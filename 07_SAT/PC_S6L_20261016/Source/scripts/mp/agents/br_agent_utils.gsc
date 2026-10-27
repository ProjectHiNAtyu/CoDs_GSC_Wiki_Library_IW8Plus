// scripts\mp\agents\br_agent_utils.gsc  (hash_252fa7d2b1b1b50b.gscc) (size: 4146 Bytes / 0x1032 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x462fa65 (73595493)
// size ...... 4146 (0x1032)
// includes .. 8   (offset: 0xf46)
// strings ... 8   (offset: 0xf86)
// dev strs .. 5   (offset: 0xff6)
// exports ... 9   (offset: 0x9ca)
// cseg ...... 0xc3 + 0x907 (0x9ca)
// imports ... 35  (offset: 0xb32)
// animtree1 . 0   (offset: 0x1032)
// animtree2 . 0   (offset: 0x1032)
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\poi;

#namespace br_agent_utils;

// Namespace br_agent_utils
// Params 0
// Checksum 0x3d5f4d2e, Offset: 0xe1
// Size: 0x9
function function_ba773d55f126a182()
{
    function_23bc222cf83218e2();
}

// Namespace br_agent_utils
// Params 3
// Checksum 0xed565e0a, Offset: 0xf2
// Size: 0x25
function function_fe2e21eec76f957d( circle_origin, circle_radius, threshold_radius )
{
    function_23bc222cf83218e2();
}

// Namespace br_agent_utils
// Params 0
// Checksum 0x8e670dff, Offset: 0x11f
// Size: 0x19a
function function_23bc222cf83218e2()
{
    foreach ( category in level.var_107eb2dda76e0ce3 )
    {
        agents = function_8e8b213809f3c0ef( category );
        
        foreach ( agent in agents )
        {
            if ( isint( agent ) )
            {
                agentdata = function_c62e58693ace9312( agent );
                
                if ( !br_circle_util::ispointindangercircle( agentdata.origin ) )
                {
                    agent_utils::function_585134f4744c6f80( agent, category );
                }
                
                continue;
            }
            
            if ( isdefined( agent.chute ) || isdefined( agent.ridingvehicle ) )
            {
                continue;
            }
            
            if ( isdefined( agent.birthtime ) && gettime() < agent.birthtime + 10000 )
            {
                continue;
            }
            
            if ( !br_circle_util::ispointindangercircle( agent.origin ) )
            {
                agent.killedbygas = 1;
                agent kill();
            }
        }
    }
}

// Namespace br_agent_utils
// Params 1
// Checksum 0xc5b123a2, Offset: 0x2c1
// Size: 0x54
function function_b9a0e8dab46ee1bb( category )
{
    if ( !isdefined( level.var_107eb2dda76e0ce3 ) )
    {
        level.var_107eb2dda76e0ce3 = [];
        br_circle::registercirclecallbacks( 11, &function_fe2e21eec76f957d, &function_ba773d55f126a182 );
    }
    
    level.var_107eb2dda76e0ce3 = arraycombineunique( level.var_107eb2dda76e0ce3, [ category ] );
}

// Namespace br_agent_utils
// Params 1
// Checksum 0x92434e60, Offset: 0x31d
// Size: 0x33
function function_1f82d51efd480948( category )
{
    if ( !isdefined( level.var_107eb2dda76e0ce3 ) )
    {
        return;
    }
    
    level.var_107eb2dda76e0ce3 = arrayremove( level.var_107eb2dda76e0ce3, category );
}

