// script_39734c24fc961a11  (hash_39734c24fc961a11.gscc) (size: 425 Bytes / 0x1a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x504fb6c0 (1347401408)
// size ...... 425 (0x1a9)
// includes .. 1   (offset: 0x195)
// strings ... 1   (offset: 0x19d)
// dev strs .. 0   (offset: 0x1a9)
// exports ... 3   (offset: 0xe5)
// cseg ...... 0x78 + 0x6d (0xe5)
// imports ... 2   (offset: 0x15d)
// animtree1 . 0   (offset: 0x1a9)
// animtree2 . 0   (offset: 0x1a9)
#using scripts\common\callbacks;

#namespace specialty_sixth_sense_immune;

// Namespace specialty_sixth_sense_immune
// Params 0, eflags: 0x1
// Checksum 0x19f95cec, Offset: 0x96
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_sixth_sense_immune
// Params 1
// Checksum 0x7af4a3a8, Offset: 0xb6
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_sixth_sense_immune" );
    }
}

