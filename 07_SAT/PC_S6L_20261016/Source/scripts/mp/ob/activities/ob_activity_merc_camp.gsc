// scripts\mp\ob\activities\ob_activity_merc_camp.gsc  (hash_59f396d64c2b4347.gscc) (size: 38445 Bytes / 0x962d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4e3fe741 (1312810817)
// size ...... 38445 (0x962d)
// includes .. 32  (offset: 0x8e2d)
// strings ... 110 (offset: 0x8f2d)
// dev strs .. 18  (offset: 0x9549)
// exports ... 81  (offset: 0x6279)
// cseg ...... 0x9d5 + 0x58a4 (0x6279)
// imports ... 252 (offset: 0x6f21)
// animtree1 . 0   (offset: 0x962d)
// animtree2 . 0   (offset: 0x962d)
#using script_2304453c69e996e2;
#using script_3455b106458253e7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\ai_behavior;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\loot\common_cache;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\ob_convoy_util;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_activity_merc_camp;

/#

    // Namespace ob_activity_merc_camp
    // Params 0
    // Checksum 0xccdfa39a, Offset: 0x9f3
    // Size: 0x5, Type: dev
    function function_98bd695a464986f8()
    {
        
    }

#/

// Namespace ob_activity_merc_camp
// Params 0, eflags: 0x5
// Checksum 0xe514ed13, Offset: 0xa00
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_merc_camp", #"activity_common", &function_581ca676231cd698, undefined );
}

// Namespace ob_activity_merc_camp
// Params 0, eflags: 0x4
// Checksum 0xef714d6e, Offset: 0xa29
// Size: 0x13
function private function_581ca676231cd698()
{
    activity_common::registeractivitytype( "REV_OB_MERC_CAMP", &merc_camp_activity_type_init );
}

