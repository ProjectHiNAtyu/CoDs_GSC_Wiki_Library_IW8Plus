// scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_lighting.gsc  (hash_3e34e64fb723b1d0.gscc) (size: 615 Bytes / 0x267 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe70041ff (3875553791)
// size ...... 615 (0x267)
// includes .. 1   (offset: 0x22f)
// strings ... 4   (offset: 0x237)
// dev strs .. 0   (offset: 0x267)
// exports ... 3   (offset: 0x167)
// cseg ...... 0xd5 + 0x92 (0x167)
// imports ... 2   (offset: 0x1df)
// animtree1 . 0   (offset: 0x267)
// animtree2 . 0   (offset: 0x267)
#using scripts\common\utility;

#namespace virgo_lighting;

// Namespace virgo_lighting
// Params 0
// Checksum 0xbe324a52, Offset: 0xf3
// Size: 0x2
function main()
{
    
}

// Namespace virgo_lighting
// Params 0
// Checksum 0x4043061d, Offset: 0xfd
// Size: 0x6a
function function_830efdc5e59d5260()
{
    utility::flag_wait( "flag_intro_to_inverted_bink_done" );
    function_290c267015661b7a( #"hash_31adff910522475b" );
    utility::flag_wait( "flag_frogger_to_crashsite_bink_done" );
    function_290c267015661b7a( #"hash_d3e9e670203e5b9b" );
    utility::flag_wait( "flag_void_1_bink_done" );
    function_290c267015661b7a( #"gate_japan" );
    utility::flag_wait( "flag_void_2_bink_done" );
    function_290c267015661b7a( #"gate_carrier" );
}

