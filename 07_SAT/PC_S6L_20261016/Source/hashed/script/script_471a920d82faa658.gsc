// script_471a920d82faa658  (hash_471a920d82faa658.gscc) (size: 18426 Bytes / 0x47fa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3835d3c1 (943051713)
// size ...... 18426 (0x47fa)
// includes .. 5   (offset: 0x44fa)
// strings ... 40  (offset: 0x4522)
// dev strs .. 5   (offset: 0x47b6)
// exports ... 43  (offset: 0x2fda)
// cseg ...... 0x3d5 + 0x2c05 (0x2fda)
// imports ... 112 (offset: 0x3692)
// animtree1 . 0   (offset: 0x47fa)
// animtree2 . 0   (offset: 0x47fa)
#using script_53651341190c5aab;
#using scripts\asm\asm;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\common\values;

#namespace door_check;

// Namespace door_check
// Params 1
// Checksum 0x8cca143f, Offset: 0x3f3
// Size: 0x1aa
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onuserinit;
        case #"hash_722d767fd6d40f56":
            return &onuserterminate;
        case #"hash_9f9e07224ff2a95a":
            return &calcstartorigin;
        case #"hash_88347dbc54e3c555":
            return &function_d393bc9d5d3cd17d;
        case #"hash_55e74e391a612ea8":
            return &function_c15c3b5c7d9a70bd;
        case #"hash_d8934b522ed927fa":
            return &function_3920913d01f45199;
        case #"hash_818982b14b2af1f":
            return &arrivalsetup;
        case #"hash_3454d29ae45c6cdb":
            return &function_259b37243d1c2960;
        case #"hash_c5687eec52003555":
            return &onarrival;
        case #"hash_e016759d0510a58c":
            return &onbailout;
        case #"hash_d50b41c248a37316":
            return &onenter;
        case #"hash_40c17f88c03792e6":
            return &starthold;
        case #"hash_214ba25246813d79":
            return &function_e111218404c76afa;
        case #"hash_1ac92cc267a9ec26":
            return &goalcheckcleanup;
        case #"hash_f81d03def0fb7e01":
            return &function_a7469b67274c2f36;
        case #"hash_94e93145a62541a4":
            return &function_64f894e6c635e435;
        case #"hash_987435cc91e79a2f":
            return &function_c62577c2f2213500;
        case #"hash_4987e3e091f66f3f":
            return &function_7486427038f518fa;
        case #"hash_b690da55abc2618b":
            return &function_44fe2fbb32cf8ef4;
        case #"hash_1f5510e3c57cb592":
            return &function_7a89264e89571825;
        case #"hash_e49b80982aaa093d":
            return &function_621f73a2676bf992;
        case #"hash_d2352a64914c281a":
            return &function_8dc85eb2dfbe1b79;
    }
    
    return interaction_common::function_d4be89b1cf3d4993( funcid );
}

// Namespace door_check
// Params 1, eflags: 0x4
// Checksum 0x9c97802e, Offset: 0x5a6
// Size: 0x365
function private onuserinit( interactionid )
{
    setdvarifuninitialized( @"hash_6bff7f7a44419fce", 0 );
    
    if ( !isdefined( function_521b5a0a07a246a8( interactionid, "breachtype" ) ) )
    {
        types = [ "breach", "kick" ];
        
        if ( self isincombat() )
        {
            types[ types.size ] = "flashbang";
        }
        
        valid_types = [];
        
        foreach ( type in types )
        {
            if ( self function_8d1306d3e61ee07a( type, "all" ) )
            {
                valid_types[ valid_types.size ] = type;
            }
        }
        
        finaltype = utility::array_random( valid_types );
        function_dd518df9ee8d217c( interactionid, "breachtype", finaltype );
    }
    
    self.doorcheck = spawnstruct();
    
    if ( isdefined( self.node ) )
    {
        self.doorcheck.priornode = self.node;
    }
    else
    {
        self.doorcheck.priorgoalpos = self.pathgoalpos;
    }
    
    self.doorcheck.var_c943bcfb06618f5e = gettime() + 1000;
    self.doorcheck.arrivedtime = 0;
    self.doorcheck.var_4d33a3148606d811 = 0;
    self.doorcheck.exitquietly = 0;
    
    if ( !isdefined( level.bseq ) )
    {
        level.bseq = spawnstruct();
    }
    
    if ( !isdefined( level.bseq.instancedata ) )
    {
        level.bseq.instancedata = [];
    }
    
    if ( !isdefined( level.bseq.instancedata[ interactionid ] ) )
    {
        level.bseq.instancedata[ interactionid ] = spawnstruct();
    }
    
    if ( !isdefined( level.bseq.instancedata[ interactionid ].var_2f9616c549192b68 ) )
    {
        level.bseq.instancedata[ interactionid ].var_2f9616c549192b68 = [];
    }
    
    if ( !isdefined( level.bseq.instancedata[ interactionid ].var_52eaa818341b84c7 ) )
    {
        level.bseq.instancedata[ interactionid ].var_52eaa818341b84c7 = 0;
    }
    
    if ( !isdefined( level.bseq.instancedata[ interactionid ].farpositions ) )
    {
        level.bseq.instancedata[ interactionid ].farpositions = [];
    }
    
    if ( !isdefined( level.bseq.instancedata[ interactionid ].var_6ef2894b2f6b3fa6 ) )
    {
        level.bseq.instancedata[ interactionid ].var_6ef2894b2f6b3fa6 = 0;
    }
    
    level.bseq.instancedata[ interactionid ].holdallowed = 0;
}

