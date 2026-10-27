// script_5c5e5032f1170bc6  (hash_5c5e5032f1170bc6.gscc) (size: 6983 Bytes / 0x1b47 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x547d257c (1417487740)
// size ...... 6983 (0x1b47)
// includes .. 7   (offset: 0x19bf)
// strings ... 26  (offset: 0x19f7)
// dev strs .. 0   (offset: 0x1b47)
// exports ... 15  (offset: 0x11db)
// cseg ...... 0x3bb + 0xe20 (0x11db)
// imports ... 46  (offset: 0x1433)
// animtree1 . 0   (offset: 0x1b47)
// animtree2 . 0   (offset: 0x1b47)
#using script_35efc59124dbb5db;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\destructibles\destructibles;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\zm_quest;

#namespace namespace_2a9676437b2f197b;

// Namespace namespace_2a9676437b2f197b
// Params 0
// Checksum 0x965a7d7c, Offset: 0x3d9
// Size: 0x144
function init()
{
    level callback::add( #"player_connect", &on_player_connect );
    data = { #var_5aeac48fc66a9173:undefined, #var_3d34bc001775ed61:0, #past_walls:[ destructible::get_instances( "clean::sat_destructible_wall_mantis_01" )[ 0 ], destructible::get_instances( "clean::sat_destructible_wall_mantis_02" )[ 0 ], destructible::get_instances( "clean::sat_destructible_wall_mantis_03" )[ 0 ] ], #future_walls:[ destructible::get_instances( "sat_destructible_wall_mantis_01_hardened" )[ 0 ], destructible::get_instances( "sat_destructible_wall_mantis_02_hardened" )[ 0 ], destructible::get_instances( "sat_destructible_wall_mantis_03_hardened" )[ 0 ] ], #ichor_nodes:utility::getstructarray( "ww_quest_step_1_spawn_node_ichor", "script_noteworthy" ), #var_b3daf67a5a5ba863:utility::getstructarray( "ww_quest_step_1_spawn_node", "script_noteworthy" ), #ww_part:undefined };
    level.mantis_ww_quest.var_1e5d943acb8a2ef8 = data;
    init_walls( data.past_walls );
    setup_ichor( data.future_walls, data.ichor_nodes );
    utility::flag_set( #"hash_d6d4f73ab7728d02" );
}

// Namespace namespace_2a9676437b2f197b
// Params 1, eflags: 0x4
// Checksum 0xab353ffc, Offset: 0x525
// Size: 0x1d
function private on_player_connect( params )
{
    callback::add( "quest_item_used", &function_f9b91f79e464401b );
}

// Namespace namespace_2a9676437b2f197b
// Params 2
// Checksum 0xe0832b7b, Offset: 0x54a
// Size: 0x3b
function execute( skipped, save_restored )
{
    function_b383cba9a674761e();
    spawn_items();
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "ww_part_stock_picked_up" );
}

// Namespace namespace_2a9676437b2f197b
// Params 2
// Checksum 0x8b640ceb, Offset: 0x58d
// Size: 0x33
function cleanup( skipped, save_restored )
{
    zm_quest::function_b57dfe9625966b0b( #"mantis_ww_quest", 0, #"sat_zm_quest_mantis_wwq_stock", 1, 1 );
}

// Namespace namespace_2a9676437b2f197b
// Params 1, eflags: 0x4
// Checksum 0xe662c1f5, Offset: 0x5c8
// Size: 0x92
function private init_walls( walls )
{
    foreach ( wall in walls )
    {
        wall destructible::function_12e4a9779677a8b8( "destructible_destruction", { #execute:&on_wall_broken } );
    }
}

// Namespace namespace_2a9676437b2f197b
// Params 2, eflags: 0x4
// Checksum 0xfa85f5d6, Offset: 0x662
// Size: 0x138
function private setup_ichor( walls, ichor_nodes )
{
    foreach ( wall in walls )
    {
        foreach ( ichor_node in ichor_nodes )
        {
            if ( wall.targetname == ichor_node.targetname )
            {
                wall.ichor = utility::spawn_model( "sat_zm_ichor_wall_" + wall.targetname, ichor_node.origin, ichor_node.angles );
            }
        }
    }
}

// Namespace namespace_2a9676437b2f197b
// Params 0, eflags: 0x4
// Checksum 0x1a399db, Offset: 0x7a2
// Size: 0x16b
function private function_b383cba9a674761e()
{
    foreach ( wall in level.mantis_ww_quest.var_1e5d943acb8a2ef8.past_walls )
    {
        wall_was_destroyed = 0;
        
        switch ( wall.script_noteworthy )
        {
            case #"hash_ee66e54b8d9dfe44":
                wall_was_destroyed = zm_quest::function_73720cdf21c3cfd7( #"mantis_ww_quest", #"hash_abe60d153e917a59" );
                break;
            case #"hash_ee66e84b8d9e02fd":
                wall_was_destroyed = zm_quest::function_73720cdf21c3cfd7( #"mantis_ww_quest", #"hash_481dffe8a30f6520" );
                break;
            case #"hash_ee66e74b8d9e016a":
                wall_was_destroyed = zm_quest::function_73720cdf21c3cfd7( #"mantis_ww_quest", #"hash_8e88f59d5db46613" );
                break;
        }
        
        if ( wall_was_destroyed )
        {
            level.mantis_ww_quest.var_1e5d943acb8a2ef8.var_3d34bc001775ed61++;
            level.mantis_ww_quest.var_1e5d943acb8a2ef8.var_4cbb26d6e2e585be = 1;
            wall destructible::destroy();
        }
    }
}

// Namespace namespace_2a9676437b2f197b
// Params 1, eflags: 0x4
// Checksum 0xc4b3e413, Offset: 0x915
// Size: 0x94
function private function_81401fc764e272d4( wall_id )
{
    switch ( wall_id )
    {
        case #"hash_ee66e54b8d9dfe44":
            zm_quest::function_4eefe6de31f5ddab( #"mantis_ww_quest", #"hash_abe60d153e917a59", 1 );
            break;
        case #"hash_ee66e84b8d9e02fd":
            zm_quest::function_4eefe6de31f5ddab( #"mantis_ww_quest", #"hash_481dffe8a30f6520", 1 );
            break;
        case #"hash_ee66e74b8d9e016a":
            zm_quest::function_4eefe6de31f5ddab( #"mantis_ww_quest", #"hash_8e88f59d5db46613", 1 );
            break;
    }
}

// Namespace namespace_2a9676437b2f197b
// Params 1, eflags: 0x4
// Checksum 0xbd3d125e, Offset: 0x9b1
// Size: 0x195
function private on_wall_broken( params )
{
    quest_data = level.mantis_ww_quest.var_1e5d943acb8a2ef8;
    wall_id = self.script_noteworthy;
    
    foreach ( future_wall in level.mantis_ww_quest.var_1e5d943acb8a2ef8.future_walls )
    {
        if ( future_wall.script_noteworthy == wall_id )
        {
            future_wall destructible::destroy();
            
            if ( isdefined( future_wall.item ) )
            {
                future_wall.item setscriptablepartstate( future_wall.item.type, "visible" );
            }
            
            if ( isdefined( future_wall.ichor ) )
            {
                future_wall.ichor delete();
            }
        }
    }
    
    if ( wall_id == quest_data.var_5aeac48fc66a9173 )
    {
        utility::flag_set( "ww_wall_destroyed" );
    }
    
    function_81401fc764e272d4( wall_id );
    quest_data.var_3d34bc001775ed61++;
    
    if ( !quest_data.var_4cbb26d6e2e585be && quest_data.var_3d34bc001775ed61 == 1 )
    {
        thread function_ebcbd93731474cf7( self.origin );
    }
}

// Namespace namespace_2a9676437b2f197b
// Params 0, eflags: 0x4
// Checksum 0x65d9f740, Offset: 0xb4e
// Size: 0x202
function private spawn_items()
{
    utility::flag_wait( #"hash_d6d4f73ab7728d02" );
    quest_data = level.mantis_ww_quest.var_1e5d943acb8a2ef8;
    var_b3daf67a5a5ba863 = arraysort( quest_data.var_b3daf67a5a5ba863, undefined, &namespace_a7211835085600d5::function_47c84fef8317b8f1 );
    var_1d889a48d1b26017 = utility::callsharedfunc( #"zombie", #"get_persistent_random_seed" ) ?? randomint( 10 );
    var_5815866890b8810a = var_1d889a48d1b26017 % var_b3daf67a5a5ba863.size;
    
    for ( i = 0; i < var_b3daf67a5a5ba863.size ; i++ )
    {
        origin = var_b3daf67a5a5ba863[ i ].origin;
        angles = var_b3daf67a5a5ba863[ i ].angles;
        wall = function_b21056d585c710d( quest_data.future_walls, origin );
        
        if ( i == var_5815866890b8810a )
        {
            item = zm_quest::spawn_quest_item( origin, angles, getscriptbundle( %"hash_7c5f3d4608ece083" ) );
            
            if ( !wall destructible::is_destroyed() )
            {
                item setscriptablepartstate( item.type, "hint" );
            }
            
            thread namespace_a7211835085600d5::function_d5a2c6e5a0e2040e( item, "mantis_item_hint_light_stock", "mantis_item_hint_medium_stock" );
            quest_data.ww_part = item;
            quest_data.var_5aeac48fc66a9173 = wall.script_noteworthy;
        }
        else if ( !wall destructible::is_destroyed() )
        {
            spawnoptions = common_item::function_bc5ff2958b71a708( origin, angles );
            spawnoptions.var_fd47e835523b473f = 1;
            spawnoptions.critical = 1;
            item = common_item::function_61c2c0251e742ffd( %"itemspawnentry:zm_t10_item_essence_small_200", 200, spawnoptions );
            item setscriptablepartstate( item.type, "hidden" );
        }
        
        wall.item = item;
        wall.item_offset = origin - wall.origin;
    }
}

// Namespace namespace_2a9676437b2f197b
// Params 1, eflags: 0x4
// Checksum 0x1e020479, Offset: 0xd58
// Size: 0xf4
function private get_linked_wall( wall )
{
    quest_data = level.mantis_ww_quest.var_1e5d943acb8a2ef8;
    past_walls = quest_data.past_walls;
    future_walls = quest_data.future_walls;
    var_cd5ce912cef1f5f2 = arraycontains( past_walls, wall ) ? future_walls : past_walls;
    
    foreach ( found_wall in var_cd5ce912cef1f5f2 )
    {
        if ( wall.script_noteworthy == found_wall.script_noteworthy )
        {
            return found_wall;
        }
    }
}

// Namespace namespace_2a9676437b2f197b
// Params 1, eflags: 0x4
// Checksum 0xafdf1af5, Offset: 0xe55
// Size: 0x7d
function private function_f9b91f79e464401b( params )
{
    if ( params.scriptable != level.mantis_ww_quest.var_1e5d943acb8a2ef8.ww_part )
    {
        return;
    }
    
    zm_quest::show_splash_item_picked_up( #"mantis_ww_quest", #"sat_zm_quest_mantis_wwq_stock", 1, self );
    utility::flag_set( "ww_part_stock_picked_up" );
    level thread battlechatter_mp::trysaylocalsound( params.player, #"bc_flavor_player_positive" );
}

// Namespace namespace_2a9676437b2f197b
// Params 1, eflags: 0x4
// Checksum 0xcbb848cb, Offset: 0xeda
// Size: 0x88
function private function_ebcbd93731474cf7( location )
{
    utility::flag_waitopen( "mantis_vo_twins_banter_active" );
    utility::flag_set( "mantis_vo_twins_banter_active" );
    twins_banter = randomint( 2 );
    
    if ( twins_banter == 0 )
    {
        playsoundatpos( location, "dx_zm_mawn_mntw_lvtw_mw1brkwla1ln1" );
        wait 3;
        playsoundatpos( location, "dx_zm_mawn_mntw_detw_mw1brkwla1ln2" );
        wait 4;
    }
    else
    {
        playsoundatpos( location, "dx_zm_mawn_mntw_detw_mw1brkwla2ln1" );
        wait 5;
        playsoundatpos( location, "dx_zm_mawn_mntw_lvtw_mw1brkwla2ln2" );
        wait 4;
    }
    
    utility::flag_clear( "mantis_vo_twins_banter_active" );
}

// Namespace namespace_2a9676437b2f197b
// Params 0
// Checksum 0x85148485, Offset: 0xf6a
// Size: 0x270, Type: bool
function function_bcdd8958faa3f63b()
{
    if ( zm_quest::is_quest_step_complete( #"mantis_ww_quest", #"hash_d1f2694a69086659" ) )
    {
        return false;
    }
    
    self endon( #"hash_2c4eefaf7e2b24b6" );
    quest_data = level.mantis_ww_quest.var_1e5d943acb8a2ef8;
    
    foreach ( past_wall in quest_data.past_walls )
    {
        if ( past_wall.script_noteworthy == quest_data.var_5aeac48fc66a9173 )
        {
            linked_wall = get_linked_wall( past_wall );
            objective_mark_position = isdefined( linked_wall.item_offset ) ? past_wall.origin + linked_wall.item_offset : past_wall.origin;
            thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_c2883441cd054c54", 1 );
            namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", objective_mark_position, "wwq_mark_breakable_wall", 5, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_c2883441cd054c54" } );
            utility::flag_wait( "ww_wall_destroyed" );
        }
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    
    if ( isdefined( quest_data.ww_part ) )
    {
        thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_c2883741cd05516d", 1 );
        namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.ww_part.origin, "wwq_mark_stock", 10, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_c2883741cd05516d" } );
        utility::flag_wait( "ww_part_stock_picked_up" );
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    return true;
}

