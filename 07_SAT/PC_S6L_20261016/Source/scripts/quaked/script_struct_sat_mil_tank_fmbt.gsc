// scripts\quaked\script_struct_sat_mil_tank_fmbt.gsc  (hash_354d05f84aaf7594.gscc) (size: 1249 Bytes / 0x4e1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57ab465d (1470842461)
// size ...... 1249 (0x4e1)
// includes .. 2   (offset: 0x4a5)
// strings ... 2   (offset: 0x4b5)
// dev strs .. 1   (offset: 0x4d5)
// exports ... 5   (offset: 0x21d)
// cseg ...... 0x76 + 0x1a7 (0x21d)
// imports ... 16  (offset: 0x2e5)
// animtree1 . 0   (offset: 0x4e1)
// animtree2 . 0   (offset: 0x4e1)
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace namespace_b6f16a9deda62c88;

// Namespace namespace_b6f16a9deda62c88
// Params 0, eflags: 0x5
// Checksum 0x2cb98c35, Offset: 0x94
// Size: 0x17
function private autoexec main()
{
    vehicle::register_vehicle_init( %"hash_5efdddfa8f702be2", &fmbt_init );
}

// Namespace namespace_b6f16a9deda62c88
// Params 0
// Checksum 0xd1cf677d, Offset: 0xb3
// Size: 0x44
function fmbt_init()
{
    if ( !vehicle::should_init( %"hash_5efdddfa8f702be2" ) )
    {
        return;
    }
    
    vehicle::generic_init( %"hash_5efdddfa8f702be2" );
    utility::registersharedfunc( %"hash_5efdddfa8f702be2", #"spawn", &fmbt_spawn );
}

// Namespace namespace_b6f16a9deda62c88
// Params 2
// Checksum 0x653d0841, Offset: 0xff
// Size: 0xe0
function fmbt_spawn( spawndata, faildata )
{
    vehicle = vehicle::default_spawn( %"hash_5efdddfa8f702be2", spawndata, faildata );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    println( "<dev string:x24>" );
    collisionlocation = vehicle gettagorigin( "tag_turret" );
    collisionangles = vehicle gettagangles( "tag_turret" );
    collision = spawn( "script_model", collisionlocation );
    collision.angles = collisionangles;
    collision setmodel( %"hash_165b8e083edf99fb" );
    collision linkto( vehicle, "tag_turret" );
    collision.parent = vehicle;
    collision hideallparts();
    vehicle.turretcollision = collision;
    vehicle thread function_d041234dab436269();
    return vehicle;
}

// Namespace namespace_b6f16a9deda62c88
// Params 0, eflags: 0x4
// Checksum 0xbb0998d8, Offset: 0x1e8
// Size: 0x35
function private function_d041234dab436269()
{
    level endon( #"game_ended" );
    self endon( #"vehicle_deleted" );
    self waittill( #"death" );
    self.turretcollision delete();
}

