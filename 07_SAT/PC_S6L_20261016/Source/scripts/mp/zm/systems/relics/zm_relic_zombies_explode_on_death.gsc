// scripts\mp\zm\systems\relics\zm_relic_zombies_explode_on_death.gsc  (hash_5187c1aae546e962.gscc) (size: 881 Bytes / 0x371 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9b244c3 (2847032515)
// size ...... 881 (0x371)
// includes .. 3   (offset: 0x341)
// strings ... 0   (offset: 0x359)
// dev strs .. 2   (offset: 0x359)
// exports ... 6   (offset: 0x161)
// cseg ...... 0x58 + 0x109 (0x161)
// imports ... 8   (offset: 0x251)
// animtree1 . 0   (offset: 0x371)
// animtree2 . 0   (offset: 0x371)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace zm_relic_zombies_explode_on_death;

// Namespace zm_relic_zombies_explode_on_death
// Params 0, eflags: 0x5
// Checksum 0x4bb715c7, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_912ef24afd4946b4", undefined, &function_530cec1028dc3a47, undefined );
}

// Namespace zm_relic_zombies_explode_on_death
// Params 0
// Checksum 0x4d6c5cb0, Offset: 0x97
// Size: 0xa
function function_530cec1028dc3a47()
{
    level thread function_25dde5d5610e7d46();
}

// Namespace zm_relic_zombies_explode_on_death
// Params 0
// Checksum 0xe480632f, Offset: 0xa9
// Size: 0x1c
function function_25dde5d5610e7d46()
{
    zm_relics::register_relic_functions( #"zombies_explode_on_death", &function_2d883f411fd18a94, &function_c1c84cad7eaf18db );
}

// Namespace zm_relic_zombies_explode_on_death
// Params 0
// Checksum 0x30cfa9, Offset: 0xcd
// Size: 0x46
function function_2d883f411fd18a94()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"set_zombies_explode_on_death" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_zombies_explode_on_death
// Params 0
// Checksum 0xd6a97fa2, Offset: 0x11b
// Size: 0x46
function function_c1c84cad7eaf18db()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_9eb1ad3b8dd931f2" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x4f>" );
    #/
}

