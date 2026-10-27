// scripts\mp\dmz\dmz_ai_gunboat.gsc  (hash_0492bc03013dc1cf.gscc) (size: 3276 Bytes / 0xccc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x88a586d (143284333)
// size ...... 3276 (0xccc)
// includes .. 5   (offset: 0xbf8)
// strings ... 11  (offset: 0xc20)
// dev strs .. 1   (offset: 0xcc0)
// exports ... 9   (offset: 0x704)
// cseg ...... 0xe9 + 0x61b (0x704)
// imports ... 31  (offset: 0x86c)
// animtree1 . 0   (offset: 0xccc)
// animtree2 . 0   (offset: 0xccc)
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\common\utility\killstreak_utility;

#namespace dmz_ai_gunboat;

// Namespace dmz_ai_gunboat
// Params 1
// Checksum 0x84e937f3, Offset: 0x107
// Size: 0x4b
function function_1aec4a820d3e2e58( poiname )
{
    fakeowner = ai_mp_controller::function_3d6581dd2c928fbc( agent_utils::function_25b40f5accbca0dd( "merc" ) );
    streakinfo = killstreak_utility::createstreakinfo( "gunship", fakeowner );
    function_c5d1028ec4aed8ab( poiname, streakinfo, fakeowner );
}

// Namespace dmz_ai_gunboat
// Params 1, eflags: 0x4
// Checksum 0x4c9c0d8c, Offset: 0x15a
// Size: 0x1bf
function private function_87e64de4e2424f7b( poiname )
{
    poiorigin = utility::callsharedfunc( #"poi", #"hash_fc858bd1017130aa", poiname );
    routeheight = level.killstreak_gunboat.routeheight;
    routeradius = level.killstreak_gunboat.routeradius;
    var_dbb2cbe83ef6045d = level.killstreak_gunboat.var_674c69d5eebd2e82;
    numpoints = getdvarint( @"hash_3b46315eaafe1a8c", 10 );
    route = [];
    routeDurations = [];
    assert( numpoints >= 4, "<dev string:x24>" );
    frac = 1 / numpoints;
    individualduration = frac * var_dbb2cbe83ef6045d;
    initialangle = randomint( 360 );
    
    for ( i = 0; i < numpoints ; i++ )
    {
        currfrac = frac * i;
        theta = 360 * currfrac + initialangle;
        xoffset = cos( theta ) * routeradius;
        yoffset = sin( theta ) * routeradius;
        currpoint = poiorigin + ( xoffset, yoffset, routeheight );
        
        /#
            sphere( currpoint, 30, ( 1, 1, 1 ), 0, 60 );
        #/
        
        route[ route.size ] = currpoint;
        routeDurations[ routeDurations.size ] = individualduration;
    }
    
    level.poi[ poiname ][ "route" ] = route;
    level.poi[ poiname ][ "routeDurations" ] = routeDurations;
    return route;
}

// Namespace dmz_ai_gunboat
// Params 3
// Checksum 0xb527ea8c, Offset: 0x322
// Size: 0x7b, Type: bool
function function_cd81c3ea75384d7a( target, maxangle, turretindex )
{
    turretforward = anglestoforward( self getturretworldangles( turretindex ) );
    totarget = vectornormalize( target.origin + ( 0, 0, 25 ) - self function_6382f336b5e5cdca( turretindex ) );
    angle = math::anglebetweenvectors( turretforward, totarget );
    return angle < maxangle;
}

// Namespace dmz_ai_gunboat
// Params 2
// Checksum 0xe44e182c, Offset: 0x3a6
// Size: 0xc4
function function_1f4e400a476a53e5( target, turretindex )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    offset = ( 0, 0, 0 );
    
    if ( isdefined( target ) )
    {
        self setturrettargetent( target, offset, turretindex );
        
        while ( true )
        {
            if ( function_cd81c3ea75384d7a( target, 10, turretindex ) )
            {
                break;
            }
            
            wait 0.25;
        }
        
        for ( i = 0; i < 5 ; i++ )
        {
            offset = ( 0, 0, 0 );
            self setturrettargetent( target, offset, turretindex );
            wait 1;
            self fireweapon( turretindex, target, offset );
        }
        
        wait 4;
    }
}

// Namespace dmz_ai_gunboat
// Params 0, eflags: 0x4
// Checksum 0x3969e68a, Offset: 0x473
// Size: 0x6b
function private function_910b446162e0339d()
{
    randdist = randomint( 300 ) + 50;
    randangle = randomint( 360 );
    x = randdist * cos( randangle );
    y = randdist * sin( randangle );
    z = 0;
    offset = ( x, y, z );
    return offset;
}

// Namespace dmz_ai_gunboat
// Params 1, eflags: 0x4
// Checksum 0x73b2e4bd, Offset: 0x4e7
// Size: 0xac
function private function_98b8f922397e1972( poiname )
{
    self addcomponent( "path" );
    self addcomponent( "c2p" );
    self.pathtype = "path_catmullrom";
    splineid = function_53253e8ea222ed60( level.poi[ poiname ][ "route" ], level.poi[ poiname ][ "routeDurations" ], 1 );
    self function_eb88c4e66edbc855( "path", "catmullRomId", splineid );
    self function_eb88c4e66edbc855( "path", "advanceOnStart", 1 );
    self function_eb88c4e66edbc855( "path", "yawHelper", 0 );
    self function_eb88c4e66edbc855( "path", "useManualSpeed", 0 );
}

// Namespace dmz_ai_gunboat
// Params 3
// Checksum 0x67aed07c, Offset: 0x59b
// Size: 0x11f
function function_c5d1028ec4aed8ab( poiname, streakinfo, owner )
{
    route = function_87e64de4e2424f7b( poiname );
    bundle = killstreak_utility::function_f943c0602acdc2af( "gunship" );
    safespawnstruct = spawnstruct();
    safespawnstruct.origin = route[ 0 ];
    safespawnstruct.angles = vectortoangles( route[ 1 ] - route[ 0 ] );
    gunboat = killstreak_utility::killstreak_vehicle_create( owner, streakinfo, safespawnstruct.origin, safespawnstruct.angles, undefined );
    
    if ( !isdefined( gunboat ) )
    {
        return;
    }
    
    level.killstreak_gunboat.var_579e028883a31a65[ level.killstreak_gunboat.var_579e028883a31a65.size ] = gunboat;
    gunboat.streakinfo = streakinfo;
    gunboat.owner = owner;
    gunboat.team = owner.team;
    gunboat thread function_98b8f922397e1972( poiname );
    gunboat thread function_338f758b101aef64();
}

// Namespace dmz_ai_gunboat
// Params 0
// Checksum 0xeb36858f, Offset: 0x6c2
// Size: 0x42
function function_338f758b101aef64()
{
    while ( true )
    {
        waitframe();
        
        if ( getdvarint( @"hash_c88417ed4eef26e8", 0 ) == 1 )
        {
            thread function_1f4e400a476a53e5( level.players[ 0 ], 2 );
            setdvar( @"hash_c88417ed4eef26e8", 0 );
        }
    }
}

