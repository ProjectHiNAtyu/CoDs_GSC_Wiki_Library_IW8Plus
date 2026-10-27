// script_1fd3c1c0eb847e19  (hash_1fd3c1c0eb847e19.gscc) (size: 8542 Bytes / 0x215e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa49e391 (2856969105)
// size ...... 8542 (0x215e)
// includes .. 15  (offset: 0x1efa)
// strings ... 30  (offset: 0x1f72)
// dev strs .. 1   (offset: 0x2152)
// exports ... 23  (offset: 0x1336)
// cseg ...... 0x2a8 + 0x108e (0x1336)
// imports ... 69  (offset: 0x16ce)
// animtree1 . 0   (offset: 0x215e)
// animtree2 . 0   (offset: 0x215e)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\equipment\c4;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\currency;
#using scripts\mp\magicbox;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\time_travel_timewarps;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\tedd_tasks;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_mantis_time_travel;

// Namespace zm_sat_mantis_time_travel
// Params 0, eflags: 0x5
// Checksum 0x6cc1bc94, Offset: 0x2c6
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_c454c4f88da24f26", #"sat_timetravel", &pre_init, &init );
}

// Namespace zm_sat_mantis_time_travel
// Params 0
// Checksum 0xc2d08c66, Offset: 0x2f3
// Size: 0x2d
function pre_init()
{
    if ( level.mapname != "zm_sat_mantis" )
    {
        return;
    }
    
    thread setup_exclusion_bounds();
    callback::add( "doorbuy_opened", &function_4350005d1d5c2a0f );
}

// Namespace zm_sat_mantis_time_travel
// Params 0
// Checksum 0xde775356, Offset: 0x328
// Size: 0x48
function init()
{
    if ( level.mapname != "zm_sat_mantis" )
    {
        return;
    }
    
    utility::flag_wait( "timetravel_system_ready" );
    setup_timetravel_entities();
    setup_timeline_zones();
    function_75a087cbb86c286a();
    level callback::add( "special_round_end", &function_425a0e8319f2fce8 );
}

