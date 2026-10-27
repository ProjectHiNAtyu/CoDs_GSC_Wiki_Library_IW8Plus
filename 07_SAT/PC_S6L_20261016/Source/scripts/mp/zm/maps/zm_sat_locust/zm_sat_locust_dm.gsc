// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_dm.gsc  (hash_25a858e4ffe7ffef.gscc) (size: 19091 Bytes / 0x4a93 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x135d7ef (20305903)
// size ...... 19091 (0x4a93)
// includes .. 9   (offset: 0x463b)
// strings ... 71  (offset: 0x4683)
// dev strs .. 0   (offset: 0x4a93)
// exports ... 30  (offset: 0x3683)
// cseg ...... 0x545 + 0x313e (0x3683)
// imports ... 56  (offset: 0x3b33)
// animtree1 . 0   (offset: 0x4a93)
// animtree2 . 0   (offset: 0x4a93)
#using script_53600bb9c82cbdf2;
#using script_6d876fa941c49c7;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\gametypes\zm_guided;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_boss_fight;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_fergus;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\zm_quest;

#namespace zm_sat_locust_dm;

// Namespace zm_sat_locust_dm
// Params 0, eflags: 0x1
// Checksum 0xf3a018e5, Offset: 0x563
// Size: 0x37
function autoexec init()
{
    if ( game_utility::getgametype() != "zm_guided" )
    {
        return;
    }
    
    function_8163d4663777f0ec();
    utility::registersharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b", &dm_update_guidance );
}