// Namespace door_check
// Params 1, eflags: 0x4
// Checksum 0x4d0e4bed, Offset: 0x913
// Size: 0x102
function private onuserterminate( interactionid )
{
    val::reset( "door_check", "script_pushable" );
    val::reset( "door_check", "script_pushable_by_ai" );
    self.doorcheck = undefined;
    self clearbtgoal( 3 );
    self.capdata = undefined;
    self.customarrivalhandler = undefined;
    arrivalcleanup();
    
    if ( self.defaultasm != self.asmname )
    {
        cap::cap_exit();
    }
    
    users = getbsequsers( interactionid );
    
    if ( users.size == 1 )
    {
        doorid = function_521b5a0a07a246a8( interactionid, "doorindex" );
        
        if ( isdefined( doorid ) )
        {
            if ( !level.bseq.instancedata[ interactionid ].bstarted )
            {
                updateroomdoorclaim( doorid, 0 );
            }
            else
            {
                updateroomdoorclaim( doorid, gettime() + 8000 );
            }
        }
        
        level.bseq.instancedata[ interactionid ] = undefined;
    }
}

// Namespace door_check
// Params 2, eflags: 0x4
// Checksum 0x6d904eca, Offset: 0xa1d
// Size: 0x40e
function private calcstartorigin( statename, role )
{
    id = self getinteractionid();
    assert( isdefined( id ) );
    origin = getinteractionorigin( id );
    angles = getinteractionangles( id );
    doordir = anglestoforward( angles );
    var_430a123ddfc8269d = origin - self.origin;
    cross = vectorcross( var_430a123ddfc8269d, doordir );
    bleft = 1;
    
    if ( cross[ 2 ] < 0 )
    {
        bleft = 0;
    }
    
    idlestate = "door_idle";
    
    if ( bleft )
    {
        idlealias = "left";
    }
    else
    {
        idlealias = "right";
    }
    
    door_knob = function_521b5a0a07a246a8( id, "door_knob" );
    
    if ( isdefined( door_knob ) )
    {
        idlealias = door_knob;
    }
    
    if ( role == "active" )
    {
        function_dd518df9ee8d217c( id, "activeside", idlealias );
    }
    else
    {
        occupiedside = function_521b5a0a07a246a8( id, "activeside" );
        
        if ( occupiedside == "left" )
        {
            idlealias = "right";
        }
        else
        {
            idlealias = "left";
        }
    }
    
    sidealias = idlealias;
    openness = function_521b5a0a07a246a8( id, "openness" );
    
    if ( isdefined( openness ) )
    {
        openness = abs( openness );
    }
    
    var_336ae67a2f745bb0 = istrue( function_521b5a0a07a246a8( id, "path_has_door" ) );
    
    if ( !var_336ae67a2f745bb0 )
    {
        if ( level.issp ?? utility::issp() )
        {
            scripteddoor = function_e9af04669d362eea( origin );
            
            if ( isdefined( scripteddoor ) )
            {
                if ( !self [[ self.fndooralreadyopen ]]( scripteddoor ) )
                {
                    function_dd518df9ee8d217c( id, "path_has_door", 1 );
                    var_336ae67a2f745bb0 = 1;
                }
            }
        }
    }
    
    if ( !var_336ae67a2f745bb0 || openness > 45 )
    {
        idlealias += "_doorless";
    }
    
    type = function_521b5a0a07a246a8( id, "breachtype" );
    rolestring = type;
    capinfo = getcapinfoforrole( self, rolestring );
    animset = capinfo.animation;
    animid = archetypegetrandomalias( animset, idlestate, idlealias );
    assert( animid >= 0 );
    xanim = animsetgetanimfromindex( animset, idlestate, animid );
    idleorigin = getstartorigin( origin, angles, xanim );
    idleangles = getstartangles( origin, angles, xanim );
    snappedidleorigin = getclosestpointonnavmesh( idleorigin, self, 0, 1, 0 );
    
    if ( isdefined( snappedidleorigin ) )
    {
        idleorigin = snappedidleorigin;
    }
    
    self.customarrivalstate = sidealias + "_door_arrival";
    self.customarrivalanimset = animset;
    self.customarrivalangles = angles;
    self.customarrivalanimangles = idleangles;
    self.var_4568897d5b592329 = 1;
    self.var_e8bd8a7b2a998725 = 1;
    self.capdata = spawnstruct();
    self.capdata.asmname = capinfo.capname;
    self.capdata.animsetname = animset;
    self.capdata.dooralias = idlealias;
    self.capdata.angles = idleangles;
    self.capdata.var_9ca68a003e7b10c6 = "solo";
    self.capdata.role = role;
    self.capdata.idleorigin = idleorigin;
    
    if ( role == "support" )
    {
        self.capdata.var_9ca68a003e7b10c6 = "dual";
    }
    
    self.customarrivalhandler = &customarrivalhandler;
    
    /#
        if ( getdvarint( @"hash_6bff7f7a44419fce", 0 ) == 1 )
        {
            thread function_cf0f2bc1c543f66e( idleorigin, idleangles );
        }
    #/
    
    self.doorcheck.idleorigin = idleorigin;
    return idleorigin;
}

