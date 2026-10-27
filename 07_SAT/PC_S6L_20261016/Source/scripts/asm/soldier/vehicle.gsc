// scripts\asm\soldier\vehicle.gsc  (hash_41ad1f1424dd3cc9.gscc) (size: 37392 Bytes / 0x9210 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcced2b40 (3438095168)
// size ...... 37392 (0x9210)
// includes .. 14  (offset: 0x898c)
// strings ... 71  (offset: 0x89fc)
// dev strs .. 71  (offset: 0x8e88)
// exports ... 81  (offset: 0x60a4)
// cseg ...... 0x3ea + 0x5cba (0x60a4)
// imports ... 213 (offset: 0x6d4c)
// animtree1 . 0   (offset: 0x9210)
// animtree2 . 0   (offset: 0x9210)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\death;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\melee;
#using scripts\asm\soldier\pain;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\trace;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\vehicle\vehicle_common;

#namespace vehicle;

// Namespace vehicle
// Params 3
// Checksum 0xf5876a03, Offset: 0x408
// Size: 0x3e
function setvehiclearchetype( asmname, statename, params )
{
    self setoverridearchetype( "vehicle", self._blackboard.currentvehicleanimalias, 1 );
}

// Namespace vehicle
// Params 3
// Checksum 0x8b15b0fe, Offset: 0x44e
// Size: 0x2c
function clearvehiclearchetype( asmname, statename, params )
{
    self clearoverridearchetype( "vehicle", 0, 1 );
}

// Namespace vehicle
// Params 4
// Checksum 0xf9efd756, Offset: 0x482
// Size: 0x85, Type: bool
function function_54540d915febbad9( asmname, statename, tostatename, params )
{
    if ( !isdefined( self._blackboard.currentvehicle ) )
    {
        return true;
    }
    
    var_4b65c9e6ffc72762 = distancesquared( self.origin, self._blackboard.currentvehicle.origin );
    
    if ( var_4b65c9e6ffc72762 > 50000 )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle
// Params 0
// Checksum 0x70faa116, Offset: 0x510
// Size: 0xd1
function function_956dd9c876d9184a()
{
    alias = "";
    
    if ( self.vehicleseatonleft )
    {
        alias += "_4";
    }
    else
    {
        alias += "_6";
    }
    
    if ( isdefined( self.enemy ) )
    {
        toenemy = self.enemy.origin - self.origin;
        toenemyyaw = angleclamp180( vectortoyaw( toenemy ) - self.angles[ 1 ] );
        
        if ( toenemyyaw < 0 )
        {
            alias += "_turn6";
        }
        else
        {
            alias += "_turn4";
        }
    }
    else if ( self.vehicleseatonleft )
    {
        alias += "_turn4";
    }
    else
    {
        alias += "_turn6";
    }
    
    return alias;
}

// Namespace vehicle
// Params 1
// Checksum 0x4c458c7c, Offset: 0x5ea
// Size: 0xbd
function getpainalias( aianims )
{
    alias = "";
    flashed = utility::isflashed();
    
    if ( isdefined( self.damageyaw ) && !flashed )
    {
        if ( self.damageyaw > 135 )
        {
            alias += "_2";
        }
        else if ( self.damageyaw > 45 )
        {
            alias += "_4";
        }
        else if ( self.damageyaw > -45 )
        {
            alias += "_8";
        }
        else if ( self.damageyaw > -135 )
        {
            alias += "_6";
        }
        else
        {
            alias += "_2";
        }
    }
    
    return alias;
}

// Namespace vehicle
// Params 3
// Checksum 0x3a07e955, Offset: 0x6b0
// Size: 0x39
function chooseanim_vehicle( asmname, statename, params )
{
    return asm::asm_lookupanimfromalias( statename, self._blackboard.chosenvehicleanimpos_seatalias );
}

// Namespace vehicle
// Params 3
// Checksum 0xa180f485, Offset: 0x6f2
// Size: 0x120
function chooseanim_vehiclepain( asmname, statename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = self._blackboard.chosenvehicleanimpos_seatalias;
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_25799974c1f2939b;
        aianims = vehicle_aianim::anim_pos( vehicle, position );
        alias += getpainalias( aianims );
    }
    
    if ( isdefined( self.var_5a09f6da31beb767 ) )
    {
        statename = "vehicle_pain";
    }
    
    animresult = archetypegetrandomalias( arcname, statename, alias );
    
    if ( isdefined( animresult ) )
    {
        return asm::asm_lookupanimfromalias( statename, alias );
    }
    
    return asm::asm_lookupanimfromalias( statename, self._blackboard.chosenvehicleanimpos_seatalias );
}

// Namespace vehicle
// Params 3
// Checksum 0x73e3c1cc, Offset: 0x81a
// Size: 0xc7
function chooseanim_vehiclehide( asmname, statename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = self._blackboard.chosenvehicleanimpos_seatalias;
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_25799974c1f2939b;
        aianims = vehicle_aianim::anim_pos( vehicle, position );
    }
    
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace vehicle
// Params 3
// Checksum 0x46004417, Offset: 0x8ea
// Size: 0x28
function function_6f8a5191697a04d9( asmname, statename, params )
{
    return chooseanim_vehicle( asmname, statename, params );
}

