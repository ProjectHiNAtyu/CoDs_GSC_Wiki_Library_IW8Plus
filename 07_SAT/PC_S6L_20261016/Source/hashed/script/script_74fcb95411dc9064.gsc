// script_74fcb95411dc9064  (hash_74fcb95411dc9064.gscc) (size: 429 Bytes / 0x1ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5171b39a (1366406042)
// size ...... 429 (0x1ad)
// includes .. 1   (offset: 0x199)
// strings ... 1   (offset: 0x1a1)
// dev strs .. 0   (offset: 0x1ad)
// exports ... 3   (offset: 0xe9)
// cseg ...... 0x79 + 0x70 (0xe9)
// imports ... 2   (offset: 0x161)
// animtree1 . 0   (offset: 0x1ad)
// animtree2 . 0   (offset: 0x1ad)
#using scripts\common\callbacks;

#namespace specialty_prone_reduce_recoil;

// Namespace specialty_prone_reduce_recoil
// Params 0, eflags: 0x5
// Checksum 0xc49b3795, Offset: 0x97
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_cdab331b95aec68f );
}

// Namespace specialty_prone_reduce_recoil
// Params 1, eflags: 0x4
// Checksum 0x1459a66a, Offset: 0xb7
// Size: 0x32
function private function_cdab331b95aec68f( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_prone_reduce_recoil", undefined, undefined, [] );
    }
}

