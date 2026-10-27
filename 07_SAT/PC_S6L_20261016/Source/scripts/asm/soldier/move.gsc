// scripts\asm\soldier\move.gsc  (hash_7430cc4dc955d54c.gscc) (size: 21385 Bytes / 0x5389 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe2872a1 (3190321825)
// size ...... 21385 (0x5389)
// includes .. 7   (offset: 0x4eb9)
// strings ... 68  (offset: 0x4ef1)
// dev strs .. 14  (offset: 0x52d1)
// exports ... 46  (offset: 0x345d)
// cseg ...... 0x426 + 0x3037 (0x345d)
// imports ... 145 (offset: 0x3b8d)
// animtree1 . 0   (offset: 0x5389)
// animtree2 . 0   (offset: 0x5389)
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\math;
#using scripts\common\utility;

#namespace move;

// Namespace move
// Params 3
// Checksum 0xdaa82c47, Offset: 0x444
// Size: 0x14f
function playanim_exit( asmname, statename, params )
{
    self endon( statename + "_finished" );
    startanim = asm::asm_getanim( asmname, statename );
    self.var_14a566d25ec03787 = undefined;
    
    if ( isdefined( level.battlechatter ) && self.battlechatterallowed )
    {
        var_1385d94a52a0c92d = issubstr( statename, "cover" );
        thread movebattlechatter_helper( var_1385d94a52a0c92d );
    }
    
    if ( !isdefined( startanim ) )
    {
        desiredspeed = self aigetdesiredspeed();
        targetspeed = 50;
        
        if ( targetspeed > desiredspeed )
        {
            targetspeed = 0.5 * desiredspeed;
        }
        
        self aisettargetspeed( targetspeed );
        asm::asm_fireevent( asmname, "abort" );
        asm::asm_fireevent( asmname, "code_move" );
        asm::asm_fireevent( asmname, "end" );
        asm::asm_fireevent( asmname, "finish" );
        return;
    }
    
    self.var_4ff0a015a19a428e = 1;
    self.var_2d4dd3f57eb8b4ed = 1;
    var_9fd4dc0d227c0865 = 0;
    
    if ( isdefined( params ) )
    {
        var_9fd4dc0d227c0865 = params;
    }
    
    playstartanim( asmname, statename, startanim, var_9fd4dc0d227c0865 );
    
    if ( isdefined( self.exitspeedtarget ) )
    {
        self aisettargetspeed( float( self.exitspeedtarget ) );
    }
}

// Namespace move
// Params 3
// Checksum 0x64bb52c5, Offset: 0x59b
// Size: 0x9e
function chooseanim_exit( asmname, statename, params )
{
    bsoldierversion = 0;
    
    if ( isdefined( params ) )
    {
        if ( isarray( params ) )
        {
            bsoldierversion = istrue( params[ 0 ] );
        }
        else
        {
            bsoldierversion = istrue( params );
        }
    }
    
    if ( bsoldierversion )
    {
        return chooseanim_exitsoldier( asmname, statename, params );
    }
    
    if ( !checktransitionpreconditions() )
    {
        return;
    }
    
    exitanim = undefined;
    var_72633c0c05a5b63e = 0;
    
    if ( isarray( params ) && isdefined( params[ 1 ] ) )
    {
        var_72633c0c05a5b63e = params[ 1 ];
    }
    
    exitanim = determinestartanim( statename, var_72633c0c05a5b63e );
    return exitanim;
}

// Namespace move
// Params 0
// Checksum 0xe055746d, Offset: 0x642
// Size: 0x36
function determinedesiredexitspeed()
{
    var_ff8dae08cd8c7d9e = 70;
    desiredspeed = self getdesiredscaledspeedforposalongpath( var_ff8dae08cd8c7d9e );
    
    if ( self.cautiousnavigation )
    {
        desiredspeed = 90;
    }
    
    return desiredspeed;
}

// Namespace move
// Params 3
// Checksum 0xa551cdaf, Offset: 0x681
// Size: 0xce
function chooseanim_exitsoldier( asmname, statename, params )
{
    suffix = "";
    
    if ( utility::isentasoldier() && utility::demeanorhasblendspace() )
    {
        desiredspeed = determinedesiredexitspeed();
        archetype = self getbasearchetype();
        suffix = getnextlowestspeedthresholdstring( self, desiredspeed );
        self.exitspeedtarget = getanimspeedthreshold( self, suffix );
    }
    else
    {
        self.exitspeedtarget = undefined;
    }
    
    if ( !checktransitionpreconditions() )
    {
        return;
    }
    
    exitanim = undefined;
    var_72633c0c05a5b63e = 0;
    
    if ( isarray( params ) && isdefined( params[ 1 ] ) )
    {
        var_72633c0c05a5b63e = params[ 1 ];
    }
    
    exitanim = determinestartanim( statename, var_72633c0c05a5b63e, suffix );
    return exitanim;
}

// Namespace move
// Params 4
// Checksum 0x644452bf, Offset: 0x758
// Size: 0xfc
function getstartanim( statename, optionalsuffix = "", idx, nearanglediff )
{
    assert( !asm::asm_hasalias( statename, "<dev string:x24>" + optionalsuffix ) );
    assert( !asm::asm_hasalias( statename, "<dev string:x26>" + optionalsuffix ) );
    var_aa71c263e873ca5c = [ 2, 3, 6, 9, 8, 7, 4, 1, 2 ];
    keypadidx = var_aa71c263e873ca5c[ idx ];
    
    if ( keypadidx == 8 )
    {
        if ( nearanglediff < 0 )
        {
            aliasname = keypadidx + "r" + optionalsuffix;
        }
        else
        {
            aliasname = keypadidx + "l" + optionalsuffix;
        }
    }
    else
    {
        aliasname = keypadidx + optionalsuffix;
    }
    
    return asm::asm_lookupanimfromaliasifexists( statename, aliasname );
}

// Namespace move
// Params 0
// Checksum 0xbe78992d, Offset: 0x85d
// Size: 0x42
function getstartmindist()
{
    demeanor = asm::asm_getdemeanor();
    
    if ( demeanor == "casual" || demeanor == "casual_gun" || self aigetdesiredspeed() <= 60 )
    {
        return 75;
    }
    
    return 100;
}

// Namespace move
// Params 0
// Checksum 0xfd077968, Offset: 0x8a8
// Size: 0x107
function getexitnode()
{
    exitnode = undefined;
    limit = 400;
    
    if ( utility::actor_is3d() )
    {
        limit = 1024;
    }
    else if ( isdefined( self.heat ) )
    {
        limit = 4096;
    }
    
    if ( isdefined( self.node ) && distancesquared( self.origin, self.node.origin ) < limit )
    {
        exitnode = self.node;
    }
    else if ( isdefined( self.prevnode ) && distancesquared( self.origin, self.prevnode.origin ) < limit )
    {
        exitnode = self.prevnode;
    }
    
    if ( isdefined( self.heat ) && !utility::actor_is3d() )
    {
        if ( isdefined( exitnode ) && absangleclamp180( self.angles[ 1 ] - exitnode.angles[ 1 ] ) > 30 )
        {
            return;
        }
    }
    
    return exitnode;
}

