// script_75fb320a1f3e4b4e  (hash_75fb320a1f3e4b4e.gscc) (size: 897 Bytes / 0x381 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xac79eea8 (2893672104)
// size ...... 897 (0x381)
// includes .. 4   (offset: 0x339)
// strings ... 3   (offset: 0x359)
// dev strs .. 0   (offset: 0x381)
// exports ... 5   (offset: 0x191)
// cseg ...... 0x80 + 0x111 (0x191)
// imports ... 8   (offset: 0x259)
// animtree1 . 0   (offset: 0x381)
// animtree2 . 0   (offset: 0x381)
#using script_aa3bac81ad4fc8e;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\mp\supers;

#namespace namespace_7acf9c7beb66157b;

// Namespace namespace_7acf9c7beb66157b
// Params 0, eflags: 0x5
// Checksum 0xfc33df5a, Offset: 0x9e
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "power_keg", #"bgb", &__init__, undefined );
}

// Namespace namespace_7acf9c7beb66157b
// Params 0
// Checksum 0xa4111508, Offset: 0xc3
// Size: 0x21
function __init__()
{
    bgb::register( "power_keg", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace namespace_7acf9c7beb66157b
// Params 0
// Checksum 0xd9da23cd, Offset: 0xec
// Size: 0xe
function activation()
{
    thread powerups::powerup_activate( "full_power" );
}

// Namespace namespace_7acf9c7beb66157b
// Params 0
// Checksum 0xc8075f71, Offset: 0x102
// Size: 0x8e, Type: bool
function validation()
{
    foreach ( player in level.players )
    {
        var_c0c4324d255baab3 = player supers_mp::getcurrentsuper();
        
        if ( isdefined( var_c0c4324d255baab3 ) )
        {
            return true;
        }
    }
    
    return false;
}

