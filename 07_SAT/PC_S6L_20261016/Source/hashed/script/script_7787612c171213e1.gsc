// script_7787612c171213e1  (hash_7787612c171213e1.gscc) (size: 9792 Bytes / 0x2640 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x292228dd (690104541)
// size ...... 9792 (0x2640)
// includes .. 3   (offset: 0x2134)
// strings ... 56  (offset: 0x214c)
// dev strs .. 0   (offset: 0x2610)
// exports ... 15  (offset: 0x1af0)
// cseg ...... 0x507 + 0x15e9 (0x1af0)
// imports ... 28  (offset: 0x1d48)
// animtree1 . 0   (offset: 0x2610)
// animtree2 . 3   (offset: 0x2610)
#using script_4f7cbc7a2a2ba890;
#using script_7ee07206a83ca532;
#using scripts\mp\common\utility\benchmark_mp_utils;

#namespace namespace_5e1a0b922665681b;

#using_animtree( "script_model" );

// Namespace namespace_5e1a0b922665681b
// Params 0
// Checksum 0x83f35354, Offset: 0x525
// Size: 0x173
function start()
{
    level.var_7f0aa6db090b81f = ( 0, 0, -372 );
    level.fade_out_time = 2;
    level.glass_shoot_points = [ ( 1541, 900, 42 ), ( 1445, 900, 42 ), ( 1355, 900, 43 ), ( 897, 1193, 175 ), ( 897, 1193, 175 ) ];
    level.death_sounds = [ "generic_death_american_1", "generic_death_american_2", "generic_death_american_3", "generic_death_american_4", "generic_death_american_5", "generic_death_american_6", "generic_death_american_7", "generic_death_american_8" ];
    benchmark_level::start( &function_87748c7dd74b4a02, &setuptriggers, &function_73c514526480319d, &playerdamagemodifier, ( 711.779, 864.031, 38.58 ), ( 0, 0, 0 ), "vm_c_sat_usa_pl_red_proto", "sat_vm_pi_timir_benchmark", %sat_mp_vm_benchmark, %sat_mp_vm_benchmark_weapon, %sat_mp_flyby_benchmark, "body_c_sat_usa_pl_red_proto", "head_c_sat_usa_pl_red_proto", undefined, "body_c_sat_usa_pl_red_proto", "head_c_sat_usa_pl_red_proto", ( 855, 23, 1855 ), ( -64, -227, -67 ), "sat_pi_timir_mp", 1.5, undefined, undefined, "vfx_sat_core_weapons_muz_pi", "enemy_mp_benchmark_sat" );
}

// Namespace namespace_5e1a0b922665681b
// Params 0, eflags: 0x4
// Checksum 0x503545dc, Offset: 0x6a0
// Size: 0x4b
function private function_87748c7dd74b4a02()
{
    return [ benchmark_mp_utils::function_768d305ebadbe8fb( int( ceil( benchmark_level::function_c8ae0e55058400d6() ) ) ), benchmark_mp_utils::function_768d305ebadbe8fb( 12 ), benchmark_mp_utils::function_768d305ebadbe8fb( 13 ), benchmark_mp_utils::function_768d305ebadbe8fb( 12 ), benchmark_mp_utils::function_768d305ebadbe8fb( 17 ) ];
}

