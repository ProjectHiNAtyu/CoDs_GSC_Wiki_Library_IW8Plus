// scripts\mp\zm\systems\relics\zm_relic_challenge_spawn_mimic_props.gsc  (hash_534a5e922b2461f4.gscc) (size: 921 Bytes / 0x399 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda3e006e (3661496430)
// size ...... 921 (0x399)
// includes .. 3   (offset: 0x369)
// strings ... 0   (offset: 0x381)
// dev strs .. 2   (offset: 0x381)
// exports ... 6   (offset: 0x175)
// cseg ...... 0x58 + 0x11d (0x175)
// imports ... 9   (offset: 0x265)
// animtree1 . 0   (offset: 0x399)
// animtree2 . 0   (offset: 0x399)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;

#namespace zm_relic_challenge_spawn_mimic_props;

// Namespace zm_relic_challenge_spawn_mimic_props
// Params 0, eflags: 0x5
// Checksum 0x5302f1a, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_7e1d92939ffb1839", undefined, &function_89e542947f344df9, undefined );
}

// Namespace zm_relic_challenge_spawn_mimic_props
// Params 0
// Checksum 0x4983764e, Offset: 0x97
// Size: 0xa
function function_89e542947f344df9()
{
    level thread function_16e5f79a82c91516();
}

// Namespace zm_relic_challenge_spawn_mimic_props
// Params 0
// Checksum 0x99c1ff14, Offset: 0xa9
// Size: 0x1c
function function_16e5f79a82c91516()
{
    zm_relic_challenges::register_relic_challenge_functions( #"hash_4a5af973a4cee44b", &function_c3a7014cd40f4d24, &function_823794fd1325790b );
}

// Namespace zm_relic_challenge_spawn_mimic_props
// Params 0
// Checksum 0x12a99fdf, Offset: 0xcd
// Size: 0x5e
function function_c3a7014cd40f4d24()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        var_7d4c78b7d42d3e = %"hash_316026ac255921e9";
        level utility::callsharedfunc( #"zm_mode_modifiers", #"hash_fbbb0712f33c62e6", var_7d4c78b7d42d3e );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_spawn_mimic_props
// Params 0
// Checksum 0xce44f608, Offset: 0x133
// Size: 0x42
function function_823794fd1325790b()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        level.zm_mode_modifiers.var_17778bfafdc97691 = 0;
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x54>" );
    #/
}

