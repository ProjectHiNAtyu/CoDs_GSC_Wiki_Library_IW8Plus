// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_ww_quest.gsc  (hash_42a67cdbe133ce0d.gscc) (size: 87449 Bytes / 0x15599 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd947f35b (3645371227)
// size ...... 87449 (0x15599)
// includes .. 42  (offset: 0x13e5d)
// strings ... 262 (offset: 0x13fad)
// dev strs .. 38  (offset: 0x1537d)
// exports ... 88  (offset: 0xf481)
// cseg ...... 0x13db + 0xe0a6 (0xf481)
// imports ... 415 (offset: 0x10241)
// animtree1 . 0   (offset: 0x15599)
// animtree2 . 0   (offset: 0x15599)
#using script_aa3bac81ad4fc8e;
#using script_ac28d65e8605696;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_loot_consume;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\weapons\weap_fireflyww;
#using scripts\mp\common\weapons\weap_manglercannon;
#using scripts\mp\doorbuy;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\movers;
#using scripts\mp\overlord;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_mq;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_pluto_upgrade;
#using scripts\mp\zm\points;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_urchin;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\traps\trap_core;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_firefly_ww_quest;

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x5
// Checksum 0x42067d67, Offset: 0x13f9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_ww_quest", undefined, undefined, &init );
}

