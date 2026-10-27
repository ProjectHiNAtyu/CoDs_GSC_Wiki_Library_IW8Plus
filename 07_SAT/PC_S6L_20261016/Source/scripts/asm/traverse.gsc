// scripts\asm\traverse.gsc  (hash_2ae0c65ffba71f3c.gscc) (size: 33206 Bytes / 0x81b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4217fb6 (3290529718)
// size ...... 33206 (0x81b6)
// includes .. 8   (offset: 0x75c2)
// strings ... 63  (offset: 0x7602)
// dev strs .. 121 (offset: 0x7b56)
// exports ... 43  (offset: 0x575a)
// cseg ...... 0x436 + 0x5324 (0x575a)
// imports ... 174 (offset: 0x5e12)
// animtree1 . 0   (offset: 0x81b6)
// animtree2 . 0   (offset: 0x81b6)
#using scripts\anim\animselector;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace traverse;

// Namespace traverse
// Params 3
// Checksum 0x3fc4c077, Offset: 0x454
// Size: 0x362
function playtraversearrivalanim( asmname, statename, params )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    traverseanim = asm::asm_getanim( asmname, statename );
    assert( isdefined( traverseanim ) );
    traversexanim = asm::asm_getxanim( statename, traverseanim );
    asm_bb::bb_requeststance( "stand" );
    
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        if ( isdefined( self.var_9d40c8bd8f7a879.traverse_height_delta ) )
        {
            self.var_9d40c8bd8f7a879.traverse_height = self.var_9d40c8bd8f7a879.origin[ 2 ] + self.var_9d40c8bd8f7a879.traverse_height_delta;
        }
    }
    else
    {
        startnode = self getnegotiationstartnode();
        
        if ( !isdefined( startnode ) && isdefined( self.traversal_start_node ) )
        {
            startnode = self.traversal_start_node;
        }
        
        assert( isdefined( startnode ) );
        
        if ( isdefined( startnode.traverse_height_delta ) )
        {
            startnode.traverse_height = startnode.origin[ 2 ] + startnode.traverse_height_delta;
        }
        
        endnode = self getnegotiationendnode();
        
        if ( !isdefined( endnode ) && isdefined( self.traversal_end_node ) )
        {
            endnode = self.traversal_end_node;
        }
        
        /#
            if ( !isdefined( endnode ) )
            {
                println( "<dev string:x24>" + startnode.origin );
            }
        #/
        
        self.traversestartnode = startnode;
        self.traverseendnode = endnode;
    }
    
    self animmode( "noclip" );
    self.traversestartz = self.origin[ 2 ];
    self orientmode( "face angle", self.angles[ 1 ] );
    asm::asm_playfacialanim( asmname, statename, traversexanim );
    self.traversexanim = traversexanim;
    self.traverseanimroot = asm::asm_getbodyknob();
    
    if ( isanimation( traverseanim ) )
    {
        assert( self.var_4249813a2840cfc8 == "<dev string:x65>", "<dev string:x7c>" );
        assert( utility::issp() );
        self aisetanim( statename, 0 );
        self clearanim( asm::asm_getinnerrootknob(), 0.2 );
        self setflaggedanim( statename, traverseanim );
    }
    else
    {
        self aisetanim( statename, traverseanim );
    }
    
    if ( self.var_15c6e27c1acff47e == "linkless" )
    {
        self starttraversearrival( 120, self.var_4249813a2840cfc8, self.var_9d40c8bd8f7a879.origin, self.var_9d40c8bd8f7a879.endpos );
    }
    else if ( self.var_15c6e27c1acff47e == "nodeless" )
    {
        self starttraversearrival( 120, self.var_4249813a2840cfc8 );
    }
    else
    {
        self starttraversearrival( 120 );
    }
    
    self.traversedeathindex = 0;
    self.traversedeathanim = undefined;
    self.useanimgoalweight = 1;
    return_note = asm::asm_donotetracks( asmname, statename, &handletraversearrivalwarpnotetracks );
    self animmode( "gravity" );
    
    if ( self.delayeddeath )
    {
        terminatetraverse( asmname, statename );
        return;
    }
}

// Namespace traverse
// Params 3
// Checksum 0x9a4b6a56, Offset: 0x7be
// Size: 0x29
function playtraversearrivalanim_external( asmname, statename, params )
{
    playtraversearrivalanim( asmname, statename, params );
}

// Namespace traverse
// Params 3
// Checksum 0xcd66f79b, Offset: 0x7ef
// Size: 0xa7
function function_e10afdcc708f03ab( asmname, statename, params )
{
    assert( isdefined( level.var_cc3789227d41ba00 ) );
    assert( isdefined( self.traversal_start_node ) );
    assert( isdefined( self.traversal_start_node.animscript ) );
    assert( isdefined( level.var_cc3789227d41ba00[ self.traversal_start_node.animscript ] ) );
    return [[ level.var_cc3789227d41ba00[ self.traversal_start_node.animscript ] ]]( asmname, statename, params );
}

// Namespace traverse
// Params 3, eflags: 0x4
// Checksum 0x706614e6, Offset: 0x89f
// Size: 0x425
function private playtraverseanim_initialize( asmname, statename, params )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    checktraverse( statename );
    bsetupsuccess = 1;
    var_b1dfae9ea4bfb3a8 = 0;
    
    if ( self.var_15c6e27c1acff47e == "not_set" || self.var_15c6e27c1acff47e == "node_based" && !isdefined( self getnegotiationstartnode() ) || ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" ) && !isdefined( self getnegotiationstartpos() ) )
    {
        bsetupsuccess = self setuptraversaltransitioncheck( 120 );
    }
    
    if ( bsetupsuccess )
    {
        if ( self.var_15c6e27c1acff47e == "linkless" )
        {
            startpos = self getnegotiationstartpos();
            
            if ( !isdefined( startpos ) )
            {
                self starttraversearrival( 120, self.var_4249813a2840cfc8, self.var_9d40c8bd8f7a879.origin, self.var_9d40c8bd8f7a879.endpos );
            }
            
            var_b1dfae9ea4bfb3a8 = isdefined( self.var_9d40c8bd8f7a879 ) && self.var_9d40c8bd8f7a879.traverse_data_calculated;
        }
        else if ( self.var_15c6e27c1acff47e == "nodeless" )
        {
            startpos = self getnegotiationstartpos();
            
            if ( !isdefined( startpos ) && self getpath() )
            {
                self starttraversearrival( 120, self.var_4249813a2840cfc8 );
            }
            
            var_b1dfae9ea4bfb3a8 = isdefined( self.var_9d40c8bd8f7a879 ) && self.var_9d40c8bd8f7a879.traverse_data_calculated;
        }
        else if ( self.var_15c6e27c1acff47e == "node_based" )
        {
            startnode = self getnegotiationstartnode();
            
            if ( !isdefined( startnode ) )
            {
                self starttraversearrival( 120 );
                startnode = self getnegotiationstartnode();
            }
            
            if ( isdefined( startnode ) && !isdefined( startnode.traverse_height ) )
            {
                asm::function_83faa08e56039deb( startnode );
            }
            
            endnode = self getnegotiationendnode();
            
            if ( startnode && !startnode.glasschecked )
            {
                startnode.glasschecked = 1;
                contents = trace::create_glass_contents();
                apex = startnode.origin + startnode.apex_delta;
                hits = physics_spherecast( startnode.origin, apex, 30, contents, undefined, "physicsquery_closest", 1, 0 );
                
                foreach ( h in hits )
                {
                    childthread breakglass( h[ "position" ], startnode.origin, statename + "_finished", startnode );
                    foundglass = 1;
                }
                
                if ( !foundglass )
                {
                    hits = physics_spherecast( apex, endnode.origin, 30, contents, undefined, "physicsquery_closest", 1, 0 );
                    
                    foreach ( h in hits )
                    {
                        childthread breakglass( h[ "position" ], apex, statename + "_finished", startnode );
                    }
                }
            }
            
            /#
                if ( isdefined( startnode ) && !isdefined( endnode ) )
                {
                    println( "<dev string:x24>" + startnode.origin );
                }
            #/
            
            self.traversestartnode = startnode;
            self.traverseendnode = endnode;
            var_b1dfae9ea4bfb3a8 = isdefined( startnode ) && isdefined( endnode ) && isdefined( startnode.traverse_height );
        }
    }
    
    return var_b1dfae9ea4bfb3a8;
}

