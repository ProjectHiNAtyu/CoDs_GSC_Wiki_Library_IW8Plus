// script_1f9db1ea1ffd6741  (hash_1f9db1ea1ffd6741.gscc) (size: 13307 Bytes / 0x33fb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x900ad70b (2416629515)
// size ...... 13307 (0x33fb)
// includes .. 15  (offset: 0x2f2f)
// strings ... 79  (offset: 0x2fa7)
// dev strs .. 2   (offset: 0x33e3)
// exports ... 24  (offset: 0x212f)
// cseg ...... 0x683 + 0x1aac (0x212f)
// imports ... 83  (offset: 0x24ef)
// animtree1 . 0   (offset: 0x33fb)
// animtree2 . 0   (offset: 0x33fb)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_loot;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\locksandkeys;

#namespace namespace_9db1e12416591c99;

// Namespace namespace_9db1e12416591c99
// Params 1
// Checksum 0xe8d2e5b4, Offset: 0x6a1
// Size: 0x1d4
function dmztask_getspawndata( data )
{
    if ( !level.supportsai )
    {
        return;
    }
    
    level.elimprops = spawnstruct();
    level.elimprops.circleradius = getdvarint( @"hash_fff0fc72eb6baf5c", 800 );
    level.elimprops.circlepadding = getdvarint( @"hash_f1a5f02ed324be1f", 200 );
    level.elimprops.wanderradius = getdvarint( @"hash_bf58de61e69c846b", 200 );
    level.elimprops.tier3weight = getdvarint( @"hash_160d5dea50195723", 30 );
    level.elimprops.tier2weight = getdvarint( @"hash_cbd3439c13338226", 50 );
    level.elimprops.var_f4bfd7107aa88ef2 = getdvarint( @"hash_dc9a41086c28c4c2", 20 );
    level.elimprops.tier2keys = getdvarint( @"hash_6f328864b0b8dc62", 0 );
    level.elimprops.var_b17bad5ec6f666bc = getdvarint( @"hash_18b5f4b80cca8e31", 80 );
    level.elimprops.var_b366701c64e57fb7 = getdvarint( @"hash_4767a58a76a283f6", 30 );
    level.elimprops.var_6f33befcc3001e0e = getdvarint( @"hash_7b8b57c6513edd4f", 5 );
    level.elimprops.var_c6485f63c3c35ef1 = getdvarint( @"hash_1144299c01007574", 10 );
    validnodes = utility::getstructarray( "elim_target", "script_noteworthy" );
    activity_manager::function_f61a1f535aab4194( data, &function_1f95b178f0260286, validnodes );
}

/#

    // Namespace namespace_9db1e12416591c99
    // Params 0
    // Checksum 0xf9104590, Offset: 0x87d
    // Size: 0x16, Type: dev
    function function_746bdfc760ec9b18()
    {
        return utility::getstructarray( "<dev string:x24>", "<dev string:x30>" );
    }

#/

// Namespace namespace_9db1e12416591c99
// Params 2
// Checksum 0xb43bbee1, Offset: 0x89b
// Size: 0xff
function function_1f95b178f0260286( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_b9558d7d600974a1;
    task.funcs[ "onTeamStart" ] = &function_18e7e0ce53751166;
    task.funcs[ "onPlayerJoined" ] = &function_678483a07e9dd513;
    task.funcs[ "onPlayerRemoved" ] = &function_1905345437e8b422;
    task.funcs[ "onTeamAssigned" ] = &function_cb9040ae8c575e6e;
    task.funcs[ "onCancel" ] = &function_212c019f8c6a7b71;
    task.ref = "dmz_elimination";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.node = node;
    task.spawnreinforcements = 1;
    return task;
}

