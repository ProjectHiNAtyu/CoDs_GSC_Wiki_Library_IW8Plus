// script_569acf25a680724b  (hash_569acf25a680724b.gscc) (size: 843 Bytes / 0x34b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e2a9969 (2653591913)
// size ...... 843 (0x34b)
// includes .. 4   (offset: 0x2ff)
// strings ... 3   (offset: 0x31f)
// dev strs .. 0   (offset: 0x34b)
// exports ... 5   (offset: 0x13b)
// cseg ...... 0x85 + 0xb6 (0x13b)
// imports ... 9   (offset: 0x203)
// animtree1 . 0   (offset: 0x34b)
// animtree2 . 0   (offset: 0x34b)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\mp\common\perks\zombie\zombie_perks;

#namespace namespace_c9500f8952a0749e;

// Namespace namespace_c9500f8952a0749e
// Params 0, eflags: 0x5
// Checksum 0x7e04943c, Offset: 0xa3
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "perkaholic", #"bgb", &__init__, undefined );
}

// Namespace namespace_c9500f8952a0749e
// Params 0
// Checksum 0xa0f7f0d7, Offset: 0xc8
// Size: 0x21
function __init__()
{
    bgb::register( "perkaholic", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace namespace_c9500f8952a0749e
// Params 0
// Checksum 0x5786f3d0, Offset: 0xf1
// Size: 0x22
function activation()
{
    self endon( #"disconnect" );
    zombie_perks::function_a0329bb1c47eda09();
    bgb::function_b62ba460d1b3dac9( "perkaholic" );
    waitframe();
}

// Namespace namespace_c9500f8952a0749e
// Params 0
// Checksum 0x9b75fcec, Offset: 0x11b
// Size: 0x1f, Type: bool
function validation()
{
    if ( zombie_perks::function_cda78d45986a51a0() || !val::get( "allow_zm_perks" ) )
    {
        return false;
    }
    
    return true;
}

