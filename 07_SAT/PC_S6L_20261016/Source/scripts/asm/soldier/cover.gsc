// scripts\asm\soldier\cover.gsc  (hash_15c58b3443c8f5aa.gscc) (size: 9245 Bytes / 0x241d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc5bea3f3 (3317605363)
// size ...... 9245 (0x241d)
// includes .. 7   (offset: 0x21d1)
// strings ... 35  (offset: 0x2209)
// dev strs .. 5   (offset: 0x23e1)
// exports ... 25  (offset: 0x15d5)
// cseg ...... 0x25a + 0x137b (0x15d5)
// imports ... 68  (offset: 0x19bd)
// animtree1 . 0   (offset: 0x241d)
// animtree2 . 0   (offset: 0x241d)
#using scripts\anim\notetracks;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\utility;

#namespace cover;

// Namespace cover
// Params 0
// Checksum 0xda200476, Offset: 0x278
// Size: 0x29, Type: bool
function shouldcoverexpose()
{
    return asm_bb::bb_getrequestedcoverstate() == "exposed" && isdefined( self.enemy ) && isdefined( self.node );
}

// Namespace cover
// Params 4
// Checksum 0x9f088fb2, Offset: 0x2aa
// Size: 0x49
function shouldcoverexposedreload( asmname, statename, tostatename, params )
{
    if ( isdefined( self.covernode ) && self.balwayscoverexposed )
    {
        return asm_bb::bb_reloadrequested();
    }
    
    return 0;
}

// Namespace cover
// Params 4
// Checksum 0x20abf07f, Offset: 0x2fc
// Size: 0x5b
function calcanimstartpos( stoppos, stopangle, animdelta, animangledelta )
{
    dangle = stopangle - animangledelta;
    angles = ( 0, dangle, 0 );
    worlddelta = rotatevector( animdelta, angles );
    return stoppos - worlddelta;
}