// Namespace vehicle
// Params 3
// Checksum 0xae225d62, Offset: 0x91b
// Size: 0x99
function function_881ea9bf3836666f( asmname, statename, params )
{
    alias = self._blackboard.chosenvehicleanimpos_seatalias;
    
    if ( isdefined( self.vehicleseatonleft ) )
    {
        switchsidesalias = function_956dd9c876d9184a();
        alias += switchsidesalias;
        self.vehicleseatonleft = !self.vehicleseatonleft;
        self._blackboard.var_b2d70e064192de04 = self.vehicleseatonleft;
    }
    
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace vehicle
// Params 4
// Checksum 0x371dda6, Offset: 0x9bd
// Size: 0x33
function function_53b34a1b85e11597( asmname, statename, tostatename, param )
{
    return self [[ self.fnisinstealthidle ]]();
}

// Namespace vehicle
// Params 4
// Checksum 0xdc45b98e, Offset: 0x9f9
// Size: 0x6a, Type: bool
function vehicleincombat( asmname, statename, tostatename, params )
{
    if ( weaponclass( self.weapon ) == "rocketlauncher" && !self.vehiclerpg )
    {
        return false;
    }
    
    return asm::asm_getdemeanor() == "combat" && !self [[ self.fnisinstealthhunt ]]();
}

// Namespace vehicle
// Params 3
// Checksum 0x5ff5d986, Offset: 0xa6c
// Size: 0x32
function function_22f719457d89c362( asmname, statename, params )
{
    if ( !self.canreimpulse )
    {
        function_43dfba9693d4b9a0();
    }
}

// Namespace vehicle
// Params 2
// Checksum 0xb2fd78a8, Offset: 0xaa6
// Size: 0x80
function function_2fcf021461b16927( fwd, Impact )
{
    ccos45 = cos( 45 );
    dot = vectordot( fwd, Impact );
    
    if ( dot > ccos45 )
    {
        return 2;
    }
    
    if ( dot < -1 * ccos45 )
    {
        return 8;
    }
    
    cross = vectorcross( fwd, Impact );
    
    if ( cross[ 2 ] > 0 )
    {
        return 6;
    }
    
    return 4;
}

// Namespace vehicle
// Params 3
// Checksum 0x90965838, Offset: 0xb2e
// Size: 0x2b2
function function_84b80d3028f54267( asmname, statename, param )
{
    /#
        setdvarifuninitialized( @"hash_e4eece17e1ee5b59", 0 );
    #/
    
    seatalias = self._blackboard.chosenvehicleanimpos_seatalias;
    alias = seatalias;
    self.canreimpulse = 0;
    
    if ( isdefined( archetypegetrandomalias( self._blackboard.currentvehicleanimalias, statename, alias ) ) )
    {
        return asm::asm_lookupanimfromalias( statename, alias );
    }
    
    alias = alias + "_" + self._blackboard.vehicledir;
    assert( isdefined( self.collision_data ), "<dev string:x24>" );
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_25799974c1f2939b;
    aianims = vehicle_aianim::anim_pos( vehicle, position );
    arcname = self._blackboard.currentvehicleanimalias;
    
    if ( aianims.var_14f441f730dc229d )
    {
        alias = function_a055bf5ee5b0fdb4( arcname, statename, alias );
        
        /#
            if ( getdvarint( @"hash_e4eece17e1ee5b59" ) != 0 )
            {
                print3d( self.origin, alias, ( 0, 1, 0 ), 1, 0.5, 100, 1 );
            }
        #/
    }
    else
    {
        vehforward = anglestoforward( vehicle.angles );
        vehforward = vectornormalize2( vehforward );
        normal = self.collision_data.normal;
        normal = vectornormalize2( normal );
        dir = function_2fcf021461b16927( vehforward, normal );
        alias = alias + "_" + dir;
        
        /#
            if ( getdvarint( @"hash_e4eece17e1ee5b59" ) != 0 )
            {
                print3d( self.origin, alias, ( 0, 1, 0 ), 1, 0.5, 100, 1 );
            }
        #/
        
        if ( !asm::asm_hasalias( statename, alias ) )
        {
            print( "<dev string:xb8>" + getxhashsourcename( alias ) + "<dev string:xcf>" + arcname + "<dev string:xe0>" + statename + "<dev string:xea>" + self.classname + "<dev string:xf2>" );
            aifwd = anglestoforward( self.angles );
            aifwd = vectornormalize2( aifwd );
            dir = function_2fcf021461b16927( aifwd, normal );
            alias = seatalias + "_8_" + dir;
        }
    }
    
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace vehicle
// Params 2, eflags: 0x4
// Checksum 0x6d04a174, Offset: 0xde9
// Size: 0x2b
function private function_3ca1629867ddb8cc( index, mapsize )
{
    if ( index == mapsize - 1 )
    {
        index = 1;
    }
    else
    {
        index++;
    }
    
    return index;
}

// Namespace vehicle
// Params 2, eflags: 0x4
// Checksum 0xdc973fa8, Offset: 0xe1d
// Size: 0x2b
function private function_26adb41146356f54( index, mapsize )
{
    if ( index == 0 )
    {
        index = mapsize - 2;
    }
    else
    {
        index--;
    }
    
    return index;
}

// Namespace vehicle
// Params 3, eflags: 0x4
// Checksum 0x9c303feb, Offset: 0xe51
// Size: 0x19e
function private function_a055bf5ee5b0fdb4( arcname, statename, seatalias )
{
    aimangles = self getaimangle();
    var_4e5c5b70e54cc1d2 = [ "2", "3", "6", "9", "8", "7", "4", "1", "2" ];
    angleindex = getangleindex( aimangles[ 1 ], 22.5 );
    currentindex = angleindex;
    mapsize = var_4e5c5b70e54cc1d2.size;
    
    if ( var_4e5c5b70e54cc1d2[ getangleindex( aimangles[ 1 ] + 11.25, 22.5 ) ] == var_4e5c5b70e54cc1d2[ currentindex ] )
    {
        var_e2964387b7c96e7d = currentindex;
        var_e4a26e2075587c74 = function_26adb41146356f54( currentindex, mapsize );
    }
    else
    {
        var_e2964387b7c96e7d = function_3ca1629867ddb8cc( currentindex, mapsize );
        var_e4a26e2075587c74 = currentindex;
    }
    
    directionalalias = seatalias + "_" + var_4e5c5b70e54cc1d2[ currentindex ];
    
    for ( directionalanim = archetypegetrandomalias( arcname, statename, directionalalias ); !isdefined( directionalanim ) ; directionalanim = archetypegetrandomalias( arcname, statename, directionalalias ) )
    {
        if ( currentindex == var_e2964387b7c96e7d )
        {
            currentindex = var_e4a26e2075587c74;
            var_e2964387b7c96e7d = function_3ca1629867ddb8cc( var_e2964387b7c96e7d, mapsize );
        }
        else
        {
            currentindex = var_e2964387b7c96e7d;
            var_e4a26e2075587c74 = function_26adb41146356f54( var_e4a26e2075587c74, mapsize );
        }
        
        if ( var_4e5c5b70e54cc1d2[ var_e4a26e2075587c74 ] == var_4e5c5b70e54cc1d2[ var_e2964387b7c96e7d ] )
        {
            break;
        }
        
        directionalalias = seatalias + "_" + var_4e5c5b70e54cc1d2[ currentindex ];
    }
    
    if ( isdefined( directionalanim ) )
    {
        return directionalalias;
    }
    
    return seatalias;
}

// Namespace vehicle
// Params 3
// Checksum 0xad592d30, Offset: 0xff7
// Size: 0x77
function function_1bf84c0a9526ac66( asmname, statename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    seatalias = self._blackboard.chosenvehicleanimpos_seatalias;
    var_a46784d87a50ff8a = function_a055bf5ee5b0fdb4( arcname, statename, seatalias );
    return asm::asm_lookupanimfromalias( statename, var_a46784d87a50ff8a );
}

// Namespace vehicle
// Params 4
// Checksum 0xde250c38, Offset: 0x1077
// Size: 0x9b
function function_549988004c8c9b7f( asmname, statename, tostatename, params )
{
    if ( !isdefined( self._blackboard.currentvehicle ) )
    {
        return 0;
    }
    
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_25799974c1f2939b;
    aianims = vehicle_aianim::anim_pos( vehicle, position );
    return aianims.var_14f441f730dc229d;
}

// Namespace vehicle
// Params 3
// Checksum 0xfe3d078e, Offset: 0x111b
// Size: 0x179
function chooseanim_vehicleoriented( asmname, statename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = self._blackboard.chosenvehicleanimpos_seatalias;
    
    if ( isdefined( self._blackboard.vehicledir ) && self._blackboard.vehicledir != 8 )
    {
        alias = alias + "_" + self._blackboard.vehicledir;
    }
    
    weaponclassalias = "_" + weaponclass( self.weapon );
    var_739f675f7546797f = archetypegetrandomalias( arcname, statename, alias + weaponclassalias );
    
    if ( isdefined( var_739f675f7546797f ) )
    {
        return asm::asm_lookupanimfromalias( statename, alias + weaponclassalias );
    }
    
    animresult = archetypegetrandomalias( arcname, statename, alias );
    
    if ( isdefined( animresult ) )
    {
        return asm::asm_lookupanimfromalias( statename, alias );
    }
    
    var_739f675f7546797f = archetypegetrandomalias( arcname, statename, self._blackboard.chosenvehicleanimpos_seatalias + weaponclassalias );
    
    if ( isdefined( var_739f675f7546797f ) )
    {
        return asm::asm_lookupanimfromalias( statename, self._blackboard.chosenvehicleanimpos_seatalias + weaponclassalias );
    }
    
    return asm::asm_lookupanimfromalias( statename, self._blackboard.chosenvehicleanimpos_seatalias );
}

// Namespace vehicle
// Params 3
// Checksum 0xce41b4cd, Offset: 0x129c
// Size: 0x2b
function chooseanim_vehicleturret( asmname, statename, params )
{
    return asm::asm_lookupanimfromalias( statename, "blank" );
}

// Namespace vehicle
// Params 3
// Checksum 0xcc8dfd33, Offset: 0x12d0
// Size: 0x2b
function chooseanim_vehicleturretdeath( asmname, statename, params )
{
    return asm::asm_lookupanimfromalias( statename, "vehicle_turret_death" );
}

// Namespace vehicle
// Params 6
// Checksum 0xa92f4349, Offset: 0x1304
// Size: 0x1bd
function getvehicleanimtargetoriginandangles( vehicle, vehicleanim, vehicletag, vehiclelocation, vehicleangles, animendfrac )
{
    result = [];
    
    if ( !isdefined( animendfrac ) )
    {
        animendfrac = 1;
    }
    
    if ( isdefined( vehicle ) && isdefined( vehicletag ) )
    {
        tagorigin = vehicle gettagorigin( vehicletag );
        tagangles = vehicle gettagangles( vehicletag );
        seatinfo = vehicle_aianim::anim_pos( vehicle, self._blackboard.var_25799974c1f2939b );
        
        if ( isdefined( seatinfo ) && isdefined( seatinfo.linkoffset ) )
        {
            tagorigin += rotatevector( seatinfo.linkoffset, vehicle.angles );
        }
        
        if ( isdefined( seatinfo ) && isdefined( seatinfo.linkangle ) )
        {
            tagangles += seatinfo.linkangle;
        }
        
        startorigin = getstartorigin( tagorigin, tagangles, vehicleanim );
        startangles = getstartangles( tagorigin, tagangles, vehicleanim );
        movedelta = getmovedelta( vehicleanim, 0, animendfrac );
        angledelta = getangledelta3d( vehicleanim, 0, animendfrac );
        result[ "startOrigin" ] = startorigin;
        result[ "startAngles" ] = startangles;
        result[ "targetOrigin" ] = rotatevector( movedelta, startangles ) + startorigin;
        result[ "targetAngles" ] = startangles + angledelta;
    }
    else
    {
        result[ "startOrigin" ] = self.origin;
        result[ "startAngles" ] = self.angles;
        result[ "targetOrigin" ] = vehiclelocation;
        result[ "targetAngles" ] = vehicleangles;
    }
    
    return result;
}

// Namespace vehicle
// Params 0, eflags: 0x4
// Checksum 0x2536500f, Offset: 0x14ca
// Size: 0x14d
function private function_9d4b246b152263e8()
{
    var_bc114156dc7a2d72 = self._blackboard.currentvehicle;
    assert( isdefined( var_bc114156dc7a2d72 ), "<dev string:xf4>" );
    assert( var_bc114156dc7a2d72 is_common_vehicle() );
    data = get_data( var_bc114156dc7a2d72 get_ref() );
    seatdata = data.aiseats;
    foundindex = undefined;
    
    foreach ( seat in seatdata )
    {
        if ( seat.sittag == self._blackboard.chosenvehicleanimpos_sittag && seat.mgturret )
        {
            foundindex = seat.vehicleturretindex;
            break;
        }
    }
    
    assert( isdefined( foundindex ), "<dev string:x13b>" + self._blackboard.chosenvehicleanimpos_sittag + "<dev string:x16e>" );
    return foundindex;
}

// Namespace vehicle
// Params 4
// Checksum 0x84c473c8, Offset: 0x1620
// Size: 0x1b3
function linktovehicle( org, ang, linktoblend, sittag )
{
    if ( self.var_1633d8e2541091c7 )
    {
        return self [[ self.var_1633d8e2541091c7 ]]( org, ang, linktoblend, sittag );
    }
    
    self forceteleport( org, ang );
    
    if ( linktoblend )
    {
        self linktoblendtotag( self._blackboard.currentvehicle, sittag, 0 );
    }
    else
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_25799974c1f2939b;
        aianims = vehicle_aianim::anim_pos( vehicle, position );
        
        if ( isdefined( aianims.linkoffset ) && isdefined( aianims.linkangle ) )
        {
            self linktomoveoffset( self._blackboard.currentvehicle, sittag, aianims.linkoffset, aianims.linkangle );
        }
        else if ( self._blackboard.currentvehicle.var_576395da235040f2 )
        {
            self linktomoveoffset( self._blackboard.currentvehicle, sittag );
        }
        else
        {
            self linktomoveoffset( self._blackboard.currentvehicle, sittag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        }
    }
    
    if ( isagent( self ) )
    {
        self playerlinkedoffsetenable();
        self fixlinktointerpolationbug( 1 );
    }
    
    self._blackboard.linkedtovehicle = 1;
}

// Namespace vehicle
// Params 2
// Checksum 0x1573fe66, Offset: 0x17db
// Size: 0x287
function faceenemyincombat( asmname, statename )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        canshootinvehicle = self._blackboard.var_fef1650fd4ff6f6 && self.canshootinvehicle;
        canrotate = isdefined( self._blackboard.currentvehicle ) && !self._blackboard.currentvehicle.vehicledisableturningwhileshooting;
        enemyisalive = isdefined( self.enemy ) && ( !( isplayer( self.enemy ) || isai( self.enemy ) ) || isalive( self.enemy ) );
        incombat = vehicleincombat( asmname, statename, statename );
        
        if ( incombat && enemyisalive && canshootinvehicle && canrotate )
        {
            axis = anglestoaxis( self._blackboard.currentvehicle.angles );
            forward = axis[ "forward" ];
            up = axis[ "up" ];
            yaw = utility::getyaw( self.enemy.origin ) - self._blackboard.currentvehicle.angles[ 1 ];
            yaw = angleclamp180( yaw );
            facing = rotatepointaroundvector( up, forward, yaw );
            faceangles = axistoangles( facing, vectorcross( facing, up ), up );
            self orientmode( "face angle 3d", faceangles );
        }
        else
        {
            self orientmode( "face current angles" );
        }
        
        /#
            if ( getdvarint( @"hash_e8e7feb9b789f1d7" ) && incombat )
            {
                sphere( self.origin + ( 0, 0, 40 ), 2.5, ( 0, 1, 0 ), 0, 1 );
                line( self.origin + ( 0, 0, 40 ), self.origin + ( 0, 0, 40 ) + anglestoforward( self.angles ) * 10, ( 0, 1, 0 ), 1, 0, 1 );
            }
        #/
        
        waitframe();
    }
}

