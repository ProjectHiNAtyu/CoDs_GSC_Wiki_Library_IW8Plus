// scripts\common\ai\stealth\group.gsc  (hash_2373da272a381e70.gscc) (size: 6478 Bytes / 0x194e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x62d21bb8 (1657936824)
// size ...... 6478 (0x194e)
// includes .. 3   (offset: 0x185a)
// strings ... 12  (offset: 0x1872)
// dev strs .. 0   (offset: 0x194e)
// exports ... 16  (offset: 0x10f2)
// cseg ...... 0xea + 0x1008 (0x10f2)
// imports ... 38  (offset: 0x1372)
// animtree1 . 0   (offset: 0x194e)
// animtree2 . 0   (offset: 0x194e)
#using scripts\asm\asm_bb;
#using scripts\common\ai\stealth\enemy;
#using scripts\common\utility;

#namespace group;

// Namespace group
// Params 1
// Checksum 0x6ec4fc10, Offset: 0x108
// Size: 0xc2
function initgroup( groupname )
{
    if ( !isdefined( level.stealth.groupdata ) )
    {
        level.stealth.groupdata = spawnstruct();
    }
    
    groupdata = level.stealth.groupdata;
    
    if ( !isdefined( groupdata.groups ) )
    {
        groupdata.groups = [];
    }
    
    mygroup = groupdata.groups[ groupname ];
    
    if ( !isdefined( mygroup ) )
    {
        mygroup = stealthinitgroup( groupname );
        groupdata.groups[ groupname ] = mygroup;
    }
    
    level.stealth.groupdata notify( groupname );
}

// Namespace group
// Params 2
// Checksum 0x670e4eeb, Offset: 0x1d2
// Size: 0xa0
function addtogroup( groupname, guy )
{
    if ( !( isdefined( level.stealth.groupdata ) && isdefined( level.stealth.groupdata.groups[ groupname ] ) ) )
    {
        initgroup( groupname );
    }
    
    mygroup = level.stealth.groupdata.groups[ groupname ];
    
    if ( !isdefined( mygroup ) )
    {
        return;
    }
    
    stealthaddtogroup( groupname, guy );
    mygroup thread group_waitfordeath( guy );
}

