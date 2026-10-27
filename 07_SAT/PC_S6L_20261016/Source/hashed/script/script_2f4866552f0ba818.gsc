// script_2f4866552f0ba818  (hash_2f4866552f0ba818.gscc) (size: 11085 Bytes / 0x2b4d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x99794a54 (2574862932)
// size ...... 11085 (0x2b4d)
// includes .. 9   (offset: 0x2925)
// strings ... 23  (offset: 0x296d)
// dev strs .. 10  (offset: 0x2ac9)
// exports ... 18  (offset: 0x1e9d)
// cseg ...... 0x1af + 0x1cee (0x1e9d)
// imports ... 59  (offset: 0x216d)
// animtree1 . 0   (offset: 0x2b4d)
// animtree2 . 0   (offset: 0x2b4d)
#using scripts\common\ai\stealth\enemy;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\dmz\gametypes\dmz_ai;
#using scripts\mp\gametypes\common;
#using scripts\mp\mp_gameskill;

#namespace namespace_14ab7f658b8ad5e4;

// Namespace namespace_14ab7f658b8ad5e4
// Params 0
// Checksum 0xd2dda7a9, Offset: 0x1cd
// Size: 0x20d
function function_a1e291f650f8bab3()
{
    level.var_cd071ae2d95ce178 = getdvarint( @"hash_298cc7147ef3f50b", 0 );
    ai_mp_controller::init();
    
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
    }
    
    while ( !isdefined( level.stealth ) )
    {
        waitframe();
    }
    
    while ( !isdefined( level.agentarray ) )
    {
        waitframe();
    }
    
    setdvar( @"hash_d3907cde9245b595", 0 );
    level.var_c98a3a72c3f25319 = getdvarint( @"hash_dc995ffe71bb3262", 256 );
    level.var_d95835502ec96520 = getdvarint( @"hash_80dab21524b4b344", 32 );
    level.var_88bc630f649e2bd5 = getdvarint( @"hash_23d2d501004ed790", 2 );
    level.var_dd33972e3281439c = getdvarint( @"hash_6d3496529af637a1", 6 );
    level.ai_badPathHandler = &armai_badpathhandler;
    wait 1;
    level.var_98b34b6f2882c202 = [];
    
    foreach ( objective in level.objectives )
    {
        objective.assignedagents = [];
    }
    
    hqorigin = level.gw_objstruct.axishqloc.trigger.origin;
    function_289496ee1f4ab618( "axis", hqorigin );
    hqorigin = level.gw_objstruct.allieshqloc.trigger.origin;
    function_289496ee1f4ab618( "allies", hqorigin );
    
    while ( !( isdefined( level.gameskill ) && isdefined( level.difficultytype ) ) )
    {
        waitframe();
    }
    
    level thread function_521a8b5f40d81074( "axis" );
    level thread function_521a8b5f40d81074( "allies" );
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 2
// Checksum 0x950a59b7, Offset: 0x3e2
// Size: 0x2a6
function function_289496ee1f4ab618( team, hqorigin )
{
    var_32364b26d5f93623 = [];
    
    if ( !isdefined( level.var_37577f906456bfad ) )
    {
        level.var_37577f906456bfad = [];
    }
    
    level.var_37577f906456bfad[ team ] = [];
    
    foreach ( objective in level.objectives )
    {
        objective.assignedagents[ team ] = [];
    }
    
    foreach ( objective in level.objectives )
    {
        var_32364b26d5f93623[ objective.objectivekey ] = distance( hqorigin, objective.origin );
    }
    
    var_3cbb7ce347601837 = sortbydistance( level.objectives, hqorigin );
    var_ec1462a0acdc4764 = 0;
    var_91059fd146e56a29 = undefined;
    
    foreach ( objective in var_3cbb7ce347601837 )
    {
        if ( level.var_37577f906456bfad[ team ].size == 0 )
        {
            level.var_37577f906456bfad[ team ][ var_ec1462a0acdc4764 ] = [];
            level.var_37577f906456bfad[ team ][ var_ec1462a0acdc4764 ][ 0 ] = objective;
            var_91059fd146e56a29 = var_32364b26d5f93623[ objective.objectivekey ];
            continue;
        }
        
        if ( abs( var_91059fd146e56a29 - var_32364b26d5f93623[ objective.objectivekey ] ) < 2048 )
        {
            level.var_37577f906456bfad[ team ][ var_ec1462a0acdc4764 ][ level.var_37577f906456bfad[ team ][ var_ec1462a0acdc4764 ].size ] = objective;
            var_91059fd146e56a29 = var_32364b26d5f93623[ objective.objectivekey ];
            continue;
        }
        
        var_ec1462a0acdc4764++;
        level.var_37577f906456bfad[ team ][ var_ec1462a0acdc4764 ] = [];
        level.var_37577f906456bfad[ team ][ var_ec1462a0acdc4764 ][ 0 ] = objective;
        var_91059fd146e56a29 = var_32364b26d5f93623[ objective.objectivekey ];
    }
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 1
// Checksum 0x33989147, Offset: 0x690
// Size: 0x1b8
function function_521a8b5f40d81074( team )
{
    level endon( #"game_ended" );
    hqstring = "gw_fob_" + team + "HQ";
    var_8ac28db1d6e83438 = level.spawnselectionlocations[ hqstring ][ team ].spawnpoints;
    budgetname = "spawnHQ_" + team;
    ai_mp_controller::aibudget_registercategory( budgetname, level.var_d95835502ec96520 );
    level thread function_6dc56859d2c01245();
    
    while ( true )
    {
        totalspawned = ai_mp_controller::function_62448bd2c6f12ae9( budgetname );
        currentspawntarget = level.var_d95835502ec96520 - totalspawned;
        
        if ( currentspawntarget > level.var_88bc630f649e2bd5 )
        {
            currentspawntarget = level.var_88bc630f649e2bd5;
        }
        
        var_8ac28db1d6e83438 = arrayrandomize( var_8ac28db1d6e83438 );
        
        for ( i = 0; i < currentspawntarget ; i++ )
        {
            aitype = ai_mp_controller::function_b86341658788836c();
            agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, var_8ac28db1d6e83438[ i ].origin, var_8ac28db1d6e83438[ i ].angles, "medium", budgetname, undefined, budgetname, team );
            
            if ( isdefined( agent ) )
            {
                agent thread function_def3c8d100185761( agent, team );
                objectivetarget = function_948cd0d9a3d21cf9( agent );
                origin = getclosestpointonnavmesh( objectivetarget.origin + ( randomfloatrange( level.var_c98a3a72c3f25319 * -1, level.var_c98a3a72c3f25319 ), randomfloatrange( level.var_c98a3a72c3f25319 * -1, level.var_c98a3a72c3f25319 ), 0 ) );
                agent thread ai_behavior::behavior_combatRushOrigin( agent, origin );
            }
        }
        
        wait 20;
    }
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 2
// Checksum 0x7785ca9b, Offset: 0x850
// Size: 0x3c
function function_def3c8d100185761( agent, team )
{
    waitframe();
    agent.gameskill = mp_gameskill::get_gameskill();
    agent mp_gameskill::apply_difficulty_settings( 1 );
    function_69e6297497c0bdd4( agent );
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 1
// Checksum 0x6b6420fa, Offset: 0x894
// Size: 0x2c2
function function_948cd0d9a3d21cf9( agent )
{
    if ( isdefined( agent.objectivetarget ) && agent.objectivetarget.ownerteam == "neutral" )
    {
        return agent.objectivetarget;
    }
    
    foreach ( index, group in level.var_37577f906456bfad[ agent.team ] )
    {
        if ( index <= agent.var_ec1462a0acdc4764 )
        {
            continue;
        }
        
        tempgroup = arrayrandomize( group );
        
        foreach ( objective in tempgroup )
        {
            if ( objective.assignedagents[ agent.team ].size < level.var_dd33972e3281439c && ( objective.ownerteam == agent.team || objective.ownerteam == "neutral" ) )
            {
                agent.objectivetarget = objective;
                agent.var_ec1462a0acdc4764 = index;
                objective.assignedagents[ agent.team ][ objective.assignedagents[ agent.team ].size ] = agent;
                return objective;
            }
        }
    }
    
    if ( !isdefined( agent.objectivetarget ) )
    {
        keys = getarraykeys( level.var_37577f906456bfad[ agent.team ] );
        var_e5617dec64199ccb = utility::array_random( keys );
        randomgroup = level.var_37577f906456bfad[ agent.team ][ var_e5617dec64199ccb ];
        objective = utility::array_random( randomgroup );
        agent.objectivetarget = objective;
        agent.var_ec1462a0acdc4764 = var_e5617dec64199ccb;
        objective.assignedagents[ agent.team ][ objective.assignedagents[ agent.team ].size ] = agent;
        return objective;
    }
    
    return agent.objectivetarget;
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 0
// Checksum 0x9b6d09fb, Offset: 0xb5f
// Size: 0x113
function function_6dc56859d2c01245()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( agent in level.agentarray )
        {
            if ( isalive( agent ) && isdefined( agent.objectivetarget ) )
            {
                objectivetarget = function_948cd0d9a3d21cf9( agent );
                origin = getclosestpointonnavmesh( objectivetarget.origin + ( randomfloatrange( level.var_c98a3a72c3f25319 * -1, level.var_c98a3a72c3f25319 ), randomfloatrange( level.var_c98a3a72c3f25319 * -1, level.var_c98a3a72c3f25319 ), 0 ) );
                agent thread ai_behavior::behavior_combatRushOrigin( agent, origin );
            }
        }
        
        wait 20;
    }
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 1
// Checksum 0xfb001425, Offset: 0xc7a
// Size: 0xbe
function function_69e6297497c0bdd4( agent )
{
    if ( agent.team == "axis" )
    {
        body = "body_spetsnaz_cqc";
        head = "head_spetsnaz_cqc";
    }
    else
    {
        body = "body_mp_eastern_geist_1_1_lod1";
        head = "head_mp_eastern_bale_1_1";
    }
    
    weapon = undefined;
    grenade_type = agent_utils::function_c7ac99e13a55d70e();
    grenadeammo = getdvarint( @"hash_2e7cc22bee3354df", 0 );
    armor = 0;
    agent agent_utils::overrideagentsettings( body, head, weapon, grenade_type, grenadeammo, armor );
    agent.baseaccuracy = getdvarfloat( @"hash_949a1d9903e71c7a", 0.4 );
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 2
// Checksum 0xd4f18cf4, Offset: 0xd40
// Size: 0x9a
function armai_badpathhandler( agent, badpathpos )
{
    if ( !isdefined( agent.objectivetarget ) )
    {
        objectivetarget = function_948cd0d9a3d21cf9( agent );
    }
    
    increasedvariance = level.var_c98a3a72c3f25319 * 3;
    origin = getclosestpointonnavmesh( agent.objectivetarget.origin + ( randomfloatrange( increasedvariance * -1, increasedvariance ), randomfloatrange( increasedvariance * -1, increasedvariance ), 0 ) );
    agent thread ai_behavior::behavior_combatRushOrigin( agent, origin );
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 0
// Checksum 0xdf4a3246, Offset: 0xde2
// Size: 0x18e
function function_dabd1d39c4490160()
{
    var_83f77882375264ca = getdvarint( @"hash_f4b8192392c987fc", 25 );
    var_ca1f05ad444af2c0 = getdvarint( @"hash_8eec5964fbfe4a41", 5 );
    
    /#
        if ( level.var_cd071ae2d95ce178 )
        {
            println( "<dev string:x24>" );
            println( "<dev string:x4a>" );
            println( "<dev string:x68>" + var_83f77882375264ca );
            println( "<dev string:x7f>" + var_ca1f05ad444af2c0 );
            println( "<dev string:x91>" + level.agentarray.size );
            println( "<dev string:xa2>" + isdefined( level.stealth ) );
            println( "<dev string:x24>" );
        }
    #/
    
    possiblelocations = [];
    
    foreach ( key, data in level.spawnselectionlocations )
    {
        if ( issubstr( key, "_hq_" ) )
        {
            continue;
        }
        
        possiblelocations[ key ] = data;
    }
    
    var_3033059b3decd031 = possiblelocations.size * var_83f77882375264ca / 100;
    objkeys = getarraykeys( possiblelocations );
    objkeys = arrayrandomize( objkeys );
    
    for ( i = 0; i < var_3033059b3decd031 ; i++ )
    {
        function_2a24755065361cce( var_ca1f05ad444af2c0, objkeys[ i ], "team_six", 1 );
    }
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 4
// Checksum 0x5eb0412, Offset: 0xf78
// Size: 0x32a
function function_2a24755065361cce( numagents, objectivename, team, var_32ac624911d12314 )
{
    var_8ac28db1d6e83438 = [];
    
    if ( var_32ac624911d12314 )
    {
        foreach ( team in level.spawnselectionlocations[ objectivename ] )
        {
            var_8ac28db1d6e83438 = arraycombine( var_8ac28db1d6e83438, team.spawnpoints );
        }
    }
    
    agents = [];
    
    for ( i = 0; i < numagents ; i++ )
    {
        loc = utility::array_random( var_8ac28db1d6e83438 );
        agent = undefined;
        
        if ( isdefined( loc ) && isdefined( loc.origin ) && isdefined( loc.angles ) && isdefined( objectivename ) )
        {
            aitype = ai_mp_controller::function_b86341658788836c();
            agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, loc.origin, loc.angles, "medium", "everybody", "objective", objectivename );
            
            /#
                if ( !isdefined( agent ) && level.var_cd071ae2d95ce178 )
                {
                    println( "<dev string:x24>" );
                    println( "<dev string:xb3>" );
                    println( "<dev string:xd2>" + aitype );
                    println( "<dev string:xdb>" + loc.origin );
                    println( "<dev string:xe3>" + loc.angles );
                    println( "<dev string:x24>" );
                }
            #/
        }
        
        agents[ agents.size ] = agent;
    }
    
    objectiveorigin = undefined;
    
    foreach ( objective in level.gw_objstruct.startingfobs_neutral )
    {
        if ( objective.name == objectivename )
        {
            objectiveorigin = objective.trigger.origin;
            break;
        }
    }
    
    foreach ( agent in agents )
    {
        if ( isalive( agent ) )
        {
            if ( isdefined( objectiveorigin ) )
            {
                agent ai_behavior::function_4a3c03bb49dd5d76( getclosestpointonnavmesh( objectiveorigin ), 1024 );
            }
            
            agent enemy::bt_set_stealth_state( "combat", undefined );
            agent.stealth.script_nexthuntpos = objectiveorigin;
        }
    }
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 3
// Checksum 0xe257158a, Offset: 0x12aa
// Size: 0x8d
function function_7f52fc1bdeee6bf6( objectivekey, numagents, team )
{
    if ( !isdefined( team ) )
    {
        return;
    }
    
    objectiveorigin = level.objectives[ objectivekey ].trigger.origin;
    agents = [[ utility::getsharedfunc( #"heli", #"requestReinforcements" ) ]]( numagents, objectiveorigin, "medium", "everybody", "heli", objectivekey, team );
    return agents;
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 3
// Checksum 0xdc46f34d, Offset: 0x1340
// Size: 0x95
function function_f9e822d29d1a0944( objectivekey, numagents, team )
{
    if ( !isdefined( team ) )
    {
        return;
    }
    
    objectiveorigin = level.objectives[ objectivekey ].trigger.origin;
    agents = [[ utility::getsharedfunc( #"para", #"requestReinforcements" ) ]]( numagents, objectiveorigin, objectiveorigin[ 2 ] + 5000, undefined, "medium", "everybody", "paratroopers", team );
    return agents;
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 0
// Checksum 0xfb01b4c9, Offset: 0x13de
// Size: 0xf4
function armai_defenders()
{
    level thread dmz_ai::init();
    ai_mp_controller::init();
    ai_mp_controller::aibudget_registercategory( "everybody", 100 );
    
    while ( !level.var_aed2551dbad09889 )
    {
        waitframe();
    }
    
    level thread function_706d6c9afc1dbc18();
    ai_mp_controller::function_7f833bacb64445a6();
    
    foreach ( key, obj in level.objectives )
    {
        numagents = getdvarint( @"hash_c9a6b9ed9529aead", 15 );
        var_b6933894644e835a = getdvarint( @"hash_fa7168124c5a98ed", 0 );
        level thread function_cac6dbdf1966b849( key, "team_hundred_ninety_four", numagents, var_b6933894644e835a, 1 );
    }
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 5
// Checksum 0xa6bc45c0, Offset: 0x14da
// Size: 0x4cf
function function_cac6dbdf1966b849( objectivekey, team, numagents, var_b6933894644e835a, spawninplace )
{
    obj = level.objectives[ objectivekey ];
    groupname = ai_mp_controller::function_391d43ea550a7a49( obj.trigger.origin );
    cqbstruct = ai_behavior::function_d0bbcf89dc23b3b3( obj.trigger.origin, 1024, 1 );
    cqbnodes = arraycombine( cqbstruct.cqbcovernodes, cqbstruct.var_8144cabf597859eb, cqbstruct.var_ec741bb10c6a8231 );
    
    if ( !isdefined( numagents ) )
    {
        numagents = getdvarint( @"hash_32626c81a7c27e96", 5 );
    }
    
    if ( numagents > 0 )
    {
        if ( !spawninplace )
        {
            agents_heli = [[ utility::getsharedfunc( #"heli", #"requestReinforcements" ) ]]( numagents, obj.trigger.origin, "medium", "everybody", "captureAgents", groupname, team, 1, undefined, undefined, undefined, undefined, 1 );
            
            foreach ( agent in agents_heli )
            {
                if ( isdefined( obj.aivolume ) )
                {
                    agent setgoalvolumeauto( obj.aivolume );
                }
                
                agent.objectivekey = objectivekey;
                
                if ( team_utility::isgameplayteam( team ) )
                {
                    level.objectivereinforcements[ objectivekey ][ team ].agents[ level.objectivereinforcements[ objectivekey ][ team ].agents.size ] = agent;
                }
            }
        }
        else
        {
            for ( i = 0; i < numagents ; i++ )
            {
                aitype = ai_mp_controller::function_b86341658788836c();
                var_1e688bcc03d1d575 = undefined;
                
                if ( cqbnodes.size > 0 )
                {
                    potentialnodes = ai_behavior::function_e539e9538e19483d( obj.trigger.origin, cqbnodes, 3, 256, 0 );
                    potentialnodes = arrayrandomize( potentialnodes );
                    
                    if ( potentialnodes.size > 0 )
                    {
                        var_1e688bcc03d1d575 = potentialnodes;
                    }
                }
                
                spawnorigin = obj.trigger.origin;
                
                if ( isdefined( var_1e688bcc03d1d575 ) )
                {
                    spawnorigin = var_1e688bcc03d1d575[ 0 ].origin;
                }
                
                agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, obj.trigger.origin, ( 0, 0, 0 ), "medium", "everybody", "captureAgents", groupname, team, undefined, undefined, 1 );
                
                if ( isdefined( agent ) )
                {
                    common::function_7c3197fc1ba5824( agent, "team_hundred_ninety_four" );
                    
                    if ( isdefined( var_1e688bcc03d1d575 ) )
                    {
                        ai_behavior::cqb_usenode( agent, var_1e688bcc03d1d575[ 0 ] );
                    }
                    else
                    {
                        agent thread ai_behavior::behavior_GuardWander( agent, 256, 256 );
                    }
                    
                    if ( isdefined( obj.aivolume ) )
                    {
                        agent setgoalvolumeauto( obj.aivolume );
                    }
                    
                    agent.objectivekey = objectivekey;
                    
                    if ( team_utility::isgameplayteam( team ) )
                    {
                        level.objectivereinforcements[ objectivekey ][ team ].agents[ level.objectivereinforcements[ objectivekey ][ team ].agents.size ] = agent;
                    }
                }
            }
        }
    }
    
    if ( !isdefined( var_b6933894644e835a ) )
    {
        var_b6933894644e835a = getdvarint( @"hash_ff335488d9d13e7c", 0 );
    }
    
    if ( var_b6933894644e835a > 0 )
    {
        for ( i = 0; i < var_b6933894644e835a ; i++ )
        {
            var_f6e7047445d8c4f2 = undefined;
            
            if ( cqbnodes.size > 0 )
            {
                potentialnodes = ai_behavior::function_e539e9538e19483d( obj.trigger.origin, cqbnodes, cqbnodes.size, 256, 0 );
                potentialnodes = arrayrandomize( potentialnodes );
                
                if ( potentialnodes.size > 0 )
                {
                    var_f6e7047445d8c4f2 = potentialnodes[ 0 ];
                }
            }
            
            spawnorigin = obj.trigger.origin;
            
            if ( isdefined( var_f6e7047445d8c4f2 ) )
            {
                spawnorigin = var_f6e7047445d8c4f2.origin;
            }
            
            agent = ai_mp_controller::ai_mp_requestspawnagent( "actor_enemy_mp_jugg_aq", spawnorigin, ( 0, 0, 0 ), "absolute", "everybody", "jugg", groupname, undefined, undefined, undefined, 1 );
            
            if ( isdefined( agent ) )
            {
                if ( isdefined( var_f6e7047445d8c4f2 ) )
                {
                    ai_behavior::cqb_usenode( agent, var_f6e7047445d8c4f2 );
                }
                else
                {
                    agent thread ai_behavior::behavior_GuardWander( agent, 256, 256 );
                }
                
                if ( isdefined( obj.aivolume ) )
                {
                    agent setgoalvolumeauto( obj.aivolume );
                }
            }
        }
    }
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 3
// Checksum 0xfc75ae4f, Offset: 0x19b1
// Size: 0xef
function function_260faced42e86285( desired_origin, var_6d02049e49f1e1a0, team )
{
    org_struct = spawnstruct();
    org_struct.origin = desired_origin;
    unload_locs = sortbydistance( level.helireinforcestruct.unload_locs, org_struct.origin );
    
    foreach ( node in unload_locs )
    {
        if ( utility::callsharedfunc( #"heli", #"hash_ae5ac6ed06687f8e", node ) )
        {
            return node;
        }
    }
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 1
// Checksum 0x471b1a46, Offset: 0x1aa8
// Size: 0x9d
function function_eb40fe818a5cfaff( params )
{
    agent = self;
    
    if ( !isdefined( agent.objectivekey ) || !team_utility::isgameplayteam( agent.team ) )
    {
        return;
    }
    
    level.objectivereinforcements[ agent.objectivekey ][ agent.team ].agents = arrayremove( level.objectivereinforcements[ agent.objectivekey ][ agent.team ].agents, agent );
}

// Namespace namespace_14ab7f658b8ad5e4
// Params 0
// Checksum 0x532dc9af, Offset: 0x1b4d
// Size: 0x350
function function_706d6c9afc1dbc18()
{
    ai_mp_controller::function_2b1cc53b284373( &function_eb40fe818a5cfaff );
    desiredcount = getdvarint( @"hash_32626c81a7c27e96", 5 );
    backfillthreshold = getdvarint( @"hash_9780788ca9cfa05b", 2 );
    var_89b69b6927ff1081 = getdvarint( @"hash_dce73a817d63d040", 30 ) * 1000;
    level.objectivereinforcements = [];
    
    foreach ( key, obj in level.objectives )
    {
        level.objectivereinforcements[ key ] = [];
        
        foreach ( team in level.teamnamelist )
        {
            data = spawnstruct();
            data.agents = [];
            data.var_1e69802e27a5eeed = 0;
            level.objectivereinforcements[ key ][ team ] = data;
        }
    }
    
    while ( true )
    {
        foreach ( key, obj in level.objectives )
        {
            wait 1;
            team = obj.ownerteam;
            
            if ( team == "neutral" )
            {
                continue;
            }
            
            currenttime = gettime();
            
            if ( currenttime < level.objectivereinforcements[ key ][ team ].var_1e69802e27a5eeed + var_89b69b6927ff1081 )
            {
                continue;
            }
            
            aliveagents = [];
            
            foreach ( agent in level.objectivereinforcements[ key ][ team ].agents )
            {
                if ( agent.health > 0 )
                {
                    aliveagents[ aliveagents.size ] = agent;
                }
            }
            
            level.objectivereinforcements[ key ][ team ].agents = aliveagents;
            currentcount = level.objectivereinforcements[ key ][ team ].agents.size;
            
            if ( currentcount <= backfillthreshold )
            {
                level thread function_cac6dbdf1966b849( key, team, desiredcount - currentcount, 0 );
                level.objectivereinforcements[ key ][ team ].var_1e69802e27a5eeed = currenttime;
            }
        }
    }
}

