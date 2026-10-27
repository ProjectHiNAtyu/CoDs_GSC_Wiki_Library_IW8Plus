// scripts\mp\zm\systems\zm_ncfdpedestal.gsc  (hash_1e43bd77ad5dde8c.gscc) (size: 16437 Bytes / 0x4035 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x378d57dc (932009948)
// size ...... 16437 (0x4035)
// includes .. 9   (offset: 0x3c79)
// strings ... 46  (offset: 0x3cc1)
// dev strs .. 12  (offset: 0x3fa5)
// exports ... 37  (offset: 0x27b9)
// cseg ...... 0x44e + 0x236b (0x27b9)
// imports ... 121 (offset: 0x2d81)
// animtree1 . 0   (offset: 0x4035)
// animtree2 . 0   (offset: 0x4035)
#using script_16ea1b94f0f381b3;
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\equipment;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_ncfdpedestal;

// Namespace zm_ncfdpedestal
// Params 0, eflags: 0x5
// Checksum 0x64dfcb1b, Offset: 0x46c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_ncfdpedestal", undefined, undefined, &post_init );
}

// Namespace zm_ncfdpedestal
// Params 0
// Checksum 0xd70f87d7, Offset: 0x48d
// Size: 0x11f
function post_init()
{
    if ( !getdvarint( @"enable_ncfd_pedestal", 0 ) )
    {
        return;
    }
    
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( #"player_death", &on_player_death );
    level utility::flag_wait_all( "zm_sat_scarab_script_ncfdpedestal_cs_completed", "scriptables_ready", "begin_round_logic", "equipment_initialized" );
    level callback::add( "on_round_end", &on_round_end );
    level callback::add( #"equipment_use", &on_equipment_use );
    level callback::add( "on_grapple_pulling_start", &on_grapple_pulling_start_vo );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_7fe8c6572826a966", &function_8a1d6aa3a157f687 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_1138f7763bcafe18", &function_243e94122f2268f6 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_9fa71914fdba6e1", &function_c7725a355fafd3f4 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_9e745888c25e0c9e", &function_23094ea1c1486df7 );
    level.var_eeaac875c659468d = 30;
    level.var_b6a4b93f9f863428 = 3;
    level.var_2f39759a21e00f9f = 30;
    level thread spawn_pedestals();
    
    /#
        level thread init_debug();
    #/
}

// Namespace zm_ncfdpedestal
// Params 0, eflags: 0x4
// Checksum 0x838fbb50, Offset: 0x5b4
// Size: 0x232
function private spawn_pedestals()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "begin_round_logic" );
    level.ncfd_pedestals = [];
    level.var_2c4ae363d9399fc4 = [];
    level.var_998acce8d310a746 = [];
    var_b9f992dce3a115e8 = utility::getstructarray( "np_loc" );
    
    foreach ( loc in var_b9f992dce3a115e8 )
    {
        item = spawnscriptable( "ncfd_pedestal", loc.origin, loc.angles );
        item.interact = zm_quest::function_91f9590e98d57ff6( item.origin + ( 0, 0, 50 ), &use_np, &function_a296e3fa63e78600 );
        item.interact.script_id = loc.script_noteworthy;
        item.interact.pedestal = item;
        vfx = spawnscriptable( "ncfd_pedestal_vfx", loc.origin, loc.angles );
        vfx_off = spawnscriptable( "ncfd_pedestal_vfx_off", loc.origin, loc.angles );
        item.vfx = vfx;
        item.vfx_off = vfx_off;
        assert( isdefined( loc.script_noteworthy ), "<dev string:x24>" );
        level.var_998acce8d310a746[ level.var_998acce8d310a746.size ] = vfx_off;
        level.var_2c4ae363d9399fc4[ level.var_2c4ae363d9399fc4.size ] = vfx;
        level.ncfd_pedestals[ level.ncfd_pedestals.size ] = item;
    }
    
    level thread pedestal_watcher();
    level utility::flag_set( "ncfds_spawned" );
}

