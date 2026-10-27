// script_4bf17c7c52d3ed18  (hash_4bf17c7c52d3ed18.gscc) (size: 11340 Bytes / 0x2c4c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe6e18d69 (3873541481)
// size ...... 11340 (0x2c4c)
// includes .. 8   (offset: 0x2a7c)
// strings ... 25  (offset: 0x2abc)
// dev strs .. 2   (offset: 0x2c34)
// exports ... 27  (offset: 0x1b60)
// cseg ...... 0x1df + 0x1981 (0x1b60)
// imports ... 91  (offset: 0x1f98)
// animtree1 . 0   (offset: 0x2c4c)
// animtree2 . 0   (offset: 0x2c4c)
#using script_9d7b1b99a878301;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_hazard_tornado;

// Namespace ztron_hazard_tornado
// Params 0, eflags: 0x5
// Checksum 0x75554eb, Offset: 0x1fd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_tornado", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_tornado
// Params 0
// Checksum 0xfe0681bd, Offset: 0x226
// Size: 0x66
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"tornado", #"create", &function_a65aed73a5cdc122 );
    ztron_hazard::function_6f661fac5fd31f1( #"tornado", #"arenaspawn", &function_79751ddb57ba61df );
    level.ztron.tornadopool = [];
    ztron_sound::function_4ac735395b173fe( "ztron_tornado_spinning_lp", "evt_ztron_hazard_tornado_lp", 1 );
}

// Namespace ztron_hazard_tornado
// Params 0
// Checksum 0xbff6a546, Offset: 0x294
// Size: 0x9c
function function_79751ddb57ba61df()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "tornado" );
    
    foreach ( var_4d080f710fb8349e in hazards )
    {
        function_a65aed73a5cdc122( var_4d080f710fb8349e );
    }
}

// Namespace ztron_hazard_tornado
// Params 2
// Checksum 0x656eda9c, Offset: 0x338
// Size: 0x27
function function_a65aed73a5cdc122( trap, paged )
{
    function_5e41eb3e262f466( trap );
    trap thread function_428a48504a190006();
}

// Namespace ztron_hazard_tornado
// Params 0
// Checksum 0xe106c028, Offset: 0x367
// Size: 0x65
function function_428a48504a190006()
{
    self.moving_state = 0;
    self.var_ea4c8511f73c0117 = [];
    function_9ee825c3c83e3ab1();
    thread movingthink( self.moveorg );
    thread effectthink();
    thread function_84071e36a4c99c84();
    level.ztron.tornadopool[ level.ztron.tornadopool.size ] = self;
}

// Namespace ztron_hazard_tornado
// Params 0
// Checksum 0x87a95519, Offset: 0x3d4
// Size: 0x1ee
function function_9ee825c3c83e3ab1()
{
    scriptable = spawnscriptable( "ztron_tornado", self.origin );
    mover = spawn( "script_model", self.origin );
    mover setmodel( "tag_origin" );
    self.moveorg = mover;
    self.scriptable = scriptable;
    self.var_234c25b58673e9b6 = 25;
    self.var_7a2b37fd58781e39 = 5;
    mover.script_noteworthy = "hazard_tornado";
    trigger = spawn( "trigger_radius", self.origin, 0, 120, 200 );
    trigger.owner = mover;
    trigger enablelinkto();
    trigger linkto( self.moveorg );
    self.trigger = trigger;
    
    /#
        thread function_86b1295d75bb64e3( trigger );
    #/
    
    waitframe();
    scriptable scriptablesetparententity( mover );
    ztron_sound::ztron_playsound( "ztron_tornado_spinning_lp", undefined, self.moveorg );
    self.moveorg.var_94aa2bee2b8fd1c2 = squared( 120 );
    self.moveorg.var_9e9f4765a006b71c = &function_b8bbefc1e043bb4;
    level.ztron.activeattractors[ level.ztron.activeattractors.size ] = self.moveorg;
    self.moveorg thread function_6b62b93629fb96e5();
    targetstate = self.elementtype + "_tornado_actived";
    
    if ( scriptable getscriptableparthasstate( "visual", targetstate ) )
    {
        scriptable setscriptablepartstate( "visual", targetstate );
    }
    
    switch ( self.elementtype )
    {
        case #"hash_47276d6c2f4cfd60":
            self.var_25513b2a68d9dbb6 = "MOD_ELEMENTAL_COLD";
            break;
        default:
            return;
    }
}

