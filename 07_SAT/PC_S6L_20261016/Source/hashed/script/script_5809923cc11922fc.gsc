// script_5809923cc11922fc  (hash_5809923cc11922fc.gscc) (size: 2857 Bytes / 0xb29 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdfc3e308 (3754156808)
// size ...... 2857 (0xb29)
// includes .. 10  (offset: 0xa39)
// strings ... 11  (offset: 0xa89)
// dev strs .. 0   (offset: 0xb29)
// exports ... 14  (offset: 0x501)
// cseg ...... 0x137 + 0x3ca (0x501)
// imports ... 27  (offset: 0x731)
// animtree1 . 0   (offset: 0xb29)
// animtree2 . 0   (offset: 0xb29)
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\interaction;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\objidpoolmanager;

#namespace namespace_2f9117a1b4b565d6;

// Namespace namespace_2f9117a1b4b565d6
// Params 0, eflags: 0x5
// Checksum 0x5c5a10cf, Offset: 0x155
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3d824de98624158b", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_2f9117a1b4b565d6
// Params 0, eflags: 0x4
// Checksum 0xc802a3da, Offset: 0x17e
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "CONTRACT_ARIES_T1", &activity_type_init );
}

// Namespace namespace_2f9117a1b4b565d6
// Params 0
// Checksum 0x394d5d0, Offset: 0x199
// Size: 0x79
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "CONTRACT_ARIES_T1", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "CONTRACT_ARIES_T1", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "CONTRACT_ARIES_T1", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "CONTRACT_ARIES_T1", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "CONTRACT_ARIES_T1" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "CONTRACT_ARIES_T1" );
}

// Namespace namespace_2f9117a1b4b565d6
// Params 0
// Checksum 0xe3eabaae, Offset: 0x21a
// Size: 0x32
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_2f9117a1b4b565d6
// Params 0
// Checksum 0x91f31804, Offset: 0x254
// Size: 0xeb
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    namespace_b451b5202140ccde::function_855fd697c30b090c( 0 );
    namespace_b451b5202140ccde::function_9025afff14ea9bee( 1 );
    marshall = function_c851f2182f65f23b();
    game_utility::questcircle_create( "Assassination_Br", marshall.origin, 3000 );
    game_utility::questcircle_showtoplayer( level.players[ 0 ] );
    level thread function_bdf6b3d7b1a3d08b( marshall.origin );
    interact_marshall = utility::getstruct( "s_interact_marshall", "targetname" );
    interact = interaction::register_interact( interact_marshall.origin, 300, undefined, undefined, undefined, undefined, undefined, "HINT_BUTTON" );
    interact waittill( #"trigger" );
    interact makeunusable();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_2f9117a1b4b565d6
// Params 1
// Checksum 0x86333f4b, Offset: 0x347
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_2f9117a1b4b565d6
// Params 0
// Checksum 0xedbbf177, Offset: 0x375
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_2f9117a1b4b565d6
// Params 0
// Checksum 0x51c6cc0a, Offset: 0x399
// Size: 0xf
function get_activity_center_point()
{
    return ( 0, 0, 0 );
}

// Namespace namespace_2f9117a1b4b565d6
// Params 1
// Checksum 0xb42f3c6f, Offset: 0x3b1
// Size: 0x4e
function function_470b4f0cecef4cf4( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace namespace_2f9117a1b4b565d6
// Params 1
// Checksum 0x27e8e7e2, Offset: 0x407
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace namespace_2f9117a1b4b565d6
// Params 1
// Checksum 0xfbb70ec6, Offset: 0x447
// Size: 0x23
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace namespace_2f9117a1b4b565d6
// Params 0
// Checksum 0x9190c9ed, Offset: 0x472
// Size: 0x50
function function_c851f2182f65f23b()
{
    spawn_location_marshall = utility::getstruct( "s_spawn_location_marshall", "targetname" );
    marshall = mp_agent::spawnnewagentaitype( "sat_ally_ar", spawn_location_marshall.origin, spawn_location_marshall.angles, "allies" );
    return marshall;
}

// Namespace namespace_2f9117a1b4b565d6
// Params 1
// Checksum 0xa32c316f, Offset: 0x4cb
// Size: 0x36
function function_bdf6b3d7b1a3d08b( objective_position )
{
    self.big_circle_marker = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "jup_ob_objectivemarker_bigbounty_nodistance", 1, 1 );
    objidpoolmanager::update_objective_position( self.big_circle_marker, objective_position );
}