// Namespace zm_sat_locust_dm
// Params 0, eflags: 0x4
// Checksum 0x6352257, Offset: 0x5a2
// Size: 0x199
function private function_8163d4663777f0ec()
{
    zm_guided::register_interact_func( %"sat_zm_prop_earnest", &function_a488de84e3fcfa97 );
    zm_guided::register_interact_func( %"sat_zm_prop_chester", &function_194faee2c35dd7b4 );
    zm_guided::register_interact_func( %"sat_wm_ww_locust_rec_prop", &function_ecd7b69ce2a8bde9 );
    zm_guided::register_interact_func( #"hash_615dfad92a4b326b", &function_c06186b6abbad112 );
    zm_guided::register_interact_func( #"hash_a098c327ff36b16b", &function_65b8d77b1ac486a );
    zm_guided::register_interact_func( #"hash_d47e7a05beac35d2", &function_71672188c3531b0b );
    zm_guided::register_interact_func( #"hash_cc24a7e415c2d1fa", &function_c38c2ecc3fa30c3 );
    zm_guided::register_interact_func( #"hash_96f397939d24f478", &function_774d8a97e8abd411 );
    zm_guided::register_interact_func( #"hash_a94659effa7c6b35", &function_29e645fe5c7f3502 );
    zm_guided::register_interact_func( #"hash_c352c332977dea4", &function_8ad2f8049fb13eaf );
    zm_guided::register_interact_func( #"hash_a84e67b0741d4edb", &function_bd9f8cdd9b158e4e );
    zm_guided::register_interact_func( #"hash_d09ef62e904c7cc", &function_5b3d0c0333e2bd71 );
    zm_guided::register_interact_func( #"hash_f961c7a5172671d9", &function_63d51e22e84ea998 );
    zm_guided::register_interact_func( #"hash_8786c05a63d826c9", &function_6d0bc6db98ea2036 );
    zm_guided::register_interact_func( #"hash_1c92cec617cca51f", &function_c5223c2a7b9f4bbc );
    zm_guided::register_interact_func( #"fishing_stand", &function_7be2d6d7b97a5471 );
    zm_guided::register_interact_func( #"hash_d3a172311502ebff", &function_52cdfce5dc996ca3 );
    zm_guided::register_interact_string( #"constellation_capture", &"zm_sat_locust/hint_constellation_evan_capture" );
    zm_guided::register_interact_string( #"hash_abf52d69bd7c3f52", &"hash_b0bc96fae9f1551" );
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0x8db15d92, Offset: 0x743
// Size: 0x40
function private function_a488de84e3fcfa97( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_earnest_lower", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0x57cb9b0e, Offset: 0x78c
// Size: 0x40
function private function_194faee2c35dd7b4( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_chester_placement", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0xc62e8149, Offset: 0x7d5
// Size: 0x5a
function private function_ecd7b69ce2a8bde9( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:interact.failed ? &"zm_sat_locust/hint_burgess_free" : &"zm_sat_locust/hint_burgess_place", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0x907c58d8, Offset: 0x838
// Size: 0x5b
function private function_52cdfce5dc996ca3( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:!utility::flag( "ww_step_02_a" ) ? &"zm_sat_locust/hint_crypt_chain_place" : &"zm_sat_locust/hint_crypt_chain_pull", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0x6f9e19cb, Offset: 0x89c
// Size: 0x7b
function private function_c06186b6abbad112( interact, player )
{
    if ( !utility::flag( "mq_rm_step_02" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_63e2f30177f9cf40", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0x3a28ef66, Offset: 0x920
// Size: 0x40
function private function_65b8d77b1ac486a( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"hash_2f1879dbb605eee2", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0xbb9bbead, Offset: 0x969
// Size: 0x40
function private function_71672188c3531b0b( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"hash_196c99564d3885f2", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0x6f2f7488, Offset: 0x9b2
// Size: 0x74
function private function_5b3d0c0333e2bd71( interact, player )
{
    if ( player.var_55d09c5e6dd5f1e2 )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_6703ad63719df0a", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0xd9bdcfe, Offset: 0xa2e
// Size: 0xbc
function private function_63d51e22e84ea998( interact, player )
{
    if ( !utility::flag( "mq_rp_step_03_a" ) )
    {
        if ( level.power_quest.collected_uranium > 0 )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_6e1db67859b999b9", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        
        return;
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_7bfea36d44232bb3", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0xbf3f1f98, Offset: 0xaf2
// Size: 0x40
function private function_6d0bc6db98ea2036( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"hash_78e0ad26d49dbadf", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0xc2e46793, Offset: 0xb3b
// Size: 0x7c
function private function_bd9f8cdd9b158e4e( interact, player )
{
    if ( level.power_quest.var_cf29b30fac966d56 )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_25b3abff365d7bad", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0x12ac47e6, Offset: 0xbbf
// Size: 0x10e
function private function_c38c2ecc3fa30c3( interact, player )
{
    if ( interact.hidden )
    {
        if ( level.power_quest.jars_held.size == 0 )
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_6f66665c2d0a844b", #type:"HINT_BUTTON" };
        }
        
        return;
    }
    
    if ( level.power_quest.jars_held.size > 0 )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_526aaab2c92e30a0", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0x23963646, Offset: 0xcd5
// Size: 0x40
function private function_774d8a97e8abd411( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"hash_1e5f626083298b7e", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0xa816b9d3, Offset: 0xd1e
// Size: 0x130
function private function_29e645fe5c7f3502( interact, player )
{
    if ( interact.var_92312339e02c8408 )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_526aaab2c92e30a0", #type:"HINT_BUTTON" };
    }
    
    if ( level.power_quest.jars_held.size > 0 )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_6f66665c2d0a844b", #type:"HINT_BUTTON" };
    }
    
    var_75385495715741fb = zm_sat_locust_util::get_quest_reference( #"hash_f48d6a93accac874" );
    
    if ( level.power_quest.jars_held.size == 0 && var_75385495715741fb.jars_placed > 0 )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_526aaab2c92e30a0", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0xd5ce9f25, Offset: 0xe56
// Size: 0x40
function private function_8ad2f8049fb13eaf( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"hash_5f1bde270fb5fcbe", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0xebd40423, Offset: 0xe9f
// Size: 0x40
function private function_c5223c2a7b9f4bbc( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"hash_4eb27edc14c3f59a", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0x4
// Checksum 0x7218d73f, Offset: 0xee8
// Size: 0x189
function private function_7be2d6d7b97a5471( interact, player )
{
    if ( !interact.fishing_hole.scriptable.active_fish )
    {
        return { #string:&"zm_sat_locust/hint_no_fish", #var_26bbd300351fde34:0, #type:"HINT_NOBUTTON" };
    }
    else if ( !interact.rod_model )
    {
        if ( player zm_sat_locust_fergus::function_c981f5f464e676e5() )
        {
            return { #string:&"hash_20000e756b77a80", #var_26bbd300351fde34:0, #type:"HINT_BUTTON" };
        }
        else
        {
            return { #string:&"hash_50ccd9e1a64a20da", #var_26bbd300351fde34:0, #type:"HINT_NOBUTTON" };
        }
    }
    else if ( interact.rod_model && interact.stored_player == player )
    {
        if ( interact.object_on_the_hook )
        {
            return { #string:&"hash_19a47cd59a0712e9", #var_26bbd300351fde34:0, #type:"HINT_BUTTON" };
        }
        else
        {
            return { #string:&"hash_4d11eb76a8c75ea9", #var_26bbd300351fde34:0, #type:"HINT_BUTTON" };
        }
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_dm
// Params 0, eflags: 0xc
// Checksum 0xe8085ee7, Offset: 0x107a
// Size: 0xfc
function private dm_update_guidance()
{
    self notify( #"hash_1649f22b9ad90f51" );
    self endon( #"hash_1649f22b9ad90f51" );
    
    if ( !utility::flag( "pap_step_12" ) )
    {
        return;
    }
    
    utility::flag_wait( "loading_screen_fade_out_begin" );
    
    if ( !utility::flag( "ww_step_08" ) )
    {
        if ( !utility::flag( "ww_billiam_step_02" ) )
        {
            function_d3661fb77aad74aa();
        }
        else if ( !utility::flag( "ww_burgess_step_03" ) )
        {
            function_c94d9b98a2879cc3();
        }
        else
        {
            function_54ed08a115400802();
        }
        
        return;
    }
    
    if ( !utility::flag( "mq_rm_core" ) || !utility::flag( "mq_rp_step_01_a" ) )
    {
        function_f25e302c6a23691b();
        return;
    }
    
    if ( !utility::flag( "mq_rp_core" ) )
    {
        function_82e113324133fa2e();
        return;
    }
    
    if ( !utility::flag( "mq_rl_core" ) )
    {
        function_1a83590985f1f187();
        return;
    }
    
    if ( !utility::flag( "mq_step_02" ) )
    {
        function_b5a03834799a9ea4();
        return;
    }
    
    zm_quest::clear_all_guidance();
}

// Namespace zm_sat_locust_dm
// Params 0, eflags: 0x4
// Checksum 0x732bb51f, Offset: 0x117e
// Size: 0xc0
function private function_d3661fb77aad74aa()
{
    if ( !utility::flag( "activate_crane" ) )
    {
        crane_usable = zm_sat_locust_util::get_quest_reference( #"hash_1cb916ba3ee31df5" );
        level thread zm_quest::update_guidance( [ [ crane_usable, 24 ] ], #"hash_e3aec2d006eaaee5", #"activate_crane" );
        return;
    }
    
    if ( !utility::flag( "ww_billiam_step_02" ) )
    {
        chain_usable = zm_sat_locust_util::get_quest_reference( #"ww_chainlink" );
        level thread zm_quest::update_guidance( [ [ crane_usable, 24 ], [ chain_usable, 24 ] ], #"hash_e3aec2d006eaaee5", #"collect_chain" );
    }
}

// Namespace zm_sat_locust_dm
// Params 0, eflags: 0x4
// Checksum 0xdf9c499f, Offset: 0x1246
// Size: 0x1b1
function private function_c94d9b98a2879cc3()
{
    if ( !utility::flag( "ww_burgess_step_02" ) )
    {
        bait = zm_sat_locust_util::get_quest_reference( #"ww_bait" );
        level thread zm_quest::update_guidance( [ [ bait, 24 ] ], #"hash_e3aec2d006eaaee5", #"acquire_bait" );
        return;
    }
    
    if ( !utility::flag( "ww_burgess_dm_place_bait" ) )
    {
        bait_trap = zm_sat_locust_util::get_quest_reference( #"hash_9435edf7f1f7c29e" );
        level thread zm_quest::update_guidance( [ [ bait_trap, 24 ] ], #"hash_e3aec2d006eaaee5", #"hash_8b03b6e5bd0e8cd4" );
        return;
    }
    
    if ( !utility::flag( "ww_burgess_step_03_a" ) )
    {
        bait_trap = zm_sat_locust_util::get_quest_reference( #"hash_9435edf7f1f7c29e" );
        level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_b4e96dfd4f5cd0d" );
        return;
    }
    
    if ( !utility::flag( "ww_burgess_step_03_b" ) )
    {
        zursa = level.quest_ww.lantern_quest.zursa;
        level thread zm_quest::update_guidance( [ [ zursa, 96 ] ], #"hash_e3aec2d006eaaee5", #"kill_zursa" );
        return;
    }
    
    if ( !utility::flag( "ww_burgess_step_03" ) )
    {
        var_cb5369743609abbe = zm_sat_locust_util::get_quest_reference( #"ww_lantern" );
        var_cb5369743609abbe setscriptablepartstate( #"objective", #"enabled" );
        level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"collect_lantern" );
    }
}

// Namespace zm_sat_locust_dm
// Params 0, eflags: 0x4
// Checksum 0x9f59941a, Offset: 0x13ff
// Size: 0x37c
function private function_54ed08a115400802()
{
    if ( !utility::flag( "ww_step_02_a" ) )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_crypt_door" ) )
        {
            crypt_door = zm_sat_locust_util::get_quest_reference( #"ww_crypt_door" );
            usable = crypt_door.chain;
            level thread zm_quest::update_guidance( [ [ usable, 24 ] ], #"hash_e3aec2d006eaaee5", #"place_chain" );
        }
        
        return;
    }
    
    if ( !utility::flag( "ww_step_02_b" ) )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_crypt_door" ) )
        {
            crypt_door = zm_sat_locust_util::get_quest_reference( #"ww_crypt_door" );
            usable = crypt_door.chain;
            level thread zm_quest::update_guidance( [ [ usable, 24 ] ], #"hash_e3aec2d006eaaee5", #"reveal_crypt" );
        }
        
        return;
    }
    
    if ( !utility::flag( "ww_step_03_a" ) )
    {
        interact = zm_sat_locust_util::get_quest_reference( #"hash_190817d488858e56" );
        level thread zm_quest::update_guidance( [ [ interact, 24 ] ], #"hash_e3aec2d006eaaee5", #"place_lantern" );
        return;
    }
    
    if ( !utility::flag( "ww_step_03_b" ) )
    {
        idx = level.quest_ww.code_idx;
        code_wall = zm_sat_locust_util::get_quest_reference( #"hash_96b27119d936f549" );
        level thread zm_quest::update_guidance( [ [ code_wall[ idx ], 24 ] ], #"hash_e3aec2d006eaaee5", #"solve_lantern" );
        return;
    }
    
    if ( !utility::flag( "ww_dm_follow" ) )
    {
        zm_quest::clear_all_guidance();
        return;
    }
    
    if ( !utility::flag( "ww_step_04" ) )
    {
        if ( utility::flag( "ww_dm_spawn_platforms" ) )
        {
            zm_quest::clear_all_guidance();
        }
        else
        {
            astrid = zm_sat_locust_util::get_quest_reference( #"ww_astrid" );
            level thread zm_quest::update_guidance( [ [ astrid, 102 ] ], #"hash_e3aec2d006eaaee5", #"follow_astrid_dm" );
        }
        
        return;
    }
    
    if ( !utility::flag( "ww_step_07" ) )
    {
        usable = undefined;
        
        foreach ( safe_area in level.safe_area.nodes )
        {
            if ( safe_area.enter.script_flag_set == "ww_step_07" )
            {
                usable = safe_area.enter;
                break;
            }
        }
        
        level thread zm_quest::update_guidance( [ [ usable, 24 ] ], #"hash_e3aec2d006eaaee5", #"enter_lighthouse" );
        return;
    }
    
    if ( !utility::flag( #"craft_ww" ) )
    {
        usable = zm_sat_locust_util::get_quest_reference( #"hash_90013a88c1591def" );
        level thread zm_quest::update_guidance( [ [ usable, 24 ] ], #"hash_e3aec2d006eaaee5", #"craft_ww" );
    }
}

// Namespace zm_sat_locust_dm
// Params 0, eflags: 0x4
// Checksum 0x946b1c9, Offset: 0x1783
// Size: 0x820
function private function_f25e302c6a23691b()
{
    if ( !utility::flag( "ww_dm_exit_lighthouse" ) )
    {
        zm_quest::clear_all_guidance();
        return;
    }
    
    if ( !utility::flag( "mq_rm_step_02" ) )
    {
        crowbar = zm_sat_locust_util::get_quest_reference( #"hash_e1b204b85412e1fb" );
        level thread zm_quest::update_guidance( [ [ crowbar, 12 ] ], #"hash_e3aec2d006eaaee5", #"collect_crowbar" );
        return;
    }
    
    if ( !utility::flag( #"hash_f86ab8d0731a525c" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_246baaab8e88427a" );
        return;
    }
    
    if ( !utility::flag( "mq_rp_step_01_a" ) )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_3a817233cf6b90fc" ) )
        {
            uranium = zm_sat_locust_util::get_quest_reference( #"hash_3a817233cf6b90fc" );
            uranium setscriptablepartstate( "objective", "enabled" );
        }
        
        level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_b3d111d0de8f21b" );
        return;
    }
    
    if ( !utility::flag( #"hash_a8fa833fe3563102" ) )
    {
        hint = zm_sat_locust_util::get_quest_reference( #"aa_shell_hint" );
        level thread zm_quest::update_guidance( [ [ hint, 24 ] ], #"hash_e3aec2d006eaaee5", #"hash_94d1ee301064d663" );
        return;
    }
    
    if ( !utility::flag( "mq_rm_step_03" ) )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_ded897a885bd34ad" ) )
        {
            shell = zm_sat_locust_util::get_quest_reference( #"hash_ded897a885bd34ad" );
            shell setscriptablepartstate( #"objective", #"enabled" );
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_85e38cf4f364aeb8" );
        }
        else
        {
            guided_crate = undefined;
            crates = zm_sat_locust_util::get_quest_reference( #"hash_66bc71bf51846d35" );
            
            foreach ( crate in crates )
            {
                if ( crate.contents == "shell" )
                {
                    guided_crate = crate;
                }
            }
            
            level thread zm_quest::update_guidance( [ [ guided_crate, 24 ] ], #"hash_e3aec2d006eaaee5", #"hash_85e38cf4f364aeb8" );
        }
        
        return;
    }
    
    if ( !utility::flag( #"hash_a8fa813fe3562d9c" ) )
    {
        shell_chamber = zm_sat_locust_util::get_quest_reference( #"aa_gun" );
        level thread zm_quest::update_guidance( [ [ shell_chamber, 24 ] ], #"hash_e3aec2d006eaaee5", #"load_shell" );
        return;
    }
    
    if ( !utility::flag( "mq_rm_step_04" ) )
    {
        shell_chamber = zm_sat_locust_util::get_quest_reference( #"aa_gun" );
        level thread zm_quest::update_guidance( [ [ shell_chamber, 24 ] ], #"hash_e3aec2d006eaaee5", #"fire_aa_gun" );
        return;
    }
    
    if ( !utility::flag( #"hash_a8fa803fe3562be9" ) )
    {
        antenna_interact = zm_sat_locust_util::get_quest_reference( #"antenna_interact" );
        level thread zm_quest::update_guidance( [ [ antenna_interact, 24 ] ], #"hash_e3aec2d006eaaee5", #"search_wreckage" );
        return;
    }
    
    if ( !utility::flag( #"hash_a8fa7f3fe3562a36" ) )
    {
        transmitter_spawn = zm_sat_locust_util::get_quest_reference( #"transmitter_spawn" );
        transmitter_spawn setscriptablepartstate( #"objective", #"enabled" );
        level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"collect_transmitter" );
        return;
    }
    
    if ( !utility::flag( #"hash_a8fa7e3fe3562883" ) )
    {
        flags = [];
        
        foreach ( point in level.var_db1ca16030498d75.interactions )
        {
            if ( !isdefined( point.script_flag_set ) )
            {
                continue;
            }
            
            flags[ flags.size ] = point;
        }
        
        level thread zm_quest::update_guidance( [ [ flags[ 0 ], 24 ], [ flags[ 1 ], 24 ] ], #"hash_e3aec2d006eaaee5", #"enter_tyr" );
        return;
    }
    
    if ( !utility::flag( "mq_rm_step_06" ) )
    {
        transmitter_deposit = zm_sat_locust_util::get_quest_reference( #"transmitter_deposit" );
        level thread zm_quest::update_guidance( [ [ transmitter_deposit, 24 ] ], #"hash_e3aec2d006eaaee5", #"install_transmitter" );
        return;
    }
    
    if ( !utility::flag( #"hash_a8fa7d3fe35626d0" ) )
    {
        amp_light = zm_sat_locust_util::get_quest_reference( #"lights_amplitude" )[ 0 ];
        freq_light = zm_sat_locust_util::get_quest_reference( #"lights_frequency" )[ 0 ];
        level thread zm_quest::update_guidance( [ [ amp_light, 12 ], [ freq_light, 12 ] ], #"hash_e3aec2d006eaaee5", #"lookat_blinking_lights" );
        return;
    }
    
    if ( !utility::flag( "mq_rm_step_07_a" ) )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"radio_tower_ascender" ) )
        {
            radio_tower_ascender = zm_sat_locust_util::get_quest_reference( #"radio_tower_ascender" );
            level thread zm_quest::update_guidance( [ [ radio_tower_ascender, -300 ] ], #"hash_e3aec2d006eaaee5", #"melt_ascender" );
        }
        
        return;
    }
    
    if ( utility::flag( #"hash_a8fa8c3fe356404d" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_f9b848cfa7879665" );
        return;
    }
    
    if ( !utility::flag( "mq_rm_step_07_c" ) )
    {
        if ( utility::flag( "mq_rm_step_07_b" ) && zm_sat_locust_util::function_3112dc4740eb8499( #"radio_tower_karkinos" ) )
        {
            karkinos = zm_sat_locust_util::get_quest_reference( #"radio_tower_karkinos" );
            level thread zm_quest::update_guidance( [ [ karkinos, 80 ] ], #"hash_e3aec2d006eaaee5", #"kill_karkinos" );
        }
        else
        {
            radio_tower_puzzle = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" );
            
            if ( !utility::flag( "mq_rm_step_07_b" ) )
            {
                first_set = [ #"hash_56be5844469daf4a", #"hash_56be5744469dad97" ];
                ref = first_set[ level.var_41a9e596c74a0cf8.set_1 ];
            }
            else
            {
                second_set = [ #"hash_771cfbbb153243a8", #"hash_771cfebb153248c1" ];
                ref = second_set[ level.var_41a9e596c74a0cf8.set_2 ];
            }
            
            level thread zm_quest::update_guidance( [ [ radio_tower_puzzle, 64 ] ], #"hash_e3aec2d006eaaee5", ref );
        }
        
        return;
    }
    
    if ( !utility::flag( "mq_rm_step_08" ) )
    {
        var_b699cdb061cd813c = zm_sat_locust_util::get_quest_reference( #"hash_25f192b7bac57fef" );
        level thread zm_quest::update_guidance( [ [ var_b699cdb061cd813c, 24 ] ], #"hash_e3aec2d006eaaee5", #"collect_wb" );
    }
}

// Namespace zm_sat_locust_dm
// Params 0, eflags: 0x4
// Checksum 0xbf72b984, Offset: 0x1fab
// Size: 0xeab
function private function_82e113324133fa2e()
{
    if ( !utility::flag( "mq_rp_step_02" ) )
    {
        debris = zm_sat_locust_util::get_quest_reference( #"workshop_debris" );
        icon_loc = debris.origin + anglestoleft( debris.angles ) * 64 + anglestoforward( debris.angles ) * -32;
        level thread zm_quest::update_guidance( [ [ icon_loc, 100 ] ], #"hash_e3aec2d006eaaee5", #"open_workshop" );
        return;
    }
    
    if ( !utility::flag( "mq_rp_step_01" ) )
    {
        if ( !utility::flag( #"collect_rod" ) )
        {
            if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"pole_pickups" ) )
            {
                utility::flag_wait( "poles_initalized" );
            }
            
            rod_pickups = [];
            var_be4a979112a66db0 = zm_sat_locust_util::get_quest_reference( #"pole_pickups" );
            
            foreach ( var_b11b64f5583f0be3 in var_be4a979112a66db0 )
            {
                if ( isdefined( var_b11b64f5583f0be3 ) )
                {
                    new_entry = [ var_b11b64f5583f0be3, 24 ];
                    rod_pickups[ rod_pickups.size ] = new_entry;
                }
            }
            
            new_entry = [ level.fishing_struct.rod_barrel, 24 ];
            rod_pickups[ rod_pickups.size ] = new_entry;
            level thread zm_quest::update_guidance( rod_pickups, #"hash_e3aec2d006eaaee5", #"collect_rod" );
        }
        else if ( !utility::flag( #"hash_35fd63a75bced24f" ) )
        {
            namespace_7acb35c452673b3::function_5826c8ca68de9fc1();
            fishing_spots = zm_sat_locust_util::get_quest_reference( #"hash_e14c6ea2335d2754" );
            goal_spot = fishing_spots[ level.power_quest.var_e29658758f888ffd ];
            var_ab556827771b1b11 = goal_spot.var_f9cd5cbcdb7bf574.scriptable;
            level thread zm_quest::update_guidance( [ [ var_ab556827771b1b11 ] ], #"hash_e3aec2d006eaaee5", #"hash_8f06cfaa95a779bc" );
        }
        else if ( !utility::flag( #"hash_35fd64a75bced402" ) )
        {
            goal_spot = fishing_spots[ level.power_quest.var_e29658758f888ffd ];
            var_ab556827771b1b11 = goal_spot.var_f9cd5cbcdb7bf574.scriptable;
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_a615ae8bff73e713" );
        }
        else if ( !utility::flag( #"hash_35fd65a75bced5b5" ) )
        {
            fishing_spots = zm_sat_locust_util::get_quest_reference( #"hash_e14c6ea2335d2754" );
            goal_spot = fishing_spots[ level.power_quest.var_e29658758f888ffd ];
            var_ab556827771b1b11 = goal_spot.var_f9cd5cbcdb7bf574.scriptable;
            level thread zm_quest::update_guidance( [ [ var_ab556827771b1b11 ] ], #"hash_e3aec2d006eaaee5", #"hash_dc038a26197f340a" );
        }
        else if ( !utility::flag( #"hash_f86ab6d0731a4ef6" ) )
        {
            goal_spot = fishing_spots[ level.power_quest.var_e29658758f888ffd ];
            var_ab556827771b1b11 = goal_spot.var_f9cd5cbcdb7bf574.scriptable;
            level thread zm_quest::update_guidance( [ [ var_ab556827771b1b11 ] ], #"hash_e3aec2d006eaaee5", #"hash_ba5ddbd81de4d8c9" );
        }
        else if ( !utility::flag( #"hash_f86ab7d0731a50a9" ) )
        {
            quest_ravager = zm_sat_locust_util::get_quest_reference( #"hvt_ravager" );
            level thread zm_quest::update_guidance( [ [ quest_ravager, 64 ] ], #"hash_e3aec2d006eaaee5", #"kill_ravager" );
        }
        else if ( !utility::flag( "mq_rp_step_01_b" ) )
        {
            uranium = zm_sat_locust_util::get_quest_reference( #"hash_3a817533cf6b9615" );
            uranium setscriptablepartstate( "objective", "enabled" );
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_b3d121d0de8f3ce" );
        }
        else if ( !utility::flag( #"hash_f86ab9d0731a540f" ) )
        {
            if ( !utility::flag( #"hash_5a0400a77099d116" ) )
            {
                if ( function_58283cb4272bc52a( "rcxd" ) || !zm_sat_locust_util::function_3112dc4740eb8499( #"rcxd_staged_item" ) )
                {
                    utility::flag_set( #"hash_5a0400a77099d116" );
                    
                    if ( !utility::flag( #"hash_5a0401a77099d2c9" ) )
                    {
                        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"vent_blocker" ) )
                        {
                            vent_blocker = zm_sat_locust_util::get_quest_reference( #"vent_blocker" );
                            level thread zm_quest::update_guidance( [ [ vent_blocker, 24 ] ], #"hash_e3aec2d006eaaee5", #"lab_rcxd" );
                        }
                        else
                        {
                            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"lab_rcxd" );
                        }
                        
                        namespace_7acb35c452673b3::function_cf98a4a07345ec2e();
                    }
                }
                else if ( !function_58283cb4272bc52a( "rcxd" ) && zm_sat_locust_util::function_3112dc4740eb8499( #"rcxd_staged_item" ) )
                {
                    staged_item = zm_sat_locust_util::get_quest_reference( #"rcxd_staged_item" );
                    level thread zm_quest::update_guidance( [ [ staged_item, 24 ] ], #"hash_e3aec2d006eaaee5", #"hash_9338bc0665abd171" );
                    level thread function_c5afcdf46bd86544( "rcxd", #"hash_5a0400a77099d116" );
                }
            }
            else if ( !utility::flag( #"hash_5a0401a77099d2c9" ) )
            {
                if ( zm_sat_locust_util::function_3112dc4740eb8499( #"vent_blocker" ) )
                {
                    vent_blocker = zm_sat_locust_util::get_quest_reference( #"vent_blocker" );
                    level thread zm_quest::update_guidance( [ [ vent_blocker, 24 ] ], #"hash_e3aec2d006eaaee5", #"lab_rcxd" );
                }
                else
                {
                    level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"lab_rcxd" );
                }
                
                namespace_7acb35c452673b3::function_cf98a4a07345ec2e();
            }
        }
        else if ( !utility::flag( #"hash_f86abad0731a55c2" ) )
        {
            room_jars = zm_sat_locust_util::get_quest_reference( #"hash_2ae4cc0540a8e80b" );
            
            foreach ( jar in room_jars )
            {
                if ( jar.jar_data.is_required )
                {
                    jar setscriptablepartstate( #"objective", #"enabled" );
                    continue;
                }
                
                jar setscriptablepartstate( #"usable", #"disabled" );
            }
            
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"collect_jars" );
        }
        else if ( !utility::flag( #"hash_f86abbd0731a5775" ) )
        {
            var_75385495715741fb = zm_sat_locust_util::get_quest_reference( #"hash_f48d6a93accac874" );
            var_75385495715741fb setscriptablepartstate( #"objective", #"none" );
            mixture_jar = zm_sat_locust_util::get_quest_reference( #"hash_2d3e8588dd9589cf" );
            mixture_jar setscriptablepartstate( #"objective", #"enabled" );
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"collect_caustic" );
        }
        else if ( !utility::flag( #"hash_f86abcd0731a5928" ) )
        {
            lockpick_spawn = zm_sat_locust_util::get_quest_reference( #"hash_ec5ede4c7c6a23f9" );
            level thread zm_quest::update_guidance( [ [ lockpick_spawn, 24 ] ], #"hash_e3aec2d006eaaee5", #"use_caustic" );
        }
        else if ( !utility::flag( #"hash_f86abdd0731a5adb" ) )
        {
            lockpick = zm_sat_locust_util::get_quest_reference( #"lab_lockpick" );
            level thread zm_quest::update_guidance( [ [ lockpick, 24 ] ], #"hash_e3aec2d006eaaee5", #"hash_bf275054e22102a3" );
        }
        else if ( !utility::flag( #"hash_f86dbad0731c8b99" ) )
        {
            lockpick_interact = zm_sat_locust_util::get_quest_reference( #"hash_6c7f753a7756664" );
            level thread zm_quest::update_guidance( [ [ lockpick_interact, 24 ] ], #"hash_e3aec2d006eaaee5", #"pick_lock" );
        }
        else if ( !utility::flag( "mq_rp_step_01_c" ) )
        {
            uranium = zm_sat_locust_util::get_quest_reference( #"power_uranium_c" );
            uranium setscriptablepartstate( "objective", "enabled" );
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"collect_uranium_c" );
        }
        
        return;
    }
    
    if ( !utility::flag( "mq_rp_step_03" ) )
    {
        if ( !utility::flag( "mq_rp_step_03_a" ) )
        {
            power_source = zm_sat_locust_util::get_quest_reference( #"power_source_pickup" );
            power_source setscriptablepartstate( #"guided_objective", #"enabled" );
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"deposit_rods" );
        }
        else
        {
            power_source = zm_sat_locust_util::get_quest_reference( #"power_source_pickup" );
            power_source setscriptablepartstate( #"guided_objective", #"disabled" );
            var_75385495715741fb = zm_sat_locust_util::get_quest_reference( #"power_source_craft_interact" );
            machine_controls = var_75385495715741fb.origin + anglestoforward( var_75385495715741fb.angles ) * 24 + anglestoright( var_75385495715741fb.angles ) * 12;
            
            if ( utility::flag( #"hash_f86db7d0731c8680" ) )
            {
                level thread zm_quest::update_guidance( [ [ machine_controls, 48 ] ], #"hash_e3aec2d006eaaee5", #"rod_puzzle_cooldown" );
            }
            else
            {
                level thread zm_quest::update_guidance( [ [ machine_controls, 48 ] ], #"hash_e3aec2d006eaaee5", #"rod_puzzle" );
            }
        }
        
        return;
    }
    
    if ( !utility::flag( "mq_rp_step_04" ) )
    {
        if ( !utility::flag( "mq_rp_step_04_a" ) )
        {
            if ( zm_sat_locust_util::function_3112dc4740eb8499( #"power_source_loot" ) )
            {
                power_source = zm_sat_locust_util::get_quest_reference( #"power_source_loot" );
            }
            else if ( zm_sat_locust_util::function_3112dc4740eb8499( #"power_source_pickup" ) )
            {
                power_source = zm_sat_locust_util::get_quest_reference( #"power_source_pickup" );
            }
            
            if ( power_source getscriptablehaspart( #"objective" ) )
            {
                power_source setscriptablepartstate( #"objective", #"none" );
            }
            
            power_source setscriptablepartstate( #"guided_objective", #"enabled" );
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"pickup_power_source" );
        }
        else if ( !utility::flag( #"hash_f86db9d0731c89e6" ) )
        {
            deposit = zm_sat_locust_util::get_quest_reference( #"power_source_deposit" );
            level thread zm_quest::update_guidance( [ [ deposit, 24 ] ], #"hash_e3aec2d006eaaee5", #"shed_deposit" );
        }
        else if ( !utility::flag( "mq_rp_step_04_b" ) )
        {
            var_c0a89f990cafaa0c = zm_sat_locust_util::get_quest_reference( #"power_source_electrical_box" );
            level thread zm_quest::update_guidance( [ [ var_c0a89f990cafaa0c, 24 ] ], #"hash_e3aec2d006eaaee5", #"hash_9353712e6aeb2afe" );
        }
        
        return;
    }
    
    if ( !utility::flag( "mq_rp_step_05" ) )
    {
        if ( !utility::flag( #"hash_621593d8eea24f40" ) )
        {
            foreach ( player in level.players )
            {
                zm_quest::function_38cacc34ddb8431c( player );
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                zm_quest::function_1a1a1e0bd84ac45e( player );
            }
        }
        
        return;
    }
    
    if ( !utility::flag( "mq_rp_step_06" ) )
    {
        if ( !utility::flag( "mq_rp_step_06_a" ) )
        {
            zm_quest::clear_all_guidance();
            charged_source = zm_sat_locust_util::get_quest_reference( #"power_source_deposit" );
            
            if ( charged_source getscriptablepartstate( #"model", 0, 1 ) == #"disabled" )
            {
                charged_source setscriptablepartstate( #"guided_objective", #"disabled" );
                charged_source = zm_sat_locust_util::get_quest_reference( #"hash_8c446a7ac3c0792a" );
            }
            
            if ( charged_source getscriptablehaspart( #"objective" ) )
            {
                charged_source setscriptablepartstate( #"objective", #"none" );
            }
            
            charged_source setscriptablepartstate( #"guided_objective", #"enabled" );
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_e67af73dad21f466" );
        }
        else
        {
            charged_source = zm_sat_locust_util::get_quest_reference( #"power_source_deposit" );
            charged_source setscriptablepartstate( #"guided_objective", #"disabled" );
            deposit = zm_sat_locust_util::get_quest_reference( #"hash_59d80432a1a3fdb9" );
            level thread zm_quest::update_guidance( [ [ deposit, 24 ] ], #"hash_e3aec2d006eaaee5", #"hash_f81611a91c90b209" );
        }
        
        return;
    }
    
    if ( !utility::flag( #"hash_f86db8d0731c8833" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_6318fa7270a0013b" );
        return;
    }
    
    zm_quest::clear_all_guidance();
}

// Namespace zm_sat_locust_dm
// Params 0
// Checksum 0x6d7aa144, Offset: 0x2e5e
// Size: 0x471
function function_1a83590985f1f187()
{
    if ( !utility::flag( "mq_rl_step_02" ) )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_b1ac45e87d3c09c3" ) )
        {
            garment = zm_sat_locust_util::get_quest_reference( #"hash_b1ac45e87d3c09c3" );
            level thread zm_quest::update_guidance( [ [ garment, 24 ] ], #"hash_e3aec2d006eaaee5", #"collect_fragment" );
        }
        
        return;
    }
    
    if ( !utility::flag( "mq_rl_step_03" ) )
    {
        if ( !utility::flag( "mq_rl_step_03_a" ) )
        {
            hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
            level thread zm_quest::update_guidance( [ [ hall_fire, 64 ] ], #"hash_e3aec2d006eaaee5", #"place_fragment" );
        }
        else if ( !utility::flag( "mq_rl_step_03_b" ) )
        {
            hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
            level thread zm_quest::update_guidance( [ [ hall_fire, 64 ] ], #"hash_e3aec2d006eaaee5", #"start_bonfire" );
        }
        else if ( !utility::flag( "mq_rl_step_03_c" ) )
        {
            hall_fire = zm_sat_locust_util::get_quest_reference( #"hash_8d00b8d1f10e5389" );
            
            if ( !utility::flag( #"hash_718c5a6db53f383f" ) )
            {
                if ( function_58283cb4272bc52a( "zm_dinj" ) || !zm_sat_locust_util::function_3112dc4740eb8499( #"dinj_staged_item" ) )
                {
                    utility::flag_set( #"hash_718c5a6db53f383f" );
                    level thread zm_quest::update_guidance( [ [ hall_fire, 32 ] ], #"hash_e3aec2d006eaaee5", #"hash_1a6c2f18426c14d7" );
                }
                else if ( !function_58283cb4272bc52a( "zm_dinj" ) && zm_sat_locust_util::function_3112dc4740eb8499( #"dinj_staged_item" ) )
                {
                    staged_item = zm_sat_locust_util::get_quest_reference( #"dinj_staged_item" );
                    level thread zm_quest::update_guidance( [ [ staged_item, 24 ] ], #"hash_e3aec2d006eaaee5", #"hash_5d03f0865e35b274" );
                    level thread function_c5afcdf46bd86544( "zm_dinj", #"hash_718c5a6db53f383f" );
                }
            }
            else
            {
                level thread zm_quest::update_guidance( [ [ hall_fire, 32 ] ], #"hash_e3aec2d006eaaee5", #"hash_1a6c2f18426c14d7" );
            }
        }
        else if ( !utility::flag( "mq_rl_step_03_d" ) )
        {
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"holdout" );
        }
        else if ( !utility::flag( "mq_rl_step_03_e" ) )
        {
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_be030634210db169" );
        }
        
        return;
    }
    
    if ( !utility::flag( "mq_rl_step_04" ) )
    {
        disc = zm_sat_locust_util::get_quest_reference( #"hash_49fe01f298f554e2" );
        
        if ( !utility::flag( "mq_rl_step_04_a" ) )
        {
            level thread zm_quest::update_guidance( [ [ disc, 24 ] ], #"hash_e3aec2d006eaaee5", #"hash_abf52d69bd7c3f52" );
        }
        else if ( !utility::flag( "mq_rl_step_04_b" ) )
        {
            level thread zm_quest::update_guidance( [ [ disc, 24 ] ], #"hash_e3aec2d006eaaee5", #"activate_offering" );
        }
        
        return;
    }
    
    if ( !utility::flag( "mq_rl_step_05" ) )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_e254894438a37f89" ) )
        {
            compass = zm_sat_locust_util::get_quest_reference( #"hash_e254894438a37f89" );
            goal_pyre = undefined;
            
            foreach ( pyre in compass.pyres )
            {
                if ( pyre.code == compass.full_code[ compass.code_index ] )
                {
                    goal_pyre = pyre;
                    break;
                }
            }
            
            level thread zm_quest::update_guidance( [ [ goal_pyre, 48 ] ], #"hash_e3aec2d006eaaee5", #"hash_6b5a806498d19632" );
        }
    }
}

// Namespace zm_sat_locust_dm
// Params 0, eflags: 0x4
// Checksum 0x7a477835, Offset: 0x32d7
// Size: 0x253
function private function_b5a03834799a9ea4()
{
    if ( !utility::flag( "boss_vote_passed" ) )
    {
        terminal = zm_sat_locust_util::get_quest_reference( #"pap_terminal" );
        level thread zm_quest::update_guidance( [ [ terminal, 24 ] ], #"hash_e3aec2d006eaaee5", #"hash_c6726fcf33a632ae" );
        return;
    }
    
    if ( !utility::flag( "mq_bs_show_guidance" ) )
    {
        zm_quest::clear_all_guidance();
        return;
    }
    
    if ( !utility::flag( "mq_bs_step_01" ) )
    {
        active_weak_points = zm_sat_locust_boss_fight::get_active_weak_points();
        
        if ( active_weak_points.size > 0 )
        {
            weak_point_objectives = [];
            
            foreach ( weak_point_struct in active_weak_points )
            {
                if ( zombie_boss_virgil::is_weak_point_hidden( weak_point_struct ) )
                {
                    continue;
                }
                
                weak_point_quest_ref = getxhash( weak_point_struct.name );
                
                if ( zm_sat_locust_util::function_3112dc4740eb8499( weak_point_quest_ref ) )
                {
                    weak_point_ent = zm_sat_locust_util::get_quest_reference( weak_point_quest_ref );
                }
                
                if ( weak_point_ent )
                {
                    weak_point_objectives[ weak_point_objectives.size ] = [ weak_point_ent ];
                }
            }
            
            level thread zm_quest::update_guidance( weak_point_objectives, #"hash_e3aec2d006eaaee5", #"aid_tyr" );
        }
        else
        {
            level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"aid_tyr" );
        }
        
        return;
    }
    
    if ( !utility::flag( "mq_bs_step_02_a" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_9fdd558e1a18452c" );
        return;
    }
    
    if ( !utility::flag( "mq_bs_step_02_b" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"hash_a8d64a5bfdf24153" );
        return;
    }
    
    if ( !utility::flag( "mq_bs_step_03" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"hash_e3aec2d006eaaee5", #"defeat_dravakar" );
        return;
    }
    
    if ( utility::flag( "mq_bs_step_03" ) )
    {
        level thread zm_quest::function_fb3af5600f6a9441( 4, 1, #"hash_e3aec2d006eaaee5", #"defeat_dravakar" );
    }
}

// Namespace zm_sat_locust_dm
// Params 1, eflags: 0x4
// Checksum 0x87930ff9, Offset: 0x3532
// Size: 0xd3
function private function_58283cb4272bc52a( streak_name )
{
    player_has_streak = 0;
    
    foreach ( player in level.players )
    {
        if ( player.streakdata.streaks.size == 0 )
        {
            continue;
        }
        
        if ( player.streakdata.streaks[ 1 ].streakname == streak_name )
        {
            player_has_streak = 1;
        }
    }
    
    return player_has_streak;
}

// Namespace zm_sat_locust_dm
// Params 2, eflags: 0xc
// Checksum 0x7cf80895, Offset: 0x360e
// Size: 0x75
function private function_c5afcdf46bd86544( streak_name, flag )
{
    self notify( #"hash_b896244eb4d94064" );
    self endon( #"hash_b896244eb4d94064" );
    level endon( #"game_ended", flag );
    
    while ( true )
    {
        if ( function_58283cb4272bc52a( streak_name ) )
        {
            break;
        }
        
        wait 0.1;
    }
    
    utility::delaythread( level.framedurationseconds, &dm_update_guidance );
    utility::flag_set( flag );
}

