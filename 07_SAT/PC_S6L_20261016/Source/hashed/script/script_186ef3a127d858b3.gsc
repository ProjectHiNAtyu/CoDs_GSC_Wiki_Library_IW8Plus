// script_186ef3a127d858b3  (hash_186ef3a127d858b3.gscc) (size: 20199 Bytes / 0x4ee7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2224e1f1 (572842481)
// size ...... 20199 (0x4ee7)
// includes .. 8   (offset: 0x4653)
// strings ... 117 (offset: 0x4693)
// dev strs .. 0   (offset: 0x4d67)
// exports ... 36  (offset: 0x321b)
// cseg ...... 0xad1 + 0x274a (0x321b)
// imports ... 118 (offset: 0x37bb)
// animtree1 . 0   (offset: 0x4d67)
// animtree2 . 24  (offset: 0x4d67)
#using scripts\common\anim;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_infils_common;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\streamhint;

#namespace namespace_6b5a23ed480ee500;

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x5
// Checksum 0x99d2cbc4, Offset: 0xaef
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_513b7424670ebb53", #"br_infils_common", &pre_main, undefined );
}

// Namespace namespace_6b5a23ed480ee500
// Params 0
// Checksum 0x9c462e89, Offset: 0xb18
// Size: 0x13
function pre_main()
{
    br_infils_common::register_infil( "cer_infil_s3", &init );
}

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0xbeffbff5, Offset: 0xb33
// Size: 0x280
function private init()
{
    assert( isdefined( level.infilstruct ) );
    level.infilstruct.hwconfig = %"hw_jup_mp_wz2_cin_cer";
    
    if ( utility::issharedfuncdefined( #"br_infils", #"hash_50d7df11518fd6c8" ) )
    {
        [[ utility::getsharedfunc( #"br_infils", #"hash_50d7df11518fd6c8" ) ]]();
    }
    
    level.var_8f64d94451f73542 = 0;
    level.infilstruct.c130model = "veh8_mil_air_acharlie130_magma_animated";
    level.infilstruct.var_f265685cdcfee833 = "veh8_mil_air_acharlie130_magma_rigid";
    level.infilstruct.var_9d24745d02be135e = "tag_origin";
    level.infilstruct.c130soundalias = "br_ac130_lp";
    level.infilstruct.var_ea87d0ead0c54f1c = 1;
    level.infilstruct.var_dfeffb86c1dd09b6 = 1;
    level.infilstruct.var_cee5041ecb30a2c5 = &function_fdfe0dc503c4f44;
    level.infilstruct.var_3bead1a95b75d55d = &function_2295b0f632c0d19d;
    level.infilstruct.jumpfunc = &jumpfunc;
    level.infilstruct.var_9a4f6a9353c9055c = &function_9a4f6a9353c9055c;
    level.infilstruct.var_12c03eae53e9bb4c = &function_60ca5349741930ba;
    level.infilstruct.var_3a2e6ef0dea2917f = "mp_donetsk_c130_intro";
    level.infilstruct.var_5081bf0daf7ab833 = 6.45;
    level.infilstruct.binktime = 2.7;
    orbitcamassets = [ "cam_orbit_br_infil_cer_s3_player1", "cam_orbit_br_infil_cer_s3_player2", "cam_orbit_br_infil_cer_s3_player3", "cam_orbit_br_infil_cer_s3_player4" ];
    br_infils_util::set_orbit_cam_info( orbitcamassets );
    br_infils_util::function_8e44037c2a8b1713( "prematch", &prematchstartfunc );
    br_infils_util::function_8e44037c2a8b1713( "fadedown", &fadedownfunc );
    br_infils_util::function_8e44037c2a8b1713( "cinematic", &videostartfunc );
    br_infils_util::function_8e44037c2a8b1713( "animatic", &animaticstartfunc );
    level._effect[ "vfx_br_ac130_clouds" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_ac130_clouds" );
    level._effect[ "vfx_br_infil_cloud_anim" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_cloud_anim" );
    initanims();
}

// Namespace namespace_6b5a23ed480ee500
// Params 1, eflags: 0x4
// Checksum 0xc4a3fe34, Offset: 0xdbb
// Size: 0xe4f
function private function_fdfe0dc503c4f44( movingc130 )
{
    animstruct = spawnstruct();
    animstruct.origin = getdvarvector( @"br_infil_anim_pos", ( 0, 0, 0 ) );
    animstruct.angles = ( 0, 0, 0 );
    animstruct.var_39f40041d77aaab4 = 1;
    animstruct.cleanupfunc = &function_fa70e3629f82e53b;
    animstruct.var_751e0e63f6c6f6ec = &function_1ad287fcb5253b3c;
    animstruct.movingc130 = movingc130;
    animstruct.staticc130 = getent( "infil_cer_s3_exterior", #targetname );
    
    if ( isdefined( animstruct.staticc130 ) )
    {
        animstruct.staticc130 show();
        animstruct.staticc130.dontdelete = 1;
        animstruct.staticc130.animname = "c130";
        animstruct.origin = animstruct.staticc130.origin;
    }
    else
    {
        animstruct.staticc130 = animstruct br_infils_util::spawn_script_model( "veh8_mil_air_acharlie130_magma_animated", "c130" );
    }
    
    animstruct.staticc130.dontteleport = 1;
    animstruct.var_b6e5f06b0c65a1d7 = animstruct.staticc130;
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.movingc130.animname = "movingC130";
        animstruct.movingc130.innards.animname = "movingC130";
        animstruct.movingc130.animstruct = animstruct;
    }
    
    animstruct.var_21f0343cdb0961ac = animstruct br_infils_util::spawn_script_model( "generic_prop_x30", "parent" );
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
    skins = [ "t10_usa_pl_jack_base_skin", "t10_usa_pl_jill_base_skin", "t10_usa_pl_westpoint_squish_skin", "t10_usa_pl_westpoint_squash_skin" ];
    
    if ( utility::issharedfuncdefined( #"br_infils", #"hash_c3456f85d5e2105a" ) )
    {
        skins = utility::callsharedfunc( #"br_infils", #"hash_c3456f85d5e2105a" );
    }
    
    randomskins = arrayrandomize( skins );
    animstruct.playermodels[ 0 ] function_91ed8e384d4e1fa6( randomskins[ 0 ] );
    animstruct.playermodels[ 1 ] function_91ed8e384d4e1fa6( randomskins[ 1 ] );
    animstruct.playermodels[ 2 ] function_91ed8e384d4e1fa6( randomskins[ 2 ] );
    animstruct.playermodels[ 3 ] function_91ed8e384d4e1fa6( randomskins[ 3 ] );
    animstruct.doorchief = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "doorChief" );
    animstruct.doorchief linkto( animstruct.var_21f0343cdb0961ac, "j_prop_5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.cloudanimfx = spawnfx( level._effect[ "vfx_br_infil_cloud_anim" ], animstruct.staticc130.origin );
    animstruct.cloudanimfx.angles = combineangles( animstruct.staticc130.angles, ( 0, 180, 0 ) );
    animstruct.cloudanimfx forcenetfieldhighlod( 1 );
    animstruct.var_5f6fbc6984651c9a = spawnfx( level._effect[ "vfx_br_infil_cloud_anim" ], animstruct.movingc130.origin );
    animstruct.var_5f6fbc6984651c9a.angles = combineangles( animstruct.movingc130.angles, ( 0, 180, 0 ) );
    animstruct.var_5f6fbc6984651c9a forcenetfieldhighlod( 1 );
    animstruct.packs = [];
    n = 0;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene1" );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_418b6894c6117b16 );
    animstruct.packs[ n ] br_infils_util::function_9597cbd14a6857e3( [], &function_49745c7eb311e7db );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.staticc130, level.br_anim[ "wz_br_cer_infil_s3_sh010_plane" ] );
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130, level.br_anim[ "wz_br_cer_infil_s3_sh010_plane" ] );
    }
    
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_21f0343cdb0961ac, level.br_anim[ "wz_br_cer_infil_s3_sh010_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.doorchief, level.br_anim[ "wz_br_cer_infil_s3_sh010_npc01" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.var_21f0343cdb0961ac, "tag_origin", level.br_anim[ "wz_br_cer_infil_s3_sh010_gprop" ], "wz_br_cer_infil_s3_sh010_xcam_plyr01", &function_5d591253b1d2e18d );
    
    if ( !isdefined( level.scr_notetrack[ "c130" ][ "any" ][ "gored" ] ) )
    {
        animation::addnotetrack_customfunction( "c130", "startinteriorsound", &startinteriorsound );
        animation::addnotetrack_customfunction( "c130", "gored", &function_c3c0fb045468d829 );
        animation::addnotetrack_customfunction( "c130", "gogreen", &greenlightfunc );
        animation::addnotetrack_customfunction( "c130", "opendoor", &function_89803b991877c99b );
        animation::addnotetrack_customfunction( "c130", "transitionstart", &function_7e34cbf1b9243cb4 );
        animation::addnotetrack_customfunction( "parent", "transition", &transitionfunc );
        animation::addnotetrack_customfunction( "c130", "infil_player_header", &function_c0e3aebd3d0c509 );
    }
    
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "looping", 1 );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_d08f2d7f11cd8058 );
    animstruct.packs[ n ] br_infils_util::function_9597cbd14a6857e3( [], &function_e5ebb228460bf05 );
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130, level.br_anim[ "wz_br_cer_infil_s3_loop_plane" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130.innards, level.br_anim[ "wz_br_cer_infil_s3_loop_plane" ] );
    }
    
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_21f0343cdb0961ac, level.br_anim[ "wz_br_cer_infil_s3_loop_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_cer_infil_s3_loop_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_cer_infil_s3_loop_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_cer_infil_s3_loop_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_cer_infil_s3_loop_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_cer_infil_s3_loop_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_cer_infil_s3_loop_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_cer_infil_s3_loop_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_cer_infil_s3_loop_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.doorchief, level.br_anim[ "wz_br_cer_infil_s3_loop_npc01" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.var_21f0343cdb0961ac, [ "j_prop_11", "j_prop_12", "j_prop_13", "j_prop_14" ] );
    animstruct.packs[ n ] br_infils_util::set_pack_fov( 65 );
    return animstruct;
}

// Namespace namespace_6b5a23ed480ee500
// Params 1, eflags: 0x4
// Checksum 0x4b869564, Offset: 0x1c13
// Size: 0x9e
function private function_c0e3aebd3d0c509( c130 )
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_br_infil_exfil_player_focus", 1 );
    }
}

// Namespace namespace_6b5a23ed480ee500
// Params 1
// Checksum 0xd9f55658, Offset: 0x1cb9
// Size: 0x91
function function_5d591253b1d2e18d( player )
{
    xcamassets = [ "wz_br_cer_infil_s3_sh010_xcam_plyr01", "wz_br_cer_infil_s3_sh010_xcam_plyr02", "wz_br_cer_infil_s3_sh010_xcam_plyr03", "wz_br_cer_infil_s3_sh010_xcam_plyr04" ];
    
    if ( !isdefined( player ) || !isdefined( player.infilanimindex ) )
    {
        return xcamassets[ 0 ];
    }
    
    if ( player.infilanimindex < 1 || player.infilanimindex > xcamassets.size )
    {
        return xcamassets[ 0 ];
    }
    
    return xcamassets[ player.infilanimindex - 1 ];
}

// Namespace namespace_6b5a23ed480ee500
// Params 1
// Checksum 0xaa61c6e, Offset: 0x1d53
// Size: 0xa8
function function_418b6894c6117b16( array )
{
    if ( isdefined( self.movingc130 ) )
    {
        self.movingc130 stoploopsound();
    }
    
    self.doorchief hide();
    playfxontag( level._effect[ "vfx_br_ac130_clouds" ], self.staticc130, "tag_body" );
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_c8dc6c3814634134" ) )
    {
        utility::callsharedfunc( #"gametype", #"hash_c8dc6c3814634134", self );
    }
    
    thread clearsoundsubmixmpbrinfilanim();
    thread offlight();
    thread delaystreamtomovingplane();
    thread fade_cover();
}

// Namespace namespace_6b5a23ed480ee500
// Params 2
// Checksum 0x1f0c4360, Offset: 0x1e03
// Size: 0xe9
function function_49745c7eb311e7db( player, array )
{
    assert( isdefined( player ) );
    var_d4c0c761c30a5938 = 34;
    var_ce05f4f6be26fe25 = 5.6;
    var_557b4c05a5389149 = 50.7;
    var_a401234361e805a0 = 2;
    var_2236739e78e9538b = 4;
    player setsoundsubmix( "mp_br_infil_anim", 0 );
    player setsoundsubmix( "mp_br_infil_ac130", 0 );
    player setclienttriggeraudiozone( "mp_br_c130_infil_int", 1 );
    player setclientdvar( @"cg_fov", var_d4c0c761c30a5938 );
    player enablephysicaldepthoffieldscripting();
    player setphysicaldepthoffield( var_ce05f4f6be26fe25, var_557b4c05a5389149, var_a401234361e805a0, var_2236739e78e9538b );
    player function_a565dafac620d68e( level.infilstruct.hwconfig );
    self.doorchief showtoplayer( player );
}

// Namespace namespace_6b5a23ed480ee500
// Params 1
// Checksum 0x8fed970a, Offset: 0x1ef4
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

// Namespace namespace_6b5a23ed480ee500
// Params 2
// Checksum 0x6b25fc61, Offset: 0x1f58
// Size: 0x15
function function_e5ebb228460bf05( player, array )
{
    
}

// Namespace namespace_6b5a23ed480ee500
// Params 0
// Checksum 0x2211f8db, Offset: 0x1f75
// Size: 0x21
function function_fa70e3629f82e53b()
{
    br_infils_util::function_3855f5796f4d2b65( "cer_infil_s3" );
    audio_utility::snd_transient_unload( "mp_wz2_br_igc_cer_s3_infil" );
    br_infils_common::cleanupents();
}

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0x84a4e967, Offset: 0x1f9e
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

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0xf7b5f171, Offset: 0x2049
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

// Namespace namespace_6b5a23ed480ee500
// Params 1, eflags: 0x4
// Checksum 0x31da38c9, Offset: 0x20f4
// Size: 0x2b
function private startinteriorsound( c130 )
{
    audio_utility::function_63bf1584c79c055( level.infilstruct.players, "scn_wz_infil_cer_s3_lr" );
}

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0x4ab4c665, Offset: 0x2127
// Size: 0x9a
function private offlight()
{
    lightcontrollers = getentitylessscriptablearray( "infil_blinking_light", #script_noteworthy );
    
    foreach ( lightcontroller in lightcontrollers )
    {
        lightcontroller setscriptablepartstate( "light_blinking_slow", "light_off_hold", 1 );
    }
}

// Namespace namespace_6b5a23ed480ee500
// Params 1, eflags: 0x4
// Checksum 0x325b62bc, Offset: 0x21c9
// Size: 0xa4
function private function_c3c0fb045468d829( c130 )
{
    lightcontrollers = getentitylessscriptablearray( "infil_blinking_light", #script_noteworthy );
    
    foreach ( lightcontroller in lightcontrollers )
    {
        lightcontroller setscriptablepartstate( "light_blinking_slow", "light_on", 1 );
    }
}

// Namespace namespace_6b5a23ed480ee500
// Params 1, eflags: 0x4
// Checksum 0x59e77eac, Offset: 0x2275
// Size: 0xa4
function private greenlightfunc( c130 )
{
    lightcontrollers = getentitylessscriptablearray( "infil_blinking_light", #script_noteworthy );
    
    foreach ( lightcontroller in lightcontrollers )
    {
        lightcontroller setscriptablepartstate( "light_blinking_slow", "light_jump", 1 );
    }
}

// Namespace namespace_6b5a23ed480ee500
// Params 1, eflags: 0x4
// Checksum 0x5de6321a, Offset: 0x2321
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

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0xb22c762a, Offset: 0x23fc
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

// Namespace namespace_6b5a23ed480ee500
// Params 1, eflags: 0x4
// Checksum 0x3e46090f, Offset: 0x24b8
// Size: 0x50
function private function_7e34cbf1b9243cb4( c130 )
{
    triggerfx( level.infilstruct.animstruct.cloudanimfx );
    triggerfx( level.infilstruct.animstruct.var_5f6fbc6984651c9a );
}

// Namespace namespace_6b5a23ed480ee500
// Params 1, eflags: 0x4
// Checksum 0xe91eabe1, Offset: 0x2510
// Size: 0x2bc
function private transitionfunc( c130 )
{
    level.infilstruct.animstruct notify( #"infil_reset_light_dvars" );
    level.infilstruct.animstruct clearplayerwind();
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setallstreamloaddist( 0 );
        player clearpredictedstreampos();
        player setclienttriggeraudiozone( "amb_mp_br_infil_ext_lr", 2 );
        player function_72cf2eee8e035013( level.infilstruct.hwconfig );
    }
    
    if ( isdefined( level.infilstruct.animstruct.movingc130 ) )
    {
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientdvar( @"cg_fov", 65 );
            player setclientdvar( @"cg_disable_user_fov", 1 );
            player setphysicaldepthoffield( 14, 35, 2, 4 );
        }
        
        level.infilstruct.animstruct.var_21f0343cdb0961ac unlink();
        level.infilstruct.animstruct.var_21f0343cdb0961ac linkto( level.infilstruct.animstruct.movingc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.infilstruct.animstruct.movingc130 notify( #"start_moving" );
    }
    
    level.infilstruct.animstruct.staticc130 hide();
    setomnvar( "ui_hide_player_icons", 0 );
    level thread function_84d9f43651e1f809();
    level thread clearsoundsubmixmpbrinfilac130();
}

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0x57def61e, Offset: 0x27d4
// Size: 0x55
function private function_84d9f43651e1f809()
{
    wait 0.1;
    
    if ( isdefined( level.infilstruct.animstruct.movingc130 ) )
    {
        level.infilstruct.animstruct.movingc130 setscriptablepartstate( "br_fx", "clouds" );
    }
}

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0x12f501c2, Offset: 0x2831
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

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0x104a8275, Offset: 0x2990
// Size: 0x187
function private fade_cover()
{
    self endon( #"stopscene" );
    
    if ( !isdefined( self.var_21f0343cdb0961ac ) )
    {
        return;
    }
    
    self.var_21f0343cdb0961ac endon( #"death" );
    overlay = newhudelem();
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( "white", 640, 480 );
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.sort = -1;
    overlay.color = ( 0.88, 0.88, 0.88 );
    overlay.alpha = 0;
    fadeintime = 0.16;
    fadeouttime = 0.5;
    self.var_21f0343cdb0961ac waittillmatch( #"parent", #"hash_877c81b45be2897c" );
    overlay fadeovertime( fadeintime );
    overlay.alpha = 1;
    self.var_21f0343cdb0961ac waittillmatch( #"parent", #"fadeoutstart" );
    overlay fadeovertime( fadeouttime );
    overlay.alpha = 0;
    br_infils_util::waitandpause( fadeouttime + 0.1 );
    overlay destroy();
}

// Namespace namespace_6b5a23ed480ee500
// Params 0
// Checksum 0x4013654a, Offset: 0x2b1f
// Size: 0x44
function prematchstartfunc()
{
    var_4f36a20c84898388 = getent( "targetname", #infil_cer_s3_exterior );
    
    if ( isdefined( var_4f36a20c84898388 ) )
    {
        var_4f36a20c84898388 hide();
    }
    
    level.nosuspensemusic = 1;
    audio_utility::snd_transient_load( "mp_wz2_br_igc_cer_s3_infil" );
}

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0xe6d23c5a, Offset: 0x2b6b
// Size: 0x1c
function private fadedownfunc()
{
    audio_utility::function_7b72e563ad80e020( level.players, "default", 2.5 );
}

// Namespace namespace_6b5a23ed480ee500
// Params 0
// Checksum 0x814e8320, Offset: 0x2b8f
// Size: 0xc7
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
        player clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
        player setplayermusicstate( br_infil_intro );
    }
}

// Namespace namespace_6b5a23ed480ee500
// Params 0
// Checksum 0x41566460, Offset: 0x2c5e
// Size: 0x2
function animaticstartfunc()
{
    
}

// Namespace namespace_6b5a23ed480ee500
// Params 0
// Checksum 0x11ddd95, Offset: 0x2c68
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
        return [ "sdr_mp_infil_ac130_jump_genpropx10", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10" ], "sdr_mp_infil_ac130_jump01_pl01", player_link_tag ];
    }
    
    if ( dotright > cos45 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_90_l", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_90_l" ], "sdr_mp_infil_ac130_jump01_pl01_90_l", player_link_tag ];
    }
    
    if ( dotright < -1 * cos45 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_90_r", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_90_r" ], "sdr_mp_infil_ac130_jump01_pl01_90_r", player_link_tag ];
    }
    
    if ( dotright > 0 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_180_l", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_180_l" ], "sdr_mp_infil_ac130_jump01_pl01_180_l", player_link_tag ];
    }
    
    return [ "sdr_mp_infil_ac130_jump_genpropx10_180_r", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_180_r" ], "sdr_mp_infil_ac130_jump01_pl01_180_r", player_link_tag ];
}

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0x8bc77bc8, Offset: 0x2e6b
// Size: 0x34
function private jumpfunc()
{
    if ( getdvarint( @"hash_549df6ab370a2bc4", 1 ) )
    {
        self lerpfovscalefactor( 0, 0 );
        self setclientdvar( @"cg_disable_user_fov", 0 );
    }
}

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0xa7580c3, Offset: 0x2ea7
// Size: 0x6d
function private function_9a4f6a9353c9055c()
{
    self endon( #"disconnect" );
    self lerpfov( 65, 0.5 );
    
    if ( getdvarint( @"hash_549df6ab370a2bc4", 1 ) )
    {
        self lerpfovscalefactor( 1, 0.5 );
    }
    
    wait 1;
    self disablephysicaldepthoffieldscripting();
    self setclientdvar( @"cg_fov", 65 );
    self setclientdvar( @"cg_disable_user_fov", 0 );
}

// Namespace namespace_6b5a23ed480ee500
// Params 0
// Checksum 0x4c75884e, Offset: 0x2f1c
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

// Namespace namespace_6b5a23ed480ee500
// Params 1, eflags: 0x4
// Checksum 0x97bf5c54, Offset: 0x2f80
// Size: 0x19
function private function_91ed8e384d4e1fa6( skinname )
{
    self function_ce21f4102d5d17f6( skinname, "iw9_avatar_scriptable_mp" );
}

#using_animtree( "br_infil_cer_s3" );

// Namespace namespace_6b5a23ed480ee500
// Params 0, eflags: 0x4
// Checksum 0xf5080637, Offset: 0x2fa1
// Size: 0x25a
function private initanims()
{
    level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10" ] = %sdr_mp_infil_ac130_jump_genpropx10;
    level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_90_l" ] = %sdr_mp_infil_ac130_jump_genpropx10_90_l;
    level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_90_r" ] = %sdr_mp_infil_ac130_jump_genpropx10_90_r;
    level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_180_l" ] = %sdr_mp_infil_ac130_jump_genpropx10_180_l;
    level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_180_r" ] = %sdr_mp_infil_ac130_jump_genpropx10_180_r;
    level.br_anim[ "sdr_mp_infil_ac130_jump01_pl01" ] = %sdr_mp_infil_ac130_jump01_pl01;
    level.br_anim[ "sdr_mp_infil_ac130_jump01_pl01_180_l" ] = %sdr_mp_infil_ac130_jump01_pl01_180_l;
    level.br_anim[ "sdr_mp_infil_ac130_jump01_pl01_180_r" ] = %sdr_mp_infil_ac130_jump01_pl01_180_r;
    level.br_anim[ "sdr_mp_infil_ac130_jump01_pl01_90_l" ] = %sdr_mp_infil_ac130_jump01_pl01_90_l;
    level.br_anim[ "sdr_mp_infil_ac130_jump01_pl01_90_r" ] = %sdr_mp_infil_ac130_jump01_pl01_90_r;
    level.br_anim[ "wz_br_cer_infil_s3_sh010_plane" ] = %wz_br_cer_infil_s3_sh010_plane;
    level.br_anim[ "wz_br_cer_infil_s3_sh010_gprop" ] = %wz_br_cer_infil_s3_sh010_gprop;
    level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr01" ] = %wz_br_cer_infil_s3_sh010_plyr01;
    level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr02" ] = %wz_br_cer_infil_s3_sh010_plyr02;
    level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr03" ] = %wz_br_cer_infil_s3_sh010_plyr03;
    level.br_anim[ "wz_br_cer_infil_s3_sh010_plyr04" ] = %wz_br_cer_infil_s3_sh010_plyr04;
    level.br_anim[ "wz_br_cer_infil_s3_sh010_npc01" ] = %wz_br_cer_infil_s3_sh010_npc01;
    level.br_anim[ "wz_br_cer_infil_s3_loop_plane" ] = %wz_br_cer_infil_s3_loop_plane;
    level.br_anim[ "wz_br_cer_infil_s3_loop_gprop" ] = %wz_br_cer_infil_s3_loop_gprop;
    level.br_anim[ "wz_br_cer_infil_s3_loop_plyr01" ] = %wz_br_cer_infil_s3_loop_plyr01;
    level.br_anim[ "wz_br_cer_infil_s3_loop_plyr02" ] = %wz_br_cer_infil_s3_loop_plyr02;
    level.br_anim[ "wz_br_cer_infil_s3_loop_plyr03" ] = %wz_br_cer_infil_s3_loop_plyr03;
    level.br_anim[ "wz_br_cer_infil_s3_loop_plyr04" ] = %wz_br_cer_infil_s3_loop_plyr04;
    level.br_anim[ "wz_br_cer_infil_s3_loop_npc01" ] = %wz_br_cer_infil_s3_loop_npc01;
}

// Namespace namespace_6b5a23ed480ee500
// Params 0
// Checksum 0x1ecff0fd, Offset: 0x3203
// Size: 0x18
function function_60ca5349741930ba()
{
    self setallstreamloaddist( getdvarint( @"hash_32ac593ffe0cb45f", 6000 ) );
}

