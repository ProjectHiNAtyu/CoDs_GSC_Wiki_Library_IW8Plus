// script_48f4132c14612708  (hash_48f4132c14612708.gscc) (size: 438 Bytes / 0x1b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd82d9b (232271259)
// size ...... 438 (0x1b6)
// includes .. 1   (offset: 0x19e)
// strings ... 1   (offset: 0x1a6)
// dev strs .. 0   (offset: 0x1b6)
// exports ... 3   (offset: 0xee)
// cseg ...... 0x73 + 0x7b (0xee)
// imports ... 2   (offset: 0x166)
// animtree1 . 0   (offset: 0x1b6)
// animtree2 . 0   (offset: 0x1b6)
#using scripts\common\callbacks;

#namespace specialty_hack_immunity;

// Namespace specialty_hack_immunity
// Params 0, eflags: 0x1
// Checksum 0xc5785132, Offset: 0x91
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_hack_immunity
// Params 1
// Checksum 0x4a9db215, Offset: 0xb1
// Size: 0x3d
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_hack_immunity" );
    }
    
    level.specialty_hack_immunity_ref = "specialty_hack_immunity";
}

