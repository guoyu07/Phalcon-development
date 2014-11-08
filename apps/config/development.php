<?php
// Override production configs for development environment

return [

    // Configure database driver

    'database' =>   [
        'adapter'       => 'Mysql',     // Mysql, Postgres, Sqlite
        'username'      => 'root',
        'password'      => 'root',
        'dbname'        => 'phalcon.local',
        'charset'       => 'utf8',
        'port'          => 3306,
        'persistent'    => true,
        'profiler'	    => true,
        'debug'	        => PDO::ERRMODE_EXCEPTION,
    ],

    // Configure backend and frontend data caching

    'cache'     =>  [
        'enable'        =>  false,
        'metadata'      =>  false,
        'annotations'   =>  false,

        'memcached' => [
            'host'          => '127.0.0.1',
            'port'          => 11211,
            'persistent'    => false,
        ],
    ],

    // Log configuration

    'logger'    =>  [
		'enable'    =>  true,
		'file'    	=>  APP_PATH.'/logs',
        'format'    => '[%date%][%type%] %message%',
    ],

    // Mailing and subscribe configuration

    'mail' => [
        'fromName'  => 'Stanislav WEB',
        'fromEmail' => 'stanisov@gmail.com',
        'smtp' => [
            'server'   => 'smtp.gmail.com',
            'port'     => 587,
            'security' => 'tls',
            'username' => 'stanisov@gmail.com',
            'password' => 'QWERTY!@#$%^&*()',
        ],
    ],
];