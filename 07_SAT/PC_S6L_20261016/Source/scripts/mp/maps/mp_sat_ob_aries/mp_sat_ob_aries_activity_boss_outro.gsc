// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_boss_outro.gsc  (hash_3148c59b219b1945.gscc) (size: 2878 Bytes / 0xb3e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d51cd73 (2639383923)
// size ...... 2878 (0xb3e)
// includes .. 11  (offset: 0xa5a)
// strings ... 10  (offset: 0xab2)
// dev strs .. 0   (offset: 0xb3e)
// exports ... 11  (offset: 0x562)
// cseg ...... 0x12e + 0x434 (0x562)
// imports ... 29  (offset: 0x71a)
// animtree1 . 0   (offset: 0xb3e)
// animtree2 . 0   (offset: 0xb3e)
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\hud_util;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_scenes;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;

#namespace mp_sat_ob_aries_activity_boss_outro;

// Namespace mp_sat_ob_aries_activity_boss_outro
// Params 0, eflags: 0x5
// Checksum 0x331e2ec, Offset: 0x14c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_f810dcc5b3452a48", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_boss_outro
// Params 0, eflags: 0x4
// Checksum 0x15402221, Offset: 0x175
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_BOSS_OUTRO";
    activity_common::registeractivitytype( "OB_ARIES_BOSS_OUTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_OUTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_OUTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_OUTRO", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_BOSS_OUTRO" );
}

// Namespace mp_sat_ob_aries_activity_boss_outro
// Params 0
// Checksum 0xd4dc029a, Offset: 0x1ec
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_a3f77fecd579b4f8();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_aries_activity_boss_outro
// Params 0
// Checksum 0xbd857cde, Offset: 0x24d
// Size: 0x62
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    story_contract_util::mark_complete( level.players, #"aries_complete" );
    namespace_b451b5202140ccde::completed( level.players );
    activity_instance function_28aadbb38098c6d1();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_boss_outro
// Params 0
// Checksum 0x5b23aecc, Offset: 0x2b7
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_boss_outro
// Params 1
// Checksum 0xd727c18b, Offset: 0x2db
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread boss_outro_player_setup( player );
    }
}

// Namespace mp_sat_ob_aries_activity_boss_outro
// Params 0
// Checksum 0x322f1143, Offset: 0x397
// Size: 0xf
function function_a3f77fecd579b4f8()
{
    activity_instance = self;
}

// Namespace mp_sat_ob_aries_activity_boss_outro
// Params 0
// Checksum 0x8e5f146e, Offset: 0x3ae
// Size: 0x154
function function_28aadbb38098c6d1()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level childthread aries_boss_phase_outro( activity_instance );
    level utility::flag_set( "flag_aries_boss_outro_start" );
    ob_story_mission_utils::objective_marker_clear_all();
    namespace_d11629872d017c15::play_boss_outro();
    
    if ( ob::nightmare() )
    {
        ob_story_mission_utils::function_f20a9fe6c594f5b3( 0 );
        
        foreach ( player in level.players )
        {
            player thread hud_util::fade_in( 0.5, "black" );
            player utility::callsharedfunc( #"hash_561b73e89e879cb7", #"hash_3fa3c8cca94e4308", "aries" );
        }
        
        level utility::flag_set( "flag_aries_reward" );
        origin = ( -18453, 23433, 2200 );
        angles = ( 0, 90, 0 );
        ob_story_mission_utils::function_e1f7ae6f70c4b0c1( origin, angles, undefined, "OB_ARIES_BOSS_PHASETHREE" );
    }
    
    level utility::flag_set( "flag_aries_boss_outro_end" );
}

// Namespace mp_sat_ob_aries_activity_boss_outro
// Params 1
// Checksum 0x611b4d0c, Offset: 0x50a
// Size: 0x19
function boss_outro_player_setup( player )
{
    activity_instance = self;
}

// Namespace mp_sat_ob_aries_activity_boss_outro
// Params 1
// Checksum 0x524cc6b7, Offset: 0x52b
// Size: 0x37
function aries_boss_phase_outro( activity_instance )
{
    var_7e7dc3f64e33360a = utility::getstructarray( "mars_phasethree_respawn_override", "targetname" );
    
    if ( isdefined( var_7e7dc3f64e33360a ) )
    {
        ob_story_mission_utils::set_revive_spawns( var_7e7dc3f64e33360a );
    }
}