// Namespace zm_sat_firefly_ww_quest
// Params 0
// Checksum 0x66f9e824, Offset: 0x141a
// Size: 0x252
function init()
{
    if ( getdvarint( @"enable_firefly_ee", 0 ) )
    {
        level._effect[ "aether_canister_cam_vfx" ] = loadfxasset( "vfx_t10_levels_zm_garnet_aether_cannister_carrying_cam" );
        level._effect[ "zombie_impact" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact" );
        level._effect[ "zombie_impact_blood" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact_blood" );
        level._effect[ "zombie_impact_purple" ] = loadfxasset( "vfx_sat_firefly_wwq_zmb_death_purple" );
        level._effect[ "wonder_energy_pulse" ] = loadfxasset( "vfx_sat_firefly_wwq_vehicle_pulse" );
        level._effect[ "aether_energy_trail" ] = loadfxasset( "vfx_sat_zm_firefly_wwq_vault_energy_absorb_trail" );
        level._effect[ "ww_teleport" ] = loadfxasset( "vfx_sat_zm_firefly_wwq_creature_teleport_fail" );
        level._effect[ "bio_scan" ] = loadfxasset( "vfx_sat_firefly_wwq_light_beam" );
        level._effect[ "bio_scan_circle" ] = loadfxasset( "vfx_sat_firefly_wwq_circle_security_clearance" );
        level._effect[ "pickup_cover" ] = loadfxasset( "vfx_sat_zm_firefly_wwq_pickup_ambient" );
    }
    
    level utility::flag_wait_all( "zm_sat_firefly_script_quest_ww_cs_completed", "zm_quest_initialized", "scriptables_ready", "doorbuy_init_complete" );
    level utility::registersharedfunc( #"zm_quest", #"hash_85468165ad5b3400", &is_ww_quest_complete );
    level.firefly_ww_quest = zm_quest::get_quest( #"firefly_ww_quest" );
    level init_ww_quest_items();
    
    if ( isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "wwQuest" ) )
    {
        return;
    }
    
    level init_ww_quest_steps();
    level magicbox::function_2e49cd8681e36211( 1 );
    
    if ( getdvarint( @"enable_firefly_ee", 0 ) )
    {
        level zm_save::function_1f44a48caae2acbf();
        var_7be076c9078045aa = level.firefly_ww_quest.steps[ level.firefly_ww_quest.var_7be076c9078045aa ];
        
        if ( zm_save::function_fcccc3d2a616b1c7() && !level zm_quest::function_73720cdf21c3cfd7( #"firefly_ww_quest", #"ab_grabbed" ) && var_7be076c9078045aa.ref == #"setup_delivery" )
        {
            level.pluto_upgrade_quest utility::ent_flag_set( "block_update_guidance" );
        }
        
        level thread zm_quest::start_quest( #"firefly_ww_quest" );
    }
    
    /#
        level thread ww_debug_init();
    #/
}

// Namespace zm_sat_firefly_ww_quest
// Params 0
// Checksum 0x2ee6ac26, Offset: 0x1674
// Size: 0x11
function is_ww_quest_complete()
{
    return zm_quest::is_quest_complete( #"firefly_ww_quest" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xa676edfe, Offset: 0x168e
// Size: 0x177
function private init_ww_quest_steps()
{
    zm_quest::function_3c363613c60958f5( "firefly_ww_quest" );
    zm_quest::register_quest_step( #"firefly_ww_quest", #"hash_2ed7a5ae2e02ce96", &function_a6c039ae8e3916dd, &function_32a49f98f1839d9e );
    zm_quest::register_quest_step( #"firefly_ww_quest", #"hash_f9d5c7ccbdfca64", &function_a78eb023f8c4c11c );
    zm_quest::register_quest_step( #"firefly_ww_quest", #"hash_2dc50dfee0272f9a", &function_48583a540e1f7e6d );
    zm_quest::register_quest_step( #"firefly_ww_quest", #"hash_4bc27163c1adcce0", &function_74cf35cb8c233f73, &function_24096dec67918b3d );
    zm_quest::register_quest_step( #"firefly_ww_quest", #"setup_delivery", &function_5f27d14e40573b40 );
    zm_quest::register_quest_step( #"firefly_ww_quest", #"aether_energy_extraction", &function_fcb7efc858bb6055, &function_7de88cdb37253574 );
    zm_quest::register_quest_step( #"firefly_ww_quest", #"crazy_taxi", &crazy_taxi_setup, &crazy_taxi_cleanup );
    zm_quest::register_quest_step( #"firefly_ww_quest", #"unlock_symbol_lock", &symbol_lock_setup, &symbol_lock_cleanup );
    zm_quest::register_quest_step( #"firefly_ww_quest", #"hash_2628b3662d042f0c", &function_d17e280d6fac9f17 );
    zm_quest::register_quest_step( #"firefly_ww_quest", #"hash_ab5d1400594ebb61", &function_250933da8d3acb42, &function_d320084b93d98117 );
    zm_quest::register_quest_step( #"firefly_ww_quest", #"respawn_ww", undefined, &respawn_ww_cleanup );
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xdf8bf70, Offset: 0x180d
// Size: 0x1300
function private init_ww_quest_items()
{
    level.firefly_ww_quest.s_vault = spawnstruct();
    level.firefly_ww_quest.s_vault.sbl = utility::function_b3fc2f9ce7786d99( "fww_v", #targetname );
    
    if ( isent( level.firefly_ww_quest.s_vault.sbl ) && level.firefly_ww_quest.s_vault.sbl.model == "sat_zm_vault_flesh_01_active_fxanim" )
    {
        level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( "anim", "close_idle" );
    }
    
    var_f9855c557d11e49d = level zm_sat_firefly::function_24006873400b7a8() ? "idle" : "off";
    
    if ( !getdvarint( @"enable_firefly_ee", 0 ) )
    {
        var_f9855c557d11e49d = "off";
    }
    
    level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( "ping", var_f9855c557d11e49d );
    
    if ( !isdefined( level.firefly_ww_quest.s_vault.progress ) )
    {
        level.firefly_ww_quest.s_vault.progress = 0;
    }
    
    var_bb8ee5d831e6b4a1 = utility::getstruct( "fww_v_f_s", "targetname" );
    var_bb8ee5d831e6b4a1.group_number = 3;
    var_7d96177d66efadd5 = utility::getstruct( "fww_v_b_s", "targetname" );
    var_7d96177d66efadd5.group_number = 2;
    var_eab91b06ee73cea3 = utility::getstruct( "fww_v_l_s", "targetname" );
    var_eab91b06ee73cea3.group_number = 0;
    var_78a8544ddfb401ac = utility::getstruct( "fww_v_r_s", "targetname" );
    var_78a8544ddfb401ac.group_number = 1;
    level.firefly_ww_quest.var_e327c4bd0a3ed3fd = [];
    
    foreach ( s_doorbuy in level.a_s_doorbuys )
    {
        foreach ( door in s_doorbuy.interact.doors )
        {
            if ( door.targetname != "farm_barn_db" )
            {
                continue;
            }
            
            if ( door.model != "sat_zm_farm_float_03_fxanim" && door.model != "sat_construction_door_farm_barn_door_01" && door.model != "sat_construction_door_farm_barn_door_02" )
            {
                continue;
            }
            
            if ( door.model == "sat_construction_door_farm_barn_door_01" && door.minimap_scriptable.type != "zm_sat_doorbuy_ping" || door.model == "sat_construction_door_farm_barn_door_02" && door.minimap_scriptable.type != "cp_mp_doorbuy_minimap_double_door_pingable" )
            {
                continue;
            }
            
            door_to_add = door.model == "sat_zm_farm_float_03_fxanim" ? door : door.minimap_scriptable;
            level.firefly_ww_quest.var_e327c4bd0a3ed3fd = arraycombineunique( level.firefly_ww_quest.var_e327c4bd0a3ed3fd, [ door_to_add ] );
        }
    }
    
    level.firefly_ww_quest.var_e81a6e44cbb46236 = [ var_eab91b06ee73cea3, var_78a8544ddfb401ac, var_7d96177d66efadd5, var_bb8ee5d831e6b4a1 ];
    level.firefly_ww_quest.var_7beabd5eecea599c = utility::getstruct( "fww_sec_ab", "targetname" );
    level.firefly_ww_quest.var_7beabd5eecea599c.mdl = utility::spawn_model( %"sat_zm_aether_canister_dynamic_fxanim", level.firefly_ww_quest.var_7beabd5eecea599c.origin, level.firefly_ww_quest.var_7beabd5eecea599c.angles );
    level.firefly_ww_quest.var_7beabd5eecea599c.is_in_original_pos = 1;
    level.firefly_ww_quest.var_7beabd5eecea599c.interact = interaction::register_scriptable_interact( level.firefly_ww_quest.var_7beabd5eecea599c.mdl getlinkedscriptableinstance(), &ab_used, undefined, undefined, &ab_hint );
    level.firefly_ww_quest.var_7beabd5eecea599c.interact.mdl = level.firefly_ww_quest.var_7beabd5eecea599c.mdl;
    level.firefly_ww_quest.var_7beabd5eecea599c.interact.var_a7754bc017e65d98 = level.firefly_ww_quest.var_7beabd5eecea599c;
    level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "base", "cannot_use" );
    level.firefly_ww_quest.var_f9f72736451013bb = utility::getstruct( "fww_sec_c", "targetname" );
    level.firefly_ww_quest.s_security_door = utility::function_30dbabe3200518b( "fww_sec_d", #targetname );
    
    if ( !isdefined( level.firefly_ww_quest.s_security_door ) )
    {
        level.firefly_ww_quest.s_security_door = utility::getstruct( "fww_sec_d", "targetname" );
    }
    
    if ( level.firefly_ww_quest.s_security_door utility::function_de1f80d93273abf5() )
    {
        level.firefly_ww_quest.s_security_door.mdl = level.firefly_ww_quest.s_security_door;
    }
    
    if ( !isdefined( level.firefly_ww_quest.s_security_door.mdl ) )
    {
        level.firefly_ww_quest.s_security_door.mdl = utility::spawn_model( %"sat_zm_aether_barrel_storage_base", level.firefly_ww_quest.s_security_door.origin, level.firefly_ww_quest.s_security_door.angles );
    }
    
    level.firefly_ww_quest.var_6c1394a72bab48af = spawnstruct();
    level.firefly_ww_quest.var_6c1394a72bab48af.sbl = utility::function_30dbabe3200518b( "fww_sec_t", #targetname );
    level.firefly_ww_quest.var_6c1394a72bab48af.interact = interaction::register_scriptable_interact( level.firefly_ww_quest.var_6c1394a72bab48af.sbl, &function_81190209e33147f3, undefined, undefined, &function_444e1dc004601f3f );
    level.firefly_ww_quest.var_6c1394a72bab48af.interact.sbl = level.firefly_ww_quest.var_6c1394a72bab48af.sbl;
    level.firefly_ww_quest.var_6c1394a72bab48af.interact.var_a7754bc017e65d98 = level.firefly_ww_quest.var_6c1394a72bab48af;
    var_bd166e2aa5a0fd9d = level zm_sat_firefly::function_24006873400b7a8() ? "idle" : "off";
    
    if ( !getdvarint( @"enable_firefly_ee", 0 ) )
    {
        var_bd166e2aa5a0fd9d = "off";
    }
    
    level.firefly_ww_quest.var_6c1394a72bab48af.sbl utility::function_32b24db3127bff40( "ping", var_bd166e2aa5a0fd9d );
    level.firefly_ww_quest.var_adb8bdf91749de3 = utility::getstruct( "fww_sec_s", "targetname" );
    level.firefly_ww_quest.var_472676df8b3d0265 = getentarray( "wwq_storage_clip", #targetname );
    
    foreach ( clip in level.firefly_ww_quest.var_472676df8b3d0265 )
    {
        clip disconnectpaths();
        clip solid();
    }
    
    level.firefly_ww_quest.var_c1f736e2f66ad165 = utility::getstruct( "fww_t_ab", "targetname" );
    level.firefly_ww_quest.var_c1f736e2f66ad165.var_bb3cfcbf65750e32 = "power_on3";
    level.firefly_ww_quest.var_c1f736e2f66ad165.we_lgt = "we_lgt_power_on_ashwood";
    level.firefly_ww_quest.var_e923a8986534e479 = utility::getstruct( "fww_f_ab", "targetname" );
    level.firefly_ww_quest.var_e923a8986534e479.var_bb3cfcbf65750e32 = "power_on2";
    level.firefly_ww_quest.var_e923a8986534e479.we_lgt = "we_lgt_power_on_farm";
    level.firefly_ww_quest.var_ebc7351f6a37a33e = utility::getstruct( "fww_l_ab", "targetname" );
    level.firefly_ww_quest.var_ebc7351f6a37a33e.var_bb3cfcbf65750e32 = "power_on1";
    level.firefly_ww_quest.var_ebc7351f6a37a33e.we_lgt = "we_lgt_power_on_cabin";
    level.firefly_ww_quest.var_3c2b958988525c86 = [ level.firefly_ww_quest.var_c1f736e2f66ad165, level.firefly_ww_quest.var_e923a8986534e479, level.firefly_ww_quest.var_ebc7351f6a37a33e ];
    level.firefly_ww_quest.var_45280f83a973bb97 = [];
    level.firefly_ww_quest.var_45280f83a973bb97[ 0 ] = [ "sat_zm_aetheric_symbols_08", "sat_zm_aetheric_symbols_07", "sat_zm_aetheric_symbols_06", "sat_zm_aetheric_symbols_03" ];
    level.firefly_ww_quest.var_45280f83a973bb97[ 1 ] = [ "sat_zm_aetheric_symbols_16", "sat_zm_aetheric_symbols_04", "sat_zm_aetheric_symbols_10", "sat_zm_aetheric_symbols_14" ];
    level.firefly_ww_quest.var_45280f83a973bb97[ 2 ] = [ "sat_zm_aetheric_symbols_17", "sat_zm_aetheric_symbols_18", "sat_zm_aetheric_symbols_11", "sat_zm_aetheric_symbols_01" ];
    var_4a8eee18f42e71b2 = getentitylessscriptablearray( "fww_f_s", #targetname );
    
    if ( !isdefined( var_4a8eee18f42e71b2 ) )
    {
        var_4a8eee18f42e71b2 = utility::getstructarray( "fww_f_s", "targetname" );
    }
    
    level.firefly_ww_quest.var_4a8eee18f42e71b2 = arraysort( var_4a8eee18f42e71b2, undefined, &function_acf66c7bcfc4a400 );
    
    for ( i = 0; i < level.firefly_ww_quest.var_4a8eee18f42e71b2.size ; i++ )
    {
        var_d2f6ff24b75082be = getdvarint( @"enable_firefly_ee", 0 ) ? randomint( 4 ) : 0;
        var_5b377d8f012f0b1 = level.firefly_ww_quest.var_4a8eee18f42e71b2[ i ];
        var_be2b26959a32ff77 = level.firefly_ww_quest.var_45280f83a973bb97[ i ][ var_d2f6ff24b75082be ];
        
        if ( var_5b377d8f012f0b1 utility::function_de1f80d93273abf5() )
        {
            var_5b377d8f012f0b1.mdl = var_5b377d8f012f0b1;
            var_3e066fe791b826aa = [ "left_symbol", "right_symbol", "back_symbol" ][ i ];
            var_5b377d8f012f0b1.mdl utility::function_32b24db3127bff40( var_3e066fe791b826aa, var_be2b26959a32ff77 );
        }
        
        if ( !isdefined( var_5b377d8f012f0b1.mdl ) )
        {
            var_5b377d8f012f0b1.mdl = utility::spawn_model( var_be2b26959a32ff77, var_5b377d8f012f0b1.origin, var_5b377d8f012f0b1.angles );
        }
        
        level.firefly_ww_quest.var_748aaeaf64dfc687[ i ] = var_5b377d8f012f0b1;
    }
    
    level.firefly_ww_quest.var_1ccacaad7d794986 = spawnstruct();
    level.firefly_ww_quest.var_1ccacaad7d794986.sbl = utility::function_30dbabe3200518b( "fww_v_sum_c", #targetname );
    level.firefly_ww_quest.var_1ccacaad7d794986.trigger = getnoentvolumearray( "fww_sum_failsafe", #targetname )[ 0 ];
    level.firefly_ww_quest.var_d69e4eb311b10cc7 = getentarray( "wwq_clip", #targetname );
    
    foreach ( clip in level.firefly_ww_quest.var_d69e4eb311b10cc7 )
    {
        clip connectpaths();
        clip notsolid();
    }
    
    level.firefly_ww_quest.var_13f3df23852d9c5a = [];
    level.firefly_ww_quest.var_13f3df23852d9c5a[ 0 ] = utility::getstruct( "fww_v_r_s1", "targetname" );
    level.firefly_ww_quest.var_13f3df23852d9c5a[ 1 ] = utility::getstruct( "fww_v_r_s2", "targetname" );
    level.firefly_ww_quest.ww_start_loc = level.firefly_ww_quest.var_13f3df23852d9c5a[ 0 ].origin;
    level.firefly_ww_quest.var_1d5d2bed26821e5c = level.firefly_ww_quest.var_13f3df23852d9c5a[ 0 ].angles;
    var_b023ec842afe3dd6 = utility::getstructarray( "fww_v_rs", "targetname" );
    var_1d889a48d1b26017 = randomint( 10 );
    level.firefly_ww_quest.var_b023ec842afe3dd6 = arrayrandomize( var_b023ec842afe3dd6, var_1d889a48d1b26017 );
    item_bundle = getscriptbundle( %"hash_7dedf5bcb43f68e7" );
    spawnoptions = common_item::function_bc5ff2958b71a708( level.firefly_ww_quest.s_vault.sbl.origin, level.firefly_ww_quest.s_vault.sbl.angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    positioningdata = common_item::function_b4bee4333994e45a( level.firefly_ww_quest.s_vault.sbl.origin, level.firefly_ww_quest.s_vault.sbl.angles );
    
    foreach ( var_1fcaa9d65aab7c5 in level.firefly_ww_quest.var_b023ec842afe3dd6 )
    {
        if ( !common_item::items_isenabled() )
        {
            continue;
        }
        
        var_1fcaa9d65aab7c5.sbl = common_item::function_2352d25db9e97696( item_bundle, 1, positioningdata, spawnoptions );
        var_1fcaa9d65aab7c5.sbl function_7653c765b6c7b815();
    }
    
    level.firefly_ww_quest.event_banter[ #"hash_fb0eee05f38579be" ][ "banterName" ] = #"hash_fb0eee05f38579be";
    level.firefly_ww_quest.event_banter[ #"hash_a21a7f363346300b" ][ "banterName" ] = #"hash_a21a7f363346300b";
    level.firefly_ww_quest.event_banter[ #"hash_a6076f47e020fc69" ][ "banterName" ] = #"hash_a6076f47e020fc69";
    level.firefly_ww_quest.event_banter[ #"hash_90eb90608de89d7d" ][ "banterName" ] = #"hash_90eb90608de89d7d";
    level.firefly_ww_quest.event_banter[ #"fww_ww_picked_up" ][ "banterName" ] = #"fww_ww_picked_up";
    level.firefly_ww_quest.event_banter[ #"hash_6ab9faf612440ca8" ][ "banterName" ] = #"hash_6ab9faf612440ca8";
    level.firefly_ww_quest.event_banter[ #"hash_86fdd551c833af59" ][ "banterName" ] = #"hash_86fdd551c833af59";
    level.firefly_ww_quest.event_banter[ #"hash_e3a088adc861cd25" ][ "banterName" ] = #"hash_e3a088adc861cd25";
    level.firefly_ww_quest.event_battlechatter = spawnstruct();
    level utility::flag_set( "firefly_ww_quest_items_inited" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xd46047d4, Offset: 0x2b15
// Size: 0x74
function private function_acf66c7bcfc4a400( item1, item2 )
{
    return isdefined( item1.script_int ) && isdefined( item2.script_int ) ? int( item1.script_int ) < int( item2.script_int ) : int( item1.script_noteworthy ) < int( item2.script_noteworthy );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x612dddca, Offset: 0x2b92
// Size: 0xc6
function private function_2fe825e40352d2b5( s_exfil )
{
    if ( !isdefined( level.firefly_ww_quest.steps ) )
    {
        return;
    }
    
    foreach ( step in level.firefly_ww_quest.steps )
    {
        step.b_skipped = 1;
    }
    
    level thread zm_quest::clear_all_guidance();
    level zm_quest::quit_quest( #"firefly_ww_quest" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0xc
// Checksum 0x70fa3b5, Offset: 0x2c60
// Size: 0x18ee
function private function_51f12524c830dd09()
{
    self notify( #"hash_2d55c8678130930e" );
    self endon( #"hash_2d55c8678130930e" );
    level endon( #"game_ended" );
    
    if ( level zm_quest::function_73720cdf21c3cfd7( #"firefly_ww_quest", #"ww_picked_up" ) )
    {
        return;
    }
    
    quest_step = level.firefly_ww_quest.steps[ level.firefly_ww_quest.var_7be076c9078045aa ];
    level.firefly_ww_quest utility::ent_flag_waitopen_any( "showing_failure_ui" );
    
    if ( level zm_sat_firefly::function_24006873400b7a8() )
    {
        var_6f25a74d1bcf454 = level zm_quest::get_quest( #"firefly_pap_quest" );
        var_6f25a74d1bcf454 utility::ent_flag_wait( "zm_quest_completed" );
        var_72ff9a1f8a0203db = quest_step.index > 2 && quest_step.index < 5 && !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_ab_got" );
        var_d547b9e0c1d783cc = !level.firefly_ww_quest.var_7beabd5eecea599c.var_619c74ef69fba3b0 && var_72ff9a1f8a0203db;
        
        if ( ( level.wonder_veh.var_7493baa2cd62443 != 3 || !level utility::flag( "doorbuy_farm_barn_bought" ) ) && !level.firefly_ww_quest utility::ent_flag( "is_sss_step" ) && !var_d547b9e0c1d783cc && !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_extr" ) && ( !level.firefly_ww_quest utility::ent_flag( "is_craxi_step" ) || level.firefly_ww_quest.var_7beabd5eecea599c.progress < 1 ) && !level.firefly_ww_quest.var_1ccacaad7d794986 utility::ent_flag( "is_sc_active" ) )
        {
            if ( level.wonder_veh.var_7493baa2cd62443 != 3 )
            {
                if ( !level.firefly_ww_quest.var_7beabd5eecea599c.var_619c74ef69fba3b0 && !level.firefly_ww_quest.var_7beabd5eecea599c.var_6bbbc08c0181bd79 )
                {
                    level zm_quest::function_fb3af5600f6a9441( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_2ed7a5ae2e02ce96" );
                    level zm_quest::function_fb3af5600f6a9441( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_f9d5c7ccbdfca64" );
                    level zm_quest::function_fb3af5600f6a9441( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_2dc50dfee0272f9a" );
                    level zm_quest::function_fb3af5600f6a9441( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
                    level zm_quest::function_fb3af5600f6a9441( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"setup_delivery" );
                    level zm_quest::function_fb3af5600f6a9441( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"grab_ab" );
                    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_2ed7a5ae2e02ce96" );
                    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_f9d5c7ccbdfca64" );
                    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_2dc50dfee0272f9a" );
                    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
                    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"setup_delivery" );
                    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"grab_ab" );
                    level thread zm_sat_firefly_script_pluto_upgrade::function_51f12524c830dd09();
                }
                
                while ( level.wonder_veh.var_7493baa2cd62443 != 3 )
                {
                    wait 1;
                }
                
                level utility::flag_wait( "upgraded_pluto_to_stage_" + 3 );
                wait 1;
            }
            
            if ( !level utility::flag( "doorbuy_farm_barn_bought" ) )
            {
                var_28418cde11ed7c81 = [];
                
                for ( i = 0; i < level.firefly_ww_quest.var_e327c4bd0a3ed3fd.size ; i++ )
                {
                    var_28418cde11ed7c81[ var_28418cde11ed7c81.size ] = [ level.firefly_ww_quest.var_e327c4bd0a3ed3fd[ i ], 90, undefined, undefined, undefined, level.firefly_ww_quest.var_e327c4bd0a3ed3fd[ i ] ];
                }
                
                level thread zm_quest::update_guidance( var_28418cde11ed7c81, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_2ed7a5ae2e02ce96" );
                level utility::flag_wait( "doorbuy_farm_barn_bought" );
            }
        }
    }
    
    if ( quest_step.ref == #"hash_f9d5c7ccbdfca64" || quest_step.ref == #"hash_2dc50dfee0272f9a" || level.firefly_ww_quest utility::ent_flag( "is_sss_step" ) )
    {
        level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag_clear( "quest_guidance_updated" );
        
        if ( !level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag( "is_fixed" ) )
        {
            var_6f25a74d1bcf454 = level zm_quest::get_quest( #"firefly_pap_quest" );
            var_6f25a74d1bcf454 utility::ent_flag_wait( "zm_quest_completed" );
            
            if ( !level.firefly_ww_quest utility::ent_flag( "player_saw_ab" ) )
            {
                hud_data = [ level.firefly_ww_quest.var_7beabd5eecea599c.mdl, undefined, undefined, undefined, undefined, level.firefly_ww_quest.var_7beabd5eecea599c.mdl ];
                level thread zm_quest::update_guidance( [ hud_data ], level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"discover_ab" );
                level.firefly_ww_quest.var_7beabd5eecea599c.mdl zm_quest::player_distance_and_look_at_looping_check( 150, 1 );
                level.firefly_ww_quest utility::ent_flag_set( "player_saw_ab" );
            }
            
            if ( isdefined( level.europa ) && isdefined( level.firefly_ww_quest.var_6c1394a72bab48af.sbl.origin ) && !level.europa europa::is_activated() )
            {
                level utility::flag_wait( "europa_assets_ready" );
                europa_summon_device = function_47c86977a18df38b( level.europa_unlock_ee.summon_devices, level.firefly_ww_quest.var_6c1394a72bab48af.sbl.origin );
                guidance_org = [ europa_summon_device, 25, undefined, undefined, undefined, europa_summon_device ];
                step_ref = #"call_europa";
            }
            else
            {
                guidance_org = [ level.firefly_ww_quest.var_6c1394a72bab48af.sbl, 25, undefined, undefined, undefined, level.firefly_ww_quest.var_6c1394a72bab48af.sbl ];
                step_ref = #"hash_f9d5c7ccbdfca64";
            }
            
            level thread zm_quest::update_guidance( [ guidance_org ], level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", step_ref );
            level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag_set( "quest_guidance_updated" );
        }
        else if ( level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag( "is_active" ) )
        {
            level zm_quest::function_fba942a1cfd85f5d( 1, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
            level zm_quest::function_fb3af5600f6a9441( 2, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
            
            if ( !is_cursed_mode() )
            {
                var_7be076c9078045aa = level zm_quest::get_quest_step( level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
                var_7be076c9078045aa utility::waittill_any( "zm_quest_step_tracker_showing", "splash_before_tracker_timeout" );
            }
            
            guidance_org = [ level.firefly_ww_quest.var_f9f72736451013bb.origin ];
            level thread zm_quest::update_guidance( [ guidance_org ], level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
            level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag_set( "quest_guidance_updated" );
            n_time_left = 60;
            n_time_start_ms = gettime();
            
            while ( n_time_left > 0 && level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag( "is_active" ) )
            {
                n_time_taken = utility::function_6f5d2e1f1ff70482( gettime() - n_time_start_ms );
                n_time_left = 60 - n_time_taken;
                level zm_quest::function_612a9ad0db22c29c( n_time_left * 1000, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
                wait 1;
            }
        }
        else
        {
            guidance_org = [ level.firefly_ww_quest.var_6c1394a72bab48af.sbl, 25, undefined, undefined, undefined, level.firefly_ww_quest.var_6c1394a72bab48af.sbl ];
            level thread zm_quest::update_guidance( [ guidance_org ], level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_2dc50dfee0272f9a" );
            level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag_set( "quest_guidance_updated" );
        }
        
        return;
    }
    
    if ( !level.firefly_ww_quest.s_vault utility::ent_flag( "is_full" ) && ( quest_step.ref == #"setup_delivery" || quest_step.ref == #"aether_energy_extraction" || level.firefly_ww_quest utility::ent_flag( "is_craxi_step" ) ) )
    {
        level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_clear( "quest_guidance_updated" );
        progress_left = 3 - level.firefly_ww_quest.s_vault.progress;
        
        if ( !level.firefly_ww_quest utility::ent_flag( "is_craxi_step" ) || level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_extr" ) )
        {
            if ( level zm_sat_firefly::function_24006873400b7a8() && level.firefly_ww_quest.var_7beabd5eecea599c.is_in_original_pos && !level.firefly_ww_quest.var_7beabd5eecea599c.var_619c74ef69fba3b0 && ( !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_ab_got" ) || level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_extr" ) ) )
            {
                step_ref = #"grab_ab";
            }
            else
            {
                step_ref = level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_extr" ) ? #"aether_energy_extraction" : quest_step.ref;
            }
        }
        else if ( !level zm_sat_firefly::function_24006873400b7a8() )
        {
            step_ref = #"crazy_taxi";
        }
        else if ( level zm_sat_firefly::function_24006873400b7a8() && level.firefly_ww_quest.var_7beabd5eecea599c.is_in_original_pos && !level.firefly_ww_quest.var_7beabd5eecea599c.var_619c74ef69fba3b0 && ( !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_ab_got" ) || level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_extr" ) ) )
        {
            step_ref = #"grab_ab";
        }
        else if ( level.firefly_ww_quest.var_7beabd5eecea599c.progress < progress_left )
        {
            step_ref = level.firefly_ww_quest.var_7beabd5eecea599c.progress < 1 ? #"setup_delivery" : #"hash_3367f7aa0ab01ca7";
        }
        else
        {
            step_ref = #"hash_cd2f167a0c99f2a6";
        }
        
        level.firefly_ww_quest.var_7beabd5eecea599c.step_ref = step_ref;
        
        if ( !level.firefly_ww_quest.var_7beabd5eecea599c.var_619c74ef69fba3b0 && ( !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_ab_got" ) || level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_extr" ) ) )
        {
            hud_data = [ level.firefly_ww_quest.var_7beabd5eecea599c.mdl, undefined, undefined, undefined, undefined, level.firefly_ww_quest.var_7beabd5eecea599c.mdl ];
            hud_data = [ hud_data ];
        }
        else
        {
            if ( level.firefly_ww_quest.var_7beabd5eecea599c.progress < progress_left )
            {
                hud_data = [];
                
                foreach ( ab_loc in level.firefly_ww_quest.var_3c2b958988525c86 )
                {
                    if ( ab_loc utility::ent_flag( "is_on_cooldown" ) )
                    {
                        continue;
                    }
                    
                    var_55a3da08bd6a9a23 = function_f727edb1f17e9f25( ab_loc );
                    
                    if ( !var_55a3da08bd6a9a23 utility::ent_flag( "activated" ) )
                    {
                        continue;
                    }
                    
                    hud_data[ hud_data.size ] = [ var_55a3da08bd6a9a23, 150, undefined, undefined, undefined, var_55a3da08bd6a9a23 ];
                }
            }
            
            if ( level.firefly_ww_quest.var_7beabd5eecea599c.progress >= progress_left || level.firefly_ww_quest.var_7beabd5eecea599c.progress > 0 && hud_data.size < 1 )
            {
                hud_data = [ level.firefly_ww_quest.s_vault.sbl, 75, undefined, undefined, undefined, level.firefly_ww_quest.s_vault.sbl ];
                hud_data = [ hud_data ];
            }
            else if ( hud_data.size < 1 )
            {
                step_ref = #"hash_26b4778edc93e87a";
            }
        }
        
        level thread zm_quest::update_guidance( hud_data, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", step_ref, 1 );
        level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_set( "quest_guidance_updated" );
        return;
    }
    
    if ( quest_step.ref != #"hash_2628b3662d042f0c" && quest_step.ref != #"hash_ab5d1400594ebb61" && ( level.firefly_ww_quest.s_vault utility::ent_flag( "is_full" ) || quest_step.ref == #"unlock_symbol_lock" ) )
    {
        hud_data = [];
        
        foreach ( aetheric_symbol in level.firefly_ww_quest.var_748aaeaf64dfc687 )
        {
            data = [ aetheric_symbol, 150 ];
            hud_data[ hud_data.size ] = data;
        }
        
        hud_data[ hud_data.size ] = [ level.firefly_ww_quest.s_vault.sbl, 75, undefined, undefined, undefined, level.firefly_ww_quest.s_vault.sbl ];
        level thread zm_quest::update_guidance( hud_data, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"unlock_symbol_lock" );
        return;
    }
    
    if ( quest_step.ref == #"hash_2628b3662d042f0c" && !level.firefly_ww_quest utility::ent_flag( "is_ww_picked_up" ) )
    {
        hud_data = [ level.firefly_ww_quest.s_vault.sbl, 75, undefined, undefined, undefined, level.firefly_ww_quest.s_vault.sbl ];
        hud_data = [ hud_data ];
        level thread zm_quest::update_guidance( hud_data, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_2628b3662d042f0c" );
        return;
    }
    
    if ( level.firefly_ww_quest utility::ent_flag( "is_ww_picked_up" ) && !level.firefly_ww_quest.var_1ccacaad7d794986 utility::ent_flag( "is_sc_complete" ) )
    {
        hud_data = [];
        var_eee91ca54d5f05a7 = [ level.firefly_ww_quest.var_1ccacaad7d794986.origin, 0, 208 ];
        hud_data[ hud_data.size ] = var_eee91ca54d5f05a7;
        
        foreach ( var_1fcaa9d65aab7c5 in level.firefly_ww_quest.var_b023ec842afe3dd6 )
        {
            if ( var_1fcaa9d65aab7c5.sbl utility::ent_flag( "fireflyww_is_retrieved" ) )
            {
                continue;
            }
            
            if ( !var_1fcaa9d65aab7c5.sbl utility::function_9f2c41c1dcc8c94( "model", "ready" ) )
            {
                continue;
            }
            
            data = [ var_1fcaa9d65aab7c5.sbl, undefined, undefined, undefined, undefined, var_1fcaa9d65aab7c5.sbl ];
            hud_data[ hud_data.size ] = data;
        }
        
        level thread zm_quest::update_guidance( hud_data, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_ab5d1400594ebb61" );
        return;
    }
    
    if ( level.firefly_ww_quest utility::ent_flag( "is_ww_picked_up" ) && level.firefly_ww_quest.var_1ccacaad7d794986 utility::ent_flag( "is_sc_complete" ) )
    {
        step_ref = level zm_sat_firefly::function_24006873400b7a8() ? #"complete" : #"hash_ab5d1400594ebb61";
        level zm_quest::function_fba942a1cfd85f5d( 1, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", step_ref );
        level zm_quest::function_fb3af5600f6a9441( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", step_ref );
        level thread zm_quest::update_guidance( undefined, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", step_ref );
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xa0c69303, Offset: 0x4556
// Size: 0x8
function private is_cursed_mode()
{
    return game_utility::function_d68874417f3eea5c();
}

// Namespace zm_sat_firefly_ww_quest
// Params 12, eflags: 0xc
// Checksum 0x5fc13938, Offset: 0x4567
// Size: 0x65a
function private spawn_event_zombies( radius, time, zone, event_name, var_392d8b2be6a2351b, event_player_radius = 1200, event_spawn_flag, var_df125048d0e44125 = 0, zombie_spawn_interval, var_ef9c3997f9bd7592, b_skip_nuke, event_origin = self.origin )
{
    self notify( #"hash_5a8ab6a21225d224" );
    self endon( #"hash_5a8ab6a21225d224" );
    level endon( #"game_ended" );
    
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
    
    while ( utility::ent_flag( event_spawn_flag ) )
    {
        var_c6457b9450c88863 = getplayersinradius( event_origin, event_player_radius );
        
        if ( var_c6457b9450c88863.size > 0 && ( !isdefined( var_e145557eae07e615 ) || var_e145557eae07e615.size != var_c6457b9450c88863.size ) )
        {
            var_e145557eae07e615 = var_c6457b9450c88863;
            max_spawn_count = var_e145557eae07e615.size * 5 + 10;
            var_a958b2f1050461c1 = zombie_spawn_interval;
            var_a958b2f1050461c1 -= var_e145557eae07e615.size == 1 ? 2 : 0;
            var_a958b2f1050461c1 /= var_e145557eae07e615.size >= 4 ? 3.75 : var_e145557eae07e615.size;
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
                    logstring( "<dev string:x24>" + event_spawn_flag + "<dev string:x41>" );
                #/
                
                waitframe();
                continue;
            }
        }
        
        var_fa6ce69c0e6a4a22 = arrayintersection( var_9e5ef79d94efc7eb, self.a_zombies_spawned );
        
        if ( var_9e5ef79d94efc7eb.size >= max_spawn_count && var_fa6ce69c0e6a4a22.size >= var_ef9c3997f9bd7592 )
        {
            /#
                logstring( "<dev string:x24>" + event_spawn_flag + "<dev string:x7a>" + max_spawn_count + "<dev string:xb6>" + var_ef9c3997f9bd7592 + "<dev string:xb8>" );
            #/
            
            waitframe();
            continue;
        }
        
        spawner_zombie_type = function_b3988325430ce242( "zombie_base" );
        
        if ( !isdefined( spawner_zombie_type ) )
        {
            /#
                logstring( "<dev string:x24>" + event_spawn_flag + "<dev string:xbb>" + spawner_zombie_type + "<dev string:xb8>" );
            #/
            
            waitframe();
            continue;
        }
        
        var_33e3fae68ea718e3 = zone_spawner::function_20c574a6ba7cc5c6( zone.zone_name, spawner_zombie_type );
        var_33e3fae68ea718e3 = utility::get_array_of_closest( event_origin, var_33e3fae68ea718e3, undefined, undefined, var_392d8b2be6a2351b );
        var_a650a0c6e936d32e = zone_spawner::function_20c574a6ba7cc5c6( getarraykeys( zone.var_c96b1c3cfbbd6aac ), spawner_zombie_type );
        var_a650a0c6e936d32e = utility::get_array_of_closest( event_origin, var_a650a0c6e936d32e, undefined, undefined, var_392d8b2be6a2351b );
        
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
                logstring( "<dev string:x24>" + event_spawn_flag + "<dev string:xe3>" );
            #/
            
            waitframe();
            continue;
        }
        
        zmb_spawner = utility::array_random( spawners );
        thread function_fcc576ce75ae207c( spawner_zombie_type, zmb_spawner, event_name, zombie_round_difficulty );
        var_5818b14097fe1399 = utility::function_6f5d2e1f1ff70482( gettime() );
    }
    
    callback::remove( #"on_ai_killed", &function_a8219108040d8468, self );
    
    if ( !level.var_a009ab14ee0d3223.isspecialround )
    {
        powerups::function_b3ef1ccbc3c4bbbb( 1 );
    }
    
    points::function_2b4273c6ce33f6eb();
    
    if ( b_skip_nuke )
    {
        return;
    }
    
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
    
    foreach ( ai in ais )
    {
        if ( !zm_utility::is_active_zombie( ai ) )
        {
            continue;
        }
        
        ai thread function_50ad2aedd39077e5();
    }
    
    self.a_zombies_spawned = undefined;
}

// Namespace zm_sat_firefly_ww_quest
// Params 4, eflags: 0x4
// Checksum 0x31dba5c9, Offset: 0x4bc9
// Size: 0x1ea
function private function_fcc576ce75ae207c( spawner_zombie_type, zmb_spawner, event_name, zombie_round_difficulty )
{
    level endon( #"game_ended" );
    zombie = agent_manager::spawn_agent( spawner_zombie_type, zmb_spawner.origin, ( 0, 0, 0 ), "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        zombie.var_8986d0eef2b93060 = zombie.kiastring;
        zombie.kiastring = #"zombie_kia_mission_kill";
        zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "sprint" == "super_sprint" || "sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "sprint" == "sprint" ? "run" : "sprint", event_name, 6 );
        zombie zombie_utils::set_zombie_round_difficulty( zombie_round_difficulty );
        zombie val::set( event_name, "ignore_cleanup", 1 );
        zombie.b_cleanup_no_respawn = 1;
        zombie.ignore_enemy_count = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie.no_powerups = 1;
        zombie.var_15598d8e493afe88 = 1;
        self.a_zombies_spawned[ self.a_zombies_spawned.size ] = zombie;
        zombie zone_spawner::function_ce10e453e7f7bb8e( zmb_spawner );
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x2e344782, Offset: 0x4dbb
// Size: 0x14b
function private function_50ad2aedd39077e5()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait randomfloatrange( 1, 1.25 );
    self.nuked = 1;
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.full_gib = 1;
    self.var_65522105f3bdca37 = 1;
    zombie_stun::stun_ai( 100 );
    self playsoundevent( %"sndevent_ai_papdeath_start" );
    
    if ( self tagexists( "j_spine4" ) )
    {
        self.pap_stun_fx = playfxontag( level._effect[ "zombie_impact" ], self, "j_spine4" );
    }
    
    wait randomfloatrange( 0.5, 1 );
    
    if ( isalive( self ) && self tagexists( "j_spine4" ) )
    {
        self playsoundevent( %"sndevent_ai_papdeath_explode" );
        self.pap_stun_fx = stopfxontag( level._effect[ "zombie_impact" ], self, "j_spine4" );
        self.pap_death_fx = playfxontag( level._effect[ "zombie_impact_blood" ], self, "j_spine4" );
    }
    
    wait 0.25;
    
    if ( isalive( self ) && !self.magic_bullet_shield && !val::get( "damageshield" ) )
    {
        self kill();
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x69861246, Offset: 0x4f0e
// Size: 0x32
function private function_a8219108040d8468( sparams, var_cd6fe84ede3ba4ae )
{
    var_cd6fe84ede3ba4ae.a_zombies_spawned = utility::array_removedead_or_dying( var_cd6fe84ede3ba4ae.a_zombies_spawned );
}

// Namespace zm_sat_firefly_ww_quest
// Params 5, eflags: 0x44 variadic
// Checksum 0x27e6e0a9, Offset: 0x4f48
// Size: 0x12d
function private function_f8c6a4e681e1b609( var_fe6c867545324e40, distance, func, ... )
{
    self endon( #"stop_delay_thread" );
    self endon( #"death_or_disconnect" );
    var_750b43408cd73917 = isvector( var_fe6c867545324e40 ) ? var_fe6c867545324e40 : var_fe6c867545324e40.origin;
    var_8106f5c3abefbda2 = 0;
    
    while ( !var_8106f5c3abefbda2 )
    {
        foreach ( player in level.players )
        {
            distance_to_player = distancesquared( var_750b43408cd73917, player.origin );
            var_8106f5c3abefbda2 = distance_to_player < squared( distance );
            
            if ( var_8106f5c3abefbda2 )
            {
                break;
            }
        }
        
        wait 0.1;
    }
    
    self thread [[ func ]]( flat_args( vararg, varargcount ) );
}

// Namespace zm_sat_firefly_ww_quest
// Params 3
// Checksum 0x22e5e44a, Offset: 0x507d
// Size: 0xf9
function function_7544b009dd330759( battlechattertype, var_40e9094b1574bf98, var_85eec463724acbc9 )
{
    if ( overlord::function_dce0a14273dfa0a8() || level utility::flag( "overlord_paused" ) || level utility::flag( "player_banter_playing" ) || !battlechattertype || var_85eec463724acbc9 )
    {
        return;
    }
    
    if ( isvector( var_40e9094b1574bf98 ) )
    {
        player = getplayersinradius( var_40e9094b1574bf98, 500, undefined, 1 )[ 0 ];
    }
    else if ( isalive( var_40e9094b1574bf98 ) && isplayer( var_40e9094b1574bf98 ) )
    {
        player = var_40e9094b1574bf98;
    }
    else
    {
        return;
    }
    
    level overlord::function_724ca7b94bf1fb66( 1 );
    soundtype = battlechattertype == 0 ? #"bc_flavor_player_negative" : battlechattertype == 1 ? #"bc_flavor_player_positive" : #"hash_5212ed7ec42f115a";
    level battlechatter_mp::trysaylocalsound( player, soundtype );
    level utility::delaythread( 1, &overlord::function_724ca7b94bf1fb66, 0 );
    var_85eec463724acbc9 = 1;
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x6cdaeb23, Offset: 0x517e
// Size: 0xe7
function private function_a6c039ae8e3916dd( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread function_51f12524c830dd09();
    }
    
    level callback::remove( "on_exfil_start", &function_2fe825e40352d2b5 );
    level callback::add( "on_exfil_start", &function_2fe825e40352d2b5 );
    
    if ( !level.firefly_ww_quest.event_battlechatter.var_1b7dde180d11822f )
    {
        level.firefly_ww_quest.event_battlechatter.var_1b7dde180d11822f = 1;
        level thread function_f8c6a4e681e1b609( level.firefly_ww_quest.s_vault.sbl.origin, 250, &function_7544b009dd330759, 2, level.firefly_ww_quest.s_vault.sbl.origin );
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x4ba22b5e, Offset: 0x526d
// Size: 0xcb
function private function_32a49f98f1839d9e( b_skipped, b_save_restored )
{
    if ( b_skipped && !b_save_restored && !level.firefly_ww_quest.restarted )
    {
        var_27729b5034168c47 = getentarray( "farm_barn_db", #targetname );
        
        foreach ( door in var_27729b5034168c47 )
        {
            door thread doorbuy::doorbuy_used( undefined, undefined, 1 );
        }
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x41545c5b, Offset: 0x5340
// Size: 0x257
function private function_a78eb023f8c4c11c( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored || level zm_quest::function_73720cdf21c3cfd7( #"firefly_ww_quest", #"security_scan_complete" ) || self.b_restarted && self.completed )
    {
        if ( !level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag( "is_fixed" ) )
        {
            function_f9c8afe21502a40( undefined );
        }
        
        return;
    }
    
    level thread function_51f12524c830dd09();
    
    if ( !level.firefly_ww_quest.s_security_door.interact )
    {
        level.firefly_ww_quest.s_security_door.interact = zm_quest::function_91f9590e98d57ff6( level.firefly_ww_quest.s_security_door.mdl.origin + ( 0, 0, 45 ), &function_12111988e2f81a9, &function_8b5df25d6c2e676f );
    }
    
    level callback::remove( #"europa_activated", &function_4e07d97648d75a2b );
    level callback::add( #"europa_activated", &function_4e07d97648d75a2b );
    level callback::remove( #"europa_return_to_chair", &function_c92bb4dc32f9c462 );
    level callback::add( #"europa_return_to_chair", &function_c92bb4dc32f9c462 );
    level utility::callsharedfunc( #"europa", #"hash_28df9ffe0637327e", "firefly_ww_quest_security_terminal", level.firefly_ww_quest.var_6c1394a72bab48af.sbl, undefined, 128, undefined, 1, 0, undefined, &function_f9c8afe21502a40 );
    level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag_wait( "is_fixed" );
    
    if ( level.firefly_ww_quest.s_security_door.interact )
    {
        level.firefly_ww_quest.s_security_door.interact freescriptable();
    }
    
    level.firefly_ww_quest thread weap_fireflyww::play_vo_banter( #"hash_fb0eee05f38579be", -1 );
    level callback::remove( #"europa_activated", &function_4e07d97648d75a2b );
    level callback::remove( #"europa_return_to_chair", &function_c92bb4dc32f9c462 );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x23da14e9, Offset: 0x559f
// Size: 0x70
function private function_12111988e2f81a9( player )
{
    if ( !isalive( player ) || player.interactions_disabled || level.firefly_ww_quest.event_battlechatter.var_fe2f5ab18c2398c0 )
    {
        return;
    }
    
    level thread function_7544b009dd330759( 2, player, level.firefly_ww_quest.event_battlechatter.var_fe2f5ab18c2398c0 );
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xd320ec2b, Offset: 0x5617
// Size: 0x36
function private function_8b5df25d6c2e676f( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xf7655338, Offset: 0x5656
// Size: 0x14
function private function_4e07d97648d75a2b( sparams )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xa151b289, Offset: 0x5672
// Size: 0x14
function private function_c92bb4dc32f9c462( sparams )
{
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xf85628f2, Offset: 0x568e
// Size: 0x77
function private function_f9c8afe21502a40( sparams )
{
    level.firefly_ww_quest.var_6c1394a72bab48af.sbl utility::function_7c10ea82c1e305b8( "base", "can_use" );
    level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag_set( "is_fixed" );
    utility::callsharedfunc( #"europa", #"hash_3ac6bb166921f4af", "firefly_ww_quest_security_terminal" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x96d98463, Offset: 0x570d
// Size: 0x116
function private function_48583a540e1f7e6d( b_skipped, b_save_restored )
{
    if ( !level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag( "is_fixed" ) )
    {
        function_f9c8afe21502a40( undefined );
        level callback::remove( #"europa_activated", &function_4e07d97648d75a2b );
        level callback::remove( #"europa_return_to_chair", &function_c92bb4dc32f9c462 );
    }
    
    if ( self.b_restarted && self.completed )
    {
        return;
    }
    
    if ( b_skipped || b_save_restored || level zm_quest::function_73720cdf21c3cfd7( #"firefly_ww_quest", #"security_scan_complete" ) || level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag( "is_successful" ) )
    {
        return;
    }
    
    level thread function_51f12524c830dd09();
    level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag_waitopen_any( "is_on_cooldown" );
    level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag_wait( "is_active" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xd98351d4, Offset: 0x582b
// Size: 0xf0
function private function_81190209e33147f3( player )
{
    if ( !isdefined( self.sbl ) || !isdefined( player ) || player.interactions_disabled )
    {
        return;
    }
    
    if ( !level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag( "is_fixed" ) )
    {
        return;
    }
    
    if ( self.var_a7754bc017e65d98 utility::ent_flag( "is_successful" ) || self.var_a7754bc017e65d98 utility::ent_flag( "is_active" ) || self.var_a7754bc017e65d98 utility::ent_flag( "is_on_cooldown" ) )
    {
        return;
    }
    
    thread function_ef663847d36f2545( player );
    
    if ( !level.firefly_ww_quest.event_battlechatter.b_activate_scanner )
    {
        level thread function_7544b009dd330759( 1, player, level.firefly_ww_quest.event_battlechatter.b_activate_scanner );
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x91b384b9, Offset: 0x5923
// Size: 0xb8
function private function_444e1dc004601f3f( interact, player )
{
    if ( interact.var_a7754bc017e65d98 utility::ent_flag( "is_on_cooldown" ) )
    {
        return { #string:&"SHARED_HINTSTRINGS/TRAP_COOLDOWN_HINT", #type:"HINT_NOBUTTON" };
    }
    
    if ( !level zm_sat_firefly::function_24006873400b7a8() || interact.var_a7754bc017e65d98 utility::ent_flag( "is_successful" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"SHARED_HINTSTRINGS/HINT_ACTIVATE", #type:"HINT_NOICON" };
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x5c28932a, Offset: 0x59e4
// Size: 0xbb4
function private function_ef663847d36f2545( activator )
{
    level endon( #"game_ended" );
    self.sbl utility::function_32b24db3127bff40( "base", "cannot_use" );
    self.var_a7754bc017e65d98 utility::ent_flag_set( "is_active" );
    
    if ( !isdefined( level.firefly_ww_quest.var_f9f72736451013bb.fx_mdl ) )
    {
        level.firefly_ww_quest.var_f9f72736451013bb.fx_mdl = utility::spawn_model( "tag_origin", level.firefly_ww_quest.var_f9f72736451013bb.origin + ( 0, 0, 10 ), level.firefly_ww_quest.var_f9f72736451013bb.angles );
    }
    
    var_a74326164f8c8c8b = vectortoangles( vectornormalize( level.firefly_ww_quest.var_f9f72736451013bb.origin - level.firefly_ww_quest.var_adb8bdf91749de3.origin ) );
    
    if ( !isdefined( level.firefly_ww_quest.var_adb8bdf91749de3.fx_mdl ) )
    {
        level.firefly_ww_quest.var_adb8bdf91749de3.fx_mdl = utility::spawn_model( "tag_origin", level.firefly_ww_quest.var_adb8bdf91749de3.origin, var_a74326164f8c8c8b );
    }
    
    self.var_a7754bc017e65d98 utility::ent_flag_clear( "quest_guidance_updated" );
    level.firefly_ww_quest utility::ent_flag_wait( "is_sss_step" );
    playfxontag( level._effect[ "bio_scan" ], level.firefly_ww_quest.var_adb8bdf91749de3.fx_mdl, "tag_origin" );
    playfxontag( level._effect[ "bio_scan_circle" ], level.firefly_ww_quest.var_f9f72736451013bb.fx_mdl, "tag_origin" );
    level.firefly_ww_quest.var_adb8bdf91749de3.fx_mdl playsound( #"hash_3c667c744ff02792" );
    level.firefly_ww_quest.var_adb8bdf91749de3.fx_mdl playloopsound( #"hash_bd0c7af7a2ab74a6" );
    level thread function_51f12524c830dd09();
    self.var_a7754bc017e65d98 utility::ent_flag_wait( "quest_guidance_updated" );
    event_zone = zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( level.firefly_ww_quest.var_f9f72736451013bb.origin ) );
    self.var_a7754bc017e65d98 thread spawn_event_zombies( 450, 60, event_zone, "ss_event", 1000, undefined, "is_active", undefined, 3.75, 12, undefined, self.sbl.origin );
    level zm_quest::function_9f49b2a045ece8ae( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
    var_a61da3b8290021b0 = 0;
    var_427b3d2c2f8fb546 = utility::function_6f5d2e1f1ff70482( gettime() );
    progress = 0;
    
    while ( true )
    {
        wait 0.5;
        level zm_quest::function_9f49b2a045ece8ae( progress, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
        var_cb0209b713fe3e13 = utility::function_6f5d2e1f1ff70482( gettime() ) - var_427b3d2c2f8fb546;
        
        if ( var_cb0209b713fe3e13 > 60 )
        {
            break;
        }
        
        if ( progress >= 100 )
        {
            break;
        }
        
        agent = undefined;
        var_9764a587d92077ea = getplayersandaiarrayinradius( level.firefly_ww_quest.var_f9f72736451013bb.fx_mdl.origin, 50 );
        
        if ( var_9764a587d92077ea.size > 1 )
        {
            b_continue_scanning = 0;
            
            if ( var_9764a587d92077ea.size == 2 && level.europa && level.europa europa::is_activated() )
            {
                var_bef89789cd63e5cf = 0;
                var_8c01ca543439fb3e = 0;
                
                foreach ( ent in var_9764a587d92077ea )
                {
                    if ( ent == level.europa )
                    {
                        var_bef89789cd63e5cf = 1;
                    }
                    
                    if ( ent == activator )
                    {
                        var_8c01ca543439fb3e = 1;
                        agent = ent;
                    }
                }
                
                b_continue_scanning = var_bef89789cd63e5cf && var_8c01ca543439fb3e;
            }
            
            if ( !b_continue_scanning )
            {
                if ( !var_a61da3b8290021b0 )
                {
                    var_a61da3b8290021b0 = 1;
                    level.firefly_ww_quest.var_f9f72736451013bb.fx_mdl playloopsound( #"hash_31cac99e8f09d248" );
                }
                
                continue;
            }
        }
        else if ( var_9764a587d92077ea.size < 1 )
        {
            if ( !var_a61da3b8290021b0 )
            {
                var_a61da3b8290021b0 = 1;
                level.firefly_ww_quest.var_f9f72736451013bb.fx_mdl playloopsound( #"hash_31cac99e8f09d248" );
            }
            
            if ( !isdefined( starting_timeout ) )
            {
                starting_timeout = utility::function_6f5d2e1f1ff70482( gettime() );
            }
            
            var_f79c409a3b70c83f = utility::function_6f5d2e1f1ff70482( gettime() ) - starting_timeout;
            
            if ( var_f79c409a3b70c83f > 5 )
            {
                break;
            }
            
            continue;
        }
        
        if ( !isdefined( agent ) )
        {
            agent = var_9764a587d92077ea[ 0 ];
        }
        
        if ( !isalive( agent ) )
        {
            continue;
        }
        
        if ( !isplayer( agent ) )
        {
            if ( !( isdefined( agent.aicategory ) && isdefined( agent.health ) && isdefined( agent.maxhealth ) ) || agent.type != "zombie" || !zm_utility::is_active_zombie( agent ) )
            {
                continue;
            }
            
            continue;
        }
        
        if ( activator != agent )
        {
            continue;
        }
        
        if ( agent.ismutantinjection )
        {
            continue;
        }
        
        if ( agent utility::ent_flag( "aether_shroud_in_use" ) )
        {
            continue;
        }
        
        if ( player::isinlaststand( agent ) )
        {
            continue;
        }
        
        if ( agent killstreak_utility::is_using_killstreak() )
        {
            var_359cad62d73f79e5 = agent killstreak_utility::get_using_killstreaks();
            var_f485422f78ea700e = 0;
            
            foreach ( killstreak in var_359cad62d73f79e5 )
            {
                if ( isstring( killstreak.streakname ) && killstreak.streakname == "sentry_gun" )
                {
                    var_f485422f78ea700e = 1;
                    break;
                }
            }
            
            if ( !var_f485422f78ea700e )
            {
                continue;
            }
        }
        
        if ( var_a61da3b8290021b0 )
        {
            var_a61da3b8290021b0 = 0;
            level.firefly_ww_quest.var_f9f72736451013bb.fx_mdl stoploopsound();
            level.firefly_ww_quest.var_f9f72736451013bb.fx_mdl playsound( #"hash_a3a34802b34b0bdd" );
        }
        
        starting_timeout = undefined;
        progress += 2.5;
        level zm_quest::function_9f49b2a045ece8ae( progress, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
    }
    
    if ( var_a61da3b8290021b0 )
    {
        var_a61da3b8290021b0 = 0;
        level.firefly_ww_quest.var_f9f72736451013bb.fx_mdl stoploopsound();
    }
    
    stopfxontag( level._effect[ "bio_scan_circle" ], level.firefly_ww_quest.var_f9f72736451013bb.fx_mdl, "tag_origin" );
    killfxontag( level._effect[ "bio_scan" ], level.firefly_ww_quest.var_adb8bdf91749de3.fx_mdl, "tag_origin" );
    level.firefly_ww_quest.var_adb8bdf91749de3.fx_mdl stoploopsound();
    level.firefly_ww_quest.var_adb8bdf91749de3.fx_mdl playsound( #"hash_a87c8eda039a1a52" );
    
    if ( progress < 100 )
    {
        if ( !level.firefly_ww_quest.event_battlechatter.b_fail_scanner )
        {
            level thread function_7544b009dd330759( 0, activator, level.firefly_ww_quest.event_battlechatter.b_fail_scanner );
        }
        
        level zm_quest::function_fb3af5600f6a9441( 3, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
        level zm_quest::function_9f49b2a045ece8ae( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
        self.sbl utility::function_32b24db3127bff40( "base", "cooldown" );
        self.var_a7754bc017e65d98 utility::ent_flag_set( "is_on_cooldown" );
        self.var_a7754bc017e65d98 utility::ent_flag_clear( "is_active" );
        level waittill( #"on_round_end" );
        self.var_a7754bc017e65d98 utility::ent_flag_clear( "is_on_cooldown" );
        self.sbl utility::function_32b24db3127bff40( "base", "can_use" );
        return;
    }
    
    if ( !level.firefly_ww_quest.event_battlechatter.b_success_scanner )
    {
        level thread function_7544b009dd330759( 1, activator, level.firefly_ww_quest.event_battlechatter.b_success_scanner );
    }
    
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_4bc27163c1adcce0" );
    level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag_set( "is_successful" );
    level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag_clear( "is_active" );
    level.firefly_ww_quest.var_f9f72736451013bb.fx_mdl delete();
    level.firefly_ww_quest.var_adb8bdf91749de3.fx_mdl delete();
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xee28cc95, Offset: 0x65a0
// Size: 0x128
function private function_74cf35cb8c233f73( b_skipped, b_save_restored )
{
    var_76865511e11784d = zm_quest::get_quest_step( #"firefly_ww_quest", #"hash_2dc50dfee0272f9a" );
    
    if ( b_save_restored || b_skipped || var_76865511e11784d.b_skipped || level zm_quest::function_73720cdf21c3cfd7( #"firefly_ww_quest", #"security_scan_complete" ) )
    {
        return;
    }
    
    level.firefly_ww_quest utility::ent_flag_set( "is_sss_step" );
    level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag_waitopen_any( "is_active" );
    
    if ( !level.firefly_ww_quest.var_6c1394a72bab48af utility::ent_flag( "is_successful" ) )
    {
        level.firefly_ww_quest utility::ent_flag_clear( "is_sss_step" );
        setup_scan_step = level zm_quest::get_quest_step( #"firefly_ww_quest", #"hash_2dc50dfee0272f9a" );
        level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_ww_quest", setup_scan_step.ref );
        level waittill( #"never" );
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x6d3b342d, Offset: 0x66d0
// Size: 0x226
function private function_24096dec67918b3d( b_skipped, b_save_restored )
{
    level.firefly_ww_quest utility::ent_flag_clear( "is_sss_step" );
    level utility::flag_wait( "firefly_ww_quest_items_inited" );
    
    foreach ( clip in level.firefly_ww_quest.var_472676df8b3d0265 )
    {
        clip connectpaths();
        clip notsolid();
    }
    
    if ( level.firefly_ww_quest.s_security_door.b_opened )
    {
        return;
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_ww_quest", #"security_scan_complete", 1 );
    level.firefly_ww_quest.s_security_door.mdl utility::function_32b24db3127bff40( "move", "slide_move" );
    wait 2;
    level.firefly_ww_quest.s_security_door.b_opened = 1;
    
    if ( isdefined( level.firefly_ww_quest.var_7beabd5eecea599c.mdl ) )
    {
        level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "base", "can_use" );
        level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "ping", "idle" );
    }
    
    level.firefly_ww_quest.var_6c1394a72bab48af.sbl utility::function_32b24db3127bff40( "base", "off" );
    level.firefly_ww_quest.var_6c1394a72bab48af.sbl utility::function_32b24db3127bff40( "ping", "off" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xc2a0769b, Offset: 0x68fe
// Size: 0x4e5
function private function_5f27d14e40573b40( b_skipped, b_save_restored )
{
    level utility::flag_wait( "initial_player_spawned" );
    level._fasttravel[ "override_jumppad_watchEnter" ] = &function_59d0caa02a782f49;
    level utility::flag_set( "pause_tessie_task_wwq" );
    
    if ( isdefined( level.var_8cff5e93e7f5e8 ) && ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"ol_tessie_race" || level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"hash_118650abf6b05f4f" ) )
    {
        level val::set( "task_wwq", "task_logic_activate", 0 );
    }
    
    var_76865511e11784d = level zm_quest::get_quest_step( #"firefly_ww_quest", #"hash_2dc50dfee0272f9a" );
    
    if ( !self.b_restarted && ( b_skipped || b_save_restored || var_76865511e11784d.b_skipped ) && !isdefined( level.firefly_ww_quest.var_7beabd5eecea599c.player ) )
    {
        var_3641fe418dfb41b1 = ( b_skipped || var_76865511e11784d.b_skipped ) && !b_save_restored;
        
        if ( level zm_quest::function_73720cdf21c3cfd7( #"firefly_ww_quest", #"ab_grabbed" ) || var_3641fe418dfb41b1 )
        {
            level.firefly_ww_quest.var_7beabd5eecea599c.interact thread ab_used( level.players[ 0 ] );
        }
        
        level utility::flag_set( "pause_tessie_task_wwq" );
    }
    
    var_921f51e781ffd11c = level zm_quest::function_73720cdf21c3cfd7( #"firefly_ww_quest", #"vault_progress" );
    
    if ( zm_save::function_fcccc3d2a616b1c7() && isdefined( var_921f51e781ffd11c ) && var_921f51e781ffd11c != 3 )
    {
        level.firefly_ww_quest.s_vault.progress = var_921f51e781ffd11c;
        level.firefly_ww_quest.s_vault thread function_f2a75b82f5feaa8f( 1 );
    }
    
    if ( !isdefined( level.firefly_ww_quest.s_vault.progress ) )
    {
        level.firefly_ww_quest.s_vault.progress = 0;
    }
    
    if ( !self.b_restarted )
    {
        level thread function_51f12524c830dd09();
        level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_wait( "is_ab_got" );
        level.pluto_upgrade_quest utility::ent_flag_clear( "block_update_guidance" );
        
        foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
        {
            var_55a3da08bd6a9a23 setscriptablepartstate( "usable", "usable" );
        }
        
        level.var_cbe0c7aecbbd5064 = &aed_hint_string;
        level.var_ef98efe43679ef7a = &aed_on_use;
        level callback::add( #"player_spawned", &function_ec5d1703d5fc69dd );
    }
    else if ( !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_extr" ) && level utility::flag( "doorbuy_farm_barn_bought" ) && level zm_sat_firefly::function_24006873400b7a8() && !level.firefly_ww_quest.s_vault utility::ent_flag( "is_full" ) )
    {
        level thread function_51f12524c830dd09();
    }
    
    if ( !self.b_restarted && b_skipped && !level.firefly_ww_quest.var_7beabd5eecea599c.b_dev_skip )
    {
        is_progress = !isdefined( level.firefly_ww_quest.var_7beabd5eecea599c.progress ) || level.firefly_ww_quest.var_7beabd5eecea599c.progress == 0;
        level.firefly_ww_quest.var_7beabd5eecea599c.progress = is_progress ? level.firefly_ww_quest.var_7beabd5eecea599c.progress + 1 : 1;
        level.firefly_ww_quest.var_7beabd5eecea599c.b_dev_skip = 1;
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.b_dev_skip )
    {
        return;
    }
    
    level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_wait( "is_extr" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xd62df23f, Offset: 0x6deb
// Size: 0xdb
function private function_59d0caa02a782f49( s_jumppad, ent )
{
    if ( !isalive( ent ) || !isplayer( ent ) || level.firefly_ww_quest.var_7beabd5eecea599c.player != ent || !level.firefly_ww_quest.var_7beabd5eecea599c.mdl )
    {
        return;
    }
    
    if ( !level.firefly_ww_quest.event_battlechatter.var_98afcd3e889c999c )
    {
        level thread function_7544b009dd330759( 0, ent, level.firefly_ww_quest.event_battlechatter.var_98afcd3e889c999c );
    }
    
    ent thread function_de7abb58d0a1293( level.firefly_ww_quest.var_7beabd5eecea599c, "drop_canister_check" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xba474570, Offset: 0x6ece
// Size: 0xaf
function private ab_hint( interact, player )
{
    if ( !isdefined( player ) || level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_9f2c41c1dcc8c94( "base", "cannot_use" ) || weap_manglercannon::is_mangler_cannon( player getcurrentweapon() ) || player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #string:&"zm_t10_garnet/interaction_carry_on", #type:"HINT_NOICON" };
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xc32eb1e6, Offset: 0x6f86
// Size: 0x501
function private ab_used( player )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.mdl ) || !isdefined( player ) || weap_manglercannon::is_mangler_cannon( player getcurrentweapon() ) || player.interactions_disabled )
    {
        return;
    }
    
    if ( self.var_a7754bc017e65d98 utility::ent_flag( "is_ab_got" ) )
    {
        return;
    }
    
    if ( self.var_a7754bc017e65d98 utility::ent_flag( "is_in_aed" ) )
    {
        if ( self.var_a7754bc017e65d98 utility::ent_flag( "is_extr" ) )
        {
            return;
        }
        
        self.var_a7754bc017e65d98.var_a793391979fbfb8a = 1;
        self.var_a7754bc017e65d98 utility::ent_flag_clear( "is_in_aed" );
        self.var_a7754bc017e65d98.var_63fcc9bb6c678138 = undefined;
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_ww_quest", #"ab_grabbed", 1 );
    self.var_a7754bc017e65d98.var_6bbbc08c0181bd79 = self.var_a7754bc017e65d98.var_619c74ef69fba3b0;
    self.var_a7754bc017e65d98.mdl utility::function_32b24db3127bff40( "base", "cannot_use" );
    self.var_a7754bc017e65d98.mdl utility::function_32b24db3127bff40( "pickup", "picked_up" );
    self.var_a7754bc017e65d98.mdl getlinkedscriptableinstance() calloutmarkerping::function_608710c894185549();
    level callback::remove( #"player_vehicle_exit", &function_ffd450bab3725dce );
    level callback::add( #"player_vehicle_enter", &function_41b9616d74df7ada );
    self.var_a7754bc017e65d98.b_stowed = 0;
    self.var_a7754bc017e65d98.var_619c74ef69fba3b0 = 0;
    self.var_a7754bc017e65d98.mdl unlink();
    self.var_a7754bc017e65d98.prev_owner = undefined;
    self.var_a7754bc017e65d98.is_in_original_pos = 0;
    self.var_a7754bc017e65d98 notify( #"is_ab_got" );
    self.var_a7754bc017e65d98 utility::ent_flag_set( "is_ab_got" );
    
    if ( !isdefined( self.var_a7754bc017e65d98.progress ) )
    {
        self.var_a7754bc017e65d98.progress = 0;
    }
    
    self.var_a7754bc017e65d98.player = player;
    self.var_a7754bc017e65d98.dont_watch_for_timeout = undefined;
    
    if ( self.var_a7754bc017e65d98.var_a793391979fbfb8a || self.var_a7754bc017e65d98 utility::ent_flag( "is_in_aed" ) )
    {
        if ( level.firefly_ww_quest utility::ent_flag( "is_craxi_step" ) )
        {
            level thread function_51f12524c830dd09();
        }
    }
    else if ( self.var_a7754bc017e65d98.progress < 1 || level.firefly_ww_quest utility::ent_flag( "is_craxi_step" ) )
    {
        level thread function_51f12524c830dd09();
    }
    
    self.var_a7754bc017e65d98.var_a793391979fbfb8a = 0;
    self.var_a7754bc017e65d98.var_6bbbc08c0181bd79 = 0;
    level zm_quest::function_b57dfe9625966b0b( #"misc", 0, #"canister_2", 1, undefined, player );
    level zm_quest::show_splash_item_picked_up( #"misc", #"canister_2", 1, player );
    self.mdl notsolid();
    self.mdl linkto( player, "j_spine4", ( -16, 9, 6 ), ( 114, 5, 0 ) );
    player_vals = [ "sprint", "remote_killstreaks", "crouch", "prone" ];
    player.var_ff2e0673e13ac2ee = 1;
    player val::set_array( "carry_on_canister", player_vals, 0 );
    
    if ( self.var_a7754bc017e65d98.progress > 0 )
    {
        playfxontagforclients( level._effect[ "aether_canister_cam_vfx" ], player, "j_head", player );
        player setscriptablepartstate( "firefly_canister_hold_audio", "on" );
        var_5e1c75975eb34ec4 = self.var_a7754bc017e65d98.progress < 3 ? #"hash_a21a7f363346300b" : #"hash_a6076f47e020fc69";
        level.firefly_ww_quest thread weap_fireflyww::play_vo_banter( var_5e1c75975eb34ec4, -1, player );
    }
    else
    {
        level.firefly_ww_quest thread weap_fireflyww::play_vo_banter( #"hash_90eb90608de89d7d", -1, player );
    }
    
    player setclientomnvar( "ui_hud_carried_item_index", 6 );
    player setclientomnvar( "ui_hud_carried_item_count", 1 );
    player thread function_de12b01ac45a3e0e( self.var_a7754bc017e65d98 );
    player thread function_4863b57bd3a4454d( self.var_a7754bc017e65d98 );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xb6c1ec92, Offset: 0x748f
// Size: 0x8c
function private function_de12b01ac45a3e0e( var_7beabd5eecea599c )
{
    level endon( #"game_ended" );
    level.firefly_ww_quest endon( #"hash_297ff11c69a33cca" );
    level endon( #"drop_aether_canister" );
    var_7beabd5eecea599c endon( #"is_ab_got" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( self getcamerathirdperson() )
        {
            var_7beabd5eecea599c.mdl showtoplayer( self );
        }
        else
        {
            var_7beabd5eecea599c.mdl hidefromplayer( self );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x88a7ee5, Offset: 0x7523
// Size: 0x178
function private function_41b9616d74df7ada( params )
{
    if ( !params.vehicle.var_b6a3f46ec4332fd8 )
    {
        return;
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.player != self )
    {
        return;
    }
    
    if ( level.wonder_veh.tedd && !level.wonder_veh.tedd.var_b6f6811f0d9fa263 )
    {
        level.wonder_veh.tedd.var_b6f6811f0d9fa263 = 1;
        level.wonder_veh thread utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_6ae4afed220bcaab", 1 );
    }
    
    overridedata = spawnstruct();
    overridedata.var_29739c6fec03ea5a = level.wonder_veh gettagorigin( "tag_aether_cannister" );
    overridedata.drop_ang = level.wonder_veh gettagangles( "tag_aether_cannister" );
    overridedata.drop_type = "placed_in_vehicle";
    thread function_de7abb58d0a1293( level.firefly_ww_quest.var_7beabd5eecea599c, "player_enter_vehicle", overridedata );
    level callback::remove( #"player_vehicle_exit", &function_ffd450bab3725dce );
    level callback::add( #"player_vehicle_exit", &function_ffd450bab3725dce );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x8a8bc141, Offset: 0x76a3
// Size: 0xc6
function private function_ffd450bab3725dce( params )
{
    if ( !params.vehicle.var_b6a3f46ec4332fd8 )
    {
        return;
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.is_in_original_pos )
    {
        return;
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_ab_got" ) || level.firefly_ww_quest.var_7beabd5eecea599c.prev_owner != self )
    {
        return;
    }
    
    if ( params.specialexit == "_to_roof" )
    {
        return;
    }
    
    level.firefly_ww_quest.var_7beabd5eecea599c.interact thread ab_used( self );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x5b6eda61, Offset: 0x7771
// Size: 0x12f
function private function_4863b57bd3a4454d( var_7beabd5eecea599c )
{
    level endon( #"game_ended" );
    level endon( #"drop_aether_canister" );
    var_7beabd5eecea599c endon( #"is_ab_got" );
    self notifyonplayercommand( "drop_canister_check", "+stance" );
    self notifyonplayercommand( "drop_canister_check", "+prone" );
    self notifyonplayercommand( "drop_canister_check", "+movedown" );
    
    while ( true )
    {
        result = utility::waittill_any_return( "death_or_disconnect", "playing_game_over_scene", "last_stand_enter", "drop_canister_check", "active_roll_begin", "progressing_bear_attack_quest", "progressing_dmps_ee" );
        
        if ( result == "death_or_disconnect" || result == "playing_game_over_scene" || !isalive( self ) || result == "last_stand_enter" || result == "active_roll_begin" || result == "progressing_bear_attack_quest" || result == "progressing_dmps_ee" )
        {
            break;
        }
        
        if ( self isonascender() || !self isonground() || self isonladder() || self isjumping() || self ishighjumping() )
        {
            continue;
        }
        
        break;
    }
    
    thread function_de7abb58d0a1293( var_7beabd5eecea599c, result );
}

// Namespace zm_sat_firefly_ww_quest
// Params 3, eflags: 0x4
// Checksum 0xab81a8c7, Offset: 0x78a8
// Size: 0x632
function private function_de7abb58d0a1293( var_7beabd5eecea599c, result, overridedata = spawnstruct() )
{
    level endon( #"game_ended" );
    var_7beabd5eecea599c.mdl endon( #"death" );
    
    if ( isdefined( self ) )
    {
        val::reset( "carry_on_canister", "crouch" );
        val::reset( "carry_on_canister", "prone" );
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            var_7beabd5eecea599c.mdl showtoplayer( player );
        }
    }
    
    level callback::remove( #"player_vehicle_enter", &function_41b9616d74df7ada );
    
    if ( result == "death_or_disconnect" || result == "playing_game_over_scene" )
    {
        if ( result == "playing_game_over_scene" )
        {
            var_7beabd5eecea599c.mdl hide();
        }
        else if ( var_7beabd5eecea599c.b_stowed )
        {
            vehicle = level.wonder_veh;
        }
    }
    else if ( isalive( self ) )
    {
        if ( isplayer( self ) )
        {
            level zm_quest::function_b57dfe9625966b0b( #"misc", 0, #"canister_2", 0, undefined, self );
        }
        
        self notifyonplayercommandremove( "drop_canister_check", "+stance" );
        self notifyonplayercommandremove( "drop_canister_check", "+prone" );
        self notifyonplayercommandremove( "drop_canister_check", "+movedown" );
        
        if ( var_7beabd5eecea599c.progress > 0 )
        {
            self setscriptablepartstate( "firefly_canister_hold_audio", "off_playsound" );
            stopfxontag( level._effect[ "aether_canister_cam_vfx" ], self, "j_head" );
        }
        
        val::reset_all( "carry_on_canister" );
        self.var_ff2e0673e13ac2ee = 0;
        self setclientomnvar( "ui_hud_carried_item_index", 6 );
        self setclientomnvar( "ui_hud_carried_item_count", 0 );
        
        if ( result == "player_enter_vehicle" )
        {
            vehicle = level.wonder_veh;
            var_7beabd5eecea599c.b_stowed = 1;
            var_7beabd5eecea599c.prev_owner = self;
        }
        else
        {
            vehicle = function_ff53b2caf72c2bea();
        }
    }
    
    var_7beabd5eecea599c.player = undefined;
    var_7beabd5eecea599c.mdl unlink();
    var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "base", "can_use" );
    
    if ( isdefined( vehicle ) && result != "player_enter_vehicle" )
    {
        overridedata.var_29739c6fec03ea5a = undefined;
        overridedata.drop_ang = undefined;
    }
    
    var_b7c95846e0592242 = self ? self.origin : var_7beabd5eecea599c.origin;
    default_drop_org = getgroundposition( var_b7c95846e0592242, 1 );
    var_5c8e7bf7fb3ac77e = ( 0, 0, -3 );
    var_29739c6fec03ea5a = overridedata.var_29739c6fec03ea5a ?? default_drop_org;
    
    if ( isdefined( var_29739c6fec03ea5a ) )
    {
        var_7beabd5eecea599c.mdl.origin = var_29739c6fec03ea5a;
    }
    
    var_7beabd5eecea599c.mdl.angles = overridedata.drop_ang ?? var_5c8e7bf7fb3ac77e;
    var_7beabd5eecea599c.unresolved_collision_func = &movers::unresolved_collision_void;
    
    if ( isdefined( vehicle ) )
    {
        tag = var_7beabd5eecea599c.b_stowed ? "tag_aether_cannister" : "";
        var_7beabd5eecea599c.mdl linkto( vehicle, tag );
        var_7beabd5eecea599c.var_619c74ef69fba3b0 = 1;
    }
    
    default_drop_type = "placed_on_ground";
    drop_type = overridedata.drop_type ?? default_drop_type;
    var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "pickup", drop_type );
    level notify( #"drop_aether_canister" );
    var_7beabd5eecea599c utility::ent_flag_clear( "is_ab_got" );
    
    if ( !var_7beabd5eecea599c utility::ent_flag( "is_in_aed" ) && ( var_7beabd5eecea599c.progress < 1 || !isdefined( vehicle ) && level.firefly_ww_quest utility::ent_flag( "is_craxi_step" ) ) )
    {
        level thread function_51f12524c830dd09();
    }
    
    if ( var_7beabd5eecea599c.dont_watch_for_timeout || isdefined( vehicle ) )
    {
        return;
    }
    
    var_7beabd5eecea599c endon( #"is_ab_got" );
    failsafe_locs = utility::getstructarray( "fww_failsafe_loc", "targetname" );
    var_daa976c3bd95e4e5 = utility::get_array_of_closest( var_7beabd5eecea599c.mdl.origin, failsafe_locs, undefined, undefined, 100 );
    
    if ( var_daa976c3bd95e4e5[ 0 ] )
    {
        /#
            sphere( var_daa976c3bd95e4e5[ 0 ].origin, 100, ( 1, 0, 1 ), 1, int( 8 * getframeduration() ) );
        #/
        
        var_a9d1b92b22e9e830 = 8;
        n_time_left = 8;
    }
    
    if ( !isdefined( var_a9d1b92b22e9e830 ) )
    {
        var_a9d1b92b22e9e830 = 150;
    }
    
    n_time_left = var_a9d1b92b22e9e830;
    n_time_start_ms = gettime();
    
    while ( n_time_left > 0 )
    {
        n_time_taken = utility::function_6f5d2e1f1ff70482( gettime() - n_time_start_ms );
        n_time_left = var_a9d1b92b22e9e830 - n_time_taken;
        wait 1;
    }
    
    var_7beabd5eecea599c.mdl unlink();
    var_7beabd5eecea599c.is_in_original_pos = 1;
    var_7beabd5eecea599c.var_619c74ef69fba3b0 = 0;
    var_7beabd5eecea599c.mdl.origin = var_7beabd5eecea599c.origin;
    var_7beabd5eecea599c.mdl.angles = var_7beabd5eecea599c.angles;
    
    if ( !var_7beabd5eecea599c.var_a1029c238846f4b0 )
    {
        var_57c67bd5f19e87b7 = level zm_quest::get_quest_step( #"firefly_ww_quest", #"setup_delivery" );
        level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_ww_quest", var_57c67bd5f19e87b7.ref );
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x6060b5d1, Offset: 0x7ee2
// Size: 0x1fc
function private function_fcb7efc858bb6055( b_skipped, b_save_restored )
{
    level utility::flag_wait( "initial_player_spawned" );
    
    if ( b_save_restored || b_skipped )
    {
        return;
    }
    
    var_7685e511e1168e8 = level zm_quest::get_quest_step( #"firefly_ww_quest", #"setup_delivery" );
    
    if ( !self.b_restarted && var_7685e511e1168e8.b_skipped && !isdefined( level.firefly_ww_quest.var_7beabd5eecea599c.player ) )
    {
        level.firefly_ww_quest.var_7beabd5eecea599c.interact thread ab_used( level.players[ 0 ] );
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.b_dev_skip )
    {
        level zm_quest::function_fba942a1cfd85f5d( 1, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"aether_energy_extraction" );
        level zm_quest::clear_all_guidance();
        return;
    }
    
    if ( isdefined( level.firefly_main_quest.var_7002a144b4b849f2 ) && isdefined( level.wonder_veh ) )
    {
        level.wonder_veh calloutmarkerping::function_7c0ee9d4b604e6d6( level.firefly_main_quest.var_7002a144b4b849f2 );
        level.wonder_veh notify( #"remove_c_taxi_ping" );
    }
    
    if ( !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_extr" ) && ( level utility::flag( "doorbuy_farm_barn_bought" ) || !level zm_sat_firefly::function_24006873400b7a8() ) )
    {
        level thread function_51f12524c830dd09();
    }
    
    level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_waitopen_any( "is_extr" );
    level zm_quest::clear_all_guidance();
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x681ae685, Offset: 0x80e6
// Size: 0x2e7
function private aed_on_use( interact, player )
{
    var_55a3da08bd6a9a23 = interact.entity;
    
    if ( !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_in_aed" ) && level.firefly_ww_quest.var_7beabd5eecea599c.player != player )
    {
        return;
    }
    
    if ( !var_55a3da08bd6a9a23 utility::ent_flag( "activated" ) )
    {
        return;
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_extr" ) )
    {
        return;
    }
    
    if ( !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_in_aed" ) && level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_fully_dec" ) )
    {
        return;
    }
    
    if ( !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_in_aed" ) && level.firefly_ww_quest.var_7beabd5eecea599c.progress >= 3 )
    {
        return;
    }
    
    var_63fcc9bb6c678138 = function_22891980fcfd4ada( var_55a3da08bd6a9a23 );
    
    if ( var_63fcc9bb6c678138 utility::ent_flag( "is_on_cooldown" ) && level.firefly_ww_quest.var_7beabd5eecea599c.var_63fcc9bb6c678138 != var_63fcc9bb6c678138 )
    {
        return;
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_in_aed" ) && level.firefly_ww_quest.var_7beabd5eecea599c.var_63fcc9bb6c678138 != var_63fcc9bb6c678138 )
    {
        return;
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_in_aed" ) )
    {
        level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_clear( "is_in_aed" );
        level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "base", "can_use" );
        level.firefly_ww_quest.var_7beabd5eecea599c.var_63fcc9bb6c678138 = undefined;
        level.firefly_ww_quest.var_7beabd5eecea599c.var_a793391979fbfb8a = 1;
        level.firefly_ww_quest.var_7beabd5eecea599c.interact ab_used( player );
        return;
    }
    
    thread aed_aether_extraction( var_63fcc9bb6c678138, var_55a3da08bd6a9a23, player );
    
    if ( !level.firefly_ww_quest.event_battlechatter.var_eedfb545e8935f01 )
    {
        level thread function_7544b009dd330759( 1, player, level.firefly_ww_quest.event_battlechatter.var_eedfb545e8935f01 );
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x185f7b9e, Offset: 0x83d5
// Size: 0x99
function private function_22891980fcfd4ada( var_55a3da08bd6a9a23 )
{
    switch ( var_55a3da08bd6a9a23.loc_str )
    {
        case #"hash_2f38b0d124dff2c9":
            return level.firefly_ww_quest.var_ebc7351f6a37a33e;
        case #"hash_9c5e8152de8ef99":
            return level.firefly_ww_quest.var_e923a8986534e479;
        case #"hash_eff0649069653dd":
            return level.firefly_ww_quest.var_c1f736e2f66ad165;
        default:
            assertmsg( "<dev string:xf9>" );
            return;
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x2493b58b, Offset: 0x8476
// Size: 0x11c
function private function_f727edb1f17e9f25( var_63fcc9bb6c678138 )
{
    foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
    {
        if ( var_63fcc9bb6c678138 == level.firefly_ww_quest.var_ebc7351f6a37a33e && var_55a3da08bd6a9a23.loc_str != "lakefront" )
        {
            continue;
        }
        
        if ( var_63fcc9bb6c678138 == level.firefly_ww_quest.var_e923a8986534e479 && var_55a3da08bd6a9a23.loc_str != "farm" )
        {
            continue;
        }
        
        if ( var_63fcc9bb6c678138 == level.firefly_ww_quest.var_c1f736e2f66ad165 && var_55a3da08bd6a9a23.loc_str != "sunken" )
        {
            continue;
        }
        
        return var_55a3da08bd6a9a23;
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 3, eflags: 0x4
// Checksum 0x158f8f73, Offset: 0x859b
// Size: 0x8ff
function private aed_aether_extraction( var_63fcc9bb6c678138, var_55a3da08bd6a9a23, player )
{
    level endon( #"game_ended" );
    level.firefly_ww_quest.var_7beabd5eecea599c.var_63fcc9bb6c678138 = var_63fcc9bb6c678138;
    level.firefly_ww_quest.var_7beabd5eecea599c.var_63fcc9bb6c678138 utility::ent_flag_set( "is_extr" );
    level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_set( "is_extr" );
    level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_set( "is_in_aed" );
    level notify( #"hash_5a23390ae3e31bd0" );
    level zm_quest::clear_all_guidance();
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.progress < 1 || level.firefly_ww_quest utility::ent_flag( "is_craxi_step" ) )
    {
        level thread function_51f12524c830dd09();
    }
    
    level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_wait( "quest_guidance_updated" );
    level zm_quest::function_fba942a1cfd85f5d( 1, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"aether_energy_extraction" );
    level zm_quest::function_fb3af5600f6a9441( 2, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"aether_energy_extraction" );
    level zm_quest::function_9f49b2a045ece8ae( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"aether_energy_extraction" );
    overridedata = spawnstruct();
    overridedata.var_29739c6fec03ea5a = var_55a3da08bd6a9a23 gettagorigin( "tag_battery" );
    overridedata.drop_ang = var_55a3da08bd6a9a23 gettagangles( "tag_battery" );
    overridedata.drop_type = "placed_in_generator";
    level.firefly_ww_quest.var_7beabd5eecea599c.dont_watch_for_timeout = 1;
    player function_de7abb58d0a1293( level.firefly_ww_quest.var_7beabd5eecea599c, "drop_canister_check", overridedata );
    level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "base", "cannot_use" );
    level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "decay", 0 + "_decay" );
    fill_to_state = level.firefly_ww_quest.var_7beabd5eecea599c.progress + "_3";
    level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "audio", "start_filling" );
    level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "fill", fill_to_state );
    wait 1;
    fill_to_state = clamp( level.firefly_ww_quest.var_7beabd5eecea599c.progress + 1, 0, 3 );
    level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "audio", "filling" );
    level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "fill", fill_to_state + "_" + 3 + "_full" );
    var_55a3da08bd6a9a23 utility::function_7c10ea82c1e305b8( "body", "start_extracting" );
    var_55a3da08bd6a9a23 function_70576dbab4f88e19( "generator_audio_speed", 1 );
    event_zone = zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( var_55a3da08bd6a9a23.origin ) );
    var_63fcc9bb6c678138 thread spawn_event_zombies( 750, 15, event_zone, "aether_extraction", 1250, undefined, "is_extr", undefined, 3.25, 15 );
    n_time_left = 15;
    n_time_start_ms = gettime();
    
    while ( n_time_left > 0 )
    {
        n_time_taken = utility::function_6f5d2e1f1ff70482( gettime() - n_time_start_ms );
        n_time_left = 15 - n_time_taken;
        progress = 15 - n_time_left;
        level zm_quest::function_9f49b2a045ece8ae( progress, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"aether_energy_extraction" );
        level zm_quest::function_612a9ad0db22c29c( n_time_left * 1000, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"aether_energy_extraction" );
        wait 1;
    }
    
    level.firefly_ww_quest.var_7beabd5eecea599c.last_generator = var_55a3da08bd6a9a23;
    level.firefly_ww_quest.var_7beabd5eecea599c.progress++;
    clamp( level.firefly_ww_quest.var_7beabd5eecea599c.progress, 0, 3 );
    level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "audio", "fill_end" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"aether_energy_extraction" );
    level zm_quest::clear_all_guidance();
    var_55a3da08bd6a9a23 setmodel( %"sat_zm_aether_energy_generator_main_fxanim" );
    var_55a3da08bd6a9a23 utility::function_7c10ea82c1e305b8( "fx", "done_extracting" );
    var_55a3da08bd6a9a23 function_70576dbab4f88e19( "generator_audio_speed", 0 );
    
    foreach ( cylinder in var_55a3da08bd6a9a23.a_cylinders )
    {
        cylinder utility::function_7c10ea82c1e305b8( "fx", "done_extracting" );
    }
    
    var_55a3da08bd6a9a23 utility::function_7c10ea82c1e305b8( "body", "off" );
    var_63fcc9bb6c678138 utility::ent_flag_clear( "is_extr" );
    level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_clear( "is_extr" );
    var_63fcc9bb6c678138 childthread function_dd9b23b2bf287a6c();
    wait 5;
    var_bb3cfcbf65750e32 = var_55a3da08bd6a9a23.loc_str == "lakefront" ? "power_on1" : var_55a3da08bd6a9a23.loc_str == "farm" ? "power_on2" : "power_on3";
    level utility::flag_clear( var_bb3cfcbf65750e32 );
    deactivateworldevent( var_63fcc9bb6c678138.we_lgt );
    level trap_core::function_477b6dafe486c6b0( "saw_blade_trap_switch", 1 );
    wait 15;
    level utility::flag_set( var_bb3cfcbf65750e32 );
    activateworldevent( var_63fcc9bb6c678138.we_lgt );
    level trap_core::function_477b6dafe486c6b0( "saw_blade_trap_switch", 0 );
    wait 165;
    var_55a3da08bd6a9a23 utility::function_7c10ea82c1e305b8( "fx", "on" );
    
    foreach ( cylinder in var_55a3da08bd6a9a23.a_cylinders )
    {
        cylinder utility::function_7c10ea82c1e305b8( "fx", "on" );
    }
    
    var_55a3da08bd6a9a23 setmodel( %"sat_zm_aether_energy_generator_main_on_fxanim" );
    quest_step = level.firefly_ww_quest.steps[ level.firefly_ww_quest.var_7be076c9078045aa ];
    
    if ( quest_step.ref == #"setup_delivery" || quest_step.ref == #"aether_energy_extraction" || level.firefly_ww_quest utility::ent_flag( "is_craxi_step" ) )
    {
        level thread function_51f12524c830dd09();
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xaa5558d7, Offset: 0x8ea2
// Size: 0x43
function private function_dd9b23b2bf287a6c()
{
    utility::ent_flag_set( "is_on_cooldown" );
    self.cooldowntime = 185;
    
    while ( self.cooldowntime > 0 )
    {
        wait 1;
        self.cooldowntime--;
    }
    
    utility::ent_flag_clear( "is_on_cooldown" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x63ca51f1, Offset: 0x8eed
// Size: 0xdb
function private function_ec5d1703d5fc69dd( sparams )
{
    self endon( #"disconnect" );
    wait 8;
    level utility::flag_wait( "firefly_ww_quest_items_inited" );
    
    foreach ( var_63fcc9bb6c678138 in level.firefly_ww_quest.var_3c2b958988525c86 )
    {
        if ( level utility::flag( var_63fcc9bb6c678138.var_bb3cfcbf65750e32 ) )
        {
            activateworldevent( var_63fcc9bb6c678138.we_lgt );
        }
        else
        {
            deactivateworldevent( var_63fcc9bb6c678138.we_lgt );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x8da68cf, Offset: 0x8fd0
// Size: 0x254
function private aed_hint_string( interact, player )
{
    var_55a3da08bd6a9a23 = interact.entity;
    var_63fcc9bb6c678138 = function_22891980fcfd4ada( var_55a3da08bd6a9a23 );
    
    if ( var_63fcc9bb6c678138 utility::ent_flag( "is_on_cooldown" ) && level.firefly_ww_quest.var_7beabd5eecea599c.var_63fcc9bb6c678138 != var_63fcc9bb6c678138 )
    {
        return { #params:[ var_63fcc9bb6c678138.cooldowntime ], #string:&"zm_sat_firefly/firefly_wwq_cooldown", #type:"HINT_NOBUTTON" };
    }
    
    if ( !var_55a3da08bd6a9a23 utility::ent_flag( "activated" ) && level zm_sat_firefly::function_24006873400b7a8() && level.firefly_ww_quest.var_7beabd5eecea599c.player == player )
    {
        return { #string:&"SHARED_HINTSTRINGS/NEED_POWER_RED", #type:"HINT_NOBUTTON" };
    }
    
    if ( !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_in_aed" ) && level.firefly_ww_quest.var_7beabd5eecea599c.progress < 3 )
    {
        if ( level zm_sat_firefly::function_24006873400b7a8() && level.firefly_ww_quest.var_7beabd5eecea599c.player == player )
        {
            return { #string:&"shared_hintstrings/place", #type:"HINT_NOICON" };
        }
    }
    else if ( !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_extr" ) && !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_fully_dec" ) && level.firefly_ww_quest.var_7beabd5eecea599c.var_63fcc9bb6c678138 == var_63fcc9bb6c678138 )
    {
        return { #string:&"zm_t10_garnet/interaction_carry_on", #type:"HINT_NOICON" };
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x7f6ee283, Offset: 0x922d
// Size: 0x80
function private function_7de88cdb37253574( b_skipped, b_save_restored )
{
    if ( ( b_save_restored || b_skipped ) && level.firefly_ww_quest.s_vault.progress != 3 )
    {
        level.firefly_ww_quest.s_vault.progress = 3;
        level.firefly_ww_quest.s_vault thread function_f2a75b82f5feaa8f( 1 );
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xa49d1cb8, Offset: 0x92b5
// Size: 0x496
function private crazy_taxi_setup( b_skipped, b_save_restored )
{
    level utility::flag_wait( "initial_player_spawned" );
    var_7685f511e116b1b = level zm_quest::get_quest_step( #"firefly_ww_quest", #"aether_energy_extraction" );
    
    if ( b_save_restored || b_skipped || var_7685f511e116b1b.b_skipped )
    {
        return;
    }
    
    level.firefly_ww_quest utility::ent_flag_set( "is_craxi_step" );
    level thread function_51f12524c830dd09();
    last_generator = level.firefly_ww_quest.var_7beabd5eecea599c.last_generator;
    var_c2002eac05211e03 = level.firefly_ww_quest.var_7beabd5eecea599c.progress >= 3 && last_generator.loc_str == "farm";
    
    if ( isdefined( level.wonder_veh ) && isplayer( level.firefly_ww_quest.var_7beabd5eecea599c.player ) && !var_c2002eac05211e03 )
    {
        level.firefly_ww_quest.var_7002a144b4b849f2 = level.firefly_ww_quest.var_7beabd5eecea599c.player calloutmarkerping::function_81aa43aad6e47820( level.wonder_veh getentitynumber() );
        level.wonder_veh thread calloutmarkerping::function_3c501da3379eca0a( level.firefly_ww_quest.var_7beabd5eecea599c.player, level.firefly_ww_quest.var_7002a144b4b849f2, [ "remove_c_taxi_ping" ], undefined, 30 );
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.b_dev_skip )
    {
        if ( isdefined( level.firefly_ww_quest.var_7beabd5eecea599c.player ) )
        {
            level.firefly_ww_quest.var_7beabd5eecea599c.player thread function_de7abb58d0a1293( level.firefly_ww_quest.var_7beabd5eecea599c, "dev_skip" );
            level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_waitopen_any( "is_ab_got" );
        }
        
        level.firefly_ww_quest.var_7beabd5eecea599c.interact thread ab_used( level.players[ 0 ] );
        
        if ( level.firefly_ww_quest.var_7beabd5eecea599c.mdl )
        {
            level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "decay", 0 + "_decay" );
            fill_to_state = level.firefly_ww_quest.var_7beabd5eecea599c.progress + "_3";
            level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "audio", "ambient_filled" );
            level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "fill", fill_to_state );
        }
        
        level.firefly_ww_quest.var_7beabd5eecea599c.b_dev_skip = 0;
    }
    
    level.firefly_ww_quest.s_vault thread function_67b5b0d01b842d95();
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.progress > 0 )
    {
        level.firefly_ww_quest.var_7beabd5eecea599c thread function_ac02e13c0f9d83c();
        level.firefly_ww_quest.var_7beabd5eecea599c thread crazy_taxi_arcxd();
    }
    
    level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_wait_any( "is_extr", "is_deleted" );
    
    if ( !level.firefly_ww_quest.s_vault utility::ent_flag( "is_full" ) )
    {
        level.firefly_ww_quest utility::ent_flag_clear( "is_craxi_step" );
        level function_6580703500a68f81();
        setup_energy_step = level zm_quest::get_quest_step( #"firefly_ww_quest", #"setup_delivery" );
        level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_ww_quest", setup_energy_step.ref );
        level waittill( #"never" );
    }
    
    level zm_quest::clear_all_guidance();
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0xc
// Checksum 0xe161d8af, Offset: 0x9753
// Size: 0x617
function private crazy_taxi_arcxd()
{
    self notify( #"hash_e24248926a2fe3f6" );
    self endon( #"hash_e24248926a2fe3f6" );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.wonder_veh.arcxd_link ) )
    {
        level.wonder_veh.arcxd_link = utility::spawn_model( "tag_origin", level.wonder_veh gettagorigin( "tag_aether_cannister" ), ( 0, 0, 0 ) );
    }
    
    level.wonder_veh.arcxd_link linkto( level.wonder_veh, "tag_aether_cannister", ( 0, 0, 0 ), ( 90, 90, 0 ) );
    
    while ( !self.is_in_original_pos && level.firefly_ww_quest.var_7beabd5eecea599c.progress > 0 )
    {
        if ( !self.var_619c74ef69fba3b0 && ( !isdefined( self.player ) || !isdefined( self.player function_ff53b2caf72c2bea() ) ) )
        {
            wait 1;
            continue;
        }
        
        playfxontag( level._effect[ "wonder_energy_pulse" ], level.wonder_veh.arcxd_link, "tag_origin" );
        level.wonder_veh playsound( #"hash_b8c4ec4aa73e90d4" );
        
        /#
            frame_duration = getframeduration();
            var_a9a3df5cf2a744f4 = int( 5 * frame_duration );
            sphere( level.wonder_veh.origin, 350, ( 1, 0, 1 ), 1, var_a9a3df5cf2a744f4 );
        #/
        
        nearby_ai = getaiarrayinradius( level.wonder_veh.origin, 350, zm_utility::get_zombie_team() );
        
        foreach ( zombie in nearby_ai )
        {
            if ( !zm_utility::is_active_zombie( zombie ) || zombie.type != "zombie" || !isdefined( zombie.health ) )
            {
                continue;
            }
            
            if ( zombie.aicategory == "normal" )
            {
                dmg = zombie.health;
            }
            else
            {
                if ( !isdefined( zombie.maxhealth ) )
                {
                    continue;
                }
                
                dmg_perc = ( zombie.aicategory == "special" ? 30 : 10 ) / 100;
                dmg = zombie.maxhealth * dmg_perc;
            }
            
            var_5e94b7b011663cfd = zombie.health - dmg <= 0;
            
            if ( var_5e94b7b011663cfd )
            {
                start = level.wonder_veh.origin;
                end = zombie.origin;
                var_a2edc5cf45eced9e = vectornormalize( end - start );
                zombie.ragdollimpactvector = var_a2edc5cf45eced9e * 8000;
                zombie.ragdollhitloc = "torso_lower";
                zombie.do_immediate_ragdoll = 1;
            }
            
            zombie dodamage( dmg, zombie.origin, self.mdl, self.mdl, "MOD_UNKNOWN", level.weaponnone, "none", undefined, 536936448 );
            
            if ( var_5e94b7b011663cfd )
            {
                params = spawnstruct();
                params.scoreevent = #"zombie_kia_mission_kill";
                var_e145557eae07e615 = getplayersinradius( level.wonder_veh.origin, 350 );
                
                foreach ( player in var_e145557eae07e615 )
                {
                    if ( !zm_player::function_f37cfdf04b932a03( player ) )
                    {
                        continue;
                    }
                    
                    player callback::callback( "zombie_score_event", params );
                }
                
                corpse = zombie getcorpseentity();
                
                if ( corpse && corpse tagexists( "j_spine4" ) )
                {
                    corpse.veh_death_fx = playfxontag( level._effect[ "zombie_impact_purple" ], corpse, "j_spine4" );
                }
                
                waitframe();
            }
        }
        
        a_scriptables = getentitylessscriptablearray( undefined, undefined, level.wonder_veh.origin, 350 );
        
        foreach ( urchin in a_scriptables )
        {
            if ( urchin.type != %"zm_sat_urchin" && urchin.type != %"zm_sat_urchin_large" )
            {
                continue;
            }
            
            if ( !urchin utility::ent_flag( "active" ) && !urchin utility::ent_flag( "doing_warning_state" ) || urchin utility::ent_flag( "doing_force_explo" ) )
            {
                continue;
            }
            
            urchin zm_urchin::urchin_explode();
        }
        
        wait 5;
    }
    
    if ( level.wonder_veh.arcxd_link )
    {
        level.wonder_veh.arcxd_link delete();
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xa3fed2dc, Offset: 0x9d72
// Size: 0x83
function private function_ff53b2caf72c2bea()
{
    vehicle = undefined;
    moving_platform = self getmovingplatformparent();
    
    if ( isdefined( moving_platform ) )
    {
        var_2f2fdd8359217aab = anglestoup( moving_platform.angles );
        var_ea6ee32bec218e5b = vectordot( var_2f2fdd8359217aab, self.origin - moving_platform.origin );
        
        if ( var_ea6ee32bec218e5b < 150 && var_ea6ee32bec218e5b > 15 && isdefined( self getgroundentity() ) )
        {
            vehicle = moving_platform;
        }
    }
    
    return vehicle;
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x57aa0346, Offset: 0x9dfe
// Size: 0x49a
function private function_ac02e13c0f9d83c()
{
    level endon( #"game_ended" );
    level endon( #"hash_5a23390ae3e31bd0" );
    utility::ent_flag_wait( "quest_guidance_updated" );
    var_e7f65fcbdd676f57 = level.firefly_ww_quest.var_7beabd5eecea599c.step_ref;
    level zm_quest::function_fba942a1cfd85f5d( 1, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", var_e7f65fcbdd676f57 );
    level zm_quest::function_fb3af5600f6a9441( 2, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", var_e7f65fcbdd676f57 );
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.mdl )
    {
        level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "audio", "decaying" );
    }
    
    if ( !is_cursed_mode() )
    {
        var_7be076c9078045aa = level zm_quest::get_quest_step( level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", level.firefly_ww_quest.var_7beabd5eecea599c.step_ref );
        var_7be076c9078045aa utility::waittill_any( "zm_quest_step_tracker_showing", "splash_before_tracker_timeout" );
    }
    
    n_time_left = 105;
    n_time_start_ms = gettime();
    
    while ( n_time_left > 0 && level.firefly_ww_quest.var_7beabd5eecea599c.mdl && !level.firefly_ww_quest utility::ent_flag( "force_full_decay" ) )
    {
        n_time_taken = utility::function_6f5d2e1f1ff70482( gettime() - n_time_start_ms );
        n_time_left = 105 - n_time_taken;
        var_d7a1ec841905def6 = int( n_time_left );
        time_left_perc = 100 - var_d7a1ec841905def6 / 105 * 100;
        var_93850f2389ce60b7 = int( time_left_perc );
        
        if ( var_93850f2389ce60b7 % 20 == 0 )
        {
            if ( n_time_left <= 0 )
            {
                break;
            }
            
            if ( level.firefly_ww_quest.var_7beabd5eecea599c.mdl )
            {
                level.firefly_ww_quest.var_7beabd5eecea599c.mdl utility::function_32b24db3127bff40( "decay", var_93850f2389ce60b7 + "_decay" );
            }
        }
        
        level zm_quest::function_612a9ad0db22c29c( n_time_left * 1000, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", var_e7f65fcbdd676f57 );
        wait 1;
    }
    
    if ( self.var_619c74ef69fba3b0 && level.wonder_veh.tedd && !level.wonder_veh.tedd.var_e33b85fd22540ed6 )
    {
        level.wonder_veh.tedd.var_e33b85fd22540ed6 = 1;
        level.wonder_veh thread utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_6bdcaded22de6894", 1 );
    }
    
    if ( !level.firefly_ww_quest.event_battlechatter.b_fail_ab && level.firefly_ww_quest.var_7beabd5eecea599c.player )
    {
        level thread function_7544b009dd330759( 0, level.firefly_ww_quest.var_7beabd5eecea599c.player, level.firefly_ww_quest.event_battlechatter.b_fail_ab );
    }
    
    function_1b29660d07ca2124( 1 );
    level.firefly_ww_quest utility::ent_flag_set( "showing_failure_ui" );
    level zm_quest::function_fb3af5600f6a9441( 3, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", var_e7f65fcbdd676f57 );
    level.firefly_ww_quest utility::delaythread( 2.5, &utility::ent_flag_clear, "showing_failure_ui" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xad3e4bf3, Offset: 0xa2a0
// Size: 0x266
function private function_1b29660d07ca2124( var_455fdf4f22424c85 = 0 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( self.player ) )
    {
        self.player setscriptablepartstate( "firefly_canister_hold_audio", "off_playsound" );
        stopfxontag( level._effect[ "aether_canister_cam_vfx" ], self.player, "j_head" );
    }
    
    self.progress = 0;
    utility::ent_flag_set( "is_fully_dec" );
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.mdl )
    {
        self.mdl utility::function_32b24db3127bff40( "audio", "off" );
        
        if ( var_455fdf4f22424c85 )
        {
            self.mdl utility::function_32b24db3127bff40( "decay", 100 + "_decay" );
            wait 2;
        }
        else
        {
            self.mdl utility::function_32b24db3127bff40( "decay", "empty_deposit" );
            wait 1;
        }
        
        if ( self.mdl )
        {
            self.mdl utility::function_32b24db3127bff40( "fill", self.progress + "_" + 3 + "_full" );
        }
        
        wait 0.5;
        
        if ( self.mdl )
        {
            self.mdl utility::function_32b24db3127bff40( "decay", 0 + "_decay" );
        }
    }
    
    utility::ent_flag_clear( "is_fully_dec" );
    
    if ( var_455fdf4f22424c85 )
    {
        level utility::delaythread( 2.5, &function_6580703500a68f81 );
        level utility::delaythread( 2.5, &function_51f12524c830dd09 );
    }
    else
    {
        level function_6580703500a68f81();
        level thread function_51f12524c830dd09();
    }
    
    utility::ent_flag_waitopen_any( "is_energy_flying" );
    
    if ( level.firefly_ww_quest.s_vault utility::ent_flag( "is_full" ) )
    {
        self.dont_watch_for_timeout = 1;
        
        if ( isdefined( self.player ) )
        {
            self.player setscriptablepartstate( "firefly_canister_hold_audio", "off_playsound" );
            stopfxontag( level._effect[ "aether_canister_cam_vfx" ], self.player, "j_head" );
            self.player function_de7abb58d0a1293( self, "drop_canister_check" );
        }
        
        if ( self.mdl )
        {
            self.mdl delete();
        }
        
        utility::ent_flag_set( "is_deleted" );
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x8ac54173, Offset: 0xa50e
// Size: 0x6b
function private function_6580703500a68f81()
{
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"firefly_ww_quest", #"crazy_taxi" );
    
    if ( zm_quest::get_quest_relaxed( #"firefly_ww_quest_guidance" ) )
    {
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"firefly_ww_quest_guidance", #"hash_3367f7aa0ab01ca7" );
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"firefly_ww_quest_guidance", #"hash_cd2f167a0c99f2a6" );
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0xc
// Checksum 0x2bbcb240, Offset: 0xa581
// Size: 0x2ae
function private function_67b5b0d01b842d95()
{
    self notify( #"hash_127dd732a9d98d84" );
    self endon( #"hash_127dd732a9d98d84" );
    level endon( #"game_ended" );
    var_4fdbbc550ccdc21d = 0;
    
    while ( !var_4fdbbc550ccdc21d )
    {
        var_e145557eae07e615 = getplayersinradius( self.sbl.origin, 250 );
        
        foreach ( player in var_e145557eae07e615 )
        {
            if ( !isdefined( self.sbl ) || !isdefined( player ) || player.interactions_disabled || !level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag( "is_ab_got" ) )
            {
                wait 1;
                continue;
            }
            
            if ( level.firefly_ww_quest.var_7beabd5eecea599c.player != player )
            {
                wait 1;
                continue;
            }
            
            if ( level.firefly_ww_quest.var_7beabd5eecea599c.progress < 1 )
            {
                wait 1;
                continue;
            }
            
            up_angles = anglestoup( self.sbl.angles );
            var_f572500837a92fdf = vectordot( up_angles, player.origin - self.sbl.origin );
            
            if ( var_f572500837a92fdf > 150 )
            {
                wait 1;
                continue;
            }
            
            var_4fdbbc550ccdc21d = 1;
            break;
        }
        
        wait 0.5;
    }
    
    self.progress += level.firefly_ww_quest.var_7beabd5eecea599c.progress;
    
    if ( !level.firefly_ww_quest.event_battlechatter.var_3c0483919e95c276 && level.firefly_ww_quest.var_7beabd5eecea599c.player )
    {
        level thread function_7544b009dd330759( 1, level.firefly_ww_quest.var_7beabd5eecea599c.player, level.firefly_ww_quest.event_battlechatter.var_3c0483919e95c276 );
    }
    
    level.firefly_ww_quest.var_7beabd5eecea599c thread function_174869f929a0cf89();
    wait 0.5;
    thread function_f2a75b82f5feaa8f();
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x6fe8c202, Offset: 0xa837
// Size: 0x1cd
function private function_174869f929a0cf89()
{
    level endon( #"game_ended" );
    level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_set( "is_energy_flying" );
    fx_proxy = utility::spawn_model( "tag_origin", self.mdl.origin, vectortoangles( ( 0, 0, 1 ) ) );
    waitframe();
    playfxontag( level._effect[ "aether_energy_trail" ], fx_proxy, "tag_origin" );
    level thread utility::play_sound_in_space( "evt_wwq_vault_eat_ab_energy", fx_proxy.origin );
    wait 1;
    start = fx_proxy.origin;
    end = level.firefly_ww_quest.ww_start_loc + ( 0, 0, 16 );
    midpoint_pos = ( start + end ) / 2;
    var_67826db7688a058a = midpoint_pos[ 2 ] + distance( start, midpoint_pos );
    var_9ff7b1b7dd1448a1 = ( midpoint_pos[ 0 ], midpoint_pos[ 1 ], var_67826db7688a058a );
    fx_proxy thread utility::function_8001268940441423( start, end, var_9ff7b1b7dd1448a1, 1 );
    wait 0.95;
    stopfxontag( level._effect[ "aether_energy_trail" ], fx_proxy, "tag_origin" );
    level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( "fx", "absorb" );
    fx_proxy thread utility::delete_after_delay( 1 );
    earthquake( 0.25, 1, end, 250 );
    playrumbleonposition( "heavy_1s", end );
    level thread utility::play_sound_in_space( "evt_wwq_vault_eat_ab_energy_finish", end );
    level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_clear( "is_energy_flying" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x773ff566, Offset: 0xaa0c
// Size: 0x38b
function private function_f2a75b82f5feaa8f( b_instant = 0 )
{
    level endon( #"game_ended" );
    
    if ( self.progress >= 3 )
    {
        utility::ent_flag_set( "is_full" );
    }
    
    level.firefly_ww_quest.var_7beabd5eecea599c thread function_1b29660d07ca2124();
    level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_waitopen_any( "is_energy_flying" );
    level notify( #"hash_5a23390ae3e31bd0" );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_ww_quest", #"vault_progress", self.progress );
    wait_time = b_instant ? 0 : 1.5;
    var_eab91b06ee73cea3 = level.firefly_ww_quest.var_e81a6e44cbb46236[ 0 ];
    
    if ( !var_eab91b06ee73cea3.b_showing && self.progress > 0 )
    {
        var_eab91b06ee73cea3.b_showing = 1;
        level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( [ "left_symbol", "right_symbol", "back_symbol" ][ 0 ], "default" );
        wait wait_time;
    }
    
    var_78a8544ddfb401ac = level.firefly_ww_quest.var_e81a6e44cbb46236[ 1 ];
    
    if ( !var_78a8544ddfb401ac.b_showing && self.progress > 1 )
    {
        var_78a8544ddfb401ac.b_showing = 1;
        level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( [ "left_symbol", "right_symbol", "back_symbol" ][ 1 ], "default" );
        wait wait_time;
    }
    
    if ( self.progress >= 3 )
    {
        var_7d96177d66efadd5 = level.firefly_ww_quest.var_e81a6e44cbb46236[ 2 ];
        var_7d96177d66efadd5.b_showing = 1;
        level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( [ "left_symbol", "right_symbol", "back_symbol" ][ 2 ], "default" );
        var_bb8ee5d831e6b4a1 = level.firefly_ww_quest.var_e81a6e44cbb46236[ 3 ];
        var_bb8ee5d831e6b4a1.b_showing = 1;
        level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( "anim", "open" );
        level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( "fx", "symbol_ambient" );
        utility::ent_flag_set( "is_symbols_show" );
        
        if ( !level.firefly_ww_quest.event_battlechatter.var_2144b267d9620a58 && level.firefly_ww_quest.var_7beabd5eecea599c.player )
        {
            level thread function_7544b009dd330759( 2, level.firefly_ww_quest.var_7beabd5eecea599c.player, level.firefly_ww_quest.event_battlechatter.var_2144b267d9620a58 );
        }
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xadcaca2f, Offset: 0xad9f
// Size: 0x428
function private crazy_taxi_cleanup( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( level zm_sat_firefly::function_24006873400b7a8() )
    {
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"grab_ab" );
    }
    
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"setup_delivery" );
    level utility::flag_clear( "pause_tessie_task_wwq" );
    
    if ( !level val::get( "task_logic_activate" ) )
    {
        level val::set( "task_wwq", "task_logic_activate" );
    }
    
    level.firefly_ww_quest utility::ent_flag_clear( "is_craxi_step" );
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.var_a1029c238846f4b0 )
    {
        return;
    }
    
    level.firefly_ww_quest.var_7beabd5eecea599c.var_a1029c238846f4b0 = 1;
    
    if ( ( b_save_restored || b_skipped ) && level.firefly_ww_quest.s_vault.progress != 3 )
    {
        level.firefly_ww_quest.s_vault.progress = 3;
        level.firefly_ww_quest.s_vault thread function_f2a75b82f5feaa8f( 1 );
        
        if ( level utility::flag( "pause_tessie_task_wwq" ) )
        {
            level utility::flag_clear( "pause_tessie_task_wwq" );
        }
        
        if ( !level val::get( "task_logic_activate" ) )
        {
            level val::set( "task_wwq", "task_logic_activate" );
        }
    }
    
    level.firefly_ww_quest.s_vault utility::ent_flag_wait( "is_full" );
    
    if ( level.wonder_veh.arcxd_link )
    {
        level.wonder_veh.arcxd_link delete();
    }
    
    foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
    {
        var_55a3da08bd6a9a23 setscriptablepartstate( "usable", "unusable" );
    }
    
    level._fasttravel[ "override_jumppad_watchEnter" ] = undefined;
    level callback::remove( #"player_spawned", &function_ec5d1703d5fc69dd );
    level.firefly_ww_quest.var_7beabd5eecea599c.dont_watch_for_timeout = 1;
    
    if ( isdefined( level.firefly_ww_quest.var_7beabd5eecea599c.player ) )
    {
        level.firefly_ww_quest.var_7beabd5eecea599c.player setscriptablepartstate( "firefly_canister_hold_audio", "off_playsound" );
        stopfxontag( level._effect[ "aether_canister_cam_vfx" ], level.firefly_ww_quest.var_7beabd5eecea599c.player, "j_head" );
        level.firefly_ww_quest.var_7beabd5eecea599c.player function_de7abb58d0a1293( level.firefly_ww_quest.var_7beabd5eecea599c, "drop_canister_check" );
    }
    
    if ( level.firefly_ww_quest.var_7beabd5eecea599c.mdl )
    {
        level.firefly_ww_quest.var_7beabd5eecea599c.mdl delete();
    }
    
    level.firefly_ww_quest.var_7beabd5eecea599c utility::ent_flag_set( "is_deleted" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x9abffe3e, Offset: 0xb1cf
// Size: 0x1b9
function private symbol_lock_setup( b_skipped, b_save_restored )
{
    if ( isdefined( level.firefly_main_quest.var_7002a144b4b849f2 ) && isdefined( level.wonder_veh ) )
    {
        level.wonder_veh calloutmarkerping::function_7c0ee9d4b604e6d6( level.firefly_main_quest.var_7002a144b4b849f2 );
        level.wonder_veh notify( #"remove_c_taxi_ping" );
    }
    
    if ( b_save_restored || b_skipped )
    {
        level.firefly_ww_quest.s_vault utility::ent_flag_set( "is_complete" );
        return;
    }
    
    foreach ( s_vault_symbol in level.firefly_ww_quest.var_e81a6e44cbb46236 )
    {
        var_ebaee93d40b84094 = anglestoforward( s_vault_symbol.angles );
        var_caab51e0887b0963 = s_vault_symbol.origin + var_ebaee93d40b84094 * 44 + ( 0, 0, -20 );
        s_vault_symbol.interact = zm_quest::function_91f9590e98d57ff6( var_caab51e0887b0963, &symbol_lock_used, &symbol_lock_hint, "extrasmall_anyanglefov" );
        s_vault_symbol.interact.var_a7754bc017e65d98 = s_vault_symbol;
    }
    
    level thread function_51f12524c830dd09();
    level.firefly_ww_quest.s_vault utility::ent_flag_wait( "is_complete" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x41bd0c0, Offset: 0xb390
// Size: 0x3d7
function private symbol_lock_used( player )
{
    if ( self.var_a7754bc017e65d98 utility::ent_flag( "is_swapping" ) )
    {
        return;
    }
    
    playerangles = player getplayerangles();
    playerlookdir = anglestoforward( playerangles );
    originoffset = ( 0, 0, -60 );
    var_30736d696a032221 = isplayer( player ) && player getcamerathirdperson() ? 0.89 : 0.975;
    var_d02fa75282ca8f3f = [];
    
    foreach ( s_vault_symbol in level.firefly_ww_quest.var_e81a6e44cbb46236 )
    {
        var_84a7396e21d5b7ba = vectordot( playerlookdir, vectornormalize( s_vault_symbol.origin + originoffset - player.origin ) );
        var_d02fa75282ca8f3f[ var_d02fa75282ca8f3f.size ] = var_84a7396e21d5b7ba;
    }
    
    var_b62bc0ef73a41e0e = arraysort( var_d02fa75282ca8f3f, undefined, &function_e8eaa5513ef69669 )[ 0 ];
    var_c527272f7a17e566 = vectordot( playerlookdir, vectornormalize( self.var_a7754bc017e65d98.origin + originoffset - player.origin ) );
    var_6a77d11636c116d5 = distance2dsquared( player.origin, self.var_a7754bc017e65d98.origin + originoffset );
    
    if ( var_6a77d11636c116d5 > squared( 30 ) )
    {
        var_3e237fd4c3bce53b = distance2dsquared( player.origin, self.origin );
        
        if ( var_3e237fd4c3bce53b >= squared( 48 ) || var_c527272f7a17e566 < var_b62bc0ef73a41e0e && var_c527272f7a17e566 < var_30736d696a032221 )
        {
            return;
        }
    }
    
    if ( level.firefly_ww_quest.s_vault utility::ent_flag( "is_wrong_input_spawn_zombies" ) || level.firefly_ww_quest.s_vault utility::ent_flag( "is_complete" ) || level.firefly_ww_quest.s_vault utility::ent_flag( "is_checking_input" ) )
    {
        return;
    }
    
    var_cb7b13df04ee5809 = self.var_a7754bc017e65d98.group_number;
    
    if ( var_cb7b13df04ee5809 == 3 )
    {
        level.firefly_ww_quest.s_vault utility::ent_flag_set( "is_checking_input" );
        thread function_353de732315b1f48( player );
        return;
    }
    
    self.var_a7754bc017e65d98 utility::ent_flag_set( "is_swapping" );
    
    if ( !isdefined( self.var_a7754bc017e65d98.var_bc4f329a58b0c98e ) || self.var_a7754bc017e65d98.var_bc4f329a58b0c98e >= 3 )
    {
        self.var_a7754bc017e65d98.var_bc4f329a58b0c98e = -1;
    }
    
    self.var_a7754bc017e65d98.var_bc4f329a58b0c98e++;
    var_ddd47ec4b1da404 = [ "left_symbol", "right_symbol", "back_symbol" ][ var_cb7b13df04ee5809 ];
    var_b9b3b83d1557beab = level.firefly_ww_quest.var_45280f83a973bb97[ var_cb7b13df04ee5809 ][ self.var_a7754bc017e65d98.var_bc4f329a58b0c98e ];
    
    if ( isdefined( var_ddd47ec4b1da404 ) && isdefined( var_b9b3b83d1557beab ) )
    {
        level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( var_ddd47ec4b1da404, var_b9b3b83d1557beab );
    }
    
    wait 0.75;
    self.var_a7754bc017e65d98 utility::ent_flag_clear( "is_swapping" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x829d7976, Offset: 0xb76f
// Size: 0x19, Type: bool
function private function_e8eaa5513ef69669( var_b449a6cf38e90cd1, var_59f2c12b6b615667 )
{
    return var_b449a6cf38e90cd1 >= var_59f2c12b6b615667;
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x7939b37c, Offset: 0xb791
// Size: 0x1bc
function private symbol_lock_hint( interact, player )
{
    if ( !level zm_sat_firefly::function_24006873400b7a8() )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    playerangles = player getplayerangles();
    playerlookdir = anglestoforward( playerangles );
    var_c527272f7a17e566 = vectordot( playerlookdir, vectornormalize( interact.origin - player.origin ) );
    var_a3ca0e318e03980f = distance2dsquared( player.origin, interact.origin );
    
    if ( var_c527272f7a17e566 < 0.975 && var_a3ca0e318e03980f >= squared( 48 ) )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( level.firefly_ww_quest.s_vault utility::ent_flag( "is_wrong_input_spawn_zombies" ) || level.firefly_ww_quest.s_vault utility::ent_flag( "is_complete" ) )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    var_cb7b13df04ee5809 = interact.var_a7754bc017e65d98.group_number;
    
    if ( var_cb7b13df04ee5809 == 3 )
    {
        return { #string:&"zm_sat_firefly_post/input", #type:"HINT_NOICON" };
    }
    
    return { #string:&"zm_sat_firefly_post/hint_rotate", #type:"HINT_NOICON" };
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x8557b70a, Offset: 0xb956
// Size: 0x6e7
function private function_353de732315b1f48( player )
{
    level endon( #"game_ended" );
    level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( "anim", "close" );
    wait 0.87;
    level.firefly_ww_quest.s_vault.sbl utility::delaythreadendon( 0.6, "is_complete", &utility::function_32b24db3127bff40, "anim", "open" );
    b_unlocked = 1;
    var_b7ffc086099320e5 = level.firefly_ww_quest.var_e81a6e44cbb46236.size - 1;
    
    for ( i = 0; i < var_b7ffc086099320e5 ; i++ )
    {
        s_vault_symbol = level.firefly_ww_quest.var_e81a6e44cbb46236[ i ];
        var_5b377d8f012f0b1 = level.firefly_ww_quest.var_748aaeaf64dfc687[ s_vault_symbol.group_number ];
        var_ddd47ec4b1da404 = [ "left_symbol", "right_symbol", "back_symbol" ][ s_vault_symbol.group_number ];
        
        if ( level.firefly_ww_quest.s_vault.sbl utility::function_9f2c41c1dcc8c94( var_ddd47ec4b1da404, var_5b377d8f012f0b1.mdl.model ) )
        {
            continue;
        }
        
        b_unlocked = 0;
        break;
    }
    
    if ( b_unlocked )
    {
        level.firefly_ww_quest.s_vault utility::ent_flag_set( "is_complete" );
        level.firefly_ww_quest.s_vault.sbl notify( #"is_complete" );
        level.firefly_ww_quest.s_vault utility::ent_flag_clear( "is_checking_input" );
        playsoundatpos( level.firefly_ww_quest.s_vault.sbl.origin, #"hash_75c660e1c3edf8a3" );
        
        if ( !level.firefly_ww_quest.event_battlechatter.var_1a8de49901cb255d )
        {
            level thread function_7544b009dd330759( 2, player, level.firefly_ww_quest.event_battlechatter.var_1a8de49901cb255d );
        }
        
        return;
    }
    
    if ( !level.firefly_ww_quest.event_battlechatter.var_d5efe235b75756ea )
    {
        level thread function_7544b009dd330759( 0, player, level.firefly_ww_quest.event_battlechatter.var_d5efe235b75756ea );
    }
    
    level zm_quest::function_fb3af5600f6a9441( 3, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"unlock_symbol_lock" );
    level utility::delaythread( 2.5, &zm_quest::function_fb3af5600f6a9441, 2, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"unlock_symbol_lock" );
    level utility::delaythread( 2.75, &function_51f12524c830dd09 );
    level.firefly_ww_quest.s_vault utility::ent_flag_set( "is_wrong_input_spawn_zombies" );
    var_c6457b9450c88863 = getplayersinradius( level.firefly_ww_quest.s_vault.sbl.origin, 1200 );
    
    foreach ( player in var_c6457b9450c88863 )
    {
        if ( !zm_player::function_f37cfdf04b932a03( player ) )
        {
            continue;
        }
        
        player playrumblelooponentity( "low_highfreq" );
    }
    
    earthquake( 0.25, 5, level.firefly_ww_quest.s_vault.sbl.origin, 1200 );
    playsoundatpos( level.firefly_ww_quest.s_vault.sbl.origin, #"hash_7cfca44690359480" );
    vault_zone = zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( level.firefly_ww_quest.s_vault.sbl.origin ) );
    level.firefly_ww_quest.s_vault thread spawn_event_zombies( 500, 5, vault_zone, "symbol_lock", 800, undefined, "is_wrong_input_spawn_zombies", 1, 3, 10, 1, level.firefly_ww_quest.s_vault.sbl.origin );
    wait 5;
    var_c6457b9450c88863 = getplayersinradius( level.firefly_ww_quest.s_vault.sbl.origin, 1200 );
    
    foreach ( player in var_c6457b9450c88863 )
    {
        if ( !zm_player::function_f37cfdf04b932a03( player ) )
        {
            continue;
        }
        
        player stoprumble( "low_highfreq" );
    }
    
    for ( i = 0; i < level.firefly_ww_quest.var_e81a6e44cbb46236.size ; i++ )
    {
        s_vault_symbol = level.firefly_ww_quest.var_e81a6e44cbb46236[ i ];
        s_vault_symbol.var_bc4f329a58b0c98e = -1;
        
        if ( s_vault_symbol.group_number != 3 )
        {
            var_ddd47ec4b1da404 = [ "left_symbol", "right_symbol", "back_symbol" ][ s_vault_symbol.group_number ];
            level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( var_ddd47ec4b1da404, "default" );
        }
    }
    
    wait 1;
    level.firefly_ww_quest.s_vault utility::ent_flag_clear( "is_wrong_input_spawn_zombies" );
    level.firefly_ww_quest.s_vault utility::ent_flag_clear( "is_checking_input" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xf7656e63, Offset: 0xc045
// Size: 0x215
function private symbol_lock_cleanup( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level.firefly_ww_quest.s_vault utility::ent_flag_wait_all_array( [ "is_full", "is_symbols_show" ] );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"unlock_symbol_lock" );
    
    if ( !level.firefly_ww_quest utility::ent_flag( "wwq_first_time_completed" ) )
    {
        level zm_quest::clear_all_guidance();
    }
    
    for ( i = 0; i < level.firefly_ww_quest.var_e81a6e44cbb46236.size ; i++ )
    {
        s_vault_symbol = level.firefly_ww_quest.var_e81a6e44cbb46236[ i ];
        
        if ( s_vault_symbol.group_number != 3 )
        {
            var_ddd47ec4b1da404 = [ "left_symbol", "right_symbol", "back_symbol" ][ s_vault_symbol.group_number ];
            level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( var_ddd47ec4b1da404, "off" );
        }
        
        if ( isdefined( s_vault_symbol.interact ) )
        {
            s_vault_symbol.interact freescriptable();
        }
    }
    
    level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( "fx", "symbol_success" );
    wait 1;
    level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( "model", "open" );
    wait 1;
    level.firefly_ww_quest.s_vault.sbl notsolid();
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xad7d34a4, Offset: 0xc262
// Size: 0x6f7
function private function_d17e280d6fac9f17( b_skipped, b_save_restored )
{
    level utility::flag_wait( "initial_player_spawned" );
    
    if ( b_save_restored || b_skipped || level zm_quest::function_73720cdf21c3cfd7( #"firefly_ww_quest", #"ww_picked_up" ) )
    {
        return;
    }
    
    level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( "audio", "off" );
    level.firefly_ww_quest.var_1ccacaad7d794986 utility::ent_flag_clear( "is_sc_complete" );
    level.firefly_ww_quest utility::ent_flag_clear( "wwq_guidance_finished" );
    level.firefly_ww_quest utility::ent_flag_clear( "is_ww_picked_up" );
    
    if ( !isdefined( level.firefly_ww_quest.var_744bbf78fb616248 ) && common_item::items_isenabled() )
    {
        s_weapon_spawn = getscriptbundle( %"hash_e5db3b642aea010" );
        spawnoptions = common_item::function_bc5ff2958b71a708( level.firefly_ww_quest.ww_start_loc, level.firefly_ww_quest.var_1d5d2bed26821e5c );
        spawnoptions.var_fd47e835523b473f = 1;
        spawnoptions.var_5fa61841e327b2c8 = 1;
        spawnoptions.dropradiusscale = 0;
        spawnoptions.critical = 1;
        item_weapon = item_weapon::function_b960bc85ea91de14( s_weapon_spawn, spawnoptions );
        level.firefly_ww_quest.var_6c150f7629ea7156 = item_weapon;
        level.firefly_ww_quest.var_744bbf78fb616248 = item_weapon.weaponobj;
        level.firefly_ww_quest.var_7da8436789fe3152 = spawnoptions;
        level.firefly_ww_quest.var_77d66e21d01c77bb = s_weapon_spawn;
        level.firefly_ww_quest.var_6c150f7629ea7156.from_ww_quest = 1;
        level zombie_shade_loot_consume::function_2c1c775b372991b0( 0, undefined, undefined, undefined, [ item_weapon ] );
        
        if ( self.b_restarted )
        {
            level thread function_2da6f99d19c4ee28( level.firefly_ww_quest.ww_start_loc );
        }
        
        item_weapon setscriptablepartstate( #"obloot_custom_weapon", #"visible_original_position_no_stem" );
        item_weapon thread function_aa04f0de7fd161cc();
        level.firefly_ww_quest.s_vault utility::ent_flag_set( "ww_in_v" );
        level callback::remove( #"player_used_item", &function_c189445879836297 );
        level callback::add( #"player_used_item", &function_c189445879836297 );
    }
    
    var_38f42c598f72843e = level zm_quest::get_quest_step( #"firefly_pluto_upgrade", #"hash_173b92792d6221e1" );
    
    if ( var_38f42c598f72843e.completed )
    {
        level utility::delaythread( 1, &function_51f12524c830dd09 );
    }
    
    level.firefly_ww_quest.s_vault utility::ent_flag_wait( "ww_in_v" );
    
    while ( !isdefined( level.firefly_ww_quest.var_6c150f7629ea7156 ) )
    {
        wait 0.1;
    }
    
    link = utility::spawn_model( "tag_origin", level.firefly_ww_quest.ww_start_loc + ( 0, 0, 4 ), level.firefly_ww_quest.var_1d5d2bed26821e5c );
    
    if ( isdefined( level.firefly_ww_quest.var_6c150f7629ea7156.linkedparent ) )
    {
        level.firefly_ww_quest.var_6c150f7629ea7156 utility::scriptable_clearparententity();
    }
    
    level.firefly_ww_quest.var_6c150f7629ea7156 utility::scriptable_setparententity( link, ( 0, 0, -4 ) );
    link function_616378d7e5b22efb( level.firefly_ww_quest.var_1d5d2bed26821e5c, 0.8, 5, 5 );
    playfxontag( level._effect[ "pickup_cover" ], link, "tag_origin" );
    level.firefly_ww_quest.var_1ccacaad7d794986 utility::ent_flag_waitopen_any( "is_on_cooldown" );
    thread function_82b78368b531569();
    level.firefly_ww_quest utility::ent_flag_wait( "is_ww_picked_up" );
    level.firefly_ww_quest.s_vault utility::ent_flag_clear( "ww_in_v" );
    
    if ( link )
    {
        stopfxontag( level._effect[ "pickup_cover" ], link, "tag_origin" );
        link delete();
    }
    
    foreach ( clip in level.firefly_ww_quest.var_d69e4eb311b10cc7 )
    {
        clip disconnectpaths();
        clip solid();
    }
    
    vault_zone = zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( level.firefly_ww_quest.s_vault.sbl.origin ) );
    event_players = zone_manager::get_zone_occupants( vault_zone.zone_name );
    
    foreach ( player in event_players )
    {
        player val::set( "sc_event", "round_spawning_ignore_player", 1 );
    }
    
    level callback::add( "zone_changed", &function_193ef20f45479e53, vault_zone );
    level zone_spawner::function_2ce7db1d59b307d8( vault_zone.zone_name );
    farm_zones = [ "zone_farm", "zone_farm_cellar", "zone_farm_house", "zone_farm_rear", "zone_farm_barn", "zone_farm_gate", "zone_farm_garage", "zone_farm_close_to_tower", "zone_farm_road", "zone_farm_close_to_sunken" ];
    level thread zm_quest::cleanup_zombies_manually( undefined, farm_zones, undefined, undefined, 0, 0, undefined, 1, undefined, 0.5 );
    level.firefly_ww_quest.var_1ccacaad7d794986.sbl utility::delaythread( 2, &utility::function_32b24db3127bff40, "reveal", "show" );
    level.firefly_ww_quest.var_1ccacaad7d794986.sbl utility::delaythread( 2, &utility::function_32b24db3127bff40, "audio", "on" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xb3a30f82, Offset: 0xc961
// Size: 0xe1
function private function_aa04f0de7fd161cc()
{
    self endon( #"death" );
    level.firefly_ww_quest endon( #"is_ww_picked_up" );
    
    while ( !level.firefly_ww_quest utility::ent_flag( "is_ww_picked_up" ) )
    {
        foreach ( player in level.players )
        {
            if ( zm_player::function_f37cfdf04b932a03( player ) && player hasweapon( self.weaponobj ) )
            {
                self disablescriptableplayeruse( player );
                continue;
            }
            
            self enablescriptableplayeruse( player );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xa04b8b26, Offset: 0xca4a
// Size: 0x275
function private function_82b78368b531569()
{
    level endon( #"game_ended" );
    level.firefly_ww_quest endon( #"is_ww_picked_up" );
    
    if ( !level.firefly_ww_quest utility::ent_flag( "wwq_first_time_completed" ) || !level zm_sat_firefly::function_24006873400b7a8() )
    {
        return;
    }
    
    while ( !level.firefly_ww_quest utility::ent_flag( "is_ww_picked_up" ) )
    {
        if ( function_3343f083309374e3() )
        {
            if ( !level.firefly_ww_quest utility::ent_flag( "wwq_guidance_finished" ) )
            {
                level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_2628b3662d042f0c" );
                level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_ab5d1400594ebb61" );
                step_ref = level zm_sat_firefly::function_24006873400b7a8() ? #"complete" : #"hash_ab5d1400594ebb61";
                level zm_quest::function_fba942a1cfd85f5d( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", step_ref );
                level.firefly_ww_quest utility::ent_flag_set( "wwq_guidance_finished" );
                level thread zm_sat_firefly_script_pluto_upgrade::function_51f12524c830dd09();
                level thread zm_sat_firefly_script_mq::function_51f12524c830dd09();
            }
        }
        else if ( level.firefly_ww_quest utility::ent_flag( "wwq_guidance_finished" ) )
        {
            level.firefly_ww_quest utility::ent_flag_clear( "wwq_guidance_finished" );
            level zm_quest::function_fba942a1cfd85f5d( 1, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_2628b3662d042f0c" );
            level zm_quest::function_fb3af5600f6a9441( 2, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_2628b3662d042f0c" );
            level thread function_51f12524c830dd09();
        }
        
        wait 2;
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x9ca949a5, Offset: 0xccc7
// Size: 0xab
function private function_2da6f99d19c4ee28( org = ( 0, 0, 0 ), ang = ( 0, 0, 0 ) )
{
    fx_tag = utility::spawn_tag_origin( org, ang );
    fx_tag endon( #"death" );
    fx_tag show();
    playfxontag( level._effect[ "ww_teleport" ], fx_tag, "tag_origin" );
    wait 3;
    stopfxontag( level._effect[ "ww_teleport" ], fx_tag, "tag_origin" );
    
    if ( fx_tag )
    {
        fx_tag delete();
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x6b421216, Offset: 0xcd7a
// Size: 0x155
function private function_c189445879836297( params )
{
    if ( !( isdefined( params ) && isdefined( params.item.weaponobj ) && isdefined( level.firefly_ww_quest.var_6c150f7629ea7156 ) ) )
    {
        return;
    }
    
    if ( params.item != level.firefly_ww_quest.var_6c150f7629ea7156 )
    {
        return;
    }
    
    if ( isdefined( level.firefly_ww_quest.var_6c150f7629ea7156.linkedparent ) )
    {
        level.firefly_ww_quest.var_6c150f7629ea7156 utility::scriptable_clearparententity();
    }
    
    level.firefly_ww_quest utility::delaythread( 0.75, &weap_fireflyww::play_vo_banter, #"fww_ww_picked_up", 0, self );
    level.firefly_ww_quest utility::ent_flag_set( "is_ww_picked_up" );
    level.firefly_ww_quest notify( #"is_ww_picked_up" );
    level.firefly_ww_quest.var_6c150f7629ea7156 = params.item;
    level.firefly_ww_quest.ww_player = self;
    level callback::add( #"player_item_drop", &function_afcf822b791cf2ad );
    self switchtoweaponimmediate( params.item.weaponobj );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xd3bec726, Offset: 0xced7
// Size: 0x19c
function private function_afcf822b791cf2ad( params )
{
    waitframe();
    
    if ( !level.firefly_ww_quest utility::ent_flag( "is_ww_picked_up" ) )
    {
        return;
    }
    
    if ( !( isdefined( params ) && isdefined( params.item.weaponobj ) && isdefined( level.firefly_ww_quest.var_744bbf78fb616248 ) ) )
    {
        return;
    }
    
    if ( params.item.weaponobj != level.firefly_ww_quest.var_744bbf78fb616248 )
    {
        return;
    }
    
    if ( self != level.firefly_ww_quest.ww_player )
    {
        return;
    }
    
    level callback::remove( #"player_item_drop", &function_afcf822b791cf2ad );
    level.firefly_ww_quest endon( #"is_ww_picked_up" );
    level.firefly_ww_quest.var_6c150f7629ea7156 = params.item;
    level.firefly_ww_quest.var_6c150f7629ea7156 function_7653c765b6c7b815();
    level.firefly_ww_quest.var_6c150f7629ea7156 enablescriptableplayeruse( level.firefly_ww_quest.ww_player );
    wait 5;
    level thread function_2da6f99d19c4ee28( level.firefly_ww_quest.var_6c150f7629ea7156.origin );
    level.firefly_ww_quest.var_6c150f7629ea7156 = undefined;
    level.firefly_ww_quest.var_744bbf78fb616248 = undefined;
    
    if ( params.item )
    {
        params.item freescriptable();
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x2b29253a, Offset: 0xd07b
// Size: 0x2de
function private function_250933da8d3acb42( b_skipped, b_save_restored )
{
    var_56188aed30cdd4da = level zm_quest::get_quest_step( #"firefly_ww_quest", #"hash_2628b3662d042f0c" );
    
    if ( b_save_restored || b_skipped || var_56188aed30cdd4da.b_skipped || level zm_quest::function_73720cdf21c3cfd7( #"firefly_ww_quest", #"ww_picked_up" ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && level.firefly_ww_quest.var_1ccacaad7d794986.trigger && ispointinvolume( player.origin, level.firefly_ww_quest.var_1ccacaad7d794986.trigger ) )
        {
            var_c23d3df539fa470a = getgroundposition( level.firefly_ww_quest.var_13f3df23852d9c5a[ 1 ].origin, 5 );
            level thread zm_player::teleport_player( player, var_c23d3df539fa470a, player.angles );
        }
    }
    
    level thread function_51f12524c830dd09();
    wait 4;
    level.firefly_ww_quest.var_1ccacaad7d794986 utility::ent_flag_set( "is_sc_active" );
    level.firefly_ww_quest.var_1ccacaad7d794986 thread function_f8d3b8dee3b10254();
    level.firefly_ww_quest.var_1ccacaad7d794986 thread function_44ac8c1bc17fccf4();
    level.firefly_ww_quest.var_1ccacaad7d794986 utility::ent_flag_waitopen_any( "is_sc_active" );
    
    foreach ( clip in level.firefly_ww_quest.var_d69e4eb311b10cc7 )
    {
        clip connectpaths();
        clip notsolid();
    }
    
    if ( !level.firefly_ww_quest.var_1ccacaad7d794986 utility::ent_flag( "is_sc_complete" ) )
    {
        level zm_quest::clear_all_guidance();
        level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_ww_quest", var_56188aed30cdd4da.ref );
        level waittill( #"never" );
    }
    
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xee40859b, Offset: 0xd361
// Size: 0x461
function private function_f8d3b8dee3b10254()
{
    self.progress = 0;
    vault_zone = zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( level.firefly_ww_quest.s_vault.sbl.origin ) );
    
    if ( !isdefined( vault_zone ) )
    {
        vault_zone = level.firefly_ww_quest.ww_player zone_manager::get_current_zone();
    }
    
    var_259651d312d02011 = undefined;
    var_fa69bba90ee3aa = 0;
    wait 2;
    
    while ( utility::ent_flag( "is_sc_active" ) && var_fa69bba90ee3aa < 6 )
    {
        if ( isdefined( var_259651d312d02011 ) )
        {
            var_ab92adee957b096e = utility::function_6f5d2e1f1ff70482( gettime() ) - var_259651d312d02011;
            
            if ( var_ab92adee957b096e < 0.5 )
            {
                waitframe();
                continue;
            }
        }
        
        var_259651d312d02011 = utility::function_6f5d2e1f1ff70482( gettime() );
        var_1fcaa9d65aab7c5 = level.firefly_ww_quest.var_b023ec842afe3dd6[ var_fa69bba90ee3aa ];
        link = utility::spawn_model( "tag_origin", var_1fcaa9d65aab7c5.sbl.origin, vectortoangles( ( 0, 0, 1 ) ) );
        
        if ( isdefined( var_1fcaa9d65aab7c5.sbl.linkedparent ) )
        {
            var_1fcaa9d65aab7c5.sbl utility::scriptable_clearparententity();
        }
        
        var_1fcaa9d65aab7c5.sbl utility::scriptable_setparententity( link );
        link.origin = level.firefly_ww_quest.s_vault.sbl.origin;
        link.angles = level.firefly_ww_quest.s_vault.sbl.angles;
        var_1fcaa9d65aab7c5.sbl utility::function_32b24db3127bff40( "model", "traveling" );
        path_array = [ level.firefly_ww_quest.var_13f3df23852d9c5a[ 0 ].origin, level.firefly_ww_quest.var_13f3df23852d9c5a[ 1 ].origin, var_1fcaa9d65aab7c5.origin ];
        link utility::function_2159dd4196ff4b81( path_array, 1, 1, 0, 1, 1, 0.5, istrue( level.firefly_ww_quest.s_debug.var_c8f9a0cee2aaf3ad ) );
        
        if ( isdefined( var_1fcaa9d65aab7c5.sbl.linkedparent ) )
        {
            link.angles = var_1fcaa9d65aab7c5.angles;
            var_1fcaa9d65aab7c5.sbl utility::scriptable_clearparententity();
        }
        
        link delete();
        var_1fcaa9d65aab7c5.sbl utility::ent_flag_clear( "fireflyww_is_retrieved" );
        var_1fcaa9d65aab7c5 thread function_cb9ce5e40645338c();
        var_1fcaa9d65aab7c5.sbl utility::function_32b24db3127bff40( "model", "ready" );
        var_1fcaa9d65aab7c5.sbl utility::function_32b24db3127bff40( "ping", "idle" );
        
        if ( utility::ent_flag( "is_sc_active" ) && var_fa69bba90ee3aa < 6 )
        {
            level thread function_51f12524c830dd09();
        }
        
        var_fa69bba90ee3aa++;
        var_6ef24e4613588a04 = var_fa69bba90ee3aa / 6;
        
        if ( var_6ef24e4613588a04 >= 0.333333 && !utility::ent_flag( "is_sc_spawn_start" ) )
        {
            utility::ent_flag_set( "is_sc_spawn_start" );
            thread spawn_event_zombies( 500, 120, vault_zone, "sc_event", 800, undefined, "is_sc_active", 1, 3.75, 15, undefined, self.sbl.origin );
        }
    }
    
    utility::ent_flag_waitopen_any( "is_sc_active" );
    utility::ent_flag_clear( "is_sc_spawn_start" );
    
    foreach ( var_1fcaa9d65aab7c5 in level.firefly_ww_quest.var_b023ec842afe3dd6 )
    {
        var_1fcaa9d65aab7c5.sbl utility::ent_flag_set( "reset" );
        var_1fcaa9d65aab7c5 thread function_cb9ce5e40645338c();
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0xc
// Checksum 0xd9a42c96, Offset: 0xd7ca
// Size: 0x3e5
function private function_cb9ce5e40645338c()
{
    self notify( #"hash_9511982451c9f085" );
    self endon( #"hash_9511982451c9f085" );
    level endon( #"game_ended" );
    self.sbl endon( #"death" );
    
    while ( !self.sbl utility::ent_flag( "reset" ) )
    {
        if ( self.sbl.var_3542eed684e39d18 )
        {
            self.sbl utility::function_32b24db3127bff40( "model", "traveling_nofx" );
            break;
        }
        
        waitframe();
    }
    
    result = self.sbl utility::function_e2baa5896d5756cc( [ "reset", "fireflyww_is_retrieved" ] );
    
    if ( isdefined( self.sbl.linkedparent ) )
    {
        self.sbl utility::scriptable_clearparententity();
    }
    
    if ( level.firefly_ww_quest.var_1ccacaad7d794986 utility::ent_flag( "is_sc_active" ) && result == "fireflyww_is_retrieved" )
    {
        if ( isalive( level.firefly_ww_quest.ww_player ) )
        {
            level.firefly_ww_quest thread weap_fireflyww::play_vo_banter( #"hash_6ab9faf612440ca8", -1, level.firefly_ww_quest.ww_player, #"bc_flavor_player_positive" );
        }
        
        level.firefly_ww_quest.var_1ccacaad7d794986.progress++;
        level zm_quest::function_9f49b2a045ece8ae( level.firefly_ww_quest.var_1ccacaad7d794986.progress, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_ab5d1400594ebb61" );
        level thread function_51f12524c830dd09();
    }
    else if ( !level.firefly_ww_quest.var_1ccacaad7d794986 utility::ent_flag( "is_sc_complete" ) )
    {
        link = utility::spawn_model( "tag_origin", self.sbl.origin, self.sbl.angles );
        self.sbl utility::scriptable_setparententity( link );
        self.sbl utility::function_32b24db3127bff40( "model", "traveling" );
        path_array = [ self.origin, level.firefly_ww_quest.var_13f3df23852d9c5a[ 1 ].origin, level.firefly_ww_quest.var_13f3df23852d9c5a[ 0 ].origin ];
        link utility::function_2159dd4196ff4b81( path_array, 1, 1, 0, 1, 1, 0.5, istrue( level.firefly_ww_quest.s_debug.var_c8f9a0cee2aaf3ad ) );
        
        if ( isdefined( self.sbl.linkedparent ) )
        {
            link.origin = level.firefly_ww_quest.s_vault.sbl.origin;
            link.angles = level.firefly_ww_quest.s_vault.sbl.angles;
            self.sbl utility::scriptable_clearparententity();
        }
        
        link delete();
    }
    
    self.sbl utility::function_32b24db3127bff40( "model", "default" );
    self.sbl utility::function_32b24db3127bff40( "ping", "off" );
    self.sbl utility::ent_flag_clear( "reset" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x7f65d6f9, Offset: 0xdbb7
// Size: 0xa08
function private function_44ac8c1bc17fccf4()
{
    level endon( #"game_ended" );
    level notify( #"sc_event" );
    ww_player = level.firefly_ww_quest.ww_player;
    
    if ( level zm_sat_firefly::function_24006873400b7a8() )
    {
        level zm_quest::function_fba942a1cfd85f5d( 1, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_ab5d1400594ebb61" );
        level zm_quest::function_fb3af5600f6a9441( 2, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_ab5d1400594ebb61" );
        level zm_quest::function_9f49b2a045ece8ae( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_ab5d1400594ebb61" );
    }
    
    vault_zone = zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( level.firefly_ww_quest.s_vault.sbl.origin ) );
    
    if ( !isdefined( vault_zone ) )
    {
        vault_zone = ww_player zone_manager::get_current_zone();
    }
    
    event_players = zone_manager::get_zone_occupants( vault_zone.zone_name );
    level musicbank_utility::function_5aca66c390aa347d( event_players, #"hash_48842b7a7bb9bd25" );
    var_427b3d2c2f8fb546 = utility::function_6f5d2e1f1ff70482( gettime() );
    
    while ( true )
    {
        var_cb0209b713fe3e13 = utility::function_6f5d2e1f1ff70482( gettime() ) - var_427b3d2c2f8fb546;
        
        if ( var_cb0209b713fe3e13 > 120 )
        {
            /#
                logstring( "<dev string:x121>" );
            #/
            
            break;
        }
        
        if ( !isalive( ww_player ) || player::isinlaststand( ww_player ) )
        {
            /#
                logstring( "<dev string:x14c>" );
            #/
            
            break;
        }
        
        if ( !isdefined( level.firefly_ww_quest.var_744bbf78fb616248 ) )
        {
            /#
                logstring( "<dev string:x192>" );
            #/
            
            break;
        }
        
        if ( ww_player.mutantinjectiontransformed )
        {
            ww_player.var_cb1f8edf70251de = level.firefly_ww_quest.var_744bbf78fb616248;
            ww_player callback::remove( #"hash_d558db2dac47d5f7", &function_e2dad1e3b1d361cd );
            ww_player callback::add( #"hash_d558db2dac47d5f7", &function_e2dad1e3b1d361cd );
            
            /#
                logstring( "<dev string:x1f2>" );
            #/
            
            break;
        }
        
        if ( ww_player bgb::is_active( "anywhere_but_here" ) )
        {
            /#
                logstring( "<dev string:x236>" );
            #/
            
            break;
        }
        
        var_9764a587d92077ea = getplayersandaiarrayinradius( self.sbl.origin, 172 );
        
        if ( !arraycontains( var_9764a587d92077ea, ww_player ) )
        {
            /#
                logstring( "<dev string:x273>" );
            #/
            
            break;
        }
        
        if ( self.progress >= 6 )
        {
            if ( level zm_sat_firefly::function_24006873400b7a8() )
            {
                wait 1.5;
            }
            
            utility::ent_flag_set( "is_sc_complete" );
            break;
        }
        
        wait 0.5;
    }
    
    level.firefly_ww_quest.var_1ccacaad7d794986.sbl utility::function_32b24db3127bff40( "reveal", "hide" );
    level.firefly_ww_quest.var_1ccacaad7d794986.sbl utility::function_32b24db3127bff40( "audio", "stop" );
    level.firefly_ww_quest.s_vault.sbl utility::function_32b24db3127bff40( "fx", "blast" );
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"hash_48842b7a7bb9bd25" );
    event_players = zone_manager::get_zone_occupants( vault_zone.zone_name );
    
    foreach ( player in event_players )
    {
        player val::reset( "sc_event", "round_spawning_ignore_player" );
    }
    
    level callback::remove( #"player_item_drop", &function_afcf822b791cf2ad );
    level callback::remove( "zone_changed", &function_193ef20f45479e53, vault_zone );
    level thread utility::delaythreadendon( 8, "sc_event", &zone_spawner::function_8a020f24a3b73c79, vault_zone.zone_name );
    
    if ( !utility::ent_flag( "is_sc_complete" ) )
    {
        if ( !level.firefly_ww_quest.event_battlechatter.var_8e4cc1db01952c7 )
        {
            level thread function_7544b009dd330759( 0, player, level.firefly_ww_quest.event_battlechatter.var_8e4cc1db01952c7 );
        }
        
        playsoundatpos( level.firefly_ww_quest.s_vault.sbl.origin, #"hash_43bcf7d4de303295" );
        
        if ( isalive( ww_player ) )
        {
            ww_player.var_b4b5b6ea04345176 = player::isinlaststand( ww_player );
            
            if ( isdefined( level.firefly_ww_quest.var_744bbf78fb616248 ) && !ww_player.ismutantinjection )
            {
                ww_player inventory_utility::_takeweapon( level.firefly_ww_quest.var_744bbf78fb616248 );
                level.firefly_ww_quest.var_744bbf78fb616248 = undefined;
            }
            
            if ( !player::isinlaststand( ww_player ) && !ww_player.ismutantinjection && !ww_player.var_758feed359019083 && !ww_player isswitchingweapon() && !ww_player isgestureplaying() )
            {
                ww_player inventory_utility::forcevalidweapon();
            }
            
            level.firefly_ww_quest.ww_player = undefined;
        }
        
        level.firefly_ww_quest utility::ent_flag_clear( "is_ww_picked_up" );
        level.firefly_ww_quest utility::ent_flag_set( "showing_failure_ui" );
        level zm_quest::function_fb3af5600f6a9441( 3, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_ab5d1400594ebb61" );
        level zm_quest::function_9f49b2a045ece8ae( 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_ab5d1400594ebb61" );
        level.firefly_ww_quest utility::delaythread( 2, &zm_quest::function_fb3af5600f6a9441, 0, 1, level.zm_quests_steps[ #"firefly_ww_quest_guidance" ] && zm_sat_firefly::function_24006873400b7a8() ? #"firefly_ww_quest_guidance" : #"firefly_ww_quest", #"hash_ab5d1400594ebb61" );
        level.firefly_ww_quest utility::delaythread( 2, &utility::ent_flag_clear, "showing_failure_ui" );
        level thread function_2da6f99d19c4ee28( level.firefly_ww_quest.var_7da8436789fe3152.baseorigin );
        level utility::waittill_notify_or_timeout_return( "on_round_end", 2 );
        
        if ( common_item::items_isenabled() && ( !isalive( ww_player ) || !level.firefly_ww_quest.var_744bbf78fb616248 || ww_player.mutantinjectiontransformed ) )
        {
            spawnoptions = common_item::function_bc5ff2958b71a708( level.firefly_ww_quest.ww_start_loc, level.firefly_ww_quest.var_1d5d2bed26821e5c );
            spawnoptions.var_fd47e835523b473f = 1;
            spawnoptions.var_5fa61841e327b2c8 = 1;
            spawnoptions.dropradiusscale = 16;
            spawnoptions.critical = 1;
            item_weapon = item_weapon::function_b960bc85ea91de14( level.firefly_ww_quest.var_77d66e21d01c77bb, spawnoptions );
            level.firefly_ww_quest.var_744bbf78fb616248 = item_weapon.weaponobj;
            level.firefly_ww_quest.var_6c150f7629ea7156 = item_weapon;
        }
        
        if ( isdefined( level.firefly_ww_quest.var_6c150f7629ea7156 ) && isdefined( level.firefly_ww_quest.var_6c150f7629ea7156.weaponobj ) )
        {
            level zombie_shade_loot_consume::function_2c1c775b372991b0( 0, undefined, undefined, undefined, [ level.firefly_ww_quest.var_6c150f7629ea7156 ] );
            level.firefly_ww_quest.var_6c150f7629ea7156 utility::delaycall( 0.07, &function_7653c765b6c7b815 );
        }
        
        level thread function_51f12524c830dd09();
        utility::ent_flag_set( "is_on_cooldown" );
        utility::ent_flag_clear( "is_sc_active" );
        level.firefly_ww_quest.s_vault utility::ent_flag_set( "ww_in_v" );
        
        if ( level zm_quest::function_b0a5181ebe7bb905() )
        {
            wait 10;
        }
        else
        {
            level waittill( #"on_round_end" );
        }
        
        utility::ent_flag_clear( "is_on_cooldown" );
        
        if ( isdefined( level.firefly_ww_quest.var_6c150f7629ea7156 ) && isdefined( level.firefly_ww_quest.var_6c150f7629ea7156.weaponobj ) )
        {
            level.firefly_ww_quest.var_6c150f7629ea7156 notify( #"vault_usable" );
            level.firefly_ww_quest.var_6c150f7629ea7156 thread function_aa04f0de7fd161cc();
        }
        
        return;
    }
    
    playsoundatpos( level.firefly_ww_quest.s_vault.sbl.origin, #"hash_f5cadf7f51d06428" );
    utility::ent_flag_clear( "is_sc_active" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0xd015dcc2, Offset: 0xe5c7
// Size: 0x75
function private function_193ef20f45479e53( params, vault_zone )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    var_77898ab40e53d0ae = params.zone_struct;
    
    if ( vault_zone.zone_name == var_77898ab40e53d0ae.zone_name )
    {
        val::set( "sc_event", "round_spawning_ignore_player", 1 );
        return;
    }
    
    val::reset( "sc_event", "round_spawning_ignore_player" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0x632f3476, Offset: 0xe644
// Size: 0x65
function private function_e2dad1e3b1d361cd( params )
{
    if ( !isalive( self ) && isdefined( self.var_cb1f8edf70251de ) )
    {
        return;
    }
    
    inventory_utility::_takeweapon( self.var_cb1f8edf70251de );
    self.var_cb1f8edf70251de = undefined;
    inventory_utility::forcevalidweapon( self.primaryweapons[ 0 ] );
    callback::remove( #"hash_d558db2dac47d5f7", &function_e2dad1e3b1d361cd );
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x81387c64, Offset: 0xe6b1
// Size: 0x17f
function private function_d320084b93d98117( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level zm_quest::clear_all_guidance();
    }
    
    level thread zm_quest::update_round_cap( 12 );
    level magicbox::function_6c4ffb8218367c4b( %"hash_e5db3b642aea010", 4 );
    level magicbox::function_2e49cd8681e36211( 0 );
    
    foreach ( player in level.players )
    {
        player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_firefly_artifact_5" );
    }
    
    level.firefly_ww_quest.var_1ccacaad7d794986 utility::ent_flag_set( "is_sc_complete" );
    level.firefly_ww_quest utility::delaythread( 2, &zm_sat_firefly_script_mq::function_51f12524c830dd09 );
    level.firefly_ww_quest utility::delaythread( 2, &utility::ent_flag_set, "wwq_guidance_finished" );
    level.firefly_ww_quest utility::ent_flag_set( "wwq_first_time_completed" );
    level thread function_81b5d6dfef068a01();
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_ww_quest", #"ww_picked_up", 1 );
    level callback::remove( #"player_used_item", &function_c189445879836297 );
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0x96e27eb9, Offset: 0xe838
// Size: 0xcb
function private function_81b5d6dfef068a01()
{
    player = level.firefly_ww_quest.ww_player;
    
    /#
        if ( !isplayer( player ) )
        {
            player = level.players[ 0 ];
        }
    #/
    
    zm_quest::function_8934bb2a9028bdc5();
    wait 1;
    level.firefly_ww_quest weap_fireflyww::play_vo_banter( #"hash_86fdd551c833af59", -1, player, #"hash_5212ed7ec42f115a" );
    
    if ( !level.firefly_ww_quest.var_4e3217aa99440872 )
    {
        level.firefly_ww_quest.var_4e3217aa99440872 = 1;
        wait 5;
        zm_quest::play_vo_events( [ #"hash_e3a088adc861cd25" ] );
        level.firefly_ww_quest weap_fireflyww::play_vo_banter( #"hash_e3a088adc861cd25", -1 );
    }
}

// Namespace zm_sat_firefly_ww_quest
// Params 2, eflags: 0x4
// Checksum 0x6aea7f76, Offset: 0xe90b
// Size: 0x1d2
function private respawn_ww_cleanup( b_skipped, b_save_restored )
{
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_ww_quest", #"hash_9227e1eff29cebb3", 1 );
    
    if ( !level callback::exists( #"player_death", &function_674f565359a341d1 ) )
    {
        level callback::add( #"player_death", &function_674f565359a341d1 );
    }
    
    if ( !level callback::exists( #"player_disconnect", &function_674f565359a341d1 ) )
    {
        level callback::add( #"player_disconnect", &function_674f565359a341d1 );
    }
    
    if ( !level callback::exists( #"player_item_drop", &function_c855f7617917942e ) )
    {
        level callback::add( #"player_item_drop", &function_c855f7617917942e );
    }
    
    level.firefly_ww_quest utility::ent_flag_wait( "is_ww_resp" );
    level.firefly_ww_quest utility::ent_flag_clear( "is_ww_resp" );
    level callback::remove( #"player_death", &function_674f565359a341d1 );
    level callback::remove( #"player_disconnect", &function_674f565359a341d1 );
    level callback::remove( #"player_item_drop", &function_c855f7617917942e );
    level zm_quest::function_6265be8d0549e1b1( #"firefly_ww_quest", #"hash_9227e1eff29cebb3" );
    level zm_quest::function_6265be8d0549e1b1( #"firefly_ww_quest", #"ww_picked_up" );
    level.firefly_ww_quest.var_6c150f7629ea7156 = undefined;
    level.firefly_ww_quest.var_744bbf78fb616248 = undefined;
    var_56188aed30cdd4da = level zm_quest::get_quest_step( #"firefly_ww_quest", #"hash_2628b3662d042f0c" );
    level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_ww_quest", var_56188aed30cdd4da.ref );
    level waittill( #"never" );
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xa9955a0c, Offset: 0xeae5
// Size: 0x7c
function private function_674f565359a341d1( sparams )
{
    player = sparams.victim ?? self;
    
    if ( player function_3343f083309374e3() || level.firefly_ww_quest.var_b60c1fd3b1677216.size > 0 )
    {
        return;
    }
    
    level.firefly_ww_quest utility::ent_flag_set( "is_ww_resp" );
    
    /#
        logstring( "<dev string:x2bb>" );
    #/
    
    /#
        iprintlnbold( "<dev string:x2bb>" );
    #/
}

// Namespace zm_sat_firefly_ww_quest
// Params 1, eflags: 0x4
// Checksum 0xbc674f23, Offset: 0xeb69
// Size: 0x134
function private function_c855f7617917942e( sparams )
{
    waitframe();
    
    if ( sparams.item.weaponobj.basename != "sat_ww_firefly_zm" )
    {
        return;
    }
    
    if ( !isdefined( level.firefly_ww_quest.var_b60c1fd3b1677216 ) )
    {
        level.firefly_ww_quest.var_b60c1fd3b1677216 = [];
    }
    
    level.firefly_ww_quest.var_b60c1fd3b1677216[ level.firefly_ww_quest.var_b60c1fd3b1677216.size ] = sparams.item;
    sparams.item waittill( #"death" );
    
    if ( function_3343f083309374e3() || sparams.item.pickedup )
    {
        level.firefly_ww_quest.var_b60c1fd3b1677216 = arrayremove( level.firefly_ww_quest.var_b60c1fd3b1677216, sparams.item );
        return;
    }
    
    level.firefly_ww_quest utility::ent_flag_set( "is_ww_resp" );
    
    /#
        logstring( "<dev string:x2f8>" );
    #/
    
    /#
        iprintlnbold( "<dev string:x2f8>" );
    #/
}

// Namespace zm_sat_firefly_ww_quest
// Params 0, eflags: 0x4
// Checksum 0xe3630d14, Offset: 0xeca5
// Size: 0x114, Type: bool
function private function_3343f083309374e3()
{
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        foreach ( weapon in player.weaponlist )
        {
            if ( weapon.basename != "sat_ww_firefly_zm" )
            {
                continue;
            }
            
            if ( self == player )
            {
                continue;
            }
            
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace zm_sat_firefly_ww_quest
    // Params 0
    // Checksum 0x5579997f, Offset: 0xedc2
    // Size: 0x41e, Type: dev
    function ww_debug_init()
    {
        if ( !level.firefly_ww_quest.s_vault.sbl )
        {
            return;
        }
        
        level.firefly_ww_quest.s_debug = spawnstruct();
        
        if ( !isdefined( level.firefly_ww_quest.s_debug.var_3c53e6bf591666f3 ) )
        {
            level.firefly_ww_quest.s_debug.var_3c53e6bf591666f3 = 1;
        }
        
        if ( !isdefined( level.firefly_ww_quest.s_debug.var_c8f9a0cee2aaf3ad ) )
        {
            level.firefly_ww_quest.s_debug.var_c8f9a0cee2aaf3ad = 0;
        }
        
        zm_quest::function_bc99f123a684344f( #"firefly_ww_quest" );
        devgui::add_devgui_func( "<dev string:x338>", "<dev string:x353>", &function_4c3f2d6c20077019 );
        zm_quest::function_c1400a2f4670c23f();
        
        foreach ( step in level.firefly_ww_quest.steps )
        {
            zm_quest::function_1b5b11caffa04d9a( #"firefly_ww_quest", step.ref );
            
            switch ( step.index )
            {
                case 1:
                case 2:
                case 3:
                    path = "<dev string:x369>";
                    var_3e012a6d0afcac8c = level.firefly_ww_quest.var_f9f72736451013bb.origin;
                    devgui::function_cd4e263c1f3018ae( path, "<dev string:x385>" + var_3e012a6d0afcac8c[ 0 ] + "<dev string:x396>" + var_3e012a6d0afcac8c[ 1 ] + "<dev string:x396>" + var_3e012a6d0afcac8c[ 2 ], &function_82d34688b32c0fb );
                    break;
                case 4:
                    path = "<dev string:x398>";
                    var_3e012a6d0afcac8c = getclosestpointonnavmesh( level.firefly_ww_quest.var_c1f736e2f66ad165.origin );
                    devgui::function_cd4e263c1f3018ae( path, "<dev string:x385>" + var_3e012a6d0afcac8c[ 0 ] + "<dev string:x396>" + var_3e012a6d0afcac8c[ 1 ] + "<dev string:x396>" + var_3e012a6d0afcac8c[ 2 ], &function_82d34688b32c0fb );
                    path = "<dev string:x3ba>";
                    var_3e012a6d0afcac8c = getclosestpointonnavmesh( level.firefly_ww_quest.var_e923a8986534e479.origin );
                    devgui::function_cd4e263c1f3018ae( path, "<dev string:x385>" + var_3e012a6d0afcac8c[ 0 ] + "<dev string:x396>" + var_3e012a6d0afcac8c[ 1 ] + "<dev string:x396>" + var_3e012a6d0afcac8c[ 2 ], &function_82d34688b32c0fb );
                    path = "<dev string:x3d5>";
                    var_3e012a6d0afcac8c = getclosestpointonnavmesh( level.firefly_ww_quest.var_ebc7351f6a37a33e.origin );
                    devgui::function_cd4e263c1f3018ae( path, "<dev string:x385>" + var_3e012a6d0afcac8c[ 0 ] + "<dev string:x396>" + var_3e012a6d0afcac8c[ 1 ] + "<dev string:x396>" + var_3e012a6d0afcac8c[ 2 ], &function_82d34688b32c0fb );
                    devgui::function_cd4e263c1f3018ae( "<dev string:x3f0>", "<dev string:x402>", &function_a4780d2bb3c1eea6 );
                    devgui::function_cd4e263c1f3018ae( "<dev string:x414>", "<dev string:x426>", &function_a4780d2bb3c1eea6 );
                    devgui::function_cd4e263c1f3018ae( "<dev string:x438>", "<dev string:x44a>", &function_a4780d2bb3c1eea6 );
                    devgui::function_cd4e263c1f3018ae( "<dev string:x45c>", "<dev string:x46b>", &function_dc6eb903454306e4 );
                    break;
                case 7:
                    devgui::function_cd4e263c1f3018ae( "<dev string:x47b>", "<dev string:x48e>", &function_bf04bc2bcd54fc49 );
                default:
                    path = "<dev string:x4a2>";
                    var_3e012a6d0afcac8c = level.firefly_ww_quest.s_vault.sbl.origin;
                    devgui::function_cd4e263c1f3018ae( path, "<dev string:x385>" + var_3e012a6d0afcac8c[ 0 ] + "<dev string:x396>" + var_3e012a6d0afcac8c[ 1 ] + "<dev string:x396>" + var_3e012a6d0afcac8c[ 2 ], &function_82d34688b32c0fb );
                    break;
            }
            
            zm_quest::function_394bdba74beda0aa();
        }
    }

    // Namespace zm_sat_firefly_ww_quest
    // Params 1, eflags: 0x4
    // Checksum 0xe8ea48c8, Offset: 0xf1e8
    // Size: 0x82, Type: dev
    function private function_82d34688b32c0fb( params )
    {
        x = float( params[ 0 ] );
        y = float( params[ 1 ] );
        z = float( params[ 2 ] );
        var_3e012a6d0afcac8c = ( x, y, z );
        var_bd04bf9737ce7846 = getclosestpointonnavmesh( var_3e012a6d0afcac8c );
        player = level.players[ 0 ];
        player setorigin( var_bd04bf9737ce7846 );
    }

    // Namespace zm_sat_firefly_ww_quest
    // Params 0, eflags: 0x4
    // Checksum 0xbb126c84, Offset: 0xf272
    // Size: 0x6c, Type: dev
    function private function_4c3f2d6c20077019()
    {
        level.firefly_ww_quest.s_debug.var_3c53e6bf591666f3 = !level.firefly_ww_quest.s_debug.var_3c53e6bf591666f3;
        
        /#
            iprintlnbold( "<dev string:x4b7>" + level.firefly_ww_quest.s_debug.var_3c53e6bf591666f3 );
        #/
    }

    // Namespace zm_sat_firefly_ww_quest
    // Params 1, eflags: 0x4
    // Checksum 0xca22f523, Offset: 0xf2e6
    // Size: 0xc8, Type: dev
    function private function_a4780d2bb3c1eea6( params )
    {
        progress = params[ 0 ];
        level.firefly_ww_quest.var_7beabd5eecea599c.progress = int( progress );
        level.firefly_ww_quest.var_7beabd5eecea599c.b_dev_skip = 1;
        setup_energy_step = level.firefly_ww_quest.steps[ 4 ];
        skip_params = [ setup_energy_step.ref ];
        zm_quest::function_11b75e2232ce3d4( skip_params );
        zm_quest::clear_all_guidance();
        level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_ww_quest", setup_energy_step.ref );
    }

    // Namespace zm_sat_firefly_ww_quest
    // Params 1, eflags: 0x4
    // Checksum 0x83f96157, Offset: 0xf3b6
    // Size: 0x76, Type: dev
    function private function_bf04bc2bcd54fc49( params )
    {
        level.firefly_ww_quest.s_debug.var_c8f9a0cee2aaf3ad = !level.firefly_ww_quest.s_debug.var_c8f9a0cee2aaf3ad;
        
        /#
            iprintlnbold( "<dev string:x4b7>" + level.firefly_ww_quest.s_debug.var_c8f9a0cee2aaf3ad );
        #/
    }

    // Namespace zm_sat_firefly_ww_quest
    // Params 1, eflags: 0x4
    // Checksum 0x5c332bb7, Offset: 0xf434
    // Size: 0x4d, Type: dev
    function private function_dc6eb903454306e4( params )
    {
        level.firefly_ww_quest utility::ent_flag_set( "<dev string:x4d0>" );
        level.firefly_ww_quest utility::delaythread( 2, &utility::ent_flag_clear, "<dev string:x4d0>" );
        
        /#
            iprintlnbold( "<dev string:x4e1>" );
        #/
    }

#/
