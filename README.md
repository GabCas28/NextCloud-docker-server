# Nextcloud + Maria DB + OpenLDAP

This project can be run using the following command from the root folder:

```{}
docker-compose up
```

It requires docker engine installed and running.

## About NextCloud

Some of the apps from NextCloud are disabled, like:

```{}
accessibility, dashboard, accessibility, firstrunwizard, nextcloud_announcements, photos,weather_status, user_status, survey_client, support, recommendations and updatenotification.
```

This configuration can be changed from the file: `./nextcloud/docker-settings.sh`

As for the connection settings, they are all set at the `.env` file. This file also includes configuration for database.

## About OpenLDAP

THe dockerFile has been copied from  [Larry Cai's proyect](https://github.com/larrycai/docker-openldap).

It includes a default user (gabcas28) added and it can be changed from the file `./openldap/files/more.ldif`

## References and resources

[LDAP configuration in Nextcloud](https://docs.nextcloud.com/server/21/admin_manual/configuration_user/user_auth_ldap.html?highlight=ldap)

[LDAP configuration keys](https://docs.nextcloud.com/server/13.0.0/admin_manual/configuration_user/user_auth_ldap_api.html#creating-a-configuration)

[Larry Cai's docker-openldap](https://github.com/larrycai/docker-openldap)

[Manuel Parra's docler_ldap](https://github.com/manuparra/docker_ldap)

[Nginx Load Balancing and using with Docker](https://levelup.gitconnected.com/nginx-load-balancing-and-using-with-docker-7e16c49f5d9)

[nextcloud/docker/nginx.conf](https://github.com/nextcloud/docker/blob/master/.examples/docker-compose/with-nginx-proxy/mariadb/fpm/web/nginx.conf)

[nextclod/docker/README.md](https://github.com/nextcloud/docker)