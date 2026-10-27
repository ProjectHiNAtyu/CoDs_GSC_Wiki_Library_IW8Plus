// scripts\mp\ob\contracts\sat_ob_contract_capricorn_mission_launch.gsc  (hash_285f3796d3002c6e.gscc) (size: 1837 Bytes / 0x72d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcd83edd (215498461)
// size ...... 1837 (0x72d)
// includes .. 3   (offset: 0x6cd)
// strings ... 3   (offset: 0x6e5)
// dev strs .. 1   (offset: 0x721)
// exports ... 12  (offset: 0x31d)
// cseg ...... 0x98 + 0x285 (0x31d)
// imports ... 16  (offset: 0x4fd)
// animtree1 . 0   (offset: 0x72d)
// animtree2 . 0   (offset: 0x72d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;

#namespace sat_ob_contract_capricorn_mission_launch;

// Namespace sat_ob_contract_capricorn_mission_launch
// Params 0, eflags: 0x5
// Checksum 0xa53b565c, Offset: 0xb6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_7db7b6e0e3424449", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace sat_ob_contract_capricorn_mission_launch
// Params 0, eflags: 0x4
// Checksum 0x771e6788, Offset: 0xdf
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_CAPRICORN_MISSION_LAUNCH", &activity_type_init );
}

// Namespace sat_ob_contract_capricorn_mission_launch
// Params 0
// Checksum 0x4541e360, Offset: 0xfa
// Size: 0x79
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_CAPRICORN_MISSION_LAUNCH", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_CAPRICORN_MISSION_LAUNCH", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_CAPRICORN_MISSION_LAUNCH", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_CAPRICORN_MISSION_LAUNCH", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_CAPRICORN_MISSION_LAUNCH" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_CAPRICORN_MISSION_LAUNCH" );
}

// Namespace sat_ob_contract_capricorn_mission_launch
// Params 0
// Checksum 0xa53f8c1e, Offset: 0x17b
// Size: 0x32
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace sat_ob_contract_capricorn_mission_launch
// Params 0
// Checksum 0x9e8ea2d, Offset: 0x1b5
// Size: 0x47
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    wait 3;
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace sat_ob_contract_capricorn_mission_launch
// Params 1
// Checksum 0xc0e609fb, Offset: 0x204
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace sat_ob_contract_capricorn_mission_launch
// Params 0
// Checksum 0xab6ec7c7, Offset: 0x232
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace sat_ob_contract_capricorn_mission_launch
// Params 0
// Checksum 0x1713faba, Offset: 0x256
// Size: 0xf
function get_activity_center_point()
{
    return ( 0, 0, 0 );
}

// Namespace sat_ob_contract_capricorn_mission_launch
// Params 0
// Checksum 0x34c6f0fc, Offset: 0x26e
// Size: 0x44
function function_470b4f0cecef4cf4()
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace sat_ob_contract_capricorn_mission_launch
// Params 1
// Checksum 0x613dd152, Offset: 0x2ba
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace sat_ob_contract_capricorn_mission_launch
// Params 1
// Checksum 0xbd623876, Offset: 0x2fa
// Size: 0x23
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

