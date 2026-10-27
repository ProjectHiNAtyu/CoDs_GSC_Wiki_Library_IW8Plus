// script_2dc32a20ae7710c2  (hash_2dc32a20ae7710c2.gscc) (size: 574 Bytes / 0x23e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a6ec4d2 (1248773330)
// size ...... 574 (0x23e)
// includes .. 2   (offset: 0x21e)
// strings ... 1   (offset: 0x22e)
// dev strs .. 0   (offset: 0x23e)
// exports ... 4   (offset: 0x10e)
// cseg ...... 0x84 + 0x8a (0x10e)
// imports ... 4   (offset: 0x1ae)
// animtree1 . 0   (offset: 0x23e)
// animtree2 . 0   (offset: 0x23e)
#using scripts\common\callbacks;
#using scripts\mp\common\perks\perks;

#namespace specialty_explosive_regen_delay_immunity;

// Namespace specialty_explosive_regen_delay_immunity
// Params 0, eflags: 0x1
// Checksum 0xf2a51adf, Offset: 0xa2
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_explosive_regen_delay_immunity
// Params 1
// Checksum 0xafdd211d, Offset: 0xc2
// Size: 0x36
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_explosive_regen_delay_immunity", &setspecialty, undefined, [] );
    }
}

// Namespace specialty_explosive_regen_delay_immunity
// Params 0
// Checksum 0x7d9408be, Offset: 0x100
// Size: 0xe
function setspecialty()
{
    perks::function_70e4256c5fb41ada( "specialty_explosive_regen_delay_immunity" );
}

