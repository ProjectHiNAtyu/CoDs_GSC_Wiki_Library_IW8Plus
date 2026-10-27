// script_7e92d5dd2cf1bc89  (hash_7e92d5dd2cf1bc89.gscc) (size: 16119 Bytes / 0x3ef7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5ab4c54 (95112276)
// size ...... 16119 (0x3ef7)
// includes .. 20  (offset: 0x3ba7)
// strings ... 45  (offset: 0x3c47)
// dev strs .. 3   (offset: 0x3ecf)
// exports ... 35  (offset: 0x2737)
// cseg ...... 0x46a + 0x22cd (0x2737)
// imports ... 125 (offset: 0x2caf)
// animtree1 . 0   (offset: 0x3ef7)
// animtree2 . 0   (offset: 0x3ef7)
#using script_16ea1b94f0f381b3;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\common\equipment\flash_grenade;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace namespace_dc3a0c120a108a2;

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0x58329c11, Offset: 0x488
// Size: 0xfe
function brtask_getspawndata( data )
{
    level.bombprops = spawnstruct();
    level.bombprops.circleradius = getdvarint( @"scr_br_bomb_circle_radius", 2000 );
    level.bombprops.pointradius = getdvarint( @"scr_br_bomb_point_radius", 1000 );
    level.bombprops.pointradiussq = level.bombprops.pointradius * level.bombprops.pointradius;
    level.bombprops.var_3afcdbbcf79cc9cc = getdvarfloat( @"hash_3e60557305f8da61", 0.65 );
    data.createfunc = &function_5aee551df753930c;
    
    if ( !isdefined( level._effect[ "bomb_squad_explosion" ] ) )
    {
        level._effect[ "bomb_squad_explosion" ] = loadfxasset( "vfx_iw8_mp_gamemode_search_bombsite_destroy" );
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 2
// Checksum 0x5e107407, Offset: 0x58e
// Size: 0x1e7
function function_5aee551df753930c( activity, owner )
{
    task = dmz_task_utils::task_create( activity );
    task.owner = owner;
    owner.task = task;
    task.players = [];
    task.funcs[ "onInit" ] = &function_a1e3d36d091b96db;
    task.funcs[ "onPlayerAssigned" ] = &brtask_onplayerassigned;
    task.funcs[ "onPlayerJoined" ] = &function_efbc1c0b2acc37e9;
    task.funcs[ "onPlayerRemoved" ] = &function_1b2a9bb0ef75170c;
    task.funcs[ "onTeamStart" ] = &function_aca08baa497b2838;
    task.funcs[ "onPlayerExitVolume" ] = &function_3aab368e50d72cca;
    task.funcs[ "onPlayerExitTimeout" ] = &brtask_onplayerexittimeout;
    task.funcs[ "onPlayerReenterVolume" ] = &function_3225931ebde732b;
    task.ref = "br_bomb";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.spawntrap = 0;
    task.tier = task.owner br_strongholds::function_999adf66330f4aa8();
    
    if ( task.tier == "black" )
    {
        task.mission_index = 17;
        task.mission_complete = 18;
        task.mission_fail = 0;
        task.mission_fail_warning = 0;
    }
    else
    {
        task.mission_index = 17;
        task.mission_complete = 18;
        task.mission_fail = 0;
        task.mission_fail_warning = 0;
    }
    
    return task;
}

// Namespace namespace_dc3a0c120a108a2
// Params 0
// Checksum 0xd7b64c75, Offset: 0x77e
// Size: 0x9b
function function_a1e3d36d091b96db()
{
    task = self;
    task.activity.origin = task.owner.origin;
    circlelocation = task.owner.missiontrigger.origin;
    task.circlecenter = circlelocation;
    task.circleradius = level.bombprops.circleradius;
    task.originalteam = undefined;
}

// Namespace namespace_dc3a0c120a108a2
// Params 2
// Checksum 0x7779ac13, Offset: 0x821
// Size: 0x105
function brtask_onplayerassigned( teamname, player )
{
    task = self;
    teams = [ teamname ];
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    task.owner br_strongholds::function_7d3778200a9a7f9e( player, player.team );
    ai_fortress::function_6afabfde369e039c( task.owner, 1 );
    task thread activity_manager::function_e7c5a361b3642470( task.owner.missiontrigger, 9000 );
    
    if ( !isdefined( task.plantedbombs ) )
    {
        task.plantedbombs = [];
    }
    
    if ( task.plantedbombs.size < 1 )
    {
        task thread function_617035fdc09c852b();
    }
    
    if ( var_7537e34d05ee8017 )
    {
        task thread function_26bcaac92e9ff923();
        task function_efbc1c0b2acc37e9( player );
        return;
    }
    
    task thread function_26bcaac92e9ff923();
    task dmz_task_utils::function_678cd11cba7c85a9( teamname );
    task function_efbc1c0b2acc37e9( player );
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0xaa3fe839, Offset: 0x92e
// Size: 0x15a
function function_efbc1c0b2acc37e9( player )
{
    task = self;
    
    if ( !isdefined( function_f02c63b99c9614c9( task.players, player ) ) )
    {
        size = task.players.size;
        task.players[ size ] = player;
    }
    
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    
    if ( var_7537e34d05ee8017 )
    {
        return;
    }
    
    var_da759e0bfcdfca64 = player getclientomnvar( "ui_br_stronghold_mission" );
    player thread hud_message::showsplash( "stronghold_operation_bomb_disposal" );
    wait 4;
    
    if ( !isdefined( player ) || !arraycontains( task.players, player ) )
    {
        return;
    }
    
    if ( var_da759e0bfcdfca64 == player getclientomnvar( "ui_br_stronghold_mission" ) )
    {
        player setclientomnvar( "ui_br_stronghold_mission", task.mission_index );
        player setclientomnvar( "ui_br_stronghold_mission_timer", task.endtime );
    }
    
    br_public::brleaderdialogplayer( "br_mission_bomb_assigned", player );
    
    if ( !isdefined( task.originalteam ) )
    {
        task.originalteam = player.team;
    }
    
    for ( i = 0; i < task.plantedbombs.size ; i++ )
    {
        task.plantedbombs[ i ] enableplayeruse( player );
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0x573d4555, Offset: 0xa90
// Size: 0x9c
function function_1b2a9bb0ef75170c( player )
{
    task = self;
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    task.players = arrayremove( task.players, player );
    
    if ( var_7537e34d05ee8017 )
    {
        return;
    }
    
    player setclientomnvar( "ui_br_stronghold_mission", task.mission_fail );
    
    for ( i = 0; i < task.plantedbombs.size ; i++ )
    {
        task.plantedbombs[ i ] disableplayeruse( player );
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0xdb84a387, Offset: 0xb34
// Size: 0x1b
function function_aca08baa497b2838( teamname )
{
    assert( 1, "<dev string:x24>" );
}

// Namespace namespace_dc3a0c120a108a2
// Params 3
// Checksum 0x10142d38, Offset: 0xb57
// Size: 0x1e9
function function_8bed103af0972c89( teamname, omnvarstate, detonated )
{
    task = self;
    teamplayers = task activity_manager::function_1a4ef82bc898efb6( teamname, 0 );
    teamparticipants = task activity_manager::function_1a4ef82bc898efb6( teamname, 1 );
    task dmz_task_utils::function_3ff46488beb193c7();
    level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].activities = arrayremove( level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].activities, task.activity.id );
    task.teams = arrayremove( task.teams, teamname );
    level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].active = 0;
    
    foreach ( player in teamparticipants )
    {
        task.players = arrayremove( task.players, player );
        
        if ( game_utility_common::isaigameparticipant( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_br_stronghold_mission", omnvarstate );
        
        if ( omnvarstate == task.mission_complete )
        {
            player thread hud_message::showsplash( "stronghold_operation_bomb_disposal_completed" );
            continue;
        }
        
        if ( detonated )
        {
            player thread hud_message::showsplash( "stronghold_operation_bomb_disposal_failed" );
        }
        else
        {
            player thread hud_message::showsplash( "stronghold_operation_bomb_disposal_poached" );
        }
        
        player setclientomnvar( "ui_br_stronghold_mission", 0 );
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0x3ff147ee, Offset: 0xd48
// Size: 0x7c
function function_3aab368e50d72cca( player )
{
    task = self;
    player.var_5111d0ec51f4ab00 = 1;
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    
    if ( !var_7537e34d05ee8017 )
    {
        player setclientomnvar( "ui_br_stronghold_mission", task.mission_fail_warning );
    }
    
    exittimeout = gettime() + 9000;
    
    if ( !var_7537e34d05ee8017 )
    {
        player setclientomnvar( "ui_br_stronghold_mission_timer", exittimeout );
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0x4673ad9a, Offset: 0xdcc
// Size: 0x6a
function function_3225931ebde732b( player )
{
    task = self;
    player.var_5111d0ec51f4ab00 = undefined;
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    
    if ( !var_7537e34d05ee8017 )
    {
        player setclientomnvar( "ui_br_stronghold_mission", task.mission_index );
        player setclientomnvar( "ui_br_stronghold_mission_timer", task.endtime );
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0x3c2ac9d3, Offset: 0xe3e
// Size: 0x55
function brtask_onplayerexittimeout( player )
{
    task = self;
    task function_1b2a9bb0ef75170c( player );
    player.var_5111d0ec51f4ab00 = undefined;
    player.var_4f29940bf9ecfd79 = undefined;
    
    if ( isdefined( level.var_18933116083e8076 ) )
    {
        task [[ level.var_18933116083e8076 ]]( player );
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 2, eflags: 0x4
// Checksum 0x5b8d58b9, Offset: 0xe9b
// Size: 0x253
function private function_6bfe3d7868662202( teamname, detonated )
{
    task = self;
    task notify( #"task_ended" );
    ai_fortress::function_5b84b41b9159ad3f( task.owner );
    
    if ( isdefined( level.var_d07dd9893f7e474b ) )
    {
        task.owner [[ level.var_d07dd9893f7e474b ]]( teamname, !detonated );
    }
    
    deletetask = 0;
    
    foreach ( team in task.teams )
    {
        teamcompleted = 0;
        
        if ( isdefined( teamname ) && isdefined( team ) )
        {
            teamcompleted = team == teamname;
        }
        
        omnvarstate = task.mission_fail;
        
        if ( teamcompleted )
        {
            deletetask = 1;
            omnvarstate = task.mission_complete;
        }
        
        task function_8bed103af0972c89( team, omnvarstate, detonated );
    }
    
    if ( detonated )
    {
        task.owner.crate thread br_strongholds::function_a5a4e51b72179cb6( undefined, 0, 1, 1, 0 );
        
        if ( level.var_bc39be980e0bcff5 )
        {
            thread br_strongholds::function_bfa72076355a7c05( task.owner, "high", level.var_70899f78a2e75346, 0, 1 );
        }
    }
    
    if ( !isdefined( detonated ) )
    {
        detonated = 0;
    }
    
    task.starttime = undefined;
    
    if ( isdefined( task.activity ) && isdefined( task.activity.tasks ) && task.activity.tasks.size >= 1 && ( deletetask || detonated ) )
    {
        task.owner.missiontrigger notify( #"activity_ended" );
        level.var_f9ba6d6273c5cc67.activities[ task.activity.id ] = undefined;
        task.activity.tasks = undefined;
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 3, eflags: 0x4
// Checksum 0x2de0ced9, Offset: 0x10f6
// Size: 0xdc
function private function_58fca188eeb39a70( instance, player, bombent )
{
    success = function_9776d5a252d64376( player, bombent );
    
    if ( success )
    {
        function_3da6d04cf07b8f1d( player, bombent );
        
        if ( instance.plantedbombs.size <= 0 )
        {
            dropstruct = pickups::function_f71dd588dc4f6288();
            instance function_6bfe3d7868662202( player.team );
            dmz_task_utils::function_59e5c04599d5a456( instance, player );
            instance.owner function_fa85b9830a413ae3( dropstruct, player );
            player br_strongholds::function_e0fc600c4a7ef0ec( dropstruct, player::getteamarray( player.team, 0 ), instance.originalteam );
        }
        
        return;
    }
    
    if ( !isdefined( bombent ) )
    {
        return;
    }
    
    function_3da6d04cf07b8f1d( player, bombent );
    instance thread function_8e82dbad412db83a( bombent );
}

// Namespace namespace_dc3a0c120a108a2
// Params 2, eflags: 0x4
// Checksum 0xd629fae5, Offset: 0x11da
// Size: 0x12a, Type: bool
function private function_9776d5a252d64376( player, bombent )
{
    task = self;
    item = makeweapon( "briefcase_bomb_mp" );
    player inventory_utility::_giveweapon( item, undefined, undefined, 0 );
    player setweaponammostock( item, 0 );
    player setweaponammoclip( item, 0 );
    player thread gameobjects::switchtouseweapon( item, 1 );
    timepassed = 0;
    
    while ( timepassed < 3 && gettime() < task.endtime )
    {
        if ( !isalive( player ) || player::isinlaststand( player ) || player.fauxdeath || player br_public::isplayeringulag() )
        {
            player inventory_utility::getridofweapon( "briefcase_bomb_mp" );
            return false;
        }
        
        timepassed += level.framedurationseconds;
        waitframe();
    }
    
    if ( player::isreallyalive( player ) )
    {
        player inventory_utility::getridofweapon( "briefcase_bomb_mp" );
        
        if ( gettime() < task.endtime )
        {
            task.plantedbombs = arrayremove( task.plantedbombs, bombent );
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_dc3a0c120a108a2
// Params 0
// Checksum 0x88cfba70, Offset: 0x130d
// Size: 0x160
function function_6d578ae493219bdd()
{
    task = self;
    caches = getlootscriptablearrayinradius( "br_loot_cache", undefined, task.circlecenter, task.circleradius );
    
    if ( !isdefined( caches ) )
    {
        return;
    }
    
    caches = arrayrandomize( caches );
    scalars = [ 0.1, 0.3, 0.5, 0.7, 0.9 ];
    cache = task function_52e2f82f6dd6c2f9( caches, scalars, 0 );
    
    if ( !isdefined( cache ) )
    {
        scalars = [ 0.1, 0.3, 0.5, 0.7, 0.9, 1 ];
        cache = task function_52e2f82f6dd6c2f9( caches, scalars, 0 );
        assert( isdefined( cache ), "<dev string:x61>" );
        task thread function_6bfe3d7868662202( undefined, 1 );
    }
    
    cache.task = task;
    task.cache = cache;
    cache.contents = [];
    cache function_20a913dfee3627ab();
    cache.contents[ 1 ][ "quantity" ] = 50;
    cache.contents[ 1 ][ "lootID" ] = 8395;
}

// Namespace namespace_dc3a0c120a108a2
// Params 3
// Checksum 0x6fe313c2, Offset: 0x1475
// Size: 0x16f
function function_52e2f82f6dd6c2f9( locations, var_79d164674c4f55e5, ignoreinuse )
{
    task = self;
    
    if ( !isdefined( ignoreinuse ) )
    {
        ignoreinuse = 0;
    }
    
    foreach ( radiusscalar in var_79d164674c4f55e5 )
    {
        foreach ( node in locations )
        {
            if ( node.inuse && !ignoreinuse )
            {
                continue;
            }
            
            dist = distance2d( node.origin, task.circlecenter );
            
            if ( dist < task.circleradius * radiusscalar )
            {
                if ( ignoreinuse )
                {
                    node.inuse = 0;
                    node freescriptable();
                }
                
                return node;
            }
        }
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 0
// Checksum 0xa2e609e0, Offset: 0x15ed
// Size: 0x55
function function_20a913dfee3627ab()
{
    cache = self;
    cache.contents[ 0 ][ "quantity" ] = 1;
    cache.contents[ 0 ][ "lootID" ] = 8608;
    cache.contents[ 0 ][ "callback" ] = &function_58fca188eeb39a70;
}

// Namespace namespace_dc3a0c120a108a2
// Params 0
// Checksum 0x4872349, Offset: 0x164a
// Size: 0x136
function function_26bcaac92e9ff923()
{
    task = self;
    
    if ( task.ticking )
    {
        return;
    }
    
    level endon( #"game_ended" );
    task endon( #"task_ended" );
    task.owner.missiontrigger endon( #"deleted" );
    task.owner.missiontrigger endon( #"activity_ended" );
    waittime = task.owner.var_32ef3f20015bb872[ 0 ];
    task.ticking = 1;
    task.starttime = gettime();
    task.endtime = task.starttime + waittime * 1000;
    task thread function_5f5a4f76a8ab7073( task.endtime, 3000 );
    wait waittime;
    
    for ( i = 0; i < task.plantedbombs.size ; i++ )
    {
        task function_a80154efe8821509( task.plantedbombs[ i ] );
    }
    
    task thread function_6bfe3d7868662202( undefined, 1 );
}

// Namespace namespace_dc3a0c120a108a2
// Params 2
// Checksum 0x9370887c, Offset: 0x1788
// Size: 0x195
function function_5f5a4f76a8ab7073( bombendtime, offset )
{
    task = self;
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    currenttime = gettime();
    var_f4f3f0356fef8102 = bombendtime - currenttime;
    
    while ( var_f4f3f0356fef8102 > 0 && isdefined( task.bombent ) )
    {
        currenttime = gettime();
        var_f4f3f0356fef8102 = bombendtime - currenttime;
        
        if ( var_f4f3f0356fef8102 <= 7000 + offset )
        {
            if ( var_f4f3f0356fef8102 <= 250 )
            {
                if ( soundexists( "breach_warning_beep_05" ) )
                {
                    task.bombent playsound( "breach_warning_beep_05" );
                }
            }
            else if ( var_f4f3f0356fef8102 <= 750 )
            {
                if ( soundexists( "breach_warning_beep_04" ) )
                {
                    task.bombent playsound( "breach_warning_beep_04" );
                }
            }
            else if ( var_f4f3f0356fef8102 <= 1500 )
            {
                if ( soundexists( "breach_warning_beep_03" ) )
                {
                    task.bombent playsound( "breach_warning_beep_03" );
                }
            }
            else if ( soundexists( "breach_warning_beep_02" ) )
            {
                task.bombent playsound( "breach_warning_beep_02" );
            }
            
            wait 0.25;
            continue;
        }
        
        if ( var_f4f3f0356fef8102 <= 15000 + offset )
        {
            if ( soundexists( "breach_warning_beep_02" ) )
            {
                task.bombent playsound( "breach_warning_beep_02" );
            }
            
            wait 0.5;
            continue;
        }
        
        if ( soundexists( "breach_warning_beep_01" ) )
        {
            task.bombent playsound( "breach_warning_beep_01" );
        }
        
        wait 1;
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0xd3805e06, Offset: 0x1925
// Size: 0x103
function function_b9415f2f47afea88( bombent )
{
    task = self;
    level endon( #"game_ended" );
    task endon( #"task_ended" );
    task.owner.missiontrigger endon( #"deleted" );
    task.owner.missiontrigger endon( #"activity_ended" );
    
    if ( !isdefined( bombent ) )
    {
        return;
    }
    
    if ( bombent.gaswatch )
    {
        return;
    }
    
    origin = bombent.origin + ( 0, 0, 40 );
    bombent.gaswatch = 1;
    waitframe();
    waittillframeend();
    
    while ( br_circle_util::ispointinmulticircledanger( origin ) || br_circle_util::function_3199bf5530fd0bc2( origin ) )
    {
        wait 0.5;
    }
    
    task function_a80154efe8821509( bombent );
    
    if ( task.plantedbombs.size <= 0 )
    {
        task thread function_6bfe3d7868662202( undefined, 1 );
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0x74e85592, Offset: 0x1a31
// Size: 0x1ff
function function_a80154efe8821509( bombent )
{
    task = self;
    origin = bombent.origin + ( 0, 0, 80 );
    physicsexplosionsphere( origin, task.circleradius, task.circleradius / 2, 400 );
    bombent radiusdamage( origin, 1024, 700, 100, bombent, "MOD_EXPLOSIVE", "c4_mp" );
    playsoundatpos( origin, "exp_bombsite_lr" );
    playfx( level._effect[ "bomb_squad_explosion" ], origin );
    shellshock_utility_cpmp::shellshock_artilleryearthquake( origin, undefined, 3.5, task.circleradius );
    
    if ( isdefined( bombent.visuals[ 0 ] ) )
    {
        bombent.visuals[ 0 ] delete();
    }
    
    bombent delete();
    
    foreach ( player in task.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
        
        if ( var_7537e34d05ee8017 )
        {
            continue;
        }
        
        player thread flash_grenade::applyflash( player, 1 );
        player.var_5111d0ec51f4ab00 = undefined;
        player.var_4f29940bf9ecfd79 = undefined;
    }
    
    if ( isdefined( bombent ) )
    {
        task.plantedbombs = arrayremove( task.plantedbombs, bombent );
        return;
    }
    
    if ( isdefined( task.plantedbombs ) && isdefined( task.plantedbombs.size ) && task.plantedbombs.size <= 1 )
    {
        task.plantedbombs = [];
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 2
// Checksum 0xf5daa350, Offset: 0x1c38
// Size: 0x45
function function_fa85b9830a413ae3( dropstruct, player )
{
    fortress = self;
    fortress br_strongholds::function_fb5fbbc2fcf4a080( player, undefined, undefined, 1 );
    function_a1ace995732ddde9( dropstruct, player, fortress.crate );
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0x4dd8944, Offset: 0x1c85
// Size: 0x1b6
function function_617035fdc09c852b( skipspawn )
{
    task = self;
    
    if ( isdefined( task.owner ) && isdefined( task.owner.crate ) )
    {
        success = function_74afcbfcfddd57be( task.owner.crate.origin, skipspawn );
        assert( success, "<dev string:x8b>" );
        
        if ( !success )
        {
            logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, task.owner ) + " : Failed to plant bomb." );
            return;
        }
        
        return;
    }
    
    task.availablenodes = undefined;
    
    if ( task.owner.elites.size > 0 )
    {
        task.availablenodes = task.owner.elites;
    }
    else if ( task.owner.guardnodes.size > 0 )
    {
        task.availablenodes = task.owner.guardnodes;
    }
    
    while ( task.plantedbombs.size < 1 )
    {
        success = task function_6e13482eb513ade8( task.plantedbombs.size );
        assert( success, "<dev string:x8b>" );
        
        if ( !success )
        {
            logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, task.owner ) + " : Failed to plant bomb." );
            return;
        }
    }
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0x852c6cbd, Offset: 0x1e43
// Size: 0xd4, Type: bool
function function_472af779e404f70f( bombnum )
{
    task = self;
    scalars = [ 0.1, 0.3, 0.5, 0.7, 0.9 ];
    
    foreach ( radiusscalar in scalars )
    {
        success = function_a89d8626f49db0f( bombnum, radiusscalar );
        
        if ( success )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_dc3a0c120a108a2
// Params 2
// Checksum 0x7915818c, Offset: 0x1f20
// Size: 0x8b, Type: bool
function function_a89d8626f49db0f( bombnum, radiusscalar )
{
    task = self;
    safeorigin = undefined;
    
    for ( attempts = 0; attempts < 10 ; attempts++ )
    {
        safeorigin = task.circlecenter + utility::randomonunitsphere() * task.circleradius * radiusscalar;
        safeorigin = getclosestpointonnavmesh( safeorigin );
        
        if ( function_2972f6f5ccc0fe10( safeorigin ) )
        {
            task function_e3d5cf954eb3b105( safeorigin, bombnum );
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0xa446cf01, Offset: 0x1fb4
// Size: 0x1f, Type: bool
function function_2972f6f5ccc0fe10( point )
{
    if ( isdefined( point ) )
    {
        if ( ispointonnavmesh( point ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_dc3a0c120a108a2
// Params 4
// Checksum 0x5042d3cc, Offset: 0x1fdc
// Size: 0x1bb
function function_e3d5cf954eb3b105( safeorigin, bombnum, originoverride, skipspawn )
{
    task = self;
    bombent = undefined;
    fullspawn = undefined;
    bombmodel = "offhand_2h_wm_briefcase_bomb_v0";
    
    if ( isdefined( task.plantedbombs[ bombnum ] ) && skipspawn )
    {
        bombent = task.plantedbombs[ bombnum ];
    }
    
    offset = ( 0, 0, 22 );
    safeorigin += offset;
    
    if ( !skipspawn || !isdefined( bombent ) )
    {
        bombent = spawn( "script_model", safeorigin );
        fullspawn = 1;
    }
    
    bombent.origin = safeorigin;
    
    if ( isdefined( originoverride ) )
    {
        bombmodel = "tag_origin";
        bombent.startorigin = safeorigin;
    }
    
    if ( !skipspawn || fullspawn )
    {
        bombent setmodel( bombmodel );
        bombent.visuals = [];
        bombent.visuals[ 0 ] = spawn( "script_model", bombent.origin );
        bombent.visuals[ 0 ] setmodel( "tag_origin" );
        bombent.trigger = spawnstruct();
        bombent.objidnum = -1;
        task.plantedbombs[ bombnum ] = bombent;
    }
    
    bombent.curorigin = bombent.origin;
    bombent.safeorigin = bombent.origin;
    bombent gameobjects::setdropped( undefined, undefined );
    task thread function_b9415f2f47afea88( bombent );
    task thread function_8e82dbad412db83a( bombent );
}

// Namespace namespace_dc3a0c120a108a2
// Params 1, eflags: 0x4
// Checksum 0xdf3d228a, Offset: 0x219f
// Size: 0x4e
function private function_a9cc2aa51cea29e5( player )
{
    bomb = makeweapon( "briefcase_bomb_mp" );
    player inventory_utility::_giveweapon( bomb, undefined, undefined, 0 );
    player setweaponammostock( bomb, 0 );
    player setweaponammoclip( bomb, 0 );
    player thread gameobjects::switchtouseweapon( bomb, 1 );
    return bomb;
}

// Namespace namespace_dc3a0c120a108a2
// Params 1, eflags: 0x4
// Checksum 0x117aee35, Offset: 0x21f6
// Size: 0x138
function private function_8e82dbad412db83a( bombent )
{
    task = self;
    bombent makeusable();
    bombent disableplayeruseforallplayers();
    
    foreach ( player in task.players )
    {
        bombent enableplayeruse( player );
    }
    
    bombent sethintstring( &"mp_dmz_missions/dmz_destroy_sam_samsite_defuse_hint" );
    bombent sethinticon( "ui_map_icon_obj_sh_bomb_defuse" );
    bombent sethintdisplayrange( 1024 );
    bombent setuserange( 90 );
    bombent setcursorhint( "HINT_BUTTON" );
    bombent sethintdisplayfov( 120 );
    bombent setusefov( 120 );
    bombent setuseholdduration( "duration_short" );
    task.bombent = bombent;
    bombent waittill( #"trigger", player );
    function_a9cc2aa51cea29e5( player );
    bombent hide();
    bombent makeunusable();
    function_58fca188eeb39a70( task, player, bombent );
}

// Namespace namespace_dc3a0c120a108a2
// Params 2, eflags: 0x4
// Checksum 0xc37b9de1, Offset: 0x2336
// Size: 0xa0
function private function_3da6d04cf07b8f1d( player, bombent )
{
    droporigin = player.origin;
    
    if ( isdefined( bombent.startorigin ) )
    {
        droporigin = bombent.startorigin;
        bombent show();
        bombent.trigger.origin = droporigin;
        return;
    }
    
    safeorigin = getclosestpointonnavmesh( droporigin );
    bombent.origin = safeorigin;
    bombent.trigger.origin = safeorigin;
}

// Namespace namespace_dc3a0c120a108a2
// Params 1
// Checksum 0xa3805812, Offset: 0x23de
// Size: 0xa1, Type: bool
function function_6e13482eb513ade8( bombnum )
{
    task = self;
    
    if ( !isdefined( task.availablenodes ) )
    {
        return false;
    }
    
    var_231764b69c1beca3 = task.availablenodes[ randomint( task.availablenodes.size ) ];
    safeorigin = getclosestpointonnavmesh( var_231764b69c1beca3.origin );
    
    if ( function_2972f6f5ccc0fe10( safeorigin ) )
    {
        task function_e3d5cf954eb3b105( safeorigin, bombnum );
        task.availablenodes = arrayremove( task.availablenodes, var_231764b69c1beca3 );
        return true;
    }
    
    return false;
}

// Namespace namespace_dc3a0c120a108a2
// Params 2
// Checksum 0x6403c401, Offset: 0x2488
// Size: 0x59, Type: bool
function function_74afcbfcfddd57be( origin, skipspawn )
{
    task = self;
    
    if ( !isdefined( origin ) )
    {
        return false;
    }
    
    safeorigin = getclosestpointonnavmesh( origin );
    
    if ( function_2972f6f5ccc0fe10( safeorigin ) )
    {
        task function_e3d5cf954eb3b105( safeorigin, 0, 1, skipspawn );
        return true;
    }
    
    return false;
}

// Namespace namespace_dc3a0c120a108a2
// Params 3
// Checksum 0x498fa834, Offset: 0x24ea
// Size: 0x13c
function function_a1ace995732ddde9( dropstruct, player, crate )
{
    var_6cdac992267212d4 = getdvarint( @"hash_3174d9a2553a5fa7", 1 );
    var_e7e703931fbca4 = [ "brloot_super_munitionsbox", "brloot_super_armorbox" ];
    teammatecount = undefined;
    teammates = teams::getsquadmates( player.team, player.sessionsquadid, 0 );
    
    if ( isdefined( teammates ) )
    {
        teammatecount = teammates.size;
    }
    
    if ( var_6cdac992267212d4 >= 0 )
    {
        for ( i = 0; i < var_6cdac992267212d4 ; i++ )
        {
            function_70cd056be8d9a095( dropstruct, player, crate );
        }
    }
    else if ( isdefined( teammatecount ) )
    {
        for ( i = 0; i < teammatecount ; i++ )
        {
            extraloot = var_e7e703931fbca4[ i % var_e7e703931fbca4.size ];
            function_70cd056be8d9a095( dropstruct, player, crate, extraloot );
        }
    }
    else
    {
        function_70cd056be8d9a095( dropstruct, player, crate );
    }
    
    if ( getdvarint( @"scr_emptypalfa_enable", 1 ) != 1 )
    {
        return;
    }
    
    spawnoptions = namespace_9d8e359c3b1041e5::initspawnoptions_spawnfromentitysharedfunc( player );
    namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_gascan_palfa", undefined, spawnoptions );
}

// Namespace namespace_dc3a0c120a108a2
// Params 4
// Checksum 0xbc76229f, Offset: 0x262e
// Size: 0x109
function function_70cd056be8d9a095( dropstruct, player, crate, extraloot )
{
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "bomb_defuse_reward" );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        if ( isdefined( crate ) && getdvarint( @"hash_13c3754911cca521", 1 ) )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( crate.origin, crate.angles );
            common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, spawnoptions );
            return;
        }
        
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( player );
        common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.var_185d29f84c8dc710, spawnoptions );
        
        if ( isdefined( extraloot ) )
        {
            namespace_9d8e359c3b1041e5::spawnnewitemfromscriptablesharedfunc( extraloot, player.origin, player.angles );
        }
    }
}

