// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_mq.gsc  (hash_28e5f71cdba4db0a.gscc) (size: 102156 Bytes / 0x18f0c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x32dd2c48 (853355592)
// size ...... 102156 (0x18f0c)
// includes .. 58  (offset: 0x171c4)
// strings ... 322 (offset: 0x17394)
// dev strs .. 94  (offset: 0x18a70)
// exports ... 175 (offset: 0x10788)
// cseg ...... 0x1a82 + 0xed06 (0x10788)
// imports ... 553 (offset: 0x122e0)
// animtree1 . 0   (offset: 0x18f0c)
// animtree2 . 0   (offset: 0x18f0c)
#using script_16ea1b94f0f381b3;
#using script_38234c6dc0321d2a;
#using script_38839cc29075d9db;
#using script_5cda26b07ee216bf;
#using scripts\anim\dialogue;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_cocoon;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\scriptable_group;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\killstreaks\dawg_mp;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\weapons\weap_scarabww;
#using scripts\mp\common\weapons\ww_shared;
#using scripts\mp\damagefeedback;
#using scripts\mp\dragonsbreath;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\weapons;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_boss_fight;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_mq_cs;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_pap_quest;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_phone;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rb;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ww_quest;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_exfil_sat;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_ncfdpedestal;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_mq;

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x5
// Checksum 0xc00c35bc, Offset: 0x1aa0
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"scarab_mq", #"zm_quest", &function_930973cdd22cf413, &function_a2f64003f0457e92 );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xb211f556, Offset: 0x1acd
// Size: 0x303
function private function_930973cdd22cf413()
{
    zm_sat_scarab_mq_cs::main();
    
    if ( !getdvarint( @"hash_1389eb7dad9f9d83", 0 ) )
    {
        return;
    }
    
    zm_quest::register_quest_step( #"scarab_mq", #"start_symbols", &setup_start_symbols, &cleanup_start_symbols );
    zm_quest::register_quest_step( #"scarab_mq", #"solve_symbols", &setup_solve_symbols, &cleanup_solve_symbols );
    zm_quest::register_quest_step( #"scarab_mq", #"go_to_safehouse", &function_6f2a1957e766ffea, &function_f2ca61ca9764938b );
    zm_quest::register_quest_step( #"scarab_mq", #"find_upgrade", &setup_find_upgrade, &cleanup_find_upgrade );
    zm_quest::register_quest_step( #"scarab_mq", #"upgrade_pedestal", &setup_upgrade_pedestal, &cleanup_upgrade_pedestal );
    zm_quest::register_quest_step( #"scarab_mq", #"clear_gears", &setup_clear_gears, &cleanup_clear_gears );
    zm_quest::register_quest_step( #"scarab_mq", #"restart_engine", &setup_restart_engine, &cleanup_restart_engine );
    zm_quest::register_quest_step( #"scarab_mq", #"cleanse_temples", &function_f094d1200e309814, &function_68d48b23c1e3b131 );
    zm_quest::register_quest_step( #"scarab_mq", #"enter_boss_fight", &setup_enter_boss_fight, &cleanup_enter_boss_fight );
    level.zm_scarab_mq = zm_quest::get_quest( #"scarab_mq" );
    namespace_7d52c88182a8ee9b::register_temple_quests( "caltheris" );
    namespace_7d52c88182a8ee9b::register_temple_quests( "dravakar" );
    namespace_7d52c88182a8ee9b::register_temple_quests( "nyxara" );
    namespace_7d52c88182a8ee9b::register_temple_quests( "veytharion" );
    namespace_7d52c88182a8ee9b::function_2fa9a01d86a5d30();
    zm_quest::get_quest( #"hash_f6b10d1f1c4575a" ).var_8af4bb0185feb88 = 4;
    zm_quest::get_quest( #"hash_a9ed33fe4d2ef275" ).var_8af4bb0185feb88 = 3;
    zm_quest::get_quest( #"hash_2d753cdc71ad3528" ).var_8af4bb0185feb88 = 1;
    zm_quest::get_quest( #"hash_8f67bf8336da87a4" ).var_8af4bb0185feb88 = 2;
    level._effect[ "tw_scene_spawn" ] = loadfxasset( "vfx_sat_zm_two_sisters_spawn" );
    level._effect[ "tw_reward_spawn" ] = loadfxasset( "vfx_t10_levels_zm_opal_ritual_bowl_transition" );
    level._effect[ #"hash_33df832c950ebf73" ] = loadfxasset( "vfx_sat_levels_zm_scarab_forge_mana_obelisk_to_temple_beam" );
    level._effect[ #"hash_d4a1fe7e4b6f48f8" ] = loadfxasset( "vfx_sat_levels_zm_scarab_forge_mana_obelisk_to_temple_beam_origin" );
    level._effect[ #"hash_5a739e4db08befc9" ] = loadfxasset( "vfx_sat_levels_zm_scarab_forge_mana_obelisk_to_temple_beam_impact" );
    level._effect[ "exfil_hvt_spawn_portal_vfx_custom" ] = loadfxasset( "vfx_sat_levels_zm_scarab_phone_booth_spawn_blue" );
    level._effect[ "dark_energy_beam_custom" ] = loadfxasset( "vfx_sat_levels_zm_scarab_phone_booth_active_beam_blue" );
    level._effect[ "dark_energy_fly_vfx_custom" ] = loadfxasset( "vfx_sat_levels_zm_scarab_phone_booth_trail_blue" );
    level._effect[ "hvt_energy_beam_custom" ] = loadfxasset( "vfx_sat_levels_zm_scarab_phone_booth_active_beam_blue" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x2def1afd, Offset: 0x1dd8
// Size: 0x1b2
function private function_a2f64003f0457e92()
{
    level utility::flag_wait( "zm_quest_initialized" );
    level thread setup_mq_objects();
    level thread function_38724f179692538d();
    level callback::add( "special_round_start", &function_1907bf6712f60078 );
    level callback::add( #"hash_38e04a6ab5e82438", &function_95b86968754aa670 );
    level zombie_utils::function_dfae6a5bd222c586( &function_d3db8c47e794100 );
    level callback::add( #"hash_db23ebf23acc8885", &function_95b86968754aa670 );
    
    if ( !getdvarint( @"hash_1389eb7dad9f9d83", 0 ) )
    {
        return;
    }
    
    level callback::add( #"player_weapon_change", &function_fc03729ecb12b199 );
    scene::add_scene_func( "sat_cin_zm_vig_fly_sisters_standing", &function_bdfe82a43bd1c0f9, "callback_play" );
    scene::add_scene_func( "sat_cin_zm_vig_fly_sisters_dance", &function_bdfe82a43bd1c0f9, "callback_play" );
    level zm_save::function_1f44a48caae2acbf();
    level thread init_arch_mayhem();
    level thread function_f73ae285d87499cd();
    level thread namespace_7d52c88182a8ee9b::function_db234cd93079c3c1();
    level thread zm_quest::start_quest( #"scarab_mq" );
    
    /#
        level thread mq_debug();
    #/
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread function_51445825201dd469();
        
        if ( zm_save::function_1dda3554974a999e() )
        {
            level utility::delaythread( 5, &function_e0d5285bfbad4e41 );
        }
    }
    
    var_524edcab1d059ca3 = getnoentvolumearray( "scarab_life_brush", #targetname );
    
    foreach ( vol in var_524edcab1d059ca3 )
    {
        namespace_af5a2e4a7277c1d::function_ff714b8751ab0002( vol );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xa76e63f3, Offset: 0x1f92
// Size: 0x25
function private function_51445825201dd469()
{
    level endon( #"chicky_bicky_bambam" );
    level utility::flag_wait( "w_s_12_c_rivet" );
    wait 5;
    function_e0d5285bfbad4e41();
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xe160330c, Offset: 0x1fbf
// Size: 0xd0
function private init_arch_mayhem()
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hash_8f67bf8336da87a4", #"arch_mayhem" ) == 1 )
    {
        a_arch_mayhem = getentitylessscriptablearray( "forge_arch_mayhem", #script_noteworthy );
        
        foreach ( scriptable in a_arch_mayhem )
        {
            scriptable setscriptablepartstate( "base", "remove" );
        }
        
        level utility::flag_set( "gimbals_first_up" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xd07bda86, Offset: 0x2097
// Size: 0x1f
function private function_1907bf6712f60078( params )
{
    level callback::callback( #"hash_fdb7c9b3f46244da", params );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x5f90eba9, Offset: 0x20be
// Size: 0x14e
function private function_f73ae285d87499cd()
{
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    var_1764324234cd7401 = zm_quest::function_73720cdf21c3cfd7( #"hash_a9ed33fe4d2ef275", #"first_hidden_room" );
    
    if ( isdefined( var_1764324234cd7401 ) )
    {
        level.zm_scarab_mq.var_765f74df80347a3c = var_1764324234cd7401;
        return;
    }
    
    str_result = level utility::flag_wait_any_return( "nyxara_secret_room_opened", "hr_c_opened", "hr_v_opened", "WW_STEP_6_COMPLETE" );
    
    switch ( str_result )
    {
        case #"hash_332145aec0673491":
            level.zm_scarab_mq.var_765f74df80347a3c = 2;
            break;
        case #"hash_8d794293240ba24b":
            level.zm_scarab_mq.var_765f74df80347a3c = 4;
            break;
        case #"hash_28c1bbb630b5f1ea":
            level.zm_scarab_mq.var_765f74df80347a3c = 1;
            break;
        case #"hash_d05c0ba7bde7ea4f":
            level.zm_scarab_mq.var_765f74df80347a3c = 5;
            break;
    }
    
    level thread zm_quest::start_quest( #"hash_a9ed33fe4d2ef275" );
    zm_quest::function_4eefe6de31f5ddab( #"hash_a9ed33fe4d2ef275", #"first_hidden_room", level.zm_scarab_mq.var_765f74df80347a3c );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xfed11bf1, Offset: 0x2214
// Size: 0x894
function private setup_mq_objects()
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !level.zm_scarab_mq )
    {
        level.zm_scarab_mq = spawnstruct();
    }
    
    var_125e18437f144d3 = utility::getstruct( "safehouse_ambi_3" );
    level.zm_scarab_mq.var_d05c101ef52472fa = spawnscriptable( %"zm_sat_cardboard_box_small", var_125e18437f144d3.origin, var_125e18437f144d3.angles );
    level.zm_scarab_mq.var_d05c101ef52472fa setscriptablepartstate( "base", "reveal" );
    level.zm_scarab_mq.var_d05c101ef52472fa.var_18d4007b123c953a = 1;
    level.zm_scarab_mq.var_d05c101ef52472fa.var_436fc13baa7377d8 = 1;
    level.zm_scarab_mq.var_d05c101ef52472fa.var_674f590d538943ad = 1;
    a_panels = getentarray( "forge_sealed_panel", #targetname );
    
    foreach ( var_1af8bf945e6e471c in a_panels )
    {
        function_c1e9dfea56215227( var_1af8bf945e6e471c, 0 );
    }
    
    var_a4b4c22347038daf = getent( "nexus_ring_1", #targetname );
    var_a4b4c32347038fe2 = getent( "nexus_ring_2", #targetname );
    var_a4b4c42347039215 = getent( "nexus_ring_3", #targetname );
    level.zm_scarab_mq.a_links = [];
    var_5b9a68906ed98b40 = getent( "nexus_ring_1_link", #targetname );
    var_5b9a68906ed98b40.unresolved_collision_func = &function_81ac9d12a89fa2f;
    var_5b9a68906ed98b40.origin += ( 0, 0, 3 );
    var_5b9a68906ed98b40 linkto( var_a4b4c22347038daf );
    level.zm_scarab_mq.a_links = arraycombine( level.zm_scarab_mq.a_links, [ var_5b9a68906ed98b40 ] );
    var_586e9c520a3db1b = getent( "nexus_ring_2_link", #targetname );
    var_586e9c520a3db1b.unresolved_collision_func = &function_81ac9d12a89fa2f;
    var_586e9c520a3db1b linkto( var_a4b4c32347038fe2 );
    level.zm_scarab_mq.a_links = arraycombine( level.zm_scarab_mq.a_links, [ var_586e9c520a3db1b ] );
    var_5652cdd31625f3d6 = getent( "nexus_ring_3_link", #targetname );
    var_5652cdd31625f3d6.unresolved_collision_func = &function_81ac9d12a89fa2f;
    var_5652cdd31625f3d6 linkto( var_a4b4c42347039215 );
    level.zm_scarab_mq.a_links = arraycombine( level.zm_scarab_mq.a_links, [ var_5652cdd31625f3d6 ] );
    level.zm_scarab_mq.var_fb76b1c01e976601 = [ 0, 45, 122, 180, 252, 317 ];
    level.zm_scarab_mq.a_rings = [ var_a4b4c22347038daf, var_a4b4c32347038fe2, var_a4b4c42347039215 ];
    level.zm_scarab_mq.var_a62a3d1842569ece = [];
    level.zm_scarab_mq.var_d0c61fca7a739091 = [];
    
    foreach ( var_29aa1f4b1eaa2a4 in level.zm_scarab_mq.a_rings )
    {
        var_81d8430d88523877 = getentarray( "drop_channeler_" + var_29aa1f4b1eaa2a4.targetname, #script_noteworthy );
        
        foreach ( channeler in var_81d8430d88523877 )
        {
            channeler.origin -= ( 0, 0, 256 );
            channeler linkto( var_29aa1f4b1eaa2a4 );
            channeler.unresolved_collision_func = &function_81ac9d12a89fa2f;
        }
        
        a_triggers = getentarray( "block_trigger_" + var_29aa1f4b1eaa2a4.targetname, #targetname );
        
        foreach ( trigger in a_triggers )
        {
            level.zm_scarab_mq.var_d0c61fca7a739091[ level.zm_scarab_mq.var_d0c61fca7a739091.size ] = trigger;
            trigger enablelinkto();
            trigger linkto( var_29aa1f4b1eaa2a4 );
            trigger.var_29aa1f4b1eaa2a4 = var_29aa1f4b1eaa2a4;
        }
    }
    
    level zm_save::function_1f44a48caae2acbf();
    var_a4b4c22347038daf.n_rotate_slot = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", #"hash_f3b21cd1f5b8e84" ) ?? 2;
    var_a4b4c32347038fe2.n_rotate_slot = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", #"hash_83e631fdd4b97ba3" ) ?? 0;
    var_a4b4c42347039215.n_rotate_slot = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", #"hash_89f03fdf6d577e22" ) ?? 4;
    
    for ( i = 0; i < level.zm_scarab_mq.var_fb76b1c01e976601.size ; i++ )
    {
        function_339b830137e4badc( 0, i );
    }
    
    function_136351ae2c66058f();
    function_8b4797f558d2183();
    
    foreach ( trigger in level.zm_scarab_mq.var_d0c61fca7a739091 )
    {
        if ( trigger.script_label == "channel" )
        {
            trigger.var_988b524502b2d45e = ( 56, 132, 130 );
        }
        else
        {
            trigger.var_988b524502b2d45e = ( 96, 116, 60 );
        }
        
        trigger.var_5ea0f98dc8a9f1f4 = float( trigger.script_noteworthy );
        var_12aadf5d8bbfdafd = createnavobstaclebybounds( trigger.origin, trigger.var_988b524502b2d45e / 2, ( 0, float( trigger.script_noteworthy ), 0 ) );
        level.zm_scarab_mq.var_a62a3d1842569ece[ level.zm_scarab_mq.var_a62a3d1842569ece.size ] = var_12aadf5d8bbfdafd;
    }
    
    set_ring_rotation( 1, 0.1, 0 );
    level utility::flag_set( "forgeo_reverseo" );
    
    if ( function_d32e94a4b84c30a5( 4, #"hash_87c25a640efbd1c9" ) )
    {
        level utility::flag_clear( "forgeo_reverseo" );
        level.zm_scarab_mq.var_df4a9f862b20305f setscriptablepartstate( "lever_position_sfx", "on" );
        level.zm_scarab_mq.var_df4a9f862b20305f.var_961af44f6619c00e rotateby( ( 0, 0, 90 ), 0.3 );
    }
    
    level.zm_scarab_mq utility::ent_flag_set( "mq_quest_init_done" );
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x7cacca41, Offset: 0x2ab0
// Size: 0x66
function private function_81ac9d12a89fa2f( hitent, penetrate )
{
    if ( isplayer( hitent ) && isalive( hitent ) )
    {
        v_move = anglestoup( self.angles ) * 32;
        hitent setorigin( hitent.origin + v_move );
        
        /#
            iprintln( "<dev string:x24>" );
        #/
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x15b30caf, Offset: 0x2b1e
// Size: 0xbb
function private function_339b830137e4badc( var_e12f26713e8411c0, var_e97a4f4962bc3f25 )
{
    var_7c00f823b7c297d4 = get_channeler_slot( var_e97a4f4962bc3f25 );
    var_b2f8e5c576d3e25f = getnodearray( string( "forge_dynamic_traversal_" + var_7c00f823b7c297d4 ), #script_noteworthy );
    
    foreach ( node in var_b2f8e5c576d3e25f )
    {
        function_30dc1efdafe7681e( node, var_e12f26713e8411c0 );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x8180811c, Offset: 0x2be1
// Size: 0x2ec
function private function_136351ae2c66058f()
{
    if ( !isdefined( zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", #"hash_87c25a640efbd1c9" ) ) )
    {
        bitmask = 0;
        
        for ( i = 0; i <= 4 ; i++ )
        {
            bitmask |= 1 << i;
        }
        
        zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", #"hash_87c25a640efbd1c9", bitmask );
    }
    
    level.zm_scarab_mq.var_2a106eed0f98b74b = [];
    
    foreach ( s_seal in utility::getstructarray( "nexus_platform_seal" ) )
    {
        scr_seal = spawnscriptable( %"zm_sat_scarab_forge_seal", s_seal.origin, s_seal.angles );
        scr_seal.var_8ff12f2d202531c5 = s_seal.script_noteworthy;
        scr_seal.var_8293dcbfaa9d666e = level.zm_scarab_mq.a_rings[ int( s_seal.script_noteworthy ) - 1 ];
        scr_seal scriptablesetparententity( scr_seal.var_8293dcbfaa9d666e, s_seal.origin - scr_seal.var_8293dcbfaa9d666e.origin, s_seal.angles - scr_seal.var_8293dcbfaa9d666e.angles );
        
        if ( function_d32e94a4b84c30a5( scr_seal.var_8ff12f2d202531c5, #"hash_87c25a640efbd1c9" ) )
        {
            scr_seal setscriptablepartstate( "health", "ignore_damage" );
            scr_seal setscriptablepartstate( "base", "off" );
        }
        else
        {
            level.zm_scarab_mq.var_2a106eed0f98b74b[ level.zm_scarab_mq.var_2a106eed0f98b74b.size ] = scr_seal;
        }
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            scr_seal.obj_holder = utility::spawn_model( "tag_origin", scr_seal.origin );
            scr_seal.obj_holder linkto( scr_seal.var_8293dcbfaa9d666e );
            scr_seal.obj_holder.var_8ff12f2d202531c5 = scr_seal.var_8ff12f2d202531c5;
            
            if ( !isdefined( level.zm_scarab_mq.var_bd0720171f444fbe ) )
            {
                level.zm_scarab_mq.var_bd0720171f444fbe = [];
            }
            
            level.zm_scarab_mq.var_bd0720171f444fbe[ level.zm_scarab_mq.var_bd0720171f444fbe.size ] = scr_seal.obj_holder;
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x1f6a9942, Offset: 0x2ed5
// Size: 0x25d
function private function_8b4797f558d2183()
{
    level.zm_scarab_mq.var_d38c1e11055bbed4 = [];
    
    foreach ( s_lever in utility::getstructarray( "nexus_platform_lever" ) )
    {
        scr_lever = spawn_single_lever( s_lever );
        var_8293dcbfaa9d666e = level.zm_scarab_mq.a_rings[ int( s_lever.script_noteworthy ) - 1 ];
        scr_lever scriptablesetparententity( var_8293dcbfaa9d666e, scr_lever.origin - var_8293dcbfaa9d666e.origin, scr_lever.angles - var_8293dcbfaa9d666e.angles );
        scr_lever.var_961af44f6619c00e linkto( var_8293dcbfaa9d666e );
        scr_lever.var_961af44f6619c00e.e_parent_ring = var_8293dcbfaa9d666e;
        scr_lever.var_8ff12f2d202531c5 = s_lever.script_noteworthy;
        level.zm_scarab_mq.var_d38c1e11055bbed4[ level.zm_scarab_mq.var_d38c1e11055bbed4.size ] = scr_lever;
        
        if ( function_d32e94a4b84c30a5( scr_lever.var_8ff12f2d202531c5, #"hash_87c25a640efbd1c9" ) )
        {
            scr_lever setscriptablepartstate( "forge_usable_lever", "on" );
            scr_lever setscriptablepartstate( "ping", "on" );
            level utility::flag_set( "unsealed_lever" + scr_lever.var_8ff12f2d202531c5 );
        }
        
        /#
            if ( getdvarint( @"hash_d62ffa0adc14adc7", 0 ) >= 2 )
            {
                scr_lever setscriptablepartstate( "<dev string:x4d>", "<dev string:x60>" );
                scr_lever setscriptablepartstate( "<dev string:x63>", "<dev string:x60>" );
            }
        #/
    }
    
    s_lever = utility::getstruct( "forgeo_reo_lever" );
    level.zm_scarab_mq.var_df4a9f862b20305f = spawn_single_lever( s_lever, 1 );
    level.zm_scarab_mq.var_df4a9f862b20305f.script_id = "forgeo_reo_lever";
    scriptable::scriptable_addusedcallbackbypart( "forge_usable_lever", &function_b73a7a66b64dd480 );
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x7bbeecf5, Offset: 0x313a
// Size: 0xe8
function private spawn_single_lever( s_lever, var_50eb5fee4315cf79 = 0 )
{
    var_961af44f6619c00e = utility::spawn_model( %"hash_226174984f70b8ea", s_lever.origin, s_lever.angles );
    v_offset = anglestoforward( var_961af44f6619c00e.angles ) * 12;
    scr_lever = spawnscriptable( %"hash_5c199b5a575f874d", s_lever.origin + v_offset, s_lever.angles );
    scr_lever.var_961af44f6619c00e = var_961af44f6619c00e;
    scr_lever.var_8ff12f2d202531c5 = s_lever.script_noteworthy;
    
    if ( var_50eb5fee4315cf79 )
    {
        scr_lever setscriptablepartstate( "forge_usable_lever", "on" );
        scr_lever setscriptablepartstate( "ping", "on" );
    }
    
    return scr_lever;
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xe5bce401, Offset: 0x322b
// Size: 0x2a
function private setup_start_symbols( b_skipped, b_restored )
{
    level thread function_45c243607a8be9cb();
    level utility::flag_wait( "sh_symbols_start" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xafea326b, Offset: 0x325d
// Size: 0x11c
function private function_45c243607a8be9cb()
{
    level endon( #"sh_symbols_start" );
    level utility::flag_wait( "scriptables_ready" );
    var_6fdd2f80be44e1bf = getent( "zm_scarab_roof_debris", #targetname );
    
    if ( var_6fdd2f80be44e1bf )
    {
        var_6fdd2f80be44e1bf forcenetfieldhighlod( 1 );
        var_6fdd2f80be44e1bf setcandamage( 1 );
    }
    
    while ( var_6fdd2f80be44e1bf )
    {
        var_6fdd2f80be44e1bf waittill( #"damage", idamage, eattacker );
        
        if ( isplayer( eattacker ) )
        {
            break;
        }
    }
    
    foreach ( player in level.players )
    {
        player playsoundtoplayer( "evt_zm_scarab_mq_twins_success_stinger", player );
    }
    
    /#
        iprintlnbold( "<dev string:x68>" );
    #/
    
    level utility::flag_set( "sh_symbols_start" );
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x24c705b5, Offset: 0x3381
// Size: 0x86
function private function_56909fcbf4dda6be( vpoint, vdir )
{
    level utility::flag_wait( "scriptables_ready" );
    var_6fdd2f80be44e1bf = getent( "zm_scarab_roof_debris", #targetname );
    var_6fdd2f80be44e1bf setscriptablepartstate( "fx", "glow" );
    
    if ( !isdefined( vpoint ) )
    {
        vpoint = var_6fdd2f80be44e1bf.origin;
    }
    
    if ( !isdefined( vdir ) )
    {
        vdir = anglestoforward( var_6fdd2f80be44e1bf.angles );
    }
    
    var_6fdd2f80be44e1bf physicslaunchserver( vpoint, vdir * 10 );
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x6bf607ba, Offset: 0x340f
// Size: 0x2a
function private cleanup_start_symbols( b_skipped, b_restored )
{
    level utility::flag_set( "sh_symbols_start" );
    level thread function_56909fcbf4dda6be();
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x8881d6b0, Offset: 0x3441
// Size: 0x2a
function private setup_solve_symbols( b_skipped, b_restored )
{
    level thread spawn_symbols();
    level utility::flag_wait( "sh_symbols_solved" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xbb9300ac, Offset: 0x3473
// Size: 0x1a6
function private function_66daaab5047dbcd6()
{
    zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "power_on" );
    
    if ( level utility::flag( "symbols_data_restored" ) )
    {
        return;
    }
    
    var_a6e34b8329a36652 = 0;
    
    for ( i = 1; i <= 4 ; i++ )
    {
        var_29c208b3e77aa7c0 = hashcat( #"hash_d9d74e223909d38a", i );
        var_69ef8081866461f4 = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", var_29c208b3e77aa7c0 );
        var_a793ddb7210696b4 = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", hashcat( var_29c208b3e77aa7c0, "_success" ) );
        
        if ( var_69ef8081866461f4 || var_a793ddb7210696b4 )
        {
            foreach ( scriptable in level.zm_scarab_mq.a_symbols )
            {
                if ( scriptable.script_noteworthy == string( var_69ef8081866461f4 ) )
                {
                    function_28d923d8767aa2f5( scriptable, i );
                    break;
                }
                
                if ( scriptable.script_noteworthy == string( var_a793ddb7210696b4 ) )
                {
                    var_a6e34b8329a36652++;
                    function_28d923d8767aa2f5( scriptable, i, 1 );
                    break;
                }
            }
        }
    }
    
    if ( var_a6e34b8329a36652 == 4 )
    {
        level utility::flag_set( "sh_symbols_solved" );
        level thread function_50b4f6548ab7c3b4();
    }
    
    level thread function_e0d5285bfbad4e41();
    level utility::flag_set( "symbols_data_restored" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xedeb5b20, Offset: 0x3621
// Size: 0x28e
function private spawn_symbols()
{
    level endon( #"hash_e9164b5b9263e652" );
    
    if ( !isdefined( level.zm_scarab_mq.a_symbols ) )
    {
        level.zm_scarab_mq.a_symbols = getentitylessscriptablearray( "scriptable_zm_sat_scarab_safehouse_symbols", #classname );
    }
    
    if ( !isdefined( level.zm_scarab_mq.var_de54a609d267d14a ) )
    {
        level.zm_scarab_mq.var_de54a609d267d14a = [];
    }
    
    if ( !isdefined( level.zm_scarab_mq.var_6ad7ad9449083487 ) )
    {
        level.zm_scarab_mq.var_6ad7ad9449083487 = [ 1, 2, 3, 4 ];
    }
    
    function_66daaab5047dbcd6();
    var_3320b864e80b817d = zm_utility::get_round_number();
    
    for ( n_skip = undefined; true ; n_skip = undefined )
    {
        level utility::flag_waitopen( "sh_symbols_maxed" );
        
        if ( getdvarint( @"hash_c4bf10548bb81070", 0 ) )
        {
            waitframe();
            
            if ( level.zm_scarab_mq.var_de54a609d267d14a.size == 4 )
            {
                level waittill( #"on_round_end" );
            }
        }
        else
        {
            if ( !n_skip )
            {
                var_3320b864e80b817d = zm_utility::get_round_number();
                level waittill( #"on_round_end" );
            }
            
            var_49f7091014d2c59 = zm_utility::get_round_number();
            n_round_diff = var_49f7091014d2c59 - var_3320b864e80b817d;
            
            if ( n_round_diff > 1 )
            {
                n_skip = 1;
                var_3320b864e80b817d++;
            }
            else
            {
                n_skip = undefined;
            }
        }
        
        if ( function_41160421ad0382b().size > 0 )
        {
            continue;
        }
        
        if ( level.zm_scarab_mq.var_de54a609d267d14a.size < 4 )
        {
            if ( !level.zm_scarab_mq.a_symbols.size )
            {
                level.zm_scarab_mq.a_symbols = getentitylessscriptablearray( "scriptable_zm_sat_scarab_safehouse_symbols", #classname );
            }
            
            scr_symbol = utility::array_random( level.zm_scarab_mq.a_symbols );
            function_28d923d8767aa2f5( scr_symbol );
            var_29c208b3e77aa7c0 = hashcat( #"hash_d9d74e223909d38a", scr_symbol.var_7e2f5dd7a65a6e53 );
            zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", var_29c208b3e77aa7c0, int( scr_symbol.script_noteworthy ) );
            
            if ( zm_save::is_save_load_enabled() )
            {
                zm_save::save_session( 0 );
                
                if ( zm_save::is_autosave_enabled() )
                {
                    zm_save::commit_session( 1 );
                }
            }
            
            level thread function_e0d5285bfbad4e41();
            
            if ( level utility::flag( "sh_symbols_maxed" ) )
            {
            }
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 3, eflags: 0x4
// Checksum 0xfb302d17, Offset: 0x38b7
// Size: 0x2fa
function private function_28d923d8767aa2f5( scr_symbol, var_7e2f5dd7a65a6e53, var_929a3ff666a99dac )
{
    level.zm_scarab_mq.a_symbols = arrayremove( level.zm_scarab_mq.a_symbols, scr_symbol );
    
    if ( !var_929a3ff666a99dac )
    {
        level.zm_scarab_mq.var_de54a609d267d14a = arraycombineunique( level.zm_scarab_mq.var_de54a609d267d14a, [ scr_symbol ] );
    }
    
    if ( var_7e2f5dd7a65a6e53 )
    {
        scr_symbol.var_7e2f5dd7a65a6e53 = var_7e2f5dd7a65a6e53;
    }
    else
    {
        scr_symbol.var_7e2f5dd7a65a6e53 = level.zm_scarab_mq.var_de54a609d267d14a.size;
    }
    
    if ( scr_symbol.var_7e2f5dd7a65a6e53 == 4 || level.zm_scarab_mq.var_de54a609d267d14a.size == 4 )
    {
        if ( !level utility::flag( "sh_symbols_maxed" ) )
        {
            level utility::flag_set( "sh_symbols_maxed" );
            level thread function_84d70739aabab4a4();
        }
    }
    
    str_note_visual = hashcat( #"note_visual", scr_symbol.var_7e2f5dd7a65a6e53 );
    n_note = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", str_note_visual );
    
    if ( !isdefined( n_note ) )
    {
        function_788a3937abf269f();
        n_note = utility::array_random( level.zm_scarab_mq.var_6ad7ad9449083487 );
        zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", str_note_visual, n_note );
    }
    else
    {
        /#
            iprintln( "<dev string:x74>" + scr_symbol.var_7e2f5dd7a65a6e53 + "<dev string:x94>" + n_note );
        #/
    }
    
    assert( isint( n_note ) );
    level.zm_scarab_mq.var_6ad7ad9449083487 = arrayremove( level.zm_scarab_mq.var_6ad7ad9449083487, n_note );
    scr_symbol.n_note = n_note;
    scr_symbol.var_436fc13baa7377d8 = 1;
    str_state = "note" + n_note;
    scr_symbol setscriptablepartstate( "vfx", str_state );
    
    if ( !var_929a3ff666a99dac )
    {
        scr_symbol zm_damage::register_scriptable_damage_callback( &symbol_damaged, 1 );
        scr_symbol setscriptablepartstate( "base", "on" );
        return;
    }
    
    scr_symbol setscriptablepartstate( "base", "success" );
    var_f1874aa7f305ed6e = hashcat( #"hash_d9d74e223909d38a", scr_symbol.var_7e2f5dd7a65a6e53, "_success" );
    zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", var_f1874aa7f305ed6e, int( scr_symbol.script_noteworthy ) );
    
    if ( !isdefined( level.zm_scarab_mq.var_e294dddfbc492de7 ) )
    {
        level.zm_scarab_mq.var_e294dddfbc492de7 = [];
    }
    
    level.zm_scarab_mq.var_e294dddfbc492de7[ level.zm_scarab_mq.var_e294dddfbc492de7.size ] = scr_symbol;
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xe748f8c0, Offset: 0x3bb9
// Size: 0x13a
function private function_788a3937abf269f()
{
    level.zm_scarab_mq.var_6ad7ad9449083487 = function_5713d46873b29625( level.zm_scarab_mq.var_6ad7ad9449083487 );
    
    if ( !level.zm_scarab_mq.var_6ad7ad9449083487.size )
    {
        a_used_notes = [];
        
        foreach ( var_825261bedb0065e6 in level.zm_scarab_mq.var_de54a609d267d14a )
        {
            if ( isdefined( var_825261bedb0065e6.n_note ) )
            {
                a_used_notes[ a_used_notes.size ] = var_825261bedb0065e6.n_note;
            }
        }
        
        for ( i = 1; i <= 4 ; i++ )
        {
            if ( !arraycontains( a_used_notes, i ) )
            {
                level.zm_scarab_mq.var_6ad7ad9449083487[ level.zm_scarab_mq.var_6ad7ad9449083487.size ] = i;
            }
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x58a93515, Offset: 0x3cfb
// Size: 0x319
function private symbol_damaged( params )
{
    profilestart();
    
    if ( !isplayer( params.eattacker ) )
    {
        profilestop();
        return -1;
    }
    
    if ( !level utility::flag( "sh_symbols_maxed" ) && zm_quest::function_b0a5181ebe7bb905() )
    {
        profilestop();
        return -1;
    }
    
    zm_damage::function_c31f9d79d5ceb7ec( &symbol_damaged, 0 );
    self setscriptablepartstate( "debug", "off" );
    
    if ( !level utility::flag( "sh_symbols_maxed" ) || self.var_7e2f5dd7a65a6e53 != 1 || !( zm_exfil_sat::is_exfil_available() || zm_quest::function_b0a5181ebe7bb905() ) )
    {
        self setscriptablepartstate( "base", "fail" );
        function_9e6b451ddb57365e();
        level utility::flag_clear( "sh_symbols_maxed" );
        level utility::flag_set( "sh_end_twins_scene" );
        function_2385483d11cbe05();
        level thread play_banter_once( #"symbol_disappear", "sym_dis_vo", [ params.eattacker ], #"bc_flavor_player_negative", 1 );
    }
    else
    {
        self setscriptablepartstate( "base", "success" );
        
        if ( !isdefined( level.zm_scarab_mq.var_e294dddfbc492de7 ) )
        {
            level.zm_scarab_mq.var_e294dddfbc492de7 = [];
        }
        
        level.zm_scarab_mq.var_e294dddfbc492de7[ level.zm_scarab_mq.var_e294dddfbc492de7.size ] = self;
    }
    
    level.zm_scarab_mq.var_de54a609d267d14a = arrayremove( level.zm_scarab_mq.var_de54a609d267d14a, self );
    var_29c208b3e77aa7c0 = hashcat( #"hash_d9d74e223909d38a", self.var_7e2f5dd7a65a6e53 );
    zm_quest::function_6265be8d0549e1b1( #"scarab_mq", var_29c208b3e77aa7c0 );
    
    if ( level utility::flag( "sh_symbols_maxed" ) && level.zm_scarab_mq.var_de54a609d267d14a.size == 0 )
    {
        level utility::flag_set( "sh_symbols_solved" );
        level thread function_e0d5285bfbad4e41();
        level thread function_7038fcc5de4df138( hashcat( #"twins_safehouse", randomintrange( 1, 5 ) ), "tw_sfh_vo", undefined, 1 );
        level thread function_50b4f6548ab7c3b4();
        function_305ebaed7ee9b820();
    }
    else
    {
        function_81df0569d267ce4e();
        
        foreach ( var_825261bedb0065e6 in level.zm_scarab_mq.var_de54a609d267d14a )
        {
            if ( var_825261bedb0065e6.var_7e2f5dd7a65a6e53 > self.var_7e2f5dd7a65a6e53 )
            {
                var_825261bedb0065e6.var_7e2f5dd7a65a6e53--;
            }
        }
        
        function_dcb4801c31481aea();
    }
    
    function_a3ff094fededb8c6();
    
    if ( !level utility::flag( "sh_symbols_solved" ) )
    {
        level thread function_e0d5285bfbad4e41();
    }
    
    self.var_7e2f5dd7a65a6e53 = undefined;
    profilestop();
    return params.idamage;
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xe6c2ce1, Offset: 0x401e
// Size: 0x245
function private function_a3ff094fededb8c6()
{
    for ( i = 1; i <= 4 ; i++ )
    {
        str_note_save = hashcat( #"note_visual", i );
        zm_quest::function_6265be8d0549e1b1( #"scarab_mq", str_note_save );
    }
    
    var_9a2273e29261d44f = [];
    
    foreach ( var_825261bedb0065e6 in level.zm_scarab_mq.var_de54a609d267d14a )
    {
        str_note_save = hashcat( #"note_visual", var_825261bedb0065e6.var_7e2f5dd7a65a6e53 );
        zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", str_note_save, var_825261bedb0065e6.n_note );
        level.zm_scarab_mq.var_6ad7ad9449083487 = arrayremove( level.zm_scarab_mq.var_6ad7ad9449083487, var_825261bedb0065e6.n_note );
        var_9a2273e29261d44f[ var_9a2273e29261d44f.size ] = var_825261bedb0065e6.var_7e2f5dd7a65a6e53;
    }
    
    foreach ( var_825261bedb0065e6 in level.zm_scarab_mq.var_e294dddfbc492de7 )
    {
        for ( i = 1; i <= 4 ; i++ )
        {
            if ( arraycontains( var_9a2273e29261d44f, i ) )
            {
                continue;
            }
            
            var_76d7992070af76ae = i;
            break;
        }
        
        zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", hashcat( #"hash_d9d74e223909d38a", var_76d7992070af76ae, "_success" ), int( var_825261bedb0065e6.script_noteworthy ) );
        zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", hashcat( #"note_visual", var_76d7992070af76ae ), var_825261bedb0065e6.n_note );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x47fa3fbc, Offset: 0x426b
// Size: 0x20d
function private function_2385483d11cbe05()
{
    level.zm_scarab_mq.var_e294dddfbc492de7 = [];
    var_13b5a6f5c0727db7 = [];
    
    foreach ( var_825261bedb0065e6 in getentitylessscriptablearray( "scriptable_zm_sat_scarab_safehouse_symbols", #classname ) )
    {
        if ( var_825261bedb0065e6 != self && var_825261bedb0065e6 getscriptablepartstate( "base" ) == "success" )
        {
            var_825261bedb0065e6 setscriptablepartstate( "base", "fail" );
            level.zm_scarab_mq.var_6ad7ad9449083487 = arraycombineunique( level.zm_scarab_mq.var_6ad7ad9449083487, [ var_825261bedb0065e6.n_note ] );
            var_13b5a6f5c0727db7[ var_13b5a6f5c0727db7.size ] = var_825261bedb0065e6;
        }
    }
    
    for ( i = 1; i <= 4 ; i++ )
    {
        zm_quest::function_6265be8d0549e1b1( #"scarab_mq", hashcat( #"hash_d9d74e223909d38a", i, "_success" ) );
        
        foreach ( var_825261bedb0065e6 in var_13b5a6f5c0727db7 )
        {
            if ( var_825261bedb0065e6.n_note && zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", hashcat( #"note_visual", i ) ) == var_825261bedb0065e6.n_note )
            {
                zm_quest::function_6265be8d0549e1b1( #"scarab_mq", hashcat( #"note_visual", i ) );
                var_825261bedb0065e6.n_note = undefined;
            }
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xcc33141d, Offset: 0x4480
// Size: 0x79
function private function_9e6b451ddb57365e()
{
    level.zm_scarab_mq.var_6ad7ad9449083487 = arraycombineunique( level.zm_scarab_mq.var_6ad7ad9449083487, [ self.n_note ] );
    str_note_save = hashcat( #"note_visual", self.var_7e2f5dd7a65a6e53 );
    zm_quest::function_6265be8d0549e1b1( #"scarab_mq", str_note_save );
    self.n_note = undefined;
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x90888b82, Offset: 0x4501
// Size: 0xb0
function private function_81df0569d267ce4e()
{
    foreach ( var_825261bedb0065e6 in level.zm_scarab_mq.var_de54a609d267d14a )
    {
        var_29c208b3e77aa7c0 = hashcat( #"hash_d9d74e223909d38a", var_825261bedb0065e6.var_7e2f5dd7a65a6e53 );
        zm_quest::function_6265be8d0549e1b1( #"scarab_mq", var_29c208b3e77aa7c0 );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x15d6bbe3, Offset: 0x45b9
// Size: 0xbf
function private function_dcb4801c31481aea()
{
    foreach ( var_825261bedb0065e6 in level.zm_scarab_mq.var_de54a609d267d14a )
    {
        var_29c208b3e77aa7c0 = hashcat( #"hash_d9d74e223909d38a", var_825261bedb0065e6.var_7e2f5dd7a65a6e53 );
        zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", var_29c208b3e77aa7c0, int( var_825261bedb0065e6.script_noteworthy ) );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x28c60af2, Offset: 0x4680
// Size: 0xad
function private function_84d70739aabab4a4()
{
    level thread function_7038fcc5de4df138( hashcat( #"twins_appear", randomintrange( 1, 4 ) ), "tw_app_vo", undefined, 5 );
    level utility::flag_clear( "sh_end_twins_scene" );
    s_scene = utility::getstruct( "tw_scene_inside" );
    playfx( level._effect[ "tw_scene_spawn" ], s_scene.origin );
    level.var_2a41d34c821d2467 = utility::play_loopsound_in_space( #"hash_a456bccbb571f6e3", s_scene.origin );
    s_scene.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_standing";
    s_scene thread scene::play( undefined, "idle_holding_hands" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0xc
// Checksum 0xffabd9dc, Offset: 0x4735
// Size: 0x236
function private function_bdfe82a43bd1c0f9()
{
    self notify( #"hash_4a1f579b17bcba30" );
    self endon( #"hash_4a1f579b17bcba30" );
    a_ents = scene::get_entities();
    
    foreach ( ent in a_ents )
    {
        ent.var_2fc3a5fb762afb6e = 1;
        ent setscriptablepartstate( "reveal", "reveal_in" );
    }
    
    if ( self.script_scenescriptbundle == "sat_cin_zm_vig_fly_sisters_standing" )
    {
        level utility::flag_wait_any( "sh_symbols_solved", "sh_end_twins_scene" );
        var_92feb2a5c5e183b8 = 1;
    }
    else
    {
        level utility::flag_wait_any( "tommy_want_wingy", "sh_end_twins_scene" );
    }
    
    foreach ( ent in a_ents )
    {
        ent setscriptablepartstate( "reveal", "reveal_out" );
    }
    
    playfx( level._effect[ "tw_scene_spawn" ], self.origin );
    
    if ( level.var_2a41d34c821d2467 )
    {
        level.var_2a41d34c821d2467 delete();
    }
    
    wait 3;
    scene::stop();
    
    if ( !var_92feb2a5c5e183b8 || level utility::flag( "sh_end_twins_scene" ) )
    {
        return;
    }
    
    s_scene = utility::getstruct( "tw_scene_outside" );
    playfx( level._effect[ "tw_scene_spawn" ], s_scene.origin );
    level.var_2a41d34c821d2467 = utility::play_loopsound_in_space( #"hash_992414e558bf007d", s_scene.origin );
    s_scene.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_dance";
    s_scene thread scene::play( undefined, "dance_idle" );
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x5765e642, Offset: 0x4973
// Size: 0x15
function private cleanup_solve_symbols( b_skipped, b_restored )
{
    
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xc9d5c8b9, Offset: 0x4990
// Size: 0x2f
function private function_6f2a1957e766ffea( b_skipped, b_restored )
{
    level utility::flag_clear( "bad_mama_jamma" );
    level utility::flag_wait( "chicky_bicky_bambam" );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x7c42c99f, Offset: 0x49c7
// Size: 0x55
function private function_6f53095e3dd6ddc1( params )
{
    if ( level utility::flag( "sh_symbols_solved" ) )
    {
        level utility::flag_set( "pickle_takes_tomato" );
        level utility::flag_set( "poppa_bop_boopy" );
        level.var_519fe94beba8d651 = &function_af2100bd9d9f70b3;
        level callback::remove( "zm_exfil_started", &function_6f53095e3dd6ddc1 );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0x8fa6f483, Offset: 0x4a24
// Size: 0x6c
function function_305ebaed7ee9b820()
{
    level.s_zm_exfil.interaction_settings[ "available" ].description = &"hash_dcdcfed6fb5ef6e";
    level.s_zm_exfil.interaction_settings[ "exit" ].description = &"hash_9e1bb4649d7f87";
    zm_exfil_sat::function_24b07fa711a26fa9( #"hash_ab7aac7a31e5b4ae" );
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0xb02957b5, Offset: 0x4a98
// Size: 0x63
function function_d23fa1633710dbb9()
{
    level.s_zm_exfil.interaction_settings[ "available" ].description = &"shared_hintstrings/exfil_start_use_sat";
    level.s_zm_exfil.interaction_settings[ "exit" ].description = &"shared_hintstrings/exfil_start_enter_portal";
    zm_exfil_sat::function_24b07fa711a26fa9();
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xa99fa4d8, Offset: 0x4b03
// Size: 0x18b
function private function_50b4f6548ab7c3b4()
{
    level utility::flag_clear( "tommy_want_wingy" );
    level utility::flag_set( "use_custom_exfil_vfx" );
    level callback::add( "zm_exfil_started", &function_6f53095e3dd6ddc1 );
    level utility::flag_wait( "exfil_active" );
    level thread function_4feedb2729840388();
    function_1610a3edf83ac662();
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"exfil" );
    level callback::remove( "zm_exfil_started", &function_6f53095e3dd6ddc1 );
    level utility::flag_clear( "sh_symbols_solved" );
    level utility::flag_clear( "sh_symbols_maxed" );
    level utility::flag_clear( "pickle_takes_tomato" );
    level utility::flag_clear( "use_custom_exfil_vfx" );
    function_2385483d11cbe05();
    function_a3ff094fededb8c6();
    waitframe();
    
    if ( level utility::flag( "tommy_want_wingy" ) )
    {
        level thread function_e0d5285bfbad4e41();
        level thread function_e9e1eaf652f006b1();
        level utility::flag_wait( "bad_mama_jamma" );
        level thread function_88183d17cd1118b9();
        
        do
        {
            wait 1;
        }
        while ( function_41160421ad0382b().size );
        
        foreach ( player in level.players )
        {
            player utility::ent_flag_clear( "player_sh_etp_done" );
            player val::reset( "sh_com_ev", "round_spawning_ignore_player" );
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xcd9ea80, Offset: 0x4c96
// Size: 0x37
function private function_1610a3edf83ac662()
{
    while ( !level utility::flag( "tommy_want_wingy" ) && level utility::flag( "exfil_active" ) )
    {
        level utility::waittill_any( "tommy_want_wingy", "exfil_active" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x1c806c04, Offset: 0x4cd5
// Size: 0x2d
function private function_4feedb2729840388()
{
    level utility::flag_waitopen( "exfil_active" );
    level.var_519fe94beba8d651 = undefined;
    level utility::flag_clear( "use_custom_exfil_vfx" );
    function_d23fa1633710dbb9();
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x732f3108, Offset: 0x4d0a
// Size: 0x273
function private function_af2100bd9d9f70b3( player )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    if ( player.sessionstate == "spectator" || player.sessionstate == "intermission" )
    {
        return;
    }
    
    if ( player utility::ent_flag( "sat_exfil_completed" ) || player utility::ent_flag( "player_sh_etp_done" ) )
    {
        return;
    }
    
    level utility::flag_set( "tommy_want_wingy" );
    player zm_exfil_sat::function_9515b3c2d065c86b();
    player utility::ent_flag_clear( "showed_exfil_hud_splash" );
    player utility::ent_flag_clear( "show_exfil_hud" );
    player utility::ent_flag_clear( "showed_reach_exfil_hud" );
    player utility::ent_flag_clear( "showed_kill_hvt_hud" );
    player val::set( "sh_com_ev", "round_spawning_ignore_player", 1 );
    
    if ( player.var_819dfee5ff9a56d6 )
    {
        player thread zm_ncfdpedestal::force_end_grapple();
    }
    
    if ( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 )
    {
        objidpoolmanager::objective_playermask_hidefrom( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466, player );
    }
    
    a_respawn_points = utility::getstructarray( "sh_tp_spec" );
    index = player getentitynumber();
    var_99064b9592368173 = a_respawn_points[ index ];
    
    if ( player utility::ent_flag( "consume_fruit_scene_in_prog" ) || player utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) )
    {
        player utility::ent_flag_waitopen_any( "consume_fruit_scene_in_prog" );
        level zm_sat_scarab_ww_quest::function_d5ddbca43097a0ff( var_99064b9592368173 );
    }
    else
    {
        player.var_c6d48777fc700ed8 = 1;
        player utility::function_32b24db3127bff40( "playerTeleport", "scarabOn" );
        player playlocalsound( #"hash_651dd2ec6e75b7bd" );
        playworldsound( player.origin + ( 0, 0, 75 ), #"hash_1084c5d54855b552" );
        player setorigin( var_99064b9592368173.origin );
        player setplayerangles( var_99064b9592368173.angles );
        playworldsound( var_99064b9592368173.origin + ( 0, 0, 75 ), #"hash_1084c5d54855b552" );
    }
    
    player utility::ent_flag_set( "player_sh_etp_done" );
    level utility::flag_set( "chicky_bicky_bambam" );
    level utility::flag_set( "bad_mama_jamma" );
    player thread function_182d6cf58ba9ceac();
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xb894fdf4, Offset: 0x4f85
// Size: 0x1b
function private function_182d6cf58ba9ceac()
{
    self endon( #"death" );
    wait 3;
    self.var_c6d48777fc700ed8 = undefined;
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xa430a513, Offset: 0x4fa8
// Size: 0x132
function private function_41160421ad0382b()
{
    a_players = [];
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        foreach ( var_4cdafb4532dd9de4 in [ "zone_safehouse_interior_upper_bedroom_1", "zone_safehouse_interior_upper_bedroom_2", "zone_safehouse_interior_lower", "zone_safehouse_interior_upper", "zone_safehouse_exterior" ] )
        {
            if ( player zone_manager::is_touching_zone( var_4cdafb4532dd9de4 ) )
            {
                a_players[ a_players.size ] = player;
            }
        }
    }
    
    return a_players;
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x2d314194, Offset: 0x50e3
// Size: 0x17a
function private function_88183d17cd1118b9()
{
    level utility::waittill_any_timeout( 15, "sh_combat_go" );
    level thread zm_music::start_zone_music_watcher( "safehouse_combat", [ "zone_safehouse_interior_upper_bedroom_1", "zone_safehouse_interior_upper_bedroom_2", "zone_safehouse_interior_lower", "zone_safehouse_interior_upper", "zone_safehouse_exterior" ], #"safehouse_combat" );
    level utility::flag_clear( "redo_safehouse_guidance" );
    safehouse_combat_event( [ "zone_safehouse_interior_upper_bedroom_1", "zone_safehouse_interior_upper_bedroom_2", "zone_safehouse_interior_lower", "zone_safehouse_interior_upper", "zone_safehouse_exterior" ] );
    level utility::flag_set( "sh_combat_done" );
    level thread zm_music::function_e9fd14ede793ef0d( "safehouse_combat" );
    level thread function_e0d5285bfbad4e41();
    level thread function_2e41f5dfd839ae29();
    
    if ( level utility::flag( "exfil_window_active" ) )
    {
        level utility::flag_clear( "exfil_window_active" );
    }
    
    wait 1;
    level thread function_32d920119d2d9e06();
    wait 20;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        wait 10;
    }
    
    foreach ( player in level.players )
    {
        player val::reset( "sh_com_ev", "round_spawning_ignore_player" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x7c122362, Offset: 0x5265
// Size: 0x7d
function private function_2e41f5dfd839ae29()
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        if ( function_bb944bb3079c8286() )
        {
            level utility::flag_wait( "wanna_wingo_eh" );
        }
        else
        {
            level utility::flag_wait( "sh_combat_done" );
            level utility::flag_clear( "redo_phone_answered" );
            level utility::flag_set( "redo_safehouse_guidance" );
        }
    }
    
    level thread zm_sat_scarab_phone::function_8d579bd589a6afea();
    level thread function_e0d5285bfbad4e41();
    level waittill( #"phone_answered" );
    level utility::flag_set( "redo_phone_answered" );
    level thread function_e0d5285bfbad4e41();
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xc25358b3, Offset: 0x52ea
// Size: 0x6b
function private function_e9e1eaf652f006b1()
{
    level thread function_7038fcc5de4df138( hashcat( #"twins_symbol_success", randomintrange( 1, 4 ) ), "tw_sys_vo", undefined, 1 );
    s_scene = utility::getstruct( "tw_scene_success" );
    s_scene.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_chalk_both";
    scene::add_scene_func( s_scene, &function_568002bbf54dabbd, "callback_play" );
    s_scene scene::play();
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xa888052c, Offset: 0x535d
// Size: 0x347
function private function_568002bbf54dabbd()
{
    playfx( level._effect[ "tw_scene_spawn" ], self.origin );
    a_ents = scene::get_entities();
    
    foreach ( ent in a_ents )
    {
        ent.var_2fc3a5fb762afb6e = 1;
        ent setscriptablepartstate( "reveal", "reveal_in" );
    }
    
    trigger = spawn( "trigger_radius", self.origin, 0, 256, 64 );
    
    while ( !level utility::flag( "sh_combat_go" ) )
    {
        trigger waittill( #"trigger", player );
        
        if ( isplayer( player ) )
        {
            break;
        }
    }
    
    trigger delete();
    
    foreach ( ent in a_ents )
    {
        ent setscriptablepartstate( "reveal", "reveal_out" );
    }
    
    wait 2.5;
    playfx( level._effect[ "tw_scene_spawn" ], self.origin );
    scene::stop();
    
    if ( level.var_2a41d34c821d2467 )
    {
        level.var_2a41d34c821d2467 delete();
    }
    
    foreach ( ent in a_ents )
    {
        ent delete();
    }
    
    if ( !isdefined( level.zm_scarab_mq.var_10f4671cb3ccf1be ) )
    {
        level.zm_scarab_mq.var_10f4671cb3ccf1be = 0;
    }
    else if ( level.zm_scarab_mq.var_10f4671cb3ccf1be >= level.players.size )
    {
        wait 5;
        level utility::flag_set( "sh_combat_go" );
        return;
    }
    
    level.zm_scarab_mq.var_10f4671cb3ccf1be++;
    playfx( level._effect[ "tw_reward_spawn" ], self.origin );
    spawnoptions = common_item::function_bc5ff2958b71a708( self.origin );
    item = common_item::function_61c2c0251e742ffd( %"itemspawnentry:zm_t10_item_aether_crystal", 1, spawnoptions );
    level endon( #"sh_combat_go" );
    item waittill( #"death" );
    level thread play_banter_once( #"safehouse_pap", "sym_dis_vo", [ player ], #"hash_5212ed7ec42f115a" );
    level utility::flag_set( "sh_combat_go" );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x6ec8dc3d, Offset: 0x56ac
// Size: 0x21c
function private safehouse_combat_event( var_42497e720336895b )
{
    level utility::flag_set( "sh_combat_go" );
    level utility::flag_clear( "sh_drop_max_ammo" );
    level thread function_e0d5285bfbad4e41();
    level.zm_scarab_mq.var_a36bb529ae3e5a08 = [];
    var_3046be002fd6398 = zone_spawner::function_20c574a6ba7cc5c6( var_42497e720336895b, "zombie_shade" );
    var_d70d76bf718d7f50 = zone_spawner::function_20c574a6ba7cc5c6( var_42497e720336895b, "zombie_ghoul" );
    n_waves = 3;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        n_waves = 2;
    }
    
    /#
        n_waves = getdvarint( @"hash_c087c0659cc5e64d", n_waves );
    #/
    
    var_bc037a366edd1d10 = 1;
    n_ravagers = 8;
    
    for ( var_a82e1f2633bba9c = 1; var_a82e1f2633bba9c <= n_waves ; var_a82e1f2633bba9c++ )
    {
        var_3046be002fd6398 = arrayrandomize( var_3046be002fd6398 );
        
        for ( i = 0; i < n_ravagers ; i++ )
        {
            spawner = var_3046be002fd6398[ i ];
            
            if ( !spawner )
            {
                spawner = utility::array_random( var_3046be002fd6398 );
            }
            
            level thread function_b2f8e4e6b4fbeebe( spawner, "zombie_shade" );
            wait 0.25;
        }
        
        wait 5;
        var_d70d76bf718d7f50 = arrayrandomize( var_d70d76bf718d7f50 );
        
        for ( i = 0; i < var_bc037a366edd1d10 ; i++ )
        {
            spawner = var_d70d76bf718d7f50[ i ];
            
            if ( !spawner )
            {
                spawner = utility::array_random( var_d70d76bf718d7f50 );
            }
            
            level thread function_b2f8e4e6b4fbeebe( spawner, "zombie_ghoul", var_a82e1f2633bba9c );
            wait 1;
        }
        
        n_ravagers += function_41160421ad0382b().size;
        var_bc037a366edd1d10++;
        wait 10;
    }
    
    n_times_up = gettime() + utility::function_4b74c15943231980( 30 );
    
    do
    {
        wait 1;
        level.zm_scarab_mq.var_a36bb529ae3e5a08 = function_5713d46873b29625( level.zm_scarab_mq.var_a36bb529ae3e5a08 );
        level.zm_scarab_mq.var_a36bb529ae3e5a08 = function_46f9072493651dc9( level.zm_scarab_mq.var_a36bb529ae3e5a08 );
    }
    while ( level.zm_scarab_mq.var_a36bb529ae3e5a08.size > 0 && gettime() < n_times_up );
    
    level utility::flag_clear( "sh_combat_go" );
}

// Namespace zm_sat_scarab_mq
// Params 3, eflags: 0x4
// Checksum 0x2fe52ade, Offset: 0x58d0
// Size: 0xd4
function private function_b2f8e4e6b4fbeebe( spawner, var_ff75798b22968d50, var_909487a97fce4608 )
{
    ai = agent_manager::spawn_agent( var_ff75798b22968d50, spawner.origin, spawner.angles );
    
    if ( !ai )
    {
        return;
    }
    
    ai zm_utility::setup_quest_ai();
    
    if ( var_ff75798b22968d50 == "zombie_shade" )
    {
        ai.var_d26d1e568f55c0e4 = 1;
    }
    
    level.zm_scarab_mq.var_a36bb529ae3e5a08 = arraycombineunique( level.zm_scarab_mq.var_a36bb529ae3e5a08, [ ai ] );
    
    if ( var_ff75798b22968d50 == "zombie_ghoul" && var_909487a97fce4608 == 3 )
    {
        ai callback::add( "on_zombie_ai_killed", &function_32d920119d2d9e06 );
    }
    
    ai agent_spawner::function_ce10e453e7f7bb8e( spawner );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x2fc944ef, Offset: 0x59ac
// Size: 0x128
function private function_32d920119d2d9e06( params )
{
    if ( level utility::flag( "sh_drop_max_ammo" ) )
    {
        return;
    }
    
    level.zm_scarab_mq.var_a36bb529ae3e5a08 = function_5713d46873b29625( level.zm_scarab_mq.var_a36bb529ae3e5a08 );
    level.zm_scarab_mq.var_a36bb529ae3e5a08 = function_46f9072493651dc9( level.zm_scarab_mq.var_a36bb529ae3e5a08 );
    
    if ( level.zm_scarab_mq.var_a36bb529ae3e5a08.size < 1 || level.zm_scarab_mq.var_a36bb529ae3e5a08.size == 1 && level.zm_scarab_mq.var_a36bb529ae3e5a08[ 0 ] == self )
    {
        level utility::flag_set( "sh_drop_max_ammo" );
        
        if ( !isai( self ) || self.b_in_spawn_closet )
        {
            v_drop = utility::getstruct( "tw_scene_success" ).origin;
        }
        else
        {
            v_drop = self.origin;
        }
        
        level thread powerups::force_powerup_drop( "full_ammo", v_drop, "quest" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x1d9d6c79, Offset: 0x5adc
// Size: 0x2e
function private function_3915abc11dddc885()
{
    level utility::flag_wait( "begin_round_logic" );
    level utility::flag_wait( "initial_player_spawned" );
    
    if ( function_41160421ad0382b().size )
    {
        level thread function_2e41f5dfd839ae29();
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x2ecb89a7, Offset: 0x5b12
// Size: 0xb1
function private function_f2ca61ca9764938b( b_skipped, b_restored )
{
    level utility::flag_set( "chicky_bicky_bambam" );
    level utility::flag_set( "poppa_bop_boopy" );
    level thread function_52708afcf151d781();
    level callback::add( "on_agent_spawned", &function_76fe1eedc502b68c );
    level callback::add( #"on_ai_killed", &function_c2d1b5c595b03786, { #trigger:getnoentvolumearray( "trig_forge_main", #targetname )[ 0 ] } );
    zm_sat_scarab_phone::function_e31fd04f8a18de90();
    
    if ( level.var_2a41d34c821d2467 )
    {
        level.var_2a41d34c821d2467 delete();
    }
    
    if ( b_restored || b_skipped )
    {
        level thread function_3915abc11dddc885();
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xc8f1280a, Offset: 0x5bcb
// Size: 0x43
function private setup_find_upgrade( b_skipped, b_restored )
{
    level.zm_scarab_mq.var_d05c101ef52472fa zm_damage::register_scriptable_damage_callback( &function_f9499f4a1111e405, 1 );
    level utility::flag_wait( "wanna_wingo_eh" );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xddf33c5e, Offset: 0x5c16
// Size: 0x2d
function private function_f9499f4a1111e405( params )
{
    if ( weap_scarabww::function_3a1514a781375202( params ) )
    {
        level thread drop_eye( self, params );
    }
    
    return params.idamage;
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x624a3f12, Offset: 0x5c4c
// Size: 0x27c
function private drop_eye( scr_eye, cyclone_params )
{
    level endon( #"game_ended" );
    e_cyclone = cyclone_params.einflictor;
    e_player = cyclone_params.eattacker;
    var_264a09acc59facf0 = e_player.origin;
    scr_eye setscriptablepartstate( "health", "ignore_damage" );
    scr_eye zm_damage::function_c31f9d79d5ceb7ec( &function_f9499f4a1111e405, 0 );
    s_end_cyclone = utility::getstruct( "safehouse_ambi_t" );
    level utility::flag_set( "hueh_ho_hiya" );
    
    if ( !e_cyclone )
    {
        level thread function_3a848e0b5b120023( var_264a09acc59facf0, s_end_cyclone.origin + ( 0, 0, 72 ) );
        level thread function_e0d5285bfbad4e41();
        return;
    }
    
    e_cyclone.var_cfb11de0d6c22510 = 1;
    waitframe();
    var_8a8aa5cafc8f73be = 1.5;
    var_a186d6448bd89507 = 1;
    var_739dfdc119196047 = 1.75;
    e_cyclone moveto( scr_eye.origin, var_8a8aa5cafc8f73be );
    wait var_8a8aa5cafc8f73be;
    scr_eye.e_mover = utility::spawn_model( "tag_origin", scr_eye.origin, scr_eye.angles );
    scr_eye scriptablesetparententity( scr_eye.e_mover, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    scr_eye.e_mover thread utility::follow_spiral( 3, 12, ( 0, 0, 1 ), 64, var_a186d6448bd89507 + var_739dfdc119196047, e_cyclone, 3 );
    scr_eye.e_mover rotateby( ( 720, 150, 360 ), var_a186d6448bd89507 + var_739dfdc119196047 );
    wait var_a186d6448bd89507;
    e_cyclone moveto( s_end_cyclone.origin, var_739dfdc119196047 );
    wait var_739dfdc119196047;
    
    if ( e_cyclone )
    {
        playworldsound( e_cyclone.origin + ( 0, 0, 75 ), #"hash_f59d17e393281a03" );
        e_cyclone utility::function_7c10ea82c1e305b8( "cyclone", "out_pap" );
        e_cyclone utility::delaycall( 2, &delete );
    }
    
    function_3a848e0b5b120023( var_264a09acc59facf0, scr_eye.origin );
    
    if ( scr_eye.e_mover )
    {
        scr_eye.e_mover delete();
    }
    
    if ( scr_eye )
    {
        scr_eye freescriptable();
    }
    
    wait 1;
    level thread function_e0d5285bfbad4e41();
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xdcba6605, Offset: 0x5ed0
// Size: 0xe5
function private function_3a848e0b5b120023( var_efed17415279c75a, var_c319499aa3853093 )
{
    v_ground = getgroundposition( var_efed17415279c75a, 1 );
    v_drop_pos = v_ground + ( 0, 0, 5 );
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( v_drop_pos, var_c319499aa3853093 );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.var_9161cf0784b6951d = 1;
    level.zm_scarab_mq.var_1b004718c0efb9be = common_item::function_61c2c0251e742ffd( %"hash_1f703d826612b19", undefined, spawnoptions );
    info = { #item:level.zm_scarab_mq.var_1b004718c0efb9be };
    info.info = info;
    level callback::add( #"player_item_pickup", &function_c86e5fd5e1ce400f, info );
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x8042b223, Offset: 0x5fbd
// Size: 0xb8
function private function_c86e5fd5e1ce400f( params, info )
{
    if ( params.item == info.item || params.itembundlename == %"hash_1f703d826612b19" )
    {
        level utility::flag_set( "wanna_wingo_eh" );
        level zm_quest::show_splash_item_picked_up( #"scarab_misc", #"forge_1", 1, self );
        level callback::remove( #"player_item_pickup", &function_c86e5fd5e1ce400f, info.info );
        level thread play_banter_once( #"find_eye", "fin_aye_vo", [ self ], #"hash_5212ed7ec42f115a" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x5dc7b91a, Offset: 0x607d
// Size: 0xd1
function private cleanup_find_upgrade( b_skipped, b_restored )
{
    level utility::flag_set( "hueh_ho_hiya" );
    level utility::flag_set( "wanna_wingo_eh" );
    level utility::flag_set( "sat_ww_scarab_papd" );
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "sh_combat_done" );
    }
    
    level.var_3c874d3f031f6c50 = 1;
    level notify( #"hash_e9164b5b9263e652" );
    level zm_quest::function_98432f89334662d5( #"scarab_misc", 1 );
    level zm_quest::function_b57dfe9625966b0b( #"scarab_misc", 0, #"forge_1", 1, 1 );
    level zm_quest::function_44fe3dcaa8005357();
    level callback::add( #"hash_234602ce81ae619b", &function_660c7a8837bf677d );
    level callback::add( #"hash_db23ebf23acc8885", &function_84d4d612ebe5b7f7 );
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xae9289c9, Offset: 0x6156
// Size: 0x2a
function private setup_upgrade_pedestal( b_skipped, b_restored )
{
    level thread function_e0d5285bfbad4e41();
    level utility::flag_wait( "party_pants_pico" );
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xd8112dd3, Offset: 0x6188
// Size: 0x132
function private function_c29ef060264b0a64( final_origin, player )
{
    self endon( #"death" );
    player_origin = player.origin ?? final_origin;
    eye_origin = self.origin;
    eye_angles = self.angles;
    
    if ( !isdefined( level.var_851d59fc0145cbf0 ) )
    {
        level.var_851d59fc0145cbf0 = spawn( "script_model", final_origin );
        level.var_851d59fc0145cbf0 setmodel( "tag_origin" );
        level.var_851d59fc0145cbf0 moveto( final_origin, 0.5, 0.5 );
    }
    else
    {
        level.var_851d59fc0145cbf0 moveto( final_origin, 0.5, 0.5 );
    }
    
    wait 1;
    self setscriptablepartstate( "base", "upgraded" );
    angles_to_player = vectortoangles( player_origin - eye_origin );
    var_45ad5b627b21e31 = ( eye_angles[ 0 ], angles_to_player[ 1 ], eye_angles[ 2 ] );
    level.var_851d59fc0145cbf0 rotateto( var_45ad5b627b21e31, 0.5, 0, 0 );
    wait 0.5;
    
    if ( self )
    {
        thread zm_ncfdpedestal::function_a67361ffee16b320();
    }
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x3419c13, Offset: 0x62c2
// Size: 0x43c
function private function_660c7a8837bf677d( params )
{
    level.var_3c874d3f031f6c50 = undefined;
    pedestal_interact = params.scriptable;
    
    if ( !pedestal_interact )
    {
        level utility::flag_wait( "ncfds_spawned" );
        var_7c00f823b7c297d4 = params.var_872cda73afffcfb8;
        
        foreach ( scriptable in level.ncfd_pedestals )
        {
            if ( int( scriptable.interact.script_id ) == var_7c00f823b7c297d4 )
            {
                if ( !isdefined( level.var_cb500ca89b62b266 ) )
                {
                    scr_eye = spawnscriptable( %"hash_1b0e4bdaf4d184c9", scriptable.interact.origin, scriptable.angles );
                    level.var_cb500ca89b62b266 = scr_eye;
                }
                
                scriptable.interact.var_c62a3e81dd2e88bd = 1;
                scriptable.var_c62a3e81dd2e88bd = 1;
                scriptable.vfx_off.var_c62a3e81dd2e88bd = 1;
                scriptable.vfx.var_c62a3e81dd2e88bd = 1;
                pedestal_interact = scriptable.interact;
                break;
            }
        }
        
        foreach ( player in level.players )
        {
            foreach ( vfx in level.var_2c4ae363d9399fc4 )
            {
                vfx function_d6a7b7ef13a57f38( player );
            }
        }
        
        level.var_cb500ca89b62b266 setscriptablepartstate( "base", "upgraded" );
    }
    
    if ( !isdefined( level.var_cb500ca89b62b266 ) )
    {
        scr_eye = spawnscriptable( %"hash_1b0e4bdaf4d184c9", pedestal_interact.origin, pedestal_interact.angles );
        level.var_cb500ca89b62b266 = scr_eye;
    }
    
    final_origin = pedestal_interact.origin + ( 0, 0, 0 );
    level.var_cb500ca89b62b266.pedestal_interact = pedestal_interact;
    playworldsound( pedestal_interact.origin + ( 0, 0, 25 ), #"hash_e057382250705d90" );
    level.var_cb500ca89b62b266.pedestal_interact.pedestal.vfx setscriptablepartstate( "icon", "active_upgrade" );
    level.var_cb500ca89b62b266 function_c29ef060264b0a64( final_origin, params.player );
    zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", #"hash_be8c8ce0f6aea2c4", int( pedestal_interact.script_id ) );
    level zm_quest::function_b57dfe9625966b0b( #"scarab_misc", 0, #"forge_1", 0, 1 );
    wait 1;
    playrumbleonposition( "artillery_rumble_light", pedestal_interact.origin );
    earthquake( 0.2, 1.5, pedestal_interact.origin, 1200 );
    level utility::flag_set( "party_pants_pico" );
    level thread play_banter_once( #"upgrade_pedestal", "up_ped_vo", [ params.player ], #"hash_5212ed7ec42f115a" );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xabc00d0e, Offset: 0x6706
// Size: 0x291
function private function_84d4d612ebe5b7f7( params )
{
    if ( params.scriptable.type != %"hash_1b0e4bdaf4d184c9" )
    {
        return;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() && !level utility::flag( "mq_tmp_guidance_go" ) )
    {
        return;
    }
    
    if ( level.var_cb500ca89b62b266.pedestal_interact.pedestal.vfx )
    {
        level.var_cb500ca89b62b266.pedestal_interact.pedestal.vfx setscriptablepartstate( "icon", "active" );
    }
    
    v_move = self getcentroid();
    zm_quest::function_6265be8d0549e1b1( #"scarab_mq", #"hash_be8c8ce0f6aea2c4" );
    scr_eye = params.scriptable;
    scr_eye utility::scriptable_clearparententity();
    level.var_851d59fc0145cbf0 notify( #"end_player_watch" );
    scr_eye.pedestal_interact.var_c62a3e81dd2e88bd = undefined;
    scr_eye.pedestal_interact.pedestal.vfx.var_c62a3e81dd2e88bd = undefined;
    scr_eye.pedestal_interact.pedestal.vfx_off.var_c62a3e81dd2e88bd = undefined;
    scr_eye.pedestal_interact = undefined;
    scr_eye setscriptablepartstate( "grapple", "off" );
    
    if ( !scr_eye.e_mover )
    {
        scr_eye.e_mover = utility::spawn_model( "tag_origin", scr_eye.origin, scr_eye.angles );
    }
    
    scr_eye scriptablesetparententity( scr_eye.e_mover );
    n_move_time = distance( scr_eye.e_mover.origin, v_move ) / 500;
    scr_eye.e_mover moveto( v_move, n_move_time );
    wait n_move_time;
    
    if ( scr_eye.e_mover )
    {
        scr_eye.e_mover delete();
    }
    
    if ( scr_eye )
    {
        scr_eye freescriptable();
    }
    
    level.var_cb500ca89b62b266 = undefined;
    level zm_quest::show_splash_item_picked_up( #"scarab_misc", #"forge_1", 1, self );
    level zm_quest::function_b57dfe9625966b0b( #"scarab_misc", 0, #"forge_1", 1, 1 );
    level.var_3c874d3f031f6c50 = 1;
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xba9c1ae3, Offset: 0x699f
// Size: 0x97
function private cleanup_upgrade_pedestal( b_skipped, b_restored )
{
    level utility::flag_set( "party_pants_pico" );
    level thread setup_sealed_panels( b_restored );
    scriptable::scriptable_adddamagedcallback( &function_d5eff97086e41da5 );
    
    if ( b_restored )
    {
        var_872cda73afffcfb8 = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", #"hash_be8c8ce0f6aea2c4" );
        
        if ( isdefined( var_872cda73afffcfb8 ) )
        {
            level thread function_660c7a8837bf677d( { #var_872cda73afffcfb8:var_872cda73afffcfb8 } );
        }
        
        return;
    }
    
    if ( b_skipped )
    {
        level thread function_660c7a8837bf677d( { #var_872cda73afffcfb8:1 } );
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x801c02af, Offset: 0x6a3e
// Size: 0x22
function private setup_clear_gears( b_skipped, b_restored )
{
    level utility::flag_wait( "tiki_taco_time" );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xefa1faa9, Offset: 0x6a68
// Size: 0x6ff
function private setup_sealed_panels( b_save_restored )
{
    level.zm_scarab_mq utility::ent_flag_wait( "mq_quest_init_done" );
    
    foreach ( seal in level.zm_scarab_mq.var_2a106eed0f98b74b )
    {
        seal setscriptablepartstate( "grapple", "on" );
    }
    
    level.zm_scarab_mq.a_webs = [];
    level.zm_scarab_mq.a_panel_seals = [];
    aibundle = getscriptbundle( "zombieaisettings:settings_zombie_loom" );
    aisettings = getscriptbundle( aibundle.var_394d3c5e6fa40c50 );
    cocoon_data = { #var_117ffe14504a5d0d:aisettings.var_117ffe14504a5d0d / 100, #cocoonduration:5, #var_7e3f71d4e5078658:1, #cocoonmodel:aisettings.cocoonmodel, #var_659578f5e8d63be4:"loom_cocoon_activate", #var_4016a2314b839e98:aisettings.var_4016a2314b839e98, #var_21ad7d10138bed0a:aisettings.var_21ad7d10138bed0a, #var_10ff74dbc3145263:aisettings.var_10ff74dbc3145263 };
    currentround = zm_utility::get_round_number();
    var_633489ee645e852b = int( namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", currentround ) );
    a_panels = getentarray( "forge_sealed_panel", #targetname );
    
    foreach ( var_1af8bf945e6e471c in a_panels )
    {
        var_de6c93d7f32ef644 = utility::getstructarray( var_1af8bf945e6e471c.target );
        
        foreach ( s_cocoon in var_de6c93d7f32ef644 )
        {
            cocoon_data.cocoonduration = 5 + randomfloat( 4 );
            mdl_cocoon = zombie_loom_cocoon::spawn_cocoon( s_cocoon.origin, s_cocoon.angles, cocoon_data, var_633489ee645e852b );
            
            if ( !isdefined( var_1af8bf945e6e471c.a_webs ) )
            {
                var_1af8bf945e6e471c.a_webs = [];
            }
            
            var_1af8bf945e6e471c.a_webs[ var_1af8bf945e6e471c.a_webs.size ] = mdl_cocoon;
            level.zm_scarab_mq.a_webs[ level.zm_scarab_mq.a_webs.size ] = mdl_cocoon;
        }
        
        a_targets = getentitylessscriptablearray( var_1af8bf945e6e471c.target, #targetname );
        
        foreach ( target in a_targets )
        {
            if ( target.type == %"zm_sat_scarab_forge_seal" )
            {
                if ( b_save_restored )
                {
                    var_c603fefd86005802 = function_d32e94a4b84c30a5( target.script_noteworthy, #"hash_e95eb8492b771f78" );
                }
                
                if ( !istrue( var_c603fefd86005802 ) )
                {
                    target setscriptablepartstate( "grapple", "on" );
                    target.var_1af8bf945e6e471c = var_1af8bf945e6e471c;
                    
                    if ( !isdefined( var_1af8bf945e6e471c.a_seals ) )
                    {
                        var_1af8bf945e6e471c.a_seals = [];
                    }
                    
                    var_1af8bf945e6e471c.a_seals[ var_1af8bf945e6e471c.a_seals.size ] = target;
                }
                else
                {
                    target setscriptablepartstate( "base", "off" );
                    target setscriptablepartstate( "health", "ignore_damage" );
                }
                
                level.zm_scarab_mq.a_panel_seals[ int( target.script_noteworthy ) ] = target;
                continue;
            }
            
            if ( b_save_restored )
            {
                b_web_off = function_d32e94a4b84c30a5( target.script_noteworthy, #"hash_8030592f25657848" );
            }
            
            if ( !istrue( b_web_off ) )
            {
                if ( !isdefined( var_1af8bf945e6e471c.a_webs ) )
                {
                    var_1af8bf945e6e471c.a_webs = [];
                }
                
                var_1af8bf945e6e471c.a_webs[ var_1af8bf945e6e471c.a_webs.size ] = target;
                level.zm_scarab_mq.a_webs[ level.zm_scarab_mq.a_webs.size ] = target;
                target.var_1af8bf945e6e471c = var_1af8bf945e6e471c;
                target.n_hit_tracking = 0;
                target.var_436fc13baa7377d8 = 1;
                target.elementalweakness[ "fire" ] = 1;
                target setscriptablepartstate( "base", "on" );
                target zm_damage::register_scriptable_damage_callback( &function_e631a80fffe959a3, 1 );
                continue;
            }
            
            target setscriptablepartstate( "base", "off" );
            target setscriptablepartstate( "health", "ignore_damage" );
        }
        
        if ( !var_1af8bf945e6e471c.a_seals )
        {
            var_1af8bf945e6e471c thread function_26521cf5c5dfe949( b_save_restored );
        }
    }
    
    if ( !isdefined( zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", #"hash_e95eb8492b771f78" ) ) )
    {
        bitmask = 0;
        
        for ( i = 0; i < level.zm_scarab_mq.a_panel_seals.size ; i++ )
        {
            bitmask |= 1 << i;
        }
        
        zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", #"hash_e95eb8492b771f78", bitmask );
    }
    
    if ( !isdefined( zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", #"hash_8030592f25657848" ) ) )
    {
        bitmask = 0;
        
        for ( i = 0; i < level.zm_scarab_mq.a_webs.size ; i++ )
        {
            bitmask |= 1 << i;
        }
        
        zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", #"hash_8030592f25657848", bitmask );
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread function_f1f181895831d365( a_panels );
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xacfbdf61, Offset: 0x716f
// Size: 0xda
function private function_c1e9dfea56215227( var_1af8bf945e6e471c, var_e12f26713e8411c0 )
{
    var_7c00f823b7c297d4 = strtok( var_1af8bf945e6e471c.target, "fspt_" )[ 0 ];
    s_loc = utility::getstruct( "forge_eng_tr_block_" + var_7c00f823b7c297d4 );
    var_b2f8e5c576d3e25f = getnodesinradius( s_loc.origin, 72, 0 );
    
    foreach ( node in var_b2f8e5c576d3e25f )
    {
        function_30dc1efdafe7681e( node, var_e12f26713e8411c0 );
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x329382a0, Offset: 0x7251
// Size: 0x40, Type: bool
function private function_d32e94a4b84c30a5( n_index, str_key )
{
    bitmask = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", str_key );
    return ( bitmask & 1 << int( n_index ) ) == 0;
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x6c8b3ac0, Offset: 0x729a
// Size: 0x54
function private function_cafc24dfffbfc7fa( n_index, str_key )
{
    bitmask = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", str_key );
    bitmask &= ~( 1 << int( n_index ) );
    zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", str_key, bitmask );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x338ce24e, Offset: 0x72f6
// Size: 0x3d8
function private function_f1f181895831d365( a_panels )
{
    wait 0.1;
    level.zm_scarab_mq.a_panel_guidance = [];
    level.zm_scarab_mq.var_b156e78e204b43 = [];
    var_6481a266d2017be3 = [];
    var_7c00f823b7c297d4 = 1;
    
    for ( i = 0; i < a_panels.size ; i++ )
    {
        foreach ( var_1af8bf945e6e471c in a_panels )
        {
            str_id = strtok( var_1af8bf945e6e471c.target, "fspt_" )[ 0 ];
            
            if ( int( str_id ) == var_7c00f823b7c297d4 )
            {
                var_6481a266d2017be3[ var_6481a266d2017be3.size ] = var_1af8bf945e6e471c;
                var_7c00f823b7c297d4++;
                break;
            }
        }
    }
    
    foreach ( var_1af8bf945e6e471c in var_6481a266d2017be3 )
    {
        level.zm_scarab_mq.a_panel_guidance = var_1af8bf945e6e471c.a_seals;
        
        foreach ( seal in level.zm_scarab_mq.a_panel_guidance )
        {
            if ( seal getscriptablepartstate( "base" ) != "on" )
            {
                level.zm_scarab_mq.a_panel_guidance = arrayremove( level.zm_scarab_mq.a_panel_guidance, seal );
            }
        }
        
        level thread function_e0d5285bfbad4e41();
        utility::array_wait( level.zm_scarab_mq.a_panel_guidance, "seal_removed" );
    }
    
    waitframe();
    var_3282e3242b42e98a = arrayreverse( var_6481a266d2017be3 );
    
    foreach ( var_1af8bf945e6e471c in var_3282e3242b42e98a )
    {
        foreach ( web in var_1af8bf945e6e471c.a_webs )
        {
            if ( isdefined( web ) && !isent( web ) && web getscriptablepartstate( "base" ) == "on" )
            {
                level.zm_scarab_mq.var_b156e78e204b43[ level.zm_scarab_mq.var_b156e78e204b43.size ] = web;
            }
        }
    }
    
    level thread function_e0d5285bfbad4e41();
    level utility::flag_wait( "tiki_taco_time" );
    level.zm_scarab_mq.a_panel_guidance = undefined;
    level.zm_scarab_mq.var_b156e78e204b43 = undefined;
}

// Namespace zm_sat_scarab_mq
// Params 11, eflags: 0x4
// Checksum 0x8be36059, Offset: 0x76d6
// Size: 0x368
function private function_d5eff97086e41da5( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !eattacker.var_32e68c63905a0787 )
    {
        return;
    }
    
    if ( instance.type == %"zm_sat_scarab_forge_seal" && einflictor.equipmentref && einflictor.equipmentref == "equip_grappling_hook_upgraded" )
    {
        eattacker damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
        instance setscriptablepartstate( "base", "hit" );
        instance setscriptablepartstate( "health", "ignore_damage" );
        instance thread function_1f996d374ae162ca( vdir, vpoint );
        instance notify( #"seal_removed" );
        player_idx = eattacker getplayerclientnum();
        level thread play_banter_once( "str_play_bc_generic_vo_instead", "rem_sel_vo_" + player_idx, [ eattacker ], #"bc_flavor_player_positive" );
        
        if ( instance.var_1af8bf945e6e471c )
        {
            instance.var_1af8bf945e6e471c.a_seals = arrayremove( instance.var_1af8bf945e6e471c.a_seals, instance );
            
            if ( level.zm_scarab_mq.a_panel_guidance )
            {
                level.zm_scarab_mq.a_panel_guidance = arrayremove( level.zm_scarab_mq.a_panel_guidance, instance );
            }
            
            level thread function_e0d5285bfbad4e41();
            function_cafc24dfffbfc7fa( instance.script_noteworthy, #"hash_e95eb8492b771f78" );
            
            if ( instance.var_1af8bf945e6e471c.a_seals.size == 0 )
            {
                instance.var_1af8bf945e6e471c thread function_26521cf5c5dfe949();
                level thread play_banter_once( #"remove_panel", "rem_pan_vo", [ eattacker ], undefined, 1 );
            }
            
            return;
        }
        
        level utility::flag_set( "unsealed_lever" + instance.var_8ff12f2d202531c5 );
        function_cafc24dfffbfc7fa( instance.var_8ff12f2d202531c5, #"hash_87c25a640efbd1c9" );
        level.zm_scarab_mq.var_2a106eed0f98b74b = arrayremove( level.zm_scarab_mq.var_2a106eed0f98b74b, instance );
        level thread function_e0d5285bfbad4e41();
        
        foreach ( scr_lever in level.zm_scarab_mq.var_d38c1e11055bbed4 )
        {
            if ( scr_lever.var_8ff12f2d202531c5 == instance.var_8ff12f2d202531c5 )
            {
                scr_lever setscriptablepartstate( "ping", "on" );
                break;
            }
        }
        
        if ( instance.obj_holder )
        {
            instance.obj_holder.var_8ff12f2d202531c5 = instance.var_8ff12f2d202531c5;
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x2e8a299b, Offset: 0x7a46
// Size: 0x1b5
function private function_1f996d374ae162ca( vdir, vpoint )
{
    var_ef97a4c343d57f38 = 1310;
    
    if ( self.var_1af8bf945e6e471c )
    {
        var_ef97a4c343d57f38 = 960;
    }
    
    mdl_seal = utility::spawn_model( "sat_zm_forge_seal", self.origin, self.angles );
    mdl_seal thread function_b2362b54d7211226();
    vforward = anglestoforward( mdl_seal.angles );
    mdl_seal moveto( mdl_seal.origin + vforward * 4, level.framedurationseconds );
    wait level.framedurationseconds;
    mdl_seal physicslaunchserver( vpoint, vdir * -420 );
    var_52bb832d79c4ff38 = mdl_seal.origin;
    
    do
    {
        wait 0.1;
        
        if ( mdl_seal )
        {
            var_52bb832d79c4ff38 = mdl_seal.origin;
            continue;
        }
        
        break;
    }
    while ( mdl_seal.origin[ 2 ] > var_ef97a4c343d57f38 );
    
    playworldsound( mdl_seal.origin ?? var_52bb832d79c4ff38, #"hash_b0db9950dffd9196" );
    
    if ( !mdl_seal )
    {
        return;
    }
    
    do
    {
        v_start = mdl_seal.origin;
        wait 0.2;
        v_new = mdl_seal.origin;
    }
    while ( mdl_seal && distancesquared( v_start, v_new ) > 0.1 );
    
    if ( mdl_seal && self.var_8293dcbfaa9d666e )
    {
        mdl_seal linkto( self.var_8293dcbfaa9d666e );
        
        if ( self.var_8293dcbfaa9d666e.targetname != "nexus_ring_1" )
        {
            mdl_seal.var_689ef52e5650ffbf = 1;
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x6b7178b0, Offset: 0x7c03
// Size: 0x24
function private function_b2362b54d7211226()
{
    self endon( #"death" );
    wait 5;
    
    if ( !self.var_689ef52e5650ffbf )
    {
        self delete();
    }
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x74852317, Offset: 0x7c2f
// Size: 0x108
function private function_26521cf5c5dfe949( b_save_restored )
{
    wait 0.2;
    self moveto( self.origin - ( 0, 0, 166 ), 1.2, 0.5 );
    self playsound( #"hash_7ad2c1d0fe7fa6da" );
    playrumbleonposition( "artillery_rumble_light", self.origin );
    thread function_1967a71ba82f1950();
    
    foreach ( mdl_cocoon in self.a_webs )
    {
        if ( isent( mdl_cocoon ) )
        {
            if ( b_save_restored )
            {
                mdl_cocoon delete();
                continue;
            }
            
            mdl_cocoon utility::ent_flag_set( "loom_cocoon_activate" );
        }
    }
    
    wait 1.2;
    function_c1e9dfea56215227( self, 1 );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xac9e9f4d, Offset: 0x7d3f
// Size: 0x42
function private function_1967a71ba82f1950()
{
    self endon( #"death" );
    wait 1.2;
    earthquake( 0.3, 0.75, self.origin, 1800 );
    playrumbleonposition( "artillery_rumble", self.origin );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xe60a0fa2, Offset: 0x7d89
// Size: 0x2fa, Type: bool
function private function_e631a80fffe959a3( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return false;
    }
    
    var_16680fe0ae17804c = utility::isexplosivedamage( params.smeansofdeath );
    var_16d9e23a1f2bd68a = weap_scarabww::function_3a1514a781375202( params.einflictor );
    var_6533c6f51a3333dd = damage::function_17032bfefd0f2bff( params.objweapon, params.smeansofdeath, params.eattacker ) || dragonsbreath::isdragonsbreathweapon( params.objweapon );
    
    if ( params.var_5e5a2456deacd236 != "fire" && !utility::isfiredamage( params.smeansofdeath ) && !utility::ismeleedamage( params.smeansofdeath ) && !var_16680fe0ae17804c && !var_16d9e23a1f2bd68a && !var_6533c6f51a3333dd )
    {
        return false;
    }
    
    if ( var_16680fe0ae17804c )
    {
        b_killing_blow = 1;
    }
    else
    {
        self.n_hit_tracking += 1;
        
        if ( var_16d9e23a1f2bd68a )
        {
            self.n_hit_tracking += 3;
        }
        
        if ( self.type == "zm_sat_scarab_forge_web_engine_1" || self.type == %"zm_sat_scarab_forge_web_engine_1" )
        {
            n_hit_req = 16;
        }
        else
        {
            n_hit_req = 8;
        }
        
        if ( self.n_hit_tracking < n_hit_req )
        {
            b_killing_blow = 0;
        }
    }
    
    if ( var_6533c6f51a3333dd )
    {
        element = "fire";
    }
    
    if ( !isdefined( params.objweapon ) )
    {
        params.objweapon = level.weaponnone;
    }
    
    if ( !isdefined( element ) )
    {
        element = zombie_damage::get_element( params.objweapon, params.eattacker, params.smeansofdeath );
    }
    
    namespace_9d8e359c3b1041e5::displaydamagenumber_sharedfunc( params.eattacker, self, "none", params.smeansofdeath, params.objweapon, int( params.idamage ), params.vpoint, 0, element, 0, 0 );
    
    if ( b_killing_blow == 0 )
    {
        return true;
    }
    
    self setscriptablepartstate( "base", "hit" );
    self setscriptablepartstate( "health", "ignore_damage" );
    self.var_4adbbc9bc3b00a42 = 1;
    function_cafc24dfffbfc7fa( self.script_noteworthy, #"hash_8030592f25657848" );
    zm_damage::function_c31f9d79d5ceb7ec( &function_e631a80fffe959a3, 0 );
    
    if ( level.zm_scarab_mq.var_b156e78e204b43 )
    {
        level.zm_scarab_mq.var_b156e78e204b43 = arrayremove( level.zm_scarab_mq.var_b156e78e204b43, self );
    }
    
    function_9b9c325cb8501fb0( self );
    function_7e3f9a68cc71bd7b( params.eattacker );
    level thread function_e0d5285bfbad4e41();
    return true;
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x8148a67, Offset: 0x808c
// Size: 0xae
function private function_9b9c325cb8501fb0( scriptable )
{
    foreach ( web in scriptable.var_1af8bf945e6e471c.a_webs )
    {
        if ( !web.var_4adbbc9bc3b00a42 )
        {
            return;
        }
    }
    
    activateworldevent( "we_sat_zm_scarab_webs_" + scriptable.script_noteworthy );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xf1af36d3, Offset: 0x8142
// Size: 0xfe
function private function_7e3f9a68cc71bd7b( player )
{
    foreach ( web in level.zm_scarab_mq.a_webs )
    {
        if ( isent( web ) )
        {
            function_55622a7e4f1d271d( web );
            continue;
        }
        
        if ( !web )
        {
            function_55622a7e4f1d271d( web );
            continue;
        }
        
        if ( web getscriptablepartstate( "base" ) == "on" )
        {
            return;
        }
        
        function_55622a7e4f1d271d( web );
    }
    
    level utility::flag_set( "tiki_taco_time" );
    level thread play_banter_once( #"clear_webs", "cl_we_vo", [ player ], #"bc_flavor_player_positive" );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x4e284928, Offset: 0x8248
// Size: 0x4f
function private function_55622a7e4f1d271d( web )
{
    if ( level.zm_scarab_mq.var_b156e78e204b43 )
    {
        level.zm_scarab_mq.var_b156e78e204b43 = arrayremove( level.zm_scarab_mq.var_b156e78e204b43, web );
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x6acb5d5, Offset: 0x829f
// Size: 0x40
function private cleanup_clear_gears( b_skipped, b_restored )
{
    level utility::flag_set( "tiki_taco_time" );
    
    /#
        if ( b_skipped && !b_restored )
        {
            level thread function_59ea1a623a1278cb( [ 1 ] );
        }
    #/
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x48669701, Offset: 0x82e7
// Size: 0x32
function private setup_restart_engine( b_skipped, b_restored )
{
    level thread function_e0d5285bfbad4e41();
    level thread wait_for_power_surge();
    level utility::flag_wait( "topo_loco_bogo" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x869b2b14, Offset: 0x8321
// Size: 0x5e
function private wait_for_power_surge()
{
    level endon( #"topo_loco_bogo" );
    
    while ( !level utility::flag( "topo_loco_bogo" ) )
    {
        level waittill( #"forgeo_reverseo" );
        
        if ( level utility::flag( "power_surge_active" ) && !level utility::flag( "forgeo_reverseo" ) )
        {
            break;
        }
    }
    
    level utility::flag_set( "topo_loco_bogo" );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xc5f753b1, Offset: 0x8387
// Size: 0x271
function private function_37b095b3381db574( b_restored )
{
    level utility::flag_set( "forge_rest_in_prog" );
    playworldsound( ( 3, -936, 1043 ), #"hash_957dab0f3cfa3409" );
    
    if ( level.scarab_pap_quest.var_9d15330b141fe52f )
    {
        level.scarab_pap_quest.var_9d15330b141fe52f setscriptablepartstate( "audio_mq", "forge_power_surge" );
    }
    
    earthquake( 0.25, 0.75, level.zm_scarab_mq.a_rings[ 1 ].origin, 4000 );
    playrumbleonposition( "artillery_rumble_heavy", level.zm_scarab_mq.a_rings[ 1 ].origin );
    var_e627d1619f1cfa8c = getentarray( "forge_engine_part", #targetname );
    
    foreach ( model in var_e627d1619f1cfa8c )
    {
        model setscriptablepartstate( "base", "on_" + model.script_noteworthy );
        model setscriptablepartstate( "vfx", "activate" );
    }
    
    if ( !b_restored )
    {
        wait 12;
    }
    
    level utility::flag_set( "forge_rest_big_shot" );
    earthquake( 0.4, 1.5, level.zm_scarab_mq.a_rings[ 1 ].origin, 4000 );
    playrumbleonposition( "artillery_rumble_heavy", level.zm_scarab_mq.a_rings[ 1 ].origin );
    level utility::flag_clear( "forge_rest_in_prog" );
    
    if ( !b_restored )
    {
        a_players = getplayersinradius( level.scarab_pap_quest.var_9d15330b141fe52f.origin, 1000 );
        a_players = a_players.size ? a_players : level.players;
        level thread play_banter_once( #"forge_start", "frg_st_vo", a_players, #"bc_flavor_player_positive", 3 );
    }
    
    level thread function_ca8db7d0047a4756( b_restored );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xe933ef6c, Offset: 0x8600
// Size: 0x13f
function private extend_forge_lever( lever )
{
    level utility::flag_set( "forge_lever_" + lever.var_8ff12f2d202531c5 + "_unparented" );
    lever.b_turning = 1;
    lever.var_961af44f6619c00e unlink();
    lever setscriptablepartstate( "forge_usable_lever", "on" );
    lever setscriptablepartstate( "lever_position_sfx", "off" );
    v_extend = anglestoforward( lever.var_961af44f6619c00e.angles ) * 7;
    v_move = lever.var_961af44f6619c00e.origin + v_extend;
    lever.var_961af44f6619c00e moveto( v_move, 0.5 );
    lever.var_961af44f6619c00e waittill( #"movedone" );
    lever.var_961af44f6619c00e linkto( lever.var_961af44f6619c00e.e_parent_ring );
    lever.b_turning = undefined;
    level utility::flag_clear( "forge_lever_" + lever.var_8ff12f2d202531c5 + "_unparented" );
    lever notify( #"extension_complete" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xe1e62b13, Offset: 0x8747
// Size: 0xeb
function private cleanup_forge_corpses()
{
    level utility::flag_wait( "forge_rest_big_shot" );
    wait 0.25;
    v_forge_center = level.zm_scarab_mq.a_rings[ 0 ].origin;
    var_847d084dec62c9ef = function_955f614470e71cb2( v_forge_center, 1024 );
    
    foreach ( corpse in var_847d084dec62c9ef )
    {
        if ( corpse.origin[ 2 ] >= 1300 )
        {
            corpse setscriptablepartstate( "reveal_death_red_glow", "reveal_death_red_glow" );
            corpse thread utility::delete_after_delay( 2 );
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xd97d668d, Offset: 0x883a
// Size: 0x51
function private function_c2d1b5c595b03786( params, s_info )
{
    if ( self.subclass != "dawg" )
    {
        return;
    }
    
    do
    {
        corpse = self getcorpseentity();
        waitframe();
    }
    while ( self && !corpse );
    
    if ( corpse )
    {
        corpse delete();
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xa23b8351, Offset: 0x8893
// Size: 0x83
function private function_de773f4ffa8c224d( params, s_info )
{
    if ( !issubstr( self.subclass, "zombie_base" ) && !issubstr( self.subclass, "zombie_loom" ) )
    {
        return;
    }
    
    if ( !self.var_ff03aca8518f1161 && !self.var_c906438bb56dd18e && ispointinvolume( self.origin, s_info.trigger ) )
    {
        namespace_b76ff2659823e89d::annihilate( 1 );
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x45edc4d7, Offset: 0x891e
// Size: 0x51
function private function_bc9677f9e7a5c45f( params, s_info )
{
    if ( issubstr( self.subclass, "dawg" ) && ispointinvolume( self.origin, s_info.trigger ) )
    {
        self.forceannihilate = 1;
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xd80e7b5, Offset: 0x8977
// Size: 0x1a8
function private cleanup_restart_engine( b_skipped, b_restored )
{
    level utility::flag_set( "topo_loco_bogo" );
    level callback::add( "on_zombie_ai_killed", &function_de773f4ffa8c224d, { #trigger:getnoentvolumearray( "trig_forge_main", #targetname )[ 0 ] } );
    level callback::add( "pre_killed_body_cloned", &function_bc9677f9e7a5c45f, { #trigger:getnoentvolumearray( "trig_forge_main", #targetname )[ 0 ] } );
    
    if ( !b_restored )
    {
        level.scarab_pap_quest.var_9d15330b141fe52f setscriptablepartstate( "fx_mq", "restart" );
        level thread cleanup_forge_corpses();
        
        if ( b_skipped )
        {
            level utility::flag_clear( "forgeo_reverseo" );
            level.zm_scarab_mq.var_df4a9f862b20305f setscriptablepartstate( "lever_position_sfx", "on" );
            level.zm_scarab_mq.var_df4a9f862b20305f.var_961af44f6619c00e rotateby( ( 0, 0, 90 ), 0.3 );
            function_cafc24dfffbfc7fa( 4, #"hash_87c25a640efbd1c9" );
        }
    }
    
    level thread function_37b095b3381db574( b_restored );
    
    if ( zm_quest::function_b0a5181ebe7bb905() && !b_restored )
    {
        level.zm_scarab_mq.n_enabled_ring = 0;
        
        if ( zm_save::is_save_load_enabled() )
        {
            function_314be45bcef2ff6e( 0, { #slot3:4, #slot2:3, #slot1:2 } );
            zm_save::save_session( 0 );
            
            if ( zm_save::is_autosave_enabled() )
            {
                zm_save::commit_session( 1 );
            }
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x628dc5c4, Offset: 0x8b27
// Size: 0x58
function private function_f094d1200e309814( b_skipped, b_restored )
{
    if ( b_skipped || b_restored )
    {
        level thread function_e0d5285bfbad4e41();
    }
    
    level thread astral_motes::function_716ebb0b24af874a();
    level utility::flag_wait_all( "sst_made_nice" + 4, "sst_made_nice" + 3, "sst_made_nice" + 1, "sst_made_nice" + 2 );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x80b0db4e, Offset: 0x8b87
// Size: 0x138
function private function_a6a33eab4fa1fb06()
{
    a_tiles = getentarray( "bf_lift_tile", #targetname );
    
    foreach ( mdl_tile in a_tiles )
    {
        mdl_tile thread function_9f3aaae885eec057();
    }
    
    while ( true )
    {
        level waittill( #"hash_a842878295492243" );
        var_762f5d19a53f7c0 = 1;
        
        foreach ( player in utility::get_alive_players( 0 ) )
        {
            if ( !player.var_6af5ae2769824a38 )
            {
                var_762f5d19a53f7c0 = undefined;
                break;
            }
        }
        
        if ( var_762f5d19a53f7c0 )
        {
            return;
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x591769af, Offset: 0x8cc7
// Size: 0x18f
function private function_9f3aaae885eec057()
{
    level endon( #"enter_boss_fight_go" );
    self hide();
    var_2fb361e60af77be9 = self.origin;
    v_up = self.origin + ( 0, 0, 2 );
    self moveto( v_up, 0.5 );
    self waittill( #"movedone" );
    thread tile_vfx();
    
    while ( self )
    {
        wait 0.1;
        
        foreach ( player in utility::get_alive_players( 0 ) )
        {
            if ( player && player istouching( self ) )
            {
                self moveto( var_2fb361e60af77be9, 0.5 );
                self waittill( #"movedone" );
                
                if ( player )
                {
                    player.var_6af5ae2769824a38 = self;
                }
                
                level notify( #"hash_a842878295492243" );
                
                if ( player )
                {
                    player playrumblelooponentity( "low_highfreq" );
                }
                
                while ( player && player istouching( self ) )
                {
                    waitframe();
                }
                
                if ( player )
                {
                    player stoprumble( "low_highfreq" );
                }
                
                if ( player )
                {
                    player.var_6af5ae2769824a38 = undefined;
                }
                
                self moveto( v_up, 0.5 );
                self waittill( #"movedone" );
                break;
            }
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0x863ea303, Offset: 0x8e5e
// Size: 0x93
function tile_vfx()
{
    self.sc_vfx = spawnscriptable( "zm_sat_scarab_mq_shadowsmith_spawn", self.origin, ( 0, 0, 0 ) );
    self.sc_vfx setscriptablepartstate( "visual", "elevator_tile_spawn" );
    wait 1;
    self.sc_vfx freescriptable();
    self.sc_vfx = spawnscriptable( "zm_sat_scarab_mq_shadowsmith_spawn", self.origin, ( 0, 0, 0 ) );
    self.sc_vfx setscriptablepartstate( "visual", "elevator_tile" );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xa8d62dfd, Offset: 0x8ef9
// Size: 0x1e5
function private do_forge_eruption( b_skipped )
{
    zm_round_spawning::pause_round_spawning( 1, "forge_eruption" );
    level thread function_abff053a2d0c7cf4();
    
    if ( b_skipped && !level utility::flag( "fo_ar_smas" ) )
    {
        function_2c992d8bbeb5344b();
    }
    
    level utility::flag_wait( "initial_player_spawned" );
    level utility::flag_wait( "papq_final_state_set" );
    function_ae4e63665a224e18();
    reset_gimbals( 0 );
    function_6d64d53cb450e847();
    level utility::flag_set( "disallow_power_surge" );
    level utility::flag_set( "gimbals_moving" );
    wait 7;
    function_2c23da40490c84f7();
    level notify( #"eruption_started" );
    zm_round_spawning::pause_round_spawning( 1, "forge_eruption" );
    
    if ( !level utility::flag( "enter_boss_fight_go" ) )
    {
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_a5359d9621eb4ef5" );
    }
    
    playworldsound( ( 3, -936, 1043 ), #"hash_397cdbc431805e24" );
    level thread function_d351da6394d1206a();
    level.scarab_pap_quest.var_9d15330b141fe52f setscriptablepartstate( "fx_mq", "erupt" );
    s_up = utility::getstruct( "forge_rings_up" );
    level.scarab_pap_quest.var_dbdff7ad02b59f6b moveto( s_up.origin, 9.5, 0.1 );
    level.scarab_pap_quest.var_dbdff8ad02b5a19e moveto( s_up.origin, 9.5, 0.1 );
    wait 9.5;
    
    if ( !b_skipped )
    {
        level thread function_8b7e907b65e651fd();
    }
    
    level utility::flag_set( "eruption_peaked" );
    level utility::flag_set( "gimbals_are_up" );
    level utility::flag_clear( "disallow_power_surge" );
    level utility::flag_clear( "gimbals_moving" );
    wait 40;
    zm_round_spawning::pause_round_spawning( 0, "forge_eruption" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x22f7f52e, Offset: 0x90e6
// Size: 0x5a
function private function_2c23da40490c84f7()
{
    level endon( #"enter_boss_fight_go" );
    trigger = getnoentvolumearray( "trig_forge_main", #targetname )[ 0 ];
    
    while ( trigger )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            break;
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x7e504adf, Offset: 0x9148
// Size: 0x1e
function private function_abff053a2d0c7cf4()
{
    level endon( #"eruption_started" );
    wait 35;
    zm_round_spawning::pause_round_spawning( 0, "forge_eruption" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xc75c9c0, Offset: 0x916e
// Size: 0x18b
function private function_d351da6394d1206a()
{
    v_quake = level.zm_scarab_mq.a_rings[ 0 ].origin;
    earthquake( 0.15, 9.5, v_quake, 4000 );
    
    foreach ( player in level.players )
    {
        player playrumblelooponentity( "damage_light" );
    }
    
    level utility::flag_wait( "eruption_peaked" );
    
    foreach ( player in level.players )
    {
        player stoprumble( "damage_light" );
    }
    
    earthquake( 0.35, 1.75, v_quake, 5000 );
    playrumbleonposition( "artillery_rumble_heavy", v_quake );
    wait 1.5;
    earthquake( 0.45, 3.5, v_quake, 6000 );
    playrumbleonposition( "artillery_rumble_heavy", v_quake );
    wait 1;
    level function_fc6ae894b579d37();
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x163f96f4, Offset: 0x9301
// Size: 0xd4
function private function_fc6ae894b579d37()
{
    foreach ( player in level.players )
    {
        if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_efe074ec11372361" ) )
        {
            player utility::callsharedfunc( #"scarab_rain", #"hash_efe074ec11372361" );
        }
    }
    
    level utility::flag_set( "pretty_rain_active" );
    level zm_sat_scarab_rb::function_2a311bb411c253bc();
    level callback::add( #"player_spawned", &function_6ee529c6185fa736 );
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0x108c78f5, Offset: 0x93dd
// Size: 0x53
function function_8b7e907b65e651fd()
{
    level utility::flag_wait( "sst_made_nice_all_vo_done" );
    wait 2;
    level utility::flag_waitopen( "scarab_mq_vo_playing" );
    level utility::flag_set( "scarab_mq_vo_playing" );
    level dialogue::say( "dx_zm_scmn_6trf_ssuh_sm6ssinv", 99, 0, 1 );
    level utility::flag_clear( "scarab_mq_vo_playing" );
    level thread vo_begin_descent();
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xc4f252c6, Offset: 0x9438
// Size: 0x41
function private function_6ee529c6185fa736( params )
{
    if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_bd3ce90cea3f86b5" ) )
    {
        utility::callsharedfunc( #"scarab_rain", #"hash_bd3ce90cea3f86b5" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xd4b2266f, Offset: 0x9481
// Size: 0x12c
function private function_68d48b23c1e3b131( b_skipped, b_restored )
{
    if ( b_skipped )
    {
        a_arch_mayhem = getentitylessscriptablearray( "forge_arch_mayhem", #script_noteworthy );
        
        foreach ( scriptable in a_arch_mayhem )
        {
            scriptable setscriptablepartstate( "base", "remove" );
        }
        
        level utility::flag_set( "gimbals_first_up" );
    }
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "sst_made_nice_all_vo_done" );
    }
    
    level utility::flag_set( "sst_made_nice" + 4 );
    level utility::flag_set( "sst_made_nice" + 3 );
    level utility::flag_set( "sst_made_nice" + 1 );
    level utility::flag_set( "sst_made_nice" + 2 );
    level utility::flag_set( "sst_made_nice_all" );
    level thread do_forge_eruption( b_skipped );
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x7d6901bd, Offset: 0x95b5
// Size: 0x1d2
function private setup_enter_boss_fight( b_skipped, b_restored )
{
    if ( b_restored )
    {
        return;
    }
    
    if ( !level utility::flag( "gimbals_are_up" ) )
    {
        level thread function_6d64d53cb450e847();
    }
    
    level thread function_e0d5285bfbad4e41();
    level thread function_8fa61abe2e0a38fb();
    level utility::flag_wait( "enter_boss_fight_go" );
    level musicbank_utility::function_683e33ddcb824d18( #"round_start" );
    level musicbank_utility::function_683e33ddcb824d18( #"round_end" );
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"hash_a5359d9621eb4ef5" );
    
    foreach ( player in level.players )
    {
        player playlocalsound( #"hash_c763903b970912d0" );
    }
    
    if ( level callback::exists( #"player_spawned", &function_6ee529c6185fa736 ) )
    {
        level callback::remove( #"player_spawned", &function_6ee529c6185fa736 );
    }
    
    level callback::add( #"player_spawned", &function_59cad469f9f9fb05 );
    zm_round_spawning::pause_round_spawning( 1, "scarab_elevator_pause_spawning" );
    function_582f076a7ebc859a();
    level thread function_e4640d67837d8faa();
    level thread function_72477e4a4aa23682();
    level thread function_ac0c6e4829650289();
    level thread function_bcbe2f10c51a29bb();
    level thread lower_elevator();
    level utility::flag_wait( "enter_boss_fight_done" );
    level callback::remove( #"player_spawned", &function_59cad469f9f9fb05 );
    zm_round_spawning::pause_round_spawning( 0, "scarab_elevator_pause_spawning" );
    level thread zm_sat_scarab_boss_fight::start_boss_fight();
    level utility::flag_wait( "scarab_boss_fight_complete" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xed986a08, Offset: 0x978f
// Size: 0x62
function private function_8fa61abe2e0a38fb()
{
    function_a6a33eab4fa1fb06();
    s_platform = utility::getstruct( "bf_lift_center" );
    s_platform.interact = zm_quest::function_91f9590e98d57ff6( s_platform.origin + ( 0, 0, 32 ), &function_f5a496910d586e6d, &vote_interact_hint, "extralarge" );
    level thread function_e0d5285bfbad4e41();
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x30765a08, Offset: 0x97f9
// Size: 0x166
function private vote_interact_hint( interact, player )
{
    if ( interact.b_voting || level utility::flag( "enter_boss_fight_go" ) || !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    foreach ( e_player in utility::get_alive_players( 0 ) )
    {
        if ( !e_player.var_6af5ae2769824a38 )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
    }
    
    return { #buttoncallout:&"hash_186ae934ee85e385", #icon:"sat_ui_icon_zm_ai_boss", #description:&"hash_5f04213027a731c3", #string:&"hash_5f04213027a731c3", #title:&"hash_186ae934ee85e385", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xed6d352, Offset: 0x9968
// Size: 0x19e
function private function_f5a496910d586e6d( player )
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return;
    }
    
    foreach ( e_player in utility::get_alive_players( 0 ) )
    {
        if ( !e_player.var_6af5ae2769824a38 )
        {
            return;
        }
    }
    
    var_3faf858e79cd17bb = spawnstruct();
    var_3faf858e79cd17bb.init_message = &"hash_368ffead421750f5";
    var_3faf858e79cd17bb.description = &"zm_hud/start_final_encounter";
    self.b_voting = 1;
    level thread function_25ce8c61c919061a();
    thread function_adf1f912b6d45500( 1 );
    b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb );
    
    if ( b_passed )
    {
        level utility::flag_set( "enter_boss_fight_go" );
        zm_quest::clear_all_guidance();
    }
    else
    {
        foreach ( e_player in utility::get_alive_players( 0 ) )
        {
            e_player val::reset_all( "scarab_lift" );
        }
    }
    
    thread function_adf1f912b6d45500( 0 );
    self.b_voting = undefined;
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0xc4d35ea7, Offset: 0x9b0e
// Size: 0x101
function function_adf1f912b6d45500( b_ignore_players )
{
    self endon( #"death" );
    
    if ( b_ignore_players && !callback::exists( "on_zombie_ai_spawned", &function_4324b8acbf7c2614 ) )
    {
        callback::add( "on_zombie_ai_spawned", &function_4324b8acbf7c2614 );
    }
    else if ( callback::exists( "on_zombie_ai_spawned", &function_4324b8acbf7c2614 ) )
    {
        callback::remove( "on_zombie_ai_spawned", &function_4324b8acbf7c2614 );
    }
    
    if ( isdefined( self ) )
    {
        var_d0bf10f61a87b364 = getaiarrayinradius( self.origin, 800, "team_two_hundred" );
        
        foreach ( zombie in var_d0bf10f61a87b364 )
        {
            zombie thread function_6c717dfb99b62352( b_ignore_players );
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0x5db45e4b, Offset: 0x9c17
// Size: 0x31
function function_4324b8acbf7c2614( params )
{
    self endon( #"death" );
    
    while ( self.b_in_spawn_closet )
    {
        waitframe();
    }
    
    thread function_6c717dfb99b62352( 1 );
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0x5264d0f6, Offset: 0x9c50
// Size: 0xaa
function function_6c717dfb99b62352( b_ignore_players )
{
    self endon( #"death" );
    
    while ( self.b_in_spawn_closet )
    {
        waitframe();
    }
    
    if ( b_ignore_players && !isdefined( self.elevator_attractor ) )
    {
        idle_loc = { #angles:self.angles, #origin:self.origin };
        self.elevator_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( idle_loc, 4 );
        return;
    }
    
    if ( isdefined( self.elevator_attractor ) )
    {
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.elevator_attractor );
        self.elevator_attractor = undefined;
    }
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0x20b16ad9, Offset: 0x9d02
// Size: 0x37
function vo_begin_descent()
{
    wait 1;
    player = utility::array_random( level.players );
    
    if ( isalive( player ) )
    {
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "begin_descent" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0xf0b2c5a8, Offset: 0x9d41
// Size: 0xac
function function_38724f179692538d()
{
    var_f92156f72fab2a25 = utility::getstructarray( "cage_zombie" );
    
    foreach ( s_cage in var_f92156f72fab2a25 )
    {
        s_cage thread scene::init( undefined, undefined, "sat_cin_zm_scarab_living_world_caged_zmb_01" );
        scene_entities = s_cage scene::get_entities();
        s_cage thread function_11087ab11a52bd8( scene_entities );
    }
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0xf56fba58, Offset: 0x9df5
// Size: 0xad
function function_11087ab11a52bd8( scene_entities )
{
    foreach ( entity in scene_entities )
    {
        entity.var_2fc3a5fb762afb6e = 1;
    }
    
    wait randomfloatrange( 0.1, 1 );
    thread scene::play();
    level utility::flag_wait( "enter_boss_fight_done" );
    scene::stop();
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0xee9aad44, Offset: 0x9eaa
// Size: 0xd8
function function_e4640d67837d8faa()
{
    foreach ( livingworldstruct in level._livingworld_info.livingworldstructs )
    {
        if ( isdefined( livingworldstruct.script_scenescriptbundle ) )
        {
            level notify( livingworldstruct.script_scenescriptbundle + "_cancel_living_world_encounter_" + livingworldstruct.origin );
            continue;
        }
        
        level notify( livingworldstruct.encounterstruct.stringid + "_cancel_living_world_encounter_" + livingworldstruct.origin );
    }
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0x9799d92c, Offset: 0x9f8a
// Size: 0x15c
function function_582f076a7ebc859a( var_6779a2f075a575a3 )
{
    wait var_6779a2f075a575a3 ? 0 : 2;
    
    if ( !var_6779a2f075a575a3 )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player thread zm_utility::white_screen_flash( 1.5, undefined, undefined, undefined, 1 );
            }
        }
    }
    
    removeallcorpses();
    level.zm_scarab_mq.elevator_throttle = throttle::throttle_initialize( "elevator_kill" );
    var_d0bf10f61a87b364 = getaiarray( "team_two_hundred" );
    
    for ( i = 0; i < var_d0bf10f61a87b364.size ; i++ )
    {
        if ( isalive( var_d0bf10f61a87b364[ i ] ) )
        {
            throttle::throttle_wait_in_queue( level.zm_scarab_mq.elevator_throttle, var_d0bf10f61a87b364[ i ] );
            var_d0bf10f61a87b364[ i ].forceannihilate = 1;
            var_d0bf10f61a87b364[ i ] thread zm_utility::function_5bbd540197e3fd( 100, 0.5, 1 );
        }
        
        waitframe();
    }
    
    if ( !var_6779a2f075a575a3 )
    {
        level utility::flag_set( "elevator_cleared" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xdea6711b, Offset: 0xa0ee
// Size: 0xfc
function private get_powerups_in_radius( origin, radius )
{
    powerups_in_radius = [];
    root = powerups::get_powerups_root();
    active_powerups = root.active_powerups;
    
    if ( !isarray( active_powerups ) || active_powerups.size <= 0 )
    {
        return powerups_in_radius;
    }
    
    radius_sq = radius * radius;
    
    foreach ( powerup in active_powerups )
    {
        if ( !isdefined( powerup ) )
        {
            continue;
        }
        
        if ( distancesquared( powerup.origin, origin ) <= radius_sq )
        {
            powerups_in_radius[ powerups_in_radius.size ] = powerup;
        }
    }
    
    return powerups_in_radius;
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x414278e0, Offset: 0xa1f3
// Size: 0xad
function private function_72477e4a4aa23682()
{
    s_platform = utility::getstruct( "bf_lift_center" );
    var_ce607c804a2b8215 = get_powerups_in_radius( s_platform.origin, 1000 );
    
    foreach ( powerup in var_ce607c804a2b8215 )
    {
        if ( isdefined( powerup ) )
        {
            powerup powerups::powerup_delete();
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xc41ae1a3, Offset: 0xa2a8
// Size: 0xd5
function private function_ac0c6e4829650289()
{
    s_platform = utility::getstruct( "bf_lift_center" );
    items = scriptable_group::function_dbae202082772159( "common_items" );
    items = function_5713d46873b29625( items );
    
    foreach ( item in items )
    {
        if ( isdefined( item ) )
        {
            if ( distancesquared( s_platform.origin, item.origin ) <= 40000 )
            {
                level thread common_item::function_869d7676e359a627( item );
            }
        }
        
        zm_quest::quest_throttle_wait();
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xd14ebe09, Offset: 0xa385
// Size: 0x142
function private function_bcbe2f10c51a29bb()
{
    foreach ( player in level.players )
    {
        if ( player.var_4fd5ac47a9bd8c18 )
        {
            player.var_4fd5ac47a9bd8c18 utility::callsharedfunc( #"w_mod", #"delete_wisp", player );
        }
        
        allequip = player weapons::getallequip();
        
        foreach ( equip in allequip )
        {
            if ( equip && equip.equipmentref == "equip_blackhole_bomb" )
            {
                equip weapons::deleteexplosive();
            }
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xfc41b3c5, Offset: 0xa4cf
// Size: 0x6b8
function private lower_elevator()
{
    s_platform = utility::getstruct( "bf_lift_center" );
    
    if ( s_platform.interact )
    {
        s_platform.interact freescriptable();
    }
    
    var_863fd30dd9bd51d5 = utility::getstruct( "tag_align_nexus_lift" );
    var_f8d442d6449835a6 = utility::spawn_model( "tag_origin", var_863fd30dd9bd51d5.origin, var_863fd30dd9bd51d5.angles );
    var_f8d442d6449835a6.targetname = "tag_align_nexus_lift";
    var_f8d442d6449835a6 scene::init( undefined, undefined, "sat_cin_zm_vig_scarab_mq_platform_shdsmth" );
    scene_entities = var_f8d442d6449835a6 scene::get_entities();
    level.var_b52c8f742ebf349e = [];
    
    foreach ( entity in scene_entities )
    {
        level.var_b52c8f742ebf349e[ entity.animname ] = entity;
    }
    
    level utility::flag_set( "scarab_mq_vo_playing" );
    wait 1;
    var_a6e5905583be59d = getent( "scarab_lift", #targetname );
    var_a6e5905583be59d.v_home = var_a6e5905583be59d.origin;
    mdl_linker = utility::spawn_model( "tag_origin", s_platform.origin, s_platform.angles );
    var_a6e5905583be59d linkto( mdl_linker );
    a_tiles = getentarray( "bf_lift_tile", #targetname );
    
    foreach ( mdl_tile in a_tiles )
    {
        mdl_tile linkto( mdl_linker );
    }
    
    mdl_clip = getent( "elevator_clip", "targetname" );
    
    if ( isdefined( mdl_clip ) )
    {
        mdl_clip linkto( var_a6e5905583be59d );
    }
    
    function_8bf6c5fe849106c4( var_a6e5905583be59d.origin, ( 0, 0, 0 ), 10, 222, 64 );
    level utility::flag_wait( "elevator_cleared" );
    var_a6e5905583be59d thread function_5a9534f56e8c5a67();
    function_6ba6b0d5cd6d940a();
    
    foreach ( player in utility::get_alive_players( 1 ) )
    {
        if ( isdefined( player.var_33d0b84743f8c1c7 ) )
        {
            player setorigin( player.var_33d0b84743f8c1c7.origin );
            continue;
        }
        
        player thread function_71b8d8d7101f214c();
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_c2ef3010af21f72e" );
    wait 0.5;
    var_f8d442d6449835a6 thread shadowsmith_spawn_vfx( scene_entities );
    var_f8d442d6449835a6 linkto( mdl_linker );
    mdl_linker moveto( mdl_linker.origin - ( 0, 0, 2600 ), 30, 10, 10 );
    wait 6;
    mdl_linker rotateby( ( 0, -118, 0 ), 28, 10, 5 );
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_f72f05d8d6d715a7" ], undefined, 9 );
    level thread function_d65ec157ea604b53();
    wait 23;
    var_1e8dcea37965c118 = utility::getstruct( "bf_lift_door" );
    mdl_linker moveto( var_1e8dcea37965c118.origin, 12, 2 );
    wait 2;
    var_99064b9592368173 = utility::getstructarray( "zone_boss_arena", "script_noteworthy" )[ 0 ];
    a_teleports = utility::getstructarray( var_99064b9592368173.target );
    
    foreach ( player in level.players )
    {
        level thread utility::fadetoblackforplayer( player, 1, 5 );
        num = player getentitynumber();
        player predictstreamposuntilcleared( a_teleports[ num ].origin );
    }
    
    wait 6;
    
    foreach ( player in utility::get_alive_players( 1 ) )
    {
        num = player getentitynumber();
        player dontinterpolate();
        player setorigin( a_teleports[ num ].origin );
        player setplayerangles( a_teleports[ num ].angles );
        player stoprumble( "steady_rumble" );
        player utility::delaythread( 4, &val::reset_all, "scarab_lift" );
        player utility::delaycallendon( 3, "death_or_disconnect", &playrumbleonentity, "damage_heavy" );
        player.var_b591aaffe204ef9b = undefined;
    }
    
    mdl_linker delete();
    var_a6e5905583be59d hide();
    level utility::flag_set( "enter_boss_fight_done" );
    wait 1;
    
    foreach ( player in level.players )
    {
        player clearpredictedstreampos();
    }
    
    foreach ( entity in scene_entities )
    {
        entity delete();
    }
    
    level utility::flag_clear( "scarab_mq_vo_playing" );
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0x32c9241b, Offset: 0xab8f
// Size: 0x13f
function function_d65ec157ea604b53()
{
    wait 24;
    var_a6e5905583be59d = getent( "scarab_lift", #targetname );
    earthquakeadvanced( 0.4, 0.3, 0.2, 6, var_a6e5905583be59d.origin, 1000, 2000, 3000 );
    
    foreach ( player in level.players )
    {
        player playrumblelooponentity( "artillery_rumble_heavy" );
    }
    
    wait 7;
    
    foreach ( player in level.players )
    {
        player stoprumble( "artillery_rumble_heavy" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0x5411b8d1, Offset: 0xacd6
// Size: 0x1db
function function_5a9534f56e8c5a67()
{
    sc_vfx = spawnscriptable( "zm_sat_scarab_mq_shadowsmith_spawn", self.origin, ( 0, 0, 0 ) );
    sc_vfx setscriptablepartstate( "visual", "elevator_activate" );
    sc_vfx scriptablesetparententity( self );
    level utility::flag_wait( "shadowsmith_vo_done" );
    
    foreach ( player in level.players )
    {
        player playlocalsound( #"hash_4b0687ed09c664f4" );
    }
    
    earthquakeadvanced( 0.4, 0.3, 0.2, 1, self.origin, 1000, 2000, 3000 );
    sc_vfx setscriptablepartstate( "visual", "elevator_move" );
    sc_vfx thread function_6df176a8d6547229( "enter_boss_fight_done" );
    wait 0.5;
    level thread function_72477e4a4aa23682();
    level thread function_ac0c6e4829650289();
    level thread function_bcbe2f10c51a29bb();
    a_tiles = getentarray( "bf_lift_tile", #targetname );
    
    foreach ( mdl_tile in a_tiles )
    {
        if ( isdefined( mdl_tile.sc_vfx ) )
        {
            mdl_tile.sc_vfx freescriptable();
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0x2da09711, Offset: 0xaeb9
// Size: 0x18
function function_6df176a8d6547229( var_803fcb74a2c19d5f )
{
    level waittill( var_803fcb74a2c19d5f );
    self freescriptable();
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0xe81ccdd2, Offset: 0xaed9
// Size: 0x99
function function_6ba6b0d5cd6d940a()
{
    if ( !isdefined( level.var_b52c8f742ebf349e ) || !level.var_b52c8f742ebf349e.size )
    {
        return;
    }
    
    level.var_b52c8f742ebf349e[ "shadowsmith_firefly" ] namespace_c0b4f2882c9d100f::function_e8e3ebe31c2c48bb( "dx_zm_scwp_wprg_ssfh_wpmn6eldeln1" );
    level.var_b52c8f742ebf349e[ "shadowsmith_ruby" ] namespace_c0b4f2882c9d100f::function_e8e3ebe31c2c48bb( "dx_zm_scwp_wprg_ssrh_wpmn6eldeln2" );
    level.var_b52c8f742ebf349e[ "shadowsmith_locust" ] namespace_c0b4f2882c9d100f::function_e8e3ebe31c2c48bb( "dx_zm_scwp_wprg_sslh_wpmn6eldeln3" );
    level.var_b52c8f742ebf349e[ "shadowsmith_hornet" ] namespace_c0b4f2882c9d100f::function_e8e3ebe31c2c48bb( "dx_zm_scwp_wprg_sshh_wpmn6eldeln4" );
    level utility::flag_set( "shadowsmith_vo_done" );
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0xa9976339, Offset: 0xaf7a
// Size: 0x173
function shadowsmith_spawn_vfx( scene_entities )
{
    foreach ( entity in scene_entities )
    {
        entity.team = level.players[ 0 ].team;
    }
    
    wait 7.5;
    level notify( #"highvis_reload_outline", level.players[ 0 ].team, scene_entities );
    thread scene::play( scene_entities, undefined, "sat_cin_zm_vig_scarab_mq_platform_shdsmth" );
    
    foreach ( entity in scene_entities )
    {
        if ( entity.model == "zm_elevator::c_sat_zmb_npc_diana_humanoid_body" )
        {
            entity setscriptablepartstate( "diana_wings", "diana_unfolded_wings" );
        }
        
        entity setscriptablepartstate( "reveal", "reveal_in_1_sec" );
        entity playsoundonmovingent( #"hash_8e77ad02046698fa" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x5d4e67b3, Offset: 0xb0f5
// Size: 0x106
function private function_ed6f5204aa5548b8( s_loc )
{
    if ( !isalive( self ) || self.sessionstate == "spectator" )
    {
        return;
    }
    
    s_loc.var_e26932b14b792eb3 = 1;
    self dontinterpolate();
    self setorigin( s_loc.origin );
    self setplayerangles( s_loc.angles );
    self.var_33d0b84743f8c1c7 = s_loc;
    self earthquakeforplayer( 0.4, 1.35, self.origin, 512 );
    self playrumblelooponentity( "steady_rumble" );
    self.var_b591aaffe204ef9b = 1;
    val::set( "scarab_lift", "damage", 0 );
    val::set( "scarab_lift", "death", 0 );
    val::function_b8033e083072d1d6( "scarab_lift", 1 );
    val::set( "scarab_lift", "ignore_playable_area_check", 1 );
    val::set( "scarab_lift", "ignoreme", 1 );
    val::set( "scarab_lift", "show_hud", 0 );
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0xb6121a76, Offset: 0xb203
// Size: 0x33
function function_59cad469f9f9fb05( params )
{
    if ( level utility::flag( "enter_boss_fight_go" ) && !level utility::flag( "enter_boss_fight_done" ) )
    {
        thread function_71b8d8d7101f214c();
    }
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0x7b4e23f1, Offset: 0xb23e
// Size: 0xb9
function function_71b8d8d7101f214c()
{
    self endon( #"death" );
    a_teleports = utility::getstructarray( "bf_lift_tp" );
    
    foreach ( var_d6603d02be124c70 in a_teleports )
    {
        if ( !isdefined( var_d6603d02be124c70.var_e26932b14b792eb3 ) )
        {
            thread zm_utility::white_screen_flash( 1, undefined, undefined, undefined, 1 );
            thread function_ed6f5204aa5548b8( var_d6603d02be124c70 );
            break;
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0x2adf6b08, Offset: 0xb2ff
// Size: 0x16a
function function_25ce8c61c919061a()
{
    var_4dcae802c552cd5a = [];
    a_teleports = utility::getstructarray( "bf_lift_tp" );
    
    foreach ( player in utility::get_alive_players( 0 ) )
    {
        if ( player.var_6af5ae2769824a38 )
        {
            var_ed100f9a07836d02 = utility::getstruct( "bf_lift_tp" + player.var_6af5ae2769824a38.script_noteworthy, "script_noteworthy" );
            a_teleports = arrayremove( a_teleports, var_ed100f9a07836d02 );
            player function_ed6f5204aa5548b8( var_ed100f9a07836d02 );
            continue;
        }
        
        var_4dcae802c552cd5a[ var_4dcae802c552cd5a.size ] = player;
    }
    
    foreach ( player in var_4dcae802c552cd5a )
    {
        s_loc = a_teleports[ 0 ];
        a_teleports = arrayremove( a_teleports, s_loc );
        player function_ed6f5204aa5548b8( s_loc );
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xeffaaa75, Offset: 0xb471
// Size: 0xc6
function private cleanup_enter_boss_fight( b_skipped, b_restored )
{
    level utility::flag_set( "enter_boss_fight_go" );
    level utility::flag_set( "scarab_boss_fight_complete" );
    
    if ( b_restored )
    {
        var_a6e5905583be59d = getent( "scarab_lift", #targetname );
        function_8bf6c5fe849106c4( var_a6e5905583be59d.origin, ( 0, 0, 0 ), 10, 222, 64 );
        var_a6e5905583be59d.origin += ( 0, 0, -2600 );
        var_a6e5905583be59d hide();
        mdl_clip = getent( "elevator_clip", "targetname" );
        
        if ( isdefined( mdl_clip ) )
        {
            mdl_clip notsolid();
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0x2756c40f, Offset: 0xb53f
// Size: 0x6f6
function private function_ca8db7d0047a4756( b_save_restored )
{
    level.zm_scarab_mq utility::ent_flag_wait( "mq_quest_init_done" );
    
    if ( !b_save_restored )
    {
        set_ring_rotation();
    }
    else
    {
        level utility::flag_set( "nexus_platforms_begin" );
    }
    
    var_a4b4c22347038daf = getent( "nexus_ring_1", #targetname );
    var_a4b4c32347038fe2 = getent( "nexus_ring_2", #targetname );
    var_a4b4c42347039215 = getent( "nexus_ring_3", #targetname );
    
    if ( b_save_restored && var_a4b4c22347038daf.n_rotate_slot == var_a4b4c32347038fe2.n_rotate_slot && var_a4b4c22347038daf.n_rotate_slot == var_a4b4c42347039215.n_rotate_slot )
    {
        var_20ee61ef917aaafe = var_a4b4c22347038daf.n_rotate_slot;
        var_d262521be8963583 = function_33008a6d7a4ca2bb( var_20ee61ef917aaafe, 1 );
        function_339b830137e4badc( 1, var_20ee61ef917aaafe );
        b_aligned = 1;
    }
    else
    {
        level utility::flag_set( "tmp_align_id_ready" );
        b_aligned = undefined;
        var_d262521be8963583 = undefined;
        var_20ee61ef917aaafe = undefined;
    }
    
    foreach ( lever in level.zm_scarab_mq.var_d38c1e11055bbed4 )
    {
        level thread extend_forge_lever( lever );
    }
    
    level utility::array_wait( level.zm_scarab_mq.var_d38c1e11055bbed4, "extension_complete" );
    
    while ( true )
    {
        level.zm_scarab_mq.var_b2e14bf59e9c9d31 = undefined;
        str_lever = level utility::flag_wait_any_return( "forge_lever_1", "forge_lever_2", "forge_lever_3" );
        
        if ( !level utility::flag( "sst_made_nice_all" ) )
        {
            level thread reset_gimbals();
        }
        
        level utility::flag_clear( "nexus_platforms_aligned" );
        level utility::flag_set( "nexus_platforms_moving" );
        level thread function_d51cdd1fe6efad4f();
        
        if ( var_d262521be8963583 && level utility::flag( "temple_channeling_" + var_d262521be8963583 ) )
        {
            function_ae4e63665a224e18( var_d262521be8963583 );
        }
        
        if ( b_aligned && isdefined( var_20ee61ef917aaafe ) )
        {
            function_339b830137e4badc( 0, var_20ee61ef917aaafe );
        }
        
        level utility::flag_waitopen( str_lever + "_unparented" );
        
        switch ( str_lever )
        {
            case #"hash_733a4aedcf3c1bc7":
                var_909e30d7b4f29aa8 = var_a4b4c22347038daf;
                break;
            case #"hash_733a4bedcf3c1d5a":
                var_909e30d7b4f29aa8 = var_a4b4c32347038fe2;
                break;
            case #"hash_733a4cedcf3c1eed":
                var_909e30d7b4f29aa8 = var_a4b4c42347039215;
                break;
        }
        
        b_aligned = 1;
        var_20ee61ef917aaafe = undefined;
        
        foreach ( var_29aa1f4b1eaa2a4 in level.zm_scarab_mq.a_rings )
        {
            if ( var_29aa1f4b1eaa2a4 == var_909e30d7b4f29aa8 )
            {
                if ( level utility::flag( "forgeo_reverseo" ) )
                {
                    var_29aa1f4b1eaa2a4.n_rotate_slot--;
                }
                else
                {
                    var_29aa1f4b1eaa2a4.n_rotate_slot++;
                }
            }
            else if ( level utility::flag( "forgeo_reverseo" ) )
            {
                var_29aa1f4b1eaa2a4.n_rotate_slot -= 2;
            }
            else
            {
                var_29aa1f4b1eaa2a4.n_rotate_slot += 2;
            }
            
            function_f44812ac19e28d3( var_29aa1f4b1eaa2a4 );
            
            if ( !isdefined( var_20ee61ef917aaafe ) )
            {
                var_20ee61ef917aaafe = var_29aa1f4b1eaa2a4.n_rotate_slot;
            }
            else if ( var_20ee61ef917aaafe != var_29aa1f4b1eaa2a4.n_rotate_slot )
            {
                b_aligned = 0;
                var_d262521be8963583 = undefined;
            }
            
            var_29aa1f4b1eaa2a4 rotateby( ( 0, var_29aa1f4b1eaa2a4.n_rotation_angle, 0 ), 16 );
        }
        
        level thread function_39d3115218c6f53();
        
        foreach ( var_12aadf5d8bbfdafd in level.zm_scarab_mq.var_a62a3d1842569ece )
        {
            destroynavobstacle( var_12aadf5d8bbfdafd );
        }
        
        foreach ( trigger in level.zm_scarab_mq.var_d0c61fca7a739091 )
        {
            trigger thread function_b662efcdad565fb();
        }
        
        var_a4b4c32347038fe2 setscriptablepartstate( "visual", "forge_on" );
        wait 16;
        level notify( #"hash_b5b1f3df1fb56105" );
        function_314be45bcef2ff6e( 1 );
        var_a4b4c32347038fe2 setscriptablepartstate( "visual", "hidden" );
        level.zm_scarab_mq.var_a62a3d1842569ece = [];
        
        foreach ( trigger in level.zm_scarab_mq.var_d0c61fca7a739091 )
        {
            trigger.var_5ea0f98dc8a9f1f4 += trigger.var_29aa1f4b1eaa2a4.n_rotation_angle;
            
            if ( trigger.var_5ea0f98dc8a9f1f4 > 360 )
            {
                trigger.var_5ea0f98dc8a9f1f4 -= 360;
            }
            else if ( trigger.var_5ea0f98dc8a9f1f4 < 0 )
            {
                trigger.var_5ea0f98dc8a9f1f4 += 360;
            }
            
            var_12aadf5d8bbfdafd = createnavobstaclebybounds( trigger.origin, trigger.var_988b524502b2d45e / 2, ( 0, trigger.var_5ea0f98dc8a9f1f4, 0 ) );
            level.zm_scarab_mq.var_a62a3d1842569ece[ level.zm_scarab_mq.var_a62a3d1842569ece.size ] = var_12aadf5d8bbfdafd;
        }
        
        if ( b_aligned )
        {
            function_339b830137e4badc( 1, var_20ee61ef917aaafe );
            var_d262521be8963583 = function_33008a6d7a4ca2bb( var_20ee61ef917aaafe );
        }
        
        wait 0.25;
        level utility::flag_clear( "nexus_platforms_moving" );
        level utility::flag_clear( str_lever );
    }
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0xc
// Checksum 0xddbfa92, Offset: 0xbc3d
// Size: 0x204
function private function_d51cdd1fe6efad4f( n_rotate_time = 16 )
{
    self notify( #"hash_81e347ca94b93288" );
    self endon( #"hash_81e347ca94b93288" );
    earthquake( 0.15, n_rotate_time, level.zm_scarab_mq.a_rings[ 1 ].origin, 3600 );
    interval = 0.1;
    
    while ( n_rotate_time > 0 )
    {
        foreach ( player in level.players )
        {
            groundent = player getgroundentity();
            
            if ( groundent && level.zm_scarab_mq.a_links && arraycontains( level.zm_scarab_mq.a_links, groundent ) )
            {
                player playrumblelooponentity( "low_highfreq" );
                player.var_f511323a3f360091 = 1;
                continue;
            }
            
            if ( player.var_f511323a3f360091 )
            {
                player stoprumble( "low_highfreq" );
                player.var_f511323a3f360091 = undefined;
            }
        }
        
        wait interval;
        n_rotate_time -= interval;
    }
    
    foreach ( player in level.players )
    {
        if ( player.var_f511323a3f360091 )
        {
            player stoprumble( "low_highfreq" );
            player.var_f511323a3f360091 = undefined;
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xd05bdb2b, Offset: 0xbe49
// Size: 0x252
function private function_f44812ac19e28d3( var_29aa1f4b1eaa2a4 )
{
    var_a7e249dbc52cbe30 = 0;
    
    if ( var_29aa1f4b1eaa2a4.n_rotate_slot >= level.zm_scarab_mq.var_fb76b1c01e976601.size )
    {
        var_29aa1f4b1eaa2a4.n_rotate_slot -= level.zm_scarab_mq.var_fb76b1c01e976601.size;
        var_a7e249dbc52cbe30 = 1;
    }
    else if ( var_29aa1f4b1eaa2a4.n_rotate_slot < 0 )
    {
        var_29aa1f4b1eaa2a4.n_rotate_slot += level.zm_scarab_mq.var_fb76b1c01e976601.size;
    }
    
    var_a2f11af490c03477 = level.zm_scarab_mq.var_fb76b1c01e976601[ var_29aa1f4b1eaa2a4.n_rotate_slot ];
    
    if ( var_a7e249dbc52cbe30 )
    {
        var_29aa1f4b1eaa2a4.n_rotation_angle = 360 + var_a2f11af490c03477 - var_29aa1f4b1eaa2a4.angles[ 1 ];
    }
    else
    {
        var_29aa1f4b1eaa2a4.n_rotation_angle = var_a2f11af490c03477 - var_29aa1f4b1eaa2a4.angles[ 1 ];
    }
    
    if ( level utility::flag( "forgeo_reverseo" ) )
    {
        var_29aa1f4b1eaa2a4.n_rotation_angle -= 360;
        
        if ( var_29aa1f4b1eaa2a4.n_rotation_angle < -360 )
        {
            var_29aa1f4b1eaa2a4.n_rotation_angle += 360;
        }
        else if ( var_29aa1f4b1eaa2a4.n_rotation_angle == 0 )
        {
            var_29aa1f4b1eaa2a4.n_rotation_angle = -360;
        }
    }
    else if ( var_29aa1f4b1eaa2a4.n_rotation_angle < 0 )
    {
        var_29aa1f4b1eaa2a4.n_rotation_angle += 360;
    }
    else if ( var_29aa1f4b1eaa2a4.n_rotation_angle == 0 )
    {
        var_29aa1f4b1eaa2a4.n_rotation_angle = 360;
    }
    
    var_29aa1f4b1eaa2a4.n_rotation_angle = int( var_29aa1f4b1eaa2a4.n_rotation_angle );
    
    /#
        if ( var_29aa1f4b1eaa2a4.n_rotate_slot == 5 )
        {
            iprintln( var_29aa1f4b1eaa2a4.targetname + "<dev string:x9e>" + var_a2f11af490c03477 + "<dev string:xac>" + var_29aa1f4b1eaa2a4.angles[ 1 ] + "<dev string:xb3>" + var_29aa1f4b1eaa2a4.n_rotation_angle );
        }
    #/
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0xbcfb2510, Offset: 0xc0a3
// Size: 0x188
function private function_314be45bcef2ff6e( var_93f3ef9a1698479, var_4c85b5c057749614 )
{
    if ( var_93f3ef9a1698479 && !level utility::flag( "sst_made_nice_all" ) && zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    foreach ( var_29aa1f4b1eaa2a4 in level.zm_scarab_mq.a_rings )
    {
        if ( var_29aa1f4b1eaa2a4.targetname == "nexus_ring_1" )
        {
            zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", #"hash_f3b21cd1f5b8e84", var_4c85b5c057749614.slot1 ?? var_29aa1f4b1eaa2a4.n_rotate_slot );
            continue;
        }
        
        if ( var_29aa1f4b1eaa2a4.targetname == "nexus_ring_2" )
        {
            zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", #"hash_83e631fdd4b97ba3", var_4c85b5c057749614.slot2 ?? var_29aa1f4b1eaa2a4.n_rotate_slot );
            continue;
        }
        
        if ( var_29aa1f4b1eaa2a4.targetname == "nexus_ring_3" )
        {
            zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", #"hash_89f03fdf6d577e22", var_4c85b5c057749614.slot3 ?? var_29aa1f4b1eaa2a4.n_rotate_slot );
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 3, eflags: 0x4
// Checksum 0x98928338, Offset: 0xc233
// Size: 0x54e
function private set_ring_rotation( var_6feb9faca1fcf243, var_87a558a43aae9787, var_e700317bf82f1f9b = 1 )
{
    level utility::flag_clear( "nexus_platforms_aligned" );
    level utility::flag_set( "nexus_platforms_moving" );
    var_a4b4c32347038fe2 = getent( "nexus_ring_2", #targetname );
    
    if ( var_e700317bf82f1f9b )
    {
        var_a4b4c32347038fe2 setscriptablepartstate( "visual", "forge_on" );
    }
    
    if ( !var_6feb9faca1fcf243 )
    {
        level utility::flag_set( "nexus_platforms_begin" );
        
        if ( level zm_quest::function_b0a5181ebe7bb905() )
        {
            var_fcdf8fd9782a74e6 = 2;
        }
        else
        {
            var_fcdf8fd9782a74e6 = level.zm_scarab_mq.var_765f74df80347a3c ?? utility::array_random( [ 1, 2, 4, 5 ] );
        }
    }
    
    n_max_slots = level.zm_scarab_mq.var_fb76b1c01e976601.size;
    var_c294de0d89d6891a = 0;
    
    foreach ( var_29aa1f4b1eaa2a4 in level.zm_scarab_mq.a_rings )
    {
        if ( var_fcdf8fd9782a74e6 )
        {
            if ( var_fcdf8fd9782a74e6 >= var_29aa1f4b1eaa2a4.n_rotate_slot )
            {
                n_slot_delta = var_fcdf8fd9782a74e6 - var_29aa1f4b1eaa2a4.n_rotate_slot;
            }
            else
            {
                n_slot_delta = var_fcdf8fd9782a74e6 - var_29aa1f4b1eaa2a4.n_rotate_slot + n_max_slots;
            }
            
            for ( i = 0; i < n_slot_delta ; i++ )
            {
                var_29aa1f4b1eaa2a4.n_rotate_slot++;
            }
        }
        
        if ( n_slot_delta == 0 )
        {
            var_c294de0d89d6891a = n_max_slots;
        }
        else if ( n_slot_delta > var_c294de0d89d6891a )
        {
            var_c294de0d89d6891a = n_slot_delta;
        }
        
        function_f44812ac19e28d3( var_29aa1f4b1eaa2a4 );
        var_29aa1f4b1eaa2a4.var_57547023bc8b4c5f = var_29aa1f4b1eaa2a4.angles[ 1 ] + var_29aa1f4b1eaa2a4.n_rotation_angle;
        
        if ( var_29aa1f4b1eaa2a4.var_57547023bc8b4c5f >= 360 )
        {
            var_29aa1f4b1eaa2a4.var_57547023bc8b4c5f -= 360;
        }
        
        if ( var_fcdf8fd9782a74e6 )
        {
            var_fcdf8fd9782a74e6++;
        }
    }
    
    n_rotate_time = ( var_87a558a43aae9787 ?? var_c294de0d89d6891a ) * 8;
    level thread function_d51cdd1fe6efad4f( n_rotate_time );
    
    foreach ( var_29aa1f4b1eaa2a4 in level.zm_scarab_mq.a_rings )
    {
        var_29aa1f4b1eaa2a4.n_rotate_time = n_rotate_time;
        var_29aa1f4b1eaa2a4 rotateby( ( 0, var_29aa1f4b1eaa2a4.n_rotation_angle, 0 ), var_29aa1f4b1eaa2a4.n_rotate_time );
    }
    
    level thread function_39d3115218c6f53();
    
    foreach ( var_12aadf5d8bbfdafd in level.zm_scarab_mq.var_a62a3d1842569ece )
    {
        destroynavobstacle( var_12aadf5d8bbfdafd );
    }
    
    level.zm_scarab_mq.var_a62a3d1842569ece = [];
    
    foreach ( trigger in level.zm_scarab_mq.var_d0c61fca7a739091 )
    {
        trigger thread function_b662efcdad565fb();
        trigger thread block_trigger_update();
    }
    
    if ( !var_6feb9faca1fcf243 && zm_save::is_save_load_enabled() )
    {
        function_314be45bcef2ff6e();
        zm_save::save_session( 0 );
        
        if ( zm_save::is_autosave_enabled() )
        {
            zm_save::commit_session( 1 );
        }
    }
    
    utility::array_wait( level.zm_scarab_mq.a_rings, "rotatedone" );
    
    foreach ( var_29aa1f4b1eaa2a4 in level.zm_scarab_mq.a_rings )
    {
        var_29aa1f4b1eaa2a4.angles = ( 0, var_29aa1f4b1eaa2a4.var_57547023bc8b4c5f, 0 );
    }
    
    level notify( #"hash_b5b1f3df1fb56105" );
    function_314be45bcef2ff6e();
    var_a4b4c32347038fe2 setscriptablepartstate( "visual", "hidden" );
    level utility::flag_clear( "nexus_platforms_moving" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x8b1cf577, Offset: 0xc789
// Size: 0xbf
function private block_trigger_update()
{
    self.var_29aa1f4b1eaa2a4 waittill( #"rotatedone" );
    self.var_5ea0f98dc8a9f1f4 += self.var_29aa1f4b1eaa2a4.n_rotation_angle;
    
    if ( self.var_5ea0f98dc8a9f1f4 > 360 )
    {
        self.var_5ea0f98dc8a9f1f4 -= 360;
    }
    
    var_12aadf5d8bbfdafd = createnavobstaclebybounds( self.origin, self.var_988b524502b2d45e / 2, ( 0, self.var_5ea0f98dc8a9f1f4, 0 ) );
    level.zm_scarab_mq.var_a62a3d1842569ece[ level.zm_scarab_mq.var_a62a3d1842569ece.size ] = var_12aadf5d8bbfdafd;
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x5c8a7d12, Offset: 0xc850
// Size: 0x638
function private function_33008a6d7a4ca2bb( var_20ee61ef917aaafe, b_save_restored )
{
    level utility::flag_set( "nexus_platforms_aligned" );
    
    if ( level utility::flag( "sst_made_nice_all" ) )
    {
        level utility::flag_set( "tmp_align_id_ready" );
        return;
    }
    
    var_e97a4f4962bc3f25 = get_channeler_slot( var_20ee61ef917aaafe );
    
    switch ( var_e97a4f4962bc3f25 )
    {
        case 1:
            var_8af4bb0185feb88 = 4;
            str_shadowsmith = "caltheris";
            break;
        case 2:
            var_8af4bb0185feb88 = 3;
            str_shadowsmith = "dravakar";
            break;
        case 4:
            var_8af4bb0185feb88 = 2;
            str_shadowsmith = "veytharion";
            break;
        case 5:
            var_8af4bb0185feb88 = 1;
            str_shadowsmith = "nyxara";
            break;
    }
    
    if ( !isdefined( var_8af4bb0185feb88 ) )
    {
        level utility::flag_set( "tmp_align_id_ready" );
        return;
    }
    
    function_314be45bcef2ff6e();
    
    if ( level utility::flag( "sst_made_nice" + var_8af4bb0185feb88 ) )
    {
        level utility::flag_set( "tmp_align_id_ready" );
        return;
    }
    
    level.zm_scarab_mq.var_d262521be8963583 = var_8af4bb0185feb88;
    level utility::flag_set( "tmp_align_id_ready" );
    str_quest = hashcat( #"hash_5267022c69306b07", str_shadowsmith );
    var_af2c5380593e3cfa = zm_quest::get_quest( str_quest );
    
    /#
        iprintlnbold( "<dev string:xc1>" + var_8af4bb0185feb88 );
    #/
    
    level utility::flag_wait( "papq_final_state_set" );
    function_6d64d53cb450e847();
    wait 1;
    activateworldevent( "we_sat_zm_mana_chan_base" );
    
    if ( level.scarab_pap_quest.var_9d15330b141fe52f )
    {
        level.scarab_pap_quest.var_9d15330b141fe52f setscriptablepartstate( "audio_mq", "temple_alignment_mana" );
    }
    
    s_up = utility::getstruct( "forge_rings_up" );
    
    if ( b_save_restored )
    {
        level.scarab_pap_quest.var_dbdff7ad02b59f6b.origin = s_up.origin;
        level.scarab_pap_quest.var_dbdff8ad02b5a19e.origin = s_up.origin;
        level utility::flag_set( "gimbals_first_up" );
    }
    else
    {
        earthquake( 0.3, 0.75, level.scarab_pap_quest.var_dbdff7ad02b59f6b.origin, 1000 );
        playrumbleonposition( "zm_scarab_ruins_channel", level.scarab_pap_quest.var_dbdff7ad02b59f6b.origin );
        level.scarab_pap_quest.var_dbdff7ad02b59f6b moveto( s_up.origin, 1.75, 0.25 );
        level.scarab_pap_quest.var_dbdff8ad02b5a19e moveto( s_up.origin, 1.75, 0.25 );
        
        if ( !level utility::flag( "gimbals_first_up" ) )
        {
            level utility::flag_set( "gimbals_first_up" );
            function_2c992d8bbeb5344b();
        }
        else
        {
            wait 1.75;
        }
        
        if ( !var_af2c5380593e3cfa.started && !var_af2c5380593e3cfa.completed )
        {
            level thread zm_quest::start_quest( str_quest );
        }
    }
    
    level.scarab_pap_quest.var_dbdff7ad02b59f6b setscriptablepartstate( "ambient_fx", "off" );
    level.scarab_pap_quest.var_dbdff8ad02b5a19e setscriptablepartstate( "ambient_fx", "off" );
    level utility::flag_set( "gimbals_are_up" );
    level utility::flag_set( "temple_channeling_" + var_8af4bb0185feb88 );
    level utility::flag_set( "temple_channeling_id_flag_set" );
    wait 2.5;
    activateworldevent( "we_sat_zm_manach_t" + var_8af4bb0185feb88 );
    var_c810c698cea03d98 = getent( "sat_zm_temple_head_0" + var_8af4bb0185feb88, #targetname );
    var_c810c698cea03d98 setscriptablepartstate( "anim", "open" );
    mdl_channeler = getent( "blocker_nexus_ring_2", #targetname );
    playworldsound( mdl_channeler.origin + ( 0, 0, 25 ), #"hash_e6cbb9cfc82f3ae5" );
    wait 0.5;
    playfxontag( level._effect[ #"hash_d4a1fe7e4b6f48f8" ], mdl_channeler, "tag_fx" );
    wait 1.1;
    playworldsound( mdl_channeler.origin + ( 0, 0, 25 ), #"hash_9af28d0b68d7d4c9" );
    var_5990ce3727e634d1 = utility::getstruct( "sst_mouth" + var_8af4bb0185feb88 );
    
    if ( !isdefined( level.zm_scarab_mq.var_e6380a1b95bd817e ) )
    {
        level.zm_scarab_mq.var_e6380a1b95bd817e = utility::spawn_model( "tag_origin", var_5990ce3727e634d1.origin, var_5990ce3727e634d1.angles );
    }
    
    level.zm_scarab_mq.var_e6380a1b95bd817e dontinterpolate();
    level.zm_scarab_mq.var_e6380a1b95bd817e.origin = var_5990ce3727e634d1.origin;
    level.zm_scarab_mq.var_e6380a1b95bd817e.angles = var_5990ce3727e634d1.angles;
    waitframe();
    level.zm_scarab_mq.var_d128e0d1cb82b144 = playfxontagsbetweenclients( level._effect[ #"hash_33df832c950ebf73" ], mdl_channeler, "tag_fx", level.zm_scarab_mq.var_e6380a1b95bd817e, "tag_origin" );
    waitframe();
    playfxontag( level._effect[ #"hash_5a739e4db08befc9" ], level.zm_scarab_mq.var_e6380a1b95bd817e, "tag_origin" );
    var_c0e8f83465571e1c = mdl_channeler gettagorigin( "tag_fx" );
    playrumbleonposition( "zm_scarab_ruins_channel", var_c0e8f83465571e1c );
    earthquake( 0.2, 2, var_5990ce3727e634d1.origin, 2500 );
    
    if ( isalive( level.zm_scarab_mq.var_b2e14bf59e9c9d31 ) )
    {
        level thread function_60b7f0ff81737e08();
    }
    
    return var_8af4bb0185feb88;
}

// Namespace zm_sat_scarab_mq
// Params 0
// Checksum 0x5b604314, Offset: 0xce91
// Size: 0x77
function function_60b7f0ff81737e08()
{
    b_success = play_banter_once( #"rings_align", "rng_al_vo", [ level.zm_scarab_mq.var_b2e14bf59e9c9d31 ], #"bc_flavor_player_positive", 1 );
    
    if ( b_success )
    {
        utility::flag_set( "skip_powerup_vo" );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_afc4778a066aafef" ] );
        utility::flag_clear( "skip_powerup_vo" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x9d6a5f23, Offset: 0xcf10
// Size: 0x74
function private function_39d3115218c6f53()
{
    playworldsound( ( 3, -976, 1561 ), #"hash_562abb0f14627fb0" );
    soundorg = utility::play_loopsound_in_space( #"hash_8f97450f2fd9beab", ( 3, -976, 1561 ) );
    level waittill( #"hash_b5b1f3df1fb56105" );
    soundorg delete();
    playworldsound( ( 3, -976, 1561 ), #"hash_7b40f5dc22b41d74" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xeb4e20f7, Offset: 0xcf8c
// Size: 0x74
function private function_6d64d53cb450e847()
{
    level utility::flag_set( "disallow_power_surge" );
    wait_for_gimbal_flags_open_timeout();
    level utility::flag_set( "gimbals_moving" );
    level.var_c57f2e874f4ba092 setscriptablepartstate( "ring_audio", "off" );
    level.var_c57f2e874f4ba092 setscriptablepartstate( "mq_gimbal_up", "on" );
    function_a34ff7bd39fa717b();
    level utility::flag_clear( "gimbals_moving" );
    level utility::flag_clear( "disallow_power_surge" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x5eb0b3b5, Offset: 0xd008
// Size: 0x49
function private wait_for_gimbal_flags_open_timeout()
{
    level endon( #"wait_for_gimbal_flags_open_timeout" );
    level thread utility::delay_notify( 12, "wait_for_gimbal_flags_open_timeout", "wait_for_gimbal_flags_open_timeout_end" );
    level utility::flag_waitopen_all_array( [ "power_surge_active", "gimbals_moving" ] );
    level notify( #"wait_for_gimbal_flags_open_timeout_end" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xa4a55a5c, Offset: 0xd059
// Size: 0x3c
function private function_a34ff7bd39fa717b()
{
    level endon( #"spin_gimbals_flat_timeout" );
    level thread utility::delay_notify( 5, "spin_gimbals_flat_timeout", "spin_gimbals_flat_timeout_end" );
    zm_sat_scarab_pap_quest::function_45d093f55c15da8c( 2, 1.75 );
    level notify( #"spin_gimbals_flat_timeout_end" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x8523f817, Offset: 0xd09d
// Size: 0x1a0
function private function_2c992d8bbeb5344b()
{
    level thread zm_quest::start_quest( #"hash_8f67bf8336da87a4" );
    zm_quest::function_4eefe6de31f5ddab( #"hash_8f67bf8336da87a4", #"arch_mayhem", 1 );
    level utility::flag_set( "fo_ar_smas" );
    wait 1.4;
    a_arch_mayhem = getentitylessscriptablearray( "forge_arch_mayhem", #script_noteworthy );
    
    foreach ( scriptable in a_arch_mayhem )
    {
        scriptable setscriptablepartstate( "base", "explode" );
    }
    
    if ( a_arch_mayhem.size )
    {
        earthquake( 0.5, 3, a_arch_mayhem[ 0 ].origin, 4000 );
        playrumbleonposition( "zm_scarab_ruins_channel", a_arch_mayhem[ 0 ].origin );
    }
    
    var_bb9cbca5b5bb314c = getentarray( "forge_arch_clip", #targetname );
    
    foreach ( brush in var_bb9cbca5b5bb314c )
    {
        brush delete();
    }
    
    wait 0.4;
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xaa3ac0a4, Offset: 0xd245
// Size: 0x2e
function private get_channeler_slot( var_e97a4f4962bc3f25 )
{
    var_a8f971edb5c0be92 = var_e97a4f4962bc3f25 + 3;
    
    if ( var_a8f971edb5c0be92 > 5 )
    {
        var_a8f971edb5c0be92 -= 6;
    }
    
    return var_a8f971edb5c0be92;
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0x4648d637, Offset: 0xd27c
// Size: 0x192
function function_ae4e63665a224e18( var_8af4bb0185feb88 = level.zm_scarab_mq.var_d262521be8963583 ?? 1 )
{
    level utility::flag_clear( "temple_channeling_" + var_8af4bb0185feb88 );
    deactivateworldevent( "we_sat_zm_manach_t" + var_8af4bb0185feb88 );
    deactivateworldevent( "we_sat_zm_mana_chan_base" );
    
    if ( level.scarab_pap_quest.var_9d15330b141fe52f )
    {
        level.scarab_pap_quest.var_9d15330b141fe52f setscriptablepartstate( "audio_mq", "off" );
    }
    
    mdl_channeler = getent( "blocker_nexus_ring_2", #targetname );
    stopfxontag( level._effect[ #"hash_d4a1fe7e4b6f48f8" ], mdl_channeler, "tag_fx" );
    playworldsound( mdl_channeler.origin + ( 0, 0, 25 ), #"hash_d1b69214449f493d" );
    
    if ( level.zm_scarab_mq.var_e6380a1b95bd817e )
    {
        stopfxontag( level._effect[ #"hash_5a739e4db08befc9" ], level.zm_scarab_mq.var_e6380a1b95bd817e, "tag_origin" );
    }
    
    if ( level.zm_scarab_mq.var_d128e0d1cb82b144 )
    {
        level.zm_scarab_mq.var_d128e0d1cb82b144 delete();
    }
    
    var_c810c698cea03d98 = getent( "sat_zm_temple_head_0" + var_8af4bb0185feb88, #targetname );
    var_c810c698cea03d98 setscriptablepartstate( "anim", "close" );
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0x201536c0, Offset: 0xd416
// Size: 0x262
function reset_gimbals( var_c7fedc10dad45c1 )
{
    level utility::flag_waitopen_or_timeout( "gimbals_moving", 5 );
    level.scarab_pap_quest.var_dbdff7ad02b59f6b setscriptablepartstate( "ambient_fx", "ring1_on" );
    level.scarab_pap_quest.var_dbdff8ad02b5a19e setscriptablepartstate( "ambient_fx", "ring2_on" );
    
    if ( level utility::flag( "gimbals_are_up" ) )
    {
        level utility::flag_clear( "gimbals_are_up" );
        level utility::flag_set( "disallow_power_surge" );
        level utility::flag_set( "gimbals_moving" );
        level.var_c57f2e874f4ba092 setscriptablepartstate( "mq_gimbal_up", "reset" );
        stop_rotating_rings_timeout();
        level.scarab_pap_quest.var_dbdff7ad02b59f6b moveto( level.scarab_pap_quest.var_dbdff7ad02b59f6b.v_home, 1.25, 0.25, 0.5 );
        level.scarab_pap_quest.var_dbdff8ad02b5a19e moveto( level.scarab_pap_quest.var_dbdff8ad02b5a19e.v_home, 1.25, 0.25, 0.5 );
        level.scarab_pap_quest.var_dbdff8ad02b5a19e utility::waittill_notify_or_timeout( "movedone", 2.25 );
        earthquake( 0.33, 0.75, level.scarab_pap_quest.var_dbdff7ad02b59f6b.origin, 1000 );
        playrumbleonposition( "zm_scarab_ruins_channel", level.scarab_pap_quest.var_dbdff7ad02b59f6b.origin );
        wait 1;
        
        if ( var_c7fedc10dad45c1 ?? 1 )
        {
            level.scarab_pap_quest.var_dbdff7ad02b59f6b thread zm_sat_scarab_pap_quest::function_33cf59821e8c556c( ( 0, 0, 360 ), 12, 1, 1, 2, 0, 1 );
            level.scarab_pap_quest.var_dbdff8ad02b5a19e thread zm_sat_scarab_pap_quest::function_33cf59821e8c556c( ( 0, 0, 360 ), 6, 1, 1, 2, 0, 1 );
            level.scarab_pap_quest.var_dbdff8ad02b5a19e utility::waittill_notify_or_timeout( "rotateToDefaultStart_complete", 5 );
        }
        
        level utility::flag_clear( "disallow_power_surge" );
        level utility::flag_clear( "gimbals_moving" );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x845fc391, Offset: 0xd680
// Size: 0x83
function private stop_rotating_rings_timeout()
{
    level endon( #"stop_rotating_rings_timeout" );
    level thread utility::delay_notify( 5, "stop_rotating_rings_timeout", "stop_rotating_rings_timeout_end" );
    zm_sat_scarab_pap_quest::function_3dcd857bd322e457( 0, ( 0, 0, 0 ), 2 );
    level.scarab_pap_quest.var_dbdff7ad02b59f6b utility::ent_flag_waitopen_any( "is_ring_rotating" );
    level.scarab_pap_quest.var_dbdff8ad02b5a19e utility::ent_flag_waitopen_any( "is_ring_rotating" );
    level notify( #"stop_rotating_rings_timeout_end" );
}

// Namespace zm_sat_scarab_mq
// Params 6, eflags: 0x4
// Checksum 0xe614993c, Offset: 0xd70b
// Size: 0x301
function private function_b73a7a66b64dd480( instance, part, state, player, bautouse, usestring )
{
    if ( instance.b_turning )
    {
        return;
    }
    
    if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player, 0, 0 ) )
    {
        return;
    }
    
    if ( instance.script_id == "forgeo_reo_lever" )
    {
        if ( !function_a4d68977edc1a9a6() )
        {
            return;
        }
        
        instance setscriptablepartstate( "forge_usable_lever", "off" );
        
        if ( !level utility::flag( "forgeo_reverseo" ) )
        {
            level utility::flag_set( "forgeo_reverseo" );
            instance setscriptablepartstate( "lever_position_sfx", "off" );
            instance.var_961af44f6619c00e rotateby( ( 0, 0, -90 ), 0.3 );
            bitmask = zm_quest::function_73720cdf21c3cfd7( #"scarab_mq", #"hash_87c25a640efbd1c9" );
            bitmask |= 1 << int( 4 );
            zm_quest::function_4eefe6de31f5ddab( #"scarab_mq", #"hash_87c25a640efbd1c9", bitmask );
        }
        else
        {
            level utility::flag_clear( "forgeo_reverseo" );
            instance setscriptablepartstate( "lever_position_sfx", "on" );
            instance.var_961af44f6619c00e rotateby( ( 0, 0, 90 ), 0.3 );
            function_cafc24dfffbfc7fa( 4, #"hash_87c25a640efbd1c9" );
        }
        
        wait 0.4;
        level utility::flag_waitopen( "forge_rest_in_prog" );
        instance setscriptablepartstate( "forge_usable_lever", "on" );
        return;
    }
    
    if ( instance.var_8ff12f2d202531c5 && !level utility::flag( "unsealed_lever" + instance.var_8ff12f2d202531c5 ) )
    {
        return;
    }
    
    if ( !level utility::flag( "topo_loco_bogo" ) )
    {
        return;
    }
    
    if ( level utility::flag( "nexus_platforms_moving" ) || level utility::flag( "forge_lever_" + instance.var_8ff12f2d202531c5 ) || level utility::flag( "forge_lever_" + instance.var_8ff12f2d202531c5 + "_unparented" ) )
    {
        return;
    }
    
    if ( isdefined( level.zm_scarab_mq.n_enabled_ring ) && level.zm_scarab_mq.n_enabled_ring != int( instance.var_8ff12f2d202531c5 ) )
    {
        return;
    }
    
    level.zm_scarab_mq.var_b2e14bf59e9c9d31 = player;
    
    foreach ( lever in level.zm_scarab_mq.var_d38c1e11055bbed4 )
    {
        level thread turn_forge_lever( lever, instance );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x629bc638, Offset: 0xda14
// Size: 0x43, Type: bool
function private function_a4d68977edc1a9a6()
{
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        if ( level utility::flag( "topo_loco_bogo" ) )
        {
            return false;
        }
        
        if ( !level utility::flag( "tiki_taco_time" ) )
        {
            return false;
        }
        
        if ( !level utility::flag( "power_surge_active" ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x160c20c6, Offset: 0xda60
// Size: 0x2fb
function private turn_forge_lever( lever, used_lever )
{
    level utility::flag_set( "forge_lever_" + lever.var_8ff12f2d202531c5 + "_unparented" );
    level utility::flag_set( "forge_lever_" + used_lever.var_8ff12f2d202531c5 );
    lever.b_turning = 1;
    lever setscriptablepartstate( "forge_usable_lever", "off" );
    lever setscriptablepartstate( "lever_position_sfx", "on" );
    lever.var_961af44f6619c00e unlink();
    lever.var_961af44f6619c00e rotateby( ( 0, 0, -90 ), 0.3 );
    lever.var_961af44f6619c00e waittill( #"rotatedone" );
    v_retract = anglestoforward( lever.var_961af44f6619c00e.angles ) * -7;
    v_move = lever.var_961af44f6619c00e.origin + v_retract;
    lever.var_961af44f6619c00e moveto( v_move, 0.5 );
    lever.var_961af44f6619c00e waittill( #"movedone" );
    lever.var_961af44f6619c00e linkto( lever.var_961af44f6619c00e.e_parent_ring );
    lever.b_turning = undefined;
    level utility::flag_clear( "forge_lever_" + lever.var_8ff12f2d202531c5 + "_unparented" );
    level utility::flag_waitopen( "forge_lever_" + used_lever.var_8ff12f2d202531c5 );
    level utility::flag_set( "forge_lever_" + lever.var_8ff12f2d202531c5 + "_unparented" );
    lever.b_turning = 1;
    lever.var_961af44f6619c00e unlink();
    lever setscriptablepartstate( "lever_position_sfx", "off" );
    v_extend = anglestoforward( lever.var_961af44f6619c00e.angles ) * 7;
    v_move = lever.var_961af44f6619c00e.origin + v_extend;
    lever.var_961af44f6619c00e moveto( v_move, 0.5 );
    lever.var_961af44f6619c00e waittill( #"movedone" );
    lever.var_961af44f6619c00e rotateby( ( 0, 0, 90 ), 0.3 );
    lever.var_961af44f6619c00e waittill( #"rotatedone" );
    lever.var_961af44f6619c00e linkto( lever.var_961af44f6619c00e.e_parent_ring );
    lever.b_turning = undefined;
    lever setscriptablepartstate( "forge_usable_lever", "on" );
    level utility::flag_clear( "forge_lever_" + lever.var_8ff12f2d202531c5 + "_unparented" );
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xa55343d2, Offset: 0xdd63
// Size: 0x7f
function private function_76fe1eedc502b68c( params )
{
    if ( self.subclass != "dawg" )
    {
        return;
    }
    
    self endon( #"death" );
    self waittill( #"mode_changed" );
    level utility::flag_wait( "nexus_platforms_moving" );
    
    if ( self.owner )
    {
        self.owner notify( #"hash_339f837e27f2a6d5" );
    }
    
    self.owner = undefined;
    thread dawg_mp::function_5c121dce096cc8f0( self.origin );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xc663166c, Offset: 0xddea
// Size: 0x180
function private function_b662efcdad565fb()
{
    level endon( #"hash_b5b1f3df1fb56105" );
    self.var_29aa1f4b1eaa2a4 endon( #"rotatedone" );
    
    for ( ai_last = undefined; true ; ai_last = ai )
    {
        self waittill( #"trigger", ai );
        
        if ( !isai( ai ) || ai.do_immediate_ragdoll || ai == ai_last )
        {
            ai_last = undefined;
            continue;
        }
        
        ai_last = undefined;
        
        if ( ai.subclass == "dawg" )
        {
            foreach ( var_29aa1f4b1eaa2a4 in level.zm_scarab_mq.a_rings )
            {
                if ( ai istouching( var_29aa1f4b1eaa2a4 ) )
                {
                    ai kill();
                    break;
                }
            }
            
            continue;
        }
        
        if ( !ai zombie_knockdown::function_605c20f278a1b5a8() && ai istouching( self ) )
        {
            ai thread function_24e4ca44c79e65d2();
            continue;
        }
        
        v_touch = ai getcentroid();
        var_b773e0df1cdd96a = vectornormalize( self.origin - v_touch ) * 5;
        ai thread zombie_knockdown::function_6fc167d4a3590991( v_touch + var_b773e0df1cdd96a, 99, 10 );
    }
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xf5cb5059, Offset: 0xdf72
// Size: 0x5b
function private function_24e4ca44c79e65d2()
{
    self endon( #"death" );
    self.var_a13bed1ac47e1b2c = 1;
    self.var_c906438bb56dd18e = 1;
    waitframe();
    
    if ( self.magic_bullet_shield )
    {
        ai::stop_magic_bullet_shield();
    }
    
    if ( !self.ignore_enemy_count )
    {
        zm_cleanup_manager::function_dd62e2042418b7e5();
    }
    
    namespace_b76ff2659823e89d::annihilate( 1 );
    self kill();
}

/#

    // Namespace zm_sat_scarab_mq
    // Params 0, eflags: 0x4
    // Checksum 0xe824b492, Offset: 0xdfd5
    // Size: 0xb6, Type: dev
    function private draw_block_trigger()
    {
        n_increments = self.var_29aa1f4b1eaa2a4.n_rotate_time / 0.1;
        var_3f97cff66053f3c1 = self.var_29aa1f4b1eaa2a4.n_rotation_angle / n_increments;
        n_yaw_draw = self.var_5ea0f98dc8a9f1f4;
        
        while ( true )
        {
            level thread debug::function_76204bee46fa39fd( self.origin, self.var_988b524502b2d45e / 2, ( 0, n_yaw_draw, 0 ), 0.1, ( 1, 0, 0 ) );
            wait 0.1;
            n_yaw_draw += var_3f97cff66053f3c1;
            
            if ( n_yaw_draw > 360 )
            {
                n_yaw_draw -= 360;
            }
        }
    }

#/

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0xc
// Checksum 0xafa27dce, Offset: 0xe093
// Size: 0xf86
function private function_e0d5285bfbad4e41()
{
    self notify( #"hash_da860a58e43a7fd" );
    self endon( #"hash_da860a58e43a7fd" );
    zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "initial_player_spawned" );
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    if ( level.zm_scarab_mq.completed )
    {
        return;
    }
    
    if ( !level.scarab_ww_quest.completed )
    {
        return;
    }
    
    if ( level utility::flag( "enter_boss_fight_go" ) )
    {
        return;
    }
    
    if ( !level.zm_scarab_mq.s_exfil_loc )
    {
        foreach ( struct in level.s_zm_exfil.var_c7cfc464905e7bcd )
        {
            if ( struct.script_noteworthy == "zone_nexus_exterior_ring" )
            {
                level.zm_scarab_mq.s_exfil_loc = struct;
                break;
            }
        }
    }
    
    if ( level.zm_scarab_mq.s_exfil_loc )
    {
        level.s_zm_exfil.var_c7cfc464905e7bcd = [ level.zm_scarab_mq.s_exfil_loc ];
    }
    
    level.zm_scarab_mq utility::ent_flag_wait( "mq_quest_init_done" );
    quest_step = level.zm_scarab_mq.steps[ level.zm_scarab_mq.var_7be076c9078045aa ];
    
    if ( quest_step.ref == #"cleanse_temples" )
    {
        if ( !level utility::flag( "mq_tmp_guidance_go" ) && level.zm_scarab_mq.var_2a106eed0f98b74b.size && getdvarint( @"hash_3f250537cd05c93e", 0 ) != 3 )
        {
            a_markers = [];
            
            foreach ( seal in level.zm_scarab_mq.var_2a106eed0f98b74b )
            {
                if ( !seal.obj_holder )
                {
                    seal.obj_holder = utility::spawn_model( "tag_origin", seal.origin );
                    seal.obj_holder linkto( seal.var_8293dcbfaa9d666e );
                }
                
                a_markers[ a_markers.size ] = seal.obj_holder;
            }
            
            if ( level.var_cb500ca89b62b266.pedestal_interact )
            {
                a_markers[ a_markers.size ] = level.var_cb500ca89b62b266.pedestal_interact;
            }
            
            hud_data = build_hud_data_array( a_markers, 12 );
            level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"reveal_cranks", 1 );
        }
        else if ( !level utility::flag( "mq_tmp_guidance_go" ) )
        {
            if ( !level utility::flag( "nexus_platforms_begin" ) )
            {
                level thread zm_quest::update_guidance( undefined, #"hash_f7e08be41d80e326", #"hash_48cced3e02723650", 1 );
                level utility::flag_wait( "nexus_platforms_begin" );
                level utility::flag_waitopen( "nexus_platforms_moving" );
            }
            
            level thread zm_quest::clear_all_guidance();
            level utility::flag_set( "mq_tmp_guidance_go" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "sh_symbols_start" ) )
    {
        var_6fdd2f80be44e1bf = getent( "zm_scarab_roof_debris", #targetname );
        var_6fdd2f80be44e1bf setscriptablepartstate( "fx", "scarab_directed" );
        hud_data = [ [ var_6fdd2f80be44e1bf, 64 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"shoot_ball", 1 );
        return;
    }
    
    if ( !level utility::flag( "sh_symbols_maxed" ) && function_1da27cef7cea7ac9() )
    {
        if ( level utility::flag( "redo_safehouse_guidance" ) )
        {
            if ( function_41160421ad0382b().size && !level utility::flag( "redo_phone_answered" ) )
            {
                level utility::flag_clear( "sh_combat_done" );
                hud_data = [ [ level.scarab_phone.origin, 10 ] ];
                level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"answer_phone", 1 );
                return;
            }
            else if ( !function_3f9d6a2be6697770() )
            {
                level utility::flag_clear( "sat_ww_scarab_papd" );
                hud_data = [ [ level.var_db52bcfd04d45a7a[ 0 ].var_370acb837a3a86c3, 64 ] ];
                
                if ( level.scarab_ww_quest.wonder_weapon_item )
                {
                    hud_data = [ [ level.var_db52bcfd04d45a7a[ 0 ].var_370acb837a3a86c3, 64 ], [ level.scarab_ww_quest.wonder_weapon_item, 32 ] ];
                }
                
                level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"hash_9f88f06f99456374", 1 );
                return;
            }
        }
        
        a_symbols = level.zm_scarab_mq.var_de54a609d267d14a;
        var_3471316e3ec32d4a = a_symbols.size;
        
        if ( a_symbols.size < 4 )
        {
            hud_data = undefined;
        }
        else
        {
            hud_data = build_hud_data_array( a_symbols, 64 );
        }
        
        zm_quest::function_cd1f2fee4749fb0a( 1, #"hash_3becabb2f9cd7c65", #"hash_cde791fa2aed136" );
        zm_quest::function_9f49b2a045ece8ae( var_3471316e3ec32d4a, 1, #"hash_3becabb2f9cd7c65", #"hash_cde791fa2aed136" );
        level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"hash_cde791fa2aed136", 1 );
        return;
    }
    
    if ( !level utility::flag( "sat_ww_scarab_papd" ) || !level utility::flag( "wanna_wingo_eh" ) && !function_3f9d6a2be6697770() && !function_41160421ad0382b().size )
    {
        level utility::flag_clear( "sat_ww_scarab_papd" );
        var_a4e04bd0db57432a = function_3f9d6a2be6697770();
        
        if ( var_a4e04bd0db57432a )
        {
            level utility::flag_set( "sat_ww_scarab_papd" );
            level thread function_e0d5285bfbad4e41();
            return;
        }
        
        hud_data = [ [ level.var_db52bcfd04d45a7a[ 0 ].var_370acb837a3a86c3, 64 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"hash_9f88f06f99456374", 1 );
        
        if ( !level utility::flag( "wanna_wingo_eh" ) && level utility::flag( "chicky_bicky_bambam" ) )
        {
            level utility::flag_set( "redo_safehouse_guidance" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "sh_symbols_solved" ) && function_1da27cef7cea7ac9() && !function_41160421ad0382b().size )
    {
        hud_data = [ [ level.zm_scarab_mq.var_de54a609d267d14a[ 0 ], 64 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"hash_838f5e1a4ef0c6ef", 1 );
        return;
    }
    
    if ( !level.var_f78688c167b4bb9d && function_1da27cef7cea7ac9() && !function_41160421ad0382b().size )
    {
        level thread function_c2cde602dc65b1ed();
        return;
    }
    
    if ( !level utility::flag( "pickle_takes_tomato" ) && !function_41160421ad0382b().size && ( !level utility::flag( "poppa_bop_boopy" ) || level utility::flag( "redo_safehouse_guidance" ) ) )
    {
        hud_data = [ [ level.zm_scarab_mq.s_exfil_loc, 184 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"activate_exfil", 1 );
        return;
    }
    
    if ( level utility::flag( "chicky_bicky_bambam" ) && !level utility::flag( "sh_combat_done" ) && !level utility::flag( "sh_combat_go" ) )
    {
        level thread zm_quest::clear_all_guidance();
        return;
    }
    
    if ( !level utility::flag( "hueh_ho_hiya" ) && level utility::flag( "sh_combat_go" ) )
    {
        s_safehouse = utility::getstruct( "tw_scene_success" );
        hud_data = [ [ s_safehouse, 0, 666 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"hash_577d0ab0bf9f9b36", 1 );
        return;
    }
    
    if ( !level utility::flag( "hueh_ho_hiya" ) )
    {
        hud_data = [ [ level.zm_scarab_mq.var_d05c101ef52472fa ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"knockdown_box", 1 );
        wait 5;
        
        foreach ( player in level.players )
        {
            if ( player function_856e69a265ae940c() )
            {
                player thread ww_shared::show_hud_tutorial_message( &"hash_2ff538a33b629bd2" );
            }
        }
        
        return;
    }
    
    if ( !level utility::flag( "wanna_wingo_eh" ) )
    {
        hud_data = [ [ level.zm_scarab_mq.var_1b004718c0efb9be, 16 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"pickup_i", 1 );
        return;
    }
    
    if ( quest_step.ref == #"upgrade_pedestal" )
    {
        if ( level utility::flag( "sh_combat_go" ) )
        {
            s_safehouse = utility::getstruct( "tw_scene_success" );
            hud_data = [ [ s_safehouse, 0, 666 ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"hash_577d0ab0bf9f9b36", 1 );
        }
        else if ( istrue( level.var_255753bd26bf0bdd ) )
        {
            hud_data = [ [ level.scarab_phone.origin, 10 ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"answer_phone", 1 );
        }
        else
        {
            a_pedestals = utility::getstructarray( "np_loc" );
            
            foreach ( struct in a_pedestals )
            {
                if ( struct.script_noteworthy == "1" )
                {
                    s_marker = struct;
                    break;
                }
            }
            
            hud_data = [ [ s_marker, 72 ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"hash_fdb83675fec3e90e", 1 );
        }
        
        return;
    }
    
    if ( quest_step.ref == #"clear_gears" )
    {
        if ( level.zm_scarab_mq.a_panel_guidance.size )
        {
            hud_data = build_hud_data_array( level.zm_scarab_mq.a_panel_guidance, 5 );
            
            if ( level.var_cb500ca89b62b266.pedestal_interact )
            {
                var_f8270170d75c491f = [ level.var_cb500ca89b62b266.pedestal_interact, 12 ];
                hud_data[ hud_data.size ] = var_f8270170d75c491f;
            }
            
            level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"remove_seals", 1 );
        }
        else
        {
            if ( level.zm_scarab_mq.var_b156e78e204b43.size >= 4 )
            {
                var_77334e918f2b1b78 = utility::array_slice( level.zm_scarab_mq.var_b156e78e204b43, 0, 4 );
            }
            
            hud_data = build_hud_data_array( var_77334e918f2b1b78 ?? level.zm_scarab_mq.var_b156e78e204b43 );
            level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"clear_webs", 1 );
        }
        
        return;
    }
    
    if ( quest_step.ref == #"restart_engine" )
    {
        hud_data = [ [ level.var_db52bcfd04d45a7a[ 0 ].var_370acb837a3a86c3, 64 ], [ level.zm_scarab_mq.var_df4a9f862b20305f, 12 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"hash_d6a7bc88810da0e4", 1 );
        level utility::flag_wait( "power_surge_active" );
        hud_data = [ [ level.zm_scarab_mq.var_df4a9f862b20305f, 12 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"hash_cbf305887a6931ef", 1 );
        level.zm_scarab_mq.var_df4a9f862b20305f.interact_hint_callback = &function_62f7d623ba1c37ad;
        level utility::flag_waitopen_any( "power_surge_active", "forgeo_reverseo" );
        level.zm_scarab_mq.var_df4a9f862b20305f.interact_hint_callback = undefined;
        
        if ( level utility::flag( "power_surge_active" ) )
        {
            level thread zm_quest::update_guidance( undefined, #"hash_3becabb2f9cd7c65", #"hash_cbf304887a69303c", 1 );
            wait 2;
        }
        
        level thread function_e0d5285bfbad4e41();
        return;
    }
    
    if ( quest_step.ref == #"enter_boss_fight" )
    {
        s_platform = utility::getstruct( "bf_lift_center" );
        
        if ( !s_platform.interact )
        {
            a_tiles = getentarray( "bf_lift_tile", #targetname );
            var_f144346027c675dd = [];
            
            foreach ( tile in a_tiles )
            {
                var_f144346027c675dd[ var_f144346027c675dd.size ] = tile.origin;
                
                if ( var_f144346027c675dd.size == level.players.size )
                {
                    break;
                }
            }
            
            hud_data = build_hud_data_array( var_f144346027c675dd, 32 );
            level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"hash_cf5a9c70dd8e5142", 1 );
            return;
        }
        
        hud_data = [ [ s_platform, 48 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_3becabb2f9cd7c65", #"start_boss_fight", 1 );
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0x4
// Checksum 0x305ecb4a, Offset: 0xf021
// Size: 0x65
function private build_hud_data_array( array, offset )
{
    hud_data = [];
    
    if ( !isdefined( offset ) )
    {
        offset = 0;
    }
    
    for ( i = 0; i < array.size ; i++ )
    {
        marker = [ array[ i ], offset ];
        hud_data[ hud_data.size ] = marker;
    }
    
    return hud_data;
}

// Namespace zm_sat_scarab_mq
// Params 2
// Checksum 0x8d966171, Offset: 0xf08f
// Size: 0x70
function function_62f7d623ba1c37ad( interact, player )
{
    if ( player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"SHARED_HINTSTRINGS/USE", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0xc
// Checksum 0x83b6b6e1, Offset: 0xf108
// Size: 0x8d
function private function_c2cde602dc65b1ed()
{
    self notify( #"hash_a297ea7d781a1cf4" );
    self endon( #"hash_a297ea7d781a1cf4" );
    level endon( #"chicky_bicky_bambam" );
    
    if ( level utility::flag( "wanna_wingo_eh" ) )
    {
        return;
    }
    
    level utility::flag_clear( "exfil_window_active" );
    level.var_f78688c167b4bb9d = 1;
    level.var_4d146d09c3834279 = 1;
    level.var_ae6ec3d5ec830a1 = undefined;
    level utility::flag_set( "rbz_allow_exfil" );
    level zm_exfil_sat::on_round_end();
    level utility::flag_wait( "exfil_window_active" );
    level thread function_e0d5285bfbad4e41();
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xae300fb3, Offset: 0xf19d
// Size: 0x46
function private function_52708afcf151d781()
{
    if ( !zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level.var_f78688c167b4bb9d = undefined;
    level.var_4d146d09c3834279 = undefined;
    level.var_ae6ec3d5ec830a1 = 1;
    level utility::flag_waitopen( "exfil_window_active" );
    level utility::flag_clear( "rbz_allow_exfil" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0xc
// Checksum 0x58e8c67e, Offset: 0xf1eb
// Size: 0x44
function private function_2c13d4c261153217()
{
    self notify( #"hash_55a0e64027b152a9" );
    self endon( #"hash_55a0e64027b152a9" );
    level utility::flag_wait( "exfil_window_active" );
    level thread function_e0d5285bfbad4e41();
    level utility::flag_wait( "exfil_active" );
    level thread function_e0d5285bfbad4e41();
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x19fe2413, Offset: 0xf237
// Size: 0x1f, Type: bool
function private function_1da27cef7cea7ac9()
{
    return !level utility::flag( "chicky_bicky_bambam" ) || level utility::flag( "redo_safehouse_guidance" );
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x17822fa7, Offset: 0xf25f
// Size: 0x81, Type: bool
function private function_3f9d6a2be6697770()
{
    foreach ( player in level.players )
    {
        if ( player function_856e69a265ae940c() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0xf7b81a05, Offset: 0xf2e9
// Size: 0x8d, Type: bool
function private function_bb944bb3079c8286()
{
    a_players = function_41160421ad0382b();
    
    foreach ( player in a_players )
    {
        if ( player function_856e69a265ae940c() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_mq
// Params 0, eflags: 0x4
// Checksum 0x60bf73cd, Offset: 0xf37f
// Size: 0xaf, Type: bool
function private function_856e69a265ae940c()
{
    var_3df86f0b126863ab = self getweaponslistall();
    
    foreach ( weapon in var_3df86f0b126863ab )
    {
        if ( weapon.basename == level.scarabww_basename )
        {
            paplevel = namespace_9d8e359c3b1041e5::function_1d4087075103b248( weapon );
            
            if ( paplevel > 0 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0x4
// Checksum 0xfeac5d99, Offset: 0xf437
// Size: 0x89
function private function_fc03729ecb12b199( params )
{
    if ( params.weapon.basename == level.scarabww_basename && !level utility::flag( "sat_ww_scarab_papd" ) )
    {
        paplevel = namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.weapon );
        
        if ( paplevel > 0 && !level utility::flag( "sat_ww_scarab_papd" ) )
        {
            level utility::flag_set( "sat_ww_scarab_papd" );
            level thread function_e0d5285bfbad4e41();
        }
    }
}

// Namespace zm_sat_scarab_mq
// Params 5
// Checksum 0x13be00f2, Offset: 0xf4c8
// Size: 0xc3
function function_7038fcc5de4df138( var_80ce893c79d1d533, str_flag, a_players, n_delay, b_convo = 1 )
{
    if ( level utility::flag( str_flag ) )
    {
        return;
    }
    
    level utility::flag_set( str_flag );
    
    if ( n_delay )
    {
        wait n_delay;
    }
    
    if ( !isdefined( a_players ) )
    {
        a_players = level.players;
    }
    
    zm_quest::function_8934bb2a9028bdc5();
    utility::flag_set( "scarab_mq_vo_playing" );
    
    if ( b_convo )
    {
        b_success = level overlord::playconversation( var_80ce893c79d1d533, a_players );
    }
    else
    {
        b_success = level overlord::playevent( var_80ce893c79d1d533, a_players );
    }
    
    utility::flag_clear( "scarab_mq_vo_playing" );
    
    if ( !b_success )
    {
        level utility::flag_clear( str_flag );
    }
    
    return b_success;
}

// Namespace zm_sat_scarab_mq
// Params 5
// Checksum 0xde0e21fa, Offset: 0xf594
// Size: 0x1a6
function play_banter_once( var_80ce893c79d1d533, str_flag, a_players, var_f1772df0e5a2f445, n_delay )
{
    if ( level utility::flag( str_flag ) )
    {
        return;
    }
    
    level utility::flag_set( str_flag );
    
    if ( n_delay )
    {
        wait n_delay;
    }
    
    if ( !isdefined( a_players ) )
    {
        a_players = level.players;
    }
    
    foreach ( player in a_players )
    {
        if ( player player_banter::function_4e1aff6241ebea8() )
        {
            player_banter::function_850de641659a4090();
        }
    }
    
    utility::flag_set( "scarab_mq_vo_playing" );
    b_success = var_80ce893c79d1d533 == "str_play_bc_generic_vo_instead" ? 0 : level player_banter::play_banter_vo( var_80ce893c79d1d533, a_players );
    
    if ( !b_success && var_f1772df0e5a2f445 )
    {
        foreach ( player in a_players )
        {
            b_success = level battlechatter_mp::trysaylocalsound( player, var_f1772df0e5a2f445 );
            
            if ( b_success )
            {
                break;
            }
        }
    }
    
    utility::flag_clear( "scarab_mq_vo_playing" );
    
    if ( !b_success )
    {
        level utility::flag_clear( str_flag );
    }
    
    return b_success;
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0x83a21050, Offset: 0xf743
// Size: 0x4f
function function_95b86968754aa670( params )
{
    if ( isdefined( params.entity ) )
    {
        target_ent = params.entity;
    }
    else
    {
        target_ent = self getgrappletargetentity();
    }
    
    if ( isalive( target_ent ) )
    {
        target_ent thread function_eb527d201f190972( self );
    }
}

// Namespace zm_sat_scarab_mq
// Params 1, eflags: 0xc
// Checksum 0x6817c4f9, Offset: 0xf79a
// Size: 0x195
function private function_eb527d201f190972( player_grappler )
{
    self notify( #"hash_2b2f52418a16c21a" );
    self endon( #"hash_2b2f52418a16c21a" );
    self endon( #"death" );
    
    if ( !isdefined( self.subclass ) )
    {
        return;
    }
    
    switch ( self.subclass )
    {
        case #"hash_9de4699c88b66354":
            var_4a130743b2f3b4a4 = player_grappler.origin + anglestoforward( player_grappler.angles ) * 75;
            
            if ( !isdefined( self.shadow_soul_owner ) )
            {
                self.shadow_soul_owner = {};
            }
            
            if ( !isdefined( self.shadow_soul_teleport_origin ) )
            {
                self.shadow_soul_teleport_origin = self.origin;
            }
            
            self.shadow_soul_owner thread zombie_weyward_shadow_soul::function_53cb0174251a4270( self, var_4a130743b2f3b4a4, 1500 );
            utility::function_7c10ea82c1e305b8( "shadow_soul_fx", "grapple_vulnerable" );
            function_b25bf10a6b6d5dfc( 3, 0.25, player_grappler );
            utility::function_7c10ea82c1e305b8( "shadow_soul_fx", "ambient" );
            self.shadow_soul_owner thread zombie_weyward_shadow_soul::function_53cb0174251a4270( self, self.shadow_soul_teleport_origin );
            break;
        case #"hash_a38a8f1e60b2e94":
            self.v_target_pos_override = player_grappler.origin + ( 0, 0, 25 ) + anglestoforward( player_grappler.angles ) * 75;
            function_b25bf10a6b6d5dfc( 3, 0.25, player_grappler );
            self.var_175f2edcb822a477 = 1;
            self.v_target_pos_override = undefined;
            wait 1;
            self.var_175f2edcb822a477 = undefined;
            break;
    }
}

// Namespace zm_sat_scarab_mq
// Params 3, eflags: 0xc
// Checksum 0x966a9f38, Offset: 0xf937
// Size: 0x100
function private function_b25bf10a6b6d5dfc( var_25a202f50163a470, n_damage_pct, player_grappler )
{
    self notify( #"hash_d8b47b7c0adcd19c" );
    self endon( #"hash_d8b47b7c0adcd19c" );
    self endon( #"death" );
    player_grappler setvelocity( ( 0, 0, 0 ) );
    player_grappler function_5c764e554642cf04();
    self dodamage( self.maxhealth * n_damage_pct, self.origin, player_grappler, undefined, "MOD_CRUSH", makeweapon( "sat_grappling_hook_zm" ) );
    self.var_70e2cd76631d2140 = 1;
    utility::function_7c10ea82c1e305b8( "grapple_vulnerable", "on" );
    
    if ( utility::function_4c656524ecb504d6( "grappled" ) )
    {
        thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "grappled", "grappled" );
    }
    
    thread function_411684bfcaf8fa03( player_grappler );
    wait var_25a202f50163a470;
    self.var_70e2cd76631d2140 = undefined;
    utility::function_7c10ea82c1e305b8( "grapple_vulnerable", "off" );
    
    if ( utility::function_4c656524ecb504d6( "grappled" ) )
    {
        thread utility::animscripted_clear();
    }
}

// Namespace zm_sat_scarab_mq
// Params 2, eflags: 0xc
// Checksum 0x526bef30, Offset: 0xfa3f
// Size: 0xd1
function private function_411684bfcaf8fa03( player, n_time = 0.5 )
{
    self notify( #"hash_cdc850e0d4d67164" );
    self endon( #"hash_cdc850e0d4d67164" );
    e_mover = self.soul_carrier ?? self.skull_carrier ?? self.e_mover;
    
    if ( isdefined( e_mover ) )
    {
        vdir = player.origin - e_mover.origin;
        yaw = vectortoyaw( vdir );
        v_rotate_to_angles = ( e_mover.angles[ 0 ], yaw, e_mover.angles[ 2 ] );
        e_mover rotateto( v_rotate_to_angles, n_time );
        wait n_time;
    }
}

// Namespace zm_sat_scarab_mq
// Params 1
// Checksum 0xbb145c9, Offset: 0xfb18
// Size: 0x4c
function function_d3db8c47e794100( params )
{
    if ( self.var_70e2cd76631d2140 && params.smeansofdeath == "MOD_MELEE" && isplayer( params.eattacker ) )
    {
        return self.health;
    }
    
    return -1;
}

/#

    // Namespace zm_sat_scarab_mq
    // Params 0, eflags: 0x4
    // Checksum 0x25a1baa3, Offset: 0xfb6d
    // Size: 0xcd, Type: dev
    function private symbols_debug()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_5e3748fde52ad219", 0 ) || getdvarint( @"hash_c4bf10548bb81070", 0 ) )
            {
                foreach ( var_825261bedb0065e6 in level.zm_scarab_mq.var_de54a609d267d14a )
                {
                    if ( var_825261bedb0065e6.var_7e2f5dd7a65a6e53 == 1 )
                    {
                        var_825261bedb0065e6 setscriptablepartstate( "<dev string:xe0>", "<dev string:x60>" );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_scarab_mq
    // Params 0, eflags: 0x4
    // Checksum 0x2bf25a17, Offset: 0xfc42
    // Size: 0x23e, Type: dev
    function private function_fd8d1c802cb9cd39()
    {
        devgui::function_9082edeb5db93280( "<dev string:xe6>" );
        devgui::add_devgui_func( "<dev string:x100>", "<dev string:x115>", &test_safehouse );
        devgui::function_cd4e263c1f3018ae( "<dev string:x11b>", "<dev string:x133>", &function_59ea1a623a1278cb );
        devgui::function_cd4e263c1f3018ae( "<dev string:x13f>", "<dev string:x166>", &function_59ea1a623a1278cb );
        devgui::function_cd4e263c1f3018ae( "<dev string:x183>", "<dev string:x199>", &function_c203480139ea58ba );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1a5>", "<dev string:x1ba>", &function_c203480139ea58ba );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1c5>", "<dev string:x1d8>", &function_c203480139ea58ba );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1e1>", "<dev string:x1f8>", &function_c203480139ea58ba );
        devgui::function_cd4e263c1f3018ae( "<dev string:x205>", "<dev string:x21b>", &function_c203480139ea58ba );
        devgui::function_cd4e263c1f3018ae( "<dev string:x227>", "<dev string:x239>", &function_c203480139ea58ba );
        devgui::function_cd4e263c1f3018ae( "<dev string:x241>", "<dev string:x25c>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x268>", "<dev string:x288>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x299>", "<dev string:x2b5>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2c3>", "<dev string:x2e4>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2fc>", "<dev string:x316>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x322>", "<dev string:x341>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x352>", "<dev string:x36d>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x37b>", "<dev string:x39b>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3b3>", "<dev string:x3cb>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3d7>", "<dev string:x3f4>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x405>", "<dev string:x41e>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x42c>", "<dev string:x44a>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x462>", "<dev string:x47e>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x48a>", "<dev string:x4ab>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4bc>", "<dev string:x4d9>", &mouth_anim );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4e7>", "<dev string:x509>", &mouth_anim );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_scarab_mq
    // Params 1, eflags: 0x4
    // Checksum 0x5107c880, Offset: 0xfe88
    // Size: 0x59, Type: dev
    function private mouth_anim( a_params )
    {
        var_8af4bb0185feb88 = a_params[ 0 ];
        str_state = a_params[ 1 ];
        var_c810c698cea03d98 = getent( "<dev string:x521>" + var_8af4bb0185feb88, #targetname );
        var_c810c698cea03d98 setscriptablepartstate( "<dev string:x536>", str_state );
    }

    // Namespace zm_sat_scarab_mq
    // Params 1, eflags: 0x4
    // Checksum 0xa5664820, Offset: 0xfee9
    // Size: 0x27d, Type: dev
    function private function_59ea1a623a1278cb( params )
    {
        if ( !level.zm_scarab_mq.a_panel_seals )
        {
            setup_sealed_panels();
        }
        
        foreach ( instance in level.zm_scarab_mq.a_panel_seals )
        {
            instance setscriptablepartstate( "<dev string:x53b>", "<dev string:x540>" );
            instance setscriptablepartstate( "<dev string:x544>", "<dev string:x54b>" );
            instance notify( #"seal_removed" );
            
            if ( instance.var_1af8bf945e6e471c )
            {
                instance.var_1af8bf945e6e471c.a_seals = arrayremove( instance.var_1af8bf945e6e471c.a_seals, instance );
                
                if ( level.zm_scarab_mq.a_panel_guidance )
                {
                    level.zm_scarab_mq.a_panel_guidance = arrayremove( level.zm_scarab_mq.a_panel_guidance, instance );
                }
                
                level thread function_e0d5285bfbad4e41();
                function_cafc24dfffbfc7fa( instance.script_noteworthy, #"hash_e95eb8492b771f78" );
                
                if ( instance.var_1af8bf945e6e471c.a_seals.size == 0 )
                {
                    instance.var_1af8bf945e6e471c thread function_26521cf5c5dfe949();
                }
            }
            
            waitframe();
        }
        
        if ( params[ 0 ] == 1 || params[ 0 ] == "<dev string:x559>" )
        {
            foreach ( web in level.zm_scarab_mq.a_webs )
            {
                if ( isent( web ) )
                {
                    web delete();
                }
                else if ( web getscriptablepartstate( "<dev string:x53b>" ) != "<dev string:x55b>" )
                {
                    web setscriptablepartstate( "<dev string:x53b>", "<dev string:x540>" );
                }
                
                waitframe();
            }
            
            level utility::flag_set( "<dev string:x55f>" );
        }
    }

    // Namespace zm_sat_scarab_mq
    // Params 1, eflags: 0x4
    // Checksum 0xef06fbca, Offset: 0x1016e
    // Size: 0x2f1, Type: dev
    function private function_c203480139ea58ba( a_params )
    {
        deactivateworldevent( "<dev string:x56e>" );
        deactivateworldevent( "<dev string:x582>" );
        deactivateworldevent( "<dev string:x596>" );
        deactivateworldevent( "<dev string:x5aa>" );
        deactivateworldevent( "<dev string:x5be>" );
        level utility::flag_clear( "<dev string:x5d7>" );
        level utility::flag_clear( "<dev string:x5eb>" );
        level utility::flag_clear( "<dev string:x5ff>" );
        level utility::flag_clear( "<dev string:x613>" );
        getent( "<dev string:x627>", #targetname ) setscriptablepartstate( "<dev string:x536>", "<dev string:x63d>" );
        getent( "<dev string:x643>", #targetname ) setscriptablepartstate( "<dev string:x536>", "<dev string:x63d>" );
        getent( "<dev string:x659>", #targetname ) setscriptablepartstate( "<dev string:x536>", "<dev string:x63d>" );
        getent( "<dev string:x66f>", #targetname ) setscriptablepartstate( "<dev string:x536>", "<dev string:x63d>" );
        mdl_channeler = getent( "<dev string:x685>", #targetname );
        stopfxontag( level._effect[ #"hash_d4a1fe7e4b6f48f8" ], mdl_channeler, "<dev string:x69a>" );
        playworldsound( mdl_channeler.origin + ( 0, 0, 25 ), #"hash_d1b69214449f493d" );
        
        if ( level.scarab_pap_quest.var_9d15330b141fe52f )
        {
            level.scarab_pap_quest.var_9d15330b141fe52f setscriptablepartstate( "<dev string:x6a1>", "<dev string:x55b>" );
        }
        
        if ( level.zm_scarab_mq.var_e6380a1b95bd817e )
        {
            stopfxontag( level._effect[ #"hash_5a739e4db08befc9" ], level.zm_scarab_mq.var_e6380a1b95bd817e, "<dev string:x6aa>" );
        }
        
        if ( level.zm_scarab_mq.var_d128e0d1cb82b144 )
        {
            level.zm_scarab_mq.var_d128e0d1cb82b144 delete();
        }
        
        reset_gimbals();
        var_89b8fe7ede93d5b3 = int( a_params[ 0 ] );
        
        foreach ( var_29aa1f4b1eaa2a4 in level.zm_scarab_mq.a_rings )
        {
            var_29aa1f4b1eaa2a4.n_rotate_slot = var_89b8fe7ede93d5b3;
        }
        
        for ( i = 0; i < 6 ; i++ )
        {
            if ( i != var_89b8fe7ede93d5b3 )
            {
                function_339b830137e4badc( 0, i );
            }
        }
        
        set_ring_rotation( 1, 1 );
        function_339b830137e4badc( 1, var_89b8fe7ede93d5b3 );
        level thread function_33008a6d7a4ca2bb( var_89b8fe7ede93d5b3 );
    }

    // Namespace zm_sat_scarab_mq
    // Params 0, eflags: 0x4
    // Checksum 0x46ceea65, Offset: 0x10467
    // Size: 0x26, Type: dev
    function private test_safehouse()
    {
        zm_sat_scarab_phone::function_e31fd04f8a18de90();
        function_af2100bd9d9f70b3( level.players[ 0 ] );
        level thread function_88183d17cd1118b9();
    }

    // Namespace zm_sat_scarab_mq
    // Params 0, eflags: 0x4
    // Checksum 0xc6c68548, Offset: 0x10495
    // Size: 0x2f3, Type: dev
    function private mq_debug()
    {
        level thread symbols_debug();
        function_fd8d1c802cb9cd39();
        level utility::flag_wait( "<dev string:x6b5>" );
        level utility::flag_wait( "<dev string:x6c7>" );
        level.zm_scarab_mq utility::ent_flag_wait( "<dev string:x6d0>" );
        var_6473fcc8bf5c22f1 = getdvarint( @"hash_3f250537cd05c93e", 0 );
        
        if ( var_6473fcc8bf5c22f1 && var_6473fcc8bf5c22f1 < 3 )
        {
            level thread zm_quest::start_quest( #"hash_f6b10d1f1c4575a" );
            level thread zm_quest::start_quest( #"hash_a9ed33fe4d2ef275" );
            level thread zm_quest::start_quest( #"hash_2d753cdc71ad3528" );
            level thread zm_quest::start_quest( #"hash_8f67bf8336da87a4" );
            
            if ( var_6473fcc8bf5c22f1 == 2 )
            {
                wait 1;
                level thread zm_quest::function_11b75e2232ce3d4( [ #"destroy_visage", 0, #"hash_f6b10d1f1c4575a" ] );
                level thread zm_quest::function_11b75e2232ce3d4( [ #"destroy_visage", 0, #"hash_a9ed33fe4d2ef275" ] );
                level thread zm_quest::function_11b75e2232ce3d4( [ #"destroy_visage", 0, #"hash_2d753cdc71ad3528" ] );
                level thread zm_quest::function_11b75e2232ce3d4( [ #"destroy_visage", 0, #"hash_8f67bf8336da87a4" ] );
            }
            else if ( var_6473fcc8bf5c22f1 == 1 )
            {
                wait 1;
                level thread zm_quest::function_11b75e2232ce3d4( [ #"reveal_corruption", 0, #"hash_f6b10d1f1c4575a" ] );
                level thread zm_quest::function_11b75e2232ce3d4( [ #"reveal_corruption", 0, #"hash_a9ed33fe4d2ef275" ] );
                level thread zm_quest::function_11b75e2232ce3d4( [ #"reveal_corruption", 0, #"hash_2d753cdc71ad3528" ] );
                level thread zm_quest::function_11b75e2232ce3d4( [ #"reveal_corruption", 0, #"hash_8f67bf8336da87a4" ] );
            }
        }
        
        n_debug = getdvarint( @"hash_d62ffa0adc14adc7", 0 );
        
        if ( n_debug == 1 )
        {
            level thread zm_quest::function_f4862fe4218197b2( [ #"scarab_ww_quest", #"pick_up_ww" ] );
        }
        else if ( n_debug == 2 )
        {
            level thread zm_quest::function_11b75e2232ce3d4( [ #"restart_engine" ] );
        }
        else if ( n_debug == 3 )
        {
            level thread zm_quest::function_11b75e2232ce3d4( [ #"cleanse_temples" ] );
        }
        else if ( n_debug == 4 )
        {
            level thread zm_quest::function_11b75e2232ce3d4( [ #"clear_gears" ] );
            wait 1;
            function_59ea1a623a1278cb();
        }
        
        var_89b8fe7ede93d5b3 = getdvarint( @"hash_185f80864f951492", 0 );
        
        if ( var_89b8fe7ede93d5b3 )
        {
            level utility::flag_wait( "<dev string:x6e3>" );
            wait 1;
            function_c203480139ea58ba( [ var_89b8fe7ede93d5b3 ] );
        }
    }

#/
