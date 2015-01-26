<?php
// Default navigation list
$navigation =   [

    'top'   =>  [
        [
            'title'     =>  'Home',
            'url'       =>  '/',
            'translate' =>  'HOME',
            'isAuthenticated'    =>  'false'
        ],
        [
            'title'     =>  'Agreement',
            'url'       =>  '/agreement',
            'translate' =>  'AGREEMENT',
            'isAuthenticated'    =>  'false'
        ],
        [
            'title'     =>  'Help',
            'url'       =>  '/help',
            'translate' =>  'HELP',
            'isAuthenticated'    =>  'false'

        ],
        [
            'title'     =>  'Contacts',
            'url'       =>  '/contacts',
            'translate' =>  'CONTACTS',
            'isAuthenticated'    =>  'false'
        ],
        [
            'title'     =>  'About',
            'url'       =>  '/about',
            'translate' =>  'ABOUT',
            'isAuthenticated'    =>  'false'

        ],
        [
            'title'     =>  'Sign In',
            'url'       =>  '#',
            'translate' =>  'SIGN IN',
            'onclick'   =>  'openSplash()',
            'isAuthenticated'    =>  'false'

        ],
        [
            'title'     =>  'My Account',
            'url'       =>  '/account',
            'translate' =>  'ACCOUNT',
            'isAuthenticated'    =>  'true'
        ],
        [
            'title'     =>  'Logout',
            'url'       =>  '#',
            'translate' =>  'LOGOUT',
            'onclick'   =>  'logout()',
            'controller'=>  'SignCtrl',
            'isAuthenticated'    =>  'true'
        ],
    ],

];