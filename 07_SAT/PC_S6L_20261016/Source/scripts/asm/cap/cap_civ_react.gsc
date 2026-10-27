// scripts\asm\cap\cap_civ_react.gsc  (hash_6a80b1f96116909e.gscc) (size: 11156 Bytes / 0x2b94 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x775a4114 (2002403604)
// size ...... 11156 (0x2b94)
// includes .. 7   (offset: 0x28f8)
// strings ... 37  (offset: 0x2930)
// dev strs .. 3   (offset: 0x2b4c)
// exports ... 38  (offset: 0x1968)
// cseg ...... 0x235 + 0x1733 (0x1968)
// imports ... 80  (offset: 0x1f58)
// animtree1 . 0   (offset: 0x2b74)
// animtree2 . 2   (offset: 0x2b74)
#using scripts\asm\asm;
#using scripts\asm\cap;
#using scripts\asm\cap\cap_civ_react_manager;
#using scripts\asm\shared\utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace cap_civ_react;

// Namespace cap_civ_react
// Params 3
// Checksum 0x42e54f1, Offset: 0x253
// Size: 0x74
function initcivreact( asmname, statename, params )
{
    self.fnasm_playfacialanim = utility::getsharedfunc( #"anim", #"asm_playfacialanim" );
    initcivreactcommon( asmname, statename, params );
    
    if ( !isai( self ) )
    {
        self.fnasm_handlenotetrack = utility::getsharedfunc( #"anim", #"handlenotetrack" );
    }
}

// Namespace cap_civ_react
// Params 3
// Checksum 0x73381cf6, Offset: 0x2cf
// Size: 0x36
function function_72a3d10382463e9f( asmname, statename, params )
{
    val::reset( "cap_civ_react InitCivReactCommon", "script_pushable_by_ai" );
    asm_cap::cap_exit();
}

// Namespace cap_civ_react
// Params 4
// Checksum 0xa9ead2bb, Offset: 0x30d
// Size: 0x73, Type: bool
function function_9353f68234515472( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.lasttimepushed ) )
    {
        return false;
    }
    
    timediff = gettime() - self.lasttimepushed;
    var_23b217fe0c5236fa = 10000;
    return asm::asm_eventfired( asmname, "player_pushed" ) && timediff < var_23b217fe0c5236fa;
}

// Namespace cap_civ_react
// Params 3
// Checksum 0x45c1f62, Offset: 0x389
// Size: 0x113
function function_c32a123be89fad63( asmname, statename, params )
{
    player = cap_civ_react_manager::getclosestplayer( self.origin );
    
    if ( !isdefined( player ) )
    {
        randomalias = asm_cap::cap_lookuprandomalias( statename );
        return asm_cap::cap_lookupanimfromalias( statename, randomalias );
    }
    
    if ( isdefined( self.reactdata.waspunched ) )
    {
        self.reactdata.waspunched = 0;
    }
    
    movedirnormalized = vectornormalize( self.origin - player.origin );
    targetangles = vectortoangles( movedirnormalized );
    targetyaw = angleclamp180( targetangles[ 1 ] - self.angles[ 1 ] );
    angleindex = asm::yawdiffto2468( targetyaw );
    aliasname = "pushed_" + angleindex;
    turnanim = asm_cap::cap_lookupanimfromalias( statename, aliasname );
    return turnanim;
}

#using_animtree( "generic_human" );

