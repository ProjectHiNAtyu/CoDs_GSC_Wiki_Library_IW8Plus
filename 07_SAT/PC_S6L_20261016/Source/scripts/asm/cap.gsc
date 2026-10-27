// scripts\asm\cap.gsc  (hash_4e1d4dd23699a8a4.gscc) (size: 36776 Bytes / 0x8fa8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3339a65 (53713509)
// size ...... 36776 (0x8fa8)
// includes .. 9   (offset: 0x879c)
// strings ... 119 (offset: 0x87e4)
// dev strs .. 16  (offset: 0x8ecc)
// exports ... 125 (offset: 0x5a60)
// cseg ...... 0xdd0 + 0x4c90 (0x5a60)
// imports ... 193 (offset: 0x6de8)
// animtree1 . 0   (offset: 0x8fa8)
// animtree2 . 0   (offset: 0x8fa8)
#using scripts\anim\notetracks;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\gesture;
#using scripts\asm\shared\death;
#using scripts\common\anim;
#using scripts\common\cap;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace asm_cap;

// Namespace asm_cap
// Params 3
// Checksum 0x75a874d5, Offset: 0xdee
// Size: 0x138
function function_d5f3ba0089e6bb87( asmname, statename, params )
{
    uselr = 0;
    aliasprefix = "";
    
    if ( isdefined( params ) )
    {
        if ( !isarray( params ) )
        {
            aliasprefix = params;
        }
        else
        {
            aliasprefix = params[ 0 ];
            uselr = params[ 1 ];
        }
    }
    
    warptarget = self function_564775eb2acf5e3f();
    targetangles = self.angles;
    
    if ( isdefined( warptarget ) )
    {
        targetpos = warptarget.origin;
        movedirnormalized = vectornormalize( targetpos - self.origin );
        targetangles = vectortoangles( movedirnormalized );
    }
    
    targetyaw = angleclamp180( targetangles[ 1 ] - self.angles[ 1 ] );
    angleindex = asm::yawdiffto2468( targetyaw );
    
    if ( uselr && angleindex == "2" )
    {
        if ( targetyaw < 0 )
        {
            angleindex = "2l";
        }
        else
        {
            angleindex = "2r";
        }
    }
    
    aliasname = aliasprefix + angleindex;
    turnanim = cap_lookupanimfromalias( statename, aliasname );
    return turnanim;
}

// Namespace asm_cap
// Params 3
// Checksum 0xc7de9a13, Offset: 0xf2f
// Size: 0x44
function cap_playanim_pushed( asmname, statename, params )
{
    self.lasttimepushed = gettime();
    self.attitude = "curious";
    cap_playanim( asmname, statename, params );
}

