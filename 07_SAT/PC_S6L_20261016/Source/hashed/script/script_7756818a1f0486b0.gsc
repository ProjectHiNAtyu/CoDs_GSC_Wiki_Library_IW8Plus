// script_7756818a1f0486b0  (hash_7756818a1f0486b0.gscc) (size: 59915 Bytes / 0xea0b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf18a77f (2937628543)
// size ...... 59915 (0xea0b)
// includes .. 31  (offset: 0xd65f)
// strings ... 268 (offset: 0xd757)
// dev strs .. 27  (offset: 0xe89f)
// exports ... 95  (offset: 0xa14b)
// cseg ...... 0x1ccd + 0x847e (0xa14b)
// imports ... 267 (offset: 0xb023)
// animtree1 . 0   (offset: 0xea0b)
// animtree2 . 0   (offset: 0xea0b)
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_collision;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_redeploy_drone;
#using scripts\mp\br\gametypes\br_scavenger_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\flags;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\rank;
#using scripts\mp\uav_tower;
#using scripts\mp\weapons;

#namespace br_research_vessel;

// Namespace br_research_vessel
// Params 0, eflags: 0x1
// Checksum 0xa991af25, Offset: 0x1ceb
// Size: 0xa48
function autoexec init()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    br_scavenger_quest::function_c0e40cd3d5a09287( getent( "research_vessel_scavenger_cache_exclusion", "targetname" ) );
    utility::add_fx( "research_vessel_vfx_main", "vfx_iw9_jup_br_level_mp_sm_island_2_dd2_vessel_wake_main" );
    utility::flag_wait( "scriptables_ready" );
    level.research_vessel = getent( "research_vessel", "targetname" );
    level.research_vessel_clip = getent( "research_vessel_clip", "targetname" );
    research_vessel_pieces = getentarray( "research_vessel_piece", "targetname" );
    research_vessel_lights = getentarray( "research_vessel_light", "targetname" );
    research_vessel_audio_triggers = getentarray( "research_vessel_audio_trigger", "targetname" );
    research_vessel_audio_triggers[ research_vessel_audio_triggers.size ] = getent( "research_vessel_audio_vessel", "targetname" );
    level.research_vessel function_82b804c0aec6cc65();
    
    if ( !getdvarint( @"hash_54c6fa832912916", 1 ) )
    {
        level.research_vessel function_26131cae41c989b7();
        level waittill( #"prematch_fade_done" );
        level.research_vessel research_vessel_heli_cleanup();
        level.research_vessel research_vessel_scriptables_cleanup();
        
        if ( isdefined( level.research_vessel ) )
        {
            level.research_vessel delete();
        }
        
        if ( isdefined( level.research_vessel_clip ) )
        {
            level.research_vessel_clip delete();
        }
        
        if ( isdefined( research_vessel_pieces ) )
        {
            foreach ( piece in research_vessel_pieces )
            {
                piece delete();
            }
        }
        
        if ( isdefined( research_vessel_lights ) )
        {
            foreach ( lighting_fixture in research_vessel_lights )
            {
                lighting_fixture delete();
            }
        }
        
        if ( isdefined( research_vessel_audio_triggers ) )
        {
            foreach ( trigger in research_vessel_audio_triggers )
            {
                trigger delete();
            }
        }
        
        locked_door_clip = getent( "research_vessel_door_clip", "targetname" );
        locked_door_clip delete();
        locked_door_clip_hack = getent( "research_vessel_door_clip_hack", "targetname" );
        
        if ( isdefined( locked_door_clip_hack ) )
        {
            locked_door_clip_hack delete();
        }
        
        research_vessel_navmesh = getentarray( "research_vessel_ai_navmesh", "targetname" );
        
        if ( isdefined( research_vessel_navmesh ) )
        {
            foreach ( navmesh in research_vessel_navmesh )
            {
                navmesh delete();
            }
        }
        
        return;
    }
    
    assert( isdefined( level.research_vessel ), "<dev string:x24>" );
    assert( isdefined( level.research_vessel_clip ), "<dev string:xa4>" );
    assert( isdefined( research_vessel_pieces ), "<dev string:x122>" );
    
    /#
        level thread debug_init();
    #/
    
    level.research_vessel forcenetfieldhighlod( 1 );
    level.research_vessel setmoverantilagged( 1 );
    level.research_vessel setmoveroptimized( 1 );
    level.research_vessel_clip forcenetfieldhighlod( 1 );
    level.research_vessel_clip setmoverantilagged( 1 );
    level.research_vessel_clip setmoveroptimized( 1 );
    level.research_vessel_clip linkto( level.research_vessel );
    level.research_vessel_clip setascenderignorecollision( 1 );
    level.research_vessel_clip.unresolved_collision_kill = 1;
    
    foreach ( piece in research_vessel_pieces )
    {
        if ( piece.model == "veh_jup_mil_research_vessel_top_room" )
        {
            level.research_vessel_top_room = piece;
        }
        
        piece forcenetfieldhighlod( 1 );
        piece setmoverantilagged( 1 );
        piece setmoveroptimized( 1 );
        piece linkto( level.research_vessel );
    }
    
    foreach ( light in research_vessel_lights )
    {
        light linkto( level.research_vessel );
    }
    
    a_probes = [];
    a_probes[ 0 ] = getent( "vessel_rfl_probe_LOD1", "targetname" );
    a_probes[ 1 ] = getent( "vessel_rfl_probe_LOD0_1", "targetname" );
    a_probes[ 2 ] = getent( "vessel_rfl_probe_LOD0_2", "targetname" );
    a_probes[ 3 ] = getent( "vessel_rfl_probe_LOD0_3", "targetname" );
    a_probes[ 4 ] = getent( "vessel_rfl_probe_LOD0_4", "targetname" );
    a_probes[ 5 ] = getent( "vessel_rfl_probe_LOD0_5", "targetname" );
    a_probes[ 6 ] = getent( "vessel_rfl_probe_LOD0_6", "targetname" );
    a_probes[ 7 ] = getent( "vessel_rfl_probe_LOD0_7", "targetname" );
    a_probes[ 8 ] = getent( "vessel_rfl_probe_LOD0_8", "targetname" );
    a_probes[ 9 ] = getent( "vessel_rfl_probe_LOD0_9", "targetname" );
    
    foreach ( probe in a_probes )
    {
        probe linkto( level.research_vessel );
    }
    
    foreach ( trigger in research_vessel_audio_triggers )
    {
        trigger enablelinkto();
        trigger linkto( level.research_vessel );
        trigger::makeenterexittrigger( trigger, &research_vessel_audio_trigger_enter, &research_vessel_audio_trigger_exit );
    }
    
    level.research_vessel.moving_platform_ents = arraycombine( [ level.research_vessel, level.research_vessel_clip ], research_vessel_pieces );
    level.research_vessel.a_str_paths = [ "beach", "crater", "konni", "gazebo", "keep", "lighthouse", "pier", "town" ];
    level.research_vessel.a_s_destinations = [];
    
    foreach ( str in level.research_vessel.a_str_paths )
    {
        level.research_vessel.a_s_destinations[ str ] = utility::getstruct( "research_vessel_" + str + "_end", "targetname" );
    }
    
    if ( getdvarint( @"scr_research_vessel_aprilfools" ) )
    {
        level.research_vessel.a_s_destinations[ "aprilfools" ] = utility::getstruct( "research_vessel_aprilfools_end", "targetname" );
        setdvar( @"hash_4f6cf77fc759724c", 1500 );
        setdvar( @"hash_3e2527f66bfc3dd3", 1500 );
    }
    
    level.research_vessel thread function_f86518467a624ab2();
    killstreak_utility::function_44cbe91072276a84( &function_44c13ba7a3c5f9e1 );
    killstreak_utility::function_dcf4549703176a17( &function_44c13ba7a3c5f9e1 );
    flags::gameflagwait( "prematch_fade_done" );
    var_2835d2659cb4515a = getdvar( @"hash_dbb3bd49f0aeed0e", "" );
    
    if ( var_2835d2659cb4515a == "" )
    {
        var_2835d2659cb4515a = undefined;
    }
    
    level.research_vessel function_7a74104a2c974fdd( var_2835d2659cb4515a );
    level.research_vessel thread function_15c0f49dfb82c50e();
    level.research_vessel thread function_6a8da3c401990942();
    level.research_vessel thread research_vessel_match_start();
    level callback::add( #"cache_opened", &function_48d495a74a5dada2 );
    
    if ( getdvarint( @"hash_1fa530550ac5e3ca", 1 ) )
    {
        utility::registersharedfunc( #"assault_drone", #"hash_43597075da251a73", &function_ac89ef5650a8e9 );
        utility::registersharedfunc( #"radar_drone_recon", #"hash_43597075da251a73", &function_ac89ef5650a8e9 );
    }
    
    if ( getdvarint( @"hash_8fb5c42f58ebc26b", 0 ) )
    {
        utility::registersharedfunc( #"lrad", #"hash_43597075da251a73", &function_91309c8d98117177 );
    }
    
    helper_drone::function_7d135d70a58856f6( &function_dcaa97c6e855f2b );
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x955b20be, Offset: 0x273b
// Size: 0xb7
function function_15c0f49dfb82c50e()
{
    var_fe5cfc6ca2b96aba = getentitylessscriptablearray( "redeploy_drone_research_vessel", "script_noteworthy" );
    
    if ( !var_fe5cfc6ca2b96aba.size )
    {
        return;
    }
    
    self.redeploy_drone = sortbydistance( var_fe5cfc6ca2b96aba, self.var_ad2aab3cb9ffb7b[ self.var_ad2aab3cb9ffb7b.size - 1 ].origin )[ 0 ];
    self.redeploy_drone.isredeploydrone = 1;
    self.redeploy_drone.b_skip_repopulate = 1;
    
    /#
        utility::function_95db22f620602461( @"scr_debug_redeploy_drones", &debug::sphere, [ self.redeploy_drone, 200, "<dev string:x1a2>" ] );
    #/
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x6fd6420b, Offset: 0x27fa
// Size: 0xb7
function function_6a8da3c401990942()
{
    var_fe5cfc6ca2b96aba = getentitylessscriptablearray( "redeploy_drone_research_vessel_exfil", "script_noteworthy" );
    
    if ( !var_fe5cfc6ca2b96aba.size )
    {
        return;
    }
    
    self.exfil_drone = sortbydistance( var_fe5cfc6ca2b96aba, self.var_ad2aab3cb9ffb7b[ self.var_ad2aab3cb9ffb7b.size - 1 ].origin )[ 0 ];
    self.exfil_drone.isredeploydrone = 1;
    self.exfil_drone.b_skip_repopulate = 1;
    
    /#
        utility::function_95db22f620602461( @"scr_debug_redeploy_drones", &debug::sphere, [ self.exfil_drone, 200, "<dev string:x1a7>" ] );
    #/
}

// Namespace br_research_vessel
// Params 1, eflags: 0x4
// Checksum 0x207ee0b0, Offset: 0x28b9
// Size: 0x2e
function private function_44c13ba7a3c5f9e1( movingplatforment )
{
    if ( !isdefined( movingplatforment ) )
    {
        return 0;
    }
    
    return arraycontains( level.research_vessel.moving_platform_ents, movingplatforment );
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xbeddbcd9, Offset: 0x28f0
// Size: 0x20b
function function_f86518467a624ab2()
{
    var_713c52e98a79af68 = utility::getstructarray( "research_vessel_scriptables", "script_noteworthy" );
    
    foreach ( struct in var_713c52e98a79af68 )
    {
        str_standalone = getsubstr( struct.targetname, 11 );
        scr_standalone = spawnscriptable( str_standalone, struct.origin, struct.angles );
        v_offset = scr_standalone.origin - self.origin;
        scr_standalone scriptablesetparententity( self, v_offset, scr_standalone.angles );
        
        if ( scr_standalone.type == "military_ascendertop_heavy" )
        {
            if ( !isdefined( self.ascenders_actual ) )
            {
                self.ascenders_actual = [];
            }
            
            self.ascenders_actual[ self.ascenders_actual.size ] = scr_standalone.origin - self.origin;
            scr_standalone freescriptable();
        }
    }
    
    a_scr = getentitylessscriptablearray( undefined, undefined, self.origin, 2000 );
    
    foreach ( var_b3053b25c717315a in a_scr )
    {
        if ( var_b3053b25c717315a.type == "ammo_restock" )
        {
            var_b3053b25c717315a setscriptablepartstate( "model", "hidden" );
        }
    }
    
    function_26131cae41c989b7();
    boat_initcollision();
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x272553e4, Offset: 0x2b03
// Size: 0xdf
function research_vessel_match_start()
{
    function_bb97b0a5ba25c870();
    thread function_1f2a1d22c2bd46e1();
    thread function_73f1c538118bf9c4();
    thread research_vessel_ascenders();
    thread research_vessel_gas_exclusion_button();
    thread research_vessel_horn();
    thread research_vessel_locked_door();
    thread research_vessel_locked_door_loot();
    thread research_vessel_uav_tower();
    thread function_d18f5969b24aaff5();
    
    if ( getdvarint( @"scr_research_vessel_heli_locked", 1 ) && !getdvarint( @"hash_a1c6f1032781dfcd", 0 ) )
    {
        thread research_vessel_locked_heli();
    }
    
    wait 2;
    thread function_9bf319d9b185aee();
    level thread function_aea30ef65100adc9();
    level.research_vessel_clip setmovingplatformdef( "movingplatform_rotator" );
    level.research_vessel_clip.vehiclename = "veh_jup_research_vessel";
    level.research_vessel_clip.bundlename = %"hash_6d3feafb24bc9d6c";
    self setscriptablepartstate( "objective", "objective_active" );
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x37e8de, Offset: 0x2bea
// Size: 0xc37
function function_1f2a1d22c2bd46e1()
{
    level.research_vessel.sfx = [];
    level.research_vessel.sfx[ "underside_center_above_water" ] = spawnscriptable( "research_vessel_sfx_underside_center_above_water", ( -375, 0, -4988 ) );
    level.research_vessel.sfx[ "underside_center_below_water" ] = spawnscriptable( "research_vessel_sfx_underside_center_below_water", ( -375, 0, -5070 ) );
    level.research_vessel.sfx[ "pontoon_front_right" ] = spawnscriptable( "research_vessel_sfx_pontoon_front_right", ( 922.5, -310.5, -4988 ) );
    level.research_vessel.sfx[ "pontoon_front_left" ] = spawnscriptable( "research_vessel_sfx_pontoon_front_left", ( 922.5, 310.5, -4980 ) );
    level.research_vessel.sfx[ "pontoon_back_right" ] = spawnscriptable( "research_vessel_sfx_pontoon_back_right", ( -1800, -279, -4988 ) );
    level.research_vessel.sfx[ "pontoon_back_left" ] = spawnscriptable( "research_vessel_sfx_pontoon_back_left", ( -1800, 272, -4988 ) );
    level.research_vessel.sfx[ "engine_right" ] = spawnscriptable( "research_vessel_sfx_engine_right", ( -1484, -239, -4949 ) );
    level.research_vessel.sfx[ "engine_left" ] = spawnscriptable( "research_vessel_sfx_engine_left", ( -1484, 239, -4949 ) );
    level.research_vessel.sfx[ "locked_door" ] = spawnscriptable( "research_vessel_sfx_locked_door", ( -309, -282, -4588 ) );
    level.research_vessel.sfx[ "audio_emt_hull_01" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_ext_01", ( -379, 187, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_02" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_ext_02", ( -73, 186, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_03" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_ext_03", ( -653, 189, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_04" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_ext_04", ( -864, 176, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_05" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_ext_05", ( -1155, 179, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_06" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_ext_06", ( -1477, 177, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_07" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_ext_07", ( -1739, 181, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_08" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_ext_08", ( 239, 180, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_09" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_ext_09", ( 555, 187, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_10" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_int_01", ( 804, 194, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_11" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_int_02", ( 661, -184, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_12" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_int_03", ( 410, -182, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_13" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_int_04", ( 95, -185, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_14" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_int_05", ( -251, -190, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_15" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_int_06", ( -551, -188, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_16" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_int_07", ( -789, -182, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_17" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_int_08", ( -1016, -182, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_18" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_int_09", ( -1338, -177, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_19" ] = spawnscriptable( "research_vessel_audio_emt_hull_port_int_10", ( -1614, -173, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_20" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_ext_01", ( -1588, -415, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_21" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_ext_02", ( -1328, -422, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_22" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_ext_03", ( -1022, -425, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_23" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_ext_04", ( -799, -424, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_24" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_ext_05", ( -552, -426, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_25" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_ext_06", ( -258, -430, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_26" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_ext_07", ( 92, -429, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_27" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_ext_08", ( 414, -435, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_28" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_ext_09", ( 664, -430, -4970 ), ( 0, 0, -90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_29" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_int_01", ( 791, 407, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_30" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_int_02", ( 543, 431, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_31" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_int_03", ( 227, 428, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_32" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_int_04", ( -658, 419, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_33" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_int_05", ( -863, 417, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_34" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_int_06", ( -1479, 410, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_35" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_int_07", ( -379, 187, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_36" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_int_08", ( -379, 187, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_hull_37" ] = spawnscriptable( "research_vessel_audio_emt_hull_starboard_int_09", ( -379, 187, -4970 ), ( 0, 0, 90 ) );
    level.research_vessel.sfx[ "audio_emt_vent_01" ] = spawnscriptable( "research_vessel_audio_emt_vent_01", ( -403, -250, -4370 ) );
    level.research_vessel.sfx[ "audio_emt_vent_02" ] = spawnscriptable( "research_vessel_audio_emt_vent_02", ( -561, 274, -4370 ) );
    level.research_vessel.sfx[ "audio_emt_vent_03" ] = spawnscriptable( "research_vessel_audio_emt_vent_03", ( -394, 273, -4370 ) );
    level.research_vessel.sfx[ "audio_emt_vent_04" ] = spawnscriptable( "research_vessel_audio_emt_vent_04", ( -558, -251, -4370 ) );
    
    foreach ( var_b3053b25c717315a in level.research_vessel.sfx )
    {
        var_b3053b25c717315a.origin += ( 0, 0, 2486 );
        var_b3053b25c717315a.criticalitem = 1;
        var_b3053b25c717315a.alwayscritical = 1;
        var_b3053b25c717315a function_b48259f9e8cc417();
    }
    
    /#
        if ( getdvarint( @"hash_b43200fbf59c0359", 0 ) )
        {
            function_1a2772ac6cc0431d();
        }
    #/
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x589af7b5, Offset: 0x3829
// Size: 0x32
function function_73f1c538118bf9c4()
{
    if ( getdvarint( @"hash_a1c6f1032781dfcd", 0 ) )
    {
        return;
    }
    
    playfxontag( utility::getfx( "research_vessel_vfx_main" ), level.research_vessel_top_room, "tag_origin" );
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x6b61b299, Offset: 0x3863
// Size: 0x45
function function_b48259f9e8cc417()
{
    v_offset = self.origin - level.research_vessel.origin;
    self scriptablesetparententity( level.research_vessel, v_offset, self.angles );
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x5e74f3b7, Offset: 0x38b0
// Size: 0x62
function research_vessel_ascenders()
{
    self.ascenders = spawnscriptable( "research_vessel_ascenders", self.origin, self.angles );
    self.ascenders.criticalitem = 1;
    self.ascenders.alwayscritical = 1;
    self.ascenders function_b48259f9e8cc417();
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x2cc01775, Offset: 0x391a
// Size: 0x164
function research_vessel_locked_heli()
{
    v_origin = level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * -910 + ( 0, 0, 460 );
    level.research_vessel.heli_locked = spawnscriptable( "research_vessel_locked_heli", v_origin );
    level.research_vessel.heli_locked.criticalitem = 1;
    level.research_vessel.heli_locked.alwayscritical = 1;
    v_offset = level.research_vessel.heli_locked.origin - self.origin;
    level.research_vessel.heli_locked scriptablesetparententity( self, v_offset );
    level.research_vessel utility::waittill_any( "research_vessel_heli_locked_cleanup", "waittill_littlebirds_timeout" );
    level.research_vessel.heli_locked freescriptable();
    
    if ( isalive( level.research_vessel.heli ) )
    {
        level.research_vessel.heli setscriptablepartstate( "single", "vehicle_use" );
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xc197c00, Offset: 0x3a86
// Size: 0x37
function function_8bf7a6a10a4dbd19()
{
    level.research_vessel endon( #"research_vessel_heli_locked_cleanup" );
    self waittill( #"death" );
    level.research_vessel notify( #"research_vessel_heli_locked_cleanup" );
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xc40c3dca, Offset: 0x3ac5
// Size: 0x173
function research_vessel_horn()
{
    if ( getdvarint( @"hash_e8b562b654c7720a", 0 ) )
    {
        return;
    }
    
    scriptable::scriptable_addusedcallbackbypart( "research_vessel_horn_button", &research_vessel_horn_button_used );
    horn_right = spawnscriptable( "research_vessel_horn_right", ( 1041.75, -342, -2203.75 ), ( 0, -45, 0 ) );
    v_offset = horn_right.origin - self.origin;
    horn_right scriptablesetparententity( self, v_offset, horn_right.angles );
    horn_right setscriptablepartstate( "research_vessel_horn_button", "research_vessel_horn_button_available" );
    horn_left = spawnscriptable( "research_vessel_horn_left", ( 1041.75, 342, -2203.75 ), ( 0, 45, 0 ) );
    v_offset = horn_left.origin - self.origin;
    horn_left scriptablesetparententity( self, v_offset, horn_left.angles );
    horn_left setscriptablepartstate( "research_vessel_horn_button", "research_vessel_horn_button_available" );
    self waittill( #"hash_c82007ad6abcf0d6" );
    wait 5;
    
    if ( horn_right getscriptablepartstate( "research_vessel_horn_button" ) == "research_vessel_horn_button_available" && horn_left getscriptablepartstate( "research_vessel_horn_button" ) == "research_vessel_horn_button_available" )
    {
        if ( lengthsquared( horn_right.origin ) < lengthsquared( horn_left.origin ) )
        {
            research_vessel_horn_button_used( horn_right );
            return;
        }
        
        research_vessel_horn_button_used( horn_left );
    }
}

// Namespace br_research_vessel
// Params 6
// Checksum 0x8edb4cdc, Offset: 0x3c40
// Size: 0x67
function research_vessel_horn_button_used( instance, part, state, player, bautouse, usestring )
{
    instance setscriptablepartstate( "research_vessel_horn_button", "research_vessel_horn_button_unavailable" );
    
    if ( isdefined( player ) )
    {
        player function_d241b7c3db2cbb( "horn" );
    }
    
    instance thread research_vessel_horn_button_reset();
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xcbf4d64b, Offset: 0x3caf
// Size: 0x21
function research_vessel_horn_button_reset()
{
    level endon( #"game_ended" );
    wait 5;
    self setscriptablepartstate( "research_vessel_horn_button", "research_vessel_horn_button_available" );
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x10eadf9, Offset: 0x3cd8
// Size: 0x122
function research_vessel_locked_door()
{
    level endon( #"game_ended" );
    game[ "dialog" ][ "barge_security_door_unlocked" ] = "reba_rfcv_bsdu";
    level.research_vessel.locked_door = spawn( "script_model", self.origin );
    level.research_vessel.locked_door setmodel( "veh_jup_mil_research_vessel_top_room_door" );
    level.research_vessel.locked_door linkto( self );
    clip = getent( "research_vessel_door_clip", "targetname" );
    clip linkto( level.research_vessel.locked_door, "tag_top_room_door" );
    clip_hack = getent( "research_vessel_door_clip_hack", "targetname" );
    
    if ( isdefined( clip_hack ) )
    {
        clip_hack linkto( level.research_vessel.locked_door, "tag_top_room_door" );
    }
    
    level.research_vessel.locked_door setscriptablepartstate( "research_vessel_locked_door", "open" );
    
    if ( isdefined( clip_hack ) )
    {
        clip_hack delete();
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xe9bccddf, Offset: 0x3e02
// Size: 0xe7
function research_vessel_locked_door_loot()
{
    v_pos = ( -598, -252.5, -2050 );
    v_offset = v_pos - level.research_vessel.origin;
    v_rot = ( 0, 90, 0 );
    spawnoptions = common_item::function_bc5ff2958b71a708( v_pos, v_rot );
    spawnoptions.critical = 1;
    spawnoptions.var_f35b5b18b029c493 = 0;
    itembundlename = common_item_database::function_ca9ca606e66b5911( "brloot_equip_gasmask" );
    itembundle = getscriptbundle( itembundlename );
    maxcount = itembundle.maxcount;
    item = common_item::items_spawnitemfromscriptable( "brloot_equip_gasmask", maxcount, spawnoptions );
    item scriptablesetparententity( self, v_offset, item.angles );
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xdb33279, Offset: 0x3ef1
// Size: 0x10d
function research_vessel_uav_tower()
{
    if ( !uav_tower::function_d54bbc8100ac0b16() )
    {
        return;
    }
    
    game[ "dialog" ][ "barge_uav_tower_activated" ] = "reba_rfcv_buta";
    rank::registerscoreinfo( #"uav_tower_used", #"value", 100 );
    
    while ( !isdefined( level.uavtowers ) )
    {
        wait level.framedurationseconds;
    }
    
    scriptable::scriptable_addusedcallbackbypart( "research_vessel_uav_tower", &research_vessel_uav_tower_used );
    towerstruct = spawnstruct();
    towerstruct.origin = ( -56.75, 9.75, -1879.5 );
    towerstruct.angles = ( 0, 180, 0 );
    scriptable = function_2cf14288fef2846d( towerstruct, 1 );
    scriptable.var_30629e995e498243 = -1;
    v_offset = scriptable.origin - self.origin;
    scriptable scriptablesetparententity( self, v_offset, scriptable.angles );
    scriptable.var_797ff656985cbd32 = 1;
}

// Namespace br_research_vessel
// Params 2
// Checksum 0x76315b93, Offset: 0x4006
// Size: 0x53
function function_2cf14288fef2846d( towerstruct, var_cba25aeb0b0992a9 )
{
    assert( isdefined( level.uavtowers ) );
    towersspawned = level.uavtowers.size;
    towerscriptable = function_fd009d079b18f9c( towerstruct, towersspawned, var_cba25aeb0b0992a9 );
    return towerscriptable;
}

// Namespace br_research_vessel
// Params 3
// Checksum 0xd67d134e, Offset: 0x4062
// Size: 0x1ad
function function_fd009d079b18f9c( towerstruct, identifier, var_cba25aeb0b0992a9 )
{
    if ( !isdefined( towerstruct.angles ) )
    {
        towerstruct.angles = ( 0, 0, 0 );
    }
    
    scriptable = spawnscriptable( "research_vessel_uav_tower", towerstruct.origin, towerstruct.angles );
    scriptable.criticalitem = 1;
    scriptable.alwayscritical = 1;
    scriptable.var_9b44b630662e4ee8 = 1;
    scriptable.ignore_gas = 1;
    
    if ( var_cba25aeb0b0992a9 )
    {
        scriptable.var_cba25aeb0b0992a9 = 1;
    }
    
    if ( !level.var_9bb2993c2475a372 )
    {
        scriptable setscriptablepartstate( "objective", "inactive" );
    }
    
    scriptable setscriptablepartstate( "research_vessel_uav_tower", "usable" );
    towerstruct.uav_station = scriptable;
    scriptable.towerstruct = towerstruct;
    scriptable.identifier = identifier;
    scriptable.gasdisabled = 0;
    
    if ( !isdefined( towerstruct.poi ) && isdefined( towerstruct.fortress ) && isdefined( towerstruct.fortress.poiname ) )
    {
        towerstruct.poi = towerstruct.fortress.poiname;
    }
    
    level.uavtowers[ level.uavtowers.size ] = towerstruct;
    
    if ( level.var_1e6e788a295d6a49 )
    {
        scriptable.teamscooldown = [];
    }
    
    return scriptable;
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x9ff8cc83, Offset: 0x4218
// Size: 0xea
function function_d18f5969b24aaff5()
{
    var_6b7b777537561dd = getentarray( "research_vessel_ai_navmesh", "targetname" );
    
    foreach ( var_df405291234daa59 in var_6b7b777537561dd )
    {
        var_df405291234daa59 show();
        var_df405291234daa59 solid();
        var_df405291234daa59.moverdoesnotkill = 1;
        var_df405291234daa59.carriabletype = 1;
        var_df405291234daa59 linkto( self, "tag_origin", var_df405291234daa59.origin - self.origin - ( 0, 0, 1 ), ( 0, 0, 0 ) );
    }
}

// Namespace br_research_vessel
// Params 6
// Checksum 0x1c41d71b, Offset: 0x430a
// Size: 0x528
function research_vessel_uav_tower_used( instance, part, state, player, bautouse, usestring )
{
    if ( !uav_tower::tower_canuse( player ) )
    {
        return;
    }
    
    canuse = !level.var_dfe8fdf9c0076a23[ instance.index ];
    
    if ( level.var_1e6e788a295d6a49 )
    {
        canuse = !instance.teamscooldown[ player.team ];
    }
    
    var_e3c6c1bbc4b40b36 = 1;
    
    if ( level.var_a5bbb57efb42b3dd > 0 && !instance.var_cba25aeb0b0992a9 )
    {
        var_e3c6c1bbc4b40b36 = player.plundercount >= level.var_a5bbb57efb42b3dd;
        
        if ( canuse && !var_e3c6c1bbc4b40b36 )
        {
            canuse = 0;
        }
    }
    
    if ( canuse )
    {
        instance setscriptablepartstate( "research_vessel_uav_tower", "unusable" );
        instance.capturingteam = player.team;
        
        if ( level.var_9bb2993c2475a372 )
        {
            if ( utility::issharedfuncdefined( #"uav_tower", #"oncapturedchange" ) )
            {
                [[ utility::getsharedfunc( #"uav_tower", #"oncapturedchange" ) ]]( instance, 1 );
            }
        }
        
        instance.successfuluse = 0;
        instance uav_tower::function_f62c2471b7b672e( player );
        player setclientomnvar( "ui_uav_tower_screen", 0 );
        instance setscriptablepartstate( "research_vessel_uav_tower", "usable" );
        
        if ( level.var_a5bbb57efb42b3dd > 0 && !instance.var_cba25aeb0b0992a9 )
        {
            var_e3c6c1bbc4b40b36 = player.plundercount >= level.var_a5bbb57efb42b3dd;
            
            if ( var_e3c6c1bbc4b40b36 && instance.successfuluse )
            {
                a_players_on_team = teams::getteamdata( player.team, "players" );
                var_e12abd8c59ecd0c0 = [];
                
                foreach ( player in a_players_on_team )
                {
                    if ( distancesquared( player.origin, instance.origin ) < squared( 500 ) )
                    {
                        var_e12abd8c59ecd0c0[ var_e12abd8c59ecd0c0.size ] = player;
                    }
                }
                
                br_public::brleaderdialog( "barge_uav_tower_activated", 1, var_e12abd8c59ecd0c0, undefined, undefined, undefined, "dx_br_brsa_" );
                players = level.players;
                instance thread uav_tower::function_ad35065b87cb760c( instance, part, state, player, bautouse, usestring, players );
                player function_d241b7c3db2cbb( "uav_tower" );
                analytics_uav_tower_used( instance.origin );
            }
            else if ( var_e3c6c1bbc4b40b36 && !instance.successfuluse )
            {
            }
            else
            {
                if ( soundexists( "fly_pickup_deny_lyr" ) && level.uavtowersounds )
                {
                    player playlocalsound( "fly_pickup_deny_lyr" );
                }
                
                if ( isdefined( level.showerrormessagefunc ) )
                {
                    player [[ level.showerrormessagefunc ]]( "DMZ/INSUFFICIENT_MONEY_UAV_TOWER" );
                }
            }
        }
        else if ( instance.successfuluse )
        {
            a_players_on_team = teams::getteamdata( player.team, "players" );
            var_e12abd8c59ecd0c0 = [];
            
            foreach ( p in a_players_on_team )
            {
                if ( distancesquared( p.origin, instance.origin ) < squared( 500 ) )
                {
                    var_e12abd8c59ecd0c0[ var_e12abd8c59ecd0c0.size ] = p;
                }
            }
            
            br_public::brleaderdialog( "barge_uav_tower_activated", 1, var_e12abd8c59ecd0c0, undefined, undefined, undefined, "dx_br_brsa_" );
            players = level.players;
            instance thread uav_tower::function_ad35065b87cb760c( instance, part, state, player, bautouse, usestring, players );
            player function_d241b7c3db2cbb( "uav_tower" );
            analytics_uav_tower_used( instance.origin );
        }
        else
        {
            instance setscriptablepartstate( "research_vessel_uav_tower", "usable" );
        }
    }
    else if ( !var_e3c6c1bbc4b40b36 )
    {
        if ( soundexists( "fly_pickup_deny_lyr" ) && level.uavtowersounds )
        {
            player playlocalsound( "fly_pickup_deny_lyr" );
        }
        
        if ( isdefined( level.showerrormessagefunc ) )
        {
            player [[ level.showerrormessagefunc ]]( "DMZ/INSUFFICIENT_MONEY_UAV_TOWER" );
        }
    }
    else
    {
        if ( soundexists( "fly_pickup_deny" ) && level.uavtowersounds )
        {
            player playlocalsound( "fly_pickup_deny" );
        }
        
        if ( isdefined( level.showerrormessagefunc ) )
        {
            player [[ level.showerrormessagefunc ]]( "DMZ/INACTIVE_UAV_TOWER" );
        }
    }
    
    if ( isdefined( instance.mapcircle ) )
    {
        instance.mapcircle linkto( level.research_vessel );
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x952d97a4, Offset: 0x483a
// Size: 0x557
function function_bb97b0a5ba25c870()
{
    var_4b555e37485b9ef6 = [];
    var_fa2ff099ee7eba34 = getentitylessscriptablearray( undefined, undefined, self.origin, 2000 );
    
    foreach ( var_b3053b25c717315a in var_fa2ff099ee7eba34 )
    {
        if ( distancesquared( var_b3053b25c717315a.origin, self.origin ) < squared( 2000 ) )
        {
            var_4b555e37485b9ef6[ var_4b555e37485b9ef6.size ] = var_b3053b25c717315a;
        }
    }
    
    stationstruct = spawnstruct();
    stationstruct.origin = ( 0, 0, -2514 ) + ( -1451.24, -1.65039, 268 );
    stationstruct.angles = ( 0, 0, 0 );
    stationstruct.scriptableid = "br_plunder_box_nocollision";
    kiosk_override = getdvar( @"hash_805738c3210f2c35", "" );
    
    if ( kiosk_override != "" )
    {
        stationstruct.var_553cc8efe969a2a8 = kiosk_override;
    }
    
    scr_buystation = common_kiosk::function_2282260e9dc07a4b( stationstruct, level.common_armory_kiosk.instances.size );
    level.common_armory_kiosk.instances[ level.common_armory_kiosk.instances.size ] = scr_buystation;
    v_offset = scr_buystation.origin - self.origin;
    scr_buystation scriptablesetparententity( self, v_offset, stationstruct.angles );
    scr_buystation setscriptablepartstate( "br_plunder_box", "visible" );
    scr_buystation.criticalitem = 1;
    scr_buystation.alwayscritical = 1;
    
    foreach ( var_b3053b25c717315a in var_4b555e37485b9ef6 )
    {
        if ( var_b3053b25c717315a.type == "brloot_scavenger_laptop" )
        {
            var_b3053b25c717315a setscriptablepartstate( var_b3053b25c717315a.type, "hidden" );
            continue;
        }
        
        if ( var_b3053b25c717315a getscriptablehaspart( "body" ) )
        {
            var_88b0efbd9a4d9468 = "closed_usable";
            
            if ( var_b3053b25c717315a getscriptableparthasstate( "body", #"closed_usable_no_collision" ) )
            {
                var_88b0efbd9a4d9468 = #"closed_usable_no_collision";
            }
            
            scr_standalone = common_cache::function_9bc018c1b8aad720( var_b3053b25c717315a.type, var_b3053b25c717315a.origin, var_b3053b25c717315a.angles, var_88b0efbd9a4d9468, "wz_sat_resurgence_zone_global" );
            
            if ( distance2dsquared( var_b3053b25c717315a.origin, ( -1366, -267, 52.2583 ) ) < 1 || distance2dsquared( var_b3053b25c717315a.origin, ( -1367, 267, 52.2583 ) ) < 1 )
            {
                scr_standalone.var_a3b7393208a540bc = 10;
            }
            
            b_register = 0;
        }
        else if ( var_b3053b25c717315a.type == "ammo_restock" )
        {
            scr_standalone = spawnscriptable( var_b3053b25c717315a.type, var_b3053b25c717315a.origin, var_b3053b25c717315a.angles );
            level.ammorestocklocs[ level.ammorestocklocs.size ] = scr_standalone;
        }
        else
        {
            spawnoptions = common_item::function_bc5ff2958b71a708( var_b3053b25c717315a.origin, var_b3053b25c717315a.angles );
            spawnoptions.var_f35b5b18b029c493 = 0;
            scr_standalone = common_item::items_spawnitemfromscriptable( var_b3053b25c717315a.type, 1, spawnoptions );
        }
        
        if ( isdefined( scr_standalone ) )
        {
            v_offset = var_b3053b25c717315a.origin - self.origin;
            scr_standalone.origin = var_b3053b25c717315a.origin;
            scr_standalone scriptablesetparententity( self, v_offset, var_b3053b25c717315a.angles );
            scr_standalone.var_37bf28e977662d28 = self;
        }
        
        if ( isdefined( scr_standalone ) && isdefined( var_b3053b25c717315a.count ) )
        {
            scr_standalone.count = var_b3053b25c717315a.count;
        }
        
        if ( var_b3053b25c717315a getscriptablehaspart( "body" ) )
        {
            var_b3053b25c717315a setscriptablepartstate( "body", "hidden" );
            b_register = 0;
        }
        
        if ( var_b3053b25c717315a.type == "ammo_restock" )
        {
            var_b3053b25c717315a setscriptablepartstate( "model", "hidden" );
            b_register = 0;
        }
        
        if ( isdefined( scr_standalone ) && issubstr( var_b3053b25c717315a.type, "laptop" ) )
        {
            scr_standalone setscriptablepartstate( var_b3053b25c717315a.type, var_b3053b25c717315a getscriptablepartstate( var_b3053b25c717315a.type ) );
        }
        
        if ( isdefined( scr_standalone ) && b_register )
        {
            pickups::registerscriptableinstance( scr_standalone );
        }
        
        if ( issubstr( var_b3053b25c717315a.type, "brloot_" ) )
        {
            var_b3053b25c717315a setscriptablepartstate( var_b3053b25c717315a.type, "hidden" );
        }
    }
}

// Namespace br_research_vessel
// Params 0, eflags: 0x4
// Checksum 0xa3c48a14, Offset: 0x4d99
// Size: 0x9a
function private function_1239ce8e2abb410a()
{
    function_ed0def2d44bc94bd( "brloot_weapon_dm_p03_sgeorge550_ultra", ( -438, -366, -2037 ), ( 0, 90, 0 ) );
    function_ed0def2d44bc94bd( "brloot_weapon_ar_p22_able18_ultra", ( -500, -366, -2038 ), ( 0, 90, 0 ) );
    function_ed0def2d44bc94bd( "brloot_weapon_sn_p08_ultiger_ultra", ( -568, -11, -2038 ), ( 0, 90, 0 ) );
    function_ed0def2d44bc94bd( "brloot_weapon_sm_p04_chuck9_ultra", ( -317, -152, -2042 ), ( 0, 180, 0 ) );
}

// Namespace br_research_vessel
// Params 3
// Checksum 0x829dad12, Offset: 0x4e3b
// Size: 0xc9
function function_ed0def2d44bc94bd( str_loot_item, origin, angles )
{
    itembundle = common_item::function_80af1e9daffacc7d( str_loot_item );
    weapon = item_weapon::function_477bf1207c6672a5( itembundle );
    clipsize = weaponclipsize( weapon );
    spawnoptions = common_item::function_bc5ff2958b71a708( origin, angles );
    spawnoptions.var_f35b5b18b029c493 = 0;
    item = common_item::function_61c2c0251e742ffd( itembundle, clipsize, spawnoptions );
    v_offset = item.origin - self.origin;
    item scriptablesetparententity( self, v_offset, item.angles );
    item.var_37bf28e977662d28 = self;
}

// Namespace br_research_vessel
// Params 1
// Checksum 0x653d163a, Offset: 0x4f0c
// Size: 0x188
function function_7a74104a2c974fdd( str_path )
{
    if ( !isdefined( str_path ) )
    {
        f_closest_sq = squared( 50000 );
        
        foreach ( str in level.research_vessel.a_str_paths )
        {
            if ( distance2dsquared( level.research_vessel.a_s_destinations[ str ].origin, level.br_level.br_circlecenters[ level.br_level.br_circlecenters.size - 1 ] ) < f_closest_sq )
            {
                str_path = str;
                f_closest_sq = distance2dsquared( level.research_vessel.a_s_destinations[ str ].origin, level.br_level.br_circlecenters[ level.br_level.br_circlecenters.size - 1 ] );
            }
        }
    }
    
    if ( getdvarint( @"scr_research_vessel_aprilfools" ) )
    {
        str_path = "aprilfools";
    }
    
    function_efef6128a744727b( str_path );
    
    if ( randomfloat( 100 ) < getdvarfloat( @"hash_2daf09d2b8ba0a95", 0 ) )
    {
        level thread function_b9955c953168e1ad();
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x71e90a35, Offset: 0x509c
// Size: 0x348
function function_9bf319d9b185aee()
{
    function_71e93ca4ec664548();
    
    if ( isdefined( level.research_vessel.heli ) )
    {
        level.research_vessel.heli.dangercircletickimmune = 1;
        level.research_vessel.heli thread function_8bf7a6a10a4dbd19();
        level.research_vessel.heli thread function_c99f3e51cbe1063e();
        level.research_vessel.heli vehicle_spawn::prevent_respawn();
        var_d12b833198b84ee5 = ( -965, 0, 582.5 );
    }
    
    self.origin = self.var_ad2aab3cb9ffb7b[ 0 ].origin;
    self.angles = self.var_ad2aab3cb9ffb7b[ 0 ].angles;
    
    if ( isdefined( level.research_vessel.heli ) )
    {
        var_d12b833198b84ee5 = rotatevector( var_d12b833198b84ee5, self.angles );
        level.research_vessel.heli.origin = self.origin + var_d12b833198b84ee5;
        level.research_vessel.heli.angles = self.angles;
        level.research_vessel.heli setrotorsactive( 0 );
        self.heli_linker = spawn( "script_origin", level.research_vessel.heli.origin );
        self.heli_linker.origin += ( 0, 0, -129 );
        self.heli_linker.angles = level.research_vessel.heli.angles;
        self.heli_linker setmodel( "tag_origin" );
        self.heli_linker linkto( self );
        
        if ( getdvarint( @"scr_research_vessel_heli_locked", 1 ) && !getdvarint( @"hash_a1c6f1032781dfcd", 0 ) )
        {
            level.research_vessel.heli setscriptablepartstate( "single", "vehicle_unusable" );
        }
        
        level.research_vessel.heli thread vehicle_linkto( self.heli_linker, "tag_origin", 1 );
    }
    
    thread research_vessel_gopath();
    flags::gameflagwait( "infil_animatic_complete" );
    var_ff154a943bebb554 = getlootscriptablearrayinradius( "br_reusable_loot_cache", undefined, self.origin, 2000 );
    
    foreach ( scriptable in var_ff154a943bebb554 )
    {
        scriptable setscriptablepartstate( "body", "closed_usable_no_collision" );
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x4a0f57e2, Offset: 0x53ec
// Size: 0x76a
function function_aea30ef65100adc9()
{
    level.research_vessel.sfx[ "engine_right" ] setscriptablepartstate( "sfx", "engine_lp" );
    level.research_vessel.sfx[ "engine_left" ] setscriptablepartstate( "sfx", "engine_lp" );
    level.research_vessel.sfx[ "pontoon_back_right" ] setscriptablepartstate( "sfx", "prop_lp" );
    level.research_vessel.sfx[ "pontoon_back_left" ] setscriptablepartstate( "sfx", "prop_lp" );
    level.research_vessel.sfx[ "pontoon_front_right" ] setscriptablepartstate( "sfx", "bow_wake_starboard" );
    level.research_vessel.sfx[ "pontoon_front_left" ] setscriptablepartstate( "sfx", "bow_wake_port" );
    level.research_vessel.sfx[ "audio_emt_hull_01" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_02" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_03" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_04" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_05" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_06" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_07" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_08" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_09" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_10" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_11" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_12" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_13" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_14" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_15" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_16" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_17" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_18" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_19" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_20" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_21" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_22" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_23" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_24" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_25" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_26" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_27" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_28" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_29" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_30" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_31" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_32" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_33" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_34" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_35" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_36" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_hull_37" ] setscriptablepartstate( "audio_hull_emt", "hull_lp" );
    level.research_vessel.sfx[ "audio_emt_vent_01" ] setscriptablepartstate( "audio_vent_emt", "vent_lp" );
    level.research_vessel.sfx[ "audio_emt_vent_02" ] setscriptablepartstate( "audio_vent_emt", "vent_lp" );
    level.research_vessel.sfx[ "audio_emt_vent_03" ] setscriptablepartstate( "audio_vent_emt", "vent_lp" );
    level.research_vessel.sfx[ "audio_emt_vent_04" ] setscriptablepartstate( "audio_vent_emt", "vent_lp" );
    setglobalsoundcontext( "research_vessel", "moving", 0 );
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xa34a444b, Offset: 0x5b5e
// Size: 0x63
function function_c99f3e51cbe1063e()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( !self.occupants.size )
    {
        wait level.framedurationseconds;
    }
    
    self.dangercircletickimmune = undefined;
    self notify( #"hash_ba40c5d0ac649170" );
    level.research_vessel.heli_linker delete();
}

// Namespace br_research_vessel
// Params 3
// Checksum 0xac203fd2, Offset: 0x5bc9
// Size: 0x6d
function vehicle_linkto( ent, tag, var_7aa8c0693684425c )
{
    self endon( #"death" );
    self endon( #"hash_ba40c5d0ac649170" );
    
    while ( true )
    {
        origin = ent gettagorigin( tag );
        angles = ent gettagangles( tag );
        self vehicle_teleport( origin, angles, var_7aa8c0693684425c );
        waitframe();
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xcccb75c9, Offset: 0x5c3e
// Size: 0xe3
function research_vessel_gas_exclusion_button()
{
    game[ "dialog" ][ "barge_decon_system_active" ] = "reba_rfcv_bdsa";
    game[ "dialog" ][ "barge_decon_system_warning" ] = "reba_rfcv_bdsw";
    game[ "dialog" ][ "barge_decon_system_disabled" ] = "reba_rfcv_bdsd";
    scriptable::scriptable_addusedcallbackbypart( "research_vessel_gas_exclusion_button", &function_90480ee8956e30b8 );
    scr_button = spawnscriptable( "research_vessel_gas_exclusion_button", ( -449, -70, -2217 ), ( 90, 10, 100 ) );
    v_offset = scr_button.origin - self.origin;
    scr_button scriptablesetparententity( self, v_offset, scr_button.angles );
    scr_button setscriptablepartstate( "research_vessel_gas_exclusion_button", "research_vessel_gas_exclusion_button_available_2" );
    var_8881e788b17c138b = getdvarint( @"hash_83ff217f0222a5ac", 4 );
    scr_button function_d52f0372bc88e754( var_8881e788b17c138b );
}

// Namespace br_research_vessel
// Params 6
// Checksum 0xa0c97ac9, Offset: 0x5d29
// Size: 0xfe
function function_90480ee8956e30b8( scriptable, part, state, player, bautouse, usestring )
{
    player thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_loot_pickup", 1.17 );
    state = scriptable getscriptablepartstate( "research_vessel_gas_exclusion_button" );
    
    switch ( state )
    {
        case #"hash_78b723975f87d531":
            scriptable thread function_12f9c644de3cd818( "research_vessel_gas_exclusion_button_available_2" );
            break;
        case #"hash_78b722975f87d39e":
            scriptable thread function_12f9c644de3cd818( "research_vessel_gas_exclusion_button_available_1" );
            break;
        default:
            scriptable thread function_12f9c644de3cd818( "research_vessel_gas_exclusion_button_absent" );
            break;
    }
    
    scriptable thread research_vessel_gas_exclusion_button_unavailable();
    player function_d241b7c3db2cbb( "decon_system" );
    br_public::brleaderdialog( "barge_decon_system_active", 1, getplayersinradius( level.research_vessel.origin, 2000 ), undefined, undefined, undefined, "dx_br_brsa_" );
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xc7900cfc, Offset: 0x5e2f
// Size: 0x9d
function research_vessel_gas_exclusion_button_unavailable()
{
    self setscriptablepartstate( "research_vessel_gas_exclusion_button", "transition" );
    wait 0.05;
    self setscriptablepartstate( "research_vessel_gas_exclusion_button", "research_vessel_gas_exclusion_button_unavailable" );
    level.research_vessel thread research_vessel_gas_exclusion_zone();
    
    if ( isdefined( level.research_vessel.redeploy_drone ) && level.research_vessel.var_9405671f743d92ad )
    {
        if ( level.research_vessel.redeploy_drone getscriptablepartstate( "redeploy_drone" ) == "unavailable" )
        {
            level.research_vessel thread function_a58245a45859aee( 1 );
        }
    }
}

// Namespace br_research_vessel
// Params 1
// Checksum 0xfbd31774, Offset: 0x5ed4
// Size: 0xda
function function_12f9c644de3cd818( state )
{
    self endon( #"hash_f4e631f3e8b1c24c" );
    wait 10;
    
    if ( state == "research_vessel_gas_exclusion_button_absent" )
    {
        if ( !self.b_warned )
        {
            br_public::brleaderdialog( "barge_decon_system_warning", 1, getplayersinradius( level.research_vessel.origin, 2000 ), undefined, undefined, undefined, "dx_br_brsa_" );
            self.b_warned = 1;
        }
    }
    
    wait 30;
    self setscriptablepartstate( "research_vessel_gas_exclusion_button", "transition" );
    wait 0.05;
    self setscriptablepartstate( "research_vessel_gas_exclusion_button", state );
    
    if ( state == "research_vessel_gas_exclusion_button_absent" )
    {
        br_public::brleaderdialog( "barge_decon_system_disabled", 1, getplayersinradius( level.research_vessel.origin, 2000 ), undefined, undefined, undefined, "dx_br_brsa_" );
        self.var_df00f5fbf4a6d195 = 1;
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x90a1b151, Offset: 0x5fb6
// Size: 0x191
function research_vessel_gas_exclusion_zone()
{
    level endon( #"game_ended" );
    
    if ( isdefined( self.Exclusion_Zone ) )
    {
        self.exclusion_zone_previous = self.Exclusion_Zone;
    }
    
    Exclusion_Zone = level.exclusionzones[ exclusion_zones::function_13326ea977bfb539( self.origin + anglestoforward( self.angles ) * -300, ( 1, 1, 1 ), self.angles, 1 ) ];
    Exclusion_Zone exclusion_zones::function_f597034a78b33c62( ( 5000, 5000, 5000 ), 0.05, 0 );
    Exclusion_Zone linkto( self );
    self.Exclusion_Zone = Exclusion_Zone;
    level thread function_fa0595ae9bf850d1( self.origin );
    
    for ( i = 0; i < 40 ; i++ )
    {
        if ( self.var_776efeec25f5e7c9 )
        {
            break;
        }
        
        wait 1;
    }
    
    Exclusion_Zone exclusion_zones::function_f597034a78b33c62( ( 0, 0, 0 ), ( -5, -5, -5 ), 1 );
    
    while ( true )
    {
        var_1d036682dc89c202 = self.Exclusion_Zone function_465f674722f8d216()[ 0 ];
        var_f0fde846c5d31cd0 = undefined;
        
        if ( isdefined( self.exclusion_zone_previous ) )
        {
            var_f0fde846c5d31cd0 = self.exclusion_zone_previous function_465f674722f8d216()[ 0 ];
        }
        
        if ( Exclusion_Zone == self.Exclusion_Zone && var_1d036682dc89c202 < 1 || Exclusion_Zone == self.exclusion_zone_previous && var_1d036682dc89c202 >= var_f0fde846c5d31cd0 )
        {
            exclusion_zones::function_5fc2ac1152c0aa19( Exclusion_Zone );
            return;
        }
        
        waitframe();
    }
}

// Namespace br_research_vessel
// Params 1
// Checksum 0x69c6c495, Offset: 0x614f
// Size: 0x163
function function_d52f0372bc88e754( circle )
{
    level endon( #"game_ended" );
    circleindex = circle - 1;
    i_wait = 0;
    
    for ( i = 0; i < circleindex ; i++ )
    {
        i_wait += level.br_level.br_circleclosetimes[ i ];
        i_wait += level.br_level.br_circledelaytimes[ i ];
    }
    
    wait i_wait - 30;
    br_public::brleaderdialog( "warning", 0, getplayersinradius( self.origin, 2000 ), undefined, undefined, undefined, "barge_decon_system_" );
    wait 30;
    
    while ( level.br_circle.circleindex != circleindex )
    {
        wait 0.05;
    }
    
    self notify( #"hash_f4e631f3e8b1c24c" );
    self setscriptablepartstate( "research_vessel_gas_exclusion_button", "research_vessel_gas_exclusion_button_absent" );
    
    if ( !self.var_df00f5fbf4a6d195 )
    {
        br_public::brleaderdialog( "barge_decon_system_disabled", 1, getplayersinradius( level.research_vessel.origin, 2000 ), undefined, undefined, undefined, "dx_br_brsa_" );
    }
    
    level.research_vessel.var_776efeec25f5e7c9 = 1;
    self.b_warned = undefined;
    self.var_df00f5fbf4a6d195 = undefined;
    level.research_vessel thread function_5a82194199190a82();
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x34ab848a, Offset: 0x62ba
// Size: 0x39f
function research_vessel_gopath()
{
    if ( getdvarint( @"hash_a1c6f1032781dfcd", 0 ) )
    {
        self.origin = self.var_ad2aab3cb9ffb7b[ self.var_ad2aab3cb9ffb7b.size - 1 ].origin;
        self.angles = self.var_ad2aab3cb9ffb7b[ self.var_ad2aab3cb9ffb7b.size - 1 ].angles;
        thread function_57f91ad0759ff196();
        thread function_a58245a45859aee( 1 );
        level.research_vessel_clip.velocity = ( 0, 0, 0 );
        level.research_vessel_clip.vehiclename = undefined;
        return;
    }
    
    level endon( #"game_ended" );
    game[ "dialog" ][ "barge_docking_soon" ] = "reba_rfcv_bptd";
    game[ "dialog" ][ "barge_deploying_anchors" ] = "reba_rfcv_bdan";
    
    /#
        if ( getdvarint( @"hash_79a6a5e84a38efe8", 0 ) || getdvarint( @"hash_938b29834106fb61", 0 ) )
        {
            level thread function_458fa6eeb26e0a32();
        }
        
        if ( getdvarint( @"hash_938b29834106fb61", 0 ) )
        {
            start = getdvarint( @"hash_938b29834106fb61", 0 );
            duration = getdvarint( @"hash_1f94206a78e9a746", 10 );
            level thread function_3395900a15b2a16f( start, duration );
        }
    #/
    
    self.var_99282ff58ec55b2b = 0;
    var_f78511be97bccc3f = self.var_ad2aab3cb9ffb7b[ 0 ];
    
    while ( isdefined( var_f78511be97bccc3f.var_7b97f011bb3a6659 ) )
    {
        var_f78511be97bccc3f = var_f78511be97bccc3f.var_7b97f011bb3a6659;
        research_vessel_goto( var_f78511be97bccc3f );
    }
    
    setglobalsoundcontext( "research_vessel", "idle", 5 );
    level.research_vessel.sfx[ "engine_right" ] setscriptablepartstate( "sfx", "sfx_engine_idle" );
    level.research_vessel.sfx[ "engine_left" ] setscriptablepartstate( "sfx", "sfx_engine_idle" );
    level.research_vessel.sfx[ "pontoon_back_right" ] setscriptablepartstate( "sfx", "props_stop" );
    level.research_vessel.sfx[ "pontoon_back_left" ] setscriptablepartstate( "sfx", "props_stop" );
    level.research_vessel.sfx[ "pontoon_front_right" ] setscriptablepartstate( "sfx", "bow_wake_starboard_stop" );
    level.research_vessel.sfx[ "pontoon_front_left" ] setscriptablepartstate( "sfx", "bow_wake_port_stop" );
    wait 20;
    level.research_vessel.b_docked = 1;
    br_public::brleaderdialog( "barge_deploying_anchors", 1, getplayersinradius( level.research_vessel.origin, 2000 ), undefined, undefined, undefined, "dx_br_brsa_" );
    thread function_57f91ad0759ff196();
    level.research_vessel notify( #"research_vessel_heli_locked_cleanup" );
    level.research_vessel notify( #"hash_c82007ad6abcf0d6" );
    level.research_vessel_clip.velocity = ( 0, 0, 0 );
    level.research_vessel_clip.vehiclename = undefined;
    
    for ( i = 0; i < 20 ; i++ )
    {
        stopfxontag( utility::getfx( "research_vessel_vfx_main" ), level.research_vessel_top_room, "tag_origin" );
        wait 0.05;
    }
    
    level.research_vessel thread function_ef4e28f4c2ed6b73();
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x720b49a, Offset: 0x6661
// Size: 0x4c
function function_ef4e28f4c2ed6b73()
{
    level endon( #"game_ended" );
    sign = 1;
    
    while ( true )
    {
        self.origin += ( 0.1 * sign, 0, 0 );
        sign *= -1;
        wait 5;
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x1d420bdd, Offset: 0x66b5
// Size: 0x102
function function_57f91ad0759ff196()
{
    self.ascenders setscriptablepartstate( "research_vessel_ascenders", "research_vessel_ascenders_down" );
    
    foreach ( v in self.ascenders_actual )
    {
        v_actual = self.origin + rotatevector( v, self.angles );
        level thread function_ddfff3b8a23ae82c( undefined, "top", v_actual );
        level thread function_ddfff3b8a23ae82c( 1.8, "bottom", v_actual + vectornormalize( v_actual - self.origin ) * 10 + ( 0, 0, -460 ) );
        level thread function_7855ee3ad0993ef9( 1.8, v_actual );
    }
}

// Namespace br_research_vessel
// Params 3
// Checksum 0xeff8cffd, Offset: 0x67bf
// Size: 0x67
function function_ddfff3b8a23ae82c( var_39ae44a13ef5cd04, type, v_spawn )
{
    if ( isdefined( var_39ae44a13ef5cd04 ) )
    {
        wait var_39ae44a13ef5cd04;
    }
    
    var_b3053b25c717315a = spawnscriptable( "research_vessel_ascenders_sfx_" + type, v_spawn );
    var_b3053b25c717315a.criticalitem = 1;
    var_b3053b25c717315a.alwayscritical = 1;
    wait 10;
    var_b3053b25c717315a freescriptable();
}

// Namespace br_research_vessel
// Params 2
// Checksum 0x709e895f, Offset: 0x682e
// Size: 0x37
function function_7855ee3ad0993ef9( var_39ae44a13ef5cd04, v_spawn )
{
    wait var_39ae44a13ef5cd04;
    spawnscriptable( "military_ascendertop_heavy", v_spawn, level.research_vessel.angles );
}

// Namespace br_research_vessel
// Params 1
// Checksum 0x5f4ad6e9, Offset: 0x686d
// Size: 0x3cd
function research_vessel_goto( var_f78511be97bccc3f )
{
    level endon( #"game_ended" );
    var_db734181520e011b = 0;
    
    if ( getdvarint( @"scr_research_vessel_aprilfools" ) )
    {
        var_db734181520e011b = ( level.research_vessel.a_s_destinations[ "aprilfools" ].origin[ 2 ] - function_e4f8330cd328f0fa( "aprilfools" )[ 0 ][ 2 ] ) / 4340;
    }
    
    var_e04d4bdd573538ab = ( 0, 0, var_db734181520e011b * 2 );
    var_511529ec3be4a0b4 = 0;
    
    while ( true )
    {
        if ( getdvarint( @"scr_research_vessel_aprilfools" ) )
        {
            if ( self.origin[ 2 ] - level.research_vessel.a_s_destinations[ "aprilfools" ].origin[ 2 ] < var_db734181520e011b * 2 )
            {
                var_e04d4bdd573538ab = ( 0, 0, 0 );
            }
        }
        
        var_a87a1520f9140606 = distance2d( self.origin, var_f78511be97bccc3f.origin );
        
        if ( isdefined( var_f78511be97bccc3f.var_7b97f011bb3a6659 ) )
        {
            if ( var_a87a1520f9140606 > 1000 && vectordot( anglestoforward( self.angles ), var_f78511be97bccc3f.origin - self.origin ) > 0 )
            {
                var_511529ec3be4a0b4 = 30;
                level.research_vessel_clip.velocity = anglestoforward( self.angles ) * var_511529ec3be4a0b4;
                self moveto( self.origin + level.research_vessel_clip.velocity + var_e04d4bdd573538ab, 0.05 );
            }
            else
            {
                break;
            }
        }
        else if ( var_a87a1520f9140606 > 5000 )
        {
            var_511529ec3be4a0b4 = 30;
            self moveto( self.origin + anglestoforward( self.angles ) * var_511529ec3be4a0b4 + var_e04d4bdd573538ab, 0.05 );
        }
        else if ( var_a87a1520f9140606 > 1000 && vectordot( anglestoforward( self.angles ), var_f78511be97bccc3f.origin - self.origin ) > 0 )
        {
            if ( !self.var_c867e26ccf89e5cf )
            {
                br_public::brleaderdialog( "barge_docking_soon", 1, getplayersinradius( level.research_vessel.origin, 2000 ), undefined, undefined, undefined, "dx_br_smis_" );
                self.var_c867e26ccf89e5cf = 1;
            }
            
            var_511529ec3be4a0b4 = 30 * var_a87a1520f9140606 / 5000;
            
            if ( var_511529ec3be4a0b4 < 10 )
            {
                var_511529ec3be4a0b4 = 10;
            }
            
            level.research_vessel_clip.velocity = anglestoforward( self.angles ) * var_511529ec3be4a0b4;
            self moveto( self.origin + level.research_vessel_clip.velocity, 0.05 );
        }
        else
        {
            thread function_a58245a45859aee();
            self moveto( var_f78511be97bccc3f.origin, 20, 0, 20 );
            self rotateto( var_f78511be97bccc3f.angles, 20, 0, 20 );
            return;
        }
        
        v_goto = var_f78511be97bccc3f.origin - self.origin;
        dot_right = vectordot( vectornormalize( v_goto ), anglestoright( self.angles ) );
        var_5a3ee56e8591a886 = -1 * dot_right * 0.0125 * var_511529ec3be4a0b4;
        
        if ( var_5a3ee56e8591a886 < self.var_99282ff58ec55b2b - 0.0025 )
        {
            var_5a3ee56e8591a886 = self.var_99282ff58ec55b2b - 0.0025;
        }
        else if ( var_5a3ee56e8591a886 > self.var_99282ff58ec55b2b + 0.0025 )
        {
            var_5a3ee56e8591a886 = self.var_99282ff58ec55b2b + 0.0025;
        }
        
        self rotateby( ( 0, var_5a3ee56e8591a886, 0 ), 0.05 );
        self.var_99282ff58ec55b2b = var_5a3ee56e8591a886;
        wait 0.05;
    }
}

// Namespace br_research_vessel
// Params 1
// Checksum 0x21fced4d, Offset: 0x6c42
// Size: 0x498
function function_a58245a45859aee( b_immediate )
{
    if ( !getdvarint( @"redeploy_ascenders_enabled", 0 ) )
    {
        return;
    }
    
    if ( !b_immediate )
    {
        wait 6;
    }
    
    if ( !isdefined( self.redeploy_drone ) )
    {
        return;
    }
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        if ( scriptable == self.redeploy_drone )
        {
            continue;
        }
        
        if ( scriptable.b_occupied && scriptable getscriptablepartstate( "redeploy_drone" ) == "available" )
        {
            if ( distance2dsquared( self.redeploy_drone.origin, scriptable.origin ) < level.redeploy_drone_info_struct.var_10fed330f6746fa6 )
            {
                level.research_vessel.var_9405671f743d92ad = 1;
                scriptable thread br_redeploy_drone::redeploy_drone_relocate( self.redeploy_drone, 1, 1 );
                return;
            }
        }
    }
    
    v_spawn = self.redeploy_drone.origin + vectornormalize( self.var_ad2aab3cb9ffb7b[ 0 ].origin - self.redeploy_drone.origin ) * 10000 + ( 0, 0, 3500 );
    drone = spawn( "script_model", v_spawn );
    drone setmodel( "veh9_mil_air_drone_redeploy_relocate" );
    drone.angles = vectortoangles( self.origin - drone.origin );
    drone.speed = level.redeploy_drone_info_struct.i_max_speed;
    drone.health = level.redeploy_drone_info_struct.i_health;
    drone setcandamage( 1 );
    drone forcenetfieldhighlod( 1 );
    weapons::function_ef0cb557b1a93af9( drone );
    drone thread br_redeploy_drone::function_db27aa1265406b53( self.redeploy_drone, 1 );
    
    /#
        if ( getdvarint( @"scr_debug_redeploy_drones", 0 ) )
        {
            debug::sphere( drone, 25, ( 1, 0, 0 ), undefined, "<dev string:x1ae>", "<dev string:x1d6>" );
            debug::draw_angles( drone, undefined, 150, undefined, "<dev string:x1ae>", "<dev string:x1d6>" );
        }
    #/
    
    drone thread br_redeploy_drone::function_f8019c12697fcf50( self.redeploy_drone );
    drone thread br_redeploy_drone::function_76cb6eb6a9700637( self.redeploy_drone );
    drone thread br_redeploy_drone::redeploy_drone_sfx_watcher();
    
    while ( !( isdefined( drone.b_movement_complete ) && isdefined( drone.var_fe7274eb7e5153e7 ) ) )
    {
        if ( drone.health <= 0 )
        {
            level.research_vessel.var_9405671f743d92ad = 1;
            return;
        }
        
        wait level.framedurationseconds;
    }
    
    drone br_redeploy_drone::cable_deploy();
    
    if ( !isalive( drone ) )
    {
        return;
    }
    
    drone notify( #"relocation_complete" );
    self.redeploy_drone.health = drone.health;
    weapons::function_d5eafafe8f6a97bf( drone );
    drone delete();
    self.redeploy_drone br_redeploy_drone::set_redeploy_drone_available();
    self.redeploy_drone thread br_redeploy_drone::function_1903b4a3be0118f1();
    level.research_vessel.var_9405671f743d92ad = 1;
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        if ( scriptable == self.redeploy_drone )
        {
            continue;
        }
        
        if ( scriptable.b_occupied && scriptable getscriptablepartstate( "redeploy_drone" ) == "available" )
        {
            if ( distance2dsquared( self.redeploy_drone.origin, scriptable.origin ) < level.redeploy_drone_info_struct.var_10fed330f6746fa6 )
            {
                scriptable thread br_redeploy_drone::redeploy_drone_relocate();
                return;
            }
        }
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x58dc443e, Offset: 0x70e2
// Size: 0x4cf
function function_5a82194199190a82()
{
    if ( !getdvarint( @"redeploy_ascenders_enabled", 0 ) )
    {
        return;
    }
    
    if ( !isdefined( self.exfil_drone ) )
    {
        return;
    }
    
    collisioncontents = physics_createcontents( [ "physicscontents_aiclip" ] );
    trace = trace::ray_trace( self.exfil_drone.origin, self.exfil_drone.origin + ( 0, 0, -3000 ), undefined, collisioncontents, 1, 1, 0 );
    self.exfil_drone.str_surftype = trace[ "surfacetype" ];
    self.exfil_drone.var_bd4fec0091dedb5c = trace[ "position" ];
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        if ( scriptable == self.exfil_drone )
        {
            continue;
        }
        
        if ( scriptable.b_occupied && scriptable getscriptablepartstate( "redeploy_drone" ) == "available" )
        {
            if ( distance2dsquared( self.exfil_drone.origin, scriptable.origin ) < level.redeploy_drone_info_struct.var_10fed330f6746fa6 )
            {
                scriptable thread br_redeploy_drone::redeploy_drone_relocate( self.exfil_drone, 1, 1, 1 );
                return;
            }
        }
    }
    
    v_spawn = self.exfil_drone.origin + vectornormalize( self.var_ad2aab3cb9ffb7b[ 0 ].origin - self.exfil_drone.origin ) * 10000 + ( 0, 0, 3500 );
    drone = spawn( "script_model", v_spawn );
    drone setmodel( "veh9_mil_air_drone_redeploy_relocate" );
    drone.angles = vectortoangles( self.origin - drone.origin );
    drone.speed = level.redeploy_drone_info_struct.i_max_speed;
    drone.health = level.redeploy_drone_info_struct.i_health;
    drone setcandamage( 1 );
    drone forcenetfieldhighlod( 1 );
    weapons::function_ef0cb557b1a93af9( drone );
    drone thread br_redeploy_drone::function_db27aa1265406b53( self.exfil_drone, 1 );
    
    /#
        if ( getdvarint( @"scr_debug_redeploy_drones", 0 ) )
        {
            debug::sphere( drone, 25, ( 1, 0, 0 ), undefined, "<dev string:x1ae>", "<dev string:x1d6>" );
            debug::draw_angles( drone, undefined, 150, undefined, "<dev string:x1ae>", "<dev string:x1d6>" );
        }
    #/
    
    drone thread br_redeploy_drone::function_f8019c12697fcf50( self.exfil_drone );
    drone thread br_redeploy_drone::function_76cb6eb6a9700637( self.exfil_drone );
    drone thread br_redeploy_drone::redeploy_drone_sfx_watcher();
    
    while ( !( isdefined( drone.b_movement_complete ) && isdefined( drone.var_fe7274eb7e5153e7 ) ) )
    {
        if ( drone.health <= 0 )
        {
            return;
        }
        
        wait level.framedurationseconds;
    }
    
    drone br_redeploy_drone::cable_deploy();
    
    if ( !isalive( drone ) )
    {
        return;
    }
    
    drone notify( #"relocation_complete" );
    self.exfil_drone.health = drone.health;
    weapons::function_d5eafafe8f6a97bf( drone );
    drone delete();
    self.exfil_drone br_redeploy_drone::set_redeploy_drone_available();
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        if ( scriptable == self.exfil_drone )
        {
            continue;
        }
        
        if ( scriptable.b_occupied && scriptable getscriptablepartstate( "redeploy_drone" ) == "available" )
        {
            if ( distance2dsquared( self.exfil_drone.origin, scriptable.origin ) < level.redeploy_drone_info_struct.var_10fed330f6746fa6 )
            {
                scriptable thread br_redeploy_drone::redeploy_drone_relocate();
                return;
            }
        }
    }
}

// Namespace br_research_vessel
// Params 1
// Checksum 0x22cada5d, Offset: 0x75b9
// Size: 0x7cf
function function_efef6128a744727b( str_path )
{
    self.var_ad2aab3cb9ffb7b = [];
    function_63353d537962eecd( function_e4f8330cd328f0fa( str_path )[ 0 ], function_e4f8330cd328f0fa( str_path )[ 1 ] );
    
    switch ( str_path )
    {
        case #"hash_5695fdbbff61405c":
            var_3ef8c87c2393ff22 = level.research_vessel.a_s_destinations[ "aprilfools" ].origin[ 2 ] - function_e4f8330cd328f0fa( "aprilfools" )[ 0 ][ 2 ];
            z_each = var_3ef8c87c2393ff22 / 9;
            function_63353d537962eecd( ( -5300, 0, function_e4f8330cd328f0fa( "aprilfools" )[ 0 ][ 2 ] + z_each * 1 ) );
            function_63353d537962eecd( ( 3200, 9700, function_e4f8330cd328f0fa( "aprilfools" )[ 0 ][ 2 ] + z_each * 2 ) );
            function_63353d537962eecd( ( 10900, 6000, function_e4f8330cd328f0fa( "aprilfools" )[ 0 ][ 2 ] + z_each * 3 ) );
            function_63353d537962eecd( ( 13300, -3700, function_e4f8330cd328f0fa( "aprilfools" )[ 0 ][ 2 ] + z_each * 4 ) );
            function_63353d537962eecd( ( 2700, -4200, function_e4f8330cd328f0fa( "aprilfools" )[ 0 ][ 2 ] + z_each * 5 ) );
            function_63353d537962eecd( ( 1500, -200, function_e4f8330cd328f0fa( "aprilfools" )[ 0 ][ 2 ] + z_each * 6 ) );
            function_63353d537962eecd( ( 1700, 3300, function_e4f8330cd328f0fa( "aprilfools" )[ 0 ][ 2 ] + z_each * 7 ) );
            function_63353d537962eecd( ( 2100, 3800, function_e4f8330cd328f0fa( "aprilfools" )[ 0 ][ 2 ] + z_each * 8 ) );
            break;
        case #"hash_affa2b724bff3c28":
            function_63353d537962eecd( ( -13600, -4000, 56 ) );
            function_63353d537962eecd( ( -4300, -8700, 56 ) );
            function_63353d537962eecd( ( 11000, -8400, 56 ) );
            function_63353d537962eecd( ( 14700, -5300, 56 ) );
            function_63353d537962eecd( ( 13300, 6600, 56 ) );
            function_63353d537962eecd( ( 2000, 12000, 56 ) );
            function_63353d537962eecd( ( -12500, 3000, 56 ) );
            function_63353d537962eecd( ( -13700, -400, 56 ) );
            function_63353d537962eecd( ( -12700, -2400, 56 ) );
            function_63353d537962eecd( ( -11700, -5000, 56 ) );
            break;
        case #"hash_b84916758d35116":
            function_63353d537962eecd( ( -10500, -7200, 56 ) );
            function_63353d537962eecd( ( -13100, 1100, 56 ) );
            function_63353d537962eecd( ( 1500, 12000, 56 ) );
            function_63353d537962eecd( ( 13300, 7000, 56 ) );
            function_63353d537962eecd( ( 15800, -3800, 56 ) );
            function_63353d537962eecd( ( 10200, -7500, 56 ) );
            break;
        case #"hash_4dc3a20a08855da":
            function_63353d537962eecd( ( 18500, 200, 56 ) );
            function_63353d537962eecd( ( 8000, 10800, 56 ) );
            function_63353d537962eecd( ( 3100, 11700, 56 ) );
            function_63353d537962eecd( ( -12900, 2100, 56 ) );
            function_63353d537962eecd( ( -8000, -8300, 56 ) );
            function_63353d537962eecd( ( 11300, -7700, 56 ) );
            function_63353d537962eecd( ( 16300, -3300, 56 ) );
            function_63353d537962eecd( ( 15500, 3900, 56 ) );
            break;
        case #"hash_e30631e085140833":
            function_63353d537962eecd( ( -16600, -1100, 56 ) );
            function_63353d537962eecd( ( -8600, 6900, 56 ) );
            function_63353d537962eecd( ( 200, 11500, 56 ) );
            function_63353d537962eecd( ( 13000, 7800, 56 ) );
            function_63353d537962eecd( ( 15500, -3900, 56 ) );
            function_63353d537962eecd( ( 11500, -7400, 56 ) );
            function_63353d537962eecd( ( -7000, -9000, 56 ) );
            function_63353d537962eecd( ( -13000, -3800, 56 ) );
            function_63353d537962eecd( ( -13400, -1000, 56 ) );
            function_63353d537962eecd( ( -11600, 2500, 56 ) );
            break;
        case #"hash_b7ef1f59cc0d3ca8":
            function_63353d537962eecd( ( 2000, 12200, 56 ) );
            function_63353d537962eecd( ( 13500, 6900, 56 ) );
            function_63353d537962eecd( ( 16100, -600, 56 ) );
            function_63353d537962eecd( ( 15100, -4300, 56 ) );
            function_63353d537962eecd( ( 11800, -7100, 56 ) );
            function_63353d537962eecd( ( -6900, -8500, 56 ) );
            function_63353d537962eecd( ( -12600, -4100, 56 ) );
            function_63353d537962eecd( ( -10100, 5600, 56 ) );
            break;
        case #"hash_9a2adde286aaf659":
            function_63353d537962eecd( ( -10600, -7700, 56 ) );
            function_63353d537962eecd( ( -13600, -3300, 56 ) );
            function_63353d537962eecd( ( 1400, 12000, 56 ) );
            function_63353d537962eecd( ( 14600, 7100, 56 ) );
            function_63353d537962eecd( ( 16200, -3100, 56 ) );
            function_63353d537962eecd( ( 13200, -6500, 56 ) );
            function_63353d537962eecd( ( 12000, -7100, 56 ) );
            break;
        case #"hash_8c5f7784935d24a5":
            function_63353d537962eecd( ( 20000, 2500, 56 ) );
            function_63353d537962eecd( ( 15500, -5400, 56 ) );
            function_63353d537962eecd( ( -8200, -8200, 56 ) );
            function_63353d537962eecd( ( -12500, -4900, 56 ) );
            function_63353d537962eecd( ( 800, 11800, 56 ) );
            function_63353d537962eecd( ( 13000, 9200, 56 ) );
            function_63353d537962eecd( ( 17200, 2400, 56 ) );
            function_63353d537962eecd( ( 16000, -3100, 56 ) );
            break;
        case #"hash_604cf56e3d9478a5":
            function_63353d537962eecd( ( -14100, -300, 56 ) );
            function_63353d537962eecd( ( 700, 11600, 56 ) );
            function_63353d537962eecd( ( 15900, 3700, 56 ) );
            function_63353d537962eecd( ( 15600, -3900, 56 ) );
            function_63353d537962eecd( ( 12700, -6800, 56 ) );
            function_63353d537962eecd( ( 10000, -7900, 56 ) );
            function_63353d537962eecd( ( -6100, -9800, 56 ) );
            function_63353d537962eecd( ( -9900, -7700, 56 ) );
            function_63353d537962eecd( ( -12200, -4400, 56 ) );
            break;
    }
    
    self.var_ad2aab3cb9ffb7b[ self.var_ad2aab3cb9ffb7b.size ] = level.research_vessel.a_s_destinations[ str_path ];
    
    for ( i = 0; i < self.var_ad2aab3cb9ffb7b.size - 1 ; i++ )
    {
        self.var_ad2aab3cb9ffb7b[ i ].var_7b97f011bb3a6659 = self.var_ad2aab3cb9ffb7b[ i + 1 ];
    }
}

// Namespace br_research_vessel
// Params 1
// Checksum 0xf58c11bb, Offset: 0x7d90
// Size: 0x1c6
function function_e4f8330cd328f0fa( str_path )
{
    switch ( str_path )
    {
        case #"hash_5695fdbbff61405c":
            return [ ( -1700, -5100, 5000 ), ( 0, 120, 0 ) ];
        case #"hash_affa2b724bff3c28":
            return [ ( -16700, 2300, 56 ), ( 0, 295, 0 ) ];
        case #"hash_b84916758d35116":
            return [ ( -1800, -11100, 56 ), ( 0, 155, 0 ) ];
        case #"hash_4dc3a20a08855da":
            return [ ( 19000, -1500, 56 ), ( 0, 105, 0 ) ];
        case #"hash_e30631e085140833":
            return [ ( -17600, -2900, 56 ), ( 0, 60, 0 ) ];
        case #"hash_b7ef1f59cc0d3ca8":
            return [ ( -6700, 10200, 56 ), ( 0, 20, 0 ) ];
        case #"hash_9a2adde286aaf659":
            return [ ( -900, -11400, 56 ), ( 0, 160, 0 ) ];
        case #"hash_8c5f7784935d24a5":
            return [ ( 20500, 4800, 56 ), ( 0, 260, 0 ) ];
        case #"hash_604cf56e3d9478a5":
            return [ ( -15300, -5300, 56 ), ( 0, 80, 0 ) ];
    }
}

// Namespace br_research_vessel
// Params 2
// Checksum 0xbcc056de, Offset: 0x7f5e
// Size: 0x5e
function function_63353d537962eecd( origin, angles )
{
    s_node = spawnstruct();
    s_node.origin = origin;
    
    if ( isdefined( angles ) )
    {
        s_node.angles = angles;
    }
    
    self.var_ad2aab3cb9ffb7b[ self.var_ad2aab3cb9ffb7b.size ] = s_node;
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x466ad816, Offset: 0x7fc4
// Size: 0x97
function function_26131cae41c989b7()
{
    level endon( #"prematch_fade_done" );
    self endon( #"waittill_littlebirds_timeout" );
    waittill_littlebirds();
    
    while ( true )
    {
        littlebirds = sortbydistance( level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ], self.origin );
        
        if ( distancesquared( littlebirds[ 0 ].origin, self.origin ) < squared( 2000 ) )
        {
            littlebirds[ 0 ] hide();
            return;
        }
        
        wait level.framedurationseconds;
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x7e4f2155, Offset: 0x8063
// Size: 0x129
function function_71e93ca4ec664548()
{
    self endon( #"waittill_littlebirds_timeout" );
    waittill_littlebirds();
    i = 0;
    
    while ( i < 1 )
    {
        littlebirds = sortbydistance( level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ], self.origin );
        
        if ( distancesquared( littlebirds[ 0 ].origin, self.origin ) < squared( 2000 ) )
        {
            level.research_vessel.heli = littlebirds[ 0 ];
            level.research_vessel.heli show();
            return;
        }
        
        wait level.framedurationseconds;
        i += level.framedurationseconds;
    }
    
    littlebirds = sortbydistance( level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ], self.origin );
    level.research_vessel.heli = littlebirds[ 0 ];
    level.research_vessel.heli show();
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x11b300c6, Offset: 0x8194
// Size: 0xda
function waittill_littlebirds()
{
    self endon( #"waittill_littlebirds_timeout" );
    thread waittill_littlebirds_timeout( 10 );
    
    while ( !isdefined( level.vehicle ) )
    {
        wait level.framedurationseconds;
    }
    
    while ( !isdefined( level.vehicle.instances ) )
    {
        wait level.framedurationseconds;
    }
    
    while ( !level.vehicle.instances.size )
    {
        wait level.framedurationseconds;
    }
    
    while ( !isdefined( level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ] ) )
    {
        wait level.framedurationseconds;
    }
    
    while ( !level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ].size )
    {
        wait level.framedurationseconds;
    }
}

// Namespace br_research_vessel
// Params 1
// Checksum 0x121656ed, Offset: 0x8276
// Size: 0x55
function waittill_littlebirds_timeout( var_461c6327d0baaa86 )
{
    f_timeout_time = gettime() + var_461c6327d0baaa86 * 1000;
    
    while ( gettime() < f_timeout_time )
    {
        waitframe();
    }
    
    if ( !isdefined( level.research_vessel.heli ) )
    {
        self notify( #"waittill_littlebirds_timeout" );
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xacfb1e40, Offset: 0x82d3
// Size: 0x41
function boat_initcollision()
{
    leveldataforvehicle = vehicle_collision::get_data( %"hash_6d3feafb24bc9d6c", 1 );
    leveldataforvehicle.handleeventcallback = &function_3a3833d47360afd4;
    leveldataforvehicle.class = "immovable";
}

// Namespace br_research_vessel
// Params 5
// Checksum 0xf94a2a99, Offset: 0x831c
// Size: 0x2af
function function_3a3833d47360afd4( vehicle1, vehicle2, position, normal, normalspeed )
{
    /#
        if ( getdvarint( @"hash_f590f577104a1cd1" ) )
        {
            level thread function_2a3f1f621005f901( position );
        }
    #/
    
    if ( vehicle1 vehicle::get_ref() == %"hash_6d3feafb24bc9d6c" )
    {
        movingplatform = vehicle1;
        vehicle = vehicle2;
    }
    else
    {
        movingplatform = vehicle2;
        vehicle = vehicle1;
    }
    
    if ( !( isdefined( vehicle ) && isdefined( vehicle.health ) ) )
    {
        return;
    }
    
    vehicle_ref = vehicle vehicle::get_ref();
    
    if ( !isdefined( vehicle_ref ) || !vehicle::get_data( vehicle_ref ).isboat )
    {
        return;
    }
    
    v_forward = anglestoforward( level.research_vessel.angles ) * ( 900, 310, 0 )[ 0 ];
    v_right = anglestoright( level.research_vessel.angles ) * ( 900, 310, 0 )[ 1 ];
    v_up = ( 0, 0, 1 ) * ( 900, 310, 0 )[ 2 ];
    var_f61a786bf0066925 = level.research_vessel.origin + v_forward + v_right + v_up;
    var_f61a756bf006628c = level.research_vessel.origin + v_forward + -1 * v_right + v_up;
    
    if ( distancesquared( position, var_f61a786bf0066925 ) < squared( 150 ) || distancesquared( position, var_f61a756bf006628c ) < squared( 150 ) )
    {
        function_3c4f5b8ab17a516a( position, vehicle.vehiclename );
        
        foreach ( player in vehicle_occupancy::get_all_occupants( vehicle ) )
        {
            player thread function_5b6577fe786449c4();
        }
        
        vehicle.dontspawnhusk = 1;
        vehicle dodamage( 99999, vehicle.origin, movingplatform, undefined, "MOD_CRUSH" );
        return;
    }
    
    if ( vehicle.occupants.size == 0 )
    {
        vehicle vehicle_setspeedimmediate( vehicle.veh_speed * 0.99 );
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x761d4298, Offset: 0x85d3
// Size: 0x4b
function function_5b6577fe786449c4()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( self.disablelaststand )
    {
        return;
    }
    else
    {
        self.disablelaststand = 1;
    }
    
    while ( isalive( self ) )
    {
        waitframe();
    }
    
    self.disablelaststand = undefined;
}

// Namespace br_research_vessel
// Params 1
// Checksum 0x80d126b7, Offset: 0x8626
// Size: 0x7a
function function_fa0595ae9bf850d1( position )
{
    eventparams = [];
    eventparams[ eventparams.size ] = "pos_x";
    eventparams[ eventparams.size ] = position[ 0 ];
    eventparams[ eventparams.size ] = "pos_y";
    eventparams[ eventparams.size ] = position[ 1 ];
    eventparams[ eventparams.size ] = "pos_z";
    eventparams[ eventparams.size ] = position[ 2 ];
    eventparams[ eventparams.size ] = "time_since_match_start_ms";
    eventparams[ eventparams.size ] = game_utility::gettimepassed();
    dlog_recordevent( "dlog_event_br_research_vessel_gas_exclusion_used", eventparams );
}

// Namespace br_research_vessel
// Params 1
// Checksum 0x29a1844, Offset: 0x86a8
// Size: 0x6a
function analytics_uav_tower_used( position )
{
    eventparams = [ "pos_x", position[ 0 ], "pos_y", position[ 1 ], "pos_z", position[ 2 ], "time_since_match_start_ms", game_utility::gettimepassed() ];
    dlog_recordevent( "dlog_event_br_research_vessel_uav_tower_used", eventparams );
}

// Namespace br_research_vessel
// Params 2
// Checksum 0xa6260e0f, Offset: 0x871a
// Size: 0x6f
function function_3c4f5b8ab17a516a( position, vehicle_type )
{
    eventparams = [ "pos_x", position[ 0 ], "pos_y", position[ 1 ], "pos_z", position[ 2 ], "vehicle_type", vehicle_type ];
    dlog_recordevent( "dlog_event_br_research_vessel_vehicle_kill", eventparams );
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x7cc1fb50, Offset: 0x8791
// Size: 0x2
function quest_on_init()
{
    
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x554055e2, Offset: 0x879b
// Size: 0x2
function quest_on_start()
{
    
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x6accece6, Offset: 0x87a5
// Size: 0x257
function function_b9955c953168e1ad()
{
    flags::gameflagwait( "infil_animatic_complete" );
    var_9ccb699aa28cbcab = level.br_multi_circle.circles[ 0 ].circlecenters[ level.br_multi_circle.circles[ 0 ].circlecenters.size - 6 ];
    var_54d8df5a81dca5d3 = function_a9b0c7bddd31d7bd();
    var_5504f15a820d33cf = var_54d8df5a81dca5d3 + ( var_9ccb699aa28cbcab - var_54d8df5a81dca5d3 ) / 2;
    var_62054d16ac2b1ca4 = function_a9b0c7bddd31d7bd();
    var_61d92716abfa62ac = var_62054d16ac2b1ca4 + ( var_5504f15a820d33cf - var_62054d16ac2b1ca4 ) / 2;
    level.br_multi_circle.circles[ 0 ].circlecenters[ level.br_multi_circle.circles[ 0 ].circlecenters.size - 6 ] = var_5504f15a820d33cf;
    level.br_multi_circle.circles[ 0 ].circlecenters[ level.br_multi_circle.circles[ 0 ].circlecenters.size - 5 ] = var_61d92716abfa62ac;
    level.br_multi_circle.circles[ 0 ].circlecenters[ level.br_multi_circle.circles[ 0 ].circlecenters.size - 4 ] = function_a9b0c7bddd31d7bd();
    level.br_multi_circle.circles[ 0 ].circlecenters[ level.br_multi_circle.circles[ 0 ].circlecenters.size - 3 ] = function_a9b0c7bddd31d7bd();
    level.br_multi_circle.circles[ 0 ].circlecenters[ level.br_multi_circle.circles[ 0 ].circlecenters.size - 2 ] = function_a9b0c7bddd31d7bd();
    level.br_multi_circle.circles[ 0 ].circlecenters[ level.br_multi_circle.circles[ 0 ].circlecenters.size - 1 ] = function_a9b0c7bddd31d7bd();
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x885bbcbf, Offset: 0x8a04
// Size: 0xc2
function function_a9b0c7bddd31d7bd()
{
    s_destination = level.research_vessel.var_ad2aab3cb9ffb7b[ level.research_vessel.var_ad2aab3cb9ffb7b.size - 1 ];
    forward = 900;
    backward = -1750;
    right = 420;
    left = -1 * right;
    random_forward = anglestoforward( s_destination.angles ) * randomfloatrange( backward, forward );
    random_right = anglestoright( s_destination.angles ) * randomfloatrange( left, right );
    return s_destination.origin + random_forward + random_right;
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x79ab886c, Offset: 0x8acf
// Size: 0x191
function research_vessel_scriptables_cleanup()
{
    var_f1797b4763471e5 = [];
    var_fa2ff099ee7eba34 = getentitylessscriptablearray( undefined, undefined, self.origin, squared( 2000 ) );
    
    foreach ( var_b3053b25c717315a in var_fa2ff099ee7eba34 )
    {
        if ( distancesquared( var_b3053b25c717315a.origin, self.origin ) < squared( 2000 ) )
        {
            var_f1797b4763471e5[ var_f1797b4763471e5.size ] = var_b3053b25c717315a;
        }
    }
    
    foreach ( var_b3053b25c717315a in var_f1797b4763471e5 )
    {
        if ( var_b3053b25c717315a getscriptablehaspart( "body" ) )
        {
            var_b3053b25c717315a setscriptablepartstate( "body", "hidden" );
        }
        
        if ( var_b3053b25c717315a.type == "ammo_restock" )
        {
            var_b3053b25c717315a setscriptablepartstate( "model", "hidden" );
        }
        
        if ( issubstr( var_b3053b25c717315a.type, "brloot_" ) )
        {
            var_b3053b25c717315a setscriptablepartstate( var_b3053b25c717315a.type, "hidden" );
        }
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xd6734b53, Offset: 0x8c68
// Size: 0xd0
function function_82b804c0aec6cc65()
{
    var_fa2ff099ee7eba34 = getentitylessscriptablearray( undefined, undefined, self.origin, 2000 );
    
    foreach ( var_b3053b25c717315a in var_fa2ff099ee7eba34 )
    {
        if ( distancesquared( var_b3053b25c717315a.origin, self.origin ) < squared( 2000 ) && var_b3053b25c717315a.type == "ammo_restock" )
        {
            var_b3053b25c717315a setscriptablepartstate( "military_ammo_restock", "useable_off" );
        }
    }
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x54893a18, Offset: 0x8d40
// Size: 0x12a
function research_vessel_heli_cleanup()
{
    while ( true )
    {
        if ( !isdefined( level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ] ) )
        {
            return;
        }
        
        littlebirds = sortbydistance( level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ], self.origin );
        
        if ( distancesquared( littlebirds[ 0 ].origin, self.origin ) < squared( 2000 ) )
        {
            prematch_bird = littlebirds[ 0 ];
            break;
        }
        
        wait level.framedurationseconds;
    }
    
    while ( isdefined( prematch_bird ) )
    {
        wait level.framedurationseconds;
    }
    
    waittill_littlebirds();
    
    while ( true )
    {
        littlebirds = sortbydistance( level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ], self.origin );
        
        if ( distancesquared( littlebirds[ 0 ].origin, self.origin ) < squared( 2000 ) )
        {
            littlebirds[ 0 ] hide();
            break;
        }
        
        wait level.framedurationseconds;
    }
}

// Namespace br_research_vessel
// Params 1
// Checksum 0x4429ff06, Offset: 0x8e72
// Size: 0x3a, Type: bool
function function_ac89ef5650a8e9( streakinfo )
{
    if ( !level.research_vessel.b_docked && function_97301e2f065abde3( self.origin ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_research_vessel
// Params 1
// Checksum 0xf9fee3a7, Offset: 0x8eb5
// Size: 0x22, Type: bool
function function_91309c8d98117177( streakinfo )
{
    if ( function_97301e2f065abde3( self.origin ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_research_vessel
// Params 0
// Checksum 0x9f5ed1da, Offset: 0x8ee0
// Size: 0x11
function function_dcaa97c6e855f2b()
{
    return function_97301e2f065abde3( self.origin );
}

// Namespace br_research_vessel
// Params 1
// Checksum 0x1ad9e1ed, Offset: 0x8efa
// Size: 0x1a4, Type: bool
function function_97301e2f065abde3( v_pos )
{
    forward = 1100;
    backward = -1900;
    right = 550;
    left = -1 * right;
    v_back_right = level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * backward + anglestoright( level.research_vessel.angles ) * right;
    v_forward_left = level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * forward + anglestoright( level.research_vessel.angles ) * left;
    var_d1b28165faf8ae1 = v_forward_left - v_back_right;
    var_e5ad17bd9f4e1cd8 = v_pos - v_back_right;
    var_c3b5002329a0f789 = rotatevector( var_d1b28165faf8ae1, ( 0, level.research_vessel.angles[ 1 ] * -1, 0 ) );
    v_pos_adjusted = rotatevector( var_e5ad17bd9f4e1cd8, ( 0, level.research_vessel.angles[ 1 ] * -1, 0 ) );
    maxx = var_c3b5002329a0f789[ 0 ];
    maxy = var_c3b5002329a0f789[ 1 ];
    
    if ( 0 < v_pos_adjusted[ 0 ] && v_pos_adjusted[ 0 ] < maxx && 0 < v_pos_adjusted[ 1 ] && v_pos_adjusted[ 1 ] < maxy )
    {
        return true;
    }
    
    return false;
}

// Namespace br_research_vessel
// Params 1
// Checksum 0x3842a82c, Offset: 0x90a7
// Size: 0xe8
function function_d241b7c3db2cbb( str )
{
    if ( self.var_85b4a441914ab683 )
    {
        return;
    }
    
    switch ( str )
    {
        case #"hash_403206320a45694a":
            self.var_900f90ed4bf358b4 = 1;
            break;
        case #"hash_ddd9135494086ba0":
            self.var_5778148e709bcaca = 1;
            break;
        case #"hash_67ae47e606d4e89d":
            self.research_vessel_uav_tower_used = 1;
            break;
        default:
            assertmsg( "<dev string:x203>" );
            break;
    }
    
    if ( self.var_900f90ed4bf358b4 && self.var_5778148e709bcaca && self.research_vessel_uav_tower_used )
    {
        challenges::function_37e945722d6497f3( self, "BR_DECAY_VESSEL_ACTIVATE_TRIO", 1 );
        self.var_85b4a441914ab683 = 1;
        self.var_900f90ed4bf358b4 = undefined;
        self.var_5778148e709bcaca = undefined;
        self.research_vessel_uav_tower_used = undefined;
    }
}

// Namespace br_research_vessel
// Params 1
// Checksum 0xb4c1fc77, Offset: 0x9197
// Size: 0x53
function function_48d495a74a5dada2( params )
{
    if ( isdefined( params.player ) && function_97301e2f065abde3( params.player.origin ) )
    {
        challenges::function_37e945722d6497f3( params.player, "BR_DECAY_VESSEL_LOOT_CACHE", 1 );
    }
}

// Namespace br_research_vessel
// Params 2
// Checksum 0x1d1ab6dc, Offset: 0x91f2
// Size: 0x68
function research_vessel_audio_trigger_enter( ent, trigger )
{
    if ( !isplayer( ent ) )
    {
        return;
    }
    
    if ( !isdefined( ent.var_bf29f3b699f8bc13 ) )
    {
        ent.var_bf29f3b699f8bc13 = [];
    }
    
    ent.var_bf29f3b699f8bc13[ ent.var_bf29f3b699f8bc13.size ] = trigger.script_noteworthy;
    ent function_466dfa87dad5ef6a();
}

// Namespace br_research_vessel
// Params 2
// Checksum 0x5143c290, Offset: 0x9262
// Size: 0x4f
function research_vessel_audio_trigger_exit( ent, trigger )
{
    if ( !isplayer( ent ) )
    {
        return;
    }
    
    ent.var_bf29f3b699f8bc13 = arrayremove( ent.var_bf29f3b699f8bc13, trigger.script_noteworthy );
    ent function_466dfa87dad5ef6a();
}

// Namespace br_research_vessel
// Params 0
// Checksum 0xd8202bdb, Offset: 0x92b9
// Size: 0xe0
function function_466dfa87dad5ef6a()
{
    if ( self.var_bf29f3b699f8bc13.size )
    {
        zone_to_use = undefined;
        
        foreach ( zone in self.var_bf29f3b699f8bc13 )
        {
            if ( issubstr( zone, "stairwell" ) )
            {
                zone_to_use = zone;
                break;
            }
            
            if ( issubstr( zone, "exterior" ) && !isdefined( zone_to_use ) )
            {
                zone_to_use = zone;
            }
            
            if ( !issubstr( zone, "exterior" ) )
            {
                zone_to_use = zone;
            }
        }
        
        self setclienttriggeraudiozone( zone_to_use, 1 );
        return;
    }
    
    self clearclienttriggeraudiozone( 0 );
}

/#

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x3b4bc744, Offset: 0x93a1
    // Size: 0x5, Type: dev
    function function_eea18adbdbb5777c()
    {
        
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x4cdf5b17, Offset: 0x93ae
    // Size: 0x44, Type: dev
    function debug_init()
    {
        level waittill( #"player_spawned" );
        level thread function_6c025e2cb9e2dd26();
        utility::function_95db22f620602461( @"hash_1d1672e5f6dcd5a5", &function_6a414a3d389a6b53 );
        utility::function_95db22f620602461( @"hash_f590f577104a1cd1", &function_e2453e125bf029f );
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x4edb30af, Offset: 0x93fa
    // Size: 0x70, Type: dev
    function function_6c025e2cb9e2dd26()
    {
        devgui::function_9082edeb5db93280( "<dev string:x247>" );
        devgui::add_devgui_func( "<dev string:x25b>", "<dev string:x266>", &function_f22345c1786809e1 );
        devgui::add_devgui_func( "<dev string:x281>", "<dev string:x299>", &function_490cf6880dcb2011 );
        devgui::add_devgui_func( "<dev string:x2c1>", "<dev string:x2d2>", &function_31d3ec460499b643 );
        devgui::add_devgui_func( "<dev string:x2e6>", "<dev string:x2fa>", &function_b61ab6cc3dfc945f );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x81e50832, Offset: 0x9472
    // Size: 0x2a, Type: dev
    function function_f22345c1786809e1()
    {
        if ( !getdvarint( @"hash_1d1672e5f6dcd5a5", 0 ) )
        {
            level thread function_6a414a3d389a6b53();
            return;
        }
        
        level thread function_482469a37bbfea17();
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0xeb3ffd80, Offset: 0x94a4
    // Size: 0xe6, Type: dev
    function function_6a414a3d389a6b53()
    {
        setdvar( @"hash_1d1672e5f6dcd5a5", 1 );
        iprintlnbold( "<dev string:x317>" );
        
        while ( !isdefined( level.research_vessel.var_ad2aab3cb9ffb7b ) )
        {
            wait level.framedurationseconds;
        }
        
        for ( i = 0; i < level.research_vessel.var_ad2aab3cb9ffb7b.size - 1 ; i++ )
        {
            debug::line( level.research_vessel.var_ad2aab3cb9ffb7b[ i ], level.research_vessel.var_ad2aab3cb9ffb7b[ i + 1 ], undefined, undefined, "<dev string:x33e>" );
            debug::print3d( level.research_vessel.var_ad2aab3cb9ffb7b[ i ].origin, i, undefined, undefined, "<dev string:x33e>", undefined, undefined, 20, 200 );
        }
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0xeda06400, Offset: 0x9592
    // Size: 0x2a, Type: dev
    function function_482469a37bbfea17()
    {
        setdvar( @"hash_1d1672e5f6dcd5a5", 0 );
        iprintlnbold( "<dev string:x36a>" );
        level notify( #"hash_afadd0c3a7174d76" );
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x117df44e, Offset: 0x95c4
    // Size: 0x47, Type: dev
    function function_31d3ec460499b643()
    {
        if ( !getdvarint( @"hash_b43200fbf59c0359", 0 ) )
        {
            setdvar( @"hash_b43200fbf59c0359", 1 );
            function_1a2772ac6cc0431d();
            return;
        }
        
        setdvar( @"hash_b43200fbf59c0359", 0 );
        function_44e17c332aadb639();
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x1ef9e1dd, Offset: 0x9613
    // Size: 0xbb, Type: dev
    function function_1a2772ac6cc0431d()
    {
        foreach ( sfx in level.research_vessel.sfx )
        {
            debug::sphere( sfx, 1, "<dev string:x392>", undefined, "<dev string:x396>" );
            debug::print3d( sfx, sfx.type, "<dev string:x392>", undefined, "<dev string:x396>", undefined, 1, 1, 10 );
        }
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0xc54885a4, Offset: 0x96d6
    // Size: 0x11, Type: dev
    function function_44e17c332aadb639()
    {
        level notify( #"hash_cf62c22d212e55d" );
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0xb1211d39, Offset: 0x96ef
    // Size: 0x79, Type: dev
    function function_458fa6eeb26e0a32()
    {
        level.research_vessel.path_timer = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_79a6a5e84a38efe8", 0 ) )
            {
                iprintlnbold( level.research_vessel.path_timer );
            }
            
            wait 1;
            
            if ( !level.research_vessel.var_c867e26ccf89e5cf )
            {
                level.research_vessel.path_timer++;
            }
        }
    }

    // Namespace br_research_vessel
    // Params 2
    // Checksum 0x24905455, Offset: 0x9770
    // Size: 0xdd, Type: dev
    function function_3395900a15b2a16f( start, duration )
    {
        while ( level.research_vessel.path_timer != start )
        {
            wait 1;
        }
        
        origin = level.research_vessel.origin;
        angles = level.research_vessel.angles;
        var_99282ff58ec55b2b = level.research_vessel.var_99282ff58ec55b2b;
        
        while ( true )
        {
            wait duration;
            level.research_vessel.origin = origin;
            level.research_vessel.angles = angles;
            level.research_vessel.var_99282ff58ec55b2b = var_99282ff58ec55b2b;
        }
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x4f7f071a, Offset: 0x9855
    // Size: 0x2d6, Type: dev
    function debug_waterline()
    {
        forward = 900;
        backward = -1750;
        right = 420;
        left = -1 * right;
        
        while ( true )
        {
            line( level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * forward + anglestoright( level.research_vessel.angles ) * right, level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * forward + anglestoright( level.research_vessel.angles ) * left, ( 1, 0, 0 ) );
            line( level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * backward + anglestoright( level.research_vessel.angles ) * right, level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * backward + anglestoright( level.research_vessel.angles ) * left, ( 1, 0, 0 ) );
            line( level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * forward + anglestoright( level.research_vessel.angles ) * right, level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * backward + anglestoright( level.research_vessel.angles ) * right, ( 1, 0, 0 ) );
            line( level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * forward + anglestoright( level.research_vessel.angles ) * left, level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * backward + anglestoright( level.research_vessel.angles ) * left, ( 1, 0, 0 ) );
            waitframe();
        }
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0xc28f6e89, Offset: 0x9b33
    // Size: 0x27, Type: dev
    function function_490cf6880dcb2011()
    {
        if ( !getdvarint( @"hash_f590f577104a1cd1" ) )
        {
            function_e2453e125bf029f();
            return;
        }
        
        function_d90a61260339ae23();
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x731c7f9c, Offset: 0x9b62
    // Size: 0x27, Type: dev
    function function_e2453e125bf029f()
    {
        setdvar( @"hash_f590f577104a1cd1", 1 );
        iprintlnbold( "<dev string:x3b4>" );
        level thread function_84f7fd3b449ba015();
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x9d907989, Offset: 0x9b91
    // Size: 0x32, Type: dev
    function function_d90a61260339ae23()
    {
        setdvar( @"hash_f590f577104a1cd1", 0 );
        iprintlnbold( "<dev string:x3e8>" );
        level.research_vessel notify( #"hash_aa8017feb8f5617d" );
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x46bbe455, Offset: 0x9bcb
    // Size: 0x118, Type: dev
    function function_84f7fd3b449ba015()
    {
        level.research_vessel endon( #"hash_aa8017feb8f5617d" );
        
        while ( true )
        {
            v_forward = anglestoforward( level.research_vessel.angles ) * ( 900, 310, 0 )[ 0 ];
            v_right = anglestoright( level.research_vessel.angles ) * ( 900, 310, 0 )[ 1 ];
            v_up = ( 0, 0, 1 ) * ( 900, 310, 0 )[ 2 ];
            sphere( level.research_vessel.origin + v_forward + v_right + v_up, 150, ( 1, 0, 0 ), 0, 1 );
            sphere( level.research_vessel.origin + v_forward + -1 * v_right + v_up, 150, ( 1, 0, 0 ), 0, 1 );
            waitframe();
        }
    }

    // Namespace br_research_vessel
    // Params 1
    // Checksum 0xb80bea90, Offset: 0x9ceb
    // Size: 0x5f, Type: dev
    function function_2a3f1f621005f901( v_pos )
    {
        hit = spawn( "<dev string:x41d>", v_pos );
        hit linkto( level.research_vessel );
        debug::sphere( hit, 5 );
        level.research_vessel utility::waittill_any_timeout( 30, "<dev string:x42a>" );
        hit delete();
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0xeb22c2f4, Offset: 0x9d52
    // Size: 0x2d6, Type: dev
    function function_49639aa3c37378f6()
    {
        forward = 1100;
        backward = -1900;
        right = 550;
        left = -1 * right;
        
        while ( true )
        {
            line( level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * forward + anglestoright( level.research_vessel.angles ) * right, level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * forward + anglestoright( level.research_vessel.angles ) * left, ( 1, 0, 0 ) );
            line( level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * backward + anglestoright( level.research_vessel.angles ) * right, level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * backward + anglestoright( level.research_vessel.angles ) * left, ( 1, 0, 0 ) );
            line( level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * forward + anglestoright( level.research_vessel.angles ) * right, level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * backward + anglestoright( level.research_vessel.angles ) * right, ( 1, 0, 0 ) );
            line( level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * forward + anglestoright( level.research_vessel.angles ) * left, level.research_vessel.origin + anglestoforward( level.research_vessel.angles ) * backward + anglestoright( level.research_vessel.angles ) * left, ( 1, 0, 0 ) );
            waitframe();
        }
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0xe4c256eb, Offset: 0xa030
    // Size: 0x3a, Type: dev
    function function_b61ab6cc3dfc945f()
    {
        if ( !level.research_vessel_player_trace )
        {
            level.research_vessel_player_trace = 1;
            level thread function_f1d68f0b53674e9();
            return;
        }
        
        level.research_vessel_player_trace = undefined;
        level thread function_7446485e86eaae05();
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x8ba79335, Offset: 0xa072
    // Size: 0xc0, Type: dev
    function function_f1d68f0b53674e9()
    {
        level endon( #"hash_809ccee48e460a44" );
        trace_contents = trace::create_contents( 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0 );
        
        while ( true )
        {
            starttrace = level.player getvieworigin();
            endtrace = starttrace + anglestoforward( level.player getplayerangles() ) * 1000;
            trace = trace::ray_trace( starttrace, endtrace, level.player, trace_contents );
            sphere( trace[ "<dev string:x456>" ], 1, ( 1, 1, 1 ), 0, 1 );
            iprintlnbold( trace[ "<dev string:x456>" ] );
            waitframe();
        }
    }

    // Namespace br_research_vessel
    // Params 0
    // Checksum 0x2dae842a, Offset: 0xa13a
    // Size: 0x11, Type: dev
    function function_7446485e86eaae05()
    {
        level notify( #"hash_809ccee48e460a44" );
    }

#/
