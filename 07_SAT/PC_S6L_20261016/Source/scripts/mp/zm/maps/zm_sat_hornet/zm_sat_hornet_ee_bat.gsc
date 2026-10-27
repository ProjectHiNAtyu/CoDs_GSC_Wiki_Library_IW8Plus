// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_bat.gsc  (hash_5d86bb4b776e468a.gscc) (size: 26632 Bytes / 0x6808 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f4eaded (1062120941)
// size ...... 26632 (0x6808)
// includes .. 31  (offset: 0x6070)
// strings ... 98  (offset: 0x6168)
// dev strs .. 6   (offset: 0x67c0)
// exports ... 61  (offset: 0x3e8c)
// cseg ...... 0x79a + 0x36f2 (0x3e8c)
// imports ... 195 (offset: 0x4814)
// animtree1 . 0   (offset: 0x6808)
// animtree2 . 0   (offset: 0x6808)
#using script_16ea1b94f0f381b3;
#using script_5a0c375c28690264;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\mutant_injection_utility;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\overlord;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_bat_cs;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_rocker;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_ee_bat;

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x5
// Checksum 0xfba239af, Offset: 0x7b8
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_ee_bat", undefined, &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x960911dd, Offset: 0x7dd
// Size: 0x2
function private function_7cf8dacb278a2665()
{
    
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x1cd406ab, Offset: 0x7e7
// Size: 0x15a
function private postmain_init()
{
    if ( !getdvarint( @"enable_hornet_sq", 0 ) || !getdvarint( @"hash_9c0b073f3d8f9609", 1 ) )
    {
        return;
    }
    
    zm_sat_hornet_ee_bat_cs::main();
    level utility::flag_wait( "zm_quest_initialized" );
    level.ee_battle = zm_quest::get_quest( #"hornet_ee_bat" );
    zm_quest::function_3c363613c60958f5( "bat_ee_active" );
    level.ee_battle.var_8e47f8b777e4229e = 0;
    level callback::add( "on_round_start", &on_round_start );
    zm_quest::register_quest_step( #"hornet_ee_bat", #"collect_parts_bat", &setup_collection_step, &cleanup_collection_step );
    zm_quest::register_quest_step( #"hornet_ee_bat", #"fight_kla", &setup_klaus_step, &cleanup_klaus_step );
    zm_quest::register_quest_step( #"hornet_ee_bat", #"fight_kai", &setup_fight_step, &cleanup_fight_step );
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hornet_ee_bat" );
    level callback::add( #"killstreak_activated", &function_de1ecc357c566838 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_robot", &function_875147c303e760ce );
    level.var_2794781b61e20ff4 = getnoentvolumearray( "disallow_rr_area", #targetname );
    
    /#
        register_bat_devgui();
    #/
}

// Namespace zm_sat_hornet_ee_bat
// Params 2, eflags: 0x4
// Checksum 0x8cd90d97, Offset: 0x949
// Size: 0x67
function private setup_collection_step( b_skipped, b_save_restored )
{
    if ( !b_save_restored )
    {
        n_saved = level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_bat", #"hash_b480266f5821cdd1" ) ?? 0;
        level.ee_battle.var_8e47f8b777e4229e = n_saved;
        level utility::flag_wait( "all_mkbp_coll" );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 2, eflags: 0x4
// Checksum 0x9f0bfdba, Offset: 0x9b8
// Size: 0x38
function private cleanup_collection_step( b_skipped, b_save_restored )
{
    level.ee_battle.var_a5528119e634132d = 1;
    level utility::flag_set( "all_mkbp_coll" );
}

// Namespace zm_sat_hornet_ee_bat
// Params 2, eflags: 0x4
// Checksum 0x3c147e9c, Offset: 0x9f8
// Size: 0x68
function private setup_klaus_step( b_skipped, b_save_restored )
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        level utility::flag_wait( "rkr_pth_setup_complete" );
    }
    
    prop = zm_sat_hornet_ee_rocker::function_e5b4858e27850ba9( "rkr_tors", %"c_t10_zmb_viper_mini_old_head_prop" );
    level thread setup_klaus_interact( prop );
    
    if ( !b_save_restored )
    {
        level utility::flag_wait( "all_kla_def" );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 2, eflags: 0x4
// Checksum 0x31e1fb91, Offset: 0xa68
// Size: 0xc3
function private cleanup_klaus_step( b_skipped, b_save_restored )
{
    s_death = level.ee_battle.var_f4ad706946d12dd;
    
    if ( !s_death )
    {
        [ s_death ] = utility::getstructarray( "kb_dpos_tr", "targetname" );
    }
    
    level thread function_531a13e6343689b4( s_death );
    level thread function_68d941b41da1c089( s_death );
    level utility::flag_set( "all_kla_def" );
    
    if ( b_save_restored )
    {
        var_a22b71f86276c8f1 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_bat", #"hash_1affb54f0a375c65" ) ?? 0;
        
        if ( var_a22b71f86276c8f1 > 0 )
        {
            level.ee_battle.var_2b53e32ba0c4f3bd = var_a22b71f86276c8f1;
        }
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 2, eflags: 0x4
// Checksum 0x3909d2d1, Offset: 0xb33
// Size: 0x28
function private setup_fight_step( b_skipped, b_save_restored )
{
    if ( !b_save_restored )
    {
        level utility::flag_wait( "all_mkbp_def" );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 2, eflags: 0x4
// Checksum 0x3ca30301, Offset: 0xb63
// Size: 0x41
function private cleanup_fight_step( b_skipped, b_save_restored )
{
    level utility::flag_set( "all_mkbp_def" );
    level.ee_battle.interact interaction::set_interact_hint_callback( &function_c03ea5dd0f8f1c91 );
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x2906205a, Offset: 0xbac
// Size: 0x6f
function private setup_klaus_interact( prop )
{
    prop endon( #"deleted" );
    prop waittill( #"stop_curve" );
    interact = interaction::register_interact( prop.origin + ( 0, 0, 30 ), 48, &function_6a1e28491c27952a, undefined, undefined, undefined, 1, undefined, 1 );
    interact.prop = prop;
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x6664489e, Offset: 0xc23
// Size: 0xd6
function private on_round_start( sparams )
{
    if ( level.ee_battle.var_54b098e7a42b3481 )
    {
        cleanup_pending_pickup();
    }
    
    if ( level.ee_battle.var_a5528119e634132d )
    {
        if ( level.ee_rocker.var_a01e8692e9c5d076 )
        {
            level.ee_rocker.var_a01e8692e9c5d076 = undefined;
        }
        
        return;
    }
    
    n_round = zm_utility::get_round_number();
    
    if ( n_round >= 2 && ( n_round - 2 ) % 2 == 0 )
    {
        level.ee_rocker.var_a01e8692e9c5d076 = &function_936d599392b5385f;
        return;
    }
    
    if ( level.ee_rocker.var_a01e8692e9c5d076 )
    {
        level.ee_rocker.var_a01e8692e9c5d076 = undefined;
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 2, eflags: 0x4
// Checksum 0x69df8c69, Offset: 0xd01
// Size: 0x1b5
function private function_936d599392b5385f( rock, player )
{
    if ( level.ee_battle.var_54b098e7a42b3481 || level.ee_battle.var_a5528119e634132d )
    {
        return;
    }
    
    var_2a345ab3ef50328c = [ %"c_t10_zmb_viper_mini_pickup_arm_le", %"c_t10_zmb_viper_mini_pickup_arm_ri", %"c_t10_zmb_viper_mini_prop_leg_le", %"c_t10_zmb_viper_mini_prop_leg_ri" ];
    model_asset = var_2a345ab3ef50328c[ level.ee_battle.var_8e47f8b777e4229e ];
    v_destination = namespace_923cf551235ca152::function_697b336296162337( rock.origin, player.origin );
    v_destination = getgroundposition( v_destination, 1, 75 );
    mdl = utility::spawn_model( model_asset, v_destination, ( 90, 0, 0 ) );
    mdl.interact = interaction::register_interact( mdl.origin + ( 0, 0, 30 ), 48, &function_98a86b1d3c3a954e, undefined, undefined, undefined, 1, undefined, 1 );
    mdl.interact interaction::set_interact_hint_callback( &part_pickup_hint );
    mdl.interact linkto( mdl );
    mdl.outline_id = outline::outlineenableforall( mdl, "outline_depth_orange", "equipment" );
    level.ee_battle.var_54b098e7a42b3481 = 1;
    level.ee_battle.var_da5079f846860132 = mdl;
    level.ee_rocker.var_a01e8692e9c5d076 = undefined;
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x440c3471, Offset: 0xebe
// Size: 0x145
function private function_98a86b1d3c3a954e( player )
{
    mdl = self getlinkedparent();
    self delete();
    player playsoundtoplayer( "uin_zm_common_pickup_item_mechanical", player );
    
    if ( mdl )
    {
        if ( isdefined( mdl.outline_id ) )
        {
            outline::outlinedisable( mdl.outline_id, mdl );
        }
        
        mdl delete();
    }
    
    level.ee_battle.var_8e47f8b777e4229e++;
    level.ee_battle.var_54b098e7a42b3481 = 0;
    level.ee_battle.var_da5079f846860132 = undefined;
    var_2a345ab3ef50328c = [ %"c_t10_zmb_viper_mini_pickup_arm_le", %"c_t10_zmb_viper_mini_pickup_arm_ri", %"c_t10_zmb_viper_mini_prop_leg_le", %"c_t10_zmb_viper_mini_prop_leg_ri" ];
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_bat", #"hash_b480266f5821cdd1", level.ee_battle.var_8e47f8b777e4229e );
    
    if ( level.ee_battle.var_8e47f8b777e4229e >= var_2a345ab3ef50328c.size )
    {
        level.ee_battle.var_a5528119e634132d = 1;
        level utility::flag_set( "all_mkbp_coll" );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 2, eflags: 0x4
// Checksum 0x1d6db626, Offset: 0x100b
// Size: 0x7a
function private part_pickup_hint( usable, player )
{
    if ( player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x830ded8c, Offset: 0x108e
// Size: 0x10b
function private function_6a1e28491c27952a( player )
{
    v_spawn_origin = self.origin;
    playsoundatpos( v_spawn_origin, "uin_zm_common_pickup_item_mechanical" );
    zombie = agent_manager::spawn_agent( "zombie_viper_mini", v_spawn_origin, ( 0, 0, 0 ), "team_two_hundred" );
    
    if ( !zombie )
    {
        return;
    }
    
    zombie.var_a13bed1ac47e1b2c = 1;
    zombie.no_powerups = 1;
    zombie.var_7ee152b43c7188e1 = 1;
    zombie.var_825b17c932865df = 1;
    zombie.ignore_enemy_count = 1;
    zombie zombie_utils::set_zombie_round_difficulty( 17, 1, 1 );
    zombie val::set( "bat_viper", "ammomod_immune", 1 );
    zombie val::set( "bat_viper", "ignore_cleanup", 1 );
    zombie thread function_3698bad1f66976b6();
    zombie thread function_9fbe92b91ff79da9();
    zombie thread function_1febd960631817b5();
    self.prop delete();
    self delete();
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x915e3d4, Offset: 0x11a1
// Size: 0x27
function private function_9fbe92b91ff79da9()
{
    self endon( #"death" );
    self waittill( #"self_destruct_approach" );
    self notify( #"cancel_self_destruct" );
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0xdced049b, Offset: 0x11d0
// Size: 0x3d
function private function_1febd960631817b5()
{
    self waittill( #"death" );
    
    while ( isalive( self ) )
    {
        wait 5;
    }
    
    wait 2;
    
    if ( !level utility::flag( "all_kla_def" ) )
    {
        level utility::flag_set( "all_kla_def" );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x3370567e, Offset: 0x1215
// Size: 0xb0
function private function_3698bad1f66976b6()
{
    self endon( #"death" );
    zombie_utils::function_dfae6a5bd222c586( &function_adecd5bfef368091 );
    callback::add( "killed_body_cloned", &function_997c99dc612c9f15 );
    self waittill( #"hash_25d4434efb51ed1c" );
    var_60be343f8e4f0a99 = utility::getstructarray( "kb_dpos_tr", "targetname" );
    [ s_death ] = sortbydistance( var_60be343f8e4f0a99, self.origin );
    zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_death );
    function_8939721024cb8259( self, s_death, 60 );
    level.ee_battle.var_f4ad706946d12dd = s_death;
    level thread function_7cb71acdd83e250( self, s_death );
}

// Namespace zm_sat_hornet_ee_bat
// Params 3, eflags: 0x4
// Checksum 0x3c6f77d9, Offset: 0x12cd
// Size: 0x8b
function private function_8939721024cb8259( klaus, s_dest, dist_nearby )
{
    klaus endon( #"death" );
    var_26ab86035332ab92 = distancesquared( s_dest.origin, klaus.origin );
    var_7d8faea645677843 = dist_nearby * dist_nearby;
    
    while ( var_26ab86035332ab92 > var_7d8faea645677843 )
    {
        wait 0.25;
        var_26ab86035332ab92 = distancesquared( s_dest.origin, klaus.origin );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 2, eflags: 0x4
// Checksum 0x8bedc1ca, Offset: 0x1360
// Size: 0x44
function private function_7cb71acdd83e250( zombie, s_death )
{
    level endon( #"game_ended" );
    
    if ( isalive( zombie ) )
    {
        zombie kill();
    }
    
    wait 0.5;
    level utility::flag_set( "all_kla_def" );
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0xb2e39afe, Offset: 0x13ac
// Size: 0x96
function private function_adecd5bfef368091( params )
{
    if ( self.in_death_sequence )
    {
        return 0;
    }
    else if ( params.idamage >= self.health )
    {
        damage = 0;
        self.in_death_sequence = 1;
        val::set( "viper_death", "damage", 0 );
        val::set( "viper_death", "show_healthbar", 0 );
        self.ignoreall = 1;
        self notify( #"hash_25d4434efb51ed1c" );
        return damage;
    }
    
    return params.idamage;
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x971bb9c4, Offset: 0x144b
// Size: 0xee
function private function_997c99dc612c9f15( sparams )
{
    level endon( #"game_ended" );
    body = zombie_utils::function_4e99fb1239980783( sparams );
    
    if ( isdefined( body ) )
    {
        body endon( #"corpse_deleted" );
    }
    
    wait 1;
    
    if ( isdefined( body ) )
    {
        foreach ( player in level.players )
        {
            if ( distancesquared( player.origin, body.origin ) <= 250000 )
            {
                player shellshock( "flashbang_mp", 2 );
            }
        }
        
        body delete();
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0xa8cce517, Offset: 0x1541
// Size: 0x87
function private function_531a13e6343689b4( var_16af6624858ffa21 )
{
    level.ee_battle.torso_mdl = utility::spawn_model( %"c_t10_zmb_viper_mini_old_head_prop", var_16af6624858ffa21.origin, var_16af6624858ffa21.angles );
    level.ee_battle.interact = interaction::register_interact( var_16af6624858ffa21.origin + ( 0, 0, 30 ), 48, &function_93970d0257bb9f47, undefined, undefined, undefined, 1, undefined, 1 );
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x844a222e, Offset: 0x15d0
// Size: 0xe7
function private function_68d941b41da1c089( s_death )
{
    level.ee_battle.var_d205d69e26d65b8f = [];
    
    for ( s_cur = s_death; s_cur.target ; s_cur = var_7b97f011bb3a6659 )
    {
        var_7b97f011bb3a6659 = utility::getstruct( s_cur.target, "targetname" );
        
        if ( !var_7b97f011bb3a6659 )
        {
            break;
        }
        
        mdl = function_a6adb7109f50efe3( var_7b97f011bb3a6659 );
        
        if ( mdl )
        {
            e_limb = utility::spawn_model( mdl, var_7b97f011bb3a6659.origin, var_7b97f011bb3a6659.angles ?? ( 0, 0, 0 ) );
            level.ee_battle.var_d205d69e26d65b8f[ level.ee_battle.var_d205d69e26d65b8f.size ] = e_limb;
        }
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x460a78d5, Offset: 0x16bf
// Size: 0x84
function private function_a6adb7109f50efe3( s_limb )
{
    if ( s_limb.script_noteworthy == "vmini_ra" )
    {
        return %"c_t10_zmb_viper_mini_pickup_arm_ri";
    }
    
    if ( s_limb.script_noteworthy == "vmini_la" )
    {
        return %"c_t10_zmb_viper_mini_pickup_arm_le";
    }
    
    if ( s_limb.script_noteworthy == "vmini_rl" )
    {
        return %"c_t10_zmb_viper_mini_prop_leg_ri";
    }
    
    if ( s_limb.script_noteworthy == "vmini_ll" )
    {
        return %"c_t10_zmb_viper_mini_prop_leg_le";
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 2, eflags: 0x4
// Checksum 0xdb0b0ac7, Offset: 0x174c
// Size: 0x1a4
function private function_c03ea5dd0f8f1c91( usable, player )
{
    if ( player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( !level utility::flag( "all_mkbp_def" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    existing_streak = player killstreaks::getequippedkillstreakbyname( "remote_robot" );
    
    if ( isdefined( existing_streak ) && existing_streak.available > 0 )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    obj = { #icon:"sat_ui_icon_scorestreak_juggerbot", #icon_text_value:1750, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_SALVAGE", #description:&"hash_2af0df0c25d109c7", #title:&"hash_549e2b9d8e1fd390", #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #type:"HINT_BUTTON" };
    
    if ( player currency::can_afford( #"salvage", 1750 ) )
    {
        return obj;
    }
    
    obj.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_SALVAGE_NOT_ENOUGH";
    obj.interactable = 0;
    return obj;
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x92df6481, Offset: 0x18f8
// Size: 0xa6, Type: bool
function private function_a2c049da0a906c02()
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) || level utility::flag( "hornet_mq_blocking_horse_ee" ) || level utility::flag( "exfil_active" ) || level.ww_neko.has_cage || function_52d564524977be61() || level.ee_neigh.var_eb302e9eae9188ff || function_594447b3dac28e21( "bossfight_fasttravel_active" ) || level utility::flag( "hornet_mq_mem_playing" ) || level utility::flag( "zm_vote_think" ) || level.sq_player )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0xaed32ee2, Offset: 0x19a7
// Size: 0x8c, Type: bool
function private function_594447b3dac28e21( flag )
{
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag_set( flag ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x600255f0, Offset: 0x1a3c
// Size: 0x84, Type: bool
function private function_52d564524977be61()
{
    foreach ( player in level.players )
    {
        if ( player.has_cat )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x28588d4d, Offset: 0x1ac9
// Size: 0x1b1
function private function_93970d0257bb9f47( player )
{
    if ( function_a2c049da0a906c02() )
    {
        return;
    }
    
    if ( !level utility::flag( "all_mkbp_def" ) )
    {
        if ( level.ee_battle.var_9c444f4cb49b2a94 )
        {
            return;
        }
        
        var_49f7091014d2c59 = zm_utility::get_round_number();
        
        if ( isdefined( level.ee_battle.var_2b53e32ba0c4f3bd ) && var_49f7091014d2c59 - level.ee_battle.var_2b53e32ba0c4f3bd < 5 )
        {
            return;
        }
        
        level utility::flag_set( "bat_ee_active" );
        level.ee_battle.var_9c444f4cb49b2a94 = 1;
        self makeunusable();
        player thread function_d4eb68470027550();
        player utility::waittill_any_timeout( 120, "remote_robot_ended", "death_or_disconnect" );
        self makeusable();
        level.ee_battle.var_9c444f4cb49b2a94 = undefined;
        level utility::flag_clear( "bat_ee_active" );
        return;
    }
    
    existing_streak = player killstreaks::getequippedkillstreakbyname( "remote_robot" );
    
    if ( isdefined( existing_streak ) && existing_streak.available > 0 )
    {
        return;
    }
    
    if ( player currency::attempt_purchase( #"salvage", 1750, 1, 0, #"purchase_rr" ) )
    {
        item_bundle_name = common_item_database::function_a4f0a21951180013( "remote_robot" );
        
        if ( isdefined( item_bundle_name ) )
        {
            scriptable_name = getscriptbundlefieldvalue( item_bundle_name, #"scriptable" );
            fake_scriptable = { #count:1, #type:scriptable_name };
            success = player common_item::function_2b5e2ff57d5f392( fake_scriptable, 0, 1 );
        }
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x6bae719, Offset: 0x1c82
// Size: 0x10f
function private clear_equipment()
{
    if ( isdefined( level.rcxds ) && level.rcxds.size )
    {
        foreach ( rcxd in level.rcxds )
        {
            rcxd rcxd_shared::rcxd_explode();
        }
    }
    
    foreach ( player in level.players )
    {
        player thread mutant_injection_utility::function_6fa2b0b46d2abcf7( 1 );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x57e36ea4, Offset: 0x1d99
// Size: 0xa1
function private function_7d638dfa0508cd67()
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        while ( zm_player::function_f37cfdf04b932a03( player ) && player.var_d1c4c78b9fb7d153 )
        {
            wait 0.25;
        }
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0xe0fbcee2, Offset: 0x1e42
// Size: 0x3ba
function private function_d4eb68470027550()
{
    self endon( #"disconnect" );
    function_7d638dfa0508cd67();
    clear_equipment();
    var_b802db040b85531b = self.origin;
    var_200f434dacba6555 = self.angles;
    var_d457345ff8206c7e = self getcamerathirdperson();
    var_4004f65ef32d4824 = utility::getstructarray( "ab_sp_watch", "targetname" );
    var_1bf9bd17b1452a91 = var_4004f65ef32d4824[ randomint( var_4004f65ef32d4824.size ) ];
    function_41072bcfa704d11c( var_1bf9bd17b1452a91 );
    
    if ( level.players.size > 1 )
    {
        level thread setup_battle_spectators( self );
    }
    
    s_zursa = utility::getstruct( "zs_kju_sp", "targetname" );
    zursa = agent_manager::spawn_agent( "zombie_callisto", s_zursa.origin, s_zursa.angles ?? ( 0, 0, 0 ), "team_two_hundred" );
    zursa_attractor = undefined;
    
    if ( zursa )
    {
        zursa zombie_utils::set_zombie_round_difficulty( 20 );
        
        if ( s_zursa.target )
        {
            s_zursa_goal = utility::getstruct( s_zursa.target, "targetname" );
            zursa_attractor = zursa zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_zursa_goal );
        }
    }
    
    wait 3;
    s_abom = utility::getstruct( "ab_kju_sp", "targetname" );
    Abom = agent_manager::spawn_agent( "zombie_abom", s_abom.origin, s_abom.angles ?? ( 0, 0, 0 ), "team_two_hundred" );
    abom_attractor = undefined;
    
    if ( Abom )
    {
        Abom zombie_utils::set_zombie_round_difficulty( 12 );
        
        if ( s_abom.target )
        {
            var_e696ba84722684af = utility::getstruct( s_abom.target, "targetname" );
            abom_attractor = Abom zombie_attractor_manager::function_7eb1aaa8bc7cc15( var_e696ba84722684af );
        }
    }
    
    wait 3;
    thread utility::fadetoblackforplayer( self, 1, 0.5 );
    wait 0.5;
    function_bdc9b5dd67cea636();
    var_de8bcef24be90d30 = utility::getstruct( "rr_isl_sp", "targetname" );
    self setplayerangles( var_de8bcef24be90d30.angles ?? ( 0, 0, 0 ) );
    function_6685d49541ceb10d();
    
    if ( self.juggcontext )
    {
        self.juggcontext.activationorigin = var_b802db040b85531b;
        self.juggcontext.activationangles = var_200f434dacba6555;
    }
    
    self.var_cfc6520f0f180b48 = var_d457345ff8206c7e;
    var_6f5c0bece5deb66e = [];
    
    if ( zursa )
    {
        var_6f5c0bece5deb66e[ var_6f5c0bece5deb66e.size ] = zursa;
    }
    
    if ( Abom )
    {
        var_6f5c0bece5deb66e[ var_6f5c0bece5deb66e.size ] = Abom;
    }
    
    if ( isdefined( zursa ) && isalive( zursa ) && zursa_attractor )
    {
        zursa utility::delaythread( 5, &zombie_attractor_manager::function_dcfb4c31f1d97cd2, zursa_attractor );
    }
    
    if ( isdefined( Abom ) && isalive( Abom ) && abom_attractor )
    {
        Abom utility::delaythread( 5, &zombie_attractor_manager::function_dcfb4c31f1d97cd2, abom_attractor );
    }
    
    thread utility::fadetoblackforplayer( self, 0, 0.5 );
    musicbank_utility::function_5aca66c390aa347d( level.players, #"pap_oni_fight" );
    thread function_f4ff77bc2b96c9f5( var_6f5c0bece5deb66e );
    thread function_604859da4f5a1ac1( var_6f5c0bece5deb66e );
    thread function_5c838675ab6d75f3();
    thread function_163904de662d01a4();
    level thread function_4437900a30bdb9bd( var_6f5c0bece5deb66e, self );
    self waittill( #"remote_robot_ended" );
    
    if ( var_b802db040b85531b )
    {
        streamhint::playerstreamhintlocation( var_b802db040b85531b );
    }
    
    self setorigin( var_b802db040b85531b );
    self setplayerangles( var_200f434dacba6555 );
    function_14393606183750f0();
    self.var_9b5ed3c45d5a5535 = undefined;
    self.var_15a44af9d0e4010b = undefined;
    self.var_12f41c530720cd5d = undefined;
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x9a0cd12d, Offset: 0x2204
// Size: 0x93
function private function_bdc9b5dd67cea636()
{
    function_14393606183750f0();
    self unlink();
    
    if ( self.var_50d1adaf1f68b916 )
    {
        self.var_50d1adaf1f68b916 delete();
        self.var_50d1adaf1f68b916 = undefined;
    }
    
    if ( self.bat_spectator_model )
    {
        self.bat_spectator_model delete();
        self.bat_spectator_model = undefined;
    }
    
    if ( isdefined( self.var_18976542bf54139e ) && !self.var_18976542bf54139e )
    {
        self setcamerathirdperson( 0 );
    }
    
    self.var_18976542bf54139e = undefined;
    self playershow();
    self.var_12f41c530720cd5d = undefined;
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0xfd55e049, Offset: 0x229f
// Size: 0x123
function private function_14393606183750f0()
{
    val::reset( "bat_spectator", "ignoreme" );
    val::reset( "bat_spectator", "damage" );
    val::reset( "bat_spectator", "show_hud" );
    val::reset( "bat_spectator", "hide_viewmodel" );
    val::reset( "bat_spectator", "weapon" );
    val::reset( "bat_spectator", "weapon_switch" );
    val::reset( "bat_spectator", "supers" );
    val::reset( "bat_spectator", "gesture" );
    val::reset( "bat_spectator", "killstreaks" );
    val::reset( "bat_spectator", "fire" );
    val::reset( "bat_spectator", "offhand_weapons" );
    val::reset( "bat_spectator", "offhand_primary_weapons" );
    val::reset( "bat_spectator", "offhand_secondary_weapons" );
    val::reset( "bat_spectator", "allow_toggle_third_person" );
    val::reset( "bat_spectator", "prone" );
    val::reset( "bat_spectator", "crouch" );
    val::reset( "bat_spectator", "allow_jump" );
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0xf5c856fd, Offset: 0x23ca
// Size: 0x1e5
function private function_6685d49541ceb10d()
{
    self endon( #"disconnect" );
    var_de8bcef24be90d30 = utility::getstruct( "rr_isl_sp", "targetname" );
    v_original_origin = self.origin;
    v_original_angles = self.angles;
    drop_pos = spawnstruct();
    drop_pos.origin = var_de8bcef24be90d30.origin;
    drop_pos.angles = var_de8bcef24be90d30.angles ?? ( 0, 0, 0 );
    drop_pos.yaw = drop_pos.angles[ 1 ];
    drop_pos.inuse = 0;
    var_7b6df955843209c7 = level.var_e2f4b643d9aa57ae;
    level.var_e2f4b643d9aa57ae = [ drop_pos ];
    self.var_adc43141e2117c18 = 1;
    self.var_7193c22a10fb5738 = 1;
    prev_streak = killstreaks::getkillstreakinslot( 1 );
    var_7beab0b5954061b4 = isdefined( prev_streak ) ? prev_streak.streakname : undefined;
    self.var_cfc6520f0f180b48 = self getcamerathirdperson();
    killstreaks::awardkillstreak( "remote_robot", "other", undefined, undefined, undefined, 1 );
    streak_item = killstreaks::getkillstreakinslot( 1 );
    success = killstreaks::triggerkillstreak( streak_item, 1 );
    level.var_e2f4b643d9aa57ae = var_7b6df955843209c7;
    
    if ( success )
    {
        self.juggcontext.activationorigin = v_original_origin;
        self.juggcontext.activationangles = v_original_angles;
        thread function_479ce5a05cb4cc26( var_7beab0b5954061b4 );
    }
    
    killstreaks::removekillstreak( 1 );
    
    if ( !success && isdefined( var_7beab0b5954061b4 ) )
    {
        killstreaks::awardkillstreak( var_7beab0b5954061b4, "other", undefined, undefined, undefined, 1 );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x35892b1, Offset: 0x25b7
// Size: 0x88
function private function_479ce5a05cb4cc26( var_7beab0b5954061b4 )
{
    self endon( #"disconnect" );
    self waittill( #"remote_robot_ended" );
    self.var_adc43141e2117c18 = undefined;
    self.var_7193c22a10fb5738 = undefined;
    
    if ( isdefined( self.var_cfc6520f0f180b48 ) && self.var_cfc6520f0f180b48 )
    {
        self setcamerathirdperson( 1 );
    }
    else
    {
        self setcamerathirdperson( 0 );
    }
    
    self.var_cfc6520f0f180b48 = undefined;
    
    if ( isdefined( var_7beab0b5954061b4 ) )
    {
        killstreaks::awardkillstreak( var_7beab0b5954061b4, "other", undefined, undefined, undefined, 1 );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0xee71d686, Offset: 0x2647
// Size: 0x39
function private function_de1ecc357c566838( params )
{
    if ( params.streakitem.streakname != "remote_robot" )
    {
        return;
    }
    
    thread function_3d815405834b715c();
    thread function_278d8073ab0d6313();
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x6fc2b99a, Offset: 0x2688
// Size: 0xc6
function private function_3d815405834b715c()
{
    self endon( #"disconnect" );
    result = utility::waittill_any_return( "remote_robot_landed", "remote_robot_ended" );
    
    if ( result != "remote_robot_landed" )
    {
        return;
    }
    
    helmet = utility::spawn_model( %"hash_53430b10dcfbc181", self gettagorigin( "j_head" ), self gettagangles( "j_head" ) );
    helmet linkto( self, "j_head", ( -12, 0, 0 ), ( 0, 0, 0 ) );
    self.var_5a12de780c63318d = 1;
    self waittill( #"remote_robot_ended" );
    
    if ( self.var_5a12de780c63318d )
    {
        helmet unlink();
        helmet delete();
        self.var_5a12de780c63318d = undefined;
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0xd182e86b, Offset: 0x2756
// Size: 0x22d
function private function_278d8073ab0d6313()
{
    self endon( #"disconnect" );
    result = utility::waittill_any_return( "remote_robot_landed", "remote_robot_ended" );
    
    if ( result != "remote_robot_landed" )
    {
        return;
    }
    
    self endon( #"remote_robot_ended" );
    
    while ( true )
    {
        utility::waittill_any( "weapon_fired", "melee_fired" );
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        var_9d4550d562f890d7 = self gettagorigin( "tag_eye" ) + ( 0, 0, 5 );
        var_2f4d750bcced51a = vectornormalize( anglestoforward( self getgunangles() ) );
        var_b0ec4782a33e87a5 = vectornormalize( anglestoright( self getgunangles() ) );
        v_end = var_9d4550d562f890d7 + var_2f4d750bcced51a * 5000;
        v_right_start = var_9d4550d562f890d7 + var_b0ec4782a33e87a5 * 20 + var_2f4d750bcced51a * -25;
        v_right_vel = vectornormalize( v_end - v_right_start ) * 1000;
        projectile_r = magicgrenademanual( "points_of_power_mp_dagger", v_right_start, v_right_vel, 1.5, self );
        projectile_r.team = self.team;
        projectile_r.angles = vectortoangles( v_right_vel );
        projectile_r playsound( "evt_trail_impact" );
        thread function_8980cbc9b8198d3e( projectile_r );
        projectile_r thread function_a63b260eb7ac45fa( self );
        wait 0.4;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        var_9d4550d562f890d7 = self gettagorigin( "tag_eye" );
        var_2f4d750bcced51a = vectornormalize( anglestoforward( self getgunangles() ) );
        var_b0ec4782a33e87a5 = vectornormalize( anglestoright( self getgunangles() ) );
        v_end = var_9d4550d562f890d7 + var_2f4d750bcced51a * 5000;
        v_left_start = var_9d4550d562f890d7 + var_b0ec4782a33e87a5 * -20 + var_2f4d750bcced51a * -25;
        v_left_vel = vectornormalize( v_end - v_left_start ) * 1000;
        projectile_l = magicgrenademanual( "points_of_power_mp_dagger", v_left_start, v_left_vel, 1.5, self );
        projectile_l.team = self.team;
        projectile_l.angles = vectortoangles( v_left_vel );
        projectile_l playsound( "evt_trail_impact" );
        thread function_8980cbc9b8198d3e( projectile_l );
        projectile_l thread function_a63b260eb7ac45fa( self );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0xc771139f, Offset: 0x298b
// Size: 0x23b
function private function_8980cbc9b8198d3e( projectile )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    round_difficulty = zm_utility::get_round_number();
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    damage = int( zombie_base_health * 0.2 );
    projectile waittill( #"death" );
    
    if ( !isdefined( projectile.origin ) )
    {
        return;
    }
    
    projectile_origin = projectile.origin;
    var_3e5df7c437647749 = getaiarrayinradius( projectile_origin, 75 );
    
    foreach ( aihit in var_3e5df7c437647749 )
    {
        if ( isalive( aihit ) && isplayer( self ) )
        {
            if ( !isdefined( level.var_f6df644a29468234 ) )
            {
                level.var_f6df644a29468234 = throttle::throttle_initialize( "bat_dagger_projectile_dmg", 1 );
            }
            
            throttle::throttle_wait_in_queue( level.var_f6df644a29468234, aihit );
            aihit dodamage( damage, projectile_origin, self, self, "MOD_UNKNOWN", "none", "none", undefined, 1073741824 );
            
            if ( isalive( aihit ) && utility::percent_chance( 7 ) )
            {
                if ( isdefined( aihit.aicategory ) )
                {
                    if ( aihit.aicategory == "normal" )
                    {
                        aihit zombie_knockdown::function_a113e6ee43535d37( self.origin, damage );
                        continue;
                    }
                    
                    if ( aihit.aicategory != "hvt" && aihit.aicategory != "boss" )
                    {
                        n_time = gettime();
                        
                        if ( !isdefined( aihit.var_76dd8dcfc38c5b6 ) || n_time - aihit.var_76dd8dcfc38c5b6 >= 10000 )
                        {
                            aihit.var_76dd8dcfc38c5b6 = n_time;
                            aihit zombie_stun::stun_ai( 2 );
                        }
                    }
                }
            }
        }
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0xc
// Checksum 0x722ef912, Offset: 0x2bce
// Size: 0x4d
function private function_a63b260eb7ac45fa( player )
{
    self notify( #"hash_4a04b9fcdf0d882c" );
    self endon( #"hash_4a04b9fcdf0d882c" );
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 1.5;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0xbeafc5ab, Offset: 0x2c23
// Size: 0x1d9
function private function_f4ff77bc2b96c9f5( var_6f5c0bece5deb66e )
{
    self endon( #"disconnect" );
    self.var_91aa3bc85e57d496 = 0;
    self.var_257b753312bc8810 = var_6f5c0bece5deb66e.size;
    
    foreach ( enemy in var_6f5c0bece5deb66e )
    {
        if ( isdefined( enemy ) && isalive( enemy ) )
        {
            enemy thread function_c8599ddb8ba24007( self );
        }
    }
    
    result = utility::waittill_any_return( "bat_fight_all_killed", "remote_robot_ended" );
    
    if ( result == "bat_fight_all_killed" )
    {
        wait 1;
        self playsoundtoplayer( "evt_ee_complete_success_stinger", self );
        thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hesd2_mecha_kaiju_defeat_last_enemy" );
        level utility::flag_set( "all_mkbp_def" );
        wait 2;
        self notify( #"remote_robot_manual_exit" );
        level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_15800b43a7bb4ab8", #"hash_7a419acaa1cd605f", [ self ] );
    }
    else
    {
        wait 1;
        self playsoundtoplayer( "evt_ee_fail_stinger", self );
        level thread function_74c1a7068090d334( var_6f5c0bece5deb66e );
        function_c6698e7419e536b1();
        level.ee_battle.var_2b53e32ba0c4f3bd = zm_utility::get_round_number();
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_bat", #"hash_1affb54f0a375c65", level.ee_battle.var_2b53e32ba0c4f3bd );
    }
    
    self.var_91aa3bc85e57d496 = undefined;
    self.var_257b753312bc8810 = undefined;
    musicbank_utility::function_4f253fd35ec68cbc( level.players, #"pap_oni_fight" );
    level notify( #"bat_arena_ended" );
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x82433712, Offset: 0x2e04
// Size: 0x66
function private function_c8599ddb8ba24007( player )
{
    player endon( #"disconnect" );
    player endon( #"remote_robot_ended" );
    self waittill( #"death" );
    player.var_91aa3bc85e57d496++;
    
    if ( player.var_91aa3bc85e57d496 >= player.var_257b753312bc8810 )
    {
        player notify( #"bat_fight_all_killed" );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0xa88abc29, Offset: 0x2e72
// Size: 0xae
function private function_604859da4f5a1ac1( var_6f5c0bece5deb66e )
{
    level endon( #"game_ended" );
    level endon( #"bat_arena_ended" );
    self waittill( #"disconnect" );
    musicbank_utility::function_4f253fd35ec68cbc( level.players, #"pap_oni_fight" );
    level thread function_74c1a7068090d334( var_6f5c0bece5deb66e );
    function_c6698e7419e536b1();
    level.ee_battle.var_2b53e32ba0c4f3bd = zm_utility::get_round_number();
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_bat", #"hash_1affb54f0a375c65", level.ee_battle.var_2b53e32ba0c4f3bd );
    level notify( #"bat_arena_ended" );
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0xde2ad97f, Offset: 0x2f28
// Size: 0x8f
function private function_74c1a7068090d334( var_6f5c0bece5deb66e )
{
    wait 1;
    
    foreach ( enemy in var_6f5c0bece5deb66e )
    {
        if ( isdefined( enemy ) && isalive( enemy ) )
        {
            enemy kill();
        }
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0xcae2cb32, Offset: 0x2fbf
// Size: 0x98
function private cleanup_pending_pickup()
{
    mdl = level.ee_battle.var_da5079f846860132;
    
    if ( isdefined( mdl ) )
    {
        if ( isdefined( mdl.interact ) )
        {
            mdl.interact delete();
        }
        
        if ( isdefined( mdl.outline_id ) )
        {
            outline::outlinedisable( mdl.outline_id, mdl );
        }
        
        mdl delete();
    }
    
    level.ee_battle.var_54b098e7a42b3481 = 0;
    level.ee_battle.var_da5079f846860132 = undefined;
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x26c8cd04, Offset: 0x305f
// Size: 0xad
function private function_c6698e7419e536b1()
{
    a_houses = getentitylessscriptablearray( "bat_mnhs", #targetname );
    
    foreach ( house in a_houses )
    {
        house utility::function_7c10ea82c1e305b8( "model", "default" );
        house utility::function_7c10ea82c1e305b8( "fx", "none" );
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 2, eflags: 0x4
// Checksum 0xfa1bc4be, Offset: 0x3114
// Size: 0x1f6
function private function_4437900a30bdb9bd( var_6f5c0bece5deb66e, robot_player )
{
    level endon( #"game_ended" );
    level endon( #"bat_arena_ended" );
    a_houses = getentitylessscriptablearray( "bat_mnhs", #targetname );
    
    while ( true )
    {
        wait 0.25;
        
        foreach ( house in a_houses )
        {
            if ( house utility::function_9f2c41c1dcc8c94( "model", "default" ) )
            {
                b_explode = 0;
                
                if ( isdefined( robot_player ) && isalive( robot_player ) )
                {
                    if ( distancesquared( robot_player.origin, house.origin ) <= 400 )
                    {
                        b_explode = 1;
                    }
                }
                
                if ( !b_explode )
                {
                    foreach ( enemy in var_6f5c0bece5deb66e )
                    {
                        if ( isdefined( enemy ) && isalive( enemy ) )
                        {
                            if ( distancesquared( enemy.origin, house.origin ) <= 400 )
                            {
                                b_explode = 1;
                                break;
                            }
                        }
                    }
                }
                
                if ( b_explode )
                {
                    n_attacker = isent( robot_player ) && isalive( robot_player ) ? robot_player : undefined;
                    house scriptabledodamage( 9999, n_attacker, n_attacker, undefined, undefined, "MOD_MELEE" );
                }
            }
        }
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x9c139cb9, Offset: 0x3312
// Size: 0x13e
function private setup_battle_spectators( battle_player )
{
    level endon( #"game_ended" );
    var_4004f65ef32d4824 = utility::getstructarray( "ab_sp_watch", "targetname" );
    
    if ( var_4004f65ef32d4824.size == 0 || level.players.size <= 1 )
    {
        return;
    }
    
    a_spectators = [];
    var_b5bdfe7cd4a0bf4f = 0;
    
    foreach ( player in level.players )
    {
        if ( player == battle_player || player == level.sq_player || player.sessionstate == "spectator" )
        {
            continue;
        }
        
        s_watch = var_4004f65ef32d4824[ var_b5bdfe7cd4a0bf4f % var_4004f65ef32d4824.size ];
        var_b5bdfe7cd4a0bf4f++;
        player thread function_41072bcfa704d11c( s_watch );
        a_spectators[ a_spectators.size ] = player;
    }
    
    level utility::waittill_any_timeout( 90, "bat_arena_ended" );
    cleanup_bat_spectators( a_spectators );
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0xbbf40104, Offset: 0x3458
// Size: 0x2fd
function private function_41072bcfa704d11c( s_watch )
{
    self endon( #"disconnect" );
    
    while ( !self isonground() )
    {
        wait 0.1;
    }
    
    thread utility::fadetoblackforplayer( self, 1, 0.5 );
    self setstance( "stand" );
    val::set( "bat_spectator", "prone", 0 );
    val::set( "bat_spectator", "crouch", 0 );
    val::set( "bat_spectator", "allow_jump", 0 );
    wait 0.5;
    self.var_9b5ed3c45d5a5535 = self.origin;
    self.var_15a44af9d0e4010b = self.angles;
    self.var_18976542bf54139e = self getcamerathirdperson();
    
    if ( !self getcamerathirdperson() )
    {
        self setcamerathirdperson( 1 );
    }
    
    val::set( "bat_spectator", "allow_toggle_third_person", 0 );
    val::set( "bat_spectator", "ignoreme", 1 );
    val::set( "bat_spectator", "damage", 0 );
    val::set( "bat_spectator", "show_hud", 0 );
    val::set( "bat_spectator", "hide_viewmodel", 1 );
    val::set( "bat_spectator", "weapon", 0 );
    val::set( "bat_spectator", "weapon_switch", 0 );
    val::set( "bat_spectator", "supers", 0 );
    val::set( "bat_spectator", "gesture", 0 );
    val::set( "bat_spectator", "killstreaks", 0 );
    val::set( "bat_spectator", "fire", 0 );
    val::set( "bat_spectator", "offhand_weapons", 0 );
    val::set( "bat_spectator", "offhand_primary_weapons", 0 );
    val::set( "bat_spectator", "offhand_secondary_weapons", 0 );
    var_48d7479b5e64f60d = s_watch.origin + ( 0, 0, 0 );
    self.bat_spectator_model = utility::spawn_model( %"hash_2426c25c9a3c52bd", var_48d7479b5e64f60d, s_watch.angles ?? ( 0, 0, 0 ), undefined, 5 );
    self.var_50d1adaf1f68b916 = utility::spawn_model( "tag_origin", s_watch.origin + anglestoforward( s_watch.angles ) * -14 + ( 0, 0, -50 ), s_watch.angles ?? ( 0, 0, 0 ) );
    self setorigin( self.var_50d1adaf1f68b916.origin );
    self setplayerangles( self.var_50d1adaf1f68b916.angles );
    self playerlinktodelta( self.var_50d1adaf1f68b916, undefined, 1, 180, 180, -6, 30 );
    self playerhide();
    pbgpostfxbundlestart( self, %"cer_mp_rcxd_drive" );
    self.var_12f41c530720cd5d = 1;
    thread function_224e93e36d36ddd();
    wait 1;
    thread utility::fadetoblackforplayer( self, 0, 0.5 );
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0xc92a3dc8, Offset: 0x375d
// Size: 0x12e
function private function_ca428fa22375c56a()
{
    self endon( #"disconnect" );
    
    if ( self.var_9b5ed3c45d5a5535 )
    {
        streamhint::playerstreamhintlocation( self.var_9b5ed3c45d5a5535 );
    }
    
    thread utility::fadetoblackforplayer( self, 1, 0.5 );
    wait 0.5;
    function_14393606183750f0();
    self unlink();
    
    if ( isdefined( self.var_50d1adaf1f68b916 ) )
    {
        self.var_50d1adaf1f68b916 delete();
        self.var_50d1adaf1f68b916 = undefined;
    }
    
    if ( isdefined( self.bat_spectator_model ) )
    {
        self.bat_spectator_model delete();
        self.bat_spectator_model = undefined;
    }
    
    if ( isdefined( self.var_9b5ed3c45d5a5535 ) )
    {
        self setorigin( self.var_9b5ed3c45d5a5535 );
        self setplayerangles( self.var_15a44af9d0e4010b );
        self.var_9b5ed3c45d5a5535 = undefined;
        self.var_15a44af9d0e4010b = undefined;
    }
    
    if ( isdefined( self.var_18976542bf54139e ) && !self.var_18976542bf54139e )
    {
        self setcamerathirdperson( 0 );
    }
    
    self.var_18976542bf54139e = undefined;
    pbgpostfxbundleend( self, %"cer_mp_rcxd_drive" );
    self playershow();
    self.var_12f41c530720cd5d = undefined;
    thread utility::fadetoblackforplayer( self, 0, 0.5 );
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0xefbb27e6, Offset: 0x3893
// Size: 0x84
function private cleanup_bat_spectators( a_spectators )
{
    foreach ( player in a_spectators )
    {
        if ( isdefined( player ) )
        {
            player thread function_ca428fa22375c56a();
        }
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0x1e126920, Offset: 0x391f
// Size: 0xb6
function private function_224e93e36d36ddd()
{
    self endon( #"disconnect" );
    level endon( #"bat_arena_ended" );
    
    while ( isdefined( self.var_12f41c530720cd5d ) && self.var_12f41c530720cd5d )
    {
        if ( self usebuttonpressed() && self.bat_spectator_model )
        {
            playsoundatpos( self.bat_spectator_model.origin, "evt_kaijuu_battle_single_scream" );
            
            while ( self usebuttonpressed() )
            {
                waitframe();
            }
            
            wait 0.5;
        }
        else if ( self.bat_spectator_model )
        {
            self.bat_spectator_model.angles = self.angles + ( 0, 30, 0 );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0xaad13117, Offset: 0x39dd
// Size: 0x29
function private function_5c838675ab6d75f3()
{
    self endon( #"disconnect" );
    self endon( #"remote_robot_ended" );
    wait 2;
    thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hesd2_mecha_kaiju_battle_start" );
}

// Namespace zm_sat_hornet_ee_bat
// Params 0, eflags: 0x4
// Checksum 0xcaadfc2e, Offset: 0x3a0e
// Size: 0x250
function private function_163904de662d01a4()
{
    self endon( #"disconnect" );
    level endon( #"bat_arena_ended" );
    a_houses = getentitylessscriptablearray( "bat_mnhs", #targetname );
    a_destroyed = [];
    var_ca5736092f9530b7 = 0;
    var_4ba618e95f5b036d = 0;
    var_58cb17d702f5e445 = [];
    var_58cb17d702f5e445[ 0 ] = #"hash_8fed5f8b107782a7";
    var_58cb17d702f5e445[ 1 ] = #"hash_8fed608b1077845a";
    var_58cb17d702f5e445[ 2 ] = #"hash_8fed618b1077860d";
    var_58cb17d702f5e445[ 3 ] = #"hash_8fed5a8b10777a28";
    var_58cb17d702f5e445[ 4 ] = #"hash_8fed5b8b10777bdb";
    var_58cb17d702f5e445[ 5 ] = #"hash_8fed5c8b10777d8e";
    var_58cb17d702f5e445[ 6 ] = #"hash_8fed5d8b10777f41";
    var_58cb17d702f5e445[ 7 ] = #"hash_8fed568b1077735c";
    var_f0c7bbe9f1f92ce2 = [];
    var_f0c7bbe9f1f92ce2[ 0 ] = "hesd2_mecha_kaiju_destroy_structure_alt09";
    var_f0c7bbe9f1f92ce2[ 1 ] = "hesd2_mecha_kaiju_destroy_structure_alt10";
    var_f0c7bbe9f1f92ce2[ 2 ] = "hesd2_mecha_kaiju_destroy_structure_alt11";
    var_f0c7bbe9f1f92ce2[ 3 ] = "hesd2_mecha_kaiju_destroy_structure_alt12";
    
    while ( true )
    {
        wait 0.5;
        
        foreach ( house in a_houses )
        {
            if ( !arraycontains( a_destroyed, house ) )
            {
                if ( !house utility::function_9f2c41c1dcc8c94( "model", "default" ) )
                {
                    a_destroyed[ a_destroyed.size ] = house;
                    n_time = gettime();
                    
                    if ( n_time - var_4ba618e95f5b036d >= 500 )
                    {
                        playsoundatpos( house.origin, "evt_kaijuu_battle_crowd_scream" );
                        var_4ba618e95f5b036d = n_time;
                    }
                    
                    n_time = gettime();
                    
                    if ( randomfloat( 1 ) <= 0.5 && n_time - var_ca5736092f9530b7 >= 30000 )
                    {
                        var_ca5736092f9530b7 = n_time;
                        n_alt = randomint( 12 );
                        
                        if ( n_alt < 8 )
                        {
                            level thread overlord::playevent( var_58cb17d702f5e445[ n_alt ], level.players );
                            continue;
                        }
                        
                        n_convo = n_alt - 8;
                        level thread overlord::playconversation( var_f0c7bbe9f1f92ce2[ n_convo ], level.players );
                    }
                }
            }
        }
    }
}

// Namespace zm_sat_hornet_ee_bat
// Params 1, eflags: 0x4
// Checksum 0x1e49576b, Offset: 0x3c66
// Size: 0x9d
function private function_875147c303e760ce( params )
{
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player killstreaks::awardkillstreak( "remote_robot", "other", undefined, undefined, undefined, 1 );
        }
    }
}

/#

    // Namespace zm_sat_hornet_ee_bat
    // Params 0, eflags: 0x4
    // Checksum 0x8e4002cd, Offset: 0x3d0b
    // Size: 0x4c, Type: dev
    function private register_bat_devgui()
    {
        zm_quest::function_bc99f123a684344f( #"hornet_ee_bat" );
        devgui::add_devgui_func( "<dev string:x24>", "<dev string:x3b>", &debug_toggle_spectator, 1 );
        devgui::add_devgui_func( "<dev string:x4b>", "<dev string:x63>", &function_986ce4cafbd32646, 1 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_hornet_ee_bat
    // Params 0, eflags: 0x4
    // Checksum 0x35648194, Offset: 0x3d5f
    // Size: 0xf9, Type: dev
    function private debug_toggle_spectator()
    {
        player = level.players[ 0 ];
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( isdefined( player.var_12f41c530720cd5d ) && player.var_12f41c530720cd5d )
        {
            player thread function_ca428fa22375c56a();
            return;
        }
        
        var_4004f65ef32d4824 = utility::getstructarray( "<dev string:x72>", "<dev string:x7e>" );
        
        if ( var_4004f65ef32d4824.size == 0 )
        {
            return;
        }
        
        if ( !isdefined( level.ee_battle.var_e2f3e6b126c5f3e6 ) )
        {
            level.ee_battle.var_e2f3e6b126c5f3e6 = 0;
        }
        
        player thread function_41072bcfa704d11c( var_4004f65ef32d4824[ level.ee_battle.var_e2f3e6b126c5f3e6 ] );
        level.ee_battle.var_e2f3e6b126c5f3e6++;
        level.ee_battle.var_e2f3e6b126c5f3e6 %= var_4004f65ef32d4824.size;
    }

    // Namespace zm_sat_hornet_ee_bat
    // Params 0, eflags: 0x4
    // Checksum 0xc96d077, Offset: 0x3e60
    // Size: 0x2c, Type: dev
    function private function_986ce4cafbd32646()
    {
        player = level.players[ 0 ];
        
        if ( !player )
        {
            return;
        }
        
        player thread function_d4eb68470027550();
    }

#/
