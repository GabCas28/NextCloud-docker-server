#!/bin/sh
set -eu

run_as() {
    if [ "$(id -u)" = 0 ]; then
        su -p www-data -s /bin/sh -c "$1"
    else
        sh -c "$1"
    fi
}

echo "checking for Nextcloud configuration"
if [ run_as "php /var/www/html/occ maintenance:install \
                --database 'mysql' \
                --database-host '${MYSQL_HOST}'  \
                --database-name '${MYSQL_DATABASE}'  \
                --database-user '${MYSQL_USER}' \
                --database-pass '${MYSQL_PASSWORD}' \
                --admin-user '${MYSQL_ROOT_USER}' \
                --admin-pass '${MYSQL_ROOT_PASSWORD}'" ] || [ echo "Hello" ]; then
                
    echo "Nextcloud already Installed"
fi

echo "checking for LDAP configuration"


if [ -z ${NEXTCLOUD_LDAP_HOST} ] || [ -z ${NEXTCLOUD_LDAP_AGENT_NAME} ]; then
    echo "No LDAP set"
else
    echo "enabling ldap…"

    run_as "php /var/www/html/occ app:enable user_ldap"

    echo "setting up ldap…"

    string=$(run_as "php /var/www/html/occ ldap:show-config")
    found=$(echo $string  | grep 's01' -c)

    if [ $found -gt 0 ]; then
        echo "FOUND OK"
    else
        echo "CREATING NEW CONFIG"
        run_as "php /var/www/html/occ ldap:create-empty-config"
    fi
    
    run_as "php /var/www/html/occ ldap:set-config s01 ldapHost \"${NEXTCLOUD_LDAP_HOST}\""
    run_as "php /var/www/html/occ ldap:set-config s01 ldapPort \"${NEXTCLOUD_LDAP_PORT}\""
    run_as "php /var/www/html/occ ldap:set-config s01 ldapBase \"${NEXTCLOUD_LDAP_BASE}\""
    run_as "php /var/www/html/occ ldap:set-config s01 ldapBaseUsers \"${NEXTCLOUD_LDAP_BASE_USERS}\""
    run_as "php /var/www/html/occ ldap:set-config s01 ldapAgentName \"${NEXTCLOUD_LDAP_AGENT_NAME}\""
    run_as "php /var/www/html/occ ldap:set-config s01 ldapAgentPassword \"${NEXTCLOUD_LDAP_AGENT_PASSWORD}\""
    run_as "php /var/www/html/occ ldap:set-config s01 ldapTLS 0"
    run_as "php /var/www/html/occ ldap:set-config s01 ldapUserFilter \"(|(objectclass=inetOrgPerson))\""
    run_as "php /var/www/html/occ ldap:set-config s01 ldapLoginFilter \"(&(objectClass=inetOrgPerson)(uid=%uid))\""
    run_as "php /var/www/html/occ ldap:set-config s01 ldapAttributesForUserSearch \"uid;sn;givenname\""
    
    echo "Attributes set"

    
    echo "Disabling features..."
    run_as "php /var/www/html/occ app:disable accessibility dashboard accessibility firstrunwizard nextcloud_announcements photos weather_status user_status survey_client support recommendations updatenotification"

    echo "Features disabled"
fi
