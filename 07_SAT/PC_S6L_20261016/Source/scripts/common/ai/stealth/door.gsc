// scripts\common\ai\stealth\door.gsc  (hash_66fb5e83a5a97883.gscc) (size: 4158 Bytes / 0x103e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbbfd19f1 (3153926641)
// size ...... 4158 (0x103e)
// includes .. 4   (offset: 0xfd2)
// strings ... 6   (offset: 0xff2)
// dev strs .. 0   (offset: 0x103e)
// exports ... 6   (offset: 0xb02)
// cseg ...... 0xb3 + 0xa4f (0xb02)
// imports ... 33  (offset: 0xbf2)
// animtree1 . 0   (offset: 0x103e)
// animtree2 . 0   (offset: 0x103e)
#using scripts\common\ai\stealth\enemy;
#using scripts\common\ai\stealth\utility;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace door;

// Namespace door
// Params 0
// Checksum 0x17eb3e1d, Offset: 0xd1
// Size: 0x10a
function stealth_suspicious_doors_init()
{
    if ( level.ship_assault )
    {
        return;
    }
    
    if ( isdefined( level.stealth ) )
    {
        if ( !isdefined( level.stealth.suspicious_door ) )
        {
            level.stealth.suspicious_door = spawnstruct();
            level.stealth.suspicious_door.doors = [];
            level.stealth.suspicious_door.reset_time = 30;
            level.stealth.suspicious_door.sight_distsqrd = squared( 600 );
            level.stealth.suspicious_door.detect_distsqrd = squared( 200 );
            level.stealth.suspicious_door.found_distsqrd = squared( 128 );
        }
        
        level utility::set_stealth_func( "suspicious_door", &suspicious_door_found );
    }
}

