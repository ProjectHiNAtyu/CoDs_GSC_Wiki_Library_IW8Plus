// script_4ecd97e5462490d4  (hash_4ecd97e5462490d4.gscc) (size: 6847 Bytes / 0x1abf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6785a65d (1736812125)
// size ...... 6847 (0x1abf)
// includes .. 11  (offset: 0x1963)
// strings ... 19  (offset: 0x19bb)
// dev strs .. 0   (offset: 0x1abf)
// exports ... 18  (offset: 0xe63)
// cseg ...... 0x1c7 + 0xc9c (0xe63)
// imports ... 67  (offset: 0x1133)
// animtree1 . 0   (offset: 0x1abf)
// animtree2 . 0   (offset: 0x1abf)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_player;

#namespace namespace_51b8e453cf2aaa68;

// Namespace namespace_51b8e453cf2aaa68
// Params 0, eflags: 0x5
// Checksum 0x68f31c99, Offset: 0x1e5
// Size: 0x37
function private autoexec __init__system__()
{
    system::register( #"hash_eb1a9e1e9b73ed64", [ #"zm_quest", #"hash_709d77ab2b2005c5" ], &pre_main, &post_main );
}

// Namespace namespace_51b8e453cf2aaa68
// Params 0, eflags: 0x4
// Checksum 0x7233371b, Offset: 0x224
// Size: 0x92
function private pre_main()
{
    if ( !getdvarint( @"hash_42cdb7fc777fae63", 0 ) )
    {
        return;
    }
    
    level.quest_ww.chain_quest = spawnstruct();
    level.quest_ww.chain_quest.var_f0637eeb5ce80694 = 0;
    zm_quest::register_quest_step( #"hash_eb1a9e1e9b73ed64", #"hash_aa48d5bef44324c6", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"hash_eb1a9e1e9b73ed64", #"collect_chain", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
}

// Namespace namespace_51b8e453cf2aaa68
// Params 0, eflags: 0x4
// Checksum 0x78ad1c92, Offset: 0x2be
// Size: 0x51
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
    
    function_6f2a8af7d7ad800e();
    level thread function_4ddd6ec9f3d641a3();
    level thread function_b7e2cbe93c2ab2bb();
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_eb1a9e1e9b73ed64" );
}

// Namespace namespace_51b8e453cf2aaa68
// Params 0, eflags: 0x4
// Checksum 0xdc2dd64d, Offset: 0x317
// Size: 0x9f
function private function_6f2a8af7d7ad800e()
{
    walljump = getent( "wwq_wall_jump_raised_pos", #targetname );
    walljump.clip = getent( walljump.target, #targetname );
    walljump.life_brush = getnoentvolumearray( "wall_jump_life", #targetname )[ 0 ];
    walljump.clip linkto( walljump, "j_cargo" );
    zm_player::function_ff714b8751ab0002( walljump.life_brush );
    zm_sat_locust_util::function_295a36ef38f5acae( #"ww_walljump", walljump );
}

// Namespace namespace_51b8e453cf2aaa68
// Params 2, eflags: 0x4
// Checksum 0x77538489, Offset: 0x3be
// Size: 0x2d
function private function_7d6d613ab952c071( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "pap_step_04" );
}

// Namespace namespace_51b8e453cf2aaa68
// Params 2, eflags: 0x4
// Checksum 0x60b9310a, Offset: 0x3f3
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

// Namespace namespace_51b8e453cf2aaa68
// Params 2, eflags: 0x4
// Checksum 0xdfd33a6b, Offset: 0x435
// Size: 0x73
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    crane_use = zm_sat_locust_util::get_quest_reference( #"hash_1cb916ba3ee31df5" );
    crane_use setscriptablepartstate( #"usable", #"enabled" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( "quest_item_used", &function_b737e1af0d05ce6d );
    utility::flag_wait( "ww_billiam_step_02" );
}

// Namespace namespace_51b8e453cf2aaa68
// Params 2, eflags: 0x4
// Checksum 0x3a8424f5, Offset: 0x4b0
// Size: 0xe6
function private function_60062248e78b76a3( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "ww_billiam_step_02" );
        chainlink = zm_sat_locust_util::get_quest_reference( #"ww_chainlink" );
        chainlink freescriptable();
        zm_quest::function_b57dfe9625966b0b( #"hash_709d77ab2b2005c5", 0, #"chainlink", 1 );
    }
    
    level callback::remove( "quest_item_used", &function_b737e1af0d05ce6d );
    level callback::remove( #"wall_jump_begin", &function_62f9ff1b9efee96 );
    level callback::remove( #"wall_jump_end", &function_7716a179be465393 );
    utility::flag_set( "ww_billiam_core" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread zm_quest::update_round_cap( 7, 1, 0 );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_51b8e453cf2aaa68
// Params 0, eflags: 0x4
// Checksum 0xaca6e6b3, Offset: 0x59e
// Size: 0xe7
function private function_4ddd6ec9f3d641a3()
{
    utility::flag_wait( "scriptables_ready" );
    var_1408c9844ed8e52e = utility::getstruct( "ww_cr_us" );
    crane_use = spawnscriptable( %"sat_zm_prop_earnest", var_1408c9844ed8e52e.origin, var_1408c9844ed8e52e.angles );
    crane_use.wall = zm_sat_locust_util::get_quest_reference( #"ww_walljump" );
    crane_use.sfx_engine = spawnscriptable( "sat_zm_locust_crane_engine_sfx", ( 211, 3807, 397 ) );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        hint = utility::callsharedfunc( #"directed_mode", #"get_interact_func", %"sat_zm_prop_earnest" );
    }
    
    interaction::register_scriptable_interact( crane_use, &function_a5734add44b12100, undefined, undefined, hint );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_1cb916ba3ee31df5", crane_use );
}

// Namespace namespace_51b8e453cf2aaa68
// Params 1, eflags: 0x4
// Checksum 0x91e320fb, Offset: 0x68d
// Size: 0x8f
function private function_a5734add44b12100( player )
{
    self setscriptablepartstate( #"usable", #"disabled" );
    function_aab5147b2d35d9ee( 0 );
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    
    if ( player && !level.quest_ww.chain_quest.var_f0637eeb5ce80694 )
    {
        level.quest_ww.chain_quest.var_f0637eeb5ce80694 = 1;
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive" );
    }
}

// Namespace namespace_51b8e453cf2aaa68
// Params 3, eflags: 0x4
// Checksum 0x1b83bdde, Offset: 0x724
// Size: 0xd4
function private function_aab5147b2d35d9ee( reverse = 0, skipped = 0, completed = 0 )
{
    if ( !skipped )
    {
        if ( reverse )
        {
            wall_anim = "sat_zm_machinery_crane_cargo_raise_anim";
            
            if ( !completed )
            {
                utility::flag_clear( "activate_crane" );
            }
        }
        else
        {
            wall_anim = "sat_zm_machinery_crane_cargo_anim";
            utility::flag_set( "activate_crane" );
        }
        
        self.wall scriptmodelplayanim( wall_anim, "movedone" );
        self.sfx_engine setscriptablepartstate( "engine", "moving" );
        thread function_e366d9812795da64( reverse, completed );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace namespace_51b8e453cf2aaa68
// Params 2, eflags: 0x4
// Checksum 0x5460943b, Offset: 0x800
// Size: 0x224
function private function_e366d9812795da64( reverse = 0, completed )
{
    level endon( #"game_ended" );
    eq_origin = reverse ? self.wall.origin : self.wall.origin - ( 0, 0, 1200 );
    eq_radius = reverse ? 2048 : 1024;
    self.wall setscriptablepartstate( #"event", reverse ? #"moving_up" : #"moving_down" );
    earthquake( 0.3, 0.5, eq_origin, eq_radius );
    playrumbleonposition( "grenade_rumble", eq_origin );
    self.wall waittill( #"movedone" );
    self.wall stopanimscripted();
    self.sfx_engine setscriptablepartstate( "engine", "stop" );
    earthquake( 0.3, 0.5, eq_origin, eq_radius );
    playrumbleonposition( "grenade_rumble", eq_origin );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_chainlink" ) )
    {
        chainlink = zm_sat_locust_util::get_quest_reference( #"ww_chainlink" );
    }
    
    if ( reverse )
    {
        if ( chainlink )
        {
            chainlink setscriptablepartstate( chainlink function_84ad2f70189ee7c3(), #"visible_not_usable" );
        }
        
        self setscriptablepartstate( #"usable", #"enabled" );
        return;
    }
    
    if ( chainlink )
    {
        chainlink setscriptablepartstate( chainlink function_84ad2f70189ee7c3(), #"visible" );
    }
    
    if ( !utility::flag( "ww_billiam_step_02" ) )
    {
        level callback::add( #"wall_jump_begin", &function_62f9ff1b9efee96 );
        level callback::add( #"wall_jump_end", &function_7716a179be465393 );
    }
    
    wait 20;
    level callback::remove( #"wall_jump_begin", &function_62f9ff1b9efee96 );
    level callback::remove( #"wall_jump_end", &function_7716a179be465393 );
    function_aab5147b2d35d9ee( 1, 0 );
}

// Namespace namespace_51b8e453cf2aaa68
// Params 0, eflags: 0x4
// Checksum 0x92dc0ff1, Offset: 0xa2c
// Size: 0xc8
function private function_b7e2cbe93c2ab2bb()
{
    utility::flag_wait( "scriptables_ready" );
    chainlink_loc = utility::getstruct( "ww_ch_li" );
    asset = zm_sat_locust_util::get_quest_item_ref( %"zmloot_sat_locust_quest_billiam" );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:chainlink_loc.angles, #spawnorigin:chainlink_loc.origin, #asset:asset };
    chainlink = zm_sat_locust_util::spawn_quest_item( params );
    chainlink setscriptablepartstate( chainlink function_84ad2f70189ee7c3(), #"visible_not_usable" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"ww_chainlink", chainlink );
}

// Namespace namespace_51b8e453cf2aaa68
// Params 1, eflags: 0x4
// Checksum 0x945b708e, Offset: 0xafc
// Size: 0xc8
function private function_b737e1af0d05ce6d( params )
{
    switch ( params.bundle.scriptable )
    {
        case %"zmloot_sat_locust_quest_billiam_guided":
        case %"zmloot_sat_locust_quest_billiam":
            utility::flag_set( "ww_billiam_step_02" );
            zm_quest::function_b57dfe9625966b0b( #"hash_709d77ab2b2005c5", 0, #"chainlink", 1 );
            zm_quest::show_splash_item_picked_up( #"hash_709d77ab2b2005c5", #"chainlink", 1, params.player );
            params.player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_47780eeb333cd030", #"bc_flavor_player_positive" );
            zm_sat_locust_util::function_63a23256772ea1b9( params.player );
            break;
    }
}

// Namespace namespace_51b8e453cf2aaa68
// Params 1, eflags: 0x4
// Checksum 0xdde0977d, Offset: 0xbcc
// Size: 0x4f
function private function_62f9ff1b9efee96( params )
{
    walljump = zm_sat_locust_util::get_quest_reference( #"ww_walljump" );
    brush = walljump.life_brush;
    
    if ( self istouching( brush ) )
    {
        thread function_e25d95cccc056c32( brush );
    }
}

// Namespace namespace_51b8e453cf2aaa68
// Params 1, eflags: 0x4
// Checksum 0xfaf8af23, Offset: 0xc23
// Size: 0x43
function private function_7716a179be465393( params )
{
    if ( self.ww_chain.var_e59e24fbb46d7d5e )
    {
        self notify( #"crane_jump_end" );
        self.ww_chain.var_e59e24fbb46d7d5e = 0;
    }
}

// Namespace namespace_51b8e453cf2aaa68
// Params 1, eflags: 0xc
// Checksum 0xad8c1adb, Offset: 0xc6e
// Size: 0x1f5
function private function_e25d95cccc056c32( brush )
{
    self notify( #"hash_521c01c84d055862" );
    self endon( #"hash_521c01c84d055862" );
    level endon( #"game_ended" );
    level endon( #"ww_billiam_step_02" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"crane_jump_end" );
    
    if ( !isdefined( self.ww_chain ) )
    {
        self.ww_chain = { #near_misses:0, #jumps:0, #var_e59e24fbb46d7d5e:0 };
    }
    
    self.ww_chain.var_e59e24fbb46d7d5e = 1;
    self.ww_chain.jumps++;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        var_a932ebcd2eba05a0 = 2;
    }
    else
    {
        var_a932ebcd2eba05a0 = 10;
    }
    
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"ww_chainlink" ) )
    {
        return;
    }
    
    chainlink = zm_sat_locust_util::get_quest_reference( #"ww_chainlink" );
    min_dist = squared( 110 );
    end_time = gettime() + int( 2000 );
    
    while ( gettime() <= end_time )
    {
        if ( !isdefined( chainlink ) )
        {
            return;
        }
        
        if ( distancesquared( chainlink.origin, self.origin ) <= min_dist )
        {
            self.ww_chain.near_misses++;
            
            if ( self.ww_chain.near_misses == var_a932ebcd2eba05a0 || self usebuttonpressed() )
            {
                part = chainlink function_84ad2f70189ee7c3();
                state = chainlink getscriptablepartstate( part );
                level thread common_item::items_scriptable_used( chainlink, part, state, self, 0 );
                level callback::remove( #"wall_jump_begin", &function_62f9ff1b9efee96 );
                level callback::remove( #"wall_jump_end", &function_7716a179be465393 );
            }
            
            return;
        }
        
        waitframe();
    }
}

