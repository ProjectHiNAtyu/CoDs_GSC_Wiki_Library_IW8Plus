// scripts\common\vehicle_airdrop.gsc  (hash_120775574e054c2a.gscc) (size: 4960 Bytes / 0x1360 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb58ad21 (3411586337)
// size ...... 4960 (0x1360)
// includes .. 3   (offset: 0x12c8)
// strings ... 8   (offset: 0x12e0)
// dev strs .. 1   (offset: 0x1354)
// exports ... 8   (offset: 0xc80)
// cseg ...... 0xc8 + 0xbb8 (0xc80)
// imports ... 40  (offset: 0xdc0)
// animtree1 . 0   (offset: 0x1360)
// animtree2 . 0   (offset: 0x1360)
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace vehicle_airdrop;

// Namespace vehicle_airdrop
// Params 1
// Checksum 0xc1c34b51, Offset: 0xe6
// Size: 0x32, Type: bool
function can_airdrop( vehicleref )
{
    vehicledata = vehicle::get_data( vehicleref );
    return isdefined( vehicledata ) && isdefined( vehicledata.airdrop );
}

// Namespace vehicle_airdrop
// Params 1
// Checksum 0x8fb21ca2, Offset: 0x121
// Size: 0x1e
function get_data( vehicleref )
{
    return vehicle::get_data( vehicleref ).airdrop;
}

