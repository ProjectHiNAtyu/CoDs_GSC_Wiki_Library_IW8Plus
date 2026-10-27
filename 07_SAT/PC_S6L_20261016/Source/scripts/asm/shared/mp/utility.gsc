// scripts\asm\shared\mp\utility.gsc  (hash_669a259af13c5e60.gscc) (size: 9864 Bytes / 0x2688 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x920a9108 (2450166024)
// size ...... 9864 (0x2688)
// includes .. 6   (offset: 0x24b8)
// strings ... 10  (offset: 0x24e8)
// dev strs .. 13  (offset: 0x25e4)
// exports ... 38  (offset: 0x14c4)
// cseg ...... 0xe2 + 0x13e2 (0x14c4)
// imports ... 78  (offset: 0x1ab4)
// animtree1 . 0   (offset: 0x2688)
// animtree2 . 0   (offset: 0x2688)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_mp;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace utility;

// Namespace utility
// Params 0
// Checksum 0xb92e8a4d, Offset: 0x100
// Size: 0x50
function dotraversal()
{
    self endon( #"killanimscript" );
    startnode = self getnegotiationstartnode();
    animscript = startnode.animscript;
    self notify( #"traverse_begin", animscript, startnode );
    self waittill( #"traverse_end" );
}

// Namespace utility
// Params 3
// Checksum 0xabcf37b9, Offset: 0x158
// Size: 0x1f, Type: bool
function chooseanimwithoverride( asmname, statename, params )
{
    return false;
}

// Namespace utility
// Params 3
// Checksum 0x667ef2bf, Offset: 0x180
// Size: 0x97
function loopanimfortime( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self endon( #"terminate_ai_threads" );
    endevent = "loop_end";
    t = 2;
    
    if ( isarray( params ) )
    {
        if ( params.size > 0 )
        {
            t = params[ 0 ];
        }
        
        if ( params.size > 1 )
        {
            endevent = params[ 1 ];
        }
    }
    else
    {
        t = params;
    }
    
    thread asm::function_b7619cbe4e9abaf4( asmname, statename, 1 );
    wait t;
    asm::asm_fireevent( asmname, endevent );
}

// Namespace utility
// Params 2
// Checksum 0xbff37efe, Offset: 0x21f
// Size: 0x9b
function waitforpathchange( asmname, statename )
{
    self endon( statename + "_finished" );
    self waittill( #"path_set" );
    var_34b0780305cea66e = self.lookaheaddir * self.lookaheaddist;
    turnparams = [ 0, var_34b0780305cea66e, 0, self.origin, self.lookaheaddist ];
    asm::asm_fireevent( asmname, "sharp_turn", turnparams );
    thread waitforpathchange( asmname, statename );
}

// Namespace utility
// Params 3
// Checksum 0x73cd355c, Offset: 0x2c2
// Size: 0x8b
function playmoveloop_mp( asmname, statename, params )
{
    thread waitforpathchange( asmname, statename );
    rate = 1;
    
    if ( isdefined( self.asm.moveplaybackrate ) )
    {
        rate = self.asm.moveplaybackrate;
    }
    else if ( isdefined( self.moveplaybackrate ) )
    {
        rate = self.moveplaybackrate;
    }
    
    asm::function_b7619cbe4e9abaf4( asmname, statename, rate );
}

// Namespace utility
// Params 1
// Checksum 0x85c0ab17, Offset: 0x355
// Size: 0x78, Type: bool
function isfacingenemy( mindot = 0.5 )
{
    forward = anglestoforward( self.angles );
    dirtoenemy = vectornormalize( self.enemy.origin - self.origin );
    dot = vectordot( forward, dirtoenemy );
    
    if ( dot < mindot )
    {
        return false;
    }
    
    return true;
}

// Namespace utility
// Params 0
// Checksum 0x39754067, Offset: 0x3d6
// Size: 0xf, Type: bool
function isweaponfacingenemy()
{
    if ( isaimedataimtarget() )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 0
// Checksum 0x8cc3e4ee, Offset: 0x3ee
// Size: 0x15, Type: bool
function wantstocrouch()
{
    if ( asm_bb::bb_getrequestedstance() == "crouch" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0xa7607111, Offset: 0x40c
// Size: 0xa2
function function_660c1030425af7e0( shootfrompos )
{
    if ( !self._blackboard.shootparams_valid )
    {
        return;
    }
    
    if ( isdefined( self._blackboard.shootparams_ent ) )
    {
        return self._blackboard.shootparams_ent getshootatpos();
    }
    
    if ( isdefined( self._blackboard.shootparams_pos ) )
    {
        return self._blackboard.shootparams_pos;
    }
    
    if ( isdefined( self.enemy ) )
    {
        return self.enemy getshootatpos();
    }
}

// Namespace utility
// Params 0
// Checksum 0xa29e71d0, Offset: 0x4b7
// Size: 0xef, Type: bool
function isaimedataimtarget()
{
    if ( !isdefined( self._blackboard.shootparams_pos ) && !isdefined( self._blackboard.shootparams_ent ) )
    {
        return true;
    }
    
    weaponangles = self getmuzzleangle();
    shootfrompos = self getshootfrompos();
    shootpos = function_660c1030425af7e0( shootfrompos );
    
    if ( !isdefined( shootpos ) )
    {
        return false;
    }
    
    var_6f812cb8547abe64 = vectortoangles( shootpos - shootfrompos );
    absyawdiff = absangleclamp180( weaponangles[ 1 ] - var_6f812cb8547abe64[ 1 ] );
    
    if ( absyawdiff > anim.aimyawdifffartolerance )
    {
        if ( distancesquared( self geteye(), shootpos ) > anim.aimyawdiffclosedistsq || absyawdiff > anim.aimyawdiffclosetolerance )
        {
        }
    }
    
    aimpitchdifftolerance = getaimpitchdifftolerance();
    return absangleclamp180( weaponangles[ 0 ] - var_6f812cb8547abe64[ 0 ] ) <= aimpitchdifftolerance;
}

// Namespace utility
// Params 0
// Checksum 0x74cdd498, Offset: 0x5af
// Size: 0x29
function getaimpitchdifftolerance()
{
    var_7237854e3be197ca = self.aimpitchdifftolerance;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return anim.aimpitchdifftolerance;
}

// Namespace utility
// Params 4
// Checksum 0x8467241b, Offset: 0x5e1
// Size: 0x27
function delayslowmotion( delay, start, end, time )
{
    
}

// Namespace utility
// Params 3
// Checksum 0xe7bddca9, Offset: 0x610
// Size: 0x1e
function delaymodifybasefov( delay, fov, time )
{
    
}

// Namespace utility
// Params 8
// Checksum 0x525f1a23, Offset: 0x636
// Size: 0x80
function animscriptmp( archetype, statename, aliasname, loop, playbackrate, customendon, scriptednode, tag )
{
    if ( isdefined( customendon ) )
    {
        thread animscriptmp_watchcancel( customendon );
    }
    
    if ( loop )
    {
        thread animscriptmp_loop_internal( archetype, statename, aliasname, playbackrate, scriptednode, tag );
        return;
    }
    
    thread animscriptmp_single_internal( archetype, statename, aliasname, playbackrate, scriptednode, tag );
}

// Namespace utility
// Params 0
// Checksum 0x3a9f0c7, Offset: 0x6be
// Size: 0x21
function cancelanimscriptmp()
{
    if ( !asm_bb::bb_isanimscripted() )
    {
        return 0;
    }
    
    cancelanimscriptmp_internal();
    self notify( #"hash_3bae292bd79c1de4" );
}

// Namespace utility
// Params 1
// Checksum 0xc4e47ac6, Offset: 0x6e7
// Size: 0x3d
function animscriptmp_watchcancel( customendon )
{
    self endon( #"animscriptmp_complete" );
    self endon( #"death" );
    self endon( #"hash_3bae292bd79c1de4" );
    self waittill( customendon );
    cancelanimscriptmp();
}

// Namespace utility
// Params 6
// Checksum 0xc48a5dd0, Offset: 0x72c
// Size: 0xa0
function animscriptmp_single_internal( archetype, statename, aliasname, playbackrate, scriptnode, tag )
{
    animscriptmp_internal( archetype, statename, aliasname, playbackrate, scriptnode, tag );
    var_7c1c6605ddd0f7dd = playbackrate == 0;
    
    if ( !var_7c1c6605ddd0f7dd && isalive( self ) )
    {
        cancelanimscriptmp_internal();
        self notify( #"animscriptmp_complete" );
        self notify( #"single anim", "end" );
        self notify( #"looping anim", "end" );
    }
}

// Namespace utility
// Params 6
// Checksum 0x8a5577c, Offset: 0x7d4
// Size: 0x68
function animscriptmp_loop_internal( archetype, statename, aliasname, playbackrate, scriptnode, tag )
{
    self endon( #"hash_3bae292bd79c1de4" );
    self endon( #"death" );
    
    while ( true )
    {
        animscriptmp_internal( archetype, statename, aliasname, playbackrate, scriptnode, tag );
    }
}

// Namespace utility
// Params 4, eflags: 0x4
// Checksum 0x8cbe8409, Offset: 0x844
// Size: 0xb5
function private function_60823a6b47e24e37( xanim, scriptnode, tag, animindex )
{
    if ( isdefined( tag ) )
    {
        assert( isent( scriptnode ) );
        startpos = scriptnode gettagorigin( tag );
        startangles = scriptnode gettagangles( tag );
    }
    else
    {
        startpos = scriptnode.origin;
        startangles = scriptnode.angles;
    }
    
    animstartpos = getstartorigin( startpos, startangles, xanim );
    animstartangles = getstartangles( startpos, startangles, xanim );
    self dontinterpolate();
    self forceteleport( animstartpos, animstartangles, 9999999, 0 );
}

// Namespace utility
// Params 6
// Checksum 0x3d09575d, Offset: 0x901
// Size: 0xf3
function animscriptmp_internal( archetype, statename, aliasname, playbackrate, scriptnode, tag )
{
    self endon( #"hash_3bae292bd79c1de4" );
    self endon( #"death" );
    
    if ( !isdefined( playbackrate ) )
    {
        playbackrate = 1;
    }
    
    self setoverridearchetype( "animscript", archetype, 1 );
    asm_mp::asm_setanimscripted();
    animindex = archetypegetrandomalias( archetype, statename, aliasname );
    xanim = animsetgetanimfromindex( archetype, statename, animindex );
    
    if ( isdefined( scriptnode ) )
    {
        function_60823a6b47e24e37( xanim, scriptnode, tag, animindex );
    }
    
    self aisetanim( statename, animindex, playbackrate );
    self aisetanimrate( statename, animindex, playbackrate );
    animlength = getanimlength( xanim );
    self.scripted_mode = 1;
    self.ignoreall = 1;
    
    if ( playbackrate > 0 )
    {
        wait animlength / playbackrate;
    }
}

// Namespace utility
// Params 0
// Checksum 0x57134aad, Offset: 0x9fc
// Size: 0x30
function cancelanimscriptmp_internal()
{
    asm_bb::bb_clearanimscripted();
    self scriptedanimfinished();
    self clearoverridearchetype( "animscript", 0, 0 );
    self.scripted_mode = 0;
    self.ignoreall = 0;
}

// Namespace utility
// Params 3
// Checksum 0xbdf3580d, Offset: 0xa34
// Size: 0xa5
function animscripted_single( aliasname, var_9de4895ec11417b8, statename )
{
    assert( isalive( self ), "<dev string:x24>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    asm_mp::asm_setanimscripted();
    
    if ( !isdefined( statename ) )
    {
        statename = "animscripted";
    }
    
    animindex = asm::asm_lookupanimfromalias( statename, aliasname );
    self aisetanim( statename, animindex );
    
    if ( !isdefined( var_9de4895ec11417b8 ) )
    {
        var_9de4895ec11417b8 = 0;
    }
    
    if ( !var_9de4895ec11417b8 )
    {
        xanim = asm::asm_getxanim( statename, animindex );
        
        if ( isdefined( xanim ) )
        {
            animlength = getanimlength( xanim );
            wait animlength;
        }
    }
}

// Namespace utility
// Params 2
// Checksum 0xe9b58c37, Offset: 0xae1
// Size: 0x67
function animscripted_first_frame( aliasname, statename )
{
    assert( isalive( self ), "<dev string:x54>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    asm_mp::asm_setanimscripted();
    
    if ( !isdefined( statename ) )
    {
        statename = "animscripted";
    }
    
    animindex = asm::asm_lookupanimfromalias( statename, aliasname );
    self aisetanim( statename, animindex, 0 );
}

// Namespace utility
// Params 2
// Checksum 0xd8c4a11, Offset: 0xb50
// Size: 0x9d
function animscripted_single_earlyend( aliasname, time )
{
    assert( isalive( self ), "<dev string:x89>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    assert( time > 0 );
    asm_mp::asm_setanimscripted();
    animindex = asm::asm_lookupanimfromalias( "animscripted", aliasname );
    self aisetanim( "animscripted", animindex );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    
    if ( time < animlength )
    {
        wait animlength - time;
    }
}

// Namespace utility
// Params 1
// Checksum 0x5bb556f2, Offset: 0xbf5
// Size: 0xa5
function animscripted_loop( aliasname )
{
    self endon( #"death" );
    assert( isalive( self ), "<dev string:xc2>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    asm_mp::asm_setanimscripted();
    animindex = asm::asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    
    if ( animlength < 0.05 )
    {
        animlength = 0.05;
    }
    
    while ( true )
    {
        self aisetanim( "animscripted", animindex );
        wait animlength;
    }
}

// Namespace utility
// Params 2
// Checksum 0xc534c277, Offset: 0xca2
// Size: 0xaf
function animscripted_loop_earlyend( aliasname, time )
{
    assert( isalive( self ), "<dev string:xf0>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    asm_mp::asm_setanimscripted();
    animindex = asm::asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    
    if ( time < animlength )
    {
        animlength -= time;
    }
    
    if ( animlength < 0.05 )
    {
        animlength = 0.05;
    }
    
    while ( true )
    {
        self aisetanim( "animscripted", animindex );
        wait animlength;
    }
}

// Namespace utility
// Params 2
// Checksum 0xe2e6c4ab, Offset: 0xd59
// Size: 0xc2
function animscripted_loop_for_time( aliasname, time )
{
    assert( time > 0 );
    assert( isalive( self ), "<dev string:x127>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    asm_mp::asm_setanimscripted();
    animindex = asm::asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    
    if ( animlength < 0.05 )
    {
        animlength = 0.05;
    }
    
    timeremaining = time;
    
    while ( timeremaining >= 0 )
    {
        self aisetanim( "animscripted", animindex );
        wait animlength;
        timeremaining -= animlength;
    }
}

// Namespace utility
// Params 2
// Checksum 0x85fd8de2, Offset: 0xe23
// Size: 0xb1
function animscripted_loop_n_times( aliasname, numloops )
{
    assert( numloops );
    assert( isalive( self ), "<dev string:x15e>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    asm_mp::asm_setanimscripted();
    animindex = asm::asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    
    if ( animlength < 0.05 )
    {
        animlength = 0.05;
    }
    
    while ( numloops > 0 )
    {
        self aisetanim( "animscripted", animindex );
        wait animlength;
        numloops--;
    }
}

// Namespace utility
// Params 3
// Checksum 0xd7249513, Offset: 0xedc
// Size: 0xd5
function animscripted_loop_relative( aliasname, ent, tag )
{
    self endon( #"death" );
    assert( isdefined( ent ) );
    assert( isalive( self ), "<dev string:x15e>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    asm_mp::asm_setanimscripted();
    animindex = asm::asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    function_60823a6b47e24e37( xanim, ent, tag, animindex );
    
    while ( true )
    {
        if ( !self._blackboard.animscriptedactive )
        {
            return;
        }
        
        self aisetanim( "animscripted", animindex );
        animlength = getanimlength( xanim );
        wait animlength;
    }
}

// Namespace utility
// Params 5
// Checksum 0x7bde940a, Offset: 0xfb9
// Size: 0xc9
function animscripted_single_relative( aliasname, ent, tag, var_9de4895ec11417b8, statename )
{
    assert( isdefined( ent ) );
    assert( isalive( self ), "<dev string:x194>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !isdefined( statename ) )
    {
        statename = "animscripted";
    }
    
    asm_mp::asm_setanimscripted();
    animindex = asm::asm_lookupanimfromalias( statename, aliasname );
    xanim = asm::asm_getxanim( statename, animindex );
    function_60823a6b47e24e37( xanim, ent, tag, animindex );
    self aisetanim( statename, animindex );
    
    if ( !isdefined( var_9de4895ec11417b8 ) )
    {
        var_9de4895ec11417b8 = 0;
    }
    
    if ( !var_9de4895ec11417b8 )
    {
        animlength = getanimlength( xanim );
        wait animlength;
    }
}

// Namespace utility
// Params 4
// Checksum 0x486f74a6, Offset: 0x108a
// Size: 0x107
function animscripted_single_arrive_at( aliasname, pos, angles, var_9de4895ec11417b8 )
{
    assert( isalive( self ), "<dev string:x1cd>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    asm_mp::asm_setanimscripted();
    animindex = asm::asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    animdelta = getmovedelta( xanim );
    animangles = getangledelta3d( xanim );
    startangles = combineangles( angles, invertangles( animangles ) );
    startpos = pos - rotatevector( animdelta, startangles );
    self dontinterpolate();
    self forceteleport( startpos, startangles, 9999999, 0 );
    self aisetanim( "animscripted", animindex );
    
    if ( !isdefined( var_9de4895ec11417b8 ) )
    {
        var_9de4895ec11417b8 = 0;
    }
    
    if ( !var_9de4895ec11417b8 )
    {
        animlength = getanimlength( xanim );
        wait animlength;
    }
}

// Namespace utility
// Params 0
// Checksum 0xaa2a609f, Offset: 0x1199
// Size: 0xf
function animscripted_clear()
{
    asm_bb::bb_clearanimscripted();
    self scriptedanimfinished();
}

// Namespace utility
// Params 1
// Checksum 0x55f209e6, Offset: 0x11b0
// Size: 0x38, Type: bool
function function_4c656524ecb504d6( anime )
{
    if ( !( isdefined( self.animname ) && isdefined( level.scr_anim[ self.animname ][ anime ] ) ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility
// Params 6
// Checksum 0x955e6c91, Offset: 0x11f1
// Size: 0x168
function animscriptedagent( anime, anim_string, org, animangles, anim_flag, dont_clear )
{
    self endon( #"death" );
    
    if ( isstring( anim_flag ) )
    {
        ent_flag_set( anim_flag );
    }
    
    aliasname = level.scr_anim[ self.animname ][ anime ];
    assert( isdefined( aliasname ), "<dev string:x207>" + ( anime ?? "<dev string:x21e>" ) + "<dev string:x228>" + ( self.animname ?? "<dev string:x21e>" ) + "<dev string:x23a>" );
    
    if ( isanimation( aliasname ) )
    {
        aliasname = getanimname( aliasname );
    }
    
    callback_name = anime + "_animscripted";
    callback::callback( callback_name, { #aliasname:aliasname } );
    
    if ( isdefined( org ) )
    {
        anim_node = spawnstruct();
        anim_node.origin = org;
        anim_node.angles = animangles;
        animscripted_single_relative( aliasname, anim_node );
    }
    else
    {
        animscripted_single( aliasname );
    }
    
    self notify( anim_string, "end" );
    
    if ( dont_clear )
    {
        return;
    }
    
    if ( !ent_flag( "scene_active" ) )
    {
        animscripted_clear();
    }
    
    if ( isstring( anim_flag ) )
    {
        ent_flag_clear( anim_flag );
    }
}

// Namespace utility
// Params 1
// Checksum 0x9bac9ea8, Offset: 0x1361
// Size: 0x69
function function_80505911b6822d3( anime )
{
    spawn_anim = asm::asm_lookupanimfromalias( "animscripted", level.scr_anim[ self.animname ][ anime ] );
    spawn_xanim = animsetgetanimfromindex( function_18bf04f16702b9b2(), "animscripted", spawn_anim );
    spawn_anim_delta = getmovedelta( spawn_xanim, 0, 1 );
    return spawn_anim_delta;
}

// Namespace utility
// Params 1
// Checksum 0x5ed439de, Offset: 0x13d3
// Size: 0x69
function function_f59c00aad3d87ab9( anime )
{
    spawn_anim = asm::asm_lookupanimfromalias( "animscripted", level.scr_anim[ self.animname ][ anime ] );
    spawn_xanim = animsetgetanimfromindex( function_18bf04f16702b9b2(), "animscripted", spawn_anim );
    spawn_anim_delta = getangledelta( spawn_xanim, 0, 1 );
    return spawn_anim_delta;
}

// Namespace utility
// Params 2
// Checksum 0x774e565f, Offset: 0x1445
// Size: 0x7f
function ai_anim_first_frame( animation, animname )
{
    level_archetype = "agent_scripted_" + getdvar( @"g_mapname" );
    aliasname = getanimname( animation );
    
    if ( archetypeassetloaded( level_archetype ) )
    {
        thread animscriptmp( level_archetype, "animscripted", aliasname, undefined, 0 );
        return;
    }
    
    statename = "animscripted";
    thread animscripted_first_frame( aliasname, statename );
}

