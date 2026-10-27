// script_7dde60c091bb787  (hash_07dde60c091bb787.gscc) (size: 585 Bytes / 0x249 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe5e5fc7f (3857054847)
// size ...... 585 (0x249)
// includes .. 1   (offset: 0x235)
// strings ... 1   (offset: 0x23d)
// dev strs .. 0   (offset: 0x249)
// exports ... 5   (offset: 0xfd)
// cseg ...... 0x71 + 0x8c (0xfd)
// imports ... 4   (offset: 0x1c5)
// animtree1 . 0   (offset: 0x249)
// animtree2 . 0   (offset: 0x249)
#using scripts\common\callbacks;

#namespace specialty_supersprint;

// Namespace specialty_supersprint
// Params 0, eflags: 0x1
// Checksum 0xf8b9f59f, Offset: 0x8f
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_a8a4a034df7e7ae2 );
}

// Namespace specialty_supersprint
// Params 1
// Checksum 0x6c018ff, Offset: 0xaf
// Size: 0x3a
function function_a8a4a034df7e7ae2( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_supersprint", &setsupersprint, &unsetsupersprint, [] );
    }
}

// Namespace specialty_supersprint
// Params 0
// Checksum 0x7bc6c47c, Offset: 0xf1
// Size: 0x2
function setsupersprint()
{
    
}

// Namespace specialty_supersprint
// Params 0
// Checksum 0x4cb4c577, Offset: 0xfb
// Size: 0x2
function unsetsupersprint()
{
    
}