// Namespace cover
// Params 1
// Checksum 0x293a5140, Offset: 0x360
// Size: 0x29, Type: bool
function ishighnode( node )
{
    if ( !isdefined( node ) )
    {
        return false;
    }
    
    if ( node utility::isvalidpeekoutdir( "over" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace cover
// Params 3
// Checksum 0xe818743, Offset: 0x392
// Size: 0x5b
function start_conceal_add( statename, anime, waittime )
{
    self endon( statename + "_finished" );
    waittime = max( waittime, 0.05 );
    wait waittime;
    self setanim( anime, 1, 0.4, 1, 1 );
    thread conceal_add_cleanup( statename );
}

// Namespace cover
// Params 1
// Checksum 0xfd3b878c, Offset: 0x3f5
// Size: 0x4f, Type: bool
function transitionedfromrun( asmname )
{
    prevstate = self asmgetstatetransitioningfrom( asmname );
    
    if ( isdefined( prevstate ) )
    {
        if ( prevstate == "stand_run_loop" )
        {
            return true;
        }
        else if ( utility::actor_is3d() && prevstate == "stand_run_strafe_loop" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace cover
// Params 3
// Checksum 0xaeecc568, Offset: 0x44d
// Size: 0x197
function playcoveranimloop3d( asmname, statename, params )
{
    if ( !isdefined( self.asm.lastcovernode ) )
    {
        var_d1952cbf61aef8b = [ asm_bb::bb_getcovernode(), self.node ];
        
        for ( i = 0; !isdefined( self.asm.lastcovernode ) && i < var_d1952cbf61aef8b.size ; i++ )
        {
            if ( isdefined( var_d1952cbf61aef8b[ i ] ) && distancesquared( self.origin, var_d1952cbf61aef8b[ i ].origin ) < 256 )
            {
                self.asm.lastcovernode = var_d1952cbf61aef8b[ i ];
            }
        }
    }
    
    /#
        if ( isdefined( self.asm.lastcovernode ) )
        {
            if ( statename == "<dev string:x24>" && !utility::nodeiscoverexposed3dtype( self.asm.lastcovernode ) )
            {
                assertmsg( "<dev string:x32>" + utility::getnodetypename( self.asm.lastcovernode ) );
            }
            else if ( statename == "<dev string:x8c>" && !utility::nodeiscoverstand3dtype( self.asm.lastcovernode ) )
            {
                assertmsg( "<dev string:x98>" + utility::getnodetypename( self.asm.lastcovernode ) );
            }
        }
    #/
    
    playcoveranimloop( asmname, statename, params );
}

// Namespace cover
// Params 3
// Checksum 0x2e10dda4, Offset: 0x5ec
// Size: 0x15d
function playcoveranimloop( asmname, statename, params )
{
    self.keepclaimednodeifvalid = 1;
    
    if ( isdefined( params ) )
    {
        if ( params == "stickToNode" )
        {
            covernode = asm_bb::bb_getcovernode();
            
            if ( isdefined( covernode ) )
            {
                if ( distancesquared( covernode.origin, self.origin ) < 16 )
                {
                    self safeteleport( covernode.origin );
                }
                else
                {
                    thread lerpto( covernode, 4, statename + "_finished" );
                }
            }
            
            self.keepclaimednodeifvalid = 0;
            
            if ( transitionedfromrun( asmname ) )
            {
                self setuseanimgoalweight( 0.2 );
            }
        }
    }
    
    if ( !isagent( self ) )
    {
        animindex = archetypegetrandomalias( self.animsetname, statename, "conceal_add" );
        covernode = asm_bb::bb_getcovernode();
        
        if ( isdefined( animindex ) && isdefined( covernode ) && ( covernode.type == "Conceal Crouch" || covernode.type == "Conceal Stand" ) )
        {
            concealanim = asm::asm_getxanim( statename, animindex );
            self setanim( concealanim, 1, 0.2, 1, 1 );
            thread conceal_add_cleanup( statename );
        }
    }
    
    asm::function_b7619cbe4e9abaf4( asmname, statename, 1 );
}

// Namespace cover
// Params 1
// Checksum 0xa4c8f828, Offset: 0x751
// Size: 0x9c
function conceal_add_cleanup( statename )
{
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self notify( #"conceal_add_cleanup" );
    self endon( #"conceal_add_cleanup" );
    self waittill( statename + "_finished" );
    
    if ( archetypehasstate( self.animsetname, "knobs" ) )
    {
        anime = archetypegetalias( self.animsetname, "knobs", "conceal_add" );
        
        if ( isdefined( anime ) )
        {
            self clearanim( anime.anims, 0.4 );
        }
    }
}

// Namespace cover
// Params 3
// Checksum 0x44411c2c, Offset: 0x7f5
// Size: 0xa3
function lerpto( covernode, var_33ea95e43903ea30, endonstr )
{
    self endon( endonstr );
    
    while ( true )
    {
        metodest = covernode.origin - self.origin;
        distmetodest = length( metodest );
        
        if ( distmetodest < var_33ea95e43903ea30 )
        {
            self safeteleport( covernode.origin );
            break;
        }
        
        metodest /= distmetodest;
        dest = self.origin + metodest * var_33ea95e43903ea30;
        self safeteleport( dest );
        wait 0.05;
    }
}

// Namespace cover
// Params 3
// Checksum 0xc1748973, Offset: 0x8a0
// Size: 0x40
function terminatecoverreload( asmname, statename, params )
{
    asm::asm_fireephemeralevent( "reload", "end" );
    self function_b389a72141b859b0();
    namespace_fcb50a41dde46fde::reload_cleanup( asmname, statename, params );
}

// Namespace cover
// Params 3
// Checksum 0xc079a014, Offset: 0x8e8
// Size: 0x83
function playcoveranim_droprpg( asmname, statename, params )
{
    self.keepclaimednodeifvalid = 1;
    myanim = asm::asm_getanim( asmname, statename );
    myxanim = asm::asm_getxanim( statename, myanim );
    self orientmode( "face current" );
    self aisetanim( statename, myanim );
    asm::asm_playfacialanim( asmname, statename, myxanim );
    asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
}

// Namespace cover
// Params 3
// Checksum 0x5c836c53, Offset: 0x973
// Size: 0x14c
function playshuffleloop( asmname, statename, params )
{
    var_f40991160ed36d02 = [];
    var_f40991160ed36d02[ "crouch_shuffle_right" ] = -90;
    var_f40991160ed36d02[ "crouch_shuffle_left" ] = 90;
    var_f40991160ed36d02[ "stand_shuffle_right" ] = -90;
    var_f40991160ed36d02[ "stand_shuffle_left" ] = 90;
    self endon( statename + "_finished" );
    shuffleanim = asm::asm_getanim( asmname, statename );
    shufflexanim = asm::asm_getxanim( statename, shuffleanim );
    self aisetanim( statename, shuffleanim );
    asm::asm_playfacialanim( asmname, statename, shufflexanim );
    
    if ( isdefined( self._blackboard.shufflenode ) )
    {
        faceangle = self._blackboard.shufflenode.angles[ 1 ];
    }
    else if ( isdefined( self.node ) )
    {
        faceangle = self.node.angles[ 1 ];
    }
    else
    {
        faceangle = self.angles[ 1 ];
    }
    
    if ( self.unittype != "c6" && isdefined( var_f40991160ed36d02[ statename ] ) )
    {
        faceangle += var_f40991160ed36d02[ statename ];
    }
    
    self orientmode( "face angle", faceangle );
    asm::asm_donotetracks( asmname, statename );
}

// Namespace cover
// Params 4
// Checksum 0x44909125, Offset: 0xac7
// Size: 0xc6, Type: bool
function shouldplayshuffleenter( asmname, statename, tostatename, params )
{
    assert( isdefined( self._blackboard.shufflenode ) );
    enteranim = asm::asm_getrandomanim( asmname, tostatename );
    enterxanim = asm::asm_getxanim( tostatename, enteranim );
    entertranslation = getmovedelta( enterxanim );
    enterdistsq = lengthsquared( entertranslation );
    disttogoalsq = distancesquared( self.origin, self._blackboard.shufflenode.origin );
    return enterdistsq <= disttogoalsq + 1;
}

// Namespace cover
// Params 3
// Checksum 0x1d6ca7cb, Offset: 0xb96
// Size: 0x31
function abortshufflecleanup( asmname, statename, params )
{
    self._blackboard.shufflenode = undefined;
}

// Namespace cover
// Params 4
// Checksum 0x4e159c8, Offset: 0xbcf
// Size: 0x296, Type: bool
function shouldbeginshuffleexit( asmname, statename, tostatename, params )
{
    assert( isdefined( self._blackboard.shufflenode ) );
    assert( isdefined( self.node ) );
    assert( self.node == self._blackboard.shufflenode );
    shufflefromnode = self.prevcovernode;
    
    if ( !isdefined( shufflefromnode ) )
    {
        shufflefromnode = self.covernode;
    }
    
    assert( isdefined( shufflefromnode ) );
    nodetype = self._blackboard.shufflenode.type;
    
    if ( nodetype == "Cover Crouch" || nodetype == "Cover Crouch Window" || nodetype == "Conceal Crouch" )
    {
        dvarvalue = getdvar( @"hash_f72dde9792b94cc9" );
        
        if ( isdefined( self.node.covercrouchtype ) )
        {
            nodetype = self.node.covercrouchtype;
        }
        else if ( dvarvalue != "" )
        {
            nodetype = dvarvalue;
        }
    }
    
    if ( isdefined( params ) && nodetype != params )
    {
        return false;
    }
    
    exitanim = asm::asm_getrandomanim( asmname, tostatename );
    exitxanim = asm::asm_getxanim( statename, exitanim );
    goaldelta = self._blackboard.shufflenode.origin - self.origin;
    goaldir = vectornormalize( goaldelta );
    exitmovedelta = getmovedelta( exitxanim, 0, 1 );
    exitdist = length( exitmovedelta );
    goalpos = self._blackboard.shufflenode.origin - goaldir * exitdist;
    goaldelta = goalpos - self.origin;
    shuffledelta = self._blackboard.shufflenode.origin - shufflefromnode.origin;
    shuffledelta = ( shuffledelta[ 0 ], shuffledelta[ 1 ], 0 );
    
    if ( vectordot( shuffledelta, goaldelta ) <= 0 )
    {
        return true;
    }
    
    if ( length2dsquared( self.velocity ) > 1 && vectordot( goaldir, self.velocity ) <= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace cover
// Params 3
// Checksum 0x38f35591, Offset: 0xe6e
// Size: 0x1a5
function playshuffleanim_arrival( asmname, statename, params )
{
    self.a.arrivalasmstatename = statename;
    arrivalanim = asm::asm_getanim( asmname, statename );
    arrivalxanim = asm::asm_getxanim( statename, arrivalanim );
    self aisetanim( statename, arrivalanim );
    asm::asm_playfacialanim( asmname, statename, arrivalxanim );
    animtranslation = getmovedelta( arrivalxanim );
    animrotation = getangledelta3d( arrivalxanim );
    
    if ( isdefined( self._blackboard.shufflenode ) )
    {
        node = self._blackboard.shufflenode;
    }
    else
    {
        node = self.node;
    }
    
    if ( isdefined( node ) )
    {
        desiredendpos = node.origin;
        desiredendangles = ( 0, utility::getnodeforwardyaw( node ), 0 );
        desiredstartangles = combineangles( desiredendangles, invertangles( animrotation ) );
        desiredstartpos = node.origin - rotatevector( animtranslation, desiredstartangles );
    }
    else
    {
        desiredendpos = self.origin + animtranslation;
        desiredendangles = combineangles( self.angles, animrotation );
        desiredstartpos = self.origin;
        desiredstartangles = self.angles;
    }
    
    warpduration = int( 1000 * getanimlength( arrivalxanim ) - 200 );
    self startcoverarrival();
    self motionwarpwithanim( desiredstartpos, desiredstartangles, desiredendpos, desiredendangles, warpduration );
    asm::asm_donotetracks( asmname, statename );
}

// Namespace cover
// Params 3
// Checksum 0x9eacc3c4, Offset: 0x101b
// Size: 0x4a
function playshuffleanim_terminate( asmname, statename, params )
{
    self._blackboard.shufflenode = undefined;
    self._blackboard.shufflefromnode = undefined;
    self finishcoverarrival();
}

// Namespace cover
// Params 1
// Checksum 0x3b19a25c, Offset: 0x106d
// Size: 0x15
function coverreloadnotetrackhandler( note )
{
    notetracks::notetrack_prefix_handler( note );
}

// Namespace cover
// Params 4
// Checksum 0x242b142b, Offset: 0x108b
// Size: 0x203, Type: bool
function cover3dpickexposedir( asmname, statename, tostatename, params )
{
    assert( isdefined( self.enemy ) );
    assert( isdefined( self.node ) );
    assert( self.node.type == "<dev string:xee>" );
    self.bt.cover3dexposedirpicked = undefined;
    enemyeye = ( self.enemy.origin + utility_common::getenemyeyepos() ) / 2;
    current_state = anim.asm[ asmname ].states[ tostatename ];
    random_transitions = arrayrandomize( current_state.transitions );
    dir_picked = undefined;
    
    foreach ( transition in random_transitions )
    {
        assert( isdefined( transition.shouldtransitionparams ) );
        dir_picked = transition.shouldtransitionparams;
        
        if ( dir_picked == "up" )
        {
            break;
        }
        
        nodeoffset = utility_common::getcover3dnodeoffset( self.node, dir_picked );
        nodelookfrompoint = self.node.origin + nodeoffset;
        
        if ( sighttracepassed( nodelookfrompoint, enemyeye, 0, undefined ) )
        {
            break;
        }
    }
    
    assert( isdefined( dir_picked ) );
    self.bt.cover3dexposedirpicked = asmname + "_" + tostatename + "_" + dir_picked;
    return true;
}

// Namespace cover
// Params 4
// Checksum 0x78551b2, Offset: 0x1297
// Size: 0x5d, Type: bool
function cover3dcanexposedir( asmname, statename, tostatename, params )
{
    var_ba80cbb504a66663 = asmname + "_" + statename + "_" + params;
    return var_ba80cbb504a66663 == self.bt.cover3dexposedirpicked;
}

// Namespace cover
// Params 4
// Checksum 0xc32266c5, Offset: 0x12fd
// Size: 0xe0, Type: bool
function checkcovermultichangerequest( asmname, statename, tostatename, params )
{
    if ( !asm_bb::bb_iscovermultiswitchrequested() )
    {
        return false;
    }
    
    covernode = asm_bb::bb_getcovernode();
    assert( isdefined( covernode ) );
    requestednodetype = asm_bb::bb_getrequestedcovermultiswitchnodetype();
    
    if ( requestednodetype != params )
    {
        return false;
    }
    
    assert( !isdefined( self.asm.covermultiswitchdata ) );
    self.asm.covermultiswitchdata = spawnstruct();
    self.asm.covermultiswitchdata.requestednode = covernode;
    self.asm.covermultiswitchdata.requestednodetype = requestednodetype;
    return true;
}

// Namespace cover
// Params 3
// Checksum 0x849f1dce, Offset: 0x13e6
// Size: 0xa0
function finishcovermultichangerequest( asmname, statename, params )
{
    assert( isdefined( self.asm.covermultiswitchdata ) );
    requestednodetype = self.asm.covermultiswitchdata.requestednodetype;
    self.asm.covermultiswitchdata.requestednode setcovermultinodetype( requestednodetype );
    self.asm.covermultiswitchdata = undefined;
    self function_b389a72141b859b0();
}

// Namespace cover
// Params 0
// Checksum 0x76eb8177, Offset: 0x148e
// Size: 0x147
function function_161998d1980a9b77()
{
    if ( isdefined( self.covernode ) )
    {
        if ( self.covernode.type == "Cover Stand" )
        {
            self.coverposerequest = "cover_stand";
            return;
        }
        
        if ( self.covernode.type == "Cover Crouch" || self.covernode.type == "Cover Crouch Window" )
        {
            self.coverposerequest = "cover_crouch";
            return;
        }
        
        if ( self.covernode.type == "Cover Right" )
        {
            if ( self.currentpose == "stand" )
            {
                self.coverposerequest = "cover_right";
            }
            else if ( self.currentpose == "crouch" )
            {
                self.coverposerequest = "cover_right_crouch";
            }
            
            return;
        }
        
        if ( self.covernode.type == "Cover Left" )
        {
            if ( self.currentpose == "stand" )
            {
                self.coverposerequest = "cover_left";
                return;
            }
            
            if ( self.currentpose == "crouch" )
            {
                self.coverposerequest = "cover_left_crouch";
            }
        }
    }
}