// Namespace namespace_9db1e12416591c99
// Params 0
// Checksum 0x2e88b6d4, Offset: 0x9a3
// Size: 0x415
function function_b9558d7d600974a1()
{
    self.activity.origin = self.node.origin;
    circlelocation = dmz_task_utils::function_c7ccd46fc59f189d( self.node.origin, level.elimprops.circleradius );
    dmz_task_utils::function_b3476f99a8e21fa2( circlelocation + ( 0, 0, 300 ) );
    dmz_task_utils::function_ca73a4f7b8d7aacb( "Hostage_Dmz", circlelocation, level.elimprops.circleradius + 200 );
    var_f99aea3df1138286 = [];
    targetorigin = getclosestpointonnavmesh( self.node.origin );
    aitype = ai_mp_controller::function_f7aef6871cda828( "ar" );
    elimtarget = ai_mp_controller::ai_mp_requestspawnagent( aitype, targetorigin, self.node.angles, "absolute", "mission", "elimTarget", undefined, undefined, undefined, self.node.script_poi, 0, undefined, 0 );
    
    if ( !isdefined( elimtarget ) )
    {
        function_be0a73a067339365();
        return;
    }
    
    elimtarget.var_4f8a92ebabf37ee = 0;
    var_429063809711e232 = [ "thermite_mp", "semtex_mp", "frag_grenade_mp", "smoke_grenade_mp", "concussion_grenade_mp", "flash_grenade_mp", "snapshot_grenade_mp", "gas_mp", "decoy_grenade_mp" ];
    grenade_type = utility::array_random( var_429063809711e232 );
    armor = 500;
    helmet = 3;
    body = utility::array_random( [ "body_dmz_opforce_cartel_1_1", "body_dmz_opforce_cartel_1_2", "body_dmz_opforce_cartel_1_3", "body_dmz_opforce_cartel_2_1", "body_dmz_opforce_cartel_2_2", "body_dmz_opforce_cartel_2_3", "body_dmz_opforce_cartel_3_1", "body_dmz_opforce_cartel_3_2", "body_dmz_opforce_cartel_3_3" ] );
    head = utility::array_random( [ "head_sp_opforce_cartel_tier_2_2_1", "head_sp_opforce_cartel_tier_2_5_1", "head_sp_opforce_cartel_tier_2_6_1" ] );
    elimtarget agent_utils::overrideagentsettings( body, head, dmztask_getrandomweapon(), grenade_type, 4, armor, helmet );
    
    if ( getdvarint( @"hash_49b37fc622a4d585", 0 ) == 1 )
    {
        elimtarget function_e2952bb17f46a796( 1, 4, "MP_DMZ_MISSIONS/BOSS_NAME_YEGOR" );
    }
    
    var_f99aea3df1138286[ 0 ] = elimtarget;
    self.enemy = elimtarget;
    thread function_8975d7c44593649a();
    
    /#
        thread function_e10451d17a4aa873();
    #/
    
    thread ai_behavior::behavior_GuardStationary( elimtarget, undefined, self.node.origin );
    minions = [];
    
    if ( isdefined( self.node.target ) )
    {
        minions = function_be5dc4bd07ad1b28( self.node.target, self.enemy.origin );
        
        if ( minions.size > 0 )
        {
            var_f99aea3df1138286 = arraycombine( var_f99aea3df1138286, minions );
        }
    }
    
    foreach ( agent in minions )
    {
        thread ai_behavior::behavior_GuardWander( agent, level.elimprops.wanderradius, 0 );
    }
    
    /#
        self.enemy thread function_c5831b8bf85b7752();
    #/
    
    function_9fabec2a262051f3( self.enemy );
    self.enemy.dontkilloff = 1;
    self.enemy thread function_f611dd58d6f41f81( self );
    self.name = function_b204efd5bc8f336e();
}

// Namespace namespace_9db1e12416591c99
// Params 1
// Checksum 0xa0f8ce75, Offset: 0xdc0
// Size: 0x31
function function_678483a07e9dd513( player )
{
    if ( self.started )
    {
        dmz_audio::function_1219191cbcd38758( [ player ], "dmz_elimination_start", undefined, "dmz_elimination_start_classic" );
    }
}

// Namespace namespace_9db1e12416591c99
// Params 1
// Checksum 0x7343159c, Offset: 0xdf9
// Size: 0x18
function function_1905345437e8b422( player )
{
    player setplayermusicstate( "" );
}

