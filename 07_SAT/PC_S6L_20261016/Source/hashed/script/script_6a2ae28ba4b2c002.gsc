// script_6a2ae28ba4b2c002  (hash_6a2ae28ba4b2c002.gscc) (size: 9387 Bytes / 0x24ab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34fcb69f (888977055)
// size ...... 9387 (0x24ab)
// includes .. 9   (offset: 0x2387)
// strings ... 17  (offset: 0x23cf)
// dev strs .. 1   (offset: 0x249f)
// exports ... 23  (offset: 0x16c3)
// cseg ...... 0x155 + 0x156e (0x16c3)
// imports ... 78  (offset: 0x1a5b)
// animtree1 . 0   (offset: 0x24ab)
// animtree2 . 0   (offset: 0x24ab)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\common\utility\teams;
#using scripts\mp\weapons;
#using scripts\vehicle\vehicle_common;

#namespace namespace_112e5e9b0fbdf8a;

// Namespace namespace_112e5e9b0fbdf8a
// Params 0
// Checksum 0x746e48, Offset: 0x173
// Size: 0x47
function function_7d86b1d8eb835027()
{
    data = spawnstruct();
    data.spawnheli = &function_52e43f836440c67f;
    data.var_b1b3897987cfbae3 = &function_4d763cfe5c7cb1ae;
    data.flyaway = &function_a5f1508c99a6ae40;
    return data;
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 1
// Checksum 0xcf8cf723, Offset: 0x1c3
// Size: 0x9c
function function_52e43f836440c67f( guardvehicle )
{
    heli = function_972372eb03a5fbd8();
    heli thread function_30aa5843e39c3893( guardvehicle );
    weapons::function_ef0cb557b1a93af9( heli );
    heli.var_d50863b2236f2052 = &function_28ed8b55c4857151;
    heli.flaresreservecount = 1;
    heli.flareslive = [];
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        heli thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &function_1e7a2f9bf41a3894 );
    }
    
    return heli;
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 0, eflags: 0x4
// Checksum 0x749bdacf, Offset: 0x268
// Size: 0x12e
function private function_972372eb03a5fbd8()
{
    node = function_47c86977a18df38b( level.var_209035fc1e63a988, ( self.vehicle.origin + self.end.origin ) * 0.5 );
    spawnnode = spawnstruct();
    spawnnode.origin = node.origin;
    spawnnode.angles = node.angles;
    spawnnode.classname_mp = "script_vehicle_heli_medium";
    spawnnode.vehicletype = "lbravo_infil_cp";
    heli = vehicle::spawn( "little_bird", spawnnode );
    heli.var_4401c1e14c1111fe = 1;
    heli.gunners = [];
    heli.gunners[ heli.gunners.size ] = function_32be208fa62a1a01( heli, 3 );
    heli.gunners[ heli.gunners.size ] = function_32be208fa62a1a01( heli, 4 );
    heli.exitnode = node;
    return heli;
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 1
// Checksum 0xcfd2da3a, Offset: 0x39f
// Size: 0x34
function function_3ee112121ff6c288( heli )
{
    heli waittill( #"death" );
    
    if ( isalive( self ) )
    {
        self.nocorpse = 1;
        ai_mp_controller::killoffagent();
    }
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 2, eflags: 0x4
// Checksum 0xd5f1fcb9, Offset: 0x3db
// Size: 0x152
function private function_32be208fa62a1a01( heli, startingpos )
{
    origin = level.var_cbe4d28d28ae892a ?? heli.origin;
    aitype = ai_mp_controller::function_f7aef6871cda828( "ar" );
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, origin, heli.angles, "absolute", "mission", "vehicleDriveHeliDriver", undefined, undefined, undefined, self.node.script_poi, 1, undefined, 0 );
    
    if ( !isdefined( agent ) )
    {
        println( "<dev string:x24>" );
        return;
    }
    
    availablepositionsstruct = heli vehicle_aianim::get_availablepositions();
    agent.script_startingposition = startingpos;
    pos = heli vehicle_aianim::choose_vehicle_position( agent, availablepositionsstruct, 0 );
    agent vehicle_common::entervehicle( heli, 1, pos, vehicle_aianim::anim_pos( heli, pos.vehicle_position ) );
    agent.vehicle_position = pos.vehicle_position;
    agent.goalradius = 10000;
    agent.maxsightdistsqrd = squared( 10000 );
    agent function_2ef9eb3349906d00( 10000 );
    agent.ignoreall = 1;
    return agent;
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 1
// Checksum 0xdfdc0c00, Offset: 0x536
// Size: 0x11c
function function_30aa5843e39c3893( vehicle )
{
    self endon( #"death" );
    self endon( #"flyaway" );
    self setmaxpitchroll( 20, 20 );
    self setneargoalnotifydist( 150 );
    idletick = 0;
    updaterate = 0.1;
    self.var_2e07a8d03a2bbf04 = 0;
    
    while ( true )
    {
        wait updaterate;
        
        if ( !isdefined( vehicle ) )
        {
            thread function_a5f1508c99a6ae40();
            return;
        }
        
        if ( self.inbombingrun )
        {
            continue;
        }
        
        veh_speed = vehicle vehicle_getspeed();
        idletick = 0;
        currdist = distance2dsquared( self.origin, vehicle.var_66abea5e2c913ea4 );
        self vehicle_setspeed( 150, 30, 30 );
        
        if ( currdist > 16777216 )
        {
            thread function_dd9fe9f8ca1400b4( vehicle.var_66abea5e2c913ea4, 1, vehicle );
        }
        else if ( currdist > 1048576 )
        {
            thread function_dd9fe9f8ca1400b4( vehicle.var_66abea5e2c913ea4, 1, vehicle );
        }
        
        if ( function_2935ab622159fd55() )
        {
            thread function_a5f1508c99a6ae40();
            return;
        }
    }
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 2
// Checksum 0x624e981b, Offset: 0x65a
// Size: 0x2a6
function function_322379979185eda( vehicle, heli )
{
    heli endon( #"stop_throwing" );
    heli endon( #"death" );
    heli endon( #"flyaway" );
    heli.inbombingrun = 0;
    segmentstart = ( 0, 0, 0 );
    segmentend = ( 0, 0, 0 );
    var_9642042567bfc308 = 0;
    numbombs = 0;
    var_26e8fde45a4c67f9 = heli.origin;
    
    while ( true )
    {
        if ( !isdefined( vehicle ) )
        {
            return;
        }
        
        if ( heli function_2935ab622159fd55() )
        {
            heli thread function_a5f1508c99a6ae40();
            return;
        }
        
        diff = heli.origin - var_26e8fde45a4c67f9;
        var_26e8fde45a4c67f9 = heli.origin;
        currdist = distance2dsquared( heli.origin, vehicle.var_66abea5e2c913ea4 );
        
        if ( !heli.inbombingrun )
        {
            if ( currdist < 1048576 )
            {
                heli vehicle_setspeed( 125, 20, 20 );
                speed = vehicle vehicle_getspeed();
                segmentstart = vehicle.var_66abea5e2c913ea4 - 1000 * vectornormalize( vehicle.var_66abea5e2c913ea4 - heli.origin );
                segmentend = vehicle.var_66abea5e2c913ea4 + 1000 * vectornormalize( vehicle.var_66abea5e2c913ea4 - heli.origin );
                segmentstart = ( segmentstart[ 0 ], segmentstart[ 1 ], heli.origin[ 2 ] );
                segmentend = ( segmentend[ 0 ], segmentend[ 1 ], heli.origin[ 2 ] );
                startdist = distance2dsquared( heli.origin, segmentstart );
                
                if ( startdist < 122500 )
                {
                    heli.inbombingrun = 1;
                    var_9642042567bfc308 = 0;
                    numbombs = 0;
                }
                else
                {
                    heli thread function_dd9fe9f8ca1400b4( segmentstart, 0, vehicle );
                }
            }
        }
        
        if ( heli.inbombingrun )
        {
            heli vehicle_setspeed( 120, 20, 20 );
            heli thread function_dd9fe9f8ca1400b4( segmentend, 0, vehicle );
            
            if ( currdist < squared( 2500 ) )
            {
                var_9642042567bfc308 += length( diff );
                
                if ( var_9642042567bfc308 > 500 )
                {
                    var_9642042567bfc308 -= 500;
                    numbombs++;
                    thread function_6cd78f666b67ef18( heli, vehicle );
                }
            }
            else
            {
                heli.inbombingrun = 0;
            }
            
            if ( numbombs > 8 )
            {
                heli.inbombingrun = 0;
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 0
// Checksum 0x9fbd948e, Offset: 0x908
// Size: 0x15b
function function_4d763cfe5c7cb1ae()
{
    self.vehicle endon( #"death" );
    self endon( #"task_ended" );
    oldpositions = [ self.vehicle.origin, self.vehicle.origin, self.vehicle.origin, self.vehicle.origin ];
    maxindex = 3;
    currindex = 0;
    
    while ( true )
    {
        speed = self.vehicle vehicle_getspeed();
        var_610e761bc99e7e93 = 17.6;
        forward = vectornormalize( self.vehicle.origin - oldpositions[ currindex ] );
        oldpositions[ currindex ] = self.vehicle.origin;
        currindex = currindex < maxindex - 1 ? currindex + 1 : 0;
        self.vehicle.var_66abea5e2c913ea4 = self.vehicle.origin + forward * speed * var_610e761bc99e7e93 * 6;
        wait 0.5;
    }
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 2, eflags: 0x4
// Checksum 0x141959b4, Offset: 0xa6b
// Size: 0xf1
function private function_6cd78f666b67ef18( heli, vehicle )
{
    if ( !heli.var_ed6412206fccc82e )
    {
        playersonteam = teams::getteamdata( vehicle.var_2e2ed02cfb0c625d, "players" );
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"vehicledrive_helibomb", playersonteam );
        heli.var_ed6412206fccc82e = 1;
    }
    
    if ( heli function_2935ab622159fd55() )
    {
        heli thread function_a5f1508c99a6ae40();
        return;
    }
    
    gunner = function_47c86977a18df38b( heli.gunners, vehicle.origin );
    start = gunner.origin + ( 0, 0, 40 ) + anglestoforward( gunner.angles ) * 10;
    thread function_40e100ba176bdd6a( start, heli );
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 2
// Checksum 0xb9c66457, Offset: 0xb64
// Size: 0xb6
function function_40e100ba176bdd6a( origin, heli )
{
    level notify( #"dropping_bombs" );
    c4 = magicgrenademanual( "c4_dmz_heli", origin, ( 0, 0, -100 ) );
    c4 setotherent( heli );
    c4.angles = ( 0, randomfloat( 360 ), 0 ) + ( -90, 180, 0 );
    c4 setscriptablepartstate( "effects", "neutral" );
    c4 thread function_c0e630fefa1b7d7b();
    c4 utility::waittill_any_timeout( 8, "detonate" );
    c4 setscriptablepartstate( "effects", "explode" );
    wait 3;
    c4 delete();
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 1
// Checksum 0xb1de8065, Offset: 0xc22
// Size: 0x12e
function function_c0e630fefa1b7d7b( vehicle )
{
    self endon( #"entitydeleted" );
    playerdist = squared( 200 );
    vehicledist = squared( 275 );
    
    while ( true )
    {
        shoulddetonate = 0;
        
        foreach ( player in level.players )
        {
            if ( !player vehicle::is_in_vehicle() )
            {
                if ( distancesquared( self.origin, player.origin ) < playerdist )
                {
                    shoulddetonate = 1;
                }
                
                continue;
            }
            
            if ( distancesquared( self.origin, player.vehicle.origin ) < vehicledist )
            {
                shoulddetonate = 1;
            }
        }
        
        if ( shoulddetonate )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"detonate" );
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 1
// Checksum 0x167563a2, Offset: 0xd58
// Size: 0x5c
function function_28ed8b55c4857151( damage_data )
{
    if ( isdefined( damage_data.meansofdeath ) )
    {
        if ( isexplosivedamagemod( damage_data.meansofdeath ) )
        {
            vehicle::death( self, damage_data );
        }
        else if ( utility::isbulletdamage( damage_data.meansofdeath ) )
        {
            return 5;
        }
    }
    
    return damage_data.damage;
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 4
// Checksum 0xeade502e, Offset: 0xdbd
// Size: 0x116
function function_1e7a2f9bf41a3894( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            missiletarget.flaresreservecount--;
            missiletarget thread function_694cc677dd17f97f( fxtagoverride );
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            self.var_458d8d6ca334fa52 = 1;
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            level notify( #"flares", player );
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 1
// Checksum 0x10c705d2, Offset: 0xedb
// Size: 0x4b
function function_694cc677dd17f97f( fxtagoverride )
{
    flarestag = "tag_origin";
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    playsoundatpos( self gettagorigin( flarestag ), "ks_ac130_flares" );
    playfxontag( utility::getfx( "gunship_flares" ), self, flarestag );
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 0
// Checksum 0x63017d02, Offset: 0xf2e
// Size: 0xfc
function function_a5f1508c99a6ae40()
{
    self endon( #"death" );
    
    if ( self.flyingaway )
    {
        return;
    }
    
    self notify( #"flyaway" );
    self.flyingaway = 1;
    self setvehgoalpos( self.exitnode.origin, 1 );
    self vehicle_setspeed( 80, 25, 25 );
    self waittill( #"near_goal" );
    vehicle_code::vehicle_deathcleanup();
    
    foreach ( gunner in self.gunners )
    {
        gunner.nocorpse = 1;
        gunner ai_mp_controller::killoffagent();
    }
    
    thread vehicle::death( self );
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 0, eflags: 0x4
// Checksum 0xabaa093c, Offset: 0x1032
// Size: 0x91, Type: bool
function private function_2935ab622159fd55()
{
    alive = 0;
    
    foreach ( gunner in self.gunners )
    {
        if ( !isalive( gunner ) )
        {
            continue;
        }
        
        alive++;
    }
    
    return alive == 0;
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 3, eflags: 0x4
// Checksum 0xd41c620f, Offset: 0x10cc
// Size: 0x127
function private function_e1b22914d59fb6d0( point, numpositions, pathradius )
{
    var_f2c7f3bde90b912c = 360 / numpositions;
    positions = [];
    fwd = ( 1, 0, 0 );
    i = 0;
    
    while ( i < 360 )
    {
        altforward = fwd * pathradius;
        rotatedfwd = ( cos( i ) * altforward[ 0 ] - sin( i ) * altforward[ 1 ], sin( i ) * altforward[ 0 ] + cos( i ) * altforward[ 1 ], altforward[ 2 ] );
        pos = point + rotatedfwd;
        position = spawnstruct();
        position.origin = pos;
        z = position function_c506d29e15f48af8();
        position.origin = ( position.origin[ 0 ], position.origin[ 1 ], z );
        positions[ positions.size ] = position;
        i += var_f2c7f3bde90b912c;
    }
    
    return positions;
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 0, eflags: 0x4
// Checksum 0x4eb45ec7, Offset: 0x11fc
// Size: 0x35
function private function_c506d29e15f48af8()
{
    heliheight = getgroundposition( self.origin, 128, 10000, 2000 ) + ( 0, 0, 800 );
    return heliheight[ 2 ];
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 3, eflags: 0x4
// Checksum 0x761a2fb0, Offset: 0x123a
// Size: 0x102
function private function_dd9fe9f8ca1400b4( goal_pos, stopatgoal, vehicle )
{
    self endon( #"death" );
    self endon( #"flyaway" );
    self endon( #"circle" );
    self notify( #"hash_4fb7549081cc9f4c" );
    self endon( #"hash_4fb7549081cc9f4c" );
    path = function_f40b7aa48209d200( goal_pos, vehicle );
    
    foreach ( index, node in path )
    {
        if ( index == path.size - 1 )
        {
            self setvehgoalpos( node, stopatgoal );
        }
        else
        {
            self setvehgoalpos( node );
        }
        
        self waittill( #"near_goal" );
    }
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 2, eflags: 0x4
// Checksum 0x3e63e634, Offset: 0x1344
// Size: 0x245
function private function_f40b7aa48209d200( goal_pos, vehicle )
{
    path = [];
    dir = vectortoangles( goal_pos - self.origin );
    fwd = anglestoforward( dir );
    dist = length( self.origin - goal_pos );
    
    if ( dist > 250 )
    {
        steps = dist / 250;
        
        for ( i = 1; i < steps ; i++ )
        {
            if ( i > 5 )
            {
                break;
            }
            
            fwddist = i * 250;
            newpos = self.origin + fwd * fwddist;
            placedstruct = function_f10eacb2599dbcb( newpos );
            
            if ( isdefined( placedstruct ) )
            {
                path[ path.size ] = placedstruct.origin;
                continue;
            }
            
            ignored_ents = self.gunners;
            ignored_ents[ ignored_ents.size ] = self;
            trace = trace::ray_trace( newpos + ( 0, 0, 1000 ), newpos + ( 0, 0, -10000 ), ignored_ents, undefined, undefined, 1, 1 );
            pos = getgroundposition( trace[ "position" ] + ( 0, 0, 800 ), 32, 2000, 100 );
            path[ path.size ] = pos + ( 0, 0, 800 );
            
            if ( isalive( vehicle ) )
            {
                if ( path[ path.size - 1 ][ 2 ] < vehicle.origin[ 2 ] )
                {
                    path[ path.size - 1 ] = ( path[ path.size - 1 ][ 0 ], path[ path.size - 1 ][ 1 ], vehicle.origin[ 2 ] ) + ( 0, 0, 800 );
                }
            }
        }
    }
    
    if ( isalive( vehicle ) )
    {
        if ( goal_pos[ 2 ] < vehicle.origin[ 2 ] )
        {
            path[ path.size ] = ( goal_pos[ 0 ], goal_pos[ 1 ], vehicle.origin[ 2 ] ) + ( 0, 0, 800 );
        }
    }
    else
    {
        path[ path.size ] = goal_pos;
    }
    
    path = function_1d15306bcf7166c2( path );
    return path;
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 1
// Checksum 0x9a78d27f, Offset: 0x1592
// Size: 0xc3
function function_1d15306bcf7166c2( path )
{
    thresh = 100;
    
    foreach ( index, node in path )
    {
        if ( index == path.size - 1 )
        {
            break;
        }
        
        diff = path[ index + 1 ][ 2 ] - node[ 2 ];
        
        if ( diff > thresh )
        {
            node += ( 0, 0, node[ 2 ] + diff / 2 );
        }
    }
    
    return path;
}

// Namespace namespace_112e5e9b0fbdf8a
// Params 1
// Checksum 0x5e08071d, Offset: 0x165e
// Size: 0x64
function function_f10eacb2599dbcb( pos )
{
    if ( !isdefined( level.var_ac7279cacc94501 ) )
    {
        return;
    }
    
    closest = function_47c86977a18df38b( level.var_ac7279cacc94501, pos );
    
    if ( isdefined( closest ) && distancesquared( closest.origin, pos ) <= squared( closest.radius ) )
    {
        return closest;
    }
}