// Namespace zm_sat_mantis_time_travel
// Params 0, eflags: 0x4
// Checksum 0x5741a316, Offset: 0x378
// Size: 0xc2
function private setup_timetravel_entities()
{
    thread setup_pap_machine();
    thread setup_bgb_machine();
    level callback::add( "timetravel_done", &warp_magicbox );
    level callback::add( "timetravel_done", &function_545d9605ae30a30c );
    level callback::add( "timetravel_done", &function_75a087cbb86c286a );
    level callback::add( "pre_timetravel_done", &sweep_rcxd );
    level callback::add( "timetravel_done", &function_e1ff8a83c9fd6f59 );
    level callback::add( "timetravel_done", &check_w_mod );
    level callback::add( "timetravel_done", &function_37fa2bed38f2f96e );
    level callback::add( #"vehicle_spawn", &setup_timetravel_vehicle );
    utility::registersharedfunc( #"dawg", #"hash_70fa1fdad51f3de7", &setup_timetravel_entity );
}

// Namespace zm_sat_mantis_time_travel
// Params 0, eflags: 0x4
// Checksum 0x20e6b42e, Offset: 0x442
// Size: 0x9f
function private setup_pap_machine()
{
    if ( !isdefined( level.var_db52bcfd04d45a7a ) || level.var_db52bcfd04d45a7a.size == 0 )
    {
        level waittill( #"hash_3c00bc13d8b0818d" );
    }
    
    var_9f9432741e058419 = level.var_db52bcfd04d45a7a[ 0 ];
    
    if ( !isdefined( var_9f9432741e058419 ) || !isdefined( var_9f9432741e058419.var_370acb837a3a86c3 ) )
    {
        return;
    }
    
    time_travel::register_timetravel_entity( var_9f9432741e058419 );
    time_travel::register_timetravel_entity( var_9f9432741e058419.var_370acb837a3a86c3 );
    level callback::add( "timetravel_done", &update_minimap_icon, { #ent:var_9f9432741e058419.var_370acb837a3a86c3 } );
}

// Namespace zm_sat_mantis_time_travel
// Params 0
// Checksum 0xb4d33549, Offset: 0x4e9
// Size: 0x14
function function_78b6017858b1a275()
{
    level callback::remove( "timetravel_done", &update_minimap_icon );
}

// Namespace zm_sat_mantis_time_travel
// Params 2, eflags: 0x4
// Checksum 0x4e2464e1, Offset: 0x505
// Size: 0xcf
function private update_minimap_icon( params, additional_params )
{
    if ( !additional_params.ent || additional_params.ent getscriptablepartstate( "minimap_icon" ) == "disabled" )
    {
        return;
    }
    
    additional_params.ent setscriptablepartstate( "minimap_icon", "moving" );
    waitframe();
    
    if ( !additional_params.ent )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"scriptable", #"hash_10d5e3bb8a551724" ) )
    {
        utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", additional_params.ent, "minimap_icon" );
        return;
    }
    
    additional_params.ent setscriptablepartstate( "minimap_icon", "active" );
}

// Namespace zm_sat_mantis_time_travel
// Params 0, eflags: 0x4
// Checksum 0xc7c25c93, Offset: 0x5dc
// Size: 0xb8
function private setup_bgb_machine()
{
    if ( !isdefined( level.var_e0910c7bd4aab6fc ) || level.var_e0910c7bd4aab6fc.size == 0 )
    {
        level waittill( #"bgb_machines_spawned" );
    }
    
    foreach ( bgb_machine in level.var_e0910c7bd4aab6fc )
    {
        time_travel::register_timetravel_entity( bgb_machine );
        time_travel::register_timetravel_entity( bgb_machine.mdl_bgb_machine );
    }
}

// Namespace zm_sat_mantis_time_travel
// Params 1, eflags: 0x4
// Checksum 0xb1dd70da, Offset: 0x69c
// Size: 0x372
function private warp_magicbox( params )
{
    if ( level.zm_mode_modifiers.var_7d3d84e96a1a43b5 )
    {
        return;
    }
    
    target_timeline = time_travel::get_current_timeline();
    
    foreach ( magicbox in level.var_1bbb5557537e2c0c )
    {
        if ( !magicbox.var_f14b2b4820b635e7 )
        {
            continue;
        }
        
        if ( magicbox.b_is_moving )
        {
            magicbox notify( #"stop_moving" );
            magicbox magicbox::cleanup_and_close_magicbox();
            magicbox.b_is_moving = undefined;
            utility::flag_clear( "magicbox_moving" );
        }
        
        magicbox.var_f14b2b4820b635e7 = undefined;
        
        if ( magicbox.interact.b_opened_magicbox )
        {
            magicbox magicbox::cleanup_and_close_magicbox();
        }
        
        magicbox magicbox::hide_magicbox( 1, 1 );
        select_magicbox = undefined;
        
        if ( isdefined( level.var_e0e84452fe117b5f[ magicbox.var_93e4a0a8514ca47e ] ) )
        {
            var_e5d70b127b1f80df = 0;
            level.var_e0e84452fe117b5f[ magicbox.var_93e4a0a8514ca47e ] = arrayrandomize( level.var_e0e84452fe117b5f[ magicbox.var_93e4a0a8514ca47e ] );
            
            foreach ( var_349a0723ed9ac19c in level.var_e0e84452fe117b5f[ magicbox.var_93e4a0a8514ca47e ] )
            {
                if ( var_349a0723ed9ac19c.mdl_magicbox != magicbox.mdl_magicbox && ( !isdefined( var_349a0723ed9ac19c.script_flag ) || level utility::flag( var_349a0723ed9ac19c.script_flag ) ) )
                {
                    if ( var_349a0723ed9ac19c.script_parameters != target_timeline.name )
                    {
                        if ( utility::flag( "powerup_fire_sale_active" ) )
                        {
                            if ( var_349a0723ed9ac19c.interact.b_opened_magicbox )
                            {
                                var_349a0723ed9ac19c magicbox::cleanup_and_close_magicbox();
                            }
                            
                            var_349a0723ed9ac19c thread magicbox::hide_magicbox( 1, 1 );
                        }
                        
                        continue;
                    }
                    
                    if ( var_349a0723ed9ac19c.interact.b_opened_magicbox )
                    {
                        var_349a0723ed9ac19c magicbox::cleanup_and_close_magicbox();
                    }
                    
                    var_349a0723ed9ac19c magicbox::show_magicbox();
                    
                    if ( !var_e5d70b127b1f80df )
                    {
                        var_349a0723ed9ac19c.var_f14b2b4820b635e7 = 1;
                        var_e5d70b127b1f80df = 1;
                        select_magicbox = var_349a0723ed9ac19c;
                    }
                    
                    if ( utility::flag( "powerup_fire_sale_active" ) )
                    {
                        if ( !isdefined( var_349a0723ed9ac19c.n_original_cost ) )
                        {
                            var_349a0723ed9ac19c.n_original_cost = var_349a0723ed9ac19c.script_cost;
                            var_349a0723ed9ac19c.script_cost = currency::get_magicbox_cost_firesale() ?? 10;
                        }
                        
                        continue;
                    }
                    
                    break;
                }
            }
        }
        
        if ( !isdefined( select_magicbox ) )
        {
            magicbox magicbox::show_magicbox( 1, 1 );
            magicbox.var_f14b2b4820b635e7 = 1;
            assert( 0, "<dev string:x24>" + target_timeline.name );
        }
        
        break;
    }
}

// Namespace zm_sat_mantis_time_travel
// Params 1, eflags: 0x4
// Checksum 0xa9a18b3a, Offset: 0xa16
// Size: 0xc8
function private function_545d9605ae30a30c( params )
{
    current_timeline = level.timetravel.timeline.name;
    
    if ( current_timeline != level.var_bf936ccc57156561 )
    {
        level callback::callback( "chest_hide_icons" );
        
        if ( isdefined( level.var_a3eb428773fa9129 ) )
        {
            level.var_a3eb428773fa9129 teddtasks::function_ec8395db14b3e26f();
            
            if ( level.var_fd94a3cfab1edb0 || level.var_38e41e5bcaec2a1d )
            {
                level thread function_1707860703c646b8();
            }
        }
    }
    
    if ( current_timeline == level.var_bf936ccc57156561 )
    {
        level callback::callback( "chest_show_icons" );
        
        if ( isdefined( level.var_a3eb428773fa9129 ) )
        {
            level.var_a3eb428773fa9129 teddtasks::function_c687838183131248();
        }
    }
}

// Namespace zm_sat_mantis_time_travel
// Params 0, eflags: 0x4
// Checksum 0x612b12ee, Offset: 0xae6
// Size: 0x2a
function private function_1707860703c646b8()
{
    level val::set( "task_timetravel", "task_logic_activate", 0 );
    wait 5;
    level val::reset( "task_timetravel", "task_logic_activate" );
}

// Namespace zm_sat_mantis_time_travel
// Params 1, eflags: 0x4
// Checksum 0x62f9df96, Offset: 0xb18
// Size: 0x14
function private setup_timetravel_entity( params )
{
    time_travel::register_timetravel_entity( self );
}

// Namespace zm_sat_mantis_time_travel
// Params 1, eflags: 0x4
// Checksum 0x52e6f2bc, Offset: 0xb34
// Size: 0x2f
function private function_75a087cbb86c286a( params )
{
    utility::flag_wait( "scriptables_ready" );
    namespace_24edb5d87524aa7f::function_a2c1c84be2b355cb( time_travel::get_current_timeline().name );
}

// Namespace zm_sat_mantis_time_travel
// Params 1, eflags: 0x4
// Checksum 0x852e7793, Offset: 0xb6b
// Size: 0xf5
function private function_e1ff8a83c9fd6f59( params )
{
    foreach ( player in level.players )
    {
        foreach ( c4 in player.c4s )
        {
            c4 c4::sweepc4();
        }
    }
}

// Namespace zm_sat_mantis_time_travel
// Params 1, eflags: 0x4
// Checksum 0x97545b2e, Offset: 0xc68
// Size: 0x95
function private sweep_rcxd( params )
{
    if ( isarray( level.rcxds ) )
    {
        foreach ( rcxd in level.rcxds )
        {
            rcxd thread rcxd_shared::rcxd_explode();
        }
    }
}

// Namespace zm_sat_mantis_time_travel
// Params 1, eflags: 0x4
// Checksum 0x9111011a, Offset: 0xd05
// Size: 0xb5
function private check_w_mod( params )
{
    foreach ( player in level.players )
    {
        var_d9d834607fac748d = player.var_4fd5ac47a9bd8c18;
        
        if ( var_d9d834607fac748d && var_d9d834607fac748d.var_d1e820894084abac )
        {
            var_d9d834607fac748d.var_d1e820894084abac kill();
        }
    }
}

// Namespace zm_sat_mantis_time_travel
// Params 1, eflags: 0x4
// Checksum 0x23e6b553, Offset: 0xdc2
// Size: 0xab
function private function_37fa2bed38f2f96e( params )
{
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( zombie.aicategory != "special" )
        {
            continue;
        }
        
        zombie zm_cleanup_manager::teleport_zombie( 1 );
    }
}

// Namespace zm_sat_mantis_time_travel
// Params 1, eflags: 0x4
// Checksum 0xc5b36277, Offset: 0xe75
// Size: 0x1e
function private setup_timetravel_vehicle( params )
{
    time_travel::register_timetravel_entity( params.vehicle );
}

// Namespace zm_sat_mantis_time_travel
// Params 0, eflags: 0x4
// Checksum 0x7d8b288b, Offset: 0xe9b
// Size: 0x249
function private setup_timeline_zones()
{
    var_800c859752e950e5 = [];
    var_800c859752e950e5[ "future" ] = [];
    var_800c859752e950e5[ "past" ] = [];
    var_cfdcb332178e0755 = zone_manager::get_all_zones();
    
    foreach ( zone in var_cfdcb332178e0755 )
    {
        if ( zone.zone_name )
        {
            if ( zone.zone_name.size >= 2 && zone.zone_name[ zone.zone_name.size - 2 ] == "_" )
            {
                if ( zone.zone_name[ zone.zone_name.size - 1 ] == "f" )
                {
                    var_800c859752e950e5[ "future" ][ var_800c859752e950e5[ "future" ].size ] = zone.zone_name;
                    continue;
                }
                
                if ( zone.zone_name[ zone.zone_name.size - 1 ] == "p" )
                {
                    var_800c859752e950e5[ "past" ][ var_800c859752e950e5[ "past" ].size ] = zone.zone_name;
                }
            }
        }
    }
    
    var_800c859752e950e5[ "future" ][ var_800c859752e950e5[ "future" ].size ] = "zone_street_5_f_garage";
    var_800c859752e950e5[ "future" ] = arrayremoveduplicates( var_800c859752e950e5[ "future" ] );
    var_800c859752e950e5[ "past" ] = arrayremoveduplicates( var_800c859752e950e5[ "past" ] );
    
    if ( level.timetravel )
    {
        foreach ( timeline in level.timetravel.timelines )
        {
            if ( var_800c859752e950e5[ timeline.name ] )
            {
                timeline.zones = var_800c859752e950e5[ timeline.name ];
            }
        }
    }
}

// Namespace zm_sat_mantis_time_travel
// Params 0, eflags: 0x4
// Checksum 0x1e69aceb, Offset: 0x10ec
// Size: 0x11a
function private setup_exclusion_bounds()
{
    utility::flag_wait( "timetravel_system_ready" );
    time_travel::function_ff2da1e34e2b4e1a( "future_truck", ( 55732, -31067, -103 ), ( 55871, -30824, -103 ), ( 55847, -31131, -103 ), ( 55732, -31067, 9 ) );
    time_travel::function_ff2da1e34e2b4e1a( "past_truck", ( 78260, -31067, -103 ), ( 78399, -30824, -103 ), ( 78375, -31131, -103 ), ( 78260, -31067, 9 ) );
    time_travel::function_ff2da1e34e2b4e1a( "future_yellow_house_kitchen", ( 56444, -31854, -122 ), ( 56472, -31874, -122 ), ( 56484, -31782, -122 ), ( 56444, -31854, 2 ) );
    time_travel::function_ff2da1e34e2b4e1a( "future_yellow_house_garage", ( 56306, -31442, -121 ), ( 56583, -31598, -121 ), ( 56452, -31194, -121 ), ( 56306, -31442, -5 ) );
    utility::flag_set( "exclusion_bounds_setup" );
}

// Namespace zm_sat_mantis_time_travel
// Params 1, eflags: 0x4
// Checksum 0xc2cf8d51, Offset: 0x120e
// Size: 0xa7
function private function_4350005d1d5c2a0f( params )
{
    door = params.door.targetname;
    utility::flag_wait( "exclusion_bounds_setup" );
    
    if ( !door )
    {
        return;
    }
    
    switch ( door )
    {
        case #"hash_b36c730db27645d2":
            time_travel::function_4350005d1d5c2a0f( "future_truck" );
            break;
        case #"hash_b36c7d0db2765590":
            time_travel::function_4350005d1d5c2a0f( "past_truck" );
            break;
        case #"hash_e92ef04c0ac2b0dc":
            time_travel::function_4350005d1d5c2a0f( "future_yellow_house_kitchen" );
            time_travel::function_4350005d1d5c2a0f( "future_yellow_house_garage" );
            break;
    }
}

// Namespace zm_sat_mantis_time_travel
// Params 1, eflags: 0x4
// Checksum 0x6b022dce, Offset: 0x12bd
// Size: 0x79
function private function_425a0e8319f2fce8( params )
{
    level endon( #"game_ended" );
    level utility::waittill_notify_or_timeout( "powerup_grabbed", 7 );
    level notify( #"timetravel_abort_delay" );
    wait level.timetravel.data.total_duration ?? 7;
    
    if ( zm_save::is_save_load_enabled() )
    {
        zm_save::save_session( 0 );
        
        if ( zm_save::is_autosave_enabled() )
        {
            zm_save::commit_session( 1 );
        }
    }
}

