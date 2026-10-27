// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_dmps_ee.gsc  (hash_52dfc9f76978214b.gscc) (size: 38840 Bytes / 0x97b8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5c2c7b64 (1546419044)
// size ...... 38840 (0x97b8)
// includes .. 28  (offset: 0x8af8)
// strings ... 121 (offset: 0x8bd8)
// dev strs .. 79  (offset: 0x9384)
// exports ... 86  (offset: 0x58d8)
// cseg ...... 0x9de + 0x4efa (0x58d8)
// imports ... 290 (offset: 0x6648)
// animtree1 . 0   (offset: 0x97b8)
// animtree2 . 0   (offset: 0x97b8)
#using script_16ea1b94f0f381b3;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ammo_cache;
#using scripts\mp\bots\bots;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\mutant_injection_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_exfil_sat;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_firefly_script_dmps_ee;

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x5
// Checksum 0x839c7f14, Offset: 0x9fc
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_dmps_ee", undefined, &pre_init, &post_init );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0x83f7491b, Offset: 0xa21
// Size: 0x23
function private pre_init()
{
    if ( !getdvarint( @"hash_dfe5227c40e9c4e0", 0 ) )
    {
        return;
    }
    
    level.var_b171481be469074a = &function_333bde7572c80112;
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0xd4611e5c, Offset: 0xa4c
// Size: 0x285
function private post_init()
{
    if ( !getdvarint( @"hash_dfe5227c40e9c4e0", 0 ) )
    {
        return;
    }
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        return;
    }
    
    zm_quest::function_3c363613c60958f5( "progressing_dmps_ee" );
    level utility::flag_wait( "zm_sat_firefly_script_dmps_ee_cs_completed" );
    level._effect[ "ee_dempsey_confetti" ] = loadfxasset( "vfx_present_box_opening" );
    level._effect[ "ee_dempsey_outro_teleport" ] = loadfxasset( "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_zmb_3p" );
    level utility::flag_wait( "begin_round_logic" );
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"dmps_ee_done" ) == 1 )
    {
        return;
    }
    
    level.dempsey_ee = spawnstruct();
    level.dempsey_ee.var_d28d9482cfeff43a = utility::getstruct( "ee_dempsey_corpse_interact", "script_noteworthy" );
    level.dempsey_ee.e_dog_tag = spawnscriptable( "zm_sat_firefly_dmps_ee_dog_tag", level.dempsey_ee.var_d28d9482cfeff43a.origin, level.dempsey_ee.var_d28d9482cfeff43a.angels );
    interact_dog_tag = zm_quest::function_91f9590e98d57ff6( level.dempsey_ee.var_d28d9482cfeff43a.origin + ( 0, 0, 40 ), &function_3f9de58378affab6, &function_a83d1b634592a8aa, "extrasmallnohint" );
    
    if ( !isdefined( level.var_5000c3c1cd028258 ) )
    {
        level.var_5000c3c1cd028258 = undefined;
    }
    
    level callback::add( #"player_laststand", &function_b1a70274e9508a18 );
    level callback::add( #"player_disconnect", &on_player_disconnect );
    level callback::add( #"player_death", &on_player_death );
    level callback::add( "on_round_start", &on_round_start );
    s_ammo_cache = utility::getstructarray( "dempsey_ee_ammo_cache", "script_noteworthy" );
    
    foreach ( var_c08325a9a6586e42 in s_ammo_cache )
    {
        ammo_cache::function_48881059553792e5( var_c08325a9a6586e42 );
    }
    
    level.dempsey_ee.e_dog_tag thread function_74a033df096e13f7( 360 );
    
    /#
        setup_dmps_ee_devgui();
    #/
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0xb59a558f, Offset: 0xcd9
// Size: 0x174
function private function_74a033df096e13f7( n_radius )
{
    level endon( #"dog_tag_found", #"game_ended" );
    self endon( #"death" );
    distance = n_radius * n_radius;
    cooldown = 0;
    level.var_dd91b52f035361f1 = function_969ac5856f00b60d( 12 );
    
    while ( true )
    {
        waitframe();
        
        foreach ( player in level.players )
        {
            if ( !player )
            {
                continue;
            }
            
            if ( !player is_operator_dempsey() )
            {
                continue;
            }
            
            if ( player.pickup_dog_tag )
            {
                continue;
            }
            
            if ( distance2dsquared( player.origin, self.origin ) < distance )
            {
                if ( !isdefined( player.var_e1daef9711417e0a ) )
                {
                    player.var_e1daef9711417e0a = 0;
                }
                
                if ( gettime() >= player.var_e1daef9711417e0a )
                {
                    player function_e7758575f2df091d();
                    
                    if ( player )
                    {
                        cooldown = randomintrange( 10, 16 );
                        player.var_e1daef9711417e0a = gettime() + cooldown * 1000;
                    }
                }
            }
        }
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 2, eflags: 0x4
// Checksum 0x591dff89, Offset: 0xe55
// Size: 0x91
function private function_333bde7572c80112( struct, model )
{
    struct.zone = zone_manager::function_90e5c3e2272b0130( model.origin );
    
    if ( issubstr( struct.zone.zone_name, "dempsey" ) )
    {
        model utility::function_7c10ea82c1e305b8( #"icon", #"idle" );
        return;
    }
    
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", model, "icon" );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0x128eaef6, Offset: 0xeee
// Size: 0x3dd
function private progress_watcher( player )
{
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    player endon( #"death_or_disconnect" );
    player zm_utility::function_d47920bb0d5fa327( "firefly_eedmps_progresswatcher" );
    player.n_self_revive = player laststand::function_7072b516e6cffb7c();
    player laststand::function_39844c1e879cc048( 0 );
    player utility::ent_flag_set( "dmp_loadout_saved" );
    level thread function_ec810f013ce9dc70( player, getdvarint( @"hash_fed72ff304b8fb85", 90 ) );
    wait 1;
    player playlocalsound( #"hash_680a14192b7a5ddd" );
    level thread function_7938ae2780b6c1a9();
    level thread set_scene( "ee_dempsey_scene_node_1st" );
    level thread set_scene( "ee_dempsey_scene_node_2nd" );
    level thread set_scene( "ee_dempsey_scene_node_3rd" );
    
    /#
        level thread function_c021d724e05ab662();
    #/
    
    player thread function_369a9e46dcc66b79();
    var_4960ab80458481ac = utility::getstruct( "ee_dempsey_path_1_1", "script_noteworthy" );
    level function_ae078525075bf167( var_4960ab80458481ac, 0 );
    var_4960ae8045848845 = utility::getstruct( "ee_dempsey_path_1_2", "script_noteworthy" );
    level function_ae078525075bf167( var_4960ae8045848845, 0 );
    var_4960ad8045848612 = utility::getstruct( "ee_dempsey_path_1_3", "script_noteworthy" );
    level function_ae078525075bf167( var_4960ad8045848612, 1, 1 );
    player approach_watcher( var_4960ad8045848612, "_1st" );
    function_9464570ccdf080fd( var_4960ad8045848612, 1, 5 );
    level notify( #"end_timer" );
    level utility::flag_set( "stop_dempsey_anguished_thoughts" );
    level utility::flag_waitopen( "stop_dempsey_anguished_thoughts" );
    level thread function_ec810f013ce9dc70( player, getdvarint( @"hash_fed72cf304b8f4ec", 120 ) );
    var_7525b28065b130d1 = utility::getstruct( "ee_dempsey_path_2_1", "script_noteworthy" );
    level function_ae078525075bf167( var_7525b28065b130d1, 0, 0 );
    var_7525af8065b12a38 = utility::getstruct( "ee_dempsey_path_2_2", "script_noteworthy" );
    level function_ae078525075bf167( var_7525af8065b12a38, 1, 1 );
    player approach_watcher( var_7525af8065b12a38, "_2nd" );
    level utility::flag_wait( "weaver_zombie" );
    wait 5;
    function_9464570ccdf080fd( var_7525af8065b12a38, 1, 10 );
    function_9464570ccdf080fd( var_7525af8065b12a38, 2, 10 );
    level notify( #"end_timer" );
    level utility::flag_set( "stop_dempsey_anguished_thoughts" );
    level utility::flag_waitopen( "stop_dempsey_anguished_thoughts" );
    level thread function_ec810f013ce9dc70( player, getdvarint( @"hash_fed72df304b8f71f", 150 ) );
    player playlocalsound( #"hash_680a12192b7a5a77" );
    var_6863f9805cfbcaf6 = utility::getstruct( "ee_dempsey_path_3_1", "script_noteworthy" );
    level function_ae078525075bf167( var_6863f9805cfbcaf6, 0 );
    var_6863f8805cfbc8c3 = utility::getstruct( "ee_dempsey_path_3_2", "script_noteworthy" );
    level function_ae078525075bf167( var_6863f8805cfbc8c3, 0 );
    var_6863f7805cfbc690 = utility::getstruct( "ee_dempsey_path_3_3", "script_noteworthy" );
    level function_ae078525075bf167( var_6863f7805cfbc690, 0 );
    var_6863fe805cfbd5f5 = utility::getstruct( "ee_dempsey_path_3_4", "script_noteworthy" );
    level function_ae078525075bf167( var_6863fe805cfbd5f5, 1, 1 );
    player approach_watcher( var_6863fe805cfbd5f5, "_3rd" );
    function_9464570ccdf080fd( var_6863fe805cfbd5f5, 1, 15 );
    function_9464570ccdf080fd( var_6863fe805cfbd5f5, 2, 15 );
    level utility::flag_set( "stop_dempsey_anguished_thoughts" );
    level utility::flag_set( "final_zombies" );
    level thread function_9464570ccdf080fd( var_6863fe805cfbd5f5, 3, 15 );
    level utility::flag_waitopen( "stop_dempsey_anguished_thoughts" );
    level utility::flag_waitopen( "final_zombies" );
    level notify( #"end_timer" );
    wait 2;
    utility::fadetoblackforplayerkeepui( player, 1, 1 );
    zm_quest::function_d5ef98341fd6a057( [ #"hash_cd18ff635690b728" ], [ player ] );
    level thread ee_end( player, 1 );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0xee2258c, Offset: 0x12d3
// Size: 0x32e
function private function_369a9e46dcc66b79()
{
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    self endon( #"death_or_disconnect" );
    var_4960ad8045848612 = utility::getstruct( "ee_dempsey_path_1_3", "script_noteworthy" );
    function_c4ee29c73ef1fcd4( var_4960ad8045848612.origin, 0.9 );
    zm_quest::function_d5ef98341fd6a057( [ #"hash_35748cc8737d1f20" ], [ self ] );
    
    if ( !level utility::flag( "ee_dempsey_player_aproach_1st" ) )
    {
        level utility::flag_wait( "ee_dempsey_player_aproach_1st" );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_a441228c07a01103" ], [ self ] );
    }
    
    thread function_60f1468014d292ae( 1 );
    level utility::flag_wait( "stop_dempsey_anguished_thoughts" );
    wait 1.5;
    zm_quest::function_d5ef98341fd6a057( [ #"hash_185512b6f5e2466f" ], [ self ] );
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_e9ee6801a40955e" );
    wait 1;
    zm_quest::function_d5ef98341fd6a057( [ #"hash_185514b6f5e249d5" ], [ self ] );
    level utility::flag_clear( "stop_dempsey_anguished_thoughts" );
    var_7525af8065b12a38 = utility::getstruct( "ee_dempsey_path_2_2", "script_noteworthy" );
    function_c4ee29c73ef1fcd4( var_7525af8065b12a38.origin, 0.95 );
    self playlocalsound( #"hash_680a11192b7a58c4" );
    zm_quest::function_d5ef98341fd6a057( [ #"hash_35748fc8737d2439" ], [ self ] );
    level utility::flag_wait( "ee_dempsey_player_aproach_2nd" );
    weaver_dialog();
    wait 1;
    thread function_60f1468014d292ae( 2 );
    level utility::flag_wait( "stop_dempsey_anguished_thoughts" );
    wait 1.5;
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_f5521d41e914d3a2" );
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_f5521c41e914d1ef" );
    zm_quest::function_d5ef98341fd6a057( [ #"hash_e278e0a10416c460" ], [ self ], 1 );
    level utility::flag_clear( "stop_dempsey_anguished_thoughts" );
    var_6863fe805cfbd5f5 = utility::getstruct( "ee_dempsey_path_3_4", "script_noteworthy" );
    function_c4ee29c73ef1fcd4( var_6863fe805cfbd5f5.origin, 0.9 );
    zm_quest::function_d5ef98341fd6a057( [ #"hash_5231859c3da24e85" ], [ self ] );
    
    if ( !level utility::flag( "ee_dempsey_player_aproach_3rd" ) )
    {
        zm_quest::function_d5ef98341fd6a057( [ #"hash_5231829c3da2496c" ], [ self ] );
    }
    
    level utility::flag_wait( "ee_dempsey_player_aproach_3rd" );
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_1aa9253ac34db4a6" );
    wait 0.5;
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_c59ac25c28984abc" );
    wait 0.5;
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_c59ac55c28984fd5" );
    wait 2;
    thread function_60f1468014d292ae( 3 );
    level utility::flag_wait( "stop_dempsey_anguished_thoughts" );
    wait 2;
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_87233230102f8dfb" );
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_87233330102f8fae" );
    level utility::flag_clear( "stop_dempsey_anguished_thoughts" );
    thread play_transformation();
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_87233430102f9161" );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0x56aaadb8, Offset: 0x1609
// Size: 0x78
function private weaver_dialog()
{
    if ( !level.var_e7624f154d32ca39 )
    {
        return;
    }
    
    level.var_e7624f154d32ca39 endon( #"death" );
    level.var_e7624f154d32ca39 dialogue::say_dialogue( "dx_zm_ffds_ffde_weav_ds2szaln1", [ self ] );
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_472d0c4f06bd9a57" );
    level.var_e7624f154d32ca39 dialogue::say_dialogue( "dx_zm_ffds_ffde_weav_ds2szaln3", [ self ] );
    level.var_e7624f154d32ca39 delete();
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0xbea751b5, Offset: 0x1689
// Size: 0xbc
function private function_7938ae2780b6c1a9()
{
    level endon( #"game_ended" );
    utility::waittill_any( "ee_dempsey_success", "ee_dempsey_fail_time_out", "ee_dempsey_fail_death", "ee_quit_dempsey" );
    
    if ( !level.var_ecdf2ac1463b43f7 )
    {
        return;
    }
    
    foreach ( node in level.var_ecdf2ac1463b43f7 )
    {
        node scene::cleanup( 1 );
    }
    
    level.var_ecdf2ac1463b43f7 = undefined;
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 2, eflags: 0xc
// Checksum 0xbdc89081, Offset: 0x174d
// Size: 0xe7
function private function_8aecabb31a4a9b1( player, b_success )
{
    self notify( #"hash_d5f3ae24b932d880" );
    self endon( #"hash_d5f3ae24b932d880" );
    level endon( #"game_ended" );
    
    if ( !player )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    level.var_48adb603fa373e5a = player;
    s_scene_node = utility::getstruct( "Align_Node_tag_align_dempsey_sq_Node", "script_noteworthy" );
    s_scene_node scene::add_scene_func( s_scene_node, &function_49119fc6f5340249, "callback_play" );
    s_scene_node thread scene::play( [ player ], "outro", "sat_cin_zm_fly_dempsey_sq" );
    outro_length = s_scene_node scene::function_b3c7b792a7a154fa( "outro" );
    player thread function_caf545443688a4c2( 20 + outro_length );
    frametime = 7.659;
    s_scene_node utility::delaythread( frametime, &function_987623e8b5f03a26 );
    return outro_length;
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0xaa58402b, Offset: 0x183d
// Size: 0xcb
function private function_3f9de58378affab6( player )
{
    if ( !player )
    {
        return;
    }
    
    if ( player.interactions_disabled )
    {
        return;
    }
    
    if ( isdefined( level.var_5000c3c1cd028258 ) )
    {
        return;
    }
    
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return;
    }
    
    if ( utility::flag( "ee_dempsey_success" ) )
    {
        return;
    }
    
    if ( utility::flag( "ee_dempsey_in_cd" ) )
    {
        return;
    }
    
    if ( !player is_operator_dempsey() )
    {
        return;
    }
    
    if ( zm_exfil_sat::is_exfil_starting() )
    {
        return;
    }
    
    if ( utility::flag( "ee_zone_enabled" ) )
    {
        return;
    }
    
    zone = zone_manager::get_zone_struct( "zone_dempsey" );
    
    if ( zone.is_enabled )
    {
        return;
    }
    
    level notify( #"dog_tag_found" );
    player.pickup_dog_tag = 1;
    level thread ee_start( player );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 2, eflags: 0x4
// Checksum 0xa503c7af, Offset: 0x1910
// Size: 0x36
function private function_a83d1b634592a8aa( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 2, eflags: 0xc
// Checksum 0x86045655, Offset: 0x194f
// Size: 0x99
function private function_ec810f013ce9dc70( player, var_3cd5bea2a8d3e74 )
{
    self notify( #"hash_de4501463f07b504" );
    self endon( #"hash_de4501463f07b504" );
    level endon( #"game_ended", #"end_timer", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey", #"mid_igc_started", #"warp_to_boss" );
    
    if ( getdvarint( @"hash_8460eb89406c8c79", 0 ) )
    {
        return;
    }
    
    wait var_3cd5bea2a8d3e74;
    level thread ee_end( player, 2 );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0xc
// Checksum 0xfedd98c1, Offset: 0x19f0
// Size: 0x91
function private function_5c150f0f70075281( var_4152716875a1b083 )
{
    self notify( #"hash_b70e79bf12d069ff" );
    self endon( #"hash_b70e79bf12d069ff" );
    level endon( #"game_ended" );
    utility::flag_set( "ee_dempsey_in_cd" );
    level endon( #"ee_dempsey_in_cd" );
    level.dempsey_ee.cd_rounds = zm_utility::get_round_number() + var_4152716875a1b083;
    level waittill( #"clear_ee_dempsey_in_cd" );
    utility::flag_clear( "ee_dempsey_in_cd" );
    level.dempsey_ee.cd_rounds = undefined;
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 5, eflags: 0x4
// Checksum 0x9bafdf0f, Offset: 0x1a89
// Size: 0xc6
function private do_teleport( s_des, fade_time, fade_out = 1, fade_in = 1, wait_time = 1 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( self.isdisconnecting )
    {
        return;
    }
    
    val::set( "teleporting", "ignoreme", 1 );
    
    if ( fade_out )
    {
    }
    
    self predictstreamposuntilcleared( s_des.origin );
    wait wait_time + 1;
    self setorigin( s_des.origin );
    
    if ( fade_in )
    {
    }
    
    val::reset( "teleporting", "ignoreme" );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 3, eflags: 0xc
// Checksum 0xd34dca8, Offset: 0x1b57
// Size: 0x3cb
function private function_ae078525075bf167( var_4b4e6b999024cf0d, b_wait_player, b_hide_orb )
{
    self notify( #"hash_b2d6c34b970c9248" );
    self endon( #"hash_b2d6c34b970c9248" );
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    
    if ( !isdefined( b_hide_orb ) )
    {
        b_hide_orb = 0;
    }
    
    if ( !isdefined( level.var_9422388247d2fdc3 ) )
    {
        v_start_loc = utility::getstruct( level.dempsey_ee.var_d28d9482cfeff43a.target, "targetname" ).origin + ( 0, 0, 70 );
        level.var_9422388247d2fdc3 = utility::spawn_model( "tag_origin", v_start_loc, ( 0, 0, 0 ) );
        level.var_9422388247d2fdc3.fx = spawnscriptable( %"zm_sat_firefly_dmps_ee_wisp", ( 0, 0, 0 ), level.var_9422388247d2fdc3.angles, level.var_9422388247d2fdc3 );
    }
    else
    {
        v_start_loc = level.var_9422388247d2fdc3.origin;
    }
    
    level.var_9422388247d2fdc3 endon( #"death" );
    v_end_loc = var_4b4e6b999024cf0d.origin;
    state = level.var_9422388247d2fdc3.fx getscriptablepartstate( "trail" );
    
    if ( state == "off" )
    {
        level.var_9422388247d2fdc3.fx setscriptablepartstate( "base", "spawn" );
        wait 1;
        level.var_9422388247d2fdc3.fx setscriptablepartstate( "base", "hide" );
        level.var_9422388247d2fdc3.fx setscriptablepartstate( "trail", "on" );
    }
    
    playsoundatpos( level.var_9422388247d2fdc3.origin, #"hash_92ceb7c21253ce83" );
    level.var_9422388247d2fdc3 playloopsound( #"hash_8acb238bee3c5990" );
    n_travel_time = distance( v_start_loc, v_end_loc ) / 200;
    level.var_9422388247d2fdc3 moveto( v_end_loc, n_travel_time, 0.1, 0.1 );
    level.var_9422388247d2fdc3 waittill( #"movedone" );
    
    /#
        b_wait_player = getdvarint( @"hash_caf42acfdba7ba97", 0 ) == 1 ? 0 : b_wait_player;
    #/
    
    if ( b_wait_player )
    {
        while ( true )
        {
            if ( !level.var_9422388247d2fdc3 || !level.var_5000c3c1cd028258 )
            {
                return;
            }
            
            if ( distance( level.var_9422388247d2fdc3.origin, level.var_5000c3c1cd028258.origin ) <= 500 && level.var_5000c3c1cd028258 trace::can_see_origin( level.var_9422388247d2fdc3.origin, 0, undefined, undefined, 0 ) )
            {
                break;
            }
            
            wait 0.1;
        }
    }
    
    if ( b_hide_orb )
    {
        playsoundatpos( level.var_9422388247d2fdc3.origin, #"hash_567799dd736a6842" );
        level.var_9422388247d2fdc3.fx setscriptablepartstate( "base", "despawn" );
        waitframe();
        level.var_9422388247d2fdc3.fx setscriptablepartstate( "trail", "off" );
        wait 1;
        level.var_9422388247d2fdc3.fx setscriptablepartstate( "base", "hide" );
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 2, eflags: 0x4
// Checksum 0x736364ad, Offset: 0x1f2a
// Size: 0xae
function private approach_watcher( s_des, suffix = "" )
{
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    
    if ( !self )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    self endon( #"death_or_disconnect" );
    
    while ( isdefined( self ) )
    {
        if ( distance( s_des.origin, self.origin ) < 300 )
        {
            level utility::flag_set( "ee_dempsey_player_aproach" + suffix );
            return;
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 3, eflags: 0x4
// Checksum 0x67b73e69, Offset: 0x1fe0
// Size: 0x2da
function private function_9464570ccdf080fd( var_6469c1e4d3ac4060, var_909487a97fce4608, n_difficulty_modifier )
{
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    
    if ( !isdefined( level.var_ff46eb8f8b48e51e ) )
    {
        level.var_ff46eb8f8b48e51e = [];
    }
    
    a_s_spawners = utility::getstructarray( var_6469c1e4d3ac4060.target, "targetname" );
    
    foreach ( spawner in a_s_spawners )
    {
        if ( spawner.script_int && int( spawner.script_int ) == var_909487a97fce4608 )
        {
            wait randomfloatrange( 0.1, 0.7 );
            agent = agent_manager::spawn_agent( spawner.script_label, spawner.origin );
            
            if ( !agent )
            {
                continue;
            }
            
            agent val::set( "ee_dempsey", "ignore_cleanup", 1 );
            agent.no_powerups = 1;
            agent.var_7ee152b43c7188e1 = 1;
            agent.var_a13bed1ac47e1b2c = 1;
            agent.ignore_enemy_count = 1;
            agent.var_eb92c31552620100 = 1;
            agent val::set( "ee_dempsey", "show_healthbar", 0 );
            
            /#
                if ( getdvarint( @"hash_d7aaef916a6664a6", 0 ) == 1 )
                {
                    agent val::set( "<dev string:x49>", "<dev string:x54>", 1 );
                }
            #/
            
            agent val::set( "ee_dempsey", "allow_dismember", 0 );
            agent zombie_utils::function_dfae6a5bd222c586( &function_e1d01fbd58de8041 );
            agent thread zone_spawner::function_ce10e453e7f7bb8e( spawner, spawner.origin );
            var_49f7091014d2c59 = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( spawner.origin );
            agent zombie_utils::set_zombie_round_difficulty( var_49f7091014d2c59 + n_difficulty_modifier );
            agent zombie_utils::function_a8ce00e0448cb6f0( "run", "dempsey_ee", 6 );
            agent thread function_ee95d57c246635af();
            
            if ( !isdefined( level.var_ff46eb8f8b48e51e ) )
            {
                level.var_ff46eb8f8b48e51e = [];
            }
            
            level.var_ff46eb8f8b48e51e[ level.var_ff46eb8f8b48e51e.size ] = agent;
        }
        
        waitframe();
    }
    
    while ( level.var_ff46eb8f8b48e51e.size > 0 )
    {
        level.var_ff46eb8f8b48e51e = function_46f9072493651dc9( level.var_ff46eb8f8b48e51e );
        waitframe();
    }
    
    if ( level utility::flag( "final_zombies" ) )
    {
        level utility::flag_clear( "final_zombies" );
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0x7c3ae927, Offset: 0x22c2
// Size: 0x84
function private function_ee95d57c246635af()
{
    self endon( #"death" );
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    
    while ( true )
    {
        if ( self._blackboard && self._blackboard.var_ea5eb773cb969ee1 )
        {
            level.var_ff46eb8f8b48e51e = arrayremove( level.var_ff46eb8f8b48e51e, self );
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0x51d74d8d, Offset: 0x234e
// Size: 0x25
function private function_e1d01fbd58de8041( params )
{
    params.var_d20799805edf0194 = 1;
    return params.idamage;
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0xc
// Checksum 0xd3885ff4, Offset: 0x237c
// Size: 0x316
function private ee_start( player )
{
    self notify( #"hash_ed262864e0780708" );
    self endon( #"hash_ed262864e0780708" );
    
    if ( !player )
    {
        assertmsg( "<dev string:x63>" );
        return;
    }
    
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    player endon( #"death_or_disconnect" );
    level.var_5000c3c1cd028258 = player;
    level.var_48adb603fa373e5a = undefined;
    
    if ( player.allyeuropa )
    {
        player.allyeuropa utility::callsharedfunc( #"europa", #"hash_461d60a67b99be95" );
        player.allyeuropa utility::callsharedfunc( #"europa", #"hash_128edca9c946949c" );
    }
    
    if ( player.ismutantinjection || player.mutantinjectiontransformed )
    {
        player thread mutant_injection_utility::function_6fa2b0b46d2abcf7( 1 );
    }
    
    level utility::flag_set( "progressing_dmps_ee" );
    player notify( #"progressing_dmps_ee" );
    player val::set( "dmps_ee_intro", "ignoreme", 1 );
    player val::set( "dmps_ee_hud", "show_hud", 0 );
    player val::set( "dmps_ee", "killstreaks", 0 );
    player val::set( "dmps_ee", "round_spawning_ignore_player", 1 );
    player val::set( "dmps_ee", "allow_battlechatter_vo", 0 );
    player val::set( "dmps_ee", "show_compass", 0 );
    player player::hideminimap( 1 );
    namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 1 );
    player.w_current = player getcurrentweapon();
    player playlocalsound( #"hash_3c3bb4ecbf5b07d1" );
    level musicbank_utility::function_5aca66c390aa347d( player, #"dmps_ee" );
    level.dempsey_ee.e_dog_tag utility::function_7c10ea82c1e305b8( "base", "hide" );
    player inventory_utility::givegunlessweapon();
    level thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 0, 1 );
    s_scene_node = utility::getstruct( "Align_Node_tag_align_dempsey_sq_Node", "script_noteworthy" );
    player predictstreamposuntilcleared( s_scene_node.origin );
    s_scene_node thread scene::play( [ player ], "intro", "sat_cin_zm_fly_dempsey_sq" );
    var_260d27bd8f3f0772 = s_scene_node scene::function_b3c7b792a7a154fa( "intro" );
    n_vo_delay = 5.5;
    wait n_vo_delay;
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_5d6e9f86c3812a93" );
    wait var_260d27bd8f3f0772 - n_vo_delay - 0.1;
    player inventory_utility::takegunlessweapon( player.w_current );
    level utility::flag_set( "ee_zone_enabled" );
    zone_manager::set_zone_enabled( "zone_dempsey", 1 );
    zm_quest::function_d7216beb89a22329();
    player.var_dd8181302015d608 = 1;
    player.b_ignore_powerups = 1;
    player start_transition();
    level thread progress_watcher( player );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 2, eflags: 0xc
// Checksum 0xcaba62e0, Offset: 0x269a
// Size: 0x2c4
function private ee_end( player, var_a434aa2bbfdadfea )
{
    self notify( #"hash_80da323e47baa656" );
    self endon( #"hash_80da323e47baa656" );
    
    if ( var_a434aa2bbfdadfea == 2 )
    {
        namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 1 );
    }
    
    clean_ee();
    
    if ( !player || player.isdisconnecting )
    {
        level thread function_f665ad8b0558bc79();
        level notify( #"ee_quit_dempsey" );
        return;
    }
    
    player endon( #"death_or_disconnect" );
    player.var_dd8181302015d608 = 0;
    player.b_ignore_powerups = undefined;
    player.var_a327dbacf3205a5f = undefined;
    player clearclienttriggeraudiozone( 5 );
    player val::reset_all( "dmps_ee" );
    zm_quest::function_d04a18ed4295a8cd();
    player player::showminimap();
    level musicbank_utility::function_4f253fd35ec68cbc( player, #"dmps_ee" );
    player thread mutant_injection_utility::function_6fa2b0b46d2abcf7( 1 );
    player playlocalsound( #"hash_528238f734971bd2" );
    player val::set( "dempsey_scene_end", "allow_battlechatter_vo", 0 );
    player val::set( "dempsey_scene_end", "ignore_playable_area_check", 1 );
    
    switch ( var_a434aa2bbfdadfea )
    {
        case 1:
            player do_teleport( level.dempsey_ee.var_d28d9482cfeff43a, 1, 1, 1, 3 );
            level utility::flag_set( "ee_dempsey_success" );
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"dmps_ee_done", 1 );
            player function_37e122b643059d9();
            break;
        case 2:
            level notify( #"ee_dempsey_fail_time_out" );
            player do_teleport( level.dempsey_ee.var_d28d9482cfeff43a, 1, 1, 1, 3 );
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"dmps_ee_done", 1 );
            level thread function_5c150f0f70075281( getdvarint( @"hash_fc0619bb07377c04", 3 ) );
            break;
        case 3:
            level notify( #"ee_dempsey_fail_death" );
            zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"dmps_ee_done", 1 );
            level thread function_5c150f0f70075281( getdvarint( @"hash_fc0619bb07377c04", 3 ) );
            break;
        case 4:
        default:
            level notify( #"ee_quit_dempsey" );
            break;
    }
    
    player setclientomnvar( "ui_zm_is_bear_attack_quest", 0 );
    player setclientomnvar( "ui_zm_is_bear_attack_quest_show_loadout", 0 );
    player function_41fdcd23019ab260( var_a434aa2bbfdadfea );
    player val::reset( "dmps_ee_hud", "show_hud" );
    player function_fb13b9f3784f1e69( var_a434aa2bbfdadfea );
    level thread function_f665ad8b0558bc79();
    player clearpredictedstreampos();
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0xd72c5cf6, Offset: 0x2966
// Size: 0x178
function private clean_ee()
{
    level.var_5000c3c1cd028258 = undefined;
    level utility::flag_clear( "progressing_dmps_ee" );
    level utility::flag_clear( "ee_dempsey_player_aproach_1st" );
    level utility::flag_clear( "ee_dempsey_player_aproach_2nd" );
    level utility::flag_clear( "ee_dempsey_player_aproach_3rd" );
    level utility::flag_clear( "stop_dempsey_anguished_thoughts" );
    level utility::flag_clear( "weaver_zombie" );
    level utility::flag_clear( "final_zombies" );
    level utility::flag_clear( "ee_zone_enabled" );
    
    if ( level.var_9422388247d2fdc3.fx )
    {
        level.var_9422388247d2fdc3.fx freescriptable();
        level.var_9422388247d2fdc3.fx = undefined;
    }
    
    if ( level.var_9422388247d2fdc3 )
    {
        level.var_9422388247d2fdc3 delete();
        level.var_9422388247d2fdc3 = undefined;
    }
    
    foreach ( zombie in level.var_ff46eb8f8b48e51e )
    {
        if ( zombie && isalive( zombie ) )
        {
            zombie thread function_44f5bec4abb163f1();
        }
    }
    
    level.var_ff46eb8f8b48e51e = undefined;
    zone_manager::set_zone_enabled( "zone_dempsey", 0 );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0xc
// Checksum 0x50482b87, Offset: 0x2ae6
// Size: 0x146
function private function_41fdcd23019ab260( var_a434aa2bbfdadfea )
{
    self notify( #"hash_74997cbbfadec1f6" );
    self endon( #"hash_74997cbbfadec1f6" );
    player = self;
    
    if ( !player || player.isdisconnecting )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    
    if ( var_a434aa2bbfdadfea == 2 )
    {
        level thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 0, 1 );
    }
    else
    {
        level thread utility::fadetoblackforplayerkeepui( player, 0, 1 );
    }
    
    switch ( var_a434aa2bbfdadfea )
    {
        case 1:
        case 2:
            n_time = 3;
            scene_length = function_8aecabb31a4a9b1( player );
            
            if ( scene_length )
            {
                wait scene_length - n_time;
            }
            
            if ( var_a434aa2bbfdadfea == 2 )
            {
                level thread zm_quest::function_d5ef98341fd6a057( [ #"dempsey_fail" ], [ player ] );
            }
            
            wait n_time;
            player val::reset_all( "dempsey_scene_end" );
            player function_17a61640a7d3926f();
            break;
        case 3:
            player val::reset_all( "dempsey_scene_end" );
            player function_17a61640a7d3926f();
            break;
        case 4:
        default:
            break;
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0xc
// Checksum 0x3a0dca3b, Offset: 0x2c34
// Size: 0xf5
function private function_fb13b9f3784f1e69( var_a434aa2bbfdadfea )
{
    self notify( #"hash_811adc71dc62ec1f" );
    self endon( #"hash_811adc71dc62ec1f" );
    player = self;
    
    if ( !player || player.isdisconnecting )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    
    switch ( var_a434aa2bbfdadfea )
    {
        case 1:
            player thread drop_reward( "zm_round_reward_bundle_dmps_ee_rewards" );
            player.is_dempsey_speaking = 1;
            zm_quest::function_d5ef98341fd6a057( [ #"hash_af268a0605c0e692" ], [ player ] );
            player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_de957fa188ad8e22" );
            player.is_dempsey_speaking = undefined;
            break;
        case 2:
        case 3:
        case 4:
        default:
            break;
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0x5241899a, Offset: 0x2d31
// Size: 0x80
function private function_37e122b643059d9()
{
    params = spawnstruct();
    params.timestamp = gettime();
    params.questname = #"zm_sat_firefly_dmps_ee";
    params.var_be82617e5e8087bd = [ self ];
    params.event = #"zm_sq_quest_complete";
    level callback::callback( #"hash_6c71d319dc089c27", params );
    level callback::callback( "zm_sq_quest_complete", params );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0x6f95bcf1, Offset: 0x2db9
// Size: 0x1a
function private function_44f5bec4abb163f1()
{
    self endon( #"death" );
    wait 2.5;
    self kill();
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0x61c3193a, Offset: 0x2ddb
// Size: 0x55
function private function_f665ad8b0558bc79()
{
    level endon( #"game_ended" );
    level waittill( #"on_round_start" );
    
    if ( level.dempsey_ee.e_dog_tag )
    {
        level.dempsey_ee.e_dog_tag utility::function_7c10ea82c1e305b8( "base", "init" );
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0xcd29cf04, Offset: 0x2e38
// Size: 0x563
function private set_scene( str_scene_kvp )
{
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    s_scene_node = utility::getstruct( str_scene_kvp, "targetname" );
    
    if ( !isdefined( level.var_ecdf2ac1463b43f7 ) )
    {
        level.var_ecdf2ac1463b43f7 = [];
    }
    
    level.var_ecdf2ac1463b43f7[ level.var_ecdf2ac1463b43f7.size ] = s_scene_node;
    
    switch ( str_scene_kvp )
    {
        case #"hash_5e996d81c2d545a0":
            s_scene_node scene::init();
            s_scene_node thread scene::play( undefined, "action" );
            a_zombies = s_scene_node scene::get_entities();
            waitframe();
            
            foreach ( agent in a_zombies )
            {
                agent.b_ignore_death_perception = 1;
            }
            
            set_scene_zombies( a_zombies );
            function_96db24296f6da7e8( a_zombies, 1 );
            level waittill( #"ee_dempsey_player_aproach_1st" );
            
            if ( !isdefined( level.var_ff46eb8f8b48e51e ) )
            {
                level.var_ff46eb8f8b48e51e = [];
            }
            
            level.var_ff46eb8f8b48e51e[ level.var_ff46eb8f8b48e51e.size ] = a_zombies;
            level.var_ff46eb8f8b48e51e = function_46f9072493651dc9( level.var_ff46eb8f8b48e51e );
            function_96db24296f6da7e8( a_zombies, 0 );
            break;
        case #"hash_685bc681c89071a0":
            s_scene_node scene::init();
            s_scene_node thread scene::play( undefined, "looping_idle" );
            a_zombies = s_scene_node scene::get_entities();
            waitframe();
            
            foreach ( zombie in a_zombies )
            {
                zombie val::set( "ee_dempsey", "allow_dismember", 0 );
                var_49f7091014d2c59 = zm_utility::get_round_number();
                zombie zombie_utils::set_zombie_round_difficulty( var_49f7091014d2c59 + 15 );
                zombie zombie_utils::function_a8ce00e0448cb6f0( "walk", "dempsey_ee", 6 );
                level.var_e7624f154d32ca39 = utility::spawn_model( "tag_origin", zombie gettagorigin( "j_head" ) );
                level.var_e7624f154d32ca39 linkto( zombie, "j_head" );
            }
            
            set_scene_zombies( a_zombies );
            function_96db24296f6da7e8( a_zombies, 1 );
            level waittill( #"ee_dempsey_player_aproach_2nd" );
            
            if ( !isdefined( level.var_ff46eb8f8b48e51e ) )
            {
                level.var_ff46eb8f8b48e51e = [];
            }
            
            level.var_ff46eb8f8b48e51e[ level.var_ff46eb8f8b48e51e.size ] = a_zombies;
            level.var_ff46eb8f8b48e51e = function_46f9072493651dc9( level.var_ff46eb8f8b48e51e );
            function_96db24296f6da7e8( a_zombies, 0 );
            s_scene_node thread scene::play( undefined, "action_forward" );
            level utility::flag_set( "weaver_zombie" );
            break;
        case #"hash_6f7f3181cc3b4653":
            s_scene_node scene::init();
            s_scene_node thread scene::play( undefined, "looping_idle" );
            a_zombies = s_scene_node scene::get_entities();
            waitframe();
            set_scene_zombies( a_zombies );
            function_96db24296f6da7e8( a_zombies, 1 );
            eaten_zombie = s_scene_node scene::get_entity( "Actor 3" );
            
            if ( eaten_zombie )
            {
                eaten_zombie endon( #"death" );
            }
            
            level waittill( #"ee_dempsey_player_aproach_3rd" );
            
            if ( !isdefined( level.var_ff46eb8f8b48e51e ) )
            {
                level.var_ff46eb8f8b48e51e = [];
            }
            
            level.var_ff46eb8f8b48e51e[ level.var_ff46eb8f8b48e51e.size ] = s_scene_node scene::get_entity( "Actor 1" );
            
            if ( !isdefined( level.var_ff46eb8f8b48e51e ) )
            {
                level.var_ff46eb8f8b48e51e = [];
            }
            
            level.var_ff46eb8f8b48e51e[ level.var_ff46eb8f8b48e51e.size ] = s_scene_node scene::get_entity( "Actor 2" );
            level.var_ff46eb8f8b48e51e = function_46f9072493651dc9( level.var_ff46eb8f8b48e51e );
            function_96db24296f6da7e8( a_zombies, 0 );
            s_scene_node thread scene::play( undefined, "action" );
            s_length = s_scene_node scene::function_b3c7b792a7a154fa( "action" );
            wait s_length;
            
            if ( eaten_zombie )
            {
                eaten_zombie utility::ent_flag_set( "anim_ended" );
                eaten_zombie notify( #"anim_ended" );
                eaten_zombie.b_cleanup_no_respawn = 1;
                eaten_zombie.var_f654ebe2aeab29f7 = 1;
                eaten_zombie.noragdoll = 1;
                eaten_zombie.disabledeathorient = 1;
                eaten_zombie.var_fd5c989cd241b6c4 = 1;
                eaten_zombie val::set( "ee_dempsey", "allow_dismember", 0 );
                eaten_zombie val::set_allow_death( 1 );
                eaten_zombie setcandamage( 1 );
                
                if ( !isdefined( source_pos ) )
                {
                    source_pos = eaten_zombie.origin;
                }
                
                eaten_zombie dodamage( eaten_zombie.health, source_pos );
            }
            
            break;
    }
    
    /#
        while ( true )
        {
            sphere( s_scene_node.origin, 10, ( 1, 0, 0 ) );
            waitframe();
        }
    #/
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0x36ea7d3f, Offset: 0x33a3
// Size: 0xf6
function private set_scene_zombies( a_agents )
{
    foreach ( zombie in a_agents )
    {
        if ( isalive( zombie ) )
        {
            zombie.var_a13bed1ac47e1b2c = 1;
            zombie.ignore_enemy_count = 1;
            zombie.var_eb92c31552620100 = 1;
            zombie val::set( "ee_dempsey", "show_healthbar", 0 );
            
            /#
                if ( getdvarint( @"hash_d7aaef916a6664a6", 0 ) == 1 )
                {
                    zombie val::set( "<dev string:x49>", "<dev string:x54>", 1 );
                }
            #/
            
            zombie zombie_utils::function_dfae6a5bd222c586( &function_e1d01fbd58de8041 );
        }
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 2, eflags: 0x4
// Checksum 0x49b31be1, Offset: 0x34a1
// Size: 0x95
function private function_96db24296f6da7e8( a_agents, var_94d1ab5da995e573 )
{
    foreach ( zombie in a_agents )
    {
        if ( isalive( zombie ) )
        {
            zombie.var_2fc3a5fb762afb6e = var_94d1ab5da995e573;
        }
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0x5df51b58, Offset: 0x353e
// Size: 0x4a
function private ending_fx()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    playfx( level._effect[ "ee_dempsey_confetti" ], self gettagorigin( "tag_eye" ) + anglestoforward( self gettagangles( "tag_eye" ) ) * 50 );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0x70d585f8, Offset: 0x3590
// Size: 0x4c
function private set_screen_fx( b_is_on )
{
    if ( b_is_on )
    {
        utility::function_32b24db3127bff40( "dempsey_ee_fog", "on" );
        pbgpostfxbundlestart( self, "cer_hallucination_fungal" );
        return;
    }
    
    utility::function_32b24db3127bff40( "dempsey_ee_fog", "off" );
    pbgpostfxbundleend( self, "cer_hallucination_fungal" );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0xb4843f7f, Offset: 0x35e4
// Size: 0xc6
function private drop_reward( var_b8179de1b304a395 )
{
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( var_b8179de1b304a395, "Default" );
    s_loc = utility::getstruct( "ee_dempsey_reward", "script_noteworthy" );
    var_21c3b67f1a74cd8e = getclosestpointonnavmesh( s_loc.origin );
    
    if ( !isdefined( var_21c3b67f1a74cd8e ) )
    {
        var_21c3b67f1a74cd8e = s_loc.origin;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( var_21c3b67f1a74cd8e );
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        itemspawnentryname = var_8b5270de14dff72e[ i ];
        spawneditems = common_item::function_61c2c0251e742ffd( itemspawnentryname, undefined, spawnoptions );
        spawneditems.var_86918c8abfcc1332 = 1;
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0xc0db6708, Offset: 0x36b2
// Size: 0xf0
function private function_60f1468014d292ae( n_seq )
{
    level endon( #"stop_dempsey_anguished_thoughts", #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    self endon( #"death_or_disconnect" );
    a_n_indices = function_969ac5856f00b60d( 16 );
    
    while ( true )
    {
        n_index = utility::array_random( a_n_indices );
        str_sfx = "sfx_zm_ffds_ffde_ambr_ds" + n_seq + "dat_" + n_index;
        str_dx = "dx_zm_ffds_ffde_ambr_ds" + n_seq + "dat_" + n_index;
        thread function_5fba8481290677a( str_sfx );
        dialogue::say_dialogue( str_dx, [ self ] );
        a_n_indices = arrayremove( a_n_indices, n_index );
        
        if ( !a_n_indices.size )
        {
            a_n_indices = function_969ac5856f00b60d( 16 );
        }
        
        wait randomintrange( 3, 7 );
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0x6281922, Offset: 0x37aa
// Size: 0xd5
function private function_e7758575f2df091d()
{
    level endon( #"stop_dempsey_anguished_thoughts", #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    self endon( #"death_or_disconnect" );
    n_index = utility::array_random( level.var_dd91b52f035361f1 );
    str_sfx = "sfx_zm_ffds_ffde_ambr_dsatr_" + n_index;
    str_dx = "dx_zm_ffds_ffde_ambr_dsatr_" + n_index;
    thread function_5fba8481290677a( str_sfx );
    dialogue::say_dialogue( str_dx, [ self ] );
    level.var_dd91b52f035361f1 = arrayremove( level.var_dd91b52f035361f1, n_index );
    
    if ( !level.var_dd91b52f035361f1.size )
    {
        level.var_dd91b52f035361f1 = function_969ac5856f00b60d( 12 );
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0x98187118, Offset: 0x3887
// Size: 0x3d
function private function_969ac5856f00b60d( var_326c2749985b05d0 )
{
    a_n_indices = [];
    
    for ( i = 0; i < var_326c2749985b05d0 ; i++ )
    {
        a_n_indices[ i ] = i + 1;
    }
    
    return a_n_indices;
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0x42cee546, Offset: 0x38cd
// Size: 0x2f7
function private start_transition()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    var_cd334f10192877a1 = utility::getstruct( "ee_transition_start_loc", "script_noteworthy" );
    s_end_loc = utility::getstruct( "ee_transition_end_loc", "script_noteworthy" );
    s_teleport_loc = utility::getstruct( level.dempsey_ee.var_d28d9482cfeff43a.target, "targetname" );
    ent_mover = utility::spawn_model( "tag_origin", var_cd334f10192877a1.origin, var_cd334f10192877a1.angles );
    var_15598453bb30f76e = self getcamerathirdperson();
    
    if ( var_15598453bb30f76e )
    {
        self.var_15598453bb30f76e = 1;
        self setcamerathirdperson( 0 );
        self setclientomnvar( "ui_toggle_third_person", 0 );
    }
    
    val::set( "ee_dempsey_transition", "allow_toggle_third_person", 0 );
    thread white_screen_flash( 0.5, 0.3 );
    self predictstreamposuntilcleared( s_teleport_loc.origin );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    val::set( "ee_dempsey_transition", "freezecontrols", 1 );
    val::set( "ee_dempsey_transition", "ignoreme", 1 );
    val::set( "ee_dempsey_transition", "weapon", 0 );
    self setorigin( var_cd334f10192877a1.origin );
    self setplayerangles( var_cd334f10192877a1.angles );
    set_screen_fx( 1 );
    self playerlinktodelta( ent_mover, "tag_origin", 1, 0, 0, 0, 0, 1, 1 );
    n_time = 15;
    
    if ( getdvarint( @"hash_14f3536b13814af4", 0 ) == 1 )
    {
        level childthread zm_quest::function_d5ef98341fd6a057( [ #"dempsey_teleport" ], [ self ] );
    }
    else
    {
        ent_mover childthread function_896856e10720e616( s_end_loc, n_time );
        ent_mover childthread function_11d37aa3f7bb6a56();
        level childthread zm_quest::function_d5ef98341fd6a057( [ #"dempsey_teleport" ], [ self ] );
        wait n_time - 3;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setclienttriggeraudiozone( "zm_sat_firefly_dmps", 1 );
    thread white_screen_flash( 0.5, 0.3 );
    wait 0.6;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self unlink();
    ent_mover delete();
    self setorigin( s_teleport_loc.origin );
    self setplayerangles( s_teleport_loc.angles );
    set_screen_fx( 0 );
    val::reset_all( "ee_dempsey_transition" );
    
    if ( self.var_15598453bb30f76e )
    {
        self setcamerathirdperson( 1 );
        self setclientomnvar( "ui_toggle_third_person", 1 );
    }
    
    self switchtoweapon( self.w_current );
    self setclientomnvar( "ui_zm_is_bear_attack_quest", 1 );
    self setclientomnvar( "ui_zm_is_bear_attack_quest_show_loadout", 0 );
    val::reset_all( "dmps_ee_intro" );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 2, eflags: 0x4
// Checksum 0x8256a3ed, Offset: 0x3bcc
// Size: 0x66
function private function_896856e10720e616( s_des, n_time )
{
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    self endon( #"death_or_disconnect" );
    self moveto( s_des.origin, n_time, 0, 0 );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0x4e0af25c, Offset: 0x3c3a
// Size: 0x60
function private function_11d37aa3f7bb6a56()
{
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self rotateby( ( 0, 0, 360 ), 5, 0, 0 );
        wait 5;
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 2, eflags: 0x4
// Checksum 0x9650f8f, Offset: 0x3ca2
// Size: 0x1ca
function private white_screen_flash( n_fade_duration, n_hold_duration )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay = newclienthudelem( self );
        self.white_screen_overlay.x = 0;
        self.white_screen_overlay.y = 0;
        self.white_screen_overlay setshader( "white", 640, 480 );
        self.white_screen_overlay.alignx = "left";
        self.white_screen_overlay.aligny = "top";
        self.white_screen_overlay.sort = 1;
        self.white_screen_overlay.horzalign = "fullscreen";
        self.white_screen_overlay.vertalign = "fullscreen";
        self.white_screen_overlay.alpha = 0;
        self.white_screen_overlay.foreground = 1;
        self.white_screen_overlay.archived = 0;
    }
    
    var_24c3037417857a23 = n_fade_duration;
    n_target_alpha = 0.9;
    self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
    self.white_screen_overlay.alpha = n_target_alpha;
    wait var_24c3037417857a23;
    wait n_hold_duration;
    var_24c3037417857a23 = n_fade_duration;
    self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
    self.white_screen_overlay.alpha = 0;
    wait var_24c3037417857a23;
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay destroy();
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0xd9574ee4, Offset: 0x3e74
// Size: 0x22
function private function_b1a70274e9508a18( params )
{
    if ( !function_7229621b069b3b88() )
    {
        return;
    }
    
    self.var_bf82e408b7a0e3c3 = 1;
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0x6820949, Offset: 0x3e9e
// Size: 0x21
function private on_player_disconnect( params )
{
    if ( !function_7229621b069b3b88() )
    {
        return;
    }
    
    thread ee_end( self, 4 );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0xda25fd27, Offset: 0x3ec7
// Size: 0x21
function private on_player_death( params )
{
    if ( !function_7229621b069b3b88() )
    {
        return;
    }
    
    thread ee_end( self, 3 );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0xda8e3cfe, Offset: 0x3ef0
// Size: 0x5a
function private on_round_start( params )
{
    if ( utility::flag( "ee_dempsey_in_cd" ) && level.dempsey_ee.cd_rounds )
    {
        if ( zm_utility::get_round_number() >= level.dempsey_ee.cd_rounds )
        {
            level notify( #"clear_ee_dempsey_in_cd" );
        }
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0x6d0b0cbf, Offset: 0x3f52
// Size: 0x98
function private get_path_node( target )
{
    var_5fa90f1a51250bbf = utility::getstructarray( target );
    
    foreach ( struct in var_5fa90f1a51250bbf )
    {
        if ( struct.script_noteworthy )
        {
            return struct;
        }
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0x40d5ad34, Offset: 0x3ff2
// Size: 0x2e
function private function_caf545443688a4c2( seconds )
{
    val::set( "dempsey_ee_end", "ignoreme", 1 );
    wait seconds;
    val::reset_all( "dempsey_ee_end" );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0xf472d09, Offset: 0x4028
// Size: 0x114
function private play_transformation()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    owner = self;
    
    if ( !isplayer( owner ) )
    {
        owner = level.players[ 0 ];
    }
    
    if ( !isalive( owner ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( !owner isswitchingweapon() )
        {
            break;
        }
        
        waitframe();
    }
    
    owner setclientomnvar( "ui_zm_is_bear_attack_quest", 0 );
    owner setclientomnvar( "ui_zm_is_bear_attack_quest_show_loadout", 0 );
    owner.var_a327dbacf3205a5f = 1;
    owner val::reset( "dmps_ee", "killstreaks" );
    waitframe();
    owner.var_ba48bc54830dd78e = owner killstreaks::getkillstreakinslot( 1 );
    struct = killstreaks::createstreakitemstruct( "zm_dinj" );
    struct.skipdeployanimation = 1;
    result = owner killstreaks::triggerkillstreak( struct );
    owner thread function_6cbd2d134fabe092();
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0xc
// Checksum 0x936a435d, Offset: 0x4144
// Size: 0x95
function private function_6cbd2d134fabe092()
{
    self notify( #"hash_eb4ab417b1673d" );
    self endon( #"hash_eb4ab417b1673d" );
    player = self;
    player endon( #"death_or_disconnect", #"mutant_injection_time_out", #"mutantinjection_end", #"mutantinjection_exit" );
    level endon( #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
    overtime_per_frame = 50;
    
    while ( true )
    {
        player mutant_injection_utility::function_d56f1bba158cb4d6( overtime_per_frame );
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 1, eflags: 0x4
// Checksum 0xcd95877, Offset: 0x41e1
// Size: 0xb8
function private function_5fba8481290677a( alias )
{
    offset = [ ( 500, 0, 75 ), ( 250, 433, 75 ), ( -250, 433, 75 ), ( -500, 0, 75 ), ( -250, -433, 75 ), ( 250, -433, 75 ) ];
    
    for ( i = 0; i < offset.size ; i++ )
    {
        pos = self.origin + offset[ i ];
        playsoundatpos( pos, alias );
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0xe1be5da8, Offset: 0x42a1
// Size: 0x41
function private function_17a61640a7d3926f()
{
    self endon( #"death_or_disconnect" );
    
    if ( !utility::ent_flag( "dmp_loadout_saved" ) )
    {
        return;
    }
    
    utility::ent_flag_clear( "dmp_loadout_saved" );
    zm_utility::function_663d59490abc834f();
    laststand::function_39844c1e879cc048( self.n_self_revive );
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 2, eflags: 0x4
// Checksum 0xd4328bac, Offset: 0x42ea
// Size: 0x70
function private function_c4ee29c73ef1fcd4( v_org, n_ratio )
{
    self endon( #"death" );
    var_d7c46baae2850093 = distance2dsquared( self.origin, v_org );
    var_c8ccda235b30ec79 = var_d7c46baae2850093 * n_ratio;
    
    while ( true )
    {
        if ( distance2dsquared( self.origin, v_org ) <= var_c8ccda235b30ec79 )
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0x741c3e03, Offset: 0x4362
// Size: 0x23, Type: bool
function private is_operator_dempsey()
{
    return zm_quest::function_d80df37d3fe931dc() == "dempsey" || getdvarint( @"hash_415e548698e38b4d", 0 ) == 1;
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0x4
// Checksum 0xa2814bb, Offset: 0x438e
// Size: 0x1c, Type: bool
function private function_7229621b069b3b88()
{
    if ( !level.var_5000c3c1cd028258 )
    {
        return false;
    }
    
    return level.var_5000c3c1cd028258 == self;
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0xc
// Checksum 0xc5006c4e, Offset: 0x43b3
// Size: 0x106
function private function_49119fc6f5340249()
{
    self notify( #"hash_f270e30ca87928b6" );
    self endon( #"hash_f270e30ca87928b6" );
    level endon( #"game_ended" );
    
    if ( !level.var_48adb603fa373e5a || !level.var_48adb603fa373e5a isconnected() )
    {
        return;
    }
    
    level.var_48adb603fa373e5a endon( #"death_or_disconnect" );
    var_bbdfe3566471fc4f = scene::get_entity( "Prop 1" );
    
    foreach ( player in level.players )
    {
        if ( level.var_48adb603fa373e5a != player )
        {
            level.var_48adb603fa373e5a hidefromplayer( player );
            var_bbdfe3566471fc4f hidefromplayer( player );
        }
    }
}

// Namespace zm_sat_firefly_script_dmps_ee
// Params 0, eflags: 0xc
// Checksum 0xd259d889, Offset: 0x44c1
// Size: 0x155
function private function_987623e8b5f03a26()
{
    self notify( #"hash_8ba6605c54c5b9c0" );
    self endon( #"hash_8ba6605c54c5b9c0" );
    level endon( #"game_ended" );
    scene::cleanup( 1 );
    
    if ( !level.var_48adb603fa373e5a || !level.var_48adb603fa373e5a isconnected() )
    {
        return;
    }
    
    outro_player = level.var_48adb603fa373e5a;
    level.var_48adb603fa373e5a = undefined;
    outro_player endon( #"death_or_disconnect" );
    player_position = outro_player getorigin();
    player_angle = outro_player getplayerangles();
    player_forward = anglestoforward( player_angle );
    var_f969f0d8df1cfda5 = anglestoup( player_angle );
    
    foreach ( player in level.players )
    {
        if ( outro_player == player )
        {
            continue;
        }
        
        outro_player showtoplayer( player );
        playfx( level._effect[ "ee_dempsey_outro_teleport" ], player_position, player_forward, var_f969f0d8df1cfda5, player );
    }
}

/#

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0xc845ba3a, Offset: 0x461e
    // Size: 0x232, Type: dev
    function private setup_dmps_ee_devgui()
    {
        level utility::flag_wait( "<dev string:x85>" );
        waitframe();
        player = level.players[ 0 ];
        str_name = player.name;
        devgui::function_9082edeb5db93280( "<dev string:x9a>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xac>", "<dev string:xb5>" + str_name, &dev_ee_start );
        devgui::function_cd4e263c1f3018ae( "<dev string:xbf>", "<dev string:xe7>" + "<dev string:xf7>", &function_7885afad3c985d03 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x111>", "<dev string:xe7>" + "<dev string:x139>", &function_7885afad3c985d03 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x153>", "<dev string:xe7>" + "<dev string:x17b>", &function_7885afad3c985d03 );
        devgui::add_devgui_func( "<dev string:x195>", "<dev string:x195>", &function_ec55e746e84f6b9 );
        devgui::add_devgui_func( "<dev string:x1ad>", "<dev string:x1ad>", &function_5d7b4a30b0bb58e );
        devgui::add_devgui_func( "<dev string:x1be>", "<dev string:x1be>", &function_29774a4e3489e07b );
        devgui::add_devgui_func( "<dev string:x1cf>", "<dev string:x1cf>", &function_488026396797a4a4 );
        devgui::add_devgui_func( "<dev string:x1e4>", "<dev string:x1e4>", &function_2618b823bd0edf21 );
        devgui::add_devgui_func( "<dev string:x1f9>", "<dev string:x1f9>", &play_transformation );
        devgui::add_devgui_func( "<dev string:x20d>", "<dev string:x20d>", &function_d664f45397fa117f );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x220>" );
        devgui::add_devgui_func( "<dev string:x236>", "<dev string:x236>", &function_e72515acb5b6c14b );
        devgui::add_devgui_func( "<dev string:x24a>", "<dev string:x24a>", &bot_next_step );
        devgui::add_devgui_func( "<dev string:x258>", "<dev string:x258>", &function_701ffe64dfe18a1f );
        devgui::add_devgui_func( "<dev string:x266>", "<dev string:x266>", &function_872f07e4543a850d );
        devgui::add_devgui_func( "<dev string:x275>", "<dev string:x275>", &function_8f7277d222a05a5c );
        devgui::add_devgui_func( "<dev string:x28f>", "<dev string:x298>", &function_e3c0be8356637264 );
        devgui::add_devgui_func( "<dev string:x2a5>", "<dev string:x2ba>", &function_a508bd61d022b62d );
        devgui::add_devgui_func( "<dev string:x2d3>", "<dev string:x2e5>", &bot_exfil );
        devgui::add_devgui_func( "<dev string:x2fb>", "<dev string:x2fb>", &function_443f35e01a601f4f );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0x76888c9a, Offset: 0x4858
    // Size: 0x5e, Type: dev
    function private function_ec55e746e84f6b9()
    {
        if ( !level.dempsey_ee.var_d28d9482cfeff43a )
        {
            return;
        }
        
        player = level.players[ 0 ];
        player function_f975de2b0c12d135();
        player function_4641de835d2d7cb( level.dempsey_ee.var_d28d9482cfeff43a, "<dev string:x312>" );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0x309a68bd, Offset: 0x48be
    // Size: 0x3a, Type: dev
    function private function_f975de2b0c12d135()
    {
        player = self;
        player setorigin( ( -3305, -5820, 843 ) );
        player setplayerangles( ( 55, 38, 0 ) );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 4, eflags: 0x4
    // Checksum 0x4096bf07, Offset: 0x4900
    // Size: 0x118, Type: dev
    function private function_4641de835d2d7cb( target, print_text, color, sphere_radius )
    {
        if ( !isdefined( print_text ) )
        {
            print_text = "<dev string:x31a>";
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        if ( !isdefined( sphere_radius ) )
        {
            sphere_radius = 4;
        }
        
        if ( !target )
        {
            return;
        }
        
        level endon( #"game_ended" );
        target endon( #"death_or_disconnect" );
        level endon( #"hash_1855e527140b3173" );
        level endon( #"hash_3d67d894f2ef19e7" );
        
        while ( true )
        {
            if ( !target || !target.origin || !self )
            {
                return;
            }
            
            line( self.origin, target.origin, color );
            sphere( target.origin, sphere_radius, color );
            print3d( target.origin, print_text + "<dev string:x31b>" + length( target.origin - self.origin ) + "<dev string:x31e>", color );
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 1, eflags: 0x4
    // Checksum 0x8772a67b, Offset: 0x4a20
    // Size: 0x4f, Type: dev
    function private function_7885afad3c985d03( params )
    {
        level endon( #"game_ended" );
        scene_name = params[ 0 ];
        level utility::flag_set( "<dev string:x320>" );
        zone_manager::set_zone_enabled( "<dev string:x330>", 1 );
        level thread set_scene( scene_name );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 1, eflags: 0x4
    // Checksum 0x1cd0c2fe, Offset: 0x4a77
    // Size: 0xa9, Type: dev
    function private dev_ee_start( params )
    {
        str_name = params[ 0 ];
        
        foreach ( player in level.players )
        {
            if ( player.name == str_name )
            {
                ee_start( player );
                break;
            }
        }
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0x91fdd4c, Offset: 0x4b28
    // Size: 0x6e, Type: dev
    function private function_5d7b4a30b0bb58e()
    {
        s_scene_node = utility::getstruct( "<dev string:x33d>", "<dev string:x362>" );
        player = level.players[ 0 ];
        level thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 1 );
        wait 1;
        level thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 0, 1 );
        s_scene_node thread scene::play( [ player ], "<dev string:x374>", "<dev string:x37a>" );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0x1ef1e9db, Offset: 0x4b9e
    // Size: 0x25, Type: dev
    function private function_29774a4e3489e07b()
    {
        player = level.players[ 0 ];
        function_8aecabb31a4a9b1( player );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0x50d96fa6, Offset: 0x4bcb
    // Size: 0x64, Type: dev
    function private function_488026396797a4a4()
    {
        if ( !level.var_5c7d93526d10598e )
        {
            level.var_5c7d93526d10598e = spawn_a_bot( 1, 1, 1 );
        }
        
        s_scene_node = utility::getstruct( "<dev string:x33d>", "<dev string:x362>" );
        s_scene_node thread scene::play( [ level.var_5c7d93526d10598e ], "<dev string:x374>", "<dev string:x37a>" );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0x47375b0a, Offset: 0x4c37
    // Size: 0x37, Type: dev
    function private function_2618b823bd0edf21()
    {
        if ( !level.var_5c7d93526d10598e )
        {
            level.var_5c7d93526d10598e = spawn_a_bot( 1, 1, 1 );
        }
        
        function_8aecabb31a4a9b1( level.var_5c7d93526d10598e );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0xecd56c86, Offset: 0x4c76
    // Size: 0xd8, Type: dev
    function private function_d664f45397fa117f()
    {
        player = level.players[ 0 ];
        player.pickup_dog_tag = 1;
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_5d6e9f86c3812a93" );
        ee_start( player );
        wait 3;
        player thread play_transformation();
        wait 3;
        player dialogue::say( #"hash_21fcd4b9f3c11bf5", undefined, undefined, undefined, 0.5 );
        player dialogue::say( #"hash_e552bf093db631cb", undefined, undefined, undefined, 0.5 );
        player dialogue::say( #"hash_e552be093db63018", undefined, undefined, undefined, 0.5 );
        level thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 3 );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_cd18ff635690b728" ], [ player ] );
        level thread ee_end( player, 1 );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0x5197f241, Offset: 0x4d56
    // Size: 0x71, Type: dev
    function private function_c021d724e05ab662()
    {
        level endon( #"game_ended", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
        
        while ( true )
        {
            if ( level.var_9422388247d2fdc3 )
            {
                sphere( level.var_9422388247d2fdc3.origin, 10, ( 1, 1, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0xc
    // Checksum 0xbd4a9164, Offset: 0x4dcf
    // Size: 0x27, Type: dev
    function private function_e72515acb5b6c14b()
    {
        self notify( #"hash_b9ae1b3fc03e4c8" );
        self endon( #"hash_b9ae1b3fc03e4c8" );
        level thread function_e61496783dc75be5( 1 );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 1, eflags: 0xc
    // Checksum 0x76206a35, Offset: 0x4dfe
    // Size: 0x2c3, Type: dev
    function private function_e61496783dc75be5( bot_step_wait )
    {
        self notify( #"hash_f074aaef64c8704d" );
        self endon( #"hash_f074aaef64c8704d" );
        level endon( #"game_ended" );
        
        if ( !level.var_5c7d93526d10598e )
        {
            level.var_5c7d93526d10598e = spawn_a_bot();
        }
        else
        {
            level.var_5c7d93526d10598e val::set( "<dev string:x394>", "<dev string:x3a1>", 1 );
            level.var_5c7d93526d10598e val::set( "<dev string:x394>", "<dev string:x3a8>", 0 );
        }
        
        bot = level.var_5c7d93526d10598e;
        bot endon( #"death_or_disconnect" );
        bot thread function_5211fd23236d3eb8();
        bot function_f975de2b0c12d135();
        bot.var_65a8b55c5c68fc4 = "<dev string:x3b7>";
        wait 1;
        
        if ( bot_step_wait )
        {
            level waittill( #"hash_6a5b42b023d99bc3" );
        }
        
        bot.var_65a8b55c5c68fc4 = "<dev string:x3cd>";
        function_3f9de58378affab6( bot );
        
        while ( level.var_5000c3c1cd028258 != bot )
        {
            waitframe();
        }
        
        wait 5;
        
        if ( bot_step_wait )
        {
            level waittill( #"hash_6a5b42b023d99bc3" );
        }
        
        var_4960ad8045848612 = utility::getstruct( "<dev string:x3dc>", "<dev string:x362>" );
        bot function_d5a0ad3a8983089f( 10, var_4960ad8045848612.origin, "<dev string:x3f0>" );
        bot.var_65a8b55c5c68fc4 = "<dev string:x40e>";
        
        if ( bot_step_wait )
        {
            level waittill( #"hash_6a5b42b023d99bc3" );
        }
        
        wait 2;
        level thread dev_kill_zombies();
        bot.var_65a8b55c5c68fc4 = "<dev string:x41c>";
        wait 10;
        
        if ( bot_step_wait )
        {
            level waittill( #"hash_6a5b42b023d99bc3" );
        }
        
        var_7525af8065b12a38 = utility::getstruct( "<dev string:x42a>", "<dev string:x362>" );
        bot function_d5a0ad3a8983089f( 10, var_7525af8065b12a38.origin, "<dev string:x43e>" );
        level notify( #"hash_d538281d3830bc68" );
        bot.var_65a8b55c5c68fc4 = "<dev string:x45c>";
        
        if ( bot_step_wait )
        {
            level waittill( #"hash_6a5b42b023d99bc3" );
        }
        
        wait 2;
        level thread dev_kill_zombies();
        bot.var_65a8b55c5c68fc4 = "<dev string:x46a>";
        wait 10;
        
        if ( bot_step_wait )
        {
            level waittill( #"hash_6a5b42b023d99bc3" );
        }
        
        var_6863fe805cfbd5f5 = utility::getstruct( "<dev string:x478>", "<dev string:x362>" );
        bot function_d5a0ad3a8983089f( 10, var_6863fe805cfbd5f5.origin, "<dev string:x48c>" );
        level notify( #"hash_d538281d3830bc68" );
        bot.var_65a8b55c5c68fc4 = "<dev string:x4aa>";
        
        if ( bot_step_wait )
        {
            level waittill( #"hash_6a5b42b023d99bc3" );
        }
        
        wait 2;
        level thread dev_kill_zombies();
        bot.var_65a8b55c5c68fc4 = "<dev string:x4b8>";
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 3, eflags: 0xc
    // Checksum 0x917d0867, Offset: 0x50c9
    // Size: 0xc3, Type: dev
    function private function_d5a0ad3a8983089f( delay_s, position, stop_flag )
    {
        self notify( #"hash_b985c9e0179456c3" );
        self endon( #"hash_b985c9e0179456c3" );
        bot = self;
        bot endon( #"death_or_disconnect" );
        level endon( #"game_ended", stop_flag, #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
        bot.var_65a8b55c5c68fc4 = "<dev string:x4c6>" + stop_flag;
        wait delay_s;
        bot setorigin( position );
        
        while ( true )
        {
            if ( utility::flag( stop_flag ) )
            {
                return;
            }
            
            wait 2;
            bot setorigin( position );
        }
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0xc
    // Checksum 0xbb9e2d9c, Offset: 0x5194
    // Size: 0x8e, Type: dev
    function private function_5211fd23236d3eb8()
    {
        self notify( #"hash_e15a964ee6faaecd" );
        self endon( #"hash_e15a964ee6faaecd" );
        level endon( #"game_ended" );
        bot = self;
        bot endon( #"death_or_disconnect" );
        color = ( 0, 1, 0 );
        
        while ( true )
        {
            if ( bot.var_65a8b55c5c68fc4 )
            {
                print3d( bot.origin, bot.var_65a8b55c5c68fc4, color );
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0xb7b9c951, Offset: 0x522a
    // Size: 0x11, Type: dev
    function private bot_next_step()
    {
        level notify( #"hash_6a5b42b023d99bc3" );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0xc
    // Checksum 0x2bf51cf5, Offset: 0x5243
    // Size: 0xea, Type: dev
    function private dev_kill_zombies()
    {
        self notify( #"hash_97cc2275cdd2d1a8" );
        self endon( #"hash_97cc2275cdd2d1a8" );
        level endon( #"game_ended", #"hash_d538281d3830bc68", #"ee_dempsey_success", #"ee_dempsey_fail_time_out", #"ee_dempsey_fail_death", #"ee_quit_dempsey" );
        
        while ( true )
        {
            foreach ( zombie in level.var_ff46eb8f8b48e51e )
            {
                if ( zombie && isalive( zombie ) )
                {
                    zombie kill();
                    wait 2;
                }
            }
            
            wait 1;
        }
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0xe1587413, Offset: 0x5335
    // Size: 0x2b, Type: dev
    function private function_701ffe64dfe18a1f()
    {
        if ( !level.var_5c7d93526d10598e )
        {
            return;
        }
        
        kick( level.var_5c7d93526d10598e );
        level.var_5c7d93526d10598e = undefined;
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0x27463670, Offset: 0x5368
    // Size: 0x5e, Type: dev
    function private function_872f07e4543a850d()
    {
        is_god = getdvar( @"bot_godmode", 0 );
        setdvar( @"bot_godmode", !is_god );
        is_god = getdvar( @"bot_godmode", 0 );
        iprintlnbold( "<dev string:x4cc>" + ( !is_god ? "<dev string:x4d5>" : "<dev string:x4d9>" ) );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0xbf99f038, Offset: 0x53ce
    // Size: 0x3c, Type: dev
    function private function_8f7277d222a05a5c()
    {
        var_cd334f10192877a1 = utility::getstruct( "<dev string:x4dd>", "<dev string:x362>" );
        level.players[ 0 ] setorigin( var_cd334f10192877a1.origin );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0xc
    // Checksum 0x21d1737f, Offset: 0x5412
    // Size: 0x7b, Type: dev
    function private function_e3c0be8356637264()
    {
        self notify( #"hash_3ce312a82031f140" );
        self endon( #"hash_3ce312a82031f140" );
        level endon( #"game_ended", #"hash_937635ce8d0e71e" );
        level childthread function_dd0954f3fca7f0de();
        level childthread function_a2d4a2f71c215b28();
        
        while ( true )
        {
            childthread function_e61496783dc75be5( 0 );
            level utility::waittill_any( "<dev string:x4f5>", "<dev string:x508>", "<dev string:x521>", "<dev string:x537>" );
            wait 2;
            function_a508bd61d022b62d();
            wait 5;
        }
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0x12a9930e, Offset: 0x5495
    // Size: 0x1d, Type: dev
    function private function_a508bd61d022b62d()
    {
        utility::flag_clear( "<dev string:x547>" );
        utility::flag_clear( "<dev string:x4f5>" );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0xc
    // Checksum 0x1afa917a, Offset: 0x54ba
    // Size: 0x4d, Type: dev
    function private function_dd0954f3fca7f0de()
    {
        self notify( #"hash_29e883b45ed5fc9a" );
        self endon( #"hash_29e883b45ed5fc9a" );
        
        while ( true )
        {
            if ( randomint( 10000 ) <= 1 )
            {
                if ( level.var_5c7d93526d10598e )
                {
                    kick( level.var_5c7d93526d10598e );
                }
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0xc
    // Checksum 0x6d2a2436, Offset: 0x550f
    // Size: 0x42, Type: dev
    function private function_a2d4a2f71c215b28()
    {
        self notify( #"hash_1df00b167ccbce79" );
        self endon( #"hash_1df00b167ccbce79" );
        
        while ( true )
        {
            if ( randomint( 1000 ) <= 1 )
            {
                level notify( #"hash_6a5b42b023d99bc3" );
                wait 5;
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0xc
    // Checksum 0xf000aa85, Offset: 0x5559
    // Size: 0x1a3, Type: dev
    function private bot_exfil()
    {
        self notify( #"hash_7fe7ba0865e6b6ef" );
        self endon( #"hash_7fe7ba0865e6b6ef" );
        level endon( #"game_ended" );
        
        if ( !level.var_f0bf520b12cc2686 )
        {
            level.var_f0bf520b12cc2686 = spawn_a_bot( 0, 0 );
        }
        
        bot = level.var_f0bf520b12cc2686;
        wait 1;
        setdvar( @"scr_devgui_cmd", "<dev string:x558>" );
        wait 2;
        first_exfil = undefined;
        
        while ( true )
        {
            waitframe();
            
            foreach ( exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
            {
                if ( exfil.states == "<dev string:x573>" )
                {
                    first_exfil = exfil;
                    break;
                }
            }
            
            if ( first_exfil )
            {
                break;
            }
        }
        
        if ( !first_exfil )
        {
            iprintlnbold( "<dev string:x57d>" );
            return;
        }
        
        bot function_fc5a0188bf562404();
        first_exfil.interact zm_exfil_sat::on_exfil_interact_used( bot );
        
        while ( !level.s_zm_exfil.alive_hvt )
        {
            waitframe();
        }
        
        wait 5;
        setdvar( @"scr_devgui_cmd", "<dev string:x590>" );
        wait 8;
        bot function_fc5a0188bf562404();
        first_exfil.interact zm_exfil_sat::on_exfil_interact_used( bot );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0xcc2869, Offset: 0x5704
    // Size: 0x25, Type: dev
    function private function_443f35e01a601f4f()
    {
        player = level.players[ 0 ];
        player function_fc5a0188bf562404();
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 0, eflags: 0x4
    // Checksum 0x1c241b5, Offset: 0x5731
    // Size: 0x2b, Type: dev
    function private function_fc5a0188bf562404()
    {
        self setorigin( ( 24648, 1332, 375 ) );
        self setplayerangles( ( 11, 356, 0 ) );
    }

    // Namespace zm_sat_firefly_script_dmps_ee
    // Params 3, eflags: 0x4
    // Checksum 0x48628a40, Offset: 0x5764
    // Size: 0x174, Type: dev
    function private spawn_a_bot( var_162f2ed9c2896dab, freeze_control, disable_weapon )
    {
        if ( !isdefined( var_162f2ed9c2896dab ) )
        {
            var_162f2ed9c2896dab = 1;
        }
        
        level endon( #"game_ended" );
        var_e7a717b43846a16 = level.players.size;
        
        if ( var_e7a717b43846a16 >= 4 )
        {
            iprintlnbold( "<dev string:x5a8>" );
            return;
        }
        
        bots::spawn_bots( 1, "<dev string:x5d3>" );
        
        while ( true )
        {
            waitframe();
            new_bot = undefined;
            
            foreach ( index, p in level.players )
            {
                if ( index == 0 )
                {
                    continue;
                }
                
                if ( p.is_using )
                {
                    continue;
                }
                
                p.is_using = 1;
                new_bot = p;
                break;
            }
            
            if ( new_bot )
            {
                if ( var_162f2ed9c2896dab )
                {
                    new_bot val::set( "<dev string:x394>", "<dev string:x5da>", 1 );
                }
                
                if ( freeze_control )
                {
                    new_bot val::set( "<dev string:x394>", "<dev string:x3a8>", 1 );
                }
                
                if ( disable_weapon )
                {
                    new_bot val::set( "<dev string:x394>", "<dev string:x3a1>", 0 );
                }
                
                return new_bot;
            }
        }
    }

#/
