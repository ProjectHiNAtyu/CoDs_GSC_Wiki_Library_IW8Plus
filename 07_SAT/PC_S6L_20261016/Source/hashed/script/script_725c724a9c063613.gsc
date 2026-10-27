// script_725c724a9c063613  (hash_725c724a9c063613.gscc) (size: 25337 Bytes / 0x62f9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb106d547 (2970015047)
// size ...... 25337 (0x62f9)
// includes .. 8   (offset: 0x5731)
// strings ... 151 (offset: 0x5771)
// dev strs .. 0   (offset: 0x6079)
// exports ... 41  (offset: 0x40d1)
// cseg ...... 0xdbd + 0x3314 (0x40d1)
// imports ... 123 (offset: 0x4739)
// animtree1 . 0   (offset: 0x6079)
// animtree2 . 40  (offset: 0x6079)
#using scripts\common\anim;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_infils_ac130;
#using scripts\mp\br\gametypes\br_infils_common;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;

#namespace namespace_51e8100f1dd67b4c;

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x5
// Checksum 0x516cb7bf, Offset: 0xddb
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3060af2800da34df", #"br_infils_common", &pre_main, undefined );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0
// Checksum 0x7cca8b24, Offset: 0xe04
// Size: 0x13
function pre_main()
{
    br_infils_common::register_infil( "saw_infil_chopper_s4", &init );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0x84d4c56c, Offset: 0xe1f
// Size: 0x24b
function private init()
{
    assert( isdefined( level.infilstruct ) );
    level.infilstruct.hwconfig = %"hw_jup_mp_wz2_cin_cer";
    
    if ( utility::issharedfuncdefined( #"br_infils", #"hash_50d7df11518fd6c8" ) )
    {
        [[ utility::getsharedfunc( #"br_infils", #"hash_50d7df11518fd6c8" ) ]]();
    }
    
    level.var_8f64d94451f73542 = 0;
    level.infilstruct.c130model = "gray::veh_t10_mil_us_heli_heavy_infil_exterior";
    level.infilstruct.var_f265685cdcfee833 = "veh_t10_mil_us_heli_heavy_infil_interior";
    level.infilstruct.var_9d24745d02be135e = "tag_body_animate";
    level.infilstruct.var_67c8deee3845395d = "ui_mp_br_infil_type_gunship";
    level.infilstruct.c130soundalias = "veh_br_heli_infil_hero_lp";
    level.infilstruct.var_ea87d0ead0c54f1c = 1;
    level.infilstruct.var_dfeffb86c1dd09b6 = 1;
    level.infilstruct.var_cee5041ecb30a2c5 = &function_fdfe0dc503c4f44;
    level.infilstruct.var_3bead1a95b75d55d = &function_2295b0f632c0d19d;
    level.infilstruct.jumpfunc = &jumpfunc;
    level.infilstruct.var_9a4f6a9353c9055c = &function_9a4f6a9353c9055c;
    level.infilstruct.var_3a2e6ef0dea2917f = "wz_br_cer_infil_s1";
    level.infilstruct.binktime = 7;
    orbitcamassets = [ "cam_orbit_br_infil_cer_s1_player1", "cam_orbit_br_infil_cer_s1_player2", "cam_orbit_br_infil_cer_s1_player3", "cam_orbit_br_infil_cer_s1_player4", "cam_orbit_br_infil_cer_s1_player1" ];
    br_infils_util::set_orbit_cam_info( orbitcamassets );
    br_infils_util::function_8e44037c2a8b1713( "prematch", &prematchstartfunc );
    br_infils_util::function_8e44037c2a8b1713( "fadedown", &fadedownfunc );
    utility::delaythread( 0.05, &br_infils_util::function_1c0500c7cf8f9b7, "cer_s1" );
    level._effect[ "vfx_jup_level_br_s1_cinematics_vista_cloud_thick_04" ] = loadfxasset( "vfx_jup_level_br_s1_cinematics_vista_cloud_thick_04" );
    initanims();
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x948335a6, Offset: 0x1072
// Size: 0x161c
function private function_fdfe0dc503c4f44( movingc130 )
{
    var_9e0f98261ef419cf = getdvarint( @"hash_c67588bbd3b6299e", 1 );
    animstruct = spawnstruct();
    animstruct.origin = getdvarvector( @"br_infil_anim_pos", ( 0, 0, 0 ) );
    animstruct.angles = ( 0, 0, 0 );
    animstruct.cleanupfunc = &infilcleanup;
    animstruct.var_751e0e63f6c6f6ec = &function_1ad287fcb5253b3c;
    animstruct.movingc130 = movingc130;
    animstruct.movingc130.animname = "movingC130";
    animstruct.var_39f40041d77aaab4 = 1;
    animstruct.staticc130 = getent( "infil_cer_s1_exterior", #targetname );
    var_d9e7678a1aaba8e = [ "veh_t10_mil_us_heli_heavy_infil_interior", "tag_body_animate" ];
    
    if ( isdefined( animstruct.staticc130 ) )
    {
        animstruct.staticc130 show();
        animstruct.staticc130.animname = "c130";
        animstruct.staticc130.dontdelete = 1;
        animstruct.origin = animstruct.staticc130.origin;
    }
    else
    {
        animstruct.staticc130 = animstruct br_infils_util::spawn_script_model( "gray::veh_t10_mil_us_heli_heavy_infil_exterior", "c130", [ var_d9e7678a1aaba8e ] );
    }
    
    animstruct.staticc130.dontteleport = 1;
    animstruct.var_b6e5f06b0c65a1d7 = animstruct.staticc130;
    animstruct.camerarunner = animstruct br_infils_util::spawn_script_model( "generic_prop_x30", "camera" );
    animstruct.camerarunner.angles = getdvarvector( @"hash_a243c97d0dc94bd7", animstruct.camerarunner.angles );
    animstruct.camerarunner linkto( animstruct.staticc130, "tag_body_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 0 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag1" );
    animstruct.playertags[ 1 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag2" );
    animstruct.playertags[ 2 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag3" );
    animstruct.playertags[ 3 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag4" );
    animstruct.playertags[ 0 ] linkto( animstruct.camerarunner, "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 1 ] linkto( animstruct.camerarunner, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 2 ] linkto( animstruct.camerarunner, "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 3 ] linkto( animstruct.camerarunner, "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 0 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player1" );
    animstruct.playermodels[ 1 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player2" );
    animstruct.playermodels[ 2 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player3" );
    animstruct.playermodels[ 3 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player4" );
    animstruct.playermodels[ 0 ] linkto( animstruct.playertags[ 0 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 1 ] linkto( animstruct.playertags[ 1 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 2 ] linkto( animstruct.playertags[ 2 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 3 ] linkto( animstruct.playertags[ 3 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    skins = [ "t10_usa_pl_jack_base_skin", "t10_usa_pl_jill_base_skin", "t10_usa_pl_westpoint_squish_skin", "t10_usa_pl_westpoint_squash_skin" ];
    randomskins = arrayrandomize( skins );
    animstruct.playermodels[ 0 ] function_91ed8e384d4e1fa6( randomskins[ 0 ] );
    animstruct.playermodels[ 1 ] function_91ed8e384d4e1fa6( randomskins[ 1 ] );
    animstruct.playermodels[ 2 ] function_91ed8e384d4e1fa6( randomskins[ 2 ] );
    animstruct.playermodels[ 3 ] function_91ed8e384d4e1fa6( randomskins[ 3 ] );
    animstruct.npcs = [];
    animstruct.npcs[ 0 ] = animstruct br_infils_util::spawn_script_model( "wz_br_cer_infil_rus_pilot", "npc1" );
    animstruct.npcs[ 0 ] linkto( animstruct.camerarunner, "j_prop_5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.pilots = [];
    animstruct.pilots[ 0 ] = animstruct br_infils_util::spawn_script_model( "wz_br_cer_infil_rus_pilot", "pilot1" );
    animstruct.pilots[ 1 ] = animstruct br_infils_util::spawn_script_model( "wz_br_cer_infil_rus_pilot", "pilot2" );
    animstruct.pilots[ 0 ] linkto( animstruct.camerarunner, "j_prop_11", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.pilots[ 1 ] linkto( animstruct.camerarunner, "j_prop_12", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.props = [];
    animstruct.props[ 0 ] = animstruct br_infils_util::spawn_script_model( "wpn_t10_p13_pi_usugar_9_sp_prop_anim", "sidearm" );
    animstruct.props[ 0 ] linkto( animstruct.camerarunner, "j_prop_8", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( var_9e0f98261ef419cf )
    {
        animstruct.armadachoppers = [];
        animstruct.armadachoppers[ 0 ] = animstruct br_infils_util::spawn_script_model( "gray::veh_t10_mil_us_heli_heavy_infil_exterior", "armadaChopper1", [ var_d9e7678a1aaba8e ] );
        animstruct.armadachoppers[ 1 ] = animstruct br_infils_util::spawn_script_model( "gray::veh_t10_mil_us_heli_heavy_infil_exterior", "armadaChopper2", [ var_d9e7678a1aaba8e ] );
        animstruct.armadachoppers[ 0 ] linkto( animstruct.camerarunner, "j_prop_9", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.armadachoppers[ 1 ] linkto( animstruct.camerarunner, "j_prop_10", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    animstruct.cloudsfxent = animstruct br_infils_util::spawn_script_model( "tag_origin", "clouds" );
    animstruct.cloudsfxent linkto( animstruct.camerarunner, "j_prop_13", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( !isdefined( level.scr_notetrack[ "camera" ][ "any" ][ "red_light" ] ) )
    {
        animation::addnotetrack_customfunction( "camera", "red_light", &function_c3c0fb045468d829 );
        animation::addnotetrack_customfunction( "camera", "green_light", &greenlightfunc );
        animation::addnotetrack_customfunction( "camera", "wind_start", &windstartfunc );
        animation::addnotetrack_customfunction( "camera", "cloud_fx", &function_ce46160c28a7014b );
        animation::addnotetrack_customfunction( "camera", "infil_header_player", &function_c0e3aebd3d0c509 );
    }
    
    animstruct.packs = [];
    n = 0;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene010", 0 );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( undefined, &function_15d8b5c096fbdf17 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.staticc130, level.br_anim[ "saw_escape_infil_s4_sh010_heli" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130, level.br_anim[ "saw_escape_infil_s4_sh010_heli" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "saw_escape_infil_s2_sh010_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "saw_escape_infil_s2_sh010_gprop" ], "saw_escape_infil_s2_sh010_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "saw_escape_infil_s2_sh010_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "saw_escape_infil_s2_sh010_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "saw_escape_infil_s2_sh010_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "saw_escape_infil_s2_sh010_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "saw_escape_infil_s2_sh010_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "saw_escape_infil_s2_sh010_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "saw_escape_infil_s2_sh010_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "saw_escape_infil_s2_sh010_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "saw_escape_infil_s2_sh010_npc01" ] );
    animstruct.packs[ n ] br_infils_util::function_88f4d49c8d510297( animstruct.cloudsfxent );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene020", 0 );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( undefined, &function_f154e3f87b902842 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.staticc130, level.br_anim[ "saw_escape_infil_s2_sh020_heli" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130, level.br_anim[ "saw_escape_infil_s2_sh020_heli" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "saw_escape_infil_s2_sh020_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "saw_escape_infil_s2_sh020_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "saw_escape_infil_s2_sh020_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "saw_escape_infil_s2_sh020_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "saw_escape_infil_s2_sh020_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "saw_escape_infil_s2_sh020_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "saw_escape_infil_s2_sh020_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "saw_escape_infil_s2_sh020_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "saw_escape_infil_s2_sh020_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "saw_escape_infil_s2_sh020_npc01" ] );
    animstruct.packs[ n ] br_infils_util::function_88f4d49c8d510297( animstruct.cloudsfxent );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "saw_escape_infil_s2_sh020_gprop" ], "saw_escape_infil_s2_sh020_xcam", &br_infils_ac130::getxcamfunc );
    animstruct.packs[ n ].xcams = [ "saw_escape_infil_s2_sh020_single_xcam", "saw_escape_infil_s2_sh020_single_xcam", "saw_escape_infil_s2_sh020_xcam", "saw_escape_infil_s2_sh020_xcam" ];
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene030", 0 );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( undefined, &function_a80eb6de477d215d );
    animstruct.packs[ n ] br_infils_util::set_pack_fov( 45 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.staticc130, level.br_anim[ "saw_escape_infil_s2_sh030_heli" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130, level.br_anim[ "saw_escape_infil_s2_sh030_heli" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "saw_escape_infil_s2_sh030_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "saw_escape_infil_s2_sh030_gprop" ], "saw_escape_infil_s2_sh030_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "saw_escape_infil_s2_sh030_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "saw_escape_infil_s2_sh030_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "saw_escape_infil_s2_sh030_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "saw_escape_infil_s2_sh030_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "saw_escape_infil_s2_sh030_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "saw_escape_infil_s2_sh030_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "saw_escape_infil_s2_sh030_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "saw_escape_infil_s2_sh030_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "saw_escape_infil_s2_sh030_npc01" ] );
    animstruct.packs[ n ] br_infils_util::function_88f4d49c8d510297( animstruct.cloudsfxent );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "looping", 1 );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( undefined, &function_ed1b8b2b4acda986 );
    animstruct.packs[ n ] br_infils_util::set_pack_fov( 45 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.staticc130, level.br_anim[ "saw_escape_infil_s2_loop_heli" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130, level.br_anim[ "saw_escape_infil_s2_loop_heli" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "saw_escape_infil_s2_loop_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "j_prop_7" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "saw_escape_infil_s2_loop_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "saw_escape_infil_s2_loop_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "saw_escape_infil_s2_loop_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "saw_escape_infil_s2_loop_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "saw_escape_infil_s2_loop_plyr01" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "saw_escape_infil_s2_loop_plyr02" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "saw_escape_infil_s2_loop_plyr03" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "saw_escape_infil_s2_loop_plyr04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "saw_escape_infil_s2_loop_npc01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.pilots[ 0 ], level.br_anim[ "wz_br_cer_infil_s1_loop_pilot01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.pilots[ 1 ], level.br_anim[ "wz_br_cer_infil_s1_loop_pilot02" ] );
    animstruct.packs[ n ] br_infils_util::function_88f4d49c8d510297( animstruct.cloudsfxent );
    
    if ( var_9e0f98261ef419cf )
    {
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.armadachoppers[ 0 ], level.br_anim[ "saw_escape_infil_s2_loop_heli" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.armadachoppers[ 1 ], level.br_anim[ "saw_escape_infil_s2_loop_heli" ] );
    }
    
    n++;
    return animstruct;
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0x85e1dcad, Offset: 0x2697
// Size: 0x2b2
function private function_2382a170e8bf0851()
{
    pack = self.activepack;
    assert( isdefined( pack ) );
    var_3a238e44047ac624 = 0;
    var_9403e3d4f0d932b8 = 4;
    forceindex = -1;
    
    /#
        var_3a238e44047ac624 = br_infils_common::function_5e7c30c827f65843();
        var_9403e3d4f0d932b8 = br_infils_common::function_486c89102889361c();
        forceindex = getdvarint( @"hash_441165c7b355dd1b", -1 );
    #/
    
    br_infils_util::refreshteamvisibility( level.infilstruct.players );
    teams = function_b0d92cfa8cc72e75( level.infilstruct.players );
    
    foreach ( players in teams )
    {
        numplayers = players.size;
        
        if ( var_3a238e44047ac624 )
        {
            numplayers = var_9403e3d4f0d932b8;
        }
        
        possibleindices = [ 1, 2, 3, 4 ];
        usedindices = [];
        playercount = 0;
        
        foreach ( player in players )
        {
            if ( forceindex <= 0 )
            {
                player.infilanimindex = possibleindices[ playercount % possibleindices.size ];
            }
            
            player.var_edbda953d7469bd7 = numplayers;
            playercount++;
            usedindices[ usedindices.size ] = player.infilanimindex;
        }
    }
    
    if ( var_3a238e44047ac624 )
    {
        pack.var_ebbf2026208f047d = function_5713d46873b29625( pack.var_ebbf2026208f047d );
        proxycount = 0;
        
        foreach ( proxy in pack.var_ebbf2026208f047d )
        {
            if ( proxycount < var_9403e3d4f0d932b8 )
            {
                proxy show();
                continue;
            }
            
            proxy hide();
        }
    }
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0x9bf73e3e, Offset: 0x2951
// Size: 0x29
function private function_4bd6e5a67db1c692()
{
    self setshowcontrail( 0 );
    self setisinfilskydive( 0 );
    self function_a565dafac620d68e( level.infilstruct.hwconfig );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x5996d8e2, Offset: 0x2982
// Size: 0xfa
function private function_15d8b5c096fbdf17( params )
{
    audio_utility::function_63bf1584c79c055( level.infilstruct.players, "scn_wz_infil_saw_s4_lr" );
    function_2382a170e8bf0851();
    lightsyellow();
    windreset();
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setshowcontrail( 0 );
        player setisinfilskydive( 0 );
        player function_a565dafac620d68e( level.infilstruct.hwconfig );
    }
    
    br_infils_util::function_fffda20dc2c2df07( &function_4bd6e5a67db1c692 );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x6264b1c0, Offset: 0x2a84
// Size: 0x13
function private function_f154e3f87b902842( params )
{
    function_2382a170e8bf0851();
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x627b2ff3, Offset: 0x2a9f
// Size: 0x3a
function private function_a80eb6de477d215d( params )
{
    function_2382a170e8bf0851();
    self.props[ 0 ] unlink();
    self.props[ 0 ] hide();
    thread handleteleport();
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x7eeafdc1, Offset: 0x2ae1
// Size: 0x33
function private function_326bd0d3ed6dbe98( params )
{
    function_2382a170e8bf0851();
    self.props[ 0 ] unlink();
    self.props[ 0 ] hide();
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0xa7c38f4e, Offset: 0x2b1c
// Size: 0x13
function private function_7252be138ae0bd13( params )
{
    function_2382a170e8bf0851();
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x4f1d796f, Offset: 0x2b37
// Size: 0x1a
function private function_35c94ea7b2f3728e( params )
{
    function_2382a170e8bf0851();
    thread handleteleport();
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0xda55b108, Offset: 0x2b59
// Size: 0xc
function private function_ed1b8b2b4acda986( params )
{
    
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0x15a53293, Offset: 0x2b6d
// Size: 0x7b
function private handleteleport()
{
    teleporttime = utility::get_notetrack_time( level.br_anim[ "saw_escape_infil_s2_sh030_gprop" ], "teleport" ) ?? 0;
    
    if ( teleporttime <= 0 )
    {
        teleporttime = getdvarfloat( @"hash_1968fc42f31e7d28", 5.5 );
    }
    
    thread function_77f9566e4d28cf67( teleporttime );
    
    if ( teleporttime > 0 )
    {
        utility::delaythread( teleporttime, &teleporttomovingplane );
        return;
    }
    
    teleporttomovingplane();
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x41667c9a, Offset: 0x2bf0
// Size: 0x21d
function private function_77f9566e4d28cf67( teleporttime )
{
    fadedownstarttime = utility::get_notetrack_time( level.br_anim[ "saw_escape_infil_s2_sh030_gprop" ], "fade_to_black_start" ) ?? 0;
    fadedownendtime = utility::get_notetrack_time( level.br_anim[ "saw_escape_infil_s2_sh030_gprop" ], "fade_to_black_end" ) ?? 0;
    fadeupstarttime = utility::get_notetrack_time( level.br_anim[ "saw_escape_infil_s2_sh030_gprop" ], "fade_from_black_start" ) ?? 0;
    fadeupendtime = utility::get_notetrack_time( level.br_anim[ "saw_escape_infil_s2_sh030_gprop" ], "fade_from_black_end" ) ?? 0;
    
    if ( fadedownstarttime < 0 || fadedownendtime < 0 || fadeupstarttime < 0 || fadeupendtime < 0 )
    {
        fadedowntime = 0.1;
        var_6b96244b7b6c05dc = getdvarfloat( @"scr_br_infil_teleport_fade_time", 0.1 );
        fadeuptime = 0.1;
        fadedownstarttime = teleporttime - fadedowntime - var_6b96244b7b6c05dc * 0.5;
        fadedownstarttime -= fadedownstarttime % 0.05;
        fadedownendtime = fadedownstarttime + fadedowntime;
        fadeupstarttime = teleporttime + var_6b96244b7b6c05dc * 0.5;
        fadeupstarttime += 0.05 - fadeupstarttime % 0.05;
        fadeupendtime = fadeupstarttime + fadeuptime;
    }
    
    if ( fadedownstarttime > 0 )
    {
        wait fadedownstarttime;
    }
    
    fadedowntime = fadedownendtime - fadedownstarttime;
    fadeduration = getdvarfloat( @"hash_731bce8a2771bda4", fadeupstarttime - fadedownstarttime );
    fadecolor = getdvar( @"hash_b9a6d6891e3dd553", "white" );
    br_infils_util::function_c050cae6f9bcb77f( fadedowntime, level.infilstruct.players, "teleport", fadecolor );
    
    if ( fadeduration > 0 )
    {
        wait fadeduration;
    }
    
    fadeuptime = getdvarfloat( @"hash_46db1612124a7775", fadeupendtime - fadeupstarttime );
    br_infils_util::function_573cdd2bc439ec67( fadeuptime, level.infilstruct.players, "teleport" );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 2, eflags: 0x4
// Checksum 0xc88a2041, Offset: 0x2e15
// Size: 0x1bd
function private function_bf542dced3374f3f( controllerstate, planestate )
{
    light_controllers = undefined;
    
    if ( level.infilstruct.animstruct.var_8516ae7cc1d66f93 )
    {
        light_controllers = level.infilstruct.animstruct.light_controllers;
    }
    else
    {
        light_controllers = getentitylessscriptablearray( "infil_cer_s1_light_controller", "targetname" );
        level.infilstruct.animstruct.light_controllers = light_controllers;
        level.infilstruct.animstruct.var_8516ae7cc1d66f93 = 1;
    }
    
    foreach ( controller in light_controllers )
    {
        controller setscriptablepartstate( "lights", controllerstate );
    }
    
    if ( isdefined( level.infilstruct.animstruct.staticc130 ) )
    {
        level.infilstruct.animstruct.staticc130 setscriptablepartstate( "interior_lights", planestate );
    }
    
    if ( isdefined( level.infilstruct.animstruct.movingc130 ) )
    {
        level.infilstruct.animstruct.movingc130 setscriptablepartstate( "interior_lights", planestate );
    }
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0x5908a352, Offset: 0x2fda
// Size: 0x13
function private lightsyellow()
{
    function_bf542dced3374f3f( "yellow", "yellow_lights" );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x8159fd2f, Offset: 0x2ff5
// Size: 0x1d
function private function_c3c0fb045468d829( cameraent )
{
    function_bf542dced3374f3f( "red", "red_lights" );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x6bbfcd40, Offset: 0x301a
// Size: 0x1d
function private greenlightfunc( cameraent )
{
    function_bf542dced3374f3f( "green", "green_lights" );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x80ca8941, Offset: 0x303f
// Size: 0x13c
function private setwind( var_50a2e7d4d32a99a4 )
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) || isbot( player ) )
        {
            continue;
        }
        
        player player::setwind( var_50a2e7d4d32a99a4, 1 );
    }
    
    foreach ( npc in level.infilstruct.animstruct.npcs )
    {
        if ( !isdefined( npc ) )
        {
            continue;
        }
        
        npc player::setwind( var_50a2e7d4d32a99a4 );
    }
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0xce8c1382, Offset: 0x3183
// Size: 0x143
function private windreset()
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) || isbot( player ) )
        {
            continue;
        }
        
        player player::setwind( "1" );
        player.manualoverridewindmaterial = undefined;
    }
    
    foreach ( npc in level.infilstruct.animstruct.npcs )
    {
        if ( !isdefined( npc ) )
        {
            continue;
        }
        
        npc player::setwind( "0" );
    }
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0xd415e456, Offset: 0x32ce
// Size: 0x9e
function private function_c0e3aebd3d0c509( cameraent )
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

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x54d04722, Offset: 0x3374
// Size: 0x4f
function private windstartfunc( cameraent )
{
    var_2c40d03b33c1b65e = utility::get_notetrack_time( level.br_anim[ "saw_escape_infil_s2_sh030_gprop" ], "wind_full" ) ?? 0;
    
    if ( var_2c40d03b33c1b65e > 0 )
    {
        level thread function_a1d1109949c0bf8d( var_2c40d03b33c1b65e );
    }
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1
// Checksum 0xf9968e2b, Offset: 0x33cb
// Size: 0x101
function function_a1d1109949c0bf8d( var_2c40d03b33c1b65e )
{
    settings = [ "10", "20", "30", "40", "50", "60", "70", "80", "90", "100" ];
    settingscount = settings.size;
    waitinterval = var_2c40d03b33c1b65e / settingscount;
    
    foreach ( setting in settings )
    {
        setwind( setting );
        wait waitinterval;
    }
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0xca87a57c, Offset: 0x34d4
// Size: 0x42
function private function_ce46160c28a7014b( cameraent )
{
    playfxontag( level._effect[ "vfx_jup_level_br_s1_cinematics_vista_cloud_thick_04" ], level.infilstruct.animstruct.cloudsfxent, "tag_origin" );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0x3e849aa, Offset: 0x351e
// Size: 0x42
function private function_17bd92ed8041faf4()
{
    self.manualoverridewindmaterial = undefined;
    player::setwind( "1" );
    self setallstreamloaddist( 0 );
    self clearpredictedstreampos();
    self function_72cf2eee8e035013( level.infilstruct.hwconfig );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0xee23c20f, Offset: 0x3568
// Size: 0x80
function private function_9cabae2a5cecbaa2()
{
    wait_time = getdvarfloat( @"scr_cloud_time", 0.2 );
    
    if ( wait_time > 0 )
    {
        wait wait_time;
    }
    
    level.infilstruct.animstruct.cloudsfxent unlink();
    waitframe();
    function_ce46160c28a7014b();
    wait 2.5;
    level.infilstruct.animstruct.cloudsfxent hide();
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0xb9212d3d, Offset: 0x35f0
// Size: 0x171
function private teleporttomovingplane()
{
    windreset();
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setallstreamloaddist( 0 );
        player clearpredictedstreampos();
        player function_72cf2eee8e035013( level.infilstruct.hwconfig );
    }
    
    if ( isdefined( self.movingc130 ) )
    {
        self.camerarunner unlink();
        self.camerarunner linkto( self.movingc130, "tag_body_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        
        if ( !level.infilstruct.var_df720711dd79fea7 || br_infils_util::function_7d2f9d2a086bd511() )
        {
            self.movingc130 notify( #"start_moving" );
        }
        
        thread function_9cabae2a5cecbaa2();
    }
    
    setomnvar( "ui_hide_player_icons", 0 );
    level notify( #"hash_c14217752dacdeed" );
    thread function_327cc5b9e5eeb626();
    br_infils_util::function_fffda20dc2c2df07( &function_17bd92ed8041faf4 );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0x5f1ddd43, Offset: 0x3769
// Size: 0x6a
function private function_327cc5b9e5eeb626()
{
    audio_utility::function_5b885ff87a1180d4( level.players, "solo_cin_igc_music_voiceover_br_hack", 2 );
    wait 0.1;
    self.movingc130 setscriptablepartstate( "engine", "on" );
    self.movingc130 setscriptablepartstate( "navilights", "on" );
    self.movingc130 setscriptablepartstate( "exhaust", "on" );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0xeb767b10, Offset: 0x37db
// Size: 0x25b
function private function_2295b0f632c0d19d()
{
    self clearclienttriggeraudiozone( 1 );
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
    
    if ( dotforward < -1 * cos45 )
    {
        return [ "wz_br_cer_infil_jump_straight_gprop", level.br_anim[ "wz_br_cer_infil_jump_straight_gprop" ], "wz_br_cer_infil_jump_straight_player", player_link_tag ];
    }
    
    if ( dotright > cos45 )
    {
        return [ "wz_br_cer_infil_jump_l90_gprop", level.br_anim[ "wz_br_cer_infil_jump_l90_gprop" ], "wz_br_cer_infil_jump_l90_player", player_link_tag ];
    }
    
    if ( dotright < -1 * cos45 )
    {
        return [ "wz_br_cer_infil_jump_r90_gprop", level.br_anim[ "wz_br_cer_infil_jump_r90_gprop" ], "wz_br_cer_infil_jump_r90_player", player_link_tag ];
    }
    
    if ( dotright > 0 )
    {
        return [ "wz_br_cer_infil_jump_l180_gprop", level.br_anim[ "wz_br_cer_infil_jump_l180_gprop" ], "wz_br_cer_infil_jump_l180_player", player_link_tag ];
    }
    
    return [ "wz_br_cer_infil_jump_r180_gprop", level.br_anim[ "wz_br_cer_infil_jump_r180_gprop" ], "wz_br_cer_infil_jump_r180_player", player_link_tag ];
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0x24ad883f, Offset: 0x3a3e
// Size: 0x34
function private jumpfunc()
{
    if ( getdvarint( @"hash_549df6ab370a2bc4", 1 ) )
    {
        self lerpfovscalefactor( 0, 0 );
        self setclientdvar( @"cg_disable_user_fov", 0 );
    }
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0x5fad1e98, Offset: 0x3a7a
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

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0xe58d4b40, Offset: 0x3b06
// Size: 0x19
function private prematchstartfunc()
{
    level.nosuspensemusic = 1;
    audio_utility::snd_transient_load( "mp_saw_br_escape_s4_infil" );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0x9af0a159, Offset: 0x3b27
// Size: 0xa
function private fadedownfunc()
{
    level thread function_818e211bb54ccc2a();
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0xb5abf62d, Offset: 0x3b39
// Size: 0x5b
function private function_818e211bb54ccc2a()
{
    audio_utility::function_7b72e563ad80e020( level.players, "default", 2.5 );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "solo_cin_igc_music_voiceover_br_hack", 1 );
    clearmusicstate();
    wait 2.5;
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_br_lobby_fade", 0 );
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0x3690634e, Offset: 0x3b9c
// Size: 0x37
function private infilcleanup()
{
    if ( isdefined( self.staticc130 ) )
    {
        self.staticc130 scriptmodelclearanim();
    }
    
    br_infils_util::function_3855f5796f4d2b65();
    audio_utility::snd_transient_unload( "mp_saw_br_escape_s4_infil" );
    br_infils_common::cleanupents();
}

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0xe7083669, Offset: 0x3bdb
// Size: 0x2
function private function_1ad287fcb5253b3c()
{
    
}

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x6c511ec0, Offset: 0x3be5
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

// Namespace namespace_51e8100f1dd67b4c
// Params 1, eflags: 0x4
// Checksum 0x38d5afa3, Offset: 0x3cc6
// Size: 0x19
function private function_91ed8e384d4e1fa6( skinname )
{
    self function_ce21f4102d5d17f6( skinname, "iw9_avatar_scriptable_mp" );
}

#using_animtree( "br_infil_saw_s2" );

// Namespace namespace_51e8100f1dd67b4c
// Params 0, eflags: 0x4
// Checksum 0xa0d0987b, Offset: 0x3ce7
// Size: 0x3ea
function private initanims()
{
    level.br_anim[ "saw_escape_infil_s2_sh010_gprop" ] = %saw_escape_infil_s2_sh010_gprop;
    level.br_anim[ "saw_escape_infil_s2_sh020_gprop" ] = %saw_escape_infil_s2_sh020_gprop;
    level.br_anim[ "saw_escape_infil_s2_sh030_gprop" ] = %saw_escape_infil_s2_sh030_gprop;
    level.br_anim[ "saw_escape_infil_s2_loop_gprop" ] = %saw_escape_infil_s2_loop_gprop;
    level.br_anim[ "saw_escape_infil_s4_sh010_heli" ] = %saw_escape_infil_s4_sh010_heli;
    level.br_anim[ "saw_escape_infil_s2_sh020_heli" ] = %saw_escape_infil_s2_sh020_heli;
    level.br_anim[ "saw_escape_infil_s2_sh030_heli" ] = %saw_escape_infil_s2_sh030_heli;
    level.br_anim[ "saw_escape_infil_s2_loop_heli" ] = %saw_escape_infil_s2_loop_heli;
    level.br_anim[ "saw_escape_infil_s2_sh010_plyr01" ] = %saw_escape_infil_s2_sh010_plyr01;
    level.br_anim[ "saw_escape_infil_s2_sh010_plyr02" ] = %saw_escape_infil_s2_sh010_plyr02;
    level.br_anim[ "saw_escape_infil_s2_sh010_plyr03" ] = %saw_escape_infil_s2_sh010_plyr03;
    level.br_anim[ "saw_escape_infil_s2_sh010_plyr04" ] = %saw_escape_infil_s2_sh010_plyr04;
    level.br_anim[ "saw_escape_infil_s2_sh020_plyr01" ] = %saw_escape_infil_s2_sh020_plyr01;
    level.br_anim[ "saw_escape_infil_s2_sh020_plyr02" ] = %saw_escape_infil_s2_sh020_plyr02;
    level.br_anim[ "saw_escape_infil_s2_sh020_plyr03" ] = %saw_escape_infil_s2_sh020_plyr03;
    level.br_anim[ "saw_escape_infil_s2_sh020_plyr04" ] = %saw_escape_infil_s2_sh020_plyr04;
    level.br_anim[ "saw_escape_infil_s2_sh030_plyr01" ] = %saw_escape_infil_s2_sh030_plyr01;
    level.br_anim[ "saw_escape_infil_s2_sh030_plyr02" ] = %saw_escape_infil_s2_sh030_plyr02;
    level.br_anim[ "saw_escape_infil_s2_sh030_plyr03" ] = %saw_escape_infil_s2_sh030_plyr03;
    level.br_anim[ "saw_escape_infil_s2_sh030_plyr04" ] = %saw_escape_infil_s2_sh030_plyr04;
    level.br_anim[ "saw_escape_infil_s2_loop_plyr01" ] = %saw_escape_infil_s2_loop_plyr01;
    level.br_anim[ "saw_escape_infil_s2_loop_plyr02" ] = %saw_escape_infil_s2_loop_plyr02;
    level.br_anim[ "saw_escape_infil_s2_loop_plyr03" ] = %saw_escape_infil_s2_loop_plyr03;
    level.br_anim[ "saw_escape_infil_s2_loop_plyr04" ] = %saw_escape_infil_s2_loop_plyr04;
    level.br_anim[ "wz_br_cer_infil_jump_l180_gprop" ] = %wz_br_cer_infil_jump_l180_gprop;
    level.br_anim[ "wz_br_cer_infil_jump_l180_player" ] = %wz_br_cer_infil_jump_l180_player;
    level.br_anim[ "wz_br_cer_infil_jump_l90_gprop" ] = %wz_br_cer_infil_jump_l90_gprop;
    level.br_anim[ "wz_br_cer_infil_jump_l90_player" ] = %wz_br_cer_infil_jump_l90_player;
    level.br_anim[ "wz_br_cer_infil_jump_r180_gprop" ] = %wz_br_cer_infil_jump_r180_gprop;
    level.br_anim[ "wz_br_cer_infil_jump_r180_player" ] = %wz_br_cer_infil_jump_r180_player;
    level.br_anim[ "wz_br_cer_infil_jump_r90_gprop" ] = %wz_br_cer_infil_jump_r90_gprop;
    level.br_anim[ "wz_br_cer_infil_jump_r90_player" ] = %wz_br_cer_infil_jump_r90_player;
    level.br_anim[ "wz_br_cer_infil_jump_straight_gprop" ] = %wz_br_cer_infil_jump_straight_gprop;
    level.br_anim[ "wz_br_cer_infil_jump_straight_player" ] = %wz_br_cer_infil_jump_straight_player;
    level.br_anim[ "saw_escape_infil_s2_sh010_npc01" ] = %saw_escape_infil_s2_sh010_npc01;
    level.br_anim[ "saw_escape_infil_s2_sh020_npc01" ] = %saw_escape_infil_s2_sh020_npc01;
    level.br_anim[ "saw_escape_infil_s2_sh030_npc01" ] = %saw_escape_infil_s2_sh030_npc01;
    level.br_anim[ "saw_escape_infil_s2_loop_npc01" ] = %saw_escape_infil_s2_loop_npc01;
    level.br_anim[ "wz_br_cer_infil_s1_loop_pilot01" ] = %wz_br_cer_infil_s1_loop_pilot01;
    level.br_anim[ "wz_br_cer_infil_s1_loop_pilot02" ] = %wz_br_cer_infil_s1_loop_pilot02;
}

