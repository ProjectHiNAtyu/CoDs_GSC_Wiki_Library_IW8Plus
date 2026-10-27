// scripts\mp\ob\activities\ob_activity_rush.gsc  (hash_44512582115da01c.gscc) (size: 23341 Bytes / 0x5b2d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc47768 (230979432)
// size ...... 23341 (0x5b2d)
// includes .. 39  (offset: 0x5549)
// strings ... 59  (offset: 0x5681)
// dev strs .. 32  (offset: 0x59a1)
// exports ... 62  (offset: 0x3721)
// cseg ...... 0x4bd + 0x3264 (0x3721)
// imports ... 174 (offset: 0x40d1)
// animtree1 . 0   (offset: 0x5b2d)
// animtree2 . 0   (offset: 0x5b2d)
#using script_16ea1b94f0f381b3;
#using script_3edd59d0d3fc3262;
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\equipment\landmine;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\at_mine;
#using scripts\mp\common\supers\landmine_mp;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\emp_debuff;
#using scripts\mp\loot\common_cache;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_rush;

// Namespace ob_activity_rush
// Params 0, eflags: 0x5
// Checksum 0x828e9f50, Offset: 0x4db
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_60c6610745911dfb", #"activity_common", &function_ea5e8f08d5ad673b, undefined );
}

