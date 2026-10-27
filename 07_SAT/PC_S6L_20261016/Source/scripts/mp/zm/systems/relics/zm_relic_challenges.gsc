// scripts\mp\zm\systems\relics\zm_relic_challenges.gsc  (hash_31e159e3b40e909e.gscc) (size: 44500 Bytes / 0xadd4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x44ca2e24 (1154100772)
// size ...... 44500 (0xadd4)
// includes .. 24  (offset: 0xa318)
// strings ... 105 (offset: 0xa3d8)
// dev strs .. 51  (offset: 0xaa50)
// exports ... 72  (offset: 0x7a64)
// cseg ...... 0x759 + 0x730b (0x7a64)
// imports ... 223 (offset: 0x85a4)
// animtree1 . 0   (offset: 0xadd4)
// animtree2 . 0   (offset: 0xadd4)
#using script_16ea1b94f0f381b3;
#using script_4bf223434bdc0646;
#using script_61b40095fd0502f0;
#using scripts\common\ae_utility;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_loot_consume;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\relics\zm_relics;
#using scripts\mp\zm\systems\zm_exfil_sat;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;

#namespace zm_relic_challenges;

// Namespace zm_relic_challenges
// Params 0, eflags: 0x5
// Checksum 0xfca20116, Offset: 0x777
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_relic_challenges", undefined, undefined, &function_678266d57d8dc10b );
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0x38498a3a, Offset: 0x798
// Size: 0x34
function function_678266d57d8dc10b()
{
    if ( !getdvarint( @"hash_efdacc1f05df4bb2" ) && !level.var_8a98c33a6b47db4a )
    {
        return;
    }
    
    level thread function_46318015d84d9c9c();
    
    /#
        init_relic_challenge_debug();
    #/
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0x410c38df, Offset: 0x7d4
// Size: 0xea
function function_46318015d84d9c9c()
{
    utility::registersharedfunc( #"relics", #"start_relic_challenge", &start_relic_challenge );
    utility::registersharedfunc( #"relics", #"hash_92f85ae2899481f9", &function_f4e21bb3d60470a2 );
    utility::registersharedfunc( #"relics", #"end_relic_challenge", &end_relic_challenge );
    level._effect[ #"hash_c8bb89e284b41a34" ] = loadfxasset( "vfx_t10_gameplay_zm_points_of_power_trap_inside_3p" );
    level._effect[ #"egg_trail" ] = loadfxasset( "vfx_t10_gameplay_zm_loot_trail_legendary" );
    callback::add( #"relic_challenge_ended", &function_478f86b7a9f3719c );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"start_relic_challenge", &function_b03373a907a5d47c );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"end_relic_challenge", &end_relic_challenge );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_81cef8565801bc72", &function_dae076aac4ed4a4d );
}

// Namespace zm_relic_challenges
// Params 5
// Checksum 0xd96f899e, Offset: 0x8c6
// Size: 0x8a
function register_relic_challenge_functions( var_13966754f1d14be6, var_c566bafc8de72e52, var_758e205ec8d1c0a9, var_6682abccda33a41, var_10d9037598090239 )
{
    utility::registersharedfunc( var_13966754f1d14be6, #"hash_cb02e0a4c4ea830d", var_c566bafc8de72e52 );
    utility::registersharedfunc( var_13966754f1d14be6, #"hash_1ce3a63041775f04", var_758e205ec8d1c0a9 );
    
    if ( var_6682abccda33a41 )
    {
        utility::registersharedfunc( var_13966754f1d14be6, #"hash_e042082431a803da", var_6682abccda33a41 );
    }
    
    if ( var_10d9037598090239 )
    {
        utility::registersharedfunc( var_13966754f1d14be6, #"hash_f50e57484a42476e", var_10d9037598090239 );
    }
}

// Namespace zm_relic_challenges
// Params 3
// Checksum 0x8769935f, Offset: 0x958
// Size: 0xb87
function start_relic_challenge( relic_hash, var_c5018437db1be57d, warp_location )
{
    self notify( #"hash_a3d01dce1a38e8db" );
    self endon( #"hash_a3d01dce1a38e8db" );
    
    if ( !isdefined( level.zm_relics ) )
    {
        return;
    }
    
    relic_challenge_bundle = level.zm_relics[ relic_hash ].zmrelicchallenge;
    
    if ( !isxhashasset( relic_challenge_bundle ) )
    {
        relic_challenge_bundle = getxhashasset( "relic_challenge:" + relic_challenge_bundle );
    }
    
    level.active_relic_challenge = {};
    level.active_relic_challenge.bundle = getscriptbundle( relic_challenge_bundle );
    level.active_relic_challenge.relic_hash = relic_hash;
    level.active_relic_challenge.warp_location = warp_location;
    level zm_relics::function_8603fa8bc8d11175();
    level utility::waittill_any_timeout( 3, "relics_deactivated" );
    level thread utility::callsharedfunc( level.active_relic_challenge.bundle.modifiertype, #"hash_cb02e0a4c4ea830d" );
    level thread function_a67deb554faab7b6();
    level.active_relic_challenge.var_3a04ef2068c13fc9 = 1;
    level.active_relic_challenge.max_waves = level.active_relic_challenge.bundle.waveamount;
    level.active_relic_challenge.kills = 0;
    level.active_relic_challenge.pause_wave = 1;
    level.active_relic_challenge.wave_stage = "none";
    level.active_relic_challenge.wave_phase = "WAVE_BASE";
    
    if ( !isdefined( level.active_relic_challenge.zombie_spawns ) )
    {
        level.active_relic_challenge.zombie_spawns = 0;
    }
    
    level.active_relic_challenge.objective_ids = [];
    level.active_relic_challenge.var_189abf4197963d87 = 1;
    level.active_relic_challenge.var_5a5572cb1045b08f = level.active_relic_challenge.bundle.waveamount;
    
    if ( level.active_relic_challenge.bundle.var_bdc2eceba3810f8 > 0 )
    {
        level.active_relic_challenge.var_5a5572cb1045b08f = level.active_relic_challenge.bundle.var_bdc2eceba3810f8;
    }
    
    function_720b5a51388b94b5();
    level.active_relic_challenge.var_d4cfa5fb0531122c = [];
    
    foreach ( entry in level.active_relic_challenge.bundle.enemy_spawn_overrides )
    {
        level.active_relic_challenge.var_d4cfa5fb0531122c[ entry.overridesubclass ] = entry.spawnersubclass;
    }
    
    post_fx_name = "super_aether_shroud";
    level.active_relic_challenge.postfxbundle = level.field_upgrade_bundles[ post_fx_name ].var_67f9d640c30063e7;
    
    if ( level.zm_relics[ relic_hash ].tier )
    {
        switch ( level.zm_relics[ relic_hash ].tier )
        {
            case 1:
                post_fx_name = level.zm_relic_tier_bundles[ "easy" ].var_32140760af0ab16f;
                break;
            case 2:
                post_fx_name = level.zm_relic_tier_bundles[ "medium" ].var_32140760af0ab16f;
                break;
            case 3:
                post_fx_name = level.zm_relic_tier_bundles[ "hard" ].var_32140760af0ab16f;
                break;
            default:
                break;
        }
        
        level.active_relic_challenge.postfxbundle = post_fx_name;
        
        if ( level.active_relic_challenge.postfxbundle_override )
        {
            level.active_relic_challenge.postfxbundle = level.active_relic_challenge.postfxbundle_override;
        }
        
        foreach ( player in level.players )
        {
            if ( !getdvarint( @"hash_53fdf0902a70f4dd" ) )
            {
                pbgpostfxbundlestart( player, level.active_relic_challenge.postfxbundle );
            }
        }
        
        utility::callsharedfunc( #"relics", #"hash_740ebfbd9ecd064f", level.zm_relics[ relic_hash ].tier );
        level utility::callsharedfunc( #"relics", #"hash_fffe3af0c01c0420", level.zm_relics[ relic_hash ].tier );
    }
    
    level.active_relic_challenge.post_fx_name = post_fx_name;
    zm_round_spawning::pause_round_spawning( 1, "relic_challenge_begin" );
    level utility::callsharedfunc( #"relics", #"hash_ef2fe1dfec487c71" );
    ais_nuked = getaiarray( "team_two_hundred" );
    
    foreach ( ai in ais_nuked )
    {
        if ( ai.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.ejectedsubclass )
        {
            ai.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.ejectedsubclass = undefined;
        }
    }
    
    function_fa45a45eabc7f559();
    zm_quest::function_943d56a5fe5194de( 1, ais_nuked );
    kills_to_add = 0;
    
    switch ( level.players.size )
    {
        case 2:
            kills_to_add = level.active_relic_challenge.bundle.var_775c5e44423ff508;
            break;
        case 3:
            kills_to_add = level.active_relic_challenge.bundle.var_34a3ccb38a2d4293;
            break;
        case 4:
            kills_to_add = level.active_relic_challenge.bundle.var_65298c51cc7a904a;
            break;
        default:
            break;
    }
    
    level.active_relic_challenge.bundle.var_f528330bcb9dbd5c.killsneeded += kills_to_add;
    level.active_relic_challenge.bundle.var_1b60eba83ccfc385.killsneeded += kills_to_add;
    level.active_relic_challenge.bundle.var_68c10c658bb1eaf.killsneeded += kills_to_add;
    quest_bundle = getscriptbundle( level.active_relic_challenge.bundle.var_ed2af4ca9756d69f );
    zm_quest::function_61f7df5fddf96cd1();
    zm_quest::function_cd1f2fee4749fb0a( 1, quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    zm_quest::function_9f49b2a045ece8ae( 0, 1, quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    zm_quest::function_bf63bf6d044ad598( level.active_relic_challenge.var_189abf4197963d87, 1, quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    zm_quest::function_49f2a6a3c1320a6d( level.active_relic_challenge.var_5a5572cb1045b08f, 1, quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    level.active_relic_challenge.quest_bundle = quest_bundle;
    level.active_relic_challenge.fog_scriptables = [];
    level callback::add( "on_relic_challenge_objective_updated", &function_c8a0f59f58a21a44 );
    level callback::callback( "on_relic_challenge_objective_updated" );
    zm_quest::function_3c363613c60958f5( "relic_challenge_active" );
    level utility::flag_set( "relic_challenge_active" );
    level.var_9075568a1189c7c9 = 1;
    level.disable_fasttravel = 1;
    level thread function_e2a39d56b9a0431b();
    level thread function_1a2172027f36bef8();
    level callback::add( #"on_ai_killed", &function_a76f7bc479248301 );
    level callback::add( #"player_spawned", &on_player_spawn );
    level callback::add( "special_round_start", &function_a67deb554faab7b6 );
    level callback::add( "on_zombie_viper_eject", &on_zombie_viper_eject );
    level callback::callback( #"relic_challenge_started" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_1c1045bc5f007321" );
    
    foreach ( player in level.players )
    {
        player playlocalsound( #"hash_3a6f936f234c0772" );
        player.is_in_dark_aether = 1;
        player.is_in_relic_challenge = 1;
        
        if ( player.dawg )
        {
            player notify( #"killstreak_cancel" );
            player callback::callback( #"killstreak_cancel" );
            player.dawg dawg::dawg_self_destruct();
        }
    }
    
    if ( level utility::flag( "exfil_window_active" ) )
    {
        zm_exfil_sat::function_e6d25909c7962ebf( "disable" );
        zm_exfil_sat::zm_exfil_objective_icon( 0 );
    }
    
    level thread function_c9f01891fea40763();
    level thread function_c2e2628a2153edd9();
}

// Namespace zm_relic_challenges
// Params 1
// Checksum 0x74655c8f, Offset: 0x14e7
// Size: 0x509
function function_c9f01891fea40763( round_number )
{
    self notify( #"hash_2fba497a12bbedc7" );
    self endon( #"hash_2fba497a12bbedc7" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    level.exec_relic_challenge = 1;
    
    while ( level.exec_relic_challenge )
    {
        if ( level.active_relic_challenge.pause_spawning )
        {
            while ( level.active_relic_challenge.pause_spawning )
            {
                wait 1;
            }
        }
        
        wavestage = function_d07ee4921bf4e74b( level.active_relic_challenge.var_3a04ef2068c13fc9 );
        var_b0245466ae6c8a7a = function_d07ee4921bf4e74b( level.active_relic_challenge.var_3a04ef2068c13fc9 + 1 );
        
        if ( ( wavestage != var_b0245466ae6c8a7a || level.active_relic_challenge.var_3a04ef2068c13fc9 == level.active_relic_challenge.max_waves ) && level.active_relic_challenge.wave_phase == "WAVE_BASE" )
        {
            level.active_relic_challenge.wave_phase = "WAVE_BASE_MILESTONE";
        }
        
        function_149962a238edbe60( wavestage );
        zombie_spawn_interval = function_c64bef3463dfa312();
        level.active_relic_challenge.wave_stage = wavestage;
        var_1c3d219b34d9181b = level.active_relic_challenge.bundle.var_618de9e73de3a48d;
        round_number = zm_round_logic::get_rb_round_number();
        round_number = maxint( round_number, var_1c3d219b34d9181b );
        
        if ( !isdefined( level.active_relic_challenge.waveinfo.var_d52e7c104c81b620 ) )
        {
            level.active_relic_challenge.waveinfo.var_d52e7c104c81b620 = level.var_a009ab14ee0d3223.var_63a0ca44b877a390;
        }
        
        max_zombies = clampint( level.active_relic_challenge.waveinfo.var_d52e7c104c81b620, 1, level.var_a009ab14ee0d3223.var_63a0ca44b877a390 );
        
        foreach ( player in level.players )
        {
            var_c60105d2445aa45f = "zombie_base";
            var_c60105d2445aa45f = get_zombie_subclass_to_spawn();
            var_cd0d7d20957ea238 = var_c60105d2445aa45f;
            
            if ( level.active_relic_challenge.var_d4cfa5fb0531122c[ var_cd0d7d20957ea238 ] )
            {
                var_cd0d7d20957ea238 = level.active_relic_challenge.var_d4cfa5fb0531122c[ var_cd0d7d20957ea238 ];
            }
            
            zmb_spawner = zone_spawner::select_spawn_loc( var_cd0d7d20957ea238, undefined, 1 );
            
            if ( level.active_relic_challenge.zombie_spawns < max_zombies )
            {
                level thread function_fcc576ce75ae207c( var_c60105d2445aa45f, zmb_spawner, round_number );
            }
            
            if ( level.active_relic_challenge.wave_phase == "WAVE_SPECIAL" || level.active_relic_challenge.wave_phase == "WAVE_ELITE" )
            {
                var_827e514206fd3d08 = function_312bb4d3627a90f3();
                var_c60105d2445aa45f = var_827e514206fd3d08[ 0 ];
                milestone_type = var_827e514206fd3d08[ 1 ];
                
                if ( level.active_relic_challenge.zombie_spawns < level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
                {
                    var_4dd2d8ec20913af9 = level.active_relic_challenge.milestone_enemies[ milestone_type ].spawns_max;
                    milestone_zombie_count = level.active_relic_challenge.milestone_enemies[ milestone_type ].spawns.size;
                    milestone_kill_amount = level.active_relic_challenge.milestone_enemies[ milestone_type ].kills;
                    var_e1181bcbdc3a70e7 = level.active_relic_challenge.milestone_enemies[ milestone_type ].spawn_amount;
                    reserved_slots = level.active_relic_challenge.milestone_enemies[ milestone_type ].var_d74c533c8c787344 ?? 0;
                    
                    if ( var_c60105d2445aa45f != "none" && milestone_zombie_count < var_4dd2d8ec20913af9 && milestone_kill_amount + milestone_zombie_count + reserved_slots < var_e1181bcbdc3a70e7 )
                    {
                        var_cd0d7d20957ea238 = var_c60105d2445aa45f;
                        
                        if ( level.active_relic_challenge.var_d4cfa5fb0531122c[ var_cd0d7d20957ea238 ] )
                        {
                            var_cd0d7d20957ea238 = level.active_relic_challenge.var_d4cfa5fb0531122c[ var_cd0d7d20957ea238 ];
                        }
                        
                        zmb_spawner = zone_spawner::select_spawn_loc( var_cd0d7d20957ea238, undefined, 1 );
                        level thread function_fcc576ce75ae207c( var_c60105d2445aa45f, zmb_spawner, round_number, milestone_type );
                        wait 2;
                    }
                }
            }
            
            wait 0.1;
        }
        
        wait zombie_spawn_interval;
    }
}

// Namespace zm_relic_challenges
// Params 1
// Checksum 0x895a8e53, Offset: 0x19f8
// Size: 0xad
function function_d07ee4921bf4e74b( Wave )
{
    var_6479ffdd9d94769b = Wave / level.active_relic_challenge.bundle.waveamount;
    wave_stage = "EARLY";
    
    if ( var_6479ffdd9d94769b >= ( level.active_relic_challenge.bundle.var_8507b70b3844950e ?? 0.5 ) )
    {
        wave_stage = "MID";
    }
    
    if ( var_6479ffdd9d94769b >= ( level.active_relic_challenge.bundle.var_98bad84bf937e26c ?? 0.7 ) )
    {
        wave_stage = "LATE";
    }
    
    return wave_stage;
}

// Namespace zm_relic_challenges
// Params 1
// Checksum 0xe2088e5, Offset: 0x1aae
// Size: 0x250
function function_149962a238edbe60( wavestage )
{
    switch ( wavestage )
    {
        case #"hash_1093cc9874dcca5c":
            level.active_relic_challenge.waveinfo = level.active_relic_challenge.bundle.var_f528330bcb9dbd5c;
            break;
        case #"hash_17970e6c9cbefa65":
            level.active_relic_challenge.waveinfo = level.active_relic_challenge.bundle.var_1b60eba83ccfc385;
            break;
        case #"hash_f2d854ff09e04b81":
            level.active_relic_challenge.waveinfo = level.active_relic_challenge.bundle.var_68c10c658bb1eaf;
            break;
    }
    
    level.active_relic_challenge.var_ec98c1654d0d906e = level.active_relic_challenge.waveinfo.var_dcb404a73232af0c;
    level.active_relic_challenge.var_1c0860c81ed13b9a = level.active_relic_challenge.waveinfo.var_67a76eafc8d821b0;
    level.active_relic_challenge.milestone_enemies[ "special" ].spawns_max = level.active_relic_challenge.waveinfo.var_50145cca0513485a ?? 1;
    level.active_relic_challenge.milestone_enemies[ "elite" ].spawns_max = level.active_relic_challenge.waveinfo.var_394a7e1b0616eaf6 ?? 1;
    level.active_relic_challenge.milestone_enemies[ "special" ].spawn_amount = level.active_relic_challenge.waveinfo.var_837e0574f31c935c ?? 1;
    level.active_relic_challenge.milestone_enemies[ "elite" ].spawn_amount = level.active_relic_challenge.waveinfo.var_f4c0a00318672138 ?? 1;
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0xb51ee1d7, Offset: 0x1d06
// Size: 0x277
function private get_zombie_subclass_to_spawn()
{
    chance = randomfloat( 1 );
    
    if ( chance > 0 )
    {
        if ( chance <= level.active_relic_challenge.var_1c0860c81ed13b9a )
        {
            spawnlist = level.active_relic_challenge.waveinfo.var_eefaecdadba4c710 ?? %"hash_259b0495f7dcfde6";
            var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( spawnlist );
        }
        else if ( chance <= level.active_relic_challenge.var_ec98c1654d0d906e )
        {
            spawnlist = level.active_relic_challenge.waveinfo.var_31dc7cf98b0b2ba4 ?? %"hash_1e9e596bf75c59c6";
            var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( spawnlist );
        }
        else
        {
            spawnlist = level.active_relic_challenge.waveinfo.var_3a84da23cebed7be ?? %"hash_2574e003c509f5b6";
            var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( spawnlist );
        }
    }
    else
    {
        spawnlist = level.active_relic_challenge.waveinfo.var_3a84da23cebed7be ?? %"hash_2574e003c509f5b6";
        var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( spawnlist );
    }
    
    aitype = function_b3988325430ce242( var_8200d28bbef302ba );
    subclass = ai::function_29ab862ec4f51541( aitype );
    
    if ( var_8200d28bbef302ba )
    {
        flag_can_spawn = 0;
        
        if ( level.var_d85265655f6db38a[ var_8200d28bbef302ba ] )
        {
            switch ( level.var_d85265655f6db38a[ var_8200d28bbef302ba ] )
            {
                case #"hash_8c089e813083e510":
                    if ( level.active_relic_challenge.base_enemies[ "special" ].size < level.active_relic_challenge.waveinfo.var_3d26c170530f1c33 )
                    {
                        flag_can_spawn = 1;
                    }
                    
                    break;
                case #"hash_7b0e2f2ed84f34":
                    if ( level.active_relic_challenge.base_enemies[ "elite" ].size < level.active_relic_challenge.waveinfo.var_e7560fec69225d47 )
                    {
                        flag_can_spawn = 1;
                    }
                    
                    break;
                default:
                    break;
            }
        }
        
        if ( !flag_can_spawn )
        {
            spawnlist = level.active_relic_challenge.waveinfo.var_3a84da23cebed7be ?? %"hash_2574e003c509f5b6";
            var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( spawnlist );
        }
    }
    
    return var_8200d28bbef302ba;
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0xa44e9339, Offset: 0x1f86
// Size: 0x2a5
function private function_312bb4d3627a90f3()
{
    milestonetype = "none";
    wave_phase = level.active_relic_challenge.wave_phase;
    spawn_list = undefined;
    var_8200d28bbef302ba = undefined;
    
    switch ( wave_phase )
    {
        case #"hash_e820a757d6d47da4":
            spawn_list = level.active_relic_challenge.waveinfo.var_31dc7cf98b0b2ba4;
            milestonetype = "special";
            break;
        case #"hash_6c074fddf9239ee8":
            spawn_list = level.active_relic_challenge.waveinfo.var_eefaecdadba4c710;
            milestonetype = "elite";
            break;
    }
    
    var_4dd2d8ec20913af9 = level.active_relic_challenge.milestone_enemies[ milestonetype ].spawns_max;
    milestone_zombie_count = level.active_relic_challenge.milestone_enemies[ milestonetype ].spawns.size ?? 0;
    
    if ( level.active_relic_challenge.waveinfo.var_1f7ba93a1fe614ca && milestone_zombie_count < var_4dd2d8ec20913af9 )
    {
        level.active_relic_challenge.var_b623a5ae0d4b37b2 = milestone_zombie_count;
        choices = 0;
        
        while ( !var_8200d28bbef302ba && choices <= 3 )
        {
            if ( level.active_relic_challenge.var_b623a5ae0d4b37b2 == level.active_relic_challenge.var_3bc9e0e1ef15c384 )
            {
                level.active_relic_challenge.var_b623a5ae0d4b37b2++;
            }
            
            var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_3925bfe0a9aed36d( spawn_list, level.active_relic_challenge.var_b623a5ae0d4b37b2 );
            
            if ( !var_8200d28bbef302ba )
            {
                level.active_relic_challenge.var_b623a5ae0d4b37b2 = 0;
                choices++;
                continue;
            }
            
            level.active_relic_challenge.var_3bc9e0e1ef15c384 = level.active_relic_challenge.var_b623a5ae0d4b37b2;
        }
    }
    else
    {
        var_8200d28bbef302ba = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( spawn_list );
    }
    
    if ( level.active_relic_challenge.waveinfo.var_a8fcfbffa7c7cc3e )
    {
        if ( !issubstr( var_8200d28bbef302ba, "_hvt" ) )
        {
            if ( function_b3988325430ce242( var_8200d28bbef302ba + "_hvt" ) )
            {
                var_8200d28bbef302ba += "_hvt";
            }
            else
            {
                switch ( var_8200d28bbef302ba )
                {
                    case #"hash_e7da8821c456119c":
                        var_8200d28bbef302ba = "zombie_mimic_hvt_emp";
                        break;
                    default:
                        break;
                }
            }
        }
    }
    
    return [ var_8200d28bbef302ba, milestonetype ];
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0x9c36a682, Offset: 0x2234
// Size: 0x27, Type: bool
function private function_c64bef3463dfa312()
{
    return level.active_relic_challenge.waveinfo.var_b3297c85320534b ?? 1.5;
}

// Namespace zm_relic_challenges
// Params 4
// Checksum 0x31517e2a, Offset: 0x2264
// Size: 0x52b
function function_fcc576ce75ae207c( var_c60105d2445aa45f, spawner, round_number, milestone_type )
{
    level endon( #"relic_challenge_end" );
    
    if ( !spawner )
    {
        return;
    }
    
    if ( !isdefined( level.active_relic_challenge.zombie_spawns ) )
    {
        return;
    }
    
    if ( level.active_relic_challenge.pause_spawning )
    {
        return;
    }
    
    if ( milestone_type )
    {
        level.active_relic_challenge.milestone_enemies[ milestone_type ].var_d74c533c8c787344++;
    }
    
    level.active_relic_challenge.zombie_spawns++;
    should_spawn_zombie = 1;
    
    if ( issubstr( var_c60105d2445aa45f, "galileo" ) )
    {
        should_spawn_zombie = 0;
        spawn_point = utility::callsharedfunc( #"zombie_galileo", #"hash_688117f2993e46d5" );
        
        if ( spawn_point )
        {
            zombie = function_91390f94f4579fac( spawn_point );
        }
    }
    
    if ( should_spawn_zombie )
    {
        zombie = agent_manager::spawn_agent( var_c60105d2445aa45f, spawner.origin, spawner.angles, "team_two_hundred" );
        
        if ( zombie && isalive( zombie ) )
        {
            zombie zombie_utils::set_zombie_round_difficulty( round_number, 1 );
        }
    }
    
    var_8c2db094245b0cd1 = level.active_relic_challenge.waveinfo.var_88a2e48792cee5a4 ?? 0;
    
    if ( zombie && isalive( zombie ) )
    {
        zombie.relic_spawn = 1;
        zombie.var_15598d8e493afe88 = 1;
        zombie.ignore_enemy_count = 1;
        zombie.var_825b17c932865df = 1;
        zombie.var_73754e976e7672a6 = 1;
        zombie zombie_utils::set_zombie_round_difficulty( round_number + var_8c2db094245b0cd1, 0 );
        
        if ( !isdefined( zombie.var_13518fb33ec73cc ) )
        {
            zombie.var_13518fb33ec73cc = round_number;
        }
        
        zombie thread function_1bc464f15faed8c2( round_number );
    }
    
    if ( milestone_type )
    {
        level.active_relic_challenge.milestone_enemies[ milestone_type ].var_d74c533c8c787344--;
    }
    
    if ( !level.active_relic_challenge || level.active_relic_challenge.pause_spawning )
    {
        zombie function_908a1b8613e50514();
        zombie kill();
        return;
    }
    
    if ( isdefined( zombie.subclass ) && issubstr( zombie.subclass, "zombie_shade" ) )
    {
        zombie zombie_shade_loot_consume::function_20b7d83929d84799( 1 );
    }
    
    if ( isdefined( zombie.subclass ) && issubstr( zombie.subclass, "zombie_base" ) )
    {
        b_success = zombie utility::function_7c10ea82c1e305b8( "base", "base_r_mod_red_eyes" );
        
        if ( !b_success )
        {
            zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        }
    }
    else if ( isdefined( zombie.subclass ) && issubstr( zombie.subclass, "zombie_karkinos" ) )
    {
        b_success = zombie utility::function_7c10ea82c1e305b8( "eyes", "red" );
        
        if ( !b_success )
        {
            zombie utility::function_7c10ea82c1e305b8( "eyes", "purple" );
        }
    }
    else
    {
        b_success = zombie utility::function_7c10ea82c1e305b8( "base", "base_r_mod_red_eyes" );
        
        if ( !b_success )
        {
            b_success = zombie utility::function_7c10ea82c1e305b8( "eyes", "r_mod_red_eyes" );
            
            if ( !b_success )
            {
                zombie utility::function_7c10ea82c1e305b8( "eyes", "purple" );
            }
        }
    }
    
    if ( zombie.aicategory != "normal" )
    {
        zombie.var_50c96a5c56dab386 = &function_317320d6a89416ca;
        zombie.var_f895c28d17024434 = 1;
        
        if ( !milestone_type )
        {
            zombie.var_50afe5df97ddaf4 = level.active_relic_challenge.base_enemies[ zombie.aicategory ].size;
            zombie.var_5d7d933c4401f510 = zombie.aicategory;
            
            if ( isarray( level.active_relic_challenge.base_enemies[ zombie.aicategory ] ) )
            {
                level.active_relic_challenge.base_enemies[ zombie.aicategory ][ level.active_relic_challenge.base_enemies[ zombie.aicategory ].size ] = zombie;
            }
        }
    }
    
    if ( !level.active_relic_challenge.var_55fa97ff4c8976a3 )
    {
        zombie.no_powerups = 1;
    }
    
    zombie.var_5a3f5e72ec19cac1 = milestone_type;
    
    if ( zombie.var_5a3f5e72ec19cac1 )
    {
        zombie.milestone_index = level.active_relic_challenge.milestone_enemies[ milestone_type ].spawns.size;
        level.active_relic_challenge.milestone_enemies[ milestone_type ].spawns[ level.active_relic_challenge.milestone_enemies[ milestone_type ].spawns.size ] = zombie;
        zombie thread function_f4319b6598471901();
    }
    
    zombie zone_spawner::function_ce10e453e7f7bb8e( spawner );
    return zombie;
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0xb8cf4046, Offset: 0x2798
// Size: 0x17f
function private function_1bc464f15faed8c2( round_number )
{
    round_move_speed = zm_round_spawning::function_6211dbc10409aa10( zm_round_logic::get_rb_round_number() );
    
    if ( utility::getsharedfunc( #"relics", #"hash_b2dd3117e28e0ada" ) )
    {
        utility::callsharedfunc( #"relics", #"hash_b2dd3117e28e0ada" );
        return;
    }
    
    if ( round_move_speed == "walk" )
    {
        wait 2;
        
        if ( self && isalive( self ) )
        {
            movespeed = zm_round_spawning::function_6211dbc10409aa10( round_number );
            utility::callsharedfunc( #"zombie_utils", #"setmovespeed", movespeed, "relic_challenge", 9 );
        }
    }
    
    if ( level.active_relic_challenge.bundle.var_7cebb18cad192dd7 )
    {
        if ( self && isalive( self ) )
        {
            zombie_speed = "run";
            
            if ( issubstr( self.subclass, "zombie_base" ) )
            {
                start_frac = ( level.active_relic_challenge.var_3a04ef2068c13fc9 - 1 ) / level.active_relic_challenge.max_waves;
                chance = lerp( 0.4, 0.6, start_frac );
                
                if ( chance )
                {
                    zombie_speed = "run";
                }
                else
                {
                    zombie_speed = "walk";
                }
                
                utility::callsharedfunc( #"zombie_utils", #"setmovespeed", zombie_speed, "relic_challenge", 9 );
            }
        }
    }
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0x77530747, Offset: 0x291f
// Size: 0xe1
function function_f4319b6598471901()
{
    self endon( #"death" );
    level endon( #"relic_challenge_end" );
    wait 1;
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.ejectedsubclass )
    {
        if ( !isdefined( self.var_e128f7e1227e3b81 ) )
        {
            self.var_e128f7e1227e3b81 = {};
        }
        
        self.var_e128f7e1227e3b81.var_5a3f5e72ec19cac1 = self.var_5a3f5e72ec19cac1;
    }
    
    wait 2;
    
    if ( self tagexists( "j_spine4" ) )
    {
        playfxontag( level._effect[ #"hash_c8bb89e284b41a34" ], self, "j_spine4" );
    }
    else if ( self tagexists( "j_spine2" ) )
    {
        playfxontag( level._effect[ #"hash_c8bb89e284b41a34" ], self, "j_spine2" );
    }
    
    self.objectiveid = function_72f2b20fb6f167fd( self, 1, undefined, 100 );
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0xe0ebdb6c, Offset: 0x2a08
// Size: 0x6f0
function private function_a76f7bc479248301( params )
{
    if ( !isagent( self ) )
    {
        return;
    }
    
    if ( !level.active_relic_challenge )
    {
        return;
    }
    
    if ( !self.relic_spawn )
    {
        return;
    }
    
    level.active_relic_challenge.zombie_spawns--;
    
    if ( self.var_5a3f5e72ec19cac1 && isdefined( self.milestone_index ) )
    {
        function_d1d6dd6cec48c855();
        level.active_relic_challenge.milestone_enemies[ self.var_5a3f5e72ec19cac1 ].spawns[ self.milestone_index ] = undefined;
        
        if ( isint( self.milestone_index ) )
        {
            function_cdc669dbc8ea2101( level.active_relic_challenge.milestone_enemies[ self.var_5a3f5e72ec19cac1 ].spawns );
        }
        
        if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.ejectedsubclass )
        {
            if ( !isdefined( self.var_e128f7e1227e3b81 ) )
            {
                self.var_e128f7e1227e3b81 = {};
            }
            
            self.var_e128f7e1227e3b81.var_5a3f5e72ec19cac1 = self.var_5a3f5e72ec19cac1;
            level.active_relic_challenge.milestone_enemies[ self.var_5a3f5e72ec19cac1 ].var_d74c533c8c787344++;
            remove_all_waypoints();
            
            foreach ( enemy in level.active_relic_challenge.milestone_enemies[ self.var_5a3f5e72ec19cac1 ].spawns )
            {
                enemy function_72f2b20fb6f167fd( enemy, 1, undefined, 100 );
            }
            
            return;
        }
    }
    
    if ( params.victim.death_source == "zm_cleanup" )
    {
        return;
    }
    
    if ( params.eattacker.classname == "worldspawn" )
    {
        if ( params.einflictor.targetname == "trap_attacker" )
        {
        }
        else if ( !self.var_9afdcc3313206f6e )
        {
            if ( !self.a_n_player_damage.size > 0 || self.nuked )
            {
                return;
            }
        }
    }
    
    if ( self.var_50afe5df97ddaf4 )
    {
        level.active_relic_challenge.base_enemies[ self.aicategory ][ self.var_50afe5df97ddaf4 ] = undefined;
        
        if ( isint( self.var_50afe5df97ddaf4 ) )
        {
            function_cdc669dbc8ea2101( level.active_relic_challenge.base_enemies[ self.aicategory ] );
        }
    }
    
    if ( level.active_relic_challenge.bundle.var_25fc8c65de3a970c || level.active_relic_challenge.var_3bc08f51893973a )
    {
        return;
    }
    
    level.active_relic_challenge.kills++;
    
    if ( self.var_5a3f5e72ec19cac1 )
    {
        level.active_relic_challenge.milestone_enemies[ self.var_5a3f5e72ec19cac1 ].kills++;
        
        if ( self tagexists( "j_spine4" ) )
        {
            stopfxontag( level._effect[ #"hash_c8bb89e284b41a34" ], self, "j_spine4" );
        }
        else
        {
            stopfxontag( level._effect[ #"hash_c8bb89e284b41a34" ], self, "tag_origin" );
        }
        
        var_9c351380b943a2da = undefined;
        
        switch ( self.var_5a3f5e72ec19cac1 )
        {
            case #"hash_8c089e813083e510":
                var_9c351380b943a2da = level.active_relic_challenge.waveinfo.var_837e0574f31c935c;
                break;
            case #"hash_7b0e2f2ed84f34":
                var_9c351380b943a2da = level.active_relic_challenge.waveinfo.var_f4c0a00318672138;
                break;
            default:
                break;
        }
        
        remove_all_waypoints();
        
        foreach ( enemy in level.active_relic_challenge.milestone_enemies[ self.var_5a3f5e72ec19cac1 ].spawns )
        {
            enemy function_72f2b20fb6f167fd( enemy, 1, undefined, 100 );
        }
        
        quest_bundle = level.active_relic_challenge.quest_bundle;
        max_kills = var_9c351380b943a2da;
        current_kills = level.active_relic_challenge.milestone_enemies[ self.var_5a3f5e72ec19cac1 ].kills;
        
        if ( !max_kills > 0 )
        {
            return;
        }
        
        progress_frac = current_kills / max_kills;
        progress_frac = clamp( progress_frac, 0, 1 );
        progress_frac *= 100;
        step_ref = #"hash_c870eabe9bdde807";
        step_ref = function_2877e19d99dc6597( step_ref );
        zm_quest::function_9f49b2a045ece8ae( progress_frac, 1, quest_bundle.ref, step_ref );
        
        /#
            iprintlnbold( "<dev string:x24>" + toupper( self.var_5a3f5e72ec19cac1 ) + "<dev string:x2c>" + level.active_relic_challenge.milestone_enemies[ self.var_5a3f5e72ec19cac1 ].kills + "<dev string:x2f>" + var_9c351380b943a2da );
        #/
    }
    
    if ( level.active_relic_challenge.kills < level.active_relic_challenge.waveinfo.killsneeded )
    {
        /#
            iprintlnbold( "<dev string:x24>" + level.active_relic_challenge.kills + "<dev string:x2f>" + level.active_relic_challenge.waveinfo.killsneeded );
        #/
        
        quest_bundle = level.active_relic_challenge.quest_bundle;
        max_kills = level.active_relic_challenge.waveinfo.killsneeded;
        current_kills = level.active_relic_challenge.kills;
        progress_frac = current_kills / max_kills;
        progress_frac = clamp( progress_frac, 0, 1 );
        progress_frac *= 100;
        zm_quest::function_9f49b2a045ece8ae( progress_frac, 1, quest_bundle.ref, level.active_relic_challenge.bundle.ref );
        return;
    }
    
    function_2c84f339a1e20a66();
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0xdbc421c7, Offset: 0x3100
// Size: 0x3db
function function_2c84f339a1e20a66()
{
    var_c7869fe21b882d8f = level.active_relic_challenge.waveinfo.var_837e0574f31c935c ?? 0;
    var_c934ff3fed6f1cb = level.active_relic_challenge.waveinfo.var_f4c0a00318672138 ?? 0;
    
    switch ( level.active_relic_challenge.wave_phase )
    {
        case #"hash_3404d12adaad147c":
            foreach ( player in level.players )
            {
                player playlocalsound( #"hash_3a6f936f234c0772" );
            }
            
            progress_wave( 0 );
            return;
        case #"hash_73e1d2c5068acf41":
            function_720b5a51388b94b5();
            
            /#
                iprintlnbold( "<dev string:x33>" );
            #/
            
            if ( level.active_relic_challenge.bundle.var_55f354d5fa5652a9 && var_c7869fe21b882d8f > 0 )
            {
                level.active_relic_challenge.var_189abf4197963d87++;
            }
            
            foreach ( player in level.players )
            {
                if ( var_c7869fe21b882d8f > 0 )
                {
                    player playlocalsound( #"hash_555c1d0c7cc5f4ee" );
                }
            }
            
            level.active_relic_challenge.wave_phase = "WAVE_SPECIAL";
            quest_bundle = level.active_relic_challenge.quest_bundle;
            step_ref = #"hash_c870eabe9bdde807";
            step_ref = function_2877e19d99dc6597( step_ref );
            zm_quest::function_cd1f2fee4749fb0a( 1, quest_bundle.ref, step_ref );
            zm_quest::function_9f49b2a045ece8ae( 0, 1, quest_bundle.ref, step_ref );
            zm_quest::function_bf63bf6d044ad598( level.active_relic_challenge.var_189abf4197963d87, 1, quest_bundle.ref, step_ref );
            zm_quest::function_49f2a6a3c1320a6d( level.active_relic_challenge.var_5a5572cb1045b08f, 1, quest_bundle.ref, step_ref );
            
            if ( var_c7869fe21b882d8f > 0 )
            {
                params = { #var_add3b1aca5b1ef96:step_ref };
                level callback::callback( "on_relic_challenge_objective_updated", params );
            }
            
            break;
        case #"hash_e820a757d6d47da4":
            if ( level.active_relic_challenge.milestone_enemies[ "special" ].kills >= var_c7869fe21b882d8f )
            {
                if ( var_c934ff3fed6f1cb > 0 )
                {
                    level function_f0ebe68a03d04f31();
                }
            }
            
            break;
        case #"hash_6c074fddf9239ee8":
            break;
    }
    
    if ( level.active_relic_challenge.milestone_enemies[ "special" ].kills >= var_c7869fe21b882d8f && level.active_relic_challenge.milestone_enemies[ "elite" ].kills >= var_c934ff3fed6f1cb )
    {
        /#
            iprintlnbold( "<dev string:x50>" + level.active_relic_challenge.var_189abf4197963d87 + "<dev string:x56>" );
        #/
        
        if ( var_c7869fe21b882d8f > 0 || var_c934ff3fed6f1cb > 0 )
        {
            level progress_wave( 1, 1 );
            return;
        }
        
        level progress_wave( 0, 1 );
    }
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0x826ab708, Offset: 0x34e3
// Size: 0x1e5
function function_f0ebe68a03d04f31()
{
    /#
        iprintlnbold( "<dev string:x62>" );
    #/
    
    foreach ( player in level.players )
    {
        player playlocalsound( #"hash_24339ff71fb52ab7" );
    }
    
    level.active_relic_challenge.wave_phase = "WAVE_ELITE";
    
    if ( level.active_relic_challenge.bundle.var_55f354d5fa5652a9 )
    {
        level.active_relic_challenge.var_189abf4197963d87++;
    }
    
    step_ref = #"hash_c870eabe9bdde807";
    step_ref = function_2877e19d99dc6597( step_ref );
    zm_quest::function_cd1f2fee4749fb0a( 1, level.active_relic_challenge.quest_bundle.ref, step_ref );
    zm_quest::function_9f49b2a045ece8ae( 0, 1, level.active_relic_challenge.quest_bundle.ref, step_ref );
    zm_quest::function_bf63bf6d044ad598( level.active_relic_challenge.var_189abf4197963d87, 1, level.active_relic_challenge.quest_bundle.ref, step_ref );
    zm_quest::function_49f2a6a3c1320a6d( level.active_relic_challenge.var_5a5572cb1045b08f, 1, level.active_relic_challenge.quest_bundle.ref, step_ref );
    params = { #var_add3b1aca5b1ef96:step_ref };
    level callback::callback( "on_relic_challenge_objective_updated", params );
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0xdab0c438, Offset: 0x36d0
// Size: 0x1be
function function_720b5a51388b94b5()
{
    level.active_relic_challenge.milestone_enemies[ "special" ] = {};
    level.active_relic_challenge.milestone_enemies[ "elite" ] = {};
    level.active_relic_challenge.milestone_enemies[ "special" ].kills = 0;
    level.active_relic_challenge.milestone_enemies[ "elite" ].kills = 0;
    level.active_relic_challenge.milestone_enemies[ "special" ].spawns = [];
    level.active_relic_challenge.milestone_enemies[ "elite" ].spawns = [];
    level.active_relic_challenge.milestone_enemies[ "special" ].spawns_max = 0;
    level.active_relic_challenge.milestone_enemies[ "elite" ].spawns_max = 0;
    level.active_relic_challenge.base_enemies[ "special" ] = [];
    level.active_relic_challenge.base_enemies[ "elite" ] = [];
    level.active_relic_challenge.var_b623a5ae0d4b37b2 = 0;
    level.active_relic_challenge.var_3bc9e0e1ef15c384 = undefined;
    level.active_relic_challenge.milestone_enemies[ "special" ].var_d74c533c8c787344 = 0;
    level.active_relic_challenge.milestone_enemies[ "elite" ].var_d74c533c8c787344 = 0;
}

// Namespace zm_relic_challenges
// Params 2
// Checksum 0xefb69c6, Offset: 0x3896
// Size: 0x355
function progress_wave( is_milestone_wave, reset_wave_info )
{
    level.active_relic_challenge.kills = 0;
    level.active_relic_challenge.var_3a04ef2068c13fc9++;
    level.active_relic_challenge.var_189abf4197963d87++;
    level.active_relic_challenge.pause_wave = 1;
    
    /#
        iprintlnbold( "<dev string:x50>" + level.active_relic_challenge.var_189abf4197963d87 );
    #/
    
    if ( is_milestone_wave )
    {
        ais_nuked = getaiarray( "team_two_hundred" );
        function_fa45a45eabc7f559();
        zm_quest::nuke_zombies( 1, ais_nuked );
        remove_all_waypoints();
    }
    
    if ( reset_wave_info )
    {
        level.active_relic_challenge.milestone_enemies[ "special" ].kills = 0;
        level.active_relic_challenge.milestone_enemies[ "elite" ].kills = 0;
        level.active_relic_challenge.wave_phase = "WAVE_BASE";
    }
    
    milestone_step = #"hash_c870eabe9bdde807";
    milestone_step = function_2877e19d99dc6597( milestone_step );
    zm_quest::function_cd1f2fee4749fb0a( 1, level.active_relic_challenge.quest_bundle.ref, milestone_step );
    zm_quest::function_cd1f2fee4749fb0a( 1, level.active_relic_challenge.quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    zm_quest::function_9f49b2a045ece8ae( 0, 1, level.active_relic_challenge.quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    zm_quest::function_bf63bf6d044ad598( level.active_relic_challenge.var_189abf4197963d87, 1, level.active_relic_challenge.quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    zm_quest::function_49f2a6a3c1320a6d( level.active_relic_challenge.var_5a5572cb1045b08f, 1, level.active_relic_challenge.quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    params = { #var_add3b1aca5b1ef96:level.active_relic_challenge.bundle.ref };
    level callback::callback( "on_relic_challenge_objective_updated", params );
    
    /#
        if ( level.var_b2524341f96394fe )
        {
            end_relic_challenge();
            return;
        }
    #/
    
    if ( level.active_relic_challenge.var_3a04ef2068c13fc9 > level.active_relic_challenge.max_waves )
    {
        end_relic_challenge();
        return;
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, getxhash( "relic_stage_" + level.active_relic_challenge.var_3a04ef2068c13fc9 ) );
}

// Namespace zm_relic_challenges
// Params 3
// Checksum 0x995b6330, Offset: 0x3bf3
// Size: 0x49e
function end_relic_challenge( params, var_c5acdbec60b34aab = 1, warp_location )
{
    if ( !var_c5acdbec60b34aab )
    {
        waitframe();
    }
    
    level.exec_relic_challenge = 0;
    level notify( #"relic_challenge_end" );
    level thread utility::callsharedfunc( level.active_relic_challenge.bundle.modifiertype, #"hash_1ce3a63041775f04" );
    ais_nuked = getaiarray( "team_two_hundred" );
    function_7c480257523d142e( ais_nuked );
    level zm_quest::nuke_zombies( 1, ais_nuked );
    remove_all_waypoints();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"relic_complete" );
    quest_bundle = level.active_relic_challenge.quest_bundle;
    var_800c32584de16273 = #"hash_c870eabe9bdde807";
    var_800c32584de16273 = function_2877e19d99dc6597( var_800c32584de16273 );
    zm_quest::function_a62dc5b7c911530();
    zm_quest::function_fba942a1cfd85f5d( 0, 1, quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    zm_quest::function_fba942a1cfd85f5d( 0, 1, quest_bundle.ref, var_800c32584de16273 );
    level callback::remove( #"player_spawned", &on_player_spawn );
    level.var_9075568a1189c7c9 = 0;
    level.disable_fasttravel = 0;
    wait 3;
    postfxbundle = level.field_upgrade_bundles[ level.active_relic_challenge.post_fx_name ].var_67f9d640c30063e7;
    
    foreach ( player in level.players )
    {
        if ( !getdvarint( @"hash_53fdf0902a70f4dd" ) )
        {
            pbgpostfxbundleend( player, level.active_relic_challenge.postfxbundle );
        }
    }
    
    level thread function_834b256c06132a78( level.active_relic_challenge.relic_hash, warp_location );
    wait 1;
    utility::callsharedfunc( #"relics", #"hash_92c4c6c317514acf" );
    utility::callsharedfunc( #"relics", #"hash_c9559b5984f63640" );
    wait 5;
    setomnvar( "is_relic_challenge_active", 0 );
    
    foreach ( player in level.players )
    {
        if ( var_c5acdbec60b34aab )
        {
            player thread hud_message::showsplash( "sat_zm_r_mod_challenge_completed" );
            player playlocalsound( "uin_rbz_relics_cursedtrial_complete" );
        }
        
        player.is_in_dark_aether = 0;
        player.is_in_relic_challenge = 0;
    }
    
    zm_round_spawning::pause_round_spawning( 0, "relic_challenge_begin" );
    level callback::remove( #"on_ai_killed", &function_a76f7bc479248301 );
    level callback::remove( "special_round_start", &function_a67deb554faab7b6 );
    level callback::remove( "on_zombie_viper_eject", &on_zombie_viper_eject );
    level callback::remove( "on_relic_challenge_objective_updated", &function_c8a0f59f58a21a44 );
    params = { #var_c5acdbec60b34aab:var_c5acdbec60b34aab, #relic_challenge_type:level.active_relic_challenge.relic_hash, #relic_loot_id:level.zm_relics[ level.active_relic_challenge.relic_hash ].lootid };
    level utility::flag_clear( "relic_challenge_active" );
    level callback::callback( #"relic_challenge_ended", params );
    level thread function_6d50eca22569c178();
    level thread function_73a9b8be3e968345();
    level zm_relics::activate_relics();
    wait 2;
    level.active_relic_challenge.milestone_enemies[ "special" ] = undefined;
    level.active_relic_challenge.milestone_enemies[ "elite" ] = undefined;
    level.active_relic_challenge.waveinfo = undefined;
    level.active_relic_challenge = undefined;
    
    if ( level utility::flag( "exfil_window_active" ) )
    {
        zm_exfil_sat::function_e6d25909c7962ebf( "available" );
        zm_exfil_sat::zm_exfil_objective_icon( 1 );
    }
}

// Namespace zm_relic_challenges
// Params 3
// Checksum 0xfd55ef65, Offset: 0x4099
// Size: 0x141
function function_f4e21bb3d60470a2( relichash, var_c5018437db1be57d, warp_location )
{
    level thread function_834b256c06132a78( relichash, warp_location );
    thread start_relic_challenge( relichash, undefined, warp_location );
    wait 3;
    reliclootid = level.zm_relics[ relichash ].lootid;
    setomnvar( "is_relic_challenge_active", 1 );
    
    if ( reliclootid > 0 )
    {
        setomnvar( "ui_r_mod_challenge_lootid", level.zm_relics[ relichash ].lootid );
    }
    
    wait 3;
    splashsfx = hashcat( #"hash_e80aeb5d60895855", level.zm_relics[ relichash ].tier );
    
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( "sat_zm_r_mod_challenge_activated" );
        player playlocalsound( splashsfx );
    }
}

// Namespace zm_relic_challenges
// Params 3
// Checksum 0x24a82c7c, Offset: 0x41e2
// Size: 0x44a
function function_834b256c06132a78( relichash, warp_location, var_316e94b963228f9c )
{
    level endon( #"relic_challenge_end" );
    var_ca2e8e7581f5a468 = undefined;
    warp_players = var_316e94b963228f9c ?? level.players;
    
    if ( level.zm_relics[ relichash ].tier )
    {
        switch ( level.zm_relics[ relichash ].tier )
        {
            case 1:
                var_ca2e8e7581f5a468 = level.zm_relic_tier_bundles[ "easy" ].var_37a9d1ce936e5fd6;
                break;
            case 2:
                var_ca2e8e7581f5a468 = level.zm_relic_tier_bundles[ "medium" ].var_37a9d1ce936e5fd6;
                break;
            case 3:
                var_ca2e8e7581f5a468 = level.zm_relic_tier_bundles[ "hard" ].var_37a9d1ce936e5fd6;
                break;
            default:
                break;
        }
    }
    
    level thread function_497c10ca2aefef79( var_ca2e8e7581f5a468 );
    
    foreach ( player in warp_players )
    {
        player val::set( "relic_portal", "ignoreme", 1 );
        player val::set( "relic_portal", "freezecontrols", 1 );
        level thread game_utility::fadetoblackforplayerkeepui( player, 1, 0.6 );
    }
    
    wait 1.2;
    
    foreach ( player in warp_players )
    {
        level thread game_utility::fadetoblackforplayerkeepui( player, 0, 0.6 );
    }
    
    if ( var_ca2e8e7581f5a468 )
    {
        foreach ( player in warp_players )
        {
            if ( isplayer( player ) )
            {
                player setclientomnvar( "ui_zm_bink_overlay_state", 1 );
                player playcinematicforplayer( var_ca2e8e7581f5a468, 1 );
            }
        }
    }
    
    foreach ( player in warp_players )
    {
        if ( !var_ca2e8e7581f5a468 )
        {
            player thread zm_fasttravel::function_60628df0e15b562b();
        }
        
        if ( warp_location && isstruct( warp_location ) )
        {
            player thread zm_fasttravel::function_cbb08198e7c84adf( warp_location, player, undefined, undefined );
        }
    }
    
    wait 6;
    
    foreach ( player in warp_players )
    {
        if ( isplayer( player ) )
        {
            player stopcinematicforplayer( 0, 1 );
            player setclientomnvar( "ui_zm_bink_overlay_state", 0 );
        }
    }
    
    foreach ( player in warp_players )
    {
        player val::reset( "relic_portal", "ignoreme" );
        player val::reset( "relic_portal", "freezecontrols" );
    }
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0x5920f24d, Offset: 0x4634
// Size: 0x18
function private function_497c10ca2aefef79( var_ca2e8e7581f5a468 )
{
    if ( var_ca2e8e7581f5a468 )
    {
        preloadcinematicforall( var_ca2e8e7581f5a468 );
    }
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0xe335893e, Offset: 0x4654
// Size: 0x70
function private function_317320d6a89416ca()
{
    zombie_droplist = %"hash_6ef0e000b02578bc";
    var_245f1c4b1d5b3e81 = 1;
    zombie_droppos = self.origin;
    zombie_droplist_params = { #droppos:zombie_droppos ?? self.origin, #dropquantity:var_245f1c4b1d5b3e81, #droplist:zombie_droplist };
    return zombie_droplist_params;
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0xc
// Checksum 0x2d65f00a, Offset: 0x46cd
// Size: 0x2e9
function private function_c2e2628a2153edd9()
{
    self notify( #"hash_83dc71f879959c50" );
    self endon( #"hash_83dc71f879959c50" );
    level endon( #"relic_challenge_end" );
    
    while ( level.active_relic_challenge )
    {
        if ( level.active_relic_challenge.wave_phase == "WAVE_SPECIAL" || level.active_relic_challenge.wave_phase == "WAVE_ELITE" )
        {
            foreach ( key, milestone_type in level.active_relic_challenge.milestone_enemies )
            {
                var_e9807e09127a4075 = 0;
                
                for ( i = 0; i < milestone_type.spawns.size ; i++ )
                {
                    enemy = milestone_type.spawns[ i ];
                    
                    if ( enemy.relic_spawn && enemy.var_5a3f5e72ec19cac1 != key || !enemy.health || enemy.health <= 0 )
                    {
                        level.active_relic_challenge.milestone_enemies[ key ].spawns[ i ] = undefined;
                        var_e9807e09127a4075 = 1;
                        enemy function_908a1b8613e50514();
                        enemy kill();
                    }
                }
                
                if ( var_e9807e09127a4075 )
                {
                    function_cdc669dbc8ea2101( level.active_relic_challenge.milestone_enemies[ key ].spawns );
                }
            }
        }
        
        foreach ( key, var_e7f8722db5dd5f50 in level.active_relic_challenge.base_enemies )
        {
            var_e9807e09127a4075 = 0;
            
            for ( i = 0; i < var_e7f8722db5dd5f50.size ; i++ )
            {
                enemy = var_e7f8722db5dd5f50[ i ];
                
                if ( enemy.relic_spawn && enemy.var_5d7d933c4401f510 != key || !enemy.health || enemy.health <= 0 )
                {
                    level.active_relic_challenge.base_enemies[ key ][ i ] = undefined;
                    var_e9807e09127a4075 = 1;
                    enemy function_908a1b8613e50514();
                    enemy kill();
                }
            }
            
            if ( var_e9807e09127a4075 )
            {
                function_cdc669dbc8ea2101( level.active_relic_challenge.base_enemies[ key ] );
            }
        }
        
        wait 5;
    }
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0x527b2e15, Offset: 0x49be
// Size: 0x93
function private function_a67deb554faab7b6( params )
{
    if ( level.var_a009ab14ee0d3223.isspecialround || utility::flag( "special_round_is_ongoing" ) )
    {
        level thread zm_round_logic::function_895fdc21ab019efe();
    }
    
    zm_quest::function_823ee6000b6e1947( zm_round_logic::get_rb_round_number() - 1 );
    zm_quest::function_823ee6000b6e1947( zm_round_logic::get_rb_round_number() );
    level waittill( #"on_round_start" );
    wait 1;
    
    if ( level.active_relic_challenge )
    {
        level utility::callsharedfunc( #"relics", #"hash_ef2fe1dfec487c71" );
        zm_quest::function_61f7df5fddf96cd1();
    }
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0x9cff0491, Offset: 0x4a59
// Size: 0x8f
function private on_player_spawn( params )
{
    if ( isalive( self ) && level.active_relic_challenge && !level utility::flag( "zm_game_over" ) )
    {
        function_834b256c06132a78( level.active_relic_challenge.relic_hash, level.active_relic_challenge.warp_location, [ self ] );
        
        if ( !getdvarint( @"hash_53fdf0902a70f4dd" ) )
        {
            pbgpostfxbundlestart( self, level.active_relic_challenge.postfxbundle );
        }
    }
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0x7aa62fe5, Offset: 0x4af0
// Size: 0x2f
function private function_c8a0f59f58a21a44( params )
{
    level function_94804310fd96a338( params.var_add3b1aca5b1ef96 );
    level function_87a91c1272a94b6d();
    level function_5b823355b98bf619();
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0xa4ae7d49, Offset: 0x4b27
// Size: 0x14
function private function_6d50eca22569c178( params )
{
    level cleanup_holdout_points();
}

// Namespace zm_relic_challenges
// Params 1
// Checksum 0xbfa4ab24, Offset: 0x4b43
// Size: 0x74
function function_94804310fd96a338( var_add3b1aca5b1ef96 )
{
    self notify( #"hash_341f0540be5c3f2e" );
    self endon( #"hash_341f0540be5c3f2e" );
    level notify( #"hash_46c89cade4c1c9cb" );
    wavestage = function_d07ee4921bf4e74b( level.active_relic_challenge.var_3a04ef2068c13fc9 );
    level function_1fcd94399ea579c0( wavestage, level.active_relic_challenge.quest_bundle, var_add3b1aca5b1ef96 );
}

// Namespace zm_relic_challenges
// Params 3, eflags: 0x4
// Checksum 0x4d27d6cb, Offset: 0x4bbf
// Size: 0x1a1
function private function_1fcd94399ea579c0( wavestage, quest_bundle, var_add3b1aca5b1ef96 )
{
    has_time_limit = 0;
    time_limit = 0;
    
    switch ( wavestage )
    {
        case #"hash_1093cc9874dcca5c":
            has_time_limit = level.active_relic_challenge.bundle.var_f528330bcb9dbd5c.hastimelimit;
            time_limit = level.active_relic_challenge.bundle.var_f528330bcb9dbd5c.timelimit;
            break;
        case #"hash_17970e6c9cbefa65":
            has_time_limit = level.active_relic_challenge.bundle.var_1b60eba83ccfc385.hastimelimit;
            time_limit = level.active_relic_challenge.bundle.var_1b60eba83ccfc385.timelimit;
            break;
        case #"hash_f2d854ff09e04b81":
            has_time_limit = level.active_relic_challenge.bundle.var_68c10c658bb1eaf.hastimelimit;
            time_limit = level.active_relic_challenge.bundle.var_68c10c658bb1eaf.timelimit;
            break;
        default:
            break;
    }
    
    if ( has_time_limit && time_limit )
    {
        level.active_relic_challenge.timer = time_limit;
        level thread function_b0144a68cc07031b( wavestage, time_limit, quest_bundle, var_add3b1aca5b1ef96 );
    }
}

// Namespace zm_relic_challenges
// Params 4, eflags: 0xc
// Checksum 0x4e81ce05, Offset: 0x4d68
// Size: 0xf1
function private function_b0144a68cc07031b( wavestage, time_limit, quest_bundle, var_add3b1aca5b1ef96 )
{
    self notify( #"hash_4499b9cf729d16d" );
    self endon( #"hash_4499b9cf729d16d" );
    level endon( #"relic_challenge_end" );
    level endon( #"hash_46c89cade4c1c9cb" );
    wait 3;
    
    while ( level.active_relic_challenge.timer > 0 )
    {
        timer_ref = var_add3b1aca5b1ef96 ?? level.active_relic_challenge.bundle.ref;
        zm_quest::function_612a9ad0db22c29c( level.active_relic_challenge.timer * 1000, 1, quest_bundle.ref, timer_ref );
        wait 1;
        level.active_relic_challenge.timer--;
    }
    
    level thread end_relic_challenge( undefined, 0 );
}

// Namespace zm_relic_challenges
// Params 1
// Checksum 0xaf8cf321, Offset: 0x4e61
// Size: 0x88
function function_2877e19d99dc6597( step_ref )
{
    ref = step_ref;
    
    switch ( ref )
    {
        case #"hash_c870eabe9bdde807":
            if ( isdefined( level.active_relic_challenge.timer ) && !level.active_relic_challenge.bundle.var_e0409c7b372bbda3 )
            {
                ref = #"hash_7461dc80650df9f";
            }
            
            break;
        default:
            break;
    }
    
    return ref;
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0x36fc7f24, Offset: 0x4ef2
// Size: 0x61
function private function_5b823355b98bf619()
{
    if ( !level.active_relic_challenge.bundle.var_25fc8c65de3a970c )
    {
        return;
    }
    
    function_d0182e053f3cb39a();
    
    if ( level.exec_relic_challenge )
    {
        ais_nuked = getaiarray( "team_two_hundred" );
        function_7c480257523d142e( ais_nuked );
        level thread zm_quest::nuke_zombies( 1, ais_nuked );
    }
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0x76598fbd, Offset: 0x4f5b
// Size: 0xfd
function private function_d0182e053f3cb39a()
{
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = level.active_relic_challenge.bundle.ref;
    step_ref = function_2877e19d99dc6597( step_ref );
    zm_quest::function_cd1f2fee4749fb0a( 1, quest_bundle.ref, step_ref );
    zm_quest::function_bf63bf6d044ad598( level.active_relic_challenge.var_189abf4197963d87, 1, quest_bundle.ref, step_ref );
    zm_quest::function_49f2a6a3c1320a6d( level.active_relic_challenge.var_5a5572cb1045b08f, 1, quest_bundle.ref, step_ref );
    
    if ( level.active_relic_challenge.timer )
    {
        zm_quest::function_612a9ad0db22c29c( level.active_relic_challenge.timer * 1000, 1, quest_bundle.ref, step_ref );
    }
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0x69ba3cd9, Offset: 0x5060
// Size: 0x4ae
function private function_87a91c1272a94b6d()
{
    if ( !level.active_relic_challenge.bundle.var_7cebb18cad192dd7 )
    {
        return;
    }
    
    level.active_relic_challenge.pause_spawning = 1;
    function_3fb4d6ed63bdb9d1();
    
    if ( !level.active_relic_challenge.var_34b1e759ca7b2c8a.size > 0 )
    {
        level function_3292a188c0cba137();
    }
    else
    {
        if ( level.exec_relic_challenge )
        {
            ais_nuked = getaiarray( "team_two_hundred" );
            function_7c480257523d142e( ais_nuked );
            level thread zm_quest::nuke_zombies( 1, ais_nuked );
        }
        
        level thread function_34ab54355d93c140();
        
        foreach ( var_1e2895c484c9125a in level.active_relic_challenge.fog_scriptables )
        {
            if ( var_1e2895c484c9125a )
            {
                fade_out_fog( level.fog_scriptable );
                level.fog_scriptable = undefined;
            }
        }
    }
    
    current_point_index = level.active_relic_challenge.var_3a04ef2068c13fc9 - 2;
    current_point_active = level.active_relic_challenge.var_34b1e759ca7b2c8a[ current_point_index ].scriptable;
    
    if ( current_point_active )
    {
        current_point_active utility::function_7c10ea82c1e305b8( "vfx", "hide" );
        current_point_active utility::function_7c10ea82c1e305b8( "base", "Disable" );
        current_point_active.var_94d1ab5da995e573 = 1;
    }
    
    point_index = level.active_relic_challenge.var_3a04ef2068c13fc9 - 1;
    var_33204fbe5c51ece4 = level.active_relic_challenge.var_34b1e759ca7b2c8a[ point_index ].scriptable;
    
    if ( var_33204fbe5c51ece4 && !var_33204fbe5c51ece4.var_929a3ff666a99dac )
    {
        var_33204fbe5c51ece4 utility::function_7c10ea82c1e305b8( "base", "Usable" );
        var_33204fbe5c51ece4.var_94d1ab5da995e573 = 0;
    }
    
    var_2731708e4687815b = level.active_relic_challenge.var_34b1e759ca7b2c8a[ point_index ];
    
    switch ( point_index )
    {
        case 0:
            level thread fade_in_fog( "fog_1", var_2731708e4687815b );
            break;
        case 1:
            level thread fade_in_fog( "fog_2", var_2731708e4687815b );
            break;
        case 2:
            level thread fade_in_fog( "fog_3", var_2731708e4687815b );
            break;
        case 3:
            level thread fade_in_fog( "fog_4", var_2731708e4687815b );
            break;
        case 4:
            level thread fade_in_fog( "fog_5", var_2731708e4687815b );
            break;
        case 5:
            level thread fade_in_fog( "fog_6", var_2731708e4687815b );
            break;
    }
    
    level.active_relic_challenge.fog_scriptables = function_5713d46873b29625( level.active_relic_challenge.fog_scriptables );
    level.active_relic_challenge.fog_scriptables[ level.active_relic_challenge.fog_scriptables.size ] = level.fog_scriptable;
    
    foreach ( player in level.players )
    {
        if ( player.relic_trial_fog )
        {
            player.relic_trial_fog freescriptable();
            player.relic_trial_fog = undefined;
        }
        
        if ( var_2731708e4687815b )
        {
            team_select_payload = [ #"teamselect", player getentitynumber() ];
            player.relic_trial_fog = spawnscriptable( %"sat_zm_cr_trial_smoke", var_2731708e4687815b.origin, var_2731708e4687815b.angles, undefined, team_select_payload );
            player.relic_trial_fog.var_7a65426f252841e7 = 1;
            player.relic_trial_fog.owningplayer = player;
            player.in_relic_trial_fog = 1;
        }
    }
    
    level thread function_668d74cd878b3535();
}

// Namespace zm_relic_challenges
// Params 2
// Checksum 0xcd9de2e3, Offset: 0x5516
// Size: 0x1ee
function fade_in_fog( partstate, var_2731708e4687815b )
{
    level endon( #"relic_challenge_end" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_holdout_started" );
    level.fog_scriptable = spawnscriptable( %"zm_cr_t_fow", var_2731708e4687815b.origin, var_2731708e4687815b.angles );
    level.fog_scriptable utility::function_7c10ea82c1e305b8( partstate, "off" );
    level.fog_scriptable.partstate = partstate;
    level.var_80e7ffc7b42ab9b8 = spawnscriptable( %"zm_cr_t_fow", var_2731708e4687815b.origin, var_2731708e4687815b.angles );
    level.var_80e7ffc7b42ab9b8 utility::function_7c10ea82c1e305b8( partstate, "rise" );
    level.var_80e7ffc7b42ab9b8.partstate = partstate;
    wait 25;
    level.fog_scriptable utility::function_7c10ea82c1e305b8( partstate, "loop" );
    wait 1;
    
    if ( level.var_80e7ffc7b42ab9b8 )
    {
        level.var_80e7ffc7b42ab9b8 utility::function_7c10ea82c1e305b8( partstate, "off" );
        level.var_80e7ffc7b42ab9b8 freescriptable();
        level.var_80e7ffc7b42ab9b8 = undefined;
    }
    
    wait 4;
    
    foreach ( player in level.players )
    {
        player.in_relic_trial_fog = 1;
        
        if ( player.relic_trial_fog )
        {
            player.relic_trial_fog utility::function_7c10ea82c1e305b8( "trial_fog", "on_damaging" );
        }
    }
}

// Namespace zm_relic_challenges
// Params 1
// Checksum 0x680d165b, Offset: 0x570c
// Size: 0x32
function fade_out_fog( scriptable )
{
    scriptable utility::function_7c10ea82c1e305b8( scriptable.partstate, "fade" );
    waitframe();
    
    if ( scriptable )
    {
        scriptable freescriptable();
    }
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0xca106f1d, Offset: 0x5746
// Size: 0x2
function function_668d74cd878b3535()
{
    
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0xc5a332da, Offset: 0x5750
// Size: 0xdc
function private function_3fb4d6ed63bdb9d1()
{
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = hashcat( level.active_relic_challenge.bundle.ref, "_activate_point" );
    step_ref = function_2877e19d99dc6597( step_ref );
    zm_quest::function_cd1f2fee4749fb0a( 1, quest_bundle.ref, step_ref );
    zm_quest::function_bf63bf6d044ad598( level.active_relic_challenge.var_189abf4197963d87, 1, quest_bundle.ref, step_ref );
    zm_quest::function_49f2a6a3c1320a6d( level.active_relic_challenge.var_5a5572cb1045b08f, 1, quest_bundle.ref, step_ref );
    zm_quest::function_612a9ad0db22c29c( 30000, 1, quest_bundle.ref, step_ref );
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0xaff0aadc, Offset: 0x5834
// Size: 0x72
function private function_8644546a4ef8dad0()
{
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = hashcat( level.active_relic_challenge.bundle.ref, "_activate_point" );
    step_ref = function_2877e19d99dc6597( step_ref );
    zm_quest::function_fba942a1cfd85f5d( 0, 1, quest_bundle.ref, step_ref );
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0xb6b4c385, Offset: 0x58ae
// Size: 0x15e
function private function_3292a188c0cba137()
{
    level.active_relic_challenge.var_34b1e759ca7b2c8a = [];
    
    for ( i = 0; i < level.active_relic_challenge.bundle.waveamount ; i++ )
    {
        struct = utility::getstruct( "crf_z_" + i, "targetname" );
        
        if ( struct )
        {
            level.active_relic_challenge.var_34b1e759ca7b2c8a[ level.active_relic_challenge.var_34b1e759ca7b2c8a.size ] = struct;
            struct.scriptable = spawnscriptable( %"sat_zm_cr_hold_point", struct.origin, struct.angles );
            struct.scriptable.point_num = i;
            struct.scriptable = interaction::register_scriptable_interact( struct.scriptable, &function_2bf04a2a285ded6a );
            struct.scriptable utility::function_7c10ea82c1e305b8( "base", "Disable" );
            struct.scriptable.var_94d1ab5da995e573 = 1;
            struct.scriptable.radius = 500 - 50 * i;
        }
    }
    
    level thread fog_damage_players();
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0xf4cf03c4, Offset: 0x5a14
// Size: 0x11c
function private function_2bf04a2a285ded6a( player )
{
    if ( self.var_94d1ab5da995e573 )
    {
        return;
    }
    
    self.var_929a3ff666a99dac = 1;
    self.var_df00f5fbf4a6d195 = 1;
    utility::function_7c10ea82c1e305b8( "base", "Activated" );
    
    /#
        iprintlnbold( "<dev string:x7d>" + self.point_num );
    #/
    
    foreach ( point in level.active_relic_challenge.var_34b1e759ca7b2c8a )
    {
        if ( point.scriptable != self )
        {
            point.scriptable utility::function_7c10ea82c1e305b8( "base", "Disable" );
            point.scriptable.var_94d1ab5da995e573 = 1;
        }
    }
    
    thread function_272002d689adb393();
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0x9377a05a, Offset: 0x5b38
// Size: 0x2f2
function private function_272002d689adb393()
{
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    level notify( #"relic_challenge_holdout_started" );
    level.fog_scriptable utility::function_32b24db3127bff40( level.fog_scriptable.partstate, "loop" );
    
    if ( level.var_80e7ffc7b42ab9b8 )
    {
        level.var_80e7ffc7b42ab9b8 utility::function_7c10ea82c1e305b8( level.var_80e7ffc7b42ab9b8.partstate, "off" );
        level.var_80e7ffc7b42ab9b8 freescriptable();
        level.var_80e7ffc7b42ab9b8 = undefined;
    }
    
    level.active_relic_challenge.pause_spawning = 0;
    level.active_relic_challenge.var_b5a51ee87e132641 = self;
    thread function_2e8813d15836598c();
    var_83beaa896eded17a = 16;
    radius = self.radius - 80;
    origin = self.origin - ( 0, 0, 15 );
    self.circle_points = [];
    
    for ( i = 0; i < var_83beaa896eded17a ; i++ )
    {
        circle_point = 360 / var_83beaa896eded17a * i;
        var_74b69cab898e775d = ( radius * cos( circle_point ), radius * sin( circle_point ), 0 );
        point = origin + var_74b69cab898e775d;
        var_9e9bcd3c5818482a = getclosestpointonnavmesh( point );
        edge_scriptable = spawnscriptable( %"sat_zm_cr_point_edge", var_9e9bcd3c5818482a - ( 0, 0, 15 ) );
        self.circle_points[ self.circle_points.size ] = edge_scriptable;
    }
    
    zm_quest::function_cd1f2fee4749fb0a( 1, level.active_relic_challenge.quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    zm_quest::function_9f49b2a045ece8ae( 0, 1, level.active_relic_challenge.quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    zm_quest::function_bf63bf6d044ad598( level.active_relic_challenge.var_189abf4197963d87, 1, level.active_relic_challenge.quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    zm_quest::function_49f2a6a3c1320a6d( level.active_relic_challenge.var_5a5572cb1045b08f, 1, level.active_relic_challenge.quest_bundle.ref, level.active_relic_challenge.bundle.ref );
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0xc
// Checksum 0xbad7e33b, Offset: 0x5e32
// Size: 0x11d
function private fog_damage_players()
{
    self notify( #"hash_bde23f55724241d" );
    self endon( #"hash_bde23f55724241d" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    level endon( #"hash_504b1c414da068af" );
    utility::waittill_notify_or_timeout( "relic_challenge_holdout_started", 31 );
    
    while ( level.active_relic_challenge )
    {
        wait 1;
        
        foreach ( player in level.players )
        {
            if ( isplayer( player ) && isalive( player ) )
            {
                if ( !player val::get( "freezecontrols" ) && player.in_relic_trial_fog )
                {
                    player dodamage( 25, player.origin, player, player, "MOD_UNKNOWN" );
                }
            }
        }
    }
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0xc
// Checksum 0x8de9611, Offset: 0x5f57
// Size: 0x182
function private function_2e8813d15836598c()
{
    self notify( #"hash_4bb25a0dbf67ab2b" );
    self endon( #"hash_4bb25a0dbf67ab2b" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    level endon( #"hash_504b1c414da068af" );
    
    while ( level.active_relic_challenge )
    {
        self.var_376a57fb35155f07 = function_d63fe6a4c08ba6f5( self.origin, self.radius, 2000 );
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && arraycontains( self.var_376a57fb35155f07, player ) )
            {
                player.in_relic_trial_fog = 0;
                
                if ( player.relic_trial_fog )
                {
                    player.relic_trial_fog utility::function_7c10ea82c1e305b8( "trial_fog", "on" );
                }
                
                continue;
            }
            
            if ( !player.in_relic_trial_fog )
            {
                player.in_relic_trial_fog = 1;
                
                if ( player.relic_trial_fog )
                {
                    player.relic_trial_fog utility::function_7c10ea82c1e305b8( "trial_fog", "on_damaging" );
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0xf65694a6, Offset: 0x60e1
// Size: 0x1a6
function private function_34ab54355d93c140( scriptable )
{
    if ( level.active_relic_challenge.var_b5a51ee87e132641 )
    {
        level notify( #"hash_504b1c414da068af" );
        
        foreach ( player in level.players )
        {
            player.in_relic_trial_fog = 1;
            
            if ( player.relic_trial_fog )
            {
                player.relic_trial_fog utility::function_7c10ea82c1e305b8( "trial_fog", "off" );
            }
            
            for ( i = 0; i < level.active_relic_challenge.var_b5a51ee87e132641.circle_points.size ; i++ )
            {
                if ( level.active_relic_challenge.var_b5a51ee87e132641.circle_points[ i ] )
                {
                    level.active_relic_challenge.var_b5a51ee87e132641.circle_points[ i ] freescriptable();
                }
                
                waitframe();
            }
        }
        
        level.active_relic_challenge.var_b5a51ee87e132641.circle_points = function_5713d46873b29625( level.active_relic_challenge.var_b5a51ee87e132641.circle_points );
    }
    
    if ( level.exec_relic_challenge )
    {
        fog_damage_players();
    }
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0xf6aaf9e, Offset: 0x628f
// Size: 0x17a
function private cleanup_holdout_points()
{
    if ( !level.active_relic_challenge.bundle.var_7cebb18cad192dd7 )
    {
        return;
    }
    
    level thread function_8644546a4ef8dad0();
    
    if ( level.active_relic_challenge.var_34b1e759ca7b2c8a.size > 0 )
    {
        foreach ( point_struct in level.active_relic_challenge.var_34b1e759ca7b2c8a )
        {
            if ( point_struct.scriptable )
            {
                point_struct.scriptable freescriptable();
            }
        }
    }
    
    foreach ( var_1e2895c484c9125a in level.active_relic_challenge.fog_scriptables )
    {
        if ( var_1e2895c484c9125a )
        {
            level fade_out_fog( var_1e2895c484c9125a );
            var_1e2895c484c9125a = undefined;
        }
    }
    
    level.active_relic_challenge.var_34b1e759ca7b2c8a = undefined;
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0x739c62d5, Offset: 0x6411
// Size: 0x56
function set_zombie_damage_invuln()
{
    if ( !isent( self ) || !isagent( self ) )
    {
        return;
    }
    
    if ( isalive( self ) && !self.magic_bullet_shield && !self.var_698cf8d8d4a8cbb9 )
    {
        ai::magic_bullet_shield( 1 );
        val::set( "relic_trial_damage_shield", "damageshield_allow_delete", 1 );
    }
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0xd2fe241f, Offset: 0x646f
// Size: 0x24
function function_908a1b8613e50514()
{
    if ( self.magic_bullet_shield || val::get( "damageshield" ) )
    {
        ai::stop_magic_bullet_shield();
    }
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0x53e9ec9f, Offset: 0x649b
// Size: 0xa4
function function_fa45a45eabc7f559()
{
    if ( level.var_e8893f9b0f558ccf.size > 0 )
    {
        foreach ( galileo in level.var_e8893f9b0f558ccf )
        {
            if ( galileo && !galileo.relic_spawn )
            {
                galileo.var_190f8e8daa83f8c = 1;
            }
        }
    }
}

// Namespace zm_relic_challenges
// Params 1
// Checksum 0xef82d13a, Offset: 0x6547
// Size: 0x153
function function_7c480257523d142e( ais_nuked )
{
    if ( level.var_e8893f9b0f558ccf.size > 0 )
    {
        foreach ( galileo in level.var_e8893f9b0f558ccf )
        {
            if ( galileo && !galileo.relic_spawn )
            {
                galileo.var_190f8e8daa83f8c = undefined;
            }
        }
    }
    
    foreach ( ai in ais_nuked )
    {
        if ( ai.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.ejectedsubclass )
        {
            ai.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.ejectedsubclass = undefined;
        }
    }
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0xe7ef5d99, Offset: 0x66a2
// Size: 0x135
function function_1a2172027f36bef8()
{
    if ( level.var_e8893f9b0f558ccf.size > 0 && utility::issharedfuncdefined( #"zombie_galileo", #"hash_7f2f95200b82d9e4" ) )
    {
        foreach ( galileo in level.var_e8893f9b0f558ccf )
        {
            wait 2;
            
            if ( galileo && isalive( galileo ) )
            {
                galileo_teleport_pos = utility::getstruct( "heat_beam_target" );
                
                if ( galileo_teleport_pos.origin )
                {
                    galileo thread utility::callsharedfunc( #"zombie_galileo", #"hash_7f2f95200b82d9e4", galileo_teleport_pos.origin );
                }
            }
        }
        
        return;
    }
    
    if ( level.var_e8893f9b0f558ccf.size == 0 )
    {
        spawn_point = utility::callsharedfunc( #"zombie_galileo", #"hash_688117f2993e46d5" );
        function_91390f94f4579fac( spawn_point );
    }
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0x45ac25de, Offset: 0x67df
// Size: 0x197
function private function_91390f94f4579fac( spawn_point )
{
    origin = spawn_point.origin;
    galileo = agent_manager::spawn_agent( "zombie_galileo", origin );
    
    if ( isdefined( galileo ) )
    {
        galileo.var_825b17c932865df = 1;
        galileo.var_15598d8e493afe88 = 1;
        galileo.ignore_enemy_count = 1;
        galileo.b_disable_annihilate = 1;
        
        if ( utility::issharedfuncdefined( #"zombie_galileo", #"set_run_speed_fraction" ) )
        {
            galileo utility::callsharedfunc( #"zombie_galileo", #"set_run_speed_fraction", 0.35 );
        }
        
        galileo val::set( "galileo", "ignore_cleanup", 1 );
        galileo val::set( "galileo", "allow_dismember", 0 );
        galileo callback::add( "on_zombie_ai_killed", &function_60126efbf44e5b4c );
        
        if ( utility::issharedfuncdefined( #"zombie_galileo", #"hash_830823cb567739ec" ) )
        {
            galileo utility::callsharedfunc( #"zombie_galileo", #"hash_d39922daee6d1b06" );
        }
        
        if ( utility::issharedfuncdefined( #"zombie_galileo", #"deploy" ) )
        {
            galileo utility::callsharedfunc( #"zombie_galileo", #"deploy", spawn_point );
        }
        
        if ( !isdefined( level.var_e8893f9b0f558ccf ) )
        {
            level.var_e8893f9b0f558ccf = [];
        }
        
        level.var_e8893f9b0f558ccf[ level.var_e8893f9b0f558ccf.size ] = galileo;
        level.var_37401c80961cea2b = 1;
    }
    
    return galileo;
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0x36e5ff26, Offset: 0x697f
// Size: 0x35
function private function_60126efbf44e5b4c( params )
{
    if ( self.subclass == "zombie_galileo" )
    {
        level.var_e8893f9b0f558ccf = arrayremove( level.var_e8893f9b0f558ccf, self );
    }
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0x11bb639d, Offset: 0x69bc
// Size: 0x194
function private on_zombie_viper_eject( params )
{
    if ( params.var_e128f7e1227e3b81.var_5a3f5e72ec19cac1 && params.eject_ai )
    {
        zombie = params.eject_ai;
        milestone_type = params.var_e128f7e1227e3b81.var_5a3f5e72ec19cac1;
        zombie.relic_spawn = 1;
        zombie.var_5a3f5e72ec19cac1 = milestone_type;
        zombie.milestone_index = level.active_relic_challenge.milestone_enemies[ milestone_type ].spawns.size;
        zombie.var_9afdcc3313206f6e = 1;
        level.active_relic_challenge.milestone_enemies[ milestone_type ].spawns[ level.active_relic_challenge.milestone_enemies[ milestone_type ].spawns.size ] = zombie;
        zombie.var_15598d8e493afe88 = 1;
        zombie.ignore_enemy_count = 1;
        
        if ( !level.active_relic_challenge.var_55fa97ff4c8976a3 )
        {
            zombie.no_powerups = 1;
        }
        
        if ( level.active_relic_challenge.milestone_enemies[ milestone_type ].var_d74c533c8c787344 > 0 )
        {
            level.active_relic_challenge.milestone_enemies[ milestone_type ].var_d74c533c8c787344--;
        }
        
        zombie function_f4319b6598471901();
    }
}

// Namespace zm_relic_challenges
// Params 1, eflags: 0x4
// Checksum 0xfee95bf4, Offset: 0x6b58
// Size: 0x171
function private function_478f86b7a9f3719c( params )
{
    if ( !params.relic_loot_id )
    {
        return;
    }
    
    if ( !params.var_c5acdbec60b34aab )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            return;
        }
        
        if ( !player utility::callsharedfunc( #"challenges", #"hash_abec5b6ff2cce352" ) )
        {
            return;
        }
        
        aeeventname = #"zm_relic_challenge_complete";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        roundnumber = level.var_6781718da4f78d1c.roundnumber ?? 0;
        eventparams = [];
        utility::callsharedfunc( #"challenges", #"hash_20d6b9ff2d84e1e7", aeeventname, eventparams );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_round_number" ) ] = roundnumber;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_relic_loot_id" ) ] = params.relic_loot_id;
        player function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

// Namespace zm_relic_challenges
// Params 4, eflags: 0x4
// Checksum 0x1dac392e, Offset: 0x6cd1
// Size: 0x9f
function private function_72f2b20fb6f167fd( ent, b_play_intro = 1, str_label, offset )
{
    if ( isent( ent ) )
    {
        level.var_a74764204d9643c = undefined;
        objectiveid = zm_quest::function_dc297429579c6e7f( "relic_challenge_milestone_wave", 2, "ui_icon_zm_objective", "icon_small_medium", "current", ent, offset, str_label, undefined, 0, b_play_intro );
        level.var_a74764204d9643c = 1;
    }
    
    level.active_relic_challenge.objective_ids[ objectiveid ] = ent;
    function_d1d6dd6cec48c855();
    return objectiveid;
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0x86c9fa72, Offset: 0x6d79
// Size: 0x85
function private remove_all_waypoints()
{
    foreach ( id, ent in level.active_relic_challenge.objective_ids )
    {
        zm_quest::complete_objective_waypoints( id );
    }
}

// Namespace zm_relic_challenges
// Params 0, eflags: 0x4
// Checksum 0xf64ed18c, Offset: 0x6e06
// Size: 0x9f
function private function_d1d6dd6cec48c855()
{
    foreach ( objective_id, objective_enemy in level.active_relic_challenge.objective_ids )
    {
        if ( !objective_enemy.var_5a3f5e72ec19cac1 || !isalive( objective_enemy ) )
        {
            zm_quest::complete_objective_waypoints( objective_id );
        }
    }
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0x1b0e5699, Offset: 0x6ead
// Size: 0x12e
function function_73a9b8be3e968345()
{
    level.var_96d4f8dc0c3cfea3 = 0;
    
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"hash_a33e784c7bb751b3" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"hash_a33e784c7bb751b3" );
    }
    
    if ( utility::issharedfuncdefined( #"hash_cc52730feee091fd", #"hash_52c219199ae85ba" ) && utility::issharedfuncdefined( #"hash_33950fc5465e7cdc", #"hash_a6489be8eef67a3d" ) )
    {
        if ( level.workshop && level.workshop.door_is_open == 0 && level.workshop.var_d5403a837ca3983f )
        {
            level.workshop.door thread utility::callsharedfunc( #"hash_cc52730feee091fd", #"hash_52c219199ae85ba", 1 );
            utility::callsharedfunc( #"hash_33950fc5465e7cdc", #"hash_a6489be8eef67a3d" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"hornet_ash", #"ash_unpaused" ) )
    {
        utility::callsharedfunc( #"hornet_ash", #"ash_unpaused" );
    }
}

// Namespace zm_relic_challenges
// Params 0
// Checksum 0xfcd5081b, Offset: 0x6fe3
// Size: 0x30d
function function_e2a39d56b9a0431b()
{
    level.var_96d4f8dc0c3cfea3 = 1;
    level utility::callsharedfunc( #"relics", #"hash_e2ca0a7af3d23b7b" );
    
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"hash_c7aedc0f4fc1d71e" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"hash_c7aedc0f4fc1d71e" );
    }
    
    if ( utility::issharedfuncdefined( #"hash_cc52730feee091fd", #"hash_cbceda57769d1e60" ) && utility::issharedfuncdefined( #"hash_33950fc5465e7cdc", #"hash_1efa92fc552bb393" ) )
    {
        if ( level.workshop && level.workshop.door_is_open )
        {
            level.workshop.var_d5403a837ca3983f = 1;
            level.workshop.door thread utility::callsharedfunc( #"hash_cc52730feee091fd", #"hash_cbceda57769d1e60", 0 );
            utility::callsharedfunc( #"hash_33950fc5465e7cdc", #"hash_1efa92fc552bb393" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"zm_blizzard", #"unfreeze_feature" ) && level.blizzard_data.core_features.frozen.size > 0 )
    {
        var_e98afa0589b6a836 = [];
        var_e98afa0589b6a836[ var_e98afa0589b6a836.size ] = "ammo_cache";
        var_e98afa0589b6a836[ var_e98afa0589b6a836.size ] = "arsenal";
        var_e98afa0589b6a836[ var_e98afa0589b6a836.size ] = "crafting_table";
        var_e98afa0589b6a836[ var_e98afa0589b6a836.size ] = "magicbox";
        var_e98afa0589b6a836[ var_e98afa0589b6a836.size ] = "pack_a_punch";
        var_e98afa0589b6a836[ var_e98afa0589b6a836.size ] = "perk_machine";
        var_e98afa0589b6a836[ var_e98afa0589b6a836.size ] = "perk_machine_choice";
        
        foreach ( type in var_e98afa0589b6a836 )
        {
            if ( level.blizzard_data.core_features.frozen[ type ].size > 0 )
            {
                foreach ( instance in level.blizzard_data.core_features.frozen[ type ] )
                {
                    level utility::callsharedfunc( #"zm_blizzard", #"unfreeze_feature", instance, type );
                }
            }
        }
    }
    
    if ( utility::issharedfuncdefined( #"hornet_ash", #"ash_paused" ) )
    {
        utility::callsharedfunc( #"hornet_ash", #"ash_paused" );
    }
}

// Namespace zm_relic_challenges
// Params 1
// Checksum 0xdb04d196, Offset: 0x72f8
// Size: 0xf6
function function_b03373a907a5d47c( params )
{
    relic_hash = getxhashasset( "relic:" + params[ 0 ] );
    relic_bundle = level.zm_relics[ relic_hash ];
    
    if ( !relic_bundle )
    {
        return;
    }
    
    tier = relic_bundle.tier;
    portal = level.var_39919ce9d7e181ff;
    
    switch ( tier )
    {
        case 1:
            loc = level.var_39919ce9d7e181ff;
            break;
        case 2:
            loc = level.var_a32e584ceb8b4012;
            break;
        case 3:
            loc = level.var_bfe520ab0ebcfc6f;
            break;
    }
    
    if ( !level.active_relic_challenge )
    {
        level thread utility::callsharedfunc( #"relics", #"hash_92f85ae2899481f9", relic_hash, undefined, loc );
    }
}

// Namespace zm_relic_challenges
// Params 1
// Checksum 0x38000f40, Offset: 0x73f6
// Size: 0xc0
function function_dae076aac4ed4a4d( params )
{
    switch ( level.active_relic_challenge.wave_phase )
    {
        case #"hash_e820a757d6d47da4":
            level.active_relic_challenge.milestone_enemies[ "special" ].kills = 999;
            break;
        case #"hash_6c074fddf9239ee8":
            level.active_relic_challenge.milestone_enemies[ "elite" ].kills = 999;
            break;
        default:
            level.active_relic_challenge.kills = 999;
            break;
    }
    
    function_2c84f339a1e20a66();
}

/#

    // Namespace zm_relic_challenges
    // Params 0
    // Checksum 0xb775601e, Offset: 0x74be
    // Size: 0x3f5, Type: dev
    function init_relic_challenge_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x8e>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa3>" + "<dev string:xbc>", "<dev string:xd4>" + "<dev string:xbc>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa3>" + "<dev string:xeb>", "<dev string:xd4>" + "<dev string:xeb>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa3>" + "<dev string:x108>", "<dev string:xd4>" + "<dev string:x108>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa3>" + "<dev string:x122>", "<dev string:xd4>" + "<dev string:x122>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa3>" + "<dev string:x13a>", "<dev string:xd4>" + "<dev string:x13a>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x152>" + "<dev string:x168>", "<dev string:xd4>" + "<dev string:x168>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x152>" + "<dev string:x17e>", "<dev string:xd4>" + "<dev string:x17e>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x152>" + "<dev string:x194>", "<dev string:xd4>" + "<dev string:x194>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x152>" + "<dev string:x1a9>", "<dev string:xd4>" + "<dev string:x1a9>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x152>" + "<dev string:x1c1>", "<dev string:xd4>" + "<dev string:x1c1>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1db>" + "<dev string:x1f3>", "<dev string:xd4>" + "<dev string:x1f3>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1db>" + "<dev string:x20c>", "<dev string:xd4>" + "<dev string:x20c>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1db>" + "<dev string:x226>", "<dev string:xd4>" + "<dev string:x226>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x240>" + "<dev string:x258>", "<dev string:xd4>" + "<dev string:x258>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x240>" + "<dev string:x270>", "<dev string:xd4>" + "<dev string:x270>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x240>" + "<dev string:x288>", "<dev string:xd4>" + "<dev string:x288>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x240>" + "<dev string:x29f>", "<dev string:xd4>" + "<dev string:x29f>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x240>" + "<dev string:x2b4>", "<dev string:xd4>" + "<dev string:x2b4>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x240>" + "<dev string:x2cb>", "<dev string:xd4>" + "<dev string:x2cb>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e3>" + "<dev string:x2fb>", "<dev string:xd4>" + "<dev string:x2fb>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e3>" + "<dev string:x312>", "<dev string:xd4>" + "<dev string:x312>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e3>" + "<dev string:x32b>", "<dev string:xd4>" + "<dev string:x32b>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e3>" + "<dev string:x341>", "<dev string:xd4>" + "<dev string:x341>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e3>" + "<dev string:x359>", "<dev string:xd4>" + "<dev string:x359>", &debug_start_relic_challenge, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e3>" + "<dev string:x370>", "<dev string:xd4>" + "<dev string:x370>", &debug_start_relic_challenge, 0 );
        devgui::add_devgui_func( "<dev string:x387>", "<dev string:x39c>", &function_49d2fdbab16089fd );
        devgui::add_devgui_func( "<dev string:x3b7>", "<dev string:x3ce>", &function_afa3d034e9651126, 0 );
        devgui::add_devgui_func( "<dev string:x3e6>", "<dev string:x3fa>", &function_16acc9fc41097df9, 0 );
        devgui::add_devgui_func( "<dev string:x414>", "<dev string:x424>", &function_b64f99deaa7b9671, 0 );
        devgui::add_devgui_func( "<dev string:x43a>", "<dev string:x44a>", &function_b1a7ba87b5946eb9, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_relic_challenges
    // Params 1
    // Checksum 0xab31bc47, Offset: 0x78bb
    // Size: 0x18, Type: dev
    function debug_start_relic_challenge( params )
    {
        function_b03373a907a5d47c( params );
    }

    // Namespace zm_relic_challenges
    // Params 0
    // Checksum 0xafe09250, Offset: 0x78db
    // Size: 0xf4, Type: dev
    function function_49d2fdbab16089fd()
    {
        if ( !level.active_relic_challenge.postfxbundle )
        {
            return;
        }
        
        if ( level.var_148ec50009f04174 )
        {
            level.var_148ec50009f04174 = 0;
        }
        else
        {
            level.var_148ec50009f04174 = 1;
        }
        
        foreach ( player in level.players )
        {
            if ( level.var_148ec50009f04174 )
            {
                pbgpostfxbundlestart( player, level.active_relic_challenge.postfxbundle );
                continue;
            }
            
            pbgpostfxbundleend( player, level.active_relic_challenge.postfxbundle );
        }
    }

    // Namespace zm_relic_challenges
    // Params 0
    // Checksum 0x62753f3d, Offset: 0x79d7
    // Size: 0x2c, Type: dev
    function function_afa3d034e9651126()
    {
        level.var_b2524341f96394fe = !level.var_b2524341f96394fe;
        iprintlnbold( "<dev string:x460>" + level.var_b2524341f96394fe );
    }

    // Namespace zm_relic_challenges
    // Params 0
    // Checksum 0xe37e669f, Offset: 0x7a0b
    // Size: 0xc, Type: dev
    function function_16acc9fc41097df9()
    {
        end_relic_challenge();
    }

    // Namespace zm_relic_challenges
    // Params 0
    // Checksum 0x44292cca, Offset: 0x7a1f
    // Size: 0x31, Type: dev
    function function_b1a7ba87b5946eb9()
    {
        if ( level.active_relic_challenge.timer )
        {
            level.active_relic_challenge.timer = 1;
        }
    }

    // Namespace zm_relic_challenges
    // Params 0
    // Checksum 0xe262ab78, Offset: 0x7a58
    // Size: 0xc, Type: dev
    function function_b64f99deaa7b9671()
    {
        function_dae076aac4ed4a4d();
    }

#/