// Namespace door
// Params 0
// Checksum 0xd78fea43, Offset: 0x1e3
// Size: 0x5d
function suspicious_door_thread()
{
    self notify( #"suspicious_door_thread" );
    self endon( #"suspicious_door_thread" );
    self endon( #"death" );
    self endon( #"pain_death" );
    
    while ( true )
    {
        utility::ent_flag_wait( "stealth_enabled" );
        
        if ( !utility::function_4d40994d0dcca395() )
        {
            suspicious_door_sighting();
        }
        
        wait 0.1;
    }
}

// Namespace door
// Params 0
// Checksum 0x1a65adb9, Offset: 0x248
// Size: 0x455
function suspicious_door_sighting()
{
    if ( !isdefined( self.stealth.suspicious_door ) )
    {
        self.stealth.suspicious_door = spawnstruct();
    }
    
    if ( gettime() < self.stealth.suspicious_door.nexttime )
    {
        return;
    }
    
    if ( self.ignoreall )
    {
        return;
    }
    
    if ( self.var_73ce0d9808df6814 )
    {
        return;
    }
    
    if ( self.stealth.suspicious_door.investigating )
    {
        return;
    }
    
    if ( isdefined( self.stealth.suspicious_door.ent ) )
    {
        debounce = 100;
    }
    else
    {
        debounce = 1000;
    }
    
    self.stealth.suspicious_door.nexttime = gettime() + debounce;
    doors = level.stealth.suspicious_door.doors;
    found_door = undefined;
    saw_door = undefined;
    door = undefined;
    
    foreach ( door in doors )
    {
        doorentnum = door getentitynumber();
        
        if ( isdefined( door.found ) )
        {
            continue;
        }
        
        doororigin = door.origin;
        distsq = distancesquared( self.origin, doororigin );
        found_dist_sq = level.stealth.suspicious_door.found_distsqrd;
        sight_dist_sq = level.stealth.suspicious_door.sight_distsqrd;
        detect_dist_sq = level.stealth.suspicious_door.detect_distsqrd;
        
        if ( doororigin[ 2 ] - self.origin[ 2 ] > 128 )
        {
            continue;
        }
        
        if ( isdefined( self.stealth.suspicious_door.ent ) )
        {
            if ( self.stealth.suspicious_door.ent == door )
            {
                continue;
            }
            
            doororiginnew = self.stealth.suspicious_door.ent.origin;
            dist2sq = distancesquared( self.origin, doororiginnew );
            
            if ( dist2sq <= distsq )
            {
                continue;
            }
        }
        
        if ( distsq < found_dist_sq )
        {
            if ( abs( self.origin[ 2 ] - doororigin[ 2 ] ) < 60 )
            {
                /#
                    if ( getdvarint( @"debug_stealth_doors" ) )
                    {
                        line( doororigin, self.origin, ( 0, 1, 0 ), 1, 0, 400 );
                    }
                #/
                
                found_door = door;
                break;
            }
        }
        
        if ( distsq > sight_dist_sq )
        {
            continue;
        }
        
        if ( distsq < detect_dist_sq )
        {
            if ( canseedoor( door, debounce ) )
            {
                found_door = door;
                break;
            }
        }
        
        sight = anglestoforward( self gettagangles( "tag_eye" ) );
        var_242e98c4648f9f5d = vectornormalize( doororigin + ( 0, 0, 30 ) - self geteye() );
        
        if ( vectordot( sight, var_242e98c4648f9f5d ) > 0.55 )
        {
            if ( canseedoor( door, debounce ) )
            {
                found_door = door;
                break;
            }
        }
    }
    
    if ( isdefined( found_door ) )
    {
        found_door.found = 1;
        spot = undefined;
        
        if ( isdefined( door.cam_structs ) )
        {
            spot = door.cam_structs[ 0 ].origin;
        }
        else
        {
            spot = door.origin;
        }
        
        self aieventlistenerevent( "suspicious_door", found_door, spot );
    }
}

// Namespace door
// Params 2, eflags: 0x4
// Checksum 0x27704672, Offset: 0x6a5
// Size: 0x278
function private canseedoor( door, debounce )
{
    result = 0;
    debugorigin = door.origin;
    
    if ( !isdefined( door.seen ) )
    {
        if ( self cansee( door, debounce ) )
        {
            result = 1;
        }
        else
        {
            handleoffset = rotatevectorinverted( door.open_struct.origin - door.origin, door.true_start_angles );
            handleorigin = door.origin + rotatevector( handleoffset, door.pivot_ent.angles );
            ignoreents = arraycombine( getstealthcantracetoaiignoreents(), [ door ] );
            
            if ( isdefined( door.clip ) )
            {
                ignoreents[ ignoreents.size ] = door.clip;
            }
            
            if ( isdefined( door.clip_nosight ) )
            {
                ignoreents[ ignoreents.size ] = door.clip_nosight;
            }
            
            startorigin = self geteye();
            originstocheck = [ door.origin, handleorigin ];
            
            foreach ( origin in originstocheck )
            {
                debugorigin = origin;
                trace = trace::ray_trace( startorigin, origin, ignoreents );
                
                if ( trace[ "hittype" ] == "hittype_none" )
                {
                    result = 1;
                    break;
                }
            }
        }
    }
    
    /#
        if ( getdvarint( @"debug_stealth_doors" ) )
        {
            color = result ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            frames = int( debounce / 1000 * level.frameduration );
            print3d( debugorigin, door getentitynumber(), ( 1, 1, 1 ), 1, 1, frames );
            line( debugorigin, self.origin, color, 1, 0, frames );
        }
    #/
    
    return result;
}

// Namespace door
// Params 1
// Checksum 0xd96aac72, Offset: 0x926
// Size: 0x1dc
function suspicious_door_found( event )
{
    door = event.entity;
    
    if ( isdefined( door.aiopener ) )
    {
        return;
    }
    
    door.aiopener = self;
    
    if ( isdefined( door.cam_structs[ 0 ] ) )
    {
        spot = door.cam_structs[ 0 ].origin;
    }
    else
    {
        spot = door.origin;
    }
    
    point = getclosestpointonnavmesh( spot, self );
    distscalar = 75;
    doorright = anglestoright( door.true_start_angles );
    doornormal = vectornormalize( self.origin - door.origin );
    
    if ( vectordot( doorright, doornormal ) > 0 )
    {
        distscalar *= -1;
    }
    
    event.origin = spot + doorright * distscalar;
    event.investigate_pos = getclosestpointonnavmesh( event.origin, self );
    
    /#
        if ( getdvarint( @"debug_stealth_doors" ) )
        {
            line( door.origin, door.origin + doorright * 10, ( 1, 0, 0 ), 1, 0, 400 );
            line( door.origin, event.origin, ( 1, 1, 0 ), 1, 0, 400 );
            line( door.origin, event.investigate_pos, ( 0, 1, 0 ), 1, 0, 400 );
        }
    #/
    
    if ( self.stealth_bsmstate < 2 )
    {
        enemy::bt_set_stealth_state( "investigate", event );
    }
}

