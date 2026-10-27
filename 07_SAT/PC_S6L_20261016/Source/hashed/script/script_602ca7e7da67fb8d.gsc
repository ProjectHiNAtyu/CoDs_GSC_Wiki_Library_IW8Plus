// script_602ca7e7da67fb8d  (hash_602ca7e7da67fb8d.gscc) (size: 25453 Bytes / 0x636d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13f8aef (20941551)
// size ...... 25453 (0x636d)
// includes .. 16  (offset: 0x5add)
// strings ... 118 (offset: 0x5b5d)
// dev strs .. 5   (offset: 0x6331)
// exports ... 56  (offset: 0x40d9)
// cseg ...... 0xa70 + 0x3669 (0x40d9)
// imports ... 123 (offset: 0x4999)
// animtree1 . 0   (offset: 0x636d)
// animtree2 . 0   (offset: 0x636d)
#using script_3b6eb865087dc118;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\points;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace namespace_77b3320b96286ddf;

// Namespace namespace_77b3320b96286ddf
// Params 0, eflags: 0x5
// Checksum 0x4830253a, Offset: 0xa8e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_23cfb51cc22a3c39", undefined, undefined, &init );
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0xcfbd8146, Offset: 0xaaf
// Size: 0x1a6
function init()
{
    if ( !getdvarint( @"hash_70ef86ad43e08120", 0 ) && !level.var_8a98c33a6b47db4a )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "zm_rb_r_mod_survival" )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_be4855acac8d71e9", 0 ) )
    {
        level utility::flag_wait_or_timeout( "cursed_mode_validation_set", 120 );
    }
    
    if ( !level.var_df10a374e4c21ceb && !getdvarint( @"hash_be4855acac8d71e9", 0 ) )
    {
        return;
    }
    
    level utility::waittill_notify_or_timeout( "relic_level_set", 15 );
    level callback::add( "on_round_start", &function_5aea60ff18d0f508 );
    
    switch ( level.zm_relic_tier )
    {
        case 0:
            function_487f9e5930842a56();
            logstring( "[R_MOD] Firefly Relic EE's unlocked successfully, Tier 0" );
            break;
        case 1:
            function_487f9e5930842a56();
            function_463fd72850c2f91b();
            logstring( "[R_MOD] Firefly Relic EE's unlocked successfully, Tier 1" );
            break;
        case 2:
            function_487f9e5930842a56();
            function_463fd72850c2f91b();
            function_162ad694402905d0();
            logstring( "[R_MOD] Firefly Relic EE's unlocked successfully, Tier 2" );
            break;
        case 3:
            function_487f9e5930842a56();
            function_463fd72850c2f91b();
            function_162ad694402905d0();
            logstring( "[R_MOD] Firefly Relic EE's unlocked successfully, Tier 3" );
            break;
    }
    
    level.var_951106abb7efa818 = [];
    level._effect[ "mrp_disappear" ] = utility::load_fx( "vfx_t10_gameplay_zm_magic_box_bunny_rarity_white_disappear" );
    level callback::add( #"relic_challenge_started", &function_f7f8879b0284af5c );
    level callback::add( #"relic_challenge_ended", &function_1ddd99ce98d6dab8 );
    
    /#
        level thread init_relic_debug();
    #/
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0xa44ef6ba, Offset: 0xc5d
// Size: 0x45e
function function_487f9e5930842a56()
{
    level callback::add( "aether_shroud_started", &function_b2ddadafae5ed025 );
    level callback::add( "aether_shroud_ended", &function_d37fac6ced805ecc );
    level callback::add( "aether_shroud_group_set", &function_cef8a0295cfe5901 );
    level callback::add( "aether_shroud_group_remove", &function_6b3c448487f79b60 );
    level.a_candles = [];
    level.a_mrp = [];
    level.a_targets = [];
    level.s_candles = utility::getstructarray( "candle_relic", "targetname" );
    level.s_mrp = utility::getstructarray( "mrp_relics", "targetname" );
    level.s_target_pads = utility::getstructarray( "target_pads_relics", "targetname" );
    setup_chompy();
    
    foreach ( struct in level.s_candles )
    {
        candle = utility::spawn_model( "decor_candle_wax_01_red_no_dish_short_01", struct.origin, struct.angles );
        candle.number = struct.script_label;
        candle.fx_scriptable = spawnscriptable( "zm_relic_fire_c_relic", candle.origin + ( 0, 0, 3 ), candle.angles );
        candle.fx_scriptable setscriptablepartstate( "vfx", "fire_vfx" );
        level.a_candles[ level.a_candles.size ] = candle;
    }
    
    foreach ( struct in level.s_mrp )
    {
        mrp_model = utility::spawn_model( "wm_ob_mrp", struct.origin, struct.angles );
        
        foreach ( player in level.players )
        {
            mrp_model hidefromplayer( player );
        }
        
        mrp_model thread function_ba5c591c91a4a809();
        level.a_mrp[ level.a_mrp.size ] = mrp_model;
    }
    
    foreach ( struct in level.s_target_pads )
    {
        var_b49807b09fde574d = utility::spawn_model( "decor_training_target_01_big", struct.origin, struct.angles );
        
        foreach ( player in level.players )
        {
            var_b49807b09fde574d hidefromplayer( player );
            var_b49807b09fde574d.scriptable = spawnscriptable( "sat_zm_relic_jp_vfx", var_b49807b09fde574d.origin, var_b49807b09fde574d.angles );
            var_b49807b09fde574d.number = struct.script_label;
            level.a_targets[ level.a_targets.size ] = var_b49807b09fde574d;
            var_b49807b09fde574d thread target_damage_watcher();
        }
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x333a3c03, Offset: 0x10c3
// Size: 0x12a
function function_463fd72850c2f91b()
{
    level.s_wb = utility::getstruct( "m_wine_b", "targetname" );
    level.s_crate = utility::getstruct( "m_wine_b_p", "targetname" );
    level.wb_rotation = [];
    level.var_6acf3cf8225c401e = [];
    level.var_95cd28beb42b867f = utility::getstructarray( "r_wb", "script_noteworthy" );
    
    foreach ( index, struct in level.var_95cd28beb42b867f )
    {
        wb_base[ index ] = spawnscriptable( "zm_relic_wb", struct.origin, struct.angles );
        level.wb_rotation[ level.wb_rotation.size ] = wb_base[ index ];
    }
    
    level scriptable::scriptable_adddamagedcallback( &wb_pattern_check );
    setup_chompy();
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0xf6236c1f, Offset: 0x11f5
// Size: 0x1e
function function_162ad694402905d0()
{
    level.a_phone_answered = [];
    level.phone_round = 0;
    level thread function_3541a32ae8984bd3();
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x9ed4af67, Offset: 0x121b
// Size: 0xed
function function_5aea60ff18d0f508( params )
{
    round_number = params.roundnumber;
    
    if ( level.zm_relic_tier >= 2 )
    {
        if ( round_number % 10 == 0 && round_number >= 20 && !level utility::flag( "all_phones_answered" ) )
        {
            if ( level.phone_round < round_number )
            {
                level.phone_round = round_number;
                function_81d4bb35b2d1bc08();
            }
        }
    }
    
    switch ( round_number )
    {
        case 20:
            function_cbd9dd3a226ed4ff();
            break;
        case 40:
            function_9c595ed2d99d1855();
            break;
        case 60:
            function_e79f0c1a2068c143();
            break;
        default:
            break;
    }
    
    if ( round_number > 20 && zm_save::function_1dda3554974a999e() )
    {
        function_69fcd5bba8fd8309( round_number );
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x6c7781c8, Offset: 0x1310
// Size: 0x42
function function_69fcd5bba8fd8309( round )
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        if ( round > 20 )
        {
            function_cbd9dd3a226ed4ff();
        }
        
        if ( round > 40 )
        {
            function_9c595ed2d99d1855();
        }
        
        if ( round > 60 )
        {
            function_e79f0c1a2068c143();
        }
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x6833b443, Offset: 0x135a
// Size: 0x203
function function_cbd9dd3a226ed4ff()
{
    if ( !level utility::flag( "rr_20_set" ) )
    {
        level utility::flag_set( "rr_20_set" );
        level callback::add( "on_player_ft_jp_entered", &player_using_jumppad );
        level callback::add( "on_player_ft_jp_exited", &function_9172666eef5f38bf );
        level.a_targets_hit = [];
        level.var_3c7be733106adab6 = [];
        s_final_mrp = utility::getstruct( "mrp_relics_final", "targetname" );
        level.var_b956ec5f9c51743a = utility::spawn_model( "wm_ob_mrp", s_final_mrp.origin, s_final_mrp.angles );
        
        foreach ( player in level.players )
        {
            level.var_b956ec5f9c51743a hidefromplayer( player );
        }
        
        level.var_b956ec5f9c51743a thread function_ba5c591c91a4a809();
        level.var_76c45cae2094c966[ level.var_76c45cae2094c966.size ] = level.var_b956ec5f9c51743a;
        level.a_candles_hit = [];
        
        foreach ( candle in level.a_candles )
        {
            if ( candle.fx_scriptable )
            {
                candle.fx_scriptable setscriptablepartstate( "vfx", "off" );
            }
            
            candle thread candle_damage_watcher( candle.number + "_candle_hit" );
        }
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x54d34bb9, Offset: 0x1565
// Size: 0x90
function function_9c595ed2d99d1855()
{
    if ( level.zm_relic_tier >= 1 && !level utility::flag( "rr_40_set" ) )
    {
        level utility::flag_set( "rr_40_set" );
        level.var_600538b41630b28d = [];
        level callback::add( "on_round_start", &function_cd418c115c6a447b );
        level callback::add( #"on_ai_killed", &ghoul_death_check );
        level callback::add( #"on_ai_killed", &zursa_check );
        level callback::add( "teddtask_complete", &trial_complete );
        function_a0b75db68b019070();
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x8fb13200, Offset: 0x15fd
// Size: 0x69
function function_e79f0c1a2068c143()
{
    if ( level.zm_relic_tier >= 2 && !level utility::flag( "rr_60_set" ) )
    {
        level utility::flag_set( "rr_60_set" );
        level callback::add( "on_round_start", &tessie_challenge_start );
        level callback::add( "on_round_end", &function_8ec1e10f24b813d );
        level callback::add( #"on_ai_killed", &tessie_damage_check );
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x67644e59, Offset: 0x166e
// Size: 0x19
function function_f7f8879b0284af5c( params )
{
    level utility::flag_set( "relic_challenge_active" );
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x8dae21ea, Offset: 0x168f
// Size: 0x145
function function_1ddd99ce98d6dab8( params )
{
    relic_challenge_type = params.relic_challenge_type;
    level utility::flag_clear( "relic_challenge_active" );
    
    switch ( relic_challenge_type )
    {
        case %"relic:sat_zm_firefly_nu_relic":
            level utility::flag_clear( "gp_already_spawned" );
            break;
        case %"relic:sat_zm_firefly_epsilon_relic":
            level utility::flag_clear( "gp_already_spawned" );
            break;
        case %"relic:sat_zm_firefly_iota_relic":
            level utility::flag_clear( "gp_already_spawned" );
            break;
        case %"relic:sat_zm_firefly_xi_relic":
            level utility::flag_clear( "yp_already_spawned" );
            break;
        case %"relic:sat_zm_firefly_eta_relic":
            level utility::flag_clear( "yp_already_spawned" );
            break;
        case %"relic:sat_zm_firefly_mu_relic":
            level utility::flag_clear( "yp_already_spawned" );
            break;
        case %"relic:sat_zm_firefly_delta_relic":
            level utility::flag_clear( "rp_already_spawned" );
            break;
        case %"relic:sat_zm_firefly_kappa_relic":
            level utility::flag_clear( "rp_already_spawned" );
            break;
        case %"relic:sat_zm_firefly_beta_relic":
            level utility::flag_clear( "rp_already_spawned" );
            break;
        default:
            break;
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x16c0caf4, Offset: 0x17dc
// Size: 0x195
function candle_damage_watcher( var_5f3f7af2721d1ab6 )
{
    if ( utility::flag( "relic_challenge_active" ) )
    {
        return;
    }
    
    self endon( #"death" );
    val::set( "candle_hit", "damage", 1 );
    self.health = 999;
    
    while ( isdefined( self ) )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        var_5e5a2456deacd236 = points::zm_get_weapon_element( objweapon, eattacker, smeansofdeath );
        
        if ( isplayer( eattacker ) && var_5e5a2456deacd236 == "fire" && !level utility::flag( var_5f3f7af2721d1ab6 ) )
        {
            self.fx_scriptable = spawnscriptable( "zm_relic_fire_c_relic", self.origin + ( 0, 0, 3 ), self.angles );
            self.fx_scriptable = utility::function_32b24db3127bff40( "vfx", "fire_vfx" );
            level.a_candles_hit[ level.a_candles_hit.size ] = self;
            level utility::flag_set( var_5f3f7af2721d1ab6 );
            function_d7e317c8fff7a239();
            break;
        }
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x56c19880, Offset: 0x1979
// Size: 0x98
function function_d7e317c8fff7a239()
{
    if ( level.a_candles_hit.size == 3 && !level utility::flag( "all_candles_lit" ) )
    {
        var_2153e39e051f5b91 = %"relic:sat_zm_firefly_iota_relic";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
        level utility::flag_set( "gp_already_spawned" );
        level utility::flag_set( "all_candles_lit" );
        return;
    }
    
    return;
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0xbad44425, Offset: 0x1a19
// Size: 0x64
function function_ba5c591c91a4a809()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::ent_flag_wait( "fireflyww_is_retrieved" );
    playfx( level._effect[ "mrp_disappear" ], self.origin );
    self playsound( "evt_relic_bunny_exit" );
    level thread function_2e6298b59b786854( self );
    function_f1ad6c27c2e9692f();
    self delete();
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0xd8a5c443, Offset: 0x1a85
// Size: 0x3b
function function_2e6298b59b786854( model )
{
    level.var_951106abb7efa818[ level.var_951106abb7efa818.size ] = model;
    level.a_mrp = arrayremove( level.a_mrp, model );
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x471a6280, Offset: 0x1ac8
// Size: 0xfa
function function_b2ddadafae5ed025( params )
{
    if ( utility::flag( "relic_challenge_active" ) )
    {
        return;
    }
    
    player = params.player;
    
    foreach ( var_9e22673b2ff1bae7 in level.a_mrp )
    {
        var_9e22673b2ff1bae7 showtoplayer( player );
        level.var_76c45cae2094c966[ level.var_76c45cae2094c966.size ] = var_9e22673b2ff1bae7;
    }
    
    if ( isdefined( level.var_b956ec5f9c51743a ) )
    {
        level.var_b956ec5f9c51743a showtoplayer( player );
        level.var_76c45cae2094c966[ level.var_76c45cae2094c966.size ] = level.var_b956ec5f9c51743a;
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x1c7b5ac6, Offset: 0x1bca
// Size: 0x161
function function_cef8a0295cfe5901( params )
{
    if ( utility::flag( "relic_challenge_active" ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.var_568623dc77af5450 )
        {
            foreach ( var_9e22673b2ff1bae7 in level.a_mrp )
            {
                var_9e22673b2ff1bae7 showtoplayer( player );
                level.var_76c45cae2094c966[ level.var_76c45cae2094c966.size ] = var_9e22673b2ff1bae7;
            }
            
            if ( isdefined( level.var_b956ec5f9c51743a ) )
            {
                level.var_b956ec5f9c51743a showtoplayer( player );
                level.var_76c45cae2094c966[ level.var_76c45cae2094c966.size ] = level.var_b956ec5f9c51743a;
            }
        }
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0xfa16df88, Offset: 0x1d33
// Size: 0x3b
function function_d37fac6ced805ecc( params )
{
    if ( utility::flag( "relic_challenge_active" ) )
    {
        return;
    }
    
    player = params.player;
    player thread function_c4b97818329b2791();
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x95e6aa3f, Offset: 0x1d76
// Size: 0x14c
function function_c4b97818329b2791()
{
    waitframe();
    
    foreach ( player in level.players )
    {
        if ( !player.aether_shroud_active )
        {
            foreach ( var_9e22673b2ff1bae7 in level.a_mrp )
            {
                level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, var_9e22673b2ff1bae7 );
                var_9e22673b2ff1bae7 hidefromplayer( player );
            }
            
            if ( isdefined( level.var_b956ec5f9c51743a ) )
            {
                level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.var_b956ec5f9c51743a );
                level.var_b956ec5f9c51743a hidefromplayer( player );
            }
        }
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0xd8450988, Offset: 0x1eca
// Size: 0x174
function function_6b3c448487f79b60( params )
{
    if ( utility::flag( "relic_challenge_active" ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !player.var_568623dc77af5450 && !player.aether_shroud_active )
        {
            foreach ( var_9e22673b2ff1bae7 in level.a_mrp )
            {
                level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, var_9e22673b2ff1bae7 );
                var_9e22673b2ff1bae7 hidefromplayer( player );
            }
            
            if ( isdefined( level.var_b956ec5f9c51743a ) )
            {
                level.var_76c45cae2094c966 = arrayremove( level.var_76c45cae2094c966, level.var_b956ec5f9c51743a );
                level.var_b956ec5f9c51743a hidefromplayer( player );
            }
        }
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0xbc2cf125, Offset: 0x2046
// Size: 0xe0
function function_f1ad6c27c2e9692f()
{
    if ( level.var_951106abb7efa818.size == 10 && !level utility::flag( "teddies_complete" ) )
    {
        level callback::remove( "aether_shroud_started", &function_b2ddadafae5ed025 );
        level callback::remove( "aether_shroud_ended", &function_d37fac6ced805ecc );
        level callback::remove( "aether_shroud_group_set", &function_cef8a0295cfe5901 );
        level callback::remove( "aether_shroud_group_remove", &function_6b3c448487f79b60 );
        var_2153e39e051f5b91 = %"relic:sat_zm_firefly_nu_relic";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
        level utility::flag_set( "gp_already_spawned" );
        level utility::flag_set( "teddies_complete" );
        return;
    }
    
    return;
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0xea25be94, Offset: 0x212e
// Size: 0x140
function player_using_jumppad( params )
{
    jumppad = params.jumppad;
    player = params.player;
    
    if ( jumppad.current_path_name == "path_janustowers" && jumppad.script_noteworthy == "pad_farm" || jumppad.current_path_name == "path_farm" && jumppad.script_noteworthy == "pad_janustowers" )
    {
        foreach ( var_b49807b09fde574d in level.a_targets )
        {
            var_b49807b09fde574d showtoplayer( player );
            var_b49807b09fde574d.scriptable setscriptablepartstate( "vfx", "on" );
            player utility::ent_flag_set( "player_using_jumppad" );
            level.var_3c7be733106adab6[ level.var_3c7be733106adab6.size ] = player;
        }
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0xb6854d5e, Offset: 0x2276
// Size: 0x17a
function function_9172666eef5f38bf( params )
{
    jumppad = params.jumppad;
    player = params.player;
    
    if ( jumppad.current_path_name == "path_janustowers" && jumppad.script_noteworthy == "pad_farm" || jumppad.current_path_name == "path_farm" && jumppad.script_noteworthy == "pad_janustowers" )
    {
        foreach ( var_b49807b09fde574d in level.a_targets )
        {
            var_b49807b09fde574d hidefromplayer( player );
            level.var_3c7be733106adab6 = arrayremove( level.var_3c7be733106adab6, player );
            player utility::ent_flag_clear( "player_using_jumppad" );
            
            if ( level.var_3c7be733106adab6.size == 0 )
            {
                var_b49807b09fde574d.scriptable setscriptablepartstate( "vfx", "off" );
            }
        }
        
        if ( level.a_targets_hit.size < 3 && level.var_3c7be733106adab6.size == 0 )
        {
            level.a_targets_hit = [];
        }
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0xbb5d3366, Offset: 0x23f8
// Size: 0x158
function target_damage_watcher()
{
    level endon( #"all_targets_hit" );
    
    if ( utility::flag( "relic_challenge_active" ) )
    {
        return;
    }
    
    val::set( "target_hit", "damage", 1 );
    self.health = 999;
    
    while ( true )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( eattacker ) && eattacker utility::ent_flag( "player_using_jumppad" ) )
        {
            eattacker playsoundtoplayer( "evt_zm_firefly_ee_bullseye_target_hit_jumppad", eattacker, self );
            self.scriptable setscriptablepartstate( "vfx", "hit" );
            
            if ( !arraycontains( level.a_targets_hit, self ) )
            {
                level.a_targets_hit[ level.a_targets_hit.size ] = self;
            }
            
            level thread function_c6c55afef70d62b5();
            self hidefromplayer( eattacker );
        }
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0xd71fb2d0, Offset: 0x2558
// Size: 0x149
function function_c6c55afef70d62b5()
{
    if ( level.a_targets_hit.size == 3 && !level utility::flag( "all_targets_hit" ) )
    {
        level callback::remove( "on_player_ft_jp_entered", &player_using_jumppad );
        level callback::remove( "on_player_ft_jp_exited", &function_9172666eef5f38bf );
        
        if ( level.a_targets_hit.size == 3 )
        {
            foreach ( var_b49807b09fde574d in level.a_targets )
            {
                var_b49807b09fde574d delete();
            }
        }
        
        level notify( #"all_targets_hit" );
        var_2153e39e051f5b91 = %"relic:sat_zm_firefly_epsilon_relic";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
        level utility::flag_set( "gp_already_spawned" );
        level utility::flag_set( "all_targets_hit" );
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x2c6ffa35, Offset: 0x26a9
// Size: 0x1fe
function function_cd418c115c6a447b( params )
{
    if ( zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
    {
        return;
    }
    
    percent = randomintrange( 1, 100 );
    a_players_randomized = arrayrandomize( level.players );
    var_77898ab40e53d0ae = zone_manager::function_90e5c3e2272b0130( a_players_randomized[ 0 ].origin );
    spawner_zombie_type = function_b3988325430ce242( "zombie_callisto" );
    
    if ( isdefined( var_77898ab40e53d0ae.script_zone_name ) )
    {
        a_spawn_locs = zone_spawner::function_20c574a6ba7cc5c6( var_77898ab40e53d0ae.script_zone_name, spawner_zombie_type );
        var_4d5b23254c377e5f = var_77898ab40e53d0ae zone_manager::get_adjacent_zones();
        
        foreach ( var_1211cf94fc6a6c76 in var_4d5b23254c377e5f )
        {
            var_6c8454b26dc2705f = zone_spawner::function_20c574a6ba7cc5c6( var_1211cf94fc6a6c76.script_zone_name, spawner_zombie_type );
            a_spawn_locs = arraycombine( a_spawn_locs, var_6c8454b26dc2705f );
        }
        
        if ( isdefined( a_spawn_locs ) )
        {
            ghoul_spawner = a_spawn_locs[ 0 ];
        }
    }
    
    if ( isdefined( ghoul_spawner ) )
    {
        if ( percent <= 100 )
        {
            ghoul = agent_manager::spawn_agent( "zombie_ghoul", ghoul_spawner.origin, ( 0, 0, 0 ), "team_two_hundred" );
            
            if ( isdefined( ghoul ) )
            {
                ghoul.no_powerups = 1;
                ghoul.ignore_enemy_count = 1;
                ghoul.var_a13bed1ac47e1b2c = 1;
                ghoul.disable_brain_rot = 1;
                ghoul.var_16347ea3a61cc834 = 1;
                
                if ( isdefined( ghoul_spawner.script_animation ) )
                {
                    ghoul thread zone_spawner::function_ce10e453e7f7bb8e( ghoul_spawner );
                }
            }
        }
        
        return;
    }
    
    return;
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0xc4628dd6, Offset: 0x28af
// Size: 0x5a
function ghoul_death_check( params )
{
    level endon( #"game_ended" );
    einflictor = params.einflictor;
    
    if ( isstartstr( self.subclass, "zombie_ghoul" ) && utility::ent_flag( "ft_jp_kill" ) )
    {
        check_ghoul_death();
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0xff2ff78c, Offset: 0x2911
// Size: 0xaf
function check_ghoul_death()
{
    level callback::remove( #"on_ai_killed", &ghoul_death_check );
    level callback::remove( "on_round_start", &function_cd418c115c6a447b );
    
    if ( !level utility::flag( "jumppad_ghoul_killed" ) )
    {
        var_2153e39e051f5b91 = %"relic:sat_zm_firefly_xi_relic";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
        level utility::flag_set( "yp_already_spawned" );
        level utility::flag_set( "jumppad_ghoul_killed" );
        return;
    }
    
    return;
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x505b93b, Offset: 0x29c8
// Size: 0x4c
function function_a0b75db68b019070()
{
    wb_interact = utility::getstruct( "wb_interact_new" );
    level.var_69a556eda12bded2 = zm_quest::function_91f9590e98d57ff6( wb_interact.origin, &bar_interact, &wb_hint, "extrasmall" );
    level.var_21096994a10739c = [];
}

// Namespace namespace_77b3320b96286ddf
// Params 2
// Checksum 0x58e8a0a7, Offset: 0x2a1c
// Size: 0x36
function wb_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_77b3320b96286ddf
// Params 1, eflags: 0x4
// Checksum 0xe40341aa, Offset: 0x2a5b
// Size: 0x3e6
function private bar_interact( player )
{
    if ( level.var_4efcd27b3901f68b && arraycontains( level.var_600538b41630b28d, level.var_4efcd27b3901f68b ) && !level utility::flag( "wb_b_placed" ) )
    {
        s_wb_bear = utility::getstruct( "r_wb_bear", "targetname" );
        level.wb_bear = spawnscriptable( "zm_relic_wb", s_wb_bear.origin, s_wb_bear.angles );
        level.wb_rotation[ level.wb_rotation.size ] = level.wb_bear;
        level utility::flag_set( "wb_b_placed" );
        
        foreach ( Bottle in level.var_6acf3cf8225c401e )
        {
            Bottle setscriptablepartstate( "vfx", "cover" );
            Bottle setscriptablepartstate( "model", "on" );
        }
    }
    
    if ( level.var_2dcd5e17bdbbdb7b && arraycontains( level.var_600538b41630b28d, level.var_2dcd5e17bdbbdb7b ) && !level utility::flag( "wb_t_placed" ) )
    {
        s_wb_trial = utility::getstruct( "r_wb_trial", "targetname" );
        level.wb_trial = spawnscriptable( "zm_relic_wb", s_wb_trial.origin, s_wb_trial.angles );
        level.wb_rotation[ level.wb_rotation.size ] = level.wb_trial;
        level utility::flag_set( "wb_t_placed" );
        
        foreach ( Bottle in level.var_6acf3cf8225c401e )
        {
            Bottle setscriptablepartstate( "vfx", "cover" );
            Bottle setscriptablepartstate( "model", "on" );
        }
    }
    
    wait 2;
    
    if ( isdefined( level.wb_bear ) && isdefined( level.wb_trial ) && !level utility::flag( "wb_pattern" ) )
    {
        level.var_9732cf5a56a83abf = arrayrandomize( level.wb_rotation );
        
        foreach ( wb in level.var_9732cf5a56a83abf )
        {
            wb setscriptablepartstate( "model", "broken" );
            wait 0.5;
        }
        
        foreach ( wb in level.var_9732cf5a56a83abf )
        {
            wb setscriptablepartstate( "vfx", "cover" );
            wb setscriptablepartstate( "model", "on" );
        }
        
        level utility::flag_set( "wb_pattern" );
        
        if ( level.var_69a556eda12bded2 )
        {
            level.var_69a556eda12bded2 freescriptable();
        }
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0xbee98cc7, Offset: 0x2e49
// Size: 0x139
function zursa_check( params )
{
    level endon( #"game_ended" );
    eattacker = params.eattacker;
    smeansofdeath = params.smeansofdeath;
    einflictor = params.einflictor;
    
    if ( ( isstartstr( self.subclass, "zombie_callisto" ) || isstartstr( self.subclass, "zombie_callisto_hvt" ) ) && smeansofdeath == "MOD_MELEE" && !level utility::flag( "wb_bear_spawned" ) )
    {
        ground_pos = utility::drop_to_ground( self.origin, 10 );
        level.var_4efcd27b3901f68b = spawnscriptable( "zm_relic_wb_spawn", ground_pos );
        level.var_4efcd27b3901f68b setscriptablepartstate( "model", "pickup" );
        level.var_4efcd27b3901f68b.var_3153badd94ce8a35 = "wb_bear";
        level thread object_cleanup( level.var_4efcd27b3901f68b );
        level.var_4efcd27b3901f68b scriptable::scriptable_addusedcallbackbypart( "model", &pickup_wb_bear );
        level utility::flag_set( "wb_bear_spawned" );
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 6
// Checksum 0x74d77918, Offset: 0x2f8a
// Size: 0xdc
function pickup_wb_bear( instance, part, state, user, bautouse, usestring )
{
    if ( instance.var_3153badd94ce8a35 != "wb_bear" )
    {
        return;
    }
    
    if ( instance )
    {
        instance setscriptablepartstate( "model", "hidden", 0 );
    }
    
    player = user;
    level utility::flag_set( "wb_bear_pickedup" );
    player playsoundtoplayer( "fly_zm_item_pickup_generic", player );
    level callback::remove( #"on_ai_killed", &zursa_check );
    level.var_600538b41630b28d[ level.var_600538b41630b28d.size ] = level.var_4efcd27b3901f68b;
    level.var_4efcd27b3901f68b scriptable::function_369a834929711390( "model", &pickup_wb_bear );
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0xbb029c36, Offset: 0x306e
// Size: 0x31d
function trial_complete( params )
{
    reward_level = params.loot_level;
    struct = params.struct;
    chest = params.chest;
    var_1fffbca07ddaae4e = utility::getstructarray( struct, "targetname" );
    
    if ( chest && var_1fffbca07ddaae4e )
    {
        switch ( var_1fffbca07ddaae4e[ 0 ].targetname )
        {
            case #"hash_3bc67410fd4eaeff":
                wb_struct = chest.origin + ( -30, 0, 0 );
                break;
            case #"hash_a13dcc7545006505":
                wb_struct = chest.origin + ( -30, 0, 0 );
                break;
            case #"hash_2a64cb23733b5c97":
                wb_struct = chest.origin + ( 20, -20, 0 );
                break;
            case #"hash_fd0b07d9410a7ee7":
                wb_struct = chest.origin + ( 0, 30, 0 );
                break;
            case #"hash_c337e565ed564158":
                wb_struct = chest.origin + ( -10, -30, 0 );
                break;
            case #"hash_63938182a8265c4b":
                wb_struct = chest.origin + ( -20, -15, 0 );
                break;
            case #"hash_cf92e174c93d0480":
                wb_struct = chest.origin + ( 0, 30, 0 );
                break;
            case #"hash_dc44647f705288f1":
                wb_struct = chest.origin + ( 0, -30, 0 );
                break;
            case #"hash_62f3ccf495ca4f3b":
                wb_struct = chest.origin + ( 25, 0, 0 );
                break;
            case #"hash_95d280c5114601e0":
                wb_struct = chest.origin + ( 15, 20, 0 );
                break;
            case #"hash_1f05574be080585d":
                wb_struct = chest.origin + ( -30, 0, 0 );
                break;
            default:
                break;
        }
    }
    
    if ( reward_level == 3 && !level utility::flag( "wb_trial_pickedup" ) && wb_struct )
    {
        level.var_2dcd5e17bdbbdb7b = spawnscriptable( "zm_relic_wb_spawn", wb_struct );
        level.var_2dcd5e17bdbbdb7b setscriptablepartstate( "vfx", "cover" );
        level.var_2dcd5e17bdbbdb7b setscriptablepartstate( "model", "pickup" );
        level.var_2dcd5e17bdbbdb7b.var_3153badd94ce8a35 = "wb_trial";
        level thread object_cleanup( level.var_2dcd5e17bdbbdb7b );
        level.var_2dcd5e17bdbbdb7b scriptable::scriptable_addusedcallbackbypart( "model", &pickup_wb_trial );
        level utility::flag_set( "wb_trial_spawned" );
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x2033729a, Offset: 0x3393
// Size: 0x71
function object_cleanup( scriptable )
{
    level endon( #"game_ended" );
    wait 90;
    
    if ( isdefined( scriptable ) && !level utility::flag( "wb_bear_pickedup" ) )
    {
        level utility::flag_clear( "wb_bear_spawned" );
        scriptable freescriptable();
    }
    
    if ( isdefined( scriptable ) && !level utility::flag( "wb_trial_pickedup" ) )
    {
        level utility::flag_clear( "wb_trial_spawned" );
        scriptable freescriptable();
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 6
// Checksum 0x42b59d40, Offset: 0x340c
// Size: 0xce
function pickup_wb_trial( instance, part, state, user, bautouse, usestring )
{
    if ( level.var_2dcd5e17bdbbdb7b.var_3153badd94ce8a35 != "wb_trial" )
    {
        return;
    }
    
    if ( instance )
    {
        instance setscriptablepartstate( "model", "hidden", 0 );
    }
    
    player = user;
    level utility::flag_set( "wb_trial_pickedup" );
    level.var_600538b41630b28d[ level.var_600538b41630b28d.size ] = level.var_2dcd5e17bdbbdb7b;
    player playsoundtoplayer( "fly_zm_item_pickup_generic", player );
    level.var_2dcd5e17bdbbdb7b scriptable::function_369a834929711390( "model", &pickup_wb_trial );
}

// Namespace namespace_77b3320b96286ddf
// Params 11
// Checksum 0xdd4edc56, Offset: 0x34e2
// Size: 0x119
function wb_pattern_check( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type == "zm_relic_wb" )
    {
        if ( isdefined( level.wb_bear ) && isdefined( level.wb_trial ) )
        {
            instance setscriptablepartstate( "model", "broken" );
            
            if ( !arraycontains( level.var_21096994a10739c, instance ) )
            {
                level.var_21096994a10739c[ level.var_21096994a10739c.size ] = instance;
            }
        }
        else
        {
            instance setscriptablepartstate( "model", "broken" );
            level.var_6acf3cf8225c401e[ level.var_6acf3cf8225c401e.size ] = instance;
        }
    }
    
    if ( level.var_21096994a10739c.size == level.var_9732cf5a56a83abf.size )
    {
        function_d7a697b60611a198();
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0xaae48494, Offset: 0x3603
// Size: 0x12e
function function_d7a697b60611a198()
{
    for ( i = 0; i < level.var_21096994a10739c.size ; i++ )
    {
        if ( level.var_21096994a10739c[ i ].index == level.var_9732cf5a56a83abf[ i ].index )
        {
            level utility::flag_set( "bottle_success" );
            continue;
        }
        
        level utility::flag_clear( "bottle_success" );
        wait 1.5;
        level.var_21096994a10739c = [];
        
        foreach ( Bottle in level.var_9732cf5a56a83abf )
        {
            Bottle setscriptablepartstate( "vfx", "cover" );
            Bottle setscriptablepartstate( "model", "on" );
        }
        
        break;
    }
    
    if ( level utility::flag( "bottle_success" ) )
    {
        function_70e1ae35b29a770e();
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0xa24bc215, Offset: 0x3739
// Size: 0x87
function function_70e1ae35b29a770e()
{
    if ( !level utility::flag( "bottle_puzzle_complete" ) )
    {
        var_2153e39e051f5b91 = %"relic:sat_zm_firefly_eta_relic";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
        level utility::flag_set( "yp_already_spawned" );
        level utility::flag_set( "bottle_puzzle_complete" );
        return;
    }
    
    return;
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x9db96129, Offset: 0x37c8
// Size: 0x33
function setup_chompy()
{
    level.var_20f294df9f40800b = [];
    
    if ( !level callback::exists( "chompy_eats_weapon", &weapon_rarity_check ) )
    {
        level callback::add( "chompy_eats_weapon", &weapon_rarity_check );
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1, eflags: 0x4
// Checksum 0xf05c348a, Offset: 0x3803
// Size: 0x1c0
function private weapon_rarity_check( params )
{
    rarity = params.weapon_rarity;
    weapon = params.weapon;
    player = params.player;
    round_check = zm_utility::get_round_number();
    
    if ( rarity == 0 && level.var_20f294df9f40800b.size == 0 )
    {
        level.var_20f294df9f40800b[ level.var_20f294df9f40800b.size ] = rarity;
        return;
    }
    
    if ( rarity == 1 && level.var_20f294df9f40800b.size == 1 )
    {
        level.var_20f294df9f40800b[ level.var_20f294df9f40800b.size ] = rarity;
        return;
    }
    
    if ( rarity == 2 && level.var_20f294df9f40800b.size == 2 )
    {
        level.var_20f294df9f40800b[ level.var_20f294df9f40800b.size ] = rarity;
        return;
    }
    
    if ( rarity == 3 && level.var_20f294df9f40800b.size == 3 )
    {
        level.var_20f294df9f40800b[ level.var_20f294df9f40800b.size ] = rarity;
        return;
    }
    
    if ( rarity == 4 && level.var_20f294df9f40800b.size == 4 )
    {
        level.var_20f294df9f40800b[ level.var_20f294df9f40800b.size ] = rarity;
        return;
    }
    
    if ( ( weapon.basename == "sat_ww_raygun_mp" || weapon.basename == "sat_ww_raygunmark2_mp" ) && level.var_20f294df9f40800b.size == 5 && round_check >= 40 )
    {
        level.var_20f294df9f40800b[ level.var_20f294df9f40800b.size ] = rarity;
        function_dcf7341fb538725a();
        return;
    }
    
    level.var_20f294df9f40800b = [];
    return;
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x422d43cc, Offset: 0x39cb
// Size: 0x9b
function function_dcf7341fb538725a()
{
    if ( level.var_20f294df9f40800b.size == 6 )
    {
        if ( !level utility::flag( "chompy_complete" ) )
        {
            var_2153e39e051f5b91 = %"relic:sat_zm_firefly_mu_relic";
            index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
            namespace_a6c33b614364964::portal_spawn( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
            level utility::flag_set( "yp_already_spawned" );
            level utility::flag_set( "chompy_complete" );
        }
        else
        {
            return;
        }
        
        return;
    }
    
    return;
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x9cc1ff22, Offset: 0x3a6e
// Size: 0xc1
function function_81d4bb35b2d1bc08()
{
    a_s_telephones = utility::getstructarray( "r_tp", "targetname" );
    a_s_telephones = arrayrandomize( a_s_telephones );
    telephone_spawn = utility::array_random( a_s_telephones );
    level.round_telephone = spawnscriptable( "zm_relic_telephone", telephone_spawn.origin, telephone_spawn.angles );
    level.round_telephone setscriptablepartstate( "model", "visible" );
    level.round_telephone setscriptablepartstate( "audio", "ringing" );
    level.var_6c5301842a5e4b28 = zm_quest::function_91f9590e98d57ff6( level.round_telephone.origin, &phone_pickedup, &phone_hint, "small" );
}

// Namespace namespace_77b3320b96286ddf
// Params 2
// Checksum 0xd174ea39, Offset: 0x3b37
// Size: 0x36
function phone_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x622f2c5a, Offset: 0x3b76
// Size: 0xc4
function phone_pickedup( player )
{
    level endon( #"game_ended" );
    
    if ( level.var_6c5301842a5e4b28 )
    {
        level.var_6c5301842a5e4b28 freescriptable();
    }
    
    level.round_telephone setscriptablepartstate( "audio", "laugh" );
    wait 3;
    
    if ( level.round_telephone )
    {
        level.round_telephone setscriptablepartstate( "audio", "off" );
    }
    
    waitframe();
    
    if ( level.round_telephone )
    {
        level.round_telephone setscriptablepartstate( "model", "hidden" );
    }
    
    level.a_phone_answered[ level.a_phone_answered.size ] = 1;
    
    if ( level.a_phone_answered.size >= 5 )
    {
        function_bdb31e410d926990();
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x3c8c61e5, Offset: 0x3c42
// Size: 0x87
function function_bdb31e410d926990()
{
    if ( !level utility::flag( "all_phones_answered" ) )
    {
        var_2153e39e051f5b91 = %"relic:sat_zm_firefly_beta_relic";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
        level utility::flag_set( "rp_already_spawned" );
        level utility::flag_set( "all_phones_answered" );
        return;
    }
    
    return;
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x3445349a, Offset: 0x3cd1
// Size: 0x4d
function function_3541a32ae8984bd3()
{
    level endon( #"game_ended" );
    level utility::flag_wait_all( "zm_quest_initialized", "scriptables_ready" );
    waitframe();
    level.firefly_main_quest utility::ent_flag_wait( "zm_quest_completed" );
    
    if ( level.var_dd5a72f42d9c38e )
    {
        function_ddce6083b6acdb12();
        return;
    }
    
    return;
}

// Namespace namespace_77b3320b96286ddf
// Params 0
// Checksum 0x20d192c3, Offset: 0x3d26
// Size: 0x9f
function function_ddce6083b6acdb12()
{
    if ( !level utility::flag( "mq_completed_r_60" ) )
    {
        wait 5;
        var_2153e39e051f5b91 = %"relic:sat_zm_firefly_delta_relic";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
        level utility::flag_set( "rp_already_spawned" );
        level utility::flag_set( "mq_completed_r_60" );
        level.var_dd5a72f42d9c38e = 0;
        level.var_ae96560687cb440 = 1;
        return;
    }
    
    return;
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x13e2b22a, Offset: 0x3dcd
// Size: 0x3a
function tessie_challenge_start( params )
{
    if ( level utility::flag( "td_challenge_failed" ) && !level utility::flag_set( "td_challenge_success" ) )
    {
        level utility::flag_clear( "td_challenge_failed" );
        return;
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x1ec6b7ba, Offset: 0x3e0f
// Size: 0xb8
function function_8ec1e10f24b813d( params )
{
    if ( level utility::flag( "td_challenge_failed" ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.bgb_enabled[ "time_out" ] )
        {
            return;
        }
    }
    
    level utility::flag_set( "td_challenge_success" );
    check_tessie_challenge_complete();
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0xbf0156ad, Offset: 0x3ecf
// Size: 0xa8
function tessie_damage_check( params )
{
    einflictor = params.einflictor;
    eattacker = params.eattacker;
    sweapon = params.sweapon;
    
    if ( isplayer( eattacker ) )
    {
        if ( einflictor.vehiclename == "veh_sat_firefly_pluto" || sweapon.basename == "sat_pluto_dg2" )
        {
            return;
        }
        
        if ( einflictor.classname == "trigger_hurt" )
        {
            return;
        }
        
        level utility::flag_set( "td_challenge_failed" );
    }
}

// Namespace namespace_77b3320b96286ddf
// Params 1
// Checksum 0x553306c2, Offset: 0x3f7f
// Size: 0xa7
function check_tessie_challenge_complete( vehicle )
{
    if ( !level utility::flag( "tessie_challenge_complete" ) )
    {
        var_2153e39e051f5b91 = %"relic:sat_zm_firefly_kappa_relic";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
        level callback::remove( #"on_ai_killed", &tessie_damage_check );
        level utility::flag_set( "rp_already_spawned" );
        level utility::flag_set( "tessie_challenge_complete" );
        return;
    }
    
    return;
}

/#

    // Namespace namespace_77b3320b96286ddf
    // Params 0, eflags: 0x4
    // Checksum 0x79f1e75a, Offset: 0x402e
    // Size: 0x2e, Type: dev
    function private init_relic_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x2f>", "<dev string:x3c>", &function_bf7d3598a177d1f3 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_77b3320b96286ddf
    // Params 0
    // Checksum 0x4460e7d1, Offset: 0x4064
    // Size: 0x75, Type: dev
    function function_bf7d3598a177d1f3()
    {
        level utility::flag_set( "<dev string:x49>" );
        level utility::flag_set( "<dev string:x5a>" );
        level.var_4efcd27b3901f68b = spawnstruct();
        level.var_2dcd5e17bdbbdb7b = spawnstruct();
        level.var_600538b41630b28d[ level.var_600538b41630b28d.size ] = level.var_4efcd27b3901f68b;
        level.var_600538b41630b28d[ level.var_600538b41630b28d.size ] = level.var_2dcd5e17bdbbdb7b;
    }

#/
