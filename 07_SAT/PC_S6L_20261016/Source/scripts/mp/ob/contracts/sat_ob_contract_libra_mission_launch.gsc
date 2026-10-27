// scripts\mp\ob\contracts\sat_ob_contract_libra_mission_launch.gsc  (hash_62962b932bc9e725.gscc) (size: 3811 Bytes / 0xee3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xca0b038 (211857464)
// size ...... 3811 (0xee3)
// includes .. 12  (offset: 0xdef)
// strings ... 10  (offset: 0xe4f)
// dev strs .. 0   (offset: 0xee3)
// exports ... 16  (offset: 0x763)
// cseg ...... 0x138 + 0x62b (0x763)
// imports ... 36  (offset: 0x9e3)
// animtree1 . 0   (offset: 0xee3)
// animtree2 . 0   (offset: 0xee3)
#using script_3edd59d0d3fc3262;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_exfil_trans;
#using scripts\mp\overlord;

#namespace sat_ob_contract_libra_mission_launch;

// Namespace sat_ob_contract_libra_mission_launch
// Params 0, eflags: 0x5
// Checksum 0x5fe72555, Offset: 0x156
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"sat_ob_contract_libra_mission_launch", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 0, eflags: 0x4
// Checksum 0x979bbec4, Offset: 0x17f
// Size: 0x4b
function private function_538033a540e63c70()
{
    ob_settings = ob::get_ob_settings();
    
    if ( !ob_settings.var_49178f6e5c220274 )
    {
        return;
    }
    
    activity_common::registeractivitytype( "REV_OB_LIBRA_MISSION_LAUNCH", &activity_type_init );
    level callback::add( #"player_connect", &on_player_connect );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 1
// Checksum 0x66623a7e, Offset: 0x1d2
// Size: 0xb7
function on_player_connect( params )
{
    self notify( #"hash_869e435621306757" );
    self endon( #"hash_869e435621306757" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::flag_wait( "scriptables_ready" );
    story_contract_util::waittill_active( self, #"libra_launch" );
    
    while ( !isdefined( level.var_27651edb1719de7f ) )
    {
        waitframe();
    }
    
    if ( getdvarint( @"hash_8bd16c6d701b3215", 1 ) )
    {
        utility::ent_flag_wait( "taurus_cradle_vent_ended" );
    }
    
    activity_participation::function_bc67362dace4370c( level.var_27651edb1719de7f, self, "PlayerJoinedInteract" );
    thread function_4a88b972a328643d();
    story_contract_util::waittill_not_active( self, #"libra_launch" );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 0
// Checksum 0xa99504e8, Offset: 0x291
// Size: 0x17
function function_4a88b972a328643d()
{
    self waittill( #"hash_1b6b9613636daa6a" );
    thread on_player_connect( {} );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 0
// Checksum 0xc661d997, Offset: 0x2b0
// Size: 0x79
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_LIBRA_MISSION_LAUNCH", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_LIBRA_MISSION_LAUNCH", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_LIBRA_MISSION_LAUNCH", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_LIBRA_MISSION_LAUNCH", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_LIBRA_MISSION_LAUNCH" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_LIBRA_MISSION_LAUNCH" );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 0
// Checksum 0x11766525, Offset: 0x331
// Size: 0xfc
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.var_27651edb1719de7f = activity_instance;
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_91c91f4a631c481d = activityvariantdefinition;
    waitframe();
    activityjoininteracts = level.activities.var_3a2ba6751c464ab7[ activity_instance.id ] ?? [];
    
    foreach ( joininteract in activityjoininteracts )
    {
        joininteract.var_875dcaee89ecc840 = 1;
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 0
// Checksum 0xe7fd4ca, Offset: 0x435
// Size: 0x137
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( getdvar( @"scr_ob_story_progression_override" ) == "taurus_cradle_vents" )
    {
        level utility::flag_wait( "squad_play_begin" );
        wait 3;
    }
    
    squad = self.playerparticipants;
    party_leader = squad[ 0 ];
    
    foreach ( player in squad )
    {
        if ( player isfireteamleader() )
        {
            party_leader = player;
            break;
        }
    }
    
    playlistid = party_leader function_ba1793aee415985f() ? getdvarint( @"hash_f8641d7a3facd31c", 273 ) : getdvarint( @"hash_f53f011cce6a052", 275 );
    level ob_exfil_trans::exfiltrans( party_leader, playlistid, "sat_libra_load" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 1
// Checksum 0x1b46469b, Offset: 0x574
// Size: 0x3f
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance thread respawn_on_destroyed( "REV_OB_LIBRA_MISSION_LAUNCH", activity_instance.varianttag );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 0
// Checksum 0x284efd30, Offset: 0x5bb
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 2
// Checksum 0x4f3ee6c9, Offset: 0x5df
// Size: 0x70
function respawn_on_destroyed( activity, variant )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_info = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ activity_instance.varianttag ];
    activity_instance waittill( #"instance_destroyed" );
    level ob_activity_manager::ob_activity_instance_init( activity_info, undefined );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 0
// Checksum 0x9433c04d, Offset: 0x657
// Size: 0xf
function get_activity_center_point()
{
    return ( 0, 0, 0 );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 1
// Checksum 0xc89cc8a0, Offset: 0x66f
// Size: 0x4e
function function_470b4f0cecef4cf4( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 1
// Checksum 0xe21deba5, Offset: 0x6c5
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 1
// Checksum 0x3e420281, Offset: 0x705
// Size: 0x23
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace sat_ob_contract_libra_mission_launch
// Params 1
// Checksum 0xd492d067, Offset: 0x730
// Size: 0x33
function libra_mission_launch_intro_vo( squad )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level thread overlord::playconversation( "libra_mission_launch_intro", squad );
}

