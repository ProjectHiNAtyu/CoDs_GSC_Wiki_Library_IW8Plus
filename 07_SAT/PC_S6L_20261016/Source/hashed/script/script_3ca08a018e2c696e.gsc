// script_3ca08a018e2c696e  (hash_3ca08a018e2c696e.gscc) (size: 423 Bytes / 0x1a7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9bb5023 (4189802531)
// size ...... 423 (0x1a7)
// includes .. 1   (offset: 0x193)
// strings ... 1   (offset: 0x19b)
// dev strs .. 0   (offset: 0x1a7)
// exports ... 3   (offset: 0xe3)
// cseg ...... 0x73 + 0x70 (0xe3)
// imports ... 2   (offset: 0x15b)
// animtree1 . 0   (offset: 0x1a7)
// animtree2 . 0   (offset: 0x1a7)
#using scripts\common\callbacks;

#namespace specialty_quartermaster;

// Namespace specialty_quartermaster
// Params 0, eflags: 0x1
// Checksum 0x743f8be0, Offset: 0x91
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_6a21be1544039dc5 );
}

// Namespace specialty_quartermaster
// Params 1
// Checksum 0x9fade64b, Offset: 0xb1
// Size: 0x32
function function_6a21be1544039dc5( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_quartermaster", undefined, undefined, [] );
    }
}