// Namespace move
// Params 3
// Checksum 0xab115cc6, Offset: 0x9b8
// Size: 0x54d
function determinestartanim( statename, var_72633c0c05a5b63e, optionalsuffix )
{
    negstartnode = self getnegotiationstartnode();
    
    if ( isdefined( negstartnode ) )
    {
        goalpos = negstartnode.origin;
    }
    else
    {
        goalpos = self.pathgoalpos;
    }
    
    assert( isdefined( goalpos ) );
    exitnode = getexitnode();
    
    if ( var_72633c0c05a5b63e )
    {
        lookaheadpos = self.origin + self.lookaheaddir * self.lookaheaddist;
        nearlookaheadpos = lookaheadpos;
    }
    else
    {
        lookaheadpos = self getposonpath( 128 );
        nearlookaheadpos = self getposonpath( 32 );
    }
    
    lookaheadangles = vectortoangles( lookaheadpos - self.origin );
    nearlookaheadangles = vectortoangles( nearlookaheadpos - self.origin );
    
    if ( utility::nodeshouldfaceangles( exitnode ) && !var_72633c0c05a5b63e )
    {
        currentangles = exitnode.angles;
    }
    else
    {
        currentangles = self.angles;
    }
    
    anglediff = angleclamp180( lookaheadangles[ 1 ] - currentangles[ 1 ] );
    nearanglediff = angleclamp180( nearlookaheadangles[ 1 ] - currentangles[ 1 ] );
    var_2941122204b840ac = vectortoangles( self.lookaheaddir );
    var_1eb903fb976d1f2e = angleclamp180( var_2941122204b840ac[ 1 ] - currentangles[ 1 ] );
    
    if ( abs( var_1eb903fb976d1f2e ) > 135 && abs( anglediff ) < 90 )
    {
        return;
    }
    
    if ( length2dsquared( self.velocity ) > 64 )
    {
        velangles = vectortoangles( self.velocity );
        
        if ( abs( angleclamp180( velangles[ 1 ] - lookaheadangles[ 1 ] ) ) < 45 )
        {
            return;
        }
    }
    
    mindist = getstartmindist();
    
    if ( self pathdisttogoal( 1 ) < mindist )
    {
        return;
    }
    
    angleindices = getangleindices( anglediff );
    curpossnapped = self getnavposition();
    idx = angleindices[ 0 ];
    startanim = undefined;
    
    if ( isdefined( self.var_14a566d25ec03787 ) )
    {
        startanim = getstartanim( self.var_14a566d25ec03787, optionalsuffix, idx, nearanglediff );
    }
    else
    {
        startanim = getstartanim( statename, optionalsuffix, idx, nearanglediff );
    }
    
    if ( !isdefined( self.var_14a566d25ec03787 ) )
    {
        exitcover = issubstr( statename, "cover" );
        animangles = currentangles;
        
        if ( exitcover && isdefined( exitnode ) )
        {
            var_525cb9cd18816e62 = [ -180, -135, -90, -90, -90, 90, 90, 135, -180 ];
            yawoffset = var_525cb9cd18816e62[ idx ];
            
            if ( issubstr( statename, "left" ) && idx == 4 )
            {
                yawoffset *= -1;
            }
            
            animangles = ( 0, angleclamp( exitnode.angles[ 1 ] + yawoffset ), 0 );
        }
        else
        {
            var_bbc69da768fd9fe3 = [ 180, -135, -90, -45, 0, 45, 90, 135, 180 ];
            yawoffset = var_bbc69da768fd9fe3[ idx ];
            animangles = ( 0, angleclamp( self.angles[ 1 ] + yawoffset ), 0 );
        }
        
        fmindist = 20;
        animmovedelta = anglestoforward( animangles );
        velocity = animmovedelta * self aigettargetspeed();
        movedelta = vectornormalize( animmovedelta ) * 5;
        exitdata = self getadjustedexitdirection( fmindist, velocity, movedelta );
        
        switch ( exitdata[ 0 ] )
        {
            case 1:
                exitdata[ 1 ] = vectornormalize( exitdata[ 1 ] );
                adjustedexitangles = vectortoangles( exitdata[ 1 ] );
                var_f1aff74daac89ff7 = math::wrap( -179, 179, angleclamp180( adjustedexitangles[ 1 ] - currentangles[ 1 ] ) );
                var_6211cdafaf67f5d = getangleindices( var_f1aff74daac89ff7, 45 );
                var_52ee4f7d2e23dddd = angleclamp180( animangles[ 1 ] - currentangles[ 1 ] );
                currentexitangles = getangleindices( var_52ee4f7d2e23dddd );
                newindex = var_6211cdafaf67f5d[ 0 ];
                
                for ( i = var_6211cdafaf67f5d.size - 1; i >= 0 ; i-- )
                {
                    angleindex = var_6211cdafaf67f5d[ i ];
                    
                    if ( angleindex == currentexitangles[ 0 ] )
                    {
                        continue;
                    }
                    else if ( ( idx == 8 || idx == 0 ) && ( angleindex == 8 || angleindex == 0 ) )
                    {
                        continue;
                    }
                    else if ( angleindex == idx )
                    {
                        continue;
                    }
                    
                    newindex = angleindex;
                    break;
                }
                
                idx = newindex;
                self.asm.customdata.ignoreexitwarp = 1;
                startanim = getstartanim( statename, optionalsuffix, idx, nearanglediff );
                break;
            case 2:
                startanim = undefined;
                break;
            default:
                break;
        }
    }
    
    return startanim;
}

