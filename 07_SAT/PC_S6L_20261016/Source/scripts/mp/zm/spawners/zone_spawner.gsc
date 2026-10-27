// scripts\mp\zm\spawners\zone_spawner.gsc  (hash_1edc39044588162b.gscc) (size: 22803 Bytes / 0x5913 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x25379760 (624400224)
// size ...... 22803 (0x5913)
// includes .. 15  (offset: 0x551b)
// strings ... 31  (offset: 0x5593)
// dev strs .. 37  (offset: 0x573b)
// exports ... 47  (offset: 0x3b87)
// cseg ...... 0x2ac + 0x38db (0x3b87)
// imports ... 146 (offset: 0x42df)
// animtree1 . 0   (offset: 0x5913)
// animtree2 . 0   (offset: 0x5913)
#using script_16ea1b94f0f381b3;
#using script_4bf223434bdc0646;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zone_spawner;

// Namespace zone_spawner
// Params 0
// Checksum 0x58764654, Offset: 0x2ca
// Size: 0x340
function init_zone_spawner()
{
    level endon( #"game_ended" );
    agent_spawner::register_spawner( "zone", &spawn_agent );
    level.throttle_zone_spawn_closet_check = throttle::throttle_initialize( "zone_spawn_closet_check", 1, 0.25 );
    
    if ( !isdefined( level.var_1d03be60f0a95b1c ) )
    {
        level.var_1d03be60f0a95b1c = [];
    }
    
    mapinfo = getactivemapinfobundle();
    level.spawner_subclass_map = function_4812746e22d1a576( mapinfo.var_4fb89debdad9bcb5 );
    
    /#
        level.var_6a0ca82b96021d66 = [];
    #/
    
    var_6613bc9326b6d7b9 = level.zone_spawn_locations ?? [];
    level.zone_spawn_locations = utility::getstructarray( "zone_agent_spawn", "targetname" );
    level.zone_spawn_locations = arraycombine( level.zone_spawn_locations, var_6613bc9326b6d7b9 );
    utility::flag_wait( "subclass_to_aitype_map_initialized" );
    
    if ( level.zone_spawn_locations.size > 0 )
    {
        foreach ( spawn_loc in level.zone_spawn_locations )
        {
            function_eeee6cc39266a2a3( spawn_loc );
        }
        
        foreach ( spawn_loc in level.zone_spawn_locations )
        {
            if ( isdefined( level.var_1d03be60f0a95b1c[ spawn_loc.zone_name ] ) )
            {
                spawn_loc.close_spawn_locs = utility::get_array_of_closest( spawn_loc.origin, level.var_1d03be60f0a95b1c[ spawn_loc.zone_name ], [ spawn_loc ], 5, 80 );
            }
        }
    }
    else
    {
        assertmsg( "<dev string:x24>" + "<dev string:x47>" + "<dev string:x58>" );
        level.zone_spawn_locations = [];
        
        foreach ( zone_name, zone in zone_manager::get_all_zones() )
        {
            spawn_loc = spawnstruct();
            spawn_loc.origin = utility::groundpos( zone.origin );
            spawn_loc.zone_name = zone_name;
            level.zone_spawn_locations[ level.zone_spawn_locations.size ] = spawn_loc;
            
            if ( !isdefined( level.var_1d03be60f0a95b1c[ zone_name ] ) )
            {
                level.var_1d03be60f0a95b1c[ zone_name ] = [];
            }
            
            level.var_1d03be60f0a95b1c[ zone_name ][ level.var_1d03be60f0a95b1c[ zone_name ].size ] = spawn_loc;
        }
    }
    
    function_b25f1f799772f078();
    
    /#
        setup_zone_spawner_devgui();
    #/
}

// Namespace zone_spawner
// Params 2
// Checksum 0x80ba2edb, Offset: 0x612
// Size: 0x94
function function_3d210dfed7f384df( ai_subclass, zone_name )
{
    if ( !isdefined( level.var_d33bf42f68828cf9 ) )
    {
        level.var_d33bf42f68828cf9 = [];
    }
    
    if ( !isdefined( level.var_d33bf42f68828cf9[ ai_subclass ] ) )
    {
        level.var_d33bf42f68828cf9[ ai_subclass ] = {};
    }
    
    if ( !isdefined( level.var_d33bf42f68828cf9[ ai_subclass ].zones ) )
    {
        level.var_d33bf42f68828cf9[ ai_subclass ].zones = [];
    }
    
    level.var_d33bf42f68828cf9[ ai_subclass ].zones[ zone_name ] = 1;
}

// Namespace zone_spawner
// Params 2
// Checksum 0x3d0b606e, Offset: 0x6ae
// Size: 0x61
function function_f990c5bb03b55b2f( ai_subclass, zone_name )
{
    if ( level.var_d33bf42f68828cf9[ ai_subclass ] && isdefined( zone_name ) && level.var_d33bf42f68828cf9[ ai_subclass ].zones[ zone_name ] )
    {
        level.var_d33bf42f68828cf9[ ai_subclass ].zones[ zone_name ] = 0;
    }
}

// Namespace zone_spawner
// Params 2
// Checksum 0x20b8a77b, Offset: 0x717
// Size: 0x1f
function function_ce10e453e7f7bb8e( spawn_loc, override_spawn_pos )
{
    agent_spawner::function_ce10e453e7f7bb8e( spawn_loc, override_spawn_pos );
}

// Namespace zone_spawner
// Params 3, eflags: 0x4
// Checksum 0x22b0cc70, Offset: 0x73e
// Size: 0x6c
function private function_aadc23c1a676facb( spawn_zone, spawn_loc, var_46f1327fcd04fb1e )
{
    level endon( #"game_ended" );
    utility::flag_wait( var_46f1327fcd04fb1e );
    
    if ( !isdefined( level.var_1d03be60f0a95b1c[ spawn_zone ] ) )
    {
        level.var_1d03be60f0a95b1c[ spawn_zone ] = [];
    }
    
    level.var_1d03be60f0a95b1c[ spawn_zone ][ level.var_1d03be60f0a95b1c[ spawn_zone ].size ] = spawn_loc;
}

// Namespace zone_spawner
// Params 1
// Checksum 0x6b1563b1, Offset: 0x7b2
// Size: 0x42
function function_dc63662f4c025b01( str_candidate )
{
    if ( isdefined( str_candidate ) )
    {
        switch ( str_candidate )
        {
            case #"hash_c2a6f846c2619c3e":
                return "zombie_base";
            case #"hash_8091294679bbc52d":
                return "zombie_base";
        }
    }
    
    return str_candidate;
}

// Namespace zone_spawner
// Params 2
// Checksum 0xf695d62f, Offset: 0x7fd
// Size: 0x39
function register_can_spawn_agent( str_subclass, var_784bed7efde124df )
{
    if ( !isdefined( level.var_784bed7efde124df ) )
    {
        level.var_784bed7efde124df = [];
    }
    
    level.var_784bed7efde124df[ str_subclass ] = var_784bed7efde124df;
}

// Namespace zone_spawner
// Params 1
// Checksum 0x65ac3d08, Offset: 0x83e
// Size: 0x60
function can_spawn_agent( var_9af53952daa1bce )
{
    if ( isdefined( level.var_784bed7efde124df[ var_9af53952daa1bce ] ) )
    {
        return [[ level.var_784bed7efde124df[ var_9af53952daa1bce ] ]]();
    }
    
    subclass = ai::function_29ab862ec4f51541( var_9af53952daa1bce );
    
    if ( isdefined( level.var_784bed7efde124df[ subclass ] ) )
    {
        return [[ level.var_784bed7efde124df[ subclass ] ]]();
    }
    
    return 1;
}

// Namespace zone_spawner
// Params 1
// Checksum 0xb8a9a0b1, Offset: 0x8a7
// Size: 0x2a
function function_835973438f299e55( str_subclass )
{
    if ( isdefined( level.var_a65dfdd0ad8655e2[ str_subclass ] ) )
    {
        return level.var_a65dfdd0ad8655e2[ str_subclass ];
    }
    
    return 0;
}

// Namespace zone_spawner
// Params 1, eflags: 0x4
// Checksum 0x531fb77e, Offset: 0x8da
// Size: 0x98
function private function_2a839257eeff3b70( agent )
{
    if ( !isdefined( level.var_a65dfdd0ad8655e2 ) )
    {
        level.var_a65dfdd0ad8655e2 = [];
    }
    
    if ( !isdefined( level.var_a65dfdd0ad8655e2[ agent.subclass ] ) )
    {
        if ( !isdefined( level.var_a65dfdd0ad8655e2[ agent.subclass ] ) )
        {
            level.var_a65dfdd0ad8655e2[ agent.subclass ] = 0;
        }
    }
    
    level.var_a65dfdd0ad8655e2[ agent.subclass ]++;
    agent callback::add( #"on_ai_killed", &function_937ee1f0cece290c );
}

// Namespace zone_spawner
// Params 0
// Checksum 0x66c20bc6, Offset: 0x97a
// Size: 0x115
function function_f9d3af30e993a949()
{
    self notify( #"hash_cb9b97535cf47681" );
    self endon( #"hash_cb9b97535cf47681" );
    self endon( #"death" );
    self.b_in_spawn_closet = 1;
    self function_786bb6aa1b76c7ee( "in_spawn_closet", 1 );
    callback::callback( "out_playable_space" );
    
    if ( utility::ent_flag( "spawn_animating" ) )
    {
        utility::ent_flag_waitopen_any( "spawn_animating" );
    }
    
    s_current_zone = zone_manager::get_current_zone();
    
    if ( isdefined( s_current_zone ) && s_current_zone.is_enabled )
    {
        self.b_in_spawn_closet = undefined;
        self function_f2df0257c63f229( "in_spawn_closet" );
        callback::callback( "in_playable_space" );
        return;
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.throttle_zone_spawn_closet_check, self );
        s_current_zone = zone_manager::get_current_zone();
        
        if ( isdefined( s_current_zone ) && s_current_zone.is_enabled )
        {
            while ( zombie_traverse::is_traversing() )
            {
                waitframe();
            }
            
            self.b_in_spawn_closet = undefined;
            self function_f2df0257c63f229( "in_spawn_closet" );
            callback::callback( "in_playable_space" );
            return;
        }
    }
}

// Namespace zone_spawner
// Params 1, eflags: 0x4
// Checksum 0xeabba24a, Offset: 0xa97
// Size: 0x35
function private function_937ee1f0cece290c( params )
{
    level.var_a65dfdd0ad8655e2[ self.subclass ]--;
    callback::remove( #"on_ai_killed", &function_937ee1f0cece290c );
}

// Namespace zone_spawner
// Params 2, eflags: 0x4
// Checksum 0x4f9a422c, Offset: 0xad4
// Size: 0x8d, Type: bool
function private function_d1f45dcd4b4d5333( ai_subclass, spawn_loc )
{
    if ( isvector( spawn_loc ) )
    {
        var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( spawn_loc );
        zone_name = var_8c4fe62d01999d1e.zone_name;
    }
    else
    {
        zone_name = spawn_loc.zone_name;
    }
    
    if ( level.var_d33bf42f68828cf9[ ai_subclass ] && isdefined( zone_name ) && level.var_d33bf42f68828cf9[ ai_subclass ].zones[ zone_name ] )
    {
        return true;
    }
    
    return false;
}

// Namespace zone_spawner
// Params 2
// Checksum 0x9bab5ff2, Offset: 0xb6a
// Size: 0x357
function spawn_agent( ai_type, params )
{
    original_ai_type = ai_type;
    var_89d9851001e180f6 = 0;
    
    if ( !can_spawn_agent( ai_type ) )
    {
        return;
    }
    
    var_d206d64b38d405b2 = undefined;
    
    if ( level.var_fea17bce20653bd0 || level.var_de533bedf48b22d9 && can_override_aitype( ai_type ) )
    {
        var_89d9851001e180f6 = 1;
        var_d206d64b38d405b2 = level.var_8b53ffbed4b0c3ef;
        ai_type = level.round_spawn_override_aitype;
    }
    
    if ( isdefined( params.zones ) )
    {
        var_d206d64b38d405b2 = params.zones;
    }
    
    subclass = ai::function_29ab862ec4f51541( ai_type ) ?? subclass;
    spawn_loc = select_spawn_loc( subclass, var_d206d64b38d405b2, params.var_56b78e42f7e7024e );
    
    if ( isdefined( level.var_4e7a53b0367f50de ) )
    {
        spawn_loc = [[ level.var_4e7a53b0367f50de ]]( subclass );
    }
    
    if ( !isdefined( spawn_loc ) )
    {
        return;
    }
    
    if ( function_d1f45dcd4b4d5333( subclass, spawn_loc ) )
    {
        return;
    }
    
    if ( isdefined( spawn_loc.subclass_to_aitype_map ) )
    {
        var_a181a029a419db5d = [ spawn_loc.subclass_to_aitype_map ];
        gametypebundle = getgametypescriptbundle();
        
        if ( gametypebundle.var_d72ac83fac014227 )
        {
            var_a181a029a419db5d[ var_a181a029a419db5d.size ] = gametypebundle.var_d72ac83fac014227;
        }
        
        ai_type = subclass_to_aitype_map::function_427ae77ce1056e01( subclass, var_a181a029a419db5d ) ?? function_b3988325430ce242( subclass );
    }
    
    spawn_pos = spawn_loc.origin;
    spawn_angles = spawn_loc.angles ?? ( 0, 0, 0 );
    
    if ( !isdefined( spawn_loc.script_animation ) )
    {
        spawn_pos = getgroundposition( spawn_loc.origin, 32 );
    }
    
    agent = agent_manager::spawn_agent( ai_type, spawn_pos, spawn_angles );
    
    if ( isdefined( agent ) )
    {
        /#
            spawn_loc.var_f75026dba575871d++;
            spawn_loc.var_2306e1230e900f37++;
            spawn_loc.var_73a0903c3136ec8e = 0;
            level thread function_636cd02e6bd196c( spawn_loc, 3000 );
        #/
        
        spawn_loc.var_70dffb4ad0a32c6 = gettime();
        
        if ( isdefined( spawn_loc.close_spawn_locs ) )
        {
            foreach ( close_spawn_loc in spawn_loc.close_spawn_locs )
            {
                close_spawn_loc.var_70dffb4ad0a32c6 = gettime();
            }
        }
        
        agent.spawn_loc = spawn_loc;
        
        if ( var_89d9851001e180f6 )
        {
            if ( !isdefined( agent.var_8f7b67390c7a40b2 ) )
            {
                agent.var_8f7b67390c7a40b2 = original_ai_type;
            }
            
            agent.override_ai_type = ai_type;
            level.var_7ca494dfc830114f--;
            
            if ( !isdefined( level.var_d5beb84142393428 ) )
            {
                level.var_d5beb84142393428 = [];
            }
            
            level.var_d5beb84142393428[ level.var_d5beb84142393428.size ] = agent;
        }
        
        function_2a839257eeff3b70( agent );
        agent setbtgoalstationary( 0 );
        agent thread agent_spawner::function_ce10e453e7f7bb8e( spawn_loc, spawn_pos );
        agent thread function_f9d3af30e993a949();
    }
    
    return agent;
}

// Namespace zone_spawner
// Params 1
// Checksum 0x252e191, Offset: 0xeca
// Size: 0x35, Type: bool
function can_override_aitype( aitype )
{
    return issubstr( aitype, "zombie_parasite" ) || issubstr( aitype, "zombie_vermin" ) || issubstr( aitype, "zombie_base" );
}

// Namespace zone_spawner
// Params 2, eflags: 0x4
// Checksum 0xbac3ba17, Offset: 0xf08
// Size: 0x4d, Type: bool
function private function_59fa1c533e8ae888( spawn_loc, subclass )
{
    if ( !isdefined( spawn_loc.ai_subclasses ) )
    {
        return false;
    }
    
    if ( function_d1f45dcd4b4d5333( subclass, spawn_loc ) )
    {
        return false;
    }
    
    if ( arraycontains( spawn_loc.ai_subclasses, subclass ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zone_spawner
// Params 2
// Checksum 0xeea733ad, Offset: 0xf5e
// Size: 0x14f
function function_20c574a6ba7cc5c6( zones, var_bc661ad67960c4e3 )
{
    subclass = ai::function_29ab862ec4f51541( var_bc661ad67960c4e3 ) ?? var_bc661ad67960c4e3;
    ai_spawn_locs = [];
    
    if ( !isarray( zones ) )
    {
        zones = [ zones ];
    }
    
    foreach ( zone in zones )
    {
        zone_spawn_locs = level.var_1d03be60f0a95b1c[ zone ];
        
        if ( isdefined( zone_spawn_locs ) )
        {
            foreach ( spawn_loc in zone_spawn_locs )
            {
                if ( !function_59fa1c533e8ae888( spawn_loc, subclass ) )
                {
                    continue;
                }
                
                ai_spawn_locs[ ai_spawn_locs.size ] = spawn_loc;
            }
        }
    }
    
    return ai_spawn_locs;
}

// Namespace zone_spawner
// Params 3
// Checksum 0x3bb51ea5, Offset: 0x10b6
// Size: 0x45b
function select_spawn_loc( subclass, var_d206d64b38d405b2, var_56b78e42f7e7024e = 0 )
{
    if ( !isdefined( subclass ) )
    {
        return;
    }
    
    zones = [];
    
    if ( var_d206d64b38d405b2.size > 0 )
    {
        zones = var_d206d64b38d405b2;
    }
    else
    {
        zones = select_zones( var_56b78e42f7e7024e );
    }
    
    if ( !isdefined( zones ) || zones.size <= 0 )
    {
        return;
    }
    
    recommended_aitype = function_b3988325430ce242( subclass );
    
    if ( !isdefined( recommended_aitype ) )
    {
        iprintlnbold( "Cannot spawn due to failure to find aitype for subclass: " + subclass );
        return;
    }
    
    var_6f4e5327b90b04a1 = [];
    active_spawn_locs = [];
    valid_spawn_locs = [];
    var_e0a64fe062650f1f = [];
    occupants = zones[ 0 ].occupants ?? [];
    
    foreach ( zone in zones )
    {
        zone_spawn_locs = level.var_1d03be60f0a95b1c[ zone.script_zone_name ];
        
        if ( isdefined( zone_spawn_locs ) )
        {
            foreach ( spawn_loc in zone_spawn_locs )
            {
                var_e0a64fe062650f1f[ var_e0a64fe062650f1f.size ] = spawn_loc;
                
                if ( !function_59fa1c533e8ae888( spawn_loc, subclass ) )
                {
                    continue;
                }
                
                valid_spawn_locs[ valid_spawn_locs.size ] = spawn_loc;
                
                if ( isdefined( spawn_loc.var_70dffb4ad0a32c6 ) && gettime() < spawn_loc.var_70dffb4ad0a32c6 + 3000 )
                {
                    continue;
                }
                
                active_spawn_locs[ active_spawn_locs.size ] = spawn_loc;
                is_nearby = 0;
                
                foreach ( occupant in occupants )
                {
                    if ( isalive( occupant ) && distance2dsquared( occupant.origin, spawn_loc.origin ) < squared( 2000 ) )
                    {
                        is_nearby = 1;
                        break;
                    }
                }
                
                if ( !is_nearby )
                {
                    continue;
                }
                
                var_6f4e5327b90b04a1[ var_6f4e5327b90b04a1.size ] = spawn_loc;
            }
        }
    }
    
    if ( var_6f4e5327b90b04a1.size > 0 )
    {
        return utility::array_random( var_6f4e5327b90b04a1 );
    }
    
    if ( active_spawn_locs.size > 0 )
    {
        return utility::array_random( active_spawn_locs );
    }
    
    if ( valid_spawn_locs.size > 0 )
    {
        println( "<dev string:x93>" );
        return function_2026c4ea95322276( valid_spawn_locs );
    }
    
    var_20412c25a010ce09 = function_8264c19be2cc2395( subclass );
    
    if ( var_20412c25a010ce09.size > 0 )
    {
        /#
            iprintlnbold( "<dev string:xf6>" );
        #/
        
        return utility::array_random( var_20412c25a010ce09 );
    }
    
    /#
        iprintlnbold( "<dev string:x173>" + subclass + "<dev string:x19d>" );
    #/
    
    assert( "<dev string:x173>" + subclass + "<dev string:x19d>" );
    logstring( "[WARNING] No spawner match the subclass: " + subclass + " in all enabled zones!" );
    
    foreach ( zone_name, zone in level.zone_manager.inited_defs )
    {
        logstring( "Zone (" + zone_name + ") is " + ( zone.is_active ? "" : "not " ) + "active. Zone is " + ( zone.is_enabled ? "" : "not " ) + "enabled" );
    }
    
    level.var_93e06b805cf2692c = gettime();
    return;
}

// Namespace zone_spawner
// Params 1, eflags: 0x4
// Checksum 0x5f41ac61, Offset: 0x1519
// Size: 0xbd
function private function_2026c4ea95322276( var_395649a1ecde9e39 )
{
    closest_spawn_loc = undefined;
    var_c2dd3c670b06d734 = undefined;
    
    foreach ( spawn_loc in var_395649a1ecde9e39 )
    {
        if ( !( isdefined( closest_spawn_loc ) && isdefined( var_c2dd3c670b06d734 ) ) || spawn_loc.var_70dffb4ad0a32c6 < var_c2dd3c670b06d734 )
        {
            closest_spawn_loc = spawn_loc;
            var_c2dd3c670b06d734 = spawn_loc.var_70dffb4ad0a32c6;
        }
    }
    
    return closest_spawn_loc;
}

// Namespace zone_spawner
// Params 1, eflags: 0x4
// Checksum 0x4101974e, Offset: 0x15df
// Size: 0x179
function private function_8264c19be2cc2395( subclass )
{
    var_55ef29012ec9b63e = [];
    
    if ( isdefined( level.zone_spawn_locations ) )
    {
        var_ab052a4c634b6d97 = [];
        var_b6301b8792618319 = [];
        
        foreach ( spawn_location in level.zone_spawn_locations )
        {
            if ( isarray( level.var_13643baf50c26c92 ) )
            {
                if ( arraycontains( level.var_13643baf50c26c92, spawn_location.zone_name ?? "" ) )
                {
                    continue;
                }
            }
            
            if ( function_59fa1c533e8ae888( spawn_location, subclass ) && isdefined( spawn_location.zone_name ) )
            {
                zone_struct = zone_manager::get_zone_struct( spawn_location.zone_name );
                
                if ( isdefined( zone_struct ) && zone_struct.is_enabled )
                {
                    if ( isdefined( spawn_location.var_70dffb4ad0a32c6 ) && gettime() < spawn_location.var_70dffb4ad0a32c6 + 3000 )
                    {
                        var_ab052a4c634b6d97[ var_ab052a4c634b6d97.size ] = spawn_location;
                        continue;
                    }
                    
                    var_b6301b8792618319[ var_b6301b8792618319.size ] = spawn_location;
                }
            }
        }
        
        if ( var_b6301b8792618319.size > 0 )
        {
            var_55ef29012ec9b63e = var_b6301b8792618319;
        }
        else
        {
            var_55ef29012ec9b63e = var_ab052a4c634b6d97;
        }
    }
    
    return var_55ef29012ec9b63e;
}

// Namespace zone_spawner
// Params 2, eflags: 0x4
// Checksum 0x58d200f4, Offset: 0x1761
// Size: 0x5f
function private function_636cd02e6bd196c( spawn_loc, wait_time )
{
    level endon( #"game_ended" );
    utility::wait_time_in_ms( wait_time );
    
    if ( isdefined( spawn_loc.var_70dffb4ad0a32c6 ) && spawn_loc.var_70dffb4ad0a32c6 + 3000 <= gettime() )
    {
        spawn_loc.var_73a0903c3136ec8e = 1;
    }
}

// Namespace zone_spawner
// Params 1
// Checksum 0x6bef296c, Offset: 0x17c8
// Size: 0x3f
function function_2ce7db1d59b307d8( str_zonename )
{
    if ( !isdefined( level.var_13643baf50c26c92 ) )
    {
        level.var_13643baf50c26c92 = [];
    }
    
    level.var_13643baf50c26c92 = arraycombineunique( level.var_13643baf50c26c92, [ str_zonename ] );
}

// Namespace zone_spawner
// Params 1
// Checksum 0xf305c826, Offset: 0x180f
// Size: 0x4c
function function_8a020f24a3b73c79( str_zonename )
{
    if ( !isdefined( level.var_13643baf50c26c92 ) )
    {
        level.var_13643baf50c26c92 = [];
    }
    
    if ( arraycontains( level.var_13643baf50c26c92, str_zonename ) )
    {
        level.var_13643baf50c26c92 = arrayremove( level.var_13643baf50c26c92, str_zonename );
    }
}

// Namespace zone_spawner
// Params 1, eflags: 0x4
// Checksum 0xcd9b9a33, Offset: 0x1863
// Size: 0x799
function private select_zones( var_56b78e42f7e7024e = 0 )
{
    all_player_info = [];
    
    foreach ( player in level.players )
    {
        if ( !zm_utility::is_player_valid_target( player ) )
        {
            continue;
        }
        
        if ( player val::get( "round_spawning_ignore_player" ) )
        {
            continue;
        }
        
        current_zone = player zone_manager::get_current_zone();
        
        if ( isdefined( current_zone ) )
        {
            info = spawnstruct();
            info.player = player;
            info.num_zombies = 0;
            info.zone = current_zone;
            info.nearby_players = [];
            
            foreach ( other_info in all_player_info )
            {
                is_nearby = 0;
                
                if ( info.zone == other_info.zone )
                {
                    is_nearby = 1;
                }
                else
                {
                    var_c96b1c3cfbbd6aac = info.zone zone_manager::get_adjacent_zones();
                    
                    if ( arraycontains( var_c96b1c3cfbbd6aac, other_info.zone ) )
                    {
                        is_nearby = 1;
                    }
                }
                
                if ( is_nearby )
                {
                    info.nearby_players[ info.nearby_players.size ] = other_info.player;
                }
            }
            
            all_player_info[ player getentitynumber() ] = info;
        }
    }
    
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie.ignore_enemy_count && !zombie.var_73754e976e7672a6 )
        {
            continue;
        }
        
        if ( isplayer( zombie.enemy ) )
        {
            enemy_ent_number = zombie.enemy getentitynumber();
            
            if ( isdefined( all_player_info[ enemy_ent_number ] ) )
            {
                all_player_info[ enemy_ent_number ].num_zombies = ( all_player_info[ enemy_ent_number ].num_zombies ?? 0 ) + 1;
                
                foreach ( nearby_player in all_player_info[ enemy_ent_number ].nearby_players ?? [] )
                {
                    if ( isalive( nearby_player ) && isdefined( all_player_info[ nearby_player getentitynumber() ] ) )
                    {
                        all_player_info[ nearby_player getentitynumber() ].num_zombies = ( all_player_info[ nearby_player getentitynumber() ].num_zombies ?? 0 ) + 1;
                    }
                }
            }
        }
        
        zombie_zone = zombie zone_manager::get_current_zone();
        
        if ( !isdefined( zombie_zone ) && isdefined( zombie.spawn_loc.zone_name ) )
        {
            zombie_zone = zone_manager::get_zone_struct( zombie.spawn_loc.zone_name );
        }
        
        if ( !isdefined( zombie_zone ) )
        {
            continue;
        }
        
        foreach ( info in all_player_info )
        {
            if ( info.zone == zombie_zone )
            {
                info.num_zombies = ( info.num_zombies ?? 0 ) + 1;
            }
        }
    }
    
    /#
        function_2c394c8f97340a46( all_player_info );
    #/
    
    var_732b88e0978b28d6 = level.var_a009ab14ee0d3223.var_63a0ca44b877a390;
    
    if ( all_player_info.size > 0 )
    {
        var_732b88e0978b28d6 = int( level.var_a009ab14ee0d3223.var_63a0ca44b877a390 / all_player_info.size );
    }
    
    selected_player_info = undefined;
    var_7941e857dec3fdef = undefined;
    var_232b356cc3aacf0a = undefined;
    var_7c9aa5c088023bee = undefined;
    
    foreach ( info in all_player_info )
    {
        if ( isdefined( level.var_13643baf50c26c92 ) && arraycontains( level.var_13643baf50c26c92, info.zone.zone_name ) )
        {
            continue;
        }
        
        if ( !isdefined( var_7941e857dec3fdef ) || info.num_zombies < var_7941e857dec3fdef.num_zombies )
        {
            var_7941e857dec3fdef = info;
        }
        
        scaled_budget = var_732b88e0978b28d6 * ( info.nearby_players.size + 1 );
        percentage = min( info.num_zombies / scaled_budget, 1 );
        
        if ( !isdefined( var_232b356cc3aacf0a ) || percentage < var_7c9aa5c088023bee )
        {
            var_232b356cc3aacf0a = info;
            var_7c9aa5c088023bee = percentage;
        }
    }
    
    if ( var_7c9aa5c088023bee < 1 )
    {
        selected_player_info = var_232b356cc3aacf0a;
    }
    else
    {
        selected_player_info = var_7941e857dec3fdef;
    }
    
    selected_zones = [];
    
    if ( isdefined( selected_player_info.zone ) )
    {
        selected_zones[ selected_zones.size ] = selected_player_info.zone;
        var_c96b1c3cfbbd6aac = selected_player_info.zone zone_manager::get_adjacent_zones( 1, 1 );
        selected_zones = arraycombine( selected_zones, var_c96b1c3cfbbd6aac );
    }
    
    if ( isdefined( level.var_13643baf50c26c92 ) )
    {
        foreach ( info in selected_zones )
        {
            if ( arraycontains( level.var_13643baf50c26c92, info.zone_name ) )
            {
                selected_zones = arrayremove( selected_zones, info );
            }
        }
    }
    
    if ( var_56b78e42f7e7024e )
    {
        foreach ( info in selected_zones )
        {
            if ( info.round_spawn_disabled )
            {
                selected_zones = arrayremove( selected_zones, info );
            }
        }
    }
    
    return selected_zones;
}

// Namespace zone_spawner
// Params 3
// Checksum 0x5bddc663, Offset: 0x2005
// Size: 0x8f
function function_c5801414561a5dab( aitype, player, var_56b78e42f7e7024e = 0 )
{
    if ( isplayer( player ) )
    {
        zone = player zone_manager::get_current_zone();
    }
    
    if ( zone && aitype )
    {
        params = {};
        params.zones = [ zone ];
        params.var_56b78e42f7e7024e = var_56b78e42f7e7024e;
        zombie = spawn_agent( aitype, params );
    }
    
    return zombie;
}

// Namespace zone_spawner
// Params 0
// Checksum 0x257a7659, Offset: 0x209d
// Size: 0xd3
function function_e82a1e5bf446aaa1()
{
    if ( level.players.size <= 0 )
    {
        return;
    }
    
    var_668caf7e6207fdd = level.players;
    least_targeted = var_668caf7e6207fdd[ 0 ];
    
    for ( i = 0; i < var_668caf7e6207fdd.size ; i++ )
    {
        if ( !isdefined( var_668caf7e6207fdd[ i ].var_213e760185d5be4f ) )
        {
            var_668caf7e6207fdd[ i ].var_213e760185d5be4f = 0;
            var_668caf7e6207fdd[ i ].var_dbf82c09d57f9abe = 0;
        }
        
        if ( !isplayer( var_668caf7e6207fdd[ i ] ) )
        {
            continue;
        }
        
        if ( !isplayer( least_targeted ) )
        {
            least_targeted = var_668caf7e6207fdd[ i ];
        }
        
        if ( var_668caf7e6207fdd[ i ].var_213e760185d5be4f < least_targeted.var_213e760185d5be4f )
        {
            least_targeted = var_668caf7e6207fdd[ i ];
        }
    }
    
    if ( !isplayer( least_targeted ) )
    {
        return;
    }
    
    return least_targeted;
}

// Namespace zone_spawner
// Params 3
// Checksum 0x65754cda, Offset: 0x2178
// Size: 0x632
function spawn_single_dog( var_bc661ad67960c4e3, var_8bf096b6feb85dea, var_145236a34ee38b2b )
{
    var_5ddea964f429e3cf = function_e82a1e5bf446aaa1();
    
    if ( !isplayer( var_5ddea964f429e3cf ) )
    {
        println( "<dev string:x1b4>" );
        return;
    }
    
    if ( isdefined( var_8bf096b6feb85dea ) )
    {
        s_spawn_loc = var_8bf096b6feb85dea;
    }
    else if ( isdefined( level.var_c7c073a61229d7db ) )
    {
        s_spawn_loc = [[ level.var_c7c073a61229d7db ]]();
    }
    else
    {
        if ( var_145236a34ee38b2b )
        {
            var_86c90eb65ef6b59c = var_145236a34ee38b2b;
        }
        else
        {
            var_b2cbaa7705b23b5a = var_5ddea964f429e3cf zone_manager::get_current_zone();
            
            if ( !isdefined( var_b2cbaa7705b23b5a ) )
            {
                println( "<dev string:x1b4>" );
                return;
            }
            
            var_86c90eb65ef6b59c = [];
            var_86c90eb65ef6b59c = arraycombineunique( var_86c90eb65ef6b59c, [ var_b2cbaa7705b23b5a.zone_name ] );
            adj_zones = var_b2cbaa7705b23b5a zone_manager::get_adjacent_zones( 1, 1 );
            
            foreach ( s_adj_zone in adj_zones )
            {
                var_86c90eb65ef6b59c = arraycombineunique( var_86c90eb65ef6b59c, [ s_adj_zone.zone_name ] );
            }
            
            foreach ( s_adj_zone in adj_zones )
            {
                var_422ede9e829fc501 = s_adj_zone zone_manager::get_adjacent_zones( 1, 1 );
                
                foreach ( var_b1aedbc1b418f9c2 in var_422ede9e829fc501 )
                {
                    var_86c90eb65ef6b59c = arraycombineunique( var_86c90eb65ef6b59c, [ var_b1aedbc1b418f9c2.zone_name ] );
                }
            }
        }
        
        var_c0ddfd68e6c6ff9a = [];
        ai_subclass_spawn_locs = function_20c574a6ba7cc5c6( var_86c90eb65ef6b59c, var_bc661ad67960c4e3 );
        
        if ( !isdefined( ai_subclass_spawn_locs ) || ai_subclass_spawn_locs.size <= 0 )
        {
            println( "<dev string:x1b4>" );
            return;
        }
        
        foreach ( spawn_loc in ai_subclass_spawn_locs )
        {
            var_c0ddfd68e6c6ff9a = arraycombineunique( var_c0ddfd68e6c6ff9a, [ spawn_loc ] );
        }
        
        var_c0ddfd68e6c6ff9a = utility::get_array_of_closest( var_5ddea964f429e3cf.origin, var_c0ddfd68e6c6ff9a, undefined, undefined, 1024 );
        var_17d78599b65d1026 = [];
        var_25f15e7a9a869306 = [];
        
        foreach ( v_loc in var_c0ddfd68e6c6ff9a )
        {
            var_92cdc48e26174d22 = distancesquared( v_loc.origin, var_5ddea964f429e3cf.origin );
            
            if ( 173056 < var_92cdc48e26174d22 && var_92cdc48e26174d22 < 376996 )
            {
                var_17d78599b65d1026[ var_17d78599b65d1026.size ] = v_loc;
                continue;
            }
            
            if ( var_92cdc48e26174d22 > 376996 )
            {
                var_25f15e7a9a869306[ var_25f15e7a9a869306.size ] = v_loc;
            }
        }
        
        if ( var_17d78599b65d1026.size < 6 )
        {
            var_25f15e7a9a869306 = sortbydistance( var_25f15e7a9a869306, var_5ddea964f429e3cf.origin, 1 );
            var_b43ce2ec5ab270e7 = 6 - var_17d78599b65d1026.size;
            
            for ( i = 0; i < var_b43ce2ec5ab270e7 ; i++ )
            {
                if ( i < var_25f15e7a9a869306.size )
                {
                    var_17d78599b65d1026[ var_17d78599b65d1026.size ] = var_25f15e7a9a869306[ i ];
                }
            }
        }
        
        if ( var_17d78599b65d1026.size > 0 )
        {
            random_index = randomint( var_17d78599b65d1026.size );
            s_spawn_loc = var_17d78599b65d1026[ random_index ];
        }
    }
    
    if ( isdefined( s_spawn_loc.origin ) && isdefined( var_bc661ad67960c4e3 ) && can_spawn_agent( var_bc661ad67960c4e3 ) && !function_d1f45dcd4b4d5333( var_bc661ad67960c4e3, s_spawn_loc ) )
    {
        zombie = agent_manager::spawn_agent( var_bc661ad67960c4e3, s_spawn_loc.origin, s_spawn_loc.angles );
    }
    
    if ( zombie )
    {
        s_spawn_loc.var_a2424f78b9c416ef = gettime();
        zombie thread agent_spawner::function_ce10e453e7f7bb8e( s_spawn_loc );
        zombie.favoriteenemy = var_5ddea964f429e3cf;
        zombie.favoriteenemy.var_dbf82c09d57f9abe++;
        zombie.favoriteenemy.var_213e760185d5be4f++;
        
        /#
            s_spawn_loc.var_f75026dba575871d++;
            s_spawn_loc.var_2306e1230e900f37++;
            s_spawn_loc.var_73a0903c3136ec8e = 0;
            level thread function_636cd02e6bd196c( spawn_loc, 3000 );
        #/
        
        s_spawn_loc.var_70dffb4ad0a32c6 = gettime();
        
        if ( isdefined( s_spawn_loc.close_spawn_locs ) )
        {
            foreach ( close_spawn_loc in s_spawn_loc.close_spawn_locs )
            {
                close_spawn_loc.var_70dffb4ad0a32c6 = gettime();
            }
        }
        
        zombie.spawn_loc = s_spawn_loc;
        function_2a839257eeff3b70( zombie );
        zombie setbtgoalstationary( 0 );
        zombie thread function_f9d3af30e993a949();
    }
    
    /#
        if ( !isdefined( zombie ) )
        {
            println( "<dev string:x1b4>" );
        }
    #/
    
    return zombie;
}

// Namespace zone_spawner
// Params 0, eflags: 0x4
// Checksum 0x56fbf890, Offset: 0x27b3
// Size: 0x17
function private function_b25f1f799772f078()
{
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"zone_spawn", &cheat_zone_spawn );
}

// Namespace zone_spawner
// Params 1, eflags: 0x4
// Checksum 0x3c5dbf95, Offset: 0x27d2
// Size: 0x91
function private cheat_zone_spawn( params )
{
    var_329596c2aabf99a = params[ 0 ];
    
    if ( isdefined( var_329596c2aabf99a ) )
    {
        if ( var_329596c2aabf99a == "special" || var_329596c2aabf99a == "elite" )
        {
            var_a677c6c89d4a4ba1 = namespace_c7157c2cd884c5d5::function_e05919b47b9a0cda( var_329596c2aabf99a );
            
            if ( isdefined( var_a677c6c89d4a4ba1 ) )
            {
                var_329596c2aabf99a = utility::array_random( var_a677c6c89d4a4ba1 );
            }
        }
        
        aitype = function_b3988325430ce242( var_329596c2aabf99a );
        
        if ( !isdefined( aitype ) )
        {
            /#
                iprintln( "<dev string:x1dc>" + var_329596c2aabf99a + "<dev string:x212>" );
            #/
            
            return;
        }
        
        spawn_agent( aitype );
    }
}

// Namespace zone_spawner
// Params 1, eflags: 0x4
// Checksum 0x2dc4589f, Offset: 0x286b
// Size: 0x31e
function private function_4812746e22d1a576( map_asset )
{
    if ( isstring( map_asset ) )
    {
        if ( !issubstr( map_asset, "zmspawnermapping:" ) )
        {
            map_asset = "zmspawnermapping:" + map_asset;
        }
        
        map_asset = getxhashasset( map_asset );
    }
    
    scriptbundle = getscriptbundle( map_asset );
    map = [];
    
    foreach ( entry in scriptbundle.var_9ce8b61792329900 )
    {
        kvp = entry.spawnerkvp.kvp;
        map[ kvp ] = [];
        
        foreach ( subclass_struct in entry.subclass_list )
        {
            map[ kvp ][ map[ kvp ].size ] = getscriptbundlefieldvalue( subclass_struct.subclass, "name" );
        }
        
        if ( entry.var_9dd3c88d94233ec5 )
        {
            subclass_names = getscriptbundlenames( "ai_subclass" );
            
            foreach ( str_bundle in subclass_names )
            {
                name = getscriptbundlefieldvalue( str_bundle, "name" );
                map[ kvp ][ map[ kvp ].size ] = name;
            }
        }
    }
    
    var_fa0c38a635ad7f7e = getdvar( @"hash_834c9031cf7b5e81", "" );
    
    if ( var_fa0c38a635ad7f7e.size > 0 )
    {
        var_9ce8b61792329900 = strtok( var_fa0c38a635ad7f7e, "|" );
        
        foreach ( var_70a0a51f07bfc85c in var_9ce8b61792329900 )
        {
            spawner_mapping = strtok( var_70a0a51f07bfc85c, "," );
            
            if ( spawner_mapping.size > 1 )
            {
                var_f938eea2eb207203 = 1;
                
                while ( var_f938eea2eb207203 < spawner_mapping.size )
                {
                    if ( !isdefined( map[ spawner_mapping[ 0 ] ] ) )
                    {
                        map[ spawner_mapping[ 0 ] ] = [];
                    }
                    
                    map[ spawner_mapping[ 0 ] ][ map[ spawner_mapping[ 0 ] ].size ] = spawner_mapping[ var_f938eea2eb207203 ];
                    var_f938eea2eb207203 += 1;
                }
            }
        }
    }
    
    return map;
}

/#

    // Namespace zone_spawner
    // Params 0, eflags: 0x4
    // Checksum 0xacf91797, Offset: 0x2b92
    // Size: 0x164, Type: dev
    function private setup_zone_spawner_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x245>" + "<dev string:x251>" + "<dev string:x256>" );
        devgui::add_devgui_func( "<dev string:x258>", "<dev string:x274>", &draw_spawn_locations, 1 );
        devgui::add_devgui_func( "<dev string:x296>", "<dev string:x2b1>", &function_86e1a0681240ecf4 );
        devgui::add_devgui_func( "<dev string:x2c9>", "<dev string:x2e5>", &function_8a86ec026b3d6473 );
        devgui::add_devgui_func( "<dev string:x2fe>", "<dev string:x31d>", &function_ca314c9426eae6b0 );
        devgui::add_devgui_func( "<dev string:x339>", "<dev string:x359>", &function_3940e3221e8dbf03 );
        
        foreach ( ai_subclass in getarraykeys( level.var_6a0ca82b96021d66 ) )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x37d>" + ai_subclass + "<dev string:x392>", "<dev string:x396>" + ai_subclass, &function_a4313d963766760e );
            devgui::function_cd4e263c1f3018ae( "<dev string:x37d>" + ai_subclass + "<dev string:x3b4>", "<dev string:x3b9>" + ai_subclass, &function_382d50f15764acad );
        }
        
        devgui::add_devgui_func( "<dev string:x3d8>", "<dev string:x3f7>", &function_8b71e74a000d195e, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zone_spawner
    // Params 0, eflags: 0x4
    // Checksum 0x570b6206, Offset: 0x2cfe
    // Size: 0x41d, Type: dev
    function private draw_spawn_locations()
    {
        if ( !isdefined( level.var_a60e02238c772e13 ) )
        {
            function_86e1a0681240ecf4();
        }
        
        while ( true )
        {
            zones = [];
            
            foreach ( zone in select_zones() )
            {
                zones[ zones.size ] = zone.script_zone_name;
            }
            
            enabled_spawn_locs = [];
            disabled_spawn_locs = [];
            draw_origin = undefined;
            
            if ( true )
            {
                foreach ( player in level.players )
                {
                    if ( isalive( player ) )
                    {
                        draw_origin = player.origin;
                        break;
                    }
                }
            }
            
            foreach ( zone_name, spawn_loc_array in level.var_1d03be60f0a95b1c )
            {
                enabled = arraycontains( zones, zone_name );
                
                foreach ( spawn_loc in spawn_loc_array )
                {
                    if ( draw_origin && distancesquared( draw_origin, spawn_loc.origin ) > 9000000 )
                    {
                        continue;
                    }
                    
                    if ( isdefined( spawn_loc.script_label ) && !utility::flag( spawn_loc.script_label ) )
                    {
                        continue;
                    }
                    
                    if ( isdefined( spawn_loc.ai_subclasses ) && isdefined( level.var_a60e02238c772e13 ) && !should_draw_spawner( spawn_loc.ai_subclasses ) )
                    {
                        continue;
                    }
                    
                    spawn_loc_color = ( 1, 0, 0 );
                    
                    if ( enabled )
                    {
                        spawn_loc_color = ( 0, 1, 0 );
                        
                        if ( isdefined( spawn_loc.var_73a0903c3136ec8e ) && !spawn_loc.var_73a0903c3136ec8e )
                        {
                            spawn_loc_color = ( 1, 1, 0 );
                        }
                        
                        enabled_spawn_locs[ enabled_spawn_locs.size ] = spawn_loc;
                    }
                    else
                    {
                        disabled_spawn_locs[ disabled_spawn_locs.size ] = spawn_loc;
                    }
                    
                    spawn_loc.var_f23db216e8be964 = spawn_loc_color;
                }
            }
            
            foreach ( spawn_loc in enabled_spawn_locs )
            {
                draw_spawn_loc( spawn_loc, spawn_loc.var_f23db216e8be964 );
            }
            
            foreach ( spawn_loc in disabled_spawn_locs )
            {
                draw_spawn_loc( spawn_loc, spawn_loc.var_f23db216e8be964 );
            }
            
            waitframe();
        }
    }

    // Namespace zone_spawner
    // Params 2, eflags: 0x4
    // Checksum 0xfc490aef, Offset: 0x3123
    // Size: 0x163, Type: dev
    function private draw_spawn_loc( spawn_loc, spawn_loc_color )
    {
        sphere( spawn_loc.origin, 8, spawn_loc_color, 0, 1 );
        text_origin = spawn_loc.origin + ( 20, 0, 0 );
        print3d( text_origin, spawn_loc.zone_name, spawn_loc_color, 1, 1.5, 1 );
        text_origin -= ( 0, 0, 5 );
        
        if ( isdefined( spawn_loc.ai_subclasses ) )
        {
            for ( i = 0; i < spawn_loc.ai_subclasses.size ; i++ )
            {
                print3d( text_origin - i * ( 0, 0, 5 ), spawn_loc.ai_subclasses[ i ], spawn_loc_color, 1, 0.5, 1 );
            }
        }
        else
        {
            print3d( text_origin, "<dev string:x416>", spawn_loc_color, 1, 0.5, 1 );
        }
        
        cooldown_s = 0;
        
        if ( isdefined( spawn_loc.var_70dffb4ad0a32c6 ) )
        {
            cooldown_s = spawn_loc.var_70dffb4ad0a32c6 + 3000 - gettime();
            cooldown_s = max( cooldown_s, 0 );
        }
        
        if ( cooldown_s > 0 )
        {
            print3d( spawn_loc.origin, cooldown_s, ( 1, 0, 0 ), 1, 1, 1 );
        }
    }

    // Namespace zone_spawner
    // Params 0, eflags: 0x4
    // Checksum 0x37a7d522, Offset: 0x328e
    // Size: 0x1b, Type: dev
    function private function_86e1a0681240ecf4()
    {
        level.var_a60e02238c772e13 = getarraykeys( level.var_6a0ca82b96021d66 );
    }

    // Namespace zone_spawner
    // Params 0, eflags: 0x4
    // Checksum 0x7651925d, Offset: 0x32b1
    // Size: 0xf, Type: dev
    function private function_8a86ec026b3d6473()
    {
        level.var_a60e02238c772e13 = [];
    }

    // Namespace zone_spawner
    // Params 1, eflags: 0x4
    // Checksum 0x9b613c00, Offset: 0x32c8
    // Size: 0x57, Type: dev
    function private function_a4313d963766760e( params )
    {
        if ( !isdefined( level.var_a60e02238c772e13 ) )
        {
            function_86e1a0681240ecf4();
        }
        
        if ( isdefined( params[ 0 ] ) )
        {
            if ( !arraycontains( level.var_a60e02238c772e13, params[ 0 ] ) )
            {
                level.var_a60e02238c772e13[ level.var_a60e02238c772e13.size ] = params[ 0 ];
            }
        }
    }

    // Namespace zone_spawner
    // Params 1, eflags: 0x4
    // Checksum 0xa9cdb177, Offset: 0x3327
    // Size: 0x44, Type: dev
    function private function_382d50f15764acad( params )
    {
        if ( !isdefined( level.var_a60e02238c772e13 ) )
        {
            function_86e1a0681240ecf4();
        }
        
        if ( isdefined( params[ 0 ] ) )
        {
            level.var_a60e02238c772e13 = arrayremove( level.var_a60e02238c772e13, params[ 0 ] );
        }
    }

    // Namespace zone_spawner
    // Params 1, eflags: 0x4
    // Checksum 0x428a24d3, Offset: 0x3373
    // Size: 0x9f, Type: dev
    function private should_draw_spawner( ai_subclasses )
    {
        if ( !isdefined( level.var_a60e02238c772e13 ) )
        {
            return 0;
        }
        
        foreach ( ai_subclass in ai_subclasses )
        {
            if ( arraycontains( level.var_a60e02238c772e13, ai_subclass ) )
            {
                return 1;
            }
        }
        
        return 0;
    }

    // Namespace zone_spawner
    // Params 0, eflags: 0x4
    // Checksum 0xcbcb641c, Offset: 0x341a
    // Size: 0x12d, Type: dev
    function private function_8b71e74a000d195e()
    {
        var_78d6606d597fb76e = 0;
        
        foreach ( ai_subclass in getarraykeys( level.var_6a0ca82b96021d66 ) )
        {
            var_78d6606d597fb76e = int( max( var_78d6606d597fb76e, ai_subclass.size ) );
        }
        
        while ( true )
        {
            level debug::function_298a6c4895b8935d( ( 400, 300, 0 ) );
            
            foreach ( ai_subclass in getarraykeys( level.var_6a0ca82b96021d66 ) )
            {
                draw_spawner_state_text( ai_subclass, var_78d6606d597fb76e );
            }
            
            level debug::function_9de8db536c079b2d();
            waitframe();
        }
    }

    // Namespace zone_spawner
    // Params 2, eflags: 0x4
    // Checksum 0x7ed4d6ae, Offset: 0x354f
    // Size: 0x89, Type: dev
    function private draw_spawner_state_text( ai_subclass, var_78d6606d597fb76e )
    {
        text = ai_subclass;
        
        for ( i = 0; i <= var_78d6606d597fb76e - ai_subclass.size ; i++ )
        {
            text += "<dev string:x41a>";
        }
        
        if ( should_draw_spawner( [ ai_subclass ] ) )
        {
            text += "<dev string:x41c>";
        }
        else
        {
            text += "<dev string:x41f>";
        }
        
        level debug::function_ce323c1a383e915( text, ( 1, 1, 0 ) );
    }

    // Namespace zone_spawner
    // Params 0
    // Checksum 0x461c08e0, Offset: 0x35e0
    // Size: 0x9d, Type: dev
    function function_ca314c9426eae6b0()
    {
        zombies = getaiarray( zm_utility::get_zombie_team() );
        
        foreach ( zombie in zombies )
        {
            zombie thread draw_zone_name();
        }
        
        level callback::add( "<dev string:x423>", &start_draw_zone_name );
    }

    // Namespace zone_spawner
    // Params 1
    // Checksum 0x85e5680a, Offset: 0x3685
    // Size: 0x16, Type: dev
    function start_draw_zone_name( params )
    {
        thread draw_zone_name();
    }

    // Namespace zone_spawner
    // Params 0
    // Checksum 0x4b9360a5, Offset: 0x36a3
    // Size: 0x83, Type: dev
    function draw_zone_name()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        
        if ( isdefined( self.spawn_loc.zone_name ) )
        {
            zone_name = self.spawn_loc.zone_name;
        }
        
        while ( true )
        {
            if ( isdefined( zone_name ) )
            {
                print3d( self.origin, zone_name, ( 0, 1, 0 ), 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace zone_spawner
    // Params 0
    // Checksum 0xe02e737d, Offset: 0x372e
    // Size: 0x17, Type: dev
    function function_3940e3221e8dbf03()
    {
        level callback::remove( "<dev string:x423>", &start_draw_zone_name );
    }

    // Namespace zone_spawner
    // Params 1, eflags: 0x4
    // Checksum 0x13484feb, Offset: 0x374d
    // Size: 0x1a, Type: dev
    function private function_2c394c8f97340a46( all_player_info )
    {
        level.all_player_info = all_player_info;
    }

#/

// Namespace zone_spawner
// Params 1
// Checksum 0x67711762, Offset: 0x376f
// Size: 0x418
function function_eeee6cc39266a2a3( spawn_loc )
{
    assert( utility::flag( "<dev string:x438>" ) );
    
    if ( spawn_loc.processed )
    {
        return;
    }
    
    spawn_loc.processed = 1;
    spawn_zone = spawn_loc.target;
    
    if ( !isdefined( spawn_zone ) )
    {
        spawn_zone = zone_manager::function_ac62281be3d43322( spawn_loc.origin );
    }
    
    spawn_loc.zone_name = spawn_zone;
    
    if ( isdefined( spawn_loc.script_noteworthy ) )
    {
        spawn_loc.ai_subclasses = [];
        var_ffa98d725bd7a487 = strtok( spawn_loc.script_noteworthy, "|" );
        
        foreach ( candidate in var_ffa98d725bd7a487 )
        {
            mapped_candidate = function_dc63662f4c025b01( candidate );
            ai_type = function_b3988325430ce242( mapped_candidate ) ?? mapped_candidate;
            subclass = ai::function_29ab862ec4f51541( ai_type );
            
            if ( isdefined( subclass ) )
            {
                spawn_loc.ai_subclasses = arraycombineunique( spawn_loc.ai_subclasses, [ mapped_candidate ] );
                spawn_loc.ai_subclasses = arraycombineunique( spawn_loc.ai_subclasses, [ ai::function_29ab862ec4f51541( ai_type ) ] );
                
                if ( isdefined( level.spawner_subclass_map[ subclass ] ) )
                {
                    spawn_loc.ai_subclasses = arraycombine( spawn_loc.ai_subclasses, level.spawner_subclass_map[ subclass ] );
                }
            }
            
            if ( isdefined( level.spawner_subclass_map[ candidate ] ) )
            {
                spawn_loc.ai_subclasses = arraycombine( spawn_loc.ai_subclasses, level.spawner_subclass_map[ candidate ] );
            }
        }
        
        spawn_loc.ai_subclasses = arrayremoveduplicates( spawn_loc.ai_subclasses );
        
        /#
            foreach ( ai_subclass in spawn_loc.ai_subclasses )
            {
                level.var_6a0ca82b96021d66[ ai_subclass ] = 1;
            }
        #/
    }
    
    if ( isdefined( spawn_zone ) )
    {
        spawn_zone_struct = zone_manager::get_zone_struct( spawn_zone );
        spawn_loc.subclass_to_aitype_map = spawn_zone_struct.subclass_to_aitype_map;
    }
    
    spawn_loc.disable_spawn_vfx = istrue( spawn_loc.var_f0cfa8ccf9a999 );
    
    if ( !spawn_loc.disable_spawn_vfx && !spawn_loc.var_b6279e33503ba8f && !( spawn_loc.target == "zone_foundry" && spawn_loc.script_noteworthy == "hvt_large" ) )
    {
        var_44daa6498da19d5 = findclosesttacpoint( spawn_loc.origin );
        
        if ( !isdefined( var_44daa6498da19d5 ) || function_93b6d3e8b4c58539( var_44daa6498da19d5 ) < 0.1 )
        {
            spawn_loc.disable_spawn_vfx = 1;
        }
    }
    
    /#
        spawn_loc.var_f75026dba575871d = 0;
        spawn_loc.var_2306e1230e900f37 = 0;
    #/
    
    if ( isdefined( spawn_loc.script_label ) )
    {
        level thread function_aadc23c1a676facb( spawn_zone, spawn_loc, spawn_loc.script_label );
        return;
    }
    
    assert( isdefined( spawn_zone ), "<dev string:x45b>" + spawn_loc.origin );
    
    if ( !isdefined( level.var_1d03be60f0a95b1c[ spawn_zone ] ) )
    {
        level.var_1d03be60f0a95b1c[ spawn_zone ] = [];
    }
    
    level.var_1d03be60f0a95b1c[ spawn_zone ][ level.var_1d03be60f0a95b1c[ spawn_zone ].size ] = spawn_loc;
}

