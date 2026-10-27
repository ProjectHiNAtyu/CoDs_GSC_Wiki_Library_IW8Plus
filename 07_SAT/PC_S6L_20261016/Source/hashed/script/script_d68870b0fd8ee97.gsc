// script_d68870b0fd8ee97  (hash_0d68870b0fd8ee97.gscc) (size: 9538 Bytes / 0x2542 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc8530140 (3360883008)
// size ...... 9538 (0x2542)
// includes .. 9   (offset: 0x223a)
// strings ... 38  (offset: 0x2282)
// dev strs .. 3   (offset: 0x2466)
// exports ... 23  (offset: 0x148e)
// cseg ...... 0x4e2 + 0xfac (0x148e)
// imports ... 88  (offset: 0x1826)
// animtree1 . 0   (offset: 0x248a)
// animtree2 . 10  (offset: 0x248a)
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_ending_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\music_br;

#namespace namespace_b730a01c88b3f170;

// Namespace namespace_b730a01c88b3f170
// Params 0, eflags: 0x5
// Checksum 0x77d28eeb, Offset: 0x500
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_e179a026a53bd163", #"br_ending", &pre_main, undefined );
}

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0x60ffcdaa, Offset: 0x529
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
    br_ending::register_exfil( "chopper_saw_s4", exfilstruct );
}

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0xa80022c4, Offset: 0x5b4
// Size: 0xa1
function init()
{
    /#
        setdevdvarifuninitialized( @"hash_70809e88d9881104", 0 );
    #/
    
    level.var_e0308e22e5b02b6c = &function_9263c3eb37cb8039;
    level.var_2c3d783630787a16 = "tag_player";
    utility::delaythread( 0.05, &br_ending_util::function_1c0500c7cf8f9b7, "chopper3" );
    level.var_f152d0d36747c32b = [ "rifle", "smg", "mg", "spread", "sniper", "pistol", "rocketlauncher" ];
    level.var_1f9f1f1326580faa = 1;
    chopperexfil_fx_init();
}

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0xa76b6f7b, Offset: 0x65d
// Size: 0x1b
function chopperexfil_fx_init()
{
    level._effect[ "player_disconnect" ] = loadfxasset( "vfx_iw8_br_gameplay_disconnect_player" );
}

// Namespace namespace_b730a01c88b3f170
// Params 2
// Checksum 0xbadf0f4d, Offset: 0x680
// Size: 0x1f
function function_9263c3eb37cb8039( winnerplayers, var_c71a8bc30a7b241b )
{
    thread function_cf6e6d9cae907f4a( winnerplayers, var_c71a8bc30a7b241b );
}

// Namespace namespace_b730a01c88b3f170
// Params 2, eflags: 0x4
// Checksum 0x356a0b97, Offset: 0x6a7
// Size: 0x26
function private function_cf6e6d9cae907f4a( winners, var_410ded744dab958f )
{
    audio_utility::snd_transient_load( "mp_saw_br_escape_s2_exfil" );
    clearmusicstate();
}

// Namespace namespace_b730a01c88b3f170
// Params 1, eflags: 0x4
// Checksum 0xcd8fb480, Offset: 0x6d5
// Size: 0xbf
function private function_8bc29945c1a477a( var_410ded744dab958f )
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
    
    if ( soundexists( "veh_br_exfil_heli_incoming" ) )
    {
        tempent playsoundonmovingent( "veh_br_exfil_heli_incoming" );
    }
    
    tempent moveto( endorigin, movetime );
    wait movetime;
    tempent delete();
}

