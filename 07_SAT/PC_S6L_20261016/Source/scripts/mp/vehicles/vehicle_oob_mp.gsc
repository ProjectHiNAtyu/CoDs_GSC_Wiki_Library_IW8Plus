// scripts\mp\vehicles\vehicle_oob_mp.gsc  (hash_5d65ff68246f4ebb.gscc) (size: 1385 Bytes / 0x569 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6db93bc3 (1840856003)
// size ...... 1385 (0x569)
// includes .. 3   (offset: 0x4f9)
// strings ... 2   (offset: 0x511)
// dev strs .. 5   (offset: 0x52d)
// exports ... 6   (offset: 0x2c1)
// cseg ...... 0x81 + 0x240 (0x2c1)
// imports ... 11  (offset: 0x3b1)
// animtree1 . 0   (offset: 0x569)
// animtree2 . 0   (offset: 0x569)
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\outofbounds;

#namespace vehicle_oob_mp;

// Namespace vehicle_oob_mp
// Params 2
// Checksum 0x1168c037, Offset: 0x9f
// Size: 0x37
function vehicle_oob_mp_registeroutoftimecallback( vehiclename, callback )
{
    leveldata = vehicle_oob_mp_getleveldata();
    leveldata.outoftimecallbacks[ vehiclename ] = callback;
}

// Namespace vehicle_oob_mp
// Params 0
// Checksum 0xc315c09f, Offset: 0xde
// Size: 0x90
function vehicle_oob_mp_init()
{
    assert( isdefined( level.vehicle ), "<dev string:x24>" );
    assert( !isdefined( level.vehicle.oob ), "<dev string:x58>" );
    leveldata = spawnstruct();
    leveldata.outoftimecallbacks = [];
    level.vehicle.oob = leveldata;
    outofbounds::registerooboutoftimecallback( "vehicle", &vehicle_oob_mp_outoftimecallback );
    outofbounds::registeroobclearcallback( "vehicle", &vehicle_oob_mp_clearcallback );
}

// Namespace vehicle_oob_mp
// Params 0
// Checksum 0x8005955b, Offset: 0x176
// Size: 0x4d
function vehicle_oob_mp_getleveldata()
{
    assert( isdefined( level.vehicle ), "<dev string:x8a>" );
    assert( isdefined( level.vehicle.oob ), "<dev string:xc6>" );
    return level.vehicle.oob;
}

// Namespace vehicle_oob_mp
// Params 2
// Checksum 0x9dffb07a, Offset: 0x1cc
// Size: 0x64
function vehicle_oob_mp_outoftimecallback( timeoutendnotify, clearnotify )
{
    leveldata = vehicle_oob_mp_getleveldata();
    callback = leveldata.outoftimecallbacks[ vehicle::get_ref() ];
    assert( isdefined( callback ), "<dev string:x109>" );
    self.dontspawnhusk = 1;
    self [[ callback ]]();
}

// Namespace vehicle_oob_mp
// Params 0
// Checksum 0x6d6d6e89, Offset: 0x238
// Size: 0x89
function vehicle_oob_mp_clearcallback()
{
    occupants = vehicle_occupancy::get_all_occupants( self );
    
    foreach ( occupant in occupants )
    {
        occupant setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

