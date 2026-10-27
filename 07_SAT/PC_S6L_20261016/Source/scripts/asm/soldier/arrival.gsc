// scripts\asm\soldier\arrival.gsc  (hash_48cfcac846fde7ec.gscc) (size: 10755 Bytes / 0x2a03 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfc67dd85 (4234665349)
// size ...... 10755 (0x2a03)
// includes .. 6   (offset: 0x2797)
// strings ... 31  (offset: 0x27c7)
// dev strs .. 9   (offset: 0x2997)
// exports ... 24  (offset: 0x1a0f)
// cseg ...... 0x275 + 0x179a (0x1a0f)
// imports ... 81  (offset: 0x1dcf)
// animtree1 . 0   (offset: 0x2a03)
// animtree2 . 0   (offset: 0x2a03)
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\cover;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\utility;

#namespace arrival;

// Namespace arrival
// Params 4
// Checksum 0xc98b2b8e, Offset: 0x293
// Size: 0x32, Type: bool
function notshouldstartarrival( asmname, statename, tostatename, params )
{
    return !shouldstartarrival( asmname, statename, params );
}

// Namespace arrival
// Params 1
// Checksum 0x7aed4c4e, Offset: 0x2ce
// Size: 0x11
function getmaxarrivaldistfornodetype( nodetype )
{
    return 256;
}

// Namespace arrival
// Params 4
// Checksum 0xc37a5e97, Offset: 0x2e8
// Size: 0x215, Type: bool
function shouldstartarrival( asmname, statename, tostatename, params )
{
    if ( !self shoulddoarrival() )
    {
        return false;
    }
    
    if ( !isdefined( self.pathgoalpos ) )
    {
        return false;
    }
    
    node = utility::getarrivalnode();
    
    if ( !asm::asm_eventfired( asmname, "cover_approach" ) )
    {
        return false;
    }
    
    if ( isdefined( params ) )
    {
        if ( !isarray( params ) )
        {
            nodetype = params;
        }
        else if ( params.size < 1 )
        {
            nodetype = "Exposed";
        }
        else
        {
            nodetype = params[ 0 ];
        }
    }
    else
    {
        nodetype = "Exposed";
    }
    
    if ( !utility::isarrivaltype( asmname, statename, tostatename, nodetype ) )
    {
        return false;
    }
    
    dist_to_goal = distance( self.origin, self.pathgoalpos );
    var_81c745f3f0e801db = getmaxarrivaldistfornodetype( nodetype );
    
    if ( dist_to_goal > var_81c745f3f0e801db )
    {
        return false;
    }
    
    var_6c70d8d5ac969ca9 = 0;
    
    if ( isdefined( params ) && params.size > 1 )
    {
        var_6c70d8d5ac969ca9 = int( params[ 1 ] );
    }
    
    prefixstr = undefined;
    startnotetrack = undefined;
    endnotetrack = undefined;
    
    if ( nodetype == "Exposed Moving" )
    {
        endnotetrack = "code_move";
    }
    
    demeanor = asm::asm_getdemeanor();
    
    if ( demeanor == "casual" || demeanor == "casual_gun" || demeanor == "patrol" )
    {
        var_a0095780b8e513a1 = 0.053;
        
        if ( self pathdisttogoal() < 25 )
        {
            var_a0095780b8e513a1 = 2;
        }
        
        self.asm.stopdata = calculatestopdata( asmname, statename, tostatename, nodetype, var_6c70d8d5ac969ca9, undefined, prefixstr, var_a0095780b8e513a1, undefined, startnotetrack, endnotetrack );
    }
    else
    {
        self.asm.stopdata = calculatestopdata( asmname, statename, tostatename, nodetype, var_6c70d8d5ac969ca9, undefined, prefixstr, undefined, undefined, startnotetrack, endnotetrack );
    }
    
    if ( !isdefined( self.asm.stopdata ) )
    {
        return false;
    }
    
    return true;
}

// Namespace arrival
// Params 4
// Checksum 0x17ee17e9, Offset: 0x506
// Size: 0x46
function shouldstartcasualarrivalaftercodemove( asmname, statename, tostatename, params )
{
    if ( !asm::asm_eventfired( asmname, "code_move" ) )
    {
        return 0;
    }
    
    return shouldstartcasualarrival( asmname, statename, tostatename, params );
}