// Namespace door_check
// Params 7, eflags: 0x4
// Checksum 0xf1470bb1, Offset: 0xe34
// Size: 0x1ff
function private function_99e9256f88943310( id, agent, myslot, base, sidelabel, doororigin, depth )
{
    stackdir = vectornormalize( base - doororigin );
    prevpos = base;
    
    for ( scanslot = myslot - 1; scanslot >= 0 ; scanslot-- )
    {
        entry = level.bseq.instancedata[ id ].var_2f9616c549192b68[ scanslot ];
        
        if ( isdefined( entry ) && isdefined( entry.doorcheck.stackpos ) && entry.doorcheck.side == sidelabel )
        {
            prevpos = entry.doorcheck.stackpos;
            break;
        }
    }
    
    candidatepos = base + stackdir * depth * 44;
    navpos = getclosestpointonnavmesh( candidatepos, agent );
    
    if ( isdefined( navpos ) && distance( navpos, candidatepos ) <= 32 )
    {
        var_9d800a4d2cbf9dac = prevpos + ( 0, 0, 32 );
        
        if ( distance( physicstrace( navpos + ( 0, 0, 32 ), var_9d800a4d2cbf9dac ), var_9d800a4d2cbf9dac ) < 16 )
        {
            return navpos;
        }
        
        for ( retreatstep = 1; retreatstep < depth ; retreatstep++ )
        {
            adjustedcandidate = base + stackdir * ( depth - retreatstep ) * 44;
            adjustednav = getclosestpointonnavmesh( adjustedcandidate, agent );
            
            if ( isdefined( adjustednav ) && distance( adjustednav, adjustedcandidate ) <= 32 )
            {
                if ( distance( physicstrace( adjustednav + ( 0, 0, 32 ), var_9d800a4d2cbf9dac ), var_9d800a4d2cbf9dac ) < 32 )
                {
                    return adjustednav;
                }
            }
        }
    }
}

// Namespace door_check
// Params 5, eflags: 0x4
// Checksum 0x1763dab1, Offset: 0x103c
// Size: 0x234
function private function_be66ac69a90aefd3( id, agent, doororigin, doorforward, doorangles )
{
    targetdist = randomintrange( 320, 360 );
    doorside = anglestoleft( doorangles );
    candidates = [];
    candidates[ 0 ] = doororigin + vectornormalize( doorside * 2 - doorforward ) * targetdist;
    candidates[ 1 ] = doororigin + vectornormalize( doorside * -2 - doorforward ) * targetdist;
    candidates[ 2 ] = doororigin + vectornormalize( doorside - doorforward ) * targetdist;
    candidates[ 3 ] = doororigin + vectornormalize( doorside * -1 - doorforward ) * targetdist;
    candidates[ 4 ] = doororigin - doorforward * targetdist;
    dooreye = doororigin + ( 0, 0, 32 );
    
    for ( i = 0; i < candidates.size ; i++ )
    {
        navpos = getclosestpointonnavmesh( candidates[ i ], agent );
        
        if ( !isdefined( navpos ) || distance( navpos, candidates[ i ] ) > 32 )
        {
            continue;
        }
        
        if ( distance( physicstrace( navpos + ( 0, 0, 32 ), dooreye ), dooreye ) >= 16 )
        {
            continue;
        }
        
        tooclose = 0;
        
        for ( f = 0; f < level.bseq.instancedata[ id ].var_6ef2894b2f6b3fa6 ; f++ )
        {
            if ( distance( navpos, level.bseq.instancedata[ id ].farpositions[ f ] ) < 64 )
            {
                tooclose = 1;
                break;
            }
        }
        
        if ( !tooclose )
        {
            level.bseq.instancedata[ id ].farpositions[ level.bseq.instancedata[ id ].var_6ef2894b2f6b3fa6 ] = navpos;
            level.bseq.instancedata[ id ].var_6ef2894b2f6b3fa6++;
            return navpos;
        }
    }
}

