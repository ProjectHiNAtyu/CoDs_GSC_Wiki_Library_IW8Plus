// scripts\mp\ftue\utility\ftue_vehicles.gsc  (hash_27af1dac0930f28e.gscc) (size: 4605 Bytes / 0x11fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb0654bdb (2959428571)
// size ...... 4605 (0x11fd)
// includes .. 3   (offset: 0x110d)
// strings ... 6   (offset: 0x1125)
// dev strs .. 10  (offset: 0x1185)
// exports ... 20  (offset: 0x979)
// cseg ...... 0xdc + 0x89d (0x979)
// imports ... 36  (offset: 0xc99)
// animtree1 . 0   (offset: 0x11fd)
// animtree2 . 0   (offset: 0x11fd)
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;

#namespace ftue_vehicles;

// Namespace ftue_vehicles
// Params 1
// Checksum 0xc23b1f36, Offset: 0xfa
// Size: 0x86
function function_1c71ac87e3897bdb( vehicles )
{
    if ( !isdefined( vehicles ) )
    {
        return;
    }
    
    foreach ( vehicle in vehicles )
    {
        function_6b4b71332b2587ca( vehicle );
    }
}

// Namespace ftue_vehicles
// Params 1
// Checksum 0x62f1caa2, Offset: 0x188
// Size: 0x13c
function function_6b4b71332b2587ca( vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    if ( isdefined( vehicle.spawnfunction ) && isdefined( vehicle.spawnposition ) && isdefined( vehicle.spawnrotation ) )
    {
        vehicle.vehicleentity = [[ vehicle.spawnfunction ]]( vehicle.spawnposition, vehicle.spawnrotation );
    }
    
    if ( isdefined( vehicle.vehicleentity ) )
    {
        if ( isdefined( vehicle.spawndestroyed ) )
        {
            vehicle.vehicleentity function_6b72156a7d62a1db();
        }
        
        if ( isdefined( vehicle.initialdamage ) )
        {
            vehicle.vehicleentity dodamage( vehicle.vehicleentity.health * vehicle.initialdamage, vehicle.spawnposition );
        }
        
        if ( isdefined( vehicle.vfxdata ) )
        {
            vehicle.vfx = spawnscriptable( vehicle.vfxdata[ 0 ], vehicle.vfxdata[ 1 ], vehicle.vfxdata[ 2 ] );
        }
        
        vehicle thread function_5dbdba256b4390f9();
    }
}

// Namespace ftue_vehicles
// Params 0, eflags: 0x4
// Checksum 0x1b0a8b72, Offset: 0x2cc
// Size: 0x43
function private function_5dbdba256b4390f9()
{
    while ( isdefined( self.vehicleentity ) )
    {
        wait 1;
    }
    
    if ( isdefined( self.vfx ) )
    {
        self.vfx.origin = ( 0, 0, 0 );
    }
}

// Namespace ftue_vehicles
// Params 2
// Checksum 0x683b47a2, Offset: 0x317
// Size: 0x93
function function_d768b4001856b5cf( position, rotation )
{
    if ( !vehicle::is_loaded( "atv" ) )
    {
        println( "<dev string:x24>" );
        return;
    }
    
    println( "<dev string:x37>" );
    spawndata = spawnstruct();
    faildata = spawnstruct();
    spawndata.origin = position;
    spawndata.angles = rotation;
    vehicle = vehicle::spawn( "atv", spawndata, faildata );
    return vehicle;
}

// Namespace ftue_vehicles
// Params 2
// Checksum 0xdae3d2e2, Offset: 0x3b3
// Size: 0x93
function function_fa63e379a88891c5( position, rotation )
{
    if ( !vehicle::is_loaded( "little_bird" ) )
    {
        println( "<dev string:x45>" );
        return;
    }
    
    println( "<dev string:x57>" );
    spawndata = spawnstruct();
    faildata = spawnstruct();
    spawndata.origin = position;
    spawndata.angles = rotation;
    vehicle = vehicle::spawn( "little_bird", spawndata, faildata );
    return vehicle;
}

// Namespace ftue_vehicles
// Params 2
// Checksum 0x9c2d8dbe, Offset: 0x44f
// Size: 0x93
function function_ca3d501699df433a( position, rotation )
{
    if ( !vehicle::is_loaded( "tac_rover" ) )
    {
        println( "<dev string:x64>" );
        return;
    }
    
    println( "<dev string:x7d>" );
    spawndata = spawnstruct();
    faildata = spawnstruct();
    spawndata.origin = position;
    spawndata.angles = rotation;
    vehicle = vehicle::spawn( "tac_rover", spawndata, faildata );
    return vehicle;
}

// Namespace ftue_vehicles
// Params 2
// Checksum 0x3ccddb0f, Offset: 0x4eb
// Size: 0x93
function function_a110eec9c052ad79( position, rotation )
{
    if ( !vehicle::is_loaded( "veh9_mil_cargo_truck" ) )
    {
        println( "<dev string:x91>" );
        return;
    }
    
    println( "<dev string:xac>" );
    spawndata = spawnstruct();
    faildata = spawnstruct();
    spawndata.origin = position;
    spawndata.angles = rotation;
    vehicle = vehicle::spawn( "veh9_mil_cargo_truck", spawndata, faildata );
    return vehicle;
}