// Namespace vehicle
// Params 3
// Checksum 0xaf382c0e, Offset: 0x1a6a
// Size: 0x158
function function_1636b2b87abfcf8f( asmname, statename, var_703ac1898817edff )
{
    if ( ( var_703ac1898817edff || !self._blackboard.linkedtovehicle ) && isdefined( self._blackboard.currentvehicle ) )
    {
        self.leftaimlimit = 180;
        self.rightaimlimit = -180;
        animindexidle = asm::asm_getanim( asmname, statename );
        xanimidle = asm::asm_getxanim( statename, animindexidle );
        self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanimidle, self._blackboard.chosenvehicleanimpos_sittag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles );
        linktovehicle( self.asm.targetvalues[ "targetOrigin" ], self.asm.targetvalues[ "targetAngles" ], self._blackboard.chosenvehicleanimpos_linktoblend, self._blackboard.chosenvehicleanimpos_sittag );
    }
}

// Namespace vehicle
// Params 3
// Checksum 0x29e05ee1, Offset: 0x1bca
// Size: 0x140
function playanim_vehicleidle( asmname, statename, params )
{
    self endon( statename + "_finished" );
    setvehiclearchetype();
    
    if ( isdefined( self.vehicleaimyawspeed ) )
    {
        self.aimyawspeed = self.vehicleaimyawspeed;
    }
    else
    {
        self.aimyawspeed = 90;
    }
    
    if ( isdefined( self.var_1d25aaa351ced747 ) )
    {
        self.var_d56d7a593eacddb6 = self.var_1d25aaa351ced747;
    }
    else
    {
        self.var_1d25aaa351ced747 = -1;
    }
    
    function_1636b2b87abfcf8f( asmname, statename );
    self._blackboard.var_3592b6bb6169ca01 = 0;
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        if ( self._blackboard.currentvehicle ishelicopter() )
        {
            self._blackboard.var_3592b6bb6169ca01 = 1;
        }
    }
    
    endvehiclemotionwarp();
    self animmode( "nogravity" );
    self orientmode( "face current angles" );
    animindex = asm::asm_getanim( asmname, statename );
    self aisetanim( statename, animindex );
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
}

// Namespace vehicle
// Params 3
// Checksum 0xe649e900, Offset: 0x1d12
// Size: 0x30
function function_69e04a3efc20ce53( asmname, statename, params )
{
    setvehiclearchetype();
    asm::asm_playanimstate( asmname, statename, params );
}

