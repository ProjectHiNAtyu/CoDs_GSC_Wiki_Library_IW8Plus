// script_4cc3d82b122287d5  (hash_4cc3d82b122287d5.gscc) (size: 424 Bytes / 0x1a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x344b80f5 (877363445)
// size ...... 424 (0x1a8)
// includes .. 1   (offset: 0x194)
// strings ... 1   (offset: 0x19c)
// dev strs .. 0   (offset: 0x1a8)
// exports ... 3   (offset: 0xe4)
// cseg ...... 0x77 + 0x6d (0xe4)
// imports ... 2   (offset: 0x15c)
// animtree1 . 0   (offset: 0x1a8)
// animtree2 . 0   (offset: 0x1a8)
#using scripts\common\callbacks;

#namespace specialty_missileprediction;

// Namespace specialty_missileprediction
// Params 0, eflags: 0x1
// Checksum 0xda4b6ba1, Offset: 0x95
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_missileprediction
// Params 1
// Checksum 0xb94694e5, Offset: 0xb5
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_missileprediction" );
    }
}