// Namespace traverse
// Params 3
// Checksum 0xbc826482, Offset: 0xccd
// Size: 0xada
function playtraverseanim_scaled( asmname, statename, params )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    var_b1dfae9ea4bfb3a8 = playtraverseanim_initialize( asmname, statename, params );
    
    if ( !var_b1dfae9ea4bfb3a8 )
    {
        terminatetraverse( asmname, statename );
        return;
    }
    
    if ( self.var_a4d7ad445f64c817 )
    {
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
        {
            if ( length( self.var_98c8ef3d59563272 - self.var_9d40c8bd8f7a879.origin ) > 0.001 )
            {
                self.var_a4d7ad445f64c817 = 0;
            }
        }
        else if ( self.var_15c6e27c1acff47e == "node_based" )
        {
            if ( self.traversearrival_node != self.traversestartnode )
            {
                self.var_a4d7ad445f64c817 = 0;
            }
        }
    }
    
    traverseanim = asm::asm_getanim( asmname, statename );
    assert( isdefined( traverseanim ) );
    
    if ( self.var_a4d7ad445f64c817 && statename != self.var_4249813a2840cfc8 )
    {
        terminatetraverse( asmname, statename );
        return;
    }
    
    traversexanim = asm::asm_getxanim( statename, traverseanim );
    asm_bb::bb_requeststance( "stand" );
    
    if ( !( isdefined( traverseanim ) && isdefined( traversexanim ) ) || !animisleaf( traversexanim ) )
    {
        if ( isdefined( traversexanim ) )
        {
            assertmsg( "<dev string:xc8>" + getxhashsourcename( getanimname( traversexanim ) ) + "<dev string:xe0>" );
        }
        else
        {
            assertmsg( "<dev string:xf4>" + asmname + "<dev string:x11b>" + statename );
        }
        
        endpos = undefined;
        
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
        {
            endpos = self.var_9d40c8bd8f7a879.endpos;
        }
        else
        {
            endpos = self.traverseendnode.origin;
        }
        
        if ( isdefined( endpos ) )
        {
            self forceteleport( endpos, self.angles );
        }
        
        terminatetraverse( asmname, statename );
        return;
    }
    
    var_e7f72c3205c43812 = getnotetracktimes( traversexanim, "code_move" );
    
    if ( var_e7f72c3205c43812.size > 0 )
    {
        self.requestarrivalnotify = 1;
    }
    
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        if ( isdefined( self.var_9d40c8bd8f7a879.traverse_height_delta ) )
        {
            self.var_9d40c8bd8f7a879.traverse_height = self.var_9d40c8bd8f7a879.origin[ 2 ] + self.var_9d40c8bd8f7a879.traverse_height_delta;
        }
    }
    else if ( isdefined( self.traversestartnode.traverse_height_delta ) )
    {
        self.traversestartnode.traverse_height = self.traversestartnode.origin[ 2 ] + self.traversestartnode.traverse_height_delta;
    }
    
    self animmode( "noclip" );
    self.traversestartz = self.origin[ 2 ];
    
    if ( self.var_ebd26f6520cc1e89 )
    {
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
        {
            self orientmode( "face angle", self.var_9d40c8bd8f7a879.angles[ 1 ] );
        }
        else
        {
            self orientmode( "face angle", self.traversestartnode.targetangles[ 1 ] );
        }
    }
    else
    {
        self orientmode( "face angle", self.angles[ 1 ] );
    }
    
    shouldusewarpnotetracks = shouldusewarpnotetracks( traversexanim );
    shouldusewarparrival = shouldusewarparrival( traversexanim );
    
    if ( shouldusewarpnotetracks )
    {
        notetrackhandle = &handletraversewarpnotetracks;
    }
    else
    {
        notetrackhandle = &handletraverselegacynotetracks;
        println( "<dev string:x128>", traversexanim, "<dev string:x13e>", statename, "<dev string:x149>" );
        
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
        {
            self orientmode( "face angle", self.var_9d40c8bd8f7a879.angles[ 1 ] );
        }
        else
        {
            self orientmode( "face angle", self.traversestartnode.targetangles[ 1 ] );
        }
        
        if ( !animhasnotetrack( traversexanim, "traverse_align" ) )
        {
            println( "<dev string:x128>", traversexanim, "<dev string:x13e>", statename, "<dev string:x188>" );
            handletraversealignment();
        }
    }
    
    asm::asm_playfacialanim( asmname, statename, traversexanim );
    self.traversexanim = traversexanim;
    self.traverseanimroot = asm::asm_getbodyknob();
    
    if ( statename == "traverse_external" || statename == "traverse_warp_external" )
    {
        assert( utility::issp() );
        self aisetanim( statename, 0 );
        self clearanim( asm::asm_getinnerrootknob(), 0.2 );
        self setflaggedanim( statename, self.traversexanim );
    }
    else
    {
        self aisetanim( statename, traverseanim, self.animplaybackratedefault, self.var_43b5a8570d41fe2c ?? 0 );
    }
    
    if ( shouldusewarparrival && !isagent( self ) && ( !self.var_a4d7ad445f64c817 || !self.var_8b305093078ce8d4 ) )
    {
        assert( animhasnotetrack( traversexanim, "<dev string:x1a9>" ) );
        arrivalendtime = getnotetracktimes( traversexanim, "warp_arrival_end" )[ 0 ];
        
        if ( arrivalendtime > self.var_43b5a8570d41fe2c )
        {
            self setanimtime( traversexanim, arrivalendtime );
        }
    }
    
    self.traversedeathindex = 0;
    self.traversedeathanim = undefined;
    self.useanimgoalweight = 1;
    traversalattributes = spawnstruct();
    
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        traversalattributes.startpos = self.var_9d40c8bd8f7a879.origin;
        traversalattributes.endpos = self.var_d87cab901a66356c;
        traversalattributes.apex_delta = self.var_9d40c8bd8f7a879.apex_delta;
        traversalattributes.angles = self.var_9d40c8bd8f7a879.angles;
        traversalattributes.across_delta = self.var_9d40c8bd8f7a879.across_delta;
    }
    else
    {
        assert( isdefined( self.traversestartnode ) && isdefined( self.traversestartnode.apex_delta ), "<dev string:x1ba>" );
        traversalattributes.startpos = self.traversestartnode.origin;
        traversalattributes.apex_delta = self.traversestartnode.apex_delta;
        traversalattributes.angles = self.traversestartnode.targetangles;
        
        if ( isdefined( self.traverseendnode ) )
        {
            traversalattributes.endpos = self.traverseendnode.origin;
        }
        else
        {
            assertmsg( "<dev string:x23f>" + traversalattributes.startpos );
            terminatetraverse( asmname, statename );
            return;
        }
        
        traversalattributes.across_delta = self.traversestartnode.across_delta;
    }
    
    if ( ai::is_floating() )
    {
        if ( isdefined( self.var_6dc86b2b0dd51e07 ) )
        {
            self [[ self.var_6dc86b2b0dd51e07 ]]( traversalattributes, self.var_4249813a2840cfc8 );
            return;
        }
        else
        {
            old_apex_point = traversalattributes.startpos + traversalattributes.apex_delta;
            traversalattributes.startpos += ( 0, 0, self.var_ed3c19fec55b26cc );
            traversalattributes.endpos += ( 0, 0, max( self.var_69623111d7e6b9a4 - self.var_87edd2358c253b2c, 0 ) );
            
            if ( self.var_4249813a2840cfc8 == "traverse_warp_over" || self.var_4249813a2840cfc8 == "traverse_warp_across" )
            {
                var_666c4979f0ed8c1d = max( max( traversalattributes.apex_delta[ 2 ] + 10 - self.var_ed3c19fec55b26cc, traversalattributes.endpos[ 2 ] - traversalattributes.startpos[ 2 ] ), 0 );
                trace_endpoint = self aiphysicstrace( old_apex_point + ( 0, 0, 10 ), old_apex_point + ( 0, 0, self.var_ed3c19fec55b26cc + var_666c4979f0ed8c1d - traversalattributes.apex_delta[ 2 ] ) );
                var_666c4979f0ed8c1d = trace_endpoint[ 2 ] - traversalattributes.startpos[ 2 ];
                traversalattributes.apex_delta = ( traversalattributes.apex_delta[ 0 ], traversalattributes.apex_delta[ 1 ], var_666c4979f0ed8c1d );
            }
        }
    }
    
    self settraversalattributes( traversalattributes.startpos, traversalattributes.endpos, traversalattributes.angles, traversalattributes.apex_delta, traversalattributes.across_delta );
    
    if ( self function_62c36214f50430fd() )
    {
        childthread function_23e12020be882c49( traversalattributes.startpos, traversalattributes.endpos, traversalattributes.angles, asmname, statename );
    }
    
    return_note = asm::asm_donotetracks( asmname, statename, notetrackhandle, undefined, undefined, 0 );
    
    if ( return_note == "code_move" )
    {
        assert( var_e7f72c3205c43812.size > 0, "<dev string:x277>" + getxhashsourcename( getanimname( traversexanim ) ) );
        
        if ( isdefined( self.pathgoalpos ) )
        {
            self motionwarpcancel();
            self animmode( "normal" );
            self orientmode( "face motion" );
        }
        
        if ( !asm::asm_eventfired( asmname, "finish" ) && !asm::asm_eventfired( asmname, "end" ) )
        {
            asm::asm_donotetracks( asmname, statename, notetrackhandle );
        }
    }
    
    self animmode( "gravity" );
    
    if ( self.delayeddeath )
    {
        terminatetraverse( asmname, statename );
        return;
    }
    
    self.a.nodeath = 0;
    self.a.movement = "run";
    self.traverseanimroot = undefined;
    self.traversexanim = undefined;
    ai::clear_deathanim();
    terminatetraverse( asmname, statename );
}

// Namespace traverse
// Params 2
// Checksum 0xdc4076b8, Offset: 0x17af
// Size: 0x7d
function terminatetraverse( asmname, statename )
{
    self.useanimgoalweight = 0;
    self.var_a4d7ad445f64c817 = 0;
    self.istraversing = 0;
    self.jump_over_position = undefined;
    self.traversal_start_node = undefined;
    self.traversestartnode = undefined;
    self.traverseendnode = undefined;
    asm::asm_fireevent( asmname, "traverse_end" );
    
    if ( isalive( self ) )
    {
        self finishtraverse();
    }
    
    self motionwarpcancel();
}

