// scripts\quaked\script_vehicle_t10_civ_lnd_dirt_bike.gsc  (hash_49343cad0bf013e6.gscc) (size: 716 Bytes / 0x2cc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb95e975e (3109984094)
// size ...... 716 (0x2cc)
// includes .. 2   (offset: 0x2b0)
// strings ... 1   (offset: 0x2c0)
// dev strs .. 0   (offset: 0x2cc)
// exports ... 4   (offset: 0x14c)
// cseg ...... 0x6a + 0xe2 (0x14c)
// imports ... 7   (offset: 0x1ec)
// animtree1 . 0   (offset: 0x2cc)
// animtree2 . 0   (offset: 0x2cc)
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace namespace_1646b3e6cd65adbc;

// Namespace namespace_1646b3e6cd65adbc
// Params 0, eflags: 0x5
// Checksum 0x26ae03aa, Offset: 0x88
// Size: 0x17
function private autoexec main()
{
    vehicle::register_vehicle_init( %"hash_1ffb8dc1bc638508", &dirt_bike_init );
}

// Namespace namespace_1646b3e6cd65adbc
// Params 0, eflags: 0x4
// Checksum 0x589aa9a3, Offset: 0xa7
// Size: 0x20
function private dirt_bike_init()
{
    utility::registersharedfunc( %"hash_1ffb8dc1bc638508", #"spawn", &function_4919dc74a72cac01 );
}

// Namespace namespace_1646b3e6cd65adbc
// Params 2, eflags: 0x4
// Checksum 0x118208ad, Offset: 0xcf
// Size: 0x7c
function private function_4919dc74a72cac01( spawndata, faildata )
{
    if ( self.classname == "script_vehicle" )
    {
        vehicle = vehicle::function_66838ba16389a6cd( %"hash_1ffb8dc1bc638508", spawndata, self );
    }
    else
    {
        vehicle = vehicle::default_spawn( %"hash_1ffb8dc1bc638508", spawndata, faildata );
    }
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle.var_e2f56f41c8d24c59 = 1;
    vehicle vehicle_allowplayerstandon( 0 );
    return vehicle;
}

