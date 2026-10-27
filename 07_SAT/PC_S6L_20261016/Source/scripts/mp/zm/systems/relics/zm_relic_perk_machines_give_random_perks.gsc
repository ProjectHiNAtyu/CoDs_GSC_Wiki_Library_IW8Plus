// scripts\mp\zm\systems\relics\zm_relic_perk_machines_give_random_perks.gsc  (hash_684c24a110f8c6a5.gscc) (size: 1035 Bytes / 0x40b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b072b9d (453454749)
// size ...... 1035 (0x40b)
// includes .. 3   (offset: 0x3c3)
// strings ... 2   (offset: 0x3db)
// dev strs .. 2   (offset: 0x3f3)
// exports ... 6   (offset: 0x1c7)
// cseg ...... 0xa5 + 0x122 (0x1c7)
// imports ... 9   (offset: 0x2b7)
// animtree1 . 0   (offset: 0x40b)
// animtree2 . 0   (offset: 0x40b)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace zm_relic_perk_machines_give_random_perks;

// Namespace zm_relic_perk_machines_give_random_perks
// Params 0, eflags: 0x5
// Checksum 0x1271bce9, Offset: 0xc3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_743ca4913bdfa59d", undefined, &init_relic_perk_machines_give_random_perks, undefined );
}

// Namespace zm_relic_perk_machines_give_random_perks
// Params 0
// Checksum 0x5168f917, Offset: 0xe4
// Size: 0x23
function init_relic_perk_machines_give_random_perks()
{
    level thread function_c09917d40dc468b7();
    level._effect[ "relic_perk_machines_give_random_perks" ] = loadfxasset( "vfx_sat_gameplay_zm_r_mod_random" );
}

// Namespace zm_relic_perk_machines_give_random_perks
// Params 0
// Checksum 0x27c786fd, Offset: 0x10f
// Size: 0x1c
function function_c09917d40dc468b7()
{
    zm_relics::register_relic_functions( #"perk_machines_give_random_perks", &function_dc68e6f2d1a99727, &function_cb534878d9dde862 );
}

// Namespace zm_relic_perk_machines_give_random_perks
// Params 0
// Checksum 0x1e76af9c, Offset: 0x133
// Size: 0x46
function function_dc68e6f2d1a99727()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"set_perk_machines_give_random_perks" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_perk_machines_give_random_perks
// Params 0
// Checksum 0x6c52f4bc, Offset: 0x181
// Size: 0x46
function function_cb534878d9dde862()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_f9cefde5c456883b" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x56>" );
    #/
}

