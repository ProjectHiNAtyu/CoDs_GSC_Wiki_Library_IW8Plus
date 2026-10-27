// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_quest_pap.gsc  (hash_5ecacfa8fe586a06.gscc) (size: 31990 Bytes / 0x7cf6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77eaba5d (2011871837)
// size ...... 31990 (0x7cf6)
// includes .. 22  (offset: 0x753a)
// strings ... 113 (offset: 0x75ea)
// dev strs .. 3   (offset: 0x7cd2)
// exports ... 80  (offset: 0x492a)
// cseg ...... 0x9b3 + 0x3f77 (0x492a)
// imports ... 245 (offset: 0x55aa)
// animtree1 . 0   (offset: 0x7cf6)
// animtree2 . 0   (offset: 0x7cf6)
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\electric_power_switch;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\player_banter;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\killstreaks\zm_robot_controller;
#using scripts\mp\zm\systems\killstreaks\zm_robot_controller_primary;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_locust_quest_pap;

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x5
// Checksum 0x22cd7d99, Offset: 0x9d1
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"locust_quest_pap", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x182807e0, Offset: 0x9fe
// Size: 0x214
function private pre_main()
{
    if ( isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "papQuest" ) )
    {
        tube_clip = getentarray( "head_tube_clip", #targetname );
        
        if ( tube_clip.size )
        {
            for ( i = 0; i < tube_clip.size ; i++ )
            {
                tube_clip[ i ] delete();
            }
        }
        
        return;
    }
    
    level.var_d81bd225c0a774f2 = spawnstruct();
    zm_quest::register_quest_step( #"locust_quest_pap", #"investigate_island", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"locust_quest_pap", #"hash_9fe83a6822d77562", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
    zm_quest::register_quest_step( #"locust_quest_pap", #"explore_head", &function_7d6d5f3ab952bc0b, &function_60062148e78b7470 );
    zm_quest::register_quest_step( #"locust_quest_pap", #"reactivate_robot", &function_7d6d643ab952c70a, &function_60062848e78b83d5 );
    zm_quest::register_quest_step( #"locust_quest_pap", #"hash_f1001076b01afa31", &function_7d6d653ab952c93d, &function_60062748e78b81a2 );
    zm_quest::register_quest_step( #"locust_quest_pap", #"find_keycard", &function_7d6d623ab952c2a4, &function_60062648e78b7f6f );
    zm_quest::register_quest_step( #"locust_quest_pap", #"hash_c732e218d59ed929", &function_7d6d633ab952c4d7, &function_60062548e78b7d3c );
    zm_quest::register_quest_step( #"locust_quest_pap", #"hash_16150452522333d6", &function_7d6d583ab952aca6, &function_60062c48e78b8ca1 );
    zm_quest::register_quest_step( #"locust_quest_pap", #"get_remote", &function_7d6d593ab952aed9, &function_60062b48e78b8a6e );
    zm_quest::register_quest_step( #"locust_quest_pap", #"hash_7308a014981cb8a5", &function_7d71e63ab957dac7, &function_60019e48e7865e80 );
    zm_quest::register_quest_step( #"locust_quest_pap", #"hash_6e5532f77e42c61c", &function_7d71e53ab957d894, &function_60019f48e78660b3 );
    zm_quest::register_quest_step( #"locust_quest_pap", #"release_pap", &function_7d71e83ab957df2d, &function_6001a048e78662e6 );
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x2154cefa, Offset: 0xc1a
// Size: 0x141
function private post_main()
{
    level thread function_219e7880e881245c();
    
    if ( isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "papQuest" ) )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level thread function_a5617f98171099d7();
    level thread function_cf50f2c7630f627();
    level thread function_7ee5395dd3aa374c();
    level thread function_e23dbe27b5cbc543();
    level thread function_44de487299d3156b();
    level thread function_3ab5d177ac4927a3();
    level thread function_fe40c374cbd53b4e();
    level thread function_8aa3994b6dddbcfa();
    utility::add_fx( "ejection_tube_splat", "vfx_sat_levels_zm_locust_pap_blood_explo" );
    level thread hide_pap();
    level thread open_sesame_monitor();
    level val::set( #"locust_quest_pap", "task_logic_activate", 0 );
    level callback::add( #"hash_3f5e2e699aadded2", &function_f91a3207ced59367 );
    zm_save::function_1f44a48caae2acbf();
    
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        quest = zm_quest::get_quest( #"locust_quest_pap" );
        
        if ( isdefined( quest ) && quest.completed )
        {
            level val::reset( #"locust_quest_pap", "task_logic_activate" );
        }
    }
    
    level thread function_1cb650abec36ed98();
    utility::flag_wait( "begin_round_logic" );
    wait 4;
    level thread zm_quest::start_quest( #"locust_quest_pap" );
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xc6feb60b, Offset: 0xd63
// Size: 0xc7
function private function_219e7880e881245c()
{
    utility::flag_wait( "scriptables_ready" );
    var_6ef5bb7453229b53 = utility::getstructarray( "elec_switch_trigger", "targetname" );
    
    foreach ( var_9141af98d93fd67c in var_6ef5bb7453229b53 )
    {
        assert( isdefined( var_9141af98d93fd67c.model_switch ) );
        var_9141af98d93fd67c.model_switch setscriptablepartstate( #"base", #"hide" );
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x64f60475, Offset: 0xe32
// Size: 0xa8
function private hide_pap()
{
    utility::flag_wait( "scriptables_ready" );
    
    while ( level.var_db52bcfd04d45a7a.size == 0 )
    {
        waitframe();
    }
    
    s_pap = level.var_db52bcfd04d45a7a[ 0 ];
    
    while ( !isdefined( s_pap.var_370acb837a3a86c3 ) )
    {
        waitframe();
    }
    
    s_pap.var_370acb837a3a86c3.interact setusableenabled( 0 );
    s_pap.var_370acb837a3a86c3 setscriptablepartstate( #"warp", #"warp_out" );
    level.var_d81bd225c0a774f2.mdl = s_pap.var_370acb837a3a86c3;
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xa67f2d90, Offset: 0xee2
// Size: 0x35
function private open_sesame_monitor()
{
    level endon( #"game_ended" );
    utility::flag_wait( "open_sesame" );
    zm_quest::function_11b75e2232ce3d4( [ #"release_pap", 1 ] );
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xacb6f324, Offset: 0xf1f
// Size: 0x64
function private init_waypoint_manager()
{
    door_paths = [];
    door_paths[ door_paths.size ] = [ "db_shipyard", "db_downtown" ];
    door_paths[ door_paths.size ] = [ "db_shipyard_to_fishery", "db_downtown_to_fishery" ];
    door_paths[ door_paths.size ] = [ "db_fishery_to_foundry", "db_fishery_to_village" ];
    level thread function_e654bd26e0e71a98( door_paths );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x45ac2a88, Offset: 0xf8b
// Size: 0x1e1
function private function_e654bd26e0e71a98( doorbuy_sets )
{
    for ( i = 0; i < doorbuy_sets.size ; i++ )
    {
        door_flags = [];
        door_waypoints = [];
        doorbuy_group = doorbuy_sets[ i ];
        
        foreach ( doorbuy_name in doorbuy_group )
        {
            s_doorbuy = zm_sat_locust_util::get_doorbuy( doorbuy_name );
            
            if ( !isdefined( s_doorbuy ) )
            {
                continue;
            }
            
            origin = s_doorbuy.origin ?? s_doorbuy.parent.origin;
            s_doorbuy.objid = zm_quest::function_b98d4144845ffc13( s_doorbuy.target2, 0, "ui_icon_zm_objective", "icon_small_medium", "current", origin, 0, undefined, undefined, 1, i == 0 );
            door_flags[ door_flags.size ] = s_doorbuy.script_flag_set;
            door_waypoints[ door_waypoints.size ] = s_doorbuy.objid;
        }
        
        if ( door_flags.size == doorbuy_group.size )
        {
            msg = utility::flag_wait_any_array_return( door_flags );
        }
        
        foreach ( door_waypoint in door_waypoints )
        {
            zm_quest::complete_objective_waypoints( door_waypoint );
        }
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x2db6e49e, Offset: 0x1174
// Size: 0x73, Type: bool
function private function_f91a3207ced59367( params )
{
    if ( !params.was_timeout )
    {
        return false;
    }
    
    if ( !utility::flag( "pap_step_04" ) )
    {
        return false;
    }
    
    if ( !arraycontains( level.var_db1ca16030498d75.interactions, params.node.enter ) )
    {
        return false;
    }
    
    params.type = "ejection";
    return true;
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xb1f94338, Offset: 0x11f0
// Size: 0x162
function private function_a5617f98171099d7()
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    shadowsmith_hold = getdvarfloat( @"hash_d0ececc1223173ac", 2.5 );
    
    if ( shadowsmith_hold > 0 )
    {
        level callback::add( #"player_connect", &on_player_connect );
        utility::flag_set( "intro_hold" );
    }
    
    utility::flag_wait( "loading_screen_fade_out_begin" );
    wait 1;
    time_start = gettime();
    scene_struct = utility::getstruct( "virgil_game_start_walk" );
    shot_names = [ "loop" ];
    scene::add_scene_func( scene_struct, &function_931241ba4e6c6e9b, "callback_play" );
    scene_struct thread scene::play( undefined, shot_names );
    
    if ( shadowsmith_hold > 0 )
    {
        level thread function_b9b0d136e49b53ac( shadowsmith_hold );
    }
    
    utility::flag_wait( "zm_fade_from_black_start" );
    var_268a976aec755bf = utility::function_6f5d2e1f1ff70482( gettime() - time_start );
    wait max( 0.1, 1.75 - var_268a976aec755bf );
    scene::remove_scene_func( scene_struct, &function_931241ba4e6c6e9b, "callback_play" );
    shot_names = [ "walking" ];
    activateworldevent( "we_vfx_sat_virgil_footstep_house_dust" );
    scene_struct thread scene::play( scene_struct.virgil, shot_names );
    level waittill( #"shadowsmith_intro_hide" );
    scene_struct.virgil invisiblenotsolid();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x512cf242, Offset: 0x135a
// Size: 0x42
function private function_931241ba4e6c6e9b()
{
    [ virgil ] = scene::get_entities();
    virgil.is_immune = 1;
    virgil setsolid( 0 );
    self.virgil = virgil;
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x2a7c6236, Offset: 0x13a4
// Size: 0x47
function private function_7d6d613ab952c071( skipped, save_restored )
{
    level thread init_waypoint_manager();
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( "zone_changed", &function_a2924fd3a5e566b7 );
    utility::flag_wait( "pap_step_01" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x2720ee24, Offset: 0x13f3
// Size: 0x40
function private function_60062348e78b78d6( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "pap_step_01" );
    }
    
    level callback::remove( "zone_changed", &function_a2924fd3a5e566b7 );
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x11fef3e, Offset: 0x143b
// Size: 0x36
function private function_a2924fd3a5e566b7( params )
{
    if ( params.zone_struct.zone_name == "zone_fishery" )
    {
        utility::flag_set( "pap_step_01" );
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x7c76b456, Offset: 0x1479
// Size: 0xba
function private on_player_connect( params )
{
    level endon( #"zm_game_over" );
    level endon( #"game_ended" );
    level endon( #"end_intro_hold" );
    self endon( #"death_or_disconnect" );
    
    if ( utility::flag( "intro_hold" ) )
    {
        self waittill( #"giveloadout" );
        
        if ( !utility::flag( "intro_hold" ) )
        {
            return;
        }
        
        val::set( "intro_hold", "freezecontrols", 1 );
        val::set( "intro_hold", "ignoreme", 1 );
        val::set( "intro_hold", "allow_scripted_bgb_use", 0 );
        wait 5;
        utility::flag_clear( "intro_hold" );
        val::reset_all( "intro_hold" );
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x5969e80d, Offset: 0x153b
// Size: 0x6f
function private function_b9b0d136e49b53ac( hold_time )
{
    level endon( #"zm_game_over" );
    level endon( #"game_ended" );
    wait hold_time;
    utility::flag_clear( "intro_hold" );
    utility::array_thread( level.players, &val::reset_all, "intro_hold" );
    level callback::remove( #"player_connect", &on_player_connect );
    level notify( #"end_intro_hold" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x893e3542, Offset: 0x15b2
// Size: 0x154
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    door_flags = [ "zone_foundry_bought", "zone_village_bought" ];
    utility::flag_wait_any_array( door_flags );
    power_lines = zm_sat_locust_util::get_quest_reference( #"power_lines" );
    
    foreach ( power_line in power_lines )
    {
        if ( power_line.repaired )
        {
            level zm_sat_locust_util::function_68d02dd51f9cb2d4( #"locust_quest_pap", #"hash_9fe83a6822d77562", undefined, undefined, level.var_d81bd225c0a774f2.pl_repaired );
            continue;
        }
        
        power_line setscriptablepartstate( #"usable", #"enabled" );
        
        if ( !level.var_a74764204d9643c )
        {
            power_line setscriptablepartstate( #"objective", #"enabled" );
        }
    }
    
    utility::flag_wait( "pap_step_02" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xa9277224, Offset: 0x170e
// Size: 0xf4
function private function_60062248e78b76a3( skipped, save_restored )
{
    profilestart();
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"pops_head" ) )
    {
        head = zm_sat_locust_util::get_quest_reference( #"pops_head" );
        head setscriptablepartstate( #"effects", #"power_on" );
    }
    
    if ( skipped || save_restored )
    {
        power_lines = zm_sat_locust_util::get_quest_reference( #"power_lines" );
        
        foreach ( power_line in power_lines )
        {
            power_line function_2bde0dc96ab6632d( undefined, 1 );
        }
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x7815b319, Offset: 0x180a
// Size: 0x181
function private function_cf50f2c7630f627()
{
    utility::flag_wait( "scriptables_ready" );
    power_lines = [];
    power_line_locs = utility::getstructarray( "quest_pap_ambrose" );
    
    foreach ( var_65b63149bb7a7b03 in power_line_locs )
    {
        power_line = spawnscriptable( %"sat_zm_prop_ambrose", var_65b63149bb7a7b03.origin, angleclamp180( var_65b63149bb7a7b03.angles ) );
        power_line.script_flag = var_65b63149bb7a7b03.script_noteworthy;
        power_line.script_int = power_line.script_flag != "foot_power";
        power_line setscriptablepartstate( #"usable", #"off" );
        power_line setscriptablepartstate( #"objective", #"off" );
        interaction::register_scriptable_interact( power_line, &function_1dd683818962164d );
        power_lines[ power_lines.size ] = power_line;
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"power_lines", power_lines );
    level.var_d81bd225c0a774f2.var_52c5f6e1ae2566e9 = power_lines.size;
    level.var_d81bd225c0a774f2.pl_repaired = 0;
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x74e6813c, Offset: 0x1993
// Size: 0x2d
function private function_1dd683818962164d( player )
{
    self setscriptablepartstate( #"usable", #"off" );
    thread function_e471c9164717c0b( player );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0xc
// Checksum 0x7fdd37ae, Offset: 0x19c8
// Size: 0xb3
function private function_e471c9164717c0b( player )
{
    self notify( #"hash_68ec599a3db32a2c" );
    self endon( #"hash_68ec599a3db32a2c" );
    params = { #hud_description:&"shared_hintstrings/repairing", #use_object:self, #hold_time:2, #craft_reason:#"ambrose_repair" };
    result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
    
    if ( result )
    {
        function_2bde0dc96ab6632d( player, 0 );
        return;
    }
    
    utility::delaycall( 1, &setscriptablepartstate, #"usable", #"enabled" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xedce5464, Offset: 0x1a83
// Size: 0x1b4
function private function_2bde0dc96ab6632d( player, skipped = 0 )
{
    self setscriptablepartstate( #"body", #"opened_repaired" );
    self setscriptablepartstate( #"usable", #"off" );
    self setscriptablepartstate( #"objective", #"off" );
    self.repaired = 1;
    level.var_d81bd225c0a774f2.pl_repaired++;
    activateworldevent( self.script_flag == "foot_power" ? "we_sat_zm_power_foot" : "we_sat_zm_power_shoulder" );
    
    if ( !skipped )
    {
        level zm_sat_locust_util::function_68d02dd51f9cb2d4( #"locust_quest_pap", #"hash_9fe83a6822d77562", undefined, undefined, level.var_d81bd225c0a774f2.pl_repaired );
    }
    
    utility::flag_set( self.script_flag );
    value = zm_quest::function_73720cdf21c3cfd7( #"locust_quest_pap", #"powerlines_repaired" ) ?? 0;
    value = utility::set_bit_flag( value, self.script_int );
    zm_quest::function_4eefe6de31f5ddab( #"locust_quest_pap", #"powerlines_repaired", value );
    
    if ( level.var_d81bd225c0a774f2.pl_repaired == level.var_d81bd225c0a774f2.var_52c5f6e1ae2566e9 )
    {
        if ( player )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_4d1c712ed2f4907", #"bc_flavor_player_positive" );
        }
        
        utility::flag_set( "pap_step_02" );
        return;
    }
    
    if ( player )
    {
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x619b51d1, Offset: 0x1c3f
// Size: 0xff
function private function_1cb650abec36ed98()
{
    if ( !zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    if ( zm_quest::is_quest_step_complete( #"locust_quest_pap", #"hash_9fe83a6822d77562" ) )
    {
        return;
    }
    
    value = zm_quest::function_73720cdf21c3cfd7( #"locust_quest_pap", #"powerlines_repaired" ) ?? 0;
    
    if ( value == 0 )
    {
        return;
    }
    
    powerlines = zm_sat_locust_util::get_quest_reference( #"power_lines" );
    
    foreach ( powerline in powerlines )
    {
        if ( !utility::get_bit_flag( value, powerline.script_int ) )
        {
            continue;
        }
        
        powerline function_2bde0dc96ab6632d( undefined, 1 );
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xb94eb275, Offset: 0x1d46
// Size: 0x47
function private function_7d6d5f3ab952bc0b( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread function_a8a15f03eca0ceb8();
    level callback::add( "zone_changed", &function_47b2f88c4269cdd9 );
    utility::flag_wait( "pap_step_03" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x4fc5094c, Offset: 0x1d95
// Size: 0x56
function private function_60062148e78b7470( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "pap_step_03" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread zm_quest::update_round_cap( 5, 1, 0 );
    }
    
    level callback::remove( "zone_changed", &function_47b2f88c4269cdd9 );
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x39f75a34, Offset: 0x1df3
// Size: 0x1ae
function private function_a8a15f03eca0ceb8()
{
    level endon( #"game_ended" );
    door_paths = [];
    door_paths[ door_paths.size ] = [ "db_foundry_back", "db_village_back" ];
    level function_e654bd26e0e71a98( door_paths );
    flags = [];
    
    foreach ( point in level.var_db1ca16030498d75.interactions )
    {
        if ( !isdefined( point.script_flag_set ) )
        {
            continue;
        }
        
        point.objid = zm_quest::function_b98d4144845ffc13( point.script_flag_set, 0, "ui_icon_zm_objective", "icon_small_medium", "current", point.origin, 16, undefined, undefined, 1, 0 );
        flags[ flags.size ] = point.script_flag_set;
    }
    
    utility::flag_wait_any_array( [ "foot_rap", "shoulder_rap" ] );
    
    foreach ( flag in flags )
    {
        zm_quest::complete_objective_waypoints( flag );
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x8317fbde, Offset: 0x1fa9
// Size: 0x3d
function private function_47b2f88c4269cdd9( params )
{
    if ( params.zone_struct.zone_name == "zone_robot_head" )
    {
        utility::flag_set( "pap_step_03" );
        thread function_65f8992c7c4e7725();
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x4e2410b6, Offset: 0x1fee
// Size: 0x4c
function private function_65f8992c7c4e7725()
{
    level endon( #"zm_game_over" );
    self endon( #"death_or_disconnect" );
    
    if ( self.var_420915a121e1cc41 )
    {
        self waittill( #"fasttravel_finished" );
    }
    
    thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_aff2676a01629246", #"hash_5212ed7ec42f115a" );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x762f406d, Offset: 0x2042
// Size: 0x35, Type: bool
function private function_379652b5f6f85150( params )
{
    if ( arraycontains( level.var_db1ca16030498d75.interactions, params.interact ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x5ff0ba, Offset: 0x2080
// Size: 0x98
function private function_7d6d643ab952c70a( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    terminal = zm_sat_locust_util::get_quest_reference( #"pap_terminal" );
    terminal.objid = zm_quest::function_b98d4144845ffc13( #"pap_terminal", 0, "ui_icon_zm_objective", "icon_small_medium", "current", terminal.origin + anglestoforward( terminal.angles ) * 36, 64, undefined, undefined, 1, 0 );
    utility::flag_wait( "pap_step_04" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xf5556e6b, Offset: 0x2120
// Size: 0x50
function private function_60062848e78b83d5( skipped, save_restored )
{
    profilestart();
    activateworldevent( "we_sat_zm_power_on" );
    
    if ( skipped || save_restored )
    {
        terminal = zm_sat_locust_util::get_quest_reference( #"pap_terminal" );
        terminal function_6251d858b797f13b();
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x14346991, Offset: 0x2178
// Size: 0x8d
function private function_7ee5395dd3aa374c()
{
    utility::flag_wait( "scriptables_ready" );
    terminal = getent( "robot_terminal", #targetname );
    robot_map = getent( "robot_map", #targetname );
    interaction::register_interact( terminal, 96, &function_6251d858b797f13b, &function_c17e629d3b291777 );
    terminal sethintonobstruction( "show" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"pap_terminal", terminal );
    zm_sat_locust_util::function_295a36ef38f5acae( #"robot_map", robot_map );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x9f63a0b3, Offset: 0x220d
// Size: 0x196
function private function_6251d858b797f13b( player )
{
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    playsoundatpos( ( 3114, 9688, 1790 ), "evt_pap_robot_power_on" );
    self setusableenabled( 0 );
    setglobalsoundcontext( "zm_locust_robot_head", "activated" );
    
    if ( !utility::flag( "power_on" ) )
    {
        var_6ef5bb7453229b53 = utility::getstructarray( "elec_switch_trigger", "targetname" );
        var_6ef5bb7453229b53[ 0 ].interact electric_power_switch::function_e17b8c37ab7db9f2( player );
    }
    
    zm_quest::complete_objective_waypoints( #"pap_terminal" );
    
    if ( player )
    {
        self playsound( "evt_pap_console_button_interact", undefined, self );
        
        if ( player_banter::is_player_banter_vo_active() )
        {
            player_banter::function_850de641659a4090();
        }
        
        level thread zm_sat_locust_util::function_a8b578b47e763d0f( "dx_zm_lpwp_lpp1_typa_lpp1acvpor" );
        wait 2;
    }
    
    if ( player )
    {
        self setscriptablepartstate( #"display", #"reboot" );
    }
    else
    {
        self setscriptablepartstate( #"display", #"online_1" );
    }
    
    robot_map = zm_sat_locust_util::get_quest_reference( #"robot_map" );
    robot_map setscriptablepartstate( #"display", #"hash_abf0e099159a8caa" );
    
    if ( player )
    {
        scene_struct = level.var_d81bd225c0a774f2.ejection_scene_struct;
        scene_struct.tube_index = scene_struct.script_index == 0 ? 1 : 4;
        activateworldevent( "we_tube_activate_" + scene_struct.tube_index );
    }
    
    utility::flag_set( "pap_step_04" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x8a62f9fb, Offset: 0x23ab
// Size: 0x40
function private function_c17e629d3b291777( usable, player )
{
    return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_robot_terminal_activate", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x43c7e3c5, Offset: 0x23f4
// Size: 0x71
function private function_7d6d653ab952c93d( skipped, save_restored )
{
    if ( save_restored && !isdefined( level.var_d81bd225c0a774f2.ejection_scene_struct ) )
    {
        level function_e23dbe27b5cbc543();
    }
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( #"hash_462433e659e82d48", &function_38d1ba160b9b0734 );
    level thread function_e55da933a819ced7();
    utility::flag_wait( "pap_step_05" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x323917af, Offset: 0x246d
// Size: 0xff
function private function_60062748e78b81a2( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        function_e55da933a819ced7( 1 );
        utility::flag_set( "pap_step_05" );
    }
    
    foreach ( var_d3823b80b1397854 in level.robot_ejection_tubes.interactions )
    {
        if ( var_d3823b80b1397854.in_use )
        {
            continue;
        }
        
        var_d3823b80b1397854 setscriptablepartstate( "interact", "enabled_64" );
    }
    
    level callback::remove( #"hash_462433e659e82d48", &function_38d1ba160b9b0734 );
    level callback::remove( #"hash_3e4093a7794b1a98", &function_ebd480f4e632188d );
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0xc
// Checksum 0x4d5dcbfe, Offset: 0x2574
// Size: 0x194
function private function_e23dbe27b5cbc543()
{
    self notify( #"hash_73014cf45a587f66" );
    self endon( #"hash_73014cf45a587f66" );
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        utility::flag_wait( "zm_save_level_restore_keys_complete" );
        idx = zm_quest::function_73720cdf21c3cfd7( #"locust_quest_pap", #"corpse_idx" );
    }
    
    if ( !isdefined( idx ) )
    {
        idx = utility::cointoss();
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"locust_quest_pap", #"corpse_idx", idx );
    var_bf05c3168959c2db = utility::getstructarray( "locust_pap_zm_tube" );
    var_bf05c3168959c2db = utility::array_sort_by_script_index( var_bf05c3168959c2db );
    scene_struct = var_bf05c3168959c2db[ idx ];
    tube_clip = getentarray( "head_tube_clip", #targetname );
    
    if ( tube_clip.size )
    {
        tube_clip = utility::array_sort_by_script_index( tube_clip );
        
        for ( i = 0; i < tube_clip.size ; i++ )
        {
            if ( i == idx )
            {
                scene_struct.tube_clip = tube_clip[ i ];
                continue;
            }
            
            tube_clip[ i ] delete();
        }
    }
    
    level.var_d81bd225c0a774f2.ejection_scene_struct = scene_struct;
    falling_scene_struct = utility::getstruct( scene_struct.target );
    falling_scene_struct.loot_location_struct = utility::getstruct( falling_scene_struct.target );
    level.var_d81bd225c0a774f2.falling_scene_struct = falling_scene_struct;
    var_2bb3c93124521d70 = [ "stuck" ];
    scene_struct thread scene::play( undefined, var_2bb3c93124521d70 );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0xfcd77b0f, Offset: 0x2710
// Size: 0x248
function private function_e55da933a819ced7( skipped = 0 )
{
    level endon( #"game_ended" );
    level endon( #"pap_step_05" );
    utility::array_call( level.robot_ejection_tubes.interactions, &setscriptablepartstate, "interact", "default" );
    scene_struct = level.var_d81bd225c0a774f2.ejection_scene_struct;
    
    if ( !skipped )
    {
        [ corpse ] = scene_struct scene::get_entities();
        var_d3823b80b1397854 = function_47c86977a18df38b( level.robot_ejection_tubes.interactions, corpse.origin, 72 );
        corpse.objid = zm_quest::function_b98d4144845ffc13( #"corpse_tube", 0, "ui_icon_zm_objective", "icon_small_medium", "current", var_d3823b80b1397854.origin, 32, undefined, undefined, 1, 0 );
        origin = corpse.origin + anglestoforward( corpse.angles ) * 16 + ( 0, 0, 24 );
        zm_sat_locust_util::function_abbae1f498a00649( "pap_step_05", origin, 1024 );
        level.var_d81bd225c0a774f2.falling_scene_struct.eject_time = gettime();
        corpse playsoundevent( %"hash_6223b71849482c6f" );
        playsoundatpos( var_d3823b80b1397854.origin, "evt_pap_corpse_eject" );
        var_2bb3c93124521d70 = [ "eject" ];
        scene_struct scene::play( corpse, var_2bb3c93124521d70 );
        deactivateworldevent( "we_tube_activate_" + scene_struct.tube_index );
        level callback::add( #"hash_3e4093a7794b1a98", &function_ebd480f4e632188d );
        level thread zm_sat_locust_util::function_a8b578b47e763d0f( "dx_zm_lpwp_lpp1_typa_lpp1cpsejd", 1 );
        level thread function_abcb1deb1ea69ce1();
    }
    else
    {
        scene_struct thread scene::cleanup( 1 );
    }
    
    if ( scene_struct.tube_clip )
    {
        scene_struct.tube_clip delete();
    }
    
    utility::array_call( level.robot_ejection_tubes.interactions, &setscriptablepartstate, "interact", "enabled_64" );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x92451421, Offset: 0x2960
// Size: 0xdd
function private function_ebd480f4e632188d( params )
{
    zm_quest::complete_objective_waypoints( #"corpse_tube" );
    falling_scene_struct = level.var_d81bd225c0a774f2.falling_scene_struct;
    loot_location_struct = falling_scene_struct.loot_location_struct;
    
    if ( isdefined( falling_scene_struct.eject_time ) )
    {
        time_difference = ( gettime() - falling_scene_struct.eject_time ) / 1000;
    }
    else
    {
        time_difference = 0;
    }
    
    if ( time_difference < 25 )
    {
        falling_scene_struct thread scene::play();
        level waittill( #"ejection_zombie_splat" );
    }
    
    playsoundatpos( loot_location_struct.origin, "evt_pap_corpse_splat" );
    playfx( utility::getfx( "ejection_tube_splat" ), loot_location_struct.origin );
    utility::flag_set( "pap_step_05" );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0xca96eecc, Offset: 0x2a45
// Size: 0xd, Type: bool
function private function_38d1ba160b9b0734( params )
{
    return false;
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x64b289c2, Offset: 0x2a5b
// Size: 0x48
function private function_abcb1deb1ea69ce1()
{
    set_1 = [ "dx_zm_lpwp_lpp1_lvtw_lpp1cerspa1ln1", "dx_zm_lpwp_lpp1_detw_lpp1cerspa1ln2" ];
    set_2 = [ "dx_zm_lpwp_lpp1_detw_lpp1cerspa2ln1", "dx_zm_lpwp_lpp1_lvtw_lpp1cerspa2ln2" ];
    zm_sat_locust_util::function_1d7335486cb891d8( set_1, set_2 );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x3d9d75ee, Offset: 0x2aab
// Size: 0x109
function private function_7d6d623ab952c2a4( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    loot_location_struct = level.var_d81bd225c0a774f2.falling_scene_struct.loot_location_struct;
    params = { #spawntype:#"spawn_at_pos", #spawnangles:loot_location_struct.angles, #spawnorigin:loot_location_struct.origin, #asset:%"zmloot_sat_locust_quest_abner" };
    keycard = zm_sat_locust_util::spawn_quest_item( params );
    
    if ( !level.var_a74764204d9643c )
    {
        keycard setscriptablepartstate( #"objective", #"enabled" );
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_b3820157cc8abee6", keycard );
    level callback::add( "quest_item_used", &function_6f9df07ed5c11a31 );
    utility::flag_wait( "pap_step_06" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x90ebe537, Offset: 0x2bbc
// Size: 0xa0
function private function_60062648e78b7f6f( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_b3820157cc8abee6" ) )
        {
            keycard = zm_sat_locust_util::get_quest_reference( #"hash_b3820157cc8abee6" );
            keycard freescriptable();
        }
        
        utility::flag_set( "pap_step_06" );
        zm_quest::function_b57dfe9625966b0b( #"locust_quest_pap", 0, #"admin_keycard", 1 );
    }
    
    zm_quest::complete_objective_waypoints( #"corpse" );
    level callback::remove( "quest_item_used", &function_6f9df07ed5c11a31 );
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0xab8bf27c, Offset: 0x2c64
// Size: 0xb2
function private function_6f9df07ed5c11a31( params )
{
    if ( params.bundle.scriptable == %"zmloot_sat_locust_quest_abner" )
    {
        utility::flag_set( "pap_step_06" );
        zm_quest::function_b57dfe9625966b0b( #"locust_quest_pap", 0, #"admin_keycard", 1 );
        zm_quest::show_splash_item_picked_up( #"locust_quest_pap", #"admin_keycard", 1, params.player );
        params.player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_d408e3f30b000a6f", #"bc_flavor_player_positive" );
        zm_sat_locust_util::function_63a23256772ea1b9( params.player );
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xcb539046, Offset: 0x2d1e
// Size: 0x84
function private function_7d6d633ab952c4d7( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    occupants = arraycombine( zone_manager::get_zone_occupants( "zone_foundry_factory" ), zone_manager::get_zone_occupants( "zone_foundry_factory_hall" ) );
    
    if ( occupants.size > 0 )
    {
        utility::flag_set( "pap_step_07" );
    }
    else
    {
        level thread function_6f418267c97a71fc();
        level callback::add( "zone_changed", &function_8677f8dc77f8b32d );
    }
    
    utility::flag_wait( "pap_step_07" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x8014592c, Offset: 0x2daa
// Size: 0x40
function private function_60062548e78b7d3c( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "pap_step_07" );
    }
    
    level callback::remove( "zone_changed", &function_8677f8dc77f8b32d );
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x5a39ce6e, Offset: 0x2df2
// Size: 0x7f
function private function_6f418267c97a71fc()
{
    level endon( #"pap_step_07" );
    door_paths = [];
    door_paths[ door_paths.size ] = [ "db_foundry_factory" ];
    level function_e654bd26e0e71a98( door_paths );
    admin_room = zm_sat_locust_util::get_quest_reference( #"admin_room" );
    
    if ( !level.var_a74764204d9643c )
    {
        admin_room.reader utility::function_32b24db3127bff40( #"objective", #"enabled" );
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x28622d34, Offset: 0x2e79
// Size: 0x55
function private function_8677f8dc77f8b32d( params )
{
    if ( params.zone_struct.zone_name == "zone_foundry_factory" || params.zone_struct.zone_name == "zone_foundry_factory_hall" )
    {
        utility::flag_set( "pap_step_07" );
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xbde9c8d1, Offset: 0x2ed6
// Size: 0x9b
function private function_7d6d583ab952aca6( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    admin_room = zm_sat_locust_util::get_quest_reference( #"admin_room" );
    
    if ( !level.var_a74764204d9643c )
    {
        admin_room.reader utility::function_32b24db3127bff40( #"objective", #"enabled" );
    }
    
    admin_room.reader setscriptablepartstate( #"usable", #"enabled" );
    utility::flag_wait( "pap_step_08" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x487359fa, Offset: 0x2f79
// Size: 0x4f
function private function_60062c48e78b8ca1( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        admin_room = zm_sat_locust_util::get_quest_reference( #"admin_room" );
        admin_room.reader function_b123c5445732906e();
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x52fce557, Offset: 0x2fd0
// Size: 0x1a1
function private function_44de487299d3156b()
{
    doors = getentarray( "pap_door", #targetname );
    var_40be060335ef6caf = getent( "foundry_factory_power_room_door", #targetname );
    window = getent( "pap_foundry_window", #targetname );
    window.blocker = getent( var_40be060335ef6caf.target, #targetname );
    spawners = utility::getstructarray( "quest_pap_spawn_area" );
    reader_loc = utility::getstruct( "quest_pap_reader" );
    reader = spawnscriptable( %"sat_zm_prop_abner_reader", reader_loc.origin, reader_loc.angles );
    interaction::register_scriptable_interact( reader, &function_b123c5445732906e );
    var_2dad18cbe1ea2226 = utility::function_11a2ebb045201379( doors, 1 ) + ( 0, 0, 48 ) + anglestoleft( doors[ 0 ].angles ) * 4;
    var_cf1ed9f26e4dd49d = interaction::register_interact( var_2dad18cbe1ea2226, 32, &function_52c48c11b98c7e37, &"zm_sat_locust/hint_door_locked", undefined, undefined, undefined, "HINT_NOBUTTON" );
    admin_room = { #var_cf1ed9f26e4dd49d:var_cf1ed9f26e4dd49d, #reader:reader, #spawners:spawners, #window:window, #var_40be060335ef6caf:var_40be060335ef6caf, #doors:doors };
    zm_sat_locust_util::function_295a36ef38f5acae( #"admin_room", admin_room );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0xe70ba3ff, Offset: 0x3179
// Size: 0xc
function private function_52c48c11b98c7e37( player )
{
    
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x4cee743d, Offset: 0x318d
// Size: 0x16d
function private function_b123c5445732906e( player )
{
    if ( utility::flag( "pap_step_08" ) )
    {
        return;
    }
    
    self setscriptablepartstate( #"usable", #"disabled" );
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    
    if ( !zm_quest::function_6b5f09e88a4edfce( #"locust_quest_pap", 0, #"admin_keycard" ) )
    {
        utility::delaycall( 1, &setscriptablepartstate, #"usable", #"enabled" );
        self setscriptablepartstate( #"effects", #"failure" );
        return;
    }
    else
    {
        self setscriptablepartstate( #"effects", #"success" );
        self setscriptablepartstate( #"model", #"unlocked" );
        
        if ( player )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_fb14adec552b7498", #"bc_flavor_player_positive" );
        }
    }
    
    utility::flag_set( "pap_step_08" );
    utility::flag_set( "zone_foundry_factory_power_room_opened" );
    utility::function_32b24db3127bff40( #"objective", #"disabled" );
    station = zm_sat_locust_util::get_quest_reference( #"hash_de3a46bf23adb2cb" );
    
    if ( !level.var_a74764204d9643c )
    {
        station.controller setscriptablepartstate( #"objective", #"enabled" );
    }
    
    level thread function_ca4d34132ff6325( !isdefined( player ) );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x199a01ec, Offset: 0x3302
// Size: 0x2e7
function private function_ca4d34132ff6325( skipped = 0 )
{
    admin_room = zm_sat_locust_util::get_quest_reference( #"admin_room" );
    admin_room.var_cf1ed9f26e4dd49d delete();
    
    if ( !skipped )
    {
        playsoundatpos( ( -1973, 5642, 410 ), "evt_pap_foundry_door_open" );
        num_zombies = 3;
        
        foreach ( spawn_area in admin_room.spawners )
        {
            points = getrandomnavpoints( spawn_area.origin, spawn_area.radius, num_zombies, undefined );
            
            for ( i = 0; i < num_zombies ; i++ )
            {
                var_30085f70fc117162 = { #angles:( 0, randomfloat( 360 ), 0 ), #origin:points[ i ] };
                params = { #skip_eyes:1, #allow_cleanup:1, #var_30085f70fc117162:var_30085f70fc117162, #aitypes:[ { #type:"zombie_base", #weight:70 }, { #type:"zombie_base_armored_light", #weight:30 } ] };
                zombie = zm_sat_locust_util::spawn_quest_zombie( params );
            }
            
            waitframe();
        }
        
        time = 1;
        
        foreach ( door in admin_room.doors )
        {
            pos = door.origin + anglestoforward( door.angles ) * -76;
            door moveto( pos, time );
            door notsolid();
        }
        
        admin_room.window movez( 102, time );
        wait time * 0.66;
    }
    
    admin_room.window.blocker delete();
    admin_room.window delete();
    admin_room.var_40be060335ef6caf delete();
    utility::array_delete( admin_room.doors );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xf844c373, Offset: 0x35f1
// Size: 0x86
function private function_7d6d593ab952aed9( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    station = zm_sat_locust_util::get_quest_reference( #"hash_de3a46bf23adb2cb" );
    station.controller setscriptablepartstate( station.controller function_84ad2f70189ee7c3(), #"visible" );
    level callback::add( #"player_item_pickup", &function_5ca52fc18d8039ef );
    utility::flag_wait( "pap_step_09" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xacb9c56d, Offset: 0x367f
// Size: 0x1a5
function private function_60062b48e78b8a6e( skipped, save_restored )
{
    profilestart();
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_de3a46bf23adb2cb" ) )
    {
        station = zm_sat_locust_util::get_quest_reference( #"hash_de3a46bf23adb2cb" );
    }
    
    if ( skipped || save_restored )
    {
        if ( !save_restored )
        {
            if ( station.controller )
            {
                station.controller utility::function_32b24db3127bff40( #"objective", #"none" );
            }
            
            /#
                if ( station && station.controller && level.player && isalive( level.player ) )
                {
                    zm_sat_locust_util::function_82f9bbbcb47ef102( #"locust_quest_pap", #"get_remote", "<dev string:x24>" + level.player.name + "<dev string:x43>" + isalive( level.player ) );
                    common_item::items_scriptable_used( station.controller, station.controller function_84ad2f70189ee7c3(), #"visible", level.player, 0 );
                }
            #/
        }
        else if ( station.controller )
        {
            station.controller freescriptable();
        }
        
        utility::flag_set( "pap_step_09" );
        zm_quest::function_b57dfe9625966b0b( #"locust_quest_pap", 0, #"robot_controller", 1 );
    }
    
    setomnvar( o"ui_item_bernard_primary_allowed", 1 );
    level callback::remove( #"player_item_pickup", &function_5ca52fc18d8039ef );
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xa55abb84, Offset: 0x382c
// Size: 0x43
function private function_3ab5d177ac4927a3()
{
    utility::flag_wait( "robot_controllers_init" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_de3a46bf23adb2cb", level.robot_controllers[ "primary" ] );
    level callback::add( #"killstreak_can_trigger", &function_8d72823f2d366bb4 );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x6c57c15, Offset: 0x3877
// Size: 0x4a
function private function_8d72823f2d366bb4( params )
{
    if ( params.bundle.killstreakref == "zm_bernard_primary" )
    {
        params.var_1b38ed24a6c4e157 = undefined;
        params.out_errormessage = %"zm_sat_locust/killstreak_bernard_unlinked";
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x9b8210a3, Offset: 0x38c9
// Size: 0xf7
function private function_5ca52fc18d8039ef( params )
{
    if ( params.itembundle.scriptable == %"zmloot_sat_locust_quest_bernard_primary" )
    {
        utility::flag_set( "pap_step_09" );
        zm_quest::function_b57dfe9625966b0b( #"locust_quest_pap", 0, #"robot_controller", 1 );
        zm_quest::show_splash_item_picked_up( #"locust_quest_pap", #"robot_controller", 1, params.player );
        zm_sat_locust_util::function_63a23256772ea1b9( params.player );
        dialogue = !params.player namespace_c0b4f2882c9d100f::is_richtofen() ? "dx_zm_lpwp_lpp1_typa_lpp1purorm" : "dx_zm_lpwp_lpp1_typa_lpp1purormpr";
        zm_sat_locust_util::function_a8b578b47e763d0f( dialogue );
        
        if ( params.player )
        {
            params.player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_b98761fd6f1f90bc", #"bc_flavor_player_positive" );
        }
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x412eebd4, Offset: 0x39c8
// Size: 0x152
function private function_7d71e63ab957dac7( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    circle_loc = utility::getstruct( "quest_pap_circle" );
    level.var_d81bd225c0a774f2 game_utility::questcircle_showtoall();
    level.var_d81bd225c0a774f2.mdl.objid = zm_quest::function_b98d4144845ffc13( #"pap_island", 0, "ui_icon_zm_objective", "icon_small_medium", "current", circle_loc.origin, undefined, undefined, undefined, 1, 1 );
    groundpos = getgroundposition( circle_loc.origin, 8 );
    interact = spawnscriptable( %"sat_zm_interact_locust", groundpos + ( 0, 0, 24 ) );
    interact.fx = spawnfx( utility::getfx( "glocke_drop_landing_indicator" ), groundpos );
    interact setscriptablepartstate( #"interact", #"enabled_96" );
    triggerfx( interact.fx );
    interaction::register_scriptable_interact( interact, &function_e0a52becd17a51e2, undefined, undefined, &function_26cda0e5d8c1d8d2 );
    zm_sat_locust_util::function_295a36ef38f5acae( #"pap_sync_interact", interact );
    utility::flag_wait( "pap_step_10" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xd0eca926, Offset: 0x3b22
// Size: 0x92
function private function_60019e48e7865e80( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "pap_step_10" );
    }
    
    level.var_d81bd225c0a774f2 game_utility::questcircle_delete();
    zm_quest::complete_objective_waypoints( #"pap_island" );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"pap_sync_interact" ) )
    {
        interact = zm_sat_locust_util::get_quest_reference( #"pap_sync_interact" );
        interact.fx delete();
        interact freescriptable();
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x33d70f03, Offset: 0x3bbc
// Size: 0x3b
function private function_fe40c374cbd53b4e()
{
    circle_loc = utility::getstruct( "quest_pap_circle" );
    level.var_d81bd225c0a774f2 game_utility::questcircle_create( "testCircle_Orange", circle_loc.origin, 64 );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x8ce70d05, Offset: 0x3bff
// Size: 0x8a
function private function_e0a52becd17a51e2( player )
{
    self setscriptablepartstate( #"interact", #"default" );
    streakinfo = player killstreak_utility::createstreakinfo( "zm_bernard_primary", player );
    streakinfo.var_41f8a434fae6074f = 1;
    player zm_robot_controller_primary::function_95593d8d1cb71405( streakinfo );
    utility::flag_set( "pap_step_10" );
    zm_sat_locust_util::function_a8b578b47e763d0f( "dx_zm_lpwp_lpp2_typa_lpp2bgresy" );
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_5497db9c7df23a78", #"hash_5212ed7ec42f115a" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x21fd715d, Offset: 0x3c91
// Size: 0x40
function private function_26cda0e5d8c1d8d2( usable, player )
{
    return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_pap_sync", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xa08c7e2c, Offset: 0x3cda
// Size: 0x3c
function private function_7d71e53ab957d894( skipped, save_restored )
{
    function_4077ce318e4f6d25();
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread function_8ae9f52439cbf094();
    utility::flag_wait( "pap_step_11" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xc76341a7, Offset: 0x3d1e
// Size: 0x8d
function private function_60019f48e78660b3( skipped, save_restored )
{
    profilestart();
    
    if ( skipped && zm_sat_locust_util::is_holdout_event_active( "pap_sync" ) )
    {
        zm_sat_locust_util::end_holdout_event( "pap_sync" );
    }
    
    level thread zm_music::function_e9fd14ede793ef0d( "pap_holdout" );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "pap_step_11" );
    }
    
    level callback::remove( "zone_changed", &function_bee639aa5dc162a );
    level.var_d81bd225c0a774f2 game_utility::questcircle_delete();
    zm_quest::complete_objective_waypoints( #"pap_island" );
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xf07c8c63, Offset: 0x3db3
// Size: 0x54
function private function_4077ce318e4f6d25()
{
    circle_loc = utility::getstruct( "quest_pap_circle" );
    level.var_d81bd225c0a774f2 game_utility::questcircle_create( "testCircle_Orange", circle_loc.origin, circle_loc.radius );
    level.var_d81bd225c0a774f2 game_utility::questcircle_showtoall();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xd7f7b288, Offset: 0x3e0f
// Size: 0x1e
function private function_8ae9f52439cbf094()
{
    utility::flag_wait( "begin_round_logic" );
    level thread function_6855c0f075d99040();
    level thread function_525f0c3d63bec51b();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xa78beeb, Offset: 0x3e35
// Size: 0xf4
function private function_6855c0f075d99040()
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        difficulty_round_number = zm_round_logic::get_rb_round_number();
    }
    else
    {
        difficulty_round_number = 10;
    }
    
    params = { #max_active_zombies:10, #var_98f23c369371e8ec:1, #var_d346909023f61570:1, #difficulty_round_number:difficulty_round_number, #spawner_zombie_type:"zombie_base", #var_1e899b25f3766233:1, #spawn_zones:[ zone_manager::get_zone_struct( "zone_fishery" ) ], #name:"pap_sync" };
    
    if ( !level callback::exists( "zone_changed", &function_bee639aa5dc162a ) )
    {
        level callback::add( "zone_changed", &function_bee639aa5dc162a );
    }
    
    level thread zm_music::start_zone_music_watcher( "pap_holdout", [ "zone_fishery", "zone_fishery_lab" ], #"pap_defend_loop" );
    zm_sat_locust_util::holdout_event( params );
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x7ea041be, Offset: 0x3f31
// Size: 0x197
function private function_525f0c3d63bec51b()
{
    level endon( #"zm_game_over" );
    level endon( #"pap_step_11" );
    total_time = 45;
    total_rate = int( ceil( total_time / level.framedurationseconds ) * level.frameduration );
    add_rate = level.frameduration;
    rate = 0;
    pct_rate = 0;
    var_a19d01d7a35bd64c = 0;
    
    while ( rate < total_rate )
    {
        players = function_553661671e19df66();
        
        if ( players.size > 0 )
        {
            if ( pct_rate == 0 )
            {
                utility::array_call( players, &playsoundevent, %"hash_513744ae1a8735e6" );
            }
            
            rate += add_rate;
            var_5798b94641746a54 = rate / total_rate * 60;
            pct_rate = rate / total_rate * 100;
            zm_quest::function_9f49b2a045ece8ae( var_5798b94641746a54, 1, #"locust_quest_pap", #"hash_6e5532f77e42c61c" );
            base_pct = int( pct_rate );
            
            if ( base_pct > 0 && base_pct % 5 == 0 && base_pct != var_a19d01d7a35bd64c )
            {
                utility::array_call( players, &playsoundevent, %"hash_759a48be0a17d26d" );
                var_a19d01d7a35bd64c = base_pct;
            }
        }
        
        waitframe();
    }
    
    utility::array_call( players, &playsoundevent, %"hash_7c449f989767c8b" );
    level thread zm_music::function_e9fd14ede793ef0d( "pap_holdout" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"pap_defend_success" );
    zm_sat_locust_util::end_holdout_event( "pap_sync" );
    utility::flag_set( "pap_step_11" );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x444e0b7e, Offset: 0x40d0
// Size: 0xd8
function private function_bee639aa5dc162a( params )
{
    if ( params.zone_struct.zone_name == "zone_fishery" || params.zone_struct.zone_name == "zone_fishery_lab" || !isdefined( params.previous_zone_struct ) )
    {
        occupants = function_553661671e19df66();
        
        if ( occupants.size == 0 && zm_sat_locust_util::is_holdout_event_active( "pap_sync" ) )
        {
            utility::array_call( utility::get_alive_players(), &playsoundevent, %"hash_3397ebc7b8f91548" );
            zm_sat_locust_util::end_holdout_event( "pap_sync" );
            level thread zm_sat_locust_util::function_a8b578b47e763d0f( "dx_zm_lpwp_lpp2_typa_lpp2paresy" );
            return;
        }
        
        if ( occupants.size > 0 && !zm_sat_locust_util::is_holdout_event_active( "pap_sync" ) )
        {
            level thread function_6855c0f075d99040();
        }
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xe924d4c7, Offset: 0x41b0
// Size: 0x2e
function private function_553661671e19df66()
{
    occupants = zone_manager::get_zone_occupants( "zone_fishery" );
    occupants = arraycombineunique( occupants, zone_manager::get_zone_occupants( "zone_fishery_lab" ) );
    return occupants;
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xd1a351a8, Offset: 0x41e7
// Size: 0x115
function private function_7d71e83ab957df2d( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level.var_d81bd225c0a774f2 game_utility::questcircle_create( "testCircle_Orange", level.var_d81bd225c0a774f2.mdl.origin, 128 );
    level.var_d81bd225c0a774f2 game_utility::questcircle_showtoall();
    level.var_d81bd225c0a774f2.mdl.objid = zm_quest::function_b98d4144845ffc13( #"pap_aimer", 0, "ui_icon_zm_objective", "icon_small_medium", "current", level.var_d81bd225c0a774f2.mdl.origin + ( 0, 0, 32 ), 100, undefined, undefined, 1, 1 );
    level callback::add( #"hash_2767e511882e6794", &function_7ce7006a64c98248 );
    level callback::add( #"hash_2eec00c5f9affd9b", &function_4207c13c1322c496 );
    level thread function_715b1353c32bd103();
    utility::flag_wait( "pap_step_12" );
}

// Namespace zm_sat_locust_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x5e5fd4b7, Offset: 0x4304
// Size: 0x2b8
function private function_6001a048e78662e6( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "pap_step_12" );
    }
    
    level.fishing_struct.force_rcxd = 1;
    level.fishing_struct.force_glocke = 1;
    level.var_d81bd225c0a774f2 game_utility::questcircle_delete();
    level.var_d81bd225c0a774f2.mdl.interact setusableenabled( 0 );
    level.var_d81bd225c0a774f2.mdl setscriptablepartstate( #"warp", #"warp_in_fast" );
    players = function_553661671e19df66();
    
    if ( players.size > 0 )
    {
        player = function_47c86977a18df38b( players, level.var_d81bd225c0a774f2.mdl.origin );
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"papq_react", #"bc_flavor_player_positive" );
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"pap_blocker" ) )
    {
        blocker = zm_sat_locust_util::get_quest_reference( #"pap_blocker" );
        blocker.fx setscriptablepartstate( #"sat_zm_locust_pap_blocker", #"explode" );
        blocker.fx utility::delaycall( 5, &freescriptable );
        blocker delete();
    }
    
    zm_quest::complete_objective_waypoints( #"pap_aimer" );
    level callback::remove( #"hash_2767e511882e6794", &function_7ce7006a64c98248 );
    level callback::remove( #"hash_2eec00c5f9affd9b", &function_4207c13c1322c496 );
    level callback::remove( #"killstreak_can_trigger", &function_8d72823f2d366bb4 );
    level.fishing_struct.loot_index = 1;
    utility::flag_set( "power_on_pap" );
    level val::reset( #"locust_quest_pap", "task_logic_activate" );
    
    if ( !getdvarint( @"enable_locust_mq", 0 ) && zm_sat_locust_util::function_3112dc4740eb8499( #"hash_25f192b7bac57fef" ) )
    {
        station = zm_sat_locust_util::get_quest_reference( #"hash_25f192b7bac57fef" );
        station.controller setscriptablepartstate( station.controller function_84ad2f70189ee7c3(), #"visible" );
        setomnvar( o"ui_item_bernard_secondary_allowed", 1 );
    }
    
    level thread zm_sat_locust_util::terminal_set_state( #"online_2" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x44e763c0, Offset: 0x45c4
// Size: 0x66
function private function_8aa3994b6dddbcfa()
{
    blocker = getent( "pap_blocker", #targetname );
    
    if ( blocker )
    {
        blocker.fx = spawnscriptable( %"sat_zm_locust_pap_blocker", blocker.origin, blocker.angles );
        zm_sat_locust_util::function_295a36ef38f5acae( #"pap_blocker", blocker );
    }
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xd24b8ba1, Offset: 0x4632
// Size: 0x10e
function private function_715b1353c32bd103()
{
    if ( zm_save::function_1dda3554974a999e() && !utility::flag( "begin_round_logic" ) )
    {
        utility::flag_wait( "begin_round_logic" );
    }
    
    occupants = function_553661671e19df66();
    
    if ( occupants.size == 0 )
    {
        occupants = utility::get_alive_players();
    }
    
    assert( occupants.size > 0 );
    player = function_b21056d585c710d( occupants, level.var_d81bd225c0a774f2.mdl.origin );
    
    if ( !player )
    {
        assert( level.players.size, "<dev string:x4e>" );
        player = level.players[ 0 ];
        
        if ( !player )
        {
            return;
        }
    }
    
    streakinfo = player killstreak_utility::createstreakinfo( "zm_bernard_primary", player );
    streakinfo.targetoverride = level.var_d81bd225c0a774f2.mdl.origin;
    streakinfo.var_9384480e6997afd7 = 1;
    player zm_robot_controller::controller_use( streakinfo );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0xc1a31d22, Offset: 0x4748
// Size: 0xae
function private function_7ce7006a64c98248( params )
{
    player = params.player;
    position = params.position;
    streakinfo = params.streakinfo;
    
    if ( !isdefined( streakinfo.targetoverride ) )
    {
        return;
    }
    
    params.position = level.var_d81bd225c0a774f2.mdl.origin;
    params.type = "delivery_quest";
    level callback::remove( #"hash_2767e511882e6794", &function_7ce7006a64c98248 );
}

// Namespace zm_sat_locust_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x716f95c4, Offset: 0x47fe
// Size: 0xa9
function private function_4207c13c1322c496( params )
{
    level endon( #"pap_step_12" );
    drop = params.drop;
    
    if ( drop.params.type != "delivery_quest" )
    {
        return;
    }
    
    glocke = drop.glocke;
    glocke.land_override = &function_d9939cf9773aaca2;
    level callback::remove( #"hash_2eec00c5f9affd9b", &function_4207c13c1322c496 );
    drop waittill( #"drop_completed" );
    utility::flag_set_delayed( "pap_step_12", 0.25 );
}

// Namespace zm_sat_locust_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xb909ce4d, Offset: 0x48af
// Size: 0x7b
function private function_d9939cf9773aaca2()
{
    self endon( #"death" );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"pap_blocker" ) )
    {
        blocker = zm_sat_locust_util::get_quest_reference( #"pap_blocker" );
        blocker.fx setscriptablepartstate( #"sat_zm_locust_pap_blocker", #"explode" );
        blocker.fx utility::delaycall( 5, &freescriptable );
        blocker delete();
    }
}

