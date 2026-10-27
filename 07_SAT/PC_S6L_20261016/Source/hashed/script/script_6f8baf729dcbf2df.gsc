// script_6f8baf729dcbf2df  (hash_6f8baf729dcbf2df.gscc) (size: 11653 Bytes / 0x2d85 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbab501ae (3132424622)
// size ...... 11653 (0x2d85)
// includes .. 8   (offset: 0x29a9)
// strings ... 45  (offset: 0x29e9)
// dev strs .. 8   (offset: 0x2c4d)
// exports ... 30  (offset: 0x18ed)
// cseg ...... 0x6bb + 0x1232 (0x18ed)
// imports ... 103 (offset: 0x1d9d)
// animtree1 . 0   (offset: 0x2cb9)
// animtree2 . 11  (offset: 0x2cb9)
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_ending_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;

#namespace namespace_c4bfea04500a8c9c;

// Namespace namespace_c4bfea04500a8c9c
// Params 0, eflags: 0x5
// Checksum 0x84d92267, Offset: 0x6d9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b4524d989c7fd1cf", #"br_ending", &pre_main, undefined );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x5c2ee563, Offset: 0x702
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
    br_ending::register_exfil( "cer_s3", exfilstruct );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x8c0d8fa1, Offset: 0x78d
// Size: 0x4d
function init()
{
    /#
        setdevdvarifuninitialized( @"hash_70809e88d9881104", 0 );
    #/
    
    level.var_e0308e22e5b02b6c = &function_5a141a0ad52cc10e;
    level.var_2c3d783630787a16 = "tag_player";
    utility::delaythread( 0.05, &br_ending_util::function_1c0500c7cf8f9b7, "chopper3_s3" );
    init_fx();
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x8e7eb9, Offset: 0x7e2
// Size: 0x4d
function init_fx()
{
    level._effect[ "chopperExfil_rotorwash" ] = loadfxasset( "vfx_iw8_br_gameplay_blima_rotor_infil" );
    level._effect[ "chopperExfil_gas" ] = loadfxasset( "vfx_iw8_br_gameplay_circle_gas_exfil_01" );
    level._effect[ "player_disconnect" ] = loadfxasset( "vfx_iw8_br_gameplay_disconnect_player" );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 2, eflags: 0x4
// Checksum 0x747ef35b, Offset: 0x837
// Size: 0x1f
function private function_5a141a0ad52cc10e( winnerplayers, var_c71a8bc30a7b241b )
{
    thread end_game_sound( winnerplayers, var_c71a8bc30a7b241b );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 3, eflags: 0x4
// Checksum 0x4a96ecb7, Offset: 0x85e
// Size: 0x30
function private end_game_sound( winners, var_410ded744dab958f, movetime )
{
    audio_utility::snd_transient_load( function_931d17ce42432f1d() );
    clearmusicstate();
}

// Namespace namespace_c4bfea04500a8c9c
// Params 1, eflags: 0x4
// Checksum 0x66f9c698, Offset: 0x896
// Size: 0xbf
function private function_130b4f260102282f( var_410ded744dab958f )
{
    if ( !isdefined( winners ) )
    {
        winners = [];
    }
    
    if ( !isdefined( var_410ded744dab958f ) )
    {
        var_410ded744dab958f = ( 0, 0, 0 );
    }
    
    movetime = 7;
    endorigin = var_410ded744dab958f + ( 0, 0, 360 );
    startorigin = endorigin + ( -7200, 7200, 1800 );
    tempent = spawn( "script_model", startorigin );
    tempent forcenetfieldhighlod( 1 );
    waitframe();
    
    if ( soundexists( "br_exfil_incoming_heli_lr" ) )
    {
        tempent playsoundonmovingent( "br_exfil_incoming_heli_lr" );
    }
    
    tempent moveto( endorigin, movetime );
    wait movetime;
    tempent delete();
}

// Namespace namespace_c4bfea04500a8c9c
// Params 1
// Checksum 0x22377054, Offset: 0x95d
// Size: 0x34e
function pack( var_410ded744dab958f )
{
    level.exfilanimstruct = self;
    
    if ( !self.istemp )
    {
        level thread br_ending_util::function_ee3a6a615e19250a( 0, 0.85, "ending_transient_fade_done" );
    }
    
    scenenames = [ "wz_br_cer_exfil_s3_scene_solo", "wz_br_cer_exfil_s3_scene_duo", "wz_br_cer_exfil_s3_scene_trio", "wz_br_cer_exfil_s3_scene" ];
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
    self.sceneroot = sceneroot;
    
    if ( !isdefined( var_410ded744dab958f ) )
    {
        var_410ded744dab958f = ( 0, 0, 0 );
    }
    
    level thread function_130b4f260102282f( var_410ded744dab958f );
    setomnvarforallclients( "ui_br_infil_exfil_player_focus", -1 );
    
    if ( !getdvarint( @"scr_br_ending_placement" ) )
    {
        self.transientname = transientfunc();
        br_ending_util::function_9711748a5c6c12c3( self.transientname );
    }
    
    sceneroot scene::set_scriptbundle( scenenames[ winnercount - 1 ] );
    var_174294bc19644102 = sceneroot scene::get_shot_names( 0 );
    level.exfilanimstruct.var_5203f111ee0d9f26 = sceneroot scene::function_b3c7b792a7a154fa( var_174294bc19644102[ var_174294bc19644102.size - 2 ] );
    scene::add_scene_func( sceneroot, &scenestartfunc, var_174294bc19644102[ 0 ] );
    scene::add_scene_func( sceneroot, &function_39a19b0aea67702f, "shot_010" );
    scene::add_scene_func( sceneroot, &function_d6746411f6d55954, "shot_030" );
    scene::add_scene_func( sceneroot, &function_d2812e9cb6ec22dd, "shot_040" );
    scene::add_scene_func( sceneroot, &function_a48558f4d96a60ca, "shot_050" );
    scene::add_scene_func( sceneroot, &function_7b6f04f18f3e2b03, "shot_060" );
    scene::add_scene_func( sceneroot, &function_b63ac6a2731e0d74, var_174294bc19644102[ var_174294bc19644102.size - 2 ] );
    scene::add_scene_func( sceneroot, &function_ab7d7cf3650889fb, var_174294bc19644102[ var_174294bc19644102.size - 1 ] );
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
        br_ending_util::create_disconnectplayer( self );
    }
    
    self.sceneroot scene::function_e214b532712cd63a( self.winners.size );
    self.sceneroot.lightingrig = br_ending_util::function_88dc0218d2006993( "chopper3_s3" );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x49075951, Offset: 0xcb3
// Size: 0x1e3
function music_start()
{
    if ( level.br_ending.winners.size == 0 )
    {
        return;
    }
    
    musicalias = "mus_br_exfil_intro_3player_intro";
    var_7a12303c46bad125 = "br_exfil_part1_3person_lr";
    
    switch ( level.br_ending.winners.size )
    {
        case 1:
            musicalias = "mus_br_exfil_intro_1player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_1person_lr";
            break;
        case 2:
            musicalias = "mus_br_exfil_intro_2player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_2person_lr";
            break;
        case 3:
            musicalias = "mus_br_exfil_intro_3player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_3person_lr";
            break;
        case 4:
            musicalias = "mus_br_exfil_intro_4player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_4person_lr";
            break;
    }
    
    foreach ( player in level.players )
    {
        if ( player.var_ee74e8eed7f0fe09 )
        {
            continue;
        }
        
        player playlocalsound( var_7a12303c46bad125 );
    }
    
    waitframe();
    setmusicstate( "" );
    
    foreach ( player in level.players )
    {
        if ( player.var_ee74e8eed7f0fe09 )
        {
            continue;
        }
        
        player setsoundsubmix( "mp_br_exfil_fade", 4 );
    }
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0xd53c4884, Offset: 0xe9e
// Size: 0x9
function scenestartfunc()
{
    thread music_start();
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x7934ef61, Offset: 0xeaf
// Size: 0x69
function function_39a19b0aea67702f()
{
    hwconfiguratoraddasset( %"hw_jup_mp_wz2_cin_cer" );
    function_5c5a58d4d56c8f25( 1023, 3, 1, 0 );
    chopperobject = scene::get_object( "Heli" );
    
    if ( isdefined( chopperobject ) && isdefined( self.lightingrig ) )
    {
        br_ending_util::function_4db4aba34fab2da9( self.lightingrig, chopperobject.entity );
    }
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0xc321d8da, Offset: 0xf20
// Size: 0x49
function function_d6746411f6d55954()
{
    chopperobject = scene::get_object( "Heli" );
    
    if ( isdefined( chopperobject.entity ) )
    {
        chopperobject.entity playloopsound( "amb_br_ending_int_lr" );
    }
    
    setomnvarforallclients( "ui_br_end_game_splash_type", 13 );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x45d2710f, Offset: 0xf71
// Size: 0xe
function function_d2812e9cb6ec22dd()
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 14 );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x78b258be, Offset: 0xf87
// Size: 0xe
function function_a48558f4d96a60ca()
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 15 );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0xca9284b1, Offset: 0xf9d
// Size: 0xe
function function_7b6f04f18f3e2b03()
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 16 );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0xd49a02fa, Offset: 0xfb3
// Size: 0x9
function function_b63ac6a2731e0d74()
{
    thread function_92777323e7001806();
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x1cc2c6e0, Offset: 0xfc4
// Size: 0x7b
function function_92777323e7001806()
{
    assert( isdefined( level.exfilanimstruct.var_5203f111ee0d9f26 ) );
    leadtime = 1.25;
    waittime = max( 0, level.exfilanimstruct.var_5203f111ee0d9f26 - leadtime );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    audio_utility::function_63bf1584c79c055( level.players, "br_exfil_end_part_lr" );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x54d0e21a, Offset: 0x1047
// Size: 0x5f
function function_ab7d7cf3650889fb()
{
    chopperobject = scene::get_object( "Heli" );
    
    if ( isdefined( chopperobject.entity ) )
    {
        chopperobject.entity stoploopsound( "amb_br_ending_int_lr" );
    }
    
    hwconfiguratorremoveasset( %"hw_jup_mp_wz2_cin_cer" );
    function_5c5a58d4d56c8f25( 1023, 3, 0, 0 );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x47895e80, Offset: 0x10ae
// Size: 0x80
function play()
{
    playchopperexfil();
    
    foreach ( player in level.players )
    {
        player clearpredictedstreampos();
    }
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0, eflags: 0x4
// Checksum 0x32c478fe, Offset: 0x1136
// Size: 0x1b3
function private playchopperexfil()
{
    /#
        level thread function_e4f12d9c72d72008();
    #/
    
    level thread function_a6452f76524c61ef( level.players, self.winners );
    
    foreach ( player in self.winners )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player setshowcontrail( 0 );
    }
    
    self.sceneroot scene::pre_stream( self.winners );
    
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
    
    outrofunc();
    self.sceneroot scene::play( self.winners );
    
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
    
    outroendfunc();
}

/#

    // Namespace namespace_c4bfea04500a8c9c
    // Params 0, eflags: 0x4
    // Checksum 0xfd5710a6, Offset: 0x12f1
    // Size: 0x3a, Type: dev
    function private function_8aef03fda147c379()
    {
        self waittill( #"hash_94b93d1bf2fbbb59" );
        
        if ( self.sceneroot scene::get_state() == "<dev string:x24>" )
        {
            self.sceneroot scene::stop();
        }
    }

    // Namespace namespace_c4bfea04500a8c9c
    // Params 0, eflags: 0x4
    // Checksum 0xb2475a3d, Offset: 0x1333
    // Size: 0x33, Type: dev
    function private function_e4f12d9c72d72008()
    {
        level waittill( #"hash_3e26dfc193b4fd86" );
        
        if ( !br_public::isanytutorialorbotpracticematch() )
        {
            setomnvarforallclients( "<dev string:x2c>", 0 );
            setomnvarforallclients( "<dev string:x3c>", -1 );
        }
    }

#/

// Namespace namespace_c4bfea04500a8c9c
// Params 2
// Checksum 0xaa1006f2, Offset: 0x136e
// Size: 0x1da
function function_a6452f76524c61ef( players, winners )
{
    assert( isarray( players ), "<dev string:x57>" + "<dev string:x78>" );
    assert( isarray( winners ), "<dev string:x57>" + "<dev string:x9b>" );
    winner_count = maxint( winners.size, 1 );
    assert( isint( winner_count ), "<dev string:x57>" + "<dev string:xbe>" );
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_1e19065f4a3ef23d":
            intro_music = "mx_br_iw8_exfil_intro_" + winner_count + "player_culture";
            main_music = "mx_br_iw8_exfil_main_" + winner_count + "player_culture";
            break;
        case #"hash_ed580acc26c2838a":
            intro_music = "mx_br_daisy_exfil";
            main_music = "";
            break;
        default:
            intro_music = "mx_br_iw8_exfil_intro_" + winner_count + "player";
            main_music = "mx_br_iw8_exfil_main_" + winner_count + "player";
            break;
    }
    
    wait_time = 12;
    
    switch ( winner_count )
    {
        case 1:
        default:
            wait_time = 11.6;
            break;
        case 2:
            wait_time = 14;
            break;
        case 3:
            wait_time = 15.2;
            break;
        case 4:
            wait_time = 20;
            break;
    }
    
    assert( isnumber( wait_time ) && wait_time > 0, "<dev string:x57>" + "<dev string:xdb>" );
    
    if ( !isdefined( level.musicenabled ) )
    {
        level.musicenabled = 1;
    }
    
    audio_utility::function_6a0ed3b9fb942369( players, intro_music );
    wait wait_time;
    audio_utility::function_6a0ed3b9fb942369( players, main_music );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x60cbc570, Offset: 0x1550
// Size: 0x6b
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
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x5b4e37ad, Offset: 0x15c3
// Size: 0x1d
function outroendfunc()
{
    level thread br_ending_util::function_e89c7c78b10aa4a( undefined, 2, 1 );
    level thread function_7f7b1eab3d58d251();
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x8ec22b92, Offset: 0x15e8
// Size: 0x15
function function_7f7b1eab3d58d251()
{
    wait 60;
    audio_utility::snd_transient_unload( function_931d17ce42432f1d() );
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0xf86f17ae, Offset: 0x1605
// Size: 0x4c
function function_931d17ce42432f1d()
{
    soundbank = "mp_wz2_br_igc_cer_s3_exfil";
    
    if ( utility::issharedfuncdefined( #"hash_b4524d989c7fd1cf", #"getexfilsoundbank" ) )
    {
        soundbank = [[ utility::getsharedfunc( #"hash_b4524d989c7fd1cf", #"getexfilsoundbank" ) ]]();
    }
    
    return soundbank;
}

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x25f7a53f, Offset: 0x165a
// Size: 0x3d
function transientfunc()
{
    if ( utility::issharedfuncdefined( #"hash_b4524d989c7fd1cf", #"get_exfil_transient" ) )
    {
        return [[ utility::getsharedfunc( #"hash_b4524d989c7fd1cf", #"get_exfil_transient" ) ]]();
    }
    
    return "";
}

#using_animtree( "script_model" );

// Namespace namespace_c4bfea04500a8c9c
// Params 0
// Checksum 0x6b2d69d9, Offset: 0x16a0
// Size: 0x24c
function function_e63a9d5ec4b488a0()
{
    argsarray = [];
    guyradius = 30;
    guyheight = 68;
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, %wz_br_cer_exfil_s3_sh020_plyr1@sbundle, 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, %wz_br_cer_exfil_s3_sh020_plyr2@sbundle, 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, %wz_br_cer_exfil_s3_sh020_plyr3@sbundle, 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, %wz_br_cer_exfil_s3_sh020_plyr4@sbundle, 0, undefined, guyradius, guyheight );
    choppermodel = "xcomp_t10_mil_us_heli_medium_trans_wz_exfil_sierra";
    chopperoriginoffset = ( 0, 0, -70 );
    chopperradius = 350;
    choppersegments = 10;
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh020_heli@sbundle, 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh030_heli@sbundle, 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh040_heli@sbundle, 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh050_heli@sbundle, 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh060_heli@sbundle, 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh070_heli@sbundle, 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh070_heli@sbundle, 0.99, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh010_heli@sbundle, chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh020_heli@sbundle, chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh030_heli@sbundle, chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh040_heli@sbundle, chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh050_heli@sbundle, chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh060_heli@sbundle, chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, %wz_br_cer_exfil_s3_sh070_heli@sbundle, chopperoriginoffset, chopperradius, choppersegments );
    return argsarray;
}

