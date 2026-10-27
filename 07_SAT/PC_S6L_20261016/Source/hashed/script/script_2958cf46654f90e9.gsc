// script_2958cf46654f90e9  (hash_2958cf46654f90e9.gscc) (size: 893 Bytes / 0x37d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x71cd718a (1909289354)
// size ...... 893 (0x37d)
// includes .. 3   (offset: 0x349)
// strings ... 2   (offset: 0x361)
// dev strs .. 0   (offset: 0x37d)
// exports ... 7   (offset: 0x131)
// cseg ...... 0x7a + 0xb7 (0x131)
// imports ... 9   (offset: 0x249)
// animtree1 . 0   (offset: 0x37d)
// animtree2 . 0   (offset: 0x37d)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\mp\wallbuy;

#namespace namespace_ded2d35ac5e891d4;

// Namespace namespace_ded2d35ac5e891d4
// Params 0, eflags: 0x5
// Checksum 0xf6925dcd, Offset: 0x98
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "wall_to_wall_clearance", #"bgb", &__init__, undefined );
}

// Namespace namespace_ded2d35ac5e891d4
// Params 0
// Checksum 0x3c9ae97a, Offset: 0xbd
// Size: 0x24
function __init__()
{
    bgb::register( "wall_to_wall_clearance", "time", 30, &enable, &disable, &validation );
}

// Namespace namespace_ded2d35ac5e891d4
// Params 0
// Checksum 0x4fa13e70, Offset: 0xe9
// Size: 0xe
function enable()
{
    namespace_a2d5c07a0ea12ae::register_player_weapon_cost_override( &override_wallbuy_cost );
}

// Namespace namespace_ded2d35ac5e891d4
// Params 0
// Checksum 0x9651582c, Offset: 0xff
// Size: 0xe
function disable()
{
    namespace_a2d5c07a0ea12ae::function_e123b2e2d54943a8( &override_wallbuy_cost );
}

// Namespace namespace_ded2d35ac5e891d4
// Params 0
// Checksum 0xd344cacd, Offset: 0x115
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

// Namespace namespace_ded2d35ac5e891d4
// Params 1
// Checksum 0xaab5ec1, Offset: 0x122
// Size: 0xe
function override_wallbuy_cost( var_a55bab15779256e2 )
{
    return 10;
}

