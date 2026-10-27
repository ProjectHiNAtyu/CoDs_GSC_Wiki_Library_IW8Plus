// scripts\mp\br\gametypes\br_infils_ac130.gsc  (hash_4f5c5729daf67114.gscc) (size: 49115 Bytes / 0xbfdb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2aeeda06 (720296454)
// size ...... 49115 (0xbfdb)
// includes .. 10  (offset: 0xadeb)
// strings ... 307 (offset: 0xae3b)
// dev strs .. 0   (offset: 0xbfdb)
// exports ... 66  (offset: 0x891b)
// cseg ...... 0x1fb1 + 0x696a (0x891b)
// imports ... 174 (offset: 0x936b)
// animtree1 . 0   (offset: 0xbfdb)
// animtree2 . 0   (offset: 0xbfdb)
#using scripts\common\anim;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_infils_common;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\music_and_dialog;

#namespace br_infils_ac130;

// Namespace br_infils_ac130
// Params 0
// Checksum 0x18ea36b8, Offset: 0x1fcf
// Size: 0x240
function init()
{
    assert( isdefined( level.infilstruct ) );
    
    /#
        setdevdvarifuninitialized( @"hash_ef579438c4248057", 3.75 );
        setdevdvarifuninitialized( @"hash_224074cc9cbd34e3", 1 );
        setdevdvarifuninitialized( @"hash_916619431dc89fba", 6 );
        setdevdvarifuninitialized( @"hash_419ab155ef9169a4", 3 );
        setdevdvarifuninitialized( @"hash_4ee80a43d1c50ca2", 1 );
        setdevdvarifuninitialized( @"hash_bfded00ac93c45b7", 1 );
        setdevdvarifuninitialized( @"hash_7f1da0c3501cbdf2", 1 );
        setdevdvarifuninitialized( @"hash_5fd54d13e95394d5", 0 );
    #/
    
    level.infilstruct.c130model = getdvarint( @"hash_2be93dd484220a45", 0 ) == 1 ? "shadow::veh9_mil_air_cargo_plane_exterior_infil" : "jup_black_wz::veh9_mil_air_cargo_plane_exterior_infil";
    level.infilstruct.var_f265685cdcfee833 = "veh9_mil_air_cargo_plane_interior_infil";
    level.infilstruct.var_9d24745d02be135e = "tag_body_animate";
    utility::delaythread( 0.05, &br_infils_util::function_1c0500c7cf8f9b7, "ac130" );
    level.infilstruct.var_cee5041ecb30a2c5 = &function_a8719d48afa1b495;
    level.infilstruct.var_3bead1a95b75d55d = &function_2295b0f632c0d19d;
    level.infilstruct.jumpfunc = &jumpfunc;
    level.infilstruct.var_9a4f6a9353c9055c = &function_9a4f6a9353c9055c;
    level.infilstruct.var_ea87d0ead0c54f1c = 1;
    level.infilstruct.var_dfeffb86c1dd09b6 = 1;
    level.infilstruct.c130soundalias = "veh_br_infil_c17_distant_lp";
    orbitcamassets = [ "cam_orbit_br_infil_ac130_player1", "cam_orbit_br_infil_ac130_player2", "cam_orbit_br_infil_ac130_player3", "cam_orbit_br_infil_ac130_player4", "cam_orbit_br_infil_ac130_player1" ];
    br_infils_util::set_orbit_cam_info( orbitcamassets );
    br_infils_util::function_8e44037c2a8b1713( "prematch", &prematchstartfunc );
    br_infils_util::function_8e44037c2a8b1713( "fadedown", &fadedownfunc );
    game[ "dialog" ][ "infil_ac130_5_seconds" ] = "dx_br_dmzc_infl_ldms_drop";
}

