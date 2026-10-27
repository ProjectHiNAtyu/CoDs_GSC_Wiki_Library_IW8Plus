// script_1e5b0eceb3a8b79c  (hash_1e5b0eceb3a8b79c.gscc) (size: 14547 Bytes / 0x38d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x80f42fa7 (2163486631)
// size ...... 14547 (0x38d3)
// includes .. 7   (offset: 0x3643)
// strings ... 34  (offset: 0x367b)
// dev strs .. 14  (offset: 0x3817)
// exports ... 32  (offset: 0x23bb)
// cseg ...... 0x4ce + 0x1eed (0x23bb)
// imports ... 112 (offset: 0x28bb)
// animtree1 . 0   (offset: 0x38d3)
// animtree2 . 0   (offset: 0x38d3)
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_ending_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\audio_utility;

#namespace namespace_fa712d681ac4a11f;

// Namespace namespace_fa712d681ac4a11f
// Params 0, eflags: 0x5
// Checksum 0x106f0471, Offset: 0x4ec
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_976cc251fb7a291e", #"br_ending", &pre_main, undefined );
}

// Namespace namespace_fa712d681ac4a11f
// Params 0
// Checksum 0xe113b20a, Offset: 0x515
// Size: 0x83
function pre_main()
{
    exfilstruct = spawnstruct();
    exfilstruct.usescenesystem = 1;
    exfilstruct.initfunc = &init;
    exfilstruct.playfunc = &play;
    exfilstruct.packfunc = &pack;
    exfilstruct.transientfunc = &transientfunc;
    exfilstruct.var_e63a9d5ec4b488a0 = &function_e63a9d5ec4b488a0;
    br_ending::register_exfil( "brexfil", exfilstruct );
}

// Namespace namespace_fa712d681ac4a11f
// Params 0
// Checksum 0xb4c39905, Offset: 0x5a0
// Size: 0xe3
function init()
{
    if ( !isdefined( self.bundle ) )
    {
        self.bundle = getscriptbundle( function_e910f7efd1daa8b3() );
    }
    
    bundle = self.bundle;
    assert( bundle );
    
    /#
        setdevdvarifuninitialized( @"hash_70809e88d9881104", 0 );
    #/
    
    level.var_e0308e22e5b02b6c = &function_5a141a0ad52cc10e;
    level.var_2c3d783630787a16 = "tag_body_animate";
    
    if ( bundle.var_47494e59d134059b )
    {
        utility::delaythread( 0.05, &br_ending_util::function_1c0500c7cf8f9b7, bundle.var_47494e59d134059b );
    }
    
    level.var_f152d0d36747c32b = [ "rifle", "smg", "mg", "spread", "sniper", "pistol" ];
    level.var_1f9f1f1326580faa = 1;
}

// Namespace namespace_fa712d681ac4a11f
// Params 2, eflags: 0x4
// Checksum 0x87cd2d9c, Offset: 0x68b
// Size: 0x1f
function private function_5a141a0ad52cc10e( winnerplayers, var_c71a8bc30a7b241b )
{
    thread end_game_sound( winnerplayers, var_c71a8bc30a7b241b );
}

// Namespace namespace_fa712d681ac4a11f
// Params 3, eflags: 0x4
// Checksum 0x74b4dab6, Offset: 0x6b2
// Size: 0x23
function private end_game_sound( winners, var_410ded744dab958f, movetime )
{
    clearmusicstate();
}

