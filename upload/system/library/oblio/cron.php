<?php

$oblio_dir = dirname(__FILE__);

require_once $oblio_dir . DIRECTORY_SEPARATOR . 'cron_functions.php';

if ($index = oblio_init($oblio_dir)) {
    require_once $index;
}