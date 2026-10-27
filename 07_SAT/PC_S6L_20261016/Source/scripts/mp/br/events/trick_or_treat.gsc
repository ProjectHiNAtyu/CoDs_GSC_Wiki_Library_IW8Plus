// scripts\mp\br\events\trick_or_treat.gsc  (hash_4f706adbb2fdf5a1.gscc) (size: 11637 Bytes / 0x2d75 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x55ddfe96 (1440611990)
// size ...... 11637 (0x2d75)
// includes .. 10  (offset: 0x2a05)
// strings ... 41  (offset: 0x2a55)
// dev strs .. 19  (offset: 0x2c8d)
// exports ... 35  (offset: 0x1ab9)
// cseg ...... 0x2cf + 0x17ea (0x1ab9)
// imports ... 80  (offset: 0x2031)
// animtree1 . 0   (offset: 0x2d75)
// animtree2 . 0   (offset: 0x2d75)
#using script_16ea1b94f0f381b3;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\flags;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;

#namespace trick_or_treat;

// Namespace trick_or_treat
// Params 0, eflags: 0x1
// Checksum 0xc05e623f, Offset: 0x2ed
// Size: 0x1d
function autoexec main()
{
    if ( !getdvarint( @"scr_trick_or_treat_enabled", 0 ) )
    {
        return;
    }
    
    level thread init();
}

