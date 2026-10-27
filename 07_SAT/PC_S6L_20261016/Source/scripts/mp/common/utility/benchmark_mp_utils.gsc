// scripts\mp\common\utility\benchmark_mp_utils.gsc  (hash_0315aa86810d944c.gscc) (size: 33823 Bytes / 0x841f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30900a57 (814746199)
// size ...... 33823 (0x841f)
// includes .. 24  (offset: 0x77c3)
// strings ... 38  (offset: 0x7883)
// dev strs .. 148 (offset: 0x7abb)
// exports ... 87  (offset: 0x4c2f)
// cseg ...... 0x2de + 0x4951 (0x4c2f)
// imports ... 242 (offset: 0x59c7)
// animtree1 . 0   (offset: 0x841f)
// animtree2 . 0   (offset: 0x841f)
#using script_18c2f6d91cbc576a;
#using script_1e4b34c6e2079318;
#using script_3aef13b8bdda78d2;
#using script_4f7cbc7a2a2ba890;
#using script_5305dc48048e0b08;
#using scripts\anim\shared;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\swim_common;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\auto_drone;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\nuke;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\mp_agent;

#namespace benchmark_mp_utils;

// Namespace benchmark_mp_utils
// Params 2
// Checksum 0xcb4965b4, Offset: 0x2fc
// Size: 0x17
function function_4a78a434bc9d818c( dvarname, dvarvalue )
{
    return dvarname;
}

// Namespace benchmark_mp_utils
// Params 0
// Checksum 0x6838f1a8, Offset: 0x31c
// Size: 0x9, Type: bool
function isdevbuild()
{
    /#
        return true;
    #/
    
    return false;
}