// Namespace namespace_b730a01c88b3f170
// Params 1
// Checksum 0xd3371d4f, Offset: 0x79c
// Size: 0x2d5
function pack( var_410ded744dab958f )
{
    level.exfilanimstruct = self;
    var_b8739ba4d53c7cbb = [ "solo", "duo", "trio", "quad" ];
    scenesuffix = "solo";
    
    if ( self.winners.size > 0 && self.winners.size <= var_b8739ba4d53c7cbb.size )
    {
        scenesuffix = var_b8739ba4d53c7cbb[ self.winners.size - 1 ];
    }
    
    sceneroot = spawnstruct();
    sceneroot.origin = self.origin;
    sceneroot.angles = self.angles;
    sceneroot scene::set_scriptbundle( "saw_escape_exfil_s4_" + scenesuffix );
    var_174294bc19644102 = sceneroot scene::get_shot_names();
    scene::add_scene_func( sceneroot, &function_253e7b6290b55b6a, var_174294bc19644102[ 0 ] );
    scene::add_scene_func( sceneroot, &function_d4c5db2b3b71b891, var_174294bc19644102[ var_174294bc19644102.size - 2 ] );
    scene::add_scene_func( sceneroot, &function_d610a176235bd5f4, var_174294bc19644102[ var_174294bc19644102.size - 1 ] );
    self.sceneroot = sceneroot;
    
    if ( !isdefined( var_410ded744dab958f ) )
    {
        var_410ded744dab958f = ( 0, 0, 0 );
    }
    
    level thread function_8bc29945c1a477a( var_410ded744dab958f );
    setomnvarforallclients( "ui_br_infil_exfil_player_focus", -1 );
    
    if ( !getdvarint( @"scr_br_ending_placement" ) )
    {
        if ( getdvarint( @"hash_82bc06c11204070", 1 ) )
        {
            level thread br_ending_util::function_ee3a6a615e19250a( 0, 1.2, "exfil_fadeEnd" );
        }
        
        self.transientname = transientfunc();
        br_ending_util::function_9711748a5c6c12c3( self.transientname );
    }
    
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
    self.sceneroot.lightingrig = br_ending_util::function_88dc0218d2006993( "chopper3" );
}

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0x52b250dc, Offset: 0xa79
// Size: 0x79
function function_253e7b6290b55b6a()
{
    hwconfiguratoraddasset( %"hw_jup_mp_wz2_cin_cer" );
    visionset = "mp_jup_bigmap_wz2_cer_exfil";
    player_utility::_visionsetnaked( visionset, 0 );
    chopperobject = scene::get_object( "Heli" );
    
    if ( isdefined( chopperobject ) && isdefined( self.lightingrig ) )
    {
        br_ending_util::function_4db4aba34fab2da9( self.lightingrig, chopperobject.entity );
    }
    
    function_ab152385cf867235();
}

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0x4a0f5689, Offset: 0xafa
// Size: 0x9
function function_d4c5db2b3b71b891()
{
    function_6f6873223a9285bd();
}

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0x73d1f947, Offset: 0xb0b
// Size: 0x2
function function_d610a176235bd5f4()
{
    
}

// Namespace namespace_b730a01c88b3f170
// Params 0, eflags: 0x4
// Checksum 0xdc4bdb95, Offset: 0xb15
// Size: 0x82
function private function_ab152385cf867235()
{
    foreach ( player in level.players )
    {
        pbgpostfxbundlestart( player, %"hash_364372fd798b98dc" );
    }
}

