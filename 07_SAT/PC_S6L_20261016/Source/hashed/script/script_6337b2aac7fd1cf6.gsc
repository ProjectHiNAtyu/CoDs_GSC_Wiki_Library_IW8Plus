// script_6337b2aac7fd1cf6  (hash_6337b2aac7fd1cf6.gscc) (size: 430 Bytes / 0x1ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbaa1566b (3131135595)
// size ...... 430 (0x1ae)
// includes .. 1   (offset: 0x19a)
// strings ... 1   (offset: 0x1a2)
// dev strs .. 0   (offset: 0x1ae)
// exports ... 3   (offset: 0xea)
// cseg ...... 0x7d + 0x6d (0xea)
// imports ... 2   (offset: 0x162)
// animtree1 . 0   (offset: 0x1ae)
// animtree2 . 0   (offset: 0x1ae)
#using scripts\common\callbacks;

#namespace specialty_throwback_extrafusetime;

// Namespace specialty_throwback_extrafusetime
// Params 0, eflags: 0x1
// Checksum 0x18872371, Offset: 0x9b
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_throwback_extrafusetime
// Params 1
// Checksum 0x7b8adc35, Offset: 0xbb
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_throwback_extrafusetime" );
    }
}