// Namespace ob_activity_merc_camp
// Params 0, eflags: 0x1
// Checksum 0x11d38a6a, Offset: 0xa44
// Size: 0x1b
function autoexec merc_camp_init()
{
    level._effect[ "turret_muzflash" ] = loadfxasset( "vfx_core_muz_minigun_flash_cheap" );
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0xd90fdb52, Offset: 0xa67
// Size: 0xc0
function merc_camp_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_MERC_CAMP", 0, &merc_camp_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_MERC_CAMP", 1, &merc_camp_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_MERC_CAMP", 2, &merc_camp_activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_MERC_CAMP", 3, &merc_camp_activity_destroy );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &merc_camp_player_joined_activity, "REV_OB_MERC_CAMP" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &merc_camp_player_left_activity, "REV_OB_MERC_CAMP" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_922567a1ce765c40, "REV_OB_MERC_CAMP" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerExitedAwarenessZone", &function_d3ad44a1c30e2e6, "REV_OB_MERC_CAMP" );
    level.merc_camp_blocker_agent_throttle = throttle::throttle_initialize( "merc_camp_blocker_agent_throttle", 1, 0.5 );
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x7bce63ac, Offset: 0xb2f
// Size: 0x3ce
function merc_camp_activity_setup()
{
    self endon( #"instance_destroyed" );
    
    if ( !isdefined( level.activities.obmerccamp ) )
    {
        level.activities.obmerccamp = { #var_1045367e983ba618:0, #var_12e11e6f433f0a2a:0 };
    }
    
    if ( !level.activities.obmerccamp.var_1045367e983ba618 )
    {
        activity_common::function_2dd4f07fa5c3e911( "InstanceBegin", &function_40980edc87776a8b, "REV_OB_SUPPLY_DROP" );
        activity_common::function_2dd4f07fa5c3e911( "InstanceEnd", &function_ab91f17beffa3e53, "REV_OB_SUPPLY_DROP" );
        level.activities.obmerccamp.var_1045367e983ba618 = 1;
    }
    
    activityvariantdefinition = activity_definition_utils::function_837a0c8626c9b419();
    self.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( activityvariantdefinition );
    setdvarifuninitialized( @"hash_181e765f7a6858d2", self.var_91c91f4a631c481d.var_e965ac8995a53a89 );
    setdvarifuninitialized( @"hash_683ddaf9dc721a27", self.var_91c91f4a631c481d.var_e965a98995a533f0 );
    self.s_center = utility::getstructarray( self.varianttag, "targetname" )[ 0 ];
    
    if ( !self.s_center )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.s_center.origin );
    
    if ( self.difficulty_region == "difficulty_undefined" )
    {
        self.difficulty_region = "difficulty_easy";
    }
    
    self.var_9300db9d73a80ede = 1;
    
    switch ( self.difficulty_region )
    {
        case #"hash_7bb2cd766703d463":
            self.success_score_event = #"ob_minor_activity_complete_green";
            break;
        case #"hash_af83e47edfa8900a":
            self.var_9300db9d73a80ede = 2;
            self.success_score_event = #"ob_minor_activity_complete_yellow";
            break;
        case #"hash_5343b465e56ec9a4":
            self.success_score_event = #"ob_minor_activity_complete_red";
            break;
        case #"hash_651f76c0ad6741ec":
            self.success_score_event = #"ob_minor_activity_complete_orange";
            break;
        default:
            break;
    }
    
    self.var_2595e35f3b867fb4 = undefined;
    self.var_cd38a428a87732ce = undefined;
    self.var_1eb4548a094385c4 = [];
    self.var_7c6a14aaab8d3a32 = [];
    self.var_366bb5477d1e8e05 = [];
    self.var_3e0be2038aacf981 = [];
    self.var_b748d7198b3af123 = [];
    self.var_baa34b7d898459c7 = [];
    self.var_324ee51418b55f61 = [];
    self.n_radius = 512;
    self.var_f6acc3926b3da25e = 0;
    self.var_7972a140ba94ec1e = 0;
    self.var_772ce0ec7032e594 = 0;
    self.var_f4f91556935fc7b8 = 0;
    self.reinforce_vehicles = [];
    self.var_6710c248eab7b13e = undefined;
    self.a_vh_drone = [];
    self.var_77825b2a6902fa8d = 0;
    thread function_7470b3f6c233a325();
    thread merc_camp_setup_cover();
    thread function_8eaca4fc105939ef();
    thread function_21811bb0afce307f();
    
    if ( self.s_center.script_parameters == "only_props" )
    {
        level thread function_35f070bdae8b8d2c( self );
    }
    
    self.var_82990baca12b59e8 = 1;
    ob_activity_vo_utility::function_3844a29027b73897();
    waitframe();
    thread function_6092d36d6b04c071();
    self.var_7b3d9e1eb426ada0 = getdvarint( @"hash_7ad54859d9c698f7", 5 );
    utility::ent_flag_wait( "cover_ready" );
    
    /#
        thread function_91696900a4b41c73();
    #/
    
    if ( self.var_e7b6adbe385c7c18.scriptable )
    {
        self.var_e7b6adbe385c7c18.scriptable.activity_instance = self;
    }
    
    activity_instance_common::function_46135a69bddfec2c( self );
}

/#

    // Namespace ob_activity_merc_camp
    // Params 0
    // Checksum 0x3ef6636a, Offset: 0xf05
    // Size: 0x1c7, Type: dev
    function function_91696900a4b41c73()
    {
        level endon( #"game_ended" );
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_353abc235a10f418", 0 ) )
            {
                foreach ( agent in self.var_3e0be2038aacf981 )
                {
                    sphere( agent.origin, 35, ( 1, 0, 0 ), 0, 1 );
                    line( agent.origin, self.s_center.origin, ( 1, 0, 0 ), 1, 0, 1 );
                }
                
                foreach ( agent in self.var_b748d7198b3af123 )
                {
                    sphere( agent.origin, 35, ( 1, 0, 0 ), 0, 1 );
                    line( agent.origin, self.s_center.origin, ( 1, 0, 0 ), 1, 0, 1 );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x8efd138d, Offset: 0x10d4
// Size: 0x2c
function function_d379de3ec8858244()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::flag_wait( "cleanup_prop_only_merc_camps" );
    self delete();
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0xbf4d98db, Offset: 0x1108
// Size: 0xc1
function function_35f070bdae8b8d2c( activityinstance )
{
    level endon( #"game_ended" );
    activityinstance endon( #"instance_destroyed" );
    level notify( "watch_to_empty_merc_camp_singleton" + activityinstance.varianttag );
    waitframe();
    level endon( "watch_to_empty_merc_camp_singleton" + activityinstance.varianttag );
    region = undefined;
    
    while ( !isdefined( region ) )
    {
        region = function_1fce1da6e1f75c03( activityinstance );
        wait 1;
    }
    
    utility::flag_wait( "cleanup_prop_only_merc_camps" );
    vehstructs = activityinstance.s_center namespace_be3150865da9d2f1::get_linked_structs_filtered( "s_merc_camp_vehicle", "targetname" );
    
    if ( vehstructs.size > 0 )
    {
        activityinstance thread function_1be63c24410f6ba4( activityinstance );
        return;
    }
    
    activity_instance_common::function_9aeeabe50fc9cc3e( activityinstance );
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0xdf9ced22, Offset: 0x11d1
// Size: 0xc3
function function_1be63c24410f6ba4( activityinstance )
{
    level endon( #"game_ended" );
    
    while ( !isdefined( activityinstance.ambient_vehicles ) || activityinstance.ambient_vehicles.size < 1 )
    {
        wait 1;
    }
    
    foreach ( vehicle in activityinstance.ambient_vehicles )
    {
        vehicle delete();
    }
    
    activity_instance_common::function_9aeeabe50fc9cc3e( activityinstance );
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x693d4a11, Offset: 0x129c
// Size: 0x11e
function function_1fce1da6e1f75c03( activityinstance )
{
    var_a98d07f7a054ff29 = "Activity";
    ActivityTypeName = "REV_OB_MERC_CAMP";
    var_4312b79c960726b6 = activityinstance.varianttag;
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    region = undefined;
    
    foreach ( region in regions )
    {
        if ( isdefined( level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ] ) )
        {
            var_c233e7a3293d7096 = level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ][ var_4312b79c960726b6 ];
            
            if ( isdefined( var_c233e7a3293d7096 ) )
            {
                return region;
            }
        }
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x78ab1a44, Offset: 0x13c2
// Size: 0x5c
function merc_camp_activity_begin()
{
    if ( self.var_77825b2a6902fa8d )
    {
        ob_soldier_util::mortar_zombie_cleanup( self.s_center.origin, 1500 );
    }
    
    function_59d4082e9af5e35f();
    thread function_2e0516c58921029f();
    thread function_226c407fa0525ebf();
    thread function_f7476e006cc75ffd();
    thread function_47ade808b9bcb21e();
    thread camp_siren();
    thread function_7c3640f139309ce7();
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x81fe9ef, Offset: 0x1426
// Size: 0x12d
function merc_camp_activity_end()
{
    activity_succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    
    if ( self.a_vh_drone.size > 0 )
    {
        foreach ( drone in self.a_vh_drone )
        {
            data = spawnstruct();
            data.inflictor = undefined;
            drone ob_soldier_util::function_ed8981f34799cf8e( data );
        }
    }
    
    if ( isdefined( self.var_2103d32051a84e1c ) )
    {
        function_b43716082f77e5e5( self.var_2103d32051a84e1c );
    }
    
    self.var_5959c36e9f0c82d3 = 0;
    
    if ( self.var_c9876a8e7895a3a )
    {
        self.var_c9876a8e7895a3a notify( #"child_activity_begin" );
        
        if ( activity_succeeded )
        {
            level thread function_8cfd23439e11af5( self.var_c9876a8e7895a3a, self.playerparticipants );
            return;
        }
        
        level thread function_3b877b6b99163358( self.var_c9876a8e7895a3a );
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x7eeb8908, Offset: 0x155b
// Size: 0x38a
function merc_camp_activity_destroy()
{
    leaveprops = self.s_center.script_parameters == "only_props";
    
    if ( isdefined( self.loot_cache ) )
    {
        self.loot_cache freescriptable();
    }
    
    if ( self.var_324ee51418b55f61.size > 0 && !leaveprops )
    {
        foreach ( scriptable in self.var_324ee51418b55f61 )
        {
            scriptable setscriptablepartstate( "state", "hidden" );
        }
    }
    
    if ( isdefined( self.loot_marker_cache ) )
    {
        self.loot_marker_cache freescriptable();
    }
    
    if ( self.var_baa34b7d898459c7.size > 0 && !leaveprops )
    {
        foreach ( barrel in self.var_baa34b7d898459c7 )
        {
            if ( isdefined( barrel ) )
            {
                barrel freescriptable();
                barrel = undefined;
            }
        }
    }
    
    if ( self.var_366bb5477d1e8e05.size > 0 && !leaveprops )
    {
        ob_soldier_util::function_3604220db3a0a0cf( self.var_366bb5477d1e8e05 );
    }
    
    if ( !leaveprops )
    {
        ob_activity_utility::ob_disable_cover_nodes();
    }
    
    if ( self.var_7c6a14aaab8d3a32.size > 0 )
    {
        foreach ( mine in self.var_7c6a14aaab8d3a32 )
        {
            if ( isdefined( mine ) )
            {
                mine delete();
            }
        }
    }
    
    ob_activity_utility::function_1467dab20b2d22();
    
    foreach ( vehicle in self.reinforce_vehicles )
    {
        vehicle thread ob_activity_utility::function_16f13e7feb0abb24( 3000 );
    }
    
    self.var_56ae48f9eceb8b3a = undefined;
    self.var_f4855a3f09b3db24 = undefined;
    
    if ( self.var_c9876a8e7895a3a && activity_instance_common::getactivitystate( self.var_c9876a8e7895a3a ) == "Active" )
    {
        if ( self.var_c9876a8e7895a3a.var_a4350e73a4097c74 )
        {
            self.var_c9876a8e7895a3a.computer_station freescriptable();
            self.var_c9876a8e7895a3a.computer_station = undefined;
        }
        else
        {
            activity_instance_common::endactivity( self.var_c9876a8e7895a3a, 0 );
        }
        
        return;
    }
    
    if ( self.var_c9876a8e7895a3a && activity_instance_common::getactivitystate( self.var_c9876a8e7895a3a ) == "Idle" )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self.var_c9876a8e7895a3a );
    }
}

/#

    // Namespace ob_activity_merc_camp
    // Params 0
    // Checksum 0x62146591, Offset: 0x18ed
    // Size: 0x5, Type: dev
    function function_d7efa01d93e66da5()
    {
        
    }

#/

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0xb31c71a7, Offset: 0x18fa
// Size: 0x8f
function function_513082067d02fdd2( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        
        if ( arraycontains( level.players, attacker ) )
        {
            activityinstance notify( #"player_attacking", attacker );
        }
        
        wait 1;
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x3b2091a1, Offset: 0x1991
// Size: 0x9d
function function_3472b90fdf8de091( params )
{
    foreach ( outline_id in self.merc_camp_outlines )
    {
        outline::outlinedisable( outline_id, self );
    }
    
    self notify( #"merc_camp_ai_turned", params.attacker );
}

// Namespace ob_activity_merc_camp
// Params 3
// Checksum 0x7c693042, Offset: 0x1a36
// Size: 0x199
function camp_ai_death_monitor( activityinstance, requestid, is_reinforcement )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"mc_despawn" );
    results = utility::waittill_any_return_params( "death", "merc_camp_ai_turned" );
    assert( results.size > 0 );
    attacker = results[ 0 ];
    
    if ( !isplayer( attacker ) && isplayer( attacker.owner ) )
    {
        attacker = attacker.owner;
    }
    
    if ( isplayer( attacker ) && spatial_zone_container::function_c6b163965cbc2caa( attacker, activityinstance, "Awareness_Zone" ) )
    {
        activity_participation::function_fb0ec90aaf6d4c61( activityinstance, [ attacker ], "PlayerJoinedDamage" );
    }
    
    if ( !is_reinforcement )
    {
        activityinstance.var_3e0be2038aacf981 = arrayremove( activityinstance.var_3e0be2038aacf981, self );
        activityinstance.var_f6acc3926b3da25e++;
    }
    else
    {
        activityinstance.var_b748d7198b3af123 = arrayremove( activityinstance.var_b748d7198b3af123, self );
        activityinstance.var_7972a140ba94ec1e++;
    }
    
    activity_definition_utils::updateprogress( activityinstance function_2a128245c3386a7e(), activityinstance );
    activityinstance.already_outlined = activityinstance function_6f838b438d55cc50();
    
    if ( activityinstance function_97a488fcd7301383() == 0 )
    {
        script::function_2e2007575f92910d( "Merc Camp Soldier counts are messed up. Is Reinforcement:" + is_reinforcement );
    }
    
    if ( activityinstance function_97a488fcd7301383() > 0 && activityinstance function_97a488fcd7301383() <= activityinstance function_2a128245c3386a7e() )
    {
        merc_camp_cleared( activityinstance );
    }
}

/#

    // Namespace ob_activity_merc_camp
    // Params 0
    // Checksum 0x5f221c7c, Offset: 0x1bd7
    // Size: 0x5, Type: dev
    function function_c4d98fe17ef6f6ea()
    {
        
    }

#/

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x25edc688, Offset: 0x1be4
// Size: 0x20f
function function_f7476e006cc75ffd()
{
    self endon( #"activity_ended" );
    var_942e90a59bc9206b = [];
    self.a_s_alarm = self.s_center namespace_be3150865da9d2f1::get_linked_struct_filtered( "s_merc_camp_alarm", "targetname" );
    self.a_s_sentry = self.s_center namespace_be3150865da9d2f1::get_linked_structs_filtered( "s_merc_camp_sentry", "targetname" );
    
    if ( self.a_s_sentry.size > 0 )
    {
        var_942e90a59bc9206b[ var_942e90a59bc9206b.size ] = "s_merc_camp_sentry";
    }
    
    if ( getdvarint( @"hash_177edb8e50ca60cd" ) == 1 )
    {
        self.a_s_drone = self.s_center namespace_be3150865da9d2f1::get_linked_structs_filtered( "s_merc_camp_drone", "targetname" );
        
        if ( self.a_s_drone.size > 0 )
        {
            thread function_ddeaecc4702f0476();
        }
    }
    
    n_hazards = int( min( var_942e90a59bc9206b.size, self.var_9300db9d73a80ede ) );
    var_65747ea08a7469b2 = getdvar( @"hash_b13b59a0d62a36fd", "merc_camp_random" );
    
    if ( var_65747ea08a7469b2 == "merc_camp_all" )
    {
        n_hazards = var_942e90a59bc9206b.size;
    }
    
    var_942e90a59bc9206b = arrayrandomize( var_942e90a59bc9206b );
    var_8a8f0f8b6f4ee03f = utility::array_slice( var_942e90a59bc9206b, 0, n_hazards );
    
    foreach ( var_445ad4c6ab68ba82 in var_8a8f0f8b6f4ee03f )
    {
        switch ( var_445ad4c6ab68ba82 )
        {
            case #"hash_607ec07c00f34010":
                thread function_8a7942bbf64a61a4();
                break;
            case #"hash_a5c91c69bb471104":
                if ( getdvarint( @"hash_e865e223283f1d8d", 0 ) == 1 || self.difficulty_region != "difficulty_easy" )
                {
                    thread function_f73b3ca7e161ad8b();
                }
                
                break;
            default:
                assert( "<dev string:x24>" + var_445ad4c6ab68ba82 );
                break;
        }
        
        waitframe();
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x60849621, Offset: 0x1dfb
// Size: 0x13a
function function_59d4082e9af5e35f()
{
    self endon( #"activity_ended" );
    var_3543973e66a36661 = "ev_" + self.s_center.script_noteworthy;
    self.var_2595e35f3b867fb4 = activity_ai_encounters::function_92b671064b0b1ce2( var_3543973e66a36661, 1, 1, 1, 2 );
    
    if ( !isdefined( self.var_2595e35f3b867fb4 ) )
    {
        assertmsg( "<dev string:x42>" + var_3543973e66a36661 );
        return;
    }
    
    var_546e4eb5269dbafa = self.difficulty_region;
    
    /#
        var_546e4eb5269dbafa = getdvar( @"hash_2d2062bab211cbf5", var_546e4eb5269dbafa );
    #/
    
    function_1a9d724a960fa19d( self.var_2595e35f3b867fb4, var_546e4eb5269dbafa, 1 );
    assert( isdefined( self.var_2595e35f3b867fb4 ), "<dev string:x42>" + var_3543973e66a36661 );
    
    if ( isdefined( self.var_2595e35f3b867fb4 ) )
    {
        activity_ai_encounters::function_52d1342183200a8f( self.var_2595e35f3b867fb4, &function_1bf55e53e0e4b159, self );
        ai_spawn_director::function_5a08798970350207( self.var_2595e35f3b867fb4, &function_6a4eb08b56eb09f0, self );
        activity_ai_encounters::function_16b0131751c4fb39( self.var_2595e35f3b867fb4, &function_79579029f85b7e8, self );
        activity_ai_encounters::function_edecd8fd32cc3ec5( self.var_2595e35f3b867fb4, &function_72941ccbf4efa10d, self );
    }
    
    thread function_e14717219f21c9b8();
    thread function_f61e2813de0f81c7( self.var_2595e35f3b867fb4 );
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x64053bca, Offset: 0x1f3d
// Size: 0x6e
function function_2e0516c58921029f()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self waittill( #"player_attacking" );
    thread function_db87d3aaf8075042( 20 );
    wait getdvarint( @"hash_6515033148c12e15", 15 );
    thread function_d797b035ad18ae66( self.var_2595e35f3b867fb4 );
    ob_activity_utility::function_894ac80e038636c5( "wcacheckpointrein" );
    self.var_a4eb471d5db606c0 = 1;
    thread function_882b18c1663feb2f();
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x799eecbf, Offset: 0x1fb3
// Size: 0x16a
function function_d797b035ad18ae66( encounter_id )
{
    self notify( #"hash_1a5d081179a42241" );
    self endon( #"hash_1a5d081179a42241" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_21fd0d8034ab1cca = getvehiclenode( self.s_center.script_noteworthy + "_GROUND", #targetname );
    force_parachute_reinforcement = getdvarint( @"hash_46932f4e7ac892dc", 0 );
    assert( isdefined( var_21fd0d8034ab1cca ) );
    var_9f042ff152592eee = "ai_encounter_despawning_" + encounter_id;
    
    if ( isdefined( var_21fd0d8034ab1cca ) )
    {
        while ( true )
        {
            check_player_array = getplayersinradius( var_21fd0d8034ab1cca.origin, 2000 );
            
            if ( force_parachute_reinforcement || check_player_array.size > 5 || ob_activity_utility::function_e710f3efecb65567( check_player_array, var_21fd0d8034ab1cca.origin, 500 ) || ob_activity_utility::function_2ffc785b6076484e( check_player_array, var_21fd0d8034ab1cca.origin ) )
            {
                function_1a9d724a960fa19d( encounter_id, "parachute_allowed", 1 );
            }
            else
            {
                function_1a9d724a960fa19d( encounter_id, "ground_vehicle_allowed", 1 );
            }
            
            level waittill( var_9f042ff152592eee );
            function_1a9d724a960fa19d( encounter_id, "ground_vehicle_allowed", 0 );
            function_1a9d724a960fa19d( encounter_id, "parachute_allowed", 0 );
            self waittill( #"merc_camp_soldiers_spawned" );
        }
        
        return;
    }
    
    function_1a9d724a960fa19d( encounter_id, "parachute_allowed", 1 );
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0xf8fbb04, Offset: 0x2125
// Size: 0x83
function function_db87d3aaf8075042( delay )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    wait delay;
    self.var_db87d3aaf8075042 = 1;
    self.already_outlined = function_6f838b438d55cc50();
    var_9f042ff152592eee = "ai_encounter_despawning_" + ( self.var_2595e35f3b867fb4 ?? "" );
    
    while ( true )
    {
        level utility::waittill_any( var_9f042ff152592eee );
        wait 2;
        self.already_outlined = 0;
    }
}

// Namespace ob_activity_merc_camp
// Params 0, eflags: 0x4
// Checksum 0xb6213b78, Offset: 0x21b0
// Size: 0x2a7
function private function_6f838b438d55cc50()
{
    activityinstance = self;
    
    if ( !activityinstance.already_outlined && activityinstance.var_db87d3aaf8075042 && activityinstance.var_3e0be2038aacf981.size + activityinstance.var_b748d7198b3af123.size <= activityinstance.var_7b3d9e1eb426ada0 )
    {
        foreach ( soldier in activityinstance.var_3e0be2038aacf981 )
        {
            if ( !isdefined( soldier.merc_camp_outlines ) )
            {
                soldier.merc_camp_outlines = [];
            }
            
            foreach ( player in activityinstance.playerparticipants )
            {
                outline_id = outline::outlineenableforplayer( soldier, player, "sat_ob_activity_stronghold_boss_outline", "level_script" );
                soldier.merc_camp_outlines[ soldier.merc_camp_outlines.size ] = outline_id;
            }
        }
        
        foreach ( soldier in activityinstance.var_b748d7198b3af123 )
        {
            if ( !isdefined( soldier.merc_camp_outlines ) )
            {
                soldier.merc_camp_outlines = [];
            }
            
            foreach ( player in activityinstance.playerparticipants )
            {
                outline_id = outline::outlineenableforplayer( soldier, player, "sat_ob_activity_stronghold_boss_outline", "level_script" );
                soldier.merc_camp_outlines[ soldier.merc_camp_outlines.size ] = outline_id;
            }
        }
        
        return 1;
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0xdd0d090, Offset: 0x2460
// Size: 0xe1
function function_882b18c1663feb2f()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_9f042ff152592eee = "ai_encounter_despawning_" + ( self.var_2595e35f3b867fb4 ?? "" );
    
    while ( true )
    {
        level utility::waittill_any( var_9f042ff152592eee );
        
        foreach ( vehicle in self.reinforce_vehicles )
        {
            vehicle thread ob_activity_utility::function_16f13e7feb0abb24( 3000 );
            self.reinforce_vehicles = arrayremove( self.reinforce_vehicles, vehicle );
        }
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0xf74bbd25, Offset: 0x2549
// Size: 0x236
function function_226c407fa0525ebf()
{
    self endon( #"activity_ended" );
    
    if ( !isdefined( self.var_91c91f4a631c481d.zombieencounter ) || self.var_91c91f4a631c481d.zombieencounter == "" )
    {
        return;
    }
    
    var_546e4eb5269dbafa = self.difficulty_region;
    
    /#
        var_546e4eb5269dbafa = getdvar( @"hash_2d2062bab211cbf5", var_546e4eb5269dbafa );
    #/
    
    var_101d17c5d545cace = 0;
    chance = randomint( 100 );
    
    switch ( var_546e4eb5269dbafa )
    {
        case #"hash_7bb2cd766703d463":
            var_b9bce6a2c6a0af70 = getdvarint( @"hash_181e765f7a6858d2", 0 );
            break;
        case #"hash_af83e47edfa8900a":
            var_b9bce6a2c6a0af70 = getdvarint( @"hash_683ddaf9dc721a27", 0 );
            break;
        case #"hash_5343b465e56ec9a4":
            var_b9bce6a2c6a0af70 = getdvarint( @"hash_cbe82ce25c4d4239", 0 );
            break;
        default:
            var_b9bce6a2c6a0af70 = 0;
            break;
    }
    
    if ( chance < var_b9bce6a2c6a0af70 )
    {
        var_101d17c5d545cace = 1;
    }
    
    if ( var_101d17c5d545cace )
    {
        self.var_c960c17aa7217b46 = [];
        self.var_c960c17aa7217b46 = self.s_center namespace_be3150865da9d2f1::get_linked_structs_filtered( self.var_91c91f4a631c481d.var_788b9af1a1807c6f, "targetname" );
        self waittill( #"merc_camp_soldiers_spawned" );
        
        if ( self.var_c960c17aa7217b46.size > 0 )
        {
            pos = utility::array_random( self.var_c960c17aa7217b46 );
        }
        else
        {
            pos = function_239fa3b8592a2b7();
        }
        
        if ( isdefined( pos ) )
        {
            self.var_2103d32051a84e1c = ai_spawn_director::spawn_request( "ai_encounter:" + self.var_91c91f4a631c481d.zombieencounter, pos.origin, self.var_91c91f4a631c481d.zombieradius, 1, 1, 0 );
            self.var_fb02babc2a96f94a = pos.origin;
            ai_spawn_director::add_spawned_callback( self.var_2103d32051a84e1c, &function_b9768738c38915a5, self );
            function_1a9d724a960fa19d( self.var_2103d32051a84e1c, var_546e4eb5269dbafa, 1 );
            self.var_5959c36e9f0c82d3 = 1;
            thread function_3fc17331e8ddf308();
            thread function_2259ce1199b27e15();
        }
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x47da236c, Offset: 0x2787
// Size: 0x1c2
function function_239fa3b8592a2b7()
{
    self endon( #"activity_ended" );
    attempts = 0;
    
    while ( true )
    {
        angle = randomfloatrange( 1, 360 );
        rad = randomfloatrange( self.var_91c91f4a631c481d.var_c43aaec4aceec0af, self.var_91c91f4a631c481d.zombiemaxdistance );
        pos = spawnstruct();
        var_610b8e887cb333fd = self.s_center.origin[ 0 ];
        cy = self.s_center.origin[ 1 ];
        var_610b8c887cb32f97 = self.s_center.origin[ 2 ];
        dist = 0;
        posx = var_610b8e887cb333fd + rad * cos( angle );
        posy = cy + rad * sin( angle );
        pos.origin = getclosestpointonnavmesh( ( posx, posy, var_610b8c887cb32f97 ), undefined, 0, 0, 0 );
        center = getclosestpointonnavmesh( self.s_center.origin, undefined, 0, 0, 0 );
        
        if ( isdefined( pos.origin ) && isdefined( center ) )
        {
            dist = distance2d( pos.origin, center );
        }
        
        if ( dist > self.var_91c91f4a631c481d.var_c43aaec4aceec0af && dist < self.var_91c91f4a631c481d.zombiemaxdistance )
        {
            break;
        }
        
        wait 0.1;
        attempts += 1;
        
        if ( attempts > 5 )
        {
            break;
        }
    }
    
    return pos;
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x81931609, Offset: 0x2952
// Size: 0xce
function function_7470b3f6c233a325()
{
    self endon( #"activity_ended" );
    structs = self.s_center namespace_be3150865da9d2f1::get_linked_structs_filtered( "s_merc_camp_vehicle", "targetname" );
    
    if ( structs.size > 0 )
    {
        if ( structs.size > 1 )
        {
            n_min_vehicles = int( min( structs.size, 1 ) );
            n_max_vehicles = int( min( structs.size, 3 ) );
            
            if ( n_max_vehicles > n_min_vehicles )
            {
                var_a3ac6fb908f611b0 = randomintrange( n_min_vehicles, n_max_vehicles );
            }
            else
            {
                var_a3ac6fb908f611b0 = n_min_vehicles;
            }
            
            var_49b1d4c03abc1262 = arrayrandomize( structs );
            structs_sliced = utility::array_slice( var_49b1d4c03abc1262, 0, var_a3ac6fb908f611b0 );
        }
        else
        {
            structs_sliced = structs;
        }
        
        ob_activity_utility::function_4ad66bfa02812252( "veh_sat_medium_truck_ob", structs_sliced, 3000 );
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x18d953d1, Offset: 0x2a28
// Size: 0x241
function merc_camp_setup_cover()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !isdefined( self.var_366bb5477d1e8e05 ) )
    {
        self.var_366bb5477d1e8e05 = [];
    }
    
    var_7d61048eb831bd93 = "e_cover_" + self.s_center.script_noteworthy;
    self.var_366bb5477d1e8e05 = ob_soldier_util::function_a315cc5d1dee425a( var_7d61048eb831bd93 );
    essential_covers = [];
    
    foreach ( cover in self.var_366bb5477d1e8e05 )
    {
        if ( cover.script_noteworthy == "ladder" )
        {
            essential_covers[ essential_covers.size ] = cover;
        }
    }
    
    while ( true )
    {
        wait 0.1;
        var_c4699a40f8084d4b = 0;
        
        foreach ( cover in essential_covers )
        {
            if ( !cover.scriptables )
            {
                var_c4699a40f8084d4b = 1;
                break;
            }
            
            foreach ( scriptable in cover.scriptables )
            {
                if ( scriptable getscriptablepartstate( #"state", 0, 1 ) != #"visible" )
                {
                    var_c4699a40f8084d4b = 1;
                    break;
                }
            }
        }
        
        if ( !var_c4699a40f8084d4b )
        {
            break;
        }
    }
    
    essential_covers = undefined;
    waitframe();
    function_9d6e36ee18e16677();
    utility::ent_flag_set( "cover_ready" );
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x86337c2c, Offset: 0x2c71
// Size: 0x21
function function_9d6e36ee18e16677()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_activity_utility::ob_enable_cover_nodes();
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x1c1b794c, Offset: 0x2c9a
// Size: 0x118
function function_21811bb0afce307f()
{
    self endon( #"activity_ended" );
    var_50fca865ff4e803f = "s_merc_camp_flag_" + self.s_center.script_noteworthy;
    flagscriptables = getentitylessscriptablearray( var_50fca865ff4e803f, #targetname, self.s_center.origin, 3000 );
    
    foreach ( scriptable in flagscriptables )
    {
        if ( isdefined( scriptable.classname ) && issubstr( scriptable.classname, "scriptable_ob_toggleable" ) )
        {
            scriptable setscriptablepartstate( "state", "visible" );
            self.var_324ee51418b55f61[ self.var_324ee51418b55f61.size ] = scriptable;
        }
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0xb4963887, Offset: 0x2dba
// Size: 0x18f
function function_8a7942bbf64a61a4()
{
    self endon( #"activity_ended" );
    assert( self.a_s_mine.size > 0, "<dev string:x99>" + "<dev string:xd1>" );
    
    while ( self.var_3e0be2038aacf981.size == 0 )
    {
        waitframe();
    }
    
    var_d610710cd23beb8b = self.a_s_mine.size;
    
    if ( self.a_s_mine.size > 1 )
    {
        n_min_mines = int( min( self.a_s_mine.size, 3 ) );
        n_max_mines = int( min( self.a_s_mine.size, 12 ) );
        
        if ( n_max_mines > n_min_mines )
        {
            var_d610710cd23beb8b = randomintrange( n_min_mines, n_max_mines );
        }
        else
        {
            var_d610710cd23beb8b = n_min_mines;
        }
    }
    
    var_49b1d4c03abc1262 = arrayrandomize( self.a_s_mine );
    
    for ( index = 0; index < var_d610710cd23beb8b ; index++ )
    {
        var_8de6f80b3674ce04 = "bp_" + self.s_center.script_noteworthy + "_mine" + index;
        mine = ob_soldier_util::ob_mine_spawn( var_49b1d4c03abc1262[ index ].origin, var_8de6f80b3674ce04, self.var_3e0be2038aacf981[ 0 ], undefined, mine.angles, 1 );
        mine.allowfriendlyfire = 1;
        self.var_7c6a14aaab8d3a32[ self.var_7c6a14aaab8d3a32.size ] = mine;
        mine thread function_a03b8679b05ba716( self );
        activity_participation::function_d041ee0ec570299d( mine );
        mine thread function_513082067d02fdd2( self );
        waitframe();
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0xacb72d63, Offset: 0x2f51
// Size: 0x137
function function_a03b8679b05ba716( activityinstance )
{
    self endon( #"death" );
    activityinstance endon( #"activity_ended" );
    self waittill( #"trigger_grenade", ents );
    
    if ( ents.size > 0 )
    {
        if ( ents[ 0 ] vehicle::is_vehicle() )
        {
            occupants = vehicle_occupancy::get_all_occupants( ents[ 0 ], 0 );
            
            if ( occupants.size > 0 )
            {
                foreach ( occupant in occupants )
                {
                    if ( arraycontains( level.players, occupant ) )
                    {
                        ents[ 0 ] = occupant;
                    }
                }
            }
        }
        
        if ( arraycontains( level.players, ents[ 0 ] ) )
        {
            if ( !arraycontains( activityinstance.playerparticipants, ents[ 0 ] ) )
            {
                activity_participation::function_fb0ec90aaf6d4c61( activityinstance, ents[ 0 ], "PlayerJoinedDamage" );
            }
            
            activityinstance notify( #"player_attacking", ents[ 0 ] );
        }
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0xbc458113, Offset: 0x3090
// Size: 0x129
function function_f73b3ca7e161ad8b()
{
    self endon( #"activity_ended" );
    assert( self.a_s_sentry.size > 0, "<dev string:x99>" + "<dev string:xe2>" );
    self.var_704c3b198e3c8def = throttle::throttle_initialize( "sentry_health_bar_update", 2 );
    n_sentries = self.a_s_sentry.size;
    
    if ( self.a_s_sentry.size > 1 )
    {
        n_min_sentries = int( min( self.a_s_sentry.size, 1 ) );
        n_max_sentries = int( min( self.a_s_sentry.size, 3 ) );
        
        if ( n_max_sentries > n_min_sentries )
        {
            n_sentries = randomintrange( n_min_sentries, n_max_sentries );
        }
        else
        {
            n_sentries = n_min_sentries;
        }
    }
    
    var_49b1d4c03abc1262 = arrayrandomize( self.a_s_sentry );
    
    for ( index = 0; index < n_sentries ; index++ )
    {
        var_49b1d4c03abc1262[ index ].allowemp = 1;
        var_49b1d4c03abc1262[ index ].var_b9ac62a4e325b4be = #"killstreak";
        ob_activity_utility::ob_activity_spawn_turret( var_49b1d4c03abc1262[ index ], &on_spawn_sentry, undefined, 1, undefined );
        waitframe();
    }
}

// Namespace ob_activity_merc_camp
// Params 1, eflags: 0x4
// Checksum 0x686b2425, Offset: 0x31c1
// Size: 0x72
function private on_spawn_sentry( params )
{
    params.activity_instance activity_participation::function_d041ee0ec570299d( self );
    thread function_513082067d02fdd2( params.activity_instance );
    thread function_64f20590bdf8c79d( params.activity_instance );
    
    if ( params.activity_instance.s_center.script_parameters == "only_props" )
    {
        thread function_d379de3ec8858244();
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0xe6e4df8e, Offset: 0x323b
// Size: 0xb5
function function_64f20590bdf8c79d( activityinstance )
{
    self endon( #"death" );
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    while ( true )
    {
        if ( isdefined( self.besttarget ) && arraycontains( level.players, self.besttarget ) )
        {
            if ( !arraycontains( activityinstance.playerparticipants, self.besttarget ) )
            {
                activity_participation::function_fb0ec90aaf6d4c61( activityinstance, [ self.besttarget ], "PlayerJoinedDamage" );
            }
            
            activityinstance notify( #"player_attacking", self.besttarget );
        }
        
        wait 1;
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x330e1cae, Offset: 0x32f8
// Size: 0x5a
function function_8eaca4fc105939ef()
{
    var_a262fb111cfa520c = self.s_center namespace_be3150865da9d2f1::get_linked_struct_filtered( "s_merc_camp_cache", "targetname" );
    
    if ( var_a262fb111cfa520c )
    {
        self.loot_cache = common_cache::function_9bc018c1b8aad720( #"activity_merc_camp", var_a262fb111cfa520c.origin, var_a262fb111cfa520c.angles );
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0xa4ed082e, Offset: 0x335a
// Size: 0x109
function function_47ade808b9bcb21e()
{
    self endon( #"activity_ended" );
    
    if ( self.difficulty_region == "difficulty_easy" )
    {
        return;
    }
    
    spawnchance = getdvarfloat( @"hash_ac20e1c50f0ca8fe", 0.5 );
    
    if ( randomfloat( 1 ) > spawnchance )
    {
        return;
    }
    
    self waittill( #"player_attacking" );
    alivesoldiers = utility::array_removedead_or_dying( self.var_3e0be2038aacf981 );
    
    if ( alivesoldiers.size == 0 || self.var_e2fbbbbf65e236fe )
    {
        return;
    }
    
    ownersoldier = alivesoldiers[ 0 ];
    reinforcement_center = self.s_center namespace_be3150865da9d2f1::get_linked_struct_filtered( "killstreak_support", "script_noteworthy" );
    
    if ( isdefined( reinforcement_center ) )
    {
        spawnpoint = reinforcement_center.origin;
        spawnangles = reinforcement_center.angles;
    }
    else
    {
        spawnpoint = ownersoldier getorigin();
        spawnangles = ownersoldier getplayerangles();
    }
    
    ob_activity_utility::function_ded5fcf7673a2ae6( ownersoldier, spawnpoint, spawnangles );
}

// Namespace ob_activity_merc_camp
// Params 4
// Checksum 0xc5e7aae9, Offset: 0x346b
// Size: 0x2fd
function function_1bf55e53e0e4b159( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    
    if ( !isdefined( agent.ob ) )
    {
        agent.ob = spawnstruct();
    }
    
    activityinstance = userdata;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"merc_camp_cleared" );
    is_reinforcement = data.waveindex > 0;
    agent.var_d229a71fb9fbe4d1 = data.var_d229a71fb9fbe4d1;
    
    if ( !modelhastag( agent.model, "j_spine4" ) )
    {
        dump_agent_info( agent, "encounter spawn" );
    }
    
    if ( !is_reinforcement )
    {
        activityinstance.var_772ce0ec7032e594++;
        activityinstance.var_3e0be2038aacf981[ activityinstance.var_3e0be2038aacf981.size ] = agent;
    }
    else
    {
        if ( data.vehicle_unload_pos )
        {
            agent waittill( #"unload" );
        }
        
        activityinstance.var_b748d7198b3af123[ activityinstance.var_b748d7198b3af123.size ] = agent;
        activityinstance.var_f4f91556935fc7b8++;
        activity_definition_utils::updateprogress( undefined, activityinstance, activityinstance function_97a488fcd7301383() );
        
        if ( activityinstance.already_outlined )
        {
            if ( !isdefined( agent.merc_camp_outlines ) )
            {
                agent.merc_camp_outlines = [];
            }
            
            foreach ( player in activityinstance.playerparticipants )
            {
                outline_id = outline::outlineenableforplayer( agent, player, "sat_ob_activity_stronghold_boss_outline", "level_script" );
                agent.merc_camp_outlines[ agent.merc_camp_outlines.size ] = outline_id;
            }
        }
    }
    
    if ( activityinstance.var_3e0be2038aacf981.size == 1 )
    {
        activityinstance notify( #"merc_camp_soldiers_spawned" );
    }
    
    agent callback::add( "on_turned", &function_3472b90fdf8de091 );
    
    if ( !is_reinforcement )
    {
        agent thread function_c574e62b6240a290( activityinstance );
    }
    
    agent thread function_513082067d02fdd2( activityinstance );
    agent thread camp_ai_death_monitor( activityinstance, requestid, is_reinforcement );
    agent utility::ent_flag_init( "activity_mercCamp_spawned" );
    agent callback::add( #"on_ai_killed", &function_80b71fb924a91bb9, [ activityinstance ] );
    
    if ( is_reinforcement )
    {
        if ( data.vehicle_unload_pos )
        {
            agent waittill( #"unloaded" );
        }
        else if ( data.parachute_start_pos )
        {
            agent waittill( #"delete_chute" );
        }
        
        agent thread function_c574e62b6240a290( activityinstance );
        agent thread function_be9ddaebe68332b5( activityinstance );
    }
}

// Namespace ob_activity_merc_camp
// Params 2, eflags: 0x4
// Checksum 0xe22e4b22, Offset: 0x3770
// Size: 0x90
function private function_80b71fb924a91bb9( params, additional_params )
{
    if ( self.death_source == "despawn" )
    {
        self notify( #"mc_despawn" );
        activity_instance = additional_params[ 0 ];
        activity_instance.var_772ce0ec7032e594 = 0;
        activity_instance.var_f6acc3926b3da25e = 0;
        activity_instance.var_f4f91556935fc7b8 = 0;
        activity_instance.var_7972a140ba94ec1e = 0;
        activity_instance.var_3e0be2038aacf981 = [];
        activity_instance.var_b748d7198b3af123 = [];
    }
}

// Namespace ob_activity_merc_camp
// Params 4
// Checksum 0x1ab55606, Offset: 0x3808
// Size: 0x41, Type: bool
function function_79579029f85b7e8( requestid, userdata, agent, data )
{
    activity_instance = userdata;
    return istrue( activity_instance.var_a4eb471d5db606c0 );
}

// Namespace ob_activity_merc_camp
// Params 3
// Checksum 0xdfdfc10a, Offset: 0x3852
// Size: 0x6f
function function_72941ccbf4efa10d( requestid, userdata, spawnedvehicle )
{
    activityinstance = userdata;
    isgroundvehicle = spawnedvehicle vehicle::is_ground_vehicle();
    
    if ( !spawnedvehicle vehicle::is_ground_vehicle() )
    {
        return;
    }
    
    activityinstance.reinforce_vehicles[ activityinstance.reinforce_vehicles.size ] = spawnedvehicle;
    ob_convoy_util::function_1b365c78e86f6916( spawnedvehicle );
}

// Namespace ob_activity_merc_camp
// Params 2
// Checksum 0xd666af2c, Offset: 0x38c9
// Size: 0x140
function merc_camp_cleared( activityinstance, data )
{
    assert( isdefined( activityinstance ) );
    assert( activity_instance_common::getactivitystate( activityinstance ) == "<dev string:xf5>" );
    activityinstance.var_9c29bf1eecedd383 = 1;
    activityinstance notify( #"merc_camp_cleared" );
    activityinstance function_5ea8aab3b8d1f863();
    
    if ( activityinstance.a_vh_drone.size > 0 )
    {
        foreach ( drone in activityinstance.a_vh_drone )
        {
            data = spawnstruct();
            data.inflictor = undefined;
            drone ob_soldier_util::function_ed8981f34799cf8e( data );
        }
    }
    
    activityinstance thread ob_activity_utility::function_894ac80e038636c5( "wcacheckpointsuccess", undefined, undefined, undefined, undefined, &function_ce0c2d3b7fcd489b );
    
    if ( activityinstance.var_f4f91556935fc7b8 == 0 )
    {
        activityinstance.successtype = #"hash_1639b37bf8a7b6a3";
    }
    
    waitframe();
    activity_instance_common::endactivity( activityinstance, 1 );
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x821f637b, Offset: 0x3a11
// Size: 0x37
function function_ce0c2d3b7fcd489b( var_73f4f05f29c6770a )
{
    if ( var_73f4f05f29c6770a == "wcacheckpointsuccess_kagan" || var_73f4f05f29c6770a == "wcacheckpointsuccess_razor" )
    {
        return [ "wcacheckpointclapback2", "wcacheckpointlastword" ];
    }
}

// Namespace ob_activity_merc_camp
// Params 4
// Checksum 0x3696c314, Offset: 0x3a51
// Size: 0x71
function function_b9768738c38915a5( requestid, userdata, agent, data )
{
    var_4d7d4fdebb3384d2 = getclosestpointonnavmesh( userdata.s_center.origin );
    agent setgoalpos( var_4d7d4fdebb3384d2, 512 );
    agent utility::ent_flag_wait( "stealth_enabled" );
    agent thread function_928db17e31e77aa8( userdata );
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x62afd560, Offset: 0x3aca
// Size: 0x183
function function_760d5a2035e88df3()
{
    foreach ( agent in self.var_3e0be2038aacf981 )
    {
        if ( !isdefined( agent.var_3761ee502c4a6baa ) )
        {
            agent.var_3761ee502c4a6baa = 3;
        }
        
        switch ( self.difficulty_region )
        {
            case #"hash_7bb2cd766703d463":
                assert( self.var_91c91f4a631c481d.var_ba7519deea0482bf > 0 );
                agent.var_3761ee502c4a6baa /= self.var_91c91f4a631c481d.var_ba7519deea0482bf;
                break;
            case #"hash_5343b465e56ec9a4":
            case #"hash_af83e47edfa8900a":
                assert( self.var_91c91f4a631c481d.var_ba751adeea0484f2 > 0 );
                agent.var_3761ee502c4a6baa /= self.var_91c91f4a631c481d.var_ba751adeea0484f2;
                break;
            default:
                break;
        }
    }
    
    function_a8c7910253bb1f28( self.var_2103d32051a84e1c );
    self.var_5959c36e9f0c82d3 = 0;
}

// Namespace ob_activity_merc_camp
// Params 2
// Checksum 0xd1401781, Offset: 0x3c55
// Size: 0x190
function function_6a4eb08b56eb09f0( requestid, userdata )
{
    activityinstance = userdata;
    activityinstance endon( #"activity_ended" );
    requestdata = function_9b649316adcccbaa( requestid );
    
    if ( requestdata.var_6c68f9123a6c858d > 0 )
    {
        return;
    }
    
    var_67702249fa20e0a4 = 0;
    tacticiancount = 0;
    
    if ( isarray( requestdata.ai ) )
    {
        foreach ( ai in requestdata.ai )
        {
            if ( isdefined( ai ) && isdefined( ai.subclass ) )
            {
                switch ( ai.subclass )
                {
                    case #"hash_c9beeb2ff7f370db":
                        tacticiancount++;
                        break;
                    case #"hash_5a24fffee0d81302":
                        var_67702249fa20e0a4++;
                        break;
                    default:
                        break;
                }
            }
        }
    }
    
    var_9cf8c1e6c568eb81 = "s_merc_camp_type_default";
    
    if ( tacticiancount != 0 && var_67702249fa20e0a4 < tacticiancount )
    {
        var_9cf8c1e6c568eb81 = "s_merc_camp_type_tactician";
    }
    else if ( var_67702249fa20e0a4 != 0 && var_67702249fa20e0a4 >= tacticiancount )
    {
        var_9cf8c1e6c568eb81 = "s_merc_camp_type_sniper";
    }
    
    activityinstance.var_b924e4853c511278 = var_9cf8c1e6c568eb81;
}

// Namespace ob_activity_merc_camp
// Params 2, eflags: 0x4
// Checksum 0xaeadcba2, Offset: 0x3ded
// Size: 0x140
function private dump_agent_info( agent, extrainfo )
{
    if ( !getdvarint( @"hash_24c8d84d4de7244e", 1 ) )
    {
        return;
    }
    
    var_83867b83cbba65a8 = extrainfo ? "[" + extrainfo + "] " : "";
    subclassstr = "subClass = " + ( agent.subclass ?? "invalid" );
    modelstr = "model = " + ( agent.model ?? "invalid" );
    var_499f41bd3481294c = "goalAreaTarget = " + ( agent.var_d229a71fb9fbe4d1 ?? "invalid" );
    originstr = "pos = " + agent.origin[ 0 ] + " " + agent.origin[ 1 ] + " " + agent.origin[ 2 ];
    dumpinfo = "[CHI-244572] No j_spine4 " + var_83867b83cbba65a8 + subclassstr + ", " + modelstr + ", " + var_499f41bd3481294c + ", " + originstr;
    logstring( dumpinfo );
    script::demoforcesre( dumpinfo );
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x674f8e5a, Offset: 0x3f35
// Size: 0x1cb
function function_73692ff2738f8402( activityinstance )
{
    self endon( #"death" );
    activityinstance endon( #"activity_ended" );
    
    while ( true )
    {
        if ( self.scripted_mode )
        {
            wait 1;
            continue;
        }
        
        self notify( #"startCombatRush" );
        wait randomfloatrange( 5, 15 );
        
        if ( !isdefined( self.enemy ) )
        {
            continue;
        }
        
        self aieventlistenerevent( "combat", self.enemy, self.enemy.origin );
        self getenemyinfo( self.enemy );
        self forcethreatupdate();
        enemytome = self.origin - self.enemy.origin;
        
        if ( length( enemytome ) < 256 )
        {
            continue;
        }
        
        self.goalradius = 128;
        goalradius = randomfloatrange( 384, 768 );
        var_7094b15a00ea54dc = randomfloatrange( -90, 90 );
        testpos = goalradius * vectornormalize( rotatevector( enemytome, ( 0, var_7094b15a00ea54dc, 0 ) ) );
        goalpos = self getclosestreachablepointonnavmesh( testpos );
        goalnode = self findbestcovernode( undefined, 1, goalpos, 0 );
        goal = undefined;
        
        if ( isdefined( goalnode ) )
        {
            self setgoalnode( goalnode );
            self usecovernodeifpossible( goalnode );
            goal = goalnode.origin;
        }
        else
        {
            self setgoalpos( goalpos );
            goal = goalpos;
        }
        
        self.var_92ab46924acfe3aa = 1;
        waitframe();
        thread function_4091aff0173de400( self, goal );
        utility::waittill_any_timeout( 10, "goal" );
        self.var_92ab46924acfe3aa = 0;
    }
}

// Namespace ob_activity_merc_camp
// Params 2
// Checksum 0x3e4fb550, Offset: 0x4108
// Size: 0xa8
function function_4091aff0173de400( activityinstance, goal )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    activityinstance endon( #"activity_ended" );
    
    while ( self.var_92ab46924acfe3aa )
    {
        /#
            thread utility::draw_ent_axis( ( 1, 0, 0 ), 10, 30 );
            thread utility::draw_circle( goal, 32, ( 1, 0, 0 ), 1, 0, 10 );
            thread utility::draw_line_for_time( self.origin, goal, 1, 0, 0, 0.1 );
        #/
        
        wait 0.1;
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0xc32d39d, Offset: 0x41b8
// Size: 0x129
function function_be9ddaebe68332b5( activityinstance )
{
    self endon( #"death" );
    activityinstance endon( #"activity_ended" );
    
    while ( self.scripted_mode )
    {
        wait 0.2;
    }
    
    player = undefined;
    goal = activityinstance.s_center;
    dist = distance2d( self.origin, activityinstance.s_center.origin );
    
    if ( activityinstance.playerparticipants.size > 0 )
    {
        a_players = sortbydistancecullbyradius( activityinstance.playerparticipants, self.origin, dist * 1.25 );
        
        if ( a_players.size > 0 )
        {
            player = utility::array_random( a_players );
            goal = player;
        }
    }
    
    self notify( #"startCombatRush" );
    ai_behavior::function_4a3c03bb49dd5d76( goal.origin, 512, 0 );
    
    if ( isdefined( player ) )
    {
        self aieventlistenerevent( "combat", player, player.origin );
        self getenemyinfo( player );
        self forcethreatupdate();
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x6f72cacc, Offset: 0x42e9
// Size: 0x1ca
function function_c574e62b6240a290( activityinstance )
{
    self endon( #"death" );
    activityinstance endon( #"activity_ended" );
    
    if ( !self.var_d229a71fb9fbe4d1 )
    {
        thread ai_spawn_director::function_83b64ff1bf82fa89();
    }
    
    if ( isdefined( self.var_3761ee502c4a6baa ) )
    {
        switch ( activityinstance.difficulty_region )
        {
            case #"hash_7bb2cd766703d463":
                assert( activityinstance.var_91c91f4a631c481d.var_ba7519deea0482bf > 0 );
                self.var_3761ee502c4a6baa *= activityinstance.var_91c91f4a631c481d.var_ba7519deea0482bf;
                break;
            case #"hash_5343b465e56ec9a4":
            case #"hash_af83e47edfa8900a":
                assert( activityinstance.var_91c91f4a631c481d.var_ba751adeea0484f2 > 0 );
                self.var_3761ee502c4a6baa *= activityinstance.var_91c91f4a631c481d.var_ba751adeea0484f2;
                break;
            default:
                break;
        }
    }
    
    while ( true )
    {
        if ( isdefined( self.enemy ) && arraycontains( level.players, self.enemy ) )
        {
            if ( activityinstance.var_5959c36e9f0c82d3 )
            {
                activityinstance function_760d5a2035e88df3();
            }
        }
        
        if ( activityinstance.var_5959c36e9f0c82d3 && !isdefined( self.enemy ) && isdefined( self.threatsightstate ) && ( self.threatsightstate == "combat" || self.threatsightstate == "spotted" ) )
        {
            activityinstance notify( #"zombies_attacking" );
        }
        
        wait 1;
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0xf78d2285, Offset: 0x44bb
// Size: 0xc8
function function_3fc17331e8ddf308()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    
    while ( true )
    {
        foreach ( agent in self.var_3e0be2038aacf981 )
        {
            if ( isdefined( agent.threatsightstate ) && agent.threatsightstate == "combat_hunt" )
            {
                self notify( #"zombies_defeated" );
            }
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x4dc89b39, Offset: 0x458b
// Size: 0x240
function function_2259ce1199b27e15()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    centerpos = getclosestpointonnavmesh( self.s_center.origin );
    var_534215846b0f1d6d = findpathcustom( centerpos, self.var_fb02babc2a96f94a );
    self.var_b6585d7c58cb4649 = function_7f614e981de283a1( var_534215846b0f1d6d );
    
    while ( true )
    {
        self waittill( #"zombies_attacking" );
        self.var_afcb48f946e7e142 = [];
        self.var_afcb48f946e7e142 = sortbydistance( self.var_3e0be2038aacf981, self.var_b6585d7c58cb4649 );
        
        for ( i = 0; i < self.var_91c91f4a631c481d.var_3051e4e4779c0d9d ; i++ )
        {
            defender = self.var_afcb48f946e7e142[ i ];
            var_b56a34654c431062 = distance( defender.origin, self.var_b6585d7c58cb4649 );
            
            if ( defender.subclass != "ob_sniper" && defender.subclass != "ob_rocketeer" && var_b56a34654c431062 < 2 * self.var_91c91f4a631c481d.var_3338671d0210676b )
            {
                defender setgoalpos( self.var_b6585d7c58cb4649, self.var_91c91f4a631c481d.var_3338671d0210676b );
                defender.keepclaimednodeifvalid = 1;
                self.var_afcb48f946e7e142[ self.var_afcb48f946e7e142.size ] = defender;
            }
        }
        
        self waittill( #"zombies_defeated" );
        
        foreach ( agent in self.var_afcb48f946e7e142 )
        {
            agent setgoalpos( self.s_center.origin, 1024 );
            defender.keepclaimednodeifvalid = 0;
        }
        
        wait 1;
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x43ebe2c1, Offset: 0x47d3
// Size: 0xe9
function function_7f614e981de283a1( var_8dfa4957f801303c )
{
    lastpoint = undefined;
    
    foreach ( point in var_8dfa4957f801303c )
    {
        dist = distance( point, self.s_center.origin );
        
        if ( dist < self.var_91c91f4a631c481d.var_8936126a3d1475aa )
        {
            if ( !isdefined( lastpoint ) || dist > distance( self.s_center.origin, lastpoint ) )
            {
                lastpoint = point;
            }
        }
    }
    
    return lastpoint;
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x79f53b65, Offset: 0x48c5
// Size: 0x42
function function_928db17e31e77aa8( activityinstance )
{
    self endon( #"death" );
    activityinstance endon( #"activity_ended" );
    wait 1;
    self setstealthstate( "combat" );
    self notify( #"startCombatRush" );
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0xc769e2bc, Offset: 0x490f
// Size: 0x1e2
function function_f61e2813de0f81c7( var_ebf498d444523fd8 )
{
    self endon( #"activity_ended" );
    struct = self.s_center namespace_be3150865da9d2f1::get_linked_struct_filtered( "s_merc_camp_guard", "targetname" );
    
    if ( !isdefined( struct ) )
    {
        struct = self.s_center;
    }
    
    var_54862d4d96784cfd = 256;
    
    if ( isdefined( struct.radius ) )
    {
        var_54862d4d96784cfd = struct.radius;
    }
    
    var_8ce7664583d7129a = var_54862d4d96784cfd * var_54862d4d96784cfd;
    self waittill( #"player_attacking", player );
    self.var_430822dd1eb17760 = 1;
    
    while ( true )
    {
        var_9b7c145a00556747 = function_9b649316adcccbaa( var_ebf498d444523fd8 );
        var_18d0924d9095aaa9 = var_9b7c145a00556747.ai;
        
        if ( !isdefined( var_18d0924d9095aaa9 ) || var_18d0924d9095aaa9.size == 0 )
        {
            return;
        }
        
        var_c4a134f80d7d3fde = sortbydistance( var_18d0924d9095aaa9, struct.origin );
        
        foreach ( var_d937a8ac809622d5 in var_c4a134f80d7d3fde )
        {
            waitframe();
            
            if ( !isalive( var_d937a8ac809622d5 ) || var_d937a8ac809622d5.var_d229a71fb9fbe4d1 )
            {
                continue;
            }
            
            self.var_cd38a428a87732ce = var_d937a8ac809622d5;
            break;
        }
        
        if ( isdefined( self.var_cd38a428a87732ce ) )
        {
            self.var_cd38a428a87732ce ai_behavior::function_4a3c03bb49dd5d76( struct.origin, var_54862d4d96784cfd, 0 );
            self.var_cd38a428a87732ce waittill( #"death" );
        }
        
        wait randomfloatrange( 4, 6 );
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0xb47e28b2, Offset: 0x4af9
// Size: 0x13a
function function_e14717219f21c9b8()
{
    self endon( #"activity_ended" );
    var_ec53abb317948a11 = undefined;
    
    while ( true )
    {
        self waittill( #"player_attacking", player );
        self.lastattackedtime = gettime();
        
        if ( isdefined( player ) )
        {
            if ( player == var_ec53abb317948a11 )
            {
                wait 1;
                continue;
            }
            
            self.var_3e0be2038aacf981 = utility::array_removedead_or_dying( self.var_3e0be2038aacf981 );
            
            foreach ( soldier in self.var_3e0be2038aacf981 )
            {
                if ( isdefined( soldier ) && !isdefined( soldier.enemy ) )
                {
                    soldier notify( #"startCombatRush" );
                    soldier aieventlistenerevent( "combat", player, player.origin );
                    soldier getenemyinfo( player );
                    soldier forcethreatupdate();
                    waitframe();
                }
            }
            
            var_ec53abb317948a11 = player;
        }
        
        wait 1;
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0xaaf671af, Offset: 0x4c3b
// Size: 0xe3
function function_ddeaecc4702f0476()
{
    self endon( #"activity_ended" );
    assert( self.a_s_drone.size > 0, "<dev string:x99>" + "<dev string:xfc>" );
    
    while ( self.var_3e0be2038aacf981.size == 0 )
    {
        waitframe();
    }
    
    self.n_veh_speed = 25;
    var_9a80fef3bda93382 = self.a_s_drone[ 0 ];
    drone = ob_soldier_util::function_f8dc64379e93d335( var_9a80fef3bda93382, undefined );
    ob_resource_manager::activity_register_vehicle( drone );
    
    if ( isdefined( drone ) )
    {
        activity_participation::function_d041ee0ec570299d( drone );
        drone setneargoalnotifydist( 256 );
        drone.var_24954f14e27b448d = 1;
        drone.ignorelist = drone;
        drone thread namespace_28acf6540b1bc740::action_follow_path( var_9a80fef3bda93382, undefined, 40, 1 );
        drone thread function_513082067d02fdd2( self );
        self.a_vh_drone[ self.a_vh_drone.size ] = drone;
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x32083422, Offset: 0x4d26
// Size: 0x95
function function_922567a1ce765c40( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        function_4279fe11828ff026( player, 1 );
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x2bbe797d, Offset: 0x4dc3
// Size: 0x94
function function_d3ad44a1c30e2e6( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        function_4279fe11828ff026( player, 0 );
    }
}

// Namespace ob_activity_merc_camp
// Params 2
// Checksum 0x8a4de470, Offset: 0x4e5f
// Size: 0x126
function function_4279fe11828ff026( player, playerinzone )
{
    if ( !self.var_82990baca12b59e8 || activity_instance_common::getactivitystate( self ) != "Active" )
    {
        /#
            ob_humans::function_5224f34d2833fe25( player, self, "<dev string:x10e>" );
        #/
        
        return;
    }
    
    var_ba0dbe3ec176cc51 = self.var_aef199e9dadf99c2;
    
    if ( playerinzone )
    {
        /#
            ob_humans::function_5224f34d2833fe25( player, self, "<dev string:x138>" );
        #/
        
        if ( !isdefined( self.var_56ae48f9eceb8b3a ) )
        {
            self.var_56ae48f9eceb8b3a = [];
        }
        
        if ( !arraycontains( self.var_56ae48f9eceb8b3a, player ) )
        {
            if ( isarray( var_ba0dbe3ec176cc51 ) && var_ba0dbe3ec176cc51.size == 1 && isdefined( player.guid ) && var_ba0dbe3ec176cc51[ player.guid ] )
            {
                ob_activity_utility::function_894ac80e038636c5( "wcacheckpointbrief", [ player ] );
                self.var_56ae48f9eceb8b3a[ self.var_56ae48f9eceb8b3a.size ] = player;
            }
            else
            {
                /#
                    ob_humans::function_5224f34d2833fe25( player, self, "<dev string:x154>" );
                #/
            }
        }
        else
        {
            /#
                ob_humans::function_5224f34d2833fe25( player, self, "<dev string:x193>" );
            #/
        }
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x3ba16ecf, Offset: 0x4f8d
// Size: 0x41d
function camp_siren()
{
    self endon( #"instance_destroyed" );
    alarm_lights = [];
    
    foreach ( cover in self.var_366bb5477d1e8e05 )
    {
        foreach ( scriptable in cover.scriptables )
        {
            if ( scriptable getscriptablehaspart( #"vfx" ) )
            {
                alarm_lights[ alarm_lights.size ] = scriptable;
            }
        }
    }
    
    if ( self.a_s_alarm )
    {
        alarm_alias = self.a_s_alarm.script_noteworthy ?? "sat_ob_activity_camp_alarm";
        alarm_origin = self.a_s_alarm.origin;
    }
    else
    {
        awareness_zone_origin = spatial_zone_container::function_f7fc3e6c249a8256( self, "Awareness_Zone" )[ 0 ].origin;
        alarm_origin = ( awareness_zone_origin[ 0 ], awareness_zone_origin[ 1 ], awareness_zone_origin[ 2 ] + 200 );
        alarm_alias = "sat_ob_activity_stronghold_alarm";
    }
    
    var_4a7e50a07112c158 = max( level.framedurationseconds, lookupsoundlength( alarm_alias ) / 1000 );
    
    while ( true )
    {
        wait var_4a7e50a07112c158;
        
        if ( activity_instance_common::getactivitystate( self ) == "Ended" )
        {
            foreach ( light in alarm_lights )
            {
                light setscriptablepartstate( #"vfx", "off" );
            }
            
            return;
        }
        
        siren_on = 0;
        
        if ( self.var_772ce0ec7032e594 == 0 && self.var_f4f91556935fc7b8 == 0 )
        {
            continue;
        }
        
        foreach ( soldier in arraycombine( self.var_3e0be2038aacf981, self.var_b748d7198b3af123 ) )
        {
            if ( soldier.stealth_bsmstate != 0 && soldier.stealth_bsmstate != 4 )
            {
                siren_on = 1;
                break;
            }
        }
        
        if ( siren_on )
        {
            playsoundatpos( alarm_origin, alarm_alias );
            
            foreach ( light in alarm_lights )
            {
                light setscriptablepartstate( #"vfx", "on" );
            }
            
            continue;
        }
        
        foreach ( light in alarm_lights )
        {
            light setscriptablepartstate( #"vfx", "off" );
        }
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x707df551, Offset: 0x53b2
// Size: 0x1e9
function function_fbcc49e8d50eb781( players )
{
    if ( !( isdefined( self ) && isdefined( players ) ) || !isarray( players ) || players.size == 0 )
    {
        /#
            ob_humans::function_718254d8560b5513( self, "<dev string:x1ce>" );
        #/
        
        return;
    }
    
    self endon( #"activity_ended" );
    
    while ( !isdefined( self.var_b924e4853c511278 ) )
    {
        waitframe();
    }
    
    var_b5d893a66963d916 = 0;
    
    foreach ( player in players )
    {
        if ( ob_activity_vo_utility::is_squad_on_mission( player, 16152 ) || ob_activity_vo_utility::is_squad_on_mission( player, 17078 ) || getdvarint( @"hash_7b8b09c504a0c9a0", 0 ) )
        {
            params = spawnstruct();
            params.player = player;
            callback::callback( "approached_merc_camp", params );
            var_b5d893a66963d916 = 1;
        }
    }
    
    if ( !var_b5d893a66963d916 )
    {
        /#
            ob_humans::function_b43e56660c5cfc1f( player );
            ob_humans::function_5224f34d2833fe25( player, self, "<dev string:x200>" + self.var_b924e4853c511278 + "<dev string:x21e>" );
        #/
        
        switch ( self.var_b924e4853c511278 )
        {
            case #"hash_64ef5ee25b022921":
                activity_player_broadcasting::function_cb4750c84882dd07( "merc_camp_vo_approach_generic", players );
                break;
            case #"hash_f70b08ee00093db7":
                activity_player_broadcasting::function_cb4750c84882dd07( "merc_camp_vo_approach_sniper", players );
                break;
            case #"hash_25a0e6b2bfb7482c":
                activity_player_broadcasting::function_cb4750c84882dd07( "merc_camp_vo_approach_tactician", players );
                break;
            default:
                break;
        }
        
        return;
    }
    
    /#
        ob_humans::function_5224f34d2833fe25( player, self, "<dev string:x220>" );
    #/
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0xdf284122, Offset: 0x55a3
// Size: 0x1f2
function function_5ea8aab3b8d1f863()
{
    players = spatial_zone_container::function_84f653d797112085( self, "Awareness_Zone" );
    var_296b3965dee9889 = [];
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) || arraycontains( var_296b3965dee9889, player ) )
        {
            continue;
        }
        
        if ( ob_activity_vo_utility::is_squad_on_mission( player, 17078 ) || getdvarint( @"hash_7b8b09c504a0c9a0", 0 ) )
        {
            params = spawnstruct();
            params.player = player;
            callback::callback( "merc_camp_success", params );
            squadmembers = player squad_utility::getsquadmembers();
            
            foreach ( squadmember in squadmembers )
            {
                var_296b3965dee9889[ var_296b3965dee9889.size ] = squadmember;
            }
        }
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) || arraycontains( var_296b3965dee9889, player ) )
        {
            continue;
        }
        
        activity_player_broadcasting::function_cb4750c84882dd07( "merc_camp_vo_camp_cleared", [ player ] );
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0xfbbdfdf3, Offset: 0x579d
// Size: 0xeb
function function_69bf5a85b9232db4( lootingplayer )
{
    if ( !isdefined( lootingplayer ) )
    {
        return;
    }
    
    /#
        ob_humans::function_5224f34d2833fe25( lootingplayer, self, "<dev string:x252>" );
    #/
    
    if ( ob_activity_vo_utility::is_squad_on_mission( lootingplayer, 17078 ) || getdvarint( @"hash_7b8b09c504a0c9a0", 0 ) )
    {
        /#
            ob_humans::function_5224f34d2833fe25( lootingplayer, self, "<dev string:x270>" );
        #/
        
        params = spawnstruct();
        params.player = lootingplayer;
        callback::callback( "merc_camp_looted", params );
        return;
    }
    
    squad = lootingplayer squad_utility::getsquadmembers( lootingplayer.team, 1 );
    var_beb03108fb5917e6 = ob_activity_vo_utility::function_203aabe755cf54aa( lootingplayer, 1 );
    wait 1;
    
    /#
        ob_humans::function_b43e56660c5cfc1f( lootingplayer );
        ob_humans::function_5224f34d2833fe25( lootingplayer, self, "<dev string:x2a6>" );
    #/
    
    thread ob_activity_vo_utility::function_6caa1743696a5163( var_beb03108fb5917e6, "activity_merc_camp_key_looted", squad );
}

// Namespace ob_activity_merc_camp
// Params 0, eflags: 0x4
// Checksum 0x2ffea16d, Offset: 0x5890
// Size: 0x56
function private function_421792107922fbb2()
{
    self endon( #"death_or_disconnect" );
    wait 120;
    player = self;
    
    if ( ob_activity_vo_utility::is_squad_on_mission( player, 17078 ) )
    {
        player utility::ent_flag_clear( "quest_s0a3t3_merccamp_fail" );
        player utility::ent_flag_clear( "quest_s0a3t3_merccamp_success" );
        player utility::ent_flag_clear( "quest_s0a3t3_merccamp_approach" );
    }
}

/#

    // Namespace ob_activity_merc_camp
    // Params 0
    // Checksum 0xa90cd7b8, Offset: 0x58ee
    // Size: 0x5, Type: dev
    function function_b64a0e230e39c3bc()
    {
        
    }

#/

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x4d37b166, Offset: 0x58fb
// Size: 0xf1
function merc_camp_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, function_2a128245c3386a7e(), function_97a488fcd7301383() );
    
    foreach ( player in player_list )
    {
        if ( isplayer( player ) )
        {
            if ( var_99e714060e093089 == "PlayerJoinedProximity" )
            {
                self notify( #"player_proximity", player );
                continue;
            }
            
            if ( var_99e714060e093089 == "PlayerJoinedDamage" )
            {
                self notify( #"player_attacking", player );
            }
        }
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x1982d228, Offset: 0x59f4
// Size: 0x34
function merc_camp_player_left_activity( relevant_info_struct )
{
    if ( activity_instance_common::getactivitystate( self ) == "Ended" )
    {
        return;
    }
    
    ob_activity_utility::function_894ac80e038636c5( "wcacheckpointfail", relevant_info_struct.playerlist );
}

// Namespace ob_activity_merc_camp
// Params 0, eflags: 0x4
// Checksum 0x7a662719, Offset: 0x5a30
// Size: 0x15
function private function_2a128245c3386a7e()
{
    return self.var_f6acc3926b3da25e + self.var_7972a140ba94ec1e;
}

// Namespace ob_activity_merc_camp
// Params 0, eflags: 0x4
// Checksum 0x3fa88a37, Offset: 0x5a4e
// Size: 0x15
function private function_97a488fcd7301383()
{
    return self.var_772ce0ec7032e594 + self.var_f4f91556935fc7b8;
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x48b18144, Offset: 0x5a6c
// Size: 0x62
function function_40980edc87776a8b( relevantinfostruct )
{
    additional_spawn_data = activity_instance_common::function_a45920af4495e9f( self );
    
    if ( additional_spawn_data.var_5382c8093f54dd2c )
    {
        level.activities.obmerccamp.var_12e11e6f433f0a2a++;
        additional_spawn_data.var_71b6ce0e281f4b60.var_c9876a8e7895a3a = self;
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0xcb44fe36, Offset: 0x5ad6
// Size: 0x4b
function function_ab91f17beffa3e53( relevantinfostruct )
{
    additional_spawn_data = activity_instance_common::function_a45920af4495e9f( self );
    
    if ( additional_spawn_data.var_5382c8093f54dd2c )
    {
        level.activities.obmerccamp.var_12e11e6f433f0a2a--;
    }
}

// Namespace ob_activity_merc_camp
// Params 1
// Checksum 0x655ac74c, Offset: 0x5b29
// Size: 0x5a
function function_3b877b6b99163358( var_c9876a8e7895a3a )
{
    var_c9876a8e7895a3a endon( #"activity_ended" );
    var_c9876a8e7895a3a endon( #"instance_destroyed" );
    
    while ( true )
    {
        var_c9876a8e7895a3a waittill( #"hash_cd359b944e88899d" );
        
        if ( activity_instance_common::getactivitystate( var_c9876a8e7895a3a ) == "Active" )
        {
            break;
        }
    }
    
    activity_instance_common::endactivity( var_c9876a8e7895a3a, 0 );
}

// Namespace ob_activity_merc_camp
// Params 2
// Checksum 0xff2b0dfa, Offset: 0x5b8b
// Size: 0x1fd
function function_8cfd23439e11af5( var_c9876a8e7895a3a, participants )
{
    var_c9876a8e7895a3a endon( #"activity_ended" );
    var_c9876a8e7895a3a endon( #"instance_destroyed" );
    wait 1;
    
    if ( !var_c9876a8e7895a3a.computer_station || var_c9876a8e7895a3a.var_a4350e73a4097c74 )
    {
        return;
    }
    
    ping_owners = [];
    
    foreach ( player in participants )
    {
        var_c774c1b8025617e1 = 1;
        
        foreach ( var_c31894e7ad5a341e in ping_owners )
        {
            if ( squad_utility::function_6a77a8d0f8eb25b5( player, var_c31894e7ad5a341e ) )
            {
                var_c774c1b8025617e1 = 0;
                break;
            }
        }
        
        if ( var_c774c1b8025617e1 )
        {
            ping_owners[ ping_owners.size ] = player;
        }
    }
    
    ping_origin = var_c9876a8e7895a3a.computer_station.origin;
    ping_objectiveid = var_c9876a8e7895a3a.computer_station.index;
    
    foreach ( var_c31894e7ad5a341e in ping_owners )
    {
        var_c31894e7ad5a341e calloutmarkerping::function_920a63c06abdefe8( ping_objectiveid );
    }
}

// Namespace ob_activity_merc_camp
// Params 0
// Checksum 0x22275dc, Offset: 0x5d90
// Size: 0x24b
function function_6092d36d6b04c071()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_4fe2d491bc9efbff = ob_activity_manager::function_ed1dae3a9cce08d2( self.varianttag );
    
    if ( var_4fe2d491bc9efbff )
    {
        foreach ( var_af6e1e5aef347723 in var_4fe2d491bc9efbff )
        {
            additionalspawndata = undefined;
            chance = 100;
            
            switch ( var_af6e1e5aef347723.type )
            {
                case #"hash_df1adaaaad94657b":
                    chance = self.var_91c91f4a631c481d.var_b2c632657802ce1c;
                    break;
                case #"hash_92be5f48e2fa5497":
                    chance = self.var_91c91f4a631c481d.var_99f9fd33a8fced2e;
                    break;
                case #"hash_e0b78d9eb13b0bac":
                    chance = self.var_92ac5b0ebd14fc08 && self.var_92ac5b0ebd14fc08 > 0 ? self.var_92ac5b0ebd14fc08 : self.var_91c91f4a631c481d.var_8e1bef679bfdf073;
                    break;
                default:
                    break;
            }
            
            if ( var_af6e1e5aef347723.type == "REV_OB_SUPPLY_DROP" )
            {
                if ( !isdefined( level.activities.obmerccamp ) )
                {
                    level.activities.obmerccamp = { #var_12e11e6f433f0a2a:0 };
                }
                
                if ( level.activities.obmerccamp.var_12e11e6f433f0a2a >= self.var_91c91f4a631c481d.var_b256198953b66c88 )
                {
                    logstring( "Merc camp skip spawn linked supply drop, maximum merc camp allowed supply drop reached " + self.var_91c91f4a631c481d.var_b256198953b66c88 );
                    continue;
                }
                
                additionalspawndata = { #var_71b6ce0e281f4b60:self, #var_d9274cd4b9b9a361:1, #var_5382c8093f54dd2c:1 };
            }
            
            level thread ob_activity_manager::function_8c2371421d37415a( var_af6e1e5aef347723, chance, additionalspawndata );
            throttle::throttle_wait_in_queue( level.setup_linked_activities_throttle, self );
        }
    }
}

// Namespace ob_activity_merc_camp
// Params 0, eflags: 0x4
// Checksum 0xb437c4c3, Offset: 0x5fe3
// Size: 0x18a
function private function_7c3640f139309ce7()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self waittill( #"player_attacking" );
    
    while ( true )
    {
        wait 1;
        
        if ( self.playerparticipants.size == 0 )
        {
            continue;
        }
        
        foreach ( agent in self.var_3e0be2038aacf981 )
        {
            if ( !isalive( agent ) || self.var_2595e35f3b867fb4 != agent.directorrequestid )
            {
                continue;
            }
            
            if ( function_fbce29cb62d44d3b( agent ) )
            {
                agent kill();
            }
        }
        
        foreach ( agent in self.var_b748d7198b3af123 )
        {
            if ( !isalive( agent ) || self.var_2595e35f3b867fb4 != agent.directorrequestid )
            {
                continue;
            }
            
            if ( function_fbce29cb62d44d3b( agent ) )
            {
                agent kill();
            }
        }
    }
}

// Namespace ob_activity_merc_camp
// Params 1, eflags: 0x4
// Checksum 0x96ae5557, Offset: 0x6175
// Size: 0x104
function private function_fbce29cb62d44d3b( agent )
{
    agent endon( #"death" );
    start_origin = self.s_center.origin;
    
    if ( modelhastag( agent.model, "j_spine4" ) )
    {
        start_origin = agent gettagorigin( "j_spine4" );
    }
    else
    {
        dump_agent_info( agent, "below ground" );
    }
    
    if ( self.s_center.origin[ 2 ] - start_origin[ 2 ] > 1000 )
    {
        return 1;
    }
    
    throttle::throttle_wait_in_queue( level.merc_camp_blocker_agent_throttle, agent );
    wait randomfloatrange( 0.1, 0.2 );
    trace_result = trace::ray_trace( start_origin, start_origin + ( 0, 0, -1000 ), [ agent ], trace::create_solid_ai_contents( 1 ) );
    
    if ( !isdefined( trace_result ) || trace_result[ "hittype" ] == "hittype_none" )
    {
        return 1;
    }
    
    return 0;
}