// Namespace asm_cap
// Params 2
// Checksum 0x14ac14cf, Offset: 0xf7b
// Size: 0x1dd
function function_b0881496c5f588c3( asmname, sourceciv )
{
    self endon( #"death" );
    player = getclosestplayer( sourceciv.origin );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    movedirnormalized = vectornormalize( sourceciv.origin - player.origin );
    sourcecivorigin = sourceciv.origin;
    wait 0.5;
    
    foreach ( otherciv in level.civreactdata.civs )
    {
        if ( !isalive( otherciv ) || otherciv == sourceciv )
        {
            continue;
        }
        
        if ( isdefined( otherciv.capgroup ) && isdefined( sourceciv.gapgroup ) )
        {
            if ( level.capgroups[ otherciv.gapgroup ] == level.capgroups[ sourceciv.capgroup ] )
            {
                continue;
            }
        }
        
        tootherciv = otherciv.origin - sourcecivorigin;
        var_228e5851bf553acb = lengthsquared( tootherciv );
        maxdistance = 80;
        
        if ( var_228e5851bf553acb > maxdistance * maxdistance )
        {
            continue;
        }
        
        var_e43eacb01fe4be6e = vectornormalize( tootherciv );
        dot = vectordot( var_e43eacb01fe4be6e, movedirnormalized );
        
        if ( dot > 0.96 )
        {
            otherciv asm::asm_fireevent( asmname, "player_pushed" );
        }
    }
}

// Namespace asm_cap
// Params 1, eflags: 0x4
// Checksum 0xfb7654b8, Offset: 0x1160
// Size: 0x60
function private getclosestplayer( testorigin )
{
    if ( utility::ismp() )
    {
        radius = 700;
        players = getplayersinradius( testorigin, radius );
        
        if ( !isdefined( players ) )
        {
            return;
        }
        
        if ( players.size == 0 )
        {
            return;
        }
        
        players = sortbydistance( players, testorigin );
        return players[ 0 ];
    }
    
    return level.player;
}

// Namespace asm_cap
// Params 3
// Checksum 0xefb10c97, Offset: 0x11c8
// Size: 0x4e
function cap_playanim_pushed_hard( asmname, statename, params )
{
    thread function_b0881496c5f588c3( asmname, self );
    self.lasttimepushed = gettime();
    self.attitude = "angered";
    cap_playanim( asmname, statename, params );
}

// Namespace asm_cap
// Params 1
// Checksum 0x64c954d5, Offset: 0x121e
// Size: 0x13c
function function_f867c83bad54ffa8( statename )
{
    self notify( #"lerp_arrive_finished" );
    self endon( #"death" );
    self endon( #"lerp_arrive_finished" );
    alpha = 0;
    startorigin = self.origin;
    startangles = self.angles;
    targetpos = getclosestpointonnavmesh( self.origin, self );
    xanim = animsetgetanimfromindex( self.animsetname, statename, self.capanimid );
    animend = getoriginforanimtime( self.origin, self.angles, xanim, 1 );
    animlength = getanimlength( xanim );
    starttime = gettime();
    
    if ( ispointonnavmesh( animend ) )
    {
        self notify( #"lerp_arrive_finished" );
        return;
    }
    
    while ( alpha < animlength )
    {
        waitframe();
        alpha = ( gettime() - starttime ) / 1000;
        newpos = vectorlerp( self.origin, targetpos, alpha );
        self forceteleport( newpos, startangles );
    }
    
    self notify( #"lerp_arrive_finished" );
}

// Namespace asm_cap
// Params 3
// Checksum 0xf1ef60e6, Offset: 0x1362
// Size: 0x44
function cap_playanim( asmname, statename, params )
{
    self.capanimid = asm::asm_getanim( asmname, statename );
    cap_playanim_internal( asmname, statename, params, self.capanimid );
}

// Namespace asm_cap
// Params 4
// Checksum 0x245e8ef2, Offset: 0x13ae
// Size: 0x17a
function cap_playanim_internal( asmname, statename, params, animid )
{
    self endon( statename + "_finished" );
    xanim = asm::asm_getxanim( statename, animid );
    function_1e26c70280259c3f( statename, xanim );
    
    if ( isai( self ) )
    {
        var_cbe0a3d32726f09e = self function_90f71263a5ae4ecb();
        
        if ( isdefined( var_cbe0a3d32726f09e ) )
        {
            if ( var_cbe0a3d32726f09e isscriptableinstance() )
            {
                function_ded2e1c43ae7caf( statename, var_cbe0a3d32726f09e );
            }
            else
            {
                function_d5fb8f35869be0d6( statename, var_cbe0a3d32726f09e );
            }
        }
        
        self aisetanim( statename, animid );
    }
    else
    {
        bodyanimid = asm::asm_lookupanimfromalias( "knobs", "body" );
        bodyxanim = asm::asm_getxanim( "knobs", bodyanimid );
        self setflaggedanimknoballrestart( statename, xanim, bodyxanim, 1, 0.2, 1 );
        self setanim( bodyxanim, 1, 0.2 );
        
        if ( statename == "relaxed" || statename == "single_loop" || statename == "group_loop" )
        {
            cap_proceduralturn_forward();
        }
        else if ( isarray( params ) && params.size == 2 )
        {
            proceduralturn = params[ 1 ];
            
            if ( proceduralturn )
            {
                childthread cap_proceduralturn();
            }
        }
    }
    
    function_8045e4c15184ed50( statename, xanim );
    cap_propanim( asmname, statename, params );
    asm::asm_playfacialanim( asmname, statename, xanim );
    cap_donotetracks( asmname, statename );
}

// Namespace asm_cap
// Params 3
// Checksum 0xab46516d, Offset: 0x1530
// Size: 0x41
function function_4de072f9061e4554( asmname, statename, params )
{
    cap_playanim( asmname, statename, params );
    
    if ( isdefined( self.node ) )
    {
        self.keepclaimednodeifvalid = 1;
    }
}

// Namespace asm_cap
// Params 3
// Checksum 0xff790d23, Offset: 0x1579
// Size: 0x28
function function_e7eb6dd4c6bee96a( asmname, statename, params )
{
    self.keepclaimednodeifvalid = 0;
}

// Namespace asm_cap
// Params 3
// Checksum 0xcf2bd360, Offset: 0x15a9
// Size: 0xf0
function function_1e26c70280259c3f( statename, xanim, animtime )
{
    if ( isdefined( self.relativestates ) && arraycontains( self.relativestates, statename ) )
    {
        return;
    }
    
    scriptednode = function_5a86a8fec880930b();
    
    if ( !isdefined( scriptednode ) )
    {
        return;
    }
    
    if ( !isdefined( animtime ) )
    {
        animtime = 0;
    }
    
    origin = scriptednode.origin;
    angles = scriptednode.angles ?? ( 0, 0, 0 );
    startorg = getoriginforanimtime( origin, angles, xanim, animtime );
    startangles = getanglesforanimtime( origin, angles, xanim, animtime );
    
    if ( isai( self ) )
    {
        self forceteleport( startorg, startangles, 9999 );
        return;
    }
    
    self.origin = startorg;
    self.angles = startangles;
}

// Namespace asm_cap
// Params 0
// Checksum 0x6a771056, Offset: 0x16a1
// Size: 0x6a
function function_5a86a8fec880930b()
{
    if ( isdefined( self.scriptednodebypass ) )
    {
        return;
    }
    
    var_7237854e3be197ca = self.scriptednode;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = self.animnode;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = self.scripted_animnode;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = self.scripted_anim_node;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace asm_cap
// Params 2
// Checksum 0xd3531135, Offset: 0x1713
// Size: 0xaa
function function_8045e4c15184ed50( statename, xanim )
{
    if ( !isdefined( self.resumestatetime ) || !isdefined( self.resumestatetime[ statename ] ) )
    {
        return;
    }
    
    var_2fa91f90efb30033 = self;
    
    if ( isdefined( self.var_2fa91f90efb30033 ) )
    {
        var_2fa91f90efb30033 = self.var_2fa91f90efb30033;
    }
    
    resumetime = var_2fa91f90efb30033.resumestatetime[ statename ];
    assert( isdefined( resumetime ), "<dev string:x24>" + statename + "<dev string:x4d>" );
    function_1e26c70280259c3f( statename, xanim, resumetime );
    self setanimtime( xanim, resumetime );
    thread function_fe3a3571bf158f81( statename, xanim );
}

// Namespace asm_cap
// Params 2
// Checksum 0xb47fe233, Offset: 0x17c5
// Size: 0x3d
function function_fe3a3571bf158f81( statename, xanim )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        self.resumestatetime[ statename ] = self getanimtime( xanim );
        waitframe();
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x4a68aa5c, Offset: 0x180a
// Size: 0x25f
function cap_proceduralturn()
{
    while ( true )
    {
        player = getclosestplayer( self.origin );
        
        if ( !isdefined( player ) )
        {
            waitframe();
            continue;
        }
        
        target = player;
        
        if ( isalive( self._blackboard.var_8141bfd7b74a80f6 ) )
        {
            enemy = self._blackboard.var_8141bfd7b74a80f6;
        }
        
        totarget = target.origin - self.origin;
        distsqrtotarget = lengthsquared( totarget );
        anglediff = angleclamp180( vectortoyaw( totarget ) - self.angles[ 1 ] );
        var_a73e896d91e2aa7a = [ [ 300, 180 ], [ 0, 10 ] ];
        angletouse = 0;
        
        foreach ( pair in var_a73e896d91e2aa7a )
        {
            distancesqr = pair[ 0 ] * pair[ 0 ];
            
            if ( distsqrtotarget > distancesqr )
            {
                angletouse = pair[ 1 ];
                break;
            }
        }
        
        shouldrotate = abs( anglediff ) > angletouse;
        
        if ( shouldrotate )
        {
            rotationspeed = 25;
            duration = abs( anglediff ) / rotationspeed * 1000;
            remainingframes = int( ceil( duration / level.frameduration ) );
            
            while ( remainingframes > 0 )
            {
                anglediff = angleclamp180( vectortoyaw( target.origin - self.origin ) - self.angles[ 1 ] );
                lerpfraction = 1 / remainingframes;
                remainingyaw = anglediff;
                yaw = angleclamp( self.angles[ 1 ] + remainingyaw * lerpfraction );
                self.angles = ( 0, yaw, 0 );
                remainingframes--;
                waitframe();
            }
        }
        
        waitframe();
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x4832bb4c, Offset: 0x1a71
// Size: 0x241
function cap_proceduralturn_forward()
{
    rotationspeed = 70;
    
    while ( true )
    {
        origin = self.caporigin + anglestoforward( self.capangles ) * 50;
        
        if ( isalive( self._blackboard.var_8141bfd7b74a80f6 ) )
        {
            enemy = self._blackboard.var_8141bfd7b74a80f6;
        }
        
        totarget = origin - self.origin;
        distsqrtotarget = lengthsquared( totarget );
        anglediff = angleclamp180( vectortoyaw( totarget ) - self.angles[ 1 ] );
        var_a73e896d91e2aa7a = [ [ 300, 180 ], [ 0, 10 ] ];
        angletouse = 0;
        
        foreach ( pair in var_a73e896d91e2aa7a )
        {
            distancesqr = pair[ 0 ] * pair[ 0 ];
            
            if ( distsqrtotarget > distancesqr )
            {
                angletouse = pair[ 1 ];
                break;
            }
        }
        
        shouldrotate = abs( anglediff ) > angletouse;
        
        if ( shouldrotate )
        {
            duration = abs( anglediff ) / rotationspeed * 1000;
            remainingframes = int( ceil( duration / level.frameduration ) );
            
            while ( remainingframes > 0 )
            {
                anglediff = angleclamp180( vectortoyaw( origin - self.origin ) - self.angles[ 1 ] );
                lerpfraction = 1 / remainingframes;
                remainingyaw = anglediff;
                yaw = angleclamp( self.angles[ 1 ] + remainingyaw * lerpfraction );
                self.angles = ( 0, yaw, 0 );
                remainingframes--;
                waitframe();
            }
        }
        
        waitframe();
    }
}

// Namespace asm_cap
// Params 2
// Checksum 0x7a672a22, Offset: 0x1cba
// Size: 0x15
function function_c3561644e599fa70( xanim, tracktime )
{
    
}

// Namespace asm_cap
// Params 2
// Checksum 0xd50c33af, Offset: 0x1cd7
// Size: 0x15
function function_aca38f6190adaf8b( xanim, tracktime )
{
    
}

// Namespace asm_cap
// Params 1
// Checksum 0x3f6fa492, Offset: 0x1cf4
// Size: 0xc
function function_7061e465eb4117da( player )
{
    
}

// Namespace asm_cap
// Params 3
// Checksum 0x383363ce, Offset: 0x1d08
// Size: 0xf8
function cap_loopanim( asmname, statename, params )
{
    self endon( statename + "_finished" );
    
    while ( true )
    {
        animid = asm::asm_getanim( asmname, statename );
        xanim = asm::asm_getxanim( statename, animid );
        function_1e26c70280259c3f( statename, xanim );
        
        if ( isai( self ) )
        {
            self aisetanim( statename, animid );
            
            if ( self.var_5d4829c8b859716f )
            {
                self.var_d4da0a58a936a837 = 1;
            }
            
            asm::asm_playfacialanim( asmname, statename, xanim );
        }
        else
        {
            bodyanimid = asm::asm_lookupanimfromalias( "knobs", "body" );
            bodyxanim = asm::asm_getxanim( "knobs", bodyanimid );
            self setflaggedanimknoballrestart( statename, xanim, bodyxanim, 1, 0.2, 1 );
        }
        
        cap_propanim( asmname, statename, params );
        cap_donotetracks( asmname, statename );
    }
}

// Namespace asm_cap
// Params 2
// Checksum 0x88b92245, Offset: 0x1e08
// Size: 0x5c
function cap_donotetracks( asmname, statename )
{
    notehandler = asm::asm_getnotehandler( asmname, statename );
    
    for ( endnote = undefined; !isstring( endnote ) || endnote != "end" ; endnote = asm::asm_donotetracks( asmname, statename, notehandler ) )
    {
    }
    
    return endnote;
}

// Namespace asm_cap
// Params 1
// Checksum 0x2cc5b9d8, Offset: 0x1e6d
// Size: 0x15
function cap_notetrackhandler( notetrack )
{
    notetracks::notetrack_prefix_handler( notetrack );
}

// Namespace asm_cap
// Params 3
// Checksum 0xe912e0de, Offset: 0x1e8b
// Size: 0x90
function cap_chooseanim( asmname, statename, params )
{
    if ( !isdefined( params ) )
    {
        randomalias = cap_lookuprandomalias( statename );
        return cap_lookupanimfromalias( statename, randomalias );
    }
    
    result = undefined;
    prefixstr = asm_bb::bb_getprefixstring( params );
    
    if ( isdefined( prefixstr ) )
    {
        randomalias = cap_lookuprandomalias( statename, prefixstr );
        result = cap_lookupanimfromalias( statename, randomalias );
    }
    else
    {
        result = cap_lookupanimfromalias( statename, params );
    }
    
    return result;
}

// Namespace asm_cap
// Params 2
// Checksum 0x9d60148f, Offset: 0x1f23
// Size: 0x34, Type: bool
function cap_hasalias( statename, alias )
{
    animresult = archetypegetrandomalias( self.animsetname, statename, alias );
    return isdefined( animresult );
}

// Namespace asm_cap
// Params 3
// Checksum 0xb57e29c9, Offset: 0x1f60
// Size: 0x1cb
function cap_chooseanimdistance( asmname, statename, params )
{
    neardistthreshold = 450;
    neardistthresholdsqr = neardistthreshold * neardistthreshold;
    player = getclosestplayer( self.origin );
    
    if ( !isdefined( player ) )
    {
        distancealias = "far";
        
        if ( cap_hasalias( statename, distancealias ) )
        {
            result = cap_lookupanimfromalias( statename, distancealias );
            return result;
        }
        
        randomalias = cap_lookuprandomalias( statename );
        return cap_lookupanimfromalias( statename, randomalias );
    }
    
    distsqr = distancesquared( self.origin, player.origin );
    distancealias = undefined;
    
    if ( distsqr < neardistthresholdsqr )
    {
        contents = trace::create_contents( 1, 0, 0, 0, 0, 0, 0 );
        excludelist = [ player, self ];
        origin = self.origin + ( 0, 0, 30 );
        end = player.origin + ( 0, 0, 30 );
        
        if ( isai( self ) )
        {
            hitresult = physics_charactercast( origin, end, self, 30, self.angles, contents, excludelist, "physicsquery_closest" );
            
            if ( hitresult.size )
            {
                distancealias = "far";
            }
            else
            {
                distancealias = "near";
            }
        }
        else
        {
            distancealias = "near";
        }
    }
    else
    {
        distancealias = "far";
    }
    
    if ( cap_hasalias( statename, distancealias ) )
    {
        result = cap_lookupanimfromalias( statename, distancealias );
        return result;
    }
    
    randomalias = cap_lookuprandomalias( statename );
    return cap_lookupanimfromalias( statename, randomalias );
}

// Namespace asm_cap
// Params 3
// Checksum 0x7befdd73, Offset: 0x2134
// Size: 0x90
function function_da5175524f57289a( asmname, statename, params )
{
    if ( !isdefined( params ) )
    {
        randomalias = cap_lookuprandomalias( statename );
        return function_38d1e30680a5d36f( statename, randomalias );
    }
    
    result = undefined;
    prefixstr = asm_bb::bb_getprefixstring( params );
    
    if ( isdefined( prefixstr ) )
    {
        randomalias = cap_lookuprandomalias( statename, prefixstr );
        result = function_38d1e30680a5d36f( statename, randomalias );
    }
    else
    {
        result = function_38d1e30680a5d36f( statename, params );
    }
    
    return result;
}

// Namespace asm_cap
// Params 2
// Checksum 0xda3436e3, Offset: 0x21cc
// Size: 0x83
function cap_lookupanimfromalias( statename, alias )
{
    arcname = self.animsetname;
    assert( isdefined( arcname ), "<dev string:x71>" );
    animresult = archetypegetrandomalias( arcname, statename, alias );
    assert( isdefined( animresult ), "<dev string:x95>" + alias + "<dev string:xab>" + arcname + "<dev string:xba>" + statename + "<dev string:xc2>" + self.classname );
    return animresult;
}

// Namespace asm_cap
// Params 2
// Checksum 0xe084a370, Offset: 0x2258
// Size: 0xe0
function function_38d1e30680a5d36f( statename, alias )
{
    arcname = self.animsetname;
    
    if ( !isdefined( self.var_f6cf297cd6c37337 ) )
    {
        self.var_f6cf297cd6c37337 = [];
    }
    
    if ( !isdefined( self.var_f6cf297cd6c37337[ statename ] ) )
    {
        self.var_f6cf297cd6c37337[ statename ] = [];
    }
    
    if ( !isdefined( self.var_f6cf297cd6c37337[ statename ][ alias ] ) )
    {
        self.var_f6cf297cd6c37337[ statename ][ alias ] = 0;
    }
    
    animindices = animsetgetallanimindicesforalias( arcname, statename, alias );
    animresult = animindices[ self.var_f6cf297cd6c37337[ statename ][ alias ] ];
    self.var_f6cf297cd6c37337[ statename ][ alias ]++;
    
    if ( self.var_f6cf297cd6c37337[ statename ][ alias ] >= animindices.size )
    {
        self.var_f6cf297cd6c37337[ statename ][ alias ] = 0;
    }
    
    return animresult;
}

// Namespace asm_cap
// Params 3
// Checksum 0x2e7fa29, Offset: 0x2341
// Size: 0x1ae
function cap_lookuprandomalias( statename, optionalprefix, allownone )
{
    archetype = self.animsetname;
    aliases = archetypegetaliases( archetype, statename );
    possible = 0;
    chosen = undefined;
    prefixlen = -1;
    
    if ( isdefined( optionalprefix ) )
    {
        prefixlen = optionalprefix.size;
    }
    
    if ( !isdefined( aliases ) )
    {
        /#
            if ( !allownone )
            {
                msg = "<dev string:xc8>" + statename + "<dev string:xab>" + archetype;
                
                if ( isdefined( optionalprefix ) )
                {
                    msg += "<dev string:xed>" + optionalprefix;
                }
                
                assertmsg( msg );
            }
        #/
        
        return;
    }
    
    foreach ( aliasname in aliases )
    {
        if ( prefixlen < 0 || getsubstr( aliasname, 0, prefixlen ) == optionalprefix )
        {
            possible += 1;
            chance = 1 / possible;
            
            if ( randomfloat( 1 ) <= chance )
            {
                chosen = aliasname;
            }
        }
    }
    
    /#
        if ( !allownone && !isdefined( chosen ) )
        {
            msg = "<dev string:xc8>" + statename + "<dev string:xab>" + archetype;
            
            if ( isdefined( optionalprefix ) )
            {
                msg += "<dev string:xed>" + optionalprefix;
            }
            
            assertmsg( msg );
        }
    #/
    
    return chosen;
}

// Namespace asm_cap
// Params 4
// Checksum 0x81019624, Offset: 0x24f8
// Size: 0x28, Type: bool
function cap_event( asmname, statename, tostatename, params )
{
    return false;
}

// Namespace asm_cap
// Params 4
// Checksum 0xeef0b388, Offset: 0x2529
// Size: 0x28, Type: bool
function cap_time_elapsed( asmname, statename, tostatename, params )
{
    return false;
}

// Namespace asm_cap
// Params 4
// Checksum 0xacf0406e, Offset: 0x255a
// Size: 0x36
function function_5ba84486682aad55( asmname, statename, tostatename, params )
{
    if ( isai( self ) )
    {
        return self codemoverequested();
    }
    
    return 0;
}

// Namespace asm_cap
// Params 3
// Checksum 0x52a91210, Offset: 0x2599
// Size: 0x52
function function_2a155fba2493edcc( asmname, statename, params )
{
    if ( isdefined( params ) )
    {
        assert( !isarray( params ) );
        asm_bb::bb_setcivilianstate( params );
    }
    
    self._blackboard.var_5ee32e89826cf63f = 1;
}

// Namespace asm_cap
// Params 3
// Checksum 0x3eb673c8, Offset: 0x25f3
// Size: 0x19e
function cap_propanim( asmname, statename, params )
{
    if ( !isdefined( self.animprops ) )
    {
        return;
    }
    
    foreach ( prop in self.animprops )
    {
        if ( isdefined( params ) )
        {
            aliasname = params;
        }
        else
        {
            aliasname = undefined;
            aliasnames = archetypegetaliases( prop.animsetname, statename );
            
            if ( isdefined( aliasnames ) )
            {
                aliasname = utility::array_random( aliasnames );
            }
        }
        
        if ( !isdefined( aliasname ) )
        {
            continue;
        }
        
        alias = archetypegetalias( prop.animsetname, statename, aliasname );
        
        if ( !isdefined( alias ) )
        {
            continue;
        }
        
        propxanim = alias.anims;
        
        if ( isarray( propxanim ) )
        {
            propxanim = utility::array_random( propxanim );
        }
        
        scriptednode = function_5a86a8fec880930b();
        assert( isdefined( scriptednode ), "<dev string:xfb>" );
        origin = scriptednode.origin;
        angles = scriptednode.angles ?? ( 0, 0, 0 );
        prop animscripted( aliasname, origin, angles, propxanim );
    }
}

// Namespace asm_cap
// Params 3
// Checksum 0x91056909, Offset: 0x2799
// Size: 0x41
function cap_exit( asmname, statename, params )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    cap::cap_exit();
    
    if ( isstring( params ) )
    {
        asm::asm_setstate( params );
    }
}

// Namespace asm_cap
// Params 3
// Checksum 0x33116daf, Offset: 0x27e2
// Size: 0x48
function cap_playdeathanim( asmname, statename, params )
{
    if ( isdefined( self.fnplaydeathanim ) )
    {
        self [[ self.fnplaydeathanim ]]( asmname, statename, params );
        return;
    }
    
    death::playdeathanimcommon( asmname, statename, params );
}

// Namespace asm_cap
// Params 3
// Checksum 0x9f7badcf, Offset: 0x2832
// Size: 0x31
function cap_exit_long_death_death( asmname, statename, params )
{
    cap::cap_exit();
    asm::asm_setstate( "long_death_death" );
}

// Namespace asm_cap
// Params 3
// Checksum 0x3675dd57, Offset: 0x286b
// Size: 0x31
function cap_exit_death( asmname, statename, params )
{
    cap::cap_exit();
    asm::asm_setstate( "death_generic" );
}

// Namespace asm_cap
// Params 3
// Checksum 0xde8df68, Offset: 0x28a4
// Size: 0x54
function cap_playpainanim( asmname, statename, params )
{
    if ( isdefined( self.fnplaypainanim ) )
    {
        self [[ self.fnplaypainanim ]]( asmname, statename, params );
        return;
    }
    
    asm::asm_playanimstate( asmname, statename, params );
    self notify( #"killanimscript" );
}

// Namespace asm_cap
// Params 3
// Checksum 0xe95e4a0e, Offset: 0x2900
// Size: 0x52
function cap_exit_pain( asmname, statename, params )
{
    cap::cap_exit();
    
    if ( self.currentpose == "crouch" )
    {
        asm::asm_setstate( "pain_crouch" );
        return;
    }
    
    asm::asm_setstate( "pain_stand" );
}

// Namespace asm_cap
// Params 3
// Checksum 0x5359881e, Offset: 0x295a
// Size: 0x31
function function_bab17bc4cac0e3b2( asmname, statename, params )
{
    cap::cap_exit();
    asm::asm_setstate( "special_pain_in" );
}

// Namespace asm_cap
// Params 3
// Checksum 0x7b1da77b, Offset: 0x2993
// Size: 0x67
function cap_exit_long_death_skip_intro( asmname, statename, params )
{
    cap::cap_exit();
    cache = self.forcelongdeathskipintroanim;
    self.forcelongdeathskipintroanim = 1;
    self.skipdyingbackcrawl = 1;
    asm::asm_setstate( "choose_long_death" );
    self.forcelongdeathskipintroanim = cache;
}

// Namespace asm_cap
// Params 3
// Checksum 0x2f2138d6, Offset: 0x2a02
// Size: 0x1e
function cap_donothing( asmname, statename, params )
{
    
}

// Namespace asm_cap
// Params 4
// Checksum 0x4177bd2c, Offset: 0x2a28
// Size: 0x35
function cap_init( asmname, fromstate, tostate, params )
{
    self.attitude = "relaxed";
}

// Namespace asm_cap
// Params 4
// Checksum 0x5b2f065b, Offset: 0x2a65
// Size: 0x49, Type: bool
function cap_attitude( asmname, fromstate, tostate, params )
{
    assert( isdefined( params ) && !isarray( params ) );
    return self.attitude == params;
}

// Namespace asm_cap
// Params 4
// Checksum 0x9087ffee, Offset: 0x2ab7
// Size: 0x36, Type: bool
function cap_shouldreact( asmname, statename, tostatename, params )
{
    return self.attitude != "relaxed";
}

// Namespace asm_cap
// Params 4
// Checksum 0xdec72df7, Offset: 0x2af6
// Size: 0x55
function cap_shouldreactlow( asmname, statename, tostatename, params )
{
    switch ( self.attitude )
    {
        case #"hash_2be091d2ce1d5a7d":
            return 1;
        default:
            return 0;
    }
}

// Namespace asm_cap
// Params 4
// Checksum 0x4bfc89d, Offset: 0x2b53
// Size: 0x61
function cap_shouldreactmed( asmname, statename, tostatename, params )
{
    switch ( self.attitude )
    {
        case #"hash_dd76edf4ebd198bd":
        case #"hash_f140fd4db5ed4df1":
            return 1;
        default:
            return 0;
    }
}

// Namespace asm_cap
// Params 4
// Checksum 0xf673b5f3, Offset: 0x2bbc
// Size: 0x61
function cap_shouldreacthigh( asmname, statename, tostatename, params )
{
    switch ( self.attitude )
    {
        case #"hash_6da61cb2c6d68687":
        case #"hash_ea9150ecc8538d74":
            return 1;
        default:
            return 0;
    }
}

// Namespace asm_cap
// Params 4
// Checksum 0xe3307b68, Offset: 0x2c25
// Size: 0x4d
function cap_isflagset( asmname, statename, tostatename, params )
{
    assert( isdefined( params ), "<dev string:x136>" );
    
    if ( !utility::flag_exist( params ) )
    {
        return 0;
    }
    
    return utility::flag( params );
}

// Namespace asm_cap
// Params 4
// Checksum 0x90367b6b, Offset: 0x2c7b
// Size: 0xce, Type: bool
function function_2a76e1ce63b18f19( asmname, statename, tostatename, params )
{
    assert( isnumber( params ), "<dev string:x177>" );
    
    foreach ( player in level.players )
    {
        if ( distancesquared( self.origin, player.origin ) <= params * params )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace asm_cap
// Params 4
// Checksum 0xc81c213c, Offset: 0x2d52
// Size: 0x31
function function_bb499c66c154c1db( asmname, statename, tostatename, params )
{
    return function_48706802989070b5( params, 1 );
}

// Namespace asm_cap
// Params 4
// Checksum 0x48a46ebf, Offset: 0x2d8c
// Size: 0x30
function function_cf4877ea05753e49( asmname, statename, tostatename, params )
{
    return function_48706802989070b5( params, 0 );
}

// Namespace asm_cap
// Params 2, eflags: 0x4
// Checksum 0x515554af, Offset: 0x2dc5
// Size: 0x123, Type: bool
function private function_48706802989070b5( params, dosighttrace )
{
    if ( isai( self ) )
    {
        lookatorigin = self geteye();
    }
    else
    {
        lookatorigin = self.origin;
    }
    
    if ( isdefined( params ) )
    {
        if ( abs( params ) > 1 )
        {
            fov = cos( params );
        }
        else
        {
            fov = params;
        }
    }
    else
    {
        fov = 0.77;
    }
    
    foreach ( player in level.players )
    {
        playerorigin = player geteye();
        playerangles = player getgunangles();
        
        if ( utility::within_fov( playerorigin, playerangles, lookatorigin, fov ) )
        {
            if ( !dosighttrace || sighttracepassed( playerorigin, lookatorigin, 0, self ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace asm_cap
// Params 4
// Checksum 0x6d7392ec, Offset: 0x2ef1
// Size: 0x43
function cap_isidling( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.stealth ) )
    {
        return 0;
    }
    
    return self [[ self.fnisinstealthidle ]]();
}

// Namespace asm_cap
// Params 4
// Checksum 0xcdc4d320, Offset: 0x2f3d
// Size: 0x43
function cap_isinvestigating( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.stealth ) )
    {
        return 0;
    }
    
    return self [[ self.fnisinstealthinvestigate ]]();
}

// Namespace asm_cap
// Params 4
// Checksum 0xdcb1501e, Offset: 0x2f89
// Size: 0x43
function cap_ishunting( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.stealth ) )
    {
        return 0;
    }
    
    return self [[ self.fnisinstealthhunt ]]();
}

// Namespace asm_cap
// Params 4
// Checksum 0x6a6b1649, Offset: 0x2fd5
// Size: 0x44
function cap_iscombating( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.stealth ) )
    {
        return 1;
    }
    
    return self [[ self.fnisinstealthcombat ]]();
}

// Namespace asm_cap
// Params 4
// Checksum 0xdb00ccba, Offset: 0x3022
// Size: 0x44, Type: bool
function function_632eebf5e5bce8ea( asmname, statename, tostatename, params )
{
    assert( isdefined( params ), "<dev string:x1c4>" );
    return self findoverridearchetype( "default" ) == params;
}

// Namespace asm_cap
// Params 2
// Checksum 0xcdc798a0, Offset: 0x306f
// Size: 0x21
function function_b79833801d9577e6( note, params )
{
    capnotehandler( note, params, 1 );
}

// Namespace asm_cap
// Params 3
// Checksum 0xc8a5f778, Offset: 0x3098
// Size: 0x2de
function capnotehandler( note, params, ispain )
{
    statename = self asmgetcurrentstate( self.asmname );
    interactionscriptmodel = self function_90f71263a5ae4ecb();
    
    if ( isdefined( interactionscriptmodel ) )
    {
        notehandler_interactionscriptmodel( note, statename, interactionscriptmodel );
    }
    else if ( isstartstr( note, "cigarette" ) )
    {
        note = getsubstr( note, 10 );
        notehandler_smoking( note, statename );
    }
    else if ( isstartstr( note, "pack" ) )
    {
        note = getsubstr( note, 5 );
        notehandler_cigarettepack( note, statename );
    }
    else if ( isstartstr( note, "phone" ) )
    {
        note = getsubstr( note, 6 );
        notehandler_cellphone( note, statename );
    }
    else if ( isstartstr( note, "bottle" ) )
    {
        note = getsubstr( note, 7 );
        notehandler_drinking( note, statename );
    }
    else if ( isstartstr( note, "flashlight" ) )
    {
        note = getsubstr( note, 7 );
        notehandler_flashlight( note, statename );
    }
    else if ( isstartstr( note, "bread" ) )
    {
        note = getsubstr( note, 6 );
        notehandler_bread( note, statename );
    }
    else if ( isstartstr( note, "chips" ) )
    {
        note = getsubstr( note, 6 );
        notehandler_chips( note, statename );
    }
    else if ( isstartstr( note, "pistol" ) )
    {
        note = getsubstr( note, 7 );
        notehandler_pistol( note, statename );
    }
    else if ( isstartstr( note, "laptop" ) )
    {
        note = getsubstr( note, 7 );
        notehandler_laptop( note, statename );
    }
    else if ( isstartstr( note, "tablet" ) )
    {
        note = getsubstr( note, 7 );
        notehandler_tablet( note, statename );
    }
    else if ( isstartstr( note, "radio" ) )
    {
        note = getsubstr( note, 6 );
        notehandler_radio( note, statename );
    }
    else if ( isstartstr( note, "chair" ) )
    {
        note = getsubstr( note, 6 );
        notehandler_chair( note, statename );
    }
    else if ( isstartstr( note, "crowbar" ) )
    {
        note = getsubstr( note, 8 );
        notehandler_crowbar( note, statename );
    }
    else if ( isstartstr( note, "champaign_glass" ) )
    {
        note = getsubstr( note, 17 );
        notehandler_champaignglass( note, statename );
    }
    else if ( isstartstr( note, "napkin" ) )
    {
        note = getsubstr( note, 8 );
        notehandler_napkin( note, statename );
    }
    else if ( isstartstr( note, "liquor_glass" ) )
    {
        note = getsubstr( note, 14 );
        notehandler_liquorglass( note, statename );
    }
    else if ( isstartstr( note, "liquor_bottle" ) )
    {
        note = getsubstr( note, 15 );
        notehandler_liquorbottle( note, statename );
    }
    else
    {
        function_16430184dcaacf09( note, statename, ispain );
    }
    
    /#
    #/
}

// Namespace asm_cap
// Params 3
// Checksum 0x9195984a, Offset: 0x337e
// Size: 0x2c5
function function_16430184dcaacf09( note, statename, ispain )
{
    switch ( self.animsetname )
    {
        case #"hash_149d7c5dce32a188":
        case #"hash_62169a0a62911cd5":
        case #"hash_3e182810143fa64f":
        case #"hash_3fc615e3b8e00c85":
        case #"hash_9c81a4e8a2a4ae57":
        case #"hash_a2eb0bfd79516586":
        case #"hash_a3973ce6c3af982e":
        case #"hash_af29d76908144a0e":
        case #"hash_bdbb1945f35ec8ad":
        case #"hash_d993fbbf069153c0":
        case #"hash_dc358932f675ac5a":
        case #"hash_dcd5de9c5dea1236":
            notehandler_cellphone( note, statename );
            break;
        case #"hash_4a444d172c0638fb":
        case #"hash_8e86ee0917b95e24":
        case #"hash_557b96037dfe66e":
        case #"hash_cf3adaaba425a2b":
        case #"hash_cf3aeaaba425bbe":
        case #"hash_11badab054262604":
        case #"hash_11baddb054262abd":
        case #"hash_16a5f4580f4c6e72":
        case #"hash_4a691b7eac4fb2fa":
        case #"hash_8332961b364efcc6":
        case #"hash_5cf06ead8786602c":
        case #"hash_c1e77a98a3d9a4dc":
        case #"hash_d94c489057313d8c":
            notehandler_smoking( note, statename );
            break;
        case #"hash_1ced745e581f8103":
        case #"hash_e1d4951296d73551":
            notehandler_drinking( note, statename, ispain );
            break;
        case #"hash_47e0df940655e2f8":
            notehandler_flashlight( note, statename );
            break;
        case #"hash_6709cc400063908a":
            notehandler_pistol( note, statename );
            break;
        case #"hash_caf759f5b518d89e":
            notehandler_laptop( note, statename );
            break;
        case #"hash_5417fe714f655ae6":
            function_39586589ede59a57( note, statename );
            break;
        case #"hash_5342668e989a445f":
            notehandler_sleeping( note, statename );
            break;
        case #"hash_1efe403428779c54":
            notehandler_bag( note, statename );
            break;
        case #"hash_1b5e50102560a11":
        case #"hash_1b5e20102560558":
        case #"hash_f7cf21fc914907ae":
            notehandler_champaignglass( note, statename );
            break;
        case #"hash_1d7ee866faec76ce":
            notehandler_napkin( note, statename );
            break;
        case #"hash_d695ea87f7b5d558":
        case #"hash_2cd0497d5e3735f5":
            notehandler_liquorglass( note, statename );
            break;
        case #"hash_651b054cece48d2a":
        case #"hash_529008aec6f053e5":
            notehandler_liquorbottle( note, statename );
            break;
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x8e291131, Offset: 0x364b
// Size: 0xce
function function_64053b572b4d36b0()
{
    self endon( #"death" );
    ai = self getlinkedparent();
    
    while ( isdefined( self ) && self islinked() && !ai.in_melee && !ai.in_melee_death && isalive( ai ) )
    {
        waitframe();
    }
    
    if ( isdefined( ai ) )
    {
        if ( isdefined( ai.idle_fx ) )
        {
            stopfxontag( ai.idle_fx, ai, "tag_accessory_right" );
            stopfxontag( ai.idle_fx, ai, "tag_accessory_left" );
            ai.idle_fx = undefined;
        }
        
        if ( !level.var_c294a30622f899b5 )
        {
            ai launchprop( self );
            thread prop_delete();
            return;
        }
    }
    
    self delete();
}

// Namespace asm_cap
// Params 1
// Checksum 0x27316906, Offset: 0x3721
// Size: 0x4f
function gethandtag( note )
{
    handtag = "tag_accessory_right";
    hand = getsubstr( note, 7 );
    
    if ( hand == "left" || hand == "l" )
    {
        handtag = "tag_accessory_left";
    }
    
    return handtag;
}

// Namespace asm_cap
// Params 2
// Checksum 0x83b8419b, Offset: 0x3779
// Size: 0x39
function function_d5fb8f35869be0d6( asmstate, interactionscriptmodel )
{
    animsname = interactionscriptmodel function_1467eb5cc4102bf4( asmstate );
    
    if ( isdefined( animsname ) )
    {
        interactionscriptmodel thread animation::anim_single_solo( interactionscriptmodel, animsname );
    }
}

// Namespace asm_cap
// Params 2
// Checksum 0xd17c78e4, Offset: 0x37ba
// Size: 0x2a
function function_ded2e1c43ae7caf( asmstate, interactionscriptmodel )
{
    interactionscriptmodel setscriptablepartstate( interactionscriptmodel.partname, asmstate, 0 );
}

// Namespace asm_cap
// Params 3
// Checksum 0x446500a1, Offset: 0x37ec
// Size: 0x97
function notehandler_interactionscriptmodel( note, statename, interactionscriptmodel )
{
    switch ( note )
    {
        case #"hash_6fb23e39e833ccc9":
            bonename = interactionscriptmodel function_599699f695591103();
            
            if ( isdefined( bonename ) )
            {
                interactionscriptmodel linkto( self, bonename, ( 0, 0, 0 ), ( 0, 0, 0 ) );
            }
            
            break;
        case #"hash_92bcabbf88850fb2":
            bonename = interactionscriptmodel function_599699f695591103();
            
            if ( isdefined( bonename ) )
            {
                interactionscriptmodel unlink();
            }
            
            break;
    }
}

// Namespace asm_cap
// Params 2
// Checksum 0xd73006c, Offset: 0x388c
// Size: 0xad
function notehandler_cellphone( note, statename )
{
    self endon( statename + "_finished" );
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( idle_getcellphone(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x3977b2dc, Offset: 0x3941
// Size: 0x39
function idle_getcellphone()
{
    modelname = "offhand_wm_smartphone_on";
    
    if ( isdefined( level.scr_model[ "idle_cellphone" ] ) )
    {
        modelname = level.scr_model[ "idle_cellphone" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 2
// Checksum 0xca44aecd, Offset: 0x3983
// Size: 0xad
function notehandler_tablet( note, statename )
{
    self endon( statename + "_finished" );
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( function_90db32130bc71deb(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x49f84262, Offset: 0x3a38
// Size: 0x39
function function_90db32130bc71deb()
{
    modelname = "offhand2h_wm_tablet_v0";
    
    if ( isdefined( level.scr_model[ "idle_tablet" ] ) )
    {
        modelname = level.scr_model[ "idle_tablet" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 2
// Checksum 0x92c51a91, Offset: 0x3a7a
// Size: 0xad
function notehandler_radio( note, statename )
{
    self endon( statename + "_finished" );
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( function_64d13ca3f8c792be(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x6a6acb89, Offset: 0x3b2f
// Size: 0x39
function function_64d13ca3f8c792be()
{
    modelname = "electronics_walkie_talkie_01";
    
    if ( isdefined( level.scr_model[ "idle_radio" ] ) )
    {
        modelname = level.scr_model[ "idle_radio" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 2
// Checksum 0xbe3ce75a, Offset: 0x3b71
// Size: 0x9e
function notehandler_bread( note, statename )
{
    self endon( statename + "_finished" );
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        self.idle_prop = animation::anim_link_tag_model( "food_bread_slice", handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 2
// Checksum 0x7bf0f611, Offset: 0x3c17
// Size: 0x9e
function notehandler_chips( note, statename )
{
    self endon( statename + "_finished" );
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        self.idle_prop = animation::anim_link_tag_model( "food_trash_bag_chips_01", handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 2
// Checksum 0xa0ea2bb3, Offset: 0x3cbd
// Size: 0x1e6
function notehandler_smoking( note, statename )
{
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( function_68e721497784be41(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        self.idle_fx = level.g_effect[ "cigarette_unlit" ];
        playfxontag( self.idle_fx, self, handtag );
        self.idle_prop.handtag = handtag;
        return;
    }
    
    if ( isstartstr( note, "light" ) )
    {
        if ( isdefined( self.idle_prop.handtag ) )
        {
            handtag = self.idle_prop.handtag;
        }
        
        self.idle_fx = level.g_effect[ "cigarette_lit" ];
        playfxontag( self.idle_fx, self, handtag );
        stopfxontag( level.g_effect[ "cigarette_unlit" ], self, handtag );
        playfx( level.g_effect[ "lighter_glow" ], self gettagorigin( handtag ) );
        thread smoking_blowsmoke( statename );
        return;
    }
    
    if ( isstartstr( note, "detach" ) || isstartstr( note, "toss" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
        
        stopfxontag( level.g_effect[ "cigarette_lit" ], self, handtag );
        self.idle_fx = undefined;
        
        if ( isstartstr( note, "toss" ) )
        {
            playfx( level.g_effect[ "cigarette_lit_toss" ], self gettagorigin( handtag ), anglestoforward( self gettagangles( handtag ) ) );
        }
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x1909f561, Offset: 0x3eab
// Size: 0x39
function function_68e721497784be41()
{
    modelname = "misc_cigarette_01_centered";
    
    if ( isdefined( level.scr_model[ "idle_cigarette" ] ) )
    {
        modelname = level.scr_model[ "idle_cigarette" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 1
// Checksum 0x264acaa1, Offset: 0x3eed
// Size: 0x9e
function smoking_blowsmoke( statename )
{
    self endon( #"smoking_end" );
    self endon( #"death" );
    
    while ( true )
    {
        self.smoke_fx_ent = playfxontag( level.g_effect[ "cigarette_smoke" ], self, "tag_eye" );
        thread utility::playsoundontag( "fly_t10_ai_smoking_exhale_01", "j_head", undefined, undefined, undefined );
        waittime = randomintrange( 5, 8 );
        wait waittime;
        
        if ( isdefined( self.smoke_fx_ent ) )
        {
            self.smoke_fx_ent delete();
            self.smoke_fx_ent = undefined;
        }
    }
}

// Namespace asm_cap
// Params 3
// Checksum 0x1e267fc0, Offset: 0x3f93
// Size: 0x99
function smoking_cleanup( asmname, statename, params )
{
    self notify( #"smoking_end" );
    
    if ( isdefined( self.idle_fx ) )
    {
        stopfxontag( self.idle_fx, self, "tag_accessory_right" );
        stopfxontag( self.idle_fx, self, "tag_accessory_left" );
        self.idle_fx = undefined;
    }
    
    if ( isdefined( self.smoke_fx_ent ) )
    {
        self.smoke_fx_ent delete();
        self.smoke_fx_ent = undefined;
    }
    
    idle_cleanup( asmname, statename, params );
}

// Namespace asm_cap
// Params 2
// Checksum 0x10efbc18, Offset: 0x4034
// Size: 0xbe
function notehandler_cigarettepack( note, statename )
{
    action = getsubstr( note, 0, 6 );
    handtag = gethandtag( note );
    
    switch ( action )
    {
        case #"hash_2d1403e602f082a4":
            if ( isdefined( self.idle_prop_pack ) )
            {
                return;
            }
            
            self.idle_prop_pack = animation::anim_link_tag_model( function_74fcbb8a6075305c(), handtag );
            self.idle_prop_pack thread function_64053b572b4d36b0();
            break;
        case #"hash_682ec8b49fe7aa12":
            if ( isdefined( self.idle_prop_pack ) )
            {
                self.idle_prop_pack delete();
                self.idle_prop_pack = undefined;
            }
            
            break;
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0xadbc1371, Offset: 0x40fa
// Size: 0x39
function function_74fcbb8a6075305c()
{
    modelname = "misc_cigarette_pack_01";
    
    if ( isdefined( level.scr_model[ "idle_cigarettepack" ] ) )
    {
        modelname = level.scr_model[ "idle_cigarettepack" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 2
// Checksum 0xd9dae548, Offset: 0x413c
// Size: 0xae
function notehandler_flashlight( note, statename )
{
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( idle_focusflashlight(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        self notify( #"enable_flashlight_fx" );
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x57f5febd, Offset: 0x41f2
// Size: 0x39
function idle_focusflashlight()
{
    modelname = "c_t10_gear_flashlight_map_reading_anim";
    
    if ( isdefined( level.scr_model[ "idle_focus_flashlight" ] ) )
    {
        modelname = level.scr_model[ "idle_focus_flashlight" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 3
// Checksum 0x1d8d431d, Offset: 0x4234
// Size: 0xcb
function notehandler_drinking( note, statename, ispain )
{
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( function_481ffce7fc751da7(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            if ( ispain )
            {
                self.idle_prop unlink();
                self.idle_prop = undefined;
                return;
            }
            
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0xbef6c07c, Offset: 0x4307
// Size: 0x39
function function_481ffce7fc751da7()
{
    modelname = "p7_bottle_plastic_16oz_water";
    
    if ( isdefined( level.scr_model[ "idle_bottle" ] ) )
    {
        modelname = level.scr_model[ "idle_bottle" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 2
// Checksum 0xcc5bea4e, Offset: 0x4349
// Size: 0xa2
function notehandler_champaignglass( note, statename )
{
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( function_cb51f142bcc3cc33(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x833ba05b, Offset: 0x43f3
// Size: 0x39
function function_cb51f142bcc3cc33()
{
    modelname = "t10_tableware_glass_flute_champagne_01_filled_b";
    
    if ( isdefined( level.scr_model[ "idle_champaignglass" ] ) )
    {
        modelname = level.scr_model[ "idle_champaignglass" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 2
// Checksum 0x7603ca91, Offset: 0x4435
// Size: 0xa2
function notehandler_napkin( note, statename )
{
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( function_ea9ad62f6ce64d64(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x7f4362f0, Offset: 0x44df
// Size: 0x39
function function_ea9ad62f6ce64d64()
{
    modelname = "t10_tableware_napkin_cloth_folded_03_dest_02";
    
    if ( isdefined( level.scr_model[ "idle_napkin" ] ) )
    {
        modelname = level.scr_model[ "idle_napkin" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 2
// Checksum 0x893780c2, Offset: 0x4521
// Size: 0xa2
function notehandler_liquorglass( note, statename )
{
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( function_9d4e3bcc6bc5bb09(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x55c446ca, Offset: 0x45cb
// Size: 0x39
function function_9d4e3bcc6bc5bb09()
{
    modelname = "t10_tableware_glass_tumbler_sml_01";
    
    if ( isdefined( level.scr_model[ "idle_liquorglass" ] ) )
    {
        modelname = level.scr_model[ "idle_liquorglass" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 2
// Checksum 0xe61b62fe, Offset: 0x460d
// Size: 0xa2
function notehandler_liquorbottle( note, statename )
{
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( function_c54fa8e54d72cecf(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x3cecd6f7, Offset: 0x46b7
// Size: 0x39
function function_c54fa8e54d72cecf()
{
    modelname = "t10_food_bottle_glass_liquor_08";
    
    if ( isdefined( level.scr_model[ "idle_liquorbottle" ] ) )
    {
        modelname = level.scr_model[ "idle_liquorbottle" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 2
// Checksum 0x148656fa, Offset: 0x46f9
// Size: 0xa2
function notehandler_crowbar( note, statename )
{
    handtag = gethandtag( note );
    
    if ( isstartstr( note, "attach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( function_afd17c253068e399(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isstartstr( note, "detach" ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            self.idle_prop delete();
            self.idle_prop = undefined;
        }
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x3245c4cb, Offset: 0x47a3
// Size: 0x39
function function_afd17c253068e399()
{
    modelname = "parts_jup_misc_crowbar";
    
    if ( isdefined( level.scr_model[ "idle_crowbar" ] ) )
    {
        modelname = level.scr_model[ "idle_crowbar" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 2
// Checksum 0xdb432b36, Offset: 0x47e5
// Size: 0x1e
function notehandler_sleeping( note, statename )
{
    if ( isdefined( self getinteractionid() ) )
    {
    }
}

// Namespace asm_cap
// Params 2
// Checksum 0x39197e53, Offset: 0x480b
// Size: 0x140
function notehandler_pistol( note, statename )
{
    handtag = "tag_accessory_right";
    gun = "weapon_wm_pi_mike1911_phys";
    
    if ( isdefined( self getinteractionid() ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        if ( !isdefined( self.idle_table ) )
        {
            tableoffset = anglestoforward( self.angles ) * 18 + ( 0, 0, -2 );
            self.idle_table = utility::spawn_model( idle_gettable(), self.origin + tableoffset, self.angles );
        }
        
        origin = self.origin + ( 0, 0, 34 ) + anglestoforward( self.angles ) * 10 + anglestoright( self.angles ) * -8;
        self.idle_prop = utility::spawn_model( gun, origin, self.angles + ( 0, 90, 90 ) );
        return;
    }
    
    if ( isdefined( self.idle_prop ) )
    {
        self.idle_prop delete();
        self.idle_prop = undefined;
    }
}

// Namespace asm_cap
// Params 2
// Checksum 0x25f6fb73, Offset: 0x4953
// Size: 0x80
function notehandler_table( note, statename )
{
    if ( isdefined( self getinteractionid() ) )
    {
        if ( !isdefined( self.idle_table ) )
        {
            tableoffset = anglestoforward( self.angles ) * 18 + ( 0, 0, -2 );
            self.idle_table = utility::spawn_model( idle_gettable(), self.origin + tableoffset, self.angles );
        }
    }
}

// Namespace asm_cap
// Params 2
// Checksum 0xde0b0348, Offset: 0x49db
// Size: 0xef
function notehandler_laptop( note, statename )
{
    handtag = "tag_accessory_right";
    
    if ( isdefined( self getinteractionid() ) )
    {
        if ( !isdefined( self.idle_table ) )
        {
            tableoffset = anglestoforward( self.angles ) * 22 + ( 0, 0, -2 );
            self.idle_table = utility::spawn_model( idle_gettable(), self.origin + tableoffset, self.angles );
        }
        
        if ( isdefined( self.idle_laptop ) )
        {
            return;
        }
        
        laptopoffset = anglestoforward( self.angles ) * 30 + ( 0, 0, 31 );
        self.idle_laptop = utility::spawn_model( function_730007b0ea5c9207(), self.origin + laptopoffset, self.angles );
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0xfad7da2c, Offset: 0x4ad2
// Size: 0x39
function function_730007b0ea5c9207()
{
    modelname = "misc_wm_blackbox_laptop";
    
    if ( isdefined( level.scr_model[ "idle_laptop" ] ) )
    {
        modelname = level.scr_model[ "idle_laptop" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 2
// Checksum 0x9e21ae73, Offset: 0x4b14
// Size: 0x8c
function function_39586589ede59a57( note, statename )
{
    handtag = "tag_accessory_right";
    
    if ( isdefined( self getinteractionid() ) )
    {
        if ( isdefined( self.idle_prop ) )
        {
            return;
        }
        
        self.idle_prop = animation::anim_link_tag_model( idle_getcellphone(), handtag );
        self.idle_prop thread function_64053b572b4d36b0();
        return;
    }
    
    if ( isdefined( self.idle_prop ) )
    {
        self.idle_prop delete();
        self.idle_prop = undefined;
    }
}

// Namespace asm_cap
// Params 2
// Checksum 0xd34596e3, Offset: 0x4ba8
// Size: 0x1eb
function notehandler_bag( note, statename )
{
    modelname = "container_fertilizer_bag_01_open";
    offset = ( 0, 0, -13 );
    
    if ( isdefined( self getinteractionid() ) )
    {
        if ( !isdefined( self.idle_bag ) )
        {
            propanim = level.scr_anim[ "idle_bag" ][ "wait" ];
            self.idle_bag = utility::spawn_model( modelname, self._blackboard.var_8690cdaf3fef6fec, self._blackboard.var_54bc96b8017ea2ee );
            self.idle_bag useanimtree( level.scr_animtree[ "idle_bag" ] );
            self.idle_bag animrelative( "wait", self._blackboard.var_8690cdaf3fef6fec + offset, self._blackboard.var_54bc96b8017ea2ee, propanim );
            self.idle_bag.key = "wait";
            thread function_f47ce971e1c78885();
        }
    }
    
    if ( !isdefined( self.idle_bag ) )
    {
        return;
    }
    
    if ( statename == "group_loop" && !self.idle_bag.isidle )
    {
        self.idle_bag.key = "idle";
        self.idle_bag.isidle = 1;
        propanim = level.scr_anim[ "idle_bag" ][ "idle" ];
        self.idle_bag animrelative( "idle", self._blackboard.var_8690cdaf3fef6fec + offset, self._blackboard.var_54bc96b8017ea2ee, propanim );
        self.idle_bag thread function_f159bd9d9fb8b581();
    }
}

// Namespace asm_cap
// Params 0
// Checksum 0x1fb65582, Offset: 0x4d9b
// Size: 0x3d
function function_f159bd9d9fb8b581()
{
    self endon( #"death" );
    self notify( #"prop_singleton" );
    self endon( #"prop_singleton" );
    self waittill( #"idle" );
    self.isidle = 0;
}

// Namespace asm_cap
// Params 0
// Checksum 0xf18b2e13, Offset: 0x4de0
// Size: 0x47
function function_f47ce971e1c78885()
{
    self endon( #"death" );
    self.idle_bag endon( #"death" );
    
    while ( isdefined( self getinteractionid() ) )
    {
        waitframe();
    }
    
    self.idle_bag delete();
    self.idle_bag = undefined;
}

// Namespace asm_cap
// Params 2
// Checksum 0x8c04622a, Offset: 0x4e2f
// Size: 0x15
function notehandler_chair( note, statename )
{
    
}

// Namespace asm_cap
// Params 0
// Checksum 0x5d2bf101, Offset: 0x4e4c
// Size: 0x79
function spawnchair()
{
    modelname = "cp_disco_folding_chair_lod0";
    
    if ( isdefined( level.scr_model[ "idle_chair" ] ) )
    {
        modelname = level.scr_model[ "idle_chair" ];
    }
    
    if ( !isdefined( self.idle_chair ) )
    {
        self.idle_chair = utility::spawn_model( modelname, self.origin + anglestoforward( self.angles ) * -8, self.angles );
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 0
// Checksum 0xd25178ff, Offset: 0x4ece
// Size: 0x39
function idle_gettable()
{
    modelname = "furniture_kitchen_end_table_01";
    
    if ( isdefined( level.scr_model[ "idle_table" ] ) )
    {
        modelname = level.scr_model[ "idle_table" ];
    }
    
    return modelname;
}

// Namespace asm_cap
// Params 3
// Checksum 0xeeeafb92, Offset: 0x4f10
// Size: 0x34
function cappropcleanup( asmname, statename, params )
{
    smoking_cleanup( asmname, statename, params );
    prop_drop( asmname, statename, params );
}

// Namespace asm_cap
// Params 3
// Checksum 0x77bf71ca, Offset: 0x4f4c
// Size: 0x106
function prop_drop( asmname, statename, params )
{
    props = [];
    
    if ( isdefined( self.idle_prop ) )
    {
        props[ props.size ] = self.idle_prop;
    }
    
    if ( isdefined( self.idle_prop_pack ) )
    {
        props[ props.size ] = self.idle_prop_pack;
    }
    
    if ( isdefined( self.idle_fx ) )
    {
        smoking_cleanup();
    }
    
    if ( props.size == 0 )
    {
        return;
    }
    
    foreach ( prop in props )
    {
        if ( !level.var_c294a30622f899b5 )
        {
            launchprop( prop );
        }
        
        prop thread prop_delete();
    }
}

// Namespace asm_cap
// Params 1
// Checksum 0x3c780a2d, Offset: 0x505a
// Size: 0xae
function launchprop( prop )
{
    if ( !isent( prop ) || !isdefined( prop.model ) || prop.model == "" )
    {
        return;
    }
    
    launchforce = anglestoforward( self.angles );
    launchforce *= randomfloatrange( 10, 20 );
    forcex = launchforce[ 0 ];
    forcey = launchforce[ 1 ];
    forcez = randomfloatrange( 1, 10 );
    prop unlink();
    prop physicslaunchserver( prop.origin, ( forcex, forcey, forcez ) );
}

// Namespace asm_cap
// Params 0
// Checksum 0x8d65ce0, Offset: 0x5110
// Size: 0x93
function prop_delete()
{
    interval = 10000;
    starttime = gettime();
    endtime = starttime + interval;
    
    if ( utility::issp() )
    {
        wait 1;
        
        while ( isdefined( self ) && isalive( level.player ) && gettime() < endtime && distance2dsquared( level.player.origin, self.origin ) < 16384 )
        {
            wait 1;
        }
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace asm_cap
// Params 3
// Checksum 0x8c3eda1f, Offset: 0x51ab
// Size: 0x63
function idle_cleanup( asmname, statename, params )
{
    self.newenemyreactiondistsq = 262144;
    self function_49d3154c50a04d58();
    
    if ( isdefined( self.idle_prop ) )
    {
        self.idle_prop delete();
        self.idle_prop = undefined;
    }
    
    self notify( #"patrol_idle_complete" );
}

// Namespace asm_cap
// Params 3
// Checksum 0x91ed3f0e, Offset: 0x5216
// Size: 0x5a, Type: bool
function function_b07023605221e73c( asmname, statename, params )
{
    statename = "death_custom";
    alias = "death_custom_anim";
    animresult = archetypegetrandomalias( self.animsetname, statename, alias );
    
    if ( isdefined( animresult ) )
    {
        return true;
    }
    
    return false;
}

// Namespace asm_cap
// Params 3
// Checksum 0x9ee5ab54, Offset: 0x5279
// Size: 0x24, Type: bool
function ininteraction( asmname, statename, params )
{
    return isdefined( self getinteractionid() );
}

// Namespace asm_cap
// Params 3
// Checksum 0x9c3f4495, Offset: 0x52a6
// Size: 0x3b, Type: bool
function incap( asmname, statename, params )
{
    return self.asmname != "civilian_react" || isdefined( self.customarrivalanimset );
}

// Namespace asm_cap
// Params 3
// Checksum 0x90269dc0, Offset: 0x52ea
// Size: 0xa4
function function_83ef1379dd15e081( asmname, statename, params )
{
    if ( !isdefined( self._blackboard.coweralias ) )
    {
        coweralias = asm::asm_getrandomalias( statename );
        self._blackboard.coweralias = cap_lookupanimfromalias( statename, coweralias );
    }
    
    alias = self._blackboard.coweralias;
    
    if ( statename == "cower_to_panicked" )
    {
        self._blackboard.coweralias = undefined;
    }
    
    return alias;
}

// Namespace asm_cap
// Params 4
// Checksum 0x52b904cf, Offset: 0x5397
// Size: 0x3b, Type: bool
function shouldskiptransition( asmname, statename, tostatename, params )
{
    return istrue( self._blackboard.skiptransition );
}

// Namespace asm_cap
// Params 3
// Checksum 0x126986ee, Offset: 0x53db
// Size: 0x1bf
function capchooseturnanim( asmname, statename, params )
{
    yawtotarget = vectortoyaw( self.turntarget.origin - self.origin );
    anglediff = angleclamp180( yawtotarget - self.angles[ 1 ] );
    turnanim = undefined;
    
    if ( params == "cardinal" )
    {
        absanglediff = abs( anglediff );
        animindex = "2";
        
        if ( absanglediff > 135 )
        {
            animindex = "8";
        }
        else if ( anglediff > 45 && anglediff <= 135 )
        {
            animindex = "6";
        }
        else if ( anglediff >= -135 && anglediff < -45 )
        {
            animindex = "4";
        }
        
        turnanim = asm::asm_lookupanimfromalias( statename, animindex );
        assert( isdefined( turnanim ), "<dev string:x1f8>" + animindex + "<dev string:x212>" + self.animsetname );
    }
    else
    {
        animmap = [ "2", "3", "6", "9", "8", "7", "4", "1", "2" ];
        animindex = getangleindex( anglediff, 22.5 );
        animalias = animmap[ animindex ];
        turnanim = asm::asm_lookupanimfromalias( statename, animmap[ animindex ] );
        assert( isdefined( turnanim ), "<dev string:x229>" + animmap[ animindex ] + "<dev string:x212>" + self.animsetname );
    }
    
    return turnanim;
}

// Namespace asm_cap
// Params 3
// Checksum 0xd05822e, Offset: 0x55a3
// Size: 0x165
function function_f3e7915ba349aa61( asmname, statename, params )
{
    target = self.origin;
    interactionid = self getinteractionid();
    
    if ( level.bseq.instancedata[ interactionid ].var_1bc6a584e02d6e98 )
    {
        target = level.bseq.instancedata[ interactionid ].var_1bc6a584e02d6e98;
    }
    
    yawtotarget = vectortoyaw( target - self.origin );
    anglediff = angleclamp180( yawtotarget - self.angles[ 1 ] );
    var_d0f05fda9a1dd4fb = undefined;
    absanglediff = abs( anglediff );
    animindex = "2";
    
    if ( absanglediff > 135 )
    {
        animindex = "8";
    }
    else if ( anglediff > 45 && anglediff <= 135 )
    {
        animindex = "6";
    }
    else if ( anglediff >= -135 && anglediff < -45 )
    {
        animindex = "4";
    }
    
    directionalanim = asm::asm_lookupanimfromalias( statename, animindex );
    assert( isdefined( directionalanim ), "<dev string:x1f8>" + animindex + "<dev string:x212>" + self.animsetname );
    return directionalanim;
}

// Namespace asm_cap
// Params 3
// Checksum 0x1c2659d0, Offset: 0x5711
// Size: 0x1d6
function function_b93baf79cb23f0a2( asmname, statename, params )
{
    endonname = statename + "finished";
    self endon( endonname );
    target = self.origin;
    interactionid = self getinteractionid();
    yawtotarget = self.angles[ 1 ];
    
    if ( level.bseq.instancedata[ interactionid ].movedir )
    {
        yawtotarget = vectortoyaw( level.bseq.instancedata[ interactionid ].movedir );
    }
    else if ( level.bseq.instancedata[ interactionid ].var_1bc6a584e02d6e98 )
    {
        target = level.bseq.instancedata[ interactionid ].var_1bc6a584e02d6e98;
        yawtotarget = vectortoyaw( target - self.origin );
    }
    
    anglediff = angleclamp180( yawtotarget - self.angles[ 1 ] );
    gesturename = undefined;
    
    if ( anglediff > 45 )
    {
        gesturename = "point_left";
    }
    else if ( anglediff < -45 )
    {
        gesturename = "point_right";
    }
    else if ( -45 <= anglediff && anglediff <= 45 )
    {
        gesturename = "point_forward";
    }
    
    if ( gesturename )
    {
        if ( self getdemeanor() == "combat" || self getdemeanor() == "frantic" )
        {
            gesturename += "_fast";
        }
        
        notifyname = "cap_gesture";
        gesture::ai_request_gesture( gesturename, undefined, 500, notifyname );
        thread gesture_listener( notifyname, endonname, asmname );
    }
    
    asm::asm_playanimstate( asmname, statename, params );
}

// Namespace asm_cap
// Params 3
// Checksum 0x8d417010, Offset: 0x58ef
// Size: 0x76
function gesture_listener( notifyname, endonname, asmname )
{
    self endon( endonname );
    
    while ( true )
    {
        self waittill( notifyname, param );
        
        if ( param == "gesture_finish" )
        {
            self asmfireevent( asmname, "gesture_end" );
            break;
        }
        
        if ( param == "gesture_cancel" )
        {
            self asmfireevent( asmname, "gesture_end" );
            break;
        }
    }
}

// Namespace asm_cap
// Params 4
// Checksum 0x9e832082, Offset: 0x596d
// Size: 0x31, Type: bool
function function_8a8727784428ee26( asmname, statename, tostatename, params )
{
    return isdefined( self.turntarget );
}

// Namespace asm_cap
// Params 4
// Checksum 0xbf1be445, Offset: 0x59a7
// Size: 0x61
function function_b6a01df66755ad67( asmname, statename, tostatename, params )
{
    interactionid = self getinteractionid();
    
    if ( !interactionid )
    {
        return 0;
    }
    
    if ( !isdefined( archetypegetaliases( self.animsetname, tostatename ) ) )
    {
        return 0;
    }
    
    return function_521b5a0a07a246a8( interactionid, "friendDown" );
}

// Namespace asm_cap
// Params 3
// Checksum 0x31ead844, Offset: 0x5a11
// Size: 0x4e
function function_42bf7bda1fa0820f( asmname, statename, params )
{
    alias = self.blackboard.bseqphase ?? "idle";
    return cap_lookupanimfromalias( statename, alias );
}

