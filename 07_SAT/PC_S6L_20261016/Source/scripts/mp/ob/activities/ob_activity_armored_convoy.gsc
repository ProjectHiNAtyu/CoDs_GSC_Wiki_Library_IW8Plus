// scripts\mp\ob\activities\ob_activity_armored_convoy.gsc  (hash_37aaa4cf3f98bb4f.gscc) (size: 7333 Bytes / 0x1ca5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x745f97f9 (1952421881)
// size ...... 7333 (0x1ca5)
// includes .. 16  (offset: 0x1aa1)
// strings ... 21  (offset: 0x1b21)
// dev strs .. 8   (offset: 0x1c41)
// exports ... 21  (offset: 0xf59)
// cseg ...... 0x22b + 0xd2e (0xf59)
// imports ... 69  (offset: 0x12a1)
// animtree1 . 0   (offset: 0x1ca5)
// animtree2 . 0   (offset: 0x1ca5)
#using script_5f501fbedf0953f;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_scriptables;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\loot\common_cache;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\ob_convoy_util;
#using scripts\mp\ob\systems\ob_activity_instance_common;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_activity_armored_convoy;

// Namespace ob_activity_armored_convoy
// Params 0, eflags: 0x5
// Checksum 0x8191f854, Offset: 0x249
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_1e792c98047cfa28", #"activity_common", &function_7e507f17a2c1ccc0, undefined );
}

// Namespace ob_activity_armored_convoy
// Params 0, eflags: 0x4
// Checksum 0x530cf59b, Offset: 0x272
// Size: 0x13
function private function_7e507f17a2c1ccc0()
{
    activity_common::registeractivitytype( "REV_OB_ARMORED_CONVOY", &function_76a121069ca15361 );
}

