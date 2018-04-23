use YAML::Syck;

my $menu_data1 = {
    'name' => 'testdirmenu',
    'type' => 'dir',
    'direcotry' => './config/test/',
    'ext'  => '*',
    'command' => 'cat [[filename]]'
};

my $menu_data2 = {
    'name' => 'testcmdmenu',
    'label' => 'Test Menu',
    'items' => [        
        { 'type' => 'command', 'label' => 'Item 1', 'command' => 'df -h' },
        { 'type' => 'command', 'label' => 'Item 2', 'command' => 'ls /etc/' },
        { 'type' => 'event',   'label' => 'Item 3', 'event' => 'MENU_QUIT'},
        { 'type' => 'dir', 'dir' => 'config/test', 'mask' => '*', 'command' => 'cat |file|' }
    ]
};

my $menu_data3 = [ $menu_data1, $menu_data2 ];

my $menu_data4 = { 'one' => $menu_data1, 'two' => $menu_data2 };
    
print Dump($menu_data2);