// Namespace move
// Params 1
// Checksum 0xbf0919e2, Offset: 0xf0e
// Size: 0x22
function movebattlechatter_helper( var_1385d94a52a0c92d )
{
    self endon( #"death" );
    waitframe();
    movestartbattlechatter( var_1385d94a52a0c92d );
}

/#

    // Namespace move
    // Params 1
    // Checksum 0xc8b553ec, Offset: 0xf38
    // Size: 0x8e, Type: dev
    function function_b2b5772db75d207d( statename )
    {
        if ( getdvarint( @"hash_79e471363d9c6b91", 0 ) == 0 )
        {
            return;
        }
        
        self notify( #"hash_ee9995276dee6c60" );
        self endon( #"hash_ee9995276dee6c60" );
        self endon( statename + "<dev string:x28>" );
        
        while ( true )
        {
            print3d( self.origin + ( 0, 0, 72 ), "<dev string:x32>", ( 1, 0.25, 0.25 ), 1, 2, 1 );
            wait 0.05;
        }
    }

    // Namespace move
    // Params 3
    // Checksum 0x7944a2f8, Offset: 0xfce
    // Size: 0x60, Type: dev
    function function_b82af4ac0aff4294( suffix, statename, node )
    {
        if ( isdefined( suffix ) && suffix != "<dev string:x34>" )
        {
            thread function_b2b5772db75d207d( statename );
        }
        
        if ( isdefined( node ) && node.type != "<dev string:x3d>" )
        {
            thread function_b2b5772db75d207d( statename );
        }
    }

#/

// Namespace move
// Params 4
// Checksum 0x1a6ed7de, Offset: 0x1036
// Size: 0x4a4
function playstartanim( asmname, statename, startanim, var_9fd4dc0d227c0865 )
{
    self endon( statename + "_finished" );
    lookaheadpos = self getposonpath( 128 );
    lookaheadangles = vectortoangles( lookaheadpos - self.origin );
    anglediff = angleclamp180( lookaheadangles[ 1 ] - self.angles[ 1 ] );
    startxanim = asm::asm_getxanim( statename, startanim );
    var_e7f72c3205c43812 = getnotetracktimes( startxanim, "code_move" );
    cornertimes = getnotetracktimes( startxanim, "corner" );
    warpstarttimes = getnotetracktimes( startxanim, "warp_exit_start" );
    var_f9bdf6b6133195d1 = getnotetracktimes( startxanim, "warp_exit_end" );
    endtimefrac = 1;
    
    if ( var_e7f72c3205c43812.size > 0 )
    {
        self.requestarrivalnotify = 1;
        endtimefrac = var_e7f72c3205c43812[ 0 ];
    }
    
    startanimangles = getangledelta3d( startxanim, 0, endtimefrac );
    self animmode( "zonly_physics" );
    self setuseanimgoalweight( 0.2 );
    exitrate = self.moveplaybackrate;
    
    if ( utility::demeanorhasblendspace() && utility::isentasoldier() )
    {
        exitrate = 1;
    }
    
    var_2c2c2eeeaeccde1f = getmovedelta( startxanim, 0, endtimefrac );
    var_667c84c1c16d50d7 = length( var_2c2c2eeeaeccde1f );
    pos_along_path = self getposonpath( var_667c84c1c16d50d7 );
    
    if ( var_667c84c1c16d50d7 > 1 )
    {
        var_775fed0a1e030d4b = pos_along_path - self getnavposition();
    }
    else
    {
        var_775fed0a1e030d4b = self getposonpath( 12 ) - self getnavposition();
    }
    
    var_952e774efb657f9f = vectortoyaw( var_775fed0a1e030d4b );
    asm::asm_playfacialanim( asmname, statename, startxanim );
    self aisetanim( statename, startanim, exitrate );
    var_ecd7cff44d4c6bbc = 1;
    animdata = spawnstruct();
    animdata.xanim = startxanim;
    
    if ( isdefined( self.asm.customdata.ignoreexitwarp ) )
    {
    }
    else if ( cornertimes.size > 0 )
    {
        cornertranslation = getmovedelta( startxanim, 0, cornertimes[ 0 ] );
        cornerdist = length( cornertranslation );
        cornerposonpath = self getposonpath( cornerdist );
        var_40dd8742bd462442 = pos_along_path;
        
        if ( var_667c84c1c16d50d7 - cornerdist < 2 )
        {
            var_40dd8742bd462442 = self getposonpath( var_667c84c1c16d50d7 + 6 );
        }
        
        var_1b715302467bd9d = var_40dd8742bd462442 - cornerposonpath;
        var_1f62b6b24056c4bd = vectortoyaw( var_1b715302467bd9d );
        
        if ( warpstarttimes.size > 0 && warpstarttimes[ 0 ] > 0 && warpstarttimes[ 0 ] < cornertimes[ 0 ] )
        {
            animdata.posalongpath = cornerposonpath;
            animdata.anglealongpath = var_1f62b6b24056c4bd;
            animdata.endnote = "corner";
            
            if ( var_f9bdf6b6133195d1.size > 0 && var_f9bdf6b6133195d1[ 0 ] < cornertimes[ 0 ] )
            {
                animdata.duration = int( ( var_f9bdf6b6133195d1[ 0 ] - warpstarttimes[ 0 ] ) * getanimlength( startxanim ) * 1000 / exitrate );
            }
        }
        else
        {
            utility::motionwarpwithnotetracks( startxanim, cornerposonpath, ( 0, var_1f62b6b24056c4bd, 0 ), undefined, "corner", undefined, 0 );
        }
    }
    else if ( warpstarttimes.size == 0 || warpstarttimes[ 0 ] == 0 )
    {
        assert( var_e7f72c3205c43812.size > 0, "<dev string:x45>" + getxhashsourcename( getanimname( startxanim ) ) );
        duration = undefined;
        
        if ( warpstarttimes.size > 0 && var_f9bdf6b6133195d1.size > 0 && var_f9bdf6b6133195d1[ 0 ] < var_e7f72c3205c43812[ 0 ] )
        {
            duration = int( ( var_f9bdf6b6133195d1[ 0 ] - warpstarttimes[ 0 ] ) * getanimlength( startxanim ) * 1000 );
        }
        
        utility::motionwarpwithnotetracks( startxanim, pos_along_path, ( 0, var_952e774efb657f9f, 0 ), undefined, "code_move", duration, 0 );
    }
    
    if ( !isdefined( animdata.posalongpath ) )
    {
        animdata.posalongpath = pos_along_path;
        animdata.anglealongpath = var_952e774efb657f9f;
        animdata.endnote = "code_move";
        
        if ( warpstarttimes.size > 0 && var_f9bdf6b6133195d1.size > 0 )
        {
            animdata.duration = int( ( var_f9bdf6b6133195d1[ 0 ] - warpstarttimes[ 0 ] ) * getanimlength( startxanim ) * 1000 / exitrate );
        }
    }
    
    groundent = self getgroundentity();
    
    if ( isdefined( groundent ) )
    {
        animdata = motionwarp_localizedata( animdata, groundent );
    }
    
    asm::asm_donotetracks( asmname, statename, &handlewarpexitstart, animdata, undefined, !var_9fd4dc0d227c0865 );
    self motionwarpcancel();
    
    if ( var_9fd4dc0d227c0865 )
    {
        self animmode( "normal" );
        self orientmode( "face motion" );
        asm::asm_donotetracks( asmname, statename );
    }
}

// Namespace move
// Params 2
// Checksum 0x3be32b26, Offset: 0x14e2
// Size: 0xa0
function motionwarp_localizedata( animdata, groundent )
{
    var_bef2e865ee301d50 = invertangles( groundent.angles );
    var_803d1c26b9dd4479 = animdata.posalongpath - groundent.origin;
    var_4c53e76ad5867262 = rotatevector( var_803d1c26b9dd4479, var_bef2e865ee301d50 );
    animdata.posalongpath = var_4c53e76ad5867262;
    animdata.anglealongpath = combineangles( ( 0, animdata.anglealongpath, 0 ), var_bef2e865ee301d50 );
    animdata.groundent = groundent;
    return animdata;
}

// Namespace move
// Params 1
// Checksum 0xff4de696, Offset: 0x158b
// Size: 0xda
function motionwarp_getworldifydata( animdata )
{
    posalongpath = undefined;
    anglealongpath = undefined;
    groundent = animdata.groundent;
    
    if ( isdefined( groundent ) )
    {
        var_4c53e76ad5867262 = animdata.posalongpath;
        var_803d1c26b9dd4479 = rotatevector( var_4c53e76ad5867262, groundent.angles );
        posalongpath = var_803d1c26b9dd4479 + groundent.origin;
        angles = combineangles( animdata.anglealongpath, groundent.angles );
        anglealongpath = angles[ 1 ];
        return [ posalongpath, anglealongpath ];
    }
    
    return [ animdata.posalongpath, animdata.anglealongpath ];
}

// Namespace move
// Params 2
// Checksum 0x7d11aa09, Offset: 0x166d
// Size: 0x119
function handlewarpexitstart( note, params )
{
    posalongpath = undefined;
    anglealongpath = undefined;
    
    if ( note == "warp_exit_start" && !isdefined( self.asm.customdata.ignoreexitwarp ) )
    {
        assert( isstruct( params ) );
        endnote = params.endnote;
        
        if ( !isdefined( endnote ) )
        {
            endnote = "warp_exit_end";
        }
        
        duration = undefined;
        
        if ( isdefined( params.duration ) )
        {
            duration = params.duration - params.duration % 50;
        }
        
        assert( animhasnotetrack( params.xanim, endnote ) );
        [ posalongpath, anglealongpath ] = motionwarp_getworldifydata( params );
        utility::motionwarpwithnotetracks( params.xanim, posalongpath, ( 0, anglealongpath, 0 ), "warp_exit_start", endnote, duration, 0 );
    }
}

// Namespace move
// Params 0
// Checksum 0x30cebe3a, Offset: 0x178e
// Size: 0x149, Type: bool
function checktransitionpreconditions()
{
    if ( !isdefined( self.pathgoalpos ) )
    {
        /#
            asm::debug_arrival( "<dev string:x74>" + self getentitynumber() + "<dev string:x8c>" );
        #/
        
        return false;
    }
    
    if ( !self.facemotion )
    {
        /#
            asm::debug_arrival( "<dev string:x74>" + self getentitynumber() + "<dev string:xad>" );
        #/
        
        return false;
    }
    
    if ( self.disableexits )
    {
        /#
            asm::debug_arrival( "<dev string:x74>" + self getentitynumber() + "<dev string:xc9>" );
        #/
        
        return false;
    }
    
    if ( self.stairsstate != "none" )
    {
        /#
            asm::debug_arrival( "<dev string:x74>" + self getentitynumber() + "<dev string:xe6>" );
        #/
        
        return false;
    }
    
    mindist = 100;
    demeanor = asm::asm_getdemeanor();
    
    if ( asm::asm_getdemeanor() == "casual" || asm::asm_getdemeanor() == "casual_gun" || self aigetdesiredspeed() <= 60 )
    {
        mindist = 50;
        
        if ( self.disablearrivals )
        {
            mindist = 25;
        }
    }
    else if ( self.disablearrivals )
    {
        mindist = 50;
    }
    
    if ( self pathdisttogoal() < mindist )
    {
        /#
            asm::debug_arrival( "<dev string:x74>" + self getentitynumber() + "<dev string:xf3>" );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace move
// Params 3
// Checksum 0x274dd5b8, Offset: 0x18e0
// Size: 0x169
function function_800d11dd7314250c( asmname, statename, params )
{
    self.runngun = 1;
    self setstrafeblocked( 1, "asm" );
    assert( isdefined( self.enemy ), "<dev string:x108>" );
    shootfrompos = self getshootfrompos();
    targetposstruct = self getshootpos( shootfrompos );
    
    if ( isdefined( targetposstruct ) )
    {
        targetpos = targetposstruct.shootpos;
    }
    else
    {
        targetpos = self lastknownpos( self.enemy );
    }
    
    metotargetdir = targetpos - self getposonpath( 14 );
    metotargetyaw = vectortoyaw( metotargetdir );
    pathyaw = vectortoyaw( self.lookaheaddir );
    faceyawdelta = angleclamp180( metotargetyaw - pathyaw );
    var_ce299808430670d8 = -1;
    
    if ( faceyawdelta > 100 )
    {
        var_ce299808430670d8 = asm::asm_lookupanimfromalias( statename, "run_n_gun_hard_left" );
    }
    else if ( faceyawdelta < -100 )
    {
        var_ce299808430670d8 = asm::asm_lookupanimfromalias( statename, "run_n_gun_hard_right" );
    }
    else if ( faceyawdelta > 0 )
    {
        var_ce299808430670d8 = asm::asm_lookupanimfromalias( statename, "run_n_gun_soft_left" );
    }
    else
    {
        var_ce299808430670d8 = asm::asm_lookupanimfromalias( statename, "run_n_gun_soft_right" );
    }
    
    self.var_4ff0a015a19a428e = 1;
    self.var_2d4dd3f57eb8b4ed = 0;
    return var_ce299808430670d8;
}

// Namespace move
// Params 3
// Checksum 0x75cc79f, Offset: 0x1a52
// Size: 0x67
function stoprunngun( asmname, statename, params )
{
    self.runngun = 0;
    self.runngundisableaim = 0;
    self.baimedataimtarget = 0;
    self setstrafeblocked( 0, "asm" );
    self.var_c657299e18cfb232 = gettime() + int( self.runngun_cooldown * 1000 );
}

// Namespace move
// Params 4
// Checksum 0xc635b278, Offset: 0x1ac1
// Size: 0x47b, Type: bool
function shouldstrafeaimchange( asmname, statename, tostatename, params )
{
    bdisableaimchange = 1;
    
    if ( bdisableaimchange )
    {
        return false;
    }
    
    if ( !isdefined( self.asm.strafe_foot ) )
    {
        return false;
    }
    
    if ( !isdefined( self.pathgoalpos ) )
    {
        return false;
    }
    
    if ( self getreacquirestate() == "enabled" )
    {
        return false;
    }
    
    if ( isonanystairs() )
    {
        return false;
    }
    
    stairsenterdist = self getstairsenterdist();
    var_372936be0b6fa779 = self getstairsstateatdist( stairsenterdist );
    
    if ( var_372936be0b6fa779 != "none" )
    {
        return false;
    }
    
    targetspeed = self aigettargetspeed();
    
    if ( self.lookaheaddist < 90 )
    {
        return false;
    }
    
    pathyaw = vectortoyaw( self.lookaheaddir );
    
    if ( vectordot( vectornormalize( self.velocity ), vectornormalize( self.lookaheaddir ) ) < 0.9 )
    {
        return false;
    }
    
    var_4d32ebc7e0fb160f = self asmeventfiredwithin( asmname, "sharp_turn", 50 );
    
    if ( var_4d32ebc7e0fb160f )
    {
        newheadingyawdelta = angleclamp180( pathyaw - self.angles[ 1 ] );
        headingyawdelta = angleclamp180( vectortoyaw( self.velocity ) - self.angles[ 1 ] );
        
        if ( abs( angleclamp180( headingyawdelta - newheadingyawdelta ) ) > 45 )
        {
            return false;
        }
    }
    else
    {
        headingyawdelta = angleclamp180( pathyaw - self.angles[ 1 ] );
    }
    
    shootfrompos = self getshootfrompos();
    targetposstruct = self getshootpos( shootfrompos );
    
    if ( self.facemotion || self.predictedfacemotion || self shouldcautiousstrafe() )
    {
        faceyawdelta = 0;
    }
    else if ( isdefined( targetposstruct ) || self iscurrentenemyvalid() )
    {
        if ( isdefined( targetposstruct ) )
        {
            targetpos = targetposstruct.shootpos;
        }
        else
        {
            if ( issentient( self.enemy ) && gettime() - self lastknowntime( self.enemy ) > 2000 )
            {
                return false;
            }
            
            targetpos = self lastknownpos( self.enemy );
        }
        
        if ( distance2dsquared( targetpos, self.origin ) < 22500 )
        {
            return false;
        }
        
        metotargetdir = targetpos - self getposonpath( 32 );
        metotargetyaw = vectortoyaw( metotargetdir );
        
        if ( abs( angleclamp180( metotargetyaw - self.angles[ 1 ] ) ) < 45 )
        {
            return false;
        }
        
        faceyawdelta = angleclamp180( pathyaw - metotargetyaw );
    }
    else if ( self._blackboard.forcestrafe )
    {
        return false;
    }
    else
    {
        if ( var_4d32ebc7e0fb160f || self pathdisttogoal() < 64 )
        {
            return false;
        }
        
        faceyawdelta = angleclamp180( pathyaw - self.desiredangle );
    }
    
    if ( abs( angleclamp180( headingyawdelta - faceyawdelta ) ) < 45 )
    {
        return false;
    }
    
    curdir = asm::yawdiffto2468( headingyawdelta );
    desireddir = asm::yawdiffto2468( faceyawdelta );
    
    if ( curdir == desireddir )
    {
        return false;
    }
    
    speedstring = "fast";
    
    if ( utility::isentasoldier() && utility::demeanorhasblendspace() )
    {
        archetype = self getbasearchetype();
        speedstring = getnearestspeedthresholdname( self, targetspeed );
        
        if ( speedstring == "shuffle" || speedstring == "walk" )
        {
            speedstring = "walk";
        }
        else if ( speedstring != "fast" )
        {
            speedstring = "fast";
        }
        
        self.strafepoispeedtarget = getanimspeedthreshold( self, speedstring );
    }
    else
    {
        self.strafepoispeedtarget = undefined;
    }
    
    alias = speedstring + "_" + self.asm.strafe_foot + "_" + curdir + "_to_" + desireddir;
    
    if ( !asm::asm_hasalias( tostatename, alias ) )
    {
        if ( curdir == "4" || curdir == "6" )
        {
            alias = speedstring + "_feet_together_" + curdir + "_to_" + desireddir;
        }
        else
        {
            alias = speedstring + "_foot_l_forward_" + curdir + "_to_" + desireddir;
        }
        
        if ( !asm::asm_hasalias( tostatename, alias ) )
        {
            return false;
        }
    }
    
    self.asm.strafeaimchangealias = alias;
    return true;
}

// Namespace move
// Params 4
// Checksum 0xee547228, Offset: 0x1f45
// Size: 0x4b, Type: bool
function shouldrestartaimchange( asmname, statename, tostatename, params )
{
    if ( asm::asm_eventfired( asmname, "code_move" ) && shouldstrafeaimchange( asmname, statename, tostatename, params ) )
    {
        return true;
    }
    
    return false;
}

// Namespace move
// Params 5
// Checksum 0x8384eb57, Offset: 0x1f99
// Size: 0x1e6
function aimchangeorientation( turnxanim, rate, endtime, faceyawtarget, totalanimlength )
{
    self endon( #"hash_4660cd750093574f" );
    self.aimchange_oldturnrate = self.turnrate;
    totalangledelta = getangledelta( turnxanim, 0, endtime );
    yawtotarget = faceyawtarget - self.angles[ 1 ];
    yawtotarget = angleclamp180( yawtotarget );
    totalyawfixup = angleclamp180( yawtotarget - totalangledelta );
    animyawremaining = totalangledelta;
    
    while ( isalive( self ) )
    {
        currentanimtime = self aigetanimtime( turnxanim );
        nextanimtime = min( currentanimtime + level.frameduration / 1000 / totalanimlength * rate, 1 );
        var_462fd421f9d07429 = getangledelta( turnxanim, currentanimtime, nextanimtime );
        
        if ( ( animyawremaining - var_462fd421f9d07429 ) * animyawremaining > 0 )
        {
            animyawremaining -= var_462fd421f9d07429;
        }
        else
        {
            var_462fd421f9d07429 = animyawremaining;
            animyawremaining = 0;
        }
        
        lerpfraction = var_462fd421f9d07429 / totalangledelta;
        var_240c81c9e87593da = totalyawfixup * lerpfraction;
        rotatethisframe = var_462fd421f9d07429 + var_240c81c9e87593da;
        faceangle = angleclamp( self.angles[ 1 ] + rotatethisframe );
        var_1cbbf1e83bc04858 = angleclamp( self.angles[ 1 ] + clamp( rotatethisframe * 3, -179, 179.9 ) );
        self orientmode( "face angle", var_1cbbf1e83bc04858 );
        
        if ( rotatethisframe != 0 )
        {
            turnrate = abs( angleclamp180( self.angles[ 1 ] - faceangle ) ) / level.frameduration;
            
            if ( turnrate > 0 )
            {
                self.turnrate = turnrate;
            }
        }
        
        waitframe();
    }
}

// Namespace move
// Params 3
// Checksum 0x83287cb6, Offset: 0x2187
// Size: 0x318
function playanim_strafeaimchange( asmname, statename, params )
{
    self endon( statename + "_finished" );
    animindex = asm::asm_getanim( asmname, statename );
    turnxanim = asm::asm_getxanim( statename, animindex );
    self.asm.strafeaimchangealias = undefined;
    self.sharpturnforceusevelocity = 1;
    rate = 1;
    exitspeed = undefined;
    
    if ( isdefined( self.strafepoispeedtarget ) && utility::isentasoldier() && utility::demeanorhasblendspace() )
    {
        targetspeed = self aigettargetspeed();
        rate = targetspeed / self.strafepoispeedtarget;
        exitspeed = targetspeed;
        rate = clamp( rate, 0.6, 1.4 );
    }
    
    self aisetanim( statename, animindex, rate );
    asm::asm_playfacialanim( asmname, statename, turnxanim );
    codemovetimes = getnotetracktimes( turnxanim, "code_move" );
    finishnotes = getnotetracktimes( turnxanim, "finish" );
    endtime = 1;
    
    if ( codemovetimes.size > 0 )
    {
        endtime = codemovetimes[ 0 ];
    }
    else if ( finishnotes.size > 0 )
    {
        endtime = finishnotes[ 0 ];
    }
    
    totalanimlength = getanimlength( turnxanim );
    animlength = totalanimlength * endtime;
    faceyawtarget = vectortoyaw( self.lookaheaddir );
    facetargetpos = undefined;
    
    if ( !self.facemotion && !self.predictedfacemotion && !self shouldcautiousstrafe() )
    {
        animmovedelta = getmovedelta( turnxanim, 0, endtime );
        pathendpos = self getposonpath( length( animmovedelta ) );
        shootfrompos = self getshootfrompos();
        targetposstruct = self getshootpos( shootfrompos );
        enemypos = undefined;
        
        if ( isdefined( targetposstruct ) )
        {
            enemypos = targetposstruct.shootpos;
        }
        else if ( isdefined( self.enemy ) )
        {
            enemypos = self lastknownpos( self.enemy );
        }
        
        if ( isdefined( enemypos ) )
        {
            metotargetdir = vectornormalize( enemypos - pathendpos );
            faceyawtarget = vectortoyaw( metotargetdir );
            facetargetpos = enemypos;
        }
    }
    
    thread aimchangeorientation( turnxanim, rate, endtime, faceyawtarget, totalanimlength );
    note = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    self notify( #"hash_4660cd750093574f" );
    
    if ( isdefined( self.aimchange_oldturnrate ) )
    {
        if ( self.aimchange_oldturnrate > 0 )
        {
            self.turnrate = self.aimchange_oldturnrate;
        }
        
        self.aimchange_oldturnrate = undefined;
    }
    
    if ( note == "code_move" )
    {
        if ( isdefined( facetargetpos ) )
        {
            self orientmode( "face point", facetargetpos );
        }
        else
        {
            self orientmode( "face angle", faceyawtarget );
        }
        
        self animmode( "normal" );
        asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    }
    
    if ( isdefined( exitspeed ) )
    {
        self aisettargetspeed( exitspeed );
    }
}

// Namespace move
// Params 3
// Checksum 0xda847188, Offset: 0x24a7
// Size: 0x55
function chooseanim_strafeaimchange( asmname, statename, params )
{
    assert( isdefined( self.asm.strafeaimchangealias ) );
    return asm::asm_lookupanimfromalias( statename, self.asm.strafeaimchangealias );
}

// Namespace move
// Params 3
// Checksum 0x448ab56, Offset: 0x2505
// Size: 0x5d
function strafeaimchange_cleanup( asmname, statename, params )
{
    self notify( #"hash_4660cd750093574f" );
    
    if ( isdefined( self.aimchange_oldturnrate ) )
    {
        self.turnrate = self.aimchange_oldturnrate;
        self.aimchange_oldturnrate = undefined;
    }
    
    self.sharpturnforceusevelocity = 0;
}

// Namespace move
// Params 1
// Checksum 0x520a6122, Offset: 0x256a
// Size: 0x116
function handlestrafenotetracks( note )
{
    switch ( note )
    {
        case #"hash_e13cf484a444d070":
            self.asm.strafe_foot = "feet_together";
            self.asm.strafe_foot_time = gettime();
            break;
        case #"hash_622de61830d10b28":
            self.asm.strafe_foot = "feet_apart";
            self.asm.strafe_foot_time = gettime();
            break;
        case #"hash_725f3a6c07952190":
            self.asm.strafe_foot = "foot_l_forward";
            self.asm.strafe_foot_time = gettime();
            break;
        case #"hash_e81afc35eec1256e":
            self.asm.strafe_foot = "foot_r_forward";
            self.asm.strafe_foot_time = gettime();
            break;
    }
}

// Namespace move
// Params 3
// Checksum 0x766a815b, Offset: 0x2688
// Size: 0xb3
function playanim_strafereverse( asmname, statename, params )
{
    self endon( statename + "_finished" );
    zonlytime = 0.4;
    blankanimid = asm::asm_getanim( asmname, statename );
    self aisetanim( statename, blankanimid );
    self orientmode( "face enemy or motion" );
    self setstrafereverse( 1 );
    endnote = asm::asm_donotetracks( asmname, statename, undefined, undefined, undefined, 0 );
    
    if ( endnote == "code_move" )
    {
        self animmode( "normal" );
        endnote = asm::asm_donotetracks( asmname, statename, undefined, undefined, undefined, 0 );
    }
    
    asm::asm_fireevent( asmname, "end" );
}

// Namespace move
// Params 3
// Checksum 0xe4ab8615, Offset: 0x2743
// Size: 0x25
function strafereverse_cleanup( asmname, statename, params )
{
    self setstrafereverse( 0 );
}

// Namespace move
// Params 3
// Checksum 0x151161f9, Offset: 0x2770
// Size: 0x4d
function chooseanim_strafearrive( asmname, statename, params )
{
    assert( isdefined( self.asm.strafearrival_animindex ) );
    return self.asm.strafearrival_animindex;
}

// Namespace move
// Params 3
// Checksum 0x34425008, Offset: 0x27c6
// Size: 0x97
function choosewalkandtalkanims( asmname, statename, params )
{
    animstruct = spawnstruct();
    moveanims = [];
    moveanims[ 0 ] = asm::asm_lookupanimfromalias( statename, "0" );
    moveanims[ 1 ] = asm::asm_lookupanimfromalias( statename, "1" );
    moveanims[ 2 ] = asm::asm_lookupanimfromalias( statename, "2" );
    animstruct.anims = moveanims;
    animstruct.forwardanim = asm::asm_lookupanimfromalias( statename, "forward" );
    return animstruct;
}

// Namespace move
// Params 0
// Checksum 0x8d46ca49, Offset: 0x2866
// Size: 0x37, Type: bool
function shouldwalkandtalk()
{
    return asm_bb::bb_moverequested() && isdefined( self._blackboard.walk_and_talk_requested ) && self._blackboard.walk_and_talk_requested;
}

// Namespace move
// Params 2
// Checksum 0xfaf26bf5, Offset: 0x28a6
// Size: 0x32
function walkandtalkdonotetracks( asmname, statename )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        asm::asm_donotetracks( asmname, statename );
    }
}

// Namespace move
// Params 3
// Checksum 0xced4bc92, Offset: 0x28e0
// Size: 0x3a6
function movewalkandtalk( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self.requestarrivalnotify = 1;
    rate = asm::asm_getmoveplaybackrate();
    asm::asm_updatefrantic();
    self codemoveanimrate( rate );
    asm::asm_updatefrantic();
    animstruct = asm::asm_getanim( asmname, statename );
    anims = animstruct.anims;
    forwardanim = animstruct.forwardanim;
    self setflaggedanim( statename, forwardanim, 1, 0.2, 1 );
    thread walkandtalkdonotetracks( asmname, statename );
    lastangle = 0;
    blendframes = 20;
    
    while ( true )
    {
        arrival = asm::asm_eventfired( asmname, "cover_approach" );
        disttogoal = self pathdisttogoal();
        
        if ( arrival && disttogoal < 150 )
        {
            anglediff = anglediffwalkandtalk();
            index = 1;
            
            while ( index <= blendframes )
            {
                i = index / blendframes;
                result = i * i * ( 3 - 2 * i );
                transitiondegree = anglediff;
                actualangle = transitiondegree * result;
                interpolatedangle = transitiondegree - actualangle;
                animweights = getwalkandtalkanimweights( interpolatedangle );
                
                for ( animindex = 0; animindex < animweights.size ; animindex++ )
                {
                    self setanim( anims[ animindex ], animweights[ animindex ], 0.2, 1, 1 );
                }
                
                index++;
                wait 0.05;
                waittillframeend();
            }
            
            while ( arrival )
            {
                animweights = getwalkandtalkanimweights( 0 );
                
                for ( index = 0; index < animweights.size ; index++ )
                {
                    if ( isdefined( anims[ index ] ) )
                    {
                        self setanim( anims[ index ], animweights[ index ], 0.2, 1, 1 );
                    }
                }
                
                wait 0.05;
                waittillframeend();
            }
            
            continue;
        }
        
        anglediff = anglediffwalkandtalk();
        largetransition = lastangle - anglediff;
        
        if ( largetransition < 0 )
        {
            largetransition *= -1;
        }
        
        if ( largetransition >= 60 )
        {
            lastplayerangle = lastangle;
            var_bf8596e11a530d62 = lastangle;
            index = 1;
            
            while ( index <= blendframes )
            {
                anglediff = anglediffwalkandtalk();
                secondarylargetransition = lastplayerangle - anglediff;
                
                if ( secondarylargetransition < 0 )
                {
                    secondarylargetransition *= -1;
                }
                
                if ( secondarylargetransition >= 60 )
                {
                    if ( index == 1 )
                    {
                        index = 1;
                    }
                    else
                    {
                        index -= 1;
                    }
                    
                    newangle = lastplayerangle - lastangle;
                    i = index / blendframes;
                    result = i * i * ( 3 - 2 * i );
                    newactualangle = newangle * result;
                    var_bf8596e11a530d62 = newactualangle + lastangle;
                    index = 1;
                    lastangle = var_bf8596e11a530d62;
                }
                
                i = index / blendframes;
                result = i * i * ( 3 - 2 * i );
                transitiondegree = anglediff - var_bf8596e11a530d62;
                actualangle = transitiondegree * result;
                interpolatedangle = actualangle + lastangle;
                animweights = getwalkandtalkanimweights( interpolatedangle );
                
                for ( animindex = 0; animindex < animweights.size ; animindex++ )
                {
                    self setanim( anims[ animindex ], animweights[ animindex ], 0.2, 1, 1 );
                }
                
                index++;
                lastplayerangle = anglediff;
                wait 0.05;
                waittillframeend();
            }
        }
        else
        {
            animweights = getwalkandtalkanimweights( anglediff );
            
            for ( index = 0; index < animweights.size ; index++ )
            {
                if ( isdefined( anims[ index ] ) )
                {
                    self setanim( anims[ index ], animweights[ index ], 0.2, 1, 1 );
                }
            }
            
            wait 0.05;
            waittillframeend();
        }
        
        lastangle = anglediff;
    }
}

// Namespace move
// Params 0
// Checksum 0xc49e0a6, Offset: 0x2c8e
// Size: 0x13a
function anglediffwalkandtalk()
{
    targetpos = self.walk_and_talk_target.origin;
    actorpos = self.origin;
    offsetdir = targetpos - actorpos;
    facingdir = anglestoforward( self.angles );
    cross = vectorcross( facingdir, offsetdir );
    crossnormalize = vectornormalize( cross );
    offsetnorm = vectornormalize( offsetdir );
    facingnorm = vectornormalize( facingdir );
    dot = vectordot( offsetnorm, facingnorm );
    
    if ( isdefined( self.walk_and_talk_hemisphere ) )
    {
        anglediff = math::anglebetweenvectors( offsetdir, facingdir );
        
        if ( self.walk_and_talk_hemisphere == "right" )
        {
            if ( dot <= -1 )
            {
                return -180;
            }
            
            return ( anglediff * -1 );
        }
        else
        {
            if ( dot >= 1 )
            {
                return 180;
            }
            
            return anglediff;
        }
        
        return;
    }
    
    if ( dot >= 1 )
    {
        return 180;
    }
    
    if ( dot <= -1 )
    {
        return -180;
    }
    
    anglediff = math::anglebetweenvectors( offsetdir, facingdir );
    
    if ( crossnormalize[ 2 ] == -1 )
    {
        anglediff *= -1;
    }
    
    return anglediff;
}

// Namespace move
// Params 1
// Checksum 0x634e540a, Offset: 0x2dd0
// Size: 0xec
function getwalkandtalkanimweights( yaw )
{
    animweights = [];
    
    for ( index = 0; index < 3 ; index++ )
    {
        animweights[ index ] = 0;
    }
    
    anglearray = [ -180, 0, 180 ];
    
    for ( index = 0; yaw >= anglearray[ index ] ; index++ )
    {
        assert( index < anglearray.size );
    }
    
    last_index = index - 1;
    next_index = index;
    assert( index > 0 && index <= 3 );
    next_index_weight = ( yaw - anglearray[ last_index ] ) / ( anglearray[ next_index ] - anglearray[ last_index ] );
    last_index_weight = 1 - next_index_weight;
    animweights[ last_index ] = last_index_weight;
    animweights[ next_index ] = next_index_weight;
    animweights[ 1 ] = max( 0.01, animweights[ 1 ] );
    return animweights;
}

// Namespace move
// Params 1
// Checksum 0x11af07cd, Offset: 0x2ec5
// Size: 0x4f
function movestartbattlechatter( var_1385d94a52a0c92d )
{
    movetype = asm::asm_getdemeanor();
    
    if ( movetype == "frantic" || movetype == "combat" || movetype == "sprint" )
    {
        addbattlechatternotify( self, undefined, "move", var_1385d94a52a0c92d );
    }
}

// Namespace move
// Params 4
// Checksum 0x54ba2e47, Offset: 0x2f1c
// Size: 0x79, Type: bool
function shouldreloadwhilemoving( asmname, statename, tostatename, params )
{
    if ( !asm_bb::bb_reloadrequested() )
    {
        return false;
    }
    
    archetype = self getbasearchetype();
    
    if ( isspeedwithincqbrange( self, self aigetdesiredspeed() ) )
    {
        mindist = 500;
    }
    else
    {
        mindist = 600;
    }
    
    disttogoal = self pathdisttogoal();
    return mindist < disttogoal;
}

// Namespace move
// Params 3
// Checksum 0xb0ec60ed, Offset: 0x2f9e
// Size: 0x5b
function choosereloadwhilemoving( asmname, statename, params )
{
    alias = "reload";
    archetype = self getbasearchetype();
    
    if ( isspeedwithincqbrange( self, self aigetdesiredspeed() ) )
    {
        alias = "cqbreload";
    }
    
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace move
// Params 3
// Checksum 0x4f192eb8, Offset: 0x3002
// Size: 0x6f
function playreloadwhilemoving( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self.requestarrivalnotify = 1;
    reloadanim = asm::asm_getanim( asmname, statename );
    self aisetanim( statename, reloadanim );
    asm::asm_playfacialanim( asmname, statename, asm::asm_getxanim( statename, reloadanim ) );
    asm::asm_donotetracks( asmname, statename );
}

// Namespace move
// Params 3
// Checksum 0x5c9eb70f, Offset: 0x3079
// Size: 0x41
function terminatereloadwhilemoving( asmname, statename, params )
{
    if ( !asm::asm_eventfired( asmname, "reload done" ) )
    {
        weaponlist::refillclip();
    }
    
    namespace_fcb50a41dde46fde::reload_cleanup( asmname, statename, params );
}

// Namespace move
// Params 0
// Checksum 0xb55e6bfc, Offset: 0x30c2
// Size: 0x1f, Type: bool
function isonanystairs()
{
    return isdefined( self.pathgoalpos ) && self.stairsstate != "none";
}

// Namespace move
// Params 0
// Checksum 0x3cb30cbd, Offset: 0x30ea
// Size: 0x36
function getgroundangle()
{
    slope = self actorgetgroundslope();
    
    if ( abs( slope ) > 0.99 )
    {
        return 0;
    }
    
    riserun = acos( slope );
    return riserun;
}

// Namespace move
// Params 3
// Checksum 0xa403e872, Offset: 0x3129
// Size: 0xd8
function chooseanim_stairs( asmname, statename, params )
{
    assert( isdefined( self.asm.footsteps.foot ) );
    
    if ( self.asm.footsteps.foot == "left" )
    {
        alias = "right";
    }
    else
    {
        alias = "left";
    }
    
    archetype = self getbasearchetype();
    
    if ( isspeedwithincqbrange( self, self aigetdesiredspeed() ) )
    {
        altalias = "cqb" + alias;
        
        if ( asm::asm_hasalias( statename, altalias ) )
        {
            alias = altalias;
        }
    }
    
    stairsanim = asm::asm_lookupanimfromalias( statename, alias );
    return stairsanim;
}

// Namespace move
// Params 3
// Checksum 0xb5df39d0, Offset: 0x320a
// Size: 0xf2
function chooseanim_stairs_rise_run( asmname, statename, params )
{
    alias = "8x10";
    angle = getgroundangle();
    
    if ( angle < 27.75 )
    {
        alias = "8x20";
    }
    
    if ( angle >= 27.75 && angle < 36.2 )
    {
        alias = "8x12";
    }
    
    if ( angle >= 36.2 && angle < 41.85 )
    {
        alias = "8x10";
    }
    
    if ( angle >= 41.85 )
    {
        alias = "8x8";
    }
    
    archetype = self getbasearchetype();
    
    if ( isspeedwithincqbrange( self, self aigetdesiredspeed() ) )
    {
        altalias = "cqb" + alias;
        
        if ( asm::asm_hasalias( statename, altalias ) )
        {
            alias = altalias;
        }
    }
    
    stairsanim = asm::asm_lookupanimfromalias( statename, alias );
    return stairsanim;
}

// Namespace move
// Params 3
// Checksum 0x21cfc4f7, Offset: 0x3305
// Size: 0x106
function stumblechooseanim( asmname, statename, params )
{
    walkthreshold = getanimspeedthreshold( self, "walk" );
    fastthreshold = getanimspeedthreshold( self, "fast" );
    jogthreshold = getanimspeedthreshold( self, "jog" );
    runthreshold = getanimspeedthreshold( self, "run" );
    sprintthreshold = getanimspeedthreshold( self, "sprint" );
    speed = length( self.velocity );
    alias = "stumble_shuffle";
    
    if ( speed >= sprintthreshold )
    {
        alias = "stumble_sprint";
    }
    else if ( speed >= runthreshold )
    {
        alias = "stumble_run";
    }
    else if ( speed >= jogthreshold )
    {
        alias = "stumble_jog";
    }
    else if ( speed >= fastthreshold )
    {
        alias = "stumble_fast";
    }
    else if ( speed >= walkthreshold )
    {
        alias = "stumble_walk";
    }
    
    return asm::asm_chooseanim( asmname, statename, alias );
}

// Namespace move
// Params 3
// Checksum 0x98f47f27, Offset: 0x3414
// Size: 0x49
function playanim_stumble( asmname, statename, params )
{
    self.requestarrivalnotify = 1;
    self.var_4ff0a015a19a428e = 1;
    self.var_2d4dd3f57eb8b4ed = 0;
    asm::asm_playanimstate( asmname, statename, params );
}

