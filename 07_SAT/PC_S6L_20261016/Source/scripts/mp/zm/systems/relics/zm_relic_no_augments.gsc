// scripts\mp\zm\systems\relics\zm_relic_no_augments.gsc  (hash_2d6b9d936dc083fe.gscc) (size: 821 Bytes / 0x335 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7add262a (2061313578)
// size ...... 821 (0x335)
// includes .. 3   (offset: 0x305)
// strings ... 0   (offset: 0x31d)
// dev strs .. 2   (offset: 0x31d)
// exports ... 6   (offset: 0x12d)
// cseg ...... 0x58 + 0xd5 (0x12d)
// imports ... 8   (offset: 0x21d)
// animtree1 . 0   (offset: 0x335)
// animtree2 . 0   (offset: 0x335)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace zm_relic_no_augments;

// Namespace zm_relic_no_augments
// Params 0, eflags: 0x5
// Checksum 0x74543394, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_235a6ffbcd99b0ba", undefined, &init_relic_no_augments, undefined );
}

// Namespace zm_relic_no_augments
// Params 0
// Checksum 0x475a169a, Offset: 0x97
// Size: 0xa
function init_relic_no_augments()
{
    level thread function_e53671b20c326808();
}

// Namespace zm_relic_no_augments
// Params 0
// Checksum 0x3a0ec63a, Offset: 0xa9
// Size: 0x1c
function function_e53671b20c326808()
{
    zm_relics::register_relic_functions( #"no_augments", &function_bc1e99f79dad4dce, &function_fef9fd560eac474d );
}

// Namespace zm_relic_no_augments
// Params 0
// Checksum 0x90483255, Offset: 0xcd
// Size: 0x46
function function_bc1e99f79dad4dce()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"set_no_augments" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_no_augments
// Params 0
// Checksum 0xb4aa626a, Offset: 0x11b
// Size: 0x12
function function_fef9fd560eac474d()
{
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x42>" );
    #/
}

