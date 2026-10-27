// scripts\anim\utility.gsc  (hash_7e4d332e911e1b90.gscc) (size: 14161 Bytes / 0x3751 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc72f3129 (3341758761)
// size ...... 14161 (0x3751)
// includes .. 5   (offset: 0x3361)
// strings ... 34  (offset: 0x3389)
// dev strs .. 29  (offset: 0x3575)
// exports ... 63  (offset: 0x1ee9)
// cseg ...... 0x2a0 + 0x1c49 (0x1ee9)
// imports ... 89  (offset: 0x28c1)
// animtree1 . 0   (offset: 0x3711)
// animtree2 . 4   (offset: 0x3711)
#using scripts\anim\utility_common;
#using scripts\common\callbacks;
#using scripts\common\gameskill;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace utility;

// Namespace utility
// Params 1
// Checksum 0x24242614, Offset: 0x2be
// Size: 0xc
function initialize( type )
{
    
}

#using_animtree( "generic_human" );

// Namespace utility
// Params 0
// Checksum 0xf51da2e5, Offset: 0x2d2
// Size: 0x13d
function updateanimpose()
{
    assert( self.a.movement == "<dev string:x24>" || self.a.movement == "<dev string:x29>" || self.a.movement == "<dev string:x2e>", "<dev string:x32>" + self.currentpose + "<dev string:x42>" + self.a.movement );
    
    if ( isdefined( self.desired_anim_pose ) && self.desired_anim_pose != self.currentpose )
    {
        if ( self.currentpose == "prone" )
        {
            exitpronewrapper( 0.5 );
        }
        
        if ( self.desired_anim_pose == "prone" )
        {
            self setproneanimnodes( -45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up );
            enterpronewrapper( 0.5 );
            self setanimknoball( lookupanim( "default_prone", "straight_level" ), %body, 1, 0.1, 1 );
        }
    }
    
    self.desired_anim_pose = undefined;
}

