// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_boat.gsc  (hash_73c67e55dc629462.gscc) (size: 3052 Bytes / 0xbec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x65e0266e (1709188718)
// size ...... 3052 (0xbec)
// includes .. 8   (offset: 0xb34)
// strings ... 7   (offset: 0xb74)
// dev strs .. 0   (offset: 0xbec)
// exports ... 12  (offset: 0x5d8)
// cseg ...... 0xea + 0x4ee (0x5d8)
// imports ... 31  (offset: 0x7b8)
// animtree1 . 0   (offset: 0xbec)
// animtree2 . 0   (offset: 0xbec)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_intro;

#namespace mp_sat_ob_capricorn_boat;

// Namespace mp_sat_ob_capricorn_boat
// Params 0, eflags: 0x5
// Checksum 0x709c1b37, Offset: 0x108
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_ob_capricorn_boat", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_capricorn_boat
// Params 0, eflags: 0x4
// Checksum 0x200160ef, Offset: 0x131
// Size: 0x82
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_CAPRICORN_BOAT";
    activity_common::registeractivitytype( "OB_CAPRICORN_BOAT", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_BOAT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_BOAT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_BOAT", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_BOAT", 9, &activity_cleanup );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_CAPRICORN_BOAT" );
}

// Namespace mp_sat_ob_capricorn_boat
// Params 0
// Checksum 0x9b332aa4, Offset: 0x1bb
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_capricorn_boat
// Params 0
// Checksum 0x8a24ce0a, Offset: 0x220
// Size: 0x2
function activity_cleanup()
{
    
}

// Namespace mp_sat_ob_capricorn_boat
// Params 0
// Checksum 0xa5527854, Offset: 0x22a
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_capricorn_boat
// Params 0
// Checksum 0xf99cf56a, Offset: 0x26f
// Size: 0xaa
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( level.var_3d9fc7aa7b25b565.boats )
    {
        foreach ( player in level.players )
        {
            level thread function_8c486bcd41c2aab7( player );
        }
    }
}

// Namespace mp_sat_ob_capricorn_boat
// Params 1
// Checksum 0xb4c9b6e1, Offset: 0x321
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

// Namespace mp_sat_ob_capricorn_boat
// Params 0
// Checksum 0x5ef5d588, Offset: 0x3dd
// Size: 0x1d
function start()
{
    activity_instance = self;
    mp_sat_ob_capricorn_intro::function_aa6018fc7bc95be6();
    mp_sat_ob_capricorn_intro::function_6000b34e76e11764();
}

// Namespace mp_sat_ob_capricorn_boat
// Params 0
// Checksum 0xcf24fd09, Offset: 0x402
// Size: 0xfb
function main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_BOAT" );
    
    foreach ( player in level.players )
    {
        player thread mp_sat_ob_capricorn_intro::function_14ef622671fda1d7();
    }
    
    hijack_objective = utility::getstruct( "OB_CAPRICORN_HIJACK_OBJECTIVE", "targetname" );
    hijack_obj_id = activity_instance ob_story_mission_utils::function_b9cb179f9577f32a( hijack_objective.origin, 0 );
    level utility::flag_wait( "OB_CAPRICORN_REACHED_HIJACK" );
    activity_instance ob_story_mission_utils::objective_marker_clear( hijack_obj_id );
}

// Namespace mp_sat_ob_capricorn_boat
// Params 1, eflags: 0x4
// Checksum 0x419fbf85, Offset: 0x505
// Size: 0x3d
function private player_setup( player )
{
    activity_instance = self;
    utility::callsharedfunc( #"gametype", #"hash_b64530c1428fda8", player );
    player thread mp_sat_ob_capricorn_intro::function_ac60bfbecdb7332a();
}

// Namespace mp_sat_ob_capricorn_boat
// Params 1, eflags: 0x4
// Checksum 0x9a6a4cc4, Offset: 0x54a
// Size: 0x8e
function private function_8c486bcd41c2aab7( player )
{
    player endon( #"disconnect" );
    hijack_objective = utility::getstruct( "OB_CAPRICORN_HIJACK_OBJECTIVE", "targetname" );
    var_b02273968e3fffda = 4000000;
    
    while ( true )
    {
        if ( isalive( player ) && distancesquared( player.origin, hijack_objective.origin ) < var_b02273968e3fffda )
        {
            player val::set( "capricorn_boat", "vehicle_use", 0 );
            break;
        }
        
        waitframe();
    }
}

