// script_3045fde1f2a74482  (hash_3045fde1f2a74482.gscc) (size: 5435 Bytes / 0x153b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf1c134b (2937852747)
// size ...... 5435 (0x153b)
// includes .. 8   (offset: 0x135b)
// strings ... 34  (offset: 0x139b)
// dev strs .. 0   (offset: 0x153b)
// exports ... 10  (offset: 0xdaf)
// cseg ...... 0x346 + 0xa69 (0xdaf)
// imports ... 33  (offset: 0xf3f)
// animtree1 . 0   (offset: 0x153b)
// animtree2 . 0   (offset: 0x153b)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\gametypes\zm_rb_survival;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_murder_holes;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_pap_quest;
#using scripts\mp\zm\systems\zone_manager;

#namespace namespace_df63222e81d7b3dd;

// Namespace namespace_df63222e81d7b3dd
// Params 0, eflags: 0x5
// Checksum 0xc6d3a576, Offset: 0x364
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"hash_fea238716a02c6b2", undefined, &pre_main_init, &post_main_init );
}

// Namespace namespace_df63222e81d7b3dd
// Params 0, eflags: 0x4
// Checksum 0x6a673a2, Offset: 0x389
// Size: 0xd
function private pre_main_init()
{
    if ( !function_494616db66c84e53() )
    {
        return;
    }
}

// Namespace namespace_df63222e81d7b3dd
// Params 0, eflags: 0x4
// Checksum 0x86cbd491, Offset: 0x39e
// Size: 0x10f
function private post_main_init()
{
    if ( !function_494616db66c84e53() )
    {
        return;
    }
    
    level.var_d78277198d5eb19c = [ "zone_main_keep_roof", "zone_keep_east_path", "zone_keep_phd" ];
    level utility::flag_wait( "scriptables_ready" );
    var_7c06ccff26c8744e = utility::getstruct( "pedestal" );
    sc_pedestal = spawnscriptable( %"zm_sat_hornet_pap_pedestal", var_7c06ccff26c8744e.origin, var_7c06ccff26c8744e.angles );
    sc_pedestal utility::function_7c10ea82c1e305b8( "visual", "pedestal" );
    s_seed = utility::getstruct( "seed" );
    sc_seed = utility::spawn_model( %"hash_6c35cf67bff31b67", s_seed.origin, s_seed.angles );
    level thread function_6e768e27593c3006();
    level thread function_27d2fd641bfe2f13();
    level thread function_afc850e22470f90f();
    level thread function_ed12c05f934569c0();
    level thread function_78bc51641649e16b();
    level utility::flag_set( "completed_ww_step_6" );
}

