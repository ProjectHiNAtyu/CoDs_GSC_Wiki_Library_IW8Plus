// script_39ecc21922ab862e  (hash_39ecc21922ab862e.gscc) (size: 10250 Bytes / 0x280a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7700f649 (1996551753)
// size ...... 10250 (0x280a)
// includes .. 8   (offset: 0x26ae)
// strings ... 16  (offset: 0x26ee)
// dev strs .. 3   (offset: 0x27e6)
// exports ... 22  (offset: 0x1b56)
// cseg ...... 0x15b + 0x19fb (0x1b56)
// imports ... 63  (offset: 0x1ec6)
// animtree1 . 0   (offset: 0x280a)
// animtree2 . 0   (offset: 0x280a)
#using script_382bf8d77c4fd348;
#using scripts\common\callback_sequence;
#using scripts\common\utility;
#using scripts\mp\action_park_utility;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\utility\game;
#using scripts\mp\flags;
#using scripts\mp\spawncamera;

#namespace koth_shared;

// Namespace koth_shared
// Params 0
// Checksum 0xb833df66, Offset: 0x179
// Size: 0x10c
function initialize()
{
    if ( !getmatchrulesdata( "kothData", "enableKothShared" ) )
    {
        return;
    }
    
    level.koth_shared = {};
    level.koth_shared.var_25b9531df6a0c1cf = getmatchrulesdata( "kothData", "randomLocationOrder" ) || action_park_utility::is_enabled();
    level.koth_shared.var_7ab595df37d911bb = getmatchrulesdata( "kothData", "zoneHoldScoreLoopFrequencySeconds" );
    thread function_306f92cbc535101c();
    thread main_loop_thread();
    
    /#
        thread function_ac676f23b86223c9();
        utility::issharedfuncdefined( #"koth_shared", #"hash_cda4308a680a661b", 1 );
        utility::issharedfuncdefined( #"koth_shared", #"hash_fe4eaea2df7a50a0", 1 );
        utility::issharedfuncdefined( #"koth_shared", #"hash_78baf065cea30b57", 1 );
        utility::issharedfuncdefined( #"koth_shared", #"on_player_score_interval", 1 );
        utility::issharedfuncdefined( #"koth_shared", #"hash_4356b4516dc478f2", 1 );
    #/
}

// Namespace koth_shared
// Params 0
// Checksum 0xa36ab08d, Offset: 0x28d
// Size: 0xc, Type: bool
function is_enabled()
{
    return isdefined( level.koth_shared );
}

// Namespace koth_shared
// Params 1
// Checksum 0x4a39772, Offset: 0x2a2
// Size: 0x18, Type: bool
function is_first_zone( game_object )
{
    return istrue( game_object.is_first_zone );
}

// Namespace koth_shared
// Params 0, eflags: 0xc
// Checksum 0x8cc99db7, Offset: 0x2c3
// Size: 0x104
function private function_306f92cbc535101c()
{
    self notify( #"hash_1854467da5d71aa9" );
    self endon( #"hash_1854467da5d71aa9" );
    level endon( #"game_ended" );
    utility::flag_wait( "gameobject_system_pre_init" );
    callback::function_dc654a4d4126a928( #"hash_92c01688276809dc", #"hash_6947ec89a1af6d69", &on_activate );
    callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_1cb0ea1c91f157da );
    callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &on_player_stop_use );
    callback::function_dc654a4d4126a928( #"hash_a836ce9ab43d9e2", #"hash_6947ec89a1af6d69", &on_capture );
    callback::function_dc654a4d4126a928( #"hash_2e3e0663aecb6f19", #"hash_6947ec89a1af6d69", &function_1e56136120092b81 );
    callback::function_dc654a4d4126a928( #"hash_300ad54dcc9beab1", #"hash_6947ec89a1af6d69", &on_contested );
    callback::function_dc654a4d4126a928( #"hash_629949853fbabab8", #"hash_6947ec89a1af6d69", &on_uncontested );
}

// Namespace koth_shared
// Params 1, eflags: 0x4
// Checksum 0xbd44753d, Offset: 0x3cf
// Size: 0x3c
function private on_activate( params )
{
    game_object = params.game_object;
    game_object.activation_time_ms = gettime();
    function_a56e8aada400baa1( game_object );
}

// Namespace koth_shared
// Params 1, eflags: 0x4
// Checksum 0xf366f1db, Offset: 0x413
// Size: 0x111
function private function_1cb0ea1c91f157da( params )
{
    game_object = params.game_object;
    player = params.player;
    var_7f4958ce4e4277c3 = namespace_277c922f0d0dc523::function_9b71aa2788e21706( game_object );
    player_team_hash = player.team == "all" || player.team == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( player.team ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( player.team ) ? #"hash_ce911e3bbe99421f" : player.team == "none" || player.team == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( var_7f4958ce4e4277c3 == player_team_hash )
    {
        player thread function_cb9700aa0c5f2bbf( game_object, player );
    }
}

// Namespace koth_shared
// Params 1, eflags: 0x4
// Checksum 0xc4fbf06c, Offset: 0x52c
// Size: 0x60
function private on_player_stop_use( params )
{
    player = params.player;
    player notify( #"hash_c8dbb4f0fcdd8488" );
    
    if ( !isdefined( player.koth_shared ) )
    {
        player.koth_shared = {};
    }
    
    player.koth_shared.var_db2b1dde1497a248 = undefined;
}

// Namespace koth_shared
// Params 1, eflags: 0x4
// Checksum 0x8c5fb0ea, Offset: 0x594
// Size: 0x147
function private on_capture( params )
{
    game_object = params.game_object;
    player = params.var_dbd0d4c325a7ae15;
    var_2b03add3a518dea6 = params.var_2b03add3a518dea6;
    current_time_ms = gettime();
    game_object_objective_key = gameobjects_common::get_objective_key( game_object );
    is_first_capture = 0;
    is_quick_capture = current_time_ms - game_object.activation_time_ms <= 2100;
    
    if ( level.var_1beb16b6708fb13c != game_object_objective_key )
    {
        level.var_1beb16b6708fb13c = game_object_objective_key;
        is_first_capture = 1;
    }
    
    function_6753545e88425567( game_object, player, current_time_ms, 0, is_first_capture, is_quick_capture );
    player notify( #"player_zone_captured", game_object_objective_key );
    
    foreach ( var_bfcacfc3e65ffcb1 in var_2b03add3a518dea6 )
    {
        function_6753545e88425567( game_object, var_bfcacfc3e65ffcb1, current_time_ms, 1, is_first_capture, is_quick_capture );
    }
}

// Namespace koth_shared
// Params 1, eflags: 0x4
// Checksum 0x57b3dd1c, Offset: 0x6e3
// Size: 0x4b
function private function_1e56136120092b81( params )
{
    game_object = params.game_object;
    owning_team_name = params.team_name;
    function_88843f8e155e0a40( game_object, owning_team_name );
    function_a56e8aada400baa1( game_object );
}

// Namespace koth_shared
// Params 1, eflags: 0x4
// Checksum 0x600f3813, Offset: 0x736
// Size: 0x46
function private on_contested( params )
{
    game_object = params.game_object;
    function_a56e8aada400baa1( game_object );
    game_object notify( #"hash_7406452701232584" );
    game_object notify( #"hash_c8dbb4f0fcdd8488" );
}

// Namespace koth_shared
// Params 1, eflags: 0x4
// Checksum 0xb2e85c4e, Offset: 0x784
// Size: 0x35
function private on_uncontested( params )
{
    game_object = params.game_object;
    function_88843f8e155e0a40( game_object );
    function_a56e8aada400baa1( game_object );
}

// Namespace koth_shared
// Params 6, eflags: 0x4
// Checksum 0xbab9f89c, Offset: 0x7c1
// Size: 0x137
function private function_6753545e88425567( game_object, player, current_time_ms, is_assist, is_first_capture, is_quick_capture )
{
    var_1aadc49467d8cbcf = 3.40282e+38;
    
    if ( isdefined( player.koth_shared.var_ebecc5927e197b1a ) )
    {
        var_1aadc49467d8cbcf = current_time_ms - player.koth_shared.var_ebecc5927e197b1a;
    }
    
    if ( !isdefined( player.koth_shared ) )
    {
        player.koth_shared = {};
    }
    
    player.koth_shared.var_ebecc5927e197b1a = current_time_ms;
    profilestart();
    params = {};
    params.game_object = game_object;
    params.player = player;
    params.is_assist = is_assist;
    params.is_first_capture = is_first_capture;
    params.var_76e9eb89ea7138e3 = var_1aadc49467d8cbcf <= 7000 && !is_first_capture;
    params.is_quick_capture = is_quick_capture;
    utility::callsharedfunc( #"koth_shared", #"hash_4356b4516dc478f2", params );
    profilestop();
}

// Namespace koth_shared
// Params 2, eflags: 0xc
// Checksum 0x56cfb7d3, Offset: 0x900
// Size: 0x225
function private team_score_thread( game_object, owning_team_name )
{
    self notify( #"hash_29c2bd235da60613" );
    self endon( #"hash_29c2bd235da60613" );
    level endon( #"game_ended" );
    game_object endon( #"hash_7406452701232584" );
    current_time_ms = gettime();
    var_7f4958ce4e4277c3 = owning_team_name == "all" || owning_team_name == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( owning_team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( owning_team_name ) ? #"hash_ce911e3bbe99421f" : owning_team_name == "none" || owning_team_name == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( !isdefined( game_object.koth_shared ) )
    {
        game_object.koth_shared = {};
    }
    
    if ( !isdefined( game_object.koth_shared.var_958d66a61d9c2941 ) )
    {
        game_object.koth_shared.var_958d66a61d9c2941 = [];
    }
    
    if ( !isdefined( game_object.koth_shared.var_958d66a61d9c2941[ var_7f4958ce4e4277c3 ] ) )
    {
        game_object.koth_shared.var_958d66a61d9c2941[ var_7f4958ce4e4277c3 ] = current_time_ms;
    }
    
    var_8fbc6de387b47c2 = current_time_ms - game_object.koth_shared.var_958d66a61d9c2941[ var_7f4958ce4e4277c3 ];
    
    if ( var_8fbc6de387b47c2 < 1000 )
    {
        wait_time_ms = 1000 - var_8fbc6de387b47c2;
        wait wait_time_ms * 0.001;
    }
    
    while ( true )
    {
        game_object.koth_shared.var_958d66a61d9c2941[ var_7f4958ce4e4277c3 ] = gettime();
        profilestart();
        params = {};
        params.game_object = game_object;
        params.owning_team_name = owning_team_name;
        params.var_7f4958ce4e4277c3 = var_7f4958ce4e4277c3;
        utility::callsharedfunc( #"koth_shared", #"hash_78baf065cea30b57", params );
        profilestop();
        wait level.koth_shared.var_7ab595df37d911bb;
    }
}

// Namespace koth_shared
// Params 2, eflags: 0xc
// Checksum 0x55f7e5ee, Offset: 0xb2d
// Size: 0x1f5
function private function_cb9700aa0c5f2bbf( game_object, player )
{
    self notify( #"hash_520dfc1728343d03" );
    self endon( #"hash_520dfc1728343d03" );
    level endon( #"game_ended" );
    game_object endon( #"hash_c8dbb4f0fcdd8488" );
    player endon( #"hash_c8dbb4f0fcdd8488" );
    current_time_ms = gettime();
    
    if ( !isdefined( player.koth_shared ) )
    {
        player.koth_shared = {};
    }
    
    if ( !isdefined( player.koth_shared.var_958d66a61d9c2941 ) )
    {
        player.koth_shared.var_958d66a61d9c2941 = current_time_ms;
    }
    
    if ( !isdefined( player.koth_shared.var_db2b1dde1497a248 ) )
    {
        player.koth_shared.var_db2b1dde1497a248 = 0;
    }
    
    var_8fbc6de387b47c2 = current_time_ms - player.koth_shared.var_958d66a61d9c2941;
    
    if ( var_8fbc6de387b47c2 > 3000 )
    {
        player.koth_shared.var_db2b1dde1497a248 = 0;
    }
    else if ( var_8fbc6de387b47c2 < 1000 )
    {
        wait_time_ms = 1000 - var_8fbc6de387b47c2;
        wait wait_time_ms * 0.001;
    }
    
    while ( true )
    {
        player.koth_shared.var_958d66a61d9c2941 = gettime();
        player.koth_shared.var_db2b1dde1497a248++;
        profilestart();
        params = {};
        params.game_object = game_object;
        params.player = player;
        params.var_db2b1dde1497a248 = player.koth_shared.var_db2b1dde1497a248;
        utility::callsharedfunc( #"koth_shared", #"on_player_score_interval", params );
        profilestop();
        wait level.koth_shared.var_7ab595df37d911bb;
    }
}

// Namespace koth_shared
// Params 1, eflags: 0xc
// Checksum 0x53302e9, Offset: 0xd2a
// Size: 0x257
function private main_loop_thread( instance_id )
{
    self notify( #"hash_2020e38588b42804" );
    self endon( #"hash_2020e38588b42804" );
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    utility::flag_wait( "gameobject_system_post_init" );
    waitframe();
    current_zone = undefined;
    var_ca2b2b4d85249d06 = undefined;
    assert( level.zoneduration > level.nextzonerevealtime, "<dev string:x24>" );
    
    while ( true )
    {
        /#
            level.koth_shared.force_next_zone = 0;
        #/
        
        var_d9af928a3790f480 = int( isdefined( level.zone ) ) * level.nextzonerevealtime;
        activation_delay_sec = !level.zone ? level.firstzoneactivationdelay : level.zoneactivationdelay;
        
        if ( var_d9af928a3790f480 > 0 )
        {
            wait_time_sec = level.zoneduration - var_d9af928a3790f480;
            function_f87fe1fb9a513f50( wait_time_sec );
        }
        else if ( level.zone )
        {
            function_f87fe1fb9a513f50( level.zoneduration );
        }
        
        var_ca2b2b4d85249d06 = function_3ddd038603106fa9();
        var_ca2b2b4d85249d06.is_first_zone = isdefined( level.zone );
        
        if ( !isdefined( level.zone ) )
        {
            level.zone = var_ca2b2b4d85249d06;
        }
        
        profilestart();
        params = {};
        params.game_object = var_ca2b2b4d85249d06;
        params.instance_id = instance_id;
        lock_time_sec = var_d9af928a3790f480 + activation_delay_sec;
        
        if ( lock_time_sec > 0 )
        {
            params.lock_time_ms = lock_time_sec * 1000;
        }
        
        utility::callsharedfunc( #"koth_shared", #"hash_cda4308a680a661b", params );
        profilestop();
        function_f87fe1fb9a513f50( var_d9af928a3790f480 );
        
        if ( isdefined( current_zone ) )
        {
            current_zone.is_first_zone = undefined;
            gameobjects_common::deactivate( current_zone );
            profilestart();
            params = {};
            params.game_object = current_zone;
            params.instance_id = instance_id;
            utility::callsharedfunc( #"koth_shared", #"hash_fe4eaea2df7a50a0", params );
            profilestop();
        }
        
        function_f87fe1fb9a513f50( activation_delay_sec );
        current_zone = var_ca2b2b4d85249d06;
        level.zone = current_zone;
        gameobjects_common::activate( current_zone );
    }
}

// Namespace koth_shared
// Params 2, eflags: 0x4
// Checksum 0x87744316, Offset: 0xf89
// Size: 0x1d9
function private function_88843f8e155e0a40( game_object, owning_team_name )
{
    if ( namespace_277c922f0d0dc523::function_79ed8dd2c414e8ed( game_object ) )
    {
        if ( !isdefined( owning_team_name ) )
        {
            owning_team_name = namespace_277c922f0d0dc523::get_owning_team_name( game_object );
        }
        
        game_object thread team_score_thread( game_object, owning_team_name );
        
        foreach ( player in gameobjects_common::function_de2f4638a165d21c( game_object, owning_team_name == "all" || owning_team_name == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( owning_team_name ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( owning_team_name ) ? #"hash_ce911e3bbe99421f" : owning_team_name == "none" || owning_team_name == "neutral" ? #"hash_bb332da19f9944df" : undefined ) )
        {
            player thread function_cb9700aa0c5f2bbf( game_object, player );
        }
        
        return;
    }
    
    game_object notify( #"hash_7406452701232584" );
    game_object notify( #"hash_c8dbb4f0fcdd8488" );
    
    foreach ( player in gameobjects_common::function_c3218a3e4808e36c( game_object ) )
    {
        if ( isdefined( player.koth_shared.var_db2b1dde1497a248 ) )
        {
            player.koth_shared.var_db2b1dde1497a248 = undefined;
        }
    }
}

// Namespace koth_shared
// Params 1, eflags: 0x4
// Checksum 0xd8c80e2d, Offset: 0x116a
// Size: 0x6b7
function private function_3ddd038603106fa9( instance_id )
{
    if ( !level.koth_shared.var_25b9531df6a0c1cf )
    {
        zone_list = game_utility_mp::get_gametype_objectives( instance_id );
        
        if ( level.zone )
        {
            objective_key = gameobjects_common::get_objective_key( level.zone );
            zone_index = int( objective_key ) + 1;
            
            if ( zone_index > zone_list.size )
            {
                zone_index = 1;
            }
            
            return zone_list[ string( zone_index ) ];
        }
        
        return zone_list[ "1" ];
    }
    else if ( !level.zone )
    {
        var_5c31df2b0d0396b5 = spawncamera::getstartspawnavg( game_utility_mp::get_attacker_team( instance_id ) );
        var_52b6a0379b50a3c9 = spawncamera::getstartspawnavg( game_utility_mp::get_defender_team( instance_id ) );
        var_b7b53dcc92ca0f62 = vectornormalize( var_52b6a0379b50a3c9 - var_5c31df2b0d0396b5 );
        var_2dd29dbc124ec5b2 = anglestoright( var_b7b53dcc92ca0f62 );
        best_zone = undefined;
        best_cost = 3.40282e+38;
        
        foreach ( zone in game_utility_mp::get_gametype_objectives( instance_id ) )
        {
            zone_origin = gameobjects_common::get_origin( zone );
            zone_dir = zone_origin - level.mapcenter;
            var_5c965c5d1639608b = abs( vectordot( zone_dir, var_b7b53dcc92ca0f62 ) );
            var_9f8e9ac53cfe4fbb = abs( vectordot( zone_dir, var_2dd29dbc124ec5b2 ) );
            var_5297ab9a8e6cfe44 = var_5c965c5d1639608b * 0.8 + var_9f8e9ac53cfe4fbb * 0.2;
            
            if ( var_5297ab9a8e6cfe44 < best_cost )
            {
                best_zone = zone;
                best_cost = var_5297ab9a8e6cfe44;
            }
        }
        
        return best_zone;
    }
    
    if ( !isdefined( level.koth_shared.zone_list ) )
    {
        level.koth_shared.zone_list = {};
    }
    
    if ( !isdefined( level.koth_shared.zone_list.unused ) )
    {
        level.koth_shared.zone_list.unused = game_utility_mp::get_gametype_objectives( instance_id );
    }
    
    if ( !isdefined( level.koth_shared.zone_list.used ) )
    {
        level.koth_shared.zone_list.used = [];
    }
    
    level.koth_shared.zone_list.unused = arrayremove( level.koth_shared.zone_list.unused, level.zone );
    level.koth_shared.zone_list.used[ level.koth_shared.zone_list.used.size ] = level.zone;
    
    if ( level.koth_shared.zone_list.unused.size == 1 )
    {
        zone = level.koth_shared.zone_list.unused[ 0 ];
        level.koth_shared.zone_list = undefined;
        return zone;
    }
    
    var_fd59d4ff87a23539 = [];
    living_players = game_utility_mp::getpotentiallivingplayers();
    
    foreach ( player in living_players )
    {
        if ( player.team == "spectators" || player.sessionstate == "spectators" )
        {
            continue;
        }
        
        if ( !isdefined( var_fd59d4ff87a23539[ player.team ] ) )
        {
            var_fd59d4ff87a23539[ player.team ] = { #player_count:0, #origin:( 0, 0, 0 ) };
        }
        
        var_fd59d4ff87a23539[ player.team ].origin += player.origin;
        var_fd59d4ff87a23539[ player.team ].player_count++;
    }
    
    foreach ( team_name, var_54ed6aa05f65db34 in var_fd59d4ff87a23539 )
    {
        avg_origin = var_fd59d4ff87a23539[ team_name ].origin / var_fd59d4ff87a23539[ team_name ].player_count;
        var_fd59d4ff87a23539[ team_name ] = avg_origin;
    }
    
    curr_zone_origin = gameobjects_common::get_origin( level.zone );
    best_zone = undefined;
    best_cost = 0;
    
    foreach ( zone in level.koth_shared.zone_list.unused )
    {
        zone_origin = gameobjects_common::get_origin( zone );
        var_5297ab9a8e6cfe44 = distance2dsquared( curr_zone_origin, zone_origin );
        var_b37f7dfd48157c7d = 0;
        
        foreach ( origin in var_fd59d4ff87a23539 )
        {
            var_b37f7dfd48157c7d += distance2dsquared( zone_origin, origin );
        }
        
        total_cost = var_5297ab9a8e6cfe44 * 0.3 + var_b37f7dfd48157c7d * 0.7;
        
        if ( total_cost > best_cost )
        {
            best_zone = zone;
            best_cost = total_cost;
        }
    }
    
    return best_zone;
}

// Namespace koth_shared
// Params 2, eflags: 0x4
// Checksum 0x8a9a439e, Offset: 0x182a
// Size: 0x1ae
function private get_zone_list( randomize, instance_id )
{
    zone_array = game_utility_mp::get_gametype_objectives( instance_id );
    out_array = [];
    
    foreach ( zone in zone_array )
    {
        objective_key = gameobjects_common::get_objective_key( zone );
        out_array[ int( objective_key ) - 1 ] = zone;
    }
    
    if ( !randomize )
    {
        return out_array;
    }
    
    if ( level.koth_shared.var_5536e41ccd119a2 )
    {
        var_eac4404f9e957c6e = [];
        var_d3ac450acb39ae9c = [];
        
        foreach ( zone in zone_array )
        {
            objective_key = gameobjects_common::get_objective_key( zone );
            
            if ( utility::function_9dac7ef683ed0e52( level.koth_shared.var_5536e41ccd119a2, objective_key ) )
            {
                arrayinsert( var_eac4404f9e957c6e, zone, var_eac4404f9e957c6e.size );
                continue;
            }
            
            arrayinsert( var_d3ac450acb39ae9c, zone, var_d3ac450acb39ae9c.size );
        }
        
        var_eac4404f9e957c6e = arrayrandomize( var_eac4404f9e957c6e );
        var_d3ac450acb39ae9c = arrayrandomize( var_d3ac450acb39ae9c );
        return arraycombine( var_d3ac450acb39ae9c, var_eac4404f9e957c6e );
    }
    
    return arrayrandomize( out_array );
}

// Namespace koth_shared
// Params 1, eflags: 0x4
// Checksum 0x83904b47, Offset: 0x19e1
// Size: 0x53
function private function_f87fe1fb9a513f50( time_sec )
{
    /#
        if ( level.koth_shared.force_next_zone )
        {
            return;
        }
        else if ( isdefined( level.koth_shared.force_next_zone ) )
        {
            level utility::waittill_any_timeout_no_endon_death( time_sec, "<dev string:x6b>" );
            return;
        }
    #/
    
    wait time_sec;
}

// Namespace koth_shared
// Params 1, eflags: 0x4
// Checksum 0xa96ffeac, Offset: 0x1a3c
// Size: 0x94
function private function_a56e8aada400baa1( game_object )
{
    if ( namespace_277c922f0d0dc523::is_contested( game_object ) )
    {
        setomnvar( "ui_hq_ownerteam", 3 );
        return;
    }
    
    if ( !namespace_277c922f0d0dc523::function_79ed8dd2c414e8ed( game_object ) )
    {
        setomnvar( "ui_hq_ownerteam", 0 );
        return;
    }
    
    owning_team_name = namespace_277c922f0d0dc523::get_owning_team_name( game_object );
    
    if ( owning_team_name == "axis" )
    {
        setomnvar( "ui_hq_ownerteam", 1 );
        return;
    }
    
    if ( owning_team_name == "allies" )
    {
        setomnvar( "ui_hq_ownerteam", 2 );
        return;
    }
    
    assert( "<dev string:x7f>" );
}

/#

    // Namespace koth_shared
    // Params 0, eflags: 0xc
    // Checksum 0x960eb9c6, Offset: 0x1ad8
    // Size: 0x7e, Type: dev
    function private function_ac676f23b86223c9()
    {
        self notify( #"hash_5801a3c8ac5f0ab7" );
        self endon( #"hash_5801a3c8ac5f0ab7" );
        setdevdvarifuninitialized( @"hash_796deaab0da995a1", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_796deaab0da995a1", 0 ) != 0 )
            {
                level.koth_shared.force_next_zone = 1;
                level notify( #"hash_233bb22a713b1b57" );
                setdevdvar( @"hash_796deaab0da995a1", 0 );
            }
            
            wait 0.5;
        }
    }

#/
