// scripts\mp\br\gametypes\br_infils_ac130_v0.gsc  (hash_55599db61ea39d51.gscc) (size: 16240 Bytes / 0x3f70 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x17b6829b (397836955)
// size ...... 16240 (0x3f70)
// includes .. 8   (offset: 0x39a0)
// strings ... 96  (offset: 0x39e0)
// dev strs .. 0   (offset: 0x3f70)
// exports ... 27  (offset: 0x2a48)
// cseg ...... 0x8ee + 0x215a (0x2a48)
// imports ... 87  (offset: 0x2e80)
// animtree1 . 0   (offset: 0x3f70)
// animtree2 . 0   (offset: 0x3f70)
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_infils_common;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\streamhint;

#namespace br_infils_ac130_v0;

// Namespace br_infils_ac130_v0
// Params 0
// Checksum 0x4beee249, Offset: 0x90c
// Size: 0x117
function init()
{
    assert( isdefined( level.infilstruct ) );
    level.infilstruct.var_cee5041ecb30a2c5 = &function_a8719d48afa1b495;
    level.infilstruct.var_3bead1a95b75d55d = &function_2295b0f632c0d19d;
    level.infilstruct.var_3a2e6ef0dea2917f = "mp_donetsk_c130_intro";
    level.infilstruct.binktime = 3.2;
    orbitcamassets = [ "cam_orbit_br_ac130_player1", "cam_orbit_br_ac130_player2", "cam_orbit_br_ac130_player3", "cam_orbit_br_ac130_player4" ];
    br_infils_util::set_orbit_cam_info( orbitcamassets );
    br_infils_util::function_8e44037c2a8b1713( "prematch", &prematchstartfunc );
    br_infils_util::function_8e44037c2a8b1713( "cinematic", &videostartfunc );
    br_infils_util::function_8e44037c2a8b1713( "animatic", &animaticstartfunc );
    level._effect[ "vfx_br_ac130_clouds" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_ac130_clouds" );
    level._effect[ "vfx_br_infil_cloud_anim" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_cloud_anim" );
}

// Namespace br_infils_ac130_v0
// Params 1
// Checksum 0xbb244777, Offset: 0xa2b
// Size: 0xd32
function function_a8719d48afa1b495( movingc130 )
{
    animstruct = spawnstruct();
    animstruct.origin = getdvarvector( @"br_infil_anim_pos", ( 0, 0, 0 ) );
    animstruct.angles = ( 0, 0, 0 );
    animstruct.cleanupfunc = &function_fa70e3629f82e53b;
    animstruct.var_751e0e63f6c6f6ec = &function_1ad287fcb5253b3c;
    animstruct.movingc130 = movingc130;
    animstruct.staticc130 = getent( "infil_plane", #script_noteworthy );
    
    if ( isdefined( animstruct.staticc130 ) )
    {
        animstruct.staticc130 show();
        animstruct.staticc130.animname = "c130";
    }
    else
    {
        animstruct.staticc130 = animstruct br_infils_util::spawn_script_model( "veh8_mil_air_acharlie130_magma_animated", "c130" );
    }
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.movingc130.animname = "movingC130";
        animstruct.movingc130.innards.animname = "movingC130";
        animstruct.movingc130.animstruct = animstruct;
    }
    
    animstruct.camera = animstruct br_infils_util::spawn_script_model( "generic_prop_x5", "camera" );
    animstruct.camera linkto( animstruct.staticc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.movingcam = animstruct br_infils_util::spawn_script_model( "generic_prop_x5", "cameramoving" );
        animstruct.movingcam linkto( animstruct.movingc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    animstruct.var_21f0343cdb0961ac = animstruct br_infils_util::spawn_script_model( "generic_prop_x5", "parent" );
    animstruct.var_21f0343cdb0961ac linkto( animstruct.staticc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags = [];
    animstruct.playertags[ 0 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag1" );
    animstruct.playertags[ 1 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag2" );
    animstruct.playertags[ 2 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag3" );
    animstruct.playertags[ 3 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag4" );
    animstruct.playertags[ 0 ] linkto( animstruct.var_21f0343cdb0961ac, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 1 ] linkto( animstruct.var_21f0343cdb0961ac, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 2 ] linkto( animstruct.var_21f0343cdb0961ac, "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 3 ] linkto( animstruct.var_21f0343cdb0961ac, "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels = [];
    animstruct.playermodels[ 0 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player1" );
    animstruct.playermodels[ 1 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player2" );
    animstruct.playermodels[ 2 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player3" );
    animstruct.playermodels[ 3 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player4" );
    animstruct.playermodels[ 0 ] linkto( animstruct.playertags[ 0 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 1 ] linkto( animstruct.playertags[ 1 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 2 ] linkto( animstruct.playertags[ 2 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 3 ] linkto( animstruct.playertags[ 3 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.doorchief = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "doorChief" );
    animstruct.doorchief linkto( animstruct.var_21f0343cdb0961ac, "j_prop_5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.cloudanimfx = spawnfx( level._effect[ "vfx_br_infil_cloud_anim" ], animstruct.staticc130.origin );
    animstruct.packs = [];
    n = 0;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene1" );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_418b6894c6117b16 );
    animstruct.packs[ n ] br_infils_util::function_9597cbd14a6857e3( [], &function_49745c7eb311e7db );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.staticc130, level.br_anim[ "sdr_mp_infil_ac130_redux_players_ac130" ] );
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130, level.br_anim[ "sdr_mp_infil_ac130_redux_players_ac130" ] );
    }
    
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camera, level.br_anim[ "sdr_mp_infil_ac130_redux_players_cam" ] );
    
    if ( isdefined( animstruct.movingcam ) )
    {
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingcam, level.br_anim[ "sdr_mp_infil_ac130_redux_players_cam" ] );
    }
    
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_21f0343cdb0961ac, level.br_anim[ "sdr_mp_infil_ac130_redux_character_link" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "sdr_mp_infil_ac130_redux_player1" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "sdr_mp_infil_ac130_redux_player2" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "sdr_mp_infil_ac130_redux_player3" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "sdr_mp_infil_ac130_redux_player4" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "sdr_mp_infil_ac130_redux_player1" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "sdr_mp_infil_ac130_redux_player2" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "sdr_mp_infil_ac130_redux_player3" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "sdr_mp_infil_ac130_redux_player4" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.doorchief, level.br_anim[ "sdr_mp_infil_ac130_redux_doorchief" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camera, [ "j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4" ], level.br_anim[ "sdr_mp_infil_ac130_redux_players_ac130" ] );
    
    if ( !isdefined( level.scr_notetrack[ "c130" ][ "any" ][ "gored" ] ) )
    {
        animation::addnotetrack_customfunction( "c130", "gored", &function_c3c0fb045468d829 );
        animation::addnotetrack_customfunction( "c130", "gogreen", &greenlightfunc );
        animation::addnotetrack_customfunction( "c130", "opendoor", &function_89803b991877c99b );
        animation::addnotetrack_customfunction( "c130", "transitionstart", &function_7e34cbf1b9243cb4 );
        animation::addnotetrack_customfunction( "camera", "transition", &transitionfunc );
    }
    
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "looping", 1 );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_d08f2d7f11cd8058 );
    animstruct.packs[ n ] br_infils_util::function_9597cbd14a6857e3( [], &function_e5ebb228460bf05 );
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130, level.br_anim[ "sdr_mp_infil_ac130_loop2_plane" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130.innards, level.br_anim[ "sdr_mp_infil_ac130_loop2_plane" ] );
    }
    
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_21f0343cdb0961ac, level.br_anim[ "sdr_mp_infil_ac130_loop_genpropx10" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "sdr_mp_infil_ac130_loop_pl01" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "sdr_mp_infil_ac130_loop_pl02" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "sdr_mp_infil_ac130_loop_pl03" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "sdr_mp_infil_ac130_loop_pl04" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "sdr_mp_infil_ac130_loop_pl01" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "sdr_mp_infil_ac130_loop_pl02" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "sdr_mp_infil_ac130_loop_pl03" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "sdr_mp_infil_ac130_loop_pl04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.doorchief, level.br_anim[ "sdr_mp_infil_ac130_loop_doorchief" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camera, [ "j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4" ] );
    return animstruct;
}

// Namespace br_infils_ac130_v0
// Params 1
// Checksum 0xd2f36de4, Offset: 0x1766
// Size: 0x73
function function_418b6894c6117b16( array )
{
    if ( isdefined( self.movingc130 ) )
    {
        self.movingc130 stoploopsound();
    }
    
    self.doorchief hide();
    playfxontag( level._effect[ "vfx_br_ac130_clouds" ], self.staticc130, "tag_body" );
    thread clearsoundsubmixmpbrinfilanim();
    thread offlight();
    thread infil_light_dvars();
    thread delaystreamtomovingplane();
}

// Namespace br_infils_ac130_v0
// Params 2
// Checksum 0x71c48043, Offset: 0x17e1
// Size: 0xe0
function function_49745c7eb311e7db( player, array )
{
    assert( isdefined( player ) );
    var_d4c0c761c30a5938 = 34;
    var_ce05f4f6be26fe25 = 5.6;
    var_557b4c05a5389149 = 50.7;
    var_a401234361e805a0 = 2;
    var_2236739e78e9538b = 4;
    player setsoundsubmix( "mp_br_infil_anim", 0 );
    player setsoundsubmix( "mp_br_infil_music", 0 );
    player setsoundsubmix( "mp_br_infil_ac130", 0 );
    player setclienttriggeraudiozone( "mp_br_c130_infil_int", 1 );
    player setclientdvar( @"cg_fov", var_d4c0c761c30a5938 );
    player enablephysicaldepthoffieldscripting();
    player setphysicaldepthoffield( var_ce05f4f6be26fe25, var_557b4c05a5389149, var_a401234361e805a0, var_2236739e78e9538b );
    self.doorchief showtoplayer( player );
}

// Namespace br_infils_ac130_v0
// Params 1
// Checksum 0xe7426b40, Offset: 0x18c9
// Size: 0x5c
function function_d08f2d7f11cd8058( array )
{
    stopfxontag( level._effect[ "vfx_br_ac130_clouds" ], self.staticc130, "tag_body" );
    self.staticc130 stoploopsound();
    
    if ( isdefined( self.movingc130 ) )
    {
        self.movingc130 playloopsound( "br_ac130_lp" );
    }
}

// Namespace br_infils_ac130_v0
// Params 2
// Checksum 0x6afc343b, Offset: 0x192d
// Size: 0x15
function function_e5ebb228460bf05( player, array )
{
    
}

// Namespace br_infils_ac130_v0
// Params 0
// Checksum 0x9fb976a, Offset: 0x194a
// Size: 0x10
function function_fa70e3629f82e53b()
{
    br_infils_util::function_3855f5796f4d2b65();
    br_infils_common::cleanupents();
}

// Namespace br_infils_ac130_v0
// Params 0, eflags: 0x4
// Checksum 0xec0b152d, Offset: 0x1962
// Size: 0xa3
function private clearsoundsubmixmpbrinfilanim()
{
    br_infils_util::waitandpause( 0.65 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "mp_br_infil_anim", 3 );
    }
}

// Namespace br_infils_ac130_v0
// Params 0, eflags: 0x4
// Checksum 0xd2cf28c7, Offset: 0x1a0d
// Size: 0xa3
function private clearsoundsubmixfadetoblackamb()
{
    br_infils_util::waitandpause( 0.5 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "fade_to_black_all_except_music_scripted5_and_amb_br_hack", 1 );
    }
}

// Namespace br_infils_ac130_v0
// Params 0, eflags: 0x4
// Checksum 0x9f1a0d3b, Offset: 0x1ab8
// Size: 0xa3
function private clearsoundsubmixmpbrinfilac130()
{
    br_infils_util::waitandpause( 7.7 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "mp_br_infil_ac130", 30 );
    }
}

// Namespace br_infils_ac130_v0
// Params 0, eflags: 0x4
// Checksum 0x4b6d0e3f, Offset: 0x1b63
// Size: 0x9a
function private offlight()
{
    lightcontrollers = getentitylessscriptablearray( "infil_blinking_light", #script_noteworthy );
    
    foreach ( lightcontroller in lightcontrollers )
    {
        lightcontroller setscriptablepartstate( "light_blinking_slow", "light_off_hold", 1 );
    }
}

// Namespace br_infils_ac130_v0
// Params 1, eflags: 0x4
// Checksum 0x3382aae6, Offset: 0x1c05
// Size: 0xa4
function private function_c3c0fb045468d829( c130 )
{
    lightcontrollers = getentitylessscriptablearray( "infil_blinking_light", #script_noteworthy );
    
    foreach ( lightcontroller in lightcontrollers )
    {
        lightcontroller setscriptablepartstate( "light_blinking_slow", "light_on", 1 );
    }
}

// Namespace br_infils_ac130_v0
// Params 1, eflags: 0x4
// Checksum 0x583eb6f6, Offset: 0x1cb1
// Size: 0xa4
function private greenlightfunc( c130 )
{
    lightcontrollers = getentitylessscriptablearray( "infil_blinking_light", #script_noteworthy );
    
    foreach ( lightcontroller in lightcontrollers )
    {
        lightcontroller setscriptablepartstate( "light_blinking_slow", "light_jump", 1 );
    }
}

// Namespace br_infils_ac130_v0
// Params 1, eflags: 0x4
// Checksum 0x3549ce50, Offset: 0x1d5d
// Size: 0xd3
function private function_89803b991877c99b( c130 )
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) || isbot( player ) )
        {
            continue;
        }
        
        player player::setwind( "100", 1 );
    }
    
    level.infilstruct.animstruct.doorchief player::setwind( "100" );
}

// Namespace br_infils_ac130_v0
// Params 0, eflags: 0x4
// Checksum 0xb3f5be70, Offset: 0x1e38
// Size: 0xb4
function private clearplayerwind()
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player player::setwind( "1" );
        player.manualoverridewindmaterial = undefined;
    }
    
    self.doorchief player::setwind( "0" );
}

// Namespace br_infils_ac130_v0
// Params 1, eflags: 0x4
// Checksum 0xc250c6f5, Offset: 0x1ef4
// Size: 0x2e
function private function_7e34cbf1b9243cb4( c130 )
{
    triggerfx( level.infilstruct.animstruct.cloudanimfx );
}

// Namespace br_infils_ac130_v0
// Params 1, eflags: 0x4
// Checksum 0x4a02e7d7, Offset: 0x1f2a
// Size: 0x46e
function private transitionfunc( c130 )
{
    level.infilstruct.animstruct notify( #"infil_reset_light_dvars" );
    level.infilstruct.animstruct clearplayerwind();
    var_18d0df245861d5ee = 65;
    var_a8f0a20f605c8643 = 14;
    var_77bbca38fad0b92b = 35;
    var_daed827896c0c1f6 = 2;
    var_be99de3cab37743d = 4;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setallstreamloaddist( 0 );
        player setclienttriggeraudiozone( "mp_br_c130_infil_ext", 2 );
    }
    
    if ( isdefined( level.infilstruct.animstruct.movingc130 ) )
    {
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            cameraent = level.infilstruct.animstruct.movingcam;
            cameratag = undefined;
            
            if ( isarray( level.infilstruct.animstruct.activepack.camerainfo.var_a87edda589012079 ) )
            {
                assert( player.infilanimindex <= level.infilstruct.animstruct.activepack.camerainfo.var_a87edda589012079.size );
                cameratag = level.infilstruct.animstruct.activepack.camerainfo.var_a87edda589012079[ player.infilanimindex - 1 ];
            }
            else
            {
                cameratag = level.infilstruct.animstruct.activepack.camerainfo.var_a87edda589012079;
            }
            
            player cameraunlink();
            player cameralinkto( cameraent, cameratag, 1, 1 );
            player setclientdvar( @"cg_fov", var_18d0df245861d5ee );
            player setphysicaldepthoffield( var_a8f0a20f605c8643, var_77bbca38fad0b92b, var_daed827896c0c1f6, var_be99de3cab37743d );
        }
        
        level thread clearsoundsubmixfadetoblackamb();
        
        if ( isdefined( level.infilstruct.animstruct.cloudanimfx ) )
        {
            level.infilstruct.animstruct.cloudanimfx.origin = level.infilstruct.animstruct.movingc130.origin;
        }
        
        level.infilstruct.animstruct.var_21f0343cdb0961ac unlink();
        level.infilstruct.animstruct.var_21f0343cdb0961ac linkto( level.infilstruct.animstruct.movingc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.infilstruct.animstruct.movingc130 notify( #"start_moving" );
    }
    
    level.infilstruct.animstruct.staticc130 hide();
    setomnvar( "ui_hide_player_icons", 0 );
    level thread clearsoundsubmixmpbrinfilac130();
}

// Namespace br_infils_ac130_v0
// Params 0, eflags: 0x4
// Checksum 0xfce4f58e, Offset: 0x23a0
// Size: 0x13
function private infil_light_dvars()
{
    utility::waittill_any( "infil_reset_light_dvars", "stopScene" );
}

// Namespace br_infils_ac130_v0
// Params 0, eflags: 0x4
// Checksum 0x132cc998, Offset: 0x23bb
// Size: 0x157
function private delaystreamtomovingplane()
{
    self endon( #"stopscene" );
    
    if ( isdefined( self.movingc130 ) )
    {
        delaytime = getdvarint( @"hash_d01d0472d843d39e", 8 );
        wait delaytime;
        
        if ( !isdefined( self.movingc130 ) )
        {
            return;
        }
        
        streamorigin = self.movingc130.origin;
        forward = getdvarint( @"hash_7abcda2d7aabbe4c", 0 );
        
        if ( forward > 0 )
        {
            dir = anglestoforward( self.movingc130.angles );
            streamorigin = self.movingc130.origin + dir * forward;
        }
        
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setpredictedstreamloaddist( 0 );
            player streamhint::playerstreamhintlocation( streamorigin );
        }
    }
}

// Namespace br_infils_ac130_v0
// Params 0, eflags: 0x4
// Checksum 0x41a2050, Offset: 0x251a
// Size: 0xce
function private stopstreamtomovingplane()
{
    if ( isdefined( self.movingc130 ) && getdvarint( @"hash_eb8a05afa7735e5f", 1 ) == 1 )
    {
        delaytime = getdvarint( @"hash_b7c6d487b0f5506b", 5 );
        wait delaytime;
        
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player thread br_public::playerclearstreamhintorigin();
        }
    }
}

// Namespace br_infils_ac130_v0
// Params 0
// Checksum 0x44b8dcac, Offset: 0x25f0
// Size: 0x2d
function prematchstartfunc()
{
    var_4f36a20c84898388 = getent( "infil_plane", #script_noteworthy );
    
    if ( isdefined( var_4f36a20c84898388 ) )
    {
        var_4f36a20c84898388 hide();
    }
}

// Namespace br_infils_ac130_v0
// Params 0
// Checksum 0x6e6e8f55, Offset: 0x2625
// Size: 0xe4
function videostartfunc()
{
    br_infil_intro = audio_utility::function_d4d265f3dcd0a13c( "br_infil_intro" );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setentitysoundcontext( "lobby_fade", "", 2 );
        player playlocalsound( "br_infil_part1_lr" );
        player clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
        player setsoundsubmix( "solo_cin_igc_music_br_hack", 0.5 );
        player setplayermusicstate( br_infil_intro );
    }
}

// Namespace br_infils_ac130_v0
// Params 0
// Checksum 0x9af58c3c, Offset: 0x2711
// Size: 0xa
function animaticstartfunc()
{
    level thread setsoundsubmixfadetoblackamb();
}

// Namespace br_infils_ac130_v0
// Params 1, eflags: 0x4
// Checksum 0x88a5b4a1, Offset: 0x2723
// Size: 0xbe
function private setsoundsubmixfadetoblackamb( players )
{
    br_infils_util::waitandpause( 2 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "solo_cin_igc_music_br_hack", 0.5 );
        player setsoundsubmix( "fade_to_black_all_except_music_scripted5_and_amb_br_hack", 2 );
    }
}

// Namespace br_infils_ac130_v0
// Params 0
// Checksum 0xe51c9b1, Offset: 0x27e9
// Size: 0x1fb
function function_2295b0f632c0d19d()
{
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
    
    player_link_tag = "j_prop_" + self.infilanimindex + 2;
    cos45 = cos( 45 );
    
    if ( dotforward < -1 * cos45 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10" ], "sdr_mp_infil_ac130_jump", player_link_tag ];
    }
    
    if ( dotright > cos45 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_90_l", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_90_l" ], "sdr_mp_infil_ac130_jump_90_l", player_link_tag ];
    }
    
    if ( dotright < -1 * cos45 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_90_r", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_90_r" ], "sdr_mp_infil_ac130_jump_90_r", player_link_tag ];
    }
    
    if ( dotright > 0 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_180_l", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_180_l" ], "sdr_mp_infil_ac130_jump_180_l", player_link_tag ];
    }
    
    return [ "sdr_mp_infil_ac130_jump_genpropx10_180_r", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_180_r" ], "sdr_mp_infil_ac130_jump_180_r", player_link_tag ];
}

// Namespace br_infils_ac130_v0
// Params 0
// Checksum 0x4dac4014, Offset: 0x29ec
// Size: 0x5c
function function_1ad287fcb5253b3c()
{
    cloudfx = level._effect[ "vfx_br_ac130_clouds" ];
    cloudbreakfx = level._effect[ "vfx_br_ac130_oneshot" ];
    
    if ( isdefined( cloudfx ) )
    {
        stopfxontag( cloudfx, self, "tag_body" );
    }
    
    if ( isdefined( cloudbreakfx ) )
    {
        stopfxontag( cloudbreakfx, self, "tag_body" );
    }
}

