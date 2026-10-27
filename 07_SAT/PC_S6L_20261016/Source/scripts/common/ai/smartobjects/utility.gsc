// scripts\common\ai\smartobjects\utility.gsc  (hash_5a1384dc05b4b87f.gscc) (size: 9163 Bytes / 0x23cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe80da602 (3893208578)
// size ...... 9163 (0x23cb)
// includes .. 3   (offset: 0x22b7)
// strings ... 7   (offset: 0x22cf)
// dev strs .. 14  (offset: 0x2323)
// exports ... 32  (offset: 0x1873)
// cseg ...... 0xf6 + 0x177d (0x1873)
// imports ... 41  (offset: 0x1d73)
// animtree1 . 0   (offset: 0x23cb)
// animtree2 . 0   (offset: 0x23cb)
#using scripts\asm\asm_bb;
#using scripts\common\system;
#using scripts\common\utility;

#namespace utility;

// Namespace utility
// Params 0, eflags: 0x5
// Checksum 0x9e73d4f5, Offset: 0x114
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"smartobjects", undefined, &pre_main, undefined );
}

// Namespace utility/spawnstruct
// Params 1, eflags: 0x24
// Checksum 0xb377b0e3, Offset: 0x135
// Size: 0x57
function private event_handler[spawnstruct] spawn_struct( struct )
{
    if ( struct.script_smartobject && isdefined( struct.script_linkto ) )
    {
        if ( !isdefined( level.link_smart_objects ) )
        {
            level.link_smart_objects = [];
        }
        
        level.link_smart_objects[ level.link_smart_objects.size ] = struct;
    }
}

// Namespace utility
// Params 0, eflags: 0x4
// Checksum 0xf88cf38e, Offset: 0x194
// Size: 0x175
function private pre_main()
{
    foreach ( struct in level.link_smart_objects )
    {
        structs = struct get_linked_structs();
        
        foreach ( linkedstruct in structs )
        {
            if ( linkedstruct == struct )
            {
                continue;
            }
            
            if ( !isdefined( linkedstruct.script_smartobject ) )
            {
                continue;
            }
            
            if ( !isdefined( struct.linkedsmartobjects ) )
            {
                struct.linkedsmartobjects = [];
            }
            
            struct.linkedsmartobjects[ struct.linkedsmartobjects.size ] = linkedstruct;
        }
        
        if ( !isdefined( anim.smartobjectpoints ) )
        {
            anim.smartobjectpoints = [];
        }
        
        anim.smartobjectpoints[ anim.smartobjectpoints.size ] = struct;
    }
    
    level.link_smart_objects = undefined;
}

// Namespace utility
// Params 0
// Checksum 0xc3779912, Offset: 0x311
// Size: 0xc8
function validate()
{
    if ( !isdefined( anim.smartobjectpoints ) )
    {
        return;
    }
    
    foreach ( point in anim.smartobjectpoints )
    {
        assert( isdefined( anim.smartobjects[ point.script_smartobject ] ), "<dev string:x24>" + point.script_smartobject + "<dev string:x32>" + point.origin + "<dev string:x38>" );
    }
}