// Namespace arrival
// Params 4
// Checksum 0x95cb9c90, Offset: 0x555
// Size: 0x59, Type: bool
function shouldstartcasualarrival( asmname, statename, tostatename, params )
{
    demeanor = asm::asm_getdemeanor();
    
    if ( !isdefined( params ) || demeanor != params[ 2 ] )
    {
        return false;
    }
    
    return shouldstartarrival( asmname, statename, tostatename, params );
}

// Namespace arrival
// Params 4
// Checksum 0xe79a8e26, Offset: 0x5b7
// Size: 0x46
function shouldstartcasualarrivalwithgunaftercodemove( asmname, statename, tostatename, params )
{
    if ( !asm::asm_eventfired( asmname, "code_move" ) )
    {
        return 0;
    }
    
    return shouldstartcasualarrivalwithgun( asmname, statename, tostatename, params );
}

// Namespace arrival
// Params 4
// Checksum 0xf092e872, Offset: 0x606
// Size: 0x59, Type: bool
function shouldstartcasualarrivalwithgun( asmname, statename, tostatename, params )
{
    demeanor = asm::asm_getdemeanor();
    
    if ( !isdefined( params ) || demeanor != params[ 2 ] )
    {
        return false;
    }
    
    return shouldstartarrival( asmname, statename, tostatename, params );
}

// Namespace arrival
// Params 3
// Checksum 0x764ae951, Offset: 0x668
// Size: 0x4d
function chooseanim_arrival( asmname, statename, params )
{
    assert( isdefined( self.asm.stopdata ) );
    return self.asm.stopdata;
}

// Namespace arrival
// Params 1
// Checksum 0xec5d9118, Offset: 0x6be
// Size: 0x244
function function_3aa64d1ee292310b( node )
{
    nodepos = node.origin;
    
    if ( self._blackboard.shouldarrivetocoverexposedstepouttype != "none" && isdefined( node.type ) )
    {
        switch ( node.type )
        {
            case #"hash_667bc7e605903a6c":
            case #"hash_cd3ffe799551db82":
                if ( self._blackboard.shouldarrivetocoverexposedstepouttype == "full_exposed" )
                {
                    offset = ( -15, -44, 0 );
                    nodepos += rotatevector( offset, node.angles );
                }
                else if ( self._blackboard.shouldarrivetocoverexposedstepouttype == "lean" )
                {
                    offset = ( -6, -10, 0 );
                    nodepos += rotatevector( offset, node.angles );
                }
                
                break;
            case #"hash_55ed607005f12d49":
            case #"hash_e1d8e1adebed5a61":
                if ( self._blackboard.shouldarrivetocoverexposedstepouttype == "full_exposed" )
                {
                    offset = ( -15, 44, 0 );
                    nodepos += rotatevector( offset, node.angles );
                }
                else if ( self._blackboard.shouldarrivetocoverexposedstepouttype == "lean" )
                {
                    offset = ( -6, 10, 0 );
                    nodepos += rotatevector( offset, node.angles );
                }
                
                break;
            case #"hash_78b110033ccb68b0":
            case #"hash_c3b74422dec48736":
                assert( self._blackboard.shouldarrivetocoverexposedstepouttype == "<dev string:x24>" );
                offset = ( -8, 0, 0 );
                nodepos += rotatevector( offset, node.angles );
                break;
            case #"hash_961a09cded5ffc80":
                break;
            default:
                assertmsg( "<dev string:x31>" + node.type );
                break;
        }
    }
    
    return nodepos;
}