// Namespace vehicle
// Params 1
// Checksum 0x2ccfdf6b, Offset: 0x1d4a
// Size: 0x31
function function_75486e23d9240384( statename )
{
    self endon( #"death" );
    self function_e4a314ead67ffb55();
    self waittill( statename + "_finished" );
    self function_e4a314ead67ffb55( 0 );
}

// Namespace vehicle
// Params 3
// Checksum 0x97060068, Offset: 0x1d83
// Size: 0x56
function playanim_vehiclepain( asmname, statename, params )
{
    if ( function_549988004c8c9b7f() )
    {
        thread function_75486e23d9240384( statename );
    }
    
    if ( isdefined( self.var_5a09f6da31beb767 ) )
    {
        statename = "vehicle_pain";
    }
    
    setvehiclearchetype();
    pain::playpainanim( asmname, statename, params );
}

// Namespace vehicle
// Params 3
// Checksum 0xd89b1aa3, Offset: 0x1de1
// Size: 0x30
function playanim_vehicleflashed( asmname, statename, params )
{
    setvehiclearchetype();
    pain::playanim_flashed( asmname, statename, params );
}

// Namespace vehicle
// Params 1
// Checksum 0x48506e43, Offset: 0x1e19
// Size: 0x1c2
function vehicleturretshootthread( turret )
{
    self endon( #"death" );
    self endon( #"unload" );
    self endon( #"stop_shooting" );
    turret utility::self_func( "SetAISpread", 2 );
    turret setmode( "manual" );
    turret.gunner = self;
    self linktoblendtotag( turret, "tag_gunner", 0 );
    mercy = 0;
    maxmercy = 2;
    var_981ecffd640ac572 = 0;
    loseplayertime = 7000;
    
    while ( isalive( self ) )
    {
        if ( isdefined( self.enemy ) )
        {
            turret settargetentity( self.enemy );
            turret waittill( #"turret_on_target" );
            burst = randomintrange( 12, 18 );
            shots = 0;
            minshots = randomintrange( 7, 12 );
            
            for ( i = 0; i < burst ; i++ )
            {
                shots++;
                turret shootturret();
                wait 0.05;
                
                if ( randomint( 100 ) < 25 )
                {
                    wait randomfloatrange( 0.1, 0.2 );
                }
                
                target = turret getturrettarget( 0 );
                
                if ( isplayer( target ) && mercy < maxmercy && target.health < 60 )
                {
                    mercy++;
                    wait 3;
                }
                
                if ( shots > minshots )
                {
                    if ( issentient( target ) && !isalive( target ) )
                    {
                        break;
                    }
                }
            }
            
            var_981ecffd640ac572 = gettime() + loseplayertime;
        }
        else if ( var_981ecffd640ac572 <= gettime() )
        {
            turret cleartargetentity();
        }
        
        wait 0.8 + randomfloat( 1 );
    }
}

// Namespace vehicle
// Params 3
// Checksum 0x9184f6ae, Offset: 0x1fe3
// Size: 0x2af
function playanim_vehicleturret( asmname, statename, params )
{
    self endon( statename + "_finished" );
    
    if ( isdefined( self._blackboard.currentvehicle.mgturret[ 0 ] ) )
    {
        is_turret = self._blackboard.currentvehicle.mgturret[ 0 ].classname == "misc_turret";
        var_14e6abfbfd597a72 = self._blackboard.currentvehicle.mgturret[ 0 ].classname == "script_vehicle";
        
        if ( is_turret )
        {
            utility::use_turret( self._blackboard.currentvehicle.mgturret[ 0 ], undefined );
        }
        else if ( var_14e6abfbfd597a72 )
        {
            index = function_9d4b246b152263e8();
            utility::use_vehicle_turret( self._blackboard.currentvehicle, index );
        }
        
        if ( !self._blackboard.currentvehicle.mgturret[ 0 ].var_26fe2ac086a3523b )
        {
            if ( isdefined( self._blackboard.currentvehicle.customattackfunc ) )
            {
                self._blackboard.currentvehicle thread [[ self._blackboard.currentvehicle.customattackfunc ]]();
            }
            else if ( self._blackboard.currentvehicle.var_8d709d1797b48f07 )
            {
                if ( is_turret )
                {
                    thread vehicleturretshootthread( self._blackboard.currentvehicle.mgturret[ 0 ] );
                }
                else if ( var_14e6abfbfd597a72 )
                {
                    index = function_9d4b246b152263e8();
                    self._blackboard.currentvehicle setturretscriptcontrolled( 1, index );
                    self._blackboard.currentvehicle turret::function_9b1f535339c80a4( index );
                }
            }
            
            self._blackboard.currentvehicle.mgturret[ 0 ].var_26fe2ac086a3523b = 1;
        }
    }
    
    setvehiclearchetype();
    self animmode( "nogravity" );
    self orientmode( "face current angles" );
    animindex = asm::asm_getanim( asmname, statename );
    self aisetanim( statename, animindex );
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
}

// Namespace vehicle
// Params 3
// Checksum 0x3fd36838, Offset: 0x229a
// Size: 0x18e
function playanim_vehicleturret_terminate( asmname, statename, params )
{
    var_14e6abfbfd597a72 = self._blackboard.currentvehicle.mgturret[ 0 ].classname == "script_vehicle";
    
    if ( var_14e6abfbfd597a72 )
    {
        self function_41545111c3f7cb5d();
        index = function_9d4b246b152263e8();
        self._blackboard.currentvehicle setturretscriptcontrolled( 0, index );
        self._blackboard.currentvehicle turret::function_9a0fa09f3acbc0cd( index );
    }
    
    clearvehiclearchetype();
    
    if ( isdefined( self._blackboard.currentvehicle ) && isdefined( self._blackboard.currentvehicle.mgturret ) )
    {
        if ( isdefined( self._blackboard.currentvehicle.mgturret[ 0 ] ) )
        {
            if ( self._blackboard.currentvehicle.mgturret[ 0 ].classname == "misc_turret" )
            {
                self._blackboard.currentvehicle.mgturret[ 0 ] cleartargetentity();
            }
            
            self._blackboard.currentvehicle.mgturret[ 0 ].var_26fe2ac086a3523b = 0;
        }
    }
}

// Namespace vehicle
// Params 0
// Checksum 0xe440ee7b, Offset: 0x2430
// Size: 0x43
function rotatetocurrentangles()
{
    self endon( #"death" );
    self endon( #"endvehiclemotionwarp" );
    self endon( #"hash_ba0090c4e2ed5609" );
    
    while ( true )
    {
        self orientmode( "face angle 3d", self.angles );
        waitframe();
    }
}

// Namespace vehicle
// Params 6
// Checksum 0xae3f8c36, Offset: 0x247b
// Size: 0xe5b
function enterexitvehiclemotionwarp( asmname, statename, xanim, vehicletag, exiting, xanimtargetoverride )
{
    if ( isplayer( self ) )
    {
        self endon( #"death_or_disconnect" );
    }
    else
    {
        self endon( #"death" );
    }
    
    self endon( #"endvehiclemotionwarp" );
    self animmode( "noclip" );
    self orientmode( "face current" );
    seatinfo = vehicle_aianim::anim_pos( self._blackboard.currentvehicle, self._blackboard.var_25799974c1f2939b );
    assert( isdefined( xanim ), "<dev string:x184>" + asmname + "<dev string:x1a6>" + statename + "<dev string:x1b0>" + exiting + "<dev string:x1bc>" + ( vehicletag ?? "<dev string:x1c4>" ) + "<dev string:x1ce>" + ( xanimtargetoverride ?? "<dev string:x1db>" ) );
    validxanim = isdefined( xanim );
    animlength = 1;
    
    if ( validxanim )
    {
        animlength = getanimlength( xanim );
    }
    
    animstartfrac = 0;
    startnote = undefined;
    
    if ( validxanim && animhasnotetrack( xanim, "motion_warp_begin" ) )
    {
        animstartfrac = getnotetracktimes( xanim, "motion_warp_begin" )[ 0 ];
        startnote = "motion_warp_begin";
    }
    
    animendfrac = 1;
    endnote = undefined;
    
    if ( validxanim && animhasnotetrack( xanim, "motion_warp_end" ) )
    {
        animendfrac = getnotetracktimes( xanim, "motion_warp_end" )[ 0 ];
        endnote = "motion_warp_end";
    }
    
    if ( validxanim && animhasnotetrack( xanim, "vehicle_cab_transition" ) )
    {
        var_69d60bc3299bdc53 = getnotetracktimes( xanim, "vehicle_cab_transition" )[ 0 ];
        
        if ( exiting )
        {
            self.var_9f2be75059f33907 = gettime();
            self.var_61ac0cadde089972 = gettime() + 1000 * animlength * var_69d60bc3299bdc53;
        }
        else
        {
            self.var_9f2be75059f33907 = gettime() + 1000 * animlength * var_69d60bc3299bdc53;
            self.var_61ac0cadde089972 = gettime() + 1000 * animlength;
        }
    }
    
    linkpos = self._blackboard.currentvehicle gettagorigin( vehicletag );
    linkang = self._blackboard.currentvehicle gettagangles( vehicletag );
    
    if ( isdefined( seatinfo.linkoffset ) )
    {
        linkpos += rotatevector( seatinfo.linkoffset, self._blackboard.currentvehicle.angles );
    }
    
    if ( isdefined( seatinfo.linkangle ) )
    {
        linkang += seatinfo.linkangle;
    }
    
    animindex = asm::asm_getanim( asmname, statename );
    waittime = animlength * animstartfrac;
    
    /#
        if ( vehicle_common::function_1b2539f38f15adae( 3 ) )
        {
            sphere( self.origin, 2, ( 1, 0, 0 ), 0, 300 );
        }
    #/
    
    if ( exiting )
    {
        if ( isdefined( self._blackboard.chosenvehicleanimpos_fastroperig ) )
        {
            thread rotatetocurrentangles();
        }
        else
        {
            if ( isdefined( xanimtargetoverride ) )
            {
                self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanimtargetoverride, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac );
            }
            else if ( validxanim )
            {
                self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanim, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac );
            }
            
            if ( !self.enemy )
            {
                self orientmode( "face angle 3d", self.asm.targetvalues[ "startAngles" ] );
            }
            
            /#
                if ( vehicle_common::function_1b2539f38f15adae( 3 ) )
                {
                    sphere( self.asm.targetvalues[ "<dev string:x1e6>" ], 3, ( 0, 0, 1 ), 0, 300 );
                }
            #/
        }
    }
    else
    {
        self aisetanim( statename, animindex );
        var_ff32d80ea94a704a = self.origin - self._blackboard.currentvehicle gettagorigin( vehicletag );
        invlinkang = invertangles( self._blackboard.currentvehicle gettagangles( vehicletag ) );
        localtargetpos = rotatevector( var_ff32d80ea94a704a, invlinkang );
        var_82b26273be843388 = combineanglesinverted( linkang, self.angles );
        self linktomoveoffset( self._blackboard.currentvehicle, vehicletag, localtargetpos, var_82b26273be843388 );
        self._blackboard.linkedtovehicle = 1;
        
        if ( isagent( self ) )
        {
            self playerlinkedoffsetenable();
            self fixlinktointerpolationbug( 1 );
        }
    }
    
    wait waittime;
    
    /#
        if ( vehicle_common::function_1b2539f38f15adae( 3 ) )
        {
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:x1f3>", ( 1, 1, 1 ), 1, 0.3, 300 );
            sphere( self.origin, 2, ( 1, 0, 0 ), 0, 300 );
        }
    #/
    
    self motionwarpcancel();
    
    if ( !isdefined( self.asm ) )
    {
        return;
    }
    
    self notify( #"hash_ba0090c4e2ed5609" );
    warpduration = ( animendfrac - animstartfrac ) * animlength;
    
    if ( isdefined( xanimtargetoverride ) )
    {
        self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanimtargetoverride, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac );
    }
    else if ( validxanim )
    {
        self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanim, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac );
    }
    
    targetpoint = self.asm.targetvalues[ "targetOrigin" ];
    targetangles = self.asm.targetvalues[ "targetAngles" ];
    
    /#
        if ( vehicle_common::function_1b2539f38f15adae( 3 ) )
        {
            sphere( targetpoint, 3, ( 0, 1, 0 ), 0, 300 );
        }
    #/
    
    if ( validxanim )
    {
        if ( exiting )
        {
            if ( function_d7ba7989b9cd118e() )
            {
                self unlink();
                self._blackboard.linkedtovehicle = 0;
            }
            
            self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanim, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac );
            projected = self.asm.targetvalues[ "targetOrigin" ];
            
            if ( !isdefined( self._blackboard.chosenvehicleanimpos_fastroperig ) && isdefined( self._blackboard.currentvehicle ) )
            {
                vehiclevel = self._blackboard.currentvehicle vehicle_getvelocity();
                v2d = vehiclevel - ( 0, 0, vehiclevel[ 2 ] );
                projected += v2d * 0.25;
            }
            
            targetangles = ( 0, self.asm.targetvalues[ "targetAngles" ][ 1 ], 0 );
            
            if ( self.enemy && !isdefined( self._blackboard.chosenvehicleanimpos_fastroperig ) )
            {
                directiontoenemy = vectornormalize( self.enemy.origin - self.origin );
                facingangle = vectortoangles( directiontoenemy );
                targetangles = ( 0, facingangle[ 1 ], 0 );
                
                /#
                    if ( vehicle_common::function_1b2539f38f15adae( 3 ) )
                    {
                        print3d( self.origin + ( 0, 0, 60 ), "<dev string:x205>", ( 1, 0, 0 ), 1, 0.3, 300 );
                        line( self.origin, self.enemy.origin, ( 0, 1, 0 ), 1, 1, 500 );
                        sphere( self.enemy.origin, 3, ( 1, 0, 0 ), 0, 300 );
                    }
                #/
                
                currentangles = self.angles;
                rotationdelta = angleclamp180( targetangles - currentangles );
                
                if ( abs( rotationdelta[ 1 ] ) > 35 )
                {
                    rotationdelta = ( rotationdelta[ 0 ], clamp( rotationdelta[ 1 ], -35, 35 ), rotationdelta[ 2 ] );
                }
                
                targetangles = currentangles + rotationdelta;
            }
            
            targetpoint = getclosestpointonnavmesh( projected, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
            
            if ( distance2dsquared( targetpoint, self.asm.targetvalues[ "targetOrigin" ] ) > 16384 )
            {
                /#
                    if ( vehicle_common::function_1b2539f38f15adae( 3 ) )
                    {
                        print3d( self.origin, "<dev string:x219>", ( 1, 1, 1 ), 1, 0.3, 2000, 0 );
                        line( self.origin, targetpoint, ( 255, 165, 0 ), 1, 0, 2000 );
                        sphere( targetpoint, 5, ( 255, 165, 0 ), 0, 2000 );
                    }
                #/
                
                targetpoint = self.asm.targetvalues[ "targetOrigin" ];
            }
            
            contents = trace::create_solid_ai_contents( 1 );
            ignorelist = [];
            
            if ( isdefined( self ) )
            {
                ignorelist[ ignorelist.size ] = self;
            }
            
            if ( isdefined( self._blackboard.currentvehicle ) )
            {
                ignorelist[ ignorelist.size ] = self._blackboard.currentvehicle;
            }
            
            spherecaststart = targetpoint + ( 0, 0, 72 );
            spherecastend = targetpoint + ( 0, 0, -1000 );
            collisionresults = physics_spherecast( spherecaststart, spherecastend, 12, contents, ignorelist, "physicsquery_closest" );
            
            if ( collisionresults.size > 0 )
            {
                targetpoint = collisionresults[ 0 ][ "position" ];
            }
            
            /#
                if ( getdvarint( @"scr_ai_debugvehicleexit", 0 ) == 1 )
                {
                    startpoint = self.asm.targetvalues[ "<dev string:x238>" ];
                    startangles = self.asm.targetvalues[ "<dev string:x244>" ];
                    startendpoint = startpoint + anglestoforward( startangles ) * 5;
                    line( startpoint, startendpoint, ( 0, 1, 0 ), 1, 0, 2000 );
                    sphere( startpoint, 1, ( 0, 1, 0 ), 0, 2000 );
                    line( targetpoint, self.origin, ( 0, 0, 1 ), 1, 0, 2000 );
                    sphere( targetpoint, 5, ( 0, 0, 1 ), 0, 2000 );
                    line( self.asm.targetvalues[ "<dev string:x1e6>" ], self.origin, ( 1, 0, 0 ), 1, 0, 2000 );
                    sphere( self.asm.targetvalues[ "<dev string:x1e6>" ], 5, ( 1, 0, 0 ), 0, 2000 );
                }
            #/
            
            self animmode( "noclip" );
            utility::motionwarpwithnotetracks( xanim, targetpoint, targetangles, startnote, endnote, int( warpduration * 1000 ) );
        }
        else
        {
            movedelta = getmovedelta( xanim, animstartfrac, animendfrac );
            angledelta = getangledelta3d( xanim, animstartfrac, animendfrac );
            startangle = targetangles - angledelta;
            startangle = angleclamp180( startangle );
            startpos = targetpoint - rotatevector( movedelta, startangle );
            self aisetanim( statename, animindex );
            self aisetanimtime( xanim, animstartfrac );
            self motionwarpwithanim( startpos, startangle, targetpoint, targetangles, int( warpduration * 1000 ) );
        }
    }
    
    wait warpduration;
    
    /#
        if ( vehicle_common::function_1b2539f38f15adae( 3 ) )
        {
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:x250>", ( 1, 1, 1 ), 1, 0.3, 300 );
            sphere( self.origin, 2, ( 1, 0, 0 ), 0, 300 );
        }
    #/
    
    if ( exiting )
    {
        if ( !isdefined( self._blackboard ) )
        {
            return;
        }
        
        endvehiclemotionwarp();
        self unlink();
        self._blackboard.linkedtovehicle = 0;
        self animmode( "gravity" );
        return;
    }
    
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    
    if ( !( isdefined( self._blackboard ) && isdefined( self ) ) )
    {
        return;
    }
    
    if ( !self._blackboard.linkedtovehicle )
    {
        linktovehicle( self.origin, self.angles, self._blackboard.chosenvehicleanimpos_linktoblend, self._blackboard.chosenvehicleanimpos_sittag );
    }
}

// Namespace vehicle
// Params 3
// Checksum 0x4529d3de, Offset: 0x32de
// Size: 0x1ec
function playanim_entervehicle( asmname, statename, params )
{
    self endon( statename + "_finished" );
    setvehiclearchetype();
    self.customarrivalangles = undefined;
    
    if ( self.bhasriotshieldattached )
    {
        if ( utility::issp() )
        {
            self detach( self.riotshieldmodel, self.riotshieldmodeltag );
        }
        else
        {
            self aisetriotshieldweapon( nullweapon() );
        }
        
        self.bhasriotshieldattached = undefined;
        self.var_9b1f04013b677742 = 1;
    }
    
    self._blackboard.startedenteringvehicle = 1;
    animindex = asm::asm_getanim( asmname, statename );
    xanim = asm::asm_getxanim( statename, animindex );
    assert( isdefined( xanim ), "<dev string:x260>" + self._blackboard.chosenvehicleanimpos_seatalias + "<dev string:x273>" + self._blackboard.currentvehicleanimalias + "<dev string:x282>" + statename + "<dev string:x28e>" + self.classname + "<dev string:x294>" );
    self animmode( "noclip" );
    self orientmode( "face current angles" );
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_25799974c1f2939b;
        aianims = vehicle_aianim::anim_pos( vehicle, position );
        animindexidle = asm::asm_getanim( asmname, "vehicle_idle" );
        xanimidle = asm::asm_getxanim( "vehicle_idle", animindexidle );
        thread enterexitvehiclemotionwarp( asmname, statename, xanim, self._blackboard.chosenvehicleanimpos_sittag, 0, undefined );
    }
}

// Namespace vehicle
// Params 3
// Checksum 0x3cd12b4e, Offset: 0x34d2
// Size: 0x203
function entervehicle_terminate( asmname, statename, params )
{
    clearvehiclearchetype();
    
    if ( isalive( self ) )
    {
        if ( !self._blackboard.linkedtovehicle && isalive( self._blackboard.currentvehicle ) )
        {
            linktovehicle( self.asm.targetvalues[ "targetOrigin" ], self.asm.targetvalues[ "targetAngles" ], self._blackboard.chosenvehicleanimpos_linktoblend, self._blackboard.chosenvehicleanimpos_sittag );
            self.asm.targetvalues = undefined;
        }
        
        if ( isalive( self._blackboard.currentvehicle ) )
        {
            self._blackboard.enteredvehicle = 1;
        }
    }
    else
    {
        setvehiclearchetype();
        animindex = asm::asm_lookupanimfromalias( statename, self._blackboard.chosenvehicleanimpos_seatalias );
        xanim = asm::asm_getxanim( statename, animindex );
        animtime = self aigetanimtime( statename, animindex );
        animlength = getanimlength( xanim );
        transitiontime = getnotetracktimes( xanim, "vehicle_cab_transition" )[ 0 ];
        
        if ( isdefined( transitiontime ) )
        {
            if ( animtime < transitiontime )
            {
                self.diedintransition = 1;
            }
            else
            {
                self._blackboard.vehicledeathwait = ( 1 - animtime ) * animlength;
                self._blackboard.var_7d2c11d68f18313b = animtime;
                self._blackboard.var_13fc8a2fa0ff443f = statename;
                self.var_b4ae9860238072a9 = 1;
            }
        }
        else
        {
            self.diedintransition = 1;
        }
    }
    
    self motionwarpcancel();
}

// Namespace vehicle
// Params 1
// Checksum 0x96ad5242, Offset: 0x36dd
// Size: 0x4b
function exitvehiclewatchpath( statename )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        if ( isdefined( self.pathgoalpos ) )
        {
            endvehiclemotionwarp();
            self animmode( "gravity" );
            self orientmode( "face motion" );
            return;
        }
        
        waitframe();
    }
}

// Namespace vehicle
// Params 0
// Checksum 0xad9e5c93, Offset: 0x3730
// Size: 0xd0
function function_d4ef6fe998b25423()
{
    upeps = 2;
    r = 8;
    start = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + upeps );
    end = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - 10 );
    contents = trace::create_solid_ai_contents( 1 );
    ignorelist = [ self ];
    hits = physics_spherecast( start, end, r, contents, ignorelist, "physicsquery_closest" );
    
    if ( hits.size == 0 )
    {
        return 1;
    }
    
    return 0;
}

/#

    // Namespace vehicle
    // Params 1
    // Checksum 0x5c8e2fd7, Offset: 0x3808
    // Size: 0xbf, Type: dev
    function drawdeathnotetracks( xanim )
    {
        waittime = getnotetracktimes( xanim, "<dev string:x2bc>" )[ 0 ];
        ragdolltime = getnotetracktimes( xanim, "<dev string:x2cf>" )[ 0 ];
        
        if ( isdefined( waittime ) && isdefined( ragdolltime ) )
        {
            animlength = getanimlength( xanim );
            wait waittime * animlength;
            endtime = gettime() + ( ragdolltime - waittime ) * animlength * 1000;
            
            while ( isalive( self ) && gettime() < endtime )
            {
                sphere( self.origin + ( 0, 0, 60 ), 4, ( 1, 0, 0 ), 0, 1 );
                waitframe();
            }
        }
    }

#/

// Namespace vehicle
// Params 2
// Checksum 0xcd2a9487, Offset: 0x38cf
// Size: 0x2ca, Type: bool
function function_7816a377accd22d6( xanim, vehicle )
{
    animendfrac = 1;
    validxanim = isdefined( xanim );
    vehicleinfo = level.vehicle.templates.aianims[ vehicle vehicle_code::get_vehicle_classname() ];
    
    if ( validxanim && animhasnotetrack( xanim, "motion_warp_end" ) )
    {
        animendfrac = getnotetracktimes( xanim, "motion_warp_end" )[ 0 ];
    }
    
    if ( validxanim )
    {
        self.asm.targetvalues = getvehicleanimtargetoriginandangles( self._blackboard.currentvehicle, xanim, self._blackboard.chosenvehicleanimpos_sittag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac );
    }
    
    desired = self.asm.targetvalues[ "targetOrigin" ];
    navpt = getclosestpointonnavmesh( desired );
    spherecastradius = 10;
    contents = trace::create_solid_ai_contents( 1 );
    ignorelist = [ self ];
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        ignorelist[ ignorelist.size ] = self._blackboard.currentvehicle;
    }
    
    offset = ( 0, 0, 0 );
    
    if ( isdefined( self._blackboard.var_25799974c1f2939b ) && isdefined( vehicleinfo[ self._blackboard.var_25799974c1f2939b ].var_ce9c74d9845f1cc ) )
    {
        offset = vehicleinfo[ self._blackboard.var_25799974c1f2939b ].var_ce9c74d9845f1cc;
    }
    
    height = self.origin[ 2 ] + spherecastradius;
    start = ( self.origin[ 0 ], self.origin[ 1 ], height ) + offset;
    tracepoint = ( navpt[ 0 ], navpt[ 1 ], height ) + offset;
    
    /#
    #/
    
    pathhits = physics_spherecast( start, tracepoint, spherecastradius, contents, ignorelist, "physicsquery_closest" );
    
    if ( pathhits.size > 0 )
    {
        self.var_d1b0724fae506fe7 = pathhits[ 0 ];
        self._blackboard.exitingvehicle = 0;
        self._blackboard.exitvehiclerequested = 0;
        self unlink();
        self._blackboard.linkedtovehicle = 0;
        return true;
    }
    
    return false;
}

// Namespace vehicle
// Params 3
// Checksum 0x7b2b7955, Offset: 0x3ba2
// Size: 0x3a3
function playanim_exitvehicle( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self setdefaultaimlimits();
    self.requestopendoor = 1;
    self.requestopendoorparams = params;
    self.allowpain = 1;
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        if ( isdefined( self._blackboard.chosenvehicleanimpos_getoutanim ) )
        {
            anim_name = self._blackboard.chosenvehicleanimpos_getoutanim;
            self._blackboard.currentvehicle function_a3ad4171c5aa3497( anim_name );
        }
    }
    
    utility::set_movement_speed( 60 );
    self aisettargetspeed( 60 );
    self.exitvehicle_oldturnrate = self.turnrate;
    self.turnrate = 0.3;
    setvehiclearchetype();
    animindex = asm::asm_getanim( asmname, statename );
    xanim = asm::asm_getxanim( statename, animindex );
    assert( isdefined( xanim ), "<dev string:x260>" + self._blackboard.chosenvehicleanimpos_seatalias + "<dev string:x273>" + self._blackboard.currentvehicleanimalias + "<dev string:x282>" + statename + "<dev string:x28e>" + self.classname + "<dev string:x294>" );
    
    if ( function_7816a377accd22d6( xanim, self._blackboard.currentvehicle ) )
    {
        asm::asm_fireevent( asmname, "abort" );
        return;
    }
    
    self._blackboard.exitvehicleanimindex = animindex;
    
    /#
        if ( getdvarint( @"hash_89424474a6dbe389", 0 ) == 1 )
        {
            thread drawdeathnotetracks( xanim );
        }
    #/
    
    self._blackboard.var_3592b6bb6169ca01 = 0;
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        if ( self._blackboard.currentvehicle ishelicopter() || self._blackboard.currentvehicle.isheli == 1 )
        {
            self._blackboard.var_3592b6bb6169ca01 = 1;
        }
        
        thread enterexitvehiclemotionwarp( asmname, statename, xanim, self._blackboard.chosenvehicleanimpos_sittag, 1, undefined );
    }
    
    self animmode( "nogravity" );
    
    if ( self._blackboard.var_86e1adabb762ade4 == 1 )
    {
        if ( self.secondaryweapon.basename != "none" )
        {
            utility::initweapon( self.secondaryweapon );
            self.riotshieldmodeltag = "tag_weapon_left";
            
            if ( utility::issp() )
            {
                self attach( self.riotshieldmodel, self.riotshieldmodeltag );
                utility::delaythread( 0.5, self aisetriotshieldweapon( self.secondaryweapon ) );
            }
            else
            {
                self aisetriotshieldweapon( self.secondaryweapon );
            }
            
            self.bhasriotshieldattached = 1;
            self._blackboard.var_86e1adabb762ade4 = 0;
        }
    }
    
    self aisetanim( statename, animindex );
    endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ), undefined, undefined, 0 );
    
    if ( endnote == "code_move" )
    {
        thread exitvehiclewatchpath( statename );
        asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ), undefined, undefined, 0 );
    }
    
    asm::asm_fireevent( asmname, "end" );
}