// Namespace utility
// Params 3
// Checksum 0xc1f7bf2e, Offset: 0x3e1
// Size: 0x6e
function add_smartobject_type( name, fngetinfo, fnusecondition )
{
    if ( !isdefined( anim.smartobjects ) )
    {
        anim.smartobjects = [];
    }
    
    assert( !isdefined( anim.smartobjects[ name ] ) );
    anim.smartobjects[ name ] = { #fnusecondition:fnusecondition, #fngetinfo:fngetinfo };
}

// Namespace utility
// Params 0
// Checksum 0xf8663c85, Offset: 0x457
// Size: 0x21
function createsmartobjectinfo()
{
    info = spawnstruct();
    info.animlist = [];
    return info;
}

// Namespace utility
// Params 2
// Checksum 0x5cedea4d, Offset: 0x481
// Size: 0x40
function addsmartobjectanim_internal( statename, alias )
{
    if ( !isdefined( self.animlist[ statename ] ) )
    {
        self.animlist[ statename ] = [];
    }
    
    self.animlist[ statename ] = alias;
}

// Namespace utility
// Params 1
// Checksum 0xcd6f6d8f, Offset: 0x4c9
// Size: 0x25
function addsmartobjectintroanim( alias )
{
    addsmartobjectanim_internal( "smartobject_intro", alias );
    self.hasintro = 1;
}

// Namespace utility
// Params 1
// Checksum 0x9550a049, Offset: 0x4f6
// Size: 0x1a
function addsmartobjectanim( alias )
{
    addsmartobjectanim_internal( "smartobject_logic", alias );
}

// Namespace utility
// Params 1
// Checksum 0xb5a0027f, Offset: 0x518
// Size: 0x2b
function addsmartobjectreactanim( alias )
{
    if ( isdefined( alias ) )
    {
        addsmartobjectanim_internal( "smartobject_react", alias );
    }
    
    self.hasreact = 1;
}

// Namespace utility
// Params 1
// Checksum 0x9fa43978, Offset: 0x54b
// Size: 0x25
function addsmartobjectoutroanim( alias )
{
    addsmartobjectanim_internal( "smartobject_outro", alias );
    self.hasoutro = 1;
}

// Namespace utility
// Params 0
// Checksum 0xd90fa86c, Offset: 0x578
// Size: 0xd
function addsmartobjectarrivalanims()
{
    self.hasarrivals = 1;
}

// Namespace utility
// Params 0
// Checksum 0x5e74ea28, Offset: 0x58d
// Size: 0xd
function addsmartobjectexitanims()
{
    self.hasexits = 1;
}

// Namespace utility
// Params 1
// Checksum 0x25960e10, Offset: 0x5a2
// Size: 0x2b
function addsmartobjectpainanim( alias )
{
    if ( isdefined( alias ) )
    {
        addsmartobjectanim_internal( "smartobject_pain", alias );
    }
    
    self.haspain = 1;
}

// Namespace utility
// Params 1
// Checksum 0xd1b97124, Offset: 0x5d5
// Size: 0x2b
function addsmartobjectdeathanim( alias )
{
    if ( isdefined( alias ) )
    {
        addsmartobjectanim_internal( "smartobject_death", alias );
    }
    
    self.hasdeath = 1;
}

// Namespace utility
// Params 1
// Checksum 0x6f39523b, Offset: 0x608
// Size: 0x18
function getsmartobjecttype( name )
{
    return anim.smartobjects[ name ];
}

// Namespace utility
// Params 0
// Checksum 0xdc4d050e, Offset: 0x629
// Size: 0x131
function smartobject_setnextuse()
{
    objtype = getsmartobjecttype( self.script_smartobject );
    info = self [[ objtype.fngetinfo ]]();
    
    if ( isdefined( info.useonce ) )
    {
        self.neveruseagain = 1;
        return;
    }
    
    nextusetime = gettime() + info.nextusetime * 1000;
    self.nextusetime = nextusetime;
    
    if ( isdefined( self.linkedsmartobjects ) )
    {
        foreach ( obj in self.linkedsmartobjects )
        {
            if ( isdefined( obj.nextusetime ) )
            {
                obj.nextusetime = max( obj.nextusetime, nextusetime );
                continue;
            }
            
            obj.nextusetime = nextusetime;
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0x4a7cea4a, Offset: 0x762
// Size: 0x44
function claimsmartobject( obj )
{
    assert( !isdefined( obj.claimer ) || obj.claimer == self, "<dev string:x4a>" );
    obj.claimer = self;
}

// Namespace utility
// Params 1
// Checksum 0x94f6f73b, Offset: 0x7ae
// Size: 0x42
function unclaimsmartobject( obj )
{
    assert( !isdefined( obj.claimer ) || obj.claimer == self, "<dev string:x77>" );
    obj.claimer = undefined;
}

// Namespace utility
// Params 1
// Checksum 0x6af72b0e, Offset: 0x7f8
// Size: 0x19, Type: bool
function canclaimsmartobject( obj )
{
    return !isdefined( obj.claimer );
}

// Namespace utility
// Params 1
// Checksum 0xe93ec143, Offset: 0x81a
// Size: 0x7a
function canusesmartobject( obj )
{
    if ( obj.donotuse )
    {
        return 0;
    }
    
    if ( isdefined( obj.neveruseagain ) )
    {
        return 0;
    }
    
    if ( gettime() < obj.nextusetime )
    {
        return 0;
    }
    
    objbp = getsmartobjecttype( obj.script_smartobject );
    result = [[ objbp.fnusecondition ]]( obj );
    return result;
}

// Namespace utility
// Params 3
// Checksum 0xf1dae81f, Offset: 0x89d
// Size: 0x102
function getbestsmartobject( desiredpos, volume, var_aac03fbd5dcff647 )
{
    if ( !isdefined( anim.smartobjectpoints ) )
    {
        return;
    }
    
    var_c1f081ffb6ed7ef7 = var_aac03fbd5dcff647 * var_aac03fbd5dcff647;
    allsmartobjects = sortbydistance( anim.smartobjectpoints, desiredpos );
    numsmartobjects = allsmartobjects.size;
    
    for ( iobj = 0; iobj < numsmartobjects ; iobj++ )
    {
        object = allsmartobjects[ iobj ];
        
        if ( distancesquared( object.origin, desiredpos ) > var_c1f081ffb6ed7ef7 )
        {
            break;
        }
        
        if ( !canclaimsmartobject( object ) )
        {
            continue;
        }
        
        if ( !canusesmartobject( object ) )
        {
            continue;
        }
        
        if ( !issmartobjectwithinrange( object, desiredpos, volume ) )
        {
            continue;
        }
        
        objbp = getsmartobjecttype( object.script_smartobject );
        
        if ( [[ objbp.fnusecondition ]]( object ) )
        {
            return object;
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0x771efb18, Offset: 0x9a8
// Size: 0x126, Type: bool
function isplayernearsmartobject( obj )
{
    radiussq = 1600;
    zdiffsq = 4096;
    
    foreach ( player in level.players )
    {
        if ( distance2dsquared( obj.origin, player.origin ) < radiussq && squared( obj.origin[ 2 ] - player.origin[ 2 ] ) < zdiffsq )
        {
            objtoplayeryaw = vectortoyaw( player.origin - obj.origin );
            
            if ( abs( angleclamp180( objtoplayeryaw - obj.angles[ 1 ] ) ) < 90 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace utility
// Params 7
// Checksum 0x34f633af, Offset: 0xad7
// Size: 0x9cd
function getbestsmartobjectalongline( startpos, endpos, region, volume, var_2c1fec3f1319ae6c, var_48f31087817969a9, var_21c04db07d15c1a9 )
{
    if ( !isdefined( anim.smartobjectpoints ) )
    {
        return;
    }
    
    var_cd43d2f6305a3dc4 = 60;
    clineheight = 60;
    var_d89601b7d992830d = 5184;
    var_84a9b9b2491a9182 = 48;
    
    if ( isdefined( region.volume.script_radius ) )
    {
        var_84a9b9b2491a9182 = region.volume.script_radius;
    }
    
    var_1d03c21a061a73a5 = 128;
    
    if ( isdefined( region.volume.script_maxdist ) )
    {
        var_1d03c21a061a73a5 = region.volume.script_maxdist;
    }
    
    starttoend = endpos - startpos;
    linelen = length( starttoend );
    starttoenddir = starttoend / linelen;
    starttoendnormal = vectornormalize( ( starttoenddir[ 1 ], -1 * starttoenddir[ 0 ], 0 ) );
    bdrawdebug = 0;
    drawtime = undefined;
    
    /#
        drawtime = 40;
        bdrawdebug = getdvarint( @"hash_e24fb561372dfef1", -1 ) == self getentitynumber();
        
        if ( bdrawdebug )
        {
            line( startpos + ( 0, 0, 6 ), endpos + ( 0, 0, 6 ), ( 0, 0.5, 0.7 ), 1, 0, drawtime );
        }
    #/
    
    var_b6a9de5d12e6ef29 = 60;
    var_31b94fe68a5005cc = 5;
    var_3e2a97f1632acece = 0.33;
    var_82c583b13dcc5561 = 1.5;
    var_a0e751101fb3727f = 300000;
    var_d5ed334f352d2e1c = 0.001;
    bestobj = undefined;
    bestobjscore = -9999;
    
    foreach ( obj in region.smart_objects )
    {
        if ( distancesquared( obj.origin, self.origin ) < var_d89601b7d992830d )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xa9>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        if ( !canclaimsmartobject( obj ) )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xad>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        if ( !var_21c04db07d15c1a9 && !canusesmartobject( obj ) )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xb1>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        var_491a91ba25cbaf88 = obj.origin - startpos;
        distdownline = vectordot( starttoenddir, var_491a91ba25cbaf88 );
        
        if ( distdownline < var_2c1fec3f1319ae6c )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xb6>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        if ( distdownline > linelen + var_cd43d2f6305a3dc4 )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xba>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        distfromline = abs( vectordot( starttoendnormal, var_491a91ba25cbaf88 ) );
        objradiussq = getsmartobjectradiussq( obj );
        
        if ( distfromline * distfromline > objradiussq )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xbe>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        var_46dd2fe38cda1e3a = var_1d03c21a061a73a5;
        
        if ( linelen - distfromline < 60 )
        {
            var_46dd2fe38cda1e3a *= 0.5;
        }
        
        if ( distfromline > var_46dd2fe38cda1e3a )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xc0>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        if ( isdefined( volume ) && !ispointinvolume( obj.origin, volume ) )
        {
            /#
                if ( bdrawdebug )
                {
                    orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.9, 0.4, 0 ), 0, drawtime );
                    print3d( obj.origin + ( 0, 0, 24 ), "<dev string:xc4>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
            
            continue;
        }
        
        objbp = getsmartobjecttype( obj.script_smartobject );
        adjustedlinelen = linelen - var_2c1fec3f1319ae6c;
        var_dd263590a88b77fe = distdownline - var_2c1fec3f1319ae6c;
        var_71b7a7f2973e46f3 = var_48f31087817969a9 - var_2c1fec3f1319ae6c;
        
        if ( var_dd263590a88b77fe < var_71b7a7f2973e46f3 )
        {
            score = var_31b94fe68a5005cc + var_b6a9de5d12e6ef29 * ( 1 - ( var_71b7a7f2973e46f3 - var_dd263590a88b77fe ) / var_71b7a7f2973e46f3 );
        }
        else
        {
            adjustedlinelen = linelen - var_48f31087817969a9 + var_cd43d2f6305a3dc4;
            var_dd263590a88b77fe = distdownline - var_48f31087817969a9;
            score = var_31b94fe68a5005cc + var_b6a9de5d12e6ef29 * ( adjustedlinelen - var_dd263590a88b77fe ) / adjustedlinelen;
        }
        
        if ( distfromline > var_84a9b9b2491a9182 )
        {
            distfrompreferred = distfromline - var_84a9b9b2491a9182;
            score *= var_3e2a97f1632acece + ( 1 - distfrompreferred / ( var_46dd2fe38cda1e3a - var_84a9b9b2491a9182 ) ) * ( 1 - var_3e2a97f1632acece );
        }
        
        if ( isplayernearsmartobject( obj ) )
        {
            score *= var_82c583b13dcc5561;
            
            /#
                if ( bdrawdebug )
                {
                    print3d( obj.origin + ( 0, 0, 20 ), "<dev string:xc9>", ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
                }
            #/
        }
        
        objinfo = obj [[ objbp.fngetinfo ]]();
        
        if ( isdefined( objinfo.fngetprioritymultiplier ) )
        {
            score *= self [[ objinfo.fngetprioritymultiplier ]]( obj );
        }
        
        if ( isdefined( obj.lastusetime ) )
        {
            if ( gettime() - obj.lastusetime < var_a0e751101fb3727f )
            {
                score *= var_d5ed334f352d2e1c;
            }
            else
            {
                obj.lastusetime = undefined;
            }
        }
        
        if ( score > bestobjscore )
        {
            bestobjscore = score;
            bestobj = obj;
        }
        
        /#
            if ( bdrawdebug )
            {
                orientedbox( obj.origin + ( 0, 0, 32 ), ( 12, 12, 12 ), obj.angles, ( 0.8, 0.8, 0 ), 0, drawtime );
                print3d( obj.origin + ( 0, 0, 24 ), string( score ), ( 0.5, 0.5, 0.5 ), 1, 0.2, drawtime );
            }
        #/
    }
    
    return bestobj;
}

// Namespace utility
// Params 1
// Checksum 0x409b0a35, Offset: 0x14ad
// Size: 0xb1
function getsmartobjectradiussq( obj )
{
    if ( isdefined( obj.radius ) )
    {
        return ( obj.radius * obj.radius );
    }
    
    objtype = anim.smartobjects[ obj.script_smartobject ];
    objinfo = [[ objtype.fngetinfo ]]();
    
    if ( isdefined( objinfo.radius ) )
    {
        return ( objinfo.radius * objinfo.radius );
    }
    
    assert( isdefined( objinfo.radiussqrd ) );
    return objinfo.radiussqrd;
}

// Namespace utility
// Params 3
// Checksum 0x99696b8d, Offset: 0x1567
// Size: 0xed, Type: bool
function issmartobjectwithinrange( object, optorigin, volume )
{
    if ( isdefined( optorigin ) )
    {
        pos = optorigin;
    }
    else
    {
        pos = self.origin;
    }
    
    distsqrd = distancesquared( pos, object.origin );
    
    if ( isdefined( object.radius ) )
    {
        if ( distsqrd > squared( object.radius ) )
        {
            return false;
        }
    }
    else
    {
        type = anim.smartobjects[ object.script_smartobject ];
        info = [[ type.fngetinfo ]]();
        
        if ( distsqrd > info.radiussqrd )
        {
            return false;
        }
    }
    
    if ( isdefined( volume ) && !ispointinvolume( object.origin, volume ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility
// Params 1
// Checksum 0x4c1fcba0, Offset: 0x165d
// Size: 0x91
function setcustomsmartobjectarrivaldata( obj )
{
    objbp = getsmartobjecttype( obj.script_smartobject );
    info = [[ objbp.fngetinfo ]]();
    
    if ( !info.hasarrivals )
    {
        return;
    }
    
    self.customarrivalangles = obj.angles;
    self.customarrivalstate = info.animstatename;
    self.var_4568897d5b592329 = 1;
    self.customarrivaloptionalprefix = "arrival";
}

// Namespace utility
// Params 1
// Checksum 0xb6bf4d8b, Offset: 0x16f6
// Size: 0x3f
function setsmartobject( smartobj )
{
    prevsmartobj = asm_bb::bb_getrequestedsmartobject();
    
    if ( isdefined( prevsmartobj ) )
    {
        clearsmartobject( prevsmartobj );
    }
    
    claimsmartobject( smartobj );
    asm_bb::bb_requestsmartobject( smartobj );
}

// Namespace utility
// Params 1
// Checksum 0x6a45a127, Offset: 0x173d
// Size: 0x22
function clearsmartobject( smartobj )
{
    if ( isdefined( smartobj ) )
    {
        unclaimsmartobject( smartobj );
    }
    
    asm_bb::bb_clearsmartobject();
}

// Namespace utility
// Params 1
// Checksum 0xb5d98f15, Offset: 0x1767
// Size: 0x4e, Type: bool
function canusesmartobject_stealth( smartobj )
{
    if ( !isdefined( self.script_stealthgroup ) )
    {
        return false;
    }
    
    if ( ![[ self.fnisinstealthinvestigate ]]() && ![[ self.fnisinstealthhunt ]]() )
    {
        return false;
    }
    
    if ( isdefined( self.enemy ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility
// Params 1
// Checksum 0x49ea16c2, Offset: 0x17be
// Size: 0xb4, Type: bool
function canusesmartobject_nostrafenoturn( smartobj )
{
    forward = anglestoforward( self.angles );
    normal = vectornormalize( smartobj.origin - self.origin );
    
    if ( vectordot( forward, normal ) >= cos( 60 ) )
    {
        strafedist = 64;
    }
    else
    {
        strafedist = 100;
    }
    
    if ( distancesquared( self.origin, smartobj.origin ) <= strafedist * strafedist )
    {
        return false;
    }
    
    forward = anglestoforward( smartobj.angles );
    
    if ( vectordot( forward, normal ) < cos( 45 ) )
    {
        return false;
    }
    
    return true;
}

