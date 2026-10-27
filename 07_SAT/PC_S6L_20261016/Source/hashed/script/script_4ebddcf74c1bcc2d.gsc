// script_4ebddcf74c1bcc2d  (hash_4ebddcf74c1bcc2d.gscc) (size: 422 Bytes / 0x1a6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66d935c4 (1725511108)
// size ...... 422 (0x1a6)
// includes .. 1   (offset: 0x192)
// strings ... 1   (offset: 0x19a)
// dev strs .. 0   (offset: 0x1a6)
// exports ... 3   (offset: 0xe2)
// cseg ...... 0x75 + 0x6d (0xe2)
// imports ... 2   (offset: 0x15a)
// animtree1 . 0   (offset: 0x1a6)
// animtree2 . 0   (offset: 0x1a6)
#using scripts\common\callbacks;

#namespace specialty_walljump_buffed;

// Namespace specialty_walljump_buffed
// Params 0, eflags: 0x1
// Checksum 0xf2e5e8ba, Offset: 0x93
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_walljump_buffed
// Params 1
// Checksum 0x91e817fe, Offset: 0xb3
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_walljump_buffed" );
    }
}

