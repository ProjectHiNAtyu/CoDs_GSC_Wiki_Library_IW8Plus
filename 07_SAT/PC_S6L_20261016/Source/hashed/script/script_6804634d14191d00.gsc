// script_6804634d14191d00  (hash_6804634d14191d00.gscc) (size: 567 Bytes / 0x237 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x160fbb4 (23133108)
// size ...... 567 (0x237)
// includes .. 2   (offset: 0x217)
// strings ... 1   (offset: 0x227)
// dev strs .. 0   (offset: 0x237)
// exports ... 4   (offset: 0x107)
// cseg ...... 0x7d + 0x8a (0x107)
// imports ... 4   (offset: 0x1a7)
// animtree1 . 0   (offset: 0x237)
// animtree2 . 0   (offset: 0x237)
#using scripts\common\callbacks;
#using scripts\mp\common\perks\perks;

#namespace specialty_explosive_slow_immunity;

// Namespace specialty_explosive_slow_immunity
// Params 0, eflags: 0x1
// Checksum 0x745a56eb, Offset: 0x9b
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_explosive_slow_immunity
// Params 1
// Checksum 0xd4fb8baf, Offset: 0xbb
// Size: 0x36
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_explosive_slow_immunity", &setspecialty, undefined, [] );
    }
}

// Namespace specialty_explosive_slow_immunity
// Params 0
// Checksum 0xfb6b448a, Offset: 0xf9
// Size: 0xe
function setspecialty()
{
    perks::function_70e4256c5fb41ada( "specialty_explosive_slow_immunity" );
}