// Namespace namespace_fa712d681ac4a11f
// Params 2, eflags: 0x4
// Checksum 0x4e0a2eb5, Offset: 0x6dd
// Size: 0x192
function private function_130b4f260102282f( var_410ded744dab958f, incomingsound )
{
    assert( isdefined( incomingsound ) && isdefined( incomingsound.movetime ) );
    assert( isdefined( incomingsound.var_2a703df93dac72b0 ) && isdefined( incomingsound.var_2a703ef93dac74e3 ) && isdefined( incomingsound.var_2a703ff93dac7716 ) );
    assert( isdefined( incomingsound.var_df451061686a64b ) && isdefined( incomingsound.var_df450061686a418 ) && isdefined( incomingsound.var_df453061686aab1 ) );
    
    if ( !isdefined( winners ) )
    {
        winners = [];
    }
    
    if ( !isdefined( var_410ded744dab958f ) )
    {
        var_410ded744dab958f = ( 0, 0, 0 );
    }
    
    movetime = incomingsound.movetime;
    endorigin = var_410ded744dab958f + ( incomingsound.var_df451061686a64b, incomingsound.var_df450061686a418, incomingsound.var_df453061686aab1 );
    startorigin = var_410ded744dab958f + ( incomingsound.var_2a703df93dac72b0, incomingsound.var_2a703ef93dac74e3, incomingsound.var_2a703ff93dac7716 );
    tempent = spawn( "script_model", startorigin );
    tempent forcenetfieldhighlod( 1 );
    waitframe();
    
    if ( isdefined( incomingsound.soundname ) && soundexists( incomingsound.soundname ) )
    {
        tempent playsoundonmovingent( incomingsound.soundname );
    }
    
    tempent moveto( endorigin, movetime );
    wait movetime;
    tempent delete();
}

