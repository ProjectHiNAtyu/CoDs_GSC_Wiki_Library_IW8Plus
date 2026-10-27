// script_cb42c5f594fc5e1  (hash_0cb42c5f594fc5e1.gscc) (size: 12002 Bytes / 0x2ee2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8c9c983e (2359072830)
// size ...... 12002 (0x2ee2)
// includes .. 19  (offset: 0x2bde)
// strings ... 35  (offset: 0x2c76)
// dev strs .. 8   (offset: 0x2e82)
// exports ... 28  (offset: 0x1a4e)
// cseg ...... 0x33c + 0x1712 (0x1a4e)
// imports ... 104 (offset: 0x1eae)
// animtree1 . 0   (offset: 0x2ee2)
// animtree2 . 0   (offset: 0x2ee2)
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\interaction;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace namespace_f3578dc85bdbb3e5;

// Namespace namespace_f3578dc85bdbb3e5
// Params 0, eflags: 0x5
// Checksum 0x851016b1, Offset: 0x35a
// Size: 0x37
function private autoexec __init__system__()
{
    system::register( #"hash_4f8df8efe261fec1", [ #"zm_quest", #"hash_709d77ab2b2005c5" ], &pre_main, &post_main );
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 0, eflags: 0x4
// Checksum 0xb797cec, Offset: 0x399
// Size: 0xb5
function private pre_main()
{
    if ( !getdvarint( @"hash_42cdb7fc777fae63", 0 ) )
    {
        return;
    }
    
    level.quest_ww.lantern_quest = spawnstruct();
    level.quest_ww.lantern_quest.var_96e0e70be4cf684e = 0;
    zm_quest::register_quest_step( #"hash_4f8df8efe261fec1", #"hash_aa48d5bef44324c6", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"hash_4f8df8efe261fec1", #"acquire_bait", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
    zm_quest::register_quest_step( #"hash_4f8df8efe261fec1", #"collect_lantern", &function_7d6d5f3ab952bc0b, &function_60062148e78b7470 );
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 0, eflags: 0x4
// Checksum 0xf02f7956, Offset: 0x456
// Size: 0x66
function private post_main()
{
    if ( !getdvarint( @"hash_42cdb7fc777fae63", 0 ) )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level thread function_a15039f7d4d0e25e();
    level thread function_17ff6094fce956d();
    level callback::add( "quest_item_used", &function_b737e1af0d05ce6d );
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_4f8df8efe261fec1" );
    
    /#
        debug_init();
    #/
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 2, eflags: 0x4
// Checksum 0xe3a29d04, Offset: 0x4c4
// Size: 0x2d
function private function_7d6d613ab952c071( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "pap_step_04" );
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 2, eflags: 0x4
// Checksum 0xf4482887, Offset: 0x4f9
// Size: 0x3a
function private function_60062348e78b78d6( skipped, save_restored )
{
    profilestart();
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 2, eflags: 0x4
// Checksum 0xccaf5c1, Offset: 0x53b
// Size: 0x70
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_bait" ) )
    {
        bait = zm_sat_locust_util::get_quest_reference( #"ww_bait" );
        bait setscriptablepartstate( bait function_84ad2f70189ee7c3(), #"visible" );
    }
    
    utility::flag_wait( "ww_burgess_step_02" );
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 2, eflags: 0x4
// Checksum 0xbeab11f6, Offset: 0x5b3
// Size: 0xd5
function private function_60062248e78b76a3( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "ww_burgess_step_02" );
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_bait" ) )
        {
            bait = zm_sat_locust_util::get_quest_reference( #"ww_bait" );
            bait freescriptable();
        }
        
        zm_quest::function_b57dfe9625966b0b( #"hash_709d77ab2b2005c5", 0, #"hash_9a24f69baa0a7051", 1 );
    }
    
    level callback::remove( "quest_item_used", &function_b737e1af0d05ce6d );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        bait_trap = zm_sat_locust_util::get_quest_reference( #"hash_9435edf7f1f7c29e" );
        bait_trap game_utility::questcircle_delete();
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 0, eflags: 0x4
// Checksum 0x86e97f58, Offset: 0x690
// Size: 0xd1
function private function_a15039f7d4d0e25e()
{
    utility::flag_wait( "scriptables_ready" );
    bait_loc = utility::getstruct( "ww_ba_lo" );
    asset = zm_sat_locust_util::get_quest_item_ref( %"zmloot_sat_locust_quest_chester" );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:bait_loc.angles, #spawnorigin:bait_loc.origin, #asset:asset };
    bait = zm_sat_locust_util::spawn_quest_item( params );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        bait setscriptablepartstate( bait function_84ad2f70189ee7c3(), #"visible_not_usable" );
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"ww_bait", bait );
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 1, eflags: 0x4
// Checksum 0x6cf7be2b, Offset: 0x769
// Size: 0xc8
function private function_b737e1af0d05ce6d( params )
{
    switch ( params.bundle.scriptable )
    {
        case %"zmloot_sat_locust_quest_chester_guided":
        case %"zmloot_sat_locust_quest_chester":
            utility::flag_set( "ww_burgess_step_02" );
            zm_quest::function_b57dfe9625966b0b( #"hash_709d77ab2b2005c5", 0, #"hash_9a24f69baa0a7051", 1 );
            zm_quest::show_splash_item_picked_up( #"hash_709d77ab2b2005c5", #"hash_9a24f69baa0a7051", 1, params.player );
            zm_sat_locust_util::function_63a23256772ea1b9( params.player );
            params.player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_f440050b1ea309ef", #"hash_5212ed7ec42f115a" );
            break;
    }
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 2, eflags: 0x4
// Checksum 0x1335502f, Offset: 0x839
// Size: 0x215
function private function_7d6d5f3ab952bc0b( skipped, save_restored )
{
    bait_trap = zm_sat_locust_util::get_quest_reference( #"hash_9435edf7f1f7c29e" );
    
    if ( skipped || save_restored )
    {
        bait_trap setscriptablepartstate( #"body", #"visible" );
        bait_trap setscriptablepartstate( #"usable", #"disabled" );
        return;
    }
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        hvt_killed = zm_quest::function_73720cdf21c3cfd7( #"hash_4f8df8efe261fec1", #"hvt_killed" );
        
        if ( hvt_killed )
        {
            bait_trap setscriptablepartstate( #"body", #"visible" );
            bait_trap setscriptablepartstate( #"usable", #"disabled" );
            level utility::flag_set( "b_used_block" );
            failsafe = utility::getstruct( "ww_bu_fa" );
            drop_pos = failsafe.origin;
            params = { #spawntype:#"spawn_at_pos", #spawnangles:undefined, #spawnorigin:drop_pos, #asset:%"zmloot_sat_locust_quest_burgess" };
            var_cb5369743609abbe = zm_sat_locust_util::spawn_quest_item( params );
            zm_sat_locust_util::function_295a36ef38f5acae( #"ww_lantern", var_cb5369743609abbe );
            level callback::add( "quest_item_used", &function_ff492f29ccb83e0 );
            
            if ( zm_quest::function_b0a5181ebe7bb905() )
            {
                utility::flag_set( "ww_burgess_dm_place_bait" );
            }
            
            utility::flag_set( "ww_burgess_step_03_a" );
            utility::flag_set( "ww_burgess_step_03_b" );
            
            if ( zm_quest::function_b0a5181ebe7bb905() )
            {
                level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
            }
        }
        else
        {
            bait_trap setscriptablepartstate( #"usable", #"enabled" );
        }
    }
    else
    {
        bait_trap setscriptablepartstate( #"usable", #"enabled" );
    }
    
    utility::flag_wait( "ww_burgess_step_03" );
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 2, eflags: 0x4
// Checksum 0xf1f2289b, Offset: 0xa56
// Size: 0x1d7
function private function_60062148e78b7470( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "ww_burgess_step_03_a" );
        utility::flag_set( "ww_burgess_step_03_b" );
        utility::flag_set( "ww_burgess_step_03" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            utility::flag_set( "ww_burgess_dm_place_bait" );
            level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        }
        
        if ( isalive( level.quest_ww.lantern_quest.var_d77d0f53fb0b9b97 ) )
        {
            level.quest_ww.lantern_quest.var_d77d0f53fb0b9b97 callback::remove( "on_zombie_ai_killed", &function_a812dcaa68d0c073 );
            level.quest_ww.lantern_quest.var_d77d0f53fb0b9b97 kill();
            level.quest_ww.lantern_quest.var_d77d0f53fb0b9b97 = undefined;
        }
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_lantern" ) )
        {
            var_cb5369743609abbe = zm_sat_locust_util::get_quest_reference( #"ww_lantern" );
            var_cb5369743609abbe freescriptable();
        }
        
        zm_quest::function_b57dfe9625966b0b( #"hash_709d77ab2b2005c5", 0, #"lantern", 1 );
    }
    
    level callback::remove( "special_round_scheduled", &function_8e73808b6aad307c );
    level callback::remove( "on_round_start", &function_ef8d6ad1e41a62b5 );
    level callback::remove( "special_round_allow_shadowsmith", &function_cd634b811f8c2d8b );
    level callback::remove( "quest_item_used", &function_ff492f29ccb83e0 );
    level.var_23378cc637cedbd7 = undefined;
    utility::flag_set( "ww_burgess_core" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 0, eflags: 0x4
// Checksum 0xea50611f, Offset: 0xc35
// Size: 0xac
function private function_17ff6094fce956d()
{
    var_2d3ccd7fcded97b9 = utility::getstruct( "ww_ba_tr" );
    bait_trap = spawnscriptable( %"sat_zm_prop_chester", var_2d3ccd7fcded97b9.origin, var_2d3ccd7fcded97b9.angles );
    bait_trap.loc = var_2d3ccd7fcded97b9;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        hint = utility::callsharedfunc( #"directed_mode", #"get_interact_func", %"sat_zm_prop_chester" );
    }
    
    interaction::register_scriptable_interact( bait_trap, &function_57b6088e88112a9e, undefined, undefined, hint );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_9435edf7f1f7c29e", bait_trap );
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 1, eflags: 0x4
// Checksum 0x73643660, Offset: 0xce9
// Size: 0x135
function private function_57b6088e88112a9e( player )
{
    if ( level utility::flag( "ww_quest_block_cr" ) )
    {
        return;
    }
    
    self setscriptablepartstate( #"body", #"visible" );
    self setscriptablepartstate( #"usable", #"disabled" );
    level utility::flag_set( "b_used_block" );
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_432de8e7538210f7", player );
    set_1 = [ "dx_zm_lown_low1_lvtw_lw1plcna1ln1", "dx_zm_lown_low1_detw_lw1plcna1ln2" ];
    set_2 = [ "dx_zm_lown_low1_detw_lw1plcna2ln1", "dx_zm_lown_low1_lvtw_lw1plcna2ln2" ];
    level thread zm_sat_locust_util::function_1d7335486cb891d8( set_1, set_2 );
    level thread function_1b74b5ef28ef8a58();
    level callback::add( "on_round_start", &function_ef8d6ad1e41a62b5 );
    level callback::add( "special_round_allow_shadowsmith", &function_cd634b811f8c2d8b );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        game_utility::questcircle_create( "testCircle_Orange", self.origin, 640 );
        game_utility::questcircle_showtoall();
        utility::flag_set( "ww_burgess_dm_place_bait" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 0, eflags: 0x4
// Checksum 0xcdccbd91, Offset: 0xe26
// Size: 0x1a8
function private function_1b74b5ef28ef8a58()
{
    var_96e0e70be4cf684e = getarraykey( level.var_a009ab14ee0d3223.specialroundspawns, 0 );
    curr_round = zm_round_logic::get_rb_round_number();
    
    if ( curr_round < 10 )
    {
        request_round = 10;
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            request_round = min( zm_round_logic::get_rb_round_cap(), zm_round_logic::get_rb_round_number() + 1 );
            zm_round_spawning::function_9fd9e12523021d1d( var_96e0e70be4cf684e, request_round );
            level.quest_ww.lantern_quest.var_96e0e70be4cf684e = getarraykey( level.var_a009ab14ee0d3223.specialroundspawns, 0 );
        }
        else if ( var_96e0e70be4cf684e == request_round )
        {
            level.quest_ww.lantern_quest.var_96e0e70be4cf684e = var_96e0e70be4cf684e;
        }
        else if ( var_96e0e70be4cf684e > request_round )
        {
            zm_round_spawning::function_9fd9e12523021d1d( var_96e0e70be4cf684e, request_round );
            level.quest_ww.lantern_quest.var_96e0e70be4cf684e = getarraykey( level.var_a009ab14ee0d3223.specialroundspawns, 0 );
        }
        else
        {
            level callback::add( "special_round_scheduled", &function_8e73808b6aad307c );
        }
    }
    else
    {
        request_round = curr_round + 1;
        
        if ( request_round != var_96e0e70be4cf684e )
        {
            zm_round_spawning::function_9fd9e12523021d1d( var_96e0e70be4cf684e, curr_round + 1 );
        }
        
        level.quest_ww.lantern_quest.var_96e0e70be4cf684e = getarraykey( level.var_a009ab14ee0d3223.specialroundspawns, 0 );
    }
    
    level.disable_zm_exfil = 1;
    level val::set( #"ww_quest", "task_logic_activate", 0 );
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 1, eflags: 0x4
// Checksum 0x229d3515, Offset: 0xfd6
// Size: 0x9b
function private function_8e73808b6aad307c( params )
{
    special_round_number = params.roundnumber;
    
    if ( special_round_number == 10 )
    {
        level.quest_ww.lantern_quest.var_96e0e70be4cf684e = special_round_number;
        level callback::remove( "special_round_scheduled", &function_8e73808b6aad307c );
        return;
    }
    
    level callback::remove( "special_round_scheduled", &function_8e73808b6aad307c );
    zm_round_spawning::function_9fd9e12523021d1d( special_round_number, 10 );
    level.quest_ww.lantern_quest.var_96e0e70be4cf684e = 10;
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 1, eflags: 0x4
// Checksum 0x42f7d9c9, Offset: 0x1079
// Size: 0x7c
function private function_ef8d6ad1e41a62b5( params )
{
    if ( params.roundnumber != level.quest_ww.lantern_quest.var_96e0e70be4cf684e )
    {
        return;
    }
    
    assert( zm_round_spawning::is_special_round( params.roundnumber ), "<dev string:x24>" + params.roundnumber + "<dev string:x2b>" );
    level thread function_1da6c8d10cb13f23( params.roundnumber );
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 1, eflags: 0x4
// Checksum 0x769ce330, Offset: 0x10fd
// Size: 0xd, Type: bool
function private function_cd634b811f8c2d8b( params )
{
    return false;
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 1, eflags: 0xc
// Checksum 0xba4ddce1, Offset: 0x1113
// Size: 0x225
function private function_1da6c8d10cb13f23( roundnumber )
{
    self notify( #"hash_1815fe0a74658c98" );
    self endon( #"hash_1815fe0a74658c98" );
    level endon( #"game_ended" );
    level endon( #"on_round_end" );
    level endon( #"ww_burgess_step_03_a" );
    assert( !isdefined( level.var_23378cc637cedbd7 ) );
    level.var_23378cc637cedbd7 = &function_39f65238c251fff2;
    wait level.var_6781718da4f78d1c.spawndelay;
    
    if ( !isdefined( roundnumber ) )
    {
        roundnumber = zm_round_logic::get_rb_round_number();
    }
    
    var_f3c67df5fce3389a = 50;
    
    /#
        var_f3c67df5fce3389a = getdvarfloat( @"hash_bb168a31445eaee6", var_f3c67df5fce3389a );
    #/
    
    var_30085f70fc117162 = utility::getstruct( "ww_ca" );
    
    for ( ;; )
    {
        round_pct = zm_round_spawning::get_round_progress_percent();
        
        if ( round_pct < var_f3c67df5fce3389a )
        {
            wait 0.25;
            continue;
        }
        
        if ( !isalive( level.quest_ww.lantern_quest.var_d77d0f53fb0b9b97 ) )
        {
            while ( !zm_utility::function_922d522db5f1ceda( 1, [ "hvt" ], undefined ) )
            {
                wait 0.5;
            }
            
            params = { #allow_cleanup:1, #skip_values:1, #var_30085f70fc117162:var_30085f70fc117162, #difficulty_round_number:roundnumber, #spawner_zombie_type:"zombie_callisto_hvt" };
            var_d77d0f53fb0b9b97 = zm_sat_locust_util::spawn_quest_zombie( params );
            
            if ( !isdefined( var_d77d0f53fb0b9b97 ) )
            {
                wait 0.5;
                continue;
            }
            
            var_d77d0f53fb0b9b97 zombie_callisto::function_4b705a0e1a9137e8( 0 );
            var_d77d0f53fb0b9b97 val::set( "spawn_protection", "damageshield", 1 );
            var_d77d0f53fb0b9b97.var_825b17c932865df = 1;
            var_d77d0f53fb0b9b97 thread zone_spawner::function_f9d3af30e993a949();
            var_d77d0f53fb0b9b97 callback::add( "in_playable_space", &function_19bef56f31ea1ceb );
            var_d77d0f53fb0b9b97.banter_played = 0;
            var_d77d0f53fb0b9b97 callback::add( "killed_body_cloned", &function_a812dcaa68d0c073 );
            level.quest_ww.lantern_quest.var_d77d0f53fb0b9b97 = var_d77d0f53fb0b9b97;
            utility::flag_set( "ww_burgess_step_03_a" );
        }
    }
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 1, eflags: 0x4
// Checksum 0x6ecc4e76, Offset: 0x1340
// Size: 0x11d
function private function_19bef56f31ea1ceb( params )
{
    val::reset_all( "spawn_protection" );
    
    if ( self.banter_played )
    {
        return;
    }
    
    zursa_player_range = 1024;
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_432de8e7538210f7" ) )
    {
        player = zm_sat_locust_util::get_quest_reference( #"hash_432de8e7538210f7" );
        in_range = zm_utility::is_player_valid_target( player ) && distancesquared( player.origin, self.origin ) <= squared( zursa_player_range );
    }
    
    if ( !in_range )
    {
        player = zm_sat_locust_util::function_3587bfca3892d37b( self.origin, zursa_player_range );
    }
    
    if ( player )
    {
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_f834a02a3ead8bfc", #"bc_flavor_player_negative" );
        self.banter_played = 1;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        bait_trap = zm_sat_locust_util::get_quest_reference( #"hash_9435edf7f1f7c29e" );
        bait_trap game_utility::questcircle_delete();
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 1, eflags: 0x4
// Checksum 0x7121808c, Offset: 0x1465
// Size: 0x27b
function private function_a812dcaa68d0c073( params )
{
    zm_quest::function_4eefe6de31f5ddab( #"hash_4f8df8efe261fec1", #"hvt_killed", 1 );
    level.disable_zm_exfil = undefined;
    level val::reset( #"ww_quest", "task_logic_activate" );
    level callback::add( "quest_item_used", &function_ff492f29ccb83e0 );
    level callback::remove( "on_round_start", &function_ef8d6ad1e41a62b5 );
    level callback::remove( "special_round_allow_shadowsmith", &function_cd634b811f8c2d8b );
    body = zombie_utils::function_4e99fb1239980783( params );
    start_pos = body.origin;
    
    if ( !self.forceannihilate )
    {
        body utility::waittill_any( "death_explode", "corpse_deleted" );
    }
    
    utility::flag_set( "ww_burgess_step_03_b" );
    level.quest_ww.lantern_quest.var_d77d0f53fb0b9b97 = undefined;
    tacpoint = ai::function_20e2b5e7fcba9f36( start_pos, 512, 0 );
    
    if ( tacpoint )
    {
        drop_pos = getgroundposition( tacpoint.origin, 8 );
    }
    else if ( zone_manager::function_65305a611c6226d9( start_pos ) )
    {
        drop_pos = start_pos;
    }
    
    if ( drop_pos )
    {
        if ( self.subclass == "zombie_callisto_hvt" )
        {
            params = { #spawntype:#"hash_5624a153809c30bc", #toangles:undefined, #spawningent:self, #toorigin:drop_pos, #asset:%"zmloot_sat_locust_quest_burgess" };
        }
        else
        {
            params = { #spawntype:#"spawn_at_pos", #spawnangles:undefined, #spawnorigin:drop_pos, #asset:%"zmloot_sat_locust_quest_burgess" };
        }
    }
    else
    {
        failsafe = utility::getstruct( "ww_bu_fa" );
        drop_pos = failsafe.origin;
        params = { #spawntype:#"spawn_at_pos", #spawnangles:undefined, #spawnorigin:drop_pos, #asset:%"zmloot_sat_locust_quest_burgess" };
    }
    
    var_cb5369743609abbe = zm_sat_locust_util::spawn_quest_item( params );
    zm_sat_locust_util::function_295a36ef38f5acae( #"ww_lantern", var_cb5369743609abbe );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 1, eflags: 0x4
// Checksum 0xa639c208, Offset: 0x16e8
// Size: 0xb2
function private function_ff492f29ccb83e0( params )
{
    if ( params.bundle.scriptable == %"zmloot_sat_locust_quest_burgess" )
    {
        utility::flag_set( "ww_burgess_step_03" );
        zm_quest::function_b57dfe9625966b0b( #"hash_709d77ab2b2005c5", 0, #"lantern", 1 );
        zm_quest::show_splash_item_picked_up( #"hash_709d77ab2b2005c5", #"lantern", 1, params.player );
        zm_sat_locust_util::function_63a23256772ea1b9( params.player );
        params.player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_8aee83839daa5afd", #"bc_flavor_player_positive" );
    }
}

// Namespace namespace_f3578dc85bdbb3e5
// Params 1, eflags: 0x4
// Checksum 0xf2ba4155, Offset: 0x17a2
// Size: 0x27, Type: bool
function private function_39f65238c251fff2( bgb )
{
    if ( bgb == "round_off" || bgb == "time_out" )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace namespace_f3578dc85bdbb3e5
    // Params 0, eflags: 0x4
    // Checksum 0x60f39369, Offset: 0x17d2
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_f3578dc85bdbb3e5
    // Params 0, eflags: 0x4
    // Checksum 0x1449e514, Offset: 0x17e6
    // Size: 0x48, Type: dev
    function private devgui_init()
    {
        zm_quest::function_bc99f123a684344f( #"hash_709d77ab2b2005c5" );
        devgui::add_devgui_func( "<dev string:x58>", "<dev string:x70>", &function_f022c6f67cf1d803 );
        devgui::add_devgui_func( "<dev string:x7c>", "<dev string:x8c>", &function_aa62eba9446122b1 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace namespace_f3578dc85bdbb3e5
    // Params 0, eflags: 0x4
    // Checksum 0xe20cdff6, Offset: 0x1836
    // Size: 0x124, Type: dev
    function private function_f022c6f67cf1d803()
    {
        zm_utility::open_sesame();
        var_3fb6e6959465a40a = [ #"locust_quest_pap" ];
        
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

    // Namespace namespace_f3578dc85bdbb3e5
    // Params 0, eflags: 0x4
    // Checksum 0x2e9cf6bb, Offset: 0x1962
    // Size: 0xd, Type: dev
    function private function_aa62eba9446122b1()
    {
        level thread function_b2c342e12e209632();
    }

    // Namespace namespace_f3578dc85bdbb3e5
    // Params 0, eflags: 0x4
    // Checksum 0x959f9e37, Offset: 0x1977
    // Size: 0xd7, Type: dev
    function private function_b2c342e12e209632()
    {
        player = level.player;
        var_30085f70fc117162 = { #angles:player.angles, #origin:player.origin };
        params = { #allow_cleanup:1, #skip_values:1, #var_30085f70fc117162:var_30085f70fc117162, #difficulty_round_number:1, #spawner_zombie_type:"<dev string:x9b>" };
        var_d77d0f53fb0b9b97 = zm_sat_locust_util::spawn_quest_zombie( params );
        
        if ( !isdefined( var_d77d0f53fb0b9b97 ) )
        {
            return;
        }
        
        var_d77d0f53fb0b9b97 zombie_callisto::function_4b705a0e1a9137e8( 0 );
        var_d77d0f53fb0b9b97.var_825b17c932865df = 1;
        var_d77d0f53fb0b9b97 callback::add( "<dev string:xaf>", &function_a812dcaa68d0c073 );
    }

#/
