// script_39a93ed3a292d09c  (hash_39a93ed3a292d09c.gscc) (size: 874 Bytes / 0x36a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x371ddf45 (924704581)
// size ...... 874 (0x36a)
// includes .. 4   (offset: 0x32e)
// strings ... 2   (offset: 0x34e)
// dev strs .. 0   (offset: 0x36a)
// exports ... 4   (offset: 0x1ae)
// cseg ...... 0x85 + 0x129 (0x1ae)
// imports ... 8   (offset: 0x24e)
// animtree1 . 0   (offset: 0x36a)
// animtree2 . 0   (offset: 0x36a)
#using script_31ee2a173f3499b7;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace namespace_33e886a9a5b55137;

// Namespace namespace_33e886a9a5b55137
// Params 0, eflags: 0x5
// Checksum 0xa5a924a6, Offset: 0xa3
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_ebc38a2707aa7210", #"ztron_item", undefined, &init );
}

// Namespace namespace_33e886a9a5b55137
// Params 0
// Checksum 0x30d03865, Offset: 0xcc
// Size: 0x31
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"vehicle_fuel", #"use", &function_3eb1816981e3e53 );
    ztron_sound::function_4ac735395b173fe( "vehicle_fuel", "evt_ztron_veh_refuel_bell" );
}

// Namespace namespace_33e886a9a5b55137
// Params 1, eflags: 0x4
// Checksum 0xaf68fded, Offset: 0x105
// Size: 0xa9
function private function_3eb1816981e3e53( params )
{
    owner = params.player;
    owner ztron_sound::ztron_playsound( "vehicle_fuel" );
    vehicle = owner.ztron.vehicle;
    
    if ( isdefined( vehicle.fuel ) )
    {
        vehicle.fuel += 100;
        vehicle.fuel = clamp( vehicle.fuel, 0, vehicle.maxfuel );
        owner ztron_ui::function_76bcd958c9d09b8c();
    }
}

