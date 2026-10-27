// script_6c28af156a9bc7e9  (hash_6c28af156a9bc7e9.gscc) (size: 1020 Bytes / 0x3fc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe8fc24e6 (3908838630)
// size ...... 1020 (0x3fc)
// includes .. 4   (offset: 0x3bc)
// strings ... 2   (offset: 0x3dc)
// dev strs .. 0   (offset: 0x3fc)
// exports ... 7   (offset: 0x170)
// cseg ...... 0x72 + 0xfe (0x170)
// imports ... 11  (offset: 0x288)
// animtree1 . 0   (offset: 0x3fc)
// animtree2 . 0   (offset: 0x3fc)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ammomods\ammo_mod;

#namespace zm_bgb_modified_chaos;

// Namespace zm_bgb_modified_chaos
// Params 0, eflags: 0x5
// Checksum 0x1ca4b042, Offset: 0x90
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "modified_chaos", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_modified_chaos
// Params 0
// Checksum 0xaf7c641b, Offset: 0xb5
// Size: 0x42
function __init__()
{
    bgb::register( "modified_chaos", "time", 60, &enable, &disable, &validation );
    utility::registersharedfunc( #"zombie", #"hash_67dba6baa6a33fb7", &function_c412074d9947af04 );
}

// Namespace zm_bgb_modified_chaos
// Params 0
// Checksum 0x4c07cab6, Offset: 0xff
// Size: 0x2
function enable()
{
    
}

// Namespace zm_bgb_modified_chaos
// Params 0
// Checksum 0xf0e24fd5, Offset: 0x109
// Size: 0x2
function disable()
{
    
}

// Namespace zm_bgb_modified_chaos
// Params 0
// Checksum 0xc59433de, Offset: 0x113
// Size: 0x22, Type: bool
function validation()
{
    w_current = self getcurrentweapon();
    
    if ( ammo_mod::has_ammo_mod( w_current ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_bgb_modified_chaos
// Params 2
// Checksum 0xc2c3fa65, Offset: 0x13e
// Size: 0x31
function function_c412074d9947af04( ammomodname, cooldown = 1 )
{
    if ( bgb::is_enabled( "modified_chaos" ) )
    {
        return 1;
    }
    
    return cooldown;
}

