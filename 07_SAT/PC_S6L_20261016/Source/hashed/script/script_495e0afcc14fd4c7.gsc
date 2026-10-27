// script_495e0afcc14fd4c7  (hash_495e0afcc14fd4c7.gscc) (size: 994 Bytes / 0x3e2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x65e765e4 (1709663716)
// size ...... 994 (0x3e2)
// includes .. 3   (offset: 0x3ae)
// strings ... 2   (offset: 0x3c6)
// dev strs .. 0   (offset: 0x3e2)
// exports ... 7   (offset: 0x19a)
// cseg ...... 0x6e + 0x12c (0x19a)
// imports ... 9   (offset: 0x2b2)
// animtree1 . 0   (offset: 0x3e2)
// animtree2 . 0   (offset: 0x3e2)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\mp\armor;

#namespace namespace_79a0d6920f7c6e7a;

// Namespace namespace_79a0d6920f7c6e7a
// Params 0, eflags: 0x5
// Checksum 0x23d88ed8, Offset: 0x8c
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "shields_up", #"bgb", &__init__, undefined );
}

// Namespace namespace_79a0d6920f7c6e7a
// Params 0
// Checksum 0xe9d03ac5, Offset: 0xb1
// Size: 0x24
function __init__()
{
    bgb::register( "shields_up", "time", 180, &enable, &disable, &validation );
}

// Namespace namespace_79a0d6920f7c6e7a
// Params 0
// Checksum 0xd0db4dd9, Offset: 0xdd
// Size: 0x55
function enable()
{
    self.var_a48163c16d11e1b1 = &function_a01280595b8b126f;
    owns_armor = isdefined( self.armorhealth ) && self.maxarmorhealth > 0;
    
    if ( owns_armor && !armor::has_full_armor() )
    {
        armor::repair_armor( self.maxarmorhealth );
    }
}

// Namespace namespace_79a0d6920f7c6e7a
// Params 0
// Checksum 0x8623cf43, Offset: 0x13a
// Size: 0xc
function disable()
{
    self.var_a48163c16d11e1b1 = undefined;
}

// Namespace namespace_79a0d6920f7c6e7a
// Params 0
// Checksum 0x4255df70, Offset: 0x14e
// Size: 0x1c, Type: bool
function validation()
{
    if ( level.zm_mode_modifiers.var_2dc492758425fa76 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_79a0d6920f7c6e7a
// Params 3
// Checksum 0x97cfb650, Offset: 0x173
// Size: 0x26
function function_a01280595b8b126f( damage, eattacker, smeansofdeath )
{
    return damage * 0.5;
}

