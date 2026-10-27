// script_359e7c9d91207445  (hash_359e7c9d91207445.gscc) (size: 22935 Bytes / 0x5997 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe84f554f (3897513295)
// size ...... 22935 (0x5997)
// includes .. 20  (offset: 0x50c7)
// strings ... 129 (offset: 0x5167)
// dev strs .. 1   (offset: 0x598b)
// exports ... 51  (offset: 0x3607)
// cseg ...... 0x91f + 0x2ce8 (0x3607)
// imports ... 138 (offset: 0x3dff)
// animtree1 . 0   (offset: 0x5997)
// animtree2 . 0   (offset: 0x5997)
#using script_16ea1b94f0f381b3;
#using script_3b6eb865087dc118;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\overlord;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;

#namespace namespace_eb2390cd97be6a19;

// Namespace namespace_eb2390cd97be6a19
// Params 0, eflags: 0x5
// Checksum 0x215aa8f1, Offset: 0x93d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_17965b67cef6e218", undefined, undefined, &init );
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0xc799b5f3, Offset: 0x95e
// Size: 0x20b
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
    
    if ( !level.var_49d838013a096e6c && !getdvarint( @"hash_be4855acac8d71e9", 0 ) )
    {
        return;
    }
    
    if ( !level.var_49d838013a096e6c && !getdvarint( @"hash_307752bc7a505a1f", 0 ) )
    {
        return;
    }
    
    level utility::waittill_notify_or_timeout( "relic_level_set", 15 );
    level callback::add( "on_round_start", &function_5aea60ff18d0f508 );
    
    switch ( level.zm_relic_tier )
    {
        case 0:
            function_487f9e5930842a56();
            logstring( "[R_MOD] Mantis Relic EE's unlocked successfully, Tier 0" );
            break;
        case 1:
            function_487f9e5930842a56();
            function_463fd72850c2f91b();
            logstring( "[R_MOD] Mantis Relic EE's unlocked successfully, Tier 1" );
            break;
        case 2:
            function_487f9e5930842a56();
            function_463fd72850c2f91b();
            function_162ad694402905d0();
            logstring( "[R_MOD] Mantis Relic EE's unlocked successfully, Tier 2" );
            break;
        case 3:
            function_487f9e5930842a56();
            function_463fd72850c2f91b();
            function_162ad694402905d0();
            logstring( "[R_MOD] Mantis Relic EE's unlocked successfully, Tier 3" );
            break;
    }
    
    level._effect[ #"zombie_trail" ] = loadfxasset( "vfx_sat_gameplay_zm_cr_sc_trail_red" );
    level._effect[ #"zombie_impact" ] = loadfxasset( "vfx_sat_gameplay_zm_cr_sc_impact_red" );
    level._effect[ #"collar_trail" ] = loadfxasset( "vfx_t10_gameplay_zm_loot_trail_legendary" );
    level._effect[ #"ball_vfx" ] = loadfxasset( "vfx_sat_zm_mantis_rh_tb" );
    level callback::add( #"relic_challenge_started", &function_f7f8879b0284af5c );
    level callback::add( #"relic_challenge_ended", &function_1ddd99ce98d6dab8 );
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x66f2499f, Offset: 0xb71
// Size: 0x19
function function_f7f8879b0284af5c( params )
{
    level utility::flag_set( "relic_challenge_active" );
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x497fdeb9, Offset: 0xb92
// Size: 0x6f
function function_5aea60ff18d0f508( params )
{
    round_number = params.roundnumber;
    
    if ( round_number == 40 )
    {
        function_9c595ed2d99d1855();
        level callback::remove( "on_round_start", &function_5aea60ff18d0f508 );
    }
    
    if ( round_number >= 40 && zm_save::function_1dda3554974a999e() )
    {
        function_9c595ed2d99d1855();
        level callback::remove( "on_round_start", &function_5aea60ff18d0f508 );
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x82c7108e, Offset: 0xc09
// Size: 0x9d
function function_1ddd99ce98d6dab8( params )
{
    relic_challenge_type = params.relic_challenge_type;
    level utility::flag_clear( "relic_challenge_active" );
    
    switch ( relic_challenge_type )
    {
        case %"hash_5fd98af539578121":
            level utility::flag_clear( "gp_already_spawned" );
            break;
        case %"hash_349c69bd2c8f6c8e":
            level utility::flag_clear( "yp_already_spawned" );
            break;
        case %"hash_4f62ab03d511d66f":
            level utility::flag_clear( "rp_already_spawned" );
            break;
        default:
            break;
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0x2a80101f, Offset: 0xcae
// Size: 0x8b
function relic_challenge_unlocked()
{
    foreach ( player in level.players )
    {
        player playlocalsound( "evt_relic_challenge_unlocked_mrpeeks_stinger" );
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0xaf41f0b3, Offset: 0xd41
// Size: 0x26
function function_487f9e5930842a56()
{
    level.dogs_pet = 0;
    level callback::add( "on_turned", &function_5fa2bc0256019094 );
    level thread function_f2a6f8b334b98d5a();
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0x8b60acc6, Offset: 0xd6f
// Size: 0x10d
function function_463fd72850c2f91b()
{
    chimney_trigger = getent( "ghc_td", "targetname" );
    level.collar_start = utility::getstruct( "cl_st" );
    level.collar_mid = utility::getstruct( "c_md" );
    level.collar_end = utility::getstruct( "cl_ld" );
    level.var_a54368d8a875e7d4 = utility::getstruct( "s_lc" );
    level.var_64b4c2bb8eb81f63 = utility::getstruct( "s_l_st" );
    level.grave_end = utility::getstruct( "tb_f" );
    chimney_trigger thread chimney_damage_watcher();
    level.var_58a4da601dd05ca0 = spawnscriptable( "zm_sat_cr_dirt", level.var_a54368d8a875e7d4.origin, level.var_a54368d8a875e7d4.angles );
    level.grave_fx = spawnscriptable( "zm_sat_cr_dirt", level.grave_end.origin, level.grave_end.angles );
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0xbdf2da86, Offset: 0xe84
// Size: 0x97
function function_162ad694402905d0()
{
    level callback::add( "mrp_appeared", &magicbox_used );
    s_fn_mailbox = utility::getstruct( "fn_mb" );
    var_171f68751d3f3f59 = utility::getstruct( "pn_mb" );
    level.fn_mailbox = spawnscriptable( "zm_sat_cr_mb_burnt", s_fn_mailbox.origin, s_fn_mailbox.angles );
    level.pn_mailbox = spawnscriptable( "zm_sat_cr_mb", var_171f68751d3f3f59.origin, var_171f68751d3f3f59.angles );
    mailbox_interacts();
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0x48b8fc31, Offset: 0xf23
// Size: 0x25
function function_9c595ed2d99d1855()
{
    grave_radius = getent( "g_tv", "targetname" );
    grave_radius thread grave_watcher();
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0xcee979ec, Offset: 0xf50
// Size: 0x9e
function function_5fa2bc0256019094( params )
{
    timeline = time_travel::get_current_timeline();
    
    if ( timeline.name != "past" )
    {
        return;
    }
    
    if ( self.subclass == "zombie_methone" )
    {
        utility::waittill_notify_or_timeout( "hound_petting", 45 );
        
        if ( self.being_pet == 1 )
        {
            num_zombie_left = zm_round_spawning::get_round_enemies();
            
            if ( num_zombie_left.size <= 1 )
            {
                level.dogs_pet++;
                level callback::remove( "on_turned", &function_5fa2bc0256019094 );
                function_9cd3179dcd60f78a();
            }
        }
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 0, eflags: 0xc
// Checksum 0xeff59a03, Offset: 0xff6
// Size: 0x64
function private function_f2a6f8b334b98d5a()
{
    self notify( #"hash_fb2889fa2773fe0e" );
    self endon( #"hash_fb2889fa2773fe0e" );
    level utility::waittill_notify_and_time( "dawg_pet", 0.5 );
    timeline = time_travel::get_current_timeline();
    
    if ( timeline.name != "future" )
    {
        return;
    }
    
    level.dogs_pet++;
    function_9cd3179dcd60f78a();
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0x7276728a, Offset: 0x1062
// Size: 0x9b
function function_9cd3179dcd60f78a()
{
    if ( level.dogs_pet == 2 && !level utility::flag( "dog_portal_spawned" ) )
    {
        level thread relic_challenge_unlocked();
        var_2153e39e051f5b91 = %"hash_5fd98af539578121";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::function_9a0db59ed1b757d4( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
        level utility::flag_set( "gp_already_spawned" );
        level utility::flag_set( "dog_portal_spawned" );
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0x2906efeb, Offset: 0x1105
// Size: 0x237
function chimney_damage_watcher()
{
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( eattacker ) )
        {
            if ( smeansofdeath == "MOD_EXPLOSION" || smeansofdeath == "MOD_GRENADE_SPLASH" && !level utility::flag( "collar_spawned" ) )
            {
                level utility::flag_set( "collar_spawned" );
                level.collar = utility::spawn_model( "sat_zm_h_col", level.collar_start.origin );
                level.collar hudoutlineenable( "outline_depth_orange" );
                playfxontag( level._effect[ #"collar_trail" ], level.collar, "tag_origin" );
                waitframe();
                level.collar utility::function_8001268940441423( level.collar_start.origin, level.collar_end.origin, level.collar_mid.origin, 1.5, undefined, 1 );
                stopfxontag( level._effect[ #"collar_trail" ], level.collar, "tag_origin" );
                playfxontag( level._effect[ #"ball_vfx" ], level.collar, "tag_origin" );
                level.collar thread bob_loot_item( 1.5, 1, 1 );
                level.collar_interact = zm_quest::function_91f9590e98d57ff6( level.collar_end.origin, &collar_pickedup, &collar_hint, "small" );
            }
        }
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 2
// Checksum 0x7c840a1c, Offset: 0x1344
// Size: 0x36
function collar_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0xb886fd28, Offset: 0x1383
// Size: 0xd2
function collar_pickedup( player )
{
    level endon( #"game_ended" );
    playsoundatpos( level.collar.origin, #"hash_8913f5c173c756c0" );
    level.collar delete();
    level.collar_interact freescriptable();
    level utility::flag_set( "collar_collected" );
    player utility::ent_flag_set( "collar_owner" );
    level callback::add( "on_turned", &function_52f68ff549179771 );
    
    if ( utility::percent_chance( 50 ) )
    {
        overlord::playevent( "twins_notso_1", level.players, 1 );
    }
    else
    {
        overlord::playevent( "twins_notso_2", level.players, 1 );
    }
    
    level.var_21920135eb0f324b = utility::getstruct( "hh_b" );
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x1a0eb225, Offset: 0x145d
// Size: 0x8b
function function_52f68ff549179771( params )
{
    timeline = time_travel::get_current_timeline();
    
    if ( timeline.name == "future" )
    {
        return;
    }
    
    if ( self.subclass == "zombie_methone" && params.attacker utility::ent_flag( "collar_owner" ) && !level utility::flag( "fluffy_turned" ) )
    {
        level utility::flag_set( "fluffy_turned" );
        fluffy_settings();
        function_265d57ecf850b4ed();
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0x2f7e71e, Offset: 0x14f0
// Size: 0x334
function fluffy_settings()
{
    namespace_659599414270bd0a::function_80623a2279a4d888();
    val::set( #"fluffy", "ignoreall", 1 );
    val::set( #"fluffy", "ignoreme", 1 );
    val::set( #"fluffy", "ignore_ai_collision", 1 );
    val::set( #"fluffy", "disallow_knockdown", 1 );
    val::set( #"fluffy", "disallow_stun", 1 );
    val::set( #"fluffy", "disallow_slow", 1 );
    val::set( #"fluffy", "damage", 0 );
    val::set( #"fluffy", "death", 0 );
    val::set( #"fluffy", "collide_with_ai_allies", 0 );
    val::set( #"fluffy", "script_pushable_by_ai", 0 );
    val::set( #"fluffy", "script_pushable", 0 );
    val::set( #"fluffy", "ignore_cleanup", 1 );
    utility::callsharedfunc( #"ai", #"hash_d1ade7b3c059cba9", "fluffy", 1 );
    self function_7f8988ce63c1623d( 0 );
    self.var_923fd785fff9159b = 1;
    self.var_7ee152b43c7188e1 = 1;
    self.b_cleanup_no_respawn = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.no_powerups = 1;
    self.var_15598d8e493afe88 = 1;
    self.collared = 1;
    
    if ( isdefined( self._blackboard ) )
    {
        self._blackboard.var_ea5eb773cb969ee1 = 0;
        self._blackboard.brainrotowner = undefined;
    }
    
    foreach ( effects in self.status_effects )
    {
        foreach ( effect in effects )
        {
            effect.end_time = gettime();
        }
    }
    
    self function_54d3d4ceb3d0bc90();
    
    if ( self.active_attractors.size > 0 )
    {
        foreach ( attractor in self.active_attractors )
        {
            zombie_attractor_manager::function_dcfb4c31f1d97cd2( attractor );
        }
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 2
// Checksum 0x131cccf2, Offset: 0x182c
// Size: 0x36
function ball_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x7b491671, Offset: 0x186b
// Size: 0x73
function ball_pickedup( player )
{
    level endon( #"game_ended" );
    level.var_f9eb442fe53b74d freescriptable();
    playsoundatpos( level.fluffy_ball.origin, #"hash_8913f5c173c756c0" );
    level.fluffy_ball delete();
    wait 1;
    level.var_6a4650454c5238f3 kill();
    level utility::flag_set( "ball_collected" );
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0x59aead7e, Offset: 0x18e6
// Size: 0x1af
function function_265d57ecf850b4ed()
{
    self function_9dd2ab67d1a87a77( 0 );
    self setbtgoalpos( 2, level.var_21920135eb0f324b.origin );
    level.dig_model = utility::spawn_model( "tag_origin", level.var_21920135eb0f324b.origin, level.var_21920135eb0f324b.angles );
    
    while ( true )
    {
        dis = distancesquared( self.var_5e0be30a5816a64d, level.var_21920135eb0f324b.origin );
        
        /#
            sphere( level.var_21920135eb0f324b.origin, 15, ( 1, 0, 0 ), 0, 50 );
        #/
        
        if ( dis <= squared( 5 ) )
        {
            level.var_58a4da601dd05ca0 setscriptablepartstate( "fx", "dig" );
            thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "dig", "hellhound_dig_complete", level.var_21920135eb0f324b.origin, level.var_21920135eb0f324b.angles, undefined );
            utility::function_32b24db3127bff40( "digging", "digging_on" );
            thread spawn_ball( level.var_a54368d8a875e7d4, self );
            self waittill( #"hellhound_dig_complete" );
            playfxontag( level._effect[ #"ball_vfx" ], level.fluffy_ball, "tag_origin" );
            utility::function_32b24db3127bff40( "digging", "digging_off" );
            level.var_58a4da601dd05ca0 setscriptablepartstate( "fx", "off" );
            self function_786bb6aa1b76c7ee( "petting", 1 );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 2
// Checksum 0x38c0a11, Offset: 0x1a9d
// Size: 0x108
function spawn_ball( struct, var_62f538f25aff1d94 )
{
    level.fluffy_ball = spawn( "script_model", level.var_64b4c2bb8eb81f63.origin );
    level.fluffy_ball.angles = level.var_64b4c2bb8eb81f63.angles;
    level.fluffy_ball setscale( 1.3 );
    level.fluffy_ball setmodel( "sat_zm_d_b" );
    level.fluffy_ball hudoutlineenable( "outline_depth_orange" );
    level.fluffy_ball linkto( var_62f538f25aff1d94, "j_tongue_5", ( -1, 2.5, -2.15 ), ( 0, 0, 0 ) );
    level.var_6a4650454c5238f3 = var_62f538f25aff1d94;
    wait 2;
    level.var_f9eb442fe53b74d = zm_quest::function_91f9590e98d57ff6( level.fluffy_ball.origin, &ball_pickedup, &ball_hint, "medium" );
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0x54257824, Offset: 0x1bad
// Size: 0x8f
function grave_watcher()
{
    self endon( #"death" );
    
    while ( self )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && level utility::flag( "ball_collected" ) && level utility::flag( "collar_collected" ) )
        {
            if ( ent.inlaststand && !level utility::flag( "tomb_raised" ) )
            {
                level utility::flag_set( "tomb_raised" );
                level thread grave_raise( self );
                break;
            }
        }
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0xb4b6e0e8, Offset: 0x1c44
// Size: 0xfc
function grave_raise( grave_radius )
{
    grave_radius delete();
    level.grave_start = utility::getstruct( "tb_st" );
    level.grave_end = utility::getstruct( "tb_f" );
    level.grave_fx setscriptablepartstate( "fx", "on" );
    tomb = utility::spawn_model( "sat_zm_tb_cm", level.grave_start.origin );
    tomb rotateto( level.grave_end.angles, 0.1 );
    tomb moveto( level.grave_end.origin, 5, 1 );
    wait 2;
    level.grave_fx freescriptable();
    level.tomb_interact = zm_quest::function_91f9590e98d57ff6( level.grave_end.origin, &tomb_pickedup, &tomb_hint, "small" );
}

// Namespace namespace_eb2390cd97be6a19
// Params 2
// Checksum 0x45318fff, Offset: 0x1d48
// Size: 0x36
function tomb_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x9d97a360, Offset: 0x1d87
// Size: 0x9d
function tomb_pickedup( player )
{
    level endon( #"game_ended" );
    level.tomb_interact freescriptable();
    var_af303c74703b246d = utility::getstruct( "b_pl" );
    s_collar = utility::getstruct( "c_pl" );
    utility::spawn_model( "sat_zm_d_b", var_af303c74703b246d.origin, var_af303c74703b246d.angles );
    utility::spawn_model( "sat_zm_h_col", s_collar.origin, s_collar.angles );
    funeral_complete();
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0x2361355c, Offset: 0x1e2c
// Size: 0x7b
function funeral_complete()
{
    level thread relic_challenge_unlocked();
    var_2153e39e051f5b91 = %"hash_349c69bd2c8f6c8e";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::function_9a0db59ed1b757d4( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
    level utility::flag_set( "yp_already_spawned" );
    level utility::flag_set( "tomb_portal_spawned" );
}

// Namespace namespace_eb2390cd97be6a19
// Params 3, eflags: 0x4
// Checksum 0x37ece5fa, Offset: 0x1eaf
// Size: 0x9b
function private bob_loot_item( bobspeed, var_72aed9155bce2622, spinspeed )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self movez( 5, 0.1 );
    self waittill( #"movedone" );
    move_dir = 1;
    acceleration_const = bobspeed * 0.25;
    
    while ( isdefined( self ) )
    {
        self movez( 7 * move_dir, bobspeed, acceleration_const, acceleration_const );
        self waittill( #"movedone" );
        move_dir *= -1;
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0xa345d65d, Offset: 0x1f52
// Size: 0x4d
function magicbox_used( params )
{
    level.magicbox = params.var_349a0723ed9ac19c;
    level.mrp_box = params.peeks;
    valid_distance_check( level.magicbox, level.mrp_box );
}

// Namespace namespace_eb2390cd97be6a19
// Params 2
// Checksum 0xc339e998, Offset: 0x1fa7
// Size: 0x291
function valid_distance_check( box, peeks )
{
    level endon( #"game_ended" );
    timeline = time_travel::get_current_timeline();
    
    if ( timeline.name == "future" && level utility::flag( "future_peeks_collected" ) )
    {
        return;
    }
    
    if ( timeline.name == "past" && level utility::flag( "past_peeks_collected" ) )
    {
        return;
    }
    
    if ( level utility::flag( "past_peeks_collected" ) && level utility::flag( "future_peeks_collected" ) )
    {
        level callback::remove( "mrp_appeared", &magicbox_used );
        return;
    }
    
    while ( peeks )
    {
        players_near_box = getplayersinradius( box.origin, 500, undefined, 1 );
        
        foreach ( player in players_near_box )
        {
            if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_paris_favor" ) )
            {
                continue;
            }
            
            player.fn_mary_paris_started = &function_d89fd1eb9decfe90;
            player.near_box = 1;
        }
        
        foreach ( player in level.players )
        {
            if ( !player.near_box )
            {
                player.fn_mary_paris_started = undefined;
            }
            
            player.near_box = 0;
        }
        
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        player.near_box = 0;
        player.fn_mary_paris_started = undefined;
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x49489ed, Offset: 0x2240
// Size: 0x26
function peeks_activated( params )
{
    if ( level.peeks )
    {
        self.fn_mary_paris_started = &function_d89fd1eb9decfe90;
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 1, eflags: 0x4
// Checksum 0x93d0ca6b, Offset: 0x226e
// Size: 0x2dd
function private function_d89fd1eb9decfe90( mdl_bunny )
{
    if ( !mdl_bunny )
    {
        return;
    }
    
    self.fn_mary_paris_started = undefined;
    v_home = mdl_bunny.origin;
    v_angles = mdl_bunny.angles;
    mdl_bunny setscriptablepartstate( "animation", "idle_to_attack" );
    mdl_bunny setscriptablepartstate( "particle", "attack" );
    targetpos = level.peeks.origin;
    var_929d0623891294a1 = distance2dsquared( targetpos, mdl_bunny.origin );
    attacktime = var_929d0623891294a1 / 360000;
    attacktime *= attacktime;
    attacktime = clamp( attacktime, 0.2, 2 );
    var_9f11e6ceea53353d = attacktime + 0.15;
    launchorigin = mdl_bunny.origin;
    rotatetoangle = vectortoangles( targetpos - mdl_bunny.origin );
    rotatetoangle = ( rotatetoangle[ 0 ] + 45, rotatetoangle[ 1 ], rotatetoangle[ 2 ] );
    
    for ( i = 0; i < 2 ; i++ )
    {
        playsoundatpos( mdl_bunny.origin, "eqp_fug_mary_paris_mrpeeks_dash" );
        mdl_bunny rotateto( rotatetoangle, 0.3, 0.1 );
        mdl_bunny moveto( targetpos, attacktime, 0.2 );
        wait var_9f11e6ceea53353d;
        
        if ( i == 1 )
        {
            level.fake_peeks = utility::spawn_model( level.peeks.model, level.peeks.origin, level.peeks.angles );
            waitframe();
            
            if ( level.fake_peeks )
            {
                level.fake_peeks linkto( mdl_bunny, "tag_origin", ( 0, 0, 50 ), ( 0, 0, 0 ) );
                
                foreach ( player in level.players )
                {
                    level.peeks hidefromplayer( player );
                }
            }
        }
        
        mdl_bunny setscriptablepartstate( "animation", "attack_to_idle" );
        mdl_bunny rotateto( v_angles, 0.3, 0.1 );
        mdl_bunny moveto( v_home, attacktime, 0.2 );
        wait var_9f11e6ceea53353d;
        
        if ( level.fake_peeks )
        {
            level.fake_peeks unlink();
            level thread function_f97bf4aab9d3e479( level.fake_peeks, mdl_bunny );
        }
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 2
// Checksum 0xcff5d11, Offset: 0x2553
// Size: 0xe6
function function_f97bf4aab9d3e479( peeks, field_peeks )
{
    level endon( #"game_ended" );
    landing_loc = field_peeks.origin;
    peek_pop = spawnscriptable( "zm_sat_cr_mrp_pop", field_peeks.origin, field_peeks.angles );
    
    while ( field_peeks )
    {
        peeks rotateyaw( 360, 0.25 );
        waitframe();
    }
    
    if ( peek_pop )
    {
        peek_pop setscriptablepartstate( "vfx", "on" );
    }
    
    peeks_ground = utility::drop_to_ground( landing_loc );
    peeks moveto( peeks_ground + ( 0, 0, 15 ), 0.25 );
    level.peeks_interact = zm_quest::function_91f9590e98d57ff6( peeks.origin, &peeks_interact, &peeks_hint, "small" );
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0xc9300009, Offset: 0x2641
// Size: 0x94
function peeks_interact( player )
{
    if ( level.peeks_interact )
    {
        level.peeks_interact freescriptable();
    }
    
    if ( level.fake_peeks )
    {
        level.fake_peeks delete();
    }
    
    timeline = time_travel::get_current_timeline();
    
    if ( timeline.name == "future" )
    {
        level utility::flag_set( "future_peeks_collected" );
    }
    
    if ( timeline.name == "past" )
    {
        level utility::flag_set( "past_peeks_collected" );
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 2
// Checksum 0x37dad841, Offset: 0x26dd
// Size: 0x36
function peeks_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0x31b7d843, Offset: 0x271c
// Size: 0x64
function mailbox_interacts()
{
    level.var_c03b1e2b31b749e8 = zm_quest::function_91f9590e98d57ff6( level.fn_mailbox.origin, &function_a784f8bc529f608c, &mb_hint, "small" );
    level.var_63f21429b4669816 = zm_quest::function_91f9590e98d57ff6( level.pn_mailbox.origin, &mbp_interact, &mb_hint, "small" );
}

// Namespace namespace_eb2390cd97be6a19
// Params 2
// Checksum 0x9ad064e1, Offset: 0x2788
// Size: 0x36
function mb_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x4d46c375, Offset: 0x27c7
// Size: 0x7e
function function_a784f8bc529f608c( player )
{
    if ( level utility::flag( "past_peeks_collected" ) )
    {
        level.var_c03b1e2b31b749e8 freescriptable();
        var_78de1c7c1da1a51 = utility::getstruct( "fn_mb_mrp" );
        level.future_peeks = utility::spawn_model( "wm_ob_mrp", var_78de1c7c1da1a51.origin, var_78de1c7c1da1a51.angles );
        level utility::flag_set( "fmp_set" );
        function_af6216f92fbef87d();
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x3be2c98e, Offset: 0x284d
// Size: 0x7e
function mbp_interact( player )
{
    if ( level utility::flag( "future_peeks_collected" ) )
    {
        level.var_63f21429b4669816 freescriptable();
        var_af2a480f82c5d257 = utility::getstruct( "pn_mb_mrp" );
        level.past_peeks = utility::spawn_model( "wm_ob_mrp", var_af2a480f82c5d257.origin, var_af2a480f82c5d257.angles );
        level utility::flag_set( "pmp_set" );
        function_af6216f92fbef87d();
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0xed40f5cb, Offset: 0x28d3
// Size: 0x33
function function_af6216f92fbef87d()
{
    if ( level utility::flag( "fmp_set" ) && level utility::flag( "pmp_set" ) )
    {
        level callback::add( "on_round_start", &check_round );
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0xb93b0aa4, Offset: 0x290e
// Size: 0x31f
function check_round( params )
{
    round_number = params.roundnumber;
    timeline = time_travel::get_current_timeline();
    
    if ( round_number >= 60 && !level utility::flag( "weapon_spawned" ) )
    {
        level utility::flag_set( "weapon_spawned" );
        level callback::add( #"item_weapon_picked_up", &knife_pickup );
        
        if ( timeline.name == "future" )
        {
            level.past_peeks delete();
            level.pn_mailbox setscriptablepartstate( "door", "open" );
            level.pn_mailbox setscriptablepartstate( "vfx", "on" );
            level.pn_mailbox setscriptablepartstate( "flag", "up" );
            level.past_knife = utility::getstruct( "pn_k" );
            var_8a61d4195b4b6e64 = getscriptbundle( "itemspawnentry:zm_sat_item_weapon_me_knife_ultra_quest" );
            spawnoptions = common_item::function_bc5ff2958b71a708( level.past_knife.origin, level.past_knife.angles );
            spawnoptions.var_fd47e835523b473f = 1;
            spawnoptions.critical = 1;
            knife_weapon = item_weapon::function_b960bc85ea91de14( var_8a61d4195b4b6e64, spawnoptions );
            knife_weapon.relic_knife = 1;
            knife_weapon.struct = level.past_knife;
            knife_weapon.var_3546f709e76066ce = level.pn_mailbox;
            knife_weapon.from_quest = 1;
            level.relic_knife = knife_weapon;
            level callback::add( "timetravel_done", &timetravel_activated );
            level callback::remove( "on_round_start", &check_round );
        }
        
        if ( timeline.name == "past" )
        {
            level.future_peeks delete();
            level.fn_mailbox setscriptablepartstate( "door", "open" );
            level.fn_mailbox setscriptablepartstate( "vfx", "on" );
            level.fn_mailbox setscriptablepartstate( "flag", "up" );
            level.future_knife = utility::getstruct( "fn_k" );
            var_8a61d4195b4b6e64 = getscriptbundle( "itemspawnentry:zm_sat_item_weapon_me_knife_ultra_quest" );
            spawnoptions = common_item::function_bc5ff2958b71a708( level.future_knife.origin, level.future_knife.angles );
            spawnoptions.var_fd47e835523b473f = 1;
            spawnoptions.critical = 1;
            knife_weapon = item_weapon::function_b960bc85ea91de14( var_8a61d4195b4b6e64, spawnoptions );
            knife_weapon.relic_knife = 1;
            knife_weapon.struct = level.future_knife;
            knife_weapon.var_3546f709e76066ce = level.fn_mailbox;
            level.relic_knife = knife_weapon;
            level callback::add( "timetravel_done", &timetravel_activated );
            level callback::remove( "on_round_start", &check_round );
        }
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0xe71d7d4f, Offset: 0x2c35
// Size: 0x129
function knife_pickup( params )
{
    knife = params.item;
    struct = knife.origin;
    var_3546f709e76066ce = knife.var_3546f709e76066ce;
    
    if ( params.item == level.relic_knife && !level utility::flag( "knife_pickedup" ) )
    {
        level utility::flag_set( "knife_pickedup" );
        timeline = time_travel::get_current_timeline();
        self.relic_knife = 1;
        level.relic_knife = params.item.weaponobj;
        function_7f0f8dacc7c86563( timeline, struct, var_3546f709e76066ce );
        level callback::add( #"player_item_drop", &knife_drop );
        return;
    }
    
    if ( params.item.relic_knife && level utility::flag( "knife_pickedup" ) )
    {
        self.relic_knife = 1;
        level callback::add( #"player_item_drop", &knife_drop );
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x6a02ad1b, Offset: 0x2d66
// Size: 0x69
function knife_drop( params )
{
    if ( self.relic_knife && params.weaponobj.ismelee )
    {
        self.relic_knife = 0;
        params.item.relic_knife = 1;
        level callback::remove( #"player_item_drop", &knife_drop );
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 3
// Checksum 0x2850ba4e, Offset: 0x2dd7
// Size: 0x20c
function function_7f0f8dacc7c86563( timeline, struct, var_3546f709e76066ce )
{
    if ( timeline.name == "past" )
    {
        var_d75033f34db4981e = utility::getstructarray( "zone_culdesac_3_p", "target" );
        mimic_spawner = var_d75033f34db4981e[ 1 ];
    }
    
    if ( timeline.name == "future" )
    {
        var_d75033f34db4981e = utility::getstructarray( "zone_culdesac_3_f", "target" );
        mimic_spawner = var_d75033f34db4981e[ 3 ];
    }
    
    round_number = zm_round_logic::get_rb_round_number();
    
    if ( !level utility::flag( "mimic_spawned" ) )
    {
        level utility::flag_set( "mimic_spawned" );
        mimic = agent_manager::spawn_agent( "zombie_mimic_emp", mimic_spawner.origin, ( 0, 0, 0 ), "team_two_hundred" );
        waitframe();
        
        if ( mimic )
        {
            mimic setscriptablepartstate( "mouth", "mouth_red" );
        }
        
        struct_params = spawnstruct();
        struct_params.var_3546f709e76066ce = var_3546f709e76066ce;
        struct_params.struct = struct;
        struct_params.timeline = timeline;
        
        if ( !level callback::exists( "on_zombie_ai_killed", &function_c7cc0d848a893687, struct_params ) )
        {
            level callback::add( "on_zombie_ai_killed", &function_c7cc0d848a893687, struct_params );
        }
        
        if ( !level callback::exists( "timetravel_done", &function_822b5642b4c4993d ) )
        {
            level callback::add( "timetravel_done", &function_822b5642b4c4993d );
        }
        
        if ( isdefined( mimic ) )
        {
            mimic.var_eefa301859152d7e = 1;
            mimic.no_powerups = 1;
            mimic zombie_utils::set_zombie_round_difficulty( round_number );
            mimic.ignore_enemy_count = 1;
            mimic.var_a13bed1ac47e1b2c = 1;
            mimic.disable_brain_rot = 1;
            
            if ( isdefined( mimic_spawner.script_animation ) )
            {
                mimic thread zone_spawner::function_ce10e453e7f7bb8e( mimic_spawner.zone );
            }
            
            level.knife_mimic = mimic;
        }
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x593be119, Offset: 0x2feb
// Size: 0x165
function timetravel_activated( params )
{
    timeline = time_travel::get_current_timeline();
    
    if ( level utility::flag( "weapon_spawned" ) )
    {
        if ( timeline.name == "future" )
        {
            if ( level.past_peeks )
            {
                level.past_peeks delete();
                level.pn_mailbox setscriptablepartstate( "flag", "up" );
                level.pn_mailbox setscriptablepartstate( "door", "open" );
                level.pn_mailbox setscriptablepartstate( "vfx", "on" );
                level.past_knife = utility::getstruct( "pn_k" );
                level callback::remove( "timetravel_done", &timetravel_activated );
            }
        }
        
        if ( timeline.name == "past" )
        {
            if ( level.future_peeks )
            {
                level.fn_mailbox setscriptablepartstate( "flag", "up" );
                level.fn_mailbox setscriptablepartstate( "door", "open" );
                level.fn_mailbox setscriptablepartstate( "vfx", "on" );
                level.future_peeks delete();
                level.future_knife = utility::getstruct( "fn_k" );
                level callback::remove( "timetravel_done", &timetravel_activated );
            }
        }
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0xe0858d5e, Offset: 0x3158
// Size: 0x26
function function_822b5642b4c4993d( params )
{
    if ( level.knife_mimic )
    {
        level.knife_mimic kill();
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 2
// Checksum 0x3c1cc6e5, Offset: 0x3186
// Size: 0x1e7
function function_c7cc0d848a893687( params, struct_params )
{
    if ( self.subclass == "zombie_mimic_emp" && self.var_eefa301859152d7e )
    {
        if ( isplayer( params.eattacker ) && params.eattacker.relic_knife )
        {
            if ( params.smeansofdeath == "MOD_MELEE" && params.objweapon.basename == "sat_me_knife_mp" )
            {
                level callback::remove( "on_zombie_ai_killed", &function_c7cc0d848a893687, struct_params );
                charge_fx( self getcentroid(), struct_params.struct );
                level.fn_mailbox setscriptablepartstate( "vfx", "despawn" );
                level.pn_mailbox setscriptablepartstate( "vfx", "despawn" );
                level.fn_mailbox setscriptablepartstate( "door", "closed" );
                level.pn_mailbox setscriptablepartstate( "door", "closed" );
                level.fn_mailbox setscriptablepartstate( "flag", "down" );
                level.pn_mailbox setscriptablepartstate( "flag", "down" );
                function_f94fd9d84e73685e();
                level.knife_mimic = undefined;
                
                if ( !level callback::exists( "on_round_start", &mimic_respawn ) )
                {
                    level callback::remove( "on_round_start", &mimic_respawn );
                }
                
                return;
            }
        }
        
        level.fail_round = zm_round_logic::get_rb_round_number();
        level.fail_timeline = struct_params.timeline;
        
        if ( !level callback::exists( "on_round_start", &mimic_respawn ) )
        {
            level callback::add( "on_round_start", &mimic_respawn );
        }
        
        level utility::flag_clear( "mimic_spawned" );
        level.knife_mimic = undefined;
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 2
// Checksum 0x606bc2d0, Offset: 0x3375
// Size: 0xbd
function charge_fx( v_start, v_end )
{
    e_s_fx = utility::spawn_model( "tag_origin", v_start );
    e_e_fx = utility::spawn_model( "tag_origin", v_end );
    playfxontag( level._effect[ #"zombie_trail" ], e_s_fx, "tag_origin" );
    n_time = distance2d( v_start, v_end ) / 200;
    e_s_fx utility::function_8001268940441423( v_start, v_end, v_start + ( 0, 0, 48 ), n_time, 0, 1 );
    playfxontag( level._effect[ #"zombie_impact" ], e_e_fx, "tag_origin" );
    e_s_fx delete();
}

// Namespace namespace_eb2390cd97be6a19
// Params 1
// Checksum 0x48db6360, Offset: 0x343a
// Size: 0xc7
function mimic_respawn( params )
{
    round_number = zm_round_logic::get_rb_round_number();
    timeline = time_travel::get_current_timeline();
    
    if ( timeline != level.fail_timeline )
    {
        if ( round_number > level.fail_round )
        {
            switch ( timeline.name )
            {
                case #"hash_c72ecd84b20c267d":
                    function_7f0f8dacc7c86563( timeline, level.past_knife.origin, level.pn_mailbox );
                    break;
                case #"hash_af2e8fb2786941f6":
                    function_7f0f8dacc7c86563( timeline, level.future_knife.origin, level.fn_mailbox );
                    break;
            }
        }
    }
}

// Namespace namespace_eb2390cd97be6a19
// Params 0
// Checksum 0x6cecb486, Offset: 0x3509
// Size: 0xfe
function function_f94fd9d84e73685e()
{
    level thread relic_challenge_unlocked();
    var_2153e39e051f5b91 = %"hash_4f62ab03d511d66f";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::function_9a0db59ed1b757d4( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
    level.fn_mailbox setscriptablepartstate( "vfx", "off" );
    level.pn_mailbox setscriptablepartstate( "vfx", "off" );
    level.fn_mailbox setscriptablepartstate( "door", "off" );
    level.pn_mailbox setscriptablepartstate( "door", "off" );
    level.fn_mailbox setscriptablepartstate( "flag", "down" );
    level.pn_mailbox setscriptablepartstate( "flag", "start" );
    level utility::flag_set( "rp_already_spawned" );
}

