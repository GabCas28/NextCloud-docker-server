#!/bin/sh
set -eu

run_as() {
    if [ "$(id -u)" = 0 ]; then
        su -p www-data -s /bin/sh -c "$1"
    else
        sh -c "$1"
    fi
}

echo "checking for LDAP configuration"

if [ -z ${NEXTCLOUD_LDAP_HOST} ] || [ -z ${NEXTCLOUD_LDAP_AGENT_NAME} ]; then
    echo "No LDAP set"
else
    echo "enabling ldap…"
    run_as "php /var/www/html/occ app:enable user_ldap"

    echo "setting up ldap…"

    run_as "php /var/www/html/occ ldap:show-config s01"

    if [ $? -eq 0 ]; then
        echo OK
    else
        echo FAIL
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
