// script_b08cfd938b4688f  (hash_0b08cfd938b4688f.gscc) (size: 40000 Bytes / 0x9c40 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcd2028b1 (3441436849)
// size ...... 40000 (0x9c40)
// includes .. 20  (offset: 0x94dc)
// strings ... 69  (offset: 0x957c)
// dev strs .. 48  (offset: 0x99d0)
// exports ... 96  (offset: 0x60a0)
// cseg ...... 0x516 + 0x5b8a (0x60a0)
// imports ... 283 (offset: 0x6fa0)
// animtree1 . 0   (offset: 0x9c40)
// animtree2 . 0   (offset: 0x9c40)
#using script_214060780e647f61;
#using script_236edd51aea4c314;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\interaction;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace namespace_ee77ed3d068c5ad5;

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x5
// Checksum 0xff1d1466, Offset: 0x534
// Size: 0x37
function private autoexec __init__system__()
{
    system::register( #"hash_9a9f22ecb2a5ad11", [ #"zm_quest", #"locust_mq" ], &pre_main, &post_main );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x4d25cc5e, Offset: 0x573
// Size: 0x269
function private pre_main()
{
    if ( !getdvarint( @"enable_locust_mq", 0 ) )
    {
        return;
    }
    
    level.quest_mq.locate_quest = spawnstruct();
    level.quest_mq.locate_quest.zone_name = "zone_downtown_meadhall";
    level.quest_mq.locate_quest.var_7a018e34c90cd7f9 = zm_quest::function_b0a5181ebe7bb905() ? getdvarint( @"hash_b32cdc4ccacd78f6", 2 ) : getdvarint( @"hash_15b6c9f300071645", 5 );
    level.quest_mq.locate_quest.var_e168ad22c5f220d = getdvarint( @"hash_ea463703f533f210", 72 );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"attack_ss", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"collect_fragment", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"hash_1f2495b745507c45", &function_7d6d5f3ab952bc0b, &function_60062148e78b7470 );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"place_fragment", &function_e963d59dc8feaa07, &function_66f87d6979309cf4 );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"start_bonfire", &function_e963d69dc8feac3a, &function_66f880697930a38d );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"hash_1a6c2f18426c14d7", &function_e963d79dc8feae6d, &function_66f87f697930a15a );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"holdout", &function_e963d09dc8fe9f08, &function_66f87a697930965b );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"hash_be030634210db169", &function_e963d19dc8fea13b, &function_66f8796979309428 );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"make_offering", &function_7d6d643ab952c70a, &function_60062848e78b83d5 );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"hash_abf52d69bd7c3f52", &function_31f8869dfe36254a, &function_cc5da069c3749c2d );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"activate_offering", &function_31f8859dfe362317, &function_cc5d9d69c3749594 );
    zm_quest::register_quest_step( #"hash_9a9f22ecb2a5ad11", #"hash_6b5a806498d19632", &function_7d6d653ab952c93d, &function_60062748e78b81a2 );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x85eb9a51, Offset: 0x7e4
// Size: 0x78
function private post_main()
{
    level thread function_27a5e2a2fdbb4841();
    
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
    
    level thread function_efd10cb86b28854f();
    level thread function_cf8782cbf8347566();
    level thread function_d25f5b9c820b6358();
    level thread function_39d77a454dfa20b3();
    zm_save::function_1f44a48caae2acbf();
    utility::flag_wait( "onStartGameTypeFinished" );
    level thread zm_quest::start_quest( #"hash_9a9f22ecb2a5ad11" );
    
    /#
        debug_init();
    #/
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0xd2cbfba7, Offset: 0x864
// Size: 0x35
function private function_7d6d613ab952c071( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread function_9b3d6619db6cd8fd();
    utility::flag_wait( "mq_rl_step_01" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0xbc19d219, Offset: 0x8a1
// Size: 0x72
function private function_60062348e78b78d6( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        function_66361e45e91d83f6( 1 );
        utility::flag_set( "mq_rl_step_01" );
    }
    else
    {
        level thread function_66361e45e91d83f6();
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        level thread zm_quest::update_round_cap( 15, 1, 0 );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x1b37e58d, Offset: 0x91b
// Size: 0x27
function private function_9b3d6619db6cd8fd()
{
    level endon( #"mq_rl_step_01" );
    level waittill( #"virgil_react_spawn_item" );
    utility::flag_set( "mq_rl_step_01" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0xea586ed2, Offset: 0x94a
// Size: 0x160
function private function_66361e45e91d83f6( skipped = 0 )
{
    var_ff3f156fcd8fe422 = utility::getstruct( "mqlo_ss_dr" );
    end_pos = var_ff3f156fcd8fe422.origin;
    
    if ( !skipped && zm_sat_locust_util::function_3112dc4740eb8499( #"virgil_power" ) )
    {
        shadowsmith = zm_sat_locust_util::get_quest_reference( #"virgil_power" );
        start_pos = shadowsmith gettagorigin( "tag_r_chest" );
        mdl = utility::spawn_model( %"sat_zm_locust_mack_01", start_pos, ( 0, 0, 0 ), undefined, 2.5 );
        mdl utility::function_8001268940441423( start_pos, end_pos, ( end_pos[ 0 ], end_pos[ 1 ], start_pos[ 2 ] ), 1.5, 1, 1 );
        mdl delete();
        playfx( utility::getfx( "ejection_tube_splat" ), end_pos );
    }
    
    params = { #spawntype:#"spawn_at_pos", #spawnangles:var_ff3f156fcd8fe422.angles, #spawnorigin:end_pos, #asset:%"zmloot_sat_locust_quest_mack" };
    item = zm_sat_locust_util::spawn_quest_item( params );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_b1ac45e87d3c09c3", item );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x5952b876, Offset: 0xab2
// Size: 0x3f
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( "quest_item_used", &function_b737e1af0d05ce6d );
    utility::flag_wait( "mq_rl_step_02" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0xc52649c7, Offset: 0xaf9
// Size: 0xb3
function private function_60062248e78b76a3( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rl_step_02" );
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_b1ac45e87d3c09c3" ) )
        {
            item = zm_sat_locust_util::get_quest_reference( #"hash_b1ac45e87d3c09c3" );
            item freescriptable();
        }
        
        zm_quest::function_b57dfe9625966b0b( #"hash_9a9f22ecb2a5ad11", 0, #"item_mack", 1 );
    }
    
    level callback::remove( "quest_item_used", &function_b737e1af0d05ce6d );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x72a7c6e4, Offset: 0xbb4
// Size: 0xb2
function private function_b737e1af0d05ce6d( params )
{
    if ( params.bundle.scriptable == %"zmloot_sat_locust_quest_mack" )
    {
        utility::flag_set( "mq_rl_step_02" );
        zm_quest::function_b57dfe9625966b0b( #"hash_9a9f22ecb2a5ad11", 0, #"item_mack", 1 );
        zm_quest::show_splash_item_picked_up( #"hash_9a9f22ecb2a5ad11", #"item_mack", 1, params.player );
        zm_sat_locust_util::function_63a23256772ea1b9( params.player );
        params.player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_77d8e8f8655d0da1", #"hash_5212ed7ec42f115a" );
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x8a2e5f8f, Offset: 0xc6e
// Size: 0x21
function private function_7d6d5f3ab952bc0b( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0xcfb6ee9d, Offset: 0xc97
// Size: 0x46
function private function_60062148e78b7470( skipped, save_restored )
{
    profilestart();
    utility::flag_set( "mq_rl_step_03" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x7600c396, Offset: 0xce5
// Size: 0x41
function private function_27a5e2a2fdbb4841()
{
    blocker = getent( "mq_locate_blocker", #targetname );
    
    if ( !isdefined( blocker ) )
    {
        return;
    }
    
    blocker hide();
    zm_sat_locust_util::function_295a36ef38f5acae( #"mq_locate_blocker", blocker );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x6952de5a, Offset: 0xd2e
// Size: 0x121
function private function_efd10cb86b28854f()
{
    utility::flag_wait( "scriptables_ready" );
    hall_fire_loc = utility::getstruct( "mqlo_ha_fi" );
    hall_fire_interact_loc = utility::getstruct( hall_fire_loc.target );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        hint = utility::callsharedfunc( #"directed_mode", #"get_interact_func", #"hash_1c92cec617cca51f" );
    }
    
    hall_fire = spawnscriptable( %"sat_zm_firepit_reginald", hall_fire_loc.origin, hall_fire_loc.angles );
    hall_fire.interact = spawnscriptable( %"sat_zm_prop_mack", hall_fire_interact_loc.origin, hall_fire_interact_loc.angles );
    hall_fire.interact = interaction::register_scriptable_interact( hall_fire.interact, &function_3a77470615a8aea8, undefined, undefined, hint );
    hall_fire setscriptablepartstate( #"body", #"visible" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_8d00b8d1f10e5389", hall_fire );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x587e4113, Offset: 0xe57
// Size: 0x6a
function private function_e963d59dc8feaa07( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
    hall_fire.interact setscriptablepartstate( #"sat_zm_prop_mack", #"enabled" );
    utility::flag_wait( "mq_rl_step_03_a" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x695719de, Offset: 0xec9
// Size: 0x72
function private function_66f87d6979309cf4( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
        hall_fire.interact function_3a77470615a8aea8();
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x9ba99f0c, Offset: 0xf43
// Size: 0xc9
function private function_3a77470615a8aea8( player )
{
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( #"sat_zm_prop_mack", #"placed" );
    }
    
    hall_fire_loc = utility::getstruct( "mqlo_ha_fi" );
    hall_fire_interact_loc = utility::getstruct( hall_fire_loc.target );
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    
    if ( player )
    {
        level thread battlechatter_mp::trysaylocalsound( player, #"hash_5212ed7ec42f115a" );
    }
    
    fragment = utility::spawn_model( %"sat_zm_locust_mack_01", hall_fire_interact_loc.origin, hall_fire_interact_loc.angles );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_1ab0feb7cfae1bd0", fragment );
    utility::flag_set( "mq_rl_step_03_a" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0xd39dcbea, Offset: 0x1014
// Size: 0x32
function private meat_manager()
{
    self endon( #"death" );
    f_rotate_time = 20;
    
    while ( true )
    {
        self rotatepitch( 360, f_rotate_time );
        wait f_rotate_time;
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x96ad568, Offset: 0x104e
// Size: 0xa4
function private function_e963d69dc8feac3a( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
    hall_fire.health = 100;
    hall_fire.var_af70f02bb9462edd = 1;
    hall_fire.var_436fc13baa7377d8 = 1;
    hall_fire.var_18d4007b123c953a = 0;
    hall_fire zm_damage::register_scriptable_damage_callback( &function_f79d28193278c4fb );
    hall_fire callback::add( #"hash_11e40a4909e138f7", &function_75d0e26e1c7db03e );
    utility::flag_wait( "mq_rl_step_03_b" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x8395d2f4, Offset: 0x10fa
// Size: 0xc4
function private function_66f880697930a38d( skipped, save_restored )
{
    profilestart();
    hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
    hall_fire setscriptablepartstate( #"lit", #"begin" );
    
    if ( skipped || save_restored )
    {
        hall_fire.health = 0;
        hall_fire.var_af70f02bb9462edd = 0;
        hall_fire zm_damage::function_c31f9d79d5ceb7ec( &function_f79d28193278c4fb );
        hall_fire callback::remove( #"hash_11e40a4909e138f7", &function_75d0e26e1c7db03e );
        utility::flag_set( "mq_rl_step_03_b" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0xd87f54bb, Offset: 0x11c6
// Size: 0x22
function private function_f79d28193278c4fb( params )
{
    if ( namespace_e625df044ece0a58::function_c531ee6013cf3d72( params ) )
    {
        return self.health;
    }
    
    return 0;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x3200eb06, Offset: 0x11f1
// Size: 0x4a
function private function_75d0e26e1c7db03e( params )
{
    if ( params.eattacker )
    {
        params.eattacker thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_cfe387c1d121c73b", #"bc_flavor_player_positive" );
    }
    
    utility::flag_set( "mq_rl_step_03_b" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x1b2641a6, Offset: 0x1243
// Size: 0x8c
function private function_e963d79dc8feae6d( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level.fishing_struct.force_injection = 1;
    level callback::add( #"hash_462433e659e82d48", &function_1577c5038f287ec0 );
    function_6f4d5facaa056b86();
    level callback::add( #"hash_2ae271dee4ec81dc", &function_7ba2b2aed0fde63b );
    level callback::add( #"hash_495068f01155197e", &function_516b8f40eb34e8c1 );
    utility::flag_wait( "mq_rl_step_03_c" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x6a3d550e, Offset: 0x12d7
// Size: 0xb0
function private function_66f87f697930a15a( skipped, save_restored )
{
    profilestart();
    level.fishing_struct.force_injection = 0;
    level callback::remove( #"hash_2ae271dee4ec81dc", &function_7ba2b2aed0fde63b );
    hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
    hall_fire setscriptablepartstate( #"lit", #"complete" );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rl_step_03_c" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x4e682989, Offset: 0x138f
// Size: 0x46
function private function_6f4d5facaa056b86()
{
    hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
    hall_fire.max_consumption = level.quest_mq.locate_quest.var_7a018e34c90cd7f9;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x8d015ad5, Offset: 0x13dd
// Size: 0x62
function private function_7ba2b2aed0fde63b( params )
{
    profilestart();
    
    if ( !function_d3f76a2718ec2dbe( params, params.mover.origin ) )
    {
        profilestop();
        return;
    }
    
    params.player mutant_injection_disciple_zombies::function_31e00c35c13bd665();
    params.should_explode = 0;
    function_6cf778806f9705ad( params.player );
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0xcd942fc6, Offset: 0x1447
// Size: 0x1ac, Type: bool
function private function_6cf778806f9705ad( player )
{
    hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
    
    if ( !isdefined( hall_fire.consumption ) )
    {
        hall_fire.consumption = 0;
    }
    
    hall_fire.consumption++;
    hall_fire setscriptablepartstate( #"lit", "consumed_" + hall_fire.consumption );
    
    /#
        iprintlnbold( "<dev string:x24>" + hall_fire.consumption );
    #/
    
    if ( hall_fire.consumption == 1 && zm_sat_locust_util::function_3112dc4740eb8499( #"hash_1ab0feb7cfae1bd0" ) )
    {
        fragment = zm_sat_locust_util::get_quest_reference( #"hash_1ab0feb7cfae1bd0" );
        fragment thread meat_manager();
    }
    
    if ( hall_fire.consumption == hall_fire.max_consumption )
    {
        utility::flag_set( "mq_rl_step_03_c" + "_completed" );
        level callback::remove( #"hash_2ae271dee4ec81dc", &function_7ba2b2aed0fde63b );
        level thread utility::flag_set_delayed( "mq_rl_step_03_c", 2 );
        
        if ( player )
        {
            hall_fire.activating_player = player;
            players = utility::get_alive_players( 0 );
            
            if ( players.size > 1 )
            {
                players = arrayremove( players, player );
                var_dc4fa75655c6106d = sortbydistancecullbyradius( players, player.origin, 512 );
                vo_player = utility::array_random( var_dc4fa75655c6106d );
                
                if ( vo_player )
                {
                    vo_player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_7facaea22922933a", #"bc_flavor_player_positive" );
                }
            }
        }
        
        return true;
    }
    
    return false;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x47e1ecb5, Offset: 0x15fc
// Size: 0x56
function private function_516b8f40eb34e8c1( params )
{
    if ( !function_d3f76a2718ec2dbe( params, params.end ) )
    {
        return;
    }
    
    hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
    params.end = hall_fire.origin;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0xb93568c3, Offset: 0x165a
// Size: 0x24b, Type: bool
function private function_d3f76a2718ec2dbe( params, end )
{
    radius = level.quest_mq.locate_quest.var_e168ad22c5f220d;
    hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
    
    if ( params.trace[ "hittype" ] == "hittype_scriptable" && params.trace[ "scriptable" ] == hall_fire )
    {
        return true;
    }
    else if ( params.trace[ "hittype" ] == "hittype_world" )
    {
        if ( !isdefined( end ) || !isdefined( hall_fire.origin ) )
        {
            return false;
        }
        
        if ( distance2dsquared( end, hall_fire.origin ) <= squared( radius ) )
        {
            return true;
        }
    }
    
    if ( !isdefined( end ) || !isdefined( hall_fire.origin ) )
    {
        return false;
    }
    
    zone = params.player zone_manager::get_current_zone();
    
    if ( zone.zone_name != "zone_downtown_meadhall" )
    {
        return false;
    }
    
    org_diff = end - hall_fire.origin;
    
    if ( org_diff[ 2 ] > 32 )
    {
        return false;
    }
    
    if ( !utility::within_fov( params.player getcamerathirdpersonorigin(), params.player getplayerangles(), hall_fire.origin, cos( 60 ) ) )
    {
        return false;
    }
    
    player_fwd = anglestoforward( params.player.angles );
    fire_fwd = vectornormalize( hall_fire.origin - params.player.origin );
    dot = vectordot( player_fwd, fire_fwd );
    dist = distance2d( hall_fire.origin, params.player.origin );
    required_dot = mapfloat( 40, 1000, 0.9, 0.995, dist );
    
    if ( abs( dot ) >= required_dot )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x551fd6a6, Offset: 0x18ae
// Size: 0xd, Type: bool
function private function_1577c5038f287ec0( params )
{
    return false;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x6f7e413e, Offset: 0x18c4
// Size: 0x7b
function private function_e963d09dc8fe9f08( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    zm_quest::function_3c363613c60958f5( "mq_locate_lockdown" );
    utility::flag_set( "mq_locate_lockdown" );
    params = zm_sat_locust_util::function_5174cc6676c87a1( "mq_locate_holdout", "zone_downtown_meadhall", &function_5715145c110ebe04, &function_94f7f341f5a3f1a9 );
    zm_sat_locust_util::lockdown_event( params );
    function_91338a819cdb2e5();
    utility::flag_wait( "mq_rl_step_03_d" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x73887a93, Offset: 0x1947
// Size: 0x217
function private function_66f87a697930965b( skipped, save_restored )
{
    profilestart();
    zm_quest::function_7fb356c0028d0a64( "mq_locate_lockdown" );
    utility::flag_clear( "mq_locate_lockdown" );
    level callback::remove( #"hash_462433e659e82d48", &function_1577c5038f287ec0 );
    
    if ( zm_sat_locust_util::function_2843f52d4913dcda( "mq_locate_holdout" ) )
    {
        zm_sat_locust_util::function_f994152baff649dc( "mq_locate_holdout" );
        wave_0 = zm_sat_locust_util::is_holdout_event_active( "rl_wave_0" );
        
        if ( wave_0 )
        {
            zm_sat_locust_util::end_holdout_event( "rl_wave_0" );
        }
        
        if ( isdefined( level.quest_mq.locate_quest.hvt ) )
        {
            level.quest_mq.locate_quest.hvt.invulnerable = 0;
            level.quest_mq.locate_quest.hvt kill();
        }
    }
    
    level thread zm_music::function_e9fd14ede793ef0d( "meadhall_holdout" );
    
    if ( zm_sat_locust_util::get_quest_reference( #"mq_locate_blocker" ) )
    {
        blocker = zm_sat_locust_util::get_quest_reference( #"mq_locate_blocker" );
        blocker delete();
    }
    
    if ( isdefined( level.var_8774f821e260ceba ) )
    {
        foreach ( vfx_blocker in level.var_8774f821e260ceba )
        {
            vfx_blocker setscriptablepartstate( #"sat_zm_locust_door_blocker", #"off" );
            vfx_blocker freescriptable();
        }
        
        utility::array_delete( level.var_8774f821e260ceba );
    }
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rl_step_03_d" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0xc896b302, Offset: 0x1b66
// Size: 0x9a
function private function_5715145c110ebe04( params )
{
    blocker = zm_sat_locust_util::get_quest_reference( #"mq_locate_blocker" );
    blocker show();
    flags = [ "rej_is_busy" ];
    
    if ( utility::flag( "rr_3_is_busy" ) )
    {
        flags[ flags.size ] = #"hash_69f45a8d347b79b6";
        utility::flag_wait( "rr_3_teleport_done" );
        richtofen_player = zm_sat_locust_util::get_quest_reference( #"richtofen_player" );
        richtofen_player notify( #"hash_750e74bc033e878f" );
    }
    
    utility::flag_waitopen_all_array( flags );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x400310cf, Offset: 0x1c08
// Size: 0xf6
function private function_94f7f341f5a3f1a9( params )
{
    level.var_8774f821e260ceba = [];
    var_e015876f55128a7a = utility::getstructarray( "mqlo_do_blo", "targetname" );
    
    foreach ( blocker in var_e015876f55128a7a )
    {
        vfx_blocker = spawnscriptable( %"sat_zm_locust_door_blocker", blocker.origin, blocker.angles );
        vfx_blocker setscriptablepartstate( #"sat_zm_locust_door_blocker", #"on" );
        level.var_8774f821e260ceba[ level.var_8774f821e260ceba.size ] = vfx_blocker;
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0xcbbba9c1, Offset: 0x1d06
// Size: 0x2ea
function private function_91338a819cdb2e5()
{
    s_hvt_spawn_pos = utility::getstruct( "mqlo_hv_sp" );
    level thread powerups::powerup_drop( "full_ammo", s_hvt_spawn_pos.origin + ( 0, 0, 8 ), 60, undefined, "quest" );
    wait 2.5;
    hvt_params = { #difficulty_round_number:function_7ccd586506b77039(), #var_30085f70fc117162:s_hvt_spawn_pos, #spawner_zombie_type:"zombie_karkinos_hvt" };
    hvt = zm_sat_locust_util::spawn_quest_zombie( hvt_params );
    wait 1;
    earthquake( 0.65, 1.5, s_hvt_spawn_pos.origin, 768 );
    level.quest_mq.locate_quest.hvt = hvt;
    hvt thread function_4a29780498969406();
    hvt thread function_4b83db67fafe47a7();
    var_5cfd36d664316522 = level.players.size == 1 ? getdvarint( @"hash_3e43fd36ad709baa", 10 ) : getdvarint( @"hash_75fb0c828dcb2c41", 15 );
    params = { #var_201aaa0c57618626:1, #max_active_zombies:var_5cfd36d664316522, #var_98f23c369371e8ec:1, #var_d346909023f61570:function_c905725a4bb3636(), #difficulty_round_number:function_c905725a4bb3636(), #drop_list:[ "zombie_base_luna":"ld_normal", "zombie_base_armored_light":{ #armored:"ld_normal_armored", #normal:"ld_normal" }, "zombie_base":"ld_normal" ], #aitypes:[ { #type:"zombie_base_luna", #weight:40 }, { #type:"zombie_base_armored_light", #weight:30 }, { #type:"zombie_base", #weight:30 } ], #var_1e899b25f3766233:1, #spawn_zones:[ zone_manager::get_zone_struct( level.quest_mq.locate_quest.zone_name ) ], #name:"rl_wave_0" };
    
    if ( isdefined( params ) )
    {
        level thread zm_sat_locust_util::holdout_event( params );
    }
    
    level thread zm_music::start_zone_music_watcher( "meadhall_holdout", [ "zone_downtown_meadhall" ], #"hash_bbaf3ba6bcd8337e" );
    utility::flag_wait( "pause_rl_holdout_loop" );
    completed = !isalive( hvt );
    
    if ( completed )
    {
        if ( isdefined( params.name ) )
        {
            level thread zm_sat_locust_util::end_holdout_event( params.name );
        }
    }
    
    level thread zm_music::function_e9fd14ede793ef0d( "meadhall_holdout" );
    utility::flag_clear( "pause_rl_holdout_loop" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x9af1eaca, Offset: 0x1ff8
// Size: 0x14
function private function_8fad42fbdec1025f( params )
{
    return namespace_e625df044ece0a58::function_c531ee6013cf3d72( params );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0xed1fbcd0, Offset: 0x2015
// Size: 0x44
function private function_4a29780498969406()
{
    self waittill( #"death" );
    level.quest_mq.locate_quest.hvt = undefined;
    utility::flag_set( "pause_rl_holdout_loop" );
    utility::flag_set( "mq_rl_step_03_d" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0xc48cb243, Offset: 0x2061
// Size: 0x3a
function private function_c905725a4bb3636()
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        round_difficulty = zm_utility::get_round_number();
    }
    else
    {
        round_difficulty = zm_utility::get_round_number() + getdvarint( @"hash_a88a003f32fd2ac", 2 );
    }
    
    return round_difficulty;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x4802f7a7, Offset: 0x20a4
// Size: 0x3a
function private function_7ccd586506b77039()
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        round_difficulty = zm_utility::get_round_number();
    }
    else
    {
        round_difficulty = zm_utility::get_round_number() + getdvarint( @"hash_532fe5610704dc7", 10 );
    }
    
    return round_difficulty;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0xfe561393, Offset: 0x20e7
// Size: 0xe8
function private function_4b83db67fafe47a7()
{
    level endon( #"game_ended" );
    level endon( #"zm_game_over" );
    self endon( #"death" );
    spawn_pos = utility::getstruct( "mqlo_hv_sp" );
    
    for ( ;; )
    {
        zone = zone_manager::get_current_zone();
        
        if ( zone.zone_name != "zone_downtown_meadhall" && !self.attractor )
        {
            self.attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( spawn_pos, 4 );
        }
        else if ( zone.zone_name == "zone_downtown_meadhall" && self.attractor )
        {
            utility::waittill_notify_or_timeout( "damage", randomfloatrange( 0.5, 1.5 ) );
            
            if ( zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.attractor ) )
            {
                self.attractor = undefined;
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x51f3999f, Offset: 0x21d7
// Size: 0x1a9
function private function_e963d19dc8fea13b( skipped, save_restored )
{
    hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
    hall_fire.interact setscriptablepartstate( #"sat_zm_prop_mack", #"smelted" );
    hall_fire.interact utility::delaycall( 0.1, &freescriptable );
    hall_fire utility::delaycall( 1, &setscriptablepartstate, #"lit", #"hash_6475bb4ea8b1d5bf" );
    loot_spawn_origin = getclosestpointonnavmesh( hall_fire.origin + anglestoforward( hall_fire.interact.angles ) * -96 );
    params = { #spawntype:#"spawn_to_pos_from_pos", #toangles:hall_fire.angles, #fromorigin:hall_fire.interact.origin, #toorigin:loot_spawn_origin, #asset:%"zmloot_sat_locust_quest_rudyard" };
    sunstone = zm_sat_locust_util::spawn_quest_item( params );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_576eab2f9ebd38b0", sunstone );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        sunstone setscriptablepartstate( "objective", "enabled" );
    }
    
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_1ab0feb7cfae1bd0" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( "quest_item_used", &function_767b8b778812706c );
    utility::flag_wait( "mq_rl_step_03_e" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x6037951e, Offset: 0x2388
// Size: 0xb1
function private function_66f8796979309428( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rl_step_03_e" );
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_576eab2f9ebd38b0" ) )
        {
            item = zm_sat_locust_util::get_quest_reference( #"hash_576eab2f9ebd38b0" );
            zm_sat_locust_util::function_7bf944a5a2b76f39( #"hash_576eab2f9ebd38b0" );
            item freescriptable();
        }
        
        zm_quest::function_b57dfe9625966b0b( #"hash_9a9f22ecb2a5ad11", 0, #"item_rudyard", 1 );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0xed3117eb, Offset: 0x2441
// Size: 0xb2
function private function_767b8b778812706c( params )
{
    if ( params.bundle.scriptable == %"zmloot_sat_locust_quest_rudyard" )
    {
        utility::flag_set( "mq_rl_step_03_e" );
        zm_quest::function_b57dfe9625966b0b( #"hash_9a9f22ecb2a5ad11", 0, #"item_rudyard", 1 );
        zm_quest::show_splash_item_picked_up( #"hash_9a9f22ecb2a5ad11", #"item_rudyard", 1, params.player );
        zm_sat_locust_util::function_63a23256772ea1b9( params.player );
        params.player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_14c955ad9b250bb6", #"bc_flavor_player_positive" );
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x144aca2c, Offset: 0x24fb
// Size: 0x21
function private function_7d6d643ab952c70a( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0xcfb6ee9d, Offset: 0x2524
// Size: 0x46
function private function_60062848e78b83d5( skipped, save_restored )
{
    profilestart();
    utility::flag_set( "mq_rl_step_04" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0xe2f6dd18, Offset: 0x2572
// Size: 0x51
function private function_31f8869dfe36254a( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    pedestal = zm_sat_locust_util::get_quest_reference( #"hash_130cb3bad407461d" );
    pedestal setusableenabled( 1 );
    utility::flag_wait( "mq_rl_step_04_a" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x9dfccb0c, Offset: 0x25cb
// Size: 0x69
function private function_cc5da069c3749c2d( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        pedestal = zm_sat_locust_util::get_quest_reference( #"hash_130cb3bad407461d" );
        pedestal function_9b528b97fdc6967d();
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x8c7023b0, Offset: 0x263c
// Size: 0x94
function private function_cf8782cbf8347566()
{
    pedestal_loc = utility::getstruct( "mqlo_pe_lo" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        hint = utility::callsharedfunc( #"directed_mode", #"get_interact_string", #"hash_abf52d69bd7c3f52" );
    }
    
    pedestal = interaction::register_interact( pedestal_loc.origin, pedestal_loc.radius, &function_9b528b97fdc6967d, hint );
    pedestal setusableenabled( 0 );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_130cb3bad407461d", pedestal );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x57f6bbb0, Offset: 0x26d8
// Size: 0xe7
function private function_9b528b97fdc6967d( player )
{
    self setusableenabled( 0 );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:self.angles, #spawnorigin:self.origin, #asset:%"zmloot_sat_locust_quest_rudyard" };
    sunstone = zm_sat_locust_util::spawn_quest_item( params );
    sunstone setscriptablepartstate( sunstone function_84ad2f70189ee7c3(), #"visible_not_usable" );
    
    if ( player )
    {
        zm_sat_locust_util::function_63a23256772ea1b9( player );
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_6e9036a5b05a10c2", #"hash_5212ed7ec42f115a" );
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_576eab2f9ebd38b0", sunstone );
    thread utility::delete_after_delay( level.framedurationseconds );
    utility::flag_set( "mq_rl_step_04_a" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x9f0f721d, Offset: 0x27c7
// Size: 0xa4
function private function_31f8859dfe362317( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    disc = zm_sat_locust_util::get_quest_reference( #"hash_49fe01f298f554e2" );
    disc.health = 100;
    disc.var_af70f02bb9462edd = 1;
    disc.var_436fc13baa7377d8 = 1;
    disc.var_18d4007b123c953a = 0;
    disc zm_damage::register_scriptable_damage_callback( &function_c18ff2bfbab202ab );
    disc callback::add( #"hash_11e40a4909e138f7", &function_1697971017656eec );
    utility::flag_wait( "mq_rl_step_04_b" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0xcb864d44, Offset: 0x2873
// Size: 0x57
function private function_cc5d9d69c3749594( skipped, save_restored )
{
    profilestart();
    disc = zm_sat_locust_util::get_quest_reference( #"hash_49fe01f298f554e2" );
    disc zm_damage::function_c31f9d79d5ceb7ec( &function_c18ff2bfbab202ab );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rl_step_04_b" );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x2f2a323b, Offset: 0x28d2
// Size: 0x6b
function private function_d25f5b9c820b6358()
{
    disc_loc = utility::getstruct( "mqlo_di_lo" );
    payload = function_67b78af3c33ac9a8( 2 );
    disc = spawnscriptable( %"sat_zm_prop_rupert", disc_loc.origin, disc_loc.angles, undefined, payload );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_49fe01f298f554e2", disc );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0xc5297bd7, Offset: 0x2945
// Size: 0x22
function private function_c18ff2bfbab202ab( params )
{
    if ( namespace_e625df044ece0a58::function_c531ee6013cf3d72( params ) )
    {
        return self.health;
    }
    
    return 0;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x8106a12a, Offset: 0x2970
// Size: 0x4c
function private function_1697971017656eec( params )
{
    utility::flag_set( "mq_rl_step_04_b" );
    self setscriptablepartstate( #"fx", #"active" );
    level thread battlechatter_mp::trysaylocalsound( params.eattacker, #"hash_5212ed7ec42f115a" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0xe12e3cfc, Offset: 0x29c4
// Size: 0xea
function private function_7d6d653ab952c93d( skipped, save_restored )
{
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_e254894438a37f89" ) )
    {
        function_39d77a454dfa20b3();
        utility::flag_wait( "initial_player_spawned" );
    }
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
    sunstone = zm_sat_locust_util::get_quest_reference( #"hash_576eab2f9ebd38b0" );
    beam = function_767584b2d3ddf986( utility::getfx( "uther_beam" ), compass.origin, vectortoangles( compass.origin - sunstone.origin ), sunstone.origin );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_789c304adecfa1dc", beam );
    function_9e35d9e096a75e20();
    utility::flag_wait( "mq_rl_step_05" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x3be4c3ff, Offset: 0x2ab6
// Size: 0x189
function private function_60062748e78b81a2( skipped, save_restored )
{
    profilestart();
    function_fc20ef8141f72e45( 1 );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_fe8af74b7a14db1e" ) )
    {
        pyres = zm_sat_locust_util::get_quest_reference( #"hash_fe8af74b7a14db1e" );
        
        foreach ( pyre in pyres )
        {
            pyre setscriptablepartstate( #"body", #"default" );
            pyre.base setscriptablepartstate( #"body", #"default" );
        }
    }
    
    compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
    compass thread function_86677aab8cb180f6( skipped );
    level thread function_c86aa975cc7e4908();
    
    if ( zm_sat_locust_util::is_holdout_event_active( "pyre_holdout" ) )
    {
        zm_sat_locust_util::end_holdout_event( "pyre_holdout" );
    }
    
    /#
        level notify( #"compass_reset" );
    #/
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rl_step_05" );
        utility::flag_set( "mq_rl_core" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x2c19ed10, Offset: 0x2c47
// Size: 0xfc
function private function_d07cf90bfd3dee4()
{
    pyres = zm_sat_locust_util::get_quest_reference( #"hash_fe8af74b7a14db1e" );
    compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
    var_d8c4e9fd1c11e160 = [];
    
    foreach ( pyre in pyres )
    {
        if ( arraycontains( compass.full_code, pyre.code ) )
        {
            var_d8c4e9fd1c11e160[ var_d8c4e9fd1c11e160.size ] = pyre;
        }
    }
    
    pyres = arrayremove( pyres, var_d8c4e9fd1c11e160 );
    var_4bcf6e7512fb1423 = utility::array_random_slice( pyres, 2 );
    var_ae385fc2d6a4273f = arraycombine( var_d8c4e9fd1c11e160, var_4bcf6e7512fb1423 );
    return var_ae385fc2d6a4273f;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x45193213, Offset: 0x2d4c
// Size: 0x176
function private function_8d0c192eae3e11de()
{
    compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
    
    foreach ( pyre in compass.pyres )
    {
        if ( pyre getscriptablepartstate( #"lit" ) == "lit" || pyre.code > 8 )
        {
            continue;
        }
        
        pyre.health = 100;
        pyre.var_af70f02bb9462edd = 1;
        pyre.var_436fc13baa7377d8 = 1;
        pyre.var_18d4007b123c953a = 0;
        pyre zm_damage::register_scriptable_damage_callback( &function_849367bc681da858 );
        pyre callback::add( #"hash_11e40a4909e138f7", &function_d057e3bf16069779 );
        pyre utility::function_32b24db3127bff40( #"body", #"visible" );
        pyre.base utility::function_32b24db3127bff40( #"body", #"visible" );
        pyre setscriptablepartstate( #"hash_bfedd21f6f583ddd", "ver_0" + pyre.code );
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x88cd86fb, Offset: 0x2eca
// Size: 0x22
function private function_849367bc681da858( params )
{
    if ( namespace_e625df044ece0a58::function_c531ee6013cf3d72( params ) )
    {
        return self.health;
    }
    
    return 0;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x3e0b875b, Offset: 0x2ef5
// Size: 0x2a4
function private function_d057e3bf16069779( params )
{
    compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
    
    if ( !isdefined( compass.first_dialogue ) )
    {
        compass.first_dialogue = 0;
    }
    
    if ( !isdefined( compass.failed_dialogue ) )
    {
        compass.failed_dialogue = 0;
    }
    
    if ( compass.full_code[ compass.code_index ] == self.code )
    {
        self setscriptablepartstate( #"lit", #"lit" );
        compass.code_index++;
        
        if ( compass.code_index == 1 && !compass.first_dialogue )
        {
            compass.first_dialogue = 1;
            level thread battlechatter_mp::trysaylocalsound( params.eattacker, #"bc_flavor_player_positive" );
        }
        
        pyre_target = utility::getstruct( self.base.target );
        pyre_zone = zone_manager::function_90e5c3e2272b0130( pyre_target.origin );
        
        foreach ( zombie in level.holdout_event[ "pyre_holdout" ].var_4c6516944983d5d8 )
        {
            zone = zombie zone_manager::get_current_zone();
            
            if ( zone != pyre_zone )
            {
                continue;
            }
            
            zombie thread zm_sat_locust_util::wipe_zombie();
        }
        
        level.holdout_event[ "pyre_holdout" ].var_de0e7ba14e831fa0 = arrayremove( level.holdout_event[ "pyre_holdout" ].var_de0e7ba14e831fa0, pyre_zone );
        
        if ( compass.code_index == compass.full_code.size )
        {
            compass thread function_1293aee8aea10da7( 1, params.eattacker );
            return;
        }
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        }
        
        return;
    }
    
    compass thread function_147ab48c2accd35b();
    
    if ( !compass.failed_dialogue )
    {
        compass.failed_dialogue = 1;
        level thread battlechatter_mp::trysaylocalsound( params.eattacker, #"bc_flavor_player_negative" );
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 2, eflags: 0x4
// Checksum 0x8d45fe27, Offset: 0x31a1
// Size: 0x196
function private function_1293aee8aea10da7( set_flag = 1, eattacker )
{
    var_156edbbce622cae7 = [];
    
    foreach ( pyre in self.pyres )
    {
        if ( pyre getscriptablepartstate( #"lit" ) != "lit" )
        {
            continue;
        }
        
        pyre zm_damage::function_c31f9d79d5ceb7ec( &function_849367bc681da858 );
        pyre callback::remove( #"hash_11e40a4909e138f7", &function_d057e3bf16069779 );
        var_156edbbce622cae7[ var_156edbbce622cae7.size ] = pyre;
    }
    
    wait 1;
    
    foreach ( pyre in var_156edbbce622cae7 )
    {
        pyre setscriptablepartstate( #"lit", #"lit_complete" );
    }
    
    if ( set_flag )
    {
        level thread function_4be35b2d7a221a6( eattacker );
    }
    
    wait 2;
    zm_sat_locust_util::end_holdout_event( "pyre_holdout" );
    
    if ( set_flag )
    {
        utility::flag_set( "mq_rl_step_05" );
        utility::flag_set( "mq_rl_core" );
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0xa33f7dd6, Offset: 0x333f
// Size: 0x6d
function private function_4be35b2d7a221a6( eattacker )
{
    dialog_ent = utility::spawn_tag_origin( ( 2538.96, 11507.2, 2866.12 ) );
    dialog_ent dialogue::say_self( "dx_locust_virgil_exert_pain" );
    dialog_ent delete();
    
    if ( eattacker && isalive( eattacker ) && eattacker namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        eattacker thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_f296370c3456b4b0" );
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0xb67fbc87, Offset: 0x33b4
// Size: 0xc0
function private function_147ab48c2accd35b()
{
    /#
        level notify( #"compass_reset" );
    #/
    
    zm_sat_locust_util::end_holdout_event( "pyre_holdout" );
    
    foreach ( pyre in self.pyres )
    {
        pyre setscriptablepartstate( #"lit", #"lit_incorrectly" );
    }
    
    wait 2;
    function_fc20ef8141f72e45( 1 );
    function_62fd8de46c149c69();
    thread function_629468129e8e515c();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0xc56fe432, Offset: 0x347c
// Size: 0x179
function private function_fc20ef8141f72e45( reset = 0 )
{
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_e254894438a37f89" ) )
    {
        return;
    }
    
    compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
    
    foreach ( pyre in compass.pyres )
    {
        pyre.health = 0;
        pyre zm_damage::function_c31f9d79d5ceb7ec( &function_849367bc681da858 );
        pyre callback::remove( #"hash_11e40a4909e138f7", &function_d057e3bf16069779 );
        
        if ( pyre.blockers )
        {
            utility::array_delete( pyre.blockers );
        }
        
        pyre utility::function_32b24db3127bff40( #"hash_bfedd21f6f583ddd", #"default" );
        
        if ( reset )
        {
            pyre setscriptablepartstate( #"body", #"default" );
            pyre setscriptablepartstate( #"lit", #"hash_6475bb4ea8b1d5bf" );
            pyre.base setscriptablepartstate( #"body", #"default" );
        }
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x5f8bd390, Offset: 0x35fd
// Size: 0x2c
function private function_989be8e9a1edbdc9( damagedata )
{
    if ( namespace_e625df044ece0a58::function_c531ee6013cf3d72( damagedata ) )
    {
        return self.health;
    }
    
    return damagedata.damage;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0xaf433287, Offset: 0x3632
// Size: 0xb4
function private function_98b5a7837c13d7c8( damagedata )
{
    self.pyre.blockers = arrayremove( self.pyre.blockers, self );
    
    if ( self.pyre.blockers.size == 1 )
    {
        other_blocker = self.pyre.blockers[ 0 ];
        other_blocker thread zm_sat_locust_util::function_3fa3cd4714495cf7( 96, 1.5, other_blocker.pyre, 1, undefined, 1 );
    }
    
    self setscriptablepartstate( #"effects", #"destroyed" );
    utility::delete_after_delay( 1 );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0xa70522b4, Offset: 0x36ee
// Size: 0x9c
function private function_28077e55bc195191( pyres )
{
    var_4fc9b62ba71956f8 = [ 1, 2, 3, 4, 5, 6, 7, 8 ];
    var_4fc9b62ba71956f8 = arrayrandomize( var_4fc9b62ba71956f8 );
    pyre_code = 0;
    
    for ( i = 0; i < pyres.size ; i++ )
    {
        digit = var_4fc9b62ba71956f8[ i ];
        pyre_code = int( pyre_code + digit * int( pow( 10, i ) ) );
    }
    
    return pyre_code;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0xca064ef9, Offset: 0x3793
// Size: 0x46a
function private function_39d77a454dfa20b3()
{
    utility::add_fx( "uther_beam", "vfx_sat_levels_zm_locust_rupert_beam" );
    pyres = getentitylessscriptablearray( %"sat_zm_pyre_leonard" );
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        if ( !utility::flag( "zm_save_level_restore_keys_complete" ) )
        {
            return;
        }
        
        pyre_code = zm_quest::function_73720cdf21c3cfd7( #"hash_9a9f22ecb2a5ad11", #"pyre_code" );
    }
    else
    {
        pyre_code = function_28077e55bc195191( pyres );
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"hash_9a9f22ecb2a5ad11", #"pyre_code", pyre_code );
    var_e1c9c1919deaeecb = [];
    
    foreach ( idx, pyre in pyres )
    {
        pyre.base = getentitylessscriptablearray( pyre.target, #targetname )[ 0 ];
        assert( isdefined( pyre.base ) );
        var_e1c9c1919deaeecb[ int( pyre.base.script_noteworthy ) ] = pyre;
    }
    
    var_d3171d851a1a1977 = "" + pyre_code;
    
    foreach ( idx, pyre in var_e1c9c1919deaeecb )
    {
        digit = int( var_d3171d851a1a1977[ idx - 1 ] );
        pyre.code = digit;
        assert( pyre.code > 0 );
    }
    
    level.quest_mq.locate_quest.pyre_code = pyre_code;
    level.quest_mq.locate_quest.var_156edbbce622cae7 = 0;
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_fe8af74b7a14db1e", pyres );
    compass_loc = utility::getstruct( "mqlo_co_lo" );
    compass = spawnscriptable( %"sat_zm_prop_uther_base", compass_loc.origin, compass_loc.angles );
    num_degrees = 22.5;
    var_c4ee686de4669900 = [];
    
    for ( i = 1; i <= 3 ; i++ )
    {
        switch ( i )
        {
            case 1:
                default_pos = 11;
                yaw = num_degrees * 8;
                break;
            case 2:
                default_pos = 5;
                yaw = num_degrees * 2;
                break;
            case 3:
                default_pos = 1;
                yaw = num_degrees * -2;
                break;
        }
        
        layer = utility::spawn_model( %"sat_zm_prop_uther_arrow", compass_loc.origin, compass_loc.angles + ( 0, yaw, 0 ) );
        layer forcenetfieldhighlod( 1 );
        layer.idx = i - 1;
        layer.default_angles = layer.angles;
        layer.default_pos = default_pos;
        layer hide();
        var_c4ee686de4669900[ var_c4ee686de4669900.size ] = layer;
    }
    
    compass.var_c4ee686de4669900 = var_c4ee686de4669900;
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_e254894438a37f89", compass );
    compass function_62fd8de46c149c69();
    utility::flag_wait( "scriptables_ready" );
    
    foreach ( layer in var_c4ee686de4669900 )
    {
        layer setscriptablepartstate( #"sat_zm_prop_uther_arrow", hashcat( #"arrow_0", layer.idx + 1 ) );
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x253b8230, Offset: 0x3c05
// Size: 0x64
function private function_9e35d9e096a75e20()
{
    level endon( #"mq_rl_step_05" );
    compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
    compass setscriptablepartstate( #"model", #"visible" );
    compass setscriptablepartstate( #"effects", #"active" );
    compass function_629468129e8e515c();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0xc973007d, Offset: 0x3c71
// Size: 0x97
function private function_4dfcd3afd8facab0()
{
    base_code = [ 1, 2, 3, 4, 5, 6, 7, 8 ];
    remainder_code = arraycopy( base_code );
    compass_code = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        digit = utility::array_random( remainder_code );
        remainder_code = arrayremove( remainder_code, digit );
        compass_code[ compass_code.size ] = digit;
    }
    
    return compass_code;
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x7497da47, Offset: 0x3d11
// Size: 0xb2
function private function_62fd8de46c149c69()
{
    codes = function_4dfcd3afd8facab0();
    
    for ( i = 0; i < codes.size ; i++ )
    {
        self.var_c4ee686de4669900[ i ].old_pos = self.var_c4ee686de4669900[ i ].code_pos ?? self.var_c4ee686de4669900[ i ].default_pos;
        self.var_c4ee686de4669900[ i ].code_pos = codes[ i ];
    }
    
    self.full_code = codes;
    self.code_index = 0;
    self.pyres = function_d07cf90bfd3dee4();
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x3d71a990, Offset: 0x3dcb
// Size: 0x326
function private function_629468129e8e515c()
{
    foreach ( layer in self.var_c4ee686de4669900 )
    {
        layer show();
        layer.code_idx = undefined;
        layer.code_pos = undefined;
    }
    
    if ( utility::ent_flag( "rotate_done" ) )
    {
        utility::ent_flag_clear( "rotate_done" );
    }
    else
    {
        ring_objs = [];
        points = function_5245578b24385b1c( self.origin, 415, 16, 22.5 );
        
        for ( i = 0; i < points.size ; i++ )
        {
            point = points[ i ];
            idx = i + 1;
            
            if ( i > 7 )
            {
                idx = i - 7;
            }
            
            obj = spawnscriptable( %"sat_zm_prop_uther_rune", point, vectortoangles( point - self.origin ) );
            obj setscriptablepartstate( "effects", "rune_0" + idx );
            obj.rune_idx = idx;
            obj.position = i;
            ring_objs[ ring_objs.size ] = obj;
        }
        
        self.ring_objs = ring_objs;
    }
    
    self setscriptablepartstate( #"reset", #"arrow_rotate" );
    self.rotations = 0;
    function_75e5de37169d8001();
    thread function_684aa639bb20060d();
    
    foreach ( idx, layer in self.var_c4ee686de4669900 )
    {
        thread function_83d464d1378a00ea( layer );
        wait randomfloatrange( 0.25, 0.75 );
    }
    
    utility::ent_flag_wait( "rotate_done" );
    
    foreach ( obj in self.ring_objs )
    {
        obj setscriptablepartstate( "effects", "rune_0" + obj.rune_idx );
    }
    
    self setscriptablepartstate( #"reset", #"arrow_stop" );
    function_8d0c192eae3e11de();
    level thread function_b6bf15d00dd56a8e();
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    /#
        if ( self.show_debug )
        {
            function_e197959697b3a954();
            function_e36c0cf30254a861();
        }
    #/
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x75844e6b, Offset: 0x40f9
// Size: 0x2af
function private function_75e5de37169d8001()
{
    ring_objs = arrayrandomize( self.ring_objs );
    selected_objs = [];
    selected_positions = [];
    
    for ( i = 0; i < self.full_code.size ; i++ )
    {
        code = self.full_code[ i ];
        assert( isdefined( code ) );
        
        foreach ( obj in ring_objs )
        {
            assert( isdefined( obj.rune_idx ) );
            
            if ( obj.rune_idx == code )
            {
                safe = 1;
                
                foreach ( position in selected_positions )
                {
                    if ( abs( position - obj.position ) == 8 )
                    {
                        safe = 0;
                        break;
                    }
                }
                
                if ( safe )
                {
                    self.var_c4ee686de4669900[ i ].code_pos = obj.position;
                    self.var_c4ee686de4669900[ i ].code_idx = obj.rune_idx;
                    selected_positions[ selected_positions.size ] = obj.position;
                    selected_objs[ selected_objs.size ] = obj;
                    assert( isdefined( obj.rune_idx ) );
                    assert( isdefined( self.var_c4ee686de4669900[ i ].code_pos ) );
                    assert( isdefined( self.var_c4ee686de4669900[ i ].code_idx ) );
                    assert( self.var_c4ee686de4669900[ i ].code_idx == code );
                    break;
                }
            }
        }
        
        assert( selected_positions.size == i + 1 );
        assert( self.var_c4ee686de4669900[ i ].code_idx == code );
    }
    
    /#
        if ( self.show_debug )
        {
            function_b02f11d5e37add33();
        }
    #/
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x7f8ac5cf, Offset: 0x43b0
// Size: 0xcb
function private function_684aa639bb20060d( var_e8fb86694955a311 = 0 )
{
    if ( !var_e8fb86694955a311 )
    {
        self endon( #"rotate_done" );
    }
    
    while ( true )
    {
        foreach ( obj in self.ring_objs )
        {
            i = randomint( 8 ) + 1;
            obj setscriptablepartstate( "effects", "rune_0" + i );
        }
        
        wait 0.2;
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 5, eflags: 0x4
// Checksum 0x275b422c, Offset: 0x4483
// Size: 0x1b1
function private function_83d464d1378a00ea( layer, num_rotations = 3, var_5a385538a11a3beb = 1, accel_percent = 0.25, decel_percent = 0.5 )
{
    layer notify( #"rotating" );
    num_degrees = 360 / self.ring_objs.size;
    rotate_time = var_5a385538a11a3beb * num_rotations;
    accel_time = accel_percent > 0 ? rotate_time * accel_percent : 0;
    layer rotateyaw( 360 * num_rotations, rotate_time, accel_time );
    layer waittill( #"rotatedone" );
    remaining_positions = 0;
    current_pos = layer.old_pos;
    
    for ( i = 0; i < self.ring_objs.size ; i++ )
    {
        if ( current_pos == layer.code_pos )
        {
            remaining_positions = i;
            break;
        }
        
        current_pos++;
        
        if ( current_pos == self.ring_objs.size )
        {
            current_pos = 0;
        }
    }
    
    rotate_time = var_5a385538a11a3beb / self.ring_objs.size * remaining_positions;
    decel_time = decel_percent > 0 ? rotate_time * decel_percent : 0;
    
    if ( rotate_time > 0 )
    {
        layer rotateyaw( remaining_positions * num_degrees, rotate_time, 0, decel_time );
        layer waittill( #"rotatedone" );
    }
    
    self.rotations++;
    
    if ( self.rotations == self.var_c4ee686de4669900.size )
    {
        utility::ent_flag_set( "rotate_done" );
    }
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x338d62bd, Offset: 0x463c
// Size: 0x1c2
function private function_b6bf15d00dd56a8e()
{
    var_6363020203d4315f = function_d07cf90bfd3dee4();
    var_7ad17415ec48d958 = [];
    
    foreach ( pyre in var_6363020203d4315f )
    {
        pyre_target = utility::getstruct( pyre.base.target );
        var_759e4a55f4b07d78 = zone_manager::function_90e5c3e2272b0130( pyre_target.origin );
        var_7ad17415ec48d958[ var_7ad17415ec48d958.size ] = var_759e4a55f4b07d78;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        difficulty_round_number = zm_utility::get_round_number();
    }
    else
    {
        difficulty_round_number = 15;
    }
    
    params = { #max_active_zombies:15, #forced_move_speed:"sprint", #var_d346909023f61570:difficulty_round_number, #difficulty_round_number:difficulty_round_number, #skip_eyes:0, #aitypes:[ { #type:"zombie_base_luna", #weight:50 }, { #type:"zombie_base_armored_light", #weight:20 }, { #type:"zombie_base_armored_heavy", #weight:30 } ], #var_1e899b25f3766233:0, #spawn_zones:var_7ad17415ec48d958, #name:"pyre_holdout" };
    level thread zm_sat_locust_util::holdout_event( params );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 1, eflags: 0x4
// Checksum 0x5aed4f2b, Offset: 0x4806
// Size: 0x39f
function private function_86677aab8cb180f6( skipped = 0 )
{
    self endon( #"death" );
    
    if ( skipped )
    {
        if ( self getscriptablepartstate( #"effects", 0, 1 ) != #"active" )
        {
            self setscriptablepartstate( #"model", #"visible" );
            self setscriptablepartstate( #"effects", #"active" );
            ring_objs = [];
            points = function_5245578b24385b1c( self.origin, 415, 16, 22.5 );
            
            for ( i = 0; i < points.size ; i++ )
            {
                point = points[ i ];
                idx = i + 1;
                
                if ( i > 7 )
                {
                    idx = i - 7;
                }
                
                obj = spawnscriptable( %"sat_zm_prop_uther_rune", point, vectortoangles( point - self.origin ) );
                obj setscriptablepartstate( "effects", "rune_0" + idx );
                obj.rune_idx = idx;
                obj.position = i;
                ring_objs[ ring_objs.size ] = obj;
            }
            
            self.ring_objs = ring_objs;
            
            foreach ( layer in self.var_c4ee686de4669900 )
            {
                layer show();
                layer setscriptablepartstate( #"sat_zm_prop_uther_arrow", hashcat( #"arrow_0", layer.idx + 1 ) );
            }
            
            self.rotations = 0;
            function_75e5de37169d8001();
            thread function_684aa639bb20060d();
            
            foreach ( idx, layer in self.var_c4ee686de4669900 )
            {
                thread function_83d464d1378a00ea( layer, 1 );
                wait randomfloatrange( 0.25, 0.75 );
            }
            
            utility::ent_flag_wait( "rotate_done" );
            utility::ent_flag_clear( "rotate_done" );
            self.rotations = 0;
        }
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        self.var_c4ee686de4669900[ i ].old_pos = self.var_c4ee686de4669900[ i ].code_pos;
        self.var_c4ee686de4669900[ i ].code_pos = 2;
    }
    
    thread function_684aa639bb20060d();
    
    foreach ( idx, layer in self.var_c4ee686de4669900 )
    {
        thread function_83d464d1378a00ea( layer, 6 );
        wait randomfloatrange( 0.25, 0.75 );
    }
    
    utility::ent_flag_wait( "rotate_done" );
    self setscriptablepartstate( #"reset", #"off" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 0, eflags: 0x4
// Checksum 0x9282f00c, Offset: 0x4bad
// Size: 0x110
function private function_c86aa975cc7e4908()
{
    utility::flag_wait_any( "boss_fight_start", "mq_step_02" );
    compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
    utility::array_delete( compass.var_c4ee686de4669900 );
    
    foreach ( obj in compass.ring_objs )
    {
        obj freescriptable();
    }
    
    compass setscriptablepartstate( #"effects", #"end" );
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_789c304adecfa1dc" );
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_49fe01f298f554e2" );
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_576eab2f9ebd38b0" );
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_e254894438a37f89" );
}

// Namespace namespace_ee77ed3d068c5ad5
// Params 4, eflags: 0x4
// Checksum 0xddf0c6e2, Offset: 0x4cc5
// Size: 0xb1
function private function_5245578b24385b1c( origin, radius, num_points, yaw = 0 )
{
    points = [];
    angle_increment = 360 / num_points;
    
    for ( i = 0; i < num_points ; i++ )
    {
        theta = mod( angle_increment * i + yaw, 360 );
        offset = ( radius * cos( theta ), radius * sin( theta ), 0 );
        point = origin + offset;
        points[ points.size ] = point;
    }
    
    return points;
}

/#

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0x162cd95, Offset: 0x4d7f
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0x481d44e1, Offset: 0x4d93
    // Size: 0x164, Type: dev
    function private devgui_init()
    {
        zm_quest::function_bc99f123a684344f( #"hash_9a9f22ecb2a5ad11" );
        devgui::add_devgui_func( "<dev string:x3a>", "<dev string:x52>", &function_f022c6f67cf1d803 );
        zm_quest::function_c1400a2f4670c23f();
        zm_quest::function_1b5b11caffa04d9a( #"hash_9a9f22ecb2a5ad11", #"hash_1a6c2f18426c14d7" );
        devgui::add_devgui_func( "<dev string:x62>", "<dev string:x75>", &function_2643366036f9bea3 );
        devgui::add_devgui_func( "<dev string:x8f>", "<dev string:xa3>", &function_fc35c7859fc817a2 );
        zm_quest::function_c1400a2f4670c23f();
        zm_quest::function_1b5b11caffa04d9a( #"hash_9a9f22ecb2a5ad11", #"hash_6b5a806498d19632" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb8>", "<dev string:xd3>", &function_a79ae89ab3c8383a );
        devgui::function_cd4e263c1f3018ae( "<dev string:xed>", "<dev string:x10a>", &function_a79ae89ab3c8383a );
        devgui::add_devgui_func( "<dev string:x124>", "<dev string:x132>", &function_fe9e1b166363242 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x147>", "<dev string:x161>", &function_d7fa9930286358c2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x178>", "<dev string:x192>", &function_d7fa9930286358c2 );
        devgui::add_devgui_func( "<dev string:x1a9>", "<dev string:x1bb>", &function_32ec10e9141102c2 );
        devgui::add_devgui_func( "<dev string:x1d5>", "<dev string:x1eb>", &function_f298cc582ee0a30a );
        devgui::add_devgui_func( "<dev string:x207>", "<dev string:x211>", &function_1a0107a9a75a33b6 );
        devgui::add_devgui_func( "<dev string:x22a>", "<dev string:x23c>", &function_6c98b13fcee51ec6 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0xa7d86b2e, Offset: 0x4eff
    // Size: 0x164, Type: dev
    function private function_f022c6f67cf1d803()
    {
        zm_utility::open_sesame();
        var_3fb6e6959465a40a = [ #"locust_quest_pap", #"hash_709d77ab2b2005c5", #"hash_d1612ed5d50da819", #"hash_7b26a8bb39d7312" ];
        
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
        
        utility::flag_wait( "<dev string:x25b>" );
        waitframe();
        level notify( #"virgil_react_spawn_item" );
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0x20e698ea, Offset: 0x506b
    // Size: 0x15, Type: dev
    function private function_2643366036f9bea3()
    {
        function_6cf778806f9705ad( level.player );
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 1, eflags: 0x4
    // Checksum 0xa83d364e, Offset: 0x5088
    // Size: 0x148, Type: dev
    function private function_a79ae89ab3c8383a( params )
    {
        compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
        
        if ( params[ 0 ] == "<dev string:x269>" )
        {
            foreach ( pyre in compass.pyres )
            {
                if ( compass.full_code[ compass.code_index ] == pyre.code )
                {
                    pyre setscriptablepartstate( #"lit", #"lit" );
                    utility::array_delete( pyre.blockers );
                    compass.code_index++;
                    
                    if ( compass.code_index == compass.full_code.size )
                    {
                        compass thread function_1293aee8aea10da7();
                        return;
                    }
                }
            }
            
            iprintlnbold( "<dev string:x26b>" );
            return;
        }
        
        compass thread function_147ab48c2accd35b();
        iprintlnbold( "<dev string:x286>" );
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0xa2aecd23, Offset: 0x51d8
    // Size: 0x47, Type: dev
    function private function_fe9e1b166363242()
    {
        level notify( #"compass_reset" );
        compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
        function_fc20ef8141f72e45( 1 );
        compass function_62fd8de46c149c69();
        compass thread function_629468129e8e515c();
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 1, eflags: 0x4
    // Checksum 0xe06c91de, Offset: 0x5227
    // Size: 0x116, Type: dev
    function private function_d7fa9930286358c2( params )
    {
        compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
        
        if ( params[ 0 ] == "<dev string:x269>" )
        {
            compass thread function_1293aee8aea10da7( 0 );
            return;
        }
        
        var_156edbbce622cae7 = [];
        var_50ed1b4545a07f7a = [];
        
        foreach ( pyre in compass.pyres )
        {
            if ( pyre getscriptablepartstate( #"lit" ) == "<dev string:x2a3>" )
            {
                var_156edbbce622cae7[ var_156edbbce622cae7.size ] = pyre;
            }
            else
            {
                var_50ed1b4545a07f7a[ var_50ed1b4545a07f7a.size ] = pyre;
            }
            
            pyre setscriptablepartstate( #"lit", #"lit_incorrectly" );
        }
        
        level thread function_2cc53994b5ca24c6( var_156edbbce622cae7, var_50ed1b4545a07f7a );
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 2, eflags: 0x4
    // Checksum 0x6150fd7, Offset: 0x5345
    // Size: 0x115, Type: dev
    function private function_2cc53994b5ca24c6( var_156edbbce622cae7, var_50ed1b4545a07f7a )
    {
        wait 3;
        
        foreach ( pyre in var_156edbbce622cae7 )
        {
            pyre setscriptablepartstate( #"lit", #"lit" );
        }
        
        foreach ( pyre in var_50ed1b4545a07f7a )
        {
            pyre setscriptablepartstate( #"lit", #"hash_6475bb4ea8b1d5bf" );
        }
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0xe90a5e1, Offset: 0x5462
    // Size: 0x174, Type: dev
    function private function_32ec10e9141102c2()
    {
        compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
        
        if ( compass.show_debug )
        {
            compass.show_debug = 0;
            level notify( #"compass_reset" );
            compass notify( #"debug_code" );
            
            foreach ( layer in compass.var_c4ee686de4669900 )
            {
                layer notify( #"debug_code" );
            }
            
            foreach ( obj in compass.ring_objs )
            {
                obj notify( #"debug_code" );
            }
            
            return;
        }
        
        compass.show_debug = 1;
        function_e197959697b3a954();
        function_b02f11d5e37add33();
        function_e36c0cf30254a861();
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0x8901b349, Offset: 0x55de
    // Size: 0x149, Type: dev
    function private function_e197959697b3a954()
    {
        compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
        
        foreach ( idx, layer in compass.var_c4ee686de4669900 )
        {
            layer notify( #"debug_code" );
            debug::print3d( layer, "<dev string:x2a7>" + idx + 1 + "<dev string:x2ae>" + layer.code_idx, ( 0, 1, 0 ), undefined, undefined, "<dev string:x2b8>", undefined, undefined, 10 * idx );
        }
        
        compass notify( #"debug_code" );
        debug::print3d( compass, "<dev string:x2c3>" + compass.full_code[ 0 ] + "<dev string:x2ca>" + compass.full_code[ 1 ] + "<dev string:x2ca>" + compass.full_code[ 2 ], ( 1, 1, 0 ), undefined, undefined, "<dev string:x2b8>", undefined, undefined, 50 );
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0x2cbd1e80, Offset: 0x572f
    // Size: 0x101, Type: dev
    function private function_b02f11d5e37add33()
    {
        compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
        
        foreach ( obj in compass.ring_objs )
        {
            obj notify( #"debug_code" );
            debug::print3d( obj, "<dev string:x2cd>" + obj.rune_idx, ( 0, 1, 0 ), undefined, undefined, "<dev string:x2b8>", undefined, undefined, 30 );
            debug::print3d( obj, "<dev string:x2d9>" + obj.position, ( 0, 0, 1 ), undefined, undefined, "<dev string:x2b8>", undefined, undefined, 15 );
        }
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0x80d11f01, Offset: 0x5838
    // Size: 0x226, Type: dev
    function private function_e36c0cf30254a861()
    {
        compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
        
        foreach ( layer in compass.var_c4ee686de4669900 )
        {
            end = layer.origin + anglestoleft( layer.angles ) * 300;
            debug::line( compass, end, ( 1, 1, 1 ), undefined, "<dev string:x2ec>" );
            debug::print3d( end, "<dev string:x2fa>" + layer.idx + "<dev string:x2ff>" + layer.code_idx, ( 1, 1, 0 ), undefined, "<dev string:x2ec>", undefined, 1, 5, 24 );
            
            foreach ( pyre in compass.pyres )
            {
                if ( pyre.code == layer.code_idx )
                {
                    debug::line( end, pyre.origin, ( 1, 1, 1 ), undefined, "<dev string:x2ec>" );
                    debug::print3d( pyre.origin, "<dev string:x2fa>" + layer.idx + "<dev string:x2ff>" + layer.code_idx, ( 1, 1, 0 ), undefined, "<dev string:x2ec>", undefined, 1, 5 );
                }
            }
        }
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0x6f9aa2b3, Offset: 0x5a66
    // Size: 0xef, Type: dev
    function private function_fc35c7859fc817a2()
    {
        hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
        
        for ( ;; )
        {
            player_fwd = anglestoforward( level.player.angles );
            fire_fwd = vectornormalize( hall_fire.origin - level.player.origin );
            dot = vectordot( player_fwd, fire_fwd );
            debug::print3d( hall_fire, abs( dot ), ( 1, 1, 1 ), level.framedurationseconds );
            debug::print3d( hall_fire, distance2d( level.player.origin, hall_fire.origin ), ( 1, 1, 1 ), level.framedurationseconds, undefined, undefined, undefined, undefined, 16 );
            waitframe();
        }
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0xb8496b3e, Offset: 0x5b5d
    // Size: 0x2a8, Type: dev
    function private function_f298cc582ee0a30a()
    {
        pyres = zm_sat_locust_util::get_quest_reference( #"hash_fe8af74b7a14db1e" );
        
        if ( level.quest_mq.locate_quest.var_1c0084bdacbb7281 )
        {
            level.quest_mq.locate_quest.var_1c0084bdacbb7281 = 0;
            level notify( #"hash_4566889668a327ca" );
            iprintlnbold( "<dev string:x302>" );
            
            foreach ( pyre in pyres )
            {
                pyre utility::function_32b24db3127bff40( #"body", #"default" );
                pyre.base utility::function_32b24db3127bff40( #"body", #"default" );
                pyre setscriptablepartstate( #"hash_bfedd21f6f583ddd", "<dev string:x317>" );
            }
            
            return;
        }
        
        level.quest_mq.locate_quest.var_1c0084bdacbb7281 = 1;
        iprintlnbold( "<dev string:x31f>" );
        
        foreach ( pyre in pyres )
        {
            pyre utility::function_32b24db3127bff40( #"body", #"visible" );
            pyre.base utility::function_32b24db3127bff40( #"body", #"visible" );
            pyre setscriptablepartstate( #"hash_bfedd21f6f583ddd", "<dev string:x333>" + pyre.code );
            line_origin = pyre.origin + ( 0, 0, 260 );
            debug::line( line_origin, line_origin + ( 0, 0, 1000 ), ( 0, 1, 0 ), undefined, "<dev string:x339>" );
            debug::print3d( pyre.origin, "<dev string:x34f>" + pyre.code, ( 0, 1, 0 ), undefined, "<dev string:x339>", undefined, 1, 2, 240 );
        }
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0x8024235b, Offset: 0x5e0d
    // Size: 0x104, Type: dev
    function private function_1a0107a9a75a33b6()
    {
        pyres = getentitylessscriptablearray( %"sat_zm_pyre_leonard" );
        
        for ( i = 0; i < 50 ; i++ )
        {
            pyre_code = function_28077e55bc195191( pyres );
            var_4fc9b62ba71956f8 = [];
            var_d3171d851a1a1977 = "<dev string:x355>" + pyre_code;
            
            foreach ( idx, pyre in pyres )
            {
                digit = int( var_d3171d851a1a1977[ idx ] );
                pyre.code = digit;
                assert( !arraycontains( var_4fc9b62ba71956f8, digit ) );
                var_4fc9b62ba71956f8[ var_4fc9b62ba71956f8.size ] = digit;
            }
        }
    }

    // Namespace namespace_ee77ed3d068c5ad5
    // Params 0, eflags: 0x4
    // Checksum 0xf66909ab, Offset: 0x5f19
    // Size: 0x187, Type: dev
    function private function_6c98b13fcee51ec6()
    {
        compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
        
        for ( i = 0; i < 200 ; i++ )
        {
            level notify( #"compass_reset" );
            
            if ( zm_sat_locust_util::is_holdout_event_active( "<dev string:x356>" ) )
            {
                zm_sat_locust_util::end_holdout_event( "<dev string:x356>" );
            }
            
            function_fc20ef8141f72e45( 1 );
            compass function_62fd8de46c149c69();
            compass function_629468129e8e515c();
            
            foreach ( code in compass.full_code )
            {
                valid = 0;
                
                foreach ( pyre in compass.pyres )
                {
                    if ( pyre.code == code )
                    {
                        valid = 1;
                        break;
                    }
                }
                
                assert( valid );
            }
        }
    }

#/