// Namespace door_check
// Params 3, eflags: 0x4
// Checksum 0x3272b37b, Offset: 0x1279
// Size: 0x6c1
function private function_d393bc9d5d3cd17d( statename, mindist, maxdist )
{
    id = self getinteractionid();
    origin = getinteractionorigin( id );
    angles = getinteractionangles( id );
    doorforward = anglestoforward( angles );
    var_a9e32918349d710 = -1;
    var_61e26e261dff35d4 = -1;
    var_d78d46558916046d = -1;
    searchpos = origin - doorforward * 80;
    var_eb0015653cf2d386 = findclosesttacpoint( searchpos );
    
    if ( var_eb0015653cf2d386 )
    {
        var_a9e32918349d710 = var_eb0015653cf2d386.roomindex;
    }
    
    searchpos = origin + doorforward * 80;
    var_71dd92c136986d6a = findclosesttacpoint( searchpos );
    
    if ( var_71dd92c136986d6a )
    {
        var_61e26e261dff35d4 = var_71dd92c136986d6a.roomindex;
    }
    
    curtacpoint = self getnearesttacpoint();
    
    if ( curtacpoint )
    {
        var_d78d46558916046d = curtacpoint.roomindex;
    }
    
    if ( var_61e26e261dff35d4 && var_d78d46558916046d && var_61e26e261dff35d4 == var_d78d46558916046d )
    {
        self.doorcheck.exitquietly = 1;
        return var_71dd92c136986d6a.groundpos;
    }
    
    if ( var_a9e32918349d710 == var_d78d46558916046d && getdvarint( @"hash_84cb0c5329c50b3f", 0 ) )
    {
        myslot = level.bseq.instancedata[ id ].var_52eaa818341b84c7;
        level.bseq.instancedata[ id ].var_2f9616c549192b68[ myslot ] = self;
        level.bseq.instancedata[ id ].var_52eaa818341b84c7 = myslot + 1;
        leader = getbsequserswithtag( id, "primary" );
        leader = leader[ 0 ];
        support = getbsequserswithtag( id, "secondary" );
        support = support[ 0 ];
        stackdir = function_521b5a0a07a246a8( id, "activeside" );
        doorside = anglestoleft( angles );
        
        if ( stackdir == "right" )
        {
            doorside *= -1;
        }
        
        var_f04ca2ec1c2db2d7 = isdefined( support );
        var_9f4009431a04ecef = !var_f04ca2ec1c2db2d7 || myslot % 2 == 0;
        depth = var_f04ca2ec1c2db2d7 ? int( myslot / 2 ) + 1 : myslot + 1;
        
        if ( isdefined( leader ) )
        {
            leaderbase = leader.doorcheck.idleorigin;
        }
        else
        {
            assertmsg( "<dev string:x24>" );
            leaderbase = origin - doorforward * 24 + doorside * 44;
        }
        
        primarybase = var_9f4009431a04ecef ? leaderbase : support.doorcheck.idleorigin;
        primarylabel = var_9f4009431a04ecef ? #"leader" : #"support";
        placedpos = function_99e9256f88943310( id, self, myslot, primarybase, primarylabel, origin, depth );
        placedlabel = primarylabel;
        
        if ( !isdefined( placedpos ) && var_f04ca2ec1c2db2d7 )
        {
            fallbackbase = var_9f4009431a04ecef ? support.doorcheck.idleorigin : leaderbase;
            fallbacklabel = var_9f4009431a04ecef ? #"support" : #"leader";
            placedpos = function_99e9256f88943310( id, self, myslot, fallbackbase, fallbacklabel, origin, depth );
            placedlabel = fallbacklabel;
        }
        
        if ( !isdefined( placedpos ) )
        {
            placedpos = function_be66ac69a90aefd3( id, self, origin, doorforward, angles );
            placedlabel = undefined;
        }
        
        if ( isdefined( placedpos ) )
        {
            offsetpos = placedpos;
            self.doorcheck.stackpos = offsetpos;
            self.doorcheck.side = placedlabel;
        }
    }
    
    if ( var_a9e32918349d710 != var_d78d46558916046d )
    {
        doortome = vectornormalize( self.origin - origin );
        
        if ( vectordot( doortome, doorforward ) < 0 )
        {
            self.doorcheck.exitquietly = 1;
            return var_71dd92c136986d6a.groundpos;
        }
        
        leader = getbsequserswithtag( id, "primary" );
        leader = leader[ 0 ];
        
        if ( !isdefined( leader ) )
        {
            assertmsg( "<dev string:x74>" );
            leader = self;
        }
        
        leaderpoint = leader getnearesttacpoint();
        
        if ( !leaderpoint )
        {
            leaderpoint = var_eb0015653cf2d386;
        }
        
        var_d80ca2010ee67dd1 = findclosestlospointwithinradius( self.origin, 360, leader.origin, self.origin );
        
        if ( var_d80ca2010ee67dd1 )
        {
            return var_d80ca2010ee67dd1;
        }
    }
    
    if ( var_a9e32918349d710 == var_d78d46558916046d && !getdvarint( @"hash_84cb0c5329c50b3f", 0 ) )
    {
        doortome = vectornormalize( self.origin - origin );
        dist = randomintrange( mindist, maxdist );
        endpoint = origin + doortome * dist;
        
        /#
            if ( getdvarint( @"hash_6bff7f7a44419fce", 0 ) == 1 )
            {
                line( origin, endpoint, ( 0, 0, 1 ), 1, 0, 200 );
            }
        #/
        
        point = findclosestlospointwithinradius( origin, maxdist, origin, endpoint );
        
        if ( !isdefined( point ) )
        {
            point = findclosesttacpoint( endpoint );
            
            if ( isdefined( point ) )
            {
                /#
                    if ( getdvarint( @"hash_6bff7f7a44419fce", 0 ) == 1 )
                    {
                        print3d( point.origin + ( 0, 0, 100 ), "<dev string:xcd>", ( 255, 255, 255 ), 1, 0.6, 200 );
                        utility::draw_circle( point.origin, 16, ( 1, 1, 0 ), 1, 0, 200 );
                    }
                #/
                
                return point.origin;
            }
            else
            {
                point = self getclosestreachablepointonnavmesh( endpoint );
            }
            
            /#
                if ( getdvarint( @"hash_6bff7f7a44419fce", 0 ) == 1 )
                {
                    print3d( point + ( 0, 0, 100 ), "<dev string:xcd>", ( 255, 255, 255 ), 1, 0.6, 200 );
                    utility::draw_circle( point, 16, ( 1, 1, 0 ), 1, 0, 200 );
                }
            #/
            
            if ( point )
            {
                return point;
            }
        }
    }
    
    if ( offsetpos )
    {
        return offsetpos;
    }
    
    disttodoor = distance( self.origin, origin );
    
    if ( disttodoor > 360 )
    {
        farpos = function_be66ac69a90aefd3( id, self, origin, doorforward, angles );
        
        if ( isdefined( farpos ) )
        {
            return farpos;
        }
    }
    
    return self.origin;
}