// Namespace cap_civ_react
// Params 3
// Checksum 0x85083692, Offset: 0x4a5
// Size: 0x236
function initcivreactcommon( asmname, statename, params )
{
    self.capeventdata = spawnstruct();
    self._blackboard.var_8141bfd7b74a80f6 = undefined;
    self.reactdata = spawnstruct();
    self.reactdata.var_ed5d1e6938130421 = 0;
    self.reactdata.var_2dae93a5479ad10d = 0;
    self.reactdata.triggeredreactiontype = "relaxed";
    self.reactdata.triggeredtime = 0;
    self.reactdata.var_372968252c7721ef = "relaxed";
    self.reactdata.var_31f78bb756f22d = 0;
    self.reactdata.isglancing = 0;
    self.reactdata.runawaycooldown = 0;
    self.reactdata.var_3c9a9092b1feeced = 1;
    self.reactdata.var_ebe365d66ab22d01 = 0;
    self.sightdata = spawnstruct();
    self.sightdata.sight_trace_queued = 0;
    self.sightdata.sight_trace_passed = 0;
    
    if ( isai( self ) )
    {
        self setanim( %lookat_procedural_node );
        self setanim( %lookat_eye_node );
        capanimset = self findoverridearchetype( "animscript" );
        
        if ( isdefined( capanimset ) )
        {
            headanim = archetypegetalias( capanimset, "knobs", "head" );
            
            if ( isdefined( headanim ) )
            {
                self setanim( headanim.anims, 1, 0.2 );
            }
            
            self.var_4e48f5af6ec54dcc = capanimset;
            self.prevasmname = asmname;
        }
    }
    else
    {
        self.fakeactor_face_anim = 1;
        self.facialstate = "asm";
        self.var_2eb71d32b982e8a4 = 1;
    }
    
    val::set( "cap_civ_react InitCivReactCommon", "script_pushable_by_ai", 0 );
    
    if ( !self.var_ed632dc7f1d2ff1 )
    {
    }
}

