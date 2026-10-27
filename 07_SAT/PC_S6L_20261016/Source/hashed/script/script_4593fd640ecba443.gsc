// script_4593fd640ecba443  (hash_4593fd640ecba443.gscc) (size: 5233 Bytes / 0x1471 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6b7665c4 (1802921412)
// size ...... 5233 (0x1471)
// includes .. 11  (offset: 0x1285)
// strings ... 27  (offset: 0x12dd)
// dev strs .. 0   (offset: 0x1471)
// exports ... 19  (offset: 0x9ed)
// cseg ...... 0x2fd + 0x6f0 (0x9ed)
// imports ... 49  (offset: 0xce5)
// animtree1 . 0   (offset: 0x1471)
// animtree2 . 0   (offset: 0x1471)
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;

#namespace namespace_9ac0a47dc9935869;

/#

    // Namespace namespace_9ac0a47dc9935869
    // Params 0
    // Checksum 0xdaa5737, Offset: 0x31b
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_9ac0a47dc9935869
// Params 0, eflags: 0x5
// Checksum 0x2df21108, Offset: 0x328
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_26be850eb72d56ba", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_9ac0a47dc9935869
// Params 0, eflags: 0x4
// Checksum 0xe1c46055, Offset: 0x351
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_AMBUSH_EXIT";
    activity_common::registeractivitytype( "OB_LIBRA_AMBUSH_EXIT", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_AMBUSH_EXIT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_AMBUSH_EXIT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_AMBUSH_EXIT", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_9ac0a47dc9935869
// Params 0
// Checksum 0xeb68f0e2, Offset: 0x3b2
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance setup();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_9ac0a47dc9935869
// Params 0
// Checksum 0x3e96410a, Offset: 0x417
// Size: 0x48
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance ambush_exit_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_9ac0a47dc9935869
// Params 0
// Checksum 0x909dccc8, Offset: 0x467
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_9ac0a47dc9935869
// Params 0
// Checksum 0x7cff829a, Offset: 0x48b
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_AMBUSH_EXIT" );
}

/#

    // Namespace namespace_9ac0a47dc9935869
    // Params 0
    // Checksum 0x4a10f327, Offset: 0x4a1
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_9ac0a47dc9935869
// Params 0
// Checksum 0x2028a455, Offset: 0x4ae
// Size: 0x4d
function setup()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    level thread setup_force_fields();
    level thread mp_sat_ob_libra_util::function_32b80bf22f39a811( "utility_fan", "roll", 2, "start_processing", %"electronics_fan_box_lg_01_blade" );
    level thread function_c616e09e9efbaca5();
}