// Namespace trick_or_treat
// Params 0
// Checksum 0xd57033ff, Offset: 0x312
// Size: 0x420
function init()
{
    utility::flag_wait( "scriptables_ready" );
    
    /#
        debug_init();
    #/
    
    level.trick_or_treat = spawnstruct();
    level.trick_or_treat.var_a5a13c58a64a6824 = getdvarfloat( @"hash_c334fb837fad72b3", 0.5 );
    level.trick_or_treat.var_e943750361cdb0f6 = getdvarint( @"hash_fac645b35dd753a2", 2 );
    level.trick_or_treat.var_57d4614a60e4eb28 = getdvarint( @"hash_d383f878beed21a4", 1 );
    level.trick_or_treat.var_6b58c89003e5358a = getdvarfloat( @"hash_a9a37903e0fdd7ff", 0.05 );
    level.trick_or_treat.var_51b5f7edfcec0fd1 = getdvarint( @"hash_925bb1d97ebff9f5", 1 );
    level.trick_or_treat.var_f854689cb88a6ee7 = getdvarint( @"hash_d0d17a74c46cb056", 0 );
    level.trick_or_treat.flashbang_fuse_time = getdvarfloat( @"hash_56decc38b23ed44a", 2 );
    level.trick_or_treat.frag_fuse_time = getdvarfloat( @"hash_2d42e07f0fe0b31a", 4 );
    level.trick_or_treat.gas_fuse_time = getdvarfloat( @"hash_9a686a64ca37f3f7", 2 );
    level.trick_or_treat.var_4f4ee4acfed5e813 = 0;
    level.trick_or_treat.var_1e54973bb33c75b4 = getdvarint( @"hash_2bc57dff7062eef8", 10 );
    level.trick_or_treat.i_zombie_health = getdvarint( @"scr_trick_or_treat_zombie_health", 300 );
    level.trick_or_treat.var_33ecad5ddd1374e6 = getdvarint( @"hash_7fb2424011dd5cb2", 30 );
    level.trick_or_treat.powerups = [ "double_points", "full_ammo", "full_armor", "loot_master", "zombie_legs", "zombie_vision" ];
    init_tricks();
    init_treats();
    var_f9f4a7337b681398 = get_trick_or_treat_locations();
    level.trick_or_treat.a_scriptables = [];
    
    foreach ( s in var_f9f4a7337b681398 )
    {
        scriptable = spawnscriptable( "mp_saw_trick_or_treat", s.origin );
        scriptable.angles = s.angles;
        scriptable setscriptablepartstate( "model", "visible" );
        scriptable.a_used_by = [];
        scriptable.interact = interaction::register_scriptable_interact( scriptable, &function_a159b8f7ca2a7c05 );
        scriptable.interact interaction::set_interact_hint_callback( &function_253067cc8be9663 );
        level.trick_or_treat.a_scriptables[ level.trick_or_treat.a_scriptables.size ] = scriptable;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    foreach ( scriptable in level.trick_or_treat.a_scriptables )
    {
        scriptable setscriptablepartstate( "interact", "usable" );
        scriptable setscriptablepartstate( "ping", "enabled" );
    }
}

// Namespace trick_or_treat
// Params 0
// Checksum 0xae8ce192, Offset: 0x73a
// Size: 0x1b5
function init_tricks()
{
    level.trick_or_treat.a_tricks = [];
    init_trick( "flashbang", getdvarfloat( @"hash_6bee35aa6d90e0a5", 1 ), &trick_flashbang );
    init_trick( "frag", getdvarfloat( @"hash_2ea9ae52eaf2ee3f", 1 ), &trick_frag );
    init_trick( "gas", getdvarfloat( @"hash_4ca488075e477eec", 1 ), &trick_gas );
    init_trick( "zombie", getdvarfloat( @"hash_3aa498a66f7b1351", 0 ), &trick_zombie );
    var_94c2144c53e1ccd7 = 0;
    
    foreach ( trick in level.trick_or_treat.a_tricks )
    {
        var_94c2144c53e1ccd7 += trick.weight;
    }
    
    foreach ( trick in level.trick_or_treat.a_tricks )
    {
        trick.weight_normalized = trick.weight / var_94c2144c53e1ccd7;
    }
}

// Namespace trick_or_treat
// Params 0
// Checksum 0x15f010b3, Offset: 0x8f7
// Size: 0x176
function init_treats()
{
    level.trick_or_treat.a_treats = [];
    init_treat( "loot", getdvarfloat( @"hash_84ce09aaf84ad2ae", 1 ), &function_8ede2e11b29ce2e4 );
    init_treat( "powerup", getdvarfloat( @"hash_912f1e5f95a4b3a7", 1 ), &treat_spawn_powerup );
    var_94c2144c53e1ccd7 = 0;
    
    foreach ( treat in level.trick_or_treat.a_treats )
    {
        var_94c2144c53e1ccd7 += treat.weight;
    }
    
    foreach ( treat in level.trick_or_treat.a_treats )
    {
        treat.weight_normalized = treat.weight / var_94c2144c53e1ccd7;
    }
}

// Namespace trick_or_treat
// Params 3
// Checksum 0xa21b44cb, Offset: 0xa75
// Size: 0x83
function init_trick( str_id, weight, func )
{
    trick = spawnstruct();
    trick.str_id = str_id;
    trick.weight = weight;
    trick.func = func;
    level.trick_or_treat.a_tricks[ level.trick_or_treat.a_tricks.size ] = trick;
}

// Namespace trick_or_treat
// Params 3
// Checksum 0xa21b44cb, Offset: 0xb00
// Size: 0x83
function init_treat( str_id, weight, func )
{
    treat = spawnstruct();
    treat.str_id = str_id;
    treat.weight = weight;
    treat.func = func;
    level.trick_or_treat.a_treats[ level.trick_or_treat.a_treats.size ] = treat;
}

// Namespace trick_or_treat
// Params 0
// Checksum 0x50a6116c, Offset: 0xb8b
// Size: 0x12
function get_trick_or_treat_locations()
{
    return utility::getstructarray( "trick_or_treat", "targetname" );
}

// Namespace trick_or_treat
// Params 1
// Checksum 0xa6bbc167, Offset: 0xba6
// Size: 0x26
function function_a159b8f7ca2a7c05( player )
{
    level thread trick_or_treat( player, self );
    
    /#
        self notify( #"hash_b5328e4cec9b286a" );
    #/
}

// Namespace trick_or_treat
// Params 2
// Checksum 0xff312016, Offset: 0xbd4
// Size: 0x100
function trick_or_treat( player, scriptable = undefined )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( scriptable.var_9796df19b39ca7cf ) )
    {
        scriptable.var_9796df19b39ca7cf = 0;
    }
    
    var_8d9efa13a2826cb9 = level.trick_or_treat.var_a5a13c58a64a6824 - scriptable.var_9796df19b39ca7cf * level.trick_or_treat.var_6b58c89003e5358a;
    f_roll = randomfloat( 1 );
    
    if ( f_roll < var_8d9efa13a2826cb9 )
    {
        player thread treat( scriptable );
        player thread points::doscoreevent( #"hash_59f5027d78daafb7" );
    }
    else
    {
        player thread trick( scriptable );
        player thread points::doscoreevent( #"hash_7e46b37d8de5bbf4" );
    }
    
    if ( isdefined( scriptable ) )
    {
        scriptable setscriptablepartstate( "interact", "unusable" );
        scriptable setscriptablepartstate( "ping", "disabled" );
    }
}

// Namespace trick_or_treat
// Params 2
// Checksum 0xf1159dec, Offset: 0xcdc
// Size: 0x6c
function function_253067cc8be9663( usable, player )
{
    if ( usable getscriptablepartstate( "interact" ) == "usable" )
    {
        return { #string:&"hash_6547d9f01a15f638", #type:"HINT_NOICON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace trick_or_treat
// Params 1
// Checksum 0x9c256e10, Offset: 0xd51
// Size: 0x88
function trick( scriptable )
{
    if ( isdefined( scriptable ) )
    {
        scriptable setscriptablepartstate( "sfx", "trick" );
    }
    
    trick_or_treat_roll( scriptable, level.trick_or_treat.a_tricks );
    
    if ( level.trick_or_treat.var_51b5f7edfcec0fd1 )
    {
        scriptable setscriptablepartstate( "interact", "unusable" );
        scriptable setscriptablepartstate( "ping", "disabled" );
        scriptable setscriptablepartstate( "vfx", "on" );
    }
}

// Namespace trick_or_treat
// Params 1
// Checksum 0xd009846d, Offset: 0xde1
// Size: 0xa0
function treat( scriptable )
{
    if ( isdefined( scriptable ) )
    {
        scriptable setscriptablepartstate( "sfx", "treat" );
    }
    
    trick_or_treat_roll( scriptable, level.trick_or_treat.a_treats );
    scriptable.var_9796df19b39ca7cf++;
    
    if ( scriptable.var_9796df19b39ca7cf >= level.trick_or_treat.var_57d4614a60e4eb28 )
    {
        scriptable setscriptablepartstate( "interact", "unusable" );
        scriptable setscriptablepartstate( "ping", "disabled" );
        scriptable setscriptablepartstate( "vfx", "on" );
    }
}

// Namespace trick_or_treat
// Params 2
// Checksum 0x5bd30a12, Offset: 0xe89
// Size: 0x1e8
function trick_or_treat_roll( scriptable, a_trick_or_treat )
{
    var_ebf939378de39da8 = 1;
    
    if ( level.trick_or_treat.var_f854689cb88a6ee7 && isdefined( self.trick_or_treat_last ) )
    {
        foreach ( trick_or_treat in a_trick_or_treat )
        {
            if ( trick_or_treat.str_id == self.trick_or_treat_last )
            {
                var_ebf939378de39da8 -= trick_or_treat.weight_normalized;
            }
        }
    }
    
    f_roll = randomfloat( var_ebf939378de39da8 );
    
    foreach ( trick_or_treat in a_trick_or_treat )
    {
        if ( f_roll < trick_or_treat.weight_normalized )
        {
            if ( level.trick_or_treat.var_f854689cb88a6ee7 && isdefined( self.trick_or_treat_last ) && self.trick_or_treat_last == trick_or_treat.str_id )
            {
                continue;
            }
            
            if ( level.trick_or_treat.var_f854689cb88a6ee7 )
            {
                self.trick_or_treat_last = trick_or_treat.str_id;
            }
            
            self thread [[ trick_or_treat.func ]]( scriptable );
            return;
        }
        
        f_roll -= trick_or_treat.weight_normalized;
    }
}

// Namespace trick_or_treat
// Params 1
// Checksum 0x55fe08fe, Offset: 0x1079
// Size: 0xd8
function trick_flashbang( scriptable )
{
    if ( isdefined( scriptable ) )
    {
        spawn_origin = scriptable.origin + anglestoforward( scriptable.angles ) * 12;
        launch_dir_origin = self.origin + ( 0, 0, 40 );
        velocity = vectornormalize( launch_dir_origin - spawn_origin ) * 20;
    }
    else
    {
        spawn_origin = self.origin;
        velocity = ( 0, 0, 0 );
    }
    
    grenade = magicgrenademanual( "sat_flash_grenade_wz", spawn_origin + ( 0, 0, 10 ), velocity, level.trick_or_treat.flashbang_fuse_time, self );
    grenade.team = "team_hundred_ninety_nine";
}

// Namespace trick_or_treat
// Params 1
// Checksum 0xaf17cb55, Offset: 0x1159
// Size: 0xd8
function trick_frag( scriptable )
{
    if ( isdefined( scriptable ) )
    {
        spawn_origin = scriptable.origin + anglestoforward( scriptable.angles ) * 12;
        launch_dir_origin = self.origin + ( 0, 0, 40 );
        velocity = vectornormalize( launch_dir_origin - spawn_origin ) * 20;
    }
    else
    {
        spawn_origin = self.origin;
        velocity = ( 0, 0, 0 );
    }
    
    grenade = magicgrenademanual( "sat_frag_grenade_wz", spawn_origin + ( 0, 0, 10 ), velocity, level.trick_or_treat.frag_fuse_time, self );
    grenade.team = "team_hundred_ninety_nine";
}

// Namespace trick_or_treat
// Params 1
// Checksum 0x3f815f41, Offset: 0x1239
// Size: 0xd8
function trick_gas( scriptable )
{
    if ( isdefined( scriptable ) )
    {
        spawn_origin = scriptable.origin + anglestoforward( scriptable.angles ) * 12;
        launch_dir_origin = self.origin + ( 0, 0, 40 );
        velocity = vectornormalize( launch_dir_origin - spawn_origin ) * 20;
    }
    else
    {
        spawn_origin = self.origin;
        velocity = ( 0, 0, 0 );
    }
    
    grenade = magicgrenademanual( "sat_gas_grenade_wz", spawn_origin + ( 0, 0, 10 ), velocity, level.trick_or_treat.gas_fuse_time, self );
    grenade.team = "team_hundred_ninety_nine";
}

// Namespace trick_or_treat
// Params 1
// Checksum 0x4a5eec78, Offset: 0x1319
// Size: 0x207
function trick_zombie( scriptable )
{
    origin = self.origin;
    spawnpoint = ( origin + self.origin ) / 2;
    spawnpoint = getclosestpointonnavmesh( spawnpoint );
    spawnangles = vectortoangles( ( self.origin[ 0 ], self.origin[ 1 ], 0 ) - ( origin[ 0 ], origin[ 1 ], 0 ) );
    var_5544bd57802f6974 = namespace_9d8e359c3b1041e5::get_aitype_by_subclass_sharedfunc( "zombie_base" )[ 0 ];
    
    if ( level.trick_or_treat.var_4f4ee4acfed5e813 >= level.trick_or_treat.var_1e54973bb33c75b4 )
    {
        return;
    }
    
    spawnteam = "team_hundred_ninety_nine";
    guy = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( var_5544bd57802f6974, spawnpoint, spawnangles, spawnteam );
    
    if ( isdefined( guy ) )
    {
        if ( getdvarint( @"hash_294d0bb1fe9b2abe", 0 ) == 1 )
        {
            guy.ignoreall = 1;
        }
        
        guy.health = level.trick_or_treat.i_zombie_health;
        guy.basehealth = guy.health;
        guy.maxhealth = guy.health;
        guy.b_disable_annihilate = 1;
        guy.spawntime = gettime();
        guy.lifetime = level.trick_or_treat.var_33ecad5ddd1374e6;
        guy.ignoreall = 1;
        guy.var_a8eeeeec59e70a36 = 1;
        guy.var_24954f14e27b448d = 0;
        level.trick_or_treat.var_4f4ee4acfed5e813++;
        guy thread function_100b86a579227332();
        guy thread zombie_timeout();
        guy callback::add( "on_ai_killed", &function_4172d76563dd9134 );
    }
    
    if ( isdefined( guy ) )
    {
        guy thread utility::animscriptedagent( "spawn", "spawn_end" );
    }
}

// Namespace trick_or_treat
// Params 0
// Checksum 0x56c335d7, Offset: 0x1528
// Size: 0x17
function function_100b86a579227332()
{
    wait 2;
    
    if ( isalive( self ) )
    {
        self.ignoreall = 0;
    }
}

// Namespace trick_or_treat
// Params 0
// Checksum 0xc2b53d6, Offset: 0x1547
// Size: 0x22
function zombie_timeout()
{
    wait self.lifetime;
    
    if ( isdefined( self ) )
    {
        if ( !utility::is_dead_or_dying( self ) )
        {
            self kill();
        }
    }
}

// Namespace trick_or_treat
// Params 1
// Checksum 0xeb3d99af, Offset: 0x1571
// Size: 0x20
function function_4172d76563dd9134( params )
{
    level.trick_or_treat.var_4f4ee4acfed5e813--;
}

// Namespace trick_or_treat
// Params 1
// Checksum 0xeabe32fd, Offset: 0x1599
// Size: 0x183
function function_8ede2e11b29ce2e4( scriptable )
{
    if ( isdefined( scriptable ) )
    {
        start_origin = scriptable.origin;
        end_origin = getclosestpointonnavmesh( scriptable.origin + anglestoforward( scriptable.angles ) * 25 );
        goal_angles = vectortoangles( end_origin - scriptable.origin );
    }
    else
    {
        end_origin = getclosestpointonnavmesh( self.origin + anglestoforward( self.origin ) * 25 );
        start_origin = self.origin + ( 0, 0, 40 );
        goal_angles = vectortoangles( end_origin - start_origin );
    }
    
    spawn_options = common_item::function_f5dfaa3bbdf99a33( end_origin, start_origin, goal_angles );
    spawn_options.var_9161cf0784b6951d = 0;
    items = common_item::function_38cde6a6acb68ea6( %"hash_1dc3e0624152704b", level.trick_or_treat.var_e943750361cdb0f6, spawn_options );
    
    foreach ( item in items )
    {
        logstring( "manticore_s6_trick_or_treat::item_from_lootlist: " + item.type );
    }
}

// Namespace trick_or_treat
// Params 1
// Checksum 0x2ed8544a, Offset: 0x1724
// Size: 0x95
function treat_spawn_powerup( scriptable )
{
    spawn_origin = isdefined( scriptable ) ? scriptable.origin + anglestoforward( scriptable.angles ) * 25 : self.origin;
    powerup = level.trick_or_treat.powerups[ randomint( level.trick_or_treat.powerups.size ) ];
    logstring( "manticore_s6_trick_or_treat::powerup: " + powerup );
    namespace_9d8e359c3b1041e5::droppowerupsharedfunc( powerup, spawn_origin );
}

/#

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0xb2cff251, Offset: 0x17c1
    // Size: 0x5, Type: dev
    function function_eea18adbdbb5777c()
    {
        
    }

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0xe7699a94, Offset: 0x17ce
    // Size: 0x30, Type: dev
    function debug_init()
    {
        level waittill( #"player_spawned" );
        level thread function_6c025e2cb9e2dd26();
        level thread utility::function_95db22f620602461( @"hash_cfb842b0a0b7c9de", &function_f4b20f982233434a );
    }

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0xe0ff20c8, Offset: 0x1806
    // Size: 0xb2, Type: dev
    function function_6c025e2cb9e2dd26()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x37>", "<dev string:x47>", &function_e7a7d549ceb5dcaa );
        devgui::add_devgui_func( "<dev string:x73>", "<dev string:x82>", &debug_trick_or_treat );
        devgui::add_devgui_func( "<dev string:x97>", "<dev string:xa7>", &function_270205974bd10b8a );
        devgui::add_devgui_func( "<dev string:xbd>", "<dev string:xc8>", &function_a0a4928a78a13d32 );
        devgui::add_devgui_func( "<dev string:xd9>", "<dev string:xe6>", &function_71f30ca166ac5be0 );
        devgui::add_devgui_func( "<dev string:xf9>", "<dev string:x109>", &function_d801b03c413ec529 );
        devgui::add_devgui_func( "<dev string:x125>", "<dev string:x133>", &function_8a5000eaf93a0d2d );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0xf09a802e, Offset: 0x18c0
    // Size: 0x28, Type: dev
    function function_e7a7d549ceb5dcaa()
    {
        if ( !getdvarint( @"scr_debug_trick_or_treat", 0 ) )
        {
            function_f4b20f982233434a();
            return;
        }
        
        function_56b887933696953c();
    }

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0xb6b3e8f8, Offset: 0x18f0
    // Size: 0xe8, Type: dev
    function function_f4b20f982233434a()
    {
        level endon( #"game_ended" );
        level endon( #"hash_b5328e4cec9b286a" );
        
        while ( !level.trick_or_treat.a_scriptables.size )
        {
            waitframe();
        }
        
        setdvar( @"scr_debug_trick_or_treat", 1 );
        iprintlnbold( "<dev string:x14d>" );
        
        foreach ( scriptable in level.trick_or_treat.a_scriptables )
        {
            debug::sphere( scriptable, 10, "<dev string:x178>", undefined, "<dev string:x17f>", "<dev string:x17f>" );
        }
    }

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0xe44b4033, Offset: 0x19e0
    // Size: 0x2a, Type: dev
    function function_56b887933696953c()
    {
        setdvar( @"scr_debug_trick_or_treat", 0 );
        iprintlnbold( "<dev string:x1a8>" );
        level notify( #"hash_b5328e4cec9b286a" );
    }

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0xb85c954d, Offset: 0x1a12
    // Size: 0x16, Type: dev
    function debug_trick_or_treat()
    {
        level thread trick_or_treat( level.player );
    }

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0x7a6191a5, Offset: 0x1a30
    // Size: 0x15, Type: dev
    function function_270205974bd10b8a()
    {
        level.player thread trick_flashbang();
    }

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0x711ee326, Offset: 0x1a4d
    // Size: 0x15, Type: dev
    function function_a0a4928a78a13d32()
    {
        level.player thread trick_frag();
    }

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0x7c9e6e44, Offset: 0x1a6a
    // Size: 0x15, Type: dev
    function function_71f30ca166ac5be0()
    {
        level.player thread trick_zombie();
    }

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0x47faac30, Offset: 0x1a87
    // Size: 0x15, Type: dev
    function function_d801b03c413ec529()
    {
        level.player thread function_8ede2e11b29ce2e4();
    }

    // Namespace trick_or_treat
    // Params 0
    // Checksum 0x2fb08c26, Offset: 0x1aa4
    // Size: 0x15, Type: dev
    function function_8a5000eaf93a0d2d()
    {
        level.player thread treat_spawn_powerup();
    }

#/
