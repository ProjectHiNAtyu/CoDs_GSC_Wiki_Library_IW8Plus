// script_706e6ff5e6be79e6  (hash_706e6ff5e6be79e6.gscc) (size: 497 Bytes / 0x1f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe2d2cc1c (3805465628)
// size ...... 497 (0x1f1)
// includes .. 2   (offset: 0x1d5)
// strings ... 1   (offset: 0x1e5)
// dev strs .. 0   (offset: 0x1f1)
// exports ... 3   (offset: 0xed)
// cseg ...... 0x76 + 0x77 (0xed)
// imports ... 4   (offset: 0x165)
// animtree1 . 0   (offset: 0x1f1)
// animtree2 . 0   (offset: 0x1f1)
#using scripts\common\callbacks;
#using scripts\mp\common\perks\perkfunctions;

#namespace specialty_reload_on_switch;

// Namespace specialty_reload_on_switch
// Params 0, eflags: 0x1
// Checksum 0xa5d3e245, Offset: 0x94
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_reload_on_switch
// Params 1
// Checksum 0x6d9bd386, Offset: 0xb4
// Size: 0x39
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_reload_on_switch", &perkfunctions::function_b171574387e7502e, &perkfunctions::function_27bc83ee3dea9e27 );
    }
}

