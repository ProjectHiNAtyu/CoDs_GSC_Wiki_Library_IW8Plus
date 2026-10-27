// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_pap_quest.gsc  (hash_0321e618438617e2.gscc) (size: 114506 Bytes / 0x1bf4a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd1ae938f (3517879183)
// size ...... 114506 (0x1bf4a)
// includes .. 53  (offset: 0x1a4f6)
// strings ... 309 (offset: 0x1a69e)
// dev strs .. 71  (offset: 0x1bb9a)
// exports ... 125 (offset: 0x14312)
// cseg ...... 0x1852 + 0x12ac0 (0x14312)
// imports ... 575 (offset: 0x1569a)
// animtree1 . 0   (offset: 0x1bf4a)
// animtree2 . 0   (offset: 0x1bf4a)
#using script_16ea1b94f0f381b3;
#using script_38234c6dc0321d2a;
#using script_61b40095fd0502f0;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\equipment\mini_sentry;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\equipment\smart_seeker;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\common\powerups\nuke;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\gametypes\common;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\pack_a_punch;
#using scripts\mp\player_banter;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\weapons;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rb;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_usurped_power;
#using scripts\mp\zm\points;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_pap_quest;

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x5
// Checksum 0x5fc76e6a, Offset: 0x1870
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_pap_quest", undefined, undefined, &init );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0
// Checksum 0x9df83ded, Offset: 0x1891
// Size: 0x108
function init()
{
    level utility::registersharedfunc( #"zm_quest", #"hash_9b839bc2ba7777ff", &is_pap_quest_complete );
    level.scarab_pap_quest = zm_quest::get_quest( #"scarab_pap_quest" );
    
    if ( !( isusingmatchrulesdata() && getmatchrulesdata( "zmData", "papQuest" ) ) )
    {
        if ( utility::issharedfuncdefined( #"scarab_pap_quest", #"hash_c87b411e7826157c" ) )
        {
            level thread utility::callsharedfunc( #"scarab_pap_quest", #"hash_c87b411e7826157c" );
            return;
        }
        
        level utility::flag_wait_all( "zm_sat_scarab_script_quest_pap_cs_completed", "scriptables_ready" );
        level thread init_pap_quest_assets( 1 );
        return;
    }
    
    level utility::flag_wait_all( "zm_sat_scarab_script_quest_pap_cs_completed", "scriptables_ready" );
    level thread function_c561c0c29a089a62();
    level thread init_pap_quest_assets();
    level namespace_e9c7b42a427c6c3a::init();
    
    if ( level.scarab_pap_quest.completed == 0 )
    {
        level val::set( "task_scarab_pap", "task_logic_activate", 0 );
    }
    
    /#
        level thread init_pap_debug();
    #/
}

// Namespace zm_sat_scarab_pap_quest
// Params 0
// Checksum 0xfa2779c1, Offset: 0x19a1
// Size: 0x11
function is_pap_quest_complete()
{
    return zm_quest::is_quest_complete( #"scarab_pap_quest" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x723fce72, Offset: 0x19bb
// Size: 0x1bc8
function private init_pap_quest_assets( is_quest_off = 0 )
{
    level endon( #"game_ended" );
    level zm_quest::function_b57dfe9625966b0b( #"scarab_misc", 0, #"world_seed", 1 );
    level.scarab_pap_quest.var_3beeb295fe09e9bf = [];
    level.scarab_pap_quest.var_fce0c3e197569778 = [];
    level.scarab_pap_quest.event_banter = [ #"hash_452b8909c2523f20":{ #fallback:#"hash_5212ed7ec42f115a", #bantername:"scarab_pap_s_f_b" }, #"hash_2049f009accbf065":{ #bantername:"scarab_pap_s_f_k" }, #"hash_30048b153d63c135":{ #fallback:#"bc_flavor_player_positive", #bantername:"scarab_pap_p_u_u_p" }, #"hash_7355ed11646a36a1":{ #fallback:#"hash_5212ed7ec42f115a", #bantername:"scarab_pap_p_u_b_f" }, #"hash_88369e0d8765096f":{ #fallback:#"bc_flavor_player_positive", #bantername:"scarab_pap_s_d" }, #"hash_88369d0d876507bc":{ #fallback:#"bc_flavor_player_negative", #bantername:"scarab_pap_w_t_r" }, #"hash_dc4ed84b0148d33a":{ #bantername:"scarab_pap_p_w_s" } ];
    var_a05d089d117bf075 = utility::getstruct( "pq_forge_end", "targetname" );
    level.scarab_pap_quest.var_9d15330b141fe52f = spawnscriptable( %"sat_zm_quest_scarab_pap", var_a05d089d117bf075.origin, var_a05d089d117bf075.angles );
    level.scarab_pap_quest.var_9d15330b141fe52f.clip = getent( "pq_forge_end_clip", #targetname );
    level.scarab_pap_quest.var_9d15330b141fe52f.clip connectpaths();
    s_papq_forge_audio = utility::getstruct( "papq_forge_audio", "targetname" );
    level.var_c57f2e874f4ba092 = spawnscriptable( "sat_zm_quest_scarab_pap_ring_audio", s_papq_forge_audio.origin );
    level.scarab_pap_quest.var_9d15330b141fe52f.var_370acb837a3a86c3 = level.scarab_pap_quest.var_9d15330b141fe52f;
    level.scarab_pap_quest.var_9d15330b141fe52f.s_pap = level.scarab_pap_quest.var_9d15330b141fe52f;
    level.var_db52bcfd04d45a7a = arraycombineunique( level.var_db52bcfd04d45a7a, [ level.scarab_pap_quest.var_9d15330b141fe52f ] );
    level.scarab_pap_quest.var_9d15330b141fe52f.interact = interaction::register_scriptable_interact( level.scarab_pap_quest.var_9d15330b141fe52f, &on_use_pap_machine, undefined, undefined, &pap_per_player_hint );
    e_mover = utility::spawn_model( "tag_origin", level.scarab_pap_quest.var_9d15330b141fe52f.origin, level.scarab_pap_quest.var_9d15330b141fe52f.angles );
    level.scarab_pap_quest.var_9d15330b141fe52f utility::scriptable_setparententity( e_mover );
    level.scarab_pap_quest.e_sound_tag = utility::spawn_model( "tag_origin", level.scarab_pap_quest.var_9d15330b141fe52f.origin, level.scarab_pap_quest.var_9d15330b141fe52f.angles );
    e_mover.lowerzoffset = -287;
    level.scarab_pap_quest.var_9d15330b141fe52f.clip.lowerzoffset = -287;
    level.scarab_pap_quest.var_9d15330b141fe52f.var_370acb837a3a86c3.interact = level.scarab_pap_quest.var_9d15330b141fe52f.interact;
    level.scarab_pap_quest.var_9d15330b141fe52f.var_370acb837a3a86c3.var_e7d3b195989ad581 = 128;
    level.scarab_pap_quest.var_9d15330b141fe52f.s_pap_menu = pack_a_punch::function_870d519a9b809a9c( level.scarab_pap_quest.var_9d15330b141fe52f.origin );
    
    if ( !is_quest_off )
    {
        level.scarab_pap_quest.var_9d15330b141fe52f.var_370acb837a3a86c3 pack_a_punch::disable_pap( 1 );
        level.scarab_pap_quest.var_9d15330b141fe52f.var_370acb837a3a86c3.var_d29eb957aaffcbbd = { #var_370acb837a3a86c3:level.scarab_pap_quest.var_9d15330b141fe52f.var_370acb837a3a86c3, #script_power:"power_on" };
        level.scarab_pap_quest.var_9d15330b141fe52f.var_370acb837a3a86c3.var_d29eb957aaffcbbd thread pack_a_punch::function_6bef4f03bfe01f85();
    }
    
    level.scarab_pap_quest.var_9d15330b141fe52f thread pack_a_punch::function_d9ce48cca2ff225b();
    level.scarab_pap_quest.var_9d15330b141fe52f thread function_4aa2592711d45598();
    level thread function_c992397f20685522();
    level.scarab_pap_quest.s_seed = utility::function_30dbabe3200518b( "pq_seed", #targetname );
    level.scarab_pap_quest.s_seed.interact = interaction::register_scriptable_interact( level.scarab_pap_quest.s_seed, &function_2af656c4985a7ed5 );
    level.scarab_pap_quest.s_seed.interact.s_seed = level.scarab_pap_quest.s_seed;
    level.scarab_pap_quest.s_seed.fx_tag = utility::spawn_model( "tag_origin", level.scarab_pap_quest.s_seed.origin + ( 0, 0, 8 ), level.scarab_pap_quest.s_seed.angles );
    level.scarab_pap_quest.s_seed utility::function_7c10ea82c1e305b8( "usable", "usable" );
    level.scarab_pap_quest.s_skull_1 = utility::getstruct( "pq_skull_1", "targetname" );
    level.scarab_pap_quest.s_skull_2 = utility::getstruct( "pq_skull_2", "targetname" );
    level.scarab_pap_quest.var_b1428d1c2e2f00b2 = [ level.scarab_pap_quest.s_skull_1, level.scarab_pap_quest.s_skull_2 ];
    level utility::add_fx( "skull_power_beam_fx", "vfx_sat_zm_scarab_pap_world_seed_siphon_beam" );
    level utility::add_fx( "skull_siphon_beam_fx", "vfx_sat_zm_scarab_pap_world_seed_siphon_beam" );
    level utility::add_fx( "cage_boom_fx", "vfx_sat_zm_scarab_skull_cage_explosion" );
    level utility::add_fx( "skull_boom_fx", "vfx_sat_zm_scarab_skull_fiery_explosion" );
    level utility::add_fx( "skull_phase_fx", "vfx_sat_zm_scarab_skull_door_transition" );
    level utility::add_fx( "skull_ball_fx", "vfx_sat_zm_scarab_skull_fire_ball" );
    level utility::add_fx( "pap_fx", "vfx_sat_zm_levels_scarab_fog_cover_loop" );
    level utility::add_fx( "pap_fx_end", "vfx_sat_zm_levels_scarab_fog_cover_end" );
    level.scarab_pap_quest.var_2a4fab2f4ebf62f6 = utility::getstruct( "pq_fx", "targetname" );
    
    if ( level.scarab_pap_quest.var_2a4fab2f4ebf62f6 )
    {
        level.scarab_pap_quest.var_2a4fab2f4ebf62f6.tag = utility::spawn_model( "tag_origin", level.scarab_pap_quest.var_2a4fab2f4ebf62f6.origin, level.scarab_pap_quest.var_2a4fab2f4ebf62f6.angles );
        playfxontag( utility::getfx( "pap_fx" ), level.scarab_pap_quest.var_2a4fab2f4ebf62f6.tag, "tag_origin" );
    }
    
    var_7fbd5e78649bc07f = 0;
    
    for ( i = 0; i < level.scarab_pap_quest.var_b1428d1c2e2f00b2.size ; i++ )
    {
        var_1be5586316eb3191 = i == 0 ? level.scarab_pap_quest.s_skull_1 : level.scarab_pap_quest.s_skull_2;
        
        while ( !var_1be5586316eb3191.agent )
        {
            var_1be5586316eb3191.agent = agent_manager::spawn_agent( "sat_spawner_zombie_wither_zm_scpq", var_1be5586316eb3191.origin, var_1be5586316eb3191.angles );
            waitframe();
        }
        
        var_1be5586316eb3191.agent.e_mover = utility::spawn_model( "tag_origin", var_1be5586316eb3191.agent.origin, var_1be5586316eb3191.agent.angles );
        var_1be5586316eb3191.agent linktoblendtotag( var_1be5586316eb3191.agent.e_mover, "tag_origin" );
        var_1be5586316eb3191.agent thread utility::delete_on_death( var_1be5586316eb3191.agent.e_mover );
        var_1be5586316eb3191.agent thread function_7744537f7ff86215();
        
        if ( !isdefined( var_1be5586316eb3191.agent.var_f3f3b4d926db02c7 ) )
        {
            var_1be5586316eb3191.agent.var_f3f3b4d926db02c7 = [];
        }
        
        var_1be5586316eb3191.agent.var_f3f3b4d926db02c7[ var_1be5586316eb3191.agent.var_f3f3b4d926db02c7.size ] = &skull_damage_callback;
        var_1be5586316eb3191.agent.var_be089c77e1eaac30 = &skull_insta_kill;
        var_1be5586316eb3191.agent.disallow_grab = 1;
        var_1be5586316eb3191.agent.nocorpse = 1;
        var_1be5586316eb3191.agent.forceannihilate = 1;
        var_1be5586316eb3191.agent.b_cleanup_no_respawn = 1;
        var_1be5586316eb3191.agent.ignore_enemy_count = 1;
        var_1be5586316eb3191.agent.var_a13bed1ac47e1b2c = 1;
        var_1be5586316eb3191.agent.no_powerups = 1;
        var_1be5586316eb3191.agent.var_15598d8e493afe88 = 1;
        var_1be5586316eb3191.agent.var_7ee152b43c7188e1 = 1;
        var_1be5586316eb3191.agent.b_ignore_death_perception = 1;
        var_1be5586316eb3191.agent.var_25f933db0db285ad = 1;
        var_1be5586316eb3191.agent.var_2fc3a5fb762afb6e = 1;
        var_1be5586316eb3191.agent.var_825b17c932865df = 1;
        level notify( #"highvis_reload_outline", undefined, [ var_1be5586316eb3191.agent ] );
        var_1be5586316eb3191.agent val::set_array( "pq_skull", [ "ignore_cleanup", "ignoreme" ], 1 );
        var_1be5586316eb3191.agent val::set_array( "pq_skull", [ "damage", "death" ], 0 );
        var_1be5586316eb3191.agent function_66dc8b6ae969f66d( 1 );
        var_1be5586316eb3191.agent.animname = "Actor 1";
        var_1be5586316eb3191.agent utility::animscripted_clear();
        var_1be5586316eb3191.animstruct = utility::getstruct( var_1be5586316eb3191.target2, "targetname" );
        var_1be5586316eb3191.animstruct thread scene::play( var_1be5586316eb3191.agent, [ "cage_idle" ], "zm_sat_skull_cage_scene" );
        ents = var_1be5586316eb3191.animstruct scene::get_entities();
        
        foreach ( ent in ents )
        {
            if ( !isai( ent ) )
            {
                var_1be5586316eb3191.agent.var_8c496e6decf0bae = ent;
                ent.animname = "Prop 1";
                break;
            }
        }
        
        var_1be5586316eb3191.agent.var_1be5586316eb3191 = var_1be5586316eb3191;
        var_1be5586316eb3191.node_idx = 0;
        var_1be5586316eb3191.num = var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? 1 : 2;
        
        if ( !zm_save::function_fcccc3d2a616b1c7() )
        {
            var_e0b9f6dbbb03c840 = undefined;
            
            if ( !var_7fbd5e78649bc07f )
            {
                var_e0b9f6dbbb03c840 = i == level.scarab_pap_quest.var_b1428d1c2e2f00b2.size - 1 ? 1 : utility::percent_chance( 50 );
                
                if ( var_e0b9f6dbbb03c840 )
                {
                    var_7fbd5e78649bc07f = 1;
                }
            }
        }
        
        level function_b682da092f333992( var_1be5586316eb3191, var_e0b9f6dbbb03c840 );
        waitframe();
        var_1be5586316eb3191.health_checkpoints = [];
        health_checkpoint = var_1be5586316eb3191.agent.maxhealth;
        var_484844943496d334 = 0.75 * var_1be5586316eb3191.agent.maxhealth;
        var_1cf9795be7f13f5a = var_1be5586316eb3191.path_array.size - 1;
        var_d648d1dbc51f0b0f = int( var_484844943496d334 / var_1cf9795be7f13f5a );
        
        for ( var_c6abefbeb73cbea3 = 1; var_c6abefbeb73cbea3 < var_1cf9795be7f13f5a + 1 ; var_c6abefbeb73cbea3++ )
        {
            var_1be5586316eb3191.health_checkpoints[ var_c6abefbeb73cbea3 ] = health_checkpoint - var_d648d1dbc51f0b0f;
            health_checkpoint = var_1be5586316eb3191.health_checkpoints[ var_c6abefbeb73cbea3 ];
        }
        
        var_1be5586316eb3191.var_64bc501c93ac9b83 = var_d648d1dbc51f0b0f / 10;
    }
    
    level scriptable::scriptable_adddamagedcallback( &function_86f4d375df09a65a );
    level scriptable::scriptable_addnotifycallback( "pap_brz_lit", &function_59952a45413dbb99 );
    var_c6b9e23aac03b4d0 = utility::getstructarray( "pq_forge_brazier", "targetname" );
    level.scarab_pap_quest.var_c6b9e23aac03b4d0 = [];
    
    for ( i = 1; i <= var_c6b9e23aac03b4d0.size ; i++ )
    {
        var_4d376276647607c7 = var_c6b9e23aac03b4d0[ i - 1 ];
        var_bc0e33be954008a1 = spawnscriptable( %"hash_7b61dbbdc8216b39", var_4d376276647607c7.origin, var_4d376276647607c7.angles );
        var_bc0e33be954008a1.s_brazier = var_4d376276647607c7;
        level.scarab_pap_quest.var_c6b9e23aac03b4d0[ level.scarab_pap_quest.var_c6b9e23aac03b4d0.size ] = var_bc0e33be954008a1;
        var_bc0e33be954008a1.interact = interaction::register_scriptable_interact( var_bc0e33be954008a1, &function_10f75cf5ef72a3fd, undefined, undefined, &function_f306401e80062fef );
        var_bc0e33be954008a1.interact.var_4d376276647607c7 = var_bc0e33be954008a1;
        var_bc0e33be954008a1.interact.var_87f8c6598b0699af = var_bc0e33be954008a1;
        var_bc0e33be954008a1.var_9922b410586809d5 = createnavbadplacebybounds( var_bc0e33be954008a1.origin, ( 48, 48, 4 ), ( 0, 0, 0 ) );
    }
    
    var_e7675332b610d916 = getentitylessscriptablearray( "pq_brazier", "targetname" );
    level.scarab_pap_quest.var_f0218d7a43516520 = [];
    
    for ( i = 1; i <= var_e7675332b610d916.size ; i++ )
    {
        var_b1972b88268e4995 = var_e7675332b610d916[ i - 1 ];
        var_b1972b88268e4995.s_brazier = var_b1972b88268e4995;
        level.scarab_pap_quest.var_f0218d7a43516520[ level.scarab_pap_quest.var_f0218d7a43516520.size ] = var_b1972b88268e4995;
        var_b1972b88268e4995.interact = interaction::register_scriptable_interact( var_b1972b88268e4995, &function_10f75cf5ef72a3fd, undefined, undefined, &function_f306401e80062fef );
        var_b1972b88268e4995.interact.var_87f8c6598b0699af = var_b1972b88268e4995;
        var_b1972b88268e4995.interact.var_8af4bb0185feb88 = var_b1972b88268e4995.script_noteworthy;
    }
    
    level.scarab_pap_quest.var_c6070e16c81619f1 = 0;
    level.scarab_pap_quest.var_869784d65d81d184 = utility::getstructarray( "pq_crank", "targetname" );
    var_25c622217b6eca42 = utility::getstructarray( "pq_crank_base", "targetname" );
    var_ed94c880ec9dc431 = getnoentvolumearray( "pq_crank_trigger", #targetname ) ?? [];
    
    foreach ( var_2e2441e747b19673 in level.scarab_pap_quest.var_869784d65d81d184 )
    {
        foreach ( var_316bbdc1e92171 in var_25c622217b6eca42 )
        {
            if ( int( var_2e2441e747b19673.script_noteworthy ) == int( var_316bbdc1e92171.script_noteworthy ) )
            {
                var_2e2441e747b19673.base = var_316bbdc1e92171;
                break;
            }
        }
        
        var_2e2441e747b19673.base.mdl = utility::spawn_model( %"hash_150013ff8ce3bad8", var_2e2441e747b19673.base.origin, var_2e2441e747b19673.base.angles );
        var_2e2441e747b19673.mdl = utility::spawn_model( %"hash_745da9bdc49f3fbd", var_2e2441e747b19673.origin, var_2e2441e747b19673.angles );
        var_2e2441e747b19673.interact = interaction::register_scriptable_interact( var_2e2441e747b19673.mdl getlinkedscriptableinstance(), &function_f4c63e969c1c8aab, undefined, undefined, &rotate_hint_callback );
        var_2e2441e747b19673.mdl.var_2e2441e747b19673 = var_2e2441e747b19673;
        var_2e2441e747b19673.interact.var_2e2441e747b19673 = var_2e2441e747b19673;
        var_2e2441e747b19673.ring_num = int( var_2e2441e747b19673.script_noteworthy );
        var_2e2441e747b19673.mdl.lowerzoffset = -287;
        var_2e2441e747b19673.base.mdl.lowerzoffset = -287;
        var_2e2441e747b19673.interact.animstruct = { #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_2e2441e747b19673.interact.original_angles = var_2e2441e747b19673.interact.angles;
        var_2e2441e747b19673.base.mdl.anim_pause_time = 0;
        var_2e2441e747b19673.base.mdl.anim_length = 0.9;
        var_2e2441e747b19673.base.mdl.anim_rate = 0.25;
        var_2e2441e747b19673.base.mdl.var_ee795077e5dab0f0 = var_2e2441e747b19673.base.mdl.anim_length / var_2e2441e747b19673.base.mdl.anim_rate;
        
        foreach ( var_7296bdc41f0d2010 in var_ed94c880ec9dc431 )
        {
            if ( int( var_7296bdc41f0d2010.struct.script_int ) == int( var_2e2441e747b19673.script_noteworthy ) )
            {
                var_2e2441e747b19673.trigger = var_7296bdc41f0d2010;
                break;
            }
        }
    }
    
    level val::group_register( "cranking", [ "allow_jump", "gesture", "melee", "mantle", "offhand_weapons", "allow_movement", "sprint", "fire", "reload", "weapon_pickup", "weapon_switch", "execution_victim", "supers", "allow_scripted_bgb_use", "weapon_inspect", "allow_toggle_third_person" ] );
    level.scarab_pap_quest.var_387620b5f8c8e07 = getent( "pq_forge_lid", #targetname );
    level.scarab_pap_quest.var_387620b5f8c8e07.lowerzoffset = -287;
    calloutmarkerping::function_6052d1ed5729bcfc( level.scarab_pap_quest.var_387620b5f8c8e07 );
    calloutmarkerping::function_9bd4bf4f8fe74b16( level.scarab_pap_quest.var_387620b5f8c8e07, level.scarab_pap_quest.var_9d15330b141fe52f, 9 );
    level.scarab_pap_quest.var_bc83b6a5157bf046 = getent( "pq_forge_center_stairs", #targetname );
    level.scarab_pap_quest.var_bc83b6a5157bf046.lowerzoffset = -287;
    level.scarab_pap_quest.var_adf372aea1405d38 = getent( "pq_forge_ring_base", #targetname );
    level.scarab_pap_quest.var_adf372aea1405d38.lowerzoffset = -287;
    level.scarab_pap_quest.var_405ba86a0a3065d9 = utility::function_30dbabe3200518b( "pq_forge_platform", #targetname );
    
    if ( level.scarab_pap_quest.var_405ba86a0a3065d9 )
    {
        level.scarab_pap_quest.var_405ba86a0a3065d9.clip = getent( "pq_forge_platform_clip", #targetname );
    }
    
    level.scarab_pap_quest.var_36689e18b47d20cd = getent( "pq_forge_platform_ai_obstacle", #targetname );
    level.scarab_pap_quest.var_36689e18b47d20cd.origin += ( 0, 0, -725 );
    level.scarab_pap_quest.var_4879f13476e06b5a = getent( "pq_forge_platform_ai_nav", #targetname );
    level.scarab_pap_quest.var_cdb6b8216216dafd = getent( "pq_forge_obstacle", #targetname );
    level.scarab_pap_quest.var_cdb6b8216216dafd.var_7e43d93181543ab3 = getent( "pq_forge_obstacle_end", #targetname );
    var_c39290a87f707bc1 = utility::getstruct( "pq_forge_ring1", "targetname" );
    level.scarab_pap_quest.var_dbdff7ad02b59f6b = utility::spawn_model( "sat_zm_energy_ring_glow_01", var_c39290a87f707bc1.origin, var_c39290a87f707bc1.angles );
    level.scarab_pap_quest.var_dbdff7ad02b59f6b.script_noteworthy = var_c39290a87f707bc1.script_noteworthy;
    var_c3928da87f707528 = utility::getstruct( "pq_forge_ring2", "targetname" );
    level.scarab_pap_quest.var_dbdff8ad02b5a19e = utility::spawn_model( "sat_zm_energy_ring_glow_02", var_c3928da87f707528.origin, var_c3928da87f707528.angles );
    level.scarab_pap_quest.var_dbdff8ad02b5a19e.script_noteworthy = var_c3928da87f707528.script_noteworthy;
    level.scarab_pap_quest.var_59f2066b542a115d = getent( "forge_dmg", #targetname );
    level.scarab_pap_quest thread function_86b23a35ab3696d6();
    level.scarab_pap_quest.var_809f73b42a6602e0 = getnodearray( "traversals_nexus_top", #script_noteworthy );
    
    if ( !isdefined( level.scarab_pap_quest.var_809f73b42a6602e0 ) )
    {
        level.scarab_pap_quest.var_809f73b42a6602e0 = [];
    }
    
    level.scarab_pap_quest.var_f94fc2341de8afbe = getnodearray( "traversals_nexus_bot", #script_noteworthy );
    
    if ( !isdefined( level.scarab_pap_quest.var_f94fc2341de8afbe ) )
    {
        level.scarab_pap_quest.var_f94fc2341de8afbe = [];
    }
    
    level thread function_f4d74c3d8464f51d();
    level.scarab_pap_quest.var_b3ad13b33f68da50 = [];
    level.scarab_pap_quest.var_59bc9f460dcca5f3 = utility::getstructarray( "pq_skull_path_temple_door", "targetname" );
    level.scarab_pap_quest.var_a7b66b69733c6d12 = getentitylessscriptablearray( "pq_forge_glow_structures", #targetname );
    level.scarab_pap_quest.usurpedpowercallbacks[ "usurped_power_switch_fail" ] = &function_24800776007b2216;
    level.scarab_pap_quest.usurpedpowercallbacks[ "usurped_power_finished" ] = &function_65c67f99e310d390;
    level.scarab_pap_quest.usurpedpowercallbacks[ "usurped_power_land" ] = &function_b00975f421635a2e;
    level function_7f31da56d66646f5();
    level.scarab_pap_quest utility::ent_flag_set( "is_initialized" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xb895ee8d, Offset: 0x358b
// Size: 0x3d
function private function_7744537f7ff86215()
{
    self endon( #"death" );
    self.var_e59e24fbb46d7d5e = 1;
    
    do
    {
        self orientmode( "face angle 3d", self.e_mover.angles );
        waitframe();
    }
    while ( true );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x6ab25655, Offset: 0x35d0
// Size: 0x1e4
function private function_f4d74c3d8464f51d()
{
    level.scarab_pap_quest.var_405ba86a0a3065d9.clip connectpaths();
    level.scarab_pap_quest.var_405ba86a0a3065d9.clip solid();
    wait 0.1;
    level.scarab_pap_quest.var_36689e18b47d20cd notsolid();
    level.scarab_pap_quest.var_36689e18b47d20cd.var_9922b410586809d5 = createnavbadplacebyent( level.scarab_pap_quest.var_36689e18b47d20cd );
    wait 0.1;
    level.scarab_pap_quest.var_cdb6b8216216dafd disconnectpaths();
    wait 0.1;
    level.scarab_pap_quest.var_cdb6b8216216dafd solid();
    wait 0.1;
    
    foreach ( dynamic_traversal_top_node in level.scarab_pap_quest.var_809f73b42a6602e0 )
    {
        function_30dc1efdafe7681e( dynamic_traversal_top_node, 1 );
    }
    
    wait 0.1;
    
    foreach ( var_1c998cfdc83d8cfd in level.scarab_pap_quest.var_f94fc2341de8afbe )
    {
        function_30dc1efdafe7681e( var_1c998cfdc83d8cfd, 0 );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x1c877e1e, Offset: 0x37bc
// Size: 0x6f
function private on_use_pap_machine( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    var_10f50841c4b80477 = player.origin[ 2 ];
    var_53bf338caf0d088e = level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 2 ] + -30;
    
    if ( var_10f50841c4b80477 < var_53bf338caf0d088e )
    {
        return;
    }
    
    thread pack_a_punch::on_use_pap_machine( player );
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x1c877e1f, Offset: 0x3833
// Size: 0xba
function private pap_per_player_hint( usable, player )
{
    if ( !isplayer( player ) )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    var_10f50841c4b80477 = player.origin[ 2 ];
    var_53bf338caf0d088e = level.scarab_pap_quest.var_9d15330b141fe52f.origin[ 2 ] + -30;
    
    if ( var_10f50841c4b80477 < var_53bf338caf0d088e )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    return pack_a_punch::pap_per_player_hint( usable, player );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x1e081a4c, Offset: 0x38f6
// Size: 0x29
function private function_c992397f20685522()
{
    level utility::flag_wait( "pluto_functions_registered" );
    level utility::clearsharedfunc( #"pack_a_punch", #"pap_fx_override" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0
// Checksum 0x6b434686, Offset: 0x3927
// Size: 0xe6
function function_4aa2592711d45598()
{
    do
    {
        self waittill( #"damage", einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, spartname );
        
        if ( !isplayer( eattacker ) )
        {
            continue;
        }
        
        if ( smeansofdeath != "MOD_MELEE" )
        {
            continue;
        }
        
        if ( eattacker.var_2bbc37a986db6306 )
        {
            continue;
        }
        
        if ( !eattacker.b_disable_pap_camo )
        {
            eattacker.b_disable_pap_camo = 1;
        }
        else
        {
            eattacker.b_disable_pap_camo = 0;
        }
        
        eattacker thread pack_a_punch::pap_melee_cooldown();
    }
    while ( true );
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x93e693be, Offset: 0x3a15
// Size: 0x19e
function private function_b682da092f333992( var_1be5586316eb3191, path_idx )
{
    var_1be5586316eb3191.path_array = [];
    var_ed92d3edd3eded9 = utility::getstruct( var_1be5586316eb3191.target, "targetname" );
    
    if ( !isdefined( path_idx ) )
    {
        path_idx = undefined;
    }
    
    for ( i = 0;  ; i++ )
    {
        if ( !var_ed92d3edd3eded9.target )
        {
            var_1be5586316eb3191.s_circle_node = var_ed92d3edd3eded9;
            break;
        }
        
        if ( !isdefined( var_1be5586316eb3191.path_array ) )
        {
            var_1be5586316eb3191.path_array = [];
        }
        
        var_1be5586316eb3191.path_array[ var_1be5586316eb3191.path_array.size ] = var_ed92d3edd3eded9;
        
        if ( i == 1 )
        {
            var_e67d2b409143afde = utility::getstructarray( var_ed92d3edd3eded9.target, "targetname" );
            
            if ( !isdefined( path_idx ) )
            {
                path_idx = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_42c9db6058af9535" : #"hash_da16147f5bd2d8aa" );
            }
            
            if ( !isdefined( path_idx ) )
            {
                path_idx = randomintrange( 0, var_e67d2b409143afde.size );
            }
            
            var_ed92d3edd3eded9 = var_e67d2b409143afde[ path_idx ];
            continue;
        }
        
        var_ed92d3edd3eded9 = utility::getstruct( var_ed92d3edd3eded9.target, "targetname" );
    }
    
    var_1be5586316eb3191.path_idx = path_idx;
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_42c9db6058af9535" : #"hash_da16147f5bd2d8aa", path_idx );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xdba19388, Offset: 0x3bbb
// Size: 0x291
function private function_c561c0c29a089a62()
{
    level endon( #"game_ended" );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"insert_seed", &function_aa691d098166bae3, &function_fef6c068974690a6 );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"hunt_skulls", &function_29f54b3274e25bb4, &function_34d9cdfcc3b631e5 );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"hash_c7044385893e7295", &function_34d2a3b178084055, &function_bd78ba8efdb51574 );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"hash_402e0d074cc6f251", &function_fdba62bd6315bdb5 );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"hash_7f81077fb695e7e2", &function_64e4a1681bedc6c6 );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"hash_94fb431c2711f3e7" );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"hash_c7044085893e6d7c", &function_34d2a3b178084055, &function_bd78ba8efdb51574 );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"hash_402e0a074cc6ed38", &function_fdba62bd6315bdb5 );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"hash_7f81067fb695e62f", &function_64e4a1681bedc6c6 );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"hash_94fb441c2711f59a" );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"rotate_cranks", &function_5313a9f4256e61e4, &function_ecb043d3a7a40b55 );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"hash_cf9cadfb84da7b1", &function_a931d5e7295444c1, &function_ae4797aa4b15f5b8 );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"hash_cf9c7dfb84da298", &function_a931d5e7295444c1, &function_ae4797aa4b15f5b8 );
    level zm_quest::register_quest_step( #"scarab_pap_quest", #"complete", &quest_complete_setup );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        level utility::flag_wait( "load_phone_finished" );
    }
    
    if ( level.scarab_phone && !level.scarab_phone.var_aa3febe5f666b58f )
    {
        level zm_quest::get_quest( #"scarab_pap_quest" ).var_94c5b7d04e0c2501 = 1;
        level zm_quest::function_fb3af5600f6a9441( 1, 1, #"scarab_pap_quest", #"insert_seed" );
    }
    
    level thread set_round_cap();
    level thread zm_quest::start_quest( #"scarab_pap_quest" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x1c55aaa9, Offset: 0x3e54
// Size: 0xa7
function private set_round_cap()
{
    if ( !isdefined( level.directed_mode ) )
    {
        return;
    }
    
    if ( !level.scarab_phone.var_b249c3f5faace516 )
    {
        level thread zm_quest::update_round_cap( 3 );
        return;
    }
    
    if ( !level zm_quest::get_quest_step( #"scarab_pap_quest", #"insert_seed" ).completed )
    {
        level thread zm_quest::update_round_cap( 3 );
        return;
    }
    
    if ( !level zm_quest::get_quest_step( #"scarab_pap_quest", #"rotate_cranks" ).completed )
    {
        level thread zm_quest::update_round_cap( 5 );
        return;
    }
    
    level thread zm_quest::update_round_cap( 7 );
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x4c60833f, Offset: 0x3f03
// Size: 0x68
function private function_e2fc8115f872162d( var_1be5586316eb3191, node_idx )
{
    var_1be5586316eb3191.node_idx = node_idx;
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_db1d1fe1fed0d0fa" : #"hash_c040c10873125dd9", int( node_idx ) );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xd5b79374, Offset: 0x3f73
// Size: 0x5d2
function private function_7f31da56d66646f5()
{
    foreach ( var_1be5586316eb3191 in [ level.scarab_pap_quest.s_skull_1, level.scarab_pap_quest.s_skull_2 ] )
    {
        var_e18c746f2e75ecaa = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", #"current_skull" );
        
        if ( var_e18c746f2e75ecaa == var_1be5586316eb3191.num )
        {
            level.scarab_pap_quest.s_current_skull = var_1be5586316eb3191;
        }
        
        var_1be5586316eb3191.var_348491563c879773 = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_b1efd54170d7cdb9" : #"hash_f96e5211a125fba2" );
        var_bc3053e9cb924a06 = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_db1d1fe1fed0d0fa" : #"hash_c040c10873125dd9" );
        
        if ( isdefined( var_bc3053e9cb924a06 ) )
        {
            if ( var_bc3053e9cb924a06 >= 6 )
            {
                level skull_cleanup( var_1be5586316eb3191 );
                continue;
            }
            
            var_1be5586316eb3191.node_idx = int( var_bc3053e9cb924a06 );
            
            if ( var_bc3053e9cb924a06 >= 5 )
            {
                var_1be5586316eb3191.var_ae8733439bf340f4 = 1;
            }
        }
        
        iscircling = var_1be5586316eb3191.node_idx >= var_1be5586316eb3191.path_array.size;
        
        if ( iscircling )
        {
            var_1be5586316eb3191 utility::ent_flag_set( "is_circling" );
            continue;
        }
        
        var_1be5586316eb3191 utility::ent_flag_clear( "is_circling" );
    }
    
    foreach ( var_e8696492fd8b4e43 in level.scarab_pap_quest.var_f0218d7a43516520 )
    {
        saved_is_lit = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", hashcat( #"hash_ff2398a72f6caaa7", var_e8696492fd8b4e43.s_brazier.script_noteworthy ) );
        
        if ( !isdefined( saved_is_lit ) )
        {
            continue;
        }
        
        templeid = int( var_e8696492fd8b4e43.s_brazier.script_noteworthy );
        
        if ( templeid == 1 || templeid == 2 )
        {
            level.scarab_pap_quest.s_skull_2.var_87f8c6598b0699af = var_e8696492fd8b4e43;
            var_1be5586316eb3191 = level.scarab_pap_quest.s_skull_2;
            huntstep = #"hash_c7044085893e6d7c";
        }
        else
        {
            level.scarab_pap_quest.s_skull_1.var_87f8c6598b0699af = var_e8696492fd8b4e43;
            var_1be5586316eb3191 = level.scarab_pap_quest.s_skull_1;
            huntstep = #"hash_c7044385893e7295";
        }
        
        var_e8696492fd8b4e43.var_1be5586316eb3191 = var_1be5586316eb3191;
        var_fb30f3b84d922147 = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_cce5cbb8c9e0117a" : #"hash_b79f2a6fc4be996b" );
        
        if ( var_fb30f3b84d922147 == 2 )
        {
            continue;
        }
        
        diddeliver = level zm_quest::get_quest_step( #"scarab_pap_quest", huntstep ).completed;
        
        if ( diddeliver )
        {
            continue;
        }
        
        var_e8696492fd8b4e43 function_760e6888e3e99e1d( saved_is_lit );
    }
    
    foreach ( var_bc0e33be954008a1 in level.scarab_pap_quest.var_c6b9e23aac03b4d0 )
    {
        saved_is_lit = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", hashcat( #"hash_43da8c2d828a79d3", var_bc0e33be954008a1.s_brazier.script_noteworthy ) );
        
        if ( !isdefined( saved_is_lit ) )
        {
            continue;
        }
        
        var_bc0e33be954008a1 function_760e6888e3e99e1d( saved_is_lit );
    }
    
    foreach ( var_2e2441e747b19673 in level.scarab_pap_quest.var_869784d65d81d184 )
    {
        var_ca9378733eb14a5f = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", hashcat( #"hash_79e1a644b523b61b", var_2e2441e747b19673.script_noteworthy ) );
        
        if ( !var_ca9378733eb14a5f )
        {
            continue;
        }
        
        var_2e2441e747b19673 utility::ent_flag_set( "is_first_rotated" );
        var_2e2441e747b19673 utility::ent_flag_set( "is_finish_rotated" );
        var_2e2441e747b19673.mdl utility::function_7c10ea82c1e305b8( "usable", "off" );
        level.scarab_pap_quest.var_c6070e16c81619f1++;
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x67852a9f, Offset: 0x454d
// Size: 0xca
function private function_aa691d098166bae3( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level endon( #"hash_39da9feeb1e54eb9" );
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    
    if ( b_skipped || b_save_restored || self.b_restarted && self.completed || level utility::flag( "open_sesame" ) )
    {
        level.scarab_pap_quest.s_seed utility::ent_flag_set( "is_placed" );
        return;
    }
    
    level thread function_51f12524c830dd09();
    level.scarab_pap_quest.s_seed utility::ent_flag_wait( "is_placed" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x637feed4, Offset: 0x461f
// Size: 0x4f9
function private function_2af656c4985a7ed5( player )
{
    level endon( #"game_ended" );
    
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( level.scarab_pap_quest.s_seed utility::ent_flag( "is_placed" ) )
    {
        return;
    }
    
    level.scarab_pap_quest.s_seed utility::ent_flag_set( "is_placed" );
    level thread zm_quest::update_round_cap( 5 );
    level.scarab_pap_quest.s_seed utility::function_7c10ea82c1e305b8( "body", "on" );
    level.scarab_pap_quest.s_seed utility::function_7c10ea82c1e305b8( "usable", "off" );
    earthquake( 0.12, 3, level.scarab_pap_quest.s_seed.origin, 1200 );
    playrumbleonposition( "heavy_1s", level.scarab_pap_quest.s_seed.origin );
    level.scarab_pap_quest utility::delaythread( 1, &play_vo_banter, #"hash_dc4ed84b0148d33a", -1, player );
    musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_107cd2ba016ea8b2" );
    wait 4;
    
    foreach ( var_1be5586316eb3191 in [ level.scarab_pap_quest.s_skull_1, level.scarab_pap_quest.s_skull_2 ] )
    {
        if ( var_1be5586316eb3191.agent )
        {
            var_1be5586316eb3191.agent utility::function_7c10ea82c1e305b8( "fx", "siphon" );
        }
        
        var_1be5586316eb3191.var_180eb370d406426b = playfxontagsbetweenclients( utility::getfx( "skull_siphon_beam_fx" ), var_1be5586316eb3191.agent, "j_head", level.scarab_pap_quest.s_seed.fx_tag, "tag_origin" );
        
        if ( var_1be5586316eb3191.var_180eb370d406426b )
        {
            var_1be5586316eb3191.var_180eb370d406426b thread namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
        }
    }
    
    level.scarab_pap_quest.s_seed utility::function_7c10ea82c1e305b8( "body", "off" );
    level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent thread zm_quest::function_537ffe28010f5e83( 0.25, 1200, "damage_light", 600 );
    wait 2;
    level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent thread utility::delay_notify( 2.4, "stop_camera_shake_rumber" );
    
    foreach ( var_1be5586316eb3191 in [ level.scarab_pap_quest.s_skull_1, level.scarab_pap_quest.s_skull_2 ] )
    {
        var_41b0ca109e0fc40d = var_1be5586316eb3191.num == 1 ? [ "cage_raise1", "cage_break1" ] : [ "cage_raise2", "cage_break2" ];
        var_1be5586316eb3191.animstruct thread scene::play( [ var_1be5586316eb3191.agent, var_1be5586316eb3191.agent.var_8c496e6decf0bae ], var_41b0ca109e0fc40d, "zm_sat_skull_cage_scene" );
        cage_origin = var_1be5586316eb3191.agent.var_8c496e6decf0bae.origin;
        effects_origin = cage_origin ?? var_1be5586316eb3191.agent.origin;
        level utility::noself_delaycall( 2.6, &earthquake, 0.4, 1, effects_origin, 800 );
        level utility::noself_delaycall( 2.6, &playrumbleonposition, "heavy_1s", effects_origin );
        level utility::delaythread( 2.6, &utility::play_sound_in_space, "evt_papq_skull_cage_explosion", effects_origin );
    }
    
    level.scarab_pap_quest.s_seed.fx_tag thread utility::delete_after_delay( 3.5 );
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_6d093f7d7f632f29" ], undefined, 1 );
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x14bc0e0b, Offset: 0x4b20
// Size: 0xa8
function private function_fef6c068974690a6( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level.scarab_pap_quest.s_seed utility::ent_flag_set( "is_placed" );
    level.scarab_pap_quest.s_seed utility::function_7c10ea82c1e305b8( "usable", "off" );
    level zm_quest::get_quest_step( #"scarab_pap_quest", #"hunt_skulls" ).var_94c5b7d04e0c2501 = 1;
    level zm_quest::function_b57dfe9625966b0b( #"scarab_misc", 0, #"world_seed", 1, 0 );
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xed806a6, Offset: 0x4bd0
// Size: 0x5ca
function private function_29f54b3274e25bb4( b_skipped, b_save_restored )
{
    level endon( #"open_sesame" );
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    
    if ( level utility::flag( "open_sesame" ) )
    {
        level zm_quest::get_quest( #"scarab_pap_quest" ).skip_splash = 1;
    }
    
    if ( b_skipped || b_save_restored || level utility::flag( "open_sesame" ) )
    {
        return;
    }
    
    self.var_94c5b7d04e0c2501 = undefined;
    level thread function_51f12524c830dd09();
    prev_step = level zm_quest::get_quest_step( #"scarab_pap_quest", #"insert_seed" );
    
    if ( !prev_step.b_skipped && !prev_step.b_save_restored && !prev_step.var_d36be2d73e12f4fe )
    {
        wait 8.5;
    }
    
    foreach ( var_1be5586316eb3191 in [ level.scarab_pap_quest.s_skull_1, level.scarab_pap_quest.s_skull_2 ] )
    {
        if ( !isalive( var_1be5586316eb3191.agent ) || !var_1be5586316eb3191.agent )
        {
            continue;
        }
        
        if ( var_1be5586316eb3191.var_180eb370d406426b )
        {
            var_1be5586316eb3191.var_180eb370d406426b delete();
        }
        
        var_1be5586316eb3191.agent val::reset( "pq_skull", "ignoreme" );
        var_1be5586316eb3191.agent utility::function_7c10ea82c1e305b8( "fx", "alive" );
        var_1be5586316eb3191.agent utility::function_7c10ea82c1e305b8( "health", "ignore_damage" );
        playfx( utility::getfx( "cage_boom_fx" ), var_1be5586316eb3191.agent.origin + ( 0, 0, 28 ), anglestoforward( var_1be5586316eb3191.agent.angles ), anglestoup( var_1be5586316eb3191.agent.angles ) );
        var_1be5586316eb3191.animstruct scene::stop_object( "Prop 1" );
        var_1be5586316eb3191.animstruct utility::delaythread( 0.25, &scene::stop );
        var_1be5586316eb3191.agent.e_mover utility::delaycall( 0.26, &moveto, var_1be5586316eb3191.agent.origin + ( 0, 0, 28 ), 0.1 );
    }
    
    foreach ( var_2e2441e747b19673 in level.scarab_pap_quest.var_869784d65d81d184 )
    {
        if ( !var_2e2441e747b19673.mdl || var_2e2441e747b19673 utility::ent_flag( "is_finish_rotated" ) )
        {
            continue;
        }
        
        var_2e2441e747b19673.mdl utility::function_7c10ea82c1e305b8( "usable", "usable" );
    }
    
    foreach ( var_1be5586316eb3191 in [ level.scarab_pap_quest.s_skull_1, level.scarab_pap_quest.s_skull_2 ] )
    {
        if ( !isalive( var_1be5586316eb3191.agent ) || !var_1be5586316eb3191.agent )
        {
            continue;
        }
        
        var_1be5586316eb3191.agent.b_ignore_death_perception = 0;
        var_1be5586316eb3191.agent.var_2fc3a5fb762afb6e = 0;
        level notify( #"highvis_reload_outline", undefined, [ var_1be5586316eb3191.agent ] );
        var_1be5586316eb3191.agent function_66dc8b6ae969f66d( 0 );
        var_1be5586316eb3191 utility::delaythread( 0.5, &function_b95bddad3b8a4f1 );
        
        if ( var_1be5586316eb3191.node_idx >= var_1be5586316eb3191.path_array.size )
        {
            continue;
        }
        
        if ( var_1be5586316eb3191.node_idx >= 1 )
        {
            var_1be5586316eb3191 utility::delaythread( 0.5, &function_bb7d1abe300ec126, var_1be5586316eb3191.path_array[ var_1be5586316eb3191.node_idx ].origin, undefined, undefined, 1 );
            continue;
        }
        
        var_1be5586316eb3191 utility::delaythread( 0.5, &function_bb7d1abe300ec126, var_1be5586316eb3191.path_array[ 1 ].origin, var_1be5586316eb3191.path_array[ 0 ].origin );
    }
    
    level zm_quest::get_quest_step( #"scarab_pap_quest", #"hash_c7044385893e7295" ).var_94c5b7d04e0c2501 = 1;
    level zm_quest::get_quest_step( #"scarab_pap_quest", #"hash_c7044085893e6d7c" ).var_94c5b7d04e0c2501 = 1;
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xa77fe136, Offset: 0x51a2
// Size: 0x244
function private function_34d9cdfcc3b631e5( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level scriptable::function_dc174fecebb79952( &function_86f4d375df09a65a );
    
    if ( b_skipped || b_save_restored || level utility::flag( "open_sesame" ) )
    {
        level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
        
        foreach ( var_1be5586316eb3191 in [ level.scarab_pap_quest.s_skull_1, level.scarab_pap_quest.s_skull_2 ] )
        {
            var_1be5586316eb3191.animstruct scene::stop_object( "Prop 1" );
            var_1be5586316eb3191.animstruct scene::stop();
            level skull_cleanup( var_1be5586316eb3191 );
            var_1be5586316eb3191 utility::ent_flag_set( "is_torch_delivered" );
            var_1be5586316eb3191.animstruct scene::stop();
        }
        
        for ( i = 0; i < level.scarab_pap_quest.var_c6b9e23aac03b4d0.size ; i++ )
        {
            var_4d376276647607c7 = level.scarab_pap_quest.var_c6b9e23aac03b4d0[ i ];
            var_4d376276647607c7 function_760e6888e3e99e1d( 1 );
        }
        
        foreach ( var_2e2441e747b19673 in level.scarab_pap_quest.var_869784d65d81d184 )
        {
            if ( var_2e2441e747b19673 utility::ent_flag( "is_finish_rotated" ) )
            {
                continue;
            }
            
            var_2e2441e747b19673.mdl utility::function_7c10ea82c1e305b8( "usable", "usable" );
        }
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x7ce5b67c, Offset: 0x53ee
// Size: 0xd9b
function private function_34d2a3b178084055( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    var_1be5586316eb3191 = self.ref == #"hash_c7044385893e7295" ? level.scarab_pap_quest.s_skull_1 : level.scarab_pap_quest.s_skull_2;
    level endon( "cancel_hunt_each_skull" + var_1be5586316eb3191.num );
    var_482ec38e12e036dd = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_b1efd54170d7cdb9" : #"hash_f96e5211a125fba2" );
    
    if ( !var_482ec38e12e036dd || var_482ec38e12e036dd == 0 )
    {
        var_1be5586316eb3191.var_348491563c879773 = 0;
        level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_b1efd54170d7cdb9" : #"hash_f96e5211a125fba2", 0 );
    }
    
    if ( level utility::flag( "open_sesame" ) )
    {
        level zm_quest::get_quest( #"scarab_pap_quest" ).skip_splash = 1;
    }
    
    if ( !isalive( var_1be5586316eb3191.agent ) )
    {
        var_fb30f3b84d922147 = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_cce5cbb8c9e0117a" : #"hash_b79f2a6fc4be996b" );
        
        if ( var_fb30f3b84d922147 )
        {
            level zm_quest::get_quest_step( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_402e0d074cc6f251" : #"hash_402e0a074cc6ed38" ).skip_splash = 1;
            level zm_quest::get_quest_step( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_402e0d074cc6f251" : #"hash_402e0a074cc6ed38" ).var_94c5b7d04e0c2501 = 1;
        }
        
        return;
    }
    
    if ( b_skipped || b_save_restored || self.completed || level utility::flag( "open_sesame" ) )
    {
        return;
    }
    
    while ( var_1be5586316eb3191.node_idx < 1 )
    {
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_scarab_artifact_1" );
    }
    
    if ( var_1be5586316eb3191.node_idx < var_1be5586316eb3191.path_array.size )
    {
        if ( var_1be5586316eb3191.node_idx == 1 )
        {
            results = var_1be5586316eb3191.agent utility::waittill_any_return_params( "damage", "skip_to" );
            isskipping = results[ "message" ] == "skip_to";
        }
        
        self.var_94c5b7d04e0c2501 = 0;
        var_1be5586316eb3191 function_96d06a6ebdf6d263();
        var_6f978d6e06f99094 = isskipping ? results[ 0 ] : var_1be5586316eb3191.node_idx;
        var_57128c33337aeaef = var_1be5586316eb3191 function_447d07e229236a98( var_6f978d6e06f99094 );
        
        for ( i = var_6f978d6e06f99094; i < var_1be5586316eb3191.path_array.size ; i++ )
        {
            if ( i != var_6f978d6e06f99094 || isskipping )
            {
                var_1be5586316eb3191 function_bb7d1abe300ec126( var_1be5586316eb3191.path_array[ i ].origin );
            }
            
            var_492729916603c7c0 = i / var_1be5586316eb3191.path_array.size * 100;
            var_1be5586316eb3191.agent utility::function_7c10ea82c1e305b8( "cracks", var_492729916603c7c0 + "_damage" );
            var_1f7e6ff49ed186ea = 0;
            var_57128c33337aeaef = var_1be5586316eb3191.health_checkpoints[ i - 1 ] ?? var_1be5586316eb3191.agent.maxhealth;
            var_f9e25bf667ccd796 = undefined;
            
            do
            {
                results = var_1be5586316eb3191.agent utility::waittill_any_return_params( "damage", "skip_to" );
                idamage = results[ "message" ] == "damage" ? results[ 0 ] : -1;
                
                if ( idamage < 0 && results[ 0 ] > var_1be5586316eb3191.node_idx )
                {
                    /#
                        var_57128c33337aeaef = var_1be5586316eb3191 function_447d07e229236a98( results[ 0 ] );
                    #/
                    
                    break;
                }
                
                if ( level.scarab_pap_quest.s_current_skull != var_1be5586316eb3191 )
                {
                    var_1be5586316eb3191 function_96d06a6ebdf6d263();
                }
                
                level utility::play_sound_in_space( "evt_papq_skull_damage_hit", var_1be5586316eb3191.agent.origin, var_1be5586316eb3191.agent );
                var_dd4e6b80d55fa6b3 = var_1be5586316eb3191.agent.health - idamage;
                damagetaken = var_57128c33337aeaef - var_1be5586316eb3191.agent.health;
                var_64bc501c93ac9b83 = int( damagetaken / var_1be5586316eb3191.var_64bc501c93ac9b83 );
                
                if ( var_64bc501c93ac9b83 > var_1f7e6ff49ed186ea )
                {
                    var_c99e2dd45847a0db = var_64bc501c93ac9b83 - var_1f7e6ff49ed186ea;
                    
                    for ( vialsdropped = 0; vialsdropped < var_c99e2dd45847a0db ; vialsdropped++ )
                    {
                        var_1be5586316eb3191 thread function_bddb5cd64c663497( vialsdropped * 0.075 );
                    }
                    
                    var_1f7e6ff49ed186ea = var_64bc501c93ac9b83;
                }
                
                var_1be5586316eb3191.agent.health = var_dd4e6b80d55fa6b3 < var_1be5586316eb3191.health_checkpoints[ i ] ? var_1be5586316eb3191.health_checkpoints[ i ] : var_dd4e6b80d55fa6b3;
                
                if ( !isdefined( var_f9e25bf667ccd796 ) )
                {
                    var_f9e25bf667ccd796 = results[ 1 ];
                }
            }
            while ( var_1be5586316eb3191.agent.health > var_1be5586316eb3191.health_checkpoints[ i ] );
            
            if ( namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( var_f9e25bf667ccd796 ) && ( !level.scarab_pap_quest.var_2da12b930758856a || randomfloat( 1 ) > 0.5 ) )
            {
                level.scarab_pap_quest thread function_c7e06474a927134f( var_f9e25bf667ccd796 );
            }
        }
        
        var_1be5586316eb3191.agent utility::function_7c10ea82c1e305b8( "health", "ignore_damage_ghost" );
        center = var_1be5586316eb3191.s_circle_node.origin;
        v_center_to_pos = vectornormalize( var_1be5586316eb3191.agent.e_mover.origin - center );
        theta = math::anglebetweenvectorssigned( ( 1, 0, 0 ), v_center_to_pos, ( 0, 0, 1 ) );
        xdest = center[ 0 ] + cos( theta ) * var_1be5586316eb3191.s_circle_node.radius;
        ydest = center[ 1 ] + sin( theta ) * var_1be5586316eb3191.s_circle_node.radius;
        var_1be5586316eb3191 function_bb7d1abe300ec126( ( xdest, ydest, center[ 2 ] ), undefined, 1 );
        
        if ( var_1be5586316eb3191.var_7f2eb0a6d3eaed2e )
        {
            level thread utility::draw_angles( var_1be5586316eb3191.agent.e_mover.angles, var_1be5586316eb3191.agent.e_mover.origin, ( 0, 1, 0 ), 10000, 1.5 );
        }
    }
    
    var_1be5586316eb3191 utility::ent_flag_set( "is_circling" );
    var_1be5586316eb3191.agent.health = int( var_1be5586316eb3191.agent.maxhealth * 0.25 );
    var_1be5586316eb3191.agent utility::function_7c10ea82c1e305b8( "cracks", "80_damage" );
    var_1be5586316eb3191 thread function_2602f4ee6a678353();
    pos_on_ground = getgroundposition( var_1be5586316eb3191.s_circle_node.origin, 1 );
    var_b3c889daa506785e = getclosestpointonnavmesh( pos_on_ground );
    event_zone = zone_manager::function_90e5c3e2272b0130( var_b3c889daa506785e );
    var_1be5586316eb3191 thread spawn_event_zombies( 1000, event_zone, "pq_skull_circle", 2000, 1500, "is_circling", 2, 4, 12, var_1be5586316eb3191.var_ae8733439bf340f4, var_1be5586316eb3191.s_circle_node.origin );
    var_1be5586316eb3191.agent thread function_5c306f89da6592bf( var_1be5586316eb3191.s_circle_node.origin );
    var_20cbbe41ae0129c8 = var_1be5586316eb3191.num == 1 ? [ 3, 4 ] : [ 1, 2 ];
    var_8af4bb0185feb88 = var_20cbbe41ae0129c8[ var_1be5586316eb3191.path_idx ];
    var_1be5586316eb3191.agent thread zm_sat_scarab_rb::function_dba55b5c7bdfb0ed( var_8af4bb0185feb88, &function_a389dc321c1795e8, self.ref == #"hash_c7044385893e7295" ? "papq_sk1_done" : "papq_sk2_done" );
    level zm_music::start_zone_music_watcher( "skull_battle_" + var_8af4bb0185feb88, [ undefined, [ "zone_sw_temple_entrance", "zone_sw_temple_mainhall", "zone_sw_temple_sideroom_landing" ], [ "zone_nw_temple_entrance", "zone_nw_temple_interior_steps" ], [ "zone_ne_temple_exterior_steps", "zone_ne_temple_courtyard", "zone_ne_temple_westwing_exterior", "zone_ne_temple_eastwing_exterior" ], [ "zone_se_temple_entrance", "zone_se_temple_finalroom", "zone_se_temple_mainhall_north", "zone_se_temple_mainhall_south" ] ][ var_8af4bb0185feb88 ], #"hash_dd081789917f8d9d" );
    var_1be5586316eb3191.agent utility::function_7c10ea82c1e305b8( "health", "damage_detect" );
    var_1be5586316eb3191.agent val::reset( "pq_skull", "damage" );
    var_1be5586316eb3191.agent waittill( #"death" );
    deathorigin = var_1be5586316eb3191.agent.origin;
    deathangles = var_1be5586316eb3191.agent.angles;
    playfx( utility::getfx( "skull_boom_fx" ), deathorigin, anglestoforward( deathangles ), anglestoup( deathangles ) );
    level.scarab_pap_quest thread play_vo_banter( #"hash_88369e0d8765096f", -1, undefined );
    level utility::play_sound_in_space( "evt_papq_skull_explode", deathorigin );
    level zm_music::function_e9fd14ede793ef0d( "skull_battle_" + var_8af4bb0185feb88 );
    var_1be5586316eb3191 utility::ent_flag_clear( "is_circling" );
    var_c6457b9450c88863 = getplayersinradius( deathorigin, 1250 );
    
    foreach ( player in var_c6457b9450c88863 )
    {
        if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.shockname ) )
        {
            player thread shellshock_utility_cpmp::_shellshock( %"sat_concussion_grenade_mp", #"stun", 2, 1 );
        }
        
        player val::set( "pq_skull_explode", "show_hud", 0 );
        player thread utility::delaythread( 1.8, &val::set, "pq_skull_explode", "show_hud", 1 );
    }
    
    level skull_cleanup( var_1be5586316eb3191 );
    var_1be5586316eb3191.var_8242e1e7ed6da21a = utility::spawn_model( "tag_origin", deathorigin, deathangles );
    playfxontag( utility::getfx( "skull_ball_fx" ), var_1be5586316eb3191.var_8242e1e7ed6da21a, "tag_origin" );
    
    if ( !isdefined( var_1be5586316eb3191.var_87f8c6598b0699af ) )
    {
        var_1be5586316eb3191.var_87f8c6598b0699af = function_47c86977a18df38b( level.scarab_pap_quest.var_f0218d7a43516520, var_1be5586316eb3191.s_circle_node.origin );
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", hashcat( #"hash_ff2398a72f6caaa7", var_1be5586316eb3191.var_87f8c6598b0699af.script_noteworthy ), 1 );
    endpointpos = var_1be5586316eb3191.var_87f8c6598b0699af.origin + ( 0, 0, 24 );
    midpointpos = ( deathorigin + endpointpos ) / 2;
    handle = ( midpointpos[ 0 ], midpointpos[ 1 ], midpointpos[ 2 ] + 84 );
    var_1be5586316eb3191.var_8242e1e7ed6da21a utility::function_8001268940441423( deathorigin, endpointpos, handle, 2 );
    
    if ( var_1be5586316eb3191.var_8242e1e7ed6da21a )
    {
        var_1be5586316eb3191.var_8242e1e7ed6da21a delete();
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x8a28e9f1, Offset: 0x6191
// Size: 0x8e, Type: bool
function private function_447d07e229236a98( path_idx )
{
    function_e2fc8115f872162d( self, path_idx );
    healthtoset = self.health_checkpoints[ path_idx - 1 ] ?? self.agent.health;
    self.agent.health = healthtoset <= 0 ? 1 : healthtoset;
    return self.health_checkpoints[ path_idx - 2 ] ?? self.agent.maxhealth;
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xbbcda83, Offset: 0x6228
// Size: 0x24, Type: bool
function private function_a389dc321c1795e8( var_8af4bb0185feb88 )
{
    return isalive( self ) && self.agent_type == "sat_spawner_zombie_wither_zm_scpq";
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x1c46deb8, Offset: 0x6255
// Size: 0x28c
function private function_5c306f89da6592bf( event_origin )
{
    self endon( #"death" );
    
    while ( isalive( self ) )
    {
        var_58ce97f82627f845 = getaiarrayinradius( event_origin, 1000 );
        
        foreach ( zombie in var_58ce97f82627f845 )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            if ( !zombie.var_3f41062a98e768c )
            {
                continue;
            }
            
            if ( zombie.var_fafecd2eda47fc8c )
            {
                continue;
            }
            
            if ( zombie.b_in_spawn_closet )
            {
                continue;
            }
            
            if ( !utility::time_has_passed( zombie.timespawned, 6 ) )
            {
                continue;
            }
            
            var_e3d7c56f21e0093a = zombie gettagorigin( "j_head", 1 );
            
            if ( !var_e3d7c56f21e0093a || !sighttracepassed( var_e3d7c56f21e0093a, self.origin, 1, zombie, self ) )
            {
                continue;
            }
            
            var_180eb370d406426b = undefined;
            var_180eb370d406426b = playfxontagsbetweenclients( utility::getfx( "skull_power_beam_fx" ), self, "j_head", zombie, "j_head" );
            
            if ( var_180eb370d406426b )
            {
                self.beam_sound = utility::play_sound_in_space( "evt_papq_skull_siphon_beam_start", self.origin, self );
                var_180eb370d406426b thread namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
                zombie thread utility::delete_on_death( var_180eb370d406426b );
                var_180eb370d406426b thread utility::delete_after_delay( 0.75 );
            }
            
            zombie.var_fafecd2eda47fc8c = 1;
            zombie utility::function_7c10ea82c1e305b8( "base", "red_glow_eyes" );
            zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "sprint" == "super_sprint" || "sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "sprint" == "sprint" ? "run" : "sprint", "pq_skull_circle", 6 );
            wait 0.8;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x59a8e0c5, Offset: 0x64e9
// Size: 0x217
function private skull_damage_callback( dmg_struct )
{
    var_c5541bc107fc443b = self.var_1be5586316eb3191.health_checkpoints[ self.var_1be5586316eb3191.node_idx ] ?? self.maxhealth;
    var_c5541bc107fc443b = self.var_1be5586316eb3191.node_idx > self.var_1be5586316eb3191.health_checkpoints.size ? 0 : var_c5541bc107fc443b;
    var_dd4e6b80d55fa6b3 = self.health - dmg_struct.idamage;
    
    if ( self.var_1be5586316eb3191 utility::ent_flag( "is_circling" ) )
    {
        dmg_struct.var_d20799805edf0194 = utility::ent_flag( "is_doing_jitter" );
        
        if ( utility::ent_flag( "is_doing_jitter" ) )
        {
            self.health = int( dmg_struct.idamage ) + 1000;
            var_dd4e6b80d55fa6b3 = self.health - dmg_struct.idamage;
        }
        
        if ( var_dd4e6b80d55fa6b3 > 0 )
        {
            return dmg_struct.idamage;
        }
        
        if ( utility::ent_flag( "is_doing_jitter" ) )
        {
            return 0;
        }
        
        self.e_mover notify( #"interrupt_circle_move" );
        self notify( #"hash_2bbf1ddeb55ebe02" );
        utility::function_7c10ea82c1e305b8( "cracks", "100_damage" );
        utility::ent_flag_set( "is_doing_jitter" );
        self.e_mover utility::do_jitter( 7, 0.8, 0.8 );
        val::reset( "pq_skull", "death" );
        self kill( self.origin, dmg_struct.eattacker, dmg_struct.einflictor );
        return dmg_struct.idamage;
    }
    
    if ( var_dd4e6b80d55fa6b3 > var_c5541bc107fc443b )
    {
        return dmg_struct.idamage;
    }
    
    adjusteddamage = self.health - var_c5541bc107fc443b + 1;
    
    if ( !isdefined( adjusteddamage ) || adjusteddamage < 0 )
    {
        return 0;
    }
    
    self notify( #"damage", adjusteddamage );
    return adjusteddamage;
}

// Namespace zm_sat_scarab_pap_quest
// Params 3, eflags: 0x4
// Checksum 0x79e1643d, Offset: 0x6709
// Size: 0x20, Type: bool
function private skull_insta_kill( eattacker, smeansofdeath, shitloc )
{
    return true;
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x84732ca8, Offset: 0x6732
// Size: 0x5f5
function private function_bddb5cd64c663497( delay )
{
    self.agent endon( #"death" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    var_1be5586316eb3191 = self;
    spawnoptions = common_item::function_bc5ff2958b71a708( var_1be5586316eb3191.agent.origin, var_1be5586316eb3191.agent.angles );
    essenceorb = common_item::items_spawnitemfromscriptable( %"hash_1eee0e52bf4c061c", randomintrange( 2, 3 ), spawnoptions );
    
    if ( !isdefined( essenceorb ) )
    {
        return;
    }
    
    e_mover = utility::spawn_model( "tag_origin", essenceorb.origin, essenceorb.angles );
    essenceorb.e_mover = e_mover;
    essenceorb.e_mover endon( #"death" );
    essenceorb endon( #"hash_3b5f54b955c0c6ec" );
    waitframe();
    
    if ( essenceorb )
    {
        if ( essenceorb.linkedparent )
        {
            essenceorb utility::scriptable_clearparententity();
        }
        
        essenceorb utility::scriptable_setparententity( essenceorb.e_mover );
        xoffset = randomintrange( -64, 64 );
        yoffset = randomintrange( -64, 64 );
        v_landing = getgroundposition( var_1be5586316eb3191.agent.origin, 1 ) + ( xoffset, yoffset, 0 );
        v_landing = getclosestpointonnavmesh( v_landing ) + ( 0, 0, 4 );
        gravity = getdvarfloat( @"bg_gravity", 0 ) * -1;
        dist = distance( var_1be5586316eb3191.agent.origin, v_landing );
        time = max( dist / 250, 0.5 );
        delta = v_landing - var_1be5586316eb3191.agent.origin;
        drop = 0.5 * gravity * time * time;
        velocity = ( delta[ 0 ] / time, delta[ 1 ] / time, ( delta[ 2 ] - drop ) / time );
        essenceorb.e_mover movegravity( velocity, time );
        wait time;
        
        if ( essenceorb )
        {
            essenceorb.e_mover moveto( v_landing, 0.25 );
            
            if ( !isdefined( level.scarab_pap_quest.var_b127d1ef4a2d06c3 ) )
            {
                level.scarab_pap_quest.var_b127d1ef4a2d06c3 = [];
            }
            
            level.scarab_pap_quest.var_b127d1ef4a2d06c3[ level.scarab_pap_quest.var_b127d1ef4a2d06c3.size ] = essenceorb;
            level utility::callsharedfunc( #"jetgun", #"hash_f5c28d458e95c1fc", essenceorb.e_mover );
        }
    }
    
    v_force_move_pos = undefined;
    
    while ( isdefined( essenceorb ) )
    {
        a_players = v_force_move_pos ? level.players : getplayersinradius( essenceorb.origin, 256, undefined, 1 );
        a_nearby_players = utility::get_array_of_closest( essenceorb.origin, a_players );
        var_2f8f8419c9ba51d3 = 0;
        
        foreach ( player in a_nearby_players )
        {
            if ( isdefined( essenceorb.e_mover ) && ( player function_14da84d716fa9b63( essenceorb ) || isdefined( v_force_move_pos ) ) )
            {
                v_destination = v_force_move_pos ?? player getcentroid();
                v_force_move_pos = undefined;
                move_vector = 350 * level.framedurationseconds * vectornormalize( v_destination - essenceorb.e_mover.origin );
                var_2f8f8419c9ba51d3 = 1;
                essenceorb.e_mover moveto( essenceorb.e_mover.origin + move_vector, level.framedurationseconds );
                break;
            }
        }
        
        if ( !var_2f8f8419c9ba51d3 && ( level utility::issharedfuncdefined( #"zombie", #"hash_bad01cbc996e3dba" ) && !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", essenceorb.e_mover.origin ) || !ispointonnavmesh( essenceorb.e_mover.origin ) ) )
        {
            a_alive_players = utility::get_alive_players();
            closest_player = utility::get_array_of_closest( essenceorb.e_mover.origin, a_alive_players )[ 0 ];
            
            if ( isdefined( closest_player.origin ) && closest_player function_14da84d716fa9b63( essenceorb ) )
            {
                v_force_move_pos = closest_player.origin + ( 0, 0, 30 );
            }
        }
        
        wait level.framedurationseconds;
    }
    
    if ( !isdefined( level.scarab_pap_quest.var_b127d1ef4a2d06c3 ) )
    {
        level.scarab_pap_quest.var_b127d1ef4a2d06c3 = [];
    }
    
    if ( essenceorb )
    {
        level.scarab_pap_quest.var_b127d1ef4a2d06c3 = arrayremove( level.scarab_pap_quest.var_b127d1ef4a2d06c3, essenceorb );
    }
    else
    {
        level.scarab_pap_quest.var_b127d1ef4a2d06c3 = function_5713d46873b29625( level.scarab_pap_quest.var_b127d1ef4a2d06c3 );
    }
    
    e_mover thread utility::delete_after_delay( 1 );
    e_mover utility::function_51a662d7927dccc7( essenceorb );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xfdcb4994, Offset: 0x6d2f
// Size: 0x40, Type: bool
function private function_14da84d716fa9b63( orb )
{
    if ( distance( self getcentroid(), orb.origin ) > 164 )
    {
        return false;
    }
    
    if ( !isalive( self ) || player::isinlaststand( self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x84ebc56, Offset: 0x6d78
// Size: 0x19f
function private function_2602f4ee6a678353()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.agent endon( #"death", #"hash_2bbf1ddeb55ebe02" );
    self.s_circle_node.link = utility::spawn_model( "tag_origin", self.s_circle_node.origin, self.s_circle_node.angles );
    self.agent.e_mover thread utility::follow_circle( self.s_circle_node.radius, 10, self.s_circle_node.link, 1 );
    self.s_circle_node.link function_616378d7e5b22efb( ( 0, 0, 1 ), 24, 3 );
    self.agent.e_mover waittill( #"off_circle_move" );
    
    while ( self.agent.health > 0 )
    {
        self.agent.e_mover thread utility::follow_circle( self.s_circle_node.radius, 10, self.s_circle_node.link, 1 );
        waitframe();
        self.agent.e_mover waittill( #"off_circle_move" );
    }
    
    self.s_circle_node.link delete();
}

// Namespace zm_sat_scarab_pap_quest
// Params 4, eflags: 0x4
// Checksum 0xb961a117, Offset: 0x6f1f
// Size: 0x5e6
function private function_bb7d1abe300ec126( endpos, var_5d861183a36f94d3, var_4545f531d62eb660, var_eebcce8e08dc108a = 0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.agent endon( #"death", #"hash_cca7d4b2926fc69a" );
    
    if ( !self.agent utility::ent_flag( "is_laughing" ) )
    {
        self.animstruct scene::stop();
        self.agent utility::ent_flag_set( "is_laughing" );
        self.agent thread utility::animscripted_loop( "laugh" );
    }
    
    if ( !self.agent utility::function_9f2c41c1dcc8c94( "health", "ignore_damage" ) )
    {
        self.agent utility::function_7c10ea82c1e305b8( "health", "ignore_damage_ghost" );
    }
    
    self.agent val::set( "pq_skull", "damage", 0 );
    self.agent notify( #"hash_7cb487854903bb15" );
    lastpos = self.agent.e_mover.origin;
    startpos = self.agent.e_mover.origin;
    var_e16f272d8e313f8a = endpos - startpos;
    var_484987054d287200 = distance( endpos, startpos );
    segmentnormal = vectornormalize( var_e16f272d8e313f8a );
    var_a09c5040fab635e3 = mapfloat( 150, 1750, 24, 36, var_484987054d287200 );
    velocity = mapfloat( 150, 1500, 100, 225, var_484987054d287200 );
    velocity = var_5d861183a36f94d3 ? velocity * 0.75 : velocity;
    moveintervaltime = 0.1;
    var_ab37e61e5b18a09 = velocity * moveintervaltime;
    x = int( mapfloat( 150, 1500, 2, 6, var_484987054d287200 ) );
    var_2554c51c9e7c75fb = math::radians_to_degrees( x * 2 * 3.14159 - 1.5708 );
    var_2d6c72e58535776b = 0;
    traveleddistance = 0;
    
    while ( !var_eebcce8e08dc108a )
    {
        var_4860c6e042607dd3 = clamp( traveleddistance / var_484987054d287200, 0, 1 );
        
        if ( var_5d861183a36f94d3 )
        {
            var_5f8bc94d517962e4 = utility::get_bezier_position( var_4860c6e042607dd3, startpos, endpos, var_5d861183a36f94d3 );
            var_becd52aec83a4887 = 2 * ( 1 - var_4860c6e042607dd3 ) * ( var_5d861183a36f94d3 - startpos ) + 2 * var_4860c6e042607dd3 * ( endpos - var_5d861183a36f94d3 );
            
            if ( length( var_becd52aec83a4887 ) <= 0.001 )
            {
                var_becd52aec83a4887 = segmentnormal;
            }
            
            var_becd52aec83a4887 = vectornormalize( var_becd52aec83a4887 );
        }
        else
        {
            var_5f8bc94d517962e4 = startpos + var_e16f272d8e313f8a * var_4860c6e042607dd3;
            var_becd52aec83a4887 = segmentnormal;
        }
        
        sineoffset = ( 0, 0, var_a09c5040fab635e3 * sin( var_2554c51c9e7c75fb * ( var_4860c6e042607dd3 + var_2d6c72e58535776b ) ) );
        movetopoint = var_5f8bc94d517962e4 + sineoffset;
        totarget = movetopoint - self.agent.e_mover.origin;
        
        if ( length( totarget ) <= 0.001 )
        {
            skulldir = var_becd52aec83a4887;
        }
        else
        {
            skulldir = vectornormalize( totarget );
        }
        
        self.agent.e_mover moveto( movetopoint, moveintervaltime );
        
        if ( var_4860c6e042607dd3 < 1 && ( var_4860c6e042607dd3 < 0.25 || var_4860c6e042607dd3 > 0.8 ) )
        {
            self.var_40041eb298806395 = skulldir * 24 + endpos;
            self.var_4b03e79ae816beee = 1;
            self.var_c8f23fb3965a475e = undefined;
        }
        else
        {
            self.var_40041eb298806395 = undefined;
            self.var_4b03e79ae816beee = 0;
            self.var_c8f23fb3965a475e = 0;
        }
        
        thread function_7dff009c19e77de6();
        wait moveintervaltime;
        traveleddistance += var_ab37e61e5b18a09;
        
        if ( traveleddistance >= var_484987054d287200 )
        {
            break;
        }
        
        /#
            line( lastpos, self.agent.e_mover.origin, ( 1, 0, 0 ), 1, 0, 1000 );
            lastpos = self.agent.e_mover.origin;
        #/
    }
    
    if ( var_eebcce8e08dc108a )
    {
        self.agent.e_mover.origin = endpos;
        self.agent.e_mover.angles = ( 0, self.agent.e_mover.angles[ 1 ], self.agent.e_mover.angles[ 2 ] );
        var_78577e2edef1517d = self.node_idx;
    }
    else
    {
        self.var_40041eb298806395 = undefined;
        self.agent.e_mover rotateto( ( 0, self.agent.e_mover.angles[ 1 ], self.agent.e_mover.angles[ 2 ] ), 0.1 );
        var_78577e2edef1517d = self.node_idx + 1;
    }
    
    function_e2fc8115f872162d( self, var_78577e2edef1517d );
    
    if ( !var_4545f531d62eb660 )
    {
        var_1f3f8862a9b3c272 = skulldir ? vectorcross( ( 0, 0, 1 ), skulldir ) : segmentnormal;
        thread function_8a70a409414e99bb( var_1f3f8862a9b3c272, 1, 60, 0, 30 );
    }
    
    self.var_c8f23fb3965a475e = 1;
    self.var_4b03e79ae816beee = 0;
    self.agent utility::function_7c10ea82c1e305b8( "health", "damage_detect" );
    self.agent val::reset( "pq_skull", "damage" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 5, eflags: 0x4
// Checksum 0x6ae55ca9, Offset: 0x750d
// Size: 0x45f
function private function_8a70a409414e99bb( segmentnormal = ( 1, 0, 0 ), var_d777601be7287ee7 = 1, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b )
{
    self.agent endon( #"death", #"hash_7cb487854903bb15" );
    idlecenter = self.agent.e_mover.origin;
    var_d777601be7287ee7 = var_d777601be7287ee7;
    var_edfa19e75eb7e3e1 = var_d777601be7287ee7 ? var_edfa19e75eb7e3e1 * -1 : var_edfa19e75eb7e3e1;
    var_edfa18e75eb7e1ae = var_d777601be7287ee7 ? var_edfa18e75eb7e1ae * -1 : var_edfa18e75eb7e1ae;
    var_edfa17e75eb7df7b = var_d777601be7287ee7 ? var_edfa17e75eb7df7b * -1 : var_edfa17e75eb7df7b;
    worldup = ( 0, 0, 1 );
    rightaxis = vectornormalize( vectorcross( segmentnormal, worldup ) );
    frameup = vectornormalize( vectorcross( rightaxis, segmentnormal ) );
    velocity = 110;
    moveintervaltime = 0.08;
    var_ab37e61e5b18a09 = velocity * moveintervaltime;
    var_b7a83c120c2a977b = 1.3;
    var_a2be2bf3eca86d10 = 0.75;
    var_c83f8754d9a38950 = 0.5;
    var_14eb833a28b4357a = 1;
    
    if ( var_edfa17e75eb7df7b >= 0 )
    {
        var_de22377a794b43c = function_9fb3989280ff645( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, 45, 135 );
        var_fc28b0deec62917c = function_9fb3989280ff645( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, 135, 225 );
    }
    else
    {
        var_de22377a794b43c = function_9fb3989280ff645( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, 135, 225 );
        var_fc28b0deec62917c = function_9fb3989280ff645( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, 45, 135 );
    }
    
    var_da87357e609b2c8f = 180;
    var_51bb5f8788144c55 = var_da87357e609b2c8f + 1;
    startpoint = function_f432d0a80e4fc236( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, 1 );
    var_5f7e954fef5f7dd1 = function_f432d0a80e4fc236( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, var_51bb5f8788144c55 );
    var_3b36b63dbb87b3c = distance( startpoint, var_5f7e954fef5f7dd1 );
    var_da87357e609b2c8f += var_ab37e61e5b18a09 / max( var_3b36b63dbb87b3c, 0.001 );
    var_40c6fbcff3780891 = 0;
    var_bb1c24cf988f60e9 = 0;
    var_7bbf9d2f36f06e0a = 0;
    var_9d85241c95a6c94a = 0;
    currentspeedscale = 1;
    var_ae007d03d938d588 = 1;
    var_be7c344476f9fb5d = 1;
    lastpos = self.agent.e_mover.origin;
    
    do
    {
        movetopoint = function_f432d0a80e4fc236( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, var_da87357e609b2c8f );
        travelstep = distance( lastpos, movetopoint );
        upoffset = sin( var_da87357e609b2c8f * 2 ) * var_edfa17e75eb7df7b;
        var_fd57c9695177f68c = upoffset < var_40c6fbcff3780891;
        
        if ( var_fd57c9695177f68c != var_bb1c24cf988f60e9 )
        {
            var_7bbf9d2f36f06e0a = 0;
            var_9d85241c95a6c94a = 0;
            var_ae007d03d938d588 = currentspeedscale;
            var_be7c344476f9fb5d = var_fd57c9695177f68c ? var_b7a83c120c2a977b : 1;
        }
        
        if ( var_fd57c9695177f68c )
        {
            var_7bbf9d2f36f06e0a += travelstep;
            descentt = clamp( var_7bbf9d2f36f06e0a / max( var_de22377a794b43c * var_a2be2bf3eca86d10, 0.001 ), 0, 1 );
            targetspeedscale = lerp( var_ae007d03d938d588, var_be7c344476f9fb5d, descentt );
        }
        else
        {
            var_9d85241c95a6c94a += travelstep;
            ascentt = clamp( var_9d85241c95a6c94a / max( var_fc28b0deec62917c * var_c83f8754d9a38950, 0.001 ), 0, 1 );
            targetspeedscale = lerp( var_ae007d03d938d588, var_be7c344476f9fb5d, ascentt );
        }
        
        speedscale = lerp( currentspeedscale, targetspeedscale, var_14eb833a28b4357a );
        currentspeedscale = speedscale;
        var_bb1c24cf988f60e9 = var_fd57c9695177f68c;
        var_40c6fbcff3780891 = upoffset;
        self.agent.e_mover moveto( movetopoint, moveintervaltime );
        wait moveintervaltime;
        var_51bb5f8788144c55 = var_da87357e609b2c8f + 1;
        sampletarget = function_f432d0a80e4fc236( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, var_51bb5f8788144c55 );
        var_a2bea4b7ff543195 = distance( movetopoint, sampletarget );
        var_7d565fee6c2f9d1 = var_ab37e61e5b18a09 * speedscale / max( var_a2bea4b7ff543195, 0.001 );
        var_da87357e609b2c8f += var_7d565fee6c2f9d1;
        lastpos = self.agent.e_mover.origin;
    }
    while ( true );
}

// Namespace zm_sat_scarab_pap_quest
// Params 10, eflags: 0x4
// Checksum 0x139deee, Offset: 0x7974
// Size: 0xf5
function private function_9fb3989280ff645( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, var_6af6d6647c72141f = 0, var_11530950ea14ee1e = 180, var_d4c980a85b7bde52 = 1 )
{
    if ( var_d4c980a85b7bde52 <= 0 )
    {
        var_d4c980a85b7bde52 = 1;
    }
    
    totaldistance = 0;
    prevpoint = function_f432d0a80e4fc236( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, var_6af6d6647c72141f );
    phase = var_6af6d6647c72141f + var_d4c980a85b7bde52;
    
    while ( phase <= var_11530950ea14ee1e )
    {
        nextpoint = function_f432d0a80e4fc236( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, phase );
        totaldistance += distance( prevpoint, nextpoint );
        prevpoint = nextpoint;
        phase += var_d4c980a85b7bde52;
    }
    
    return totaldistance;
}

// Namespace zm_sat_scarab_pap_quest
// Params 8, eflags: 0x4
// Checksum 0xfa75e1b2, Offset: 0x7a72
// Size: 0x9c
function private function_f432d0a80e4fc236( idlecenter, rightaxis, segmentnormal, frameup, var_edfa19e75eb7e3e1, var_edfa18e75eb7e1ae, var_edfa17e75eb7df7b, var_da87357e609b2c8f )
{
    rightoffset = sin( var_da87357e609b2c8f ) * var_edfa19e75eb7e3e1;
    fwdoffset = sin( var_da87357e609b2c8f * 2 ) * var_edfa18e75eb7e1ae;
    upoffset = sin( var_da87357e609b2c8f * 2 ) * var_edfa17e75eb7df7b;
    return idlecenter + rightaxis * rightoffset + segmentnormal * fwdoffset + frameup * upoffset;
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xc3f95c9d, Offset: 0x7b17
// Size: 0x15b
function private function_7dff009c19e77de6()
{
    self.agent endon( #"death", #"hash_cca7d4b2926fc69a" );
    
    if ( self.agent.var_97745da8b76ccf48 )
    {
        return;
    }
    
    var_2e5bc2b05f3dbe94 = function_47c86977a18df38b( level.scarab_pap_quest.var_59bc9f460dcca5f3, self.agent.e_mover.origin );
    
    if ( !isdefined( var_2e5bc2b05f3dbe94 ) )
    {
        return;
    }
    
    if ( distancesquared( self.agent.e_mover.origin, var_2e5bc2b05f3dbe94.origin ) > squared( 64 ) )
    {
        return;
    }
    
    if ( level utility::flag( var_2e5bc2b05f3dbe94.script_flag_set ) )
    {
        return;
    }
    
    self.agent.var_97745da8b76ccf48 = var_2e5bc2b05f3dbe94;
    playfxontag( utility::getfx( "skull_phase_fx" ), self.agent, "j_skull_jaw" );
    
    do
    {
        waitframe();
    }
    while ( distancesquared( self.agent.e_mover.origin, self.agent.var_97745da8b76ccf48.origin ) <= squared( 64 ) );
    
    self.agent.var_97745da8b76ccf48 = undefined;
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0xc
// Checksum 0x55c54c21, Offset: 0x7c7a
// Size: 0x3ec
function private function_b95bddad3b8a4f1()
{
    self notify( #"hash_9f4a547b5eee80b4" );
    self endon( #"hash_9f4a547b5eee80b4" );
    self endon( #"death" );
    self.agent endon( #"death" );
    self.agent callback::add( "on_zombie_ai_damaged", &function_961d3eae1c87e316 );
    var_acfa7617de64218 = int( level.frameduration * 1.5 );
    first_target_frames = var_acfa7617de64218;
    lookat_timestamp = undefined;
    to_start = undefined;
    to_end = undefined;
    
    do
    {
        if ( self.var_7375786dc498b042 || !self.agent.e_mover )
        {
            waitframe();
            continue;
        }
        
        if ( !self.var_40041eb298806395 )
        {
            if ( self.var_4b03e79ae816beee )
            {
                waitframe();
                continue;
            }
            
            var_915bb1a64d88fe6f = self.agent.e_mover.origin + anglestoforward( ( 0, 0, 0 ) ) * 56;
            closest_player = function_65279b9a6f7b8052();
            var_b989d260623bdfb5 = !isdefined( closest_player );
            
            if ( closest_player )
            {
                distsq = distancesquared( self.agent.e_mover.origin, closest_player.origin );
                var_b989d260623bdfb5 = distsq > squared( 1200 );
            }
            
            if ( var_b989d260623bdfb5 )
            {
                var_5bbcb415badb8b51 = undefined;
                v_pos = var_915bb1a64d88fe6f;
                to_start = 0.3;
                to_end = 0.08;
            }
            else
            {
                to_start = 0.2;
                to_end = 0.05;
                
                if ( !level utility::time_has_passed( var_5bbcb415badb8b51, 2 ) && self.var_c8f23fb3965a475e )
                {
                    to_start = 0.1;
                    to_end = 0.02;
                }
                
                v_pos = closest_player.origin;
                
                switch ( closest_player getstance() )
                {
                    case #"hash_c6775c88e38f7803":
                        v_pos += ( 0, 0, 60 );
                        break;
                    case #"hash_3fed0cbd303639eb":
                        v_pos += ( 0, 0, 40 );
                        break;
                    case #"hash_d91940431ed7c605":
                        v_pos += ( 0, 0, 11 );
                        break;
                }
                
                if ( !isdefined( var_5bbcb415badb8b51 ) )
                {
                    var_5bbcb415badb8b51 = gettime();
                }
            }
        }
        else
        {
            to_start = 0.08;
            to_end = 0.01;
            v_pos = self.var_40041eb298806395;
            var_5bbcb415badb8b51 = undefined;
        }
        
        multiplier = first_target_frames ? mapfloat( 0, var_acfa7617de64218, to_start, to_end, first_target_frames ) : to_start;
        
        if ( !isdefined( v_pos ) )
        {
            waitframe();
            continue;
        }
        
        goalangles = vectortoangles( v_pos - self.agent.e_mover.origin );
        
        if ( !isdefined( goalangles ) )
        {
            waitframe();
            continue;
        }
        
        diffangles = function_da0487dd086b6da9( goalangles - self.agent.e_mover.angles );
        newangles = diffangles * multiplier;
        newangles = function_da0487dd086b6da9( self.agent.e_mover.angles + newangles );
        self.agent.e_mover.angles = newangles;
        
        if ( first_target_frames > 0 )
        {
            first_target_frames--;
        }
        
        if ( !isdefined( lookat_timestamp ) && vectordot( anglestoforward( self.agent.e_mover.angles ), vectornormalize( v_pos - self.agent.e_mover.origin ) ) > 0.99 )
        {
            lookat_timestamp = gettime();
        }
        
        waitframe();
    }
    while ( true );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xfd515ce6, Offset: 0x806e
// Size: 0x2a2
function private function_961d3eae1c87e316( dmg_struct )
{
    self.var_1be5586316eb3191 endon( #"death" );
    self endon( #"death" );
    self.e_mover endon( #"death" );
    
    if ( !isalive( self ) || !self.e_mover )
    {
        return;
    }
    
    if ( !dmg_struct.vpoint || !dmg_struct.vdir || !dmg_struct.idamage )
    {
        return;
    }
    
    if ( self.var_1be5586316eb3191.var_7375786dc498b042 )
    {
        return;
    }
    
    if ( dmg_struct.smeansofdeath == "MOD_EXPLOSIVE" || dmg_struct.smeansofdeath == "MOD_GRENADE_SPLASH" || dmg_struct.smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        return dmg_struct.idamage;
    }
    
    var_1be5586316eb3191 = self.var_1be5586316eb3191;
    vpoint = dmg_struct.vpoint;
    vdir = dmg_struct.vdir;
    idamage = dmg_struct.idamage;
    var_1be5586316eb3191.var_7375786dc498b042 = 1;
    var_8acddcc653508613 = 35;
    var_8c4ba9ce3068a1d9 = 60;
    spindegrees = int( mapfloat( 30, 100, var_8acddcc653508613, var_8c4ba9ce3068a1d9, idamage ) );
    var_6a96e7d5a9589d5f = anglestoaxis( self.e_mover.angles );
    var_c8e1c9f5bd16db95 = self gettagorigin( "j_head", 1 ) ?? self.e_mover.origin;
    leverarm = vpoint - var_c8e1c9f5bd16db95;
    var_b4d9de79d0d10d09 = vectorcross( leverarm, vdir );
    
    if ( lengthsquared( var_b4d9de79d0d10d09 ) < 0.001 )
    {
        var_b4d9de79d0d10d09 = var_6a96e7d5a9589d5f[ "right" ];
    }
    
    var_b4d9de79d0d10d09 = vectornormalize( var_b4d9de79d0d10d09 );
    v_new_forward = rotatepointaroundvector( var_b4d9de79d0d10d09, var_6a96e7d5a9589d5f[ "forward" ], spindegrees );
    v_new_right = rotatepointaroundvector( var_b4d9de79d0d10d09, var_6a96e7d5a9589d5f[ "right" ], spindegrees );
    v_new_up = rotatepointaroundvector( var_b4d9de79d0d10d09, var_6a96e7d5a9589d5f[ "up" ], spindegrees );
    v_dest = axistoangles( v_new_forward, v_new_right, v_new_up );
    self.e_mover rotateto( v_dest, 0.2, 0.2 );
    self.e_mover waittill( #"rotatedone" );
    var_1be5586316eb3191.var_7375786dc498b042 = 0;
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x42c35782, Offset: 0x8318
// Size: 0x24
function private function_da0487dd086b6da9( angles )
{
    return ( angleclamp180( angles[ 0 ] ), angleclamp180( angles[ 1 ] ), angleclamp180( angles[ 2 ] ) );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x1ccb7775, Offset: 0x8345
// Size: 0x119
function private function_65279b9a6f7b8052()
{
    level endon( #"game_ended" );
    closestplayer = undefined;
    closestdistsq = undefined;
    var_c6457b9450c88863 = getplayersinradius( self.agent.e_mover.origin, 1200 );
    
    foreach ( player in var_c6457b9450c88863 )
    {
        if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
        {
            continue;
        }
        
        distsq = distancesquared( self.agent.e_mover.origin, player.origin );
        
        if ( !isdefined( closestdistsq ) || distsq < closestdistsq )
        {
            closestdistsq = distsq;
            closestplayer = player;
        }
    }
    
    return closestplayer;
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xc25c016f, Offset: 0x8467
// Size: 0x2d1
function private function_bd78ba8efdb51574( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( self.ref == #"hash_c7044385893e7295" )
    {
        level utility::flag_set( "papq_sk1_done" );
    }
    else
    {
        level utility::flag_set( "papq_sk2_done" );
    }
    
    var_1be5586316eb3191 = self.ref == #"hash_c7044385893e7295" ? level.scarab_pap_quest.s_skull_1 : level.scarab_pap_quest.s_skull_2;
    
    if ( b_skipped || b_save_restored || level utility::flag( "open_sesame" ) )
    {
        level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
        level skull_cleanup( var_1be5586316eb3191 );
        var_1be5586316eb3191 utility::ent_flag_set( "is_torch_delivered" );
        
        if ( b_skipped || level utility::flag( "open_sesame" ) )
        {
            if ( !b_save_restored )
            {
                if ( !level.scarab_pap_quest.var_c6b9e23aac03b4d0[ 0 ] utility::ent_flag( "is_lit" ) )
                {
                    level.scarab_pap_quest.var_c6b9e23aac03b4d0[ 0 ] function_760e6888e3e99e1d( 1 );
                }
                else
                {
                    level.scarab_pap_quest.var_c6b9e23aac03b4d0[ 1 ] function_760e6888e3e99e1d( 1 );
                }
            }
            
            if ( !isdefined( var_1be5586316eb3191.var_87f8c6598b0699af ) )
            {
                var_1be5586316eb3191.var_87f8c6598b0699af = function_47c86977a18df38b( level.scarab_pap_quest.var_f0218d7a43516520, var_1be5586316eb3191.s_circle_node.origin );
            }
            
            var_1be5586316eb3191.var_87f8c6598b0699af function_760e6888e3e99e1d( 0 );
            var_1be5586316eb3191.var_87f8c6598b0699af utility::ent_flag_set( "is_usurped_power_first_grabbed" );
            var_1be5586316eb3191.var_87f8c6598b0699af utility::function_7c10ea82c1e305b8( "usable", "off" );
            level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", hashcat( #"hash_ff2398a72f6caaa7", var_1be5586316eb3191.var_87f8c6598b0699af.script_noteworthy ), 1 );
        }
    }
    
    foreach ( event, callback_func in level.scarab_pap_quest.usurpedpowercallbacks )
    {
        if ( !level callback::exists( event, callback_func, var_1be5586316eb3191.var_87f8c6598b0699af ) )
        {
            continue;
        }
        
        level callback::remove( event, callback_func, var_1be5586316eb3191.var_87f8c6598b0699af );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xd42b711f, Offset: 0x8740
// Size: 0xd5
function private skull_cleanup( var_1be5586316eb3191 )
{
    var_1be5586316eb3191 utility::ent_flag_set( "is_destroyed" );
    
    if ( var_1be5586316eb3191.animstruct )
    {
        var_1be5586316eb3191.animstruct scene::stop();
    }
    
    if ( var_1be5586316eb3191.var_180eb370d406426b )
    {
        var_1be5586316eb3191.var_180eb370d406426b delete();
    }
    
    if ( var_1be5586316eb3191.agent )
    {
        var_1be5586316eb3191.agent kill();
    }
    
    if ( var_1be5586316eb3191.var_8242e1e7ed6da21a )
    {
        var_1be5586316eb3191.var_8242e1e7ed6da21a delete();
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_db1d1fe1fed0d0fa" : #"hash_c040c10873125dd9", 6 );
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xa2c4f80e, Offset: 0x881d
// Size: 0x3c9
function private function_fdba62bd6315bdb5( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    var_1be5586316eb3191 = self.ref == #"hash_402e0d074cc6f251" ? level.scarab_pap_quest.s_skull_1 : level.scarab_pap_quest.s_skull_2;
    var_482ec38e12e036dd = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_b1efd54170d7cdb9" : #"hash_f96e5211a125fba2" );
    
    if ( !var_482ec38e12e036dd || var_482ec38e12e036dd == 2 )
    {
        var_1be5586316eb3191.var_348491563c879773 = 2;
        level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_b1efd54170d7cdb9" : #"hash_f96e5211a125fba2", 2 );
    }
    
    if ( level utility::flag( "open_sesame" ) )
    {
        level zm_quest::get_quest( #"scarab_pap_quest" ).skip_splash = 1;
    }
    
    if ( b_skipped || b_save_restored || level utility::flag( "open_sesame" ) )
    {
        return;
    }
    
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    level skull_cleanup( var_1be5586316eb3191 );
    
    if ( !isdefined( var_1be5586316eb3191.var_87f8c6598b0699af ) )
    {
        var_1be5586316eb3191.var_87f8c6598b0699af = function_47c86977a18df38b( level.scarab_pap_quest.var_f0218d7a43516520, var_1be5586316eb3191.s_circle_node.origin );
    }
    
    var_1be5586316eb3191.var_87f8c6598b0699af.var_1be5586316eb3191 = var_1be5586316eb3191;
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", hashcat( #"hash_ff2398a72f6caaa7", var_1be5586316eb3191.var_87f8c6598b0699af.script_noteworthy ), 1 );
    
    foreach ( event, callback_func in level.scarab_pap_quest.usurpedpowercallbacks )
    {
        if ( level callback::exists( event, callback_func, var_1be5586316eb3191.var_87f8c6598b0699af ) )
        {
            continue;
        }
        
        level callback::add( event, callback_func, var_1be5586316eb3191.var_87f8c6598b0699af );
    }
    
    var_fb30f3b84d922147 = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_cce5cbb8c9e0117a" : #"hash_b79f2a6fc4be996b" );
    var_1be5586316eb3191.var_87f8c6598b0699af.var_3a45536cff3b28ac = var_fb30f3b84d922147 == 2 || var_fb30f3b84d922147 == 3 ? 3 : 0;
    
    if ( !var_fb30f3b84d922147 || var_fb30f3b84d922147 != 2 )
    {
        var_1be5586316eb3191.var_87f8c6598b0699af function_760e6888e3e99e1d( 1 );
        var_1be5586316eb3191.var_87f8c6598b0699af utility::function_7c10ea82c1e305b8( "usable", "usable" );
        var_1be5586316eb3191 function_96d06a6ebdf6d263();
    }
    
    if ( var_fb30f3b84d922147 )
    {
        var_1be5586316eb3191.var_87f8c6598b0699af utility::ent_flag_set( "is_usurped_power_first_grabbed" );
        return;
    }
    
    var_1be5586316eb3191.var_87f8c6598b0699af utility::ent_flag_wait( "is_usurped_power_first_grabbed" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x535288b3, Offset: 0x8bee
// Size: 0x1c6
function private function_10f75cf5ef72a3fd( player )
{
    level endon( #"game_ended" );
    
    if ( player.interactions_disabled || level utility::flag( "disallow_usurped_power" ) || player utility::function_9f2c41c1dcc8c94( "corrupted_fx", "unstable_on" ) )
    {
        return;
    }
    
    if ( self.item )
    {
        return;
    }
    
    if ( level utility::issharedfuncdefined( #"quest", #"hash_cd5baec2a82d6549" ) && self.var_8af4bb0185feb88 )
    {
        b_end = level utility::callsharedfunc( #"quest", #"hash_cd5baec2a82d6549", player, self );
        
        if ( b_end )
        {
            return;
        }
    }
    
    additionalinfo = { #var_3dfb48cd2da760ed:self.var_87f8c6598b0699af.var_3dfb48cd2da760ed };
    
    if ( !player callback::exists( "usurped_power_deploying", &function_22c69cd5983a09d, self.var_87f8c6598b0699af ) )
    {
        player callback::add( "usurped_power_deploying", &function_22c69cd5983a09d, self.var_87f8c6598b0699af );
    }
    
    if ( self.var_87f8c6598b0699af.var_3dfb48cd2da760ed )
    {
        level zm_quest::function_6265be8d0549e1b1( #"scarab_phone_quest", hashcat( #"hash_d093261ec76a4ecb", self.s_brazier.script_noteworthy ) );
    }
    
    var_997d4b6005a845d1 = self.var_87f8c6598b0699af utility::ent_flag( "has_cosmic_power" );
    equipinfo = namespace_e9c7b42a427c6c3a::give_usurped_power( player, var_997d4b6005a845d1, additionalinfo );
    
    if ( player callback::exists( "usurped_power_deploying", &function_22c69cd5983a09d, self.var_87f8c6598b0699af ) )
    {
        player callback::remove( "usurped_power_deploying", &function_22c69cd5983a09d, self.var_87f8c6598b0699af );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xbffdb6b3, Offset: 0x8dbc
// Size: 0x297
function private function_f306401e80062fef( interact, player )
{
    var_42555a5e56e33403 = !player isonground() && !player isswimming() || player isonladder() || player utility::ent_flag( "is_usurped_power_grabbed" ) || player utility::function_9f2c41c1dcc8c94( "corrupted_fx", "unstable_on" );
    
    if ( level utility::flag( "disallow_usurped_power" ) || player.interactions_disabled || var_42555a5e56e33403 || interact.item )
    {
        return { #interactable:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    else if ( interact utility::function_9f2c41c1dcc8c94( "usable", "cooldown" ) )
    {
        return { #interactable:0, #string:&"SHARED_HINTSTRINGS/TRAP_COOLDOWN_HINT", #type:"HINT_NOBUTTON" };
    }
    else if ( interact utility::function_9f2c41c1dcc8c94( "usable", "usable" ) && interact.var_87f8c6598b0699af utility::ent_flag( "is_lit" ) )
    {
        string = interact.var_87f8c6598b0699af utility::ent_flag( "has_cosmic_power" ) ? &"hash_2a84988f9b16380" : &"hash_33009289e2a7c8c";
        return { #string:string, #type:"HINT_NOICON" };
    }
    else if ( level zm_quest::function_b0a5181ebe7bb905() && isdefined( level.zm_scarab_mq.var_a1b2e808da2bc982 ) && interact.script_noteworthy && level.zm_scarab_mq.var_a1b2e808da2bc982 == int( interact.script_noteworthy ) && !interact.item && level utility::flag( "totes_check_check" + level.zm_scarab_mq.var_a1b2e808da2bc982 ) && !level utility::flag( "totes_plop_hop" + level.zm_scarab_mq.var_a1b2e808da2bc982 ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_50d67812942d9840", #type:"HINT_BUTTON" };
    }
    
    return { #interactable:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xc73c099a, Offset: 0x905c
// Size: 0x1d8
function private function_22c69cd5983a09d( sparams, var_87f8c6598b0699af )
{
    player = sparams.player;
    equipinfo = sparams.equipinfo;
    deployweapon = equipinfo.deployweapon;
    var_87f8c6598b0699af utility::ent_flag_set( "is_usurped_power_first_grabbed" );
    
    if ( !isdefined( var_87f8c6598b0699af.var_3a45536cff3b28ac ) )
    {
        var_87f8c6598b0699af.var_3a45536cff3b28ac = 0;
    }
    
    var_87f8c6598b0699af.var_3a45536cff3b28ac++;
    var_87f8c6598b0699af.var_5e2221840c5be55d = player;
    var_87f8c6598b0699af function_760e6888e3e99e1d( 0 );
    equipinfo.var_87f8c6598b0699af = var_87f8c6598b0699af;
    
    if ( !var_87f8c6598b0699af.interact utility::ent_flag( "enabled_for_totem" ) )
    {
        var_87f8c6598b0699af utility::function_7c10ea82c1e305b8( "usable", "off" );
    }
    
    if ( var_87f8c6598b0699af.var_1be5586316eb3191 )
    {
        var_1be5586316eb3191 = var_87f8c6598b0699af.var_1be5586316eb3191;
        equipinfo.var_1be5586316eb3191 = var_1be5586316eb3191;
        var_1be5586316eb3191 function_96d06a6ebdf6d263( { #firstpickup:var_87f8c6598b0699af.var_3a45536cff3b28ac == 1 } );
        var_f4ee6227e4cd2e2f = var_87f8c6598b0699af.var_3a45536cff3b28ac >= 3 ? 2 : 1;
        level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_cce5cbb8c9e0117a" : #"hash_b79f2a6fc4be996b", var_f4ee6227e4cd2e2f );
    }
    
    var_5e1c75975eb34ec4 = var_87f8c6598b0699af.var_3dfb48cd2da760ed ? #"hash_30048b153d63c135" : #"hash_7355ed11646a36a1";
    level.scarab_pap_quest thread play_vo_banter( var_5e1c75975eb34ec4, 15, player, undefined, 1 );
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xc5f4cd88, Offset: 0x923c
// Size: 0x62
function private function_24800776007b2216( sparams, var_87f8c6598b0699af )
{
    player = sparams.player;
    equipinfo = sparams.equipinfo;
    switchresult = sparams.switchresult;
    var_87f8c6598b0699af thread function_7f042c187671e6ab( equipinfo, 1 );
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x8588d754, Offset: 0x92a6
// Size: 0x8d
function private function_65c67f99e310d390( sparams, var_87f8c6598b0699af )
{
    player = sparams.player;
    equipinfo = sparams.equipinfo;
    switchresult = sparams.switchresult;
    equipinfo.fireballs = function_5713d46873b29625( equipinfo.fireballs );
    
    if ( equipinfo.fireballs.size > 0 )
    {
        return;
    }
    
    var_87f8c6598b0699af thread function_7f042c187671e6ab( equipinfo );
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xae18f6cc, Offset: 0x933b
// Size: 0x8d
function private function_b00975f421635a2e( sparams, var_87f8c6598b0699af )
{
    player = sparams.player;
    equipinfo = sparams.equipinfo;
    var_c7e6abba90b31f67 = sparams.var_c7e6abba90b31f67;
    stuckto = sparams.stuckto;
    var_55bc4979ee147531 = sparams.var_55bc4979ee147531;
    wait 2;
    var_87f8c6598b0699af thread function_7f042c187671e6ab( equipinfo );
}

// Namespace zm_sat_scarab_pap_quest
// Params 3, eflags: 0x4
// Checksum 0xf594bb96, Offset: 0x93d0
// Size: 0x1b8
function private function_7f042c187671e6ab( equipinfo, var_15e41ffe0e2d037 = 0, var_1fbad0c50e0f39fa = 0 )
{
    level endon( #"game_ended" );
    
    if ( self.dontreset || self.isresetting )
    {
        return;
    }
    
    if ( self.var_1be5586316eb3191 utility::ent_flag( "is_torch_delivered" ) )
    {
        return;
    }
    
    if ( !var_15e41ffe0e2d037 && utility::ent_flag( "is_lit" ) )
    {
        return;
    }
    
    self.isresetting = 1;
    var_7a4474e071a50b0b = var_1fbad0c50e0f39fa || !self.var_3dfb48cd2da760ed && self.var_3a45536cff3b28ac >= 3;
    self.var_7a4474e071a50b0b = 1;
    self.var_1be5586316eb3191 function_96d06a6ebdf6d263( { #var_1fbad0c50e0f39fa:var_1fbad0c50e0f39fa, #var_7a4474e071a50b0b:var_7a4474e071a50b0b, #has_failed:1 } );
    
    if ( var_7a4474e071a50b0b )
    {
        level waittill( #"on_round_end" );
    }
    
    var_cb7b0720edaa11a0 = var_7a4474e071a50b0b ? 2 : 5;
    wait var_cb7b0720edaa11a0;
    var_f4ee6227e4cd2e2f = var_7a4474e071a50b0b ? 3 : 1;
    var_1be5586316eb3191 = self.var_1be5586316eb3191;
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_cce5cbb8c9e0117a" : #"hash_b79f2a6fc4be996b", var_f4ee6227e4cd2e2f );
    utility::function_7c10ea82c1e305b8( "usable", "usable" );
    function_760e6888e3e99e1d( 1 );
    self.isresetting = 0;
    self.var_7a4474e071a50b0b = 0;
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x7ab28401, Offset: 0x9590
// Size: 0x49d
function private function_64e4a1681bedc6c6( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    var_1be5586316eb3191 = self.ref == #"hash_7f81077fb695e7e2" ? level.scarab_pap_quest.s_skull_1 : level.scarab_pap_quest.s_skull_2;
    var_482ec38e12e036dd = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_b1efd54170d7cdb9" : #"hash_f96e5211a125fba2" );
    
    if ( !var_482ec38e12e036dd || var_482ec38e12e036dd == 3 )
    {
        var_1be5586316eb3191.var_348491563c879773 = 3;
        level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_b1efd54170d7cdb9" : #"hash_f96e5211a125fba2", 3 );
    }
    
    var_1dcb26d0174b87c4 = self.ref == #"hash_7f81077fb695e7e2" ? #"hash_402e0d074cc6f251" : #"hash_402e0a074cc6ed38";
    prev_step = level zm_quest::get_quest_step( #"scarab_pap_quest", var_1dcb26d0174b87c4 );
    prev_step.skip_splash = 0;
    prev_step.var_94c5b7d04e0c2501 = 0;
    
    if ( level utility::flag( "open_sesame" ) )
    {
        level zm_quest::get_quest( #"scarab_pap_quest" ).skip_splash = 1;
    }
    
    if ( b_skipped || b_save_restored || level utility::flag( "open_sesame" ) )
    {
        return;
    }
    else if ( prev_step.b_skipped )
    {
        closestplayer = undefined;
        closestdistsq = undefined;
        var_c6457b9450c88863 = getplayersinradius( var_1be5586316eb3191.var_87f8c6598b0699af.origin, 1200 );
        
        foreach ( player in var_c6457b9450c88863 )
        {
            if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
            {
                continue;
            }
            
            distsq = distancesquared( var_1be5586316eb3191.var_87f8c6598b0699af.origin, player.origin );
            
            if ( !isdefined( closestdistsq ) || distsq < closestdistsq )
            {
                closestdistsq = distsq;
                closestplayer = player;
                break;
            }
        }
        
        var_1be5586316eb3191.var_87f8c6598b0699af.interact thread function_10f75cf5ef72a3fd( closestplayer );
    }
    
    var_fb30f3b84d922147 = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", var_1be5586316eb3191 == level.scarab_pap_quest.s_skull_1 ? #"hash_cce5cbb8c9e0117a" : #"hash_b79f2a6fc4be996b" );
    
    if ( var_fb30f3b84d922147 == 2 )
    {
        var_1be5586316eb3191.var_87f8c6598b0699af.var_3a45536cff3b28ac = 3;
        var_1be5586316eb3191.var_87f8c6598b0699af thread function_7f042c187671e6ab( undefined, 1, 1 );
    }
    else
    {
        var_1be5586316eb3191 function_96d06a6ebdf6d263( { #firstpickup:1 } );
    }
    
    for ( i = 0; i < level.scarab_pap_quest.var_c6b9e23aac03b4d0.size ; i++ )
    {
        var_4d376276647607c7 = level.scarab_pap_quest.var_c6b9e23aac03b4d0[ i ];
        
        if ( !var_4d376276647607c7.var_35e8c29dafef15e8 && !var_4d376276647607c7 utility::ent_flag( "is_lit" ) )
        {
            var_4d376276647607c7 thread function_8be482bb47601f45( i );
        }
    }
    
    var_1be5586316eb3191 utility::ent_flag_wait( "is_torch_delivered" );
    var_9b3cbd7a350ebacf = self.ref == #"hash_7f81077fb695e7e2" ? #"hash_94fb431c2711f3e7" : #"hash_94fb441c2711f59a";
    level zm_quest::get_quest_step( #"scarab_pap_quest", var_9b3cbd7a350ebacf ).skip_splash = 1;
    level zm_quest::get_quest_step( #"scarab_pap_quest", var_9b3cbd7a350ebacf ).var_94c5b7d04e0c2501 = 1;
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xd2c9335f, Offset: 0x9a35
// Size: 0x487
function private function_8be482bb47601f45( forge_idx )
{
    level endon( #"game_ended" );
    self.var_35e8c29dafef15e8 = 1;
    utility::function_7c10ea82c1e305b8( "health", "damage_detect" );
    var_c7e6abba90b31f67 = undefined;
    eattacker = undefined;
    
    do
    {
        self waittill( #"damage", einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, spartname );
        
        if ( isplayer( eattacker ) && einflictor.weapon_name == "t10_inc_fire_zm_scarab_torch" && einflictor.equipinfo )
        {
            var_c7e6abba90b31f67 = einflictor;
            break;
        }
    }
    while ( true );
    
    if ( isplayer( eattacker ) )
    {
        eattacker thread damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
    }
    
    function_760e6888e3e99e1d( 1 );
    var_c7e6abba90b31f67.equipinfo.b_skip_molotov = 1;
    var_c7e6abba90b31f67.equipinfo.var_5990ce3727e634d1 = self;
    var_c7e6abba90b31f67.equipinfo.var_1be5586316eb3191 utility::ent_flag_set( "is_torch_delivered" );
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", hashcat( #"hash_43da8c2d828a79d3", self.s_brazier.script_noteworthy ), 1 );
    
    if ( var_c7e6abba90b31f67.equipinfo.var_87f8c6598b0699af && var_c7e6abba90b31f67.equipinfo.var_87f8c6598b0699af utility::ent_flag( "is_lit" ) )
    {
        var_c7e6abba90b31f67.equipinfo.var_87f8c6598b0699af utility::function_7c10ea82c1e305b8( "usable", "off" );
        var_c7e6abba90b31f67.equipinfo.var_87f8c6598b0699af function_760e6888e3e99e1d( 0 );
    }
    
    if ( !isdefined( level.scarab_pap_quest.var_4223862ee4b6fa8b ) )
    {
        level.scarab_pap_quest.var_4223862ee4b6fa8b = 0;
    }
    
    level.scarab_pap_quest.var_4223862ee4b6fa8b++;
    
    if ( level.scarab_pap_quest.var_4223862ee4b6fa8b < 2 )
    {
        level.scarab_pap_quest thread function_42cdb7bef87fe61( #"hash_1f04fdccd00bc01c" );
        musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_598fa2c4e968bb5" );
    }
    else
    {
        level.scarab_pap_quest thread play_vo_banter( #"hash_452b8909c2523f20", 10, eattacker );
        musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_f54c2fa5ac3b3c63" );
        level utility::delaythread( 120, &musicbank_utility::function_4f253fd35ec68cbc, level.players, #"hash_f54c2fa5ac3b3c63" );
    }
    
    level.scarab_pap_quest.var_b3ad13b33f68da50 = arraycombineunique( level.scarab_pap_quest.var_b3ad13b33f68da50, [ level.scarab_pap_quest.s_current_skull == level.scarab_pap_quest.s_skull_1 ? #"hash_402e0d074cc6f251" : #"hash_402e0a074cc6ed38" ] );
    level.scarab_pap_quest.var_b3ad13b33f68da50 = arraycombineunique( level.scarab_pap_quest.var_b3ad13b33f68da50, [ level.scarab_pap_quest.s_current_skull == level.scarab_pap_quest.s_skull_1 ? #"hash_7f81077fb695e7e2" : #"hash_7f81067fb695e62f" ] );
    var_b457abaa9dbbda0c = level.scarab_pap_quest.s_current_skull == level.scarab_pap_quest.s_skull_1 ? level.scarab_pap_quest.s_skull_2 : level.scarab_pap_quest.s_skull_1;
    var_10b2fdfd65ac0f70 = var_b457abaa9dbbda0c.var_87f8c6598b0699af.var_7a4474e071a50b0b;
    var_b457abaa9dbbda0c function_96d06a6ebdf6d263( { #var_7a4474e071a50b0b:var_10b2fdfd65ac0f70, #has_failed:var_10b2fdfd65ac0f70, #var_ce32f3d53521f58c:1 } );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1
// Checksum 0x7bc52a10, Offset: 0x9ec4
// Size: 0xa0
function function_760e6888e3e99e1d( b_light )
{
    if ( b_light )
    {
        if ( utility::ent_flag( "is_lit" ) )
        {
            return;
        }
        
        if ( utility::ent_flag( "has_cosmic_power" ) )
        {
            self setscriptablepartstate( "fx", "cosmic_fire" );
        }
        else
        {
            utility::function_7c10ea82c1e305b8( "fx", "on" );
        }
        
        utility::ent_flag_set( "is_lit" );
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "fx", "off" );
    self.var_3dfb48cd2da760ed = 0;
    utility::ent_flag_clear( "is_lit" );
    utility::ent_flag_clear( "has_cosmic_power" );
    self notify( #"brazier_off" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xb2a58792, Offset: 0x9f6c
// Size: 0x19c
function private function_5313a9f4256e61e4( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    
    if ( level utility::flag( "open_sesame" ) )
    {
        level zm_quest::get_quest( #"scarab_pap_quest" ).skip_splash = 1;
    }
    
    if ( b_skipped || b_save_restored || level utility::flag( "open_sesame" ) )
    {
        return;
    }
    
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    level thread function_51f12524c830dd09();
    
    foreach ( var_2e2441e747b19673 in level.scarab_pap_quest.var_869784d65d81d184 )
    {
        if ( var_2e2441e747b19673 utility::ent_flag( "is_finish_rotated" ) )
        {
            continue;
        }
        
        var_2e2441e747b19673.mdl utility::function_7c10ea82c1e305b8( "usable", "usable" );
    }
    
    level zm_quest::get_quest_step( #"scarab_pap_quest", #"hash_cf9cadfb84da7b1" ).var_94c5b7d04e0c2501 = 1;
    level zm_quest::get_quest_step( #"scarab_pap_quest", #"hash_cf9c7dfb84da298" ).var_94c5b7d04e0c2501 = 1;
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x1c756868, Offset: 0xa110
// Size: 0x15c
function private function_a931d5e7295444c1( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    
    if ( level utility::flag( "open_sesame" ) )
    {
        level zm_quest::get_quest( #"scarab_pap_quest" ).skip_splash = 1;
    }
    
    var_2e2441e747b19673 = self.ref == #"hash_cf9cadfb84da7b1" ? level.scarab_pap_quest.var_869784d65d81d184[ 0 ] : level.scarab_pap_quest.var_869784d65d81d184[ 1 ];
    
    if ( b_skipped || b_save_restored || level utility::flag( "open_sesame" ) || var_2e2441e747b19673 utility::ent_flag( "is_first_rotated" ) )
    {
        if ( !b_save_restored )
        {
            var_2e2441e747b19673 utility::ent_flag_set( "is_first_rotated" );
            var_2e2441e747b19673 utility::ent_flag_set( "is_finish_rotated" );
            var_2e2441e747b19673.mdl utility::function_7c10ea82c1e305b8( "usable", "off" );
            
            if ( !var_2e2441e747b19673 utility::ent_flag( "is_first_rotated" ) )
            {
                level.scarab_pap_quest.var_c6070e16c81619f1++;
            }
        }
        
        return;
    }
    
    var_2e2441e747b19673 utility::ent_flag_wait( "is_finish_rotated" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x336f7342, Offset: 0xa274
// Size: 0x5fe
function private function_f4c63e969c1c8aab( player )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "disallow_power_surge" ) )
    {
        return;
    }
    
    var_2e2441e747b19673 = self.var_2e2441e747b19673;
    
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( player.is_rotating_crank || var_2e2441e747b19673.is_rotating_crank || player.is_animating_crank )
    {
        return;
    }
    
    if ( var_2e2441e747b19673.trigger && !ispointinvolume( player.origin, var_2e2441e747b19673.trigger, 1 ) )
    {
        return;
    }
    
    var_8984ae1d02cf303b = level.scarab_pap_quest.completed;
    usablestate = var_8984ae1d02cf303b ? "usable_surge" : "usable";
    var_2e2441e747b19673.mdl utility::function_7c10ea82c1e305b8( "usable", "off" );
    var_2e2441e747b19673 utility::ent_flag_clear( "is_finish_rotated" );
    var_2e2441e747b19673.var_234e290c63d5d935 = 0;
    
    if ( !var_8984ae1d02cf303b )
    {
        var_747a8ec67dda34ae = level.scarab_pap_quest.var_61396eee26689ea1 == var_2e2441e747b19673;
        
        if ( !isdefined( level.scarab_pap_quest.var_61396eee26689ea1 ) )
        {
            level.scarab_pap_quest.var_61396eee26689ea1 = var_2e2441e747b19673;
        }
        
        is_guidance_showing = level.scarab_pap_quest.steps[ level.scarab_pap_quest.var_7be076c9078045aa ].ref == #"rotate_cranks";
        
        if ( is_guidance_showing && level.scarab_pap_quest.var_61396eee26689ea1 == var_2e2441e747b19673 && !var_747a8ec67dda34ae )
        {
            self.var_94c5b7d04e0c2501 = 0;
            level thread function_51f12524c830dd09();
        }
    }
    
    if ( !var_8984ae1d02cf303b )
    {
        level.scarab_pap_quest thread function_42cdb7bef87fe61( #"hash_17d7b851834cc56e" );
    }
    
    thread function_e0aaddd95137dcb8( player );
    self notify( #"hash_8680d9e90ced5412" );
    var_4d47c773ffd373fe = 0.8;
    var_420dc839b081741b = var_4d47c773ffd373fe / 0.1;
    
    for ( i = 0; i < var_420dc839b081741b ; i++ )
    {
        if ( player usebuttonpressed() && player::isreallyalive( player ) && !player::isinlaststand( player ) )
        {
            var_2e2441e747b19673.var_256f95131b1f73d0 = 1;
            wait 0.1;
            continue;
        }
        
        var_2e2441e747b19673.var_256f95131b1f73d0 = 0;
        player.is_rotating_crank = 0;
        var_2e2441e747b19673.is_rotating_crank = 0;
        self notify( #"rotation released" );
        break;
    }
    
    timestamp_begin = gettime();
    result = 0;
    
    if ( var_2e2441e747b19673.var_256f95131b1f73d0 )
    {
        strdesc = var_8984ae1d02cf303b ? &"hash_2ba796d8c71426bf" : &"hash_41663929a3cf36f0";
        result = var_2e2441e747b19673 function_52e6cfe50e6862cd( strdesc, undefined, player, var_8984ae1d02cf303b );
        time_elapsed = gettime() - timestamp_begin;
        time_elapsed_sec = time_elapsed / 1000;
        old_pause_time = var_2e2441e747b19673.base.mdl.anim_pause_time;
        new_pause_time = mod( old_pause_time + 1 * time_elapsed_sec * var_2e2441e747b19673.base.mdl.anim_rate, var_2e2441e747b19673.base.mdl.anim_length );
        
        if ( new_pause_time < 0 )
        {
            new_pause_time = var_2e2441e747b19673.base.mdl.anim_length + new_pause_time;
        }
        
        var_2e2441e747b19673.base.mdl.anim_pause_time = new_pause_time;
    }
    
    var_2e2441e747b19673.mdl setscriptablepartstate( "body", "static" );
    var_2e2441e747b19673.var_256f95131b1f73d0 = 0;
    
    if ( !function_3344b28acfb69e9c() )
    {
        level.scarab_pap_quest.var_9d15330b141fe52f utility::ent_flag_clear( "is_rotating_crank_event" );
    }
    
    if ( result )
    {
        self notify( #"rotation complete" );
        var_2e2441e747b19673.base.mdl scriptmodelplayanim( var_2e2441e747b19673.ring_num == 1 ? "sat_fxanim_zm_cannon_switch_forward" : "sat_fxanim_zm_cannon_switch_forward_left", undefined, var_2e2441e747b19673.base.mdl.anim_pause_time, 0.001 );
        level.scarab_pap_quest.var_61396eee26689ea1 = undefined;
        level.scarab_pap_quest.var_c6070e16c81619f1++;
        var_2e2441e747b19673 utility::ent_flag_set( "is_first_rotated" );
        var_2e2441e747b19673 utility::ent_flag_set( "is_finish_rotated" );
        
        if ( !var_8984ae1d02cf303b )
        {
            level utility::play_sound_in_space_with_angles( "evt_forge_gear_interval_end", level.scarab_pap_quest.e_sound_tag.origin, level.scarab_pap_quest.e_sound_tag.angles, level.scarab_pap_quest.e_sound_tag );
            level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", hashcat( #"hash_79e1a644b523b61b", var_2e2441e747b19673.script_noteworthy ), 1 );
        }
        
        level.scarab_pap_quest.var_f617745c014e4efd = player;
        
        if ( player && var_8984ae1d02cf303b )
        {
            player thread set_power_surge();
        }
        
        return;
    }
    
    self notify( #"rotation released" );
    thread function_6df3c47f6abb81be( var_8984ae1d02cf303b );
    wait 1.5;
    var_2e2441e747b19673.mdl utility::function_7c10ea82c1e305b8( "usable", usablestate );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x4340fbf9, Offset: 0xa87a
// Size: 0x2d9
function private function_6df3c47f6abb81be( var_8984ae1d02cf303b )
{
    level endon( #"game_ended" );
    self endon( #"hash_8680d9e90ced5412", #"rotation complete" );
    var_2e2441e747b19673 = self.var_2e2441e747b19673;
    var_2e2441e747b19673.base.mdl scriptmodelplayanim( var_2e2441e747b19673.ring_num == 1 ? "sat_fxanim_zm_cannon_switch_forward" : "sat_fxanim_zm_cannon_switch_forward_left", undefined, var_2e2441e747b19673.base.mdl.anim_pause_time, 0.001 );
    wait 4;
    thread function_2a5442b9e089d045( undefined, var_2e2441e747b19673.base.mdl, var_2e2441e747b19673.ring_num == 1 ? "sat_fxanim_zm_cannon_switch_backward" : "sat_fxanim_zm_cannon_switch_backward_left", -1 );
    timestamp_begin = gettime();
    var_9a27ef35fa3f22ad = utility::function_6f5d2e1f1ff70482( var_2e2441e747b19673.var_83cebc8cbb76e120 ?? 0 );
    var_9eae75512754340c = var_9a27ef35fa3f22ad / 0.3;
    
    if ( var_9eae75512754340c > 0 )
    {
        var_2e2441e747b19673.var_234e290c63d5d935 = 1;
        var_2e2441e747b19673.mdl function_9d07f59a7bb06e84( var_8984ae1d02cf303b, var_9eae75512754340c, -1, 0.3 );
        var_2e2441e747b19673.var_234e290c63d5d935 = 0;
    }
    
    self notify( #"hash_7bbea7c377e6a7d8" );
    time_elapsed_sec = ( gettime() - timestamp_begin ) / 1000;
    old_pause_time = var_2e2441e747b19673.base.mdl.anim_pause_time;
    new_pause_time = old_pause_time - time_elapsed_sec * 0.08;
    var_2e2441e747b19673.base.mdl.anim_pause_time = min( var_2e2441e747b19673.base.mdl.anim_length, max( 0, new_pause_time ) );
    backward_pause_time = var_2e2441e747b19673.base.mdl.anim_length - var_2e2441e747b19673.base.mdl.anim_pause_time;
    
    if ( backward_pause_time >= var_2e2441e747b19673.base.mdl.anim_length )
    {
        backward_pause_time = var_2e2441e747b19673.base.mdl.anim_length - 0.001;
    }
    
    var_2e2441e747b19673.base.mdl scriptmodelplayanim( var_2e2441e747b19673.ring_num == 1 ? "sat_fxanim_zm_cannon_switch_backward" : "sat_fxanim_zm_cannon_switch_backward_left", undefined, backward_pause_time, 0.001 );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x72184cc3, Offset: 0xab5b
// Size: 0x85
function private function_e0aaddd95137dcb8( player )
{
    player endon( #"death_or_disconnect", #"last_stand_enter", #"enter_live_ragdoll" );
    player.is_animating_crank = 1;
    thread watchplayerdeathordisconnect( player );
    thread watchcancelinteraction( player );
    crank_anim_start( player );
    function_58d5b512c62f6d38( player );
    player notify( #"interact_finished" );
    player val::group_reset( "cranking" );
    player.is_animating_crank = 0;
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x185f696d, Offset: 0xabe8
// Size: 0xba
function private function_77ef56bb1480f769( player )
{
    player setplayerangles( player.saved_camera_angles );
    player.camera_link moveto( player.saved_camera_origin, 0.5, 0.15, 0.15 );
    player.camera_link rotateto( player.saved_camera_angles, 0.5, 0.15, 0.15 );
    wait 0.5;
    
    if ( namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player, 0, 1 ) && isdefined( player.camera_link ) )
    {
        player startcameratween( 0.5, 0 );
        player cameraunlink();
        player.camera_link delete();
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xbb9c1b70, Offset: 0xacaa
// Size: 0x3f3
function private crank_anim_start( player )
{
    player endon( #"death_or_disconnect", #"last_stand_enter", #"enter_live_ragdoll" );
    player val::group_set( "cranking", 0 );
    anglesrotated = self.original_angles + ( 0, 90, 0 );
    forward = ( 0, 0, 0 ) - anglestoforward( anglesrotated );
    up = ( 0, 0, 1 );
    var_727a3efac8519ddb = ( 0, 0, -37.25 ) + forward * -15;
    goalpos = self.origin + var_727a3efac8519ddb;
    right = vectorcross( forward, up );
    goalangles = axistoangles( forward, right, up );
    movetotime = 0.3;
    player.linktoent = player utility::spawn_tag_origin( goalpos, goalangles );
    player playerlinktoblend( player.linktoent, "tag_origin", 0.25 );
    wait movetotime;
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
    player setorigin( goalpos );
    player setplayerangles( goalangles );
    
    if ( player getcamerathirdperson() )
    {
        player.saved_camera_origin = player getcamerathirdpersonorigin();
        player.saved_camera_angles = player getplayerangles();
        var_55d2b327417bc911 = self.var_2e2441e747b19673.mdl.origin + ( 0, 0, 64 ) + anglestoleft( self.var_2e2441e747b19673.mdl.angles ) * 48;
        var_ba474bc1a76e1caa = vectortoangles( vectornormalize( self.var_2e2441e747b19673.mdl.origin - var_55d2b327417bc911 ) );
        var_55d2b327417bc911 += anglestoright( var_ba474bc1a76e1caa ) * 24;
        var_ba474bc1a76e1caa = vectortoangles( vectornormalize( self.var_2e2441e747b19673.mdl.origin - var_55d2b327417bc911 ) );
        player.camera_link = utility::spawn_model( "tag_origin", var_55d2b327417bc911, var_ba474bc1a76e1caa );
        
        /#
            player.camera_link thread utility::draw_angles( var_ba474bc1a76e1caa, var_55d2b327417bc911, ( 1, 0, 0 ), 1000, 3 );
        #/
        
        player startcameratween( 0.5, 0 );
        player cameralinkto( player.camera_link, "tag_origin", 1, 1 );
    }
    else
    {
        player.saved_camera_origin = player getorigin();
        player.saved_camera_angles = player getplayerangles();
        player.camera_link = undefined;
    }
    
    player callback::remove( #"player_laststand", &function_c45defd64abf5652 );
    player callback::add( #"player_laststand", &function_c45defd64abf5652, self );
    scene::add_scene_func( "zm_sat_scarab_crank_switch_scene", &function_84a798b6b2458582, "callback_play" );
    scene::add_scene_func( "zm_sat_scarab_crank_switch_scene", &function_84a798b6b2458582, "callback_stop" );
    self.animstruct scene::play( player, [ self.var_2e2441e747b19673.ring_num == 1 ? "forward_in" : "forward_in_left" ], "zm_sat_scarab_crank_switch_scene" );
    self.animstruct thread scene::play( player, [ self.var_2e2441e747b19673.ring_num == 1 ? "forward_loop" : "forward_loop_left" ], "zm_sat_scarab_crank_switch_scene" );
    
    if ( self.var_2e2441e747b19673.var_256f95131b1f73d0 )
    {
        utility::waittill_any( "rotation released", "rotation complete" );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xd1fbc79f, Offset: 0xb0a5
// Size: 0x8d
function private function_84a798b6b2458582()
{
    var_79a1b4c592a0d24d = scene::function_5fe163f439457bd0();
    
    foreach ( player in var_79a1b4c592a0d24d )
    {
        if ( isplayer( player ) )
        {
            player thread function_847016a69f0fe2fd();
        }
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xe830fd62, Offset: 0xb13a
// Size: 0x5f
function private function_847016a69f0fe2fd()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( level utility::flag( "its_raining" ) )
    {
        if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_bd3ce90cea3f86b5" ) )
        {
            utility::callsharedfunc( #"scarab_rain", #"hash_bd3ce90cea3f86b5" );
        }
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x61a20d59, Offset: 0xb1a1
// Size: 0x58
function private function_c45defd64abf5652( sparams, var_82e46185007c65ea )
{
    var_82e46185007c65ea.animstruct scene::stop();
    thread function_847016a69f0fe2fd();
    callback::remove( #"player_laststand", &function_c45defd64abf5652 );
    
    if ( isdefined( self.camera_link ) )
    {
        function_77ef56bb1480f769( self );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xb7c0d4ab, Offset: 0xb201
// Size: 0x88
function private watchcancelinteraction( player )
{
    player endon( #"death_or_disconnect", #"interact_interrupt" );
    waitframe();
    
    if ( !isbot( player ) )
    {
        player notifyonplayercommand( "interact_cancelled", "+weapnext" );
    }
    
    timeout = 15;
    msg = utility::waittill_any_timeout( timeout, "rotation complete", "rotation released", "interact_cancelled" );
    
    if ( !isbot( player ) )
    {
        player notifyonplayercommandremove( "interact_cancelled", "+weapnext" );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xb71013e6, Offset: 0xb291
// Size: 0xdf
function private watchplayerdeathordisconnect( player )
{
    player endon( #"interact_cancelled", #"interact_finished" );
    player utility::waittill_any( "death_or_disconnect", "enter_live_ragdoll", "last_stand_enter", "player_downed" );
    self.animstruct scene::stop();
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player thread function_847016a69f0fe2fd();
    player notify( #"interact_interrupt" );
    player stopanimscriptsceneevent();
    player stopviewmodelanim();
    
    if ( isdefined( player.linktoent ) )
    {
        player unlink();
        player.linktoent delete();
        player.linktoent = undefined;
    }
    
    if ( isdefined( player.camera_link ) )
    {
        function_77ef56bb1480f769( player );
    }
    
    player val::group_reset( "cranking" );
    player.is_animating_crank = 0;
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x39209b4d, Offset: 0xb378
// Size: 0x162
function private function_58d5b512c62f6d38( player )
{
    player endon( #"death_or_disconnect", #"last_stand_enter", #"enter_live_ragdoll", #"interact_interrupt" );
    
    if ( isalive( player ) && !player::isinlaststand( player ) )
    {
        player val::set( "crank_detach", "damage", 0 );
        self.animstruct scene::play( player, [ self.var_2e2441e747b19673.ring_num == 1 ? "forward_out" : "forward_out_left" ], "zm_sat_scarab_crank_switch_scene" );
        player thread function_847016a69f0fe2fd();
        player callback::remove( #"player_laststand", &function_c45defd64abf5652 );
        
        if ( player isviewmodelanimplaying() )
        {
            player stopanimscriptsceneevent();
            player stopviewmodelanim();
        }
        
        if ( isdefined( player.camera_link ) )
        {
            wait 0.5;
            function_77ef56bb1480f769( player );
        }
        else if ( player.saved_camera_origin && player.saved_camera_angles )
        {
            player setorigin( player.saved_camera_origin );
            player setplayerangles( player.saved_camera_angles );
        }
        
        player utility::delaythread( 1, &val::reset, "crank_detach", "damage" );
        player setstance( "stand" );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 4, eflags: 0x4
// Checksum 0xa1798b1f, Offset: 0xb4e2
// Size: 0x15b
function private function_2a5442b9e089d045( player, model, animation, direction = 1 )
{
    if ( isdefined( player ) )
    {
        player endon( #"death_or_disconnect", #"last_stand_enter", #"enter_live_ragdoll", #"interact_cancelled" );
    }
    
    self endon( #"hash_7bbea7c377e6a7d8", #"hash_8680d9e90ced5412", #"rotation released", #"rotation complete" );
    
    if ( direction == 1 )
    {
        local_pause_time = min( model.anim_length, max( 0, model.anim_pause_time ) );
        anim_rate = model.anim_rate;
        var_ee795077e5dab0f0 = model.var_ee795077e5dab0f0;
    }
    else
    {
        local_pause_time = min( model.anim_length, max( 0, model.anim_length - model.anim_pause_time ) );
        anim_rate = 0.08;
        var_ee795077e5dab0f0 = model.anim_length / 0.08;
    }
    
    while ( true )
    {
        model scriptmodelplayanim( animation, undefined, local_pause_time, anim_rate );
        time_remaining = max( 0, var_ee795077e5dab0f0 - local_pause_time / anim_rate );
        wait time_remaining;
        local_pause_time = 0;
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x2f64c88e, Offset: 0xb645
// Size: 0x1a1
function private rotate_hint_callback( interact, player )
{
    if ( level utility::flag( "disallow_power_surge" ) || player utility::ent_flag( "is_usurped_power_grabbed" ) || interact.var_2e2441e747b19673.trigger && !ispointinvolume( player.origin, interact.var_2e2441e747b19673.trigger, 1 ) )
    {
        return { #interactable:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    else if ( interact utility::function_9f2c41c1dcc8c94( "usable", "cooldown" ) )
    {
        return { #params:[ interact.cooldowntime ], #interactable:0, #string:&"hash_52b3c358fb58cc29", #type:"HINT_NOBUTTON" };
    }
    else if ( interact utility::function_9f2c41c1dcc8c94( "usable", "usable_surge" ) )
    {
        return { #string:&"hash_2ba796d8c71426bf", #type:"HINT_NOICON" };
    }
    else if ( interact utility::function_9f2c41c1dcc8c94( "usable", "usable" ) )
    {
        return { #string:&"hash_7d915e5414fbc467", #type:"HINT_NOICON" };
    }
    
    return { #interactable:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_pap_quest
// Params 0
// Checksum 0xd1027b36, Offset: 0xb7ef
// Size: 0x8e, Type: bool
function function_3344b28acfb69e9c()
{
    foreach ( var_2e2441e747b19673 in level.scarab_pap_quest.var_869784d65d81d184 )
    {
        if ( var_2e2441e747b19673.is_rotating_crank )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_pap_quest
// Params 4, eflags: 0x4
// Checksum 0xfbdbaf66, Offset: 0xb886
// Size: 0x3a2
function private function_52e6cfe50e6862cd( var_3f77d5fa92c1edbb, str_caption, player, var_8984ae1d02cf303b )
{
    var_2e2441e747b19673 = self;
    player.is_rotating_crank = 1;
    var_7baf17561b0934fe = var_2e2441e747b19673.ring_num == 1 ? level.scarab_pap_quest.var_dbdff7ad02b59f6b : level.scarab_pap_quest.var_dbdff8ad02b5a19e;
    var_7baf17561b0934fe.var_2e2441e747b19673 = var_2e2441e747b19673;
    var_2e2441e747b19673.is_rotating_crank = 1;
    waitframe();
    
    if ( !var_8984ae1d02cf303b )
    {
        if ( var_7baf17561b0934fe utility::ent_flag( "is_ring_rotating" ) )
        {
            level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent notify( #"stop_camera_shake_rumber" );
            level.scarab_pap_quest.var_9d15330b141fe52f.var_dee86a2ab4bb62b5 = 0;
            level.scarab_pap_quest.var_9d15330b141fe52f.var_1893d0bddf221db3 = undefined;
            var_7baf17561b0934fe notify( #"hash_4988b7bc41d672ad" );
            var_7baf17561b0934fe rotatevelocity( ( 0, 0, 0 ), 0.05, 0, 0 );
            wait 0.05;
            var_7baf17561b0934fe utility::ent_flag_clear( "is_ring_rotating" );
            var_7baf17561b0934fe utility::ent_flag_clear( "stop_rotating_ring_natural" );
            nearby_players = getplayersinradius( self.origin, 600 );
            
            foreach ( nearby_player in nearby_players )
            {
                if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( nearby_player ) )
                {
                    continue;
                }
                
                nearby_player playrumbleonentity( "low_highfreq" );
            }
            
            var_7baf17561b0934fe.var_5b09b54c5605be78 = undefined;
            waitframe();
        }
        
        hold_time = 5;
        end_angle_y = var_2e2441e747b19673.ring_num == 1 ? 180 : -180;
        var_7baf17561b0934fe.earthquake_scale = 0.18;
        var_7baf17561b0934fe.earthquake_radius = 1200;
        var_7baf17561b0934fe.override_rumble = "zm_scarab_forge_heavy";
        var_7baf17561b0934fe thread function_33cf59821e8c556c( ( 0, end_angle_y, 0 ), 5, 0, undefined, undefined, 1 );
    }
    else
    {
        hold_time = 3;
    }
    
    self.interact thread function_2a5442b9e089d045( player, var_2e2441e747b19673.base.mdl, var_2e2441e747b19673.ring_num == 1 ? "sat_fxanim_zm_cannon_switch_forward" : "sat_fxanim_zm_cannon_switch_forward_left" );
    var_2e2441e747b19673.target_hold_time = hold_time;
    var_2e2441e747b19673.var_234e290c63d5d935 = 1;
    var_2e2441e747b19673.mdl thread function_9d07f59a7bb06e84( var_8984ae1d02cf303b, hold_time );
    
    if ( player )
    {
        result = player function_4b07233a4390fbe4( hold_time, var_2e2441e747b19673 );
    }
    
    if ( var_8984ae1d02cf303b && player )
    {
        if ( player weapons::function_67041fa03f87323c( "power_surge" ) )
        {
            player weapons::removeextramovespeed( "power_surge" );
        }
        
        if ( player common::function_8ff835bf23198a0( "power_surge" ) )
        {
            player common::function_d85a92c557ea5a52( "power_surge" );
        }
        
        player weapons::updatemovespeedscale();
    }
    
    if ( player )
    {
        player.is_rotating_crank = 0;
    }
    
    var_2e2441e747b19673.is_rotating_crank = 0;
    var_2e2441e747b19673.var_234e290c63d5d935 = 0;
    var_7baf17561b0934fe.var_2e2441e747b19673 = undefined;
    return result;
}

// Namespace zm_sat_scarab_pap_quest
// Params 2
// Checksum 0x28b92040, Offset: 0xbc31
// Size: 0x13b
function function_4b07233a4390fbe4( hold_time, var_2e2441e747b19673 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect", #"last_stand_enter", #"hash_38101be0adc9a0bf", #"blackhole_teleporting" );
    
    if ( self.inlaststand )
    {
        return;
    }
    
    craft_fraction = 0;
    start_time = gettime();
    result = 0;
    waitframe();
    
    if ( !isdefined( var_2e2441e747b19673.var_83cebc8cbb76e120 ) )
    {
        var_2e2441e747b19673.var_83cebc8cbb76e120 = 0;
    }
    
    saved_hold_time = var_2e2441e747b19673.var_83cebc8cbb76e120;
    
    /#
        iprintlnbold( "<dev string:x24>" + utility::function_6f5d2e1f1ff70482( var_2e2441e747b19673.var_83cebc8cbb76e120 ) );
    #/
    
    while ( true )
    {
        time_elapsed = gettime() - start_time;
        var_2e2441e747b19673.var_83cebc8cbb76e120 = saved_hold_time + time_elapsed;
        
        if ( !self usebuttonpressed() || distance2d( self.origin, var_2e2441e747b19673.origin ) > 128 )
        {
            return 0;
        }
        
        craft_fraction = utility::function_6f5d2e1f1ff70482( time_elapsed + saved_hold_time ) / hold_time;
        
        if ( craft_fraction > 1 )
        {
            return 1;
        }
        
        waitframe();
    }
    
    return result;
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x2feb7159, Offset: 0xbd75
// Size: 0x2d
function private function_5f7accfcf7404be( var_2e2441e747b19673 )
{
    return utility::function_6f5d2e1f1ff70482( var_2e2441e747b19673.var_83cebc8cbb76e120 ?? 0 ) / var_2e2441e747b19673.target_hold_time;
}

// Namespace zm_sat_scarab_pap_quest
// Params 4
// Checksum 0x23cedc3, Offset: 0xbdab
// Size: 0x3ea
function function_9d07f59a7bb06e84( var_8984ae1d02cf303b, total_time, direction = 1, slowdown = 1 )
{
    var_9a27ef35fa3f22ad = utility::function_6f5d2e1f1ff70482( self.var_2e2441e747b19673.var_83cebc8cbb76e120 ?? 0 );
    var_62a44dd66a6ff3ff = self.var_2e2441e747b19673.ring_num == 1 ? level.scarab_pap_quest.var_dbdff7ad02b59f6b : level.scarab_pap_quest.var_dbdff8ad02b5a19e;
    level.scarab_pap_quest.e_sound_tag unlink();
    level.scarab_pap_quest.e_sound_tag linkto( var_62a44dd66a6ff3ff );
    
    if ( direction == -1 )
    {
        var_d49865256502c0c9 = var_9a27ef35fa3f22ad / total_time * 0.1;
        
        if ( !var_8984ae1d02cf303b )
        {
            progress_perc = function_5f7accfcf7404be( self.var_2e2441e747b19673 );
            reset_angle_y = ( self.var_2e2441e747b19673.ring_num == 1 ? -180 : 180 ) * progress_perc;
            var_62a44dd66a6ff3ff thread function_33cf59821e8c556c( ( 0, reset_angle_y, 0 ), total_time, 0, 0, 0, 1 );
        }
    }
    
    self.var_2e2441e747b19673.mdl utility::function_32b24db3127bff40( "body", "turning" );
    starttime = gettime();
    
    if ( !var_8984ae1d02cf303b )
    {
        thread function_c4ebc69796fbf643();
    }
    
    while ( !utility::time_has_passed( starttime, total_time ) )
    {
        if ( var_8984ae1d02cf303b )
        {
            if ( !self.var_2e2441e747b19673.var_234e290c63d5d935 )
            {
                /#
                    iprintlnbold( "<dev string:x3c>" );
                #/
                
                break;
            }
        }
        else if ( !var_62a44dd66a6ff3ff utility::ent_flag( "is_ring_rotating" ) )
        {
            /#
                iprintlnbold( "<dev string:x75>" );
            #/
            
            break;
        }
        
        angle_step = 1440 / total_time / 0.1 * slowdown;
        crank_direction = slowdown == 1 ? -1 : direction * -1;
        self rotateby( ( crank_direction * angle_step, 0, 0 ), 0.1 );
        var_9a27ef35fa3f22ad = utility::function_6f5d2e1f1ff70482( self.var_2e2441e747b19673.var_83cebc8cbb76e120 ?? 0 );
        
        if ( direction == -1 )
        {
            var_7f18302397fa6d96 = max( 0, var_9a27ef35fa3f22ad - var_d49865256502c0c9 );
            self.var_2e2441e747b19673.var_83cebc8cbb76e120 = utility::function_4b74c15943231980( var_7f18302397fa6d96 );
        }
        
        is_guidance_showing = level.scarab_pap_quest.steps[ level.scarab_pap_quest.var_7be076c9078045aa ].ref == #"rotate_cranks" && level.scarab_pap_quest.var_61396eee26689ea1 == self.var_2e2441e747b19673;
        
        if ( is_guidance_showing && self.var_2e2441e747b19673.target_hold_time )
        {
            var_c6d68ade6259ef97 = self.var_2e2441e747b19673 == level.scarab_pap_quest.var_869784d65d81d184[ 0 ] ? #"hash_cf9cadfb84da7b1" : #"hash_cf9c7dfb84da298";
            progress = min( 100, function_5f7accfcf7404be( self.var_2e2441e747b19673 ) * 100 );
            
            if ( progress >= 0 && self.var_2e2441e747b19673 utility::ent_flag( "guidance_active" ) )
            {
                level thread zm_quest::function_9f49b2a045ece8ae( progress, 1, #"scarab_pap_quest", var_c6d68ade6259ef97 );
            }
        }
        
        wait 0.1;
    }
    
    self.var_2e2441e747b19673.mdl utility::function_32b24db3127bff40( "body", "static" );
    self notify( #"hash_65d378ab57a6c2df" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xbea46b39, Offset: 0xc19d
// Size: 0x225
function private function_c4ebc69796fbf643()
{
    self endon( #"hash_65d378ab57a6c2df" );
    self.var_2e2441e747b19673.interact endon( #"hash_8680d9e90ced5412", #"rotation complete" );
    level.scarab_pap_quest.e_sound_tag utility::ent_flag_clear( "is_crank_start_sound_played" );
    
    while ( true )
    {
        var_9e76f46f7540b82b = min( 100, function_5f7accfcf7404be( self.var_2e2441e747b19673 ) * 100 );
        var_9e76f46f7540b82b = int( var_9e76f46f7540b82b );
        var_ea869665e46948fd = level.scarab_pap_quest.e_sound_tag utility::ent_flag( "is_crank_start_sound_played" );
        
        if ( !var_ea869665e46948fd )
        {
            /#
                iprintlnbold( "<dev string:xaf>" + var_9e76f46f7540b82b );
            #/
            
            if ( var_9e76f46f7540b82b < 1 )
            {
                level.scarab_pap_quest.e_sound_tag utility::ent_flag_set( "is_crank_start_sound_played" );
                level thread utility::play_sound_in_space_with_angles( "evt_forge_gear_interval_start", level.scarab_pap_quest.e_sound_tag.origin, level.scarab_pap_quest.e_sound_tag.angles, level.scarab_pap_quest.e_sound_tag );
                level.scarab_pap_quest.e_sound_tag utility::delaythread( 0.75, &utility::ent_flag_clear, "is_crank_start_sound_played" );
            }
            else if ( var_9e76f46f7540b82b % 20 == 0 )
            {
                level.scarab_pap_quest.e_sound_tag utility::ent_flag_set( "is_crank_start_sound_played" );
                level thread utility::play_sound_in_space_with_angles( "evt_forge_gear_interval", level.scarab_pap_quest.e_sound_tag.origin, level.scarab_pap_quest.e_sound_tag.angles, level.scarab_pap_quest.e_sound_tag );
                level.scarab_pap_quest.e_sound_tag utility::delaythread( 0.12, &utility::ent_flag_clear, "is_crank_start_sound_played" );
            }
        }
        
        wait 0.05;
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xac8f9469, Offset: 0xc3ca
// Size: 0x130
function private function_ae4797aa4b15f5b8( b_skipped, b_save_restored )
{
    var_2e2441e747b19673 = self.ref == #"hash_cf9cadfb84da7b1" ? level.scarab_pap_quest.var_869784d65d81d184[ 0 ] : level.scarab_pap_quest.var_869784d65d81d184[ 1 ];
    
    if ( b_skipped || b_save_restored || level utility::flag( "open_sesame" ) )
    {
        if ( !b_save_restored && !var_2e2441e747b19673 utility::ent_flag( "is_first_rotated" ) )
        {
            level.scarab_pap_quest.var_c6070e16c81619f1++;
            var_2e2441e747b19673 utility::delaythread( 0.1, &utility::ent_flag_set, "is_first_rotated" );
        }
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", hashcat( #"hash_79e1a644b523b61b", var_2e2441e747b19673.script_noteworthy ), 1 );
    level.scarab_pap_quest.var_b3ad13b33f68da50 = arraycombineunique( level.scarab_pap_quest.var_b3ad13b33f68da50, [ self.ref ] );
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x1df41dda, Offset: 0xc502
// Size: 0x905
function private function_ecb043d3a7a40b55( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    is_skipped = b_skipped || b_save_restored || level utility::flag( "open_sesame" );
    
    if ( is_skipped )
    {
        level utility::array_ent_flag_wait( level.scarab_pap_quest.var_869784d65d81d184, "is_first_rotated" );
        level zm_round_spawning::pause_round_spawning( 1, "scarab_pap_quest_complete" );
        level thread function_92c8f38b26454764( 1 );
    }
    else
    {
        level zm_round_spawning::pause_round_spawning( 1, "scarab_pap_quest_complete" );
        level thread function_92c8f38b26454764();
    }
    
    level.var_c57f2e874f4ba092 setscriptablepartstate( "drone_audio", "on" );
    
    foreach ( var_7baf17561b0934fe in [ level.scarab_pap_quest.var_dbdff7ad02b59f6b, level.scarab_pap_quest.var_dbdff8ad02b5a19e ] )
    {
        var_7baf17561b0934fe.lowerzoffset = -289;
        end_angle_y = int( var_7baf17561b0934fe.script_noteworthy ) == 1 ? 60 : -60;
        var_7baf17561b0934fe thread function_33cf59821e8c556c( ( 0, end_angle_y, 0 ), 0.1, 0, 0, 0, 1 );
        wait 0.1;
    }
    
    if ( !isdefined( level.scarab_pap_quest.var_f617745c014e4efd ) )
    {
        level.scarab_pap_quest.var_f617745c014e4efd = level.players[ 0 ];
    }
    
    level function_45b00b1b3a595819();
    
    if ( level.scarab_pap_quest.var_4879f13476e06b5a )
    {
        level.scarab_pap_quest.var_4879f13476e06b5a delete();
    }
    
    level.scarab_pap_quest.var_36689e18b47d20cd.origin += ( 0, 0, 275 );
    
    if ( level.scarab_pap_quest.var_36689e18b47d20cd.var_9922b410586809d5 )
    {
        destroynavobstacle( level.scarab_pap_quest.var_36689e18b47d20cd.var_9922b410586809d5 );
    }
    
    level.scarab_pap_quest.var_36689e18b47d20cd.var_9922b410586809d5 = createnavbadplacebyent( level.scarab_pap_quest.var_36689e18b47d20cd );
    
    foreach ( var_1c998cfdc83d8cfd in level.scarab_pap_quest.var_f94fc2341de8afbe )
    {
        function_30dc1efdafe7681e( var_1c998cfdc83d8cfd, 1 );
    }
    
    foreach ( dynamic_traversal_top_node in level.scarab_pap_quest.var_809f73b42a6602e0 )
    {
        destroynavlink( dynamic_traversal_top_node );
    }
    
    foreach ( var_cee8788f6ff31df4 in [ #"rotate_cranks", #"hash_cf9cadfb84da7b1", #"hash_cf9c7dfb84da298" ] )
    {
        level utility::delaythread( 2.5, &zm_quest::function_fb3af5600f6a9441, 0, 1, #"scarab_pap_quest", var_cee8788f6ff31df4 );
        level utility::delaythread( 2.5, &zm_quest::function_fba942a1cfd85f5d, 0, 1, #"scarab_pap_quest", var_cee8788f6ff31df4 );
    }
    
    var_7fe2b7b59f1603f5 = [ level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent, level.scarab_pap_quest.var_9d15330b141fe52f.clip, level.scarab_pap_quest.var_405ba86a0a3065d9.clip, level.scarab_pap_quest.var_dbdff7ad02b59f6b, level.scarab_pap_quest.var_dbdff8ad02b5a19e, level.scarab_pap_quest.var_bc83b6a5157bf046, level.scarab_pap_quest.var_adf372aea1405d38, level.scarab_pap_quest.var_387620b5f8c8e07 ];
    
    foreach ( var_2e2441e747b19673 in level.scarab_pap_quest.var_869784d65d81d184 )
    {
        var_7fe2b7b59f1603f5[ var_7fe2b7b59f1603f5.size ] = var_2e2441e747b19673.mdl;
        var_7fe2b7b59f1603f5[ var_7fe2b7b59f1603f5.size ] = var_2e2441e747b19673.base.mdl;
    }
    
    foreach ( var_4d376276647607c7 in level.scarab_pap_quest.var_c6b9e23aac03b4d0 )
    {
        var_4d376276647607c7.e_mover = utility::spawn_model( "tag_origin", var_4d376276647607c7.origin, var_4d376276647607c7.angles );
        var_4d376276647607c7.e_mover.lowerzoffset = -127;
        var_4d376276647607c7 utility::scriptable_setparententity( var_4d376276647607c7.e_mover );
        var_7fe2b7b59f1603f5[ var_7fe2b7b59f1603f5.size ] = var_4d376276647607c7.e_mover;
        var_4d376276647607c7 function_760e6888e3e99e1d( 0 );
        var_4d376276647607c7 utility::function_7c10ea82c1e305b8( "collision", "off" );
    }
    
    level.scarab_pap_quest.var_405ba86a0a3065d9 utility::function_7c10ea82c1e305b8( "collision", "off" );
    currentround = zm_round_logic::get_rb_round_number();
    
    if ( level.var_a009ab14ee0d3223.specialroundspawns[ currentround + 1 ] )
    {
        level zm_round_spawning::function_9fd9e12523021d1d( currentround + 1, currentround + 2 );
    }
    
    foreach ( var_e452975569fc645a in var_7fe2b7b59f1603f5 )
    {
        if ( !var_e452975569fc645a.targetname )
        {
            continue;
        }
        
        if ( !isdefined( var_336aeb5d5caeec58 ) )
        {
            var_336aeb5d5caeec58 = [];
        }
        
        var_336aeb5d5caeec58[ var_336aeb5d5caeec58.size ] = var_e452975569fc645a.targetname + "_lowered";
    }
    
    foreach ( player in level.players )
    {
        player utility::player_prestream_assets( "scarab_forge", "model", [ "sat_zm_circular_stair_platform_static" ], [ 2000 ], 30 );
    }
    
    level thread function_1ef8ee0706921d17( var_7fe2b7b59f1603f5, is_skipped );
    level thread function_90b87f94d3bad632( var_336aeb5d5caeec58, is_skipped, b_save_restored );
    musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_a94d38e07fadbac" );
    level zm_quest::get_quest_step( #"scarab_pap_quest", #"complete" ).var_94c5b7d04e0c2501 = 1;
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x5f39701b, Offset: 0xce0f
// Size: 0x388
function private function_1ef8ee0706921d17( var_7fe2b7b59f1603f5, is_skipped )
{
    level.scarab_pap_quest.var_405ba86a0a3065d9 utility::ent_flag_set( "is_in_lowering_sequence" );
    level utility::flag_set( "has_forge_lowering_sequence_started" );
    delay = is_skipped ? 0.05 : 3;
    fxdelay = is_skipped ? 0.05 : 6;
    
    if ( level.scarab_pap_quest.var_dbdff7ad02b59f6b && level.scarab_pap_quest.var_dbdff8ad02b5a19e )
    {
        level.scarab_pap_quest.var_dbdff7ad02b59f6b utility::delaythread( delay, &utility::function_7c10ea82c1e305b8, "glow", "on" );
        level.scarab_pap_quest.var_dbdff7ad02b59f6b utility::delaythread( fxdelay, &utility::function_7c10ea82c1e305b8, "ambient_fx", "ring1_on" );
        level.scarab_pap_quest.var_dbdff8ad02b5a19e utility::delaythread( delay, &utility::function_7c10ea82c1e305b8, "glow", "on" );
        level.scarab_pap_quest.var_dbdff8ad02b5a19e utility::delaythread( fxdelay, &utility::function_7c10ea82c1e305b8, "ambient_fx", "ring2_on" );
        level.scarab_pap_quest.var_adf372aea1405d38 utility::delaythread( delay, &utility::function_7c10ea82c1e305b8, "glow", "on" );
        level.scarab_pap_quest.var_dbdff7ad02b59f6b utility::ent_flag_waitopen_any( "is_ring_rotating" );
        level.scarab_pap_quest.var_dbdff8ad02b5a19e utility::ent_flag_waitopen_any( "is_ring_rotating" );
        waitframe();
        var_1893d0bddf221db3 = { #override_rumble:"zm_scarab_forge_light", #earthquake_radius:1200, #earthquake_scale:0.18 };
        level function_45d093f55c15da8c( undefined, 10, 1, 6, 3, var_1893d0bddf221db3 );
    }
    
    level thread function_e2a8e83afdcdaaa2( is_skipped );
    
    foreach ( var_e452975569fc645a in var_7fe2b7b59f1603f5 )
    {
        zoffset = var_e452975569fc645a.lowerzoffset ?? -276;
        var_e452975569fc645a thread function_12944abf5a167a56( 10, var_e452975569fc645a.origin + ( 0, 0, zoffset ), is_skipped );
    }
    
    if ( !level.scarab_pap_quest.var_405ba86a0a3065d9 )
    {
        return;
    }
    
    if ( is_skipped )
    {
        level.scarab_pap_quest.var_405ba86a0a3065d9 utility::function_7c10ea82c1e305b8( "anim", "lowering_instant" );
        level.scarab_pap_quest.var_405ba86a0a3065d9 utility::delaythread( 1, &utility::function_7c10ea82c1e305b8, "tags", "hide" );
    }
    else
    {
        level.scarab_pap_quest.var_405ba86a0a3065d9 utility::delaythread( 10, &utility::function_7c10ea82c1e305b8, "anim", "lowering" );
        level.scarab_pap_quest.var_405ba86a0a3065d9 utility::delaythread( 25.5, &utility::function_7c10ea82c1e305b8, "tags", "hide" );
    }
    
    level.var_c57f2e874f4ba092 setscriptablepartstate( "forge_lowered", "on" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x6dba990d, Offset: 0xd19f
// Size: 0xbd
function private function_e2a8e83afdcdaaa2( b_skipped )
{
    if ( b_skipped )
    {
        activateworldevent( "we_lgt_gimbals_slow" );
        return;
    }
    
    level utility::noself_delaycall( 6, &activateworldevent, "we_lgt_gimbals_ext_3" );
    light_intervals = 5.16667;
    level utility::noself_delaycall( light_intervals * 1, &deactivateworldevent, "we_lgt_gimbals_ext_3" );
    level utility::noself_delaycall( light_intervals * 1, &activateworldevent, "we_lgt_gimbals_ext_2" );
    level utility::noself_delaycall( light_intervals * 2, &deactivateworldevent, "we_lgt_gimbals_ext_2" );
    level utility::noself_delaycall( light_intervals * 2, &activateworldevent, "we_lgt_gimbals_ext_1" );
    level utility::noself_delaycall( light_intervals * 3, &deactivateworldevent, "we_lgt_gimbals_ext_1" );
    level utility::noself_delaycall( light_intervals * 3, &activateworldevent, "we_lgt_gimbals_slow" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 3, eflags: 0x4
// Checksum 0x70345dd6, Offset: 0xd264
// Size: 0x20e
function private function_12944abf5a167a56( delay, endpos, b_skipped )
{
    self endon( #"death" );
    
    if ( self == level.scarab_pap_quest.var_dbdff7ad02b59f6b || self == level.scarab_pap_quest.var_dbdff8ad02b5a19e )
    {
        self notsolid();
    }
    
    if ( !b_skipped )
    {
        if ( !self.var_c10884d905539b5a && ( self == level.scarab_pap_quest.var_dbdff7ad02b59f6b || self == level.scarab_pap_quest.var_dbdff8ad02b5a19e ) )
        {
            self.var_c10884d905539b5a = 1;
            self.earthquake_scale = 0.25;
            self.earthquake_radius = 1200;
            self.override_rumble = "zm_scarab_forge_heavy";
        }
        
        wait delay;
        var_e16f272d8e313f8a = endpos - self.origin;
        var_bdc72945c435c1a2 = gettime();
        moveintervaltime = 0.1;
        
        do
        {
            velocity = gettime() - var_bdc72945c435c1a2 < 7500 ? 22.7 : 28;
            
            /#
                iprintlnbold( velocity );
            #/
            
            iterationmovedistance = velocity * moveintervaltime;
            var_269dc941204467cc = iterationmovedistance * ( 0, 0, -1 );
            movetopoint = self.origin + var_269dc941204467cc;
            self moveto( movetopoint, moveintervaltime );
            wait moveintervaltime;
            var_1f4c5666d756234c = endpos - self.origin;
            currentdot = vectordot( var_e16f272d8e313f8a, var_1f4c5666d756234c );
            
            if ( currentdot < 0 )
            {
                break;
            }
        }
        while ( true );
    }
    else
    {
        self.origin = endpos;
    }
    
    if ( self == level.scarab_pap_quest.var_bc83b6a5157bf046 )
    {
        self dontinterpolate();
    }
    
    if ( self.targetname )
    {
        level utility::flag_set( self.targetname + "_lowered" );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x5267d4ab, Offset: 0xd47a
// Size: 0x202
function private function_92c8f38b26454764( var_41ebd3ce0b2f6629 )
{
    if ( !var_41ebd3ce0b2f6629 )
    {
        playsoundatpos( level.var_c57f2e874f4ba092.origin, #"hash_aeb2a6c63d3fd322" );
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player thread zm_utility::white_screen_flash( 1.5, 0.3, undefined, 0.5, 1 );
            }
        }
        
        wait 0.5;
    }
    
    zombies = zm_utility::get_active_zombies();
    zombies = utility::array_removedead_or_dying( zombies );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie.marked_for_death )
        {
            continue;
        }
        
        if ( zombie.magic_bullet_shield || zombie.damageshield )
        {
            if ( !zombie val::get( "damageshield_allow_delete" ) )
            {
                continue;
            }
            
            zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        }
        
        zombie.nocorpse = 1;
        zombie.no_powerups = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie.nogib = 1;
        zombie zm_cleanup_manager::function_dd62e2042418b7e5();
        zombie kill();
    }
    
    removeallcorpses();
}

// Namespace zm_sat_scarab_pap_quest
// Params 3, eflags: 0x4
// Checksum 0xfab3f919, Offset: 0xd684
// Size: 0xa23
function private function_90b87f94d3bad632( var_336aeb5d5caeec58, b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level thread zm_quest::update_round_cap( 7 );
    level utility::flag_wait_all_array( var_336aeb5d5caeec58 );
    level notify( #"hash_2d5a983efeb04648" );
    level.scarab_pap_quest.var_405ba86a0a3065d9 utility::ent_flag_clear( "is_in_lowering_sequence" );
    level zm_round_spawning::pause_round_spawning( 0, "scarab_pap_quest_complete" );
    level utility::flag_set( "power_on" );
    level val::set( "task_scarab_pap", "task_logic_activate" );
    level thread function_3dcd857bd322e457( 0, ( 0, 0, 0 ), 1 );
    
    if ( level.scarab_pap_quest.var_405ba86a0a3065d9 )
    {
        level.scarab_pap_quest.var_405ba86a0a3065d9.clip delete();
    }
    
    level.scarab_pap_quest.var_9d15330b141fe52f.interact utility::function_7c10ea82c1e305b8( "usable", "usable" );
    a_arch_mayhem = getentitylessscriptablearray( "forge_arch_mayhem", #script_noteworthy ) ?? [];
    
    foreach ( scriptable in a_arch_mayhem )
    {
        if ( scriptable utility::function_9f2c41c1dcc8c94( "base", "explode" ) || scriptable utility::function_9f2c41c1dcc8c94( "base", "remove" ) || scriptable utility::function_9f2c41c1dcc8c94( "base", "hide" ) )
        {
            continue;
        }
        
        scriptable utility::function_7c10ea82c1e305b8( "glow", "on" );
    }
    
    foreach ( var_3786a83c4cf463f1 in level.scarab_pap_quest.var_a7b66b69733c6d12 )
    {
        var_3786a83c4cf463f1 utility::function_7c10ea82c1e305b8( "glow", "on" );
    }
    
    foreach ( var_4d376276647607c7 in level.scarab_pap_quest.var_c6b9e23aac03b4d0 )
    {
        var_4d376276647607c7 utility::function_7c10ea82c1e305b8( "collision", "on" );
    }
    
    level thread function_b23f9e865af725e9( b_skipped );
    level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent notify( #"stop_camera_shake_rumber" );
    level.scarab_pap_quest.var_9d15330b141fe52f.var_dee86a2ab4bb62b5 = 0;
    level.scarab_pap_quest.var_9d15330b141fe52f.var_1893d0bddf221db3 = undefined;
    
    if ( level.scarab_pap_quest.var_2a4fab2f4ebf62f6 )
    {
        stopfxontag( utility::getfx( "pap_fx" ), level.scarab_pap_quest.var_2a4fab2f4ebf62f6.tag, "tag_origin" );
        playfxontag( utility::getfx( "pap_fx_end" ), level.scarab_pap_quest.var_2a4fab2f4ebf62f6.tag, "tag_origin" );
    }
    
    if ( !b_skipped )
    {
        earthquake( 0.3, 1, level.scarab_pap_quest.var_9d15330b141fe52f.origin, 1200 );
        players = getplayersinradius( level.scarab_pap_quest.var_9d15330b141fe52f.origin, 1000 );
        
        foreach ( player in players )
        {
            if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
            {
                continue;
            }
            
            player playrumbleonentity( "damage_heavy" );
        }
    }
    
    level.scarab_pap_quest.var_cdb6b8216216dafd connectpaths();
    level.scarab_pap_quest.var_cdb6b8216216dafd notsolid();
    
    if ( level.scarab_pap_quest.var_cdb6b8216216dafd.var_7e43d93181543ab3 )
    {
        level.scarab_pap_quest.var_cdb6b8216216dafd.var_7e43d93181543ab3 disconnectpaths();
    }
    
    wait 1;
    
    foreach ( var_4d376276647607c7 in level.scarab_pap_quest.var_c6b9e23aac03b4d0 )
    {
        if ( var_4d376276647607c7.e_mover )
        {
            var_4d376276647607c7 utility::scriptable_clearparententity();
            var_4d376276647607c7.e_mover delete();
        }
        
        if ( !b_save_restored )
        {
            continue;
        }
        
        savekey = hashcat( #"hash_d093261ec76a4ecb", var_4d376276647607c7.s_brazier.script_noteworthy );
        saved_is_lit = level zm_quest::function_73720cdf21c3cfd7( #"scarab_phone_quest", savekey );
        
        if ( !isdefined( saved_is_lit ) )
        {
            continue;
        }
        
        if ( saved_is_lit >= 2 )
        {
            var_4d376276647607c7 utility::ent_flag_set( "has_cosmic_power" );
        }
        
        var_4d376276647607c7.var_3dfb48cd2da760ed = 1;
        var_4d376276647607c7.dontreset = 1;
        var_4d376276647607c7 utility::function_7c10ea82c1e305b8( "usable", "usable" );
        var_4d376276647607c7 function_760e6888e3e99e1d( 1 );
    }
    
    level callback::add( "on_pap_machine_purchase", &set_power_surge, { #frompap:1 } );
    
    foreach ( var_2e2441e747b19673 in level.scarab_pap_quest.var_869784d65d81d184 )
    {
        var_2e2441e747b19673.interact.animstruct.origin += ( 0, 0, var_2e2441e747b19673.mdl.lowerzoffset );
        var_2e2441e747b19673.trigger.origin += ( 0, 0, var_2e2441e747b19673.mdl.lowerzoffset );
        delay = b_skipped ? 0 : 90;
        var_2e2441e747b19673.mdl notify( #"dont_set_usable" );
        var_2e2441e747b19673.var_83cebc8cbb76e120 = 0;
        
        if ( b_skipped )
        {
            var_2e2441e747b19673.mdl utility::function_7c10ea82c1e305b8( "usable", "usable_surge" );
        }
        else
        {
            var_2e2441e747b19673 thread function_4c29d31c0e1122a4();
        }
        
        var_2e2441e747b19673 utility::ent_flag_clear( "is_finish_rotated" );
    }
    
    if ( level.scarab_pap_quest.var_dbdff7ad02b59f6b && level.scarab_pap_quest.var_dbdff8ad02b5a19e )
    {
        level.scarab_pap_quest.var_dbdff7ad02b59f6b utility::ent_flag_waitopen_any( "is_ring_rotating" );
        level.scarab_pap_quest.var_dbdff8ad02b5a19e utility::ent_flag_waitopen_any( "is_ring_rotating" );
        waitframe();
        level.scarab_pap_quest.var_dbdff7ad02b59f6b.v_home = level.scarab_pap_quest.var_dbdff7ad02b59f6b.origin;
        level.scarab_pap_quest.var_dbdff8ad02b5a19e.v_home = level.scarab_pap_quest.var_dbdff8ad02b5a19e.origin;
        level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent notify( #"stop_camera_shake_rumber" );
        level.scarab_pap_quest.var_9d15330b141fe52f.var_dee86a2ab4bb62b5 = 0;
        level.scarab_pap_quest.var_9d15330b141fe52f.var_1893d0bddf221db3 = undefined;
        rotatetodefaultstarttime = b_skipped ? 0.15 : undefined;
        level.var_c57f2e874f4ba092 setscriptablepartstate( "ring_audio", "on" );
        level.scarab_pap_quest.var_dbdff7ad02b59f6b thread function_33cf59821e8c556c( ( 0, 0, 360 ), 12, 1, undefined, 2, undefined, 1, rotatetodefaultstarttime );
        level.scarab_pap_quest.var_dbdff8ad02b5a19e thread function_33cf59821e8c556c( ( 0, 0, 360 ), 6, 1, undefined, 2, undefined, 1, rotatetodefaultstarttime );
    }
    
    activateworldevent( "we_vfx_zm_sat_scarab_forege_lava_1" );
    level utility::flag_set( "papq_final_state_set" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xe4ea2ee8, Offset: 0xe0af
// Size: 0x172
function private function_b23f9e865af725e9( b_skipped )
{
    level.scarab_pap_quest.var_387620b5f8c8e07 utility::function_7c10ea82c1e305b8( "fade_out", "on" );
    level.scarab_pap_quest.var_9d15330b141fe52f.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "fx_ambient", "on_first_time" );
    playsoundatpos( level.scarab_pap_quest.var_387620b5f8c8e07.origin, #"hash_266cdc9d714deedf" );
    wait 2;
    
    if ( level.scarab_pap_quest.var_387620b5f8c8e07 )
    {
        level.scarab_pap_quest.var_387620b5f8c8e07 delete();
    }
    
    if ( b_skipped )
    {
        return;
    }
    
    level.scarab_pap_quest thread function_3fd8acb758c48db6();
    wait 2;
    
    if ( isalive( level.scarab_pap_quest.var_f617745c014e4efd ) )
    {
        var_2cf7c60d344a2c2 = level.scarab_pap_quest.var_f617745c014e4efd;
        var_5ea5579f09400c6c = var_2cf7c60d344a2c2 calloutmarkerping::function_920a63c06abdefe8( level.scarab_pap_quest.var_9d15330b141fe52f.var_370acb837a3a86c3.index );
        level.scarab_pap_quest.var_9d15330b141fe52f.var_370acb837a3a86c3 utility::delaythread( 12, &calloutmarkerping::function_608710c894185549, var_2cf7c60d344a2c2 );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xfebf9c0, Offset: 0xe229
// Size: 0x3a
function private quest_complete_setup( b_skipped, b_save_restored )
{
    level zm_quest::get_quest_step( #"scarab_pap_quest", #"complete" ).var_94c5b7d04e0c2501 = 0;
}

// Namespace zm_sat_scarab_pap_quest
// Params 2
// Checksum 0x9e337f84, Offset: 0xe26b
// Size: 0x814
function set_power_surge( var_691cf213909b0526, var_650afee77554228c )
{
    level utility::flag_waitopen_all_array( [ "disallow_power_surge", "gimbals_are_moving" ] );
    
    if ( level utility::flag( "power_surge_active" ) )
    {
        return;
    }
    
    level utility::flag_set( "power_surge_active" );
    level.var_c57f2e874f4ba092 setscriptablepartstate( "power_surge", "enabled" );
    var_af0d2a90c128693d = level.scarab_pap_quest.var_869784d65d81d184[ 0 ].mdl utility::function_9f2c41c1dcc8c94( "usable", "usable_surge" );
    var_495d032fc228b833 = level.scarab_pap_quest.var_b335801a86aa60af ? gettime() - level.scarab_pap_quest.var_b335801a86aa60af : undefined;
    var_495d032fc228b833 = var_495d032fc228b833 ? utility::function_6f5d2e1f1ff70482( var_495d032fc228b833 ) : undefined;
    
    if ( !var_af0d2a90c128693d && var_495d032fc228b833 < 90 )
    {
        var_1c8134374a4e7c40 = max( 0, 90 - var_495d032fc228b833 );
        var_af0d2a90c128693d = var_1c8134374a4e7c40 <= 10;
        level.scarab_pap_quest.var_b335801a86aa60af = undefined;
    }
    
    foreach ( var_2e2441e747b19673 in level.scarab_pap_quest.var_869784d65d81d184 )
    {
        var_2e2441e747b19673.mdl utility::function_7c10ea82c1e305b8( "usable", "off" );
        
        if ( var_af0d2a90c128693d )
        {
            var_2e2441e747b19673.mdl notify( #"dont_set_usable" );
        }
        
        var_2e2441e747b19673.var_83cebc8cbb76e120 = 0;
    }
    
    var_7310ab5ed2bc2339 = [ level.scarab_pap_quest.var_dbdff7ad02b59f6b, level.scarab_pap_quest.var_dbdff8ad02b5a19e ];
    
    if ( level utility::flag( "gimbals_are_up" ) )
    {
        foreach ( var_6b188b2a9854e5d8 in var_7310ab5ed2bc2339 )
        {
            var_6b188b2a9854e5d8 thread function_92773fb518bb06ad( 0.5 );
        }
        
        level utility::array_wait( var_7310ab5ed2bc2339, "rotateToDefaultStart_complete" );
    }
    
    foreach ( var_6b188b2a9854e5d8 in var_7310ab5ed2bc2339 )
    {
        var_3c9d7fe0d5ce8228 = var_650afee77554228c.end_angles ?? ( 0, 0, 1800 );
        var_2b3c387f3209217b = var_650afee77554228c.var_2b3c387f3209217b ?? 10;
        var_6b188b2a9854e5d8.var_3dfb48cd2da760ed = 1;
        var_6b188b2a9854e5d8.var_2bda94460d5b5cae = self;
        var_1893d0bddf221db3 = { #override_rumble:"zm_scarab_forge_heavy", #earthquake_radius:1200, #earthquake_scale:0.15 };
        var_6b188b2a9854e5d8 set_ring_rotation_speed( var_3c9d7fe0d5ce8228, var_2b3c387f3209217b, 2, 1, undefined, var_1893d0bddf221db3 );
    }
    
    if ( level utility::flag( "astral_mote_in_forge_area" ) )
    {
        level utility::flag_clear( "astral_mote_in_forge_area" );
        level astral_motes::function_9061591a110584b5();
        level utility::waittill_notify_or_timeout( "motes_in_forge_charged_braziers", 5 );
        level utility::flag_clear( "overcharge_motes_active" );
        
        foreach ( brazier in level.scarab_pap_quest.var_c6b9e23aac03b4d0 )
        {
            brazier.var_3dfb48cd2da760ed = 1;
            brazier utility::function_7c10ea82c1e305b8( "usable", "usable" );
            brazier.dontreset = 1;
            brazier utility::ent_flag_set( "has_cosmic_power" );
            
            if ( !brazier utility::ent_flag( "is_lit" ) )
            {
                brazier function_760e6888e3e99e1d( 1 );
            }
            else
            {
                brazier setscriptablepartstate( "fx", "cosmic_fire" );
            }
            
            level zm_quest::function_4eefe6de31f5ddab( #"scarab_phone_quest", hashcat( #"hash_d093261ec76a4ecb", brazier.s_brazier.script_noteworthy ), 2 );
        }
    }
    else
    {
        var_e50a4e84ffa06c2a = arrayrandomize( level.scarab_pap_quest.var_c6b9e23aac03b4d0 );
        
        foreach ( var_4d376276647607c7 in var_e50a4e84ffa06c2a )
        {
            if ( var_4d376276647607c7 utility::ent_flag( "is_lit" ) )
            {
                continue;
            }
            
            var_4d376276647607c7.var_3dfb48cd2da760ed = 1;
            var_4d376276647607c7 function_760e6888e3e99e1d( 1 );
            var_4d376276647607c7 utility::function_7c10ea82c1e305b8( "usable", "usable" );
            var_4d376276647607c7.dontreset = 1;
            level zm_quest::function_4eefe6de31f5ddab( #"scarab_phone_quest", hashcat( #"hash_d093261ec76a4ecb", var_4d376276647607c7.s_brazier.script_noteworthy ), 1 );
            break;
        }
    }
    
    level callback::callback( "power_surge_happened" );
    activateworldevent( "we_lgt_gimbals_fast" );
    deactivateworldevent( "we_lgt_gimbals_slow" );
    wait 10;
    deactivateworldevent( "we_lgt_gimbals_fast" );
    activateworldevent( "we_lgt_gimbals_slow" );
    
    foreach ( var_6b188b2a9854e5d8 in var_7310ab5ed2bc2339 )
    {
        var_6b188b2a9854e5d8.var_3dfb48cd2da760ed = 0;
        var_6b188b2a9854e5d8.var_2bda94460d5b5cae = undefined;
    }
    
    level.scarab_pap_quest.var_3beeb295fe09e9bf = [];
    
    if ( level utility::flag( "gimbals_are_up" ) )
    {
        function_45d093f55c15da8c();
    }
    
    foreach ( var_2e2441e747b19673 in level.scarab_pap_quest.var_869784d65d81d184 )
    {
        if ( !var_650afee77554228c.frompap )
        {
            var_2e2441e747b19673 thread function_4c29d31c0e1122a4();
        }
        else if ( var_af0d2a90c128693d )
        {
            var_2e2441e747b19673.interact.cooldowntime = 0;
            var_2e2441e747b19673.mdl utility::function_7c10ea82c1e305b8( "usable", "usable_surge" );
        }
        else
        {
            var_2e2441e747b19673.mdl utility::function_7c10ea82c1e305b8( "usable", "cooldown" );
            var_2e2441e747b19673 thread function_4c29d31c0e1122a4();
        }
        
        var_2e2441e747b19673 utility::ent_flag_clear( "is_finish_rotated" );
    }
    
    level.var_c57f2e874f4ba092 setscriptablepartstate( "power_surge", "disabled" );
    level utility::flag_clear( "power_surge_active" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xecd007ad, Offset: 0xea87
// Size: 0xc4
function private function_4c29d31c0e1122a4()
{
    self.mdl notify( #"dont_set_usable" );
    self.mdl endon( #"dont_set_usable", #"power_surge_active" );
    self.mdl utility::function_7c10ea82c1e305b8( "usable", "cooldown" );
    self.interact.cooldowntime = 90;
    level.scarab_pap_quest.var_b335801a86aa60af = gettime();
    
    do
    {
        wait 1;
        self.interact.cooldowntime--;
    }
    while ( self.interact.cooldowntime > 0 );
    
    self.mdl utility::function_7c10ea82c1e305b8( "usable", "usable_surge" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 6
// Checksum 0x6b666939, Offset: 0xeb53
// Size: 0x200
function function_45d093f55c15da8c( n_stop_time = 1, n_ease_time = 2, var_924ad8579216d213, var_368b8b433b945fc5 = 3, var_7f22d8b8f8904ea4 = 2, var_1893d0bddf221db3 )
{
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    function_3dcd857bd322e457( 0, ( 0, 0, 0 ), n_stop_time );
    level.scarab_pap_quest.var_dbdff7ad02b59f6b utility::ent_flag_waitopen_any( "is_ring_rotating" );
    level.scarab_pap_quest.var_dbdff8ad02b5a19e utility::ent_flag_waitopen_any( "is_ring_rotating" );
    
    foreach ( var_6b188b2a9854e5d8 in [ level.scarab_pap_quest.var_dbdff7ad02b59f6b, level.scarab_pap_quest.var_dbdff8ad02b5a19e ] )
    {
        var_6b188b2a9854e5d8.earthquake_scale = var_1893d0bddf221db3.earthquake_scale;
        var_6b188b2a9854e5d8.earthquake_radius = var_1893d0bddf221db3.earthquake_radius;
        var_6b188b2a9854e5d8.override_rumble = var_1893d0bddf221db3.override_rumble;
    }
    
    level.scarab_pap_quest.var_dbdff7ad02b59f6b thread function_33cf59821e8c556c( ( 0, 360, 0 ), var_368b8b433b945fc5, 1, 0, n_ease_time, var_924ad8579216d213 );
    level.scarab_pap_quest.var_dbdff8ad02b5a19e thread function_33cf59821e8c556c( ( 0, 360, 0 ), var_7f22d8b8f8904ea4, 1, 0, n_ease_time, var_924ad8579216d213 );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1
// Checksum 0x41a3c59c, Offset: 0xed5b
// Size: 0xb4b
function function_51f12524c830dd09( var_650afee77554228c )
{
    self notify( #"hash_e4b4b11de1d4d5c5" );
    self endon( #"hash_e4b4b11de1d4d5c5" );
    level endon( #"game_ended" );
    
    if ( level utility::flag( "open_sesame" ) )
    {
        level function_45b00b1b3a595819();
        return;
    }
    
    var_dd925b6b224c9541 = level zm_quest::get_quest_step( #"scarab_pap_quest", #"complete" );
    
    if ( var_dd925b6b224c9541.b_save_restored && var_dd925b6b224c9541.completed )
    {
        return;
    }
    
    if ( !var_650afee77554228c )
    {
        var_650afee77554228c = {};
    }
    
    level.scarab_pap_quest utility::ent_flag_wait( "is_initialized" );
    current_quest_step = level.scarab_pap_quest.steps[ level.scarab_pap_quest.var_7be076c9078045aa ];
    
    if ( current_quest_step.ref == #"insert_seed" && !level.scarab_pap_quest.s_seed utility::ent_flag( "is_placed" ) )
    {
        var_6573b2bbd219d66 = 1;
        level function_38448ec66340d598( level.scarab_pap_quest.s_seed, current_quest_step.ref, 1, &"shared_hintstrings/place", undefined, var_6573b2bbd219d66 );
        return;
    }
    
    level.scarab_pap_quest.var_b3ad13b33f68da50 = arraycombineunique( level.scarab_pap_quest.var_b3ad13b33f68da50, [ #"insert_seed" ] );
    
    if ( current_quest_step.ref == #"hunt_skulls" || current_quest_step.ref == #"insert_seed" && level.scarab_pap_quest.s_seed utility::ent_flag( "is_placed" ) )
    {
        if ( !level.scarab_pap_quest.s_current_skull.agent )
        {
            var_b1428d1c2e2f00b2 = [];
            
            foreach ( var_1be5586316eb3191 in [ level.scarab_pap_quest.s_skull_1, level.scarab_pap_quest.s_skull_2 ] )
            {
                if ( !isalive( var_1be5586316eb3191.agent ) )
                {
                    continue;
                }
                
                if ( !isdefined( var_b1428d1c2e2f00b2 ) )
                {
                    var_b1428d1c2e2f00b2 = [];
                }
                
                var_b1428d1c2e2f00b2[ var_b1428d1c2e2f00b2.size ] = var_1be5586316eb3191.agent;
            }
            
            level thread function_38448ec66340d598( var_b1428d1c2e2f00b2, #"hunt_skulls", 1, &"hash_27a897a6c07b4ea9", 88, 2, 13, 1 );
            return;
        }
        
        level.scarab_pap_quest.var_b3ad13b33f68da50 = arraycombineunique( level.scarab_pap_quest.var_b3ad13b33f68da50, [ #"hunt_skulls" ] );
        var_f81ce681ddb3cc8a = level.scarab_pap_quest.s_current_skull == level.scarab_pap_quest.s_skull_1 ? #"hash_c7044385893e7295" : #"hash_c7044085893e6d7c";
        
        if ( !level.scarab_pap_quest.s_current_skull utility::ent_flag( "is_destroyed" ) )
        {
            if ( var_650afee77554228c.var_ce32f3d53521f58c )
            {
                level zm_quest::get_quest_step( #"scarab_pap_quest", var_f81ce681ddb3cc8a ).skip_splash = 0;
                level zm_quest::get_quest_step( #"scarab_pap_quest", var_f81ce681ddb3cc8a ).var_94c5b7d04e0c2501 = 0;
            }
            
            level function_38448ec66340d598( level.scarab_pap_quest.s_current_skull.agent, var_f81ce681ddb3cc8a, 1, &"hash_27a897a6c07b4ea9", 88, 2, undefined, 1 );
            return;
        }
        
        level.scarab_pap_quest.var_b3ad13b33f68da50 = arraycombineunique( level.scarab_pap_quest.var_b3ad13b33f68da50, [ var_f81ce681ddb3cc8a ] );
        
        if ( level.scarab_pap_quest.s_current_skull.var_87f8c6598b0699af utility::ent_flag( "is_lit" ) || var_650afee77554228c.has_failed )
        {
            if ( var_650afee77554228c.has_failed && ( var_650afee77554228c.var_1fbad0c50e0f39fa || level.scarab_pap_quest.var_48e543bcd57e9d83 ) )
            {
                if ( !var_650afee77554228c.var_1fbad0c50e0f39fa )
                {
                    level zm_quest::function_fb3af5600f6a9441( 3, 1, #"scarab_pap_quest", level.scarab_pap_quest.var_48e543bcd57e9d83 );
                    level function_45b00b1b3a595819();
                    wait 2;
                }
                
                if ( var_650afee77554228c.var_7a4474e071a50b0b )
                {
                    level thread function_38448ec66340d598( level.scarab_pap_quest.s_current_skull.var_87f8c6598b0699af, level.scarab_pap_quest.s_current_skull == level.scarab_pap_quest.s_skull_1 ? #"hash_94fb431c2711f3e7" : #"hash_94fb441c2711f59a", 1, undefined, 24, 2 );
                    level waittill( #"on_round_end" );
                }
            }
            
            level.scarab_pap_quest.var_b3ad13b33f68da50 = arraycombineunique( level.scarab_pap_quest.var_b3ad13b33f68da50, [ level.scarab_pap_quest.s_current_skull == level.scarab_pap_quest.s_skull_1 ? #"hash_94fb431c2711f3e7" : #"hash_94fb441c2711f59a" ] );
            level function_38448ec66340d598( level.scarab_pap_quest.s_current_skull.var_87f8c6598b0699af, level.scarab_pap_quest.s_current_skull == level.scarab_pap_quest.s_skull_1 ? #"hash_402e0d074cc6f251" : #"hash_402e0a074cc6ed38", 1, undefined, 24, 2 );
            return;
        }
        
        var_fb30f3b84d922147 = level zm_quest::function_73720cdf21c3cfd7( #"scarab_pap_quest", level.scarab_pap_quest.s_current_skull == level.scarab_pap_quest.s_skull_1 ? #"hash_cce5cbb8c9e0117a" : #"hash_b79f2a6fc4be996b" );
        var_8795a6f35701eef3 = var_fb30f3b84d922147 == 2;
        
        if ( level.scarab_pap_quest.s_current_skull && !var_8795a6f35701eef3 && !level.scarab_pap_quest.s_current_skull utility::ent_flag( "is_torch_delivered" ) )
        {
            a_s_braziers = [];
            
            foreach ( var_4d376276647607c7 in level.scarab_pap_quest.var_c6b9e23aac03b4d0 )
            {
                if ( var_4d376276647607c7 utility::ent_flag( "is_lit" ) )
                {
                    continue;
                }
                
                if ( !isdefined( a_s_braziers ) )
                {
                    a_s_braziers = [];
                }
                
                a_s_braziers[ a_s_braziers.size ] = var_4d376276647607c7;
            }
            
            var_6573b2bbd219d66 = var_650afee77554228c.firstpickup ? undefined : 2;
            level thread function_38448ec66340d598( a_s_braziers, level.scarab_pap_quest.s_current_skull == level.scarab_pap_quest.s_skull_1 ? #"hash_7f81077fb695e7e2" : #"hash_7f81067fb695e62f", 1, undefined, 24, var_6573b2bbd219d66 );
            return;
        }
        
        return;
    }
    
    previous_refs = [ #"hunt_skulls", #"hash_c7044385893e7295", #"hash_c7044085893e6d7c", #"hash_402e0d074cc6f251", #"hash_402e0a074cc6ed38", #"hash_7f81077fb695e7e2", #"hash_7f81067fb695e62f", #"hash_94fb431c2711f3e7", #"hash_94fb441c2711f59a" ];
    level.scarab_pap_quest.var_b3ad13b33f68da50 = arraycombineunique( level.scarab_pap_quest.var_b3ad13b33f68da50, previous_refs );
    
    if ( current_quest_step.ref == #"rotate_cranks" )
    {
        if ( !level.scarab_pap_quest.var_61396eee26689ea1 )
        {
            var_869784d65d81d184 = [];
            
            foreach ( var_2e2441e747b19673 in level.scarab_pap_quest.var_869784d65d81d184 )
            {
                if ( var_2e2441e747b19673 utility::ent_flag( "is_first_rotated" ) )
                {
                    continue;
                }
                
                if ( !isdefined( var_869784d65d81d184 ) )
                {
                    var_869784d65d81d184 = [];
                }
                
                var_869784d65d81d184[ var_869784d65d81d184.size ] = var_2e2441e747b19673.mdl;
            }
            
            level thread function_38448ec66340d598( var_869784d65d81d184, #"rotate_cranks", 1, &"hash_74e5192f4b1bb22b", 16 );
            level zm_quest::function_9f49b2a045ece8ae( level.scarab_pap_quest.var_c6070e16c81619f1, 1, #"scarab_pap_quest", #"rotate_cranks" );
            return;
        }
        
        var_bfe9939a3fbd75ba = level.scarab_pap_quest.var_61396eee26689ea1 == level.scarab_pap_quest.var_869784d65d81d184[ 0 ] ? #"hash_cf9cadfb84da7b1" : #"hash_cf9c7dfb84da298";
        level function_38448ec66340d598( level.scarab_pap_quest.var_61396eee26689ea1.mdl, var_bfe9939a3fbd75ba, 1, &"hash_74e5192f4b1bb22b", 24, 2 );
        
        if ( level.scarab_pap_quest.var_61396eee26689ea1.var_83cebc8cbb76e120 && level.scarab_pap_quest.var_61396eee26689ea1.target_hold_time )
        {
            progress = min( 100, function_5f7accfcf7404be( level.scarab_pap_quest.var_61396eee26689ea1 ) * 100 );
            
            if ( progress >= 0 && level.scarab_pap_quest.var_61396eee26689ea1 utility::ent_flag( "guidance_active" ) )
            {
                /#
                    iprintlnbold( progress );
                #/
                
                level thread zm_quest::function_9f49b2a045ece8ae( progress, 1, #"scarab_pap_quest", var_bfe9939a3fbd75ba );
            }
        }
        
        level.scarab_pap_quest.var_61396eee26689ea1 utility::ent_flag_set( "guidance_active" );
        return;
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xbfb6b1dd, Offset: 0xf8ae
// Size: 0x169
function private function_96d06a6ebdf6d263( var_650afee77554228c )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( var_650afee77554228c ) )
    {
        var_650afee77554228c = {};
    }
    
    var_7d79ab034e15da68 = self;
    s_current_skull = level.scarab_pap_quest.s_current_skull;
    
    if ( s_current_skull == var_7d79ab034e15da68 )
    {
        level thread function_51f12524c830dd09( var_650afee77554228c );
        return;
    }
    
    if ( !var_650afee77554228c.var_ce32f3d53521f58c && s_current_skull.node_idx > var_7d79ab034e15da68.node_idx )
    {
        return;
    }
    
    if ( !var_650afee77554228c.var_ce32f3d53521f58c )
    {
        if ( s_current_skull.var_348491563c879773 > var_7d79ab034e15da68.var_348491563c879773 )
        {
            if ( var_7d79ab034e15da68.var_348491563c879773 != 2 || !s_current_skull.var_87f8c6598b0699af.var_7a4474e071a50b0b )
            {
                return;
            }
        }
        else if ( s_current_skull.var_348491563c879773 == var_7d79ab034e15da68.var_348491563c879773 && s_current_skull.var_348491563c879773 == 2 )
        {
            if ( var_7d79ab034e15da68.var_87f8c6598b0699af.var_7a4474e071a50b0b )
            {
                return;
            }
        }
    }
    
    level.scarab_pap_quest.s_current_skull = var_7d79ab034e15da68;
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_pap_quest", #"current_skull", var_7d79ab034e15da68.num );
    level thread function_51f12524c830dd09( var_650afee77554228c );
}

// Namespace zm_sat_scarab_pap_quest
// Params 8, eflags: 0x4
// Checksum 0x5e35b5c0, Offset: 0xfa1f
// Size: 0x901
function private function_38448ec66340d598( var_fe501b744cefa6fa, step_ref, b_play_intro = 1, str_label, zoffset = 20, var_6573b2bbd219d66, var_850df567b37f5e37, var_22c227ff9b447dd0 = 0 )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "load_phone_finished" );
    
    if ( level.scarab_phone && !level.scarab_phone.var_aa3febe5f666b58f )
    {
        if ( !level.scarab_phone.is_completing_guidance && ( !level.scarab_phone.var_b249c3f5faace516 || level.var_71af9b4e3751cbbf ) )
        {
            return;
        }
        
        var_267d728e35e0b3 = 1;
        var_6573b2bbd219d66 = 1;
    }
    
    var_fe501b744cefa6fa = isarray( var_fe501b744cefa6fa ) ? var_fe501b744cefa6fa : [ var_fe501b744cefa6fa ];
    
    foreach ( origin_or_ent in var_fe501b744cefa6fa )
    {
        level.scarab_pap_quest notify( #"hash_d9e74ada1ea3da69", origin_or_ent, step_ref );
    }
    
    if ( !isdefined( level.scarab_pap_quest.a_current_objectives ) )
    {
        level.scarab_pap_quest.a_current_objectives = [];
    }
    
    if ( level.scarab_pap_quest.var_48e543bcd57e9d83 == step_ref )
    {
        foreach ( current_objectives in level.scarab_pap_quest.a_current_objectives )
        {
            foreach ( origin_or_ent in var_fe501b744cefa6fa )
            {
                if ( current_objectives == origin_or_ent )
                {
                    return;
                }
            }
        }
    }
    
    foreach ( var_cee8788f6ff31df4 in level.scarab_pap_quest.var_b3ad13b33f68da50 )
    {
        level zm_quest::function_fb3af5600f6a9441( 0, 1, #"scarab_pap_quest", var_cee8788f6ff31df4 );
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"scarab_pap_quest", var_cee8788f6ff31df4 );
    }
    
    var_c5ee73ae8f8ca28a = 0;
    
    if ( var_267d728e35e0b3 || !level.scarab_pap_quest.var_48e543bcd57e9d83 || level.scarab_pap_quest.var_48e543bcd57e9d83 && level.scarab_pap_quest.var_48e543bcd57e9d83 != step_ref )
    {
        level function_45b00b1b3a595819();
        waitframe();
        var_c5ee73ae8f8ca28a = 1;
        
        foreach ( origin_or_ent in var_fe501b744cefa6fa )
        {
            if ( arraycontains( level.scarab_pap_quest.a_current_objectives, origin_or_ent ) )
            {
                return;
            }
            
            if ( !isdefined( level.scarab_pap_quest.a_current_objectives ) )
            {
                level.scarab_pap_quest.a_current_objectives = [];
            }
            
            level.scarab_pap_quest.a_current_objectives[ level.scarab_pap_quest.a_current_objectives.size ] = origin_or_ent;
        }
        
        level.scarab_pap_quest.var_48e543bcd57e9d83 = step_ref;
        
        if ( var_850df567b37f5e37 )
        {
            wait var_850df567b37f5e37;
        }
        
        level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"scarab_pap_quest", step_ref );
        
        if ( var_6573b2bbd219d66 )
        {
            level zm_quest::function_fb3af5600f6a9441( var_6573b2bbd219d66, 1, #"scarab_pap_quest", step_ref );
            splashdelay = var_267d728e35e0b3 ? 2 : 1;
            wait splashdelay;
        }
    }
    
    if ( !var_c5ee73ae8f8ca28a )
    {
        foreach ( origin_or_ent in var_fe501b744cefa6fa )
        {
            if ( arraycontains( level.scarab_pap_quest.a_current_objectives, origin_or_ent ) )
            {
                return;
            }
            
            if ( !isdefined( level.scarab_pap_quest.a_current_objectives ) )
            {
                level.scarab_pap_quest.a_current_objectives = [];
            }
            
            level.scarab_pap_quest.a_current_objectives[ level.scarab_pap_quest.a_current_objectives.size ] = origin_or_ent;
        }
        
        level.scarab_pap_quest.var_48e543bcd57e9d83 = step_ref;
    }
    
    current_quest_step = level.scarab_pap_quest.steps[ level.scarab_pap_quest.var_7be076c9078045aa ];
    
    if ( level utility::flag( "open_sesame" ) || level.scarab_pap_quest.completed || current_quest_step.completed )
    {
        return;
    }
    
    foreach ( origin_or_ent in var_fe501b744cefa6fa )
    {
        if ( !origin_or_ent )
        {
            continue;
        }
        
        var_895bdd0db4c4515 = [];
        objectiveid = undefined;
        var_d77a77b2a496a842 = arraycontains( [ level.scarab_pap_quest.s_skull_1.agent, level.scarab_pap_quest.s_skull_2.agent ], origin_or_ent );
        
        if ( isent( origin_or_ent ) )
        {
            if ( !var_d77a77b2a496a842 )
            {
                var_895bdd0db4c4515 = arraycombineunique( var_895bdd0db4c4515, [ origin_or_ent ] );
            }
            
            objectiveid = zm_quest::function_dc297429579c6e7f( step_ref, 1, "ui_icon_zm_objective", "icon_small_medium", "current", origin_or_ent, zoffset, str_label, undefined, 0, b_play_intro, 0 );
        }
        else if ( origin_or_ent )
        {
            origin_or_ent = isvector( origin_or_ent ) ? origin_or_ent : origin_or_ent.origin;
            objectiveid = zm_quest::function_b98d4144845ffc13( step_ref, 1, "ui_icon_zm_objective", "icon_small_medium", "current", origin_or_ent, zoffset, str_label, undefined, 0, b_play_intro );
        }
        
        if ( var_22c227ff9b447dd0 && isdefined( objectiveid ) )
        {
            level objidpoolmanager::objective_showdistance( objectiveid, 0 );
            level objidpoolmanager::function_de3fb937d4f45f38( objectiveid, 800, 400 );
        }
        
        foreach ( target in var_895bdd0db4c4515 )
        {
            if ( isdefined( objectiveid ) )
            {
                calloutmarkerping::function_9bd4bf4f8fe74b16( target, objectiveid, 6 );
                
                if ( !isdefined( level.scarab_pap_quest.var_a3e31c6af9c21d0c ) )
                {
                    level.scarab_pap_quest.var_a3e31c6af9c21d0c = [];
                }
                
                level.scarab_pap_quest.var_a3e31c6af9c21d0c[ level.scarab_pap_quest.var_a3e31c6af9c21d0c.size ] = target;
            }
        }
        
        if ( !isdefined( level.scarab_pap_quest.var_fce0c3e197569778 ) )
        {
            level.scarab_pap_quest.var_fce0c3e197569778 = [];
        }
        
        level.scarab_pap_quest.var_fce0c3e197569778[ level.scarab_pap_quest.var_fce0c3e197569778.size ] = objectiveid;
        level.scarab_pap_quest notify( #"hash_b18c3696d16f534c", objectiveid, origin_or_ent, step_ref );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xfac4d2b6, Offset: 0x10328
// Size: 0x146
function private function_45b00b1b3a595819()
{
    foreach ( id in level.scarab_pap_quest.var_fce0c3e197569778 )
    {
        level zm_quest::complete_objective_waypoints( id );
    }
    
    level.scarab_pap_quest.var_fce0c3e197569778 = [];
    
    foreach ( target in level.scarab_pap_quest.var_a3e31c6af9c21d0c )
    {
        calloutmarkerping::function_ab4e5514677fba94( target );
    }
    
    level.scarab_pap_quest.var_a3e31c6af9c21d0c = [];
    level.scarab_pap_quest.a_current_objectives = [];
}

// Namespace zm_sat_scarab_pap_quest
// Params 11, eflags: 0x4
// Checksum 0xc50e083a, Offset: 0x10476
// Size: 0xea
function private function_86f4d375df09a65a( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, spartname )
{
    level endon( #"game_ended" );
    
    if ( !instance || !instance getscriptablehaspart( "health" ) )
    {
        return;
    }
    
    if ( getxhashasset( instance.type ) == %"hash_77a162c14e8deb93" )
    {
        eattacker thread damagefeedback::updatedamagefeedback( "standard" );
        level mp_agent_damage::function_eb8ba16055d6da7c( eattacker, self, undefined, smeansofdeath, objweapon, 0, vpoint, 1, undefined, undefined, undefined, undefined, undefined, einflictor );
    }
    
    instance notify( #"damage", einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, spartname );
}

// Namespace zm_sat_scarab_pap_quest
// Params 4, eflags: 0x4
// Checksum 0x8afb1eb1, Offset: 0x10568
// Size: 0x90
function private function_59952a45413dbb99( instance, note, param, var_64ffacba090c91be )
{
    if ( !isdefined( instance ) )
    {
        return;
    }
    
    if ( arraycontains( level.scarab_pap_quest.var_c6b9e23aac03b4d0, instance ) )
    {
        instance utility::function_7c10ea82c1e305b8( "sfx", "forge_on" );
        return;
    }
    
    if ( arraycontains( level.scarab_pap_quest.var_f0218d7a43516520, instance ) )
    {
        instance utility::function_7c10ea82c1e305b8( "sfx", "temple_on" );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x34a06090, Offset: 0x10600
// Size: 0x8a
function private function_86b23a35ab3696d6()
{
    if ( !isdefined( self.var_59f2066b542a115d ) )
    {
        return;
    }
    
    do
    {
        self.var_59f2066b542a115d waittill( #"trigger", player );
        
        if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player, 0, 1 ) )
        {
            continue;
        }
        
        vdir = vectornormalize( player.origin - self.var_59f2066b542a115d.origin );
        player utility::delaycall( 0, &knockback, vdir, 400, 1 );
    }
    while ( true );
}

// Namespace zm_sat_scarab_pap_quest
// Params 5
// Checksum 0x86366666, Offset: 0x10692
// Size: 0x1bb
function play_vo_banter( var_5e1c75975eb34ec4, var_7c2c820e274abf1c = 0, player, var_1c360473c4174a43, var_e4a07fbc14e00c4d = 0 )
{
    if ( overlord::function_dce0a14273dfa0a8() || level utility::flag( "overlord_paused" ) )
    {
        return;
    }
    
    banterstruct = self.event_banter[ var_5e1c75975eb34ec4 ];
    
    if ( level utility::flag( "player_banter_playing" ) || banterstruct.var_7d0cc2771cba8ee5 )
    {
        return;
    }
    
    var_8984c1f1eeea88ec = banterstruct.bantername;
    
    if ( !var_8984c1f1eeea88ec )
    {
        return;
    }
    
    if ( !isdefined( banterstruct.playersplayed ) )
    {
        banterstruct.playersplayed = [];
    }
    
    if ( var_e4a07fbc14e00c4d && arraycontains( banterstruct.playersplayed, player ) )
    {
        return;
    }
    
    if ( !isdefined( var_1c360473c4174a43 ) )
    {
        var_1c360473c4174a43 = banterstruct.fallback;
    }
    
    level overlord::function_724ca7b94bf1fb66( 1 );
    
    if ( var_7c2c820e274abf1c == -1 )
    {
        banterstruct.bantername = undefined;
    }
    
    if ( var_e4a07fbc14e00c4d && isalive( player ) )
    {
        banterstruct.playersplayed = arraycombineunique( banterstruct.playersplayed, [ player ] );
    }
    
    players = isalive( player ) ? [ player ] : level.players;
    var_db75d3de862ce072 = level namespace_f1b889ff795b541c::play_banter_vo( var_8984c1f1eeea88ec, players );
    
    if ( !var_db75d3de862ce072 && isalive( player ) && var_1c360473c4174a43 )
    {
        level battlechatter_mp::trysaylocalsound( player, var_1c360473c4174a43 );
    }
    
    level utility::delaythread( 1, &overlord::function_724ca7b94bf1fb66, 0 );
    thread function_e928ce898e77ddd1( var_5e1c75975eb34ec4, var_db75d3de862ce072, var_7c2c820e274abf1c );
    return var_db75d3de862ce072;
}

// Namespace zm_sat_scarab_pap_quest
// Params 3, eflags: 0x4
// Checksum 0x458815b6, Offset: 0x10856
// Size: 0x61
function private function_e928ce898e77ddd1( var_5e1c75975eb34ec4, var_db75d3de862ce072, var_7c2c820e274abf1c )
{
    banterstruct = self.event_banter[ var_5e1c75975eb34ec4 ];
    
    if ( var_db75d3de862ce072 && var_7c2c820e274abf1c > 0 )
    {
        banterstruct.var_7d0cc2771cba8ee5 = 1;
        wait var_7c2c820e274abf1c;
        banterstruct.var_7d0cc2771cba8ee5 = 0;
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xc84db2d0, Offset: 0x108bf
// Size: 0x70
function private function_42cdb7bef87fe61( str_event_ref )
{
    if ( !isdefined( self.var_fb04a2e4e1770aa9 ) )
    {
        self.var_fb04a2e4e1770aa9 = [];
    }
    
    if ( self.var_fb04a2e4e1770aa9[ str_event_ref ] )
    {
        return;
    }
    
    utility::flag_set( "skip_powerup_vo" );
    self.var_fb04a2e4e1770aa9[ str_event_ref ] = 1;
    level overlord::playevent( str_event_ref, level.players, undefined, undefined, 1 );
    utility::flag_clear( "skip_powerup_vo" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x708e059a, Offset: 0x10937
// Size: 0xa1
function private function_c7e06474a927134f( player )
{
    var_dfcc2aad0b563514 = self.var_2da12b930758856a ?? 0;
    self.var_2da12b930758856a = 1;
    utility::flag_set( "skip_powerup_vo" );
    lineplayed = level overlord::playevent( #"scarab_pap_w_t", level.players, undefined, undefined, 1 );
    utility::flag_clear( "skip_powerup_vo" );
    
    if ( istrue( lineplayed ) && !var_dfcc2aad0b563514 )
    {
        level overlord::function_29d8b7aaf2aa133a( level.players );
        play_vo_banter( #"hash_88369d0d876507bc", -1, player );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xda212d15, Offset: 0x109e0
// Size: 0x59
function private function_3fd8acb758c48db6()
{
    if ( self.var_1b24eb09051d9369 )
    {
        return;
    }
    
    self.var_1b24eb09051d9369 = 1;
    var_cbb9de3ce21516de = [];
    
    for ( i = 1; i <= 4 ; i++ )
    {
        var_cbb9de3ce21516de[ var_cbb9de3ce21516de.size ] = "scarab_pap_h_e_a" + i;
    }
    
    level thread zm_quest::function_d5ef98341fd6a057( var_cbb9de3ce21516de );
}

// Namespace zm_sat_scarab_pap_quest
// Params 12, eflags: 0xc
// Checksum 0x8584bb3b, Offset: 0x10a41
// Size: 0x836
function private spawn_event_zombies( radius, var_2a28f8c6e8b63140, event_name, var_392d8b2be6a2351b = 1750, event_player_radius = 1200, event_spawn_flag, var_df125048d0e44125 = 0, zombie_spawn_interval, var_ef9c3997f9bd7592, var_ae8733439bf340f4, event_origin = self.origin, var_9c48d16a8ddc875 )
{
    self notify( #"hash_de8b9145cb26c925" );
    self endon( #"hash_de8b9145cb26c925" );
    level endon( #"game_ended" );
    
    if ( var_ae8733439bf340f4 )
    {
        wait 5;
    }
    
    if ( isplayer( var_2a28f8c6e8b63140 ) )
    {
        if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( var_2a28f8c6e8b63140 ) )
        {
            return;
        }
        
        var_2a28f8c6e8b63140 endon( #"death_or_disconnect" );
    }
    
    if ( level.firefly_ww_quest.s_debug.var_3c53e6bf591666f3 == 0 )
    {
        return;
    }
    
    zombie_round_difficulty = zm_round_logic::get_rb_round_number() + var_df125048d0e44125;
    self.a_zombies_spawned = [];
    callback::remove( #"on_ai_killed", &function_a8219108040d8468, self );
    callback::add( #"on_ai_killed", &function_a8219108040d8468, self );
    var_29155e0ed4821acf = level._livingworld_info.var_90fad1f7b6fa1ff0;
    powerups::function_b3ef1ccbc3c4bbbb( 0 );
    b_first_spawned = 0;
    var_5818b14097fe1399 = undefined;
    var_e145557eae07e615 = undefined;
    num_zombies_spawned = 0;
    
    while ( utility::ent_flag( event_spawn_flag ) )
    {
        if ( num_zombies_spawned >= 40 )
        {
            /#
                logstring( "<dev string:xba>" + event_spawn_flag + "<dev string:xd8>" );
            #/
            
            waitframe();
            continue;
        }
        
        if ( isplayer( var_2a28f8c6e8b63140 ) )
        {
            if ( namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( var_2a28f8c6e8b63140 ) )
            {
                zone = zone_manager::function_90e5c3e2272b0130( var_2a28f8c6e8b63140.origin );
                event_origin = var_2a28f8c6e8b63140.origin;
            }
            else
            {
                return;
            }
        }
        
        var_c6457b9450c88863 = getplayersinradius( event_origin, event_player_radius );
        
        if ( var_c6457b9450c88863.size > 0 && ( !isdefined( var_e145557eae07e615 ) || var_e145557eae07e615.size != var_c6457b9450c88863.size ) )
        {
            var_e145557eae07e615 = var_c6457b9450c88863;
            max_spawn_count = var_e145557eae07e615.size * 5 + 10;
            var_a958b2f1050461c1 = zombie_spawn_interval;
            var_a958b2f1050461c1 -= var_e145557eae07e615.size == 1 ? 2 : 0;
            var_a958b2f1050461c1 /= var_e145557eae07e615.size >= 4 ? 3.75 : var_e145557eae07e615.size;
        }
        
        if ( var_c6457b9450c88863.size <= 0 )
        {
            /#
                logstring( "<dev string:xba>" + event_spawn_flag + "<dev string:x100>" );
            #/
            
            waitframe();
            continue;
        }
        
        if ( isdefined( var_5818b14097fe1399 ) )
        {
            var_4e76d2ef0334cb0e = utility::function_6f5d2e1f1ff70482( gettime() ) - var_5818b14097fe1399;
            
            if ( var_4e76d2ef0334cb0e < var_a958b2f1050461c1 )
            {
                waitframe();
                continue;
            }
        }
        
        zombies_count = zm_utility::get_active_zombies_count();
        var_9e5ef79d94efc7eb = getaiarrayinradius( event_origin, radius, zm_utility::get_zombie_team() );
        
        if ( zombies_count >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
        {
            event_zombies = arraycombineunique( var_9e5ef79d94efc7eb, self.a_zombies_spawned );
            var_29155e0ed4821acf = arraycombineunique( event_zombies, var_29155e0ed4821acf );
            var_5da531956c557870 = round( level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 / 8 ) + 1;
            var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( int( var_5da531956c557870 ), [ "normal" ], var_29155e0ed4821acf, undefined, 1, undefined, 1, 600 );
            
            if ( !var_d7b3a1f33b95bf77 )
            {
                /#
                    logstring( "<dev string:xba>" + event_spawn_flag + "<dev string:x12c>" );
                #/
                
                waitframe();
                continue;
            }
        }
        
        var_fa6ce69c0e6a4a22 = arrayintersection( var_9e5ef79d94efc7eb, self.a_zombies_spawned );
        
        if ( var_9e5ef79d94efc7eb.size >= max_spawn_count && var_fa6ce69c0e6a4a22.size >= var_ef9c3997f9bd7592 )
        {
            /#
                logstring( "<dev string:xba>" + event_spawn_flag + "<dev string:x165>" + max_spawn_count + "<dev string:x1a1>" + var_ef9c3997f9bd7592 + "<dev string:x1a3>" );
            #/
            
            waitframe();
            continue;
        }
        
        spawner_zombie_type = function_b3988325430ce242( "zombie_base" );
        
        if ( !isdefined( spawner_zombie_type ) )
        {
            /#
                logstring( "<dev string:xba>" + event_spawn_flag + "<dev string:x1a6>" + spawner_zombie_type + "<dev string:x1a3>" );
            #/
            
            waitframe();
            continue;
        }
        
        if ( !isdefined( zone ) )
        {
            zone = var_2a28f8c6e8b63140;
        }
        
        if ( !zone.zone_name || !zone.var_c96b1c3cfbbd6aac )
        {
            /#
                logstring( "<dev string:xba>" + event_spawn_flag + "<dev string:x1ce>" );
            #/
            
            waitframe();
            continue;
        }
        
        var_33e3fae68ea718e3 = zone_spawner::function_20c574a6ba7cc5c6( zone.zone_name, spawner_zombie_type );
        var_33e3fae68ea718e3 = utility::get_array_of_closest( event_origin, var_33e3fae68ea718e3, undefined, undefined, var_392d8b2be6a2351b );
        var_a650a0c6e936d32e = [];
        
        if ( getarraykeys( zone.var_c96b1c3cfbbd6aac ) )
        {
            var_657090c09a4ba939 = [];
            
            foreach ( adjacent_zone_name in getarraykeys( zone.var_c96b1c3cfbbd6aac ) )
            {
                adjacent_zone_struct = zone_manager::get_zone_struct( adjacent_zone_name );
                
                if ( !adjacent_zone_struct.is_enabled )
                {
                    continue;
                }
                
                var_657090c09a4ba939[ var_657090c09a4ba939.size ] = adjacent_zone_name;
            }
            
            var_a650a0c6e936d32e = zone_spawner::function_20c574a6ba7cc5c6( var_657090c09a4ba939, spawner_zombie_type );
            var_a650a0c6e936d32e = utility::get_array_of_closest( event_origin, var_a650a0c6e936d32e, undefined, undefined, var_392d8b2be6a2351b );
        }
        
        if ( !b_first_spawned )
        {
            b_first_spawned = 1;
            spawners = var_33e3fae68ea718e3.size > 0 ? var_33e3fae68ea718e3 : var_a650a0c6e936d32e;
        }
        else
        {
            spawners = utility::percent_chance( 80 ) ? var_33e3fae68ea718e3 : var_a650a0c6e936d32e;
        }
        
        if ( !isdefined( spawners ) || spawners.size <= 0 )
        {
            /#
                logstring( "<dev string:xba>" + event_spawn_flag + "<dev string:x1df>" );
            #/
            
            waitframe();
            continue;
        }
        
        zmb_spawner = utility::array_random( spawners );
        thread function_fcc576ce75ae207c( spawner_zombie_type, zmb_spawner, event_name, zombie_round_difficulty, var_9c48d16a8ddc875 );
        num_zombies_spawned++;
        var_5818b14097fe1399 = utility::function_6f5d2e1f1ff70482( gettime() );
    }
    
    callback::remove( #"on_ai_killed", &function_a8219108040d8468, self );
    
    if ( !level.var_a009ab14ee0d3223.isspecialround )
    {
        powerups::function_b3ef1ccbc3c4bbbb( 1 );
    }
    
    points::function_2b4273c6ce33f6eb();
    nearby_ai = getaiarrayinradius( event_origin, 650, zm_utility::get_zombie_team() );
    
    foreach ( var_a8ed9dcd9413dc0a in nearby_ai )
    {
        if ( !zm_utility::is_active_zombie( var_a8ed9dcd9413dc0a ) || var_a8ed9dcd9413dc0a.aicategory == "special" || var_a8ed9dcd9413dc0a.aicategory == "elite" || var_a8ed9dcd9413dc0a.aicategory == "hvt" || var_a8ed9dcd9413dc0a.type != "zombie" )
        {
            nearby_ai = arrayremove( nearby_ai, var_a8ed9dcd9413dc0a );
            continue;
        }
        
        if ( !arraycontains( self.a_zombies_spawned, var_a8ed9dcd9413dc0a ) )
        {
            var_a8ed9dcd9413dc0a zm_cleanup_manager::function_dd62e2042418b7e5();
        }
    }
    
    ais = arraycombineunique( nearby_ai, self.a_zombies_spawned );
    var_aee5aab8da1e9285 = [];
    
    foreach ( ai in ais )
    {
        if ( !zm_utility::is_active_zombie( ai ) )
        {
            continue;
        }
        
        var_aee5aab8da1e9285[ var_aee5aab8da1e9285.size ] = ai;
        ai utility::function_7c10ea82c1e305b8( "base", "base_off" );
    }
    
    level nuke::function_6c5906115e825d8f( event_origin, var_aee5aab8da1e9285 );
    self.a_zombies_spawned = undefined;
}

// Namespace zm_sat_scarab_pap_quest
// Params 5, eflags: 0x4
// Checksum 0x4d0f14b4, Offset: 0x1127f
// Size: 0x226
function private function_fcc576ce75ae207c( spawner_zombie_type, zmb_spawner, event_name, zombie_round_difficulty, var_9c48d16a8ddc875 = "base_purple_eyes" )
{
    level endon( #"game_ended" );
    zombie = agent_manager::spawn_agent( spawner_zombie_type, zmb_spawner.origin, ( 0, 0, 0 ), "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        zombie.var_8986d0eef2b93060 = zombie.kiastring;
        zombie.kiastring = #"zombie_kia_mission_kill";
        zombie utility::function_7c10ea82c1e305b8( "base", var_9c48d16a8ddc875 );
        zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "run" == "super_sprint" || "run" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "run" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "run" == "sprint" ? "run" : "run", event_name, 6 );
        zombie zombie_utils::set_zombie_round_difficulty( zombie_round_difficulty );
        zombie val::set( event_name, "ignore_cleanup", 1 );
        zombie.b_cleanup_no_respawn = 1;
        zombie.ignore_enemy_count = 1;
        zombie.no_powerups = 1;
        zombie.var_15598d8e493afe88 = 1;
        zombie.var_3f41062a98e768c = 1;
        zombie.var_50c96a5c56dab386 = &function_acf02770d0dc43ac;
        zombie.timespawned = gettime();
        self.a_zombies_spawned[ self.a_zombies_spawned.size ] = zombie;
        zombie zone_spawner::function_ce10e453e7f7bb8e( zmb_spawner );
        zombie thread zone_spawner::function_f9d3af30e993a949();
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xd2864f9f, Offset: 0x114ad
// Size: 0x2e
function private function_acf02770d0dc43ac()
{
    return { #droppos:self.origin, #dropquantity:1, #droplist:"zm_sat_scarab_papq_zombie_item_list" };
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x1554871e, Offset: 0x114e4
// Size: 0x32
function private function_a8219108040d8468( sparams, var_cd6fe84ede3ba4ae )
{
    var_cd6fe84ede3ba4ae.a_zombies_spawned = utility::array_removedead_or_dying( var_cd6fe84ede3ba4ae.a_zombies_spawned );
}

// Namespace zm_sat_scarab_pap_quest
// Params 8
// Checksum 0x64f44bf7, Offset: 0x1151e
// Size: 0x9f0
function function_33cf59821e8c556c( var_3c9d7fe0d5ce8228, rotationduration = self == level.scarab_pap_quest.var_dbdff7ad02b59f6b ? 12 : 6, var_c9f3cc25b9f1c6b1 = 1, var_ad43382b4c4ea305 = 1, var_26f563b3b61de737 = 0, var_924ad8579216d213, rotatetodefaultstart, rotatetodefaultstarttime )
{
    level endon( #"game_ended" );
    self endon( #"death", #"hash_4988b7bc41d672ad" );
    
    if ( !isdefined( self.var_65610b2f215ff340 ) )
    {
        self.var_65610b2f215ff340 = 0;
    }
    
    self.var_65610b2f215ff340++;
    rotation_thread_id = self.var_65610b2f215ff340;
    utility::ent_flag_set( "is_ring_rotating" );
    
    if ( !var_924ad8579216d213 )
    {
        thread function_670d5dff684f3a88();
    }
    
    savedholdtime = 0;
    
    if ( self.var_2e2441e747b19673 )
    {
        var_c6d68ade6259ef97 = self.var_2e2441e747b19673 == level.scarab_pap_quest.var_869784d65d81d184[ 0 ] ? #"hash_cf9cadfb84da7b1" : #"hash_cf9c7dfb84da298";
        savedholdtime = self.var_2e2441e747b19673.var_83cebc8cbb76e120 ?? 0;
    }
    
    if ( rotatetodefaultstart )
    {
        function_92773fb518bb06ad( rotatetodefaultstarttime );
        function_81b808b9378f39c6( var_3c9d7fe0d5ce8228, rotationduration, var_26f563b3b61de737 );
    }
    
    var_9807bcafaebddccf = function_4f23ae97a36eb534( var_3c9d7fe0d5ce8228, rotationduration );
    rotationdata = { #var_cb1c180e2300b93:self.angles, #var_9b24221d187bbae1:self.var_5b09b54c5605be78 ?? var_9807bcafaebddccf, #var_5d16a8dff156656e:var_9807bcafaebddccf, #var_b5f2f4784a819a40:var_9807bcafaebddccf, #var_c9f3cc25b9f1c6b1:var_c9f3cc25b9f1c6b1, #timepassed:0, #starttimems:gettime(), #var_26f563b3b61de737:var_26f563b3b61de737, #rotationduration:rotationduration, #var_3c9d7fe0d5ce8228:var_3c9d7fe0d5ce8228, #var_b8ee7b73eae0d9f8:1, #var_b6adabcd2c81f80:rotationduration, #var_bb3b62ecc73c5620:var_3c9d7fe0d5ce8228 };
    
    while ( true )
    {
        rotationdata = function_67cb66d8c9877245( rotationdata );
        
        if ( !rotationdata.var_c9f3cc25b9f1c6b1 && rotationdata.timepassed >= rotationdata.rotationduration )
        {
            break;
        }
        
        if ( var_c6d68ade6259ef97 && ( !self.var_2e2441e747b19673 || !self.var_2e2441e747b19673.is_rotating_crank ) )
        {
            break;
        }
        
        if ( utility::ent_flag( "stop_rotating_ring_natural" ) && !( isdefined( self.var_b469b6a3bd1533fa ) && isdefined( self.var_cc0850c9fe11691d ) ) )
        {
            break;
        }
        
        if ( level.scarab_pap_quest.s_debug.var_7791633f076a1eb )
        {
            thread utility::draw_ent_axis( ( 0, 0, 0 ), int( 0.1 * getframeduration() ), 5 );
        }
        
        var_326d16e084dd3fb2 = rotationdata.rotationstate != 0;
        
        if ( var_326d16e084dd3fb2 )
        {
            var_839437918b467365 = utility::function_6f5d2e1f1ff70482( gettime() - rotationdata.starttimems );
            transitionprogress = var_839437918b467365 / rotationdata.var_26f563b3b61de737;
            var_130cd8ac8a60f78f = squared( transitionprogress ) * ( 3 - 2 * transitionprogress );
            
            if ( rotationdata.rotationstate == 3 )
            {
                if ( transitionprogress >= 1 )
                {
                    var_963849c05482fbc6 = rotationdata.var_419751d3bcb66d1f;
                }
                else
                {
                    var_963849c05482fbc6 = anglelerpquatfrac( rotationdata.var_5fcb1c9586d1e7a0, rotationdata.var_419751d3bcb66d1f, var_130cd8ac8a60f78f );
                }
                
                rotationdata.var_b5f2f4784a819a40 = ( absangleclamp180( var_963849c05482fbc6[ 0 ] - rotationdata.var_518579d90f2a2deb[ 0 ] ), absangleclamp180( var_963849c05482fbc6[ 1 ] - rotationdata.var_518579d90f2a2deb[ 1 ] ), absangleclamp180( var_963849c05482fbc6[ 2 ] - rotationdata.var_518579d90f2a2deb[ 2 ] ) );
                rotationdata.var_518579d90f2a2deb = var_963849c05482fbc6;
            }
            else if ( transitionprogress >= 1 )
            {
                rotationdata.var_b5f2f4784a819a40 = rotationdata.var_5d16a8dff156656e;
                
                if ( rotationdata.rotationstate == 2 )
                {
                    rotationdata.var_a0c8e4d1ee06f053 = 0;
                }
                
                if ( rotationdata.var_b8ee7b73eae0d9f8 )
                {
                    rotationdata.var_bb3b62ecc73c5620 = undefined;
                    rotationdata.var_b6adabcd2c81f80 = undefined;
                    rotationdata.var_b8ee7b73eae0d9f8 = undefined;
                }
                
                rotationdata.var_26f563b3b61de737 = undefined;
            }
            else
            {
                rotationdata.var_b5f2f4784a819a40 = vectorlerp( rotationdata.var_9b24221d187bbae1, rotationdata.var_5d16a8dff156656e, var_130cd8ac8a60f78f );
            }
            
            rotationdata.rotationstate = transitionprogress >= 1 ? 0 : rotationdata.rotationstate;
        }
        
        self.var_5b09b54c5605be78 = rotationdata.var_b5f2f4784a819a40;
        function_398bc9ee922d91fd( "forge_pap_ring_speed_sound", self.var_5b09b54c5605be78[ 2 ] );
        
        if ( var_326d16e084dd3fb2 )
        {
            if ( var_963849c05482fbc6 && ( transitionprogress >= 1 || rotationdata.rotationstate == 3 ) )
            {
                rotationdata.var_cb1c180e2300b93 = var_963849c05482fbc6;
            }
            else
            {
                rotationdata.var_cb1c180e2300b93 += rotationdata.var_b5f2f4784a819a40;
            }
            
            self rotateto( rotationdata.var_cb1c180e2300b93, 0.1 );
            var_dc077e96fe91d86e = undefined;
        }
        else if ( !var_dc077e96fe91d86e || utility::time_has_passed( var_dc077e96fe91d86e, rotationdata.rotationduration ) )
        {
            var_a0cecc9a38ab1aca = ( rotationdata.var_b5f2f4784a819a40[ 0 ] * 10, rotationdata.var_b5f2f4784a819a40[ 1 ] * 10, rotationdata.var_b5f2f4784a819a40[ 2 ] * 10 );
            self rotatevelocity( var_a0cecc9a38ab1aca, rotationdata.rotationduration, 0, 0 );
            var_dc077e96fe91d86e = gettime();
        }
        
        if ( function_6bee0776a9b2f31b( self.earthquake_scale, self.earthquake_radius, self.override_rumble ) )
        {
            level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent notify( #"stop_camera_shake_rumber" );
            earthquake_scale = self.earthquake_scale ?? 0.1;
            earthquake_radius = self.earthquake_radius ?? 800;
            override_rumble = self.override_rumble;
            level.scarab_pap_quest.var_9d15330b141fe52f.var_1893d0bddf221db3 = { #override_rumble:override_rumble, #earthquake_radius:earthquake_radius, #earthquake_scale:earthquake_scale };
            
            if ( !isdefined( override_rumble ) )
            {
                level.scarab_pap_quest.var_9d15330b141fe52f.var_dee86a2ab4bb62b5 = 0;
                level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent thread zm_quest::function_640be494549054c8( earthquake_scale, earthquake_radius );
            }
            else
            {
                level.scarab_pap_quest.var_9d15330b141fe52f.var_dee86a2ab4bb62b5 = 1;
                level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent thread zm_quest::function_6c4de661b29fc88c( earthquake_scale, earthquake_radius, override_rumble );
            }
        }
        
        wait 0.1;
        rotationdata.timepassed = utility::function_6f5d2e1f1ff70482( gettime() - rotationdata.starttimems + savedholdtime );
    }
    
    if ( !var_326d16e084dd3fb2 || var_dc077e96fe91d86e )
    {
        var_a0cecc9a38ab1aca = ( rotationdata.var_b5f2f4784a819a40[ 0 ] * 10, rotationdata.var_b5f2f4784a819a40[ 1 ] * 10, rotationdata.var_b5f2f4784a819a40[ 2 ] * 10 );
        self rotatevelocity( var_a0cecc9a38ab1aca, 0.05, 0, 0 );
    }
    else
    {
        var_834aeafffde162ba = rotationdata.var_419751d3bcb66d1f ?? rotationdata.var_cb1c180e2300b93;
        var_834aeafffde162ba = ( function_63a2ef74ebcc6413( var_834aeafffde162ba[ 0 ] ), function_63a2ef74ebcc6413( var_834aeafffde162ba[ 1 ] ), function_63a2ef74ebcc6413( var_834aeafffde162ba[ 2 ] ) );
        self rotateto( var_834aeafffde162ba, 0.05 );
    }
    
    wait 0.05;
    
    if ( self.var_65610b2f215ff340 != rotation_thread_id )
    {
        return;
    }
    
    set_ring_rotation_speed();
    level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent notify( #"stop_camera_shake_rumber" );
    level.scarab_pap_quest.var_9d15330b141fe52f.var_dee86a2ab4bb62b5 = 0;
    level.scarab_pap_quest.var_9d15330b141fe52f.var_1893d0bddf221db3 = undefined;
    
    if ( var_ad43382b4c4ea305 )
    {
        earthquake( 0.2, 1, level.scarab_pap_quest.var_9d15330b141fe52f.origin, 1200 );
        players = getplayersinradius( level.scarab_pap_quest.var_9d15330b141fe52f.origin, 1000 );
        
        foreach ( player in players )
        {
            if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
            {
                continue;
            }
            
            player playrumbleonentity( "damage_heavy" );
        }
    }
    
    self.var_5b09b54c5605be78 = undefined;
    utility::ent_flag_clear( "is_ring_rotating" );
    utility::ent_flag_clear( "stop_rotating_ring_natural" );
    self notify( #"hash_a756f9bf6c6f6058" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xa40131e3, Offset: 0x11f16
// Size: 0x78
function private function_92773fb518bb06ad( n_time = 2 )
{
    rotate_angle_x = self == level.scarab_pap_quest.var_dbdff7ad02b59f6b ? 60 : -60;
    targetangles = ( function_63a2ef74ebcc6413( rotate_angle_x - self.angles[ 1 ] ), 0, 0 );
    self rotateto( targetangles, n_time );
    wait n_time;
    self notify( #"rotateToDefaultStart_complete" );
}

// Namespace zm_sat_scarab_pap_quest
// Params 3, eflags: 0x4
// Checksum 0xbe149237, Offset: 0x11f96
// Size: 0xc8
function private function_81b808b9378f39c6( var_3c9d7fe0d5ce8228, rotationduration, var_26f563b3b61de737 )
{
    if ( !var_26f563b3b61de737 || var_26f563b3b61de737 <= 0 )
    {
        return;
    }
    
    var_27c258f2df5fbada = function_4f23ae97a36eb534( var_3c9d7fe0d5ce8228, rotationduration );
    
    if ( !isdefined( var_27c258f2df5fbada ) )
    {
        self.var_5b09b54c5605be78 = ( 0, 0, 0 );
        return;
    }
    
    var_e20f2977a3ea2cab = 0.25;
    reverseblendtime = 0.16;
    var_3b5450247e8716c7 = ( var_27c258f2df5fbada[ 0 ] * -1 * var_e20f2977a3ea2cab, var_27c258f2df5fbada[ 1 ] * -1 * var_e20f2977a3ea2cab, var_27c258f2df5fbada[ 2 ] * -1 * var_e20f2977a3ea2cab );
    self rotateto( self.angles + var_3b5450247e8716c7, reverseblendtime );
    wait reverseblendtime;
    self.var_5b09b54c5605be78 = var_3b5450247e8716c7;
}

// Namespace zm_sat_scarab_pap_quest
// Params 6
// Checksum 0x199ae932, Offset: 0x12066
// Size: 0x140
function set_ring_rotation_speed( var_3c9d7fe0d5ce8228, rotationduration, var_26f563b3b61de737 = 0, var_a0c8e4d1ee06f053, var_343d5244dc31aede, var_1893d0bddf221db3 )
{
    if ( !utility::ent_flag( "is_ring_rotating" ) )
    {
        return;
    }
    
    if ( var_3c9d7fe0d5ce8228 && rotationduration )
    {
        self.var_3c9d7fe0d5ce8228 = var_3c9d7fe0d5ce8228;
        self.rotationduration = rotationduration;
        self.var_26f563b3b61de737 = var_26f563b3b61de737;
        self.var_a0c8e4d1ee06f053 = var_a0c8e4d1ee06f053;
        self.var_343d5244dc31aede = var_343d5244dc31aede;
        self.earthquake_scale = var_1893d0bddf221db3.earthquake_scale;
        self.earthquake_radius = var_1893d0bddf221db3.earthquake_radius;
        self.override_rumble = var_1893d0bddf221db3.override_rumble;
        return;
    }
    
    self.var_46b01c34f2f3d98c = undefined;
    self.var_b469b6a3bd1533fa = undefined;
    self.var_cc0850c9fe11691d = undefined;
    self.var_3c9d7fe0d5ce8228 = undefined;
    self.rotationduration = undefined;
    self.var_26f563b3b61de737 = undefined;
    self.var_a0c8e4d1ee06f053 = undefined;
    self.var_343d5244dc31aede = undefined;
    self.earthquake_scale = undefined;
    self.earthquake_radius = undefined;
    self.override_rumble = undefined;
}

// Namespace zm_sat_scarab_pap_quest
// Params 3
// Checksum 0xb56cde8b, Offset: 0x121ae
// Size: 0x228
function function_3dcd857bd322e457( b_immediate = 0, var_4c534208d49e5d2e, var_cc0850c9fe11691d )
{
    var_7310ab5ed2bc2339 = [ level.scarab_pap_quest.var_dbdff7ad02b59f6b, level.scarab_pap_quest.var_dbdff8ad02b5a19e ];
    
    foreach ( var_6b188b2a9854e5d8 in var_7310ab5ed2bc2339 )
    {
        if ( !var_6b188b2a9854e5d8 utility::ent_flag( "is_ring_rotating" ) )
        {
            continue;
        }
        
        var_6b188b2a9854e5d8.var_46b01c34f2f3d98c = undefined;
        var_6b188b2a9854e5d8.var_b469b6a3bd1533fa = undefined;
        var_6b188b2a9854e5d8.var_cc0850c9fe11691d = undefined;
        
        if ( b_immediate )
        {
            level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent notify( #"stop_camera_shake_rumber" );
            level.scarab_pap_quest.var_9d15330b141fe52f.var_dee86a2ab4bb62b5 = 0;
            level.scarab_pap_quest.var_9d15330b141fe52f.var_1893d0bddf221db3 = undefined;
            var_6b188b2a9854e5d8 notify( #"hash_4988b7bc41d672ad" );
            var_6b188b2a9854e5d8 rotatevelocity( ( 0, 0, 0 ), 0.05, 0, 0 );
            wait 0.05;
            var_6b188b2a9854e5d8 utility::ent_flag_clear( "is_ring_rotating" );
            var_6b188b2a9854e5d8 utility::ent_flag_clear( "stop_rotating_ring_natural" );
            var_6b188b2a9854e5d8.var_5b09b54c5605be78 = undefined;
            continue;
        }
        
        if ( isdefined( var_4c534208d49e5d2e ) && isdefined( var_cc0850c9fe11691d ) )
        {
            var_6b188b2a9854e5d8.var_46b01c34f2f3d98c = function_63a2ef74ebcc6413( var_4c534208d49e5d2e - var_6b188b2a9854e5d8.angles );
            var_6b188b2a9854e5d8.var_b469b6a3bd1533fa = ( function_63a2ef74ebcc6413( var_4c534208d49e5d2e[ 0 ] ), function_63a2ef74ebcc6413( var_4c534208d49e5d2e[ 1 ] ), function_63a2ef74ebcc6413( var_4c534208d49e5d2e[ 2 ] ) );
            var_6b188b2a9854e5d8.var_cc0850c9fe11691d = var_cc0850c9fe11691d;
        }
        
        var_6b188b2a9854e5d8 utility::ent_flag_set( "stop_rotating_ring_natural" );
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xec57f5af, Offset: 0x123de
// Size: 0x542
function private function_67cb66d8c9877245( rotationdata )
{
    if ( utility::ent_flag( "stop_rotating_ring_natural" ) && isdefined( self.var_b469b6a3bd1533fa ) && isdefined( self.var_cc0850c9fe11691d ) )
    {
        if ( rotationdata.rotationstate == 3 )
        {
            rotationdata.var_9b24221d187bbae1 = self.var_5b09b54c5605be78 ?? rotationdata.var_b5f2f4784a819a40;
            return rotationdata;
        }
        
        rotationstate = 3;
    }
    else if ( rotationdata.var_a0c8e4d1ee06f053 )
    {
        if ( rotationdata.timepassed < rotationdata.rotationduration )
        {
            return rotationdata;
        }
        
        var_70b1fb30a8a3e2eb = ( 0, 0, 360 / ( self == level.scarab_pap_quest.var_dbdff7ad02b59f6b ? 12 : 6 ) * 0.1 );
        
        if ( rotationdata.var_5d16a8dff156656e == var_70b1fb30a8a3e2eb )
        {
            return rotationdata;
        }
        
        rotationstate = 2;
    }
    else if ( rotationdata.var_26f563b3b61de737 || self.var_3c9d7fe0d5ce8228 && self.rotationduration )
    {
        var_eca36b13cc113156 = function_4f23ae97a36eb534( self.var_3c9d7fe0d5ce8228, self.rotationduration );
        var_aacdeaf8b9773cd6 = function_4f23ae97a36eb534( rotationdata.var_bb3b62ecc73c5620, rotationdata.var_b6adabcd2c81f80 );
        
        if ( rotationdata.var_5d16a8dff156656e == var_eca36b13cc113156 || rotationdata.var_5d16a8dff156656e == var_aacdeaf8b9773cd6 )
        {
            return rotationdata;
        }
        
        if ( rotationdata.var_b8ee7b73eae0d9f8 )
        {
            var_ce7225f184718a0d = rotationdata;
        }
        
        rotationstate = 1;
    }
    else
    {
        rotationdata.rotationstate = 0;
        rotationdata.var_9b24221d187bbae1 = self.var_5b09b54c5605be78 ?? rotationdata.var_b5f2f4784a819a40;
        return rotationdata;
    }
    
    rotationdata = var_ce7225f184718a0d ?? {};
    rotationdata.rotationstate = rotationstate;
    rotationdata.starttimems = gettime();
    rotationdata.timepassed = 0;
    
    switch ( rotationdata.rotationstate )
    {
        case 3:
            rotationdata.rotationduration = self.var_cc0850c9fe11691d;
            rotationdata.var_26f563b3b61de737 = self.var_cc0850c9fe11691d;
            rotationdata.var_5fcb1c9586d1e7a0 = self.angles;
            rotationdata.var_cb1c180e2300b93 = self.angles;
            rotationdata.var_419751d3bcb66d1f = anglelerpquatfrac( self.angles, self.var_b469b6a3bd1533fa, 1 );
            rotationdata.var_518579d90f2a2deb = self.angles;
            rotationdata.var_b5f2f4784a819a40 = ( 0, 0, 0 );
            rotationdata.var_5d16a8dff156656e = ( 0, 0, 0 );
            rotationdata.var_c9f3cc25b9f1c6b1 = 0;
            break;
        case 2:
            rotationdata.rotationduration = self == level.scarab_pap_quest.var_dbdff7ad02b59f6b ? 12 : 6;
            rotationdata.var_26f563b3b61de737 = self.var_343d5244dc31aede ?? 3;
            rotationdata.var_cb1c180e2300b93 = self.angles;
            rotationdata.var_b5f2f4784a819a40 = ( 0, 0, 360 / ( self == level.scarab_pap_quest.var_dbdff7ad02b59f6b ? 12 : 6 ) * 0.1 );
            rotationdata.var_5d16a8dff156656e = ( 0, 0, 360 / ( self == level.scarab_pap_quest.var_dbdff7ad02b59f6b ? 12 : 6 ) * 0.1 );
            rotationdata.var_c9f3cc25b9f1c6b1 = 1;
            rotationdata.var_a0c8e4d1ee06f053 = 1;
            set_ring_rotation_speed();
            break;
        case 1:
            var_1d1637deea619655 = rotationdata.var_bb3b62ecc73c5620 ?? self.var_3c9d7fe0d5ce8228 ?? ( 0, 0, 0 );
            var_9a9183a0a195f031 = rotationdata.var_b6adabcd2c81f80 ?? self.rotationduration ?? 0.5;
            var_97b8381e291e1707 = function_4f23ae97a36eb534( var_1d1637deea619655, var_9a9183a0a195f031 );
            rotationdata.rotationduration = var_9a9183a0a195f031;
            
            if ( !isdefined( rotationdata.var_26f563b3b61de737 ) )
            {
                rotationdata.var_26f563b3b61de737 = self.var_26f563b3b61de737 ?? 3;
            }
            
            rotationdata.var_cb1c180e2300b93 = self.angles;
            rotationdata.var_b5f2f4784a819a40 = var_97b8381e291e1707;
            rotationdata.var_5d16a8dff156656e = var_97b8381e291e1707;
            rotationdata.var_c9f3cc25b9f1c6b1 = !self.var_a0c8e4d1ee06f053;
            rotationdata.var_a0c8e4d1ee06f053 = self.var_a0c8e4d1ee06f053;
            break;
        default:
            break;
    }
    
    rotationdata.var_9b24221d187bbae1 = self.var_5b09b54c5605be78 ?? rotationdata.var_b5f2f4784a819a40;
    return rotationdata;
}

// Namespace zm_sat_scarab_pap_quest
// Params 3, eflags: 0x4
// Checksum 0x2f40a9f6, Offset: 0x12929
// Size: 0x1ae, Type: bool
function private function_6bee0776a9b2f31b( earthquake_scale = 0.1, earthquake_radius = 800, override_rumble )
{
    if ( level.scarab_pap_quest.var_9d15330b141fe52f.dont_shake_and_rumble )
    {
        level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent notify( #"stop_camera_shake_rumber" );
        level.scarab_pap_quest.var_9d15330b141fe52f.var_dee86a2ab4bb62b5 = 0;
        level.scarab_pap_quest.var_9d15330b141fe52f.var_1893d0bddf221db3 = undefined;
        return false;
    }
    
    if ( level.scarab_pap_quest.var_9d15330b141fe52f.var_1893d0bddf221db3.earthquake_scale == earthquake_scale && level.scarab_pap_quest.var_9d15330b141fe52f.var_1893d0bddf221db3.earthquake_radius == earthquake_radius && level.scarab_pap_quest.var_9d15330b141fe52f.var_1893d0bddf221db3.override_rumble == override_rumble )
    {
        return false;
    }
    
    if ( level.scarab_pap_quest.var_9d15330b141fe52f.var_dee86a2ab4bb62b5 )
    {
        level.scarab_pap_quest.var_9d15330b141fe52f.linkedparent notify( #"stop_camera_shake_rumber" );
        level.scarab_pap_quest.var_9d15330b141fe52f.var_dee86a2ab4bb62b5 = 0;
    }
    
    return true;
}

// Namespace zm_sat_scarab_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xfb969131, Offset: 0x12ae0
// Size: 0x4a
function private function_4f23ae97a36eb534( var_3c9d7fe0d5ce8228, rotationduration )
{
    if ( !var_3c9d7fe0d5ce8228 || !rotationduration )
    {
        return;
    }
    
    return ( var_3c9d7fe0d5ce8228[ 0 ] / rotationduration * 0.1, var_3c9d7fe0d5ce8228[ 1 ] / rotationduration * 0.1, var_3c9d7fe0d5ce8228[ 2 ] / rotationduration * 0.1 );
}

// Namespace zm_sat_scarab_pap_quest
// Params 0, eflags: 0xc
// Checksum 0x2cbc5329, Offset: 0x12b33
// Size: 0x6c0
function private function_670d5dff684f3a88()
{
    self notify( #"hash_49417bc7d122f41b" );
    self endon( #"hash_49417bc7d122f41b" );
    level endon( #"game_ended" );
    self endon( #"death", #"hash_4988b7bc41d672ad", #"hash_a756f9bf6c6f6058" );
    
    while ( true )
    {
        var_4d9e62025d53284e = getplayersandaiarrayinradius( self.origin, 600 );
        
        foreach ( var_c00d6d974cf57fc0 in var_4d9e62025d53284e )
        {
            if ( !var_c00d6d974cf57fc0 istouching( self ) )
            {
                continue;
            }
            
            if ( !isalive( var_c00d6d974cf57fc0 ) )
            {
                continue;
            }
            
            if ( isplayer( var_c00d6d974cf57fc0 ) )
            {
                if ( var_c00d6d974cf57fc0 isnoclip() )
                {
                    continue;
                }
                
                if ( var_c00d6d974cf57fc0.ismutantinjection )
                {
                    continue;
                }
                
                if ( var_c00d6d974cf57fc0.var_54f5b0babe253b59 && !utility::time_has_passed( var_c00d6d974cf57fc0.var_54f5b0babe253b59, 1.5 ) )
                {
                    continue;
                }
                
                idamage = 0.25 * var_c00d6d974cf57fc0.maxhealth;
                var_c00d6d974cf57fc0 dodamage( idamage, var_c00d6d974cf57fc0.origin, var_c00d6d974cf57fc0, self, "MOD_UNKNOWN", undefined, undefined, undefined, 536936448 );
                var_c00d6d974cf57fc0 playsoundtoplayer( #"hash_243177545366ba48", var_c00d6d974cf57fc0 );
                
                if ( !isdefined( var_c00d6d974cf57fc0.shockname ) )
                {
                    var_c00d6d974cf57fc0 thread shellshock_utility_cpmp::_shellshock( %"sat_concussion_grenade_mp", #"stun", 2, 1 );
                }
                
                var_c00d6d974cf57fc0 val::set( "forge_ring_struck", "show_hud", 0 );
                var_c00d6d974cf57fc0 thread utility::delaythread( 1.8, &val::set, "forge_ring_struck", "show_hud", 1 );
                var_c00d6d974cf57fc0.var_54f5b0babe253b59 = gettime();
                continue;
            }
            
            if ( var_c00d6d974cf57fc0 zombie_utils::function_bf1464d09f4e4b40() )
            {
                continue;
            }
            
            if ( var_c00d6d974cf57fc0.aicategory == "hvt" || var_c00d6d974cf57fc0.aicategory == "special" || var_c00d6d974cf57fc0.aicategory == "elite" )
            {
                if ( var_c00d6d974cf57fc0.var_54f5b0babe253b59 && var_c00d6d974cf57fc0.var_f4fd3c591fbc2d74 && !utility::time_has_passed( var_c00d6d974cf57fc0.var_54f5b0babe253b59, var_c00d6d974cf57fc0.var_f4fd3c591fbc2d74 ) )
                {
                    continue;
                }
                
                level.scarab_pap_quest.var_3beeb295fe09e9bf = function_46f9072493651dc9( level.scarab_pap_quest.var_3beeb295fe09e9bf );
                level.scarab_pap_quest.var_3beeb295fe09e9bf = function_5713d46873b29625( level.scarab_pap_quest.var_3beeb295fe09e9bf );
                var_c00d6d974cf57fc0.var_54f5b0babe253b59 = gettime();
                var_bf0297981c567ea7 = self.var_3dfb48cd2da760ed && !arraycontains( level.scarab_pap_quest.var_3beeb295fe09e9bf, var_c00d6d974cf57fc0 );
                
                if ( var_c00d6d974cf57fc0.aicategory == "hvt" || var_c00d6d974cf57fc0.aicategory == "elite" && !var_bf0297981c567ea7 )
                {
                    var_c00d6d974cf57fc0.var_f4fd3c591fbc2d74 = 3;
                    idamage = 0.1 * var_c00d6d974cf57fc0.maxhealth;
                }
                else if ( var_c00d6d974cf57fc0.aicategory == "special" && var_c00d6d974cf57fc0 zombie_knockdown::function_99b2020a564d9c7e( var_c00d6d974cf57fc0.origin ) )
                {
                    var_c00d6d974cf57fc0.var_f4fd3c591fbc2d74 = 3;
                    
                    if ( var_c00d6d974cf57fc0 zombie_knockdown::function_19d6107cb6bdff5c() )
                    {
                        continue;
                    }
                    
                    vdir = vectornormalize( level.scarab_pap_quest.var_9d15330b141fe52f.origin - var_c00d6d974cf57fc0.origin );
                    var_c00d6d974cf57fc0 thread zombie_knockdown::function_6fc167d4a3590991( var_c00d6d974cf57fc0.origin - vdir, 300 );
                }
                else
                {
                    var_c00d6d974cf57fc0.var_f4fd3c591fbc2d74 = 3;
                    
                    if ( var_c00d6d974cf57fc0 asmgetcurrentstate( var_c00d6d974cf57fc0.asmname ) == "stun_in" || var_c00d6d974cf57fc0 asmgetcurrentstate( var_c00d6d974cf57fc0.asmname ) == "stun_prep" )
                    {
                        continue;
                    }
                    
                    var_c00d6d974cf57fc0 zombie_stun::stun_ai( 0.3 );
                    
                    if ( var_c00d6d974cf57fc0.aicategory == "elite" )
                    {
                        level.scarab_pap_quest.var_3beeb295fe09e9bf = arraycombineunique( level.scarab_pap_quest.var_3beeb295fe09e9bf, [ var_c00d6d974cf57fc0 ] );
                    }
                }
                
                if ( !isdefined( var_c00d6d974cf57fc0.var_f4fd3c591fbc2d74 ) )
                {
                    var_c00d6d974cf57fc0.var_f4fd3c591fbc2d74 = 3;
                }
                
                damageperc = var_c00d6d974cf57fc0.aicategory == "special" ? 0.2 : 0.1;
                idamage = damageperc * var_c00d6d974cf57fc0.maxhealth;
            }
            else
            {
                idamage = var_c00d6d974cf57fc0.health + 1;
            }
            
            if ( var_c00d6d974cf57fc0.health - idamage <= 0 )
            {
                var_c00d6d974cf57fc0.forceannihilate = 1;
                var_c00d6d974cf57fc0.var_a13bed1ac47e1b2c = 1;
                var_c00d6d974cf57fc0.no_powerups = 1;
                var_c00d6d974cf57fc0 utility::ent_flag_set( "forge_ring_struck" );
                
                if ( self.var_3dfb48cd2da760ed )
                {
                    var_c00d6d974cf57fc0.kiastring = #"zombie_kia_mission_kill";
                    
                    foreach ( player in var_c00d6d974cf57fc0.a_n_player_damage )
                    {
                        if ( player == self.var_2bda94460d5b5cae )
                        {
                            var_c00d6d974cf57fc0.a_n_player_damage = arrayremove( var_c00d6d974cf57fc0.a_n_player_damage, player );
                        }
                    }
                    
                    var_c00d6d974cf57fc0.b_cleanup_no_respawn = 1;
                    var_c00d6d974cf57fc0.var_15598d8e493afe88 = 1;
                }
                else
                {
                    var_c00d6d974cf57fc0 zm_cleanup_manager::function_dd62e2042418b7e5();
                }
            }
            
            eattacker = namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( self.var_2bda94460d5b5cae ) ? self.var_2bda94460d5b5cae : self;
            var_c00d6d974cf57fc0 dodamage( idamage, var_c00d6d974cf57fc0.origin, eattacker, self, "MOD_UNKNOWN", undefined, undefined, undefined, 536936448 );
            var_c00d6d974cf57fc0 playsound( #"hash_5241922ed983763d" );
            waitframe();
        }
        
        var_f089e9fea8462fc5 = get_sentients( self );
        function_d7f112c494a55aee( var_f089e9fea8462fc5 );
        waitframe();
    }
}

// Namespace zm_sat_scarab_pap_quest
// Params 1
// Checksum 0x1c707c3c, Offset: 0x131fb
// Size: 0x117
function get_sentients( var_6b188b2a9854e5d8 )
{
    var_f089e9fea8462fc5 = sentientpoolmanager::function_ad3d873516899a0e();
    var_f089e9fea8462fc5 = arraycombineunique( var_f089e9fea8462fc5, level.grenades, level.missiles, weapon::function_3aafcaf7ff6dea9e(), level.activekillstreaks, level.vehicle.all, level.cratedata.crates );
    var_f089e9fea8462fc5 = function_5713d46873b29625( var_f089e9fea8462fc5 );
    var_f089e9fea8462fc5 = function_6a293b884c444a20( var_f089e9fea8462fc5, var_6b188b2a9854e5d8.origin, 600 );
    
    foreach ( sentient in var_f089e9fea8462fc5 )
    {
        if ( sentient istouching( self ) )
        {
            continue;
        }
        
        if ( self istouching( sentient ) )
        {
            continue;
        }
        
        var_f089e9fea8462fc5 = arrayremove( var_f089e9fea8462fc5, sentient );
    }
    
    return var_f089e9fea8462fc5;
}

// Namespace zm_sat_scarab_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x6271e3a0, Offset: 0x1331b
// Size: 0x26b
function private function_d7f112c494a55aee( var_f089e9fea8462fc5 )
{
    profilestart();
    
    foreach ( sentient in var_f089e9fea8462fc5 )
    {
        if ( sentient.equipmentref == "equip_mini_sentry" )
        {
            sentient thread namespace_e6861a39b2264899::on_destruction();
            continue;
        }
        
        if ( sentient.streakname == "dawg" )
        {
            sentient.owner notify( #"killstreak_cancel" );
            sentient thread dawg::dawg_self_destruct();
            continue;
        }
        
        if ( sentient.streakname == "remote_turret" )
        {
            sentient.owner notify( #"killstreak_cancel" );
            sentient notify( #"kill_turret", 1, 1, 0, 1 );
            continue;
        }
        
        if ( sentient.streakname == "rcxd" )
        {
            sentient.owner notify( #"killstreak_cancel" );
            sentient thread rcxd_shared::rcxd_explode();
            continue;
        }
        
        if ( sentient.equipmentref == "equip_smart_seeker" )
        {
            sentient thread smart_seeker::function_16e1c3f278107106();
            continue;
        }
        
        if ( sentient.equipmentref == "equip_combataxe" )
        {
            sentient [[ sentient.deletefunction ]]();
            continue;
        }
        
        if ( sentient.equipmentref == "equip_molotov" )
        {
            sentient molotov::molotov_burn_destroy( 1 );
            continue;
        }
        
        if ( sentient.equipmentref == "equip_shockstick" )
        {
            sentient shock_stick::function_5ea9a3b277397a1b();
            continue;
        }
        
        if ( sentient.health > 0 )
        {
            sentient notify( #"damage", sentient.health, level.players[ 0 ], ( 0, 0, 0 ), sentient.origin, "MOD_EXPLOSIVE_BULLET" );
            continue;
        }
        
        sentient delete();
        assert( !sentient, "<dev string:x1f5>" + sentient.code_classname + "<dev string:x206>" + ( sentient.equipmentref ?? sentient.streakname ?? "<dev string:x208>" ) );
    }
    
    profilestop();
}

/#

    // Namespace zm_sat_scarab_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x7420fd8b, Offset: 0x1358e
    // Size: 0x33e, Type: dev
    function private init_pap_debug()
    {
        level.scarab_pap_quest utility::ent_flag_wait( "<dev string:x20f>" );
        level.scarab_pap_quest.s_debug = spawnstruct();
        level.scarab_pap_quest.s_debug.var_7791633f076a1eb = 0;
        zm_quest::function_bc99f123a684344f( #"scarab_pap_quest" );
        devgui::add_devgui_func( "<dev string:x21e>", "<dev string:x235>", &function_82e6d91f80e896f6 );
        devgui::add_devgui_func( "<dev string:x24d>", "<dev string:x266>", &function_1e4aeecee09bfd77 );
        devgui::add_devgui_func( "<dev string:x280>", "<dev string:x29e>", &function_6299786dca1ae929 );
        devgui::add_devgui_func( "<dev string:x2bd>", "<dev string:x2e1>", &function_3a7a2cf1ca3c0b5e );
        devgui::add_devgui_func( "<dev string:x306>", "<dev string:x320>", &function_519908993c0df2dd );
        devgui::function_cd4e263c1f3018ae( "<dev string:x33b>", "<dev string:x359>", &function_a8b12cbff923961 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x36f>", "<dev string:x38b>", &function_a8b12cbff923961 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3a1>", "<dev string:x3c0>", &function_a8b12cbff923961 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3dc>", "<dev string:x3fc>", &function_a8b12cbff923961 );
        devgui::add_devgui_func( "<dev string:x419>", "<dev string:x42e>", &function_5af8ca85e62c844d );
        zm_quest::function_c1400a2f4670c23f();
        zm_quest::function_1b5b11caffa04d9a( #"scarab_pap_quest", #"hash_c7044385893e7295" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x444>", "<dev string:x459>", &function_13259d65955f7872 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x473>", "<dev string:x489>", &function_13259d65955f7872 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4a3>", "<dev string:x4bc>", &function_3e8121850657ad15 );
        
        for ( i = 2; i < level.scarab_pap_quest.s_skull_1.path_array.size ; i++ )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x4e1>" + i, "<dev string:x4f3>" + i, &function_628a915b0cf329f7 );
        }
        
        devgui::function_cd4e263c1f3018ae( "<dev string:x519>", "<dev string:x533>", &function_628a915b0cf329f7 );
        zm_quest::function_394bdba74beda0aa();
        zm_quest::function_1b5b11caffa04d9a( #"scarab_pap_quest", #"hash_c7044085893e6d7c" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x55a>", "<dev string:x56d>", &function_13259d65955f7872 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x587>", "<dev string:x59e>", &function_13259d65955f7872 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4a3>", "<dev string:x5b8>", &function_3e8121850657ad15 );
        
        for ( i = 2; i < level.scarab_pap_quest.s_skull_2.path_array.size ; i++ )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x4e1>" + i, "<dev string:x5dd>" + i, &function_628a915b0cf329f7 );
        }
        
        devgui::function_cd4e263c1f3018ae( "<dev string:x519>", "<dev string:x603>", &function_628a915b0cf329f7 );
        zm_quest::function_394bdba74beda0aa();
        zm_quest::function_1b5b11caffa04d9a( #"scarab_pap_quest", #"hash_402e0d074cc6f251" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x62a>", "<dev string:x63e>", &function_e2f42544ec64bc98 );
        zm_quest::function_394bdba74beda0aa();
        zm_quest::function_1b5b11caffa04d9a( #"scarab_pap_quest", #"hash_402e0a074cc6ed38" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x62a>", "<dev string:x656>", &function_e2f42544ec64bc98 );
        zm_quest::function_394bdba74beda0aa();
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 1, eflags: 0x4
    // Checksum 0x1a41395c, Offset: 0x138d4
    // Size: 0xb3, Type: dev
    function private function_5af8ca85e62c844d( sparams )
    {
        if ( !level.scarab_pap_quest.var_dbdff7ad02b59f6b utility::ent_flag( "<dev string:x66e>" ) )
        {
            level.scarab_pap_quest.var_dbdff7ad02b59f6b thread function_33cf59821e8c556c( ( 0, 0, 360 ), 12, 1, 2, undefined, 1 );
        }
        
        if ( !level.scarab_pap_quest.var_dbdff8ad02b5a19e utility::ent_flag( "<dev string:x66e>" ) )
        {
            level.scarab_pap_quest.var_dbdff8ad02b5a19e thread function_33cf59821e8c556c( ( 0, 0, 360 ), 6, 1, 2, undefined, 1 );
        }
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 1, eflags: 0x4
    // Checksum 0x8ae01b6e, Offset: 0x1398f
    // Size: 0x80, Type: dev
    function private function_a8b12cbff923961( sparams )
    {
        level endon( #"game_ended" );
        b_immediate = int( sparams[ 0 ] );
        
        if ( sparams[ 1 ] && sparams[ 2 ] && sparams[ 3 ] )
        {
            var_4c534208d49e5d2e = ( int( sparams[ 1 ] ), int( sparams[ 2 ] ), int( sparams[ 3 ] ) );
            var_cc0850c9fe11691d = 5;
        }
        
        level function_3dcd857bd322e457( b_immediate, var_4c534208d49e5d2e, var_cc0850c9fe11691d );
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 1, eflags: 0x4
    // Checksum 0xcc32c5b9, Offset: 0x13a17
    // Size: 0x107, Type: dev
    function private function_3e8121850657ad15( sparams )
    {
        level endon( #"game_ended" );
        var_1be5586316eb3191 = sparams[ 0 ] == #"hash_c7044385893e7295" ? level.scarab_pap_quest.s_skull_1 : level.scarab_pap_quest.s_skull_2;
        var_1be5586316eb3191 endon( #"hash_f9ff13038bbb13d4" );
        
        if ( !isdefined( var_1be5586316eb3191.var_7f2eb0a6d3eaed2e ) )
        {
            var_1be5586316eb3191.var_7f2eb0a6d3eaed2e = 0;
        }
        
        var_1be5586316eb3191.var_7f2eb0a6d3eaed2e = !var_1be5586316eb3191.var_7f2eb0a6d3eaed2e;
        
        while ( var_1be5586316eb3191.var_7f2eb0a6d3eaed2e && var_1be5586316eb3191.agent.e_mover )
        {
            var_1be5586316eb3191.agent.e_mover thread utility::draw_ent_axis( ( 0, 0, 0 ), getframeduration(), 2 );
            waitframe();
        }
        
        var_1be5586316eb3191 notify( #"hash_f9ff13038bbb13d4" );
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 1, eflags: 0x4
    // Checksum 0x53ff5413, Offset: 0x13b26
    // Size: 0x66, Type: dev
    function private function_13259d65955f7872( sparams )
    {
        var_1be5586316eb3191 = sparams[ 0 ] == #"hash_c7044385893e7295" ? level.scarab_pap_quest.s_skull_1 : level.scarab_pap_quest.s_skull_2;
        level function_b682da092f333992( var_1be5586316eb3191, int( sparams[ 1 ] ) );
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 1, eflags: 0x4
    // Checksum 0x8a28e377, Offset: 0x13b94
    // Size: 0xd4, Type: dev
    function private function_628a915b0cf329f7( sparams )
    {
        var_1be5586316eb3191 = sparams[ 0 ] == #"hash_c7044385893e7295" ? level.scarab_pap_quest.s_skull_1 : level.scarab_pap_quest.s_skull_2;
        path_idx = int( sparams[ 1 ] );
        
        if ( !isalive( var_1be5586316eb3191.agent ) )
        {
            iprintlnbold( "<dev string:x67f>" );
            return;
        }
        
        if ( path_idx <= var_1be5586316eb3191.node_idx )
        {
            iprintlnbold( "<dev string:x695>" );
            return;
        }
        
        if ( var_1be5586316eb3191.node_idx < 1 )
        {
            iprintlnbold( "<dev string:x6dc>" );
            return;
        }
        
        var_1be5586316eb3191.agent notify( #"skip_to", path_idx );
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 1, eflags: 0x4
    // Checksum 0xa517a76a, Offset: 0x13c70
    // Size: 0x20a, Type: dev
    function private function_e2f42544ec64bc98( sparams )
    {
        var_4ac035ac829f9a13 = sparams[ 0 ];
        current_quest_step = level.scarab_pap_quest.steps[ level.scarab_pap_quest.var_7be076c9078045aa ];
        
        if ( current_quest_step.ref == #"insert_seed" )
        {
            current_quest_step.var_d36be2d73e12f4fe = 1;
            level notify( #"hash_39da9feeb1e54eb9" );
            wait 0.5;
        }
        
        var_1be5586316eb3191 = var_4ac035ac829f9a13 == "<dev string:x708>" ? level.scarab_pap_quest.s_skull_1 : level.scarab_pap_quest.s_skull_2;
        
        while ( !var_1be5586316eb3191.var_87f8c6598b0699af )
        {
            level notify( "<dev string:x715>" + var_1be5586316eb3191.num );
            wait 1;
        }
        
        if ( !var_1be5586316eb3191.var_87f8c6598b0699af utility::ent_flag( "<dev string:x72c>" ) )
        {
            return;
        }
        
        closestplayer = undefined;
        closestdistsq = undefined;
        
        foreach ( player in level.players )
        {
            if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
            {
                continue;
            }
            
            distsq = distancesquared( var_1be5586316eb3191.var_87f8c6598b0699af.origin, player.origin );
            
            if ( !isdefined( closestdistsq ) || distsq < closestdistsq )
            {
                closestdistsq = distsq;
                closestplayer = player;
                break;
            }
        }
        
        level function_45b00b1b3a595819();
        var_1be5586316eb3191.var_87f8c6598b0699af.interact thread function_10f75cf5ef72a3fd( closestplayer );
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0xe2abd7, Offset: 0x13e82
    // Size: 0x75, Type: dev
    function private function_82e6d91f80e896f6()
    {
        level endon( #"game_ended" );
        level.scarab_pap_quest.s_debug.var_7791633f076a1eb = !level.scarab_pap_quest.s_debug.var_7791633f076a1eb;
        iprintlnbold( "<dev string:x733>" + level.scarab_pap_quest.s_debug.var_7791633f076a1eb );
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x36cba5f4, Offset: 0x13eff
    // Size: 0x23, Type: dev
    function private function_1e4aeecee09bfd77()
    {
        level endon( #"game_ended" );
        level thread set_power_surge();
        iprintlnbold( "<dev string:x74c>" );
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x8206bcf3, Offset: 0x13f2a
    // Size: 0xf5, Type: dev
    function private function_6299786dca1ae929()
    {
        level endon( #"game_ended" );
        var_e50a4e84ffa06c2a = arrayrandomize( level.scarab_pap_quest.var_c6b9e23aac03b4d0 );
        
        foreach ( var_4d376276647607c7 in var_e50a4e84ffa06c2a )
        {
            if ( var_4d376276647607c7 utility::ent_flag( "<dev string:x72c>" ) )
            {
                continue;
            }
            
            var_4d376276647607c7.var_3dfb48cd2da760ed = 1;
            var_4d376276647607c7 function_760e6888e3e99e1d( 1 );
            var_4d376276647607c7 utility::function_7c10ea82c1e305b8( "<dev string:x764>", "<dev string:x764>" );
            var_4d376276647607c7.dontreset = 1;
            break;
        }
        
        iprintlnbold( "<dev string:x280>" );
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0xbb236262, Offset: 0x14027
    // Size: 0xff, Type: dev
    function private function_3a7a2cf1ca3c0b5e()
    {
        level endon( #"game_ended" );
        
        foreach ( player in level.players )
        {
            brazier = level.scarab_pap_quest.var_c6b9e23aac03b4d0[ 0 ];
            brazier.var_3dfb48cd2da760ed = 1;
            brazier.dontreset = 1;
            brazier utility::function_7c10ea82c1e305b8( "<dev string:x764>", "<dev string:x764>" );
            
            if ( !brazier utility::ent_flag( "<dev string:x72c>" ) )
            {
                brazier function_760e6888e3e99e1d( 1 );
            }
            
            brazier function_10f75cf5ef72a3fd( player );
        }
        
        iprintlnbold( "<dev string:x2bd>" );
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x8ee29951, Offset: 0x1412e
    // Size: 0x112, Type: dev
    function private function_519908993c0df2dd()
    {
        foreach ( player in level.players )
        {
            brazier = level.scarab_pap_quest.var_c6b9e23aac03b4d0[ 0 ];
            brazier setscriptablepartstate( "<dev string:x76b>", "<dev string:x76e>" );
            brazier.var_3dfb48cd2da760ed = 1;
            brazier utility::function_7c10ea82c1e305b8( "<dev string:x764>", "<dev string:x764>" );
            brazier.dontreset = 1;
            brazier utility::ent_flag_set( "<dev string:x77a>" );
            
            if ( !brazier utility::ent_flag( "<dev string:x72c>" ) )
            {
                brazier function_760e6888e3e99e1d( 1 );
            }
            
            brazier function_10f75cf5ef72a3fd( player );
        }
        
        iprintlnbold( "<dev string:x2bd>" );
    }

    // Namespace zm_sat_scarab_pap_quest
    // Params 5, eflags: 0x4
    // Checksum 0x80f0293b, Offset: 0x14248
    // Size: 0xca, Type: dev
    function private function_e3544cbc1726eebb( speedscale, targetspeedscale, var_b7a83c120c2a977b, var_ae007d03d938d588, movetopoint )
    {
        if ( speedscale >= var_b7a83c120c2a977b )
        {
            color = ( 0, 0, 1 );
        }
        else if ( speedscale <= 1 )
        {
            color = ( 1, 0, 0 );
        }
        else if ( targetspeedscale > var_ae007d03d938d588 )
        {
            color = ( 0, 1, 0 );
        }
        else if ( targetspeedscale < var_ae007d03d938d588 )
        {
            color = ( 1, 1, 0 );
        }
        
        line( self.agent.e_mover.origin, movetopoint, color, 1, 0, 400 );
    }

#/