// Namespace namespace_5e1a0b922665681b
// Params 0, eflags: 0x4
// Checksum 0xb5c1d278, Offset: 0x6f4
// Size: 0x5c0
function private function_73c514526480319d()
{
    var_a24e09134b4e72 = [];
    var_a24e09134b4e72[ "enemy_group_0" ][ "enemy_0" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_0", ( -1088.23, 888.764, -20.057 ), ( 0, 53.9121, 0 ), 0, 0, "stand", 75 ), benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_0_0", ( -810, 1271, -20 ), ( 0, 53.9121, 0 ), 0, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_0" ][ "enemy_1" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_0", ( -637.648, 818.141, -19.2187 ), ( 0, -0.467263, 0 ), 1, 0, "stand", 100 ), benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_0_1", ( 402.144, 823.968, -20.0526 ), ( 0, -0.467263, 0 ), 1, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_1" ][ "enemy_1" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_1", ( -1941.97, 45.5705, 97.9774 ), ( 0, 71.492, 0 ), 0, 0, "stand", 200 ), benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_1_1", ( -1584.22, 746.766, -20 ), ( 0, 71.492, 0 ), 0, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_1" ][ "enemy_0" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_1", ( -1953.85, -56.4969, 97 ), ( 0, 79.674, 0 ), 0, 0, "stand", 180 ), benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_1_0", ( -1578.2, 822.501, -20 ), ( 0, 79.674, 0 ), 0, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_2" ][ "enemy_0" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_2", ( -2097, -484, 132 ), ( 0, 96.4986, 0 ), 0, 0, "stand", 300 ), benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_2_0", ( -1952.33, -0.525223, 97.2832 ), ( 0, 96.4986, 0 ), 0, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_2" ][ "enemy_1" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_2", ( -1555.97, -625.665, 97 ), ( 0, 98.4885, 0 ), 0, 0.5, "stand", 200 ), benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_2_1", ( -1861.34, -3.24588, 97 ), ( 0, 98.4885, 0 ), 0, 0.5, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_2" ][ "enemy_2" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_2", ( -1388, 513, 97 ), ( 0, -92.3749, 0 ), 0, 0, "stand", 150 ), benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_2_2", ( -1436, -27, 94 ), ( 0, -92.3749, 0 ), 0, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_4" ][ "enemy_0" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_4", ( -1465.58, -1770.5, 152 ), ( 0, 96.9185, 0 ), 0, 0, "stand", 100 ), benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_4_0", ( -1651.81, -902.077, 152.408 ), ( 0, 96.9185, 0 ), 0, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_4" ][ "enemy_1" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_4", ( -1278.12, -1729.63, 152 ), ( 0, 119.569, 0 ), 0, 0, "stand", 100 ), benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_4_1", ( -1606.36, -863.577, 152 ), ( 0, 119.569, 0 ), 0, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_3" ][ "enemy_0" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_3", ( 2189.24, 310.66, 16 ), ( 0, -88.0759, 0 ), 1, 0, "stand", 150 ), benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_3_0", ( 1660.74, -118.77, 26.2261 ), ( 0, -88.0759, 0 ), 1, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_3" ][ "enemy_1" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_3", ( 2039.58, 247.077, 16 ), ( 0, -94.1486, 0 ), 1, 0, "stand", 180 ), benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_3_1", ( 1617.09, -126.491, 17.0431 ), ( 0, -94.1486, 0 ), 1, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_3" ][ "enemy_2" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_3", ( 1610.4, 777.378, 17 ), ( 0, -79.7279, 0 ), 0, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_3" ][ "enemy_3" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_3", ( 2072.48, -306.413, 16 ), ( 0, 167.271, 0 ), 1, 0, "stand" ) ];
    var_a24e09134b4e72[ "enemy_group_3" ][ "enemy_4" ] = [ benchmark_mp_utils::function_1d8f6f11879b79a5( "enemy_group_3", ( 1019.75, 1088.14, 131.646 ), ( 0, -36.3185, 0 ), 0, 0, "stand" ) ];
    benchmark_mp_utils::function_1d4329e5a1e40b20( var_a24e09134b4e72 );
}