// Namespace namespace_9db1e12416591c99
// Params 1
// Checksum 0xe9362e86, Offset: 0xe19
// Size: 0x15d
function function_cb9040ae8c575e6e( teamname )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    players = teams::getteamdata( teamname, "players" );
    dmz_task_utils::task_showsplashtoteam( "dmz_elim_assigned", teamname );
    dmz_task_utils::function_18b83232055b1325( teamname );
    thread dmz_task_utils::function_96037ebc29937337( teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_elimination_start", 1, "dmz_elimination_start_classic" );
    
    if ( !self.var_5f33f6e8c3317f20 )
    {
        if ( br_gametype_dmz::function_e6d940bc5935f1ba() )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "elim_assigned_" + utility::array_random( [ "hpt", "hvt" ] ), teamname, 2 );
        }
        else
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "elim_assigned_" + self.name, teamname, 2 );
        }
        
        return;
    }
    
    if ( br_gametype_dmz::function_e6d940bc5935f1ba() )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"elim_target_killed_enemy_generic", teamname, 2.5 );
        return;
    }
    
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"elim_target_killed_enemy", teamname, 2.5 );
}

// Namespace namespace_9db1e12416591c99
// Params 1
// Checksum 0x6d4101b4, Offset: 0xf7e
// Size: 0x15
function function_18e7e0ce53751166( teamname )
{
    thread function_9d6c2cfa935b2de3( teamname );
}

// Namespace namespace_9db1e12416591c99
// Params 1
// Checksum 0xedddf1cc, Offset: 0xf9b
// Size: 0xac
function function_212c019f8c6a7b71( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        player setplayermusicstate( "" );
    }
    
    if ( !self.completed )
    {
        function_be0a73a067339365();
    }
}