// Namespace door_check
// Params 0, eflags: 0x4
// Checksum 0xd2435aa4, Offset: 0x1943
// Size: 0x57
function private customarrivalhandler()
{
    assert( isdefined( self.capdata ) );
    self.capdata.var_ec117174c7bbdce6 = 1;
    cap::cap_start( self.capdata.asmname, self.capdata.animsetname );
}

// Namespace door_check
// Params 2, eflags: 0x4
// Checksum 0x6bbfd103, Offset: 0x19a2
// Size: 0x15
function private arrivalsetup( statename, params )
{
    
}

// Namespace door_check
// Params 0, eflags: 0x4
// Checksum 0xa9e7ad6b, Offset: 0x19bf
// Size: 0x3e
function private arrivalcleanup()
{
    self.customarrivalstate = undefined;
    self.customarrivalanimset = undefined;
    self.customarrivalangles = undefined;
    self.customarrivalanimangles = undefined;
    self.var_4568897d5b592329 = 0;
    self.var_e8bd8a7b2a998725 = 0;
}

// Namespace door_check
// Params 3, eflags: 0x4
// Checksum 0xe190bcd2, Offset: 0x1a05
// Size: 0xd3
function private opendoor( interactionid, var_4e6c261e98adf1ea, shouldbash )
{
    doorobj = function_521b5a0a07a246a8( interactionid, "door" );
    
    if ( isdefined( doorobj ) )
    {
        if ( doorobj scriptabledoorisclosed() )
        {
            if ( shouldbash )
            {
                doorobj scriptabledoorbashopen( "away", self.origin );
            }
            else
            {
                doorobj scriptabledooropen( "away", self.origin );
            }
        }
        
        return;
    }
    
    if ( level.issp ?? utility::issp() )
    {
        scripteddoor = function_e9af04669d362eea( self.origin );
        
        if ( isdefined( scripteddoor ) )
        {
            if ( !self [[ self.fndooralreadyopen ]]( scripteddoor ) )
            {
                self [[ self.fndooropen ]]( scripteddoor, 0.5 );
            }
        }
    }
}

// Namespace door_check
// Params 2, eflags: 0x4
// Checksum 0x64ddfeb7, Offset: 0x1ae0
// Size: 0x153
function private onarrival( statename, params )
{
    if ( !self.capdata.var_ec117174c7bbdce6 )
    {
        arrivalcleanup();
        cap::cap_start( self.capdata.asmname, self.capdata.animsetname );
    }
    
    self.doorcheck.arrived = 1;
    val::set( "door_check", "script_pushable", 0 );
    val::set( "door_check", "script_pushable_by_ai", 0 );
    sidetoken = self.capdata.dooralias;
    numbertoken = self.capdata.var_9ca68a003e7b10c6;
    roletoken = self.capdata.role;
    self.capdata.var_44b71e00f14cb477 = sidetoken + "_" + numbertoken + "_" + roletoken;
    self interactioncleargoalpos();
    id = self getinteractionid();
    level.bseq.instancedata[ id ].bstarted = 1;
}

// Namespace door_check
// Params 2, eflags: 0x4
// Checksum 0xf6994b74, Offset: 0x1c3b
// Size: 0x57
function private onbailout( statename, params )
{
    id = self getinteractionid();
    abortinteraction( id );
    doorid = function_521b5a0a07a246a8( id, "doorindex" );
    
    if ( isdefined( doorid ) )
    {
        updateroomdoorclaim( doorid, gettime() + 10000 );
    }
}