// Namespace ob_activity_armored_convoy
// Params 0
// Checksum 0xb0a65598, Offset: 0x28d
// Size: 0x1a5
function function_76a121069ca15361()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_ARMORED_CONVOY", 0, &namespace_f384a0805440e6ab::function_8d04b6e332b104af );
    activity_common::function_944074f3079c1d4e( "REV_OB_ARMORED_CONVOY", 1, &armored_convoy_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_ARMORED_CONVOY", 2, &namespace_f384a0805440e6ab::function_aa78d0adc78609ef );
    activity_common::function_944074f3079c1d4e( "REV_OB_ARMORED_CONVOY", 3, &namespace_f384a0805440e6ab::function_65cf1a7814dc05cc );
    activity_common::function_944074f3079c1d4e( "REV_OB_ARMORED_CONVOY", 4, &namespace_f384a0805440e6ab::function_a02484466dfd0cdb );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_4dcf44cdf76bb5ed, "REV_OB_ARMORED_CONVOY" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &namespace_f384a0805440e6ab::function_d06081717767fc6d, "REV_OB_ARMORED_CONVOY" );
    utility::registersharedfunc( #"hash_3d4481e54c199ae4", #"hash_a9b37ef5c1f86827", &function_c17ae5b79de317c7 );
    utility::registersharedfunc( #"hash_3d4481e54c199ae4", #"hash_ca89108500931062", &function_ab4bd54e8d6bdd56 );
    utility::registersharedfunc( #"hash_3d4481e54c199ae4", #"hash_21865e91bbe91f42", &function_8ad5ad04a4fb83ec );
    utility::registersharedfunc( #"hash_3d4481e54c199ae4", #"hash_9b8883333137f592", &function_d98c440afd38b20 );
    utility::registersharedfunc( #"hash_3d4481e54c199ae4", #"hash_1696460b6fd16672", &function_c3a1d427fbaa5929 );
    utility::registersharedfunc( #"hash_3d4481e54c199ae4", #"hash_7c46e0eba7b87d1f", &function_fe68b6c682b5f13c );
    utility::registersharedfunc( #"hash_3d4481e54c199ae4", #"hash_1c9144f0a3015dba", &function_dee09b211f23a6fd );
    utility::registersharedfunc( #"hash_3d4481e54c199ae4", #"hash_654756dcb26260ad", &function_163e42f49383891a );
    utility::registersharedfunc( #"hash_3d4481e54c199ae4", #"hash_a3a16920ec351b48", &ob_resource_manager::activity_spawn_vehicle );
    
    /#
        level thread function_195aaa8ed920fb32();
    #/
}

// Namespace ob_activity_armored_convoy
// Params 1, eflags: 0x4
// Checksum 0x13be27eb, Offset: 0x43a
// Size: 0x37
function private function_4dcf44cdf76bb5ed( relevant_info_struct )
{
    namespace_f384a0805440e6ab::function_4dcf44cdf76bb5ed( relevant_info_struct );
    player_list = relevant_info_struct.playerlist;
    namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, 0, 1 );
}

// Namespace ob_activity_armored_convoy
// Params 1
// Checksum 0xf2c6dce2, Offset: 0x479
// Size: 0x76
function function_c17ae5b79de317c7( convoyparams )
{
    self.var_8ac4adf7bae6f45a = region_difficulty_manager::get_region_difficulty( self.nd_spline_start.origin );
    self.difficulty_region = self.var_8ac4adf7bae6f45a;
    
    if ( self.var_8ac4adf7bae6f45a == "difficulty_undefined" )
    {
        self.var_8ac4adf7bae6f45a = getdvar( @"hash_600f124219762287", "difficulty_easy" );
    }
    
    namespace_f384a0805440e6ab::function_da8ee699f89950b4( convoyparams );
}

// Namespace ob_activity_armored_convoy
// Params 0
// Checksum 0x4aaa2dd5, Offset: 0x4f7
// Size: 0x8
function function_ab4bd54e8d6bdd56()
{
    return namespace_f384a0805440e6ab::function_9dfc1f6914f4a7d5();
}

// Namespace ob_activity_armored_convoy
// Params 1
// Checksum 0x1ac2047b, Offset: 0x508
// Size: 0x14
function function_8ad5ad04a4fb83ec( var_fbc9b9a942a814f9 )
{
    return namespace_f384a0805440e6ab::function_deb352f09e1247cf( var_fbc9b9a942a814f9 );
}

// Namespace ob_activity_armored_convoy
// Params 1
// Checksum 0xf3dfddd0, Offset: 0x525
// Size: 0x14
function function_d98c440afd38b20( var_fbc9b9a942a814f9 )
{
    return namespace_f384a0805440e6ab::function_7fb97e96ec4d15a3( var_fbc9b9a942a814f9 );
}

// Namespace ob_activity_armored_convoy
// Params 1
// Checksum 0xa5713813, Offset: 0x542
// Size: 0x187
function function_babd34fe09dc1bdc( vehicle )
{
    e_loot_crate = spawnscriptable( self.var_ef091d37dff54373, vehicle.origin );
    
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
        default:
            var_85c1572ce2d3e84b = ( -50, 0, -10 );
            break;
    }
    
    e_loot_crate utility::scriptable_setparententity( vehicle, var_85c1572ce2d3e84b, ( 0, 90, 0 ) );
    e_loot_crate setscriptablepartstate( "body", #"closed_usable_no_collision" );
    
    if ( self.regiondifficulty )
    {
        if ( self.var_8ac4adf7bae6f45a == "difficulty_easy" )
        {
            var_49167480b31d844b = 3;
            var_a36a123d827025e1 = self.var_e90fa0d985dd486d;
        }
        else
        {
            var_49167480b31d844b = 4;
            var_a36a123d827025e1 = self.var_45008a5d7d3b0506;
        }
    }
    else
    {
        var_49167480b31d844b = 3;
        var_a36a123d827025e1 = self.var_e90fa0d985dd486d;
    }
    
    common_cache::fillcontentsfromlist( e_loot_crate, var_a36a123d827025e1, var_49167480b31d844b );
    thread _relocate_loot_cache( vehicle );
    vehicle.var_7efd2ef630bd1000 = e_loot_crate;
    self.a_loot_caches[ self.a_loot_caches.size ] = e_loot_crate;
}

// Namespace ob_activity_armored_convoy
// Params 2
// Checksum 0x42dafe99, Offset: 0x6d1
// Size: 0x9c
function function_c3a1d427fbaa5929( activity_instance, player_list )
{
    activity_instance ob_activity_utility::function_894ac80e038636c5( "wcaconvoybrief", player_list );
    
    foreach ( player in player_list )
    {
        player callback::callback( "on_approach_convoy" );
    }
}

// Namespace ob_activity_armored_convoy
// Params 3
// Checksum 0xe0d787c9, Offset: 0x775
// Size: 0xb3
function function_fe68b6c682b5f13c( activity_instance, var_7e84a1b2d6501f11, attacker )
{
    activity_instance ob_activity_utility::function_894ac80e038636c5( "wcaconvoyfight", [ attacker ] );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player callback::callback( "on_engage_convoy" );
    }
}

// Namespace ob_activity_armored_convoy
// Params 2
// Checksum 0xc8a876e0, Offset: 0x830
// Size: 0x95
function function_dee09b211f23a6fd( activity_instance, var_8411d4fa278141f1 )
{
    foreach ( player in activity_instance.playerparticipants )
    {
        player callback::callback( "on_destroy_convoy" );
    }
}

// Namespace ob_activity_armored_convoy
// Params 2
// Checksum 0x4ea82d5a, Offset: 0x8cd
// Size: 0x49
function function_163e42f49383891a( activity_instance, relevant_info_struct )
{
    if ( isdefined( activity_instance ) && activity_instance.state != "Ended" )
    {
        activity_instance ob_activity_utility::function_894ac80e038636c5( "wcaconvoyfail", relevant_info_struct.playerlist );
    }
}

// Namespace ob_activity_armored_convoy
// Params 0
// Checksum 0x7a049a9c, Offset: 0x91e
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

// Namespace ob_activity_armored_convoy
// Params 1, eflags: 0x4
// Checksum 0xc8b01cfc, Offset: 0x98a
// Size: 0x119
function private _relocate_loot_cache( vehicle )
{
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

// Namespace ob_activity_armored_convoy
// Params 0, eflags: 0x4
// Checksum 0xcc7c7509, Offset: 0xaab
// Size: 0xb1
function private armored_convoy_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    scriptable = activity_scriptables::function_e54570745bff582e( self, "sat_ob_armored_convoy_center_objective_marker", self.var_83e013bcaf310285.origin + ( 0, 0, 90 ), "ActivityEnd" );
    ob_activity_instance_common::function_9c6b2d04234d7b5e( self, scriptable );
    scriptable utility::scriptable_setparententity( self.var_83e013bcaf310285, ( 0, 0, 180 ), ( 0, 0, 0 ) );
    namespace_f384a0805440e6ab::armored_convoy_activity_begin();
    
    if ( getdvarint( @"hash_3a2d4f17dd9ba711", 1 ) )
    {
        wait 5;
        thread setup_pit();
    }
}

// Namespace ob_activity_armored_convoy
// Params 0, eflags: 0x4
// Checksum 0x9d20a0bf, Offset: 0xb64
// Size: 0x13a
function private setup_pit()
{
    foreach ( vehicle in self.a_vh_ground )
    {
        if ( !vehicle vehicle::is_husk() )
        {
            vehicle physics_registerforcollisioncallback();
        }
        
        vehicle thread ob_convoy_util::function_4b9cb0a28bb6273f();
        vehicle thread ob_convoy_util::function_9ce1eb1748c8b4fa();
    }
    
    utility::waittill_any( "activity_ended", "instance_destroyed" );
    
    if ( self.a_vh_ground )
    {
        foreach ( vehicle in self.a_vh_ground )
        {
            if ( !vehicle vehicle::is_husk() )
            {
                vehicle notify( #"stop_pit" );
                vehicle physics_unregisterforcollisioncallback();
            }
        }
    }
}

/#

    // Namespace ob_activity_armored_convoy
    // Params 0
    // Checksum 0x9ebac222, Offset: 0xca6
    // Size: 0x34, Type: dev
    function function_195aaa8ed920fb32()
    {
        wait 5;
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x61>", "<dev string:x88>", &function_a303bf15893d08f1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_activity_armored_convoy
    // Params 0, eflags: 0x4
    // Checksum 0x1edc943b, Offset: 0xce2
    // Size: 0x91, Type: dev
    function private function_a303bf15893d08f1()
    {
        logstring( "<dev string:xbb>" );
        params = [];
        params[ 0 ] = "<dev string:xda>";
        params[ 1 ] = "<dev string:xe3>";
        var_4f59973c28f149d6 = [[ level.var_690cc31a674a33ec.var_2ca79148edf22998 ]]( params[ 0 ], params[ 1 ], level.players[ 0 ].origin );
        
        if ( isdefined( var_4f59973c28f149d6 ) )
        {
            [[ level.var_690cc31a674a33ec.var_6af90d5c7779f340 ]]( var_4f59973c28f149d6 );
            var_4f59973c28f149d6 thread function_5663e6c947e2dcee();
        }
    }

    // Namespace ob_activity_armored_convoy
    // Params 0, eflags: 0x4
    // Checksum 0x699713c1, Offset: 0xd7b
    // Size: 0x1de, Type: dev
    function private function_5663e6c947e2dcee()
    {
        level endon( #"game_ended" );
        pathstruct = utility::getstruct( self.name, "<dev string:xf9>" );
        var_336cee9e631eaae = [];
        loopingcomplete = 0;
        currentnode = getvehiclenode( pathstruct.script_linkto, "<dev string:x104>" );
        var_833008e1b61489db = undefined;
        var_7fcb11a5cd0459fe = undefined;
        
        while ( isdefined( currentnode ) )
        {
            var_336cee9e631eaae[ var_336cee9e631eaae.size ] = currentnode;
            
            if ( isdefined( currentnode.target ) )
            {
                cachenode = getvehiclenode( currentnode.target, "<dev string:xf9>" );
                
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

#/