// Namespace namespace_9db1e12416591c99
// Params 1, eflags: 0x4
// Checksum 0xf605b851, Offset: 0x104f
// Size: 0x5e5
function private function_f611dd58d6f41f81( task )
{
    task endon( #"task_ended" );
    level endon( #"game_ended" );
    self waittill( #"death", killer );
    
    if ( isdefined( task.activity.activitystarter ) )
    {
        task.activity.activitystarter activity_manager::function_2a0e4909a5f9b6a4();
    }
    
    killerteam = undefined;
    nearbyteammate = undefined;
    origin = self.origin;
    
    if ( killer vehicle::is_vehicle() )
    {
        killerteam = killer.ownerteam;
    }
    else if ( isplayer( killer ) )
    {
        killerteam = killer.team;
    }
    
    if ( isdefined( task.teams[ 0 ] ) )
    {
        nearbyteammate = task function_1f85bd4d54bf38c5( origin, 300, task.teams[ 0 ] );
    }
    else if ( isdefined( killerteam ) )
    {
        nearbyteammate = task function_1f85bd4d54bf38c5( origin, 300, killerteam );
    }
    
    wait 1;
    
    if ( isdefined( task.teams[ 0 ] ) )
    {
        if ( isdefined( nearbyteammate ) && nearbyteammate.team == task.teams[ 0 ] )
        {
            task dmz_task_utils::function_e533421ccebd7d79( task.teams[ 0 ] );
            task dmz_task_utils::function_c64a66646904bc1( "dmz_elim_complete", "elim", task.activity.cashreward, task.teams[ 0 ] );
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"elim_yegor_kia_confirmed", task.teams[ 0 ], 2.5 );
            dmz_audio::function_32ff837bc21a4833( task.teams[ 0 ], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic" );
            task thread function_be0a73a067339365( task.teams[ 0 ] );
            return;
        }
        else if ( killerteam == task.teams[ 0 ] )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"elim_yegor_killed", task.teams[ 0 ], 2.5 );
            dmz_audio::function_32ff837bc21a4833( task.teams[ 0 ], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic" );
        }
        else
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"elim_target_killed_enemy", task.teams[ 0 ], 2.5 );
            dmz_audio::function_32ff837bc21a4833( task.teams[ 0 ], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic" );
        }
        
        if ( !isdefined( nearbyteammate ) )
        {
            task function_aa785900a6a4499d( origin, task.teams[ 0 ] );
            task dmz_task_utils::function_c64a66646904bc1( "dmz_elim_complete", "elim", task.activity.cashreward, task.teams[ 0 ] );
            task dmz_task_utils::function_e533421ccebd7d79( task.teams[ 0 ] );
            
            if ( br_gametype_dmz::function_e6d940bc5935f1ba() )
            {
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "elim_target_confirmed_no_contract_" + utility::array_random( [ "hpt", "hvt" ] ), task.teams[ 0 ], 2.5 );
            }
            else
            {
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "elim_target_confirmed_no_contract_" + task.name, task.teams[ 0 ], 2.5 );
            }
            
            dmz_audio::function_32ff837bc21a4833( task.teams[ 0 ], "dmz_elimination_win", 0.5, "dmz_elimination_win_classic" );
            task thread function_be0a73a067339365( task.teams[ 0 ] );
        }
        
        return;
    }
    
    if ( isdefined( killerteam ) )
    {
        if ( isdefined( nearbyteammate ) )
        {
            if ( br_gametype_dmz::function_e6d940bc5935f1ba() )
            {
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "elim_target_killed_not_assigned_" + utility::array_random( [ "hpt", "hvt" ] ), killerteam, 2.5 );
            }
            else
            {
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "elim_target_killed_not_assigned_" + task.name, killerteam, 2.5 );
            }
            
            dmz_audio::function_32ff837bc21a4833( killerteam, "dmz_elimination_win", 0.5, "dmz_elimination_win_classic" );
            task dmz_task_utils::function_e533421ccebd7d79( killerteam );
            task thread function_be0a73a067339365( undefined );
            return;
        }
        
        if ( br_gametype_dmz::function_e6d940bc5935f1ba() )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "elim_target_killed_no_contract_no_confirmation_" + utility::array_random( [ "hpt", "hvt" ] ), killerteam, 2.5 );
        }
        else
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "elim_target_killed_no_contract_no_confirmation_" + task.name, killerteam, 2.5 );
        }
        
        task function_aa785900a6a4499d( origin, killerteam );
        
        if ( br_gametype_dmz::function_e6d940bc5935f1ba() )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "elim_target_confirmed_no_contract_" + utility::array_random( [ "hpt", "hvt" ] ), killerteam, 2.5 );
        }
        else
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "elim_target_confirmed_no_contract_" + task.name, killerteam, 2.5 );
        }
        
        dmz_audio::function_32ff837bc21a4833( killerteam, "dmz_elimination_win", 0.5, "dmz_elimination_win_classic" );
        task dmz_task_utils::function_e533421ccebd7d79( killerteam );
        task thread function_be0a73a067339365();
    }
}

// Namespace namespace_9db1e12416591c99
// Params 2, eflags: 0x4
// Checksum 0x14177059, Offset: 0x163c
// Size: 0x76
function private function_aa785900a6a4499d( origin, team )
{
    dmz_task_utils::function_844c661c74b52ce3( "dmz_confirm_kill" );
    self.var_5f33f6e8c3317f20 = 1;
    dmz_task_utils::function_c74c010e593f5ea5( origin + ( 0, 0, 50 ) );
    dmz_task_utils::function_e23cad864e9e2023();
    
    while ( true )
    {
        teammate = function_1f85bd4d54bf38c5( origin, 200, team );
        
        if ( isdefined( teammate ) )
        {
            break;
        }
        
        wait 1;
    }
}

// Namespace namespace_9db1e12416591c99
// Params 1, eflags: 0x4
// Checksum 0x92195254, Offset: 0x16ba
// Size: 0x2e
function private function_be0a73a067339365( winningteam )
{
    self.completed = 1;
    dmz_task_utils::function_3ff46488beb193c7();
    dmz_task_utils::function_e23cad864e9e2023();
    dmz_task_utils::task_ended( winningteam );
}

// Namespace namespace_9db1e12416591c99
// Params 3, eflags: 0x4
// Checksum 0xb8525e7a, Offset: 0x16f0
// Size: 0xac
function private function_1f85bd4d54bf38c5( origin, range, team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( distance( player.origin, origin ) < range )
        {
            return player;
        }
    }
}

