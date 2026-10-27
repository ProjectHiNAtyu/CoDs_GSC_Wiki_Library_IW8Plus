// script_141bfaec85682a58  (hash_141bfaec85682a58.gscc) (size: 6468 Bytes / 0x1944 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x531f4b0 (87159984)
// size ...... 6468 (0x1944)
// includes .. 11  (offset: 0x1704)
// strings ... 35  (offset: 0x175c)
// dev strs .. 0   (offset: 0x1944)
// exports ... 23  (offset: 0xd44)
// cseg ...... 0x3cd + 0x977 (0xd44)
// imports ... 54  (offset: 0x10dc)
// animtree1 . 0   (offset: 0x1944)
// animtree2 . 0   (offset: 0x1944)
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\hints;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_c6771d95cd4ff4de;

/#

    // Namespace namespace_c6771d95cd4ff4de
    // Params 0
    // Checksum 0x976fb80, Offset: 0x3eb
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_c6771d95cd4ff4de
// Params 0, eflags: 0x5
// Checksum 0x600ce9db, Offset: 0x3f8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_fb46870598a7e13f", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0, eflags: 0x4
// Checksum 0xda22ec92, Offset: 0x421
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_JUNGLE_INTRO";
    activity_common::registeractivitytype( "OB_LEO_JUNGLE_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_INTRO", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_JUNGLE_INTRO" );
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0xeb5936fe, Offset: 0x498
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance jungle_intro_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0xd826f125, Offset: 0x4fd
// Size: 0x3c
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.request_ids = [];
    activity_instance thread jungle_intro_main();
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0x9441607f, Offset: 0x541
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_c6771d95cd4ff4de
// Params 1
// Checksum 0x1c822022, Offset: 0x565
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

/#

    // Namespace namespace_c6771d95cd4ff4de
    // Params 0
    // Checksum 0x4ecc5f90, Offset: 0x621
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_c6771d95cd4ff4de
// Params 1
// Checksum 0x2d03a256, Offset: 0x62e
// Size: 0x19
function player_setup( player )
{
    activity_instance = self;
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0x8a172ba4, Offset: 0x64f
// Size: 0x2
function jungle_intro_start()
{
    
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0x70bf08e1, Offset: 0x659
// Size: 0x12e
function jungle_intro_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_jungle_intro_weapon", "jungle_mansion_complete", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_jungle_intro_equipment", "jungle_mansion_complete", 1 );
    utility::exploder( "leo_nic_rocks_falling" );
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 3, undefined, level.players, undefined, undefined, 1 );
    level thread mp_sat_ob_leo_util::function_46c7dd890b4e2bbb();
    level thread mp_sat_ob_leo_util::function_3c8a17513e90ef86();
    thread mp_sat_ob_leo_vo::function_5bd091dd6159ca17();
    
    foreach ( player in level.players )
    {
        player thread function_e6b075450cd7819d();
    }
    
    thread jungle_intro_mega_jump();
    thread jungle_intro_objectives();
    thread mp_sat_ob_leo_vo::jungle_menendez_taunt( "jungle_menendez_taunt_1", "jungle_intro_vo_complete" );
    level utility::flag_wait( "flag_jungle_intro_complete" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0x69e072d3, Offset: 0x78f
// Size: 0xb0
function function_e6b075450cd7819d()
{
    tutorial_trigger = getent( "trig_ability_case_tutorial", "targetname" );
    var_816926b4b2d4b31d = [];
    
    while ( true )
    {
        tutorial_trigger waittill( #"trigger", var_b075bf5fecbc413 );
        
        if ( var_816926b4b2d4b31d[ var_b075bf5fecbc413 getentitynumber() ] || isautopilot( var_b075bf5fecbc413 ) )
        {
            continue;
        }
        
        var_816926b4b2d4b31d[ var_b075bf5fecbc413 getentitynumber() ] = 1;
        var_b075bf5fecbc413 utility::callsharedfunc( #"hint", #"add_wait", "ability_crate_hint", undefined, undefined, "hint_close_anim_complete", undefined, undefined, 0, [ "HintDisplay", "DialogueSpeaker", "SkillSelect" ] );
    }
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0x27d467e8, Offset: 0x847
// Size: 0x1c6
function jungle_intro_mega_jump()
{
    struct = utility::getstruct( "jungle_intro_ability_case_struct", "targetname" );
    
    if ( isdefined( struct ) )
    {
        struct.tag_origin = utility::function_1808878d1c511ce8( struct.origin, struct.angles );
        ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_mega_jump", undefined, #"tactical" );
        
        foreach ( player in level.players )
        {
            player thread function_ce54b9e6dbc1a7c2( struct );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player thread ob_story_mission_utils::function_a1cd17816bae5f6();
    }
    
    foreach ( player in level.players )
    {
        player thread mega_jump_hint();
    }
}

// Namespace namespace_c6771d95cd4ff4de
// Params 1
// Checksum 0xdb395087, Offset: 0xa15
// Size: 0x63
function function_ce54b9e6dbc1a7c2( struct )
{
    self endon( #"disconnect" );
    thread hints::function_ccd82ecebe5d387e( struct.tag_origin, "jungle_intro_mega_jump_waypoint", undefined, undefined, undefined, 0, undefined, undefined, "player_used_ability_case" );
    thread function_5f96489e055043eb();
    function_20ce7f5956f0ad56();
    level utility::flag_set( "flag_jungle_intro_player_has_ability" );
    thread ob_story_mission_utils::refill_super_mega_jump();
    thread mega_jump_hint();
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0x6c49060f, Offset: 0xa80
// Size: 0x1b
function function_5f96489e055043eb()
{
    level utility::flag_wait( "flag_jungle_village_combat_start" );
    self notify( #"player_used_ability_case" );
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0x52d74da7, Offset: 0xaa3
// Size: 0x5d
function function_13fe58d8c957fd25()
{
    self endon( #"death_or_disconnect" );
    trig = getent( "jungle_intro_mega_jump_hint_3", "targetname" );
    
    while ( true )
    {
        trig waittill( #"trigger", player );
        
        if ( self == player )
        {
            self notify( #"hash_17468ca0327c5fd5" );
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0xa323c3bd, Offset: 0xb08
// Size: 0x1c
function function_bb456f17c35792c0()
{
    player = self;
    return player utility::ent_flag( "player_equipped_mega_jump" );
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0x8f7c0409, Offset: 0xb2d
// Size: 0x48
function function_20ce7f5956f0ad56()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"equipment_given", ref, slot );
    
    if ( ref == "equip_super_mega_jump" )
    {
        utility::ent_flag_set( "player_equipped_mega_jump" );
    }
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0x3c83cf99, Offset: 0xb7d
// Size: 0xd7
function mega_jump_hint()
{
    self endon( #"death_or_disconnect" );
    player = self;
    wait 4;
    player thread watch_mega_jump();
    player hints::hint_add_simple( "leo_mega_jump_hint", &"sat_ob_story_missions/leo_mega_jump_hint", undefined, &function_44a6562572712d1e );
    trig = getent( "jungle_intro_mega_jump_hint_2", "targetname" );
    
    if ( isdefined( trig ) )
    {
        trig waittill( #"trigger", player );
        player hints::hint_add_simple( "leo_mega_jump_hint_2", &"sat_ob_story_missions/leo_mega_jump_hint_2", 10 );
    }
    
    trig = getent( "jungle_intro_mega_jump_hint_3", "targetname" );
    
    if ( isdefined( trig ) )
    {
        trig waittill( #"trigger", player );
        player notify( #"hash_96796cdf694143ac" );
        player hints::hint_add_simple( "leo_mega_jump_hint_3", &"sat_ob_story_missions/leo_mega_jump_hint_3", 10 );
    }
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0x8fa5bfe0, Offset: 0xc5c
// Size: 0x1c
function function_44a6562572712d1e()
{
    player = self;
    return player utility::ent_flag( "player_used_mega_jump" );
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0x86b8cc16, Offset: 0xc81
// Size: 0x47
function watch_mega_jump()
{
    self endon( #"death_or_disconnect" );
    self notifyonplayercommand( "mega_jump", "+smoke" );
    self waittill( #"mega_jump" );
    utility::ent_flag_set( "player_used_mega_jump" );
    self notifyonplayercommandremove( "mega_jump", "+smoke" );
}

// Namespace namespace_c6771d95cd4ff4de
// Params 0
// Checksum 0xc3dd3759, Offset: 0xcd0
// Size: 0x74
function jungle_intro_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level utility::flag_wait( "jungle_intro_vo_complete" );
    ob_story_mission_utils::objective_text_show( %"hash_4194f104fb0af16c" );
    struct = utility::getstruct( "jungle_intro_obj_marker_end", "targetname" );
    self.var_8029d4363972e15 = ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin, undefined, undefined, "sat_ob_objectivemarker_storymissionmain" );
}

