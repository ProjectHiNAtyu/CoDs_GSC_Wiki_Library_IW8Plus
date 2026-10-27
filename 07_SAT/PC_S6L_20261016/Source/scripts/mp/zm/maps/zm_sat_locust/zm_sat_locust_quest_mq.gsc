// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_quest_mq.gsc  (hash_0aeed3aac44aa17d.gscc) (size: 5551 Bytes / 0x15af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc8d636d (210592621)
// size ...... 5551 (0x15af)
// includes .. 13  (offset: 0x1453)
// strings ... 15  (offset: 0x14bb)
// dev strs .. 2   (offset: 0x1597)
// exports ... 17  (offset: 0xa47)
// cseg ...... 0x1b5 + 0x892 (0xa47)
// imports ... 64  (offset: 0xcef)
// animtree1 . 0   (offset: 0x15af)
// animtree2 . 0   (offset: 0x15af)
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\interaction;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_boss_fight;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_ee_richtofen;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_rej;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_locust_quest_mq;

// Namespace zm_sat_locust_quest_mq
// Params 0, eflags: 0x5
// Checksum 0x1ffa5bc6, Offset: 0x1d3
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"locust_mq", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_locust_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x936d8778, Offset: 0x200
// Size: 0x68
function private pre_main()
{
    if ( !getdvarint( @"enable_locust_mq", 0 ) )
    {
        return;
    }
    
    level.quest_mq = spawnstruct();
    zm_quest::register_quest_step( #"locust_mq", #"hash_191e39148b091f7", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"locust_mq", #"boss_fight", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
}

// Namespace zm_sat_locust_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x3388bace, Offset: 0x270
// Size: 0x64
function private post_main()
{
    if ( !getdvarint( @"enable_locust_mq", 0 ) )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level thread function_fddfe644055041bb();
    zm_quest::function_3c363613c60958f5( "mq_encounter_starting" );
    zm_save::function_1f44a48caae2acbf();
    utility::flag_wait( "onStartGameTypeFinished" );
    level thread zm_quest::start_quest( #"locust_mq" );
    
    /#
        debug_init();
    #/
}

// Namespace zm_sat_locust_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xf1878baf, Offset: 0x2dc
// Size: 0x35
function private function_7d6d613ab952c071( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread locate_monitor();
    utility::flag_wait( "mq_step_01" );
}

// Namespace zm_sat_locust_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x8782a022, Offset: 0x319
// Size: 0x2e
function private function_60062348e78b78d6( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_step_01" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x6d84f3e0, Offset: 0x34f
// Size: 0x37
function private function_fddfe644055041bb()
{
    utility::flag_wait( "scriptables_ready" );
    lair_loc = utility::getstruct( "mq_vi_la" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"virgil_lair", lair_loc );
}

// Namespace zm_sat_locust_quest_mq
// Params 0, eflags: 0x4
// Checksum 0xace8ffaf, Offset: 0x38e
// Size: 0x99
function private locate_monitor()
{
    level endon( #"mq_step_01" );
    utility::flag_wait( "mq_rl_step_05" );
    lair_loc = zm_sat_locust_util::get_quest_reference( #"virgil_lair" );
    lair = spawnscriptable( %"sat_zm_prop_virgil", lair_loc.origin, lair_loc.angles );
    lair setscriptablepartstate( #"sat_zm_prop_virgil", #"active" );
    zm_sat_locust_util::function_222215ce3aef9da1( #"virgil_lair", lair );
    utility::flag_set( "mq_step_01" );
}

// Namespace zm_sat_locust_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xbcef9cc4, Offset: 0x42f
// Size: 0xf3
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    function_dbec36aeacd69af0();
    utility::flag_wait( "boss_vote_passed" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_e3aec2d006eaaee5", #"hash_c6726fcf33a632ae" );
        utility::flag_clear( "mq_bs_show_guidance" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    zm_round_spawning::pause_round_spawning( 1, "locust_boss_pause_round_spawning" );
    zm_utility::util_kill_all_zombies();
    utility::array_thread( level.players, &zm_sat_locust_boss_fight::function_77bf79da6a2825ec );
    level thread zm_sat_locust_boss_fight::start_boss_fight( 1 );
    utility::flag_wait( "mq_step_02" );
    utility::flag_clear( "mq_encounter_starting" );
    zm_round_spawning::pause_round_spawning( 0, "main_quest_pause_spawning" );
    zm_quest::function_4eefe6de31f5ddab( #"locust_mq", #"quest_complete", 1 );
}

// Namespace zm_sat_locust_quest_mq
// Params 2, eflags: 0x4
// Checksum 0x376dbab, Offset: 0x52a
// Size: 0x61
function private function_60062248e78b76a3( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_step_02" );
    }
    
    terminal = zm_sat_locust_util::get_quest_reference( #"pap_terminal" );
    terminal setusableenabled( 0 );
    zm_sat_locust_util::function_a70056d3a99eace5( #"virgil_lair" );
    profilestop();
}

// Namespace zm_sat_locust_quest_mq
// Params 0, eflags: 0x4
// Checksum 0x72a21158, Offset: 0x593
// Size: 0x4b
function private function_dbec36aeacd69af0()
{
    zm_sat_locust_util::terminal_set_state( #"online_4", 1 );
    terminal = zm_sat_locust_util::get_quest_reference( #"pap_terminal" );
    terminal interaction::set_interact_use_callback( &function_1191b063c9744f64 );
    terminal interaction::set_interact_hint_callback( &function_633af15aa56f9304 );
}

// Namespace zm_sat_locust_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x56754b4a, Offset: 0x5e6
// Size: 0x3d
function private function_1191b063c9744f64( player )
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return;
    }
    
    if ( zm_sat_locust_rej::is_busy() )
    {
        return;
    }
    
    if ( namespace_bc6cf6669176d9b1::is_busy() )
    {
        return;
    }
    
    self setusableenabled( 0 );
    thread trigger_boss_fight_vote( player );
}

// Namespace zm_sat_locust_quest_mq
// Params 2, eflags: 0x4
// Checksum 0xa4b6caba, Offset: 0x62b
// Size: 0xe6
function private function_633af15aa56f9304( interact, player )
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) || zm_sat_locust_rej::is_busy() || namespace_bc6cf6669176d9b1::is_busy() )
    {
        return { #interactable:0, #icon:"ui_icon_zm_ping_enemy_boss", #aux_text:&"zm_sat_locust/hint_mq_final_fight_unavail_desc", #description:&"zm_sat_locust/hint_mq_final_fight_desc", #title:&"zm_sat_locust/hint_mq_final_fight_title", #type:"HINT_BUTTON" };
    }
    
    return { #icon:"ui_icon_zm_ping_enemy_boss", #buttoncallout:&"SHARED_HINTSTRINGS/ENTER_BUTTON", #description:&"zm_sat_locust/hint_mq_final_fight_desc", #title:&"zm_sat_locust/hint_mq_final_fight_title", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_quest_mq
// Params 1, eflags: 0x4
// Checksum 0x41780eb3, Offset: 0x71a
// Size: 0x17f
function private trigger_boss_fight_vote( player )
{
    var_a765a497b222f7e3 = spawnstruct();
    var_a765a497b222f7e3.init_message = &"hash_368ffead421750f5";
    var_a765a497b222f7e3.description = &"zm_hud/start_final_encounter";
    var_61379032dd337c5f = zm_quest::vote_think( player, var_a765a497b222f7e3 );
    dialogue = !player namespace_c0b4f2882c9d100f::is_richtofen() ? "dx_zm_lomn_4bls_typa_ml4bbfv" : "dx_zm_lomn_4bls_typa_ml4bbfvpu";
    
    if ( var_61379032dd337c5f )
    {
        utility::flag_set( "mq_encounter_starting" );
        
        foreach ( player in utility::get_alive_players() )
        {
            if ( player.var_420915a121e1cc41 )
            {
                player notify( #"hash_c14f946ebf4aaea3" );
            }
        }
    }
    
    zm_sat_locust_util::function_a8b578b47e763d0f( dialogue );
    
    if ( var_61379032dd337c5f )
    {
        utility::flag_set( "boss_vote_passed" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            utility::flag_clear( "mq_bs_show_guidance" );
            level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        }
        
        level.disable_fasttravel = 1;
        utility::flag_set( "mq_step_01" );
        return;
    }
    
    utility::delaycall( 1, &setusableenabled, 1 );
}

/#

    // Namespace zm_sat_locust_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0xab36b1be, Offset: 0x8a1
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace zm_sat_locust_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0x2420334f, Offset: 0x8b5
    // Size: 0x32, Type: dev
    function private devgui_init()
    {
        zm_quest::function_bc99f123a684344f( #"locust_mq" );
        devgui::add_devgui_func( "<dev string:x24>", "<dev string:x3c>", &function_fc3e984df968a1f7 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_locust_quest_mq
    // Params 0, eflags: 0x4
    // Checksum 0x4449295, Offset: 0x8ef
    // Size: 0x158, Type: dev
    function private function_fc3e984df968a1f7()
    {
        zm_utility::open_sesame();
        var_3fb6e6959465a40a = [ #"locust_quest_pap", #"hash_709d77ab2b2005c5", #"hash_d1612ed5d50da819", #"hash_7b26a8bb39d7312", #"hash_9a9f22ecb2a5ad11" ];
        
        foreach ( quest in var_3fb6e6959465a40a )
        {
            if ( !zm_quest::is_quest_complete( quest ) )
            {
                zm_quest = zm_quest::get_quest( quest );
                
                foreach ( step in zm_quest.steps )
                {
                    zm_quest::function_e65609834444650c( step );
                }
            }
        }
    }

#/
