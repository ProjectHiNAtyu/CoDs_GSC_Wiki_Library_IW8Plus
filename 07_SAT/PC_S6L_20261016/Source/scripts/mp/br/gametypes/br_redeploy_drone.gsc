// scripts\mp\br\gametypes\br_redeploy_drone.gsc  (hash_6afc6be6181e8577.gscc) (size: 45082 Bytes / 0xb01a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f7d2ecf (1065168591)
// size ...... 45082 (0xb01a)
// includes .. 22  (offset: 0xa73a)
// strings ... 75  (offset: 0xa7ea)
// dev strs .. 42  (offset: 0xad1a)
// exports ... 104 (offset: 0x74a6)
// cseg ...... 0x9a5 + 0x6b01 (0x74a6)
// imports ... 251 (offset: 0x84e6)
// animtree1 . 0   (offset: 0xaf9a)
// animtree2 . 8   (offset: 0xaf9a)
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\scriptable;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\flags;
#using scripts\mp\parachute;
#using scripts\mp\structspawnconfig;
#using scripts\mp\weapons;

#namespace br_redeploy_drone;

// Namespace br_redeploy_drone
// Params 0, eflags: 0x1
// Checksum 0xd8d1367b, Offset: 0x9c3
// Size: 0xa
function autoexec main()
{
    level thread function_ed6b67ba86cf1f74();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xe37a329a, Offset: 0x9d5
// Size: 0x5f
function function_ed6b67ba86cf1f74()
{
    waitframe();
    
    if ( !getdvarint( @"redeploy_ascenders_enabled", 0 ) )
    {
        return;
    }
    
    if ( level.gametype == "ob" || level.gametype == "ob_pvp" )
    {
        return;
    }
    
    if ( isdefined( level.var_6c903c6228695991 ) && !level.var_6c903c6228695991 )
    {
        return;
    }
    
    init();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x175fb086, Offset: 0xa3c
// Size: 0x8f
function init()
{
    /#
        level thread debug_init();
    #/
    
    function_3d109d207b3bed3c();
    initvariables();
    
    if ( level.redeploy_drone_info_struct.var_9ebe4eb7ada19a41 )
    {
        structspawnconfig::function_7418a260adaec05( "redeploy_drone", &function_e2f8d56220cffff5 );
        structspawnconfig::function_8c0a09968efe9138( "redeploy_drone", &spawn_redeploy_drone_single );
    }
    
    if ( level.redeploy_drone_info_struct.var_b25c414b8d1434de )
    {
        utility::registersharedfunc( #"redeploy_drone", #"redeploy_drone_repopulation_watcher", &redeploy_drone_repopulation_watcher );
    }
    
    level thread redeploy_drone_spawn_manager();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x372878a3, Offset: 0xad3
// Size: 0x168
function function_3d109d207b3bed3c()
{
    if ( level.var_f54b241031186114 )
    {
        return;
    }
    
    level.var_f54b241031186114 = 1;
    scriptable::scriptable_adddamagedcallback( &scriptable_redeploy_drone_damaged );
    scriptable::scriptable_addusedcallbackbypart( "redeploy_drone_interact", &function_d3b7bea5de5c72 );
    audio_utility::snd_transient_load( "eqp_redeploy_drone" );
    utility::registersharedfunc( #"redeploy_drone", #"precision_airstrike_death", &precision_airstrike_death );
    utility::registersharedfunc( #"redeploy_drone", #"get_closest_redeploy_drone", &get_closest_redeploy_drone );
    utility::registersharedfunc( #"redeploy_drone", #"dropbag_collision_watcher", &dropbag_collision_watcher );
    utility::registersharedfunc( #"redeploy_drone", #"redeploy_drone_destroyed", &redeploy_drone_destroyed );
    utility::registersharedfunc( %"hash_49602cb7beee6fba", #"handleWorldCollision", &function_ae129ad897a2887c );
    utility::registersharedfunc( %"hash_1dd941f8f4026e3", #"handleWorldCollision", &function_ae129ad897a2887c );
    utility::registersharedfunc( %"hash_873d4f44f8688af", #"handleWorldCollision", &function_ae129ad897a2887c );
    utility::registersharedfunc( %"hash_75f332a3f5f94027", #"handleWorldCollision", &function_ae129ad897a2887c );
    utility::registersharedfunc( %"hash_200f29150357b3c6", #"handleWorldCollision", &function_ae129ad897a2887c );
    level.var_c7c34c7053a29846 = getdvarint( @"hash_c977b0effe861ab8", 0 );
}

#using_animtree( "scriptables" );

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x76a28f1f, Offset: 0xc43
// Size: 0x6c4
function initvariables()
{
    level.redeploy_drone_info_struct = spawnstruct();
    level.redeploy_drone_info_struct.i_count = getdvarint( @"scr_redeploy_drone_count", 4 );
    level.redeploy_drone_info_struct.i_health = getdvarint( @"scr_redeploy_drone_health", 270 );
    level.redeploy_drone_info_struct.var_752a2de7a9a8ec9d = getdvarint( @"hash_fc06cf8b2e6ff7c8", 100 );
    level.redeploy_drone_info_struct.var_725b5a0d669b2688 = getdvarint( @"hash_4d3f3ddcf9c9ae8f", 2000 );
    level.redeploy_drone_info_struct.i_explosion_radius = getdvarint( @"scr_redeploy_drone_explosion_radius", 512 );
    level.redeploy_drone_info_struct.var_e287bb6858da1470 = getdvarint( @"scr_redeploy_drone_explosion_damage_min", 60 );
    level.redeploy_drone_info_struct.var_e264b16858b3b6ba = getdvarint( @"hash_3d7052323e9fd24d", 165 );
    level.redeploy_drone_info_struct.var_563ff6d850570b0 = getdvarint( @"hash_59ab4e81308f5bfb", 42 );
    level.redeploy_drone_info_struct.var_93c50a30cdabecab = getdvarint( @"scr_redeploy_drone_despawn_index", 3 );
    level.redeploy_drone_info_struct.var_9e437065f024b3dd = getdvarfloat( @"hash_590a91e3623c94d", 4 );
    level.redeploy_drone_info_struct.var_b250d13e6f70f782 = getdvarfloat( @"hash_54123d8a1fcc2b5e", -999 );
    level.redeploy_drone_info_struct.var_b25c414b8d1434de = getdvarint( @"hash_fea84386244345fd", 0 );
    level.redeploy_drone_info_struct.var_282669dff723ff8 = getdvarint( @"hash_3cd8f7500c4cffcb", 30 );
    level.redeploy_drone_info_struct.var_c91738a31073297d = getdvarint( @"hash_7a6046af43f645a", 10 );
    level.redeploy_drone_info_struct.var_d0553b05b6a9d317 = getdvarint( @"hash_67144a280e505eb0", 10 );
    level.redeploy_drone_info_struct.i_max_speed = getdvarint( @"scr_redeploy_drone_max_speed", 50 );
    level.redeploy_drone_info_struct.var_b532046b2ae6c118 = getdvarint( @"scr_redeploy_drone_replace_enabled", 1 );
    level.redeploy_drone_info_struct.var_531c104023c0b6c7 = getdvarfloat( @"hash_f5fd01a154a295b7", 120 );
    level.redeploy_drone_info_struct.var_9ebe4eb7ada19a41 = getdvarint( @"scr_ssc_use_redeploy_drone", 1 ) && getdvarint( @"scr_ssc_enabled", 1 );
    var_e304f85506f34c20 = getdvarint( @"hash_9bd3724f70106775", 9000 );
    level.redeploy_drone_info_struct.var_2e5a2c13083fe991 = squared( var_e304f85506f34c20 );
    var_8318ed3598692919 = getdvarint( @"hash_59c137234dad4ad6", 7000 );
    level.redeploy_drone_info_struct.var_10fed330f6746fa6 = squared( var_8318ed3598692919 );
    level.redeploy_drone_info_struct.var_12bfa36b3396fee1 = getmatchrulesdata( "commonOption", "parachuteOverheadWarningRadius" );
    level.redeploy_drone_info_struct.var_bb39751f42ca73bc = getmatchrulesdata( "commonOption", "parachuteOverheadWarningHeight" );
    level.redeploy_drone_info_struct.var_7a0ef63e9d1bf5cb = getmatchrulesdata( "commonOption", "parachuteOverheadWarningTimeoutMs" );
    level.redeploy_drone_info_struct.var_70f8f33c72450ba = [];
    level.redeploy_drone_info_struct.var_70f8f33c72450ba[ "veh9_mil_air_drone_redeploy_relocate" ] = getanimlength( %veh9_mil_air_drone_redeploy_extend_hook_01_alt );
    level.redeploy_drone_info_struct.var_70f8f33c72450ba[ "veh9_mil_air_drone_redeploy_relocate_extended" ] = getanimlength( %veh9_mil_air_drone_redeploy_extend_hook_02 );
    level.redeploy_drone_info_struct.var_70f8f33c72450ba[ "veh9_mil_air_drone_redeploy_relocate_short" ] = getanimlength( %veh9_mil_air_drone_redeploy_extend_hook_short_alt );
    level.redeploy_drone_info_struct.var_70f8f33c72450ba[ "veh9_mil_air_drone_redeploy_relocate_very_short" ] = getanimlength( %veh9_mil_air_drone_redeploy_extend_hook_very_short_alt );
    level.redeploy_drone_info_struct.var_f662574871be8bd2 = [];
    level.redeploy_drone_info_struct.var_f662574871be8bd2[ "veh9_mil_air_drone_redeploy_relocate" ] = getanimlength( %veh9_mil_air_drone_redeploy_retract_hook_01_alt );
    level.redeploy_drone_info_struct.var_f662574871be8bd2[ "veh9_mil_air_drone_redeploy_relocate_extended" ] = getanimlength( %veh9_mil_air_drone_redeploy_retract_hook_02 );
    level.redeploy_drone_info_struct.var_f662574871be8bd2[ "veh9_mil_air_drone_redeploy_relocate_short" ] = getanimlength( %veh9_mil_air_drone_redeploy_retract_hook_short_alt );
    level.redeploy_drone_info_struct.var_f662574871be8bd2[ "veh9_mil_air_drone_redeploy_relocate_very_short" ] = getanimlength( %veh9_mil_air_drone_redeploy_retract_hook_very_short_alt );
    level.redeploy_drone_info_struct.var_dc2234786c8913dd = function_e2f8d56220cffff5( undefined );
    level.redeploy_drone_info_struct.var_2bfdfa4dca37bac4 = level.redeploy_drone_info_struct.var_dc2234786c8913dd;
    level.redeploy_drone_info_struct.var_531f28cf3d055c11 = level.redeploy_drone_info_struct.var_dc2234786c8913dd;
    
    if ( isdefined( level.redeploy_drone_info_struct.var_dc2234786c8913dd ) )
    {
        foreach ( redeploy_drone in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
        {
            if ( isdefined( redeploy_drone ) )
            {
                redeploy_drone.isredeploydrone = 1;
            }
        }
    }
    
    level.redeploy_drone_info_struct.var_251b2c6b71a01138 = 1;
    
    if ( isdefined( level.br_level ) && isdefined( level.br_level.c130_speedoverride ) )
    {
        level.redeploy_drone_info_struct.var_251b2c6b71a01138 = level.br_level.c130_speedoverride / 3044;
    }
    
    level.redeploy_drone_info_struct.var_416151fca5c5b862 = [];
    level.redeploy_drone_info_struct.movingdrones = [];
    level.redeploy_drone_info_struct.var_69654e31920f8e38 = [];
    level.redeploy_drone_relocate_throttle = throttle::throttle_initialize( "redeployDroneRelocate", 1, level.framedurationseconds );
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0xf49da5aa, Offset: 0x130f
// Size: 0x1a
function function_e2f8d56220cffff5( structname )
{
    return getentitylessscriptablearray( "scriptable_scriptable_redeploy_drone", "classname" );
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x63a75577, Offset: 0x1332
// Size: 0x3d
function redeploy_drone_spawn_manager()
{
    waitframe();
    spawn_redeploy_drones();
    
    while ( !isdefined( level.br_ac130 ) )
    {
        wait 0.05;
    }
    
    level notify( #"respawn_redeploy_drones" );
    level thread respawn_redeploy_drones();
    level thread despawn_redeploy_drones();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xb31676a, Offset: 0x1377
// Size: 0x15a
function spawn_redeploy_drones()
{
    if ( !level.redeploy_drone_info_struct.var_531f28cf3d055c11.size )
    {
        return;
    }
    
    function_713e11f8f6f563e8();
    
    if ( !level.redeploy_drone_info_struct.var_9ebe4eb7ada19a41 )
    {
        function_e6a3b10a4a325792();
        
        foreach ( scriptable in level.redeploy_drone_info_struct.var_531f28cf3d055c11 )
        {
            scriptable thread spawn_redeploy_drone();
        }
    }
    
    for ( i = 0; i < level.redeploy_drone_info_struct.var_531f28cf3d055c11.size ; i++ )
    {
        if ( level.redeploy_drone_info_struct.var_531f28cf3d055c11[ i ] getscriptablepartstate( "redeploy_drone" ) != "available" )
        {
            level.redeploy_drone_info_struct.var_531f28cf3d055c11 = arrayremove( level.redeploy_drone_info_struct.var_531f28cf3d055c11, level.redeploy_drone_info_struct.var_531f28cf3d055c11[ i ] );
            i--;
        }
    }
}

// Namespace br_redeploy_drone
// Params 2
// Checksum 0xb3c66f69, Offset: 0x14d9
// Size: 0x58
function spawn_redeploy_drone_single( structname, dronestruct )
{
    dronestruct thread spawn_redeploy_drone();
    size = level.redeploy_drone_info_struct.var_531f28cf3d055c11.size;
    level.redeploy_drone_info_struct.var_531f28cf3d055c11[ size ] = dronestruct;
    return dronestruct;
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x423ff9f9, Offset: 0x153a
// Size: 0x3b
function spawn_redeploy_drone()
{
    set_redeploy_drone_available();
    self setscriptablepartstate( "redeploy_drone_sfx", "engine_idle_sfx" );
    health_init();
    weapons::function_ef0cb557b1a93af9( self );
    flags::gameflagwait( "infil_animatic_complete" );
    thread function_1903b4a3be0118f1();
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0xd1b762a3, Offset: 0x157d
// Size: 0x100
function redeploy_drone_emp( data )
{
    replace = 0;
    
    if ( !self.b_skip_repopulate && level.redeploy_drone_info_struct.var_b25c414b8d1434de )
    {
        level thread redeploy_drone_repopulation_watcher( self );
    }
    else if ( !self.b_skip_replace && level.redeploy_drone_info_struct.var_b532046b2ae6c118 )
    {
        replace = 1;
        level thread function_8dd2309a67900f1f( self );
    }
    
    vehicleowner = undefined;
    
    if ( isdefined( data.attacker ) && isdefined( data.attacker.owner ) )
    {
        vehicleowner = data.attacker.owner;
    }
    
    if ( isdefined( vehicleowner ) )
    {
        redeploy_drone_destroyed( vehicleowner, self.model, undefined, replace );
        return;
    }
    
    redeploy_drone_destroyed( data.attacker, self.model, undefined, replace );
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0x1327536b, Offset: 0x1685
// Size: 0x106
function function_655132aeb9577cc6( data )
{
    if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, self ) )
    {
        level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, self );
    }
    
    if ( self.destination_scriptable.isredeploydrone )
    {
        if ( !self.b_skip_repopulate && level.redeploy_drone_info_struct.var_b25c414b8d1434de )
        {
            level thread redeploy_drone_repopulation_watcher( self.destination_scriptable );
        }
        else if ( !self.b_skip_replace && level.redeploy_drone_info_struct.var_b532046b2ae6c118 )
        {
            level thread function_8dd2309a67900f1f( self.destination_scriptable );
        }
        
        self.destination_scriptable.b_occupied = 0;
    }
    
    redeploy_drone_relocate_destroyed( data.attacker, self.model );
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x3519bd16, Offset: 0x1793
// Size: 0x28c
function respawn_redeploy_drones()
{
    level.redeploy_drone_info_struct.var_416151fca5c5b862 = function_5713d46873b29625( level.redeploy_drone_info_struct.var_416151fca5c5b862 );
    level.redeploy_drone_info_struct.movingdrones = function_5713d46873b29625( level.redeploy_drone_info_struct.movingdrones );
    
    for ( i = 0; i < level.redeploy_drone_info_struct.var_416151fca5c5b862.size ; i++ )
    {
        drone = level.redeploy_drone_info_struct.var_416151fca5c5b862[ i ];
        level.redeploy_drone_info_struct.var_416151fca5c5b862 = arrayremove( level.redeploy_drone_info_struct.var_416151fca5c5b862, drone );
        
        if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
        {
            level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
        }
        
        drone delete();
        i--;
    }
    
    level.redeploy_drone_info_struct.var_416151fca5c5b862 = undefined;
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        scriptable set_redeploy_drone_in_gas();
        
        /#
            scriptable function_a8470b55ba93350();
        #/
    }
    
    if ( !level.redeploy_drone_info_struct.var_9ebe4eb7ada19a41 && br_gametypes::isfeatureenabled( #"circleearlystart" ) )
    {
        function_e6a3b10a4a325792();
    }
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_531f28cf3d055c11 )
    {
        if ( getdvarint( @"hash_8cc1035ee7514c26", 0 ) )
        {
            scriptable thread redeploy_drone_infil();
            continue;
        }
        
        scriptable thread spawn_redeploy_drone();
    }
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x9103e908, Offset: 0x1a27
// Size: 0x229
function function_e6a3b10a4a325792()
{
    redeploy_spawns = arrayrandomize( level.redeploy_drone_info_struct.var_2bfdfa4dca37bac4 );
    b_prematch_done = flags::gameflag( "prematch_done" );
    level.redeploy_drone_info_struct.var_531f28cf3d055c11 = [];
    i_spawned = 0;
    
    foreach ( scriptable in redeploy_spawns )
    {
        if ( isdefined( scriptable.script_noteworthy ) && scriptable.script_noteworthy != "redeploy_drone_spawn" )
        {
            continue;
        }
        
        if ( i_spawned >= level.redeploy_drone_info_struct.i_count )
        {
            /#
                scriptable thread function_40b374f871ce7b65();
            #/
            
            continue;
        }
        
        if ( b_prematch_done && scriptable is_redeploy_drone_in_gas() )
        {
            /#
                scriptable thread function_40b374f871ce7b65();
            #/
            
            continue;
        }
        
        b_valid_spawn = 1;
        
        foreach ( other in redeploy_spawns )
        {
            if ( !arraycontains( level.redeploy_drone_info_struct.var_531f28cf3d055c11, other ) )
            {
                continue;
            }
            
            if ( distance2dsquared( scriptable.origin, other.origin ) > level.redeploy_drone_info_struct.var_2e5a2c13083fe991 )
            {
                continue;
            }
            
            b_valid_spawn = 0;
            
            /#
                scriptable thread function_40b374f871ce7b65();
            #/
            
            break;
        }
        
        if ( b_valid_spawn )
        {
            level.redeploy_drone_info_struct.var_531f28cf3d055c11[ i_spawned ] = scriptable;
            i_spawned++;
        }
    }
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xb7681ff6, Offset: 0x1c58
// Size: 0x228
function function_d2571bfea20527f5()
{
    minx = level.mapcorners[ 0 ].origin[ 0 ];
    maxx = level.mapcorners[ 1 ].origin[ 0 ];
    miny = level.mapcorners[ 1 ].origin[ 1 ];
    maxy = level.mapcorners[ 0 ].origin[ 1 ];
    var_dcb7210a96d1a0fb = anglestoforward( level.br_ac130.angles ) * -1;
    t_left = ( minx - self.origin[ 0 ] ) / var_dcb7210a96d1a0fb[ 0 ];
    t_right = ( maxx - self.origin[ 0 ] ) / var_dcb7210a96d1a0fb[ 0 ];
    t_top = ( miny - self.origin[ 1 ] ) / var_dcb7210a96d1a0fb[ 1 ];
    t_bottom = ( maxy - self.origin[ 1 ] ) / var_dcb7210a96d1a0fb[ 1 ];
    t = -1;
    
    if ( t_left > 0 && ( t < 0 || t_left < t ) )
    {
        t = t_left;
    }
    
    if ( t_right > 0 && ( t < 0 || t_right < t ) )
    {
        t = t_right;
    }
    
    if ( t_top > 0 && ( t < 0 || t_top < t ) )
    {
        t = t_top;
    }
    
    if ( t_bottom > 0 && ( t < 0 || t_bottom < t ) )
    {
        t = t_bottom;
    }
    
    if ( t >= 0 )
    {
        t += distance2d( self.origin, level.br_ac130.origin );
        spawnx = self.origin[ 0 ] + t * var_dcb7210a96d1a0fb[ 0 ];
        spawny = self.origin[ 1 ] + t * var_dcb7210a96d1a0fb[ 1 ];
        planeheight = level.br_ac130.origin[ 2 ];
        return ( spawnx, spawny, planeheight );
    }
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xa5eff92, Offset: 0x1e89
// Size: 0x4e9
function redeploy_drone_infil()
{
    flags::gameflagwait( "infil_animatic_complete" );
    v_spawn = function_d2571bfea20527f5();
    
    if ( !isdefined( v_spawn ) )
    {
        f_right_dot = vectordot( anglestoright( level.br_ac130.angles ), vectornormalize( self.origin - level.br_ac130.origin ) );
        v_spawn = level.br_ac130.origin + anglestoforward( level.br_ac130.angles ) * -1 * ( distance( level.br_ac130.origin, self.origin ) - 40000 ) + anglestoright( level.br_ac130.angles ) * 15000 * f_right_dot;
    }
    
    var_59a9f6269998cd9a = 100;
    var_59cce02699bee4f0 = parachute::getc130height() - 4000;
    var_59a9ec269998b79c = var_59a9f6269998cd9a + var_59cce02699bee4f0 / 2;
    var_5b5fb127b73a395b = ( var_59cce02699bee4f0 - var_59a9f6269998cd9a ) / 2;
    f_forward_dot = vectordot( anglestoforward( level.br_ac130.angles ), vectornormalize( v_spawn - level.br_ac130.origin ) );
    f_z_offset = var_59a9ec269998b79c + var_5b5fb127b73a395b * f_forward_dot;
    v_spawn += ( 0, 0, -1 * f_z_offset );
    drone = spawn( "script_model", v_spawn );
    drone setmodel( "veh9_mil_air_drone_redeploy_relocate" );
    drone.angles = vectortoangles( self.origin - drone.origin );
    var_197c61b16b417511 = level.redeploy_drone_info_struct.i_max_speed * 5 * level.redeploy_drone_info_struct.var_251b2c6b71a01138;
    drone.speed = var_197c61b16b417511;
    drone.health = level.redeploy_drone_info_struct.i_health;
    drone.type = self.type;
    drone setcandamage( 1 );
    drone forcenetfieldhighlod( 1 );
    level.redeploy_drone_info_struct.movingdrones[ level.redeploy_drone_info_struct.movingdrones.size ] = drone;
    
    if ( level.var_c7c34c7053a29846 )
    {
        drone emp_debuff::set_apply_emp_callback( &function_655132aeb9577cc6 );
        drone.var_5b3dbacfeda0fd01 = &function_655132aeb9577cc6;
    }
    
    /#
        if ( getdvarint( @"scr_debug_redeploy_drones", 0 ) )
        {
            debug::sphere( drone, 25, ( 1, 0, 0 ), undefined, "<dev string:x24>", "<dev string:x4c>" );
            debug::draw_angles( drone, undefined, 150, undefined, "<dev string:x24>", "<dev string:x4c>" );
        }
    #/
    
    movementparameters = function_4932b017680a36b1();
    movementparameters.i_min_speed = 0;
    movementparameters.i_max_speed = var_197c61b16b417511;
    movementparameters.var_551db378f3d8f9d9 = var_197c61b16b417511 * 20 * level.redeploy_drone_info_struct.var_251b2c6b71a01138;
    movementparameters.var_97160ac0ed09c3bb = 0.05 / level.redeploy_drone_info_struct.var_251b2c6b71a01138;
    drone thread function_f8019c12697fcf50( self, movementparameters );
    drone thread function_76cb6eb6a9700637( self, movementparameters );
    drone thread redeploy_drone_sfx_watcher( undefined, self, movementparameters );
    
    while ( !( isdefined( drone.b_movement_complete ) && isdefined( drone.var_fe7274eb7e5153e7 ) ) )
    {
        if ( drone.health <= 0 )
        {
            if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
            {
                level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
            }
            
            return;
        }
        
        wait 0.05;
    }
    
    drone cable_deploy();
    
    if ( !isalive( drone ) )
    {
        if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
        {
            level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
        }
        
        return;
    }
    
    drone notify( #"relocation_complete" );
    self.health = drone.health;
    
    if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
    {
        level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
    }
    
    drone delete();
    set_redeploy_drone_available();
    thread function_1903b4a3be0118f1();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xefc762e9, Offset: 0x237a
// Size: 0x1c9
function function_713e11f8f6f563e8()
{
    collisioncontents = physics_createcontents( [ "physicscontents_aiclip", "physicscontents_water" ] );
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        trace = trace::ray_trace( scriptable.origin, scriptable.origin + ( 0, 0, -3000 ), undefined, collisioncontents, 1, 1, 0 );
        scriptable.str_surftype = trace[ "surfacetype" ];
        scriptable.var_bd4fec0091dedb5c = trace[ "position" ];
    }
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_2bfdfa4dca37bac4 )
    {
        trace = trace::ray_trace( scriptable.origin, scriptable.origin + ( 0, 0, -3000 ), undefined, collisioncontents, 1, 1, 0 );
        scriptable.str_surftype = trace[ "surfacetype" ];
        scriptable.var_bd4fec0091dedb5c = trace[ "position" ];
    }
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x37b3ed07, Offset: 0x254b
// Size: 0x10a
function set_redeploy_drone_available()
{
    self setscriptablepartstate( "redeploy_drone", "available" );
    self.b_occupied = 1;
    self.b_used = 1;
    
    if ( level.var_c7c34c7053a29846 )
    {
        emp_debuff::set_apply_emp_callback( &redeploy_drone_emp );
        self.var_5b3dbacfeda0fd01 = &redeploy_drone_emp;
    }
    
    weapons::function_ef0cb557b1a93af9( self );
    
    /#
        function_65401ca948591d1e();
    #/
    
    if ( !isdefined( self.var_bd4fec0091dedb5c ) )
    {
        assertmsg( "<dev string:x79>" + self.origin + "<dev string:x8b>" );
        self.var_bd4fec0091dedb5c = self.origin - ( 0, 0, 2727 );
    }
    
    thread spawn_anchor_impact_vfx( self.var_bd4fec0091dedb5c, self.str_surftype );
    
    if ( !arraycontains( level.redeploy_drone_info_struct.var_69654e31920f8e38, self ) )
    {
        level.redeploy_drone_info_struct.var_69654e31920f8e38[ level.redeploy_drone_info_struct.var_69654e31920f8e38.size ] = self;
    }
}

// Namespace br_redeploy_drone
// Params 2
// Checksum 0x10dfb889, Offset: 0x265d
// Size: 0x117
function spawn_anchor_impact_vfx( surfaceposition, surfacetype )
{
    scr_impact_fx = spawnscriptable( "scriptable_redeploy_drone_anchor_impact", surfaceposition );
    
    if ( !isdefined( surfacetype ) )
    {
        surfacetype = "surftype_dirt";
    }
    
    switch ( surfacetype )
    {
        case #"hash_296fec58e16e327":
        case #"hash_588c5c47805606eb":
        case #"hash_5f33d5485b7f33ed":
        case #"hash_6dc36f3e31f59c8b":
            scr_impact_fx setscriptablepartstate( "redeploy_drone_anchor_impact", "impact_concrete" );
            break;
        case #"hash_1f2e430eca34d788":
        case #"hash_5ff12d0a2c109d2c":
        case #"hash_d4e7d6c49368be7f":
            scr_impact_fx setscriptablepartstate( "redeploy_drone_anchor_impact", "impact_dirt" );
            break;
        case #"hash_2fa4167540164873":
            scr_impact_fx setscriptablepartstate( "redeploy_drone_anchor_impact", "impact_metal" );
            break;
        case #"hash_2dc2bd39328def65":
        case #"hash_3990683480267242":
            scr_impact_fx setscriptablepartstate( "redeploy_drone_anchor_impact", "impact_water" );
            break;
    }
    
    wait 2;
    scr_impact_fx freescriptable();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xec273b4d, Offset: 0x277c
// Size: 0x7d
function set_redeploy_drone_unavailable()
{
    level notify( "redeploy_drone_kill_callout_" + self.origin );
    self setscriptablepartstate( "redeploy_drone", "unavailable" );
    self.b_occupied = 0;
    weapons::function_d5eafafe8f6a97bf( self );
    
    if ( arraycontains( level.redeploy_drone_info_struct.var_69654e31920f8e38, self ) )
    {
        level.redeploy_drone_info_struct.var_69654e31920f8e38 = arrayremove( level.redeploy_drone_info_struct.var_69654e31920f8e38, self );
    }
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xb1f25a55, Offset: 0x2801
// Size: 0x13
function set_redeploy_drone_in_gas()
{
    set_redeploy_drone_unavailable();
    
    /#
        function_21f17ba620ead39e();
    #/
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x21c2e063, Offset: 0x281c
// Size: 0x2b, Type: bool
function is_redeploy_drone_in_gas()
{
    if ( !isbrgamemode() )
    {
        return false;
    }
    
    if ( !level.br_prematchstarted )
    {
        return false;
    }
    
    return !br_circle_util::ispointindangercircle( self.origin );
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x58777c8a, Offset: 0x2850
// Size: 0x7f
function function_2d911c70cbf5caa8()
{
    level endon( #"game_ended" );
    level endon( #"respawn_redeploy_drones" );
    self endon( #"relocation_started" );
    
    if ( !isbrgamemode() )
    {
        return 0;
    }
    
    if ( !level.br_prematchstarted )
    {
        return 0;
    }
    
    while ( true )
    {
        if ( !br_circle_util::ispointindangercircle( self.origin ) )
        {
            self setscriptablepartstate( "redeploy_drone", "unavailable" );
            self notify( #"redeploy_drone_in_gas" );
            break;
        }
        
        wait 0.5;
    }
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xa5d9dbe8, Offset: 0x28d7
// Size: 0x20
function cable_deploy()
{
    self setscriptablepartstate( "redeploy_drone_relocation_sfx", "deploy" );
    thread deploy_icon();
    wait function_a0a77736a9d43739();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xea4840dd, Offset: 0x28ff
// Size: 0x5d
function function_a0a77736a9d43739()
{
    var_f002302f831854cf = undefined;
    
    if ( isdefined( self.model ) )
    {
        var_f002302f831854cf = level.redeploy_drone_info_struct.var_70f8f33c72450ba[ self.model ];
    }
    
    var_f002302f831854cf = var_f002302f831854cf ?? level.redeploy_drone_info_struct.var_70f8f33c72450ba[ "veh9_mil_air_drone_redeploy_relocate" ];
    return var_f002302f831854cf;
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x77d811d8, Offset: 0x2965
// Size: 0x2d
function deploy_icon()
{
    deploy_icon = spawnscriptable( "scriptable_redeploy_drone_deploy", self.origin );
    wait 0.8;
    deploy_icon freescriptable();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x554d93b5, Offset: 0x299a
// Size: 0x35
function cable_retract()
{
    self setscriptablepartstate( "redeploy_drone_relocation_sfx", "retract" );
    wait function_b62ee9471ee0cd75() - 0.7;
    self setscriptablepartstate( "redeploy_drone_cable_sfx", "retract_stop" );
    wait 0.7;
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xe61c5e5f, Offset: 0x29d7
// Size: 0x5d
function function_b62ee9471ee0cd75()
{
    var_9733e32c5e633bdb = undefined;
    
    if ( isdefined( self.model ) )
    {
        var_9733e32c5e633bdb = level.redeploy_drone_info_struct.var_f662574871be8bd2[ self.model ];
    }
    
    var_9733e32c5e633bdb = var_9733e32c5e633bdb ?? level.redeploy_drone_info_struct.var_f662574871be8bd2[ "veh9_mil_air_drone_redeploy_relocate" ];
    return var_9733e32c5e633bdb;
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xb12ae32b, Offset: 0x2a3d
// Size: 0x65
function health_init()
{
    /#
        if ( getdvarint( @"hash_bf9414a8359d7c0", 0 ) )
        {
            self.health = 1;
            self.maxhealth = 1;
            return;
        }
    #/
    
    self.health = level.redeploy_drone_info_struct.i_health;
    self.maxhealth = level.redeploy_drone_info_struct.i_health;
}

// Namespace br_redeploy_drone
// Params 11
// Checksum 0x94890810, Offset: 0x2aaa
// Size: 0x352
function scriptable_redeploy_drone_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isdefined( instance ) )
    {
        return;
    }
    
    if ( !instance.isredeploydrone )
    {
        return;
    }
    
    if ( idamage < 2 )
    {
        return;
    }
    
    if ( vpoint[ 2 ] < instance.origin[ 2 ] - 100 )
    {
        return;
    }
    
    if ( isplayer( eattacker ) )
    {
        eattacker damagefeedback::updatehitmarker( "standard", instance.health == 0, 0, 1, "hitequip" );
    }
    else if ( isplayer( eattacker.owner ) )
    {
        eattacker.owner damagefeedback::updatehitmarker( "standard", instance.health == 0, 0, 1, "hitequip" );
    }
    
    vehicleowner = undefined;
    
    if ( eattacker.model == "veh8_mil_air_lbravo_mp_flyable" || eattacker.model == "veh8_mil_air_lbravo_mp_flyable_mg" || eattacker.model == "veh9_mil_air_heli_medium_vehphys_mp" )
    {
        vehicleowner = eattacker.owner;
        level thread function_cbbeb2f71936b10e( eattacker, instance.origin );
    }
    
    if ( smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" )
    {
        idamage = int( idamage * level.redeploy_drone_info_struct.var_9e437065f024b3dd );
    }
    
    if ( isdefined( einflictor ) && einflictor.model == "ks_airstrike_target_br_ch3" )
    {
        idamage = level.redeploy_drone_info_struct.var_4f3cd2a57aac6ea6;
    }
    
    instance.health -= idamage;
    
    if ( isdefined( objweapon ) && objweapon.basename == "toma_proj_mp" )
    {
        instance.health = 0;
    }
    
    if ( instance.health < level.redeploy_drone_info_struct.i_health * level.redeploy_drone_info_struct.var_b250d13e6f70f782 )
    {
        instance setscriptablepartstate( "redeploy_drone_damage_vfx", "enabled" );
    }
    
    if ( instance.health <= 0 )
    {
        replace = 0;
        
        if ( !instance.b_skip_repopulate && level.redeploy_drone_info_struct.var_b25c414b8d1434de )
        {
            level thread redeploy_drone_repopulation_watcher( instance );
        }
        else if ( !instance.b_skip_replace && level.redeploy_drone_info_struct.var_b532046b2ae6c118 )
        {
            replace = 1;
            level thread function_8dd2309a67900f1f( instance );
        }
        
        if ( isdefined( vehicleowner ) )
        {
            instance redeploy_drone_destroyed( vehicleowner, einflictor.model, undefined, replace );
            return;
        }
        
        instance redeploy_drone_destroyed( eattacker, einflictor.model, undefined, replace );
    }
}

// Namespace br_redeploy_drone
// Params 4
// Checksum 0x1342e7a4, Offset: 0x2e04
// Size: 0x139
function redeploy_drone_destroyed( eattacker, modelname, var_ad3a06d177a39b09, replace )
{
    if ( replace )
    {
        self setscriptablepartstate( "redeploy_drone", "destroyed" );
    }
    else
    {
        self setscriptablepartstate( "redeploy_drone", "unavailable" );
    }
    
    self setscriptablepartstate( "redeploy_drone_sfx", "disabled" );
    weapons::function_d5eafafe8f6a97bf( self );
    
    /#
        function_a8470b55ba93350();
    #/
    
    self.b_occupied = 0;
    self notify( #"redeploy_drone_destroyed" );
    
    if ( modelname == "ks_airstrike_target_br_ch3" && isdefined( eattacker ) )
    {
        eattacker.var_bf76d1814a73cd34++;
    }
    
    if ( isdefined( eattacker ) )
    {
        challenges::function_37e945722d6497f3( eattacker, "destroy_redeploy_drone", 1 );
    }
    
    analytics_params = { #was_relocating:0, #circle_index:level.br_circle.circleindex ?? -1, #pos:self.origin };
    level thread br_analytics::function_fef6725d302a8146( analytics_params );
    
    if ( var_ad3a06d177a39b09 )
    {
        redeploy_drone_explosion( eattacker );
        return;
    }
    
    thread function_4972205b8c562ca3( self.origin, self.angles, eattacker );
}

// Namespace br_redeploy_drone
// Params 3
// Checksum 0xd70180fc, Offset: 0x2f45
// Size: 0x88
function function_4972205b8c562ca3( position, angles, eattacker )
{
    level endon( #"game_ended" );
    drone = spawn( "script_model", position );
    drone setmodel( "veh9_mil_air_drone_redeploy_relocate" );
    drone.angles = angles;
    drone.speed = 0;
    weapons::function_ef0cb557b1a93af9( drone );
    drone.owner = eattacker;
    drone redeploy_drone_freefall();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x8460b349, Offset: 0x2fd5
// Size: 0x8a
function redeploy_drone_freefall()
{
    level endon( #"game_ended" );
    waitframe();
    self setscriptablepartstate( "redeploy_drone_relocation_smoke_vfx", "enabled" );
    
    if ( level.redeploy_drone_info_struct.var_b532046b2ae6c118 )
    {
        self setscriptablepartstate( "redeploy_drone_relocation_objective", "inactive" );
    }
    
    self setscriptablepartstate( "redeploy_drone_relocation_smoke_vfx", "enabled" );
    self physics_registerforcollisioncallback();
    thread function_2f9ddf986e50897();
    self waittill( #"collision" );
    redeploy_drone_explosion();
    wait 0.2;
    weapons::function_d5eafafe8f6a97bf( self );
    self delete();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xd4091b89, Offset: 0x3067
// Size: 0x247
function function_2f9ddf986e50897()
{
    level endon( #"game_ended" );
    self endon( #"collision" );
    self endon( #"entitydeleted" );
    v_movement = ( 0, 0, 0 );
    
    if ( isdefined( self.v_destination ) )
    {
        v_movement = vectornormalize( self.v_destination - self.origin );
    }
    
    self physics_takecontrol( 1, self.origin, v_movement * self.speed * 1500 );
    i = level.redeploy_drone_info_struct.var_752a2de7a9a8ec9d;
    x = randomfloatrange( i / 2, i );
    x = utility::cointoss() ? x : x * -1;
    y = randomfloatrange( i / 2, i );
    y = utility::cointoss() ? y : y * -1;
    z = randomfloatrange( i / 10, i / 5 );
    z = utility::cointoss() ? z : z * -1;
    self physics_applyimpulse( self.origin + ( randomintrange( -50, 51 ), randomintrange( -50, 51 ), randomintrange( -50, 51 ) ), ( x, y, z ) );
    
    while ( true )
    {
        var_9e922f60b00adbff = anglestoforward( self.angles ) * randomfloatrange( -1 * level.redeploy_drone_info_struct.var_725b5a0d669b2688, level.redeploy_drone_info_struct.var_725b5a0d669b2688 );
        var_54f5cce3f0e25b20 = anglestoright( self.angles ) * randomfloatrange( -1 * level.redeploy_drone_info_struct.var_725b5a0d669b2688, level.redeploy_drone_info_struct.var_725b5a0d669b2688 );
        var_6fc4450d22b6d93f = anglestoup( self.angles ) * randomfloat( level.redeploy_drone_info_struct.var_725b5a0d669b2688 );
        self physics_applyimpulse( self.origin + ( randomintrange( -50, 51 ), randomintrange( -50, 51 ), randomintrange( -50, 51 ) ), var_9e922f60b00adbff + var_54f5cce3f0e25b20 + var_6fc4450d22b6d93f );
        wait 0.05;
    }
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0xe6fbebf8, Offset: 0x32b6
// Size: 0x8a
function redeploy_drone_explosion( eattacker )
{
    thread function_e6eb38f13786318f( self.origin );
    
    if ( !isdefined( eattacker ) && isdefined( self.owner ) )
    {
        eattacker = self.owner;
    }
    
    radiusdamage( self.origin, level.redeploy_drone_info_struct.i_explosion_radius, level.redeploy_drone_info_struct.var_e264b16858b3b6ba, level.redeploy_drone_info_struct.var_e287bb6858da1470, eattacker, "MOD_EXPLOSIVE" );
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0x92ec8668, Offset: 0x3348
// Size: 0x3c
function function_e6eb38f13786318f( position )
{
    vfx = spawnscriptable( "scriptable_redeploy_drone_explosion", position );
    level utility::waittill_notify_or_timeout( "game_ended", 0.5 );
    vfx freescriptable();
}

// Namespace br_redeploy_drone
// Params 2
// Checksum 0xecdf3d0d, Offset: 0x338c
// Size: 0x32
function function_cbbeb2f71936b10e( attacker, v_pos )
{
    wait 0.15;
    
    if ( player::isreallyalive( attacker ) )
    {
        attacker dodamage( 9999, v_pos );
    }
}

// Namespace br_redeploy_drone
// Params 6
// Checksum 0xb427a444, Offset: 0x33c6
// Size: 0x6f
function function_d3b7bea5de5c72( instance, part, state, player, bautouse, usestring )
{
    player notify( #"redeploy_drone_use" );
    
    if ( isdefined( instance ) )
    {
        instance notify( #"redeploy_drone_scriptable_used", player );
    }
    
    player thread function_c402a843dfb643ff( instance );
    player thread function_100353b7081f4f4b( instance );
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0x98455e02, Offset: 0x343d
// Size: 0xb5
function function_c402a843dfb643ff( instance )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    instance endon( #"death" );
    level thread br_analytics::function_d35a53c77fb9ea2d( self, instance );
    threshold_sq = squared( 19 );
    
    while ( distance2dsquared( self.origin, instance.origin ) > threshold_sq )
    {
        waitframe();
    }
    
    while ( distance2dsquared( self.origin, instance.origin ) < threshold_sq )
    {
        waitframe();
    }
    
    self notify( #"redeploy_drone_launch" );
    function_5c0d522c0e3bb441( instance );
    thread function_8245b29bb3cd5c27();
    thread function_11c9995c11585344();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x2fd9a5c9, Offset: 0x34fa
// Size: 0x12d
function function_8245b29bb3cd5c27()
{
    level endon( #"game_ended" );
    omnvar_utility::function_58bd31d56367a73d( "ui_br_altimeter_state", 2 );
    
    while ( isdefined( self ) )
    {
        if ( self isskydiving() )
        {
            self waittill( #"skydive_end" );
            break;
        }
        
        var_4c8494b2d9f8a060 = istrue( self.inlaststand );
        var_26e9e89ab44fa0d5 = self.ffsm_state == 5 || self.ffsm_state == 6 || self.ffsm_state == 3;
        bisland = self isonground() || self isswimming() || self ishanging();
        var_90941ad50be28a34 = self isonladder();
        var_ab97440e881ebc09 = self isonascender();
        bisdead = !player::isreallyalive( self );
        binvehicle = self isvehicleactive();
        
        if ( var_4c8494b2d9f8a060 || var_26e9e89ab44fa0d5 || bisland || var_90941ad50be28a34 || var_ab97440e881ebc09 || bisdead || binvehicle )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        omnvar_utility::function_58bd31d56367a73d( "ui_br_altimeter_state", 0 );
    }
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0x923f05b9, Offset: 0x362f
// Size: 0x29
function function_5c0d522c0e3bb441( instance )
{
    if ( instance.var_fa94b25ca4c43790 )
    {
        challenges::function_37e945722d6497f3( self, "redeploy_beacon", 1 );
    }
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x74fb44a7, Offset: 0x3660
// Size: 0x1c4
function function_11c9995c11585344()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( !self isonground() )
    {
        nearbyplayers = utility::playersincylinder( self.origin, level.redeploy_drone_info_struct.var_12bfa36b3396fee1, undefined, level.redeploy_drone_info_struct.var_bb39751f42ca73bc );
        teamcompare = self.team;
        
        foreach ( targetplayer in nearbyplayers )
        {
            sameteam = teamcompare == targetplayer.team;
            
            if ( sameteam )
            {
                continue;
            }
            
            var_7459e3ac9f644b43 = !player::isreallyalive( targetplayer ) || targetplayer.inlaststand;
            
            if ( var_7459e3ac9f644b43 )
            {
                continue;
            }
            
            targetparachuting = targetplayer isparachuting() || targetplayer isinfreefall();
            
            if ( targetparachuting )
            {
                continue;
            }
            
            time = gettime();
            heardrecently = isdefined( targetplayer.heardparachuteoverheadtime ) && time - targetplayer.heardparachuteoverheadtime < level.redeploy_drone_info_struct.var_7a0ef63e9d1bf5cb;
            
            if ( heardrecently )
            {
                continue;
            }
            
            targetplayer.heardparachuteoverheadtime = time;
            br_public::brleaderdialog( "respawning_enemy_in_area", 1, [ targetplayer ] );
        }
        
        waitframe();
    }
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0xf017a677, Offset: 0x382c
// Size: 0x44
function function_100353b7081f4f4b( instance )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"redeploy_drone_launch" );
    instance waittill( #"redeploy_drone_destroyed" );
    self dropoffascender();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xdab7420a, Offset: 0x3878
// Size: 0x126
function despawn_redeploy_drones()
{
    level endon( #"game_ended" );
    level waittill( #"br_circle_set" );
    
    while ( level.br_circle.circleindex != level.redeploy_drone_info_struct.var_93c50a30cdabecab )
    {
        wait level.redeploy_drone_info_struct.var_d0553b05b6a9d317;
    }
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        if ( scriptable getscriptablepartstate( "redeploy_drone" ) == "available" || scriptable getscriptablepartstate( "redeploy_drone" ) == "deploy" || scriptable getscriptablepartstate( "redeploy_drone" ) == "retract" )
        {
            scriptable thread function_8085580e5330a29e();
            wait randomintrange( 5, 10 );
        }
    }
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0xf71678e2, Offset: 0x39a6
// Size: 0x599
function redeploy_drone_repopulation_watcher( redeploy_drone )
{
    level endon( #"game_ended" );
    level endon( #"respawn_redeploy_drones" );
    v_origin = redeploy_drone.origin;
    wait level.redeploy_drone_info_struct.var_563ff6d850570b0;
    target_scriptable = undefined;
    f_closest_sq = undefined;
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        if ( scriptable == redeploy_drone )
        {
            continue;
        }
        
        if ( scriptable.b_occupied )
        {
            continue;
        }
        
        if ( scriptable.b_used )
        {
            continue;
        }
        
        if ( scriptable.script_noteworthy != "redeploy_drone_spawn" && scriptable.script_noteworthy != "redeploy_drone_relocate" )
        {
            continue;
        }
        
        if ( scriptable getscriptablepartstate( "redeploy_drone" ) == "available" || scriptable getscriptablepartstate( "redeploy_drone" ) == "deploy" || scriptable getscriptablepartstate( "redeploy_drone" ) == "retract" )
        {
            continue;
        }
        
        if ( scriptable is_redeploy_drone_in_gas() )
        {
            /#
                scriptable set_redeploy_drone_in_gas();
            #/
            
            continue;
        }
        
        if ( scriptable function_e2169a00d5058341() )
        {
            /#
                scriptable function_40b374f871ce7b65();
            #/
            
            continue;
        }
        
        distance_sq = distance2dsquared( v_origin, scriptable.origin );
        
        if ( !isdefined( f_closest_sq ) || distance_sq < f_closest_sq )
        {
            f_closest_sq = distance_sq;
            target_scriptable = scriptable;
        }
    }
    
    if ( !isdefined( target_scriptable ) )
    {
        return;
    }
    
    target_scriptable.b_occupied = 1;
    target_scriptable.b_used = 1;
    
    if ( isdefined( redeploy_drone ) )
    {
        redeploy_drone.b_occupied = 0;
    }
    
    var_edbf62b3aa438ff0 = br_circle::getsafecircleorigin();
    v_spawn_origin = v_origin + vectornormalize( v_origin - ( var_edbf62b3aa438ff0[ 0 ], var_edbf62b3aa438ff0[ 1 ], v_origin[ 2 ] ) ) * 20000;
    v_spawn_angles = vectortoangles( v_origin - ( var_edbf62b3aa438ff0[ 0 ], var_edbf62b3aa438ff0[ 1 ], v_origin[ 2 ] ) );
    drone = spawn( "script_model", v_spawn_origin );
    drone setmodel( "veh9_mil_air_drone_redeploy_relocate" );
    drone.angles = v_spawn_angles;
    drone.speed = 0;
    drone health_init();
    drone setcandamage( 1 );
    drone forcenetfieldhighlod( 1 );
    weapons::function_ef0cb557b1a93af9( drone );
    level.redeploy_drone_info_struct.movingdrones[ level.redeploy_drone_info_struct.movingdrones.size ] = drone;
    
    if ( level.var_c7c34c7053a29846 )
    {
        drone emp_debuff::set_apply_emp_callback( &function_655132aeb9577cc6 );
        drone.var_5b3dbacfeda0fd01 = &function_655132aeb9577cc6;
    }
    
    if ( isdefined( level.redeploy_drone_info_struct.var_416151fca5c5b862 ) )
    {
        level.redeploy_drone_info_struct.var_416151fca5c5b862[ level.redeploy_drone_info_struct.var_416151fca5c5b862.size ] = drone;
    }
    
    /#
        if ( getdvarint( @"scr_debug_redeploy_drones", 0 ) )
        {
            debug::sphere( drone, 25, ( 1, 0, 0 ), undefined, "<dev string:x24>", "<dev string:x4c>" );
            debug::draw_angles( drone, undefined, 150, undefined, "<dev string:x24>", "<dev string:x4c>" );
        }
    #/
    
    var_9d7349f6823a8948 = function_4932b017680a36b1();
    drone thread function_f8019c12697fcf50( target_scriptable, var_9d7349f6823a8948 );
    drone thread function_76cb6eb6a9700637( target_scriptable, var_9d7349f6823a8948 );
    drone thread redeploy_drone_sfx_watcher( undefined, target_scriptable, var_9d7349f6823a8948 );
    drone thread function_db27aa1265406b53( target_scriptable );
    
    while ( !( isdefined( drone.b_movement_complete ) && isdefined( drone.var_fe7274eb7e5153e7 ) ) )
    {
        if ( drone.health <= 0 )
        {
            if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
            {
                level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
            }
            
            return;
        }
        
        wait 0.05;
    }
    
    drone cable_deploy();
    
    if ( !isalive( drone ) )
    {
        if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
        {
            level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
        }
        
        return;
    }
    
    drone notify( #"relocation_complete" );
    target_scriptable.health = drone.health;
    
    if ( isdefined( level.redeploy_drone_info_struct.var_416151fca5c5b862 ) )
    {
        level.redeploy_drone_info_struct.var_416151fca5c5b862 = arrayremove( level.redeploy_drone_info_struct.var_416151fca5c5b862, drone );
    }
    
    weapons::function_d5eafafe8f6a97bf( drone );
    
    if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
    {
        level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
    }
    
    drone delete();
    target_scriptable set_redeploy_drone_available();
    target_scriptable thread function_1903b4a3be0118f1();
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0xd5497ed9, Offset: 0x3f47
// Size: 0x40b
function function_8dd2309a67900f1f( redeploy_drone )
{
    level endon( #"game_ended" );
    level endon( #"respawn_redeploy_drones" );
    self endon( #"redeploy_drone_in_gas" );
    v_origin = redeploy_drone.origin;
    redeploy_drone thread function_2d911c70cbf5caa8();
    wait level.redeploy_drone_info_struct.var_531c104023c0b6c7;
    redeploy_drone notify( #"relocation_started" );
    
    if ( redeploy_drone.b_occupied )
    {
        return;
    }
    
    if ( redeploy_drone is_redeploy_drone_in_gas() )
    {
        redeploy_drone set_redeploy_drone_in_gas();
        return;
    }
    
    redeploy_drone.b_occupied = 1;
    redeploy_drone.b_used = 1;
    
    if ( level.br_circle_disabled )
    {
        var_edbf62b3aa438ff0 = ( 0, 0, 0 );
    }
    else
    {
        var_edbf62b3aa438ff0 = br_circle::getsafecircleorigin();
    }
    
    v_spawn_origin = v_origin + vectornormalize( v_origin - ( var_edbf62b3aa438ff0[ 0 ], var_edbf62b3aa438ff0[ 1 ], v_origin[ 2 ] ) ) * 20000;
    v_spawn_angles = vectortoangles( v_origin - ( var_edbf62b3aa438ff0[ 0 ], var_edbf62b3aa438ff0[ 1 ], v_origin[ 2 ] ) );
    drone = spawn( "script_model", v_spawn_origin );
    drone setmodel( "veh9_mil_air_drone_redeploy_relocate" );
    drone.angles = v_spawn_angles;
    drone.speed = 0;
    drone health_init();
    drone setcandamage( 1 );
    drone forcenetfieldhighlod( 1 );
    weapons::function_ef0cb557b1a93af9( drone );
    level.redeploy_drone_info_struct.movingdrones[ level.redeploy_drone_info_struct.movingdrones.size ] = drone;
    
    if ( level.var_c7c34c7053a29846 )
    {
        drone emp_debuff::set_apply_emp_callback( &function_655132aeb9577cc6 );
        drone.var_5b3dbacfeda0fd01 = &function_655132aeb9577cc6;
    }
    
    if ( isdefined( level.redeploy_drone_info_struct.var_416151fca5c5b862 ) )
    {
        level.redeploy_drone_info_struct.var_416151fca5c5b862[ level.redeploy_drone_info_struct.var_416151fca5c5b862.size ] = drone;
    }
    
    /#
        if ( getdvarint( @"scr_debug_redeploy_drones", 0 ) )
        {
            debug::sphere( drone, 25, ( 1, 0, 0 ), undefined, "<dev string:x24>", "<dev string:x4c>" );
            debug::draw_angles( drone, undefined, 150, undefined, "<dev string:x24>", "<dev string:x4c>" );
        }
    #/
    
    var_9d7349f6823a8948 = function_4932b017680a36b1();
    drone thread function_f8019c12697fcf50( redeploy_drone, var_9d7349f6823a8948 );
    drone thread function_76cb6eb6a9700637( redeploy_drone, var_9d7349f6823a8948 );
    drone thread redeploy_drone_sfx_watcher( undefined, redeploy_drone, var_9d7349f6823a8948 );
    drone thread function_db27aa1265406b53( redeploy_drone );
    drone thread function_3b976c4cc3dc25b1( redeploy_drone );
    
    while ( !( isdefined( drone.b_movement_complete ) && isdefined( drone.var_fe7274eb7e5153e7 ) ) )
    {
        if ( drone.health <= 0 )
        {
            level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
            return;
        }
        
        wait 0.05;
    }
    
    drone cable_deploy();
    
    if ( !isalive( drone ) )
    {
        level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
        return;
    }
    
    drone notify( #"relocation_complete" );
    redeploy_drone.health = drone.health;
    
    if ( isdefined( level.redeploy_drone_info_struct.var_416151fca5c5b862 ) )
    {
        level.redeploy_drone_info_struct.var_416151fca5c5b862 = arrayremove( level.redeploy_drone_info_struct.var_416151fca5c5b862, drone );
    }
    
    weapons::function_d5eafafe8f6a97bf( drone );
    level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
    drone delete();
    redeploy_drone set_redeploy_drone_available();
    redeploy_drone thread function_1903b4a3be0118f1();
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0x6bae9155, Offset: 0x435a
// Size: 0x113
function get_closest_redeploy_drone( v_pos )
{
    var_812f1d56ca696e52 = level.redeploy_drone_info_struct.var_dc2234786c8913dd;
    otherdrones = utility::callsharedfunc( #"superredeploydronebeacon", #"hash_3dd4fa0f710a2eff" );
    
    if ( isdefined( otherdrones ) )
    {
        var_812f1d56ca696e52 = arraycombine( var_812f1d56ca696e52, otherdrones );
    }
    
    var_812f1d56ca696e52 = sortbydistance( var_812f1d56ca696e52, v_pos );
    
    foreach ( drone in var_812f1d56ca696e52 )
    {
        scriptablepartstate = drone getscriptablepartstate( "redeploy_drone" );
        var_9525eadf979c0f3a = scriptablepartstate == "available" || scriptablepartstate == "deploy" || scriptablepartstate == "retract";
        
        if ( var_9525eadf979c0f3a )
        {
            return drone;
        }
    }
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x8e6449e8, Offset: 0x4476
// Size: 0xc7
function function_5be9e1b2e2545ef7()
{
    var_19c7202e565973f0 = arrayremove( level.redeploy_drone_info_struct.var_dc2234786c8913dd, level.redeploy_drone_info_struct.var_69654e31920f8e38 );
    var_19c7202e565973f0 = arrayrandomize( level.redeploy_drone_info_struct.var_dc2234786c8913dd );
    
    foreach ( drone in var_19c7202e565973f0 )
    {
        if ( !drone is_redeploy_drone_in_gas() )
        {
            return drone;
        }
    }
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0x41bfac6a, Offset: 0x4546
// Size: 0x33
function precision_airstrike_death( owner )
{
    wait 0.3;
    
    if ( !isdefined( self ) || self.health <= 0 )
    {
        owner.var_bf76d1814a73cd34++;
    }
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x6ae90249, Offset: 0x4581
// Size: 0x73
function dropbag_collision_watcher()
{
    self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
    function_64fa143275559702( position, self.owner );
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0xe02e59ef, Offset: 0x45fc
// Size: 0x1e
function function_ae129ad897a2887c( position )
{
    function_64fa143275559702( position, self.owner );
}

// Namespace br_redeploy_drone
// Params 2
// Checksum 0xe200e5da, Offset: 0x4622
// Size: 0xcc
function function_64fa143275559702( position, eattacker )
{
    scr_drone = get_closest_redeploy_drone( position );
    
    if ( isdefined( scr_drone ) && distancesquared( position, scr_drone.origin ) < squared( 150 ) )
    {
        replace = 0;
        
        if ( !scr_drone.b_skip_repopulate && level.redeploy_drone_info_struct.var_b25c414b8d1434de )
        {
            level thread redeploy_drone_repopulation_watcher( scr_drone );
        }
        else if ( !scr_drone.b_skip_replace && level.redeploy_drone_info_struct.var_b532046b2ae6c118 )
        {
            replace = 1;
            level thread function_8dd2309a67900f1f( scr_drone );
        }
        
        scr_drone redeploy_drone_destroyed( eattacker, undefined, 1, replace );
    }
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x67476f19, Offset: 0x46f6
// Size: 0x2
function function_200421d609523ac3()
{
    
}

// Namespace br_redeploy_drone
// Params 2
// Checksum 0x2c92c32f, Offset: 0x4700
// Size: 0xd4
function function_1903b4a3be0118f1( b_skip_repopulate, b_skip_replace )
{
    /#
        if ( getdvarint( @"hash_20d28f147758431b", 0 ) && level.mapname == "<dev string:xa4>" )
        {
            return;
        }
    #/
    
    if ( level.br_circle_disabled )
    {
        return;
    }
    
    level endon( #"game_ended" );
    
    if ( !( isdefined( self ) && isdefined( self.origin ) ) )
    {
        return;
    }
    
    timetilldangerforpoint = br_circle_util::gettimetilldangerforpoint( self.origin );
    
    if ( timetilldangerforpoint > 0 )
    {
        if ( level utility::waittill_notify_or_timeout_return( "br_circle_relocation", timetilldangerforpoint ) == "timeout" )
        {
            if ( self getscriptablepartstate( "redeploy_drone" ) == "unavailable" )
            {
                return;
            }
        }
        else
        {
            thread function_1903b4a3be0118f1( b_skip_repopulate, b_skip_replace );
            return;
        }
    }
    
    thread redeploy_drone_relocate( undefined, undefined, b_skip_repopulate, undefined, undefined, b_skip_replace );
}

// Namespace br_redeploy_drone
// Params 6
// Checksum 0xc50b99df, Offset: 0x47dc
// Size: 0x3a0
function redeploy_drone_relocate( scr_override, b_immediate, b_skip_repopulate, var_805032909ed2a9d7, var_4f1f0425833996da, b_skip_replace )
{
    level endon( #"game_ended" );
    
    if ( !b_immediate )
    {
        while ( exclusion_zones::function_1efc19de6199fff6( ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - 2727 ) ) != -1 )
        {
            wait 1;
        }
        
        while ( true )
        {
            i_circle_index = level.br_circle.circleindex ?? 0;
            i_wait = level.redeploy_drone_info_struct.var_282669dff723ff8 - level.redeploy_drone_info_struct.var_c91738a31073297d * i_circle_index;
            
            if ( i_wait < level.redeploy_drone_info_struct.var_d0553b05b6a9d317 )
            {
                i_wait = level.redeploy_drone_info_struct.var_d0553b05b6a9d317;
            }
            
            wait i_wait;
            
            if ( exclusion_zones::function_1efc19de6199fff6( ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - 2727 ) ) != -1 )
            {
                while ( exclusion_zones::function_1efc19de6199fff6( ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - 2727 ) ) != -1 )
                {
                    wait 1;
                }
                
                continue;
            }
            
            break;
        }
    }
    
    throttle::throttle_wait_in_queue( level.redeploy_drone_relocate_throttle, self );
    
    if ( self getscriptablepartstate( "redeploy_drone" ) == "unavailable" )
    {
        return;
    }
    
    target_scriptable = undefined;
    f_closest_sq = undefined;
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        if ( scriptable.b_occupied )
        {
            continue;
        }
        
        if ( scriptable.script_noteworthy != "redeploy_drone_spawn" && scriptable.script_noteworthy != "redeploy_drone_relocate" )
        {
            continue;
        }
        
        if ( scriptable getscriptablepartstate( "redeploy_drone" ) == "available" || scriptable getscriptablepartstate( "redeploy_drone" ) == "deploy" || scriptable getscriptablepartstate( "redeploy_drone" ) == "retract" )
        {
            continue;
        }
        
        if ( scriptable is_redeploy_drone_in_gas() )
        {
            /#
                scriptable set_redeploy_drone_in_gas();
            #/
            
            continue;
        }
        
        if ( scriptable function_e2169a00d5058341() )
        {
            /#
                scriptable function_40b374f871ce7b65();
            #/
            
            continue;
        }
        
        distance_sq = distance2dsquared( self.origin, scriptable.origin );
        
        if ( !isdefined( f_closest_sq ) || distance_sq < f_closest_sq )
        {
            f_closest_sq = distance_sq;
            target_scriptable = scriptable;
        }
    }
    
    if ( isdefined( scr_override ) )
    {
        target_scriptable = scr_override;
    }
    
    if ( !isdefined( target_scriptable ) || !level.redeploy_drone_info_struct.var_b25c414b8d1434de )
    {
        thread function_8085580e5330a29e();
        return;
    }
    
    set_redeploy_drone_in_gas();
    var_c053aa99fadec150 = function_baa604d4fd5d4f8b( self.origin, self, target_scriptable, var_4f1f0425833996da, b_skip_repopulate, b_skip_replace );
    
    if ( !var_c053aa99fadec150 )
    {
        return;
    }
    
    target_scriptable set_redeploy_drone_available();
    
    if ( !var_805032909ed2a9d7 )
    {
        target_scriptable thread function_1903b4a3be0118f1( b_skip_repopulate, b_skip_replace );
    }
}

// Namespace br_redeploy_drone
// Params 7
// Checksum 0x8224d07a, Offset: 0x4b84
// Size: 0x3d7, Type: bool
function function_baa604d4fd5d4f8b( spawn_position, departure_scriptable, target_scriptable, var_4f1f0425833996da, b_skip_repopulate, b_skip_replace, var_9d7349f6823a8948 = function_4932b017680a36b1() )
{
    target_scriptable.b_occupied = 1;
    target_scriptable.b_used = 1;
    drone = spawn( "script_model", spawn_position );
    var_4f1f0425833996da = var_4f1f0425833996da ?? 0;
    model_name = function_950a8f041419ae80( var_4f1f0425833996da );
    drone setmodel( model_name );
    
    if ( isdefined( departure_scriptable ) )
    {
        drone.angles = departure_scriptable.angles;
        drone.speed = 0;
        drone.health = departure_scriptable.health;
        drone.type = departure_scriptable.type;
    }
    else
    {
        drone.speed = var_9d7349f6823a8948.i_max_speed;
        drone health_init();
    }
    
    drone setcandamage( 1 );
    drone forcenetfieldhighlod( 1 );
    drone.b_skip_repopulate = b_skip_repopulate;
    drone.b_skip_replace = b_skip_replace;
    weapons::function_ef0cb557b1a93af9( drone );
    level.redeploy_drone_info_struct.movingdrones[ level.redeploy_drone_info_struct.movingdrones.size ] = drone;
    
    if ( level.var_c7c34c7053a29846 )
    {
        drone emp_debuff::set_apply_emp_callback( &function_655132aeb9577cc6 );
        drone.var_5b3dbacfeda0fd01 = &function_655132aeb9577cc6;
    }
    
    drone thread function_db27aa1265406b53( target_scriptable, b_skip_repopulate, b_skip_replace );
    
    if ( isdefined( departure_scriptable ) )
    {
        drone cable_retract();
    }
    
    if ( !isalive( drone ) )
    {
        if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
        {
            /#
                debug::sphere( drone, 25, ( 1, 0, 0 ), undefined, "<dev string:x24>", "<dev string:x4c>" );
            #/
            
            level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
        }
        
        return false;
    }
    
    drone setscriptablepartstate( "redeploy_drone_cable_sfx", "retract_stop" );
    drone thread function_f8019c12697fcf50( target_scriptable, var_9d7349f6823a8948 );
    drone thread function_76cb6eb6a9700637( target_scriptable, var_9d7349f6823a8948 );
    drone thread redeploy_drone_sfx_watcher( departure_scriptable, target_scriptable, var_9d7349f6823a8948 );
    
    while ( !( isdefined( drone.b_movement_complete ) && isdefined( drone.var_fe7274eb7e5153e7 ) ) )
    {
        if ( drone.health <= 0 )
        {
            if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
            {
                level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
            }
            
            return false;
        }
        
        wait 0.05;
    }
    
    drone cable_deploy();
    
    if ( !isalive( drone ) )
    {
        if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
        {
            level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
        }
        
        return false;
    }
    
    drone notify( #"relocation_complete" );
    target_scriptable.health = drone.health;
    weapons::function_d5eafafe8f6a97bf( drone );
    
    if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
    {
        level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
    }
    
    drone delete();
    return true;
}

// Namespace br_redeploy_drone
// Params 3
// Checksum 0x96741df3, Offset: 0x4f64
// Size: 0xc3
function function_8085580e5330a29e( var_4f1f0425833996da, i_wait, b_skip_cable_retract )
{
    level endon( #"game_ended" );
    var_4f1f0425833996da = var_4f1f0425833996da ?? 0;
    
    if ( !isdefined( i_wait ) )
    {
        i_circle_index = level.br_circle.circleindex ?? 0;
        i_wait = level.redeploy_drone_info_struct.var_282669dff723ff8 - level.redeploy_drone_info_struct.var_c91738a31073297d * i_circle_index;
        
        if ( i_wait < level.redeploy_drone_info_struct.var_d0553b05b6a9d317 )
        {
            i_wait = level.redeploy_drone_info_struct.var_d0553b05b6a9d317;
        }
    }
    
    wait i_wait;
    function_5feb841850cc465d( var_4f1f0425833996da, b_skip_cable_retract );
}

// Namespace br_redeploy_drone
// Params 2
// Checksum 0x55dff8f5, Offset: 0x502f
// Size: 0x3bf
function function_5feb841850cc465d( var_4f1f0425833996da, b_skip_cable_retract )
{
    level endon( #"game_ended" );
    
    if ( self getscriptablepartstate( "redeploy_drone" ) == "unavailable" )
    {
        return;
    }
    
    s_despawn = spawnstruct();
    
    if ( level.br_multi_circle_enabled )
    {
        var_edbf62b3aa438ff0 = level.br_level.br_circlecenters[ level.br_circle.circleindex + 1 ];
    }
    else
    {
        var_edbf62b3aa438ff0 = br_circle::getsafecircleorigin();
    }
    
    s_despawn.origin = self.origin + vectornormalize( self.origin - ( var_edbf62b3aa438ff0[ 0 ], var_edbf62b3aa438ff0[ 1 ], self.origin[ 2 ] ) ) * 20000;
    s_despawn.angles = vectortoangles( self.origin - ( var_edbf62b3aa438ff0[ 0 ], var_edbf62b3aa438ff0[ 1 ], self.origin[ 2 ] ) );
    set_redeploy_drone_in_gas();
    model_name = function_950a8f041419ae80( var_4f1f0425833996da );
    drone = spawn( "script_model", self.origin );
    drone setmodel( model_name );
    drone.angles = self.angles;
    drone.speed = 0;
    drone.health = self.health;
    drone.type = self.type;
    drone forcenetfieldhighlod( 1 );
    weapons::function_ef0cb557b1a93af9( drone );
    level.redeploy_drone_info_struct.movingdrones[ level.redeploy_drone_info_struct.movingdrones.size ] = drone;
    
    if ( level.var_c7c34c7053a29846 )
    {
        drone emp_debuff::set_apply_emp_callback( &function_655132aeb9577cc6 );
        drone.var_5b3dbacfeda0fd01 = &function_655132aeb9577cc6;
    }
    
    target_scriptable = undefined;
    b_skip_repopulate = 1;
    b_skip_replace = 1;
    drone thread function_db27aa1265406b53( target_scriptable, b_skip_repopulate, b_skip_replace );
    
    if ( !b_skip_cable_retract )
    {
        drone cable_retract();
    }
    
    if ( !isalive( drone ) )
    {
        if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
        {
            /#
                debug::sphere( drone, 25, ( 1, 0, 0 ), undefined, "<dev string:x24>", "<dev string:x4c>" );
            #/
            
            level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
        }
        
        return;
    }
    
    var_9d7349f6823a8948 = function_4932b017680a36b1();
    drone thread function_f8019c12697fcf50( s_despawn, var_9d7349f6823a8948 );
    drone thread function_76cb6eb6a9700637( s_despawn, var_9d7349f6823a8948 );
    drone thread redeploy_drone_sfx_watcher( self, undefined, var_9d7349f6823a8948 );
    
    while ( !( isdefined( drone.b_movement_complete ) && isdefined( drone.var_fe7274eb7e5153e7 ) ) )
    {
        if ( drone.health <= 0 )
        {
            if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
            {
                level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
            }
            
            return;
        }
        
        wait 0.05;
    }
    
    drone notify( #"relocation_complete" );
    weapons::function_d5eafafe8f6a97bf( drone );
    
    if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, drone ) )
    {
        level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, drone );
    }
    
    drone delete();
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0xfa6ce3bf, Offset: 0x53f6
// Size: 0x4c
function function_3b976c4cc3dc25b1( target_scriptable )
{
    self endon( #"entitydeleted" );
    self endon( #"relocation_complete" );
    
    while ( true )
    {
        if ( !isdefined( target_scriptable ) )
        {
            return;
        }
        
        if ( target_scriptable is_redeploy_drone_in_gas() )
        {
            redeploy_drone_freefall();
        }
        
        wait 0.5;
    }
}

// Namespace br_redeploy_drone
// Params 3
// Checksum 0xc4bb60, Offset: 0x544a
// Size: 0x2ff
function function_db27aa1265406b53( target_scriptable, b_skip_repopulate, b_skip_replace )
{
    self endon( #"entitydeleted" );
    self endon( #"relocation_complete" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon );
        
        if ( isplayer( eattacker ) )
        {
            eattacker damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1, "hitequip" );
        }
        else if ( isplayer( eattacker.owner ) )
        {
            eattacker.owner damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1, "hitequip" );
        }
        
        if ( eattacker.model == "veh8_mil_air_lbravo_mp_flyable" || eattacker.model == "veh8_mil_air_lbravo_mp_flyable_mg" || eattacker.model == "veh9_mil_air_heli_medium_vehphys_mp" )
        {
            level thread function_cbbeb2f71936b10e( eattacker, self.origin );
        }
        
        if ( smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" )
        {
            idamage = int( idamage * level.redeploy_drone_info_struct.var_9e437065f024b3dd );
        }
        
        if ( modelname == "ks_airstrike_target_br_ch3" )
        {
            idamage = level.redeploy_drone_info_struct.var_4f3cd2a57aac6ea6;
        }
        
        self.health -= idamage;
        
        if ( isdefined( objweapon ) && objweapon.basename == "toma_proj_mp" )
        {
            self.health = 0;
        }
        
        if ( self.health <= 0 )
        {
            if ( arraycontains( level.redeploy_drone_info_struct.movingdrones, self ) )
            {
                level.redeploy_drone_info_struct.movingdrones = arrayremove( level.redeploy_drone_info_struct.movingdrones, self );
            }
            
            if ( !b_skip_repopulate && level.redeploy_drone_info_struct.var_b25c414b8d1434de )
            {
                level thread redeploy_drone_repopulation_watcher( self );
            }
            else if ( !b_skip_replace && level.redeploy_drone_info_struct.var_b532046b2ae6c118 && isdefined( target_scriptable ) )
            {
                target_scriptable.b_occupied = 0;
                level thread function_8dd2309a67900f1f( target_scriptable );
            }
            
            redeploy_drone_relocate_destroyed( eattacker, modelname );
            
            if ( isdefined( target_scriptable ) )
            {
                target_scriptable.b_occupied = 0;
            }
            
            return;
        }
    }
}

// Namespace br_redeploy_drone
// Params 2
// Checksum 0xc385472f, Offset: 0x5751
// Size: 0x3e
function redeploy_drone_relocate_destroyed( eattacker, modelname )
{
    if ( modelname == "ks_airstrike_target_br_ch3" )
    {
        eattacker.var_bf76d1814a73cd34++;
    }
    
    self.owner = eattacker;
    redeploy_drone_freefall();
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0x9addf77d, Offset: 0x5797
// Size: 0xd4, Type: bool
function function_e2169a00d5058341()
{
    var_9702e571229a176 = sqrt( level.redeploy_drone_info_struct.var_10fed330f6746fa6 );
    redeploydronelocations = function_6a293b884c444a20( level.redeploy_drone_info_struct.var_dc2234786c8913dd, self.origin, var_9702e571229a176 );
    
    foreach ( scriptable in redeploydronelocations )
    {
        if ( scriptable == self )
        {
            continue;
        }
        
        if ( scriptable.b_occupied )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_redeploy_drone
// Params 2
// Checksum 0xb0b6879b, Offset: 0x5874
// Size: 0x364
function function_f8019c12697fcf50( target_scriptable, var_9d7349f6823a8948 )
{
    level endon( #"game_ended" );
    self endon( #"death", #"entitydeleted" );
    
    if ( !isdefined( var_9d7349f6823a8948 ) )
    {
        var_9d7349f6823a8948 = function_4932b017680a36b1();
    }
    
    self.destination_scriptable = target_scriptable;
    self.v_destination = target_scriptable.origin;
    self.drone_arrived = 0;
    
    /#
        utility::function_95db22f620602461( @"scr_debug_redeploy_drones", &debug::line, [ self, target_scriptable.origin, ( 1, 0, 0 ), undefined, "<dev string:x24>", "<dev string:xb4>" ] );
    #/
    
    if ( self.speed < var_9d7349f6823a8948.i_max_speed )
    {
        while ( self.speed < var_9d7349f6823a8948.i_max_speed )
        {
            self.speed += 1;
            
            if ( self.speed > var_9d7349f6823a8948.i_max_speed )
            {
                self.speed = var_9d7349f6823a8948.i_max_speed;
            }
            
            self moveto( self.origin + self.speed * vectornormalize( self.v_destination - self.origin ), 0.05, 0, 0 );
            wait 0.05;
        }
    }
    else
    {
        while ( self.speed > var_9d7349f6823a8948.i_max_speed )
        {
            self.speed -= 0.8;
            
            if ( self.speed < var_9d7349f6823a8948.i_max_speed )
            {
                self.speed = var_9d7349f6823a8948.i_max_speed;
            }
            
            self moveto( self.origin + self.speed * vectornormalize( self.v_destination - self.origin ), 0.05, 0, 0 );
            wait 0.05;
        }
    }
    
    destinationdistance = distance( self.origin, self.v_destination );
    var_c965d3f10448db7c = destinationdistance - var_9d7349f6823a8948.var_551db378f3d8f9d9;
    
    if ( var_c965d3f10448db7c > 0 )
    {
        var_434787e69705f50d = self.origin + vectornormalize( self.v_destination - self.origin ) * var_c965d3f10448db7c;
        var_d69ee2e227bbb8ff = var_c965d3f10448db7c / self.speed / 10;
        self moveto( var_434787e69705f50d, var_d69ee2e227bbb8ff, 0, 0 );
        wait var_d69ee2e227bbb8ff;
    }
    
    self notify( #"redeploy_drone_arrive" );
    self.drone_arrived = 1;
    var_2bb98675a819d0a4 = distance( self.origin, self.v_destination );
    self.speed = var_2bb98675a819d0a4 * var_9d7349f6823a8948.var_97160ac0ed09c3bb;
    self.speed = min( self.speed, var_2bb98675a819d0a4 );
    var_33b5afbd448ff196 = var_2bb98675a819d0a4 / self.speed;
    self moveto( self.v_destination, var_33b5afbd448ff196, 0, 0 );
    self waittill( #"movedone" );
    self.speed = 0;
    self.v_destination = undefined;
    self.b_movement_complete = 1;
}

// Namespace br_redeploy_drone
// Params 0
// Checksum 0xc71ef095, Offset: 0x5be0
// Size: 0xb0
function function_4932b017680a36b1()
{
    movementparameters = spawnstruct();
    movementparameters.i_min_speed = 0;
    movementparameters.i_max_speed = level.redeploy_drone_info_struct.i_max_speed;
    movementparameters.var_551db378f3d8f9d9 = 500;
    movementparameters.var_97160ac0ed09c3bb = 0.7;
    movementparameters.var_10ba80ea9aef8808 = 30;
    movementparameters.var_bdf1a2f11c76b413 = 0.025;
    movementparameters.var_f5123fffd5f1ad01 = 2;
    movementparameters.b_show_objective_icon = !level.redeploy_drone_info_struct.var_b532046b2ae6c118;
    return movementparameters;
}

// Namespace br_redeploy_drone
// Params 2
// Checksum 0x570db5f8, Offset: 0x5c99
// Size: 0x273
function function_d5375de1310d94cf( target_position, movementparameters )
{
    if ( movementparameters.var_fc5691fd2a2c4b00 )
    {
        if ( self.drone_arrived )
        {
            return;
        }
        
        self endon( #"redeploy_drone_arrive" );
    }
    
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    
    if ( !isdefined( movementparameters ) )
    {
        movementparameters = function_4932b017680a36b1();
    }
    
    v_diff = vectornormalize( target_position - self.origin );
    f_yaw_diff = vectortoangles( v_diff )[ 1 ] - self.angles[ 1 ];
    
    if ( f_yaw_diff < -180 )
    {
        f_yaw_diff += 360;
    }
    
    if ( f_yaw_diff > 180 )
    {
        f_yaw_diff -= 360;
    }
    
    f_forward_dot = vectordot( v_diff, anglestoforward( self.angles ) );
    f_right_dot = vectordot( v_diff, anglestoright( self.angles ) );
    f_frames = abs( f_yaw_diff );
    var_8e605a9183d0adda = f_frames - 90;
    
    if ( var_8e605a9183d0adda > 0 )
    {
        var_cdd066867dc4ec27 = var_8e605a9183d0adda / f_frames;
        self rotateby( ( movementparameters.var_10ba80ea9aef8808 * f_forward_dot + movementparameters.var_10ba80ea9aef8808 / 2, f_yaw_diff * var_cdd066867dc4ec27, movementparameters.var_10ba80ea9aef8808 * f_right_dot ), var_8e605a9183d0adda * movementparameters.var_bdf1a2f11c76b413, var_8e605a9183d0adda / 2 * movementparameters.var_bdf1a2f11c76b413, 0 );
        wait var_8e605a9183d0adda * movementparameters.var_bdf1a2f11c76b413;
        var_9b14118f1a9651d5 = f_frames - var_8e605a9183d0adda;
        self rotateto( ( movementparameters.var_10ba80ea9aef8808, vectortoangles( v_diff )[ 1 ], 0 ), var_9b14118f1a9651d5 * movementparameters.var_bdf1a2f11c76b413, 0, var_9b14118f1a9651d5 / 2 * movementparameters.var_bdf1a2f11c76b413 );
        wait var_9b14118f1a9651d5 * movementparameters.var_bdf1a2f11c76b413;
        return;
    }
    
    f_halftime = f_frames / 2 * movementparameters.var_bdf1a2f11c76b413;
    
    if ( f_halftime < 1 )
    {
        f_halftime = 1;
    }
    
    self rotateby( ( movementparameters.var_10ba80ea9aef8808 / 2 * f_forward_dot, f_yaw_diff / 2, movementparameters.var_10ba80ea9aef8808 / 2 * f_right_dot ), f_halftime, f_halftime / 2, 0 );
    wait f_halftime;
    self rotateto( ( movementparameters.var_10ba80ea9aef8808, vectortoangles( v_diff )[ 1 ], 0 ), f_halftime, 0, f_halftime / 2 );
    wait f_halftime;
}

// Namespace br_redeploy_drone
// Params 2
// Checksum 0xa5ce4529, Offset: 0x5f14
// Size: 0x18a
function function_76cb6eb6a9700637( target_scriptable, movementparameters )
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    
    if ( !isdefined( movementparameters ) )
    {
        movementparameters = function_4932b017680a36b1();
    }
    
    function_d5375de1310d94cf( target_scriptable.origin, movementparameters );
    
    if ( !self.drone_arrived )
    {
        self waittill( #"redeploy_drone_arrive" );
    }
    
    f_yaw_diff = target_scriptable.angles[ 1 ] - self.angles[ 1 ];
    
    if ( f_yaw_diff < -180 )
    {
        f_yaw_diff += 360;
    }
    
    if ( f_yaw_diff > 180 )
    {
        f_yaw_diff -= 360;
    }
    
    f_forward_dot = vectordot( anglestoforward( self.angles ), anglestoforward( target_scriptable.angles ) );
    f_right_dot = vectordot( anglestoright( self.angles ), anglestoforward( target_scriptable.angles ) );
    f_halftime = movementparameters.var_f5123fffd5f1ad01 / 2;
    self rotateby( ( -1 * movementparameters.var_10ba80ea9aef8808 * f_forward_dot - movementparameters.var_10ba80ea9aef8808, f_yaw_diff / 2, movementparameters.var_10ba80ea9aef8808 * f_right_dot ), f_halftime, f_halftime / 2, 0 );
    wait f_halftime;
    self rotateto( ( 0, target_scriptable.angles[ 1 ], 0 ), f_halftime, 0, f_halftime / 2 );
    wait f_halftime;
    self.var_fe7274eb7e5153e7 = 1;
}

// Namespace br_redeploy_drone
// Params 3
// Checksum 0x573cf603, Offset: 0x60a6
// Size: 0xe3
function redeploy_drone_sfx_watcher( departure_scriptable, arrival_scriptable, var_9d7349f6823a8948 )
{
    self endon( #"entitydeleted" );
    
    if ( !isdefined( var_9d7349f6823a8948 ) )
    {
        var_9d7349f6823a8948 = function_4932b017680a36b1();
    }
    
    if ( var_9d7349f6823a8948.b_show_objective_icon )
    {
        self setscriptablepartstate( "redeploy_drone_relocation_objective", "active" );
    }
    else
    {
        self setscriptablepartstate( "redeploy_drone_relocation_objective", "inactive" );
    }
    
    wait 1;
    self setscriptablepartstate( "redeploy_drone_relocation_sfx", "relocation_loop" );
    
    if ( isdefined( departure_scriptable ) )
    {
        departure_scriptable setscriptablepartstate( "redeploy_drone_sfx", "disabled" );
    }
    
    self waittill( #"redeploy_drone_arrive" );
    
    if ( isdefined( arrival_scriptable ) )
    {
        arrival_scriptable setscriptablepartstate( "redeploy_drone_sfx", "relocation_sfx_end" );
        wait 0.5;
        
        if ( isdefined( arrival_scriptable ) )
        {
            arrival_scriptable setscriptablepartstate( "redeploy_drone_sfx", "engine_idle_sfx" );
        }
    }
    
    self setscriptablepartstate( "redeploy_drone_relocation_sfx", "relocation_end" );
}

// Namespace br_redeploy_drone
// Params 1
// Checksum 0x5a46ad79, Offset: 0x6191
// Size: 0x9d
function function_950a8f041419ae80( var_4f1f0425833996da )
{
    model_name = "veh9_mil_air_drone_redeploy_relocate";
    
    switch ( var_4f1f0425833996da )
    {
        case 0:
            model_name = "veh9_mil_air_drone_redeploy_relocate";
            break;
        case 1:
            model_name = "veh9_mil_air_drone_redeploy_relocate_extended";
            break;
        case 2:
            model_name = "veh9_mil_air_drone_redeploy_relocate_short";
            break;
        case 3:
            model_name = "veh9_mil_air_drone_redeploy_relocate_very_short";
            break;
        default:
            assertmsg( "<dev string:xca>" );
            break;
    }
    
    return model_name;
}

/#

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x57724d69, Offset: 0x6237
    // Size: 0x5, Type: dev
    function function_eea18adbdbb5777c()
    {
        
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xd82f261c, Offset: 0x6244
    // Size: 0x83, Type: dev
    function debug_init()
    {
        level waittill( #"player_spawned" );
        level thread function_6c025e2cb9e2dd26();
        utility::function_95db22f620602461( @"hash_20d28f147758431b", &function_44cc73900f4ab5c4 );
        utility::function_95db22f620602461( @"hash_1b823e69b7bcb477", &function_35e87715d9077624 );
        utility::function_95db22f620602461( @"hash_7206433d469d7d0a", &function_74861cf53dcd878b );
        utility::function_95db22f620602461( @"hash_44c9b804cfee044b", &function_9ad0ac1dbf305540 );
        utility::function_95db22f620602461( @"hash_bf9414a8359d7c0", &function_ba60a7751992fee8 );
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x66c39a69, Offset: 0x62cf
    // Size: 0x86, Type: dev
    function function_6c025e2cb9e2dd26()
    {
        devgui::function_9082edeb5db93280( "<dev string:xe9>" );
        devgui::add_devgui_func( "<dev string:xfc>", "<dev string:x102>", &function_f55fb32a09a9c23e );
        devgui::add_devgui_func( "<dev string:x118>", "<dev string:x12e>", &function_23db4a1fa55837bc );
        devgui::add_devgui_func( "<dev string:x154>", "<dev string:x16f>", &function_e9f706dab8fb7f39 );
        devgui::add_devgui_func( "<dev string:x19a>", "<dev string:x1aa>", &function_f2bc4e0f4fdee368 );
        devgui::add_devgui_func( "<dev string:x1ca>", "<dev string:x1d3>", &function_d91a3467badaac50 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xa715af46, Offset: 0x635d
    // Size: 0x28, Type: dev
    function function_f55fb32a09a9c23e()
    {
        if ( !getdvarint( @"scr_debug_redeploy_drones", 0 ) )
        {
            function_3ac4f9785cd1eae();
            return;
        }
        
        function_e0eee23b41f48d50();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x5afbf047, Offset: 0x638d
    // Size: 0xa2, Type: dev
    function function_3ac4f9785cd1eae()
    {
        setdvar( @"scr_debug_redeploy_drones", 1 );
        iprintlnbold( "<dev string:x1ec>" );
        
        foreach ( drone in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
        {
            drone function_24c539ca7be1d0ca();
        }
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xd107624c, Offset: 0x6437
    // Size: 0x2a, Type: dev
    function function_e0eee23b41f48d50()
    {
        setdvar( @"scr_debug_redeploy_drones", 0 );
        iprintlnbold( "<dev string:x216>" );
        level notify( #"hash_373fb3ddb710adfe" );
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x54f47be3, Offset: 0x6469
    // Size: 0x28, Type: dev
    function function_23db4a1fa55837bc()
    {
        if ( !getdvarint( @"hash_1b823e69b7bcb477", 0 ) )
        {
            function_35e87715d9077624();
            return;
        }
        
        function_9591370c4b42ee9e();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x7400dead, Offset: 0x6499
    // Size: 0x27, Type: dev
    function function_35e87715d9077624()
    {
        setdvar( @"hash_1b823e69b7bcb477", 1 );
        iprintlnbold( "<dev string:x241>" );
        level thread function_456dc53c4ccc3357();
    }

    // Namespace br_redeploy_drone
    // Params 2
    // Checksum 0xf861a290, Offset: 0x64c8
    // Size: 0x1b9, Type: dev
    function function_456dc53c4ccc3357( v_position, i_radius )
    {
        level endon( #"game_ended" );
        level endon( #"hash_319d3c57e79e627c" );
        var_4ef8ad119102a654 = getdvarint( @"hash_9bd3724f70106775", 9000 );
        
        while ( true )
        {
            scr_closest = level.players[ 0 ] utility::function_4113d68e8e0a401f( level.redeploy_drone_info_struct.var_dc2234786c8913dd );
            
            foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
            {
                if ( scriptable == scr_closest )
                {
                    sphere( scriptable.origin, 200, ( 1, 1, 1 ), 0, 2 );
                    cylinder( scriptable.origin - ( 0, 0, 10 ), scriptable.origin + ( 0, 0, 10 ), var_4ef8ad119102a654, ( 0, 0, 1 ), 0, 2 );
                    continue;
                }
                
                cylinder( scriptable.origin - ( 0, 0, 10 ), scriptable.origin + ( 0, 0, 10 ), var_4ef8ad119102a654, ( 0.5, 0.5, 0.5 ), 0, 2 );
            }
            
            waitframe();
        }
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x56b582fb, Offset: 0x6689
    // Size: 0x2a, Type: dev
    function function_9591370c4b42ee9e()
    {
        setdvar( @"hash_1b823e69b7bcb477", 0 );
        iprintlnbold( "<dev string:x27b>" );
        level notify( #"hash_319d3c57e79e627c" );
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xd2d234e2, Offset: 0x66bb
    // Size: 0x28, Type: dev
    function function_e9f706dab8fb7f39()
    {
        if ( !getdvarint( @"hash_7206433d469d7d0a", 0 ) )
        {
            function_74861cf53dcd878b();
            return;
        }
        
        function_1055ac56ead996af();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x9d8bb7c5, Offset: 0x66eb
    // Size: 0x27, Type: dev
    function function_74861cf53dcd878b()
    {
        setdvar( @"hash_7206433d469d7d0a", 1 );
        iprintlnbold( "<dev string:x2b6>" );
        level thread function_aefb6f1dcf5f9218();
    }

    // Namespace br_redeploy_drone
    // Params 2
    // Checksum 0x9454aa75, Offset: 0x671a
    // Size: 0x278, Type: dev
    function function_aefb6f1dcf5f9218( v_position, i_radius )
    {
        level endon( #"game_ended" );
        level endon( #"hash_11cdd87366d33bf9" );
        var_75d3c72461966741 = getdvarint( @"hash_59c137234dad4ad6", 7000 );
        
        while ( true )
        {
            f_closest_dot = -1;
            scr_closest = undefined;
            
            foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
            {
                v_player = anglestoforward( level.players[ 0 ] getplayerangles() );
                v_scriptable = vectornormalize( scriptable.origin - level.players[ 0 ] geteye() );
                f_dot = vectordot( v_player, v_scriptable );
                
                if ( f_dot >= f_closest_dot )
                {
                    f_closest_dot = f_dot;
                    scr_closest = scriptable;
                }
            }
            
            foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
            {
                if ( scriptable == scr_closest )
                {
                    sphere( scriptable.origin, 200, ( 1, 1, 1 ), 0, 2 );
                    cylinder( scriptable.origin - ( 0, 0, 10 ), scriptable.origin + ( 0, 0, 10 ), var_75d3c72461966741, ( 1, 1, 0 ), 0, 2 );
                    continue;
                }
                
                cylinder( scriptable.origin - ( 0, 0, 10 ), scriptable.origin + ( 0, 0, 10 ), var_75d3c72461966741, ( 0.5, 0.5, 0.5 ), 0, 2 );
            }
            
            waitframe();
        }
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x2ce8cacd, Offset: 0x699a
    // Size: 0x2a, Type: dev
    function function_1055ac56ead996af()
    {
        setdvar( @"hash_7206433d469d7d0a", 0 );
        iprintlnbold( "<dev string:x2f5>" );
        level notify( #"hash_11cdd87366d33bf9" );
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xd2a7c207, Offset: 0x69cc
    // Size: 0x28, Type: dev
    function function_f2bc4e0f4fdee368()
    {
        if ( !getdvarint( @"hash_44c9b804cfee044b", 0 ) )
        {
            function_9ad0ac1dbf305540();
            return;
        }
        
        function_a962db6b7771f3da();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x89165ca9, Offset: 0x69fc
    // Size: 0xa2, Type: dev
    function function_9ad0ac1dbf305540()
    {
        setdvar( @"hash_44c9b804cfee044b", 1 );
        iprintlnbold( "<dev string:x335>" );
        
        foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
        {
            scriptable thread function_acb1eaea68b43a3e();
        }
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xe3e2ddce, Offset: 0x6aa6
    // Size: 0x163, Type: dev
    function function_acb1eaea68b43a3e()
    {
        switch ( self.str_surftype )
        {
            case #"hash_296fec58e16e327":
            case #"hash_1f2e430eca34d788":
            case #"hash_2dc2bd39328def65":
            case #"hash_2fa4167540164873":
            case #"hash_3990683480267242":
            case #"hash_588c5c47805606eb":
            case #"hash_5f33d5485b7f33ed":
            case #"hash_5ff12d0a2c109d2c":
            case #"hash_6dc36f3e31f59c8b":
            case #"hash_d4e7d6c49368be7f":
                debug::print3d( self.var_bd4fec0091dedb5c + ( 0, 0, 200 ), self.str_surftype, ( 1, 1, 1 ), undefined, "<dev string:x417>", undefined, undefined, 10 );
                debug::sphere( self.var_bd4fec0091dedb5c, 2, ( 1, 1, 1 ), undefined, "<dev string:x417>" );
                break;
            default:
                debug::print3d( self.var_bd4fec0091dedb5c + ( 0, 0, 200 ), self.str_surftype, ( 1, 1, 1 ), undefined, "<dev string:x417>", undefined, undefined, 10 );
                debug::sphere( self.var_bd4fec0091dedb5c, 2, ( 1, 0, 0 ), undefined, "<dev string:x417>" );
                break;
        }
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x50c43b31, Offset: 0x6c11
    // Size: 0x2a, Type: dev
    function function_a962db6b7771f3da()
    {
        setdvar( @"hash_44c9b804cfee044b", 0 );
        iprintlnbold( "<dev string:x449>" );
        level notify( #"hash_ff6880a7db0a6828" );
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xce492a92, Offset: 0x6c43
    // Size: 0x28, Type: dev
    function function_895c94bd110abe98()
    {
        if ( !getdvarint( @"hash_a64dca6283ab8a08", 0 ) )
        {
            function_a4a0b9c8f13b0af0();
            return;
        }
        
        function_48a71aea85009f6a();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x41eb82eb, Offset: 0x6c73
    // Size: 0x27, Type: dev
    function function_a4a0b9c8f13b0af0()
    {
        setdvar( @"hash_a64dca6283ab8a08", 1 );
        iprintlnbold( "<dev string:x47e>" );
        level thread function_c510e9f28a65f8dd();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x1db5675d, Offset: 0x6ca2
    // Size: 0x4f, Type: dev
    function function_c510e9f28a65f8dd()
    {
        level endon( #"game_ended" );
        level endon( #"hash_9ff697a0ce97d258" );
        
        while ( true )
        {
            trace = level.players[ 0 ] trace::player_viewangles();
            iprintlnbold( trace[ "<dev string:x49f>" ] );
            waitframe();
        }
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x22219437, Offset: 0x6cf9
    // Size: 0x2a, Type: dev
    function function_48a71aea85009f6a()
    {
        setdvar( @"hash_a64dca6283ab8a08", 0 );
        iprintlnbold( "<dev string:x4ab>" );
        level notify( #"hash_9ff697a0ce97d258" );
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xac4c8161, Offset: 0x6d2b
    // Size: 0x28, Type: dev
    function function_d91a3467badaac50()
    {
        if ( !getdvarint( @"hash_bf9414a8359d7c0", 0 ) )
        {
            function_ba60a7751992fee8();
            return;
        }
        
        function_756be4873e1fadc2();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x13841239, Offset: 0x6d5b
    // Size: 0xb5, Type: dev
    function function_ba60a7751992fee8()
    {
        setdvar( @"hash_bf9414a8359d7c0", 1 );
        iprintlnbold( "<dev string:x4cd>" );
        
        foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
        {
            scriptable.health = 1;
            scriptable.maxhealth = 1;
        }
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x5f037718, Offset: 0x6e18
    // Size: 0xa1, Type: dev
    function function_756be4873e1fadc2()
    {
        setdvar( @"hash_bf9414a8359d7c0", 0 );
        iprintlnbold( "<dev string:x4f2>" );
        
        foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
        {
            scriptable health_init();
        }
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xbc3862a, Offset: 0x6ec1
    // Size: 0x3ea, Type: dev
    function function_44cc73900f4ab5c4()
    {
        if ( level.mapname != "<dev string:xa4>" )
        {
            return;
        }
        
        level notify( #"hash_a48f1e6117d0ea8d" );
        level endon( #"hash_a48f1e6117d0ea8d" );
        scr_static = spawnscriptable( "<dev string:x518>", ( 0, 0, 2740 ) );
        var_45bdde538ab6ef4e = spawnscriptable( "<dev string:x518>", ( 0, 0, 0 ) );
        var_45bddd538ab6ed1b = spawnscriptable( "<dev string:x518>", ( 0, 0, 0 ) );
        scr_static.isredeploydrone = 1;
        var_45bdde538ab6ef4e.isredeploydrone = 1;
        var_45bddd538ab6ed1b.isredeploydrone = 1;
        scr_static health_init();
        var_45bdde538ab6ef4e health_init();
        var_45bddd538ab6ed1b health_init();
        level.redeploy_drone_info_struct.var_dc2234786c8913dd[ level.redeploy_drone_info_struct.var_dc2234786c8913dd.size ] = scr_static;
        level.redeploy_drone_info_struct.var_dc2234786c8913dd[ level.redeploy_drone_info_struct.var_dc2234786c8913dd.size ] = var_45bdde538ab6ef4e;
        level.redeploy_drone_info_struct.var_dc2234786c8913dd[ level.redeploy_drone_info_struct.var_dc2234786c8913dd.size ] = var_45bddd538ab6ed1b;
        var_45bdde538ab6ef4e.i_random = randomint( 360 );
        var_45bdde538ab6ef4e.origin = scr_static.origin + 5500 * anglestoforward( ( 0, var_45bdde538ab6ef4e.i_random, 0 ) );
        var_45bddd538ab6ed1b.i_random = var_45bdde538ab6ef4e.i_random + randomintrange( 90, 270 );
        
        if ( var_45bddd538ab6ed1b.i_random >= 360 )
        {
            var_45bddd538ab6ed1b.i_random -= 360;
        }
        
        var_45bddd538ab6ed1b.origin = scr_static.origin + 5500 * anglestoforward( ( 0, var_45bddd538ab6ed1b.i_random, 0 ) );
        scr_static set_redeploy_drone_available();
        scr_static setscriptablepartstate( "<dev string:x532>", "<dev string:x545>" );
        scr_static setscriptablepartstate( "<dev string:x555>", "<dev string:x568>" );
        weapons::function_ef0cb557b1a93af9( scr_static );
        var_45bdde538ab6ef4e function_92558e2048ced142();
        var_45bddd538ab6ed1b set_redeploy_drone_available();
        var_45bddd538ab6ed1b setscriptablepartstate( "<dev string:x532>", "<dev string:x545>" );
        var_45bddd538ab6ed1b setscriptablepartstate( "<dev string:x555>", "<dev string:x568>" );
        weapons::function_ef0cb557b1a93af9( var_45bddd538ab6ed1b );
        
        while ( true )
        {
            scr_static thread redeploy_drone_relocate();
            wait 6;
            var_45bddd538ab6ed1b redeploy_drone_relocate();
            wait 6;
            var_45bddd538ab6ed1b.i_random = var_45bdde538ab6ef4e.i_random + randomintrange( 90, 270 );
            
            if ( var_45bddd538ab6ed1b.i_random >= 360 )
            {
                var_45bddd538ab6ed1b.i_random -= 360;
            }
            
            var_45bddd538ab6ed1b.origin = scr_static.origin + 5500 * anglestoforward( ( 0, var_45bddd538ab6ed1b.i_random, 0 ) );
            var_45bddd538ab6ed1b function_92558e2048ced142();
            var_45bddd538ab6ed1b setscriptablepartstate( "<dev string:x532>", "<dev string:x570>" );
            scr_static thread redeploy_drone_relocate();
            wait 6;
            var_45bdde538ab6ef4e redeploy_drone_relocate();
            wait 6;
            var_45bdde538ab6ef4e.i_random = var_45bddd538ab6ed1b.i_random + randomintrange( 90, 270 );
            
            if ( var_45bdde538ab6ef4e.i_random >= 360 )
            {
                var_45bdde538ab6ef4e.i_random -= 360;
            }
            
            var_45bdde538ab6ef4e.origin = scr_static.origin + 5500 * anglestoforward( ( 0, var_45bdde538ab6ef4e.i_random, 0 ) );
            var_45bdde538ab6ef4e function_92558e2048ced142();
            var_45bdde538ab6ef4e setscriptablepartstate( "<dev string:x532>", "<dev string:x570>" );
        }
    }

    // Namespace br_redeploy_drone
    // Params 2
    // Checksum 0xfb98e6e2, Offset: 0x72b3
    // Size: 0x24, Type: dev
    function function_824ce39a43f46e7( instance, time )
    {
        wait time;
        instance redeploy_drone_destroyed();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x6253fcc6, Offset: 0x72df
    // Size: 0x4e, Type: dev
    function function_92558e2048ced142()
    {
        self setscriptablepartstate( "<dev string:x579>", "<dev string:x588>" );
        self setscriptablepartstate( "<dev string:x594>", "<dev string:x570>" );
        self setscriptablepartstate( "<dev string:x5ad>", "<dev string:x570>" );
        self.b_occupied = 0;
        weapons::function_d5eafafe8f6a97bf( self );
        function_a8470b55ba93350();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x3b0ff98e, Offset: 0x7335
    // Size: 0x22, Type: dev
    function function_65401ca948591d1e()
    {
        self.var_64eddca1e356cd88 = ( 0, 1, 0 );
        function_24c539ca7be1d0ca();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xb615222c, Offset: 0x735f
    // Size: 0x22, Type: dev
    function function_a8470b55ba93350()
    {
        self.var_64eddca1e356cd88 = ( 1, 1, 0 );
        function_24c539ca7be1d0ca();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xbd33be7f, Offset: 0x7389
    // Size: 0x22, Type: dev
    function function_7a2988a0d2d64f3b()
    {
        self.var_64eddca1e356cd88 = ( 0, 1, 1 );
        function_24c539ca7be1d0ca();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0xd63d94, Offset: 0x73b3
    // Size: 0x22, Type: dev
    function function_40b374f871ce7b65()
    {
        self.var_64eddca1e356cd88 = ( 0, 0, 1 );
        function_24c539ca7be1d0ca();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x6149b775, Offset: 0x73dd
    // Size: 0x22, Type: dev
    function function_21f17ba620ead39e()
    {
        self.var_64eddca1e356cd88 = ( 1, 0, 0 );
        function_24c539ca7be1d0ca();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x2801375e, Offset: 0x7407
    // Size: 0x22, Type: dev
    function function_205ac32211ef7d20()
    {
        self.var_64eddca1e356cd88 = ( 1, 0.5, 0 );
        function_24c539ca7be1d0ca();
    }

    // Namespace br_redeploy_drone
    // Params 0
    // Checksum 0x3c25d176, Offset: 0x7431
    // Size: 0x75, Type: dev
    function function_24c539ca7be1d0ca()
    {
        if ( !getdvarint( @"scr_debug_redeploy_drones", 0 ) )
        {
            return;
        }
        
        self notify( #"hash_abc48242bb8f578f" );
        debug::sphere( self, 100, self.var_64eddca1e356cd88, undefined, "<dev string:x24>", "<dev string:x4c>" );
        debug::line( self, self.origin - ( 0, 0, 2700 ), self.var_64eddca1e356cd88, undefined, "<dev string:x24>", "<dev string:x4c>" );
    }

#/