// Namespace namespace_b730a01c88b3f170
// Params 0, eflags: 0x4
// Checksum 0x23adf132, Offset: 0xb9f
// Size: 0x82
function private function_6f6873223a9285bd()
{
    foreach ( player in level.players )
    {
        pbgpostfxbundlekill( player, %"hash_364372fd798b98dc" );
    }
}

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0xa9378000, Offset: 0xc29
// Size: 0x96
function play()
{
    level notify( #"exfil_fadeEnd" );
    logstring( "FADE TO BLACK DEBUG:  playExfil fade out" );
    playchopperexfil();
    
    foreach ( player in level.players )
    {
        player clearpredictedstreampos();
    }
}

// Namespace namespace_b730a01c88b3f170
// Params 0, eflags: 0x4
// Checksum 0x3cc9b193, Offset: 0xcc7
// Size: 0x1bf
function private playchopperexfil()
{
    /#
        level thread function_e4f12d9c72d72008();
    #/
    
    foreach ( player in self.winners )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isplayer( player ) && !isbot( player ) )
        {
            continue;
        }
        
        player setshowcontrail( 0 );
    }
    
    self.sceneroot scene::pre_stream( self.winners );
    
    if ( !self.istemp )
    {
        music_br::function_a7fb040e884f8833( level.players );
        level thread br_ending_util::function_e89c7c78b10aa4a( 0, 1.75, 0.066 );
        wait 1.75;
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

    // Namespace namespace_b730a01c88b3f170
    // Params 0, eflags: 0x4
    // Checksum 0x25ee6d4a, Offset: 0xe8e
    // Size: 0x3a, Type: dev
    function private function_8aef03fda147c379()
    {
        self waittill( #"hash_94b93d1bf2fbbb59" );
        
        if ( self.sceneroot scene::get_state() == "<dev string:x24>" )
        {
            self.sceneroot scene::stop();
        }
    }

    // Namespace namespace_b730a01c88b3f170
    // Params 0, eflags: 0x4
    // Checksum 0x6afe27d1, Offset: 0xed0
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

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0x6d02d8ae, Offset: 0xf0b
// Size: 0xa1
function outrofunc()
{
    if ( !br_public::isanytutorialorbotpracticematch() )
    {
        if ( !isdefined( level.brwinnerscircle ) && !getdvarint( @"scr_br_ending_play", 0 ) && !getdvarint( @"scr_br_ending_placement", 0 ) )
        {
            setomnvarforallclients( "post_game_state", 14 );
        }
        
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    }
    
    audio_utility::function_63bf1584c79c055( level.players, "scn_wz_exfil_saw_s2_lr" );
    audio_utility::function_7b72e563ad80e020( level.players, "default", 3 );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "solo_cin_igc_music_voiceover_br_hack", 3 );
}

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0x8900b2d3, Offset: 0xfb4
// Size: 0x3c
function outroendfunc()
{
    player_utility::_visionsetnaked( "", 0 );
    hwconfiguratorremoveasset( %"hw_jup_mp_wz2_cin_cer" );
    level thread br_ending_util::function_e89c7c78b10aa4a( undefined, 2, 1 );
    level thread function_7f7b1eab3d58d251();
}

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0x4e94ea0b, Offset: 0xff8
// Size: 0x73
function function_7f7b1eab3d58d251()
{
    audio_utility::function_5b885ff87a1180d4( level.players, "solo_cin_igc_music_voiceover_br_hack", 3 );
    wait 60;
    soundbank = "mp_saw_br_escape_s2_exfil";
    
    if ( utility::issharedfuncdefined( #"hash_e179a026a53bd163", #"getexfilsoundbank" ) )
    {
        soundbank = [[ utility::getsharedfunc( #"hash_e179a026a53bd163", #"getexfilsoundbank" ) ]]();
    }
    
    audio_utility::snd_transient_unload( soundbank );
}

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0xfd4ed8d3, Offset: 0x1073
// Size: 0x3d
function transientfunc()
{
    if ( utility::issharedfuncdefined( #"hash_e179a026a53bd163", #"get_exfil_transient" ) )
    {
        return [[ utility::getsharedfunc( #"hash_e179a026a53bd163", #"get_exfil_transient" ) ]]();
    }
    
    return "";
}

#using_animtree( "script_model" );

// Namespace namespace_b730a01c88b3f170
// Params 0
// Checksum 0xf5d7eff0, Offset: 0x10b9
// Size: 0x3d4
function function_e63a9d5ec4b488a0()
{
    argsarray = [];
    guyradius = 30;
    guyheight = 68;
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, %saw_escape_exfil_s2_sh010_plyr01@sbundle, 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, %saw_escape_exfil_s2_sh010_plyr02@sbundle, 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, %saw_escape_exfil_s2_sh010_plyr03@sbundle, 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, %saw_escape_exfil_s2_sh010_plyr04@sbundle, 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, %saw_escape_exfil_s2_sh010_npc01@sbundle, 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, %saw_escape_exfil_s2_sh010_npc02@sbundle, 0, undefined, guyradius, guyheight );
    choppermodel = "xcomp_t10_mil_us_heli_medium_trans_weapons_wz_exfil";
    chopperoriginoffset = ( 0, 0, -70 );
    choppersegments = 10;
    chopperradius = 350;
    chopperzoffset = -70;
    chopperoriginoffset = ( 0, 0, chopperzoffset );
    usevehicleanimtree = 0;
    var_ad2fa2b94ff60b94 = 12;
    var_943a1b954395e3e = -2;
    var_f8b2cca2f27bae62 = ( 0, 0, var_943a1b954395e3e );
    rear_wheel_radius = 12;
    rear_wheel_z_offset = 5;
    rear_wheel_origin_offset = ( 0, 0, rear_wheel_z_offset );
    tail_rotor_radius = 48;
    tail_rotor_z_offset = 0;
    tail_rotor_origin_offset = ( 0, 0, tail_rotor_z_offset );
    var_55ff43bc93b02923 = 12;
    var_46c79b616ce8ba81 = 0;
    var_b0a5407a6b445d63 = ( 0, 0, var_46c79b616ce8ba81 );
    var_7782ea4747b7485d = 350;
    var_9b44fc1652422bb0 = 36;
    var_5a4c96f0644d3a48 = 360 / var_9b44fc1652422bb0;
    var_99dccda6275a374b = [];
    var_66e12751c63b228e = 0;
    
    for ( i = 0; i < var_9b44fc1652422bb0 ; i++ )
    {
        x_offset = var_7782ea4747b7485d * cos( var_66e12751c63b228e );
        y_offset = var_7782ea4747b7485d * sin( var_66e12751c63b228e );
        z_offset = var_46c79b616ce8ba81;
        var_99dccda6275a374b[ i ] = ( x_offset, y_offset, z_offset );
        var_66e12751c63b228e += var_5a4c96f0644d3a48;
    }
    
    argsarray = br_ending_util::function_4751687f65ee208c( argsarray, choppermodel, %saw_escape_exfil_s4_sh020_heli@sbundle, 0, "wheel_front_r_jnt", var_f8b2cca2f27bae62, var_ad2fa2b94ff60b94, usevehicleanimtree );
    argsarray = br_ending_util::function_4751687f65ee208c( argsarray, choppermodel, %saw_escape_exfil_s4_sh020_heli@sbundle, 0, "wheel_front_l_jnt", var_f8b2cca2f27bae62, var_ad2fa2b94ff60b94, usevehicleanimtree );
    argsarray = br_ending_util::function_4751687f65ee208c( argsarray, choppermodel, %saw_escape_exfil_s4_sh010_heli@sbundle, 0, "wheel_rear_jnt", rear_wheel_origin_offset, rear_wheel_radius, usevehicleanimtree );
    argsarray = br_ending_util::function_4751687f65ee208c( argsarray, choppermodel, %saw_escape_exfil_s4_sh010_heli@sbundle, 0, "tail_rotor_null", tail_rotor_origin_offset, tail_rotor_radius, usevehicleanimtree );
    argsarray = br_ending_util::function_4751687f65ee208c( argsarray, choppermodel, %saw_escape_exfil_s4_sh010_heli@sbundle, 0, "main_rotor_jnt", var_b0a5407a6b445d63, var_55ff43bc93b02923, usevehicleanimtree );
    
    for ( i = 0; i < var_9b44fc1652422bb0 ; i++ )
    {
        argsarray = br_ending_util::function_4751687f65ee208c( argsarray, choppermodel, %saw_escape_exfil_s4_sh010_heli@sbundle, 0, "main_rotor_jnt", var_99dccda6275a374b[ i ], var_55ff43bc93b02923, usevehicleanimtree );
    }
    
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, %saw_escape_exfil_s4_sh010_heli@sbundle, chopperoriginoffset, chopperradius, choppersegments, usevehicleanimtree );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, %saw_escape_exfil_s4_sh020_heli@sbundle, chopperoriginoffset, chopperradius, choppersegments, usevehicleanimtree );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, %saw_escape_exfil_s4_sh030_heli@sbundle, chopperoriginoffset, chopperradius, choppersegments, usevehicleanimtree );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, %saw_escape_exfil_s4_sh040_heli@sbundle, chopperoriginoffset, chopperradius, choppersegments, usevehicleanimtree );
    return argsarray;
}

