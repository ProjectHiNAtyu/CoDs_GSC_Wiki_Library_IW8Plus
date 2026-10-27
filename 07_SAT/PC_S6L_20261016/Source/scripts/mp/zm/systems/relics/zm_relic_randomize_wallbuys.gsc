// scripts\mp\zm\systems\relics\zm_relic_randomize_wallbuys.gsc  (hash_1da6a642c738a895.gscc) (size: 881 Bytes / 0x371 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x939f3f4f (2476687183)
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

#namespace zm_relic_randomize_wallbuys;

// Namespace zm_relic_randomize_wallbuys
// Params 0, eflags: 0x5
// Checksum 0x8af27a44, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_dca1dbdeefcbdd03", undefined, &init_relic_randomize_wallbuys, undefined );
}

// Namespace zm_relic_randomize_wallbuys
// Params 0
// Checksum 0x690976f, Offset: 0x97
// Size: 0xa
function init_relic_randomize_wallbuys()
{
    level thread function_9c5203ce28ce33dd();
}

// Namespace zm_relic_randomize_wallbuys
// Params 0
// Checksum 0x1c780ef2, Offset: 0xa9
// Size: 0x1c
function function_9c5203ce28ce33dd()
{
    zm_relics::register_relic_functions( #"randomize_wallbuys", &function_2ffafacf04671849, &function_8ad2cc501af026c );
}

// Namespace zm_relic_randomize_wallbuys
// Params 0
// Checksum 0xa23f9e49, Offset: 0xcd
// Size: 0x46
function function_2ffafacf04671849()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"set_randomize_wallbuys" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_randomize_wallbuys
// Params 0
// Checksum 0x35e41308, Offset: 0x11b
// Size: 0x46
function function_8ad2cc501af026c()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"disable_randomize_wallbuys" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x50>" );
    #/
}

