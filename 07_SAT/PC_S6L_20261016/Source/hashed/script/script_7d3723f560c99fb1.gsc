// script_7d3723f560c99fb1  (hash_7d3723f560c99fb1.gscc) (size: 23008 Bytes / 0x59e0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa6f36ae (2859415214)
// size ...... 23008 (0x59e0)
// includes .. 13  (offset: 0x5188)
// strings ... 113 (offset: 0x51f0)
// dev strs .. 13  (offset: 0x593c)
// exports ... 57  (offset: 0x378c)
// cseg ...... 0xab9 + 0x2cd3 (0x378c)
// imports ... 117 (offset: 0x4074)
// animtree1 . 0   (offset: 0x59e0)
// animtree2 . 0   (offset: 0x59e0)
#using script_3b6eb865087dc118;
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;

#namespace namespace_2f1b7b33eb8edd8b;

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0, eflags: 0x5
// Checksum 0xdcd66e5f, Offset: 0xad7
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_5eb584a6274d193e", undefined, undefined, &init );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x11634cd4, Offset: 0xaf8
// Size: 0x200
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
    
    if ( !level.var_bffa8890dbd9dca && !getdvarint( @"hash_be4855acac8d71e9", 0 ) )
    {
        return;
    }
    
    if ( !level.var_bffa8890dbd9dca && !getdvarint( @"hash_307752bc7a505a1f", 0 ) )
    {
        return;
    }
    
    level callback::add( "zm_perk_purchased", &function_e6744befac2e84ea );
    level callback::add( "zm_perk_obtained", &function_ca8cbd726ee395f3 );
    level utility::waittill_notify_or_timeout( "relic_level_set", 15 );
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
            function_162ad694402905d0();
            logstring( "[R_MOD] Locust Relic EE's unlocked successfully, Tier 2" );
            break;
        case 3:
            function_487f9e5930842a56();
            function_463fd72850c2f91b();
            function_162ad694402905d0();
            logstring( "[R_MOD] Locust Relic EE's unlocked successfully, Tier 3" );
            break;
    }
    
    level._effect[ #"zombie_trail" ] = loadfxasset( "vfx_sat_gameplay_zm_cr_sc_trail_red" );
    level._effect[ #"zombie_impact" ] = loadfxasset( "vfx_sat_gameplay_zm_cr_sc_impact_red" );
    level callback::add( #"relic_challenge_started", &function_f7f8879b0284af5c );
    level callback::add( #"relic_challenge_ended", &function_1ddd99ce98d6dab8 );
    
    /#
        level thread init_relic_debug();
    #/
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x1ac2fe0d, Offset: 0xd00
// Size: 0x19
function function_f7f8879b0284af5c( params )
{
    level utility::flag_set( "relic_challenge_active" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x625eae8d, Offset: 0xd21
// Size: 0x232
function function_691023c6e407d0bd()
{
    level.var_9d5e6c6a6ded4a2c = utility::getstructarray( "dh_1" );
    level.var_9d5e6f6a6ded50c5 = utility::getstructarray( "dh_2" );
    level.var_9d5e6e6a6ded4e92 = utility::getstructarray( "dh_3" );
    level.var_9d5e696a6ded4393 = utility::getstructarray( "dh_4" );
    a_numbers = arrayrandomize( [ 1, 2, 3, 4 ] );
    level.var_9d5e6c6a6ded4a2c[ level.var_9d5e6c6a6ded4a2c.size ] = a_numbers[ 0 ];
    level.var_9d5e6f6a6ded50c5[ level.var_9d5e6f6a6ded50c5.size ] = a_numbers[ 1 ];
    level.var_9d5e6e6a6ded4e92[ level.var_9d5e6e6a6ded4e92.size ] = a_numbers[ 2 ];
    level.var_9d5e696a6ded4393[ level.var_9d5e696a6ded4393.size ] = a_numbers[ 3 ];
    
    for ( i = 0; i < level.var_9d5e6c6a6ded4a2c[ 4 ] ; i++ )
    {
        utility::spawn_model( "t10_decor_deer_skull_01", level.var_9d5e6c6a6ded4a2c[ i ].origin, level.var_9d5e6c6a6ded4a2c[ i ].angles );
    }
    
    for ( i = 0; i < level.var_9d5e6f6a6ded50c5[ 4 ] ; i++ )
    {
        utility::spawn_model( "t10_decor_deer_skull_01", level.var_9d5e6f6a6ded50c5[ i ].origin, level.var_9d5e6f6a6ded50c5[ i ].angles );
    }
    
    for ( i = 0; i < level.var_9d5e6e6a6ded4e92[ 4 ] ; i++ )
    {
        utility::spawn_model( "t10_decor_deer_skull_01", level.var_9d5e6e6a6ded4e92[ i ].origin, level.var_9d5e6e6a6ded4e92[ i ].angles );
    }
    
    for ( i = 0; i < level.var_9d5e696a6ded4393[ 4 ] ; i++ )
    {
        utility::spawn_model( "t10_decor_deer_skull_01", level.var_9d5e696a6ded4393[ i ].origin, level.var_9d5e696a6ded4393[ i ].angles );
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x9d193736, Offset: 0xf5b
// Size: 0xa0
function function_5aea60ff18d0f508( params )
{
    round_number = params.roundnumber;
    
    if ( round_number >= 40 && level.zm_relic_tier >= 1 && !level utility::flag( "round_40_triggered" ) && !level.var_2d551b2a23bf56fb )
    {
        level utility::flag_set( "round_40_triggered" );
        function_9c595ed2d99d1855();
    }
    
    if ( round_number >= 60 && level.zm_relic_tier >= 2 )
    {
        function_e79f0c1a2068c143();
        level callback::remove( "on_round_start", &function_5aea60ff18d0f508 );
        return;
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x6898e186, Offset: 0x1003
// Size: 0xe2
function function_1ddd99ce98d6dab8( params )
{
    relic_challenge_type = params.relic_challenge_type;
    level utility::flag_clear( "relic_challenge_active" );
    
    switch ( relic_challenge_type )
    {
        case %"hash_539fc82cb7248b92":
            level utility::flag_clear( "gp_already_spawned" );
            break;
        case %"hash_7be57b8d6e0798e1":
            level utility::flag_clear( "gp_already_spawned" );
            break;
        case %"hash_706a1b2d98067f67":
            level utility::flag_clear( "yp_already_spawned" );
            break;
        case %"hash_264618d7bc91d4d2":
            level utility::flag_clear( "yp_already_spawned" );
            break;
        case %"hash_3994b3eb24ea7a7d":
            level utility::flag_clear( "rp_already_spawned" );
            break;
        case %"hash_123e7ddc71d8e14f":
            level utility::flag_clear( "rp_already_spawned" );
            break;
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x56b0a78d, Offset: 0x10ed
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

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x1cf122d9, Offset: 0x1180
// Size: 0x1af
function function_487f9e5930842a56()
{
    level.peeks_wallbuy_weapons = [];
    level callback::add( "wallbuy_purchase", &wallbuy_purchase_check );
    level callback::add( "zm_packed_weapon", &function_2d1d8ab6add359e6 );
    spawn_mag();
    function_691023c6e407d0bd();
    hide_1 = utility::spawn_model( "sat_zm_locust_animal_fur_01", utility::getstruct( "dh_gh_1" ).origin, utility::getstruct( "dh_gh_1" ).angles );
    hide_2 = utility::spawn_model( "sat_zm_locust_animal_fur_01", utility::getstruct( "dh_gh_2" ).origin, utility::getstruct( "dh_gh_2" ).angles );
    hide_3 = utility::spawn_model( "sat_zm_locust_animal_fur_01", utility::getstruct( "dh_gh_3" ).origin, utility::getstruct( "dh_gh_3" ).angles );
    hide_4 = utility::spawn_model( "sat_zm_locust_animal_fur_01", utility::getstruct( "dh_gh_4" ).origin, utility::getstruct( "dh_gh_4" ).angles );
    hide_1 thread damage_watcher( level.var_9d5e6f6a6ded50c5[ 4 ], "hide_1_hit" );
    hide_2 thread damage_watcher( level.var_9d5e6c6a6ded4a2c[ 4 ], "hide_2_hit" );
    hide_3 thread damage_watcher( level.var_9d5e6e6a6ded4e92[ 4 ], "hide_3_hit" );
    hide_4 thread damage_watcher( level.var_9d5e696a6ded4393[ 4 ], "hide_4_hit" );
    level.hides_hit = 1;
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0xed2e2c1c, Offset: 0x1337
// Size: 0x10
function function_463fd72850c2f91b()
{
    cooking_setup();
    function_60e1f47706b67c9();
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x187b89cd, Offset: 0x134f
// Size: 0x9
function function_162ad694402905d0()
{
    function_953ad4ae3db80899();
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x5e3e50e7, Offset: 0x1360
// Size: 0x9
function function_9c595ed2d99d1855()
{
    function_272a3fd53805d845();
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x4a8327de, Offset: 0x1371
// Size: 0x14
function function_e79f0c1a2068c143()
{
    level callback::add( "zone_changed", &function_c456c4c9e25ff79d );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0xfdae24f8, Offset: 0x138d
// Size: 0x65
function spawn_mag()
{
    level.peeks_mag = utility::spawn_model( %"prop_sat_dm_solomon_peeks_mag", ( 7049.38, 1230.4, 1603.41 ), ( 0.0896118, 26.5993, 90.8209 ) );
    level.peeks_mag_interact = zm_quest::function_91f9590e98d57ff6( level.peeks_mag.origin, &mag_pickedup, &mag_hint, "small" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 2
// Checksum 0xc22d9dc9, Offset: 0x13fa
// Size: 0x36
function mag_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xf4e446fb, Offset: 0x1439
// Size: 0x117
function mag_pickedup( player )
{
    level endon( #"game_ended" );
    level.peeks_mag delete();
    level.peeks_mag_interact freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level utility::flag_set( "peeks_mag_picked_up" );
    level callback::add( "on_zombie_ai_killed", &function_c75abda0166d9fb6 );
    level.zeus_kill_count = 0;
    level.condor_kill_count = 0;
    level.eagle_kill_count = 0;
    level.falcon_kill_count = 0;
    level.vulture_kill_count = 0;
    level.kite_kill_count = 0;
    level.kara_kill_count = 0;
    level.oman_kill_count = 0;
    level.scotia_kill_count = 0;
    level.atlas_kill_count = 0;
    level.husky_kill_count = 0;
    level.corso_kill_count = 0;
    level.cobra_kill_count = 0;
    level.otter_kill_count = 0;
    level.zebra_kill_count = 0;
    level.caspian_kill_count = 0;
    level.drake_kill_count = 0;
    level.var_beccde34f1d389a9 = 0;
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xc48e7969, Offset: 0x1558
// Size: 0x92
function wallbuy_purchase_check( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isweapon( params.objweapon ) )
    {
        level.peeks_wallbuy_weapons[ level.peeks_wallbuy_weapons.size ] = params.objweapon;
        
        if ( params.objweapon.hasalternate )
        {
            altweapon = params.objweapon getaltweapon();
            level.peeks_wallbuy_weapons[ level.peeks_wallbuy_weapons.size ] = altweapon;
        }
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x2206673c, Offset: 0x15f2
// Size: 0x14b
function function_2d1d8ab6add359e6( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    newalt = params.var_101633ed971732ba getaltweapon();
    oldweapon = params.var_39044599845b54cf;
    var_7bdf08af13d4f1a9 = params.var_101633ed971732ba;
    var_da9895ad63747df9 = params.var_39044599845b54cf getaltweapon();
    self.var_b728f74baa7e0b47 = 1;
    
    if ( isdefined( oldweapon ) )
    {
        if ( isdefined( var_7bdf08af13d4f1a9 ) )
        {
            params.objweapon = var_7bdf08af13d4f1a9;
            
            if ( arraycontains( level.peeks_wallbuy_weapons, params.var_39044599845b54cf ) || arraycontains( level.peeks_wallbuy_weapons, var_da9895ad63747df9 ) )
            {
                level.peeks_wallbuy_weapons[ level.peeks_wallbuy_weapons.size ] = params.objweapon;
                return;
            }
        }
        
        if ( isdefined( newalt ) )
        {
            params.objweapon = newalt;
            
            if ( arraycontains( level.peeks_wallbuy_weapons, params.var_39044599845b54cf ) || arraycontains( level.peeks_wallbuy_weapons, var_da9895ad63747df9 ) )
            {
                level.var_78b06bc85775ee0[ level.var_78b06bc85775ee0.size ] = params.objweapon;
                return;
            }
        }
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x8ea7004c, Offset: 0x1745
// Size: 0x4f5
function function_c75abda0166d9fb6( params )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( arraycontains( level.peeks_wallbuy_weapons, params.objweapon ) )
        {
            switch ( params.objweapon.basename )
            {
                case #"hash_a8732e71577dba8f":
                    if ( level.zeus_kill_count < 50 )
                    {
                        level.zeus_kill_count++;
                        
                        if ( level.zeus_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_d0faed243bf185b7":
                    if ( level.condor_kill_count < 50 )
                    {
                        level.condor_kill_count++;
                        
                        if ( level.condor_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_e46df264972befb0":
                    if ( level.eagle_kill_count < 50 )
                    {
                        level.eagle_kill_count++;
                        
                        if ( level.eagle_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_147fbfa420fffdf7":
                    if ( level.falcon_kill_count < 50 )
                    {
                        level.falcon_kill_count++;
                        
                        if ( level.falcon_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_a77bfda2108d3a5":
                    if ( level.kite_kill_count < 50 )
                    {
                        level.kite_kill_count++;
                        
                        if ( level.kite_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_d2e208af1049b83b":
                    if ( level.vulture_kill_count < 50 )
                    {
                        level.vulture_kill_count++;
                        
                        if ( level.vulture_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_4aa9cc5005d6af5f":
                    if ( level.kara_kill_count < 50 )
                    {
                        level.kara_kill_count++;
                        
                        if ( level.kara_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_29de240aad1ece69":
                    if ( level.oman_kill_count < 50 )
                    {
                        level.oman_kill_count++;
                        
                        if ( level.oman_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_22ac67dc9e7defc9":
                    if ( level.scotia_kill_count < 50 )
                    {
                        level.scotia_kill_count++;
                        
                        if ( level.scotia_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_6eb0b5dce242d11":
                    if ( level.atlas_kill_count < 50 )
                    {
                        level.atlas_kill_count++;
                        
                        if ( level.atlas_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_996300eec1031ce0":
                    if ( level.husky_kill_count < 50 )
                    {
                        level.husky_kill_count++;
                        
                        if ( level.husky_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_1e08728921d03416":
                    if ( level.corso_kill_count < 50 )
                    {
                        level.corso_kill_count++;
                        
                        if ( level.corso_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_c0d081fecac3ad43":
                    if ( level.otter_kill_count < 50 )
                    {
                        level.otter_kill_count++;
                        
                        if ( level.otter_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_204f8d47ab7c6dde":
                    if ( level.cobra_kill_count < 50 )
                    {
                        level.cobra_kill_count++;
                        
                        if ( level.cobra_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_47ff7b6685837679":
                    if ( level.zebra_kill_count < 50 )
                    {
                        level.zebra_kill_count++;
                        
                        if ( level.zebra_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_6601abb79140f145":
                    if ( level.caspian_kill_count < 50 )
                    {
                        level.caspian_kill_count++;
                        
                        if ( level.caspian_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                case #"hash_27128cdb5424cf31":
                    if ( level.drake_kill_count < 50 )
                    {
                        level.drake_kill_count++;
                        
                        if ( level.drake_kill_count >= 50 )
                        {
                            iprintlnbold( "Weapon has reached the required kills!" );
                        }
                    }
                    
                    break;
                default:
                    break;
            }
        }
        
        if ( params.objweapon.basename == "sat_ww_locust_zm" && level.var_beccde34f1d389a9 < 50 )
        {
            level.var_beccde34f1d389a9++;
        }
    }
    
    function_c32132bdfb3b2977();
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0xbd0ede20, Offset: 0x1c42
// Size: 0x17c
function function_c32132bdfb3b2977()
{
    if ( level.zeus_kill_count >= 50 && level.condor_kill_count >= 50 && level.eagle_kill_count >= 50 && level.falcon_kill_count >= 50 && level.kite_kill_count >= 50 && level.kara_kill_count >= 50 && level.oman_kill_count >= 50 && level.scotia_kill_count >= 50 && level.atlas_kill_count >= 50 && level.corso_kill_count >= 50 && level.otter_kill_count >= 50 && level.zebra_kill_count >= 50 && level.caspian_kill_count >= 50 && level.cobra_kill_count >= 50 && level.vulture_kill_count >= 50 && level.var_beccde34f1d389a9 >= 50 && level.husky_kill_count >= 50 && level.drake_kill_count >= 50 && !level utility::flag( "wallbuy_challenge_completed" ) )
    {
        level utility::flag_set( "wallbuy_challenge_completed" );
        level callback::remove( "wallbuy_purchase", &wallbuy_purchase_check );
        level callback::remove( "zm_packed_weapon", &function_2d1d8ab6add359e6 );
        level callback::remove( "on_zombie_ai_killed", &function_c75abda0166d9fb6 );
        function_5dbe610b6774ceff();
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x84d9225f, Offset: 0x1dc6
// Size: 0x7b
function function_5dbe610b6774ceff()
{
    level thread relic_challenge_unlocked();
    var_2153e39e051f5b91 = %"hash_7be57b8d6e0798e1";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::portal_spawn( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
    level utility::flag_set( "gp_already_spawned" );
    level utility::flag_set( "belt_portal_spawned" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 2
// Checksum 0x14aafec6, Offset: 0x1e49
// Size: 0x1e5
function damage_watcher( number, flag )
{
    self endon( #"death" );
    level endon( #"power_switch_portal_spawned" );
    val::set( "hide", "damage", 1 );
    self.health = 99999;
    
    while ( true )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( eattacker ) )
        {
            if ( smeansofdeath == "MOD_IMPACT" )
            {
                if ( level.hides_hit == number && objweapon.basename == "sat_combataxe_zm" && !level utility::flag( flag ) )
                {
                    level utility::flag_set( flag );
                    level.hides_hit++;
                    iprintlnbold( "CORRECT HIDE" );
                    
                    if ( level.hides_hit >= 5 )
                    {
                        iprintlnbold( "HIDES COMPLETE" );
                        function_4a8d3b13cde785fb();
                    }
                }
                else if ( level.hides_hit != number )
                {
                    iprintlnbold( "FAILURE: TRY AGAIN" );
                    level.hides_hit = 1;
                    level utility::flag_clear( "hide_1_hit" );
                    level utility::flag_clear( "hide_2_hit" );
                    level utility::flag_clear( "hide_3_hit" );
                    level utility::flag_clear( "hide_4_hit" );
                }
            }
        }
        
        self.health += damage;
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x7ea18811, Offset: 0x2036
// Size: 0x87
function function_4a8d3b13cde785fb()
{
    level thread relic_challenge_unlocked();
    var_2153e39e051f5b91 = %"hash_539fc82cb7248b92";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::portal_spawn( "easy" + "_" + index, level.green_portals[ index ], var_2153e39e051f5b91 );
    level utility::flag_set( "gp_already_spawned" );
    level utility::flag_set( "power_switch_portal_spawned" );
    level notify( #"power_switch_portal_spawned" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x1e76da69, Offset: 0x20c5
// Size: 0x32
function function_ca8cbd726ee395f3( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.var_ffc1674def575bfa ) )
    {
        return;
    }
    
    level.var_1241723eaf9538b = 1;
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x26058aa, Offset: 0x20ff
// Size: 0x32
function function_e6744befac2e84ea( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.perkref ) )
    {
        return;
    }
    
    level.var_1241723eaf9538b = 1;
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x586b15a4, Offset: 0x2139
// Size: 0x3b
function function_60e1f47706b67c9()
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        if ( level.var_1241723eaf9538b )
        {
            level callback::remove( "zm_perk_purchased", &function_e6744befac2e84ea );
            level callback::remove( "zm_perk_obtained", &function_ca8cbd726ee395f3 );
        }
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0xf43bedb8, Offset: 0x217c
// Size: 0xa1
function function_272a3fd53805d845()
{
    if ( !level.var_1241723eaf9538b && !level.var_2d551b2a23bf56fb )
    {
        level thread relic_challenge_unlocked();
        var_2153e39e051f5b91 = %"hash_706a1b2d98067f67";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
        level utility::flag_set( "yp_already_spawned" );
        level utility::flag_set( "elephant_portal_spawned" );
        level.var_2d551b2a23bf56fb = 1;
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0xe1249a62, Offset: 0x2225
// Size: 0x61
function cooking_setup()
{
    level.peek_pot = utility::spawn_model( "zm_sat_c_kp", ( 5079.05, 5813.79, 223.601 ), ( 0, 30.5997, 0 ) );
    level.var_c3ffddb145b561e8 = zm_quest::function_91f9590e98d57ff6( level.peek_pot.origin, &pot_pickedup, &hidden_hint, "extrasmallnohint" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x95a679e9, Offset: 0x228e
// Size: 0x7c
function pot_pickedup( player )
{
    level endon( #"game_ended" );
    level.peek_pot delete();
    level.var_c3ffddb145b561e8 freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level.var_93ca37b3af2a0810 = zm_quest::function_91f9590e98d57ff6( ( 4841.15, 3927.39, 176.71 ), &pot_placed, &hidden_hint, "small" );
    level utility::flag_set( "peek_pot_picked_up" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x785e9263, Offset: 0x2312
// Size: 0xf1
function pot_placed( player )
{
    level endon( #"game_ended" );
    level.var_93ca37b3af2a0810 freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level.var_4d7338dd1052341e = spawnscriptable( "zm_sat_c_cs", ( 4841.15, 3927.39, 176.71 ), ( 0, 30.5997, 0 ) );
    level.var_4641470c66a7e295 = zm_quest::function_91f9590e98d57ff6( ( 4841.15, 3927.39, 176.71 ), &function_474b26c02137f5e0, &hidden_hint, "small" );
    level.beer = spawnscriptable( "zm_sat_bm_cr", ( 2430.89, 3209.01, 102.757 ), ( 0, 53, 0 ) );
    level.beer_interact = zm_quest::function_91f9590e98d57ff6( ( 2430.89, 3209.01, 102.757 ), &beer_collect, &hidden_hint, "small" );
    level utility::flag_set( "peek_pot_picked_up" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xe05c49d5, Offset: 0x240b
// Size: 0x51
function beer_collect( player )
{
    level endon( #"game_ended" );
    level.beer freescriptable();
    level.beer_interact freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level utility::flag_set( "beer_collected" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xff0facf4, Offset: 0x2464
// Size: 0x25f
function function_474b26c02137f5e0( player )
{
    if ( level utility::flag( "beer_collected" ) && !level utility::flag( "beer_added" ) )
    {
        level utility::flag_set( "beer_added" );
        level.var_4d7338dd1052341e setscriptablepartstate( "reaction", "splash" );
        level.var_4d7338dd1052341e setscriptablepartstate( "vfx", "start" );
        return;
    }
    
    if ( level utility::flag( "ww_burgess_step_02" ) && !level utility::flag( "seal_added" ) && level utility::flag( "beer_added" ) && !level utility::flag( "b_used_block" ) )
    {
        level utility::flag_set( "seal_added" );
        level utility::flag_set( "ww_quest_block_cr" );
        zm_quest::function_b57dfe9625966b0b( #"hash_709d77ab2b2005c5", 0, #"Bait", 0 );
        level thread function_5a3872c290cf4af7();
        level.var_4d7338dd1052341e setscriptablepartstate( "reaction", "splash" );
    }
    
    if ( level utility::flag( "seal_added" ) && level utility::flag( "beer_added" ) && !level utility::flag( "cooking_stage_2" ) )
    {
        level utility::flag_set( "cooking_stage_2" );
        level callback::add( "on_zombie_ai_killed", &function_e7019fbedb234e40 );
        return;
    }
    
    if ( level utility::flag( "lobster_tail_picked_up" ) && !level utility::flag( "tail_added" ) )
    {
        level utility::flag_set( "tail_added" );
        level.var_4d7338dd1052341e setscriptablepartstate( "reaction", "splash" );
        level utility::flag_set( "cooking_near_complete" );
        level callback::add( "fergus_general_catch_success", &successful_catch );
        return;
    }
    
    if ( level utility::flag( "fish_spawned" ) && !level utility::flag( "fish_added" ) )
    {
        level utility::flag_set( "fish_added" );
        level.var_4d7338dd1052341e setscriptablepartstate( "reaction", "splash" );
        level utility::flag_set( "cooking_complete" );
        level callback::add( "on_zombie_ai_killed", &function_b731e9c9e412b576 );
        level.cooking_peek = spawnscriptable( "zm_sat_mrp_ck", ( 4841.15, 3927.39, 176.71 ) + ( 0, 0, 7 ) );
        level.var_2bedc05a158adb7f = 0;
        level.var_4641470c66a7e295 freescriptable();
        return;
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xf8449b39, Offset: 0x26cb
// Size: 0x15d
function function_b731e9c9e412b576( params )
{
    level endon( #"game_ended" );
    var_251f4e1af05f5cd3 = zone_manager::get_current_zone();
    
    if ( isplayer( params.eattacker ) || isplayer( params.eattacker.owner ) )
    {
        if ( var_251f4e1af05f5cd3.script_zone_name == "zone_downtown_meadhall" && params.objweapon.basename == "sat_ww_locust_zm" )
        {
            level.var_2bedc05a158adb7f++;
            utility::function_24215250530eaebc( self getcentroid(), ( 4841.15, 3927.39, 176.71 ), level._effect[ #"zombie_trail" ], level._effect[ #"zombie_impact" ] );
        }
        
        if ( level.var_2bedc05a158adb7f >= 50 && !level utility::flag( "cooking_finished" ) )
        {
            level utility::flag_set( "cooking_finished" );
            level callback::remove( "on_zombie_ai_killed", &function_b731e9c9e412b576 );
            level.cooking_peek setscriptablepartstate( "visual", "exit" );
            level thread function_3968cd5b3c0a8e99();
            wait 1;
            level.cooking_peek setscriptablepartstate( "visual", "off" );
            level.cooking_peek freescriptable();
        }
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x93e1b74, Offset: 0x2830
// Size: 0x29
function function_5a3872c290cf4af7()
{
    level.truck_trigger = getent( "tdt_sc", "targetname" );
    level.truck_trigger thread truck_damage();
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x6b48384e, Offset: 0x2861
// Size: 0x1e1
function truck_damage()
{
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( eattacker ) )
        {
            if ( smeansofdeath == "MOD_EXPLOSION" || smeansofdeath == "MOD_GRENADE_SPLASH" && !level utility::flag( "ww_meat_spawned" ) )
            {
                level utility::flag_set( "ww_meat_spawned" );
                level.var_57129e676401b3ff = utility::spawn_model( %"sat_locust_zm_chester_01", ( 1290.59, 7596.61, 569.458 ) );
                level.var_57129e676401b3ff hudoutlineenable( "outline_depth_orange" );
                playfxontag( level._effect[ #"zombie_trail" ], level.var_57129e676401b3ff, "tag_origin" );
                level.var_57129e676401b3ff utility::function_8001268940441423( level.var_57129e676401b3ff.origin, ( 1152.03, 7712.53, 490.735 ), ( 1182.15, 7644.64, 562.408 ), 0.5, undefined, 1 );
                stopfxontag( level._effect[ #"zombie_trail" ], level.var_57129e676401b3ff, "tag_origin" );
                zm_quest::function_91f9590e98d57ff6( level.var_57129e676401b3ff.origin, &can_pickedup, &hidden_hint, "small" );
            }
        }
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xcd01fa58, Offset: 0x2a4a
// Size: 0x64
function can_pickedup( player )
{
    self freescriptable();
    
    if ( isdefined( level.var_57129e676401b3ff ) )
    {
        level.var_57129e676401b3ff delete();
    }
    
    level.truck_trigger delete();
    zm_quest::function_b57dfe9625966b0b( #"hash_709d77ab2b2005c5", 0, #"Bait", 1 );
    level utility::flag_clear( "ww_quest_block_cr" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xc212da04, Offset: 0x2ab6
// Size: 0x202
function successful_catch( params )
{
    round_number = zm_round_logic::get_rb_round_number();
    special_round = zm_round_spawning::is_special_round( round_number );
    var_c23a8cb334b43f16 = params.fishing_hole.scriptable.loot_spawn_loc.origin;
    mid_point = params.fishing_hole.scriptable.loot_spawn_loc.origin + ( 0, 150, 200 );
    ground_pos = utility::drop_to_ground( var_c23a8cb334b43f16, 10 );
    
    if ( round_number >= 35 && special_round && params.fishing_hole.groupid == "fishing_spot_3" && !level utility::flag( "fish_spawned" ) )
    {
        level utility::flag_set( "fish_spawned" );
        level callback::remove( "fergus_general_catch_success", &successful_catch );
        level.fish = utility::spawn_model( "vfx_animals_fish_med_school_disperse", var_c23a8cb334b43f16 );
        level.fish hudoutlineenable( "outline_depth_orange" );
        playfxontag( level._effect[ #"zombie_trail" ], level.fish, "tag_origin" );
        level.fish utility::function_8001268940441423( params.fishing_hole.origin, ground_pos + ( 0, 10, 0 ), mid_point, 1.5, undefined, 1 );
        stopfxontag( level._effect[ #"zombie_trail" ], level.fish, "tag_origin" );
        zm_quest::function_91f9590e98d57ff6( level.fish.origin, &fish_pickedup, &hidden_hint, "small" );
        level thread object_cleanup( level.fish );
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x3e01b04, Offset: 0x2cc0
// Size: 0xdf
function function_e7019fbedb234e40( params )
{
    if ( isstartstr( self.subclass, "zombie_karkinos" ) && params.einflictor.var_fcda7168a743663a == "fire_trap_switch" )
    {
        ground_pos = utility::drop_to_ground( self.origin, 10 );
        level.lob_tail = utility::spawn_model( "t10_food_lobster_01", ground_pos );
        level.lob_tail hudoutlineenable( "outline_depth_orange" );
        zm_quest::function_91f9590e98d57ff6( level.lob_tail.origin, &function_96c7b029a8a5c0ea, &hidden_hint, "small" );
        level utility::flag_set( "lobster_tail_spawned" );
        level thread object_cleanup( level.lob_tail );
        level callback::remove( "on_zombie_ai_killed", &function_e7019fbedb234e40 );
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xfa30cbe, Offset: 0x2da7
// Size: 0x3a
function fish_pickedup( player )
{
    self freescriptable();
    
    if ( isdefined( level.fish ) )
    {
        level.fish delete();
    }
    
    level utility::flag_set( "fish_picked_up" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xd8961e85, Offset: 0x2de9
// Size: 0x2d
function function_96c7b029a8a5c0ea( player )
{
    self freescriptable();
    level.lob_tail delete();
    level utility::flag_set( "lobster_tail_picked_up" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xfc3b4c5, Offset: 0x2e1e
// Size: 0x71
function object_cleanup( item )
{
    level endon( #"game_ended" );
    wait 90;
    
    if ( isdefined( item ) && !level utility::flag( "lobster_tail_picked_up" ) )
    {
        level utility::flag_clear( "lobster_tail_spawned" );
        item delete();
    }
    
    if ( isdefined( item ) && !level utility::flag( "fish_picked_up" ) )
    {
        level utility::flag_clear( "fish_spawned" );
        item delete();
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0xf0883c62, Offset: 0x2e97
// Size: 0x7b
function function_3968cd5b3c0a8e99()
{
    level thread relic_challenge_unlocked();
    var_2153e39e051f5b91 = %"hash_264618d7bc91d4d2";
    index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
    namespace_a6c33b614364964::portal_spawn( "medium" + "_" + index, level.yellow_portals[ index ], var_2153e39e051f5b91 );
    level utility::flag_set( "yp_already_spawned" );
    level utility::flag_set( "cooking_portal_spawned" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xe0e34997, Offset: 0x2f1a
// Size: 0xbd
function function_c456c4c9e25ff79d( params )
{
    if ( params.zone_struct.zone_name == "zone_robot_head" && !utility::ent_flag( "player_in_head" ) )
    {
        utility::ent_flag_set( "player_in_head" );
        
        if ( !level callback::exists( "on_zombie_ai_killed", &function_39ba99f1e76a9ef6 ) )
        {
            level callback::add( "on_zombie_ai_killed", &function_39ba99f1e76a9ef6 );
        }
        
        self.var_3d6e5b2ed54269b1 = 0;
        return;
    }
    
    if ( params.zone_struct.zone_name != "zone_robot_head" && utility::ent_flag( "player_in_head" ) )
    {
        utility::ent_flag_clear( "player_in_head" );
        self.var_3d6e5b2ed54269b1 = 0;
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xe0ea6e4d, Offset: 0x2fdf
// Size: 0xcb
function function_39ba99f1e76a9ef6( params )
{
    if ( isplayer( params.eattacker ) && self.last_dmg_struct.biscritical && params.eattacker utility::ent_flag( "player_in_head" ) )
    {
        params.eattacker.var_3d6e5b2ed54269b1++;
        iprintlnbold( "Critical kills in head: " + params.eattacker.var_3d6e5b2ed54269b1 );
        
        if ( params.eattacker.var_3d6e5b2ed54269b1 >= 5 )
        {
            level callback::remove( "zone_changed", &function_c456c4c9e25ff79d );
            level callback::remove( "on_zombie_ai_killed", &function_39ba99f1e76a9ef6 );
            music_box_complete();
        }
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x629884eb, Offset: 0x30b2
// Size: 0x8b
function music_box_complete()
{
    if ( !level utility::flag( "music_box_portal_spawned" ) )
    {
        level thread relic_challenge_unlocked();
        var_2153e39e051f5b91 = %"hash_123e7ddc71d8e14f";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
        level utility::flag_set( "rp_already_spawned" );
        level utility::flag_set( "music_box_portal_spawned" );
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x6f3cbe37, Offset: 0x3145
// Size: 0x15f
function function_953ad4ae3db80899()
{
    level.motel_peeks = spawn( "script_model", ( 7062.78, 9711.88, 671.34 ) );
    level.motel_peeks.angles = ( 358.701, 149.145, 2.40049 );
    level.motel_peeks setscale( 0.75 );
    level.motel_peeks setmodel( "wm_ob_mrp" );
    level.var_1eee6272f7e64f4b = zm_quest::function_91f9590e98d57ff6( level.motel_peeks.origin, &function_602e0fe52e834320, &hidden_hint, "small" );
    level.var_b24138012ff2c852 = utility::spawn_model( %"zm_sat_r_prop", ( 1244.68, 5922.94, 67.867 ), ( 0.272183, 220.296, -90.6443 ) );
    level.var_eedaed3d09e8e235 = zm_quest::function_91f9590e98d57ff6( level.var_b24138012ff2c852.origin, &radio_pickedup, &hidden_hint, "small" );
    level.var_501cb3cb5069f3f0 = utility::spawn_model( %"zm_sat_h_prop", ( 6470.2, 9624.98, 694.289 ), ( 0, 0, 0 ) );
    level.var_9a563f92fe3795f = zm_quest::function_91f9590e98d57ff6( level.var_501cb3cb5069f3f0.origin, &helmet_pickedup, &hidden_hint, "small" );
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 2
// Checksum 0xc6ed15d3, Offset: 0x32ac
// Size: 0x36
function hidden_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x2f3c4064, Offset: 0x32eb
// Size: 0x58
function function_602e0fe52e834320( player )
{
    level endon( #"game_ended" );
    level.motel_peeks delete();
    level.var_1eee6272f7e64f4b freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level utility::flag_set( "motel_peeks_picked_up" );
    function_54ef1302320ef7a8();
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0xa92a1d03, Offset: 0x334b
// Size: 0x58
function radio_pickedup( player )
{
    level endon( #"game_ended" );
    level.var_b24138012ff2c852 delete();
    level.var_eedaed3d09e8e235 freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level utility::flag_set( "radio_cr_picked_up" );
    function_54ef1302320ef7a8();
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x6d35b8c6, Offset: 0x33ab
// Size: 0x58
function helmet_pickedup( player )
{
    level endon( #"game_ended" );
    level.var_501cb3cb5069f3f0 delete();
    level.var_9a563f92fe3795f freescriptable();
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level utility::flag_set( "helmet_cr_picked_up" );
    function_54ef1302320ef7a8();
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x7ef9cb7c, Offset: 0x340b
// Size: 0x5c
function function_54ef1302320ef7a8()
{
    if ( level utility::flag( "motel_peeks_picked_up" ) && level utility::flag( "radio_cr_picked_up" ) && level utility::flag( "helmet_cr_picked_up" ) )
    {
        level.var_ec8dbccc455b3762 = zm_quest::function_91f9590e98d57ff6( ( 7388.09, 10293.9, 691.476 ), &function_b7f8e7a3826eb037, &hidden_hint, "small" );
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 1
// Checksum 0x9b7b5302, Offset: 0x346f
// Size: 0x11b
function function_b7f8e7a3826eb037( player )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "rr_scene_complete" ) )
    {
        level.var_ec8dbccc455b3762 freescriptable();
        peeks = spawn( "script_model", ( 7388.09, 10293.9, 691.476 ) );
        peeks.angles = ( 9.19203, 180.253, 2.1211 );
        peeks setscale( 1.5 );
        peeks setmodel( "wm_ob_mrp" );
        utility::spawn_model( %"zm_sat_r_prop", ( 7380.77, 10293.7, 691.643 ), ( 13.174, 202.732, -38.4572 ) );
        helmet = spawn( "script_model", ( 7385.88, 10294, 710.106 ) );
        helmet.angles = ( 359.237, 282.786, -24.5999 );
        helmet setscale( 1.75 );
        helmet setmodel( %"zm_sat_h_prop" );
        level utility::flag_set( "throne_peeks_placed" );
        function_c6189cc49267b10d();
    }
}

// Namespace namespace_2f1b7b33eb8edd8b
// Params 0
// Checksum 0x22167e8a, Offset: 0x3592
// Size: 0x8a
function function_c6189cc49267b10d()
{
    if ( level utility::flag( "throne_peeks_placed" ) )
    {
        level thread relic_challenge_unlocked();
        var_2153e39e051f5b91 = %"hash_3994b3eb24ea7a7d";
        index = level.zm_relics[ var_2153e39e051f5b91 ].portalindex;
        namespace_a6c33b614364964::portal_spawn( "hard" + "_" + index, level.red_portals[ index ], var_2153e39e051f5b91 );
        level utility::flag_set( "rp_already_spawned" );
        level utility::flag_set( "agarthan_device_portal_spawned" );
    }
}

/#

    // Namespace namespace_2f1b7b33eb8edd8b
    // Params 0, eflags: 0x4
    // Checksum 0xe27d255c, Offset: 0x3624
    // Size: 0x5a, Type: dev
    function private init_relic_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x33>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x53>", &debug_spawn_pot );
        devgui::add_devgui_func( "<dev string:x5d>", "<dev string:x7d>", &debug_spawn_effects );
        devgui::add_devgui_func( "<dev string:x93>", "<dev string:xb3>", &debug_spawn_splash );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_2f1b7b33eb8edd8b
    // Params 0
    // Checksum 0x2d1113e1, Offset: 0x3686
    // Size: 0x4c, Type: dev
    function debug_spawn_pot()
    {
        if ( isdefined( level.var_4d7338dd1052341e ) )
        {
            level.var_4d7338dd1052341e freescriptable();
        }
        
        level.var_4d7338dd1052341e = spawnscriptable( "<dev string:xc0>", ( 4841.15, 3927.39, 176.71 ), ( 0, 30.5997, 0 ) );
    }

    // Namespace namespace_2f1b7b33eb8edd8b
    // Params 0
    // Checksum 0x11931253, Offset: 0x36da
    // Size: 0x55, Type: dev
    function debug_spawn_effects()
    {
        if ( !isdefined( level.var_4d7338dd1052341e ) )
        {
            level.var_4d7338dd1052341e = spawnscriptable( "<dev string:xc0>", ( 4841.15, 3927.39, 176.71 ), ( 0, 30.5997, 0 ) );
        }
        
        level.var_4d7338dd1052341e setscriptablepartstate( "<dev string:xcc>", "<dev string:xd0>" );
    }

    // Namespace namespace_2f1b7b33eb8edd8b
    // Params 0
    // Checksum 0xd78759f8, Offset: 0x3737
    // Size: 0x55, Type: dev
    function debug_spawn_splash()
    {
        if ( !isdefined( level.var_4d7338dd1052341e ) )
        {
            level.var_4d7338dd1052341e = spawnscriptable( "<dev string:xc0>", ( 4841.15, 3927.39, 176.71 ), ( 0, 30.5997, 0 ) );
        }
        
        level.var_4d7338dd1052341e setscriptablepartstate( "<dev string:xd6>", "<dev string:xdf>" );
    }

#/