// Namespace br_infils_ac130
// Params 2
// Checksum 0x9d3f40f1, Offset: 0x2217
// Size: 0x5b
function function_add25eacfdc15047( animstruct, animationref )
{
    if ( isdefined( animstruct.staticc130 ) )
    {
        br_infils_util::add_pack_modelanim( animstruct.staticc130, animationref );
    }
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        br_infils_util::add_pack_modelanim( animstruct.movingc130, animationref );
    }
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0xf9b91681, Offset: 0x227a
// Size: 0x3a89
function function_a8719d48afa1b495( movingc130 )
{
    animstruct = spawnstruct();
    animstruct.origin = getdvarvector( @"br_infil_anim_pos", ( 0, 0, 0 ) );
    animstruct.angles = ( 0, 0, 0 );
    animstruct.var_2ce59fbb5988f86d = getdvarint( @"hash_4ee80a43d1c50ca2", 1 );
    animstruct.var_39f40041d77aaab4 = level.var_2d454f2d3f7b541a;
    animstruct.cleanupfunc = &function_fa70e3629f82e53b;
    animstruct.var_751e0e63f6c6f6ec = &function_1ad287fcb5253b3c;
    animstruct.movingc130 = movingc130;
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.movingc130.animname = "movingC130";
        animstruct.movingc130.innards.animname = "movingC130";
        animstruct.movingc130.animstruct = animstruct;
        animstruct.movingc130.dontteleport = 1;
    }
    
    if ( utility::issharedfuncdefined( #"hash_850494e962957876", #"getanimstruct" ) )
    {
        animstruct = [[ utility::getsharedfunc( #"hash_850494e962957876", #"getanimstruct" ) ]]( animstruct );
    }
    else
    {
        animstruct.staticc130 = getent( "infil_ac130_exterior", #targetname );
        
        if ( isdefined( animstruct.staticc130 ) )
        {
            animstruct.staticc130 show();
            animstruct.staticc130.animname = "c130";
            animstruct.staticc130.dontdelete = 1;
        }
        else
        {
            animstruct.staticc130 = animstruct br_infils_util::spawn_script_model( "jup_black_wz::veh9_mil_air_cargo_plane_exterior_infil", "c130" );
        }
        
        animstruct.staticc130.dontteleport = 1;
        animstruct.camerarunner = animstruct br_infils_util::spawn_script_model( "generic_prop_x30", "camera" );
        animstruct.camerarunner linkto( animstruct.staticc130, "tag_body_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.introplane = animstruct br_infils_util::spawn_script_model( "black::veh9_mil_air_cargo_plane", "introPlane" );
        animstruct.introplane linkto( animstruct.camerarunner, "j_prop_30" );
        animstruct.playertags = [];
        animstruct.playertags[ 0 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag1" );
        animstruct.playertags[ 1 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag2" );
        animstruct.playertags[ 2 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag3" );
        animstruct.playertags[ 3 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag4" );
        animstruct.playertags[ 4 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag5" );
        animstruct.playertags[ 0 ] linkto( animstruct.camerarunner, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playertags[ 1 ] linkto( animstruct.camerarunner, "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playertags[ 2 ] linkto( animstruct.camerarunner, "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playertags[ 3 ] linkto( animstruct.camerarunner, "j_prop_5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playertags[ 4 ] linkto( animstruct.camerarunner, "j_prop_15", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playermodels = [];
        animstruct.playermodels[ 0 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player1" );
        animstruct.playermodels[ 1 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player2" );
        animstruct.playermodels[ 2 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player3" );
        animstruct.playermodels[ 3 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player4" );
        animstruct.playermodels[ 4 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player5" );
        animstruct.playermodels[ 0 ] linkto( animstruct.playertags[ 0 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playermodels[ 1 ] linkto( animstruct.playertags[ 1 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playermodels[ 2 ] linkto( animstruct.playertags[ 2 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playermodels[ 3 ] linkto( animstruct.playertags[ 3 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playermodels[ 4 ] linkto( animstruct.playertags[ 4 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playermodels[ 0 ] function_91ed8e384d4e1fa6( br_infils_util::function_b331ca02076487e0() );
        animstruct.playermodels[ 1 ] function_91ed8e384d4e1fa6( br_infils_util::function_b331ca02076487e0() );
        animstruct.playermodels[ 2 ] function_91ed8e384d4e1fa6( br_infils_util::function_b331ca02076487e0() );
        animstruct.playermodels[ 3 ] function_91ed8e384d4e1fa6( br_infils_util::function_b331ca02076487e0() );
        animstruct.playermodels[ 4 ] function_91ed8e384d4e1fa6( br_infils_util::function_b331ca02076487e0() );
        animstruct.crates = [];
        animstruct.crates[ 0 ] = animstruct br_infils_util::spawn_script_model( "military_carepackage_01_br", "crate1" );
        animstruct.crates[ 0 ] linkto( animstruct.camerarunner, "j_prop_8", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.npcs = [];
        animstruct.npcs[ 0 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "npc1" );
        animstruct.npcs[ 1 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "npc2" );
        animstruct.npcs[ 2 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "npc3" );
        animstruct.npcs[ 3 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "npc4" );
        animstruct.npcs[ 4 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "npc5" );
        animstruct.npcs[ 5 ] = animstruct br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "npc6" );
        animstruct.npcs[ 0 ] linkto( animstruct.camerarunner, "j_prop_9", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.npcs[ 1 ] linkto( animstruct.camerarunner, "j_prop_10", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.npcs[ 2 ] linkto( animstruct.camerarunner, "j_prop_11", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.npcs[ 3 ] linkto( animstruct.camerarunner, "j_prop_12", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.npcs[ 4 ] linkto( animstruct.camerarunner, "j_prop_13", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.npcs[ 5 ] linkto( animstruct.camerarunner, "j_prop_14", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.npcs[ 0 ] function_91ed8e384d4e1fa6( br_infils_util::function_b331ca02076487e0() );
        animstruct.npcs[ 1 ] function_91ed8e384d4e1fa6( br_infils_util::function_b331ca02076487e0() );
        animstruct.npcs[ 2 ] function_91ed8e384d4e1fa6( br_infils_util::function_b331ca02076487e0() );
        animstruct.npcs[ 3 ] function_91ed8e384d4e1fa6( br_infils_util::function_b331ca02076487e0() );
        animstruct.npcs[ 4 ] function_91ed8e384d4e1fa6( br_infils_util::function_b331ca02076487e0() );
        animstruct.npcs[ 5 ] function_91ed8e384d4e1fa6( br_infils_util::function_b331ca02076487e0() );
        animstruct.packs = [];
        n = 0;
        solosfov = 10;
        quadsfov = 10;
        var_c9bf3815d396f3b3 = 0;
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene0.0" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ solosfov, quadsfov, var_c9bf3815d396f3b3 ], &function_288f43cd24f548ef );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_sh000" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.introplane, level.br_anim[ "wz_infil_cargoplane_sh000" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_drone_guy1_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_drone_guy1_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_infil_g_prop_sh000" ], "wz_infil_xcam_sh000_quads", &getxcamfunc );
        animstruct.packs[ n ].xcams = [ "wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads", "wz_infil_xcam_sh000_quads" ];
        
        if ( !isdefined( level.scr_notetrack[ "camera" ][ "any" ][ "infil_header_player1" ] ) )
        {
            animation::addnotetrack_customfunction( "camera", "infil_header_player1", &function_de040b2460ec48a0 );
            animation::addnotetrack_customfunction( "camera", "infil_header_player2", &function_d405a143a8af24c9 );
            animation::addnotetrack_customfunction( "camera", "infil_header_player3", &function_fa3221798d6d0286 );
            animation::addnotetrack_customfunction( "camera", "infil_header_player4", &function_1ce889b9f8da68b7 );
        }
        
        n++;
        solosfov = 35;
        quadsfov = 30;
        var_c9bf3815d396f3b3 = 0;
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene4" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ solosfov, quadsfov, var_c9bf3815d396f3b3 ], &function_c1eead15ea327dd3 );
        animstruct.packs[ n ] function_add25eacfdc15047( animstruct, level.br_anim[ "wz_infil_cargoplane_sh040" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_sh040" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh040" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh040" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh040" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh040" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh040" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh040" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh040" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh040" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh040" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh040" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.crates[ 0 ], level.br_anim[ "wz_infil_cargobox_sh040" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "wz_infil_drone_guy_npc1_sh040" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_infil_drone_guy_npc2_sh040" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_infil_drone_guy_npc3_sh040" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 3 ], level.br_anim[ "wz_infil_drone_guy_npc4_sh040" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 4 ], level.br_anim[ "wz_infil_drone_guy_npc5_sh040" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 5 ], level.br_anim[ "wz_infil_drone_guy_npc6_sh040" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_infil_g_prop_sh040" ], "wz_infil_xcam_sh040_quads", &getxcamfunc );
        animstruct.packs[ n ].xcams = [ "wz_infil_xcam_sh040_solos", "wz_infil_xcam_sh040_solos", "wz_infil_xcam_sh040_quads", "wz_infil_xcam_sh040_quads" ];
        n++;
        solosfov = 7.5;
        quadsfov = 40;
        var_c9bf3815d396f3b3 = 0;
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene5" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ solosfov, quadsfov, var_c9bf3815d396f3b3 ], &function_f0a6ea24eb7fd51a );
        animstruct.packs[ n ] function_add25eacfdc15047( animstruct, level.br_anim[ "wz_infil_cargoplane_sh050" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_sh050" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh050" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh050" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh050" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh050" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh050" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh050" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh050" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh050" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh050" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh050" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.crates[ 0 ], level.br_anim[ "wz_infil_cargobox_sh050" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "wz_infil_drone_guy_npc1_sh050" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_infil_drone_guy_npc2_sh050" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_infil_drone_guy_npc3_sh050" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 3 ], level.br_anim[ "wz_infil_drone_guy_npc4_sh050" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 4 ], level.br_anim[ "wz_infil_drone_guy_npc5_sh050" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 5 ], level.br_anim[ "wz_infil_drone_guy_npc6_sh050" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_infil_g_prop_sh050" ], "wz_infil_xcam_sh050_quads", &getxcamfunc );
        animstruct.packs[ n ].xcams = [ "wz_infil_xcam_sh050_solos", "wz_infil_xcam_sh050_solos", "wz_infil_xcam_sh050_quads", "wz_infil_xcam_sh050_quads" ];
        n++;
        solosfov = 30;
        quadsfov = 40;
        var_c9bf3815d396f3b3 = 0;
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene6" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ solosfov, quadsfov, var_c9bf3815d396f3b3 ], &function_b19cfd0d4f996179 );
        animstruct.packs[ n ] function_add25eacfdc15047( animstruct, level.br_anim[ "wz_infil_cargoplane_sh060" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_sh060" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh060" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh060" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh060" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh060" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh060" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh060" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh060" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh060" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh060" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh060" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.crates[ 0 ], level.br_anim[ "wz_infil_cargobox_sh060" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "wz_infil_drone_guy_npc1_sh060" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_infil_drone_guy_npc2_sh060" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_infil_drone_guy_npc3_sh060" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 3 ], level.br_anim[ "wz_infil_drone_guy_npc4_sh060" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 4 ], level.br_anim[ "wz_infil_drone_guy_npc5_sh060" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 5 ], level.br_anim[ "wz_infil_drone_guy_npc6_sh060" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_infil_g_prop_sh060" ], "wz_infil_xcam_sh060_quads", &getxcamfunc );
        animstruct.packs[ n ].xcams = [ "wz_infil_xcam_sh060_solos", "wz_infil_xcam_sh060_solos", "wz_infil_xcam_sh060_quads", "wz_infil_xcam_sh060_quads" ];
        n++;
        solosfov = 20;
        quadsfov = 50;
        var_c9bf3815d396f3b3 = 0;
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene7" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ solosfov, quadsfov, var_c9bf3815d396f3b3 ], &function_9618465a68239d40 );
        animstruct.packs[ n ] function_add25eacfdc15047( animstruct, level.br_anim[ "wz_infil_cargoplane_sh070" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_sh070" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh070" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh070" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh070" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh070" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh070" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh070" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh070" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh070" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh070" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh070" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.crates[ 0 ], level.br_anim[ "wz_infil_cargobox_sh070" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "wz_infil_drone_guy_npc1_sh070" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_infil_drone_guy_npc2_sh070" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_infil_drone_guy_npc3_sh070" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 3 ], level.br_anim[ "wz_infil_drone_guy_npc4_sh070" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 4 ], level.br_anim[ "wz_infil_drone_guy_npc5_sh070" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 5 ], level.br_anim[ "wz_infil_drone_guy_npc6_sh070" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_infil_g_prop_sh070" ], "wz_infil_xcam_sh070_quads", &getxcamfunc );
        animstruct.packs[ n ].xcams = [ "wz_infil_xcam_sh070_solos", "wz_infil_xcam_sh070_solos", "wz_infil_xcam_sh070_quads", "wz_infil_xcam_sh070_quads" ];
        n++;
        solosfov = 30;
        quadsfov = 50;
        var_c9bf3815d396f3b3 = 0;
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene8" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ solosfov, quadsfov, var_c9bf3815d396f3b3 ], &function_3df7bbac60cef2b7 );
        animstruct.packs[ n ] function_add25eacfdc15047( animstruct, level.br_anim[ "wz_infil_cargoplane_sh080" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_sh080" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh080" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh080" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh080" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh080" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh080" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh080" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh080" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh080" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh080" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh080" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.crates[ 0 ], level.br_anim[ "wz_infil_cargobox_sh080" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "wz_infil_drone_guy_npc1_sh080" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_infil_drone_guy_npc2_sh080" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_infil_drone_guy_npc3_sh080" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 3 ], level.br_anim[ "wz_infil_drone_guy_npc4_sh080" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 4 ], level.br_anim[ "wz_infil_drone_guy_npc5_sh080" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 5 ], level.br_anim[ "wz_infil_drone_guy_npc6_sh080" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_infil_g_prop_sh080" ], "wz_infil_xcam_sh080_quads", &getxcamfunc );
        animstruct.packs[ n ].xcams = [ "wz_infil_xcam_sh080_solos", "wz_infil_xcam_sh080_solos", "wz_infil_xcam_sh080_quads", "wz_infil_xcam_sh080_quads" ];
        n++;
        solosfov = 25;
        quadsfov = 31.78;
        var_c9bf3815d396f3b3 = 1;
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene9" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ solosfov, quadsfov, var_c9bf3815d396f3b3 ], &function_518f68995d16f5e );
        animstruct.packs[ n ] function_add25eacfdc15047( animstruct, level.br_anim[ "wz_infil_cargoplane_sh090" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_sh090" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh090" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh090" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh090" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh090" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh090" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh090" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh090" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh090" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh090" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh090" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.crates[ 0 ], level.br_anim[ "wz_infil_cargobox_sh090" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "wz_infil_drone_guy_npc1_sh090" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_infil_drone_guy_npc2_sh090" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_infil_drone_guy_npc3_sh090" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 3 ], level.br_anim[ "wz_infil_drone_guy_npc4_sh090" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 4 ], level.br_anim[ "wz_infil_drone_guy_npc5_sh090" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 5 ], level.br_anim[ "wz_infil_drone_guy_npc6_sh090" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_infil_g_prop_sh090" ], "wz_infil_xcam_sh090_quads", &getxcamfunc );
        animstruct.packs[ n ].xcams = [ "wz_infil_xcam_sh090_solos", "wz_infil_xcam_sh090_quads", "wz_infil_xcam_sh090_solos", "wz_infil_xcam_sh090_quads" ];
        n++;
        solosfov = 20;
        quadsfov = 17.847;
        var_c9bf3815d396f3b3 = 1;
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene10" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ solosfov, quadsfov, var_c9bf3815d396f3b3 ], &function_103a86bb8976fef0 );
        animstruct.packs[ n ] function_add25eacfdc15047( animstruct, level.br_anim[ "wz_infil_cargoplane_sh100" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_sh100" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh100" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh100" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh100" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh100" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh100" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh100" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh100" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh100" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh100" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_solowin_guy1_sh100" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.crates[ 0 ], level.br_anim[ "wz_infil_cargobox_sh100" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "wz_infil_drone_guy_npc1_sh100" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_infil_drone_guy_npc2_sh100" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_infil_drone_guy_npc3_sh100" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 3 ], level.br_anim[ "wz_infil_drone_guy_npc4_sh100" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 4 ], level.br_anim[ "wz_infil_drone_guy_npc5_sh100" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 5 ], level.br_anim[ "wz_infil_drone_guy_npc6_sh100" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_infil_g_prop_sh100" ], "wz_infil_xcam_sh100_quads", &getxcamfunc );
        animstruct.packs[ n ].xcams = [ "wz_infil_xcam_sh100_solos", "wz_infil_xcam_sh100_quads", "wz_infil_xcam_sh100_solos", "wz_infil_xcam_sh100_quads" ];
        n++;
        solosfov = 40;
        quadsfov = 40;
        var_c9bf3815d396f3b3 = 0;
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene11" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ solosfov, quadsfov, var_c9bf3815d396f3b3 ], &function_f545de7a661a0629 );
        animstruct.packs[ n ] function_add25eacfdc15047( animstruct, level.br_anim[ "wz_infil_cargoplane_sh110" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_sh110" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh110" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh110" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh110" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh110" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_drone_guy1_sh110" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh110" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh110" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh110" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh110" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_drone_guy1_sh110" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.crates[ 0 ], level.br_anim[ "wz_infil_cargobox_sh110" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "wz_infil_drone_guy_npc1_sh110" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_infil_drone_guy_npc2_sh110" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_infil_drone_guy_npc3_sh110" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 3 ], level.br_anim[ "wz_infil_drone_guy_npc4_sh110" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 4 ], level.br_anim[ "wz_infil_drone_guy_npc5_sh110" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 5 ], level.br_anim[ "wz_infil_drone_guy_npc6_sh110" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_infil_g_prop_sh110" ], "wz_infil_xcam_sh110_quads", &getxcamfunc );
        animstruct.packs[ n ].xcams = [ "wz_infil_xcam_sh110_quads", "wz_infil_xcam_sh110_quads", "wz_infil_xcam_sh110_quads", "wz_infil_xcam_sh110_quads" ];
        n++;
        solosfov = 45;
        quadsfov = 45;
        var_c9bf3815d396f3b3 = 0;
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene12" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ solosfov, quadsfov, var_c9bf3815d396f3b3 ], &function_923c2e743e753c4a );
        animstruct.packs[ n ] function_add25eacfdc15047( animstruct, level.br_anim[ "wz_infil_cargoplane_sh120" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_sh120" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh120" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh120" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh120" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh120" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_drone_guy1_sh120" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_sh120" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_sh120" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_sh120" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_sh120" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_drone_guy1_sh120" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.crates[ 0 ], level.br_anim[ "wz_infil_cargobox_sh120" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "wz_infil_drone_guy_npc1_sh120" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_infil_drone_guy_npc2_sh120" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_infil_drone_guy_npc3_sh120" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 3 ], level.br_anim[ "wz_infil_drone_guy_npc4_sh120" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 4 ], level.br_anim[ "wz_infil_drone_guy_npc5_sh120" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 5 ], level.br_anim[ "wz_infil_drone_guy_npc6_sh120" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, "tag_origin", level.br_anim[ "wz_infil_g_prop_sh120" ], "wz_infil_xcam_sh120_quads", &getxcamfunc );
        animstruct.packs[ n ].xcams = [ "wz_infil_xcam_sh120_quads", "wz_infil_xcam_sh120_quads", "wz_infil_xcam_sh120_quads", "wz_infil_xcam_sh120_quads" ];
        solosfov = 45;
        quadsfov = 45;
        var_c9bf3815d396f3b3 = 0;
        n++;
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "looping", 1 );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [ solosfov, quadsfov, var_c9bf3815d396f3b3 ], &function_d08f2d7f11cd8058 );
        animstruct.packs[ n ] br_infils_util::function_9597cbd14a6857e3( [], &function_e5ebb228460bf05 );
        animstruct.packs[ n ] function_add25eacfdc15047( animstruct, level.br_anim[ "wz_infil_cargoplane_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.camerarunner, level.br_anim[ "wz_infil_g_prop_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_drone_guy1_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_drone_guy2_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_drone_guy3_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_drone_guy4_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_drone_guy1_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_drone_guy1_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_drone_guy2_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_drone_guy3_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_drone_guy4_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_drone_guy1_idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 0 ], level.br_anim[ "wz_infil_drone_guy_npc1idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 1 ], level.br_anim[ "wz_infil_drone_guy_npc2idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 2 ], level.br_anim[ "wz_infil_drone_guy_npc3idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 3 ], level.br_anim[ "wz_infil_drone_guy_npc4idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 4 ], level.br_anim[ "wz_infil_drone_guy_npc5idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.npcs[ 5 ], level.br_anim[ "wz_infil_drone_guy_npc6idle_sh010" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.camerarunner, &function_fd52e7e7e4cc7afd );
    }
    
    return animstruct;
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x6b17e14b, Offset: 0x5d0c
// Size: 0xd8
function function_b0d92cfa8cc72e75( players )
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

// Namespace br_infils_ac130
// Params 1
// Checksum 0x7e1513a7, Offset: 0x5ded
// Size: 0x63b
function function_2382a170e8bf0851( array )
{
    var_c45898e443d6fd9f = 0;
    solosfov = undefined;
    quadsfov = undefined;
    var_c9bf3815d396f3b3 = 0;
    
    if ( array.size >= 2 && isnumber( array[ 0 ] ) && isnumber( array[ 1 ] ) )
    {
        var_c45898e443d6fd9f = 1;
        solosfov = array[ 0 ];
        quadsfov = array[ 1 ];
    }
    
    if ( array.size >= 3 )
    {
        var_c9bf3815d396f3b3 = array[ 2 ];
    }
    
    pack = self.activepack;
    assert( isdefined( pack ) );
    pack.var_c9bf3815d396f3b3 = var_c9bf3815d396f3b3;
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
        
        if ( isdefined( level.var_3d331ab8ba673cfb ) )
        {
            possibleindices = [[ level.var_3d331ab8ba673cfb ]]( numplayers, var_c9bf3815d396f3b3 );
        }
        else if ( numplayers == 1 )
        {
            possibleindices = [ 5 ];
        }
        else if ( numplayers == 2 )
        {
            if ( var_c9bf3815d396f3b3 )
            {
                possibleindices = [ 1, 4 ];
            }
            else
            {
                possibleindices = [ 5, 4 ];
            }
        }
        else if ( var_c9bf3815d396f3b3 && numplayers == 3 )
        {
            possibleindices = [ 5, 2, 3, 4 ];
        }
        
        playercount = 0;
        
        foreach ( player in players )
        {
            player.infilanimindex = possibleindices[ playercount % possibleindices.size ];
            player.var_edbda953d7469bd7 = numplayers;
            playercount++;
        }
        
        if ( var_c45898e443d6fd9f )
        {
            chosenfov = quadsfov;
            
            if ( var_c9bf3815d396f3b3 && numplayers == 2 )
            {
                chosenfov = quadsfov;
            }
            else if ( var_c9bf3815d396f3b3 && numplayers == 3 )
            {
                chosenfov = solosfov;
            }
            else if ( numplayers < 3 )
            {
                chosenfov = solosfov;
            }
            
            foreach ( player in players )
            {
                player setclientdvar( @"cg_fov", chosenfov );
                player setclientdvar( @"cg_disable_user_fov", 1 );
            }
        }
    }
    
    if ( var_3a238e44047ac624 )
    {
        pack.var_30043414aa6e135f = 1;
        pack.var_ebbf2026208f047d = function_5713d46873b29625( pack.var_ebbf2026208f047d );
        
        if ( pack.var_ebbf2026208f047d.size >= 5 )
        {
            foreach ( proxy in pack.var_ebbf2026208f047d )
            {
                proxy hide();
            }
            
            if ( var_9403e3d4f0d932b8 == 1 )
            {
                pack.var_ebbf2026208f047d[ 4 ] show();
            }
            else if ( var_9403e3d4f0d932b8 == 2 )
            {
                if ( var_c9bf3815d396f3b3 )
                {
                    pack.var_ebbf2026208f047d[ 0 ] show();
                    pack.var_ebbf2026208f047d[ 3 ] show();
                }
                else
                {
                    pack.var_ebbf2026208f047d[ 4 ] show();
                    pack.var_ebbf2026208f047d[ 3 ] show();
                }
            }
            else if ( var_9403e3d4f0d932b8 == 3 )
            {
                if ( var_c9bf3815d396f3b3 )
                {
                    pack.var_ebbf2026208f047d[ 4 ] show();
                    pack.var_ebbf2026208f047d[ 1 ] show();
                    pack.var_ebbf2026208f047d[ 2 ] show();
                }
                else
                {
                    pack.var_ebbf2026208f047d[ 0 ] show();
                    pack.var_ebbf2026208f047d[ 1 ] show();
                    pack.var_ebbf2026208f047d[ 2 ] show();
                }
            }
            else
            {
                pack.var_ebbf2026208f047d[ 0 ] show();
                pack.var_ebbf2026208f047d[ 1 ] show();
                pack.var_ebbf2026208f047d[ 2 ] show();
                pack.var_ebbf2026208f047d[ 3 ] show();
            }
            
            return;
        }
        
        if ( pack.var_ebbf2026208f047d.size >= 4 )
        {
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
}

// Namespace br_infils_ac130
// Params 1, eflags: 0x4
// Checksum 0xbe355c38, Offset: 0x6430
// Size: 0x44
function private foreach_c130( callbackfunc )
{
    if ( isdefined( self.staticc130 ) )
    {
        self [[ callbackfunc ]]( self.staticc130 );
    }
    
    if ( isdefined( self.movingc130 ) )
    {
        self [[ callbackfunc ]]( self.movingc130 );
    }
}

// Namespace br_infils_ac130
// Params 1, eflags: 0x4
// Checksum 0xf8a7483a, Offset: 0x647c
// Size: 0x32
function private function_de2ff70d72fd961b( c130 )
{
    c130 show();
    
    if ( isdefined( c130.innards ) )
    {
        c130.innards show();
    }
}

// Namespace br_infils_ac130
// Params 1, eflags: 0x4
// Checksum 0xe8d4732c, Offset: 0x64b6
// Size: 0x1d
function private function_dcf064960f516547( c130 )
{
    c130 setscriptablepartstate( "running_lights", "on" );
}

// Namespace br_infils_ac130
// Params 2
// Checksum 0x2e9cf2b0, Offset: 0x64db
// Size: 0x101
function function_c56ce3e744d2188b( teams, soundsarray )
{
    assert( isarray( teams ) );
    assert( isarray( soundsarray ) );
    
    foreach ( players in teams )
    {
        assert( soundsarray.size >= players.size );
        sounds = soundsarray[ players.size - 1 ];
        
        for ( i = 0; i < players.size ; i++ )
        {
            alias = sounds[ i ];
            
            if ( isstring( alias ) && alias != "" )
            {
                audio_utility::function_63bf1584c79c055( players, alias );
            }
        }
    }
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0xb61d3f02, Offset: 0x65e4
// Size: 0x59
function function_5c895d434d0940d1()
{
    var_2cc2914e6fc95a6e = level.var_faebd0b51ab8818e ?? "mp_saba_infil_exterior";
    self visionsetnakedforplayer( var_2cc2914e6fc95a6e, 0 );
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    
    if ( var_2754701952ea4d67 )
    {
        self function_a565dafac620d68e( %"hash_16737cfa86d4521" );
    }
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0xf8273502, Offset: 0x6645
// Size: 0x2c1
function function_288f43cd24f548ef( array )
{
    function_2382a170e8bf0851( array );
    foreach_c130( &function_de2ff70d72fd961b );
    self.introplane setscriptablepartstate( "running_lights", "on" );
    foreach_c130( &function_dcf064960f516547 );
    var_a12b1981f44b4976 = getdvarint( @"hash_5fd54d13e95394d5", 0 );
    
    if ( var_a12b1981f44b4976 )
    {
        setsundirection( anglestoforward( ( -37, 40, 0 ) ) );
        setsuncolorandintensity( 0.9294, 0.9608, 1, 0.2 );
    }
    
    audio_utility::function_63bf1584c79c055( level.infilstruct.players, "scn_br_c17_infil_ext" );
    thread delaystreamtomovingplane();
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    usestreaming = getdvarint( @"hash_6eff23c71a0d4b51", 1 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setshowcontrail( 0 );
        player setisinfilskydive( 0 );
        var_2cc2914e6fc95a6e = level.var_faebd0b51ab8818e ?? "mp_saba_infil_exterior";
        
        if ( isdefined( level.delta_alt ) )
        {
            setsuncolorandintensity( 0.07 );
            setsundirection( anglestoforward( ( -59, -96, 0 ) ) );
        }
        
        player visionsetnakedforplayer( var_2cc2914e6fc95a6e, 0 );
        
        if ( var_2754701952ea4d67 )
        {
            player function_a565dafac620d68e( %"hash_16737cfa86d4521" );
        }
        
        if ( usestreaming )
        {
            player clearpredictedstreampos();
        }
        
        player setentitysoundcontext( "lobby_fade", "", 2 );
        player clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
        player setsoundsubmix( "solo_cin_igc_music_br_hack", 0.5 );
        musicbank_utility::function_4f253fd35ec68cbc( player );
        musicbank_utility::function_5aca66c390aa347d( player, #"br_infil" );
    }
    
    function_865f0376fd2522a0();
    function_895b45db66a5b048();
    fadestarttime = utility::get_notetrack_time( level.br_anim[ "wz_infil_g_prop_sh000" ], "fade_to_black_start" );
    fadestarttime -= fadestarttime % 0.05;
    fadedowntime = 0.1;
    utility::delaythread( fadestarttime, &br_infils_util::function_c050cae6f9bcb77f, fadedowntime, level.infilstruct.players, "sh000" );
    br_infils_util::function_fffda20dc2c2df07( &function_5c895d434d0940d1 );
}

// Namespace br_infils_ac130
// Params 1, eflags: 0x4
// Checksum 0xe27e97e9, Offset: 0x690e
// Size: 0x6c
function private function_c45fd843bc4c0eea( c130 )
{
    c130 show();
    
    if ( isdefined( c130.innards ) )
    {
        c130.innards show();
    }
    
    c130 setscriptablepartstate( "running_lights", "off" );
    var_a12b1981f44b4976 = getdvarint( @"hash_5fd54d13e95394d5", 0 );
    
    if ( var_a12b1981f44b4976 )
    {
        resetsundirection();
        resetsunlight();
    }
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x3b891fdd, Offset: 0x6982
// Size: 0xf1
function leaderdialog( dialogref )
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

// Namespace br_infils_ac130
// Params 0
// Checksum 0xfa67bc6a, Offset: 0x6a7b
// Size: 0x74
function function_a0442266c4808c88()
{
    self playlocalsound( "scn_br_c17_infil_int" );
    infilvisionset = level.var_ee0d6402032a1984 ?? "mp_saba_infil";
    self visionsetnakedforplayer( infilvisionset, 0 );
    self setclienttriggeraudiozone( "br_c17_infil_int", 0 );
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    
    if ( var_2754701952ea4d67 )
    {
        self function_a565dafac620d68e( %"hash_1fae1fa57c3e3922" );
    }
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x2ab87e3d, Offset: 0x6af7
// Size: 0x246
function function_d12cc6a14b105c35()
{
    self.introplane hide();
    foreach_c130( &function_c45fd843bc4c0eea );
    sound = level.var_8f2e4f150190594b ?? "scn_br_c17_infil_int";
    audio_utility::function_63bf1584c79c055( level.infilstruct.players, sound );
    teams = function_b0d92cfa8cc72e75( level.infilstruct.players );
    sounds = [];
    
    if ( isdefined( level.var_552a4642eef096d2[ "04" ] ) )
    {
        sounds = level.var_552a4642eef096d2[ "04" ];
    }
    else
    {
        sounds[ 0 ] = [ "scn_br_c17_infil_solos_plr1_shot04" ];
        sounds[ 1 ] = [ "scn_br_c17_infil_duos_plr1_shot04", "" ];
        sounds[ 2 ] = [ "scn_br_c17_infil_trios_plr1_shot04", "scn_br_c17_infil_trios_plr2_shot04", "scn_br_c17_infil_trios_plr3_shot04" ];
        sounds[ 3 ] = [ "scn_br_c17_infil_quads_plr1_shot04", "scn_br_c17_infil_quads_plr2_shot04", "scn_br_c17_infil_quads_plr3_shot04", "" ];
    }
    
    function_c56ce3e744d2188b( teams, sounds );
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        infilvisionset = level.var_ee0d6402032a1984 ?? "mp_saba_infil";
        
        if ( isdefined( level.delta_alt ) )
        {
            resetsunlight();
            resetsundirection();
        }
        
        player visionsetnakedforplayer( infilvisionset, 0 );
        player setclienttriggeraudiozone( "br_c17_infil_int", 0 );
        
        if ( var_2754701952ea4d67 )
        {
            player function_a565dafac620d68e( %"hash_1fae1fa57c3e3922" );
        }
    }
    
    function_c06078e58c9d2964();
    function_88dfbe7ebe3c1354();
    thread function_6dfeac0c11b159d7();
    br_infils_util::function_fffda20dc2c2df07( &function_a0442266c4808c88 );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x4e8acf2b, Offset: 0x6d45
// Size: 0x8c
function function_c1eead15ea327dd3( array )
{
    function_2382a170e8bf0851( array );
    function_d12cc6a14b105c35();
    fadeendtime = utility::get_notetrack_time( level.br_anim[ "wz_infil_g_prop_sh040" ], "fade_to_black_end" );
    fadeendtime += 0.05 - fadeendtime % 0.05;
    fadeuptime = 0.65;
    utility::delaythread( fadeendtime, &br_infils_util::function_573cdd2bc439ec67, fadeuptime, level.infilstruct.players, "sh000" );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0xb547747b, Offset: 0x6dd9
// Size: 0x15
function function_f0a6ea24eb7fd51a( array )
{
    function_2382a170e8bf0851( array );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0xc2d9a68b, Offset: 0x6df6
// Size: 0x15
function function_b19cfd0d4f996179( array )
{
    function_2382a170e8bf0851( array );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x597ceae4, Offset: 0x6e13
// Size: 0x15
function function_9618465a68239d40( array )
{
    function_2382a170e8bf0851( array );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0xc00e5a3, Offset: 0x6e30
// Size: 0xe7
function function_3df7bbac60cef2b7( array )
{
    function_2382a170e8bf0851( array );
    teams = function_b0d92cfa8cc72e75( level.infilstruct.players );
    sounds = [];
    
    if ( isdefined( level.var_552a4642eef096d2[ "08" ] ) )
    {
        sounds = level.var_552a4642eef096d2[ "08" ];
    }
    else
    {
        sounds[ 0 ] = [ "scn_br_c17_infil_solos_plr1_shot08" ];
        sounds[ 1 ] = [ "scn_br_c17_infil_duos_plr1_shot08", "scn_br_c17_infil_duos_plr2_shot08" ];
        sounds[ 2 ] = [ "scn_br_c17_infil_trios_plr1_shot08", "scn_br_c17_infil_trios_plr2_shot08", "scn_br_c17_infil_trios_plr3_shot08" ];
        sounds[ 3 ] = [ "scn_br_c17_infil_quads_plr1_shot08", "scn_br_c17_infil_quads_plr2_shot08", "scn_br_c17_infil_quads_plr3_shot08", "scn_br_c17_infil_quads_plr4_shot08" ];
    }
    
    function_c56ce3e744d2188b( teams, sounds );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0xb04d39fa, Offset: 0x6f1f
// Size: 0x15
function function_518f68995d16f5e( array )
{
    function_2382a170e8bf0851( array );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x524b8056, Offset: 0x6f3c
// Size: 0x12
function function_cd94c4e80cbd3510()
{
    self setclienttriggeraudiozone( "br_c17_infil_ext", 3 );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x866ba1c1, Offset: 0x6f56
// Size: 0xb6
function function_103a86bb8976fef0( array )
{
    function_2382a170e8bf0851( array );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclienttriggeraudiozone( "br_c17_infil_ext", 3 );
    }
    
    br_infils_util::function_fffda20dc2c2df07( &function_cd94c4e80cbd3510 );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x42689588, Offset: 0x7014
// Size: 0xf8
function function_f545de7a661a0629( array )
{
    function_2382a170e8bf0851( array );
    teams = function_b0d92cfa8cc72e75( level.infilstruct.players );
    sounds = [];
    
    if ( isdefined( level.var_552a4642eef096d2[ "11" ] ) )
    {
        sounds = level.var_552a4642eef096d2[ "11" ];
    }
    else
    {
        sounds[ 0 ] = [ "scn_br_c17_infil_solos_plr1_shot11" ];
        sounds[ 1 ] = [ "scn_br_c17_infil_duos_plr1_shot11", "scn_br_c17_infil_duos_plr2_shot11" ];
        sounds[ 2 ] = [ "scn_br_c17_infil_trios_plr1_shot11", "scn_br_c17_infil_trios_plr2_shot11", "scn_br_c17_infil_trios_plr3_shot11" ];
        sounds[ 3 ] = [ "scn_br_c17_infil_quads_plr1_shot11", "scn_br_c17_infil_quads_plr2_shot11", "scn_br_c17_infil_quads_plr3_shot11", "scn_br_c17_infil_quads_plr4_shot11" ];
    }
    
    function_c56ce3e744d2188b( teams, sounds );
    utility::delaythread( 0.5, &function_9da341f9c3f45568 );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0xc2a10f9a, Offset: 0x7114
// Size: 0x5a
function function_5531f4161ba26c67()
{
    transitionseconds = getdvarfloat( @"hash_224074cc9cbd34e3", 1 );
    self visionsetnakedforplayer( "", transitionseconds );
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    
    if ( var_2754701952ea4d67 )
    {
        self function_72cf2eee8e035013( %"hash_1fae1fa57c3e3922" );
    }
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x12681535, Offset: 0x7176
// Size: 0x125
function function_e85d2e66e44fe387()
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
            player function_72cf2eee8e035013( %"hash_1fae1fa57c3e3922" );
        }
    }
    
    utility::delaythread( 1, &function_d35b87f9f4a332d6 );
    br_infils_util::function_fffda20dc2c2df07( &function_5531f4161ba26c67 );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x9c007ea4, Offset: 0x72a3
// Size: 0x28
function function_8fad488f8dcae12a()
{
    wait 3;
    audio_utility::function_5b885ff87a1180d4( level.players, "solo_cin_igc_music_br_hack", 3 );
    wait 3;
}

// Namespace br_infils_ac130
// Params 0, eflags: 0x4
// Checksum 0x8072ddfa, Offset: 0x72d3
// Size: 0xbb
function private function_37c17c4ea61d3b2e()
{
    fadestarttime = utility::get_notetrack_time( level.br_anim[ "wz_infil_g_prop_sh120" ], "fade_to_black_start" );
    fadeendtime = utility::get_notetrack_time( level.br_anim[ "wz_infil_g_prop_sh120" ], "fade_to_black_end" );
    fadestarttime -= fadestarttime % 0.05;
    fadeendtime += 0.05 - fadeendtime % 0.05;
    wait fadestarttime;
    br_infils_util::function_c050cae6f9bcb77f( 0.066, level.infilstruct.players, "sh120" );
    wait fadeendtime - fadestarttime;
    br_infils_util::function_573cdd2bc439ec67( 0.083, level.infilstruct.players, "sh120" );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x5f08abd3, Offset: 0x7396
// Size: 0x92
function function_923c2e743e753c4a( array )
{
    function_2382a170e8bf0851( array );
    level thread function_8fad488f8dcae12a();
    level thread function_e85d2e66e44fe387();
    delayseconds = getdvarfloat( @"hash_1968fc42f31e7d28", 3.9 );
    
    if ( delayseconds > 0 )
    {
        utility::delaythread( delayseconds, &teleporttomovingplane );
    }
    else
    {
        teleporttomovingplane();
    }
    
    level thread function_37c17c4ea61d3b2e();
    self.movingc130 setscriptablepartstate( "running_lights", "on" );
    leaderdialog( "infil_ac130_5_seconds" );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0xb6169bc2, Offset: 0x7430
// Size: 0xf5
function function_9da341f9c3f45568()
{
    light_switches = getentitylessscriptablearray( "air_cargo_light_switch", #targetname );
    
    foreach ( ls in light_switches )
    {
        ls setscriptablepartstate( "base", "on_green" );
    }
    
    lightstate = level.var_50e5d9f8a3ed3681 ?? "on";
    self.staticc130 setscriptablepartstate( "int_lights_red_all", "off" );
    self.staticc130 setscriptablepartstate( "int_lights_green_all", lightstate );
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_c17_infil_jump_buzzer" );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x1137627e, Offset: 0x752d
// Size: 0x1a
function function_8480689471b795a0()
{
    self.movingc130 setscriptablepartstate( "int_lights_green_all", "on" );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0xecd6f8f3, Offset: 0x754f
// Size: 0xe0
function function_c06078e58c9d2964()
{
    light_switches = getentitylessscriptablearray( "air_cargo_light_switch", #targetname );
    
    foreach ( ls in light_switches )
    {
        ls setscriptablepartstate( "base", "on_red" );
    }
    
    lightstate = level.var_50e5d9f8a3ed3681 ?? "on";
    self.staticc130 setscriptablepartstate( "int_lights_red_all", lightstate );
    self.staticc130 setscriptablepartstate( "int_lights_green_all", "off" );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x7bee7831, Offset: 0x7637
// Size: 0x1a
function function_88dfbe7ebe3c1354()
{
    self.movingc130 setscriptablepartstate( "int_lights_green_all", "off" );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x7201dc2d, Offset: 0x7659
// Size: 0xc8
function function_865f0376fd2522a0()
{
    light_switches = getentitylessscriptablearray( "air_cargo_light_switch", #targetname );
    
    foreach ( ls in light_switches )
    {
        ls setscriptablepartstate( "base", "off" );
    }
    
    self.staticc130 setscriptablepartstate( "int_lights_red_all", "off" );
    self.staticc130 setscriptablepartstate( "int_lights_green_all", "off" );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0xb50cc89b, Offset: 0x7729
// Size: 0x1a
function function_895b45db66a5b048()
{
    self.movingc130 setscriptablepartstate( "int_lights_green_all", "off" );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0xbf396e4, Offset: 0x774b
// Size: 0x2
function function_d35b87f9f4a332d6()
{
    
}

// Namespace br_infils_ac130
// Params 1, eflags: 0x4
// Checksum 0x62df9647, Offset: 0x7755
// Size: 0xc
function private c130_looping( c130 )
{
    
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0xa1037182, Offset: 0x7769
// Size: 0x1c
function function_d08f2d7f11cd8058( array )
{
    function_2382a170e8bf0851( array );
    function_d35b87f9f4a332d6();
}

// Namespace br_infils_ac130
// Params 2
// Checksum 0xf871bf3a, Offset: 0x778d
// Size: 0x15
function function_e5ebb228460bf05( player, array )
{
    
}

// Namespace br_infils_ac130
// Params 2
// Checksum 0xc9a5a735, Offset: 0x77aa
// Size: 0xab
function function_85721aae76a5675a( players, index )
{
    foreach ( player in players )
    {
        if ( isdefined( player.infilanimindex ) && ( player.infilanimindex - 1 ) % 5 + 1 == index )
        {
            return player;
        }
    }
}

// Namespace br_infils_ac130
// Params 2, eflags: 0x4
// Checksum 0x1bffb5f4, Offset: 0x785e
// Size: 0x269
function private function_490c8bf86f4d9bb0( index, var_aaf9d419d317e0c1 )
{
    teams = [];
    
    foreach ( player in level.infilstruct.players )
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
    
    foreach ( players in teams )
    {
        numplayers = players.size;
        foundplayer = undefined;
        
        if ( index == 0 )
        {
            foundplayer = function_85721aae76a5675a( players, 1 );
            
            if ( !isdefined( foundplayer ) )
            {
                foundplayer = function_85721aae76a5675a( players, 5 );
            }
        }
        else if ( index == 1 )
        {
            if ( numplayers == 2 )
            {
                foundplayer = undefined;
            }
            else
            {
                foundplayer = function_85721aae76a5675a( players, 2 );
            }
        }
        else if ( index == 2 )
        {
            foundplayer = function_85721aae76a5675a( players, 3 );
        }
        else
        {
            assert( index == 3 );
            foundplayer = function_85721aae76a5675a( players, 4 );
        }
        
        omnvarvalue = -1;
        
        if ( isdefined( foundplayer ) )
        {
            omnvarvalue = foundplayer getentitynumber();
        }
        
        if ( var_aaf9d419d317e0c1 )
        {
            foreach ( player in players )
            {
                player setclientomnvar( "ui_br_infil_exfil_player_focus", omnvarvalue );
            }
        }
    }
}

// Namespace br_infils_ac130
// Params 0, eflags: 0x4
// Checksum 0x56e67ee5, Offset: 0x7acf
// Size: 0x65
function private prematchstartfunc()
{
    level.nosuspensemusic = 1;
    thread music_and_dialog::stopsuspensemusic();
    soundbank = "mp_gamemode_br_infils";
    
    if ( utility::issharedfuncdefined( #"hash_850494e962957876", #"hash_cb5306fe92b5067c" ) )
    {
        soundbank = [[ utility::getsharedfunc( #"hash_850494e962957876", #"hash_cb5306fe92b5067c" ) ]]();
    }
    
    audio_utility::snd_transient_load( soundbank );
}

// Namespace br_infils_ac130
// Params 0, eflags: 0x4
// Checksum 0x7d24949f, Offset: 0x7b3c
// Size: 0xf4
function private function_25b64156970ffa5()
{
    if ( getdvarint( @"hash_6eff23c71a0d4b51", 1 ) )
    {
        level.infilstruct.var_cfd89587fdc657ad = 1;
        waitframe();
        streamorigin = level.infilstruct.c130.animstruct.introplane.origin;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setpredictedstreamloaddist( -1 );
            player predictstreamposuntilcleared( streamorigin );
        }
    }
}

// Namespace br_infils_ac130
// Params 0, eflags: 0x4
// Checksum 0x14112e35, Offset: 0x7c38
// Size: 0x24
function private function_818e211bb54ccc2a()
{
    level thread function_25b64156970ffa5();
    audio_utility::function_7b72e563ad80e020( level.players, "default", 2.5 );
}

// Namespace br_infils_ac130
// Params 0, eflags: 0x4
// Checksum 0x27c29b83, Offset: 0x7c64
// Size: 0xa
function private fadedownfunc()
{
    level thread function_818e211bb54ccc2a();
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x3b5f5590, Offset: 0x7c76
// Size: 0x16
function function_de040b2460ec48a0( camera )
{
    function_490c8bf86f4d9bb0( 0, 1 );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x7cff2f40, Offset: 0x7c94
// Size: 0x16
function function_d405a143a8af24c9( camera )
{
    function_490c8bf86f4d9bb0( 1, 0 );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x419f06f3, Offset: 0x7cb2
// Size: 0x16
function function_fa3221798d6d0286( camera )
{
    function_490c8bf86f4d9bb0( 2, 0 );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0xf3bfdae2, Offset: 0x7cd0
// Size: 0x16
function function_1ce889b9f8da68b7( camera )
{
    function_490c8bf86f4d9bb0( 3, 0 );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x11cc9152, Offset: 0x7cee
// Size: 0x61
function function_fa70e3629f82e53b()
{
    soundbank = "mp_gamemode_br_infils";
    
    if ( utility::issharedfuncdefined( #"hash_850494e962957876", #"hash_cb5306fe92b5067c" ) )
    {
        soundbank = [[ utility::getsharedfunc( #"hash_850494e962957876", #"hash_cb5306fe92b5067c" ) ]]();
    }
    
    br_infils_util::function_3855f5796f4d2b65();
    audio_utility::snd_transient_unload( soundbank );
    br_infils_common::cleanupents();
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x37742371, Offset: 0x7d57
// Size: 0xc8
function function_fd52e7e7e4cc7afd( player )
{
    quads_tag = "j_prop_1";
    solos_tag = "j_prop_17";
    cameratag = quads_tag;
    
    if ( isdefined( player ) && isdefined( player.var_edbda953d7469bd7 ) )
    {
        teamcount = player.var_edbda953d7469bd7;
        var_c9bf3815d396f3b3 = 0;
        
        if ( isdefined( self.activepack ) )
        {
            var_c9bf3815d396f3b3 = istrue( self.activepack.var_c9bf3815d396f3b3 );
        }
        
        if ( var_c9bf3815d396f3b3 && teamcount == 2 )
        {
            cameratag = quads_tag;
        }
        else if ( var_c9bf3815d396f3b3 && teamcount == 3 )
        {
            cameratag = solos_tag;
        }
        else if ( teamcount < 3 )
        {
            cameratag = solos_tag;
        }
    }
    
    return cameratag;
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x2ec0661b, Offset: 0x7e28
// Size: 0x8a
function getxcamfunc( player )
{
    assert( isdefined( self.xcams ) );
    
    if ( isdefined( player ) && isdefined( player.var_edbda953d7469bd7 ) )
    {
        assert( player.var_edbda953d7469bd7 > 0 );
        assert( player.var_edbda953d7469bd7 <= self.xcams.size );
        return self.xcams[ player.var_edbda953d7469bd7 - 1 ];
    }
    
    return self.xcams[ 0 ];
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x9f7bcf04, Offset: 0x7ebb
// Size: 0x21e
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
    
    infilanimindex = self.infilanimindex;
    
    if ( infilanimindex >= 5 )
    {
        infilanimindex = 1;
    }
    
    player_link_tag = "j_prop_" + infilanimindex + 1;
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

// Namespace br_infils_ac130
// Params 0
// Checksum 0xbb6a1046, Offset: 0x80e1
// Size: 0x40
function function_9ae48f565dda4a82()
{
    self endon( #"disconnect" );
    wait 5;
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    
    if ( var_2754701952ea4d67 )
    {
        self function_72cf2eee8e035013( %"hash_16737cfa86d4521" );
    }
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x3f71d348, Offset: 0x8129
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

// Namespace br_infils_ac130
// Params 0
// Checksum 0x98edbbb, Offset: 0x816c
// Size: 0x92
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
    self setclientdvar( @"cg_fov_viewmodel", 65 );
    self setclientdvar( @"cg_disable_user_fov", 0 );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0xdf21cb15, Offset: 0x8206
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

// Namespace br_infils_ac130
// Params 0
// Checksum 0xef5afb67, Offset: 0x826a
// Size: 0x157
function delaystreamtomovingplane()
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

// Namespace br_infils_ac130
// Params 1, eflags: 0x4
// Checksum 0x52aa813c, Offset: 0x83c9
// Size: 0xa2
function private function_cc6f5ee219e0effc( percent )
{
    if ( percent <= 0 )
    {
        percent = 0;
    }
    else if ( percent >= 1 )
    {
        percent = 1;
    }
    
    var_7c1f8026968ff956 = int( percent * 100 );
    var_7c1f8026968ff956 -= var_7c1f8026968ff956 % 10;
    
    if ( isplayer( self ) )
    {
        player::setwind( string( var_7c1f8026968ff956 ), 1 );
        return;
    }
    
    if ( self getscriptablehaspart( "wind" ) && self getscriptableparthasstate( "wind", string( var_7c1f8026968ff956 ) ) )
    {
        self setscriptablepartstate( "wind", string( var_7c1f8026968ff956 ), 1 );
    }
}

// Namespace br_infils_ac130
// Params 0, eflags: 0x4
// Checksum 0xae24c68, Offset: 0x8473
// Size: 0x1c2
function private function_6dfeac0c11b159d7()
{
    self endon( #"stopwind" );
    var_64cd9d22fb6477e8 = self.staticc130.origin;
    var_ad65039d2e5e5742 = self.staticc130.angles;
    
    if ( !isdefined( var_ad65039d2e5e5742 ) )
    {
        var_ad65039d2e5e5742 = ( 0, 0, 0 );
    }
    
    var_4a8379b1436784a3 = anglestoforward( var_ad65039d2e5e5742 );
    var_e78616be36a604c1 = var_4a8379b1436784a3 * -1;
    var_78646f63d599c123 = getdvarfloat( @"hash_35e512315ec17f9e", -200 );
    windmaxdistance = getdvarfloat( @"hash_35c124315e992c7c", 50 );
    npcs = arraycombine( self.npcs, self.playermodels );
    
    while ( true )
    {
        operators = arraycombine( level.infilstruct.players, npcs );
        
        foreach ( operator in operators )
        {
            if ( !isdefined( operator ) )
            {
                continue;
            }
            
            var_110970b3127c53e1 = operator.origin - var_64cd9d22fb6477e8;
            projection = math::scalar_projection( var_e78616be36a604c1, var_110970b3127c53e1 );
            projectionpercent = ( projection - var_78646f63d599c123 ) / ( windmaxdistance - var_78646f63d599c123 );
            operator function_cc6f5ee219e0effc( projectionpercent );
        }
        
        wait 0.5;
    }
}

// Namespace br_infils_ac130
// Params 0, eflags: 0x4
// Checksum 0xbfcd1670, Offset: 0x863d
// Size: 0xeb
function private clearplayerwind()
{
    self notify( #"stopwind" );
    npcs = arraycombine( self.npcs, self.playermodels );
    operators = arraycombine( level.infilstruct.players, npcs );
    
    foreach ( operator in operators )
    {
        if ( !isdefined( operator ) )
        {
            continue;
        }
        
        if ( isplayer( operator ) )
        {
            operator.manualoverridewindmaterial = undefined;
        }
        
        operator setscriptablepartstate( "wind", "1", 1 );
    }
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x7390a5a1, Offset: 0x8730
// Size: 0x4e
function function_327cc5b9e5eeb626()
{
    wait 0.1;
    function_8480689471b795a0();
    cloudpartname = level.var_4ff07086d20a8b36 ?? "clouds";
    
    if ( isdefined( self.movingc130 ) )
    {
        self.movingc130 setscriptablepartstate( "br_fx", cloudpartname );
    }
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x323e5751, Offset: 0x8786
// Size: 0x23
function function_29911c87540fe025()
{
    self.manualoverridewindmaterial = undefined;
    player::setwind( "1" );
    self setallstreamloaddist( 0 );
}

// Namespace br_infils_ac130
// Params 0
// Checksum 0x92888482, Offset: 0x87b1
// Size: 0x149
function teleporttomovingplane()
{
    clearplayerwind();
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setallstreamloaddist( 0 );
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
    
    setomnvar( "ui_hide_player_icons", 0 );
    level notify( #"hash_c14217752dacdeed" );
    thread function_327cc5b9e5eeb626();
    br_infils_util::function_fffda20dc2c2df07( &function_29911c87540fe025 );
}

// Namespace br_infils_ac130
// Params 1
// Checksum 0x85e7957d, Offset: 0x8902
// Size: 0x19
function function_91ed8e384d4e1fa6( skinname )
{
    self function_ce21f4102d5d17f6( skinname, "iw9_avatar_scriptable_mp" );
}

