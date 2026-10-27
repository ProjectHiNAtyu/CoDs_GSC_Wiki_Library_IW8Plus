// script_b42489114a80a4a  (hash_0b42489114a80a4a.gscc) (size: 17697 Bytes / 0x4521 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6394d896 (1670699158)
// size ...... 17697 (0x4521)
// includes .. 7   (offset: 0x4105)
// strings ... 67  (offset: 0x413d)
// dev strs .. 1   (offset: 0x4515)
// exports ... 36  (offset: 0x2ccd)
// cseg ...... 0x3c6 + 0x2907 (0x2ccd)
// imports ... 117 (offset: 0x326d)
// animtree1 . 0   (offset: 0x4521)
// animtree2 . 0   (offset: 0x4521)
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_infils_common;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\teams;

#namespace namespace_a9890cc332704be1;

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x5
// Checksum 0x5141ccf7, Offset: 0x3e4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_17e41641fbdadf18", #"br_infils_common", &pre_main, undefined );
}

// Namespace namespace_a9890cc332704be1
// Params 0
// Checksum 0x55a93a23, Offset: 0x40d
// Size: 0x13
function pre_main()
{
    br_infils_common::register_infil( "brinfil", &init );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0xce73b6ef, Offset: 0x428
// Size: 0x381
function private init()
{
    assert( isdefined( level.infilstruct ) );
    bundle = br_infils_common::function_962df7256771b267();
    assert( isdefined( bundle ) );
    level.infilstruct.bundle = bundle;
    assert( isdefined( bundle.hwconfig ) );
    level.infilstruct.hwconfig = bundle.hwconfig;
    
    if ( utility::issharedfuncdefined( #"br_infils", #"hash_50d7df11518fd6c8" ) )
    {
        [[ utility::getsharedfunc( #"br_infils", #"hash_50d7df11518fd6c8" ) ]]();
    }
    
    level.var_8f64d94451f73542 = 1;
    level.infilstruct.c130model = bundle.c130model;
    level.infilstruct.var_f265685cdcfee833 = bundle.var_f265685cdcfee833;
    level.infilstruct.var_9d24745d02be135e = bundle.var_9d24745d02be135e;
    level.infilstruct.var_67c8deee3845395d = bundle.var_67c8deee3845395d;
    level.infilstruct.c130soundalias = bundle.c130soundalias;
    level.infilstruct.var_ea87d0ead0c54f1c = bundle.var_ea87d0ead0c54f1c;
    level.infilstruct.var_dfeffb86c1dd09b6 = bundle.var_dfeffb86c1dd09b6;
    level.infilstruct.var_cee5041ecb30a2c5 = &function_fdfe0dc503c4f44;
    level.infilstruct.play_scenesystem = &playscene;
    level.infilstruct.prestream_scenesystem = &prestream;
    level.infilstruct.var_12c03eae53e9bb4c = &function_60ca5349741930ba;
    level.infilstruct.var_57d9814dcb2bcbed = &function_8d9ee8187d2d646b;
    level.infilstruct.var_3bead1a95b75d55d = &function_2295b0f632c0d19d;
    level.infilstruct.jumpfunc = &jumpfunc;
    level.infilstruct.var_9a4f6a9353c9055c = &function_9a4f6a9353c9055c;
    level.infilstruct.var_3a2e6ef0dea2917f = bundle.var_3a2e6ef0dea2917f;
    level.infilstruct.binktime = bundle.binktime - 2;
    level.infilstruct.var_5081bf0daf7ab833 = bundle.binktime;
    orbitcamassets = [];
    
    foreach ( asset in bundle.orbitcamarray )
    {
        orbitcamassets[ orbitcamassets.size ] = asset.camera;
    }
    
    br_infils_util::set_orbit_cam_info( orbitcamassets, bundle.orbitcamsolo );
    br_infils_util::function_8e44037c2a8b1713( "prematch", &prematchstartfunc );
    br_infils_util::function_8e44037c2a8b1713( "cinematic", &cinematicstartfunc );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x6d4f8320, Offset: 0x7b1
// Size: 0xab
function private cinematicstartfunc()
{
    waitframe();
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setentitysoundcontext( "lobby_fade", "", 2 );
        player clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
    }
}

// Namespace namespace_a9890cc332704be1
// Params 1, eflags: 0x4
// Checksum 0xc0031a3b, Offset: 0x864
// Size: 0xa9f
function private function_fdfe0dc503c4f44( movingc130 )
{
    animstruct = spawnstruct();
    animstruct.cleanupfunc = &infilcleanup;
    sceneent = spawnstruct();
    sceneent.origin = ( 0, 0, 0 );
    sceneent.angles = ( 0, 0, 0 );
    bundle = level.infilstruct.bundle;
    assert( isdefined( bundle.var_394fd6963d38cbac ) && isdefined( bundle.var_e18807faf9211575 ) );
    animstruct.staticc130 = getent( bundle.var_394fd6963d38cbac, "targetname" );
    assert( isdefined( animstruct.staticc130 ), "<dev string:x24>" );
    animstruct.staticc130.script_animname = bundle.var_e18807faf9211575;
    animstruct.staticc130 notsolid();
    
    if ( bundle.var_6f9b41f7dd7d93f3 )
    {
        animstruct.staticc130 show();
    }
    
    animstruct.var_5f941378403fe534 = isdefined( animstruct.staticc130 ) && bundle.var_5f941378403fe534;
    animstruct.var_b6e5f06b0c65a1d7 = animstruct.staticc130;
    assert( isdefined( bundle.var_15bb890b6a236ca9 ) );
    animstruct.movingc130 = movingc130;
    animstruct.movingc130.script_animname = bundle.var_15bb890b6a236ca9;
    animstruct.movingc130 notsolid();
    animstruct.var_a542c674f3aff8a0 = isdefined( animstruct.movingc130 ) && bundle.var_a542c674f3aff8a0;
    animstruct.origin = animstruct.staticc130.origin;
    animstruct.angles = animstruct.staticc130.angles;
    level.infilstruct.var_eebe498248baa141 = animstruct.origin;
    animstruct.scenename = bundle.scenename;
    sceneroot = spawnstruct();
    sceneroot.origin = animstruct.origin;
    sceneroot.angles = animstruct.angles;
    sceneroot scene::set_scriptbundle( animstruct.scenename );
    var_174294bc19644102 = sceneroot scene::get_shot_names();
    scene::add_scene_func( sceneroot, &function_1239e5267110edae, var_174294bc19644102[ 0 ] );
    scene::add_scene_func( sceneroot, &function_e614a113e9db2d80, var_174294bc19644102[ var_174294bc19644102.size - 1 ] );
    level.infilstruct.notetrack_anims = [];
    
    for ( i = 0;  ; i++ )
    {
        gprop_anims = sceneroot scene::function_d0df7c35d793d179( "gprop", i );
        
        if ( gprop_anims.size == 0 )
        {
            break;
        }
        
        assert( gprop_anims.size == 1 );
        level.infilstruct.notetrack_anims[ level.infilstruct.notetrack_anims.size ] = gprop_anims[ 0 ];
    }
    
    if ( bundle.hacknotetracks )
    {
        animstruct thread hacknotetrack( "transition" );
        animstruct thread hacknotetrack( "orbit_cam" );
        animstruct thread hacknotetrack( "red_light" );
        animstruct thread hacknotetrack( "green_light" );
        animstruct thread hacknotetrack( "wind_start" );
        animstruct thread hacknotetrack( "infil_header_player" );
        animstruct thread hacknotetrack( "fade_title" );
    }
    else
    {
        sceneroot scene::set_notify_note( animstruct, "transition", "gprop" );
        sceneroot scene::set_notify_note( animstruct, "orbit_cam", "gprop" );
        sceneroot scene::set_notify_note( animstruct, "red_light", "gprop" );
        sceneroot scene::set_notify_note( animstruct, "green_light", "gprop" );
        sceneroot scene::set_notify_note( animstruct, "wind_start", "gprop" );
        sceneroot scene::set_notify_note( animstruct, "infil_header_player", "gprop" );
        sceneroot scene::set_notify_note( animstruct, "fade_title", "gprop" );
    }
    
    animstruct.sceneroot = sceneroot;
    assert( isdefined( bundle.gprop ) );
    animstruct.gprop = animstruct br_infils_util::spawn_script_model( bundle.gprop, "gprop" );
    animstruct.gprop.script_animname = "gprop";
    animstruct.gprop linkto( animstruct.staticc130, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags = [];
    animstruct.playertags[ 0 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "Player Tag 1" );
    animstruct.playertags[ 0 ] linkto( animstruct.gprop, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 1 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "Player Tag 2" );
    animstruct.playertags[ 1 ] linkto( animstruct.gprop, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 2 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "Player Tag 3" );
    animstruct.playertags[ 2 ] linkto( animstruct.gprop, "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 3 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "Player Tag 4" );
    animstruct.playertags[ 3 ] linkto( animstruct.gprop, "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    assert( isdefined( bundle.var_ae14a15491ecbbbb ) && isdefined( bundle.var_c4e472bcfdb2dd9f ) );
    animstruct.var_d206cab225d3c7b0 = [];
    animstruct.var_d206cab225d3c7b0[ 0 ] = animstruct br_infils_util::spawn_script_model( bundle.var_c4e472bcfdb2dd9f, "Player_1_Male" );
    animstruct.var_d206cab225d3c7b0[ 0 ].script_animname = "Player_1_Male";
    animstruct.var_d206cab225d3c7b0[ 0 ] function_3ce65e6c3056261f( 0, bundle.var_ae14a15491ecbbbb, bundle.var_c4e472bcfdb2dd9f, 1 );
    animstruct.var_d206cab225d3c7b0[ 1 ] = animstruct br_infils_util::spawn_script_model( bundle.var_c4e472bcfdb2dd9f, "Player_2_Male" );
    animstruct.var_d206cab225d3c7b0[ 1 ].script_animname = "Player_2_Male";
    animstruct.var_d206cab225d3c7b0[ 1 ] function_3ce65e6c3056261f( 1, bundle.var_ae14a15491ecbbbb, bundle.var_c4e472bcfdb2dd9f, 1 );
    animstruct.var_d206cab225d3c7b0[ 2 ] = animstruct br_infils_util::spawn_script_model( bundle.var_c4e472bcfdb2dd9f, "Player_3_Male" );
    animstruct.var_d206cab225d3c7b0[ 2 ].script_animname = "Player_3_Male";
    animstruct.var_d206cab225d3c7b0[ 2 ] function_3ce65e6c3056261f( 2, bundle.var_ae14a15491ecbbbb, bundle.var_c4e472bcfdb2dd9f, 1 );
    animstruct.var_d206cab225d3c7b0[ 3 ] = animstruct br_infils_util::spawn_script_model( bundle.var_c4e472bcfdb2dd9f, "Player_4_Male" );
    animstruct.var_d206cab225d3c7b0[ 3 ].script_animname = "Player_4_Male";
    animstruct.var_d206cab225d3c7b0[ 3 ] function_3ce65e6c3056261f( 3, bundle.var_ae14a15491ecbbbb, bundle.var_c4e472bcfdb2dd9f, 1 );
    assert( isdefined( bundle.var_b118bd9845c83b2 ) && isdefined( bundle.var_dbd69a82e2295a96 ) );
    animstruct.var_62dee6fe2e66c759 = [];
    animstruct.var_62dee6fe2e66c759[ 0 ] = animstruct br_infils_util::spawn_script_model( bundle.var_dbd69a82e2295a96, "Player_1_Female" );
    animstruct.var_62dee6fe2e66c759[ 0 ].script_animname = "Player_1_Female";
    animstruct.var_62dee6fe2e66c759[ 0 ] function_3ce65e6c3056261f( 0, bundle.var_b118bd9845c83b2, bundle.var_dbd69a82e2295a96, 2 );
    animstruct.var_62dee6fe2e66c759[ 1 ] = animstruct br_infils_util::spawn_script_model( bundle.var_dbd69a82e2295a96, "Player_2_Female" );
    animstruct.var_62dee6fe2e66c759[ 1 ].script_animname = "Player_2_Female";
    animstruct.var_62dee6fe2e66c759[ 1 ] function_3ce65e6c3056261f( 1, bundle.var_b118bd9845c83b2, bundle.var_dbd69a82e2295a96, 2 );
    animstruct.var_62dee6fe2e66c759[ 2 ] = animstruct br_infils_util::spawn_script_model( bundle.var_dbd69a82e2295a96, "Player_3_Female" );
    animstruct.var_62dee6fe2e66c759[ 2 ].script_animname = "Player_3_Female";
    animstruct.var_62dee6fe2e66c759[ 2 ] function_3ce65e6c3056261f( 2, bundle.var_b118bd9845c83b2, bundle.var_dbd69a82e2295a96, 2 );
    animstruct.var_62dee6fe2e66c759[ 3 ] = animstruct br_infils_util::spawn_script_model( bundle.var_dbd69a82e2295a96, "Player_4_Female" );
    animstruct.var_62dee6fe2e66c759[ 3 ].script_animname = "Player_4_Female";
    animstruct.var_62dee6fe2e66c759[ 3 ] function_3ce65e6c3056261f( 3, bundle.var_b118bd9845c83b2, bundle.var_dbd69a82e2295a96, 2 );
    animstruct.var_d1b65c95668c3185 = arraycombine( animstruct.var_d206cab225d3c7b0, animstruct.var_62dee6fe2e66c759 );
    return animstruct;
}

// Namespace namespace_a9890cc332704be1
// Params 1, eflags: 0x4
// Checksum 0xc9ac5558, Offset: 0x130c
// Size: 0x3e
function private hacknotetrack( notetrack )
{
    time = function_978a86207e4ef204( notetrack ) ?? 0;
    assert( time > 0 );
    thread utility::delay_notify( time, notetrack );
}

// Namespace namespace_a9890cc332704be1
// Params 1, eflags: 0x4
// Checksum 0x7a967ce5, Offset: 0x1352
// Size: 0xd1
function private function_978a86207e4ef204( notetrack )
{
    time = 0;
    
    foreach ( animation in level.infilstruct.notetrack_anims )
    {
        notetracktimes = getnotetracktimes( animation, notetrack );
        animlength = getanimlength( animation );
        
        if ( notetracktimes.size > 0 )
        {
            time += notetracktimes[ 0 ] * animlength;
            return time;
        }
        
        time += animlength;
    }
}

// Namespace namespace_a9890cc332704be1
// Params 1
// Checksum 0xf5b774d0, Offset: 0x142c
// Size: 0x74
function prestream( animstruct )
{
    existingents = arraycopy( animstruct.var_d1b65c95668c3185 );
    existingents[ existingents.size ] = animstruct.staticc130;
    existingents[ existingents.size ] = animstruct.movingc130;
    existingents[ existingents.size ] = animstruct.gprop;
    animstruct.sceneroot scene::pre_stream( existingents, undefined, -1 );
}

// Namespace namespace_a9890cc332704be1
// Params 0
// Checksum 0xad9ed170, Offset: 0x14a8
// Size: 0x53
function function_60ca5349741930ba()
{
    bundle = level.infilstruct.bundle;
    assert( isdefined( bundle.streamdist ) );
    self setallstreamloaddist( getdvarint( @"hash_373b5e635f64c953", bundle.streamdist ) );
}

// Namespace namespace_a9890cc332704be1
// Params 1, eflags: 0x4
// Checksum 0xb38fba19, Offset: 0x1503
// Size: 0xd8
function private function_b0d92cfa8cc72e75( players )
{
    assert( isarray( players ) );
    teams = [];
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( teams[ player.team ] ) )
        {
            teams[ player.team ] = [];
        }
        
        teams[ player.team ][ teams[ player.team ].size ] = player;
    }
    
    return teams;
}

// Namespace namespace_a9890cc332704be1
// Params 1
// Checksum 0xbdd437a3, Offset: 0x15e4
// Size: 0xc5
function playscene( animstruct )
{
    existingents = arraycopy( animstruct.var_d1b65c95668c3185 );
    existingents[ existingents.size ] = animstruct.staticc130;
    existingents[ existingents.size ] = animstruct.movingc130;
    existingents[ existingents.size ] = animstruct.gprop;
    animstruct thread handleteleport();
    animstruct thread red_light_func();
    animstruct thread green_light_func();
    animstruct thread wind_func();
    animstruct thread player_intro_func();
    animstruct thread fade_title_func();
    animstruct.sceneroot scene::function_f922341b264d32c8( 0 );
    animstruct.sceneroot thread scene::play( existingents );
    animstruct waittill( #"orbit_cam" );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x48a14594, Offset: 0x16b1
// Size: 0x31
function private function_67ba837c885936f7()
{
    self playerhide( 1 );
    self setshowcontrail( 0 );
    self setisinfilskydive( 0 );
    self function_a565dafac620d68e( level.infilstruct.hwconfig );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0xe9f844d3, Offset: 0x16ea
// Size: 0x123
function private function_1239e5267110edae()
{
    bundle = level.infilstruct.bundle;
    
    if ( bundle.var_63bccfc59339f747 )
    {
        audio_utility::function_63bf1584c79c055( level.infilstruct.players, bundle.var_63bccfc59339f747 );
    }
    
    windreset();
    thread lights_initial();
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player playerhide( 1 );
        player setshowcontrail( 0 );
        player setisinfilskydive( 0 );
        player function_a565dafac620d68e( level.infilstruct.hwconfig );
    }
    
    br_infils_util::function_fffda20dc2c2df07( &function_67ba837c885936f7 );
}

// Namespace namespace_a9890cc332704be1
// Params 2, eflags: 0x4
// Checksum 0x774bbe0d, Offset: 0x1815
// Size: 0x1f2
function private function_bf542dced3374f3f( controllerstate, planestate )
{
    bundle = level.infilstruct.bundle;
    assert( isdefined( bundle.var_8e3eb76d39463740 ) );
    light_controllers = undefined;
    
    if ( level.infilstruct.animstruct.var_8516ae7cc1d66f93 )
    {
        light_controllers = level.infilstruct.animstruct.light_controllers;
    }
    else
    {
        light_controllers = getentitylessscriptablearray( bundle.var_8e3eb76d39463740, "targetname" );
        level.infilstruct.animstruct.light_controllers = light_controllers;
        level.infilstruct.animstruct.var_8516ae7cc1d66f93 = 1;
    }
    
    foreach ( controller in light_controllers )
    {
        controller setscriptablepartstate( "lights", controllerstate );
    }
    
    if ( level.infilstruct.animstruct.var_5f941378403fe534 )
    {
        level.infilstruct.animstruct.staticc130 setscriptablepartstate( "interior_lights", planestate );
    }
    
    if ( level.infilstruct.animstruct.var_a542c674f3aff8a0 )
    {
        level.infilstruct.animstruct.movingc130 setscriptablepartstate( "interior_lights", planestate );
    }
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0xd57e949e, Offset: 0x1a0f
// Size: 0x104
function private lights_initial()
{
    waitframe();
    
    if ( level.infilstruct.animstruct.var_5f941378403fe534 )
    {
        level.infilstruct.animstruct.staticc130 setscriptablepartstate( "interior_ambient_lights", "on" );
        level.infilstruct.animstruct.staticc130 setscriptablepartstate( "interior_white_lights", "on" );
    }
    
    if ( level.infilstruct.animstruct.var_a542c674f3aff8a0 )
    {
        level.infilstruct.animstruct.movingc130 setscriptablepartstate( "interior_ambient_lights", "on" );
        level.infilstruct.animstruct.movingc130 setscriptablepartstate( "interior_white_lights", "on" );
    }
    
    function_bf542dced3374f3f( "yellow", "amber_lights" );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0xd590f871, Offset: 0x1b1b
// Size: 0x13
function private lights_red()
{
    function_bf542dced3374f3f( "red", "red_lights" );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x7c05d6f0, Offset: 0x1b36
// Size: 0x13
function private lights_green()
{
    function_bf542dced3374f3f( "green", "green_lights" );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0xd69a7b11, Offset: 0x1b51
// Size: 0x1e5
function private function_e614a113e9db2d80()
{
    camera_obj = scene::get_object( "gprop" );
    camera_ent = camera_obj.entity;
    assert( level.infilstruct.bundle.camerabone );
    camera_tag = level.infilstruct.bundle.camerabone;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player stopxcam();
        player cameralinkto( camera_ent, camera_tag, 1, 1 );
    }
    
    br_infils_util::allplayers_setfov( 65 );
    animlength = getanimlength( level.infilstruct.notetrack_anims[ level.infilstruct.notetrack_anims.size - 1 ] );
    assert( animlength > 0 );
    wait animlength;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player cameraunlink();
    }
}

// Namespace namespace_a9890cc332704be1
// Params 1, eflags: 0x4
// Checksum 0xf0771ba1, Offset: 0x1d3e
// Size: 0xc8
function private function_8d9ee8187d2d646b( player )
{
    sceneroot = self.sceneroot;
    camera_obj = sceneroot scene::get_object( "gprop" );
    camera_ent = camera_obj.entity;
    assert( level.infilstruct.bundle.camerabone );
    camera_tag = level.infilstruct.bundle.camerabone;
    cameraorigin = camera_ent gettagorigin( camera_tag );
    cameraangles = camera_ent gettagangles( camera_tag );
    return [ cameraorigin, cameraangles ];
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0xe502327e, Offset: 0x1e0f
// Size: 0x71
function private handleteleport()
{
    teleporttime = function_978a86207e4ef204( "transition" ) ?? 0;
    
    if ( teleporttime <= 0 )
    {
        teleporttime = getdvarfloat( @"hash_1968fc42f31e7d28", 5.5 );
    }
    
    thread function_77f9566e4d28cf67( teleporttime );
    
    if ( teleporttime > 0 )
    {
        utility::delaythreadendon( teleporttime, "stopScene", &teleporttomovingplane );
        return;
    }
    
    teleporttomovingplane();
}

// Namespace namespace_a9890cc332704be1
// Params 1, eflags: 0x4
// Checksum 0xb26a5120, Offset: 0x1e88
// Size: 0x110
function private function_77f9566e4d28cf67( teleporttime )
{
    fadedowntime = 0.5;
    fadeuptime = 0.5;
    fadedownstarttime = teleporttime - 0.5;
    fadeupstarttime = teleporttime + 0.05;
    fadedownwaittime = fadedownstarttime;
    fadeupwaittime = fadeupstarttime - fadedownwaittime;
    
    if ( fadedownwaittime > 0 )
    {
        wait fadedownwaittime;
    }
    
    fadeduration = getdvarfloat( @"hash_731bce8a2771bda4", fadedowntime );
    fadecolor = getdvar( @"hash_b9a6d6891e3dd553", "white" );
    br_infils_util::function_c050cae6f9bcb77f( fadeduration, level.infilstruct.players, "teleport", fadecolor );
    
    if ( fadeupwaittime > 0 )
    {
        wait fadeupwaittime;
    }
    
    fadeduration = getdvarfloat( @"hash_46db1612124a7775", fadeuptime );
    br_infils_util::function_573cdd2bc439ec67( fadeduration, level.infilstruct.players, "teleport" );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x34e1a75d, Offset: 0x1fa0
// Size: 0x16
function private red_light_func()
{
    self waittill( #"red_light" );
    lights_red();
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x97fb9f77, Offset: 0x1fbe
// Size: 0x16
function private green_light_func()
{
    self waittill( #"green_light" );
    lights_green();
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0xf90bed92, Offset: 0x1fdc
// Size: 0x1ca
function private wind_func()
{
    self waittill( #"wind_start" );
    windstarttime = function_978a86207e4ef204( "wind_start" ) ?? 0;
    var_e7a3f66c36f7dbf0 = function_978a86207e4ef204( "wind_full" ) ?? 0;
    var_2c40d03b33c1b65e = var_e7a3f66c36f7dbf0 - windstarttime;
    
    if ( var_2c40d03b33c1b65e > 0 )
    {
        settings = [ "10", "20", "30", "40", "50", "60", "70", "80", "90", "100" ];
        settingscount = settings.size;
        waitinterval = var_2c40d03b33c1b65e / settingscount;
        
        foreach ( setting in settings )
        {
            foreach ( player in self.var_d1b65c95668c3185 )
            {
                player setscriptablepartstate( "wind", setting );
            }
            
            wait waitinterval;
        }
    }
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x1d70572, Offset: 0x21ae
// Size: 0x97
function private windreset()
{
    foreach ( player in level.infilstruct.animstruct.var_d1b65c95668c3185 )
    {
        player setscriptablepartstate( "wind", "0" );
    }
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x8ee7930c, Offset: 0x224d
// Size: 0x1b
function private player_intro_func()
{
    self waittill( #"infil_header_player" );
    setomnvarforallclients( "ui_br_infil_exfil_player_focus", 1 );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x267a6056, Offset: 0x2270
// Size: 0x67
function private fade_title_func()
{
    self waittill( #"fade_title" );
    sceneroot = self.sceneroot;
    title_obj = sceneroot scene::get_object( "title_card" );
    title_ent = title_obj.entity;
    
    if ( isdefined( title_ent ) )
    {
        title_ent setscriptablepartstate( "base", "fade" );
    }
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x40f1c76e, Offset: 0x22df
// Size: 0x2c
function private function_17bd92ed8041faf4()
{
    self setallstreamloaddist( 0 );
    self clearpredictedstreampos();
    self function_72cf2eee8e035013( level.infilstruct.hwconfig );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0xab1d5e09, Offset: 0x2313
// Size: 0x1ad
function private teleporttomovingplane()
{
    br_infils_util::allplayers_setfov( 65 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setallstreamloaddist( 0 );
        player clearpredictedstreampos();
        assert( player.infilanimindex <= self.playertags.size );
        linkent = self.playertags[ player.infilanimindex - 1 ];
        player playerlinkto( linkent, "tag_player" );
    }
    
    if ( isdefined( self.movingc130 ) )
    {
        self.movingc130 show();
        self.gprop unlink();
        self.gprop linkto( self.movingc130, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        
        if ( !level.infilstruct.var_df720711dd79fea7 || br_infils_util::function_7d2f9d2a086bd511() )
        {
            self.movingc130 notify( #"hash_d0cece8150e8d326" );
        }
    }
    
    setomnvar( "ui_hide_player_icons", 0 );
    level notify( #"hash_c14217752dacdeed" );
    thread function_327cc5b9e5eeb626();
    br_infils_util::function_fffda20dc2c2df07( &function_17bd92ed8041faf4 );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x60bd33a7, Offset: 0x24c8
// Size: 0x101
function private function_327cc5b9e5eeb626()
{
    waitframe();
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_72cf2eee8e035013( level.infilstruct.hwconfig );
    }
    
    wait 0.1;
    bundle = level.infilstruct.bundle;
    
    if ( bundle.var_6f9b41f7dd7d93f3 )
    {
        animstruct = self;
        assert( isdefined( animstruct.staticc130 ) );
        animstruct.staticc130 hide();
    }
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x14ca71ff, Offset: 0x25d1
// Size: 0x256
function private function_2295b0f632c0d19d()
{
    bundle = level.infilstruct.bundle;
    var_7ac18a39f81dd485 = self getplayerangles( 1 );
    playerforward = anglestoforward( var_7ac18a39f81dd485 );
    planeforward = anglestoforward( level.infilstruct.c130.angles );
    planeright = anglestoright( level.infilstruct.c130.angles );
    dotforward = vectordot( playerforward, planeforward );
    dotright = vectordot( playerforward, planeright );
    
    if ( !isdefined( self.infilanimindex ) )
    {
        self.infilanimindex = 1;
    }
    
    player_link_tag = "j_prop_2";
    
    switch ( self.infilanimindex )
    {
        case 2:
            player_link_tag = "j_prop_4";
            break;
        case 3:
            player_link_tag = "j_prop_3";
            break;
        case 4:
            player_link_tag = "j_prop_5";
            break;
        default:
            break;
    }
    
    cos45 = cos( 45 );
    info = undefined;
    
    if ( dotforward < -1 * cos45 )
    {
        info = bundle.var_23794d83de217262;
    }
    
    if ( dotright > cos45 )
    {
        info = bundle.var_747857e512b1a46a;
    }
    else if ( dotright < -1 * cos45 )
    {
        info = bundle.var_fee02e441e859b6c;
    }
    else if ( dotright > 0 )
    {
        info = bundle.var_4fb94c7dbf471b8;
    }
    else
    {
        info = bundle.var_b447d56e5585ce4e;
    }
    
    propanimname = getanimname( info.propanimref.id );
    propanimref = info.propanimref.id;
    playeranimname = getanimname( info.playeranimname.id );
    return [ propanimname, propanimref, playeranimname, player_link_tag ];
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x74735fed, Offset: 0x2830
// Size: 0x1f8
function private jumpfunc()
{
    if ( getdvarint( @"hash_549df6ab370a2bc4", 1 ) )
    {
        self lerpfovscalefactor( 0, 0 );
        self setclientdvar( @"cg_disable_user_fov", 0 );
    }
    
    self playershow();
    teamplayers = teams::getteamdata( self.team, "players" );
    
    foreach ( player in teamplayers )
    {
        var_d38ab4ea0d9bd7e3 = undefined;
        var_e22ced506f04a83a = undefined;
        
        if ( player == self )
        {
            var_d38ab4ea0d9bd7e3 = level.infilstruct.animstruct.var_d206cab225d3c7b0[ 0 ];
            var_e22ced506f04a83a = level.infilstruct.animstruct.var_62dee6fe2e66c759[ 0 ];
        }
        else if ( self.sessionuimemberindex == 0 )
        {
            var_d38ab4ea0d9bd7e3 = level.infilstruct.animstruct.var_d206cab225d3c7b0[ player.sessionuimemberindex ];
            var_e22ced506f04a83a = level.infilstruct.animstruct.var_62dee6fe2e66c759[ player.sessionuimemberindex ];
        }
        else
        {
            var_d38ab4ea0d9bd7e3 = level.infilstruct.animstruct.var_d206cab225d3c7b0[ self.sessionuimemberindex ];
            var_e22ced506f04a83a = level.infilstruct.animstruct.var_62dee6fe2e66c759[ self.sessionuimemberindex ];
        }
        
        if ( isdefined( var_d38ab4ea0d9bd7e3 ) && isdefined( var_e22ced506f04a83a ) )
        {
            var_d38ab4ea0d9bd7e3 hidefromplayer( player );
            var_e22ced506f04a83a hidefromplayer( player );
        }
    }
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x700b2e35, Offset: 0x2a30
// Size: 0x84
function private function_9a4f6a9353c9055c()
{
    self endon( #"disconnect" );
    self lerpfov( 65, 0.5 );
    
    if ( getdvarint( @"hash_549df6ab370a2bc4", 1 ) )
    {
        self lerpfovscalefactor( 1, 0.5 );
    }
    
    wait 1;
    
    if ( isdefined( self.var_5d1d2a9db3eeaa3f ) )
    {
        self.var_5d1d2a9db3eeaa3f = undefined;
        self disablephysicaldepthoffieldscripting();
    }
    
    self setclientdvar( @"cg_fov", 65 );
    self setclientdvar( @"cg_disable_user_fov", 0 );
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0x75361fa9, Offset: 0x2abc
// Size: 0x51
function private prematchstartfunc()
{
    level.nosuspensemusic = 1;
    
    if ( level.infilstruct.bundle.var_4533ea5379984915 )
    {
        audio_utility::snd_transient_load( level.infilstruct.bundle.var_4533ea5379984915 );
    }
}

// Namespace namespace_a9890cc332704be1
// Params 0, eflags: 0x4
// Checksum 0xf2376b31, Offset: 0x2b15
// Size: 0x1b8
function private infilcleanup()
{
    self.sceneroot scene::pre_stream( undefined, undefined, 0 );
    self.sceneroot scene::cleanup( 1 );
    br_infils_util::function_3855f5796f4d2b65();
    
    if ( level.infilstruct.bundle.var_4533ea5379984915 )
    {
        audio_utility::snd_transient_unload( level.infilstruct.bundle.var_4533ea5379984915 );
    }
    
    br_infils_common::cleanupents();
    
    foreach ( playermover in self.var_d1b65c95668c3185 )
    {
        if ( isdefined( playermover ) )
        {
            playermover delete();
        }
    }
    
    self.var_d206cab225d3c7b0 = undefined;
    self.var_62dee6fe2e66c759 = undefined;
    self.var_d1b65c95668c3185 = undefined;
    
    foreach ( playertag in self.playertags )
    {
        if ( isdefined( playertag ) )
        {
            playertag delete();
        }
    }
    
    self.playertags = undefined;
    
    if ( isdefined( self.gprop ) )
    {
        self.gprop delete();
    }
}