// Namespace br_agent_utils
// Params 4
// Checksum 0xdad29410, Offset: 0x358
// Size: 0x360
function spawn_reinforcements( location, requests, var_f6e2871019c2559e, params )
{
    assert( var_f6e2871019c2559e.size > 0, "<dev string:x24>" );
    assert( requests.size > 0, "<dev string:x80>" );
    ai_category = "everyone";
    ai_subcategory = undefined;
    ai_priority = "high";
    force_closest = 0;
    para_drop_height = 10000;
    
    if ( isdefined( params ) )
    {
        if ( isdefined( params.ai_category ) )
        {
            ai_category = params.ai_category;
        }
        
        if ( isdefined( params.ai_subcategory ) )
        {
            ai_subcategory = params.ai_subcategory;
        }
        
        if ( isdefined( params.ai_priority ) )
        {
            ai_priority = params.ai_priority;
        }
        
        if ( isdefined( params.force_closest ) )
        {
            force_closest = params.force_closest;
        }
        
        if ( isdefined( params.para_drop_height ) )
        {
            para_drop_height = params.para_drop_height;
        }
    }
    
    agents = [];
    closest_nav_point = getclosestpointonnavmesh( location );
    group_name = ai_mp_controller::function_391d43ea550a7a49();
    poi_name = poi::poi_findpoioriginisin( closest_nav_point );
    
    foreach ( type in var_f6e2871019c2559e )
    {
        if ( issubstr( type, "heli" ) && level.var_5261767313e4e145 )
        {
            var_193b1ec434529a82 = ai_reinforcements::function_7292254f1248df0( requests );
            heli_agents = [[ utility::getsharedfunc( #"heli", #"requestReinforcements" ) ]]( "heli", "requestReinforcements", requests.size, closest_nav_point, ai_priority, ai_category, ai_subcategory, group_name, "team_hundred_ninety_four", force_closest, poi_name, 256, 512, var_193b1ec434529a82, 1, 0 );
            
            if ( isdefined( heli_agents ) )
            {
                agents = heli_agents;
            }
        }
        else if ( issubstr( type, "para" ) && isdefined( level.parareinforcestruct ) )
        {
            var_193b1ec434529a82 = ai_reinforcements::function_7292254f1248df0( requests );
            para_agents = [[ utility::getsharedfunc( #"para", #"requestReinforcements" ) ]]( requests.size, closest_nav_point, para_drop_height, var_193b1ec434529a82, ai_priority, ai_category, ai_subcategory, "team_hundred_ninety_four", force_closest, poi_name, undefined, undefined, 1, 1, 1, 256 );
            
            if ( isdefined( para_agents ) )
            {
                agents = para_agents;
            }
        }
        else if ( issubstr( type, "closet" ) )
        {
            var_193b1ec434529a82 = ai_reinforcements::function_7292254f1248df0( requests );
            closet_agents = ai_reinforcements::closet_requestreinforcements( requests.size, closest_nav_point, ai_priority, ai_category, ai_subcategory, group_name, "team_hundred_ninety_four", force_closest, poi_name, undefined, undefined, 256 );
            
            if ( isdefined( closet_agents ) )
            {
                agents = closet_agents;
            }
        }
        else if ( issubstr( type, "safe" ) )
        {
            agents = agents_safe_spawn( closest_nav_point, requests, poi_name, group_name, params );
        }
        else
        {
            println( "<dev string:xd8>" + type );
        }
        
        if ( agents.size > 0 )
        {
            break;
        }
    }
    
    if ( agents.size <= 0 )
    {
        println( "<dev string:x10d>" );
    }
    
    return agents;
}

// Namespace br_agent_utils
// Params 5
// Checksum 0xbd5d0fc9, Offset: 0x6c1
// Size: 0x194
function agents_safe_spawn( location, requests, poi_name, group_name, params )
{
    safe_points = [];
    agents = [];
    safe_points = get_safe_spawn_points( location, requests.size, params.safe_spawn_distance, params.safe_spawn_radius, params.safe_spawn_squad_size );
    
    if ( safe_points.size < requests.size )
    {
        println( "<dev string:x144>" );
        return agents;
    }
    
    foreach ( index, request in requests )
    {
        ai_type = ai_mp_controller::function_f7aef6871cda828( request.type, request.tier, request.nationality );
        agent = ai_mp_controller::ai_mp_requestspawnagent( ai_type, safe_points[ index ], ( 0, 0, 0 ), params.ai_priority, params.ai_category, undefined, group_name, "team_hundred_ninety_four", undefined, poi_name, 1, 0, 0, undefined, 0 );
        
        if ( isdefined( agent ) )
        {
            agents[ agents.size ] = agent;
            agent thread ai_behavior::behavior_GuardWander( agent, 256, 256, location );
        }
        
        waitframe();
    }
    
    return agents;
}

// Namespace br_agent_utils
// Params 5
// Checksum 0x96377499, Offset: 0x85e
// Size: 0x16b
function get_safe_spawn_points( location, spawn_count, spawn_distance, spawn_radius, squad_size )
{
    safe_points = [];
    var_1238d3e75e3ea56 = squared( spawn_distance - spawn_radius );
    
    if ( !isdefined( spawn_distance ) )
    {
        spawn_distance = 1500;
    }
    
    if ( !isdefined( spawn_radius ) )
    {
        spawn_radius = 500;
    }
    
    for ( i = 0; i < 15 ; i++ )
    {
        searchpoint = location + vectornormalize( utility::function_9e0df7b136ab833c() ) * spawn_distance;
        spawnpoints = getrandomnavpoints( getclosestpointonnavmesh( searchpoint ), spawn_radius, squad_size );
        
        foreach ( point in spawnpoints )
        {
            if ( abs( point[ 2 ] - location[ 2 ] ) > 60 )
            {
                continue;
            }
            
            distsq = distance2dsquared( point, location );
            
            if ( distsq >= var_1238d3e75e3ea56 && ai_behavior::function_628be322cfae6d24( point, 64, 1000, 128 ) )
            {
                safe_points[ safe_points.size ] = point;
            }
            
            if ( safe_points.size >= spawn_count )
            {
                return safe_points;
            }
        }
        
        waitframe();
    }
    
    return safe_points;
}

