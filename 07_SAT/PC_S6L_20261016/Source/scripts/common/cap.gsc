// scripts\common\cap.gsc  (hash_010b6724c15a95e8.gscc) (size: 10793 Bytes / 0x2a29 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4b2aede6 (1261104614)
// size ...... 10793 (0x2a29)
// includes .. 3   (offset: 0x278d)
// strings ... 39  (offset: 0x27a5)
// dev strs .. 8   (offset: 0x29c1)
// exports ... 24  (offset: 0x1a61)
// cseg ...... 0x376 + 0x16eb (0x1a61)
// imports ... 78  (offset: 0x1e21)
// animtree1 . 0   (offset: 0x2a29)
// animtree2 . 0   (offset: 0x2a29)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\utility;

#namespace cap;

// Namespace cap
// Params 0
// Checksum 0x762146db, Offset: 0x394
// Size: 0x4f
function init_cap()
{
    if ( isdefined( level.cap ) )
    {
        return;
    }
    
    level.cap = spawnstruct();
    level.cap.fnstart = &cap_start;
    level.cap.fnexit = &cap_exit;
}

// Namespace cap
// Params 3
// Checksum 0xb07cd1e0, Offset: 0x3eb
// Size: 0x1fd, Type: bool
function cap_start( capname, animset, animscripted )
{
    if ( isai( self ) && self isinscriptedstate() )
    {
        msg1 = "AI $e" + self getentitynumber() + " attempting to start CAP '" + capname + "' with Arc '" + animset + "' ";
        msg2 = "but is currently playing a scripted anim (ASM state: '" + asm::asm_getcurrentstate( self.asmname ) + "') ";
        msg3 = "This is not supported - you either need to avoid starting";
        msg4 = " a CAP when the AI is scripted, or first clear the scripted state using the normal method.";
        assertmsg( msg1 + msg2 + msg3 + msg4 );
        return false;
    }
    
    if ( issubstr( animset, "/" ) )
    {
        msg = "AI $e" + self getentitynumber() + " attempting to start CAP '" + capname + "' with Arc path '" + animset + "' instead of arc. Please remove the path and use just the arc name.";
        assertmsg( msg );
        return false;
    }
    
    if ( !archetypeassetloaded( animset ) )
    {
        msg = "AI $e" + self getentitynumber() + " attempting to start CAP '" + capname + "' with invalid Arc '" + animset + "'.";
        assertmsg( msg );
        return false;
    }
    
    self.caporigin = self.origin;
    self.capangles = self.angles;
    self notify( #"cap_start" );
    
    if ( !isai( self ) )
    {
        self._blackboard = spawnstruct();
        self._blackboard.bfire = 0;
        function_64df1eb8fc59357a( capname, animset );
        return true;
    }
    else
    {
        self._blackboard.bseqphase = undefined;
    }
    
    assert( isalive( self ) && isdefined( self.asm ) );
    self setoverridearchetype( "animscript", animset, 0 );
    self setcapasm( capname );
    cap_terminateandreplace( capname );
    
    if ( animscripted )
    {
        asm_bb::bb_setanimscripted();
    }
    
    return true;
}

// Namespace cap
// Params 2
// Checksum 0x6891c3f3, Offset: 0x5f1
// Size: 0x11d
function function_64df1eb8fc59357a( baseasmname, archetypename )
{
    if ( archetypename == "hero_salter" || archetypename == "farah" || archetypename == "soldier_female" )
    {
        asm_bb::bb_setshort( 1 );
    }
    
    self.asmname = baseasmname;
    
    if ( !isdefined( self.asm ) )
    {
        self.asm = spawnstruct();
        self.asm.animoverrides = [];
    }
    
    assert( isdefined( archetypename ) || isdefined( self.animsetname ) );
    
    if ( isdefined( archetypename ) )
    {
        self.animsetname = archetypename;
        self.originalanimationarchetype = self.animationarchetype;
        self.animationarchetype = undefined;
    }
    
    self.scriptmodelcap = 1;
    self asminstantiate( baseasmname );
    
    if ( !isdefined( level.capscriptmodels ) )
    {
        level.capscriptmodels = [];
        level thread function_804046ad9cf64f5b();
    }
    
    if ( !arraycontains( level.capscriptmodels, self ) )
    {
        level.capscriptmodels[ level.capscriptmodels.size ] = self;
    }
}

// Namespace cap
// Params 0
// Checksum 0x580d6a8c, Offset: 0x716
// Size: 0x59
function function_804046ad9cf64f5b()
{
    while ( true )
    {
        for ( capindex = 0; capindex < level.capscriptmodels.size ; capindex++ )
        {
            capent = level.capscriptmodels[ capindex ];
            
            if ( isalive( capent ) )
            {
                capent asmtick();
            }
        }
        
        wait 0.05;
    }
}

// Namespace cap
// Params 2
// Checksum 0x4f7bec1, Offset: 0x777
// Size: 0x56
function cap_terminateandreplace( newasmname, newarchetype )
{
    self asmterminate();
    self notify( #"asm_terminated" );
    self.asmtrackasm = undefined;
    
    if ( !isdefined( newarchetype ) )
    {
        newarchetype = self.animsetname;
    }
    
    self [[ self.fnasm_init ]]( tolower( newasmname ), newarchetype );
}

// Namespace cap
// Params 0
// Checksum 0x1fe7d1ca, Offset: 0x7d5
// Size: 0x12b
function cap_exit()
{
    if ( !isai( self ) )
    {
        self.asmname = undefined;
        self.animationarchetype = self.originalanimationarchetype;
        self.originalanimationarchetype = undefined;
        self.scriptmodelcap = undefined;
        
        if ( arraycontains( level.capscriptmodels, self ) )
        {
            level.capscriptmodels = arrayremove( level.capscriptmodels, self );
        }
        
        return;
    }
    
    assert( self function_51631ea7d587647d(), "<dev string:x24>" + self.asmname );
    
    if ( !self function_51631ea7d587647d() )
    {
        return;
    }
    
    if ( asm_bb::bb_isanimscripted() )
    {
        asm_bb::bb_clearanimscripted();
    }
    
    self.asmtrackasm = undefined;
    self clearcap();
    self.var_f6cf297cd6c37337 = undefined;
    
    if ( isdefined( self.capgroup ) )
    {
        function_1dc69bd8c64496fc();
    }
    
    if ( !isdefined( self.script_pushable ) )
    {
        self.script_pushable = self.oldpushable;
    }
    
    if ( !isdefined( self.script_pushable_by_ai ) )
    {
        self.script_pushable_by_ai = self.var_ba77a88b56abb64;
    }
    
    self.oldpushable = undefined;
    self.var_ba77a88b56abb64 = undefined;
    function_82acad1b355efb61();
    self notify( #"cap_exit_completed" );
}

// Namespace cap
// Params 0
// Checksum 0x60d0d9e2, Offset: 0x908
// Size: 0xad
function function_4fe8a1b9dc2d0bbc()
{
    self endon( #"entitydeleted" );
    self endon( #"cap_exit_completed" );
    
    if ( self.team == "axis" )
    {
        utility::waittill_any( "death", utility::function_215bebaff8aa653c() );
    }
    else
    {
        self waittill( #"death" );
    }
    
    if ( asm_bb::bb_isanimscripted() )
    {
        asm_bb::bb_clearanimscripted();
    }
    
    self stopanimscripted();
    self clearoverridearchetype( "animscript" );
    self setcapasm( undefined );
    cap_terminateandreplace( self.defaultasm );
    
    if ( isdefined( self.capgroup ) )
    {
        function_1dc69bd8c64496fc();
    }
    
    function_82acad1b355efb61();
    self notify( #"cap_exit_completed" );
}

// Namespace cap
// Params 4
// Checksum 0x6b199569, Offset: 0x9bd
// Size: 0xc3
function function_b26f782b6bed85d5( origin, capname, animset, var_b9018c9fc0176a5c )
{
    self endon( #"death" );
    
    if ( var_b9018c9fc0176a5c )
    {
        self.oldscriptgoalpos = self.scriptgoalpos;
        self.oldgoalradius = self.goalradius;
    }
    
    self setgoalpos( origin, 1 );
    self waittill( #"goal" );
    cap_start( capname, animset );
    self waittill( #"cap_exit_completed" );
    
    if ( isdefined( self.oldscriptgoalpos ) )
    {
        self setgoalpos( self.oldscriptgoalpos, self.oldgoalradius );
        self.oldscriptgoalpos = undefined;
        self.oldgoalradius = undefined;
    }
}

// Namespace cap
// Params 0
// Checksum 0xff56d4ea, Offset: 0xa88
// Size: 0xb1
function cap_reach_and_arrive_terminate()
{
    self endon( #"death" );
    msg = utility::waittill_any_return( "cap_reach_and_arrive", "bseq_user_deleted" );
    
    if ( self && isdefined( self.var_9a42f5f373740892 ) )
    {
        self.var_9a42f5f373740892 = undefined;
    }
    
    if ( self && isdefined( self.customarrivalhandler ) )
    {
        self.customarrivalhandler = undefined;
    }
    
    if ( self && isalive( self ) && isdefined( msg ) )
    {
        self finishcoverarrival( "Custom" );
        self clearbtgoal( 1 );
        
        if ( msg == "bseq_user_deleted" )
        {
            if ( self.defaultasm != self.asmname )
            {
                cap_exit();
            }
        }
    }
}

// Namespace cap
// Params 4
// Checksum 0x40f1e596, Offset: 0xb41
// Size: 0x386
function cap_reach_and_arrive( scriptednode, capname, animset, arrival_state_override )
{
    assert( isdefined( scriptednode.origin ) );
    self notify( #"cap_reach_and_arrive" );
    self endon( #"cap_reach_and_arrive" );
    thread cap_reach_and_arrive_terminate();
    self endon( #"bseq_user_deleted" );
    self endon( #"death" );
    
    if ( !isdefined( self.var_9a42f5f373740892 ) )
    {
        self.var_9a42f5f373740892 = spawnstruct();
        self.var_9a42f5f373740892.targetname = "cap_reach_and_arrive";
    }
    
    self.var_9a42f5f373740892.angles = scriptednode.angles;
    self.var_9a42f5f373740892.origin = scriptednode.origin;
    self.var_9a42f5f373740892.type = "Custom";
    arrival_state = "cap_arrival";
    
    if ( isdefined( arrival_state_override ) )
    {
        arrival_state = arrival_state_override;
    }
    
    self.oldpushable = self.script_pushable;
    self.var_ba77a88b56abb64 = self.script_pushable_by_ai;
    self.script_pushable = 0;
    self.script_pushable_by_ai = 0;
    
    if ( !self.var_e0bc276499c18875 )
    {
        approachpos = function_82491e1bc74dd239( capname, arrival_state, scriptednode.origin, animset );
        var_e3e28571d43b1f01 = 0;
        
        if ( isarray( approachpos ) )
        {
            var_e3e28571d43b1f01 = 1;
            approachpos = approachpos[ 1 ];
        }
        
        if ( isdefined( approachpos ) )
        {
            while ( distance2d( self.origin, approachpos ) > 40 )
            {
                waitframe();
            }
            
            if ( var_e3e28571d43b1f01 )
            {
                self clearbtgoal( 1 );
            }
        }
    }
    
    goalrad = 4;
    self setbtgoalradius( 1, goalrad );
    self setbtgoalpos( 1, scriptednode.origin );
    asm::asm_fireephemeralevent( "path_chosen", "end" );
    assert( archetypehasstate( animset, arrival_state ), "<dev string:x5b>" + animset + "<dev string:x65>" + arrival_state + "<dev string:x7e>" );
    self.customarrivalstate = arrival_state;
    self.customarrivalanimset = animset;
    self.customarrivalangles = scriptednode.angles;
    self.var_4568897d5b592329 = 1;
    self.customarrivalhandler = &cap_custom_arrival_handler;
    self.capdata = spawnstruct();
    self.capdata.arrivalangles = scriptednode.angles;
    self.capdata.asmname = capname;
    self.capdata.var_ec117174c7bbdce6 = 0;
    self waittill( #"bt_goal" );
    
    while ( self.var_15c6e27c1acff47e != "not_set" )
    {
        waitframe();
    }
    
    waitforalignment( scriptednode.angles );
    
    if ( self.capdata.var_ec117174c7bbdce6 )
    {
        self waittill( #"custom_arrival_handler_done" );
        self notify( #"lerp_arrive_finished" );
    }
    else
    {
        self notify( #"lerp_arrive_finished" );
        cap_start( capname, animset );
        self function_1899aad6a5246b8( scriptednode.origin, scriptednode.angles, 0.3 );
    }
    
    asm::asm_fireephemeralevent( "move", "end" );
    self.capdata = undefined;
    self notify( #"cap_reach_and_arrive" );
}

// Namespace cap
// Params 1
// Checksum 0x31ae854d, Offset: 0xecf
// Size: 0x58
function waitforalignment( skitangle )
{
    timeout = gettime() + 3000;
    
    while ( gettime() < timeout )
    {
        anglediff = skitangle[ 1 ] - self.angles[ 1 ];
        
        if ( abs( anglediff ) < 2 )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace cap
// Params 0, eflags: 0x4
// Checksum 0xbb1718cf, Offset: 0xf2f
// Size: 0x1e6
function private cap_custom_arrival_handler()
{
    self endon( #"death" );
    self endon( #"cap_exit_completed" );
    assert( isdefined( self.capdata ) );
    self.capdata.var_ec117174c7bbdce6 = 1;
    cap_start( self.capdata.asmname, self.customarrivalanimset );
    initstate = self asmgetcurrentstate( self.asmname );
    logstring( "[CHI-239417] (Entity " + self.subclass + " #:" + self.entity_number + " ) initState [" + initstate + "] set" );
    logstring( "[CHI-239417] (Entity " + self.subclass + " #:" + self.entity_number + " ) Attempting to set state with customArrivalState [" + self.customarrivalstate + "] in [" + self.asmname + "]" );
    self asmsetstate( self.asmname, self.customarrivalstate );
    timeouttime = gettime() + 10000;
    
    while ( !asm::asm_eventfired( self.asmname, "end" ) && gettime() < timeouttime )
    {
        waitframe();
    }
    
    if ( isdefined( self.capdata ) && isdefined( self.capdata.var_ec117174c7bbdce6 ) )
    {
        self.capdata.var_ec117174c7bbdce6 = 0;
    }
    
    logstring( "[CHI-239417] (Entity " + self.subclass + " #:" + self.entity_number + " ) Attempting to set state with initState [" + initstate + "] in [" + self.asmname + "]" );
    self asmsetstate( self.asmname, initstate );
    self notify( #"custom_arrival_handler_done" );
}

// Namespace cap
// Params 1
// Checksum 0x21b81725, Offset: 0x111d
// Size: 0xc9
function function_f97b52e357e14785( group )
{
    assert( isarray( group ) );
    
    if ( !isdefined( level.capgroups ) )
    {
        level.capgroups = [];
    }
    
    newcapgroup = level.capgroups.size;
    level.capgroups[ newcapgroup ] = group;
    
    foreach ( ent in group )
    {
        ent.capgroup = newcapgroup;
    }
}

// Namespace cap
// Params 0
// Checksum 0xc81b9eab, Offset: 0x11ee
// Size: 0x44
function function_1dc69bd8c64496fc()
{
    assert( isdefined( self.capgroup ) && isdefined( level.capgroups[ self.capgroup ] ) );
    
    if ( level.capgroups[ self.capgroup ].size == 0 )
    {
    }
}

// Namespace cap
// Params 0
// Checksum 0x26ea40fa, Offset: 0x123a
// Size: 0xe2
function function_82acad1b355efb61()
{
    if ( isdefined( level.sight_trace_queue ) && utility::function_9dac7ef683ed0e52( level.sight_trace_queue, self ) )
    {
        level notify( #"player_look_at_process" );
        
        if ( isdefined( level.civreactdata.lookatlock ) )
        {
            level.civreactdata.lookatlock = 0;
        }
        
        if ( isdefined( level.sight_trace_queue ) )
        {
            level.sight_trace_queue = undefined;
        }
    }
    
    if ( isdefined( level.var_795e84d9e048e019 ) && utility::function_9dac7ef683ed0e52( level.var_795e84d9e048e019, self ) )
    {
        level notify( #"civilian_process_eye_look_at" );
        
        if ( isdefined( level.civreactdata.civilianlookatlock ) )
        {
            level.civreactdata.civilianlookatlock = 0;
        }
        
        if ( isdefined( level.var_795e84d9e048e019 ) )
        {
            level.var_795e84d9e048e019 = undefined;
        }
    }
}

// Namespace cap
// Params 2
// Checksum 0x7eb71593, Offset: 0x1324
// Size: 0x65
function cap_prop( capname, animset )
{
    self.asmname = capname;
    
    if ( !isdefined( self.asm ) )
    {
        self.asm = spawnstruct();
        self.asm.animoverrides = [];
    }
    
    self.animsetname = animset;
    self.animationarchetype = undefined;
}

// Namespace cap
// Params 2
// Checksum 0xb0ea5a11, Offset: 0x1391
// Size: 0xbe
function function_bb57e4c61b3b6dbd( states, var_56f54d90816c4970 )
{
    self.resumestatetime = [];
    
    if ( !isarray( states ) )
    {
        states = [ states ];
    }
    
    foreach ( state in states )
    {
        self.resumestatetime[ state ] = 0;
    }
    
    if ( isdefined( var_56f54d90816c4970 ) )
    {
        self.var_2fa91f90efb30033 = var_56f54d90816c4970;
    }
}

// Namespace cap
// Params 1
// Checksum 0x15bd734f, Offset: 0x1457
// Size: 0x2a
function function_61f1ed9cea162fab( states )
{
    if ( !isarray( states ) )
    {
        states = [ states ];
    }
    
    self.relativestates = states;
}

// Namespace cap
// Params 4, eflags: 0x4
// Checksum 0x27fee3b8, Offset: 0x1489
// Size: 0x1ab
function private function_82491e1bc74dd239( capasmname, arrivalstate, finalpos, animset )
{
    path = findpathcustom( self.origin, finalpos );
    
    if ( !isdefined( path ) || path.size < 2 )
    {
        assert( "<dev string:x81>" );
        return;
    }
    
    approachang = vectortoangles( finalpos - path[ path.size - 2 ] );
    anglediff = angleclamp180( self.var_9a42f5f373740892.angles[ 1 ] - approachang[ 1 ] );
    angleindex = getangleindex( anglediff, 22.5 );
    
    if ( angleindex == 8 )
    {
        angleindex = 0;
    }
    
    nextindexsign = anglediff + getangleoffset( angleindex );
    
    if ( nextindexsign < 0 )
    {
        nextindexsign = -1;
    }
    else
    {
        nextindexsign = 1;
    }
    
    nextindex = nextindexsign;
    array = function_42a823c020248a21( angleindex, nextindexsign );
    
    for ( arrayindex = 0; arrayindex < array.size ; arrayindex++ )
    {
        caparrivalanim = function_845718f590c62817( arrivalstate, animset, array[ arrayindex ] );
        
        if ( isdefined( caparrivalanim ) )
        {
            pos = function_6de1b23288eb153f( finalpos, angleindex, array[ arrayindex ], nextindexsign, caparrivalanim );
            
            if ( isarray( pos ) )
            {
                self setgoalpath( [ pos[ 0 ], pos[ 1 ] ] );
                return pos;
            }
            
            if ( isdefined( pos ) )
            {
                self setbtgoalradius( 1, 10 );
                self setbtgoalpos( 1, pos );
                return pos;
            }
        }
    }
    
    assert( isdefined( pos ), "<dev string:xac>" );
    return pos;
}

// Namespace cap
// Params 5, eflags: 0x4
// Checksum 0xa6d9316d, Offset: 0x163d
// Size: 0x17b
function private function_6de1b23288eb153f( goalpos, angleindex, closestangleindex, nextindexsign, xanim )
{
    addangle = ( 0, getangleoffset( closestangleindex ), 0 );
    newangle = combineangles( self.interaction_angles, addangle );
    movedelta = getmovedelta( xanim, 0, 1 );
    arrivalanimdis = distance2d( ( 0, 0, 0 ), movedelta );
    adddistance = 40;
    approachpos = goalpos - anglestoforward( newangle ) * ( arrivalanimdis + adddistance );
    navtraceresult = navtrace( goalpos, approachpos, self, 0 );
    
    if ( navtraceresult )
    {
        return;
    }
    
    diff = angleindex - closestangleindex;
    
    if ( abs( diff ) == 4 )
    {
        detourindex = closestangleindex + nextindexsign * -1;
        
        if ( detourindex > 7 )
        {
            detourindex -= 8;
        }
        else if ( detourindex < 0 )
        {
            detourindex += 8;
        }
        
        addangle = ( 0, getangleoffset( detourindex ), 0 );
        newangle = combineangles( self.interaction_angles, addangle );
        detourpos = goalpos - anglestoforward( newangle ) * ( arrivalanimdis + adddistance );
        navtraceresult = navtrace( detourpos, approachpos, self, 0 );
        
        if ( !navtraceresult )
        {
            listpos = [ detourpos, approachpos ];
            return listpos;
        }
    }
    
    return approachpos;
}

// Namespace cap
// Params 1, eflags: 0x4
// Checksum 0x6d13d1ed, Offset: 0x17c1
// Size: 0x65
function private getangleoffset( index )
{
    anglearray = [ 180, 135, 90, 45, 0, -45, -90, -135 ];
    return anglearray[ index ];
}

// Namespace cap
// Params 3, eflags: 0x4
// Checksum 0x35487fb4, Offset: 0x182f
// Size: 0x169
function private function_845718f590c62817( statename, animset, index )
{
    aliasesindex = [ 8, 9, 6, 3, 2, 1, 4, 7, 8 ];
    angleindex = aliasesindex[ index ];
    
    if ( angleindex == 8 )
    {
        angleindex = "8l";
        leftindex = "left" + angleindex;
        leftalias = archetypegetalias( animset, statename, leftindex );
        rightindex = "right" + angleindex;
        rightalias = archetypegetalias( animset, statename, rightindex );
        
        if ( isdefined( leftalias ) && isdefined( rightalias ) )
        {
            return leftalias.anims;
        }
        
        angleindex = "8r";
    }
    
    leftindex = "left" + angleindex;
    leftalias = archetypegetalias( animset, statename, leftindex );
    rightindex = "right" + angleindex;
    rightalias = archetypegetalias( animset, statename, rightindex );
    
    if ( isdefined( leftalias ) )
    {
        assert( isdefined( rightalias ), "<dev string:x107>" + leftindex + "<dev string:x118>" + rightindex );
    }
    
    if ( isdefined( rightalias ) )
    {
        assert( isdefined( leftalias ), "<dev string:x107>" + rightindex + "<dev string:x118>" + leftindex );
    }
    
    if ( isdefined( leftalias ) && isdefined( rightalias ) )
    {
        return leftalias.anims;
    }
}

// Namespace cap
// Params 2, eflags: 0x4
// Checksum 0x3002f9ba, Offset: 0x19a0
// Size: 0xc0
function private function_42a823c020248a21( angleindex, nextindexsign )
{
    closestangleindex = angleindex;
    nextindex = nextindexsign;
    arrayindex = 0;
    array[ arrayindex ] = closestangleindex;
    
    for ( nextangleindex = 1; nextangleindex < 5 ; nextangleindex++ )
    {
        for ( checkbothsides = 0; checkbothsides < 2 ; checkbothsides++ )
        {
            arrayindex++;
            closestangleindex = angleindex + nextangleindex * nextindex;
            
            if ( closestangleindex < 0 )
            {
                closestangleindex += 8;
            }
            else if ( closestangleindex > 7 )
            {
                closestangleindex -= 8;
            }
            
            array[ arrayindex ] = closestangleindex;
            nextindex *= -1;
            
            if ( nextangleindex == 4 )
            {
                break;
            }
        }
    }
    
    return array;
}

