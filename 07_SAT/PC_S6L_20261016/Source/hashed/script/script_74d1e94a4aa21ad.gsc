// script_74d1e94a4aa21ad  (hash_074d1e94a4aa21ad.gscc) (size: 417 Bytes / 0x1a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfe76cf00 (4269199104)
// size ...... 417 (0x1a1)
// includes .. 1   (offset: 0x18d)
// strings ... 1   (offset: 0x195)
// dev strs .. 0   (offset: 0x1a1)
// exports ... 3   (offset: 0xdd)
// cseg ...... 0x70 + 0x6d (0xdd)
// imports ... 2   (offset: 0x155)
// animtree1 . 0   (offset: 0x1a1)
// animtree2 . 0   (offset: 0x1a1)
#using scripts\common\callbacks;

#namespace specialty_fastreload;

// Namespace specialty_fastreload
// Params 0, eflags: 0x1
// Checksum 0xcc9109e9, Offset: 0x8e
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_fastreload
// Params 1
// Checksum 0xaf9cf6ad, Offset: 0xae
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_fastreload" );
    }
}

