// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ww_quest.gsc  (hash_3cbbf033ca1fe367.gscc) (size: 81744 Bytes / 0x13f50 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xba6cc6e2 (3127690978)
// size ...... 81744 (0x13f50)
// includes .. 34  (offset: 0x12be0)
// strings ... 235 (offset: 0x12cf0)
// dev strs .. 9   (offset: 0x13ed8)
// exports ... 177 (offset: 0xd254)
// cseg ...... 0x10e7 + 0xc16d (0xd254)
// imports ... 417 (offset: 0xedfc)
// animtree1 . 0   (offset: 0x13f50)
// animtree2 . 0   (offset: 0x13f50)
#using script_16ea1b94f0f381b3;
#using scripts\anim\dialogue;
#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\crafting_table;
#using scripts\mp\currency;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\supers;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_ash;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_ww_quest;

// Namespace zm_sat_hornet_ww_quest
// Params 0, eflags: 0x5
// Checksum 0x8bb9f88c, Offset: 0x1105
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hornet_ww_quest", #"zm_quest", &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x113fcbc5, Offset: 0x1132
// Size: 0x1a4
function function_7cf8dacb278a2665()
{
    if ( !getdvarint( @"hash_a848de4270c1778d", 0 ) || game_utility::function_21211f3255f8ea58() )
    {
        return;
    }
    
    level._effect[ "beam_capture" ] = loadfxasset( "vfx_sat_hornet_wwq_hair_beam" );
    level utility::flag_wait( "zm_quest_initialized" );
    level.hornet_ww_quest = zm_quest::get_quest( #"hornet_ww_quest" );
    level.ww_neko = spawnstruct();
    zm_quest::register_quest_step( #"hornet_ww_quest", #"free_nekomata", &function_b6562f5032f3dada, &function_cbc503a769bb3717 );
    zm_quest::register_quest_step( #"hornet_ww_quest", #"craft_maneki_neko", &function_b6562e5032f3d8a7, &function_cbc504a769bb394a );
    zm_quest::register_quest_step( #"hornet_ww_quest", #"lure_nekomata", &function_b6562d5032f3d674, &function_cbc505a769bb3b7d );
    zm_quest::register_quest_step( #"hornet_ww_quest", #"defeat_abom", &function_b6562c5032f3d441, &function_cbc4fea769bb2c18 );
    zm_quest::register_quest_step( #"hornet_ww_quest", #"capture_nekomata", &function_b6562b5032f3d20e, &function_cbc4ffa769bb2e4b );
    zm_quest::register_quest_step( #"hornet_ww_quest", #"save_nekomata", &function_b6562a5032f3cfdb, &function_cbc500a769bb307e );
    equipment_mp::function_2e4e9b7492b36578( "equip_carrier" );
    level thread function_bfad22a0d43eb483();
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"wwq", &function_2eb45098b7a8810d );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"cat_cage", &function_26cd1565cc73c321 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"abom", &function_dfe492d5ff917b33 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"prints", &function_ffec2500434a13d );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x27e777d6, Offset: 0x12de
// Size: 0x15
function postmain_init()
{
    if ( !getdvarint( @"hash_a848de4270c1778d", 0 ) )
    {
        return;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x252d1ab3, Offset: 0x12fb
// Size: 0x13d
function function_bfad22a0d43eb483()
{
    zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    restore_inventory();
    setup_maneki_neko();
    function_9a1f1850fb7b514b();
    level thread setup_swim();
    level thread setup_cage_assets();
    level thread setup_board_monitoring();
    level thread save_inventory();
    level thread create_blocker();
    level.var_30c6488505ccf63f = utility::getstructarray( "nekomata_sleep" );
    callback::add( #"player_used_item", &function_4fdaa33c0b4032c1 );
    callback::add( #"equipment_given", &function_e56f21f226a4498b );
    level utility::flag_wait( "power_on" );
    level thread zm_quest::start_quest( #"hornet_ww_quest" );
    callback::add( #"hash_9456270bf9577eb1", &function_e50bcdcd85f38cc1 );
    callback::add( #"hash_4cc399a485ab171d", &function_136fc86690f5969d );
    callback::add( #"hash_c677129e3ed530bc", &function_bf63101e04707fa7 );
    callback::add( #"player_disconnect", &function_f4a8a2e11376936c );
    callback::add( #"player_death", &function_2b5b36568e9c1ed8 );
    callback::add( #"player_laststand", &function_f89f89e6dc9178d3 );
    level thread setup_lava_triggers();
    level thread paw_print_reveal();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xada50118, Offset: 0x1440
// Size: 0x45
function create_blocker()
{
    v_pos = ( 1629, -23222, 243 );
    var_7c00f823b7c297d4 = createnavobstaclebybounds( v_pos, ( 35, 35, 1000 ), ( 0, 0, 0 ) );
}

// Namespace zm_sat_hornet_ww_quest
// Params 4
// Checksum 0xcd8a379c, Offset: 0x148d
// Size: 0x13e
function nekomata_leap( v_start, v_end, var_51ef870503967f06, n_time )
{
    self endon( #"death" );
    v_face = vectortoangles( vectornormalize( v_end - v_start ) );
    v_face = ( 0, v_face[ 1 ], 0 );
    self.var_8d21ca07b4ff1b6f.angles = v_face;
    wait 1;
    self setscriptablepartstate( "visual", "leap_in" );
    control_pt = ( v_start + v_end ) / 2 + ( 0, 0, var_51ef870503967f06 );
    self.var_8d21ca07b4ff1b6f thread utility::function_8001268940441423( v_start, v_end, control_pt, n_time, undefined, 1 );
    self.var_8d21ca07b4ff1b6f thread function_e59fbc19bb3045ac( n_time );
    wait n_time - 1.1;
    self setscriptablepartstate( "visual", "leap_out" );
    wait 1.1;
    self.var_8d21ca07b4ff1b6f utility::waittill_any_timeout( 0.1, "off_bezier_curve" );
    self.var_8d21ca07b4ff1b6f notify( #"landed" );
    self.var_8d21ca07b4ff1b6f.angles = v_face;
    self setscriptablepartstate( "visual", "dropped" );
    self notify( #"leap_done" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x1ec3c287, Offset: 0x15d3
// Size: 0x42
function function_e59fbc19bb3045ac( n_time )
{
    self endon( #"landed" );
    wait n_time * 0.5;
    self rotateroll( 35, 1 );
    self waittill( #"rotatedone" );
    self rotateroll( -35, 1 );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x74a09e96, Offset: 0x161d
// Size: 0x5a
function function_b6562f5032f3dada( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread function_3806b8f9be349f5f();
        level thread function_45c94bbda041a73f();
        
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            function_ecc91637c2a6fbb1();
        }
    }
    
    level utility::flag_wait( "completed_ww_step_1" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x5d3a1c2a, Offset: 0x167f
// Size: 0x45
function function_cbc503a769bb3717( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level thread nekomata_setup();
        level thread cage_melt();
        level thread function_b258440d0df12de6();
    }
    
    level utility::flag_set( "completed_ww_step_1" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x772783e2, Offset: 0x16cc
// Size: 0x22
function function_b6562e5032f3d8a7( b_skipped, b_save_restored )
{
    level utility::flag_wait( "completed_ww_step_2" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0xbe0a35f7, Offset: 0x16f6
// Size: 0x92
function function_cbc504a769bb394a( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level thread wait_maneki_neko_ready();
        level utility::flag_set( "collect_figurine" );
        level utility::flag_set( "collect_karakuri" );
        level utility::flag_set( "collect_furin" );
        level utility::flag_set( "crafted_maneki" );
        level utility::flag_set( "maneki_acquired" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            function_ecc91637c2a6fbb1();
        }
    }
    
    level utility::flag_set( "completed_ww_step_2" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x772783e2, Offset: 0x1790
// Size: 0x22
function function_b6562d5032f3d674( b_skipped, b_save_restored )
{
    level utility::flag_wait( "completed_ww_step_3" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0xeb27fba9, Offset: 0x17ba
// Size: 0x92
function function_cbc505a769bb3b7d( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "ash_start" );
        level utility::flag_set( "ash_end" );
        level utility::flag_set( "prints_revealed" );
        level utility::flag_set( "maneki_lured" );
        level utility::flag_set( "lava_molten" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            function_ecc91637c2a6fbb1();
        }
        
        level thread abom_restore();
    }
    
    level utility::flag_set( "completed_ww_step_3" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x4589447e, Offset: 0x1854
// Size: 0x30
function function_b6562c5032f3d441( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread abom_battle();
    }
    
    level utility::flag_wait( "completed_ww_step_4" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x3287a00e, Offset: 0x188c
// Size: 0x63
function function_cbc4fea769bb2c18( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "abom_defeated" );
        level utility::flag_set( "nekomata_sleeping" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            function_ecc91637c2a6fbb1();
        }
    }
    
    level utility::flag_set( "completed_ww_step_4" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0xb7b8859, Offset: 0x18f7
// Size: 0x5b
function function_b6562b5032f3d20e( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread restore_nekomata_sleep();
    }
    else if ( !b_save_restored && isdefined( level.players[ 0 ] ) )
    {
        level.players[ 0 ] thread function_de6cc82acf1fe6ac();
    }
    
    level utility::flag_wait( "completed_ww_step_5" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x642ef0d1, Offset: 0x195a
// Size: 0x7d
function function_cbc4ffa769bb2e4b( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "locate_nekomata" );
        level utility::flag_set( "capture_nekomata" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            function_ecc91637c2a6fbb1();
        }
    }
    
    if ( b_save_restored )
    {
        level thread function_b24c44d67d8f8597();
    }
    
    level utility::flag_clear( "block_ar" );
    level utility::flag_set( "completed_ww_step_5" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x772783e2, Offset: 0x19df
// Size: 0x22
function function_b6562a5032f3cfdb( b_skipped, b_save_restored )
{
    level utility::flag_wait( "completed_ww_step_6" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0xccec7fed, Offset: 0x1a09
// Size: 0xf4
function function_cbc500a769bb307e( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "feed_nekomata" );
        level utility::flag_set( "save_nekomata" );
        level utility::flag_set( "nekomata_acquired" );
        
        if ( isdefined( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f ) )
        {
            level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f delete();
        }
        
        if ( isdefined( level.ww_neko.sc_neko ) )
        {
            level.ww_neko.sc_neko freescriptable();
        }
        
        if ( !b_save_restored )
        {
            if ( isdefined( level.players[ 0 ] ) )
            {
                level.players[ 0 ] thread function_f384ed0aee9245af();
            }
        }
    }
    
    level utility::flag_clear( "block_ar" );
    level utility::flag_set( "completed_ww_step_6" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xef830d2e, Offset: 0x1b05
// Size: 0x66d
function function_ecc91637c2a6fbb1()
{
    if ( !level utility::flag( "completed_pap_step_7" ) )
    {
        return;
    }
    
    if ( level utility::flag( "completed_ww_step_6" ) )
    {
        return;
    }
    
    if ( level utility::flag( "ar_active" ) )
    {
        return;
    }
    
    if ( !level utility::flag( "phd_flop" ) )
    {
        s_cage = utility::getstruct( "cage_post" );
        level thread zm_quest::update_guidance( [ [ s_cage, 48 ] ], #"hash_2801da15b5dfd6cf", #"cage_flop" );
        return;
    }
    
    if ( !level utility::flag( "pickup_cage" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.ww_neko.var_3d521e9563c257ae, 48 ] ], #"hash_2801da15b5dfd6cf", #"pickup_cage" );
        return;
    }
    
    if ( !level utility::flag( "drop_cage" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.s_drop_cage, 140 ] ], #"hash_2801da15b5dfd6cf", #"drop_cage" );
        return;
    }
    
    if ( !level utility::flag( "collect_figurine" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.ww_neko.mdl_figurine, 16 ] ], #"hash_2801da15b5dfd6cf", #"collect_figurine" );
        return;
    }
    
    if ( !level utility::flag( "collect_furin" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.ww_neko.mdl_furin, 16 ] ], #"hash_2801da15b5dfd6cf", #"collect_furin" );
        return;
    }
    
    if ( !level utility::flag( "collect_karakuri" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.ww_neko.mdl_karakuri, 24 ] ], #"hash_2801da15b5dfd6cf", #"collect_karakuri" );
        return;
    }
    
    if ( !level utility::flag( "crafted_maneki" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.ww_neko.mdl_table.interact, 16 ] ], #"hash_2801da15b5dfd6cf", #"craft_maneki" );
        return;
    }
    
    if ( !level utility::flag( "maneki_acquired" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.ww_neko.mdl_table.interact, 16 ] ], #"hash_2801da15b5dfd6cf", #"pickup_maneki" );
        return;
    }
    
    if ( !level utility::flag( "ash_start" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_ww_quest.s_print_marker ] ], #"hash_2801da15b5dfd6cf", #"hash_d05db07a69976dba" );
        return;
    }
    
    if ( !level utility::flag( "ash_end" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_ww_quest.s_print_marker ] ], #"hash_2801da15b5dfd6cf", #"hash_4d0927b63f73e12f" );
        return;
    }
    
    if ( !level utility::flag( "prints_revealed" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_ww_quest.s_print_marker ], [ level.hornet_ww_quest.s_print_marker, 0, level.var_e3c8731c458d8627 ] ], #"hash_2801da15b5dfd6cf", #"reveal_prints" );
        return;
    }
    
    if ( !level utility::flag( "lava_molten" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_ww_quest.s_print_end, 16 ] ], #"hash_2801da15b5dfd6cf", #"wait_lava" );
        return;
    }
    
    if ( !level utility::flag( "maneki_lured" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_ww_quest.s_print_end, 16 ] ], #"hash_2801da15b5dfd6cf", #"lure_maneki" );
        return;
    }
    
    if ( !level utility::flag( "abom_defeated" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.var_8b20e2541cec4ff6, 82 ] ], #"hash_2801da15b5dfd6cf", #"defeat_abom" );
        return;
    }
    
    if ( !level utility::flag( "nekomata_sleeping" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"hash_2801da15b5dfd6cf", #"nekomata_wait" );
        return;
    }
    
    if ( !level utility::flag( "capture_nekomata" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f, 16 ] ], #"hash_2801da15b5dfd6cf", #"capture_nekomata" );
        return;
    }
    
    if ( !level utility::flag( "feed_nekomata" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.hornet_pap_quest.sc_seed, 28 ] ], #"hash_2801da15b5dfd6cf", #"feed_nekomata" );
        return;
    }
    
    if ( !level utility::flag( "save_nekomata" ) )
    {
        level zm_quest::function_9f49b2a045ece8ae( level.hornet_pap_quest.sc_seed.n_hits, 1, #"hash_2801da15b5dfd6cf", #"save_nekomata" );
        level thread zm_quest::update_guidance( [ [ level.hornet_pap_quest.sc_seed, 28 ] ], #"hash_2801da15b5dfd6cf", #"save_nekomata" );
        return;
    }
    
    if ( !level utility::flag( "nekomata_acquired" ) )
    {
        level thread zm_quest::update_guidance( [ [ level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f, 28 ] ], #"hash_2801da15b5dfd6cf", #"ww_acquired" );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x1be5a63d, Offset: 0x217a
// Size: 0xcb
function setup_lava_triggers()
{
    level.var_2893957a6bc9f49b = utility::getstructarray( "lf_parent", "targetname" );
    level.var_2893957a6bc9f49b[ level.var_2893957a6bc9f49b.size ] = utility::getstruct( "border_lv" );
    
    foreach ( s_lava in level.var_2893957a6bc9f49b )
    {
        s_lava.trigger = getent( s_lava.target, "targetname" );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x535f1010, Offset: 0x224d
// Size: 0x186
function setup_swim()
{
    level endon( #"completed_pap_step_6" );
    a_s_cats = utility::getstructarray( "cat_swim" );
    var_2893957a6bc9f49b = utility::getstructarray( "lf_parent", "targetname" );
    
    foreach ( s_cat in a_s_cats )
    {
        foreach ( s_lava in var_2893957a6bc9f49b )
        {
            if ( s_cat.script_noteworthy == s_lava.script_noteworthy )
            {
                s_cat.s_lava = s_lava;
            }
        }
    }
    
    while ( !level utility::flag( "completed_pap_step_6" ) )
    {
        a_s_cats = arrayrandomize( a_s_cats );
        
        for ( i = 0; i < a_s_cats.size ; i++ )
        {
            a_s_cats[ i ] nekomata_swim();
            wait randomfloatrange( 5, 8 );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x3c867229, Offset: 0x23db
// Size: 0x27b
function nekomata_swim()
{
    self endon( #"lava_cooled" );
    
    if ( self.var_1705bbee73a2ffec )
    {
        return;
    }
    
    thread function_9e947c17653369ee();
    thread function_ce4d410edaac8e6f();
    self.sc_neko = spawnscriptable( %"zm_sat_hornet_ww_cat", self.origin, self.angles );
    self.sc_wake = spawnscriptable( %"zm_sat_hornet_ww_vfx", self.origin, self.angles );
    waitframe();
    self.sc_neko setscriptablepartstate( "visual", "run" );
    self.sc_wake setscriptablepartstate( "visual", "lava_wake" );
    waitframe();
    self.var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", self.origin, self.angles );
    self.e_wake = utility::spawn_model( "tag_origin", self.origin, self.angles );
    waitframe();
    self.sc_neko scriptablesetparententity( self.var_2b0c20cebe23ba0b );
    waitframe();
    self.sc_wake scriptablesetparententity( self.e_wake, ( 0, 0, 10 ) );
    waitframe();
    self.e_wake linkto( self.var_2b0c20cebe23ba0b );
    waitframe();
    n_speed = 35;
    var_be17fae8e83d6e7b = utility::getstruct( self.target );
    
    while ( true )
    {
        var_b6081b1b6ba5e8b5 = distance2d( self.var_2b0c20cebe23ba0b.origin, var_be17fae8e83d6e7b.origin );
        n_time = var_b6081b1b6ba5e8b5 / n_speed;
        self.var_2b0c20cebe23ba0b moveto( var_be17fae8e83d6e7b.origin, n_time );
        self.var_2b0c20cebe23ba0b rotateto( var_be17fae8e83d6e7b.angles, n_time * 0.2 );
        self.var_2b0c20cebe23ba0b waittill( #"movedone" );
        
        if ( isdefined( var_be17fae8e83d6e7b.target ) )
        {
            var_be17fae8e83d6e7b = utility::getstruct( var_be17fae8e83d6e7b.target );
            continue;
        }
        
        function_a0565bbc8222f23f( self.sc_neko );
        function_a0565bbc8222f23f( self.sc_wake );
        function_a0565bbc8222f23f( self.e_wake );
        function_a0565bbc8222f23f( self.var_2b0c20cebe23ba0b );
        self notify( #"swim_done" );
        break;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xe192f690, Offset: 0x265e
// Size: 0xc4
function function_9e947c17653369ee()
{
    self endon( #"swim_done" );
    
    while ( true )
    {
        if ( self.s_lava.iscooled && isdefined( self ) )
        {
            self notify( #"lava_cooled" );
            
            if ( isdefined( self.var_2b0c20cebe23ba0b ) )
            {
                self.var_2b0c20cebe23ba0b movez( -100, 1 );
                self.var_2b0c20cebe23ba0b waittill( #"movedone" );
            }
            
            function_a0565bbc8222f23f( self.sc_neko );
            function_a0565bbc8222f23f( self.sc_wake );
            function_a0565bbc8222f23f( self.e_wake );
            function_a0565bbc8222f23f( self.var_2b0c20cebe23ba0b );
            self notify( #"swim_done" );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xdc690faf, Offset: 0x272a
// Size: 0x9e
function function_ce4d410edaac8e6f()
{
    self endon( #"swim_done" );
    level utility::flag_wait( "completed_pap_step_6" );
    
    if ( isdefined( self.var_2b0c20cebe23ba0b ) )
    {
        self.var_2b0c20cebe23ba0b movez( -100, 1 );
        self.var_2b0c20cebe23ba0b waittill( #"movedone" );
    }
    
    function_a0565bbc8222f23f( self.sc_neko );
    function_a0565bbc8222f23f( self.sc_wake );
    function_a0565bbc8222f23f( self.e_wake );
    function_a0565bbc8222f23f( self.var_2b0c20cebe23ba0b );
    self notify( #"swim_done" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xd94bc604, Offset: 0x27d0
// Size: 0x91
function setup_cage_assets()
{
    level.ww_neko.has_cage = 0;
    s_cage = utility::getstruct( "cage_post" );
    s_cage.s_groundpos = utility::getstruct( s_cage.target );
    level.ww_neko.var_3d521e9563c257ae = utility::spawn_model( %"hash_53ee6403eb6c17d2", s_cage.origin, s_cage.angles );
    level utility::flag_set( "cage_ready" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xf36752, Offset: 0x2869
// Size: 0x15b
function nekomata_setup()
{
    if ( isdefined( level.ww_neko.sc_neko ) )
    {
        level.ww_neko.sc_neko freescriptable();
    }
    
    s_neko = utility::getstruct( "wilson" );
    level.ww_neko.sc_neko = spawnscriptable( %"zm_sat_hornet_ww_cat", s_neko.origin, s_neko.angles );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f = utility::spawn_model( "tag_origin", s_neko.origin, s_neko.angles );
    level.ww_neko.sc_neko utility::scriptable_setparententity( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f, ( 0, 0, 0 ), ( 0, 90, 0 ) );
    
    if ( isdefined( level.ww_neko.var_3d521e9563c257ae ) )
    {
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f linkto( level.ww_neko.var_3d521e9563c257ae );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x78588588, Offset: 0x29cc
// Size: 0x166
function function_3806b8f9be349f5f()
{
    level utility::flag_wait( "power_on" );
    level utility::flag_wait( "cage_ready" );
    nekomata_setup();
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "sit_cage" );
    s_hanger = utility::getstruct( "cage_hanger" );
    mdl_hanger = spawn( "script_model", s_hanger.origin );
    mdl_hanger setscale( 3 );
    mdl_hanger setmodel( "t10_vfx_debris_tools_nail_01" );
    mdl_hanger.angles = s_hanger.angles;
    s_linkto = utility::getstruct( "cage_linkto" );
    level.ww_neko.var_3d521e9563c257ae.var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", s_linkto.origin, s_linkto.angles );
    level.ww_neko.var_3d521e9563c257ae linkto( level.ww_neko.var_3d521e9563c257ae.var_2b0c20cebe23ba0b );
    waitframe();
    level.ww_neko.var_3d521e9563c257ae.var_2b0c20cebe23ba0b thread cage_sway();
    level utility::flag_set( "cage_setup" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xc7a1f56a, Offset: 0x2b3a
// Size: 0x7a
function cage_sway()
{
    level endon( #"phd_flop" );
    
    for ( n_count = 0; true ; n_count = 0 )
    {
        self rotateroll( 10, 0.6, 0.2, 0.1 );
        wait 0.55;
        self rotateroll( -10, 0.6, 0.2, 0.1 );
        wait 0.55;
        n_count++;
        
        if ( n_count == 2 )
        {
            self playsound( #"hash_6ee5567d84214805" );
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x2f87cb96, Offset: 0x2bbc
// Size: 0xb1
function function_e50bcdcd85f38cc1( params )
{
    if ( isdefined( level.ww_neko.var_3d521e9563c257ae ) && distance2dsquared( self.origin, level.ww_neko.var_3d521e9563c257ae.origin ) <= 90000 && !level utility::flag( "phd_flop" ) && self.origin[ 2 ] < level.ww_neko.var_3d521e9563c257ae.origin[ 2 ] - 8 )
    {
        level utility::flag_set( "phd_flop" );
        level thread function_87e39a3b40cac997();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xa5851608, Offset: 0x2c75
// Size: 0x1ed
function function_87e39a3b40cac997()
{
    s_cage = utility::getstruct( "cage_post" );
    s_cage.s_groundpos = utility::getstruct( s_cage.target );
    level.ww_neko.var_3d521e9563c257ae utility::function_32b24db3127bff40( "visual", "break" );
    level.ww_neko.var_3d521e9563c257ae unlink();
    waitframe();
    level thread function_ab01fabe4eec582a( s_cage.s_groundpos.origin );
    level.ww_neko.var_3d521e9563c257ae rotateto( s_cage.s_groundpos.angles, 0.8, 0.2 );
    level.ww_neko.var_3d521e9563c257ae moveto( s_cage.s_groundpos.origin, 0.8, 0.2 );
    level.ww_neko.var_3d521e9563c257ae waittill( #"movedone" );
    level.ww_neko.var_3d521e9563c257ae.var_2b0c20cebe23ba0b delete();
    level.ww_neko.var_3d521e9563c257ae playsound( #"hash_3f8ca544a98b706f" );
    level.ww_neko.var_3d521e9563c257ae utility::function_32b24db3127bff40( "visual", "impact" );
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "stand_cage" );
    wait 1;
    level.ww_neko.var_3d521e9563c257ae cage_create_interact();
    wait 0.5;
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x38dc2d8e, Offset: 0x2e6a
// Size: 0xc1
function function_ab01fabe4eec582a( v_pos )
{
    wait 0.75;
    var_91cffc440e2463e = utility::getstructarray( "cage_repos" );
    a_players = getplayersinradius( v_pos, 60 );
    
    foreach ( player in a_players )
    {
        if ( isdefined( player ) )
        {
            player setorigin( var_91cffc440e2463e[ player getentitynumber() ].origin );
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x402962eb, Offset: 0x2f33
// Size: 0x69
function cage_create_interact()
{
    self.interact = interaction::register_interact( self.origin + ( 0, 0, 64 ), 64, &function_b24eae0a617c968, undefined, undefined, undefined, 1, undefined, 1 );
    self.interact interaction::set_interact_hint_callback( &cage_hint );
    self.interact linkto( self );
    self.interact setuseprioritymax();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x30d557a5, Offset: 0x2fa4
// Size: 0x165
function function_b24eae0a617c968( player )
{
    if ( player.interactions_disabled || level.ww_neko.has_cage || !player can_pick_up_cage() )
    {
        return;
    }
    
    playsoundatpos( player.origin, #"hash_23b067d32c0b32ae" );
    player thread cage_carry();
    level.ww_neko.has_cage = 1;
    level utility::flag_set( "pickup_cage" );
    
    if ( !level.var_777969319d8b23e0 )
    {
        level.var_777969319d8b23e0 = 1;
        level thread function_3e09828e57f63911( player );
    }
    
    a_s_drops = utility::getstructarray( "print_leap" );
    
    foreach ( s_drop in a_s_drops )
    {
        if ( s_drop.script_noteworthy == "se" )
        {
            level.s_drop_cage = s_drop;
        }
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x1293a381, Offset: 0x3111
// Size: 0x9e
function private cage_hint( usable, player )
{
    if ( player.interactions_disabled || level.ww_neko.has_cage || !player can_pick_up_cage() )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_6a266154975d873e", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xbe33b459, Offset: 0x31b8
// Size: 0x67, Type: bool
function can_pick_up_cage()
{
    if ( self.origin[ 2 ] > level.ww_neko.var_3d521e9563c257ae.origin[ 2 ] + 16 || self isjumping() || self issprinting() || self issprintsliding() || weapon::iskillstreakweapon( self.currentweapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x8572c8bb, Offset: 0x3228
// Size: 0x10b
function cage_carry()
{
    self.has_cage = 1;
    cage_carry_vals( 0 );
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "hidden" );
    function_1fd23cb175a9dab9( 1 );
    level.ww_neko.var_3d521e9563c257ae delete();
    
    if ( isdefined( level.ww_neko.var_3d521e9563c257ae.interact ) )
    {
        level.ww_neko.var_3d521e9563c257ae.interact delete();
    }
    
    self playrumbleonentity( "damage_heavy" );
    self notifyonplayercommand( "drop_cage_input", "+stance" );
    self notifyonplayercommand( "drop_cage_input", "+prone" );
    self notifyonplayercommand( "drop_cage_input", "+movedown" );
    self setclientomnvar( "ui_hud_carried_item_index", 8 );
    self setclientomnvar( "ui_hud_carried_item_count", 1 );
    self setstance( "stand" );
    thread function_db342e77c894c481();
    thread function_d182a31e2e4851b1();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xea0023e0, Offset: 0x333b
// Size: 0xde
function cage_carry_vals( var_b0e144194be51c26 )
{
    val::set( "cage_carry", "crouch", var_b0e144194be51c26 );
    val::set( "cage_carry", "gesture", var_b0e144194be51c26 );
    val::set( "cage_carry", "interactions", var_b0e144194be51c26 );
    val::set( "cage_carry", "allow_jump", var_b0e144194be51c26 );
    val::set( "cage_carry", "killstreaks", var_b0e144194be51c26 );
    val::set( "cage_carry", "melee", var_b0e144194be51c26 );
    val::set( "cage_carry", "prone", var_b0e144194be51c26 );
    val::set( "cage_carry", "sprint", var_b0e144194be51c26 );
    val::set( "cage_carry", "fire", var_b0e144194be51c26 );
    val::set( "cage_carry", "allow_scripted_bgb_use", var_b0e144194be51c26 );
    
    if ( var_b0e144194be51c26 )
    {
        self enableoffhandweapons();
        return;
    }
    
    self disableoffhandweapons();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x886b5fd7, Offset: 0x3421
// Size: 0x159
function function_1fd23cb175a9dab9( var_6a8390f12c65981d )
{
    self endon( #"death" );
    
    if ( var_6a8390f12c65981d )
    {
        zm_utility::function_d47920bb0d5fa327( "hornet_wwquest_cageswitch" );
        zm_utility::function_92275a9d3969d91d();
        supers_mp::clearsuper( 1, undefined, undefined, undefined, 1 );
        weapon = weapon_utility::function_d2c8356dc369d9ce( "sat_cat_cage_zm" );
        self giveweapon( weapon );
        self switchtoweapon( weapon );
        self.hornet_weapon_obj = self.old_weapon_obj;
        self.var_51f00190b08c44e0 = self.a_saved_weapons;
        return;
    }
    
    if ( !self.inlaststand )
    {
        self giveweapon( level.defaultfist, undefined, 0, 0, 1, 1 );
        self switchtoweaponimmediate( level.defaultfist );
        utility::waittill_any_timeout( 1, "weapon_change" );
        waitframe();
        
        if ( isweapon( self.currentweapon ) && !isnullweapon( self.currentweapon ) )
        {
            self forceplaygestureviewmodel( "t10_ges_offhand_1h_steerable_knife_toss" );
        }
        
        waitframe();
        self takeweapon( level.defaultfist );
    }
    else
    {
        self waittill( #"last_stand_finished" );
        self.old_weapon_obj = self.hornet_weapon_obj;
        self.a_saved_weapons = self.var_51f00190b08c44e0;
        self.hornet_weapon_obj = undefined;
        self.var_51f00190b08c44e0 = undefined;
    }
    
    zm_utility::function_663d59490abc834f();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x785d8626, Offset: 0x3582
// Size: 0xdc
function cage_drop( var_ba277e7621e74713 = 1 )
{
    self endon( #"death" );
    v_pos = self.origin;
    v_ang = self.angles;
    level.ww_neko.has_cage = 0;
    
    if ( var_ba277e7621e74713 )
    {
        self.has_cage = undefined;
        thread function_1fd23cb175a9dab9( 0 );
        self notifyonplayercommandremove( "drop_cage_input", "+stance" );
        self notifyonplayercommandremove( "drop_cage_input", "+prone" );
        self notifyonplayercommandremove( "drop_cage_input", "+movedown" );
        self setclientomnvar( "ui_hud_carried_item_index", 8 );
        self setclientomnvar( "ui_hud_carried_item_count", 0 );
        thread function_65bee0d289ac4437();
    }
    
    if ( isdefined( v_pos ) && isdefined( v_ang ) )
    {
        level thread cage_land( v_pos, v_ang );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0xe01cade8, Offset: 0x3666
// Size: 0x53f
function cage_land( v_pos, v_ang )
{
    v_forward_pos = vectornormalize( anglestoforward( v_ang ) ) * 100 + v_pos;
    v_start = v_pos + ( 0, 0, 48 );
    v_forward_pos += ( 0, 0, 48 );
    a_zombies = getaiarrayinradius( v_forward_pos, 250, "team_two_hundred" );
    results = trace::ray_trace( v_start, v_forward_pos, a_zombies, undefined, 1 );
    
    if ( isdefined( results[ "position" ] ) && isdefined( results[ "surfacetype" ] ) && trace::ray_trace_passed( v_start, results[ "position" ] ) )
    {
        if ( distance2dsquared( results[ "position" ], v_pos ) >= distance2dsquared( v_forward_pos, v_pos ) && results[ "surfacetype" ] == "surftype_none" )
        {
            v_ground_pos = utility::function_5918594658d3ffba( v_forward_pos, 40 );
            
            if ( isdefined( v_ground_pos ) )
            {
                v_ground_pos = utility::drop_to_ground( v_ground_pos, 40 );
            }
        }
    }
    
    v_start = vectornormalize( anglestoright( v_ang ) ) * 8 + v_pos + ( 0, 0, 48 );
    
    if ( function_eebc26d3ebcc3852( v_ground_pos ) && isdefined( v_ground_pos ) )
    {
        if ( v_ground_pos[ 2 ] > v_pos[ 2 ] + 80 )
        {
            var_5c7cebcd003936e0 = find_spawn_location( v_pos, v_forward_pos, 32 );
        }
        else
        {
            var_5c7cebcd003936e0 = v_ground_pos;
        }
    }
    else
    {
        var_5c7cebcd003936e0 = find_spawn_location( v_pos, v_forward_pos, 32 );
    }
    
    waitframe();
    
    if ( isdefined( var_5c7cebcd003936e0 ) )
    {
        level.ww_neko.var_3d521e9563c257ae = utility::spawn_model( %"hash_53ee6403eb6c17d2", v_start, v_ang + ( 0, 90, 0 ) );
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin = level.ww_neko.var_3d521e9563c257ae.origin + ( 0, 0, 5.5 );
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.angles = level.ww_neko.var_3d521e9563c257ae.angles + ( 0, 180, 0 );
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f linkto( level.ww_neko.var_3d521e9563c257ae );
        level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "sit_cage" );
        control_pt = ( v_start + var_5c7cebcd003936e0 ) / 2 + ( 0, 0, 50 );
        level.ww_neko.var_3d521e9563c257ae thread utility::function_8001268940441423( v_start, var_5c7cebcd003936e0, control_pt, 0.5, undefined, 1 );
        level.ww_neko.var_3d521e9563c257ae thread function_f502842f07d8daf8();
        level.ww_neko.var_3d521e9563c257ae utility::waittill_any_timeout( 0.6, "off_bezier_curve" );
        waitframe();
        level.ww_neko.var_3d521e9563c257ae solid();
        
        foreach ( s_lava_flow in level.var_2893957a6bc9f49b )
        {
            if ( isdefined( level.ww_neko.var_3d521e9563c257ae ) && level.ww_neko.var_3d521e9563c257ae istouching( s_lava_flow.trigger ) )
            {
                if ( !s_lava_flow.iscooled )
                {
                    if ( isdefined( s_lava_flow.trigger.name ) )
                    {
                        if ( s_lava_flow.trigger.name == "damage_trig_westbailey" )
                        {
                            var_321ab01b0a71c1e8 = 10;
                        }
                        else if ( s_lava_flow.trigger.name == "damage_trig_secondbailey" )
                        {
                            var_321ab01b0a71c1e8 = 2;
                        }
                        else
                        {
                            var_321ab01b0a71c1e8 = 4;
                        }
                    }
                    else
                    {
                        var_321ab01b0a71c1e8 = 4;
                    }
                    
                    level.ww_neko.var_3d521e9563c257ae movez( var_321ab01b0a71c1e8, 0.05 );
                    level.ww_neko.var_3d521e9563c257ae rotateroll( 15, 0.05 );
                    level.ww_neko.var_3d521e9563c257ae waittill( #"movedone" );
                    level.ww_neko.var_3d521e9563c257ae cage_place( v_pos, v_ang, 1, var_321ab01b0a71c1e8 );
                    return;
                }
            }
        }
        
        if ( !level utility::flag( "drop_cage" ) && isdefined( level.ww_neko.var_3d521e9563c257ae ) )
        {
            level.ww_neko.var_3d521e9563c257ae cage_place( v_pos, v_ang, 0, var_321ab01b0a71c1e8 );
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x4ea3a8f4, Offset: 0x3bad
// Size: 0x6f
function function_cf8a5b7d6fbcc3d2( var_5fb4fe43f49ba675, t_lava )
{
    v_up = var_5fb4fe43f49ba675 + ( var_5fb4fe43f49ba675[ 0 ], var_5fb4fe43f49ba675[ 1 ], var_5fb4fe43f49ba675[ 2 ] + 20 );
    
    for ( i = 0; i < 20 ; i++ )
    {
        v_up += ( v_up[ 0 ], v_up[ 1 ], v_up[ 2 ] - i );
        
        if ( ispointinvolume( v_up, t_lava ) )
        {
            return v_up;
        }
    }
    
    return var_5fb4fe43f49ba675;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xc735cc30, Offset: 0x3c25
// Size: 0xbb
function function_f502842f07d8daf8()
{
    self endon( #"off_bezier_curve", #"death" );
    
    while ( true )
    {
        a_zombies = getaiarrayinradius( self.origin, 50, "team_two_hundred" );
        
        for ( i = 0; i < a_zombies.size ; i++ )
        {
            if ( !isdefined( a_zombies[ i ].var_cbf08e4c1cdd8f47 ) && isdefined( a_zombies[ i ] ) )
            {
                a_zombies[ i ].var_cbf08e4c1cdd8f47 = 1;
                a_zombies[ i ] dodamage( 15, self.origin, self );
                a_zombies[ i ] thread zombie_knockdown::function_6fc167d4a3590991( self.origin );
                a_zombies[ i ] thread function_3c9de0b735fe260e();
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xcfb7ed64, Offset: 0x3ce8
// Size: 0x1e
function function_3c9de0b735fe260e()
{
    self endon( #"death" );
    wait 1;
    self.var_cbf08e4c1cdd8f47 = undefined;
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xa7b4cdb1, Offset: 0x3d0e
// Size: 0x14
function function_eebc26d3ebcc3852( v_pos )
{
    return zone_manager::function_65305a611c6226d9( v_pos );
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x5a0d9082, Offset: 0x3d2b
// Size: 0x187
function get_ground_angle( v_pos )
{
    level.ww_neko.var_3d521e9563c257ae.angles = ( 0, 0, 0 );
    var_49d8c523e3e822b5 = vectornormalize( anglestoforward( level.ww_neko.var_3d521e9563c257ae.angles ) ) * 7 + level.ww_neko.var_3d521e9563c257ae.origin;
    v_right_pos = vectornormalize( anglestoright( level.ww_neko.var_3d521e9563c257ae.angles ) ) * 10 + level.ww_neko.var_3d521e9563c257ae.origin;
    var_9860c5ddeb8fe37 = utility::groundpos( var_49d8c523e3e822b5 );
    v_right_ground_pos = utility::groundpos( v_right_pos );
    utility::spawn_model( %"hash_14a43cd5aa21998c", var_9860c5ddeb8fe37, level.ww_neko.var_3d521e9563c257ae.angles );
    utility::spawn_model( %"hash_14a43cd5aa21998c", v_right_ground_pos, level.ww_neko.var_3d521e9563c257ae.angles );
    v_ang_1 = calculate_drop_angle( v_pos, var_49d8c523e3e822b5 );
    v_ang_2 = calculate_drop_angle( v_pos, v_right_pos );
    return ( v_ang_1, 0, v_ang_2 );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0xc0f0ba8a, Offset: 0x3ebb
// Size: 0x8f
function calculate_drop_angle( v_pos, v_cage )
{
    var_dc0b08bf265f7d84 = v_pos - ( v_cage[ 0 ], v_cage[ 1 ], v_pos[ 2 ] );
    v_delta = v_pos - v_cage;
    var_4df7db8d01e4372c = vectordot( var_dc0b08bf265f7d84, v_delta );
    n_len_1 = length( var_dc0b08bf265f7d84 );
    n_len_2 = length( v_delta );
    v_ang = acos( var_4df7db8d01e4372c / abs( n_len_1 ) * abs( n_len_2 ) );
    return v_ang;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xf8ebeb19, Offset: 0x3f53
// Size: 0x24
function function_65bee0d289ac4437()
{
    self endon( #"death" );
    
    while ( self stancebuttonpressed() )
    {
        waitframe();
    }
    
    waitframe();
    cage_carry_vals( 1 );
}

// Namespace zm_sat_hornet_ww_quest
// Params 4
// Checksum 0x6e51202a, Offset: 0x3f7f
// Size: 0x238
function cage_place( v_pos, v_ang, b_on_lava = 0, var_321ab01b0a71c1e8 )
{
    self notify( #"hash_7bd74c342eb7e90d" );
    self endon( #"hash_7bd74c342eb7e90d" );
    
    if ( b_on_lava )
    {
        v_pos = function_c2aa84d816d1dd8b( v_pos, v_ang, 60 );
        playsoundatpos( self.origin, #"hash_d25a77e1a1810b8e" );
        level utility::flag_set( "pickup_cage" );
        level utility::flag_set( "drop_cage" );
        level utility::flag_set( "completed_ww_step_1" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_round_cap( 10 );
        }
        
        wait 0.5;
        utility::function_32b24db3127bff40( "visual", "sink" );
        self rotatepitch( 25, 1 );
        self movez( -40, 2.5 );
        wait 0.5;
        a_players = getplayersinradius( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin, 1000 );
        
        if ( isdefined( a_players ) && a_players.size )
        {
            player = function_47c86977a18df38b( a_players, level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin );
            
            if ( isdefined( player ) )
            {
                player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw1_place_cage" );
            }
        }
        
        self waittill( #"movedone" );
        v_start = self.origin;
        level thread cage_melt();
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f thread function_f0ece3819a8e3421( v_start, v_pos, var_321ab01b0a71c1e8 );
        zm_quest::clear_all_guidance();
        return;
    }
    
    playsoundatpos( self.origin, #"hash_2fd15d9caf54d90f" );
    cage_create_interact();
    level utility::flag_clear( "pickup_cage" );
    thread function_7401ed30e32f7bd2( v_pos, v_ang );
    thread cage_player_monitor();
    thread function_b6334c7e3c00e6c5();
    wait 0.25;
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xeeb2edd6, Offset: 0x41bf
// Size: 0x27
function function_b6334c7e3c00e6c5()
{
    var_89d17147d5f4aec7 = createnavobstaclebyent( self );
    level utility::flag_wait( "pickup_cage" );
    destroynavobstacle( var_89d17147d5f4aec7 );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x6b5dae96, Offset: 0x41ee
// Size: 0x125
function cage_player_monitor()
{
    level endon( #"pickup_cage", #"drop_cage" );
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( zm_player::function_f37cfdf04b932a03( player ) && player istouching( self ) && player.origin[ 2 ] > self.origin[ 2 ] + 8 )
            {
                var_408e0c7d8bfc99ad = utility::function_8ae0ea62537eafc5( self.origin, 20, 0 );
                v_pos = getclosestpointonnavmesh( var_408e0c7d8bfc99ad );
                
                if ( isdefined( v_pos ) && function_eebc26d3ebcc3852( v_pos ) )
                {
                    if ( isdefined( player ) )
                    {
                        player setorigin( var_408e0c7d8bfc99ad );
                    }
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x4149dbe2, Offset: 0x431b
// Size: 0x10d
function function_7401ed30e32f7bd2( v_pos, v_ang )
{
    level endon( #"pickup_cage", #"sinking", #"drop_cage" );
    var_5fb4fe43f49ba675 = self.origin + ( 0, 0, -20 );
    
    while ( true )
    {
        foreach ( s_lava_flow in level.var_2893957a6bc9f49b )
        {
            if ( ispointinvolume( var_5fb4fe43f49ba675, s_lava_flow.trigger ) )
            {
                if ( !s_lava_flow.iscooled )
                {
                    thread cage_place( v_pos, v_ang, 1 );
                    level notify( #"sinking" );
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xc94559fe, Offset: 0x4430
// Size: 0x7d
function function_db342e77c894c481()
{
    self endon( #"death", #"cage_dropped" );
    
    while ( true )
    {
        self waittill( #"drop_cage_input" );
        
        if ( self isonascender() || !self isonground() || self isonladder() || self isjumping() || self ishighjumping() || self.var_d1c4c78b9fb7d153 )
        {
            continue;
        }
        
        if ( isdefined( self.has_cage ) )
        {
            cage_drop();
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xa8a620d5, Offset: 0x44b5
// Size: 0x87
function cage_melt()
{
    level utility::flag_wait( "cage_ready" );
    wait 0.1;
    
    if ( isdefined( level.ww_neko.var_3d521e9563c257ae.interact ) )
    {
        level.ww_neko.var_3d521e9563c257ae.interact delete();
    }
    
    if ( isdefined( level.ww_neko.var_3d521e9563c257ae ) )
    {
        level.ww_neko.var_3d521e9563c257ae delete();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 3
// Checksum 0x51f10d14, Offset: 0x4544
// Size: 0xc8
function function_f0ece3819a8e3421( v_start, v_pos, var_321ab01b0a71c1e8 )
{
    level.ww_neko.sc_neko endon( #"death" );
    level.ww_neko.sc_neko thread function_732986ffa92a09cc( v_start, v_pos, var_321ab01b0a71c1e8 );
    thread function_9d5b19cafae53641();
    level.ww_neko.sc_neko waittill( #"swim" );
    thread function_1028d182f8975a3c();
    level.ww_neko.sc_neko waittill( #"swim_over" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 3
// Checksum 0x24bbe374, Offset: 0x4614
// Size: 0x350
function function_732986ffa92a09cc( v_start, v_pos, var_321ab01b0a71c1e8 )
{
    self.var_8d21ca07b4ff1b6f unlink();
    waitframe();
    a_s_swim = utility::getstructarray( "swim", "script_label" );
    s_swim = function_47c86977a18df38b( a_s_swim, self.origin );
    n_rise = s_swim.origin[ 2 ] - 4 - v_start[ 2 ];
    v_face = vectortoangles( vectornormalize( v_pos - v_start ) );
    v_face = ( 0, v_face[ 1 ], 0 );
    self.var_8d21ca07b4ff1b6f.angles = v_face;
    self setscriptablepartstate( "visual", "flail" );
    self.var_8d21ca07b4ff1b6f rotatepitch( -60, 0.05 );
    waitframe();
    self.var_8d21ca07b4ff1b6f movez( n_rise, 2 );
    self.var_8d21ca07b4ff1b6f waittill( #"movedone" );
    wait 1;
    self setscriptablepartstate( "visual", "run" );
    self.sc_wake = spawnscriptable( %"zm_sat_hornet_ww_vfx", self.origin, self.angles );
    waitframe();
    self.sc_wake setscriptablepartstate( "visual", "lava_wake" );
    self.sc_wake scriptablesetparententity( self.var_8d21ca07b4ff1b6f, ( 0, 0, 10 ) );
    
    if ( isdefined( s_swim.target ) )
    {
        s_swim = utility::getstruct( s_swim.target );
    }
    else
    {
        self.var_8d21ca07b4ff1b6f movez( n_rise * -1, 1 );
        self.var_8d21ca07b4ff1b6f waittill( #"movedone" );
        self notify( #"swim" );
        function_a0565bbc8222f23f( self.sc_wake );
        self function_da3bdbe814b866ea();
        self notify( #"swim_over" );
        self setscriptablepartstate( "visual", "hidden" );
        return;
    }
    
    n_speed = 50;
    self notify( #"swim" );
    
    while ( true )
    {
        var_b6081b1b6ba5e8b5 = distance2d( self.var_8d21ca07b4ff1b6f.origin, s_swim.origin );
        n_time = var_b6081b1b6ba5e8b5 / n_speed;
        self.var_8d21ca07b4ff1b6f moveto( s_swim.origin, n_time );
        self.var_8d21ca07b4ff1b6f rotateto( s_swim.angles + ( 0, -90, 0 ), n_time * 0.2 );
        self.var_8d21ca07b4ff1b6f waittill( #"movedone" );
        
        if ( isdefined( s_swim.target ) )
        {
            s_swim = utility::getstruct( s_swim.target );
            continue;
        }
        
        function_a0565bbc8222f23f( self.sc_wake );
        self function_da3bdbe814b866ea();
        self.var_8d21ca07b4ff1b6f movez( n_rise * -1, 1 );
        self.var_8d21ca07b4ff1b6f waittill( #"movedone" );
        break;
    }
    
    self notify( #"swim_over" );
    self setscriptablepartstate( "visual", "hidden" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x553de7dc, Offset: 0x496c
// Size: 0xd6
function function_1028d182f8975a3c()
{
    self endon( #"death" );
    level utility::flag_set( "twins_dialogue_playing" );
    dialogue::say( #"hash_e3fd6dc33a74aed", 99, 0, 0, 1.5 );
    wait 1;
    a_players = getplayersinradius( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin, 1000 );
    
    if ( isdefined( a_players ) && a_players.size )
    {
        player = function_47c86977a18df38b( a_players, level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin );
        
        if ( isdefined( player ) )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw1_free_nekomata_response" );
        }
    }
    
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x1e3e3eb7, Offset: 0x4a4a
// Size: 0x20
function function_9d5b19cafae53641()
{
    self endon( #"death" );
    wait 3;
    self playsoundonmovingent( #"hash_616b0c9703c577a4" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x7061c374, Offset: 0x4a72
// Size: 0x1b9
function nekomata_run( v_start, v_end )
{
    self endon( #"run_done" );
    v_offset = ( 0, 0, 0 );
    v_ang = vectortoangles( v_end - v_start + v_offset );
    self setscriptablepartstate( "visual", "run" );
    self.var_8d21ca07b4ff1b6f rotateto( v_ang, 0.25 );
    wait 0.2;
    thread function_b6ad9ae0dacb7772();
    var_5e29f7a2306a2b69 = findpathcustom( v_start, v_end );
    
    for ( i = 1; i < var_5e29f7a2306a2b69.size ; i++ )
    {
        var_b6081b1b6ba5e8b5 = distance2d( var_5e29f7a2306a2b69[ i ], self.var_8d21ca07b4ff1b6f.origin );
        n_time = var_b6081b1b6ba5e8b5 / 120;
        
        if ( n_time <= 0.1 )
        {
            n_time = 0.1;
        }
        
        var_44616205278e62f2 = var_5e29f7a2306a2b69[ i ] + ( 0, 0, 0 );
        n_dist_to_goal = distance2d( var_44616205278e62f2, self.var_8d21ca07b4ff1b6f.origin );
        n_time = n_dist_to_goal / 120;
        
        if ( n_time <= 0.1 )
        {
            n_time = 0.1;
        }
        
        v_ang = vectortoangles( var_44616205278e62f2 - self.var_8d21ca07b4ff1b6f.origin );
        self.var_8d21ca07b4ff1b6f rotateto( v_ang + v_offset, n_time * 0.25 );
        self.var_8d21ca07b4ff1b6f moveto( var_44616205278e62f2, n_time );
        self.var_8d21ca07b4ff1b6f waittill( #"movedone" );
    }
    
    self notify( #"run_done" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xfed0eb46, Offset: 0x4c33
// Size: 0xa2
function nekomata_turn( var_be17fae8e83d6e7b )
{
    self endon( #"run_done", #"turned" );
    v_offset = ( 0, -90, 0 );
    var_e356b6c51eb4ed14 = 20;
    
    while ( true )
    {
        var_b6081b1b6ba5e8b5 = distance2d( self.origin, var_be17fae8e83d6e7b.origin );
        
        if ( var_b6081b1b6ba5e8b5 <= var_e356b6c51eb4ed14 )
        {
            self rotateto( var_be17fae8e83d6e7b.angles + v_offset, 0.2 );
            self notify( #"turned" );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x64bc5175, Offset: 0x4cdd
// Size: 0xfa
function function_b258440d0df12de6()
{
    level utility::flag_wait( "power_on" );
    level utility::flag_wait( "maneki_neko_ready" );
    
    if ( isdefined( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f ) )
    {
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f unlink();
    }
    
    level utility::flag_set( "phd_flop" );
    level utility::flag_set( "pickup_cage" );
    level utility::flag_set( "drop_cage" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
    
    wait 0.5;
    
    if ( isdefined( level.ww_neko.sc_neko ) && !level utility::flag( "nekomata_sleeping" ) )
    {
        level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "hidden" );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x77a7f3a7, Offset: 0x4ddf
// Size: 0x1d4
function setup_maneki_neko()
{
    s_figurine = utility::array_random( utility::getstructarray( "hornet_ww_figurine" ) );
    s_karakuri = utility::array_random( utility::getstructarray( "hornet_ww_karakuri" ) );
    s_furin = utility::array_random( utility::getstructarray( "hornet_ww_furin" ) );
    var_8c6af4441aab050c = utility::getstruct( "hornet_ww_table" );
    s_table_interact = utility::getstruct( "hornet_ww_table_interact" );
    level.hornet_ww_quest.var_8549d09a1a0329da = 0;
    function_1ce0229da9638e05( "figurine", s_figurine.origin, s_figurine.angles );
    function_1ce0229da9638e05( "furin", s_furin.origin, s_furin.angles );
    function_1ce0229da9638e05( "automaton", s_karakuri.origin, s_karakuri.angles );
    level.ww_neko.mdl_table = utility::spawn_model( %"hash_16e88147aa43f786", var_8c6af4441aab050c.origin, var_8c6af4441aab050c.angles );
    level.ww_neko.mdl_table.interact = interaction::register_interact( s_table_interact.origin, 40, &function_7e027038a13d9667, undefined, undefined, undefined, 1, undefined, 1 );
    level.ww_neko.mdl_table.interact interaction::set_interact_hint_callback( &function_12c1b304909f1df3 );
    level.ww_neko.mdl_table.interact.var_b603a7fc89cd1871 = "table";
    level utility::flag_set( "maneki_neko_ready" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 3
// Checksum 0x76808e10, Offset: 0x4fbb
// Size: 0x26e
function function_1ce0229da9638e05( var_b603a7fc89cd1871, v_pos, v_ang )
{
    if ( var_b603a7fc89cd1871 == "figurine" && !zm_quest::function_73720cdf21c3cfd7( #"hornet_ww_quest", #"maneki" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            itembundle = getscriptbundle( %"hash_637da351ef2df62a" );
        }
        else
        {
            itembundle = getscriptbundle( %"hash_451850d90efb6001" );
        }
    }
    else if ( var_b603a7fc89cd1871 == "automaton" && !zm_quest::function_73720cdf21c3cfd7( #"hornet_ww_quest", #"karakuri" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            itembundle = getscriptbundle( %"hash_1f5cdc23acfafabf" );
        }
        else
        {
            itembundle = getscriptbundle( %"hash_7b49677981c2c2c6" );
        }
    }
    else if ( var_b603a7fc89cd1871 == "furin" && !zm_quest::function_73720cdf21c3cfd7( #"hornet_ww_quest", #"furin" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            itembundle = getscriptbundle( %"hash_17e40470096b5427" );
        }
        else
        {
            itembundle = getscriptbundle( %"hash_5665faf5d174afde" );
        }
    }
    
    if ( isdefined( itembundle ) )
    {
        spawnoptions = common_item::function_bc5ff2958b71a708( v_pos, v_ang );
        spawnoptions.critical = 1;
        spawnoptions.var_fd47e835523b473f = 1;
        positioningdata = common_item::function_b4bee4333994e45a( v_pos, v_ang );
        item = common_item::function_2352d25db9e97696( itembundle, 1, positioningdata, spawnoptions );
        
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            item setscriptablepartstate( "zmloot_quest_hornet_ww_" + var_b603a7fc89cd1871 + "_lootcard", "visible_directed" );
        }
        else
        {
            item setscriptablepartstate( "zmloot_quest_hornet_ww_" + var_b603a7fc89cd1871, "visible_standard" );
        }
        
        if ( var_b603a7fc89cd1871 == "figurine" )
        {
            level.ww_neko.mdl_figurine = item;
            return;
        }
        
        if ( var_b603a7fc89cd1871 == "furin" )
        {
            level.ww_neko.mdl_furin = item;
            return;
        }
        
        if ( var_b603a7fc89cd1871 == "automaton" )
        {
            level.ww_neko.mdl_karakuri = item;
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xdc207ac3, Offset: 0x5231
// Size: 0x1c4
function private function_12c1b304909f1df3( usable, player )
{
    if ( player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( usable.var_b603a7fc89cd1871 == "table" )
    {
        if ( !level utility::flag( "collect_figurine" ) || !level utility::flag( "collect_karakuri" ) || !level utility::flag( "collect_furin" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_41cd24dad1975b9", #type:"HINT_NOBUTTON" };
        }
        else if ( !level utility::flag( "crafted_maneki" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_6d97d2f577562163", #type:"HINT_BUTTON" };
        }
        else if ( player weapon::getequipmentammo( "equip_attractor" ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_2c856b65c40a5af", #type:"HINT_NOBUTTON" };
        }
        else if ( level utility::flag( "crafted_maneki" ) && level utility::flag( "maneki_acquired" ) )
        {
            return function_4fea12fd22086dcb( player );
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
        }
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_6a266154975d873e", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xb6ec4d1f, Offset: 0x53fe
// Size: 0x2d6
function private function_7e027038a13d9667( player )
{
    if ( level.hornet_ww_quest.var_8549d09a1a0329da < 3 || level utility::flag( "craft_cooldown" ) || player.interactions_disabled || self.b_interacted )
    {
        return;
    }
    
    if ( !level utility::flag( "crafted_maneki" ) )
    {
        self.b_interacted = 1;
    }
    
    if ( level utility::flag( "nya_needs_crafting" ) )
    {
        player playrumblelooponentity( "low_highfreq" );
        params = { #save_progress:0, #saved_use_object:self, #hud_description:&"hash_13f1ab4a9bad547b", #var_b35caf93a1ae502d:self, #hold_time:5, #craft_reason:#"hash_7a4be9bbf8b8856b" };
        result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
        
        if ( result )
        {
            if ( !level utility::flag( "nya_crafted" ) )
            {
                level utility::flag_set( "nya_crafted" );
                level utility::flag_clear( "nya_needs_crafting" );
            }
            
            maneki_neko_spawn( 1 );
        }
        
        if ( isalive( player ) )
        {
            player stoprumble( "low_highfreq" );
        }
        
        return;
    }
    
    if ( level utility::flag( "crafted_maneki" ) )
    {
        if ( level utility::flag( "maneki_acquired" ) )
        {
            var_bcfe0ed5ba4c9e74 = level.ee_maneki.var_f11ef9f21f5bf1da ?? 500;
            
            if ( player weapon::getequipmentammo( "equip_attractor" ) )
            {
                return;
            }
            else if ( player currency::attempt_purchase( #"salvage", var_bcfe0ed5ba4c9e74, 1, 0, #"custom_maneki_neko" ) )
            {
                item_bundle_name = common_item_database::function_a4f0a21951180013( "equip_attractor" );
                
                if ( isdefined( item_bundle_name ) )
                {
                    player crafting_table::craft_give_equipment( "equip_attractor", "secondary" );
                }
            }
            else
            {
                return;
            }
        }
        
        return;
    }
    
    player playrumblelooponentity( "low_highfreq" );
    params = { #save_progress:1, #saved_use_object:self, #hud_description:&"hash_6cb466194462537b", #var_b35caf93a1ae502d:self, #hold_time:5, #craft_reason:#"ww_quest_key" };
    result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
    
    if ( result )
    {
        if ( !level utility::flag( "crafted_maneki" ) )
        {
            level utility::flag_set( "crafted_maneki" );
        }
        
        maneki_neko_spawn();
        
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            function_ecc91637c2a6fbb1();
        }
        
        self.b_interacted = undefined;
    }
    else
    {
        self.b_interacted = undefined;
    }
    
    if ( isalive( player ) )
    {
        player stoprumble( "low_highfreq" );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x5eaf3909, Offset: 0x56dc
// Size: 0x138
function private function_4fea12fd22086dcb( player )
{
    var_bcfe0ed5ba4c9e74 = level.ee_maneki.var_f11ef9f21f5bf1da ?? 500;
    obj = { #icon:"sat_ui_icon_zm_support_beckoning_cat", #icon_text_value:var_bcfe0ed5ba4c9e74, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_SALVAGE", #description:&"hash_4352b716477963dc", #title:&"hash_756d9a67f7897446", #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #type:"HINT_BUTTON" };
    
    if ( level utility::flag( "craft_cooldown" ) )
    {
        obj.description = &"SHARED_HINTSTRINGS/TRAP_COOLDOWN_HINT";
        obj.interactable = 0;
        return obj;
    }
    
    if ( player currency::can_afford( #"salvage", var_bcfe0ed5ba4c9e74 ) )
    {
        return obj;
    }
    
    obj.description = &"shared_hintstrings/not_enough_salvage";
    obj.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_SALVAGE_NOT_ENOUGH";
    obj.interactable = 0;
    return obj;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x9359ce90, Offset: 0x581c
// Size: 0x1f
function craft_cooldown()
{
    level utility::flag_set( "craft_cooldown" );
    wait 30;
    level utility::flag_clear( "craft_cooldown" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x17e96e55, Offset: 0x5843
// Size: 0x190
function maneki_neko_spawn( b_glow = 0 )
{
    var_c5fb7b9c0ca383b7 = utility::getstruct( "hornet_ww_crafted_item" );
    var_8a61d4195b4b6e64 = getscriptbundle( "itemspawnentry:zm_sat_item_tactical_maneki_neko" );
    spawnoptions = common_item::function_bc5ff2958b71a708( var_c5fb7b9c0ca383b7.origin, var_c5fb7b9c0ca383b7.angles );
    spawnoptions.var_fd47e835523b473f = 1;
    scr_spawn = spawnscriptable( "zm_sat_hornet_ww_vfx", var_c5fb7b9c0ca383b7.origin + ( 0, 0, 2.5 ), var_c5fb7b9c0ca383b7.angles );
    scr_spawn setscriptablepartstate( "visual", "maneki_spawn" );
    waitframe();
    spawned_item = common_item::items_spawnitemfromscriptable( var_8a61d4195b4b6e64.scriptable, undefined, spawnoptions );
    
    if ( b_glow && spawned_item )
    {
        spawned_item setscriptablepartstate( "zmloot_sat_offhand_maneki_neko", "glow" );
    }
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_hornet_artifact_2" );
    }
    
    wait 0.5;
    scr_spawn freescriptable();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xb48885d, Offset: 0x59db
// Size: 0x3b
function function_9a4d0ba32b118c59( player )
{
    level thread craft_cooldown();
    player crafting_table::craft_give_equipment( "equip_attractor", "secondary" );
    self.mdl_equip delete();
    self delete();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x24ea10ef, Offset: 0x5a1e
// Size: 0x2d4
function private function_4fdaa33c0b4032c1( params )
{
    if ( !issubstr( params.itembundle.ref, "sat_zm_quest_hornet_figurine" ) && !issubstr( params.itembundle.ref, "sat_zm_quest_hornet_automaton" ) && !issubstr( params.itembundle.ref, "sat_zm_quest_hornet_furin" ) )
    {
        return;
    }
    
    if ( issubstr( params.itembundle.ref, "sat_zm_quest_hornet_figurine" ) )
    {
        playsoundatpos( params.item.origin, #"hash_7c3ae67b64a3660b" );
        level utility::flag_set( "collect_figurine" );
        level.hornet_ww_quest.var_8549d09a1a0329da++;
        zm_quest::function_b57dfe9625966b0b( #"wwq", 0, #"hash_e1881bd4bcbeb80e", 1 );
        zm_quest::show_splash_item_picked_up( #"wwq", #"hash_e1881bd4bcbeb80e", 1, self );
        wait 0.5;
        thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw1_pick_up_figurine", #"bc_flavor_player_positive" );
    }
    else if ( issubstr( params.itembundle.ref, "sat_zm_quest_hornet_automaton" ) )
    {
        playsoundatpos( params.item.origin, #"hash_840ba21156acedb2" );
        level utility::flag_set( "collect_karakuri" );
        level.hornet_ww_quest.var_8549d09a1a0329da++;
        zm_quest::function_b57dfe9625966b0b( #"wwq", 0, #"hash_cb32d9e98e43f5d", 1 );
        zm_quest::show_splash_item_picked_up( #"wwq", #"hash_cb32d9e98e43f5d", 1, self );
        wait 0.5;
        thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw1_pick_up_karakuri", #"bc_flavor_player_positive" );
    }
    else if ( issubstr( params.itembundle.ref, "sat_zm_quest_hornet_furin" ) )
    {
        playsoundatpos( params.item.origin, #"hash_e528099dee66e64e" );
        level utility::flag_set( "collect_furin" );
        level.hornet_ww_quest.var_8549d09a1a0329da++;
        zm_quest::function_b57dfe9625966b0b( #"wwq", 0, #"hash_41929f3ebd40a391", 1 );
        zm_quest::show_splash_item_picked_up( #"wwq", #"hash_41929f3ebd40a391", 1, self );
        wait 0.5;
        thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw1_pick_up_furin", #"bc_flavor_player_positive" );
    }
    
    if ( level utility::flag( "power_on" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            function_ecc91637c2a6fbb1();
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xb42f6a56, Offset: 0x5cfa
// Size: 0x50
function function_3adc6f07c6721115()
{
    function_a0565bbc8222f23f( level.ww_neko.mdl_figurine );
    function_a0565bbc8222f23f( level.ww_neko.mdl_karakuri );
    function_a0565bbc8222f23f( level.ww_neko.mdl_furin );
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xdc782f24, Offset: 0x5d52
// Size: 0x2c
function function_a0565bbc8222f23f( ent )
{
    if ( isdefined( ent ) )
    {
        if ( isent( ent ) )
        {
            ent delete();
            return;
        }
        
        ent freescriptable();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x14ce82dd, Offset: 0x5d86
// Size: 0x1ad
function function_3338d439812d6391()
{
    level endon( #"game_ended", #"completed_ww_step_3" );
    var_15f5536ed05dd399 = utility::getstructarray( "escape_pt" );
    var_bf44921702499eb4 = function_47c86977a18df38b( var_15f5536ed05dd399, level.hornet_ww_quest.s_print.origin );
    sc_fx = spawnscriptable( %"zm_sat_hornet_ww_trail", var_bf44921702499eb4.origin, var_bf44921702499eb4.angles );
    sc_fx utility::function_32b24db3127bff40( "visual", "print_reveal" );
    sc_fx thread delete_after_time( 3 );
    self.var_8d21ca07b4ff1b6f.origin = var_bf44921702499eb4.origin;
    self setscriptablepartstate( "visual", "run" );
    var_be17fae8e83d6e7b = utility::getstruct( var_bf44921702499eb4.target );
    
    while ( true )
    {
        thread function_b6ad9ae0dacb7772();
        self.var_8d21ca07b4ff1b6f function_40efcdc7476a6f67( self.origin, var_be17fae8e83d6e7b.origin, 150, 10 );
        var_be17fae8e83d6e7b = utility::getstruct( var_be17fae8e83d6e7b.target );
        
        if ( level utility::flag( "ash_ending" ) )
        {
            break;
        }
    }
    
    var_15f5536ed05dd399 = utility::getstructarray( "escape_pt" );
    var_bf44921702499eb4 = function_47c86977a18df38b( var_15f5536ed05dd399, self.origin );
    thread function_b6ad9ae0dacb7772();
    self.var_8d21ca07b4ff1b6f function_40efcdc7476a6f67( self.origin, var_bf44921702499eb4.origin, 150, 10 );
    utility::function_32b24db3127bff40( "visual", "hidden" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x33089b7f, Offset: 0x5f3b
// Size: 0x59f
function paw_print_reveal()
{
    if ( level utility::flag( "prints_revealed" ) )
    {
        return;
    }
    
    level endon( #"completed_ww_step_3" );
    level utility::flag_wait_all( "completed_ww_step_1", "completed_ww_step_2" );
    level utility::flag_set( "pause_ambient_ash" );
    a_s_markers = utility::getstructarray( "print_marker" );
    level.hornet_ww_quest.var_ce0f3411499ab2da = [];
    level.hornet_ww_quest.a_s_prints = utility::getstructarray( "print_start" );
    
    foreach ( s_print in level.hornet_ww_quest.a_s_prints )
    {
        zone = zone_manager::function_90e5c3e2272b0130( s_print.origin );
        s_print.zone_name = zone.script_zone_name;
    }
    
    level.hornet_ww_quest.s_print = utility::array_random( level.hornet_ww_quest.a_s_prints );
    v_first_print = level.hornet_ww_quest.s_print.origin;
    
    foreach ( s_marker in a_s_markers )
    {
        if ( s_marker.script_noteworthy === level.hornet_ww_quest.s_print.script_noteworthy )
        {
            v_pos = s_marker.origin;
            n_radius = s_marker.radius;
            level.hornet_ww_quest.s_print_marker = s_marker;
        }
    }
    
    zone_name = function_fbb7d4c98261e273( level.hornet_ww_quest.s_print.zone_name );
    ash_zones = zm_sat_hornet_weather_ash::function_8928ea3a422bbcaf();
    
    if ( arraycontains( ash_zones, zone_name ) )
    {
        level utility::flag_set( "ash_start" );
        
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            function_ecc91637c2a6fbb1();
        }
        
        level waittill( "sh_" + zone_name + "_end" );
    }
    else
    {
        wait randomintrange( 10, 16 );
        zm_sat_hornet_weather_ash::function_6f9a9c8f4f91f3a4( zone_name );
        level utility::flag_set( "ash_start" );
        
        /#
            iprintlnbold( "<dev string:x30>" );
        #/
        
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            function_ecc91637c2a6fbb1();
        }
        
        n_wait = randomintrange( 60, 76 );
        
        if ( getdvarint( @"hash_a11abfc65330260c", 0 ) )
        {
            n_wait = 10;
        }
        
        wait n_wait - 5;
        level utility::flag_set( "ash_ending" );
        wait 5;
        zm_sat_hornet_weather_ash::function_502a6d0994562459( zone_name );
    }
    
    level utility::flag_set( "ash_end" );
    level utility::flag_clear( "pause_ambient_ash" );
    
    /#
        iprintlnbold( "<dev string:x3a>" );
    #/
    
    level.hornet_ww_quest.s_print_marker.origin = v_first_print;
    level.var_e3c8731c458d8627 = 200;
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
    
    callback::add( #"on_ai_killed", &function_1d6c5e4473c008df );
    level.hornet_ww_quest.s_print function_a4d7e3c9487c86e5();
    level.var_e3c8731c458d8627 = 200;
    var_7b97f011bb3a6659 = level.hornet_ww_quest.s_print;
    
    while ( true )
    {
        if ( isdefined( var_7b97f011bb3a6659.target ) )
        {
            level.hornet_ww_quest.s_print = utility::getstruct( var_7b97f011bb3a6659.target );
            level.hornet_ww_quest.s_print_marker.origin = level.hornet_ww_quest.s_print.origin;
            
            if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
            {
                function_ecc91637c2a6fbb1();
            }
            
            level.hornet_ww_quest.s_print function_a4d7e3c9487c86e5();
            var_7b97f011bb3a6659 = level.hornet_ww_quest.s_print;
        }
        else
        {
            level.hornet_ww_quest.s_print_end = var_7b97f011bb3a6659;
            level utility::flag_set( "prints_revealed" );
            level thread function_500b3f8a817e65fb( level.hornet_ww_quest.s_print_end.script_label );
            
            if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
            {
                level thread function_240244504ce1a917( level.hornet_ww_quest.s_print_end );
            }
            
            break;
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x4ed764b9, Offset: 0x64e2
// Size: 0x1bf
function function_500b3f8a817e65fb( str_dir )
{
    a_s_prints = utility::getstructarray( "circle_print" );
    var_11b04dc47a3a3b01 = undefined;
    
    foreach ( s_print in a_s_prints )
    {
        if ( s_print.script_noteworthy == str_dir )
        {
            sc_print = spawnscriptable( %"zm_sat_hornet_ww_paw", s_print.origin, s_print.angles );
            
            if ( isdefined( sc_print ) )
            {
                sc_print thread function_f1ac99b48c1137b4();
                sc_print utility::function_32b24db3127bff40( "visual", "reveal" );
            }
            
            if ( !isdefined( var_11b04dc47a3a3b01 ) )
            {
                var_11b04dc47a3a3b01 = 1;
                
                if ( isdefined( sc_print ) )
                {
                    playsoundatpos( sc_print.origin, #"hash_4381553684a40022" );
                }
            }
        }
    }
    
    if ( is_lava_molten( sc_print ) )
    {
        level utility::flag_set( "lava_molten" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
        {
            function_ecc91637c2a6fbb1();
        }
        
        return;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
    
    while ( !is_lava_molten( sc_print ) )
    {
        wait 1;
    }
    
    level utility::flag_set( "lava_molten" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x4f653636, Offset: 0x66a9
// Size: 0x54
function private function_fbb7d4c98261e273( zone_name )
{
    var_93d84a67723d6fe6 = strtok( zone_name, "_" );
    
    if ( var_93d84a67723d6fe6.size > 3 )
    {
        generalized_zone_name = var_93d84a67723d6fe6[ 0 ] + "_" + var_93d84a67723d6fe6[ 1 ] + "_" + var_93d84a67723d6fe6[ 2 ];
        return generalized_zone_name;
    }
    
    return zone_name;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x54e026ae, Offset: 0x6706
// Size: 0xc1
function function_a4d7e3c9487c86e5()
{
    level endon( #"game_ended", #"completed_ww_step_3" );
    self waittill( #"hash_afecf76e733fe131" );
    
    if ( !isdefined( self.target ) )
    {
        return;
    }
    
    sc_print = spawnscriptable( %"zm_sat_hornet_ww_paw", level.hornet_ww_quest.s_print.origin, level.hornet_ww_quest.s_print.angles );
    playsoundatpos( sc_print.origin, #"hash_4381553684a40022" );
    wait 0.5;
    sc_print utility::function_32b24db3127bff40( "visual", "reveal" );
    sc_print thread function_f1ac99b48c1137b4();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xd04b724a, Offset: 0x67cf
// Size: 0x21
function function_f1ac99b48c1137b4()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "maneki_lured" );
    self freescriptable();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x5e4e9edc, Offset: 0x67f8
// Size: 0x106
function function_1d6c5e4473c008df( sparams )
{
    if ( isplayer( sparams.eattacker ) && !isdefined( level.hornet_ww_quest.s_print.var_11b04dc47a3a3b01 ) )
    {
        var_92b21ca8efb6aef2 = distancesquared( level.hornet_ww_quest.s_print.origin, self.origin );
        
        if ( var_92b21ca8efb6aef2 <= 10000 )
        {
            level.hornet_ww_quest.s_print.var_11b04dc47a3a3b01 = 1;
            level.hornet_ww_quest.s_print notify( #"hash_afecf76e733fe131" );
            
            if ( isalive( sparams.eattacker ) && !level.var_707c713f0b47a4e2 )
            {
                level.var_707c713f0b47a4e2 = 1;
                wait 0.5;
                sparams.eattacker thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw1_reveal_paw_print_first_time" );
            }
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xc565945e, Offset: 0x6906
// Size: 0x122
function function_50f69d4ac3457119()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( s_print in level.hornet_ww_quest.a_s_prints )
        {
            foreach ( var_4e6d90bf783a5546 in level.ash_root.var_110f8886053692a9 )
            {
                if ( issubstr( s_print.zone_name, var_4e6d90bf783a5546 ) )
                {
                    return s_print;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xacd9858f, Offset: 0x6a30
// Size: 0xc
function function_136fc86690f5969d( params )
{
    
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xdf0fedbf, Offset: 0x6a44
// Size: 0x273
function function_bf63101e04707fa7( params )
{
    if ( isdefined( params.owner ) )
    {
        params.owner endon( #"death" );
        
        if ( !params.owner.var_84b209983c7ea012 )
        {
            params.owner.var_84b209983c7ea012 = 1;
            params.owner thread function_c4a1a53a64653d04();
        }
    }
    
    level endon( #"maneki_lured" );
    
    if ( !level utility::flag( "maneki_lured" ) )
    {
        if ( isdefined( params.owner.maneki_neko ) && isdefined( level.hornet_ww_quest.s_print_end ) && distance2dsquared( params.owner.maneki_neko.origin, level.hornet_ww_quest.s_print_end.origin ) <= 22500 )
        {
            if ( !is_lava_molten( level.hornet_ww_quest.s_print_end ) && ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) ) )
            {
                level utility::flag_clear( "lava_molten" );
                function_ecc91637c2a6fbb1();
                level.hornet_ww_quest.s_print_end thread function_d2bd0555032e5fe4();
                return;
            }
            
            a_s_lava = utility::getstructarray( "lf_parent" );
            s_lava = function_47c86977a18df38b( a_s_lava, params.owner.maneki_neko.origin );
            
            if ( level.hornet_ww_quest.s_print_end.script_label == "nw" || level.hornet_ww_quest.s_print_end.script_label == "se" )
            {
                params.owner.maneki_neko thread nekomata_lure( level.hornet_ww_quest.s_print_end );
                return;
            }
            
            if ( !s_lava.iscooled )
            {
                params.owner.maneki_neko thread nekomata_lure( level.hornet_ww_quest.s_print_end );
            }
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x729561a1, Offset: 0x6cbf
// Size: 0x33
function function_d2bd0555032e5fe4()
{
    level endon( #"maneki_lured" );
    
    while ( !is_lava_molten( self ) )
    {
        wait 1;
    }
    
    level utility::flag_set( "lava_molten" );
    function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x6612ca2a, Offset: 0x6cfa
// Size: 0x3d
function function_240244504ce1a917( s_print_end )
{
    level endon( #"maneki_lured" );
    
    while ( is_lava_molten( s_print_end ) )
    {
        wait 1;
    }
    
    level utility::flag_clear( "lava_molten" );
    function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x1cecda50, Offset: 0x6d3f
// Size: 0x2b
function function_c4a1a53a64653d04()
{
    self endon( #"death" );
    wait 2;
    
    if ( isdefined( self ) )
    {
        thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw1_deploy_maneki_neko", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x8a79b9bb, Offset: 0x6d72
// Size: 0x314
function nekomata_lure( s_lure )
{
    level endon( #"game_ended" );
    level utility::flag_set( "block_ar" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    control_pt = ( self.origin + s_lure.origin ) / 2 + ( 0, 0, 10 );
    thread utility::function_8001268940441423( self.origin, s_lure.origin, control_pt, 0.3, undefined, 1 );
    utility::waittill_any_timeout( 0.5, "off_bezier_curve" );
    wait 2;
    a_s_leap = utility::getstructarray( "print_leap" );
    s_leap = function_47c86977a18df38b( a_s_leap, s_lure.origin );
    level.hornet_ww_quest.s_abom = s_leap;
    level.var_e696ba84722684af = utility::getstruct( s_leap.target );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin = s_leap.origin;
    var_ad8b274417815b62 = utility::getstructarray( "maneki_lure", "script_noteworthy" );
    var_5990ce3727e634d1 = function_47c86977a18df38b( var_ad8b274417815b62, s_leap.origin );
    level.ww_neko.sc_neko thread function_ef85b40bcd131c0e();
    level.ww_neko.sc_neko nekomata_leap( s_leap.origin, var_5990ce3727e634d1.origin, 200, 2.5 );
    [ n_index ] = utility::function_b104528d84ca3561( s_leap.script_int, "" );
    zm_quest::function_4eefe6de31f5ddab( #"hornet_ww_quest", #"abom_spawn", n_index );
    a_players = getplayersinradius( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin, 1000 );
    
    if ( isdefined( a_players ) && a_players.size )
    {
        player = function_47c86977a18df38b( a_players, level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin );
        
        if ( isdefined( player ) )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw1_reveal_nekomata" );
        }
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"maneki_neko_die" );
        playsoundatpos( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin, #"hash_cd05013d2d905761" );
    }
    
    wait 1;
    zm_quest::clear_all_guidance();
    level utility::flag_set( "maneki_lured" );
    level utility::flag_set( "completed_ww_step_3" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x4ce85b78, Offset: 0x708e
// Size: 0xe8
function function_ef85b40bcd131c0e()
{
    sc_trail = spawnscriptable( %"zm_sat_hornet_ww_vfx", self.var_8d21ca07b4ff1b6f.origin, self.var_8d21ca07b4ff1b6f.angles );
    sc_trail utility::scriptable_setparententity( self.var_8d21ca07b4ff1b6f );
    sc_trail setscriptablepartstate( "visual", "lava_trail" );
    wait 1.75;
    sc_exit = spawnscriptable( %"zm_sat_hornet_ww_vfx", self.var_8d21ca07b4ff1b6f.origin, self.var_8d21ca07b4ff1b6f.angles );
    sc_exit setscriptablepartstate( "visual", "lava_exit" );
    
    /#
        iprintlnbold();
    #/
    
    self.var_8d21ca07b4ff1b6f playsoundonmovingent( #"hash_73b3056861d889cf" );
    wait 5;
    sc_trail freescriptable();
    sc_exit freescriptable();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x65145993, Offset: 0x717e
// Size: 0x1cd
function abom_battle()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "power_on" );
    wait 1.1;
    aitype = subclass_to_aitype_map::function_427ae77ce1056e01( "zombie_abom", [ "stam_zm_sat_hornet_abom" ] );
    level.var_8b20e2541cec4ff6 = undefined;
    
    if ( !isdefined( level.hornet_ww_quest.s_abom ) )
    {
        level.hornet_ww_quest.s_abom = utility::array_random( utility::getstructarray( "print_leap" ) );
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin = level.hornet_ww_quest.s_abom.origin;
    }
    
    while ( !isdefined( level.var_8b20e2541cec4ff6 ) )
    {
        level.var_8b20e2541cec4ff6 = agent_manager::spawn_agent( aitype, level.hornet_ww_quest.s_abom.origin, level.hornet_ww_quest.s_abom.angles, "team_two_hundred" );
        
        if ( isdefined( level.var_8b20e2541cec4ff6 ) )
        {
            if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
            {
                function_ecc91637c2a6fbb1();
            }
            
            level.var_8b20e2541cec4ff6.var_e7095781f14d8c2d = 1;
            level.var_8b20e2541cec4ff6 thread zombie_spawn_animation( level.hornet_ww_quest.s_abom );
            level.var_8b20e2541cec4ff6 thread abom_swallow();
            level.var_8b20e2541cec4ff6 thread function_90d1d520bf73c75b();
            level.var_8b20e2541cec4ff6 zombie_utils::function_dfae6a5bd222c586( &function_9e3eb44aeb57118d );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xeaf08fb4, Offset: 0x7353
// Size: 0x26
function private function_9e3eb44aeb57118d( params )
{
    if ( isdefined( self.is_immune ) )
    {
        return 0;
    }
    
    return params.idamage;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x54f03984, Offset: 0x7382
// Size: 0x3b1
function abom_swallow()
{
    self endon( #"death" );
    level.ww_neko.sc_neko.sc_trail = spawnscriptable( %"zm_sat_hornet_ww_vfx", level.ww_neko.sc_neko.origin, level.ww_neko.sc_neko.angles );
    level.ww_neko.sc_neko.sc_trail utility::scriptable_setparententity( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f );
    thread abom_immune( 1 );
    level thread function_a943388ccf28e862( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin );
    level thread function_e905fda692dde801();
    self.var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", self.origin, self.angles );
    self linkto( self.var_2b0c20cebe23ba0b );
    self.var_c862629dd23da56a = utility::spawn_model( "tag_origin", self gettagorigin( "j_spine4" ) );
    self.var_c862629dd23da56a linkto( self, "j_spine4" );
    waitframe();
    sc_trail = spawnscriptable( %"zm_sat_hornet_ww_abom", self.var_2b0c20cebe23ba0b.origin, self.var_2b0c20cebe23ba0b.angles );
    sc_trail utility::scriptable_setparententity( self.var_2b0c20cebe23ba0b, ( -7, 0, 66 ) );
    sc_trail thread delete_after_time( 15 );
    thread abom_splash();
    
    if ( asm::asm_lookupanimfromalias( "animscripted", "leap_out" ) )
    {
        thread utility::animscripted_single( "leap_out" );
    }
    
    control_pt = vectornormalize( anglestoforward( self.angles ) ) * 80 + self.origin + ( 0, 0, 250 );
    sc_trail utility::function_32b24db3127bff40( "visual", "trail" );
    
    if ( isdefined( self.var_2b0c20cebe23ba0b ) && isdefined( level.var_e696ba84722684af.origin ) )
    {
        self.var_2b0c20cebe23ba0b thread utility::function_8001268940441423( self.var_2b0c20cebe23ba0b.origin, level.var_e696ba84722684af.origin, control_pt, 1, undefined, 1 );
        self.var_2b0c20cebe23ba0b utility::waittill_any_timeout( 1.1, "off_bezier_curve" );
    }
    
    sc_impact = spawnscriptable( %"zm_sat_hornet_ww_abom", self.var_2b0c20cebe23ba0b.origin, self.var_2b0c20cebe23ba0b.angles );
    sc_impact utility::function_32b24db3127bff40( "visual", "lava_exit" );
    earthquakeadvanced( 0.4, 0.3, 0.2, 0.5, self.var_2b0c20cebe23ba0b.origin, 400, 500, 600 );
    level thread impact_rumble( self.var_2b0c20cebe23ba0b.origin, 800, "ground_pound_land" );
    function_b0649b3528b861be();
    thread abom_immune( 0 );
    wait 2.5;
    
    if ( isdefined( self.var_2b0c20cebe23ba0b ) )
    {
        self.var_2b0c20cebe23ba0b delete();
    }
    
    if ( isdefined( self.var_c862629dd23da56a ) )
    {
        self.var_c862629dd23da56a delete();
    }
    
    self notify( #"hash_3ece3a7fffaada69" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x3a8f5a84, Offset: 0x773b
// Size: 0x1ed
function function_b0649b3528b861be()
{
    v_mouth = vectornormalize( anglestoforward( self.var_2b0c20cebe23ba0b.angles ) ) * 50 + self.var_2b0c20cebe23ba0b.origin + ( 0, 0, 60 );
    control_pt = ( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin + v_mouth ) / 2 + ( 0, 0, 200 );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f thread utility::function_8001268940441423( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin, v_mouth, control_pt, 2, undefined, 1 );
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "flail" );
    level.ww_neko.sc_neko.sc_trail utility::function_32b24db3127bff40( "visual", "lava_trail" );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f utility::waittill_any_timeout( 2.1, "off_bezier_curve" );
    level.ww_neko.sc_neko.sc_trail freescriptable();
    
    if ( isdefined( self ) )
    {
        thread utility::animscripted_single( "gulp" );
    }
    
    wait 0.1;
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "hidden" );
    level thread abom_vo();
    wait 5.45;
    level utility::flag_set( "abom_swallow" );
    
    if ( isdefined( self ) )
    {
        utility::animscripted_clear();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xe315d7f0, Offset: 0x7930
// Size: 0xc4
function abom_vo()
{
    level endon( #"abom_swallow" );
    wait 2;
    
    if ( isdefined( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f ) )
    {
        a_players = getplayersinradius( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin, 1000 );
        
        if ( isdefined( a_players ) && a_players.size )
        {
            player = function_47c86977a18df38b( a_players, level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin );
            
            if ( isdefined( player ) )
            {
                player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw2_abomination_swallows_nekomata" );
            }
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x6d8ad1, Offset: 0x79fc
// Size: 0x85
function abom_immune( var_b0e144194be51c26 )
{
    if ( isdefined( self ) )
    {
        if ( var_b0e144194be51c26 )
        {
            val::set( "ww_abom", "death", 0 );
            val::set( "ww_abom", "allow_brot", 0 );
            val::set( "ww_abom", "ignoreall", 1 );
            val::set( "ww_abom", "ignore_cleanup", 1 );
            return;
        }
        
        val::reset( "ww_abom", "death" );
        val::reset( "ww_abom", "ignoreall" );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xadbcd1a0, Offset: 0x7a89
// Size: 0xae
function abom_splash()
{
    self endon( #"death" );
    sc_fx = spawnscriptable( %"zm_sat_hornet_ww_abom", self.origin + ( 0, 0, 128 ) );
    n_start_height = self.origin[ 2 ];
    
    while ( true )
    {
        if ( self.origin[ 2 ] > n_start_height + 16 )
        {
            playsoundatpos( self.origin, #"hash_600c0093b503cb4f" );
            break;
        }
        
        wait 0.25;
    }
    
    sc_fx utility::function_32b24db3127bff40( "visual", "jump" );
    wait 5;
    sc_fx freescriptable();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x3a1f0fb, Offset: 0x7b3f
// Size: 0x18a
function function_a943388ccf28e862( v_org )
{
    level endon( #"game_ended" );
    var_a24b06ee08924b7e = squared( 500 );
    
    while ( !level utility::flag( "abom_swallow" ) )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) && distance2dsquared( v_org, player.origin ) <= var_a24b06ee08924b7e )
            {
                player val::set( "abom_swallow", "ignoreme", 1 );
                continue;
            }
            
            if ( isalive( player ) )
            {
                player val::reset( "abom_swallow", "ignoreme" );
            }
        }
        
        wait 0.5;
    }
    
    wait 1;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player val::set( "abom_swallow", "ignoreme", 0 );
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x80b3153e, Offset: 0x7cd1
// Size: 0x9f
function function_e905fda692dde801()
{
    level utility::flag_wait( "abom_swallow" );
    wait 1;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player val::set( "abom_swallow", "ignoreme", 0 );
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xe29c53ae, Offset: 0x7d78
// Size: 0x1d5
function abom_restore()
{
    if ( isdefined( level.var_8b20e2541cec4ff6 ) )
    {
        level.var_8b20e2541cec4ff6 kill();
    }
    
    level utility::flag_wait( "power_on" );
    wait 1;
    var_96b9ad8d374e9468 = zm_quest::function_73720cdf21c3cfd7( #"hornet_ww_quest", #"abom_spawn" );
    
    if ( !isdefined( var_96b9ad8d374e9468 ) )
    {
        return;
    }
    
    if ( var_96b9ad8d374e9468 == 1 )
    {
        str_key = "1";
    }
    else if ( var_96b9ad8d374e9468 == 2 )
    {
        str_key = "2";
    }
    else if ( var_96b9ad8d374e9468 == 3 )
    {
        str_key = "3";
    }
    else
    {
        str_key = "4";
    }
    
    foreach ( var_ba39b89925cb2697 in utility::getstructarray( "print_leap" ) )
    {
        if ( var_ba39b89925cb2697.script_int == str_key )
        {
            s_leap = var_ba39b89925cb2697;
        }
    }
    
    if ( !isdefined( s_leap ) )
    {
        s_leap = utility::array_random( utility::getstructarray( "print_leap" ) );
    }
    
    level.hornet_ww_quest.s_abom = utility::getstruct( s_leap.target );
    
    if ( isdefined( level.ww_neko.sc_neko ) )
    {
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f unlink();
        waitframe();
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin = s_leap.origin;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x7a8ff24c, Offset: 0x7f55
// Size: 0x26
function delete_after_time( n_time )
{
    wait n_time;
    
    if ( isent( self ) )
    {
        self delete();
        return;
    }
    
    self freescriptable();
}

// Namespace zm_sat_hornet_ww_quest
// Params 3
// Checksum 0xa6c0f9b9, Offset: 0x7f83
// Size: 0xa9
function impact_rumble( v_pos, n_radius, var_2c9997925f5b83e7 )
{
    a_players = getplayersinradius( v_pos, n_radius );
    
    foreach ( player in a_players )
    {
        if ( isalive( player ) )
        {
            player playrumbleonentity( var_2c9997925f5b83e7 );
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 3
// Checksum 0x97468bd8, Offset: 0x8034
// Size: 0x117
function find_spawn_location( v_pos, v_forward_pos, n_radius )
{
    level endon( #"game_ended" );
    v_start = v_pos + ( 0, 0, 48 );
    v_end = v_forward_pos + ( 0, 0, 48 );
    n_count = 0;
    
    while ( true )
    {
        results = trace::ray_trace( v_start, v_end, undefined, undefined, 1 );
        
        if ( isdefined( results[ "position" ] ) )
        {
            var_92b21ca8efb6aef2 = distance2dsquared( results[ "position" ], v_pos );
            n_radius = int( sqrt( var_92b21ca8efb6aef2 ) );
            var_408e0c7d8bfc99ad = utility::function_8ae0ea62537eafc5( v_pos, n_radius, 0 );
            var_408e0c7d8bfc99ad = utility::drop_to_ground( var_408e0c7d8bfc99ad, 50 );
            b_passed = trace::ray_trace_passed( v_start, var_408e0c7d8bfc99ad );
            
            if ( function_eebc26d3ebcc3852( var_408e0c7d8bfc99ad ) && b_passed )
            {
                return var_408e0c7d8bfc99ad;
            }
        }
        
        waitframe();
        n_count++;
        
        if ( n_count > 30 )
        {
            return utility::function_8ae0ea62537eafc5( v_pos, 16, 0 );
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xdc4e9889, Offset: 0x8153
// Size: 0x83
function zombie_spawn_animation( s_spawn )
{
    self.disable_spawn_vfx = 1;
    s_spawn.spawning = 1;
    
    if ( !isdefined( s_spawn.script_animation ) )
    {
        if ( issubstr( self.subclass, "zombie_base" ) )
        {
            s_spawn.script_animation = "spawn_hop";
        }
        else
        {
            s_spawn.script_animation = "";
        }
    }
    
    zone_spawner::function_ce10e453e7f7bb8e( s_spawn );
    s_spawn.spawning = undefined;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xdfde5fd9, Offset: 0x81de
// Size: 0x1ad
function function_90d1d520bf73c75b()
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    
    if ( isdefined( self.var_2b0c20cebe23ba0b ) )
    {
        self.var_2b0c20cebe23ba0b delete();
    }
    
    if ( isdefined( self.var_c862629dd23da56a ) )
    {
        self.var_c862629dd23da56a delete();
    }
    
    if ( !level.var_17f99a3acc07b271 )
    {
        level.var_17f99a3acc07b271 = 1;
        level thread function_657f86eb5c98b36c();
    }
    
    level utility::flag_set( "abom_swallow" );
    v_pos = self.origin;
    level utility::flag_set( "abom_defeated" );
    level utility::flag_set( "completed_ww_step_4" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread zm_quest::update_round_cap( 11 );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
    
    if ( isdefined( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f ) )
    {
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin = v_pos;
    }
    
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "sit" );
    zm_quest::clear_all_guidance();
    wait 5;
    
    if ( isdefined( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f ) )
    {
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f thread function_1e21999b0d30294a();
    }
    
    level utility::flag_clear( "block_ar" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xa2ba2546, Offset: 0x8393
// Size: 0xe4
function function_657f86eb5c98b36c()
{
    wait 1;
    level utility::flag_set( "twins_dialogue_playing" );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f dialogue::say( #"hash_8118ba8a80d998a2" );
    wait 1.5;
    a_players = getplayersinradius( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin, 1000 );
    
    if ( isdefined( a_players ) && a_players.size )
    {
        player = function_47c86977a18df38b( a_players, level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin );
        
        if ( isdefined( player ) )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw2_abomination_barfs_up_nekomata_response" );
        }
    }
    
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x5708c276, Offset: 0x847f
// Size: 0x15a
function function_1e21999b0d30294a()
{
    level endon( #"game_ended" );
    var_df99ab323147edf4 = utility::getstructarray( "escape_pt" );
    var_bdbbdbe8e7d867ab = function_47c86977a18df38b( var_df99ab323147edf4, self.origin );
    self playsoundonmovingent( #"hash_68d520f0031d06cf" );
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "run" );
    thread function_291e83cdf727a04();
    self playloopsound( #"hash_f81b599550290db3" );
    level.ww_neko.sc_neko thread function_b6ad9ae0dacb7772();
    function_40efcdc7476a6f67( self.origin, var_bdbbdbe8e7d867ab.origin, 150, 10 );
    self stoploopsound( #"hash_f81b599550290db3" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
    
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "hidden" );
    wait 0.5;
    level waittill( #"on_round_start" );
    level utility::flag_set( "nekomata_sleeping" );
    wait 3;
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xe0bbb36a, Offset: 0x85e1
// Size: 0x61
function function_291e83cdf727a04()
{
    self endon( #"path_reached" );
    self.sc_fx = spawnscriptable( %"zm_sat_hornet_ww_vfx", self.origin, self.angles );
    self.sc_fx utility::scriptable_setparententity( self );
    self.sc_fx utility::function_32b24db3127bff40( "visual", "cat_drip" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x573eb4b1, Offset: 0x864a
// Size: 0xb9
function function_e56f21f226a4498b( params )
{
    if ( params.ref == "equip_attractor" )
    {
        self playsoundtoplayer( #"hash_c906546bc888ceb8", self );
        
        if ( !level utility::flag( "maneki_acquired" ) )
        {
            level utility::flag_set( "maneki_acquired" );
        }
        
        if ( !level utility::flag( "completed_ww_step_2" ) )
        {
            level utility::flag_set( "completed_ww_step_2" );
            
            if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
            {
                function_ecc91637c2a6fbb1();
            }
        }
        
        if ( !level.var_9107f533a4c43200 )
        {
            level.var_9107f533a4c43200 = 1;
            thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw1_pick_up_maneki_neko", #"bc_flavor_player_positive" );
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x8f23cbe9, Offset: 0x870b
// Size: 0x67
function on_quest_item_used( params )
{
    item = params.scriptable;
    
    switch ( item.type )
    {
        case #"hash_6b4b312dc3e1dbce":
            break;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x4cf9eba3, Offset: 0x877a
// Size: 0x95
function function_f4a8a2e11376936c( params )
{
    v_org = self.origin;
    v_ang = self.angles;
    
    if ( self.has_cage )
    {
        thread cage_drop( 0 );
    }
    
    if ( function_913484f6c0aefd27() )
    {
        spawn_wonder_weapon( v_org );
    }
    
    if ( self.has_cat )
    {
        self.has_cat = undefined;
        
        if ( self isgestureplaying() )
        {
            self stopgestureviewmodel();
        }
        
        nekomata_dropped( v_org, v_ang );
    }
    
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x5099efe0, Offset: 0x8817
// Size: 0x9b
function function_2b5b36568e9c1ed8( params )
{
    v_org = self.origin;
    v_ang = self.angles;
    
    if ( self.has_cage )
    {
        thread cage_drop();
    }
    
    if ( function_913484f6c0aefd27() )
    {
        spawn_wonder_weapon( self.origin );
    }
    
    if ( self.has_cat )
    {
        self.has_cat = undefined;
        
        if ( self isgestureplaying() )
        {
            self stopgestureviewmodel();
        }
        
        nekomata_dropped( v_org, v_ang );
    }
    
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xccf66171, Offset: 0x88ba
// Size: 0x4a
function spawn_wonder_weapon( v_pos )
{
    itembundle = getscriptbundle( "itemspawnentry:zm_sat_item_weapon_ww_hornet" );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( v_pos );
    item = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
    return item;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xb02d7085, Offset: 0x890d
// Size: 0xac, Type: bool
function function_913484f6c0aefd27()
{
    wonder_weapon_name = weapon::getweaponrootname( "sat_ww_hornet_mp" );
    var_3df86f0b126863ab = self getweaponslistall();
    
    foreach ( weap in var_3df86f0b126863ab )
    {
        weapname = weapon::getweaponrootname( weap );
        
        if ( weapname == wonder_weapon_name )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x80a02f16, Offset: 0x89c2
// Size: 0x6c
function get_zombie_number()
{
    switch ( level.players.size )
    {
        case 1:
            var_13499fc5a3a2f18c = 5;
            break;
        case 2:
            var_13499fc5a3a2f18c = 7;
            break;
        case 3:
            var_13499fc5a3a2f18c = 10;
            break;
        default:
            var_13499fc5a3a2f18c = 12;
            break;
    }
    
    return var_13499fc5a3a2f18c;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xd5fef428, Offset: 0x8a37
// Size: 0x25
function function_3698bad1f66976b6()
{
    self waittill( #"death" );
    
    if ( level.var_ab4c49769a763880 )
    {
        level.var_ab4c49769a763880--;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xe9cd9884, Offset: 0x8a64
// Size: 0x3b4
function nekomata_sleep()
{
    level utility::flag_set( "pause_ambient_ash" );
    level utility::flag_set( "block_ar" );
    level utility::flag_wait( "nekomata_sleeping" );
    level.var_30c6488505ccf63f = utility::getstructarray( "nekomata_sleep" );
    var_e9f968a7301f36db = get_nekomata_sleep();
    
    if ( !isdefined( var_e9f968a7301f36db ) )
    {
        var_e9f968a7301f36db = utility::array_random( level.var_30c6488505ccf63f );
        var_e9f968a7301f36db.is_current = 1;
    }
    
    foreach ( var_d6603d02be124c70 in level.var_30c6488505ccf63f )
    {
        if ( var_d6603d02be124c70 != var_e9f968a7301f36db )
        {
            var_d6603d02be124c70.is_current = undefined;
        }
    }
    
    if ( !isdefined( level.ww_neko.sc_neko ) )
    {
        nekomata_setup();
    }
    
    wait 1;
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin = var_e9f968a7301f36db.origin;
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.angles = var_e9f968a7301f36db.angles;
    waitframe();
    level.ww_neko.sc_neko.interact = interaction::register_interact( level.ww_neko.sc_neko.origin + ( 0, 0, 42 ), 40, &function_cab0645867782645, undefined, undefined, undefined, 1, undefined, 1 );
    level.ww_neko.sc_neko.interact interaction::set_interact_hint_callback( &function_44253bdb3bef87a3 );
    level.ww_neko.sc_neko thread nekomata_monitor();
    level.ww_neko.sc_neko thread function_25d253ec55f9c561();
    level.ww_neko.sc_neko.var_48bfea3d0b39b29c = var_e9f968a7301f36db.script_noteworthy;
    level.ww_neko.sc_neko.var_e9f968a7301f36db = var_e9f968a7301f36db;
    sc_vfx = spawnscriptable( %"zm_sat_hornet_ww_vfx", var_e9f968a7301f36db.origin, var_e9f968a7301f36db.angles );
    sc_vfx setscriptablepartstate( "visual", "maneki_spawn" );
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "sleep" );
    level.ww_neko.sc_neko setscriptablepartstate( "ping", "sleeping" );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f playloopsound( #"hash_a88172df409800b7" );
    
    if ( isdefined( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.var_3136939e5076d0d ) )
    {
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.var_3136939e5076d0d freescriptable();
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
    
    wait 3;
    sc_vfx freescriptable();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xb4d740ad, Offset: 0x8e20
// Size: 0x188
function get_nekomata_sleep()
{
    foreach ( var_e9f968a7301f36db in level.var_30c6488505ccf63f )
    {
        var_e9f968a7301f36db.current_zone = zone_manager::function_90e5c3e2272b0130( var_e9f968a7301f36db.origin );
        var_e9f968a7301f36db.occupants = zone_manager::get_zone_occupants( var_e9f968a7301f36db.current_zone.zone_name );
    }
    
    level.var_30c6488505ccf63f = arrayrandomize( level.var_30c6488505ccf63f );
    
    for ( i = 0; i < level.var_30c6488505ccf63f.size ; i++ )
    {
        if ( !level.var_30c6488505ccf63f[ i ].occupants.size )
        {
            level.var_30c6488505ccf63f[ i ].is_current = 1;
            return level.var_30c6488505ccf63f[ i ];
        }
    }
    
    for ( i = 0; i < level.var_30c6488505ccf63f.size ; i++ )
    {
        if ( !isdefined( level.var_30c6488505ccf63f[ i ].is_current ) )
        {
            level.var_30c6488505ccf63f[ i ].is_current = 1;
            return level.var_30c6488505ccf63f[ i ];
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xb9736fe0, Offset: 0x8fb0
// Size: 0xd
function restore_nekomata_sleep()
{
    wait 1;
    level thread nekomata_sleep();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x2b0de04a, Offset: 0x8fc5
// Size: 0xb7
function setup_board_monitoring()
{
    a_t_boards = getentarray( "trigger_board", "targetname" );
    
    foreach ( t_board in a_t_boards )
    {
        t_board thread function_6e73e1ab977e6d02();
        level.hornet_ww_quest.a_t_boards[ level.hornet_ww_quest.a_t_boards.size ] = t_board;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xb18d585b, Offset: 0x9084
// Size: 0x108
function nekomata_reset()
{
    level endon( #"game_ended", #"capture_nekomata" );
    
    if ( isdefined( level.ww_neko.sc_neko.interact ) )
    {
        level.ww_neko.sc_neko.interact delete();
    }
    
    level utility::flag_clear( "pause_ambient_ash" );
    level utility::flag_clear( "block_ar" );
    level utility::flag_clear( "nekomata_sleeping" );
    zm_quest::clear_all_guidance();
    wait 1;
    level utility::flag_clear( "locate_nekomata" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
    
    level waittill( #"on_round_start" );
    wait randomfloatrange( 10, 15 );
    level utility::flag_clear( "awake" );
    wait 1;
    level utility::flag_set( "nekomata_sleeping" );
    
    /#
        iprintlnbold( "<dev string:x42>" );
    #/
    
    level thread nekomata_sleep();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xe1486bd9, Offset: 0x9194
// Size: 0x137
function function_25d253ec55f9c561()
{
    level endon( #"capture_nekomata", #"located", #"awake" );
    
    while ( true )
    {
        if ( !level utility::flag( "locate_nekomata" ) )
        {
            foreach ( player in level.players )
            {
                if ( isalive( player ) && isdefined( level.ww_neko.sc_neko ) )
                {
                    if ( player function_5bf510005480ab04( level.ww_neko.sc_neko.origin, 0.7 ) )
                    {
                        level utility::flag_set( "locate_nekomata" );
                        
                        if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
                        {
                            function_ecc91637c2a6fbb1();
                        }
                        
                        level notify( #"located" );
                    }
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x4fb81071, Offset: 0x92d3
// Size: 0x1d5
function function_cab0645867782645( player )
{
    player endon( #"death" );
    level thread function_bd08b6231622d2a7();
    
    if ( self.b_interacted )
    {
        return;
    }
    
    self.b_interacted = 1;
    
    if ( level utility::flag( "awake" ) )
    {
        return;
    }
    
    w_current = player getcurrentweapon();
    
    if ( isdefined( w_current ) && class::ismeleeweapon( w_current ) )
    {
        var_3df86f0b126863ab = player getweaponslistprimaries();
        
        if ( isdefined( var_3df86f0b126863ab[ 0 ] ) )
        {
            player switchtoweapon( var_3df86f0b126863ab[ 0 ] );
            player waittill( #"weapon_change" );
        }
    }
    
    if ( isdefined( player ) )
    {
        player function_de6cc82acf1fe6ac();
    }
    else
    {
        level thread nekomata_reset();
    }
    
    level utility::flag_set( "locate_nekomata" );
    level utility::flag_set( "capture_nekomata" );
    level utility::flag_set( "completed_ww_step_5" );
    level utility::flag_clear( "pause_ambient_ash" );
    level.ww_neko.sc_neko function_da3bdbe814b866ea();
    
    if ( isdefined( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f ) )
    {
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f stoploopsound( #"hash_672613a4744156d1" );
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f playsoundonmovingent( #"hash_68d520f0031d06cf" );
    }
    
    if ( !level.var_a2b6efaf70a751fd )
    {
        level.var_a2b6efaf70a751fd = 1;
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw2_capture_nekomata_success", #"bc_flavor_player_positive" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x4ea2c680, Offset: 0x94b0
// Size: 0xeb
function function_bd08b6231622d2a7()
{
    level endon( #"capture_nekomata" );
    wait 5;
    
    if ( isdefined( level.ww_neko.sc_neko ) )
    {
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f stoploopsound( #"hash_a88172df409800b7" );
        level.ww_neko.sc_neko setscriptablepartstate( "visual", "hidden" );
        sc_vfx = spawnscriptable( %"zm_sat_hornet_ww_vfx", level.ww_neko.sc_neko.origin, level.ww_neko.sc_neko.angles );
        sc_vfx setscriptablepartstate( "visual", "maneki_spawn" );
        level thread nekomata_reset();
        wait 2;
        sc_vfx freescriptable();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x76a6902b, Offset: 0x95a3
// Size: 0xfa
function function_de6cc82acf1fe6ac()
{
    self playrumbleonentity( "damage_heavy" );
    self notifyonplayercommand( "drop_cage_input", "+stance" );
    self notifyonplayercommand( "drop_cage_input", "+prone" );
    self notifyonplayercommand( "drop_cage_input", "+movedown" );
    self setclientomnvar( "ui_hud_carried_item_index", 30 );
    self setclientomnvar( "ui_hud_carried_item_count", 1 );
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "hidden" );
    self.has_cat = 1;
    val::set( "cat_carry", "crouch", 0 );
    val::set( "cat_carry", "killstreaks", 0 );
    val::set( "cat_carry", "prone", 0 );
    val::set( "cat_carry", "allow_scripted_bgb_use", 0 );
    val::set( "cat_carry", "supers", 0 );
    thread function_daba9b1a3a8aa1f8();
    thread function_82226890ae59dfb3();
    utility::function_72b6372d2d8c997( "sat_zm_vm_ges_hold_cat" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x4adcd812, Offset: 0x96a5
// Size: 0x7d
function function_82226890ae59dfb3()
{
    self endon( #"death", #"cat_dropped" );
    
    while ( true )
    {
        self waittill( #"drop_cage_input" );
        
        if ( self isonascender() || !self isonground() || self isonladder() || self isjumping() || self ishighjumping() || self.var_d1c4c78b9fb7d153 )
        {
            continue;
        }
        
        if ( isdefined( self.has_cat ) )
        {
            function_145d155cb15ffc10();
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xb1a07f1c, Offset: 0x972a
// Size: 0x47
function function_145d155cb15ffc10()
{
    self endon( #"death" );
    v_org = self.origin;
    v_ang = self.angles;
    function_9566b590c0879aa8();
    nekomata_dropped( v_org, v_ang );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x6c0b4492, Offset: 0x9779
// Size: 0x67
function function_9566b590c0879aa8()
{
    self.has_cat = undefined;
    val::reset_all( "cat_carry" );
    self notifyonplayercommandremove( "drop_cage_input", "+stance" );
    self notifyonplayercommandremove( "drop_cage_input", "+prone" );
    self notifyonplayercommandremove( "drop_cage_input", "+movedown" );
    self setclientomnvar( "ui_hud_carried_item_index", 30 );
    self setclientomnvar( "ui_hud_carried_item_count", 0 );
    self stopgestureviewmodel();
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0xb9c20d1d, Offset: 0x97e8
// Size: 0x12a
function nekomata_dropped( v_pos, v_ang )
{
    v_forward_pos = vectornormalize( anglestoforward( v_ang ) ) * 100 + v_pos;
    v_ground_pos = utility::drop_to_ground( v_forward_pos, 50 );
    
    if ( isdefined( v_ground_pos ) && function_eebc26d3ebcc3852( v_ground_pos ) )
    {
        var_7e751c750d09f346 = v_ground_pos;
    }
    else
    {
        var_7e751c750d09f346 = find_spawn_location( v_pos, v_forward_pos, 64 );
    }
    
    if ( isdefined( var_7e751c750d09f346 ) && isdefined( v_ang ) )
    {
        wait 0.5;
        sc_neko = spawnscriptable( %"zm_sat_hornet_ww_cat", var_7e751c750d09f346, v_ang + ( 0, -90, 0 ) );
        sc_neko setscriptablepartstate( "visual", "dropped" );
        sc_vfx = spawnscriptable( %"zm_sat_hornet_ww_vfx", var_7e751c750d09f346, v_ang );
        wait 2;
        sc_neko freescriptable();
        sc_vfx setscriptablepartstate( "visual", "maneki_spawn" );
        playsoundatpos( var_7e751c750d09f346, #"hash_616b0c9703c577a4" );
    }
    
    level utility::flag_clear( "capture_nekomata" );
    level thread nekomata_reset();
    wait 2;
    
    if ( isdefined( sc_vfx ) )
    {
        sc_vfx freescriptable();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x5650d907, Offset: 0x991a
// Size: 0x45
function function_b24c44d67d8f8597()
{
    level utility::flag_wait( "initial_player_spawned" );
    
    if ( level utility::flag( "nekomata_acquired" ) )
    {
        return;
    }
    
    while ( !isdefined( level.players[ 0 ] ) )
    {
        waitframe();
    }
    
    level.players[ 0 ] thread function_de6cc82acf1fe6ac();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xb6b640b2, Offset: 0x9967
// Size: 0x22
function function_f384ed0aee9245af()
{
    self endon( #"death" );
    wait 0.1;
    function_9566b590c0879aa8();
    function_16b70d67fc04ac62();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x28a2a0f9, Offset: 0x9991
// Size: 0x63
function function_f89f89e6dc9178d3( params )
{
    if ( self.has_cage )
    {
        thread cage_drop();
    }
    
    if ( self.has_cat )
    {
        self.has_cat = undefined;
        
        if ( self isgestureplaying() )
        {
            self stopgestureviewmodel();
        }
        
        function_9566b590c0879aa8();
        nekomata_dropped( self.origin, self.angles );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x620fa780, Offset: 0x99fc
// Size: 0x95
function private function_44253bdb3bef87a3( usable, player )
{
    if ( player.interactions_disabled || level utility::flag( "awake" ) || !zm_quest::function_b0a5181ebe7bb905() )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_5e064599a3091479", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xd2e10e28, Offset: 0x9a9a
// Size: 0x45
function nekomata_monitor()
{
    level endon( #"game_ended", #"capture_nekomata" );
    self endon( #"death" );
    thread function_9638e5c959fb1f4a();
    thread nekomata_player_weapon();
    level utility::flag_wait( "awake" );
    nekomata_awake();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xf6b8492e, Offset: 0x9ae7
// Size: 0x275
function nekomata_awake()
{
    level endon( #"game_ended", #"capture_nekomata" );
    self endon( #"death" );
    self.var_8d21ca07b4ff1b6f stoploopsound( #"hash_a88172df409800b7" );
    
    if ( isdefined( level.ww_neko.sc_neko.var_e9f968a7301f36db ) && isdefined( level.ww_neko.sc_neko.var_e9f968a7301f36db.target ) )
    {
        s_awake = utility::getstruct( level.ww_neko.sc_neko.var_e9f968a7301f36db.target );
    }
    
    if ( !isdefined( s_awake ) )
    {
        level thread nekomata_reset();
        level.ww_neko.sc_neko setscriptablepartstate( "visual", "hidden" );
        return;
    }
    
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "dropped" );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f rotateto( s_awake.angles, 0.05 );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f moveto( s_awake.origin, 0.05 );
    wait 0.5;
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f playsoundonmovingent( #"hash_616b0c9703c577a4" );
    wait 1;
    var_be17fae8e83d6e7b = utility::getstruct( s_awake.target );
    level.ww_neko.sc_neko function_93e86fde642379fe( var_be17fae8e83d6e7b );
    level thread nekomata_reset();
    level.ww_neko.sc_neko setscriptablepartstate( "visual", "hidden" );
    
    if ( !level.var_95caf4ffec1b424c )
    {
        level.var_95caf4ffec1b424c = 1;
        level.players[ randomint( level.players.size ) ] thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw2_capture_nekomata_fail", #"bc_flavor_player_negative" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xfa891cad, Offset: 0x9d64
// Size: 0x282
function function_93e86fde642379fe( var_be17fae8e83d6e7b )
{
    self endon( #"death", #"reached_goal" );
    v_offset = ( 0, 0, 0 );
    v_ang = vectortoangles( var_be17fae8e83d6e7b.origin - self.origin + v_offset );
    self setscriptablepartstate( "visual", "run" );
    self.var_8d21ca07b4ff1b6f rotateto( v_ang, 0.25 );
    thread function_b6ad9ae0dacb7772();
    self.var_8d21ca07b4ff1b6f playloopsound( #"hash_672613a4744156d1" );
    
    while ( true )
    {
        var_b6081b1b6ba5e8b5 = distance2d( self.var_8d21ca07b4ff1b6f.origin, var_be17fae8e83d6e7b.origin );
        n_time = var_b6081b1b6ba5e8b5 / 180;
        
        if ( n_time <= 0.1 )
        {
            n_time = 0.1;
        }
        
        self.var_8d21ca07b4ff1b6f thread nekomata_turn( var_be17fae8e83d6e7b );
        self.var_8d21ca07b4ff1b6f moveto( var_be17fae8e83d6e7b.origin, n_time );
        self.var_8d21ca07b4ff1b6f waittill( #"movedone" );
        
        if ( var_be17fae8e83d6e7b.script_noteworthy === "jump" )
        {
            var_be17fae8e83d6e7b = utility::getstruct( var_be17fae8e83d6e7b.target );
            control_pt = ( self.var_8d21ca07b4ff1b6f.origin + var_be17fae8e83d6e7b.origin ) / 2 + ( 0, 0, 120 );
            utility::function_32b24db3127bff40( "visual", "leap_in" );
            self.var_8d21ca07b4ff1b6f thread utility::function_8001268940441423( self.var_8d21ca07b4ff1b6f.origin, var_be17fae8e83d6e7b.origin, control_pt, 2, undefined, 1 );
            wait 0.9;
            utility::function_32b24db3127bff40( "visual", "leap_out" );
            self.var_8d21ca07b4ff1b6f utility::waittill_any_timeout( 1.1, "off_bezier_curve" );
            self setscriptablepartstate( "visual", "run" );
        }
        
        if ( isdefined( var_be17fae8e83d6e7b.target ) )
        {
            var_be17fae8e83d6e7b = utility::getstruct( var_be17fae8e83d6e7b.target );
            continue;
        }
        
        self setscriptablepartstate( "visual", "hidden" );
        self.var_8d21ca07b4ff1b6f notify( #"path_reached" );
        self notify( #"reached_goal" );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xfb1d9ce9, Offset: 0x9fee
// Size: 0x133
function function_9a1f1850fb7b514b()
{
    a_s_boards = utility::getstructarray( "floor_board" );
    level.hornet_ww_quest.var_2f166dcd83b163b7 = [];
    level.hornet_ww_quest.a_t_boards = [];
    
    foreach ( var_bbf1a8d11a71ed08 in a_s_boards )
    {
        if ( var_bbf1a8d11a71ed08.script_noteworthy == "san" )
        {
            str_board = "sat_zm_floorboard_wood_02";
        }
        else
        {
            str_board = "sat_zm_floorboard_wood";
        }
        
        mdl_board = utility::spawn_model( str_board, var_bbf1a8d11a71ed08.origin, var_bbf1a8d11a71ed08.angles );
        mdl_board thread board_visibility();
        level.hornet_ww_quest.var_2f166dcd83b163b7[ level.hornet_ww_quest.var_2f166dcd83b163b7.size ] = mdl_board;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x3b339458, Offset: 0xa129
// Size: 0xc2
function function_6e73e1ab977e6d02()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            if ( level utility::flag( "nekomata_sleeping" ) && isdefined( level.ww_neko.sc_neko.var_48bfea3d0b39b29c ) && self.script_noteworthy == level.ww_neko.sc_neko.var_48bfea3d0b39b29c )
            {
                level utility::flag_set( "awake" );
            }
            
            if ( !isdefined( self.b_alarm ) )
            {
                thread board_alarm();
            }
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x3c51455d, Offset: 0xa1f3
// Size: 0xe1
function board_alarm()
{
    level endon( #"game_ended" );
    self.b_alarm = 1;
    playsoundatpos( self.origin, #"hash_c03db9c4fcc392cc" );
    
    while ( true )
    {
        var_3773b5f3cf1455d2 = 0;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && player istouching( self ) )
            {
                var_3773b5f3cf1455d2 = 1;
            }
        }
        
        if ( !var_3773b5f3cf1455d2 )
        {
            self.b_alarm = undefined;
            break;
        }
        
        wait 0.25;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x819996e2, Offset: 0xa2dc
// Size: 0x10f
function function_9638e5c959fb1f4a()
{
    level endon( #"awake", #"capture_nekomata", #"game_ended", #"completed_ww_step_5" );
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && distance2dsquared( self.origin, player.origin ) <= 360000 )
            {
                if ( player issprinting() || player issprintsliding() || player isjumping() )
                {
                    level utility::flag_set( "awake" );
                    
                    /#
                        iprintlnbold( "<dev string:x54>" );
                    #/
                }
            }
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x3fd90d70, Offset: 0xa3f3
// Size: 0x81
function nekomata_player_weapon()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            thread function_d54e421eab38fb91( player );
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x14907b52, Offset: 0xa47c
// Size: 0xc5
function function_d54e421eab38fb91( player )
{
    level endon( #"awake", #"capture_nekomata", #"game_ended" );
    self endon( #"death" );
    player endon( #"death" );
    waitarray = [ "weapon_fired", "grenade_fire", "special_weapon_fired" ];
    
    while ( true )
    {
        if ( isdefined( player ) )
        {
            player utility::waittill_any_in_array_return( waitarray );
            
            if ( isdefined( player ) && distance2dsquared( self.origin, player.origin ) <= 360000 )
            {
                level utility::flag_set( "awake" );
                
                /#
                    iprintlnbold( "<dev string:x54>" );
                #/
            }
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x954e8879, Offset: 0xa549
// Size: 0xed
function board_visibility()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player hasperk( "specialty_death_perception" ) && distance2dsquared( self.origin, player.origin ) <= 75625 )
            {
                self showtoplayer( player );
                self hudoutlineenableforclient( player, "death_perception" );
                continue;
            }
            
            self hidefromplayer( player );
            self hudoutlinedisableforclient( player );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 3
// Checksum 0xd404a5bc, Offset: 0xa63e
// Size: 0xa8
function function_5bf510005480ab04( start, dot = 0.8, ignore_ent )
{
    end = self geteye();
    angles = vectortoangles( start - end );
    forward = anglestoforward( angles );
    player_angles = self getplayerangles();
    player_forward = anglestoforward( player_angles );
    new_dot = vectordot( forward, player_forward );
    
    if ( new_dot < dot )
    {
        return 0;
    }
    
    return trace::ray_trace_detail_passed( start, end, ignore_ent, trace::create_default_contents( 1 ) );
}

// Namespace zm_sat_hornet_ww_quest
// Params 3
// Checksum 0x16d44b2d, Offset: 0xa6ef
// Size: 0x54
function function_c2aa84d816d1dd8b( v_pos, v_ang, n_distance = 100 )
{
    player_angles = v_ang;
    player_angles = ( 0, player_angles[ 1 ], 0 );
    forward = anglestoforward( player_angles );
    return v_pos - forward * n_distance;
}

// Namespace zm_sat_hornet_ww_quest
// Params 4
// Checksum 0x92197eab, Offset: 0xa74c
// Size: 0x18d
function function_40efcdc7476a6f67( v_startpos, v_targetpos, n_speed, n_offset )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_5e29f7a2306a2b69 = findpathcustom( v_startpos, v_targetpos );
    
    for ( i = 1; i < var_5e29f7a2306a2b69.size ; i++ )
    {
        var_b6081b1b6ba5e8b5 = distance2d( var_5e29f7a2306a2b69[ i ], self.origin );
        n_time = var_b6081b1b6ba5e8b5 / n_speed;
        
        if ( n_time <= 0.1 )
        {
            n_time = 0.1;
        }
        
        var_44616205278e62f2 = var_5e29f7a2306a2b69[ i ] + ( 0, 0, n_offset );
        n_dist_to_goal = distance2d( var_44616205278e62f2, self.origin );
        n_time = n_dist_to_goal / n_speed;
        
        if ( n_time <= 0.1 )
        {
            n_time = 0.1;
        }
        
        v_ang = vectortoangles( var_44616205278e62f2 - self.origin );
        self rotateto( v_ang, n_time * 0.25 );
        self moveto( var_44616205278e62f2, n_time );
        self waittill( #"movedone" );
    }
    
    self notify( #"path_reached" );
    sc_vfx = spawnscriptable( %"zm_sat_hornet_ww_vfx", self.origin, self.angles );
    sc_vfx setscriptablepartstate( "visual", "maneki_spawn" );
    
    if ( isdefined( self.sc_fx ) )
    {
        self.sc_fx freescriptable();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xd4848132, Offset: 0xa8e1
// Size: 0x146
function function_b6ad9ae0dacb7772()
{
    self endon( #"death", #"escaped", #"run_done" );
    self.var_3136939e5076d0d = spawnscriptable( %"zm_sat_hornet_ww_vfx", self.origin, self.angles );
    self.var_3136939e5076d0d utility::scriptable_setparententity( self.var_8d21ca07b4ff1b6f );
    
    while ( true )
    {
        waitframe();
        var_5fb4fe43f49ba675 = self.origin + ( 0, 0, -20 );
        
        foreach ( s_lava_flow in level.var_2893957a6bc9f49b )
        {
            if ( ispointinvolume( var_5fb4fe43f49ba675, s_lava_flow.trigger ) )
            {
                self.var_3136939e5076d0d utility::function_32b24db3127bff40( "visual", "cat_lava" );
                continue;
            }
            
            self.var_3136939e5076d0d utility::function_32b24db3127bff40( "visual", "cat_step" );
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xe93a686a, Offset: 0xaa2f
// Size: 0xb7
function function_daba9b1a3a8aa1f8()
{
    level endon( #"feed_nekomata" );
    self endon( #"death" );
    
    while ( isdefined( self.has_cat ) )
    {
        if ( isdefined( level.hornet_pap_quest.sc_seed ) && isdefined( self ) && distance2dsquared( level.hornet_pap_quest.sc_seed.origin, self.origin ) <= 40000 )
        {
            thread function_9566b590c0879aa8();
            level.hornet_pap_quest.sc_seed function_35d707ec4f8cd91b( self );
            level utility::flag_set( "feed_nekomata" );
            zm_quest::clear_all_guidance();
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xa2faa260, Offset: 0xaaee
// Size: 0x16e
function function_35d707ec4f8cd91b( player )
{
    level.ww_neko.sc_neko endon( #"death" );
    player stopgestureviewmodel();
    player.has_cat = undefined;
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f unlink();
    waitframe();
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin = player.origin + ( 0, 0, 60 );
    v_start = level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin;
    waitframe();
    level.ww_neko.sc_neko nekomata_leap( v_start, self.origin + ( 0, 0, 18 ), 100, 1.3 );
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "drain_loop" );
    level.ww_neko.sc_neko setscriptablepartstate( "ping", "active" );
    zm_quest::clear_all_guidance();
    player function_3955f2d841c19971();
    wait 1;
    thread function_4495268f54f11ff8();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x1347fce1, Offset: 0xac64
// Size: 0x61
function function_3955f2d841c19971()
{
    self endon( #"death" );
    level utility::flag_set( "twins_dialogue_playing" );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f dialogue::say( #"hash_1462803f52456996" );
    thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw2_feed_nekomata_response" );
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xad6c001c, Offset: 0xaccd
// Size: 0x3e1
function function_4495268f54f11ff8()
{
    wait 8;
    s_seed = utility::getstruct( "seed" );
    var_be17fae8e83d6e7b = utility::getstruct( "ww_feed_over" );
    sc_seed = spawnscriptable( %"zm_sat_hornet_ww_vfx", s_seed.origin + ( 0, 0, 9.75 ) );
    sc_seed utility::function_32b24db3127bff40( "visual", "feed" );
    wait 0.5;
    level.ww_neko.sc_neko utility::scriptable_clearparententity();
    waitframe();
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f rotateyaw( 90, 0.05 );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f waittill( #"rotatedone" );
    waitframe();
    level.ww_neko.sc_neko utility::scriptable_setparententity( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f );
    sc_fx = spawnscriptable( %"zm_sat_hornet_ww_vfx", level.ww_neko.sc_neko.origin + ( 0, 0, 6 ), level.ww_neko.sc_neko.angles );
    sc_fx utility::function_32b24db3127bff40( "visual", "fed" );
    sc_fx thread delete_after_time( 2 );
    wait 2;
    thread function_7e2469a83fb9cba7();
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f playsoundonmovingent( #"hash_616b0c9703c577a4" );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f playloopsound( #"hash_672613a4744156d1" );
    control_pt = ( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin + var_be17fae8e83d6e7b.origin ) / 2 + ( 0, 0, 100 );
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "leap_in" );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f rotateto( vectortoangles( var_be17fae8e83d6e7b.origin - level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin ) + ( 0, 90, 0 ), 0.25 );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f thread utility::function_8001268940441423( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin, var_be17fae8e83d6e7b.origin, control_pt, 2, undefined, 1 );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f utility::waittill_any_timeout( 1, "off_bezier_curve" );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f notify( #"off_bezier_curve" );
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "flail" );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.var_e2eabc131e74854f = 1;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x29aa3d4f, Offset: 0xb0b6
// Size: 0x326
function function_7e2469a83fb9cba7()
{
    e_fx = utility::spawn_model( "tag_origin", self.origin + ( 0, 0, 9.75 ) );
    e_capture_end = utility::spawn_model( "tag_origin", e_fx.origin );
    wait 0.25;
    e_beam = playfxontagsbetweenclients( level._effect[ "beam_capture" ], e_fx, "tag_origin", e_capture_end, "tag_origin" );
    self playsound( #"hash_64fda4fb11dd4a74" );
    self playloopsound( #"hash_6fb8dc5ae2c79147" );
    
    while ( !isdefined( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.var_e2eabc131e74854f ) )
    {
        if ( !( isdefined( level.ww_neko ) && isdefined( level.ww_neko.sc_neko ) && isdefined( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f ) ) )
        {
            return;
        }
        
        e_capture_end moveto( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin + ( 0, 0, 12 ), 0.05 );
        waitframe();
    }
    
    e_capture_end moveto( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin + ( 0, 0, 12 ), 0.05 );
    e_capture_end waittill( #"movedone" );
    e_capture_end linkto( level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f, "tag_origin", ( 0, 0, 12 ), ( 0, 0, 0 ) );
    sc_vfx = spawnscriptable( %"zm_sat_hornet_ww_vfx", e_capture_end.origin );
    sc_vfx utility::scriptable_setparententity( e_capture_end );
    sc_vfx setscriptablepartstate( "visual", "cat_capture" );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f stoploopsound( #"hash_672613a4744156d1" );
    wait 1;
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f moveto( self.origin + ( 0, 0, 50 ), 1.5 );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f waittill( #"movedone" );
    function_72ab72e0e8aee270();
    level utility::flag_wait( "cat_free" );
    self stoploopsound( #"hash_6fb8dc5ae2c79147" );
    sc_vfx freescriptable();
    e_capture_end unlink();
    e_capture_end moveto( e_fx.origin + ( 0, 0, 9.75 ), 1 );
    e_capture_end waittill( #"movedone" );
    e_beam delete();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xc9d54476, Offset: 0xb3e4
// Size: 0x45
function function_72ab72e0e8aee270()
{
    self.health = 12000;
    thread function_4660eb09ee0ecaa4();
    thread world_seed_pulse();
    thread function_67e9f062ba394b66();
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xc86d0567, Offset: 0xb431
// Size: 0x2d0
function function_4660eb09ee0ecaa4()
{
    self endon( #"released" );
    self waittill( #"pulse" );
    wait 0.5;
    level.hornet_pap_quest.sc_seed.n_hits = 0;
    sc_fx = spawnscriptable( %"zm_sat_hornet_ww_vfx", self.origin + ( 0, 0, 9.75 ) );
    self setcandamage( 1 );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( attacker ) && meansofdeath === "MOD_MELEE" )
        {
            attacker damagefeedback::updatehitmarker( "standard" );
            playsoundatpos( self.origin, #"hash_f52f3cdf0bb698c3" );
            
            if ( !level.var_6f044124ae142b1 )
            {
                level.var_6f044124ae142b1 = 1;
                attacker thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw2_world_seed_melee_first_time" );
            }
            
            sc_fx setscriptablepartstate( "visual", "seed_impact" );
            waitframe();
            sc_fx setscriptablepartstate( "visual", "hidden" );
            level.hornet_pap_quest.sc_seed.n_hits++;
            
            if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
            {
                function_ecc91637c2a6fbb1();
            }
            
            if ( level.hornet_pap_quest.sc_seed.n_hits >= 3 )
            {
                level utility::flag_set( "cat_free" );
                sc_fx setscriptablepartstate( "visual", "seed_done" );
                wait 0.5;
                playsoundatpos( self.origin, #"hash_42b08b822e062362" );
                sc_blast = spawnscriptable( %"zm_sat_hornet_pap_fx", level.hornet_pap_quest.sc_seed.origin );
                sc_blast utility::function_32b24db3127bff40( "visual", "attuned" );
                sc_blast thread delete_after_time( 2 );
                sc_fx thread delete_after_time( 2 );
                level.ww_neko.sc_neko thread function_5a00440a597c7a15();
                level utility::flag_set( "released" );
                self notify( #"released" );
            }
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xf80bd397, Offset: 0xb709
// Size: 0x129
function world_seed_pulse()
{
    self endon( #"released" );
    s_seed = utility::getstruct( "seed" );
    var_a85d3faf8108e120 = squared( 160 );
    var_8bbf663b3cde1aa2 = int( var_a85d3faf8108e120 * 0.5 );
    scr_shockwave = spawnscriptable( "zm_sat_hornet_ww_vfx", s_seed.origin + ( 0, 0, 9.75 ) );
    n_delay = 1;
    
    while ( true )
    {
        for ( i = 0; i < 3 ; i++ )
        {
            self notify( #"pulse" );
            scr_shockwave setscriptablepartstate( "visual", "seed_pulse" );
            playsoundatpos( self.origin, #"hash_c8ae62b53ea63b7f" );
            thread function_a2ffd8995926ec72( var_a85d3faf8108e120, var_8bbf663b3cde1aa2 );
            wait 0.1;
            scr_shockwave setscriptablepartstate( "visual", "hidden" );
            
            if ( i < 2 )
            {
                wait n_delay;
            }
        }
        
        n_delay += 0.5;
        
        if ( n_delay == 2 )
        {
            n_delay = 1;
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0x7416d72a, Offset: 0xb83a
// Size: 0xf5
function function_a2ffd8995926ec72( var_a85d3faf8108e120, var_8bbf663b3cde1aa2 )
{
    a_zombies = getaiarrayinradius( self.origin, 150, "team_two_hundred" );
    
    for ( i = 0; i < a_zombies.size ; i++ )
    {
        if ( isdefined( a_zombies[ i ] ) && distancesquared( self.origin, a_zombies[ i ].origin ) <= var_8bbf663b3cde1aa2 )
        {
            a_zombies[ i ].forceannihilate = 1;
            a_zombies[ i ] kill( self.origin, self );
        }
        else if ( isdefined( a_zombies[ i ] ) && distancesquared( self.origin, a_zombies[ i ].origin ) <= var_a85d3faf8108e120 )
        {
            a_zombies[ i ] thread zombie_knockdown::function_6fc167d4a3590991( self.origin, 150 );
            a_zombies[ i ] dodamage( 50, self.origin, self );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x18847870, Offset: 0xb937
// Size: 0xd6
function function_67e9f062ba394b66()
{
    self endon( #"released" );
    var_92b21ca8efb6aef2 = squared( 150 );
    
    while ( true )
    {
        self waittill( #"pulse" );
        
        foreach ( player in level.players )
        {
            var_4589704325768ab8 = distance2dsquared( self.origin, player.origin );
            
            if ( var_4589704325768ab8 < var_92b21ca8efb6aef2 )
            {
                thread player_knockback( player, var_4589704325768ab8 );
            }
        }
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 2
// Checksum 0xa79e8070, Offset: 0xba15
// Size: 0xd8
function player_knockback( player, var_b6081b1b6ba5e8b5 )
{
    if ( var_b6081b1b6ba5e8b5 <= squared( 40 ) )
    {
        var_48549a864c5bb621 = 1500;
    }
    else if ( var_b6081b1b6ba5e8b5 <= squared( 80 ) )
    {
        var_48549a864c5bb621 = 1100;
    }
    else
    {
        var_48549a864c5bb621 = 800;
    }
    
    if ( isdefined( self ) && isdefined( player ) )
    {
        v_dir = vectortoangles( self.origin + player getcentroid() );
        player playsoundtoplayer( #"hash_99924a1fb249455f", player );
        player knockback( v_dir, var_48549a864c5bb621, 0 );
        player dodamage( int( var_48549a864c5bb621 * 0.02 ), self.origin, self );
        player earthquakeforplayer( 0.3, 0.5, player.origin, 64 );
        player playrumbleonentity( "damage_heavy" );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x34941451, Offset: 0xbaf5
// Size: 0x220
function function_5a00440a597c7a15()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_be17fae8e83d6e7b = utility::getstruct( "ww_feed_over" );
    control_pt = ( self.var_8d21ca07b4ff1b6f.origin + var_be17fae8e83d6e7b.origin ) / 2 + ( 0, 0, 100 );
    utility::function_32b24db3127bff40( "visual", "leap_in" );
    self.var_8d21ca07b4ff1b6f thread utility::function_8001268940441423( self.var_8d21ca07b4ff1b6f.origin, var_be17fae8e83d6e7b.origin, control_pt, 1.5, undefined, 1 );
    wait 0.9;
    utility::function_32b24db3127bff40( "visual", "leap_out" );
    self.var_8d21ca07b4ff1b6f utility::waittill_any_timeout( 0.7, "off_bezier_curve" );
    self.var_8d21ca07b4ff1b6f.angles = var_be17fae8e83d6e7b.angles + ( 0, -90, 0 );
    self.var_8d21ca07b4ff1b6f.origin = var_be17fae8e83d6e7b.origin;
    self setscriptablepartstate( "visual", "weapon" );
    waitframe();
    sc_transform = spawnscriptable( %"zm_sat_hornet_ww_vfx", self.origin );
    sc_transform setscriptablepartstate( "visual", "cat_transform" );
    wait 1;
    sc_transform freescriptable();
    level utility::flag_set( "save_nekomata" );
    playsoundatpos( self.origin, #"hash_68d520f0031d06cf" );
    self.interact = interaction::register_interact( self.origin + ( 0, 0, 42 ), 40, &function_ce94ea93aec48eda, undefined, undefined, undefined, 1, undefined, 1 );
    self.interact interaction::set_interact_hint_callback( &nekomata_hint );
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        function_ecc91637c2a6fbb1();
    }
    
    level utility::flag_wait( "nekomata_acquired" );
    self freescriptable();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xfe0b31fa, Offset: 0xbd1d
// Size: 0x48
function function_ce94ea93aec48eda( player )
{
    if ( player.interactions_disabled )
    {
        return;
    }
    
    player playsoundtoplayer( "uin_zm_weapon_legendary_pickup", player );
    player function_16b70d67fc04ac62();
    zm_quest::clear_all_guidance();
    player thread function_c1586cc4c75c0225();
    self delete();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xb4d69d21, Offset: 0xbd6d
// Size: 0xd3
function function_16b70d67fc04ac62()
{
    item = spawn_wonder_weapon( ( 0, 0, 0 ) );
    common_item::function_2b5e2ff57d5f392( item, 0 );
    level utility::flag_set( "nekomata_acquired" );
    level utility::flag_set( "completed_ww_step_6" );
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_hornet_artifact_3" );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xf098d895, Offset: 0xbe48
// Size: 0x79
function function_c1586cc4c75c0225()
{
    self endon( #"death" );
    
    if ( !level.var_3ff30211a7f345d7 )
    {
        level utility::flag_set( "twins_dialogue_playing" );
        level.var_3ff30211a7f345d7 = 1;
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f dialogue::say( #"hash_598faefbe8b80740" );
        namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw2_pick_up_wonder_weapon_response" );
        level utility::flag_clear( "twins_dialogue_playing" );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xf8814ebc, Offset: 0xbec9
// Size: 0x8a
function private nekomata_hint( usable, player )
{
    if ( player.interactions_disabled || level utility::flag( "nekomata_acquired" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_1dbba7f92117c7a6", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xc23236f5, Offset: 0xbf5c
// Size: 0x89
function private function_3e09828e57f63911( player )
{
    level endon( #"game_ended" );
    level utility::flag_set( "twins_dialogue_playing" );
    var_32d7310b7c94c555 = utility::spawn_model( "tag_origin", player.origin, player.angles );
    var_32d7310b7c94c555 dialogue::say( #"hash_2ac2e8b22da9d482" );
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hw1_pick_up_cage_response" );
    level utility::flag_clear( "twins_dialogue_playing" );
    wait 5;
    var_32d7310b7c94c555 delete();
}

// Namespace zm_sat_hornet_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xb1fe82b3, Offset: 0xbfed
// Size: 0x145
function private function_45c94bbda041a73f()
{
    level endon( #"game_ended", #"completed_ww_step_1" );
    level utility::flag_wait_all( "power_on", "cage_setup" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && distance2dsquared( player.origin, level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin ) <= 160000 )
            {
                if ( !level utility::flag( "completed_ww_step_1" ) )
                {
                    level utility::flag_set( "twins_dialogue_playing" );
                    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f thread dialogue::say( #"hash_74ac46eca51fc8c4" );
                    level utility::flag_clear( "twins_dialogue_playing" );
                }
                
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x4143bc9e, Offset: 0xc13a
// Size: 0x191
function private function_d182a31e2e4851b1()
{
    self endon( #"cage_dropped", #"death", #"game_ended" );
    var_d9662461fbddd8e6 = utility::getstructarray( "lava_proximity", "targetname" );
    
    while ( isdefined( self.has_cage ) )
    {
        foreach ( s_lava_flow in var_d9662461fbddd8e6 )
        {
            if ( !level.var_fc3ea1cc78fee73f && distance2dsquared( self.origin, s_lava_flow.origin ) <= squared( s_lava_flow.radius ) && is_lava_molten( s_lava_flow ) )
            {
                level.var_fc3ea1cc78fee73f = 1;
                var_32d7310b7c94c555 = utility::spawn_model( "tag_origin", self.origin + ( 0, 0, 64 ) );
                var_32d7310b7c94c555 linkto( self );
                level utility::flag_set( "twins_dialogue_playing" );
                var_32d7310b7c94c555 dialogue::say( #"hash_eb481e0a51716342" );
                var_32d7310b7c94c555 thread delete_after_time( 3 );
                playsoundatpos( var_32d7310b7c94c555.origin, #"hash_5683b0e4801e6674" );
                level utility::flag_clear( "twins_dialogue_playing" );
                return;
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xf5447fb2, Offset: 0xc2d3
// Size: 0xcb, Type: bool
function is_lava_molten( var_bf71b84707134267 )
{
    a_s_lava = utility::getstructarray( "lf_parent" );
    var_c4d7ba0ca135419b = utility::getstructarray( "maneki_lure", "script_noteworthy" );
    
    if ( isdefined( var_bf71b84707134267 ) )
    {
        s_lava = function_47c86977a18df38b( a_s_lava, var_bf71b84707134267.origin );
        s_loc = function_47c86977a18df38b( var_c4d7ba0ca135419b, var_bf71b84707134267.origin );
        
        if ( isdefined( s_loc.script_label ) && ( s_loc.script_label == "nw" || s_loc.script_label == "se" ) )
        {
            return true;
        }
        else if ( !s_lava.iscooled )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x98862654, Offset: 0xc3a7
// Size: 0x88
function save_inventory()
{
    level utility::flag_wait( "crafted_maneki" );
    level utility::flag_wait( "maneki_acquired" );
    zm_quest::function_4eefe6de31f5ddab( #"hornet_ww_quest", #"maneki", 1 );
    zm_quest::function_4eefe6de31f5ddab( #"hornet_ww_quest", #"karakuri", 1 );
    zm_quest::function_4eefe6de31f5ddab( #"hornet_ww_quest", #"furin", 1 );
    zm_quest::function_4eefe6de31f5ddab( #"hornet_ww_quest", #"maneki_crafted", 1 );
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0x9701b49d, Offset: 0xc437
// Size: 0xe9
function restore_inventory()
{
    if ( zm_quest::function_73720cdf21c3cfd7( #"hornet_ww_quest", #"maneki" ) )
    {
        zm_quest::function_b57dfe9625966b0b( #"wwq", 0, #"hash_e1881bd4bcbeb80e", 1 );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hornet_ww_quest", #"karakuri" ) )
    {
        zm_quest::function_b57dfe9625966b0b( #"wwq", 0, #"hash_cb32d9e98e43f5d", 1 );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hornet_ww_quest", #"furin" ) )
    {
        zm_quest::function_b57dfe9625966b0b( #"wwq", 0, #"hash_41929f3ebd40a391", 1 );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hornet_ww_quest", #"maneki_crafted" ) )
    {
        level utility::flag_set( "crafted_maneki" );
        level utility::flag_set( "maneki_acquired" );
        level utility::flag_set( "completed_ww_step_2" );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 0
// Checksum 0xdbfed83e, Offset: 0xc528
// Size: 0x6d
function wait_maneki_neko_ready()
{
    level utility::flag_wait( "maneki_neko_ready" );
    level.hornet_ww_quest.var_8549d09a1a0329da = 3;
    level utility::flag_set( "collect_figurine" );
    level utility::flag_set( "collect_karakuri" );
    level utility::flag_set( "collect_furin" );
    level utility::flag_set( "crafted_maneki" );
    level utility::flag_set( "maneki_acquired" );
    function_3adc6f07c6721115();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xb0a61162, Offset: 0xc59d
// Size: 0x1f4
function function_2eb45098b7a8810d( params )
{
    a_s_figurine = utility::getstructarray( "hornet_ww_figurine" );
    var_f6ea89721784a2a0 = utility::getstructarray( "hornet_ww_karakuri" );
    var_b3408a06036a404a = utility::getstructarray( "hornet_ww_furin" );
    
    foreach ( s_furin in var_b3408a06036a404a )
    {
        utility::spawn_model( %"hash_49972bb793499bca", s_furin.origin, s_furin.angles );
    }
    
    foreach ( s_karakuri in var_f6ea89721784a2a0 )
    {
        utility::spawn_model( %"hash_fcc986ce0cf98ed", s_karakuri.origin, s_karakuri.angles );
    }
    
    foreach ( s_figurine in a_s_figurine )
    {
        utility::spawn_model( %"hash_14a43cd5aa21998c", s_figurine.origin, s_figurine.angles );
    }
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x21830563, Offset: 0xc799
// Size: 0x29
function function_26cd1565cc73c321( params )
{
    level.var_777969319d8b23e0 = 1;
    level.players[ 0 ] thread cage_carry();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0x1b9d9bfb, Offset: 0xc7ca
// Size: 0x17
function function_ffec2500434a13d( params )
{
    /#
        level thread function_22d287b76849e2e0();
    #/
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xd14cea04, Offset: 0xc7e9
// Size: 0x692
function function_dfe492d5ff917b33( params )
{
    foreach ( param in params )
    {
        if ( issubstr( param, "loc" ) )
        {
            var_48bfea3d0b39b29c = removesubstr( param, "loc_" );
        }
    }
    
    var_e18560f330123dac = utility::getstructarray( "maneki_lure", "script_noteworthy" );
    var_10aa478ebb9cb2bc = utility::getstructarray( "print_leap" );
    
    foreach ( s_abom in var_10aa478ebb9cb2bc )
    {
        if ( s_abom.script_noteworthy == var_48bfea3d0b39b29c )
        {
            s_spawn = s_abom;
        }
    }
    
    var_be17fae8e83d6e7b = utility::getstruct( s_spawn.target );
    s_cat = function_47c86977a18df38b( var_e18560f330123dac, s_spawn.origin );
    a_s_leap = utility::getstructarray( "print_leap" );
    s_leap = function_47c86977a18df38b( a_s_leap, s_cat.origin );
    var_ad8b274417815b62 = utility::getstructarray( "maneki_lure", "script_noteworthy" );
    var_5990ce3727e634d1 = function_47c86977a18df38b( var_ad8b274417815b62, s_leap.origin );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f unlink();
    waitframe();
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.origin = s_leap.origin;
    waitframe();
    level.ww_neko.sc_neko utility::function_32b24db3127bff40( "visual", "stand" );
    wait 5;
    level.ww_neko.sc_neko thread function_ef85b40bcd131c0e();
    level.ww_neko.sc_neko nekomata_leap( s_leap.origin, var_5990ce3727e634d1.origin, 200, 2.5 );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f.angles += ( 0, 90, 0 );
    aitype = subclass_to_aitype_map::function_427ae77ce1056e01( "zombie_abom", [ "stam_zm_sat_hornet_abom" ] );
    level.var_8b20e2541cec4ff6 = agent_manager::spawn_agent( aitype, s_spawn.origin, s_spawn.angles, "team_two_hundred" );
    level.var_8b20e2541cec4ff6 thread zombie_spawn_animation( s_spawn );
    level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", level.var_8b20e2541cec4ff6.origin, level.var_8b20e2541cec4ff6.angles );
    level.var_8b20e2541cec4ff6 linkto( level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b );
    wait 3;
    sc_trail = spawnscriptable( %"zm_sat_hornet_ww_abom", level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b.origin, level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b.angles );
    sc_trail utility::scriptable_setparententity( level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b, ( -7, 0, 66 ) );
    level.var_8b20e2541cec4ff6 thread abom_splash();
    level.var_8b20e2541cec4ff6 thread utility::animscripted_single( "leap_out" );
    control_pt = vectornormalize( anglestoforward( level.var_8b20e2541cec4ff6.angles ) ) * 80 + level.var_8b20e2541cec4ff6.origin + ( 0, 0, 250 );
    sc_trail utility::function_32b24db3127bff40( "visual", "trail" );
    level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b thread utility::function_8001268940441423( level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b.origin, var_be17fae8e83d6e7b.origin, control_pt, 1, undefined, 1 );
    level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b utility::waittill_any_timeout( 1.1, "off_bezier_curve" );
    sc_impact = spawnscriptable( %"zm_sat_hornet_ww_abom", level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b.origin, level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b.angles );
    sc_impact utility::function_32b24db3127bff40( "visual", "lava_exit" );
    earthquakeadvanced( 0.4, 0.3, 0.2, 0.5, level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b.origin, 400, 500, 600 );
    level thread impact_rumble( level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b.origin, 800, "ground_pound_land" );
    level.var_8b20e2541cec4ff6 thread function_49f0174bbbfd4de6( level.ww_neko.sc_neko );
    wait 2.5;
    level.var_8b20e2541cec4ff6 utility::animscripted_clear();
    wait 5;
    level.var_8b20e2541cec4ff6 unlink();
    level.var_8b20e2541cec4ff6.var_2b0c20cebe23ba0b delete();
    level.var_8b20e2541cec4ff6 kill();
    sc_trail freescriptable();
    sc_impact freescriptable();
}

// Namespace zm_sat_hornet_ww_quest
// Params 1
// Checksum 0xa8f9f9a, Offset: 0xce83
// Size: 0x178
function function_49f0174bbbfd4de6( sc_cat )
{
    v_mouth = self gettagorigin( "tag_fx_jaw_center" );
    
    if ( !isdefined( v_mouth ) )
    {
        v_mouth = vectornormalize( anglestoforward( self.var_2b0c20cebe23ba0b.angles ) ) * 50 + self.var_2b0c20cebe23ba0b.origin + ( 0, 0, 60 );
    }
    
    control_pt = ( sc_cat.var_8d21ca07b4ff1b6f.origin + v_mouth ) / 2 + ( 0, 0, 200 );
    sc_cat.var_8d21ca07b4ff1b6f thread utility::function_8001268940441423( sc_cat.var_8d21ca07b4ff1b6f.origin, v_mouth, control_pt, 2, undefined, 1 );
    sc_cat utility::function_32b24db3127bff40( "visual", "flail" );
    level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f utility::waittill_any_timeout( 2.1, "off_bezier_curve" );
    
    if ( self tagexists( "tag_fx_jaw_center" ) )
    {
        level.ww_neko.sc_neko.var_8d21ca07b4ff1b6f linkto( self, "tag_fx_jaw_center" );
    }
    
    wait 1;
    thread utility::animscripted_single( "gulp" );
    wait 0.1;
    sc_cat utility::function_32b24db3127bff40( "visual", "hidden" );
    wait 5;
    utility::animscripted_clear();
}

/#

    // Namespace zm_sat_hornet_ww_quest
    // Params 1
    // Checksum 0x2cd655ee, Offset: 0xd003
    // Size: 0x54, Type: dev
    function function_c6a858a2b2943227( str_endon )
    {
        level endon( #"game_ended", str_endon );
        self endon( #"death" );
        
        while ( true )
        {
            sphere( self.origin, 64, ( 1, 0, 0 ), 0, 1 );
            wait 1;
        }
    }

    // Namespace zm_sat_hornet_ww_quest
    // Params 0
    // Checksum 0xf1132672, Offset: 0xd05f
    // Size: 0x138, Type: dev
    function function_22d287b76849e2e0()
    {
        a_s_prints = utility::getstructarray( "<dev string:x5b>" );
        
        foreach ( s_print in a_s_prints )
        {
            s_print thread function_17d90afd1404fb9c();
        }
        
        a_s_prints = utility::getstructarray( "<dev string:x67>" );
        
        foreach ( s_print in a_s_prints )
        {
            sc_print = spawnscriptable( %"zm_sat_hornet_ww_paw", s_print.origin, s_print.angles );
            sc_print utility::function_32b24db3127bff40( "<dev string:x74>", "<dev string:x7b>" );
        }
    }

    // Namespace zm_sat_hornet_ww_quest
    // Params 0
    // Checksum 0x8b6d59e1, Offset: 0xd19f
    // Size: 0x6a, Type: dev
    function function_17d90afd1404fb9c()
    {
        show_print();
        var_7b97f011bb3a6659 = self;
        
        while ( true )
        {
            if ( isdefined( var_7b97f011bb3a6659.target ) )
            {
                s_print = utility::getstruct( var_7b97f011bb3a6659.target );
                
                if ( isdefined( s_print.target ) )
                {
                    s_print show_print();
                }
                
                var_7b97f011bb3a6659 = s_print;
            }
            
            wait 1;
        }
    }

    // Namespace zm_sat_hornet_ww_quest
    // Params 0
    // Checksum 0x9a0adc40, Offset: 0xd211
    // Size: 0x43, Type: dev
    function show_print()
    {
        sc_print = spawnscriptable( %"zm_sat_hornet_ww_paw", self.origin, self.angles );
        sc_print utility::function_32b24db3127bff40( "<dev string:x74>", "<dev string:x7b>" );
    }

#/
