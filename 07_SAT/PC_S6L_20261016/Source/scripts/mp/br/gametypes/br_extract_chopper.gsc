// scripts\mp\br\gametypes\br_extract_chopper.gsc  (hash_131951e8903647df.gscc) (size: 10260 Bytes / 0x2814 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7515e559 (1964369241)
// size ...... 10260 (0x2814)
// includes .. 12  (offset: 0x2604)
// strings ... 29  (offset: 0x2664)
// dev strs .. 1   (offset: 0x2808)
// exports ... 23  (offset: 0x1940)
// cseg ...... 0x23a + 0x1706 (0x1940)
// imports ... 77  (offset: 0x1cd8)
// animtree1 . 0   (offset: 0x2814)
// animtree2 . 0   (offset: 0x2814)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\flares;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\hostmigration;

#namespace br_extract_chopper;

// Namespace br_extract_chopper
// Params 4
// Checksum 0x4926fa97, Offset: 0x258
// Size: 0x206
function spawnextractchopper( zone, positionoverride, onhelikilled, helitimeoffset )
{
    extractpos = zone.origin;
    coord = extractpos;
    direction = ( 0, 0, 0 );
    planehalfdistance = 24000;
    heightent = getent( "airstrikeheight", #targetname );
    planeflyheight = heightent.origin[ 2 ];
    streakname = "jackal";
    entervec = level.mapcenter - zone.origin;
    entervec = ( entervec[ 0 ], entervec[ 1 ], 0 );
    enterdir = vectornormalize( entervec );
    enterstartpoint = enterdir * -10000 + ( 0, 0, 1 ) * planeflyheight;
    exitpoint = ( extractpos[ 0 ], extractpos[ 1 ], planeflyheight );
    streakinfo = fakestreakinfo();
    newlz = spawn( "trigger_radius", extractpos, 0, 90, 128 );
    newlz.angles = ( 0, 0, 0 );
    newlz.team = self.team;
    newlz.ownerteam = self.team;
    newlz.visibleteam = "any";
    newlz.offset3d = ( 0, 0, 16 );
    newlz.location = extractpos;
    bird = beginlittlebird( 0, enterstartpoint, exitpoint, streakinfo, newlz, positionoverride, self.team, helitimeoffset );
    bird.onhelikilled = onhelikilled;
    bird.zone = zone;
    return bird;
}

// Namespace br_extract_chopper
// Params 0
// Checksum 0xd2a9b0b, Offset: 0x467
// Size: 0xd3
function fakestreakinfo()
{
    streakinfo = spawnstruct();
    streakinfo.available = 1;
    streakinfo.firednotify = "offhand_fired";
    streakinfo.isgimme = 1;
    streakinfo.kid = 5;
    streakinfo.lifeid = 0;
    streakinfo.madeavailabletime = gettime();
    streakinfo.scriptuseagetype = "gesture_script_weapon";
    streakinfo.streakname = "jackal";
    streakinfo.streaksetupinfo = undefined;
    streakinfo.variantid = -1;
    streakinfo.weaponname = "ks_gesture_generic_mp";
    streakinfo.objweapon = makeweapon( streakinfo.weaponname );
    return streakinfo;
}

// Namespace br_extract_chopper
// Params 8
// Checksum 0x431911d9, Offset: 0x543
// Size: 0x242
function beginlittlebird( lifeid, startpoint, endpoint, streakinfo, lz, positionoverride, team, helitimeoffset )
{
    marker = undefined;
    
    if ( isdefined( lz ) )
    {
        marker = lz.marker;
        
        if ( !isdefined( marker ) )
        {
            marker = spawnstruct();
            
            if ( isdefined( positionoverride ) )
            {
                marker.location = positionoverride;
            }
            else if ( isdefined( lz.location ) )
            {
                marker.location = lz.location;
            }
            else
            {
                marker.location = lz.trigger.origin;
            }
            
            marker.angles = ( 0, 0, 0 );
            marker.string = "equip_deploy_succeeded";
            marker.visual = spawn( "script_model", marker.location );
            marker.visual setmodel( "ks_marker_mp" );
            marker.visual setotherent( self );
        }
        
        if ( !isdefined( marker.location ) )
        {
            self notify( #"cancel_littlebird" );
            return 0;
        }
    }
    
    self notify( #"hash_4f1ee4a2dcc272f4" );
    heightent = getent( "airstrikeheight", #targetname );
    
    if ( isdefined( heightent ) )
    {
        trueheight = heightent.origin[ 2 ] + 500;
    }
    else
    {
        trueheight = 1300;
    }
    
    if ( isdefined( marker ) && isdefined( marker.location ) )
    {
        endpoint = marker.location;
    }
    
    endpoint *= ( 1, 1, 0 );
    pathgoal = endpoint + ( 0, 0, trueheight );
    bird = spawnlittlebird( lifeid, self, startpoint, pathgoal, streakinfo, lz );
    bird.lz = lz;
    bird.pathgoal = pathgoal;
    thread monitorarriveoverdestination( bird, marker, team, helitimeoffset );
    return bird;
}

// Namespace br_extract_chopper
// Params 6
// Checksum 0x2b25d060, Offset: 0x78e
// Size: 0x2f9
function spawnlittlebird( lifeid, owner, pathstart, pathgoal, streakinfo, lz )
{
    forward = vectortoangles( pathgoal - pathstart );
    
    if ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" )
    {
        numflares = 99;
        maxhealth = 10000;
    }
    else if ( game_utility::getgametype() == "btm" )
    {
        numflares = 99;
        maxhealth = 99999;
    }
    else
    {
        numflares = 1;
        maxhealth = 10000;
    }
    
    jackalmodel = "veh9_mil_air_heli_medium";
    jackal = spawnhelicopter( owner, pathstart, forward, "lbravo_infil_mp", jackalmodel );
    
    if ( !isdefined( jackal ) )
    {
        return;
    }
    
    if ( isdefined( lz ) )
    {
        jackal.lz = lz;
    }
    
    jackal thread handledestroydamage();
    jackal.damagecallback = &callback_vehicledamage;
    jackal.speed = 50;
    jackal.accel = 125;
    jackal.health = maxhealth;
    jackal.maxhealth = jackal.health;
    jackal.team = owner.team;
    jackal.owner = owner;
    jackal setcandamage( 1 );
    jackal.defendloc = pathgoal;
    jackal.lifeid = lifeid;
    jackal.jackal = 1;
    jackal.streakinfo = streakinfo;
    jackal.streakname = streakinfo.streakname;
    jackal.streakinfo = streakinfo;
    jackal.flaresreservecount = numflares;
    jackal killstreak::addtoactivekillstreaklist( streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100 );
    jackal setmaxpitchroll( 0, 90 );
    jackal vehicle_setspeed( jackal.speed, jackal.accel );
    jackal sethoverparams( 50, 100, 50 );
    jackal setturningability( 0.05 );
    jackal setyawspeed( 45, 25, 25, 0.5 );
    jackal setotherent( owner );
    jackal.useobj = spawn( "script_model", jackal gettagorigin( "tag_origin" ) );
    jackal.useobj linkto( jackal, "tag_origin" );
    
    if ( !isdefined( level.jackals ) )
    {
        level.jackals = [];
    }
    
    level.jackals[ level.jackals.size ] = jackal;
    level.jackals = function_5713d46873b29625( level.jackals );
    jackal thread flares::flares_handleincomingstinger( undefined, undefined );
    jackal thread littlebirddestroyed();
    jackal thread delay_jackal_arrive_sfx();
    return jackal;
}

// Namespace br_extract_chopper
// Params 0
// Checksum 0x2d5e4632, Offset: 0xa90
// Size: 0x17
function delay_jackal_arrive_sfx()
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithhostmigrationpause( 6 );
}

// Namespace br_extract_chopper
// Params 2
// Checksum 0xb9272123, Offset: 0xaaf
// Size: 0x32
function delayjackalloopsfx( delaytime, alias )
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithhostmigrationpause( delaytime );
    self playloopsound( alias );
}

// Namespace br_extract_chopper
// Params 0
// Checksum 0xd193ebb7, Offset: 0xae9
// Size: 0xbf
function littlebirddestroyed()
{
    self endon( #"jackal_gone" );
    owner = self.owner;
    self waittill( #"death" );
    
    if ( isdefined( self.turrettarget ) && isdefined( self.targetoutline ) )
    {
        outline::outlinedisable( self.targetoutline, self.turrettarget );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.largeprojectiledamage ) )
    {
        self vehicle_setspeed( 25, 5 );
        thread littlebirdcrash( 75 );
        hostmigration::waitlongdurationwithhostmigrationpause( 2.7 );
    }
    
    if ( isdefined( self.lz ) )
    {
        self.lz notify( #"extraction_destroyed" );
    }
    
    littlebirdexplode();
}

// Namespace br_extract_chopper
// Params 0
// Checksum 0xd8ce0aa1, Offset: 0xbb0
// Size: 0x60
function littlebirdexplode()
{
    self playsound( "dropship_explode_mp" );
    level.jackals[ level.jackals.size - 1 ] = undefined;
    self notify( #"explode" );
    
    if ( isdefined( self.lz ) )
    {
        playfxontag( utility::getfx( "jackal_explosion" ), self, "tag_origin" );
    }
    
    wait 0.35;
    thread littlebirddelete();
}

// Namespace br_extract_chopper
// Params 0
// Checksum 0x879ad984, Offset: 0xc18
// Size: 0xec
function littlebirddelete()
{
    /#
        print::printgameaction( "<dev string:x24>", self.owner );
    #/
    
    if ( isdefined( self.turret ) )
    {
        self.turret delete();
    }
    
    if ( isdefined( self.cannon ) )
    {
        self.cannon delete();
    }
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    foreach ( loc in level.carepackagedropnodes )
    {
        loc.free = undefined;
    }
    
    self delete();
}

// Namespace br_extract_chopper
// Params 1
// Checksum 0x5ee4b722, Offset: 0xd0c
// Size: 0x7a
function littlebirdcrash( speed )
{
    self endon( #"explode" );
    self clearlookatent();
    self notify( #"jackal_crashing" );
    self setvehgoalpos( self.origin + ( 0, 0, 100 ), 1 );
    hostmigration::waitlongdurationwithhostmigrationpause( 1.5 );
    self setyawspeed( speed, speed, speed );
    self settargetyaw( self.angles[ 1 ] + speed * 2.5 );
}

// Namespace br_extract_chopper
// Params 0
// Checksum 0x5d19dffb, Offset: 0xd8e
// Size: 0x148
function handledestroydamage()
{
    self endon( #"death" );
    self endon( #"leaving" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        objweapon = weapon::mapweapon( objweapon, inflictor );
        
        if ( ( objweapon.basename == "aamissile_projectile_mp" || objweapon.basename == "nuke_mp" ) && meansofdeath == "MOD_EXPLOSIVE" && damage >= self.health )
        {
            if ( isdefined( self.onhelikilled ) )
            {
                [[ self.onhelikilled ]]( self.team );
            }
            
            callback_vehicledamage( attacker, attacker, 9001, 0, meansofdeath, objweapon, point, direction_vec, point, 0, 0, partname );
        }
    }
}

// Namespace br_extract_chopper
// Params 13
// Checksum 0xa0383be, Offset: 0xede
// Size: 0x1ee
function callback_vehicledamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid )
{
    if ( isdefined( attacker ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
    }
    
    if ( ( attacker == self || isdefined( attacker.pers ) && attacker.pers[ "team" ] == self.team && !level.friendlyfire && level.teambased ) && attacker != self.owner )
    {
        return;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    damage = killstreak::getmodifiedantikillstreakdamage( attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5 );
    killstreaks::killstreakhit( attacker, objweapon, self, meansofdeath, damage );
    attacker damagefeedback::updatedamagefeedback( "" );
    damage::logattackerkillstreak( self, damage, attacker, dir, point, meansofdeath, modelindex, undefined, partname, dflags, objweapon );
    
    if ( self.health <= damage )
    {
        if ( isplayer( attacker ) && attacker != self.owner )
        {
            damage::onkillstreakkilled( "jackal", attacker, objweapon, meansofdeath, damage, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier" );
        }
    }
    
    if ( self.health - damage <= 900 && !self.smoking )
    {
        self.smoking = 1;
    }
    
    self vehicle_finishdamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, #"tag_origin", partname );
}

// Namespace br_extract_chopper
// Params 4
// Checksum 0x6aca768f, Offset: 0x10d4
// Size: 0x10a
function monitorarriveoverdestination( littlebird, marker, team, helitimeoffset )
{
    littlebird endon( #"death" );
    littlebird endon( #"leaving" );
    assert( isdefined( littlebird ) );
    littlebird setvehgoalpos( littlebird.pathgoal, 1 );
    littlebird thread changemaxpitchrollwhenclosetogoal( littlebird.pathgoal );
    littlebird waittill( #"goal" );
    littlebird thread watchgameendleave();
    
    if ( isdefined( helitimeoffset ) )
    {
        setspeed = littlebird.speed;
        acceleration = littlebird.accel;
    }
    else
    {
        setspeed = littlebird.speed / 4;
        acceleration = littlebird.accel / 6;
    }
    
    littlebird vehicle_setspeed( setspeed, acceleration );
    littlebird littlebirddescendtoextraction( marker.location, littlebird.zone, team );
}

// Namespace br_extract_chopper
// Params 0
// Checksum 0x39409cf0, Offset: 0x11e6
// Size: 0x1c9
function littlebirdleave()
{
    self endon( #"death" );
    speedoverride = self.speed;
    acceloverride = self.accel;
    self setmaxpitchroll( 0, 0 );
    self notify( #"leaving" );
    self.leaving = 1;
    self clearlookatent();
    
    if ( isdefined( self.turrettarget ) && isdefined( self.targetoutline ) )
    {
        outline::outlinedisable( self.targetoutline, self.turrettarget );
    }
    
    jackalspeed = int( self.speed / 14 );
    jackalaccel = int( self.accel / 16 );
    
    if ( isdefined( speedoverride ) )
    {
        jackalspeed = speedoverride;
    }
    
    if ( isdefined( acceloverride ) )
    {
        jackalaccel = acceloverride;
    }
    
    self vehicle_setspeed( jackalspeed, jackalaccel );
    pathgoal = self.origin + anglestoforward( ( 0, randomint( 360 ), 0 ) ) * 500;
    pathgoal += ( 0, 0, 1000 );
    self setvehgoalpos( pathgoal, 1 );
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    self waittill( #"goal" );
    pathend = getpathend();
    self vehicle_setspeed( 250, 75 );
    self setvehgoalpos( pathend, 1 );
    self waittill( #"goal" );
    self stoploopsound();
    level.jackals[ level.jackals.size - 1 ] = undefined;
    self notify( #"jackal_gone" );
    
    if ( game_utility::getgametype() != "arm" && game_utility::getgametype() != "conflict" )
    {
        littlebirddelete();
    }
}

// Namespace br_extract_chopper
// Params 0
// Checksum 0x2517c225, Offset: 0x13b7
// Size: 0x61
function getpathend()
{
    pathrandomness = 150;
    halfdistance = 15000;
    yaw = self.angles[ 1 ];
    direction = ( 0, yaw, 0 );
    endpoint = self.origin + anglestoforward( direction ) * halfdistance;
    return endpoint;
}

// Namespace br_extract_chopper
// Params 3
// Checksum 0x534eeae2, Offset: 0x1421
// Size: 0x95
function littlebirddescendtoextraction( location, zone, team )
{
    descend( location, zone );
    
    if ( game_utility::getgametype() != "vip" && game_utility::getgametype() != "arm" && game_utility::getgametype() != "conflict" && game_utility::getgametype() != "btm" )
    {
        zone.teamsextracting = arrayremove( zone.teamsextracting, team + self.sessionsquadid );
        thread littlebirdleave();
    }
}

// Namespace br_extract_chopper
// Params 2
// Checksum 0xdbdfef00, Offset: 0x14be
// Size: 0x1cc
function descend( location, zone )
{
    self endon( #"bugout" );
    newpos = undefined;
    locationx = location[ 0 ];
    locationy = location[ 1 ];
    properz = tracegroundheight( locationx, locationy, 20 );
    newpos = ( locationx, locationy, properz );
    
    if ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" )
    {
        properz = tracegroundheight( locationx, locationy, 5, 1 );
        newpos = ( locationx, locationy, properz + 200 );
    }
    
    self clearlookatent();
    self setvehgoalpos( newpos, 1 );
    
    /#
        line( self.origin, newpos, ( 0, 1, 0 ), 1, 0, 250 );
        sphere( newpos, 100, ( 0, 1, 0 ), 0, 250 );
    #/
    
    self waittill( #"goal" );
    
    if ( game_utility::getgametype() == "vip" )
    {
        self notify( #"hash_98bcf0401001ea22" );
        return;
    }
    
    if ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" )
    {
        self vehicle_setspeed( self.speed / 8, self.accel / 12 );
        properz = tracegroundheight( locationx, locationy, undefined, 1 );
        newpos = ( locationx, locationy, properz + 120 );
        self setvehgoalpos( newpos, 1 );
        self notify( #"hash_98bcf0401001ea22" );
        self waittill( #"goal" );
        self vehicle_setspeed( self.speed / 3, self.accel / 4 );
        return;
    }
    
    if ( game_utility::getgametype() == "btm" )
    {
        self notify( #"hash_98bcf0401001ea22" );
    }
}

// Namespace br_extract_chopper
// Params 4
// Checksum 0x8330f750, Offset: 0x1692
// Size: 0x6a
function tracegroundheight( x, y, rand, var_c7e0014b47f8a462 )
{
    offgroundheight = 30;
    groundheight = tracegroundpoint( x, y, var_c7e0014b47f8a462 );
    trueheight = groundheight + offgroundheight;
    
    if ( isdefined( rand ) )
    {
        trueheight += randomint( rand );
    }
    
    return trueheight;
}

// Namespace br_extract_chopper
// Params 3
// Checksum 0x2c756dfb, Offset: 0x1705
// Size: 0x18f
function tracegroundpoint( x, y, var_c7e0014b47f8a462 )
{
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    z = -99999;
    currz = self.origin[ 2 ] + 2000;
    minz = level.averagealliesz;
    ignorelist = [ self ];
    
    if ( isdefined( self.dropcrates ) )
    {
        foreach ( crate in self.dropcrates )
        {
            ignorelist[ ignorelist.size ] = crate;
        }
    }
    
    capsuleradius = 256;
    
    if ( isdefined( var_c7e0014b47f8a462 ) )
    {
        trc = trace::ray_trace( ( x, y, currz ), ( x, y, z ), ignorelist, undefined, undefined, 1 );
    }
    else
    {
        trc = trace::sphere_trace( ( x, y, currz ), ( x, y, z ), 256, ignorelist, undefined, 1 );
    }
    
    if ( trc[ "position" ][ 2 ] < minz )
    {
        hightrace = minz;
    }
    else
    {
        hightrace = trc[ "position" ][ 2 ];
    }
    
    return hightrace;
}

// Namespace br_extract_chopper
// Params 0
// Checksum 0x8a1997b4, Offset: 0x189d
// Size: 0x2e
function watchgameendleave()
{
    self endon( #"death" );
    self endon( #"leaving" );
    level waittill( #"game_ended" );
    thread littlebirdleave();
}

// Namespace br_extract_chopper
// Params 1
// Checksum 0xd0ad0408, Offset: 0x18d3
// Size: 0x5c
function changemaxpitchrollwhenclosetogoal( pathgoal )
{
    self endon( #"goal" );
    self endon( #"death" );
    self endon( #"leaving" );
    
    for ( ;; )
    {
        if ( distance2d( self.origin, pathgoal ) < 768 )
        {
            self setmaxpitchroll( 10, 25 );
            break;
        }
        
        wait 0.05;
    }
}

// Namespace br_extract_chopper
// Params 0
// Checksum 0xf018aa79, Offset: 0x1937
// Size: 0x9
function abortextractpickup()
{
    thread littlebirdleave();
}

