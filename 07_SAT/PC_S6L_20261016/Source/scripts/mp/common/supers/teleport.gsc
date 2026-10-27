// scripts\mp\common\supers\teleport.gsc  (hash_5fead3bc6567669a.gscc) (size: 19633 Bytes / 0x4cb1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8aa60206 (2326135302)
// size ...... 19633 (0x4cb1)
// includes .. 10  (offset: 0x4a3d)
// strings ... 18  (offset: 0x4a8d)
// dev strs .. 13  (offset: 0x4c11)
// exports ... 48  (offset: 0x314d)
// cseg ...... 0x1cd + 0x2f80 (0x314d)
// imports ... 135 (offset: 0x38cd)
// animtree1 . 0   (offset: 0x4cb1)
// animtree2 . 0   (offset: 0x4cb1)
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\target_marker;
#using scripts\mp\common\supers\active_camo;
#using scripts\mp\common\utility\points;
#using scripts\mp\supers;

#namespace teleport;

// Namespace teleport
// Params 0, eflags: 0x1
// Checksum 0x2a8f3fb4, Offset: 0x1eb
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace teleport
// Params 1, eflags: 0x4
// Checksum 0x6528037c, Offset: 0x20b
// Size: 0xcf
function private register( params )
{
    staticdata = level.superglobals.staticsuperdata[ "super_teleport" ];
    
    if ( !isdefined( staticdata ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    bundle = staticdata.bundle;
    
    if ( !isdefined( bundle ) )
    {
        assertmsg( "<dev string:x6d>" );
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_teleport", undefined, undefined, &beginuse, undefined, undefined, undefined, undefined );
    level callback::add( #"player_death", &onplayerdeath );
    level callback::add( #"on_ai_killed", &onplayerdeath );
    level callback::add( #"player_disconnect", &onplayerdisconnect );
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0x8f39c2be, Offset: 0x2e2
// Size: 0x144, Type: bool
function private beginuse()
{
    assert( isplayer( self ) );
    builddata();
    function_4635a02991dc73c2();
    
    if ( self.teleportsuper.bundle.var_8b9eade13fbfb044 )
    {
        assert( !callback::exists( #"super_cancel", &cancel ) );
        callback::add( #"super_cancel", &cancel );
    }
    
    if ( self.teleportsuper.var_effd0a4b1e866524 )
    {
        wait self.teleportsuper.var_83fc88479f048ed7;
    }
    
    teleport_location = function_649c3493f949541e();
    
    if ( self.teleportsuper.bundle.var_8b9eade13fbfb044 )
    {
        assert( callback::exists( #"super_cancel", &cancel ) );
        callback::remove( #"super_cancel", &cancel );
    }
    
    function_d73fd11402869c12();
    
    if ( !teleport_location )
    {
        cancel();
        return false;
    }
    else if ( !isvalidshapecast( teleport_location ) )
    {
        function_9b0065d6803f0742( self, &"hash_d4b2cd6a21eea6a" );
        cancel();
        return false;
    }
    
    thread teleportplayer( teleport_location );
    return true;
}

// Namespace teleport
// Params 1, eflags: 0x4
// Checksum 0xfa692840, Offset: 0x42f
// Size: 0x5c
function private cancel( params )
{
    self notify( #"equip_deploy_cancel" );
    self freezecontrols( 0 );
    function_9d216e0a4cc27ddf();
    self lerpfov( self.teleportsuper.var_3f073fc64763b109, self.teleportsuper.var_83fc88479f048ed7 );
    self.var_7e640f474fd755ae = undefined;
}

// Namespace teleport
// Params 0
// Checksum 0xf497c33c, Offset: 0x493
// Size: 0x36
function function_bc9af6778b159eb()
{
    builddata();
    self.var_7e640f474fd755ae = function_498193057dcbe7e1();
    var_483bcacc1b629852 = function_87e1fbaceba459f5();
    self.var_7e640f474fd755ae = undefined;
    return var_483bcacc1b629852;
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0x18df9276, Offset: 0x4d2
// Size: 0x61f
function private builddata()
{
    staticdata = level.superglobals.staticsuperdata[ "super_teleport" ];
    bundle = staticdata.bundle;
    self.teleportsuper = { #bundle:bundle };
    self.teleportsuper.var_3f073fc64763b109 = 65;
    self.teleportsuper.var_83fc88479f048ed7 = bundle.teleportdata.var_f88e05244ea6986a;
    self.teleportsuper.var_a38582499709f1f3 = bundle.teleportdata.var_a767d1f41c1fffba;
    self.teleportsuper.enablefov = bundle.teleportdata.var_29d1fefa084ec035;
    self.teleportsuper.targetfov = bundle.teleportdata.var_d9147370741a747;
    self.teleportsuper.var_5755b7d6a9cf4422 = bundle.teleportdata.var_de96deb7c7a652e5;
    self.teleportsuper.teleportoverlay = bundle.teleportdata.var_d1e34faba7b1f715;
    self.teleportsuper.aimingoverlay = bundle.teleportdata.var_154817ddcc07b2a1;
    self.teleportsuper.var_77c3fcd83eaa668e = bundle.teleportdata.var_d9f8c887722584f;
    self.teleportsuper.var_db956f760bc36830 = bundle.teleportdata.var_bc6c294ddf5bcf13;
    self.teleportsuper.var_352816d9a3f8701a = utility::function_b720276ae54a4d70( bundle.teleportdata.var_352816d9a3f8701a, "No TraceGroundNormalThreshold is defined for Teleport Super" );
    self.teleportsuper.previewconfig = { #var_4f5f2e8fcdd7608d:bundle.teleportdata.var_cc9f71713546becc, #var_60fd44daef6f1af0:bundle.teleportdata.var_dea818363a8ecd95, #scriptablepart:bundle.teleportdata.var_e9af219182bc5eda, #xmodel:bundle.teleportdata.var_97b4a5ba6e770568 };
    self.teleportsuper.var_febcce0e80842c16 = { #var_ef70ce6b97d70fdb:bundle.teleportdata.var_68a4aa97da61d21, #var_e50e4b0f3f98ae80:bundle.teleportdata.var_6704d8746ad976d6, #stateaiming:bundle.teleportdata.var_49cb1f00f92eaa92, #stateoff:bundle.teleportdata.var_a86bc7f23125c802, #partname:bundle.teleportdata.var_d5e574520355e68e };
    self.teleportsuper.var_effd0a4b1e866524 = getdvarint( @"hash_c999cf01b738d2f5", 1 ) == 1;
    self.teleportsuper.var_78958cd4560a98c0 = getdvarint( @"hash_863f99a2028d82b1", 0 ) == 1;
    self.teleportsuper.teleportdistance = getdvarfloat( @"hash_1425b92a63faaf6d", 800 );
    self.teleportsuper.var_ca1571891d35bf74 = getdvarint( @"hash_a91d44123ce59ee3", 1 ) == 1;
    self.teleportsuper.var_cfa8095f2d93cd86 = getdvarfloat( @"hash_a64c1887e9022347", 500 );
    self.teleportsuper.var_9c3a2da46495210 = atan( self.teleportsuper.var_cfa8095f2d93cd86 / self.teleportsuper.teleportdistance );
    self.teleportsuper.var_8038f3553ca9e5c7 = getdvarint( @"hash_f3811b8e59c504e1", 0 ) == 1;
    self.teleportsuper.var_8901f76c3cec142d = getdvarfloat( @"hash_2c6fe77ffd94bd83", -85 );
    self.teleportsuper.var_c4c8e715e8cef74b = getdvarfloat( @"hash_e11418a9e6f24821", 85 );
    self.teleportsuper.var_64d2f0b4cddd6600 = getdvarint( @"hash_37eb18bbc3b4e0ac", 1 ) == 1;
    self.teleportsuper.var_c0f8266854da989d = getdvarint( @"hash_b84935198eb59d48", 0 ) == 1;
    self.teleportsuper.ignoremetime = getdvarfloat( @"hash_74a508b7f28a37ba", 2 );
    self.teleportsuper.var_6b8caa3cb6aad6c0 = getdvarint( @"hash_c450f46a7de5e148", 2 );
    self.teleportsuper.var_bb2de854becf0809 = getdvarint( @"hash_2f285295c201290f", 1 ) == 1;
    self.teleportsuper.var_30358fc4ad8165b0 = getdvarint( @"hash_54de4dac1a5d802b", 1 ) == 1;
    self.teleportsuper.var_e010aed38652293d = getdvarfloat( @"hash_199e96a2a487e15d", 2 );
    self.teleportsuper.var_1e2e54c3f9db6f5e = getdvarfloat( @"hash_c187bb39202401ff", 0.75 );
    self.teleportsuper.var_ed286048a4fa6f8a = getdvarint( @"hash_308aa4665d0b819f", 1 ) == 1;
    self.teleportsuper.var_a64f1c5779d73bf7 = getdvarint( @"hash_19a4c4bfa8ed1aea", 1 ) == 1;
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0x142f05c, Offset: 0xaf9
// Size: 0x1e8
function private function_4635a02991dc73c2()
{
    if ( self.teleportsuper.var_febcce0e80842c16.partname && self.teleportsuper.var_febcce0e80842c16.stateaiming )
    {
        self setscriptablepartstate( self.teleportsuper.var_febcce0e80842c16.partname, self.teleportsuper.var_febcce0e80842c16.stateaiming );
    }
    
    if ( self.teleportsuper.var_5755b7d6a9cf4422 )
    {
        function_eb2a579d22bbc41d( self.teleportsuper.aimingoverlay );
    }
    
    if ( self.teleportsuper.enablefov )
    {
        self lerpfov( self.teleportsuper.targetfov, self.teleportsuper.var_83fc88479f048ed7 );
    }
    
    if ( !isdefined( self.teleportmarker ) && self.teleportsuper.previewconfig.xmodel )
    {
        self.teleportmarker = spawn( "script_model", self.origin - ( 0, 0, 1000 ) );
        self.teleportmarker hide();
        self.teleportmarker setmodel( self.teleportsuper.previewconfig.xmodel );
        self.teleportmarker setscriptablepartstate( self.teleportsuper.previewconfig.scriptablepart, self.teleportsuper.previewconfig.var_60fd44daef6f1af0 );
        self.var_4c0a43faa8dfc7f8 = 1;
        self.teleportmarker showtoplayer( self );
    }
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xa0e7cc6d, Offset: 0xce9
// Size: 0x56
function private function_d73fd11402869c12()
{
    if ( self.teleportsuper.var_5755b7d6a9cf4422 )
    {
        function_4273846c3c0bc9ba( self.teleportsuper.aimingoverlay );
    }
    
    if ( self.teleportmarker )
    {
        self.var_4c0a43faa8dfc7f8 = 0;
        self.teleportmarker delete();
    }
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xd748b41f, Offset: 0xd47
// Size: 0x60
function private function_d1840fa22f1639a0()
{
    self endon( #"death_or_disconnect" );
    self endon( #"teleport_finished" );
    level endon( #"game_ended" );
    
    while ( !level.var_b7e70fa484e134dc && self superbuttonpressed() || level.var_b7e70fa484e134dc && self secondaryoffhandbuttonpressed() )
    {
        waitframe();
    }
    
    self function_bf275e94dacf9279( gettime() );
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0x48f36006, Offset: 0xdaf
// Size: 0xab
function private waitforplacement()
{
    thread function_d1840fa22f1639a0();
    streakinfo = {};
    val::set( "super_teleport", "targetmarker_on_failed_stop", 1 );
    val::set( "super_teleport", "targetmarker_on_air_stop", 1 );
    val::set( "super_teleport", "targetmarker_on_obstruction_stop", 1 );
    marker = target_marker::gettargetmarker( streakinfo );
    val::reset( "super_teleport", "targetmarker_on_failed_stop" );
    val::reset( "super_teleport", "targetmarker_on_air_stop" );
    val::reset( "super_teleport", "targetmarker_on_obstruction_stop" );
    self notify( #"turret_placement_finished" );
    return marker.location;
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xd794fb69, Offset: 0xe63
// Size: 0x101
function private function_649c3493f949541e()
{
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"weapon_switch_started" );
    self endon( #"teleport_finished" );
    level endon( #"game_ended" );
    super_slot = supers_mp::getsuperslot( "super_teleport" );
    self endon( supers_mp::function_cc6f5a44b1441e16( super_slot, "remove_super" ) );
    
    if ( !self.teleportsuper.var_78958cd4560a98c0 )
    {
        while ( !level.var_b7e70fa484e134dc && self superbuttonpressed() || level.var_b7e70fa484e134dc && self secondaryoffhandbuttonpressed() )
        {
            self.var_7e640f474fd755ae = function_498193057dcbe7e1();
            location = function_87e1fbaceba459f5();
            
            if ( !canuseteleport() )
            {
                cancel();
                return;
            }
            
            waitframe();
        }
        
        self.var_7e640f474fd755ae = function_498193057dcbe7e1();
        location = function_87e1fbaceba459f5();
    }
    else
    {
        location = waitforplacement();
    }
    
    return location;
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xa5dab237, Offset: 0xf6d
// Size: 0x30, Type: bool
function private canuseteleport()
{
    if ( self iswingsuitdeployed() )
    {
        return false;
    }
    
    if ( self isonascender() )
    {
        return false;
    }
    
    if ( self isswimming() )
    {
        return false;
    }
    
    if ( self.using_device )
    {
        return false;
    }
    
    return true;
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xcacf68a5, Offset: 0xfa6
// Size: 0x93
function private function_91b0ee4ecf97a530()
{
    if ( !level.superteleportcontents )
    {
        ignorecharacters = getdvarint( @"hash_a7e3a9a465f1890b", 1 ) == 1;
        var_9afac63c9177fa45 = getdvarint( @"hash_899509cabbd4254e", 1 ) == 1;
        ignorewater = getdvarint( @"hash_9aa3b454dc46908a", 1 ) == 1;
        level.superteleportcontents = trace::create_contents( !ignorecharacters, 1, 1, 1, 0, !var_9afac63c9177fa45, 1, undefined, undefined, undefined, undefined, undefined, ignorewater );
    }
    
    return level.superteleportcontents;
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xfb160ebe, Offset: 0x1042
// Size: 0x246
function private function_d5c329bb1c424c94()
{
    angles = self getplayerangles();
    
    if ( self.var_c7b6c9bfdbf8d9fc )
    {
        angles = combineangles( self.var_c7b6c9bfdbf8d9fc.angles, angles );
    }
    
    pitch = angleclamp180( angles[ 0 ] );
    pitch = clamp( pitch, self.teleportsuper.var_8901f76c3cec142d, self.teleportsuper.var_c4c8e715e8cef74b );
    angles = ( pitch, angles[ 1 ], 0 );
    calculatedforward = anglestoforward( angles );
    
    if ( self.teleportsuper.var_8038f3553ca9e5c7 )
    {
        var_3345c1d37f86cce0 = self getvelocity();
        
        if ( length2d( var_3345c1d37f86cce0 ) > 10 )
        {
            calculatedforward = vectornormalize2( var_3345c1d37f86cce0 );
        }
    }
    
    if ( getdvarint( @"hash_2d7cb7c785350eaf", 0 ) == 1 )
    {
        groundnormal = self getgroundnormal();
        
        if ( groundnormal == ( 0, 0, 0 ) )
        {
            groundnormal = function_ea573f4da7c51469() ?? ( 0, 0, 1 );
        }
        
        if ( vectordot( groundnormal, ( 0, 0, 1 ) ) > 0.99 )
        {
            return calculatedforward;
        }
        
        var_1dbd02fb599bbfe1 = vectornormalize( vectorcross( groundnormal, ( 0, 0, 1 ) ) );
        var_93a51d6ffb7363c6 = vectornormalize( vectorcross( groundnormal, var_1dbd02fb599bbfe1 ) );
        playerforward = calculatedforward;
        projection = vectornormalize( playerforward - vectordot( playerforward, groundnormal ) * groundnormal );
        cosa = vectordot( projection, var_93a51d6ffb7363c6 );
        sina = vectordot( projection, var_1dbd02fb599bbfe1 );
        calculatedforward = vectornormalize( var_93a51d6ffb7363c6 * cosa + var_1dbd02fb599bbfe1 * sina );
        
        /#
            if ( getdvarint( @"hash_faea3439d80efca3", 0 ) == 1 )
            {
                newbase = axistoangles( var_93a51d6ffb7363c6, var_1dbd02fb599bbfe1, groundnormal );
                thread utility::draw_angles( newbase, self.origin, ( 1, 1, 1 ), 400, 75 );
                line( self.origin, self.origin + calculatedforward * 50, ( 1, 1, 1 ), 1, 0, 400 );
            }
        #/
    }
    
    return calculatedforward;
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xb066a543, Offset: 0x1291
// Size: 0xab
function private function_ea573f4da7c51469()
{
    tracestart = self.origin;
    traceend = tracestart - ( 0, 0, self.teleportsuper.var_352816d9a3f8701a );
    contents = trace::create_contents( 0, 1 );
    traceresult = trace::ray_trace( tracestart, traceend, self, contents );
    
    /#
        if ( getdvarint( @"hash_ee0d8de562467793", 0 ) == 1 )
        {
            line( tracestart, traceend, ( 1, 0, 0 ), 1, 1, 400 );
        }
    #/
    
    if ( traceresult[ "fraction" ] < 1 )
    {
        return traceresult[ "normal" ];
    }
}

// Namespace teleport
// Params 4, eflags: 0x4
// Checksum 0xbab4262b, Offset: 0x1345
// Size: 0x15e
function private function_8c1bef03962996cb( tracestart, traceend, var_1ebfe9d200d6c187, physicscontents )
{
    ledgeposition = tracestart;
    traceresult = trace::sphere_trace( tracestart, traceend, var_1ebfe9d200d6c187 * 2, self, physicscontents, undefined, undefined, self.var_7e640f474fd755ae );
    var_8debe0254306d39f = getdvarfloat( @"hash_1f17e6ed163d0a35", 0.7 );
    
    if ( traceresult[ "fraction" ] < var_8debe0254306d39f )
    {
        ledgeposition = traceresult[ "position" ];
        ledgeposition += traceresult[ "normal" ] * var_1ebfe9d200d6c187 * 1;
    }
    
    /#
        if ( getdvarint( @"super_teleport_debug_trace", 0 ) == 1 )
        {
            sphere( tracestart, var_1ebfe9d200d6c187 * 2, ( 1, 0, 1 ), 1, 300 );
            sphere( traceend, var_1ebfe9d200d6c187 * 2, ( 1, 0, 1 ), 1, 300 );
            line( tracestart, traceend, ( 1, 0, 1 ), 1, 1, 300 );
            print3d( ( tracestart + traceend ) * 0.5, "<dev string:x87>", ( 1, 0, 1 ), 1, 0.1, 300, 1 );
            sphere( ledgeposition, var_1ebfe9d200d6c187 * 2, ( 1, 0, 0 ), 1, 300 );
        }
    #/
    
    return ledgeposition;
}

// Namespace teleport
// Params 3, eflags: 0x4
// Checksum 0xae85553b, Offset: 0x14ac
// Size: 0xb5
function private function_f4070d1702e5394a( tracestart, var_1ebfe9d200d6c187, physicscontents )
{
    var_f82ce0e9683c213e = getdvarfloat( @"hash_8fa8f2a740a5123d", 500 );
    groundtracestart = tracestart + ( 0, 0, 5 );
    groundtraceend = groundtracestart - ( 0, 0, var_f82ce0e9683c213e );
    traceresult = trace::sphere_trace( groundtracestart, groundtraceend, 1, self, physicscontents, undefined, undefined, self.var_7e640f474fd755ae );
    
    if ( traceresult[ "fraction" ] < 1 )
    {
        groundtraceend = traceresult[ "shape_position" ];
        groundtraceend += traceresult[ "normal" ] * ( var_1ebfe9d200d6c187 + 1.5 );
    }
    
    return groundtraceend;
}

// Namespace teleport
// Params 6, eflags: 0x4
// Checksum 0x8db2e82f, Offset: 0x156a
// Size: 0x3e5
function private function_8cf8d093a498a07a( tracestart, direction, traceresult, radius, height, contents )
{
    var_1e6ac553decd744a = traceresult[ "normal" ];
    var_24f12a9d513ebc61 = vectordot( var_1e6ac553decd744a, ( 0, 0, 1 ) );
    
    if ( abs( var_24f12a9d513ebc61 ) > sin( 15 ) )
    {
        if ( self.teleportsuper.var_ed286048a4fa6f8a )
        {
            var_1e6ac553decd744a = vectornormalize( ( direction[ 0 ] * -1, direction[ 1 ] * -1, 0 ) );
            tracestart += var_1e6ac553decd744a * radius * 1;
            
            /#
                if ( getdvarint( @"hash_a2c87fd54857ae74", 0 ) == 1 )
                {
                    line( traceresult[ "<dev string:x92>" ], traceresult[ "<dev string:x92>" ] + var_1e6ac553decd744a * 50, ( 0, 0, 1 ), 1, 1, 1 );
                }
            #/
        }
        else
        {
            return tracestart;
        }
    }
    
    var_ffd452d8823d297d = tracestart + var_1e6ac553decd744a * radius * self.teleportsuper.var_e010aed38652293d;
    
    if ( self.teleportsuper.var_a64f1c5779d73bf7 )
    {
        var_4bcf9cceec50cb6d = getdvarfloat( @"hash_529d5ad98016490f", 0 );
        var_58f280ac43d2d423 = getdvarfloat( @"hash_f9cbc083f8a847a1", -45 );
        var_124fd82293dd8eeb = getdvarfloat( @"hash_99e2c21c07c57bd9", 0.75 );
        var_115135e9f6c2593d = getdvarfloat( @"hash_9928adbbdbdd1d2f", 1.5 );
        [ pitch ] = self getplayerangles();
        var_92580e02e12ce9e9 = math::remap( clamp( pitch, var_58f280ac43d2d423, var_4bcf9cceec50cb6d ), var_58f280ac43d2d423, var_4bcf9cceec50cb6d, var_115135e9f6c2593d, var_124fd82293dd8eeb );
        var_7eb293f99986fc1e = self.teleportsuper.var_1e2e54c3f9db6f5e;
        
        if ( pitch > 0 )
        {
            var_cbc3f3576bdab30 = ( 0, 0, height * var_92580e02e12ce9e9 );
            overwall = function_e906e4412952bc2c( var_cbc3f3576bdab30, var_ffd452d8823d297d, var_1e6ac553decd744a, radius, height, contents );
        }
        else
        {
            var_cbc3f3576bdab30 = ( 0, 0, height * var_7eb293f99986fc1e );
            overwall = function_e906e4412952bc2c( var_cbc3f3576bdab30, var_ffd452d8823d297d, var_1e6ac553decd744a, radius, height, contents );
            
            if ( !overwall )
            {
                if ( var_92580e02e12ce9e9 > var_7eb293f99986fc1e )
                {
                    var_cbc3f3576bdab30 = ( 0, 0, height * var_92580e02e12ce9e9 );
                    overwall = function_e906e4412952bc2c( var_cbc3f3576bdab30, var_ffd452d8823d297d, var_1e6ac553decd744a, radius, height, contents );
                }
            }
        }
    }
    else
    {
        var_1f88147aff6cd22c = self.teleportsuper.var_1e2e54c3f9db6f5e;
        var_cbc3f3576bdab30 = ( 0, 0, height * var_1f88147aff6cd22c );
        overwall = function_e906e4412952bc2c( var_cbc3f3576bdab30, var_ffd452d8823d297d, var_1e6ac553decd744a, radius, height, contents );
    }
    
    if ( !overwall )
    {
        return tracestart;
    }
    
    var_3e6a00b4236b575a = overwall - var_cbc3f3576bdab30;
    traceresult = trace::sphere_trace( overwall, var_3e6a00b4236b575a, radius, self, contents, undefined, undefined, self.var_7e640f474fd755ae );
    
    /#
        if ( getdvarint( @"hash_a2c87fd54857ae74", 0 ) == 1 )
        {
            sphere( overwall, radius, ( 0, 1, 0 ), 1, 1 );
            sphere( var_3e6a00b4236b575a, radius, ( 0, 1, 0 ), 1, 1 );
            line( overwall, var_3e6a00b4236b575a, ( 0, 1, 0 ), 1, 1, 1 );
            print3d( ( overwall + var_3e6a00b4236b575a ) * 0.5, "<dev string:xa1>", ( 0, 1, 0 ), 1, 0.1, 1, 1 );
        }
    #/
    
    if ( traceresult[ "fraction" ] == 1 )
    {
        return tracestart;
    }
    
    var_3e6a00b4236b575a = traceresult[ "shape_position" ];
    var_3e6a00b4236b575a += traceresult[ "normal" ] * ( radius + 1.5 );
    
    /#
        if ( getdvarint( @"hash_a2c87fd54857ae74", 0 ) == 1 )
        {
            sphere( var_3e6a00b4236b575a, radius, ( 1, 1, 1 ), 1, 1 );
            print3d( var_3e6a00b4236b575a, "<dev string:xb1>", ( 1, 1, 1 ), 1, 0.1, 1, 1 );
        }
    #/
    
    return var_3e6a00b4236b575a;
}

// Namespace teleport
// Params 6, eflags: 0x4
// Checksum 0x19f6305b, Offset: 0x1958
// Size: 0x210
function private function_e906e4412952bc2c( var_cbc3f3576bdab30, var_ffd452d8823d297d, var_1e6ac553decd744a, radius, height, contents )
{
    var_c41dca80a038f238 = var_ffd452d8823d297d + var_cbc3f3576bdab30;
    traceresult = trace::sphere_trace( var_ffd452d8823d297d, var_c41dca80a038f238, radius, self, contents, undefined, undefined, self.var_7e640f474fd755ae );
    
    /#
        if ( getdvarint( @"hash_a2c87fd54857ae74", 0 ) == 1 )
        {
            sphere( var_ffd452d8823d297d, radius, ( 1, 0, 0 ), 1, 1 );
            sphere( var_c41dca80a038f238, radius, ( 1, 0, 0 ), 1, 1 );
            line( var_ffd452d8823d297d, var_c41dca80a038f238, ( 1, 0, 0 ), 1, 1, 1 );
            print3d( ( var_ffd452d8823d297d + var_c41dca80a038f238 ) * 0.5, "<dev string:xc0>", ( 1, 0, 0 ), 1, 0.1, 1, 1 );
        }
    #/
    
    if ( traceresult[ "fraction" ] < 1 )
    {
        return;
    }
    
    var_c41dca80a038f238 = traceresult[ "shape_position" ];
    var_6cc40f43622a4ba3 = self.teleportsuper.var_e010aed38652293d + 1 + 1;
    overwall = var_c41dca80a038f238 + var_1e6ac553decd744a * -1 * radius * var_6cc40f43622a4ba3;
    traceresult = trace::sphere_trace( var_c41dca80a038f238, overwall, radius, self, contents, undefined, undefined, self.var_7e640f474fd755ae );
    
    /#
        if ( getdvarint( @"hash_a2c87fd54857ae74", 0 ) == 1 )
        {
            sphere( var_c41dca80a038f238, radius, ( 0, 0, 1 ), 1, 1 );
            sphere( overwall, radius, ( 0, 0, 1 ), 1, 1 );
            line( var_c41dca80a038f238, overwall, ( 0, 0, 1 ), 1, 1, 1 );
            print3d( ( var_c41dca80a038f238 + overwall ) * 0.5, "<dev string:xcb>", ( 0, 0, 1 ), 1, 0.1, 1, 1 );
        }
    #/
    
    if ( traceresult[ "fraction" ] < 1 )
    {
        return;
    }
    
    return traceresult[ "shape_position" ];
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xcdacb38d, Offset: 0x1b71
// Size: 0x44, Type: bool
function private function_a58c457912d7a94b()
{
    var_f89d6c2408bf2d29 = 5;
    
    do
    {
        var_ccd70caa2afdcc63 = self playermount();
        waitframe();
        
        if ( var_ccd70caa2afdcc63 == self playermount() )
        {
            var_f89d6c2408bf2d29--;
            
            if ( var_f89d6c2408bf2d29 <= 0 )
            {
                return false;
            }
        }
    }
    while ( var_ccd70caa2afdcc63 >= 0.1 );
    
    return true;
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xc8e314a0, Offset: 0x1bbe
// Size: 0x3ed
function private function_87e1fbaceba459f5()
{
    if ( self playermount() >= 0.1 )
    {
        mountfinished = function_a58c457912d7a94b();
        
        if ( !mountfinished )
        {
            return;
        }
    }
    
    direction = function_d5c329bb1c424c94();
    capsule = self getcollision( "stand" );
    radius = capsule.capsule_radius;
    height = capsule.capsule_halfheight + capsule.capsule_midpoint_height + capsule.capsule_radius;
    heightoffset = ( 0, 0, height / 2 );
    contents = function_91b0ee4ecf97a530();
    tracestart = self.teleportsuper.var_bb2de854becf0809 ? self getvieworigin() : self.origin + heightoffset;
    teleportdistance = self.teleportsuper.teleportdistance;
    
    if ( self.teleportsuper.var_ca1571891d35bf74 )
    {
        angles = self getplayerangles();
        pitch = abs( angleclamp180( angles[ 0 ] ) );
        
        if ( pitch < self.teleportsuper.var_9c3a2da46495210 )
        {
            cospitch = cos( pitch );
            var_fb80b1a3ef574afd = teleportdistance / ( cospitch ?? 1 );
        }
        else
        {
            sinpitch = sin( pitch );
            var_fb80b1a3ef574afd = self.teleportsuper.var_cfa8095f2d93cd86 / ( sinpitch ?? 1 );
        }
        
        traceend = tracestart + direction * var_fb80b1a3ef574afd;
    }
    else
    {
        traceend = tracestart + direction * teleportdistance;
    }
    
    traceresult = trace::sphere_trace( tracestart, traceend, 5, self, contents, undefined, 1, self.var_7e640f474fd755ae );
    traceend = traceresult[ "shape_position" ];
    ledgefound = 0;
    
    if ( traceresult[ "fraction" ] <= 0 )
    {
        return;
    }
    else if ( traceresult[ "fraction" ] < 1 )
    {
        traceend += traceresult[ "normal" ] * radius * 1;
        
        if ( self.teleportsuper.var_30358fc4ad8165b0 )
        {
            var_b02b8365439a369b = traceend;
            traceend = function_8cf8d093a498a07a( traceend, direction, traceresult, radius, height, contents );
            
            if ( traceend != var_b02b8365439a369b )
            {
                ledgefound = 1;
            }
        }
        
        /#
            if ( getdvarint( @"super_teleport_debug_trace", 0 ) == 1 )
            {
                sphere( tracestart, 5, ( 1, 0, 1 ), 1, 300 );
                sphere( traceend, 5, ( 1, 0, 1 ), 1, 300 );
                line( tracestart, traceend, ( 1, 0, 1 ), 1, 1, 300 );
            }
        #/
    }
    else if ( self.teleportsuper.var_6b8caa3cb6aad6c0 == 1 )
    {
        traceend = function_8c1bef03962996cb( tracestart + direction * teleportdistance, tracestart, radius, contents );
    }
    
    groundtraceend = function_f4070d1702e5394a( traceend, radius, contents );
    
    if ( self.teleportsuper.var_6b8caa3cb6aad6c0 == 2 && !ledgefound && !isvalidshapecast( groundtraceend ) )
    {
        groundtraceend = function_8c1bef03962996cb( tracestart + direction * teleportdistance, tracestart, radius, contents );
        groundtraceend = function_f4070d1702e5394a( groundtraceend, radius, contents );
    }
    
    if ( self.teleportmarker )
    {
        self.teleportmarker.origin = groundtraceend - ( 0, 0, radius );
        validtrace = isvalidshapecast( groundtraceend );
        function_bb103fd8787fdc2a( validtrace );
    }
    
    /#
        if ( getdvarint( @"super_teleport_debug_trace", 0 ) == 1 )
        {
            sphere( tracestart, radius, ( 1, 1, 1 ), 1, 1 );
            sphere( groundtraceend, radius, ( 0, 1, 1 ), 1, 1 );
        }
    #/
    
    return groundtraceend;
}

// Namespace teleport
// Params 1, eflags: 0x4
// Checksum 0xec1b78ed, Offset: 0x1fb4
// Size: 0xeb
function private function_bb103fd8787fdc2a( validtrace )
{
    assert( self.teleportmarker );
    
    if ( self.var_4c0a43faa8dfc7f8 && !validtrace )
    {
        self.teleportmarker setscriptablepartstate( self.teleportsuper.previewconfig.scriptablepart, self.teleportsuper.previewconfig.var_4f5f2e8fcdd7608d );
        self.var_4c0a43faa8dfc7f8 = 0;
        return;
    }
    
    if ( !self.var_4c0a43faa8dfc7f8 && validtrace )
    {
        self.teleportmarker setscriptablepartstate( self.teleportsuper.previewconfig.scriptablepart, self.teleportsuper.previewconfig.var_60fd44daef6f1af0 );
        self.var_4c0a43faa8dfc7f8 = 1;
    }
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xe8443cb5, Offset: 0x20a7
// Size: 0xbd
function private function_498193057dcbe7e1()
{
    var_91b5e03a7005bf3 = [];
    var_deb180b177fe5b43 = getentitylessscriptablearray( undefined, undefined, self.origin, self.teleportsuper.teleportdistance );
    
    foreach ( scriptable in var_deb180b177fe5b43 )
    {
        if ( scriptable function_9c6277f3d28901d5( #"hash_6e69d25330391e7f" ) )
        {
            var_91b5e03a7005bf3[ var_91b5e03a7005bf3.size ] = scriptable;
        }
    }
    
    return var_91b5e03a7005bf3;
}

// Namespace teleport
// Params 1, eflags: 0x4
// Checksum 0x33aab879, Offset: 0x216d
// Size: 0x12e, Type: bool
function private isvalidshapecast( var_56217c131fbd83ea )
{
    if ( getdvarint( @"hash_838f9e4dbe7cade6", 1 ) == 0 )
    {
        return true;
    }
    
    capsule = self getcollision( "stand" );
    radius = capsule.capsule_radius;
    viewheight = self getplayerviewheight();
    ground_pos = function_3fe38741460a4a49( var_56217c131fbd83ea );
    
    if ( ground_pos )
    {
        tracestart = self getvieworigin();
        traceend = ground_pos + ( 0, 0, viewheight );
        traceresult = trace::sphere_trace( tracestart, traceend, 1, self, function_91b0ee4ecf97a530(), undefined, undefined, self.var_7e640f474fd755ae );
        
        /#
            if ( getdvarint( @"super_teleport_debug_trace", 0 ) == 1 )
            {
                sphere( tracestart, radius, ( 1, 1, 0 ), 1, 400 );
                sphere( traceend, radius, ( 1, 1, 0 ), 1, 400 );
                line( tracestart, traceend, ( 1, 1, 0 ), 1, 1, 400 );
            }
        #/
        
        return ( traceresult[ "fraction" ] >= 1 );
    }
    
    return false;
}

// Namespace teleport
// Params 1, eflags: 0x4
// Checksum 0x5bb6ba91, Offset: 0x22a4
// Size: 0x94, Type: bool
function private teleportplayer( var_56217c131fbd83ea )
{
    if ( self.teleportsuper.var_77c3fcd83eaa668e )
    {
        thread function_416c02fb0f690fca();
    }
    
    self.var_e3481f14200a6c7d = gettime();
    function_bcb0ebecce438476();
    self freezecontrols( 1 );
    doteleport( var_56217c131fbd83ea );
    self.var_cf8af0d0f209d2bb = gettime();
    thread handleignoreme();
    function_d7f6f237e63935c6();
    function_44fb742853607576();
    
    if ( level.var_b7e70fa484e134dc )
    {
        thread supers_mp::superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, #"tactical" );
    }
    
    return true;
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xad16721c, Offset: 0x2341
// Size: 0xb4
function private function_bcb0ebecce438476()
{
    if ( self.teleportsuper.var_5755b7d6a9cf4422 )
    {
        function_eb2a579d22bbc41d( self.teleportsuper.teleportoverlay );
    }
    
    if ( self.teleportsuper.var_febcce0e80842c16.partname && self.teleportsuper.var_febcce0e80842c16.var_e50e4b0f3f98ae80 )
    {
        self setscriptablepartstate( self.teleportsuper.var_febcce0e80842c16.partname, self.teleportsuper.var_febcce0e80842c16.var_e50e4b0f3f98ae80 );
        waitframe();
    }
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0x6c9d45da, Offset: 0x23fd
// Size: 0xf5
function private function_d7f6f237e63935c6()
{
    if ( self.teleportsuper.var_5755b7d6a9cf4422 )
    {
        function_4273846c3c0bc9ba( self.teleportsuper.teleportoverlay );
    }
    
    if ( self.teleportsuper.enablefov )
    {
        self lerpfov( self.teleportsuper.var_3f073fc64763b109, self.teleportsuper.var_a38582499709f1f3 );
    }
    
    if ( self.teleportsuper.var_febcce0e80842c16.partname && self.teleportsuper.var_febcce0e80842c16.var_ef70ce6b97d70fdb )
    {
        self setscriptablepartstate( self.teleportsuper.var_febcce0e80842c16.partname, self.teleportsuper.var_febcce0e80842c16.var_ef70ce6b97d70fdb );
    }
}

// Namespace teleport
// Params 1, eflags: 0x4
// Checksum 0x257baad0, Offset: 0x24fa
// Size: 0xe8
function private function_3fe38741460a4a49( location )
{
    capsule = self getcollision( "stand" );
    playerradius = capsule.capsule_radius;
    var_75f1cb4221b1e78b = getdvarfloat( @"hash_df22bb83f8bd77a8", 50 );
    var_f82ce0e9683c213e = getdvarfloat( @"hash_8fa8f2a740a5123d", 500 );
    tracestart = location + ( 0, 0, var_75f1cb4221b1e78b );
    traceend = location - ( 0, 0, var_f82ce0e9683c213e );
    trace = trace::sphere_trace( tracestart, traceend, playerradius, undefined, function_91b0ee4ecf97a530(), undefined, undefined, self.var_7e640f474fd755ae );
    groundpos = undefined;
    
    if ( trace[ "fraction" ] > 0 && trace[ "fraction" ] < 1 )
    {
        groundpos = trace[ "shape_position" ] - ( 0, 0, playerradius );
    }
    
    return groundpos;
}

// Namespace teleport
// Params 2, eflags: 0x4
// Checksum 0x19464cb9, Offset: 0x25eb
// Size: 0x2b6
function private doteleport( var_56217c131fbd83ea, agentparams )
{
    reachableonly = 1;
    
    if ( agentparams.var_a9439e2cf5e4b13d )
    {
        reachableonly = 0;
    }
    
    var_f5661efe10a6d8d5 = getdvarint( @"hash_d5d0093c423f1235", 0 ) == 1;
    
    if ( agentparams.var_f5661efe10a6d8d5 )
    {
        var_f5661efe10a6d8d5 = 1;
    }
    
    startpos = self.origin;
    endpos = var_f5661efe10a6d8d5 ? getclosestpointonnavmesh( var_56217c131fbd83ea, self, 0, 0, 1, reachableonly ) : var_56217c131fbd83ea;
    var_3814ea19631a512f = function_18387330678e0c20( startpos, endpos );
    
    if ( var_3814ea19631a512f )
    {
        endpos = var_f5661efe10a6d8d5 ? getclosestpointonnavmesh( var_3814ea19631a512f, self, 0, 0, 1, reachableonly ) : var_3814ea19631a512f;
    }
    
    ground_pos = function_3fe38741460a4a49( endpos );
    
    if ( ground_pos )
    {
        if ( getdvarint( @"super_teleport_do_damage", 0 ) == 1 )
        {
            thread doradiusdamage();
        }
        
        /#
            if ( getdvarint( @"super_teleport_debug_trace", 0 ) == 1 )
            {
                capsule = self getcollision( "<dev string:xdc>" );
                playerradius = capsule.capsule_radius;
                var_75f1cb4221b1e78b = getdvarfloat( @"hash_df22bb83f8bd77a8", 50 );
                var_f82ce0e9683c213e = getdvarfloat( @"hash_8fa8f2a740a5123d", 500 );
                sphere( endpos + var_75f1cb4221b1e78b * ( 0, 0, 1 ), 1, ( 0, 1, 1 ), 1, 400 );
                line( endpos + var_75f1cb4221b1e78b * ( 0, 0, 1 ), endpos - var_f82ce0e9683c213e * 2 * ( 0, 0, 1 ), ( 1, 0, 1 ), 1, 1, 400 );
                sphere( endpos - var_f82ce0e9683c213e * ( 0, 0, 1 ), 1, ( 0, 1, 1 ), 1, 400 );
                sphere( ground_pos, playerradius, ( 0, 0, 1 ), 1, 400 );
                sphere( endpos, playerradius, ( 0, 1, 0 ), 1, 400 );
            }
        #/
    }
    else
    {
        if ( isplayer( self ) )
        {
            function_9b0065d6803f0742( self, &"hash_d4b2cd6a21eea6a" );
        }
        
        return;
    }
    
    if ( isagent( self ) )
    {
        assert( isdefined( agentparams.var_a140402d90c7afff ) );
        self forceteleport( ground_pos, self.angles, agentparams.var_a140402d90c7afff, 1 );
        self dontinterpolate();
    }
    else
    {
        self setorigin( ground_pos );
    }
    
    waitframe();
    function_9f6dbd4d3be549da( startpos, ground_pos );
    processtriggers( startpos, ground_pos );
}

// Namespace teleport
// Params 2, eflags: 0x4
// Checksum 0x331bf37c, Offset: 0x28a9
// Size: 0x41
function private function_9f6dbd4d3be549da( start_pos, end_pos )
{
    utility::callsharedfunc( "super_teleport", #"hash_548a96a46473e85f", { #end_pos:end_pos, #start_pos:start_pos } );
}

// Namespace teleport
// Params 0, eflags: 0xc
// Checksum 0x501874c2, Offset: 0x28f2
// Size: 0xb3
function private handleignoreme()
{
    self notify( #"hash_3d380734d615876b" );
    self endon( #"hash_3d380734d615876b" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !self.teleportsuper.var_64d2f0b4cddd6600 )
    {
        return;
    }
    
    ai::contribute_ignoreme( "super_teleport", 1 );
    
    if ( self.teleportsuper.var_c0f8266854da989d )
    {
        thread active_camo::function_32ebebc1e0f4707f();
    }
    
    wait self.teleportsuper.ignoremetime;
    ai::contribute_ignoreme( "super_teleport", 0 );
    
    if ( self.teleportsuper.var_c0f8266854da989d )
    {
        thread active_camo::active_camo_off();
    }
}

// Namespace teleport
// Params 2, eflags: 0x4
// Checksum 0xd346f1ac, Offset: 0x29ad
// Size: 0x3e
function private function_7df9666e6f0f41f8( startpos, endpos )
{
    contents = physics_createcontents( [ "physicscontents_trigger" ] );
    return physics_raycast( startpos, endpos, contents, undefined, 0, "physicsquery_all" );
}

// Namespace teleport
// Params 2, eflags: 0x4
// Checksum 0x9e3011ff, Offset: 0x29f4
// Size: 0xcd
function private function_18387330678e0c20( startpos, endpos )
{
    hitresult = function_7df9666e6f0f41f8( startpos, endpos );
    
    foreach ( hitentry in hitresult )
    {
        entity = hitentry[ "entity" ];
        
        if ( !entity )
        {
            continue;
        }
        
        if ( entity.script_noteworthy == "no_teleport" )
        {
            return getgroundposition( hitentry[ "position" ], 1 );
        }
    }
}

// Namespace teleport
// Params 2, eflags: 0x4
// Checksum 0x2ff7bfde, Offset: 0x2ac9
// Size: 0x126
function private processtriggers( startpos, endpos )
{
    hitresult = function_7df9666e6f0f41f8( startpos, endpos );
    
    foreach ( hitentry in hitresult )
    {
        if ( hitentry[ "entity" ] )
        {
            entity = hitentry[ "entity" ];
            
            if ( entity.script_noteworthy == "no_teleport" )
            {
                assertmsg( "<dev string:xe2>" + entity.name + "<dev string:xec>" + "<dev string:xff>" + "<dev string:x10b>" );
                return;
            }
            
            entity notify( #"trigger", self );
            continue;
        }
        
        if ( hitentry[ "noentvolume" ] )
        {
            volume = hitentry[ "noentvolume" ];
            volume notify( #"trigger", self );
        }
    }
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xdc9e0c6e, Offset: 0x2bf7
// Size: 0x43
function private function_416c02fb0f690fca()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.falldamageprotection = 1;
    wait self.teleportsuper.var_db956f760bc36830;
    self.falldamageprotection = 0;
}

// Namespace teleport
// Params 1, eflags: 0x4
// Checksum 0xac6f3e14, Offset: 0x2c42
// Size: 0x35
function private function_eb2a579d22bbc41d( overlayasset )
{
    utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:overlayasset }, 1, 1 );
}

// Namespace teleport
// Params 1, eflags: 0x4
// Checksum 0xea9ac170, Offset: 0x2c7f
// Size: 0x31
function private function_4273846c3c0bc9ba( overlayasset )
{
    utility::callsharedfunc( #"fullscreenfx", #"hash_494b07757cd511a5", { #postfxbundlename:overlayasset } );
}

// Namespace teleport
// Params 2, eflags: 0x4
// Checksum 0xb6eec941, Offset: 0x2cb8
// Size: 0x39
function private function_44fb742853607576( fromdeath, attacker )
{
    self notify( #"teleport_finished" );
    self freezecontrols( 0 );
    function_9d216e0a4cc27ddf();
    self.var_7e640f474fd755ae = undefined;
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0x706b433f, Offset: 0x2cf9
// Size: 0x83
function private function_9d216e0a4cc27ddf()
{
    if ( self.teleportsuper.var_febcce0e80842c16.partname && self.teleportsuper.var_febcce0e80842c16.stateoff )
    {
        self setscriptablepartstate( self.teleportsuper.var_febcce0e80842c16.partname, self.teleportsuper.var_febcce0e80842c16.stateoff );
    }
}

// Namespace teleport
// Params 1, eflags: 0x4
// Checksum 0x2f568d1e, Offset: 0x2d84
// Size: 0x13
function private onplayerspawned( params )
{
    function_44fb742853607576();
}

// Namespace teleport
// Params 1, eflags: 0x4
// Checksum 0xd373eb2a, Offset: 0x2d9f
// Size: 0x107
function private onplayerdeath( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    if ( !isdefined( params.eattacker.var_e3481f14200a6c7d ) )
    {
        return;
    }
    
    staticdata = level.superglobals.staticsuperdata[ "super_teleport" ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    bundle = staticdata.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( !isdefined( bundle.teleportdata ) )
    {
        return;
    }
    
    var_56bce9257505bb68 = gettime() - params.eattacker.var_e3481f14200a6c7d;
    var_73e040f97dfad343 = ( bundle.teleportdata.var_73e040f97dfad343 ?? 3 ) * 1000;
    
    if ( var_56bce9257505bb68 <= var_73e040f97dfad343 )
    {
        params.eattacker points::doscoreevent( #"super_teleport_kill" );
    }
}

// Namespace teleport
// Params 1, eflags: 0x4
// Checksum 0xa8847560, Offset: 0x2eae
// Size: 0x13
function private onplayerdisconnect( params )
{
    function_44fb742853607576();
}

// Namespace teleport
// Params 0, eflags: 0x4
// Checksum 0xd4858dd4, Offset: 0x2ec9
// Size: 0x1ad
function private doradiusdamage()
{
    self endon( #"teleport_finished" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    knockbackradius = 120;
    knockbackheight = 50;
    var_290ba0b087973044 = 100;
    damageamount = 250;
    earthquakescale = 0.4;
    earthquaketime = 0.5;
    earthquakeradius = 120;
    self radiusdamage( self.origin, var_290ba0b087973044, damageamount, damageamount, self, "MOD_EXPLOSIVE" );
    physicsexplosionsphere( self.origin, knockbackradius, var_290ba0b087973044, 1 );
    
    /#
        sphere( self.origin, knockbackradius, ( 1, 1, 1 ), 1, 200 );
    #/
    
    potentialtargets = utility::function_f754506ecfae9afb( self.origin, knockbackradius, undefined, knockbackheight, 0 );
    
    if ( !isdefined( potentialtargets ) )
    {
        return;
    }
    
    hitanyone = 0;
    
    foreach ( ent in potentialtargets )
    {
        if ( !isalive( ent ) || ent.team == self.team )
        {
            continue;
        }
        
        hitanyone = 1;
    }
    
    if ( hitanyone )
    {
        earthquake( earthquakescale, earthquaketime, self.origin, earthquakeradius );
    }
}

// Namespace teleport
// Params 0
// Checksum 0xe7612b89, Offset: 0x307e
// Size: 0x8
function function_fecaa5985cc1ba5f()
{
    return function_91b0ee4ecf97a530();
}

// Namespace teleport
// Params 1
// Checksum 0xee566fc, Offset: 0x308f
// Size: 0x21
function function_c33d160170c4d03( location )
{
    assert( isagent( self ) );
    return function_3fe38741460a4a49( location );
}

// Namespace teleport
// Params 2
// Checksum 0x794bf4cb, Offset: 0x30b9
// Size: 0x5b
function function_39fb9b6876d9527d( var_56217c131fbd83ea, var_a9439e2cf5e4b13d )
{
    assert( isagent( self ) );
    agentparams = { #var_a9439e2cf5e4b13d:var_a9439e2cf5e4b13d, #var_f5661efe10a6d8d5:1, #var_a140402d90c7afff:10000 };
    doteleport( var_56217c131fbd83ea, agentparams );
}

// Namespace teleport
// Params 0
// Checksum 0x5977a04f, Offset: 0x311c
// Size: 0x30, Type: bool
function function_29441fcf4c563596()
{
    if ( isplayer( self ) && self.var_e3481f14200a6c7d )
    {
        if ( gettime() - self.var_e3481f14200a6c7d < 1000 )
        {
            return true;
        }
    }
    
    return false;
}

