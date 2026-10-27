// scripts\mp\br\gametypes\br_ai_encounters_util.gsc  (hash_11b676ca38322cc2.gscc) (size: 6669 Bytes / 0x1a0d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8e7eda63 (2390678115)
// size ...... 6669 (0x1a0d)
// includes .. 1   (offset: 0x184d)
// strings ... 30  (offset: 0x1855)
// dev strs .. 5   (offset: 0x19d1)
// exports ... 20  (offset: 0x1051)
// cseg ...... 0x1a9 + 0xea8 (0x1051)
// imports ... 42  (offset: 0x1371)
// animtree1 . 0   (offset: 0x1a0d)
// animtree2 . 0   (offset: 0x1a0d)
#using scripts\common\utility;

#namespace br_ai_encounters_util;

// Namespace br_ai_encounters_util
// Params 0
// Checksum 0xd8c4864a, Offset: 0x1c7
// Size: 0x251
function get_ai_team()
{
    var_7237854e3be197ca = self.encounter.info.team;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    playercount = [];
    
    foreach ( team in level.teamnamelist )
    {
        playercount[ team ] = 0;
    }
    
    foreach ( player in level.players )
    {
        team = player.pers[ "team" ];
        
        if ( !isdefined( team ) || team == "spectator" )
        {
            continue;
        }
        
        playercount[ team ]++;
    }
    
    foreach ( team, count in playercount )
    {
        if ( count == 0 )
        {
            self.encounter.info.team = team;
            break;
        }
    }
    
    if ( !isdefined( self.encounter.info.team ) )
    {
        println( "<dev string:x24>" );
        self.encounter.info.team = utility::array_random( level.teamnamelist );
    }
    
    return self.encounter.info.team;
}