// Namespace namespace_9ac0a47dc9935869
// Params 0
// Checksum 0x2d49402a, Offset: 0x503
// Size: 0x240
function ambush_exit_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_AMBUSH_EXIT" );
    level thread mp_sat_ob_libra_vo::ambush_exit_intro();
    activateworldevent( "LGT_utility_alarm" );
    level thread ambush_exit_fx();
    mp_sat_ob_libra_util::function_c58a10af89e58f3f( "ambush_exit_interact_org", "flag_ambush_exit_hatch_01_opened", &"sat_ob_story_missions/interact_open" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "ambush_exit_01_waypoint_org", undefined, "ambush_exit_01_waypoint_org_waypoint_done", undefined, undefined, 1, 0, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_ambush_exit_hatch_01_opened", "ambush_exit_01_waypoint_org" );
    level utility::flag_wait( "flag_ambush_exit_hatch_01_opened" );
    level thread function_6af087f67e6ca3a4();
    level thread setup_ambush_exit_swim_door();
    playsoundatpos( ( 4893, -4145, 1137 ), #"hash_a5c4309750473a0e" );
    ambush_exit_hatch_01 = getent( "ambush_exit_hatch_01", #targetname );
    ambush_exit_hatch_01.clip = getent( "ambush_exit_hatch_01_clip", #targetname );
    
    if ( isdefined( ambush_exit_hatch_01 ) && ambush_exit_hatch_01.clip )
    {
        ambush_exit_hatch_01.clip linkto( ambush_exit_hatch_01 );
        ambush_exit_hatch_01 rotateyaw( -88, 1, 0.5, 0.25 );
        ambush_exit_hatch_01.clip connectpaths();
    }
    
    ambush_exit_hatch_02 = getent( "ambush_exit_hatch_02", #targetname );
    ambush_exit_hatch_02.clip = getent( "ambush_exit_hatch_02_clip", #targetname );
    
    if ( isdefined( ambush_exit_hatch_02 ) && ambush_exit_hatch_02.clip )
    {
        ambush_exit_hatch_02.clip linkto( ambush_exit_hatch_02 );
        ambush_exit_hatch_02 rotateyaw( 89, 1, 0.5, 0.25 );
        ambush_exit_hatch_02.clip connectpaths();
    }
    
    level thread mp_sat_ob_libra_vo::ambush_exit_outro();
    level thread mp_sat_ob_libra_vo::ambush_exit_tunnel();
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "ambush_exit_02_waypoint_org", undefined, "ambush_exit_02_waypoint_org_waypoint_done", undefined, undefined, 1, 0 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_ambush_exit_done", "ambush_exit_02_waypoint_org" );
    level utility::flag_set( "flag_ambush_escaped" );
    level utility::flag_wait( "flag_ambush_exit_done" );
    deactivateworldevent( "LGT_utility_alarm" );
}

// Namespace namespace_9ac0a47dc9935869
// Params 0, eflags: 0x4
// Checksum 0x62a35110, Offset: 0x74b
// Size: 0x21
function private facility_intro_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    setup_ui_widget();
}

// Namespace namespace_9ac0a47dc9935869
// Params 0
// Checksum 0xd91cd98e, Offset: 0x774
// Size: 0x3a
function setup_force_fields()
{
    mp_sat_ob_libra_util::function_7e4765db24e0ee73( "off", "ambush_tutorial_ff", #targetname, 1 );
    mp_sat_ob_libra_util::function_7e4765db24e0ee73( "off", "ambush_ff_01", #targetname, 1 );
}

// Namespace namespace_9ac0a47dc9935869
// Params 0
// Checksum 0x48ca156d, Offset: 0x7b6
// Size: 0xe3
function function_6af087f67e6ca3a4()
{
    level endon( #"start_processing" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player.sessionstate != "playing" )
            {
                continue;
            }
            
            if ( isdefined( player.var_d21a2e68a9d4148a ) )
            {
                continue;
            }
            
            player.var_d21a2e68a9d4148a = 1;
            player thread function_3bd0f2e32e1a9fcb( "start_processing" );
            player thread libra_audio::function_8965bc616d65aa2e( "start_processing" );
            player thread libra_audio::ambush_exit_swim_door_exit();
        }
        
        waitframe();
    }
}

// Namespace namespace_9ac0a47dc9935869
// Params 1
// Checksum 0xbca0ce71, Offset: 0x8a1
// Size: 0x59
function function_3bd0f2e32e1a9fcb( ender )
{
    level endon( ender );
    
    while ( true )
    {
        utility::ent_flag_wait( "flag_inside_ambush_exit_hallucination" );
        level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", undefined, undefined, self, undefined, undefined, 1 );
        utility::ent_flag_waitopen_any( "flag_inside_ambush_exit_hallucination" );
        level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", undefined, undefined, self, undefined, undefined, 1 );
    }
}

// Namespace namespace_9ac0a47dc9935869
// Params 0
// Checksum 0xb29f2116, Offset: 0x902
// Size: 0x39
function setup_ambush_exit_swim_door()
{
    ambush_exit_swim_door = getent( "ambush_exit_swim_door", #script_noteworthy );
    
    if ( isdefined( ambush_exit_swim_door ) )
    {
        ambush_exit_swim_door thread ambush_exit_swim_door_opened( "libra_util_swim_exit_door_bubbles_vfx", "start_processing" );
    }
}

// Namespace namespace_9ac0a47dc9935869
// Params 2
// Checksum 0x4fb5d500, Offset: 0x943
// Size: 0x44
function ambush_exit_swim_door_opened( exploder, ender )
{
    self endon( #"death" );
    level endon( ender );
    
    while ( true )
    {
        self waittill( #"opening" );
        utility::exploder( exploder );
    }
}

// Namespace namespace_9ac0a47dc9935869
// Params 0
// Checksum 0xf2d65b17, Offset: 0x98f
// Size: 0x27
function ambush_exit_fx()
{
    utility::exploder( "libra_ambush_exit" );
    level utility::flag_wait( "start_processing" );
    utility::stop_exploder( "libra_ambush_exit" );
}

// Namespace namespace_9ac0a47dc9935869
// Params 0
// Checksum 0xa3cecda8, Offset: 0x9be
// Size: 0x2f
function function_c616e09e9efbaca5()
{
    utility_entrance_door = getent( "utility_entrance_door", #script_noteworthy );
    
    if ( isdefined( utility_entrance_door ) )
    {
        utility_entrance_door thread scriptable_door_utility::simple_lock_door();
    }
}