// Namespace vehicle_airdrop
// Params 3
// Checksum 0xd15a7271, Offset: 0x148
// Size: 0x4ef
function vehicle_airdrop( vehicleref, spawndata, faildata )
{
    if ( isstring( vehicleref ) && vehicle::has_data( vehicleref ) )
    {
        if ( level.projectbundle.var_53c4124af039142e )
        {
            if ( isdefined( vehicle::get_data( vehicleref ).vehicle ) )
            {
                vehicleref = vehicle::get_data( vehicleref ).vehicle;
            }
        }
        else if ( isdefined( vehicle::get_data( vehicleref ).bundlename ) )
        {
            vehicleref = vehicle::get_data( vehicleref ).bundlename;
        }
    }
    
    if ( isxhashasset( vehicleref ) )
    {
        spawndata.script_vehiclebundle = vehicleref;
    }
    
    vehicledata = vehicle::get_data( vehicleref );
    airdropdata = vehicledata.airdrop;
    
    if ( !isdefined( spawndata.spawnmethod ) )
    {
        spawndata.spawnmethod = "airdrop_at_position";
    }
    
    if ( !isdefined( spawndata.angles ) )
    {
        spawndata.angles = ( 0, 0, 0 );
    }
    
    if ( !isdefined( airdropdata ) || getdvarint( @"hash_21c06b663b91aa71", 1 ) == 0 )
    {
        assert( isdefined( airdropdata ), "<dev string:x24>" );
        
        if ( utility::issharedfuncdefined( vehicleref, #"spawnPostAirdrop" ) )
        {
            return [[ utility::getsharedfunc( vehicleref, #"spawnPostAirdrop" ) ]]( spawndata, faildata );
        }
        
        return vehicle::spawn( vehicleref, spawndata, faildata );
    }
    
    scenenode = { #angles:spawndata.angles, #origin:spawndata.origin };
    parachute = spawn( "script_model", spawndata.origin );
    parachute.angles = spawndata.angles;
    parachute.animname = "parachute";
    parachute setmodel( airdropdata.parachutemodel );
    parachute animation::setanimtree();
    parachute hide();
    carrier = spawn( "script_model", spawndata.origin );
    carrier.angles = spawndata.angles;
    carrier.animname = "ac130";
    carrier setmodel( airdropdata.planemodel );
    carrier animation::setanimtree();
    carrier hide();
    fakevehicle = spawn( "script_model", spawndata.origin );
    fakevehicle.angles = spawndata.angles;
    fakevehicle.animname = vehicledata.ref;
    model = vehicledata.model;
    
    if ( isdefined( spawndata.var_305ce2bb6ec0993d ) )
    {
        model = spawndata.var_305ce2bb6ec0993d + "::" + model;
    }
    
    fakevehicle setmodel( model );
    fakevehicle animation::setanimtree();
    fakevehicle hide();
    scenenode.vehicle = fakevehicle;
    scenenode.parachute = parachute;
    scenenode.carrier = carrier;
    scenenode.starttime = gettime() + level.frameduration;
    scenenode.endtime = gettime();
    scenenode.vehicleendtime = scenenode.starttime + getanimlength( level.scr_anim[ vehicledata.ref ][ airdropdata.scenename ] ) * 1000;
    
    if ( scenenode.vehicleendtime > scenenode.endtime )
    {
        scenenode.endtime = scenenode.vehicleendtime;
    }
    
    scenenode.parachuteendtime = scenenode.starttime + getanimlength( level.scr_anim[ "parachute" ][ airdropdata.scenename ] ) * 1000;
    
    if ( scenenode.parachuteendtime > scenenode.endtime )
    {
        scenenode.endtime = scenenode.parachuteendtime;
    }
    
    scenenode.carrierendtime = scenenode.starttime + getanimlength( level.scr_anim[ "ac130" ][ airdropdata.scenename ] ) * 1000;
    
    if ( scenenode.carrierendtime > scenenode.endtime )
    {
        scenenode.endtime = scenenode.carrierendtime;
    }
    
    scenenode thread play_anims( vehicleref, spawndata, faildata, airdropdata );
    spawndata waittill( #"spawn", vehicle );
    return vehicle;
}

// Namespace vehicle_airdrop
// Params 4, eflags: 0x4
// Checksum 0xdd179655, Offset: 0x640
// Size: 0x2b6
function private play_anims( vehicleref, spawndata, faildata, airdropdata )
{
    animation::anim_first_frame_solo( self.vehicle, airdropdata.scenename );
    animation::anim_first_frame_solo( self.parachute, airdropdata.scenename );
    animation::anim_first_frame_solo( self.carrier, airdropdata.scenename );
    waitframe();
    
    if ( isdefined( self.vehicle ) )
    {
        self.vehicle show();
        thread animation::anim_single_solo( self.vehicle, airdropdata.scenename );
    }
    
    if ( isdefined( self.parachute ) )
    {
        self.parachute show();
        thread animation::anim_single_solo( self.parachute, airdropdata.scenename );
    }
    
    if ( isdefined( self.carrier ) )
    {
        self.carrier show();
        self.carrier playloopsound( airdropdata.planesound );
        
        foreach ( part in airdropdata.planeparts )
        {
            self.carrier setscriptablepartstate( part.scriptablepart, "on", 0 );
        }
        
        thread animation::anim_single_solo( self.carrier, airdropdata.scenename );
    }
    
    while ( gettime() <= self.endtime )
    {
        if ( !isdefined( self.vehicle ) || gettime() >= self.vehicleendtime )
        {
            thread detach_vehicle( vehicleref, self.vehicle, spawndata, faildata, airdropdata );
        }
        
        if ( isdefined( self.parachute ) && gettime() >= self.parachuteendtime )
        {
            self.parachute delete();
        }
        
        if ( isdefined( self.carrier ) && gettime() >= self.carrierendtime )
        {
            self.carrier delete();
        }
        
        waitframe();
    }
    
    detach_vehicle( vehicleref, self.vehicle, spawndata, faildata, airdropdata );
    
    if ( isdefined( self.parachute ) )
    {
        self.parachute delete();
    }
    
    if ( isdefined( self.carrier ) )
    {
        self.carrier delete();
    }
}

// Namespace vehicle_airdrop
// Params 5
// Checksum 0x1a38e16b, Offset: 0x8fe
// Size: 0x1f1
function detach_vehicle( vehicleref, fakevehicle, spawndata, faildata, airdropdata )
{
    self.vehicle = undefined;
    
    if ( !isdefined( fakevehicle ) )
    {
        return;
    }
    
    originalorigin = spawndata.origin;
    originalangles = spawndata.angles;
    spawndata.origin = fakevehicle.origin;
    spawndata.angles = fakevehicle.angles;
    
    if ( isent( fakevehicle ) )
    {
        fakevehicle delete();
    }
    
    if ( utility::issharedfuncdefined( vehicleref, #"spawnPostAirdrop" ) )
    {
        vehicle = [[ utility::getsharedfunc( vehicleref, #"spawnPostAirdrop" ) ]]( spawndata, faildata );
    }
    else
    {
        vehicle = vehicle::spawn( vehicleref, spawndata, faildata );
    }
    
    vehicle.scenenode = self;
    spawndata.origin = originalorigin;
    spawndata.angles = originalangles;
    spawndata notify( #"spawn", vehicle );
    
    if ( isdefined( airdropdata.var_bd3e5377d361f765 ) )
    {
        ref = vehicle::get_data( vehicleref ).ref;
        endtime = gettime() + getanimlength( level.scr_anim[ ref ][ airdropdata.var_bd3e5377d361f765 ] ) * 1000;
        
        if ( endtime > self.endtime )
        {
            self.endtime = endtime;
        }
        
        vehicle.var_300686ebe3a78e39 = 1;
        vehicle.animname = ref;
        vehicle vehphys_forcekeyframedmotion();
        thread animation::anim_single_solo( vehicle, airdropdata.var_bd3e5377d361f765 );
        
        while ( gettime() <= endtime )
        {
            waitframe();
        }
        
        vehicle vehphys_setdefaultmotion();
    }
    
    vehicle thread start_free_fall( airdropdata );
}

// Namespace vehicle_airdrop
// Params 1, eflags: 0x4
// Checksum 0x6491189b, Offset: 0xaf7
// Size: 0xbe
function private start_free_fall( airdropdata )
{
    self endon( #"death" );
    self notify( #"freefall" );
    self.var_300686ebe3a78e39 = 1;
    playsoundatpos( self.origin, airdropdata.var_51c964b5d5b988b1 );
    waitframe();
    endtime = gettime() + 3000;
    
    while ( gettime() < endtime && !self vehicle_isonground() )
    {
        waitframe();
    }
    
    origin = self.origin;
    
    if ( self tagexists( "tag_origin_static" ) )
    {
        origin = self gettagorigin( "tag_origin_static" );
    }
    
    land( airdropdata, origin, self.angles );
    self.var_300686ebe3a78e39 = undefined;
}

// Namespace vehicle_airdrop
// Params 3, eflags: 0x4
// Checksum 0xd7fc9485, Offset: 0xbbd
// Size: 0xc3
function private land( airdropdata, position, angles )
{
    playfx( airdropdata.effect, position, anglestoforward( angles ) );
    playsoundatpos( position, airdropdata.var_4ec2c10aa7105d86 );
    earthquake( airdropdata.earthquakescale, airdropdata.earthquakeduration, position, airdropdata.earthquakeradius );
    playrumbleonposition( "grenade_rumble", position );
    physicsexplosionsphere( position, airdropdata.physicsouterradius, airdropdata.physicsinnerradius, airdropdata.physicsscale );
    self vehphys_parkingbrake( 1 );
    self.landed = 1;
    self notify( #"landed" );
}