// Namespace benchmark_mp_utils
// Params 3
// Checksum 0x3fa5deaf, Offset: 0x32e
// Size: 0x6a
function function_768d305ebadbe8fb( duration_seconds, var_40c11cec962a8a3 = undefined, var_51c617130de176a9 = undefined )
{
    zone = spawnstruct();
    zone.duration_seconds = duration_seconds;
    zone.var_40c11cec962a8a3 = var_40c11cec962a8a3;
    zone.var_51c617130de176a9 = var_51c617130de176a9;
    return zone;
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0x72b7abfe, Offset: 0x3a1
// Size: 0x74
function function_6ab87ad1143eed0b( zone_info_array )
{
    if ( zone_info_array.size > 0 )
    {
        packed_integer = zone_info_array[ 0 ].duration_seconds;
        
        for ( i = 1; i < zone_info_array.size ; i++ )
        {
            packed_integer = packed_integer << 5 | zone_info_array[ i ].duration_seconds;
        }
        
        packed_integer = packed_integer << 5 | zone_info_array.size;
        setomnvar( "ui_benchmark_create_zones", packed_integer );
    }
}

// Namespace benchmark_mp_utils
// Params 2
// Checksum 0x3c69fcd, Offset: 0x41d
// Size: 0xc0
function function_424726511ca50e8a( player, zone_info_array )
{
    if ( !player )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    for ( i = 0; i < zone_info_array.size ; i++ )
    {
        if ( isdefined( zone_info_array[ i ].var_40c11cec962a8a3 ) )
        {
            thread [[ zone_info_array[ i ].var_40c11cec962a8a3 ]]( zone_info_array[ i ].duration_seconds, player );
        }
        
        function_87f27a2fe82b85da( i, zone_info_array[ i ].duration_seconds );
        wait zone_info_array[ i ].duration_seconds;
        
        if ( isdefined( zone_info_array[ i ].var_51c617130de176a9 ) )
        {
            thread [[ zone_info_array[ i ].var_51c617130de176a9 ]]( player );
        }
    }
}

// Namespace benchmark_mp_utils
// Params 2
// Checksum 0xe0601edb, Offset: 0x4e5
// Size: 0x27
function function_87f27a2fe82b85da( zone_index, zone_duration_seconds )
{
    setomnvar( "benchmark_zone_change", ( zone_index << 8 ) + zone_duration_seconds );
}

// Namespace benchmark_mp_utils
// Params 0
// Checksum 0x4f092bf6, Offset: 0x514
// Size: 0xc9
function function_a4f2152b5f2cf03c()
{
    if ( isdefined( level.black_overlay ) )
    {
        return level.black_overlay;
    }
    
    black_overlay = newhudelem();
    black_overlay.x = 0;
    black_overlay.y = 0;
    black_overlay setshader( "black", 640, 480 );
    black_overlay.alignx = "left";
    black_overlay.aligny = "top";
    black_overlay.sort = 1;
    black_overlay.horzalign = "fullscreen";
    black_overlay.vertalign = "fullscreen";
    black_overlay.foreground = 1;
    level.black_overlay = black_overlay;
    return level.black_overlay;
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0xc6422456, Offset: 0x5e6
// Size: 0x57
function function_1575e6db0bcbad11( time_seconds )
{
    black_overlay = function_a4f2152b5f2cf03c();
    
    if ( time_seconds <= 0 )
    {
        black_overlay.alpha = 1;
        return;
    }
    
    black_overlay.alpha = 0;
    black_overlay fadeovertime( time_seconds );
    black_overlay.alpha = 1;
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0xed63a45, Offset: 0x645
// Size: 0x56
function function_157210286b7849ce( time_seconds )
{
    black_overlay = function_a4f2152b5f2cf03c();
    
    if ( time_seconds <= 0 )
    {
        black_overlay.alpha = 0;
        return;
    }
    
    black_overlay.alpha = 1;
    black_overlay fadeovertime( time_seconds );
    black_overlay.alpha = 0;
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0x2b861f38, Offset: 0x6a3
// Size: 0xe1
function function_2c03773097b86c22( player_rig = undefined )
{
    if ( !isdefined( level.player ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    level.player swim_common::function_6c0a071348a7629b();
    level.player playlocalsound( "mvmt_swim_plunging_plr_fast" );
    
    if ( isdefined( player_rig ) )
    {
        playfxontag( utility::getfx( "swim_enter_water" ), player_rig, "tag_camera" );
    }
    else
    {
        playfxontag( utility::getfx( "swim_enter_water" ), level.player, "tag_eye" );
    }
    
    level.player childthread swim_common::function_51208b2efbedb7b3();
    level.player childthread swim_common::playerswimming();
    level.player setclientomnvar( "swim_under_water", level.player.swim.underwater );
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0xe8c63e73, Offset: 0x78c
// Size: 0xe1
function function_c1c32536f7a7b08d( player_rig = undefined )
{
    if ( !isdefined( level.player ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    level.player swim_common::sfx_swim_surface();
    level.player playlocalsound( "mvmt_swim_surfacing_plr_sprint_gasping" );
    
    if ( isdefined( player_rig ) )
    {
        playfxontag( utility::getfx( "swim_exit_water" ), player_rig, "tag_camera" );
    }
    else
    {
        playfxontag( utility::getfx( "swim_exit_water" ), level.player, "tag_eye" );
    }
    
    level.player childthread swim_common::function_1fcc272380ba6e7b();
    level.player childthread swim_common::function_1d34a8e960ba182d();
    level.player setclientomnvar( "swim_under_water", level.player.swim.underwater );
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0x352364c1, Offset: 0x875
// Size: 0x3b
function playerexitwater( player_rig )
{
    if ( !isdefined( level.player ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    level.player playlocalsound( "mvmt_swim_exitwater_plr" );
}

// Namespace benchmark_mp_utils
// Params 3
// Checksum 0x850ae32d, Offset: 0x8b8
// Size: 0x12f
function function_9d0c19a37c65e7b8( var_a2e42d5911e22bce, percentage, time_seconds )
{
    if ( isdedicatedserver() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level.player endon( #"death_or_disconnect" );
    percentage = clamp( percentage, 0, 1 );
    time_seconds = max( time_seconds, 0 );
    var_511c5caf4131f2f2 = var_a2e42d5911e22bce * percentage;
    
    if ( time_seconds <= 0 )
    {
        setdvar( @"r_fogheightmapfade", var_511c5caf4131f2f2 );
        return;
    }
    
    var_d66093548fd710cf = getdvarfloat( @"r_fogheightmapfade" );
    var_c369eabf0cda27fa = var_d66093548fd710cf;
    start_time = gettime();
    end_time = start_time + time_seconds * 1000;
    
    while ( gettime() < end_time )
    {
        var_c369eabf0cda27fa = math::lerp( var_d66093548fd710cf, var_511c5caf4131f2f2, gettime() / end_time );
        setdvar( @"r_fogheightmapfade", var_c369eabf0cda27fa );
        
        /#
            printtoscreen2d( 400, 500, "<dev string:x3f>" + var_c369eabf0cda27fa, ( 1, 0, 0 ), 1.5, 1 );
        #/
        
        waitframe();
    }
    
    setdvar( @"r_fogheightmapfade", var_511c5caf4131f2f2 );
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0xafb226b, Offset: 0x9ef
// Size: 0x18
function function_dd5bd0d8de316d61( player_rig )
{
    setomnvar( "ui_benchmark_show_weapon_reticle", 1 );
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0x5f6060a3, Offset: 0xa0f
// Size: 0x17
function function_dcc9df71435841da( player_rig )
{
    setomnvar( "ui_benchmark_show_weapon_reticle", 0 );
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0x11012e13, Offset: 0xa2e
// Size: 0x44
function function_8c760061f967230c( player_rig )
{
    if ( !isdefined( level.player ) )
    {
        return;
    }
    
    level.player lerpfov( 65, 0.05 );
    setglobalsoundcontext( "ads", "", 0.1 );
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0x3c68b618, Offset: 0xa7a
// Size: 0x44
function function_f54e4f773b7d8e39( player_rig )
{
    if ( !isdefined( level.player ) )
    {
        return;
    }
    
    level.player lerpfov( 70, 0.05 );
    setglobalsoundcontext( "ads", "on", 0.1 );
}

// Namespace benchmark_mp_utils
// Params 2
// Checksum 0x77165176, Offset: 0xac6
// Size: 0x4b
function function_bbd5e9a9fc65bd91( hashed_name, time_seconds )
{
    /#
        if ( getdvarint( @"hash_e1311698a7df7122" ) == 1 )
        {
            return;
        }
    #/
    
    function_f9d0dfe3ff7db515();
    level.var_d84ed83c42dc5cfc = hashed_name;
    function_592878987c62a1a9( hashed_name, time_seconds * 1000 );
}

// Namespace benchmark_mp_utils
// Params 0
// Checksum 0x1644f20c, Offset: 0xb19
// Size: 0x27
function function_f9d0dfe3ff7db515()
{
    if ( isdefined( level.var_d84ed83c42dc5cfc ) )
    {
        hwconfiguratorremoveasset( level.var_d84ed83c42dc5cfc );
        level.var_d84ed83c42dc5cfc = undefined;
    }
}

// Namespace benchmark_mp_utils
// Params 2
// Checksum 0x691d62b0, Offset: 0xb48
// Size: 0x63
function function_4fdb6b453eec8705( callbackfunction, player )
{
    if ( !isdefined( level.endgamecallbacks ) )
    {
        level.endgamecallbacks = [];
    }
    
    level.endgamecallbacks[ level.endgamecallbacks.size ] = callbackfunction;
    
    if ( !level.var_bebc4c484993c9f8 )
    {
        level.var_bebc4c484993c9f8 = 1;
        thread function_c7f5e98c3dd76be8( player );
    }
}

// Namespace benchmark_mp_utils
// Params 0
// Checksum 0xbb766bc9, Offset: 0xbb3
// Size: 0x13, Type: bool
function function_1213863ac8d76692()
{
    return getdvarint( @"benchmark_freeroam", 0 ) == 1;
}

// Namespace benchmark_mp_utils
// Params 0
// Checksum 0x3bd669f6, Offset: 0xbcf
// Size: 0x86
function function_47dbd9fd27e108cb()
{
    setdvar( @"hash_c11db9baa9e5bc9b", 1 );
    setdvar( @"scr_skip_infils", 1 );
    setdvar( @"scr_game_graceperiod", 0 );
    setdvar( @"scr_game_matchstarttime", 0 );
    setdvar( @"scr_game_disableannouncer", 1 );
    setdvar( @"hash_2a4f08bc79265550", 1 );
    setdvar( @"player_sustainammo", 1 );
    level.blocknukekills = 1;
    level.nosuspensemusic = 1;
}

// Namespace benchmark_mp_utils
// Params 4
// Checksum 0x3df56699, Offset: 0xc5d
// Size: 0xd8
function spawnnuke( player, launch_position, var_d0a9d177707a4448, explosion_time )
{
    nuke_streakinfo = killstreak_utility::createstreakinfo( "nuke_multi", player );
    nuke_streakinfo.streakname = "nuke_multi";
    nuke_streakinfo.debug_state = "begin_use";
    nuke_streakinfo.var_9065341eff512952 = 1;
    nuke_streakinfo.var_9d7850c81d7e0d81 = 1;
    nuke_streakinfo.var_30a453e5257cf0c8 = 1;
    nuke_streakinfo.mpstreaksysteminfo = killstreaks::createstreakitemstruct( nuke_streakinfo.streakname );
    player nuke::nuke_start( nuke_streakinfo, 0, launch_position, var_d0a9d177707a4448, 0, explosion_time, "nuke_multi_mp", level.streakglobals.streakbundles[ "nuke_multi" ] );
}

/#

    // Namespace benchmark_mp_utils
    // Params 4
    // Checksum 0xb5dcd61c, Offset: 0xd3d
    // Size: 0xf3, Type: dev
    function function_58455b481846aefc( guititle, path, commandcallback, var_550c32cdc941b8a9 )
    {
        if ( !isdefined( level.var_aa91986a8293701 ) )
        {
            level.var_aa91986a8293701 = [];
        }
        
        if ( path[ path.size - 1 ] != "<dev string:x52>" )
        {
            path += "<dev string:x52>";
        }
        
        if ( !isdefined( commandcallback ) )
        {
            commandcallback = &function_c54873b2989b59d6;
        }
        
        command_struct = spawnstruct();
        command_struct.guititle = guititle;
        command_struct.path = path;
        command_struct.commandcallback = commandcallback;
        command_struct.var_550c32cdc941b8a9 = var_550c32cdc941b8a9;
        
        if ( !isdefined( level.var_aa91986a8293701[ path ] ) )
        {
            level.var_aa91986a8293701[ path ] = [];
        }
        
        var_610ca93c4950914b = level.var_aa91986a8293701[ path ].size;
        level.var_aa91986a8293701[ path ][ var_610ca93c4950914b ] = command_struct;
    }

    // Namespace benchmark_mp_utils
    // Params 1
    // Checksum 0x25d69ed5, Offset: 0xe38
    // Size: 0x21f, Type: dev
    function function_abeeb86ec4c08184( player )
    {
        if ( !isdefined( level.var_aa91986a8293701 ) )
        {
            return;
        }
        
        var_dcffa07e1fd2af01 = [];
        
        foreach ( pathkey, command_path_array in level.var_aa91986a8293701 )
        {
            devgui::function_9082edeb5db93280( pathkey );
            
            foreach ( command_struct in command_path_array )
            {
                var_a8826da8026e2788 = command_struct.guititle;
                
                if ( isdefined( command_struct.var_550c32cdc941b8a9 ) )
                {
                    shortcut_struct = spawnstruct();
                    shortcut_struct.is_key_down = 0;
                    shortcut_struct.var_550c32cdc941b8a9 = command_struct.var_550c32cdc941b8a9;
                    shortcut_struct.commandcallback = command_struct.commandcallback;
                    var_dcffa07e1fd2af01[ var_dcffa07e1fd2af01.size ] = shortcut_struct;
                    key_strings = "<dev string:x54>";
                    
                    for ( i = 0; i < command_struct.var_550c32cdc941b8a9.size ; i++ )
                    {
                        key_strings += command_struct.var_550c32cdc941b8a9[ i ] + "<dev string:x55>";
                    }
                    
                    var_a8826da8026e2788 = key_strings + command_struct.guititle;
                    shortcut_struct.var_5a1cd2fad065c0a9 = var_a8826da8026e2788;
                }
                
                devgui::add_devgui_func( var_a8826da8026e2788, command_struct.guititle, command_struct.commandcallback );
            }
            
            devgui::function_77df7fe7dd273e10();
        }
        
        level.var_aa91986a8293701 = undefined;
        thread function_2fe2778f08edd219( player, var_dcffa07e1fd2af01 );
    }

    // Namespace benchmark_mp_utils
    // Params 2, eflags: 0x4
    // Checksum 0x987537ef, Offset: 0x105f
    // Size: 0x1c1, Type: dev
    function private function_2fe2778f08edd219( player, debug_keyboard_shortcuts )
    {
        level endon( #"game_ended" );
        player endon( #"disconnect" );
        
        if ( !isdefined( debug_keyboard_shortcuts ) || debug_keyboard_shortcuts.size == 0 )
        {
            return;
        }
        
        var_5a6e1fbe8a4d4895 = 20;
        var_8faad59c20e1bdb4 = 30;
        
        for ( ;; )
        {
            var_6b4bf35a7d2f1c2 = 400;
            
            foreach ( shortcut_struct in debug_keyboard_shortcuts )
            {
                if ( isdefined( shortcut_struct.var_5a1cd2fad065c0a9 ) )
                {
                    printtoscreen2d( var_5a6e1fbe8a4d4895, var_6b4bf35a7d2f1c2, shortcut_struct.var_5a1cd2fad065c0a9, ( 0, 1, 0 ), 1.2, 1 );
                    var_6b4bf35a7d2f1c2 += var_8faad59c20e1bdb4;
                }
                
                var_324ad4f4bcd84bc6 = 0;
                
                if ( isdefined( shortcut_struct.var_550c32cdc941b8a9 ) )
                {
                    for ( i = 0; i < shortcut_struct.var_550c32cdc941b8a9.size ; i++ )
                    {
                        if ( player buttonpressed( shortcut_struct.var_550c32cdc941b8a9[ i ] ) )
                        {
                            var_324ad4f4bcd84bc6 = 1;
                            continue;
                        }
                        
                        var_324ad4f4bcd84bc6 = 0;
                        break;
                    }
                }
                
                if ( var_324ad4f4bcd84bc6 )
                {
                    if ( !shortcut_struct.is_key_down && isdefined( shortcut_struct.commandcallback ) )
                    {
                        [[ shortcut_struct.commandcallback ]]();
                    }
                    
                    shortcut_struct.is_key_down = 1;
                    continue;
                }
                
                shortcut_struct.is_key_down = 0;
            }
            
            waitframe();
        }
    }

    // Namespace benchmark_mp_utils
    // Params 0, eflags: 0x4
    // Checksum 0x1e748845, Offset: 0x1228
    // Size: 0xf, Type: dev
    function private function_c54873b2989b59d6()
    {
        iprintlnbold( "<dev string:x57>" );
    }

    // Namespace benchmark_mp_utils
    // Params 0
    // Checksum 0x8e3d65b6, Offset: 0x123f
    // Size: 0x26, Type: dev
    function function_a4e58f745509cd1d()
    {
        setdvar( function_4a78a434bc9d818c( @"benchmark_freeroam", 0 ), 1 );
        adddebugcommand( "<dev string:x71>" );
    }

    // Namespace benchmark_mp_utils
    // Params 0
    // Checksum 0xdb99fb27, Offset: 0x126d
    // Size: 0x25, Type: dev
    function function_f935ed3c639215ed()
    {
        setdvar( function_4a78a434bc9d818c( @"benchmark_freeroam", 0 ), 0 );
        adddebugcommand( "<dev string:x71>" );
    }

    // Namespace benchmark_mp_utils
    // Params 0
    // Checksum 0x76487148, Offset: 0x129a
    // Size: 0xf, Type: dev
    function function_6f4cc32a47b35564()
    {
        adddebugcommand( "<dev string:x7e>" );
    }

#/

// Namespace benchmark_mp_utils
// Params 1, eflags: 0x4
// Checksum 0x94aa042, Offset: 0x12b1
// Size: 0x7a
function private function_c7f5e98c3dd76be8( player )
{
    while ( true )
    {
        player waittill( #"luinotifyserver", msg );
        
        if ( msg == "end_game" )
        {
            break;
        }
    }
    
    if ( isdefined( level.endgamecallbacks ) )
    {
        for ( i = 0; i < level.endgamecallbacks.size ; i++ )
        {
            thread [[ level.endgamecallbacks[ i ] ]]( player );
        }
    }
}

// Namespace benchmark_mp_utils
// Params 5
// Checksum 0x51c88fa4, Offset: 0x1333
// Size: 0xd8
function function_8cc9c9da58868fb2( player, entity, var_f4f8a2576734b3ee, wait_time, var_2428ad4b9aa93df5 = 0.5 )
{
    if ( isdefined( entity ) )
    {
        entity endon( #"death" );
    }
    
    wait wait_time;
    
    if ( soundexists( var_f4f8a2576734b3ee ) )
    {
        neworigin = player.origin;
        
        if ( isdefined( entity ) )
        {
            playerorigin = player.origin;
            entityorigin = entity.origin;
            var_2428ad4b9aa93df5 = clamp( var_2428ad4b9aa93df5, 0, 1 );
            neworigin = vectorlerp( playerorigin, entityorigin, var_2428ad4b9aa93df5 );
        }
        
        playsoundatpos( neworigin, var_f4f8a2576734b3ee );
        return;
    }
    
    assertmsg( "<dev string:x86>" + var_f4f8a2576734b3ee + "<dev string:x9b>" );
}

// Namespace benchmark_mp_utils
// Params 3
// Checksum 0x1fcbb281, Offset: 0x1413
// Size: 0x66
function function_9c60fba11cd3395c( vo_alias_name, wait_time, var_2428ad4b9aa93df5 = 0.5 )
{
    vo_struct = spawnstruct();
    vo_struct.alias = vo_alias_name;
    vo_struct.wait_time = wait_time;
    vo_struct.percentage = var_2428ad4b9aa93df5;
    return vo_struct;
}

// Namespace benchmark_mp_utils
// Params 8
// Checksum 0x5e043c6f, Offset: 0x1482
// Size: 0xf3
function function_8550afed58d9513c( player, name, origin, radius, triggercallback, var_d1731c1c5c658b97 = undefined, var_bbced3a4c056841 = 1, var_5c6cf7b8db65a693 = undefined )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    trigger = spawn( "trigger_radius", origin, 0, radius, radius );
    
    if ( isdefined( var_d1731c1c5c658b97 ) )
    {
        var_d1731c1c5c658b97.trigger = trigger;
    }
    
    trigger.radius = radius;
    thread function_d5486cfc2d0aa2c5( trigger, player, triggercallback, var_bbced3a4c056841, var_5c6cf7b8db65a693 );
    
    /#
        trigger.debugcolour = ( 1, 0, 0 );
        thread function_9c0c21d25d0722c7( player, trigger, name, origin, radius, var_bbced3a4c056841 );
    #/
}

// Namespace benchmark_mp_utils
// Params 5, eflags: 0x4
// Checksum 0xf0698e27, Offset: 0x157d
// Size: 0xec
function private function_d5486cfc2d0aa2c5( trigger, player, triggercallback, var_bbced3a4c056841, var_5c6cf7b8db65a693 = undefined )
{
    trigger endon( #"delete" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    for ( ;; )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && ent == player )
        {
            trigger notify( #"player_enter_trigger", player );
            
            /#
                trigger.debugcolour = ( 0, 1, 0 );
            #/
            
            if ( isdefined( var_5c6cf7b8db65a693 ) )
            {
                thread [[ triggercallback ]]( player, var_5c6cf7b8db65a693 );
            }
            else
            {
                thread [[ triggercallback ]]( player );
            }
            
            if ( var_bbced3a4c056841 )
            {
                trigger delete();
            }
            else
            {
                thread function_e1e99f170ff0908b( player, trigger, triggercallback, var_5c6cf7b8db65a693 );
            }
            
            break;
        }
    }
}

// Namespace benchmark_mp_utils
// Params 4, eflags: 0x4
// Checksum 0xb6d63719, Offset: 0x1671
// Size: 0xd8
function private function_e1e99f170ff0908b( player, trigger, triggercallback, var_5c6cf7b8db65a693 = undefined )
{
    trigger endon( #"delete" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    playerradius = player physics_getcharactercollisioncapsule()[ "radius" ];
    
    for ( ;; )
    {
        var_3046415a82974a3 = distance( trigger.origin, player.origin );
        
        if ( var_3046415a82974a3 > playerradius + trigger.radius + 5 )
        {
            /#
                trigger.debugcolour = ( 1, 0, 0 );
            #/
            
            thread function_d5486cfc2d0aa2c5( trigger, player, triggercallback, 0, var_5c6cf7b8db65a693 );
            break;
        }
        
        waitframe();
    }
}

// Namespace benchmark_mp_utils
// Params 0
// Checksum 0xa764f437, Offset: 0x1751
// Size: 0x28
function function_2544b8c262fb0f68()
{
    setomnvarforallclients( "post_game_state", 0 );
    function_1575e6db0bcbad11( 1 );
    wait 1.2;
    setomnvar( "ui_show_benchmark_report", 1 );
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0xfd1ea45b, Offset: 0x1781
// Size: 0x2c9
function function_1d4329e5a1e40b20( var_a24e09134b4e72 )
{
    if ( isdefined( level.var_6a29bf5ccb6a9fe5 ) && level.var_6a29bf5ccb6a9fe5.size > 0 )
    {
        assertmsg( "<dev string:xaf>" );
        return;
    }
    
    level.var_5a7122875ed48e7f = [];
    level.var_6a29bf5ccb6a9fe5 = [];
    level.var_90c5504ae27dcda9 = [];
    level.var_a8589eb8e39aee9 = 0;
    
    /#
        level.var_9812c0e87e1960c6 = [];
    #/
    
    foreach ( enemy_group, enemy_array in var_a24e09134b4e72 )
    {
        /#
            level.var_9812c0e87e1960c6[ string( enemy_group ) ] = 0;
        #/
        
        var_a26a91ae80135418 = 0;
        
        foreach ( struct_array in enemy_array )
        {
            if ( struct_array.size > 0 && !struct_array[ 0 ].non_player_death )
            {
                struct_array[ 0 ].var_a26a91ae80135418 = var_a26a91ae80135418;
                var_a26a91ae80135418++;
            }
            
            for ( j = 0; j < struct_array.size ; j++ )
            {
                struct = struct_array[ j ];
                
                if ( j + 1 < struct_array.size )
                {
                    struct.target = struct_array[ j + 1 ].targetname;
                }
            }
        }
    }
    
    var_fca64981f6a15d77 = [];
    
    foreach ( group, enemy_struct_array in var_a24e09134b4e72 )
    {
        var_fca64981f6a15d77[ group ] = [];
        
        foreach ( struct_array in enemy_struct_array )
        {
            var_fca64981f6a15d77[ group ][ var_fca64981f6a15d77[ group ].size ] = struct_array[ 0 ];
        }
    }
    
    level.var_6a29bf5ccb6a9fe5 = var_fca64981f6a15d77;
}

// Namespace benchmark_mp_utils
// Params 9
// Checksum 0x6a4c747a, Offset: 0x1a52
// Size: 0x176
function function_1d8f6f11879b79a5( targetname, origin, angles, non_player_death = 0, var_ac7168b74c37be45 = 0, var_24f5ddfc05b0982 = "stand", movement_speed = 160, ai_spawn_function = &basic_agent, vo_info_struct = undefined )
{
    script_struct = spawn( "script_origin", origin );
    script_struct.targetname = targetname;
    script_struct.origin = origin;
    script_struct.angles = angles;
    script_struct.goalradius = 3;
    script_struct.modelscale = "1";
    script_struct.script_parameters = var_24f5ddfc05b0982;
    script_struct.script_forcegoal = 1;
    script_struct.var_ac7168b74c37be45 = var_ac7168b74c37be45;
    script_struct.non_player_death = non_player_death;
    script_struct.movement_speed = movement_speed;
    
    if ( non_player_death )
    {
        script_struct.var_a26a91ae80135418 = -1;
    }
    else
    {
        script_struct.var_a26a91ae80135418 = -9999;
    }
    
    script_struct.ai_spawn_function = ai_spawn_function;
    script_struct.vo_info_struct = vo_info_struct;
    return script_struct;
}

// Namespace benchmark_mp_utils
// Params 4
// Checksum 0x744b1ac7, Offset: 0x1bd1
// Size: 0x340
function function_e1dbf0f401a5e201( targetname, body_model = undefined, head_model = undefined, hat_model = undefined )
{
    assert( isdefined( targetname ) );
    var_fca64981f6a15d77 = level.var_6a29bf5ccb6a9fe5[ targetname ];
    
    if ( !isdefined( var_fca64981f6a15d77 ) || var_fca64981f6a15d77.size == 0 )
    {
        assertmsg( "<dev string:xdf>" + targetname );
        return;
    }
    
    var_12fecbbf66ea0686 = undefined;
    var_d6b651ee3c4dd919 = -1;
    enemy_struct_array = [];
    
    foreach ( agentstruct in var_fca64981f6a15d77 )
    {
        agent = undefined;
        
        if ( isdefined( agentstruct.ai_spawn_function ) )
        {
            agent = [[ agentstruct.ai_spawn_function ]]( agentstruct, body_model, head_model, hat_model );
        }
        else
        {
            agent = basic_agent( agentstruct, body_model, head_model, hat_model );
        }
        
        if ( isdefined( agentstruct.vo_info_struct ) )
        {
            thread function_8cc9c9da58868fb2( level.player, agent, agentstruct.vo_info_struct.alias, agentstruct.vo_info_struct.wait_time, agentstruct.vo_info_struct.percentage );
        }
        
        agent.var_a26a91ae80135418 = agentstruct.var_a26a91ae80135418;
        agent.agent_damage_callback = &function_2d459ce49ce8b45e;
        level.var_90c5504ae27dcda9[ level.var_90c5504ae27dcda9.size ] = agent;
        
        if ( isdefined( agentstruct.target ) || agent.ignore_player_completely )
        {
            agent.ignoreme = 1;
            agent.ignoreall = 1;
        }
        
        if ( !isdefined( agentstruct.modelscale ) )
        {
            agentstruct.modelscale = "1";
        }
        
        if ( !isdefined( agentstruct.goalradius ) )
        {
            agentstruct.goalradius = 3;
        }
        
        if ( !isdefined( agentstruct.var_ac7168b74c37be45 ) || agentstruct.var_ac7168b74c37be45 < 0 )
        {
            agentstruct.var_ac7168b74c37be45 = 0;
        }
        
        utility::delaythread( agentstruct.var_ac7168b74c37be45, &function_922b6e5e519c6302, agent, agentstruct );
        
        /#
            thread function_dc39bc4458611a3f( agent, agentstruct.var_a26a91ae80135418 );
        #/
        
        enemy_struct_array[ enemy_struct_array.size ] = agentstruct;
        agentstruct.enemy_ref = agent;
        thread function_5b4ddf719f1a4604( agent, agentstruct );
        
        if ( agentstruct.var_a26a91ae80135418 != -1 && agentstruct.var_a26a91ae80135418 >= var_d6b651ee3c4dd919 )
        {
            var_d6b651ee3c4dd919 = agentstruct.var_a26a91ae80135418;
            var_12fecbbf66ea0686 = agent;
        }
    }
    
    if ( isdefined( var_12fecbbf66ea0686 ) )
    {
        level.var_5a7122875ed48e7f[ level.var_5a7122875ed48e7f.size ] = enemy_struct_array;
        thread function_1e1cda259caa52be( var_12fecbbf66ea0686 );
    }
}

// Namespace benchmark_mp_utils
// Params 4
// Checksum 0xd7d04b56, Offset: 0x1f19
// Size: 0x137
function basic_agent( agentstruct, body_model = undefined, head_model = undefined, hat_model = undefined )
{
    agent = mp_agent::spawnnewagentaitype( level.var_178a5d26de1a42ca.enemy_agent_type ? level.var_178a5d26de1a42ca.enemy_agent_type : "enemy_mp_benchmark_base", agentstruct.origin, agentstruct.angles );
    agent.health = 1;
    agent.disablebulletwhizbyreaction = 1;
    agent setcanusecover( 0 );
    agent.runngunenabled = 0;
    agent.disabledodge = 1;
    agent.aggressivemode = 0;
    agent.favoriteenemy = level.player;
    agent.allowlongdeath = 0;
    agent.var_1bf926518b0cb33 = 1;
    agent utility::set_movement_speed( agentstruct.movement_speed );
    function_95efd1fa46b6e839( agent, body_model, head_model, hat_model );
    return agent;
}

// Namespace benchmark_mp_utils
// Params 6
// Checksum 0xb83ae04c, Offset: 0x2059
// Size: 0x192
function function_50caa57b4077d26f( origin, angles, var_dc2b082141996a1, body_model = undefined, head_model = undefined, hat_model = undefined )
{
    agent = mp_agent::spawnnewagentaitype( level.var_178a5d26de1a42ca.enemy_agent_type ? level.var_178a5d26de1a42ca.enemy_agent_type : " enemy_mp_benchmark_base", origin, angles );
    
    if ( !isdefined( agent ) )
    {
        assertmsg( "<dev string:x11b>" );
        return;
    }
    
    if ( var_dc2b082141996a1 )
    {
        agent shared::dropaiweapon();
    }
    
    agent enabletraversals( 0 );
    agent.dontevershoot = 1;
    agent.bt.cannotmelee = 1;
    agent utility::set_movement_speed( 0 );
    agent enabletraversals( 0 );
    agent allowedstances( "stand" );
    agent.aggressivemode = 0;
    agent function_2ef9eb3349906d00( 600 );
    agent.favoriteenemy = undefined;
    agent.ignoreme = 1;
    agent.ignoreall = 1;
    agent.disablebulletwhizbyreaction = 1;
    agent setcanusecover( 0 );
    agent.runngunenabled = 0;
    agent.disabledodge = 1;
    agent.scripted_mode = 1;
    function_95efd1fa46b6e839( agent, body_model, head_model, hat_model );
    return agent;
}

// Namespace benchmark_mp_utils
// Params 4, eflags: 0x4
// Checksum 0xb1e703ce, Offset: 0x21f4
// Size: 0xeb
function private function_95efd1fa46b6e839( agent, body_model = undefined, head_model = undefined, hat_model = undefined )
{
    if ( isdefined( head_model ) )
    {
        if ( isdefined( agent.headmodel ) )
        {
            agent detach( agent.headmodel );
            agent.headmodel = undefined;
        }
        
        agent attach( head_model, "", 1 );
        agent.headmodel = head_model;
    }
    
    if ( isdefined( hat_model ) )
    {
        if ( isdefined( agent.hatmodel ) )
        {
            agent detach( agent.hatmodel );
            agent.hatmodel = undefined;
        }
        
        agent attach( hat_model, "", 1 );
        agent.hatmodel = hat_model;
    }
    
    if ( isdefined( body_model ) )
    {
        agent setmodel( body_model );
    }
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0x51ab17b9, Offset: 0x22e7
// Size: 0x2da
function function_db2483a05fc6044( weapon_model )
{
    if ( !level.player )
    {
        return;
    }
    
    if ( level.var_5a7122875ed48e7f.size == 0 )
    {
        assertmsg( "<dev string:x151>" );
        return;
    }
    
    var_93cafb300142975e = level.var_5a7122875ed48e7f[ 0 ];
    var_d46dcd6cc51dde2e = undefined;
    
    foreach ( enemy_struct in var_93cafb300142975e )
    {
        if ( !isdefined( enemy_struct ) )
        {
            assertmsg( "<dev string:x1a9>" );
            continue;
        }
        
        if ( isdefined( enemy_struct.var_a26a91ae80135418 ) && enemy_struct.var_a26a91ae80135418 != -9999 )
        {
            if ( enemy_struct.var_a26a91ae80135418 == level.var_a8589eb8e39aee9 )
            {
                var_d46dcd6cc51dde2e = enemy_struct.enemy_ref;
                break;
            }
            
            continue;
        }
        
        assertmsg( "<dev string:x1e9>" );
    }
    
    if ( isdefined( var_d46dcd6cc51dde2e ) )
    {
        if ( utility::is_dead_or_dying( var_d46dcd6cc51dde2e ) )
        {
            assertmsg( "<dev string:x250>" );
        }
        
        bullet_start_origin = level.player.origin + ( 0, 0, 35 );
        muzzle_vfx = utility::getfx( "vfx_muzzle_flash" );
        
        if ( isdefined( weapon_model ) && isdefined( muzzle_vfx ) && muzzle_vfx != 0 )
        {
            if ( modelhastag( weapon_model.model, "tag_flash" ) )
            {
                playfxontag( muzzle_vfx, weapon_model, "tag_flash" );
                bullet_start_origin = weapon_model gettagorigin( "tag_flash" );
            }
            else
            {
                playfx( muzzle_vfx, bullet_start_origin );
            }
        }
        
        bullet_end_origin = var_d46dcd6cc51dde2e gettagorigin( "tag_eye" );
        
        if ( isdefined( level.var_178a5d26de1a42ca.player_weapon ) )
        {
            magicbullet( level.var_178a5d26de1a42ca.player_weapon, bullet_start_origin, bullet_end_origin, level.player, undefined, undefined, 1, 1 );
        }
        
        /#
            thread utility::draw_line_for_time( bullet_start_origin, bullet_end_origin, 0, 1, 0, 3 );
        #/
        
        isenemydead = 0;
        
        if ( utility::is_dead_or_dying( var_d46dcd6cc51dde2e ) )
        {
            isenemydead = 1;
            iprintlnbold( "KILL!" );
        }
        else if ( function_1213863ac8d76692() )
        {
            iprintlnbold( "MISS!" );
        }
        else
        {
            thread validate_death( var_d46dcd6cc51dde2e );
        }
        
        if ( level.death_sounds )
        {
            playsoundatpos( bullet_end_origin, utility::array_random( level.death_sounds ) );
        }
        
        if ( !function_1213863ac8d76692() || isenemydead )
        {
            level.var_a8589eb8e39aee9++;
        }
        
        return;
    }
    
    assertmsg( "<dev string:x288>" );
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0x61ca1481, Offset: 0x25c9
// Size: 0x43
function validate_death( enemy )
{
    level endon( #"game_ended" );
    wait 0.5;
    
    if ( utility::is_dead_or_dying( enemy ) )
    {
        iprintlnbold( "KILL!" );
        return;
    }
    
    assertmsg( "<dev string:x2cd>" );
}

// Namespace benchmark_mp_utils
// Params 1
// Checksum 0xe93325be, Offset: 0x2614
// Size: 0x157
function player_fireweapon( weapon_model )
{
    if ( !level.player )
    {
        return;
    }
    
    bullet_start_origin = level.player.origin + ( 0, 0, 35 );
    muzzle_vfx = utility::getfx( "vfx_muzzle_flash" );
    
    if ( isdefined( weapon_model ) && isdefined( muzzle_vfx ) && muzzle_vfx != 0 )
    {
        if ( modelhastag( weapon_model.model, "tag_flash" ) )
        {
            playfxontag( muzzle_vfx, weapon_model, "tag_flash" );
            bullet_start_origin = weapon_model gettagorigin( "tag_flash" );
        }
        else
        {
            playfx( muzzle_vfx, bullet_start_origin );
        }
    }
    
    bullet_end_origin = level.glass_shoot_points[ 0 ];
    
    if ( isdefined( level.var_178a5d26de1a42ca.player_weapon ) )
    {
        magicbullet( level.var_178a5d26de1a42ca.player_weapon, bullet_start_origin, bullet_end_origin, level.player, undefined, undefined, 1, 1 );
        glassradiusdamage( bullet_end_origin, 35, 35, 35 );
        
        /#
            thread utility::draw_line_for_time( bullet_start_origin, bullet_end_origin, 0, 1, 0, 993 );
        #/
        
        level.glass_shoot_points[ 0 ] = undefined;
        
        if ( isint( 0 ) )
        {
            function_cdc669dbc8ea2101( level.glass_shoot_points );
        }
    }
    
    /#
        thread utility::draw_line_for_time( bullet_start_origin, bullet_end_origin, 0, 1, 0, 3 );
    #/
}

// Namespace benchmark_mp_utils
// Params 2, eflags: 0x4
// Checksum 0xc3163c38, Offset: 0x2773
// Size: 0x28
function private function_922b6e5e519c6302( agent, agentstruct )
{
    agent thread ai_behavior::function_d51a816fd9f14805( agentstruct );
    agent thread function_c1fb4529e03f8861();
}

// Namespace benchmark_mp_utils
// Params 14, eflags: 0x4
// Checksum 0xadc2fa60, Offset: 0x27a3
// Size: 0xbf
function private function_2d459ce49ce8b45e( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    is_player_kill = self.var_a26a91ae80135418 != -1;
    
    if ( is_player_kill && einflictor != level.player && !utility::isbulletdamage( smeansofdeath ) )
    {
        return 0;
    }
    
    return idamage;
}

// Namespace benchmark_mp_utils
// Params 2, eflags: 0x4
// Checksum 0xe9823fa6, Offset: 0x286b
// Size: 0x2e
function private function_5b4ddf719f1a4604( enemy, spawn_struct )
{
    enemy waittill( #"death" );
    spawn_struct.enemy_ref = undefined;
}

// Namespace benchmark_mp_utils
// Params 0, eflags: 0x4
// Checksum 0x966524c4, Offset: 0x28a1
// Size: 0xb3
function private function_c1fb4529e03f8861()
{
    self endon( #"death" );
    self waittill( #"reached_path_end" );
    utility::set_movement_speed( 0 );
    
    if ( !self.ignore_player_completely )
    {
        self.ignoreme = 0;
        self.ignoreall = 0;
    }
    
    self.baimedataimtarget = 1;
    
    if ( isdefined( self.currentnode ) && arraycontains( [ "stand", "crouch", "prone" ], self.currentnode.script_parameters ) )
    {
        self allowedstances( self.currentnode.script_parameters );
    }
    
    thread function_ee65f9df88b12cf9();
}

// Namespace benchmark_mp_utils
// Params 0, eflags: 0x4
// Checksum 0x732a512e, Offset: 0x295c
// Size: 0x1b9
function private function_ee65f9df88b12cf9()
{
    if ( !level.player )
    {
        return;
    }
    
    level endon( #"used_nuke" );
    self endon( #"death" );
    level.player endon( #"disconnect" );
    wait_array = [];
    index = 0;
    
    if ( isdefined( self.shoot_wait_array ) )
    {
        wait_array = self.shoot_wait_array;
    }
    else
    {
        wait_array = [ 0.4, 0.2, 0.1 ];
    }
    
    while ( isalive( self ) && level.player )
    {
        if ( self tagexists( "tag_flash" ) == 0 )
        {
            return;
        }
        
        start = self gettagorigin( "tag_flash" );
        end = level.player geteye();
        gun_forward = anglestoforward( self gettagangles( "tag_flash" ) );
        agent_to_player = vectornormalize( end - start );
        
        if ( function_1e92dba6b31be0d6( gun_forward, agent_to_player ) || self.var_6af0f1ba5e03f52b )
        {
            if ( !self.var_897ef656605d4cc3 )
            {
                var_47da99db0bfbb09c = self gettagangles( "tag_flash" );
                muzzle_vfx = utility::getfx( "vfx_muzzle_flash" );
                
                if ( isdefined( muzzle_vfx ) && muzzle_vfx != 0 )
                {
                    playfx( muzzle_vfx, start, anglestoforward( var_47da99db0bfbb09c ), anglestoup( var_47da99db0bfbb09c ) );
                }
                
                magicbullet( self.primaryweapon, start, end + ( -20, 0, 0 ), self );
            }
            else
            {
                self shoot();
            }
            
            wait wait_array[ index % wait_array.size ];
            index++;
            continue;
        }
        
        wait 0.05;
    }
}

// Namespace benchmark_mp_utils
// Params 1, eflags: 0x4
// Checksum 0x4e52a5ce, Offset: 0x2b1d
// Size: 0x7b
function private function_1e1cda259caa52be( var_72fef578c615a7df )
{
    if ( !isdefined( var_72fef578c615a7df ) )
    {
        assertmsg( "<dev string:x2db>" );
        return;
    }
    
    var_72fef578c615a7df waittill( #"death" );
    
    if ( level.var_5a7122875ed48e7f.size > 0 )
    {
        level.var_5a7122875ed48e7f[ 0 ] = undefined;
        function_cdc669dbc8ea2101( level.var_5a7122875ed48e7f );
        level.var_a8589eb8e39aee9 = 0;
        iprintlnbold( "Last enemy in group killed" );
        return;
    }
    
    assertmsg( "<dev string:x304>" );
}

// Namespace benchmark_mp_utils
// Params 2, eflags: 0x4
// Checksum 0xdc9caf15, Offset: 0x2ba0
// Size: 0x3a, Type: bool
function private function_1e92dba6b31be0d6( gun_forward, var_462ecf9e2a6e896b )
{
    max_angle = 12;
    var_4f92e93903b38c5f = math::anglebetweenvectors( gun_forward, var_462ecf9e2a6e896b );
    return var_4f92e93903b38c5f < max_angle;
}

/#

    // Namespace benchmark_mp_utils
    // Params 2, eflags: 0x4
    // Checksum 0x4883ff27, Offset: 0x2be3
    // Size: 0xa2, Type: dev
    function private function_dc39bc4458611a3f( agent, var_611c4b63cc4ec4d3 )
    {
        agent endon( #"death" );
        level.player endon( #"death_or_disconnect" );
        
        if ( !isdefined( var_611c4b63cc4ec4d3 ) )
        {
            var_611c4b63cc4ec4d3 = "<dev string:x31f>";
        }
        
        if ( var_611c4b63cc4ec4d3 == -1 )
        {
            var_611c4b63cc4ec4d3 = "<dev string:x33f>";
        }
        else if ( var_611c4b63cc4ec4d3 == -9999 )
        {
            var_611c4b63cc4ec4d3 = "<dev string:x350>";
        }
        
        while ( true )
        {
            textposition = agent gettagorigin( "<dev string:x370>" );
            print3d( textposition, var_611c4b63cc4ec4d3, ( 1, 0, 0 ), 1, 1, 1 );
            waitframe();
        }
    }

    // Namespace benchmark_mp_utils
    // Params 1
    // Checksum 0xb114581, Offset: 0x2c8d
    // Size: 0x17d, Type: dev
    function function_5417055af82bab24( player )
    {
        level endon( #"game_ended" );
        player endon( #"death_or_disconnect" );
        buttondown = 0;
        
        while ( true )
        {
            var_6fc71a3bb30db666 = getdvarint( @"hash_eb1fe583508df55f", 0 ) == 1;
            
            if ( var_6fc71a3bb30db666 && player buttonpressed( "<dev string:x378>" ) )
            {
                if ( !buttondown )
                {
                    if ( isdefined( level.var_5a7122875ed48e7f ) && level.var_5a7122875ed48e7f.size > 0 )
                    {
                        function_db2483a05fc6044( undefined );
                    }
                }
                
                buttondown = 1;
            }
            else
            {
                buttondown = 0;
            }
            
            if ( function_1213863ac8d76692() && var_6fc71a3bb30db666 && isdefined( level.var_9812c0e87e1960c6 ) )
            {
                i = 1;
                
                foreach ( enemy_group_name, var_e628cd58f5934155 in level.var_9812c0e87e1960c6 )
                {
                    if ( player buttonpressed( string( i ) ) )
                    {
                        if ( !var_e628cd58f5934155 )
                        {
                            function_e1dbf0f401a5e201( enemy_group_name );
                        }
                        
                        level.var_9812c0e87e1960c6[ enemy_group_name ] = 1;
                        break;
                    }
                    else
                    {
                        level.var_9812c0e87e1960c6[ enemy_group_name ] = 0;
                    }
                    
                    i++;
                }
            }
            
            waitframe();
        }
    }

    // Namespace benchmark_mp_utils
    // Params 6, eflags: 0x4
    // Checksum 0x319dea83, Offset: 0x2e12
    // Size: 0x106, Type: dev
    function private function_9c0c21d25d0722c7( player, trigger, name, origin, radius, var_bbced3a4c056841 )
    {
        trigger endon( #"delete" );
        level endon( #"game_ended" );
        player endon( #"disconnect" );
        
        if ( var_bbced3a4c056841 )
        {
            trigger endon( #"player_enter_trigger" );
        }
        
        for ( ;; )
        {
            if ( !isdefined( trigger ) )
            {
                break;
            }
            
            textscale = 1;
            
            if ( getdvarint( @"hash_90dfd1b7dc84670e", 0 ) == 1 )
            {
                sphere( origin, radius, trigger.debugcolour, 0, 1 );
            }
            else
            {
                textscale = 0.5;
                line( origin, origin + ( 0, 0, 30 ), trigger.debugcolour, 1, 0, 1 );
            }
            
            print3d( origin, name, trigger.debugcolour, 1, textscale, 1, 1 );
            waitframe();
        }
    }

    // Namespace benchmark_mp_utils
    // Params 1
    // Checksum 0x7c15de2a, Offset: 0x2f20
    // Size: 0xc4, Type: dev
    function function_f4bbfeaac557412c( player )
    {
        level endon( #"game_ended" );
        player endon( #"hash_93019aa57580b71" );
        sfx_file = "<dev string:x37d>";
        buttondown = 0;
        
        while ( true )
        {
            if ( player buttonpressed( "<dev string:x394>" ) )
            {
                if ( !buttondown )
                {
                    fileid = openfile( sfx_file, "<dev string:x39a>" );
                    
                    if ( fileid == -1 )
                    {
                        fileid = openfile( sfx_file, "<dev string:x39f>" );
                        closefile( fileid );
                    }
                    else
                    {
                        filecontent = function_34c9c07bc2a5ff96( fileid );
                        function_8cc9c9da58868fb2( player, undefined, filecontent, 1 );
                        closefile( fileid );
                    }
                    
                    buttondown = 1;
                }
            }
            else
            {
                buttondown = 0;
            }
            
            waitframe();
        }
    }

    // Namespace benchmark_mp_utils
    // Params 1
    // Checksum 0x8f7f2b63, Offset: 0x2fec
    // Size: 0x69, Type: dev
    function validateplayer( player )
    {
        if ( !isdefined( player ) )
        {
            if ( isdefined( level.player ) )
            {
                player = level.player;
            }
            else
            {
                while ( true )
                {
                    level waittill( #"player_spawned", spawned_player );
                    
                    if ( !isplayer( spawned_player ) )
                    {
                        continue;
                    }
                    
                    player = spawned_player;
                    break;
                }
            }
        }
        
        return player;
    }

    // Namespace benchmark_mp_utils
    // Params 1
    // Checksum 0xd3f3de13, Offset: 0x305d
    // Size: 0x2dc, Type: dev
    function function_309c07effd44c8f1( player )
    {
        if ( !isdefined( player ) )
        {
            player = undefined;
        }
        
        setdevdvar( @"scr_devchangetimelimit", 0 );
        setdvar( @"scr_skip_infils", 1 );
        setdvar( @"scr_game_graceperiod", 0 );
        setdvar( @"scr_game_matchstarttime", 0 );
        setdvar( @"scr_game_disableannouncer", 1 );
        setdvar( @"hash_2a4f08bc79265550", 1 );
        setdvar( @"player_sustainammo", 1 );
        setdvar( @"hash_256c32636f3dcef2", 1 );
        setdvarifuninitialized( @"hash_f2571c58dbe1ba35", 0 );
        
        if ( !isdefined( level.player ) )
        {
            if ( isdefined( player ) )
            {
                level.player = player;
            }
            else
            {
                level.player = validateplayer( level.player );
                player = level.player;
            }
        }
        
        player.team = "<dev string:x3a5>";
        player.safefromnuke = 1;
        player.magic_bullet_shield = 1;
        player allowmovement( 1 );
        player allowfire( 1 );
        player allowjump( 1 );
        player allowmelee( 1 );
        player allowsprint( 1 );
        player enableoffhandweapons();
        player enableoffhandprimaryweapons();
        player enableoffhandsecondaryweapons();
        player enableoffhandspecialweapons();
        adddebugcommand( "<dev string:x3ac>" );
        function_6d778e3befe26811();
        function_e921e44aeeb73adb( player );
        function_e1cdfa3757e33d27();
        thread namespace_a4e869218d89862b::function_18eb5a324873d647( player, 0 );
        namespace_a4e869218d89862b::function_f0396df5e1bddae9( &function_22c8c7c8bfb69023 );
        thread namespace_6826532b84b72321::function_eccd82ae06166efe( player, 0 );
        namespace_65874e704742c645::function_b4d340c670f105dd();
        function_22c8c7c8bfb69023( player );
        namespace_6826532b84b72321::function_b42a7f4dd13597d5( &function_22c8c7c8bfb69023 );
        available_perks = player perks::getavailableperks();
        
        foreach ( perkname in available_perks )
        {
            if ( perks::function_ae69f867e887ac4a( perkname ) )
            {
                player perk::giveperk( perkname );
            }
        }
        
        namespace_4517d7469a87050b::function_90114e43914d1001( "<dev string:x3b0>", "<dev string:x3c2>", "<dev string:x3de>", &namespace_1fd4452aa332cfa1::function_af8076a398f00983, &namespace_1fd4452aa332cfa1::function_b0ecf413fdb8413e );
        namespace_4517d7469a87050b::function_90114e43914d1001( "<dev string:x3e3>", "<dev string:x3f5>", "<dev string:x3de>", &namespace_a4e869218d89862b::function_516c60097c3c8f11, &namespace_a4e869218d89862b::function_7361c9ea28191f1f, &namespace_a4e869218d89862b::function_3c5088361ceee0f4 );
        namespace_4517d7469a87050b::function_90114e43914d1001( "<dev string:x40d>", "<dev string:x423>", "<dev string:x3de>", &namespace_6826532b84b72321::function_6dc927311172d69, &namespace_6826532b84b72321::function_c3cf4ac7c2003e80 );
        namespace_4517d7469a87050b::function_90114e43914d1001( "<dev string:x43f>", "<dev string:x45a>", "<dev string:x3de>", &namespace_65874e704742c645::function_5a5281810874254f, &namespace_65874e704742c645::function_bc8c91f3b418514a, &namespace_65874e704742c645::function_2db5ebdfbe0ed451 );
        namespace_4517d7469a87050b::function_8c0c83920890aa02();
    }

    // Namespace benchmark_mp_utils
    // Params 1
    // Checksum 0x4bb99b9e, Offset: 0x3341
    // Size: 0xe4, Type: dev
    function function_e921e44aeeb73adb( player )
    {
        function_58455b481846aefc( "<dev string:x47b>", "<dev string:x48c>", &function_a4e58f745509cd1d, [ "<dev string:x49c>" ] );
        function_58455b481846aefc( "<dev string:x49f>", "<dev string:x48c>", &function_f935ed3c639215ed, [ "<dev string:x4b1>" ] );
        function_58455b481846aefc( "<dev string:x4b4>", "<dev string:x48c>", &function_6f4cc32a47b35564, [ "<dev string:x4c2>" ] );
        function_58455b481846aefc( "<dev string:x4c4>", "<dev string:x48c>", &function_6d90b52e7f66709a, [ "<dev string:x4df>" ] );
        function_58455b481846aefc( "<dev string:x4e6>", "<dev string:x48c>", &function_6cf247353c5bcf3, [ "<dev string:x394>" ] );
        function_58455b481846aefc( "<dev string:x506>", "<dev string:x48c>", &function_a7dd34380de169ca );
        function_58455b481846aefc( "<dev string:x51a>", "<dev string:x48c>", &function_6d778e3befe26811 );
        function_abeeb86ec4c08184( player );
    }

    // Namespace benchmark_mp_utils
    // Params 0
    // Checksum 0x482af7f4, Offset: 0x342d
    // Size: 0xf, Type: dev
    function function_a7dd34380de169ca()
    {
        adddebugcommand( "<dev string:x52a>" );
    }

    // Namespace benchmark_mp_utils
    // Params 0
    // Checksum 0xbcdd9bdb, Offset: 0x3444
    // Size: 0x19, Type: dev
    function function_6d778e3befe26811()
    {
        adddebugcommand( "<dev string:x538>" );
        adddebugcommand( "<dev string:x54b>" );
    }

    // Namespace benchmark_mp_utils
    // Params 0
    // Checksum 0xc863b, Offset: 0x3465
    // Size: 0x76, Type: dev
    function function_6d90b52e7f66709a()
    {
        player = level.player;
        player_origin = player getorigin();
        string_position = "<dev string:x55f>" + int( player_origin[ 0 ] ) + "<dev string:x561>" + int( player_origin[ 1 ] ) + "<dev string:x561>" + int( player_origin[ 2 ] ) + "<dev string:x564>";
        function_3bc604f9c0efa918( string_position );
        iprintlnbold( "<dev string:x566>" );
    }

    // Namespace benchmark_mp_utils
    // Params 0
    // Checksum 0x8ba491eb, Offset: 0x34e3
    // Size: 0x117, Type: dev
    function function_6cf247353c5bcf3()
    {
        player = level.player;
        start = player geteye();
        end = start + vectornormalize( anglestoforward( player getplayerangles() ) ) * 2000;
        raycast_results = physics_raycast( start, end, trace::create_default_contents(), player, 0, "<dev string:x58b>" );
        var_87c2f2b6e964f3d6 = raycast_results.size > 0 && isdefined( raycast_results[ 0 ][ "<dev string:x5a0>" ] );
        
        if ( var_87c2f2b6e964f3d6 )
        {
            display_time = 15;
            hit_position = raycast_results[ 0 ][ "<dev string:x5a0>" ];
            hit_position = ( int( hit_position[ 0 ] ), int( hit_position[ 1 ] ), int( hit_position[ 2 ] ) );
            thread debug::sphere( hit_position, 20, ( 0, 1, 0 ), display_time );
            thread debug::print3d( hit_position, "<dev string:x5a9>" + hit_position, ( 1, 0, 0 ), display_time, undefined, undefined, 1, 0.7 );
            function_3bc604f9c0efa918( hit_position );
            iprintlnbold( "<dev string:x5b2>" );
        }
    }

    // Namespace benchmark_mp_utils
    // Params 1, eflags: 0x4
    // Checksum 0x1340145b, Offset: 0x3602
    // Size: 0xbe, Type: dev
    function private function_22c8c7c8bfb69023( player )
    {
        namespace_65874e704742c645::function_a1d4c1249f95b42e();
        function_79d37959141dbed8( "<dev string:x5cf>", "<dev string:x5da>", &debug_nuke );
        function_79d37959141dbed8( "<dev string:x5df>", "<dev string:x5eb>", &debug_tomastrike );
        function_79d37959141dbed8( "<dev string:x5f9>", "<dev string:x604>", &debug_nighthawk );
        function_79d37959141dbed8( "<dev string:x60e>", "<dev string:x620>", &function_7ab5e06e3494c1ce );
        function_79d37959141dbed8( "<dev string:x632>", "<dev string:x644>", &function_da39e8192d763d93 );
        function_79d37959141dbed8( "<dev string:x656>", "<dev string:x667>", &function_35b4ac7104c8bfcd );
        function_79d37959141dbed8( "<dev string:x678>", "<dev string:x683>", &function_c2cb31c55c34271 );
        function_7b08e36f08cf3c1();
        function_569c6ff061098eba();
    }

    // Namespace benchmark_mp_utils
    // Params 3, eflags: 0x4
    // Checksum 0xcca76e7e, Offset: 0x36c8
    // Size: 0x36, Type: dev
    function private function_79d37959141dbed8( streakname, displayname, callback )
    {
        if ( killstreaks::function_b5fe8b8e8c5ce798( streakname ) )
        {
            namespace_65874e704742c645::function_c99d3717aef15779( displayname, callback );
        }
    }

    // Namespace benchmark_mp_utils
    // Params 0, eflags: 0x4
    // Checksum 0xbc27f9fe, Offset: 0x3706
    // Size: 0x361, Type: dev
    function private function_e1cdfa3757e33d27()
    {
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x68e>", "<dev string:x695>", ( 0, 0, 0 ) );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x68e>", "<dev string:x6a3>", "<dev string:x6af>" );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x68e>", "<dev string:x6b4>", "<dev string:x6bc>" );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x6c2>", "<dev string:x6c5>", 100 );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x5da>", "<dev string:x6cc>", 10 );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x5da>", "<dev string:x6dd>", ( 0, 0, 0 ) );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x6ef>", "<dev string:x6fd>", ( 0, 0, 0 ) );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x6ef>", "<dev string:x706>", 2500 );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x6ef>", "<dev string:x70d>", 0 );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x5eb>", "<dev string:x6fd>", ( 0, 0, 0 ) );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x5eb>", "<dev string:x717>", 200 );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x5eb>", "<dev string:x724>", 15 );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x5eb>", "<dev string:x734>", 0.7 );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x5eb>", "<dev string:x74d>", 0 );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x604>", "<dev string:x6fd>", ( 0, 0, 0 ) );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x604>", "<dev string:x759>", 200 );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x604>", "<dev string:x706>", 3000 );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x604>", "<dev string:x70d>", 0 );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x620>", "<dev string:x75f>", ( 1000, 1000, 5000 ) );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x620>", "<dev string:x76d>", ( 0, 0, 0 ) );
        namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x620>", "<dev string:x759>", 200 );
        
        if ( killstreaks::function_b5fe8b8e8c5ce798( "<dev string:x632>" ) )
        {
            namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x644>", "<dev string:x6fd>", ( 0, 0, 0 ) );
            namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x644>", "<dev string:x779>", 0 );
            namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x644>", "<dev string:x786>", 0 );
        }
        
        if ( killstreaks::function_b5fe8b8e8c5ce798( "<dev string:x656>" ) )
        {
            namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x667>", "<dev string:x6fd>", ( 0, 0, 0 ) );
            namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x667>", "<dev string:x779>", 0 );
        }
        
        if ( killstreaks::function_b5fe8b8e8c5ce798( "<dev string:x678>" ) )
        {
            namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x683>", "<dev string:x6fd>", ( 0, 0, 0 ) );
            namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x683>", "<dev string:x790>", level.var_7ad4199154e6fc90.initialradius ?? 4000 );
            namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x683>", "<dev string:x79c>", level.var_7ad4199154e6fc90.finalradius ?? 800 );
            namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x683>", "<dev string:x7a8>", level.var_7ad4199154e6fc90.var_8bf4ac2a46c4e331 ?? 18 );
            namespace_1fd4452aa332cfa1::function_cf35ac7ba2861345( "<dev string:x683>", "<dev string:x7bd>", level.var_7ad4199154e6fc90.var_8440257504ad2a6a ?? 7 );
        }
        
        namespace_1fd4452aa332cfa1::function_82df6c443205500d( &function_11b5c3e78eff5b44 );
        thread namespace_1fd4452aa332cfa1::function_8293db8aedeb9b3a( "<dev string:x7d2>" );
    }

    // Namespace benchmark_mp_utils
    // Params 0, eflags: 0x4
    // Checksum 0x423987e1, Offset: 0x3a6f
    // Size: 0x71, Type: dev
    function private function_7b08e36f08cf3c1()
    {
        if ( namespace_6826532b84b72321::function_51c7ab8d7da34b21() )
        {
            var_ad8dc4ded175dd8 = namespace_6826532b84b72321::function_4fc61d0fc10f1cd1();
            
            for ( i = 0; i < var_ad8dc4ded175dd8 ; i++ )
            {
                custom_callback_struct = spawnstruct();
                custom_callback_struct.vfx_sequence_index = i;
                namespace_65874e704742c645::function_c99d3717aef15779( "<dev string:x7e9>" + int( i + 1 ), &function_4011f9fe73102411, custom_callback_struct );
            }
        }
    }

    // Namespace benchmark_mp_utils
    // Params 2, eflags: 0x4
    // Checksum 0xaf72b0ef, Offset: 0x3ae8
    // Size: 0x41, Type: dev
    function private function_4011f9fe73102411( player, var_5c6cf7b8db65a693 )
    {
        if ( isdefined( var_5c6cf7b8db65a693 ) && isdefined( var_5c6cf7b8db65a693.vfx_sequence_index ) )
        {
            thread namespace_6826532b84b72321::function_86b322634bc7159c( player, var_5c6cf7b8db65a693.vfx_sequence_index );
        }
    }

    // Namespace benchmark_mp_utils
    // Params 2, eflags: 0x4
    // Checksum 0x394883b6, Offset: 0x3b31
    // Size: 0x3f, Type: dev
    function private function_3a704708f6da8868( player, var_5c6cf7b8db65a693 )
    {
        if ( isdefined( var_5c6cf7b8db65a693 ) && isdefined( var_5c6cf7b8db65a693.agent_group_index ) )
        {
            namespace_a4e869218d89862b::function_699c2ae3a530d919( var_5c6cf7b8db65a693.agent_group_index );
        }
    }

    // Namespace benchmark_mp_utils
    // Params 0, eflags: 0x4
    // Checksum 0x3ae10f95, Offset: 0x3b78
    // Size: 0x73, Type: dev
    function private function_569c6ff061098eba()
    {
        if ( !namespace_a4e869218d89862b::function_f9a574a419cf108c() )
        {
            return;
        }
        
        var_80c7d677ccc85c10 = namespace_a4e869218d89862b::function_afacc4827d5a0c17();
        
        for ( i = 0; i < var_80c7d677ccc85c10 ; i++ )
        {
            custom_callback_struct = spawnstruct();
            custom_callback_struct.agent_group_index = i;
            namespace_65874e704742c645::function_c99d3717aef15779( "<dev string:x7ef>" + int( i + 1 ), &function_3a704708f6da8868, custom_callback_struct );
        }
    }

    // Namespace benchmark_mp_utils
    // Params 1, eflags: 0x4
    // Checksum 0xd98d9c04, Offset: 0x3bf3
    // Size: 0xb8, Type: dev
    function private function_11b5c3e78eff5b44( player )
    {
        spawn_location = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x68e>", "<dev string:x695>", ( 0, 0, 0 ) );
        
        if ( spawn_location != ( 0, 0, 0 ) )
        {
            player setorigin( namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x68e>", "<dev string:x695>", ( 0, 0, 0 ) ) );
        }
        
        if ( namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x68e>", "<dev string:x6a3>", 1 ) )
        {
            player player::hideminimap( 1 );
        }
        else
        {
            player player::showminimap();
        }
        
        player setclientomnvar( "<dev string:x7fa>", namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x68e>", "<dev string:x6b4>", 0 ) );
    }

    // Namespace benchmark_mp_utils
    // Params 1, eflags: 0x4
    // Checksum 0xb97a20ba, Offset: 0x3cb3
    // Size: 0xbc, Type: dev
    function private debug_airstrike( player )
    {
        airstrike_streakinfo = killstreak_utility::createstreakinfo( "<dev string:x806>", player );
        airstrike_streakinfo.targetoverride = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x81a>", "<dev string:x6fd>", ( 0, 0, 0 ) );
        airstrike_streakinfo.planeflyheightoverride = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x81a>", "<dev string:x706>", 1000 );
        airstrike_streakinfo.var_c8000fc9c5002f1e = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x81a>", "<dev string:x824>", 1.6 );
        airstrike_streakinfo.directionyawoverride = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x81a>", "<dev string:x70d>", 0.75 );
        player airstrike::tryuseairstrikefromstruct( airstrike_streakinfo );
    }

    // Namespace benchmark_mp_utils
    // Params 1, eflags: 0x4
    // Checksum 0xbe498649, Offset: 0x3d77
    // Size: 0x89, Type: dev
    function private debug_nuke( player )
    {
        nuke_time = int( namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x5da>", "<dev string:x6cc>", 10 ) );
        
        if ( nuke_time < 3 )
        {
            nuke_time = 3;
        }
        
        nuke_explosionposition = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x5da>", "<dev string:x6dd>", ( 0, 0, 0 ) );
        spawnnuke( player, player.origin + ( 0, 0, 900 ), nuke_explosionposition, nuke_time );
    }

    // Namespace benchmark_mp_utils
    // Params 1, eflags: 0x4
    // Checksum 0xd9159576, Offset: 0x3e08
    // Size: 0xbe, Type: dev
    function private debug_tomastrike( player )
    {
        overrideposition = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x5eb>", "<dev string:x6fd>", ( 0, 0, 0 ) );
        strikeradius = int( namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x5eb>", "<dev string:x717>", 40 ) );
        var_acf68f5b675943d1 = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x5eb>", "<dev string:x724>", 15 );
        var_c2eadb1b75127750 = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x5eb>", "<dev string:x734>", 0.7 );
        launchdelay = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x5eb>", "<dev string:x74d>", 0 );
        player thread toma_strike::function_bc1265319f0001e1( overrideposition, strikeradius, undefined, var_acf68f5b675943d1, var_c2eadb1b75127750, launchdelay );
    }

    // Namespace benchmark_mp_utils
    // Params 1, eflags: 0x4
    // Checksum 0x190f8069, Offset: 0x3ece
    // Size: 0x9a, Type: dev
    function private debug_nighthawk( player )
    {
        origin = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x604>", "<dev string:x6fd>", ( 0, 0, 0 ) );
        angles = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x604>", "<dev string:x70d>", 0 );
        flyheight = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x604>", "<dev string:x706>", 3000 );
        speedoverride = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x604>", "<dev string:x759>", 200 );
        thread auto_drone::function_cf4745ec4a7b893b( player, origin, angles, flyheight, speedoverride );
    }

    // Namespace benchmark_mp_utils
    // Params 1, eflags: 0x4
    // Checksum 0xcd458007, Offset: 0x3f70
    // Size: 0x7b, Type: dev
    function private function_7ab5e06e3494c1ce( player )
    {
        startlocation = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x620>", "<dev string:x75f>", ( 1000, 1000, 5000 ) );
        endlocation = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x620>", "<dev string:x76d>", ( 0, 0, 0 ) );
        speedoverride = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x620>", "<dev string:x759>", 200 );
    }

    // Namespace benchmark_mp_utils
    // Params 1, eflags: 0x4
    // Checksum 0x9d79bd1c, Offset: 0x3ff3
    // Size: 0xf7, Type: dev
    function private function_da39e8192d763d93( player )
    {
        if ( !utility::issharedfuncdefined( #"hash_bf1b3e40625ea04", #"usedirectly" ) )
        {
            return;
        }
        
        location = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x644>", "<dev string:x6fd>", ( 0, 0, 0 ) );
        locationoverride = location != ( 0, 0, 0 ) ? location : undefined;
        launchheight = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x644>", "<dev string:x779>", 0 );
        launchheight = launchheight > 0 ? launchheight : 50;
        drilldist = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x644>", "<dev string:x786>", 0 );
        var_71c1d4739b27b457 = drilldist > 0 ? drilldist : undefined;
        level [[ utility::getsharedfunc( #"hash_bf1b3e40625ea04", #"usedirectly" ) ]]( player, locationoverride, launchheight, var_71c1d4739b27b457 );
    }

    // Namespace benchmark_mp_utils
    // Params 1, eflags: 0x4
    // Checksum 0x3f4b39c8, Offset: 0x40f2
    // Size: 0xca, Type: dev
    function private function_35b4ac7104c8bfcd( player )
    {
        if ( !utility::issharedfuncdefined( #"hash_c17b352b42ff06f", #"usedirectly" ) )
        {
            return;
        }
        
        location = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x667>", "<dev string:x6fd>", ( 0, 0, 0 ) );
        locationoverride = location != ( 0, 0, 0 ) ? location : undefined;
        launchheight = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x667>", "<dev string:x779>", 0 );
        launchheightoverride = launchheight > 0 ? launchheight : undefined;
        level [[ utility::getsharedfunc( #"hash_c17b352b42ff06f", #"usedirectly" ) ]]( player, locationoverride, launchheightoverride );
    }

    // Namespace benchmark_mp_utils
    // Params 1, eflags: 0x4
    // Checksum 0xa5ac7a14, Offset: 0x41c4
    // Size: 0x12f, Type: dev
    function private function_c2cb31c55c34271( player )
    {
        streakinfo = killstreak_utility::createstreakinfo( "<dev string:x678>", player );
        streakinfo.locationoverride = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x683>", "<dev string:x6fd>", ( 0, 0, 0 ) );
        streakinfo.var_6f4deb730c0e1d9c = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x683>", "<dev string:x790>", level.var_7ad4199154e6fc90.initialradius );
        streakinfo.var_c3c4d1c2e7d20554 = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x683>", "<dev string:x79c>", level.var_7ad4199154e6fc90.finalradius );
        streakinfo.var_bc066946c94c8f21 = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x683>", "<dev string:x7a8>", level.var_7ad4199154e6fc90.var_8bf4ac2a46c4e331 );
        streakinfo.var_13d48fdb8c265002 = namespace_1fd4452aa332cfa1::function_61aca03884a23108( "<dev string:x683>", "<dev string:x7bd>", level.var_7ad4199154e6fc90.var_8440257504ad2a6a );
        gas_strike_function = killstreaks::function_ade2a126ec3053a8( "<dev string:x678>" );
        
        if ( isdefined( gas_strike_function ) )
        {
            player thread [[ gas_strike_function ]]( streakinfo );
        }
    }

    // Namespace benchmark_mp_utils
    // Params 5
    // Checksum 0x48c0c517, Offset: 0x42fb
    // Size: 0x4e9, Type: dev
    function function_dc6ca849abef4a37( player, display_text, min, max, allow_cancel )
    {
        if ( !isdefined( min ) )
        {
            min = undefined;
        }
        
        if ( !isdefined( max ) )
        {
            max = undefined;
        }
        
        if ( !isdefined( allow_cancel ) )
        {
            allow_cancel = 1;
        }
        
        keymap = [];
        keymap[ "<dev string:x836>" ] = [ "<dev string:x836>", 0 ];
        keymap[ "<dev string:x838>" ] = [ "<dev string:x838>", 0 ];
        keymap[ "<dev string:x83a>" ] = [ "<dev string:x83a>", 0 ];
        keymap[ "<dev string:x83c>" ] = [ "<dev string:x83c>", 0 ];
        keymap[ "<dev string:x83e>" ] = [ "<dev string:x83e>", 0 ];
        keymap[ "<dev string:x4c2>" ] = [ "<dev string:x4c2>", 0 ];
        keymap[ "<dev string:x840>" ] = [ "<dev string:x840>", 0 ];
        keymap[ "<dev string:x842>" ] = [ "<dev string:x842>", 0 ];
        keymap[ "<dev string:x844>" ] = [ "<dev string:x844>", 0 ];
        keymap[ "<dev string:x846>" ] = [ "<dev string:x846>", 0 ];
        keymap[ "<dev string:x848>" ] = [ "<dev string:x836>", 0 ];
        keymap[ "<dev string:x84d>" ] = [ "<dev string:x838>", 0 ];
        keymap[ "<dev string:x852>" ] = [ "<dev string:x83a>", 0 ];
        keymap[ "<dev string:x857>" ] = [ "<dev string:x83c>", 0 ];
        keymap[ "<dev string:x85c>" ] = [ "<dev string:x83e>", 0 ];
        keymap[ "<dev string:x861>" ] = [ "<dev string:x4c2>", 0 ];
        keymap[ "<dev string:x866>" ] = [ "<dev string:x840>", 0 ];
        keymap[ "<dev string:x86b>" ] = [ "<dev string:x842>", 0 ];
        keymap[ "<dev string:x870>" ] = [ "<dev string:x844>", 0 ];
        keymap[ "<dev string:x875>" ] = [ "<dev string:x846>", 0 ];
        keymap[ "<dev string:x87a>" ] = [ "<dev string:x87a>", 0 ];
        keymap[ "<dev string:x87c>" ] = [ "<dev string:x87a>", 0 ];
        keymap[ "<dev string:x882>" ] = [ "<dev string:x54>", 0 ];
        
        for ( validinput = 0; !validinput ; validinput = validinput && ( !isdefined( max ) || floatvalue <= max ) )
        {
            currentinput = "<dev string:x54>";
            
            for ( ;; )
            {
                if ( player buttonpressed( "<dev string:x88c>" ) )
                {
                    break;
                }
                
                if ( allow_cancel && player buttonpressed( "<dev string:x892>" ) )
                {
                    return;
                }
                
                foreach ( key, value in keymap )
                {
                    if ( player buttonpressed( key ) )
                    {
                        if ( !value[ 1 ] )
                        {
                            if ( key == "<dev string:x882>" )
                            {
                                newinput = "<dev string:x54>";
                                
                                for ( i = 0; i < currentinput.size - 1 ; i++ )
                                {
                                    newinput += currentinput[ i ];
                                }
                                
                                currentinput = newinput;
                            }
                            else
                            {
                                currentinput += value[ 0 ];
                            }
                        }
                        
                        keymap[ key ][ 1 ] = 1;
                        continue;
                    }
                    
                    keymap[ key ][ 1 ] = 0;
                }
                
                minstring = isdefined( min ) ? "<dev string:x899>" + float( min ) : "<dev string:x54>";
                maxstring = isdefined( max ) ? "<dev string:x89f>" + float( max ) : "<dev string:x54>";
                printtoscreen2d( 500, 250, "<dev string:x8a5>", ( 0, 1, 0 ), 1.3, 1 );
                
                if ( allow_cancel )
                {
                    printtoscreen2d( 500, 275, "<dev string:x8c2>", ( 0, 1, 0 ), 1.3, 1 );
                }
                
                printtoscreen2d( 500, 300, "<dev string:x8db>", ( 0, 1, 0 ), 1.3, 1 );
                printtoscreen2d( 500, 350, minstring + "<dev string:x55>" + maxstring, ( 0, 1, 0 ), 1.3, 1 );
                printtoscreen2d( 500, 375, display_text + currentinput, ( 0, 1, 0 ), 1.3, 1 );
                waitframe();
            }
            
            if ( currentinput == "<dev string:x54>" )
            {
                continue;
            }
            
            floatvalue = float( currentinput );
            validinput = isnumber( floatvalue );
            validinput = validinput && ( !isdefined( min ) || floatvalue >= min );
        }
        
        return floatvalue;
    }

    // Namespace benchmark_mp_utils
    // Params 3
    // Checksum 0x9be406c, Offset: 0x47ec
    // Size: 0x70, Type: dev
    function function_5f9b63ec7a92782b( file_name, extension, sub_folder )
    {
        if ( !isdefined( sub_folder ) )
        {
            sub_folder = undefined;
        }
        
        var_357d49a883caa4f3 = file_name + extension;
        fileid = function_b70280649f0c0c0d( var_357d49a883caa4f3, "<dev string:x39f>", sub_folder );
        
        if ( fileid == -1 )
        {
            assertmsg( "<dev string:x903>" );
            return;
        }
        
        function_9c33c17f1c093741( fileid );
        return var_357d49a883caa4f3;
    }

    // Namespace benchmark_mp_utils
    // Params 6
    // Checksum 0xf58edba8, Offset: 0x4864
    // Size: 0x10e, Type: dev
    function function_52defaf90913e64f( gui_path, custom_prefix, var_2b07e7738353dabc, var_a3a90d6684f9d940, var_a0395a5fce2f6511, var_777e35bbad5dd4c5 )
    {
        if ( !getdvarint( @"hash_f2571c58dbe1ba35", 1 ) )
        {
            return;
        }
        
        if ( !isdefined( level.var_a5b8c6a7124de681 ) )
        {
            level.var_a5b8c6a7124de681 = [];
        }
        
        var_d4618b5cb744f32f = { #custom_prefix:custom_prefix, #var_777e35bbad5dd4c5:var_777e35bbad5dd4c5, #gui_path:gui_path, #var_a0395a5fce2f6511:var_a0395a5fce2f6511, #var_a3a90d6684f9d940:var_a3a90d6684f9d940, #var_2b07e7738353dabc:var_2b07e7738353dabc };
        devgui::function_9082edeb5db93280( gui_path );
        devgui::function_cd4e263c1f3018ae( "<dev string:x93a>", custom_prefix + "<dev string:x94a>" + level.var_a5b8c6a7124de681.size, &function_d011a33fcc91c401 );
        devgui::function_77df7fe7dd273e10();
        function_b0e8468d2000b3df( gui_path, custom_prefix, var_a3a90d6684f9d940, var_a0395a5fce2f6511, var_777e35bbad5dd4c5 );
        level.var_a5b8c6a7124de681[ level.var_a5b8c6a7124de681.size ] = var_d4618b5cb744f32f;
    }

    // Namespace benchmark_mp_utils
    // Params 1, eflags: 0x4
    // Checksum 0x310b1f09, Offset: 0x497a
    // Size: 0x108, Type: dev
    function private function_d011a33fcc91c401( params )
    {
        index = int( params[ 0 ] );
        var_d4618b5cb744f32f = level.var_a5b8c6a7124de681[ index ];
        var_2b07e7738353dabc = var_d4618b5cb744f32f.var_2b07e7738353dabc;
        var_a3a90d6684f9d940 = var_d4618b5cb744f32f.var_a3a90d6684f9d940;
        var_a0395a5fce2f6511 = var_d4618b5cb744f32f.var_a0395a5fce2f6511;
        gui_path = var_d4618b5cb744f32f.gui_path;
        var_777e35bbad5dd4c5 = var_d4618b5cb744f32f.var_777e35bbad5dd4c5;
        custom_prefix = var_d4618b5cb744f32f.custom_prefix;
        Files = function_73796ddfbc223146( var_a0395a5fce2f6511, "<dev string:x95c>" + var_a3a90d6684f9d940, 1 );
        var_357d49a883caa4f3 = function_5847501232705d38( var_2b07e7738353dabc, var_a3a90d6684f9d940, var_a0395a5fce2f6511 );
        var_357d49a883caa4f3 = function_5f9b63ec7a92782b( var_357d49a883caa4f3, var_a3a90d6684f9d940, var_a0395a5fce2f6511 );
        function_b0e8468d2000b3df( gui_path, custom_prefix, var_a3a90d6684f9d940, var_a0395a5fce2f6511, var_777e35bbad5dd4c5 );
        iprintlnbold( "<dev string:x95e>" );
    }

    // Namespace benchmark_mp_utils
    // Params 3
    // Checksum 0xe7bf2c6e, Offset: 0x4a8a
    // Size: 0x116, Type: dev
    function function_5847501232705d38( var_2b07e7738353dabc, var_a3a90d6684f9d940, var_a0395a5fce2f6511 )
    {
        Files = function_73796ddfbc223146( var_a0395a5fce2f6511, "<dev string:x95c>" + var_a3a90d6684f9d940, 1 );
        file_map = [];
        
        foreach ( file_name in Files )
        {
            file_map[ file_name ] = 1;
        }
        
        var_ff0389572302758c = 1;
        mapname = game_utility::getmapname();
        var_357d49a883caa4f3 = mapname + "<dev string:x97a>" + var_2b07e7738353dabc + "<dev string:x97a>" + var_ff0389572302758c;
        
        while ( file_map[ var_357d49a883caa4f3 ] )
        {
            var_357d49a883caa4f3 = mapname + "<dev string:x97a>" + var_2b07e7738353dabc + "<dev string:x97a>" + var_ff0389572302758c;
            var_ff0389572302758c++;
        }
        
        return var_357d49a883caa4f3;
    }

    // Namespace benchmark_mp_utils
    // Params 5, eflags: 0x4
    // Checksum 0xa7976686, Offset: 0x4ba8
    // Size: 0x87, Type: dev
    function private function_b0e8468d2000b3df( gui_path, custom_prefix, var_a3a90d6684f9d940, folder, var_777e35bbad5dd4c5 )
    {
        Files = function_73796ddfbc223146( folder, "<dev string:x95c>" + var_a3a90d6684f9d940 );
        
        for ( i = 0; i < Files.size ; i++ )
        {
            devgui::function_cd4e263c1f3018ae( gui_path + Files[ i ], custom_prefix + "<dev string:x97c>" + Files[ i ], var_777e35bbad5dd4c5, 0, i + 1 );
        }
    }

#/
