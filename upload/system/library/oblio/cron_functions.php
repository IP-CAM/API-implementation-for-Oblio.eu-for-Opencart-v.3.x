<?php

function oblio_chdir($current_dir) {
    $root_dir = dirname(dirname(dirname($current_dir))) . '/admin';
    chdir($root_dir);

    return $root_dir;
}

function oblio_define_route() {
    define('OBLIO_CRON_ROUTE', 'extension/module/oblio/cron');

    $_GET['route'] = OBLIO_CRON_ROUTE;
}

function oblio_init($current_dir) {
    global $argc, $argv;

    // Set up default server vars
    $_SERVER['HTTP_HOST'] = 'localhost';
    $_SERVER['SERVER_NAME'] = 'localhost';
    $_SERVER['SERVER_PORT'] = 80;
    $_SERVER['SERVER_PROTOCOL'] = 'HTTP/1.1';

    putenv('SERVER_NAME=' . $_SERVER['SERVER_NAME']);

    // Change root dir
    $root_dir = oblio_chdir($current_dir);

    oblio_define_route();

    // Version
    define('VERSION', '3.0.3.2');

    // Configuration
    if (is_file('config.php')) {
        require_once('config.php');
    }

    // Install
    if (!defined('DIR_APPLICATION')) {
        exit('DIR_APPLICATION not defined');
    }

    // Startup
    require_once(DIR_SYSTEM . 'startup.php');

    start('oblio');
}