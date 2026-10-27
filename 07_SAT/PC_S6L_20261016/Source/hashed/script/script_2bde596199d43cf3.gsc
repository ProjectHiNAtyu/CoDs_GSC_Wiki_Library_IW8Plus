// script_2bde596199d43cf3  (hash_2bde596199d43cf3.gscc) (size: 907 Bytes / 0x38b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe11a8595 (3776611733)
// size ...... 907 (0x38b)
// includes .. 3   (offset: 0x34f)
// strings ... 2   (offset: 0x367)
// dev strs .. 0   (offset: 0x38b)
// exports ... 6   (offset: 0x163)
// cseg ...... 0x6f + 0xf4 (0x163)
// imports ... 9   (offset: 0x253)
// animtree1 . 0   (offset: 0x38b)
// animtree2 . 0   (offset: 0x38b)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\mp\wallbuy;

#namespace namespace_72c943209a0510e6;

// Namespace namespace_72c943209a0510e6
// Params 0, eflags: 0x5
// Checksum 0xb6a1f044, Offset: 0x8d
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "wall_power", #"bgb", &__init__, undefined );
}

// Namespace namespace_72c943209a0510e6
// Params 0
// Checksum 0x790d15f6, Offset: 0xb2
// Size: 0x2a
function __init__()
{
    bgb::register( "wall_power", "event", &event, undefined, &disable );
    namespace_a2d5c07a0ea12ae::register_upgrade_weapon( &wall_power_upgrade_weapon );
}

// Namespace namespace_72c943209a0510e6
// Params 0
// Checksum 0xf5747256, Offset: 0xe4
// Size: 0x33
function event()
{
    self endon( #"disconnect" );
    self endon( #"kill_wall_power" );
    self waittill( #"hash_1ca3f9339b98b409" );
    bgb::function_b62ba460d1b3dac9( "wall_power" );
}

// Namespace namespace_72c943209a0510e6
// Params 0
// Checksum 0xd37d293, Offset: 0x11f
// Size: 0xe
function disable()
{
    self notify( #"kill_wall_power" );
}

// Namespace namespace_72c943209a0510e6
// Params 1
// Checksum 0x3541a498, Offset: 0x135
// Size: 0x2d, Type: bool
function wall_power_upgrade_weapon( player )
{
    if ( player bgb::is_enabled( "wall_power" ) )
    {
        player notify( #"hash_1ca3f9339b98b409" );
        return true;
    }
    
    return false;
}