// Namespace door_check
// Params 2, eflags: 0x4
// Checksum 0x798d4caa, Offset: 0x1c9a
// Size: 0x100
function private onenter( statename, params )
{
    self endon( #"death" );
    self.capdata.var_e35fd27cd8a38831 = 1;
    
    if ( isdefined( self.doorcheck.priornode ) )
    {
        self setbtgoalnode( 3, self.doorcheck.priornode );
        self.doorcheck.priornode = undefined;
    }
    else if ( isdefined( self.doorcheck.priorgoalpos ) )
    {
        self setbtgoalpos( 3, self.doorcheck.priorgoalpos );
        self.doorcheck.priorgoalpos = undefined;
    }
    
    endtime = gettime() + 5000;
    waitframe();
    
    while ( gettime() < endtime )
    {
        if ( self asmeventfired( self.asmname, "end" ) )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace door_check
// Params 2
// Checksum 0xdf92b922, Offset: 0x1da2
// Size: 0x2b
function starthold( statename, params )
{
    self.capdata.var_3fd5a5aa0f365ffc = 1;
}

// Namespace door_check
// Params 4
// Checksum 0xcda98155, Offset: 0x1dd5
// Size: 0x3b, Type: bool
function doorcheck_shoulddoarrival( asmname, statename, tostatename, params )
{
    return istrue( self.capdata.var_ec117174c7bbdce6 );
}

// Namespace door_check
// Params 4
// Checksum 0x1b6e0e1b, Offset: 0x1e19
// Size: 0x3b, Type: bool
function function_d823e1cd8e76b902( asmname, statename, tostatename, params )
{
    return istrue( self.capdata.var_e35fd27cd8a38831 );
}

// Namespace door_check
// Params 4
// Checksum 0x84c3b52e, Offset: 0x1e5d
// Size: 0x3b, Type: bool
function function_d6c38f6eff6a3b59( asmname, statename, tostatename, params )
{
    return istrue( self.capdata.var_3fd5a5aa0f365ffc );
}

// Namespace door_check
// Params 3
// Checksum 0x1fa34e94, Offset: 0x1ea1
// Size: 0x46
function function_3b119c0789991605( asmname, statename, params )
{
    alias = self.capdata.dooralias;
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace door_check
// Params 3
// Checksum 0x99c64ad, Offset: 0x1ef0
// Size: 0x10e
function function_98490ba5c61f1652( asmname, statename, params )
{
    id = self getinteractionid();
    origin = getinteractionorigin( id );
    openness = function_521b5a0a07a246a8( id, "openness" );
    
    if ( isdefined( openness ) )
    {
        openness = abs( openness );
    }
    
    var_336ae67a2f745bb0 = istrue( function_521b5a0a07a246a8( id, "path_has_door" ) );
    
    if ( !var_336ae67a2f745bb0 )
    {
        if ( level.issp ?? utility::issp() )
        {
            scripteddoor = function_e9af04669d362eea( origin );
            
            if ( isdefined( scripteddoor ) )
            {
                if ( !self [[ self.fndooralreadyopen ]]( scripteddoor ) )
                {
                    function_dd518df9ee8d217c( id, "path_has_door", 1 );
                    var_336ae67a2f745bb0 = 1;
                }
            }
        }
    }
    
    alias = self.capdata.role;
    
    if ( !var_336ae67a2f745bb0 || openness > 45 )
    {
        alias += "_doorless";
    }
    
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace door_check
// Params 3
// Checksum 0xe5294944, Offset: 0x2007
// Size: 0x7a
function function_83589e3def0e1f7b( asmname, statename, params )
{
    alias = self.capdata.dooralias + "_" + self.capdata.var_9ca68a003e7b10c6 + "_" + self.capdata.role;
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace door_check
// Params 1
// Checksum 0x850813fd, Offset: 0x208a
// Size: 0xe9
function function_e9af04669d362eea( refpos )
{
    if ( !isdefined( level.interactive_doors ) || !isdefined( level.interactive_doors.ents ) )
    {
        return;
    }
    
    searchdistsq = 1296;
    
    foreach ( doorent in level.interactive_doors.ents )
    {
        assert( isdefined( doorent.origin ) );
        
        if ( distance2dsquared( doorent.origin, refpos ) < searchdistsq )
        {
            return doorent;
        }
    }
}

// Namespace door_check
// Params 0
// Checksum 0xa7c2b9ba, Offset: 0x217b
// Size: 0x88
function getgrenade()
{
    if ( level.issp ?? utility::issp() )
    {
        grenade = level.offhands.var_a990be32bdb913d6[ "equip_flash" ].weaponname ?? self.grenadeweapon;
    }
    else
    {
        grenade = level.equipment.table[ "equip_flash" ].objweapon ?? self.grenadeweapon;
    }
    
    return grenade;
}

// Namespace door_check
// Params 1
// Checksum 0xbecb2000, Offset: 0x220c
// Size: 0x17b
function function_55477afb735e892c( note )
{
    if ( note == "door_open" )
    {
        opendoor( self getinteractionid(), self.origin, 0 );
        return;
    }
    
    if ( note == "door_bash" )
    {
        opendoor( self getinteractionid(), self.origin, 1 );
        return;
    }
    
    if ( note == "grenade_left" || note == "grenade_right" )
    {
        grenadeweapon = getgrenade();
        grenademodel = getweaponmodel( grenadeweapon );
        assert( isdefined( grenademodel ) );
        
        if ( note == "grenade_left" )
        {
            self.grenadeattachtag = #"tag_accessory_left";
        }
        else
        {
            self.grenadeattachtag = #"tag_accessory_right";
        }
        
        self attach( grenademodel, self.grenadeattachtag );
        self.grenademodel = grenademodel;
        thread function_c021ab152a7a0ec1();
        return;
    }
    
    if ( note == "grenade_throw" )
    {
        assert( isdefined( self.grenadeattachtag ) );
        grenadeweapon = getgrenade();
        grenadepos = self gettagorigin( self.grenadeattachtag );
        magicgrenademanual( grenadeweapon, grenadepos, self.doorcheck.grenadedir * 20, 1, self );
        self detach( self.grenademodel, self.grenadeattachtag );
        self.grenademodel = undefined;
        self.grenadeattachtag = undefined;
    }
}

// Namespace door_check
// Params 0
// Checksum 0xc1a2f6e, Offset: 0x238f
// Size: 0x9b
function function_c021ab152a7a0ec1()
{
    self endon( #"death" );
    self endon( #"bseq_user_deleted" );
    prevhandpos = self gettagorigin( self.grenadeattachtag );
    self.doorcheck.grenadedir = anglestoforward( self.angles );
    waitframe();
    
    while ( isdefined( self.grenadeattachtag ) )
    {
        handpos = self gettagorigin( self.grenadeattachtag );
        self.doorcheck.grenadedir = handpos - prevhandpos;
        prevhandpos = handpos;
        waitframe();
    }
}

// Namespace door_check
// Params 3
// Checksum 0xdd751aa9, Offset: 0x2432
// Size: 0x87
function function_fe01d3e90c41ae7b( asmname, statename, params )
{
    thread asm::function_b7619cbe4e9abaf4( asmname, statename, 1 );
    
    if ( params == 1 )
    {
        self orientmode( "face current" );
    }
    else
    {
        self orientmode( "face angle", self.capdata.angles[ 1 ] );
    }
    
    self asmfireephemeralevent( "arrived", "end" );
    self.doorcheck.arrived = 1;
}

// Namespace door_check
// Params 3
// Checksum 0xbe0b4dc1, Offset: 0x24c1
// Size: 0x5a
function function_35c09cfbc9b57021( asmname, statename, params )
{
    thread asm::asm_playanimstate( asmname, statename, params );
    self function_1899aad6a5246b8( self.capdata.idleorigin, self.capdata.angles, 0.3 );
}

// Namespace door_check
// Params 4
// Checksum 0xdc8fd329, Offset: 0x2523
// Size: 0xf9, Type: bool
function function_7ae07f1c63c7540( asmname, statename, tostatename, params )
{
    if ( !isdefined( params ) || isarray( params ) )
    {
        assertmsg( "<dev string:xe1>" );
        return false;
    }
    
    if ( !isdefined( self.capdata.dooralias ) )
    {
        return false;
    }
    
    side = self.capdata.dooralias;
    
    if ( self.capdata.role == "support" )
    {
        if ( side == "left" )
        {
            side = "right";
        }
        else if ( side == "right" )
        {
            side = "left";
        }
    }
    
    return self.capdata.dooralias == params || self.capdata.dooralias == params + "_doorless";
}

// Namespace door_check
// Params 1, eflags: 0x4
// Checksum 0x369cd072, Offset: 0x2625
// Size: 0x146, Type: bool
function private function_64f894e6c635e435( params )
{
    interactionid = self getinteractionid();
    
    if ( !isdefined( level.bseq.instancedata[ interactionid ].var_54e8c6a29e8e131 ) )
    {
        level.bseq.instancedata[ interactionid ].var_54e8c6a29e8e131 = gettime();
    }
    
    barriving = self.arriving;
    
    if ( self isintraverse() )
    {
        return false;
    }
    
    if ( barriving )
    {
        return false;
    }
    
    var_2d7cc3a879a6d4d = distancesquared( self.doorcheck.idleorigin, self.origin );
    distthresholdsq = 16;
    var_fa987b2cf7a80865 = gettime() - level.bseq.instancedata[ interactionid ].var_54e8c6a29e8e131;
    
    if ( var_fa987b2cf7a80865 > 15000 )
    {
        distthresholdsq = 256;
    }
    else if ( var_fa987b2cf7a80865 > 8000 )
    {
        distthresholdsq = 64;
    }
    
    if ( self.doorcheck.arrived || var_2d7cc3a879a6d4d < distthresholdsq )
    {
        self.doorcheck.arrivedtime = gettime();
        return true;
    }
    
    return false;
}

// Namespace door_check
// Params 1, eflags: 0x4
// Checksum 0x409dc3f0, Offset: 0x2774
// Size: 0x20, Type: bool
function private function_c62577c2f2213500( params )
{
    return istrue( self.doorcheck.arrived );
}

// Namespace door_check
// Params 4, eflags: 0x4
// Checksum 0x89ab602c, Offset: 0x279d
// Size: 0x138, Type: bool
function private function_c15c3b5c7d9a70bd( asmname, statename, tostatename, params )
{
    id = self getinteractionid();
    assert( isdefined( id ) );
    origin = getinteractionorigin( id );
    angles = getinteractionangles( id );
    doordir = anglestoforward( angles );
    var_430a123ddfc8269d = origin - self.origin;
    cross = vectorcross( var_430a123ddfc8269d, doordir );
    bleft = 1;
    
    if ( cross[ 2 ] < 0 )
    {
        bleft = 0;
    }
    
    if ( bleft )
    {
        desiredside = "left";
    }
    else
    {
        desiredside = "right";
    }
    
    var_e419af8468929333 = function_521b5a0a07a246a8( id, "door_knob" );
    mustcross = desiredside == var_e419af8468929333;
    openness = function_521b5a0a07a246a8( id, "openness" );
    dooropen = 1;
    
    if ( isdefined( openness ) )
    {
        openness = abs( openness );
        dooropen = openness >= 45;
    }
    
    if ( mustcross && dooropen )
    {
        return false;
    }
    
    return true;
}

// Namespace door_check
// Params 4, eflags: 0x4
// Checksum 0xb854c5c0, Offset: 0x28de
// Size: 0x50, Type: bool
function private function_3920913d01f45199( asmname, statename, tostatename, params )
{
    id = self getinteractionid();
    hasdoor = function_521b5a0a07a246a8( id, "path_has_door" );
    return !hasdoor;
}

// Namespace door_check
// Params 4, eflags: 0x4
// Checksum 0xf42de6f5, Offset: 0x2937
// Size: 0x1f8, Type: bool
function private function_a7469b67274c2f36( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    id = self getinteractionid();
    origin = getinteractionorigin( id );
    angles = getinteractionangles( id );
    doordir = anglestoforward( angles );
    support = getbsequserswithtag( id, "secondary" );
    active = getbsequserswithtag( id, "primary" );
    
    if ( support.size == 0 && active.size == 0 )
    {
        return true;
    }
    
    if ( gettime() >= self.doorcheck.var_c943bcfb06618f5e )
    {
        checkpos = origin + -1 * anglestoforward( angles ) * 512;
        self.doorcheck.var_c943bcfb06618f5e = gettime() + 1000;
        enemiesinradius = self function_f017e352a29a57a1( origin, 1600, 1 );
        
        foreach ( enemy in enemiesinradius )
        {
            var_1cd7ed40c7ce2fce = self lastknowntime( enemy );
            
            if ( var_1cd7ed40c7ce2fce < gettime() - 10000 )
            {
                continue;
            }
            
            toenemy = vectornormalize2( enemy.origin - origin );
            delta = vectordot( doordir, toenemy );
            
            if ( delta <= 0 && ( self cansee( enemy ) || enemy hastacvis( self ) ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace door_check
// Params 4, eflags: 0x4
// Checksum 0x89153bf7, Offset: 0x2b38
// Size: 0x7a, Type: bool
function private function_7486427038f518fa( asmname, statename, tostatename, params )
{
    id = self getinteractionid();
    occupiedside = function_521b5a0a07a246a8( id, "activeside" );
    var_adf8f0dfeeeb25d7 = occupiedside == "left" ? "rightsidevalid" : "leftsidevalid";
    return function_521b5a0a07a246a8( id, var_adf8f0dfeeeb25d7 ) ?? 0;
}

// Namespace door_check
// Params 4, eflags: 0x4
// Checksum 0x255f75f5, Offset: 0x2bbb
// Size: 0x128, Type: bool
function private function_44fe2fbb32cf8ef4( asmname, statename, tostatename, params )
{
    if ( !self.doorcheck.arrived || self.doorcheck.arrivedtime <= 0 )
    {
        return true;
    }
    
    if ( gettime() - self.doorcheck.arrivedtime > 15000 )
    {
        return true;
    }
    
    if ( gettime() - self.doorcheck.arrivedtime > 3000 )
    {
        if ( !self.enemy )
        {
            return true;
        }
        
        if ( !self cansee( self.enemy ) )
        {
            if ( self.doorcheck.var_4d33a3148606d811 <= 0 )
            {
                self.doorcheck.var_4d33a3148606d811 = gettime();
            }
            
            if ( gettime() - self.doorcheck.var_4d33a3148606d811 > 3000 )
            {
                return true;
            }
        }
        else
        {
            self.doorcheck.var_4d33a3148606d811 = 0;
        }
    }
    
    return false;
}

// Namespace door_check
// Params 4, eflags: 0x4
// Checksum 0x800e35c0, Offset: 0x2cec
// Size: 0x69
function private function_7a89264e89571825( asmname, statename, tostatename, params )
{
    id = self getinteractionid();
    
    if ( !level.bseq.instancedata[ id ].holdallowed )
    {
        return 0;
    }
    
    return function_521b5a0a07a246a8( id, "holddoor" );
}

// Namespace door_check
// Params 4, eflags: 0x4
// Checksum 0xf4d254e9, Offset: 0x2d5e
// Size: 0x3a
function private function_621f73a2676bf992( asmname, statename, tostatename, params )
{
    return self.doorcheck.exitquietly;
}

// Namespace door_check
// Params 4
// Checksum 0xe1923113, Offset: 0x2da1
// Size: 0x31
function function_8dc85eb2dfbe1b79( asmname, statename, tostatename, params )
{
    return self function_8d1306d3e61ee07a( "all" );
}

// Namespace door_check
// Params 1, eflags: 0x4
// Checksum 0x7eda40f5, Offset: 0x2ddb
// Size: 0x25
function private function_259b37243d1c2960( interactionid )
{
    self.capdata.var_9ca68a003e7b10c6 = "dual";
}

// Namespace door_check
// Params 1
// Checksum 0x3f29b25d, Offset: 0x2e08
// Size: 0xc
function function_e111218404c76afa( interactionid )
{
    
}

// Namespace door_check
// Params 1
// Checksum 0xdccb34f5, Offset: 0x2e1c
// Size: 0xc
function goalcheckcleanup( interactionid )
{
    
}

// Namespace door_check
// Params 2, eflags: 0x4
// Checksum 0x453b9cc7, Offset: 0x2e30
// Size: 0x1aa
function private function_cf0f2bc1c543f66e( idleorigin, idleangles )
{
    self endon( #"death" );
    forward = anglestoforward( idleangles );
    end = idleorigin + forward * 32;
    id = self getinteractionid();
    breachtype = function_521b5a0a07a246a8( id, "breachtype" );
    intorg = getinteractionorigin( id );
    intfwd = anglestoforward( getinteractionangles( id ) );
    intend = intorg + intfwd * 32;
    utility::draw_arrow_time( intorg, intend, ( 150, 50, 150 ), 5 );
    utility::draw_arrow_time( idleorigin, end, ( 150, 50, 150 ), 5 );
    
    /#
        print3d( idleorigin + ( 0, 0, 100 ), breachtype, ( 255, 255, 255 ), 1, 0.6, 200 );
    #/
    
    /#
        print3d( idleorigin + ( 0, 0, 80 ), self.capdata.dooralias + "<dev string:x119>" + self.capdata.var_9ca68a003e7b10c6 + "<dev string:x119>" + self.capdata.role, ( 255, 255, 255 ), 1, 0.6, 150 );
    #/
    
    /#
        print3d( idleorigin + ( 0, 0, 60 ), self.customarrivalstate, ( 255, 255, 255 ), 1, 0.4, 150 );
    #/
}

