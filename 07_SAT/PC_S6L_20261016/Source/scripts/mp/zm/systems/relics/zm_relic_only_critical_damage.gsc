// scripts\mp\zm\systems\relics\zm_relic_only_critical_damage.gsc  (hash_370fca7b82b9afde.gscc) (size: 881 Bytes / 0x371 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x904c57ff (2420922367)
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

#namespace zm_relic_only_critical_damage;

// Namespace zm_relic_only_critical_damage
// Params 0, eflags: 0x5
// Checksum 0x922b0848, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_bde6704db4d1bae0", undefined, &function_fb3b08378fc5f513, undefined );
}

// Namespace zm_relic_only_critical_damage
// Params 0
// Checksum 0x343b11f2, Offset: 0x97
// Size: 0xa
function function_fb3b08378fc5f513()
{
    level thread function_75595be4d36b8bc2();
}

// Namespace zm_relic_only_critical_damage
// Params 0
// Checksum 0xf6631fd9, Offset: 0xa9
// Size: 0x1c
function function_75595be4d36b8bc2()
{
    zm_relics::register_relic_functions( #"only_critical_damage", &function_22b7cc463678af18, &function_d7912624ee5ef50f );
}

// Namespace zm_relic_only_critical_damage
// Params 0
// Checksum 0x83b696f8, Offset: 0xcd
// Size: 0x46
function function_22b7cc463678af18()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"set_only_critical_damage" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_only_critical_damage
// Params 0
// Checksum 0x76f9205c, Offset: 0x11b
// Size: 0x46
function function_d7912624ee5ef50f()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_bc21eef9c580b8f6" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x52>" );
    #/
}

