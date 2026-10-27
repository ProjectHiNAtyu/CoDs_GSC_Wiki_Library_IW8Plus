// script_c2e6c025f67403  (hash_00c2e6c025f67403.gscc) (size: 1127 Bytes / 0x467 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x469e4cc0 (1184779456)
// size ...... 1127 (0x467)
// includes .. 4   (offset: 0x3ff)
// strings ... 4   (offset: 0x41f)
// dev strs .. 0   (offset: 0x467)
// exports ... 6   (offset: 0x1db)
// cseg ...... 0xb8 + 0x123 (0x1db)
// imports ... 11  (offset: 0x2cb)
// animtree1 . 0   (offset: 0x467)
// animtree2 . 0   (offset: 0x467)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\mp\common\utility\perk;

#namespace namespace_3057772af992a5d6;

// Namespace namespace_3057772af992a5d6
// Params 0, eflags: 0x5
// Checksum 0x8676bd12, Offset: 0xd6
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "arsenal_accelerator", #"bgb", &__init__, undefined );
}

// Namespace namespace_3057772af992a5d6
// Params 0
// Checksum 0x4c7e0897, Offset: 0xfb
// Size: 0x25
function __init__()
{
    namespace_6616340f3419ea2d::register( "arsenal_accelerator", "time", 300, &enable, &disable, &validation );
}

// Namespace namespace_3057772af992a5d6
// Params 0
// Checksum 0x813987bc, Offset: 0x128
// Size: 0x6c
function enable()
{
    perk::giveperk( "specialty_faster_field_upgrade" );
    
    if ( !isdefined( self.perktunables ) )
    {
        self.perktunables = spawnstruct();
    }
    
    if ( !isdefined( self.perktunables.perk_faster_field_upgrade_rate ) )
    {
        self.perktunables.perk_faster_field_upgrade_rate = 1.5;
    }
    
    val::set( "specialty_faster_field_upgrade", "field_upgrade_recharge_mult", 1.5 );
}

// Namespace namespace_3057772af992a5d6
// Params 0
// Checksum 0x8df7a738, Offset: 0x19c
// Size: 0x32
function disable()
{
    if ( isdefined( self.perks[ "specialty_faster_field_upgrade" ] ) )
    {
        perk::removeperk( "specialty_faster_field_upgrade" );
    }
    
    val::reset( "specialty_faster_field_upgrade", "field_upgrade_recharge_mult" );
}

// Namespace namespace_3057772af992a5d6
// Params 0
// Checksum 0xef3efecf, Offset: 0x1d6
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

