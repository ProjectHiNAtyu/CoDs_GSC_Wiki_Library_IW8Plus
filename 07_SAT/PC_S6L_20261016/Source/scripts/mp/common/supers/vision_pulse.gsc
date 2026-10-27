// scripts\mp\common\supers\vision_pulse.gsc  (hash_54dade64e2fcbdcf.gscc) (size: 23793 Bytes / 0x5cf1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43731b4f (1131617103)
// size ...... 23793 (0x5cf1)
// includes .. 16  (offset: 0x5a51)
// strings ... 26  (offset: 0x5ad1)
// dev strs .. 8   (offset: 0x5c91)
// exports ... 91  (offset: 0x35f9)
// cseg ...... 0x255 + 0x33a4 (0x35f9)
// imports ... 184 (offset: 0x4431)
// animtree1 . 0   (offset: 0x5cf1)
// animtree2 . 0   (offset: 0x5cf1)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\hud_util;
#using scripts\mp\supers;

#namespace vision_pulse;

// Namespace vision_pulse
// Params 0, eflags: 0x5
// Checksum 0xe9cdcba7, Offset: 0x273
// Size: 0x72
function private autoexec main()
{
    level callback::add( #"register_super", &register );
    utility::registersharedfunc( #"vision_pulse", #"hash_73baeda3c430f3b3", &function_60fc5db51617d1ba );
    utility::registersharedfunc( #"vision_pulse", #"hash_38470c19fcaf5542", &function_40ca10dce82de0f );
    utility::registersharedfunc( #"vision_pulse", #"hash_acb62b42896db66d", &function_475202a861cfbc70 );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xcd23375, Offset: 0x2ed
// Size: 0x8b
function private register( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vision_pulse" );
    
    if ( !bundle )
    {
        return;
    }
    
    level callback::add( #"player_death", &onplayerkilled );
    level callback::add( #"on_ai_killed", &onagentkilled );
    supers_mp::function_48aaa60b2ce7b8a1( "super_vision_pulse", undefined, undefined, &beginuse, &function_44fb742853607576 );
    supers_mp::function_19492daedcf2689a( "super_vision_pulse", &getusetime );
    disconnect_event_aggregator::function_f460203966e88ab0( &function_ce323339907d05fa );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xe2b06871, Offset: 0x380
// Size: 0x25
function private function_ce323339907d05fa( player )
{
    if ( player.var_56c65bfb13ade932 )
    {
        player function_44fb742853607576( 0, undefined );
    }
}

// Namespace vision_pulse
// Params 0, eflags: 0x4
// Checksum 0xc0e43cad, Offset: 0x3ad
// Size: 0x265, Type: bool
function private beginuse()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vision_pulse" );
    assert( isdefined( bundle ), "<dev string:x24>" );
    var_ccb0b54ebec8e385 = function_48ecc1b3dc185dc7( bundle );
    
    if ( !var_ccb0b54ebec8e385 )
    {
        return false;
    }
    
    overrideoutlines( bundle );
    detectiondata = { #var_2a4350fe4b336a6f:0, #var_d281a94dd26554e0:function_fbebfe56d1685008( bundle ), #var_76dc9f4e34f789a5:function_b4cee80f5a9fbd65( bundle ), #var_e6c6ac2a4bdb06a:function_950865278cddc52a( bundle ), #var_1bdc8b080965b6ae:function_93b8e3fa942deb63( bundle ), #showfootsteps:function_f4108b8557b2e8e7( bundle ), #origin:undefined, #currenthalfheight:0, #currentradius:0, #var_69bf4441da46d8c:0, #var_f6e9adc3ecc6f9b7:[] };
    self.var_56c65bfb13ade932 = detectiondata;
    function_e85c939967a798e2( detectiondata );
    function_7249848af9a0bd8f();
    function_de063961dbf0b0c7( bundle );
    function_f0d64ffe0dc95355( bundle );
    thread function_9d9ecdcace5ec03b( bundle, detectiondata );
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        assert( !callback::exists( #"super_cancel", &cancel ) );
        callback::add( #"super_cancel", &cancel );
    }
    
    zombie_utils::function_dfae6a5bd222c586( &function_63bd8f24b3cf6ce3 );
    agent_utils::function_bc89b9076dd93902( &function_63bd8f24b3cf6ce3 );
    assert( !callback::exists( #"hash_2346898712859996", &onplayerdamaged ) );
    callback::add( #"hash_2346898712859996", &onplayerdamaged );
    squadmates = squad_utility::getsquadmembers( self.team, 1 );
    
    foreach ( ally in squadmates )
    {
        if ( ally != self )
        {
            ally zombie_utils::function_dfae6a5bd222c586( &function_eedc44033d765d3b );
            ally agent_utils::function_bc89b9076dd93902( &function_eedc44033d765d3b );
        }
    }
    
    callback::add( #"hash_e8b4ec317feca9a8", &function_610fe043d1b5d3a );
    return true;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xf0f2ba55, Offset: 0x61b
// Size: 0x24
function private cancel( params )
{
    self notify( #"cancel_vision_pulse" );
    supers_mp::reducesuperusepercent( 1 );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x2432be43, Offset: 0x647
// Size: 0x66
function private overrideoutlines( bundle )
{
    self.var_f547ec965235d71a = { #var_b5f2b371930434fa:bundle.var_c7342a78c0c92f1, #var_6086d3a2d535eb59:bundle.var_3b87be1ed8574bc6, #var_d0e792802af67048:bundle.var_414af98ea5ae561f, #var_c6cabf9b368038db:bundle.var_b4125743e608ff40 };
}

// Namespace vision_pulse
// Params 0, eflags: 0x4
// Checksum 0x5ff595, Offset: 0x6b5
// Size: 0xc
function private function_ffee69d037f04239()
{
    self.var_f547ec965235d71a = undefined;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xc1bb92b3, Offset: 0x6c9
// Size: 0xad
function private function_48ecc1b3dc185dc7( bundle )
{
    usehudelem = getdvarint( @"hash_f8ce3eeb71a4cba3", 0 );
    transitionresult = 1;
    
    if ( usehudelem )
    {
        var_947bb4706c5ccfaa = hud_util::function_cd054751d2d5b5c5( "black" );
        transitionresult = var_947bb4706c5ccfaa hud_util::function_d69ae82e9a4716aa( self, 0.1, 0, 0.1, 1 );
    }
    else if ( bundle.var_fd08451c352d749b )
    {
        utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:bundle.var_fd08451c352d749b }, 1, 1 );
    }
    
    return transitionresult;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xfcd4f4ae, Offset: 0x77f
// Size: 0x1b, Type: bool
function private function_f4108b8557b2e8e7( superbundle )
{
    return superbundle.var_5b7cebab30152661 ?? 0;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x3092c000, Offset: 0x7a3
// Size: 0x1b, Type: bool
function private function_93b8e3fa942deb63( superbundle )
{
    return superbundle.var_d017655b472f8ca1 ?? 0;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x2d5c57b4, Offset: 0x7c7
// Size: 0x2e, Type: bool
function private function_950865278cddc52a( superbundle )
{
    return utility::callsharedfunc( "super_vision_pulse", #"hash_4dde45b2dd2ee40b" ) ?? superbundle.var_30ce8da72c0745ef;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x39947cf2, Offset: 0x7fe
// Size: 0x2e, Type: bool
function private function_b4cee80f5a9fbd65( superbundle )
{
    return utility::callsharedfunc( "super_vision_pulse", #"hash_295417749f5b26a0" ) ?? superbundle.var_992ef2a56274244;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xd137ee75, Offset: 0x835
// Size: 0x17
function private function_fbebfe56d1685008( superbundle )
{
    return superbundle.var_3adbcaed001bfc55;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x32907588, Offset: 0x855
// Size: 0x40
function private function_e85c939967a798e2( detectiondata )
{
    if ( detectiondata.showfootsteps )
    {
        perk::giveperk( "specialty_tracker_pro" );
        
        if ( detectiondata.var_1bdc8b080965b6ae )
        {
            perk::giveperk( "specialty_tracker_pro_short" );
        }
    }
}

// Namespace vision_pulse
// Params 0, eflags: 0x4
// Checksum 0x87426d79, Offset: 0x89d
// Size: 0x33
function private function_7249848af9a0bd8f()
{
    if ( function_4a5d35da42987281() )
    {
        perk::giveperk( "specialty_ads_ping" );
        self.var_6c5652205888d74 = &function_2d151a6a490ae745;
        self.var_c008b0c65e668f56 = &function_f92200e3b6eb7b53;
    }
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0x66097355, Offset: 0x8d8
// Size: 0x79
function private function_dc1df824f81948c4( isvisible, bundle )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !self isscriptable() || !self getscriptablehaspart( bundle.var_8221dbb081dc2d88 ) )
    {
        return;
    }
    
    statename = isvisible ? bundle.var_701eeddd458c42d2 : bundle.var_f6f24cf075e78522;
    self setscriptablepartstate( bundle.var_8221dbb081dc2d88, statename, 0 );
}

// Namespace vision_pulse
// Params 0, eflags: 0x4
// Checksum 0xf36761bb, Offset: 0x959
// Size: 0x3, Type: bool
function private function_6dd7636e375b189a()
{
    return false;
}

// Namespace vision_pulse
// Params 4, eflags: 0x4
// Checksum 0x26a19d6b, Offset: 0x965
// Size: 0xc7
function private function_67dbee5f55f0f6af( compassradius, var_bfad811bac7c2ef3, var_dcdee59330786db9, var_253099ab2d108015 )
{
    var_d1dbfb20b50d69d4 = level.var_b72c376264827891[ "super_vision_pulse" ];
    var_a45c5f4e38a548d5 = function_43b5ed5a14a56573( #"scriptbundle_super", var_d1dbfb20b50d69d4 );
    self setclientomnvar( "radar_ping", var_a45c5f4e38a548d5 );
    self.radarpingstate = 0;
    var_379ea78c49a48f21 = function_6dd7636e375b189a();
    
    if ( var_379ea78c49a48f21 )
    {
        function_8f96afa046010e4f( self.origin, self.sessionsquadid, compassradius, var_bfad811bac7c2ef3, -1, var_dcdee59330786db9, var_253099ab2d108015, 1 );
        return;
    }
    
    triggerportableradarping( self.origin, self, compassradius, var_bfad811bac7c2ef3, "", var_dcdee59330786db9, 1, 0 );
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0x3044f85f, Offset: 0xa34
// Size: 0x204
function private function_9d9ecdcace5ec03b( bundle, detectiondata )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_441ddcaf3a5dbee5" );
    pulsecount = function_f46d2e810f2aee9a( bundle );
    var_43cb1c27a49e2dd3 = function_303e6b18a2f71917( bundle );
    var_5d9c56c30dd9182c = function_e911f2e7ce476e39( bundle ) * 1000;
    radius = int( function_7cbbfccbdab9bba9( bundle ) );
    var_bfad811bac7c2ef3 = int( function_fd474d27ea3c9a54( bundle ) * 1000 );
    var_dcdee59330786db9 = function_e911f2e7ce476e39( bundle );
    goalhalfheight = function_8f523f8d90944ef5( bundle );
    doradarping = bundle.var_8977a5bcd893f18e ?? 1;
    pulsefxid = utility::getfx( "vision_pulse_radius_fx" );
    var_553c6ec8945a0edd = 1;
    var_42ee2cbea1b50cbf = 0;
    thread function_bc0a2b02ce56ec0b( detectiondata, bundle );
    
    while ( true )
    {
        if ( var_553c6ec8945a0edd )
        {
            var_553c6ec8945a0edd = 0;
        }
        else
        {
            self waittill( #"hash_ac9044f9a88a2c1a", offsetpercentage );
            var_42ee2cbea1b50cbf++;
            function_c1893fb18cb4a23f( bundle, offsetpercentage );
        }
        
        for ( pulseindex = 0; pulseindex < pulsecount ; pulseindex++ )
        {
            detectiondata.var_69bf4441da46d8c = pulseindex + var_42ee2cbea1b50cbf * pulsecount;
            detectiondata.origin = self.origin;
            thread function_b4a300287bfd7aec( pulsefxid, 2 );
            thread function_2a29f136d9023c51( detectiondata, radius, goalhalfheight, var_bfad811bac7c2ef3 );
            thread function_7aa2e337112ed115( detectiondata, bundle, var_5d9c56c30dd9182c );
            thread function_209aa5a362be812c( var_5d9c56c30dd9182c );
            
            if ( doradarping )
            {
                function_67dbee5f55f0f6af( radius, var_bfad811bac7c2ef3, var_dcdee59330786db9, radius );
            }
            
            /#
                if ( false )
                {
                    thread debugradius( detectiondata );
                    thread function_333b0e312c16a7( detectiondata );
                }
            #/
            
            wait var_43cb1c27a49e2dd3;
            self notify( #"hash_e88df886d8c5f653" );
        }
    }
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0x94d33a62, Offset: 0xc40
// Size: 0xa5
function private function_b4a300287bfd7aec( effectid, timeout )
{
    var_ca6c7dcca4b19056 = getdvarint( @"hash_471fbc1aeee6111a", 0 );
    
    if ( var_ca6c7dcca4b19056 )
    {
        self setscriptablepartstate( #"vision_pulse_fx", #"super_fx_on", 0 );
        return;
    }
    
    level endon( #"game_ended" );
    
    if ( !isdefined( effectid ) )
    {
        return;
    }
    
    playfxontag( effectid, self, "tag_origin" );
    utility::waittill_any_in_array_or_timeout( [ "death", "disconnect", "cancel_vision_pulse" ], timeout );
    
    if ( self )
    {
        stopfxontag( effectid, self, "tag_origin" );
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xd66d1be3, Offset: 0xced
// Size: 0x1b, Type: bool
function private function_f46d2e810f2aee9a( superbundle )
{
    return superbundle.var_692911c4a24c33 ?? 0;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xca2dab66, Offset: 0xd11
// Size: 0x1b, Type: bool
function private function_7cbbfccbdab9bba9( superbundle )
{
    return superbundle.visionpulseradius ?? 0;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x1037a976, Offset: 0xd35
// Size: 0x1b, Type: bool
function private function_fd474d27ea3c9a54( superbundle )
{
    return superbundle.var_eefeeff1266c63ee ?? 0;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x7957eb98, Offset: 0xd59
// Size: 0x1b, Type: bool
function private function_8f523f8d90944ef5( superbundle )
{
    return superbundle.visionpulsehalfheight ?? 0;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x66892cb4, Offset: 0xd7d
// Size: 0x1b, Type: bool
function private function_e911f2e7ce476e39( superbundle )
{
    return superbundle.var_47669d6c5cf054c3 ?? 0;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xe5959527, Offset: 0xda1
// Size: 0x1b, Type: bool
function private function_303e6b18a2f71917( superbundle )
{
    return superbundle.var_8263c8acc3f6a060 ?? 0;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xf92c9ae9, Offset: 0xdc5
// Size: 0x71
function private function_aa2661b79093e3a7( superbundle )
{
    detectiontime = function_e911f2e7ce476e39( superbundle );
    sweeptime = function_fd474d27ea3c9a54( superbundle );
    var_43cb1c27a49e2dd3 = function_303e6b18a2f71917( superbundle );
    var_19e8183685f4c5f5 = max( 0, sweeptime - var_43cb1c27a49e2dd3 );
    var_afee8a14b990c156 = max( 0, detectiontime - var_43cb1c27a49e2dd3 );
    return max( var_19e8183685f4c5f5, var_afee8a14b990c156 );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xb2aa69ce, Offset: 0xe3f
// Size: 0x57
function private getusetime( superinfo )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vision_pulse" );
    pulseduration = function_63234f6ab190a60f( bundle );
    pulseoffset = function_aa2661b79093e3a7( bundle );
    totalduration = pulseduration + pulseoffset;
    return totalduration;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x49e1ddc, Offset: 0xe9f
// Size: 0x36
function private function_63234f6ab190a60f( bundle )
{
    pulsecount = function_f46d2e810f2aee9a( bundle );
    var_43cb1c27a49e2dd3 = function_303e6b18a2f71917( bundle );
    return pulsecount * var_43cb1c27a49e2dd3;
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0x71e22a9, Offset: 0xede
// Size: 0xa7
function private function_c1893fb18cb4a23f( bundle, offsetperc )
{
    if ( !offsetperc )
    {
        return;
    }
    
    superinfo = supers_mp::getcurrentsuper();
    pulseduration = function_63234f6ab190a60f( bundle );
    pulseoffset = function_aa2661b79093e3a7( bundle );
    superduration = pulseduration + pulseoffset;
    currduration = superinfo.usepercent * superduration;
    wantedduration = pulseduration + pulseoffset * offsetperc;
    
    if ( currduration > wantedduration )
    {
        return;
    }
    
    totalduration = wantedduration - currduration;
    supers_mp::function_55f1ba3202014e0b( totalduration );
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0xf5074eb8, Offset: 0xf8d
// Size: 0x1bf
function private function_44fb742853607576( fromdeath, attacker )
{
    self notify( #"hash_441ddcaf3a5dbee5" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vision_pulse" );
    cleanup( self.var_56c65bfb13ade932, bundle );
    self.var_56c65bfb13ade932 = undefined;
    self.radarpingstate = undefined;
    thread function_3d7428c1f2d0dfce( bundle );
    function_5a7cc3a5bb0ea46f( 0 );
    function_575d46a1be312d63();
    function_ffee69d037f04239();
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        assert( callback::exists( #"super_cancel", &cancel ) );
        callback::remove( #"super_cancel", &cancel );
    }
    
    zombie_utils::function_10c0c35c21e3ed9d( &function_63bd8f24b3cf6ce3 );
    agent_utils::function_def5273cfe3c9109( &function_63bd8f24b3cf6ce3 );
    assert( callback::exists( #"hash_2346898712859996", &onplayerdamaged ) );
    callback::remove( #"hash_2346898712859996", &onplayerdamaged );
    squadmates = squad_utility::getsquadmembers( self.team, 1 );
    
    foreach ( ally in squadmates )
    {
        if ( ally != self )
        {
            ally zombie_utils::function_10c0c35c21e3ed9d( &function_eedc44033d765d3b );
            ally agent_utils::function_def5273cfe3c9109( &function_eedc44033d765d3b );
        }
    }
    
    callback::remove( #"hash_e8b4ec317feca9a8", &function_610fe043d1b5d3a );
}

// Namespace vision_pulse
// Params 4, eflags: 0x4
// Checksum 0x59da6c8e, Offset: 0x1154
// Size: 0x11a
function private function_2a29f136d9023c51( detectiondata, goalradius, goalhalfheight, var_bfad811bac7c2ef3 )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_e88df886d8c5f653" );
    self endon( #"hash_441ddcaf3a5dbee5" );
    var_d6caa41129dd6cb1 = gettime();
    detectiondata.sweepinprogress = 1;
    
    while ( true )
    {
        currenttimems = gettime();
        elapsedtimems = clamp( currenttimems - var_d6caa41129dd6cb1, 0, var_bfad811bac7c2ef3 );
        var_31078e9a0e866c25 = elapsedtimems / var_bfad811bac7c2ef3;
        detectiondata.currentradius = math::lerp( 0, goalradius, var_31078e9a0e866c25 );
        detectiondata.currenthalfheight = math::lerp( 0, goalhalfheight, var_31078e9a0e866c25 );
        function_e37ec34bd8c266e8( detectiondata.currentradius );
        
        if ( elapsedtimems >= var_bfad811bac7c2ef3 )
        {
            break;
        }
        
        waitframe();
    }
    
    detectiondata.sweepinprogress = undefined;
    self notify( #"hash_33aa3999e3cd8ad7" );
}

// Namespace vision_pulse
// Params 3, eflags: 0x4
// Checksum 0x9d79273, Offset: 0x1276
// Size: 0xfa
function private function_7aa2e337112ed115( detectiondata, superbundle, detectiontime )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_33aa3999e3cd8ad7" );
    self endon( #"hash_e88df886d8c5f653" );
    self endon( #"hash_441ddcaf3a5dbee5" );
    shownameplates = function_17478a06da5996d2();
    
    while ( true )
    {
        function_f9af6e34a0bf0867( detectiondata, detectiontime, superbundle.var_44b331d6dc67d47e, superbundle.var_2891955a880f6313, superbundle );
        function_1acdbbfc90244459( detectiondata, detectiontime, superbundle.var_e0de652c5755aa82, superbundle.var_bbc271b409da31fd, superbundle );
        function_b45599de31fd1a3f( detectiondata, detectiontime, superbundle.var_d93dcc613a97701c, superbundle.var_cf826b1ab9b6d66b, superbundle );
        
        if ( shownameplates )
        {
            function_509f98d24f4795b4( detectiondata );
        }
        
        wait 0.2;
    }
}

// Namespace vision_pulse
// Params 5, eflags: 0x4
// Checksum 0xf3f8fff7, Offset: 0x1378
// Size: 0x7f
function private function_f9af6e34a0bf0867( detectiondata, detectiontime, outlineasset, detectionsoundid, superbundle )
{
    playersinrange = function_7e5143f935847484( detectiondata );
    detectiondata.var_f6e9adc3ecc6f9b7 = function_5972ac9c59591a0c( detectiondata.var_69bf4441da46d8c, playersinrange, detectiondata.var_f6e9adc3ecc6f9b7, detectiontime, outlineasset, detectionsoundid, superbundle, detectiondata.var_d281a94dd26554e0 );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xb896c3e4, Offset: 0x13ff
// Size: 0xe1
function private function_7e5143f935847484( detectiondata )
{
    ishudhidden = self getclientomnvar( "ui_hide_hud" ) == 1;
    
    if ( ishudhidden )
    {
        return [];
    }
    
    enemyplayersinrange = utility::playersincylinder( detectiondata.origin, detectiondata.currentradius, self, detectiondata.currenthalfheight, self.team );
    
    foreach ( idx, enemy in enemyplayersinrange )
    {
        if ( !player::isreallyalive( enemy ) )
        {
            enemyplayersinrange[ idx ] = undefined;
        }
    }
    
    return enemyplayersinrange;
}

// Namespace vision_pulse
// Params 5, eflags: 0x4
// Checksum 0x22e43c1d, Offset: 0x14e9
// Size: 0x7f
function private function_1acdbbfc90244459( detectiondata, detectiontime, outlineasset, detectionsoundid, superbundle )
{
    aiinrange = function_cad7493f234c9c( detectiondata );
    detectiondata.var_f6e9adc3ecc6f9b7 = function_5972ac9c59591a0c( detectiondata.var_69bf4441da46d8c, aiinrange, detectiondata.var_f6e9adc3ecc6f9b7, detectiontime, outlineasset, detectionsoundid, superbundle, detectiondata.var_d281a94dd26554e0 );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xc7dbbab3, Offset: 0x1570
// Size: 0x15e
function private function_cad7493f234c9c( detectiondata )
{
    ishudhidden = self getclientomnvar( "ui_hide_hud" ) == 1;
    
    if ( ishudhidden )
    {
        return [];
    }
    
    aiinrange = getaiarrayinradius( detectiondata.origin, detectiondata.currentradius );
    
    foreach ( idx, ai in aiinrange )
    {
        isenemy = ai.team != self.team && ai.team != "neutral";
        isspawning = ai utility::ent_flag( "spawn_animating" );
        
        if ( !isenemy || isspawning )
        {
            aiinrange[ idx ] = undefined;
        }
        
        var_1ab61fcd44b13acd = abs( ai.origin[ 2 ] - detectiondata.origin[ 2 ] );
        
        if ( var_1ab61fcd44b13acd > detectiondata.currenthalfheight )
        {
            aiinrange[ idx ] = undefined;
        }
    }
    
    aiinrange = function_5713d46873b29625( aiinrange );
    return aiinrange;
}

// Namespace vision_pulse
// Params 5, eflags: 0x4
// Checksum 0x54c82a76, Offset: 0x16d7
// Size: 0x74
function private function_b45599de31fd1a3f( detectiondata, detectiontime, outlineasset, detectionsoundid, superbundle )
{
    var_90d80f874514e662 = function_1d22f865063b74fa( detectiondata );
    detectiondata.var_f6e9adc3ecc6f9b7 = function_5972ac9c59591a0c( detectiondata.var_69bf4441da46d8c, var_90d80f874514e662, detectiondata.var_f6e9adc3ecc6f9b7, detectiontime, outlineasset, detectionsoundid, superbundle );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x744d089d, Offset: 0x1753
// Size: 0x154
function private function_1d22f865063b74fa( detectiondata )
{
    var_90d80f874514e662 = [];
    playerorigin = self.origin;
    var_dc0316782de20078 = [ self.var_3f3b99223d20a25d, level.var_3f3b99223d20a25d ];
    
    foreach ( var_271719a8e8e435db in var_dc0316782de20078 )
    {
        foreach ( entity in var_271719a8e8e435db )
        {
            var_f301e7854da18e2f = distance( playerorigin, entity.origin );
            
            if ( var_f301e7854da18e2f <= detectiondata.currentradius )
            {
                var_90d80f874514e662[ var_90d80f874514e662.size ] = entity;
            }
        }
    }
    
    return var_90d80f874514e662;
}

// Namespace vision_pulse
// Params 8, eflags: 0x4
// Checksum 0xcf0f0390, Offset: 0x18b0
// Size: 0x2ed
function private function_5972ac9c59591a0c( var_69bf4441da46d8c, entitiesinrange, var_7291f375f3d22b1c, detectiontime, outlineasset, detectionsoundid, superbundle, var_d281a94dd26554e0 )
{
    var_d9f524b49b6b73b9 = var_7291f375f3d22b1c;
    var_70747d9716f4cec6 = var_7291f375f3d22b1c.size;
    var_ce338aed9e7dc539 = 0;
    
    foreach ( entity in entitiesinrange )
    {
        entitynumber = entity getentitynumber();
        var_fb5c1ccc247d556f = var_d9f524b49b6b73b9[ entitynumber ];
        
        if ( !var_fb5c1ccc247d556f && function_987e4f417167c089( var_d281a94dd26554e0, var_70747d9716f4cec6 ) )
        {
            var_70747d9716f4cec6++;
            squadmates = squad_utility::getsquadmembers( self.team, 1 );
            
            foreach ( ally in squadmates )
            {
                if ( !entity.var_a11d8ac76c2a441e || arraycontains( entity.var_a11d8ac76c2a441e, ally ) )
                {
                    ally enableoutline( entity, outlineasset );
                }
            }
            
            function_6b6e6a35c012d8d2( entity, detectionsoundid, superbundle.var_27ddfa9510bb32c5 );
            
            if ( superbundle.var_4a3cc06ad373afbb )
            {
                entity function_dc1df824f81948c4( 1, superbundle );
            }
            
            var_e4721a15f3c11043 = { #var_97034014d6af8b16:gettime() + detectiontime, #var_e5bb3801710ecd9a:var_69bf4441da46d8c, #entity:entity };
            var_d9f524b49b6b73b9[ entitynumber ] = var_e4721a15f3c11043;
            
            if ( !isdefined( entity.var_b52498c11832e4ea ) )
            {
                entity.var_b52498c11832e4ea = [];
            }
            
            entity.var_b52498c11832e4ea[ entity.var_b52498c11832e4ea.size ] = self getentitynumber();
            entity.var_8bf8675d01bdec8b = 1;
            function_d661cabfe52392b0( entity );
            thread function_20beaf9a482b51f7( entity, var_e4721a15f3c11043 );
        }
        else if ( var_fb5c1ccc247d556f )
        {
            var_fb5c1ccc247d556f = var_d9f524b49b6b73b9[ entitynumber ];
            
            if ( var_fb5c1ccc247d556f.var_e5bb3801710ecd9a < var_69bf4441da46d8c )
            {
                function_6b6e6a35c012d8d2( entity, detectionsoundid, superbundle.var_27ddfa9510bb32c5 );
                var_fb5c1ccc247d556f.var_e5bb3801710ecd9a = var_69bf4441da46d8c;
                var_fb5c1ccc247d556f.var_97034014d6af8b16 = gettime() + detectiontime;
            }
        }
        
        var_ce338aed9e7dc539++;
        
        if ( var_ce338aed9e7dc539 % 10 == 0 )
        {
            var_ce338aed9e7dc539 = 0;
            waitframe();
            
            if ( !isdefined( self ) )
            {
                return;
            }
        }
    }
    
    return var_d9f524b49b6b73b9;
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0x65a6cf32, Offset: 0x1ba6
// Size: 0x29, Type: bool
function private function_987e4f417167c089( var_d281a94dd26554e0, var_70747d9716f4cec6 )
{
    if ( !var_d281a94dd26554e0 )
    {
        return true;
    }
    
    if ( var_70747d9716f4cec6 < var_d281a94dd26554e0 )
    {
        return true;
    }
    
    return false;
}

// Namespace vision_pulse
// Params 3, eflags: 0x4
// Checksum 0xa7751f21, Offset: 0x1bd8
// Size: 0x31
function private function_6b6e6a35c012d8d2( entity, detectionsoundid, scoreevent )
{
    function_ffa0ae985d6ca43a( entity, detectionsoundid );
    namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( scoreevent );
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0x61232867, Offset: 0x1c11
// Size: 0x25
function private function_ffa0ae985d6ca43a( entity, soundid )
{
    if ( soundid )
    {
        self playsoundtoplayer( soundid, self, entity );
    }
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0xd540760, Offset: 0x1c3e
// Size: 0xf8
function private function_bc0a2b02ce56ec0b( detectiondata, bundle )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_441ddcaf3a5dbee5" );
    shownameplates = function_17478a06da5996d2();
    
    while ( true )
    {
        foreach ( entitynumber, var_b56d7513c17407e0 in detectiondata.var_f6e9adc3ecc6f9b7 )
        {
            if ( function_7ec4f440570d67b0( var_b56d7513c17407e0 ) )
            {
                function_7836361bee97dd7( var_b56d7513c17407e0.entity, entitynumber, detectiondata, shownameplates, bundle );
            }
        }
        
        wait 0.2;
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xea2ff065, Offset: 0x1d3e
// Size: 0x5f, Type: bool
function private function_7ec4f440570d67b0( var_b56d7513c17407e0 )
{
    currenttime = gettime();
    
    if ( currenttime > var_b56d7513c17407e0.var_97034014d6af8b16 )
    {
        return true;
    }
    
    entity = var_b56d7513c17407e0.entity;
    
    if ( isplayer( entity ) && !player::isreallyalive( entity ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vision_pulse
// Params 5, eflags: 0x4
// Checksum 0x2544f55c, Offset: 0x1da6
// Size: 0x16a
function private function_7836361bee97dd7( entity, entitynumber, detectiondata, shownameplates, superbundle )
{
    if ( shownameplates )
    {
        function_c55ecad643dbb3e3( detectiondata );
    }
    
    detectiondata.var_f6e9adc3ecc6f9b7[ entitynumber ] = undefined;
    
    if ( entity.var_b52498c11832e4ea )
    {
        entity.var_b52498c11832e4ea = arrayremove( entity.var_b52498c11832e4ea, self getentitynumber() );
        
        if ( entity.var_b52498c11832e4ea.size == 0 )
        {
            entity.var_b52498c11832e4ea = undefined;
        }
    }
    
    if ( !entity.var_b52498c11832e4ea )
    {
        fadeoutoutline = function_e547d40bdae197a6( entity, superbundle );
        squadmates = squad_utility::getsquadmembers( self.team, 1 );
        
        foreach ( ally in squadmates )
        {
            ally disableoutline( entity, fadeoutoutline );
        }
        
        if ( superbundle.var_4a3cc06ad373afbb )
        {
            entity function_dc1df824f81948c4( 0, superbundle );
        }
        
        function_172933ed8acca90f( entity );
    }
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0xe71c2360, Offset: 0x1f18
// Size: 0x70
function private function_20beaf9a482b51f7( entity, var_e4721a15f3c11043 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_441ddcaf3a5dbee5" );
    entity endon( #"death" );
    entity waittill( #"hash_dc4359f8a6eb1cab" );
    var_e4721a15f3c11043.var_97034014d6af8b16 = gettime();
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x7e77736f, Offset: 0x1f90
// Size: 0x3c
function private function_d661cabfe52392b0( entity )
{
    if ( !isagent( entity ) )
    {
        return;
    }
    
    if ( entity.var_b52498c11832e4ea.size == 1 )
    {
        entity callback::add( "on_turned", &function_cb2203e9d122a1d4 );
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x699c5183, Offset: 0x1fd4
// Size: 0x3e
function private function_172933ed8acca90f( entity )
{
    if ( !isagent( entity ) )
    {
        return;
    }
    
    assert( !entity.var_b52498c11832e4ea );
    entity callback::remove( "on_turned", &function_cb2203e9d122a1d4 );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x69703c4e, Offset: 0x201a
// Size: 0x18
function private function_cb2203e9d122a1d4( params )
{
    self notify( #"hash_dc4359f8a6eb1cab" );
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0xbe1105ea, Offset: 0x203a
// Size: 0x5d
function private function_e547d40bdae197a6( entity, superbundle )
{
    if ( !superbundle.var_e4c01304d26401e )
    {
        return;
    }
    
    if ( isplayer( entity ) )
    {
        return superbundle.var_86c490cd71bfb82c;
    }
    else if ( isagent( entity ) )
    {
        return superbundle.var_879f98e2701f4b68;
    }
    
    return superbundle.var_2db6680f9c17020e;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x9ee02ac2, Offset: 0x20a0
// Size: 0xa6, Type: bool
function private function_2d151a6a490ae745( entity )
{
    detectiondata = self.var_56c65bfb13ade932;
    
    foreach ( var_b56d7513c17407e0 in detectiondata.var_f6e9adc3ecc6f9b7 )
    {
        if ( var_b56d7513c17407e0.entity == entity )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0x8e58b28a, Offset: 0x214f
// Size: 0x64
function private enableoutline( entity, outlineasset )
{
    if ( outlineasset )
    {
        entnum = entity getentitynumber();
        
        if ( self.var_35c4b20f8d18d70b[ entnum ] )
        {
            return;
        }
        
        outlineid = outline::outlineenableforplayer( entity, self, outlineasset, "killstreak_personal" );
        self.var_35c4b20f8d18d70b[ entnum ] = outlineid;
    }
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0xfcfe2aa9, Offset: 0x21bb
// Size: 0x6a
function private disableoutline( entity, fadeoutoutline )
{
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    entnum = entity getentitynumber();
    outlineid = self.var_35c4b20f8d18d70b[ entnum ];
    
    if ( outlineid )
    {
        thread function_5daf922b5483c793( entity, fadeoutoutline );
        outline::outlinedisable( outlineid, entity );
        self.var_35c4b20f8d18d70b[ entnum ] = undefined;
    }
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0xe474b42e, Offset: 0x222d
// Size: 0x77
function private function_5daf922b5483c793( entity, fadeoutoutline )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( fadeoutoutline )
    {
        fadeoutid = outline::outlineenableforplayer( entity, self, fadeoutoutline, "killstreak_personal" );
        
        if ( fadeoutid )
        {
            utility::waittill_notify_or_timeout( "cancel_vision_pulse", 5 );
            outline::outlinedisable( fadeoutid, entity );
        }
    }
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0xc17c2d07, Offset: 0x22ac
// Size: 0xca
function private cleanup( detectiondata, bundle )
{
    shownameplates = function_17478a06da5996d2();
    
    foreach ( entitynumber, var_b56d7513c17407e0 in detectiondata.var_f6e9adc3ecc6f9b7 )
    {
        function_7836361bee97dd7( var_b56d7513c17407e0.entity, entitynumber, detectiondata, shownameplates, bundle );
    }
    
    detectiondata.var_f6e9adc3ecc6f9b7 = undefined;
    function_beaf85b923e22148( detectiondata );
    function_bc6466c204450c05();
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x8079372f, Offset: 0x237e
// Size: 0x40
function private function_beaf85b923e22148( detectiondata )
{
    if ( detectiondata.showfootsteps )
    {
        perk::removeperk( "specialty_tracker_pro" );
        
        if ( detectiondata.var_1bdc8b080965b6ae )
        {
            perk::removeperk( "specialty_tracker_pro_short" );
        }
    }
}

// Namespace vision_pulse
// Params 0, eflags: 0x4
// Checksum 0x20a10e30, Offset: 0x23c6
// Size: 0x2b
function private function_bc6466c204450c05()
{
    if ( function_4a5d35da42987281() )
    {
        perk::removeperk( "specialty_ads_ping" );
        self.var_c30ac7c20e23e0f7 = undefined;
        self.var_c008b0c65e668f56 = undefined;
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x287bada9, Offset: 0x23f9
// Size: 0xc1
function private function_f0d64ffe0dc95355( superbundle )
{
    usehudelem = getdvarint( @"hash_8e7b5a6758a07295", 0 );
    
    if ( usehudelem )
    {
        var_5af856171d273251 = hud_util::function_cd054751d2d5b5c5( superbundle.var_2c596ee98b25e71c );
        var_5af856171d273251.alpha = 0;
        var_5af856171d273251 fadeovertime( superbundle.var_67712f09e051d97d );
        var_5af856171d273251.alpha = 1;
        self.var_5af856171d273251 = var_5af856171d273251;
        return;
    }
    
    if ( superbundle.var_6e4005bd76449699 )
    {
        utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:superbundle.var_6e4005bd76449699 }, 1, 1 );
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xfbce97b6, Offset: 0x24c2
// Size: 0x107
function private function_3d7428c1f2d0dfce( superbundle )
{
    if ( self.var_5af856171d273251 )
    {
        self.var_5af856171d273251 fadeovertime( superbundle.var_70f9c53c162172e0 );
        self.var_5af856171d273251.alpha = 0;
        utility::waittill_any_in_array_or_timeout( [ "death", "disconnect", "cancel_vision_pulse" ], superbundle.var_70f9c53c162172e0 );
        self.var_5af856171d273251 destroy();
        self.var_5af856171d273251 = undefined;
        return;
    }
    
    if ( superbundle.var_6e4005bd76449699 )
    {
        utility::callsharedfunc( #"fullscreenfx", #"hash_494b07757cd511a5", { #postfxbundlename:superbundle.var_6e4005bd76449699 } );
    }
    
    if ( superbundle.var_fd08451c352d749b )
    {
        utility::callsharedfunc( #"fullscreenfx", #"hash_494b07757cd511a5", { #postfxbundlename:superbundle.var_fd08451c352d749b } );
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x4cdf3cc0, Offset: 0x25d1
// Size: 0x4e
function private function_de063961dbf0b0c7( superbundle )
{
    if ( isdefined( level._effect[ "vision_pulse_radius_fx" ] ) )
    {
        return;
    }
    
    if ( isdefined( superbundle.var_73470ef97070ad52 ) )
    {
        level._effect[ "vision_pulse_radius_fx" ] = loadfxasset( superbundle.var_73470ef97070ad52 );
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x2ca0b75e, Offset: 0x2627
// Size: 0x5d
function private function_209aa5a362be812c( detectiontime )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_441ddcaf3a5dbee5" );
    function_5a7cc3a5bb0ea46f( 1 );
    wait detectiontime * 0.001;
    function_5a7cc3a5bb0ea46f( 0 );
    function_575d46a1be312d63();
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xb2cdbf0c, Offset: 0x268c
// Size: 0x9e
function private function_e37ec34bd8c266e8( radius )
{
    foreach ( value in [ "entity_mark_equipment", "entity_mark_killstreak", "entity_mark_air_killstreak" ] )
    {
        val::set( "super_vision_pulse", value, radius );
    }
}

// Namespace vision_pulse
// Params 0, eflags: 0x4
// Checksum 0xcf172ecb, Offset: 0x2732
// Size: 0x93
function private function_575d46a1be312d63()
{
    foreach ( value in [ "entity_mark_equipment", "entity_mark_killstreak", "entity_mark_air_killstreak" ] )
    {
        val::reset( "super_vision_pulse", value );
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x71cff3f5, Offset: 0x27cd
// Size: 0xb5
function private function_5a7cc3a5bb0ea46f( status )
{
    foreach ( value in [ "entity_mark_origin_equipment", "entity_mark_origin_killstreak", "entity_mark_origin_air_killstreak" ] )
    {
        if ( status )
        {
            val::set( "super_vision_pulse", value, 1 );
            continue;
        }
        
        val::reset( "super_vision_pulse", value );
    }
}

// Namespace vision_pulse
// Params 0, eflags: 0x4
// Checksum 0x98159491, Offset: 0x288a
// Size: 0x3, Type: bool
function private function_4a5d35da42987281()
{
    return false;
}

// Namespace vision_pulse
// Params 0, eflags: 0x4
// Checksum 0xa864248b, Offset: 0x2896
// Size: 0x3, Type: bool
function private function_f92200e3b6eb7b53()
{
    return false;
}

// Namespace vision_pulse
// Params 0, eflags: 0x4
// Checksum 0x236fb00f, Offset: 0x28a2
// Size: 0x3, Type: bool
function private function_17478a06da5996d2()
{
    return false;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xc07047c5, Offset: 0x28ae
// Size: 0xab
function private function_568a31bc8f674b20( detectiondata )
{
    sortedentities = [];
    
    foreach ( data in detectiondata.var_f6e9adc3ecc6f9b7 )
    {
        sortedentities[ sortedentities.size ] = data.entity;
    }
    
    return sortbydistance( sortedentities, self.origin, 1 );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xb8001292, Offset: 0x2962
// Size: 0xdf
function private function_509f98d24f4795b4( detectiondata )
{
    if ( detectiondata.var_f6e9adc3ecc6f9b7.size == 0 )
    {
        return;
    }
    
    if ( isdefined( detectiondata.var_4561a53da63a68dc ) )
    {
        return;
    }
    
    sortedentities = function_568a31bc8f674b20( detectiondata );
    
    foreach ( entity in sortedentities )
    {
        if ( isdefined( detectiondata.var_4561a53da63a68dc ) )
        {
            return;
        }
        
        if ( !function_86617683e08eef95( entity ) )
        {
            continue;
        }
        
        detectiondata.var_4561a53da63a68dc = entity;
        function_192d292203f0c351( entity );
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xbf0bc0a2, Offset: 0x2a49
// Size: 0x78, Type: bool
function private function_86617683e08eef95( entity )
{
    if ( entity.classname == "player" )
    {
        return ( entity.team != self.team );
    }
    else
    {
        entitytier = 0;
        
        if ( isdefined( entity.aicategory ) )
        {
            entitytier = level.var_69ca1da6a51846f1[ entity.aicategory ] ?? entitytier;
        }
        
        return ( entitytier >= 3 );
    }
    
    return false;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x6955b1a7, Offset: 0x2aca
// Size: 0xd7
function private function_192d292203f0c351( entity )
{
    players = level.players;
    
    if ( utility::issharedfuncdefined( #"game", #"getteamdata" ) )
    {
        players = [[ utility::getsharedfunc( #"game", #"getteamdata" ) ]]( self.team, "players" );
    }
    
    foreach ( player in players )
    {
        player function_6377d5d587b16dd1( entity );
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xbe13fca4, Offset: 0x2ba9
// Size: 0xf2
function private function_c55ecad643dbb3e3( detectiondata )
{
    if ( !isdefined( detectiondata.var_4561a53da63a68dc ) )
    {
        return;
    }
    
    players = level.players;
    
    if ( utility::issharedfuncdefined( #"game", #"getteamdata" ) )
    {
        players = [[ utility::getsharedfunc( #"game", #"getteamdata" ) ]]( self.team, "players" );
    }
    
    foreach ( player in players )
    {
        player removenameplate();
    }
    
    detectiondata.var_4561a53da63a68dc = undefined;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x3c63e065, Offset: 0x2ca3
// Size: 0x2b
function private function_6377d5d587b16dd1( entity )
{
    self [[ utility::getsharedfunc( #"zombie_health_bar", #"show_health_bar" ) ]]( entity, self );
}

// Namespace vision_pulse
// Params 0, eflags: 0x4
// Checksum 0x7216bb07, Offset: 0x2cd6
// Size: 0x1e
function private removenameplate()
{
    self [[ utility::getsharedfunc( #"zombie_health_bar", #"hide_health_bar" ) ]]();
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xe10fb53e, Offset: 0x2cfc
// Size: 0x58
function private onplayerkilled( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vision_pulse" );
    params.attacker onentitykilled( params.victim, params, bundle.var_c929773e13ee5f19, bundle.var_dd30a7f20fa6072a );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xf4010663, Offset: 0x2d5c
// Size: 0x7a
function private onagentkilled( params )
{
    if ( isdefined( params.eattacker ) && self.death_source != "despawn" )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vision_pulse" );
        params.eattacker onentitykilled( params.victim, params, bundle.var_fcdfad194b9446d3, bundle.var_6cb8a26946de1b48 );
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x9ebd732, Offset: 0x2dde
// Size: 0x6c
function private function_610fe043d1b5d3a( params )
{
    if ( self.var_56c65bfb13ade932.sweepinprogress )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vision_pulse" );
        params.outlineowner function_6b6e6a35c012d8d2( params.targetent, bundle.var_cf826b1ab9b6d66b, bundle.var_8d3181bb3140df33 );
    }
}

// Namespace vision_pulse
// Params 4, eflags: 0x4
// Checksum 0xcb46b1da, Offset: 0x2e52
// Size: 0x136
function private onentitykilled( victim, params, scoreeventkill, scoreeventassist )
{
    if ( !victim.var_b52498c11832e4ea )
    {
        return;
    }
    
    var_b5254294b138ae4e = self getentitynumber();
    
    foreach ( entnum in victim.var_b52498c11832e4ea )
    {
        var_ef748e149cfdf376 = getentbynum( entnum );
        
        if ( entnum == var_b5254294b138ae4e )
        {
            if ( scoreeventkill )
            {
                namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( scoreeventkill );
            }
        }
        else if ( !player_utility::playersareenemies( self, var_ef748e149cfdf376 ) )
        {
            if ( scoreeventassist )
            {
                var_ef748e149cfdf376 namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( scoreeventassist );
            }
        }
        
        var_4414124ccf55031e = var_ef748e149cfdf376 utility::callsharedfunc( "super_vision_pulse", #"hash_8ae2ea78813ee0dd" );
        
        if ( var_4414124ccf55031e )
        {
            var_ef748e149cfdf376 handledeathpercentage( var_4414124ccf55031e );
        }
    }
    
    victim.var_b52498c11832e4ea = undefined;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x58916c1e, Offset: 0x2f90
// Size: 0x6b
function private handledeathpercentage( var_4414124ccf55031e )
{
    detectiondata = self.var_56c65bfb13ade932;
    detectiondata.var_2a4350fe4b336a6f++;
    
    if ( detectiondata.var_2a4350fe4b336a6f >= var_4414124ccf55031e.var_65af1664bc038dfe )
    {
        self notify( #"hash_ac9044f9a88a2c1a", var_4414124ccf55031e.var_fe58711e0713af45 );
        detectiondata.var_2a4350fe4b336a6f = 0;
    }
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x22abe5e9, Offset: 0x3003
// Size: 0x33
function private function_63bd8f24b3cf6ce3( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    return function_ae6c76b392cc6c3( params, params.eattacker );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xa897edf0, Offset: 0x303f
// Size: 0x39
function private function_eedc44033d765d3b( params )
{
    var_ef748e149cfdf376 = params.eattacker function_bff1589f31799b82();
    
    if ( !var_ef748e149cfdf376 )
    {
        return;
    }
    
    return function_ae6c76b392cc6c3( params, var_ef748e149cfdf376 );
}

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0x6cb99951, Offset: 0x3081
// Size: 0x116
function private function_ae6c76b392cc6c3( params, var_ef748e149cfdf376 )
{
    damage = params.idamage;
    agents = var_ef748e149cfdf376.var_56c65bfb13ade932.var_f6e9adc3ecc6f9b7;
    damagemultiplier = var_ef748e149cfdf376.var_56c65bfb13ade932.var_e6c6ac2a4bdb06a;
    
    if ( !agents || !damagemultiplier || params.var_754388dc3c8ae2de )
    {
        return damage;
    }
    
    foreach ( agent in agents )
    {
        if ( agent.entity == self )
        {
            damage *= damagemultiplier;
            params.var_754388dc3c8ae2de = 1;
        }
    }
    
    return damage;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0xb66aace, Offset: 0x31a0
// Size: 0x4d
function private onplayerdamaged( params )
{
    if ( !function_2d151a6a490ae745( params.victim ) )
    {
        return;
    }
    
    params.idamage *= self.var_56c65bfb13ade932.var_76dc9f4e34f789a5;
}

// Namespace vision_pulse
// Params 0, eflags: 0x4
// Checksum 0xa3c5a80b, Offset: 0x31f5
// Size: 0x97
function private function_bff1589f31799b82()
{
    squadmates = squad_utility::getsquadmembers( self.team, 1 );
    
    foreach ( ally in squadmates )
    {
        if ( ally.var_56c65bfb13ade932 )
        {
            return ally;
        }
    }
}

/#

    // Namespace vision_pulse
    // Params 1, eflags: 0x4
    // Checksum 0x66214e02, Offset: 0x3295
    // Size: 0xca, Type: dev
    function private debugradius( detectiondata )
    {
        self endon( #"death" );
        self endon( #"disconnect" );
        level endon( #"game_ended" );
        self endon( #"hash_33aa3999e3cd8ad7" );
        self endon( #"hash_e88df886d8c5f653" );
        self endon( #"hash_441ddcaf3a5dbee5" );
        detectiondata.debugcircle = {};
        detectiondata.debugcircle game_utility::questcircle_create( "<dev string:x80>", detectiondata.origin, detectiondata.currentradius );
        detectiondata.debugcircle game_utility::questcircle_showtoplayer( self );
        
        while ( true )
        {
            detectiondata.debugcircle game_utility::function_d46d8731ed9d281( detectiondata.currentradius );
            waitframe();
        }
    }

    // Namespace vision_pulse
    // Params 1, eflags: 0x4
    // Checksum 0x1028f970, Offset: 0x3367
    // Size: 0x55, Type: dev
    function private function_333b0e312c16a7( detectiondata )
    {
        utility::waittill_any( "<dev string:x8b>", "<dev string:xaf>", "<dev string:xcc>", "<dev string:xe1>" );
        
        if ( detectiondata.debugcircle )
        {
            detectiondata.debugcircle game_utility::questcircle_delete();
            detectiondata.debugcircle = undefined;
        }
    }

#/

// Namespace vision_pulse
// Params 2, eflags: 0x4
// Checksum 0x68e6969a, Offset: 0x33c4
// Size: 0xbd
function private function_60fc5db51617d1ba( scriptable, var_1f8b5103710d81e7 )
{
    if ( var_1f8b5103710d81e7 && isplayer( self ) )
    {
        if ( !isdefined( scriptable.var_a11d8ac76c2a441e ) )
        {
            scriptable.var_a11d8ac76c2a441e = [];
        }
        
        scriptable.var_a11d8ac76c2a441e[ scriptable.var_a11d8ac76c2a441e.size ] = self;
    }
    
    if ( scriptable.var_a11d8ac76c2a441e && isplayer( self ) && !var_1f8b5103710d81e7 )
    {
        assertmsg( "<dev string:xf5>" + scriptable getentitynumber() + "<dev string:x112>" );
    }
    
    if ( !isdefined( self.var_3f3b99223d20a25d ) )
    {
        self.var_3f3b99223d20a25d = [];
    }
    
    self.var_3f3b99223d20a25d[ self.var_3f3b99223d20a25d.size ] = scriptable;
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x3cfb42a9, Offset: 0x3489
// Size: 0x6a
function private function_40ca10dce82de0f( scriptable )
{
    if ( scriptable.var_a11d8ac76c2a441e )
    {
        scriptable.var_a11d8ac76c2a441e = arrayremove( scriptable.var_a11d8ac76c2a441e, self );
        
        if ( scriptable.var_a11d8ac76c2a441e.size == 0 )
        {
            scriptable.var_a11d8ac76c2a441e = undefined;
        }
    }
    
    self.var_3f3b99223d20a25d = arrayremove( self.var_3f3b99223d20a25d, scriptable );
}

// Namespace vision_pulse
// Params 1, eflags: 0x4
// Checksum 0x2a0af03e, Offset: 0x34fb
// Size: 0xfe
function private function_475202a861cfbc70( entity )
{
    squadmates = squad_utility::getsquadmembers( self.team, 1 );
    
    foreach ( ally in squadmates )
    {
        detectiondata = ally.var_56c65bfb13ade932;
        
        if ( !isdefined( detectiondata ) )
        {
            continue;
        }
        
        if ( !isdefined( detectiondata.var_f6e9adc3ecc6f9b7[ entity getentitynumber() ] ) )
        {
            continue;
        }
        
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vision_pulse" );
        fadeoutoutline = function_e547d40bdae197a6( entity, bundle );
        disableoutline( entity, fadeoutoutline );
        break;
    }
}