/#

    // Namespace utility
    // Params 1
    // Checksum 0x25b6000a, Offset: 0x417
    // Size: 0xd4, Type: dev
    function checkgrenadeinhand( animscript )
    {
        self endon( #"killanimscript" );
        
        if ( animscript == "<dev string:x44>" || animscript == "<dev string:x49>" )
        {
            wait 0.05;
            waittillframeend();
        }
        
        attachsize = self getattachsize();
        
        for ( i = 0; i < attachsize ; i++ )
        {
            model = tolower( self getattachmodelname( i ) );
            assert( model != "<dev string:x4f>", "<dev string:x62>" + self.origin );
            assert( model != "<dev string:xb9>", "<dev string:x62>" + self.origin );
            assert( model != "<dev string:xd6>", "<dev string:x62>" + self.origin );
        }
    }

#/

// Namespace utility
// Params 0
// Checksum 0xf5466d0a, Offset: 0x4f3
// Size: 0x6a
function printdisplaceinfo()
{
    self endon( #"death" );
    self notify( #"hash_eac7843df6179931" );
    self endon( #"hash_eac7843df6179931" );
    
    for ( ;; )
    {
        /#
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:xee>", ( 0, 0.4, 0.7 ), 0.85, 0.5 );
        #/
        
        wait 0.05;
    }
}

/#

    // Namespace utility
    // Params 0
    // Checksum 0x554c8520, Offset: 0x565
    // Size: 0x25, Type: dev
    function isdebugon()
    {
        return getdvarint( @"animdebug" ) == 1 || anim.debugent == self;
    }

    // Namespace utility
    // Params 4
    // Checksum 0x62cd833c, Offset: 0x592
    // Size: 0x53, Type: dev
    function drawdebuglineinternal( frompoint, topoint, color, durationframes )
    {
        for ( i = 0; i < durationframes ; i++ )
        {
            line( frompoint, topoint, color );
            wait 0.05;
        }
    }

    // Namespace utility
    // Params 4
    // Checksum 0xd6bd4c8d, Offset: 0x5ed
    // Size: 0x40, Type: dev
    function drawdebugline( frompoint, topoint, color, durationframes )
    {
        if ( isdebugon() )
        {
            thread drawdebuglineinternal( frompoint, topoint, color, durationframes );
        }
    }

    // Namespace utility
    // Params 4
    // Checksum 0x4a29a244, Offset: 0x635
    // Size: 0x56, Type: dev
    function debugline( frompoint, topoint, color, durationframes )
    {
        for ( i = 0; i < durationframes * 20 ; i++ )
        {
            line( frompoint, topoint, color );
            wait 0.05;
        }
    }

#/

// Namespace utility
// Params 3
// Checksum 0x62dcae9d, Offset: 0x693
// Size: 0x37
function notifyaftertime( notifystring, killmestring, time )
{
    self endon( #"death" );
    self endon( killmestring );
    wait time;
    self notify( notifystring );
}

// Namespace utility
// Params 4
// Checksum 0x4fca2e0c, Offset: 0x6d2
// Size: 0x66
function drawstringtime( msg, org, color, timer )
{
    maxtime = timer * 20;
    
    for ( i = 0; i < maxtime ; i++ )
    {
        /#
            print3d( org, msg, color, 1, 1 );
        #/
        
        wait 0.05;
    }
}

// Namespace utility
// Params 1
// Checksum 0xce6aebcf, Offset: 0x740
// Size: 0xc0
function showlastenemysightpos( string )
{
    self notify( #"got known enemy2" );
    self endon( #"got known enemy2" );
    self endon( #"death" );
    
    if ( !isdefined( self.enemy ) )
    {
        return;
    }
    
    if ( self.enemy.team == "allies" )
    {
        color = ( 0.4, 0.7, 1 );
    }
    else
    {
        color = ( 1, 0.7, 0.4 );
    }
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isdefined( self.lastenemysightpos ) )
        {
            continue;
        }
        
        /#
            print3d( self.lastenemysightpos, string, color, 1, 2.15 );
        #/
    }
}

/#

    // Namespace utility
    // Params 4
    // Checksum 0x17f8e34d, Offset: 0x808
    // Size: 0x94, Type: dev
    function function_2d157e8584292eb( string, org, printtime, color )
    {
        level notify( "<dev string:xf8>" + org );
        level endon( "<dev string:xf8>" + org );
        
        if ( !isdefined( color ) )
        {
            color = ( 0.3, 0.9, 0.6 );
        }
        
        timer = printtime * 20;
        i = 0;
        
        while ( i < timer )
        {
            wait 0.05;
            print3d( org, string, color, 1, 1 );
            i += 1;
        }
    }

    // Namespace utility
    // Params 4
    // Checksum 0x5a60af89, Offset: 0x8a4
    // Size: 0x53, Type: dev
    function printdebugtext( string, org, printtime, color )
    {
        if ( getdvar( @"anim_debug", "<dev string:x10a>" ) != "<dev string:x10a>" )
        {
            level thread function_2d157e8584292eb( string, org, printtime, color );
        }
    }

#/

// Namespace utility
// Params 0
// Checksum 0x8d9e7756, Offset: 0x8ff
// Size: 0x33
function hasenemysightpos()
{
    if ( isdefined( self.node ) )
    {
        return ( utility_common::canseeenemyfromexposed() || self cansuppressenemyfromexposed() );
    }
    
    return utility_common::canseeenemy() || utility_common::cansuppressenemy();
}

// Namespace utility
// Params 0
// Checksum 0x1ebae486, Offset: 0x93a
// Size: 0xb
function getenemysightpos()
{
    return self.goodshootpos;
}

// Namespace utility
// Params 0
// Checksum 0xfa8b08f3, Offset: 0x94e
// Size: 0x11
function debugtimeout()
{
    wait 5;
    self notify( #"timeout" );
}

// Namespace utility
// Params 3
// Checksum 0xf308bdb8, Offset: 0x967
// Size: 0xc9
function debugposinternal( org, string, size )
{
    self endon( #"death" );
    self notify( "stop debug " + org );
    self endon( "stop debug " + org );
    ent = spawnstruct();
    ent thread debugtimeout();
    ent endon( #"timeout" );
    
    if ( self.enemy.team == "allies" )
    {
        color = ( 0.4, 0.7, 1 );
    }
    else
    {
        color = ( 1, 0.7, 0.4 );
    }
    
    /#
        while ( true )
        {
            wait 0.05;
            print3d( org, string, color, 1, size );
        }
    #/
}

// Namespace utility
// Params 2
// Checksum 0xa1e994fb, Offset: 0xa38
// Size: 0x24
function debugpos( org, string )
{
    thread debugposinternal( org, string, 2.15 );
}

// Namespace utility
// Params 3
// Checksum 0x4a7ea23a, Offset: 0xa64
// Size: 0x29
function debugpossize( org, string, size )
{
    thread debugposinternal( org, string, size );
}

// Namespace utility
// Params 2
// Checksum 0xd290adea, Offset: 0xa95
// Size: 0xc2
function debugburstprint( numshots, maxshots )
{
    burstsize = numshots / maxshots;
    burstsizestr = undefined;
    
    if ( numshots == self.bulletsinclip )
    {
        burstsizestr = "all rounds";
    }
    else if ( burstsize < 0.25 )
    {
        burstsizestr = "small burst";
    }
    else if ( burstsize < 0.5 )
    {
        burstsizestr = "med burst";
    }
    else
    {
        burstsizestr = "long burst";
    }
    
    thread debugpossize( self.origin + ( 0, 0, 42 ), burstsizestr, 1.5 );
    thread debugpos( self.origin + ( 0, 0, 60 ), "Suppressing" );
}

/#

    // Namespace utility
    // Params 0
    // Checksum 0xd9c1ddde, Offset: 0xb5f
    // Size: 0xa9, Type: dev
    function printshootproc()
    {
        self endon( #"death" );
        self notify( "<dev string:x10b>" + self.export );
        self endon( "<dev string:x10b>" + self.export );
        printtime = 0.25;
        timer = printtime * 20;
        i = 0;
        
        while ( i < timer )
        {
            wait 0.05;
            print3d( self.origin + ( 0, 0, 70 ), "<dev string:x117>", ( 1, 0, 0 ), 1, 1 );
            i += 1;
        }
    }

    // Namespace utility
    // Params 0
    // Checksum 0x6c4eac1d, Offset: 0xc10
    // Size: 0x1f, Type: dev
    function printshoot()
    {
        if ( getdvarint( @"anim_debug" ) == 3 )
        {
            thread printshootproc();
        }
    }

#/

// Namespace utility
// Params 4
// Checksum 0x9289e305, Offset: 0xc37
// Size: 0x72
function showdebugproc( frompoint, topoint, color, printtime )
{
    /#
        self endon( #"death" );
        timer = printtime * 20;
        i = 0;
        
        while ( i < timer )
        {
            wait 0.05;
            line( frompoint, topoint, color );
            i += 1;
        }
    #/
}

// Namespace utility
// Params 4
// Checksum 0x24deca4c, Offset: 0xcb1
// Size: 0x42
function showdebugline( frompoint, topoint, color, printtime )
{
    thread showdebugproc( frompoint, topoint + ( 0, 0, -5 ), color, printtime );
}

// Namespace utility
// Params 1
// Checksum 0x7b46ac53, Offset: 0xcfb
// Size: 0xe3
function shootenemywrapper_normal( var_3194eba7c1afe666 )
{
    self._blackboard.shootparams_lastshoottime = gettime();
    gameskill::set_accuracy_based_on_situation();
    self notify( #"shooting" );
    
    if ( self aiissniper() && self._blackboard.shootparams_valid && isdefined( self._blackboard.shootparams_pos ) )
    {
        if ( isdefined( self.var_819a7890692fc6d5 ) && self.var_1fbbbbeed4c2dd18 > gettime() - 250 )
        {
            self shoot( 1, self.var_819a7890692fc6d5, 1, 0, 1 );
        }
        else
        {
            self shoot( 1, self._blackboard.shootparams_pos, 1, 0, 1 );
        }
        
        return;
    }
    
    if ( isagent( self ) )
    {
        var_3194eba7c1afe666 = 1;
    }
    
    self shoot( 1, undefined, var_3194eba7c1afe666 );
}

// Namespace utility
// Params 1
// Checksum 0x1c23e877, Offset: 0xde6
// Size: 0x22
function shootenemywrapper_shootnotify( var_3194eba7c1afe666 )
{
    level notify( #"an_enemy_shot", self );
    shootenemywrapper_normal( var_3194eba7c1afe666 );
}

// Namespace utility
// Params 2
// Checksum 0x25f97943, Offset: 0xe10
// Size: 0xb5
function shootposwrapper( shootpos, var_3194eba7c1afe666 )
{
    self._blackboard.shootparams_lastshoottime = gettime();
    
    if ( !isdefined( var_3194eba7c1afe666 ) )
    {
        var_3194eba7c1afe666 = 1;
    }
    
    self notify( #"shooting" );
    
    if ( self aiissniper() )
    {
        self shoot( 1, shootpos, 1, 1, 1 );
        return;
    }
    
    bignoreenemy = 0;
    
    if ( isdefined( self.enemy ) && self.enemy.underlowcover )
    {
        bignoreenemy = 1;
    }
    
    endpos = bulletspread( self getmuzzlepos(), shootpos, 4 );
    self shoot( 1, endpos, var_3194eba7c1afe666, bignoreenemy );
}

// Namespace utility
// Params 0
// Checksum 0x4140f6a1, Offset: 0xecd
// Size: 0x20e
function throwgun()
{
    org = spawn( "script_model", ( 0, 0, 0 ) );
    org setmodel( "temp" );
    org.origin = self gettagorigin( "tag_weapon_right" ) + ( 50, 50, 0 );
    org.angles = self gettagangles( "tag_weapon_right" );
    right = anglestoright( org.angles );
    right *= 15;
    forward = anglestoforward( org.angles );
    forward *= 15;
    org movegravity( ( 0, 50, 150 ), 100 );
    weaponclass = "weapon_" + getcompleteweaponname( self.weapon );
    weapon = spawn( weaponclass, org.origin );
    weapon.angles = self gettagangles( "tag_weapon_right" );
    weapon linkto( org );
    lastorigin = org.origin;
    
    while ( isdefined( weapon ) && isdefined( weapon.origin ) )
    {
        start = lastorigin;
        end = org.origin;
        angles = vectortoangles( end - start );
        forward = anglestoforward( angles );
        forward *= 4;
        trace = trace::_bullet_trace( end, end + forward, 1, weapon );
        
        if ( isalive( trace[ "entity" ] ) && trace[ "entity" ] == self )
        {
            wait 0.05;
            continue;
        }
        
        if ( trace[ "fraction" ] < 1 )
        {
            break;
        }
        
        lastorigin = org.origin;
        wait 0.05;
    }
    
    if ( isdefined( weapon ) && isdefined( weapon.origin ) )
    {
        weapon unlink();
    }
    
    org delete();
}

// Namespace utility
// Params 0
// Checksum 0xb33046a1, Offset: 0x10e3
// Size: 0xcf
function personalcoldbreath()
{
    tag = "TAG_EYE";
    self endon( #"death" );
    self notify( #"hash_61bb6f95e7bc7c6c" );
    self endon( #"hash_61bb6f95e7bc7c6c" );
    
    while ( isdefined( self ) )
    {
        wait 0.05;
        
        if ( !isdefined( self ) )
        {
            break;
        }
        
        if ( isdefined( self.a.movement ) && self.a.movement == "stop" )
        {
            if ( isdefined( self.isindoor ) && self.isindoor == 1 )
            {
                continue;
            }
            
            playfxontag( level._effect[ "cold_breath" ], self, tag );
            wait 2.5 + randomfloat( 3 );
            continue;
        }
        
        wait 0.5;
    }
}

// Namespace utility
// Params 0
// Checksum 0x9e415ff4, Offset: 0x11ba
// Size: 0x25
function ispartiallysuppressedwrapper()
{
    if ( self.suppressionmeter <= self.suppressionthreshold * 0.25 )
    {
        return 0;
    }
    
    return self issuppressed();
}

/#

    // Namespace utility
    // Params 3
    // Checksum 0xe09ccf67, Offset: 0x11e8
    // Size: 0x5e, Type: dev
    function showlines( start, end, end2 )
    {
        for ( ;; )
        {
            line( start, end, ( 1, 0, 0 ), 1 );
            wait 0.05;
            line( start, end2, ( 0, 0, 1 ), 1 );
            wait 0.05;
        }
    }

#/

// Namespace utility
// Params 0
// Checksum 0x6febc0e6, Offset: 0x124e
// Size: 0xf
function usingboltactionweapon()
{
    return weaponisboltaction( self.weapon );
}

// Namespace utility
// Params 3
// Checksum 0x2a7e0ae8, Offset: 0x1266
// Size: 0x8a
function setfootstepeffect( type, name, fx )
{
    assert( isdefined( name ), "<dev string:x11d>" );
    assert( isdefined( fx ), "<dev string:x147>" );
    assert( isdefined( type ), "<dev string:x16b>" );
    
    if ( !isdefined( anim.optionalstepeffects ) )
    {
        anim.optionalstepeffects = [];
    }
    
    anim.optionalstepeffects[ name ] = 1;
    level._effect[ "step_" + name ][ type ] = fx;
}

// Namespace utility
// Params 3
// Checksum 0xf04e7b0c, Offset: 0x12f8
// Size: 0x8a
function setfootstepeffectsmall( type, name, fx )
{
    assert( isdefined( name ), "<dev string:x11d>" );
    assert( isdefined( fx ), "<dev string:x147>" );
    assert( isdefined( type ), "<dev string:x16b>" );
    
    if ( !isdefined( anim.optionalstepeffectssmall ) )
    {
        anim.optionalstepeffectssmall = [];
    }
    
    anim.optionalstepeffectssmall[ name ] = 1;
    level._effect[ "step_small_" + name ][ type ] = fx;
}

// Namespace utility
// Params 3
// Checksum 0x52a94e2, Offset: 0x138a
// Size: 0xa0
function setfootprinteffect( type, name, fx )
{
    assert( isdefined( name ), "<dev string:x11d>" );
    assert( isdefined( fx ), "<dev string:x147>" );
    assert( isdefined( type ), "<dev string:x16b>" );
    
    if ( !isdefined( anim.optionalfootprinteffects ) )
    {
        anim.optionalfootprinteffects = [];
    }
    
    if ( !isdefined( anim.flirfootprinteffects ) )
    {
        anim.flirfootprinteffects = 0;
    }
    
    anim.optionalfootprinteffects[ name ] = 1;
    level._effect[ "footprint_" + name ][ type ] = fx;
}

// Namespace utility
// Params 1
// Checksum 0x2145b4a7, Offset: 0x1432
// Size: 0x47
function unsetfootstepeffect( name )
{
    assert( isdefined( name ), "<dev string:x191>" );
    
    if ( isdefined( anim.optionalstepeffects ) )
    {
        anim.optionalstepeffects[ name ] = undefined;
    }
    
    level._effect[ "step_" + name ] = undefined;
}

// Namespace utility
// Params 1
// Checksum 0xfec6d47a, Offset: 0x1481
// Size: 0x47
function unsetfootstepeffectsmall( name )
{
    assert( isdefined( name ), "<dev string:x191>" );
    
    if ( isdefined( anim.optionalstepeffectssmall ) )
    {
        anim.optionalstepeffectssmall[ name ] = undefined;
    }
    
    level._effect[ "step_small_" + name ] = undefined;
}

// Namespace utility
// Params 1
// Checksum 0x4c9c693f, Offset: 0x14d0
// Size: 0x47
function unsetfootprinteffect( name )
{
    assert( isdefined( name ), "<dev string:x191>" );
    
    if ( isdefined( anim.optionalfootprinteffects ) )
    {
        anim.optionalfootprinteffects[ name ] = undefined;
    }
    
    level._effect[ "footprint_" + name ] = undefined;
}

// Namespace utility
// Params 6
// Checksum 0xd136e079, Offset: 0x151f
// Size: 0xe3
function setnotetrackeffect( notetrack, tag, surfacename, fx, sound_prefix, sound_suffix )
{
    assert( isdefined( notetrack ) );
    assert( isdefined( tag ) );
    assert( isdefined( fx ) );
    assert( isstring( notetrack ), "<dev string:x1c4>" );
    
    if ( !isdefined( surfacename ) )
    {
        surfacename = "all";
    }
    
    if ( !isdefined( level._notetrackfx ) )
    {
        level._notetrackfx = [];
    }
    
    level._notetrackfx[ notetrack ][ surfacename ] = spawnstruct();
    level._notetrackfx[ notetrack ][ surfacename ].tag = tag;
    level._notetrackfx[ notetrack ][ surfacename ].fx = fx;
    setnotetracksound( notetrack, surfacename, sound_prefix, sound_suffix );
}

// Namespace utility
// Params 4
// Checksum 0x923552f0, Offset: 0x160a
// Size: 0xb6
function setnotetracksound( notetrack, surfacename = "all", sound_prefix, sound_suffix )
{
    if ( !isdefined( level._notetrackfx ) )
    {
        level._notetrackfx = [];
    }
    
    if ( isdefined( level._notetrackfx[ notetrack ][ surfacename ] ) )
    {
        struct = level._notetrackfx[ notetrack ][ surfacename ];
    }
    else
    {
        struct = spawnstruct();
        level._notetrackfx[ notetrack ][ surfacename ] = struct;
    }
    
    if ( isdefined( sound_prefix ) )
    {
        struct.sound_prefix = sound_prefix;
    }
    
    if ( isdefined( sound_suffix ) )
    {
        struct.sound_suffix = sound_suffix;
    }
}

// Namespace utility
// Params 1
// Checksum 0xa42490e8, Offset: 0x16c8
// Size: 0x15
function enterpronewrapper( timer )
{
    thread enterpronewrapperproc( timer );
}

// Namespace utility
// Params 1
// Checksum 0xd0a28fcb, Offset: 0x16e5
// Size: 0x92
function enterpronewrapperproc( timer )
{
    self endon( #"death" );
    self notify( #"anim_prone_change" );
    self endon( #"anim_prone_change" );
    self enterprone( timer, isdefined( self.a.onback ) );
    self waittill( #"killanimscript" );
    
    if ( self.currentpose != "prone" && !isdefined( self.a.onback ) )
    {
        self.currentpose = "prone";
    }
}

// Namespace utility
// Params 0
// Checksum 0xb69fca8e, Offset: 0x177f
// Size: 0x21
function stoponback()
{
    exitpronewrapper( 1 );
    self.a.onback = undefined;
}

// Namespace utility
// Params 1
// Checksum 0x6334e0bb, Offset: 0x17a8
// Size: 0x15
function exitpronewrapper( timer )
{
    thread exitpronewrapperproc( timer );
}

// Namespace utility
// Params 1
// Checksum 0xe2049fa, Offset: 0x17c5
// Size: 0x65
function exitpronewrapperproc( timer )
{
    self endon( #"death" );
    self notify( #"anim_prone_change" );
    self endon( #"anim_prone_change" );
    self exitprone( timer );
    self waittill( #"killanimscript" );
    
    if ( self.currentpose == "prone" )
    {
        self.currentpose = "crouch";
    }
}

// Namespace utility
// Params 0
// Checksum 0xba5c76b1, Offset: 0x1832
// Size: 0xb
function getaiprimaryweapon()
{
    return self.primaryweapon;
}

// Namespace utility
// Params 0
// Checksum 0x57fb68a6, Offset: 0x1846
// Size: 0xb
function getaisecondaryweapon()
{
    return self.secondaryweapon;
}

// Namespace utility
// Params 0
// Checksum 0x2f914e64, Offset: 0x185a
// Size: 0xb
function getaisidearmweapon()
{
    return self.sidearm;
}

// Namespace utility
// Params 0
// Checksum 0x947aed29, Offset: 0x186e
// Size: 0xb
function getaicurrentweapon()
{
    return self.weapon;
}

// Namespace utility
// Params 0
// Checksum 0xf08d8f42, Offset: 0x1882
// Size: 0x6c
function getaicurrentweaponslot()
{
    if ( self.weapon == self.primaryweapon )
    {
        return "primary";
    }
    
    if ( self.weapon == self.secondaryweapon )
    {
        return "secondary";
    }
    
    if ( self.weapon == self.sidearm )
    {
        return "sidearm";
    }
    
    assertmsg( "<dev string:x1e4>" );
}

// Namespace utility
// Params 1
// Checksum 0xea04a2a5, Offset: 0x18f6
// Size: 0x40, Type: bool
function aihasweapon( objweapon )
{
    assert( isweapon( objweapon ) );
    weaponname = getcompleteweaponname( objweapon );
    
    if ( isdefined( self.weaponinfo[ weaponname ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x9e390e38, Offset: 0x193f
// Size: 0x28
function getanimendpos( theanim )
{
    movedelta = getmovedelta( theanim, 0, 1 );
    return self localtoworldcoords( movedelta );
}

// Namespace utility
// Params 1
// Checksum 0x5b1ba6d7, Offset: 0x1970
// Size: 0xb8
function ragdolldeath( moveanim )
{
    self endon( #"killanimscript" );
    lastorg = self.origin;
    
    for ( ;; )
    {
        wait 0.05;
        force = distance( self.origin, lastorg );
        lastorg = self.origin;
        
        if ( self.health == 1 )
        {
            self.a.nodeath = 1;
            self startragdoll();
            self clearanim( moveanim, 0.1 );
            wait 0.05;
            physicsexplosionsphere( lastorg, 600, 0, force * 0.1 );
            self notify( #"killanimscript" );
            return;
        }
    }
}

// Namespace utility
// Params 0
// Checksum 0x99d66cbf, Offset: 0x1a30
// Size: 0xc, Type: bool
function iscqbwalkingorfacingenemy()
{
    return !self.facemotion;
}

// Namespace utility
// Params 0
// Checksum 0x3841631, Offset: 0x1a45
// Size: 0x1c
function randomizeidleset()
{
    self.a.idleset = randomint( 2 );
}

// Namespace utility
// Params 2
// Checksum 0x59fdd55f, Offset: 0x1a69
// Size: 0x48
function getrandomintfromseed( intseed, intmax )
{
    assert( intmax > 0 );
    index = intseed % anim.randominttablesize;
    return anim.randominttable[ index ] % intmax;
}

// Namespace utility
// Params 0
// Checksum 0xad96f4a3, Offset: 0x1aba
// Size: 0x2f
function getcurrentweaponslotname()
{
    assert( isdefined( self ) );
    
    if ( utility_common::isusingsecondary() )
    {
        return "secondary";
    }
    
    if ( utility_common::isusingsidearm() )
    {
        return "sidearm";
    }
    
    return "primary";
}

// Namespace utility
// Params 2
// Checksum 0x50d113dc, Offset: 0x1af2
// Size: 0xd7
function lookupanim( animset_name, anim_index )
{
    assert( isai( self ) );
    
    if ( isdefined( self.animarchetype ) )
    {
        assert( isdefined( anim.archetypes[ self.animarchetype ] ), "<dev string:x20e>" + self.animarchetype );
        
        if ( isdefined( anim.archetypes[ self.animarchetype ][ animset_name ][ anim_index ] ) )
        {
            return anim.archetypes[ self.animarchetype ][ animset_name ][ anim_index ];
        }
    }
    
    assert( isdefined( anim.archetypes[ "<dev string:x227>" ][ animset_name ][ anim_index ] ), "<dev string:x22f>" + animset_name + "<dev string:x255>" + anim_index + "<dev string:x258>" );
    return anim.archetypes[ "soldier" ][ animset_name ][ anim_index ];
}

// Namespace utility
// Params 1
// Checksum 0x52bb0019, Offset: 0x1bd2
// Size: 0x148
function lookupanimarray( animset_name )
{
    assert( isai( self ) );
    
    if ( isdefined( self.animarchetype ) )
    {
        assert( isdefined( anim.archetypes[ self.animarchetype ] ), "<dev string:x20e>" + self.animarchetype );
        
        if ( isdefined( anim.archetypes[ self.animarchetype ][ animset_name ] ) )
        {
            animset = anim.archetypes[ "soldier" ][ animset_name ];
            
            foreach ( key, value in anim.archetypes[ self.animarchetype ][ animset_name ] )
            {
                animset[ key ] = value;
            }
            
            return animset;
        }
    }
    
    assert( isdefined( anim.archetypes[ "<dev string:x227>" ][ animset_name ] ), "<dev string:x25a>" + animset_name + "<dev string:x258>" );
    return anim.archetypes[ "soldier" ][ animset_name ];
}

// Namespace utility
// Params 1
// Checksum 0x8ba349f3, Offset: 0x1d23
// Size: 0x12
function isenergyweapon( weapon )
{
    return weaponusesenergybullets( weapon );
}

// Namespace utility
// Params 3
// Checksum 0xe1d66f36, Offset: 0x1d3e
// Size: 0x158
function function_72b6372d2d8c997( str_gestureweapon, disallow_reload = 0, b_forcestream = 0 )
{
    assert( isdefined( str_gestureweapon ), "<dev string:x286>" );
    callback::callback( "pre_gesture_weapon_fired", { #gesture:str_gestureweapon } );
    
    if ( disallow_reload )
    {
        self cancelreload();
    }
    
    gestureweapon = makeweapon( str_gestureweapon );
    
    if ( gestureweapon === level.weaponnone )
    {
        callback::callback( "on_gesture_weapon_fire_failed", { #gesture:str_gestureweapon } );
        return;
    }
    
    if ( b_forcestream )
    {
        wmodel = getweaponmodel( gestureweapon );
        self prestreamasset( "model", getxhashasset( wmodel ), 1000 );
    }
    
    self giveandfireoffhand( gestureweapon );
    
    if ( !self hasweapon( gestureweapon ) )
    {
        if ( b_forcestream )
        {
            self prestreamclear( "model" );
        }
        
        callback::callback( "on_gesture_weapon_fire_failed", { #gesture:str_gestureweapon } );
        return;
    }
    
    if ( disallow_reload )
    {
        thread function_efe2fa9330798198( gestureweapon );
        self allowreload( 0 );
        waittill_any( "offhand_fired", "weapon_gesture_failed" );
        self allowreload( 1 );
    }
    
    if ( b_forcestream )
    {
        self prestreamclear( "model" );
    }
    
    callback::callback( "on_gesture_weapon_fired", { #gesture:str_gestureweapon } );
    return gestureweapon;
}

// Namespace utility
// Params 1
// Checksum 0x73c03c78, Offset: 0x1e9f
// Size: 0x4a
function function_efe2fa9330798198( gestureweapon )
{
    level endon( #"game_ended" );
    self endon( #"offhand_fired" );
    self endon( #"death_or_disconnect" );
    
    while ( self hasweapon( gestureweapon ) )
    {
        waitframe();
    }
    
    self notify( #"weapon_gesture_failed" );
}

