// script_7350b2e8753fbf5c  (hash_7350b2e8753fbf5c.gscc) (size: 908 Bytes / 0x38c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa531ca62 (2771503714)
// size ...... 908 (0x38c)
// includes .. 3   (offset: 0x350)
// strings ... 2   (offset: 0x368)
// dev strs .. 0   (offset: 0x38c)
// exports ... 6   (offset: 0x164)
// cseg ...... 0x70 + 0xf4 (0x164)
// imports ... 9   (offset: 0x254)
// animtree1 . 0   (offset: 0x38c)
// animtree2 . 0   (offset: 0x38c)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\mp\magicbox;

#namespace namespace_e63da00c34c3caf9;

// Namespace namespace_e63da00c34c3caf9
// Params 0, eflags: 0x5
// Checksum 0x6ced09eb, Offset: 0x8e
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "crate_power", #"bgb", &__init__, undefined );
}

// Namespace namespace_e63da00c34c3caf9
// Params 0
// Checksum 0xf0e2be7e, Offset: 0xb3
// Size: 0x2a
function __init__()
{
    bgb::register( "crate_power", "event", &event, undefined, &disable );
    magicbox::register_upgrade_weapon( &upgrade_weapon );
}

// Namespace namespace_e63da00c34c3caf9
// Params 0
// Checksum 0x3b8520af, Offset: 0xe5
// Size: 0x33
function event()
{
    self endon( #"disconnect" );
    self endon( #"kill_crate_power" );
    self waittill( #"hash_a28ea66e48e08ef6" );
    bgb::function_b62ba460d1b3dac9( "crate_power" );
}

// Namespace namespace_e63da00c34c3caf9
// Params 0
// Checksum 0x8d6a373f, Offset: 0x120
// Size: 0xe
function disable()
{
    self notify( #"kill_crate_power" );
}

// Namespace namespace_e63da00c34c3caf9
// Params 1
// Checksum 0xb0d6310a, Offset: 0x136
// Size: 0x2d, Type: bool
function upgrade_weapon( player )
{
    if ( player bgb::is_enabled( "crate_power" ) )
    {
        player notify( #"hash_a28ea66e48e08ef6" );
        return true;
    }
    
    return false;
}