// Namespace namespace_df63222e81d7b3dd
// Params 0
// Checksum 0x5d95468f, Offset: 0x4b5
// Size: 0xc3
function function_ed12c05f934569c0()
{
    level endon( #"game_ended" );
    utility::flag_wait( "zone_setup_finished" );
    zone_manager::set_zone_enabled( "zone_main_keep_west_path_b", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_west_path_a", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_jump_zone_02_eave", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_jump_zone_02", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_top", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_roof_b", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_roof_a", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_east_path_b", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_east_path_a", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_2nd_floor_a", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_2nd_floor_b", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_2nd_floor_c", 0 );
    zone_manager::set_zone_enabled( "zone_main_keep_2nd_floor_d", 0 );
}

// Namespace namespace_df63222e81d7b3dd
// Params 0, eflags: 0x4
// Checksum 0xf0c205f3, Offset: 0x580
// Size: 0xa8
function private function_6e768e27593c3006()
{
    level utility::flag_wait( "doorbuy_init_complete" );
    
    for ( i = 1; i <= 7 ; i++ )
    {
        foreach ( door_trigger in getentarray( "doorbuy_powered_door_" + i, "target2" ) )
        {
            door_trigger triggerdisable();
        }
    }
}

// Namespace namespace_df63222e81d7b3dd
// Params 0, eflags: 0x4
// Checksum 0x6eaa1d6e, Offset: 0x630
// Size: 0x2f, Type: bool
function private function_494616db66c84e53()
{
    if ( !game_utility::function_21211f3255f8ea58() )
    {
        return false;
    }
    
    poiname = zm_rb_survival::function_64c3a9143299dacb();
    
    if ( poiname != "castle" )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_df63222e81d7b3dd
// Params 0, eflags: 0x4
// Checksum 0x6f724d75, Offset: 0x668
// Size: 0x54
function private function_27d2fd641bfe2f13()
{
    level endon( #"game_ended" );
    level thread zm_sat_hornet_pap_quest::power_doors_manage();
    level utility::flag_wait( "door_main_keep_to_top" );
    level thread zm_sat_hornet_pap_quest::open_power_doors();
    level thread zm_sat_hornet_pap_quest::pap_power_blast();
    level val::set( "power_on", "task_logic_activate", 1 );
    level utility::flag_set( "power_on" );
}

// Namespace namespace_df63222e81d7b3dd
// Params 0
// Checksum 0xabceb03c, Offset: 0x6c4
// Size: 0x24d
function function_afc850e22470f90f()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "mh_ready" );
    wait 2;
    a_switch = utility::getstructarray( "murder_holes_trap" );
    
    foreach ( s in a_switch )
    {
        if ( s.script_noteworthy != "mh_root_4" )
        {
            continue;
        }
        
        zm_sat_hornet_murder_holes::function_9ceca8d29317aa92( s );
        
        if ( s.a_komainu )
        {
            foreach ( komainu in s.a_komainu )
            {
                komainu freescriptable();
            }
        }
        
        foreach ( s_switch in s.a_switch_pos )
        {
            if ( s_switch.interact )
            {
                s_switch.interact freescriptable();
            }
        }
        
        foreach ( ghost in s.a_ghosts )
        {
            ghost.var_df00f5fbf4a6d195 = 1;
        }
    }
}

// Namespace namespace_df63222e81d7b3dd
// Params 0
// Checksum 0x1959a455, Offset: 0x919
// Size: 0x496
function function_78bc51641649e16b()
{
    level endon( #"game_ended" );
    max_wait_frames = 300;
    
    for ( wait_frame_count = 0; wait_frame_count < max_wait_frames ; wait_frame_count++ )
    {
        if ( !isdefined( level.zone_spawn_locations ) || !isdefined( level.var_1d03be60f0a95b1c ) )
        {
            waitframe();
            continue;
        }
        
        spawners_processed = 1;
        
        foreach ( zone_spawner in level.zone_spawn_locations )
        {
            if ( !isdefined( zone_spawner.processed ) )
            {
                spawners_processed = 0;
                break;
            }
        }
        
        if ( spawners_processed )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( !isdefined( level.zone_spawn_locations ) )
    {
        level.zone_spawn_locations = utility::getstructarray( "zone_agent_spawn", "targetname" );
    }
    
    if ( !isdefined( level.zone_spawn_locations ) || !isdefined( level.var_1d03be60f0a95b1c ) )
    {
        return;
    }
    
    disabled_spawners = [];
    
    foreach ( zone_spawner in level.zone_spawn_locations )
    {
        if ( !isdefined( zone_spawner.origin ) )
        {
            continue;
        }
        
        if ( distancesquared( zone_spawner.origin, ( 509.487, -19148.8, 710.55 ) ) <= squared( 64 ) )
        {
            disabled_spawners[ disabled_spawners.size ] = zone_spawner;
        }
    }
    
    if ( disabled_spawners.size <= 0 )
    {
        return;
    }
    
    var_8f5968adf783a8ef = [];
    
    foreach ( zone_spawner in level.zone_spawn_locations )
    {
        if ( arraycontains( disabled_spawners, zone_spawner ) )
        {
            continue;
        }
        
        var_8f5968adf783a8ef[ var_8f5968adf783a8ef.size ] = zone_spawner;
    }
    
    level.zone_spawn_locations = var_8f5968adf783a8ef;
    
    foreach ( zone_name, zone_spawners in level.var_1d03be60f0a95b1c )
    {
        if ( !isdefined( zone_spawners ) )
        {
            continue;
        }
        
        filtered_zone_spawners = [];
        
        foreach ( zone_spawner in zone_spawners )
        {
            if ( arraycontains( disabled_spawners, zone_spawner ) )
            {
                continue;
            }
            
            filtered_zone_spawners[ filtered_zone_spawners.size ] = zone_spawner;
        }
        
        level.var_1d03be60f0a95b1c[ zone_name ] = filtered_zone_spawners;
    }
    
    foreach ( zone_spawner in level.zone_spawn_locations )
    {
        if ( !isdefined( zone_spawner.close_spawn_locs ) )
        {
            continue;
        }
        
        var_cfdb7fe1ef9b8288 = [];
        
        foreach ( close_spawn_loc in zone_spawner.close_spawn_locs )
        {
            if ( arraycontains( disabled_spawners, close_spawn_loc ) )
            {
                continue;
            }
            
            var_cfdb7fe1ef9b8288[ var_cfdb7fe1ef9b8288.size ] = close_spawn_loc;
        }
        
        zone_spawner.close_spawn_locs = var_cfdb7fe1ef9b8288;
    }
}

