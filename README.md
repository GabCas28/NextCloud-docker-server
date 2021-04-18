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