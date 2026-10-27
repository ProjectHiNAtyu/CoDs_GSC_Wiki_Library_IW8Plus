// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_quest_ee_dance_off.gsc  (hash_4d0b2090578a2de1.gscc) (size: 58774 Bytes / 0xe596 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb5398d65 (3040447845)
// size ...... 58774 (0xe596)
// includes .. 40  (offset: 0xd266)
// strings ... 222 (offset: 0xd3a6)
// dev strs .. 43  (offset: 0xe376)
// exports ... 131 (offset: 0x917a)
// cseg ...... 0x1270 + 0x7f0a (0x917a)
// imports ... 353 (offset: 0xa5f2)
// animtree1 . 0   (offset: 0xe596)
// animtree2 . 0   (offset: 0xe596)
#using script_16ea1b94f0f381b3;
#using script_2693dc72a65ba196;
#using script_61b40095fd0502f0;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\equipment\mini_sentry;
#using scripts\mp\common\equipment\smart_seeker;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\playerhealth;
#using scripts\mp\playerlogic;
#using scripts\mp\weaponmetadata;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_lighting;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_exfil_sat;
#using scripts\mp\zm\systems\zm_interaction;
#using scripts\mp\zm\systems\zm_laststand;
#using scripts\mp\zm\systems\zm_ncfdpedestal;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_script_quest_ee_dance_off;

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x5
// Checksum 0x74702a51, Offset: 0x128e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_ee_dance_off", undefined, undefined, &init );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0
// Checksum 0xa4765ab8, Offset: 0x12af
// Size: 0x296
function init()
{
    level utility::flag_wait_all( "zm_sat_scarab_script_quest_ee_dance_off_cs_completed", "zm_quest_initialized", "scriptables_ready", "doorbuy_init_complete" );
    
    if ( !getdvarint( @"hash_1339f37dad46cdfd", 0 ) || getdvarint( @"hash_d6ae9d18be066ca6", 0 ) )
    {
        return;
    }
    
    level.var_c16e0e8231fe0416 = zm_quest::get_quest( #"scarab_ee_dance_off" );
    zm_quest::register_quest_step( #"scarab_ee_dance_off", #"hash_64bff5ca9ddfd4f1", &function_b77e9d43b4ba0dc8, &function_4995bbc86d4abae7 );
    zm_quest::register_quest_step( #"scarab_ee_dance_off", #"hash_2919d444e87dc652", &function_c015757c31a28f2f, &function_23f22ffe85b3e0d4 );
    zm_quest::register_quest_step( #"scarab_ee_dance_off", #"hash_5dc413b0ff631a71", &function_e5e5b424c7b7f85c, &function_4d28bc2daa04c7fb );
    zm_quest::register_quest_step( #"scarab_ee_dance_off", #"hash_64bff2ca9ddfcfd8", &function_b77ea043b4ba1461, &function_4995bcc86d4abd1a );
    zm_quest::register_quest_step( #"scarab_ee_dance_off", #"hash_4b1c8ad085cdc65f", &function_7a1397363e44f5e2, &function_d3f95f1ff4d4fb95 );
    zm_quest::register_quest_step( #"scarab_ee_dance_off", #"hash_12310c9613a1238c", &function_6341abfa80d6b7c1, &function_afec830c8d223d4a );
    zm_quest::register_quest_step( #"scarab_ee_dance_off", #"hash_64bff3ca9ddfd18b", &function_b77e9f43b4ba122e, &function_4995bdc86d4abf4d );
    zm_quest::register_quest_step( #"scarab_ee_dance_off", #"hash_9c1b0233a16dbd0", &function_1563399845de8911, &function_a30faa93ef009336 );
    zm_quest::register_quest_step( #"scarab_ee_dance_off", #"hash_14d5d32e29734e8f", &function_db6a39549aeac0ae, &function_a1cfed39473116ed );
    level.var_c16e0e8231fe0416.event_banter = [ #"scarab_sesd1_dance_off_t1_reward_collect":{ #bantername:"scarab_sesd1_dance_off_t1_reward_collect" }, #"scarab_sesd1_dance_off_move_fail":{ #bantername:"scarab_sesd1_dance_off_move_fail" }, #"hash_1d993bea77b71b94":{ #bantername:"scarab_sesd1_dance_off_move_busted" } ];
    utility::add_fx( "dance_off_end_fireworks", "vfx_t10_levels_zm_quartz_boat_racing_fireworks_shooting" );
    utility::add_fx( "dance_off_teleport_out", "vfx_sat_firefly_player_teleporting_out" );
    utility::add_fx( "dance_off_teleport_in", "vfx_sat_firefly_player_teleporting_into_seat" );
    level function_8cbee4dfbcd31dbf();
    
    /#
        level function_b4a5f67d7c881632();
    #/
    
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    utility::registersharedfunc( #"scarab_ee_dance_off", #"hash_c2b80a5f77ac7b24", &function_9fc1dcdc7b1e08ef );
    level namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_fe64e2aef57bb6a1", &function_ee4a85043e5fcda6 );
    level thread zm_quest::start_quest( #"scarab_ee_dance_off" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x1744981a, Offset: 0x154d
// Size: 0x15
function private function_b77e9d43b4ba0dc8( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x8969368e, Offset: 0x156a
// Size: 0x2a
function private function_4995bbc86d4abae7( b_skipped, b_save_restored )
{
    if ( b_skipped && !b_save_restored )
    {
        function_1421d14e3a25e774( 2 );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x2bb4dfb9, Offset: 0x159c
// Size: 0x22
function private function_c015757c31a28f2f( b_skipped, b_save_restored )
{
    level waittill( #"hash_e16635ea9eaaf11d" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x12d6beec, Offset: 0x15c6
// Size: 0x15
function private function_23f22ffe85b3e0d4( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x8327177b, Offset: 0x15e3
// Size: 0x22
function private function_e5e5b424c7b7f85c( b_skipped, b_save_restored )
{
    level waittill( #"hash_d874902f82f1882d" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xa602244c, Offset: 0x160d
// Size: 0x15
function private function_4d28bc2daa04c7fb( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x8e4dc9a0, Offset: 0x162a
// Size: 0x15
function private function_b77ea043b4ba1461( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x10606737, Offset: 0x1647
// Size: 0x2a
function private function_4995bcc86d4abd1a( b_skipped, b_save_restored )
{
    if ( b_skipped && !b_save_restored )
    {
        function_1421d14e3a25e774( 1 );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x1a5cc524, Offset: 0x1679
// Size: 0x22
function private function_7a1397363e44f5e2( b_skipped, b_save_restored )
{
    level waittill( #"hash_e16635ea9eaaf11d" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x233ea471, Offset: 0x16a3
// Size: 0x15
function private function_d3f95f1ff4d4fb95( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x3eed7bb5, Offset: 0x16c0
// Size: 0x22
function private function_6341abfa80d6b7c1( b_skipped, b_save_restored )
{
    level waittill( #"hash_d874902f82f1882d" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x1bc84882, Offset: 0x16ea
// Size: 0x15
function private function_afec830c8d223d4a( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xf94af936, Offset: 0x1707
// Size: 0x15
function private function_b77e9f43b4ba122e( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xc3067ba3, Offset: 0x1724
// Size: 0x32
function private function_4995bdc86d4abf4d( b_skipped, b_save_restored )
{
    if ( b_skipped && !b_save_restored )
    {
        function_1006d294898bcf5( 3 );
        level function_5fe1803aa61bb08f();
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xbc2bce90, Offset: 0x175e
// Size: 0x22
function private function_1563399845de8911( b_skipped, b_save_restored )
{
    level waittill( #"hash_e16635ea9eaaf11d" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x8549afc5, Offset: 0x1788
// Size: 0x15
function private function_a30faa93ef009336( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xe37ba230, Offset: 0x17a5
// Size: 0x22
function private function_db6a39549aeac0ae( b_skipped, b_save_restored )
{
    level waittill( #"hash_d874902f82f1882d" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xbffefbed, Offset: 0x17cf
// Size: 0x22
function private function_a1cfed39473116ed( b_skipped, b_save_restored )
{
    level utility::flag_set( "dance_off_ee_complete" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x80d0f9db, Offset: 0x17f9
// Size: 0x2d
function private function_1421d14e3a25e774( var_55328aa3742631a1 )
{
    level utility::flag_wait( "dance_off_asset_init_complete" );
    function_1006d294898bcf5( 3 - var_55328aa3742631a1 );
    level function_5fe1803aa61bb08f();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xa0bcde6f, Offset: 0x182e
// Size: 0x27
function private function_8cbee4dfbcd31dbf()
{
    level function_c76831731830ce06();
    level init_dance_player_data();
    level function_8c42fe8bc73ef5db();
    level utility::flag_set( "dance_off_asset_init_complete" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x7163d606, Offset: 0x185d
// Size: 0xa8
function private function_c76831731830ce06()
{
    s_spawn = utility::getstruct( "pn_lw_cp", "targetname" );
    level.var_c16e0e8231fe0416.cassette_player = spawnscriptable( %"hash_54b5f0a40b02d8bb", s_spawn.origin, s_spawn.angles );
    level.var_c16e0e8231fe0416.cassette_player.interaction = interaction::register_scriptable_interact( level.var_c16e0e8231fe0416.cassette_player, &function_aff6240822d66234, undefined, undefined, &function_b8097414fed97646 );
    level thread function_c27360ce7b9cb3a9();
    level thread function_e5ab0e36553d11dd();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xba890fd0, Offset: 0x190d
// Size: 0x305
function private init_dance_player_data()
{
    level.var_c16e0e8231fe0416.var_f67c824a6fd4b379 = [];
    var_93d5729dc6c57339 = utility::getstructarray( "un_yt_os", "targetname" );
    
    foreach ( s_spawn in var_93d5729dc6c57339 )
    {
        level.var_c16e0e8231fe0416.var_f67c824a6fd4b379[ int( s_spawn.script_noteworthy ) ] = s_spawn;
    }
    
    level.var_c16e0e8231fe0416.var_5fd60e93d1232709 = [];
    reward_player_spawns = utility::getstructarray( "ka_vr_es", "targetname" );
    
    foreach ( s_spawn in reward_player_spawns )
    {
        level.var_c16e0e8231fe0416.var_5fd60e93d1232709[ int( s_spawn.script_noteworthy ) ] = s_spawn;
    }
    
    level.var_c16e0e8231fe0416.var_bcf7d394f5b8e521 = [ "ai_t10_zm_zombie_dance_18" ];
    level.var_c16e0e8231fe0416.var_349c3bb70d047d88 = [ function_f0c989594aa7e2c3( "sat_mp_emote_dance_01_attacker_stand", 0, 4.03 ), function_f0c989594aa7e2c3( "ai_sat_zm_zombie_dance_07", 0, 3 ), function_f0c989594aa7e2c3( "ai_sat_zm_zombie_dance_09", 0, 4.4 ), function_f0c989594aa7e2c3( "ai_sat_zm_zombie_dance_10", 0, 3.8 ), function_f0c989594aa7e2c3( "sat_mp_emote_147_danceteam_01", 4.99, 13.6 ), function_f0c989594aa7e2c3( "sat_mp_emote_149_danceteam_01", 0, 5.08 ), function_f0c989594aa7e2c3( "sat_mp_emote_146_danceteam_01", 0, 5.867 ), function_f0c989594aa7e2c3( "sat_mp_emote_153_danceteam_01", 8.8, 13.367 ), function_f0c989594aa7e2c3( "sat_mp_emote_140_danceteam_01", 0, 4.63 ) ];
    level.var_c16e0e8231fe0416.var_e9abd5f3dc0bec3f = [ function_f0c989594aa7e2c3( "sat_mp_emote_fail_danceteam_01", 0, 1.5 ) ];
    level.var_c16e0e8231fe0416.var_25c425265cb8857f = [ "jlr_patrol_victory_celebrate01", "jlr_patrol_victory_celebrate02", "jlr_patrol_victory_celebrate03", "jlr_patrol_victory_celebrate04" ];
    level.var_c16e0e8231fe0416.var_396cce885f7c3331 = [ "player_green", "player_yellow", "player_cyan", "player_pink" ];
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 3, eflags: 0x4
// Checksum 0x850cc2dd, Offset: 0x1c1a
// Size: 0x5a
function private function_f0c989594aa7e2c3( str_anim_name, start_time, end_time )
{
    anim_data = spawnstruct();
    anim_data.str_anim_name = str_anim_name;
    anim_data.start_time = start_time;
    anim_data.end_time = end_time;
    return anim_data;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xce8ea35, Offset: 0x1c7d
// Size: 0x9a8
function private function_8c42fe8bc73ef5db()
{
    level.var_c16e0e8231fe0416.var_ee01e6f9143437e6 = [ "button_1", "button_2", "button_3", "button_4", "button_5", "button_6" ];
    level.var_c16e0e8231fe0416.str_success = &"hash_2c633a191a40864b";
    level.var_c16e0e8231fe0416.var_279d180fd18b8c93 = &"hash_512a9a38157e54f9";
    level.var_c16e0e8231fe0416.str_fail = &"hash_5992d04495082bbc";
    level.var_c16e0e8231fe0416.var_ebb9236cf47129e8 = &"hash_3c16a98de67529ca";
    level function_e42e8f086da956c0();
    level.var_c16e0e8231fe0416.var_d97b0ebb3bb3492f = [];
    level.var_c16e0e8231fe0416.var_d97b0ebb3bb3492f[ "a_controller_strings_phase_1" ] = [];
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_1", 4, [ "button_1", "button_2", "button_1", "button_4" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_2", 4, [ "button_3", "button_4", "button_2", "button_1" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_3", 4, [ "button_2", "button_1", "button_4", "button_3" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_4", 4, [ "button_4", "button_3", "button_1", "button_2" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_5", 4, [ "button_1", "button_3", "button_2", "button_4" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_6", 4, [ "button_3", "button_1", "button_4", "button_2" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_7", 4, [ "button_2", "button_4", "button_3", "button_1" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_8", 4, [ "button_4", "button_2", "button_1", "button_3" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_9", 4, [ "button_1", "button_1", "button_3", "button_4" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_10", 4, [ "button_2", "button_4", "button_2", "button_1" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_11", 4, [ "button_3", "button_3", "button_1", "button_2" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_12", 4, [ "button_4", "button_2", "button_4", "button_3" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_13", 4, [ "button_1", "button_3", "button_3", "button_2" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_14", 4, [ "button_2", "button_1", "button_2", "button_4" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_15", 4, [ "button_1", "button_4", "button_2", "button_3" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_16", 4, [ "button_4", "button_1", "button_2", "button_3" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_17", 4, [ "button_4", "button_1", "button_3", "button_2" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_18", 4, [ "button_2", "button_4", "button_1", "button_3" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_19", 4, [ "button_1", "button_2", "button_3", "button_4" ] );
    level setup_input_string_array( "a_controller_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_20", 4, [ "button_3", "button_4", "button_1", "button_2" ] );
    level.var_c16e0e8231fe0416.var_d97b0ebb3bb3492f[ "a_kbm_strings_phase_1" ] = [];
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_1", 5, [ "button_1", "button_5", "button_3", "button_4", "button_2" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_2", 5, [ "button_3", "button_2", "button_6", "button_1", "button_4" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_3", 5, [ "button_5", "button_4", "button_1", "button_2", "button_6" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_4", 5, [ "button_6", "button_4", "button_1", "button_2", "button_3" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_5", 5, [ "button_4", "button_1", "button_5", "button_3", "button_6" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_6", 5, [ "button_6", "button_3", "button_2", "button_4", "button_5" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_7", 5, [ "button_1", "button_4", "button_6", "button_5", "button_3" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_8", 5, [ "button_5", "button_2", "button_3", "button_6", "button_4" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_9", 5, [ "button_3", "button_6", "button_1", "button_2", "button_5" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_10", 5, [ "button_4", "button_5", "button_2", "button_1", "button_3" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_11", 5, [ "button_2", "button_3", "button_6", "button_5", "button_4" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_12", 5, [ "button_6", "button_1", "button_3", "button_5", "button_2" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_13", 5, [ "button_4", "button_2", "button_6", "button_3", "button_5" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_14", 5, [ "button_1", "button_6", "button_5", "button_2", "button_4" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_15", 5, [ "button_5", "button_2", "button_4", "button_6", "button_1" ] );
    level setup_input_string_array( "a_kbm_strings_phase_1", "ZM_SAT_SCARAB_EE/D_O_SEQ_K5_16", 5, [ "button_5", "button_3", "button_1", "button_4", "button_2" ] );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x87f5c68, Offset: 0x262d
// Size: 0x11a3
function private function_e42e8f086da956c0()
{
    var_69177fd80add24d0 = [];
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_5992d04495082bbc";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3c16a98de67529ca";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2c633a191a40864b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_512a9a38157e54f9";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_1";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1281ec0484021717";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1281ed04840218ca";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1281ee0484021a7d";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1281e70484020e98";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1e2f3ccc97b57848";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_22b92009b09dc14";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_483939d9dc3889e5";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4a4d7c6a9a91126";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_273b9e1cfb6ee66f";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_2";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1aaa8104887cc706";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1aaa8004887cc553";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1aaa7f04887cc3a0";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1aaa8604887ccf85";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_18c296b940d4b909";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4f84a36282786c01";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_6fdd033220c59440";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_30ac89706e1cc427";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_b6bc7453735375e";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_3";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_21f93a048c3e1061";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_21f937048c3e0b48";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_21f938048c3e0cfb";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_21f93d048c3e157a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_16e9f292588ce9ca";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_5ea16bce6a617c1a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_6b39b1dd094260ff";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_14442fc93b3bdbd8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_34728fad020b84f5";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_4";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2cae4f0492e31f10";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2cae520492e32429";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2cae510492e32276";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2cae540492e3278f";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_293ab2c246aa843b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_6347c5787dfc1cf7";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_6afa3f6e2a189112";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_5c1d9b3e3eea8c91";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_282fb95b7fdfef9c";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_5";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3323880495eb9e2b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3323890495eb9fde";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_33238a0495eba191";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_33238b0495eba344";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7d9a6c849652f354";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1e20a55677af70a8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1b5dfb1805f068e9";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_14315f4753652aaa";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7ef5171c20e4601b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_6";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3dd83d049c9009ba";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3dd83c049c900807";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3dd83b049c900654";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3dd83a049c9004a1";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_14d91caf253f8725";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_74322ae51165e935";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_59d800f77cc75524";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_5d827cc82c56b94b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1e60070679ba2d5a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_7";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4600d604a10ac075";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4600d304a10abb5c";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4600d404a10abd0f";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4600d104a10ab7f6";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7e24baa0dd902f66";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3f44affa38cf8aee";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3eb9860887076ca3";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_235d2a3389959d1c";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_574b0c1648a03a11";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_43247b0456a84714";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_43247e0456a84c2d";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_43247d0456a84a7a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4324780456a841fb";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_5c0480da73173d07";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_47374038f3b1c70b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_713d8a2f8d78c6b6";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_5fd3e5ffa01f89f5";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3fa5861bd94fe0d8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_9";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4b4d14045b22fdcf";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4b4d15045b22ff82";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4b4d16045b230135";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4b4d0f045b22f550";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1bf0fec743817ea0";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3bdfe553033111dc";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7c99b5827a1c870d";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4f0d736fe54467ae";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4a17f16b166d1e37";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_10";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1c76b8abd507b371";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1c76b5abd507ae58";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1c76b6abd507b00b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1c76bbabd507b88a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7a3ae2793b9090ba";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_6b79a7ff4d34a04a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4dbe2e09035f562f";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_72bef2398c5d2ec8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_6968d21c19e73da5";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_11";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1527ffabd1466a16";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1527feabd1466863";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1527fdabd14666b0";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_152804abd1467295";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7a5606a3d11e2939";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_5ee9df936776c871";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_538ec1775933d6f0";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_68be05a28baa1057";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_437d837754c2f04e";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_12";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_a736aabcaa234e7";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_a736babcaa2369a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_a736cabcaa2384d";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_a7365abcaa22c68";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2fdda6740c6af078";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_77003b2822d015c4";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_eb06940d24cf255";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2207051a8704c216";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1b408740d3c3b1df";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_13";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3fdb1abc798dc4c";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3fdb4abc798e165";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3fdb3abc798dfb2";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3fdaeabc798d733";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_42a2cb2f551711f";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_64b5e60b8167c6f3";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_f9510021be680fe";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_e079429014af0dd";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_6eb254453b336ee0";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_14";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_407e54abe9d46385";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_407e51abe9d45e6c";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_407e52abe9d4601f";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_407e4fabe9d45b06";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_6175aa87c093d656";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_71adf2694e800b5e";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7659c44c8404dcd3";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_339b66646f4bea4c";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_35c6ce8699c34001";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_15";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_35c93babe32f4e0a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_35c93aabe32f4c57";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_35c939abe32f4aa4";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_35c938abe32f48f1";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_500c0657d33a9995";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_649642f4239ceb25";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4d5792c994b05754";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_78f7d9074507e83b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_66a718d756ea4dca";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_16";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2f5406abe026d5bb";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2f5407abe026d76e";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2f5408abe026d921";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2f5409abe026dad4";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_366ee0955c5f2a04";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4bd6faf96aaf1598";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1ba352d2f9a5bd59";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4315370384b689da";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_237acc5375315cb";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_17";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_249f4dabd9826360";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_249f50abd9826879";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_249f4fabd98266c6";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_249f52abd9826bdf";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_63945c6af3ed392b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_ab19615e0d91e7";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_62b9d140459e6002";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_796d334e8d4c04c1";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1d57cb3147f1e40c";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_18";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_58a7e0abaf0bc329";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_58a7ddabaf0bbe10";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_58a7deabaf0bbfc3";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_58a7e3abaf0bc842";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1c22accf05162012";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_363e3695dcdea012";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2e8bbca030c22bf7";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_42d77879e64a9d90";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3981785c73d4e2cd";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_19";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4df2c7aba866adae";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4df2c6aba866abfb";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4df2c5aba866aa48";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4df2ccaba866b62d";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_d46089f19e81b91";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_29ff8720b2b37099";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_5f8826f0ee01ead8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_367da904bc086fff";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_11202b04a22ad0b6";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_20";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7ca636b2540a29fa";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7ca635b2540a2847";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7ca634b2540a2694";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7ca633b2540a24e1";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1ba01229885781e5";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_b0729f84a312175";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_70ad000ab5928d64";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_726a84319dc35e8b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_35360619b287189a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_1";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_68b0762b204ff3b4";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_68b0792b204ff8cd";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_68b0782b204ff71a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_68b0732b204fee9b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_68b0722b204fece8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_2";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_202dd2b2e775eb9";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_202da2b2e7759a0";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_202db2b2e775b53";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_202e02b2e7763d2";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_202e12b2e776585";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_3";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_79da442b29fca7fe";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_79da432b29fca64b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_79da422b29fca498";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_79da492b29fcb07d";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_79da482b29fcaeca";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_4";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_132d2b2b3824ec83";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_132d2c2b3824ee36";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_132d2d2b3824efe9";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_132d2e2b3824f19c";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_132d2f2b3824f34f";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_5";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_951922b3238a148";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_951952b3238a661";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_951942b3238a4ae";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_951972b3238a9c7";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_951962b3238a814";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_6";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2530992b428aa16d";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2530962b428a9c54";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2530972b428a9e07";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2530942b428a98ee";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2530952b428a9aa1";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_7";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1a7be02b3be62f12";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1a7bdf2b3be62d5f";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1a7bde2b3be62bac";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1a7bdd2b3be629f9";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1a7bdc2b3be62846";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_34a7e72b4ac69ab7";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_34a7e82b4ac69c6a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_34a7e92b4ac69e1d";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_34a7e22b4ac69238";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_34a7e32b4ac693eb";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_9";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2d592e2b4705515c";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2d59312b47055675";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2d59302b470554c2";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2d592b2b47054c43";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_2d592a2b47054a90";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_10";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_72869945c771fac4";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_72869c45c771ffdd";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_72869b45c771fe2a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_72869645c771f5ab";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_72869545c771f3f8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_11";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_79d53245cb330dbf";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_79d53345cb330f72";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_79d53445cb331125";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_79d52d45cb330540";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_79d52e45cb3306f3";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_12";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3b0e745d11f888e";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3b0e645d11f86db";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3b0e545d11f8528";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3b0ec45d11f910d";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_3b0eb45d11f8f5a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_13";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_aff8045d4e09b89";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_aff7d45d4e09670";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_aff7e45d4e09823";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_aff8345d4e0a0a2";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_aff8445d4e0a255";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_14";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1327b545d95aa858";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1327b845d95aad71";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1327b745d95aabbe";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1327ba45d95ab0d7";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1327b945d95aaf24";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_15";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1ddcce45dfffbdd3";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1ddccf45dfffbf86";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1ddcd045dfffc139";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1ddcd145dfffc2ec";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_1ddcd245dfffc49f";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"ZM_SAT_SCARAB_EE/D_O_SEQ_K5_16";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_252b8345e3c10062";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_252b8245e3c0feaf";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_252b8145e3c0fcfc";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_252b8045e3c0fb49";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_252b7f45e3c0f996";
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 4, eflags: 0x4
// Checksum 0x2e9b0139, Offset: 0x37d8
// Size: 0xc1
function private setup_input_string_array( str_target_pool, string_prefix, n_buttons, var_892a2f4fe7713b0e )
{
    string_array = [];
    string_array[ "key" ] = string_prefix;
    string_array[ "start" ] = function_812fce60dca19e14( string_prefix );
    
    for ( i = 1; i <= n_buttons ; i++ )
    {
        string_array[ "button_" + string( i ) ] = function_812fce60dca19e14( string_prefix + "_" + string( i ) );
    }
    
    string_array[ "solution" ] = var_892a2f4fe7713b0e;
    level.var_c16e0e8231fe0416.var_d97b0ebb3bb3492f[ str_target_pool ][ level.var_c16e0e8231fe0416.var_d97b0ebb3bb3492f[ str_target_pool ].size ] = string_array;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x3d787e61, Offset: 0x38a1
// Size: 0x176
function private function_c27360ce7b9cb3a9()
{
    level zm_save::function_1f44a48caae2acbf();
    cassette_state = zm_quest::function_73720cdf21c3cfd7( #"scarab_ee_dance_off", #"hash_e600ee2bff113151" ) ?? 0;
    level.var_c16e0e8231fe0416.var_3b2fa16edadb4469 = cassette_state == 1;
    level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa = cassette_state == 2;
    level.var_c16e0e8231fe0416.var_b3b947dbda926aaa = zm_quest::function_73720cdf21c3cfd7( #"scarab_ee_dance_off", #"hash_5f40e89f665a90f7" ) ?? 0;
    var_ad5ac2c071d9a5a = zm_quest::function_73720cdf21c3cfd7( #"scarab_ee_dance_off", #"hash_a6687b82227362e4" );
    
    if ( var_ad5ac2c071d9a5a )
    {
        level.var_c16e0e8231fe0416.var_22e025ddc8d3cd4d = var_ad5ac2c071d9a5a;
        
        if ( !callback::exists( "on_round_start", &function_a317fd0770877802 ) )
        {
            level callback::add( "on_round_start", &function_a317fd0770877802 );
        }
    }
    
    if ( level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa )
    {
        level function_de3ade5a7aa29299();
        level.var_c16e0e8231fe0416.cassette_player utility::function_32b24db3127bff40( "body", "on_cassette_inserted" );
        return;
    }
    
    if ( level.var_c16e0e8231fe0416.var_3b2fa16edadb4469 )
    {
        level.var_c16e0e8231fe0416.cassette_player utility::function_32b24db3127bff40( "body", "on" );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x72bea707, Offset: 0x3a1f
// Size: 0xca
function private function_e5ab0e36553d11dd()
{
    level endon( #"dance_off_ee_complete" );
    b_light_on = 0;
    
    while ( true )
    {
        if ( !b_light_on && level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa && function_7ea35bab3ad465d6() )
        {
            level.var_c16e0e8231fe0416.cassette_player utility::function_32b24db3127bff40( "fx", "on" );
            b_light_on = 1;
        }
        else if ( b_light_on && ( !level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa || !function_7ea35bab3ad465d6() ) )
        {
            level.var_c16e0e8231fe0416.cassette_player utility::function_32b24db3127bff40( "fx", "off" );
            b_light_on = 0;
        }
        
        wait 0.3;
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x7e0182f5, Offset: 0x3af1
// Size: 0x8c
function private function_287d35a29e913185()
{
    cassette_state = level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa ? 2 : level.var_c16e0e8231fe0416.var_3b2fa16edadb4469 ? 1 : 0;
    zm_quest::function_4eefe6de31f5ddab( #"scarab_ee_dance_off", #"hash_e600ee2bff113151", cassette_state );
    zm_quest::function_4eefe6de31f5ddab( #"scarab_ee_dance_off", #"hash_5f40e89f665a90f7", level.var_c16e0e8231fe0416.var_b3b947dbda926aaa );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x1970e4f, Offset: 0x3b85
// Size: 0x84
function private function_1006d294898bcf5( tries_completed )
{
    level.var_c16e0e8231fe0416.var_b3b947dbda926aaa = max( level.var_c16e0e8231fe0416.var_b3b947dbda926aaa ?? 0, tries_completed );
    
    if ( level.var_c16e0e8231fe0416.var_b3b947dbda926aaa >= 3 )
    {
        level.var_c16e0e8231fe0416.var_b3b947dbda926aaa = 3;
        level function_cd54559ef6eaa323();
        level function_5fe1803aa61bb08f();
    }
    
    level function_287d35a29e913185();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x37fb7156, Offset: 0x3c11
// Size: 0x47
function private function_e9dcea6b7fb70b4a()
{
    level.var_c16e0e8231fe0416.var_22e025ddc8d3cd4d = 3;
    level function_272d4f99e7ba82d8();
    
    if ( !level callback::exists( "on_round_start", &function_a317fd0770877802 ) )
    {
        level callback::add( "on_round_start", &function_a317fd0770877802 );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x3bd92950, Offset: 0x3c60
// Size: 0x7f
function private function_a317fd0770877802( params )
{
    if ( zm_save::function_1dda3554974a999e() || level.var_dc81f03d76612023 )
    {
        return;
    }
    
    if ( !level.var_c16e0e8231fe0416.var_22e025ddc8d3cd4d )
    {
        level function_cd54559ef6eaa323();
        return;
    }
    
    level.var_c16e0e8231fe0416.var_22e025ddc8d3cd4d--;
    
    if ( !level.var_c16e0e8231fe0416.var_22e025ddc8d3cd4d )
    {
        level function_cd54559ef6eaa323();
        return;
    }
    
    level function_272d4f99e7ba82d8();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x93c8c8ab, Offset: 0x3ce7
// Size: 0x60
function private function_272d4f99e7ba82d8()
{
    if ( level.var_c16e0e8231fe0416.var_22e025ddc8d3cd4d )
    {
        zm_quest::function_4eefe6de31f5ddab( #"scarab_ee_dance_off", #"hash_a6687b82227362e4", level.var_c16e0e8231fe0416.var_22e025ddc8d3cd4d );
        return;
    }
    
    zm_quest::function_6265be8d0549e1b1( #"scarab_ee_dance_off", #"hash_a6687b82227362e4" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x2f5ca3a7, Offset: 0x3d4f
// Size: 0x43
function private function_cd54559ef6eaa323()
{
    if ( level callback::exists( "on_round_start", &function_a317fd0770877802 ) )
    {
        level callback::remove( "on_round_start", &function_a317fd0770877802 );
    }
    
    level.var_c16e0e8231fe0416.var_22e025ddc8d3cd4d = undefined;
    level function_272d4f99e7ba82d8();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x2c7ca8f, Offset: 0x3d9a
// Size: 0x3c
function private function_b1ec8e18f73e07cb()
{
    if ( level.var_c16e0e8231fe0416.cassette_player )
    {
        level.var_c16e0e8231fe0416.cassette_player utility::function_32b24db3127bff40( "body", "off" );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x9ec19380, Offset: 0x3dde
// Size: 0x4c
function private function_5fe1803aa61bb08f()
{
    level.var_c16e0e8231fe0416.var_3b2fa16edadb4469 = 0;
    level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa = 0;
    level function_b1ec8e18f73e07cb();
    level function_1cf78d8d09ab439b();
    level function_4659f86a1519ca5a();
    level function_287d35a29e913185();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x43d3d35b, Offset: 0x3e32
// Size: 0x52
function private function_1cf78d8d09ab439b()
{
    if ( level.var_c16e0e8231fe0416.var_2d8d18ac3d6fe0d )
    {
        level.var_c16e0e8231fe0416.var_2d8d18ac3d6fe0d setscriptablepartstate( "usable", "off" );
        level.var_c16e0e8231fe0416.var_2d8d18ac3d6fe0d freescriptable();
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x1568435f, Offset: 0x3e8c
// Size: 0x30
function private function_4659f86a1519ca5a()
{
    if ( level.var_c16e0e8231fe0416.inserted_cassette )
    {
        level.var_c16e0e8231fe0416.inserted_cassette freescriptable();
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x9d98b58d, Offset: 0x3ec4
// Size: 0x2e
function private function_9fc1dcdc7b1e08ef( v_loot_spawn_loc )
{
    if ( !function_f850db589b09ba92() )
    {
        return;
    }
    
    if ( !utility::percent_chance( 40 ) )
    {
        return;
    }
    
    level function_7c3137969a08af19( v_loot_spawn_loc );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x6dcf1039, Offset: 0x3efa
// Size: 0x97, Type: bool
function private function_f850db589b09ba92()
{
    if ( zm_round_logic::get_rb_round_number() < 2 )
    {
        return false;
    }
    
    if ( level.var_c16e0e8231fe0416.var_b3b947dbda926aaa >= 3 )
    {
        return false;
    }
    
    if ( level.var_c16e0e8231fe0416.var_2d8d18ac3d6fe0d || level.var_c16e0e8231fe0416.var_3b2fa16edadb4469 || level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa )
    {
        return false;
    }
    
    if ( level.var_c16e0e8231fe0416.var_22e025ddc8d3cd4d )
    {
        return false;
    }
    
    if ( !function_7ea35bab3ad465d6() )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0xce47fbe7, Offset: 0x3f9a
// Size: 0xc5
function private function_7c3137969a08af19( v_origin )
{
    if ( level.var_c16e0e8231fe0416.var_2d8d18ac3d6fe0d )
    {
        return;
    }
    
    v_landing_origin = function_93f7c866ccb2194c( v_origin );
    var_a32906daf289db53 = v_origin;
    cassette = function_614a030e7df66e5f( var_a32906daf289db53, v_landing_origin );
    cassette setscriptablepartstate( "usable", "on" );
    cassette.interaction = interaction::register_scriptable_interact( cassette, &function_dace943b77dcb45b, undefined, undefined, &function_d2097eb551b27ac7 );
    cassette.interaction.cassette = cassette;
    level.var_c16e0e8231fe0416.var_2d8d18ac3d6fe0d = cassette;
    cassette utility::delaythread( 30, &function_e205dc0b486ae887 );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x7c3d1d87, Offset: 0x4067
// Size: 0x6e
function private function_93f7c866ccb2194c( v_origin )
{
    v_navmesh_origin = getclosestpointonnavmesh( v_origin );
    v_landing_center = v_navmesh_origin ?? v_origin;
    v_landing_origin = utility::function_7afe366c29a77c34( v_landing_center, 64 );
    v_landing_origin = utility::drop_to_ground( v_landing_origin, 64 );
    
    if ( !v_landing_origin )
    {
        v_landing_origin = v_navmesh_origin;
    }
    
    return ( v_landing_origin ?? v_landing_center ) + ( 0, 0, 3 );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xf44f61e1, Offset: 0x40de
// Size: 0x6e
function private function_614a030e7df66e5f( var_a32906daf289db53, v_landing_origin )
{
    arc_payload = calcscriptablepayloadgravityarc( var_a32906daf289db53, v_landing_origin );
    v_landing_angles = ( -90, vectortoyaw( v_landing_origin - var_a32906daf289db53 ), 0 );
    cassette = spawnscriptable( %"hash_6bfd1905b093d66c", v_landing_origin, v_landing_angles, undefined, arc_payload );
    cassette setscriptablepartstate( "body", "dropped" );
    return cassette;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xba8e4fa6, Offset: 0x4155
// Size: 0xc
function private function_e205dc0b486ae887()
{
    if ( self )
    {
        self freescriptable();
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0xc1d3c3a6, Offset: 0x4169
// Size: 0x63
function private function_dace943b77dcb45b( player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    cassette = self.cassette;
    
    if ( !cassette || cassette != level.var_c16e0e8231fe0416.var_2d8d18ac3d6fe0d )
    {
        return;
    }
    
    level pick_up_cassette( cassette, player );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x90289aae, Offset: 0x41d4
// Size: 0x9d
function private pick_up_cassette( cassette, player )
{
    cassette setscriptablepartstate( "usable", "off" );
    level.var_c16e0e8231fe0416.var_3b2fa16edadb4469 = 1;
    level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa = 0;
    level function_287d35a29e913185();
    level.var_c16e0e8231fe0416.cassette_player utility::function_32b24db3127bff40( "body", "on" );
    playsoundatpos( cassette.origin, #"hash_1fdf51ce0388951b" );
    cassette freescriptable();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x8a3f4c84, Offset: 0x4279
// Size: 0x40
function private function_d2097eb551b27ac7( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"CP_ZMB/TAKE", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x3031708, Offset: 0x42c2
// Size: 0xb0
function private function_de3ade5a7aa29299()
{
    if ( level.var_c16e0e8231fe0416.inserted_cassette )
    {
        return;
    }
    
    s_inserted = utility::getstruct( "xe_nd_ci", "targetname" );
    level.var_c16e0e8231fe0416.inserted_cassette = spawnscriptable( %"hash_6bfd1905b093d66c", s_inserted.origin, s_inserted.angles );
    level.var_c16e0e8231fe0416.inserted_cassette setscriptablepartstate( "usable", "off" );
    level.var_c16e0e8231fe0416.inserted_cassette setscriptablepartstate( "body", "no_outline" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0xa83de04a, Offset: 0x437a
// Size: 0xfe
function private function_aff6240822d66234( player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( level.var_c16e0e8231fe0416.var_3b2fa16edadb4469 && !level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa )
    {
        level.var_c16e0e8231fe0416.var_3b2fa16edadb4469 = 0;
        level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa = 1;
        level function_de3ade5a7aa29299();
        level.var_c16e0e8231fe0416.cassette_player utility::function_32b24db3127bff40( "body", "on_cassette_inserted" );
        level function_287d35a29e913185();
        
        if ( player )
        {
            player playsoundtoplayer( "uin_zm_common_pickup_item_mechanical", player );
        }
        
        return;
    }
    
    if ( !level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa || !function_7ea35bab3ad465d6() )
    {
        return;
    }
    
    player playsoundtoplayer( "uin_zm_common_pickup_item_mechanical", player );
    level function_16a8f5f5c62e57a1( player );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xeef2dbf8, Offset: 0x4480
// Size: 0x8d, Type: bool
function private function_7ea35bab3ad465d6()
{
    if ( level utility::flag( "sh_symbols_maxed" ) && zm_exfil_sat::is_exfil_available() || level utility::flag( "pickle_takes_tomato" ) || level utility::flag( "special_round_is_ongoing" ) )
    {
        return false;
    }
    
    if ( function_773e59e4119520ee() )
    {
        return false;
    }
    
    if ( level utility::flag( "dance_vote_in_progress" ) )
    {
        return false;
    }
    
    if ( level utility::flag( "WW_A_P_IN_USE" ) || level utility::flag( "black_room_in_use" ) )
    {
        return false;
    }
    
    if ( level utility::flag( "scarab_boss_fight_start" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xd5dee399, Offset: 0x4516
// Size: 0x86, Type: bool
function private function_773e59e4119520ee()
{
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "player_sh_etp_done" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x3526c1b0, Offset: 0x45a5
// Size: 0x11d
function private function_16a8f5f5c62e57a1( player )
{
    vote_params = spawnstruct();
    
    if ( level.players.size == 1 && function_7ea35bab3ad465d6() )
    {
        level function_b1ec8e18f73e07cb();
        level thread function_43c7ac28b79593e6( vote_params );
        return;
    }
    
    level utility::flag_set( "dance_vote_in_progress" );
    level function_b1ec8e18f73e07cb();
    vote_params.init_message = &"hash_368ffead421750f5";
    vote_params.description = &"hash_7d672fd3084c98c4";
    b_passed = zm_quest::vote_think( player, vote_params );
    
    if ( b_passed )
    {
        level utility::flag_clear( "dance_vote_in_progress" );
    }
    else
    {
        level utility::delaythread( 15, &utility::flag_clear, "dance_vote_in_progress" );
    }
    
    if ( b_passed && function_7ea35bab3ad465d6() )
    {
        level utility::flag_set( "dance_off_in_progress" );
        function_8d4286b44dd289fa();
        wait 1;
        level thread function_43c7ac28b79593e6( vote_params );
        return;
    }
    
    level.var_c16e0e8231fe0416.cassette_player utility::function_32b24db3127bff40( "body", "on_cassette_inserted" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1
// Checksum 0xf7d5316a, Offset: 0x46ca
// Size: 0x17b
function function_8d4286b44dd289fa( b_set = 1 )
{
    if ( b_set )
    {
        zm_laststand::function_3b2825685e8bfee8();
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || player.sessionstate == "spectator" )
            {
                player.var_14955bc056bab547 = 1;
                player thread playerlogic::spawnclient();
            }
            
            player val::set( "dance_battle_in_progress", "ignoreme", 1 );
            player val::set( "dance_battle_in_progress", "damage", 0 );
            player val::set( "dance_battle_in_progress", "interactions", 0 );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player val::reset_all( "dance_battle_in_progress" );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x8b4440c7, Offset: 0x484d
// Size: 0x36
function private function_b8097414fed97646( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0xacaad55d, Offset: 0x488c
// Size: 0x206
function private function_43c7ac28b79593e6( vote_params )
{
    level function_b1ec8e18f73e07cb();
    level utility::flag_set( "dance_off_in_progress" );
    level zm_quest::function_d7216beb89a22329();
    level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc = level.players;
    level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc = utility::function_8391781ea0784541( level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc );
    
    foreach ( player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        player function_30a523689397cde4();
    }
    
    foreach ( player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        player thread function_17862eff7d82ec0d();
    }
    
    utility::delaythread( 1, &zm_quest::cleanup_zombies_manually, 0, undefined, undefined, undefined, 0, 1, undefined, undefined, undefined, undefined, 1 );
    level function_4b933ec617b86318();
    
    if ( !isdefined( level.var_c16e0e8231fe0416.var_50d7ab1613f28040 ) )
    {
        level.var_c16e0e8231fe0416.var_50d7ab1613f28040 = utility::getstruct( "ti_ro_cc" );
    }
    
    function_e524e3a82390272( level.var_c16e0e8231fe0416.var_50d7ab1613f28040.origin, 500 );
    level zm_sat_scarab_lighting::function_c6baa2dec8445bdb();
    level thread function_d9ca7165fc8f98df();
    level thread function_8f996884c05edda4();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x384a556b, Offset: 0x4a9a
// Size: 0x35
function private function_d9ca7165fc8f98df()
{
    level endon( #"hash_d874902f82f1882d" );
    utility::array_wait( level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc, "death_or_disconnect" );
    level thread function_518b69c4fbca7bc2();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x4c3f013a, Offset: 0x4ad7
// Size: 0x3f5
function private function_8f996884c05edda4()
{
    level endon( #"game_ended" );
    level endon( #"hash_d874902f82f1882d" );
    level.var_c16e0e8231fe0416.var_8a7f4b51ac31ee32 = 3.5;
    level.var_c16e0e8231fe0416.point_multiplier = 1;
    level utility::array_ent_flag_wait( level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc, "dance_battle_ready" );
    
    if ( getdvarint( @"dance_off_time", 0 ) )
    {
        time_left = getdvarint( @"dance_off_time", 0 );
    }
    else
    {
        time_left = 75;
    }
    
    level notify( #"hash_e16635ea9eaaf11d" );
    musicbank_utility::function_5aca66c390aa347d( level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc, #"hash_8967b01d8404a562" );
    level utility::array_ent_flag_wait( level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc, "player_in_dance_off" );
    level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"scarab_ee_dance_off", function_7dffe3174c2f3415() );
    level zm_quest::function_fb3af5600f6a9441( 2, 1, #"scarab_ee_dance_off", function_7dffe3174c2f3415() );
    level zm_quest::function_612a9ad0db22c29c( time_left * 1000, 1, #"scarab_ee_dance_off", function_7dffe3174c2f3415() );
    leaderboard_info = function_19ff48887f420714();
    zm_quest::function_e4996840a6b66669( leaderboard_info );
    zm_quest::function_b507b93ea423985d( 0, level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc );
    
    while ( true )
    {
        level zm_quest::function_612a9ad0db22c29c( time_left * 1000, 1, #"scarab_ee_dance_off", function_7dffe3174c2f3415() );
        
        if ( time_left <= 0 )
        {
            foreach ( player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
            {
                player playsoundtoplayer( #"hash_acea1f2514854612", player );
            }
            
            level thread function_518b69c4fbca7bc2();
            return;
        }
        
        if ( time_left < 5 )
        {
            foreach ( player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
            {
                player playsoundtoplayer( #"hash_809f0a2bb8bbbded", player );
            }
        }
        
        if ( level.var_c16e0e8231fe0416.var_8a7f4b51ac31ee32 != 2.5 && time_left <= 55 && time_left > 15 )
        {
            /#
                iprintlnbold( "<dev string:x24>" );
            #/
            
            level.var_c16e0e8231fe0416.var_8a7f4b51ac31ee32 = 2.5;
        }
        else if ( level.var_c16e0e8231fe0416.var_8a7f4b51ac31ee32 != 1.7 && time_left <= 15 )
        {
            foreach ( player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
            {
                player thread hud_message::showsplash( #"hash_f4a5436738c70bfb" );
            }
            
            level.var_c16e0e8231fe0416.var_8a7f4b51ac31ee32 = 1.7;
            level.var_c16e0e8231fe0416.point_multiplier = 2;
        }
        
        wait 1;
        time_left -= 1;
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x77a9993d, Offset: 0x4ed4
// Size: 0x68
function private function_7dffe3174c2f3415()
{
    switch ( level.var_c16e0e8231fe0416.var_7be076c9078045aa )
    {
        case 0:
            return #"hash_5dc413b0ff631a71";
        case 1:
            return #"hash_12310c9613a1238c";
        case 2:
            return #"hash_14d5d32e29734e8f";
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xf9f748ef, Offset: 0x4f44
// Size: 0x68
function private function_a3cfaa229e8e686d()
{
    switch ( level.var_c16e0e8231fe0416.var_7be076c9078045aa )
    {
        case 0:
            return #"hash_1d68a7fdc04dbb7d";
        case 1:
            return #"hash_dc25268c08bbb38c";
        case 2:
            return #"hash_b9df9b0809d469c3";
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x25b18814, Offset: 0x4fb4
// Size: 0x184
function private function_19ff48887f420714()
{
    level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc = utility::function_8391781ea0784541( level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc );
    var_fb1c3a177ec35cba = level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc;
    
    for ( i = 0; i < var_fb1c3a177ec35cba.size ; i++ )
    {
        for ( j = i + 1; j < var_fb1c3a177ec35cba.size ; j++ )
        {
            if ( var_fb1c3a177ec35cba[ j ].var_e93f6e6310d21657 > var_fb1c3a177ec35cba[ i ].var_e93f6e6310d21657 )
            {
                swap = var_fb1c3a177ec35cba[ j ];
                var_fb1c3a177ec35cba[ j ] = var_fb1c3a177ec35cba[ i ];
                var_fb1c3a177ec35cba[ i ] = swap;
            }
        }
    }
    
    var_c119277103990614 = [];
    
    foreach ( index, player in var_fb1c3a177ec35cba )
    {
        result_info = spawnstruct();
        result_info.rank = index;
        result_info.player = player;
        result_info.score = int( player.var_e93f6e6310d21657 / 10 );
        var_c119277103990614[ var_c119277103990614.size ] = result_info;
    }
    
    return var_c119277103990614;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x7abcb8, Offset: 0x5141
// Size: 0x119
function private function_4b933ec617b86318()
{
    level.var_c16e0e8231fe0416.var_5366117d7fb19440 = [];
    var_5366117d7fb19440 = utility::getstructarray( "oz_ke_pr", "targetname" );
    
    foreach ( s_prop in var_5366117d7fb19440 )
    {
        prop = spawnscriptable( %"hash_6bfd2c05b093f6b5", s_prop.origin, s_prop.angles );
        prop setscriptablepartstate( "body", s_prop.script_noteworthy );
        level.var_c16e0e8231fe0416.var_5366117d7fb19440[ level.var_c16e0e8231fe0416.var_5366117d7fb19440.size ] = prop;
    }
    
    level function_fdd8b58c35a16656();
    level function_f5ca3db02784d092();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xde824537, Offset: 0x5262
// Size: 0x12c
function private function_a28c6e29fc4af07a()
{
    foreach ( prop in level.var_c16e0e8231fe0416.var_5366117d7fb19440 )
    {
        prop freescriptable();
    }
    
    level.var_c16e0e8231fe0416.mister_peeks delete();
    
    foreach ( var_bd2c4ac1948d79c6 in level.var_c16e0e8231fe0416.var_844660002a6c7a01 )
    {
        if ( isalive( var_bd2c4ac1948d79c6 ) )
        {
            var_bd2c4ac1948d79c6 kill();
        }
        
        waitframe();
    }
    
    level thread function_452768d39104a627();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x28173054, Offset: 0x5396
// Size: 0x95
function private function_fdd8b58c35a16656()
{
    s_spawn_loc = utility::getstruct( "bn_qw_mp", "targetname" );
    level.var_c16e0e8231fe0416.mister_peeks = utility::spawn_model( %"t10_zm_mystery_box_plinth_bunny_fxanim", s_spawn_loc.origin, s_spawn_loc.angles );
    var_ab060e00e514c29f = [ "ai_t10_zm_dj_bunny_loop_01", "ai_t10_zm_dj_bunny_loop_02" ];
    level.var_c16e0e8231fe0416.mister_peeks scriptmodelplayanim( var_ab060e00e514c29f[ randomint( var_ab060e00e514c29f.size ) ] );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xbacb905, Offset: 0x5433
// Size: 0x200
function private function_f5ca3db02784d092()
{
    level thread function_c46975e8a857b1aa();
    a_s_zombie_locs = utility::getstructarray( "dc_he_zb", "script_noteworthy" );
    level.var_c16e0e8231fe0416.var_644c244a4ca4550e = utility::getstruct( "wy_pa_sc", "targetname" );
    var_8a9f72e4d92d20d0 = [ "shot_0", "shot_1", "shot_2", "shot_3", "shot_4", "shot_6", "shot_8", "shot_9", "shot_10", "shot_11", "shot_12", "shot_13", "shot_14", "shot_15", "shot_16", "shot_17", "shot_18", "shot_19", "shot_20", "shot_21", "shot_22", "shot_23" ];
    level.var_c16e0e8231fe0416.var_844660002a6c7a01 = [];
    
    foreach ( loc in a_s_zombie_locs )
    {
        spawn_dancing_zombie( loc );
        waitframe();
    }
    
    for ( i = 0; i < level.var_c16e0e8231fe0416.var_844660002a6c7a01.size ; i++ )
    {
        level.var_c16e0e8231fe0416.var_644c244a4ca4550e thread scene::play( level.var_c16e0e8231fe0416.var_844660002a6c7a01[ i ], var_8a9f72e4d92d20d0[ i ] );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x497aa756, Offset: 0x563b
// Size: 0x16f
function private spawn_dancing_zombie( spawn_struct )
{
    zombie = agent_manager::spawn_agent( "zombie_base", spawn_struct.origin, spawn_struct.angles, "team_two_hundred" );
    
    if ( !zombie )
    {
        return;
    }
    
    zombie val::set( "ee_dance_off", "show_healthbar", 0 );
    zombie val::set( "ee_dance_off", "ignore_cleanup", 1 );
    zombie val::set( "ee_dance_off", "disallow_knockdown", 1 );
    zombie val::set( "ee_dance_off", "damage", 0 );
    zombie.scripted_mode = 1;
    zombie.ignoreall = 1;
    zombie.no_powerups = 1;
    zombie.var_a13bed1ac47e1b2c = 1;
    zombie.var_7ee152b43c7188e1 = 1;
    zombie.b_ignore_death_perception = 1;
    zombie.str_scene_animset_override = "zombie_base_zm_scene";
    zombie.collide_with_ai = 0;
    zombie.nocorpse = 1;
    level.var_c16e0e8231fe0416.var_844660002a6c7a01[ level.var_c16e0e8231fe0416.var_844660002a6c7a01.size ] = zombie;
    zombie notify( #"hash_b29c1a978f0e4627" );
    zombie thread zombie_vox::function_2373b7dab1283d18();
    zombie function_66dc8b6ae969f66d( 1 );
    zombie.var_e9bbea7fb47205ef = 1;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0
// Checksum 0x9a4a96b2, Offset: 0x57b2
// Size: 0xc1
function function_c46975e8a857b1aa()
{
    var_1840aefc5c3af3a2 = utility::getstructarray( "qf_iu_mg", "targetname" );
    var_5d373ce3d6540a3 = [ "shot_1", "shot_2" ];
    
    foreach ( index, s_scene_loc in var_1840aefc5c3af3a2 )
    {
        s_scene_loc scene::add_spawn_function( &function_e866415686064b3e );
        s_scene_loc thread scene::play( undefined, var_5d373ce3d6540a3[ index % var_5d373ce3d6540a3.size ] );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0
// Checksum 0xe80b2940, Offset: 0x587b
// Size: 0x13
function function_e866415686064b3e()
{
    utility::function_7c10ea82c1e305b8( "j_weapon_spin", "dead" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0
// Checksum 0xa97d4a14, Offset: 0x5896
// Size: 0x8e
function function_452768d39104a627()
{
    var_1840aefc5c3af3a2 = utility::getstructarray( "qf_iu_mg", "targetname" );
    
    foreach ( s_scene_loc in var_1840aefc5c3af3a2 )
    {
        s_scene_loc thread scene::stop();
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xc9ead9f1, Offset: 0x592c
// Size: 0x62d
function private function_518b69c4fbca7bc2()
{
    level notify( #"hash_d874902f82f1882d" );
    
    if ( level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa )
    {
        level function_1006d294898bcf5( ( level.var_c16e0e8231fe0416.var_b3b947dbda926aaa ?? 0 ) + 1 );
        
        if ( level.var_c16e0e8231fe0416.var_b3b947dbda926aaa < 3 )
        {
            level function_e9dcea6b7fb70b4a();
        }
        
        level function_5fe1803aa61bb08f();
    }
    
    in_progress_quest_ref = function_7dffe3174c2f3415();
    leaderboard_quest_ref = function_a3cfaa229e8e686d();
    
    /#
        iprintlnbold( "<dev string:x3b>" );
    #/
    
    level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc = utility::function_8391781ea0784541( level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc );
    
    if ( level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc.size < 1 )
    {
        level zm_quest::function_d04a18ed4295a8cd();
        function_8d4286b44dd289fa( 0 );
        return;
    }
    
    foreach ( index, player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        player zm_quest::function_22b6ab0c275ce00b();
        
        if ( player.var_a0de55e36be21b7a && player.var_a0de55e36be21b7a Interactionholding::is_open( player ) )
        {
            player zm_quest::function_6adb74d5d90e96f6();
        }
        
        player function_cc63b23a9fa216e7( level.var_c16e0e8231fe0416.var_25c425265cb8857f[ index ] );
    }
    
    wait 3;
    level utility::flag_clear( "dance_off_in_progress" );
    level zm_quest::function_d04a18ed4295a8cd();
    musicbank_utility::function_4f253fd35ec68cbc( level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc, #"hash_8967b01d8404a562" );
    
    foreach ( player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        if ( player.var_3d0cf4a350e41702 && issubstr( player.var_3d0cf4a350e41702, "zone_safehouse" ) )
        {
            player utility::ent_flag_set( "dance_ee_returning_to_safehouse" );
        }
        
        level thread game_utility::fadetoblackforplayer( player, 1, 0.5 );
        player utility::delaythread( 0.5, &function_1a2b611ae9091ba5 );
    }
    
    wait 0.5;
    level thread function_a28c6e29fc4af07a();
    level zm_sat_scarab_lighting::function_f53a52ac0b42e40d();
    level thread function_8d4286b44dd289fa( 0 );
    
    foreach ( index, player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        player utility::ent_flag_waitopen_any( "dance_battle_ready" );
        player utility::function_d5a54acde3e473ca( 1 );
        s_spawn = level.var_c16e0e8231fe0416.var_5fd60e93d1232709[ index ];
        player setorigin( s_spawn.origin );
        player setplayerangles( s_spawn.angles );
        player.var_ac2659df32949135 = s_spawn.target;
    }
    
    leaderboard_info = function_19ff48887f420714();
    zm_quest::function_e4996840a6b66669( leaderboard_info );
    
    if ( isarray( level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc ) && level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc.size == 1 )
    {
        zm_quest::function_b507b93ea423985d( 0, level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc );
    }
    else
    {
        zm_quest::function_b507b93ea423985d( 1, level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc );
    }
    
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"scarab_ee_dance_off", in_progress_quest_ref );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"scarab_ee_dance_off", in_progress_quest_ref );
    level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"scarab_ee_dance_off", leaderboard_quest_ref );
    level zm_quest::function_fb3af5600f6a9441( 2, 1, #"scarab_ee_dance_off", leaderboard_quest_ref );
    wait 0.5;
    
    foreach ( player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
        player utility::function_d5a54acde3e473ca( 0 );
    }
    
    foreach ( player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
        
        if ( player.var_e93f6e6310d21657 >= 500 )
        {
            level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_1ecbe1cb707c4156", #"zm_sat_scarab_dance_ee", [ player ] );
        }
    }
    
    level function_e9984ca356e1dc35();
    level function_a3827197e9997a9c();
    wait 15;
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"scarab_ee_dance_off", leaderboard_quest_ref );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"scarab_ee_dance_off", leaderboard_quest_ref );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xbb93c15, Offset: 0x5f61
// Size: 0x141
function private function_e9984ca356e1dc35()
{
    mister_peeks = utility::spawn_model( %"t10_zm_mystery_box_plinth_bunny_fxanim", ( 0, 0, 0 ) );
    s_scene_node = utility::getstruct( "ml_za_ens", "targetname" );
    s_scene_node thread scene::play( mister_peeks, "shot_ending" );
    
    foreach ( player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        player playsoundtoplayer( "evt_sq_bowling_ball_bunny_end_showup_laugh", player );
    }
    
    playfx( utility::getfx( "dance_off_end_fireworks" ), s_scene_node.origin - ( 0, 0, 50 ), anglestoforward( s_scene_node.angles ), anglestoup( s_scene_node.angles ) );
    n_scene_duration = s_scene_node scene::function_b3c7b792a7a154fa( "shot_ending" );
    wait n_scene_duration;
    mister_peeks delete();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xba350aa, Offset: 0x60aa
// Size: 0x272
function private function_a3827197e9997a9c()
{
    wait 2;
    level.var_c16e0e8231fe0416.var_3fd09fa68a9bd143 = [];
    
    foreach ( player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        var_890f54599b3667a = utility::getstruct( player.var_ac2659df32949135, "targetname" );
        trophy = spawnscriptable( %"hash_6bfd2805b093efe9", var_890f54599b3667a.origin, var_890f54599b3667a.angles );
        player.var_ace46c5f6dcc5cbc = player function_c24920c6a8679d81();
        trophy thread function_7eba8d58d56956e9( player );
        
        if ( isdefined( trophy ) )
        {
            level.var_c16e0e8231fe0416.var_3fd09fa68a9bd143[ level.var_c16e0e8231fe0416.var_3fd09fa68a9bd143.size ] = trophy;
            trophy.cache_interact = function_3592e85850b5fd00( trophy, player );
            trophy thread function_e5608aa3371ff2f0( player );
            trophy thread function_b9be10f5684f73a3( player );
        }
        
        if ( player.var_e93f6e6310d21657 >= 700 )
        {
            /#
                print3d( trophy.origin, "<dev string:x4c>" + player.var_e93f6e6310d21657 + "<dev string:x55>", undefined, undefined, undefined, 1000, 1 );
            #/
        }
        else if ( player.var_e93f6e6310d21657 >= 500 )
        {
            /#
                print3d( trophy.origin, "<dev string:x4c>" + player.var_e93f6e6310d21657 + "<dev string:x5d>", undefined, undefined, undefined, 1000, 1 );
            #/
        }
        else if ( player.var_e93f6e6310d21657 >= 200 )
        {
            /#
                print3d( trophy.origin, "<dev string:x4c>" + player.var_e93f6e6310d21657 + "<dev string:x68>", undefined, undefined, undefined, 1000, 1 );
            #/
        }
        else
        {
            /#
                print3d( trophy.origin, "<dev string:x4c>" + player.var_e93f6e6310d21657 + "<dev string:x72>", undefined, undefined, undefined, 1000, 1 );
            #/
        }
        
        player.var_ac2659df32949135 = undefined;
    }
    
    level thread function_831aeae93f9e4269();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0xb654d91e, Offset: 0x6324
// Size: 0xf4
function private function_7eba8d58d56956e9( player )
{
    wait 0.25;
    
    switch ( player.var_ace46c5f6dcc5cbc )
    {
        case #"hash_88654edfd0a50a49":
            self setscriptablepartstate( "base", "first" );
            color = "gold";
            break;
        case #"hash_88654bdfd0a50590":
            self setscriptablepartstate( "base", "second" );
            color = "gold";
            break;
        case #"hash_88654cdfd0a50723":
            self setscriptablepartstate( "base", "third" );
            color = "silver";
            break;
        case #"hash_886551dfd0a50f02":
            self setscriptablepartstate( "base", "fourth" );
            color = "silver";
            break;
    }
    
    self setscriptablepartstate( color + "_owner_fx", level.var_c16e0e8231fe0416.var_396cce885f7c3331[ player.sessionuimemberindex ] );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xfffbcdf8, Offset: 0x6420
// Size: 0x48
function private function_c24920c6a8679d81()
{
    if ( self.var_e93f6e6310d21657 >= 700 )
    {
        return "tier_1";
    }
    
    if ( self.var_e93f6e6310d21657 >= 500 )
    {
        return "tier_2";
    }
    
    if ( self.var_e93f6e6310d21657 >= 200 )
    {
        return "tier_3";
    }
    
    return "tier_4";
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x62890e7b, Offset: 0x6471
// Size: 0xee
function private function_3592e85850b5fd00( trophy, player )
{
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_dance_off_rewards", string( player.var_ace46c5f6dcc5cbc ) );
    
    if ( !var_8b5270de14dff72e.size )
    {
        return;
    }
    
    interact = function_5e615e25b6e4d9dd( trophy.origin, var_8b5270de14dff72e, player );
    
    if ( !isdefined( interact ) )
    {
        return;
    }
    
    foreach ( unknown_player in level.players )
    {
        if ( unknown_player && unknown_player != player )
        {
            interact disableplayeruse( unknown_player );
        }
    }
    
    return interact;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 3, eflags: 0x4
// Checksum 0xbe24202a, Offset: 0x6568
// Size: 0x184
function private function_5e615e25b6e4d9dd( position, var_8b5270de14dff72e, player )
{
    inventory_group = %"hash_30d1f71d3877d096";
    interact = common_cache::function_74364c32a1e82886( inventory_group, position, 50, &function_89993741a2bfbd11 );
    common_cache::function_61ef9e0b74e10aaf( interact.cache, var_8b5270de14dff72e );
    interact sethintonobstruction( "show" );
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        item_name = var_8b5270de14dff72e[ i ];
        weapondata = undefined;
        
        if ( common_item::function_3cba34a99d02cd9( item_name ) == "weapon" )
        {
            scriptbundlestruct = getscriptbundlefieldvalues( item_name, [ #"baseweapon", #"rarity" ] );
            weaponname = scriptbundlestruct.baseweapon;
            rarity = scriptbundlestruct.rarity;
            favoriteweapon = player weaponmetadata::function_c68204eff69ed046( weaponname );
            
            if ( isdefined( favoriteweapon ) )
            {
                item_name = item_weapon::function_3da93a43aae4473d( favoriteweapon.basename, rarity );
                weapondata = item_weapon::function_fdc74b9be99fda2f( favoriteweapon );
                weapondata.rarity = rarity;
                weapondata.weaponobj = favoriteweapon;
            }
        }
        
        skipomnvars = !isdefined( weapondata );
        common_cache::function_990ee9d9acd2d1d5( interact.cache, player, item_name, undefined, skipomnvars, undefined, weapondata );
    }
    
    return interact;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xa99a3d28, Offset: 0x66f5
// Size: 0x40
function private function_89993741a2bfbd11( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"shared_hintstrings/open_cache", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x95bbae5a, Offset: 0x673e
// Size: 0xa4
function private function_e5608aa3371ff2f0( owner )
{
    level endon( #"game_ended" );
    owner endon( #"death_or_disconnect" );
    self endon( #"death" );
    level endon( #"hash_8ecd2e333633cbf" );
    
    while ( isdefined( self ) && isdefined( self.cache_interact ) )
    {
        if ( common_cache::iscontainerempty( self.cache_interact.cache ) )
        {
            break;
        }
        
        wait 0.5;
    }
    
    if ( owner.var_e93f6e6310d21657 >= 700 )
    {
        level.var_c16e0e8231fe0416 thread function_794b25e84bf6033d( owner );
    }
    
    cleanup_trophy( owner );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0xf0b6a01, Offset: 0x67ea
// Size: 0x63
function private function_b9be10f5684f73a3( owner )
{
    level endon( #"game_ended" );
    owner endon( #"death_or_disconnect" );
    self endon( #"death" );
    self endon( #"hash_d7aeb953c169e549" );
    wait 30;
    level notify( #"hash_8ecd2e333633cbf" );
    owner notify( #"close_container" );
    waitframe();
    cleanup_trophy( owner );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x2a7859c5, Offset: 0x6855
// Size: 0xb5
function private cleanup_trophy( owner )
{
    if ( isdefined( self ) )
    {
        if ( isdefined( self.cache_interact ) )
        {
            self.cache_interact notify( #"death" );
            self.cache_interact delete();
        }
        
        self setscriptablepartstate( "base", "kill" );
        utility::delaycall( 0.5, &freescriptable );
    }
    
    if ( isdefined( self ) )
    {
        level.var_c16e0e8231fe0416.var_3fd09fa68a9bd143 = arrayremove( level.var_c16e0e8231fe0416.var_3fd09fa68a9bd143, self );
    }
    
    if ( isdefined( owner ) && isdefined( owner.var_3d0cf4a350e41702 ) )
    {
        owner utility::delaythread( 2, &function_fb66399c52016d8e );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xddc758fd, Offset: 0x6912
// Size: 0xb5
function private function_831aeae93f9e4269()
{
    level endon( #"game_ended" );
    
    while ( level.var_c16e0e8231fe0416.var_3fd09fa68a9bd143.size > 0 )
    {
        wait 1;
    }
    
    foreach ( player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        player val::reset_all( "ee_dance_off" );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xba5138bc, Offset: 0x69cf
// Size: 0x59
function private function_30a523689397cde4()
{
    self.var_3d0cf4a350e41702 = undefined;
    zone = zone_manager::function_90e5c3e2272b0130( self.origin );
    
    if ( isdefined( zone ) && issubstr( zone.zone_name, "zone_safehouse" ) )
    {
        self.var_3d0cf4a350e41702 = zone.zone_name;
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xf087ecb3, Offset: 0x6a30
// Size: 0x146
function private function_fb66399c52016d8e()
{
    self endon( #"death_or_disconnect" );
    saved_zone = self.var_3d0cf4a350e41702;
    self.var_3d0cf4a350e41702 = undefined;
    var_dae39ea9517cd07 = zone_manager::function_9dd25e9fb0ecd45b( saved_zone );
    
    if ( !var_dae39ea9517cd07.size )
    {
        return;
    }
    
    respawn_group = utility::array_random( var_dae39ea9517cd07 );
    respawn_struct = utility::array_random( respawn_group.var_f448a26cf56f4a2a );
    val::set( "dance_off_warp_back", "allow_movement", 0 );
    val::set( "dance_off_warp_back", "damage", 0 );
    thread zm_utility::white_screen_flash( 1, 0.2 );
    self playsoundtoplayer( #"hash_1fcabd3140b32dab", self );
    playfx( utility::getfx( "dance_off_teleport_out" ), self.origin );
    wait 0.25;
    self setorigin( respawn_struct.origin );
    self setplayerangles( respawn_struct.angles );
    playfx( utility::getfx( "dance_off_teleport_in" ), self.origin );
    self playsoundtoplayer( #"hash_165d13d526eca172", self );
    val::reset_all( "dance_off_warp_back" );
    utility::delaythread( level.framedurationseconds, &utility::ent_flag_clear, "dance_ee_returning_to_safehouse" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xf42de6b5, Offset: 0x6b7e
// Size: 0x63
function private function_17862eff7d82ec0d()
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"hash_d874902f82f1882d" );
    level thread game_utility::fadetoblackforplayer( player, 1, 0.5 );
    wait 0.5;
    player function_ea7b0bcd4e6f2810();
    player function_da4094e7c735f66d();
    player function_2ec3bd1896e1e74d();
    player function_a243463623f8594();
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xe9dcdd7f, Offset: 0x6be9
// Size: 0x252
function private function_ea7b0bcd4e6f2810()
{
    player = self;
    player val::set( "ee_dance_off", "freezecontrols_allowlook", 1 );
    player val::set( "ee_dance_off", "allow_movement", 0 );
    player val::set( "ee_dance_off", "stance_change", 0 );
    player val::set( "ee_dance_off", "weapon", 0 );
    player val::set( "ee_dance_off", "round_spawning_ignore_player", 1 );
    player val::set( "ee_dance_off", "ignore_afk", 1 );
    player val::set( "ee_dance_off", "mantle", 0 );
    player playerhealth::updatedeathsdoor();
    s_camera = utility::getstruct( "rv_to_c1", "targetname" );
    var_d402dd79dc735ace = utility::spawn_model( "tag_origin", s_camera.origin, s_camera.angles );
    player.var_3ff8091a8ec71ba = var_d402dd79dc735ace;
    player setplayerangles( s_camera.angles );
    player thread utility::delete_on_death( var_d402dd79dc735ace );
    player cameralinkto( var_d402dd79dc735ace, "tag_origin", 1 );
    
    if ( !isdefined( player.defaultbasefov ) )
    {
        player.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    player modifybasefov( 90, 0 );
    player lerpfovscalefactor( 0, 0 );
    
    foreach ( other_player in level.players )
    {
        other_player playerhide();
    }
    
    if ( !player.var_8eb7c138d5ccdc5 )
    {
        player.var_8eb7c138d5ccdc5 = [];
    }
    
    player.var_1253e3555e8bdfa9 = player usinggamepad();
    player function_86f124e6cd1c5230( player.var_1253e3555e8bdfa9 );
    player thread function_309aafdcbd863e8();
    
    if ( player.var_819dfee5ff9a56d6 )
    {
        player zm_ncfdpedestal::force_end_grapple();
    }
    
    player.var_e93f6e6310d21657 = 0;
    player.var_8ccf10a16d009eb9 = 0;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x3eb6b07, Offset: 0x6e43
// Size: 0x1ad
function private function_1a2b611ae9091ba5()
{
    player = self;
    player val::reset_all( "ee_dance_off" );
    player val::set( "ee_dance_off", "round_spawning_ignore_player", 1 );
    
    foreach ( other_player in level.players )
    {
        other_player playershow();
    }
    
    player notify( #"hash_558756fb4be03024" );
    player function_97767ebf2c236815();
    player setclientomnvar( "ui_match_start_countdown", 0 );
    player setclientomnvar( "ui_match_in_progress", 1 );
    player modifybasefov( player.defaultbasefov, 0 );
    player lerpfovscalefactor( 1, 0 );
    player cameraunlink();
    player unlink();
    player setstance( "stand" );
    
    foreach ( clone in player.var_8eb7c138d5ccdc5 )
    {
        clone delete();
    }
    
    player.var_8eb7c138d5ccdc5 = undefined;
    player utility::ent_flag_clear( "dance_battle_ready" );
    player utility::ent_flag_clear( "player_in_dance_off" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x28db5ae3, Offset: 0x6ff8
// Size: 0x68
function private function_309aafdcbd863e8()
{
    level endon( #"hash_d874902f82f1882d" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_558756fb4be03024" );
    
    while ( true )
    {
        b_using_gamepad = self usinggamepad();
        
        if ( b_using_gamepad != self.var_1253e3555e8bdfa9 )
        {
            self.var_1253e3555e8bdfa9 = b_using_gamepad;
            function_86f124e6cd1c5230( b_using_gamepad );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x64a20919, Offset: 0x7068
// Size: 0xb9
function private function_86f124e6cd1c5230( b_using_gamepad )
{
    function_97767ebf2c236815();
    
    if ( b_using_gamepad )
    {
        self notifyonplayercommand( "button_1", "+gostand" );
        self notifyonplayercommand( "button_2", "+stance" );
        self notifyonplayercommand( "button_3", "+weapnext" );
        self notifyonplayercommand( "button_4", "-usereload" );
        return;
    }
    
    self notifyonplayercommand( "button_1", "+back" );
    self notifyonplayercommand( "button_2", "+moveright" );
    self notifyonplayercommand( "button_3", "+forward" );
    self notifyonplayercommand( "button_4", "+moveleft" );
    self notifyonplayercommand( "button_5", "+reload" );
    self notifyonplayercommand( "button_6", "+frag" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x59c4988e, Offset: 0x7129
// Size: 0xa2
function private function_97767ebf2c236815()
{
    self notifyonplayercommandremove( "button_1", "+gostand" );
    self notifyonplayercommandremove( "button_2", "+stance" );
    self notifyonplayercommandremove( "button_3", "+weapnext" );
    self notifyonplayercommandremove( "button_4", "-usereload" );
    self notifyonplayercommandremove( "button_1", "+back" );
    self notifyonplayercommandremove( "button_2", "+moveright" );
    self notifyonplayercommandremove( "button_3", "+forward" );
    self notifyonplayercommandremove( "button_4", "+moveleft" );
    self notifyonplayercommandremove( "button_5", "+reload" );
    self notifyonplayercommandremove( "button_6", "+frag" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xadeb1ddd, Offset: 0x71d3
// Size: 0x48
function private function_da4094e7c735f66d()
{
    player = self;
    s_spawn = utility::getstruct( "gp_ly_ms", "targetname" );
    player_model = player function_84efec24f2a4e7bd( s_spawn );
    player function_a81ae8b428579093( player_model );
    return player_model;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x88a1541a, Offset: 0x7224
// Size: 0xad
function private function_84efec24f2a4e7bd( spawn_struct )
{
    player = self;
    player_model = spawn( "script_model", spawn_struct.origin );
    player_model function_ce21f4102d5d17f6( player.operatorcustomization.skinref );
    player_model.angles = spawn_struct.angles;
    player thread utility::delete_on_death( player_model );
    
    if ( !player.var_8eb7c138d5ccdc5 )
    {
        player.var_8eb7c138d5ccdc5 = [];
    }
    
    player.var_8eb7c138d5ccdc5[ player.var_8eb7c138d5ccdc5.size ] = player_model;
    return player_model;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x85c2c5ad, Offset: 0x72da
// Size: 0xb1
function private function_a81ae8b428579093( model )
{
    player = self;
    model.client_player = player;
    
    foreach ( other_player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        if ( other_player == player )
        {
            continue;
        }
        
        model hidefromplayer( other_player );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xfbd8925d, Offset: 0x7393
// Size: 0xdc
function private function_2ec3bd1896e1e74d()
{
    player = self;
    index = 0;
    
    foreach ( other_player in level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc )
    {
        if ( other_player == player )
        {
            continue;
        }
        
        s_spawn = level.var_c16e0e8231fe0416.var_f67c824a6fd4b379[ index ];
        other_player_model = other_player function_84efec24f2a4e7bd( s_spawn );
        player function_a81ae8b428579093( other_player_model );
        index++;
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0x7edef959, Offset: 0x7477
// Size: 0x242
function private function_a243463623f8594()
{
    level endon( #"hash_d874902f82f1882d" );
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player utility::ent_flag_set( "dance_battle_ready" );
    level utility::array_ent_flag_wait( level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc, "dance_battle_ready" );
    player utility::delaythread( randomfloatrange( 0.25, 1.25 ), &function_cc63b23a9fa216e7, level.var_c16e0e8231fe0416.var_bcf7d394f5b8e521 );
    wait 1.25;
    level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
    wait 0.75;
    player thread hud_message::showsplash( #"hash_70422998941d7776" );
    wait 4;
    player utility::ent_flag_set( "player_in_dance_off" );
    
    while ( true )
    {
        function_e5668ef956b6bd87( level.var_c16e0e8231fe0416.var_bcf7d394f5b8e521, "idle" );
        
        if ( player usinggamepad() )
        {
            button_string_array = player function_e891a3377bdc24b2( level.var_c16e0e8231fe0416.var_d97b0ebb3bb3492f[ "a_controller_strings_phase_1" ] );
        }
        else
        {
            button_string_array = player function_e891a3377bdc24b2( level.var_c16e0e8231fe0416.var_d97b0ebb3bb3492f[ "a_kbm_strings_phase_1" ] );
        }
        
        player.var_b359888215085610 = gettime();
        player thread zm_quest::function_3d98cd2b7249fcbd( level.var_c16e0e8231fe0416.var_8a7f4b51ac31ee32, button_string_array[ "start" ], undefined, 0 );
        b_success = player function_4e1a5a9d874b32b4( button_string_array, level.var_c16e0e8231fe0416.var_8a7f4b51ac31ee32 );
        
        if ( b_success )
        {
            thread function_d5feb3f109710982( b_success );
            thread function_d4bd822582da8463( b_success );
            function_e5668ef956b6bd87( level.var_c16e0e8231fe0416.var_349c3bb70d047d88, "success" );
        }
        else
        {
            thread function_d5feb3f109710982();
            thread function_d4bd822582da8463();
            function_e5668ef956b6bd87( level.var_c16e0e8231fe0416.var_e9abd5f3dc0bec3f, "fail" );
            thread function_3c5d9581d93982b4();
            wait 1.5;
        }
        
        wait 1;
        player utility::ent_flag_waitopen_any( "dance_move_result_hud_in_progress" );
        player zm_quest::function_22b6ab0c275ce00b();
        player zm_quest::function_6adb74d5d90e96f6();
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x34a84825, Offset: 0x76c1
// Size: 0x2bc
function private function_d4bd822582da8463( b_success = 0 )
{
    player = self;
    curr_time = utility::function_6f5d2e1f1ff70482( gettime() );
    time_elapsed = curr_time - utility::function_6f5d2e1f1ff70482( player.var_b359888215085610 );
    points = 0;
    
    if ( b_success )
    {
        if ( time_elapsed <= 1.3 )
        {
            points = 30;
        }
        else if ( time_elapsed <= 1.6 )
        {
            points = 20;
        }
        else
        {
            points = 10;
        }
        
        points *= level.var_c16e0e8231fe0416.point_multiplier;
        player.var_8ccf10a16d009eb9 = ( player.var_8ccf10a16d009eb9 ?? 0 ) + 1;
        
        if ( player.var_8ccf10a16d009eb9 == 5 )
        {
            /#
                iprintlnbold( "<dev string:x7c>" + player.sessionuimemberindex + "<dev string:x84>" );
            #/
            
            player.var_8ccf10a16d009eb9 = 0;
            points += 50;
        }
        
        level.var_c16e0e8231fe0416 thread play_vo_banter( #"hash_1d993bea77b71b94", 15, player, #"bc_flavor_player_positive" );
    }
    else if ( level.var_c16e0e8231fe0416.var_8a7f4b51ac31ee32 != 1.7 )
    {
        player.var_8ccf10a16d009eb9 = 0;
        points = min( abs( -10 ), player.var_e93f6e6310d21657 ) * -1;
        level.var_c16e0e8231fe0416 thread play_vo_banter( #"scarab_sesd1_dance_off_move_fail", 15, player, #"bc_flavor_player_negative" );
    }
    else
    {
        player.var_8ccf10a16d009eb9 = 0;
    }
    
    player.var_e93f6e6310d21657 += points;
    player.var_e93f6e6310d21657 = clamp( player.var_e93f6e6310d21657, 0, 2500 );
    
    if ( points != 0 )
    {
        foreach ( clone in player.var_8eb7c138d5ccdc5 )
        {
            level mp_agent_damage::function_2b26b84aa6ce249c( clone.client_player, 18, points, clone.origin + ( 0, 0, 64 ), 0 );
        }
    }
    
    leaderboard_info = function_19ff48887f420714();
    zm_quest::function_e4996840a6b66669( leaderboard_info );
    zm_quest::function_b507b93ea423985d( 0, level.var_c16e0e8231fe0416.var_d3d5e5e4d0ad9afc );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x8a57bdb7, Offset: 0x7985
// Size: 0x12b
function private function_cc63b23a9fa216e7( var_5b2473d5fd041de1, var_a37e345e7350c663 = 0 )
{
    if ( !level utility::flag( "dance_off_in_progress" ) )
    {
        return;
    }
    
    if ( var_a37e345e7350c663 && utility::ent_flag( "dance_move_in_progress" ) )
    {
        return;
    }
    
    anim_selection = function_c87a7f205a7efc6f( var_5b2473d5fd041de1 );
    var_2c7b2b03ba9b53f3 = anim_selection.anim_data;
    var_8df9fc3adb8c89f8 = get_dance_anim_name( var_2c7b2b03ba9b53f3 );
    anim_start_time = function_e674b207c5a0eb93( var_2c7b2b03ba9b53f3 );
    
    foreach ( clone in self.var_8eb7c138d5ccdc5 )
    {
        clone scriptmodelplayanim( var_8df9fc3adb8c89f8, undefined, anim_start_time, undefined, "slow" );
    }
    
    self.var_fce4006bd75b657e = anim_selection.anim_key;
    return function_41989d4b7fdb6f01( var_2c7b2b03ba9b53f3 );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x6444696, Offset: 0x7ab9
// Size: 0x87
function private function_c87a7f205a7efc6f( var_5b2473d5fd041de1 )
{
    selection = spawnstruct();
    
    if ( !isarray( var_5b2473d5fd041de1 ) )
    {
        selection.anim_data = var_5b2473d5fd041de1;
        selection.anim_key = get_dance_anim_key( selection.anim_data );
        return selection;
    }
    
    selection.anim_data = utility::array_random( var_5b2473d5fd041de1 );
    selection.anim_key = get_dance_anim_key( selection.anim_data );
    return selection;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xa84a939f, Offset: 0x7b49
// Size: 0xe9
function private function_e5668ef956b6bd87( var_5b2473d5fd041de1, str_anim_state )
{
    if ( self.var_cfe0cd3e580c7c73 && self.var_cfe0cd3e580c7c73 != "idle" )
    {
        return 0;
    }
    
    if ( str_anim_state == "idle" )
    {
        self.var_cfe0cd3e580c7c73 = str_anim_state;
        return function_cc63b23a9fa216e7( var_5b2473d5fd041de1 );
    }
    
    var_a30004b717a4df18 = var_5b2473d5fd041de1;
    
    if ( isarray( var_5b2473d5fd041de1 ) )
    {
        var_a30004b717a4df18 = function_9a6ec70374723856( var_5b2473d5fd041de1, self.var_681ab05e9dc3069a );
    }
    
    anim_time = function_cc63b23a9fa216e7( var_a30004b717a4df18 );
    
    if ( anim_time <= 0 )
    {
        return 0;
    }
    
    self.var_681ab05e9dc3069a = self.var_2c0cbffa124fa987 ?? self.var_fce4006bd75b657e;
    self.var_cfe0cd3e580c7c73 = str_anim_state;
    self.var_2c0cbffa124fa987 = undefined;
    utility::ent_flag_set( "dance_move_in_progress" );
    utility::delaythread( anim_time, &function_e913aa50b9a77573 );
    return anim_time;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xbf0ddaf, Offset: 0x7c3b
// Size: 0xe1
function private function_9a6ec70374723856( a_anim_pool, last_anim_key )
{
    var_923e46121bd8d7f7 = [];
    
    foreach ( anim_data in a_anim_pool )
    {
        if ( a_anim_pool.size > 1 && last_anim_key && get_dance_anim_key( anim_data ) == last_anim_key )
        {
            continue;
        }
        
        var_923e46121bd8d7f7[ var_923e46121bd8d7f7.size ] = anim_data;
    }
    
    if ( !var_923e46121bd8d7f7.size )
    {
        var_923e46121bd8d7f7 = a_anim_pool;
    }
    
    var_e29274c7a8abd16d = utility::array_random( var_923e46121bd8d7f7 );
    self.var_2c0cbffa124fa987 = get_dance_anim_key( var_e29274c7a8abd16d );
    return var_e29274c7a8abd16d;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x896dbea0, Offset: 0x7d25
// Size: 0x40, Type: bool
function private function_ae20dfe5f67bdc03( anim_data )
{
    return isstruct( anim_data ) && isdefined( anim_data.str_anim_name ) && isdefined( anim_data.start_time ) && isdefined( anim_data.end_time );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x43c8e810, Offset: 0x7d6e
// Size: 0x25
function private get_dance_anim_name( anim_data )
{
    if ( function_ae20dfe5f67bdc03( anim_data ) )
    {
        return anim_data.str_anim_name;
    }
    
    return anim_data;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x8d424052, Offset: 0x7d9c
// Size: 0x51
function private get_dance_anim_key( anim_data )
{
    if ( function_ae20dfe5f67bdc03( anim_data ) )
    {
        return ( anim_data.str_anim_name + "_" + string( anim_data.start_time ) + "_" + string( anim_data.end_time ) );
    }
    
    return anim_data;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0xe2ba9f51, Offset: 0x7df6
// Size: 0x24
function private function_e674b207c5a0eb93( anim_data )
{
    if ( function_ae20dfe5f67bdc03( anim_data ) )
    {
        return anim_data.start_time;
    }
    
    return 0;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x82189672, Offset: 0x7e23
// Size: 0x12f
function private function_e891a3377bdc24b2( var_1b9e312446530477 )
{
    if ( !isdefined( self.var_b4a2bf5be9195c65 ) )
    {
        self.var_b4a2bf5be9195c65 = [];
    }
    
    a_valid_combos = [];
    
    foreach ( combo_data in var_1b9e312446530477 )
    {
        if ( arraycontains( self.var_b4a2bf5be9195c65, combo_data[ "key" ] ) )
        {
            continue;
        }
        
        a_valid_combos[ a_valid_combos.size ] = combo_data;
    }
    
    if ( !a_valid_combos.size )
    {
        a_valid_combos = var_1b9e312446530477;
    }
    
    var_7f75496965519197 = utility::array_random( a_valid_combos );
    self.var_b4a2bf5be9195c65[ self.var_b4a2bf5be9195c65.size ] = var_7f75496965519197[ "key" ];
    
    if ( self.var_b4a2bf5be9195c65.size > 2 )
    {
        self.var_b4a2bf5be9195c65 = arrayremove( self.var_b4a2bf5be9195c65, self.var_b4a2bf5be9195c65[ getfirstarraykey( self.var_b4a2bf5be9195c65 ) ] );
    }
    
    return var_7f75496965519197;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0xabb71eb5, Offset: 0x7f5b
// Size: 0x31
function private function_41989d4b7fdb6f01( anim_data )
{
    if ( function_ae20dfe5f67bdc03( anim_data ) )
    {
        return ( anim_data.end_time - anim_data.start_time );
    }
    
    return 3;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xf96e7d4c, Offset: 0x7f95
// Size: 0x36
function private function_e913aa50b9a77573()
{
    utility::ent_flag_clear( "dance_move_in_progress" );
    self.var_cfe0cd3e580c7c73 = "idle";
    thread function_cc63b23a9fa216e7( level.var_c16e0e8231fe0416.var_bcf7d394f5b8e521 );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x12daca4b, Offset: 0x7fd3
// Size: 0x1a8
function private function_d5feb3f109710982( b_success = 0 )
{
    level endon( #"hash_d874902f82f1882d" );
    player = self;
    player endon( #"death_or_disconnect" );
    player utility::ent_flag_set( "dance_move_result_hud_in_progress" );
    player zm_quest::function_2adcdbfad350618();
    var_f0831f7b78378568 = b_success ? level.var_c16e0e8231fe0416.str_success : level.var_c16e0e8231fe0416.str_fail;
    var_90e53e9fc8d0c2b6 = b_success ? level.var_c16e0e8231fe0416.var_279d180fd18b8c93 : level.var_c16e0e8231fe0416.var_ebb9236cf47129e8;
    
    if ( !player utility::ent_flag( "quicktime_hud_active" ) )
    {
        player thread zm_quest::function_3d98cd2b7249fcbd( 0, var_90e53e9fc8d0c2b6, undefined, 0 );
        player zm_interaction::function_45e51da251cd5e3a( 0 );
    }
    
    if ( b_success )
    {
        player.var_3ff8091a8ec71ba playsoundtoplayer( #"hash_44eb5933dc603877", player );
    }
    else
    {
        player.var_3ff8091a8ec71ba playsoundtoplayer( #"hash_6d9bfdf0ccca08d6", player );
    }
    
    wait 0.2;
    player.var_a0de55e36be21b7a Interactionholding::set_description( player, var_90e53e9fc8d0c2b6 );
    wait 0.2;
    player.var_a0de55e36be21b7a Interactionholding::set_description( player, var_f0831f7b78378568 );
    wait 0.2;
    player.var_a0de55e36be21b7a Interactionholding::set_description( player, var_90e53e9fc8d0c2b6 );
    wait 0.2;
    player.var_a0de55e36be21b7a Interactionholding::set_description( player, var_f0831f7b78378568 );
    wait 0.2;
    player utility::ent_flag_clear( "dance_move_result_hud_in_progress" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 0, eflags: 0x4
// Checksum 0xe0c95de9, Offset: 0x8183
// Size: 0x44
function private function_3c5d9581d93982b4()
{
    player = self;
    level endon( #"hash_d874902f82f1882d" );
    player endon( #"death_or_disconnect" );
    self playrumbleonentity( "viewmodel_large" );
    wait 0.2;
    self playrumbleonentity( "viewmodel_large" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xac0d6866, Offset: 0x81cf
// Size: 0x128, Type: bool
function private function_4e1a5a9d874b32b4( button_string_array, event_time )
{
    player = self;
    level endon( #"hash_d874902f82f1882d" );
    player endon( #"death_or_disconnect" );
    player endon( #"hash_ac35a31662bb63f" );
    
    foreach ( index, button_notify in button_string_array[ "solution" ] )
    {
        var_a44fe3177a58d8cf = utility::waittill_any_in_array_return( level.var_c16e0e8231fe0416.var_ee01e6f9143437e6 );
        
        if ( var_a44fe3177a58d8cf == button_notify )
        {
            player.var_a0de55e36be21b7a Interactionholding::set_description( player, button_string_array[ "button_" + string( index + 1 ) ] );
            player.var_3ff8091a8ec71ba playsoundtoplayer( #"hash_7e7237dd1b2dab5a", player );
            continue;
        }
        
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x23b8126a, Offset: 0x8300
// Size: 0x73
function private function_794b25e84bf6033d( player )
{
    if ( utility::ent_flag( "t1_reward_collect_hero_banter_played" ) )
    {
        play_vo_banter( #"scarab_sesd1_dance_off_t1_reward_collect", 10, player, #"bc_flavor_player_positive", 1 );
        return;
    }
    
    var_3a8d0641ffe3f1bc = play_vo_banter( #"scarab_sesd1_dance_off_t1_reward_collect", 10, player, #"bc_flavor_player_positive" );
    
    if ( var_3a8d0641ffe3f1bc )
    {
        utility::ent_flag_set( "t1_reward_collect_hero_banter_played" );
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 5, eflags: 0x4
// Checksum 0xf7f316b, Offset: 0x837b
// Size: 0x15c
function private play_vo_banter( var_5e1c75975eb34ec4, var_7c2c820e274abf1c = 0, player, var_1c360473c4174a43, b_force_generic = 0 )
{
    if ( overlord::function_dce0a14273dfa0a8() || level utility::flag( "overlord_paused" ) )
    {
        return;
    }
    
    if ( level utility::flag( "player_banter_playing" ) || self.event_banter[ var_5e1c75975eb34ec4 ] utility::ent_flag( "cooling_down" ) )
    {
        return;
    }
    
    var_8984c1f1eeea88ec = self.event_banter[ var_5e1c75975eb34ec4 ].bantername;
    
    if ( !b_force_generic && !var_8984c1f1eeea88ec )
    {
        return;
    }
    
    level overlord::function_724ca7b94bf1fb66( 1 );
    var_db75d3de862ce072 = 0;
    var_220c096e8a2c59be = 0;
    
    if ( !b_force_generic )
    {
        var_db75d3de862ce072 = level player_banter::play_banter_vo( var_8984c1f1eeea88ec, [ player ] );
    }
    
    if ( !var_db75d3de862ce072 && isalive( player ) && var_1c360473c4174a43 )
    {
        var_220c096e8a2c59be = level battlechatter_mp::trysaylocalsound( player, var_1c360473c4174a43 );
    }
    
    level utility::delaythread( 1, &overlord::function_724ca7b94bf1fb66, 0 );
    
    if ( ( var_db75d3de862ce072 || var_220c096e8a2c59be ) && var_7c2c820e274abf1c > 0 )
    {
        self.event_banter[ var_5e1c75975eb34ec4 ] utility::ent_flag_set( "cooling_down" );
        utility::delaythread( var_7c2c820e274abf1c, &function_17eb1b6e6289e9b4, var_5e1c75975eb34ec4 );
    }
    
    return var_db75d3de862ce072;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x7f35c500, Offset: 0x84e0
// Size: 0x24
function private function_17eb1b6e6289e9b4( var_5e1c75975eb34ec4 )
{
    self.event_banter[ var_5e1c75975eb34ec4 ] utility::ent_flag_clear( "cooling_down" );
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0xaf5870ab, Offset: 0x850c
// Size: 0x1f7
function private function_e524e3a82390272( origin, radius = 200 )
{
    var_5da372bdcdfd7eb7 = function_15c22b3b8fb5cfa8( origin, radius );
    
    foreach ( equipment in var_5da372bdcdfd7eb7 )
    {
        if ( equipment.equipmentref == "equip_mini_sentry" )
        {
            equipment thread mini_sentry::on_destruction();
            b_valid_equipment = 1;
            continue;
        }
        
        if ( equipment.streakname == "dawg" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment thread dawg::dawg_self_destruct();
            b_valid_equipment = 1;
            continue;
        }
        
        if ( equipment.streakname == "remote_turret" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment notify( #"kill_turret", 1, 1, 0, 1 );
            b_valid_equipment = 1;
            continue;
        }
        
        if ( equipment.streakname == "rcxd" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment thread rcxd_shared::rcxd_explode();
            b_valid_equipment = 1;
            continue;
        }
        
        if ( equipment.equipmentref == "equip_smart_seeker" )
        {
            equipment thread smart_seeker::function_16e1c3f278107106();
            b_valid_equipment = 1;
            continue;
        }
        
        if ( equipment.streakname == "radiation_blast" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment notify( #"kill_turret", 1, 1, 0, 1 );
            b_valid_equipment = 1;
        }
    }
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 2, eflags: 0x4
// Checksum 0x17d6cab1, Offset: 0x870b
// Size: 0x193
function private function_15c22b3b8fb5cfa8( origin, radius = 200 )
{
    equipment_in_level = level.activekillstreaks;
    equipment_in_level = arraycombineunique( equipment_in_level, weapon::function_3aafcaf7ff6dea9e() );
    
    if ( !equipment_in_level || equipment_in_level.size < 1 )
    {
        return;
    }
    
    equipment_in_level = sortbydistancecullbyradius( equipment_in_level, origin, radius );
    var_5da372bdcdfd7eb7 = [];
    
    foreach ( equipment in equipment_in_level )
    {
        if ( equipment.equipmentref == "equip_mini_sentry" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.streakname == "dawg" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.streakname == "remote_turret" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.streakname == "rcxd" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.equipmentref == "equip_smart_seeker" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.streakname == "radiation_blast" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
        }
    }
    
    return var_5da372bdcdfd7eb7;
}

// Namespace zm_sat_scarab_script_quest_ee_dance_off
// Params 1, eflags: 0x4
// Checksum 0x3a0c7099, Offset: 0x88a7
// Size: 0x6e
function private function_ee4a85043e5fcda6( params )
{
    level.var_c16e0e8231fe0416.var_3b2fa16edadb4469 = 0;
    level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa = 1;
    level.var_c16e0e8231fe0416.cassette_player utility::function_32b24db3127bff40( "body", "on" );
    level function_aff6240822d66234( level.players[ 0 ] );
}

/#

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 0, eflags: 0x4
    // Checksum 0x7da4a20b, Offset: 0x891d
    // Size: 0x10a, Type: dev
    function private function_b4a5f67d7c881632()
    {
        devgui::function_9082edeb5db93280( "<dev string:x94>" );
        devgui::add_devgui_func( "<dev string:xb2>", "<dev string:xce>", &function_4a2f791100ec6aec );
        devgui::add_devgui_func( "<dev string:xe4>", "<dev string:x104>", &function_16f9a2f966322116 );
        devgui::add_devgui_func( "<dev string:x118>", "<dev string:x13b>", &function_af8319cc17b96e09 );
        devgui::add_devgui_func( "<dev string:x152>", "<dev string:x172>", &function_135e14aa804045bc );
        devgui::add_devgui_func( "<dev string:x186>", "<dev string:x1ab>", &function_37e9656cf9c69dcc );
        devgui::add_devgui_func( "<dev string:x1c4>", "<dev string:x1ec>", &function_83511b5d07585f5c );
        devgui::add_devgui_func( "<dev string:x201>", "<dev string:x230>", &function_9e1314af43b1a478 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x249>", "<dev string:x263>", &function_d87d0c42b82768c2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x277>", "<dev string:x291>", &function_d87d0c42b82768c2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2a5>", "<dev string:x2bf>", &function_d87d0c42b82768c2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2d3>", "<dev string:x2ed>", &function_d87d0c42b82768c2 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 0, eflags: 0x4
    // Checksum 0xe1bcc740, Offset: 0x8a2f
    // Size: 0x67, Type: dev
    function private function_4a2f791100ec6aec()
    {
        level.var_c16e0e8231fe0416.var_3b2fa16edadb4469 = 0;
        level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa = 1;
        level.var_c16e0e8231fe0416.cassette_player utility::function_32b24db3127bff40( "<dev string:x301>", "<dev string:x306>" );
        level function_aff6240822d66234( level.players[ 0 ] );
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 0, eflags: 0x4
    // Checksum 0x3fccc339, Offset: 0x8a9e
    // Size: 0x1f, Type: dev
    function private function_16f9a2f966322116()
    {
        function_b884537cae488d0a( level.var_c16e0e8231fe0416.var_bcf7d394f5b8e521 );
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 0, eflags: 0x4
    // Checksum 0xa1ac0505, Offset: 0x8ac5
    // Size: 0x1f, Type: dev
    function private function_af8319cc17b96e09()
    {
        function_b884537cae488d0a( level.var_c16e0e8231fe0416.var_349c3bb70d047d88 );
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 0, eflags: 0x4
    // Checksum 0xe7732b78, Offset: 0x8aec
    // Size: 0x1f, Type: dev
    function private function_135e14aa804045bc()
    {
        function_b884537cae488d0a( level.var_c16e0e8231fe0416.var_e9abd5f3dc0bec3f );
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 0, eflags: 0x4
    // Checksum 0xe19f3d42, Offset: 0x8b13
    // Size: 0xc, Type: dev
    function private function_37e9656cf9c69dcc()
    {
        function_6a8d4e2c117cd014();
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 0, eflags: 0x4
    // Checksum 0x81682bc2, Offset: 0x8b27
    // Size: 0x14e, Type: dev
    function private function_83511b5d07585f5c()
    {
        if ( level.players.size <= 0 )
        {
            return;
        }
        
        player = level.players[ 0 ];
        v_forward = anglestoforward( player.angles );
        v_spawn = player.origin + v_forward * 15 + ( 0, 0, 30 );
        level.var_c16e0e8231fe0416.var_3b2fa16edadb4469 = 0;
        level.var_c16e0e8231fe0416.var_2f7307bbc7db8dfa = 0;
        level function_4659f86a1519ca5a();
        level function_1cf78d8d09ab439b();
        cassette = spawnscriptable( %"hash_6bfd1905b093d66c", v_spawn, player.angles );
        cassette setscriptablepartstate( "<dev string:x301>", "<dev string:x309>" );
        cassette setscriptablepartstate( "<dev string:x311>", "<dev string:x306>" );
        cassette.interaction = interaction::register_scriptable_interact( cassette, &function_dace943b77dcb45b, undefined, undefined, &function_d2097eb551b27ac7 );
        cassette.interaction.cassette = cassette;
        level.var_c16e0e8231fe0416.var_2d8d18ac3d6fe0d = cassette;
        level function_287d35a29e913185();
        iprintlnbold( "<dev string:x318>" );
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 0, eflags: 0x4
    // Checksum 0x3b1e55cd, Offset: 0x8c7d
    // Size: 0x94, Type: dev
    function private function_5877d47e4e33a0d3()
    {
        if ( level.var_c16e0e8231fe0416.debug_player_model )
        {
            level.var_c16e0e8231fe0416.debug_player_model delete();
        }
        
        s_spawn = utility::getstruct( "<dev string:x348>", "<dev string:x351>" );
        level.var_c16e0e8231fe0416.debug_player_model = level.players[ 0 ] function_84efec24f2a4e7bd( s_spawn );
        level.var_c16e0e8231fe0416.debug_player_model endon( #"death" );
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 1, eflags: 0xc
    // Checksum 0x9ef791d6, Offset: 0x8d19
    // Size: 0x107, Type: dev
    function private function_b884537cae488d0a( var_c76d7a3b2968d014 )
    {
        self notify( #"hash_6e0902a47f2dd40c" );
        self endon( #"hash_6e0902a47f2dd40c" );
        level function_5877d47e4e33a0d3();
        
        while ( true )
        {
            foreach ( anim_data in var_c76d7a3b2968d014 )
            {
                str_anim = get_dance_anim_name( anim_data );
                
                /#
                    iprintlnbold( "<dev string:x35c>" + get_dance_anim_key( anim_data ) );
                #/
                
                anim_start_time = function_e674b207c5a0eb93( anim_data );
                level.var_c16e0e8231fe0416.debug_player_model scriptmodelplayanim( str_anim, undefined, anim_start_time, undefined, "<dev string:x367>" );
                wait function_41989d4b7fdb6f01( anim_data );
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 0, eflags: 0xc
    // Checksum 0x1a59cff1, Offset: 0x8e28
    // Size: 0x144, Type: dev
    function private function_6a8d4e2c117cd014()
    {
        self notify( #"hash_7e97f28e46eef981" );
        self endon( #"hash_7e97f28e46eef981" );
        level function_5877d47e4e33a0d3();
        
        while ( true )
        {
            level function_98eb8b71a711c8d();
            
            foreach ( anim_data in level.var_c16e0e8231fe0416.var_349c3bb70d047d88 )
            {
                level function_92e7d238e65c48f9( anim_data );
                level function_98eb8b71a711c8d();
            }
            
            foreach ( anim_data in level.var_c16e0e8231fe0416.var_e9abd5f3dc0bec3f )
            {
                level function_92e7d238e65c48f9( anim_data );
                level function_98eb8b71a711c8d();
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 0, eflags: 0x4
    // Checksum 0xc290e62c, Offset: 0x8f74
    // Size: 0x4f, Type: dev
    function private function_98eb8b71a711c8d()
    {
        idle_anim = utility::array_random( level.var_c16e0e8231fe0416.var_bcf7d394f5b8e521 );
        level.var_c16e0e8231fe0416.debug_player_model scriptmodelplayanim( idle_anim, undefined, undefined, undefined, "<dev string:x367>" );
        wait 3;
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 1, eflags: 0x4
    // Checksum 0x66741a5d, Offset: 0x8fcb
    // Size: 0x61, Type: dev
    function private function_92e7d238e65c48f9( anim_data )
    {
        str_anim = get_dance_anim_name( anim_data );
        anim_start_time = function_e674b207c5a0eb93( anim_data );
        level.var_c16e0e8231fe0416.debug_player_model scriptmodelplayanim( str_anim, undefined, anim_start_time, undefined, "<dev string:x367>" );
        wait function_41989d4b7fdb6f01( anim_data );
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 1, eflags: 0x4
    // Checksum 0xdce6981c, Offset: 0x9034
    // Size: 0xce, Type: dev
    function private function_d87d0c42b82768c2( params )
    {
        str_tier = params[ 0 ];
        player = level.players[ 0 ];
        v_forward = anglestoforward( player.angles );
        v_spawn = player.origin + v_forward * 120 + ( 0, 0, 42 );
        trophy = spawnscriptable( %"hash_6bfd2805b093efe9", v_spawn, player.angles );
        assert( isdefined( trophy ), "<dev string:x36c>" );
        player.var_ace46c5f6dcc5cbc = str_tier;
        trophy thread function_7eba8d58d56956e9( player );
        iprintlnbold( "<dev string:x389>" + str_tier );
    }

    // Namespace zm_sat_scarab_script_quest_ee_dance_off
    // Params 1, eflags: 0x4
    // Checksum 0x6efe8f57, Offset: 0x910a
    // Size: 0x70, Type: dev
    function private function_9e1314af43b1a478( params )
    {
        str_tier = params[ 0 ];
        player = level.players[ 0 ];
        v_forward = anglestoforward( player.angles );
        v_spawn = player.origin + v_forward * 120;
        function_7c3137969a08af19( v_spawn );
    }

#/
