// script_60f411b4429c731e  (hash_60f411b4429c731e.gscc) (size: 430 Bytes / 0x1ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x623b1b42 (1648040770)
// size ...... 430 (0x1ae)
// includes .. 1   (offset: 0x19a)
// strings ... 1   (offset: 0x1a2)
// dev strs .. 0   (offset: 0x1ae)
// exports ... 3   (offset: 0xea)
// cseg ...... 0x7a + 0x70 (0xea)
// imports ... 2   (offset: 0x162)
// animtree1 . 0   (offset: 0x1ae)
// animtree2 . 0   (offset: 0x1ae)
#using scripts\common\callbacks;

#namespace specialty_adaptive_sprint_fire;

// Namespace specialty_adaptive_sprint_fire
// Params 0, eflags: 0x5
// Checksum 0x985ed7cf, Offset: 0x98
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_22a35467549ed4b );
}

// Namespace specialty_adaptive_sprint_fire
// Params 1, eflags: 0x4
// Checksum 0xd24043ec, Offset: 0xb8
// Size: 0x32
function private function_22a35467549ed4b( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_adaptive_sprint_fire", undefined, undefined, [] );
    }
}

