// script_7f2d650d0740d4b6  (hash_7f2d650d0740d4b6.gscc) (size: 861 Bytes / 0x35d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8e723151 (2389848401)
// size ...... 861 (0x35d)
// includes .. 3   (offset: 0x321)
// strings ... 3   (offset: 0x339)
// dev strs .. 0   (offset: 0x35d)
// exports ... 5   (offset: 0x189)
// cseg ...... 0xb2 + 0xd7 (0x189)
// imports ... 7   (offset: 0x251)
// animtree1 . 0   (offset: 0x35d)
// animtree2 . 0   (offset: 0x35d)
#using script_54a05cbb2455bc6f;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_player_utility;

#namespace ztron_fate_feet;

// Namespace ztron_fate_feet
// Params 0, eflags: 0x5
// Checksum 0x21666596, Offset: 0xd0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_fate_feet", #"ztron_fate", undefined, &init );
}

// Namespace ztron_fate_feet
// Params 0
// Checksum 0x1de72b5, Offset: 0xf9
// Size: 0x2d
function init()
{
    ztron_fate::function_4b268a9ddf9d18b4( 4, #"feet", &activate, &deactivate, "ztron_fate_rock_feet", "sat_zm_ztron_props_fate_boots", "dx_zm_ztr4_anno_anz4_d4fateft" );
}

// Namespace ztron_fate_feet
// Params 1
// Checksum 0x438a3d64, Offset: 0x12e
// Size: 0x38
function activate( loadgame )
{
    ztron_player_utility::function_2c9ea3b797f22c77( getdvarfloat( @"hash_b84c9488d420c7d3", 1 ) * getdvarfloat( @"hash_8bc9aeb7a354b719", 1.65 ) );
}

// Namespace ztron_fate_feet
// Params 0
// Checksum 0xaae601f5, Offset: 0x16e
// Size: 0x1b
function deactivate()
{
    ztron_player_utility::function_2c9ea3b797f22c77( getdvarfloat( @"hash_b84c9488d420c7d3", 1 ) );
}

