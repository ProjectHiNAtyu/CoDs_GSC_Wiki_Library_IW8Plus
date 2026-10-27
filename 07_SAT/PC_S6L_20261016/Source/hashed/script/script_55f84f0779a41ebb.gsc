// script_55f84f0779a41ebb  (hash_55f84f0779a41ebb.gscc) (size: 590 Bytes / 0x24e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x354bf6a1 (894170785)
// size ...... 590 (0x24e)
// includes .. 1   (offset: 0x23a)
// strings ... 1   (offset: 0x242)
// dev strs .. 0   (offset: 0x24e)
// exports ... 5   (offset: 0x102)
// cseg ...... 0x76 + 0x8c (0x102)
// imports ... 4   (offset: 0x1ca)
// animtree1 . 0   (offset: 0x24e)
// animtree2 . 0   (offset: 0x24e)
#using scripts\common\callbacks;

#namespace specialty_flexible_tactics;

// Namespace specialty_flexible_tactics
// Params 0, eflags: 0x1
// Checksum 0x728d0836, Offset: 0x94
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_flexible_tactics
// Params 1
// Checksum 0x21374330, Offset: 0xb4
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_flexible_tactics", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_flexible_tactics
// Params 0
// Checksum 0x7cb8b3b0, Offset: 0xf6
// Size: 0x2
function setspecialty()
{
    
}

// Namespace specialty_flexible_tactics
// Params 0
// Checksum 0x4c0f07de, Offset: 0x100
// Size: 0x2
function unsetspecialty()
{
    
}

