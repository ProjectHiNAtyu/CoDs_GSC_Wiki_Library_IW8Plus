// script_7e730253b8d999ef  (hash_7e730253b8d999ef.gscc) (size: 1244 Bytes / 0x4dc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb236ddf5 (2989940213)
// size ...... 1244 (0x4dc)
// includes .. 5   (offset: 0x474)
// strings ... 4   (offset: 0x49c)
// dev strs .. 0   (offset: 0x4dc)
// exports ... 7   (offset: 0x1d0)
// cseg ...... 0x98 + 0x138 (0x1d0)
// imports ... 14  (offset: 0x2e8)
// animtree1 . 0   (offset: 0x4dc)
// animtree2 . 0   (offset: 0x4dc)
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\zombie_perks;

#namespace namespace_93166d4522738a42;

// Namespace namespace_93166d4522738a42
// Params 0, eflags: 0x5
// Checksum 0xf7eadbbf, Offset: 0xb6
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "soda_fountain", #"bgb", &__init__, undefined );
}

// Namespace namespace_93166d4522738a42
// Params 0
// Checksum 0xa1d63f73, Offset: 0xdb
// Size: 0x24
function __init__()
{
    bgb::register( "soda_fountain", "event", &event, undefined, &disable, &validation, undefined );
}

// Namespace namespace_93166d4522738a42
// Params 0
// Checksum 0x676a46cc, Offset: 0x107
// Size: 0x38
function event()
{
    self endon( #"disconnect" );
    self endon( #"kill_soda_fountain" );
    callback::add( "zm_perk_purchased", &on_perk_purchased );
    self waittill( #"soda_fountain_purchased" );
}

// Namespace namespace_93166d4522738a42
// Params 0
// Checksum 0xa6f21bef, Offset: 0x147
// Size: 0xe
function disable()
{
    self notify( #"kill_soda_fountain" );
}

// Namespace namespace_93166d4522738a42
// Params 0
// Checksum 0x451b6251, Offset: 0x15d
// Size: 0xf, Type: bool
function validation()
{
    if ( zombie_perks::function_cda78d45986a51a0() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_93166d4522738a42
// Params 1
// Checksum 0xac925afa, Offset: 0x175
// Size: 0x5b
function on_perk_purchased( sparams )
{
    if ( bgb::is_enabled( "soda_fountain" ) )
    {
        bgb::function_b62ba460d1b3dac9( "soda_fountain" );
        utility::waittill_notify_or_timeout( "perk_acquired", 0.1 );
        zombie_perks::function_ab9b4123275d6153();
        callback::remove( "zm_perk_purchased", &on_perk_purchased );
        self notify( #"soda_fountain_purchased" );
    }
}