// Namespace namespace_5e1a0b922665681b
// Params 1, eflags: 0x4
// Checksum 0x9b2ea4c1, Offset: 0xcbc
// Size: 0x29e
function private setuptriggers( player )
{
    benchmark_mp_utils::function_8550afed58d9513c( player, "VFX Sequence 2", ( -1193, -404, 100 ), 50, &benchmark_level::function_9055a9e9904536bc, undefined, 1, { #sequence_func:&function_3243aae994d5f056 } );
    benchmark_mp_utils::function_8550afed58d9513c( player, "VFX Sequence 3", ( -971.27, -202.465, 100 ), 50, &benchmark_level::function_9055a9e9904536bc, undefined, 1, { #sequence_func:&function_3243a9e994d5ee23 } );
    benchmark_mp_utils::function_8550afed58d9513c( player, "VFX Sequence 4", ( -748, -82, 100 ), 50, &benchmark_level::function_9055a9e9904536bc, undefined, 1, { #sequence_func:&function_3243a8e994d5ebf0 } );
    benchmark_mp_utils::function_8550afed58d9513c( player, "VFX Sequence 5", ( 237, -10, 92 ), 50, &benchmark_level::function_9055a9e9904536bc, undefined, 1, { #sequence_func:&function_3243afe994d5fb55 } );
    benchmark_mp_utils::function_8550afed58d9513c( player, "VFX Sequence 6", ( 1049.8, -132.888, 87 ), 50, &benchmark_level::function_9055a9e9904536bc, undefined, 1, { #sequence_func:&function_3243aee994d5f922 } );
    benchmark_mp_utils::function_8550afed58d9513c( player, "VFX Sequence 7", ( 1468.85, -123.375, 17.3557 ), 50, &benchmark_level::function_9055a9e9904536bc, undefined, 1, { #sequence_func:&function_3243ade994d5f6ef } );
    benchmark_mp_utils::function_8550afed58d9513c( player, "VFX Sequence 8", ( -204.638, 11.9742, 92 ), 50, &benchmark_level::function_9055a9e9904536bc, undefined, 1, { #sequence_func:&function_3243ace994d5f4bc } );
    benchmark_mp_utils::function_8550afed58d9513c( player, "nuke", ( 1649.47, 63.6494, 17.278 ), 50, &function_9d1a0da752f9d964 );
    benchmark_mp_utils::function_8550afed58d9513c( player, "enemy group 0", ( 139, 1122, -75 ), 50, &benchmark_level::function_7cdd735564992994, undefined, 1, { #agent_group_id:"enemy_group_0" } );
    benchmark_mp_utils::function_8550afed58d9513c( player, "enemy group 1", ( -1510, 871, -19 ), 50, &benchmark_level::function_7cdd735564992994, undefined, 1, { #agent_group_id:"enemy_group_1" } );
    benchmark_mp_utils::function_8550afed58d9513c( player, "enemy group 2", ( -1780, 427, -20 ), 50, &benchmark_level::function_7cdd735564992994, undefined, 1, { #agent_group_id:"enemy_group_2" } );
    benchmark_mp_utils::function_8550afed58d9513c( player, "enemy group 3", ( 1140, -126, 38 ), 50, &benchmark_level::function_7cdd735564992994, undefined, 1, { #agent_group_id:"enemy_group_3" } );
    benchmark_mp_utils::function_8550afed58d9513c( player, "enemy group 4", ( -1939, 126, 98 ), 50, &benchmark_level::function_7cdd735564992994, undefined, 1, { #agent_group_id:"enemy_group_4" } );
}

// Namespace namespace_5e1a0b922665681b
// Params 11, eflags: 0x4
// Checksum 0x6461ec8a, Offset: 0xf62
// Size: 0x67, Type: bool
function private playerdamagemodifier( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    return false;
}

// Namespace namespace_5e1a0b922665681b
// Params 1, eflags: 0x4
// Checksum 0x8cbd3cf4, Offset: 0xfd2
// Size: 0x75
function private function_9d1a0da752f9d964( player )
{
    player endon( #"disconnect" );
    nuke_explosionposition = ( -3989, 8243, 80 );
    benchmark_mp_utils::spawnnuke( player, player.origin + ( 0, 0, 900 ), nuke_explosionposition, 7 );
    
    if ( getdvarint( @"hash_5ea5d8814093afe7", 0 ) == 0 )
    {
        wait 13;
        benchmark_mp_utils::function_2544b8c262fb0f68();
    }
}

// Namespace namespace_5e1a0b922665681b
// Params 0, eflags: 0x4
// Checksum 0x3338222f, Offset: 0x104f
// Size: 0x47
function private function_3243abe994d5f289()
{
    return namespace_6826532b84b72321::function_905e471a4fd5790c( [ [ "nade", "sat_smoke_grenade_mp", ( 0, 0, 0 ), ( -1583.61, -921.462, 152 ), 0 ] ] );
}

// Namespace namespace_5e1a0b922665681b
// Params 0, eflags: 0x4
// Checksum 0xf8c7dc6d, Offset: 0x109f
// Size: 0x10d
function private function_3243aae994d5f056()
{
    return namespace_6826532b84b72321::function_905e471a4fd5790c( [ [ "missile", "gunship_hellfire_mp", ( -407.388, -106.521, 906.467 ), ( -801.664, -367.852, 100 ), 0 ], [ "nade", "sat_frag_grenade_mp", ( 0, 0, 0 ), ( -802.19, -368.077, 100 ), 0.4 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( -888.003, -376.117, 100 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( -630, -150, 100 ), 0.1 ] ] );
}

// Namespace namespace_5e1a0b922665681b
// Params 0, eflags: 0x4
// Checksum 0xe04fb2aa, Offset: 0x11b5
// Size: 0x89
function private function_3243a9e994d5ee23()
{
    return namespace_6826532b84b72321::function_905e471a4fd5790c( [ [ "nade", "sat_frag_grenade_mp", ( 0, 0, 0 ), ( -858.066, 124.984, 102.503 ), 0 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( -858.121, 83.0342, 100 ), 0.1 ] ] );
}

// Namespace namespace_5e1a0b922665681b
// Params 0, eflags: 0x4
// Checksum 0xb42a325e, Offset: 0x1247
// Size: 0x299
function private function_3243a8e994d5ebf0()
{
    return namespace_6826532b84b72321::function_905e471a4fd5790c( [ [ "missile", "gunship_hellfire_mp", ( -296, -571, 92 ), ( -268.523, -446.535, 40 ), 0 ], [ "nade", "sat_frag_grenade_mp", ( 0, 0, 0 ), ( -296, -571, 92 ), 0.3 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( -177, -559, 92 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( -191.997, -369.644, 124.587 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( -452.407, -486.21, 92 ), 0.1 ], [ "missile", "gunship_hellfire_mp", ( 285.776, 670.868, 663.347 ), ( 285.708, -624.409, 129.954 ), 0.6 ], [ "nade", "sat_frag_grenade_mp", ( 0, 0, 0 ), ( 285.121, -630.67, 129.954 ), 0.3 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 168.281, -561.532, 92 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 298.962, -420.9, 40 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 504, -496, 189 ), 0.1 ] ] );
}

// Namespace namespace_5e1a0b922665681b
// Params 0, eflags: 0x4
// Checksum 0xd37d85ac, Offset: 0x14e9
// Size: 0x212
function private function_3243afe994d5fb55()
{
    return namespace_6826532b84b72321::function_905e471a4fd5790c( [ [ "missile", "gunship_hellfire_mp", ( 775, 0, 824 ), ( 715, -314, 87 ), 0 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 591, -279, 87 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 751.017, -407.795, 90.9997 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 1026.19, -363.386, 87 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 967, -88, 87 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 1584, -345, 15 ), 1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 1663, 101, 17 ), 0.3 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 1754, -427, 15 ), 0.3 ] ] );
}

// Namespace namespace_5e1a0b922665681b
// Params 0, eflags: 0x4
// Checksum 0xf954611f, Offset: 0x1704
// Size: 0x10d
function private function_3243aee994d5f922()
{
    return namespace_6826532b84b72321::function_905e471a4fd5790c( [ [ "missile", "gunship_hellfire_mp", ( 1696.46, 434.805, 658.156 ), ( 1676.43, -562.074, 14.9926 ), 0 ], [ "nade", "sat_frag_grenade_mp", ( 0, 0, 0 ), ( 1684.92, -562.81, 15.0102 ), 0.3 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 1564.8, -502.728, 14.6781 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 1786.73, -523.651, 16.0824 ), 0.1 ] ] );
}

// Namespace namespace_5e1a0b922665681b
// Params 0, eflags: 0x4
// Checksum 0xd4c9aed4, Offset: 0x181a
// Size: 0x1bf
function private function_3243ade994d5f6ef()
{
    return namespace_6826532b84b72321::function_905e471a4fd5790c( [ [ "missile", "gunship_hellfire_mp", ( 3254.17, -136.017, 382.933 ), ( 2239.82, -234.694, 16 ), 0 ], [ "nade", "sat_frag_grenade_mp", ( 0, 0, 0 ), ( 2456, 2.0703, 20.0482 ), 0.3 ], [ "nade", "sat_frag_grenade_mp", ( 0, 0, 0 ), ( 2454.48, 226.159, 16 ), 0 ], [ "nade", "sat_frag_grenade_mp", ( 0, 0, 0 ), ( 2456, -452.477, 22.002 ), 0 ], [ "nade", "sat_frag_grenade_mp", ( 0, 0, 0 ), ( 2456, -676.535, 23.7673 ), 0 ], [ "nade", "sat_frag_grenade_mp", ( 0, 0, 0 ), ( 2154.05, -492.529, 16 ), 0 ], [ "nade", "sat_frag_grenade_mp", ( 0, 0, 0 ), ( 2036.35, 212.986, 16 ), 0 ] ] );
}

// Namespace namespace_5e1a0b922665681b
// Params 0, eflags: 0x4
// Checksum 0x35c833c8, Offset: 0x19e2
// Size: 0x10d
function private function_3243ace994d5f4bc()
{
    return namespace_6826532b84b72321::function_905e471a4fd5790c( [ [ "missile", "gunship_hellfire_mp", ( 5, 859, 754 ), ( -75, 519, -10 ), 0 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( -104, 250, 92 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 91, 327, 68 ), 0.1 ], [ "nade", "sat_molotov_mp", ( 0, 0, 0 ), ( 128, 232, 109 ), 0.1 ] ] );
}

