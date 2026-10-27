// script_556cff3c98539353  (hash_556cff3c98539353.gscc) (size: 22508 Bytes / 0x57ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x81e31989 (2179144073)
// size ...... 22508 (0x57ec)
// includes .. 11  (offset: 0x4fd0)
// strings ... 107 (offset: 0x5028)
// dev strs .. 14  (offset: 0x5744)
// exports ... 57  (offset: 0x3630)
// cseg ...... 0xa31 + 0x2bff (0x3630)
// imports ... 117 (offset: 0x3f18)
// animtree1 . 0   (offset: 0x57ec)
// animtree2 . 0   (offset: 0x57ec)
#using script_3b6eb865087dc118;
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_assault_rounds;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zone_manager;

#namespace namespace_101578c1f044040d;

// Namespace namespace_101578c1f044040d
// Params 0, eflags: 0x5
// Checksum 0x8cda0835, Offset: 0xa4f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_1f910fd713542d78", undefined, undefined, &init );
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x900df188, Offset: 0xa70
// Size: 0x1fb
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
    
    if ( !level.var_75e4ad2e594a0834 && !getdvarint( @"hash_be4855acac8d71e9", 0 ) )
    {
        return;
    }
    
    if ( !level.var_75e4ad2e594a0834 && !getdvarint( @"hash_307752bc7a505a1f", 0 ) )
    {
        return;
    }
    
    level utility::waittill_notify_or_timeout( "relic_level_set", 15 );
    level._effect[ #"zombie_trail" ] = loadfxasset( "vfx_sat_gameplay_zm_cr_sc_trail_red" );
    level._effect[ #"zombie_impact" ] = loadfxasset( "vfx_sat_gameplay_zm_cr_sc_impact_red" );
    level._effect[ #"cover_fx" ] = loadfxasset( "vfx_t10_gameplay_zm_magic_box_bunny_rarity_white_disappear" );
    level callback::add( "on_round_start", &function_5aea60ff18d0f508 );
    
    switch ( level.zm_relic_tier )
    {
        case 0:
            function_487f9e5930842a56();
            logstring( "[R_MOD] Locust Relic EE's unlocked successfully, Tier 0" );
            break;
        case 1:
            function_487f9e5930842a56();
            function_463fd72850c2f91b();
            logstring( "[R_MOD] Locust Relic EE's unlocked successfully, Tier 1" );
            break;
        case 2:
            function_487f9e5930842a56();
            function_463fd72850c2f91b();
            level thread function_162ad694402905d0();
            logstring( "[R_MOD] Locust Relic EE's unlocked successfully, Tier 2" );
            break;
        case 3:
            function_487f9e5930842a56();
            function_463fd72850c2f91b();
            level thread function_162ad694402905d0();
            logstring( "[R_MOD] Locust Relic EE's unlocked successfully, Tier 3" );
            break;
    }
    
    level callback::add( #"relic_challenge_started", &function_f7f8879b0284af5c );
    level callback::add( #"relic_challenge_ended", &function_1ddd99ce98d6dab8 );
    
    /#
        level thread init_relic_debug();
    #/
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0xe10f36f, Offset: 0xc73
// Size: 0x3a
function function_f7f8879b0284af5c( params )
{
    level utility::flag_set( "relic_challenge_active" );
    
    if ( level utility::flag( "ar_active" ) )
    {
        level zm_sat_hornet_assault_rounds::function_ae879757529e15f2();
    }
    
    level zm_sat_hornet_assault_rounds::set_assault_rounds_blocked( 1 );
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0xda0c61d9, Offset: 0xcb5
// Size: 0x82
function function_5aea60ff18d0f508( params )
{
    round_number = params.roundnumber;
    
    if ( round_number >= 20 && !level utility::flag( "round_20_triggered" ) )
    {
        level utility::flag_set( "round_20_triggered" );
        function_cbd9dd3a226ed4ff();
    }
    
    if ( round_number >= 60 && level.zm_relic_tier >= 2 )
    {
        function_e79f0c1a2068c143();
        level callback::remove( "on_round_start", &function_5aea60ff18d0f508 );
        return;
    }
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0x149767cd, Offset: 0xd3f
// Size: 0xeb
function function_1ddd99ce98d6dab8( params )
{
    relic_challenge_type = params.relic_challenge_type;
    level utility::flag_clear( "relic_challenge_active" );
    level zm_sat_hornet_assault_rounds::set_assault_rounds_blocked( 0 );
    
    switch ( relic_challenge_type )
    {
        case %"hash_206c58be07475f03":
            level utility::flag_clear( "gp_already_spawned" );
            break;
        case %"hash_75da7916dbe1672a":
            level utility::flag_clear( "gp_already_spawned" );
            break;
        case %"hash_6450e64abe7e170f":
            level utility::flag_clear( "yp_already_spawned" );
            break;
        case %"hash_591f83c2d331a8ba":
            level utility::flag_clear( "yp_already_spawned" );
            break;
        case %"hash_2a3c31ac35b565e6":
            level utility::flag_clear( "rp_already_spawned" );
            break;
        case %"hash_141e115159c7b3f1":
            level utility::flag_clear( "rp_already_spawned" );
            break;
    }
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x4d7a7e0b, Offset: 0xe32
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

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x6eb4ca71, Offset: 0xec5
// Size: 0x1f
function function_487f9e5930842a56()
{
    level callback::add( #"player_damaged", &on_player_damaged );
    function_33ef949d00588e26();
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xf9f892b0, Offset: 0xeec
// Size: 0x42
function function_463fd72850c2f91b()
{
    level.var_53e8b3b9893b1d76 = [];
    level callback::add( "zm_packed_weapon", &on_pap_weapon );
    level.shard_number = 0;
    level callback::add( "hornetww_enemy_transformed", &function_a25595c9bb77842c );
    level thread spawn_catnip();
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xf59fe4da, Offset: 0xf36
// Size: 0x39
function function_162ad694402905d0()
{
    level endon( #"game_ended" );
    level utility::flag_wait_or_timeout( "relic_states_restored", 10 );
    
    if ( level.var_1f33183f27882b21 )
    {
        function_474c47f826827553();
        return;
    }
    
    level thread function_31acaf494a90e4ef();
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x420667c0, Offset: 0xf77
// Size: 0x9
function function_cbd9dd3a226ed4ff()
{
    function_198ada1a05e9da4a();
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xb32de50c, Offset: 0xf88
// Size: 0x9
function function_e79f0c1a2068c143()
{
    function_67818faad572a625();
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xe9f93458, Offset: 0xf99
// Size: 0xc0
function function_33ef949d00588e26()
{
    level.var_c7aceb6241203cb2 = utility::spawn_model( "sat_zm_drum_sticks", ( 823.237, -22644.6, 201.263 ), ( 67.2123, 136.242, 100.215 ) );
    level.var_c1843055414a8ded = zm_quest::function_91f9590e98d57ff6( level.var_c7aceb6241203cb2.origin, &function_56600300de4cd01, &stick_hint, "small" );
    level.var_c7acea6241203a7f = utility::spawn_model( "sat_zm_drum_sticks", ( -1496.61, -17373.4, 1222.58 ), ( 359.963, 121.998, 0.398653 ) );
    level.var_11af6d00513c1546 = zm_quest::function_91f9590e98d57ff6( level.var_c7acea6241203a7f.origin, &function_2782f5042bf77f72, &stick_hint, "small" );
}

// Namespace namespace_101578c1f044040d
// Params 2
// Checksum 0x8b6980ba, Offset: 0x1061
// Size: 0x36
function stick_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0x63c16680, Offset: 0x10a0
// Size: 0x4c
function function_56600300de4cd01( player )
{
    level.var_c1843055414a8ded freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level.var_c7aceb6241203cb2 delete();
    level utility::flag_set( "drumstick_1_picked_up" );
    function_7081342e9eb3f5ce();
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0x632a513b, Offset: 0x10f4
// Size: 0x4c
function function_2782f5042bf77f72( player )
{
    level.var_11af6d00513c1546 freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level.var_c7acea6241203a7f delete();
    level utility::flag_set( "drumstick_2_picked_up" );
    function_7081342e9eb3f5ce();
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xdfe6f7c0, Offset: 0x1148
// Size: 0x213
function function_7081342e9eb3f5ce()
{
    if ( level utility::flag( "drumstick_1_picked_up" ) && level utility::flag( "drumstick_2_picked_up" ) )
    {
        iprintlnbold( "INTENSE DRUMMING" );
        level.players[ 0 ] playsoundtoteam( "evt_relicq_taiko_stinger", "allies" );
        level.var_b0a8f69d50995d3d = spawnscriptable( "sat_zm_db_part", ( 2781.31, -22137.4, 475.436 ), ( 0, 75.7994, 0 ) );
        level.var_b0a8f69d50995d3d setscriptablepartstate( "vfx", "on" );
        level.var_f229d50a9b599068 = zm_quest::function_91f9590e98d57ff6( level.var_b0a8f69d50995d3d.origin, &dm_initiate, &stick_hint, "small" );
        level.var_c882d1f3f040c1c4 = spawnscriptable( "sat_zm_db_part", ( 3054.92, -22206.7, 475.436 ), ( 0, 75.7994, 0 ) );
        level.var_ae6ca7e0e339d3b3 = [ [ 1, 2, 1, 2, 2, 1, 1, 2, 1, 2 ], [ 2, 1, 2, 1, 1, 2, 2, 1, 2, 1 ], [ 1, 1, 2, 2, 1, 2, 1, 1, 2, 2 ] ];
        drum_1 = getent( "jp_d_1", "targetname" );
        drum_2 = getent( "jp_d_2", "targetname" );
        drum_1.number = 1;
        drum_2.number = 2;
        drum_1 thread drum_damage_check();
        drum_2 thread drum_damage_check();
    }
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0x34601d3d, Offset: 0x1363
// Size: 0x1bf
function dm_initiate( params )
{
    level endon( #"game_ended" );
    iprintlnbold( "DRUM SEQUENCE STARTED" );
    level.var_f229d50a9b599068 freescriptable();
    level.var_b0a8f69d50995d3d setscriptablepartstate( "vfx", "off" );
    level.dr_seq = utility::array_random( level.var_ae6ca7e0e339d3b3 );
    level.var_58680ad86fa2b94e = [ level.dr_seq[ 0 ], level.dr_seq[ 1 ], level.dr_seq[ 2 ] ];
    level.var_586809d86fa2b71b = [ level.dr_seq[ 0 ], level.dr_seq[ 1 ], level.dr_seq[ 2 ], level.dr_seq[ 3 ], level.dr_seq[ 4 ], level.dr_seq[ 5 ] ];
    level.var_586808d86fa2b4e8 = [ level.dr_seq[ 0 ], level.dr_seq[ 1 ], level.dr_seq[ 2 ], level.dr_seq[ 3 ], level.dr_seq[ 4 ], level.dr_seq[ 5 ], level.dr_seq[ 6 ], level.dr_seq[ 7 ], level.dr_seq[ 8 ], level.dr_seq[ 9 ] ];
    level.var_4b3883c14a465721 = [];
    wait 3;
    function_ee32101b6bd70083();
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x3645827b, Offset: 0x152a
// Size: 0xa6
function function_ee32101b6bd70083()
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < level.var_58680ad86fa2b94e.size ; i++ )
    {
        switch ( level.var_58680ad86fa2b94e[ i ] )
        {
            case 1:
                level.var_b0a8f69d50995d3d setscriptablepartstate( "vfx", "impact_1" );
                break;
            case 2:
                level.var_c882d1f3f040c1c4 setscriptablepartstate( "vfx", "impact_2" );
                break;
        }
        
        wait 0.5;
    }
    
    level utility::flag_set( "check_pattern" );
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xaf4cd3c1, Offset: 0x15d8
// Size: 0xa6
function function_ee32111b6bd702b6()
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < level.var_586809d86fa2b71b.size ; i++ )
    {
        switch ( level.var_586809d86fa2b71b[ i ] )
        {
            case 1:
                level.var_b0a8f69d50995d3d setscriptablepartstate( "vfx", "impact_1" );
                break;
            case 2:
                level.var_c882d1f3f040c1c4 setscriptablepartstate( "vfx", "impact_2" );
                break;
        }
        
        wait 0.5;
    }
    
    level utility::flag_set( "check_pattern" );
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xd84be357, Offset: 0x1686
// Size: 0xa6
function function_ee32121b6bd704e9()
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < level.var_586808d86fa2b4e8.size ; i++ )
    {
        switch ( level.var_586808d86fa2b4e8[ i ] )
        {
            case 1:
                level.var_b0a8f69d50995d3d setscriptablepartstate( "vfx", "impact_1" );
                break;
            case 2:
                level.var_c882d1f3f040c1c4 setscriptablepartstate( "vfx", "impact_2" );
                break;
        }
        
        wait 0.5;
    }
    
    level utility::flag_set( "check_pattern" );
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x67b6ba7, Offset: 0x1734
// Size: 0x4bc
function drum_damage_check()
{
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( eattacker ) && level utility::flag( "check_pattern" ) )
        {
            level.var_4b3883c14a465721[ level.var_4b3883c14a465721.size ] = self.number;
            
            if ( self.number == 1 )
            {
                eattacker playsoundtoplayer( "evt_relicq_taiko_drum_hit_low", eattacker );
                level.var_b0a8f69d50995d3d setscriptablepartstate( "vfx", "impact_1" );
            }
            else
            {
                eattacker playsoundtoplayer( "evt_relicq_taiko_drum_hit_high", eattacker );
                level.var_c882d1f3f040c1c4 setscriptablepartstate( "vfx", "impact_2" );
            }
            
            if ( level.var_4b3883c14a465721.size == 3 && !level utility::flag( "drum_challenge_1_complete" ) )
            {
                if ( arrays_equal( level.var_4b3883c14a465721, level.var_58680ad86fa2b94e ) )
                {
                    iprintlnbold( "DRUM SEQUENCE COMPLETE" );
                    level utility::flag_set( "drum_challenge_1_complete" );
                    
                    if ( level.var_4b3883c14a465721.size == 3 )
                    {
                        level utility::flag_clear( "check_pattern" );
                        wait 2;
                        function_ee32111b6bd702b6();
                    }
                }
                else
                {
                    iprintlnbold( "DRUM SEQUENCE FAILED, TRY AGAIN" );
                    level.players[ 0 ] playsoundtoteam( "evt_plr_oob_impact_laugh", "allies" );
                    level.var_f229d50a9b599068 = zm_quest::function_91f9590e98d57ff6( level.var_b0a8f69d50995d3d.origin, &dm_initiate, &stick_hint, "small" );
                    level.var_b0a8f69d50995d3d setscriptablepartstate( "vfx", "on" );
                    level utility::flag_clear( "check_pattern" );
                }
                
                level.var_4b3883c14a465721 = [];
            }
            else if ( level.var_4b3883c14a465721.size == 6 && !level utility::flag( "drum_challenge_2_complete" ) )
            {
                if ( arrays_equal( level.var_4b3883c14a465721, level.var_586809d86fa2b71b ) )
                {
                    iprintlnbold( "DRUM SEQUENCE COMPLETE" );
                    level utility::flag_set( "drum_challenge_2_complete" );
                    
                    if ( level.var_4b3883c14a465721.size == 6 )
                    {
                        level utility::flag_clear( "check_pattern" );
                        wait 2;
                        function_ee32121b6bd704e9();
                    }
                }
                else
                {
                    iprintlnbold( "DRUM SEQUENCE FAILED, TRY AGAIN" );
                    level.players[ 0 ] playsoundtoteam( "evt_plr_oob_impact_laugh", "allies" );
                    level.var_f229d50a9b599068 = zm_quest::function_91f9590e98d57ff6( level.var_b0a8f69d50995d3d.origin, &dm_initiate, &stick_hint, "small" );
                    level.var_b0a8f69d50995d3d setscriptablepartstate( "vfx", "on" );
                    level utility::flag_clear( "check_pattern" );
                    level utility::flag_clear( "drum_challenge_1_complete" );
                }
                
                level.var_4b3883c14a465721 = [];
            }
            else if ( level.var_4b3883c14a465721.size == 10 && !level utility::flag( "drum_challenge_3_complete" ) )
            {
                if ( arrays_equal( level.var_4b3883c14a465721, level.var_586808d86fa2b4e8 ) )
                {
                    iprintlnbold( "DRUM SUCCESS. PORTAL SPAWNED" );
                    level utility::flag_set( "drum_challenge_3_complete" );
                    gramophone_complete();
                }
                else
                {
                    iprintlnbold( "DRUM SEQUENCE FAILED, TRY AGAIN" );
                    level.players[ 0 ] playsoundtoteam( "evt_plr_oob_impact_laugh", "allies" );
                    level.var_f229d50a9b599068 = zm_quest::function_91f9590e98d57ff6( level.var_b0a8f69d50995d3d.origin, &dm_initiate, &stick_hint, "small" );
                    level.var_b0a8f69d50995d3d setscriptablepartstate( "vfx", "on" );
                    level utility::flag_clear( "drum_challenge_1_complete" );
                    level utility::flag_clear( "drum_challenge_2_complete" );
                    level utility::flag_clear( "check_pattern" );
                }
            }
            
            continue;
        }
        
        if ( level utility::flag( "drum_challenge_3_complete" ) )
        {
            if ( self.number == 1 )
            {
                eattacker playsoundtoplayer( "evt_relicq_taiko_drum_hit_low", eattacker );
                level.var_b0a8f69d50995d3d setscriptablepartstate( "vfx", "impact_1" );
                continue;
            }
            
            eattacker playsoundtoplayer( "evt_relicq_taiko_drum_hit_high", eattacker );
            level.var_c882d1f3f040c1c4 setscriptablepartstate( "vfx", "impact_2" );
        }
    }
}

// Namespace namespace_101578c1f044040d
// Params 2
// Checksum 0xcb900838, Offset: 0x1bf8
// Size: 0x4c, Type: bool
function arrays_equal( a, b )
{
    if ( a.size != b.size )
    {
        return false;
    }
    
    for ( i = 0; i < a.size ; i++ )
    {
        if ( a[ i ] != b[ i ] )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x5b3de5bf, Offset: 0x1c4d
// Size: 0x7b
function gramophone_complete()
{
    level thread relic_challenge_unlocked();
    var_2153e39e051f5b91 = %"hash_206c58be07475f03";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::portal_spawn( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
    level utility::flag_set( "gp_already_spawned" );
    level utility::flag_set( "Gramophone_portal_spawned" );
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0xfe1842dc, Offset: 0x1cd0
// Size: 0xe9
function on_player_damaged( params )
{
    player = params.victim;
    
    if ( isplayer( player ) && isai( params.eattacker ) && !player.relic_damage )
    {
        player.relic_damage = 1;
    }
    
    foreach ( player in level.players )
    {
        if ( !player.relic_damage )
        {
            return;
        }
    }
    
    level callback::remove( #"player_damaged", &on_player_damaged );
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x91e62bfa, Offset: 0x1dc1
// Size: 0xfe
function function_198ada1a05e9da4a()
{
    foreach ( player in level.players )
    {
        if ( !player.relic_damage )
        {
            level thread relic_challenge_unlocked();
            var_2153e39e051f5b91 = %"hash_75da7916dbe1672a";
            index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
            namespace_a6c33b614364964::portal_spawn( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
            level utility::flag_set( "gp_already_spawned" );
            level utility::flag_set( "Druid_Stone_portal_spawned" );
            continue;
        }
    }
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0xfe0b6625, Offset: 0x1ec7
// Size: 0x80
function on_pap_weapon( params )
{
    weapon = params.var_101633ed971732ba.basename;
    
    if ( !arraycontains( level.var_53e8b3b9893b1d76, weapon ) )
    {
        level.var_53e8b3b9893b1d76[ level.var_53e8b3b9893b1d76.size ] = weapon;
        
        if ( level.var_53e8b3b9893b1d76.size >= 10 )
        {
            level callback::remove( "zm_packed_weapon", &on_pap_weapon );
            function_8d884014f4afa8b5();
        }
    }
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xf8e09e7d, Offset: 0x1f4f
// Size: 0x7b
function function_8d884014f4afa8b5()
{
    level thread relic_challenge_unlocked();
    var_2153e39e051f5b91 = %"hash_6450e64abe7e170f";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::portal_spawn( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
    level utility::flag_set( "yp_already_spawned" );
    level utility::flag_set( "film_reel_portal_spawned" );
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0x27dcbd0e, Offset: 0x1fd2
// Size: 0xf4
function function_a25595c9bb77842c( params )
{
    if ( isplayer( params.player ) && params.player.inside_bubble_shield )
    {
        trigger = params.player.trigger;
        
        if ( trigger )
        {
            if ( !isdefined( trigger.var_8ab0e58f0bcb46ff ) )
            {
                trigger.var_8ab0e58f0bcb46ff = 0;
            }
            
            trigger.var_8ab0e58f0bcb46ff++;
            iprintlnbold( "Number of Cats Spawned: " + trigger.var_8ab0e58f0bcb46ff );
            
            if ( trigger.var_8ab0e58f0bcb46ff >= 10 && !trigger utility::ent_flag( "shard_goal_hit" ) )
            {
                trigger utility::ent_flag_set( "shard_goal_hit" );
                origin = params.player.bubble_origin;
                spawn_shard( origin, trigger );
            }
        }
    }
}

// Namespace namespace_101578c1f044040d
// Params 2, eflags: 0xc
// Checksum 0x19ee8a84, Offset: 0x20ce
// Size: 0x2c1
function private spawn_shard( origin, bubble )
{
    self notify( #"hash_e4a564660d93f992" );
    self endon( #"hash_e4a564660d93f992" );
    level endon( #"game_ended" );
    level waittill( #"nya_shield_terminated" );
    ground_pos = utility::drop_to_ground( origin, 5, 3 );
    
    switch ( level.shard_number )
    {
        case 0:
            if ( !level utility::flag( "first_plate_shard_spawned" ) )
            {
                level.vh_shard = utility::spawn_model( "s4_jpn_crockery_plate_04_s1_f0", ground_pos + ( 0, 0, 10 ), ( 0, 0, 0 ) );
                level utility::flag_set( "first_plate_shard_spawned" );
                level.vh_shard thread quest_item_cleanup( "first_plate_shard_spawned" );
            }
            
            break;
        case 1:
            if ( !level utility::flag( "second_plate_shard_spawned" ) )
            {
                level.vh_shard = utility::spawn_model( "s4_jpn_crockery_plate_04_s1_f1", ground_pos + ( 0, 0, 10 ), ( 0, 0, 0 ) );
                level utility::flag_set( "second_plate_shard_spawned" );
                level.vh_shard thread quest_item_cleanup( "second_plate_shard_spawned" );
            }
            
            break;
        case 2:
            if ( !level utility::flag( "third_plate_shard_spawned" ) )
            {
                level.vh_shard = utility::spawn_model( "s4_jpn_crockery_plate_04_s1_f2", ground_pos + ( 0, 0, 10 ), ( 0, 0, 0 ) );
                level utility::flag_set( "third_plate_shard_spawned" );
                level.vh_shard thread quest_item_cleanup( "third_plate_shard_spawned" );
            }
            
            break;
        case 3:
            if ( !level utility::flag( "fourth_plate_shard_spawned" ) )
            {
                level.vh_shard = utility::spawn_model( "s4_jpn_crockery_plate_04_s1_f3", ground_pos + ( 0, 0, 10 ), ( 0, 0, 0 ) );
                level.vh_shard.final = 1;
                level utility::flag_set( "fourth_plate_shard_spawned" );
                level.vh_shard thread quest_item_cleanup( "fourth_plate_shard_spawned" );
            }
            
            break;
        default:
            break;
    }
    
    level.vh_shard hudoutlineenable( "outline_depth_orange" );
    level.var_76b4aaf7738d0416 = zm_quest::function_91f9590e98d57ff6( level.vh_shard.origin, &shard_pickedup, &blank_hint, "medium" );
    
    if ( isdefined( bubble ) )
    {
        bubble.var_8ab0e58f0bcb46ff = 0;
        bubble utility::ent_flag_clear( "shard_goal_hit" );
    }
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0xe918208a, Offset: 0x2397
// Size: 0xae
function shard_pickedup( player )
{
    level.var_76b4aaf7738d0416 freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    
    if ( level.vh_shard )
    {
        level.vh_shard delete();
    }
    
    level.shard_number++;
    
    if ( level.vh_shard.final )
    {
        level callback::remove( "hornetww_enemy_transformed", &function_a25595c9bb77842c );
        level utility::flag_set( "bubble_shards_collected" );
        level.fire_interact = zm_quest::function_91f9590e98d57ff6( ( 2249.37, -20080.9, 413.868 ), &place_shards, &blank_hint, "small" );
    }
}

// Namespace namespace_101578c1f044040d
// Params 1, eflags: 0x4
// Checksum 0x2a9ed806, Offset: 0x244d
// Size: 0x30
function private quest_item_cleanup( flag )
{
    level endon( #"game_ended" );
    wait 60;
    level utility::flag_clear( flag );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0x8df78e79, Offset: 0x2485
// Size: 0x10c
function place_shards( player )
{
    level.fire_interact freescriptable();
    level.var_aa387f19ab3cc8d3 = utility::spawn_model( "s4_jpn_crockery_plate_04_s1_f0", ( 2237.88, -20086.2, 407.094 ), ( 0, 279.899, 15.3995 ) );
    level.var_aa388019ab3ccb06 = utility::spawn_model( "s4_jpn_crockery_plate_04_s1_f1", ( 2255.72, -20074.4, 406.831 ), ( 350.571, 282.184, -13.6879 ) );
    level.var_aa388119ab3ccd39 = utility::spawn_model( "s4_jpn_crockery_plate_04_s1_f2", ( 2257.44, -20089.6, 410.997 ), ( 2.13965, 279.384, -6.90811 ) );
    level.var_aa388219ab3ccf6c = utility::spawn_model( "s4_jpn_crockery_plate_04_s1_f3", ( 2243.75, -20071.5, 406.799 ), ( 350.029, 280.862, -7.00901 ) );
    level.vh_bonfire = spawnscriptable( "sat_zm_bf_cr", ( 2249.37, -20080.9, 413.868 ) + ( 0, 0, -5 ) );
    level scriptable::scriptable_adddamagedcallback( &bonfire_damage_watcher );
}

// Namespace namespace_101578c1f044040d
// Params 11
// Checksum 0x6a48b5b0, Offset: 0x2599
// Size: 0xfa
function bonfire_damage_watcher( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "sat_zm_bf_cr" )
    {
        return;
    }
    
    if ( isplayer( eattacker ) )
    {
        if ( isplayer( eattacker ) && ( objweapon.basename == "sat_molotov_zm" || einflictor.ammo_mod[ 0 ].ammomodname == "napalmburst" ) )
        {
            iprintlnbold( "SHARD LIT" );
            level.vh_bonfire setscriptablepartstate( "vfx", "on" );
            level scriptable::function_dc174fecebb79952( &bonfire_damage_watcher );
            plate_repair();
            return;
        }
    }
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xe86371e8, Offset: 0x269b
// Size: 0x285
function plate_repair()
{
    level endon( #"game_ended" );
    level.var_aa387f19ab3cc8d3 moveto( ( 2243.44, -20082.9, 414.949 ), 4 );
    level.var_aa387f19ab3cc8d3 rotateto( ( 0, 279.299, 0 ), 4 );
    level.var_aa388019ab3ccb06 moveto( ( 2252.58, -20078.5, 415.033 ), 4 );
    level.var_aa388019ab3ccb06 rotateto( ( 0, 279.299, 0 ), 4 );
    level.var_aa388119ab3ccd39 moveto( ( 2249.5, -20083.1, 414.648 ), 4 );
    level.var_aa388119ab3ccd39 rotateto( ( 0, 279.299, 0 ), 4 );
    level.var_aa388219ab3ccf6c moveto( ( 2246.04, -20076.7, 414.793 ), 4 );
    level.var_aa388219ab3ccf6c rotateto( ( 0, 279.299, 0 ), 4 );
    wait 4;
    
    if ( level.var_aa387f19ab3cc8d3 )
    {
        level.var_aa387f19ab3cc8d3 thread function_e913129007a415da();
    }
    
    if ( level.var_aa388019ab3ccb06 )
    {
        level.var_aa388019ab3ccb06 thread function_e913129007a415da();
    }
    
    if ( level.var_aa388119ab3ccd39 )
    {
        level.var_aa388119ab3ccd39 thread function_e913129007a415da();
    }
    
    if ( level.var_aa388219ab3ccf6c )
    {
        level.var_aa388219ab3ccf6c thread function_e913129007a415da();
    }
    
    wait 1;
    
    if ( level.var_aa387f19ab3cc8d3 )
    {
        level.var_aa387f19ab3cc8d3 delete();
    }
    
    if ( level.var_aa388019ab3ccb06 )
    {
        level.var_aa388019ab3ccb06 delete();
    }
    
    if ( level.var_aa388119ab3ccd39 )
    {
        level.var_aa388119ab3ccd39 delete();
    }
    
    if ( level.var_aa388219ab3ccf6c )
    {
        level.var_aa388219ab3ccf6c delete();
    }
    
    level.vh_plate = utility::spawn_model( "s4_jpn_crockery_plate_04", ( 2249.37, -20080.9, 413.868 ), ( 0, 0, 0 ) );
    playfxontag( level._effect[ #"cover_fx" ], level.vh_plate, "tag_origin" );
    level.vh_plate thread bob_loot_item( 1.5, 1, 1 );
    level.vh_plate hudoutlineenable( "outline_depth_orange" );
    level.var_f2832b10110d719e = zm_quest::function_91f9590e98d57ff6( level.vh_plate.origin, &function_b28b12537a0cdb5a, &blank_hint, "small" );
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x26aecd89, Offset: 0x2928
// Size: 0x10
function function_e913129007a415da()
{
    utility::do_jitter( 0.25, 1 );
}

// Namespace namespace_101578c1f044040d
// Params 3, eflags: 0x4
// Checksum 0x50168bec, Offset: 0x2940
// Size: 0x9b
function private bob_loot_item( bobspeed, var_72aed9155bce2622, spinspeed )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self movez( 3, 0.1 );
    self waittill( #"movedone" );
    move_dir = 1;
    acceleration_const = bobspeed * 0.25;
    
    while ( isdefined( self ) )
    {
        self movez( 3 * move_dir, bobspeed, acceleration_const, acceleration_const );
        self waittill( #"movedone" );
        move_dir *= -1;
    }
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0x6a7bd1ba, Offset: 0x29e3
// Size: 0x51
function function_b28b12537a0cdb5a( player )
{
    level.var_f2832b10110d719e freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    
    if ( level.vh_plate )
    {
        level.vh_plate delete();
        level utility::flag_set( "plate_healed" );
    }
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x2ecab8d2, Offset: 0x2a3c
// Size: 0x89
function spawn_catnip()
{
    level endon( #"game_ended" );
    level waittill( #"cc_spawned" );
    
    if ( level utility::flag( "plate_healed" ) )
    {
        level.catnip = utility::spawn_model( "sat_zm_catnip_pile", ( -1572.6, -20590.3, 328.056 ), ( 0, 272.7, 0 ) );
        level.catnip_interact = zm_quest::function_91f9590e98d57ff6( level.catnip.origin, &catnip_pickedup, &blank_hint, "small" );
    }
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0x65ab66c2, Offset: 0x2acd
// Size: 0x63
function catnip_pickedup( player )
{
    level.catnip_interact freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level.catnip delete();
    level.offering_interact = zm_quest::function_91f9590e98d57ff6( ( -38.7374, -21038.2, 608.726 ), &offering_placement, &blank_hint, "small" );
}

// Namespace namespace_101578c1f044040d
// Params 2
// Checksum 0xe62ff070, Offset: 0x2b38
// Size: 0x36
function blank_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0x84f2e07d, Offset: 0x2b77
// Size: 0x8b
function offering_placement( player )
{
    level.offering_interact freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level.offering_plate = spawnscriptable( "sat_zm_p_of", ( -38.7374, -21038.2, 608.726 ), ( 0, 0, -5.39967 ) );
    level.offering_nip = utility::spawn_model( "sat_zm_catnip_pile", ( -38.4957, -21038.3, 609.638 ), ( 0, 0, -5.39967 ) );
    function_fa9b44356388b259();
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x5994dcd8, Offset: 0x2c0a
// Size: 0x9e
function function_fa9b44356388b259()
{
    level endon( #"game_ended" );
    level endon( #"offering_complete" );
    
    while ( true )
    {
        level waittill( #"ar_active" );
        
        if ( level.ar_root.current_sector == "ar_sec4" )
        {
            level.offering_zombies = 0;
            
            if ( !level callback::exists( "on_zombie_ai_killed", &function_a98bca4db5d01e54 ) )
            {
                level callback::add( "on_zombie_ai_killed", &function_a98bca4db5d01e54 );
            }
        }
        
        level waittill( #"ar_ended" );
        level callback::remove( "on_zombie_ai_killed", &function_a98bca4db5d01e54 );
        wait 5;
    }
}

// Namespace namespace_101578c1f044040d
// Params 1
// Checksum 0xbd7a552c, Offset: 0x2cb0
// Size: 0x1d9
function function_a98bca4db5d01e54( params )
{
    level endon( #"game_ended" );
    level endon( #"ar_ended" );
    var_251f4e1af05f5cd3 = zone_manager::get_current_zone();
    
    if ( isplayer( params.eattacker ) || isplayer( params.eattacker.owner ) )
    {
        if ( ( var_251f4e1af05f5cd3.script_zone_name == "zone_main_bailey_a" || var_251f4e1af05f5cd3.script_zone_name == "zone_main_bailey_b" || var_251f4e1af05f5cd3.script_zone_name == "zone_main_bailey_c" || var_251f4e1af05f5cd3.script_zone_name == "zone_main_bailey_d" ) && params.objweapon.basename == "sat_ww_hornet_zm" )
        {
            level.offering_zombies++;
            utility::function_24215250530eaebc( self getcentroid(), ( -38.7374, -21038.2, 608.726 ), level._effect[ #"zombie_trail" ], level._effect[ #"zombie_impact" ] );
        }
        
        if ( level.offering_zombies >= 50 && !level utility::flag( "offering_complete" ) )
        {
            level utility::flag_set( "offering_complete" );
            level notify( #"offering_complete" );
            level callback::remove( "on_zombie_ai_killed", &function_a98bca4db5d01e54 );
            
            if ( level.offering_plate )
            {
                level.offering_plate setscriptablepartstate( "vfx", "on" );
                
                if ( level.offering_nip )
                {
                    level.offering_nip delete();
                }
                
                level.offering_plate setscriptablepartstate( "model", "off" );
                wait 2;
                level.offering_plate freescriptable();
            }
            
            function_65bf8ecb715b161();
        }
    }
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xb9244533, Offset: 0x2e91
// Size: 0x8d
function function_65bf8ecb715b161()
{
    level thread relic_challenge_unlocked();
    var_2153e39e051f5b91 = %"hash_591f83c2d331a8ba";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::portal_spawn( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
    level callback::remove( "on_zombie_ai_killed", &function_a98bca4db5d01e54 );
    level utility::flag_set( "yp_already_spawned" );
    level utility::flag_set( "valkyrie_helmet_portal_spawned" );
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x9632f3eb, Offset: 0x2f26
// Size: 0x2b
function function_31acaf494a90e4ef()
{
    level endon( #"game_ended" );
    level utility::waittill_any( "hornet_mq_mystery_solved_first_attempt" );
    level thread spawn_symbols();
    level thread function_1753d5269944fe74();
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xfbc9f901, Offset: 0x2f59
// Size: 0xe2
function function_1753d5269944fe74()
{
    level endon( #"game_ended" );
    level utility::waittill_any( "hornet_mq_bossfight_fasttravel_started" );
    
    if ( level.symbol_1 )
    {
        level.symbol_1 freescriptable();
    }
    
    if ( level.symbol_2 )
    {
        level.symbol_2 freescriptable();
    }
    
    if ( level.symbol_3 )
    {
        level.symbol_3 freescriptable();
    }
    
    if ( isdefined( level.var_7f13ceaacec1dc2e[ "hard_1" ] ) && arraycontains( level.var_7f13ceaacec1dc2e, level.var_7f13ceaacec1dc2e[ "hard_1" ] ) )
    {
        level.var_7f13ceaacec1dc2e[ "hard_1" ].portal freescriptable();
        level.var_7f13ceaacec1dc2e[ "hard_1" ].portal.interact freescriptable();
    }
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x6611c34, Offset: 0x3043
// Size: 0x193
function spawn_symbols()
{
    var_d0f7f0994e4c80b7 = utility::getstructarray( "jp_s_l", "targetname" );
    var_d0f7f0994e4c80b7 = arrayrandomize( var_d0f7f0994e4c80b7 );
    level.symbol_1 = spawnscriptable( "sat_zm_s_lr", var_d0f7f0994e4c80b7[ 0 ].origin, var_d0f7f0994e4c80b7[ 0 ].angles );
    level.symbol_1.number = 0;
    level.symbol_1.flag = "symbol_1_hit";
    level.symbol_1.var_efdd24deb89a4b95 = 1;
    level.symbol_2 = spawnscriptable( "sat_zm_o_lr", var_d0f7f0994e4c80b7[ 1 ].origin, var_d0f7f0994e4c80b7[ 1 ].angles );
    level.symbol_2.number = 1;
    level.symbol_2.flag = "symbol_2_hit";
    level.symbol_2.var_efdd24deb89a4b95 = 1;
    level.symbol_3 = spawnscriptable( "sat_zm_a_lr", var_d0f7f0994e4c80b7[ 2 ].origin, var_d0f7f0994e4c80b7[ 2 ].angles );
    level.symbol_3.number = 2;
    level.symbol_3.flag = "symbol_3_hit";
    level.symbol_3.var_efdd24deb89a4b95 = 1;
    level.var_6ed8df0a4425dafa = 0;
    level scriptable::scriptable_adddamagedcallback( &symbol_damage_watcher );
}

// Namespace namespace_101578c1f044040d
// Params 11
// Checksum 0xaf8c8ceb, Offset: 0x31de
// Size: 0x1c6
function symbol_damage_watcher( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !instance.var_efdd24deb89a4b95 )
    {
        return;
    }
    
    if ( isplayer( eattacker ) )
    {
        if ( smeansofdeath == "MOD_MELEE" && !level utility::flag( instance.flag ) )
        {
            if ( instance.number == level.var_6ed8df0a4425dafa && objweapon.basename == "sat_me_elnath_mp" && eattacker.var_9606da20c1b52a78 )
            {
                level utility::flag_set( instance.flag );
                level.var_6ed8df0a4425dafa++;
                iprintlnbold( "CORRECT SYMBOL" );
                instance setscriptablepartstate( "vfx", "red" );
                
                if ( level.var_6ed8df0a4425dafa >= 3 )
                {
                    iprintlnbold( "SYMBOLS COMPLETE" );
                    level.var_1f33183f27882b21 = 1;
                    function_474c47f826827553();
                }
                
                return;
            }
            
            level.var_6ed8df0a4425dafa = 0;
            iprintlnbold( "SYMBOL FAILURE. RESTART" );
            level.symbol_1 setscriptablepartstate( "vfx", "blue" );
            level.symbol_2 setscriptablepartstate( "vfx", "blue" );
            level.symbol_3 setscriptablepartstate( "vfx", "blue" );
            level utility::flag_clear( "symbol_1_hit" );
            level utility::flag_clear( "symbol_2_hit" );
            level utility::flag_clear( "symbol_3_hit" );
        }
    }
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0xffbe33cc, Offset: 0x33ac
// Size: 0x7b
function function_474c47f826827553()
{
    level thread relic_challenge_unlocked();
    level utility::flag_set( "dragon_egg_portal_spawned" );
    var_2153e39e051f5b91 = %"hash_141e115159c7b3f1";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::portal_spawn( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
    level utility::flag_set( "rp_already_spawned" );
}

// Namespace namespace_101578c1f044040d
// Params 0
// Checksum 0x6ffa59bc, Offset: 0x342f
// Size: 0x92
function function_67818faad572a625()
{
    if ( !level.var_23f0535ecbba9ff3 )
    {
        level thread relic_challenge_unlocked();
        var_2153e39e051f5b91 = %"hash_2a3c31ac35b565e6";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
        level.var_23f0535ecbba9ff3 = 0;
        level utility::flag_set( "rp_already_spawned" );
        level utility::flag_set( "mannequin_turret_portal_spawned" );
    }
}

/#

    // Namespace namespace_101578c1f044040d
    // Params 0, eflags: 0x4
    // Checksum 0x38b76c24, Offset: 0x34c9
    // Size: 0x70, Type: dev
    function private init_relic_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x33>" );
        devgui::add_devgui_func( "<dev string:x42>", "<dev string:x5c>", &function_e85acc75ed4d523 );
        devgui::add_devgui_func( "<dev string:x6d>", "<dev string:x8e>", &function_44144244f5a0d4c );
        devgui::add_devgui_func( "<dev string:x99>", "<dev string:xb9>", &function_af73ec9fb909af90 );
        devgui::add_devgui_func( "<dev string:xc3>", "<dev string:xdc>", &function_f83824f6d874a02a );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_101578c1f044040d
    // Params 1, eflags: 0x4
    // Checksum 0x358ba9a7, Offset: 0x3541
    // Size: 0x62, Type: dev
    function private function_d744a2c3aa49c60c( pos )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            line( level.players[ 0 ].origin, pos.origin, ( 1, 1, 1 ), 1, 0, level.frameduration );
            waitframe();
        }
    }

    // Namespace namespace_101578c1f044040d
    // Params 0
    // Checksum 0x38ff05c9, Offset: 0x35ab
    // Size: 0x3d, Type: dev
    function function_e85acc75ed4d523()
    {
        level utility::flag_set( "<dev string:xe6>" );
        level.fire_interact = zm_quest::function_91f9590e98d57ff6( ( 2249.37, -20080.9, 413.868 ), &place_shards, &blank_hint, "<dev string:xfe>" );
    }

    // Namespace namespace_101578c1f044040d
    // Params 0
    // Checksum 0x19594bb1, Offset: 0x35f0
    // Size: 0x12, Type: dev
    function function_44144244f5a0d4c()
    {
        level utility::flag_set( "<dev string:x104>" );
    }

    // Namespace namespace_101578c1f044040d
    // Params 0
    // Checksum 0xf58d74d0, Offset: 0x360a
    // Size: 0x12, Type: dev
    function function_f83824f6d874a02a()
    {
        level utility::flag_set( "<dev string:x12b>" );
    }

    // Namespace namespace_101578c1f044040d
    // Params 0
    // Checksum 0x9665c56b, Offset: 0x3624
    // Size: 0xc, Type: dev
    function function_af73ec9fb909af90()
    {
        function_474c47f826827553();
    }

#/
