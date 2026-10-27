// script_6e87829a702e2189  (hash_6e87829a702e2189.gscc) (size: 457 Bytes / 0x1c9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb27b2a (263355178)
// size ...... 457 (0x1c9)
// includes .. 1   (offset: 0x1b1)
// strings ... 1   (offset: 0x1b9)
// dev strs .. 0   (offset: 0x1c9)
// exports ... 3   (offset: 0x101)
// cseg ...... 0x71 + 0x90 (0x101)
// imports ... 2   (offset: 0x179)
// animtree1 . 0   (offset: 0x1c9)
// animtree2 . 0   (offset: 0x1c9)
#using scripts\common\callbacks;

#namespace specialty_mountaineer;

// Namespace specialty_mountaineer
// Params 0, eflags: 0x1
// Checksum 0xc1e90462, Offset: 0x8f
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_mountaineer
// Params 1
// Checksum 0xbc10b4a, Offset: 0xaf
// Size: 0x52
function registerperk( params )
{
    bundle = level.perkbundles[ "specialty_mountaineer" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_mountaineer" );
    }
}

