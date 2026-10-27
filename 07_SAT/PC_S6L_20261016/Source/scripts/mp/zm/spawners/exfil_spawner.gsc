// scripts\mp\zm\spawners\exfil_spawner.gsc  (hash_66d65fe0468cdf37.gscc) (size: 4769 Bytes / 0x12a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7b5dd4cc (2069746892)
// size ...... 4769 (0x12a1)
// includes .. 10  (offset: 0x11a1)
// strings ... 9   (offset: 0x11f1)
// dev strs .. 5   (offset: 0x1265)
// exports ... 8   (offset: 0xb61)
// cseg ...... 0xd0 + 0xa91 (0xb61)
// imports ... 43  (offset: 0xca1)
// animtree1 . 0   (offset: 0x12a1)
// animtree2 . 0   (offset: 0x12a1)
#using script_4bf223434bdc0646;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;

#namespace exfil_spawner;

// Namespace exfil_spawner
// Params 0, eflags: 0x1
// Checksum 0xcd2c4488, Offset: 0xee
// Size: 0x1d
function autoexec init_exfil_spawner()
{
    agent_spawner::register_spawner( "exfil", &spawn_agent );
    
    /#
        setup_exfil_spawner_devgui();
    #/
}

// Namespace exfil_spawner
// Params 2, eflags: 0x4
// Checksum 0xdd6e75a3, Offset: 0x113
// Size: 0x5c1
function private spawn_agent( aitype, params )
{
    selected_origin = undefined;
    selected_zone = undefined;
    var_3d9ebffc1c6a16c1 = undefined;
    selected_zone_array = undefined;
    selected_player = undefined;
    exfil_origin = undefined;
    exfil_zone = undefined;
    is_exfil_site_spawn = 0;
    var_12e16941b3386ee8 = 0;
    
    if ( isdefined( level.s_exfil_active.var_42ada65a735fd2f3.origin ) )
    {
        exfil_zones = isdefined( level.var_41b52e54c6e6ac2c ) ? [[ level.var_41b52e54c6e6ac2c ]]( level.s_exfil_active ) : [];
        exfil_origin = level.s_exfil_active.var_42ada65a735fd2f3.origin;
        
        if ( exfil_zones.size > 0 )
        {
            exfil_zone = zone_manager::get_zone_struct( utility::array_random( exfil_zones ) );
        }
        else
        {
            exfil_zone = zone_manager::function_90e5c3e2272b0130( exfil_origin );
        }
    }
    
    is_elite = 0;
    aitype = function_b3988325430ce242( aitype ) ?? aitype;
    elite_array = namespace_c7157c2cd884c5d5::function_e05919b47b9a0cda( "elite" );
    
    if ( arraycontains( elite_array, aitype ) )
    {
        is_elite = 1;
    }
    
    if ( isdefined( exfil_origin ) )
    {
        var_c68ccaab1174cea1 = function_47c86977a18df38b( utility::get_alive_players(), exfil_origin );
        var_774c0b07496cfb12 = istrue( params.var_774c0b07496cfb12 );
        
        if ( var_774c0b07496cfb12 || is_elite )
        {
            selected_origin = exfil_origin;
            selected_zone = exfil_zone;
            is_exfil_site_spawn = 1;
        }
        else
        {
            selected_player = utility::array_random( level.players );
            
            if ( isdefined( selected_player ) )
            {
                var_77898ab40e53d0ae = selected_player.cached_zone_info.zone_struct ?? zone_manager::function_90e5c3e2272b0130( selected_player.origin );
                selected_zone = undefined;
                selected_origin = undefined;
                
                if ( zone_manager::is_water_zone( var_77898ab40e53d0ae ) )
                {
                    var_12e16941b3386ee8 = 1;
                    selected_origin = selected_player.origin;
                    selected_zone = selected_player.cached_zone_info.zone_struct ?? zone_manager::function_90e5c3e2272b0130( selected_player.origin );
                }
                else
                {
                    var_bb9a42d0b4e5ecf5 = function_40be4efa9ac54eea( selected_player, var_77898ab40e53d0ae, aitype );
                    
                    if ( var_bb9a42d0b4e5ecf5.size > 0 )
                    {
                        selected_zone_array = var_bb9a42d0b4e5ecf5;
                        selected_zone = utility::array_random( var_bb9a42d0b4e5ecf5 );
                        selected_origin = selected_zone.origin;
                    }
                }
            }
        }
    }
    
    if ( !isdefined( selected_zone ) || !function_8f5f58bdd9e44f42( selected_zone, aitype ) )
    {
        return;
    }
    
    if ( selected_zone === exfil_zone )
    {
        ai = agent_spawner::spawn_agent_custom( aitype, "zone", { #zones:[ exfil_zone ] } );
        return ai;
    }
    
    if ( isdefined( selected_origin ) )
    {
        nav_pos = getclosestpointonnavmesh( selected_origin );
        spawn_positions = getrandomnavpoints( nav_pos, 3000, 32 );
        closest_spawn_pos = undefined;
        closest_dist = undefined;
        
        if ( isdefined( spawn_positions ) )
        {
            valid_spawn_positions = [];
            
            foreach ( pos in spawn_positions )
            {
                var_48607cfdb87ffbae = distance2dsquared( nav_pos, pos );
                
                if ( var_12e16941b3386ee8 )
                {
                    if ( var_48607cfdb87ffbae < 62500 )
                    {
                        continue;
                    }
                    
                    if ( var_48607cfdb87ffbae > 1000000 )
                    {
                        continue;
                    }
                    
                    player_forward = anglestoforward( selected_player.angles );
                    to_pos = pos - nav_pos;
                    
                    if ( vectordot( player_forward, to_pos ) > 0 )
                    {
                        var_507c4a781f4f8c9a = 64;
                        player_right = anglestoright( selected_player.angles );
                        
                        if ( abs( vectordot( player_right, to_pos ) ) < var_507c4a781f4f8c9a )
                        {
                            continue;
                        }
                    }
                }
                else
                {
                    if ( var_48607cfdb87ffbae < 10000 )
                    {
                        continue;
                    }
                    
                    if ( var_48607cfdb87ffbae > 9000000 )
                    {
                        continue;
                    }
                }
                
                if ( !isdefined( selected_zone_array ) )
                {
                    selected_zone_array = [ selected_zone ];
                }
                
                current_zone = zone_manager::function_90e5c3e2272b0130( pos );
                
                if ( isdefined( current_zone ) && ( selected_zone === current_zone || arraycontains( selected_zone_array, current_zone ) ) )
                {
                    valid_spawn_positions[ valid_spawn_positions.size ] = pos;
                    
                    if ( isdefined( exfil_origin ) )
                    {
                        dist = distance2dsquared( exfil_origin, pos );
                        
                        if ( !isdefined( closest_dist ) || dist < closest_dist )
                        {
                            closest_dist = dist;
                            closest_spawn_pos = pos;
                        }
                    }
                }
            }
            
            if ( var_12e16941b3386ee8 )
            {
                spawn_pos = closest_spawn_pos;
            }
            else
            {
                spawn_pos = utility::array_random( valid_spawn_positions );
            }
            
            if ( !isdefined( spawn_pos ) )
            {
                return;
            }
            
            spawn_yaw = 0;
            
            if ( isdefined( selected_player ) )
            {
                spawn_yaw = vectortoyaw( selected_player.origin - spawn_pos );
            }
            
            agent = agent_manager::spawn_agent( aitype, spawn_pos, ( 0, spawn_yaw, 0 ) );
            
            if ( isdefined( agent ) )
            {
                agent callback::callback( "on_exfil_ai_spawned" );
                spawn_loc = spawnstruct();
                spawn_loc.origin = spawn_pos;
                script_animation = isdefined( level.scr_anim[ agent.animname ][ "spawn_air" ] ) ? "spawn_air" : isdefined( level.scr_anim[ agent.animname ][ "spawn_fast" ] ) ? "spawn_fast" : "spawn";
                spawn_loc.script_animation = script_animation;
                agent thread agent_spawner::function_ce10e453e7f7bb8e( spawn_loc );
                
                if ( is_exfil_site_spawn )
                {
                    agent val::set( "exfil_spawner", "ignore_cleanup", 1 );
                    agent.var_dff84042581698c3 = 1;
                }
            }
            
            return agent;
        }
    }
}

// Namespace exfil_spawner
// Params 0, eflags: 0x4
// Checksum 0x768e1961, Offset: 0x6dd
// Size: 0x9b
function private function_edfc7383b8c609cf()
{
    count = 0;
    ai_array = getaiarray();
    
    foreach ( ai in ai_array )
    {
        if ( ai.var_dff84042581698c3 )
        {
            count += 1;
        }
    }
    
    return count;
}

// Namespace exfil_spawner
// Params 2, eflags: 0x4
// Checksum 0x7659851, Offset: 0x781
// Size: 0xfb, Type: bool
function private function_8f5f58bdd9e44f42( zone, aitype )
{
    recommended_subclass = ai::function_29ab862ec4f51541( aitype );
    assert( isdefined( recommended_subclass ) );
    recommended_aitype = function_b3988325430ce242( recommended_subclass );
    zone_spawn_locs = level.var_1d03be60f0a95b1c[ zone.script_zone_name ];
    
    if ( isdefined( zone_spawn_locs ) )
    {
        foreach ( zone_spawn in zone_spawn_locs )
        {
            if ( isdefined( zone_spawn.ai_subclasses ) && arraycontains( zone_spawn.ai_subclasses, recommended_subclass ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace exfil_spawner
// Params 3, eflags: 0x4
// Checksum 0xe07c8f92, Offset: 0x885
// Size: 0x194
function private function_40be4efa9ac54eea( player, var_77898ab40e53d0ae, aitype )
{
    if ( !isdefined( var_77898ab40e53d0ae ) )
    {
        return [];
    }
    
    var_c96b1c3cfbbd6aac = var_77898ab40e53d0ae zone_manager::get_adjacent_zones( 1, 1 );
    player_direction = player zm_player::function_6aa4b5494255506b();
    highest_dot_product = -1;
    visited_zones = [ var_77898ab40e53d0ae ];
    possible_zones = [];
    new_zone = var_77898ab40e53d0ae;
    var_1bdba433a495e631 = 3;
    
    for ( var_20c8b0019bf67588 = 0; var_20c8b0019bf67588 < var_1bdba433a495e631 && isdefined( new_zone ) ; var_20c8b0019bf67588++ )
    {
        var_c96b1c3cfbbd6aac = new_zone zone_manager::get_adjacent_zones( 1, 1 );
        highest_dot_product = -1;
        
        foreach ( var_82733f6af6e5f6d7 in var_c96b1c3cfbbd6aac )
        {
            if ( arraycontains( visited_zones, var_82733f6af6e5f6d7 ) )
            {
                continue;
            }
            
            visited_zones[ visited_zones.size ] = var_82733f6af6e5f6d7;
            
            if ( function_8f5f58bdd9e44f42( var_82733f6af6e5f6d7, aitype ) )
            {
                dot_product = vectordot( player_direction, vectornormalize( var_82733f6af6e5f6d7.origin - player.origin ) );
                
                if ( dot_product > highest_dot_product && dot_product > 0 )
                {
                    possible_zones[ possible_zones.size ] = var_82733f6af6e5f6d7;
                    highest_dot_product = dot_product;
                    new_zone = var_82733f6af6e5f6d7;
                }
            }
        }
    }
    
    return possible_zones;
}

/#

    // Namespace exfil_spawner
    // Params 0
    // Checksum 0xac821041, Offset: 0xa22
    // Size: 0x3c, Type: dev
    function setup_exfil_spawner_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" + "<dev string:x30>" + "<dev string:x36>" );
        devgui::add_devgui_func( "<dev string:x38>", "<dev string:x4f>", &draw_spawn_area, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace exfil_spawner
    // Params 0, eflags: 0x4
    // Checksum 0x8d1fc610, Offset: 0xa66
    // Size: 0xfb, Type: dev
    function private draw_spawn_area()
    {
        while ( true )
        {
            if ( isdefined( level.players ) )
            {
                foreach ( player in level.players )
                {
                    var_29c712a3c9b9188c = getclosestpointonnavmesh( player.origin );
                    sphere( var_29c712a3c9b9188c, 2, ( 0, 0, 1 ), 1, 1 );
                    utility::draw_circle( var_29c712a3c9b9188c, 250, ( 0, 0, 1 ), 1, 1, 1 );
                    utility::draw_circle( var_29c712a3c9b9188c, 1000, ( 0, 0, 1 ), 1, 1, 1 );
                }
            }
            
            waitframe();
        }
    }

#/