// Namespace namespace_9db1e12416591c99
// Params 1, eflags: 0x4
// Checksum 0x5ac50f8b, Offset: 0x17a5
// Size: 0x132
function private function_9fabec2a262051f3( agent )
{
    categories = [ 1, 2, 3, 4 ];
    
    if ( game_utility::function_238d71fc76232bef() )
    {
        categories = [ "1_sealion", "2_sealion", "3_sealion", "4_sealion" ];
    }
    else if ( game_utility::function_36de887ad1f5532e() )
    {
        categories = [ "1_delta", "2_delta", "3_delta", "4_delta" ];
    }
    
    weights = [ level.elimprops.var_b17bad5ec6f666bc, level.elimprops.var_b366701c64e57fb7, level.elimprops.var_6f33befcc3001e0e, level.elimprops.var_c6485f63c3c35ef1 ];
    randomkey = locksandkeys::function_9f6bed63bb2485e( categories, weights, 20, 60, 20 );
    
    if ( isdefined( randomkey ) )
    {
        ai_loot::function_452f7cba22550779( agent, randomkey );
    }
    
    ai_loot::function_452f7cba22550779( agent, "loot_key_fortress" );
}

// Namespace namespace_9db1e12416591c99
// Params 1, eflags: 0x4
// Checksum 0xcae75290, Offset: 0x18df
// Size: 0x6e
function private function_9d6c2cfa935b2de3( teamname )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( self.enemy ) )
        {
            continue;
        }
        
        if ( !isalive( self.enemy ) )
        {
            return;
        }
        
        function_89ef2f568302be6( self.enemy.origin, teamname );
    }
}

// Namespace namespace_9db1e12416591c99
// Params 0
// Checksum 0x42ef97a4, Offset: 0x1955
// Size: 0x176
function function_8975d7c44593649a()
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self.enemy endon( #"death" );
    
    while ( true )
    {
        circle = self.questcircles[ 0 ].mapcircle.origin;
        radius = circle[ 2 ];
        origin = ( circle[ 0 ], circle[ 1 ], 0 );
        dist = distance2dsquared( self.enemy.origin, origin );
        
        if ( dist > level.elimprops.circleradius * level.elimprops.circleradius )
        {
            circlelocation = dmz_task_utils::function_c7ccd46fc59f189d( self.enemy.origin, level.elimprops.circleradius );
            newcircle = ( circlelocation[ 0 ], circlelocation[ 1 ], radius );
            self.questcircles[ 0 ].mapcircle moveto( newcircle, 1, 0.25, 0.25 );
            dmz_task_utils::function_c74c010e593f5ea5( ( circlelocation[ 0 ], circlelocation[ 1 ], self.enemy.origin[ 2 ] + 300 ) );
        }
        
        wait 1;
    }
}

// Namespace namespace_9db1e12416591c99
// Params 2, eflags: 0x4
// Checksum 0xd8d8adb2, Offset: 0x1ad3
// Size: 0x150
function private function_89ef2f568302be6( enemyloc, teamname )
{
    if ( !self.var_42f271a2433bc927 )
    {
        players = teams::getteamdata( teamname, "players" );
        
        foreach ( player in players )
        {
            if ( isalive( player ) && distancesquared( player.origin, enemyloc ) < 1000000 )
            {
                self.var_42f271a2433bc927 = 1;
                player thread function_c554561b9923f20b( self.enemy.origin, teamname );
                
                if ( br_gametype_dmz::function_e6d940bc5935f1ba() )
                {
                    thread utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"elim_target_near_generic", teamname, 2 );
                }
                else
                {
                    thread utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"elim_target_near", teamname, 2 );
                }
                
                break;
            }
        }
    }
}

