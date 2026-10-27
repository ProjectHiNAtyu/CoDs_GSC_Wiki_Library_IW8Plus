// scripts\mp\vehicles\vehicle_spawn_mp.gsc  (hash_36b297f0d12a223a.gscc) (size: 564 Bytes / 0x234 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3abf6adf (985623263)
// size ...... 564 (0x234)
// includes .. 1   (offset: 0x214)
// strings ... 2   (offset: 0x21c)
// dev strs .. 0   (offset: 0x234)
// exports ... 3   (offset: 0x110)
// cseg ...... 0x79 + 0x97 (0x110)
// imports ... 5   (offset: 0x188)
// animtree1 . 0   (offset: 0x234)
// animtree2 . 0   (offset: 0x234)
#using scripts\common\utility;

#namespace vehicle_spawn_mp;

// Namespace vehicle_spawn_mp
// Params 0
// Checksum 0x99ea0409, Offset: 0x97
// Size: 0x20
function vehicle_spawn_mp_init()
{
    utility::registersharedfunc( #"vehicle_spawn", #"canspawnvehicle", &vehicle_spawn_mp_canspawnvehicle );
}

// Namespace vehicle_spawn_mp
// Params 3
// Checksum 0x9854a32c, Offset: 0xbf
// Size: 0x50, Type: bool
function vehicle_spawn_mp_canspawnvehicle( vehicleref, owner, team )
{
    if ( !getmatchrulesdata( "commonOption", "allowVehicles" ) )
    {
        return false;
    }
    
    if ( getdvarint( hashcat( @"hash_e4fa5e1677f011e4", vehicleref ), 1 ) == 0 )
    {
        return false;
    }
    
    return true;
}