// Namespace ztron_hazard_tornado
// Params 0
// Checksum 0xdb7eecf8, Offset: 0x5ca
// Size: 0x136
function function_6b62b93629fb96e5()
{
    self endon( #"death" );
    var_5a4a9800c6694eec = 576;
    
    while ( true )
    {
        if ( level.ztron.itemdef.spawneditems.size > 0 )
        {
            pickups = sortbydistance( level.ztron.itemdef.spawneditems, self.origin );
            
            foreach ( pickup in pickups )
            {
                distsq = distancesquared( pickup.origin, self.origin );
                
                if ( distsq > var_5a4a9800c6694eec )
                {
                    break;
                }
                
                pickup thread ztron_item::function_f580915d21ddba69( undefined, self.origin + ( 0, 0, 1400 ) );
            }
        }
        
        wait 0.25;
    }
}

// Namespace ztron_hazard_tornado
// Params 1
// Checksum 0xb2c56447, Offset: 0x708
// Size: 0x1b3
function function_5e41eb3e262f466( trap )
{
    var_2c5099d703c7da38 = [];
    args = strtok( trap.script_label, ";" );
    trap.moving_mode = 0;
    
    if ( args.size > 0 )
    {
        if ( args[ 0 ] == "loop" )
        {
            trap.moving_mode = 0;
        }
        else if ( args[ 0 ] == "reverse" )
        {
            trap.moving_mode = 1;
        }
    }
    
    if ( args.size > 1 )
    {
        trap.elementtype = args[ 1 ];
    }
    
    if ( args.size > 2 )
    {
        trap.forcespeed = float( args[ 2 ] );
    }
    
    for ( var_8eb4e8e8198e4341 = trap; true ; var_8eb4e8e8198e4341 = next_node )
    {
        if ( !isdefined( var_8eb4e8e8198e4341 ) || arraycontains( var_2c5099d703c7da38, var_8eb4e8e8198e4341 ) )
        {
            assert( 0, "<dev string:x24>" );
            break;
        }
        
        var_2c5099d703c7da38[ var_2c5099d703c7da38.size ] = var_8eb4e8e8198e4341;
        args = strtok( var_8eb4e8e8198e4341.script_parameters, ";" );
        assert( args.size < 4, "<dev string:x3f>" );
        var_8eb4e8e8198e4341.var_c6db5c05a5f1e16e = float( args[ 0 ] );
        
        if ( !isdefined( trap.forcespeed ) )
        {
            var_8eb4e8e8198e4341.var_9b703e3ad83159ff = float( args[ 1 ] );
        }
        
        if ( !isdefined( var_8eb4e8e8198e4341.target ) )
        {
            break;
        }
        
        next_node = utility::getstruct( var_8eb4e8e8198e4341.target, "targetname" );
        
        if ( !isdefined( next_node ) )
        {
            break;
        }
        
        next_node.pre_node = var_8eb4e8e8198e4341;
        var_8eb4e8e8198e4341.next_node = next_node;
    }
}

// Namespace ztron_hazard_tornado
// Params 1, eflags: 0x4
// Checksum 0x949f9779, Offset: 0x8c3
// Size: 0x18, Type: bool
function private function_b8bbefc1e043bb4( item )
{
    return !item.inuse;
}

// Namespace ztron_hazard_tornado
// Params 1
// Checksum 0x620012bb, Offset: 0x8e4
// Size: 0x38a
function movingthink( tornado_entity )
{
    self notify( #"hash_21018838eb7e9e29" );
    self endon( #"hash_21018838eb7e9e29" );
    self endon( #"destroy_hazard" );
    tornado_entity endon( #"death" );
    var_8eb4e8e8198e4341 = self;
    var_c8ee3a2698889857 = 1;
    
    while ( true )
    {
        if ( !isdefined( var_8eb4e8e8198e4341 ) )
        {
            break;
        }
        
        next_node = ztron_hazard_moving_platform::getnextnode( var_8eb4e8e8198e4341 );
        
        if ( !next_node )
        {
            break;
        }
        
        wait_time = function_35069fe49b882c34( var_8eb4e8e8198e4341.var_c6db5c05a5f1e16e );
        wait wait_time;
        var_8eb4e8e8198e4341.nodedistance = distance( next_node.origin, var_8eb4e8e8198e4341.origin );
        var_8eb4e8e8198e4341.forward = vectornormalize( next_node.origin - var_8eb4e8e8198e4341.origin );
        up = ( 0, 0, 1 );
        var_8eb4e8e8198e4341.rightdir = vectorcross( var_8eb4e8e8198e4341.forward, up );
        pathpoints = [];
        nodedistance = var_8eb4e8e8198e4341.nodedistance;
        totaldistance = 0;
        lastpoint = var_8eb4e8e8198e4341.origin;
        
        while ( nodedistance > 0 )
        {
            var_74cadbc5910f549e = nodedistance;
            
            if ( nodedistance > 200 )
            {
                var_74cadbc5910f549e = clamp( 200, 0, nodedistance );
                
                if ( var_74cadbc5910f549e + 200 > nodedistance )
                {
                    var_74cadbc5910f549e = nodedistance;
                }
            }
            
            rightoffset = var_c8ee3a2698889857 * randomfloatrange( 100, 140 ) * var_8eb4e8e8198e4341.rightdir;
            var_c8ee3a2698889857 *= -1;
            forwardoffset = 0.5 * var_74cadbc5910f549e * var_8eb4e8e8198e4341.forward;
            midpoint = lastpoint + forwardoffset;
            endpoint = lastpoint + 2 * forwardoffset;
            deltadegree = 18;
            
            for ( pointindex = 1; pointindex <= 10 ; pointindex++ )
            {
                curdegree = -180 + deltadegree * pointindex;
                point = midpoint + rightoffset * sin( curdegree ) + forwardoffset * cos( curdegree );
                pathpoints[ pathpoints.size ] = point;
                totaldistance += distance( lastpoint, point );
                lastpoint = point;
            }
            
            nodedistance -= var_74cadbc5910f549e;
        }
        
        startpoint = var_8eb4e8e8198e4341.origin;
        
        /#
            tornado_entity thread function_4d6d49f5af12e9( pathpoints, startpoint );
        #/
        
        foreach ( nextpoint in pathpoints )
        {
            move_time = undefined;
            pathlen = distance( startpoint, nextpoint );
            
            if ( isdefined( self.forcespeed ) )
            {
                move_time = pathlen / self.forcespeed;
            }
            else
            {
                move_time = var_8eb4e8e8198e4341.var_9b703e3ad83159ff * pathlen / totaldistance;
            }
            
            move_time = function_776e394afde5b6e8( move_time );
            tornado_entity moveto( nextpoint, move_time );
            tornado_entity waittill( #"movedone" );
            startpoint = nextpoint;
        }
        
        tornado_entity notify( #"hash_a328eb377101ca4b" );
        var_8eb4e8e8198e4341 = next_node;
    }
}

// Namespace ztron_hazard_tornado
// Params 1, eflags: 0x4
// Checksum 0x8c97e6d4, Offset: 0xc76
// Size: 0x40
function private function_35069fe49b882c34( waittime )
{
    randomint = randomint( 100 );
    
    if ( randomint < 30 )
    {
        waittime *= 3;
    }
    else if ( randomint < 80 )
    {
        waittime *= 0;
    }
    
    return waittime;
}

// Namespace ztron_hazard_tornado
// Params 1, eflags: 0x4
// Checksum 0xa1ca27a1, Offset: 0xcbf
// Size: 0x44
function private function_776e394afde5b6e8( movetime )
{
    randomint = randomint( 100 );
    
    if ( randomint < 40 )
    {
        movetime *= 2;
    }
    else if ( randomint < 70 )
    {
        movetime *= 0.6;
    }
    
    return movetime;
}

// Namespace ztron_hazard_tornado
// Params 0
// Checksum 0x498c37ff, Offset: 0xd0c
// Size: 0x221
function function_84071e36a4c99c84()
{
    self notify( #"hash_663dc37f19827514" );
    self endon( #"hash_663dc37f19827514" );
    thread ztron_hazard::function_4d643b159a80c647( 1 );
    level endon( #"ztron_game_is_over" );
    self waittill( #"destroy_hazard" );
    
    foreach ( entdata in self.var_ea4c8511f73c0117 )
    {
        ent = entdata.entity;
        ent function_25cecc0ae7c50b15();
    }
    
    foreach ( player in level.players )
    {
        if ( player isslowed() )
        {
            player function_25cecc0ae7c50b15();
        }
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable freescriptable();
        self.scriptable = undefined;
    }
    
    if ( isdefined( self.moveorg ) )
    {
        level.ztron.activeattractors = arrayremove( level.ztron.activeattractors, self.moveorg );
        ztron_sound::ztron_stopsound( self.moveorg );
        self.moveorg delete();
        self.moveorg = undefined;
    }
    
    level.ztron.tornadopool = arrayremove( level.ztron.tornadopool, self );
}

// Namespace ztron_hazard_tornado
// Params 0
// Checksum 0xddea5505, Offset: 0xf35
// Size: 0x4a5
function effectthink()
{
    self notify( #"hash_6bda0c364d465e35" );
    self endon( #"hash_6bda0c364d465e35" );
    self endon( #"destroy_hazard" );
    
    while ( true )
    {
        tornadoorigin = self.moveorg.origin;
        currenttime = gettime();
        searchrange = max( 120, 200 ) * 2;
        aiinrange = getaiarrayinradius( tornadoorigin, searchrange );
        nearbycharacters = [];
        
        foreach ( ai in aiinrange )
        {
            if ( ai istouching( self.trigger ) && ai.health > 0 )
            {
                nearbycharacters[ nearbycharacters.size ] = ai;
            }
        }
        
        foreach ( player in level.players )
        {
            if ( player istouching( self.trigger ) )
            {
                nearbycharacters[ nearbycharacters.size ] = player;
                continue;
            }
            
            if ( player isslowed() )
            {
                player function_f8ee5aaecf5989cf();
            }
        }
        
        foreach ( entdata in self.var_ea4c8511f73c0117 )
        {
            ent = entdata.entity;
            
            if ( !arraycontains( nearbycharacters, ent ) )
            {
                if ( isdefined( ent ) )
                {
                    ent function_f8ee5aaecf5989cf();
                }
                
                self.var_ea4c8511f73c0117 = arrayremove( self.var_ea4c8511f73c0117, entdata );
            }
        }
        
        foreach ( ent in nearbycharacters )
        {
            if ( !isalive( ent ) )
            {
                continue;
            }
            
            if ( isbot( ent ) )
            {
                continue;
            }
            
            if ( ent.ztron.boss || ent.no_hazards )
            {
                continue;
            }
            
            if ( self.var_25513b2a68d9dbb6 == "MOD_ELEMENTAL_COLD" )
            {
                var_e5557a1483620915 = ent function_39bd7e33ebb3d54c();
                var_6fab6266b5f636c3 = ent isslowed();
                
                if ( !var_6fab6266b5f636c3 && !var_e5557a1483620915 )
                {
                    ent slowentity();
                    waitframe();
                    
                    if ( !isalive( ent ) )
                    {
                        continue;
                    }
                }
                
                if ( !isdefined( ent.frost_blast_time ) )
                {
                    ent.frost_blast_time = gettime();
                }
                
                freeze_threshold = 250;
                
                if ( currenttime - ent.frost_blast_time >= freeze_threshold )
                {
                    if ( !var_e5557a1483620915 )
                    {
                        if ( ent function_5e666cd92b35310b() )
                        {
                            ent freezeai( 2, self );
                        }
                    }
                }
            }
            
            if ( !isdefined( self.var_ea4c8511f73c0117[ ent getentitynumber() ] ) )
            {
                var_c2fe17f46f198981 = spawnstruct();
                var_c2fe17f46f198981.entity = ent;
                var_c2fe17f46f198981.var_c0a676cdda251cae = 0;
                self.var_ea4c8511f73c0117[ ent getentitynumber() ] = var_c2fe17f46f198981;
            }
            
            entdata = self.var_ea4c8511f73c0117[ ent getentitynumber() ];
            deltatime = currenttime - entdata.var_c0a676cdda251cae;
            
            if ( deltatime >= 500 )
            {
                var_ca474cbf87a61fc8 = isplayer( ent ) ? self.var_234c25b58673e9b6 : self.var_7a2b37fd58781e39;
                ent dodamage( var_ca474cbf87a61fc8, ent.origin, undefined, undefined, self.var_25513b2a68d9dbb6 );
                entdata.var_c0a676cdda251cae = currenttime;
            }
        }
        
        waitframe();
    }
}

// Namespace ztron_hazard_tornado
// Params 0, eflags: 0x4
// Checksum 0x2f0b48ee, Offset: 0x13e2
// Size: 0xe6
function private slowentity()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.no_hazards || self.ztron.boss )
    {
        return;
    }
    
    if ( isai( self ) && self.health > 0 )
    {
        if ( self isscriptable() && self getscriptablehaspart( "cryofreeze" ) )
        {
            utility::function_32b24db3127bff40( "cryofreeze", "cryofreeze_on" );
        }
        
        if ( !effect_slow::function_6fab6266b5f636c3() )
        {
            effect_slow::slow( "ztron_tornado_ice", 0.7, 9999, undefined, undefined, 1, "cold" );
        }
        
        return;
    }
    
    if ( isplayer( self ) )
    {
        if ( self isscriptable() && self getscriptablehaspart( "ltm_mode_fx" ) )
        {
            utility::function_32b24db3127bff40( "ltm_mode_fx", "jh_freeze_on" );
        }
        
        if ( !ztron_hazard::function_8131aea7eb196354( "ztron_tornado_ice" ) )
        {
            ztron_hazard::function_4512b7715789e4cf( "ztron_tornado_ice", 0.7, 1 );
        }
    }
}

// Namespace ztron_hazard_tornado
// Params 0, eflags: 0x4
// Checksum 0xd31d872, Offset: 0x14d0
// Size: 0xaa
function private function_25cecc0ae7c50b15()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isai( self ) && self.health > 0 )
    {
        if ( self isscriptable() && self getscriptablehaspart( "cryofreeze" ) )
        {
            utility::function_32b24db3127bff40( "cryofreeze", "cryofreeze_shatter" );
        }
        
        if ( effect_slow::function_6fab6266b5f636c3() )
        {
            effect_slow::function_80a4bd13b5ba303a( "ztron_tornado_ice" );
        }
        
        return;
    }
    
    if ( isplayer( self ) )
    {
        if ( self isscriptable() && self getscriptablehaspart( "ltm_mode_fx" ) )
        {
            utility::function_32b24db3127bff40( "ltm_mode_fx", "jh_freeze_off" );
        }
        
        if ( ztron_hazard::function_8131aea7eb196354( "ztron_tornado_ice" ) )
        {
            ztron_hazard::function_986fc44dada307f4( "ztron_tornado_ice", 1 );
        }
    }
}

// Namespace ztron_hazard_tornado
// Params 2
// Checksum 0xc02bb1e9, Offset: 0x1582
// Size: 0x256
function create_tornado( origin, points = [] )
{
    origin += ( 100, 100, 20 );
    trap = spawnstruct();
    trap.origin = origin;
    trap.angles = ( 0, 0, 0 );
    trap.var_c6db5c05a5f1e16e = 0;
    trap.var_9b703e3ad83159ff = 5;
    trap.moving_mode = 0;
    trap.elementtype = "ice";
    
    if ( points.size )
    {
        curlink = trap;
        
        foreach ( point in points )
        {
            new_link = spawnstruct();
            new_link.origin = point;
            new_link.var_c6db5c05a5f1e16e = randomint( 6 );
            new_link.var_9b703e3ad83159ff = randomintrange( 3, 12 );
            new_link.pre_node = curlink;
            curlink.next_node = new_link;
            curlink = new_link;
        }
        
        trap.pre_node = curlink;
    }
    else
    {
        var_8e8c35e597ce9817 = spawnstruct();
        var_8e8c35e597ce9817.origin = origin + ( 300, 0, 0 );
        var_8e8c35e597ce9817.var_c6db5c05a5f1e16e = 0;
        var_8e8c35e597ce9817.var_9b703e3ad83159ff = 5;
        var_8e8c36e597ce9a4a = spawnstruct();
        var_8e8c36e597ce9a4a.origin = origin + ( -300, 0, 0 );
        var_8e8c36e597ce9a4a.var_c6db5c05a5f1e16e = 0;
        var_8e8c36e597ce9a4a.var_9b703e3ad83159ff = 5;
        trap.next_node = var_8e8c35e597ce9817;
        var_8e8c35e597ce9817.pre_node = trap;
        var_8e8c35e597ce9817.next_node = var_8e8c36e597ce9a4a;
        var_8e8c36e597ce9a4a.pre_node = var_8e8c35e597ce9817;
    }
    
    trap thread function_428a48504a190006();
}

// Namespace ztron_hazard_tornado
// Params 0, eflags: 0x4
// Checksum 0x7e12eeb1, Offset: 0x17e0
// Size: 0x38
function private isslowed()
{
    if ( isai( self ) && self.health > 0 )
    {
        return effect_slow::function_6fab6266b5f636c3();
    }
    else if ( isplayer( self ) )
    {
        return ztron_hazard::function_8131aea7eb196354( "ztron_tornado_ice" );
    }
    
    return 0;
}

// Namespace ztron_hazard_tornado
// Params 0, eflags: 0x4
// Checksum 0xa1fcfe8a, Offset: 0x1821
// Size: 0xe9
function private function_f8ee5aaecf5989cf()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_136868e5bcb913a = 0;
    
    foreach ( tornado in level.ztron.tornadopool )
    {
        if ( tornado.elementtype == "ice" && distance( self.origin, tornado.moveorg.origin ) <= 120 )
        {
            var_136868e5bcb913a = 1;
            break;
        }
    }
    
    if ( !var_136868e5bcb913a && isslowed() )
    {
        function_25cecc0ae7c50b15();
    }
}

// Namespace ztron_hazard_tornado
// Params 0
// Checksum 0x9590b8ed, Offset: 0x1912
// Size: 0x18, Type: bool
function function_5e666cd92b35310b()
{
    if ( self.aicategory === "normal" )
    {
        return true;
    }
    
    return false;
}

// Namespace ztron_hazard_tornado
// Params 2, eflags: 0x40 variadic
// Checksum 0x9fe40b46, Offset: 0x1933
// Size: 0x24
function function_c2675bfd286f4264( ... )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    function_b9f429160573e518( 0 );
}

// Namespace ztron_hazard_tornado
// Params 2
// Checksum 0x96662b47, Offset: 0x195f
// Size: 0x5f
function freezeai( duration = 1, attacker )
{
    if ( !isai( self ) || self.health <= 0 )
    {
        return;
    }
    
    effect_slow::slow( "ztron_tornado_ice", 0.0001, duration, attacker, &function_c2675bfd286f4264, undefined, "cold" );
    function_b9f429160573e518( 1 );
}

// Namespace ztron_hazard_tornado
// Params 0
// Checksum 0xa28e39d2, Offset: 0x19c6
// Size: 0xb
function function_39bd7e33ebb3d54c()
{
    return self.var_d38d54be3229c829;
}

// Namespace ztron_hazard_tornado
// Params 1
// Checksum 0xbca18e8e, Offset: 0x19da
// Size: 0x17
function function_b9f429160573e518( value )
{
    self.var_d38d54be3229c829 = value;
}

/#

    // Namespace ztron_hazard_tornado
    // Params 1, eflags: 0x4
    // Checksum 0x92562c88, Offset: 0x19f9
    // Size: 0x76, Type: dev
    function private function_86b1295d75bb64e3( trigger )
    {
        level endon( #"ztron_game_is_over" );
        self endon( #"destroy_hazard" );
        trigger endon( #"death" );
        
        while ( isdefined( trigger ) )
        {
            if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
            {
                drawtrigger( trigger, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace ztron_hazard_tornado
    // Params 2
    // Checksum 0x32fe867a, Offset: 0x1a77
    // Size: 0xe9, Type: dev
    function function_4d6d49f5af12e9( pathpoints, startpoint )
    {
        level endon( #"ztron_game_is_over" );
        self endon( #"hash_a328eb377101ca4b" );
        color = ( 1, 1, 0 );
        
        if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
        {
            while ( true )
            {
                lastposition = startpoint;
                
                foreach ( nextpoint in pathpoints )
                {
                    line( lastposition, nextpoint, color, 1, 0 );
                    lastposition = nextpoint;
                }
                
                waitframe();
            }
        }
    }

#/
