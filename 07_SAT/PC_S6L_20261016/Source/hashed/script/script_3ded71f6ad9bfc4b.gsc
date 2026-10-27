// script_3ded71f6ad9bfc4b  (hash_3ded71f6ad9bfc4b.gscc) (size: 23172 Bytes / 0x5a84 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7516e120 (1964433696)
// size ...... 23172 (0x5a84)
// includes .. 17  (offset: 0x50c8)
// strings ... 115 (offset: 0x5150)
// dev strs .. 8   (offset: 0x5a1c)
// exports ... 65  (offset: 0x37b0)
// cseg ...... 0xd9a + 0x2a16 (0x37b0)
// imports ... 86  (offset: 0x41d8)
// animtree1 . 0   (offset: 0x5a84)
// animtree2 . 0   (offset: 0x5a84)
#using script_636bd827a012af12;
#using script_6b84cb220281a6d3;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_audio;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;
#using scripts\mp\mp_agent;
#using scripts\mp\overlord;

#namespace namespace_937f89a22c5b75f6;

/#

    // Namespace namespace_937f89a22c5b75f6
    // Params 0
    // Checksum 0xe8627aa8, Offset: 0xdb8
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_937f89a22c5b75f6
// Params 0, eflags: 0x5
// Checksum 0xd7620565, Offset: 0xdc5
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d205b23c2fe647c7", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_937f89a22c5b75f6
// Params 0, eflags: 0x4
// Checksum 0xdb9736ae, Offset: 0xdee
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_FREEWAY_INVERTED";
    activity_common::registeractivitytype( "OB_VIRGO_FREEWAY_INVERTED", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_INVERTED", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_INVERTED", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_INVERTED", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x8d478c9f, Offset: 0xe4f
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance freeway_inverted_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x5232b043, Offset: 0xeb4
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance freeway_inverted_main();
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x7555e157, Offset: 0xeee
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

/#

    // Namespace namespace_937f89a22c5b75f6
    // Params 0
    // Checksum 0xafd8deb8, Offset: 0xf12
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x874f9925, Offset: 0xf1f
// Size: 0xa
function freeway_inverted_start()
{
    level thread ob_virgo_util::function_4ec71c3da6905745();
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xebab4380, Offset: 0xf31
// Size: 0x128
function freeway_inverted_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "struct_cache_broken_weaps" );
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "struct_cache_inverted_equip" );
    level thread utility::kill_exploder( "fx_warp_01" );
    level thread ob_virgo_util::function_cc6d564ea2eb6880();
    level.objective_waypoint = "struct_waypoint_inverted_end";
    thread ob_story_mission_utils::function_56960723e6738b6c( "OB_VIRGO_FREEWAY_INVERTED", level.objective_waypoint, undefined, "obj_waypoint_freeway_inverted_done" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_la_inverted", undefined, 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_la_inverted", undefined, 1 );
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_la_sandwich", undefined, 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_la_sandwich", undefined, 1 );
    var_be29e02c9566cc99 = utility::getstruct( "scene_intro_drone", "targetname" );
    var_be29e02c9566cc99 thread ob_virgo_util::function_29164af2d4d89658();
    var_be29e02c9566cc99 thread scene::play();
    level thread virgo_vo::inverted_freeway_vo();
    thread inverted_freeway_beats();
    level thread utility::exploder( "fx_freeway_inverted" );
    level thread utility::exploder( "fx_freeway_broken" );
    ob_virgo_util::setup_ui_widget( "OB_VIRGO_FREEWAY_INVERTED" );
    level utility::flag_wait( "flag_virgo_freeway_inverted_done" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x92931cf2, Offset: 0x1061
// Size: 0x1ac
function inverted_freeway_beats()
{
    activity_instance = self;
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_initial_ambush_front_fallback", "flag_initial_ambush_front_fallback" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_initial_ambush_fallback", "flag_initial_ambush_fallback" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_ambush_reinforcements_fallback", "flag_ambush_reinforcements_fallback" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_sandwich_fallback", "flag_sandwich_fallback" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_sandwich_reinforcements_fallback", "flag_sandwich_reinforcements_fallback" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_flipper_fallback", "flag_flipper_fallback" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_player_inverted_ambush_mid", "flag_player_inverted_ambush_mid" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_spawn_intro_upside_down", "flag_spawn_intro_upside_down" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_spawn_shield", "flag_spawn_shield" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_shield_enemies_fallback", "flag_shield_enemies_fallback" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_sandwich_flipper_01", "flag_sandwich_flipper_01" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_sandwich_flipper_02", "flag_sandwich_flipper_02" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_sandwich_rushers", "flag_sandwich_rushers" );
    level.var_aa9beb68d0bc45f3 = [];
    waitframe();
    level thread virgo_audio::freeway_inverted_combat_walla();
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_spawn_hill_enemies", "flag_spawn_hill_enemies" );
    level utility::flag_wait( "flag_spawn_hill_enemies" );
    overlord::function_e155a19c69aed191( level.players );
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light" );
    activity_instance thread function_f6469e74efd6eb23();
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_player_inverted_freeway", "flag_player_at_inverted_ambush" );
    level utility::flag_wait( "flag_player_at_inverted_ambush" );
    level thread function_45353df1bbcc32d6();
    activity_instance thread function_80d9fb9e499f9a65();
    level thread function_e8ba7e8e03f00c05();
    activity_instance thread function_4593973af730e84b();
    level utility::flag_wait( "flag_player_inverted_ambush_mid" );
    level utility::flag_set( "flag_virgo_freeway_inverted_done" );
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x3d6597da, Offset: 0x1215
// Size: 0x17
function function_69c365cb8d45a9a2()
{
    level utility::flag_wait( "flag_sandwich_flipper_01" );
    level thread ob_virgo_freeway_broken::function_ee4edeb1fbbfbb40();
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x875d7c43, Offset: 0x1234
// Size: 0x295
function function_e8ba7e8e03f00c05()
{
    level utility::flag_wait( "flag_sandwich_rushers" );
    intro_sandwich_bot_grunt = ai_spawn_director::array_spawn_targetname( "intro_sandwich_bot_grunt" );
    
    foreach ( bot in intro_sandwich_bot_grunt )
    {
        bot thread function_96db7946374fa445();
    }
    
    if ( level.players.size >= 3 )
    {
        intro_sandwich_bot_grunt_coop = ai_spawn_director::array_spawn_targetname( "intro_sandwich_bot_grunt_coop" );
        
        foreach ( bot_coop in intro_sandwich_bot_grunt_coop )
        {
            bot_coop thread function_96db7946374fa445();
        }
        
        intro_sandwich_bot_advanced_coop = ai_spawn_director::array_spawn_targetname( "intro_sandwich_bot_advanced_coop" );
        
        foreach ( bot_advanced_coop in intro_sandwich_bot_advanced_coop )
        {
            bot_advanced_coop thread function_96db7946374fa445();
        }
        
        sandwich_intro_gdus_right = utility::getstruct( "sandwich_intro_gdus_right", "targetname" );
        sandwich_intro_gdus_left = utility::getstruct( "sandwich_intro_gdus_left", "targetname" );
        gdu_sandwich_soldier = utility::getstruct( "gdu_sandwich_soldier", "targetname" );
        level utility::flag_set( "flag_spawn_shield_gdus" );
    }
    
    level utility::flag_wait( "flag_shield_enemies_fallback" );
    mid_sandwich_bot_grunt = ai_spawn_director::array_spawn_targetname( "mid_sandwich_bot_grunt" );
    
    foreach ( bot in mid_sandwich_bot_grunt )
    {
        bot thread function_3ad1e61fefb775a6();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x31646dd0, Offset: 0x14d1
// Size: 0x77
function function_3ad1e61fefb775a6()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_flipper_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xae17e5e8, Offset: 0x1550
// Size: 0x179
function function_4593973af730e84b()
{
    level utility::flag_wait( "flag_sandwich_fallback" );
    end_sandwich_bot_grunt = ai_spawn_director::array_spawn_targetname( "end_sandwich_bot_grunt" );
    
    foreach ( bot_grunt in end_sandwich_bot_grunt )
    {
        bot_grunt thread function_a210a8a13c1ab23a();
    }
    
    if ( level.players.size >= 3 )
    {
        end_sandwich_bot_advanced = ai_spawn_director::array_spawn_targetname( "end_sandwich_bot_advanced" );
        
        foreach ( bot_advanced in end_sandwich_bot_advanced )
        {
            bot_advanced thread function_a210a8a13c1ab23a();
        }
        
        end_sandwich_gdus_right = utility::getstruct( "end_sandwich_gdus_right", "targetname" );
        end_sandwich_gdus_left = utility::getstruct( "end_sandwich_gdus_left", "targetname" );
        gdu_sandwich_soldier = utility::getstruct( "gdu_sandwich_soldier", "targetname" );
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xc4928ed7, Offset: 0x16d1
// Size: 0x47
function function_a210a8a13c1ab23a()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xe520b8f1, Offset: 0x1720
// Size: 0x12b
function sandwich_rushers()
{
    level utility::flag_wait( "flag_sandwich_rushers" );
    sandwich_intro_rusher = ai_spawn_director::array_spawn_targetname( "sandwich_intro_rusher" );
    
    foreach ( rusher in sandwich_intro_rusher )
    {
        rusher thread function_f72a3edc1122b048();
    }
    
    if ( level.players.size >= 3 )
    {
        sandwich_intro_shield_coop = ai_spawn_director::array_spawn_targetname( "sandwich_intro_shield_coop" );
        
        foreach ( shield_enemy in sandwich_intro_shield_coop )
        {
            shield_enemy thread function_96db7946374fa445();
        }
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xb00aecaa, Offset: 0x1853
// Size: 0x47
function function_f72a3edc1122b048()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xc40a823c, Offset: 0x18a2
// Size: 0x88
function shield_enemy_spawn_func()
{
    self endon( #"death" );
    var_a9439a1368ba08a8 = getnode( self.target, "targetname" );
    self setgoalnode( var_a9439a1368ba08a8 );
    level utility::flag_wait( "flag_shield_enemies_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_sandwich_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xbf8008ac, Offset: 0x1932
// Size: 0x10f
function function_824bfd3930112559()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_player_at_inverted_ambush" );
    vols = getnoentvolumearray( "vol_hill_guys_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_initial_ambush_front_fallback" );
    vols = getnoentvolumearray( "vol_initial_ambush_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_initial_ambush_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_ambush_reinforcements_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_sandwich_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x570a7bda, Offset: 0x1a49
// Size: 0x156
function function_86bd4e28870ba0c()
{
    self endon( #"death" );
    level.var_aa9beb68d0bc45f3[ level.var_aa9beb68d0bc45f3.size ] = self;
    
    if ( isdefined( self.target ) )
    {
        var_a9439a1368ba08a8 = getnode( self.target, "targetname" );
        self setgoalnode( var_a9439a1368ba08a8 );
    }
    
    level utility::flag_wait( "flag_player_at_inverted_ambush" );
    vols = getnoentvolumearray( "vol_hill_guys_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_initial_ambush_front_fallback" );
    vols = getnoentvolumearray( "vol_initial_ambush_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_initial_ambush_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_ambush_reinforcements_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_sandwich_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x990f2a7, Offset: 0x1ba7
// Size: 0x47
function intro_hill_rusher_spawn_func()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x9d9a9887, Offset: 0x1bf6
// Size: 0x23b
function function_f6469e74efd6eb23()
{
    activity_instance = self;
    intro_hill_rusher = ai_spawn_director::array_spawn_targetname( "intro_hill_rusher" );
    
    foreach ( intro_hill_rusher in intro_hill_rusher )
    {
        intro_hill_rusher thread intro_hill_rusher_spawn_func();
    }
    
    if ( level.players.size >= 3 )
    {
        intro_hill_rusher_coop = ai_spawn_director::array_spawn_targetname( "intro_hill_rusher_coop" );
        
        foreach ( intro_hill_rusher in intro_hill_rusher_coop )
        {
            intro_hill_rusher thread intro_hill_rusher_spawn_func();
        }
    }
    
    wait 1;
    inverted_intro_hill_shooters = ai_spawn_director::array_spawn_targetname( "inverted_intro_hill_shooters" );
    
    foreach ( var_3d8d6768971a4721 in inverted_intro_hill_shooters )
    {
        var_3d8d6768971a4721 thread function_824bfd3930112559();
    }
    
    if ( level.players.size >= 3 )
    {
        inverted_intro_hill_shooters_coop = ai_spawn_director::array_spawn_targetname( "inverted_intro_hill_shooters_coop" );
        
        foreach ( var_3d8d6768971a4721 in inverted_intro_hill_shooters_coop )
        {
            var_3d8d6768971a4721 thread function_824bfd3930112559();
        }
    }
    
    level utility::flag_set( "intro_player_reached_inverted" );
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0xae8b9a8e, Offset: 0x1e39
// Size: 0x2b
function function_173c4fd4f2c53681( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_intro_hill_enemies_spawned" );
}

// Namespace namespace_937f89a22c5b75f6
// Params 4
// Checksum 0x4aee7cf7, Offset: 0x1e6c
// Size: 0x113
function function_edbf7625c0130d48( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level utility::flag_wait( "flag_initial_ambush_front_fallback" );
    vols = getnoentvolumearray( "vol_initial_ambush_fallback", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_initial_ambush_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_ambush_reinforcements_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_sandwich_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0x53c3956, Offset: 0x1f87
// Size: 0x2e
function function_ff541ca22576a638( requestid, userdata, shutdowndata )
{
    ai_spawn_director::cancel_spawn_request( level.var_b49fa041d81a7f5c );
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x8c6bdc48, Offset: 0x1fbd
// Size: 0x1a5
function function_80d9fb9e499f9a65()
{
    activity_instance = self;
    level thread function_e84589d000cc9f55();
    inverted_intro_mid = ai_spawn_director::array_spawn_targetname( "inverted_intro_mid" );
    
    foreach ( var_8ed150177c7f191 in inverted_intro_mid )
    {
        var_8ed150177c7f191 thread function_870906d6144e4fe9();
    }
    
    if ( level.players.size >= 3 )
    {
        inverted_intro_mid_coop = ai_spawn_director::array_spawn_targetname( "inverted_intro_mid_coop" );
        
        foreach ( var_8ed150177c7f191 in inverted_intro_mid_coop )
        {
            var_8ed150177c7f191 thread function_af9a81716db3f71d();
        }
    }
    
    level.ai_e_initial_inverted_ambush = activity_ai_encounters::function_92b671064b0b1ce2( "ai_e_initial_inverted_ambush", 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.ai_e_initial_inverted_ambush, 1 );
    activity_instance activity_ai_encounters::function_6bf4ff2fbde584ee( level.ai_e_initial_inverted_ambush, &function_25868bd81ab0210b, activity_instance );
    ai_spawn_director::add_spawned_callback( level.ai_e_initial_inverted_ambush, &function_b9ad6cccb327b8c9 );
    ai_spawn_director::function_a49c35b72d6b6fea( level.ai_e_initial_inverted_ambush, &inverted_ai_encounter_shutdown );
    level utility::flag_wait( "flag_initial_inverted_ambush_spawned" );
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xc96ec5df, Offset: 0x216a
// Size: 0x9d
function function_96db7946374fa445()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_ambush_reinforcements_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_sandwich_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x966f30a2, Offset: 0x220f
// Size: 0xd9
function function_870906d6144e4fe9()
{
    self endon( #"death" );
    level.var_aa9beb68d0bc45f3[ level.var_aa9beb68d0bc45f3.size ] = self;
    level utility::flag_wait( "flag_initial_ambush_front_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_ambush_reinforcements_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_sandwich_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x5536bfd3, Offset: 0x22f0
// Size: 0xb3
function function_af9a81716db3f71d()
{
    self endon( #"death" );
    level.var_aa9beb68d0bc45f3[ level.var_aa9beb68d0bc45f3.size ] = self;
    level utility::flag_wait( "flag_shield_enemies_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_sandwich_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x53946322, Offset: 0x23ab
// Size: 0x12d
function function_e84589d000cc9f55()
{
    level utility::flag_wait( "flag_spawn_intro_upside_down" );
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light" );
    scene_inverted_freeway_flip = utility::getstruct( "scene_inverted_freeway_flip", "targetname" );
    gdu_sandwich_03 = utility::getstruct( "gdu_sandwich_03", "targetname" );
    var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_cradle_long", gdu_sandwich_03.origin, gdu_sandwich_03.angles, "team_hundred_ninety" );
    var_d937a8ac809622d5 thread function_b37bcd9e188c2e90( scene_inverted_freeway_flip );
    scene_inverted_big_rig_flip = utility::getstruct( "scene_inverted_big_rig_flip", "targetname" );
    var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_cradle_short", gdu_sandwich_03.origin, gdu_sandwich_03.angles, "team_hundred_ninety" );
    var_d937a8ac809622d5 thread function_1c67b1ba4613aa92( scene_inverted_big_rig_flip );
    scene_inverted_freeway_flip_02 = utility::getstruct( "scene_inverted_freeway_flip_02", "targetname" );
    var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_specialist_rusher_cradle_melee", gdu_sandwich_03.origin, gdu_sandwich_03.angles, "team_hundred_ninety" );
    var_d937a8ac809622d5 thread function_e92545b8c7555fc2();
    scene_inverted_freeway_flip_02 thread scene::play( var_d937a8ac809622d5 );
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xabede664, Offset: 0x24e0
// Size: 0x47
function function_e92545b8c7555fc2()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 1
// Checksum 0xe90a4b2c, Offset: 0x252f
// Size: 0x77
function function_1c67b1ba4613aa92( scene_struct )
{
    self endon( #"death" );
    level.var_aa9beb68d0bc45f3[ level.var_aa9beb68d0bc45f3.size ] = self;
    scene_struct scene::play( self );
    self.fixednode = 1;
    self.goalradius = 64;
    var_a9439a1368ba08a8 = getnode( "front_rig_node", "targetname" );
    self setgoalnode( var_a9439a1368ba08a8 );
    thread function_2fb010da63bf2e7e();
}

// Namespace namespace_937f89a22c5b75f6
// Params 1
// Checksum 0x2b5409f5, Offset: 0x25ae
// Size: 0x77
function function_b37bcd9e188c2e90( scene_struct )
{
    self endon( #"death" );
    level.var_aa9beb68d0bc45f3[ level.var_aa9beb68d0bc45f3.size ] = self;
    scene_struct scene::play( self );
    self.fixednode = 1;
    self.goalradius = 64;
    var_a9439a1368ba08a8 = getnode( "node_side_storage_truck", "targetname" );
    self setgoalnode( var_a9439a1368ba08a8 );
    thread function_2fb010da63bf2e7e();
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xce8835e, Offset: 0x262d
// Size: 0xf3
function function_2fb010da63bf2e7e()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_sandwich_rushers" );
    self.fixednode = 0;
    vols = getnoentvolumearray( "vol_initial_ambush_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_initial_ambush_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_ambush_reinforcements_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_sandwich_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xfa9c9e27, Offset: 0x2728
// Size: 0x14e
function function_f3c56aa2f3325de0()
{
    level utility::flag_wait( "flag_initial_ambush_fallback" );
    activity_instance = self;
    level.var_3c5544165183f118 = [];
    waitframe();
    level thread function_b33b29ac4ad0172b();
    level utility::flag_wait( "flag_sandwich_fallback" );
    sandwich_freeway_enemies = ai_spawn_director::array_spawn_targetname( "sandwich_freeway_enemies" );
    
    foreach ( sandwich_enemy in sandwich_freeway_enemies )
    {
        sandwich_enemy thread function_41470e0b3b192a6b();
    }
    
    if ( level.players.size >= 3 )
    {
        sandwich_freeway_enemies_coop = ai_spawn_director::array_spawn_targetname( "sandwich_freeway_enemies_coop" );
        
        foreach ( sandwich_enemy in sandwich_freeway_enemies_coop )
        {
            sandwich_enemy thread function_41470e0b3b192a6b();
        }
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xc89ea77b, Offset: 0x287e
// Size: 0x1b9
function function_b33b29ac4ad0172b()
{
    level utility::flag_wait( "flag_sandwich_flipper_01" );
    gdu_sandwich_soldier = utility::getstruct( "gdu_sandwich_soldier", "targetname" );
    scene_sandwich_flip_to_cover = utility::getstruct( "scene_sandwich_flip_to_cover", "targetname" );
    var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_cradle_sg", gdu_sandwich_soldier.origin, gdu_sandwich_soldier.angles, "team_hundred_ninety" );
    var_d937a8ac809622d5 thread function_eadf985bfa2d4fd1( scene_sandwich_flip_to_cover );
    scene_left_sandwich_flip_to_cover = utility::getstruct( "scene_left_sandwich_flip_to_cover", "targetname" );
    var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_cradle_short", gdu_sandwich_soldier.origin, gdu_sandwich_soldier.angles, "team_hundred_ninety" );
    var_d937a8ac809622d5 thread function_69a19f3e2d599f2c( scene_left_sandwich_flip_to_cover );
    level utility::flag_wait( "flag_sandwich_flipper_02" );
    scene_sandwich_vehicle_jumpoff = utility::getstruct( "scene_sandwich_vehicle_jumpoff", "targetname" );
    var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_cradle_sg", scene_sandwich_vehicle_jumpoff.origin, scene_sandwich_vehicle_jumpoff.angles, "team_hundred_ninety" );
    var_d937a8ac809622d5 thread function_ccf38d9a07b51a87( scene_sandwich_vehicle_jumpoff );
    
    if ( level.players.size >= 3 )
    {
        sandwich_mid_enemies_coop = ai_spawn_director::array_spawn_targetname( "sandwich_mid_enemies_coop" );
        
        foreach ( sandwich_enemy in sandwich_mid_enemies_coop )
        {
            sandwich_enemy thread function_c1f5f4862f0b1b55();
        }
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xce1b444a, Offset: 0x2a3f
// Size: 0x77
function function_c1f5f4862f0b1b55()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_sandwich_reinforcements_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 1
// Checksum 0x18f4281f, Offset: 0x2abe
// Size: 0xc1
function function_eadf985bfa2d4fd1( scene_struct )
{
    self endon( #"death" );
    level.var_3c5544165183f118[ level.var_3c5544165183f118.size ] = self;
    scene_struct thread scene::play( self );
    var_a9439a1368ba08a8 = getnode( "right_flipper_node", "targetname" );
    self setgoalnode( var_a9439a1368ba08a8 );
    level utility::flag_wait( "flag_sandwich_flipper_02" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 1
// Checksum 0x9dd8914d, Offset: 0x2b87
// Size: 0xc1
function function_69a19f3e2d599f2c( scene_struct )
{
    self endon( #"death" );
    level.var_3c5544165183f118[ level.var_3c5544165183f118.size ] = self;
    scene_struct thread scene::play( self );
    var_a9439a1368ba08a8 = getnode( "left_flipper_01_node", "targetname" );
    self setgoalnode( var_a9439a1368ba08a8 );
    level utility::flag_wait( "flag_flipper_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 1
// Checksum 0x38404ea7, Offset: 0x2c50
// Size: 0xc1
function function_ccf38d9a07b51a87( scene_struct )
{
    self endon( #"death" );
    level.var_3c5544165183f118[ level.var_3c5544165183f118.size ] = self;
    scene_struct scene::play( self );
    var_a9439a1368ba08a8 = getnode( "flipper_02_node", "targetname" );
    self setgoalnode( var_a9439a1368ba08a8 );
    level utility::flag_wait( "flag_flipper_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0x146c01a, Offset: 0x2d19
// Size: 0x101
function function_44cd75b83ac6ea6e()
{
    self endon( #"death" );
    gdu_sandwich_01 = utility::getstruct( "gdu_sandwich_01", "targetname" );
    gdu_sandwich_02 = utility::getstruct( "gdu_sandwich_02", "targetname" );
    level utility::flag_set( "flag_sandwich_gdu_spawned" );
    thread ob_virgo_util::spawn_gdu( gdu_sandwich_01 );
    
    if ( level.players.size >= 3 )
    {
        waitframe();
        thread ob_virgo_util::spawn_gdu( gdu_sandwich_02 );
    }
    
    level utility::flag_wait( "flag_ambush_reinforcements_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_sandwich_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0xf7eb6a98, Offset: 0x2e22
// Size: 0x123
function function_35c023db370c6168( requestid, activity_instance, agent )
{
    level.var_aa9beb68d0bc45f3 = utility::array_removedead_or_dying( level.var_aa9beb68d0bc45f3 );
    
    if ( level.var_aa9beb68d0bc45f3.size < 3 )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        level utility::flag_set( "flag_initial_ambush_fallback" );
    }
    
    if ( level.var_aa9beb68d0bc45f3.size < 2 )
    {
        /#
            iprintlnbold( "<dev string:x47>" );
        #/
        
        foreach ( agent in level.var_aa9beb68d0bc45f3 )
        {
            closest_player = function_47c86977a18df38b( level.players, agent.origin );
            
            if ( closest_player.sessionstate == "playing" )
            {
                agent setgoalentity( closest_player );
            }
        }
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0x8ce7bfbd, Offset: 0x2f4d
// Size: 0x2b
function function_25868bd81ab0210b( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_initial_inverted_ambush_spawned" );
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0x68f37b93, Offset: 0x2f80
// Size: 0x2b
function function_e327467a9386d1c1( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_inverted_ambush_reinforcements_spawned" );
}

// Namespace namespace_937f89a22c5b75f6
// Params 4
// Checksum 0x2a21315e, Offset: 0x2fb3
// Size: 0x12f
function function_b9ad6cccb327b8c9( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_aa9beb68d0bc45f3[ level.var_aa9beb68d0bc45f3.size ] = agent;
    level utility::flag_wait( "flag_initial_ambush_front_fallback" );
    vols = getnoentvolumearray( "vol_initial_ambush_fallback", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_initial_ambush_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_ambush_reinforcements_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_sandwich_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( agent ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], agent.origin );
        agent agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0xf432ed9b, Offset: 0x30ea
// Size: 0x48
function inverted_ai_encounter_shutdown( requestid, userdata, shutdowndata )
{
    level utility::flag_set( "inverted_ambush_cleared" );
    level utility::flag_set( "flag_spawn_intro_upside_down" );
    ai_spawn_director::cancel_spawn_request( level.ai_e_initial_inverted_ambush );
}

// Namespace namespace_937f89a22c5b75f6
// Params 4
// Checksum 0xa1f33af8, Offset: 0x313a
// Size: 0xa3
function function_b2421cfc9a464b0( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_195f7abf215627c1[ level.var_195f7abf215627c1.size ] = agent;
    level utility::flag_wait( "flag_ambush_reinforcements_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_front_fallback", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_sandwich_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0xc494a484, Offset: 0x31e5
// Size: 0x48
function function_d6e78eac26d6af1a( requestid, userdata, shutdowndata )
{
    /#
        iprintln( "<dev string:x6c>" );
    #/
    
    level utility::flag_set( "inverted_ambush_reinforcements_cleared" );
    ai_spawn_director::cancel_spawn_request( level.var_da68cf0591089b8 );
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xbced6157, Offset: 0x3235
// Size: 0x5d
function function_41470e0b3b192a6b()
{
    self endon( #"death" );
    level.var_3c5544165183f118[ level.var_3c5544165183f118.size ] = self;
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0xec9cb434, Offset: 0x329a
// Size: 0x48
function function_577a913f2380f51( requestid, userdata, shutdowndata )
{
    /#
        iprintln( "<dev string:x97>" );
    #/
    
    level utility::flag_set( "sandwich_freeway_cleared" );
    ai_spawn_director::cancel_spawn_request( level.var_bf7ff7867d10b9ce );
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0x3fc5134b, Offset: 0x32ea
// Size: 0x60
function function_577176c3edbf9f3a( requestid, activity_instance, agent )
{
    level.var_3c5544165183f118 = utility::array_removedead_or_dying( level.var_3c5544165183f118 );
    
    if ( level.var_3c5544165183f118.size < 2 )
    {
        /#
            iprintlnbold( "<dev string:xb4>" );
        #/
        
        level utility::flag_set( "flag_sandwich_freeway_fallback" );
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0x1406ec37, Offset: 0x3352
// Size: 0x2b
function function_72937d77272d9b11( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_sandwich_freeway_spawned" );
}

// Namespace namespace_937f89a22c5b75f6
// Params 4
// Checksum 0x530f61fd, Offset: 0x3385
// Size: 0xb5
function function_8d42747199c0913c( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_bb0235421fe8a535[ level.var_bb0235421fe8a535.size ] = agent;
    level utility::flag_wait( "flag_sandwich_reinforcements_fallback" );
    vols = getnoentvolumearray( "vol_sandwich_fallback", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0xdaae2f4f, Offset: 0x3442
// Size: 0x48
function function_d8f842d6b56f8cc6( requestid, userdata, shutdowndata )
{
    /#
        iprintln( "<dev string:x97>" );
    #/
    
    level utility::flag_set( "sandwich_freeway_cleared" );
    ai_spawn_director::cancel_spawn_request( level.var_bf7ff7867d10b9ce );
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0x85b1a7f, Offset: 0x3492
// Size: 0x60
function function_612c190a7956be8f( requestid, activity_instance, agent )
{
    level.var_bb0235421fe8a535 = utility::array_removedead_or_dying( level.var_bb0235421fe8a535 );
    
    if ( level.var_bb0235421fe8a535.size < 2 )
    {
        /#
            iprintlnbold( "<dev string:xd3>" );
        #/
        
        level utility::flag_set( "flag_sandwich_reinforcements_fallback" );
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0xcafb4f82, Offset: 0x34fa
// Size: 0x2b
function function_562ec78092b926e8( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_sandwich_reinforcements_spawned" );
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0x5506ae48, Offset: 0x352d
// Size: 0x60
function function_e580b9052da85295( requestid, activity_instance, agent )
{
    level.var_195f7abf215627c1 = utility::array_removedead_or_dying( level.var_195f7abf215627c1 );
    
    if ( level.var_195f7abf215627c1.size < 1 )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        level utility::flag_set( "flag_initial_ambush_reinforcements_fallback" );
    }
}

// Namespace namespace_937f89a22c5b75f6
// Params 4
// Checksum 0x5c65421a, Offset: 0x3595
// Size: 0x4b
function function_fe81417cbc5cfa43( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_52292e9ad96caf40[ level.var_52292e9ad96caf40.size ] = agent;
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0x64de6f76, Offset: 0x35e8
// Size: 0x2b
function function_33c79bdbcd3b6703( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_parkour_wall_encounter_spawned" );
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0xf2c4b642, Offset: 0x361b
// Size: 0x2b
function function_5435107f5ae900df( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_parkour_wall_reinforcements_spawned" );
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0x863a2166, Offset: 0x364e
// Size: 0x55
function function_64f99afdab7aff39( requestid, userdata, shutdowndata )
{
    /#
        iprintln( "<dev string:xf9>" );
    #/
    
    level utility::flag_set( "parkour_wall_encounter_cleared" );
    level utility::flag_set( "flag_spawn_parkour_reinforcements" );
    ai_spawn_director::cancel_spawn_request( level.var_a0c14ec871a54030 );
}

// Namespace namespace_937f89a22c5b75f6
// Params 4
// Checksum 0xea84373d, Offset: 0x36ab
// Size: 0x86
function function_c2e83d8efd6522bb( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_282a56f35610b2aa[ level.var_282a56f35610b2aa.size ] = agent;
    level utility::flag_wait( "flag_spawn_parkour_reinforcements" );
    parkour_back_area = utility::getstruct( "parkour_back_area", "targetname" );
    agent setgoalpos( parkour_back_area.origin );
}

// Namespace namespace_937f89a22c5b75f6
// Params 3
// Checksum 0x778f0718, Offset: 0x3739
// Size: 0x48
function function_8dfbc693a0e8ce7f( requestid, userdata, shutdowndata )
{
    /#
        iprintln( "<dev string:x11a>" );
    #/
    
    level utility::flag_set( "parkour_wall_reinforcements_cleared" );
    ai_spawn_director::cancel_spawn_request( level.var_3b8c6ac16b9f7b21 );
}

// Namespace namespace_937f89a22c5b75f6
// Params 0
// Checksum 0xa5570c8f, Offset: 0x3789
// Size: 0x27
function function_45353df1bbcc32d6()
{
    scene_inverted_jet_flyby = utility::getstruct( "scene_inverted_jet_flyby", "targetname" );
    scene_inverted_jet_flyby thread scene::play();
}

