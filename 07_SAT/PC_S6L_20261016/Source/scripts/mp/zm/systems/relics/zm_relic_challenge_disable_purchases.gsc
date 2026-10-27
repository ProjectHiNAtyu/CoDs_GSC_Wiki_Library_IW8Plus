// scripts\mp\zm\systems\relics\zm_relic_challenge_disable_purchases.gsc  (hash_5fea35e4976ae063.gscc) (size: 1549 Bytes / 0x60d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf7efcc7 (259980487)
// size ...... 1549 (0x60d)
// includes .. 4   (offset: 0x5d5)
// strings ... 0   (offset: 0x5f5)
// dev strs .. 2   (offset: 0x5f5)
// exports ... 8   (offset: 0x2f9)
// cseg ...... 0x58 + 0x2a1 (0x2f9)
// imports ... 14  (offset: 0x439)
// animtree1 . 0   (offset: 0x60d)
// animtree2 . 0   (offset: 0x60d)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;

#namespace zm_relic_challenge_disable_purchases;

// Namespace zm_relic_challenge_disable_purchases
// Params 0, eflags: 0x5
// Checksum 0xc3aa073a, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_relic_challenge_disable_purchases", undefined, &init_relic_challenge_disable_purchases, undefined );
}

// Namespace zm_relic_challenge_disable_purchases
// Params 0
// Checksum 0x46ce7f2, Offset: 0x97
// Size: 0xa
function init_relic_challenge_disable_purchases()
{
    level thread function_10e8597be013f561();
}

// Namespace zm_relic_challenge_disable_purchases
// Params 0
// Checksum 0x527c2fa7, Offset: 0xa9
// Size: 0x1c
function function_10e8597be013f561()
{
    zm_relic_challenges::register_relic_challenge_functions( #"disable_purchases", &function_edddeaf4ae1291ed, &function_375b1e0b05bbbde0 );
}

// Namespace zm_relic_challenge_disable_purchases
// Params 0
// Checksum 0xdca81e7a, Offset: 0xcd
// Size: 0xbe
function function_edddeaf4ae1291ed()
{
    level callback::add( #"player_spawned", &on_player_spawned );
    
    foreach ( player in level.players )
    {
        player function_174c337ae60e88a3( 1 );
    }
    
    utility::callsharedfunc( #"traps", #"hash_bec4853d43d80950", 1 );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_disable_purchases
// Params 0
// Checksum 0x27e3011f, Offset: 0x193
// Size: 0xbc
function function_375b1e0b05bbbde0()
{
    level callback::remove( #"player_spawned", &on_player_spawned );
    
    foreach ( player in level.players )
    {
        player function_174c337ae60e88a3( 0 );
    }
    
    utility::callsharedfunc( #"traps", #"hash_bec4853d43d80950", 0 );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x55>" );
    #/
}

// Namespace zm_relic_challenge_disable_purchases
// Params 1
// Checksum 0x23179811, Offset: 0x257
// Size: 0x85
function function_174c337ae60e88a3( var_94d1ab5da995e573 )
{
    self.var_432159241a2f9367 = var_94d1ab5da995e573;
    self.var_e830497a1d286f74 = var_94d1ab5da995e573;
    self.arsenal_disabled = var_94d1ab5da995e573;
    self.crafting_table_disabled = var_94d1ab5da995e573;
    self.ammo_cache_disabled = var_94d1ab5da995e573;
    level.var_c139731c583cae6b = var_94d1ab5da995e573;
    level.var_96d4f8dc0c3cfea3 = var_94d1ab5da995e573;
    self.bgb_machine_disabled = var_94d1ab5da995e573;
    self.var_73e2de392faa52c6 = var_94d1ab5da995e573;
    self.doorbuy_disabled = var_94d1ab5da995e573;
    self.var_2314a9263fbe04b9 = var_94d1ab5da995e573;
}

// Namespace zm_relic_challenge_disable_purchases
// Params 1, eflags: 0x4
// Checksum 0x3cd8b9a2, Offset: 0x2e4
// Size: 0x15
function private on_player_spawned( params )
{
    function_174c337ae60e88a3( 1 );
}