// Namespace namespace_9db1e12416591c99
// Params 2, eflags: 0x4
// Checksum 0xea377070, Offset: 0x1c2b
// Size: 0xfe
function private function_c554561b9923f20b( enemyloc, teamname )
{
    if ( !self.var_cd44b9b1f14cf756 )
    {
        teamplayers = teams::getteamdata( teamname, "players" );
        nearplayers = [];
        
        foreach ( player in teamplayers )
        {
            if ( isalive( player ) && distancesquared( player.origin, enemyloc ) < 2250000 )
            {
                nearplayers[ nearplayers.size ] = player;
                player.var_cd44b9b1f14cf756 = 1;
            }
        }
        
        dmz_audio::function_1219191cbcd38758( nearplayers, "dmz_elimination_approach", 0, "dmz_elimination_approach_classic" );
    }
}

// Namespace namespace_9db1e12416591c99
// Params 0, eflags: 0x4
// Checksum 0xf4e8af41, Offset: 0x1d31
// Size: 0x46
function private dmztask_getrandomweapon()
{
    weaponscriptable = utility::array_random( [ "brloot_weapon_ar_akilo105_epic", "brloot_weapon_ar_mike4_rare", "brloot_weapon_ar_scharlie_elim_hvt" ] );
    return level.br_lootiteminfo[ weaponscriptable ].fullweaponobj;
}

// Namespace namespace_9db1e12416591c99
// Params 2, eflags: 0x4
// Checksum 0xa469f48a, Offset: 0x1d80
// Size: 0x221
function private function_be5dc4bd07ad1b28( target, var_ec482f70a88ffd1f )
{
    minionnodes = utility::getstructarray( target, "targetname" );
    minions = [];
    totalweight = level.elimprops.tier3weight + level.elimprops.tier2weight + level.elimprops.var_f4bfd7107aa88ef2;
    tier3chance = level.elimprops.tier3weight / totalweight;
    tier2chance = level.elimprops.tier2weight / totalweight + tier3chance;
    basetier = utility::callsharedfunc( #"poi", #"hash_7f732c09fb6c538d", self.node.origin );
    
    foreach ( node in minionnodes )
    {
        rand = randomfloat( 1 );
        spawnset = "guard";
        basetype = undefined;
        tier = basetier + 1;
        
        if ( rand < tier3chance )
        {
        }
        else if ( rand < tier2chance )
        {
            tier = basetier;
        }
        else
        {
            basetype = "strikeunit";
            tier = basetier + 1;
        }
        
        aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, undefined, spawnset, basetype, tier );
        agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, node.origin, node.angles, "high", "mission", "elimGuards", undefined, undefined, undefined, undefined, 0 );
        
        if ( isdefined( agent ) )
        {
            minions[ minions.size ] = agent;
        }
    }
    
    return minions;
}

// Namespace namespace_9db1e12416591c99
// Params 0
// Checksum 0x30aab769, Offset: 0x1faa
// Size: 0x92
function function_b204efd5bc8f336e()
{
    if ( !isdefined( level.elimnameindex ) )
    {
        level.elimnameindex = 0;
    }
    
    names = [ "machado", "crybaby", "montoya", "navarro", "estrada", "romero", "toreador", "chavez" ];
    name = names[ level.elimnameindex % names.size ];
    level.elimnameindex++;
    return name;
}

// Namespace namespace_9db1e12416591c99
// Params 0, eflags: 0x4
// Checksum 0x3b5ca072, Offset: 0x2045
// Size: 0x5c
function private function_c5831b8bf85b7752()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( getdvarint( @"hash_beea5652fd628e2e", 0 ) == 1 )
        {
            if ( isalive( self ) )
            {
                thread debug::drawsphere( self.origin, 64, 1, ( 1, 0, 1 ) );
            }
        }
        
        wait 1;
    }
}

/#

    // Namespace namespace_9db1e12416591c99
    // Params 0
    // Checksum 0xfe3b4baf, Offset: 0x20a9
    // Size: 0x86, Type: dev
    function function_e10451d17a4aa873()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_f0492c0f6c817512", 0 ) )
            {
                setdvar( @"hash_f0492c0f6c817512", 0 );
                
                if ( distance2d( self.enemy.origin, level.players[ 0 ].origin ) < 2000 )
                {
                    self.enemy setorigin( level.players[ 0 ].origin, 1 );
                }
            }
            
            waitframe();
        }
    }

#/