// Namespace ob_activity_rush
// Params 0, eflags: 0x4
// Checksum 0x57d1f686, Offset: 0x504
// Size: 0x13
function private function_ea5e8f08d5ad673b()
{
    activity_common::registeractivitytype( "REV_OB_RUSH", &rush_activity_type_init );
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0x99f9cff6, Offset: 0x51f
// Size: 0x19d
function rush_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_RUSH", 0, &rush_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_RUSH", 1, &rush_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_RUSH", 2, &rush_activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_RUSH", 3, &rush_activity_destroy );
    activity_common::function_944074f3079c1d4e( "REV_OB_RUSH", 4, &function_2ab19b4050f2daa8 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &rush_player_joined_activity, "REV_OB_RUSH" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &rush_player_left_activity, "REV_OB_RUSH" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_5be42cb831f8899e, "REV_OB_RUSH" );
    utility::registersharedfunc( #"rush_activity", #"hash_ca89108500931062", &function_ab4bd54e8d6bdd56 );
    utility::registersharedfunc( #"rush_activity", #"hash_21865e91bbe91f42", &function_8ad5ad04a4fb83ec );
    utility::registersharedfunc( #"rush_activity", #"hash_9b8883333137f592", &function_d98c440afd38b20 );
    utility::registersharedfunc( #"rush_activity", #"hash_1696460b6fd16672", &function_c3a1d427fbaa5929 );
    utility::registersharedfunc( #"rush_activity", #"hash_7c46e0eba7b87d1f", &function_fe68b6c682b5f13c );
    utility::registersharedfunc( #"rush_activity", #"hash_654756dcb26260ad", &function_163e42f49383891a );
    utility::registersharedfunc( #"rush_activity", #"hash_e74a4c4cb94d0ad0", &function_babd34fe09dc1bdc );
    utility::registersharedfunc( #"rush_activity", #"hash_a3a16920ec351b48", &ob_resource_manager::activity_spawn_vehicle );
    
    /#
        level thread function_516bf0602f9e6263();
    #/
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0xebc889, Offset: 0x6c4
// Size: 0x29e
function rush_activity_setup()
{
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    self.a_vh_convoy = [];
    self.a_ai_convoy = [];
    self.a_loot_caches = [];
    self.nd_spline_start = undefined;
    self.a_players_notified = [];
    self.spawned_vehicles = [];
    self.agents = [];
    self.mines = [];
    self.handler_list = [ "karm", "mars" ];
    self.villain_list = [ "anti", "oney" ];
    goal_triggers = getnoentvolumearray( self.varianttag + "_goal", #targetname );
    assert( goal_triggers.size > 0, "<dev string:x24>" );
    self.goal = goal_triggers[ 0 ];
    disarm_triggers = getnoentvolumearray( self.varianttag + "_disarm", #targetname );
    assert( disarm_triggers.size > 0, "<dev string:x41>" );
    self.disarm_trigger = disarm_triggers[ 0 ];
    high_value_vehicle_spawns = utility::getstructarray( self.varianttag + "_vehicle_spawn", "targetname" );
    assert( high_value_vehicle_spawns.size > 0, "<dev string:x66>" );
    self.hvv_spawn = high_value_vehicle_spawns[ 0 ];
    self.script_link = utility::getstruct( self.varianttag + "_link" );
    function_65c524279eb4eb6b( activityvariantdefinition );
    
    if ( self.script_link )
    {
        thread function_3e52e23bd090bfb5();
    }
    
    self.str_stealth_group = "sg_" + self.varianttag;
    
    if ( !isdefined( function_ff2498f19618e5fa( self.str_stealth_group ) ) )
    {
        stealthinitgroup( self.str_stealth_group );
    }
    
    spatial_zone_container::function_11cd1f1428a0af78( 0, &function_2ea6d063a94e7036 );
    function_9a6506ba2f9fef9c();
    
    if ( !self.var_83e013bcaf310285 )
    {
        return;
    }
    
    self.var_2ceffa90a800662c.minspeed = self.var_83e013bcaf310285 vehicle_gettopspeedforward() * self.var_2ceffa90a800662c.var_b7ab4eabcb1704f0;
    self.var_2ceffa90a800662c.var_b1532353f6f699d7 = 25000000;
    self.var_2ceffa90a800662c.is_in_vehicle = 0;
    self.roadblocks = utility::getstructarray( self.varianttag + "_roadblock", "script_noteworthy" );
    self.var_2ceffa90a800662c.var_6aad71e9d7d3a33a = 0;
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0x2db81ffe, Offset: 0x96a
// Size: 0x3c
function rush_activity_begin()
{
    thread function_4cfe3fe4281b4f78();
    thread function_7662b641adc4081();
    thread function_dd64f3c898af888d();
    thread function_8eb6f685a87b8cac();
    
    /#
        thread function_8eeb50e8ea4082ae( "<dev string:x97>", 5, ( 1, 1, 0 ) );
    #/
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0xe8cfc110, Offset: 0x9ae
// Size: 0x2
function rush_activity_end()
{
    
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0x2518e747, Offset: 0x9b8
// Size: 0x187
function rush_activity_complete( success )
{
    if ( success )
    {
        activity_definition_utils::updateprogress( 1, self );
        
        /#
            thread function_8eeb50e8ea4082ae( "<dev string:xa8>", 5, ( 0, 1, 0 ) );
        #/
        
        var_49167480b31d844b = 3;
        var_a36a123d827025e1 = self.var_e90fa0d985dd486d;
        common_cache::fillcontentsfromlist( self.var_83e013bcaf310285.var_7efd2ef630bd1000, var_a36a123d827025e1, var_49167480b31d844b );
        thread ob_activity_vo_utility::function_639b0047db8aec67( self, "rush_success" );
        
        foreach ( player in self.playerparticipants )
        {
            if ( story_contract_util::is_activity_completed( player, #"libra_complete" ) )
            {
                thread ob_activity_vo_utility::function_5e9786e501cd7383( self, "rush_success", [ player ] );
            }
        }
        
        activity_instance_common::endactivity( self, 1 );
    }
    else
    {
        /#
            thread function_8eeb50e8ea4082ae( "<dev string:xbb>", 5, ( 1, 0, 0 ) );
        #/
        
        if ( self.fail_damage )
        {
            thread ob_activity_vo_utility::function_639b0047db8aec67( self, "rush_fail_damage" );
        }
        else
        {
            thread ob_activity_vo_utility::function_639b0047db8aec67( self, "rush_fail" );
        }
    }
    
    self.goal function_ce168ef171df1112( 0 );
    activity_instance_common::endactivity( self, success );
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0x8a09120b, Offset: 0xb47
// Size: 0x1bb
function rush_activity_destroy()
{
    if ( isdefined( self.a_loot_caches ) )
    {
        foreach ( loot_cache in self.a_loot_caches )
        {
            loot_cache thread ob_activity_utility::function_16f13e7feb0abb24( 3000, 30 );
        }
    }
    
    thread activity_ai_encounters::function_cb88eba0bb17a5e4();
    
    if ( isdefined( self.spawned_vehicles ) )
    {
        foreach ( vehicle in self.spawned_vehicles )
        {
            if ( !vehicle.istarget )
            {
                vehicle thread ob_activity_utility::function_16f13e7feb0abb24( 3000, 30 );
            }
        }
    }
    
    if ( isdefined( self.mines ) )
    {
        foreach ( mine in self.mines )
        {
            function_de2311f2a2993e6f( mine, self );
        }
        
        self.mines = undefined;
    }
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0x288bfae2, Offset: 0xd0a
// Size: 0x4e
function function_2ab19b4050f2daa8()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    centerpoint = undefined;
    
    if ( isalive( self.var_83e013bcaf310285 ) )
    {
        centerpoint = self.var_83e013bcaf310285.origin;
    }
    
    return centerpoint;
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0xed118f68, Offset: 0xd61
// Size: 0x35f
function function_65c524279eb4eb6b( rushparams )
{
    self.var_8ac4adf7bae6f45a = region_difficulty_manager::get_region_difficulty( self.hvv_spawn.origin );
    
    if ( self.var_8ac4adf7bae6f45a == "difficulty_undefined" )
    {
        self.var_8ac4adf7bae6f45a = getdvar( @"hash_eeee9d0851048b87", "difficulty_easy" );
    }
    
    if ( !isdefined( self.ai_team ) )
    {
        self.ai_team = "team_hundred_ninety";
    }
    
    if ( !isdefined( self.slowspeed ) )
    {
        self.slowspeed = 12;
    }
    
    if ( !isdefined( self.highspeed ) )
    {
        self.highspeed = 25;
    }
    
    if ( !isdefined( self.var_e90fa0d985dd486d ) )
    {
        self.var_e90fa0d985dd486d = "ob_sat_items_activity_rush_cache";
    }
    
    if ( !isdefined( self.var_ef091d37dff54373 ) )
    {
        self.var_ef091d37dff54373 = "sat_ob_loot_cache";
    }
    
    self.var_8c0b9efa3145cbb4 = istrue( rushparams.var_8c0b9efa3145cbb4 );
    self.disablecaralarm = rushparams.disablecaralarm;
    self.var_85991905917e913d = 0;
    
    if ( !isdefined( self.var_6659ca8173670617 ) )
    {
        self.var_6659ca8173670617 = "EXIT_VEHICLE";
    }
    
    self.defaultspeed = self.slowspeed;
    self.var_2ceffa90a800662c = { #roadblock:{}, #bomb_armed:0 };
    self.var_2ceffa90a800662c.var_26a0e94732f673e2 = rushparams.var_83e013bcaf310285.vehicle;
    self.var_2ceffa90a800662c.var_26afa8707c38a27a = rushparams.var_83e013bcaf310285.encounter;
    self.var_2ceffa90a800662c.roadblock.vehicle_ref = rushparams.roadblock.vehicle;
    self.var_2ceffa90a800662c.roadblock.ai_encounter = rushparams.roadblock.encounter;
    self.var_2ceffa90a800662c.roadblock.rocketeer_encounter = rushparams.rocketeerencounter;
    self.var_2ceffa90a800662c.roadblock.mine_reference = rushparams.minescriptable;
    self.var_2ceffa90a800662c.roadblock.mine_equipment = rushparams.var_fcc580bbf02a6803;
    self.var_2ceffa90a800662c.roadblock.mine_radius = rushparams.minedamageradius;
    self.var_2ceffa90a800662c.roadblock.var_6b8acedd296bf16e = rushparams.minedamagemax;
    self.var_2ceffa90a800662c.roadblock.mine_damage_min = rushparams.minedamagemin;
    self.var_2ceffa90a800662c.var_847388479f87ad84 = rushparams.var_847388479f87ad84;
    self.var_2ceffa90a800662c.var_9d56eae153da0d27 = rushparams.var_9d56eae153da0d27;
    self.var_2ceffa90a800662c.var_b7ab4eabcb1704f0 = rushparams.var_96077c1fe7b3b28;
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0x25669f5b, Offset: 0x10c8
// Size: 0x8
function function_ab4bd54e8d6bdd56()
{
    return function_9da4d075f8c983e0();
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0xccd7f47c, Offset: 0x10d9
// Size: 0x14
function function_8ad5ad04a4fb83ec( var_fbc9b9a942a814f9 )
{
    return function_dbd80f92b5ca3388( var_fbc9b9a942a814f9 );
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0x9e20f64a, Offset: 0x10f6
// Size: 0x14
function function_d98c440afd38b20( var_fbc9b9a942a814f9 )
{
    return function_b1ec0f6471f92f5c( var_fbc9b9a942a814f9 );
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0xa89dc4e6, Offset: 0x1113
// Size: 0x15
function function_9da4d075f8c983e0()
{
    return self.var_c8ee5a53f2f41b41.var_85991905917e913d;
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0x8d721a30, Offset: 0x1131
// Size: 0x56
function function_dbd80f92b5ca3388( var_fbc9b9a942a814f9 )
{
    assert( var_fbc9b9a942a814f9 >= 0 && var_fbc9b9a942a814f9 < self.var_c8ee5a53f2f41b41.var_85991905917e913d, "<dev string:xcb>" + var_fbc9b9a942a814f9 + "<dev string:xed>" );
    return self.var_c8ee5a53f2f41b41.var_c466184829df94f0[ var_fbc9b9a942a814f9 ];
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0xa4c062df, Offset: 0x1190
// Size: 0x56
function function_b1ec0f6471f92f5c( var_fbc9b9a942a814f9 )
{
    assert( var_fbc9b9a942a814f9 >= 0 && var_fbc9b9a942a814f9 < self.var_c8ee5a53f2f41b41.var_85991905917e913d, "<dev string:xcb>" + var_fbc9b9a942a814f9 + "<dev string:xed>" );
    return self.var_c8ee5a53f2f41b41.vehiclerefs[ var_fbc9b9a942a814f9 ];
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0xe896392a, Offset: 0x11ef
// Size: 0x71
function function_2ea6d063a94e7036( var_54c779cf281bb58d )
{
    activity_type = activity_instance_common::getactivitytype( self );
    
    if ( activity_type == "REV_OB_RUSH" )
    {
        if ( var_54c779cf281bb58d.enteredzone && var_54c779cf281bb58d.firsttimeinzone && !self.convoy_engaged )
        {
            player_list = [];
            player_list[ player_list.size ] = var_54c779cf281bb58d.player;
        }
    }
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0xd97466f5, Offset: 0x1268
// Size: 0x4e
function function_4cfe3fe4281b4f78()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    trigger::makeenterexittrigger( self.goal, &function_522f8bbe82cab9db, undefined, undefined, undefined, undefined, self );
    trigger::makeenterexittrigger( self.disarm_trigger, &function_6b51cdcb5cf0fc82, undefined, undefined, undefined, undefined, self );
}

// Namespace ob_activity_rush
// Params 0, eflags: 0x4
// Checksum 0x34425fa5, Offset: 0x12be
// Size: 0xcd
function private function_25601298d78218a1()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    foreach ( roadblock in self.roadblocks )
    {
        thread function_6b8ee9a7a3f4b9d0( roadblock, self.var_2ceffa90a800662c.roadblock.vehicle_ref, self.var_2ceffa90a800662c.roadblock.ai_encounter );
    }
}

// Namespace ob_activity_rush
// Params 3, eflags: 0x4
// Checksum 0x85602a7f, Offset: 0x1393
// Size: 0x1e7
function private function_6b8ee9a7a3f4b9d0( base_node, vehicle_to_spawn, encounter_to_spawn )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    spawned_encounters = 0;
    nodes = utility::getstructarray( base_node.targetname, "target" );
    nodes[ nodes.size ] = base_node;
    
    foreach ( node in nodes )
    {
        switch ( node.script_noteworthy )
        {
            case #"hash_b9c0ff6cd406fe0f":
                assert( isdefined( vehicle_to_spawn ), "<dev string:xf0>" );
                
                if ( vehicle_to_spawn )
                {
                    rush_spawn_vehicle( node, vehicle_to_spawn, self.aiteam, 1 );
                }
                
                break;
            case #"hash_44356c8ead4f425a":
                assert( isdefined( encounter_to_spawn ), "<dev string:x124>" );
                
                if ( encounter_to_spawn )
                {
                    thread function_58a1c776be699179( node, encounter_to_spawn );
                    spawned_encounters++;
                }
                
                break;
            case #"hash_573109a518f305c7":
                assert( self.var_2ceffa90a800662c.roadblock.rocketeer_encounter, "<dev string:x15c>" );
                
                if ( self.var_2ceffa90a800662c.roadblock.rocketeer_encounter )
                {
                    thread function_58a1c776be699179( node, self.var_2ceffa90a800662c.roadblock.rocketeer_encounter );
                    spawned_encounters++;
                }
                
                break;
        }
    }
    
    if ( encounter_to_spawn && spawned_encounters == 0 )
    {
        thread function_58a1c776be699179( base_node, encounter_to_spawn );
    }
}

// Namespace ob_activity_rush
// Params 0, eflags: 0x4
// Checksum 0xd29f1185, Offset: 0x1582
// Size: 0xce
function private function_9a6506ba2f9fef9c()
{
    function_6b8ee9a7a3f4b9d0( self.hvv_spawn, self.var_2ceffa90a800662c.var_26a0e94732f673e2, self.var_2ceffa90a800662c.var_26afa8707c38a27a );
    
    if ( self.spawned_vehicles.size == 0 )
    {
        return;
    }
    
    self.var_83e013bcaf310285 = self.spawned_vehicles[ 0 ];
    self.var_83e013bcaf310285 thread function_3906f1e0fcb72116( self );
    self.var_83e013bcaf310285 thread rush_vehicle_death_watcher( self );
    
    if ( utility::issharedfuncdefined( #"rush_activity", #"hash_e74a4c4cb94d0ad0" ) )
    {
        self.var_83e013bcaf310285.lootcache = utility::callsharedfunc( #"rush_activity", #"hash_e74a4c4cb94d0ad0", self.var_83e013bcaf310285 );
    }
}

// Namespace ob_activity_rush
// Params 4, eflags: 0x4
// Checksum 0x17090242, Offset: 0x1658
// Size: 0x16c
function private rush_spawn_vehicle( node, vehicle_ref, var_de67d5ccec36543a, set_parking_brake )
{
    spawn_data = { #triggerrecycle:1, #var_499a16b493ff31ed:1, #initai:0, #team:var_de67d5ccec36543a, #angles:node.angles, #origin:node.origin };
    spawn_data vehicle_spawn::prevent_respawn();
    spawn_fail = {};
    vehicle = undefined;
    
    if ( utility::issharedfuncdefined( #"rush_activity", #"hash_a3a16920ec351b48" ) )
    {
        vehicle = utility::callsharedfunc( #"rush_activity", #"hash_a3a16920ec351b48", vehicle_ref, spawn_data, spawn_fail );
    }
    else
    {
        vehicle = vehicle::spawn( vehicle_ref, spawn_data );
    }
    
    assert( isdefined( vehicle ), "<dev string:x19e>" );
    
    if ( self.disablecaralarm )
    {
        vehicle.playedcaralarm = 1;
    }
    
    vehicle_occupancy::set_team( vehicle, var_de67d5ccec36543a );
    vehicle.var_a5f34fcc4fb8b328 = 1;
    
    if ( !isdefined( self.spawned_vehicles ) )
    {
        self.spawned_vehicles = [];
    }
    
    self.spawned_vehicles[ self.spawned_vehicles.size ] = vehicle;
    
    if ( set_parking_brake )
    {
        vehicle vehicle_ai::set_parking_brake( 1 );
    }
}

// Namespace ob_activity_rush
// Params 2
// Checksum 0x7131e459, Offset: 0x17cc
// Size: 0xbf
function function_58a1c776be699179( node, encounter )
{
    assert( isdefined( node ), "<dev string:x1b7>" );
    assert( isdefined( encounter ), "<dev string:x1eb>" );
    node.ai_request_id = activity_ai_encounters::function_eb8506829193f5eb( encounter, node.origin, 128, 1, 0, 1, 0 );
    
    if ( isdefined( node.ai_request_id ) )
    {
        ai_spawn_director::add_spawned_callback( node.ai_request_id, &function_3fbad4d9db445d0f, self );
        activity_ai_encounters::function_48582991402cac50( node.ai_request_id, 1 );
        function_64ac8c4e752f4dca( node.ai_request_id, 0 );
        ai_spawn_director::function_3ce5298df1143d67( "FinishedSpawningBucket", node.ai_request_id );
    }
}

// Namespace ob_activity_rush
// Params 4, eflags: 0x4
// Checksum 0x46c78212, Offset: 0x1893
// Size: 0x42
function private function_3fbad4d9db445d0f( request_id, activity_instance, agent, data )
{
    activity_instance.agents[ activity_instance.agents.size ] = agent;
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0x9052adcc, Offset: 0x18dd
// Size: 0x114
function function_3906f1e0fcb72116( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"leavepath_unload" );
    self endon( #"engage" );
    var_2747cdcc610c7fd4 = [];
    
    while ( true )
    {
        if ( self.isdestroyed )
        {
            return;
        }
        
        if ( activityinstance.fail_damage )
        {
            return;
        }
        
        if ( self.health < self.maxhealth * 0.65 && !self.lightbroadcast )
        {
            self.lightbroadcast = 1;
            thread ob_activity_vo_utility::function_639b0047db8aec67( activityinstance, "rush_damage_light" );
        }
        else if ( self.health < self.maxhealth * 0.25 && !self.heavybroadcast )
        {
            self.heavybroadcast = 1;
            thread ob_activity_vo_utility::function_639b0047db8aec67( activityinstance, "rush_damage_heavy" );
            break;
        }
        
        waitframe();
    }
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0xb031bef9, Offset: 0x19f9
// Size: 0x74
function rush_vehicle_death_watcher( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"entitydeleted" );
    self waittill( #"death" );
    earthquake( 0.5, 1, self.origin, 1024 );
    
    if ( self == activityinstance.var_83e013bcaf310285 )
    {
        activityinstance rush_activity_complete( 0 );
    }
}

// Namespace ob_activity_rush
// Params 0, eflags: 0x4
// Checksum 0x112eddfa, Offset: 0x1a75
// Size: 0x20b
function private function_7662b641adc4081()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"under_attack" );
    self endon( #"hash_e8f0709128e49dd2" );
    self endon( #"hash_515b5bdfddc2a3f3" );
    
    while ( !self.convoy_engaged )
    {
        array = self.a_vh_convoy;
        
        foreach ( member in array )
        {
            if ( isdefined( member ) )
            {
                players = player_utility::script_getplayersinradius( member.origin, 1500 );
                
                if ( players.size > 0 )
                {
                    foreach ( player in players )
                    {
                        if ( !player.notarget )
                        {
                            var_8eba82ead0f19157 = trace::ray_trace_passed( player geteye(), member.origin + ( 0, 0, 30 ), [ player, member ] );
                            
                            if ( var_8eba82ead0f19157 == 1 )
                            {
                                if ( utility::issharedfuncdefined( #"rush_activity", #"hash_7c46e0eba7b87d1f" ) )
                                {
                                    utility::callsharedfunc( #"rush_activity", #"hash_7c46e0eba7b87d1f", self, 1 );
                                }
                                else
                                {
                                    thread activity_player_broadcasting::function_cb4750c84882dd07( "activity_armored_convoy_engage_enemy_broadcast" );
                                }
                                
                                self notify( #"hash_e8f0709128e49dd2" );
                                break;
                            }
                        }
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0xa4879d1, Offset: 0x1c88
// Size: 0xc9
function function_dd64f3c898af888d()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"ai_combat" );
    
    while ( true )
    {
        foreach ( ai in self.a_ai_convoy )
        {
            if ( isalive( ai ) && ai isincombat() )
            {
                self.var_ea5b7a595a1f4f3 = 1;
                self notify( #"ai_combat" );
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0xd39f1fd4, Offset: 0x1d59
// Size: 0xc2
function function_8eb6f685a87b8cac()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    self.var_2ceffa90a800662c.var_f915ade8ed73dafa = undefined;
    
    while ( self.var_83e013bcaf310285 )
    {
        var_2bb7e149bc229306 = vehicle_occupancy::get_driver( self.var_83e013bcaf310285, 1 );
        
        if ( ( isdefined( self.var_2ceffa90a800662c.var_f915ade8ed73dafa ) || isdefined( var_2bb7e149bc229306 ) ) && var_2bb7e149bc229306 != self.var_2ceffa90a800662c.var_f915ade8ed73dafa )
        {
            function_1a38fc108ae4e708( var_2bb7e149bc229306 );
            self.var_2ceffa90a800662c.var_f915ade8ed73dafa = var_2bb7e149bc229306;
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_rush
// Params 1, eflags: 0x4
// Checksum 0x9d4b7462, Offset: 0x1e23
// Size: 0x8b
function private function_1a38fc108ae4e708( driver )
{
    if ( !self.var_2ceffa90a800662c.var_6aad71e9d7d3a33a )
    {
        if ( driver )
        {
            thread function_4eb940b00d711ae( driver );
            self.var_2ceffa90a800662c.is_in_vehicle = 1;
            thread ob_activity_vo_utility::function_639b0047db8aec67( self, "rush_acquire" );
        }
        
        return;
    }
    
    if ( !driver )
    {
        function_40e4399d37d6f09e( 0 );
    }
    
    self.var_2ceffa90a800662c.is_in_vehicle = isdefined( driver );
    
    /#
        function_8eeb50e8ea4082ae( "<dev string:x21c>" );
    #/
}

// Namespace ob_activity_rush
// Params 1, eflags: 0x4
// Checksum 0x924dd0de, Offset: 0x1eb6
// Size: 0xc4
function private function_4eb940b00d711ae( player )
{
    activity_participation::function_bc67362dace4370c( self, player );
    waitframe();
    
    foreach ( mine in self.mines )
    {
        level thread function_649393ba80d8c549( mine, self );
    }
    
    thread function_a5e78f80f7084627();
    thread function_4e7370a6b07a1d6d();
    thread function_83916dceb85f3c60();
    thread function_25601298d78218a1();
    self.var_2ceffa90a800662c.var_6aad71e9d7d3a33a = 1;
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0x51e3cda6, Offset: 0x1f82
// Size: 0xe4
function function_83916dceb85f3c60()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    for ( i = self.var_2ceffa90a800662c.var_847388479f87ad84; i > 0 ; i-- )
    {
        /#
            function_8eeb50e8ea4082ae( "<dev string:x22c>" + i, 1, ( 1, 1, 0 ) );
        #/
        
        wait 1;
    }
    
    self.var_2ceffa90a800662c.bomb_armed = 1;
    self notify( #"rush_bomb_armed" );
    
    /#
        function_8eeb50e8ea4082ae( "<dev string:x245>", 5, ( 1, 1, 1 ) );
        function_8eeb50e8ea4082ae( "<dev string:x280>", 5, ( 1, 1, 1 ) );
    #/
    
    if ( self.var_2ceffa90a800662c.is_in_vehicle )
    {
        function_40e4399d37d6f09e( 1 );
    }
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0x2752859e, Offset: 0x206e
// Size: 0x9f
function function_3ad6fdd612624394()
{
    if ( self.var_2ceffa90a800662c.bomb_armed )
    {
        self.var_2ceffa90a800662c.bomb_armed = 0;
        self.disarm_trigger function_ce168ef171df1112( 0 );
        self notify( #"hash_22635f617da5fcd2" );
        
        /#
            function_8eeb50e8ea4082ae( "<dev string:x2ba>", 5, ( 1, 1, 1 ) );
            function_8eeb50e8ea4082ae( "<dev string:x2d9>", 5, ( 1, 1, 1 ) );
        #/
        
        if ( self.var_2ceffa90a800662c.is_in_vehicle )
        {
            function_40e4399d37d6f09e( 0 );
        }
    }
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0xed57256, Offset: 0x2115
// Size: 0x1a9
function function_4e7370a6b07a1d6d()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"hash_22635f617da5fcd2" );
    self waittill( #"rush_bomb_armed" );
    var_b83e873ca2013e32 = self.var_2ceffa90a800662c.var_9d56eae153da0d27;
    var_43a11dca52d1855a = max( var_b83e873ca2013e32 * 0.6, 2 );
    var_9fb50625f1f712e6 = 0;
    
    while ( self.var_2ceffa90a800662c.bomb_armed && var_b83e873ca2013e32 > 0 )
    {
        tickrate = 1;
        
        if ( !self.var_2ceffa90a800662c.bomb_armed )
        {
            break;
        }
        
        currentspeed = self.var_83e013bcaf310285 vehicle_getspeed();
        currenttime = gettime();
        isurgent = var_b83e873ca2013e32 <= var_43a11dca52d1855a;
        shouldplaysound = currenttime > var_9fb50625f1f712e6 + 3000;
        var_9fb50625f1f712e6 = shouldplaysound ? currenttime : var_9fb50625f1f712e6;
        thread function_dd5f3438afb93575( currentspeed, var_b83e873ca2013e32, shouldplaysound );
        var_59bb5e7e38b99ed2 = 1;
        
        if ( currentspeed <= self.var_2ceffa90a800662c.minspeed )
        {
            var_59bb5e7e38b99ed2 = 2;
            var_b83e873ca2013e32 -= 1;
        }
        else
        {
            var_b83e873ca2013e32 = self.var_2ceffa90a800662c.var_9d56eae153da0d27;
        }
        
        if ( self.var_2ceffa90a800662c.is_in_vehicle )
        {
            function_40e4399d37d6f09e( var_59bb5e7e38b99ed2 );
        }
        
        wait 1;
    }
    
    if ( self.var_2ceffa90a800662c.bomb_armed && var_b83e873ca2013e32 <= 0 )
    {
        rush_explode();
    }
}

// Namespace ob_activity_rush
// Params 4, eflags: 0x4
// Checksum 0xb6d921a6, Offset: 0x22c6
// Size: 0xdc
function private function_dd5f3438afb93575( currentspeed, var_b83e873ca2013e32, var_1696a649a3bb5b78, isurgent )
{
    if ( currentspeed > self.var_2ceffa90a800662c.minspeed * 1.05 )
    {
        return;
    }
    
    if ( !self.var_91034df63378790f && var_1696a649a3bb5b78 )
    {
        thread ob_activity_vo_utility::function_639b0047db8aec67( self, "rush_time" );
        self.var_91034df63378790f = 1;
    }
    
    if ( var_1696a649a3bb5b78 && soundexists( "uin_veh_warning_low_fuel_heli" ) )
    {
        self.var_83e013bcaf310285 playsound( "uin_veh_warning_low_fuel_heli" );
    }
    
    /#
        if ( var_b83e873ca2013e32 % 1 == 0 && currentspeed <= self.var_2ceffa90a800662c.minspeed )
        {
            function_8eeb50e8ea4082ae( "<dev string:x2f5>" + var_b83e873ca2013e32, 1, ( 1, 0, 0 ) );
        }
    #/
}

// Namespace ob_activity_rush
// Params 0, eflags: 0x4
// Checksum 0xeaf94bb6, Offset: 0x23aa
// Size: 0x4b
function private rush_explode()
{
    var_e3bf53f5c6a06d96 = vehicle_damage::function_8c4b44320250db18( self.var_83e013bcaf310285 ) * 0.5;
    
    if ( function_5e6c3edad5fa66c9( self.var_83e013bcaf310285, var_e3bf53f5c6a06d96 ) )
    {
        thread rush_explosion_damage( var_e3bf53f5c6a06d96 );
        self.fail_damage = 1;
    }
}

// Namespace ob_activity_rush
// Params 2, eflags: 0x4
// Checksum 0x87e85271, Offset: 0x23fd
// Size: 0x2a, Type: bool
function private function_5e6c3edad5fa66c9( vehicle, target_health )
{
    if ( vehicle.health <= target_health )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_activity_rush
// Params 1, eflags: 0x4
// Checksum 0xd2be82d1, Offset: 0x2430
// Size: 0x68
function private rush_explosion_damage( target_health )
{
    damage_to_vehicle = max( int( self.var_83e013bcaf310285.health - target_health ), 0 );
    
    if ( damage_to_vehicle > 0 )
    {
        self.var_83e013bcaf310285 dodamage( damage_to_vehicle, self.var_83e013bcaf310285.origin, undefined, undefined, "MOD_CRUSH" );
    }
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0xddaee009, Offset: 0x24a0
// Size: 0x44
function rush_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    ob_activity_definition_utils::function_f23bdcfc447427ae( player_list, 0, 1 );
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0xb322acf5, Offset: 0x24ec
// Size: 0x5a
function rush_player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( utility::issharedfuncdefined( #"rush_activity", #"hash_1696460b6fd16672" ) )
    {
        utility::callsharedfunc( #"rush_activity", #"hash_654756dcb26260ad", self, relevant_info_struct );
    }
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0xe64b8a60, Offset: 0x254e
// Size: 0x66
function function_5be42cb831f8899e( relevant_info_struct )
{
    /#
        function_8eeb50e8ea4082ae( "<dev string:x312>", 4, ( 1, 1, 1 ) );
        function_8eeb50e8ea4082ae( "<dev string:x341>", 4, ( 1, 1, 1 ) );
    #/
    
    player_list = relevant_info_struct.playerlist;
    function_c3a1d427fbaa5929( self, player_list );
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0x21d0c01c, Offset: 0x25bc
// Size: 0x7c
function function_a5e78f80f7084627()
{
    self.rush_marker_id = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "ob_rush_goal_marker", 1, 1 );
    objidpoolmanager::update_objective_position( self.rush_marker_id, self.goal.origin + ( 0, 0, 60 ) );
    namespace_d7fa4530141146a5::function_e27cc6376feeb35c( self.rush_marker_id, 1, 1 );
    self waittill( #"activity_ended" );
    namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.rush_marker_id );
}

// Namespace ob_activity_rush
// Params 3
// Checksum 0x1842c13, Offset: 0x2640
// Size: 0xcc
function function_522f8bbe82cab9db( enteringentity, trigger, payload )
{
    if ( enteringentity == payload.var_83e013bcaf310285 )
    {
        occupants = vehicle_occupancy::get_all_occupants( enteringentity );
        
        foreach ( occupant in occupants )
        {
            if ( arraycontains( payload.playerparticipants, occupant ) )
            {
                payload rush_activity_complete( 1 );
                break;
            }
        }
    }
}

// Namespace ob_activity_rush
// Params 3
// Checksum 0x476bc148, Offset: 0x2714
// Size: 0xf1
function function_6b51cdcb5cf0fc82( enteringentity, trigger, payload )
{
    if ( enteringentity == payload.var_83e013bcaf310285 && payload.var_2ceffa90a800662c.bomb_armed )
    {
        occupants = vehicle_occupancy::get_all_occupants( enteringentity );
        
        foreach ( occupant in occupants )
        {
            if ( arraycontains( payload.playerparticipants, occupant ) )
            {
                payload function_3ad6fdd612624394();
                thread ob_activity_vo_utility::function_639b0047db8aec67( payload, "rush_disarmed" );
                break;
            }
        }
    }
}

// Namespace ob_activity_rush
// Params 1
// Checksum 0x94591a98, Offset: 0x280d
// Size: 0x145
function function_babd34fe09dc1bdc( vehicle )
{
    switch ( vehicle vehicle::get_ref() )
    {
        case %"hash_26998cb1252f2866":
            var_85c1572ce2d3e84b = ( -60, 0, -10 );
            break;
        case %"hash_e2d0d366f55399e":
            var_85c1572ce2d3e84b = ( -50, 0, -10 );
            break;
        case %"hash_6fda5ac100dc84e2":
            var_85c1572ce2d3e84b = ( -60, 0, 5 );
            break;
        case %"hash_3deeb37ce7d4d30e":
            var_85c1572ce2d3e84b = ( -60, 0, 37 );
            break;
        default:
            var_85c1572ce2d3e84b = ( -50, 0, 47 );
            break;
    }
    
    e_loot_crate = spawnscriptable( self.var_ef091d37dff54373, vehicle.origin + var_85c1572ce2d3e84b );
    e_loot_crate utility::scriptable_setparententity( vehicle, var_85c1572ce2d3e84b, ( 0, 90, 0 ) );
    thread _relocate_loot_cache( vehicle );
    vehicle.var_7efd2ef630bd1000 = e_loot_crate;
    vehicle.var_7efd2ef630bd1000 setscriptablepartstate( "body", #"closed_usable_no_collision" );
    self.a_loot_caches[ self.a_loot_caches.size ] = e_loot_crate;
}

// Namespace ob_activity_rush
// Params 0, eflags: 0x4
// Checksum 0xd608ea8c, Offset: 0x295a
// Size: 0x13f
function private function_3e52e23bd090bfb5()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    activity_scriptables = getentitylessscriptablearray( self.script_link.targetname, "target" );
    assert( activity_scriptables.size > 0, "<dev string:x363>" );
    
    foreach ( var_c21aeb30cf4c0311 in activity_scriptables )
    {
        if ( var_c21aeb30cf4c0311.script_noteworthy == "mine" )
        {
            var_c21aeb30cf4c0311.allowfriendlyfire = 1;
            var_8de6f80b3674ce04 = "bp_" + self.link.targetname + "_mine_" + self.mines.size;
            function_15c689ee8f9f079e( var_c21aeb30cf4c0311, var_8de6f80b3674ce04, undefined );
            self.mines[ self.mines.size ] = var_c21aeb30cf4c0311;
        }
    }
}

// Namespace ob_activity_rush
// Params 3, eflags: 0x4
// Checksum 0x4b3e273e, Offset: 0x2aa1
// Size: 0x153
function private function_15c689ee8f9f079e( mine, var_8de6f80b3674ce04, player_trigger_radius_override )
{
    mine.bundle = self.var_2ceffa90a800662c.roadblock.mine_equipment;
    mine.radius = self.var_2ceffa90a800662c.roadblock.mine_radius;
    mine.activity_instance = self;
    
    if ( var_8de6f80b3674ce04 )
    {
        mine thread ob_soldier_util::ob_mine_badplace( var_8de6f80b3674ce04 );
    }
    
    mine.team = "team_hundred_ninety";
    mine.player_trigger_radius = player_trigger_radius_override ? player_trigger_radius_override : self.var_2ceffa90a800662c.roadblock.mine_radius;
    mine.radius = mine.player_trigger_radius;
    mine.damage_max = self.var_2ceffa90a800662c.roadblock.var_6b8acedd296bf16e;
    mine.damage_min = self.var_2ceffa90a800662c.roadblock.mine_damage_min;
    mine setscriptablepartstate( "visibility", "hide" );
    mine thread at_mine::at_mine_watch_game_end();
}

// Namespace ob_activity_rush
// Params 2, eflags: 0x4
// Checksum 0x8623ff06, Offset: 0x2bfc
// Size: 0x12b
function private function_649393ba80d8c549( mine, activityinstance )
{
    mine endon( #"mine_destroyed" );
    mine endon( #"death" );
    
    if ( activityinstance.agents.size <= 0 )
    {
        return;
    }
    
    mine.owner = activityinstance.agents[ 0 ];
    mine setscriptablepartstate( "visibility", "show", 0 );
    mine.equipmentref = "equip_at_mine";
    mine.deletefunc = &at_mine::at_mine_delete;
    mine weapon::registermine();
    mine setscriptablepartstate( "plant", "active" );
    mine.planted = 1;
    mine notify( #"mine_planted" );
    mine thread emp_debuff::set_apply_emp_callback( &landmine_mp::landmine_emp_applied );
    mine setscriptablepartstate( "arm", "active" );
    mine thread landmine::function_bcb65ad5d65b57fd();
    mine thread landmine::landmine_watch_trigger();
    mine thread function_e540475baef40d39();
    mine.weapon_name = "sat_landmine_mp";
    mine.bundle = namespace_9d8e359c3b1041e5::getsuperbundlefromoffhandweaponnamesharedfunc( mine.weapon_name );
}

// Namespace ob_activity_rush
// Params 2, eflags: 0x4
// Checksum 0xd9dec28c, Offset: 0x2d2f
// Size: 0x48
function private function_de2311f2a2993e6f( mine, activityinstance )
{
    mine setscriptablepartstate( "plant", "neutral" );
    mine setscriptablepartstate( "arm", "neutral" );
    mine setscriptablepartstate( "visibility", "hide" );
}

// Namespace ob_activity_rush
// Params 0, eflags: 0x4
// Checksum 0x14b9f382, Offset: 0x2d7f
// Size: 0x1e9
function private function_e540475baef40d39()
{
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    
    while ( true )
    {
        people = entity::function_cd55d7a649cb9c44( self.origin, 150 );
        vehicles = vehicle_getarrayinradius( self.origin, 300 );
        
        foreach ( vehicle in vehicles )
        {
            if ( vehicle.team && ( vehicle.team == self.team || vehicle.team == "neutral" ) )
            {
                vehicles = arrayremove( vehicles, vehicle );
            }
        }
        
        foreach ( person in people )
        {
            if ( person.team == self.team )
            {
                people = arrayremove( people, person );
            }
        }
        
        ents = arraycombine( people, vehicles );
        
        if ( ents.size > 0 )
        {
            self notify( #"trigger_grenade", ents );
        }
        
        waitframe();
    }
}

// Namespace ob_activity_rush
// Params 2
// Checksum 0x3dcc92a, Offset: 0x2f70
// Size: 0x92
function function_c3a1d427fbaa5929( activity_instance, player_list )
{
    foreach ( player in player_list )
    {
        ob_activity_vo_utility::function_639b0047db8aec67( self, "rush_brief", [ player ] );
    }
}

// Namespace ob_activity_rush
// Params 2
// Checksum 0xac784430, Offset: 0x300a
// Size: 0x15
function function_fe68b6c682b5f13c( activity_instance, var_7e84a1b2d6501f11 )
{
    
}

// Namespace ob_activity_rush
// Params 2
// Checksum 0xe22a2d78, Offset: 0x3027
// Size: 0x100
function function_dee09b211f23a6fd( activity_instance, var_8411d4fa278141f1 )
{
    foreach ( player in activity_instance.playerparticipants )
    {
        squadmembers = player squad_utility::getsquadmembers();
        squad_on_mission = ob_activity_vo_utility::function_9d4e8b8c2a6ccc45( 16095, "quest_s0a1t2_cnvy_vehicledestroyed", squadmembers );
        
        if ( !squad_on_mission && var_8411d4fa278141f1 )
        {
            activity_instance thread activity_player_broadcasting::function_cb4750c84882dd07( "activity_armored_convoy_vehicles_remain_broadcast", [ player ] );
        }
        else if ( !squad_on_mission )
        {
            activity_instance thread activity_player_broadcasting::function_cb4750c84882dd07( "activity_armored_convoy_vehicles_destroyed_broadcast", [ player ] );
        }
        
        player callback::callback( "on_destroy_convoy" );
    }
}

// Namespace ob_activity_rush
// Params 2
// Checksum 0x4cf7ba9, Offset: 0x312f
// Size: 0xab
function function_163e42f49383891a( activity_instance, relevant_info_struct )
{
    if ( isdefined( activity_instance ) && activity_instance.state != "Ended" )
    {
        foreach ( player in relevant_info_struct.playerlist )
        {
            player thread function_421792107922fbb2();
        }
    }
}

// Namespace ob_activity_rush
// Params 0
// Checksum 0x58d291e3, Offset: 0x31e2
// Size: 0x64
function function_421792107922fbb2()
{
    self endon( #"death_or_disconnect" );
    wait 120;
    player = self;
    
    if ( ob_activity_vo_utility::is_squad_on_mission( player, 16095 ) )
    {
        player utility::ent_flag_clear( "quest_s0a1t2_cnvy_approach" );
        player utility::ent_flag_clear( "quest_s0a1t2_cnvy_engage" );
        player utility::ent_flag_clear( "quest_s0a1t2_cnvy_vehicledestroyed" );
        player utility::ent_flag_clear( "quest_s0a1t2_cnvy_closedestconvoy" );
    }
}

// Namespace ob_activity_rush
// Params 1, eflags: 0x4
// Checksum 0x94eb9b98, Offset: 0x324e
// Size: 0x125
function private _relocate_loot_cache( vehicle )
{
    self endon( #"ActivityFailure" );
    vehicle waittill( #"death" );
    waitframe();
    
    if ( isdefined( vehicle.var_7efd2ef630bd1000 ) )
    {
        var_283b6edd23a960d9 = 1;
        vehicle.var_7efd2ef630bd1000 utility::scriptable_clearparententity();
        v_angles = vehicle.angles;
        v_pos = vehicle.origin;
        var_f8837bb47fccdf08 = utility::cointoss() ? -90 : 90;
        var_cc24f9924f24eb22 = ( 96, 0, 0 );
        var_1d71d60919352611 = v_angles + ( 0, var_f8837bb47fccdf08, 0 );
        var_953e1ee90c78cb51 = v_pos + rotatevector( var_cc24f9924f24eb22, var_1d71d60919352611 );
        v_loot_pos = getgroundposition( var_953e1ee90c78cb51, 32 );
        vehicle.var_7efd2ef630bd1000.origin = v_loot_pos;
        vehicle.var_7efd2ef630bd1000 setscriptablepartstate( "body", #"closed_usable" );
    }
}

/#

    // Namespace ob_activity_rush
    // Params 0
    // Checksum 0x81083d7b, Offset: 0x337b
    // Size: 0x34, Type: dev
    function function_516bf0602f9e6263()
    {
        wait 5;
        devgui::function_9082edeb5db93280( "<dev string:x383>" );
        devgui::add_devgui_func( "<dev string:x3b6>", "<dev string:x3dd>", &function_97e9d4101db0b6f2 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_activity_rush
    // Params 0, eflags: 0x4
    // Checksum 0x653369e2, Offset: 0x33b7
    // Size: 0x91, Type: dev
    function private function_97e9d4101db0b6f2()
    {
        logstring( "<dev string:x406>" );
        params = [];
        params[ 0 ] = "<dev string:x425>";
        params[ 1 ] = "<dev string:x42e>";
        var_4f59973c28f149d6 = [[ level.var_690cc31a674a33ec.var_2ca79148edf22998 ]]( params[ 0 ], params[ 1 ], level.players[ 0 ].origin );
        
        if ( isdefined( var_4f59973c28f149d6 ) )
        {
            [[ level.var_690cc31a674a33ec.var_6af90d5c7779f340 ]]( var_4f59973c28f149d6 );
            var_4f59973c28f149d6 thread function_41d87777b1146a93();
        }
    }

    // Namespace ob_activity_rush
    // Params 0, eflags: 0x4
    // Checksum 0x385d71d9, Offset: 0x3450
    // Size: 0x1de, Type: dev
    function private function_41d87777b1146a93()
    {
        level endon( #"game_ended" );
        pathstruct = utility::getstruct( self.name, "<dev string:x43a>" );
        var_336cee9e631eaae = [];
        loopingcomplete = 0;
        currentnode = getvehiclenode( pathstruct.script_linkto, "<dev string:x445>" );
        var_833008e1b61489db = undefined;
        var_7fcb11a5cd0459fe = undefined;
        
        while ( isdefined( currentnode ) )
        {
            var_336cee9e631eaae[ var_336cee9e631eaae.size ] = currentnode;
            
            if ( isdefined( currentnode.target ) )
            {
                cachenode = getvehiclenode( currentnode.target, "<dev string:x43a>" );
                
                foreach ( node in var_336cee9e631eaae )
                {
                    if ( node == cachenode )
                    {
                        loopingcomplete = 1;
                        break;
                    }
                }
                
                if ( !loopingcomplete )
                {
                    currentnode = cachenode;
                }
                else
                {
                    currentnode = undefined;
                    var_833008e1b61489db = var_336cee9e631eaae[ var_336cee9e631eaae.size - 1 ];
                    var_7fcb11a5cd0459fe = cachenode;
                }
                
                continue;
            }
            
            currentnode = undefined;
        }
        
        while ( true )
        {
            for ( i = 0; i < var_336cee9e631eaae.size ; i++ )
            {
                sphere( var_336cee9e631eaae[ i ].origin, 30 );
                
                if ( i < var_336cee9e631eaae.size - 1 )
                {
                    line( var_336cee9e631eaae[ i ].origin, var_336cee9e631eaae[ i + 1 ].origin );
                }
            }
            
            if ( isdefined( var_833008e1b61489db ) && isdefined( var_7fcb11a5cd0459fe ) )
            {
                line( var_833008e1b61489db.origin, var_7fcb11a5cd0459fe.origin );
            }
            
            waitframe();
        }
    }

    // Namespace ob_activity_rush
    // Params 3, eflags: 0x4
    // Checksum 0xd238b3b1, Offset: 0x3636
    // Size: 0x4f, Type: dev
    function private function_8eeb50e8ea4082ae( text, duration, textcolor )
    {
        if ( !isdefined( duration ) )
        {
            duration = 2;
        }
        
        if ( getdvarint( @"scr_debug_rush", 0 ) <= 0 )
        {
            return;
        }
        
        debug::function_9d6fee9cf5908ddc( text, textcolor, duration, 850, 350 );
    }

#/

// Namespace ob_activity_rush
// Params 1
// Checksum 0x699439f, Offset: 0x368d
// Size: 0x94
function function_40e4399d37d6f09e( value )
{
    participating_players = activity_instance_common::function_4225efca86f0dea9( self );
    
    foreach ( player in participating_players )
    {
        player setclientomnvar( "ui_rush_utv_bomb_state", value );
    }
}

