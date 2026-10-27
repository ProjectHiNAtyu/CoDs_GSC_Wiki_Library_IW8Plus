// script_4c4330bad5b7fb6e  (hash_4c4330bad5b7fb6e.gscc) (size: 1560 Bytes / 0x618 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x45e2d53f (1172493631)
// size ...... 1560 (0x618)
// includes .. 3   (offset: 0x5c4)
// strings ... 3   (offset: 0x5dc)
// dev strs .. 0   (offset: 0x618)
// exports ... 10  (offset: 0x29c)
// cseg ...... 0x8e + 0x20e (0x29c)
// imports ... 14  (offset: 0x42c)
// animtree1 . 0   (offset: 0x618)
// animtree2 . 0   (offset: 0x618)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;

#namespace namespace_c12ffbbe1095ddec;

// Namespace namespace_c12ffbbe1095ddec
// Params 0, eflags: 0x5
// Checksum 0xadf178c2, Offset: 0xac
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_58deb69f76e1f9ad", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_c12ffbbe1095ddec
// Params 0, eflags: 0x4
// Checksum 0xf1ebf5bc, Offset: 0xd5
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_CONTRACT_BOMBPLANT", &activity_type_init );
}

// Namespace namespace_c12ffbbe1095ddec
// Params 0
// Checksum 0xa7b46dea, Offset: 0xf0
// Size: 0x79
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_BOMBPLANT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_BOMBPLANT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_BOMBPLANT", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_BOMBPLANT", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BR_CONTRACT_BOMBPLANT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "BR_CONTRACT_BOMBPLANT" );
}

// Namespace namespace_c12ffbbe1095ddec
// Params 0
// Checksum 0x47ca0294, Offset: 0x171
// Size: 0x32
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_c12ffbbe1095ddec
// Params 0
// Checksum 0x81caba7d, Offset: 0x1ab
// Size: 0x34
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_c12ffbbe1095ddec
// Params 1
// Checksum 0x22138771, Offset: 0x1e7
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_c12ffbbe1095ddec
// Params 0
// Checksum 0x499b494d, Offset: 0x215
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_c12ffbbe1095ddec
// Params 1
// Checksum 0x83c85fd8, Offset: 0x239
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace namespace_c12ffbbe1095ddec
// Params 1
// Checksum 0x5f97b6fc, Offset: 0x279
// Size: 0x23
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

