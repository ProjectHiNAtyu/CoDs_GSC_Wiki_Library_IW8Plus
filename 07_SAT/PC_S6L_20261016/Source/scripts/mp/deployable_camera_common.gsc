// scripts\mp\deployable_camera_common.gsc  (hash_1311c5c284dd1537.gscc) (size: 59527 Bytes / 0xe887 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2ba7455f (732382559)
// size ...... 59527 (0xe887)
// includes .. 27  (offset: 0xde57)
// strings ... 125 (offset: 0xdf2f)
// dev strs .. 14  (offset: 0xe7b3)
// exports ... 173 (offset: 0x9ab3)
// cseg ...... 0x8bb + 0x91f8 (0x9ab3)
// imports ... 302 (offset: 0xb5bb)
// animtree1 . 0   (offset: 0xe887)
// animtree2 . 0   (offset: 0xe887)
#using scripts\common\interactive;
#using scripts\common\math;
#using scripts\common\targetmarkergroups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\callouts;
#using scripts\mp\common\equipment\nvg;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\hostmigration;
#using scripts\mp\movers;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;

#namespace deployable_camera_common;

// Namespace deployable_camera_common
// Params 0
// Checksum 0x2c6c3d3d, Offset: 0x8d9
// Size: 0x3c
function function_fef754ab20558ef2()
{
    level.var_719e321e085c7d29 = [];
    level thread function_5591be326812978e();
    utility::registersharedfunc( #"deployable_camera", #"attachxrays", &function_dfb6188b2f6f3ee6 );
    level.var_cb28f5431edb1e50 = [];
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x3e589439, Offset: 0x91d
// Size: 0x39
function function_ddb6749d6d40be33( cameratype )
{
    params = level.var_cb28f5431edb1e50[ cameratype ];
    assert( isdefined( params ), "<dev string:x24>" + cameratype );
    return params;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x15b6586e, Offset: 0x95f
// Size: 0x4a
function function_d5f198a6476235e1( grenade )
{
    stuckdata = spawnstruct();
    childthread function_d0a2eb232dc20d01( grenade, stuckdata );
    childthread function_dc9e56fa65496123( grenade, stuckdata );
    childthread function_95596b3ab4332ace( grenade, stuckdata );
    grenade waittill( #"hash_4d8755ce18e91d98" );
    return stuckdata;
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0x79f8bf9a, Offset: 0x9b2
// Size: 0x3e
function function_95596b3ab4332ace( grenade, stuckdata )
{
    grenade endon( #"hash_4d8755ce18e91d98" );
    grenade waittill( #"missile_water_impact" );
    stuckdata.isunderwater = 1;
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0x644ee1b2, Offset: 0x9f8
// Size: 0x57
function function_d0a2eb232dc20d01( grenade, stuckdata )
{
    grenade endon( #"hash_4d8755ce18e91d98" );
    grenade waittill( #"hash_c167e145cfc24a47", scriptablereturned );
    stuckdata.var_4ca36b89aa230d40 = scriptablereturned;
    grenade notify( #"hash_4d8755ce18e91d98" );
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0xa9abcee6, Offset: 0xa57
// Size: 0x58
function function_dc9e56fa65496123( grenade, stuckdata )
{
    grenade endon( #"hash_4d8755ce18e91d98" );
    grenade waittill( #"missile_stuck", stuckto );
    stuckdata.var_48c9acfd176d5868 = stuckto;
    waitframe();
    grenade notify( #"hash_4d8755ce18e91d98" );
}

// Namespace deployable_camera_common
// Params 7
// Checksum 0x4e14f249, Offset: 0xab7
// Size: 0x2d2
function function_d9939fdafd600147( vectorentity, stuckto, position, turret_name, turret_model, cameratype, var_1942ed602fa25adc )
{
    worldup = ( 0, 0, 1 );
    grenadeup = anglestoup( vectorentity.angles );
    dotresult = vectordot( worldup, grenadeup );
    var_d2874fdec74424d6 = dotresult <= -0.707;
    var_dd251ffa07eaab69 = dotresult > -0.707 && dotresult <= 0.707;
    turretonground = dotresult > 0.707;
    mode = "";
    desiredpitch = 0;
    
    if ( var_d2874fdec74424d6 )
    {
        mode = "ceiling";
    }
    else if ( var_dd251ffa07eaab69 )
    {
        desiredpitch = -90;
        mode = "wall";
    }
    else
    {
        mode = "ground";
    }
    
    turret = spawnturret( "misc_turret", position, turret_name, 1, 1, desiredpitch );
    turret.mode = mode;
    turret setmodel( turret_model );
    turret.team = self.team;
    
    if ( !var_1942ed602fa25adc )
    {
        turret setturretowner( self );
        turret.owner = self;
        turret setotherent( self );
    }
    
    turret.origin = vectorentity.origin;
    turret.angles = vectorentity.angles;
    turret disableplayeruseforallplayers();
    turret setmode( "sentry_offline" );
    turret.cameratype = cameratype;
    destroyfunc = function_ddb6749d6d40be33( turret.cameratype ).destroyfunc;
    
    /#
        level thread utility::draw_angles( turret.angles, turret.origin, ( 1, 0, 0 ), 5000, 100 );
    #/
    
    if ( isdefined( stuckto ) )
    {
        turret linkto( stuckto );
        turret thread equipment_mp::function_2c8f51009c3dd68f( stuckto, destroyfunc, 0 );
        turret.moving_platform = stuckto;
        data = spawnstruct();
        data.linkparent = turret.moving_platform;
        data.deathoverridecallback = destroyfunc;
        data.validateaccuratetouching = 1;
        turret thread movers::handle_moving_platforms( data );
        turret thread function_3d18b0977b362e9b( destroyfunc );
    }
    else if ( isdefined( level.wztrain_info ) )
    {
        data = spawnstruct();
        data.deathoverridecallback = destroyfunc;
        turret thread movers::handle_moving_platforms( data );
    }
    
    return turret;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x4eabee00, Offset: 0xd92
// Size: 0x2b
function function_3d18b0977b362e9b( destroyfunc )
{
    self endon( #"death" );
    
    while ( isdefined( self getlinkedparent() ) )
    {
        waitframe();
    }
    
    self [[ destroyfunc ]]();
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x31f9f902, Offset: 0xdc5
// Size: 0xb0
function function_44cb63d579bee7c8( var_17b26f1d2ecf82f2 )
{
    if ( !isdefined( level.deployable_cameras ) )
    {
        level.deployable_cameras = [];
    }
    
    level.deployable_cameras[ var_17b26f1d2ecf82f2 ] = [];
    
    foreach ( team in level.teamnamelist )
    {
        level.deployable_cameras[ var_17b26f1d2ecf82f2 ][ team ] = [];
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x2da8d934, Offset: 0xe7d
// Size: 0x65
function function_61d1333446b0881f( cameratype )
{
    params = function_ddb6749d6d40be33( cameratype );
    
    if ( !isdefined( self.deployable_cameras ) )
    {
        self.deployable_cameras = [];
    }
    
    if ( !isdefined( self.deployable_cameras[ params.groupnameplayer ] ) )
    {
        self.deployable_cameras[ params.groupnameplayer ] = [];
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x9518abbc, Offset: 0xeea
// Size: 0x57
function function_2fee422e017f6d21( cameratype )
{
    params = function_ddb6749d6d40be33( cameratype );
    
    if ( level.teambased )
    {
        return function_eb93dc9bf87aa3b8( params.groupnameteams );
    }
    
    return self.deployable_cameras[ params.groupnameplayer ];
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xa6b3d142, Offset: 0xf49
// Size: 0x5f, Type: bool
function function_f83cf4f089c9ffdf( cameratype )
{
    params = function_ddb6749d6d40be33( cameratype );
    
    if ( isdefined( params ) )
    {
        teamcameras = function_eb93dc9bf87aa3b8( params.groupnameteams );
        
        if ( teamcameras.size > 0 )
        {
            if ( teamcameras.size >= params.var_8985558107853acf )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0xf9dcfefc, Offset: 0xfb1
// Size: 0xef
function private function_eb93dc9bf87aa3b8( var_17b26f1d2ecf82f2 )
{
    if ( !isdefined( level.deployable_cameras[ var_17b26f1d2ecf82f2 ] ) )
    {
        level.deployable_cameras[ var_17b26f1d2ecf82f2 ] = [];
    }
    
    if ( !isdefined( level.deployable_cameras[ var_17b26f1d2ecf82f2 ][ self.team ] ) )
    {
        level.deployable_cameras[ var_17b26f1d2ecf82f2 ][ self.team ] = [];
    }
    
    if ( squad_utility::shouldmodesetsquads() && !isdefined( level.deployable_cameras[ var_17b26f1d2ecf82f2 ][ self.team ][ self.sessionsquadid ] ) )
    {
        level.deployable_cameras[ var_17b26f1d2ecf82f2 ][ self.team ][ self.sessionsquadid ] = [];
    }
    
    if ( squad_utility::shouldmodesetsquads() )
    {
        return level.deployable_cameras[ var_17b26f1d2ecf82f2 ][ self.team ][ self.sessionsquadid ];
    }
    
    return level.deployable_cameras[ var_17b26f1d2ecf82f2 ][ self.team ];
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0xda616303, Offset: 0x10a8
// Size: 0x5d
function private function_fa7a478fbac4253c( var_17b26f1d2ecf82f2, val )
{
    if ( squad_utility::shouldmodesetsquads() )
    {
        level.deployable_cameras[ var_17b26f1d2ecf82f2 ][ self.team ][ self.sessionsquadid ] = val;
        return;
    }
    
    level.deployable_cameras[ var_17b26f1d2ecf82f2 ][ self.team ] = val;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xb227f100, Offset: 0x110d
// Size: 0x219
function function_78ea6b444014807e( camera )
{
    params = function_ddb6749d6d40be33( camera.cameratype );
    teamref = camera.owner.team;
    
    if ( !isdefined( level.deployable_cameras ) )
    {
        level.deployable_cameras = [];
    }
    
    if ( !isdefined( level.deployable_cameras[ params.groupnameteams ] ) )
    {
        level.deployable_cameras[ params.groupnameteams ] = [];
    }
    
    if ( !isdefined( level.deployable_cameras[ params.groupnameteams ][ teamref ] ) )
    {
        level.deployable_cameras[ params.groupnameteams ][ teamref ] = [];
    }
    
    if ( squad_utility::shouldmodesetsquads() && !isdefined( function_eb93dc9bf87aa3b8( params.groupnameteams ) ) )
    {
        level.deployable_cameras[ params.groupnameteams ][ teamref ][ self.sessionsquadid ] = [];
    }
    
    foundindex = undefined;
    teamcameras = function_eb93dc9bf87aa3b8( params.groupnameteams );
    arraysize = teamcameras.size;
    var_c80ea61f862580b3 = 0;
    
    while ( true )
    {
        for ( i = 0; i <= arraysize ; i++ )
        {
            if ( i == arraysize )
            {
                foundindex = i;
                var_c80ea61f862580b3 = 1;
                break;
            }
            
            currentcam = teamcameras[ i ];
            
            if ( !isdefined( currentcam.cameraindex ) || currentcam.isdestroyed )
            {
                break;
            }
            
            if ( currentcam.cameraindex != i )
            {
                foundindex = i;
                var_c80ea61f862580b3 = 1;
                break;
            }
        }
        
        if ( var_c80ea61f862580b3 )
        {
            break;
        }
        
        waitframe();
    }
    
    teamcameras[ teamcameras.size ] = camera;
    camera.cameraindex = foundindex;
    function_fa7a478fbac4253c( params.groupnameteams, arraysort( teamcameras, undefined, &function_d815cbc39e7faf86 ) );
    level notify( params.additionnotification, camera, camera.cameraindex );
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xc79f6b5a, Offset: 0x132e
// Size: 0x34
function function_f07a5abff6b8cc9c( camera )
{
    if ( !isalive( self ) || !isdefined( camera ) || camera.isdestroyed )
    {
        return 0;
    }
    
    return 1;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x382749e9, Offset: 0x136a
// Size: 0x223
function function_ebd0636619e0a916( camera )
{
    level endon( #"game_ended" );
    params = function_ddb6749d6d40be33( camera.cameratype );
    teamref = self.team;
    level notify( params.removalnotification, camera, camera.cameraindex );
    
    if ( squad_utility::shouldmodesetsquads() )
    {
        if ( isdefined( level.deployable_cameras[ params.groupnameteams ][ teamref ][ self.sessionsquadid ] ) )
        {
            level.deployable_cameras[ params.groupnameteams ][ teamref ][ self.sessionsquadid ] = arrayremove( level.deployable_cameras[ params.groupnameteams ][ teamref ][ self.sessionsquadid ], camera );
            
            if ( level.deployable_cameras[ params.groupnameteams ][ teamref ][ self.sessionsquadid ].size == 0 )
            {
                level.deployable_cameras[ params.groupnameteams ][ teamref ][ self.sessionsquadid ] = undefined;
            }
        }
        else
        {
            assertmsg( "<dev string:x53>" + params.groupnameteams + "<dev string:x6e>" + teamref + "<dev string:x73>" + self.sessionsquadid + "<dev string:x77>" );
        }
    }
    else if ( isdefined( level.deployable_cameras[ params.groupnameteams ][ teamref ] ) )
    {
        level.deployable_cameras[ params.groupnameteams ][ teamref ] = arrayremove( level.deployable_cameras[ params.groupnameteams ][ teamref ], camera );
        
        if ( level.deployable_cameras[ params.groupnameteams ][ teamref ].size == 0 )
        {
            level.deployable_cameras[ params.groupnameteams ][ teamref ] = undefined;
        }
    }
    else
    {
        assertmsg( "<dev string:x53>" + params.groupnameteams + "<dev string:x6e>" + teamref + "<dev string:x77>" );
    }
    
    camera.cameraindex = undefined;
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x3e319f53, Offset: 0x1595
// Size: 0x78
function function_192becd98c93955e()
{
    if ( level.teambased )
    {
        squadsenabled = squad_utility::shouldmodesetsquads();
        
        if ( squadsenabled )
        {
            return teams::getsquadmates( self.owner.team, self.owner.sessionsquadid, 0 );
        }
        else
        {
            return teams::getteamdata( self.ownerteam, "players" );
        }
        
        return;
    }
    
    return self.owner;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xa97029dc, Offset: 0x1615
// Size: 0x35
function function_4d9ff7e202d60950( camtype )
{
    params = function_ddb6749d6d40be33( camtype );
    self.deployable_cameras[ params.groupnameplayer ] = undefined;
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0x528c56ae, Offset: 0x1652
// Size: 0x26, Type: bool
function private function_ecf0d0c60c43cfa0( var_35cfb2a83da5f09 )
{
    return isdefined( self.deployable_cameras ) && isdefined( self.deployable_cameras[ var_35cfb2a83da5f09 ] );
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x870bce05, Offset: 0x1681
// Size: 0x52, Type: bool
function function_b04038c7f3abf1bc( camtype )
{
    params = function_ddb6749d6d40be33( camtype );
    return isdefined( self.deployable_cameras[ params.groupnameplayer ] ) && self.deployable_cameras[ params.groupnameplayer ].size > 0;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xf7cc161f, Offset: 0x16dc
// Size: 0xc0
function function_e594b7877f267d89( camtype )
{
    params = function_ddb6749d6d40be33( camtype );
    
    if ( function_ecf0d0c60c43cfa0( params.groupnameplayer ) )
    {
        foreach ( camera in self.deployable_cameras[ params.groupnameplayer ] )
        {
            camera thread [[ params.destroyfunc ]]( 1 );
        }
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x2487ceaa, Offset: 0x17a4
// Size: 0x1c3
function function_fbedeab58253b60a( camera )
{
    params = function_ddb6749d6d40be33( camera.cameratype );
    
    if ( !isdefined( self.deployable_cameras ) )
    {
        self.deployable_cameras = [];
    }
    
    if ( !isdefined( self.deployable_cameras[ params.groupnameplayer ] ) )
    {
        self.deployable_cameras[ params.groupnameplayer ] = [];
    }
    
    cameralist = self.deployable_cameras[ params.groupnameplayer ];
    cameralist[ cameralist.size ] = camera;
    cameralist = arraysort( cameralist, undefined, &function_5bd330f23472a32e );
    
    if ( cameralist.size > params.var_d7dbb2b6c97aa3cf )
    {
        var_a7b9f021d79025fc = cameralist[ cameralist.size - 1 ];
        var_291839ef2fafc77 = cameralist[ 0 ];
        
        if ( isdefined( var_a7b9f021d79025fc.ownerindex ) )
        {
            var_291839ef2fafc77.ownerindex = var_a7b9f021d79025fc.ownerindex;
            
            if ( !level.teambased )
            {
                camera.cameraindex = var_291839ef2fafc77.ownerindex;
            }
        }
        
        cameralist[ cameralist.size - 1 ] [[ params.destroyfunc ]]( 1, 1 );
        cameralist = arrayremove( cameralist, cameralist[ cameralist.size - 1 ] );
    }
    else
    {
        if ( isdefined( cameralist[ 1 ] ) )
        {
            camera.ownerindex = cameralist[ 1 ].ownerindex == 0 ? 1 : 0;
        }
        else
        {
            camera.ownerindex = 0;
        }
        
        if ( !level.teambased )
        {
            camera.cameraindex = camera.ownerindex;
        }
    }
    
    self.deployable_cameras[ params.groupnameplayer ] = cameralist;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x32c57b40, Offset: 0x196f
// Size: 0x92
function function_c2c84235baaa07bc( camera )
{
    params = function_ddb6749d6d40be33( camera.cameratype );
    
    if ( !isdefined( self.owner.deployable_cameras[ params.groupnameplayer ] ) )
    {
        return;
    }
    
    self.owner.deployable_cameras[ params.groupnameplayer ] = arrayremove( self.owner.deployable_cameras[ params.groupnameplayer ], self );
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xe21cc159, Offset: 0x1a09
// Size: 0xa3
function function_76f2b33b425d6bc2( camera )
{
    self endon( #"disconnect" );
    camera endon( #"death" );
    
    if ( !isdefined( camera.ownerindex ) )
    {
        return;
    }
    
    while ( !camera.isdestroyed )
    {
        var_a712da0bfd6d366c = distance( self.origin, camera.origin );
        var_a712da0bfd6d366c = int( floor( var_a712da0bfd6d366c * 0.0254 ) );
        self setclientomnvar( "ui_tactical_camera_cam_" + camera.ownerindex + "_distance", var_a712da0bfd6d366c );
        wait 0.2;
    }
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0xe72b1ff, Offset: 0x1ab4
// Size: 0x37
function private function_5bd330f23472a32e( a, b )
{
    if ( a.creationtime > b.creationtime )
    {
        return 1;
    }
    
    return 0;
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0xb37e67d6, Offset: 0x1af3
// Size: 0x37
function private function_d815cbc39e7faf86( a, b )
{
    if ( a.cameraindex < b.cameraindex )
    {
        return 1;
    }
    
    return 0;
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0x8ccddbc0, Offset: 0x1b32
// Size: 0x9
function private function_5756567ead73569b()
{
    return callouts::function_69298682a76ef6c5( self );
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x6527eba0, Offset: 0x1b44
// Size: 0xa6
function function_928c5287b85618e2()
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"death" );
    self.areaid = -1;
    notif = function_ddb6749d6d40be33( self.cameratype ).var_c7d5c770eec5db7e;
    
    if ( isbrgamemode() )
    {
        return;
    }
    
    while ( true )
    {
        var_f78e8a433611e608 = function_5756567ead73569b();
        
        if ( isdefined( var_f78e8a433611e608 ) && self.areaid != var_f78e8a433611e608 )
        {
            self.areaid = var_f78e8a433611e608;
            level notify( notif, self );
        }
        
        wait 0.1;
    }
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xa304a587, Offset: 0x1bf2
// Size: 0x61
function function_1eeb9de1633236bf()
{
    self endon( #"death" );
    self.madedamageable = 1;
    params = function_ddb6749d6d40be33( self.cameratype );
    thread damage::monitordamage( params.maxhealth, "hitequip", params.var_472a74ff4f3384db, params.damagehandler );
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x14905661, Offset: 0x1c5b
// Size: 0xb1
function function_eff29e4a52221c73( camera )
{
    camera endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    timeoutduration = function_ddb6749d6d40be33( camera.cameratype ).lifetime;
    timeelapsed = 0;
    
    while ( timeelapsed < timeoutduration )
    {
        timepercent = ( timeoutduration - timeelapsed ) / timeoutduration;
        timepercent = int( ceil( clamp( timepercent, 0, 1 ) * 100 ) );
        camera.batterytime = timepercent;
        timeelapsed += level.framedurationseconds;
        waitframe();
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x9b645cf5, Offset: 0x1d14
// Size: 0x98
function function_822d202b00169d94( camera )
{
    camera endon( #"death" );
    self endon( #"hash_f9bf56f61dc1cf9e" );
    self endon( #"disconnect" );
    reticlestate = 0;
    
    while ( true )
    {
        if ( camera.markingtarget && reticlestate == 0 )
        {
            self setclientomnvar( "ui_rcd_outer_ring", 1 );
            reticlestate = 1;
        }
        else if ( !camera.markingtarget && reticlestate == 1 )
        {
            self setclientomnvar( "ui_rcd_outer_ring", 0 );
            reticlestate = 0;
        }
        
        waitframe();
    }
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0x8ffb80a7, Offset: 0x1db4
// Size: 0x25, Type: bool
function private function_932e2c6c6fc8fcfe()
{
    if ( !isdefined( self.var_f8fc9155443446cd ) )
    {
        return false;
    }
    
    if ( self.var_f8fc9155443446cd.size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x16be59a2, Offset: 0x1de2
// Size: 0xb7
function function_2a2cd4c489f881c2( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        if ( !isdefined( level.var_2fdcca6e52968129[ player.team ] ) )
        {
            return;
        }
        
        if ( squad_utility::shouldmodesetsquads() )
        {
            if ( isdefined( level.var_2fdcca6e52968129[ player.team ][ player.sessionsquadid ] ) )
            {
                return level.var_2fdcca6e52968129[ player.team ][ player.sessionsquadid ];
            }
            else
            {
                return;
            }
        }
        else
        {
            return level.var_2fdcca6e52968129[ player.team ];
        }
        
        return;
    }
    
    return player.markedents;
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0xdd21900e, Offset: 0x1ea1
// Size: 0x58, Type: bool
function private function_a92703f9ea24aa6( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    markcluster = function_2a2cd4c489f881c2( self );
    
    if ( !isdefined( markcluster ) )
    {
        return false;
    }
    
    markdata = markcluster[ target getentitynumber() ];
    
    if ( !isdefined( markdata ) )
    {
        return false;
    }
    
    return istrue( markdata.reconmarked );
}

// Namespace deployable_camera_common
// Params 3, eflags: 0x4
// Checksum 0x3b32b3fb, Offset: 0x1f02
// Size: 0x1d5
function private function_a293349d05534f0c( defaulticon, defaultoffset, target )
{
    weaponicon = defaulticon;
    weaponoffset = defaultoffset;
    weaponstruct = spawnstruct();
    
    if ( isdefined( target.weapon_name ) )
    {
        weaponref = undefined;
        
        if ( issubstr( target.weapon_name, "claymore" ) )
        {
            weaponref = "equip_claymore";
        }
        else if ( issubstr( target.weapon_name, "c4" ) )
        {
            weaponref = "equip_c4";
        }
        else if ( issubstr( target.weapon_name, "atMine" ) )
        {
            weaponref = "equip_at_mine";
        }
        else if ( issubstr( target.weapon_name, "trophy" ) )
        {
            weaponref = "equip_trophy";
        }
        
        if ( isdefined( weaponref ) )
        {
            equipinfo = undefined;
            
            if ( utility::issharedfuncdefined( #"equipment", #"hash_3187f585d2de7de7" ) )
            {
                equipinfo = [[ utility::getsharedfunc( #"equipment", #"hash_3187f585d2de7de7" ) ]]( weaponref );
            }
            
            weaponicon = equipinfo.image;
        }
    }
    else if ( isdefined( target.streakinfo ) )
    {
        streakref = target.streakinfo.streakname;
        bundle = level.streakglobals.streakbundles[ streakref ];
        weaponicon = isdefined( bundle ) && isdefined( bundle.overheadicon ) ? bundle.overheadicon : "";
        weaponoffset = 75;
    }
    
    weaponstruct.weaponicon = weaponicon;
    weaponstruct.weaponoffset = weaponoffset;
    return weaponstruct;
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x6f94f245, Offset: 0x20e0
// Size: 0xcf
function private function_f8bb1ca430334609( markdata, player )
{
    markingplayer = undefined;
    
    if ( isdefined( markdata.markingent.pilot ) )
    {
        markingplayer = markdata.markingent.pilot;
    }
    else
    {
        markingplayer = markdata.markingent.owner;
    }
    
    if ( level.teambased )
    {
        if ( squad_utility::shouldmodesetsquads() )
        {
            ownersquad = teams::getsquadmates( markingplayer.team, markingplayer.sessionsquadid, 0 );
            return arraycontains( ownersquad, player );
        }
        else
        {
            return player_utility::isfriendly( markingplayer.team, player );
        }
        
        return;
    }
    
    return player == markingplayer;
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xf5f0fa79, Offset: 0x21b7
// Size: 0x65
function function_d87e93294143124c()
{
    self endon( #"disconnect" );
    
    if ( utility::isusingremote() )
    {
        return;
    }
    
    visionset = "recon_drone_flash";
    
    if ( self.pers[ "useNVG" ] )
    {
        visionset = "recon_drone_flash_nvg";
    }
    
    self visionsetfadetoblackforplayer( visionset, 0.05 );
    wait 0.08;
    self visionsetfadetoblackforplayer( "", 1.2 );
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x3628207e, Offset: 0x2224
// Size: 0x75
function function_8cdabce49de74f20()
{
    if ( !isdefined( self.markedomnvar ) )
    {
        self.markedomnvar = 1;
        self setclientomnvar( "ui_rcd_target_notify", self.markedomnvar );
        thread function_4a3d2f214083a234();
        return;
    }
    
    if ( self.markedomnvar == 1 )
    {
        self.markedomnvar = 2;
    }
    else
    {
        self.markedomnvar = 1;
    }
    
    self setclientomnvar( "ui_rcd_target_notify", self.markedomnvar );
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0x5e317f45, Offset: 0x22a1
// Size: 0x6a
function private function_4a3d2f214083a234()
{
    self endon( #"disconnect" );
    self notify( #"hash_4f6c70212967e71e" );
    self endon( #"hash_4f6c70212967e71e" );
    
    if ( utility::issharedfuncdefined( #"helper_drone", #"hash_6d6d7607c322a1b1" ) )
    {
        wait self [[ utility::getsharedfunc( #"helper_drone", #"hash_6d6d7607c322a1b1" ) ]]();
    }
    else
    {
        wait 3;
    }
    
    thread function_ac7fe0c743da083a();
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0xcb25c22a, Offset: 0x2313
// Size: 0x24
function private function_ac7fe0c743da083a()
{
    self notify( #"hash_4f6c70212967e71e" );
    self.markedomnvar = undefined;
    self setclientomnvar( "ui_rcd_target_notify", 0 );
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0x2b6a06d9, Offset: 0x233f
// Size: 0x42
function private function_c6116144d9544df( player )
{
    entityheadicons::setheadicon_addclienttomask( self.headiconbox, player );
    entityheadicons::setheadicon_removeclientfrommask( self.headiconfaction, player );
    entityheadicons::setheadicon_removeclientfrommask( self.headiconalert, player );
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0xea4c269c, Offset: 0x2389
// Size: 0x42
function private function_22fd65265710bda6( player )
{
    entityheadicons::setheadicon_removeclientfrommask( self.headiconbox, player );
    entityheadicons::setheadicon_addclienttomask( self.headiconfaction, player );
    entityheadicons::setheadicon_removeclientfrommask( self.headiconalert, player );
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0x3904a5c6, Offset: 0x23d3
// Size: 0x42
function private function_babdb63d2443526( player )
{
    entityheadicons::setheadicon_removeclientfrommask( self.headiconbox, player );
    entityheadicons::setheadicon_removeclientfrommask( self.headiconfaction, player );
    entityheadicons::setheadicon_addclienttomask( self.headiconalert, player );
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0x1247520b, Offset: 0x241d
// Size: 0x42
function private function_f7e9275a3ec3931a( player )
{
    entityheadicons::setheadicon_removeclientfrommask( self.headiconbox, player );
    entityheadicons::setheadicon_removeclientfrommask( self.headiconfaction, player );
    entityheadicons::setheadicon_removeclientfrommask( self.headiconalert, player );
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xe99f4260, Offset: 0x2467
// Size: 0x77
function function_feaeb4d1ac58eae8()
{
    if ( isdefined( self.headiconbox ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconbox );
        self.headiconbox = undefined;
    }
    
    if ( isdefined( self.headiconfaction ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconfaction );
        self.headiconfaction = undefined;
    }
    
    if ( isdefined( self.headiconalert ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconalert );
        self.headiconalert = undefined;
    }
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0x7e8aafc4, Offset: 0x24e6
// Size: 0x90
function private function_a3616c8dc63ff9b4( supername )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        function_feffc4d0cdb7dad3( player, undefined, supername );
    }
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x26edc75f, Offset: 0x257e
// Size: 0x52
function private function_92c0266689e29969( player, supername )
{
    if ( isdefined( player.super ) && player.super.staticdata.ref == supername )
    {
        return 1;
    }
    
    return 0;
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0x5c53b1bb, Offset: 0x25d8
// Size: 0x12f
function function_feffc4d0cdb7dad3( player, unset, supername )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    idbox = self.headiconbox;
    
    if ( !isdefined( idbox ) )
    {
        return;
    }
    
    idfaction = self.headiconfaction;
    
    if ( !isdefined( idfaction ) )
    {
        return;
    }
    
    idalert = self.headiconalert;
    
    if ( !isdefined( idalert ) )
    {
        return;
    }
    
    isfriendly = player_utility::isfriendly( self.owner.team, player );
    var_3f3e3ba2890e74c = function_92c0266689e29969( player, supername );
    
    if ( isfriendly )
    {
        if ( unset )
        {
            function_22fd65265710bda6( player );
            return;
        }
        
        if ( function_932e2c6c6fc8fcfe() )
        {
            function_babdb63d2443526( player );
            return;
        }
        
        if ( var_3f3e3ba2890e74c )
        {
            if ( player.isusingcamera )
            {
                function_f7e9275a3ec3931a( player );
                return;
            }
            
            function_c6116144d9544df( player );
            return;
        }
        else
        {
            function_22fd65265710bda6( player );
        }
        
        return;
    }
    
    function_f7e9275a3ec3931a( player );
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x1a4dc128, Offset: 0x270f
// Size: 0x261
function function_4081af1e53d674d1( player )
{
    var_abcb2f625c018825 = player function_3a8b5a07c19ae1c3();
    
    if ( !isdefined( var_abcb2f625c018825 ) )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    teammates = undefined;
    squadsenabled = squad_utility::shouldmodesetsquads();
    
    if ( var_abcb2f625c018825 == self )
    {
        if ( squadsenabled )
        {
            teammates = teams::getsquadmates( player.team, player.sessionsquadid, 1 );
        }
        else
        {
            teammates = teams::getteamdata( player.team, "players" );
        }
        
        foreach ( teammate in teammates )
        {
            if ( teammate == player )
            {
                continue;
            }
            
            if ( !teammate.isusingcamera )
            {
                continue;
            }
            
            targetmarkergroups::setnewowner( player.cameratargetmarkergroup, teammate );
            
            if ( squadsenabled )
            {
                level.cameratargetmarkergroup[ player.team ][ player.sessionsquadid ] = teammate;
                level.cameratargetmarkergroup[ player.team ][ player.sessionsquadid ].cameratargetmarkergroup = player.cameratargetmarkergroup;
            }
            else
            {
                level.cameratargetmarkergroup[ player.team ] = teammate;
                level.cameratargetmarkergroup[ player.team ].cameratargetmarkergroup = player.cameratargetmarkergroup;
            }
            
            player.cameratargetmarkergroup = undefined;
            targetmarkergroups::function_c67dee3040fbef65( level.cameratargetmarkergroup[ player.team ].cameratargetmarkergroup, player );
            return teammate;
        }
        
        targetmarkergroups::targetmarkergroup_off( var_abcb2f625c018825.cameratargetmarkergroup );
        
        if ( squadsenabled )
        {
            level.cameratargetmarkergroup[ player.team ][ player.sessionsquadid ] = undefined;
            return;
        }
        
        level.cameratargetmarkergroup[ player.team ] = undefined;
    }
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0xe1733e1a, Offset: 0x2979
// Size: 0xa1
function private function_3a8b5a07c19ae1c3()
{
    tmg_ent = undefined;
    team = self.team;
    
    if ( level.teambased )
    {
        if ( !isdefined( level.cameratargetmarkergroup[ team ] ) )
        {
            return;
        }
        
        if ( squad_utility::shouldmodesetsquads() )
        {
            if ( !isdefined( level.cameratargetmarkergroup[ team ][ self.sessionsquadid ] ) )
            {
                return;
            }
            else
            {
                return level.cameratargetmarkergroup[ team ][ self.sessionsquadid ];
            }
        }
        else
        {
            return level.cameratargetmarkergroup[ team ];
        }
        
        return;
    }
    
    if ( isdefined( self.cameratargetmarkergroup ) )
    {
        return self;
    }
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xacb92a67, Offset: 0x2a22
// Size: 0xb4
function function_1ba5618c12749387()
{
    team = self.team;
    tmg_ent = function_3a8b5a07c19ae1c3();
    
    if ( !( isdefined( tmg_ent ) && isdefined( tmg_ent.cameratargetmarkergroup ) ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        newowner = undefined;
        
        if ( tmg_ent == self )
        {
            newowner = function_4081af1e53d674d1( self );
            
            if ( isdefined( newowner ) )
            {
                targetmarkergroups::function_c67dee3040fbef65( newowner.cameratargetmarkergroup, self );
            }
        }
        else
        {
            targetmarkergroups::function_c67dee3040fbef65( tmg_ent.cameratargetmarkergroup, self );
        }
        
        return;
    }
    
    targetmarkergroups::targetmarkergroup_off( tmg_ent.cameratargetmarkergroup );
    tmg_ent.cameratargetmarkergroup = undefined;
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0x8417a3e, Offset: 0x2ade
// Size: 0x5b
function function_177bcf71b0bf91fe( markergroup, target, state )
{
    firstbit = ( state >> 0 ) % 2 == 1;
    secondbit = ( state >> 1 ) % 2 == 1;
    targetmarkergroupsetentitystate( markergroup, target, firstbit );
    targetmarkergroupsetextrastate( markergroup, target, secondbit );
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x39db43c9, Offset: 0x2b41
// Size: 0x3d2
function function_5d9b2813d1d3da15()
{
    markedents = function_2a2cd4c489f881c2( self );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        if ( !isdefined( level.cameratargetmarkergroup ) )
        {
            level.cameratargetmarkergroup = [];
        }
        
        if ( squad_utility::shouldmodesetsquads() )
        {
            if ( !isdefined( level.cameratargetmarkergroup[ self.team ] ) )
            {
                level.cameratargetmarkergroup[ self.team ] = [];
            }
            
            if ( !isdefined( level.cameratargetmarkergroup[ self.team ][ self.sessionsquadid ] ) )
            {
                level.cameratargetmarkergroup[ self.team ][ self.sessionsquadid ] = self;
                self.cameratargetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0 );
                
                if ( isdefined( markedents ) )
                {
                    foreach ( ent in markedents )
                    {
                        if ( isdefined( ent ) && ent.reconmarked )
                        {
                            targetmarkergroups::targetmarkergroup_markentity( ent.target, self.cameratargetmarkergroup, 0 );
                            function_177bcf71b0bf91fe( self.cameratargetmarkergroup, ent.target, 2 );
                        }
                    }
                }
            }
            else
            {
                tmg = level.cameratargetmarkergroup[ self.team ][ self.sessionsquadid ].cameratargetmarkergroup;
                targetmarkergroups::function_68c6f44397ca287e( tmg, self );
            }
        }
        else if ( !isdefined( level.cameratargetmarkergroup[ self.team ] ) )
        {
            level.cameratargetmarkergroup[ self.team ] = self;
            self.cameratargetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0 );
            
            if ( isdefined( markedents ) )
            {
                foreach ( ent in markedents )
                {
                    if ( ent.reconmarked )
                    {
                        targetmarkergroups::targetmarkergroup_markentity( ent.target, self.cameratargetmarkergroup, 0 );
                        function_177bcf71b0bf91fe( self.cameratargetmarkergroup, ent.target, 2 );
                    }
                }
            }
        }
        else
        {
            tmg_ent = level.cameratargetmarkergroup[ self.team ];
            targetmarkergroups::function_68c6f44397ca287e( tmg_ent.cameratargetmarkergroup, self );
        }
        
        return;
    }
    
    if ( !isdefined( self.cameratargetmarkergroup ) )
    {
        self.cameratargetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0 );
        
        if ( isdefined( markedents ) )
        {
            foreach ( ent in markedents )
            {
                if ( ent.reconmarked )
                {
                    targetmarkergroups::targetmarkergroup_markentity( ent.target, self.cameratargetmarkergroup, 0 );
                    function_177bcf71b0bf91fe( self.cameratargetmarkergroup, ent.target, 2 );
                }
            }
        }
    }
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x81b7857e, Offset: 0x2f1b
// Size: 0x32
function function_1066089a542b3224()
{
    tmg_ent = function_3a8b5a07c19ae1c3();
    
    if ( isdefined( tmg_ent ) )
    {
        markergroup = tmg_ent.cameratargetmarkergroup;
        return markergroup;
    }
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xa5adb6ca, Offset: 0x2f55
// Size: 0x87
function function_7cd737002cc225f4()
{
    params = function_ddb6749d6d40be33( self.cameratype );
    self.headiconbox = entityheadicons::setheadicon_singleimage( [], params.headiconname, 5, 1, 1000, 100, undefined, 1 );
    self.headiconfaction = entityheadicons::setheadicon_equipment( self );
    self.headiconalert = entityheadicons::setheadicon_singleimage( [], "icon_ping_warning", 5, 1, 1000, 100, undefined, 1 );
    function_a3616c8dc63ff9b4( params.supername );
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0xbfd5007b, Offset: 0x2fe4
// Size: 0xe2
function private function_359ca2dd2c2cf173()
{
    if ( self.watchers.size > 0 )
    {
        var_883a127fc02b6f7d = getfirstarraykey( self.watchers );
        var_10cb156e69739625 = self.var_903b12971e52e2d0[ var_883a127fc02b6f7d ];
        
        foreach ( player in self.watchers )
        {
            entnum = player getentitynumber();
            timestamp = self.var_903b12971e52e2d0[ entnum ];
            
            if ( timestamp < var_10cb156e69739625 )
            {
                var_883a127fc02b6f7d = entnum;
            }
        }
        
        return var_883a127fc02b6f7d;
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xed8e2067, Offset: 0x30ce
// Size: 0x37
function deployablecamera_iswatcher( player )
{
    iswatcher = 0;
    
    if ( isdefined( self.watchers ) )
    {
        iswatcher = arraycontains( self.watchers, player );
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x789ff037, Offset: 0x310d
// Size: 0x90
function function_d71e7b3e8ab21636( camera )
{
    level endon( #"game_ended" );
    camera endon( #"death" );
    camera endon( #"explode" );
    camera notify( #"updatetag" );
    camera endon( #"updatetag" );
    self endon( #"disconnect" );
    
    while ( isdefined( camera.pilot ) )
    {
        camera.watcher_tag.angles = camera.pilot getplayerangles();
        waitframe();
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xec4c3be6, Offset: 0x31a5
// Size: 0xfa
function function_a2a694740a9527a8( cameratype )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"monitoringplayerexit" );
    self endon( #"monitoringplayerexit" );
    self.pilot waittill( #"playerLeavingCurrentCamera" );
    params = function_ddb6749d6d40be33( cameratype );
    
    if ( self.watchers.size > 0 )
    {
        idx = function_359ca2dd2c2cf173();
        newpilot = self.watchers[ idx ];
        timestamp = self.var_903b12971e52e2d0[ idx ];
        
        if ( !isdefined( self.pilot ) )
        {
            newpilot [[ params.exitfunc ]]( self, 1 );
            waitframe();
            
            if ( isdefined( newpilot ) && isdefined( self ) )
            {
                newpilot thread [[ params.startfunc ]]( self );
            }
        }
    }
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xbc283e17, Offset: 0x32a7
// Size: 0x36
function function_7dedef407f7f7051()
{
    var_fd551226c4a881e2 = 1000;
    starttime = gettime();
    
    while ( gettime() - starttime < var_fd551226c4a881e2 )
    {
        self disablephysicaldepthoffieldscripting();
        waitframe();
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x189676a2, Offset: 0x32e5
// Size: 0xcf
function function_903c3eda53391682( cameratype )
{
    exitfunc = function_ddb6749d6d40be33( cameratype ).exitfunc;
    
    if ( isdefined( self.pilot ) )
    {
        self.pilot function_cc8faead62cecf93( self, cameratype );
    }
    
    if ( self.watchers.size > 0 )
    {
        foreach ( watcher in self.watchers )
        {
            watcher [[ exitfunc ]]( self, 0 );
        }
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xbf5e989a, Offset: 0x33bc
// Size: 0x92
function function_3baa03e64f7d4778( player )
{
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    status = 0;
    distsq = distancesquared( self.origin, player.origin );
    
    if ( self.hasexploded )
    {
        status = 3;
    }
    else if ( distsq > function_ddb6749d6d40be33( self.cameratype ).var_4114b4b691808ac7 )
    {
        status = 2;
    }
    else if ( emp_debuff::is_empd() )
    {
        status = 4;
    }
    else
    {
        status = 1;
    }
    
    return status;
}

// Namespace deployable_camera_common
// Params 4, eflags: 0x4
// Checksum 0x3f70b0df, Offset: 0x3457
// Size: 0x88
function private function_d28f90ba0d31e7f( camera, index, state, time )
{
    camera notify( #"hash_6aff848cb3ea9491" );
    camera endon( #"hash_6aff848cb3ea9491" );
    wait time;
    
    if ( state == 3 || !isdefined( camera ) )
    {
        thread function_4e2173f801c91b9( camera, index, 0 );
        return;
    }
    
    if ( function_3c9adad27cd64792( camera ) )
    {
        thread function_4e2173f801c91b9( camera, index, 5 );
        return;
    }
    
    thread function_4e2173f801c91b9( camera, index, 1 );
}

// Namespace deployable_camera_common
// Params 4
// Checksum 0x341fcfcc, Offset: 0x34e7
// Size: 0xb4
function function_68e3f1c250bdd51f( player, unset, var_f0fa593dcaf8ac61, supername )
{
    camlist = player [[ var_f0fa593dcaf8ac61 ]]();
    
    if ( !isdefined( camlist ) )
    {
        return;
    }
    
    foreach ( camera in camlist )
    {
        camera function_feffc4d0cdb7dad3( player, unset, supername );
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x823d8b0f, Offset: 0x35a3
// Size: 0x78
function function_d1e999863ff0886a( var_1942ed602fa25adc )
{
    self endon( #"death" );
    params = function_ddb6749d6d40be33( self.cameratype );
    lifetime = getdvarint( @"hash_13717e6e87cb530f", 120 );
    function_681159fe93279157( lifetime, var_1942ed602fa25adc );
    
    if ( isdefined( self ) && !self.isdestroyed )
    {
        self thread [[ params.destroyfunc ]]();
    }
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0xce7e1fb0, Offset: 0x3623
// Size: 0x6c
function private function_681159fe93279157( cam_life, var_1942ed602fa25adc )
{
    if ( !var_1942ed602fa25adc )
    {
        self.owner endon( #"disconnect" );
        self.owner endon( #"joined_team" );
        self.owner endon( #"joined_spectators" );
    }
    
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithhostmigrationpause( cam_life );
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0x8a32e378, Offset: 0x3697
// Size: 0x5c
function function_76cdde25d88f4bc5( ison, keepwidget )
{
    if ( ison )
    {
        var_a3da6de359fe03cb = level.superglobals.var_da0d0ae8681f98ba[ "super_tac_camera" ];
        supers_mp::function_2ea603a86a682ab0( var_a3da6de359fe03cb );
        thread function_e92a105f62d36737();
        return;
    }
    
    supers_mp::function_2ea603a86a682ab0( 0, keepwidget );
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x153b61ba, Offset: 0x36fb
// Size: 0x7a
function function_e92a105f62d36737()
{
    if ( !isdefined( level.gametypebundle ) || !level.gametypebundle.var_a817308d8d92ff8c )
    {
        return;
    }
    
    self notify( #"decoy_monitor_death" );
    level endon( #"game_ended" );
    self endon( #"hash_e5c88820139da8f2" );
    self waittill( #"death" );
    function_76cdde25d88f4bc5( 0 );
    function_4d9ff7e202d60950( "tacCam" );
    self notify( #"tacticalCamera_allCamerasRemoved" );
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xfabae6fa, Offset: 0x377d
// Size: 0x246
function function_fc36c51eb333434b( target )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    icansee = 0;
    tracecontents = physics_createcontents( [ "physicscontents_itemclip", "physicscontents_item", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_ainosight" ] );
    camorigin = undefined;
    
    if ( isdefined( self.pilot ) )
    {
        camorigin = self.pilot getvieworigin();
    }
    else
    {
        camorigin = self.origin + anglestoup( self.angles ) * 3.5;
    }
    
    defaultorigin = target.origin;
    tracepoints = [ defaultorigin ];
    
    if ( isplayer( target ) )
    {
        headpos = target utility::function_f02ebab438642e16();
        centerpos = target utility::function_68061c3d21a6d57a();
        tracepoints = [ headpos, centerpos, defaultorigin ];
    }
    else if ( isagent( target ) )
    {
        tracepoints = [ defaultorigin + ( 0, 0, 1 ) ];
    }
    
    ignorelist = [ self, target ];
    vehicle = target vehicle::get_vehicle();
    
    if ( isdefined( vehicle ) )
    {
        ignorelist[ ignorelist.size ] = vehicle;
        vehiclechildren = vehicle getlinkedchildren( 1 );
        
        foreach ( child in vehiclechildren )
        {
            ignorelist[ ignorelist.size ] = vehicle;
        }
    }
    
    icansee = 0;
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        trace = trace::sphere_trace( camorigin, tracepoints[ i ], 0.01, ignorelist, tracecontents, undefined, 1 );
        
        if ( trace[ "hittype" ] == "hittype_none" )
        {
            icansee = 1;
            break;
        }
    }
    
    return icansee;
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x8e019d24, Offset: 0x39cc
// Size: 0x11a
function private function_c1f1d6623c39e238( markdata, timeout )
{
    self.owner endon( #"disconnect" );
    
    if ( isdefined( self.pilot ) )
    {
        self.pilot endon( #"disconnect" );
    }
    
    target = markdata.target;
    target endon( #"death" );
    
    for ( starttime = gettime(); timeout * 1000 + starttime >= gettime() ; starttime = gettime() )
    {
        wait 0.05;
        stillviewed = 0;
        
        if ( emp_debuff::is_empd() )
        {
            break;
        }
        
        targetinfo = function_ee93ef87c2144487( target );
        
        if ( isdefined( self.pilot ) && isdefined( self ) && isdefined( self.owner ) && targetinfo.isinreticle && targetinfo.isinrange && targetinfo.isvisible )
        {
            stillviewed = 1;
        }
        
        if ( stillviewed )
        {
        }
    }
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x157e6228, Offset: 0x3aee
// Size: 0x222
function function_10c3a94e9c94aa68()
{
    pilot = self.pilot;
    pilot endon( #"disconnect" );
    self endon( #"death" );
    pilot endon( #"playerLeavingCurrentCamera" );
    var_54e4405a5938ecfc = 0;
    self.markingtarget = undefined;
    
    while ( true )
    {
        if ( !isdefined( pilot ) )
        {
            return;
        }
        
        self.targethascoldblooded = 0;
        targets = self.pilot.targetsinouterradius;
        markergroup = self.pilot function_1066089a542b3224();
        
        foreach ( player in targets )
        {
            if ( var_54e4405a5938ecfc >= 3 )
            {
                var_54e4405a5938ecfc = 0;
                waitframe();
            }
            
            if ( isplayer( player ) && !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( isagent( player ) && !isalive( player ) )
            {
                continue;
            }
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( emp_debuff::is_empd() )
            {
                continue;
            }
            
            if ( pilot function_a92703f9ea24aa6( player ) )
            {
                continue;
            }
            
            var_54e4405a5938ecfc++;
            function_177bcf71b0bf91fe( markergroup, player, 1 );
            targetinfo = function_ee93ef87c2144487( player );
            hascoldblooded = 0;
            
            if ( isplayer( player ) && isdefined( player.perks[ "specialty_noscopeoutline" ] ) )
            {
                hascoldblooded = 1;
            }
            
            if ( targetinfo.isinreticle && hascoldblooded )
            {
                self.targethascoldblooded = 1;
            }
            
            if ( hascoldblooded )
            {
                function_177bcf71b0bf91fe( markergroup, player, 3 );
                continue;
            }
            
            if ( !targetinfo.isinreticle )
            {
                continue;
            }
            
            if ( self.markingtarget )
            {
                continue;
            }
            
            thread function_ee760d33235e67c5( player, "enemy", 0, 1 );
        }
        
        var_54e4405a5938ecfc = 0;
        waitframe();
    }
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0x2ae73387, Offset: 0x3d18
// Size: 0x80
function private function_8c887d6ba3510e29( target )
{
    if ( !isdefined( self.var_f8fc9155443446cd ) )
    {
        self.var_f8fc9155443446cd = [];
    }
    
    if ( isdefined( self.var_f8fc9155443446cd[ target getentitynumber() ] ) )
    {
        return;
    }
    
    sensordata = spawnstruct();
    sensordata.target = target;
    sensordata.entnum = target getentitynumber();
    self.var_f8fc9155443446cd[ target getentitynumber() ] = sensordata;
    return sensordata;
}

// Namespace deployable_camera_common
// Params 3, eflags: 0x4
// Checksum 0x4a55304f, Offset: 0x3da0
// Size: 0x5f
function private function_8c0c01b163c29936( sensordata, sensorduration, supername )
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    wait sensorduration;
    function_14ca1491a3828d2( sensordata );
    function_a3616c8dc63ff9b4( supername );
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0xdc4b3b4e, Offset: 0x3e07
// Size: 0x3a
function private function_14ca1491a3828d2( sensordata )
{
    if ( isdefined( self.var_f8fc9155443446cd[ sensordata.entnum ] ) )
    {
        self.var_f8fc9155443446cd[ sensordata.entnum ] = undefined;
    }
}

// Namespace deployable_camera_common
// Params 3, eflags: 0x4
// Checksum 0xfc0cad5b, Offset: 0x3e49
// Size: 0x89
function private function_127a202e856237a1( target, sensorduration, supername )
{
    sensordata = function_8c887d6ba3510e29( target );
    
    if ( !isdefined( sensordata ) )
    {
        return;
    }
    
    self playsoundtoplayer( #"ui_camera_proximity_alert", self.owner, self );
    function_a3616c8dc63ff9b4( supername );
    self.owner thread function_4e2173f801c91b9( self, self.ownerindex, 2, undefined, 3.25 );
    thread function_8c0c01b163c29936( sensordata, sensorduration, supername );
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x1ae3c2a5, Offset: 0x3eda
// Size: 0x33
function function_14f7fdebaa3171b7( state )
{
    assert( state == 0 || state == 5, "<dev string:xbb>" );
    self setclientomnvar( "ui_rcd_controls", state );
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x28fc89b, Offset: 0x3f15
// Size: 0x15a
function private function_ef44a5d11deb7bdc( camera, overrideholdtime )
{
    if ( !( isdefined( self ) && isdefined( camera ) ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"end_remote" );
    self endon( #"monitoringexit" );
    camera endon( #"death" );
    
    while ( self usebuttonpressed() )
    {
        waitframe();
    }
    
    holdtime = getdvarfloat( @"hash_8720ead849d3fbc3", 0.25 );
    
    if ( isdefined( overrideholdtime ) )
    {
        holdtime = overrideholdtime;
    }
    
    updaterate = level.framedurationseconds;
    timerdirty = 1;
    
    while ( true )
    {
        timeused = 0;
        
        if ( timerdirty == 1 )
        {
            self setclientomnvar( "ui_exit_progress", 0 );
            timerdirty = 0;
        }
        
        while ( self usebuttonpressed() )
        {
            if ( self.var_6756a2edd554e05e )
            {
                break;
            }
            
            isgamepad = self usinggamepad();
            
            if ( !isgamepad && camera.cameratype == "tacCam" )
            {
                holdtime = 0.01;
            }
            
            timeused += updaterate;
            timerdirty = 1;
            self setclientomnvar( "ui_exit_progress", timeused / holdtime );
            
            if ( timeused > holdtime )
            {
                self notify( #"cameraexit" );
                return;
            }
            
            wait updaterate;
        }
        
        wait updaterate;
    }
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0xbf915b43, Offset: 0x4077
// Size: 0x87
function function_fb22f7c7f74485a8( camera, var_4e609d3aa99e260f, cameratype )
{
    level endon( #"game_ended" );
    camera endon( #"death" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c22f384ac118b628" );
    
    if ( !isdefined( var_4e609d3aa99e260f ) )
    {
        var_4e609d3aa99e260f = function_ddb6749d6d40be33( cameratype ).exitfunc;
    }
    
    childthread function_ef44a5d11deb7bdc( camera );
    self waittill( #"cameraexit" );
    self thread [[ var_4e609d3aa99e260f ]]( camera, 0 );
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0xa97a3312, Offset: 0x4106
// Size: 0x58
function function_cc8faead62cecf93( camera, cameratype )
{
    camswitched = function_faf04f5687549ef2( camera );
    
    if ( !camswitched && !self.var_6756a2edd554e05e )
    {
        self thread [[ function_ddb6749d6d40be33( cameratype ).exitfunc ]]( camera, 0, 1 );
    }
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0xa3b1a403, Offset: 0x4166
// Size: 0x8d
function function_894a6efeebf366ae( camera, clustername, cameratype )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c22f384ac118b628" );
    camera endon( #"death" );
    
    while ( true )
    {
        var_88702fa0a54d3e78 = arraycontains( self.var_6a9b943529a63d39[ clustername ], camera );
        
        if ( !var_88702fa0a54d3e78 )
        {
            break;
        }
        
        wait 0.25;
    }
    
    function_cc8faead62cecf93( camera, cameratype );
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x34dcdf95, Offset: 0x41fb
// Size: 0xe2
function private function_e58da04a04de22d8( markdata, camuser )
{
    teamref = camuser.team;
    
    if ( level.teambased )
    {
        if ( isdefined( level.var_2fdcca6e52968129 ) )
        {
            if ( squad_utility::shouldmodesetsquads() )
            {
                if ( isdefined( level.var_2fdcca6e52968129[ teamref ][ camuser.sessionsquadid ] ) )
                {
                    level.var_2fdcca6e52968129[ teamref ][ camuser.sessionsquadid ][ markdata.targetnum ] = undefined;
                }
            }
            else if ( isdefined( level.var_2fdcca6e52968129[ teamref ] ) )
            {
                level.var_2fdcca6e52968129[ teamref ][ markdata.targetnum ] = undefined;
            }
        }
        
        return;
    }
    
    if ( isdefined( camuser.markedents ) )
    {
        camuser.markedents[ markdata.targetnum ] = undefined;
    }
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0xee37c342, Offset: 0x42e5
// Size: 0x126
function private function_969e52ec2d50a0b0( markdata, camuser )
{
    teamref = camuser.team;
    
    if ( level.teambased )
    {
        if ( !isdefined( level.var_2fdcca6e52968129 ) )
        {
            level.var_2fdcca6e52968129 = [];
        }
        
        if ( !isdefined( level.var_2fdcca6e52968129[ teamref ] ) )
        {
            level.var_2fdcca6e52968129[ teamref ] = [];
        }
        
        if ( squad_utility::shouldmodesetsquads() )
        {
            if ( !isdefined( level.var_2fdcca6e52968129[ teamref ][ camuser.sessionsquadid ] ) )
            {
                level.var_2fdcca6e52968129[ teamref ][ camuser.sessionsquadid ] = [];
            }
            
            level.var_2fdcca6e52968129[ teamref ][ camuser.sessionsquadid ][ markdata.targetnum ] = markdata;
        }
        else
        {
            level.var_2fdcca6e52968129[ teamref ][ markdata.targetnum ] = markdata;
        }
        
        return;
    }
    
    if ( !isdefined( camuser.markedents ) )
    {
        camuser.markedents = [];
    }
    
    camuser.markedents[ markdata.targetnum ] = markdata;
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0xce1a3c9, Offset: 0x4413
// Size: 0x16c
function function_5f1d60e42bc86b5( markdata, camuser, useoutline )
{
    entityheadicons::setheadicon_deleteicon( markdata.headicon );
    teamref = camuser.team;
    markergroup = camuser function_1066089a542b3224();
    function_e58da04a04de22d8( markdata, camuser );
    
    if ( isdefined( markdata.target ) )
    {
        if ( isdefined( markergroup ) && targetmarkergroups::targetmarkergroupexists( markergroup ) )
        {
            function_177bcf71b0bf91fe( markergroup, markdata.target, 0 );
        }
        
        markdata.reconmarked = undefined;
        markdata.beingmarked = undefined;
        
        if ( isplayer( markdata.target ) && useoutline )
        {
            if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
            {
                [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( markdata.outlineid, markdata.target );
            }
            
            if ( utility::issharedfuncdefined( #"outline", #"hash_ce25f2d2639fdd76" ) )
            {
                markdata.target [[ utility::getsharedfunc( #"outline", #"hash_ce25f2d2639fdd76" ) ]]();
            }
        }
        
        markdata.target notify( markdata.notifytoendmark );
    }
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xc2949126, Offset: 0x4587
// Size: 0x29
function function_5b1f7b697350a2a6()
{
    var_7237854e3be197ca = self.pilot;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return self.owner;
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0xe36b3689, Offset: 0x45b9
// Size: 0x131
function function_41b35e7097ad264c( waitnotification, omnvarprefix, var_d6b6245a5e67e907 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( var_d6b6245a5e67e907 );
    laststate = [];
    
    while ( true )
    {
        self waittill( waitnotification, camera, index, state, forcestate, time );
        
        if ( isdefined( laststate[ index ] ) )
        {
            if ( isdefined( laststate[ index ][ 0 ] ) )
            {
                if ( laststate[ index ][ 0 ] != camera )
                {
                    if ( state == 0 || state == 3 || state == 5 )
                    {
                        continue;
                    }
                }
            }
        }
        
        print( "<dev string:xf0>" + index + "<dev string:xf8>" + state + "<dev string:x109>" );
        self setclientomnvar( omnvarprefix + index + "_status", state );
        
        if ( state > 1 && state != 5 )
        {
            childthread function_d28f90ba0d31e7f( camera, index, state, time );
        }
        
        if ( !isdefined( camera ) )
        {
            laststate[ index ] = undefined;
            continue;
        }
        
        laststate[ index ] = [ camera, state ];
    }
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x7a62f6b4, Offset: 0x46f2
// Size: 0x40
function function_8c3012bc6c42ee15()
{
    starttime = gettime();
    timeelapsed = starttime;
    
    while ( timeelapsed < starttime + 10 )
    {
        thread function_14f7fdebaa3171b7( 0 );
        timeelapsed += gettime() - timeelapsed;
        waitframe();
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x2013d4bb, Offset: 0x473a
// Size: 0x9e
function function_faf001f4f21b77e0( camera )
{
    ingroup = 0;
    
    if ( !isdefined( camera.owner ) )
    {
        return 0;
    }
    
    if ( level.teambased )
    {
        if ( squad_utility::shouldmodesetsquads() )
        {
            if ( camera.owner.sessionsquadid == self.sessionsquadid )
            {
                ingroup = 1;
            }
        }
        else if ( camera.ownerteam == self.team )
        {
            ingroup = 1;
        }
    }
    else if ( camera.owner == self )
    {
        ingroup = 1;
    }
    
    return ingroup;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xda85b1, Offset: 0x47e1
// Size: 0x20a
function function_9f0d007536d7a818( target )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    camangles = self gettagangles( "tag_player" );
    var_5f6f9fd6d37e2309 = self gettagorigin( "tag_player" );
    
    if ( isdefined( self.pilot ) )
    {
        camangles = self.pilot getplayerangles();
        var_5f6f9fd6d37e2309 = self.pilot getvieworigin();
    }
    
    var_daeec451db6b2c18 = anglestoforward( camangles );
    defaultorigin = target.origin;
    headpos = target utility::function_f02ebab438642e16();
    centerpos = target utility::function_68061c3d21a6d57a();
    tracepoints = [ headpos, centerpos, defaultorigin ];
    var_f32175be69573064 = 0;
    
    foreach ( point in tracepoints )
    {
        var_ed78cebaaf406db2 = point - var_5f6f9fd6d37e2309;
        dotangle = math::anglebetweenvectors( var_daeec451db6b2c18, var_ed78cebaaf406db2 );
        var_64bff1f7d7255965 = math::anglebetweenvectors( var_daeec451db6b2c18, ( 0, 0, 1 ) );
        var_d0805c7cd34d458f = math::anglebetweenvectors( var_ed78cebaaf406db2, ( 0, 0, 1 ) );
        
        if ( isdefined( self.pilot ) )
        {
            var_682671af05015e79 = distancesquared( var_5f6f9fd6d37e2309, point );
            
            if ( var_682671af05015e79 > 10000 )
            {
                if ( abs( abs( var_64bff1f7d7255965 ) - abs( var_d0805c7cd34d458f ) ) > getdvarfloat( @"hash_77f60c1216fca977", 19 ) )
                {
                    return var_f32175be69573064;
                }
            }
        }
        
        if ( dotangle <= getdvarfloat( @"hash_a20d9fbeab627f6", 31 ) )
        {
            var_f32175be69573064 = 1;
        }
    }
    
    return var_f32175be69573064;
}

// Namespace deployable_camera_common
// Params 3, eflags: 0x4
// Checksum 0xb3d7ba31, Offset: 0x49f4
// Size: 0x23c
function private function_3f48718bebe00fff( scantarget, scanfov, var_aa7184ffa413de37 )
{
    if ( !isdefined( scantarget ) )
    {
        return 0;
    }
    
    inreticle = 0;
    targetorigin = scantarget.origin;
    scanpoints = [ targetorigin ];
    var_22662a0ba7e2796f = distancesquared( self getvieworigin(), scantarget.origin );
    var_eecf962c623168b7 = 0;
    
    if ( var_22662a0ba7e2796f <= 10000 )
    {
        var_aa7184ffa413de37 *= getdvarfloat( @"hash_20c9852b3129de04", 2.5 );
        var_eecf962c623168b7 = 1;
    }
    
    if ( isplayer( scantarget ) )
    {
        istargethanging = scantarget ishanging();
        headpos = scantarget utility::function_f02ebab438642e16();
        centerpos = scantarget utility::function_68061c3d21a6d57a();
        scanpoints = [ headpos, centerpos ];
        
        if ( !istargethanging )
        {
            scanpoints[ scanpoints.size ] = targetorigin;
        }
        
        if ( var_eecf962c623168b7 )
        {
            var_52368d99bba6a1f = ( headpos + centerpos ) / 2;
            extrapoints = [ var_52368d99bba6a1f ];
            
            if ( !istargethanging )
            {
                var_1650621827375595 = ( centerpos + targetorigin ) / 2;
                extrapoints[ extrapoints.size ] = var_1650621827375595;
            }
            
            scanpoints = arraycombine( scanpoints, extrapoints );
        }
    }
    else if ( isagent( scantarget ) )
    {
        centerpos = scantarget agent_utility::function_305eb563bc53733d();
        headpos = scantarget agent_utility::function_fa6ba9e10b560337();
        scanpoints = [ targetorigin + ( 0, 0, 1 ), centerpos, headpos ];
        
        if ( var_eecf962c623168b7 )
        {
            var_1650621827375595 = ( centerpos + targetorigin ) / 2;
            var_52368d99bba6a1f = ( headpos + centerpos ) / 2;
            extrapoints = [ var_1650621827375595, var_52368d99bba6a1f ];
            scanpoints = arraycombine( scanpoints, extrapoints );
        }
    }
    
    foreach ( point in scanpoints )
    {
        if ( self worldpointinreticle_circle( point, scanfov, var_aa7184ffa413de37 ) )
        {
            inreticle = 1;
            break;
        }
    }
    
    return inreticle;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xaa55f69d, Offset: 0x4c39
// Size: 0x2e
function function_962db5d245c5bfed( target )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    return arraycontains( self.pilot.targetsinouterradius, target );
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x79a7d103, Offset: 0x4c70
// Size: 0x19, Type: bool
function function_15ee4c2022ab516b( camera )
{
    return self == camera.pilot;
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x4f29d6e9, Offset: 0x4c92
// Size: 0x25
function deployablecamera_makeunusable()
{
    self notify( #"supportbox_makeunusable" );
    interactive::interactive_removeusedcallbackfromentity();
    self makeunusable();
    self.playersused = undefined;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xb6cd3fc7, Offset: 0x4cbf
// Size: 0x37
function function_f7bcf5a27c1854dc( ison )
{
    partstate = "off";
    
    if ( ison )
    {
        partstate = "on";
    }
    
    self setscriptablepartstate( "target_marked", partstate, 0 );
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xabe64040, Offset: 0x4cfe
// Size: 0x8e
function function_b3971f2e436bebe7( markdata )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        function_c16c4c3d7ac0cb4( markdata, player );
    }
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0xe2bc199c, Offset: 0x4d94
// Size: 0x9d
function function_c16c4c3d7ac0cb4( markdata, player )
{
    if ( !isdefined( markdata ) )
    {
        return;
    }
    
    isfriendly = function_f8bb1ca430334609( markdata, player );
    isusingcamera = isdefined( markdata.markingent ) && player.isusingcamera;
    
    if ( isdefined( markdata.headicon ) )
    {
        if ( isfriendly && !isusingcamera )
        {
            entityheadicons::setheadicon_addclienttomask( markdata.headicon, player );
            return;
        }
        
        entityheadicons::setheadicon_removeclientfrommask( markdata.headicon, player );
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xcc4fbb54, Offset: 0x4e39
// Size: 0x17
function function_caf66d04fb09d8bd( maxz )
{
    level.tacticalcameramaxheight = maxz;
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x49787e08, Offset: 0x4e58
// Size: 0xb4, Type: bool
function function_70e93e9c74630a4()
{
    if ( function_f35f40c6ca43f5da( self.cameratype, self.origin, self.owner.team ) )
    {
        return false;
    }
    
    if ( outofbounds::ispointinoutofbounds( self.origin, self.owner.team ) )
    {
        return false;
    }
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = self [[ level.var_59abd25eeb5b2fed ]]();
        
        if ( !canplant )
        {
            return false;
        }
    }
    
    if ( !isdefined( level.tacticalcameramaxheight ) )
    {
        return true;
    }
    
    if ( self.origin[ 2 ] > level.tacticalcameramaxheight )
    {
        return false;
    }
    
    return true;
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x88a5bded, Offset: 0x4f15
// Size: 0xbf
function function_d770be120fa6fe91()
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    cameradestroyfunc = function_ddb6749d6d40be33( self.cameratype ).destroyfunc;
    
    while ( true )
    {
        isoob = outofbounds::ispointinoutofbounds( self.origin, self.owner.team );
        var_efc71c5244a14ca8 = function_70e93e9c74630a4();
        
        if ( isoob || !var_efc71c5244a14ca8 )
        {
            if ( self.isingraceperiod )
            {
                self.owner supers_mp::refundsuper();
            }
            
            self thread [[ cameradestroyfunc ]]();
        }
        
        wait 0.1;
    }
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0x30c5d4ac, Offset: 0x4fdc
// Size: 0xfb
function function_f35f40c6ca43f5da( cameratype, pointtocheck, teamtocheck )
{
    pointinoutofbounds = 0;
    var_7182fec6c8cc9e0b = function_ddb6749d6d40be33( cameratype ).var_c3053b6cc88402ae;
    
    if ( !isdefined( var_7182fec6c8cc9e0b ) )
    {
        return pointinoutofbounds;
    }
    else
    {
        foreach ( trigger in var_7182fec6c8cc9e0b )
        {
            if ( ispointinvolume( pointtocheck, trigger ) )
            {
                if ( isdefined( trigger.script_team ) && isdefined( teamtocheck ) && trigger.script_team != teamtocheck )
                {
                    continue;
                }
                
                pointinoutofbounds = 1;
                break;
            }
        }
    }
    
    return pointinoutofbounds;
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xcbdff669, Offset: 0x50e0
// Size: 0x3a, Type: bool
function function_b373db29b219ef53()
{
    if ( !isdefined( self.creationtime ) )
    {
        return true;
    }
    
    if ( self.creationtime + 50 >= gettime() )
    {
        return true;
    }
    
    if ( self.destroyedoninit )
    {
        return true;
    }
    
    return false;
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0x15ad4ac2, Offset: 0x5123
// Size: 0x9a
function function_76bae8f797234de8( camera, unsetnotif, cameratype )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    camera endon( #"entering" );
    
    if ( isdefined( unsetnotif ) )
    {
        self endon( unsetnotif );
    }
    
    var_4e609d3aa99e260f = function_ddb6749d6d40be33( cameratype ).exitfunc;
    utility::waittill_any( "death", "killed_player", "last_stand_enter", "successful_exfil" );
    
    if ( self.isusingcamera )
    {
        [[ var_4e609d3aa99e260f ]]( camera, 0 );
    }
}

// Namespace deployable_camera_common
// Params 5
// Checksum 0xac20af21, Offset: 0x51c5
// Size: 0x1d6
function function_20c343566c160c96( clustername, unsetnotif, var_4c1c2a8cce6fc553, maxdistsq, var_f0fa593dcaf8ac61 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( unsetnotif );
    self notify( #"hash_561f9fd39d6ab3f" );
    self endon( #"hash_561f9fd39d6ab3f" );
    
    if ( !isdefined( self.var_6a9b943529a63d39 ) )
    {
        self.var_6a9b943529a63d39 = [];
    }
    
    self.var_6a9b943529a63d39[ clustername ] = [];
    childthread function_7de37abc3c87d0b1( clustername, var_4c1c2a8cce6fc553 );
    
    while ( true )
    {
        waitframe();
        cameragroup = self [[ var_f0fa593dcaf8ac61 ]]();
        
        if ( !isdefined( cameragroup ) )
        {
            continue;
        }
        
        foreach ( camera in cameragroup )
        {
            var_88702fa0a54d3e78 = arraycontains( self.var_6a9b943529a63d39[ clustername ], camera );
            
            if ( !isdefined( camera ) || camera.isdestroyed )
            {
                if ( var_88702fa0a54d3e78 )
                {
                    function_e1af9d9b5736aa4a( camera, clustername );
                }
                
                continue;
            }
            
            if ( distancesquared( self.origin, camera.origin ) <= maxdistsq )
            {
                if ( !var_88702fa0a54d3e78 )
                {
                    if ( camera.owner == self )
                    {
                        function_80dccac2fc2fadb4( camera, 0 );
                    }
                    
                    function_8411561a7c1f7cd6( camera, clustername );
                }
                
                continue;
            }
            
            if ( var_88702fa0a54d3e78 )
            {
                if ( camera.owner == self )
                {
                    function_80dccac2fc2fadb4( camera, 1 );
                }
                
                function_e1af9d9b5736aa4a( camera, clustername );
            }
        }
    }
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x14517460, Offset: 0x53a3
// Size: 0x43
function private function_80dccac2fc2fadb4( camera, isoor )
{
    camera.var_ef6798cd5792e898 = isoor;
    thread function_4e2173f801c91b9( camera, camera.ownerindex, isoor ? 5 : 1 );
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0xbf0f22fe, Offset: 0x53ee
// Size: 0x18, Type: bool
function private function_3c9adad27cd64792( camera )
{
    return istrue( camera.var_ef6798cd5792e898 );
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x47671460, Offset: 0x540f
// Size: 0x4d
function private function_7de37abc3c87d0b1( clustername, var_4c1c2a8cce6fc553 )
{
    while ( true )
    {
        level waittill( var_4c1c2a8cce6fc553, camera );
        
        if ( arraycontains( self.var_6a9b943529a63d39[ clustername ], camera ) )
        {
            function_e1af9d9b5736aa4a( camera, clustername );
        }
    }
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x1a83304c, Offset: 0x5464
// Size: 0x31
function private function_8411561a7c1f7cd6( camera, clustername )
{
    self.var_6a9b943529a63d39[ clustername ][ self.var_6a9b943529a63d39[ clustername ].size ] = camera;
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0xe72f4dbb, Offset: 0x549d
// Size: 0x33
function private function_e1af9d9b5736aa4a( camera, clustername )
{
    self.var_6a9b943529a63d39[ clustername ] = arrayremove( self.var_6a9b943529a63d39[ clustername ], camera );
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x33fbaeb2, Offset: 0x54d8
// Size: 0x19d
function private function_6ec4f1e38482468c( target, camera )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    camera endon( #"death" );
    camera endon( #"emp_applied" );
    markergroup = function_1066089a542b3224();
    
    if ( !isdefined( markergroup ) )
    {
        return;
    }
    
    self.targetsinouterradius[ self.targetsinouterradius.size ] = target;
    targetmarkergroups::targetmarkergroup_markentity( target, markergroup, 0 );
    function_177bcf71b0bf91fe( markergroup, target, 0 );
    self playlocalsound( "equip_tactical_cam_passive_marked" );
    
    while ( isdefined( target ) )
    {
        if ( isplayer( target ) && !player::isreallyalive( target ) )
        {
            break;
        }
        
        if ( isagent( target ) && !isalive( target ) )
        {
            break;
        }
        
        targetinfo = camera function_ee93ef87c2144487( target );
        
        if ( !function_a92703f9ea24aa6( target ) )
        {
            if ( !targetinfo.isindetectrange || !targetinfo.isvisible || !targetinfo.var_f32175be69573064 )
            {
                break;
            }
        }
        
        waitframe();
    }
    
    if ( isdefined( target ) )
    {
        markergroup = function_1066089a542b3224();
        
        if ( isdefined( markergroup ) )
        {
            if ( targetmarkergroups::targetmarkergroupexists( markergroup ) && !function_a92703f9ea24aa6( target ) )
            {
                targetmarkergroups::targetmarkergroup_unmarkentity( target, markergroup );
            }
        }
        
        if ( arraycontains( self.targetsinouterradius, target ) )
        {
            self.targetsinouterradius = arrayremove( self.targetsinouterradius, target );
        }
        
        return;
    }
    
    self.targetsinouterradius = function_5713d46873b29625( self.targetsinouterradius );
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x9591b6b2, Offset: 0x567d
// Size: 0xf0, Type: bool
function private function_7d2b84bcac4eab48( camera, ent )
{
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( isplayer( ent ) )
    {
        if ( !player::isreallyalive( ent ) )
        {
            return false;
        }
    }
    
    if ( isagent( ent ) && !isalive( ent ) )
    {
        return false;
    }
    
    if ( level.teambased )
    {
        if ( ent.team == self.team )
        {
            return false;
        }
    }
    else
    {
        if ( isplayer( ent ) && ent == self )
        {
            return false;
        }
        
        if ( ent.owner == self )
        {
            return false;
        }
    }
    
    if ( !camera deployablecamera_isindetectrange( ent ) )
    {
        return false;
    }
    
    if ( function_a92703f9ea24aa6( ent ) )
    {
        return false;
    }
    
    if ( camera emp_debuff::is_empd() )
    {
        return false;
    }
    
    if ( camera function_962db5d245c5bfed( ent ) )
    {
        return false;
    }
    
    if ( !camera function_9f0d007536d7a818( ent ) )
    {
        return false;
    }
    
    if ( !camera function_fc36c51eb333434b( ent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x6f150cd7, Offset: 0x5776
// Size: 0x11f
function function_1c744cbefa3cb8f( camera )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    camera endon( #"death" );
    self endon( #"playerLeavingCurrentCamera" );
    self.targetsinouterradius = [];
    entmask = createentitytypemask( [ "etype_player", "etype_ai" ] );
    
    while ( true )
    {
        targetarray = getentitiesinradiusfrompartitiongrid( camera.origin, 1575, entmask );
        
        foreach ( ent in targetarray )
        {
            var_95bc28949d98dde7 = function_7d2b84bcac4eab48( camera, ent );
            
            if ( var_95bc28949d98dde7 )
            {
                thread function_6ec4f1e38482468c( ent, camera );
            }
        }
        
        wait 0.25;
    }
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0xdbb18065, Offset: 0x589d
// Size: 0x23e
function function_fd179e6b66b289cc( duration, supername )
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"entering" );
    entmask = createentitytypemask( [ "etype_player", "etype_ai" ] );
    
    while ( true )
    {
        targetarray = getentitiesinradiusfrompartitiongrid( self.origin, 1575, entmask );
        
        foreach ( ent in targetarray )
        {
            if ( !isdefined( ent ) )
            {
                continue;
            }
            
            if ( isplayer( ent ) || isbot( ent ) )
            {
                if ( !player::isreallyalive( ent ) )
                {
                    continue;
                }
            }
            
            if ( isagent( ent ) && !isalive( ent ) )
            {
                continue;
            }
            
            if ( level.teambased )
            {
                if ( ent.team == self.ownerteam )
                {
                    continue;
                }
            }
            else if ( ent == self.owner )
            {
                continue;
            }
            
            if ( emp_debuff::is_empd() )
            {
                continue;
            }
            
            targetinfo = function_ee93ef87c2144487( ent );
            
            if ( !targetinfo.isinrange || !targetinfo.isvisible || !targetinfo.isindetectrange || !targetinfo.var_f32175be69573064 )
            {
                continue;
            }
            
            if ( self.owner function_a92703f9ea24aa6( ent ) )
            {
                continue;
            }
            
            if ( self.markingtarget )
            {
                continue;
            }
            
            params = function_ddb6749d6d40be33( self.cameratype );
            function_127a202e856237a1( ent, params.sensorduration, params.supername );
        }
        
        wait 0.25;
    }
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x592ab47d, Offset: 0x5ae3
// Size: 0x221
function function_eade58584f77d529()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self setmode( "manual" );
    worldup = anglestoup( ( 0, 0, 1 ) );
    grenadeup = anglestoup( self.angles );
    dotresult = vectordot( worldup, grenadeup );
    var_d2874fdec74424d6 = dotresult < -0.001;
    var_dd251ffa07eaab69 = dotresult >= -0.001 && dotresult <= 0.001;
    turretonground = dotresult > 0.001;
    
    if ( var_dd251ffa07eaab69 )
    {
        middlevec = anglestoup( self.angles );
        middleangles = vectortoangles( middlevec );
    }
    else
    {
        middlevec = anglestoforward( self.angles );
        middleangles = vectortoangles( middlevec );
    }
    
    direction = 1;
    destvec = anglestoright( middleangles );
    destfwd = anglestoforward( middleangles );
    destpos = self.origin + destvec * 100 * direction;
    destent = utility::spawn_script_origin( destpos );
    level thread utility::draw_angles( middleangles, self.origin, ( 1, 0, 0 ), 1000, 50 );
    
    while ( true )
    {
        self settargetentity( destent );
        level thread utility::draw_angles( middleangles, destpos, ( 1, 0, 0 ), 1000, 50 );
        anglediff = math::anglebetweenvectors( anglestoforward( self gettagangles( "tag_player" ) ), destvec );
        
        while ( anglediff > 10 && anglediff < 170 )
        {
            anglediff = math::anglebetweenvectors( anglestoforward( self gettagangles( "tag_player" ) ), destvec );
            waitframe();
        }
        
        direction *= -1;
        destpos = self.origin + destvec * 100 * direction;
        destent.origin = destpos;
        self cleartargetentity();
        waitframe();
    }
}

// Namespace deployable_camera_common
// Params 4, eflags: 0x4
// Checksum 0xaeffde93, Offset: 0x5d0c
// Size: 0x252
function private function_ee760d33235e67c5( target, targettype, useheadicon, useoutline )
{
    pilot = self.pilot;
    pilot endon( #"disconnect" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"explode" );
    pilot endon( #"playerLeavingCurrentCamera" );
    params = function_ddb6749d6d40be33( self.cameratype );
    markdata = spawnstruct();
    markdata.target = target;
    markdata.targetnum = target getentitynumber();
    markdata.markingent = self;
    markdata.ownerteam = self.ownerteam;
    markdata.outlineid = undefined;
    markdata.headicon = undefined;
    markdata.beingmarked = undefined;
    markdata.reconmarked = undefined;
    markdata.notifytoendmark = "unmarked_" + markdata.targetnum;
    
    if ( !isdefined( markdata.targetnum ) )
    {
        return;
    }
    
    if ( !isdefined( pilot ) )
    {
        return;
    }
    
    markergroup = pilot function_1066089a542b3224();
    
    if ( !isdefined( markergroup ) )
    {
        return;
    }
    
    self.markingtarget = 1;
    pilot notify( #"marking_target" );
    var_943be17e54d3e21 = self [[ params.var_2eb55a80f88c3746 ]]( target );
    pilot playlocalsound( params.markingsfx );
    self setscriptablepartstate( "marking_target", "on", 0 );
    
    while ( var_943be17e54d3e21 > 0 )
    {
        markdata.beingmarked = 1;
        
        if ( !isdefined( target ) )
        {
            return;
        }
        
        if ( !pilot function_3f48718bebe00fff( target, 80, 40 ) )
        {
            markdata.beingmarked = undefined;
            self.markingtarget = undefined;
            pilot stoplocalsound( "equip_tactical_cam_marking" );
            self setscriptablepartstate( "marking_target", "off", 0 );
            pilot function_14f7fdebaa3171b7( 5 );
            return;
        }
        
        var_943be17e54d3e21 -= 0.05;
        wait 0.05;
    }
    
    self thread [[ params.var_1d66ed73336b96f5 ]]( markdata, pilot, target, targettype, useheadicon, useoutline );
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0xf51b809f, Offset: 0x5f66
// Size: 0x18, Type: bool
function private function_2fd2512b36bd4e72( target )
{
    return istrue( target.beingmarked );
}

// Namespace deployable_camera_common
// Params 4
// Checksum 0xd8e5fd9c, Offset: 0x5f87
// Size: 0x8e
function function_c9ccf471e81ef3dd( markdata, camuser, timeout, useoutline )
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"explode" );
    target = markdata.target;
    target endon( markdata.notifytoendmark );
    function_c1f1d6623c39e238( markdata, timeout );
    function_5f1d60e42bc86b5( markdata, camuser, useoutline );
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x8d642242, Offset: 0x601d
// Size: 0x9d
function private function_82ffe97b500a3807( delaytime, var_b9c26f0544eb0a10 )
{
    pilot = self.pilot;
    
    if ( !isdefined( pilot ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death" );
    pilot endon( #"playerLeavingCurrentCamera" );
    pilot endon( #"disconnect" );
    pilot endon( #"marking_target" );
    wait delaytime;
    
    if ( pilot.isusingcamera && pilot.currentcamera == self )
    {
        pilot function_14f7fdebaa3171b7( var_b9c26f0544eb0a10 );
    }
}

// Namespace deployable_camera_common
// Params 4
// Checksum 0xc45cebd7, Offset: 0x60c2
// Size: 0x2e3, Type: bool
function function_458a4d14b62d1b8b( markdata, camerauser, useheadicon, useoutline )
{
    target = markdata.target;
    params = function_ddb6749d6d40be33( self.cameratype );
    markedents = function_2a2cd4c489f881c2( camerauser );
    
    if ( isdefined( markedents[ markdata.targetnum ] ) )
    {
        return false;
    }
    
    function_969e52ec2d50a0b0( markdata, camerauser );
    targettype = "player";
    
    if ( isagent( target ) )
    {
        targettype = "agent";
    }
    
    self [[ params.var_e0a8f87cf8290970 ]]( markdata.target, targettype );
    markicon = "hud_icon_new_marked";
    
    if ( entityheadicons::function_aeb3fc6af7792562() )
    {
        markicon = "hud_icon_head_marked";
    }
    
    var_f973a055a629002d = 8;
    
    if ( isplayer( target ) )
    {
        if ( useoutline )
        {
            if ( level.teambased )
            {
                if ( utility::issharedfuncdefined( #"outline", #"outlineenableforteam" ) )
                {
                    markdata.outlineid = [[ utility::getsharedfunc( #"outline", #"outlineenableforteam" ) ]]( target, "orange", self.owner.team, 0, 1, 0, "killstreak" );
                }
            }
            else if ( utility::issharedfuncdefined( #"outline", #"outlineenableforplayer" ) )
            {
                markdata.outlineid = [[ utility::getsharedfunc( #"outline", #"outlineenableforplayer" ) ]]( target, "orange", self.owner, 0, 1, 0, "killstreak" );
            }
            
            if ( utility::issharedfuncdefined( #"outline", #"hash_ad068ada1bc7aadd" ) )
            {
                target [[ utility::getsharedfunc( #"outline", #"hash_ad068ada1bc7aadd" ) ]]( 5, 0, 1 );
            }
        }
        
        target thread function_d87e93294143124c();
        target function_8cdabce49de74f20();
        target playlocalsound( "recon_drone_spotted_plr" );
    }
    else
    {
        markstruct = function_a293349d05534f0c( markicon, var_f973a055a629002d, target );
        markicon = markstruct.weaponicon;
        var_f973a055a629002d = markstruct.weaponoffset;
    }
    
    if ( useheadicon )
    {
        markdata.headicon = target entityheadicons::setheadicon_singleimage( [], markicon, var_f973a055a629002d, 1, 4000, 500, undefined, 1, 1 );
        function_b3971f2e436bebe7( markdata );
    }
    
    if ( utility::issharedfuncdefined( #"helper_drone", #"hash_708827ce1949625e" ) )
    {
        self thread [[ utility::getsharedfunc( #"helper_drone", #"hash_708827ce1949625e" ) ]]( markdata );
    }
    
    thread function_82ffe97b500a3807( self [[ params.var_2eb55a80f88c3746 ]]( markdata.target ), 5 );
    return true;
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0xf0d2b252, Offset: 0x63ae
// Size: 0xb8
function function_fb429377bbbe4b1d( player, func )
{
    markcluster = function_2a2cd4c489f881c2( player );
    
    if ( isdefined( markcluster ) )
    {
        foreach ( ent in markcluster )
        {
            if ( ent.reconmarked )
            {
                [[ func ]]( markcluster[ ent.targetnum ], player );
            }
        }
    }
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0xa5c961c, Offset: 0x646e
// Size: 0xa7
function function_ea0e8ea15d3c3bf3( camera, isswitching, cameratype )
{
    assert( camera.pilot == self, "<dev string:x10b>" );
    notification = function_ddb6749d6d40be33( cameratype ).var_a0c3c9d5e192ce52;
    level endon( #"game_ended" );
    
    if ( !isswitching )
    {
        function_fb429377bbbe4b1d( self, &function_c16c4c3d7ac0cb4 );
        function_1ba5618c12749387();
    }
    
    camera.pilot = undefined;
    camera setscriptablepartstate( "piloted", "off", 0 );
    level notify( notification, camera );
    self remotecontrolturretoff( camera );
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0xd0d67f0b, Offset: 0x651d
// Size: 0xc9
function function_2e0bea0dd3866639( camera, isswitching )
{
    if ( isdefined( camera.watchers ) && isdefined( camera ) )
    {
        watcheridx = function_f02c63b99c9614c9( camera.watchers, self );
        
        if ( isdefined( watcheridx ) )
        {
            camera.watchers = arrayremove( camera.watchers, camera.watchers[ watcheridx ] );
            camera.var_903b12971e52e2d0 = arrayremove( camera.var_903b12971e52e2d0, camera.var_903b12971e52e2d0[ watcheridx ] );
            
            if ( !isswitching )
            {
                function_fb429377bbbe4b1d( self, &function_c16c4c3d7ac0cb4 );
                function_1ba5618c12749387();
            }
            
            self cameraunlink();
            self lerpfovbypreset( "default" );
        }
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x35cc1ce4, Offset: 0x65ee
// Size: 0xe2
function function_6223506d2fc50a2f( usingcamera )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( usingcamera )
    {
        val::set( "tactical_camera_actions", "weapon_switch", 0 );
        val::set( "tactical_camera_actions", "offhand_weapons", 0 );
        val::set( "tactical_camera_actions", "fire", 0 );
        val::set( "tactical_camera_actions", "killstreaks", 0 );
        val::set( "tactical_camera_actions", "allow_movement", 0 );
        val::set( "tactical_camera_actions", "armor", 0 );
        val::set( "tactical_camera_actions", "nvg", 0 );
        
        if ( nvg::function_c58b7b66805088f5() )
        {
            val::set( "tactical_camera_actions", "nvg", 0 );
        }
        
        function_766f0c80ab7db71c( 1 );
        return;
    }
    
    val::reset_all( "tactical_camera_actions" );
    function_766f0c80ab7db71c( 0 );
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0xf0efa957, Offset: 0x66d8
// Size: 0xc4
function private function_766f0c80ab7db71c( usingcamera )
{
    stance = self getstance();
    
    if ( usingcamera )
    {
        if ( stance == "stand" )
        {
            val::set( "tactical_camera_stance", "crouch", 0 );
            val::set( "tactical_camera_stance", "prone", 0 );
        }
        else if ( stance == "crouch" )
        {
            val::set( "tactical_camera_stance", "stand", 0 );
            val::set( "tactical_camera_stance", "prone", 0 );
        }
        else if ( stance == "prone" )
        {
            val::set( "tactical_camera_stance", "crouch", 0 );
            val::set( "tactical_camera_stance", "stand", 0 );
        }
        
        return;
    }
    
    val::reset_all( "tactical_camera_stance" );
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0x9f04a044, Offset: 0x67a4
// Size: 0x3e
function function_69c7fd6e386121d2( camera, destroyfunc, oninit )
{
    if ( camera.isingraceperiod )
    {
        thread supers_mp::refundsuper();
    }
    
    camera [[ destroyfunc ]]( 1, undefined, oninit );
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0xbbbc049e, Offset: 0x67ea
// Size: 0x1283, Type: bool
function function_3a830c0230268df4( camera, destroyfunc, oninit )
{
    camera endon( #"death" );
    debugshowlines = getdvarint( @"hash_c57f2daebacd2a11", 0 ) > 0;
    var_bc8dd5ae9fe21cb9 = getdvarint( @"hash_77164862b5dd9238", 1 ) > 0;
    shiphack = 0;
    
    if ( getdvarint( @"hash_5d72d66fef5f7d5", 0 ) == 1 )
    {
        shiphack = 1;
    }
    
    if ( shiphack && oninit )
    {
        offset = getdvarfloat( @"hash_a63eaacd700c5fe0", 0.75 );
        camera.origin += anglestoup( camera.angles ) * offset;
        wait 0.05;
    }
    
    oninit = istrue( oninit );
    
    if ( !isdefined( destroyfunc ) )
    {
        destroyfunc = function_ddb6749d6d40be33( camera.cameratype ).destroyfunc;
    }
    
    if ( oninit )
    {
        wait 0.05;
    }
    
    referenceloc = spawnstruct();
    tracestartoffset = getdvarfloat( @"hash_ea48e956738a089c", 8 );
    referenceloc.origin = camera.origin + anglestoup( camera.angles ) * tracestartoffset;
    ignorearray = [ camera, self ];
    contents = function_ddb6749d6d40be33( camera.cameratype ).orientationcontents;
    assert( isdefined( contents ), "<dev string:x15d>" );
    referenceloc.angles = camera gettagangles( "tag_origin" );
    
    if ( camera.mode == "wall" )
    {
        fwd = anglestoup( camera.angles );
        right = anglestoright( camera.angles );
        up = vectorcross( fwd, right );
        referenceloc.angles = axistoangles( fwd, right, up );
    }
    
    spheresize = getdvarfloat( @"hash_71131deb09e9dcbf", 2.125 );
    tracestart = referenceloc.origin + anglestoleft( referenceloc.angles ) * 0.2;
    tracestart += anglestoforward( referenceloc.angles ) * getdvarfloat( @"hash_9837b8c055d50463", 1 );
    fwdtraceend = tracestart + anglestoforward( referenceloc.angles ) * 16.1;
    backtraceend = tracestart + anglestoforward( referenceloc.angles ) * 16.1 * -1;
    fwdtrace = trace::sphere_trace( tracestart, fwdtraceend, 2.125, ignorearray, contents, 0, 1 );
    backtrace = trace::sphere_trace( tracestart, backtraceend, 2.125, ignorearray, contents, 0, 1 );
    
    if ( isdefined( fwdtrace[ "position" ] ) )
    {
        /#
            if ( var_bc8dd5ae9fe21cb9 )
            {
                level thread debug::drawsphere( fwdtrace[ "<dev string:x1b6>" ], 0.5, 100, ( 1, 1, 1 ) );
            }
        #/
    }
    
    if ( isdefined( backtrace[ "position" ] ) )
    {
        /#
            if ( var_bc8dd5ae9fe21cb9 )
            {
                level thread debug::drawsphere( backtrace[ "<dev string:x1b6>" ], 0.5, 100, ( 0, 0, 0 ) );
            }
        #/
    }
    
    var_d631f249d3071229 = fwdtrace[ "hittype" ] == "hittype_none";
    var_70089ff8c9181863 = backtrace[ "hittype" ] == "hittype_none";
    hitdistancesq = distancesquared( fwdtrace[ "position" ], backtrace[ "position" ] );
    hitsunsafe = hitdistancesq <= 174.504;
    var_47b4fbdbfe1eb9c6 = camera.origin + anglestoup( camera.angles ) * -1.5;
    var_5a35e333074c7074 = camera gettagorigin( "tag_player" );
    var_d37630f41a431d32 = distancesquared( backtrace[ "position" ], var_47b4fbdbfe1eb9c6 );
    var_aed05ff88509bd30 = distancesquared( fwdtrace[ "position" ], var_5a35e333074c7074 );
    
    if ( var_aed05ff88509bd30 < 3 )
    {
        function_69c7fd6e386121d2( camera, destroyfunc, oninit );
        return false;
    }
    
    var_3c73821b48350d72 = backtrace[ "position" ] - var_47b4fbdbfe1eb9c6;
    var_b8e31bf2b4f3e5ba = fwdtrace[ "position" ] - var_5a35e333074c7074;
    var_611fab15dfae2ce7 = [ 180, 180 ];
    var_1f40bce379c62972 = [ 85, 85 ];
    
    if ( !var_d631f249d3071229 && !var_70089ff8c9181863 )
    {
        if ( hitsunsafe )
        {
            function_69c7fd6e386121d2( camera, destroyfunc, oninit );
            return false;
        }
        else
        {
            tooclose = vectordot( anglestoforward( camera gettagangles( "tag_player" ) ), var_b8e31bf2b4f3e5ba ) < 1;
            
            if ( tooclose )
            {
                function_69c7fd6e386121d2( camera, destroyfunc, oninit );
                return false;
            }
            
            var_d631f249d3071229 = 1;
        }
    }
    
    if ( var_d631f249d3071229 || var_70089ff8c9181863 )
    {
        if ( !var_d631f249d3071229 && camera.mode != "wall" && oninit )
        {
            newfwd = fwdtrace[ "normal" ];
            newup = anglestoup( camera.angles );
            newright = vectorcross( newfwd, newup );
            referenceloc.angles = axistoangles( newfwd, newright, newup );
            camera.angles = referenceloc.angles;
            wait 0.05;
        }
        
        if ( !var_d631f249d3071229 || !var_70089ff8c9181863 )
        {
            if ( !var_d631f249d3071229 )
            {
                insidegeo = trace::ray_trace_detail_passed( tracestart, fwdtrace[ "position" ] + fwdtrace[ "normal" ] * -2, ignorearray, contents );
                
                if ( insidegeo )
                {
                    function_69c7fd6e386121d2( camera, destroyfunc, oninit );
                    return false;
                }
            }
            
            if ( !var_70089ff8c9181863 )
            {
                insidegeo = trace::ray_trace_detail_passed( tracestart, backtrace[ "position" ] + backtrace[ "normal" ] * -2, ignorearray, contents );
                
                if ( insidegeo )
                {
                    function_69c7fd6e386121d2( camera, destroyfunc, oninit );
                    return false;
                }
            }
            
            if ( var_d37630f41a431d32 < 174.504 || var_aed05ff88509bd30 < 174.504 )
            {
                var_611fab15dfae2ce7[ 0 ] -= 70;
                var_611fab15dfae2ce7[ 1 ] -= 70;
            }
        }
    }
    
    if ( camera.mode == "wall" )
    {
        var_611fab15dfae2ce7[ 0 ] = 110;
        var_611fab15dfae2ce7[ 1 ] = 110;
    }
    else if ( camera.mode == "ground" )
    {
        var_1f40bce379c62972[ 1 ] -= getdvarfloat( @"hash_fb3d586e02f08fc9", 30 );
    }
    else
    {
        var_1f40bce379c62972[ 0 ] -= getdvarfloat( @"hash_fb3d586e02f08fc9", 30 );
    }
    
    if ( oninit )
    {
        newfwd = utility::flatten_vector( anglestoforward( camera gettagangles( "tag_player" ) ) );
        worldup = ( 0, 0, 1 );
        newright = vectorcross( newfwd, worldup );
        referenceloc.angles = axistoangles( newfwd, newright, worldup );
        var_3fa670f87c326d7 = getdvarfloat( @"hash_630da9dbea450037", 5.5 );
        camleftoffset = getdvarfloat( @"hash_1ed9270646935e4f", 0.25 );
        var_863901f01f8bba55 = getdvarfloat( @"hash_158dbc8dfe38250f", 0.05 );
        referenceloc.origin = camera.origin + anglestoup( camera.angles ) * var_3fa670f87c326d7 + anglestoleft( referenceloc.angles ) * camleftoffset + anglestoforward( referenceloc.angles ) * var_863901f01f8bba55;
        camera.var_bad4d3368eda8ca9 = referenceloc.angles;
        camera.initialcastorigin = referenceloc.origin;
    }
    else
    {
        referenceloc.angles = camera.var_bad4d3368eda8ca9;
        referenceloc.origin = camera.initialcastorigin;
    }
    
    if ( camera.mode != "ground" && oninit )
    {
        tracetip = camera gettagorigin( "tag_player" );
        tracebase = camera gettagorigin( "tag_origin" );
        tracestarts = [ tracetip, tracebase ];
        var_306c85550e0db532 = tracetip + anglestoleft( referenceloc.angles ) * 13.21;
        var_f70c53f3f60ddc03 = tracetip + anglestoright( referenceloc.angles ) * 13.21;
        var_d463fd680f606138 = tracebase + anglestoleft( referenceloc.angles ) * 13.21;
        var_3eebb62a0ba91749 = tracebase + anglestoright( referenceloc.angles ) * 13.21;
        var_12bf111ecc767dcd = trace::ray_trace( tracetip, var_306c85550e0db532, ignorearray, contents, 0, 0, 1 );
        var_4e35d04af3dc7ac6 = trace::ray_trace( tracetip, var_f70c53f3f60ddc03, ignorearray, contents, 0, 0, 1 );
        var_b921fa6a7b3b154b = trace::ray_trace( tracebase, var_d463fd680f606138, ignorearray, contents, 0, 0, 1 );
        var_f138ad16800e83d4 = trace::ray_trace( tracebase, var_3eebb62a0ba91749, ignorearray, contents, 0, 0, 1 );
        var_216dd49696199424 = var_12bf111ecc767dcd[ "hittype" ] != "hittype_none" && var_b921fa6a7b3b154b[ "hittype" ] != "hittype_none";
        var_13f72b6bf426f85b = var_4e35d04af3dc7ac6[ "hittype" ] != "hittype_none" && var_f138ad16800e83d4[ "hittype" ] != "hittype_none";
        
        if ( var_13f72b6bf426f85b && var_216dd49696199424 )
        {
            function_69c7fd6e386121d2( camera, destroyfunc, oninit );
            return false;
        }
        else
        {
            offsetdistance = getdvarfloat( @"hash_cb3fea1ca4b915e8", 6 );
            
            if ( var_13f72b6bf426f85b )
            {
                camera.origin += anglestoleft( referenceloc.angles ) * offsetdistance;
                referenceloc.origin += anglestoleft( referenceloc.angles ) * offsetdistance;
                wait 0.05;
            }
            else if ( var_216dd49696199424 )
            {
                camera.origin += anglestoright( referenceloc.angles ) * offsetdistance;
                referenceloc.origin += anglestoright( referenceloc.angles ) * offsetdistance;
                wait 0.05;
            }
            
            camera.initialcastorigin = referenceloc.origin;
        }
        
        /#
            if ( debugshowlines )
            {
                level thread utility::draw_line_for_time( var_306c85550e0db532, var_f70c53f3f60ddc03, 0, 1, 0, 100 );
                level thread utility::draw_line_for_time( var_d463fd680f606138, var_3eebb62a0ba91749, 0, 1, 0, 100 );
            }
        #/
    }
    
    if ( oninit && camera.mode == "wall" )
    {
        lensposition = camera gettagorigin( "tag_player" );
        lensorientation = referenceloc.angles;
        traceoffset = getdvarfloat( @"hash_bb708c290ae38743", 20 );
        tracestart = lensposition + anglestoforward( lensorientation ) * -1;
        righttraceend = lensposition + anglestoforward( lensorientation ) * traceoffset + anglestoright( lensorientation ) * traceoffset;
        lefttraceend = lensposition + anglestoforward( lensorientation ) * traceoffset + anglestoleft( lensorientation ) * traceoffset;
        uptraceend = lensposition + anglestoforward( lensorientation ) * traceoffset + anglestoup( lensorientation ) * traceoffset;
        downtraceend = lensposition + anglestoforward( lensorientation ) * traceoffset + anglestoup( lensorientation ) * traceoffset * -1;
        traceends = [ righttraceend, lefttraceend, uptraceend, downtraceend ];
        uptrace = trace::sphere_trace( tracestart, uptraceend, 1, ignorearray, contents, 0, 1 );
        downtrace = trace::sphere_trace( tracestart, downtraceend, 1, ignorearray, contents, 0, 1 );
        lefttrace = trace::sphere_trace( tracestart, lefttraceend, 1, ignorearray, contents, 0, 1 );
        righttrace = trace::sphere_trace( tracestart, righttraceend, 1, ignorearray, contents, 0, 1 );
        uphit = uptrace[ "hittype" ] != "hittype_none";
        downhit = downtrace[ "hittype" ] != "hittype_none";
        lefthit = lefttrace[ "hittype" ] != "hittype_none";
        righthit = righttrace[ "hittype" ] != "hittype_none";
        
        if ( uphit && downhit || lefthit && righthit )
        {
            function_69c7fd6e386121d2( camera, destroyfunc, oninit );
            return false;
        }
        
        /#
            if ( debugshowlines )
            {
                level thread utility::draw_line_for_time( tracestart, uptraceend, 1, 0, 0, 100 );
                level thread utility::draw_line_for_time( tracestart, downtraceend, 1, 0, 0, 100 );
                level thread utility::draw_line_for_time( tracestart, lefttraceend, 1, 0, 0, 100 );
                level thread utility::draw_line_for_time( tracestart, righttraceend, 1, 0, 0, 100 );
            }
        #/
    }
    
    var_4bfa385e816ba179 = getdvarfloat( @"hash_3c8365aa23c0a4e9", 8.5 );
    tracestart = referenceloc.origin;
    tracearray = physics_spherecast( tracestart, tracestart, var_4bfa385e816ba179, contents, ignorearray, "physicsquery_all", "physicsquery_all", 1 );
    var_4d11ee561215b1d5 = 6.65;
    var_c858f63dfe947195 = 2.4;
    
    if ( camera.mode == "wall" )
    {
        var_4d11ee561215b1d5 = 6.65;
        var_c858f63dfe947195 = 1.5;
    }
    
    for ( i = 0; i < tracearray.size - 1 ; i++ )
    {
        tracepoints = tracearray[ i ];
        
        foreach ( trace in tracepoints )
        {
            if ( !isdefined( trace[ "position" ] ) )
            {
                continue;
            }
            
            if ( !isdefined( trace[ "normal" ] ) )
            {
                continue;
            }
            
            if ( trace[ "hittype" ] == "hittype_none" )
            {
                continue;
            }
            
            btwn = tracestart - trace[ "position" ];
            dot = vectordot( anglestoforward( referenceloc.angles ), btwn );
            
            if ( dot > var_c858f63dfe947195 || dot < var_4d11ee561215b1d5 * -1 )
            {
                dot = vectordot( anglestoright( referenceloc.angles ), btwn );
                
                if ( dot < 0 )
                {
                    var_611fab15dfae2ce7[ 1 ] = min( var_611fab15dfae2ce7[ 1 ], 110 );
                }
                else if ( dot > 0 )
                {
                    var_611fab15dfae2ce7[ 0 ] = min( var_611fab15dfae2ce7[ 0 ], 110 );
                }
                
                /#
                    if ( var_bc8dd5ae9fe21cb9 )
                    {
                        level thread debug::drawsphere( trace[ "<dev string:x1b6>" ], 0.5, 100, ( 1, 0, 0 ) );
                    }
                #/
                
                continue;
            }
            
            var_2e7057e23e7e2aff = vectordot( anglestoright( referenceloc.angles ), btwn );
            vertdot = vectordot( anglestoup( referenceloc.angles ), btwn );
            
            if ( var_2e7057e23e7e2aff <= 1.6 && var_2e7057e23e7e2aff >= -1.6 )
            {
                bounds = 2.25;
                
                if ( vertdot <= bounds && vertdot >= bounds * -1 )
                {
                    /#
                        if ( var_bc8dd5ae9fe21cb9 )
                        {
                            level thread debug::drawsphere( trace[ "<dev string:x1b6>" ], 0.5, 100, ( 1, 1, 0 ) );
                        }
                    #/
                    
                    continue;
                }
                
                if ( camera.mode != "wall" )
                {
                    if ( vertdot < 0 )
                    {
                        /#
                            if ( var_bc8dd5ae9fe21cb9 )
                            {
                                level thread debug::drawsphere( trace[ "<dev string:x1b6>" ], 0.5, 100, ( 1, 0, 1 ) );
                            }
                        #/
                    }
                }
            }
            
            if ( var_2e7057e23e7e2aff >= 6 || var_2e7057e23e7e2aff <= -6 )
            {
                /#
                    if ( var_bc8dd5ae9fe21cb9 )
                    {
                        level thread debug::drawsphere( trace[ "<dev string:x1b6>" ], 0.5, 100, ( 0, 1, 1 ) );
                    }
                #/
                
                continue;
            }
            
            if ( vertdot >= 6 || vertdot < -6 )
            {
                /#
                    if ( var_bc8dd5ae9fe21cb9 )
                    {
                        level thread debug::drawsphere( trace[ "<dev string:x1b6>" ], 0.5, 100, ( 0, 1, 1 ) );
                    }
                #/
                
                continue;
            }
            
            dot = vectordot( anglestoup( referenceloc.angles ), btwn );
            
            if ( dot > 2.25 || dot < -2.25 )
            {
                /#
                    if ( var_bc8dd5ae9fe21cb9 )
                    {
                        level thread debug::drawsphere( trace[ "<dev string:x1b6>" ], 0.5, 100, ( 0, 0, 1 ) );
                    }
                #/
                
                var_aeb10889d7580ed6 = dot > 0 ? 1 : 0;
                var_1f40bce379c62972[ var_aeb10889d7580ed6 ] = 1;
                continue;
            }
            
            camerafwd = anglestoforward( referenceloc.angles );
            var_b061bfc5f43fe18b = trace[ "position" ] - tracestart;
            lefthit = 0;
            dotangle = math::anglebetweenvectorssigned( camerafwd, var_b061bfc5f43fe18b, ( 0, 0, 1 ) );
            
            if ( dotangle > 0 )
            {
                lefthit = 1;
            }
            
            dotangle = abs( dotangle );
            var_8f9c5185f8a9c044 = lefthit ? 0 : 1;
            var_611fab15dfae2ce7[ var_8f9c5185f8a9c044 ] = 1;
            
            /#
                if ( var_bc8dd5ae9fe21cb9 )
                {
                    level thread debug::drawsphere( trace[ "<dev string:x1b6>" ], 0.5, 100, ( 0, 1, 0 ) );
                }
            #/
        }
    }
    
    if ( oninit )
    {
        watcher_tag = spawn( "script_model", camera.origin );
        watcher_tag setmodel( "tag_origin" );
        watcher_tag.origin = camera gettagorigin( "tag_player" );
        watcher_tag.angles = camera gettagangles( "tag_player" );
        camera.watcher_tag = watcher_tag;
    }
    
    camera.var_421f9e21fee55e8 = var_611fab15dfae2ce7;
    camera.vertarc = var_1f40bce379c62972;
    return true;
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x6717a665, Offset: 0x7a76
// Size: 0x126
function private function_3b21828a228e05c3( currentcamera, reversesearch )
{
    if ( !isdefined( currentcamera ) )
    {
        return;
    }
    
    cameracluster = self [[ function_ddb6749d6d40be33( currentcamera.cameratype ).var_2f24daeab8deae63 ]]();
    assert( isdefined( cameracluster ), "<dev string:x1bf>" );
    
    if ( cameracluster.size == 0 )
    {
        return currentcamera;
    }
    
    teamref = currentcamera.owner.team;
    curidx = function_f02c63b99c9614c9( cameracluster, currentcamera );
    
    if ( !isdefined( curidx ) )
    {
        curidx = 0;
    }
    
    parsedirection = 1;
    
    if ( reversesearch )
    {
        parsedirection = -1;
    }
    
    newidx = curidx + parsedirection;
    
    if ( newidx < 0 )
    {
        newidx = cameracluster.size - 1;
    }
    
    newidx %= cameracluster.size;
    newcam = cameracluster[ newidx ];
    
    while ( newidx != curidx )
    {
        if ( isdefined( newcam ) && !function_15ee4c2022ab516b( newcam ) )
        {
            break;
        }
        
        newidx = curidx + parsedirection;
        
        if ( newidx < 0 )
        {
            newidx = cameracluster.size - 1;
        }
        
        newidx %= cameracluster.size;
        newcam = cameracluster[ newidx ];
        waitframe();
    }
    
    return newcam;
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0xcac1f5fb, Offset: 0x7ba5
// Size: 0x119
function private function_c8495349eab791d7( currentcamera, newcamera )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_6756a2edd554e05e = 1;
    exitfunc = function_ddb6749d6d40be33( currentcamera.cameratype ).exitfunc;
    game_utility::fadetoblackforplayer( self, 1, 0.25 );
    canswitch = 1;
    
    if ( !isdefined( newcamera ) || newcamera.isdestroyed || !isalive( self ) )
    {
        canswitch = 0;
    }
    
    player::_freezelookcontrols( 0 );
    
    if ( !canswitch )
    {
        thread game_utility::fadetoblackforplayer( self, 0, 0.25 );
        self thread [[ exitfunc ]]( currentcamera, canswitch );
    }
    else
    {
        self [[ exitfunc ]]( currentcamera, canswitch );
        thread game_utility::fadetoblackforplayer( self, 0, 0.25 );
        
        if ( isdefined( newcamera ) )
        {
            self [[ function_ddb6749d6d40be33( newcamera.cameratype ).startfunc ]]( newcamera );
        }
    }
    
    self.var_6756a2edd554e05e = undefined;
    self notify( #"hash_ca69f669febfd7e1" );
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0xc12bd80f, Offset: 0x7cc6
// Size: 0x9f
function function_8591223b9107cc48( var_ba6fdd0c1130d4f9, camera )
{
    self endon( #"disconnect" );
    self notify( #"hash_7c9e506198bc4839" );
    self endon( #"hash_7c9e506198bc4839" );
    self endon( #"playerExitingCameraMode" );
    self endon( var_ba6fdd0c1130d4f9 );
    self endon( #"death" );
    
    while ( true )
    {
        msg = function_ee670fe30483894();
        
        if ( !isdefined( msg ) )
        {
            continue;
        }
        
        reverseparse = 0;
        
        if ( msg == "cameraSwitchLeft" )
        {
            reverseparse = 1;
        }
        
        function_faf04f5687549ef2( camera, reverseparse, var_ba6fdd0c1130d4f9 );
    }
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0x4459d907, Offset: 0x7d6d
// Size: 0x99
function function_faf04f5687549ef2( camera, reverseparse, var_ba6fdd0c1130d4f9 )
{
    self endon( #"playerExitingCameraMode" );
    self endon( #"death" );
    
    if ( !isdefined( var_ba6fdd0c1130d4f9 ) )
    {
        var_ba6fdd0c1130d4f9 = "tacticalCamera_allCamerasRemoved";
    }
    
    self endon( var_ba6fdd0c1130d4f9 );
    
    if ( self.var_6756a2edd554e05e )
    {
        return 0;
    }
    
    newcam = function_3b21828a228e05c3( camera, reverseparse );
    
    if ( !isdefined( newcam ) )
    {
        return 0;
    }
    
    if ( newcam == camera )
    {
        return 0;
    }
    
    thread function_c8495349eab791d7( camera, newcam );
    self waittill( #"hash_ca69f669febfd7e1" );
    return 1;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x6a7d2214, Offset: 0x7e0e
// Size: 0x25f
function function_eadccb0164cccc9d( camera )
{
    level endon( #"game_ended" );
    camera endon( #"death" );
    camera endon( #"explode" );
    self endon( #"disconnect" );
    
    if ( !isdefined( camera ) || camera.hasexploded == 1 )
    {
        return;
    }
    
    currentorientation = camera gettagangles( "tag_player" );
    var_84e77badba6867b = anglestoforward( currentorientation );
    var_1c74d1ee99889bc3 = anglestoup( currentorientation );
    var_100f3a41e303bfdd = utility::flatten_vector( var_84e77badba6867b, ( 0, 0, 1 ) );
    initialorientation = camera.var_bad4d3368eda8ca9;
    var_24b0f1f5437574a = utility::flatten_vector( anglestoforward( initialorientation ), ( 0, 0, 1 ) );
    var_6e2309837786ae40 = anglestoup( initialorientation );
    camera.var_a5ceb39bda361e2b = [];
    camera.var_755cc8edd0450de0 = [];
    rightadjustment = 0;
    var_4a065f32dd196806 = 0;
    
    if ( camera.var_421f9e21fee55e8[ 0 ] != 180 || camera.var_421f9e21fee55e8[ 1 ] != 180 )
    {
        var_4a065f32dd196806 = math::anglebetweenvectorssigned( var_24b0f1f5437574a, var_100f3a41e303bfdd, ( 0, 0, 1 ) );
        
        if ( var_4a065f32dd196806 <= 0 )
        {
            rightadjustment = 1;
        }
        
        anglediff = abs( var_4a065f32dd196806 );
        
        if ( rightadjustment )
        {
            camera.var_a5ceb39bda361e2b[ 1 ] = anglediff * -1;
            camera.var_a5ceb39bda361e2b[ 0 ] = anglediff;
        }
        else
        {
            camera.var_a5ceb39bda361e2b[ 1 ] = anglediff;
            camera.var_a5ceb39bda361e2b[ 0 ] = anglediff * -1;
        }
    }
    
    bottomadjustment = 0;
    var_6cceba5e482d2c7b = math::anglebetweenvectorssigned( var_6e2309837786ae40, var_1c74d1ee99889bc3, ( 0, 1, 0 ) );
    
    if ( var_6cceba5e482d2c7b <= 0 )
    {
        bottomadjustment = 1;
    }
    
    anglediff = abs( var_6cceba5e482d2c7b );
    
    if ( bottomadjustment )
    {
        camera.var_755cc8edd0450de0[ 0 ] = anglediff;
        camera.var_755cc8edd0450de0[ 1 ] = anglediff * -1;
        return;
    }
    
    camera.var_755cc8edd0450de0[ 0 ] = anglediff * -1;
    camera.var_755cc8edd0450de0[ 1 ] = anglediff;
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0xc9dc4d06, Offset: 0x8075
// Size: 0x116
function deployablecamera_empstarted( data, var_9ce10f3a1575f377 )
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    self setscriptablepartstate( "ddos", "disabled", 0 );
    self.owner thread function_4e2173f801c91b9( self, self.ownerindex, 4, undefined, 6 );
    
    if ( isdefined( self.pilot ) )
    {
        var_fca0c350596528db = [ self.pilot ];
        
        if ( self.watchers.size > 0 )
        {
            var_fca0c350596528db = arraycombine( var_fca0c350596528db, self.watchers );
        }
        
        foreach ( user in var_fca0c350596528db )
        {
            user thread function_e8f3bce04b4ab184( self, var_9ce10f3a1575f377 );
        }
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x8c4c304, Offset: 0x8193
// Size: 0x116
function function_25b4959d3a4136a7( data )
{
    self endon( #"death" );
    
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    self setscriptablepartstate( "ddos", "disabled", 0 );
    self.owner thread function_4e2173f801c91b9( self, self.ownerindex, 0, undefined, 6 );
    
    if ( isdefined( self.pilot ) )
    {
        var_fca0c350596528db = [ self.pilot ];
        
        if ( self.watchers.size > 0 )
        {
            var_fca0c350596528db = arraycombine( var_fca0c350596528db, self.watchers );
        }
        
        foreach ( user in var_fca0c350596528db )
        {
            user thread function_393dc5be02df8026( self );
        }
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x8a22bb4f, Offset: 0x82b1
// Size: 0x1d
function function_8cb54d9cde7d4776( data )
{
    self setscriptablepartstate( "ddos", "neutral", 0 );
}

// Namespace deployable_camera_common
// Params 5
// Checksum 0xe0635453, Offset: 0x82d6
// Size: 0xca
function function_4e2173f801c91b9( camera, index, status, forcestate, var_55af9cc21f79ac7 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_ad364671edbcc0ee ) )
    {
        self.var_ad364671edbcc0ee = [];
    }
    
    struct = spawnstruct();
    struct.camera = camera;
    struct.index = index;
    struct.status = status;
    struct.forcestate = istrue( forcestate );
    struct.var_55af9cc21f79ac7 = var_55af9cc21f79ac7 ?? 0;
    self.var_ad364671edbcc0ee[ self.var_ad364671edbcc0ee.size ] = struct;
    thread function_d4b22ab8b23b850e();
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xcfd44dbf, Offset: 0x83a8
// Size: 0xdb
function function_d4b22ab8b23b850e()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"tacticalCamera_allCamerasRemoved" );
    self notify( #"hash_5d92dc22ba2bdcdb" );
    self endon( #"hash_5d92dc22ba2bdcdb" );
    
    if ( level.gameended || !isdefined( self ) )
    {
        return;
    }
    
    while ( self.var_ad364671edbcc0ee.size > 0 )
    {
        waitframe();
        struct = utility::array_get_first_item( self.var_ad364671edbcc0ee );
        self notify( #"personal_camera_status_updated", struct.camera, struct.index, struct.status, struct.forcestate, struct.var_55af9cc21f79ac7 );
        self.var_ad364671edbcc0ee = arrayremove( self.var_ad364671edbcc0ee, struct );
    }
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x544e527, Offset: 0x848b
// Size: 0x65
function private function_b98f7b4fe2f6f04e( camera, transitiontime )
{
    camera endon( #"emp_cleared" );
    self endon( #"playerLeavingCurrentCamera" );
    halftime = transitiontime / 2;
    function_ad800a2d26bfbbd6( camera, "taccam_static_start", halftime );
    wait halftime;
    function_ad800a2d26bfbbd6( camera, "taccam_static_mid", halftime );
    wait halftime;
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0x9f3f7b1b, Offset: 0x84f8
// Size: 0x72
function private function_e8f3bce04b4ab184( camera, var_9ce10f3a1575f377 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    emp_debuff::play_emp_scramble( 1 );
    returnmsg = function_af82d8ab07ed028a( camera, var_9ce10f3a1575f377 );
    
    if ( returnmsg != "timeout" )
    {
        emp_debuff::clear_emp_scramble();
        function_ca8402beb6dcf8cc( camera );
        return;
    }
    
    thread function_63ebd594ea24d2f( camera );
}

// Namespace deployable_camera_common
// Params 2, eflags: 0x4
// Checksum 0xeded9bb5, Offset: 0x8572
// Size: 0x48
function private function_af82d8ab07ed028a( camera, var_445706f5c966d889 )
{
    childthread function_b98f7b4fe2f6f04e( camera, var_445706f5c966d889 );
    msg = utility::waittill_any_ents_or_timeout_return( var_445706f5c966d889, camera, "emp_cleared", camera, "chaff_cleared", self, "playerExitingCameraMode" );
    return msg;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x9d4eedfd, Offset: 0x85c3
// Size: 0xcf
function function_393dc5be02df8026( camera )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    camera endon( #"death" );
    self notify( #"hash_492371457f1ba377" );
    self endon( #"hash_492371457f1ba377" );
    self.targetsinouterradius = [];
    function_1ba5618c12749387();
    function_ad800a2d26bfbbd6( camera, "taccam_static_full" );
    msg = camera utility::waittill_any_ents_return( camera, "haywire_cleared", self, "playerLeavingCurrentCamera", self, "death", self, "playerExitingCameraMode" );
    
    if ( !isdefined( msg ) || msg == "playerLeavingCurrentCamera" || msg == "death" )
    {
        function_ca8402beb6dcf8cc( camera );
        return;
    }
    
    function_beefde1d1ac68ff8( camera );
    function_5d9b2813d1d3da15();
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x99896417, Offset: 0x869a
// Size: 0x148
function function_63ebd594ea24d2f( camera )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_3a32e2fef6aa7ae6" );
    self endon( #"hash_3a32e2fef6aa7ae6" );
    thread function_a33e3f0c3852c197( camera );
    self.targetsinouterradius = [];
    function_1ba5618c12749387();
    function_ad800a2d26bfbbd6( camera, "taccam_static_full" );
    self setclientomnvar( "ui_tactical_camera_ddos_on", 1 );
    
    if ( !isdefined( self.empscramblelevels ) || self.empscramblelevels.size == 0 )
    {
        emp_debuff::play_emp_scramble( 3 );
    }
    
    msg = camera utility::waittill_any_ents_return( camera, "emp_cleared", camera, "chaff_cleared", self, "playerLeavingCurrentCamera", self, "death", self, "playerExitingCameraMode" );
    
    if ( !isdefined( msg ) || msg == "playerLeavingCurrentCamera" || msg == "death" )
    {
        function_ca8402beb6dcf8cc( camera );
    }
    else
    {
        function_beefde1d1ac68ff8( camera );
        function_5d9b2813d1d3da15();
    }
    
    if ( msg == "death" || msg == "playerExitingCameraMode" || msg == "emp_cleared" || msg == "chaff_cleared" || msg == "playerLeavingCurrentCamera" )
    {
        emp_debuff::clear_emp_scramble();
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x650243d6, Offset: 0x87ea
// Size: 0x74
function function_a33e3f0c3852c197( camera )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    camera notify( #"hash_7f9662cac1d8d56e" );
    camera endon( #"hash_7f9662cac1d8d56e" );
    camera utility::waittill_any( "death", "emp_cleared", "chaff_cleared" );
    camera setscriptablepartstate( "ddos", "neutral", 0 );
    self setclientomnvar( "ui_tactical_camera_ddos_on", 0 );
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x56eca22c, Offset: 0x8866
// Size: 0x8f
function function_dcfaf08239bc672f( data )
{
    attacker = data.attacker;
    self dodamage( self.maxhealth / 10, self.origin, attacker, data.inflictor );
    
    if ( self.damagetaken >= 100 )
    {
        if ( !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, attacker ) )
        {
            attacker thread points::doscoreevent( #"destroyed_equipment" );
        }
    }
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0x95bba996, Offset: 0x88fd
// Size: 0x60
function function_2fd8782ec11cfc2d( camera, cameratype )
{
    var_4e609d3aa99e260f = function_ddb6749d6d40be33( cameratype ).exitfunc;
    self endon( #"death" );
    camera endon( #"entering" );
    level waittill( #"game_ended" );
    [[ var_4e609d3aa99e260f ]]( camera, 0 );
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x86e37617, Offset: 0x8965
// Size: 0x88, Type: bool
function function_916284ca01bf7992()
{
    childthread function_e1d42f95b2940402();
    childthread function_14fc111da92d7fca();
    childthread function_5d7a79df12ecf531();
    self waittill( #"activateCamera", msg );
    self notifyonplayercommandremove( "tacButtonPress", "+smoke" );
    self notifyonplayercommandremove( "tacButtonPress", "+actionslot 1" );
    self notifyonplayercommandremove( "fragButtonPress", "+frag" );
    self notifyonplayercommandremove( "fragButtonPress", "+equip_toggle_throw" );
    self notifyonplayercommandremove( "cameraActive", "+special" );
    return msg == "success";
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0xc09ec9a2, Offset: 0x89f6
// Size: 0x32
function private function_ee670fe30483894()
{
    childthread function_7d1093cf0f7e8fea();
    childthread function_2b02ad82605857f2();
    self waittill( #"switchcamera", msg );
    function_a0caf4e9aeb4ac89();
    return msg;
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xce60fb7a, Offset: 0x8a31
// Size: 0x32
function function_a0caf4e9aeb4ac89()
{
    self notifyonplayercommandremove( "camSwitchKBM", "+special" );
    self notifyonplayercommandremove( "cameraSwitchLeft", "+smoke" );
    self notifyonplayercommandremove( "cameraSwitchRight", "+frag" );
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0x3e9b3dff, Offset: 0x8a6b
// Size: 0x6e
function private function_2b02ad82605857f2()
{
    self endon( #"switchcamera" );
    self notifyonplayercommand( "cameraSwitchLeftController", "+smoke" );
    self notifyonplayercommand( "cameraSwitchRightController", "+frag" );
    msg = utility::waittill_any_return( "cameraSwitchLeftController", "cameraSwitchRightController" );
    
    if ( utility::is_player_gamepad_enabled() )
    {
        msg = function_1b44a8bef83e8e02( msg, "Controller" );
        self notify( #"switchcamera", msg );
    }
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0x5818571c, Offset: 0x8ae1
// Size: 0x6f
function private function_7d1093cf0f7e8fea()
{
    self endon( #"switchcamera" );
    self notifyonplayercommand( "cameraSwitchLeftKBM", "+moveleft" );
    self notifyonplayercommand( "cameraSwitchRightKBM", "+moveright" );
    msg = utility::waittill_any_return( "cameraSwitchLeftKBM", "cameraSwitchRightKBM" );
    
    if ( !utility::is_player_gamepad_enabled() )
    {
        msg = function_1b44a8bef83e8e02( msg, "KBM" );
        self notify( #"switchcamera", msg );
    }
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0x57348e90, Offset: 0x8b58
// Size: 0x109, Type: bool
function function_3b986a3ad8439874( var_7634e6877c7e7f5f, var_2febbfb0784aadc5, cameraweaponname )
{
    cameracluster = self [[ var_2febbfb0784aadc5 ]]();
    
    if ( !isdefined( cameracluster ) || cameracluster.size == 0 )
    {
        return false;
    }
    
    if ( !function_30d523bacbe035c8( cameraweaponname ) )
    {
        return false;
    }
    
    currentweapon = self.currentweapon;
    
    if ( currentweapon.basename == "iw9_me_riotshield_mp" )
    {
        self.var_b590d8a08fa6c901 = 1;
        self notify( #"activateCamera", "success" );
        return true;
    }
    
    ammoclip = self getweaponammoclip( currentweapon );
    ammostock = self getweaponammostock( currentweapon );
    inventory_utility::_takeweapon( currentweapon );
    inventory_utility::_takeweapon( var_7634e6877c7e7f5f );
    self clearoffhandspecial();
    self.var_b590d8a08fa6c901 = 1;
    self notify( #"activateCamera", "success" );
    inventory_utility::_giveweapon( var_7634e6877c7e7f5f );
    self assignweaponoffhandspecial( var_7634e6877c7e7f5f );
    thread function_d6c9024d669c1ca8( currentweapon, ammoclip, ammostock );
    return true;
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0x6066de14, Offset: 0x8c6a
// Size: 0x7c
function function_d6c9024d669c1ca8( previousweapon, ammoclip, ammostock )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    waittime = getdvarfloat( @"hash_83f60684c63746be", 0 );
    wait waittime + 0.05;
    inventory_utility::_giveweapon( previousweapon, undefined, undefined, 1 );
    self setweaponammoclip( previousweapon, ammoclip );
    self setweaponammostock( previousweapon, ammostock );
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0x8917efc1, Offset: 0x8cee
// Size: 0x3c
function private function_e1d42f95b2940402()
{
    self endon( #"activateCamera" );
    self notifyonplayercommand( "cameraActive", "+special" );
    self waittill( #"cameraActive" );
    self notify( #"activateCamera", "success" );
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0xa849fb15, Offset: 0x8d32
// Size: 0x8a
function private function_14fc111da92d7fca()
{
    self endon( #"activateCamera" );
    self notifyonplayercommand( "tacButtonPress", "+smoke" );
    self notifyonplayercommand( "fragButtonPress", "+frag" );
    var_ae907018b4147d20 = [ "tacButtonPress", "fragButtonPress" ];
    thread supers_mp::function_59e580eaf8854be2( var_ae907018b4147d20, [ "activateCamera" ], 0.75 );
    self waittill( #"hash_c3884f38d7f57aaf", msg );
    self notify( #"activateCamera", msg );
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0x5d3bc4b5, Offset: 0x8dc4
// Size: 0x8a
function private function_5d7a79df12ecf531()
{
    self endon( #"activateCamera" );
    self notifyonplayercommand( "tacButtonPress", "+actionslot 1" );
    self notifyonplayercommand( "fragButtonPress", "+equip_toggle_throw" );
    var_ae907018b4147d20 = [ "tacButtonPress", "fragButtonPress" ];
    thread supers_mp::function_59e580eaf8854be2( var_ae907018b4147d20, [ "activateCamera" ], 0.75 );
    self waittill( #"hash_c3884f38d7f57aaf", msg );
    self notify( #"activateCamera", msg );
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xde94630b, Offset: 0x8e56
// Size: 0x2b
function function_a03c349df30c428()
{
    if ( isdefined( level.characterpartition ) )
    {
        return;
    }
    
    level.characterpartition = utility::create_partition( level.characters, 1575 );
}

// Namespace deployable_camera_common
// Params 0, eflags: 0x4
// Checksum 0xeb59d0c9, Offset: 0x8e89
// Size: 0x1a
function private function_5591be326812978e()
{
    while ( true )
    {
        wait 0.25;
        level.characterpartition = undefined;
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x4c0bf2af, Offset: 0x8eab
// Size: 0x112, Type: bool
function function_30d523bacbe035c8( cameraweaponname )
{
    if ( self isswimunderwater() )
    {
        return false;
    }
    
    if ( self.isjuggernaut )
    {
        return false;
    }
    
    if ( self isinfreefall() )
    {
        return false;
    }
    
    if ( self isjumping() )
    {
        return false;
    }
    
    if ( self ishanging() )
    {
        return false;
    }
    
    if ( self isdiving() )
    {
        return false;
    }
    
    if ( self isthrowinggrenade() )
    {
        offhandweapon = self getheldoffhand();
        
        if ( offhandweapon.basename != cameraweaponname )
        {
            return false;
        }
    }
    
    if ( self.deployingcamera )
    {
        return false;
    }
    
    if ( self.isusingcamera )
    {
        return false;
    }
    
    if ( isdefined( self.vehicle ) )
    {
        return false;
    }
    
    if ( !val::get( "supers" ) )
    {
        return false;
    }
    
    if ( self.super.isdeploying )
    {
        return false;
    }
    
    if ( self.var_df24ac934fd98227 )
    {
        return false;
    }
    
    if ( self.carryinghostage )
    {
        return false;
    }
    
    if ( self isswitchingweapon() && !self.var_b590d8a08fa6c901 )
    {
        return false;
    }
    
    if ( self.chaffcount > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xd41cdcee, Offset: 0x8fc6
// Size: 0xa5
function function_3ac8c3a713620589( camera )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"playerLeavingCurrentCamera" );
    
    if ( !isdefined( self.c4s ) || self.c4s.size == 0 )
    {
        return 0;
    }
    
    self notifyonplayercommand( "c4_detonated", "+detonate" );
    self notifyonplayercommand( "c4_detonated", "+attack" );
    self setclientomnvar( "ui_tactical_camera_can_detonate_c4", 1 );
    self waittill( #"c4_detonated" );
    self notify( #"detonate" );
    self setclientomnvar( "ui_tactical_camera_can_detonate_c4", 0 );
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0x58c30e11, Offset: 0x9073
// Size: 0x22
function function_1891792c3fc572f5()
{
    self notifyonplayercommandremove( "c4_detonated", "+detonate" );
    self notifyonplayercommandremove( "c4_detonated", "+attack" );
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0x1badf360, Offset: 0x909d
// Size: 0x81
function function_b080eefed2eddd5b( camera, cameratype )
{
    var_4e609d3aa99e260f = function_ddb6749d6d40be33( cameratype ).exitfunc;
    self endon( #"death_or_disconnect" );
    camera endon( #"death" );
    self endon( #"playerLeavingCurrentCamera" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self isinexecutionvictim() )
        {
            break;
        }
        
        waitframe();
    }
    
    self thread [[ var_4e609d3aa99e260f ]]( camera, 0 );
}

// Namespace deployable_camera_common
// Params 1, eflags: 0x4
// Checksum 0xbac0c0db, Offset: 0x9126
// Size: 0x22
function private function_dfb6188b2f6f3ee6( cam )
{
    cam setentityhudoutlinedata( 3, cam.ownerteam );
    return cam;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0xe6814140, Offset: 0x9151
// Size: 0x8d
function function_516c77a8a599af88( target )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    params = function_ddb6749d6d40be33( self.cameratype );
    var_6728b9f80399d36e = params.var_5cc58c3b33ca5e7d;
    
    if ( self.isunderwater || target player_utility::isswimmingunderwater() )
    {
        var_6728b9f80399d36e = params.var_40d0fc5983ba5d1c;
    }
    
    if ( !isdefined( var_6728b9f80399d36e ) )
    {
        return;
    }
    
    return distancesquared( self.origin, target.origin ) < var_6728b9f80399d36e;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x293fbf99, Offset: 0x91e7
// Size: 0x85, Type: bool
function deployablecamera_isindetectrange( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    params = function_ddb6749d6d40be33( self.cameratype );
    var_248844f06fc1d1ea = params.var_26875662281a0bd1;
    
    if ( self.isunderwater || target player_utility::isswimmingunderwater() )
    {
        var_248844f06fc1d1ea = params.var_9b15b961a6e22c68;
    }
    
    return distancesquared( self.origin, target.origin ) < var_248844f06fc1d1ea;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x18429df6, Offset: 0x9275
// Size: 0x9c
function function_ee93ef87c2144487( target )
{
    info = spawnstruct();
    info.isvisible = function_fc36c51eb333434b( target );
    info.var_f32175be69573064 = function_9f0d007536d7a818( target );
    info.isinrange = function_516c77a8a599af88( target );
    info.isindetectrange = deployablecamera_isindetectrange( target );
    
    if ( isdefined( self.pilot ) )
    {
        info.isinreticle = self.pilot function_3f48718bebe00fff( target, 80, 40 );
    }
    
    return info;
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x48a7406b, Offset: 0x931a
// Size: 0x347
function function_93eaead9553740e8( camera )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    camera endon( #"death" );
    destroyfunc = function_ddb6749d6d40be33( camera.cameratype ).destroyfunc;
    radius = getdvarfloat( @"hash_b076f58c9b234db3", 140 );
    doors = scriptable_door_utility::scriptable_door_get_in_radius( camera.origin, radius, 20 );
    camera.monitoreddoors = [];
    
    foreach ( door in doors )
    {
        var_1472fd510523a884 = spawnstruct();
        var_1472fd510523a884.door = door;
        var_1472fd510523a884.vectorbetween = camera.origin - door.origin;
        var_1472fd510523a884.lastangles = door.angles;
        var_1472fd510523a884.doorwidth = 56;
        var_1472fd510523a884.doorheight = 96;
        camera.monitoreddoors[ camera.monitoreddoors.size ] = var_1472fd510523a884;
    }
    
    if ( camera.monitoreddoors.size == 0 )
    {
        return;
    }
    
    while ( isdefined( camera ) && !camera.isdestroyed )
    {
        foreach ( doorstruct in camera.monitoreddoors )
        {
            if ( doorstruct.door.angles != doorstruct.lastangles )
            {
                doorstruct.lastangles = doorstruct.door.angles;
                anglebetween = math::anglebetweenvectors( utility::flatten_vector( doorstruct.vectorbetween ), anglestoforward( doorstruct.door.angles ) );
                
                if ( anglebetween < 5 )
                {
                    distancewidth = vectordot( anglestoforward( doorstruct.door.angles ), doorstruct.vectorbetween );
                    distanceheight = vectordot( anglestoup( doorstruct.door.angles ), doorstruct.vectorbetween );
                    
                    if ( distancewidth < doorstruct.doorwidth && distanceheight < doorstruct.doorheight )
                    {
                        camera thread [[ destroyfunc ]]();
                        break;
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x251dc5b, Offset: 0x9669
// Size: 0x92
function function_b5349d5f73682aa1( camera )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c22f384ac118b628" );
    
    while ( true )
    {
        self waittill( #"switch_thermal_mode" );
        
        if ( camera emp_debuff::is_empd() )
        {
            continue;
        }
        
        visionset = function_7c481bfcad82f606( camera );
        camera function_b7b6bd076e8e50c1( camera, visionset == "tacCam" ? "killstreak_thermal" : "tacCam" );
        function_beefde1d1ac68ff8( camera );
    }
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0x449dc7ba, Offset: 0x9703
// Size: 0x23
function function_b7b6bd076e8e50c1( camera, visionsetname )
{
    camera.currentvisionset = visionsetname;
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0xd41075c5, Offset: 0x972e
// Size: 0x138
function function_beefde1d1ac68ff8( camera, var_1a7ccd85ca17bc86 )
{
    visionset = function_7c481bfcad82f606( camera );
    players = [ self ];
    
    if ( !var_1a7ccd85ca17bc86 )
    {
        if ( isdefined( camera.watchers ) )
        {
            foreach ( player in camera.watchers )
            {
                if ( isalive( player ) )
                {
                    players[ players.size ] = player;
                }
            }
        }
    }
    
    foreach ( player in players )
    {
        player function_ad800a2d26bfbbd6( camera, visionset );
    }
}

// Namespace deployable_camera_common
// Params 3
// Checksum 0x7809ad41, Offset: 0x986e
// Size: 0x73
function function_ad800a2d26bfbbd6( camera, visionsetname, transitiontime = 0 )
{
    if ( camera.currentvisionset == "killstreak_thermal" )
    {
        self visionsetkillstreakforplayer( "" );
        self visionsetthermalforplayer( visionsetname );
        self thermalvisionon();
        return;
    }
    
    self visionsetthermalforplayer( "" );
    self visionsetkillstreakforplayer( visionsetname );
    self thermalvisionoff();
}

// Namespace deployable_camera_common
// Params 2
// Checksum 0x88364c4f, Offset: 0x98e9
// Size: 0x71
function function_ca8402beb6dcf8cc( camera, var_be665da960db068f )
{
    assert( isdefined( camera.currentvisionset ), "<dev string:x233>" );
    
    if ( camera.currentvisionset == "killstreak_thermal" )
    {
        self visionsetthermalforplayer( "" );
    }
    else
    {
        self visionsetkillstreakforplayer( "" );
    }
    
    self thermalvisionoff();
    
    if ( var_be665da960db068f )
    {
        camera.currentvisionset = undefined;
    }
}

// Namespace deployable_camera_common
// Params 1
// Checksum 0x4a3869bf, Offset: 0x9962
// Size: 0x64
function function_7c481bfcad82f606( camera )
{
    if ( isdefined( camera.currentvisionset ) )
    {
        return camera.currentvisionset;
    }
    
    if ( utility::isnightmap() )
    {
        camera.currentvisionset = "killstreak_thermal";
    }
    else
    {
        camera.currentvisionset = "tacCam";
    }
    
    return camera.currentvisionset;
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xe377ee4d, Offset: 0x99ce
// Size: 0x8a
function function_d7fe0cec25430cf()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c22f384ac118b628" );
    
    while ( true )
    {
        var_57d1116398f2b84e = player_utility::getthermalswitchplayercommand();
        self notifyonplayercommand( "switch_thermal_mode", var_57d1116398f2b84e );
        returnednotif = utility::waittill_any_return_no_endon_death( "input_type_changed", "thermal_handling_ended" );
        self notifyonplayercommandremove( "switch_thermal_mode", var_57d1116398f2b84e );
        
        if ( !isdefined( returnednotif ) || returnednotif == "thermal_handling_ended" )
        {
            break;
        }
    }
}

// Namespace deployable_camera_common
// Params 0
// Checksum 0xb3ceba2, Offset: 0x9a60
// Size: 0x53
function function_1e2276123cdaad0f()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_5bc8a48a76bae328" );
    starttime = gettime();
    
    while ( gettime() < starttime + 1000 )
    {
        self disablephysicaldepthoffieldscripting();
        wait 0.1;
    }
}

