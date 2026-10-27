// script_5f0f2d51b9adc4f4  (hash_5f0f2d51b9adc4f4.gscc) (size: 560 Bytes / 0x230 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5375be63 (1400225379)
// size ...... 560 (0x230)
// includes .. 2   (offset: 0x210)
// strings ... 1   (offset: 0x220)
// dev strs .. 0   (offset: 0x230)
// exports ... 4   (offset: 0x100)
// cseg ...... 0x76 + 0x8a (0x100)
// imports ... 4   (offset: 0x1a0)
// animtree1 . 0   (offset: 0x230)
// animtree2 . 0   (offset: 0x230)
#using scripts\common\callbacks;
#using scripts\mp\common\perks\perks;

#namespace specialty_scrambler_resist;

// Namespace specialty_scrambler_resist
// Params 0, eflags: 0x1
// Checksum 0x590e150a, Offset: 0x94
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_scrambler_resist
// Params 1
// Checksum 0xfbbb13ab, Offset: 0xb4
// Size: 0x36
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_scrambler_resist", &setspecialty, undefined, [] );
    }
}

// Namespace specialty_scrambler_resist
// Params 0
// Checksum 0xd63f076b, Offset: 0xf2
// Size: 0xe
function setspecialty()
{
    perks::function_70e4256c5fb41ada( "specialty_scrambler_resist" );
}