// Namespace arrival
// Params 12
// Checksum 0xa51713c9, Offset: 0x90b
// Size: 0x3ec
function calculatestopdata( asmname, statename, tostatename, nodetype, var_6c70d8d5ac969ca9, codeapproachdir, optionalprefix, var_53687d33ac219f65, overshootratio, startnotetrack, endnotetrack, speedstring )
{
    node = utility::getarrivalnode();
    toanimset = undefined;
    
    if ( !self btgoalvalid() && self.scriptedarrivalent == node )
    {
        if ( distance2dsquared( self.scriptedarrivalent.origin, self.pathgoalpos ) > 4096 )
        {
            if ( !isdefined( self.scriptedarrivalent.calculatestopdatawarningtime ) || self.scriptedarrivalent.calculatestopdatawarningtime < gettime() - level.frameduration )
            {
                self.scriptedarrivalent.calculatestopdatawarningtime = gettime();
            }
            else
            {
                assertmsg( "<dev string:x85>" );
                self.scriptedarrivalent delete();
                self.scriptedarrivalent = undefined;
                node = utility::getarrivalnode();
            }
        }
    }
    
    goalpos = undefined;
    
    if ( isdefined( node ) )
    {
        goalpos = function_3aa64d1ee292310b( node );
    }
    else
    {
        goalpos = self.pathgoalpos;
    }
    
    flatdir = goalpos - self.origin;
    flatdir = vectornormalize( ( flatdir[ 0 ], flatdir[ 1 ], 0 ) );
    
    if ( vectordot( flatdir, anglestoforward( self.angles ) ) < 0.707 )
    {
        return;
    }
    
    if ( nodetype == "Custom" )
    {
        tostatename = self.customarrivalstate;
        
        if ( isdefined( self.customarrivalanimset ) )
        {
            toanimset = self.customarrivalanimset;
        }
        
        var_6c70d8d5ac969ca9 = self.var_4568897d5b592329;
    }
    
    if ( !isdefined( optionalprefix ) )
    {
        optionalprefix = "";
    }
    
    prefixfoot = "";
    
    if ( var_6c70d8d5ac969ca9 )
    {
        foot = "left";
        
        if ( asm::asm_eventfiredrecently( asmname, "pass_left" ) )
        {
            foot = "left";
        }
        else if ( asm::asm_eventfiredrecently( asmname, "pass_right" ) )
        {
            foot = "right";
        }
        else if ( self.asm.footsteps.foot == "right" )
        {
            foot = "right";
        }
        
        if ( isdefined( optionalprefix ) )
        {
            prefixfoot = optionalprefix + foot;
        }
        else
        {
            prefixfoot = foot;
        }
    }
    else
    {
        prefixfoot = optionalprefix;
    }
    
    nodefaceangles = utility::nodeshouldfaceangles( node );
    yaw = undefined;
    angles = undefined;
    
    if ( ( nodetype == "Exposed" || nodetype == "Exposed Crouch" ) && utility_common::recentlysawenemy() )
    {
        if ( !self bb_shootparamsvalid() && !isdefined( self.smartfacingpos ) )
        {
            if ( isdefined( node ) && isdefined( node.angles ) )
            {
                yaw = node.angles[ 1 ];
                angles = node.angles;
                nodefaceangles = 1;
            }
            else
            {
                nodefaceangles = 0;
            }
        }
        else
        {
            rotateamount = namespace_fcb50a41dde46fde::getturndesiredyaw();
            angles = ( 0, self.angles[ 1 ] + rotateamount, 0 );
            yaw = angles[ 1 ];
            nodefaceangles = 1;
        }
    }
    else if ( nodefaceangles )
    {
        yaw = utility::getnodeforwardyaw( node, undefined, 0 );
        angles = node.angles;
    }
    
    result = self actorcalcstopdata( goalpos, angles, getcustomarrivalangles(), codeapproachdir, nodefaceangles, tostatename, yaw, prefixfoot, optionalprefix, var_53687d33ac219f65, overshootratio, nodetype, startnotetrack, endnotetrack, speedstring, toanimset );
    
    if ( isdefined( result ) && isdefined( node ) )
    {
        result.var_3e228b4fd7d0452f = self._blackboard.shouldarrivetocoverexposedstepouttype != "none";
    }
    
    return result;
}