// Namespace traverse
// Params 5, eflags: 0x4
// Checksum 0x5b5c8f73, Offset: 0x1834
// Size: 0x170
function private function_23e12020be882c49( startpos, endpos, angles, asmname, statename )
{
    radius = self getboundshalfsize()[ 0 ];
    radiussqrd = radius * radius;
    searchradius = radius * 3;
    
    while ( true )
    {
        vehicles = vehicle_getarrayinradius( endpos, searchradius );
        
        foreach ( vehicle in vehicles )
        {
            if ( vehicle.streakinfo || vehicle function_a7378c4908103226() )
            {
                continue;
            }
            
            point = math::function_1243a6cc6a030f2a( endpos, vehicle getcentroid(), vehicle getboundshalfsize(), vehicle.angles );
            
            if ( distancesquared( point, endpos ) < radiussqrd )
            {
                self forceteleport( startpos, angles );
                terminatetraverse( asmname, statename );
                self enabletraversals( 0 );
                utility::delaycallendon( getdvarfloat( @"hash_653c24ef0aa025a1", 5 ), "death", &enabletraversals );
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace traverse
// Params 0
// Checksum 0xe2c3afcb, Offset: 0x19ac
// Size: 0xa8
function handletraversealignment()
{
    self animmode( "noclip" );
    targettraverseheight = undefined;
    
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        targettraverseheight = self.var_9d40c8bd8f7a879.traverse_height;
    }
    else
    {
        targettraverseheight = self.traversestartnode.traverse_height;
    }
    
    if ( isdefined( self.traverseheight ) && isdefined( targettraverseheight ) )
    {
        currentheight = targettraverseheight - self.traversestartz;
        thread teleportthread( currentheight - self.traverseheight );
    }
}

// Namespace traverse
// Params 1
// Checksum 0x364df18e, Offset: 0x1a5c
// Size: 0x48
function handletraverselegacynotetracks( note )
{
    if ( note == "traverse_death" )
    {
        return handletraversedeathnotetrack();
    }
    
    if ( note == "traverse_align" )
    {
        return handletraversealignment();
    }
    
    if ( note == "traverse_drop" )
    {
        return handletraversedrop();
    }
}

// Namespace traverse
// Params 0
// Checksum 0x61845c6f, Offset: 0x1aac
// Size: 0x31e
function handletraversedrop()
{
    self animmode( "noclip" );
    endnode = self.traverseendnode;
    
    if ( !isdefined( endnode ) )
    {
        endnode = spawnstruct();
        endnode.angles = self.traversestartnode.angles;
        endnode.origin = self getnegotiationendpos();
        assert( isdefined( endnode.origin ) );
    }
    
    targetangles = endnode.angles;
    
    if ( self.traversestartnode.targetangles )
    {
        targetangles = self.traversestartnode.targetangles;
    }
    
    endnotetracks = getnotetracktimes( self.traversexanim, "footstep_left_large" );
    
    if ( endnotetracks.size == 0 )
    {
        endnotetracks = getnotetracktimes( self.traversexanim, "footstep_right_large" );
    }
    
    animendfrac = 1;
    
    if ( endnotetracks.size > 0 )
    {
        animendfrac = endnotetracks[ 0 ];
    }
    
    animstartfrac = getnotetracktimes( self.traversexanim, "traverse_drop" )[ 0 ];
    animdelta = getmovedelta( self.traversexanim, animstartfrac, animendfrac );
    animdelta = rotatevector( animdelta, targetangles );
    var_6bf206179eb61140 = 512;
    tracestart = ( self.origin[ 0 ] + animdelta[ 0 ], self.origin[ 1 ] + animdelta[ 1 ], self.origin[ 2 ] );
    targetpos = getgroundposition( tracestart, 10, var_6bf206179eb61140, 12 );
    assert( tracestart[ 2 ] - targetpos[ 2 ] < var_6bf206179eb61140, "<dev string:x296>" + var_6bf206179eb61140 + "<dev string:x2b8>" + tracestart );
    var_300329678ee5d9ae = 0.05;
    var_cebde5dc94888d91 = 30;
    zdelta = abs( targetpos[ 2 ] - self.origin[ 2 ] );
    
    if ( zdelta < var_300329678ee5d9ae * abs( animdelta[ 2 ] ) || zdelta > var_cebde5dc94888d91 )
    {
        println( "<dev string:x2ca>" + self.traversestartnode.origin + "<dev string:x2fc>" );
        targetpos = ( targetpos[ 0 ], targetpos[ 1 ], endnode.origin[ 2 ] );
    }
    
    nextcorner = self getpointafternegotiation();
    
    if ( !isdefined( endnode.origin ) )
    {
        endnode.origin = self.traversestartnode.end_node_origin;
    }
    
    if ( isdefined( nextcorner ) )
    {
        targetyaw = vectortoyaw( nextcorner - endnode.origin );
        targetdist = clamp( angleclamp180( targetyaw - self.angles[ 1 ] ), -30, 30 );
        targetyaw = angleclamp180( self.angles[ 1 ] + targetdist );
        targetangles = ( 0, targetyaw, 0 );
    }
    
    utility::motionwarpwithtimes( self.traversexanim, targetpos, targetangles, animstartfrac, animendfrac );
    thread finishtraversedrop( targetpos[ 2 ] );
}

// Namespace traverse
// Params 1
// Checksum 0x196dea3a, Offset: 0x1dd2
// Size: 0x52
function finishtraversedrop( finalz )
{
    self endon( #"killanimscript" );
    self endon( #"death" );
    finalz += 2;
    
    while ( true )
    {
        if ( self.origin[ 2 ] < finalz )
        {
            self motionwarpcancel();
            break;
        }
        
        waitframe();
    }
}

// Namespace traverse
// Params 1
// Checksum 0x6e96235c, Offset: 0x1e2c
// Size: 0x7a
function teleportthread( verticaloffset )
{
    self endon( #"killanimscript" );
    self notify( #"hash_3a0146d400fab409" );
    self endon( #"hash_3a0146d400fab409" );
    reps = 5;
    offset = ( 0, 0, verticaloffset / reps );
    
    for ( i = 0; i < reps ; i++ )
    {
        self forceteleport( self.origin + offset );
        waitframe();
    }
}

// Namespace traverse
// Params 4
// Checksum 0x7ed2cff7, Offset: 0x1eae
// Size: 0xea
function teleportthreadex( verticaloffset, delay, frames, animrate )
{
    self endon( #"killanimscript" );
    self endon( #"death" );
    self notify( #"hash_3a0146d400fab409" );
    self endon( #"hash_3a0146d400fab409" );
    
    if ( verticaloffset == 0 || frames <= 0 )
    {
        return;
    }
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    offset = ( 0, 0, verticaloffset / frames );
    
    if ( animrate < 1 )
    {
        self aisetanimrate( self.traversexanim, animrate );
    }
    
    for ( i = 0; i < frames ; i++ )
    {
        self forceteleport( self.origin + offset );
        waitframe();
    }
    
    if ( animrate < 1 )
    {
        self aisetanimrate( self.traversexanim, 1 );
    }
}

// Namespace traverse
// Params 1
// Checksum 0x5f00a714, Offset: 0x1fa0
// Size: 0xe5, Type: bool
function shouldusewarpnotetracks( traversexanim )
{
    if ( animhasnotetrack( traversexanim, "warp_up_start" ) )
    {
        assert( animhasnotetrack( traversexanim, "<dev string:x384>" ) );
        return true;
    }
    
    if ( animhasnotetrack( traversexanim, "warp_across_start" ) )
    {
        assert( animhasnotetrack( traversexanim, "<dev string:x390>" ) );
        return true;
    }
    
    if ( animhasnotetrack( traversexanim, "warp_down_start" ) )
    {
        assert( animhasnotetrack( traversexanim, "<dev string:x3a0>" ) );
        return true;
    }
    
    if ( animhasnotetrack( traversexanim, "warp_up_start_new" ) )
    {
        assert( animhasnotetrack( traversexanim, "<dev string:x3ae>" ) );
        return true;
    }
    
    if ( animhasnotetrack( traversexanim, "warp_down_start_new" ) )
    {
        assert( animhasnotetrack( traversexanim, "<dev string:x3be>" ) );
        return true;
    }
    
    if ( animhasnotetrack( traversexanim, "MotionWarpNoteStart" ) )
    {
        assert( animhasnotetrack( traversexanim, "<dev string:x3d0>" ) );
        return true;
    }
    
    return false;
}

// Namespace traverse
// Params 1
// Checksum 0x1999b552, Offset: 0x208e
// Size: 0x31, Type: bool
function shouldusewarparrival( traversexanim )
{
    if ( animhasnotetrack( traversexanim, "warp_arrival_start" ) )
    {
        assert( animhasnotetrack( traversexanim, "<dev string:x1a9>" ) );
        return true;
    }
    
    return false;
}

// Namespace traverse
// Params 4
// Checksum 0x80d38d30, Offset: 0x20c8
// Size: 0xe2, Type: bool
function function_37de92bd80b343dd( asmname, statename, tostatename, params )
{
    if ( self.var_15c6e27c1acff47e == "not_set" )
    {
        return false;
    }
    
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        start_pos = self.var_fa685a7668b11923;
    }
    else
    {
        assert( self.var_15c6e27c1acff47e == "<dev string:x3e4>" );
        start_pos = self.traversal_start_node.origin;
    }
    
    disttonode = distance2d( self.origin, start_pos );
    look_ahead = 120;
    
    if ( isdefined( params ) )
    {
        look_ahead = int( params );
    }
    
    if ( disttonode > look_ahead )
    {
        return false;
    }
    
    return true;
}

// Namespace traverse
// Params 4
// Checksum 0x713c95d7, Offset: 0x21b3
// Size: 0x3a, Type: bool
function shoulddotraditionaltraverse( asmname, statename, tostatename, params )
{
    if ( self.var_4249813a2840cfc8 != params )
    {
        return false;
    }
    
    return true;
}

// Namespace traverse
// Params 3
// Checksum 0x17cf68e0, Offset: 0x21f6
// Size: 0x34
function traverse_cleanup( asmname, statename, params )
{
    self motionwarpcancel();
    self finishtraverse();
    self.var_a4d7ad445f64c817 = 0;
}

/#

    // Namespace traverse
    // Params 4
    // Checksum 0x878841b1, Offset: 0x2232
    // Size: 0x530, Type: dev
    function function_d9524f43ab31640d( featurearray, alias, var_7ae5ee1b8c4d1a96, translationstartfrac )
    {
        no_recorder = getdvarint( @"recorder_enablerec", 0 ) <= 0;
        textheight = 70;
        
        if ( no_recorder )
        {
            print3d( self.origin + ( 0, 0, textheight ), "<dev string:x3eb>" + self.var_4249813a2840cfc8 + "<dev string:x3f2>", ( 1, 0, 1 ), 1, 0.5, 80 );
        }
        
        record3dtext( "<dev string:x3eb>" + self.var_4249813a2840cfc8 + "<dev string:x3f2>", self.origin + ( 0, 0, textheight ), ( 1, 0, 1 ) );
        
        foreach ( key, value in featurearray )
        {
            textheight -= 10;
            
            if ( no_recorder )
            {
                print3d( self.origin + ( 0, 0, textheight ), key + "<dev string:x3f4>" + value + "<dev string:x3f2>", ( 1, 0, 1 ), 1, 0.5, 80 );
            }
            
            record3dtext( key + "<dev string:x3f4>" + value + "<dev string:x3f2>", self.origin + ( 0, 0, textheight ), ( 1, 0, 1 ) );
        }
        
        if ( isdefined( alias ) )
        {
            textheight -= 10;
            
            if ( no_recorder )
            {
                print3d( self.origin + ( 0, 0, textheight ), "<dev string:x3f7>" + alias + "<dev string:x3f2>", ( 1, 0, 1 ), 1, 0.5, 80 );
            }
            
            record3dtext( "<dev string:x3f7>" + alias + "<dev string:x3f2>", self.origin + ( 0, 0, textheight ), ( 1, 0, 1 ) );
        }
        
        if ( isdefined( var_7ae5ee1b8c4d1a96 ) )
        {
            textheight -= 10;
            
            if ( no_recorder )
            {
                print3d( self.origin + ( 0, 0, textheight ), "<dev string:x408>" + var_7ae5ee1b8c4d1a96, ( 1, 0, 1 ), 1, 0.5, 80 );
            }
            
            record3dtext( "<dev string:x408>" + var_7ae5ee1b8c4d1a96, self.origin + ( 0, 0, textheight ), ( 1, 0, 1 ) );
        }
        
        if ( translationstartfrac > 0 )
        {
            textheight -= 10;
            
            if ( no_recorder )
            {
                print3d( self.origin + ( 0, 0, textheight ), "<dev string:x41f>" + translationstartfrac, ( 1, 0, 1 ), 1, 0.5, 80 );
            }
            
            record3dtext( "<dev string:x41f>" + translationstartfrac, self.origin + ( 0, 0, textheight ), ( 1, 0, 1 ) );
        }
        
        startnode = self.traversal_start_node ?? self.var_9d40c8bd8f7a879;
        debugstart = startnode.origin;
        debugapex = undefined;
        
        if ( isdefined( startnode.apex_delta ) )
        {
            debugapex = debugstart + startnode.apex_delta;
        }
        
        if ( isdefined( self.traversal_end_node ) )
        {
            debugend = self.traversal_end_node.origin;
        }
        else
        {
            debugend = self.var_9d40c8bd8f7a879.endpos;
        }
        
        sphere( debugstart, 5, ( 0, 0, 1 ), 0, 80 );
        recordsphere( debugstart, 5, ( 0, 0, 1 ) );
        
        if ( isdefined( debugapex ) )
        {
            line( debugstart, debugapex, ( 0, 1, 0 ), 1, 0, 80 );
            recordline( debugstart, debugapex, ( 0, 1, 0 ) );
            sphere( debugapex, 5, ( 0, 1, 0 ), 0, 80 );
            recordsphere( debugstart, 5, ( 0, 1, 0 ) );
            
            if ( isdefined( startnode.across_delta ) )
            {
                debugacross = debugapex + startnode.across_delta;
                sphere( debugacross, 5, ( 1, 0, 0 ), 0, 80 );
                recordsphere( debugacross, 5, ( 1, 0, 0 ) );
                line( debugapex, debugacross, ( 1, 0, 0 ), 0, 80 );
                recordline( debugapex, debugacross, ( 1, 0, 0 ) );
                debugapex = debugacross;
            }
            
            line( debugapex, debugend, ( 1, 0, 1 ), 1, 0, 80 );
            recordline( debugapex, debugend, ( 1, 0, 0 ) );
        }
        
        sphere( debugend, 5, ( 1, 0, 1 ), 0, 80 );
        recordsphere( debugend, 5, ( 1, 0, 1 ) );
    }

#/

// Namespace traverse
// Params 1
// Checksum 0x75e34ba0, Offset: 0x276a
// Size: 0x126
function function_a87a0d0af157820e( params )
{
    assert( isai( self ) && ai::is_floating() );
    height_delta = self.var_ed3c19fec55b26cc - params.height;
    drop_height_delta = max( self.var_69623111d7e6b9a4 - self.var_87edd2358c253b2c, 0 ) - params.drop_height;
    apex_height_delta = max( max( height_delta, drop_height_delta ), 10 );
    
    if ( isdefined( self.traversal_start_node ) && isdefined( self.traversal_start_node.apex_delta ) )
    {
        apex_point = self.traversal_start_node.origin + self.traversal_start_node.apex_delta;
        trace_endpoint = self aiphysicstrace( apex_point, apex_point + ( 0, 0, apex_height_delta ) );
        apex_height_delta = max( trace_endpoint[ 2 ] - apex_point[ 2 ], 0 );
    }
    
    params.height = apex_height_delta - height_delta;
    params.drop_height = apex_height_delta - drop_height_delta;
}

// Namespace traverse
// Params 0
// Checksum 0xd12bb4b9, Offset: 0x2898
// Size: 0xf2
function function_e51c2dd7b73c2c61()
{
    traverse_start_pos = self.var_fa685a7668b11923;
    traverse_end_pos = self.var_d87cab901a66356c;
    warp_params = spawnstruct();
    apex_point = self.var_6f7332592644a178;
    
    if ( isdefined( apex_point ) )
    {
        warp_params.traverse_data_calculated = 1;
        warp_params.traverse_height = apex_point[ 2 ];
        warp_params.traverse_height_delta = apex_point[ 2 ] - traverse_start_pos[ 2 ];
        warp_params.traverse_drop_height_delta = apex_point[ 2 ] - traverse_end_pos[ 2 ];
        warp_params.apex_delta = apex_point - traverse_start_pos;
        warp_params.angles = vectortoangles( utility::flat_origin( traverse_end_pos - traverse_start_pos ) );
        warp_params.origin = traverse_start_pos;
        warp_params.endpos = traverse_end_pos;
        warp_params.traversetype = "traverse_warp_over";
    }
    
    return warp_params;
}

// Namespace traverse
// Params 0
// Checksum 0x7f596ee, Offset: 0x2993
// Size: 0x15b
function function_b4671daaf4716143()
{
    traverse_start_pos = self.var_fa685a7668b11923;
    traverse_end_pos = self.var_d87cab901a66356c;
    warp_params = spawnstruct();
    warp_params.angles = vectortoangles( utility::flat_origin( traverse_end_pos - traverse_start_pos ) );
    warp_params.origin = traverse_start_pos;
    warp_params.endpos = traverse_end_pos;
    
    if ( abs( traverse_start_pos[ 2 ] - traverse_end_pos[ 2 ] ) < 5 )
    {
        apex_point = averagepoint( [ traverse_start_pos, traverse_end_pos ] );
    }
    else
    {
        apex_point = asm::function_5f6e47af34199e3a( traverse_start_pos, traverse_end_pos );
        
        if ( !isdefined( apex_point ) )
        {
            apex_point = averagepoint( [ traverse_start_pos, traverse_end_pos ] );
        }
    }
    
    if ( isdefined( apex_point ) )
    {
        warp_params.traverse_data_calculated = 1;
        warp_params.traverse_height = apex_point[ 2 ];
        warp_params.traverse_height_delta = apex_point[ 2 ] - traverse_start_pos[ 2 ];
        warp_params.traverse_drop_height_delta = apex_point[ 2 ] - traverse_end_pos[ 2 ];
        warp_params.apex_delta = apex_point - traverse_start_pos;
        warp_params.traversetype = function_47b418a27ea582b4( undefined, warp_params );
    }
    
    if ( warp_params.traversetype == "traverse_warp_across" )
    {
        warp_params.across_delta = traverse_end_pos - traverse_start_pos;
    }
    
    return warp_params;
}

// Namespace traverse
// Params 2
// Checksum 0xd3292100, Offset: 0x2af7
// Size: 0x385
function function_47b418a27ea582b4( currenttype, traverse_params )
{
    if ( isdefined( currenttype ) && isdefined( asm::asm_lookupanimfromaliasifexists( "traverse_custom", currenttype ) ) && self asmhasstate( self.asmname, "traverse_custom" ) )
    {
        return "traverse_custom";
    }
    
    if ( isdefined( self.traverse_traversetype ) )
    {
        if ( self.traverse_traversetype == "traverse_wall" )
        {
            return "traverse_wall";
        }
        else if ( self.traverse_traversetype == "traverse_ground" )
        {
            return "traverse_ground";
        }
    }
    
    if ( currenttype == "portal" )
    {
        return "portal";
    }
    
    across_dist_preferred = 108;
    across_height = 100;
    mantle_min_height = 20;
    height_delta = 0;
    drop_height_delta = 0;
    across_dist = undefined;
    
    if ( isdefined( traverse_params ) )
    {
        assert( traverse_params.traverse_data_calculated );
        height_delta = traverse_params.traverse_height_delta;
        drop_height_delta = traverse_params.traverse_drop_height_delta;
        
        if ( isdefined( traverse_params.across_delta ) )
        {
            across_dist = length2d( traverse_params.across_delta );
        }
        else if ( !isdefined( currenttype ) || currenttype == "traverse_warp_across" || !isdefined( traverse_params.traversetype ) || traverse_params.traversetype == "traverse_warp_across" )
        {
            across_dist = length2d( traverse_params.endpos - traverse_params.origin );
        }
    }
    else
    {
        startpos = self getnegotiationstartpos();
        
        if ( !isdefined( startpos ) )
        {
            startnode = self.traversal_start_node;
            
            if ( isdefined( startnode ) )
            {
                startpos = startnode.origin;
            }
            else
            {
                startpos = self.origin;
            }
        }
        
        endpos = self getnegotiationendpos();
        
        if ( !isdefined( endpos ) )
        {
            if ( isdefined( self.traversal_end_node ) )
            {
                endpos = self.traversal_end_node.origin;
            }
            else
            {
                assertmsg( "<dev string:x43c>" + startpos );
                return;
            }
        }
        
        if ( abs( startpos[ 2 ] - endpos[ 2 ] ) < 5 )
        {
            apexpoint = averagepoint( [ startpos, endpos ] );
        }
        else
        {
            apexpoint = asm::function_5f6e47af34199e3a( startpos, endpos );
            
            if ( !isdefined( apexpoint ) )
            {
                assertmsg( "<dev string:x475>" + startpos + "<dev string:x4b0>" + endpos );
                return;
            }
        }
        
        height_delta = apexpoint[ 2 ] - startpos[ 2 ];
        drop_height_delta = apexpoint[ 2 ] - endpos[ 2 ];
        
        if ( !( isdefined( startnode ) && isdefined( startnode.animscript ) ) || startnode.animscript == "traverse_warp_across" )
        {
            across_dist = length2d( endpos - startpos );
        }
    }
    
    if ( ai::is_floating() )
    {
        params = { #drop_height:drop_height_delta, #height:height_delta };
        function_a87a0d0af157820e( params );
        height_delta = params.height;
        drop_height_delta = params.drop_height;
    }
    
    if ( across_dist > across_dist_preferred && height_delta < across_height && drop_height_delta < across_height )
    {
        return "traverse_warp_across";
    }
    
    if ( height_delta > mantle_min_height && drop_height_delta > mantle_min_height )
    {
        return "traverse_warp_over";
    }
    
    if ( height_delta < mantle_min_height && drop_height_delta < mantle_min_height )
    {
        return "traverse_warp_across";
    }
    
    if ( drop_height_delta < height_delta )
    {
        return "traverse_warp_up";
    }
    
    if ( drop_height_delta >= height_delta )
    {
        return "traverse_warp_down";
    }
}

// Namespace traverse
// Params 1, eflags: 0x4
// Checksum 0xc1cf322d, Offset: 0x2e85
// Size: 0xb6, Type: bool
function private isvalidtraversetype( type )
{
    if ( !isdefined( type ) )
    {
        return false;
    }
    
    switch ( type )
    {
        case #"hash_20e18a3582122c1f":
        case #"hash_2517ba3af2f13858":
        case #"hash_3929e05b5be2d50d":
        case #"hash_668adb9645eda622":
        case #"hash_9e0d753b4c4375e3":
        case #"hash_e8ee1dc75e1bef22":
            return true;
        case #"hash_52f2fd565c92f171":
        case #"hash_e274e845c3302f78":
            assert( self asmhasstate( self.asmname, type ), "<dev string:x4bc>" + self.asmname + "<dev string:x4c7>" + type );
            return true;
    }
    
    return false;
}

// Namespace traverse
// Params 2
// Checksum 0x25888757, Offset: 0x2f44
// Size: 0x219
function function_b1f841aaaec3f50b( featurearray, type )
{
    featurearray = arraycopy( featurearray );
    
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        assert( isdefined( self.var_9d40c8bd8f7a879 ) && self.var_9d40c8bd8f7a879.traverse_data_calculated, "<dev string:x4f9>" );
    }
    else if ( self.var_15c6e27c1acff47e == "node_based" )
    {
        assert( isdefined( self.traversal_start_node ) && isdefined( self.traversal_start_node.traverse_height ), "<dev string:x539>" );
        
        if ( isdefined( self.traversal_start_node ) )
        {
            end_node = self.traversal_end_node;
            
            if ( isdefined( end_node ) )
            {
                if ( type == "traverse_warp_up" || issubstr( type, "climb_building_up" ) )
                {
                    featurearray[ "drop_height" ] = 0;
                    featurearray[ "height" ] = end_node.origin[ 2 ] - self.traversal_start_node.origin[ 2 ];
                }
                else if ( type == "traverse_warp_down" || issubstr( type, "climb_building_down" ) )
                {
                    featurearray[ "drop_height" ] = self.traversal_start_node.origin[ 2 ] - end_node.origin[ 2 ];
                    featurearray[ "height" ] = 0;
                }
                else if ( type == "traverse_warp_across" )
                {
                    featurearray[ "length" ] = distance2d( self.traversal_start_node.origin, end_node.origin );
                }
            }
        }
    }
    
    featurearray[ "climb_building_type" ] = "";
    
    if ( issubstr( type, "climb_building_up" ) )
    {
        tokens = strtok( type, "_" );
        
        if ( tokens[ 3 ] )
        {
            featurearray[ "climb_building_type" ] = tokens[ 3 ];
        }
    }
    
    if ( isdefined( self.var_6528526395085bc ) )
    {
        featurearray = function_c6c06162c8e6ae75( self.var_6528526395085bc, featurearray );
    }
    
    return featurearray;
}

// Namespace traverse
// Params 3
// Checksum 0xbbd08228, Offset: 0x3166
// Size: 0xeb0
function calctraversetype( asmname, statename, params )
{
    var_bfbd522a221be6d9 = undefined;
    var_732f480266a422a6 = self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless";
    
    if ( var_732f480266a422a6 )
    {
        if ( self.var_15c6e27c1acff47e == "linkless" && ( self.var_ef53ce9913fe1a35 == "fence" || self.var_ef53ce9913fe1a35 == "script" ) )
        {
            if ( self.var_ef53ce9913fe1a35 == "fence" )
            {
                var_bfbd522a221be6d9 = &function_e51c2dd7b73c2c61;
            }
            else
            {
                var_bfbd522a221be6d9 = &function_b4671daaf4716143;
            }
        }
        else if ( self.var_15c6e27c1acff47e == "nodeless" )
        {
            var_bfbd522a221be6d9 = &function_b4671daaf4716143;
        }
        
        assert( isdefined( var_bfbd522a221be6d9 ), "<dev string:x574>" );
        self.var_9d40c8bd8f7a879 = self [[ var_bfbd522a221be6d9 ]]();
    }
    
    self.var_a4d7ad445f64c817 = 1;
    self.var_4249813a2840cfc8 = self.traverse_traversetype;
    
    if ( var_732f480266a422a6 )
    {
        self.var_4249813a2840cfc8 = self.var_9d40c8bd8f7a879.traversetype;
        self.traverse_traversetype = self.var_9d40c8bd8f7a879.traversetype;
        self.var_98c8ef3d59563272 = self.var_9d40c8bd8f7a879.origin;
    }
    else
    {
        if ( !isvalidtraversetype( self.var_4249813a2840cfc8 ) )
        {
            self.var_4249813a2840cfc8 = function_47b418a27ea582b4( self.var_4249813a2840cfc8 );
        }
        
        self.traversearrival_node = self.traversal_start_node;
        
        if ( self.var_4249813a2840cfc8 == "portal" )
        {
            return;
        }
    }
    
    if ( !isdefined( self.var_4249813a2840cfc8 ) || !self asmhasstate( asmname, self.var_4249813a2840cfc8 ) )
    {
        function_57247b43a1dde975();
        return;
    }
    else if ( self.var_4249813a2840cfc8 == "traverse_warp_external" )
    {
        assert( self.var_15c6e27c1acff47e == "<dev string:x5c2>", "<dev string:x5cd>" );
        assert( isdefined( self.traversal_start_node ), "<dev string:x5f8>" + self.var_15c6e27c1acff47e + "<dev string:x61b>" + self.traverse_traversetype + "<dev string:x61e>" );
        assert( isdefined( self.traversal_start_node.animscript ) );
        customname = self.traversal_start_node.animscript;
        assert( isdefined( level.var_cc3789227d41ba00 ), "<dev string:x62a>" + customname );
        assert( isdefined( level.var_cc3789227d41ba00[ customname ] ), "<dev string:x6a3>" + customname + "<dev string:x717>" );
        self.traversalhasarrival = 1;
        self.var_8b305093078ce8d4 = 1;
        
        if ( isdefined( level.var_cc3789227d41ba00[ customname ] ) )
        {
            traverseanim = self [[ level.var_cc3789227d41ba00[ customname ] ]]( asmname, statename, params );
            assert( isdefined( traverseanim ) );
            assert( isanimation( traverseanim ) );
            self.var_ed2f86f082cf88f9 = getmovedelta( traverseanim, 0, 1 );
            return;
        }
        
        function_57247b43a1dde975();
        return;
    }
    
    if ( var_732f480266a422a6 )
    {
        assert( isdefined( self.var_9d40c8bd8f7a879 ), "<dev string:x71b>" + self.var_15c6e27c1acff47e + "<dev string:x61b>" + self.traverse_traversetype + "<dev string:x61e>" );
        featurearray = [];
        featurearray[ "height" ] = self.var_9d40c8bd8f7a879.traverse_height_delta;
        featurearray[ "drop_height" ] = self.var_9d40c8bd8f7a879.traverse_drop_height_delta;
        featurearray[ "arrival_yaw" ] = angleclamp180( self.var_9d40c8bd8f7a879.angles[ 1 ] - self.angles[ 1 ] );
        featurearray[ "speed" ] = self function_53510b1da83172ce();
        
        if ( self.var_4249813a2840cfc8 == "traverse_warp_across" && isdefined( self.var_9d40c8bd8f7a879.across_delta ) )
        {
            featurearray[ "length" ] = length2d( self.var_9d40c8bd8f7a879.across_delta );
        }
    }
    else if ( self.var_15c6e27c1acff47e == "node_based" )
    {
        if ( isdefined( self.traversal_start_node ) && !isdefined( self.traversal_start_node.traverse_height ) )
        {
            asm::function_83faa08e56039deb( self.traversal_start_node );
        }
        
        assert( isdefined( self.traversal_start_node ), "<dev string:x5f8>" + self.var_15c6e27c1acff47e + "<dev string:x61b>" + self.traverse_traversetype + "<dev string:x61e>" );
        assert( isdefined( self.traversal_start_node.type ), "<dev string:x741>" + self.traversal_start_node.origin );
        
        if ( !isdefined( self.traversal_start_node.traverse_height ) )
        {
            self.traversal_start_node asm::traversethink();
        }
        
        assert( isdefined( self.traversal_start_node.traverse_height ), "<dev string:x784>" + self.var_15c6e27c1acff47e + "<dev string:x61b>" + self.traverse_traversetype + "<dev string:x7aa>" + self.traversal_start_node.origin );
        targetangles = self.traversal_start_node.angles;
        
        if ( self.traversal_start_node.targetangles )
        {
            targetangles = self.traversal_start_node.targetangles;
        }
        
        featurearray = [];
        featurearray[ "height" ] = self.traversal_start_node.traverse_height_delta;
        featurearray[ "drop_height" ] = self.traversal_start_node.traverse_drop_height_delta;
        featurearray[ "arrival_yaw" ] = angleclamp180( targetangles[ 1 ] - self.angles[ 1 ] );
        featurearray[ "speed" ] = self function_53510b1da83172ce();
        
        if ( self.var_4249813a2840cfc8 == "traverse_warp_across" && isdefined( self.traversal_start_node.across_delta ) )
        {
            featurearray[ "length" ] = length2d( self.traversal_start_node.across_delta );
        }
    }
    else
    {
        assertmsg( "<dev string:x7cd>" + self.var_15c6e27c1acff47e + "<dev string:x7e9>" + self.traverse_traversetype );
        return;
    }
    
    if ( isdefined( self.var_5e505729e7585103 ) )
    {
        featurearray = [[ self.var_5e505729e7585103 ]]( featurearray, self.var_4249813a2840cfc8 );
    }
    
    if ( isdefined( self.var_8f42fb436afef718 ) )
    {
        self.var_4249813a2840cfc8 = self [[ self.var_8f42fb436afef718 ]]( { #featurearray:featurearray, #traversetype:self.var_4249813a2840cfc8 } );
    }
    
    if ( self.var_4249813a2840cfc8 == "traverse_warp_over" || self.var_4249813a2840cfc8 == "traverse_warp_across" )
    {
        if ( ai::is_floating() )
        {
            assert( isdefined( featurearray[ "<dev string:x804>" ] ) && isdefined( featurearray[ "<dev string:x80b>" ] ) );
            params = { #drop_height:featurearray[ "drop_height" ], #height:featurearray[ "height" ] };
            function_a87a0d0af157820e( params );
            featurearray[ "height" ] = params.height;
            featurearray[ "drop_height" ] = params.drop_height;
        }
    }
    
    alias = undefined;
    
    if ( self.var_4249813a2840cfc8 == "traverse_ground" || self.var_4249813a2840cfc8 == "traverse_wall" )
    {
        alias = self function_9e71e576c68bf0a( "move" );
        
        if ( asm::asm_hasalias( self.var_4249813a2840cfc8, alias ) == 0 )
        {
            alias = undefined;
        }
    }
    else if ( self.var_4249813a2840cfc8 == "traverse_custom" )
    {
        alias = self.traversal_start_node.animscript;
    }
    
    if ( !isdefined( alias ) )
    {
        alias = self function_805ca5e408d630c0( self.animsetname, self.var_4249813a2840cfc8, featurearray );
    }
    
    if ( !isdefined( alias ) )
    {
        traverserindex = animselector::gettraverserindex();
        
        if ( traverserindex < 0 )
        {
            /#
                assertstring = "<dev string:x817>" + ( self.var_4249813a2840cfc8 ?? "<dev string:x85a>" ) + "<dev string:x85c>" + self.origin + "<dev string:x86b>" + self getbasearchetype() + "<dev string:x87c>";
                
                foreach ( key, value in featurearray )
                {
                    assertstring += key + "<dev string:x88e>" + value + "<dev string:x890>";
                }
                
                assertmsg( assertstring );
            #/
            
            return;
        }
        
        alias = animselector::selectanim( self.var_4249813a2840cfc8, featurearray, traverserindex );
    }
    
    assert( asm::asm_hasalias( self.var_4249813a2840cfc8, alias ), "<dev string:x893>" + self.var_4249813a2840cfc8 + "<dev string:x89e>" + alias );
    traverseanim = asm::asm_lookupanimfromalias( self.var_4249813a2840cfc8, alias );
    xanim = asm::asm_getxanim( self.var_4249813a2840cfc8, traverseanim );
    self.var_ebd899fa43b2495e = alias;
    arrivalstate = self.var_4249813a2840cfc8 + "_arrival";
    self.traversalhasarrival = 0;
    arrivalxanim = undefined;
    traversearrivalanim = asm::asm_lookupanimfromaliasifexists( arrivalstate, alias );
    
    if ( isdefined( traversearrivalanim ) )
    {
        arrivalxanim = asm::asm_getxanim( arrivalstate, traversearrivalanim );
        assert( animhasnotetrack( arrivalxanim, "<dev string:x8c1>" ) && animhasnotetrack( arrivalxanim, "<dev string:x1a9>" ), "<dev string:x8d4>" + alias + "<dev string:x13e>" + self.var_4249813a2840cfc8 + "<dev string:x8e0>" );
        assert( !animhasnotetrack( xanim, "<dev string:x8c1>" ) && !animhasnotetrack( xanim, "<dev string:x1a9>" ), "<dev string:x8d4>" + alias + "<dev string:x13e>" + self.var_4249813a2840cfc8 + "<dev string:x913>" );
        self.traversalhasarrival = 1;
        self.var_8b305093078ce8d4 = 1;
    }
    
    arrival = xanim;
    
    if ( isdefined( arrivalxanim ) )
    {
        arrival = arrivalxanim;
    }
    
    translationdelta = ( 0, 0, 0 );
    arrivalstartfrac = getnotetracktimes( arrival, "warp_arrival_start" )[ 0 ];
    var_1f2d1eed0895727c = getnotetracktimes( arrival, "warp_arrival_end" )[ 0 ];
    finishfrac = getnotetracktimes( arrival, "finish" )[ 0 ];
    translationstartfrac = 0;
    var_7ae5ee1b8c4d1a96 = undefined;
    
    if ( self.var_4249813a2840cfc8 == "traverse_warp_down" )
    {
        apex_delta = undefined;
        start_pos = undefined;
        start_angles = undefined;
        
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" && self.var_ef53ce9913fe1a35 == "script" )
        {
            apex_delta = self.var_9d40c8bd8f7a879.apex_delta;
            start_pos = self.var_9d40c8bd8f7a879.origin;
            start_angles = self.var_9d40c8bd8f7a879.angles;
        }
        else
        {
            apex_delta = self.traversal_start_node.apex_delta;
            start_pos = self.traversal_start_node.origin;
            start_angles = self.traversal_start_node.targetangles;
        }
        
        var_b2d0f47a158317a3 = vectornormalize2( apex_delta );
        var_34319f8f37b33f7c = utility::flat_origin( self.origin - start_pos );
        var_7ae5ee1b8c4d1a96 = vectordot( var_b2d0f47a158317a3, var_34319f8f37b33f7c );
        
        if ( var_7ae5ee1b8c4d1a96 <= 0 )
        {
            var_7ae5ee1b8c4d1a96 = 0;
            var_34319f8f37b33f7c = ( 0, 0, 0 );
        }
        
        disttoapex = length2d( apex_delta );
        
        if ( disttoapex >= 0 )
        {
            var_694605abb9ec9367 = undefined;
            apexstartfrac = getwarpdownnotetracktime( xanim );
            
            if ( isdefined( apexstartfrac ) )
            {
                var_62c099c5f55db8f6 = getmovedelta( xanim, var_1f2d1eed0895727c ?? 0, apexstartfrac );
                var_2a5d617a4b5af8e5 = max( disttoapex - var_7ae5ee1b8c4d1a96, 0 );
                var_57a4631e10efe87a = length2d( var_62c099c5f55db8f6 );
                
                if ( var_2a5d617a4b5af8e5 < var_57a4631e10efe87a && var_2a5d617a4b5af8e5 >= 0 )
                {
                    var_694605abb9ec9367 = 1 - var_2a5d617a4b5af8e5 / var_57a4631e10efe87a;
                }
                
                var_d50b0158c2acd8c0 = vectordot( anglestoforward( self.angles ), var_b2d0f47a158317a3 );
                
                if ( isdefined( var_694605abb9ec9367 ) )
                {
                    trace_dist = 60;
                    x = trace_dist * cos( start_angles[ 1 ] );
                    y = trace_dist * sin( start_angles[ 1 ] );
                    pos = ( x, y, 0 ) + self.origin;
                    capsule_height = 50;
                    capsule_radius = 15;
                    
                    if ( var_7ae5ee1b8c4d1a96 <= 0 || self aiphysicstracepassed( self.origin + ( 0, 0, 10 ), pos + ( 0, 0, 10 ), capsule_radius, capsule_height, 1 ) )
                    {
                        currenttranslationstartfrac = math::remap( var_694605abb9ec9367, 0, 1, var_1f2d1eed0895727c ?? 0, apexstartfrac );
                        var_582f7834de8a01a2 = length2d( getmovedelta( xanim, currenttranslationstartfrac, apexstartfrac ) );
                        overshoot_threshold = 2;
                        
                        if ( var_582f7834de8a01a2 - var_2a5d617a4b5af8e5 > overshoot_threshold )
                        {
                            var_694605abb9ec9367 *= var_582f7834de8a01a2 / var_2a5d617a4b5af8e5;
                            var_694605abb9ec9367 = clamp( var_694605abb9ec9367, 0, 1 );
                            currenttranslationstartfrac = math::remap( var_694605abb9ec9367, 0, 1, var_1f2d1eed0895727c ?? 0, apexstartfrac );
                        }
                        
                        translationstartfrac = currenttranslationstartfrac;
                        self.var_8b305093078ce8d4 = 0;
                    }
                }
                
                if ( translationstartfrac >= apexstartfrac )
                {
                    translationstartfrac = max( 0, apexstartfrac - 0.01 );
                }
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_8f1b9e23aa212024", 0 ) == 1 )
        {
            function_d9524f43ab31640d( featurearray, alias, var_7ae5ee1b8c4d1a96, translationstartfrac );
        }
    #/
    
    self.var_43b5a8570d41fe2c = translationstartfrac;
    
    if ( isdefined( arrivalstartfrac ) && isdefined( var_1f2d1eed0895727c ) && isdefined( finishfrac ) )
    {
        var_c0c5d9d3f8d1954e = isdefined( arrivalxanim ) ? finishfrac : var_1f2d1eed0895727c;
        
        if ( translationstartfrac < var_c0c5d9d3f8d1954e )
        {
            translationdelta = getmovedelta( arrival, translationstartfrac, var_c0c5d9d3f8d1954e );
        }
        else
        {
            translationdelta = ( 0, 0, 0 );
        }
    }
    
    self.var_ed2f86f082cf88f9 = translationdelta;
}

// Namespace traverse
// Params 3
// Checksum 0xe00b959b, Offset: 0x401e
// Size: 0x15b
function traversechooseanim( asmname, statename, params )
{
    alias = undefined;
    
    if ( self.var_a4d7ad445f64c817 && isdefined( self.var_4249813a2840cfc8 ) && isdefined( self.var_ebd899fa43b2495e ) )
    {
        statename = self.var_4249813a2840cfc8;
        alias = self.var_ebd899fa43b2495e;
    }
    else
    {
        setupsuccess = self setuptraversaltransitioncheck( 120 );
        assert( setupsuccess, "<dev string:x956>" + self getbasearchetype() + "<dev string:x97d>" + statename + "<dev string:x989>" + self.origin );
        calctraversetype( asmname, statename, params );
        
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
        {
            nodedist = distance2d( self.var_9d40c8bd8f7a879.origin, self.origin );
        }
        else
        {
            nodedist = distance2d( self.traversal_start_node.origin, self.origin );
        }
        
        if ( nodedist < 4 )
        {
            self.var_8b305093078ce8d4 = 0;
        }
        
        statename = self.var_4249813a2840cfc8;
        alias = self.var_ebd899fa43b2495e;
    }
    
    return asm::asm_chooseanim( asmname, statename, alias );
}

// Namespace traverse
// Params 1
// Checksum 0x809d1a32, Offset: 0x4182
// Size: 0x1e
function handletraversearrivalwarpnotetracks( note )
{
    if ( note == "warp_arrival_start" )
    {
        return handlewarparrivalnotetrack();
    }
}

// Namespace traverse
// Params 1
// Checksum 0x68635b6b, Offset: 0x41a8
// Size: 0xa2
function handletraversewarpnotetracks( note )
{
    if ( isdefined( self.handletraversewarpnotetracksfn ) )
    {
        [[ self.handletraversewarpnotetracksfn ]]( note );
    }
    
    if ( note == "traverse_death" )
    {
        return handletraversedeathnotetrack();
    }
    
    if ( note == "warp_arrival_start" )
    {
        return handlewarparrivalnotetrack();
    }
    
    if ( note == "warp_up_start" )
    {
        return handlewarpupnotetrack();
    }
    
    if ( note == "warp_across_start" )
    {
        return handlewarpacrossnotetrack();
    }
    
    if ( note == "warp_down_start" )
    {
        return handlewarpdownstartnotetrack();
    }
    
    if ( note == "warp_down_end" )
    {
        return handlewarpdownendnotetrack();
    }
}

// Namespace traverse
// Params 0
// Checksum 0xc50fb8f9, Offset: 0x4252
// Size: 0x48
function handletraversedeathnotetrack()
{
    if ( isdefined( self.traversedeathanim ) )
    {
        deathanimarray = self.traversedeathanim[ self.traversedeathindex ];
        ai::set_deathanim( deathanimarray[ randomint( deathanimarray.size ) ] );
        self.traversedeathindex++;
    }
}

// Namespace traverse
// Params 0
// Checksum 0xd1f4af48, Offset: 0x42a2
// Size: 0x161
function handlewarparrivalnotetrack()
{
    self animmode( "noclip" );
    
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        if ( !isdefined( self.var_9d40c8bd8f7a879 ) )
        {
            println( "<dev string:x99b>" + self.var_15c6e27c1acff47e + "<dev string:x9d5>" );
            return;
        }
        
        targetpos = self.var_9d40c8bd8f7a879.origin;
        targetangles = self.var_9d40c8bd8f7a879.angles;
    }
    else
    {
        if ( !isdefined( self.traversestartnode ) )
        {
            println( "<dev string:x9ee>" + self.var_15c6e27c1acff47e + "<dev string:xa22>" );
            return;
        }
        
        targetpos = self.traversestartnode.origin;
        targetangles = self.traversestartnode.targetangles;
    }
    
    if ( ai::is_floating() )
    {
        targetpos += ( 0, 0, self.var_ed3c19fec55b26cc );
    }
    
    targetforward = anglestoforward( targetangles );
    warpforward = vectornormalize( targetpos - self.origin );
    
    if ( vectordot( targetforward, warpforward ) < 0 )
    {
        return;
    }
    
    utility::motionwarpwithnotetracks( self.traversexanim, targetpos, targetangles, "warp_arrival_start", "warp_arrival_end" );
}

// Namespace traverse
// Params 0
// Checksum 0x9b95827c, Offset: 0x440b
// Size: 0x292
function handlewarpupnotetrack()
{
    self animmode( "noclip" );
    
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        if ( !isdefined( self.var_9d40c8bd8f7a879 ) )
        {
            println( "<dev string:x99b>" + self.var_15c6e27c1acff47e + "<dev string:xa3a>" );
            return;
        }
        
        assert( isdefined( self.var_9d40c8bd8f7a879.origin ), "<dev string:xa4e>" + self.var_15c6e27c1acff47e + "<dev string:xa6d>" );
        assert( isdefined( self.var_9d40c8bd8f7a879.apex_delta ), "<dev string:xa4e>" + self.var_15c6e27c1acff47e + "<dev string:xa8c>" );
        targetpos = self.var_9d40c8bd8f7a879.origin + self.var_9d40c8bd8f7a879.apex_delta;
        targetangles = self.var_9d40c8bd8f7a879.angles;
    }
    else
    {
        if ( !isdefined( self.traversestartnode ) )
        {
            println( "<dev string:x9ee>" + self.var_15c6e27c1acff47e + "<dev string:xaaf>" );
            return;
        }
        
        assert( isdefined( self.traversestartnode.origin ), "<dev string:xac2>" );
        assert( isdefined( self.traversestartnode.apex_delta ), "<dev string:xafd>" );
        targetpos = self.traversestartnode.origin + self.traversestartnode.apex_delta;
        targetangles = self.traversestartnode.targetangles;
    }
    
    if ( animhasnotetrack( self.traversexanim, "warp_up_apex" ) )
    {
        animstartfrac = getnotetracktimes( self.traversexanim, "warp_up_start" )[ 0 ];
        animendfrac = getnotetracktimes( self.traversexanim, "warp_up_end" )[ 0 ];
        animlength = getanimlength( self.traversexanim );
        assert( animendfrac - animstartfrac >= 0, "<dev string:xb3c>" );
        duration = int( ( animendfrac - animstartfrac ) * animlength * 1000 );
        utility::motionwarpwithnotetracks( self.traversexanim, targetpos, targetangles, "warp_up_start", "warp_up_apex", duration );
        return;
    }
    
    utility::motionwarpwithnotetracks( self.traversexanim, targetpos, targetangles, "warp_up_start", "warp_up_end" );
}

// Namespace traverse
// Params 0
// Checksum 0x389710ec, Offset: 0x46a5
// Size: 0x2bb
function handlewarpacrossnotetrack()
{
    self animmode( "noclip" );
    endnode = self.traverseendnode;
    
    if ( !isdefined( endnode ) )
    {
        endnode = spawnstruct();
        
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
        {
            if ( !isdefined( self.var_9d40c8bd8f7a879 ) )
            {
                println( "<dev string:x99b>" + self.var_15c6e27c1acff47e + "<dev string:xb75>" );
                return;
            }
            
            endnode.angles = self.var_9d40c8bd8f7a879.angles;
        }
        else
        {
            if ( !isdefined( self.traversestartnode ) )
            {
                println( "<dev string:x9ee>" + self.var_15c6e27c1acff47e + "<dev string:xb8d>" );
                return;
            }
            
            endnode.angles = self.traversestartnode.angles;
        }
    }
    
    startnode = self.traversestartnode;
    
    if ( !isdefined( startnode ) )
    {
        startnode = spawnstruct();
        
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
        {
            startnode.across_delta = self.var_9d40c8bd8f7a879.across_delta;
            startnode.apex_delta = self.var_9d40c8bd8f7a879.apex_delta;
            startnode.origin = self.var_9d40c8bd8f7a879.origin;
        }
    }
    
    /#
        assert( isdefined( startnode.apex_delta ), "<dev string:xba4>" + startnode.origin );
        assert( isdefined( startnode.across_delta ), "<dev string:xbe8>" + startnode.origin );
    #/
    
    apex_delta = startnode.apex_delta ?? ( 0, 0, 0 );
    across_delta = startnode.across_delta ?? ( 0, 0, 0 );
    assert( isdefined( self getnegotiationstartpos() ), "<dev string:xc2e>" + self.origin );
    targetpos = startnode.origin + apex_delta + across_delta;
    targetangles = endnode.angles;
    
    if ( self.traversestartnode.targetangles )
    {
        targetangles = self.traversestartnode.targetangles;
    }
    
    utility::motionwarpwithnotetracks( self.traversexanim, targetpos, targetangles, "warp_across_start", "warp_across_end" );
}

// Namespace traverse
// Params 0
// Checksum 0x7d31c871, Offset: 0x4968
// Size: 0x51e
function handlewarpdownstartnotetrack()
{
    self animmode( "noclip" );
    endnode = self.traverseendnode;
    
    if ( !isdefined( endnode ) )
    {
        endnode = spawnstruct();
        
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
        {
            if ( !isdefined( self.var_9d40c8bd8f7a879 ) )
            {
                println( "<dev string:xc71>" + self.var_15c6e27c1acff47e + "<dev string:xca2>" );
                return;
            }
            
            endnode.angles = self.var_9d40c8bd8f7a879.angles;
            endnode.origin = self.var_d87cab901a66356c;
        }
        else
        {
            if ( !isdefined( self.traversestartnode ) )
            {
                println( "<dev string:xc71>" + self.var_15c6e27c1acff47e + "<dev string:xca2>" );
                return;
            }
            
            endnode.angles = self.traversestartnode.angles;
            endnode.origin = self getnegotiationendpos();
        }
        
        assert( isdefined( endnode.origin ), "<dev string:xcbd>" + self.origin );
    }
    else if ( !isdefined( endnode.origin ) )
    {
        endnode.origin = self.traversestartnode.end_node_origin;
    }
    
    targetangles = endnode.angles;
    
    if ( self.traversestartnode.targetangles )
    {
        targetangles = self.traversestartnode.targetangles;
    }
    
    animstartfrac = getnotetracktimes( self.traversexanim, "warp_down_start" )[ 0 ];
    animendfrac = getnotetracktimes( self.traversexanim, "warp_down_end" )[ 0 ];
    animdelta = getmovedelta( self.traversexanim, animstartfrac, animendfrac );
    animdelta = rotatevector( animdelta, targetangles );
    assert( animendfrac - animstartfrac >= 0, "<dev string:xcf2>" );
    var_6bf206179eb61140 = 512;
    tracestart = ( self.origin[ 0 ] + animdelta[ 0 ], self.origin[ 1 ] + animdelta[ 1 ], self.origin[ 2 ] );
    targetpos = undefined;
    
    if ( isdefined( self.var_b5ddf4fb051b5e5 ) )
    {
        targetpos = self.var_b5ddf4fb051b5e5;
        self.var_b5ddf4fb051b5e5 = undefined;
    }
    else
    {
        targetpos = getgroundposition( tracestart, 10, var_6bf206179eb61140, 12 );
    }
    
    /#
        if ( tracestart[ 2 ] - targetpos[ 2 ] > var_6bf206179eb61140 )
        {
            traversestartpos = ( 0, 0, 0 );
            
            if ( self.var_15c6e27c1acff47e == "<dev string:xd2d>" || self.var_15c6e27c1acff47e == "<dev string:xd36>" )
            {
                traversestartpos = self.var_fa685a7668b11923;
            }
            else if ( self.var_15c6e27c1acff47e == "<dev string:x5c2>" )
            {
                traversestartpos = self getnegotiationstartpos();
            }
            
            assertmsg( "<dev string:x296>" + var_6bf206179eb61140 + "<dev string:x2b8>" + tracestart + "<dev string:xd3f>" + traversestartpos );
        }
    #/
    
    /#
        if ( getdvarint( @"hash_8f1b9e23aa212024", 0 ) == 1 )
        {
            line( tracestart, targetpos, ( 0, 1, 0 ), 1, 0, 80 );
        }
    #/
    
    var_300329678ee5d9ae = 0.05;
    var_cebde5dc94888d91 = 30;
    zdelta = abs( targetpos[ 2 ] - self.origin[ 2 ] );
    
    if ( zdelta < var_300329678ee5d9ae * abs( animdelta[ 2 ] ) || zdelta > var_cebde5dc94888d91 )
    {
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
        {
            startpos = self.var_9d40c8bd8f7a879.origin;
        }
        else
        {
            startpos = self.traversestartnode.origin;
        }
        
        println( "<dev string:x2ca>" + startpos + "<dev string:x2fc>" );
        
        if ( isdefined( endnode.origin ) )
        {
            targetpos = endnode.origin;
        }
    }
    
    nextcorner = self getpointafternegotiation();
    targetangles = endnode.angles;
    
    if ( self.traversestartnode.targetangles )
    {
        targetangles = self.traversestartnode.targetangles;
    }
    
    if ( isdefined( nextcorner ) && isdefined( endnode.origin ) )
    {
        targetyaw = vectortoyaw( nextcorner - endnode.origin );
        targetdist = clamp( angleclamp180( targetyaw - self.angles[ 1 ] ), -30, 30 );
        targetyaw = angleclamp180( self.angles[ 1 ] + targetdist );
        targetangles = ( 0, targetyaw, 0 );
    }
    
    utility::motionwarpwithnotetracks( self.traversexanim, targetpos, targetangles, "warp_down_start", "warp_down_end" );
}

// Namespace traverse
// Params 0
// Checksum 0x1485d44b, Offset: 0x4e8e
// Size: 0x27
function handlewarpdownendnotetrack()
{
    if ( !isagent( self ) )
    {
        self setanimrate( self.traversexanim, 1 );
    }
    
    self animmode( "gravity" );
}

// Namespace traverse
// Params 0
// Checksum 0xe95a0eb2, Offset: 0x4ebd
// Size: 0x1a2
function function_57247b43a1dde975()
{
    var_732f480266a422a6 = self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless";
    endpos = undefined;
    
    if ( var_732f480266a422a6 )
    {
        endpos = self.var_9d40c8bd8f7a879.endpos;
    }
    else
    {
        endpos = self getnegotiationendpos();
        
        if ( !isdefined( endpos ) )
        {
            endnode = self getnegotiationendnode();
            
            if ( isdefined( endnode ) )
            {
                endpos = endnode.origin;
            }
            else if ( isdefined( self.traversal_end_node ) )
            {
                endpos = self.traversal_end_node.origin;
            }
        }
    }
    
    if ( ai::is_floating() )
    {
        endpos += ( 0, 0, max( self.var_69623111d7e6b9a4 - self.var_87edd2358c253b2c, 0 ) );
    }
    
    self forceteleport( endpos, self.angles );
    
    /#
        startpos = undefined;
        
        if ( var_732f480266a422a6 )
        {
            startpos = self.var_9d40c8bd8f7a879.origin;
        }
        else
        {
            startpos = self getnegotiationstartpos();
            
            if ( !isdefined( startpos ) )
            {
                startnode = self getnegotiationstartnode();
                
                if ( isdefined( startnode ) )
                {
                    startpos = startnode.origin;
                }
                else if ( isdefined( self.traversal_start_node ) )
                {
                    startpos = self.traversal_start_node.origin;
                }
            }
        }
        
        println( "<dev string:xd59>" + startpos );
        record3dtext( "<dev string:xdb4>", self.origin + ( 0, 0, 70 ), ( 1, 0, 1 ) );
    #/
}

// Namespace traverse
// Params 4, eflags: 0x4
// Checksum 0xaa34e561, Offset: 0x5067
// Size: 0xa7
function private breakglass( pos, startpos, endonname, startnode )
{
    thread function_c5b83c3b3833e72( startnode, endonname );
    glassdistsq = distancesquared( pos, startpos );
    var_abadbc756ca07f4f = ( 0, 0, 30 );
    
    while ( true )
    {
        waitframe();
        distsq = distancesquared( startpos, self.origin + var_abadbc756ca07f4f );
        
        if ( distsq >= glassdistsq )
        {
            self notify( #"glassbroken" );
            glassradiusdamage( pos, 80, 100000, 100000 );
            return;
        }
    }
}

// Namespace traverse
// Params 2, eflags: 0x4
// Checksum 0xbca257b1, Offset: 0x5116
// Size: 0x44
function private function_c5b83c3b3833e72( startnode, endonname )
{
    self endon( #"glassbroken" );
    utility::waittill_any( endonname, "death", "terminate_ai_threads" );
    
    if ( startnode )
    {
        startnode.glasschecked = undefined;
    }
}

// Namespace traverse
// Params 1
// Checksum 0x2721b8ca, Offset: 0x5162
// Size: 0x232
function checktraverse( statename )
{
    /#
        new_state = "<dev string:xdd4>";
        
        switch ( statename )
        {
            case #"hash_13f1836afb769794":
                new_state = "<dev string:xde6>";
                break;
            case #"hash_6304cbcba2e946b0":
            case #"hash_d82745219ff3c265":
                new_state = "<dev string:xe10>";
                break;
            case #"hash_866c4635f52e9798":
                new_state = "<dev string:xe27>";
                break;
            case #"hash_866fce35f531ac47":
            case #"hash_9f0dc66f883f25c3":
                new_state = "<dev string:xe4a>";
                break;
            case #"hash_1d12ff1ecb04aba4":
            case #"hash_b447ff4d4a51e9fb":
                new_state = "<dev string:xe6d>";
                break;
            case #"hash_db11de90ac6688ff":
                new_state = "<dev string:xe84>";
                break;
            case #"hash_3ea04fbb868d6bb3":
                new_state = "<dev string:xea0>";
                break;
            case #"hash_3ebccfbb86a3fb82":
                new_state = "<dev string:xecb>";
                break;
            case #"hash_3ec2dbbb86a88b94":
            case #"hash_898e0c97630ee383":
                new_state = "<dev string:xef3>";
                break;
            case #"hash_3ec5dfbb86aad077":
            case #"hash_898b0e97630ca812":
                new_state = "<dev string:xf2a>";
                break;
            case #"hash_b6f5a750ffd1a966":
                new_state = "<dev string:xf43>";
                break;
            case #"hash_79b045449d1f54ab":
                new_state = "<dev string:xf61>";
                break;
            case #"hash_79ad39449d1d0330":
                new_state = "<dev string:xf83>";
                break;
            case #"hash_79d645449d3d69bf":
                new_state = "<dev string:xfb9>";
                break;
            case #"hash_2807abfb86a05ec9":
            case #"hash_33ca12afe07d839a":
            case #"hash_525a0d9590c85cfc":
                new_state = "<dev string:xdd4>";
                break;
            default:
                return;
        }
        
        if ( new_state == "<dev string:xdd4>" )
        {
            iprintlnbold( "<dev string:xffd>" + statename + "<dev string:x1009>" + self.origin + "<dev string:x1010>" );
            return;
        }
        
        iprintlnbold( "<dev string:xffd>" + statename + "<dev string:x1009>" + self.origin + "<dev string:x103b>" + new_state + "<dev string:x105f>" );
    #/
}

// Namespace traverse
// Params 3
// Checksum 0x9875e43c, Offset: 0x539c
// Size: 0x30b
function playtraverseanim_teleport( asmname, statename, params )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    var_b1dfae9ea4bfb3a8 = playtraverseanim_initialize( asmname, statename, params );
    
    if ( !var_b1dfae9ea4bfb3a8 )
    {
        terminatetraverse( asmname, statename );
        return;
    }
    
    if ( self.var_a4d7ad445f64c817 )
    {
        if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
        {
            if ( length( self.var_98c8ef3d59563272 - self.var_9d40c8bd8f7a879.origin ) > 0.001 )
            {
                self.var_a4d7ad445f64c817 = 0;
            }
        }
        else if ( self.var_15c6e27c1acff47e == "node_based" )
        {
            if ( self.traversearrival_node != self.traversestartnode )
            {
                self.var_a4d7ad445f64c817 = 0;
            }
        }
    }
    
    traverseanim = asm::asm_getanim( asmname, statename );
    assert( isdefined( traverseanim ), "<dev string:x1063>" + asmname + "<dev string:x1080>" + statename );
    
    if ( self.var_a4d7ad445f64c817 && statename != self.var_4249813a2840cfc8 )
    {
        terminatetraverse( asmname, statename );
        return;
    }
    
    traversexanim = asm::asm_getxanim( statename, traverseanim );
    assert( isdefined( traversexanim ), "<dev string:x1095>" + asmname + "<dev string:x1080>" + traverseanim + "<dev string:x13e>" + statename );
    asm_bb::bb_requeststance( "stand" );
    shouldusewarparrival = shouldusewarparrival( traversexanim );
    
    if ( self.var_15c6e27c1acff47e == "nodeless" || self.var_15c6e27c1acff47e == "linkless" )
    {
        self orientmode( "face angle", self.var_9d40c8bd8f7a879.angles[ 1 ] );
    }
    else
    {
        self orientmode( "face angle", self.traversestartnode.targetangles[ 1 ] );
    }
    
    callback::callback( #"traverse_teleport_anim_start" );
    asm::asm_playfacialanim( asmname, statename, traversexanim );
    self.traversexanim = traversexanim;
    self.traverseanimroot = asm::asm_getbodyknob();
    self aisetanim( statename, traverseanim, self.animplaybackratedefault, self.var_43b5a8570d41fe2c ?? 0 );
    
    if ( shouldusewarparrival && !isagent( self ) && ( !self.var_a4d7ad445f64c817 || !self.var_8b305093078ce8d4 ) )
    {
        assert( animhasnotetrack( traversexanim, "<dev string:x1a9>" ) );
        arrivalendtime = getnotetracktimes( traversexanim, "warp_arrival_end" )[ 0 ];
        
        if ( arrivalendtime > self.var_43b5a8570d41fe2c )
        {
            self setanimtime( traversexanim, arrivalendtime );
        }
    }
    
    self.traversedeathindex = 0;
    self.traversedeathanim = undefined;
    self.useanimgoalweight = 1;
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
}

// Namespace traverse
// Params 1
// Checksum 0x903adc69, Offset: 0x56af
// Size: 0x51
function function_1ed9c0fa1023ed41( note )
{
    if ( note == "hide_entity" )
    {
        callback::callback( #"traverse_teleport_hide_entity" );
        self hide();
        return;
    }
    
    if ( note == "show_entity" )
    {
        callback::callback( #"traverse_teleport_show_entity" );
        self show();
    }
}

// Namespace traverse
// Params 2
// Checksum 0x9fe8393f, Offset: 0x5708
// Size: 0x52
function function_3a3e7ca9df99aa14( asmname, statename )
{
    self endon( #"death" );
    self endon( #"terminate_ai_threads" );
    self endon( statename + "_finished" );
    callback::callback( #"traverse_teleport_anim_end" );
    terminatetraverse( asmname, statename );
}

