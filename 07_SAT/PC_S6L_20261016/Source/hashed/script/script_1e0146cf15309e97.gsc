// script_1e0146cf15309e97  (hash_1e0146cf15309e97.gscc) (size: 436 Bytes / 0x1b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf0dd560 (2936919392)
// size ...... 436 (0x1b4)
// includes .. 1   (offset: 0x1a0)
// strings ... 1   (offset: 0x1a8)
// dev strs .. 0   (offset: 0x1b4)
// exports ... 3   (offset: 0xf0)
// cseg ...... 0x83 + 0x6d (0xf0)
// imports ... 2   (offset: 0x168)
// animtree1 . 0   (offset: 0x1b4)
// animtree2 . 0   (offset: 0x1b4)
#using scripts\common\callbacks;

#namespace specialty_hidden_from_location_callouts;

// Namespace specialty_hidden_from_location_callouts
// Params 0, eflags: 0x1
// Checksum 0xeef6d015, Offset: 0xa1
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_hidden_from_location_callouts
// Params 1
// Checksum 0x8dfb2f51, Offset: 0xc1
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_hidden_from_location_callouts" );
    }
}