// Namespace br_ai_encounters_util
// Params 0
// Checksum 0x2123a632, Offset: 0x421
// Size: 0x1c6
function get_targets()
{
    targets = [];
    
    if ( isdefined( self.target ) )
    {
        structs = utility::getstructarray( self.target, "targetname" );
        
        foreach ( struct in structs )
        {
            targets[ targets.size ] = struct;
        }
        
        ents = getentarray( self.target, #targetname );
        
        foreach ( ent in ents )
        {
            targets[ targets.size ] = ent;
        }
        
        nodes = getnodearray( self.target, #targetname );
        
        foreach ( node in nodes )
        {
            targets[ targets.size ] = node;
        }
    }
    
    return targets;
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0x233d010, Offset: 0x5f0
// Size: 0x121
function getvartype( var )
{
    if ( !isdefined( var ) )
    {
        return "undefined";
    }
    else if ( isfunction( var ) )
    {
        return "function";
    }
    else if ( isbuiltinfunction( var ) )
    {
        return "builtin function";
    }
    else if ( isbuiltinmethod( var ) )
    {
        return "builtin method";
    }
    else if ( isanimation( var ) )
    {
        return "animation";
    }
    else if ( isarray( var ) )
    {
        return "array";
    }
    else if ( isstruct( var ) )
    {
        str = "struct";
    }
    else if ( isvector( var ) )
    {
        str = "vector";
    }
    else if ( isent( var ) )
    {
        str = "entity";
    }
    else if ( isnode( var ) )
    {
        str = "node";
    }
    else if ( isint( var ) )
    {
        str = "int";
    }
    else if ( isfloat( var ) )
    {
        str = "float";
    }
    else if ( isstring( var ) )
    {
        str = "string";
    }
    else if ( isistring( var ) )
    {
        str = "istring";
    }
    else
    {
        str = "unknown";
    }
    
    return str;
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0x3ededcbc, Offset: 0x71a
// Size: 0xd3
function vartostring( var )
{
    type = getvartype( var );
    
    switch ( type )
    {
        case #"hash_b38a5d117ade0306":
            return _arraytostring( var );
        case #"hash_a08ace5b3c23c762":
            return ( "(" + var[ 0 ] + "," + var[ 1 ] + "," + var[ 2 ] + ")" );
        case #"hash_3e4a6f464c850b65":
        case #"hash_4730906c2f53f03e":
            return string( var );
        case #"hash_2ac140ce3b5ea398":
            return var;
        case #"hash_83e3a4585099313a":
            return ( "$e" + var getentitynumber() );
        default:
            return ( "<" + type + ">" );
    }
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0xc92d9bd5, Offset: 0x7f5
// Size: 0xbf
function _arraytostring( var )
{
    str = "[ ";
    first = 1;
    
    foreach ( value in var )
    {
        if ( !first )
        {
            str += ",";
        }
        else
        {
            first = 0;
        }
        
        str += vartostring( value );
    }
    
    str += " ]";
    return str;
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0xee26113b, Offset: 0x8bd
// Size: 0x1e
function encounterremovenavobstacle( obstacleid )
{
    destroynavobstacle( obstacleid );
    self notify( "nav_obstacle_destroy_" + obstacleid );
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0x91b9598d, Offset: 0x8e3
// Size: 0x2d
function encounterremovenavobstacleonencounterend( obstacleid )
{
    self endon( "nav_obstacle_destroy_" + obstacleid );
    self waittill( #"hash_40e543a1950bc4ec" );
    encounterremovenavobstacle( obstacleid );
}

// Namespace br_ai_encounters_util
// Params 2
// Checksum 0x401e6c1d, Offset: 0x918
// Size: 0x38
function encounterremovenavobstacledelay( obstacleid, delaysec )
{
    self endon( "nav_obstacle_destroy_" + obstacleid );
    self endon( #"hash_40e543a1950bc4ec" );
    wait delaysec;
    encounterremovenavobstacle( obstacleid );
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0x37f1be7f, Offset: 0x958
// Size: 0x2d
function encounterdeleteentonend( ent )
{
    ent endon( #"death" );
    self waittill( #"hash_40e543a1950bc4ec" );
    ent delete();
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0x290b101e, Offset: 0x98d
// Size: 0x84
function disablescriptableplayeruseall( rewardobject )
{
    foreach ( player in level.players )
    {
        rewardobject disablescriptableplayeruse( player );
    }
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0x7818639d, Offset: 0xa19
// Size: 0x84
function enablescriptableplayeruseall( rewardobject )
{
    foreach ( player in level.players )
    {
        rewardobject enablescriptableplayeruse( player );
    }
}

// Namespace br_ai_encounters_util
// Params 3
// Checksum 0x4f376334, Offset: 0xaa5
// Size: 0x1c5
function waittill_dead( guys, num, timeoutlength )
{
    /#
        allalive = 1;
        
        foreach ( member in guys )
        {
            if ( isalive( member ) )
            {
                continue;
            }
            
            allalive = 0;
            break;
        }
        
        assert( allalive, "<dev string:x6f>" );
        
        if ( !allalive )
        {
            newarray = [];
            
            foreach ( member in guys )
            {
                if ( isalive( member ) )
                {
                    newarray[ newarray.size ] = member;
                }
            }
            
            guys = newarray;
        }
    #/
    
    ent = spawnstruct();
    
    if ( isdefined( timeoutlength ) )
    {
        ent endon( #"thread_timed_out" );
        ent thread waittill_dead_timeout( timeoutlength );
    }
    
    ent.count = guys.size;
    
    if ( num < ent.count )
    {
        ent.count = num;
    }
    
    utility::array_thread( guys, &waittill_dead_thread, ent );
    
    while ( ent.count > 0 )
    {
        ent waittill( #"waittill_dead guy died" );
    }
}

// Namespace br_ai_encounters_util
// Params 3
// Checksum 0x6fc27fbe, Offset: 0xc72
// Size: 0x140
function waittill_dead_or_dying( guys, num, timeoutlength )
{
    newarray = [];
    
    foreach ( member in guys )
    {
        if ( isalive( member ) && !member.ignoreforfixednodesafecheck )
        {
            newarray[ newarray.size ] = member;
        }
    }
    
    guys = newarray;
    ent = spawnstruct();
    
    if ( isdefined( timeoutlength ) )
    {
        ent endon( #"thread_timed_out" );
        ent thread waittill_dead_timeout( timeoutlength );
    }
    
    ent.count = guys.size;
    
    if ( num < ent.count )
    {
        ent.count = num;
    }
    
    utility::array_thread( guys, &waittill_dead_or_dying_thread, ent );
    
    while ( ent.count > 0 )
    {
        ent waittill( #"waittill_dead_guy_dead_or_dying" );
    }
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0xfa66ea0f, Offset: 0xdba
// Size: 0x35
function waittill_notetrack_or_damage( notetrack )
{
    self endon( #"damage" );
    self endon( #"death" );
    self waittillmatch( #"single anim", notetrack );
}

// Namespace br_ai_encounters_util
// Params 2
// Checksum 0x9bf3f141, Offset: 0xdf7
// Size: 0x56
function get_living_ai( name, type )
{
    array = get_living_ai_array( name, type );
    
    if ( array.size > 1 )
    {
        assertmsg( "<dev string:xca>" + type + "<dev string:x102>" + name + "<dev string:x10b>" );
        return;
    }
    
    return array[ 0 ];
}

// Namespace br_ai_encounters_util
// Params 2
// Checksum 0xe2a670f, Offset: 0xe56
// Size: 0x15f
function get_living_ai_array( name, type )
{
    ai = getaispeciesarray( "all", "all" );
    array = [];
    
    foreach ( actor in ai )
    {
        if ( !isalive( actor ) )
        {
            continue;
        }
        
        switch ( type )
        {
            case #"hash_5a532485943b3d4b":
                if ( isdefined( actor.targetname ) && actor.targetname == name )
                {
                    array[ array.size ] = actor;
                }
                
                break;
            case #"hash_6d8a4db48060bf8":
                if ( isdefined( actor.script_noteworthy ) && actor.script_noteworthy == name )
                {
                    array[ array.size ] = actor;
                }
                
                break;
            case #"hash_a9ba80180b5bb733":
                if ( isdefined( actor.animname ) && actor.animname == name )
                {
                    array[ array.size ] = actor;
                }
                
                break;
        }
    }
    
    return array;
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0x6609ffba, Offset: 0xfbe
// Size: 0x32
function waittill_dead_thread( ent )
{
    self waittill( #"death" );
    ent.count--;
    ent notify( #"waittill_dead guy died" );
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0x5bf0733e, Offset: 0xff8
// Size: 0x36
function waittill_dead_or_dying_thread( ent )
{
    utility::waittill_any( "death", "long_death" );
    ent.count--;
    ent notify( #"waittill_dead_guy_dead_or_dying" );
}

// Namespace br_ai_encounters_util
// Params 1
// Checksum 0x2a872306, Offset: 0x1036
// Size: 0x1b
function waittill_dead_timeout( timeoutlength )
{
    wait timeoutlength;
    self notify( #"thread_timed_out" );
}

