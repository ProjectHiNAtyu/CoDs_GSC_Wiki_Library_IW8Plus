// scripts\mp\zm\systems\relics\zm_relic_no_self_revives.gsc  (hash_5f1512526321b2d5.gscc) (size: 881 Bytes / 0x371 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a4ab426 (1514845222)
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

#namespace zm_relic_no_self_revives;

// Namespace zm_relic_no_self_revives
// Params 0, eflags: 0x5
// Checksum 0x775d60a4, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_977ffa807a76f281", undefined, &function_2eaed64df9f77528, undefined );
}

// Namespace zm_relic_no_self_revives
// Params 0
// Checksum 0xcf7bc0c1, Offset: 0x97
// Size: 0xa
function function_2eaed64df9f77528()
{
    level thread function_e15ccbee1a555c87();
}

// Namespace zm_relic_no_self_revives
// Params 0
// Checksum 0xed15fed6, Offset: 0xa9
// Size: 0x1c
function function_e15ccbee1a555c87()
{
    zm_relics::register_relic_functions( #"no_self_revives", &function_225cc3a0aa8c7a63, &function_862c5ca01462f51e );
}

// Namespace zm_relic_no_self_revives
// Params 0
// Checksum 0x903ede14, Offset: 0xcd
// Size: 0x46
function function_225cc3a0aa8c7a63()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"set_no_self_revives" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_no_self_revives
// Params 0
// Checksum 0x55399e07, Offset: 0x11b
// Size: 0x46
function function_862c5ca01462f51e()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_786cc79d952b8fc3" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x46>" );
    #/
}

