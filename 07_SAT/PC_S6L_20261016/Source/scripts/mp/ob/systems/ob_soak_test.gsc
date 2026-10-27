// scripts\mp\ob\systems\ob_soak_test.gsc  (hash_3a1d89f34e6650c8.gscc) (size: 12494 Bytes / 0x30ce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5703ba40 (1459862080)
// size ...... 12494 (0x30ce)
// includes .. 7   (offset: 0x2dc6)
// strings ... 33  (offset: 0x2dfe)
// dev strs .. 25  (offset: 0x2fa2)
// exports ... 29  (offset: 0x1e92)
// cseg ...... 0x75f + 0x1733 (0x1e92)
// imports ... 86  (offset: 0x231a)
// animtree1 . 0   (offset: 0x30ce)
// animtree2 . 0   (offset: 0x30ce)
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\ob\activities\ob_activity_turret_trap;
#using scripts\mp\ob\systems\ob_activity_manager;

#namespace ob_soak_test;

// Namespace ob_soak_test
// Params 0
// Checksum 0xf25fcaec, Offset: 0x77d
// Size: 0x10
function init()
{
    _init_soak_test();
    _init_devgui();
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0x25532ec, Offset: 0x795
// Size: 0x44
function private _init_soak_test()
{
    level.var_78fcd0b2b060ac3d = spawnstruct();
    var_62206335828b48ba = getdvarint( @"enable_ob_soak_test", 0 );
    
    if ( var_62206335828b48ba )
    {
        level callback::add( #"player_connect", &on_player_connect );
    }
}

// Namespace ob_soak_test
// Params 1, eflags: 0x4
// Checksum 0x9ee85053, Offset: 0x7e1
// Size: 0x29
function private on_player_connect( params )
{
    level callback::remove( #"player_connect", &on_player_connect );
    ob_start_soak_test();
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0x58185b86, Offset: 0x812
// Size: 0xc8
function private _init_devgui()
{
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x32>", "<dev string:x42>", &toggle_ob_soak_test );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5d>", "<dev string:x6c>", &toggle_ob_soak_test );
        devgui::function_cd4e263c1f3018ae( "<dev string:x88>", "<dev string:xb1>", &toggle_ob_soak_test );
        devgui::function_cd4e263c1f3018ae( "<dev string:xdd>", "<dev string:x105>", &toggle_ob_soak_test );
        devgui::function_cd4e263c1f3018ae( "<dev string:x132>", "<dev string:x15d>", &toggle_ob_soak_test );
        devgui::function_cd4e263c1f3018ae( "<dev string:x183>", "<dev string:x1ad>", &toggle_ob_soak_test );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1d4>", "<dev string:x1f7>", &toggle_ob_soak_test );
        devgui::function_cd4e263c1f3018ae( "<dev string:x21e>", "<dev string:x240>", &toggle_ob_soak_test );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace ob_soak_test
// Params 1, eflags: 0x4
// Checksum 0xb603c35e, Offset: 0x8e2
// Size: 0x124
function private toggle_ob_soak_test( params )
{
    switch ( params[ 0 ] )
    {
        case #"hash_6caf06e2c9e6872e":
            ob_start_soak_test();
            break;
        case #"hash_c1c88ef798270243":
            ob_stop_soak_test();
            break;
        case #"hash_c264c6792dab4bb0":
            setdvar( @"hash_bef29ea4a0f46e7", 1 );
            thread function_94a1d41845788577();
            break;
        case #"hash_9b1fc617fa1ea3c9":
            setdvar( @"hash_bef29ea4a0f46e7", 0 );
            function_94a1d41845788577();
            break;
        case #"hash_26aaaa84b54da8b":
            setdvar( @"hash_181ba380cbd7b4cf", 1 );
            thread function_e5a5694bf8da25c9();
            break;
        case #"hash_bd6cf06749b490f8":
            setdvar( @"hash_181ba380cbd7b4cf", 0 );
            function_d06bf49f13c72e74();
            break;
        case #"hash_ae6608a71ecd1f46":
            setdvar( @"scr_ob_activity_sweep_test", 1 );
            thread function_a50af76a8095ca2f();
            break;
        case #"hash_68b149a7de08536b":
            setdvar( @"scr_ob_activity_sweep_test", 0 );
            function_92c15cf959407332();
            break;
    }
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0xf4826410, Offset: 0xa0e
// Size: 0x21
function private ob_start_soak_test()
{
    ob_stop_soak_test();
    level thread function_e5a5694bf8da25c9();
    level thread function_94a1d41845788577();
    level thread function_a50af76a8095ca2f();
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0x7f8448e9, Offset: 0xa37
// Size: 0x23
function private ob_stop_soak_test()
{
    function_d06bf49f13c72e74();
    function_195e7fa1eb4eccda();
    function_92c15cf959407332();
    level notify( #"hash_1f6e71c69fcbccd2" );
}

// Namespace ob_soak_test
// Params 1, eflags: 0x4
// Checksum 0x71e8ebb6, Offset: 0xa62
// Size: 0x77
function private function_8249d92fca677ab1( player )
{
    function_d9138fd8894858( "Waiting for player control" );
    takedamage = player.takedamage;
    
    while ( player.scripted_mode )
    {
        player.takedamage = 0;
        wait 1;
    }
    
    player.takedamage = takedamage;
    level utility::flag_wait( "ob_infil_completed" );
    function_d9138fd8894858( "Player has control" );
}

// Namespace ob_soak_test
// Params 1, eflags: 0x4
// Checksum 0x8832635b, Offset: 0xae1
// Size: 0x3b
function private function_d9138fd8894858( text )
{
    /#
        if ( getdvarint( @"hash_fb7de827d1d52bd8", 0 ) == 0 )
        {
            return;
        }
        
        println( "<dev string:x268>" + gettime() + "<dev string:x280>" + text );
    #/
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0x4da20fd4, Offset: 0xb24
// Size: 0x1c1
function private function_e5a5694bf8da25c9()
{
    if ( getdvarint( @"hash_97f50d212cd862fd", 0 ) == 0 )
    {
        return;
    }
    
    level notify( #"hash_401f1941cd8d4708" );
    level endon( #"hash_401f1941cd8d4708" );
    level endon( #"game_ended" );
    function_d9138fd8894858( "Iniitiating add_delete_test (ob_soak_test)" );
    function_8249d92fca677ab1( level.players[ 0 ] );
    level.var_78fcd0b2b060ac3d.var_d0a86726f074fb41 = [];
    level.var_78fcd0b2b060ac3d.var_ee716157a58d646e = getdvarint( @"hash_a962aa3ed8ea082c", 1 );
    level.var_78fcd0b2b060ac3d.var_2c19f9a1f07f1b4c = getdvarint( @"hash_79b43bbd00d2a116", 14 );
    level.var_78fcd0b2b060ac3d.var_db4523bf4764d433 = getdvarint( @"hash_97b11d093c59fce6", 2 );
    level.var_78fcd0b2b060ac3d.var_9f7d777fefaf96a4 = level.var_bf46df4bfc90e3bf;
    level.var_bf46df4bfc90e3bf = 0;
    level.var_78fcd0b2b060ac3d.old_pap_val = level.var_db70b79e350d72e0;
    level.var_db70b79e350d72e0 = 0;
    
    while ( true )
    {
        if ( level.var_78fcd0b2b060ac3d.var_d0a86726f074fb41.size < level.var_78fcd0b2b060ac3d.var_db4523bf4764d433 )
        {
            level.var_78fcd0b2b060ac3d.bot_squad_origin = level.players[ 0 ].origin;
            level thread bots::spawn_bots( 1, level.players[ 0 ].team, &function_8a644f71ec8c4513, undefined, undefined, "recruit" );
            level waittill( #"bot_spawned" );
            continue;
        }
        
        wait 0.25;
    }
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0x66938fa2, Offset: 0xced
// Size: 0x8c
function private function_d06bf49f13c72e74()
{
    function_d9138fd8894858( "Terminating add_delete_test" );
    
    if ( isdefined( level.var_78fcd0b2b060ac3d.var_9f7d777fefaf96a4 ) )
    {
        level.var_bf46df4bfc90e3bf = level.var_78fcd0b2b060ac3d.var_9f7d777fefaf96a4;
    }
    
    if ( isdefined( level.var_78fcd0b2b060ac3d.old_pap_val ) )
    {
        level.var_db70b79e350d72e0 = level.var_78fcd0b2b060ac3d.old_pap_val;
    }
    
    level notify( #"kick_all_bots" );
    level notify( #"hash_401f1941cd8d4708" );
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0x9625b9e7, Offset: 0xd81
// Size: 0x11a
function private function_8a644f71ec8c4513()
{
    thread function_6b4253acd28b7653( "kick_all_bots", level.var_78fcd0b2b060ac3d.var_ee716157a58d646e, level.var_78fcd0b2b060ac3d.var_2c19f9a1f07f1b4c );
    
    if ( isdefined( level.var_78fcd0b2b060ac3d.bot_squad_origin ) )
    {
        var_6e7e21c87fc712e6 = level.var_78fcd0b2b060ac3d.bot_squad_origin + ( randomintrange( -128, 128 ), randomintrange( -128, 128 ), 24 );
        
        if ( !self isspectatingplayer() )
        {
            self setorigin( var_6e7e21c87fc712e6 );
            self botclearscriptgoal();
        }
    }
    
    self botsetflag( "disable_movement", 1 );
    self botsetflag( "disable_random_goal", 1 );
    self botsetflag( "dont_path_to_enemy", 1 );
    self allowmovement( 0 );
    level.var_78fcd0b2b060ac3d.var_d0a86726f074fb41[ level.var_78fcd0b2b060ac3d.var_d0a86726f074fb41.size ] = self;
    function_d9138fd8894858( "Bot Spawned, count = " + level.var_78fcd0b2b060ac3d.var_d0a86726f074fb41.size );
    level notify( #"bot_spawned" );
}

// Namespace ob_soak_test
// Params 3, eflags: 0x4
// Checksum 0x8a9ca3c6, Offset: 0xea3
// Size: 0x9f
function private function_6b4253acd28b7653( note, min, max )
{
    self endon( #"disconnect" );
    timeout = randomfloatrange( min, max );
    level utility::waittill_notify_or_timeout( note, timeout );
    level.var_78fcd0b2b060ac3d.var_d0a86726f074fb41 = arrayremove( level.var_78fcd0b2b060ac3d.var_d0a86726f074fb41, self );
    kick( self getentitynumber() );
    function_d9138fd8894858( "Bot kicked, count = " + level.var_78fcd0b2b060ac3d.var_d0a86726f074fb41.size );
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0xefc4149c, Offset: 0xf4a
// Size: 0xf7
function private function_94a1d41845788577()
{
    level notify( #"warp_shoot_test_singleton" );
    level endon( #"warp_shoot_test_singleton" );
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_bef29ea4a0f46e7", 0 ) == 0 )
    {
        return;
    }
    
    function_8249d92fca677ab1( level.players[ 0 ] );
    function_d9138fd8894858( "Iniitiating warp_shoot_test (ob_soak_test)" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) && !player utility::ent_flag( "player_soak_active" ) )
            {
                player thread function_4dc610a699598541();
            }
        }
        
        wait 10;
    }
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0x6448068b, Offset: 0x1049
// Size: 0x1e7
function private function_4dc610a699598541()
{
    self notify( #"hash_a714bb2f13dbca64" );
    self endon( #"hash_a714bb2f13dbca64" );
    level endon( #"warp_shoot_test_singleton" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    player = self;
    player utility::ent_flag_set( "player_soak_active" );
    setdvar( @"player_sustainammo", 1 );
    all_ai = getaiarray();
    var_843124d51c0e1a48 = utility::get_array_of_closest( player.origin, all_ai );
    
    foreach ( ai in var_843124d51c0e1a48 )
    {
        if ( isalive( ai ) )
        {
            var_afdcccd14107e2eb = ai.origin + ( 30, 30, 10 );
            new_origin = getclosestpointonnavmesh( var_afdcccd14107e2eb );
            player setorigin( new_origin );
            function_d9138fd8894858( "Warping player (" + player.name + ") to location " + new_origin );
            wait 2;
            
            for ( i = 0; i < 10 ; i++ )
            {
                player startforcedfire();
                wait 2;
                player stopforcedfire();
                wait 2;
                current_angles = player getplayerangles();
                player setplayerangles( current_angles + ( 0, 85, 0 ) );
                wait 1;
                angles = player getplayerangles();
            }
            
            break;
        }
    }
    
    player utility::ent_flag_clear( "player_soak_active" );
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0xdb9fd255, Offset: 0x1238
// Size: 0x1a
function private function_195e7fa1eb4eccda()
{
    function_d9138fd8894858( "Terminating warp_shoot_test" );
    level notify( #"warp_shoot_test_singleton" );
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0x450738e6, Offset: 0x125a
// Size: 0x1e4
function private function_a50af76a8095ca2f()
{
    if ( getdvarint( @"scr_ob_activity_sweep_test", 0 ) == 0 )
    {
        return;
    }
    
    level notify( #"hash_faa8c5191d887be8" );
    level endon( #"hash_faa8c5191d887be8" );
    level endon( #"game_ended" );
    function_d9138fd8894858( "Iniitiating activity_sweep_test (ob_soak_test)" );
    callback::add( #"player_damaged", &on_player_damaged );
    callback::add( #"player_laststand", &on_player_laststand );
    function_8249d92fca677ab1( level.players[ 0 ] );
    var_d3bb36ae177d0ea8 = ob_activity_manager::function_13745445d5f57d2a();
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                kick( player getentitynumber() );
            }
        }
        
        if ( ob_activity_manager::function_81e8b9df4d6b3a72() == 0 )
        {
            function_d9138fd8894858( "Aborting activity_sweep_test (ob_soak_test), activity manager not enabled" );
            function_92c15cf959407332();
            return;
        }
        
        foreach ( var_1ecf3a2b4c40496c in var_d3bb36ae177d0ea8 )
        {
            var_657a3abce2509b48 = ob_activity_manager::function_7e9301d7a4c4306b( var_1ecf3a2b4c40496c );
            
            if ( isdefined( var_657a3abce2509b48 ) )
            {
                activityinstance = ob_activity_manager::ob_activity_instance_init( var_657a3abce2509b48 );
                
                if ( isdefined( activityinstance ) )
                {
                    function_111ceb12cc6b5178( activityinstance, var_657a3abce2509b48 );
                }
            }
            
            wait 1;
        }
    }
}

// Namespace ob_soak_test
// Params 0, eflags: 0x4
// Checksum 0x8549b919, Offset: 0x1446
// Size: 0x38
function private function_92c15cf959407332()
{
    callback::remove( #"player_damaged", &on_player_damaged );
    callback::remove( #"player_laststand", &on_player_laststand );
    level notify( #"hash_faa8c5191d887be8" );
}

// Namespace ob_soak_test
// Params 1, eflags: 0x4
// Checksum 0xeb2f5fbe, Offset: 0x1486
// Size: 0x70
function private function_228a700b84ad7e5d( activityinstance )
{
    switch ( activityinstance.type )
    {
        case #"hash_8868223da7b17525":
            return 30;
        case #"hash_17b1c4f2de901a59":
        case #"hash_5639f68d1b348213":
        case #"hash_b034a4d29df58c9a":
        case #"hash_bcceffcc02978e65":
            return 60;
    }
    
    return getdvarint( @"hash_a5704d522027396c", 30 );
}

// Namespace ob_soak_test
// Params 1, eflags: 0x4
// Checksum 0x3b5f521, Offset: 0x14ff
// Size: 0xf7
function private function_51abfed579e62b78( radius = 512 )
{
    /#
        level endon( #"hash_faa8c5191d887be8" );
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        self notify( #"hash_70074dfde0160f73" );
        self endon( #"hash_70074dfde0160f73" );
        
        while ( true )
        {
            nearby_ai = getaiarrayinradius( self.origin, radius );
            
            foreach ( ai in nearby_ai )
            {
                ai kill( ai.origin );
            }
            
            wait 0.5;
        }
    #/
}

// Namespace ob_soak_test
// Params 2, eflags: 0x4
// Checksum 0xf96bee46, Offset: 0x15fe
// Size: 0x1f6
function private function_111ceb12cc6b5178( activityinstance, var_657a3abce2509b48 )
{
    level endon( #"hash_faa8c5191d887be8" );
    function_d9138fd8894858( "Found Activity (" + var_657a3abce2509b48.class + ") with name of: " + var_657a3abce2509b48.name );
    new_origin = getclosestpointonnavmesh( var_657a3abce2509b48.origins[ randomint( var_657a3abce2509b48.origins.size ) ] );
    level.players[ 0 ] utility::player_prestream_camera( new_origin, 5, level.players[ 0 ].angles[ 1 ] );
    
    foreach ( player in level.players )
    {
        player setorigin( new_origin + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 10 ) );
        function_d9138fd8894858( "Warping player (" + player.name + ") to location " + new_origin );
    }
    
    level thread _activity_run_instance( var_657a3abce2509b48, activityinstance );
    var_3c50c651e2384b9a = function_228a700b84ad7e5d( var_657a3abce2509b48 );
    function_d9138fd8894858( "Activity (" + var_657a3abce2509b48.class + ") with name of (" + var_657a3abce2509b48.name + ") will be active for the next " + var_3c50c651e2384b9a + " seconds." );
    utility::waittill_notify_or_timeout( "test_activity_completed", var_3c50c651e2384b9a );
    function_d9138fd8894858( "Ending Activity (" + var_657a3abce2509b48.class + ") with name of: " + var_657a3abce2509b48.name );
    activity_instance_common::endactivity( activityinstance, 1 );
    level notify( #"hash_5519cb77bea483ac" );
}

// Namespace ob_soak_test
// Params 2, eflags: 0x4
// Checksum 0x2e745eb3, Offset: 0x17fc
// Size: 0x2de
function private _activity_run_instance( var_657a3abce2509b48, activityinstance )
{
    level notify( #"hash_2eee0de105e59b5a" );
    level endon( #"hash_2eee0de105e59b5a" );
    level endon( #"hash_5519cb77bea483ac" );
    level endon( #"hash_faa8c5191d887be8" );
    waitframe();
    function_d9138fd8894858( "Starting Activity (" + var_657a3abce2509b48.class + ") variant tag:  " + activityinstance.varianttag );
    
    switch ( var_657a3abce2509b48.type )
    {
        case #"hash_17b1c4f2de901a59":
            level thread function_d6123d3cc29b0ad5( activityinstance, var_657a3abce2509b48 );
            break;
        case #"hash_bcceffcc02978e65":
            level thread function_c6b9c58a2dbe46d8( activityinstance, var_657a3abce2509b48 );
            break;
        case #"hash_5639f68d1b348213":
        case #"hash_b034a4d29df58c9a":
            level thread function_6a21ba4fe2cb6f3( activityinstance, var_657a3abce2509b48 );
            break;
        case #"hash_8868223da7b17525":
            level thread function_fe5948dc109aa25e( activityinstance, var_657a3abce2509b48 );
            break;
        case #"hash_18347fa7b15eb832":
        case #"hash_2839d15859ec95fb":
        case #"hash_2ccdb15df9009096":
        case #"hash_2f4998a4a5760392":
        case #"hash_40d422a1ae5ecf0f":
        case #"hash_427820bb3395e2bf":
        case #"hash_5191681fd986c4eb":
        case #"hash_5253ef0f4683b778":
        case #"hash_5aec85630f3886be":
        case #"hash_6cf9b195bc4324c6":
        case #"hash_76bc11857d0dbf4c":
        case #"hash_80393f08d5a43d76":
        case #"hash_84c8d0e39c86ae55":
        case #"hash_87fc920520ec2075":
        case #"hash_93ac930eae20dc0":
        case #"hash_8a15cfdbf463e060":
        case #"hash_a9427160c391d79d":
        case #"hash_afab1432354a0970":
        case #"hash_113756c907deb5be":
        case #"hash_bc2e36acd99d4454":
        case #"hash_15c4973fd9fe46c4":
        case #"hash_bfe91a2e65bea028":
        case #"hash_c66a776a8125106c":
        case #"hash_cf18a80d017267ca":
        case #"hash_cf6a24d2fd4c1930":
        case #"hash_df1adaaaad94657b":
        case #"hash_f0f77ef6300b1970":
        case #"hash_f3614d8cc5575a83":
        case #"hash_f4c3ae9ba5e649bb":
            break;
        default:
            foreach ( player in level.players )
            {
                player thread function_51abfed579e62b78();
            }
            
            break;
    }
}

// Namespace ob_soak_test
// Params 2, eflags: 0x4
// Checksum 0x1b5d532e, Offset: 0x1ae2
// Size: 0x102
function private function_c6b9c58a2dbe46d8( activityinstance, var_657a3abce2509b48 )
{
    level endon( #"game_ended" );
    level endon( #"hash_5519cb77bea483ac" );
    level endon( #"hash_faa8c5191d887be8" );
    player = level.players[ 0 ];
    
    if ( !isdefined( player ) )
    {
        level notify( #"test_activity_completed" );
        return;
    }
    
    while ( !isdefined( activityinstance.safe ) )
    {
        wait 1;
    }
    
    new_origin = getclosestpointonnavmesh( activityinstance.safe.origin + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 10 ) );
    player setorigin( new_origin );
    function_d9138fd8894858( "Warping player (" + player.name + ") to weapon st stash at location " + new_origin );
    wait 3;
    activityinstance.safe notify( #"safe_unlocked" );
    wait 3;
    level notify( #"test_activity_completed" );
}

// Namespace ob_soak_test
// Params 2, eflags: 0x4
// Checksum 0xe35864f3, Offset: 0x1bec
// Size: 0x107
function private function_6a21ba4fe2cb6f3( activityinstance, var_657a3abce2509b48 )
{
    level endon( #"game_ended" );
    level endon( #"hash_5519cb77bea483ac" );
    level endon( #"hash_faa8c5191d887be8" );
    player = level.players[ 0 ];
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    var_8ed7c0132ee25b0a = activityinstance.e_defend_objective;
    anchor = getclosestpointonnavmesh( var_8ed7c0132ee25b0a.origin );
    player setorigin( anchor + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 10 ) );
    player thread function_51abfed579e62b78( 1024 );
    function_d9138fd8894858( "Setting position of player (" + player.name + ") to defend location " + anchor + " for object: " + var_8ed7c0132ee25b0a.targetname );
    
    while ( isdefined( player ) )
    {
        wait 1;
    }
    
    level notify( #"test_activity_completed" );
}

// Namespace ob_soak_test
// Params 2, eflags: 0x4
// Checksum 0x46b8e8df, Offset: 0x1cfb
// Size: 0x48
function private function_d6123d3cc29b0ad5( activityinstance, var_657a3abce2509b48 )
{
    level endon( #"game_ended" );
    level endon( #"hash_5519cb77bea483ac" );
    level endon( #"hash_faa8c5191d887be8" );
    wait 1;
    level notify( #"test_activity_completed" );
}

// Namespace ob_soak_test
// Params 2, eflags: 0x4
// Checksum 0x7a55143b, Offset: 0x1d4b
// Size: 0xb3
function private function_fe5948dc109aa25e( activityinstance, var_657a3abce2509b48 )
{
    level endon( #"game_ended" );
    level endon( #"hash_5519cb77bea483ac" );
    level endon( #"hash_faa8c5191d887be8" );
    player = level.players[ 0 ];
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    /#
        var_5da972ed55b239cf = [ "<dev string:x283>", "<dev string:x289>", "<dev string:x2c3>", "<dev string:x2fd>", "<dev string:x339>", "<dev string:x376>" ];
        wait 1;
        activityinstance thread ob_activity_turret_trap::turret_trap_activate( var_5da972ed55b239cf[ randomint( var_5da972ed55b239cf.size ) ], player );
    #/
}

// Namespace ob_soak_test
// Params 1, eflags: 0x4
// Checksum 0xf430d585, Offset: 0x1e06
// Size: 0x14
function private on_player_laststand( params )
{
    if ( isplayer( self ) )
    {
    }
}

// Namespace ob_soak_test
// Params 1, eflags: 0x4
// Checksum 0x31499892, Offset: 0x1e22
// Size: 0x70
function private on_player_damaged( params )
{
    newhealth = self.health - params.damage;
    var_a7f2f333fc15d3a = int( self.maxhealth * 0.75 );
    
    if ( newhealth <= var_a7f2f333fc15d3a )
    {
        params.damage = 0;
        self.health = self.maxhealth;
    }
}