// Namespace namespace_fa712d681ac4a11f
// Params 1
// Checksum 0x2e891a6d, Offset: 0x877
// Size: 0x71a
function pack( var_410ded744dab958f )
{
    logstring( "EXFIL SEQUENCE - Pack - Start" );
    bundle = br_ending::get_exfil_bundle();
    self.bundle = bundle;
    level.exfilanimstruct = self;
    
    if ( !self.istemp )
    {
        level thread br_ending_util::function_ee3a6a615e19250a( 0, 0.85, "ending_transient_fade_done" );
    }
    
    winnercount = int( clamp( self.winners.size, 1, 4 ) );
    
    /#
        if ( getdvarint( @"hash_70809e88d9881104", 0 ) )
        {
            winnercount = 1;
        }
    #/
    
    sceneroot = spawnstruct();
    sceneroot.origin = self.origin;
    sceneroot.angles = self.angles;
    sceneroot.bundle = bundle;
    self.sceneroot = sceneroot;
    
    if ( !isdefined( var_410ded744dab958f ) )
    {
        var_410ded744dab958f = ( 0, 0, 0 );
    }
    
    level thread function_130b4f260102282f( var_410ded744dab958f, bundle.incomingsound );
    setomnvarforallclients( "ui_br_infil_exfil_player_focus", -1 );
    logstring( "EXFIL SEQUENCE - Pack - Transient Load" );
    
    if ( !getdvarint( @"scr_br_ending_placement" ) )
    {
        self.transientname = transientfunc();
        assert( isdefined( self.transientname ) && self.transientname != "<dev string:x24>" );
        
        if ( self.transientname )
        {
            br_ending_util::function_9711748a5c6c12c3( self.transientname );
        }
    }
    
    logstring( "EXFIL SEQUENCE - Pack - Set Script Bundle" );
    assert( winnercount <= bundle.var_9eb393c138006336.size );
    scenescriptbundle = bundle.var_9eb393c138006336[ winnercount - 1 ].scene;
    assert( scenescriptbundle );
    sceneroot scene::set_scriptbundle( scenescriptbundle );
    var_174294bc19644102 = sceneroot scene::get_shot_names( 0 );
    scene::add_scene_func( sceneroot, &scenestartfunc, var_174294bc19644102[ 0 ] );
    sceneroot.dispatch = [];
    
    foreach ( scenefunc in bundle.var_d42dcd32f0b93c45 )
    {
        if ( scenefunc.disable )
        {
            continue;
        }
        
        shot = scenefunc.shot;
        
        if ( utility::function_e4e418bde2160c35( shot ) )
        {
            shot = int( shot );
            
            if ( shot < 0 )
            {
                shot = var_174294bc19644102.size + shot;
            }
            
            shot = var_174294bc19644102[ int( shot ) ];
        }
        
        func = undefined;
        params = undefined;
        
        switch ( scenefunc.functiontype )
        {
            case #"hash_87d4646c0cd6c404":
                func = &function_b4de75540de33325;
                params = { #omnvarvalue:scenefunc.omnvarvalue ?? 0, #omnvarname:scenefunc.omnvarname };
                break;
            case #"hash_57e919afe2186234":
                func = &function_2438c6f8d94ae625;
                params = { #var_b546f525a9ab1133:scenefunc.var_b546f525a9ab1133 ?? 0, #var_fb17cf243c577a5a:scenefunc.var_fb17cf243c577a5a ?? 0, #var_a02f2557b12d6926:scenefunc.var_a02f2557b12d6926 ?? 0 };
                break;
            case #"hash_b8fea2f7956f7d7a":
                func = &function_ec9dca90a11b0009;
                params = { #scriptablepartstates:scenefunc.var_b2788c2a45e6d1a9, #sceneobject:scenefunc.sceneobject };
                break;
            case #"hash_be4ba85f7a8f6308":
                func = &sceneplayloopsound;
                params = { #soundname:scenefunc.soundname, #sceneobject:scenefunc.sceneobject };
                break;
            case #"hash_4b0dfa7a6ec7c4da":
                func = &function_8b9115a038d1f843;
                params = { #soundname:scenefunc.soundname, #sceneobject:scenefunc.sceneobject };
                break;
            case #"hash_262aee31d511fcc6":
                func = &function_bf702f7f4d2ce555;
                params = { #soundname:scenefunc.soundname, #leadtime:scenefunc.leadtime ?? 0, #shot:shot };
                break;
            case #"hash_a1a2d238baea2ab2":
                func = &function_5a48592ae5a4a14f;
                params = { #sceneobject:scenefunc.sceneobject };
                break;
            case #"hash_4ee036c601366e2f":
                func = &function_1151ecce3ab51ea2;
                params = {};
                break;
            case #"hash_c8a8894c0b89fc":
                func = &function_29a9cb93aad1275;
                params = { #hwconfig:scenefunc.hwconfig };
                break;
        }
        
        dispatch = { #params:params, #func:func };
        
        if ( !isdefined( sceneroot.dispatch[ shot ] ) )
        {
            sceneroot.dispatch[ shot ] = [];
        }
        
        sceneroot.dispatch[ shot ][ sceneroot.dispatch[ shot ].size ] = dispatch;
    }
    
    scene::function_8643ca8da60b5458( sceneroot, &function_3ba4f68f30ad1c18 );
    logstring( "EXFIL SEQUENCE - Pack - Set Circle" );
    br_ending_util::chopperexfil_set_brcircle();
    self.winners = function_5713d46873b29625( self.winners );
    
    foreach ( player in self.winners )
    {
        animname = "player" + player getentitynumber();
        player.animname = animname;
        player.brexfilanimname = animname;
    }
    
    /#
        if ( getdvarint( @"hash_70809e88d9881104", 0 ) )
        {
            self.winners = [];
        }
    #/
    
    if ( self.winners.size == 0 )
    {
        logstring( "EXFIL SEQUENCE - Pack - Create Disconnect Player" );
        br_ending_util::create_disconnectplayer( self );
    }
    
    logstring( "EXFIL SEQUENCE - Pack - Set Max Players - " + self.winners.size );
    self.sceneroot scene::function_e214b532712cd63a( self.winners.size );
    logstring( "EXFIL SEQUENCE - Pack - Spawn Lighting Rig" );
    
    if ( bundle.var_47494e59d134059b )
    {
        self.sceneroot.lightingrig = br_ending_util::function_88dc0218d2006993( bundle.var_47494e59d134059b );
    }
}

// Namespace namespace_fa712d681ac4a11f
// Params 1, eflags: 0x4
// Checksum 0x2f10a491, Offset: 0xf99
// Size: 0xc3
function private function_3ba4f68f30ad1c18( var_737cff255011346c )
{
    dispatch = self.dispatch[ var_737cff255011346c ];
    
    if ( isdefined( dispatch ) )
    {
        foreach ( var_e1e74c40f192073c in dispatch )
        {
            func = var_e1e74c40f192073c.func;
            params = var_e1e74c40f192073c.params;
            self thread [[ func ]]( params );
        }
    }
}

// Namespace namespace_fa712d681ac4a11f
// Params 1, eflags: 0x4
// Checksum 0xe31c495c, Offset: 0x1064
// Size: 0x4a
function private function_b4de75540de33325( params )
{
    assert( isdefined( params.omnvarname ) && isdefined( params.omnvarvalue ) );
    setomnvarforallclients( params.omnvarname, params.omnvarvalue );
}

// Namespace namespace_fa712d681ac4a11f
// Params 1, eflags: 0x4
// Checksum 0xd18e3d1a, Offset: 0x10b6
// Size: 0x68
function private function_2438c6f8d94ae625( params )
{
    assert( isdefined( params.var_a02f2557b12d6926 ) && isdefined( params.var_fb17cf243c577a5a ) && isdefined( params.var_b546f525a9ab1133 ) );
    waitframe();
    function_5c5a58d4d56c8f25( 1023, params.var_a02f2557b12d6926, params.var_fb17cf243c577a5a, params.var_b546f525a9ab1133 );
}

// Namespace namespace_fa712d681ac4a11f
// Params 1, eflags: 0x4
// Checksum 0xa85fcd12, Offset: 0x1126
// Size: 0xe3
function private function_ec9dca90a11b0009( params )
{
    assert( isdefined( params.sceneobject ) && isdefined( params.scriptablepartstates ) );
    waitframe();
    sceneobject = scene::get_object( params.sceneobject );
    
    foreach ( scriptablepartstate in params.scriptablepartstates )
    {
        sceneobject.entity setscriptablepartstate( scriptablepartstate.part, scriptablepartstate.state );
    }
}

// Namespace namespace_fa712d681ac4a11f
// Params 1, eflags: 0x4
// Checksum 0x82e55652, Offset: 0x1211
// Size: 0x76
function private sceneplayloopsound( params )
{
    assert( isdefined( params.sceneobject ) && isdefined( params.soundname ) );
    sceneobject = scene::get_object( params.sceneobject );
    
    if ( isdefined( sceneobject.entity ) )
    {
        sceneobject.entity playloopsound( params.soundname );
    }
}

// Namespace namespace_fa712d681ac4a11f
// Params 1, eflags: 0x4
// Checksum 0x82e55652, Offset: 0x128f
// Size: 0x76
function private function_8b9115a038d1f843( params )
{
    assert( isdefined( params.sceneobject ) && isdefined( params.soundname ) );
    sceneobject = scene::get_object( params.sceneobject );
    
    if ( isdefined( sceneobject.entity ) )
    {
        sceneobject.entity stoploopsound( params.soundname );
    }
}

// Namespace namespace_fa712d681ac4a11f
// Params 1, eflags: 0x4
// Checksum 0x20a85b8a, Offset: 0x130d
// Size: 0xb2
function private function_bf702f7f4d2ce555( params )
{
    assert( isdefined( params.shot ) && isdefined( params.leadtime ) && isdefined( params.soundname ) );
    sceneroot = self;
    shotlength = sceneroot scene::function_b3c7b792a7a154fa( params.shot );
    waittime = max( 0, shotlength - params.leadtime );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    audio_utility::function_63bf1584c79c055( level.players, params.soundname );
}

// Namespace namespace_fa712d681ac4a11f
// Params 1, eflags: 0x4
// Checksum 0x6fbd912f, Offset: 0x13c7
// Size: 0x6c
function private function_5a48592ae5a4a14f( params )
{
    assert( isdefined( params.sceneobject ) );
    waitframe();
    sceneobject = scene::get_object( params.sceneobject );
    
    if ( isdefined( sceneobject ) && isdefined( self.lightingrig ) )
    {
        br_ending_util::function_4db4aba34fab2da9( self.lightingrig, sceneobject.entity );
    }
}

// Namespace namespace_fa712d681ac4a11f
// Params 1, eflags: 0x4
// Checksum 0x4b36e20f, Offset: 0x143b
// Size: 0x2a
function private function_1151ecce3ab51ea2( params )
{
    waitframe();
    
    if ( isdefined( self.lightingrig ) )
    {
        br_ending_util::function_8b1bb889b21089( self.lightingrig );
    }
}

// Namespace namespace_fa712d681ac4a11f
// Params 1, eflags: 0x4
// Checksum 0xc5e207b4, Offset: 0x146d
// Size: 0x69
function private function_29a9cb93aad1275( params )
{
    assert( isdefined( params.hwconfig ) );
    waitframe();
    
    if ( self.hwconfig )
    {
        hwconfiguratorremoveasset( self.hwconfig );
        self.hwconfig = undefined;
    }
    
    hwconfiguratoraddasset( params.hwconfig );
    self.hwconfig = params.hwconfig;
}

// Namespace namespace_fa712d681ac4a11f
// Params 0
// Checksum 0xe4b918d4, Offset: 0x14de
// Size: 0x1d1
function music_start()
{
    if ( level.br_ending.winners.size == 0 )
    {
        return;
    }
    
    assert( self.bundle );
    bundle = self.bundle;
    musicsfx = bundle.var_98287e55cd6511d1[ level.br_ending.winners.size - 1 ];
    musicalias = musicsfx.musicalias;
    var_7a12303c46bad125 = musicsfx.sfxalias;
    
    foreach ( player in level.players )
    {
        if ( player.var_ee74e8eed7f0fe09 )
        {
            continue;
        }
        
        if ( var_7a12303c46bad125 )
        {
            player playlocalsound( var_7a12303c46bad125 );
        }
        
        if ( musicalias )
        {
            player playlocalsound( musicalias );
        }
    }
    
    waitframe();
    setmusicstate( "" );
    
    foreach ( player in level.players )
    {
        if ( player.var_ee74e8eed7f0fe09 )
        {
            continue;
        }
        
        player setsoundsubmix( bundle.soundsubmix, bundle.var_f83a34bd1d31761e );
    }
}

// Namespace namespace_fa712d681ac4a11f
// Params 0
// Checksum 0x268f9643, Offset: 0x16b7
// Size: 0x9
function scenestartfunc()
{
    thread music_start();
}

// Namespace namespace_fa712d681ac4a11f
// Params 0
// Checksum 0xd3400d19, Offset: 0x16c8
// Size: 0x80
function play()
{
    playexfil();
    
    foreach ( player in level.players )
    {
        player clearpredictedstreampos();
    }
}

// Namespace namespace_fa712d681ac4a11f
// Params 0, eflags: 0x4
// Checksum 0xaba18c55, Offset: 0x1750
// Size: 0x227
function private playexfil()
{
    logstring( "EXFIL SEQUENCE - Play - Start" );
    assert( self.bundle );
    
    /#
        level thread function_e4f12d9c72d72008();
    #/
    
    logstring( "EXFIL SEQUENCE - Play - Play Music" );
    level thread function_a6452f76524c61ef( level.players, self.winners, self.bundle );
    
    foreach ( player in self.winners )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player setshowcontrail( 0 );
    }
    
    logstring( "EXFIL SEQUENCE - Play - Pre Stream" );
    self.sceneroot scene::pre_stream( self.winners );
    logstring( "EXFIL SEQUENCE - Play - Pre Stream Finished" );
    
    if ( !self.istemp )
    {
        wait 0.75;
        level notify( #"ending_transient_fade_done" );
        logstring( "FADE TO BLACK DEBUG:  playExfil fade out" );
    }
    
    /#
        if ( self.istemp )
        {
            thread function_8aef03fda147c379();
        }
    #/
    
    logstring( "EXFIL SEQUENCE - Play - outroFunc" );
    outrofunc();
    logstring( "EXFIL SEQUENCE - Play - Scene Play" );
    self.sceneroot scene::play( self.winners );
    logstring( "EXFIL SEQUENCE - Play - Scene Finished" );
    
    /#
        if ( self.istemp )
        {
            self notify( #"hash_94b93d1bf2fbbb59" );
            
            foreach ( player in level.players )
            {
                player clearpredictedstreampos();
            }
        }
    #/
    
    logstring( "EXFIL SEQUENCE - Play - outroEndFunc" );
    outroendfunc();
    logstring( "EXFIL SEQUENCE - Play - outroEndFunc finished" );
}

/#

    // Namespace namespace_fa712d681ac4a11f
    // Params 0, eflags: 0x4
    // Checksum 0xb7993d25, Offset: 0x197f
    // Size: 0x3a, Type: dev
    function private function_8aef03fda147c379()
    {
        self waittill( #"hash_94b93d1bf2fbbb59" );
        
        if ( self.sceneroot scene::get_state() == "<dev string:x25>" )
        {
            self.sceneroot scene::stop();
        }
    }

    // Namespace namespace_fa712d681ac4a11f
    // Params 0, eflags: 0x4
    // Checksum 0xf88977be, Offset: 0x19c1
    // Size: 0x33, Type: dev
    function private function_e4f12d9c72d72008()
    {
        level waittill( #"hash_3e26dfc193b4fd86" );
        
        if ( !br_public::isanytutorialorbotpracticematch() )
        {
            setomnvarforallclients( "<dev string:x2d>", 0 );
            setomnvarforallclients( "<dev string:x3d>", -1 );
        }
    }

#/

// Namespace namespace_fa712d681ac4a11f
// Params 3
// Checksum 0xea1b601, Offset: 0x19fc
// Size: 0x10a
function function_a6452f76524c61ef( players, winners, bundle )
{
    assert( isarray( players ), "<dev string:x58>" + "<dev string:x7a>" );
    assert( isarray( winners ), "<dev string:x58>" + "<dev string:x9d>" );
    winner_count = maxint( winners.size, 1 );
    assert( isint( winner_count ), "<dev string:x58>" + "<dev string:xc0>" );
    assert( bundle.var_fe301641d3ba2a57.size >= winner_count, "<dev string:x58>" + "<dev string:xdd>" );
    intro_music = bundle.var_fe301641d3ba2a57[ winner_count - 1 ].name;
    assert( intro_music != "<dev string:x24>", "<dev string:x58>" + "<dev string:x127>" + winner_count + "<dev string:x156>" );
    
    if ( !isdefined( level.musicenabled ) )
    {
        level.musicenabled = 1;
    }
    
    audio_utility::function_6a0ed3b9fb942369( players, intro_music );
}

// Namespace namespace_fa712d681ac4a11f
// Params 0
// Checksum 0x170c5e21, Offset: 0x1b0e
// Size: 0x8d
function outrofunc()
{
    if ( !br_public::isanytutorialorbotpracticematch() )
    {
        if ( !isdefined( level.brwinnerscircle ) && !getdvarint( @"hash_6b0cdb9a486f2a4b", 0 ) && !getdvarint( @"scr_br_ending_play", 0 ) && !getdvarint( @"scr_br_ending_placement", 0 ) )
        {
            setomnvarforallclients( "post_game_state", 14 );
        }
        
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    }
    
    assert( self.bundle );
    level thread function_68e7e55727f2472e( self.bundle );
}

// Namespace namespace_fa712d681ac4a11f
// Params 1
// Checksum 0xcf88a3db, Offset: 0x1ba3
// Size: 0x17d
function function_68e7e55727f2472e( bundle )
{
    assert( bundle.var_4533ea5379984915 );
    audio_utility::snd_transient_load( bundle.var_4533ea5379984915 );
    
    if ( bundle.var_be5201e010b03e23 > 0 )
    {
        wait bundle.var_be5201e010b03e23;
    }
    
    foreach ( localsound in bundle.startsounds )
    {
        if ( localsound.disable )
        {
            continue;
        }
        
        audio_utility::function_63bf1584c79c055( level.players, localsound.soundalias );
    }
    
    assert( isdefined( bundle.clienttriggeraudiozone ) && isdefined( bundle.var_667288a1a0c7aaaa ) );
    audio_utility::function_7b72e563ad80e020( level.players, bundle.clienttriggeraudiozone, bundle.var_667288a1a0c7aaaa );
    assert( isdefined( bundle.submix ) && isdefined( bundle.submixfadetime ) );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, bundle.submix, bundle.submixfadetime );
}

// Namespace namespace_fa712d681ac4a11f
// Params 0
// Checksum 0x6b841be5, Offset: 0x1d28
// Size: 0x37
function outroendfunc()
{
    assert( self.bundle );
    level thread br_ending_util::function_e89c7c78b10aa4a( undefined, 2, 1 );
    level thread function_7f7b1eab3d58d251( self.bundle );
}

// Namespace namespace_fa712d681ac4a11f
// Params 1
// Checksum 0x7a1c8b0e, Offset: 0x1d67
// Size: 0x37
function function_7f7b1eab3d58d251( bundle )
{
    wait 60;
    assert( bundle.var_4533ea5379984915 );
    audio_utility::snd_transient_unload( bundle.var_4533ea5379984915 );
}

// Namespace namespace_fa712d681ac4a11f
// Params 0
// Checksum 0xa2c2d8b5, Offset: 0x1da6
// Size: 0x14f
function function_e910f7efd1daa8b3()
{
    matchexfil = getmatchrulesdata( "brData", "exfil" );
    
    if ( matchexfil )
    {
        return hashcat( %"hash_477268a66b4ea2a8", matchexfil );
    }
    
    mapinfo = level.mapinfobundle ?? getmapscriptbundle();
    
    foreach ( var_c0929d5b10f3f848 in mapinfo.transientdata.infilgameplay )
    {
        foreach ( exfil in var_c0929d5b10f3f848.var_11b74bbf5b7c4ed9 )
        {
            return exfil.bundle;
        }
    }
    
    assert( 0, "<dev string:x165>" );
}

// Namespace namespace_fa712d681ac4a11f
// Params 0
// Checksum 0xde38238c, Offset: 0x1efd
// Size: 0x173
function transientfunc()
{
    mapinfo = level.mapinfobundle ?? getmapscriptbundle();
    bundlename = br_ending::get_exfil_bundle_name() ?? function_e910f7efd1daa8b3();
    assert( isdefined( mapinfo ) && isdefined( bundlename ) );
    
    foreach ( var_c0929d5b10f3f848 in mapinfo.transientdata.infilgameplay )
    {
        foreach ( exfil in var_c0929d5b10f3f848.var_11b74bbf5b7c4ed9 )
        {
            if ( !isdefined( bundlename ) || exfil.bundle == bundlename )
            {
                return var_c0929d5b10f3f848.transientname;
            }
        }
    }
    
    assert( 0, "<dev string:x187>" + bundlename + "<dev string:x1ac>" );
    return "";
}

// Namespace namespace_fa712d681ac4a11f
// Params 0
// Checksum 0xa4d6745f, Offset: 0x2079
// Size: 0x341
function function_e63a9d5ec4b488a0()
{
    argsarray = [];
    bundle = br_ending::get_exfil_bundle();
    assert( isdefined( bundle ) && isdefined( bundle.collision ) );
    
    foreach ( playeranim in bundle.collision.playeranimarray )
    {
        assert( isdefined( playeranim.animname.id ) && isdefined( playeranim.percentage ) && isdefined( bundle.collision.guyradius ) && isdefined( bundle.collision.guyheight ) );
        argsarray = br_ending_util::function_37badcf00027517a( argsarray, playeranim.animname.id, playeranim.percentage, undefined, bundle.collision.guyradius, bundle.collision.guyheight );
    }
    
    assert( isdefined( bundle.collision.vehiclemodel ) );
    choppermodel = bundle.collision.vehiclemodel;
    chopperoriginoffset = ( 0, 0, 0 );
    chopperradius = bundle.collision.vehicleradius;
    choppersegments = bundle.collision.vehiclesegments;
    
    foreach ( vehicleanim in bundle.collision.var_2bedbf52db2fadc4 )
    {
        argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, vehicleanim.animname.id, vehicleanim.percentage, chopperoriginoffset, chopperradius );
    }
    
    foreach ( vehiclepath in bundle.collision.vehiclepatharray )
    {
        argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, vehiclepath.animname.id, chopperoriginoffset, chopperradius, choppersegments );
    }
    
    return argsarray;
}

