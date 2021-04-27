<?php
$CONFIG = array (
  'htaccess.RewriteBase' => '/',
  'memcache.local' => '\\OC\\Memcache\\APCu',
  'apps_paths' => 
  array (
    0 => 
    array (
      'path' => '/var/www/html/apps',
      'url' => '/apps',
      'writable' => false,
    ),
    1 => 
    array (
      'path' => '/var/www/html/custom_apps',
      'url' => '/custom_apps',
      'writable' => true,
    ),
  ),
  'passwordsalt' => 'WI/iT1KIlUH5/j3rStfQ0XLJXO+KKd',
  'secret' => 'XbCA8snPjkCQyA3M7e7iy+dzRsCtiZC7hl8oZIkEZ0fkM24t',
  'trusted_domains' => 
  array (
    0 => 'localhost',
    1 => 'hadoop.ugr.es',
  ),
  'datadirectory' => '/var/www/html/data',
  'dbtype' => 'sqlite3',
  'version' => '21.0.0.18',
  'overwrite.cli.url' => 'http://localhost',
  'dbname' => 'nextcloud',
  'dbhost' => 'mariadb',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
  'installed' => true,
  'instanceid' => 'ocplbyle6yo0',
  'ldapProviderFactory' => 'OCA\\User_LDAP\\LDAPProviderFactory',
);
