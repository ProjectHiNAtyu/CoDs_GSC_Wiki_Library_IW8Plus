// script_6598d184badc5570  (hash_6598d184badc5570.gscc) (size: 735 Bytes / 0x2df / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xae3df1a7 (2923295143)
// size ...... 735 (0x2df)
// includes .. 2   (offset: 0x2c3)
// strings ... 1   (offset: 0x2d3)
// dev strs .. 0   (offset: 0x2df)
// exports ... 5   (offset: 0x137)
// cseg ...... 0x79 + 0xbe (0x137)
// imports ... 7   (offset: 0x1ff)
// animtree1 . 0   (offset: 0x2df)
// animtree2 . 0   (offset: 0x2df)
#using scripts\common\callbacks;
#using scripts\mp\playerhealth;

#namespace specialty_regen_delay_reduced;

// Namespace specialty_regen_delay_reduced
// Params 0, eflags: 0x1
// Checksum 0xd80e5625, Offset: 0x97
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_da6626d07f713a85 );
}

// Namespace specialty_regen_delay_reduced
// Params 1
// Checksum 0xc4b764de, Offset: 0xb7
// Size: 0x3a
function function_da6626d07f713a85( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_regen_delay_reduced", &setreduceregendelay, &unsetreduceregendelay, [] );
    }
}

// Namespace specialty_regen_delay_reduced
// Params 0
// Checksum 0xe9680cf, Offset: 0xf9
// Size: 0x24
function setreduceregendelay()
{
    playerhealth::function_fd91e6d94cab77e7( #"hash_9a74bc348f8739cb", getdvarfloat( @"hash_396fbb6db81e3ff6", 1 ) );
}

// Namespace specialty_regen_delay_reduced
// Params 0
// Checksum 0xed2f4673, Offset: 0x125
// Size: 0x12
function unsetreduceregendelay()
{
    playerhealth::function_b1fb4d148779580e( #"hash_9a74bc348f8739cb" );
}