// Namespace zm_ncfdpedestal
// Params 0, eflags: 0x4
// Checksum 0xe6034331, Offset: 0x7ee
// Size: 0x464
function private pedestal_watcher()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( utility::callsharedfunc( #"ncfd", #"hash_81eb587ae514df01" ) )
            {
                if ( player.var_87522aee8be7890b || player.var_819dfee5ff9a56d6 || player.n_charge_times >= 3 && !level utility::flag( "ncfd_infinite_grapple_enabled" ) )
                {
                    foreach ( np_vfx in level.var_2c4ae363d9399fc4 )
                    {
                        if ( !np_vfx function_50b79f4d4032e234( player ) )
                        {
                            np_vfx function_d6a7b7ef13a57f38( player );
                        }
                    }
                    
                    foreach ( np_vfx_off in level.var_998acce8d310a746 )
                    {
                        if ( np_vfx_off function_50b79f4d4032e234( player ) )
                        {
                            np_vfx_off function_6113853a877d5460( player );
                            
                            if ( np_vfx_off.var_c62a3e81dd2e88bd )
                            {
                                np_vfx_off setscriptablepartstate( "base", "off_upgraded" );
                                continue;
                            }
                            
                            np_vfx_off setscriptablepartstate( "base", "off" );
                        }
                    }
                }
                else
                {
                    foreach ( np_vfx in level.var_2c4ae363d9399fc4 )
                    {
                        if ( np_vfx function_50b79f4d4032e234( player ) )
                        {
                            np_vfx function_6113853a877d5460( player );
                            
                            if ( np_vfx.var_c62a3e81dd2e88bd )
                            {
                                np_vfx setscriptablepartstate( "base", "on_upgraded" );
                                continue;
                            }
                            
                            np_vfx setscriptablepartstate( "base", "on" );
                        }
                    }
                    
                    foreach ( np_vfx_off in level.var_998acce8d310a746 )
                    {
                        if ( !np_vfx_off function_50b79f4d4032e234( player ) )
                        {
                            np_vfx_off function_d6a7b7ef13a57f38( player );
                        }
                    }
                }
                
                continue;
            }
            
            foreach ( np_vfx in level.var_2c4ae363d9399fc4 )
            {
                if ( !np_vfx function_50b79f4d4032e234( player ) )
                {
                    np_vfx function_d6a7b7ef13a57f38( player );
                }
            }
            
            foreach ( np_vfx_off in level.var_998acce8d310a746 )
            {
                if ( np_vfx_off function_50b79f4d4032e234( player ) )
                {
                    np_vfx_off function_6113853a877d5460( player );
                    
                    if ( np_vfx_off.var_c62a3e81dd2e88bd )
                    {
                        np_vfx_off setscriptablepartstate( "base", "off_upgraded" );
                        continue;
                    }
                    
                    np_vfx_off setscriptablepartstate( "base", "off" );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0xb0838d1a, Offset: 0xc5a
// Size: 0x8e
function on_player_connect( params )
{
    if ( isplayer( self ) )
    {
        self.var_819dfee5ff9a56d6 = 0;
        self.var_1480821e3b802295 = 0;
        self.n_charge_times = 0;
        var_fcccc3d2a616b1c7 = 0;
        
        if ( utility::issharedfuncdefined( #"zombie", #"hash_e1eecff22a023276" ) )
        {
            var_fcccc3d2a616b1c7 = utility::callsharedfunc( #"zombie", #"hash_e1eecff22a023276" );
        }
        
        if ( var_fcccc3d2a616b1c7 )
        {
            callback::add( #"hash_79b197636e7199f", &function_2c6edf42c0de1e95 );
        }
    }
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x375839aa, Offset: 0xcf0
// Size: 0x5b
function function_2c6edf42c0de1e95( params )
{
    if ( level utility::flag( "pap_unlocked" ) )
    {
        self.var_1480821e3b802295 = 1;
        var_872cda73afffcfb8 = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", #"hash_be8c8ce0f6aea2c4" );
        
        if ( isdefined( var_872cda73afffcfb8 ) )
        {
            self.var_28d2457a9607034e = 1;
        }
    }
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x1832ca5c, Offset: 0xd53
// Size: 0x89
function on_round_end( params )
{
    foreach ( player in level.players )
    {
        player.n_charge_times = 0;
    }
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0xd45d1e28, Offset: 0xde4
// Size: 0x91
function on_equipment_use( params )
{
    if ( params.ref != "equip_grappling_hook" )
    {
        return;
    }
    
    currammo = params.player equipment_mp::getequipmentammo( params.ref );
    
    if ( currammo == 0 && isplayer( params.player ) )
    {
        params.player thread function_26af4fa33bfe67cd();
        params.player utility::function_7c10ea82c1e305b8( "ncfd_pedestal_charge", "turn_off" );
    }
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x53195d49, Offset: 0xe7d
// Size: 0x99
function function_8a1d6aa3a157f687( params )
{
    level.var_eeaac875c659468d = int( params[ 0 ] );
    
    foreach ( player in level.players )
    {
        player.n_charge_times = 0;
    }
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x26c5043c, Offset: 0xf1e
// Size: 0x1c
function function_243e94122f2268f6( params )
{
    level.var_b6a4b93f9f863428 = int( params[ 0 ] );
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x9c12736e, Offset: 0xf42
// Size: 0x1c
function function_c7725a355fafd3f4( params )
{
    level.var_2f39759a21e00f9f = int( params[ 0 ] );
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x46addaef, Offset: 0xf66
// Size: 0x85
function function_23094ea1c1486df7( params )
{
    foreach ( player in level.players )
    {
        player give_grappling_hook();
    }
}

// Namespace zm_ncfdpedestal
// Params 1, eflags: 0x4
// Checksum 0xfc049fe4, Offset: 0xff3
// Size: 0xac
function private function_e57f4aae4887949a( pedestal )
{
    self endon( #"death_or_disconnect" );
    
    if ( pedestal.var_c62a3e81dd2e88bd && !self.var_28d2457a9607034e )
    {
        self.var_28d2457a9607034e = 1;
        utility::function_72b6372d2d8c997( "sat_zm_vm_ges_grappling_hook_upgraded", 1 );
        gesture_length = self getgestureanimlength( "sat_vm_gesture_zm_grapple_gun_raise_first" );
        wait gesture_length;
        return;
    }
    
    if ( !self.var_1480821e3b802295 && !self.var_28d2457a9607034e )
    {
        self.var_1480821e3b802295 = 1;
        utility::function_72b6372d2d8c997( "sat_zm_vm_ges_grappling_hook", 1 );
        gesture_length = self getgestureanimlength( "sat_vm_gesture_zm_grapple_gun_raise_first" );
        wait gesture_length;
    }
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x3ca3ae6e, Offset: 0x10a7
// Size: 0x1a6
function use_np( player )
{
    if ( player.interactions_disabled || player.var_bf04dca5dc0d2edc )
    {
        return;
    }
    
    if ( self.is_upgrading )
    {
        return;
    }
    
    if ( !utility::callsharedfunc( #"ncfd", #"hash_81eb587ae514df01" ) )
    {
        return;
    }
    
    if ( level.var_3c874d3f031f6c50 && !self.var_c62a3e81dd2e88bd && zm_quest::function_b0a5181ebe7bb905() )
    {
        function_5e3baa9773b1a165( player );
        return;
    }
    
    if ( player.var_819dfee5ff9a56d6 )
    {
        return;
    }
    
    if ( player.var_87522aee8be7890b )
    {
        return;
    }
    
    if ( player.n_charge_times >= level.var_b6a4b93f9f863428 && !level utility::flag( "ncfd_infinite_grapple_enabled" ) )
    {
        return;
    }
    
    if ( level.var_3c874d3f031f6c50 && !self.var_c62a3e81dd2e88bd )
    {
        b_end = function_5e3baa9773b1a165( player );
        
        if ( b_end )
        {
            return;
        }
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player thread function_e57f4aae4887949a( self );
    player thread play_vo( #"hash_4e579391cb776d32", "ncfd_used_played", #"bc_flavor_player_positive" );
    player.var_819dfee5ff9a56d6 = 1;
    player notify( #"used_ncfd_pedestal" );
    player thread function_8e1671683c63ebb6( self );
    player thread function_cf2eadf4cfd227de();
    player give_grappling_hook( self );
    player.n_charge_times++;
    level callback::callback( #"hash_78694f61c22b5057", { #player:player } );
    player callback::callback( #"hash_78694f61c22b5057" );
}

// Namespace zm_ncfdpedestal
// Params 1, eflags: 0x4
// Checksum 0xc6b3d62c, Offset: 0x1255
// Size: 0x7f
function private function_5e3baa9773b1a165( player )
{
    self.is_upgrading = 1;
    result = function_43458e4673e5800b( player );
    
    if ( result )
    {
        self.is_upgrading = undefined;
        self.pedestal.vfx function_d6a7b7ef13a57f38( player );
        return 1;
    }
    else if ( player.inlaststand )
    {
        self.is_upgrading = undefined;
        return 1;
    }
    
    self.is_upgrading = undefined;
}

// Namespace zm_ncfdpedestal
// Params 0
// Checksum 0x7d22436f, Offset: 0x12dc
// Size: 0x41
function function_cf2eadf4cfd227de()
{
    self endon( #"death_or_disconnect", #"usurped_power_restore", #"cancel_all_equip_deployments", #"equip_finished_with_deploy_weapon" );
    level waittill( #"zmb_max_ammo_level" );
    self.var_c27b25f4679be5f0 = 1;
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x464f9cdb, Offset: 0x1325
// Size: 0x51
function on_grapple_pulling_start_vo( params )
{
    if ( !namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        return;
    }
    
    if ( utility::ent_flag( "ncfd_grapple_pulling_start_played" ) )
    {
        return;
    }
    
    if ( utility::ent_flag( "ncfd_used_played_attempt" ) )
    {
        return;
    }
    
    utility::delaythread( 1, &play_vo, #"hash_7bba4777ddbc46af", "ncfd_grapple_pulling_start_played" );
}

// Namespace zm_ncfdpedestal
// Params 3, eflags: 0x4
// Checksum 0xf5ddc1e1, Offset: 0x137e
// Size: 0xe8
function private play_vo( var_8984c1f1eeea88ec, str_flag_name, var_1c360473c4174a43 )
{
    level endon( #"game_ended" );
    player = self;
    
    if ( player utility::ent_flag( str_flag_name ) )
    {
        return;
    }
    
    player utility::ent_flag_set( str_flag_name );
    player utility::ent_flag_set( str_flag_name + "_attempt" );
    var_d36215acc1ef7c86 = namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec, var_1c360473c4174a43 );
    
    if ( var_d36215acc1ef7c86 )
    {
        if ( "ncfd_used_played" == str_flag_name && !level utility::flag( "warden_ncfd_used_played" ) )
        {
            level utility::flag_set( "warden_ncfd_used_played" );
            wait 1;
            zm_quest::function_d5ef98341fd6a057( [ #"hash_b17d0a571d56c1da" ] );
        }
    }
    else if ( isplayer( player ) )
    {
        player utility::ent_flag_clear( str_flag_name );
    }
    
    if ( isplayer( player ) )
    {
        player utility::ent_flag_clear( str_flag_name + "_attempt" );
    }
}

// Namespace zm_ncfdpedestal
// Params 3, eflags: 0x4
// Checksum 0x2fdd742b, Offset: 0x146e
// Size: 0x4e
function private function_ac6eb8bced699d62( origin, radius, angle )
{
    offset = ( radius * cos( angle ), radius * sin( angle ), 0 );
    point = origin + offset;
    return point;
}

// Namespace zm_ncfdpedestal
// Params 1, eflags: 0x4
// Checksum 0x1f568e06, Offset: 0x14c5
// Size: 0x3f9
function private function_11887e625b15f6cf( pedestal )
{
    if ( !pedestal )
    {
        return;
    }
    
    pedestal endon( #"hash_4781858bff25026f" );
    
    if ( pedestal.eye_moving || pedestal.var_c62a3e81dd2e88bd )
    {
        return;
    }
    
    pedestal.eye_moving = 1;
    start_origin = ( self.origin[ 0 ] + 32, self.origin[ 1 ], self.origin[ 2 ] + 32 );
    final_origin = pedestal.origin + ( 0, 0, 0 );
    
    if ( !isdefined( level.var_cb500ca89b62b266 ) )
    {
        scr_eye = spawnscriptable( %"hash_1b0e4bdaf4d184c9", start_origin, pedestal.angles );
        level.var_cb500ca89b62b266 = scr_eye;
    }
    else
    {
        scr_eye = level.var_cb500ca89b62b266;
    }
    
    if ( !isdefined( level.var_851d59fc0145cbf0 ) )
    {
        e_mover = spawn( "script_model", scr_eye.origin );
        e_mover setmodel( "tag_origin" );
        scr_eye utility::scriptable_setparententity( e_mover );
        e_mover.origin = self gettagorigin( "j_wrist_le" );
        level.var_851d59fc0145cbf0 = e_mover;
    }
    else
    {
        e_mover = level.var_851d59fc0145cbf0;
        level.var_851d59fc0145cbf0 notify( #"end_player_watch" );
        scr_eye utility::scriptable_clearparententity();
        scr_eye utility::scriptable_setparententity( e_mover );
        e_mover.origin = self gettagorigin( "j_wrist_le" );
    }
    
    scr_eye setscriptablepartstate( "base", "upgrading" );
    point_1 = function_ac6eb8bced699d62( final_origin, 20, 0 );
    point_2 = function_ac6eb8bced699d62( final_origin, 20, 90 );
    point_3 = function_ac6eb8bced699d62( final_origin, 20, 180 );
    point_4 = function_ac6eb8bced699d62( final_origin, 20, 270 );
    right = vectornormalize( anglestoright( self.angles ) );
    right = ( right[ 0 ], right[ 1 ], 0 );
    var_60fe9ccd6db18b0d = vectornormalize( point_1 - self.origin );
    var_60fe9ccd6db18b0d = ( var_60fe9ccd6db18b0d[ 0 ], var_60fe9ccd6db18b0d[ 1 ], 0 );
    var_60fe99cd6db18474 = vectornormalize( point_2 - self.origin );
    var_60fe99cd6db18474 = ( var_60fe99cd6db18474[ 0 ], var_60fe99cd6db18474[ 1 ], 0 );
    var_60fe9acd6db186a7 = vectornormalize( point_3 - self.origin );
    var_60fe9acd6db186a7 = ( var_60fe9acd6db186a7[ 0 ], var_60fe9acd6db186a7[ 1 ], 0 );
    var_60fe97cd6db1800e = vectornormalize( point_4 - self.origin );
    var_60fe97cd6db1800e = ( var_60fe97cd6db1800e[ 0 ], var_60fe97cd6db1800e[ 1 ], 0 );
    dot_1 = vectordot( right, var_60fe9ccd6db18b0d );
    dot_2 = vectordot( right, var_60fe99cd6db18474 );
    dot_3 = vectordot( right, var_60fe9acd6db186a7 );
    dot_4 = vectordot( right, var_60fe97cd6db1800e );
    
    if ( dot_1 > 0.1 )
    {
        e_mover moveto( point_1, 0.5, 0.5 );
        degrees = 0;
    }
    else if ( dot_2 > 0.1 )
    {
        e_mover moveto( point_2, 0.5, 0.5 );
        degrees = 90;
    }
    else if ( dot_3 > 0.1 )
    {
        e_mover moveto( point_3, 0.5, 0.5 );
        degrees = 180;
    }
    else if ( dot_4 > 0.1 )
    {
        e_mover moveto( point_4, 0.5, 0.5 );
        degrees = 270;
    }
    else
    {
        e_mover moveto( point_1, 0.5, 0.5 );
        degrees = 0;
    }
    
    wait 1;
    
    while ( !pedestal.var_c62a3e81dd2e88bd && isdefined( e_mover ) )
    {
        e_mover.origin = function_ac6eb8bced699d62( final_origin, 20, degrees );
        degrees += 5;
        waitframe();
    }
    
    pedestal.eye_moving = undefined;
}

// Namespace zm_ncfdpedestal
// Params 1, eflags: 0x4
// Checksum 0x646920b9, Offset: 0x18c6
// Size: 0x48
function private getclosestplayer( origin )
{
    if ( !isdefined( level.players ) )
    {
        return level.player;
    }
    else if ( level.players.size == 0 )
    {
        return;
    }
    
    return sortbydistance( level.players, origin )[ 0 ];
}

// Namespace zm_ncfdpedestal
// Params 0
// Checksum 0x12dbaa19, Offset: 0x1917
// Size: 0xd6
function function_a67361ffee16b320()
{
    self notify( #"hash_c9ad0cb21a843c23" );
    self endon( #"hash_c9ad0cb21a843c23" );
    self endon( #"death" );
    level.var_851d59fc0145cbf0 endon( #"end_player_watch" );
    
    while ( true )
    {
        closestplayer = getclosestplayer( self.origin );
        
        if ( isplayer( closestplayer ) && isalive( closestplayer ) )
        {
            angles_to_player = vectortoangles( closestplayer.origin - self.origin );
            var_45ad5b627b21e31 = ( self.angles[ 0 ], angles_to_player[ 1 ], self.angles[ 2 ] );
            level.var_851d59fc0145cbf0 rotateto( var_45ad5b627b21e31, 0.5, 0, 0 );
        }
        
        wait 0.5;
    }
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x8353aa17, Offset: 0x19f5
// Size: 0x1ea
function function_43458e4673e5800b( player )
{
    self notify( #"hash_6c11727a17bd0b38" );
    self endon( #"hash_6c11727a17bd0b38" );
    player playrumblelooponentity( "low_highfreq" );
    
    if ( !level.var_cc9ca324f86bc5e8 )
    {
        level.var_cc9ca324f86bc5e8 = 1;
    }
    else
    {
        return 0;
    }
    
    params = { #var_5ac1788a1dff4c92:1, #var_27fce690e19877a5:1, #hud_description:&"hash_4e07944452345e8d", #gesture:"sat_zm_vm_ges_ruby_hallucination_touch", #saved_use_object:self, #save_progress:0, #var_b35caf93a1ae502d:self, #hold_time:5, #craft_reason:#"hash_234602ce81ae619b" };
    player thread function_11887e625b15f6cf( self );
    result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
    
    if ( result && isplayer( player ) )
    {
        if ( !self.var_c62a3e81dd2e88bd )
        {
            level.var_3c874d3f031f6c50 = undefined;
            level callback::callback( #"hash_234602ce81ae619b", { #player:player, #scriptable:self } );
            self.var_c62a3e81dd2e88bd = 1;
            self.pedestal.vfx.var_c62a3e81dd2e88bd = 1;
            self.pedestal.vfx_off.var_c62a3e81dd2e88bd = 1;
        }
    }
    else
    {
        if ( level.var_cb500ca89b62b266 )
        {
            level.var_cb500ca89b62b266 utility::scriptable_clearparententity();
            level.var_cb500ca89b62b266 freescriptable();
            level.var_cb500ca89b62b266 = undefined;
        }
        
        self.eye_moving = undefined;
        self notify( #"hash_4781858bff25026f" );
    }
    
    if ( player )
    {
        player stoprumble( "low_highfreq" );
    }
    
    level.var_cc9ca324f86bc5e8 = undefined;
    return result;
}

// Namespace zm_ncfdpedestal
// Params 2
// Checksum 0x2100611, Offset: 0x1be8
// Size: 0x18b
function function_a296e3fa63e78600( interact, player )
{
    if ( !utility::callsharedfunc( #"ncfd", #"hash_81eb587ae514df01" ) || player.interactions_disabled || player.var_bf04dca5dc0d2edc )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level.var_3c874d3f031f6c50 && !self.var_c62a3e81dd2e88bd && zm_quest::function_b0a5181ebe7bb905() )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_7d7d2c21ef8c4e4b", #type:"HINT_BUTTON" };
    }
    
    if ( player.var_819dfee5ff9a56d6 || player.var_87522aee8be7890b || player.n_charge_times >= level.var_b6a4b93f9f863428 )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( interact.var_c62a3e81dd2e88bd )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_fa83b4a4a2e5549", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_50cf75f9e8e6ac58", #type:"HINT_BUTTON" };
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0xebc5d1b3, Offset: 0x1d7b
// Size: 0xaf
function give_grappling_hook( pedestal )
{
    if ( pedestal.var_c62a3e81dd2e88bd )
    {
        self.var_32e68c63905a0787 = 1;
        str_state = "on_upgraded";
        str_equip_ref = "equip_grappling_hook_upgraded";
        
        if ( level.var_cb500ca89b62b266 && !level.var_cb500ca89b62b266 function_50b79f4d4032e234( self ) )
        {
            level.var_cb500ca89b62b266 function_d6a7b7ef13a57f38( self );
        }
    }
    else
    {
        self.var_32e68c63905a0787 = undefined;
        str_state = "on";
        str_equip_ref = "equip_grappling_hook";
    }
    
    self enableoffhandweapons();
    equipment_mp::giveequipment( str_equip_ref, "secondary" );
    self setscriptablepartstate( "ncfd_pedestal_charge", str_state );
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0xddb1b21f, Offset: 0x1e32
// Size: 0xb4
function function_9705041607dc48de( starttime )
{
    self notify( #"hash_b3a837dbaced413b" );
    self endon( #"hash_b3a837dbaced413b" );
    self endon( #"hash_3dc891bbb01bfa85" );
    self endon( #"death_or_disconnect" );
    
    while ( isalive( self ) && self.var_819dfee5ff9a56d6 )
    {
        time_passed = ( gettime() - starttime ) / 1000;
        time_percent = time_passed / self.var_5c53eb107f4e413c;
        time_percent = 1 - time_percent;
        
        if ( time_percent <= 0 )
        {
            time_percent = 0.01;
            self setclientomnvar( "ui_tactical_recharge_progress", time_percent );
            return;
        }
        
        self setclientomnvar( "ui_tactical_recharge_progress", time_percent );
        wait 1;
    }
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x5c18517b, Offset: 0x1eee
// Size: 0xc0
function on_player_death( params )
{
    self.crafting_table_disabled = undefined;
    
    if ( self.var_819dfee5ff9a56d6 )
    {
        self.var_819dfee5ff9a56d6 = 0;
        level callback::callback( #"hash_9595b4413b1af76a", { #player:self } );
    }
    
    if ( self.var_87522aee8be7890b )
    {
        self.var_87522aee8be7890b = undefined;
    }
    
    if ( level.var_cb500ca89b62b266 && level.var_cb500ca89b62b266 function_50b79f4d4032e234( self ) )
    {
        level.var_cb500ca89b62b266 function_6113853a877d5460( self );
        level.var_cb500ca89b62b266 setscriptablepartstate( "base", "restart_upgraded" );
    }
    
    self setclientomnvar( "ui_tactical_recharge_progress", 1 );
    self setscriptablepartstate( "ncfd_pedestal_charge", "off" );
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0xa5623b9c, Offset: 0x1fb6
// Size: 0x97
function function_27054ee6a0b84dde( pedestal )
{
    if ( !isdefined( self.var_5c53eb107f4e413c ) )
    {
        self.var_5c53eb107f4e413c = 0;
    }
    
    if ( pedestal.var_c62a3e81dd2e88bd )
    {
        self.var_5c53eb107f4e413c += 30;
    }
    
    if ( self.mask_ee.var_73e37bf886655ce7 && self.mask_ee.var_73e37bf886655ce7.ref == "zmloot_scarab_grp_ee_mask" )
    {
        self.var_5c53eb107f4e413c += 30;
    }
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x9f2b07e9, Offset: 0x2055
// Size: 0x122
function function_8e1671683c63ebb6( pedestal )
{
    self notify( #"hash_3ccc9c4ea5185d97" );
    self endon( #"hash_3ccc9c4ea5185d97" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"force_end_grapple" );
    
    if ( self.var_819dfee5ff9a56d6 )
    {
        if ( self.var_5c53eb107f4e413c != 0 )
        {
            self.var_5c53eb107f4e413c = 0;
        }
    }
    
    function_27054ee6a0b84dde( pedestal );
    self.var_819dfee5ff9a56d6 = 1;
    self.crafting_table_disabled = 1;
    function_44f4352c565336();
    self setclientomnvar( "ui_tactical_recharge_progress", 1 );
    
    if ( !isdefined( self.var_5c53eb107f4e413c ) )
    {
        self.var_5c53eb107f4e413c = 0;
    }
    
    self.var_5c53eb107f4e413c += level.var_2f39759a21e00f9f;
    function_9705041607dc48de( gettime() );
    wait 0.1;
    self.var_5c53eb107f4e413c = 0;
    
    while ( utility::ent_flag( "is_usurped_power_grabbed" ) || self function_41360f0bcfc012aa() )
    {
        waitframe();
    }
    
    utility::function_7c10ea82c1e305b8( "ncfd_pedestal_charge", "turn_off" );
    wait 1;
    thread function_26af4fa33bfe67cd();
}

// Namespace zm_ncfdpedestal
// Params 1
// Checksum 0x42a24d55, Offset: 0x217f
// Size: 0x185
function force_end_grapple( params )
{
    /#
        if ( params[ 0 ] == "<dev string:x64>" )
        {
            foreach ( player in level.players )
            {
                player notify( #"force_end_grapple" );
                player notify( #"hash_3dc891bbb01bfa85" );
                player utility::function_7c10ea82c1e305b8( "<dev string:x6f>", "<dev string:x84>" );
                player thread function_26af4fa33bfe67cd();
                player.var_819dfee5ff9a56d6 = 0;
                player setclientomnvar( "<dev string:x8d>", 1 );
                
                if ( level.var_cb500ca89b62b266 && level.var_cb500ca89b62b266 function_50b79f4d4032e234( player ) )
                {
                    level.var_cb500ca89b62b266 function_6113853a877d5460( player );
                    level.var_cb500ca89b62b266 setscriptablepartstate( "<dev string:xab>", "<dev string:xb0>" );
                }
                
                level callback::callback( #"hash_9595b4413b1af76a", { #player:player } );
            }
            
            return;
        }
    #/
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.crafting_table_disabled = undefined;
    self notify( #"force_end_grapple" );
    self notify( #"hash_3dc891bbb01bfa85" );
    utility::function_7c10ea82c1e305b8( "ncfd_pedestal_charge", "turn_off" );
    thread function_26af4fa33bfe67cd();
}

// Namespace zm_ncfdpedestal
// Params 0
// Checksum 0xf067a890, Offset: 0x230c
// Size: 0x102
function function_44f4352c565336()
{
    ref = equipment_mp::getcurrentequipment( "secondary" );
    currammo = equipment_mp::getequipmentammo( ref );
    
    if ( ref == "equip_grappling_hook" || ref == "equip_grappling_hook_upgraded" )
    {
        return;
    }
    
    if ( !isdefined( ref ) && utility::ent_flag( "is_usurped_power_grabbed" ) )
    {
        saved_tactical = self.a_saved_weapons[ "equip_secondary" ][ "weapon" ];
        
        if ( isdefined( saved_tactical ) )
        {
            item_name = saved_tactical.name;
            currammo = saved_tactical.count;
            item = getscriptbundle( item_name );
            ref = item.ref;
        }
    }
    
    self.var_87522aee8be7890b = spawnstruct();
    self.var_87522aee8be7890b.ref = ref;
    self.var_87522aee8be7890b.ammo = currammo;
    equipment_mp::takeequipment( "secondary" );
}

// Namespace zm_ncfdpedestal
// Params 0
// Checksum 0x85e387e9, Offset: 0x2416
// Size: 0xd6
function function_f0f025ab535f582d()
{
    if ( isdefined( self.var_87522aee8be7890b.ref ) )
    {
        equipment_mp::giveequipment( self.var_87522aee8be7890b.ref, "secondary" );
        
        if ( self.var_c27b25f4679be5f0 )
        {
            self.var_c27b25f4679be5f0 = undefined;
            max_ammo = equipment_mp::getequipmentmaxammo( self.var_87522aee8be7890b.ref );
            equipment_mp::setequipmentammo( self.var_87522aee8be7890b.ref, max_ammo );
        }
        else
        {
            equipment_mp::setequipmentammo( self.var_87522aee8be7890b.ref, self.var_87522aee8be7890b.ammo );
        }
    }
    
    self.var_87522aee8be7890b = undefined;
    self setclientomnvar( "ui_tactical_recharge_progress", 1 );
}

// Namespace zm_ncfdpedestal
// Params 0
// Checksum 0xf42ca8e6, Offset: 0x24f4
// Size: 0x131
function function_26af4fa33bfe67cd()
{
    self notify( #"hash_faa9a20c50df4607" );
    self endon( #"hash_faa9a20c50df4607" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( utility::ent_flag( "is_usurped_power_grabbed" ) || self function_41360f0bcfc012aa() )
    {
        waitframe();
    }
    
    self notify( #"hash_3dc891bbb01bfa85" );
    
    if ( isplayer( self ) )
    {
        equipment_mp::takeequipment( "secondary" );
    }
    
    utility::function_7c10ea82c1e305b8( "grappling_hook_speed_cam", "off" );
    self.var_7a1bba3b82189d4c = 1;
    wait 2;
    
    if ( isplayer( self ) )
    {
        self.var_7a1bba3b82189d4c = undefined;
        self.var_32e68c63905a0787 = undefined;
        function_f0f025ab535f582d();
        self.crafting_table_disabled = undefined;
        self.var_819dfee5ff9a56d6 = 0;
        self setclientomnvar( "ui_tactical_recharge_progress", 1 );
        
        if ( level.var_cb500ca89b62b266 && level.var_cb500ca89b62b266 function_50b79f4d4032e234( self ) )
        {
            level.var_cb500ca89b62b266 function_6113853a877d5460( self );
            level.var_cb500ca89b62b266 setscriptablepartstate( "base", "restart_upgraded" );
        }
        
        level callback::callback( #"hash_9595b4413b1af76a", { #player:self } );
    }
}

/#

    // Namespace zm_ncfdpedestal
    // Params 1
    // Checksum 0x3276a53, Offset: 0x262d
    // Size: 0xcc, Type: dev
    function function_2c099b12d59c7250( params )
    {
        foreach ( player in level.players )
        {
            player.var_819dfee5ff9a56d6 = 1;
            player notify( #"used_ncfd_pedestal" );
            player thread function_8e1671683c63ebb6();
            player give_grappling_hook( self );
            player.n_charge_times = 0;
            player callback::callback( #"hash_78694f61c22b5057" );
        }
    }

    // Namespace zm_ncfdpedestal
    // Params 0
    // Checksum 0x4e7b9de5, Offset: 0x2701
    // Size: 0x46, Type: dev
    function init_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:xc1>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd9>", "<dev string:xec>", &function_2c099b12d59c7250, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xff>", "<dev string:x111>", &force_end_grapple, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_ncfdpedestal
    // Params 0
    // Checksum 0x76ae6289, Offset: 0x274f
    // Size: 0x6a, Type: dev
    function drawsphere()
    {
        self notify( #"hash_e0b1cbc66207f72a" );
        self endon( #"hash_e0b1cbc66207f72a" );
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            color = ( 1, 1, 1 );
            sphere( self.origin, 20, color, 0 );
            waitframe();
        }
    }

#/