// Namespace cap_civ_react
// Params 0
// Checksum 0x23db941b, Offset: 0x6e3
// Size: 0x199
function proximity_bump()
{
    self endon( #"death" );
    val::set( "cap_civ_react proximity_bump", "script_pushable", 0 );
    
    while ( true )
    {
        triggerevent = 0;
        player = cap_civ_react_manager::getclosestplayer( self.origin );
        
        if ( !isdefined( player ) )
        {
            waitframe();
            continue;
        }
        
        tome = self.origin - player.origin;
        var_3a1674a6159dfad4 = length2dsquared( tome );
        var_e26138194c9c84a = 70;
        
        if ( isdefined( self.reactdata.var_e26138194c9c84a ) )
        {
            var_e26138194c9c84a = self.reactdata.var_e26138194c9c84a;
        }
        else if ( isdefined( level.civreactdata.var_e26138194c9c84a ) )
        {
            var_e26138194c9c84a = level.civreactdata.var_e26138194c9c84a;
        }
        
        if ( var_3a1674a6159dfad4 < var_e26138194c9c84a * var_e26138194c9c84a )
        {
            playervelocity = player getvelocity();
            playerspeedsqr = length2dsquared( playervelocity );
            
            if ( playerspeedsqr > 0 )
            {
                normalizedvelocity = vectornormalize( playervelocity );
                tome = vectornormalize( tome );
                dot = vectordot( normalizedvelocity, tome );
                triggerevent = dot > 0.866;
            }
        }
        
        if ( triggerevent && self.reactdata.var_3c9a9092b1feeced )
        {
            asm::asm_fireevent( self.asmname, "player_pushed" );
            var_a6fa26cfe141482b = 0.25;
            wait var_a6fa26cfe141482b;
            continue;
        }
        
        waitframe();
    }
}

// Namespace cap_civ_react
// Params 0
// Checksum 0x45cc1f5c, Offset: 0x884
// Size: 0x77
function debugcapcivreact()
{
    while ( true )
    {
        if ( getdvar( @"hash_39375e00c2cad343", "" ) != "" && isdefined( self.attitude ) )
        {
            level notify( #"hash_8336820b1596f990" );
            
            if ( getdvar( @"hash_39375e00c2cad343", "relaxed" ) != self.attitude )
            {
                self.attitude = getdvar( @"hash_39375e00c2cad343" );
            }
        }
        
        wait 1;
    }
}

// Namespace cap_civ_react
// Params 1
// Checksum 0xbee3de2a, Offset: 0x903
// Size: 0x1a
function capcivreact( asmname )
{
    thread debugcapcivreact();
    thread capcivreact_eventhandler();
}

// Namespace cap_civ_react
// Params 1
// Checksum 0x20e6a6b8, Offset: 0x925
// Size: 0xeb
function function_afc36f5ce2d38c4a( originator )
{
    var_43c2a2710a7341ec = distance( originator.origin, self.origin );
    waittimems = var_43c2a2710a7341ec / level.civreactdata.var_bd06e361a0bf0f31 + randomfloat( 0.5 ) * 1000;
    reacttime = waittimems + gettime();
    
    if ( isdefined( self.var_689d455a803de704 ) < reacttime )
    {
        return;
    }
    
    self.capeventdata.lastevent = "bulletfired";
    self.capeventdata.lasteventorigin = originator.origin;
    self.capeventdata.var_77ee35efda799cca = gettime();
    self notify( #"hash_d373c961a24cd707" );
    self endon( #"hash_d373c961a24cd707" );
    wait waittimems;
}

// Namespace cap_civ_react
// Params 0
// Checksum 0xc6e2c663, Offset: 0xa18
// Size: 0x4c
function capcivreact_eventhandler()
{
    while ( true )
    {
        self waittill( #"cap_event", eventname, originator );
        
        switch ( eventname )
        {
            case #"hash_cb9359e30cbc556b":
                function_afc36f5ce2d38c4a( originator );
                break;
        }
    }
}

// Namespace cap_civ_react
// Params 0
// Checksum 0xe41f7cda, Offset: 0xa6c
// Size: 0x23
function function_19fd03ae91a59b29()
{
    target = self._blackboard.var_8141bfd7b74a80f6;
    return target;
}

// Namespace cap_civ_react
// Params 3
// Checksum 0x31de2432, Offset: 0xa98
// Size: 0x24b
function function_88a14e8e39cd0a1b( asmname, statename, params )
{
    selfent = self;
    
    if ( isdefined( self.capgroup ) )
    {
        capgroup = level.capgroups[ self.capgroup ];
        index = 0;
        
        for ( capindex = 0; capindex < capgroup.size ; capindex++ )
        {
            if ( isalive( capgroup[ capindex ] ) )
            {
                selfent = capgroup[ capindex ];
                break;
            }
        }
    }
    
    player_target = function_19fd03ae91a59b29();
    
    if ( !isdefined( player_target ) )
    {
        target = utility::function_bead19f1fd2135a1( 1024 );
    }
    else
    {
        target = player_target.origin;
    }
    
    yawtotarget = vectortoyaw( target - selfent.origin );
    anglediff = angleclamp180( yawtotarget - selfent.angles[ 1 ] );
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
        
        turnanim = asm_cap::cap_lookupanimfromalias( statename, animindex );
        assert( isdefined( turnanim ), "<dev string:x24>" + animindex + "<dev string:x3e>" + self.animsetname );
    }
    else
    {
        animmap = [ "2", "3", "6", "9", "8", "7", "4", "1", "2" ];
        animindex = getangleindex( anglediff, 22.5 );
        turnanim = asm_cap::cap_lookupanimfromalias( statename, animmap[ animindex ] );
        assert( isdefined( turnanim ), "<dev string:x59>" + animmap[ animindex ] + "<dev string:x3e>" + self.animsetname );
    }
    
    return turnanim;
}

// Namespace cap_civ_react
// Params 4
// Checksum 0xab8c215, Offset: 0xcec
// Size: 0x1bb, Type: bool
function function_d0db4a4fd2e0e95c( asmname, fromstate, tostate, params )
{
    if ( params == "return" )
    {
        angles = self.interaction_angles;
        anglediff = angleclamp180( angles[ 1 ] - self.angles[ 1 ] );
        angletouse = 22.5;
        return ( abs( anglediff ) > angletouse );
    }
    
    target = function_19fd03ae91a59b29();
    
    if ( isdefined( target ) )
    {
        totarget = target.origin - self.origin;
        yawtotarget = vectortoyaw( totarget );
        angletouse = 45;
        
        if ( !isai( self ) )
        {
            distsqrtotarget = lengthsquared( totarget );
            var_a73e896d91e2aa7a = [ [ 300, 23 ], [ 0, 45 ] ];
            
            foreach ( pair in var_a73e896d91e2aa7a )
            {
                distancesqr = pair[ 0 ] * pair[ 0 ];
                
                if ( distsqrtotarget > distancesqr )
                {
                    angletouse = pair[ 1 ];
                    break;
                }
            }
        }
        
        anglediff = angleclamp180( yawtotarget - self.angles[ 1 ] );
        
        if ( abs( anglediff ) > angletouse )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace cap_civ_react
// Params 3
// Checksum 0xbefbd43d, Offset: 0xeb0
// Size: 0x64
function curious_playanim( asmname, statename, params )
{
    if ( isstring( params ) && params == "return" )
    {
        self._blackboard.bseqphase = self._blackboard.var_8acd86e75a05d61a;
    }
    
    asm_cap::cap_playanim( asmname, statename );
}

// Namespace cap_civ_react
// Params 3
// Checksum 0x4c2f942c, Offset: 0xf1c
// Size: 0x15c
function function_a3b606f5f5f3b9dc( asmname, statename, params )
{
    self endon( statename + "_finished" );
    turnanim = asm::asm_getanim( asmname, statename );
    turnxanim = asm::asm_getxanim( statename, turnanim );
    self.useanimgoalweight = 1;
    assert( !isdefined( params ) || isarray( params ) && params.size == 2 );
    rate = 1;
    
    if ( isai( self ) )
    {
        if ( isdefined( params ) )
        {
            if ( isdefined( params[ 0 ] ) )
            {
                tracktime = params[ 0 ];
                asm_cap::function_aca38f6190adaf8b( turnxanim, tracktime );
            }
        }
        else
        {
            self setlookatenabled( 0 );
        }
        
        self aisetanim( statename, turnanim, rate );
    }
    else
    {
        bodyanimid = asm::asm_lookupanimfromalias( "knobs", "body" );
        bodyxanim = asm::asm_getxanim( "knobs", bodyanimid );
        self setflaggedanimknoballrestart( statename, turnxanim, bodyxanim, 1, 0.2, 1 );
    }
    
    if ( !isdefined( params ) || params[ 1 ] )
    {
        thread function_d18bf46c30a3148c( turnxanim, statename );
    }
    
    if ( !isai( self ) )
    {
        thread function_b1be93e1a8f085d7( turnxanim, statename );
    }
    
    notehandler = asm::asm_getnotehandler( asmname, statename );
    asm::asm_donotetracks( asmname, statename, notehandler );
}

// Namespace cap_civ_react
// Params 2
// Checksum 0x93e7c0ac, Offset: 0x1080
// Size: 0x9f
function function_b1be93e1a8f085d7( turnxanim, statename )
{
    self endon( #"death" );
    animlength = getanimlength( turnxanim );
    totaltraces = animlength / 0.4;
    interval = animlength / totaltraces;
    contents = trace::create_solid_ai_contents( 1 );
    
    for ( trace = 0; trace < totaltraces ; trace++ )
    {
        wait interval;
        self.origin = utility::drop_to_ground( self.origin, 30, -30, undefined, contents );
    }
}

// Namespace cap_civ_react
// Params 2
// Checksum 0xc157d7c1, Offset: 0x1127
// Size: 0x227
function function_d18bf46c30a3148c( turnxanim, statename )
{
    self endon( #"death" );
    self endon( statename + "_finished" );
    enemy = function_19fd03ae91a59b29();
    
    if ( !isdefined( enemy ) )
    {
        return;
    }
    
    enemy endon( #"death" );
    animlength = getanimlength( turnxanim );
    
    if ( animhasnotetrack( turnxanim, "start_aim" ) )
    {
        finish_time = getnotetracktimes( turnxanim, "start_aim" );
        animlength *= finish_time[ 0 ];
    }
    else if ( animhasnotetrack( turnxanim, "finish" ) )
    {
        finish_time = getnotetracktimes( turnxanim, "finish" );
        animlength *= finish_time[ 0 ];
    }
    
    numframes = int( animlength * 20 );
    remainingframes = numframes;
    
    if ( isai( self ) )
    {
        while ( remainingframes > 0 )
        {
            lerpfraction = 1 / remainingframes;
            yawtoenemy = angleclamp180( vectortoyaw( enemy.origin - self.origin ) - self.angles[ 1 ] );
            currentanimtime = undefined;
            currentanimtime = self aigetanimtime( turnxanim );
            animyawdelta = getangledelta( turnxanim, currentanimtime, 1 );
            remainingyaw = angleclamp180( yawtoenemy - animyawdelta );
            self orientmode( "face angle", angleclamp( self.angles[ 1 ] + remainingyaw * lerpfraction ) );
            remainingframes--;
            wait 0.05;
        }
        
        return;
    }
    
    while ( remainingframes > 0 )
    {
        lerpfraction = 1 / remainingframes;
        yawtoenemy = angleclamp180( vectortoyaw( enemy.origin - self.origin ) - self.angles[ 1 ] );
        currentanimtime = undefined;
        currentanimtime = self getanimtime( turnxanim );
        animyawdelta = getangledelta( turnxanim, currentanimtime, 1 );
        remainingyaw = angleclamp180( yawtoenemy - animyawdelta );
        yaw = angleclamp( self.angles[ 1 ] + remainingyaw * lerpfraction );
        self.angles = ( 0, yaw, 0 );
        remainingframes--;
        wait 0.05;
    }
}

// Namespace cap_civ_react
// Params 3
// Checksum 0xcd77e756, Offset: 0x1356
// Size: 0x28
function playturnanim_cleanup( asmname, statename, params )
{
    self.useanimgoalweight = 0;
}

// Namespace cap_civ_react
// Params 4
// Checksum 0x5b2caff5, Offset: 0x1386
// Size: 0x73, Type: bool
function function_1c26d4e18bd0fb90( asmname, statename, tostatename, params )
{
    if ( self._blackboard.blockcower )
    {
        return false;
    }
    
    if ( self.attitude == "cower" )
    {
        return true;
    }
    
    if ( gettime() >= self._blackboard.cowertime )
    {
        return true;
    }
    
    return false;
}

// Namespace cap_civ_react
// Params 3
// Checksum 0xfb27264a, Offset: 0x1402
// Size: 0x58
function cap_playanim_panic( asmname, statename, params )
{
    if ( randomint( 100 ) < 30 )
    {
        self._blackboard.cowertime = gettime() + randomintrange( 3000, 5000 );
    }
    
    asm_cap::cap_playanim( asmname, statename, params );
}

// Namespace cap_civ_react
// Params 3
// Checksum 0xdfbad696, Offset: 0x1462
// Size: 0x31
function function_1b8eff6763ba9e46( asmname, statename, params )
{
    self._blackboard.cowertime = undefined;
}

// Namespace cap_civ_react
// Params 1
// Checksum 0xe0a99b18, Offset: 0x149b
// Size: 0x4a
function function_861cb01ebeedd661( note )
{
    if ( !isai( self ) )
    {
        return;
    }
    
    if ( note == "hp_on" )
    {
        self setlookatenabled( 1 );
        self setlookatplayer( level.player );
    }
    
    if ( note == "hp_off" )
    {
        self setlookatenabled( 0 );
    }
}

// Namespace cap_civ_react
// Params 4
// Checksum 0x39e5c873, Offset: 0x14ed
// Size: 0x5c
function function_a483c382ee4790a2( asmname, fromstatename, tostatename, params )
{
    shouldpanic = istrue( self._blackboard.retriggerpanic );
    self._blackboard.retriggerpanic = undefined;
    return shouldpanic;
}

// Namespace cap_civ_react
// Params 3
// Checksum 0xa31fc25d, Offset: 0x1552
// Size: 0x77
function function_a78628645cd05677( asmname, statename, params )
{
    assert( isdefined( self._blackboard.cowerstate ) );
    
    if ( self._blackboard.cowerstate == "b" )
    {
        return asm_cap::cap_chooseanim( asmname, statename, "a_to_b" );
    }
    
    return asm_cap::cap_chooseanim( asmname, statename, "b_to_a" );
}

// Namespace cap_civ_react
// Params 3
// Checksum 0x13abb157, Offset: 0x15d1
// Size: 0x84
function cap_chooseanim_cower( asmname, statename, params )
{
    if ( asm_cap::cap_hasalias( statename, "a" ) )
    {
        if ( !isdefined( self._blackboard.cowerstate ) )
        {
            self._blackboard.cowerstate = "a";
        }
        
        return asm_cap::cap_chooseanim( asmname, statename, self._blackboard.cowerstate );
    }
    
    return asm_cap::cap_chooseanim( asmname, statename, params );
}

// Namespace cap_civ_react
// Params 4
// Checksum 0x3840d438, Offset: 0x165e
// Size: 0xc6
function function_bd685a5cf3c53307( asmname, fromstatename, tostatename, params )
{
    if ( !function_a483c382ee4790a2( asmname, fromstatename, tostatename, params ) )
    {
        return 0;
    }
    
    shouldswitch = asm_cap::cap_hasalias( fromstatename, "a" );
    
    if ( shouldswitch )
    {
        assert( isdefined( self._blackboard.cowerstate ) );
        
        if ( self._blackboard.cowerstate == "a" )
        {
            self._blackboard.cowerstate = "b";
        }
        else
        {
            self._blackboard.cowerstate = "a";
        }
    }
    
    return shouldswitch;
}

// Namespace cap_civ_react
// Params 4
// Checksum 0x381ddb8, Offset: 0x172d
// Size: 0x31, Type: bool
function function_150c29c667a4f159( asmname, fromstatename, tostatename, params )
{
    return istrue( self.var_ead7d9371042d88b );
}

// Namespace cap_civ_react
// Params 4
// Checksum 0x37b2145a, Offset: 0x1767
// Size: 0x48, Type: bool
function withingoaldist( asmname, statename, tostatename, param )
{
    disttogoal = 320;
    
    if ( isdefined( param ) )
    {
        disttogoal = param;
    }
    
    return self pathdisttogoal() < disttogoal;
}

// Namespace cap_civ_react
// Params 4
// Checksum 0x2e3fbc6c, Offset: 0x17b8
// Size: 0x4c, Type: bool
function function_94c9cf2d20dc743a( asmname, statename, tostatename, param )
{
    if ( !isdefined( self.var_caa980226028a90f ) )
    {
        return false;
    }
    
    if ( !isdefined( param ) )
    {
        return false;
    }
    
    return self.var_caa980226028a90f == param;
}

// Namespace cap_civ_react
// Params 0
// Checksum 0xce66f1ba, Offset: 0x180d
// Size: 0x10, Type: bool
function function_c181921d8ceb0ee6()
{
    return self getaiblackboarddynamic( "threat_level" ) ?? 0;
}

// Namespace cap_civ_react
// Params 1
// Checksum 0x442e9bdf, Offset: 0x1826
// Size: 0x19
function function_df50bdc4af49b91a( threatlevel )
{
    self function_786bb6aa1b76c7ee( "threat_level", threatlevel );
}

// Namespace cap_civ_react
// Params 4
// Checksum 0x9132067a, Offset: 0x1847
// Size: 0x30, Type: bool
function function_a3a566e61bf80e7d( asmname, statename, tostatename, params )
{
    return function_c181921d8ceb0ee6() == 1;
}

// Namespace cap_civ_react
// Params 1
// Checksum 0xd09de50f, Offset: 0x1880
// Size: 0x25
function function_9ab21e051a44ef65( state )
{
    if ( state )
    {
        function_df50bdc4af49b91a( 1 );
        return;
    }
    
    function_df50bdc4af49b91a( 0 );
}

// Namespace cap_civ_react
// Params 4
// Checksum 0x815f5033, Offset: 0x18ad
// Size: 0x32, Type: bool
function function_172edccc45a49aa0( asmname, statename, tostatename, params )
{
    return istrue( self getaiblackboarddynamic( "walk_away" ) );
}

// Namespace cap_civ_react
// Params 1
// Checksum 0xeb996b4, Offset: 0x18e8
// Size: 0x1a
function function_6c955ab04b1e9a68( state )
{
    self function_786bb6aa1b76c7ee( "walk_away", istrue( state ) );
}

// Namespace cap_civ_react
// Params 4
// Checksum 0x62746363, Offset: 0x190a
// Size: 0x30, Type: bool
function function_2623dad791b83c67( asmname, statename, tostatename, params )
{
    return function_c181921d8ceb0ee6() == 2;
}

// Namespace cap_civ_react
// Params 1
// Checksum 0x51d59947, Offset: 0x1943
// Size: 0x25
function function_423f654a9f19091f( state )
{
    if ( state )
    {
        function_df50bdc4af49b91a( 2 );
        return;
    }
    
    function_df50bdc4af49b91a( 0 );
}