// Namespace ftue_vehicles
// Params 2
// Checksum 0xdf281a3e, Offset: 0x587
// Size: 0x93
function function_9f2df602bfd047a1( position, rotation )
{
    if ( !vehicle::is_loaded( "veh9_suv_1996" ) )
    {
        println( "<dev string:xc2>" );
        return;
    }
    
    println( "<dev string:xda>" );
    spawndata = spawnstruct();
    faildata = spawnstruct();
    spawndata.origin = position;
    spawndata.angles = rotation;
    vehicle = vehicle::spawn( "veh9_suv_1996", spawndata, faildata );
    return vehicle;
}

// Namespace ftue_vehicles
// Params 5
// Checksum 0x2d9745a7, Offset: 0x623
// Size: 0x87
function function_c1701d2d1b46b2ac( position, speed, acceleration, yaw, hovering )
{
    if ( !( isdefined( self ) && isdefined( position ) && isdefined( speed ) && isdefined( acceleration ) ) )
    {
        return;
    }
    
    self vehicle_turnengineon();
    self vehicle_setspeed( speed, acceleration );
    
    if ( isdefined( hovering ) )
    {
        self sethoverparams( hovering[ 0 ], hovering[ 1 ], hovering[ 2 ] );
    }
    
    self setvehgoalpos( position, 1 );
    
    if ( isdefined( yaw ) )
    {
        self setgoalyaw( yaw );
    }
}

// Namespace ftue_vehicles
// Params 1
// Checksum 0x133cfbbe, Offset: 0x6b2
// Size: 0x37
function function_6b72156a7d62a1db( callback )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self dodamage( self.health, self.origin );
    
    if ( isdefined( callback ) )
    {
        self thread [[ callback ]]();
    }
}

// Namespace ftue_vehicles
// Params 1
// Checksum 0xcfdba493, Offset: 0x6f1
// Size: 0x1c
function function_92f94cce3bbb7327( callback )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    thread function_61192e318001d9c9( callback );
}

// Namespace ftue_vehicles
// Params 1, eflags: 0x4
// Checksum 0x8dc4b08c, Offset: 0x715
// Size: 0x3d
function private function_61192e318001d9c9( callback )
{
    initialhealth = self.health;
    
    while ( self.health >= initialhealth )
    {
        waitframe();
    }
    
    function_6b72156a7d62a1db( callback );
}

// Namespace ftue_vehicles
// Params 2
// Checksum 0x7007d7d, Offset: 0x75a
// Size: 0x26
function function_fd33d671ed5ae45b( position, speed )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    thread function_3ddae5081ae3f475( position, speed );
}

// Namespace ftue_vehicles
// Params 2, eflags: 0x4
// Checksum 0xda3db15d, Offset: 0x788
// Size: 0x78
function private function_3ddae5081ae3f475( position, speed = 40 )
{
    if ( self vehicle_isphysveh() )
    {
        self vehphys_crash();
    }
    
    self vehicle_setspeed( speed, 15, 10 );
    self setvehgoalpos( position, 0 );
    
    if ( soundexists( "hind_helicopter_dying_loop" ) )
    {
        self playloopsound( "hind_helicopter_dying_loop" );
    }
    
    thread function_4eb538cf26587a34();
    self waittill( #"death" );
    self notify( #"vehicle_crashdone" );
}

// Namespace ftue_vehicles
// Params 0, eflags: 0x4
// Checksum 0x8e54b9db, Offset: 0x808
// Size: 0x64
function private function_4eb538cf26587a34()
{
    self endon( #"vehicle_crashdone" );
    self clearlookatent();
    self setmaxpitchroll( 60, 90 );
    self setyawspeed( 700, 200, 200 );
    
    for ( ;; )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        irand = randomintrange( 140, 170 );
        self settargetyaw( self.angles[ 1 ] + irand );
        wait 0.5;
    }
}

// Namespace ftue_vehicles
// Params 1
// Checksum 0x5d5ba500, Offset: 0x874
// Size: 0x1f
function function_441683b10aa68b57( vehicle )
{
    assert( isdefined( vehicle ) );
    return vehicle_occupancy::get_driver( vehicle );
}

// Namespace ftue_vehicles
// Params 1
// Checksum 0x60197ba0, Offset: 0x89c
// Size: 0x8b
function function_f683c144c21c87eb( modifier )
{
    if ( !isdefined( self ) || !vehicle::is_vehicle() )
    {
        return;
    }
    
    switch ( modifier )
    {
        case #"hash_bdb6392e8750d9b0":
            vehicle_damage::set_pre_mod_damage_callback( vehicle::get_ref(), &function_7e0c28ef68326b53 );
            break;
        case #"hash_db653a4972b3c13b":
            vehicle_damage::set_pre_mod_damage_callback( vehicle::get_ref(), &function_28d76e737729e584 );
            break;
        default:
            vehicle_damage::set_pre_mod_damage_callback( vehicle::get_ref(), &function_28d76e737729e584 );
            break;
    }
}

// Namespace ftue_vehicles
// Params 1
// Checksum 0x6fcda852, Offset: 0x92f
// Size: 0x33, Type: bool
function function_7e0c28ef68326b53( data )
{
    if ( data.inflictor == level.player )
    {
        data.damage = 0;
    }
    
    return true;
}

// Namespace ftue_vehicles
// Params 1
// Checksum 0x6facc138, Offset: 0x96b
// Size: 0xd, Type: bool
function function_28d76e737729e584( data )
{
    return false;
}

