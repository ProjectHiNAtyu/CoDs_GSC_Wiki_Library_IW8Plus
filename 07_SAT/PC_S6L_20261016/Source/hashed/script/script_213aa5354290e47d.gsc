// script_213aa5354290e47d  (hash_213aa5354290e47d.gscc) (size: 50627 Bytes / 0xc5c3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc9111c4 (3432059332)
// size ...... 50627 (0xc5c3)
// includes .. 6   (offset: 0xb143)
// strings ... 395 (offset: 0xb173)
// dev strs .. 0   (offset: 0xc5c3)
// exports ... 41  (offset: 0x9593)
// cseg ...... 0x2d88 + 0x680b (0x9593)
// imports ... 123 (offset: 0x9bfb)
// animtree1 . 0   (offset: 0xc5c3)
// animtree2 . 0   (offset: 0xc5c3)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_infils_common;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\music_and_dialog;

#namespace namespace_d9bbc36a8c8a35ca;

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x7f857200, Offset: 0x2da6
// Size: 0x21b
function init()
{
    assert( isdefined( level.infilstruct ) );
    
    /#
        setdevdvarifuninitialized( @"hash_bfded00ac93c45b7", 1 );
        setdevdvarifuninitialized( @"hash_7f1da0c3501cbdf2", 1 );
    #/
    
    level.infilstruct.c130model = "jup_black_wz::veh9_mil_air_cargo_plane_exterior_infil";
    level.infilstruct.var_f265685cdcfee833 = "veh9_mil_air_cargo_plane_interior_infil";
    level.infilstruct.var_9d24745d02be135e = "tag_body_animate";
    level.infilstruct.c130soundalias = "veh_br_infil_c17_distant_lp";
    level.infilstruct.var_ea87d0ead0c54f1c = 1;
    level.infilstruct.var_dfeffb86c1dd09b6 = 1;
    
    if ( getdvarint( @"hash_4da4ea33e4dc6045", 0 ) )
    {
        level.infilstruct.var_b7ea0ff2bec1934c = 1;
        level.infilstruct.var_3a2e6ef0dea2917f = "jup_wz_infil_opening";
        level.infilstruct.binktime = 6.49;
    }
    
    level.infilstruct.var_12c03eae53e9bb4c = &function_60ca5349741930ba;
    level.infilstruct.var_e3fb172254c8751 = &function_e3fb172254c8751;
    level.infilstruct.var_cee5041ecb30a2c5 = &function_fdfe0dc503c4f44;
    level.infilstruct.var_3bead1a95b75d55d = &function_2295b0f632c0d19d;
    level.infilstruct.jumpfunc = &jumpfunc;
    level.infilstruct.var_9a4f6a9353c9055c = &function_9a4f6a9353c9055c;
    orbitcamassets = [ "cam_orbit_br_infil_ac130_player1", "cam_orbit_br_infil_ac130_player2", "cam_orbit_br_infil_ac130_player3", "cam_orbit_br_infil_ac130_player4", "cam_orbit_br_infil_ac130_player1" ];
    br_infils_util::set_orbit_cam_info( orbitcamassets );
    br_infils_util::function_8e44037c2a8b1713( "prematch", &prematchstartfunc );
    br_infils_util::function_8e44037c2a8b1713( "fadedown", &fadedownfunc );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x3aef4113, Offset: 0x2fc9
// Size: 0x5b
function function_e3fb172254c8751()
{
    sceneent = getent( "infil_exfil_hq_origin", #targetname );
    
    if ( isdefined( sceneent ) )
    {
        level.infilstruct.prestreamorigin = sceneent.origin;
        level.infilstruct.var_cfd89587fdc657ad = 1;
    }
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0xbd5b4676, Offset: 0x302c
// Size: 0x4a33
function function_fdfe0dc503c4f44( movingc130 )
{
    animstruct = spawnstruct();
    animstruct.cleanupfunc = &infilcleanup;
    animstruct.var_751e0e63f6c6f6ec = &function_1ad287fcb5253b3c;
    animstruct.movingc130 = movingc130;
    animstruct.movingc130.animname = "movingC130";
    animstruct.var_39f40041d77aaab4 = 1;
    sceneent = getent( "infil_exfil_hq_origin", #targetname );
    
    if ( !isdefined( sceneent ) )
    {
        sceneent = spawnstruct();
        sceneent.origin = ( 0, 0, 0 );
        sceneent.angles = ( 0, 0, 0 );
    }
    
    animstruct.origin = getdvarvector( @"hash_e30e6380ab2f16f7", sceneent.origin );
    animstruct.angles = sceneent.angles;
    animstruct.camerarunner = animstruct br_infils_util::spawn_script_model( "generic_prop_x30", "camera" );
    animstruct.camerarunner.angles = getdvarvector( @"hash_a243c97d0dc94bd7", animstruct.camerarunner.angles );
    animstruct.playertags[ 0 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag1" );
    animstruct.playertags[ 1 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag2" );
    animstruct.playertags[ 2 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag3" );
    animstruct.playertags[ 3 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag4" );
    animstruct.playertags[ 0 ] linkto( animstruct.camerarunner, "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 1 ] linkto( animstruct.camerarunner, "j_prop_5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 2 ] linkto( animstruct.camerarunner, "j_prop_6", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 3 ] linkto( animstruct.camerarunner, "j_prop_7", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 0 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player1" );
    animstruct.playermodels[ 1 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player2" );
    animstruct.playermodels[ 2 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player3" );
    animstruct.playermodels[ 3 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player4" );
    animstruct.playermodels[ 0 ] linkto( animstruct.playertags[ 0 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 1 ] linkto( animstruct.playertags[ 1 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 2 ] linkto( animstruct.playertags[ 2 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 3 ] linkto( animstruct.playertags[ 3 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    skins = [ "milsim_western_a", "milsim_western_b", "milsim_western_c", "milsim_western_d", "milsim_eastern_a", "milsim_eastern_b", "milsim_eastern_c", "milsim_eastern_d" ];
    randomskins = arrayrandomize( skins );
    animstruct.playermodels[ 0 ] function_91ed8e384d4e1fa6( randomskins[ 0 ] );
    animstruct.playermodels[ 1 ] function_91ed8e384d4e1fa6( randomskins[ 1 ] );
    animstruct.playermodels[ 2 ] function_91ed8e384d4e1fa6( randomskins[ 2 ] );
    animstruct.playermodels[ 3 ] function_91ed8e384d4e1fa6( randomskins[ 3 ] );
    animstruct.npcs = [];
    animstruct.npcs[ 0 ] = animstruct br_infils_util::spawn_script_model( "fullbody_mp_hero_graves_pmc_noglasses_infil", "graves" );
    animstruct.npcs[ 1 ] = animstruct br_infils_util::spawn_script_model( "fullbody_mp_shadow_company_03", "npc1" );
    animstruct.npcs[ 2 ] = animstruct br_infils_util::spawn_script_model( "fullbody_mp_shadow_company_02", "npc2" );
    animstruct.npcs[ 0 ] linkto( animstruct.camerarunner, "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.npcs[ 1 ] linkto( animstruct.camerarunner, "j_prop_8", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.npcs[ 2 ] linkto( animstruct.camerarunner, "j_prop_9", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.gravesanims = function_b8c133e7a137f51d();
    randomskins = arrayrandomize( skins );
    animstruct.parachutes = [];
    animstruct.parachutes[ 0 ] = animstruct br_infils_util::spawn_script_model( "c_t10_gear_navy_seal_parachute_01_exfil", "parachute1" );
    animstruct.parachutes[ 1 ] = animstruct br_infils_util::spawn_script_model( "c_t10_gear_navy_seal_parachute_01_exfil", "parachute2" );
    animstruct.parachutes[ 2 ] = animstruct br_infils_util::spawn_script_model( "c_t10_gear_navy_seal_parachute_01_exfil", "parachute3" );
    animstruct.parachutes[ 3 ] = animstruct br_infils_util::spawn_script_model( "c_t10_gear_navy_seal_parachute_01_exfil", "parachute4" );
    animstruct.parachutes[ 0 ] linkto( animstruct.camerarunner, "j_prop_10", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.parachutes[ 1 ] linkto( animstruct.camerarunner, "j_prop_11", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.parachutes[ 2 ] linkto( animstruct.camerarunner, "j_prop_12", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.parachutes[ 3 ] linkto( animstruct.camerarunner, "j_prop_13", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.var_c98edf6c8c06ef9d = [];
    animstruct.var_c98edf6c8c06ef9d[ 0 ] = animstruct br_infils_util::spawn_script_model( "c_t10_gear_navy_seal_parachute_01a_flat_exfil", "flatParachute1" );
    animstruct.var_c98edf6c8c06ef9d[ 1 ] = animstruct br_infils_util::spawn_script_model( "c_t10_gear_navy_seal_parachute_01b_flat_exfil", "flatParachute2" );
    animstruct.var_c98edf6c8c06ef9d[ 2 ] = animstruct br_infils_util::spawn_script_model( "c_t10_gear_navy_seal_parachute_01a_flat_exfil", "flatParachute3" );
    animstruct.var_c98edf6c8c06ef9d[ 3 ] = animstruct br_infils_util::spawn_script_model( "c_t10_gear_navy_seal_parachute_01b_flat_exfil", "flatParachute4" );
    animstruct.var_c98edf6c8c06ef9d[ 0 ] linkto( animstruct.camerarunner, "j_prop_14", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.var_c98edf6c8c06ef9d[ 1 ] linkto( animstruct.camerarunner, "j_prop_15", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.var_c98edf6c8c06ef9d[ 2 ] linkto( animstruct.camerarunner, "j_prop_16", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.var_c98edf6c8c06ef9d[ 3 ] linkto( animstruct.camerarunner, "j_prop_17", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.props = [];
    animstruct.props[ 0 ] = animstruct br_infils_util::spawn_script_model( "veh9_mil_air_cargo_plane_black", "cargoPlane" );
    animstruct.props[ 1 ] = animstruct br_infils_util::spawn_script_model( "clothing_sunglasses_02", "sunglasses" );
    animstruct.props[ 2 ] = animstruct br_infils_util::spawn_script_model( "jup_environment_props_infil", "infilProps" );
    animstruct.props[ 3 ] = animstruct br_infils_util::spawn_script_model( "jup_environment_props_exfil", "exfilProps" );
    animstruct.props[ 4 ] = animstruct br_infils_util::spawn_script_model( "device_laptop_exfil_dam", "laptop1" );
    animstruct.props[ 5 ] = animstruct br_infils_util::spawn_script_model( "device_laptop_exfil_dam", "laptop2" );
    animstruct.props[ 6 ] = animstruct br_infils_util::spawn_script_model( "device_laptop_exfil_dam", "laptop3" );
    animstruct.props[ 0 ] linkto( animstruct.camerarunner, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.props[ 1 ] linkto( animstruct.camerarunner, "j_prop_18", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.props[ 2 ] linkto( animstruct.camerarunner, "j_prop_19", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.props[ 3 ] linkto( animstruct.camerarunner, "j_prop_20", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.props[ 4 ] linkto( animstruct.camerarunner, "j_prop_21", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.props[ 5 ] linkto( animstruct.camerarunner, "j_prop_22", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.props[ 6 ] linkto( animstruct.camerarunner, "j_prop_23", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.packs = [];
    n = 0;
    
    if ( !getdvarint( @"hash_4da4ea33e4dc6045", 0 ) )
    {
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene_010" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_d3631c56c5abe3fd );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_br_jup_infil_sh010_gprop" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_br_jup_infil_sh010_gprop" ], "wz_br_jup_infil_sh010_xcam" );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_jup_infil_sh010_plyr1" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_jup_infil_sh010_plyr2" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_jup_infil_sh010_plyr3" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_jup_infil_sh010_plyr4" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_jup_infil_sh010_plyr1" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_jup_infil_sh010_plyr2" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_jup_infil_sh010_plyr3" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_jup_infil_sh010_plyr4" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ animstruct.gravesanims[ n ] ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_br_jup_infil_sh010_npc01" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_br_jup_infil_sh010_npc02" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 0 ], level.br_anim[ "wz_br_jup_infil_sh010_parachute01" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 1 ], level.br_anim[ "wz_br_jup_infil_sh010_parachute02" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 2 ], level.br_anim[ "wz_br_jup_infil_sh010_parachute03" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 3 ], level.br_anim[ "wz_br_jup_infil_sh010_parachute04" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 0 ], level.br_anim[ "wz_br_jup_infil_sh010_parachute_flat01" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 1 ], level.br_anim[ "wz_br_jup_infil_sh010_parachute_flat02" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 2 ], level.br_anim[ "wz_br_jup_infil_sh010_parachute_flat03" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 3 ], level.br_anim[ "wz_br_jup_infil_sh010_parachute_flat04" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 0 ], level.br_anim[ "wz_br_jup_infil_sh010_crgopln" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 1 ], level.br_anim[ "wz_br_jup_infil_sh010_glasses" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 2 ], level.br_anim[ "wz_br_jup_infil_sh010_infil_prop" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 3 ], level.br_anim[ "wz_br_jup_infil_sh010_exfil_prop" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 4 ], level.br_anim[ "wz_br_jup_infil_sh010_laptop1" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 5 ], level.br_anim[ "wz_br_jup_infil_sh010_laptop2" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 6 ], level.br_anim[ "wz_br_jup_infil_sh010_laptop3" ] );
        n++;
        var_e5bc746b3f9e1ba2 = &function_3132af4c6275dd4e;
    }
    
    if ( !isdefined( var_e5bc746b3f9e1ba2 ) )
    {
        var_e5bc746b3f9e1ba2 = &function_d3631c56c5abe3fd;
    }
    
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene_020" );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], var_e5bc746b3f9e1ba2 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_br_jup_infil_sh020_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_br_jup_infil_sh020_gprop" ], "wz_br_jup_infil_sh020_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_jup_infil_sh020_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_jup_infil_sh020_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_jup_infil_sh020_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_jup_infil_sh020_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_jup_infil_sh020_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_jup_infil_sh020_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_jup_infil_sh020_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_jup_infil_sh020_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ animstruct.gravesanims[ n ] ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_br_jup_infil_sh020_npc01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_br_jup_infil_sh020_npc02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 0 ], level.br_anim[ "wz_br_jup_infil_sh020_parachute01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 1 ], level.br_anim[ "wz_br_jup_infil_sh020_parachute02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 2 ], level.br_anim[ "wz_br_jup_infil_sh020_parachute03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 3 ], level.br_anim[ "wz_br_jup_infil_sh020_parachute04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 0 ], level.br_anim[ "wz_br_jup_infil_sh020_parachute_flat01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 1 ], level.br_anim[ "wz_br_jup_infil_sh020_parachute_flat02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 2 ], level.br_anim[ "wz_br_jup_infil_sh020_parachute_flat03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 3 ], level.br_anim[ "wz_br_jup_infil_sh020_parachute_flat04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 0 ], level.br_anim[ "wz_br_jup_infil_sh020_crgopln" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 1 ], level.br_anim[ "wz_br_jup_infil_sh020_glasses" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 2 ], level.br_anim[ "wz_br_jup_infil_sh020_infil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 3 ], level.br_anim[ "wz_br_jup_infil_sh020_exfil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 4 ], level.br_anim[ "wz_br_jup_infil_sh020_laptop1" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 5 ], level.br_anim[ "wz_br_jup_infil_sh020_laptop2" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 6 ], level.br_anim[ "wz_br_jup_infil_sh020_laptop3" ] );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene_030" );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_47d8b6a95a831e27 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_br_jup_infil_sh030_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_br_jup_infil_sh030_gprop" ], "wz_br_jup_infil_sh030_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_jup_infil_sh030_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_jup_infil_sh030_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_jup_infil_sh030_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_jup_infil_sh030_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_jup_infil_sh030_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_jup_infil_sh030_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_jup_infil_sh030_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_jup_infil_sh030_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ animstruct.gravesanims[ n ] ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_br_jup_infil_sh030_npc01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_br_jup_infil_sh030_npc02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 0 ], level.br_anim[ "wz_br_jup_infil_sh030_parachute01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 1 ], level.br_anim[ "wz_br_jup_infil_sh030_parachute02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 2 ], level.br_anim[ "wz_br_jup_infil_sh030_parachute03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 3 ], level.br_anim[ "wz_br_jup_infil_sh030_parachute04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 0 ], level.br_anim[ "wz_br_jup_infil_sh030_parachute_flat01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 1 ], level.br_anim[ "wz_br_jup_infil_sh030_parachute_flat02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 2 ], level.br_anim[ "wz_br_jup_infil_sh030_parachute_flat03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 3 ], level.br_anim[ "wz_br_jup_infil_sh030_parachute_flat04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 0 ], level.br_anim[ "wz_br_jup_infil_sh030_crgopln" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 1 ], level.br_anim[ "wz_br_jup_infil_sh030_glasses" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 2 ], level.br_anim[ "wz_br_jup_infil_sh030_infil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 3 ], level.br_anim[ "wz_br_jup_infil_sh030_exfil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 4 ], level.br_anim[ "wz_br_jup_infil_sh030_laptop1" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 5 ], level.br_anim[ "wz_br_jup_infil_sh030_laptop2" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 6 ], level.br_anim[ "wz_br_jup_infil_sh030_laptop3" ] );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene_040" );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_7e53f666e3a7cfd8 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_br_jup_infil_sh040_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_br_jup_infil_sh040_gprop" ], "wz_br_jup_infil_sh040_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_jup_infil_sh040_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_jup_infil_sh040_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_jup_infil_sh040_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_jup_infil_sh040_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_jup_infil_sh040_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_jup_infil_sh040_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_jup_infil_sh040_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_jup_infil_sh040_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ animstruct.gravesanims[ n ] ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_br_jup_infil_sh040_npc01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_br_jup_infil_sh040_npc02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 0 ], level.br_anim[ "wz_br_jup_infil_sh040_parachute01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 1 ], level.br_anim[ "wz_br_jup_infil_sh040_parachute02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 2 ], level.br_anim[ "wz_br_jup_infil_sh040_parachute03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 3 ], level.br_anim[ "wz_br_jup_infil_sh040_parachute04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 0 ], level.br_anim[ "wz_br_jup_infil_sh040_parachute_flat01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 1 ], level.br_anim[ "wz_br_jup_infil_sh040_parachute_flat02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 2 ], level.br_anim[ "wz_br_jup_infil_sh040_parachute_flat03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 3 ], level.br_anim[ "wz_br_jup_infil_sh040_parachute_flat04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 0 ], level.br_anim[ "wz_br_jup_infil_sh040_crgopln" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 1 ], level.br_anim[ "wz_br_jup_infil_sh040_glasses" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 2 ], level.br_anim[ "wz_br_jup_infil_sh040_infil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 3 ], level.br_anim[ "wz_br_jup_infil_sh040_exfil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 4 ], level.br_anim[ "wz_br_jup_infil_sh040_laptop1" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 5 ], level.br_anim[ "wz_br_jup_infil_sh040_laptop2" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 6 ], level.br_anim[ "wz_br_jup_infil_sh040_laptop3" ] );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene_050" );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_de66b1e993b4e0d1 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_br_jup_infil_sh050_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_br_jup_infil_sh050_gprop" ], "wz_br_jup_infil_sh050_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_jup_infil_sh050_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_jup_infil_sh050_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_jup_infil_sh050_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_jup_infil_sh050_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_jup_infil_sh050_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_jup_infil_sh050_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_jup_infil_sh050_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_jup_infil_sh050_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ animstruct.gravesanims[ n ] ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_br_jup_infil_sh050_npc01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_br_jup_infil_sh050_npc02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 0 ], level.br_anim[ "wz_br_jup_infil_sh050_parachute01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 1 ], level.br_anim[ "wz_br_jup_infil_sh050_parachute02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 2 ], level.br_anim[ "wz_br_jup_infil_sh050_parachute03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 3 ], level.br_anim[ "wz_br_jup_infil_sh050_parachute04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 0 ], level.br_anim[ "wz_br_jup_infil_sh050_parachute_flat01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 1 ], level.br_anim[ "wz_br_jup_infil_sh050_parachute_flat02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 2 ], level.br_anim[ "wz_br_jup_infil_sh050_parachute_flat03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 3 ], level.br_anim[ "wz_br_jup_infil_sh050_parachute_flat04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 0 ], level.br_anim[ "wz_br_jup_infil_sh050_crgopln" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 1 ], level.br_anim[ "wz_br_jup_infil_sh050_glasses" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 2 ], level.br_anim[ "wz_br_jup_infil_sh050_infil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 3 ], level.br_anim[ "wz_br_jup_infil_sh050_exfil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 4 ], level.br_anim[ "wz_br_jup_infil_sh050_laptop1" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 5 ], level.br_anim[ "wz_br_jup_infil_sh050_laptop2" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 6 ], level.br_anim[ "wz_br_jup_infil_sh050_laptop3" ] );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene_060" );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_221764da7d14e712 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_br_jup_infil_sh060_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_br_jup_infil_sh060_gprop" ], "wz_br_jup_infil_sh060_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_jup_infil_sh060_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_jup_infil_sh060_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_jup_infil_sh060_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_jup_infil_sh060_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_jup_infil_sh060_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_jup_infil_sh060_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_jup_infil_sh060_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_jup_infil_sh060_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ animstruct.gravesanims[ n ] ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_br_jup_infil_sh060_npc01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_br_jup_infil_sh060_npc02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 0 ], level.br_anim[ "wz_br_jup_infil_sh060_parachute01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 1 ], level.br_anim[ "wz_br_jup_infil_sh060_parachute02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 2 ], level.br_anim[ "wz_br_jup_infil_sh060_parachute03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 3 ], level.br_anim[ "wz_br_jup_infil_sh060_parachute04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 0 ], level.br_anim[ "wz_br_jup_infil_sh060_parachute_flat01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 1 ], level.br_anim[ "wz_br_jup_infil_sh060_parachute_flat02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 2 ], level.br_anim[ "wz_br_jup_infil_sh060_parachute_flat03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 3 ], level.br_anim[ "wz_br_jup_infil_sh060_parachute_flat04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 0 ], level.br_anim[ "wz_br_jup_infil_sh060_crgopln" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 1 ], level.br_anim[ "wz_br_jup_infil_sh060_glasses" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 2 ], level.br_anim[ "wz_br_jup_infil_sh060_infil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 3 ], level.br_anim[ "wz_br_jup_infil_sh060_exfil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 4 ], level.br_anim[ "wz_br_jup_infil_sh060_laptop1" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 5 ], level.br_anim[ "wz_br_jup_infil_sh060_laptop2" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 6 ], level.br_anim[ "wz_br_jup_infil_sh060_laptop3" ] );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene_070" );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_7149ce4f44d2386b );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_br_jup_infil_sh070_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_br_jup_infil_sh070_gprop" ], "wz_br_jup_infil_sh070_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_jup_infil_sh070_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_jup_infil_sh070_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_jup_infil_sh070_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_jup_infil_sh070_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_jup_infil_sh070_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_jup_infil_sh070_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_jup_infil_sh070_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_jup_infil_sh070_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ animstruct.gravesanims[ n ] ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_br_jup_infil_sh070_npc01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_br_jup_infil_sh070_npc02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 0 ], level.br_anim[ "wz_br_jup_infil_sh070_parachute01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 1 ], level.br_anim[ "wz_br_jup_infil_sh070_parachute02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 2 ], level.br_anim[ "wz_br_jup_infil_sh070_parachute03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 3 ], level.br_anim[ "wz_br_jup_infil_sh070_parachute04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 0 ], level.br_anim[ "wz_br_jup_infil_sh070_parachute_flat01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 1 ], level.br_anim[ "wz_br_jup_infil_sh070_parachute_flat02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 2 ], level.br_anim[ "wz_br_jup_infil_sh070_parachute_flat03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 3 ], level.br_anim[ "wz_br_jup_infil_sh070_parachute_flat04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 0 ], level.br_anim[ "wz_br_jup_infil_sh070_crgopln" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 1 ], level.br_anim[ "wz_br_jup_infil_sh070_glasses" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 2 ], level.br_anim[ "wz_br_jup_infil_sh070_infil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 3 ], level.br_anim[ "wz_br_jup_infil_sh070_exfil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 4 ], level.br_anim[ "wz_br_jup_infil_sh070_laptop1" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 5 ], level.br_anim[ "wz_br_jup_infil_sh070_laptop2" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 6 ], level.br_anim[ "wz_br_jup_infil_sh070_laptop3" ] );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene_080" );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_3b99489f89c29c9c );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_br_jup_infil_sh080_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_br_jup_infil_sh080_gprop" ], "wz_br_jup_infil_sh080_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_jup_infil_sh080_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_jup_infil_sh080_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_jup_infil_sh080_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_jup_infil_sh080_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_jup_infil_sh080_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_jup_infil_sh080_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_jup_infil_sh080_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_jup_infil_sh080_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ animstruct.gravesanims[ n ] ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_br_jup_infil_sh080_npc01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_br_jup_infil_sh080_npc02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 0 ], level.br_anim[ "wz_br_jup_infil_sh080_parachute01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 1 ], level.br_anim[ "wz_br_jup_infil_sh080_parachute02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 2 ], level.br_anim[ "wz_br_jup_infil_sh080_parachute03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 3 ], level.br_anim[ "wz_br_jup_infil_sh080_parachute04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 0 ], level.br_anim[ "wz_br_jup_infil_sh080_parachute_flat01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 1 ], level.br_anim[ "wz_br_jup_infil_sh080_parachute_flat02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 2 ], level.br_anim[ "wz_br_jup_infil_sh080_parachute_flat03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 3 ], level.br_anim[ "wz_br_jup_infil_sh080_parachute_flat04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 0 ], level.br_anim[ "wz_br_jup_infil_sh080_crgopln" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 1 ], level.br_anim[ "wz_br_jup_infil_sh080_glasses" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 2 ], level.br_anim[ "wz_br_jup_infil_sh080_infil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 3 ], level.br_anim[ "wz_br_jup_infil_sh080_exfil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 4 ], level.br_anim[ "wz_br_jup_infil_sh080_laptop1" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 5 ], level.br_anim[ "wz_br_jup_infil_sh080_laptop2" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 6 ], level.br_anim[ "wz_br_jup_infil_sh080_laptop3" ] );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene_090" );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_4ba161d17e2fa95 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_br_jup_infil_sh090_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_br_jup_infil_sh090_gprop" ], "wz_br_jup_infil_sh090_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_jup_infil_sh090_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_jup_infil_sh090_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_jup_infil_sh090_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_jup_infil_sh090_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_jup_infil_sh090_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_jup_infil_sh090_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_jup_infil_sh090_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_jup_infil_sh090_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ animstruct.gravesanims[ n ] ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_br_jup_infil_sh090_npc01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_br_jup_infil_sh090_npc02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 0 ], level.br_anim[ "wz_br_jup_infil_sh090_parachute01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 1 ], level.br_anim[ "wz_br_jup_infil_sh090_parachute02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 2 ], level.br_anim[ "wz_br_jup_infil_sh090_parachute03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 3 ], level.br_anim[ "wz_br_jup_infil_sh090_parachute04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 0 ], level.br_anim[ "wz_br_jup_infil_sh090_parachute_flat01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 1 ], level.br_anim[ "wz_br_jup_infil_sh090_parachute_flat02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 2 ], level.br_anim[ "wz_br_jup_infil_sh090_parachute_flat03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 3 ], level.br_anim[ "wz_br_jup_infil_sh090_parachute_flat04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 0 ], level.br_anim[ "wz_br_jup_infil_sh090_crgopln" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 1 ], level.br_anim[ "wz_br_jup_infil_sh090_glasses" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 2 ], level.br_anim[ "wz_br_jup_infil_sh090_infil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 3 ], level.br_anim[ "wz_br_jup_infil_sh090_exfil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 4 ], level.br_anim[ "wz_br_jup_infil_sh090_laptop1" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 5 ], level.br_anim[ "wz_br_jup_infil_sh090_laptop2" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 6 ], level.br_anim[ "wz_br_jup_infil_sh090_laptop3" ] );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene_100" );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_f930fd929e5ecd53 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_br_jup_infil_sh100_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_br_jup_infil_sh100_gprop" ], "wz_br_jup_infil_sh100_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_jup_infil_sh100_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_jup_infil_sh100_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_jup_infil_sh100_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_jup_infil_sh100_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_jup_infil_sh100_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_jup_infil_sh100_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_jup_infil_sh100_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_jup_infil_sh100_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ animstruct.gravesanims[ n ] ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_br_jup_infil_sh100_npc01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_br_jup_infil_sh100_npc02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 0 ], level.br_anim[ "wz_br_jup_infil_sh100_parachute01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 1 ], level.br_anim[ "wz_br_jup_infil_sh100_parachute02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 2 ], level.br_anim[ "wz_br_jup_infil_sh100_parachute03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.parachutes[ 3 ], level.br_anim[ "wz_br_jup_infil_sh100_parachute04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 0 ], level.br_anim[ "wz_br_jup_infil_sh100_parachute_flat01" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 1 ], level.br_anim[ "wz_br_jup_infil_sh100_parachute_flat02" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 2 ], level.br_anim[ "wz_br_jup_infil_sh100_parachute_flat03" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_c98edf6c8c06ef9d[ 3 ], level.br_anim[ "wz_br_jup_infil_sh100_parachute_flat04" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 0 ], level.br_anim[ "wz_br_jup_infil_sh100_crgopln" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 1 ], level.br_anim[ "wz_br_jup_infil_sh100_glasses" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 2 ], level.br_anim[ "wz_br_jup_infil_sh100_infil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 3 ], level.br_anim[ "wz_br_jup_infil_sh100_exfil_prop" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 4 ], level.br_anim[ "wz_br_jup_infil_sh100_laptop1" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 5 ], level.br_anim[ "wz_br_jup_infil_sh100_laptop2" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.props[ 6 ], level.br_anim[ "wz_br_jup_infil_sh100_laptop3" ] );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "prelooping", 0 );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ 45 ], &function_6997506bbd112cbe );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130, level.br_anim[ "wz_br_jup_infil_idle_crgopln" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_br_jup_infil_transition_gprop" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_br_jup_infil_transition_gprop" ], "wz_br_jup_infil_transition_xcam" );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_br_jup_infil_transition_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_br_jup_infil_transition_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_br_jup_infil_transition_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_br_jup_infil_transition_plyr4" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_br_jup_infil_transition_plyr1" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_br_jup_infil_transition_plyr2" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_br_jup_infil_transition_plyr3" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_br_jup_infil_transition_plyr4" ] );
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "looping", 1 );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ 45 ], &function_2382a170e8bf0851 );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.movingc130, level.br_anim[ "wz_br_jup_infil_idle_crgopln" ] );
    animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_idle_sh010" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_idle_sh010" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_idle_sh010" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_idle_sh010" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_idle_sh010" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_idle_sh010" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_idle_sh010" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_idle_sh010" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_idle_sh010" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "j_prop_1" );
    return animstruct;
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0, eflags: 0x4
// Checksum 0x6c30bfe0, Offset: 0x7a68
// Size: 0x1b4
function private function_b8c133e7a137f51d()
{
    var_45d6bb1ac886e1d3 = [ "wz_br_jup_infil_sh010_cmdr", "wz_br_jup_infil_sh020_cmdr", "wz_br_jup_infil_sh030_cmdr", "wz_br_jup_infil_sh040_cmdr", "wz_br_jup_infil_sh050_cmdr", "wz_br_jup_infil_sh060_cmdr", "wz_br_jup_infil_sh070_cmdr", "wz_br_jup_infil_sh080_cmdr", "wz_br_jup_infil_sh090_cmdr", "wz_br_jup_infil_sh100_cmdr" ];
    const_shots_randomized = [ 1, 1, 1, 1, 1, 1, 0, 0, 0, 0 ];
    var_65d389c3930a2a2b = [ 0, 0, 1, 0, 1, 0, 0, 0, 0, 0 ];
    var_c6fded36f3f5e6cb = [ "_a", "_b", "_c" ];
    
    if ( getdvarint( @"hash_4da4ea33e4dc6045", 0 ) )
    {
        var_45d6bb1ac886e1d3[ 0 ] = undefined;
        function_cdc669dbc8ea2101( var_45d6bb1ac886e1d3 );
        const_shots_randomized[ 0 ] = undefined;
        function_cdc669dbc8ea2101( const_shots_randomized );
        var_65d389c3930a2a2b[ 0 ] = undefined;
        function_cdc669dbc8ea2101( var_65d389c3930a2a2b );
    }
    
    outanims = [];
    mixup = "";
    
    for ( shotidx = 0; shotidx < var_45d6bb1ac886e1d3.size ; shotidx++ )
    {
        if ( !const_shots_randomized[ shotidx ] )
        {
            mixup = "";
        }
        else if ( !var_65d389c3930a2a2b[ shotidx ] )
        {
            mixup = utility::array_random( var_c6fded36f3f5e6cb );
        }
        
        shotanim = var_45d6bb1ac886e1d3[ shotidx ];
        outanims[ outanims.size ] = shotanim + mixup;
    }
    
    return outanims;
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0x5f2bb210, Offset: 0x7c25
// Size: 0x56e
function function_2382a170e8bf0851( array )
{
    pack = self.activepack;
    assert( isdefined( pack ) );
    var_3a238e44047ac624 = 0;
    var_9403e3d4f0d932b8 = 4;
    
    /#
        var_3a238e44047ac624 = br_infils_common::function_5e7c30c827f65843();
        var_9403e3d4f0d932b8 = br_infils_common::function_486c89102889361c();
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
            player.infilanimindex = possibleindices[ playercount % possibleindices.size ];
            player.var_edbda953d7469bd7 = numplayers;
            playercount++;
            usedindices[ usedindices.size ] = player.infilanimindex;
        }
        
        for ( parachuteidx = 0; parachuteidx < 4 ; parachuteidx++ )
        {
            foreach ( player in players )
            {
                self.parachutes[ parachuteidx ] hidefromplayer( player );
                self.var_c98edf6c8c06ef9d[ parachuteidx ] hidefromplayer( player );
            }
        }
        
        foreach ( index in usedindices )
        {
            foreach ( player in players )
            {
                self.parachutes[ index - 1 ] showtoplayer( player );
                self.var_c98edf6c8c06ef9d[ index - 1 ] showtoplayer( player );
            }
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
        
        for ( idx = 0; idx < var_9403e3d4f0d932b8 ; idx++ )
        {
            foreach ( player in players )
            {
                self.parachutes[ idx ] showtoplayer( player );
                self.var_c98edf6c8c06ef9d[ idx ] showtoplayer( player );
            }
        }
    }
    
    if ( array.size >= 1 && isnumber( array[ 0 ] ) )
    {
        foreach ( player in level.infilstruct.players )
        {
            if ( isdefined( player ) )
            {
                player setclientdvar( @"cg_fov", array[ 0 ] );
                player setclientdvar( @"cg_disable_user_fov", 1 );
            }
        }
    }
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0xb174d3f, Offset: 0x819b
// Size: 0x81
function function_a78a27b68fb07247()
{
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    
    if ( var_2754701952ea4d67 )
    {
        self function_a565dafac620d68e( %"hash_34c59bed7392d266" );
        self function_a565dafac620d68e( %"hash_6672d428dc04ad44" );
    }
    
    self setclientomnvar( "ui_br_infil_exfil_player_focus", 1 );
    audio_utility::function_7b72e563ad80e020( level.players, "mp_jup_br_infil", 0.05 );
    audio_utility::function_5b885ff87a1180d4( level.players, "mute_ambience_elements_emitters", 0.5 );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0x5768ce57, Offset: 0x8224
// Size: 0x153
function function_d3631c56c5abe3fd( array )
{
    function_2382a170e8bf0851( array );
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( var_2754701952ea4d67 )
        {
            player function_a565dafac620d68e( %"hash_34c59bed7392d266" );
            player function_a565dafac620d68e( %"hash_6672d428dc04ad44" );
        }
    }
    
    br_infils_util::function_94c95c81b53e5532( "infil_light" );
    br_infils_util::function_fffda20dc2c2df07( &function_a78a27b68fb07247 );
    br_infil_intro = audio_utility::function_d4d265f3dcd0a13c( "br_infil_intro" );
    br_infil_intro_classic = audio_utility::function_d4d265f3dcd0a13c( "br_infil_intro_classic" );
    audio_utility::function_6a0ed3b9fb942369( level.infilstruct.players, br_infil_intro, undefined, undefined, br_infil_intro_classic );
    audio_utility::function_5b885ff87a1180d4( level.players, "mute_ambience_elements_emitters", 1 );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0xa547ce6c, Offset: 0x837f
// Size: 0x15
function function_3132af4c6275dd4e( array )
{
    function_2382a170e8bf0851( array );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0x3ee28203, Offset: 0x839c
// Size: 0x15
function function_47d8b6a95a831e27( array )
{
    function_2382a170e8bf0851( array );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0x4a7a6b8c, Offset: 0x83b9
// Size: 0x15
function function_7e53f666e3a7cfd8( array )
{
    function_2382a170e8bf0851( array );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0xd1df27e3, Offset: 0x83d6
// Size: 0x15
function function_de66b1e993b4e0d1( array )
{
    function_2382a170e8bf0851( array );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0x8e7076fa, Offset: 0x83f3
// Size: 0x62
function function_221764da7d14e712( array )
{
    function_2382a170e8bf0851( array );
    utility::delaythread( 1.5, &audio_utility::function_5b885ff87a1180d4, level.players, "mute_music", 8 );
    utility::delaythread( 2.6, &audio_utility::function_63bf1584c79c055, level.infilstruct.players, "scn_jup_br_infil_c17_takeoff_spinup_lssrss" );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0x1cbc1e6, Offset: 0x845d
// Size: 0xff
function function_7149ce4f44d2386b( array )
{
    function_2382a170e8bf0851( array );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_br_infil_exfil_player_focus", 1 );
    }
    
    utility::delaythread( 2.9, &audio_utility::function_63bf1584c79c055, level.infilstruct.players, "scn_jup_br_infil_c17_takeoff_main_lr" );
    audio_utility::function_5f0fd96a39f569a1( level.players, 5 );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mute_ambience_elements_emitters", 5 );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0x4f70260d, Offset: 0x8564
// Size: 0x15
function function_3b99489f89c29c9c( array )
{
    function_2382a170e8bf0851( array );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0xd4d56a62, Offset: 0x8581
// Size: 0x15
function function_4ba161d17e2fa95( array )
{
    function_2382a170e8bf0851( array );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x96280e47, Offset: 0x859e
// Size: 0x5a
function function_88e446bc247dd06a()
{
    transitionseconds = getdvarfloat( @"hash_224074cc9cbd34e3", 1 );
    self visionsetnakedforplayer( "", transitionseconds );
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    
    if ( var_2754701952ea4d67 )
    {
        self function_72cf2eee8e035013( %"hash_34c59bed7392d266" );
    }
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x5a854f8e, Offset: 0x8600
// Size: 0x114
function function_e813468aad06000f()
{
    delayseconds = getdvarfloat( @"hash_ef579438c4248057", 3.75 );
    transitionseconds = getdvarfloat( @"hash_224074cc9cbd34e3", 1 );
    
    if ( delayseconds > 0 )
    {
        wait delayseconds;
    }
    
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player visionsetnakedforplayer( "", transitionseconds );
        
        if ( var_2754701952ea4d67 )
        {
            player function_72cf2eee8e035013( %"hash_34c59bed7392d266" );
        }
    }
    
    br_infils_util::function_fffda20dc2c2df07( &function_88e446bc247dd06a );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x440a0aad, Offset: 0x871c
// Size: 0x85
function function_db9fae619590a707()
{
    randomoptions = [ "dx_br_jpbm_infl_grav_tkoa", "dx_br_jpbm_infl_grav_tkob", "dx_br_jpbm_infl_grav_tkoc" ];
    waitframetimes = [ 18, 15, 28 ];
    choice = randomint( randomoptions.size );
    wait waitframetimes[ choice ] * level.framedurationseconds;
    audio_utility::function_63bf1584c79c055( level.infilstruct.players, randomoptions[ choice ] );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0xd7ac5023, Offset: 0x87a9
// Size: 0x15e
function function_26818e70c8bda0a4()
{
    var_ed041172455b14c3 = 1;
    var_98501b826faaa9c9 = 1;
    var_14c620fd721a4955 = 1.25;
    shotlength = getanimlength( level.br_anim[ "wz_br_jup_infil_sh100_gprop" ] );
    var_ba75c6c72c641fe5 = max( 0.05, shotlength - var_ed041172455b14c3 );
    totalwaittime = var_ba75c6c72c641fe5 + var_98501b826faaa9c9 + var_14c620fd721a4955;
    audio_utility::function_7b72e563ad80e020( level.players, "br_c17_infil_ext", totalwaittime + 3 );
    audio_utility::function_5b885ff87a1180d4( level.players, "mute_ambience_elements_emitters", totalwaittime + 3 );
    wait var_ba75c6c72c641fe5;
    br_infils_util::function_c050cae6f9bcb77f( 0.9, level.infilstruct.players, "hq_transition" );
    br_infils_util::function_fffda20dc2c2df07( &function_40bfb73673bd6503 );
    level.infilstruct.var_a85812a056eae63e = 1;
    wait var_98501b826faaa9c9;
    teleporttomovingplane();
    thread function_e813468aad06000f();
    wait var_14c620fd721a4955;
    level.infilstruct.var_a85812a056eae63e = undefined;
    br_infils_util::function_573cdd2bc439ec67( 1, level.infilstruct.players, "hq_transition" );
    audio_utility::function_5b885ff87a1180d4( level.players, "jup_br_infil_igc", 1 );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x274288da, Offset: 0x890f
// Size: 0x25
function function_40bfb73673bd6503()
{
    if ( level.infilstruct.var_a85812a056eae63e )
    {
        br_infils_util::function_d36ff11e6bc121f6( 0, "hq_transition" );
    }
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0xad23c5e1, Offset: 0x893c
// Size: 0x4c
function function_f930fd929e5ecd53( array )
{
    function_2382a170e8bf0851( array );
    thread function_26818e70c8bda0a4();
    thread function_db9fae619590a707();
    utility::delaythread( 2.8, &audio_utility::function_63bf1584c79c055, level.infilstruct.players, "scn_jup_br_infil_c17_transition_lr" );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1
// Checksum 0xd9cb907e, Offset: 0x8990
// Size: 0x354
function function_6997506bbd112cbe( array )
{
    function_2382a170e8bf0851( array );
    self.npcs[ 0 ] unlink();
    self.npcs[ 1 ] unlink();
    self.npcs[ 2 ] unlink();
    self.npcs[ 0 ] hide();
    self.npcs[ 1 ] hide();
    self.npcs[ 2 ] hide();
    self.parachutes[ 0 ] unlink();
    self.parachutes[ 1 ] unlink();
    self.parachutes[ 2 ] unlink();
    self.parachutes[ 3 ] unlink();
    self.parachutes[ 0 ] hide();
    self.parachutes[ 1 ] hide();
    self.parachutes[ 2 ] hide();
    self.parachutes[ 3 ] hide();
    self.var_c98edf6c8c06ef9d[ 0 ] unlink();
    self.var_c98edf6c8c06ef9d[ 1 ] unlink();
    self.var_c98edf6c8c06ef9d[ 2 ] unlink();
    self.var_c98edf6c8c06ef9d[ 3 ] unlink();
    self.var_c98edf6c8c06ef9d[ 0 ] hide();
    self.var_c98edf6c8c06ef9d[ 1 ] hide();
    self.var_c98edf6c8c06ef9d[ 2 ] hide();
    self.var_c98edf6c8c06ef9d[ 3 ] hide();
    self.props[ 0 ] unlink();
    self.props[ 1 ] unlink();
    self.props[ 2 ] unlink();
    self.props[ 3 ] unlink();
    self.props[ 4 ] unlink();
    self.props[ 5 ] unlink();
    self.props[ 6 ] unlink();
    self.props[ 0 ] hide();
    self.props[ 1 ] hide();
    self.props[ 2 ] hide();
    self.props[ 3 ] hide();
    self.props[ 4 ] hide();
    self.props[ 5 ] hide();
    self.props[ 6 ] hide();
    self.playertags[ 0 ] linkto( self.camerarunner, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.playertags[ 1 ] linkto( self.camerarunner, "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.playertags[ 2 ] linkto( self.camerarunner, "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.playertags[ 3 ] linkto( self.camerarunner, "j_prop_5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x983c9240, Offset: 0x8cec
// Size: 0x23
function function_6fdcd4475087fc56()
{
    self.manualoverridewindmaterial = undefined;
    player::setwind( "1" );
    self setallstreamloaddist( 0 );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0xcdbc272, Offset: 0x8d17
// Size: 0x176
function teleporttomovingplane()
{
    self.movingc130 setscriptablepartstate( "running_lights", "on" );
    br_infils_util::function_8a24432634d2a043();
    setomnvar( "ui_hide_player_icons", 0 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setallstreamloaddist( 0 );
        player clearpredictedstreampos();
        player setclientomnvar( "ui_br_infil_chyron_change", 1 );
    }
    
    if ( isdefined( self.movingc130 ) )
    {
        self.camerarunner unlink();
        self.camerarunner linkto( self.movingc130, "tag_body_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        
        if ( !level.infilstruct.var_df720711dd79fea7 || br_infils_util::function_7d2f9d2a086bd511() )
        {
            self.movingc130 notify( #"start_moving" );
        }
    }
    
    level notify( #"hash_c14217752dacdeed" );
    thread function_327cc5b9e5eeb626();
    br_infils_util::function_fffda20dc2c2df07( &function_6fdcd4475087fc56 );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x47a79f21, Offset: 0x8e95
// Size: 0xf
function function_327cc5b9e5eeb626()
{
    wait 0.1;
    function_8480689471b795a0();
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0xad3b092f, Offset: 0x8eac
// Size: 0x1a
function function_8480689471b795a0()
{
    self.movingc130 setscriptablepartstate( "int_lights_green_all", "on" );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0xc8ab5cf9, Offset: 0x8ece
// Size: 0x206
function function_2295b0f632c0d19d()
{
    self clearclienttriggeraudiozone( 3 );
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
    
    player_link_tag = "j_prop_" + self.infilanimindex + 1;
    cos45 = cos( 45 );
    
    if ( dotforward < -1 * cos45 )
    {
        return [ "wz_infil_gprop_standard_sh010", level.br_anim[ "wz_infil_gprop_standard_sh010" ], "wz_infil_standardforward_jump_sh010", player_link_tag ];
    }
    
    if ( dotright > cos45 )
    {
        return [ "wz_infil_gprop_l90_sh010", level.br_anim[ "wz_infil_gprop_l90_sh010" ], "wz_infil_l90_jump_sh010", player_link_tag ];
    }
    
    if ( dotright < -1 * cos45 )
    {
        return [ "wz_infil_gprop_r90_sh010", level.br_anim[ "wz_infil_gprop_r90_sh010" ], "wz_infil_r90_jump_sh010", player_link_tag ];
    }
    
    if ( dotright > 0 )
    {
        return [ "wz_infil_gprop_l180_sh010", level.br_anim[ "wz_infil_gprop_l180_sh010" ], "wz_infil_l180_jump_sh010", player_link_tag ];
    }
    
    return [ "wz_infil_gprop_r180_sh010", level.br_anim[ "wz_infil_gprop_r180_sh010" ], "wz_infil_r180_jump_sh010", player_link_tag ];
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x98d36bb2, Offset: 0x90dc
// Size: 0x40
function function_9ae48f565dda4a82()
{
    self endon( #"disconnect" );
    wait 5;
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    
    if ( var_2754701952ea4d67 )
    {
        self function_72cf2eee8e035013( %"hash_6672d428dc04ad44" );
    }
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x68a140d9, Offset: 0x9124
// Size: 0x3b
function jumpfunc()
{
    thread function_9ae48f565dda4a82();
    
    if ( getdvarint( @"hash_549df6ab370a2bc4", 1 ) )
    {
        self lerpfovscalefactor( 0, 0 );
        self setclientdvar( @"cg_disable_user_fov", 0 );
    }
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0xcef1501a, Offset: 0x9167
// Size: 0x84
function function_9a4f6a9353c9055c()
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

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0, eflags: 0x4
// Checksum 0x3d908007, Offset: 0x91f3
// Size: 0x14
function private prematchstartfunc()
{
    level.nosuspensemusic = 1;
    thread music_and_dialog::stopsuspensemusic();
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0, eflags: 0x4
// Checksum 0xe4cb4ecb, Offset: 0x920f
// Size: 0x12
function private fadedownfunc()
{
    level thread function_818e211bb54ccc2a();
    level thread function_1a18fedd90174829();
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0, eflags: 0x4
// Checksum 0x3f404872, Offset: 0x9229
// Size: 0x94
function private function_818e211bb54ccc2a()
{
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "jup_br_infil_igc", 2.5 );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mute_ambience_elements_emitters", 3 );
    audio_utility::function_7b72e563ad80e020( level.players, "mp_jup_br_infil_exfil_null", 3 );
    clearmusicstate();
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mute_music", 8, 0.683772 );
    wait 2.5;
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_br_lobby_fade", 0 );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0, eflags: 0x4
// Checksum 0xad4c4d33, Offset: 0x92c5
// Size: 0x37
function private function_1a18fedd90174829()
{
    wait 1.3;
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_infil_hit_swt" );
    audio_utility::function_7b72e563ad80e020( level.players, "mp_jup_br_infil", 2 );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x5ad24fc4, Offset: 0x9304
// Size: 0x10
function infilcleanup()
{
    br_infils_util::function_3855f5796f4d2b65();
    br_infils_common::cleanupents();
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0x88f15884, Offset: 0x931c
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

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1, eflags: 0x4
// Checksum 0xfd0d5046, Offset: 0x9380
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

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1, eflags: 0x4
// Checksum 0x6b344851, Offset: 0x9461
// Size: 0xf1
function private leaderdialog( dialogref )
{
    if ( !getdvarint( @"hash_bfded00ac93c45b7", 1 ) )
    {
        return;
    }
    
    soundlength = 2;
    
    if ( soundexists( dialogref ) )
    {
        soundlength = lookupsoundlength( dialogref, 1 ) / 1000;
    }
    
    soundname = game[ "dialog" ][ dialogref ];
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player queuedialogforplayer( #"queue1", soundname, dialogref, soundlength );
    }
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 1, eflags: 0x4
// Checksum 0x39ebfe28, Offset: 0x955a
// Size: 0x19
function private function_91ed8e384d4e1fa6( skinname )
{
    self function_ce21f4102d5d17f6( skinname, "iw9_avatar_scriptable_mp" );
}

// Namespace namespace_d9bbc36a8c8a35ca
// Params 0
// Checksum 0xb8b6a358, Offset: 0x957b
// Size: 0x18
function function_60ca5349741930ba()
{
    self setallstreamloaddist( getdvarint( @"hash_2f896ce49cf13d0c", 7500 ) );
}

