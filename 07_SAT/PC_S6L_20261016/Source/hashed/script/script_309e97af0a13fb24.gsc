// script_309e97af0a13fb24  (hash_309e97af0a13fb24.gscc) (size: 5555 Bytes / 0x15b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x90d0ab3 (151849651)
// size ...... 5555 (0x15b3)
// includes .. 5   (offset: 0x1537)
// strings ... 6   (offset: 0x155f)
// dev strs .. 1   (offset: 0x15a7)
// exports ... 14  (offset: 0xd53)
// cseg ...... 0xb1 + 0xca2 (0xd53)
// imports ... 49  (offset: 0xf83)
// animtree1 . 0   (offset: 0x15b3)
// animtree2 . 0   (offset: 0x15b3)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\airdrop_scriptbundle;

#namespace namespace_e137f55124338968;

// Namespace namespace_e137f55124338968
// Params 0, eflags: 0x5
// Checksum 0x59fb11e1, Offset: 0xcf
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_7bed02019e6c9db3", #"airdrop_scriptbundle", &pre_main, undefined );
}

// Namespace namespace_e137f55124338968
// Params 0, eflags: 0x4
// Checksum 0x7063cb06, Offset: 0xf8
// Size: 0xcf
function private pre_main()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    utility::registersharedfunc( #"can_airdrop_package", #"vehicle", &cancreatevehicle );
    utility::registersharedfunc( #"hash_c0543f4480543c68", #"vehicle", &createvehicle );
    utility::registersharedfunc( #"hash_270838ed4fd5716e", #"vehicle", &function_a3e10cb868818fa8 );
    
    /#
        utility::registersharedfunc( #"hash_957e5882bc1fa7c5", #"vehicle", &debug_deleteall );
        utility::registersharedfunc( #"hash_da0b3038771ec485", #"vehicle", &debug_drawlocations );
    #/
    
    callback::add( #"hash_e6c52cbe24abf037", &function_badc6b37e81a3292 );
    thread function_d6cdbfafaf8f329d();
}

// Namespace namespace_e137f55124338968
// Params 1, eflags: 0x4
// Checksum 0x75976b56, Offset: 0x1cf
// Size: 0xf0
function private function_a3e10cb868818fa8( airdropsettings )
{
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    vehicleref = packagesettings.vehicle;
    
    if ( !isdefined( vehicleref ) )
    {
        return;
    }
    
    if ( level.projectbundle.var_53c4124af039142e )
    {
        assert( !isxhashasset( vehicleref ), "<dev string:x24>" );
        
        if ( !vehicle::has_data( vehicleref ) )
        {
            vehicle::generic_init( vehicleref );
        }
        
        hybrid = function_568f797e7642c672( "vehicle", vehicleref );
        airdropsettings.vehicleref = hybrid.bundle.ref;
        return;
    }
    
    airdropsettings.vehicleref = vehicleref;
}

// Namespace namespace_e137f55124338968
// Params 0, eflags: 0x4
// Checksum 0x765a4aef, Offset: 0x2c7
// Size: 0x2a, Type: bool
function private cancreatevehicle()
{
    return level.package_airdrop.activevehicles.size < level.package_airdrop.var_c2589d35bd6eef07;
}

// Namespace namespace_e137f55124338968
// Params 6, eflags: 0x4
// Checksum 0xc86afbf7, Offset: 0x2fa
// Size: 0x2c4
function private createvehicle( airdropsettings, position, destination, angles, initialvelocity = undefined, var_e9a9d186782e327b = 1 )
{
    profilestart();
    var_9ae4b3950522d64e = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ];
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    spawndata = { #showheadicon:packagesettings.var_43d2b221d9148ad4, #spawntype:"GAME_MODE", #angles:angles ?? utility::randomvectorrange( packagesettings.var_fd22a4c72bf7eec3, packagesettings.var_fd459ac72c1e207d ), #origin:position };
    vehicle = vehicle::spawn( var_9ae4b3950522d64e.vehicleref, spawndata );
    
    if ( !isdefined( vehicle ) )
    {
        profilestop();
        return;
    }
    
    vehicle.airdropsettings = airdropsettings;
    
    if ( !var_e9a9d186782e327b )
    {
        vehicle vehphys_forcekeyframedmotion();
        vehicle.var_fe2a17068a3c0fa6 = &function_4cf5ab8f4ac304ce;
        vehicle.var_2e302f3dfd4df090 = destination;
        vehicle.var_fc294d70bf464363 = initialvelocity;
    }
    else if ( packagesettings.useparachute )
    {
        vehicle.var_c31e57afa9361a26 = initialvelocity;
        vehicle vehphys_forcekeyframedmotion();
        vehicle thread function_488647245d770afd( airdropsettings, destination );
    }
    else if ( initialvelocity )
    {
        vehicle vehicle_setvelocity( initialvelocity );
        vehicle thread function_db7c7c16eb55b911( airdropsettings );
    }
    else
    {
        var_6fa2e853c7a59cff = utility::randomvectorrange( packagesettings.var_c336f10e174b7863, packagesettings.var_c35ae70e1773dd1d );
        randomimpulse = utility::randomvectorrangeflat( packagesettings.var_bc92f2b225b0cb8a, packagesettings.var_bcb5fcb225d72940 );
        vehicle vehphys_force( randomimpulse, vehicle.origin + var_6fa2e853c7a59cff, 2 );
        vehicle thread function_db7c7c16eb55b911( airdropsettings );
    }
    
    vehicle thread airdrop_scriptbundle::function_4c121ea2c29854e8( airdropsettings );
    var_9ae4b3950522d64e = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ];
    vehicle airdrop_scriptbundle::function_e9dbf2aaef9f1c96( airdropsettings, #"hash_f35f0e2b6123474f", airdropsettings );
    vehicle airdrop_scriptbundle::function_e9dbf2aaef9f1c96( airdropsettings, #"hash_22c31697cc6f93d3", airdropsettings );
    level.package_airdrop.activevehicles[ level.package_airdrop.activevehicles.size ] = vehicle;
    profilestop();
    return vehicle;
}

// Namespace namespace_e137f55124338968
// Params 0, eflags: 0x4
// Checksum 0x8ffef673, Offset: 0x5c8
// Size: 0x156
function private function_4cf5ab8f4ac304ce()
{
    airdropsettings = self.airdropsettings;
    destination = self.var_2e302f3dfd4df090;
    initialvelocity = self.var_fc294d70bf464363;
    self.var_fe2a17068a3c0fa6 = undefined;
    self.var_2e302f3dfd4df090 = undefined;
    self.var_fc294d70bf464363 = undefined;
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    self unlink();
    
    if ( packagesettings.useparachute )
    {
        self.var_c31e57afa9361a26 = initialvelocity;
        thread function_488647245d770afd( airdropsettings, destination );
        return;
    }
    
    if ( initialvelocity )
    {
        self vehphys_setdefaultmotion();
        self vehicle_setvelocity( initialvelocity );
        thread function_db7c7c16eb55b911( airdropsettings );
        return;
    }
    
    var_6fa2e853c7a59cff = utility::randomvectorrange( packagesettings.var_c336f10e174b7863, packagesettings.var_c35ae70e1773dd1d );
    randomimpulse = utility::randomvectorrangeflat( packagesettings.var_bc92f2b225b0cb8a, packagesettings.var_bcb5fcb225d72940 );
    self vehphys_setdefaultmotion();
    self vehphys_force( randomimpulse, self.origin + var_6fa2e853c7a59cff, 2 );
    thread function_db7c7c16eb55b911( airdropsettings );
}

// Namespace namespace_e137f55124338968
// Params 2, eflags: 0x4
// Checksum 0x3674f1c8, Offset: 0x726
// Size: 0x285
function private function_488647245d770afd( airdropsettings, destination )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isdefined( destination ) )
    {
        self vehphys_setdefaultmotion();
        return;
    }
    
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    parachutemodel = packagesettings.var_2d0164ad6e60d442;
    heightoffset = packagesettings.var_49cba12d3aadd38d;
    descentspeed = packagesettings.var_8859346574a0d4a8;
    groundthreshold = packagesettings.var_6774c2fff36f19c1;
    groundz = destination[ 2 ] + groundthreshold;
    parachute = spawn( "script_model", self.origin );
    parachute setmodel( parachutemodel );
    parachute linkto( self, "tag_origin", ( 0, 0, heightoffset ), ( 0, 0, 0 ) );
    childthread function_e42ee46f203b780a( parachute );
    currentangles = self.angles;
    timedescent = ( self.origin[ 2 ] - groundz ) / descentspeed;
    var_a3ce82e2f5cbf6a6 = 1;
    timeout = ( timedescent + var_a3ce82e2f5cbf6a6 ) * 1000 + gettime();
    var_a88e691bf94f063b = getdvarint( @"hash_93a2dd6878797bb1", 0 );
    
    while ( isdefined( self ) )
    {
        if ( self.origin[ 2 ] <= groundz )
        {
            break;
        }
        
        if ( gettime() > timeout )
        {
            break;
        }
        
        newz = max( self.origin[ 2 ] - descentspeed * level.framedurationseconds, groundz );
        
        if ( var_a88e691bf94f063b )
        {
            neworigin = ( destination[ 0 ], destination[ 1 ], newz );
        }
        else
        {
            neworigin = ( self.origin[ 0 ], self.origin[ 1 ], newz );
        }
        
        self function_df84c23b1e53ff82( neworigin, currentangles );
        
        /#
            sphere( destination, 50 );
        #/
        
        waitframe();
    }
    
    self vehphys_setdefaultmotion();
    
    if ( isdefined( self.var_c31e57afa9361a26 ) )
    {
        self vehicle_setvelocity( self.var_c31e57afa9361a26 );
        self.var_c31e57afa9361a26 = undefined;
    }
    
    if ( isdefined( parachute ) )
    {
        parachute notify( #"airdrop_complete" );
        parachute unlink();
        parachute delete();
    }
}

// Namespace namespace_e137f55124338968
// Params 1, eflags: 0x4
// Checksum 0x4ea666e, Offset: 0x9b3
// Size: 0x4c
function private function_e42ee46f203b780a( parachute )
{
    level endon( #"game_ended" );
    parachute endon( #"airdrop_complete" );
    self waittill( #"death" );
    self vehphys_setdefaultmotion();
    
    if ( isdefined( parachute ) )
    {
        parachute unlink();
        parachute delete();
    }
}

// Namespace namespace_e137f55124338968
// Params 1, eflags: 0x4
// Checksum 0xc9397e7b, Offset: 0xa07
// Size: 0x10e
function private function_db7c7c16eb55b911( airdropsettings )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    immuneduration = packagesettings.var_6008a308c88c3667;
    self.var_300686ebe3a78e39 = 1;
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        
        if ( ent.classname == "worldspawn" )
        {
            break;
        }
    }
    
    wait immuneduration;
    self.var_300686ebe3a78e39 = undefined;
}

// Namespace namespace_e137f55124338968
// Params 1, eflags: 0x4
// Checksum 0xa2ccbdbe, Offset: 0xb1d
// Size: 0x6b
function private function_badc6b37e81a3292( params )
{
    if ( isdefined( self ) )
    {
        level.package_airdrop.activevehicles = arrayremove( level.package_airdrop.activevehicles, self );
        return;
    }
    
    level.package_airdrop.activevehicles = function_5713d46873b29625( level.package_airdrop.activevehicles );
}

// Namespace namespace_e137f55124338968
// Params 0, eflags: 0x4
// Checksum 0x49d6be0, Offset: 0xb90
// Size: 0x61
function private function_d6cdbfafaf8f329d()
{
    level endon( #"game_ended" );
    utility::flag_wait( "vehicle_init_done" );
    var_a617b899942dd557 = level.br_vehiclesbuffer ?? level.maxvehiclecount / 2;
    level.package_airdrop.var_c2589d35bd6eef07 = getdvarfloat( @"hash_aead1c696bcc59f5", var_a617b899942dd557 );
}

/#

    // Namespace namespace_e137f55124338968
    // Params 0, eflags: 0x4
    // Checksum 0x32320b98, Offset: 0xbf9
    // Size: 0x96, Type: dev
    function private debug_deleteall()
    {
        foreach ( vehicle in level.package_airdrop.activevehicles )
        {
            vehicle.dontspawnhusk = 1;
            vehicle::death( vehicle );
        }
    }

    // Namespace namespace_e137f55124338968
    // Params 0, eflags: 0x4
    // Checksum 0x6ee48031, Offset: 0xc97
    // Size: 0xbc, Type: dev
    function private debug_drawlocations()
    {
        foreach ( vehicle in level.package_airdrop.activevehicles )
        {
            if ( !vehicle )
            {
                continue;
            }
            
            airdrop_scriptbundle::function_cbfae468752db826( vehicle.origin, vehicle.airdropsettings.airdropidentifier, ( 1, 0.5, 0 ) );
        }
    }

#/
