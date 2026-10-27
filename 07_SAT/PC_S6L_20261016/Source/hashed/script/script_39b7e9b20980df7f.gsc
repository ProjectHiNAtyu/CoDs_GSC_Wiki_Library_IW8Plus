// script_39b7e9b20980df7f  (hash_39b7e9b20980df7f.gscc) (size: 17908 Bytes / 0x45f4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7bc59567 (2076546407)
// size ...... 17908 (0x45f4)
// includes .. 13  (offset: 0x40cc)
// strings ... 45  (offset: 0x4134)
// dev strs .. 31  (offset: 0x4430)
// exports ... 57  (offset: 0x283c)
// cseg ...... 0x383 + 0x24b9 (0x283c)
// imports ... 124 (offset: 0x3124)
// animtree1 . 0   (offset: 0x45f4)
// animtree2 . 0   (offset: 0x45f4)
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\teams;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace namespace_a6ce4971a4938f1d;

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x5
// Checksum 0xa990bbba, Offset: 0x3a1
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mtc_security_booth", #"br_map_quest", &pre_main, undefined );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0
// Checksum 0xecf19362, Offset: 0x3ca
// Size: 0x7a
function pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"mtc_security_booth" };
    br_map_quest::register( quest );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0
// Checksum 0x3b1a9c12, Offset: 0x44c
// Size: 0x21
function on_init()
{
    function_970d564ac5226b2e();
    function_1a00a5a2ba836d4d();
    register_callbacks();
    
    /#
        debug_init();
    #/
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0
// Checksum 0x6606b4ea, Offset: 0x475
// Size: 0x2
function on_precache()
{
    
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0
// Checksum 0xb0046555, Offset: 0x47f
// Size: 0x10
function on_start()
{
    thread init_puzzle();
    mop_block();
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0
// Checksum 0x5b3b115a, Offset: 0x497
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0
// Checksum 0xbd76b473, Offset: 0x4a1
// Size: 0x10
function on_infil()
{
    thread computers_enable();
    mop_unblock();
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0
// Checksum 0xbe83255b, Offset: 0x4b9
// Size: 0x1e
function on_disabled()
{
    getentitylessscriptablearray( "sb_door", "targetname" )[ 0 ] scriptabledoorfreeze();
    mop_block();
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0
// Checksum 0x7f353025, Offset: 0x4df
// Size: 0x35
function register_callbacks()
{
    scriptable::scriptable_addusedcallbackbypart( "quest_wz_security_booth_keypad", &function_97031bb6c42348b4 );
    scriptable::scriptable_addusedcallbackbypart( "quest_wz_security_booth_computer_interact", &on_computer_used );
    scriptable::scriptable_addusedcallbackbypart( "quest_wz_security_booth_admin_interact", &function_5770526c922750d5 );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0xef9b153b, Offset: 0x51c
// Size: 0x23
function private function_970d564ac5226b2e()
{
    setdvar( @"ui_bunker_keypad_active", 1 );
    br_map_quest::add_setting( "cache_loot_zone", "wz_sat_resurgence_zone_global" );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0xa8bd412f, Offset: 0x547
// Size: 0x123
function private function_1a00a5a2ba836d4d()
{
    self.door = getentitylessscriptablearray( "sb_door", "targetname" )[ 0 ];
    assert( self.door, "<dev string:x24>" + "<dev string:x59>" );
    self.keypad_loc = utility::getstruct( "quest_wz_security_booth_keypad", "targetname" );
    assert( self.keypad_loc, "<dev string:x24>" + "<dev string:x69>" );
    self.var_fc5148fde1ddc555 = utility::getstructarray( "sb_computer" );
    assert( self.var_fc5148fde1ddc555.size );
    self.server_locs = utility::getstructarray( "sb_server" );
    assert( self.server_locs.size );
    self.admin_loc = utility::getstruct( "sb_admin" );
    assert( isdefined( self.admin_loc ) );
    self.reward_cache_locs = utility::getstructarray( "sb_cache" );
    assert( self.reward_cache_locs.size, "<dev string:x24>" + "<dev string:x82>" );
    self.var_ca7594b1e544cd09 = utility::getstructarray( "security_booth_staged_loot" );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x5e098c7b, Offset: 0x672
// Size: 0x47
function private init_puzzle()
{
    level utility::flag_wait( "scriptables_ready" );
    setup_computers();
    setup_servers();
    setup_admin();
    function_bbc8034012e9c16c();
    setup_caches();
    spawn_staged_loot();
    self.door scriptabledoorfreeze();
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x73fee615, Offset: 0x6c1
// Size: 0xe9
function private function_ec0091d115070446()
{
    utility::flag_wait( "scriptables_ready" );
    self.enabled_computers = arrayrandomize( self.enabled_computers );
    self.computer_order = [];
    
    foreach ( computer in self.enabled_computers )
    {
        self.computer_order[ self.computer_order.size ] = computer.script_int;
    }
    
    self.var_ad954ccdf490691b = 0;
    server_lights_on( self.computer_order[ self.var_ad954ccdf490691b ] );
    function_24a9a44c2da6f49f();
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0
// Checksum 0x62d379b9, Offset: 0x7b2
// Size: 0x6b
function function_24a9a44c2da6f49f()
{
    self.admin_code = "";
    
    for ( i = 0; i < 6 ; i++ )
    {
        self.admin_code += string( randomint( 10 ) );
    }
    
    self.keypad.code[ "string" ] = self.admin_code;
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0xfda80296, Offset: 0x825
// Size: 0x69
function private setup_servers()
{
    self.server_panel = getentitylessscriptablearray( "server_panel", "script_noteworthy" )[ 0 ];
    self.server_panel setscriptablepartstate( "model", "visible" );
    
    /#
        if ( getdvarint( @"hash_bf029eaf39441622" ) )
        {
            debug::sphere( self.server_panel.origin, 50, undefined, undefined, "<dev string:x9b>" );
        }
    #/
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0xdf85ded5, Offset: 0x896
// Size: 0x1c0
function private setup_computers()
{
    self.computers = [];
    
    foreach ( css in self.var_fc5148fde1ddc555 )
    {
        computer = spawnscriptable( "quest_wz_security_booth_computer_interact", css.origin, css.angles );
        computer.script_int = int( int( css.script_int ) - 1 );
        self.computers[ self.computers.size ] = computer;
    }
    
    while ( self.var_e1b5456a99f18e25.size )
    {
        self.var_e1b5456a99f18e25[ 0 ] = undefined;
    }
    
    self.var_e1b5456a99f18e25 = undefined;
    self.computers = function_7243d45b5d82f431( self.computers, #script_int, 0 );
    var_d7807aa51efbece5 = getentitylessscriptablearray( "scriptable_quest_wz_security_booth_monitor", "classname" );
    
    foreach ( computer in self.computers )
    {
        computer.var_82e30c4150fe2cf4 = function_628bac9faa9d1e86( var_d7807aa51efbece5, computer.origin )[ 0 ];
    }
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x48a52fae, Offset: 0xa5e
// Size: 0x8d
function private setup_admin()
{
    admin = spawnscriptable( "quest_wz_security_booth_admin_interact", self.admin_loc.origin, self.admin_loc.angles );
    self.admin_computer = admin;
    self.admin_computer interaction::set_interact_hint_callback( &function_3f9d82dea5bbd0bc );
    
    /#
        if ( getdvarint( @"hash_bf029eaf39441622" ) )
        {
            debug::sphere( self.admin_computer, 50, "<dev string:xbb>", undefined, "<dev string:x9b>" );
        }
    #/
}

// Namespace namespace_a6ce4971a4938f1d
// Params 2, eflags: 0x4
// Checksum 0x8b352bcc, Offset: 0xaf3
// Size: 0xfb
function private function_3f9d82dea5bbd0bc( usable, player )
{
    if ( !isdefined( player ) )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    quest = br_map_quest::get_quest( "mtc_security_booth" );
    
    if ( quest.var_ef702ec7f3535e53 )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( isdefined( quest.var_83532a15a03c91f1 ) )
    {
        return { #params:[ int( quest.var_83532a15a03c91f1 ) ], #string:&"mp_saw_manticore/admin_code_expires_in", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"mp_saw_manticore/admin_generate_code", #type:"HINT_BUTTON" };
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x88cb48cb, Offset: 0xbf6
// Size: 0x314
function private computers_enable()
{
    foreach ( computer in self.computers )
    {
        computer computer_disable();
    }
    
    self.enabled_computers = [];
    
    if ( utility::cointoss() )
    {
        self.enabled_computers[ self.enabled_computers.size ] = self.computers[ 0 ];
    }
    else
    {
        self.enabled_computers[ self.enabled_computers.size ] = self.computers[ 1 ];
    }
    
    if ( utility::cointoss() )
    {
        self.enabled_computers[ self.enabled_computers.size ] = self.computers[ 2 ];
    }
    else
    {
        self.enabled_computers[ self.enabled_computers.size ] = self.computers[ 3 ];
    }
    
    if ( utility::cointoss() )
    {
        self.enabled_computers[ self.enabled_computers.size ] = self.computers[ 4 ];
    }
    else
    {
        self.enabled_computers[ self.enabled_computers.size ] = self.computers[ 5 ];
    }
    
    if ( utility::cointoss() )
    {
        self.enabled_computers[ self.enabled_computers.size ] = self.computers[ 6 ];
    }
    
    if ( utility::cointoss() )
    {
        self.enabled_computers[ self.enabled_computers.size ] = self.computers[ 7 ];
    }
    else
    {
        self.enabled_computers[ self.enabled_computers.size ] = self.computers[ 8 ];
    }
    
    if ( utility::cointoss() )
    {
        self.enabled_computers[ self.enabled_computers.size ] = self.computers[ 9 ];
    }
    else
    {
        self.enabled_computers[ self.enabled_computers.size ] = self.computers[ 10 ];
    }
    
    assert( self.enabled_computers.size >= 3 );
    
    while ( self.enabled_computers.size > 3 )
    {
        self.enabled_computers = arrayremove( self.enabled_computers, self.enabled_computers[ 0 ] );
    }
    
    foreach ( computer in self.enabled_computers )
    {
        computer thread computer_enable();
    }
    
    function_ec0091d115070446();
    
    /#
        if ( getdvarint( @"hash_bf029eaf39441622" ) )
        {
            function_76f937b31ce78b2c();
            function_b2a43f0df597e5da();
        }
    #/
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x9c3587e7, Offset: 0xf12
// Size: 0x3c
function private computer_enable()
{
    computer_booting();
    wait 3;
    self setscriptablepartstate( "quest_wz_security_booth_computer_interact", "usable" );
    self.var_82e30c4150fe2cf4 setscriptablepartstate( #"base", #"idle" );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x56ac85c4, Offset: 0xf56
// Size: 0x32
function private computer_booting()
{
    self setscriptablepartstate( "quest_wz_security_booth_computer_interact", "disabled" );
    self.var_82e30c4150fe2cf4 setscriptablepartstate( #"base", #"booting" );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x6c2b41f2, Offset: 0xf90
// Size: 0x7b
function private computers_disable()
{
    foreach ( computer in self.computers )
    {
        computer computer_disable();
    }
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x9cc368e3, Offset: 0x1013
// Size: 0x32
function private computer_disable()
{
    self setscriptablepartstate( "quest_wz_security_booth_computer_interact", "disabled" );
    self.var_82e30c4150fe2cf4 setscriptablepartstate( #"base", #"off" );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0
// Checksum 0xd9407b, Offset: 0x104d
// Size: 0x7b
function function_493d6f9e42a41c18()
{
    foreach ( computer in self.computers )
    {
        computer function_7bfa74404cfdcacd();
    }
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x68302e66, Offset: 0x10d0
// Size: 0x32
function private function_7bfa74404cfdcacd()
{
    self setscriptablepartstate( "quest_wz_security_booth_computer_interact", "disabled" );
    self.var_82e30c4150fe2cf4 setscriptablepartstate( #"base", #"off_with_sfx" );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x3ba6ecd, Offset: 0x110a
// Size: 0x32
function private computer_clean()
{
    self setscriptablepartstate( "quest_wz_security_booth_computer_interact", "disabled" );
    self.var_82e30c4150fe2cf4 setscriptablepartstate( #"base", #"clean" );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0xae3e1685, Offset: 0x1144
// Size: 0xaf
function private computer_infected()
{
    foreach ( computer in br_map_quest::get_quest( "mtc_security_booth" ).computers )
    {
        computer setscriptablepartstate( "quest_wz_security_booth_computer_interact", "disabled" );
    }
    
    self.var_82e30c4150fe2cf4 setscriptablepartstate( #"base", #"infected" );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 6, eflags: 0x4
// Checksum 0xeb18a987, Offset: 0x11fb
// Size: 0x100
function private on_computer_used( instance, part, state, player, bautouse, usestring )
{
    quest = br_map_quest::get_quest( "mtc_security_booth" );
    
    if ( quest.var_ad954ccdf490691b == 2 )
    {
        quest thread on_all_computer_used( instance );
        return;
    }
    
    if ( instance.script_int == quest.computer_order[ quest.var_ad954ccdf490691b ] )
    {
        instance computer_clean();
        quest.var_ad954ccdf490691b++;
        var_ad954ccdf490691b = quest.computer_order[ quest.var_ad954ccdf490691b ];
        quest server_lights_on( var_ad954ccdf490691b );
        
        /#
            if ( getdvarint( @"hash_bf029eaf39441622" ) )
            {
                function_76f937b31ce78b2c();
                function_b2a43f0df597e5da();
            }
        #/
        
        return;
    }
    
    quest thread function_daeab6788fa97f79( instance );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 1
// Checksum 0x291c6f7a, Offset: 0x1303
// Size: 0x147
function on_all_computer_used( instance )
{
    instance computer_clean();
    wait 3;
    
    foreach ( computer in self.computers )
    {
        if ( computer.var_82e30c4150fe2cf4 getscriptablepartstate( #"base" ) != #"clean" )
        {
            computer computer_booting();
        }
    }
    
    server_lights_all_on();
    wait 3;
    
    foreach ( computer in self.computers )
    {
        computer computer_clean();
    }
    
    self.admin_computer setscriptablepartstate( "quest_wz_security_booth_admin_interact", "usable" );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 1
// Checksum 0x9d1e8c60, Offset: 0x1452
// Size: 0xa5
function function_daeab6788fa97f79( instance )
{
    instance computer_infected();
    wait 1;
    
    foreach ( computer in self.enabled_computers )
    {
        computer computer_infected();
    }
    
    wait 1;
    computers_disable();
    wait 1;
    computers_enable();
}

// Namespace namespace_a6ce4971a4938f1d
// Params 6, eflags: 0x4
// Checksum 0x2dee7483, Offset: 0x14ff
// Size: 0x1a0
function private function_5770526c922750d5( instance, part, state, player, bautouse, usestring )
{
    quest = br_map_quest::get_quest( "mtc_security_booth" );
    
    if ( isdefined( quest.var_ef702ec7f3535e53 ) )
    {
        return;
    }
    
    if ( isdefined( quest.var_83532a15a03c91f1 ) )
    {
        return;
    }
    
    quest.var_ef702ec7f3535e53 = 1;
    level endon( #"game_ended" );
    instance setscriptablepartstate( "sfx", "on" );
    admin_monitors = getentitylessscriptablearray( "scriptable_t10_mc_equipment_tv_01", "classname" );
    
    for ( i = 0; i < admin_monitors.size ; i++ )
    {
        foreach ( var_82e30c4150fe2cf4 in admin_monitors )
        {
            if ( int( var_82e30c4150fe2cf4.script_noteworthy ) == i )
            {
                var_82e30c4150fe2cf4 setscriptablepartstate( "screen", quest.admin_code[ int( var_82e30c4150fe2cf4.script_noteworthy ) ] );
            }
        }
        
        wait 1;
    }
    
    quest thread function_83532a15a03c91f1();
    quest.keypad setscriptablepartstate( "quest_wz_security_booth_keypad", "on_model" );
    quest.var_ef702ec7f3535e53 = undefined;
}

// Namespace namespace_a6ce4971a4938f1d
// Params 1, eflags: 0x4
// Checksum 0xa0be477, Offset: 0x16a7
// Size: 0xe2
function private server_lights_on( var_f5039fe3e314f60e )
{
    server_lights_all_off();
    waitframe();
    
    foreach ( computer in self.enabled_computers )
    {
        if ( computer.script_int == var_f5039fe3e314f60e )
        {
            self.server_panel setscriptablepartstate( string( computer.script_int + 1 ), "red" );
            continue;
        }
        
        self.server_panel setscriptablepartstate( string( computer.script_int + 1 ), "green" );
    }
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x3b1c5a8f, Offset: 0x1791
// Size: 0x60
function private server_lights_all_on()
{
    for ( i = 0; i < self.computers.size ; i++ )
    {
        if ( self.server_panel getscriptablepartstate( string( i + 1 ) ) != "green" )
        {
            self.server_panel setscriptablepartstate( string( i + 1 ), "green" );
        }
    }
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0xff01d51f, Offset: 0x17f9
// Size: 0x41
function private server_lights_all_off()
{
    for ( i = 0; i < self.computers.size ; i++ )
    {
        self.server_panel setscriptablepartstate( string( i + 1 ), "off" );
    }
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x8ff93f83, Offset: 0x1842
// Size: 0x123
function private function_83532a15a03c91f1()
{
    level endon( #"sb_unlocked" );
    self.var_83532a15a03c91f1 = 90;
    
    while ( self.var_83532a15a03c91f1 > 0 )
    {
        wait level.framedurationseconds;
        self.var_83532a15a03c91f1 -= level.framedurationseconds;
    }
    
    self.var_83532a15a03c91f1 = undefined;
    self.admin_computer setscriptablepartstate( "sfx", "off" );
    self.keypad setscriptablepartstate( "quest_wz_security_booth_keypad", "off_model" );
    admin_monitors = getentitylessscriptablearray( "scriptable_t10_mc_equipment_tv_01", "classname" );
    
    foreach ( var_82e30c4150fe2cf4 in admin_monitors )
    {
        var_82e30c4150fe2cf4 setscriptablepartstate( "screen", "off" );
    }
    
    function_24a9a44c2da6f49f();
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x50d142bf, Offset: 0x196d
// Size: 0x9c
function private mop_block()
{
    foreach ( e in getentarray( "security_booth_mop", "targetname" ) )
    {
        e.origin += ( -21, -70, 0 );
    }
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x23af6eb9, Offset: 0x1a11
// Size: 0x9c
function private mop_unblock()
{
    foreach ( e in getentarray( "security_booth_mop", "targetname" ) )
    {
        e.origin -= ( -21, -70, 0 );
    }
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x636c106, Offset: 0x1ab5
// Size: 0x115
function private function_bbc8034012e9c16c()
{
    self.keypad = spawnscriptable( "quest_wz_security_booth_keypad", self.keypad_loc.origin, self.keypad_loc.angles );
    self.keypad.backwallkeypad = 1;
    self.keypad.script_codelength = 6;
    self.keypad.code[ "string" ] = self.admin_code;
    self.keypad.successfunction = &function_561e78789b4d65a6;
    self.keypad.var_f026366dba547f4c = 1;
    self.keypad.quest = self;
    self.keypad setscriptablepartstate( "quest_wz_security_booth_keypad", "off_model" );
    
    /#
        if ( getdvarint( @"hash_bf029eaf39441622" ) )
        {
            debug::sphere( self.keypad, 50, "<dev string:xc0>", undefined, "<dev string:x9b>" );
        }
    #/
}

// Namespace namespace_a6ce4971a4938f1d
// Params 6, eflags: 0x4
// Checksum 0x6fa4767, Offset: 0x1bd2
// Size: 0x70
function private function_97031bb6c42348b4( instance, part, state, player, bautouse, usestring )
{
    quest = br_map_quest::get_quest( "mtc_security_booth" );
    
    if ( instance.quest == quest )
    {
        level thread keypad_use( instance, part, state, player, bautouse );
    }
}

// Namespace namespace_a6ce4971a4938f1d
// Params 5, eflags: 0x4
// Checksum 0x6e70ef0e, Offset: 0x1c4a
// Size: 0x9b
function private keypad_use( instance, part, state, player, bautouse )
{
    quest = br_map_quest::get_quest( "mtc_security_booth" );
    instance setscriptablepartstate( part, "off_model" );
    player br_bunker_utility::keypad_playerinteractwithkeypadloop( instance );
    
    if ( isdefined( player ) )
    {
        player br_keypad_util::playersetkeypadstateindex( 0 );
    }
    
    if ( !quest.is_completed )
    {
        instance setscriptablepartstate( part, "on_model" );
        return;
    }
    
    instance.completed = 1;
}

// Namespace namespace_a6ce4971a4938f1d
// Params 1, eflags: 0x4
// Checksum 0x204079d9, Offset: 0x1ced
// Size: 0x212
function private function_561e78789b4d65a6( keypad )
{
    level endon( #"game_ended" );
    level notify( #"sb_unlocked" );
    keypad setscriptablepartstate( "quest_wz_security_booth_keypad", "off_model" );
    admin_monitors = getentitylessscriptablearray( "scriptable_t10_mc_equipment_tv_01", "classname" );
    
    foreach ( var_82e30c4150fe2cf4 in admin_monitors )
    {
        var_82e30c4150fe2cf4 setscriptablepartstate( "screen", "off" );
    }
    
    quest = br_map_quest::get_quest( "mtc_security_booth" );
    quest.admin_computer freescriptable();
    v_unlock = keypad.origin;
    v_unlock += anglestoforward( keypad.angles ) * ( 1, -10, -11 )[ 0 ];
    v_unlock += anglestoright( keypad.angles ) * ( 1, -10, -11 )[ 1 ];
    v_unlock += ( 0, 0, ( 1, -10, -11 )[ 2 ] );
    unlock = spawnscriptable( "quest_wz_security_booth_unlock", v_unlock );
    wait 1.5;
    unlock freescriptable();
    quest.door scriptabledoorunlock();
    quest.door scriptabledooropen( "away", self.origin );
    params = { #completed_by:teams::getteamdata( self.team, "players" ), #is_successful:1 };
    quest br_map_quest::on_completed( params );
    quest function_493d6f9e42a41c18();
    quest server_lights_all_off();
    challenges::function_37e945722d6497f3( self, "manticore_sq_security_booth", 1, 1 );
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0x24dee3eb, Offset: 0x1f07
// Size: 0xf4
function private setup_caches()
{
    quest = br_map_quest::get_quest( "mtc_security_booth" );
    loot_zone = br_map_quest::get_setting( "cache_loot_zone" );
    
    foreach ( loc in quest.reward_cache_locs )
    {
        var_1135b81b40c4ece1 = loc.script_noteworthy == "lege" ? "br_loot_cache_lege" : "br_reusable_loot_cache";
        script_cache = common_cache::function_9bc018c1b8aad720( var_1135b81b40c4ece1, loc.origin, loc.angles, undefined, loot_zone );
    }
}

// Namespace namespace_a6ce4971a4938f1d
// Params 0, eflags: 0x4
// Checksum 0xbfa7093a, Offset: 0x2003
// Size: 0xf1
function private spawn_staged_loot()
{
    quest = br_map_quest::get_quest( "mtc_security_booth" );
    
    foreach ( s in quest.var_ca7594b1e544cd09 )
    {
        item_bundle = getscriptbundle( "itemspawnentry:" + s.script_noteworthy );
        spawnoptions = common_item::function_bc5ff2958b71a708( s.origin, s.angles );
        spawnoptions.critical = 1;
        scriptable = common_item::function_61c2c0251e742ffd( item_bundle, undefined, spawnoptions );
    }
}

/#

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0
    // Checksum 0x6ff53d93, Offset: 0x20fc
    // Size: 0x5, Type: dev
    function function_281fd8b149568957()
    {
        
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0x46153ede, Offset: 0x2109
    // Size: 0x11d, Type: dev
    function private debug_init()
    {
        utility::function_95db22f620602461( @"hash_bf029eaf39441622", &function_2f484a43c549cdef );
        quest = br_map_quest::get_quest( "<dev string:xc7>" );
        quest.draw_debug = 0;
        devgui::function_9082edeb5db93280( "<dev string:xda>" + level.mapname + "<dev string:xe9>" + "<dev string:xc7>" + "<dev string:xe9>" );
        devgui::add_devgui_func( "<dev string:xeb>", "<dev string:x107>", &function_6a88503f559a28ba );
        devgui::add_devgui_func( "<dev string:x123>", "<dev string:x133>", &debug_activate_keypad );
        devgui::add_devgui_func( "<dev string:x146>", "<dev string:x159>", &function_ab586ab9ab31b017 );
        devgui::add_devgui_func( "<dev string:x16f>", "<dev string:x186>", &function_36a88b64c1ad542 );
        devgui::add_devgui_func( "<dev string:x1a0>", "<dev string:x1b2>", &function_4855123ea16cbeb );
        devgui::add_devgui_func( "<dev string:x1c7>", "<dev string:x1da>", &function_2dfaed8d00f1ad24 );
        devgui::add_devgui_func( "<dev string:x1f0>", "<dev string:x208>", &function_878b3b7e0090d059 );
        devgui::add_devgui_func( "<dev string:x223>", "<dev string:x239>", &function_de39d0f208a63ac0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0xea562fd0, Offset: 0x222e
    // Size: 0x5c, Type: dev
    function private function_6a88503f559a28ba()
    {
        if ( !getdvarint( @"hash_bf029eaf39441622" ) )
        {
            setdvar( @"hash_bf029eaf39441622", 1 );
            iprintlnbold( "<dev string:x252>" );
            level thread function_b2a43f0df597e5da();
            return;
        }
        
        setdvar( @"hash_bf029eaf39441622", 0 );
        iprintlnbold( "<dev string:x9b>" );
        level thread function_76f937b31ce78b2c();
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0x4290c9fb, Offset: 0x2292
    // Size: 0xd, Type: dev
    function private function_2f484a43c549cdef()
    {
        level thread function_b2a43f0df597e5da();
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0x4771f9eb, Offset: 0x22a7
    // Size: 0x1f4, Type: dev
    function private function_b2a43f0df597e5da()
    {
        level endon( #"game_ended" );
        
        for ( quest = br_map_quest::get_quest( "<dev string:xc7>" ); !isdefined( quest ) ; quest = br_map_quest::get_quest( "<dev string:xc7>" ) )
        {
            waitframe();
        }
        
        while ( !quest.computers.size )
        {
            waitframe();
        }
        
        foreach ( loc in quest.server_locs )
        {
            debug::sphere( loc.origin, 50, undefined, undefined, "<dev string:x9b>" );
        }
        
        foreach ( computer in quest.computers )
        {
            if ( computer.script_int == quest.computer_order[ quest.var_ad954ccdf490691b ] )
            {
                debug::print3d( computer, computer.script_int, "<dev string:x271>", undefined, "<dev string:x9b>" );
                continue;
            }
            
            debug::print3d( computer, computer.script_int, "<dev string:x275>", undefined, "<dev string:x9b>" );
        }
        
        debug::sphere( quest.admin_computer, 50, "<dev string:xbb>", undefined, "<dev string:x9b>" );
        debug::sphere( quest.keypad, 50, "<dev string:xc0>", undefined, "<dev string:x9b>" );
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0xd839cc98, Offset: 0x24a3
    // Size: 0x11, Type: dev
    function private function_76f937b31ce78b2c()
    {
        level notify( #"hash_8fea1b21bfd10495" );
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0xf5f3a9c5, Offset: 0x24bc
    // Size: 0x36, Type: dev
    function private debug_activate_keypad()
    {
        quest = br_map_quest::get_quest( "<dev string:xc7>" );
        quest.keypad setscriptablepartstate( "<dev string:x27b>", "<dev string:x29a>" );
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0xaa164f2a, Offset: 0x24fa
    // Size: 0x3f, Type: dev
    function private function_ab586ab9ab31b017()
    {
        level.player setorigin( ( 10663, 2305, 840 ), 1 );
        level.player setplayerangles( ( 0, 118, 0 ), 1 );
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0x37bf2a6, Offset: 0x2541
    // Size: 0x15b, Type: dev
    function private function_36a88b64c1ad542()
    {
        quest = br_map_quest::get_quest( "<dev string:xc7>" );
        correct_pc = undefined;
        
        foreach ( computer in quest.computers )
        {
            if ( computer.script_int == quest.computer_order[ quest.var_ad954ccdf490691b ] )
            {
                correct_pc = computer;
            }
        }
        
        origin = getgroundposition( correct_pc.var_82e30c4150fe2cf4.origin + anglestoforward( correct_pc.var_82e30c4150fe2cf4.angles ) * 50, 1 );
        angles = vectortoangles( correct_pc.var_82e30c4150fe2cf4.origin - origin + ( 0, 0, 60 ) );
        level.player setorigin( origin, 1 );
        level.player setplayerangles( angles, 1 );
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0x2e14a64f, Offset: 0x26a4
    // Size: 0x3f, Type: dev
    function private function_4855123ea16cbeb()
    {
        level.player setorigin( ( 11026, 3094, 840 ), 1 );
        level.player setplayerangles( ( 35, 30, 0 ), 1 );
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0x6a76811, Offset: 0x26eb
    // Size: 0x3f, Type: dev
    function private function_2dfaed8d00f1ad24()
    {
        level.player setorigin( ( 6146, 5195, 841 ), 1 );
        level.player setplayerangles( ( 22, 165, 0 ), 1 );
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0xc27e36e0, Offset: 0x2732
    // Size: 0xcb, Type: dev
    function private function_878b3b7e0090d059()
    {
        quest = br_map_quest::get_quest( "<dev string:xc7>" );
        correct_pc = undefined;
        
        foreach ( computer in quest.computers )
        {
            if ( computer.script_int == quest.computer_order[ quest.var_ad954ccdf490691b ] )
            {
                correct_pc = computer;
            }
        }
        
        quest thread on_all_computer_used( correct_pc );
    }

    // Namespace namespace_a6ce4971a4938f1d
    // Params 0, eflags: 0x4
    // Checksum 0xcc0c56b3, Offset: 0x2805
    // Size: 0x37, Type: dev
    function private function_de39d0f208a63ac0()
    {
        quest = br_map_quest::get_quest( "<dev string:xc7>" );
        level.player function_561e78789b4d65a6( quest.keypad );
    }

#/
