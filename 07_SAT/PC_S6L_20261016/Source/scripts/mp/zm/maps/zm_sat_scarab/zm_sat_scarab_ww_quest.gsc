// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ww_quest.gsc  (hash_54d72d6ed3d326a7.gscc) (size: 139352 Bytes / 0x22058 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd384ac1b (3548687387)
// size ...... 139352 (0x22058)
// includes .. 42  (offset: 0x20054)
// strings ... 384 (offset: 0x201a4)
// dev strs .. 52  (offset: 0x21da8)
// exports ... 304 (offset: 0x16c68)
// cseg ...... 0x1f11 + 0x14d57 (0x16c68)
// imports ... 684 (offset: 0x19be8)
// animtree1 . 0   (offset: 0x22058)
// animtree2 . 0   (offset: 0x22058)
#using script_16ea1b94f0f381b3;
#using script_c9364426f358755;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\status_effects\status_effects;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\damagefeedback;
#using scripts\mp\doorbuy;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_usurped_power;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_ncfdpedestal;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_ww_quest;

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x5
// Checksum 0xf162c679, Offset: 0x1f2f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_ww_quest", undefined, undefined, &init );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0
// Checksum 0xf8300a47, Offset: 0x1f50
// Size: 0x371
function init()
{
    level endon( #"game_ended" );
    level utility::flag_wait_all( "zm_sat_scarab_script_quest_ww_cs_completed", "zm_quest_initialized", "scriptables_ready", "doorbuy_init_complete" );
    
    if ( isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "wwQuest" ) )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_1389eb7dad9f9d83", 0 ) )
    {
        return;
    }
    
    wall_cover = getent( "DELETE_ME_wwq_wall_cover", #targetname );
    
    if ( wall_cover )
    {
        wall_cover delete();
    }
    
    utility::add_fx( "ww_plant_life_drain_beam", "vfx_sat_levels_zm_scarab_vine_energy_beam" );
    utility::add_fx( "ww_warp_astral_plane_3p", "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_zmb_3p" );
    level magicbox::function_2e49cd8681e36211( 1 );
    level.scarab_ww_quest = zm_quest::get_quest( #"scarab_ww_quest" );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"hash_f3a77b73b34d83f1", &function_bbb2e33ada22dda0, &function_540b700231a8d9bf );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"collect_prism", &function_bbb2e63ada22e439, &function_540b710231a8dbf2 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"hash_cd6b90bd78df30d5", &function_bbb2e53ada22e206, &function_540b720231a8de25 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"hash_8c2aadf3a579e321", &function_bbb2e83ada22e89f, &function_540b6b0231a8cec0 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"cleanse_vines", &function_bbb2e73ada22e66c, &function_540b6c0231a8d0f3 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"hash_8f84615ebd6df36d", &function_87a59f9ae151af34, &function_24646aabe49ddfd1 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"hash_f97fd6235be10e93", &function_87a5a29ae151b5cd, &function_246467abe49dd938 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"hash_35331de6580ad19f", &function_f4d4eb4e212a6fb, &function_e69d4cd33de6ff30 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"hash_90cb42c3585aefad", &function_bbb2ea3ada22ed05, &function_540b6d0231a8d326 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"hash_5d6c870c26685308", &function_cdcabca54057c398, &function_91218db8dcfb3953 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"hash_52556aa14108f0b6", &function_b462a3ce6472f572, &function_d920e5eb1bb28351 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"hash_f06b84695414d391", &function_54a2292b4c4c49df, &function_d7410a937702b5be );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"solve_riddle", &function_a6d5a3acd93970bb, &function_6d50cebffd0fba32 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"craft_ww", &function_bbb2e93ada22ead2, &function_540b6e0231a8d559 );
    zm_quest::register_quest_step( #"scarab_ww_quest", #"pick_up_ww", &function_bbb2ec3ada22f16b, &function_540b770231a8e924 );
    level init_wwq_assets();
    level function_4653caeb29695dbd();
    level function_a06aeda4705c91c9();
    
    /#
        level init_ww_debug();
    #/
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_a917b99b260ce874", &function_e3883d62f9f901fa );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"consume_cosmic_fruit", &function_cbdaf3c08c739ebb );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_844bfdc392b8e4bf", &function_c201b94930a53581 );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    level thread zm_quest::start_quest( #"scarab_ww_quest" );
    level thread function_bcfca4012641b2d1();
    level.var_16044f6f91277648 = &function_4abf1501d245467d;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xa5c2c296, Offset: 0x22c9
// Size: 0xe1
function private function_a06aeda4705c91c9()
{
    var_69177fd80add24d0 = [];
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4ba1d1cd1bb1c2b2";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_6ae66c5c83397699";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_32d2373e1b41752c";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_67657baae403f0ee";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_231fa322262e59a8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_6f7e1fa445c8377b";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_293af3f2d1d2aed8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_bef8a63d95a4f6c";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_c91dccf33f096c8";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_67d2b1f066cc817a";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_5a7e09ddc2580867";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_4f0f71ac8d96f5e4";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_78c0b2feed797e35";
    var_69177fd80add24d0[ var_69177fd80add24d0.size ] = &"hash_7b0fa0f0212f910a";
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x63b3ea7c, Offset: 0x23b2
// Size: 0x1d, Type: bool
function private function_4abf1501d245467d()
{
    if ( level utility::flag( "scarab_boss_fight_start" ) )
    {
        level thread function_307d9e51207cd55();
        return true;
    }
    
    return false;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x5c65bfa8, Offset: 0x23d8
// Size: 0x9b
function private function_307d9e51207cd55()
{
    level endon( #"game_ended" );
    waitframe();
    
    if ( level.scarab_ww_quest.wonder_weapon_item )
    {
        common_item::function_869d7676e359a627( level.scarab_ww_quest.wonder_weapon_item );
        
        if ( level.scarab_ww_quest.var_fcfa76ff6800ca09 )
        {
            level.scarab_ww_quest.var_fcfa76ff6800ca09 freescriptable();
        }
        
        if ( level.scarab_ww_quest.var_85acab423ceb4b1c )
        {
            level.scarab_ww_quest.var_85acab423ceb4b1c delete();
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x3fce83c7, Offset: 0x247b
// Size: 0x1e2
function private function_4653caeb29695dbd()
{
    var_9906360c72d1403b = [ [ "fireflyww_first_obtain", #"gauntlet_bond", 100, -1, 0.5 ], [ "fireflyww_pap", #"gauntlet_pack", 100, -1, 0.5 ], [ "fireflyww_life_steal", #"hash_905ffd2d1f502b49", 15, 60, 0 ], [ "fireflyww_spike_shot", #"hash_30023e7f505d844f", 15, 60, 0 ], [ "fireflyww_spike_recall", #"hash_ab298c512cb55a0a", 15, 60, 0 ], [ "fireflyww_melee_kill", #"gauntlet_melee_kill", 15, 60, 0.1 ], [ "fireflyww_overload", #"hash_42fc53e825abf4a1", 15, 60, 0 ] ];
    
    foreach ( event in var_9906360c72d1403b )
    {
        utility::callsharedfunc( #"weap_fireflyww", #"register_vo_event", event[ 0 ], event[ 1 ], event[ 2 ], event[ 3 ], event[ 4 ] );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 3, eflags: 0x4
// Checksum 0xa311e25c, Offset: 0x2665
// Size: 0x81
function private function_c99b85fe440b3386( str_ent_flag, var_8984c1f1eeea88ec, var_1c360473c4174a43 )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( utility::ent_flag( str_ent_flag ) )
    {
        return;
    }
    
    utility::ent_flag_set( str_ent_flag );
    function_e7337c56375cb30e( var_8984c1f1eeea88ec, var_1c360473c4174a43 );
    
    if ( var_8984c1f1eeea88ec == "scarab_scw2_pick_up_ww" )
    {
        level utility::flag_set( "scarab_mq_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_8ee6241d5996181f" ] );
        level utility::flag_clear( "scarab_mq_vo_playing" );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xb5abd4db, Offset: 0x26ee
// Size: 0x4f
function private function_e7337c56375cb30e( var_8984c1f1eeea88ec, var_1c360473c4174a43 )
{
    if ( overlord::function_dce0a14273dfa0a8( [ self ] ) )
    {
        zm_quest::function_8934bb2a9028bdc5();
    }
    
    level utility::flag_set( "scarab_mq_vo_playing" );
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec, var_1c360473c4174a43 );
    level utility::flag_clear( "scarab_mq_vo_playing" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x901bdbb6, Offset: 0x2745
// Size: 0x68
function private function_bfe16b53d76d31ef( str_conversation_ref )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    level utility::flag_set( "skip_powerup_vo" );
    level utility::flag_set( "scarab_mq_vo_playing" );
    overlord::function_e155a19c69aed191( [ self ] );
    overlord::playconversation( str_conversation_ref, [ self ], undefined, 0 );
    level utility::flag_clear( "scarab_mq_vo_playing" );
    level utility::flag_clear( "skip_powerup_vo" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x24ef5153, Offset: 0x27b5
// Size: 0x22
function private function_a8bd48519db5348f( str_conversation_ref )
{
    var_f3c2cb9bfb0d23f8 = overlord::function_e4b6b75b01ea6bc9( str_conversation_ref );
    return var_f3c2cb9bfb0d23f8;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xd13a452c, Offset: 0x27e0
// Size: 0x6e
function private function_7a13add61dfda98c( n_solution_index )
{
    switch ( n_solution_index )
    {
        case 1:
            return #"hash_283ecf77f76e8c1";
        case 2:
            return #"hash_283e9f77f76e3a8";
        case 3:
            return #"hash_283eaf77f76e55b";
        case 4:
            return #"hash_283eff77f76edda";
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xe5c84ae9, Offset: 0x2857
// Size: 0xfb
function private function_9bffb7317fa4df73( v_origin, str_zone_substring )
{
    var_f43eb6e734c44585 = [];
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || !player namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            continue;
        }
        
        zone = player zone_manager::get_current_zone();
        
        if ( !zone.zone_name || !issubstr( zone.zone_name, str_zone_substring ) )
        {
            continue;
        }
        
        var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
    }
    
    if ( var_f43eb6e734c44585.size <= 0 )
    {
        return;
    }
    
    return function_47c86977a18df38b( var_f43eb6e734c44585, v_origin );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x8508b813, Offset: 0x295b
// Size: 0xd7
function private function_8676888e7913c7a( str_zone_substring )
{
    var_f43eb6e734c44585 = [];
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        zone = player zone_manager::get_current_zone();
        
        if ( !zone.zone_name || !issubstr( zone.zone_name, str_zone_substring ) )
        {
            continue;
        }
        
        var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
    }
    
    return var_f43eb6e734c44585;
}

// Namespace zm_sat_scarab_ww_quest
// Params 4, eflags: 0x4
// Checksum 0x597dbb74, Offset: 0x2a3b
// Size: 0x19f
function private function_1ee83ba3397514ac( v_origin, n_radius, var_efad73166eceaea8 = 0, var_38d2e6cd6f6138a5 = undefined )
{
    a_players = getplayersinradius( v_origin, n_radius );
    var_f43eb6e734c44585 = [];
    
    if ( var_efad73166eceaea8 )
    {
        foreach ( player in a_players )
        {
            if ( !isalive( player ) || !player namespace_c0b4f2882c9d100f::is_hero_operator() )
            {
                continue;
            }
            
            if ( var_38d2e6cd6f6138a5 && player utility::ent_flag( var_38d2e6cd6f6138a5 ) )
            {
                continue;
            }
            
            var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
        }
        
        if ( var_f43eb6e734c44585.size > 0 )
        {
            return function_47c86977a18df38b( var_f43eb6e734c44585, v_origin );
        }
    }
    
    foreach ( player in a_players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( var_38d2e6cd6f6138a5 && player utility::ent_flag( var_38d2e6cd6f6138a5 ) )
        {
            continue;
        }
        
        var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
    }
    
    if ( var_f43eb6e734c44585.size <= 0 )
    {
        return;
    }
    
    return function_47c86977a18df38b( var_f43eb6e734c44585, v_origin );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0xc
// Checksum 0x47ab310f, Offset: 0x2be3
// Size: 0x121
function private function_bcfca4012641b2d1()
{
    self notify( #"hash_27869f40e0e70096" );
    self endon( #"hash_27869f40e0e70096" );
    pap_quest = zm_quest::get_quest( #"scarab_pap_quest" );
    
    if ( !pap_quest.completed )
    {
        pap_quest utility::ent_flag_wait( "zm_quest_completed" );
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread function_51f12524c830dd09();
        level thread function_40345848c048faea();
        level thread function_dc3081884c688758();
        level thread function_2dea72aa54f2ffad();
        level callback::add( #"hash_78694f61c22b5057", &function_24dddce9e88daecd );
        level callback::add( #"hash_9595b4413b1af76a", &function_1b7607d1b0d72e20 );
        level callback::add( "on_round_end", &function_ca976a8ff3827f9 );
        level callback::add( #"player_connect", &function_c759ffc24bf0e3f5 );
        level callback::add( #"player_spawned", &function_f2fb98e01bba2de7 );
        level.scarab_ww_quest.anvil setscriptablepartstate( "ping", "on" );
        
        if ( level zm_save::function_1dda3554974a999e() )
        {
            level utility::delaythread( 5, &function_51f12524c830dd09 );
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x6fa8f217, Offset: 0x2d0c
// Size: 0x78
function private init_wwq_assets()
{
    namespace_ed38d631807ab6b0::function_8b6ed56c2aa29c10( [ "zone_ee_ashwoods" ] );
    level function_5eac1fb1b94607b2();
    level function_75d35f53ad0d3b1b();
    level setup_vine_assets();
    level setup_riddle_assets();
    level setup_anvil_assets();
    level function_57491b97a051f563();
    level callback::add( "quest_item_used", &function_f710905c8115ad02 );
    level callback::add( #"player_item_pickup", &function_e7058ea1476170a );
    level utility::flag_set( "WWQ_ASSET_INIT_COMPLETE" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x7831af72, Offset: 0x2d8c
// Size: 0x61
function private function_5eac1fb1b94607b2()
{
    s_cracks = utility::getstruct( "za_c", "targetname" );
    level.scarab_ww_quest.var_8df3ff996389aaf = spawnscriptable( %"hash_7913bfcaf7cfe5e6", s_cracks.origin, s_cracks.angles );
    scriptable::scriptable_adddamagedcallback( &function_3b22980b58479a55 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x66980ae3, Offset: 0x2df5
// Size: 0x555
function private function_75d35f53ad0d3b1b()
{
    level.scarab_ww_quest.var_52b66e82f17fb84b = getent( "se_temple_1_eye", #targetname );
    level callback::add( "usurped_power_land", &function_173ee6a5e79f6d13 );
    level.scarab_ww_quest.var_cbf76ab35c7fe9cc = utility::getstruct( "uf_l_start", "targetname" );
    level.scarab_ww_quest.var_53fe245e95326ece = [];
    level.scarab_ww_quest.var_78eb700b3b1389dd = [];
    level.scarab_ww_quest.var_81bf0f82e9711035 = [];
    level.scarab_ww_quest.var_1ca5d39930b4e717 = [];
    level callback::add( #"hash_db23ebf23acc8885", &function_e877a930391f3498 );
    s_prism = utility::getstruct( "nm_p", "targetname" );
    first_prism = spawnscriptable( %"hash_1afbc4eea83ff1e1", s_prism.origin, s_prism.angles, undefined, function_67b78af3c33ac9a8( 1.25 ) );
    first_prism.var_68e1ed47045d49b4 = utility::spawn_model( %"hash_1c5bcc5b65c82ced", s_prism.origin, s_prism.angles, undefined, 1.25 );
    first_prism.var_68e1ed47045d49b4.var_aae9ba29786e9ca7 = first_prism;
    function_fc1d21400c23e656( first_prism );
    first_prism.base = spawnscriptable( %"hash_5a8be7c27edb65ca", s_prism.origin, s_prism.angles, undefined, function_67b78af3c33ac9a8( 1.25 ) );
    first_prism.n_index = 0;
    first_prism.var_15f69f103ace73b8 = 0;
    first_prism.a_spawn_angles = s_prism.angles;
    first_prism.var_b0c37265004d7765 = first_prism.base.origin + anglestoforward( first_prism.base.angles ) * 17;
    clip = utility::spawn_model( %"player32x32x256", first_prism.var_68e1ed47045d49b4.origin + anglestoforward( first_prism.var_68e1ed47045d49b4.angles ) * 15 + ( 0, 0, -10 ) );
    
    if ( s_prism.script_noteworthy )
    {
        first_prism.n_angle_override = int( s_prism.script_noteworthy );
    }
    
    level.scarab_ww_quest.var_53fe245e95326ece[ level.scarab_ww_quest.var_53fe245e95326ece.size ] = first_prism;
    level.scarab_ww_quest.var_81bf0f82e9711035[ level.scarab_ww_quest.var_81bf0f82e9711035.size ] = first_prism;
    n_index = 1;
    
    while ( s_prism.target )
    {
        if ( s_prism.target == "l_p_1" )
        {
            var_aae9ba29786e9ca7 = function_2791d963ed975d90( s_prism.target, 1 );
            var_aae9ba29786e9ca7 setscriptablepartstate( "body", "hide" );
            var_aae9ba29786e9ca7.base.var_8098fcc8bbc03090 = 1;
            var_aae9ba29786e9ca7.var_8098fcc8bbc03090 = 1;
            var_aae9ba29786e9ca7.var_6db487922ef2b46b = 1;
            level.scarab_ww_quest.var_1ca5d39930b4e717[ 1 ] = var_aae9ba29786e9ca7;
            level.scarab_ww_quest.var_6f55c13e5e9e6f05 = var_aae9ba29786e9ca7;
        }
        else
        {
            var_aae9ba29786e9ca7 = function_2791d963ed975d90( s_prism.target );
        }
        
        if ( n_index == 6 )
        {
            clip = utility::spawn_model( %"player32x32x256", var_aae9ba29786e9ca7.var_68e1ed47045d49b4.origin + anglestoforward( var_aae9ba29786e9ca7.var_68e1ed47045d49b4.angles ) * 15 + ( 0, 0, 220 ) );
        }
        
        level.scarab_ww_quest.var_53fe245e95326ece[ level.scarab_ww_quest.var_53fe245e95326ece.size ] = var_aae9ba29786e9ca7;
        var_aae9ba29786e9ca7.n_index = n_index;
        n_index++;
        s_prism = utility::getstruct( s_prism.target, "targetname" );
    }
    
    function_2b1c3b51647f266f( "l_p_2", 1, 2 );
    function_2b1c3b51647f266f( "l_p_3", 1, 3 );
    var_db8d0ce5e5e68b48 = utility::getstruct( "jr_l_r", "targetname" );
    level.scarab_ww_quest.var_cb14f2d5f5de60dc = var_db8d0ce5e5e68b48;
    level.scarab_ww_quest.var_493139418f5e8ea3 = [ 1, -1, 0, 1, 0, 0, -1 ];
    
    if ( !isdefined( level.scarab_ww_quest.var_c868582099fef2aa ) )
    {
        level.scarab_ww_quest.var_c868582099fef2aa = throttle::throttle_initialize( "wwq_light_prism_puzzle", 1 );
    }
    
    level function_b74ce1f5c7231e91();
    
    if ( level zm_save::function_1dda3554974a999e() )
    {
        level thread function_2ebe3ed6161d628c();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 3, eflags: 0x4
// Checksum 0xed6dd54c, Offset: 0x3352
// Size: 0xc1
function private function_2b1c3b51647f266f( struct_targetname, b_register_interact = 0, var_6db487922ef2b46b = 0 )
{
    s_spawn_struct = utility::getstruct( struct_targetname, "targetname" );
    var_aae9ba29786e9ca7 = function_2791d963ed975d90( struct_targetname, b_register_interact );
    var_aae9ba29786e9ca7 setscriptablepartstate( "body", "hide" );
    var_aae9ba29786e9ca7.var_6db487922ef2b46b = var_6db487922ef2b46b;
    var_aae9ba29786e9ca7.var_c2df640d7f1fb7d2 = 1;
    var_aae9ba29786e9ca7.var_358a306b533efabd = utility::getstruct( s_spawn_struct.target, "targetname" );
    level.scarab_ww_quest.var_1ca5d39930b4e717[ var_6db487922ef2b46b ] = var_aae9ba29786e9ca7;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xdc76121b, Offset: 0x341b
// Size: 0xd6
function private function_fc1d21400c23e656( var_aae9ba29786e9ca7 )
{
    tag_origin = var_aae9ba29786e9ca7.var_68e1ed47045d49b4 gettagorigin( "j_paw" );
    tag_angles = var_aae9ba29786e9ca7.var_68e1ed47045d49b4 gettagangles( "j_paw" );
    local_origin = rotatevectorinverted( tag_origin - var_aae9ba29786e9ca7.var_68e1ed47045d49b4.origin, var_aae9ba29786e9ca7.var_68e1ed47045d49b4.angles );
    local_angles = combineanglesinverted( var_aae9ba29786e9ca7.var_68e1ed47045d49b4.angles, tag_angles );
    var_aae9ba29786e9ca7 utility::scriptable_setparententity( var_aae9ba29786e9ca7.var_68e1ed47045d49b4, local_origin, local_angles );
    var_aae9ba29786e9ca7.var_68e1ed47045d49b4 scriptmodelplayanim( "sat_fxanim_zm_prism_closed" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xdb318f3c, Offset: 0x34f9
// Size: 0x2e0
function private function_2791d963ed975d90( targetname, b_register_interact = 0 )
{
    s_prism = utility::getstruct( targetname, "targetname" );
    var_aae9ba29786e9ca7 = spawnscriptable( %"hash_1afbc4eea83ff1e1", s_prism.origin, s_prism.angles, undefined, function_67b78af3c33ac9a8( 1.25 ) );
    var_aae9ba29786e9ca7.var_68e1ed47045d49b4 = utility::spawn_model( %"hash_1c5bcc5b65c82ced", s_prism.origin, s_prism.angles, undefined, 1.25 );
    var_aae9ba29786e9ca7.var_68e1ed47045d49b4.var_aae9ba29786e9ca7 = var_aae9ba29786e9ca7;
    clip = utility::spawn_model( %"player32x32x256", var_aae9ba29786e9ca7.var_68e1ed47045d49b4.origin + anglestoforward( var_aae9ba29786e9ca7.var_68e1ed47045d49b4.angles ) * 15 + ( 0, 0, -10 ) );
    function_fc1d21400c23e656( var_aae9ba29786e9ca7 );
    base = spawnscriptable( %"hash_5a8be7c27edb65ca", s_prism.origin, s_prism.angles, undefined, function_67b78af3c33ac9a8( 1.25 ) );
    base.var_aae9ba29786e9ca7 = var_aae9ba29786e9ca7;
    var_aae9ba29786e9ca7.base = base;
    var_aae9ba29786e9ca7.var_b0c37265004d7765 = var_aae9ba29786e9ca7.base.origin + anglestoforward( var_aae9ba29786e9ca7.base.angles ) * 17;
    var_aae9ba29786e9ca7.var_15f69f103ace73b8 = 0;
    var_aae9ba29786e9ca7.a_spawn_angles = s_prism.angles;
    
    if ( s_prism.target2 )
    {
        var_aae9ba29786e9ca7.var_ae1ce70a6b469c3d = utility::getstruct( s_prism.target2, "targetname" ).origin;
    }
    
    if ( s_prism.script_noteworthy )
    {
        var_aae9ba29786e9ca7.n_angle_override = int( s_prism.script_noteworthy );
    }
    
    if ( b_register_interact )
    {
        base.interaction = interaction::register_scriptable_interact( base, &function_d8ed6b2eabd4a4c1, undefined, undefined, &function_631358516a5bce28 );
        base.interaction.parent = base;
        level.scarab_ww_quest.var_78eb700b3b1389dd[ level.scarab_ww_quest.var_78eb700b3b1389dd.size ] = base;
        var_aae9ba29786e9ca7.var_68e1ed47045d49b4 scriptmodelplayanim( "sat_fxanim_zm_prism_open" );
    }
    
    level.scarab_ww_quest.var_81bf0f82e9711035[ level.scarab_ww_quest.var_81bf0f82e9711035.size ] = var_aae9ba29786e9ca7;
    return var_aae9ba29786e9ca7;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x241aa552, Offset: 0x37e2
// Size: 0x1c5
function private function_2ebe3ed6161d628c()
{
    level zm_save::function_1f44a48caae2acbf();
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"hash_a01291f4885b13cd" ) )
    {
        level function_3daea56851c5d51( 1, 1 );
    }
    
    var_128e007e28d8b8a5 = zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"hash_a629154ffa415ea1" );
    
    if ( var_128e007e28d8b8a5 )
    {
        switch ( var_128e007e28d8b8a5 )
        {
            case 1:
                base = level.scarab_ww_quest.var_1ca5d39930b4e717[ 1 ].base;
                base function_496aae1ac602fdeb();
                break;
            case 2:
                base = level.scarab_ww_quest.var_1ca5d39930b4e717[ 2 ].base;
                base function_496aae1ac602fdeb();
                break;
            case 3:
                base = level.scarab_ww_quest.var_1ca5d39930b4e717[ 3 ].base;
                base function_496aae1ac602fdeb();
                break;
        }
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"hash_ce2ffcbee30d6f60" ) )
    {
        var_7717e66319263994 = getentarray( "doorbuy_door_sw_temple_underground_exit", #targetname );
        
        foreach ( door in var_7717e66319263994 )
        {
            door thread doorbuy::doorbuy_used( undefined, undefined, 1 );
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xac8694c1, Offset: 0x39af
// Size: 0x18c
function private setup_vine_assets()
{
    s_center_vine = utility::getstruct( "n_c_v", "targetname" );
    level.scarab_ww_quest.center_vine = spawnscriptable( %"hash_1533a771a453d6bb", s_center_vine.origin, s_center_vine.angles );
    level.scarab_ww_quest.var_fa1360bbeab603e7 = spawnscriptable( %"hash_29cdbd46e2992da7", s_center_vine.origin, s_center_vine.angles );
    level.scarab_ww_quest.center_vine.var_12aadf5d8bbfdafd = createnavobstaclebybounds( s_center_vine.origin, ( 25, 25, 100 ), s_center_vine.angles );
    temp_vines = utility::spawn_model( %"hash_cfb603b4d934b33", s_center_vine.origin, s_center_vine.angles );
    level.scarab_ww_quest.fruit_spawn_origin = temp_vines gettagorigin( "tag_fruit" );
    level.scarab_ww_quest.fruit_spawn_angles = temp_vines gettagangles( "tag_fruit" );
    level.scarab_ww_quest.fruit_fx = spawnscriptable( %"hash_7e492987e52d3c55", level.scarab_ww_quest.fruit_spawn_origin, level.scarab_ww_quest.fruit_spawn_angles );
    temp_vines delete();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x33130a19, Offset: 0x3b43
// Size: 0x2e
function private save_load_cosmic_fruit()
{
    level zm_save::function_1f44a48caae2acbf();
    
    if ( !zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"hash_4bcd57abae316a12" ) )
    {
        level spawn_cosmic_fruit();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xe604d6c0, Offset: 0x3b79
// Size: 0x112
function private function_71d4540241921869( var_6fb860f7c9723d4e )
{
    level utility::flag_wait( "ammo_caches_initialized" );
    level utility::flag_wait( "zone_setup_finished" );
    var_b663fc67159f514d = var_6fb860f7c9723d4e ? "active" : "disable";
    
    foreach ( s_ammo_cache in level._ammo_cache_info.var_ea07e36d8fd28578 )
    {
        ammo_cache = s_ammo_cache.ammocache_trigger.var_a3338cc37b82b7b3;
        
        if ( zone_manager::function_427ae6b3bc10b5ac( ammo_cache.origin, "zone_ne_temple_sideroom" ) )
        {
            ammo_cache utility::ent_flag_wait( "minimap_floor_setup_complete" );
            ammo_cache utility::function_7c10ea82c1e305b8( "icon", var_b663fc67159f514d );
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x65fd3deb, Offset: 0x3c93
// Size: 0x8cd
function private setup_riddle_assets()
{
    level thread function_71d4540241921869( 0 );
    level.scarab_ww_quest.var_53d2453af4d1d4bf = [];
    var_29c017a8d2bb94d4 = utility::getstructarray( "vn_r_s", "targetname" );
    
    foreach ( s_sconce in var_29c017a8d2bb94d4 )
    {
        if ( int( s_sconce.script_noteworthy ) == 4 )
        {
            sconce = spawnscriptable( %"hash_4e5646fa83248a1a", s_sconce.origin, s_sconce.angles );
            sconce.handle = spawnscriptable( %"hash_bb577fe849ca21a", s_sconce.origin, s_sconce.angles );
            sconce.handle setscriptablepartstate( "body", "retract" );
            sconce.n_index = int( s_sconce.script_noteworthy );
            level.scarab_ww_quest.var_1ea0b28c0ef8cc7f = sconce;
            continue;
        }
        
        sconce = spawnscriptable( %"hash_4e5646fa83248a1a", s_sconce.origin, s_sconce.angles );
        level.scarab_ww_quest.var_53d2453af4d1d4bf[ int( s_sconce.script_noteworthy ) ] = sconce;
        sconce.handle = spawnscriptable( %"hash_bb577fe849ca21a", s_sconce.origin, s_sconce.angles );
        sconce.n_index = int( s_sconce.script_noteworthy );
        sconce.handle setscriptablepartstate( "body", "retract" );
    }
    
    level.scarab_ww_quest.var_daae8a1d00edada6 = [];
    a_pillars = getentarray( "me_pillar", #targetname );
    
    foreach ( var_7e7ca0a63d1d515e in a_pillars )
    {
        if ( int( var_7e7ca0a63d1d515e.script_noteworthy ) == 5 )
        {
            var_7e7ca0a63d1d515e.n_index = int( var_7e7ca0a63d1d515e.script_noteworthy );
            var_7e7ca0a63d1d515e.original_angles = var_7e7ca0a63d1d515e.angles;
            var_7e7ca0a63d1d515e.fx_top = spawnscriptable( %"hash_1e4de21471b0e433", var_7e7ca0a63d1d515e.origin + ( 0, 0, 464 ), var_7e7ca0a63d1d515e.angles );
            var_92a48741aa2c2efa = var_7e7ca0a63d1d515e.fx_top.origin - var_7e7ca0a63d1d515e.origin;
            var_6c094a3ff81efdba = var_7e7ca0a63d1d515e.fx_top.angles - var_7e7ca0a63d1d515e.angles;
            var_7e7ca0a63d1d515e.fx_top utility::scriptable_setparententity( var_7e7ca0a63d1d515e, var_92a48741aa2c2efa, var_6c094a3ff81efdba );
            var_7e7ca0a63d1d515e.fx_bottom = spawnscriptable( %"hash_1e4de21471b0e433", var_7e7ca0a63d1d515e.origin + ( 0, 0, 12 ), var_7e7ca0a63d1d515e.angles );
            level.scarab_ww_quest.middle_pillar = var_7e7ca0a63d1d515e;
            level.scarab_ww_quest.middle_pillar.var_12aadf5d8bbfdafd = createnavobstaclebybounds( var_7e7ca0a63d1d515e.origin, ( 40, 40, 120 ), var_7e7ca0a63d1d515e.angles );
            level.scarab_ww_quest.var_cf7bec2424e2cfc5 = getent( "qo_pillar_platform_clip", #targetname );
            level.scarab_ww_quest.middle_pillar.var_79e17c7d9b7ed858 = getentarray( "ri_pillar_cylinder", #targetname );
            level.scarab_ww_quest.middle_pillar_platform = getent( "sv_pillar_platform", #targetname );
            level.scarab_ww_quest.var_13e0e7b9a12e6637 = getent( "script_brushmodel_pillar_clip", #targetname );
            level.scarab_ww_quest.var_13e0e7b9a12e6637 linkto( var_7e7ca0a63d1d515e );
            continue;
        }
        
        var_7e7ca0a63d1d515e.n_index = int( var_7e7ca0a63d1d515e.script_noteworthy );
        var_7e7ca0a63d1d515e.original_angles = var_7e7ca0a63d1d515e.angles;
        var_7e7ca0a63d1d515e.fx_top = spawnscriptable( %"hash_1e4de21471b0e433", var_7e7ca0a63d1d515e.origin + ( 0, 0, 128 ), var_7e7ca0a63d1d515e.angles );
        var_7e7ca0a63d1d515e.fx_bottom = spawnscriptable( %"hash_1e4de21471b0e433", var_7e7ca0a63d1d515e.origin, var_7e7ca0a63d1d515e.angles );
        level.scarab_ww_quest.var_daae8a1d00edada6[ var_7e7ca0a63d1d515e.n_index ] = var_7e7ca0a63d1d515e;
        
        switch ( var_7e7ca0a63d1d515e.n_index )
        {
            case 1:
                var_7e7ca0a63d1d515e.var_da2421e332e781c4 = "south";
                var_7e7ca0a63d1d515e.var_5a1c348306d6ea19 = "south";
                break;
            case 2:
                var_7e7ca0a63d1d515e.var_da2421e332e781c4 = "west";
                var_7e7ca0a63d1d515e.var_5a1c348306d6ea19 = "west";
                break;
            case 3:
                var_7e7ca0a63d1d515e.var_da2421e332e781c4 = "east";
                var_7e7ca0a63d1d515e.var_5a1c348306d6ea19 = "east";
                break;
            case 4:
                var_7e7ca0a63d1d515e.var_da2421e332e781c4 = "north";
                var_7e7ca0a63d1d515e.var_5a1c348306d6ea19 = "north";
                break;
            default:
                break;
        }
    }
    
    level.scarab_ww_quest.var_54c01efdbeed8e49 = [];
    var_b807d24463881d7f = utility::getstructarray( "w_t_s", "targetname" );
    
    foreach ( var_dd72607ca07c871c in var_b807d24463881d7f )
    {
        symbol = spawnscriptable( %"hash_15c473487130d53e", var_dd72607ca07c871c.origin, var_dd72607ca07c871c.angles, undefined, function_67b78af3c33ac9a8( function_fbdb53076873304e( int( var_dd72607ca07c871c.script_noteworthy ) ) ) );
        symbol setscriptablepartstate( "body", var_dd72607ca07c871c.script_noteworthy );
        symbol.var_9f1e0f1b4a81472a = int( var_dd72607ca07c871c.script_noteworthy ) == 4 ? 425 : 225;
        level.scarab_ww_quest.var_54c01efdbeed8e49[ level.scarab_ww_quest.var_54c01efdbeed8e49.size ] = symbol;
        
        /#
            switch ( int( var_dd72607ca07c871c.script_noteworthy ) )
            {
                case 1:
                    symbol.debug_text = "<dev string:x24>";
                    break;
                case 2:
                    symbol.debug_text = "<dev string:x33>";
                    break;
                case 3:
                    symbol.debug_text = "<dev string:x40>";
                    break;
                case 4:
                    symbol.debug_text = "<dev string:x4d>";
                    break;
                default:
                    break;
            }
            
            level thread debug_print_text( symbol.origin + ( 0, 0, 10 ), symbol.debug_text );
        #/
    }
    
    level thread function_1fa0eaac09be7b86();
    
    if ( level zm_save::function_1dda3554974a999e() )
    {
        level thread function_7913b6c6f6b96ab1();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xdde7fdc, Offset: 0x4568
// Size: 0x6a
function private function_fbdb53076873304e( n_symbol_index )
{
    switch ( n_symbol_index )
    {
        case 1:
            return 3.5;
        case 2:
            return 4;
        case 3:
            return 4;
        case 4:
            return 2.8;
        default:
            return 3.5;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xe351416, Offset: 0x45da
// Size: 0x17
function private function_1fa0eaac09be7b86()
{
    level utility::flag_wait( "power_on" );
    level function_d1cd9bbbd97e2455();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xe7b88e5e, Offset: 0x45f9
// Size: 0x65
function private function_7913b6c6f6b96ab1()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "w_r_e_hollow" );
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"riddle_solved" ) )
    {
        level function_5809d36b4d695bb3( 1 );
        return;
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"riddle_failed" ) )
    {
        level function_b575ed6a4a924834( undefined, 1 );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x3a9f5f8c, Offset: 0x4666
// Size: 0x434
function private function_3884f55eec09766f()
{
    level.scarab_ww_quest.var_3be0b45c14e1e745 = [];
    a_s_corpses = utility::getstructarray( "a_p_c", "targetname" );
    
    foreach ( s_corpse in a_s_corpses )
    {
        corpse = spawnscriptable( %"hash_5b9daca962addae6", s_corpse.origin, s_corpse.angles );
        level.scarab_ww_quest.var_3be0b45c14e1e745[ level.scarab_ww_quest.var_3be0b45c14e1e745.size ] = corpse;
        
        if ( s_corpse.script_noteworthy == "corpse_rifle" )
        {
            level.scarab_ww_quest.soldier_corpse = corpse;
        }
        
        corpse setscriptablepartstate( "body", s_corpse.script_noteworthy );
    }
    
    s_rifle = utility::getstruct( "wk_part_r", "targetname" );
    level.scarab_ww_quest.rifle_item = function_790454e66cc6d12c( %"hash_54ad35f2b304126c", s_rifle.origin, s_rifle.angles );
    level.scarab_ww_quest.rifle_item setscriptablepartstate( "zmloot_scarab_ry_part_r", "unusable_with_fx" );
    level.scarab_ww_quest.rifle_nav_obstacle = createnavobstaclebybounds( level.scarab_ww_quest.rifle_item.origin, ( 30, 30, 75 ), level.scarab_ww_quest.rifle_item.angles );
    s_floor_board = utility::getstruct( "kr_a_p_f_b", "targetname" );
    level.scarab_ww_quest.floor_board = spawnscriptable( %"hash_3ddda2b979eeff2e", s_floor_board.origin, s_floor_board.angles );
    level.scarab_ww_quest.var_77500ecd839e52e4 = getent( "jm_a_p_f_trig", #targetname );
    s_bow = utility::getstruct( "ty_part_b", "targetname" );
    level.scarab_ww_quest.bow_item = function_790454e66cc6d12c( %"hash_6842c9ae8635ff95", s_bow.origin, s_bow.angles );
    level.scarab_ww_quest.bow_item setscriptablepartstate( "zmloot_scarab_bx_part_b", "unusable_with_fx" );
    level.scarab_ww_quest.bow_nav_obstacle = createnavobstaclebybounds( level.scarab_ww_quest.bow_item.origin + ( 0, 25, 0 ), ( 30, 35, 75 ), level.scarab_ww_quest.bow_item.angles );
    var_d414a19647759d21 = utility::getstruct( "az_part_s", "targetname" );
    level.scarab_ww_quest.string_item = function_790454e66cc6d12c( %"hash_2c474f8228e87f25", var_d414a19647759d21.origin, var_d414a19647759d21.angles );
    level.scarab_ww_quest.string_item setscriptablepartstate( "zmloot_scarab_st_part_s", "unusable_with_fx" );
    level.scarab_ww_quest.string_nav_obstacle = createnavobstaclebybounds( level.scarab_ww_quest.string_item.origin, ( 45, 45, 75 ), level.scarab_ww_quest.string_item.angles );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x6d10ce99, Offset: 0x4aa2
// Size: 0x120
function private setup_anvil_assets()
{
    s_anvil = utility::getstruct( "bx_d_a", "targetname" );
    level.scarab_ww_quest.anvil = spawnscriptable( %"hash_7337169b493df71f", s_anvil.origin, s_anvil.angles );
    level.scarab_ww_quest.anvil.var_12aadf5d8bbfdafd = createnavobstaclebybounds( level.scarab_ww_quest.anvil.origin, ( 20, 35, 75 ), level.scarab_ww_quest.anvil.angles );
    level.scarab_ww_quest.anvil.interaction = interaction::register_scriptable_interact( level.scarab_ww_quest.anvil, &function_f95bf06f1fd45e89, undefined, undefined, &anvil_hint );
    level.scarab_ww_quest.var_9bcd82f47753e4c5 = [];
    activateworldevent( "we_lgt_ww_d_a" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x5b226056, Offset: 0x4bca
// Size: 0x22
function private function_bbb2e33ada22dda0( b_skipped, b_save_restored )
{
    level utility::flag_wait( "w_s_1_c_quarry" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xd5637fc5, Offset: 0x4bf4
// Size: 0x3c
function private function_540b700231a8d9bf( b_skipped, b_save_restored )
{
    if ( b_skipped && !level.scarab_ww_quest.restarted )
    {
        level function_e825fa636fbea5c3( b_skipped );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xae91066b, Offset: 0x4c38
// Size: 0x22
function private function_bbb2e63ada22e439( b_skipped, b_save_restored )
{
    level utility::flag_wait( "w_s_2_c_harbor" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x6aad7d09, Offset: 0x4c62
// Size: 0x3a
function private function_540b710231a8dbf2( b_skipped, b_save_restored )
{
    if ( b_skipped && !level.scarab_ww_quest.restarted )
    {
        level function_bd259c94667fcfa6();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x38439731, Offset: 0x4ca4
// Size: 0xfa
function private function_bbb2e53ada22e206( b_skipped, b_save_restored )
{
    if ( level zm_quest::function_b0a5181ebe7bb905() && !level.scarab_ww_quest.restarted )
    {
        level callback::add( "usurped_power_deploying", &function_7f0a3e0bdc5ff576 );
        level callback::add( "usurped_power_removed", &function_3da47cc8a6f377a0 );
        level callback::add( "power_surge_happened", &function_313b94b67cf87ea9 );
        level callback::add( "usurped_power_land", &function_b80bbbe5b9fffb14 );
        level callback::add( #"hash_cafd4d00f2edf8b6", &function_54826b2c015d5766 );
        level callback::add( #"hash_6d92532e6d7f196d", &function_8de1852634135677 );
        level callback::add( #"hash_f6fe6e9f66f0e5f4", &function_4e05cbe30aa6bd7e );
        level callback::add( #"hash_94cf26f78221f00c", &function_f9648ac90c0e5c6e );
        level callback::add( #"hash_5c9ab8f9aa9fa81b", &function_86270d53ee610cf8 );
    }
    
    level utility::flag_wait( "southwest_nyxara_sideroom_door_opened" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xea028400, Offset: 0x4da6
// Size: 0x1c5
function private function_540b720231a8de25( b_skipped, b_save_restored )
{
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        if ( level callback::exists( "usurped_power_deploying", &function_7f0a3e0bdc5ff576 ) )
        {
            level callback::remove( "usurped_power_deploying", &function_7f0a3e0bdc5ff576 );
        }
        
        if ( level callback::exists( "usurped_power_removed", &function_3da47cc8a6f377a0 ) )
        {
            level callback::remove( "usurped_power_removed", &function_3da47cc8a6f377a0 );
        }
        
        if ( level callback::exists( "power_surge_happened", &function_313b94b67cf87ea9 ) )
        {
            level callback::remove( "power_surge_happened", &function_313b94b67cf87ea9 );
        }
        
        if ( level callback::exists( "usurped_power_land", &function_b80bbbe5b9fffb14 ) )
        {
            level callback::remove( "usurped_power_land", &function_b80bbbe5b9fffb14 );
        }
        
        if ( level callback::exists( #"hash_cafd4d00f2edf8b6", &function_54826b2c015d5766 ) )
        {
            level callback::remove( #"hash_cafd4d00f2edf8b6", &function_54826b2c015d5766 );
        }
        
        if ( level callback::exists( #"hash_6d92532e6d7f196d", &function_8de1852634135677 ) )
        {
            level callback::remove( #"hash_6d92532e6d7f196d", &function_8de1852634135677 );
        }
        
        if ( level callback::exists( #"hash_f6fe6e9f66f0e5f4", &function_4e05cbe30aa6bd7e ) )
        {
            level callback::remove( #"hash_f6fe6e9f66f0e5f4", &function_4e05cbe30aa6bd7e );
        }
        
        if ( level callback::exists( #"hash_94cf26f78221f00c", &function_f9648ac90c0e5c6e ) )
        {
            level callback::remove( #"hash_94cf26f78221f00c", &function_f9648ac90c0e5c6e );
        }
        
        if ( level callback::exists( #"hash_5c9ab8f9aa9fa81b", &function_86270d53ee610cf8 ) )
        {
            level callback::remove( #"hash_5c9ab8f9aa9fa81b", &function_86270d53ee610cf8 );
        }
    }
    
    if ( b_skipped && !level.scarab_ww_quest.restarted )
    {
        level function_3daea56851c5d51( b_skipped, b_save_restored );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x5d407b1b, Offset: 0x4f73
// Size: 0x22
function private function_bbb2e83ada22e89f( b_skipped, b_save_restored )
{
    level utility::flag_wait( "doorbuy_door_19_opened" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x904dc4b8, Offset: 0x4f9d
// Size: 0x6a
function private function_540b6b0231a8cec0( b_skipped, b_save_restored )
{
    if ( b_skipped && !level.scarab_ww_quest.restarted )
    {
        level function_927310642be72efd( b_skipped );
        
        if ( level.scarab_ww_quest.var_79fc0cd2f8572e6a )
        {
            level.scarab_ww_quest.var_79fc0cd2f8572e6a freescriptable();
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x92d776eb, Offset: 0x500f
// Size: 0x22
function private function_a6d5a3acd93970bb( b_skipped, b_save_restored )
{
    level utility::flag_wait( "WW_STEP_6_COMPLETE" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xd98843e4, Offset: 0x5039
// Size: 0x3c
function private function_6d50cebffd0fba32( b_skipped, b_save_restored )
{
    if ( b_skipped && !level.scarab_ww_quest.restarted )
    {
        level function_5809d36b4d695bb3( b_skipped );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xe89bd082, Offset: 0x507d
// Size: 0x79
function private function_bbb2e73ada22e66c( b_skipped, b_save_restored )
{
    if ( level zm_quest::function_b0a5181ebe7bb905() && !level.scarab_ww_quest.restarted )
    {
        level callback::add( #"hash_cafd4d00f2edf8b6", &function_54826b2c015d5766 );
        level callback::add( #"hash_6d92532e6d7f196d", &function_8de1852634135677 );
        level callback::add( #"hash_f6fe6e9f66f0e5f4", &function_4e05cbe30aa6bd7e );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x432a8746, Offset: 0x50fe
// Size: 0x19d
function private function_540b6c0231a8d0f3( b_skipped, b_save_restored )
{
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        if ( level callback::exists( "usurped_power_deploying", &function_7f0a3e0bdc5ff576 ) )
        {
            level callback::remove( "usurped_power_deploying", &function_7f0a3e0bdc5ff576 );
        }
        
        if ( level callback::exists( "usurped_power_removed", &function_3da47cc8a6f377a0 ) )
        {
            level callback::remove( "usurped_power_removed", &function_3da47cc8a6f377a0 );
        }
        
        if ( level callback::exists( "power_surge_happened", &function_313b94b67cf87ea9 ) )
        {
            level callback::remove( "power_surge_happened", &function_313b94b67cf87ea9 );
        }
        
        if ( level callback::exists( #"hash_94cf26f78221f00c", &function_f9648ac90c0e5c6e ) )
        {
            level callback::remove( #"hash_94cf26f78221f00c", &function_f9648ac90c0e5c6e );
        }
        
        if ( level callback::exists( #"hash_5c9ab8f9aa9fa81b", &function_86270d53ee610cf8 ) )
        {
            level callback::remove( #"hash_5c9ab8f9aa9fa81b", &function_86270d53ee610cf8 );
        }
        
        if ( level callback::exists( #"hash_cafd4d00f2edf8b6", &function_54826b2c015d5766 ) )
        {
            level callback::remove( #"hash_cafd4d00f2edf8b6", &function_54826b2c015d5766 );
        }
        
        if ( level callback::exists( #"hash_6d92532e6d7f196d", &function_8de1852634135677 ) )
        {
            level callback::remove( #"hash_6d92532e6d7f196d", &function_8de1852634135677 );
        }
        
        if ( level callback::exists( #"hash_f6fe6e9f66f0e5f4", &function_4e05cbe30aa6bd7e ) )
        {
            level callback::remove( #"hash_f6fe6e9f66f0e5f4", &function_4e05cbe30aa6bd7e );
        }
        
        if ( level callback::exists( "usurped_power_land", &function_b80bbbe5b9fffb14 ) )
        {
            level callback::remove( "usurped_power_land", &function_b80bbbe5b9fffb14 );
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xfe8435bd, Offset: 0x52a3
// Size: 0x70
function private function_87a59f9ae151af34( b_skipped, b_save_restored )
{
    if ( level zm_quest::function_b0a5181ebe7bb905() && !level.scarab_ww_quest.restarted )
    {
        level callback::add( #"hash_94cf26f78221f00c", &function_f9648ac90c0e5c6e );
        level callback::add( #"hash_5c9ab8f9aa9fa81b", &function_86270d53ee610cf8 );
    }
    
    level utility::flag_wait( "w_p_d_a_orchid" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xbb382747, Offset: 0x531b
// Size: 0x15
function private function_24646aabe49ddfd1( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x39545f83, Offset: 0x5338
// Size: 0x22
function private function_87a5a29ae151b5cd( b_skipped, b_save_restored )
{
    level utility::flag_wait( "w_s_9_c_spruce" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x3789e569, Offset: 0x5362
// Size: 0x25
function private function_246467abe49dd938( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level function_fbed4d5a0a9b7cfe( b_skipped, b_save_restored );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x17ba5063, Offset: 0x538f
// Size: 0x6e
function private function_f4d4eb4e212a6fb( b_skipped, b_save_restored )
{
    if ( !b_save_restored && zm_save::function_1dda3554974a999e() )
    {
        var_3c35d5bd581440d9 = level zm_quest::function_b0a5181ebe7bb905() ? 7 : 8;
        curr_round = zm_utility::get_round_number();
        
        if ( curr_round >= var_3c35d5bd581440d9 )
        {
            level thread save_load_cosmic_fruit();
        }
    }
    
    level utility::flag_wait( "w_f_s_f_t_zephyr" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x926fddde, Offset: 0x5405
// Size: 0x36
function private function_e69d4cd33de6ff30( b_skipped, b_save_restored )
{
    if ( b_skipped && !b_save_restored )
    {
        level spawn_cosmic_fruit();
    }
    
    if ( b_save_restored )
    {
        level thread save_load_cosmic_fruit();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x5e5b89f5, Offset: 0x5443
// Size: 0x15
function private function_bbb2ea3ada22ed05( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x12a0558a, Offset: 0x5460
// Size: 0x101
function private function_540b6d0231a8d326( b_skipped, b_save_restored )
{
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level thread zm_quest::update_round_cap( 10 );
    
    foreach ( player in level.players )
    {
        player zm_quest::function_fb3af5600f6a9441( 0, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f8bc493a69be44cb" );
        player zm_quest::function_fba942a1cfd85f5d( 0, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f8bc493a69be44cb" );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x27e0ea6a, Offset: 0x5569
// Size: 0x22
function private function_cdcabca54057c398( b_skipped, b_save_restored )
{
    level utility::flag_wait( "w_s_10_p_1_c_comet" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xaddfc1a0, Offset: 0x5593
// Size: 0x25
function private function_91218db8dcfb3953( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level function_d331253ff802b0eb( undefined, b_skipped );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x74b0cd6f, Offset: 0x55c0
// Size: 0x22
function private function_b462a3ce6472f572( b_skipped, b_save_restored )
{
    level utility::flag_wait( "w_s_10_p_2_c_marble" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xb2c37c24, Offset: 0x55ea
// Size: 0x25
function private function_d920e5eb1bb28351( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level function_c4220f02160f9859( undefined, b_skipped );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xf77219c2, Offset: 0x5617
// Size: 0x22
function private function_54a2292b4c4c49df( b_skipped, b_save_restored )
{
    level utility::flag_wait( "w_s_10_p_3_c_cinder" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xf72191b9, Offset: 0x5641
// Size: 0x53
function private function_d7410a937702b5be( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level function_64e56807b3040e46( undefined, b_skipped );
        
        if ( level.scarab_ww_quest.var_77500ecd839e52e4 )
        {
            level.scarab_ww_quest.var_77500ecd839e52e4 delete();
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xfa4bc1fd, Offset: 0x569c
// Size: 0x75
function private function_bbb2e93ada22ead2( b_skipped, b_save_restored )
{
    level.scarab_ww_quest.anvil setscriptablepartstate( "usable", "on" );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        if ( !level callback::exists( "zone_changed", &function_8367e8eaabd0aa6d ) )
        {
            level callback::add( "zone_changed", &function_8367e8eaabd0aa6d );
        }
    }
    
    level utility::flag_wait( "w_s_11_c_aurora" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x4539ff81, Offset: 0x5719
// Size: 0x72
function private function_540b6e0231a8d559( b_skipped, b_save_restored )
{
    level.scarab_ww_quest.anvil setscriptablepartstate( "usable", "off" );
    
    if ( level callback::exists( "zone_changed", &function_8367e8eaabd0aa6d ) )
    {
        level callback::remove( "zone_changed", &function_8367e8eaabd0aa6d );
    }
    
    if ( b_skipped )
    {
        level function_d318c1b7df5c49b5();
        level function_65db3e962e1a65b1();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x47af75b, Offset: 0x5793
// Size: 0x22
function private function_bbb2ec3ada22f16b( b_skipped, b_save_restored )
{
    level utility::flag_wait( "w_s_12_c_rivet" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xc7d8db7, Offset: 0x57bd
// Size: 0x1e9
function private function_540b770231a8e924( b_skipped, b_save_restored )
{
    level callback::add( #"player_disconnect", &function_8e9c97cfcd10ea15 );
    level callback::add( #"player_death", &function_8e9c97cfcd10ea15 );
    level callback::add( #"player_item_drop", &function_56178e12960b566c );
    level magicbox::function_2e49cd8681e36211( 0 );
    
    if ( b_skipped )
    {
        level function_b58aeb51fa24dc15( undefined, b_skipped );
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread zm_quest::update_round_cap( 12 );
        
        if ( level callback::exists( #"hash_78694f61c22b5057", &function_24dddce9e88daecd ) )
        {
            level callback::remove( #"hash_78694f61c22b5057", &function_24dddce9e88daecd );
        }
        
        if ( level callback::exists( #"hash_9595b4413b1af76a", &function_1b7607d1b0d72e20 ) )
        {
            level callback::remove( #"hash_9595b4413b1af76a", &function_1b7607d1b0d72e20 );
        }
        
        if ( level callback::exists( "on_round_end", &function_ca976a8ff3827f9 ) )
        {
            level callback::remove( "on_round_end", &function_ca976a8ff3827f9 );
        }
        
        if ( level callback::exists( #"player_connect", &function_c759ffc24bf0e3f5 ) )
        {
            level callback::remove( #"player_connect", &function_c759ffc24bf0e3f5 );
        }
        
        if ( level callback::exists( #"player_spawned", &function_f2fb98e01bba2de7 ) )
        {
            level callback::remove( #"player_spawned", &function_f2fb98e01bba2de7 );
        }
        
        level zm_quest::function_fba942a1cfd85f5d( 1, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"wwq_complete" );
        level zm_quest::function_fb3af5600f6a9441( 4, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"wwq_complete" );
        level utility::delaythread( 0.05, &function_c01363ed17a6efa2 );
    }
    
    if ( b_save_restored )
    {
        level thread function_5bd0613e78e85d04();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xd1ec5b41, Offset: 0x59ae
// Size: 0x5c
function private function_5bd0613e78e85d04()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    
    if ( !function_a111c6fcbfd3a928() && !level.scarab_ww_quest.wonder_weapon_item )
    {
        while ( isdefined( level.anvil_ee.gauntlet ) )
        {
            waitframe();
        }
        
        level function_65db3e962e1a65b1();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0
// Checksum 0x1cd2e22b, Offset: 0x5a12
// Size: 0x12
function function_c01363ed17a6efa2()
{
    level zm_quest::function_b5d75b34f712db9a();
    level function_b066116afb073734();
}

// Namespace zm_sat_scarab_ww_quest
// Params 5, eflags: 0x4
// Checksum 0x34ff6d31, Offset: 0x5a2c
// Size: 0xca
function private function_790454e66cc6d12c( item_bundle, origin, angles, var_7bc5c94777b35f7e = 0, scale_payload )
{
    itembundle = getscriptbundle( item_bundle );
    spawnoptions = common_item::function_bc5ff2958b71a708( origin, angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    
    if ( var_7bc5c94777b35f7e )
    {
        return item_weapon::function_b960bc85ea91de14( itembundle, spawnoptions );
    }
    
    if ( scale_payload )
    {
        spawnoptions.payload = [ #"scale", scale_payload ];
    }
    
    return common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x82b1cba7, Offset: 0x5afe
// Size: 0xcd
function private function_f710905c8115ad02( params )
{
    itembundle = params.bundle;
    
    if ( !itembundle.ref )
    {
        return;
    }
    
    switch ( itembundle.ref )
    {
        case #"hash_5e08039f9e8c7acd":
            level function_bd259c94667fcfa6( self );
            break;
        case #"hash_e6440615a7d978a7":
            level function_5763786d82e3c364( self );
            break;
        case #"hash_716f4401e49f4be8":
            level function_c4220f02160f9859( self );
            break;
        case #"hash_9e43a54d417a2fc1":
            level function_d331253ff802b0eb( self );
            break;
        case #"hash_a54b27fcc6ea8e88":
            level function_64e56807b3040e46( self );
            break;
        default:
            break;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x9bf805bf, Offset: 0x5bd3
// Size: 0x7e
function private function_e7058ea1476170a( params )
{
    itembundle = params.itembundle;
    
    switch ( itembundle.ref )
    {
        case #"hash_dafdccd14b0fc0d":
            level function_b58aeb51fa24dc15( self, undefined, params );
            utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_scarab_artifact_6" );
            break;
        default:
            break;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 4, eflags: 0x4
// Checksum 0x7d4b05e7, Offset: 0x5c59
// Size: 0x101
function private function_54d1adbb85f0d5ca( zombie_type, spawner, round_number, quest_zombie_array )
{
    zombie = agent_manager::spawn_agent( zombie_type, spawner.origin, spawner.angles, "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        zombie zombie_emergence_spawning::function_80623a2279a4d888();
        zombie val::set( #"scarab_ww_quest", "ignore_cleanup", 1 );
        zombie.ignore_enemy_count = 1;
        zombie.no_powerups = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie.var_4ba4d2d97fbec4d4 = 1;
        
        if ( round_number )
        {
            zombie zombie_utils::set_zombie_round_difficulty( round_number );
        }
        
        zombie.kiastring = #"zombie_kia_mission_kill";
        zombie thread agent_spawner::function_ce10e453e7f7bb8e( spawner );
        quest_zombie_array[ quest_zombie_array.size ] = zombie;
        return zombie;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x89adeb98, Offset: 0x5d62
// Size: 0x12f
function private function_a48053dd962a908e( var_26e7d4a1eb7193b1 = 1 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.aicategory == "hvt" || self.aicategory == "boss" )
    {
        return;
    }
    
    if ( !zm_utility::is_active_zombie( self ) )
    {
        return;
    }
    
    if ( val::get( "damageshield" ) )
    {
        return;
    }
    
    if ( !self.var_4ba4d2d97fbec4d4 && self.aicategory != "normal" )
    {
        zm_cleanup_manager::function_44f5bec4abb163f1( undefined, 1 );
        return;
    }
    
    if ( var_26e7d4a1eb7193b1 )
    {
        zombie_stun::stun_ai( 100 );
        wait randomfloatrange( 0.25, 0.5 );
    }
    
    if ( isalive( self ) )
    {
        if ( !self.var_4ba4d2d97fbec4d4 && self.aicategory == "normal" )
        {
            zm_cleanup_manager::function_dd62e2042418b7e5();
        }
        
        self.nuked = 1;
        self.full_gib = 1;
        self.forceannihilate = 1;
        self.no_powerups = 1;
        self.var_a13bed1ac47e1b2c = 1;
        self.var_66504c8a8a5ed6dd = 1;
        self kill();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x4388034, Offset: 0x5e99
// Size: 0x92
function private function_f0c96d513f9cdc67( a_zombies )
{
    a_zombies = utility::function_8391781ea0784541( a_zombies );
    
    foreach ( zombie in a_zombies )
    {
        if ( isalive( zombie ) )
        {
            zombie thread function_a48053dd962a908e();
            waitframe();
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 11, eflags: 0x4
// Checksum 0xd219e5ac, Offset: 0x5f33
// Size: 0xfd
function private function_3b22980b58479a55( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"hash_7913bfcaf7cfe5e6" || level utility::flag( "w_s_1_c_quarry" ) )
    {
        return;
    }
    
    if ( isplayer( eattacker ) && ( smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" ) )
    {
        if ( objweapon && objweapon.basename != "sat_molotov_zm" )
        {
            eattacker damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
            waitframe();
            level function_e825fa636fbea5c3();
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xde4cb5a, Offset: 0x6038
// Size: 0x12f
function private function_e825fa636fbea5c3( b_skipped = 0 )
{
    if ( level utility::flag( "w_s_1_c_quarry" ) )
    {
        return;
    }
    
    level scriptable::function_dc174fecebb79952( &function_3b22980b58479a55 );
    level utility::flag_set( "w_s_1_c_quarry" );
    level utility::flag_set( "w_o_c_i_w_monsoon" );
    level utility::delaythread( 0.5, &function_51f12524c830dd09 );
    
    if ( b_skipped )
    {
        level.scarab_ww_quest.var_8df3ff996389aaf freescriptable();
    }
    else if ( level.scarab_ww_quest.var_8df3ff996389aaf )
    {
        level.scarab_ww_quest.var_8df3ff996389aaf setscriptablepartstate( "body", "broken" );
        level.scarab_ww_quest.var_8df3ff996389aaf utility::delaycall( 1, &freescriptable );
    }
    
    s_prism = utility::getstruct( "gb_l_p_item", "targetname" );
    level.scarab_ww_quest.var_d5b8135b0cc12b16 = function_790454e66cc6d12c( %"hash_46010eefffe85ca6", s_prism.origin, s_prism.angles, undefined, 1.25 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x1c6825f1, Offset: 0x616f
// Size: 0x185
function private function_bd259c94667fcfa6( player )
{
    if ( level utility::flag( "w_s_2_c_harbor" ) )
    {
        return;
    }
    
    if ( level.scarab_ww_quest.var_d5b8135b0cc12b16 )
    {
        playsoundatpos( level.scarab_ww_quest.var_d5b8135b0cc12b16.origin + ( 0, 0, 10 ), #"evt_zm_scarab_wwq_crystal_pickup" );
    }
    
    level zm_quest::function_b57dfe9625966b0b( #"scarab_misc", 0, #"prism", 1 );
    
    if ( player )
    {
        level zm_quest::show_splash_item_picked_up( #"scarab_misc", #"prism", 1, player );
    }
    
    if ( level.scarab_ww_quest.var_d5b8135b0cc12b16 )
    {
        common_item::function_869d7676e359a627( level.scarab_ww_quest.var_d5b8135b0cc12b16 );
    }
    
    level utility::flag_set( "w_s_2_c_harbor" );
    
    foreach ( base in level.scarab_ww_quest.var_78eb700b3b1389dd )
    {
        base setscriptablepartstate( "usable", "on" );
    }
    
    level utility::delaythread( 0.5, &function_51f12524c830dd09 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xfac9180b, Offset: 0x62fc
// Size: 0x10f
function private function_d8ed6b2eabd4a4c1( player )
{
    if ( player && player.interactions_disabled )
    {
        return;
    }
    
    base = self.parent;
    
    if ( level zm_quest::function_b0a5181ebe7bb905() && !base.var_aae9ba29786e9ca7.var_8098fcc8bbc03090 )
    {
        return;
    }
    
    base setscriptablepartstate( "usable", "off" );
    
    if ( base utility::ent_flag( "p_p_ion" ) )
    {
        base function_4af641195571294f();
    }
    else
    {
        if ( level utility::flag( "p_i_p_lumen" ) || !level utility::flag( "w_s_2_c_harbor" ) )
        {
            base utility::delaycall( 1, &setscriptablepartstate, "usable", "on" );
            return;
        }
        
        base function_496aae1ac602fdeb();
        
        if ( player )
        {
            player utility::delaythread( 1.5, &function_c99b85fe440b3386, "wwq_vo_prism_slot_first_time", "scarab_scw1_prism_slot_first_time" );
        }
    }
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        base utility::delaycall( 1, &setscriptablepartstate, "usable", "on" );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x21cddbbc, Offset: 0x6413
// Size: 0xea
function private function_631358516a5bce28( interact, player )
{
    if ( player && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() && level utility::flag( "w_s_2_c_harbor" ) && interact.parent.var_8098fcc8bbc03090 && !interact.parent utility::ent_flag( "p_p_ion" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_41b66ba23f4760e3", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x9b46f7ee, Offset: 0x6505
// Size: 0x100
function private function_496aae1ac602fdeb()
{
    base = self;
    zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"hash_a629154ffa415ea1", base.var_aae9ba29786e9ca7.var_6db487922ef2b46b );
    base.var_aae9ba29786e9ca7 setscriptablepartstate( "body", "show_no_light" );
    base utility::ent_flag_set( "p_p_ion" );
    level utility::flag_set( "p_i_p_lumen" );
    base.var_aae9ba29786e9ca7.var_68e1ed47045d49b4 scriptmodelplayanim( "sat_fxanim_zm_prism_close" );
    level thread function_51f12524c830dd09();
    
    if ( base.var_aae9ba29786e9ca7 utility::ent_flag( "w_l_b_o_p_cascade" ) )
    {
        base.var_aae9ba29786e9ca7 utility::delaythread( 0.5, &function_3812fd5cf38a008e );
    }
    
    playsoundatpos( base.origin, "evt_zm_scarab_wwq_crystal_insert" );
    level zm_quest::function_b57dfe9625966b0b( #"scarab_misc", 0, #"prism", 0, 0 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x18bf5496, Offset: 0x660d
// Size: 0x1ca
function private function_4af641195571294f()
{
    base = self;
    zm_quest::function_6265be8d0549e1b1( #"scarab_ww_quest", #"hash_a629154ffa415ea1" );
    base.var_aae9ba29786e9ca7 setscriptablepartstate( "body", "hide" );
    base utility::ent_flag_clear( "p_p_ion" );
    base.var_aae9ba29786e9ca7.var_68e1ed47045d49b4 scriptmodelplayanim( "sat_fxanim_zm_prism_open" );
    level utility::flag_clear( "p_i_p_lumen" );
    level thread function_51f12524c830dd09();
    playsoundatpos( base.var_aae9ba29786e9ca7.origin, "evt_zm_scarab_wwq_crystal_pickup" );
    level zm_quest::function_b57dfe9625966b0b( #"scarab_misc", 0, #"prism", 1, 1 );
    
    if ( base.var_aae9ba29786e9ca7 utility::ent_flag( "w_l_b_o_p_cascade" ) )
    {
        if ( base.var_aae9ba29786e9ca7.var_8098fcc8bbc03090 )
        {
            foreach ( other_prism in level.scarab_ww_quest.var_53fe245e95326ece )
            {
                if ( other_prism.n_index > base.var_aae9ba29786e9ca7.n_index && other_prism utility::ent_flag( "w_l_b_o_p_cascade" ) )
                {
                    other_prism utility::ent_flag_clear( "w_l_b_o_p_cascade" );
                }
            }
        }
        
        base.var_aae9ba29786e9ca7 utility::delaythread( 0.5, &function_3812fd5cf38a008e );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xd1b8479, Offset: 0x67df
// Size: 0xe1
function private function_173ee6a5e79f6d13( params )
{
    if ( params.stuckto.targetname && params.stuckto.targetname == "se_temple_1_eye" )
    {
        if ( !params.equipinfo.var_997d4b6005a845d1 )
        {
            return;
        }
        
        level thread function_51f12524c830dd09();
        
        if ( level utility::flag( "w_e_b_a_reef" ) )
        {
            return;
        }
        
        params.equipinfo.b_skip_molotov = 1;
        
        if ( isplayer( params.player ) )
        {
            params.player damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
        }
        
        level function_fab1326dee9905e( params.player );
        level utility::delaythread( 0.05, &function_24b3d440708b288, params );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xdfcc7cf1, Offset: 0x68c8
// Size: 0x31
function private function_24b3d440708b288( params )
{
    if ( params.equipinfo )
    {
        params.equipinfo.b_skip_molotov = 0;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x9a9ec77c, Offset: 0x6901
// Size: 0x239
function private function_fab1326dee9905e( triggering_player )
{
    if ( level utility::flag( "w_e_b_a_reef" ) )
    {
        return;
    }
    
    level utility::flag_set( "w_e_b_a_reef" );
    level utility::flag_set( "w_o_n_e_drift" );
    level thread function_51f12524c830dd09();
    level.scarab_ww_quest.nyxara_eye_fx = spawnscriptable( %"hash_3d11c615060ac436", level.scarab_ww_quest.var_52b66e82f17fb84b.origin, level.scarab_ww_quest.var_52b66e82f17fb84b.angles );
    level.scarab_ww_quest.nyxara_eye_fx setscriptablepartstate( "fx", "eye_on" );
    
    if ( !level utility::flag( "w_e_b_a_reef_music" ) )
    {
        level utility::flag_set( "w_e_b_a_reef_music" );
        level zm_music::function_446e6e39d7feeb7c( [ "zone_sw_temple_entrance", "zone_sw_temple_mainhall", "zone_sw_temple_sideroom_landing", "zone_sw_temple_finalroom", "zone_sw_temple_sideroom_upper", "zone_sw_temple_sideroom", "zone_sw_temple_secret_space" ], #"eye_success" );
    }
    
    a_players = getplayersinradius( level.scarab_ww_quest.var_52b66e82f17fb84b.origin, 2000 );
    
    foreach ( player in a_players )
    {
        player playrumbleonentity( "damage_heavy" );
        player earthquakeforplayer( 0.3, 1, level.scarab_ww_quest.var_52b66e82f17fb84b.origin, 2000 );
    }
    
    if ( triggering_player )
    {
        triggering_player utility::delaythread( 1, &function_c99b85fe440b3386, "wwq_vo_energy_pulse_reveal", "scarab_scw1_energy_pulse_reveal", #"bc_flavor_player_positive" );
    }
    
    level utility::delaythread( 1, &function_a1b59bbc3cf0d64c );
    level thread function_1bb6f1044c217be8();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xa18ae179, Offset: 0x6b42
// Size: 0xb9
function private function_1bb6f1044c217be8()
{
    level endon( #"w_s_5_c_ember" );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    for ( time_elapsed = 0; true ; time_elapsed++ )
    {
        if ( time_elapsed >= 120 )
        {
            playworldsound( level.scarab_ww_quest.var_52b66e82f17fb84b.origin, #"hash_6faa2c529171b340" );
            level function_d466074beef00a26();
            return;
        }
        else if ( time_elapsed > 105 )
        {
            playworldsound( level.scarab_ww_quest.var_52b66e82f17fb84b.origin, #"hash_1b4b825dc389bf75" );
        }
        
        wait 1;
        
        /#
            iprintlnbold( "<dev string:x59>" + 120 - time_elapsed );
        #/
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xc01329b4, Offset: 0x6c03
// Size: 0x16d
function private function_d466074beef00a26()
{
    level utility::flag_clear( "w_e_b_a_reef" );
    level notify( #"hash_1b7bb5fb86e09819" );
    
    foreach ( e_pulse in level.scarab_ww_quest.var_46fd404b0867d867 )
    {
        function_db4bc0dcd3aba60c( e_pulse );
    }
    
    foreach ( var_aae9ba29786e9ca7 in level.scarab_ww_quest.var_81bf0f82e9711035 )
    {
        var_aae9ba29786e9ca7 utility::ent_flag_clear( "w_l_b_o_p_cascade" );
    }
    
    level.scarab_ww_quest.nyxara_eye_fx setscriptablepartstate( "fx", "eye_off" );
    level.scarab_ww_quest.nyxara_eye_fx utility::delaycall( 1, &freescriptable );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x86198ef8, Offset: 0x6d78
// Size: 0x86
function private function_a1b59bbc3cf0d64c()
{
    if ( level utility::flag( "w_s_5_c_ember" ) )
    {
        return;
    }
    
    first_prism = level.scarab_ww_quest.var_53fe245e95326ece[ 0 ];
    first_prism utility::ent_flag_set( "w_l_b_o_p_cascade" );
    first_prism.throttle_ent = utility::spawn_model( "tag_origin", level.scarab_ww_quest.var_cbf76ab35c7fe9cc.origin );
    level thread function_369d97dad514545a();
    first_prism thread function_3812fd5cf38a008e();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x8ea8af9a, Offset: 0x6e06
// Size: 0x53f
function private function_3812fd5cf38a008e()
{
    level endon( #"game_ended" );
    level endon( #"w_s_5_c_ember" );
    
    if ( level utility::flag( "w_s_5_c_ember" ) )
    {
        return;
    }
    
    if ( !utility::ent_flag( "w_l_b_o_p_cascade" ) )
    {
        return;
    }
    
    if ( self.var_c2df640d7f1fb7d2 )
    {
        function_ceb8ffea339aec07();
        level thread function_51f12524c830dd09();
        return;
    }
    
    if ( self.n_index >= level.scarab_ww_quest.var_53fe245e95326ece.size - 1 )
    {
        b_last_prism = 1;
        var_5b05142da4e3befc = vectornormalize( level.scarab_ww_quest.var_cb14f2d5f5de60dc.origin - self.var_b0c37265004d7765 );
    }
    else
    {
        next_prism = level.scarab_ww_quest.var_53fe245e95326ece[ self.n_index + 1 ];
        var_5b05142da4e3befc = vectornormalize( next_prism.var_b0c37265004d7765 - self.var_b0c37265004d7765 );
    }
    
    var_1607b99e6557e03 = self.var_15f69f103ace73b8 - level.scarab_ww_quest.var_493139418f5e8ea3[ self.n_index ];
    
    if ( self.var_1295db083488b625 )
    {
        self.var_1295db083488b625 utility::ent_flag_clear( "w_l_b_o_p_cascade" );
        self.var_1295db083488b625 = undefined;
    }
    
    if ( var_1607b99e6557e03 != 0 )
    {
        if ( self.n_index == 3 && self.var_15f69f103ace73b8 == -1 && self.var_ae1ce70a6b469c3d )
        {
            goal_origin = self.var_ae1ce70a6b469c3d;
        }
        else
        {
            v_angles = vectortoangles( var_5b05142da4e3befc );
            angle_offset = self.n_angle_override;
            
            if ( !isdefined( angle_offset ) )
            {
                angle_offset = 10;
            }
            
            var_2b9c45b77c958450 = var_1607b99e6557e03 * angle_offset;
            v_angles = ( v_angles[ 0 ], v_angles[ 1 ] - var_2b9c45b77c958450, v_angles[ 2 ] );
            v_dir = anglestoforward( v_angles );
            goal_origin = self.var_b0c37265004d7765 + v_dir * 1500;
            contentoverride = trace::create_contents( 0, 1, 0, 1, 1, 0, 1, 1, 0, 0 );
            trace = trace::ray_trace( self.var_b0c37265004d7765 + var_5b05142da4e3befc * 50, goal_origin, undefined, contentoverride, 0, 0, 1 );
            
            if ( trace[ "position" ] )
            {
                goal_origin = trace[ "position" ];
            }
        }
        
        throttle::throttle_wait_in_queue( level.scarab_ww_quest.var_c868582099fef2aa, level.scarab_ww_quest.var_53fe245e95326ece[ 0 ].throttle_ent );
        
        foreach ( false_prism in level.scarab_ww_quest.var_1ca5d39930b4e717 )
        {
            if ( false_prism.var_8098fcc8bbc03090 )
            {
                continue;
            }
            
            if ( distancesquared( false_prism.var_b0c37265004d7765, goal_origin ) <= squared( 128 ) )
            {
                self.var_1295db083488b625 = false_prism;
                false_prism utility::ent_flag_set( "w_l_b_o_p_cascade" );
                
                if ( false_prism getscriptablepartstate( "body" ) != "hide" )
                {
                    false_prism utility::delaythread( 0.5, &function_3812fd5cf38a008e );
                }
                
                goal_origin = false_prism.var_b0c37265004d7765;
            }
        }
        
        foreach ( var_aae9ba29786e9ca7 in level.scarab_ww_quest.var_53fe245e95326ece )
        {
            if ( var_aae9ba29786e9ca7.n_index > self.n_index && var_aae9ba29786e9ca7 utility::ent_flag( "w_l_b_o_p_cascade" ) )
            {
                var_aae9ba29786e9ca7 utility::ent_flag_clear( "w_l_b_o_p_cascade" );
            }
        }
    }
    else if ( b_last_prism )
    {
        goal_origin = level.scarab_ww_quest.var_cb14f2d5f5de60dc.origin;
    }
    else if ( next_prism.var_8098fcc8bbc03090 )
    {
        next_prism utility::ent_flag_set( "w_l_b_o_p_cascade" );
        
        if ( next_prism.base utility::ent_flag( "p_p_ion" ) )
        {
            next_prism utility::delaythread( 0.5, &function_3812fd5cf38a008e );
            goal_origin = next_prism.var_b0c37265004d7765;
        }
    }
    else if ( !self.var_8098fcc8bbc03090 || self.var_8098fcc8bbc03090 && self.base utility::ent_flag( "p_p_ion" ) )
    {
        next_prism utility::ent_flag_set( "w_l_b_o_p_cascade" );
        next_prism utility::delaythread( 0.5, &function_3812fd5cf38a008e );
        goal_origin = next_prism.var_b0c37265004d7765;
    }
    
    self.var_711df2db14265b = goal_origin;
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xe1dd1849, Offset: 0x734d
// Size: 0x18d
function private function_ceb8ffea339aec07()
{
    if ( !self.base utility::ent_flag( "p_p_ion" ) )
    {
        self.var_711df2db14265b = self.var_b0c37265004d7765;
        return;
    }
    
    var_1607b99e6557e03 = self.var_15f69f103ace73b8 - 0;
    var_358a306b533efabd = self.var_358a306b533efabd;
    var_5b05142da4e3befc = vectornormalize( var_358a306b533efabd.origin - self.var_b0c37265004d7765 );
    v_angles = vectortoangles( var_5b05142da4e3befc );
    angle_offset = self.n_angle_override;
    
    if ( !isdefined( angle_offset ) )
    {
        angle_offset = 10;
    }
    
    var_2b9c45b77c958450 = var_1607b99e6557e03 * angle_offset;
    v_angles = ( v_angles[ 0 ], v_angles[ 1 ] - var_2b9c45b77c958450, v_angles[ 2 ] );
    v_dir = anglestoforward( v_angles );
    goal_origin = self.var_b0c37265004d7765 + v_dir * 1500;
    contentoverride = trace::create_contents( 0, 1, 0, 1, 1, 0, 1, 1, 0, 0 );
    trace = trace::ray_trace( self.var_b0c37265004d7765 + var_5b05142da4e3befc * 50, goal_origin, undefined, contentoverride, 0, 0, 1 );
    
    if ( trace[ "position" ] )
    {
        goal_origin = trace[ "position" ];
    }
    
    throttle::throttle_wait_in_queue( level.scarab_ww_quest.var_c868582099fef2aa, level.scarab_ww_quest.var_53fe245e95326ece[ 0 ].throttle_ent );
    self.var_711df2db14265b = goal_origin;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x9108d7f1, Offset: 0x74e2
// Size: 0x45
function private function_369d97dad514545a()
{
    level endon( #"w_s_5_c_ember" );
    level endon( #"hash_1b7bb5fb86e09819" );
    level.scarab_ww_quest.var_46fd404b0867d867 = [];
    
    while ( true )
    {
        level thread function_99fba40656669d57();
        wait 2.5;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 4, eflags: 0x4
// Checksum 0x4c493b11, Offset: 0x752f
// Size: 0x7d
function private function_c61cd21e8e51b402( e_mover, var_ded4e8183160df51, var_40a0117d8c10e208, n_segment )
{
    var_b6081b1b6ba5e8b5 = distance( var_ded4e8183160df51, var_40a0117d8c10e208 );
    
    if ( var_b6081b1b6ba5e8b5 < 1 )
    {
        return var_ded4e8183160df51;
    }
    
    n_speed = 2000 * ( 1 + n_segment * 0.1 );
    e_mover moveto( var_40a0117d8c10e208, var_b6081b1b6ba5e8b5 / n_speed );
    e_mover waittill( #"movedone" );
    return var_40a0117d8c10e208;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xac57228b, Offset: 0x75b5
// Size: 0x36d
function private function_99fba40656669d57()
{
    level endon( #"hash_1b7bb5fb86e09819" );
    level endon( #"w_s_5_c_ember" );
    
    if ( !level.scarab_ww_quest.var_53fe245e95326ece[ 0 ] utility::ent_flag( "w_l_b_o_p_cascade" ) )
    {
        return;
    }
    
    v_start = level.scarab_ww_quest.var_cbf76ab35c7fe9cc.origin;
    e_mover = utility::spawn_model( %"tag_origin", v_start );
    e_pulse = spawnscriptable( %"hash_5e6ec99607287fab", v_start, ( 0, 0, 0 ) );
    waitframe();
    e_pulse utility::scriptable_setparententity( e_mover );
    e_pulse.e_mover = e_mover;
    level.scarab_ww_quest.var_46fd404b0867d867[ level.scarab_ww_quest.var_46fd404b0867d867.size ] = e_pulse;
    v_prev = v_start;
    n_segment = 0;
    var_4d41bf26c23e8f8e = undefined;
    
    foreach ( var_aae9ba29786e9ca7 in level.scarab_ww_quest.var_53fe245e95326ece )
    {
        if ( !var_aae9ba29786e9ca7 utility::ent_flag( "w_l_b_o_p_cascade" ) )
        {
            break;
        }
        
        v_prev = function_c61cd21e8e51b402( e_mover, v_prev, var_aae9ba29786e9ca7.var_b0c37265004d7765, n_segment );
        var_aae9ba29786e9ca7 setscriptablepartstate( "fx", "light_impact" );
        n_segment++;
        var_4d41bf26c23e8f8e = var_aae9ba29786e9ca7;
    }
    
    if ( !var_4d41bf26c23e8f8e )
    {
        e_pulse freescriptable();
        e_mover delete();
        return;
    }
    
    b_success = 0;
    
    if ( var_4d41bf26c23e8f8e.var_1295db083488b625 )
    {
        false_prism = var_4d41bf26c23e8f8e.var_1295db083488b625;
        v_prev = function_c61cd21e8e51b402( e_mover, v_prev, false_prism.var_b0c37265004d7765, n_segment );
        false_prism setscriptablepartstate( "fx", "light_impact" );
        n_segment++;
        
        if ( false_prism.var_711df2db14265b )
        {
            function_c61cd21e8e51b402( e_mover, v_prev, false_prism.var_711df2db14265b, n_segment );
        }
        
        e_pulse setscriptablepartstate( "impact", "impact_strong" );
    }
    else if ( var_4d41bf26c23e8f8e.var_711df2db14265b )
    {
        var_b60a9e11870d2863 = var_4d41bf26c23e8f8e.var_711df2db14265b;
        function_c61cd21e8e51b402( e_mover, v_prev, var_4d41bf26c23e8f8e.var_711df2db14265b, n_segment );
        var_278a753ccfffa3c8 = var_4d41bf26c23e8f8e.n_index >= level.scarab_ww_quest.var_53fe245e95326ece.size - 1;
        
        if ( var_278a753ccfffa3c8 && var_b60a9e11870d2863 == level.scarab_ww_quest.var_cb14f2d5f5de60dc.origin )
        {
            e_pulse setscriptablepartstate( "visual", "invisible" );
            e_pulse setscriptablepartstate( "impact", "impact_strong" );
            level thread function_3daea56851c5d51();
            b_success = 1;
        }
    }
    
    if ( !b_success )
    {
        e_pulse setscriptablepartstate( "visual", "invisible" );
        e_pulse setscriptablepartstate( "impact", "impact_strong" );
    }
    
    wait 0.5;
    e_pulse freescriptable();
    e_mover delete();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x9168759b, Offset: 0x792a
// Size: 0x3d
function private function_db4bc0dcd3aba60c( e_pulse )
{
    if ( !e_pulse )
    {
        return;
    }
    
    e_mover = e_pulse.e_mover;
    e_pulse freescriptable();
    
    if ( e_mover )
    {
        e_mover delete();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x7eab8e67, Offset: 0x796f
// Size: 0x1ee
function private function_e877a930391f3498( params )
{
    retrieved_entity = params.entity;
    retrieved_scriptable = params.scriptable;
    
    if ( retrieved_entity.model != %"hash_1c5bcc5b65c82ced" && retrieved_scriptable.type != %"hash_1afbc4eea83ff1e1" )
    {
        return;
    }
    
    if ( retrieved_scriptable.type == %"hash_1afbc4eea83ff1e1" )
    {
        var_aae9ba29786e9ca7 = retrieved_scriptable;
        var_68e1ed47045d49b4 = retrieved_scriptable.var_68e1ed47045d49b4;
    }
    else
    {
        var_aae9ba29786e9ca7 = retrieved_entity.var_aae9ba29786e9ca7;
        var_68e1ed47045d49b4 = retrieved_entity;
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() && !level function_891ce73ab5b1601a( var_aae9ba29786e9ca7 ) )
    {
        return;
    }
    
    var_68e1ed47045d49b4 setscriptablepartstate( "grapple", "off" );
    var_c2914619b3afef50 = vectornormalize( self.origin - var_68e1ed47045d49b4.origin );
    var_22d513e22377cf35 = anglestoleft( var_aae9ba29786e9ca7.a_spawn_angles );
    var_503192e8cdf95142 = vectordot( var_c2914619b3afef50, var_22d513e22377cf35 );
    b_rotate_right = var_503192e8cdf95142 < 0;
    var_a9a5f546b4c9e8c0 = var_aae9ba29786e9ca7 thread move_prism( b_rotate_right );
    
    if ( var_a9a5f546b4c9e8c0 )
    {
        if ( isplayer( self ) )
        {
            damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
        }
        
        if ( !var_aae9ba29786e9ca7.var_8098fcc8bbc03090 || var_aae9ba29786e9ca7.var_8098fcc8bbc03090 && var_aae9ba29786e9ca7.base utility::ent_flag( "p_p_ion" ) )
        {
            var_aae9ba29786e9ca7 utility::delaythread( 1, &function_3812fd5cf38a008e );
        }
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level utility::delaythread( 1.2, &function_b74ce1f5c7231e91 );
        return;
    }
    
    var_68e1ed47045d49b4 utility::delaycall( 1.2, &setscriptablepartstate, "grapple", "on" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xaa642884, Offset: 0x7b65
// Size: 0x8f, Type: bool
function private move_prism( var_32f8419558277cb5 = 0 )
{
    if ( utility::ent_flag( "p_r_mercury" ) )
    {
        return false;
    }
    
    var_15f69f103ace73b8 = self.var_15f69f103ace73b8;
    n_new_pos = var_15f69f103ace73b8;
    
    if ( var_32f8419558277cb5 )
    {
        if ( var_15f69f103ace73b8 >= 1 )
        {
            n_new_pos = -1;
        }
        else
        {
            n_new_pos = var_15f69f103ace73b8 + 1;
        }
    }
    else if ( var_15f69f103ace73b8 <= -1 )
    {
        n_new_pos = 1;
    }
    else
    {
        n_new_pos = var_15f69f103ace73b8 - 1;
    }
    
    self.var_15f69f103ace73b8 = n_new_pos;
    thread function_1a27a710e1c94151( n_new_pos );
    return true;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xfba83616, Offset: 0x7bfd
// Size: 0xc1
function private function_1a27a710e1c94151( n_target_pos )
{
    utility::ent_flag_set( "p_r_mercury" );
    a_target_angles = self.a_spawn_angles + ( 0, 0, n_target_pos * 45 );
    v_sound_origin = self.origin;
    v_sound_origin += anglestoforward( self.var_68e1ed47045d49b4.angles ) * 20;
    playworldsound( v_sound_origin, #"hash_4a270fe9ba0f8c17" );
    self.var_68e1ed47045d49b4 rotateto( a_target_angles, 1 );
    self.var_68e1ed47045d49b4 waittill( #"rotatedone" );
    self.var_68e1ed47045d49b4.angles = a_target_angles;
    utility::ent_flag_clear( "p_r_mercury" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x353647dd, Offset: 0x7cc6
// Size: 0x336
function private function_3daea56851c5d51( b_skipped = 0, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "w_s_5_c_ember" ) )
    {
        return;
    }
    
    level utility::flag_set( "w_s_5_c_ember" );
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"hash_a01291f4885b13cd", 1 );
    
    /#
        iprintlnbold( "<dev string:x70>" );
    #/
    
    if ( level callback::exists( "usurped_power_land", &function_173ee6a5e79f6d13 ) )
    {
        level callback::remove( "usurped_power_land", &function_173ee6a5e79f6d13 );
    }
    
    level function_aab0bd8fb93dc605();
    
    if ( !b_skipped )
    {
        a_players = getplayersinradius( level.scarab_ww_quest.var_cb14f2d5f5de60dc.origin, 1500 );
        
        foreach ( player in a_players )
        {
            player playrumbleonentity( "damage_heavy" );
            player earthquakeforplayer( 0.3, 2.5, level.scarab_ww_quest.var_cb14f2d5f5de60dc.origin, 1500 );
        }
    }
    
    level notify( #"hash_1b7bb5fb86e09819" );
    
    foreach ( e_pulse in level.scarab_ww_quest.var_46fd404b0867d867 )
    {
        function_db4bc0dcd3aba60c( e_pulse );
    }
    
    var_41604c028f54cbea = getentarray( "doorbuy_door_nyxara_sideroom_1", #targetname );
    var_41604c028f54cbea[ 0 ].var_fc824b622a52db8d[ 0 ] thread doorbuy::doorbuy_used( undefined, undefined, 1 );
    playsoundatpos( ( -4029, -3562, 1616 ), #"hash_3855469ecca32cab" );
    
    if ( !b_skipped )
    {
        door_vo_player = level function_9bffb7317fa4df73( var_41604c028f54cbea[ 0 ].origin, "zone_sw_temple" );
        
        if ( door_vo_player )
        {
            door_vo_player utility::delaythread( 2, &function_c99b85fe440b3386, "wwq_vo_door_blast", "scarab_scw1_door_blast" );
        }
    }
    
    if ( level.scarab_ww_quest.nyxara_eye_fx )
    {
        level.scarab_ww_quest.nyxara_eye_fx freescriptable();
    }
    
    s_visage = utility::getstruct( "w_a_v", "targetname" );
    level.scarab_ww_quest.var_79fc0cd2f8572e6a = spawnscriptable( %"hash_7647f4595739caf6", s_visage.origin, s_visage.angles );
    level thread function_459091222c60463a();
    level utility::delaythread( 0.5, &function_51f12524c830dd09 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x8f79dcef, Offset: 0x8004
// Size: 0xf0
function private function_aab0bd8fb93dc605()
{
    foreach ( var_aae9ba29786e9ca7 in level.scarab_ww_quest.var_53fe245e95326ece )
    {
        goal_pos = level.scarab_ww_quest.var_493139418f5e8ea3[ var_aae9ba29786e9ca7.n_index ];
        var_5e27faa4dc5fcb95 = goal_pos - var_aae9ba29786e9ca7.var_15f69f103ace73b8;
        var_aae9ba29786e9ca7.var_15f69f103ace73b8 = goal_pos;
        
        if ( var_5e27faa4dc5fcb95 != 0 )
        {
            while ( var_aae9ba29786e9ca7 utility::ent_flag( "p_r_mercury" ) )
            {
                waitframe();
            }
            
            var_aae9ba29786e9ca7 thread function_1a27a710e1c94151( goal_pos );
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0
// Checksum 0xfa00cd9a, Offset: 0x80fc
// Size: 0x1b
function function_57491b97a051f563()
{
    if ( !level utility::flag( "n_s_r_o_l_anvil" ) )
    {
        level function_bbc3d0bde2bc174d( 0 );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1
// Checksum 0xcc85a3b3, Offset: 0x811f
// Size: 0xca
function function_bbc3d0bde2bc174d( bool )
{
    if ( !isdefined( level.scarab_ww_quest.hidden_room_traversals ) )
    {
        level.scarab_ww_quest.hidden_room_traversals = getnodearray( "traversal_pinky_tomato", #script_noteworthy );
    }
    
    foreach ( starter_node in level.scarab_ww_quest.hidden_room_traversals )
    {
        function_30dc1efdafe7681e( starter_node, bool );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x8f6549be, Offset: 0x81f1
// Size: 0xc9
function private function_459091222c60463a()
{
    level endon( #"n_s_r_o_l_anvil" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( distancesquared( player.origin, level.scarab_ww_quest.var_79fc0cd2f8572e6a.origin ) <= squared( 75 ) )
            {
                level thread function_927310642be72efd( undefined, player );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xd763deb1, Offset: 0x82c2
// Size: 0x4d4
function private function_927310642be72efd( b_skipped, triggering_player )
{
    if ( utility::flag( "n_s_r_o_l_anvil" ) )
    {
        return;
    }
    
    level utility::flag_set( "n_s_r_o_l_anvil" );
    level thread function_51f12524c830dd09();
    
    if ( !b_skipped )
    {
        var_846692675f7015c5 = utility::getstruct( "rv_n_s_r_fx", "targetname" );
        var_6c99815cc189324b = spawnscriptable( %"hash_3d11c615060ac436", var_846692675f7015c5.origin, var_846692675f7015c5.angles );
        var_6536bb06307c5d8f = getplayersinradius( level.scarab_ww_quest.var_79fc0cd2f8572e6a.origin, 125 );
        
        foreach ( player in var_6536bb06307c5d8f )
        {
            if ( isalive( player ) )
            {
                player thread zm_utility::function_81b8d5704842d1ea( 1.5 );
                player val::set( "scarab_wwq", "allow_movement", 0 );
                player val::set( "scarab_wwq", "damage", 0 );
                player val::set( "scarab_wwq", "ignoreme", 1 );
            }
        }
        
        playsoundatpos( level.scarab_ww_quest.var_79fc0cd2f8572e6a.origin, #"hash_aaa16ff2d8595d0c" );
        level thread function_9a2dc21edaaa9395();
        level thread zm_utility::function_1d82e63812f9640a( level.scarab_ww_quest.var_79fc0cd2f8572e6a.origin, 400, 5, "damage_heavy", 0.2, 800, "damage_light", 0.15 );
        wait 0.5;
        level.scarab_ww_quest.var_79fc0cd2f8572e6a setscriptablepartstate( "fx", "room_opening" );
        var_c8b052adbf4cc2cc = getaiarrayinradius( level.scarab_ww_quest.var_79fc0cd2f8572e6a.origin, 225, zm_utility::get_zombie_team() );
        level thread function_f0c96d513f9cdc67( var_c8b052adbf4cc2cc );
        wait 1;
        var_6536bb06307c5d8f = utility::function_8391781ea0784541( var_6536bb06307c5d8f );
        
        foreach ( player in var_6536bb06307c5d8f )
        {
            player val::reset_all( "scarab_wwq" );
        }
        
        if ( isalive( triggering_player ) )
        {
            triggering_player utility::delaythread( 3, &function_c99b85fe440b3386, "wwq_vo_dreadspinner_attack", "scarab_scw1_dreadspinner_attack" );
        }
        
        if ( level.scarab_ww_quest.var_79fc0cd2f8572e6a )
        {
            level.scarab_ww_quest.var_79fc0cd2f8572e6a thread function_dde51bca6cc6b91();
        }
    }
    else
    {
        if ( level.scarab_ww_quest.var_79fc0cd2f8572e6a )
        {
            level.scarab_ww_quest.var_79fc0cd2f8572e6a freescriptable();
        }
        
        if ( level.scarab_ww_quest.var_79fc0cd2f8572e6a.e_mover )
        {
            level.scarab_ww_quest.var_79fc0cd2f8572e6a.e_mover delete();
        }
    }
    
    if ( var_6c99815cc189324b )
    {
        var_6c99815cc189324b setscriptablepartstate( "fx", "secret_room_open_dust" );
        var_6c99815cc189324b utility::delaycall( 63, &freescriptable );
    }
    
    var_41604c028f54cbea = getentarray( "doorbuy_door_19", #targetname );
    
    foreach ( door in var_41604c028f54cbea )
    {
        door thread doorbuy::doorbuy_used( undefined, undefined, 1 );
    }
    
    e_navmesh_plug = getent( "sideroom_navmesh_plug", #targetname );
    
    if ( e_navmesh_plug )
    {
        e_navmesh_plug.origin += ( 0, 0, -256 );
        e_navmesh_plug disconnectpaths();
    }
    
    level function_bbc3d0bde2bc174d( 1 );
    level thread function_db61de2c497058ad();
    
    if ( !level utility::flag( "w_s_9_c_spruce" ) )
    {
        level thread function_7bfc46e051d4fc57();
    }
    
    if ( !level utility::flag( "doorbuy_door_sw_temple_underground_exit_opened" ) )
    {
        level thread function_61d90fee079babed();
    }
    
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0xc
// Checksum 0x81834119, Offset: 0x879e
// Size: 0x18f
function private function_db61de2c497058ad()
{
    self notify( #"hash_ce1901ef95ec5443" );
    self endon( #"hash_ce1901ef95ec5443" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !( isdefined( level.activekillstreaks ) && isdefined( level.scarab_ww_quest.fruit_spawn_origin ) ) )
        {
            waitframe();
            continue;
        }
        
        foreach ( equipment in level.activekillstreaks )
        {
            if ( !equipment || equipment.var_cb33721325447eae )
            {
                continue;
            }
            
            if ( !equipment.origin || distancesquared( equipment.origin, level.scarab_ww_quest.fruit_spawn_origin ) > squared( 100 ) )
            {
                continue;
            }
            
            if ( equipment.streakname == "remote_turret" || equipment.streakname == "sentry_gun" )
            {
                equipment.var_cb33721325447eae = 1;
                
                if ( isdefined( equipment.owner ) )
                {
                    equipment.owner notify( #"killstreak_cancel" );
                }
                
                equipment notify( #"kill_turret", 1, 1, 0, 1 );
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x5cd727e, Offset: 0x8935
// Size: 0xe2
function private function_dde51bca6cc6b91()
{
    path_array = [];
    var_91924ab1040d73db = utility::getstruct( "w_a_v", "targetname" );
    path_array[ path_array.size ] = var_91924ab1040d73db.origin;
    
    while ( var_91924ab1040d73db.target )
    {
        var_91924ab1040d73db = utility::getstruct( var_91924ab1040d73db.target, "targetname" );
        path_array[ path_array.size ] = var_91924ab1040d73db.origin;
    }
    
    e_mover = utility::spawn_model( "tag_origin", self.origin, self.angles );
    utility::scriptable_setparententity( e_mover );
    e_mover utility::function_2159dd4196ff4b81( path_array, 2, 1, 0, 1, 1, 0.5 );
    e_mover delete();
    self setscriptablepartstate( "body", "despawn" );
    utility::delaycall( 0.5, &freescriptable );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x3e284d08, Offset: 0x8a1f
// Size: 0x170
function private function_61d90fee079babed()
{
    level endon( #"doorbuy_door_sw_temple_underground_exit_opened" );
    level zm_save::function_1f44a48caae2acbf();
    var_48503b46405e1a9e = getnoentvolumearray( "s_n_s_e_t", #targetname );
    var_7717e66319263994 = getentarray( "doorbuy_door_sw_temple_underground_exit", #targetname );
    
    if ( var_48503b46405e1a9e.size <= 0 || var_7717e66319263994.size <= 0 )
    {
        return;
    }
    
    exit_trigger = var_48503b46405e1a9e[ 0 ];
    exit_door = var_7717e66319263994[ 0 ];
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( ispointinvolume( player.origin, exit_trigger, 1 ) && utility::within_fov( player geteye(), player getplayerangles(), exit_door.origin, cos( 45 ) ) )
            {
                level zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"hash_ce2ffcbee30d6f60", 1 );
                exit_door.s_doorbuy thread doorbuy::doorbuy_used( undefined, undefined, 1 );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xdfa1ccc3, Offset: 0x8b97
// Size: 0x177
function private function_71913779818bc8d4( player )
{
    player endon( #"death_or_disconnect" );
    level.scarab_ww_quest.var_79fc0cd2f8572e6a.e_mover = utility::spawn_model( "tag_origin", self.origin, self.angles );
    level.scarab_ww_quest.var_79fc0cd2f8572e6a utility::scriptable_setparententity( level.scarab_ww_quest.var_79fc0cd2f8572e6a.e_mover );
    level.scarab_ww_quest.var_79fc0cd2f8572e6a.e_mover endon( #"death" );
    level.scarab_ww_quest.var_79fc0cd2f8572e6a.e_mover endon( #"stop_facing" );
    
    while ( true )
    {
        waitframe();
        
        if ( !level.scarab_ww_quest.var_79fc0cd2f8572e6a || !isalive( player ) )
        {
            return;
        }
        
        angles_to_player = vectortoangles( vectornormalize( player.origin - level.scarab_ww_quest.var_79fc0cd2f8572e6a.origin ) );
        angles_to_player = ( 0, angles_to_player[ 1 ], 0 );
        level.scarab_ww_quest.var_79fc0cd2f8572e6a.e_mover.angles = angles_to_player;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0xc
// Checksum 0xbb15179c, Offset: 0x8d16
// Size: 0xad
function private function_7bfc46e051d4fc57()
{
    self notify( #"hash_83aed6fab421f234" );
    self endon( #"hash_83aed6fab421f234" );
    level endon( #"w_s_9_c_spruce" );
    
    while ( true )
    {
        if ( level utility::flag( "w_p_d_a_orchid" ) )
        {
            wait 0.1;
            continue;
        }
        
        if ( level.scarab_ww_quest.var_fe5620e942a1ed76 && !utility::time_has_passed( level.scarab_ww_quest.var_fe5620e942a1ed76, 3 ) )
        {
            wait 0.1;
            continue;
        }
        
        a_players = function_685fa266d30f547c();
        
        if ( a_players.size > 0 )
        {
            level function_c3ac50469bfbc1aa();
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x49d9ea2, Offset: 0x8dcb
// Size: 0xd9
function private function_685fa266d30f547c( radius = 400 )
{
    a_players_in_radius = [];
    a_players = getplayersinradius( level.scarab_ww_quest.center_vine.origin, radius );
    
    foreach ( player in a_players )
    {
        if ( isalive( player ) && !player.inlaststand )
        {
            a_players_in_radius[ a_players_in_radius.size ] = player;
        }
    }
    
    return a_players_in_radius;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x807258e2, Offset: 0x8ead
// Size: 0x80
function private function_cdd675c225c4327d( var_3471316e3ec32d4a )
{
    if ( var_3471316e3ec32d4a < 0 )
    {
        var_3471316e3ec32d4a = 0;
    }
    else if ( var_3471316e3ec32d4a > 100 )
    {
        var_3471316e3ec32d4a = 100;
    }
    
    level.scarab_ww_quest.var_26e8aa9db02e7109 = var_3471316e3ec32d4a;
    level zm_quest::function_9f49b2a045ece8ae( level.scarab_ww_quest.var_26e8aa9db02e7109, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f97fd6235be10e93" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xd752f779, Offset: 0x8f35
// Size: 0x584
function private function_d1cd9bbbd97e2455()
{
    if ( level utility::flag( "WW_STEP_6_COMPLETE" ) )
    {
        return;
    }
    
    if ( !level zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"hash_35846a501c1ef16c" ) )
    {
        n_solution_index = randomintrange( 1, 5 );
        
        if ( getdvarint( @"hash_521b12bbf659d744", 0 ) )
        {
            n_solution_index = getdvarint( @"hash_521b12bbf659d744", 0 );
        }
        
        level zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"hash_35846a501c1ef16c", n_solution_index );
    }
    
    level function_a25883084fb4b473();
    level.scarab_ww_quest.var_1734d730480a06e = level function_7a13add61dfda98c( level zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"hash_35846a501c1ef16c" ) );
    s_riddle = utility::getstruct( "fd_r", "targetname" );
    level.scarab_ww_quest.riddle_inscription = spawnscriptable( %"hash_6bb83b247cc577ae", s_riddle.origin, s_riddle.angles );
    level.scarab_ww_quest.riddle_inscription setscriptablepartstate( "body", string( zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"hash_35846a501c1ef16c" ) ) );
    level thread function_9cb57a61ba8faab9();
    
    if ( level.scarab_ww_quest.var_daae8a1d00edada6.size <= 0 )
    {
        return;
    }
    
    level.scarab_ww_quest.riddle_icons = [];
    var_e3de28e3700b2fd3 = utility::getstructarray( "kl_r_i", "targetname" );
    
    foreach ( s_icon in var_e3de28e3700b2fd3 )
    {
        icon = { #angles:s_icon.angles, #origin:s_icon.origin };
        level.scarab_ww_quest.riddle_icons[ int( s_icon.script_noteworthy ) ] = icon;
        var_7e7ca0a63d1d515e = level.scarab_ww_quest.var_daae8a1d00edada6[ int( s_icon.script_noteworthy ) ];
        var_7e7ca0a63d1d515e.icon = icon;
        
        /#
            switch ( int( s_icon.script_noteworthy ) )
            {
                case 1:
                    icon.str_symbol = "<dev string:x8d>";
                    icon.debug_text = "<dev string:x24>";
                    break;
                case 2:
                    icon.str_symbol = "<dev string:x94>";
                    icon.debug_text = "<dev string:x33>";
                    break;
                case 3:
                    icon.str_symbol = "<dev string:x99>";
                    icon.debug_text = "<dev string:x40>";
                    break;
                case 4:
                    icon.str_symbol = "<dev string:x9f>";
                    icon.debug_text = "<dev string:x4d>";
                    break;
                default:
                    break;
            }
            
            var_7e7ca0a63d1d515e thread debug_print_text( icon.origin + ( 0, 0, 10 ), icon.debug_text, "<dev string:xa4>" );
        #/
    }
    
    foreach ( sconce in level.scarab_ww_quest.var_53d2453af4d1d4bf )
    {
        sconce.handle setscriptablepartstate( "body", "available" );
        sconce.handle.interaction = interaction::register_scriptable_interact( sconce.handle, &function_72e7be655296a695, undefined, undefined, &function_ef20a04716fe79d8 );
        sconce.handle.interaction.parent_sconce = sconce;
    }
    
    level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle setscriptablepartstate( "body", "retract" );
    level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle.interaction = interaction::register_scriptable_interact( level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle, &function_c35e70c2364d665d, undefined, undefined, &function_295505f0b51d83f0 );
    level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle.interaction.parent_sconce = level.scarab_ww_quest.var_1ea0b28c0ef8cc7f;
    
    if ( level utility::flag( "w_e_p_tundra" ) )
    {
        level function_119b591f0edba006();
    }
    
    level utility::flag_set( "w_r_e_hollow" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x27568684, Offset: 0x94c1
// Size: 0x37a
function private function_a25883084fb4b473()
{
    n_index = level zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"hash_35846a501c1ef16c" );
    level.scarab_ww_quest.var_a2be214d8c2fa691 = [];
    
    switch ( n_index )
    {
        case 1:
            level.scarab_ww_quest.var_a2be214d8c2fa691 = [ "east", "south", "north", "west" ];
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 1 ].var_84c9ca9810613496 = &"hash_4fd6b8389e37d10b";
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 2 ].var_84c9ca9810613496 = &"hash_4fd6ba389e37d471";
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 3 ].var_84c9ca9810613496 = &"hash_4fd6b7389e37cf58";
            break;
        case 2:
            level.scarab_ww_quest.var_a2be214d8c2fa691 = [ "south", "north", "west", "east" ];
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 1 ].var_84c9ca9810613496 = &"hash_4fd6b9389e37d2be";
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 2 ].var_84c9ca9810613496 = &"hash_4fd6b8389e37d10b";
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 3 ].var_84c9ca9810613496 = &"hash_4fd6b7389e37cf58";
            break;
        case 3:
            level.scarab_ww_quest.var_a2be214d8c2fa691 = [ "west", "east", "south", "north" ];
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 1 ].var_84c9ca9810613496 = &"hash_4fd6ba389e37d471";
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 2 ].var_84c9ca9810613496 = &"hash_4fd6b7389e37cf58";
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 3 ].var_84c9ca9810613496 = &"hash_4fd6b7389e37cf58";
            break;
        case 4:
            level.scarab_ww_quest.var_a2be214d8c2fa691 = [ "north", "east", "west", "south" ];
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 1 ].var_84c9ca9810613496 = &"hash_4fd6b7389e37cf58";
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 2 ].var_84c9ca9810613496 = &"hash_4fd6b7389e37cf58";
            level.scarab_ww_quest.var_53d2453af4d1d4bf[ 3 ].var_84c9ca9810613496 = &"hash_4fd6b9389e37d2be";
            break;
        default:
            assertmsg( "<dev string:xbc>" );
            break;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x60cb34fb, Offset: 0x9843
// Size: 0x27a
function private function_9cb57a61ba8faab9()
{
    level endon( #"WW_STEP_6_COMPLETE" );
    
    if ( !isdefined( level.scarab_ww_quest.var_73a983fef1f73e5f ) )
    {
        level.scarab_ww_quest.var_73a983fef1f73e5f = throttle::throttle_initialize( "wwq_riddle_vo", 1 );
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            wait 0.2;
            level throttle::throttle_wait_in_queue( level.scarab_ww_quest.var_73a983fef1f73e5f );
            
            if ( !level.scarab_ww_quest.riddle_inscription )
            {
                level utility::flag_set( "w_r_o_bravo" );
                return;
            }
            
            if ( !isalive( player ) || level utility::flag( "vo_d_r_c_keystone" ) )
            {
                continue;
            }
            
            if ( distancesquared( player.origin, level.scarab_ww_quest.riddle_inscription.origin ) > squared( 180 ) )
            {
                continue;
            }
            
            trace_start = player geteye();
            trace_end = trace_start + anglestoforward( player getplayerangles() ) * 180;
            trace_result = trace::ray_trace_detail( trace_start, trace_end, [ player ] );
            
            if ( distancesquared( trace_result[ "position" ], level.scarab_ww_quest.riddle_inscription.origin ) > squared( 25 ) )
            {
                continue;
            }
            
            overlord_players = level function_8676888e7913c7a( "zone_ne_temple" );
            
            if ( overlord_players.size <= 0 )
            {
                continue;
            }
            
            if ( !level utility::flag( "w_r_o_bravo" ) && level function_4d8dcc44436b3e5a() )
            {
                level utility::flag_set( "w_r_o_bravo" );
                level thread function_51f12524c830dd09();
            }
            
            level utility::flag_set( "vo_d_r_c_keystone" );
            level utility::delaythread( 45, &utility::flag_clear, "vo_d_r_c_keystone" );
            
            if ( overlord::function_dce0a14273dfa0a8( overlord_players ) )
            {
                zm_quest::function_8934bb2a9028bdc5();
            }
            
            overlord::playevent( level.scarab_ww_quest.var_1734d730480a06e, overlord_players, undefined, undefined, 1 );
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xd1b07495, Offset: 0x9ac5
// Size: 0x50, Type: bool
function private function_4d8dcc44436b3e5a()
{
    quest_step = level.scarab_ww_quest.steps[ level.scarab_ww_quest.var_7be076c9078045aa ];
    return quest_step && quest_step.ref == #"solve_riddle";
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x22cb6387, Offset: 0x9b1e
// Size: 0x50
function private function_119b591f0edba006()
{
    if ( !level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle )
    {
        return;
    }
    
    level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle setscriptablepartstate( "body", "available" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xec8cfab2, Offset: 0x9b76
// Size: 0x99
function private function_c35e70c2364d665d( player )
{
    if ( player && player.interactions_disabled )
    {
        return;
    }
    
    if ( self.b_in_use || level utility::flag( "WW_STEP_6_COMPLETE" ) || level utility::flag( "b_p_f_m_onyx" ) || !level utility::flag( "w_e_p_tundra" ) )
    {
        return;
    }
    
    self.b_in_use = 1;
    
    if ( function_28b4c383f06f8181() )
    {
        level function_5809d36b4d695bb3( 0, player );
    }
    else
    {
        level function_b575ed6a4a924834( player );
    }
    
    if ( self )
    {
        self.b_in_use = 0;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x82ecb49c, Offset: 0x9c17
// Size: 0xad
function private function_295505f0b51d83f0( interact, player )
{
    if ( player && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() && level function_28b4c383f06f8181() )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_636572052553263b", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x3e19204b, Offset: 0x9ccd
// Size: 0x1ab
function private function_ef20a04716fe79d8( interact, player )
{
    if ( player && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level utility::flag( "WW_STEP_6_COMPLETE" ) || level utility::flag( "b_p_f_m_onyx" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        quest_step = level.scarab_ww_quest.steps[ level.scarab_ww_quest.var_7be076c9078045aa ];
        
        if ( !quest_step || quest_step.ref != #"solve_riddle" || function_28b4c383f06f8181() )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        var_edf5c0dd317d0d99 = level function_c3262176052b9bb8();
        
        if ( var_edf5c0dd317d0d99 && interact.parent_sconce && interact.parent_sconce.handle == var_edf5c0dd317d0d99.sconce_handle )
        {
            return { #var_26bbd300351fde34:0, #string:&"hash_6bc0722a90f01ce5", #type:"HINT_BUTTON" };
        }
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xec76547d, Offset: 0x9e81
// Size: 0x60
function private function_72e7be655296a695( player )
{
    if ( player && player.interactions_disabled )
    {
        return;
    }
    
    if ( level utility::flag( "WW_STEP_6_COMPLETE" ) || level utility::flag( "b_p_f_m_onyx" ) )
    {
        return;
    }
    
    parent_sconce = self.parent_sconce;
    level function_7d505e68878e19a0( parent_sconce );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xb9f36a6, Offset: 0x9ee9
// Size: 0x8f
function private function_7d505e68878e19a0( sconce )
{
    level endon( #"game_ended" );
    level endon( #"WW_STEP_6_COMPLETE" );
    
    if ( !level utility::flag( "w_e_p_tundra" ) )
    {
        level utility::flag_set( "w_e_p_tundra" );
        level function_119b591f0edba006();
        level thread function_51f12524c830dd09();
    }
    
    level utility::flag_set( "b_p_f_m_onyx" );
    sconce.handle setscriptablepartstate( "body", "used" );
    level function_c93373833caa3a2b( sconce );
    level utility::flag_clear( "b_p_f_m_onyx" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x7b0f3a2c, Offset: 0x9f80
// Size: 0x55
function private function_c93373833caa3a2b( sconce )
{
    level endon( #"game_ended" );
    a_pillars = function_61df5b1f2e3a25da( sconce );
    a_pillars[ 0 ] thread rotate_pillar();
    a_pillars[ 1 ] thread rotate_pillar( 1, undefined, 1 );
    level utility::array_wait( a_pillars, "rotatedone" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 3, eflags: 0x4
// Checksum 0xbfbd61bd, Offset: 0x9fdd
// Size: 0xfa
function private rotate_pillar( b_counter_clockwise = 0, b_instant = 0, var_8409db4242733d6 = 0 )
{
    rotate_angle = b_counter_clockwise ? 90 : -90;
    
    if ( b_instant )
    {
        self.angles += ( 0, rotate_angle, 0 );
        function_c4a5b66e03fdbbbf( b_counter_clockwise );
        return;
    }
    
    level endon( #"game_ended" );
    self.fx_top setscriptablepartstate( "fx", "dust_falling" );
    self.fx_bottom setscriptablepartstate( "fx", "dust_falling" );
    thread function_f57f597d4877cf61();
    self rotateby( ( 0, rotate_angle, 0 ), 5, 0.5, 1 );
    function_c4a5b66e03fdbbbf( b_counter_clockwise );
    
    if ( var_8409db4242733d6 )
    {
        level thread function_51f12524c830dd09();
    }
    
    self waittill( #"rotatedone" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x5153fd6f, Offset: 0xa0df
// Size: 0xfa
function private function_f57f597d4877cf61()
{
    self endon( #"rotatedone" );
    utility::delaythread( 4.7, &function_4838fcbb50870a4b );
    timer = 0;
    
    while ( true )
    {
        if ( timer >= 4.6 )
        {
            return;
        }
        
        a_players = getplayersinradius( self.origin, 700 );
        
        foreach ( player in a_players )
        {
            player playrumbleonentity( "low_highfreq" );
            player earthquakeforplayer( 0.15, 0.2, self.origin, 700 );
        }
        
        wait 0.1;
        timer += 0.1;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x84a53f97, Offset: 0xa1e1
// Size: 0xae
function private function_4838fcbb50870a4b()
{
    a_players = getplayersinradius( self.origin, 500 );
    
    foreach ( player in a_players )
    {
        player playrumbleonentity( "damage_light" );
        player earthquakeforplayer( 0.15, 0.7, self.origin, 500 );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xc27a5446, Offset: 0xa297
// Size: 0x162
function private function_c4a5b66e03fdbbbf( b_counter_clockwise )
{
    switch ( self.var_5a1c348306d6ea19 )
    {
        case #"hash_b9ff0a9f617355e4":
            new_direction = b_counter_clockwise ? "west" : "east";
            break;
        case #"hash_22ce3b03c1e51a9c":
            new_direction = b_counter_clockwise ? "north" : "south";
            break;
        case #"hash_fbd39e4f5634905a":
            new_direction = b_counter_clockwise ? "east" : "west";
            break;
        case #"hash_a1e9b77432f55b0e":
            new_direction = b_counter_clockwise ? "south" : "north";
            break;
        default:
            break;
    }
    
    self.var_5a1c348306d6ea19 = new_direction;
    
    /#
        self notify( #"hash_31035f061d750027" );
        
        if ( self.icon.debug_text )
        {
            self.icon.debug_text = self.icon.str_symbol + "<dev string:xd1>" + new_direction;
            thread debug_print_text( self.icon.origin + ( 0, 0, 10 ), self.icon.debug_text, "<dev string:xa4>" );
        }
    #/
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xe274cdf3, Offset: 0xa401
// Size: 0x148
function private function_61df5b1f2e3a25da( sconce )
{
    a_pillars = [];
    
    switch ( sconce.n_index )
    {
        case 1:
            pillar_1 = level.scarab_ww_quest.var_daae8a1d00edada6[ 1 ];
            break;
        case 2:
            pillar_1 = level.scarab_ww_quest.var_daae8a1d00edada6[ 4 ];
            break;
        case 3:
            pillar_1 = level.scarab_ww_quest.var_daae8a1d00edada6[ 3 ];
            break;
    }
    
    a_pillars[ 0 ] = pillar_1;
    
    switch ( sconce.n_index )
    {
        case 1:
            pillar_2 = level.scarab_ww_quest.var_daae8a1d00edada6[ 3 ];
            break;
        case 2:
            pillar_2 = level.scarab_ww_quest.var_daae8a1d00edada6[ 2 ];
            break;
        case 3:
            pillar_2 = level.scarab_ww_quest.var_daae8a1d00edada6[ 4 ];
            break;
    }
    
    a_pillars[ 1 ] = pillar_2;
    return a_pillars;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xd380f225, Offset: 0xa552
// Size: 0xbd, Type: bool
function private function_28b4c383f06f8181()
{
    foreach ( var_7e7ca0a63d1d515e in level.scarab_ww_quest.var_daae8a1d00edada6 )
    {
        solution_direction = level.scarab_ww_quest.var_a2be214d8c2fa691[ var_7e7ca0a63d1d515e.n_index - 1 ];
        
        if ( var_7e7ca0a63d1d515e.var_5a1c348306d6ea19 != solution_direction )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x94f61623, Offset: 0xa618
// Size: 0x5f
function private function_c9481c5b9aae24f0( direction )
{
    switch ( direction )
    {
        case #"hash_b9ff0a9f617355e4":
            return 0;
        case #"hash_22ce3b03c1e51a9c":
            return 1;
        case #"hash_fbd39e4f5634905a":
            return 2;
        case #"hash_a1e9b77432f55b0e":
            return 3;
        default:
            return 0;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xbb051782, Offset: 0xa67f
// Size: 0x94
function private function_e09520908dad62b7( var_7e7ca0a63d1d515e, b_counter_clockwise = 0 )
{
    solution_direction = level.scarab_ww_quest.var_a2be214d8c2fa691[ var_7e7ca0a63d1d515e.n_index - 1 ];
    current_index = level function_c9481c5b9aae24f0( var_7e7ca0a63d1d515e.var_5a1c348306d6ea19 );
    solution_index = level function_c9481c5b9aae24f0( solution_direction );
    
    if ( b_counter_clockwise )
    {
        return ( ( current_index - solution_index + 4 ) % 4 );
    }
    
    return ( solution_index - current_index + 4 ) % 4;
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x95301616, Offset: 0xa71c
// Size: 0x12f
function private function_b4363bff6c49ec8a( sconce_index, n_pulls )
{
    if ( n_pulls <= 0 )
    {
        return;
    }
    
    switch ( sconce_index )
    {
        case 1:
            switch ( n_pulls )
            {
                case 1:
                    return #"hash_bc9ea5a8446143f0";
                case 2:
                    return #"hash_bc9ea8a844614909";
                default:
                    return #"hash_bc9ea7a844614756";
            }
        case 2:
            switch ( n_pulls )
            {
                case 1:
                    return #"hash_2140bd1b357364c1";
                case 2:
                    return #"hash_2140ba1b35735fa8";
                default:
                    return #"hash_2140bb1b3573615b";
            }
        case 3:
            switch ( n_pulls )
            {
                case 1:
                    return #"hash_a7a4c908b2f22490";
                case 2:
                    return #"hash_a7a4cc08b2f229a9";
                default:
                    return #"hash_a7a4cb08b2f227f6";
            }
            
            break;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xa8f50520, Offset: 0xa853
// Size: 0x1c0
function private function_c3262176052b9bb8()
{
    galaxy_pillar = level.scarab_ww_quest.var_daae8a1d00edada6[ 1 ];
    galaxy_pulls = level function_e09520908dad62b7( galaxy_pillar, 0 );
    
    if ( galaxy_pulls > 0 )
    {
        sconce = level.scarab_ww_quest.var_53d2453af4d1d4bf[ 1 ];
        
        if ( sconce && sconce.handle )
        {
            return { #guidance_ref:level function_b4363bff6c49ec8a( 1, galaxy_pulls ), #sconce_handle:sconce.handle };
        }
    }
    
    moon_pillar = level.scarab_ww_quest.var_daae8a1d00edada6[ 2 ];
    moon_pulls = level function_e09520908dad62b7( moon_pillar, 1 );
    
    if ( moon_pulls > 0 )
    {
        sconce = level.scarab_ww_quest.var_53d2453af4d1d4bf[ 2 ];
        
        if ( sconce && sconce.handle )
        {
            return { #guidance_ref:level function_b4363bff6c49ec8a( 2, moon_pulls ), #sconce_handle:sconce.handle };
        }
    }
    
    comet_pillar = level.scarab_ww_quest.var_daae8a1d00edada6[ 3 ];
    comet_pulls = level function_e09520908dad62b7( comet_pillar, 0 );
    
    if ( comet_pulls > 0 )
    {
        sconce = level.scarab_ww_quest.var_53d2453af4d1d4bf[ 3 ];
        
        if ( sconce && sconce.handle )
        {
            return { #guidance_ref:level function_b4363bff6c49ec8a( 3, comet_pulls ), #sconce_handle:sconce.handle };
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x8286688a, Offset: 0xaa1c
// Size: 0x1ab
function private function_b575ed6a4a924834( triggering_player, b_skipped = 0 )
{
    if ( !b_skipped )
    {
        playsoundatpos( level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.origin, "evt_fail_stinger" );
    }
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        level zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"riddle_failed", 1 );
    }
    
    level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle setscriptablepartstate( "body", "retract" );
    level utility::flag_clear( "w_e_p_tundra" );
    
    foreach ( sconce in level.scarab_ww_quest.var_53d2453af4d1d4bf )
    {
        sconce.handle setscriptablepartstate( "body", "retract" );
    }
    
    if ( triggering_player )
    {
        triggering_player utility::delaythread( 0.5, &function_c99b85fe440b3386, "wwq_vo_riddle_puzzle_fail_first_time", "scarab_scw2_riddle_puzzle_fail_first_time" );
    }
    
    level thread function_f431baac117aaaea();
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level utility::delaythread( 0.1, &function_303136443788ced7 );
    }
    else
    {
        level callback::add( "on_round_start", &function_47811134e8bf6ea6 );
    }
    
    level utility::delaythread( 0.5, &function_51f12524c830dd09 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x343dfc4e, Offset: 0xabcf
// Size: 0x17
function private function_303136443788ced7()
{
    level utility::flag_waitopen( "b_p_f_m_onyx" );
    level function_e30dc30b52613962();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xc4ac8af5, Offset: 0xabee
// Size: 0x31
function private function_47811134e8bf6ea6( params )
{
    if ( level zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    level callback::remove( "on_round_start", &function_47811134e8bf6ea6 );
    level function_e30dc30b52613962();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xe092e6fa, Offset: 0xac27
// Size: 0xb9
function private function_e30dc30b52613962()
{
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"riddle_failed", 0 );
    level thread function_51f12524c830dd09();
    
    foreach ( sconce in level.scarab_ww_quest.var_53d2453af4d1d4bf )
    {
        sconce.handle setscriptablepartstate( "body", "available" );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x76c2728e, Offset: 0xace8
// Size: 0xa2
function private function_f431baac117aaaea()
{
    level utility::flag_set( "b_p_f_m_onyx" );
    
    foreach ( var_7e7ca0a63d1d515e in level.scarab_ww_quest.var_daae8a1d00edada6 )
    {
        var_7e7ca0a63d1d515e thread function_1002e5a6dbaf7175();
    }
    
    wait 5;
    level utility::flag_clear( "b_p_f_m_onyx" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x5423230f, Offset: 0xad92
// Size: 0x84
function private function_1002e5a6dbaf7175()
{
    if ( self.var_5a1c348306d6ea19 != self.var_da2421e332e781c4 )
    {
        thread function_f57f597d4877cf61();
        self.fx_top setscriptablepartstate( "fx", "dust_falling" );
        self.fx_bottom setscriptablepartstate( "fx", "dust_falling" );
        self.var_5a1c348306d6ea19 = self.var_da2421e332e781c4;
        self rotateto( self.original_angles, 5, 0.2 );
        self waittill( #"rotatedone" );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xd1c77880, Offset: 0xae1e
// Size: 0x713
function private function_5809d36b4d695bb3( b_skipped = 0, triggering_player = undefined )
{
    if ( level utility::flag( "WW_STEP_6_COMPLETE" ) )
    {
        return;
    }
    
    level utility::flag_set( "WW_STEP_6_COMPLETE" );
    level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle setscriptablepartstate( "body", "used_to_off" );
    
    foreach ( sconce in level.scarab_ww_quest.var_53d2453af4d1d4bf )
    {
        sconce.handle setscriptablepartstate( "body", "retract" );
    }
    
    /#
        iprintlnbold( "<dev string:xd5>" );
    #/
    
    level function_43643ed1b151a972();
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"riddle_solved", 1 );
    
    foreach ( var_7e7ca0a63d1d515e in level.scarab_ww_quest.var_daae8a1d00edada6 )
    {
        if ( var_7e7ca0a63d1d515e.fx_top )
        {
            var_7e7ca0a63d1d515e.fx_top freescriptable();
        }
        
        if ( var_7e7ca0a63d1d515e.fx_bottom )
        {
            var_7e7ca0a63d1d515e.fx_bottom freescriptable();
        }
    }
    
    if ( b_skipped )
    {
        level thread function_5cc6c228350c4da9();
        var_41604c028f54cbea = getentarray( "doorbuy_door_17", #targetname );
        
        foreach ( door in var_41604c028f54cbea )
        {
            door thread doorbuy::doorbuy_used( undefined, undefined, 1 );
        }
        
        level thread function_86cdfad3b0402c85( b_skipped );
        level thread function_51f12524c830dd09();
    }
    else
    {
        level endon( #"game_ended" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level function_c01363ed17a6efa2();
            level zm_quest::function_fba942a1cfd85f5d( 1, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_571f27482dab434c" );
            level zm_quest::function_fb3af5600f6a9441( 4, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_571f27482dab434c" );
            level utility::delaythread( 16, &function_27a278d02a1a6973 );
        }
        
        earthquake( 0.5, 3, level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.origin, 700 );
        playrumbleonposition( "heavy_2s", level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.origin );
        playworldsound( level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.origin, #"hash_a2b013f4cad82bb1" );
        level zm_music::function_446e6e39d7feeb7c( [ "zone_ne_temple_finalroom", "zone_ne_temple_westwing", "zone_ne_temple_eastwing", "zone_ne_temple_mainhall" ], #"pillar_success" );
        wait 2;
        
        foreach ( player in level.players )
        {
            zone = player zone_manager::get_current_zone();
            
            if ( !zone.zone_name || !arraycontains( [ "zone_ne_temple_finalroom", "zone_ne_temple_westwing", "zone_ne_temple_eastwing", "zone_ne_temple_mainhall" ], zone.zone_name ) )
            {
                continue;
            }
            
            player val::set( "scarab_wwq_riddle", "round_spawning_ignore_player", 1 );
            player utility::delaythread( 10, &val::reset_all, "scarab_wwq_riddle" );
        }
        
        zm_quest::cleanup_zombies_manually( undefined, [ "zone_ne_temple_finalroom", "zone_ne_temple_westwing", "zone_ne_temple_eastwing", "zone_ne_temple_mainhall" ], undefined, undefined, 0, 0, undefined, 1, undefined, undefined, 1 );
        wait 1;
        var_41604c028f54cbea = getentarray( "doorbuy_door_17", #targetname );
        
        foreach ( door in var_41604c028f54cbea )
        {
            door thread doorbuy::doorbuy_used( undefined, undefined, 1 );
        }
        
        var_1d85038f83a4a385 = spawnscriptable( %"hash_1e4de21471b0e433", level.scarab_ww_quest.middle_pillar_platform.origin, level.scarab_ww_quest.middle_pillar_platform.angles );
        var_1d85038f83a4a385 utility::scriptable_setparententity( level.scarab_ww_quest.middle_pillar_platform );
        
        if ( var_1d85038f83a4a385 )
        {
            var_1d85038f83a4a385 setscriptablepartstate( "fx", "secret_room_open_dust" );
            var_1d85038f83a4a385 utility::delaythread( 8, &function_73d48da3244c80bd );
        }
        
        if ( isalive( triggering_player ) )
        {
            triggering_player thread function_c99b85fe440b3386( "wwq_vo_riddle_puzzle_success", "scarab_scw2_riddle_puzzle_success" );
        }
        
        level function_86cdfad3b0402c85();
    }
    
    level thread function_71d4540241921869( 1 );
    
    if ( level.scarab_ww_quest.middle_pillar.fx_top )
    {
        level.scarab_ww_quest.middle_pillar.fx_top freescriptable();
    }
    
    if ( level.scarab_ww_quest.middle_pillar.fx_bottom )
    {
        level.scarab_ww_quest.middle_pillar.fx_bottom freescriptable();
    }
    
    level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle freescriptable();
    level.scarab_ww_quest.var_1ea0b28c0ef8cc7f freescriptable();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x10a84d76, Offset: 0xb539
// Size: 0x70
function private function_27a278d02a1a6973()
{
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_571f27482dab434c" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_571f27482dab434c" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xad720184, Offset: 0xb5b1
// Size: 0x158
function private function_43643ed1b151a972()
{
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    foreach ( symbol in level.scarab_ww_quest.var_54c01efdbeed8e49 )
    {
        if ( !symbol utility::ent_flag( "wwq_observed_temple_symbol" ) )
        {
            symbol utility::ent_flag_set( "wwq_observed_temple_symbol" );
        }
        
        symbol notify( #"hash_9d20391ac1bb8072" );
    }
    
    foreach ( var_7e7ca0a63d1d515e in level.scarab_ww_quest.var_daae8a1d00edada6 )
    {
        if ( !var_7e7ca0a63d1d515e utility::ent_flag( "wwq_observed_riddle_pillar" ) )
        {
            var_7e7ca0a63d1d515e utility::ent_flag_set( "wwq_observed_riddle_pillar" );
        }
        
        var_7e7ca0a63d1d515e notify( #"hash_9d20391ac1bb8072" );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xe4472f6, Offset: 0xb711
// Size: 0x1e
function private function_73d48da3244c80bd()
{
    self setscriptablepartstate( "fx", "central_pillar_dust_ground" );
    utility::delaycall( 1, &freescriptable );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x916b885e, Offset: 0xb737
// Size: 0x478
function private function_86cdfad3b0402c85( b_skipped = 0 )
{
    var_7e7ca0a63d1d515e = level.scarab_ww_quest.middle_pillar;
    pillar_platform = level.scarab_ww_quest.middle_pillar_platform;
    var_7e7ca0a63d1d515e.e_mover = utility::spawn_model( "tag_origin", pillar_platform.origin, pillar_platform.angles );
    pillar_platform linkto( var_7e7ca0a63d1d515e.e_mover, "tag_origin" );
    origin_offset = var_7e7ca0a63d1d515e.origin - pillar_platform.origin;
    angles_offset = var_7e7ca0a63d1d515e.angles - pillar_platform.angles;
    var_7e7ca0a63d1d515e linkto( var_7e7ca0a63d1d515e.e_mover, "tag_origin", origin_offset, angles_offset );
    
    foreach ( cylinder in level.scarab_ww_quest.middle_pillar.var_79e17c7d9b7ed858 )
    {
        origin_offset = cylinder.origin - pillar_platform.origin;
        angles_offset = cylinder.angles - pillar_platform.angles;
        cylinder linkto( var_7e7ca0a63d1d515e.e_mover, "tag_origin", origin_offset, angles_offset );
    }
    
    var_8b0c1d8a8ff1a6a0 = ( level.scarab_ww_quest.middle_pillar.origin[ 0 ], level.scarab_ww_quest.middle_pillar.origin[ 1 ], 1212 );
    
    if ( !b_skipped )
    {
        level thread function_f30328a74a105f1c();
        var_7e7ca0a63d1d515e thread function_7e56c82bffe2cb9b();
        var_7e7ca0a63d1d515e.fx_top setscriptablepartstate( "fx", "dust_falling_one_shot" );
        var_7e7ca0a63d1d515e.fx_bottom setscriptablepartstate( "fx", "snow_dust" );
        var_7e7ca0a63d1d515e.fx_bottom utility::delaycall( 6, &setscriptablepartstate, "fx", "off" );
        var_7e7ca0a63d1d515e.e_mover moveto( var_8b0c1d8a8ff1a6a0, 8 );
        playsoundatpos( var_7e7ca0a63d1d515e.e_mover.origin, #"hash_cf57e23a80eec366" );
        wait 4;
        level.scarab_ww_quest.var_cf7bec2424e2cfc5.origin = var_8b0c1d8a8ff1a6a0;
        wait 4;
        var_7e7ca0a63d1d515e.e_mover.origin = var_8b0c1d8a8ff1a6a0;
        a_players = getplayersinradius( var_7e7ca0a63d1d515e.e_mover.origin, 800 );
        
        foreach ( player in a_players )
        {
            player playrumbleonentity( "damage_heavy" );
            player earthquakeforplayer( 0.8, 1.2, var_7e7ca0a63d1d515e.e_mover.origin, 800 );
        }
        
        var_7e7ca0a63d1d515e.fx_top setscriptablepartstate( "fx", "off" );
        var_7e7ca0a63d1d515e.fx_bottom setscriptablepartstate( "fx", "off" );
    }
    else
    {
        var_7e7ca0a63d1d515e.e_mover.origin = var_8b0c1d8a8ff1a6a0;
        waitframe();
    }
    
    destroynavobstacle( level.scarab_ww_quest.middle_pillar.var_12aadf5d8bbfdafd );
    level.scarab_ww_quest.var_cf7bec2424e2cfc5 delete();
    level.scarab_ww_quest.var_13e0e7b9a12e6637 delete();
    level.scarab_ww_quest.middle_pillar delete();
    var_7e7ca0a63d1d515e.e_mover delete();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xa81f7980, Offset: 0xbbb7
// Size: 0x105
function private function_7e56c82bffe2cb9b()
{
    self.e_mover endon( #"death" );
    self.e_mover endon( #"movedone" );
    timer = 0;
    
    while ( true )
    {
        if ( timer >= 7.7 )
        {
            return;
        }
        
        a_players = getplayersinradius( self.origin, 800 );
        
        foreach ( player in a_players )
        {
            player playrumbleonentity( "low_highfreq" );
            player earthquakeforplayer( 0.15, 0.2, self.origin, 800 );
        }
        
        wait 0.1;
        timer += 0.1;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xabde6468, Offset: 0xbcc4
// Size: 0x188
function private function_f30328a74a105f1c()
{
    e_mover = utility::spawn_model( "tag_origin", level.scarab_ww_quest.middle_pillar.origin, level.scarab_ww_quest.middle_pillar.angles );
    e_mover linkto( level.scarab_ww_quest.middle_pillar.e_mover );
    middle_sconce = level.scarab_ww_quest.var_1ea0b28c0ef8cc7f;
    v_world_offset = middle_sconce.origin - e_mover.origin;
    var_c101d0c597f924b8 = ( vectordot( v_world_offset, anglestoforward( e_mover.angles ) ), vectordot( v_world_offset, anglestoright( e_mover.angles ) ), vectordot( v_world_offset, anglestoup( e_mover.angles ) ) );
    var_5d692dcd860dbfb0 = middle_sconce.angles - e_mover.angles;
    middle_sconce utility::scriptable_setparententity( e_mover, var_c101d0c597f924b8, var_5d692dcd860dbfb0 );
    middle_sconce.handle utility::scriptable_setparententity( e_mover, var_c101d0c597f924b8, var_5d692dcd860dbfb0 );
    level.scarab_ww_quest.middle_pillar linkto( e_mover );
    e_mover function_f137e973856d34d9( ( 0, 540, 0 ), 8 );
    e_mover waittill( #"rotatedone" );
    e_mover delete();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x8e68ec9a, Offset: 0xbe54
// Size: 0x11f
function private function_9a2dc21edaaa9395()
{
    spawners = utility::getstructarray( "eq_s_a_s", "targetname" );
    level.scarab_ww_quest.var_1d9844be4c815ef7 = [];
    
    foreach ( spawner in spawners )
    {
        var_d7b3a1f33b95bf77 = 0;
        
        while ( !var_d7b3a1f33b95bf77 )
        {
            zombies_count = zm_utility::get_active_zombies_count();
            
            if ( zombies_count >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
            {
                var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ], level.scarab_ww_quest.var_1d9844be4c815ef7 );
            }
            else
            {
                var_d7b3a1f33b95bf77 = 1;
            }
            
            if ( !var_d7b3a1f33b95bf77 )
            {
                waitframe();
                continue;
            }
        }
        
        level thread function_82df5d41f1b83b7a( spawner );
        wait 0.1;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x7d71249e, Offset: 0xbf7b
// Size: 0xad
function private function_82df5d41f1b83b7a( spawner )
{
    zombie = agent_manager::spawn_agent( "zombie_loom_minion", spawner.origin, spawner.angles, "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        zombie.ignore_enemy_count = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie zombie_utils::function_a8ce00e0448cb6f0( "sprint", "terminus_wwq_bc_ambush", 9998 );
        zombie thread zone_spawner::function_ce10e453e7f7bb8e( spawner );
        level.scarab_ww_quest.var_1d9844be4c815ef7[ level.scarab_ww_quest.var_1d9844be4c815ef7.size ] = zombie;
    }
    
    return zombie;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x94acb561, Offset: 0xc031
// Size: 0xd6
function private function_5cc6c228350c4da9()
{
    level utility::flag_wait( "w_r_e_hollow" );
    
    foreach ( var_7e7ca0a63d1d515e in level.scarab_ww_quest.var_daae8a1d00edada6 )
    {
        solution_direction = level.scarab_ww_quest.var_a2be214d8c2fa691[ var_7e7ca0a63d1d515e.n_index - 1 ];
        
        while ( var_7e7ca0a63d1d515e.var_5a1c348306d6ea19 != solution_direction )
        {
            var_7e7ca0a63d1d515e rotate_pillar( 0, 1 );
            waitframe();
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x56db7061, Offset: 0xc10f
// Size: 0x21f
function private function_c3ac50469bfbc1aa()
{
    if ( level utility::flag( "w_p_d_a_orchid" ) || level utility::flag( "w_s_9_c_spruce" ) )
    {
        return;
    }
    
    level utility::flag_set( "w_p_d_a_orchid" );
    level.scarab_ww_quest.var_8c3e8c1e5569746 = 20;
    level.scarab_ww_quest.var_fe5620e942a1ed76 = 0;
    level.scarab_ww_quest.var_d66b98d2d523210f = gettime();
    level.scarab_ww_quest.var_e00b1b38507a027 = 0;
    level.scarab_ww_quest.var_8e03328a39e60e6c = gettime();
    level.scarab_ww_quest.var_a2e6932bb574a4b0 = randomfloatrange( 7, 8 );
    level zm_music::start_zone_music_watcher( "vine_defend", [ "zone_sw_temple_sideroom" ], #"vine_defend" );
    level thread function_51f12524c830dd09();
    plant = level.scarab_ww_quest.center_vine;
    plant.attack_ent = utility::spawn_model( "tag_origin", level.scarab_ww_quest.var_fa1360bbeab603e7.origin + ( 0, 0, 256 ), level.scarab_ww_quest.var_fa1360bbeab603e7.angles );
    plant.attack_ent.team = "team_hundred_ninety";
    level.scarab_ww_quest.var_fa1360bbeab603e7 setscriptablepartstate( "fx", "growing" );
    level zm_quest::function_fba942a1cfd85f5d( 1, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f97fd6235be10e93" );
    level zm_quest::function_fb3af5600f6a9441( 2, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f97fd6235be10e93" );
    level function_cdd675c225c4327d( 0 );
    level thread function_13d1602e3fe7c57();
    level thread function_450248fe87d0aa6c();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x95791d1b, Offset: 0xc336
// Size: 0x1e6
function private function_13d1602e3fe7c57()
{
    level endon( #"game_ended" );
    level endon( #"hash_98ba81d2960f222f" );
    round_number = zm_round_logic::get_rb_round_number();
    var_cfdcb332178e0755 = [ "zone_sw_temple_sideroom" ];
    a_alive_players = utility::get_alive_players();
    max_spawn_count = a_alive_players.size * 4 + 2;
    spawner_zombie_type = "zombie_base";
    level.scarab_ww_quest.var_f55d5d2d3244f47d = [];
    
    while ( true )
    {
        zombies_count = zm_utility::get_active_zombies_count();
        var_62b73c35531aa69e = getaiarrayinradius( level.scarab_ww_quest.center_vine.origin, 750, zm_utility::get_zombie_team() );
        
        if ( zombies_count >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
        {
            var_29155e0ed4821acf = arraycombineunique( var_62b73c35531aa69e, level.scarab_ww_quest.var_f55d5d2d3244f47d );
            var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ], var_29155e0ed4821acf );
            
            if ( !var_d7b3a1f33b95bf77 )
            {
                waitframe();
                continue;
            }
        }
        
        if ( var_62b73c35531aa69e.size >= max_spawn_count )
        {
            waitframe();
            continue;
        }
        
        spawners = zone_spawner::function_20c574a6ba7cc5c6( var_cfdcb332178e0755, spawner_zombie_type );
        
        if ( !isdefined( spawners ) || spawners.size <= 0 )
        {
            waitframe();
            continue;
        }
        
        zmb_spawner = utility::array_random( spawners );
        spawnerdist = distancesquared( level.scarab_ww_quest.center_vine.origin, zmb_spawner.origin );
        
        if ( spawnerdist > squared( 650 ) )
        {
            waitframe();
            continue;
        }
        
        level thread function_54d1adbb85f0d5ca( spawner_zombie_type, zmb_spawner, round_number, level.scarab_ww_quest.var_f55d5d2d3244f47d );
        wait 2;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x6d6326c1, Offset: 0xc524
// Size: 0x21c
function private function_450248fe87d0aa6c()
{
    level endon( #"game_ended" );
    level endon( #"hash_98ba81d2960f222f" );
    var_eb05479b90fc2476 = 0;
    level function_cdd675c225c4327d( level.scarab_ww_quest.var_26e8aa9db02e7109 );
    
    while ( true )
    {
        if ( level.scarab_ww_quest.var_e00b1b38507a027 )
        {
            var_eb05479b90fc2476 = 0;
            wait 0.1;
            continue;
        }
        
        a_players = function_685fa266d30f547c( 550 );
        var_2c568e2791a115b1 = function_adc498d8f217e1bf( a_players );
        
        if ( var_2c568e2791a115b1 )
        {
            var_eb05479b90fc2476 = 0;
            
            if ( utility::time_has_passed( level.scarab_ww_quest.var_8e03328a39e60e6c, level.scarab_ww_quest.var_a2e6932bb574a4b0 ) )
            {
                level.scarab_ww_quest.var_e00b1b38507a027 = 1;
                level.scarab_ww_quest.var_8e03328a39e60e6c = gettime();
                level.scarab_ww_quest.var_a2e6932bb574a4b0 = randomfloatrange( 7, 8 );
                level thread function_5b4a4714a6b77289( var_2c568e2791a115b1 );
            }
            
            wait 0.1;
            continue;
        }
        
        if ( level.scarab_ww_quest.var_26e8aa9db02e7109 <= 0 && utility::time_has_passed( level.scarab_ww_quest.var_d66b98d2d523210f, 5 ) )
        {
            level thread function_abec93ff93cd59ff();
            return;
        }
        
        if ( !var_eb05479b90fc2476 )
        {
            var_eb05479b90fc2476 = gettime();
        }
        
        var_6b21105ac7f30d32 = utility::function_6f5d2e1f1ff70482( gettime() - var_eb05479b90fc2476 );
        var_74944d2cdc5af616 = ( 1.5 + var_6b21105ac7f30d32 * 1 ) * 0.1;
        
        if ( a_players.size > 0 )
        {
            var_74944d2cdc5af616 *= 0.25;
        }
        
        level function_cdd675c225c4327d( level.scarab_ww_quest.var_26e8aa9db02e7109 - var_74944d2cdc5af616 );
        
        if ( level.scarab_ww_quest.var_26e8aa9db02e7109 <= 0 && utility::time_has_passed( level.scarab_ww_quest.var_d66b98d2d523210f, 5 ) )
        {
            level thread function_abec93ff93cd59ff();
            return;
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x54b8214b, Offset: 0xc748
// Size: 0xdb
function private function_adc498d8f217e1bf( a_players )
{
    var_af19f3f09208be90 = undefined;
    best_health = 0;
    
    foreach ( player in a_players )
    {
        if ( isalive( player ) && !player.inlaststand && player.health >= 30 && player.health > best_health )
        {
            var_af19f3f09208be90 = player;
            best_health = player.health;
        }
    }
    
    return var_af19f3f09208be90;
}

// Namespace zm_sat_scarab_ww_quest
// Params 4, eflags: 0x4
// Checksum 0x5f4220fc, Offset: 0xc82c
// Size: 0x9f
function private function_c8615c29b189b961( player, attack_ent, life_drain_beam_fx, var_f267475281d5704f = 1 )
{
    if ( life_drain_beam_fx )
    {
        life_drain_beam_fx delete();
    }
    
    if ( isalive( player ) )
    {
        player setscriptablepartstate( "scarab_wwq_fx", "life_drain_off", 0 );
    }
    
    level.scarab_ww_quest.var_fa1360bbeab603e7 setscriptablepartstate( "life_drain", "off" );
    level.scarab_ww_quest.var_e00b1b38507a027 = 0;
    
    if ( var_f267475281d5704f )
    {
        level notify( #"hash_9a7d49152761071f" );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0xc
// Checksum 0x7694b3d5, Offset: 0xc8d3
// Size: 0x27e
function private function_5b4a4714a6b77289( player, var_dc58879cfee40e71 )
{
    self notify( #"hash_4a844955a3904109" );
    self endon( #"hash_4a844955a3904109" );
    player.var_20a4a655261f6172 = 0;
    n_damage = 5;
    var_bd11f1adca7f178d = 0;
    var_1fd065c9c2fbe679 = 0;
    
    if ( !isdefined( var_dc58879cfee40e71 ) )
    {
        var_dc58879cfee40e71 = 5;
    }
    
    start_time = gettime();
    
    if ( isalive( player ) && player isscriptable() )
    {
        player setscriptablepartstate( "scarab_wwq_fx", "life_drain", 0 );
    }
    
    level.scarab_ww_quest.var_fa1360bbeab603e7 setscriptablepartstate( "life_drain", "on" );
    attack_ent = level.scarab_ww_quest.center_vine.attack_ent;
    life_drain_beam_fx = playfxontagsbetweenclients( utility::getfx( "ww_plant_life_drain_beam" ), attack_ent, "tag_origin", player, "j_spine4" );
    var_44268d0bd95ace85 = level.scarab_ww_quest.var_26e8aa9db02e7109;
    attack_ent playsound( #"hash_4f00a88630a31687" );
    
    while ( isalive( player ) && !player.inlaststand && level utility::flag( "w_p_d_a_orchid" ) )
    {
        curr_time = gettime();
        
        if ( utility::time_has_passed( start_time, var_dc58879cfee40e71 ) )
        {
            break;
        }
        
        time_elapsed = curr_time - start_time;
        level function_cdd675c225c4327d( var_44268d0bd95ace85 + time_elapsed / utility::function_4b74c15943231980( 5 ) * 30 );
        
        if ( level.scarab_ww_quest.var_26e8aa9db02e7109 >= 100 )
        {
            level function_c8615c29b189b961( player, attack_ent, life_drain_beam_fx, 0 );
            level thread function_fbed4d5a0a9b7cfe();
            return;
        }
        
        dist_sq = distancesquared( player.origin, attack_ent.origin );
        
        if ( dist_sq > squared( 550 ) )
        {
            level function_c8615c29b189b961( player, attack_ent, life_drain_beam_fx );
            return;
        }
        
        if ( curr_time - var_bd11f1adca7f178d >= utility::function_4b74c15943231980( 0.5 ) )
        {
            if ( player.health <= n_damage )
            {
                level function_c8615c29b189b961( player, attack_ent, life_drain_beam_fx );
                return;
            }
            
            player dodamage( n_damage, player.origin, attack_ent, attack_ent, "MOD_PROJECTILE", undefined, "torso_upper" );
            var_bd11f1adca7f178d = curr_time;
            var_1fd065c9c2fbe679++;
        }
        
        wait 0.05;
    }
    
    level function_c8615c29b189b961( player, attack_ent, life_drain_beam_fx );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xc45dbd1c, Offset: 0xcb59
// Size: 0x29
function private function_7c95b410b6bcc3f1()
{
    level endon( #"game_ended" );
    self endon( #"zm_quest_step_tracker_showing" );
    wait 10;
    self notify( #"splash_before_tracker_timeout" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x7359e940, Offset: 0xcb8a
// Size: 0xd0
function private function_abec93ff93cd59ff()
{
    level endon( #"game_ended" );
    
    /#
        iprintlnbold( "<dev string:xeb>" );
    #/
    
    level zm_music::function_e9fd14ede793ef0d( "vine_defend" );
    level.scarab_ww_quest.var_fe5620e942a1ed76 = gettime();
    level function_cdd675c225c4327d( 0 );
    level function_4f15ee9c0696c9db();
    level.scarab_ww_quest.var_fa1360bbeab603e7 setscriptablepartstate( "fx", "fail" );
    level zm_quest::function_fb3af5600f6a9441( 3, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f97fd6235be10e93" );
    waitframe();
    level thread zm_quest::function_80abdea0cd4c89a7( #"scarab_ww_quest", #"hash_8f84615ebd6df36d" );
    utility::delaythread( 1, &function_51f12524c830dd09 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xb61d488b, Offset: 0xcc62
// Size: 0x331
function private function_fbed4d5a0a9b7cfe( b_skipped, b_save_restored )
{
    /#
        iprintlnbold( "<dev string:x100>" );
    #/
    
    level zm_music::function_446e6e39d7feeb7c( [ "zone_sw_temple_sideroom" ], #"vine_defend_success" );
    level zm_music::function_e9fd14ede793ef0d( "vine_defend" );
    
    if ( !b_skipped )
    {
        player = level function_1ee83ba3397514ac( level.scarab_ww_quest.center_vine.origin, 700, 1 );
        
        if ( player )
        {
            player utility::delaythread( 4, &function_e7337c56375cb30e, "scarab_scw1_restore_vines_success", #"bc_flavor_player_positive" );
        }
    }
    
    level utility::flag_set( "w_s_9_c_spruce" );
    level function_4f15ee9c0696c9db( b_skipped );
    level.scarab_ww_quest.center_vine setscriptablepartstate( "body", "cleansed" );
    level.scarab_ww_quest.var_fa1360bbeab603e7 setscriptablepartstate( "fx", "cleansed" );
    
    foreach ( set_dressing in level.scarab_ww_quest.var_ce709afc89da3cb7 )
    {
        state_name = set_dressing getscriptablepartstate( "body" );
        set_dressing setscriptablepartstate( "body", state_name + "_charged" );
    }
    
    current_round = zm_round_logic::get_rb_round_number();
    var_3c35d5bd581440d9 = level zm_quest::function_b0a5181ebe7bb905() ? 7 : 8;
    var_39962c36b9c1a4e4 = current_round >= var_3c35d5bd581440d9 && !level.scarab_ww_quest.cosmic_fruit;
    var_3308f73418c43ad2 = zm_quest::get_quest_step( #"scarab_ww_quest", #"hash_35331de6580ad19f" );
    
    if ( ( !b_skipped || b_skipped && !var_3308f73418c43ad2.completed ) && !var_39962c36b9c1a4e4 )
    {
        level.scarab_ww_quest.fruit_fx setscriptablepartstate( "fx", "growing" );
        level.scarab_ww_quest.fruit_fx setscriptablepartstate( "audio", "growing" );
    }
    
    level callback::add( "on_round_start", &function_f1b761703feb2572 );
    level function_3884f55eec09766f();
    
    if ( var_39962c36b9c1a4e4 && !b_save_restored )
    {
        level utility::delaythread( 0.5, &spawn_cosmic_fruit );
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread function_ebe81e9a0ad36841();
        return;
    }
    
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f97fd6235be10e93" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f97fd6235be10e93" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xda8c9e33, Offset: 0xcf9b
// Size: 0xaa
function private function_ebe81e9a0ad36841()
{
    wait 0.6;
    level zm_quest::function_fb3af5600f6a9441( 4, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f97fd6235be10e93" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f97fd6235be10e93" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f97fd6235be10e93" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x3f70b127, Offset: 0xd04d
// Size: 0x19e
function private spawn_cosmic_fruit()
{
    level.scarab_ww_quest.fruit_fx setscriptablepartstate( "fx", "off" );
    level.scarab_ww_quest.fruit_fx setscriptablepartstate( "audio", "grown" );
    level utility::flag_clear( "w_c_f_c_i_p_ember" );
    
    if ( level.scarab_ww_quest.cosmic_fruit )
    {
        level.scarab_ww_quest.cosmic_fruit delete();
    }
    
    level.scarab_ww_quest.cosmic_fruit = utility::spawn_model( %"hash_5ab34868ff8ffed5", level.scarab_ww_quest.fruit_spawn_origin, level.scarab_ww_quest.fruit_spawn_angles );
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"hash_4bcd57abae316a12", 0 );
    level utility::flag_set( "w_f_s_f_t_zephyr" );
    level.scarab_ww_quest.cosmic_fruit setscriptablepartstate( "fx", "on" );
    
    if ( level.scarab_ww_quest.cosmic_fruit_interact )
    {
        level.scarab_ww_quest.cosmic_fruit_interact zm_quest::function_9170db4686f796e2();
    }
    
    level.scarab_ww_quest.cosmic_fruit_interact = zm_quest::function_91f9590e98d57ff6( level.scarab_ww_quest.fruit_spawn_origin, &function_7d3a4c029d37e71a, &cosmic_fruit_hint, "small" );
    level notify( #"cf_spawned" );
    level utility::delaythread( 0.5, &function_51f12524c830dd09 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xd5e12aec, Offset: 0xd1f3
// Size: 0xeb
function private function_87b03f10b7d1f37c( b_play_despawn_fx = 1 )
{
    if ( b_play_despawn_fx )
    {
        level.scarab_ww_quest.fruit_fx setscriptablepartstate( "fx", "despawn" );
        level.scarab_ww_quest.fruit_fx setscriptablepartstate( "audio", "off" );
    }
    
    if ( level.scarab_ww_quest.cosmic_fruit )
    {
        level.scarab_ww_quest.cosmic_fruit setscriptablepartstate( "ping", "off" );
        level.scarab_ww_quest.cosmic_fruit delete();
    }
    
    if ( level.scarab_ww_quest.cosmic_fruit_interact )
    {
        level.scarab_ww_quest.cosmic_fruit_interact zm_quest::function_9170db4686f796e2();
    }
    
    level utility::flag_clear( "w_c_f_c_i_p_ember" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x6f58cd1, Offset: 0xd2e6
// Size: 0x159
function private function_4f15ee9c0696c9db( b_skipped )
{
    level notify( #"hash_98ba81d2960f222f" );
    level utility::flag_clear( "w_p_d_a_orchid" );
    level.scarab_ww_quest.var_e00b1b38507a027 = 0;
    
    if ( !b_skipped )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player setscriptablepartstate( "scarab_wwq_fx", "life_drain_off", 0 );
            }
        }
    }
    
    if ( level.scarab_ww_quest.center_vine.attack_ent )
    {
        level.scarab_ww_quest.center_vine.attack_ent delete();
    }
    
    if ( level.scarab_ww_quest.center_vine.attack_ent )
    {
        level.scarab_ww_quest.center_vine.attack_ent delete();
    }
    
    level thread function_fd4347a1e32f3dd1( b_skipped );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xf2b0fe7e, Offset: 0xd447
// Size: 0x100
function private function_fd4347a1e32f3dd1( b_skipped )
{
    level endon( #"game_ended" );
    
    if ( b_skipped )
    {
        var_98f467d1c9b0e5d = level.scarab_ww_quest.var_f55d5d2d3244f47d;
    }
    else
    {
        var_98f467d1c9b0e5d = getaiarrayinradius( level.scarab_ww_quest.center_vine.origin, 650, zm_utility::get_zombie_team() );
        var_98f467d1c9b0e5d = arraycombineunique( var_98f467d1c9b0e5d, level.scarab_ww_quest.var_f55d5d2d3244f47d );
    }
    
    foreach ( zombie in var_98f467d1c9b0e5d )
    {
        if ( isalive( zombie ) )
        {
            zombie thread function_a48053dd962a908e();
            waitframe();
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x7d5239c1, Offset: 0xd54f
// Size: 0x7c
function private function_f1b761703feb2572( params )
{
    if ( level zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    current_round = zm_round_logic::get_rb_round_number();
    var_3c35d5bd581440d9 = level zm_quest::function_b0a5181ebe7bb905() ? 7 : 8;
    
    if ( current_round >= var_3c35d5bd581440d9 && !level.scarab_ww_quest.cosmic_fruit && !level utility::flag( "WW_A_P_IN_USE" ) )
    {
        level spawn_cosmic_fruit();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x54357dd6, Offset: 0xd5d3
// Size: 0xb4
function private function_5763786d82e3c364( player, var_6ca9c18a86eefcf5 = 0 )
{
    if ( level utility::flag( "w_c_f_c_i_p_ember" ) )
    {
        return;
    }
    
    if ( level utility::flag( "WW_A_P_IN_USE" ) )
    {
        return;
    }
    
    if ( !level.scarab_ww_quest.cosmic_fruit )
    {
        return;
    }
    
    level utility::flag_set( "w_c_f_c_i_p_ember" );
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"hash_4bcd57abae316a12", 1 );
    player utility::delaythread( 4.5, &function_c99b85fe440b3386, "wwq_vo_consume_cosmic_dragonfruit_first_time", "scarab_scw1_consume_cosmic_dragonfruit_first_time" );
    level thread function_80ea67ae1394c952( player, var_6ca9c18a86eefcf5 );
    level notify( #"cf_consumed", player );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x466ba2ef, Offset: 0xd68f
// Size: 0x63
function private function_7d3a4c029d37e71a( player )
{
    if ( player && player.interactions_disabled )
    {
        return;
    }
    
    if ( level utility::flag( "w_c_f_c_i_p_ember" ) )
    {
        return;
    }
    
    if ( !level.scarab_ww_quest.cosmic_fruit )
    {
        return;
    }
    
    if ( level utility::flag( "WW_A_P_IN_USE" ) )
    {
        return;
    }
    
    level thread function_5763786d82e3c364( player );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x58bf80e3, Offset: 0xd6fa
// Size: 0xfb
function private cosmic_fruit_hint( interact, player )
{
    if ( player && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level utility::flag( "w_c_f_c_i_p_ember" ) || !level.scarab_ww_quest.cosmic_fruit || level utility::flag( "WW_A_P_IN_USE" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_12aa67d57689ba30", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x3865a8ee, Offset: 0xd7fe
// Size: 0x58c
function private function_80ea67ae1394c952( player, var_6ca9c18a86eefcf5 = 0 )
{
    player endon( #"death_or_disconnect" );
    
    if ( player.isinlaststand )
    {
        return;
    }
    
    if ( !var_6ca9c18a86eefcf5 )
    {
        player function_8d1a8002535ac6de();
    }
    
    level function_bd1c9b9c1bf4e6c9();
    level thread function_bc683f19a6b8fa00( player );
    
    if ( level.scarab_ww_quest.var_77500ecd839e52e4 )
    {
        level.scarab_ww_quest.var_77500ecd839e52e4 thread function_241fc123b396130e();
    }
    
    var_5bfe886b67c1dcf5 = zm_quest::get_quest_step( #"scarab_ww_quest", #"hash_90cb42c3585aefad" );
    
    if ( !var_5bfe886b67c1dcf5.completed )
    {
        level thread function_d776625064a36243( player );
    }
    else
    {
        level utility::delaythread( 3, &function_b7cefc26724c15de );
    }
    
    if ( utility::issharedfuncdefined( #"astral_plane", #"hash_7471e910ef93eae8" ) )
    {
        utility::callsharedfunc( #"astral_plane", #"hash_7471e910ef93eae8", player );
    }
    
    if ( !var_6ca9c18a86eefcf5 )
    {
        level function_7923fab6efb88aed( player );
        function_a62e9fb7be9ff0a6( level.scarab_ww_quest.center_vine.origin, 200 );
        var_bafbe5848d83214b = utility::spawn_model( %"hash_5ab34868ff8ffed5", level.scarab_ww_quest.fruit_spawn_origin, level.scarab_ww_quest.fruit_spawn_angles );
        var_bafbe5848d83214b setscriptablepartstate( "ping", "off" );
        player thread utility::delete_on_death( var_bafbe5848d83214b );
        level utility::delaythread( 1.4, &function_87b03f10b7d1f37c, 1 );
        waitframe();
        s_spawn_parent = utility::getstruct( "lc_a_p_spawn_parent", "targetname" );
        s_ap_spawn_location = function_febc6fe97fa53a90( s_spawn_parent );
        player predictstreamposuntilcleared( s_ap_spawn_location.origin );
        var_ce30af25aa59de8b = utility::getstructarray( "va_fruit_scene", "targetname" );
        var_2d08dd083ea31527 = function_47c86977a18df38b( var_ce30af25aa59de8b, player.origin );
        player function_fd64e7e1aa9e5c71( var_2d08dd083ea31527, 0.25 );
        
        if ( var_2d08dd083ea31527.target )
        {
            player.var_c0539489de2c62bc = utility::getstruct( var_2d08dd083ea31527.target, "targetname" );
        }
        else
        {
            player.var_c0539489de2c62bc = undefined;
        }
        
        var_f57c8f1cdfc44be4 = { #angles:player.angles, #origin:player.origin };
        
        if ( var_2d08dd083ea31527 )
        {
            var_f57c8f1cdfc44be4.origin = var_2d08dd083ea31527.origin;
            var_f57c8f1cdfc44be4.angles = var_2d08dd083ea31527.angles;
        }
        
        var_f57c8f1cdfc44be4 scene::init( [ player, var_bafbe5848d83214b ], undefined, "sat_cin_zm_vig_scarab_wwq_eat_cosmic_fruit" );
        var_78dc209cc5bd82bb = var_f57c8f1cdfc44be4 scene::function_b3c7b792a7a154fa( "eat_fruit" );
        var_360a7cae396ff42e = 2.5;
        warp_start_delay = max( var_78dc209cc5bd82bb - 1.5 + 0.1, 0 );
        remaining_scene_duration = max( var_78dc209cc5bd82bb - warp_start_delay, 0 );
        var_4773a5878e3c3af6 = max( var_360a7cae396ff42e - remaining_scene_duration, 0 );
        player playsoundonmovingent( #"evt_zm_scarab_wwq_eat_fruit" );
        player val::set( "ww_quest_consume_fruit_warp", "weapon", 0 );
        var_f57c8f1cdfc44be4 thread scene::play( [ player, var_bafbe5848d83214b ], "eat_fruit" );
        wait warp_start_delay;
        player val::set( "ww_quest_a_p", "round_spawning_ignore_player", 1 );
    }
    else
    {
        level function_87b03f10b7d1f37c( 1 );
    }
    
    level thread function_90a12e7d5e3d7217( player, s_ap_spawn_location );
    
    if ( !var_6ca9c18a86eefcf5 )
    {
        wait remaining_scene_duration;
        
        if ( var_bafbe5848d83214b )
        {
            var_bafbe5848d83214b delete();
        }
    }
    
    player utility::delaythread( 1, &function_c99b85fe440b3386, "wwq_vo_astral_plane_arrival_first_time", "scarab_scw1_astral_plane_arrival_first_time", #"hash_5212ed7ec42f115a" );
    player function_6e2b606f6af78075();
    
    if ( !var_6ca9c18a86eefcf5 )
    {
        wait var_4773a5878e3c3af6;
        player val::reset_all( "ww_quest_consume_fruit_warp" );
        player utility::delaythread( 0.2, &utility::ent_flag_clear, "consume_fruit_scene_in_prog" );
    }
    
    var_26589e418fb5aa0c = utility::getstructarray( "nu_a_p_e", "targetname" );
    s_exit_portal = function_47c86977a18df38b( var_26589e418fb5aa0c, player.origin );
    level.scarab_ww_quest.var_7ba53ebdc38a4c73 = spawnscriptable( %"hash_a3b29c93f049045", s_exit_portal.origin, s_exit_portal.angles );
    level.scarab_ww_quest.var_7ba53ebdc38a4c73 setscriptablepartstate( "base", "idle" );
    var_b5047dffd83b2ae4 = ( 20, 60, 100 ) / 2;
    level.scarab_ww_quest.var_ea16e7bd7c8a01e8 = spawn( "trigger_box", s_exit_portal.origin, 0, var_b5047dffd83b2ae4, var_b5047dffd83b2ae4 + ( 1, 1, 1 ) );
    level.scarab_ww_quest.var_ea16e7bd7c8a01e8.angles = s_exit_portal.angles;
    level thread function_fffbb4206132844f();
    waitframe();
    level function_b20f75e74697d6ea();
    
    if ( !var_5bfe886b67c1dcf5.completed )
    {
        player thread function_263163501668201e();
    }
    
    player thread function_62f9b072b7bf8ef1();
    level thread function_f3a8ddd7369998fc( player );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x771cb63b, Offset: 0xdd92
// Size: 0x77
function private function_62f9b072b7bf8ef1()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_75ff751c366da41a" );
    
    while ( true )
    {
        self clearpredictedstreampos();
        self clearadditionalstreampos();
        self predictstreamposuntilcleared( level.scarab_ww_quest.center_vine.origin );
        self setadditionalstreamposuntilcleared( level.scarab_ww_quest.center_vine.origin );
        wait 18;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xccc92d23, Offset: 0xde11
// Size: 0xe2
function private function_8d1a8002535ac6de()
{
    player = self;
    player setstance( "stand", undefined, 1 );
    player val::set( "ww_quest_consume_fruit_warp", "ignoreme", 1 );
    player val::set( "ww_quest_consume_fruit_warp", "freezecontrols_allowlook", 1 );
    player val::set( "ww_quest_consume_fruit_warp", "allow_movement", 0 );
    player val::set( "ww_quest_consume_fruit_warp", "stance_change", 0 );
    player val::set( "ww_quest_consume_fruit_warp", "killstreaks", 0 );
    player val::set( "ww_quest_consume_fruit_warp", "allow_scripted_bgb_use", 0 );
    player val::set( "ww_quest_consume_fruit_warp", "supers", 0 );
    player val::set( "ww_quest_consume_fruit_warp", "show_hud", 0 );
    player val::set( "ww_quest_consume_fruit_warp", "damage", 0 );
    player utility::ent_flag_set( "consume_fruit_scene_in_prog" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x17c269fe, Offset: 0xdefb
// Size: 0x107
function private function_7923fab6efb88aed( consuming_player )
{
    a_players = getplayersinradius( level.scarab_ww_quest.center_vine.origin, 120 );
    
    foreach ( player in a_players )
    {
        if ( !isalive( player ) || player == consuming_player )
        {
            continue;
        }
        
        v_dir = vectornormalize( player.origin - level.scarab_ww_quest.center_vine.origin + ( 1, 0, 0 ) );
        player knockback( v_dir, 350 );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x49386cb, Offset: 0xe00a
// Size: 0xdc
function private function_fd64e7e1aa9e5c71( var_5990ce3727e634d1, n_time = 0.25 )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_75ff751c366da41a" );
    v_goal_origin = var_5990ce3727e634d1.origin;
    v_goal_angles = var_5990ce3727e634d1.angles ?? self getplayerangles();
    
    if ( n_time <= 0 )
    {
        self setorigin( v_goal_origin );
        self setplayerangles( v_goal_angles );
        return;
    }
    
    anchor = spawn( "script_origin", v_goal_origin );
    anchor.angles = v_goal_angles;
    self playerlinktoblend( anchor, undefined, n_time );
    wait n_time;
    self unlink();
    self setorigin( anchor.origin );
    self setplayerangles( v_goal_angles );
    anchor delete();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x9c0d2c77, Offset: 0xe0ee
// Size: 0x52
function private function_bc683f19a6b8fa00( player )
{
    level endon( #"game_ended" );
    level endon( #"ww_a_p_cleanup_in_progress" );
    player utility::waittill_any( "last_stand_enter", "death_or_disconnect" );
    player utility::function_7c10ea82c1e305b8( "scarab_wwq_fx", "off" );
    level thread function_d5ddbca43097a0ff();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xca16221, Offset: 0xe148
// Size: 0xa7
function private function_bd1c9b9c1bf4e6c9()
{
    level utility::flag_set( "WW_A_P_IN_USE" );
    level zone_manager::set_zone_enabled( "zone_ee_ashwoods", 1 );
    
    if ( !level callback::exists( "special_round_start", &function_ab6df1e4ee184409 ) )
    {
        level callback::add( "special_round_start", &function_ab6df1e4ee184409 );
    }
    
    if ( !isdefined( level.scarab_ww_quest.astral_projection_throttle ) )
    {
        level.scarab_ww_quest.astral_projection_throttle = throttle::throttle_initialize( "ww_astral_projection_throttle", 1 );
    }
    
    level.scarab_ww_quest.var_ba94d7dcbaa92bfb = level.var_a52fc6524d39e8e9;
    level.var_a52fc6524d39e8e9 = &function_cdb04089157cc0e9;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xaaeeaa59, Offset: 0xe1f7
// Size: 0xb1
function private function_cdb04089157cc0e9()
{
    var_62d8d6b7a834f3c4 = 0;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && !player utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) )
        {
            var_62d8d6b7a834f3c4 = 1;
            break;
        }
    }
    
    if ( !var_62d8d6b7a834f3c4 )
    {
        return zm_player::function_c107082b3aabba7d( "zone_ee_ashwoods" );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xf24cf5fe, Offset: 0xe2b1
// Size: 0x22c
function private function_d776625064a36243( player )
{
    player endon( #"exit_astral_projection" );
    player endon( #"death_or_disconnect" );
    level.scarab_ww_quest.var_c2740b15b8d89540 = [];
    level.scarab_ww_quest.var_d4c029c55e977dc7 = [];
    level.scarab_ww_quest.var_2525db782c51cf5e = [];
    level.scarab_ww_quest.var_858df476a878f27e = [];
    var_a65a556e144e8c0b = utility::getstructarray( "to_a_p_zombie_spawn", "targetname" );
    
    foreach ( spawner in var_a65a556e144e8c0b )
    {
        var_4ee9a0987287d10f = 0;
        
        while ( !var_4ee9a0987287d10f )
        {
            var_50e48382a36fbea8 = zm_utility::function_2453a16ad4a092f8( 1 );
            
            if ( var_50e48382a36fbea8 > 0 )
            {
                var_4ee9a0987287d10f = zm_utility::function_922d522db5f1ceda( var_50e48382a36fbea8, [ "normal" ] );
            }
            else
            {
                break;
            }
            
            waitframe();
        }
        
        switch ( spawner.script_noteworthy )
        {
            case #"hash_8cdaf2e4ecfe5b51":
                quest_zombie_array = level.scarab_ww_quest.var_c2740b15b8d89540;
                break;
            case #"hash_2ac140ce3b5ea398":
                quest_zombie_array = level.scarab_ww_quest.var_d4c029c55e977dc7;
                break;
            case #"hash_2138826c1b3287cb":
                quest_zombie_array = level.scarab_ww_quest.var_2525db782c51cf5e;
                break;
            default:
                assertmsg( "<dev string:x116>" );
                break;
        }
        
        zombie = function_54d1adbb85f0d5ca( "sat_spawner_zombie_base_zm_firefly_sunken", spawner, zm_utility::get_round_number() + 3, quest_zombie_array );
        
        if ( zombie )
        {
            zombie function_379568c470a98fe3();
        }
    }
    
    level thread function_5dadcbaf52771ce2( player );
    level function_20b87bfa1e8b6121( player );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x3b5c7bf5, Offset: 0xe4e5
// Size: 0x79
function private function_5dadcbaf52771ce2( player )
{
    level endon( #"game_ended" );
    level endon( #"ww_a_p_cleanup_in_progress" );
    level endon( #"hash_e556220fb37faf9b" );
    player endon( #"exit_astral_projection" );
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( level utility::flag( "w_a_p_r_s_vault" ) )
        {
            return;
        }
        
        if ( function_966d71532f7249ec() <= 0 )
        {
            level thread function_41efc24a257f3c3d();
            return;
        }
        
        wait 1;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x5114c584, Offset: 0xe566
// Size: 0x109
function private function_966d71532f7249ec()
{
    level.scarab_ww_quest.var_c2740b15b8d89540 = utility::function_8391781ea0784541( level.scarab_ww_quest.var_c2740b15b8d89540 );
    level.scarab_ww_quest.var_d4c029c55e977dc7 = utility::function_8391781ea0784541( level.scarab_ww_quest.var_d4c029c55e977dc7 );
    level.scarab_ww_quest.var_2525db782c51cf5e = utility::function_8391781ea0784541( level.scarab_ww_quest.var_2525db782c51cf5e );
    level.scarab_ww_quest.var_858df476a878f27e = utility::function_8391781ea0784541( level.scarab_ww_quest.var_858df476a878f27e );
    return level.scarab_ww_quest.var_c2740b15b8d89540.size + level.scarab_ww_quest.var_d4c029c55e977dc7.size + level.scarab_ww_quest.var_2525db782c51cf5e.size + level.scarab_ww_quest.var_858df476a878f27e.size;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xaa59976f, Offset: 0xe678
// Size: 0x28f
function private function_20b87bfa1e8b6121( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"exit_astral_projection" );
    var_f3ffbcf817464228 = [];
    
    if ( level utility::flag( "w_a_p_b_s_h_meadow" ) )
    {
        var_f3ffbcf817464228 = arraycombine( var_f3ffbcf817464228, level.scarab_ww_quest.var_2525db782c51cf5e );
    }
    
    if ( level utility::flag( "w_a_p_str_s_h_summit" ) )
    {
        var_f3ffbcf817464228 = arraycombine( var_f3ffbcf817464228, level.scarab_ww_quest.var_d4c029c55e977dc7 );
    }
    
    if ( level utility::flag( "w_a_p_s_s_h_lagoon" ) )
    {
        var_f3ffbcf817464228 = arraycombine( var_f3ffbcf817464228, level.scarab_ww_quest.var_c2740b15b8d89540 );
    }
    
    if ( var_f3ffbcf817464228.size <= 0 )
    {
        return;
    }
    
    foreach ( zombie in var_f3ffbcf817464228 )
    {
        zombie function_72443dc748c4ac15();
        zombie val::set( "ww_quest_a_p", "ignoreall", 1 );
    }
    
    level.scarab_ww_quest.var_29f7f959f6d0023e = var_f3ffbcf817464228;
    
    if ( !isdefined( level.scarab_ww_quest.var_6de1434eff82d34d ) )
    {
        level.scarab_ww_quest.var_6de1434eff82d34d = throttle::throttle_initialize( "ww_astral_projection_zombie_attack", 1 );
    }
    
    while ( true )
    {
        foreach ( zombie in level.scarab_ww_quest.var_29f7f959f6d0023e )
        {
            if ( isalive( zombie ) && distancesquared( player.origin, zombie.origin ) <= squared( 200 ) )
            {
                level function_aff3e95738ad05e0( zombie );
                break;
            }
        }
        
        utility::array_removedead_or_dying( level.scarab_ww_quest.var_29f7f959f6d0023e );
        
        if ( level.scarab_ww_quest.var_29f7f959f6d0023e.size <= 0 )
        {
            return;
        }
        
        level throttle::throttle_wait_in_queue( level.scarab_ww_quest.var_6de1434eff82d34d );
        waitframe();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x8f201762, Offset: 0xe90f
// Size: 0xc2
function private function_aff3e95738ad05e0( zombie )
{
    var_995c5b99dafcaf0c = function_13d04d50da223079( zombie );
    
    foreach ( group_zombie in var_995c5b99dafcaf0c )
    {
        group_zombie val::reset_all( "ww_quest_a_p" );
        level.scarab_ww_quest.var_29f7f959f6d0023e = arrayremove( level.scarab_ww_quest.var_29f7f959f6d0023e, group_zombie );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x83dc81f3, Offset: 0xe9d9
// Size: 0x9c
function private function_13d04d50da223079( zombie )
{
    if ( arraycontains( level.scarab_ww_quest.var_2525db782c51cf5e, zombie ) )
    {
        return level.scarab_ww_quest.var_2525db782c51cf5e;
    }
    
    if ( arraycontains( level.scarab_ww_quest.var_d4c029c55e977dc7, zombie ) )
    {
        return level.scarab_ww_quest.var_d4c029c55e977dc7;
    }
    
    if ( arraycontains( level.scarab_ww_quest.var_c2740b15b8d89540, zombie ) )
    {
        return level.scarab_ww_quest.var_c2740b15b8d89540;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xfd7f7c17, Offset: 0xea7d
// Size: 0x18e
function private function_379568c470a98fe3()
{
    zombie = self;
    zombie.var_65de3f7c461c1611 = 1;
    zombie._blackboard.var_dd1cb4e12c4c12d2 = -1;
    zombie._blackboard.var_8d34ab856208146f = 200;
    zombie.var_7ee152b43c7188e1 = 1;
    zombie setscriptablepartstate( "scarab_wwq", "idle" );
    zombie val::set( "ww_quest_a_p", "ignoreall", 1 );
    zombie val::set( "ww_quest_a_p", "damage", 0 );
    zombie val::set( "ww_quest_a_p", "show_healthbar", 0 );
    zombie val::set( "ww_quest_a_p", "ignoreme", 1 );
    zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "sprint" == "super_sprint" || "sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "sprint" == "sprint" ? "run" : "sprint", "wwq_spawn", 6 );
    zombie zombie_utils::function_dfae6a5bd222c586( &function_359d86998a043710 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xda608644, Offset: 0xec13
// Size: 0x264
function private function_e094dc6f02704e8c( player, str_subclass )
{
    player endon( #"exit_astral_projection" );
    player endon( #"death_or_disconnect" );
    
    if ( !isalive( player ) )
    {
        return;
    }
    
    var_dd2f44338c0d54dc = utility::array_removedead_or_dying( level.scarab_ww_quest.var_858df476a878f27e );
    var_6c8cc65363a0b920 = 5 - var_dd2f44338c0d54dc.size;
    
    for ( i = 0; i < var_6c8cc65363a0b920 ; i++ )
    {
        var_4ee9a0987287d10f = 0;
        
        while ( true )
        {
            var_50e48382a36fbea8 = zm_utility::function_2453a16ad4a092f8( 1 );
            
            if ( var_50e48382a36fbea8 > 0 )
            {
                var_4ee9a0987287d10f = zm_utility::function_922d522db5f1ceda( var_50e48382a36fbea8, [ "normal" ] );
            }
            
            if ( var_50e48382a36fbea8 > 0 && !var_4ee9a0987287d10f )
            {
                waitframe();
                continue;
            }
            
            spawners = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_ee_ashwoods" ], "zombie_base" );
            
            if ( !isdefined( spawners ) || spawners.size <= 0 )
            {
                waitframe();
                continue;
            }
            
            spawner = utility::array_random( spawners );
            spawnerdist = distancesquared( player.origin, spawner.origin );
            
            if ( spawnerdist > squared( 800 ) )
            {
                waitframe();
                continue;
            }
            
            if ( spawner )
            {
                break;
            }
            
            waitframe();
        }
        
        zombie = function_54d1adbb85f0d5ca( str_subclass, spawner, zm_utility::get_round_number() + 3, level.scarab_ww_quest.var_858df476a878f27e );
        
        if ( zombie )
        {
            zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "sprint" == "super_sprint" || "sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "sprint" == "sprint" ? "run" : "sprint", "wwq_spawn", 6 );
            zombie function_c0b1d35bc1be7a69();
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0
// Checksum 0xcf78a206, Offset: 0xee7f
// Size: 0x5e
function function_c0b1d35bc1be7a69()
{
    zombie = self;
    zombie.var_65de3f7c461c1611 = 1;
    zombie.var_7ee152b43c7188e1 = 1;
    zombie setscriptablepartstate( "scarab_wwq", "attacking" );
    zombie zombie_utils::function_dfae6a5bd222c586( &function_359d86998a043710 );
    zombie val::set( "ww_quest_a_p", "show_healthbar", 0 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x5adbbb95, Offset: 0xeee5
// Size: 0xe3
function private function_359d86998a043710( params )
{
    damage = params.idamage;
    
    if ( isplayer( params.eattacker ) && level.scarab_ww_quest.var_29f7f959f6d0023e && arraycontains( level.scarab_ww_quest.var_29f7f959f6d0023e, self ) )
    {
        level function_aff3e95738ad05e0( self );
    }
    
    if ( self.var_65de3f7c461c1611 && val::get( "damage" ) && self.aicategory != "elite" )
    {
        if ( damage >= self.health && ( params.smeansofdeath == "MOD_RIFLE_BULLET" || params.smeansofdeath == "MOD_PISTOL_BULLET" ) )
        {
            thread function_e42c1de3165e461f( params );
        }
    }
    
    return damage;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xf5945833, Offset: 0xefd1
// Size: 0x18d
function private function_e42c1de3165e461f( params )
{
    if ( !self.var_4e2cae13b6ec94fc )
    {
        self.var_4e2cae13b6ec94fc = 1;
        val::set( "ap_zombie_shield", "damageshield", 1 );
        val::set( "ap_zombie_shield", "allow_brot", 0 );
        val::set( "ap_zombie_shield", "ignoreall", 1 );
        self function_e8726d980fa12944();
        utility::function_7c10ea82c1e305b8( "base", "base_off" );
        utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_out" );
        utility::function_7c10ea82c1e305b8( "scarab_wwq", "despawn" );
        thread function_a92715d9ef8eeb80();
        effect_slow::slow( "fog", 0.01, 100 );
        callback::callback( #"hash_31a3aff6c85c746a", params );
        wait 0.4;
        
        if ( isalive( self ) )
        {
            self.nocorpse = 1;
            self.death_source = "scarab_fade";
        }
        
        waitframe();
        
        if ( isalive( self ) )
        {
            val::reset( "ap_zombie_shield", "damageshield" );
            self kill( params.vpoint, params.eattacker, params.einflictor, params.smeansofdeath, params.objweapon );
        }
        
        utility::array_removedead_or_dying( level.scarab_ww_quest.var_c2740b15b8d89540 );
        utility::array_removedead_or_dying( level.scarab_ww_quest.var_d4c029c55e977dc7 );
        utility::array_removedead_or_dying( level.scarab_ww_quest.var_2525db782c51cf5e );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0
// Checksum 0x4001a81d, Offset: 0xf166
// Size: 0xb2
function function_a92715d9ef8eeb80()
{
    self endon( #"death" );
    var_1dadec86cf0cbb73 = utility::ent_flag( "cryofreeze_active" ) || status_effects::has_status_effect_type( "frost_blast" ) || status_effects::has_status_effect_type( "frost_blast_frozen" );
    b_burn = status_effects::has_status_effect_type( "burn" );
    
    if ( var_1dadec86cf0cbb73 )
    {
        wait 0.1;
        utility::function_7c10ea82c1e305b8( "frozen", "frozen_off" );
        utility::function_7c10ea82c1e305b8( "cryofreeze", "cryofreeze_shatter" );
    }
    
    if ( b_burn )
    {
        wait 0.1;
        utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
        utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 3, eflags: 0x4
// Checksum 0x3c0583ee, Offset: 0xf220
// Size: 0xb0
function private function_b41dedcc915732d1( player, a_idle_zombies, str_subclass = "sat_spawner_zombie_base_zm_firefly_sunken" )
{
    foreach ( zombie in a_idle_zombies )
    {
        if ( isalive( zombie ) )
        {
            zombie function_72443dc748c4ac15();
        }
    }
    
    level thread function_e094dc6f02704e8c( player, str_subclass );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x2dfd9292, Offset: 0xf2d8
// Size: 0x30
function private function_72443dc748c4ac15()
{
    val::reset_all( "ww_quest_a_p" );
    self setscriptablepartstate( "scarab_wwq", "attacking" );
    val::set( "ww_quest_a_p", "show_healthbar", 0 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xbae30c54, Offset: 0xf310
// Size: 0x1bc
function private function_6e2b606f6af78075()
{
    utility::ent_flag_set( "WW_PLAYER_IN_A_P_SPACE" );
    self.var_896ba90a1f08dc45 = 1;
    self.var_3edb080f749fcb9c = 1;
    
    if ( self.var_819dfee5ff9a56d6 )
    {
        zm_ncfdpedestal::force_end_grapple();
    }
    
    self setscriptablepartstate( "scarab_wwq_fx", "astral_projection_on", 0 );
    player::hideminimap( 1 );
    pbgpostfxbundlestart( self, %"cer_zm_ruby_echoes_cave" );
    val::set( "ww_quest_a_p", "show_hud", 0 );
    val::set( "ww_quest_a_p", "killstreaks", 0 );
    val::set( "ww_quest_a_p", "round_spawning_ignore_player", 1 );
    val::set( "ww_quest_a_p", "show_compass", 0 );
    val::set( "ww_quest_a_p", "enable_nuke_flash_and_sound", 0 );
    self.var_421f03224b430b6e = self.var_6b5c16c263b6b7ac;
    self.var_6b5c16c263b6b7ac = 1;
    set_combat_hud( 1 );
    level musicbank_utility::function_5aca66c390aa347d( self, #"astral_plane" );
    
    if ( !level.scarab_ww_quest.completed )
    {
        self setclientomnvar( "ui_show_quest_ui_nohud", 1 );
    }
    
    if ( level utility::flag( "show_hud_for_t1" ) )
    {
        self setclientomnvar( "ui_show_quest_ui_nohud", 1 );
    }
    
    self sethidenameplate( 1 );
    self function_66dc8b6ae969f66d( 1 );
    
    if ( level utility::flag( "its_raining" ) )
    {
        if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_efe074ec11372361" ) )
        {
            utility::callsharedfunc( #"scarab_rain", #"hash_efe074ec11372361" );
        }
    }
    
    zm_round_spawning::function_4ac257955c0b5c16( 0 );
    
    if ( utility::ent_flag( "is_usurped_power_grabbed" ) )
    {
        self notify( #"equip_finished_with_deploy_weapon" );
    }
    
    self.var_18b16b62bdc6de6c = [ "zone_ee_ashwoods" ];
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x1d4a5ce, Offset: 0xf4d4
// Size: 0x206
function private function_e69097e7d69abde0()
{
    utility::ent_flag_clear( "WW_PLAYER_IN_A_P_SPACE" );
    self.var_896ba90a1f08dc45 = undefined;
    self.var_3edb080f749fcb9c = undefined;
    utility::ent_flag_clear( "w_a_p_v_i_p_garnet" );
    self setscriptablepartstate( "scarab_wwq_fx", "off", 0 );
    val::reset_all( "ww_quest_a_p" );
    val::reset_all( "ww_quest_a_p_vision" );
    val::reset_all( "ww_quest_a_p_vision_exit_grace" );
    val::reset_all( "ww_quest_consume_fruit_warp" );
    val::reset_all( "ww_astral_projection_weapons" );
    
    if ( !isdefined( self.defaultbasefov ) )
    {
        self.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    self modifybasefov( self.defaultbasefov, 0.2 );
    self lerpfovscalefactor( 1, 0 );
    player::showminimap();
    self.var_6b5c16c263b6b7ac = self.var_421f03224b430b6e;
    self setclientomnvar( "ui_show_quest_ui_nohud", 0 );
    set_combat_hud( 0 );
    level musicbank_utility::function_4f253fd35ec68cbc( self, #"astral_plane" );
    pbgpostfxbundleend( self, %"cer_zm_ruby_echoes_cave" );
    pbgpostfxbundleend( self, %"cer_zm_ruby_echoes_cave_intense" );
    
    foreach ( zombie in level.var_89dcfbd19d153b27 )
    {
        zombie visiblesolid();
    }
    
    level.var_89dcfbd19d153b27 = undefined;
    self sethidenameplate( 0 );
    self function_66dc8b6ae969f66d( 0 );
    self.var_18b16b62bdc6de6c = undefined;
    utility::delaythread( 2, &function_d5ae644cf3d561ed );
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) )
    {
        objidpoolmanager::objective_playermask_addshowplayer( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466, self );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x4891dbd2, Offset: 0xf6e2
// Size: 0x19
function private set_combat_hud( var_f1fbc291f2430b1e )
{
    self setclientomnvar( "ui_zm_is_bear_attack_quest", var_f1fbc291f2430b1e );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x758e1774, Offset: 0xf703
// Size: 0x5e
function private function_d5ae644cf3d561ed()
{
    if ( zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
    {
        thread zm_round_spawning::function_4ac257955c0b5c16( 1 );
    }
    
    if ( level utility::flag( "its_raining" ) )
    {
        if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_bd3ce90cea3f86b5" ) )
        {
            utility::callsharedfunc( #"scarab_rain", #"hash_bd3ce90cea3f86b5" );
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xa5c79b8a, Offset: 0xf769
// Size: 0xdd
function private function_ab6df1e4ee184409( params )
{
    waitframe();
    
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) )
        {
            if ( level utility::flag( "its_raining" ) )
            {
                if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_efe074ec11372361" ) )
                {
                    player utility::callsharedfunc( #"scarab_rain", #"hash_efe074ec11372361" );
                }
            }
            
            player zm_round_spawning::function_4ac257955c0b5c16( 0 );
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xb2ebbc21, Offset: 0xf84e
// Size: 0x36
function private function_febc6fe97fa53a90( s_destination_parent )
{
    a_s_spawn_locations = utility::getstructarray( s_destination_parent.target, "targetname" );
    return utility::array_random( a_s_spawn_locations );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x7e9c0107, Offset: 0xf88d
// Size: 0x50
function private function_83378f709aa6acc2( s_destination, should_spawn_clone = 0 )
{
    dest_location = function_febc6fe97fa53a90( s_destination );
    function_67663890f9cd3e20( dest_location.origin, dest_location.angles, should_spawn_clone );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x8e41fe11, Offset: 0xf8e5
// Size: 0x79
function private function_90a12e7d5e3d7217( player, var_36f05171f3c6350f = undefined )
{
    player endon( #"death_or_disconnect" );
    
    if ( !var_36f05171f3c6350f )
    {
        s_spawn_parent = utility::getstruct( "lc_a_p_spawn_parent", "targetname" );
        var_36f05171f3c6350f = function_febc6fe97fa53a90( s_spawn_parent );
    }
    
    player function_67663890f9cd3e20( var_36f05171f3c6350f.origin, var_36f05171f3c6350f.angles, 1, 1 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 3, eflags: 0x4
// Checksum 0x4b08a891, Offset: 0xf966
// Size: 0x167
function private function_c3cb4a0aef80c167( player, player_original_origin, player_original_angles )
{
    if ( !isalive( player ) )
    {
        return;
    }
    
    origin = player_original_origin;
    angles = player_original_angles;
    clone = spawn( "script_model", origin );
    clone.angles = angles;
    player_collision = spawnscriptable( %"hash_29cdbd46e2992da7", origin, angles );
    player_collision setscriptablepartstate( "body", "player_collision" );
    clone function_ce21f4102d5d17f6( player.operatorcustomization.skinref, %"super_combat_hologram_aether_shadow_clone" );
    clone setscriptablepartstate( "fx", "on" );
    player thread utility::delete_on_death( clone );
    clone hide();
    clone.var_12aadf5d8bbfdafd = createnavobstaclebybounds( clone.origin, ( 25, 25, 100 ), clone.angles );
    level.scarab_ww_quest.var_9ec936076b99c433 = { #player_collision_scriptable:player_collision, #angles:clone.angles, #origin:clone.origin, #ent:clone };
    player thread function_30d7480a42f00cd3();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x7ec7b62d, Offset: 0xfad5
// Size: 0xc9
function private function_30d7480a42f00cd3()
{
    player = self;
    player endon( #"death_or_disconnect" );
    clone = level.scarab_ww_quest.var_9ec936076b99c433.ent;
    clone endon( #"death" );
    var_c78ffcdb53abd5a5 = { #script_scenescriptbundle:"sat_cin_zm_vig_scarab_wwq_eat_cosmic_fruit" };
    n_loop_duration = var_c78ffcdb53abd5a5 scene::function_b3c7b792a7a154fa( "hallucination_loop" );
    player utility::ent_flag_wait( "WW_PLAYER_IN_A_P_SPACE" );
    clone show();
    
    while ( player utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) && clone )
    {
        clone scriptmodelplayanim( "ch_cin_zm_vig_scarab_wwq_eat_cosmic_fruit_hallucinate_plyr" );
        wait n_loop_duration > 0 ? n_loop_duration : 1;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x49da4b37, Offset: 0xfba6
// Size: 0xcd
function private function_c53246740ce88066()
{
    if ( !level.scarab_ww_quest.var_9ec936076b99c433 )
    {
        return;
    }
    
    var_96397e25a97b5e0e = level.scarab_ww_quest.var_9ec936076b99c433;
    clone = var_96397e25a97b5e0e.ent;
    
    if ( clone.var_12aadf5d8bbfdafd )
    {
        destroynavobstacle( clone.var_12aadf5d8bbfdafd );
    }
    
    if ( clone )
    {
        clone delete();
    }
    
    if ( level.scarab_ww_quest.var_9ec936076b99c433.player_collision_scriptable )
    {
        level.scarab_ww_quest.var_9ec936076b99c433.player_collision_scriptable freescriptable();
        level.scarab_ww_quest.var_9ec936076b99c433 = undefined;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 4, eflags: 0x4
// Checksum 0x56ba696, Offset: 0xfc7b
// Size: 0x22d
function private function_67663890f9cd3e20( v_origin, v_angles, should_spawn_clone = 0, var_78cd17a97664a701 = 0 )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_75ff751c366da41a" );
    val::set( "ww_quest_a_p_teleport", "mantle", 0 );
    
    if ( var_78cd17a97664a701 )
    {
        level.scarab_ww_quest.var_f9e1c104c8edb0bf = { #angles:v_angles, #origin:v_origin };
        self setadditionalstreamposuntilcleared( v_origin );
    }
    
    if ( !isdefined( self.defaultbasefov ) )
    {
        self.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    utility::function_32b24db3127bff40( "scarab_ap_teleport_fx", "warm_up" );
    self modifybasefov( self.defaultbasefov * 1.3, 0.75 );
    wait 0.75;
    self modifybasefov( self.defaultbasefov * 0.7, 0.75 );
    wait 0.75;
    utility::function_32b24db3127bff40( "scarab_ap_teleport_fx", "warp" );
    player_original_origin = self.origin;
    player_original_angles = self getplayerangles();
    playfx( utility::getfx( "ww_warp_astral_plane_3p" ), self.origin );
    playworldsound( self.origin + ( 0, 0, 75 ), #"hash_1fcabd3140b32dab" );
    self setorigin( v_origin );
    
    if ( isdefined( v_angles ) )
    {
        self setplayerangles( v_angles );
    }
    
    self modifybasefov( self.defaultbasefov, 1 );
    playfx( utility::getfx( "ww_warp_astral_plane_3p" ), v_origin );
    playworldsound( v_origin + ( 0, 0, 75 ), #"hash_1fcabd3140b32dab" );
    
    if ( should_spawn_clone )
    {
        level utility::delaythread( 0.05, &function_c3cb4a0aef80c167, self, player_original_origin, player_original_angles );
    }
    
    level utility::delaythread( 0.1, &function_c2bde7c7cd0b3ee1, v_origin );
    wait 1;
    utility::function_32b24db3127bff40( "scarab_ap_teleport_fx", "off" );
    self clearadditionalstreampos();
    val::reset_all( "ww_quest_a_p_teleport" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xfd364480, Offset: 0xfeb0
// Size: 0x36
function private function_c2bde7c7cd0b3ee1( v_origin )
{
    if ( isalive( self ) && distancesquared( self.origin, v_origin ) > squared( 5 ) )
    {
        self setorigin( v_origin );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x1cc54054, Offset: 0xfeee
// Size: 0x205
function private function_f3a8ddd7369998fc( player )
{
    level endon( #"ww_a_p_cleanup_in_progress" );
    player endon( #"death_or_disconnect" );
    player endon( #"exit_astral_projection" );
    level endon( #"hash_e556220fb37faf9b" );
    level.scarab_ww_quest.var_b8e06220e1014427 = 120;
    start_time = gettime();
    var_ce74fa86b4e1ada3 = 0;
    
    while ( true )
    {
        wait 1;
        time_elapsed = gettime() - start_time;
        timeout_ms = utility::function_4b74c15943231980( getdvarint( @"hash_1ecec00fec3c4467", int( level.scarab_ww_quest.var_b8e06220e1014427 ) ) );
        
        if ( player utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) && level.scarab_ww_quest.var_f9e1c104c8edb0bf )
        {
            zone = player zone_manager::get_current_zone();
            
            if ( zone.zone_name != "zone_ee_ashwoods" )
            {
                player setorigin( level.scarab_ww_quest.var_f9e1c104c8edb0bf.origin );
            }
        }
        
        if ( getdvarint( @"hash_e389d84cc8b09cf4", 0 ) )
        {
            /#
                iprintlnbold( "<dev string:x145>" );
            #/
            
            continue;
        }
        
        if ( !var_ce74fa86b4e1ada3 && time_elapsed >= timeout_ms - utility::function_4b74c15943231980( 5 ) && !player utility::ent_flag( "w_a_p_v_i_p_garnet" ) && !player utility::ent_flag( "twins_ee_game_active" ) )
        {
            player utility::function_32b24db3127bff40( "scarab_ap_teleport_fx", "warning" );
            var_ce74fa86b4e1ada3 = 1;
        }
        
        if ( time_elapsed >= timeout_ms && !player utility::ent_flag( "w_a_p_v_i_p_garnet" ) && !player utility::ent_flag( "twins_ee_game_active" ) )
        {
            /#
                iprintlnbold( "<dev string:x174>" );
            #/
            
            level thread function_d5ddbca43097a0ff();
            return;
        }
        
        if ( player utility::ent_flag( "w_a_p_v_i_p_garnet" ) )
        {
            player utility::ent_flag_waitopen_any( "w_a_p_v_i_p_garnet" );
            wait 5;
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x61d8f966, Offset: 0x100fb
// Size: 0xa7
function private function_fffbb4206132844f()
{
    level endon( #"ww_a_p_cleanup_in_progress" );
    level.scarab_ww_quest.var_ea16e7bd7c8a01e8 endon( #"death" );
    
    while ( true )
    {
        level.scarab_ww_quest.var_ea16e7bd7c8a01e8 waittill( #"trigger", player );
        
        if ( !isplayer( player ) || !isalive( player ) )
        {
            continue;
        }
        
        if ( !player utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) )
        {
            continue;
        }
        
        if ( player utility::ent_flag( "w_a_p_v_i_p_garnet" ) )
        {
            continue;
        }
        
        level thread function_d5ddbca43097a0ff();
        return;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1
// Checksum 0x613888e3, Offset: 0x101aa
// Size: 0x1c9
function function_d5ddbca43097a0ff( var_99064b9592368173 )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "ww_a_p_cleanup_in_progress" ) || !level utility::flag( "WW_A_P_IN_USE" ) )
    {
        return;
    }
    
    level utility::flag_set( "ww_a_p_cleanup_in_progress" );
    
    if ( utility::issharedfuncdefined( #"astral_plane", #"hash_398ed0d3c1d71a38" ) )
    {
        utility::callsharedfunc( #"astral_plane", #"hash_398ed0d3c1d71a38" );
    }
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && player utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) )
        {
            level thread function_69cd274b8fcf956f( player, var_99064b9592368173 );
        }
    }
    
    wait 1.5;
    level function_c7b3cc5d4daf663();
    level function_aedf6546d4a7a2();
    wait 1;
    
    if ( level.scarab_ww_quest.var_7ba53ebdc38a4c73 )
    {
        level.scarab_ww_quest.var_7ba53ebdc38a4c73 freescriptable();
    }
    
    if ( level.scarab_ww_quest.var_ea16e7bd7c8a01e8 )
    {
        level.scarab_ww_quest.var_ea16e7bd7c8a01e8 delete();
    }
    
    level.var_a52fc6524d39e8e9 = level.scarab_ww_quest.var_ba94d7dcbaa92bfb;
    level function_c53246740ce88066();
    level utility::flag_clear( "ww_a_p_cleanup_in_progress" );
    level notify( #"hash_a4cefdbdb8534cf0" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xc74d022b, Offset: 0x1037b
// Size: 0x63
function private function_aedf6546d4a7a2()
{
    level utility::flag_clear( "WW_A_P_IN_USE" );
    level utility::flag_clear( "w_a_p_r_s_vault" );
    level.scarab_ww_quest.var_f9e1c104c8edb0bf = undefined;
    level zone_manager::set_zone_enabled( "zone_ee_ashwoods", 0 );
    
    if ( level callback::exists( "special_round_start", &function_ab6df1e4ee184409 ) )
    {
        level callback::remove( "special_round_start", &function_ab6df1e4ee184409 );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xfa77a9c7, Offset: 0x103e6
// Size: 0x18e
function private function_69cd274b8fcf956f( player, var_99064b9592368173 )
{
    player endon( #"death_or_disconnect" );
    player notify( #"exit_astral_projection" );
    
    if ( var_99064b9592368173 )
    {
        s_exit_destination = var_99064b9592368173;
    }
    else if ( player.var_c0539489de2c62bc )
    {
        s_exit_destination = player.var_c0539489de2c62bc;
    }
    else if ( level.scarab_ww_quest.var_9ec936076b99c433 )
    {
        s_exit_destination = { #angles:level.scarab_ww_quest.var_9ec936076b99c433.angles, #origin:level.scarab_ww_quest.var_9ec936076b99c433.origin };
    }
    
    if ( s_exit_destination )
    {
        player thread function_67663890f9cd3e20( s_exit_destination.origin, s_exit_destination.angles );
    }
    else
    {
        var_26462c020d370d71 = utility::getstruct( "vt_a_p_end_spawn_parent", "targetname" );
        player thread function_83378f709aa6acc2( var_26462c020d370d71 );
    }
    
    player playlocalsound( #"hash_4e14ee5c47d5c772" );
    wait 1.5;
    player function_e69097e7d69abde0();
    level function_bc0bd512e7665b79( player );
    level function_c53246740ce88066();
    player val::set( "ap_warped_out_grace_period", "ignoreme", 1 );
    wait 1;
    
    if ( isalive( player ) )
    {
        player clearpredictedstreampos();
        player notify( #"finished_exit_astral_projection" );
    }
    
    player utility::delaythread( 6, &val::reset_all, "ap_warped_out_grace_period" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0
// Checksum 0xc9cceaa5, Offset: 0x1057c
// Size: 0x9d
function function_c7b3cc5d4daf663()
{
    var_dc802d68a24bc4ff = function_43497cf318c703b5();
    
    foreach ( zombie in var_dc802d68a24bc4ff )
    {
        if ( isalive( zombie ) )
        {
            zombie.nocorpse = 1;
            zombie thread function_a48053dd962a908e( 0 );
            waitframe();
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0
// Checksum 0x6638b5df, Offset: 0x10621
// Size: 0x8f
function function_43497cf318c703b5()
{
    a_zombies = level.scarab_ww_quest.var_c2740b15b8d89540;
    a_zombies = arraycombineunique( a_zombies, level.scarab_ww_quest.var_d4c029c55e977dc7 );
    a_zombies = arraycombineunique( a_zombies, level.scarab_ww_quest.var_2525db782c51cf5e );
    a_zombies = arraycombineunique( a_zombies, level.scarab_ww_quest.var_858df476a878f27e );
    a_zombies = arraycombineunique( a_zombies, level.scarab_ww_quest.var_a65c4a1c47029a88 );
    return a_zombies;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xd6a1e8f9, Offset: 0x106b9
// Size: 0x63
function private function_da2567008371ded8( player )
{
    if ( level utility::flag( "w_s_10_p_1_c_comet" ) && level utility::flag( "w_s_10_p_3_c_cinder" ) && level utility::flag( "w_s_10_p_2_c_marble" ) )
    {
        if ( level zm_quest::function_b0a5181ebe7bb905() )
        {
            player setclientomnvar( "ui_show_quest_ui_nohud", 0 );
        }
        
        level utility::delaythread( 3, &function_63e5f8dcb995ab33, player );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xb7bc525f, Offset: 0x10724
// Size: 0x37
function private function_63e5f8dcb995ab33( player )
{
    if ( isalive( player ) )
    {
        player utility::function_32b24db3127bff40( "scarab_ap_teleport_fx", "warning" );
    }
    
    level utility::delaythread( 5, &function_d5ddbca43097a0ff );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x85fc70a0, Offset: 0x10763
// Size: 0x1d, Type: bool
function private function_808f3f47c71c0799( player )
{
    return player getscriptablepartstate( "scarab_ap_teleport_fx" ) == "warning";
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x69584117, Offset: 0x10789
// Size: 0x1b3
function private function_263163501668201e()
{
    self endon( #"death_or_disconnect" );
    self endon( #"exit_astral_projection" );
    level endon( #"hash_e556220fb37faf9b" );
    level endon( #"ww_a_p_cleanup_in_progress" );
    
    if ( level utility::flag( "w_a_p_s_s_h_lagoon" ) && level utility::flag( "w_a_p_b_s_h_meadow" ) )
    {
        return;
    }
    
    var_8edd216e7f09987d = utility::getstruct( "s_p_v_t", "targetname" );
    
    while ( true )
    {
        if ( !level utility::flag( "w_a_p_s_s_h_lagoon" ) && !function_808f3f47c71c0799( self ) )
        {
            if ( distancesquared( self.origin, level.scarab_ww_quest.rifle_item.origin ) <= squared( 90 ) )
            {
                var_83fc378ec1663686 = anglestoforward( var_8edd216e7f09987d.angles );
                var_83fc378ec1663686 = ( var_83fc378ec1663686[ 0 ], var_83fc378ec1663686[ 1 ], 0 );
                vec_to_player = vectornormalize2( self.origin - var_8edd216e7f09987d.origin );
                
                if ( vectordot( var_83fc378ec1663686, vec_to_player ) >= cos( 180 ) )
                {
                    thread function_fe66c989eabff107();
                }
            }
        }
        
        level throttle::throttle_wait_in_queue( level.scarab_ww_quest.astral_projection_throttle );
        
        if ( !level utility::flag( "w_a_p_b_s_h_meadow" ) && !function_808f3f47c71c0799( self ) )
        {
            if ( distancesquared( self.origin, level.scarab_ww_quest.bow_item.origin ) <= squared( 90 ) )
            {
                thread function_a52d7069db87a605();
            }
        }
        
        level throttle::throttle_wait_in_queue( level.scarab_ww_quest.astral_projection_throttle );
        waitframe();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xa46fffb8, Offset: 0x10944
// Size: 0x205
function private function_b7a530ac452e465b()
{
    utility::ent_flag_set( "w_a_p_v_i_p_garnet" );
    self.var_a70cdb59a2258435 = gettime();
    self.var_14d65c46d17b2fe = undefined;
    disable_weapon( 1 );
    self setscriptablepartstate( "scarab_wwq_fx", "astral_projection_vision", 0 );
    val::set( "ww_quest_a_p_vision", "ignoreme", 1 );
    val::set( "ww_quest_a_p_vision", "allow_movement", 0 );
    val::set( "ww_quest_a_p_vision", "damage", 0 );
    val::set( "ww_quest_a_p_vision", "stance_change", 0 );
    val::set( "ww_quest_a_p_vision", "allow_jump", 0 );
    val::set( "ww_quest_a_p_vision", "freezecontrols_allowlook", 1 );
    val::set( "ww_quest_a_p_vision", "ignore_afk", 1 );
    val::set( "ww_quest_a_p_vision", "fire", 0 );
    val::set( "ww_quest_a_p_vision", "allow_toggle_third_person", 0 );
    val::set( "ww_quest_a_p_vision", "slide", 0 );
    
    if ( !isdefined( self.defaultbasefov ) )
    {
        self.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    self lerpfovscalefactor( 0, 0 );
    pbgpostfxbundleend( self, %"cer_zm_ruby_echoes_cave" );
    pbgpostfxbundlestart( self, %"cer_zm_ruby_echoes_cave_intense" );
    self setclientomnvar( "ui_show_quest_ui_nohud", 0 );
    self.var_62b898b055222a68 = self getcamerathirdperson();
    
    if ( self.var_62b898b055222a68 )
    {
        self setcamerathirdperson( 0 );
    }
    
    set_combat_hud( 0 );
    level.var_89dcfbd19d153b27 = getaiarrayinradius( self.origin, 850 );
    
    foreach ( zombie in level.var_89dcfbd19d153b27 )
    {
        zombie invisiblenotsolid();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x8727ed38, Offset: 0x10b51
// Size: 0x127
function private function_aef3c1db7cfe5e94()
{
    utility::ent_flag_clear( "w_a_p_v_i_p_garnet" );
    self.var_a70cdb59a2258435 = undefined;
    self.var_14d65c46d17b2fe = undefined;
    disable_weapon( 0 );
    self setscriptablepartstate( "scarab_wwq_fx", "astral_projection_on", 0 );
    val::reset_all( "ww_quest_a_p_vision" );
    self modifybasefov( self.defaultbasefov, 1 );
    self lerpfovscalefactor( 1, 0 );
    pbgpostfxbundleend( self, %"cer_zm_ruby_echoes_cave_intense" );
    pbgpostfxbundlestart( self, %"cer_zm_ruby_echoes_cave" );
    self setclientomnvar( "ui_show_quest_ui_nohud", 1 );
    
    if ( self.var_62b898b055222a68 )
    {
        self setcamerathirdperson( 1 );
    }
    
    set_combat_hud( 1 );
    
    foreach ( zombie in level.var_89dcfbd19d153b27 )
    {
        zombie visiblesolid();
    }
    
    thread function_2d76a73eaf76a983();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x62b963ab, Offset: 0x10c80
// Size: 0x30
function private function_2d76a73eaf76a983()
{
    self endon( #"death_or_disconnect" );
    val::set( "ww_quest_a_p_vision_exit_grace", "ignoreme", 1 );
    wait 2;
    val::reset_all( "ww_quest_a_p_vision_exit_grace" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x3ea5ca3b, Offset: 0x10cb8
// Size: 0x67
function private disable_weapon( b_no_weapon = 1 )
{
    if ( b_no_weapon )
    {
        val::set( "ww_astral_projection_weapons", "weapon", 0 );
        val::set( "ww_astral_projection_weapons", "reload", 0 );
        return;
    }
    
    val::set( "ww_astral_projection_weapons", "weapon", 1 );
    val::set( "ww_astral_projection_weapons", "reload", 1 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 3, eflags: 0x4
// Checksum 0xb1e5f111, Offset: 0x10d27
// Size: 0x114, Type: bool
function private function_bc7e225fa70b66a2( v_goal_origin, n_time = 1, var_899b9bbe505cba96 )
{
    self endon( #"death_or_disconnect" );
    var_9b0535a434f74a2c = self getplayerangles();
    lerpfraction = 0;
    starttime = gettime();
    lerpduration = n_time * 1000;
    v_twist = ( 0, 0, 0 );
    
    if ( !var_899b9bbe505cba96 )
    {
        v_twist = ( 0, 0, randomintrange( -33, 33 ) );
    }
    
    while ( true )
    {
        if ( function_bd02908bf7416ec() )
        {
            return true;
        }
        
        timepassed = gettime() - starttime;
        lerpfraction = timepassed / lerpduration;
        v_goal_angles = vectortoangles( v_goal_origin - utility::get_player_camera_origin() ) + v_twist;
        
        if ( lerpfraction < 1 )
        {
            v_angles = anglelerpquatfrac( var_9b0535a434f74a2c, v_goal_angles, lerpfraction );
            self setplayerangles( v_angles );
        }
        else
        {
            self setplayerangles( v_goal_angles );
            return false;
        }
        
        waitframe();
    }
    
    return false;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xab28fb30, Offset: 0x10e44
// Size: 0xc2, Type: bool
function private function_bd02908bf7416ec()
{
    if ( !self.var_a70cdb59a2258435 )
    {
        self.var_a70cdb59a2258435 = gettime();
    }
    
    if ( !utility::time_has_passed( self.var_a70cdb59a2258435, 2 ) )
    {
        self.var_14d65c46d17b2fe = undefined;
        return false;
    }
    
    v_movement = self getnormalizedmovement( 0.8, 0.8 );
    var_cc5c316fede9f9e2 = length2d( v_movement ) >= 0.8;
    
    if ( !var_cc5c316fede9f9e2 )
    {
        self.var_14d65c46d17b2fe = undefined;
        return false;
    }
    
    if ( !self.var_14d65c46d17b2fe )
    {
        self.var_14d65c46d17b2fe = gettime();
        return false;
    }
    
    n_hold_duration_ms = gettime() - self.var_14d65c46d17b2fe;
    return n_hold_duration_ms > utility::function_4b74c15943231980( 0.8 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xb6465722, Offset: 0x10f0f
// Size: 0xf
function private function_533618d10f0bb077()
{
    overlord::function_e155a19c69aed191( [ self ] );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x6f72647b, Offset: 0x10f26
// Size: 0x3c
function private function_553d4eb674b9d3e0( v_origin )
{
    var_aca464fa1d30bf62 = function_47c86977a18df38b( level.scarab_ww_quest.var_3be0b45c14e1e745, v_origin );
    return var_aca464fa1d30bf62.origin;
}

// Namespace zm_sat_scarab_ww_quest
// Params 4, eflags: 0x4
// Checksum 0x9d8bb744, Offset: 0x10f6b
// Size: 0x20f, Type: bool
function private function_e5042e52eb214a53( var_f97bb796bebbac76, var_50143896b3dba792 = 0.6, var_899b9bbe505cba96 = 1, var_7a76bc5d842b86c7 )
{
    self endon( #"death_or_disconnect" );
    defaultbasefov = self.defaultbasefov;
    val::set( "ww_quest_a_p_vision", "move_speed_scale", 0.01 );
    var_77aa2a7c23d641d9 = 0;
    
    for ( i = 0; i < var_f97bb796bebbac76.size ; i++ )
    {
        step = var_f97bb796bebbac76[ i ];
        var_cbb512a239813764 = step.pan_time ?? var_50143896b3dba792;
        var_a9214b1fa75844b9 = step.focus_time ?? 0;
        n_fov_in_time = step.fov_in_time ?? var_cbb512a239813764;
        n_fov_out_time = step.fov_out_time ?? var_cbb512a239813764;
        b_last_step = i == var_f97bb796bebbac76.size - 1;
        
        if ( b_last_step )
        {
            n_remaining_duration = max( 0, var_7a76bc5d842b86c7 - var_77aa2a7c23d641d9 + var_cbb512a239813764 );
            var_a9214b1fa75844b9 = n_remaining_duration;
            
            if ( step.var_af25c214afcc1fc3 )
            {
                n_fov_out_time = n_remaining_duration;
            }
        }
        
        if ( step.var_72a89b2e08c4be82 || step.var_af25c214afcc1fc3 )
        {
            thread function_55b8d736a3d40682( defaultbasefov, step.var_72a89b2e08c4be82, n_fov_in_time, step.var_af25c214afcc1fc3, n_fov_out_time );
        }
        
        var_63aaeee8f3b236ea = function_bc7e225fa70b66a2( step.origin, var_cbb512a239813764, var_899b9bbe505cba96 );
        
        if ( var_63aaeee8f3b236ea )
        {
            return true;
        }
        
        var_77aa2a7c23d641d9 += var_cbb512a239813764;
        
        if ( var_a9214b1fa75844b9 > 0 )
        {
            var_d1f4f7248bd17670 = gettime();
            
            while ( gettime() - var_d1f4f7248bd17670 < utility::function_4b74c15943231980( var_a9214b1fa75844b9 ) )
            {
                if ( function_bd02908bf7416ec() )
                {
                    return true;
                }
                
                waitframe();
            }
            
            var_77aa2a7c23d641d9 += var_a9214b1fa75844b9;
        }
    }
    
    val::set( "ww_quest_a_p_vision", "move_speed_scale", 0.65 );
    return false;
}

// Namespace zm_sat_scarab_ww_quest
// Params 5, eflags: 0x4
// Checksum 0x817bb98b, Offset: 0x11183
// Size: 0x7c
function private function_55b8d736a3d40682( var_ebaa37b9c3ec7c0e, var_8a916af414adfd9f, n_fov_in_time, var_81a059de7a03d6c, n_fov_out_time )
{
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( var_8a916af414adfd9f ) )
    {
        self modifybasefov( int( var_ebaa37b9c3ec7c0e * var_8a916af414adfd9f ), n_fov_in_time, 0.3 );
    }
    
    if ( isdefined( var_81a059de7a03d6c ) )
    {
        if ( n_fov_in_time > 0 )
        {
            wait n_fov_in_time;
        }
        
        self modifybasefov( int( var_ebaa37b9c3ec7c0e * var_81a059de7a03d6c ), n_fov_out_time, 0.3 );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x588a794f, Offset: 0x11207
// Size: 0x1be
function private function_fe66c989eabff107()
{
    level utility::flag_set( "w_a_p_s_s_h_lagoon" );
    level thread function_51f12524c830dd09();
    function_b7a530ac452e465b();
    var_65ef33a2caa1d188 = 0.5;
    var_6339deb0dd4a30b4 = utility::getstruct( "r_p_s_l", "targetname" );
    
    if ( distancesquared( self.origin, level.scarab_ww_quest.rifle_item.origin ) <= squared( 60 ) )
    {
        level.scarab_ww_quest.var_b8e06220e1014427 += var_65ef33a2caa1d188;
        function_fd64e7e1aa9e5c71( var_6339deb0dd4a30b4, var_65ef33a2caa1d188 );
    }
    
    var_f3c2cb9bfb0d23f8 = function_a8bd48519db5348f( "scarab_scw2_astral_scene_rifle_boy" );
    level.scarab_ww_quest.var_b8e06220e1014427 += var_f3c2cb9bfb0d23f8;
    thread function_bfe16b53d76d31ef( "scarab_scw2_astral_scene_rifle_boy" );
    var_c62bcc5525b133c = level function_553d4eb674b9d3e0( level.scarab_ww_quest.rifle_item.origin );
    var_f97bb796bebbac76 = function_41710b7c5e4d7f90( var_c62bcc5525b133c );
    var_63aaeee8f3b236ea = function_e5042e52eb214a53( var_f97bb796bebbac76, 0.6, 1, var_f3c2cb9bfb0d23f8 );
    
    if ( isalive( self ) )
    {
        if ( var_63aaeee8f3b236ea )
        {
            function_533618d10f0bb077();
        }
        
        function_aef3c1db7cfe5e94();
        utility::delaythread( 1.5, &function_b41dedcc915732d1, self, level.scarab_ww_quest.var_c2740b15b8d89540, "sat_spawner_zombie_base_zm_firefly_sunken" );
    }
    
    level.scarab_ww_quest.rifle_item setscriptablepartstate( "zmloot_scarab_ry_part_r", "visible" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x418cc56d, Offset: 0x113cd
// Size: 0x16a
function private function_41710b7c5e4d7f90( var_c62bcc5525b133c )
{
    var_f97bb796bebbac76 = [];
    var_dc2879e7a32534b3 = var_c62bcc5525b133c + ( 0, 0, 60 );
    var_f97bb796bebbac76[ var_f97bb796bebbac76.size ] = { #fov_out_time:11, #var_af25c214afcc1fc3:1, #fov_in_time:1, #var_72a89b2e08c4be82:0.7, #pan_time:1, #focus_time:12, #origin:var_dc2879e7a32534b3 };
    var_f97bb796bebbac76[ var_f97bb796bebbac76.size ] = { #fov_in_time:13, #var_72a89b2e08c4be82:0.8, #pan_time:4, #focus_time:10, #origin:level.scarab_ww_quest.rifle_item.origin };
    var_32c27bc4d92e2aa4 = ( var_dc2879e7a32534b3 + level.scarab_ww_quest.rifle_item.origin + ( 0, 0, 16 ) ) * 0.5;
    var_f97bb796bebbac76[ var_f97bb796bebbac76.size ] = { #var_af25c214afcc1fc3:1.4, #fov_in_time:4, #var_72a89b2e08c4be82:1, #pan_time:4, #origin:var_32c27bc4d92e2aa4 };
    return var_f97bb796bebbac76;
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x17e8a74f, Offset: 0x11540
// Size: 0x10d
function private function_d331253ff802b0eb( player, b_skipped )
{
    level zm_quest::function_b57dfe9625966b0b( #"wwq", 0, #"rifle", 1 );
    
    if ( player )
    {
        level zm_quest::show_splash_item_picked_up( #"wwq", #"rifle", 1, player );
    }
    
    if ( b_skipped )
    {
        if ( level.scarab_ww_quest.rifle_item )
        {
            common_item::function_869d7676e359a627( level.scarab_ww_quest.rifle_item );
        }
        
        level utility::flag_set( "w_a_p_s_s_h_lagoon" );
    }
    
    level function_64e0a04939df996d( "sn_d_a_part_r", %"hash_54ad35f2b304126c", "zmloot_scarab_ry_part_r" );
    
    if ( !b_skipped && player )
    {
        player utility::delaythread( 0.5, &function_e7337c56375cb30e, "scarab_scw2_pick_up_rifle" );
    }
    
    level utility::flag_set( "w_s_10_p_1_c_comet" );
    
    if ( !b_skipped )
    {
        level function_da2567008371ded8( player );
    }
    
    level function_b20f75e74697d6ea();
    level utility::delaythread( 0.5, &function_51f12524c830dd09 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xdbf6d9db, Offset: 0x11655
// Size: 0xfd
function private function_241fc123b396130e()
{
    self endon( #"death" );
    level endon( #"ww_a_p_cleanup_in_progress" );
    level endon( #"hash_e556220fb37faf9b" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isplayer( attacker ) && meansofdeath == "MOD_MELEE" && !player::isinlaststand( attacker ) && !attacker.ismutantinjection && !function_808f3f47c71c0799( attacker ) )
        {
            attacker damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
            level thread function_fedbb692e1ca52ea( attacker );
            return;
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x7d36f86c, Offset: 0x1175a
// Size: 0x7a
function private function_fedbb692e1ca52ea( player )
{
    if ( level.scarab_ww_quest.var_77500ecd839e52e4 )
    {
        level.scarab_ww_quest.var_77500ecd839e52e4 delete();
    }
    
    level.scarab_ww_quest.floor_board setscriptablepartstate( "body", "moved" );
    level utility::flag_set( "w_f_b_b_talon" );
    level thread function_51f12524c830dd09();
    player thread function_bd1e5602ff4a40c9();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x1e529deb, Offset: 0x117dc
// Size: 0x132
function private function_bd1e5602ff4a40c9()
{
    level utility::flag_set( "w_a_p_str_s_h_summit" );
    
    /#
        iprintlnbold( "<dev string:x18f>" );
    #/
    
    function_b7a530ac452e465b();
    var_f3c2cb9bfb0d23f8 = function_a8bd48519db5348f( "scarab_scw2_astral_scene_string_man" );
    level.scarab_ww_quest.var_b8e06220e1014427 += var_f3c2cb9bfb0d23f8;
    var_46b3ea356a15ad95 = level function_553d4eb674b9d3e0( level.scarab_ww_quest.string_item.origin );
    var_f97bb796bebbac76 = function_d8076e17c821fd09( var_46b3ea356a15ad95 );
    thread function_bfe16b53d76d31ef( "scarab_scw2_astral_scene_string_man" );
    var_63aaeee8f3b236ea = function_e5042e52eb214a53( var_f97bb796bebbac76, 0.6, 1, var_f3c2cb9bfb0d23f8 );
    
    if ( isalive( self ) )
    {
        if ( var_63aaeee8f3b236ea )
        {
            function_533618d10f0bb077();
        }
        
        function_aef3c1db7cfe5e94();
        utility::delaythread( 1.5, &function_b41dedcc915732d1, self, level.scarab_ww_quest.var_d4c029c55e977dc7, "zombie_loom_minion" );
    }
    
    level.scarab_ww_quest.string_item setscriptablepartstate( "zmloot_scarab_st_part_s", "visible" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xb3cfe4b0, Offset: 0x11916
// Size: 0x136
function private function_d8076e17c821fd09( var_46b3ea356a15ad95 )
{
    var_f97bb796bebbac76 = [ { #fov_out_time:21, #var_af25c214afcc1fc3:1, #fov_in_time:1, #var_72a89b2e08c4be82:0.6, #pan_time:1, #focus_time:21, #origin:level.scarab_ww_quest.string_item.origin } ];
    var_f97bb796bebbac76[ var_f97bb796bebbac76.size ] = { #fov_out_time:10, #var_af25c214afcc1fc3:1, #fov_in_time:7, #var_72a89b2e08c4be82:0.8, #pan_time:7, #focus_time:9, #origin:var_46b3ea356a15ad95 };
    var_f97bb796bebbac76[ var_f97bb796bebbac76.size ] = { #fov_in_time:2, #var_72a89b2e08c4be82:1, #pan_time:2, #origin:level.scarab_ww_quest.string_item.origin };
    return var_f97bb796bebbac76;
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x55fe03b2, Offset: 0x11a55
// Size: 0x131
function private function_64e56807b3040e46( player, b_skipped )
{
    level zm_quest::function_b57dfe9625966b0b( #"wwq", 0, #"string", 1 );
    
    if ( player )
    {
        level zm_quest::show_splash_item_picked_up( #"wwq", #"string", 1, player );
    }
    
    if ( b_skipped )
    {
        if ( level.scarab_ww_quest.string_item )
        {
            common_item::function_869d7676e359a627( level.scarab_ww_quest.string_item );
        }
        
        level.scarab_ww_quest.floor_board utility::function_32b24db3127bff40( "body", "moved" );
        level utility::flag_set( "w_a_p_str_s_h_summit" );
    }
    
    level function_64e0a04939df996d( "tr_d_a_part_s", %"hash_2c474f8228e87f25", "zmloot_scarab_st_part_s" );
    
    if ( !b_skipped && player )
    {
        player utility::delaythread( 0.5, &function_e7337c56375cb30e, "scarab_scw2_pick_up_whip" );
    }
    
    level utility::flag_set( "w_s_10_p_3_c_cinder" );
    
    if ( !b_skipped )
    {
        level function_da2567008371ded8( player );
    }
    
    level function_b20f75e74697d6ea();
    level utility::delaythread( 0.5, &function_51f12524c830dd09 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xb82d3f0b, Offset: 0x11b8e
// Size: 0x1be
function private function_a52d7069db87a605()
{
    level utility::flag_set( "w_a_p_b_s_h_meadow" );
    function_b7a530ac452e465b();
    var_65ef33a2caa1d188 = 0.5;
    var_942b1d5349935b0a = utility::getstruct( "b_p_l_s", "targetname" );
    
    if ( distancesquared( self.origin, level.scarab_ww_quest.bow_item.origin ) <= squared( 60 ) )
    {
        level.scarab_ww_quest.var_b8e06220e1014427 += var_65ef33a2caa1d188;
        function_fd64e7e1aa9e5c71( var_942b1d5349935b0a, var_65ef33a2caa1d188 );
    }
    
    var_f3c2cb9bfb0d23f8 = function_a8bd48519db5348f( "scarab_scw2_astral_scene_bow_woman" );
    level.scarab_ww_quest.var_b8e06220e1014427 += var_f3c2cb9bfb0d23f8;
    var_435b888ee48535ba = level function_553d4eb674b9d3e0( level.scarab_ww_quest.bow_item.origin );
    var_f97bb796bebbac76 = function_6f21b0c48f74094e( var_435b888ee48535ba );
    thread function_bfe16b53d76d31ef( "scarab_scw2_astral_scene_bow_woman" );
    var_63aaeee8f3b236ea = function_e5042e52eb214a53( var_f97bb796bebbac76, 0.6, 1, var_f3c2cb9bfb0d23f8 );
    
    if ( isalive( self ) )
    {
        if ( var_63aaeee8f3b236ea )
        {
            function_533618d10f0bb077();
        }
        
        function_aef3c1db7cfe5e94();
        utility::delaythread( 1.5, &function_b41dedcc915732d1, self, level.scarab_ww_quest.var_2525db782c51cf5e, "sat_spawner_zombie_base_zm_firefly_sunken" );
    }
    
    level.scarab_ww_quest.bow_item setscriptablepartstate( "zmloot_scarab_bx_part_b", "visible" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xa9f201da, Offset: 0x11d54
// Size: 0x158
function private function_6f21b0c48f74094e( var_f7fc1f923cfeb939 )
{
    var_f97bb796bebbac76 = [];
    var_f97bb796bebbac76[ var_f97bb796bebbac76.size ] = { #fov_out_time:14, #var_af25c214afcc1fc3:1, #fov_in_time:1, #var_72a89b2e08c4be82:0.7, #pan_time:1, #focus_time:14, #origin:var_f7fc1f923cfeb939 };
    var_f97bb796bebbac76[ var_f97bb796bebbac76.size ] = { #fov_in_time:10, #var_72a89b2e08c4be82:0.7, #pan_time:5, #focus_time:6, #origin:level.scarab_ww_quest.bow_item.origin };
    
    if ( var_f7fc1f923cfeb939 )
    {
        var_d5c50c3b12ec7142 = ( var_f7fc1f923cfeb939 + level.scarab_ww_quest.bow_item.origin + ( 0, 0, 50 ) ) * 0.5;
        var_f97bb796bebbac76[ var_f97bb796bebbac76.size ] = { #var_af25c214afcc1fc3:1.4, #fov_in_time:4, #var_72a89b2e08c4be82:1.3, #pan_time:4, #origin:var_d5c50c3b12ec7142 };
    }
    
    return var_f97bb796bebbac76;
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x18d53ba, Offset: 0x11eb5
// Size: 0x14e
function private function_c4220f02160f9859( player, b_skipped )
{
    level zm_quest::function_b57dfe9625966b0b( #"wwq", 0, #"bow", 1 );
    
    if ( player )
    {
        level zm_quest::show_splash_item_picked_up( #"wwq", #"bow", 1, player );
    }
    
    if ( level.scarab_ww_quest.bow_nav_obstacle )
    {
        destroynavobstacle( level.scarab_ww_quest.bow_nav_obstacle );
        level.scarab_ww_quest.bow_nav_obstacle = undefined;
    }
    
    if ( b_skipped )
    {
        if ( level.scarab_ww_quest.bow_item )
        {
            common_item::function_869d7676e359a627( level.scarab_ww_quest.bow_item );
        }
        
        level utility::flag_set( "w_a_p_b_s_h_meadow" );
    }
    
    level function_64e0a04939df996d( "pk_d_a_part_b", %"hash_6842c9ae8635ff95", "zmloot_scarab_bx_part_b" );
    
    if ( !b_skipped && player )
    {
        player utility::delaythread( 0.5, &function_e7337c56375cb30e, "scarab_scw2_pick_up_bow" );
    }
    
    level utility::flag_set( "w_s_10_p_2_c_marble" );
    
    if ( !b_skipped )
    {
        level function_da2567008371ded8( player );
    }
    
    level function_b20f75e74697d6ea();
    level utility::delaythread( 0.5, &function_51f12524c830dd09 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xc508da33, Offset: 0x1200b
// Size: 0xa
function private function_b7cefc26724c15de()
{
    level thread function_d682c0049acd2643();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x6f13be87, Offset: 0x1201d
// Size: 0x27
function private function_41efc24a257f3c3d()
{
    if ( level utility::flag( "w_a_p_r_s_vault" ) )
    {
        return;
    }
    
    level utility::flag_set( "w_a_p_r_s_vault" );
    level thread function_d682c0049acd2643();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0xc
// Checksum 0xd3a0bb88, Offset: 0x1204c
// Size: 0x1c8
function private function_d682c0049acd2643()
{
    self notify( #"hash_268315e542b2f85e" );
    self endon( #"hash_268315e542b2f85e" );
    level endon( #"game_ended" );
    level endon( #"ww_a_p_cleanup_in_progress" );
    level endon( #"hash_e556220fb37faf9b" );
    round_number = zm_round_logic::get_rb_round_number();
    var_cfdcb332178e0755 = [ "zone_ee_ashwoods" ];
    var_e5999964340b378b = [ "sat_spawner_zombie_base_zm_firefly_sunken", "zombie_loom_minion" ];
    level.scarab_ww_quest.var_a65c4a1c47029a88 = [];
    
    while ( true )
    {
        level.scarab_ww_quest.var_a65c4a1c47029a88 = utility::function_8391781ea0784541( level.scarab_ww_quest.var_a65c4a1c47029a88 );
        
        if ( level.scarab_ww_quest.var_a65c4a1c47029a88.size >= 8 )
        {
            waitframe();
            continue;
        }
        
        zombies_count = zm_utility::get_active_zombies_count();
        
        if ( zombies_count >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
        {
            var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] );
            
            if ( !var_d7b3a1f33b95bf77 )
            {
                waitframe();
                continue;
            }
        }
        
        zombie_type = utility::random_weighted( var_e5999964340b378b, [ 80, 20 ] );
        spawners = zone_spawner::function_20c574a6ba7cc5c6( var_cfdcb332178e0755, zombie_type );
        
        if ( !isdefined( spawners ) || spawners.size <= 0 )
        {
            waitframe();
            continue;
        }
        
        zmb_spawner = utility::array_random( spawners );
        zombie = function_54d1adbb85f0d5ca( zombie_type, zmb_spawner, round_number, level.scarab_ww_quest.var_a65c4a1c47029a88 );
        
        if ( zombie )
        {
            zombie function_c0b1d35bc1be7a69();
        }
        
        wait 2;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 3, eflags: 0x4
// Checksum 0xfc3089ec, Offset: 0x1221c
// Size: 0x84
function private function_64e0a04939df996d( var_dc6a4b4b351da087, item_bundle, item_scriptable_part_name )
{
    var_c5fb7b9c0ca383b7 = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    item = function_790454e66cc6d12c( item_bundle, var_c5fb7b9c0ca383b7.origin, var_c5fb7b9c0ca383b7.angles );
    item setscriptablepartstate( item_scriptable_part_name, "unusable" );
    level.scarab_ww_quest.var_9bcd82f47753e4c5[ item_scriptable_part_name ] = item;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x4fbf451b, Offset: 0x122a8
// Size: 0x83
function private function_f95bf06f1fd45e89( player )
{
    if ( player && player.interactions_disabled )
    {
        return;
    }
    
    level utility::flag_set( "w_o_d_a_pioneer" );
    level.scarab_ww_quest.anvil setscriptablepartstate( "usable", "off" );
    playworldsound( level.scarab_ww_quest.anvil.origin, #"hash_a2b013f4cad82bb1" );
    level thread function_b37e069604536bfb();
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x833f7380, Offset: 0x12333
// Size: 0xac
function private anvil_hint( interact, player )
{
    if ( player && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    hintstring_obj = { #icon:"sat_ui_icon_zm_dravakar_anvil", #buttoncallout:&"hash_2515dd7d6af02a14", #description:&"hash_51edb31b3ab6eb22", #title:&"hash_6c60f9db7f99be5d", #type:"HINT_BUTTON" };
    return hintstring_obj;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0
// Checksum 0x923afcb4, Offset: 0x123e8
// Size: 0x25
function function_b37e069604536bfb()
{
    level thread function_ce0d45429c151a4a();
    wait 3;
    level function_3f203864ea2e36bc();
    level function_d318c1b7df5c49b5();
    level function_65db3e962e1a65b1();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0
// Checksum 0x2081192c, Offset: 0x12415
// Size: 0x4a
function function_ce0d45429c151a4a()
{
    overlord_players = level function_8676888e7913c7a( "zone_ne_temple_sideroom" );
    
    if ( overlord_players.size > 0 )
    {
        if ( overlord::function_dce0a14273dfa0a8( overlord_players ) )
        {
            zm_quest::function_8934bb2a9028bdc5();
        }
        
        overlord::playevent( #"hash_612f1d965d110939", overlord_players, undefined, undefined, 1 );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0
// Checksum 0x974449dc, Offset: 0x12467
// Size: 0x27e
function function_3f203864ea2e36bc()
{
    var_cd52b3c7a7087b9f = utility::getstruct( "dx_m_start", "targetname" );
    s_meteor_impact = utility::getstruct( "tn_m_end", "targetname" );
    var_93436b5d97cfd76c = vectortoangles( s_meteor_impact.origin - var_cd52b3c7a7087b9f.origin );
    mover = utility::spawn_model( "tag_origin", var_cd52b3c7a7087b9f.origin, var_93436b5d97cfd76c );
    meteor = spawnscriptable( %"hash_79232c6f577bf67c", var_cd52b3c7a7087b9f.origin, var_93436b5d97cfd76c );
    meteor scriptablesetparententity( mover );
    mover moveto( s_meteor_impact.origin, 1, 0.6 );
    mover waittill( #"movedone" );
    meteorimpact = spawnscriptable( %"hash_2eed8391eee358e", s_meteor_impact.origin, ( 0, 0, 1 ) );
    a_zombies_in_range = getaiarrayinradius( s_meteor_impact.origin, 500 );
    
    foreach ( zmb in a_zombies_in_range )
    {
        if ( zmb )
        {
            zmb zombie_knockdown::function_6fc167d4a3590991( s_meteor_impact.origin, 300, 45 );
        }
    }
    
    earthquake( 0.7, 1, s_meteor_impact.origin, 500 );
    playrumbleonposition( "heavy_1s", s_meteor_impact.origin );
    var_484ed23f896479f = getplayersinradius( s_meteor_impact.origin, 300 );
    
    foreach ( player in var_484ed23f896479f )
    {
        player shellshock( "sat_flashbang_zm_scarab", 2 );
    }
    
    mover delete();
    meteor freescriptable();
    meteorimpact utility::delaycall( 5, &freescriptable );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xcb751883, Offset: 0x126ed
// Size: 0x93
function private function_65db3e962e1a65b1()
{
    level utility::flag_set( "w_s_11_c_aurora" );
    level zm_music::function_446e6e39d7feeb7c( [ "zone_ne_temple_sideroom" ], #"anvil_craft_ww" );
    var_fe68cd50dcda7fdc = utility::getstruct( "wt_spawn", "targetname" );
    wonder_weapon_item = function_790454e66cc6d12c( %"hash_4844829b9d56a021", var_fe68cd50dcda7fdc.origin, var_fe68cd50dcda7fdc.angle, 1 );
    level function_c576532512aeeae3( wonder_weapon_item );
    level utility::delaythread( 0.5, &function_51f12524c830dd09 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xc69b768e, Offset: 0x12788
// Size: 0x10b
function private function_c576532512aeeae3( wonder_weapon_item )
{
    level.scarab_ww_quest.wonder_weapon_item = wonder_weapon_item;
    var_fe68cd50dcda7fdc = utility::getstruct( "wt_spawn", "targetname" );
    level.scarab_ww_quest.var_fcfa76ff6800ca09 = spawnscriptable( %"hash_175bf8a4f700ba40", var_fe68cd50dcda7fdc.origin, var_fe68cd50dcda7fdc.angles );
    level.scarab_ww_quest.var_85acab423ceb4b1c = utility::spawn_model( "tag_origin", var_fe68cd50dcda7fdc.origin, var_fe68cd50dcda7fdc.angles );
    wonder_weapon_item utility::scriptable_setparententity( level.scarab_ww_quest.var_85acab423ceb4b1c );
    level.scarab_ww_quest.var_85acab423ceb4b1c bobbing( ( 0, 0, 1 ), 2, 2 );
    wonder_weapon_item thread utility::delete_on_death( level.scarab_ww_quest.var_85acab423ceb4b1c );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x8198778a, Offset: 0x1289b
// Size: 0x85
function private function_d318c1b7df5c49b5()
{
    foreach ( part in level.scarab_ww_quest.var_9bcd82f47753e4c5 )
    {
        common_item::function_869d7676e359a627( part );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 3, eflags: 0x4
// Checksum 0xcebecc6c, Offset: 0x12928
// Size: 0x139
function private function_b58aeb51fa24dc15( player, b_skipped, params )
{
    if ( !b_skipped && params.item != level.scarab_ww_quest.wonder_weapon_item )
    {
        return;
    }
    
    if ( b_skipped )
    {
        if ( level.scarab_ww_quest.wonder_weapon_item )
        {
            common_item::function_869d7676e359a627( level.scarab_ww_quest.wonder_weapon_item );
        }
    }
    
    if ( level.scarab_ww_quest.var_fcfa76ff6800ca09 )
    {
        level.scarab_ww_quest.var_fcfa76ff6800ca09 freescriptable();
    }
    
    if ( level.scarab_ww_quest.var_85acab423ceb4b1c )
    {
        level.scarab_ww_quest.var_85acab423ceb4b1c delete();
    }
    
    if ( !level utility::flag( "w_s_12_c_rivet" ) && !b_skipped && player )
    {
        player utility::delaythread( 1, &function_c99b85fe440b3386, "wwq_vo_pick_up_ww", "scarab_scw2_pick_up_ww", #"bc_flavor_player_positive" );
        player utility::delaythread( 0.1, &function_e45a1c6a7cd5d5db );
    }
    
    level utility::flag_set( "w_s_12_c_rivet" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xf1bd1cb0, Offset: 0x12a69
// Size: 0x35
function private function_e45a1c6a7cd5d5db()
{
    if ( isalive( self ) )
    {
        var_97fba1c5c18b108f = self getcurrentweapon();
        
        if ( var_97fba1c5c18b108f.basename == "sat_ww_scarab_zm" )
        {
            self forceweaponinspect();
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x39a4312, Offset: 0x12aa6
// Size: 0x17d
function private function_8e9c97cfcd10ea15( params )
{
    if ( level.scarab_ww_quest.wonder_weapon_item )
    {
        return;
    }
    
    if ( self.var_f5ee28e51c394b99.weaponobj && self.var_f5ee28e51c394b99.weaponobj.basename == "sat_ww_scarab_zm" )
    {
        weapon_info_struct = item_weapon::function_8daff85dacc00ff4( self, self.var_f5ee28e51c394b99.weaponobj, self.var_f5ee28e51c394b99.weaponobj.ammomod );
        level thread function_e77fa1e434d179e2( weapon_info_struct, self.var_f5ee28e51c394b99.weaponobj );
        common_item::function_869d7676e359a627( self.var_f5ee28e51c394b99 );
        return;
    }
    
    primary_weapons = self getweaponslistprimaries();
    
    foreach ( weapon in primary_weapons )
    {
        if ( weapon.basename == "sat_ww_scarab_zm" )
        {
            weapon_info_struct = item_weapon::function_8daff85dacc00ff4( self, weapon, weapon.ammomod );
            level thread function_e77fa1e434d179e2( weapon_info_struct, weapon );
            return;
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xb1b84483, Offset: 0x12c2b
// Size: 0x1b0
function private function_56178e12960b566c( params )
{
    level endon( #"game_ended" );
    waitframe();
    
    if ( !params.item || !params.item.weaponobj || params.item.weaponobj.basename != "sat_ww_scarab_zm" )
    {
        return;
    }
    
    var_8a61d4195b4b6e64 = params.item;
    weapon_obj = var_8a61d4195b4b6e64.weaponobj;
    count = var_8a61d4195b4b6e64.count;
    weapon_stock_ammo = var_8a61d4195b4b6e64.weaponstockammo;
    pap_level = var_8a61d4195b4b6e64.var_951c89546ec50477;
    var_d5009c748c570641 = var_8a61d4195b4b6e64.var_6828becb300b1c44;
    weapon_info_struct = item_weapon::function_8daff85dacc00ff4( self, weapon_obj );
    var_8a61d4195b4b6e64 waittill( #"death" );
    
    if ( function_a111c6fcbfd3a928() )
    {
        return;
    }
    
    if ( !weapon_obj )
    {
        return;
    }
    
    weapon_info_struct.ammoclipright = common_item::function_44eacd480abb5b94( count );
    weapon_info_struct.ammoclipleft = common_item::function_5c3ce1ec7db94488( count );
    weapon_info_struct.ammoclipalt = common_item::function_3b2613fcafd07797( count );
    weapon_info_struct.ammostock = weapon_stock_ammo ?? weapon_info_struct.ammostock;
    weapon_info_struct.paplv = pap_level ?? weapon_info_struct.paplv;
    
    if ( var_d5009c748c570641 )
    {
        weapon_info_struct.var_6828becb300b1c44 = var_d5009c748c570641;
    }
    
    level thread function_e77fa1e434d179e2( weapon_info_struct, weapon_obj );
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0xc
// Checksum 0x785fbf3e, Offset: 0x12de3
// Size: 0x190
function private function_e77fa1e434d179e2( weapon_info_struct, weapon )
{
    self notify( #"hash_42c9aeb6f28cdfe5" );
    self endon( #"hash_42c9aeb6f28cdfe5" );
    var_fe68cd50dcda7fdc = utility::getstruct( "wt_spawn", "targetname" );
    spawn_options = common_item::function_bc5ff2958b71a708( var_fe68cd50dcda7fdc.origin, var_fe68cd50dcda7fdc.angles );
    spawn_options.weapon = weapon;
    spawn_options.weaponinfostruct = weapon_info_struct;
    spawn_options.var_8d4f327170228364 = 1;
    spawn_options.var_fd47e835523b473f = 1;
    spawn_options.var_9161cf0784b6951d = 1;
    spawn_options.var_f35b5b18b029c493 = 0;
    spawn_options.critical = 1;
    spawn_options.overridepaplvl = weapon_info_struct.paplv;
    spawn_options.overrideammomod = weapon_info_struct.ammomod;
    level utility::flag_waitopen( "ee_anvil_wp_on_anvil" );
    
    if ( level.scarab_ww_quest.wonder_weapon_item )
    {
        return;
    }
    
    while ( isdefined( level.anvil_ee.gauntlet ) )
    {
        waitframe();
    }
    
    if ( function_a111c6fcbfd3a928() )
    {
        return;
    }
    
    waitframe();
    level function_3f203864ea2e36bc();
    var_8a61d4195b4b6e64 = item_weapon::function_b960bc85ea91de14( getscriptbundle( %"hash_4844829b9d56a021" ), spawn_options );
    
    if ( var_8a61d4195b4b6e64.linkedparent )
    {
        var_8a61d4195b4b6e64 utility::scriptable_clearparententity();
    }
    
    level function_c576532512aeeae3( var_8a61d4195b4b6e64 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x47a5c9d5, Offset: 0x12f7b
// Size: 0x10e, Type: bool
function private function_a111c6fcbfd3a928()
{
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        weapons = player getweaponslistprimaries();
        
        foreach ( weapon in weapons )
        {
            if ( weapon.basename == "sat_ww_scarab_zm" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xf1d6e1a0, Offset: 0x13092
// Size: 0x1a
function private function_7f0a3e0bdc5ff576( sparams )
{
    utility::delaythread( 1, &function_51f12524c830dd09 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x1cdb7985, Offset: 0x130b4
// Size: 0x14
function private function_3da47cc8a6f377a0( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x40db01ba, Offset: 0x130d0
// Size: 0x14
function private function_313b94b67cf87ea9( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x26be6a52, Offset: 0x130ec
// Size: 0x14
function private function_f9648ac90c0e5c6e( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x19691182, Offset: 0x13108
// Size: 0x14
function private function_86270d53ee610cf8( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x93315b69, Offset: 0x13124
// Size: 0x14
function private function_8de1852634135677( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xb97ddb42, Offset: 0x13140
// Size: 0x14
function private function_54826b2c015d5766( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x9c26edd1, Offset: 0x1315c
// Size: 0x14
function private function_4e05cbe30aa6bd7e( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x17b13ad, Offset: 0x13178
// Size: 0x14
function private function_b80bbbe5b9fffb14( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0xc
// Checksum 0x10eca1b1, Offset: 0x13194
// Size: 0x1e2
function private function_d498aa8fc72246cb()
{
    self notify( #"hash_9514d88e6ffcd9aa" );
    self endon( #"hash_9514d88e6ffcd9aa" );
    var_331fbaa3a72359c9 = -1;
    
    foreach ( player in level.players )
    {
        if ( !player utility::ent_flag( "holding_cosmic_usurped_power" ) || !player.var_499637249aa97555 )
        {
            continue;
        }
        
        time_left_ms = max( 0, player.var_499637249aa97555 - gettime() );
        
        if ( time_left_ms > var_331fbaa3a72359c9 )
        {
            var_253b431817cf862c = player;
            var_331fbaa3a72359c9 = time_left_ms;
        }
    }
    
    if ( !isdefined( var_253b431817cf862c ) )
    {
        level utility::flag_clear( "wwq_sync_shoot_cosmic_eye_guidance_timer_active" );
        level thread function_51f12524c830dd09();
        return;
    }
    
    while ( !level utility::flag( "w_e_b_a_reef" ) )
    {
        if ( !isalive( var_253b431817cf862c ) || !var_253b431817cf862c utility::ent_flag( "holding_cosmic_usurped_power" ) || !var_253b431817cf862c.var_499637249aa97555 )
        {
            level utility::flag_clear( "wwq_sync_shoot_cosmic_eye_guidance_timer_active" );
            level thread function_51f12524c830dd09();
            return;
        }
        
        time_left_ms = max( 0, var_253b431817cf862c.var_499637249aa97555 - gettime() );
        
        if ( time_left_ms <= 0 )
        {
            level utility::flag_clear( "wwq_sync_shoot_cosmic_eye_guidance_timer_active" );
            level thread function_51f12524c830dd09();
            return;
        }
        
        level zm_quest::function_612a9ad0db22c29c( time_left_ms, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f6a9fdb2540ecd54" );
        wait 1;
    }
    
    level utility::flag_clear( "wwq_sync_shoot_cosmic_eye_guidance_timer_active" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x6085534c, Offset: 0x1337e
// Size: 0x14
function private function_24dddce9e88daecd( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x5bb050b0, Offset: 0x1339a
// Size: 0x14
function private function_1b7607d1b0d72e20( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x2f19c0e2, Offset: 0x133b6
// Size: 0x1e
function private function_ca976a8ff3827f9( params )
{
    level utility::delaythread( 0.5, &function_51f12524c830dd09 );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x7cb9c4f4, Offset: 0x133dc
// Size: 0x14
function private function_c759ffc24bf0e3f5( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xc6d0e2f3, Offset: 0x133f8
// Size: 0x14
function private function_f2fb98e01bba2de7( params )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xebbb516d, Offset: 0x13414
// Size: 0x80
function private function_8367e8eaabd0aa6d( params )
{
    if ( !params.zone_struct.script_zone_name || params.zone_struct.script_zone_name != "zone_ne_temple_sideroom" )
    {
        return;
    }
    
    level utility::flag_set( "w_o_d_a_pioneer" );
    level thread function_51f12524c830dd09();
    
    if ( level callback::exists( "zone_changed", &function_8367e8eaabd0aa6d ) )
    {
        level callback::remove( "zone_changed", &function_8367e8eaabd0aa6d );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0xc
// Checksum 0x3957b6ec, Offset: 0x1349c
// Size: 0x3b
function private function_2dea72aa54f2ffad()
{
    self notify( #"hash_6f545b360e381a55" );
    self endon( #"hash_6f545b360e381a55" );
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level utility::flag_wait( "southwest_temple_finalroom_door_bought" );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0xc
// Checksum 0xad1fd019, Offset: 0x134df
// Size: 0x98
function private function_40345848c048faea()
{
    self notify( #"hash_6d558c9cb76d04fb" );
    self endon( #"hash_6d558c9cb76d04fb" );
    level endon( #"w_s_1_c_quarry" );
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    var_5a8637cd564cdb48 = 0;
    
    while ( true )
    {
        if ( level utility::flag( "w_s_1_c_quarry" ) || !level.scarab_ww_quest.var_8df3ff996389aaf )
        {
            return;
        }
        
        b_on_ledge = function_c37ba2f04a71f3d9();
        
        if ( b_on_ledge != var_5a8637cd564cdb48 )
        {
            var_5a8637cd564cdb48 = b_on_ledge;
            level thread function_51f12524c830dd09();
        }
        
        wait 0.2;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 5, eflags: 0x4
// Checksum 0xf2a22e79, Offset: 0x1357f
// Size: 0x1a2
function private function_def4c1e8715980a0( flag_name, target, distance, var_937f02187aa11f9d, flag_ent )
{
    level endon( #"game_ended" );
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    var_e2d8d059f0a30085 = isdefined( flag_ent );
    
    if ( var_e2d8d059f0a30085 )
    {
        flag_ent endon( #"hash_9d20391ac1bb8072" );
    }
    
    if ( isvector( target ) )
    {
        target_origin = target;
    }
    else
    {
        target_origin = target.origin;
    }
    
    while ( true )
    {
        if ( var_e2d8d059f0a30085 )
        {
            if ( !flag_ent || flag_ent utility::ent_flag( flag_name ) )
            {
                return;
            }
        }
        else if ( level utility::flag( flag_name ) )
        {
            return;
        }
        
        if ( !target )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, target_origin ) <= squared( distance ) )
            {
                if ( var_937f02187aa11f9d > 0 )
                {
                    if ( !utility::within_fov( player.origin, player getplayerangles(), target_origin, cos( var_937f02187aa11f9d ) ) )
                    {
                        continue;
                    }
                }
                
                if ( var_e2d8d059f0a30085 )
                {
                    flag_ent utility::ent_flag_set( flag_name );
                }
                else
                {
                    level utility::flag_set( flag_name );
                }
                
                level thread function_51f12524c830dd09();
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0xc
// Checksum 0xa4647d80, Offset: 0x13729
// Size: 0xea
function private function_5c6978dc12cd0a8f()
{
    self notify( #"hash_e0783e1abfa3a8d1" );
    self endon( #"hash_e0783e1abfa3a8d1" );
    level utility::flag_wait( "w_s_10_p_1_c_comet" );
    level utility::flag_wait( "w_s_10_p_2_c_marble" );
    level utility::flag_wait( "w_s_10_p_3_c_cinder" );
    
    foreach ( symbol in level.scarab_ww_quest.var_54c01efdbeed8e49 )
    {
        if ( !symbol utility::ent_flag( "wwq_observed_temple_symbol" ) )
        {
            level thread function_def4c1e8715980a0( "wwq_observed_temple_symbol", symbol, symbol.var_9f1e0f1b4a81472a, 45, symbol );
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0xc
// Checksum 0x8ebfe89e, Offset: 0x1381b
// Size: 0xc8
function private function_dc3081884c688758()
{
    self notify( #"hash_e4259ade12d5d640" );
    self endon( #"hash_e4259ade12d5d640" );
    level utility::flag_wait( "w_r_o_bravo" );
    
    foreach ( var_7e7ca0a63d1d515e in level.scarab_ww_quest.var_daae8a1d00edada6 )
    {
        if ( !var_7e7ca0a63d1d515e utility::ent_flag( "wwq_observed_riddle_pillar" ) )
        {
            level thread function_def4c1e8715980a0( "wwq_observed_riddle_pillar", var_7e7ca0a63d1d515e, 275, 45, var_7e7ca0a63d1d515e );
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x1c165763, Offset: 0x138eb
// Size: 0x91, Type: bool
function private function_b96f350d7ce0bd96()
{
    foreach ( symbol in level.scarab_ww_quest.var_54c01efdbeed8e49 )
    {
        if ( !symbol utility::ent_flag( "wwq_observed_temple_symbol" ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x69fc90c8, Offset: 0x13985
// Size: 0x91, Type: bool
function private function_1c09266e1831c289()
{
    foreach ( var_7e7ca0a63d1d515e in level.scarab_ww_quest.var_daae8a1d00edada6 )
    {
        if ( !var_7e7ca0a63d1d515e utility::ent_flag( "wwq_observed_riddle_pillar" ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x214e89d9, Offset: 0x13a1f
// Size: 0xee
function private function_62298debe1eff7e()
{
    hud_data = [];
    
    foreach ( symbol in level.scarab_ww_quest.var_54c01efdbeed8e49 )
    {
        if ( !symbol utility::ent_flag( "wwq_observed_temple_symbol" ) )
        {
            hud_data[ hud_data.size ] = [ symbol, 30, undefined, undefined, undefined, symbol ];
            radius_marker = [ symbol, undefined, symbol.var_9f1e0f1b4a81472a ];
            hud_data[ hud_data.size ] = radius_marker;
        }
    }
    
    return hud_data;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xa71d5acb, Offset: 0x13b16
// Size: 0x10d
function private function_a0fef6d08103ac25()
{
    hud_data = [];
    
    foreach ( var_7e7ca0a63d1d515e in level.scarab_ww_quest.var_daae8a1d00edada6 )
    {
        if ( !var_7e7ca0a63d1d515e utility::ent_flag( "wwq_observed_riddle_pillar" ) )
        {
            marker_origin = var_7e7ca0a63d1d515e.origin + anglestoforward( var_7e7ca0a63d1d515e.angles ) * -35;
            hud_data[ hud_data.size ] = [ marker_origin, 100, undefined, undefined, undefined, var_7e7ca0a63d1d515e ];
            radius_marker = [ marker_origin, undefined, 225 ];
            hud_data[ hud_data.size ] = radius_marker;
        }
    }
    
    return hud_data;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0xc
// Checksum 0xacfbba13, Offset: 0x13c2c
// Size: 0x1902
function private function_51f12524c830dd09()
{
    self notify( #"hash_a2053981eef92329" );
    self endon( #"hash_a2053981eef92329" );
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    if ( level.scarab_ww_quest.completed )
    {
        return;
    }
    
    level endon( #"game_ended" );
    pap_quest = zm_quest::get_quest( #"scarab_pap_quest" );
    
    if ( !pap_quest.completed )
    {
        pap_quest utility::ent_flag_wait( "zm_quest_completed" );
    }
    
    level utility::flag_wait( "WWQ_ASSET_INIT_COMPLETE" );
    level utility::flag_wait( "ncfds_spawned" );
    level utility::flag_wait( "papq_final_state_set" );
    quest_step = level.scarab_ww_quest.steps[ level.scarab_ww_quest.var_7be076c9078045aa ];
    
    if ( quest_step.ref == #"hash_f3a77b73b34d83f1" )
    {
        if ( !function_c37ba2f04a71f3d9() && !level utility::flag( "step_1_ledge_guidance_shown" ) )
        {
            var_cc7d385215da9379 = !isdefined( level.scarab_ww_quest.var_4bbd2b915d82d648 ) ? #"hash_14a82292745097e8" : #"hash_d317f85aacdfa3be";
            level.scarab_ww_quest.var_4bbd2b915d82d648 = 1;
            
            if ( !function_83be1c87382f0d() )
            {
                guidance_ref = var_cc7d385215da9379;
                hud_data = function_8f95ba5a5923ab89( level.scarab_pap_quest.var_9d15330b141fe52f.origin + ( 0, 900, 100 ) );
                
                if ( function_ebf05edbd73f2f6c() )
                {
                    guidance_ref = #"hash_741539e72c10f856";
                }
                else
                {
                    data = [ level.scarab_ww_quest.var_8df3ff996389aaf.origin + ( 165, -300, 0 ), 55, undefined, undefined, undefined, level.scarab_ww_quest.var_8df3ff996389aaf ];
                    radius_marker = [ level.scarab_ww_quest.var_8df3ff996389aaf.origin + ( 165, -300, 0 ), undefined, 300 ];
                    hud_data[ hud_data.size ] = data;
                    hud_data[ hud_data.size ] = radius_marker;
                }
                
                level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", guidance_ref );
                return;
            }
            
            if ( level.scarab_ww_quest.var_8df3ff996389aaf )
            {
                hud_data = [ [ level.scarab_ww_quest.var_8df3ff996389aaf.origin + ( 165, -300, 0 ), 55, undefined, undefined, undefined, level.scarab_ww_quest.var_8df3ff996389aaf ] ];
                radius_marker = [ level.scarab_ww_quest.var_8df3ff996389aaf.origin + ( 165, -300, 0 ), undefined, 300 ];
                hud_data[ hud_data.size ] = radius_marker;
            }
            
            level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", var_cc7d385215da9379 );
            return;
        }
        
        if ( level.scarab_ww_quest.var_8df3ff996389aaf )
        {
            hud_data = [ [ level.scarab_ww_quest.var_8df3ff996389aaf.origin + ( -75, -78, 25 ), 25, undefined, undefined, undefined, level.scarab_ww_quest.var_8df3ff996389aaf ] ];
        }
        
        level utility::flag_set( "step_1_ledge_guidance_shown" );
        level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"explode_wall" );
        return;
    }
    
    if ( quest_step.ref == #"collect_prism" )
    {
        if ( !level utility::flag( "w_s_2_c_harbor" ) )
        {
            if ( level.scarab_ww_quest.var_d5b8135b0cc12b16 )
            {
                hud_data = [ [ level.scarab_ww_quest.var_d5b8135b0cc12b16.origin + ( -6, -6, 0 ), 15 ] ];
            }
            
            level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"pick_up_prism" );
            return;
        }
        
        return;
    }
    
    if ( quest_step.ref == #"hash_cd6b90bd78df30d5" )
    {
        level function_b74ce1f5c7231e91();
        
        if ( !level.scarab_ww_quest.var_6f55c13e5e9e6f05.base utility::ent_flag( "p_p_ion" ) )
        {
            if ( !function_83be1c87382f0d() )
            {
                hud_data = function_8f95ba5a5923ab89( level.scarab_ww_quest.var_6f55c13e5e9e6f05.base.origin );
                guidance_ref = #"get_grapple_claw";
                
                if ( function_ebf05edbd73f2f6c() )
                {
                    guidance_ref = #"hash_741539e72c10f856";
                }
                
                level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", guidance_ref );
                return;
            }
            
            hud_data = [ [ level.scarab_ww_quest.var_6f55c13e5e9e6f05.base, 30 ] ];
            level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_9043af1ba1ab447f" );
            return;
        }
        else if ( !level utility::flag( "southwest_temple_finalroom_door_bought" ) )
        {
            hud_data = [];
            a_door_trigs = getentarray( "doorbuy_door_8", #targetname );
            
            foreach ( trig in a_door_trigs )
            {
                if ( trig.model )
                {
                    continue;
                }
                
                marker_data = [ trig, -100 ];
                hud_data[ hud_data.size ] = marker_data;
            }
            
            level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_b47d90efa577f65d" );
            return;
        }
        else if ( !level utility::flag( "w_e_b_a_reef" ) )
        {
            if ( level zm_sat_scarab_usurped_power::function_fa42c671f89f2b5() )
            {
                hud_data = [ [ level.scarab_ww_quest.var_52b66e82f17fb84b, 25, undefined, undefined, undefined, level.scarab_ww_quest.var_52b66e82f17fb84b ] ];
                
                if ( !level utility::flag( "wwq_sync_shoot_cosmic_eye_guidance_timer_active" ) )
                {
                    level utility::flag_set( "wwq_sync_shoot_cosmic_eye_guidance_timer_active" );
                    level thread function_d498aa8fc72246cb();
                    level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f6a9fdb2540ecd54" );
                }
                
                return;
            }
            else if ( level zm_sat_scarab_usurped_power::function_c9d7a7dadf1c7b4e() )
            {
                hud_data = [];
                
                foreach ( brazier in level.scarab_pap_quest.var_c6b9e23aac03b4d0 )
                {
                    if ( brazier utility::ent_flag( "is_lit" ) && brazier utility::ent_flag( "has_cosmic_power" ) )
                    {
                        data = [ brazier, 35, undefined, undefined, undefined, brazier ];
                        hud_data[ hud_data.size ] = data;
                    }
                }
                
                if ( hud_data.size <= 0 )
                {
                    hud_data = [ [ level.scarab_pap_quest.var_9d15330b141fe52f, 50, undefined, undefined, undefined, level.scarab_pap_quest.var_9d15330b141fe52f ] ];
                }
                
                level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f2b0db72b39cf15e" );
                return;
            }
            else if ( level utility::flag( "astral_mote_in_forge_area" ) )
            {
                hud_data = [ [ level.scarab_pap_quest.var_9d15330b141fe52f, 50, undefined, undefined, undefined, level.scarab_pap_quest.var_9d15330b141fe52f ] ];
                level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_a72532ff777d2e16" );
                return;
            }
            else if ( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6.size <= 0 )
            {
                level thread zm_quest::update_guidance( undefined, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_4a672453c726a415" );
                return;
            }
            else
            {
                if ( !function_83be1c87382f0d() )
                {
                    if ( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6.size > 0 )
                    {
                        closest_mote = function_47c86977a18df38b( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6, level.scarab_pap_quest.var_9d15330b141fe52f.origin );
                    }
                    
                    if ( !closest_mote )
                    {
                        hud_data = function_8f95ba5a5923ab89( level.scarab_pap_quest.var_9d15330b141fe52f.origin + ( 0, -900, 100 ) );
                    }
                    else
                    {
                        hud_data = function_8f95ba5a5923ab89( closest_mote.origin );
                    }
                    
                    guidance_ref = #"hash_fd0822654892a253";
                    
                    if ( function_ebf05edbd73f2f6c() )
                    {
                        guidance_ref = #"hash_9346f8142c0cfb04";
                    }
                    
                    level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", guidance_ref );
                    return;
                }
                
                hud_data = [];
                hud_data[ hud_data.size ] = [ level.scarab_pap_quest.var_9d15330b141fe52f, 200, undefined, undefined, undefined, level.scarab_pap_quest.var_9d15330b141fe52f ];
                radius_marker = [ level.scarab_pap_quest.var_9d15330b141fe52f.origin, undefined, 350 ];
                hud_data[ hud_data.size ] = radius_marker;
                
                if ( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6.size > 0 )
                {
                    closest_mote = function_47c86977a18df38b( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6, level.scarab_pap_quest.var_9d15330b141fe52f.origin );
                    
                    if ( closest_mote )
                    {
                        data = [ closest_mote.e_mover, 30, undefined, undefined, undefined, closest_mote ];
                        hud_data[ hud_data.size ] = data;
                    }
                }
                
                level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_fd0822654892a253" );
                return;
            }
        }
        else
        {
            if ( !function_83be1c87382f0d() )
            {
                guidance_ref = #"hash_cd6b90bd78df30d5";
                
                if ( function_ebf05edbd73f2f6c() )
                {
                    guidance_ref = #"hash_9346f8142c0cfb04";
                }
                
                hud_data = function_8f95ba5a5923ab89( level.scarab_ww_quest.var_53fe245e95326ece[ 0 ].origin );
                level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", guidance_ref );
                return;
            }
            
            hud_data = function_1c52d71139cb66a6();
            level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_cd6b90bd78df30d5" );
            return;
        }
        
        return;
    }
    
    if ( quest_step.ref == #"hash_8c2aadf3a579e321" )
    {
        if ( !level utility::flag( "doorbuy_door_19_opened" ) )
        {
            if ( level.scarab_ww_quest.var_79fc0cd2f8572e6a )
            {
                hud_data = [ [ level.scarab_ww_quest.var_79fc0cd2f8572e6a, 45, undefined, undefined, undefined, level.scarab_ww_quest.var_79fc0cd2f8572e6a ] ];
                radius_marker = [ level.scarab_ww_quest.var_79fc0cd2f8572e6a.origin, undefined, 200 ];
                hud_data[ hud_data.size ] = radius_marker;
            }
            
            level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"observe_visage" );
            return;
        }
        else
        {
            hud_data = [ [ level.scarab_ww_quest.center_vine, 175, undefined, undefined, undefined, level.scarab_ww_quest.center_vine ] ];
            radius_marker = [ level.scarab_ww_quest.center_vine.origin, undefined, 300 ];
            hud_data[ hud_data.size ] = radius_marker;
            level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_342813bb373007b2" );
            return;
        }
        
        return;
    }
    
    if ( quest_step.ref == #"cleanse_vines" || quest_step.ref == #"hash_8f84615ebd6df36d" || quest_step.ref == #"hash_f97fd6235be10e93" )
    {
        if ( level utility::flag( "w_p_d_a_orchid" ) )
        {
            return;
        }
        
        if ( level.scarab_ww_quest.center_vine )
        {
            hud_data = [ [ level.scarab_ww_quest.center_vine, 175, undefined, undefined, undefined, level.scarab_ww_quest.center_vine ] ];
            radius_marker = [ level.scarab_ww_quest.center_vine.origin, undefined, 385 ];
            hud_data[ hud_data.size ] = radius_marker;
            level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_342813bb373007b2" );
            return;
        }
        
        return;
    }
    
    if ( quest_step.ref == #"hash_35331de6580ad19f" )
    {
        level thread zm_quest::update_guidance( undefined, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_23fa664b7e5916ab" );
        return;
    }
    
    if ( quest_step.ref == #"hash_90cb42c3585aefad" )
    {
        if ( !level utility::flag( "WW_A_P_IN_USE" ) )
        {
            foreach ( player in level.players )
            {
                player zm_quest::function_fb3af5600f6a9441( 0, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f8bc493a69be44cb" );
                player zm_quest::function_fba942a1cfd85f5d( 0, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f8bc493a69be44cb" );
            }
            
            if ( !level.scarab_ww_quest.cosmic_fruit )
            {
                level thread zm_quest::update_guidance( undefined, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_23fa664b7e5916ab" );
                return;
            }
            else
            {
                hud_data = [ [ level.scarab_ww_quest.cosmic_fruit, 25 ] ];
                level thread zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"consume_fruit" );
                return;
            }
        }
        else
        {
            step_ref = undefined;
            
            if ( !level utility::flag( "w_s_10_p_3_c_cinder" ) )
            {
                if ( !level utility::flag( "w_f_b_b_talon" ) )
                {
                    if ( level.scarab_ww_quest.string_item )
                    {
                        hud_data = [ [ level.scarab_ww_quest.string_item, 25, undefined, undefined, undefined, level.scarab_ww_quest.string_item ] ];
                    }
                    
                    step_ref = #"melee_floorboard";
                }
                else
                {
                    if ( level.scarab_ww_quest.string_item )
                    {
                        hud_data = [ [ level.scarab_ww_quest.string_item, 15, undefined, undefined, undefined, level.scarab_ww_quest.string_item ] ];
                    }
                    
                    step_ref = #"pick_up_whip";
                }
            }
            else if ( !level utility::flag( "w_s_10_p_1_c_comet" ) )
            {
                if ( !level utility::flag( "w_a_p_s_s_h_lagoon" ) )
                {
                    if ( level.scarab_ww_quest.soldier_corpse )
                    {
                        hud_data = [ [ level.scarab_ww_quest.soldier_corpse, 75, undefined, undefined, undefined, level.scarab_ww_quest.soldier_corpse ] ];
                    }
                    
                    step_ref = #"observe_soldier";
                }
                else
                {
                    if ( level.scarab_ww_quest.rifle_item )
                    {
                        hud_data = [ [ level.scarab_ww_quest.rifle_item, 20, undefined, undefined, undefined, level.scarab_ww_quest.rifle_item ] ];
                    }
                    
                    step_ref = #"pick_up_rifle";
                }
            }
            else if ( !level utility::flag( "w_s_10_p_2_c_marble" ) )
            {
                if ( !level utility::flag( "w_a_p_b_s_h_meadow" ) )
                {
                    hud_data = [ [ level.scarab_ww_quest.bow_item.origin + ( 5, 20, 40 ), 0, undefined, undefined, undefined, level.scarab_ww_quest.bow_item ] ];
                    step_ref = #"observe_bow";
                }
                else
                {
                    hud_data = [ [ level.scarab_ww_quest.bow_item, 20, undefined, undefined, undefined, level.scarab_ww_quest.bow_item ] ];
                    step_ref = #"pick_up_bow";
                }
            }
            
            if ( step_ref )
            {
                level thread function_a446e2f865dc4ffa( hud_data, step_ref );
                return;
            }
        }
        
        return;
    }
    
    if ( quest_step.ref == #"solve_riddle" )
    {
        if ( !level utility::flag( "w_r_o_bravo" ) )
        {
            if ( level.scarab_ww_quest.riddle_inscription )
            {
                hud_data = [ [ level.scarab_ww_quest.riddle_inscription, 25 ] ];
                radius_marker = [ level.scarab_ww_quest.riddle_inscription, undefined, 200 ];
                hud_data[ hud_data.size ] = radius_marker;
            }
            
            level thread function_f6e32bbfb848f529( hud_data, #"observe_riddle" );
            return;
        }
        else if ( !function_1c09266e1831c289() )
        {
            hud_data = function_a0fef6d08103ac25();
            level thread function_f6e32bbfb848f529( hud_data, #"hash_cf43b8bbcda4de14" );
            return;
        }
        else if ( level zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"riddle_failed" ) == 1 )
        {
            level thread function_f6e32bbfb848f529( undefined, #"riddle_cooldown" );
            return;
        }
        else if ( !function_28b4c383f06f8181() )
        {
            var_edf5c0dd317d0d99 = level function_c3262176052b9bb8();
            var_8b70d8aedcddc58c = var_edf5c0dd317d0d99.sconce_handle.origin + anglestoforward( var_edf5c0dd317d0d99.sconce_handle.angles ) * 15;
            hud_data = [ [ var_8b70d8aedcddc58c, 15 ] ];
            level thread function_f6e32bbfb848f529( hud_data, var_edf5c0dd317d0d99.guidance_ref );
            return;
        }
        else
        {
            if ( level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle )
            {
                var_8b70d8aedcddc58c = level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle.origin + anglestoforward( level.scarab_ww_quest.var_1ea0b28c0ef8cc7f.handle.angles ) * 15;
                hud_data = [ [ var_8b70d8aedcddc58c, 15 ] ];
            }
            
            level thread function_f6e32bbfb848f529( hud_data, #"hash_571f27482dab434c" );
            return;
        }
        
        return;
    }
    
    if ( quest_step.ref == #"craft_ww" )
    {
        if ( !level utility::flag( "w_o_d_a_pioneer" ) )
        {
            if ( !function_83be1c87382f0d() )
            {
                guidance_ref = #"hash_c861ac190f946cdf";
                hud_data = function_8f95ba5a5923ab89( level.scarab_ww_quest.anvil.origin );
                
                if ( function_ebf05edbd73f2f6c() )
                {
                    guidance_ref = #"hash_c37522f1f41fa5b9";
                }
                
                level thread function_f6e32bbfb848f529( hud_data, guidance_ref );
                return;
            }
            
            hud_data = [ [ level.scarab_ww_quest.anvil.origin + ( 100, 100, 100 ), 50 ] ];
            radius_marker = [ level.scarab_ww_quest.anvil.origin + ( 100, 100, 100 ), undefined, 300 ];
            hud_data[ hud_data.size ] = radius_marker;
            level thread function_f6e32bbfb848f529( hud_data, #"hash_c861ac190f946cdf" );
            return;
        }
        else
        {
            hud_data = [ [ level.scarab_ww_quest.anvil, 60 ] ];
            level thread function_f6e32bbfb848f529( hud_data, #"craft_ww" );
            return;
        }
        
        return;
    }
    
    if ( quest_step.ref == #"pick_up_ww" )
    {
        if ( !zm_quest::function_625cc874b6861487( level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"pick_up_ww" ) )
        {
            if ( level.scarab_ww_quest.wonder_weapon_item )
            {
                hud_data = [ [ level.scarab_ww_quest.wonder_weapon_item, 15 ] ];
            }
            
            level thread function_f6e32bbfb848f529( hud_data, #"pick_up_ww" );
        }
        
        return;
    }
    
    return;
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x29a372eb, Offset: 0x15536
// Size: 0x1a6
function private function_a446e2f865dc4ffa( hud_data, step_ref )
{
    level zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", step_ref );
    
    foreach ( player in level.players )
    {
        if ( !player utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) )
        {
            level zm_quest::function_38cacc34ddb8431c( player );
            player zm_quest::function_fba942a1cfd85f5d( 1, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f8bc493a69be44cb" );
            player zm_quest::function_fb3af5600f6a9441( 2, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f8bc493a69be44cb" );
            continue;
        }
        
        level zm_quest::function_1a1a1e0bd84ac45e( player );
        player zm_quest::function_fb3af5600f6a9441( 0, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f8bc493a69be44cb" );
        player zm_quest::function_fba942a1cfd85f5d( 0, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_f8bc493a69be44cb" );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x3e3412f4, Offset: 0x156e4
// Size: 0x48
function private function_f6e32bbfb848f529( hud_data, step_ref )
{
    level zm_quest::update_guidance( hud_data, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", step_ref );
    level function_b20f75e74697d6ea();
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x419dec91, Offset: 0x15734
// Size: 0x88
function private function_b20f75e74697d6ea()
{
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        level function_bc0bd512e7665b79( player );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xaad52757, Offset: 0x157c4
// Size: 0x3b
function private function_bc0bd512e7665b79( player )
{
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    if ( level function_d58969903c25908d( player ) )
    {
        level function_20ad5497bf00acb0( player );
        return;
    }
    
    level function_110ad7630542da97( player );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x35840c65, Offset: 0x15807
// Size: 0xa4, Type: bool
function private function_d58969903c25908d( player )
{
    if ( !isalive( player ) )
    {
        return false;
    }
    
    if ( !player utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) )
    {
        return false;
    }
    
    if ( !level.scarab_ww_quest.var_7ba53ebdc38a4c73 )
    {
        return false;
    }
    
    if ( level.scarab_ww_quest.completed )
    {
        return false;
    }
    
    quest_step = level.scarab_ww_quest.steps[ level.scarab_ww_quest.var_7be076c9078045aa ];
    return quest_step.ref != #"hash_90cb42c3585aefad";
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x91d15929, Offset: 0x158b4
// Size: 0x1b7
function private function_20ad5497bf00acb0( player )
{
    level zm_quest::function_38cacc34ddb8431c( player );
    
    if ( !player.var_eb32cd3ef0f9a8b0 )
    {
        player zm_quest::function_fba942a1cfd85f5d( 1, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_50a71d9f124bc87b" );
        player zm_quest::function_fb3af5600f6a9441( 2, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_50a71d9f124bc87b" );
        player.var_eb32cd3ef0f9a8b0 = 1;
    }
    
    if ( !player.var_44d3167de9585c69 )
    {
        objective_name = "scarab_wwq_astral_exit_" + player getentitynumber();
        player.var_44d3167de9585c69 = zm_quest::function_b98d4144845ffc13( objective_name, 1, "ui_icon_zm_objective", "icon_small_medium", "current", level.scarab_ww_quest.var_7ba53ebdc38a4c73.origin + ( 0, 0, 35 ), undefined, undefined, undefined, 0, 0 );
        
        foreach ( other_player in level.players )
        {
            if ( other_player == player )
            {
                objidpoolmanager::objective_playermask_addshowplayer( player.var_44d3167de9585c69, other_player );
                continue;
            }
            
            objidpoolmanager::objective_playermask_hidefrom( player.var_44d3167de9585c69, other_player );
        }
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xb8d549b8, Offset: 0x15a73
// Size: 0xcd
function private function_110ad7630542da97( player )
{
    if ( !isalive( player ) )
    {
        return;
    }
    
    if ( player.var_eb32cd3ef0f9a8b0 )
    {
        player zm_quest::function_fb3af5600f6a9441( 0, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_50a71d9f124bc87b" );
        player zm_quest::function_fba942a1cfd85f5d( 0, 0, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", #"hash_50a71d9f124bc87b" );
        level zm_quest::function_1a1a1e0bd84ac45e( player );
        player.var_eb32cd3ef0f9a8b0 = 0;
    }
    
    if ( player.var_44d3167de9585c69 )
    {
        zm_quest::complete_objective_waypoints( player.var_44d3167de9585c69 );
        player.var_44d3167de9585c69 = undefined;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xcff35011, Offset: 0x15b48
// Size: 0x84, Type: bool
function private function_83be1c87382f0d()
{
    foreach ( player in level.players )
    {
        if ( player.var_819dfee5ff9a56d6 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x26fe2636, Offset: 0x15bd5
// Size: 0x70, Type: bool
function private function_ebf05edbd73f2f6c()
{
    if ( level.players.size != 1 )
    {
        return false;
    }
    
    player = level.players[ 0 ];
    
    if ( !player.n_charge_times || !level.var_b6a4b93f9f863428 )
    {
        return false;
    }
    
    return player.n_charge_times >= level.var_b6a4b93f9f863428 && !level utility::flag( "ncfd_infinite_grapple_enabled" );
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x7d483c87, Offset: 0x15c4e
// Size: 0xdb
function private function_c37ba2f04a71f3d9()
{
    if ( !level.scarab_ww_quest.var_8df3ff996389aaf )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.origin[ 2 ] > 1990 && distancesquared( player.origin, level.scarab_ww_quest.var_8df3ff996389aaf.origin ) <= squared( 850 ) )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x2aa776ab, Offset: 0x15d32
// Size: 0x74
function private function_8f95ba5a5923ab89( origin )
{
    if ( !isdefined( level.ncfd_pedestals ) || !level.ncfd_pedestals.size )
    {
        return;
    }
    
    pedestal = function_47c86977a18df38b( level.ncfd_pedestals, origin );
    
    if ( !isdefined( pedestal ) )
    {
        return;
    }
    
    return [ [ pedestal, 65, undefined, undefined, undefined, pedestal ] ];
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x918789a6, Offset: 0x15daf
// Size: 0x74
function private function_1c52d71139cb66a6()
{
    hud_data = [];
    target_prism = level function_7856aa011394dbd8();
    
    if ( !target_prism )
    {
        return hud_data;
    }
    
    icon_offset = 40;
    
    if ( target_prism.n_index >= level.scarab_ww_quest.var_53fe245e95326ece.size - 1 )
    {
        icon_offset = 15;
    }
    
    hud_data[ hud_data.size ] = [ target_prism, icon_offset ];
    return hud_data;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xb5285046, Offset: 0x15e2c
// Size: 0x7e, Type: bool
function private function_81c161b5e09ff273( var_aae9ba29786e9ca7 )
{
    if ( !var_aae9ba29786e9ca7.n_index )
    {
        return false;
    }
    
    if ( var_aae9ba29786e9ca7.n_index < 0 || var_aae9ba29786e9ca7.n_index >= level.scarab_ww_quest.var_493139418f5e8ea3.size )
    {
        return false;
    }
    
    return var_aae9ba29786e9ca7.var_15f69f103ace73b8 == level.scarab_ww_quest.var_493139418f5e8ea3[ var_aae9ba29786e9ca7.n_index ];
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x572bef50, Offset: 0x15eb3
// Size: 0x11b
function private function_7856aa011394dbd8()
{
    foreach ( var_aae9ba29786e9ca7 in level.scarab_ww_quest.var_53fe245e95326ece )
    {
        if ( !var_aae9ba29786e9ca7 utility::ent_flag( "w_l_b_o_p_cascade" ) )
        {
            previous_prism = level.scarab_ww_quest.var_53fe245e95326ece[ var_aae9ba29786e9ca7.n_index - 1 ];
            
            if ( !previous_prism || level function_81c161b5e09ff273( previous_prism ) )
            {
                return;
            }
            
            return previous_prism;
        }
    }
    
    last_prism = level.scarab_ww_quest.var_53fe245e95326ece[ level.scarab_ww_quest.var_53fe245e95326ece.size - 1 ];
    
    if ( !last_prism || level function_81c161b5e09ff273( last_prism ) )
    {
        return;
    }
    
    return last_prism;
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x7812162f, Offset: 0x15fd7
// Size: 0x8c, Type: bool
function private function_891ce73ab5b1601a( var_aae9ba29786e9ca7 )
{
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return true;
    }
    
    if ( !level.scarab_ww_quest.var_6f55c13e5e9e6f05 || !level.scarab_ww_quest.var_6f55c13e5e9e6f05.base utility::ent_flag( "p_p_ion" ) )
    {
        return false;
    }
    
    if ( level function_81c161b5e09ff273( var_aae9ba29786e9ca7 ) )
    {
        return false;
    }
    
    target_prism = level function_7856aa011394dbd8();
    return isdefined( target_prism ) && target_prism == var_aae9ba29786e9ca7;
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xebca5599, Offset: 0x1606c
// Size: 0xcb
function private function_b74ce1f5c7231e91()
{
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    foreach ( var_aae9ba29786e9ca7 in level.scarab_ww_quest.var_53fe245e95326ece )
    {
        if ( level function_891ce73ab5b1601a( var_aae9ba29786e9ca7 ) )
        {
            var_aae9ba29786e9ca7.var_68e1ed47045d49b4 setscriptablepartstate( "grapple", "on" );
            continue;
        }
        
        var_aae9ba29786e9ca7.var_68e1ed47045d49b4 setscriptablepartstate( "grapple", "off" );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x5fbdeae8, Offset: 0x1613f
// Size: 0x33e
function private function_b066116afb073734()
{
    var_82eb04176f761348 = [ #"hash_14a82292745097e8", #"hash_d317f85aacdfa3be", #"hash_ed19d0ee322625a4", #"explode_wall", #"pick_up_prism", #"get_grapple_claw", #"hash_9043af1ba1ab447f", #"hash_b47d90efa577f65d", #"hash_88e1696f329a5587", #"hash_cd6b90bd78df30d5", #"observe_visage", #"hash_342813bb373007b2", #"hash_fd0822654892a253", #"hash_4a672453c726a415", #"hash_a72532ff777d2e16", #"hash_f2b0db72b39cf15e", #"hash_f6a9fdb2540ecd54", #"hash_23fa664b7e5916ab", #"consume_fruit", #"melee_floorboard", #"pick_up_whip", #"observe_soldier", #"observe_bow", #"pick_up_rifle", #"pick_up_bow", #"observe_riddle", #"hash_26f232caee2d1e8b", #"hash_cf43b8bbcda4de14", #"hash_bc9ea5a8446143f0", #"hash_bc9ea8a844614909", #"hash_bc9ea7a844614756", #"hash_2140bd1b357364c1", #"hash_2140ba1b35735fa8", #"hash_2140bb1b3573615b", #"hash_a7a4c908b2f22490", #"hash_a7a4cc08b2f229a9", #"hash_a7a4cb08b2f227f6", #"hash_571f27482dab434c", #"riddle_cooldown", #"hash_50a71d9f124bc87b", #"hash_c37522f1f41fa5b9", #"hash_f8bc493a69be44cb", #"hash_c861ac190f946cdf", #"craft_ww", #"pick_up_ww", #"hash_741539e72c10f856", #"hash_9346f8142c0cfb04", #"wwq_complete" ];
    
    foreach ( step in var_82eb04176f761348 )
    {
        level zm_quest::function_fb3af5600f6a9441( 0, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", step );
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, level zm_quest::function_b0a5181ebe7bb905() ? #"hash_e01621c22e6f07ca" : #"scarab_ww_quest", step );
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xc7b452a5, Offset: 0x16485
// Size: 0x13
function private function_e3883d62f9f901fa( params )
{
    function_ecf3aaf13fa4221();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x43f35fb6, Offset: 0x164a0
// Size: 0x13
function private function_cbdaf3c08c739ebb( params )
{
    function_900fb8603ba46be8();
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x4e76e142, Offset: 0x164bb
// Size: 0x8e
function private function_c201b94930a53581( params )
{
    a_solution = level.scarab_ww_quest.var_a2be214d8c2fa691;
    str_solution = "RIDDLE SOLUTION: Galaxy -> " + level function_1ae065b26e8d5607( a_solution[ 0 ] );
    str_solution += ", Moon -> " + level function_1ae065b26e8d5607( a_solution[ 1 ] );
    str_solution += ", Star -> " + level function_1ae065b26e8d5607( a_solution[ 3 ] );
    str_solution += ", Comet -> " + level function_1ae065b26e8d5607( a_solution[ 2 ] );
    iprintlnbold( str_solution );
}

// Namespace zm_sat_scarab_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x7f8df4d9, Offset: 0x16551
// Size: 0x6d
function private function_1ae065b26e8d5607( str_direction )
{
    switch ( str_direction )
    {
        case #"hash_b9ff0a9f617355e4":
            return "North";
        case #"hash_fbd39e4f5634905a":
            return "South";
        case #"hash_22ce3b03c1e51a9c":
            return "East";
        case #"hash_a1e9b77432f55b0e":
            return "West";
        default:
            return str_direction;
    }
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x6f3fe384, Offset: 0x165c6
// Size: 0xa6
function private function_ecf3aaf13fa4221()
{
    player = level.players[ 0 ];
    
    if ( !player )
    {
        return;
    }
    
    s_spawn_parent = utility::getstruct( "lc_a_p_spawn_parent", "targetname" );
    [ dest ] = utility::getstructarray( s_spawn_parent.target, "targetname" );
    player setorigin( dest.origin );
    
    if ( dest.angles )
    {
        player setplayerangles( dest.angles );
    }
    
    /#
        iprintlnbold( "<dev string:x1b1>" );
    #/
}

// Namespace zm_sat_scarab_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x5d85dcf5, Offset: 0x16674
// Size: 0x7f
function private function_900fb8603ba46be8()
{
    player = level.players[ 0 ];
    
    if ( !player )
    {
        return;
    }
    
    if ( !level.scarab_ww_quest.cosmic_fruit )
    {
        /#
            function_cdb86f0d1ce0e3a9();
        #/
    }
    
    if ( !level.scarab_ww_quest.cosmic_fruit )
    {
        /#
            iprintlnbold( "<dev string:x1c8>" );
        #/
        
        return;
    }
    
    level function_5763786d82e3c364( player, 1 );
    
    /#
        iprintlnbold( "<dev string:x1e5>" );
    #/
}

/#

    // Namespace zm_sat_scarab_ww_quest
    // Params 0, eflags: 0x4
    // Checksum 0x65bc651f, Offset: 0x166fb
    // Size: 0xc8, Type: dev
    function private init_ww_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x201>" );
        devgui::add_devgui_func( "<dev string:x21b>", "<dev string:x235>", &function_d888497493329c11 );
        devgui::add_devgui_func( "<dev string:x249>", "<dev string:x268>", &function_cdb86f0d1ce0e3a9 );
        devgui::add_devgui_func( "<dev string:x281>", "<dev string:x296>", &function_8d4879bb6584df23 );
        devgui::add_devgui_func( "<dev string:x2a5>", "<dev string:x2c0>", &function_cc84d3374ef86dcf );
        devgui::add_devgui_func( "<dev string:x2d5>", "<dev string:x2f6>", &function_8ec5b556e8d7dd7e );
        devgui::add_devgui_func( "<dev string:x311>", "<dev string:x334>", &function_e4d64fe2d05c77c5 );
        devgui::add_devgui_func( "<dev string:x357>", "<dev string:x36b>", &function_5a890d3e0adbdbf1 );
        devgui::add_devgui_func( "<dev string:x379>", "<dev string:x398>", &function_6483b632d134d216 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_scarab_ww_quest
    // Params 3, eflags: 0x4
    // Checksum 0xafcaa740, Offset: 0x167cb
    // Size: 0x4e, Type: dev
    function private debug_print_text( origin, text, self_endon_notify )
    {
        level endon( #"game_ended" );
        
        if ( self_endon_notify )
        {
            self endon( self_endon_notify );
        }
        
        while ( true )
        {
            print3d( origin, text, undefined, undefined, undefined, undefined, 1 );
            waitframe();
        }
    }

    // Namespace zm_sat_scarab_ww_quest
    // Params 0, eflags: 0x4
    // Checksum 0x365ad607, Offset: 0x16821
    // Size: 0x22, Type: dev
    function private function_d888497493329c11()
    {
        level utility::flag_set( "<dev string:x3b1>" );
        level function_119b591f0edba006();
        level thread function_5cc6c228350c4da9();
    }

    // Namespace zm_sat_scarab_ww_quest
    // Params 0, eflags: 0x4
    // Checksum 0xd2bc1eed, Offset: 0x1684b
    // Size: 0xdc, Type: dev
    function private function_cdb86f0d1ce0e3a9()
    {
        fruit_step = zm_quest::get_quest_step( #"scarab_ww_quest", #"hash_f97fd6235be10e93" );
        
        if ( !fruit_step.completed )
        {
            foreach ( step in level.scarab_ww_quest.steps )
            {
                if ( step.ref == #"hash_90cb42c3585aefad" )
                {
                    break;
                }
                
                zm_quest::function_e65609834444650c( step );
            }
        }
        
        level spawn_cosmic_fruit();
    }

    // Namespace zm_sat_scarab_ww_quest
    // Params 0, eflags: 0x4
    // Checksum 0xf613a7e0, Offset: 0x1692f
    // Size: 0xe, Type: dev
    function private function_8d4879bb6584df23()
    {
        level function_fab1326dee9905e( undefined );
    }

    // Namespace zm_sat_scarab_ww_quest
    // Params 0, eflags: 0x4
    // Checksum 0x94fcd5b8, Offset: 0x16945
    // Size: 0xc, Type: dev
    function private function_cc84d3374ef86dcf()
    {
        function_ecf3aaf13fa4221();
    }

    // Namespace zm_sat_scarab_ww_quest
    // Params 0, eflags: 0x4
    // Checksum 0x3c098097, Offset: 0x16959
    // Size: 0xc, Type: dev
    function private function_8ec5b556e8d7dd7e()
    {
        function_900fb8603ba46be8();
    }

    // Namespace zm_sat_scarab_ww_quest
    // Params 0, eflags: 0x4
    // Checksum 0xc21d6fae, Offset: 0x1696d
    // Size: 0x1ad, Type: dev
    function private function_e4d64fe2d05c77c5()
    {
        player = level.players[ 0 ];
        var_3530c91bc79c1c9e = anglestoforward( player getplayerangles() );
        result = trace::ray_trace( player geteye(), player geteye() + var_3530c91bc79c1c9e * 10000, undefined, undefined, undefined, undefined, 1 );
        
        if ( isdefined( result[ "<dev string:x3be>" ] ) )
        {
            spawner = { #origin:result[ "<dev string:x3be>" ] };
            
            if ( !isdefined( level.scarab_ww_quest.var_858df476a878f27e ) )
            {
                level.scarab_ww_quest.var_858df476a878f27e = [];
            }
            
            zombie = function_54d1adbb85f0d5ca( "<dev string:x3c7>", spawner, zm_utility::get_round_number() + 3, level.scarab_ww_quest.var_858df476a878f27e );
            
            if ( zombie )
            {
                zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "<dev string:x3f1>" == "<dev string:x3f8>" || "<dev string:x3f1>" == "<dev string:x3f1>" ) ? "<dev string:x405>" : level.gametypebundle.var_25934546ad2751f3 && "<dev string:x3f1>" == "<dev string:x3f8>" ? "<dev string:x3f1>" : level.gametypebundle.var_ed84de94958fe6c0 && "<dev string:x3f1>" == "<dev string:x3f1>" ? "<dev string:x405>" : "<dev string:x3f1>", "<dev string:x409>", 6 );
                zombie function_c0b1d35bc1be7a69();
            }
        }
    }

    // Namespace zm_sat_scarab_ww_quest
    // Params 0, eflags: 0x4
    // Checksum 0x26e61bd3, Offset: 0x16b22
    // Size: 0x75, Type: dev
    function private function_5a890d3e0adbdbf1()
    {
        if ( level.scarab_ww_quest.anvil )
        {
            pos = level.scarab_ww_quest.anvil.origin + ( 100, 100, 100 );
            command = "<dev string:x413>" + pos;
            adddebugcommand( command );
            iprintlnbold( "<dev string:x41f>" );
        }
    }

    // Namespace zm_sat_scarab_ww_quest
    // Params 0, eflags: 0x4
    // Checksum 0xfb18c46, Offset: 0x16b9f
    // Size: 0xc9, Type: dev
    function private function_6483b632d134d216()
    {
        if ( !isdefined( level.scarab_ww_quest.var_ab92bfe9265466e8 ) )
        {
            level.scarab_ww_quest.var_ab92bfe9265466e8 = 1;
        }
        
        level.scarab_ww_quest.var_ab92bfe9265466e8 = !level.scarab_ww_quest.var_ab92bfe9265466e8;
        
        if ( level.scarab_ww_quest.var_ab92bfe9265466e8 )
        {
            level.players[ 0 ] val::set( #"scarab_ww_quest", "<dev string:x42f>", 1 );
            iprintlnbold( "<dev string:x44b>" );
            return;
        }
        
        level.players[ 0 ] val::set( #"scarab_ww_quest", "<dev string:x42f>", 0 );
        iprintlnbold( "<dev string:x46f>" );
    }

#/