// Namespace arrival
// Params 2
// Checksum 0x4c22c296, Offset: 0xd00
// Size: 0x47
function playanim_waitforpathset( asmname, statename )
{
    self endon( #"runto_arrived" );
    self endon( statename + "_finished" );
    self waittill( #"path_set" );
    asm::asm_fireevent( asmname, "abort" );
}

// Namespace arrival
// Params 2
// Checksum 0xe7c52a4b, Offset: 0xd4f
// Size: 0x59
function playanim_waitforpathclear( asmname, statename )
{
    self endon( #"runto_arrived" );
    self endon( statename + "_finished" );
    
    while ( true )
    {
        if ( !isdefined( self.pathgoalpos ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    asm::asm_fireevent( asmname, "abort" );
}

// Namespace arrival
// Params 1
// Checksum 0x7b7df6b, Offset: 0xdb0
// Size: 0x4d
function arrivalterminatewait( statename )
{
    self endon( #"death" );
    self.asm.arriving = statename;
    self waittill( statename + "_finished" );
    self.asm.arriving = undefined;
}

// Namespace arrival
// Params 4
// Checksum 0x2e646453, Offset: 0xe05
// Size: 0x104
function playanim_arrival_handlestandevent( asmname, statename, xanim, finalrate )
{
    self endon( statename + "_finished" );
    self.asm.arrivalstopfired = 0;
    movedelta = getmovedelta( xanim, 0, 1 );
    animtime = getanimlength( xanim );
    decrement = 0.05 / animtime;
    currenttime = 1 - decrement;
    
    while ( currenttime > 0 )
    {
        partialmovedelta = getmovedelta( xanim, 0, currenttime );
        
        if ( lengthsquared( movedelta - partialmovedelta ) >= 64 )
        {
            break;
        }
        
        currenttime -= decrement;
    }
    
    waittime = currenttime * animtime / finalrate;
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    self.asm.arrivalstopfired = 1;
}

// Namespace arrival
// Params 1
// Checksum 0xd9748e66, Offset: 0xf11
// Size: 0x1a
function returnoncorner( note )
{
    if ( note == "corner" )
    {
        return 1;
    }
}

// Namespace arrival
// Params 1
// Checksum 0x788e5692, Offset: 0xf33
// Size: 0x1a
function returnonwarpstart( note )
{
    if ( note == "warp_arrival_start" )
    {
        return 1;
    }
}

// Namespace arrival
// Params 2
// Checksum 0x5ad10c30, Offset: 0xf55
// Size: 0x70
function calculateadjustedspeedforshortpath( desiredspeed, pathdist )
{
    var_a83d194f5f447746 = 64;
    var_aeb33c09c2a9e5b0 = 110;
    
    if ( pathdist >= var_a83d194f5f447746 && pathdist <= var_aeb33c09c2a9e5b0 )
    {
        t = ( pathdist - var_a83d194f5f447746 ) / ( var_aeb33c09c2a9e5b0 - var_a83d194f5f447746 );
        targetspeed = self aigettargetspeed();
        return ( ( 1 - t ) * targetspeed + t * desiredspeed );
    }
    
    return desiredspeed;
}

// Namespace arrival
// Params 3
// Checksum 0xb6c93660, Offset: 0xfce
// Size: 0x78a
function playanim_arrival( asmname, statename, params )
{
    self endon( statename + "_finished" );
    arrival_rate = 1;
    
    if ( isdefined( params ) )
    {
        arrival_rate = params;
    }
    
    self.asm.arrivalasmstatename = statename;
    self.a.arrivalasmstatename = statename;
    thread arrivalterminatewait( statename );
    stopdata = asm::asm_getanim( asmname, statename );
    assert( isdefined( stopdata ), "<dev string:x128>" );
    
    if ( !isdefined( stopdata ) )
    {
        self orientmode( "face motion" );
        asm::asm_fireevent( asmname, "abort", undefined );
        return;
    }
    
    self orientmode( "face angle", self.angles[ 1 ] );
    facingangles = stopdata.finalangles;
    angleindex = stopdata.angleindex;
    facingyaw = ( 0, facingangles[ 1 ] - stopdata.angledelta, 0 );
    var_a8c83cec2fc71ee8 = stopdata.startpos;
    coverarrivalyaw = facingyaw[ 1 ];
    
    if ( isdefined( stopdata.parentpos ) && isdefined( stopdata.parentangles ) )
    {
        localdelta = stopdata.startpos - stopdata.parentpos;
        localdelta = rotatevectorinverted( localdelta, stopdata.parentangles );
        invangles = invertangles( stopdata.parentangles );
        localangles = combineangles( facingyaw, invangles );
        parentent = self getnavspaceent();
        assert( isdefined( parentent ), "<dev string:x140>" );
        localdelta = rotatevector( localdelta, parentent.angles );
        var_a8c83cec2fc71ee8 = localdelta + parentent.origin;
        newangles = combineangles( localangles, parentent.angles );
        coverarrivalyaw = newangles[ 1 ];
    }
    
    arrivalstatename = statename;
    
    if ( isdefined( self.customarrivalstate ) )
    {
        arrivalstatename = self.customarrivalstate;
    }
    
    stopanim = stopdata.stopanim;
    
    if ( isdefined( self.asm.customdata ) && isdefined( self.customarrivalanimset ) )
    {
        self setoverridearchetype( "animscript", self.customarrivalanimset, 1 );
    }
    
    stopxanim = asm::asm_getxanim( arrivalstatename, stopanim );
    arrival_node = utility::getarrivalnode();
    
    if ( isdefined( stopdata.customtargetpos ) )
    {
        goalpos = stopdata.customtargetpos;
    }
    else
    {
        if ( isdefined( arrival_node ) )
        {
            goalpos = function_3aa64d1ee292310b( arrival_node );
        }
        else
        {
            goalpos = self.pathgoalpos;
        }
        
        self._blackboard.arrivingtocoverexposed = istrue( stopdata.var_3e228b4fd7d0452f );
    }
    
    if ( !stopdata.bskipstartcoverarrival )
    {
        self startcoverarrival();
    }
    
    if ( animhasnotetrack( stopxanim, "code_move" ) )
    {
        self animmode( "zonly_physics" );
        animrate = utility::motionwarpwithnotetracks( stopxanim, goalpos, stopdata.finalangles, undefined, "corner", undefined );
        self aisetanim( arrivalstatename, stopanim, animrate );
        asm::asm_donotetracks( asmname, statename, &returnoncorner, undefined, arrivalstatename );
        self aisetanim( arrivalstatename, stopanim, 1 );
        asm::asm_donotetracks( asmname, statename, undefined, undefined, arrivalstatename );
        return;
    }
    
    if ( isdefined( self.customarrivalanimmode ) )
    {
        anim_mode = self.customarrivalanimmode;
        self animmode( anim_mode );
    }
    else
    {
        self animmode( "zonly_physics" );
    }
    
    asm::asm_playfacialanim( asmname, statename, stopxanim );
    stoprate = 1;
    
    if ( isdefined( goalpos ) )
    {
        animdist = length( stopdata.movedelta );
        disttogoal = length( self.origin - goalpos );
        
        if ( disttogoal > 1 )
        {
            stoprate = animdist / length( self.origin - goalpos );
        }
        
        stoprate = clamp( stoprate, 0.8, 1.3 );
    }
    
    finalrate = arrival_rate * stoprate;
    
    if ( isdefined( self.asm.arrivalspeed ) )
    {
        finalrate *= self.asm.arrivalspeed;
    }
    
    if ( isdefined( self.arrivalspeedtarget ) && isdefined( self.arrivaldesiredspeed ) && utility::isentasoldier() && utility::demeanorhasblendspace() )
    {
        finalrate = self.arrivaldesiredspeed / self.arrivalspeedtarget;
        self.arrivaldesiredspeed = undefined;
        var_eaa394eb0a1857e4 = 0.8;
        finalrate = max( var_eaa394eb0a1857e4, finalrate );
    }
    
    thread playanim_arrival_handlestandevent( asmname, statename, stopxanim, finalrate );
    self aisetanim( arrivalstatename, stopanim, finalrate );
    end_time = 1;
    
    if ( animhasnotetrack( stopxanim, "warp_arrival_start" ) )
    {
        assert( animhasnotetrack( stopxanim, "<dev string:x1b6>" ) );
        startnote = getnotetracktimes( stopxanim, "warp_arrival_start" );
        endnote = getnotetracktimes( stopxanim, "warp_arrival_end" );
        
        if ( startnote[ 0 ] > 0 )
        {
            asm::asm_donotetracks( asmname, statename, &returnonwarpstart, undefined, arrivalstatename, 0 );
        }
        
        animlength = getanimlength( stopxanim );
        warpstarttime = startnote[ 0 ];
        
        if ( warpstarttime > 0 )
        {
            warpstarttime = startnote[ 0 ] * animlength * 1000;
            warpstarttime -= int( warpstarttime ) % level.frameduration;
            warpstarttime = warpstarttime / animlength / 1000;
        }
        
        end_time = endnote[ 0 ];
        duration = int( ( end_time - warpstarttime ) * animlength / finalrate * 1000 );
        duration += level.frameduration - duration % level.frameduration;
        utility::motionwarpwithtimes( stopxanim, goalpos, stopdata.finalangles, warpstarttime, 1, duration, 0 );
    }
    else
    {
        warpduration = 500;
        
        if ( animhasnotetrack( stopxanim, "start_aim" ) )
        {
            end_time = getnotetracktimes( stopxanim, "start_aim" )[ 0 ];
            anim_length = getanimlength( stopxanim );
            warpduration = int( end_time * anim_length / finalrate * 1000 );
            
            if ( warpduration < 300 && anim_length / finalrate >= 0.15 )
            {
                warpduration = 300;
            }
        }
        
        self motionwarpwithanim( var_a8c83cec2fc71ee8, facingyaw, goalpos, stopdata.finalangles, warpduration );
    }
    
    if ( !isagent( self ) )
    {
        anime = asm::asm_lookupanimfromaliasifexists( statename, "conceal_add" );
        
        if ( isdefined( anime ) && isdefined( arrival_node ) && isdefined( arrival_node.type ) && ( arrival_node.type == "Conceal Crouch" || arrival_node.type == "Conceal Stand" ) )
        {
            conceal_xanim = asm::asm_getxanim( statename, anime );
            animlength = getanimlength( stopxanim );
            conceal_start_time = animlength * end_time * 0.3;
            thread cover::start_conceal_add( statename, conceal_xanim, conceal_start_time );
        }
    }
    
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ), undefined, arrivalstatename );
    self.a.movement = "stop";
}

// Namespace arrival
// Params 0
// Checksum 0xe5ae8f3c, Offset: 0x1760
// Size: 0x20
function getcustomarrivalangles()
{
    var_7237854e3be197ca = self.customarrivalangles;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace arrival
// Params 5
// Checksum 0x548eb466, Offset: 0x1788
// Size: 0x10a
function getstopanims( asmname, statename, approachtype, var_6c70d8d5ac969ca9, optionalprefix )
{
    assert( !asm::asm_hasalias( statename, "<dev string:x1c7>" ) );
    assert( !asm::asm_hasalias( statename, "<dev string:x1c9>" ) );
    stopanims = [];
    stopanims[ 5 ] = asm::asm_lookupdirectionalfootanim( 1, asmname, statename, var_6c70d8d5ac969ca9, optionalprefix );
    stopanims[ 4 ] = asm::asm_lookupdirectionalfootanim( 2, asmname, statename, var_6c70d8d5ac969ca9, optionalprefix );
    stopanims[ 3 ] = asm::asm_lookupdirectionalfootanim( 3, asmname, statename, var_6c70d8d5ac969ca9, optionalprefix );
    stopanims[ 6 ] = asm::asm_lookupdirectionalfootanim( 4, asmname, statename, var_6c70d8d5ac969ca9, optionalprefix );
    stopanims[ 2 ] = asm::asm_lookupdirectionalfootanim( 6, asmname, statename, var_6c70d8d5ac969ca9, optionalprefix );
    stopanims[ 7 ] = asm::asm_lookupdirectionalfootanim( 7, asmname, statename, var_6c70d8d5ac969ca9, optionalprefix );
    stopanims[ 0 ] = asm::asm_lookupdirectionalfootanim( 8, asmname, statename, var_6c70d8d5ac969ca9, optionalprefix );
    stopanims[ 1 ] = asm::asm_lookupdirectionalfootanim( 9, asmname, statename, var_6c70d8d5ac969ca9, optionalprefix );
    stopanims[ 8 ] = stopanims[ 0 ];
    return stopanims;
}

/#

    // Namespace arrival
    // Params 6
    // Checksum 0xff736adb, Offset: 0x189b
    // Size: 0xaf, Type: dev
    function debug_arrival_attempt( optimalstartpos, tracestartpos, finalpos, fraction, color, frames )
    {
        if ( !asm::function_ae2d2cb168819b86() )
        {
            return;
        }
        
        line( optimalstartpos, optimalstartpos + ( 0, 0, 64 ), color, 1, 1, frames );
        midpoint = vectorlerp( tracestartpos, finalpos, fraction );
        line( tracestartpos, midpoint, ( 0, 1, 0 ), 1, 1, frames );
        line( midpoint, finalpos, ( 1, 0, 0 ), 1, 1, frames );
    }

    // Namespace arrival
    // Params 2
    // Checksum 0xc111e5d7, Offset: 0x1952
    // Size: 0x7f, Type: dev
    function debug_arrival_position( goal_origin, arrival_angles )
    {
        if ( asm::function_ae2d2cb168819b86() )
        {
            forward = anglestoforward( arrival_angles );
            line( goal_origin, goal_origin + forward * 16, ( 1, 0.4, 0 ), 1, 0, 1 );
            line( goal_origin, goal_origin + ( 0, 0, 64 ), ( 1, 0.4, 0 ), 1, 0, 1 );
        }
    }

#/

// Namespace arrival
// Params 4
// Checksum 0x47f2b5d0, Offset: 0x19d9
// Size: 0x35, Type: bool
function shouldstartarrivalpassthrough( asmname, statename, tostatename, params )
{
    assertmsg( "<dev string:x1cb>" );
    return false;
}