// Namespace group
// Params 1
// Checksum 0xf39ec7e5, Offset: 0x27a
// Size: 0x39
function group_waitfordeath( guy )
{
    guy waittill( #"death" );
    guy thread enemy::death_cleanup();
    
    if ( isdefined( guy ) )
    {
        stealthremovefromgroup( self.name, guy );
    }
}

// Namespace group
// Params 1
// Checksum 0x72061088, Offset: 0x2bb
// Size: 0x80
function getgroup( groupname )
{
    assert( isdefined( level.stealth ) );
    assert( isdefined( level.stealth.groupdata ) );
    assert( isdefined( level.stealth.groupdata.groups ) );
    return level.stealth.groupdata.groups[ groupname ];
}

// Namespace group
// Params 1
// Checksum 0xd0b11152, Offset: 0x344
// Size: 0x33
function pod_hunt_update( squadid )
{
    pod = spawnstruct();
    pod.squadid = squadid;
    pod thread function_93d2b1c4587d3f62();
}

// Namespace group
// Params 1
// Checksum 0xb6ef1672, Offset: 0x37f
// Size: 0xb4, Type: bool
function function_d173f7e2bef7be01( guy )
{
    clookaheaddist = 48;
    var_bed672fe084b4eb9 = 5000;
    
    if ( !isalive( guy ) )
    {
        return false;
    }
    
    if ( isdefined( self.jobs[ guy getentitynumber() ] ) )
    {
        return false;
    }
    
    if ( isdefined( guy.pathgoalpos ) && guy pathdisttogoal( 1 ) < clookaheaddist )
    {
        return false;
    }
    
    if ( guy asm_bb::bb_playsmartobjectrequested() )
    {
        return false;
    }
    
    if ( isdefined( guy.stealth.var_c2e24aa2b54d1a4d ) && gettime() - guy.stealth.var_c2e24aa2b54d1a4d < var_bed672fe084b4eb9 )
    {
        return false;
    }
    
    return true;
}

// Namespace group
// Params 0
// Checksum 0x72de55f7, Offset: 0x43c
// Size: 0x39b
function function_93d2b1c4587d3f62()
{
    var_1db61ae6a5da82ff = 262144;
    
    if ( !isdefined( self.jobs ) )
    {
        self.jobs = [];
    }
    
    jobid = 0;
    
    while ( true )
    {
        if ( !isdefined( self.squadid ) )
        {
            return;
        }
        
        members = aigetsquadmembers( self.squadid );
        
        if ( !isdefined( members ) || members.size == 0 )
        {
            return;
        }
        
        for ( i = 0; i < members.size ; i++ )
        {
            guy = members[ i ];
            
            if ( utility::is_dead_or_dying( guy ) || !function_d173f7e2bef7be01( guy ) )
            {
                continue;
            }
            
            entnum = guy getentitynumber();
            guylookaheaddir = guy.lookaheaddir;
            
            for ( j = i + 1; j < members.size ; j++ )
            {
                otherguy = members[ j ];
                
                if ( !isalive( otherguy ) )
                {
                    continue;
                }
                
                if ( utility::is_dead_or_dying( otherguy ) )
                {
                    continue;
                }
                
                otherentnum = otherguy getentitynumber();
                
                if ( distancesquared( guy.origin, otherguy.origin ) < var_1db61ae6a5da82ff )
                {
                    if ( !function_d173f7e2bef7be01( otherguy ) )
                    {
                        continue;
                    }
                    
                    otherguylookaheaddir = otherguy.lookaheaddir;
                    var_5e423e9b98c6a084 = vectornormalize( otherguy.origin - guy.origin );
                    
                    if ( vectordot( guylookaheaddir, var_5e423e9b98c6a084 ) < 0 && vectordot( guylookaheaddir, otherguylookaheaddir ) < 0 )
                    {
                        continue;
                    }
                    
                    guypos = guy.origin;
                    otherguypos = otherguy.origin;
                    midpoint = ( guypos + otherguypos ) / 2;
                    var_ebdbe7814ee802a8 = vectornormalize( midpoint - guy.origin );
                    var_591ccff8c485da76 = vectornormalize( midpoint - otherguy.origin );
                    
                    if ( vectordot( var_ebdbe7814ee802a8, guylookaheaddir ) < 0.5 )
                    {
                        continue;
                    }
                    
                    if ( vectordot( var_591ccff8c485da76, otherguylookaheaddir ) < 0.5 )
                    {
                        continue;
                    }
                    
                    if ( guy hastacvis( otherguy ) || otherguy hastacvis( guy ) )
                    {
                        midpoint = guy getclosestreachablepointonnavmesh( midpoint );
                        guypos = guy getclosestreachablepointonnavmesh( midpoint + 30 * vectornormalize( guypos - midpoint ) );
                        otherguypos = otherguy getclosestreachablepointonnavmesh( midpoint + 30 * vectornormalize( otherguypos - midpoint ) );
                        job = spawnstruct();
                        job.guys = [];
                        job.guys[ job.guys.size ] = guy;
                        job.guys[ job.guys.size ] = otherguy;
                        job.requestedpos = [];
                        job.requestedpos[ entnum ] = guypos;
                        job.requestedpos[ otherentnum ] = otherguypos;
                        job.state[ entnum ] = "init";
                        job.state[ otherentnum ] = "init";
                        job.leader = guy;
                        job.requesttime = gettime();
                        job.id = jobid;
                        self.jobs[ otherentnum ] = job;
                        self.jobs[ entnum ] = job;
                        childthread hunt_point_update( job );
                        jobid++;
                        wait 5;
                        break;
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace group
// Params 1
// Checksum 0x92d7d8dc, Offset: 0x7df
// Size: 0x3c
function function_96198570744ec631( job )
{
    self endon( #"hash_a7ebbf3b72352b9a" );
    self waittill( #"hash_2f41a75384ab8e1" );
    job.state[ self getentitynumber() ] = "done";
}

// Namespace group
// Params 1
// Checksum 0x8fe0e30e, Offset: 0x823
// Size: 0x391
function hunt_point_update( job )
{
    status = "wait_for_arrival";
    entnum1 = job.guys[ 0 ] getentitynumber();
    entnum2 = job.guys[ 1 ] getentitynumber();
    leader = job.leader;
    
    if ( job.leader == job.guys[ 0 ] )
    {
        follower = job.guys[ 1 ];
    }
    else
    {
        follower = job.guys[ 0 ];
    }
    
    leader endon( #"death" );
    follower endon( #"death" );
    leader.gunposeoverride_internal = "gun_down";
    follower.gunposeoverride_internal = "gun_down";
    leader setlookatenabled( 1 );
    follower setlookatenabled( 1 );
    leader childthread function_96198570744ec631( job );
    follower childthread function_96198570744ec631( job );
    leader endon( #"hash_2f41a75384ab8e1" );
    follower endon( #"hash_2f41a75384ab8e1" );
    state1 = "";
    state2 = "";
    leader utility::delaycall( randomfloatrange( 0.2, 1 ), &setlookatentity, follower, 0 );
    follower utility::delaycall( randomfloatrange( 0.2, 1 ), &setlookatentity, leader, 0 );
    
    while ( true )
    {
        if ( !isalive( job.guys[ 0 ] ) )
        {
            break;
        }
        
        if ( !isalive( job.guys[ 1 ] ) )
        {
            break;
        }
        
        guy1 = job.guys[ 0 ];
        guy2 = job.guys[ 1 ];
        
        if ( status == "wait_for_arrival" )
        {
            if ( state1 != "arrived" && !isdefined( guy1.pathgoalpos ) )
            {
                state1 = "arrived";
                job.state[ entnum1 ] = "wait";
                guy1.gunposeoverride_internal = undefined;
            }
            
            if ( state2 != "arrived" && !isdefined( guy2.pathgoalpos ) )
            {
                state2 = "arrived";
                job.state[ entnum2 ] = "wait";
                guy2.gunposeoverride_internal = undefined;
            }
            
            if ( state1 == "arrived" && state2 == "arrived" )
            {
                status = "gesture";
            }
        }
        
        if ( status == "gesture" )
        {
            job.state[ leader getentitynumber() ] = "gesture";
            leader hunt_waitforgesture( "hunt_gesture" );
            
            if ( !isalive( leader ) )
            {
                break;
            }
            
            job.state[ leader getentitynumber() ] = "wait";
            job.state[ follower getentitynumber() ] = "gesture";
            follower hunt_waitforgesture( "hunt_gesture" );
            
            if ( !isalive( follower ) )
            {
                break;
            }
            
            job.state[ follower getentitynumber() ] = "wait";
            status = "complete";
        }
        
        if ( status == "complete" )
        {
            job.state[ entnum1 ] = "done";
            job.state[ entnum2 ] = "done";
            break;
        }
        
        waitframe();
    }
    
    leader notify( #"hash_a7ebbf3b72352b9a" );
    follower notify( #"hash_a7ebbf3b72352b9a" );
}

// Namespace group
// Params 1
// Checksum 0x90d6ca73, Offset: 0xbbc
// Size: 0x6d
function hunt_waitforgesture( flag )
{
    self endon( #"death" );
    self endon( #"smartobject_logic_finished" );
    self endon( #"hunt_gesture_timeout" );
    childthread hunt_waitforgesture_timeout( 10 );
    
    while ( true )
    {
        self waittill( flag, status );
        
        if ( status == "gesture_finish" || status == "gesture_cancel" )
        {
            break;
        }
    }
}

// Namespace group
// Params 1
// Checksum 0x6ee64d4c, Offset: 0xc31
// Size: 0x1b
function hunt_waitforgesture_timeout( t )
{
    wait t;
    self notify( #"hunt_gesture_timeout" );
}

// Namespace group
// Params 1
// Checksum 0xffbc8eb2, Offset: 0xc54
// Size: 0x2b
function function_3d7d78fa51b4c2e3( guy )
{
    if ( !isdefined( self.jobs ) )
    {
        return;
    }
    
    return self.jobs[ guy getentitynumber() ];
}

// Namespace group
// Params 1
// Checksum 0x1e5e699d, Offset: 0xc88
// Size: 0x2b
function function_6cc70e0fbad2400( guy )
{
    if ( !isdefined( self.jobs ) )
    {
        return;
    }
    
    self.jobs[ guy getentitynumber() ] = undefined;
}

// Namespace group
// Params 1
// Checksum 0x3df687eb, Offset: 0xcbb
// Size: 0xa2
function function_2243c1594b91a446( array )
{
    callsigns = [];
    
    foreach ( guy in array )
    {
        if ( isdefined( guy.bccallsign ) )
        {
            callsigns[ callsigns.size ] = guy.bccallsign;
        }
    }
    
    return callsigns;
}

// Namespace group
// Params 0
// Checksum 0x214fa865, Offset: 0xd66
// Size: 0x38c
function pod_hunt_vo()
{
    if ( isdefined( level.bcs_stealthhuntthink ) )
    {
        return;
    }
    
    level.bcs_stealthhuntthink = 1;
    
    if ( !isdefined( level.var_f07cf694d416152a ) )
    {
        level.var_f07cf694d416152a = [ 6, 12 ];
    }
    
    first_lost = undefined;
    
    while ( true )
    {
        hunters = [];
        
        foreach ( group in level.stealth.groupdata.groups )
        {
            if ( !isdefined( group.pods ) )
            {
                continue;
            }
            
            foreach ( pod in group.pods )
            {
                if ( pod.state != 2 )
                {
                    continue;
                }
                
                foreach ( hunter in pod.members )
                {
                    hunters[ hunters.size ] = hunter;
                }
            }
        }
        
        if ( hunters.size < 1 )
        {
            break;
        }
        
        if ( hunters.size > 1 )
        {
            if ( utility::issp() )
            {
                hunters = sortbydistance( hunters, level.player.origin );
            }
            else
            {
                hunters = arrayrandomize( hunters );
            }
            
            hunters[ 0 ].battlechatter.huntgroup = hunters;
            leader = hunters[ 0 ];
            hunters = arrayremove( hunters, leader );
            wait randomfloatrange( 2, 2.5 );
            hunters = utility::array_removedead_or_dying( hunters );
            
            if ( utility::issp() )
            {
                hunters = sortbydistance( hunters, level.player.origin );
            }
            else
            {
                hunters = arrayrandomize( hunters );
            }
            
            hunter = undefined;
            
            switch ( hunters.size )
            {
                case 0:
                    break;
                case 1:
                case 2:
                case 3:
                    hunter = hunters[ randomint( hunters.size ) ];
                    break;
                default:
                    hunter = hunters[ randomint( 3 ) ];
                    break;
            }
            
            if ( !isdefined( hunter ) )
            {
                break;
            }
            
            hunters[ hunters.size ] = leader;
            hunter.battlechatter.huntgroup = hunters;
        }
        else
        {
            hunter = hunters[ 0 ];
            
            if ( !isdefined( first_lost ) )
            {
            }
        }
        
        if ( isarray( level.var_f07cf694d416152a ) )
        {
            wait randomfloatrange( level.var_f07cf694d416152a[ 0 ], level.var_f07cf694d416152a[ 1 ] );
            continue;
        }
        
        wait level.var_f07cf694d416152a;
    }
    
    level.bcs_stealthhuntthink = undefined;
}

