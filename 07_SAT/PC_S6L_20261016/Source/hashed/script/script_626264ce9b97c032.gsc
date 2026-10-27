// script_626264ce9b97c032  (hash_626264ce9b97c032.gscc) (size: 2103 Bytes / 0x837)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d938a49 (1569950281)
// size ...... 2103 (0x837)
// includes .. 1   (offset: 0x817)
// strings ... 2   (offset: 0x81f)
// dev strs .. 0   (offset: 0x837)
// exports ... 13  (offset: 0x4ff)
// cseg ...... 0x79 + 0x486 (0x4ff)
// imports ... 9   (offset: 0x707)
// animtree1 . 0   (offset: 0x837)
// animtree2 . 0   (offset: 0x837)
#using script_d74ae0b4aa21186;

#namespace namespace_cf699c4c504e63f;

// Namespace namespace_cf699c4c504e63f
// Params 0
// Checksum 0xd08b225c, Offset: 0x97
// Size: 0x64
function combatconstants()
{
    dc1 = mind::function_1ee329c7a6e496b9( &function_b458daa6d04b38ee );
    dc_brtdm_mgl = dc1 mind::function_9a8a822b063d346( &function_e986421cf314115c, "brtdm_mgl.*.*" );
    dc_conflict = dc1 mind::function_9a8a822b063d346( &function_e8625e431ad62e9f, "conflict.*.*" );
    return [ dc1, dc_brtdm_mgl, dc_conflict ];
}

// Namespace namespace_cf699c4c504e63f
// Params 1
// Checksum 0x2340041c, Offset: 0x104
// Size: 0x104
function function_b458daa6d04b38ee( constants )
{
    constants.nearbyenemydistance = 5850;
    constants.var_6f25ddad2801df76 = [ 0, 585, 780, 1560, 1755, 2925, 3900, 5850 ];
    constants.var_280ab218c5864a36 = [ 98, 90, 81, 63, 53, 22, 5, 0 ];
    constants.var_25466031dbd60293 = 1000;
    constants.var_642e1e5b43a46ef6 = [ 195, 780, 1755, 2730 ];
    constants.var_7fae8b56893010b6 = [ -5, -20, -30, -40 ];
    constants.attackermodifier = 10;
}

// Namespace namespace_cf699c4c504e63f
// Params 1
// Checksum 0x785ed6ee, Offset: 0x210
// Size: 0x75
function function_e986421cf314115c( constants )
{
    constants.var_25466031dbd60293 = 2000;
    constants.var_642e1e5b43a46ef6 = [ 195, 975, 1755, 2730 ];
    constants.var_7fae8b56893010b6 = [ 0, -10, -25, -40 ];
    constants.attackermodifier = 15;
}

// Namespace namespace_cf699c4c504e63f
// Params 1
// Checksum 0xd56e2acc, Offset: 0x28d
// Size: 0x68
function function_e8625e431ad62e9f( constants )
{
    constants.var_25466031dbd60293 = 1200;
    constants.var_642e1e5b43a46ef6 = [ 312, 780, 1755, 2730 ];
    constants.var_7fae8b56893010b6 = [ 0, -5, -20, -40 ];
}

// Namespace namespace_cf699c4c504e63f
// Params 0
// Checksum 0xd34ae64a, Offset: 0x2fd
// Size: 0x20
function wanderconstants()
{
    dc1 = mind::function_1ee329c7a6e496b9( &function_89c577193f88965d );
    return [ dc1 ];
}

// Namespace namespace_cf699c4c504e63f
// Params 1
// Checksum 0xefc6c49f, Offset: 0x326
// Size: 0x1a
function function_89c577193f88965d( constants )
{
    constants.basescore = 5;
}

// Namespace namespace_cf699c4c504e63f
// Params 0
// Checksum 0xc2af38fb, Offset: 0x348
// Size: 0x20
function function_7fdae62b3066f367()
{
    dc1 = mind::function_1ee329c7a6e496b9( &function_e1b9ddeaf2e4f628 );
    return [ dc1 ];
}

// Namespace namespace_cf699c4c504e63f
// Params 1
// Checksum 0xad41905a, Offset: 0x371
// Size: 0x39
function function_e1b9ddeaf2e4f628( constants )
{
    constants.basescore = 60;
    constants.var_e2a49e9ea25a80d0 = [ 60, 30, 10 ];
}

// Namespace namespace_cf699c4c504e63f
// Params 0
// Checksum 0x5772e1ad, Offset: 0x3b2
// Size: 0x20
function function_522644131a5491b1()
{
    dc1 = mind::function_1ee329c7a6e496b9( &function_f1c9a449e3ddcc66 );
    return [ dc1 ];
}

// Namespace namespace_cf699c4c504e63f
// Params 1
// Checksum 0xac6a246a, Offset: 0x3db
// Size: 0x45
function function_f1c9a449e3ddcc66( constants )
{
    constants.basescore = 60;
    constants.var_e2a49e9ea25a80d0 = [ 40, 30, 15, 10, 5 ];
}

// Namespace namespace_cf699c4c504e63f
// Params 0
// Checksum 0xe72033ed, Offset: 0x428
// Size: 0x20
function function_876ade716e9c3a9a()
{
    dc1 = mind::function_1ee329c7a6e496b9( &function_d26e9b40213b9127 );
    return [ dc1 ];
}

// Namespace namespace_cf699c4c504e63f
// Params 1
// Checksum 0x8cb260d7, Offset: 0x451
// Size: 0xae
function function_d26e9b40213b9127( constants )
{
    var_9199af0d05441497 = 20;
    var_1f95171eb5126fcc = 8;
    constants.basescore = 60;
    constants.var_6c5a34a2a051ce06 = 51;
    constants.var_9b7deb85eca56732 = [ var_1f95171eb5126fcc, var_1f95171eb5126fcc + 1, var_9199af0d05441497 ];
    constants.var_8b93445f3af471a7 = [ 0, -20, 0 ];
    constants.teammatemodifier = [ 10, 10, 0, 0, 0, 0 ];
}