// Namespace vehicle
// Params 0
// Checksum 0xa7c379e0, Offset: 0x3f4d
// Size: 0x27
function endvehiclemotionwarp()
{
    self notify( #"endvehiclemotionwarp" );
    self.asm.targetvalues = undefined;
    self motionwarpcancel();
}

// Namespace vehicle
// Params 3
// Checksum 0x8b1181d9, Offset: 0x3f7c
// Size: 0x493
function exitvehicle_terminate( asmname, statename, params )
{
    self._blackboard.invehicle = 0;
    utility::clear_movement_speed();
    
    if ( isdefined( self.exitvehicle_oldturnrate ) )
    {
        self.turnrate = self.exitvehicle_oldturnrate;
        self.exitvehicle_oldturnrate = undefined;
    }
    
    if ( !isalive( self ) && !self._blackboard.chosenvehicleanimpos_deathragdoll )
    {
        if ( !isdefined( self._blackboard.exitvehicleanimindex ) )
        {
            self._blackboard.exitvehicleanimindex = asm::asm_getanim( asmname, statename );
        }
        
        xanim = asm::asm_getxanim( statename, self._blackboard.exitvehicleanimindex );
        animtime = self aigetanimtime( statename, self._blackboard.exitvehicleanimindex );
        animlength = getanimlength( xanim );
        waittime = getnotetracktimes( xanim, "vehicle_death_wait" )[ 0 ];
        ragdolltime = getnotetracktimes( xanim, "vehicle_death_ragdoll" )[ 0 ];
        crashinghelicopter = isdefined( self._blackboard.currentvehicle ) && !self._blackboard.currentvehicle is_common_vehicle() && self._blackboard.currentvehicle ishelicopter() && self._blackboard.currentvehicle vehicle_is_crashing();
        
        if ( isdefined( waittime ) || isdefined( ragdolltime ) )
        {
            if ( animtime < waittime )
            {
                self._blackboard.invehicle = 1;
            }
            else if ( animtime < ragdolltime )
            {
                if ( crashinghelicopter )
                {
                    self._blackboard.invehicle = 1;
                }
                else
                {
                    self._blackboard.vehicledeathwait = ( ragdolltime - animtime ) * animlength;
                    self._blackboard.var_7d2c11d68f18313b = animtime;
                    self._blackboard.var_13fc8a2fa0ff443f = statename;
                }
            }
            
            if ( !self._blackboard.invehicle )
            {
                self.diedintransition = 1;
            }
        }
        else
        {
            self.diedintransition = 1;
            transitiontime = getnotetracktimes( xanim, "vehicle_cab_transition" )[ 0 ];
            
            if ( isdefined( transitiontime ) )
            {
                if ( animtime < transitiontime )
                {
                    self._blackboard.vehicledeathwait = ( transitiontime - animtime ) * animlength;
                    self._blackboard.var_7d2c11d68f18313b = animtime;
                    self._blackboard.var_13fc8a2fa0ff443f = statename;
                }
            }
        }
    }
    else if ( !isalive( self ) )
    {
        self.diedintransition = 1;
        
        if ( !isdefined( self._blackboard.exitvehicleanimindex ) )
        {
            self._blackboard.exitvehicleanimindex = asm::asm_getanim( asmname, statename );
        }
        
        xanim = asm::asm_getxanim( statename, self._blackboard.exitvehicleanimindex );
        animtime = self aigetanimtime( statename, self._blackboard.exitvehicleanimindex );
        animlength = getanimlength( xanim );
        transitiontime = getnotetracktimes( xanim, "vehicle_cab_transition" )[ 0 ];
        
        if ( isdefined( transitiontime ) )
        {
            if ( animtime < transitiontime )
            {
                self._blackboard.vehicledeathwait = ( transitiontime - animtime ) * animlength;
                self._blackboard.var_7d2c11d68f18313b = animtime;
                self._blackboard.var_13fc8a2fa0ff443f = statename;
            }
        }
    }
    else if ( self._blackboard.linkedtovehicle )
    {
        endvehiclemotionwarp();
        self unlink();
        self._blackboard.linkedtovehicle = 0;
    }
    
    if ( !isdefined( self._blackboard.vehicledeathwait ) )
    {
        endvehiclemotionwarp();
        self._blackboard.exitvehicleanimindex = undefined;
    }
    
    self notify( #"jumpedout" );
    self notify( #"exited_vehicle" );
    self._blackboard.exitingvehicle = 0;
    self.requestopendoor = undefined;
    self.requestopendoorparams = undefined;
    self function_e4850f7996d65f64();
    clearvehiclearchetype();
}

// Namespace vehicle
// Params 3
// Checksum 0x97c6b5c9, Offset: 0x4417
// Size: 0x13d
function function_bf0bdbfaca372818( asmname, statename, params )
{
    self._blackboard.var_d8b9e2ebdf7d6e95 = 0;
    self motionwarpcancel();
    
    if ( isalive( self ) && self._blackboard.currentvehicle )
    {
        vehicle = self._blackboard.currentvehicle;
        seatinfo = vehicle_aianim::anim_pos( vehicle, self._blackboard.var_84de977d30197688 );
        linkoffset = ( 0, 0, 0 );
        linkangles = ( 0, 0, 0 );
        
        if ( isdefined( seatinfo.linkoffset ) )
        {
            linkoffset += seatinfo.linkoffset;
        }
        
        if ( isdefined( seatinfo.linkangle ) )
        {
            linkangles += seatinfo.linkangle;
        }
        
        thread function_d736fba8aae3fa8a();
        self linktomoveoffset( self._blackboard.currentvehicle, seatinfo.sittag, linkoffset, linkangles );
    }
    
    clearvehiclearchetype();
}

// Namespace vehicle
// Params 0
// Checksum 0xbf42e3d1, Offset: 0x455c
// Size: 0x2e
function function_d736fba8aae3fa8a()
{
    self endon( #"death" );
    self.vehicleaimyawspeed = 0;
    waitframe();
    self.vehicleaimyawspeed = undefined;
    self.aimyawspeed = 90;
}

// Namespace vehicle
// Params 3
// Checksum 0x2197c75, Offset: 0x4592
// Size: 0x3f
function vehicletransition_terminate( asmname, statename, params )
{
    if ( !isalive( self ) )
    {
        self motionwarpcancel();
        self.diedintransition = 1;
    }
    
    clearvehiclearchetype();
}

// Namespace vehicle
// Params 0
// Checksum 0xdcdc30e9, Offset: 0x45d9
// Size: 0xac
function watchvehicledeath()
{
    self endon( #"entitydeleted" );
    
    if ( self isragdoll() )
    {
        return;
    }
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        
        while ( true )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            if ( !isdefined( vehicle ) || vehicle vehicle_code::vehicle_iscorpse() )
            {
                if ( self.deleteonvehicledeath )
                {
                    self delete();
                    return;
                }
                
                endvehiclemotionwarp();
                self startragdoll();
                self.skipdeathcleanup = 0;
                self.vehicle_idling = 0;
                death::deathcleanup();
                return;
            }
            
            waitframe();
        }
    }
}

// Namespace vehicle
// Params 3
// Checksum 0x3615a10a, Offset: 0x468d
// Size: 0x99
function playanim_vehicledeathidle( asmname, statename, params )
{
    allowed = getdvarint( @"hash_b65e1595eaad125a", 0 );
    
    if ( !allowed )
    {
        return;
    }
    
    self._blackboard.var_e7389bdf2ba44c93 = 0;
    self._blackboard.var_48381213c6a1f0d9 = 1;
    setvehiclearchetype();
    idleanim = asm::asm_getanim( asmname, statename, params );
    assert( isdefined( idleanim ) );
    self aisetanim( statename, idleanim );
}

// Namespace vehicle
// Params 3
// Checksum 0xf6db4182, Offset: 0x472e
// Size: 0x493
function playanim_vehicledeath( asmname, statename, params )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"entitydeleted" );
    setvehiclearchetype();
    
    if ( !isagent( self ) )
    {
        if ( self.diedintransition || self.damagemod == "MOD_FIRE" || self.damagemod == "MOD_IMPACT" )
        {
            self.ragdoll_immediate_vector = ( 0, 0, 0 );
        }
        
        death::handleburningtodeath();
        self.burningtodeath = 0;
        vehicleisdead = !isdefined( self._blackboard.currentvehicle ) || self._blackboard.currentvehicle vehicle_code::vehicle_iscorpse();
        
        if ( isdefined( self._blackboard.vehicledeathwait ) )
        {
            if ( !vehicleisdead )
            {
                xanimindices = animsetgetallanimindicesforalias( self._blackboard.currentvehicleanimalias, self._blackboard.var_13fc8a2fa0ff443f, self._blackboard.chosenvehicleanimpos_seatalias );
                
                if ( xanimindices.size <= 0 )
                {
                    return;
                }
                
                index = xanimindices[ 0 ];
                xanim = animsetgetanimfromindex( self._blackboard.currentvehicleanimalias, self._blackboard.var_13fc8a2fa0ff443f, index );
                self aisetanim( self._blackboard.var_13fc8a2fa0ff443f, index, 1 );
                self aisetanimtime( xanim, self._blackboard.var_7d2c11d68f18313b );
                self animmode( "noclip" );
                
                if ( self.var_b4ae9860238072a9 && isdefined( self._blackboard.currentvehicle ) )
                {
                    utility::function_1e0fdc2ddb427044( xanim, self._blackboard.currentvehicle, self._blackboard.chosenvehicleanimpos_sittag, ( 0, 0, 0 ), ( 0, 0, 0 ), self._blackboard.var_7d2c11d68f18313b, 1 );
                }
                
                thread watchvehicledeath();
                wait self._blackboard.vehicledeathwait;
                
                if ( !isdefined( self ) )
                {
                    return;
                }
                
                self.ragdoll_immediate_vector = ( 0, 0, 0 );
                self._blackboard.exitvehicleanimindex = undefined;
                self._blackboard.vehicledeathwait = undefined;
            }
            
            endvehiclemotionwarp();
        }
        
        self orientmode( "face current" );
        var_7bcb23be2ae2ded0 = undefined;
        self.noragdoll = 0;
        deathanimdata = death::getdeathanimdata( asmname, statename, params );
        assert( deathanimdata.size == 2 );
        notetracks = getnotetracks( deathanimdata[ 1 ], "start_ragdoll" );
        
        if ( notetracks.size != 0 )
        {
            var_7bcb23be2ae2ded0 = 1;
        }
        
        shouldragdoll = vehicleisdead || self._blackboard.chosenvehicleanimpos_deathragdoll || var_7bcb23be2ae2ded0 || self.diedintransition;
        var_dedfedf8052e4b53 = !vehicleisdead && var_7bcb23be2ae2ded0;
        
        if ( shouldragdoll )
        {
            self.skipdeathcleanup = 0;
            self.vehicle_idling = 0;
            
            if ( self.diedintransition )
            {
                self.nogravityragdoll = 1;
                self.ragdoll_immediate = 1;
                self.deathstate = "vehicle_transition_death";
                self.deathalias = "death";
            }
            else if ( var_dedfedf8052e4b53 )
            {
                self.nogravityragdoll = 1;
                self.ragdolltime = getanimlength( deathanimdata[ 1 ] ) * notetracks[ 0 ][ "time" ];
            }
            else
            {
                self.ragdoll_immediate = 1;
            }
        }
        else
        {
            self animmode( "nogravity" );
            linktovehicle( self.origin, self.angles, self._blackboard.chosenvehicleanimpos_linktoblend, self._blackboard.chosenvehicleanimpos_sittag );
            self.noragdoll = 1;
            thread watchvehicledeath();
        }
        
        if ( function_549988004c8c9b7f() )
        {
            self._blackboard.var_e7389bdf2ba44c93 = 1;
        }
    }
    else
    {
        self motionwarpcancel();
        self orientmode( "face current angles" );
    }
    
    death::playdeathanim( asmname, statename, params );
}

// Namespace vehicle
// Params 3
// Checksum 0xd351543e, Offset: 0x4bc9
// Size: 0x30
function playanim_vehicle( asmname, statename, params )
{
    setvehiclearchetype();
    asm::asm_playanimstate( asmname, statename, params );
}

// Namespace vehicle
// Params 3
// Checksum 0x9fe2a940, Offset: 0x4c01
// Size: 0x3b
function playanim_vehicleturn( asmname, statename, params )
{
    setvehiclearchetype();
    self.useanimgoalweight = 1;
    asm::asm_playanimstate( asmname, statename, params );
}

// Namespace vehicle
// Params 3
// Checksum 0x8bee2319, Offset: 0x4c44
// Size: 0xb8
function playanim_vehiclereload( asmname, statename, params )
{
    self endon( #"reload_terminate" );
    self endon( statename + "_finished" );
    setvehiclearchetype();
    animid = asm::asm_getanim( asmname, statename );
    self aisetanim( statename, animid );
    xanim = asm::asm_getxanim( statename, animid );
    assert( animhasnotetrack( xanim, "<dev string:x2e5>" ) || animhasnotetrack( xanim, "<dev string:x2f1>" ) || animhasnotetrack( xanim, "<dev string:x2fd>" ) );
    asm::asm_playfacialanim( asmname, statename, xanim );
    asm::asm_donotetracks( asmname, statename, undefined, undefined, undefined, 1 );
}

// Namespace vehicle
// Params 3
// Checksum 0xecadd9c2, Offset: 0x4d04
// Size: 0x12d
function playanim_vehiclemelee( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self endon( #"death" );
    setvehiclearchetype();
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_25799974c1f2939b;
    aianims = vehicle_aianim::anim_pos( vehicle, position );
    melee::playmeleeattacksound();
    target = asm_bb::bb_getmeleetarget();
    
    if ( !isdefined( target ) )
    {
        self orientmode( "face current" );
    }
    else if ( target == self.enemy )
    {
        self orientmode( "face enemy" );
    }
    else
    {
        self orientmode( "face point", target.origin );
    }
    
    asm::asm_fireephemeralevent( "melee_attack", "begin" );
    self aisetanim( statename, asm::asm_getanim( asmname, statename ) );
    melee::donotetracks_vsplayer( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    asm::asm_fireevent( asmname, "end" );
}

// Namespace vehicle
// Params 3
// Checksum 0xe7e5d469, Offset: 0x4e39
// Size: 0x30
function vehiclereload_terminate( asmname, statename, params )
{
    namespace_fcb50a41dde46fde::reload_cleanup( asmname, statename, params );
    clearvehiclearchetype();
}

// Namespace vehicle
// Params 4
// Checksum 0xe7c3b137, Offset: 0x4e71
// Size: 0x3f, Type: bool
function isvehicledead( asmname, statename, tostatename, params )
{
    return !isalive( self._blackboard.currentvehicle );
}

// Namespace vehicle
// Params 0
// Checksum 0xcae6fe05, Offset: 0x4eb9
// Size: 0x16, Type: bool
function isnotinvehicle()
{
    return !self._blackboard.invehicle;
}

// Namespace vehicle
// Params 4
// Checksum 0x69e4e4d5, Offset: 0x4ed8
// Size: 0x9b, Type: bool
function function_e57e403f42eac5dd( asmname, statename, tostatename, params )
{
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_25799974c1f2939b;
    aianims = vehicle_aianim::anim_pos( vehicle, position );
    
    if ( !isdefined( aianims ) || !aianims.var_9d16896d44b5fc6e )
    {
        return false;
    }
    
    if ( self function_dac5a0eb14ee3cb9() )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle
// Params 4
// Checksum 0xa620e7e6, Offset: 0x4f7c
// Size: 0x70, Type: bool
function function_f941ef6cc58df9d1( asmname, statename, tostatename, params )
{
    if ( isdefined( self._blackboard.vehicledir ) )
    {
        return ( self._blackboard.vehicledir == 0 || self._blackboard.vehicledir == 8 );
    }
    
    return true;
}

// Namespace vehicle
// Params 3
// Checksum 0xa8803451, Offset: 0x4ff5
// Size: 0x10a
function function_276e4c990bb0f06( asmname, statename, params )
{
    alias = self._blackboard.chosenvehicleanimpos_seatalias;
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_25799974c1f2939b;
    aianims = vehicle_aianim::anim_pos( vehicle, position );
    currentdir = self._blackboard.vehicledir;
    alias += "_" + string( self._blackboard.vehicledir );
    
    if ( currentdir == 2 )
    {
        alias += "_turn_2";
    }
    else if ( currentdir == 4 )
    {
        alias += "_turn_6";
    }
    else
    {
        alias += "_turn_4";
    }
    
    return asm::asm_lookupanimfromalias( "vehicle_idle_combat_shoot_turn", alias );
}

// Namespace vehicle
// Params 3
// Checksum 0xc5f2b0bf, Offset: 0x5108
// Size: 0xb6
function function_690efc1b1c37d021( asmname, statename, params )
{
    self endon( statename + "_finished" );
    setvehiclearchetype();
    self.useanimgoalweight = 1;
    animid = asm::asm_getanim( asmname, statename );
    turnanimstatename = "vehicle_idle_combat_shoot_turn";
    self aisetanim( turnanimstatename, animid );
    asm::asm_playfacialanim( asmname, turnanimstatename, asm::asm_getxanim( turnanimstatename, animid ) );
    endnote = asm::asm_donotetracks( asmname, turnanimstatename, asm::asm_getnotehandler( asmname, turnanimstatename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm::asm_donotetracks( asmname, turnanimstatename, asm::asm_getnotehandler( asmname, turnanimstatename ) );
    }
}

// Namespace vehicle
// Params 4
// Checksum 0xea959c0d, Offset: 0x51c6
// Size: 0x6a
function vehicleshouldstophide( asmname, statename, tostatename, params )
{
    if ( !self issuppressed() && isdefined( self.vehicleusesuppression ) && self.vehicleusesuppression )
    {
        return 1;
    }
    
    return gettime() > self._blackboard.vehiclehidetime;
}

// Namespace vehicle
// Params 4
// Checksum 0xa98e2da1, Offset: 0x5238
// Size: 0xdc, Type: bool
function function_6d48777a5cfcb3ea( asmname, statename, tostatename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = self._blackboard.chosenvehicleanimpos_seatalias;
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_25799974c1f2939b;
        aianims = vehicle_aianim::anim_pos( vehicle, position );
    }
    
    animresult = archetypegetrandomalias( arcname, tostatename, alias );
    return isdefined( animresult );
}

// Namespace vehicle
// Params 4
// Checksum 0x9890567b, Offset: 0x531d
// Size: 0x112
function function_560e2e7c34343c1e( asmname, statename, tostatename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = self._blackboard.chosenvehicleanimpos_seatalias;
    
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        vehicle = self._blackboard.currentvehicle;
        position = self._blackboard.var_25799974c1f2939b;
        aianims = vehicle_aianim::anim_pos( vehicle, position );
        alias += getpainalias( aianims );
    }
    
    animresult = archetypegetrandomalias( arcname, tostatename, alias );
    
    if ( isdefined( animresult ) )
    {
        return 1;
    }
    
    animresult = archetypegetrandomalias( arcname, tostatename, self._blackboard.chosenvehicleanimpos_seatalias );
    return isdefined( animresult );
}

// Namespace vehicle
// Params 4
// Checksum 0x714c7728, Offset: 0x5437
// Size: 0x9b, Type: bool
function function_d90a5a81d86c8ece( asmname, statename, tostatename, params )
{
    arcname = self._blackboard.currentvehicleanimalias;
    alias = self._blackboard.chosenvehicleanimpos_seatalias;
    
    if ( isdefined( self.vehicleseatonleft ) )
    {
        switchsidesalias = function_956dd9c876d9184a();
        alias += switchsidesalias;
    }
    
    animresult = archetypegetrandomalias( arcname, tostatename, alias );
    return isdefined( animresult );
}

// Namespace vehicle
// Params 4
// Checksum 0xdac7fff8, Offset: 0x54db
// Size: 0x48
function vehicleshouldrunexit( asmname, statename, tostatename, params )
{
    runexit = self codemoverequested() && isdefined( self.enemy );
    return runexit;
}

// Namespace vehicle
// Params 2
// Checksum 0x4426ab99, Offset: 0x552c
// Size: 0x276
function function_6659f818b3f6b88f( asmname, statename )
{
    self endon( #"death" );
    vehicle = self._blackboard.currentvehicle;
    seatinfo = vehicle_aianim::anim_pos( vehicle, self._blackboard.var_84de977d30197688 );
    animindex = asm::asm_getanim( asmname, statename );
    xanim = asm::asm_getxanim( statename, animindex );
    self aisetanim( statename, animindex );
    animlength = getanimlength( xanim );
    animstartfrac = 0;
    
    if ( animhasnotetrack( xanim, "motion_warp_begin" ) )
    {
        animstartfrac = getnotetracktimes( xanim, "motion_warp_begin" )[ 0 ];
    }
    
    animendfrac = 1;
    
    if ( animhasnotetrack( xanim, "motion_warp_end" ) )
    {
        animendfrac = getnotetracktimes( xanim, "motion_warp_end" )[ 0 ];
    }
    
    duration = ( animendfrac - animstartfrac ) * animlength;
    wait animstartfrac * animlength;
    tagpos = vehicle gettagorigin( seatinfo.sittag );
    tagangle = vehicle gettagangles( seatinfo.sittag );
    
    if ( isdefined( seatinfo.linkoffset ) )
    {
        tagpos += rotatevector( seatinfo.linkoffset, self._blackboard.currentvehicle.angles );
    }
    
    if ( isdefined( seatinfo.linkangle ) )
    {
        tagangle += seatinfo.linkangle;
    }
    
    tagangle = angleclamp180( tagangle );
    self motionwarp( tagpos, tagangle, int( duration * 1000 ) );
    
    /#
        if ( vehicle_common::function_1b2539f38f15adae( 4 ) )
        {
            movedelta = getmovedelta( xanim, 0, 1 );
            angledelta = getangledelta3d( xanim, 0, 1 )[ 1 ];
            startangle = ( tagangle[ 0 ], tagangle[ 1 ] - angledelta, tagangle[ 2 ] );
            startangle = angleclamp180( startangle );
            startpos = tagpos - rotatevector( movedelta, startangle );
            sphere( startpos, 3, ( 0, 1, 1 ), 0, 300 );
            sphere( tagpos, 3, ( 1, 0, 1 ), 0, 300 );
        }
    #/
}

// Namespace vehicle
// Params 3
// Checksum 0x76b680f4, Offset: 0x57aa
// Size: 0x42
function function_fc8cfcf406c522b8( asmname, statename, params )
{
    setvehiclearchetype();
    thread function_6659f818b3f6b88f( asmname, statename );
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
}

// Namespace vehicle
// Params 1
// Checksum 0xb77634aa, Offset: 0x57f4
// Size: 0x21
function function_6de8e03a38f4276c( note )
{
    if ( note == "change_seat_done" )
    {
        vehicle_common::function_134a8f5d5a23d3cb();
        return 1;
    }
}

// Namespace vehicle
// Params 4
// Checksum 0x2efb57db, Offset: 0x581e
// Size: 0x49, Type: bool
function vehiclegetoutcodemove( asmname, statename, tostatename, params )
{
    if ( asm::asm_eventfired( asmname, "code_move" ) && isdefined( self.pathgoalpos ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle
// Params 0
// Checksum 0xa4eadd84, Offset: 0x5870
// Size: 0x19
function function_43dfba9693d4b9a0()
{
    if ( isdefined( self.collision_data ) )
    {
        self.collision_data = undefined;
    }
}

/#

    // Namespace vehicle
    // Params 0
    // Checksum 0xec0ebc4b, Offset: 0x5891
    // Size: 0x1a, Type: dev
    function function_17f9547ff5c748a9()
    {
        wait 0.5;
        setdvar( @"ai_vehicletriggerimpulse", 0 );
    }

#/

// Namespace vehicle
// Params 4
// Checksum 0xfb70a57, Offset: 0x58b3
// Size: 0x62, Type: bool
function function_93dc81e71aa72abf( asmname, statename, tostatename, params )
{
    if ( !self.canreimpulse )
    {
        return false;
    }
    
    if ( !isdefined( self.collision_data ) || self.collision_data.impulse < 120 )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle
// Params 4
// Checksum 0x801606e2, Offset: 0x591e
// Size: 0x1de
function function_135ffa542fd3afd9( asmname, statename, tostatename, params )
{
    if ( !( isdefined( self._blackboard.currentvehicle ) && isdefined( self._blackboard.var_25799974c1f2939b ) ) )
    {
        return 0;
    }
    
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_25799974c1f2939b;
    aianims = vehicle_aianim::anim_pos( vehicle, position );
    
    /#
        setdvarifuninitialized( @"ai_vehicletriggerimpulse", 0 );
        triggerimpulse = getdvarint( @"ai_vehicletriggerimpulse", 0 );
        
        if ( triggerimpulse )
        {
            self.collision_data = spawnstruct();
            self.collision_data.position = self.origin;
            self.collision_data.normal = ( 1, 0, 0 );
            self.collision_data.impulse = 0.5;
            thread function_17f9547ff5c748a9();
        }
    #/
    
    result = 1;
    
    if ( !isdefined( self.collision_data ) || !aianims.var_e65cfecaf7ed4bff )
    {
        result = 0;
    }
    else if ( self.collision_data.impulse < 120 )
    {
        result = 0;
    }
    else
    {
        seatalias = self._blackboard.chosenvehicleanimpos_seatalias;
        alias = seatalias + "_8_2";
        
        if ( !asm::asm_hasalias( tostatename, alias ) )
        {
            result = 0;
        }
    }
    
    if ( !result )
    {
        function_43dfba9693d4b9a0();
    }
    
    return result;
}

/#

    // Namespace vehicle
    // Params 6
    // Checksum 0xde0bc98c, Offset: 0x5b05
    // Size: 0x8a, Type: dev
    function function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, message )
    {
        println( "<dev string:x309>" + asmname + "<dev string:xe0>" + statename + "<dev string:x357>" + arc + "<dev string:x365>" );
        level.var_1ca285a952c278f7 = 0;
        println( "<dev string:x368>" + alias + "<dev string:x373>" + xanim + "<dev string:x373>" + message );
    }

    // Namespace vehicle
    // Params 3
    // Checksum 0x43a3dd08, Offset: 0x5b97
    // Size: 0x3a8, Type: dev
    function function_8a74b020241a7a1( asmname, statename, arc )
    {
        if ( !archetypeassetloaded( arc ) )
        {
            return;
        }
        
        aliases = archetypegetaliases( arc, statename );
        
        if ( !isdefined( aliases ) )
        {
            return;
        }
        
        foreach ( alias in aliases )
        {
            organims = archetypegetalias( arc, statename, alias );
            
            if ( isarray( organims.anims ) )
            {
                anims = organims.anims;
            }
            else
            {
                anims = [ organims.anims ];
            }
            
            foreach ( xanim in anims )
            {
                waittime = getnotetracktimes( xanim, "<dev string:x2bc>" )[ 0 ];
                ragdolltime = getnotetracktimes( xanim, "<dev string:x2cf>" )[ 0 ];
                var_92cec47c35decf93 = getnotetracktimes( xanim, "<dev string:x1f3>" );
                motionwarpendtimes = getnotetracktimes( xanim, "<dev string:x250>" );
                codemovetimes = getnotetracktimes( xanim, "<dev string:x375>" );
                finishtimes = getnotetracktimes( xanim, "<dev string:x37f>" );
                
                if ( var_92cec47c35decf93.size > 1 )
                {
                    function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, "<dev string:x386>" );
                }
                
                if ( motionwarpendtimes.size > 1 )
                {
                    function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, "<dev string:x3bd>" );
                }
                
                if ( var_92cec47c35decf93.size > 0 && isdefined( motionwarpendtimes ) && motionwarpendtimes.size > 0 )
                {
                    if ( var_92cec47c35decf93[ 0 ] >= motionwarpendtimes[ 0 ] )
                    {
                        function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, "<dev string:x3f2>" );
                    }
                    
                    if ( isdefined( finishtimes ) )
                    {
                        if ( finishtimes.size > 0 && var_92cec47c35decf93[ 0 ] > finishtimes[ 0 ] )
                        {
                            function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, "<dev string:x428>" );
                        }
                        
                        if ( finishtimes.size > 0 && motionwarpendtimes[ 0 ] > finishtimes[ 0 ] )
                        {
                            function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, "<dev string:x455>" );
                        }
                    }
                    
                    if ( isdefined( codemovetimes ) )
                    {
                        if ( codemovetimes.size > 0 && var_92cec47c35decf93[ 0 ] > codemovetimes[ 0 ] )
                        {
                            function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, "<dev string:x497>" );
                        }
                        
                        if ( codemovetimes.size > 0 && motionwarpendtimes[ 0 ] > codemovetimes[ 0 ] )
                        {
                            function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, "<dev string:x4c7>" );
                        }
                    }
                    
                    totalmovedelta = getmovedelta( xanim, 0, 1 );
                    motionwarpmovedelta = getmovedelta( xanim, var_92cec47c35decf93[ 0 ], motionwarpendtimes[ 0 ] );
                    
                    if ( abs( motionwarpmovedelta[ 2 ] ) < abs( totalmovedelta[ 2 ] ) * 0.5 )
                    {
                        function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, "<dev string:x4f5>" );
                    }
                }
                
                if ( isdefined( waittime ) && !isdefined( ragdolltime ) )
                {
                    function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, "<dev string:x535>" );
                }
                
                if ( !isdefined( waittime ) && isdefined( ragdolltime ) )
                {
                    function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, "<dev string:x577>" );
                }
                
                if ( waittime >= ragdolltime )
                {
                    function_1be2b9ca6d03476c( asmname, statename, arc, alias, xanim, "<dev string:x5b9>" );
                }
            }
        }
    }

    // Namespace vehicle
    // Params 3
    // Checksum 0xc33888b5, Offset: 0x5f47
    // Size: 0x15d, Type: dev
    function function_478c7e5d81944d43( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        archetypes = [ "<dev string:x5f2>", "<dev string:x5f6>", "<dev string:x5fe>", "<dev string:x604>", "<dev string:x611>", "<dev string:x617>", "<dev string:x621>", "<dev string:x632>", "<dev string:x639>", "<dev string:x643>", "<dev string:x653>", "<dev string:x65b>", "<dev string:x661>", "<dev string:x671>", "<dev string:x680>", "<dev string:x686>", "<dev string:x68d>", "<dev string:x693>", "<dev string:x69a>", "<dev string:x6a0>" ];
        
        foreach ( arc in archetypes )
        {
            function_8a74b020241a7a1( asmname, statename, arc );
        }
    }

#/
