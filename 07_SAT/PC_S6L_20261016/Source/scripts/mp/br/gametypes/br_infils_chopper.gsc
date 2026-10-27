// scripts\mp\br\gametypes\br_infils_chopper.gsc  (hash_409e4f9a95c285eb.gscc) (size: 22698 Bytes / 0x58aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3bbebf36 (1002356534)
// size ...... 22698 (0x58aa)
// includes .. 9   (offset: 0x5072)
// strings ... 128 (offset: 0x50ba)
// dev strs .. 0   (offset: 0x58aa)
// exports ... 31  (offset: 0x3d4e)
// cseg ...... 0xb88 + 0x31c6 (0x3d4e)
// imports ... 106 (offset: 0x4226)
// animtree1 . 0   (offset: 0x58aa)
// animtree2 . 0   (offset: 0x58aa)
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_infils_common;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\streamhint;

#namespace br_infils_chopper;

// Namespace br_infils_chopper
// Params 0
// Checksum 0xc1b0370d, Offset: 0xba6
// Size: 0x166
function init()
{
    assert( isdefined( level.infilstruct ) );
    level.var_ecbb1dc12c3dc87d = getdvarint( @"hash_1d024c82743aa4ce", 0 );
    level.infilstruct.c130model = "veh8_mil_air_mindia8_open_back_infil";
    level.infilstruct.var_f265685cdcfee833 = "veh8_mil_air_mindia8_interior_vm_infil";
    level.infilstruct.var_3a2e6ef0dea2917f = "mp_donetsk_mindia8_intro";
    level.infilstruct.binktime = level.var_ecbb1dc12c3dc87d ? 0.1 : 5;
    level.infilstruct.var_cee5041ecb30a2c5 = &function_a8719d48afa1b495;
    level.infilstruct.var_3bead1a95b75d55d = &function_2295b0f632c0d19d;
    level.infilstruct.var_3ebd56e1708e1387 = &function_f3afff530d382c20;
    orbitcamassets = [ "cam_orbit_br_chopper_squad_player1", "cam_orbit_br_chopper_squad_player1", "cam_orbit_br_chopper_squad_player2", "cam_orbit_br_chopper_squad_player3", "cam_orbit_br_chopper_squad_player4" ];
    br_infils_util::set_orbit_cam_info( orbitcamassets, "cam_orbit_br_chopper_solo" );
    br_infils_util::function_8e44037c2a8b1713( "prematch", &utility::empty_init_func );
    br_infils_util::function_8e44037c2a8b1713( "cinematic", &videostartfunc );
    br_infils_util::function_8e44037c2a8b1713( "animatic", &animaticstartfunc );
}

// Namespace br_infils_chopper
// Params 1
// Checksum 0x31a631a9, Offset: 0xd14
// Size: 0x1415
function function_a8719d48afa1b495( movingchopper )
{
    animstruct = spawnstruct();
    movingchopper.animstruct = animstruct;
    animstruct.origin = getdvarvector( @"br_infil_anim_pos", ( 4319, 0, -28644 ) );
    animstruct.angles = ( 0, 0, 0 );
    animstruct.movingchopper = movingchopper;
    animstruct.cleanupfunc = &function_e5c6c81a78f0fbda;
    animstruct.chopper = getent( "infil_chopper", #script_noteworthy );
    
    if ( isdefined( animstruct.chopper ) )
    {
        animstruct.chopper show();
    }
    else
    {
        animstruct.chopper = animstruct br_infils_util::spawn_script_model( "veh8_mil_air_mindia8_interior_infil", "chopper" );
        animstruct.chopper.angles = animstruct.angles;
        animstruct.chopper.cleanme = 1;
    }
    
    animstruct.choppershell = getent( "infil_chopper_open", #script_noteworthy );
    
    if ( isdefined( animstruct.choppershell ) )
    {
        animstruct.choppershell show();
    }
    else
    {
        animstruct.choppershell = animstruct.chopper br_infils_util::spawn_script_model( "veh8_mil_air_mindia8_open_back_infil", "choppershell" );
        animstruct.choppershell.angles = animstruct.chopper.angles;
        animstruct.choppershell.cleanme = 1;
    }
    
    animstruct.var_d9e7678a1aaba8e = animstruct.chopper br_infils_util::spawn_script_model( "veh8_mil_air_mindia8_interior_infil_netting", "movingChopper" );
    animstruct.var_d9e7678a1aaba8e linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.chopperdoor = animstruct.chopper br_infils_util::spawn_script_model( "veh8_mil_air_mindia8_interior_infil_cabin_door", "chopperDoor" );
    animstruct.chopperdoor linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( isdefined( animstruct.movingchopper ) )
    {
        animstruct.movingchopper.animname = "movingChopper";
        animstruct.movingchopper.innards.animname = "movingChopper";
    }
    
    animstruct.cameraentsolo = animstruct.chopper br_infils_util::spawn_script_model( "generic_prop_x3", "camera" );
    animstruct.cameraentsolo linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.cameraentsquad = animstruct.chopper br_infils_util::spawn_script_model( "generic_prop_x3", "cameraSquad" );
    animstruct.cameraentsquad linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( isdefined( movingchopper ) )
    {
        movingchopper forcenetfieldhighlod( 1 );
        animstruct.var_61b243ef58e281a7 = movingchopper br_infils_util::spawn_script_model( "generic_prop_x3", "cameramoving" );
        animstruct.var_61b243ef58e281a7 linkto( movingchopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.var_61b243ef58e281a7 forcenetfieldhighlod( 1 );
        animstruct.var_cb8657e9f30cf232 = movingchopper br_infils_util::spawn_script_model( "generic_prop_x3", "cameraSquadmoving" );
        animstruct.var_cb8657e9f30cf232 linkto( movingchopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.var_cb8657e9f30cf232 forcenetfieldhighlod( 1 );
    }
    
    animstruct.playerpositionents[ "parent_solo" ] = animstruct.chopper br_infils_util::spawn_script_model( "generic_prop_x3", "propsolo" );
    animstruct.playerpositionents[ "parent_solo" ] linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playerpositionents[ "parent_squad" ] = animstruct.chopper br_infils_util::spawn_script_model( "generic_prop_x5", "propparent" );
    animstruct.playerpositionents[ "parent_squad" ] linkto( animstruct.chopper, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags = [];
    animstruct.playertags[ 0 ] = animstruct.chopper br_infils_util::spawn_script_model( "tag_player", "playerTag1" );
    animstruct.playertags[ 1 ] = animstruct.chopper br_infils_util::spawn_script_model( "tag_player", "playerTag1" );
    animstruct.playertags[ 2 ] = animstruct.chopper br_infils_util::spawn_script_model( "tag_player", "playerTag2" );
    animstruct.playertags[ 3 ] = animstruct.chopper br_infils_util::spawn_script_model( "tag_player", "playerTag3" );
    animstruct.playertags[ 4 ] = animstruct.chopper br_infils_util::spawn_script_model( "tag_player", "playerTag4" );
    animstruct.playertags[ 0 ] linkto( animstruct.playerpositionents[ "parent_solo" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 1 ] linkto( animstruct.playerpositionents[ "parent_squad" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 2 ] linkto( animstruct.playerpositionents[ "parent_squad" ], "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 3 ] linkto( animstruct.playerpositionents[ "parent_squad" ], "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 4 ] linkto( animstruct.playerpositionents[ "parent_squad" ], "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels = [];
    animstruct.playermodels[ 0 ] = animstruct.chopper br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player1" );
    animstruct.playermodels[ 1 ] = animstruct.chopper br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player1" );
    animstruct.playermodels[ 2 ] = animstruct.chopper br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player2" );
    animstruct.playermodels[ 3 ] = animstruct.chopper br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player3" );
    animstruct.playermodels[ 4 ] = animstruct.chopper br_infils_util::spawn_script_model( "fullbody_usmc_ar_br_infil", "player4" );
    animstruct.playermodels[ 0 ] linkto( animstruct.playertags[ 0 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 1 ] linkto( animstruct.playertags[ 0 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 2 ] linkto( animstruct.playertags[ 1 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 3 ] linkto( animstruct.playertags[ 2 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playermodels[ 4 ] linkto( animstruct.playertags[ 3 ], "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.aipilot = animstruct.chopper br_infils_util::spawn_script_model( "body_mp_western_otter_3_1_lod1", "aiPilot" );
    animstruct.aipilothead = spawn( "script_model", animstruct.aipilot gettagorigin( "j_neck" ) );
    animstruct.aipilothead setmodel( "head_mp_eastern_metalghost_1_1" );
    animstruct.aipilothead.animname = "aiPilotHead";
    animstruct.aipilothead linkto( animstruct.aipilot, "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
    animstruct.aipilot linkto( animstruct.playerpositionents[ "parent_solo" ], "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.aicopilot = animstruct.chopper br_infils_util::spawn_script_model( "body_mp_western_otter_3_1_lod1", "aiCopilot" );
    var_fa8111159536969a = spawn( "script_model", animstruct.aicopilot gettagorigin( "j_neck" ) );
    var_fa8111159536969a setmodel( "head_mp_eastern_metalghost_1_1" );
    var_fa8111159536969a linkto( animstruct.aicopilot, "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
    animstruct.aicopilot linkto( animstruct.playerpositionents[ "parent_solo" ], "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.armadarig = animstruct.chopper br_infils_util::spawn_script_model( "generic_prop_x10", "armadaRig" );
    animstruct.armadarig linkto( animstruct.chopper, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.armadarig forcenetfieldhighlod( 1 );
    var_e3b2d4d76dd93ac8 = 9;
    animstruct.armadachoppers = [];
    
    for ( i = 0; i < var_e3b2d4d76dd93ac8 ; i++ )
    {
        newchopper = animstruct.chopper br_infils_util::spawn_script_model( "veh8_mil_air_mindia8_infil_flight", "newChopper" + i );
        newchopper linkto( animstruct.armadarig, "j_prop_" + i + 2, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        newchopper forcenetfieldhighlod( 1 );
        newchopper playloopsound( "br_heli_infil_fleet_lp" );
        animstruct.armadachoppers[ animstruct.armadachoppers.size ] = newchopper;
    }
    
    animstruct.packs = [];
    n = 0;
    
    if ( !level.var_ecbb1dc12c3dc87d )
    {
        animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "scene1" );
        animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_6d54b90c75adf0cc );
        animstruct.packs[ n ] br_infils_util::function_9597cbd14a6857e3( [], &function_e96c0813c45930f1 );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.cameraentsolo, level.br_anim[ "wz_infil_mindia8_solo_cam" ] );
        
        if ( isdefined( animstruct.var_61b243ef58e281a7 ) )
        {
            animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_61b243ef58e281a7, level.br_anim[ "wz_infil_mindia8_solo_cam" ] );
        }
        
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.cameraentsquad, level.br_anim[ "wz_infil_mindia8_squad_cam" ] );
        
        if ( isdefined( animstruct.var_cb8657e9f30cf232 ) )
        {
            animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.var_cb8657e9f30cf232, level.br_anim[ "wz_infil_mindia8_squad_cam" ] );
        }
        
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.playerpositionents[ "parent_solo" ], level.br_anim[ "wz_infil_mindia8_solo_character_link" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.playerpositionents[ "parent_squad" ], level.br_anim[ "wz_infil_mindia8_squad_character_link" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_mindia8_solo_player" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_mindia8_squad_player1" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_mindia8_squad_player2" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_mindia8_squad_player3" ] );
        animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_mindia8_squad_player4" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_mindia8_solo_player" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_mindia8_squad_player1" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_mindia8_squad_player2" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_mindia8_squad_player3" ] );
        animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_mindia8_squad_player4" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.aipilot, level.br_anim[ "wz_infil_mindia8_solo_pilot" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.aipilothead, level.br_anim[ "wz_infil_mindia8_solo_pilot" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.aicopilot, level.br_anim[ "wz_infil_mindia8_solo_copilot" ] );
        animstruct.packs[ n ] br_infils_util::add_pack_modelanim( animstruct.armadarig, level.br_anim[ "wz_infil_mindia8_armada" ] );
        animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.cameraentsquad, "j_prop_1", level.br_anim[ "wz_infil_mindia8_solo_player" ] );
        
        if ( !isdefined( level.scr_notetrack[ "camera" ] ) )
        {
            animation::addnotetrack_customfunction( "camera", "nameplateon", &function_bd7abd1e5b8ef84 );
            animation::addnotetrack_customfunction( "camera", "nameplateoff", &function_debd8cad7dfe1862 );
            animation::addnotetrack_customfunction( "camera", "transition", &transitionfunc );
            animation::addnotetrack_customfunction( "camera", "fadeinstart", &fadeinfunc );
            animation::addnotetrack_customfunction( "camera", "fadeoutstart", &fadeoutfunc );
        }
    }
    
    n++;
    animstruct.packs[ n ] = animstruct br_infils_util::create_animpack( "looping", 1 );
    animstruct.packs[ n ] br_infils_util::add_pack_startfunc( [], &function_c4cfb81726add96d );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 0 ], level.br_anim[ "wz_infil_mindia8_loop_pl01" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 1 ], level.br_anim[ "wz_infil_mindia8_loop_pl01" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 2 ], level.br_anim[ "wz_infil_mindia8_loop_pl02" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 3 ], level.br_anim[ "wz_infil_mindia8_loop_pl03" ] );
    animstruct.packs[ n ] br_infils_util::function_9371dd9b5a3be26e( animstruct.playertags[ 4 ], level.br_anim[ "wz_infil_mindia8_loop_pl04" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 0 ], level.br_anim[ "wz_infil_mindia8_loop_pl01" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 1 ], level.br_anim[ "wz_infil_mindia8_loop_pl01" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 2 ], level.br_anim[ "wz_infil_mindia8_loop_pl02" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 3 ], level.br_anim[ "wz_infil_mindia8_loop_pl03" ] );
    animstruct.packs[ n ] br_infils_util::function_23a63ce49ef69d8f( animstruct.playermodels[ 4 ], level.br_anim[ "wz_infil_mindia8_loop_pl04" ] );
    animstruct.packs[ n ] br_infils_util::function_4e87e96bc5852dc0( animstruct.cameraentsquad, "j_prop_1" );
    animstruct.packs[ n ].var_70b246e04887fc4a = 1;
    return animstruct;
}

// Namespace br_infils_chopper
// Params 0
// Checksum 0x46f5c133, Offset: 0x2132
// Size: 0x205
function function_2382a170e8bf0851()
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
        possibleindices = [ 2, 3, 4, 5 ];
        
        if ( numplayers == 1 )
        {
            possibleindices = [ 1 ];
        }
        
        playercount = 0;
        
        foreach ( player in players )
        {
            player.infilanimindex = possibleindices[ playercount % possibleindices.size ];
            player.var_edbda953d7469bd7 = numplayers;
            playercount++;
        }
    }
}

// Namespace br_infils_chopper
// Params 1
// Checksum 0xb8974261, Offset: 0x233f
// Size: 0x1bd
function function_6d54b90c75adf0cc( array )
{
    function_2382a170e8bf0851();
    
    if ( isdefined( self.movingchopper ) )
    {
        self.movingchopper stoploopsound();
    }
    
    self.aipilot hide();
    self.aicopilot hide();
    self.movingchopper show();
    self.var_d9e7678a1aaba8e show();
    thread clearsoundsubmixmpbrinfilanim();
    
    if ( isdefined( self.movingchopper ) )
    {
        self.movingchopper setscriptablepartstate( "infil_fx_hero", "on" );
        self.movingchopper setscriptablepartstate( "infil_fx_mindia8", "moving" );
    }
    
    function_89803b991877c99b();
    thread chopper_door();
    thread infil_light_dvars();
    thread delaystreamtomovingplane();
    
    foreach ( armadachopper in self.armadachoppers )
    {
        var_b70bbb796b14c525 = getanimlength( level.br_anim[ "wz_infil_mindia8_loop_veh" ] );
        var_1c90fc9c8aad733e = randomfloatrange( 0.5, var_b70bbb796b14c525 - 0.5 );
        armadachopper scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "armadaChopper", var_1c90fc9c8aad733e );
        armadachopper setscriptablepartstate( "infil_fx_armada", "on" );
        
        if ( isdefined( armadachopper.innards ) )
        {
            armadachopper.innards scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "armadaChopperInnards", var_1c90fc9c8aad733e );
        }
    }
}

// Namespace br_infils_chopper
// Params 2
// Checksum 0x4d767113, Offset: 0x2504
// Size: 0x142
function function_e96c0813c45930f1( player, array )
{
    assert( isdefined( player ) );
    var_d4c0c761c30a5938 = 48;
    var_ce05f4f6be26fe25 = 5.6;
    var_557b4c05a5389149 = 50.7;
    var_a401234361e805a0 = 2;
    var_2236739e78e9538b = 4;
    player playlocalsound( "br_heli_infil_part2_lr" );
    player setsoundsubmix( "mp_br_infil_anim", 0 );
    player setsoundsubmix( "mp_br_infil_music", 0 );
    player setsoundsubmix( "mp_br_infil_ac130", 0 );
    player setclienttriggeraudiozone( "mp_br_c130_infil_int", 1 );
    player setclientdvar( @"cg_fov", var_d4c0c761c30a5938 );
    player setclientdvar( @"cg_disable_user_fov", 1 );
    player enablephysicaldepthoffieldscripting();
    player setphysicaldepthoffield( var_ce05f4f6be26fe25, var_557b4c05a5389149, var_a401234361e805a0, var_2236739e78e9538b );
    self.aipilot showtoplayer( player );
    self.aicopilot showtoplayer( player );
    
    if ( !isdefined( player.infilcoveroverlay ) )
    {
        player.infilcoveroverlay = newclienthudelem( player );
        function_11138830b99e606( player.infilcoveroverlay );
    }
}

// Namespace br_infils_chopper
// Params 1
// Checksum 0xa0b546bf, Offset: 0x264e
// Size: 0xb9
function function_11138830b99e606( hudelem )
{
    hudelem.x = 0;
    hudelem.y = 0;
    hudelem setshader( "white", 640, 480 );
    hudelem.alignx = "left";
    hudelem.aligny = "top";
    hudelem.horzalign = "fullscreen";
    hudelem.vertalign = "fullscreen";
    hudelem.sort = -1;
    hudelem.color = ( 0.21, 0.21, 0.17 );
    hudelem.alpha = 0;
    hudelem setshowinrealism( 1 );
}

// Namespace br_infils_chopper
// Params 1
// Checksum 0x7c3133f, Offset: 0x270f
// Size: 0x1d4
function function_c4cfb81726add96d( array )
{
    if ( level.var_ecbb1dc12c3dc87d )
    {
        if ( isdefined( self.movingchopper ) )
        {
            self.movingchopper setscriptablepartstate( "infil_fx_hero", "on" );
            self.movingchopper setscriptablepartstate( "infil_fx_mindia8", "moving" );
        }
        
        foreach ( armadachopper in self.armadachoppers )
        {
            var_b70bbb796b14c525 = getanimlength( level.br_anim[ "wz_infil_mindia8_loop_veh" ] );
            var_1c90fc9c8aad733e = randomfloatrange( 0.5, var_b70bbb796b14c525 - 0.5 );
            armadachopper scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "armadaChopper", var_1c90fc9c8aad733e );
            armadachopper setscriptablepartstate( "infil_fx_armada", "on" );
            
            if ( isdefined( armadachopper.innards ) )
            {
                armadachopper.innards scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "armadaChopperInnards", var_1c90fc9c8aad733e );
            }
        }
        
        self.var_61b243ef58e281a7 scriptmodelplayanim( "wz_infil_mindia8_solo_cam", "cameramoving", 10, 6 );
        self.var_cb8657e9f30cf232 scriptmodelplayanim( "wz_infil_mindia8_squad_cam", "cameraSquadmoving", 10, 6 );
        self.armadarig scriptmodelplayanim( "wz_infil_mindia8_armada", "armadaRig", 0, 3 );
        transitionfunc();
    }
    
    self.chopper stoploopsound();
    
    if ( isdefined( self.movingchopper ) )
    {
        self.movingchopper playloopsound( "br_heli_infil_hero_lp" );
    }
}

// Namespace br_infils_chopper
// Params 0
// Checksum 0x254803f1, Offset: 0x28eb
// Size: 0x15
function function_e5c6c81a78f0fbda()
{
    br_infils_common::cleanupents();
    level notify( #"cleanupinfil" );
}

// Namespace br_infils_chopper
// Params 0, eflags: 0x4
// Checksum 0xe51d3f32, Offset: 0x2908
// Size: 0xaf
function private clearsoundsubmixmpbrinfilanim()
{
    level endon( #"cleanupinfil" );
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

// Namespace br_infils_chopper
// Params 0, eflags: 0x4
// Checksum 0xf9f2c1dd, Offset: 0x29bf
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

// Namespace br_infils_chopper
// Params 0, eflags: 0x4
// Checksum 0x23575781, Offset: 0x2a6a
// Size: 0xa3
function private function_b5322c681125847e()
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

// Namespace br_infils_chopper
// Params 1, eflags: 0x4
// Checksum 0x92bc2f65, Offset: 0x2b15
// Size: 0xaa
function private function_89803b991877c99b( c130 )
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) || isbot( player ) )
        {
            continue;
        }
        
        player player::setwind( "80", 1 );
    }
}

// Namespace br_infils_chopper
// Params 0
// Checksum 0x52519e19, Offset: 0x2bc7
// Size: 0x63
function chopper_door()
{
    level endon( #"cleanupinfil" );
    
    if ( isdefined( self.chopperdoor ) )
    {
        self.chopperdoor hide();
    }
    
    self.cameraentsolo utility::waittill_match_or_timeout( "camera", "showdoor", 30 );
    
    if ( isdefined( self.chopperdoor ) )
    {
        self.chopperdoor show();
    }
}

// Namespace br_infils_chopper
// Params 0, eflags: 0x4
// Checksum 0xe34dbeaf, Offset: 0x2c32
// Size: 0x9f
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
}

// Namespace br_infils_chopper
// Params 1, eflags: 0x4
// Checksum 0x42f4daf9, Offset: 0x2cd9
// Size: 0xf3
function private fadeinfunc( c130 )
{
    fadeintime = 0.15;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.infilcoveroverlay ) )
        {
            continue;
        }
        
        player.infilcoveroverlay.alpha = 0;
        player.infilcoveroverlay fadeovertime( fadeintime );
        player.infilcoveroverlay.alpha = 1;
    }
}

// Namespace br_infils_chopper
// Params 1, eflags: 0x4
// Checksum 0x1b27d6f6, Offset: 0x2dd4
// Size: 0x19f
function private fadeoutfunc( c130 )
{
    fadeouttime = 0.2;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.infilcoveroverlay ) )
        {
            continue;
        }
        
        player.infilcoveroverlay.alpha = 1;
        player.infilcoveroverlay fadeovertime( fadeouttime );
        player.infilcoveroverlay.alpha = 0;
    }
    
    br_infils_util::waitandpause( fadeouttime + 0.1 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.infilcoveroverlay ) )
        {
            continue;
        }
        
        player.infilcoveroverlay destroy();
    }
}

// Namespace br_infils_chopper
// Params 2, eflags: 0x4
// Checksum 0xeb73be2f, Offset: 0x2f7b
// Size: 0x46
function private function_438fe8a0f8ceeb6f( omnvarname, value )
{
    if ( !isdefined( self.var_dfd0bae682a3ab75 ) )
    {
        self.var_dfd0bae682a3ab75 = [];
    }
    
    self.var_dfd0bae682a3ab75[ omnvarname ] = getomnvar( omnvarname );
    setomnvar( omnvarname, value );
}

// Namespace br_infils_chopper
// Params 1, eflags: 0x4
// Checksum 0x83320d44, Offset: 0x2fc9
// Size: 0x3d
function private function_f38d8a01fed5bb9c( omnvarname )
{
    if ( !isdefined( self.var_dfd0bae682a3ab75[ omnvarname ] ) )
    {
        return;
    }
    
    setomnvar( omnvarname, self.var_dfd0bae682a3ab75[ omnvarname ] );
    self.var_dfd0bae682a3ab75[ omnvarname ] = undefined;
}

// Namespace br_infils_chopper
// Params 1, eflags: 0x4
// Checksum 0xa7424d93, Offset: 0x300e
// Size: 0x19
function private function_bd7abd1e5b8ef84( c130 )
{
    function_438fe8a0f8ceeb6f( "ui_hide_player_icons", 0 );
}

// Namespace br_infils_chopper
// Params 1, eflags: 0x4
// Checksum 0x7fae6e02, Offset: 0x302f
// Size: 0x18
function private function_debd8cad7dfe1862( c130 )
{
    function_f38d8a01fed5bb9c( "ui_hide_player_icons" );
}

// Namespace br_infils_chopper
// Params 1, eflags: 0x4
// Checksum 0x2dd48b24, Offset: 0x304f
// Size: 0x58f
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
        player setclienttriggeraudiozone( "mp_br_infil_ext", 2 );
    }
    
    if ( isdefined( level.infilstruct.animstruct.movingchopper ) )
    {
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            cameraent = player.var_edbda953d7469bd7 == 1 ? level.infilstruct.animstruct.var_61b243ef58e281a7 : level.infilstruct.animstruct.var_cb8657e9f30cf232;
            cameratag = "j_prop_1";
            player cameraunlink();
            player cameralinkto( cameraent, cameratag, 1, 1 );
            player setclientdvar( @"cg_fov", var_18d0df245861d5ee );
            player setclientdvar( @"cg_disable_user_fov", 1 );
            player setphysicaldepthoffield( var_a8f0a20f605c8643, var_77bbca38fad0b92b, var_daed827896c0c1f6, var_be99de3cab37743d );
            player thread function_3df1d0cf67a02dd1();
        }
        
        level thread clearsoundsubmixfadetoblackamb();
        level.infilstruct.animstruct.playerpositionents[ "parent_solo" ] unlink();
        level.infilstruct.animstruct.playerpositionents[ "parent_squad" ] unlink();
        level.infilstruct.animstruct.playerpositionents[ "parent_solo" ] linkto( level.infilstruct.animstruct.movingchopper, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.infilstruct.animstruct.playerpositionents[ "parent_squad" ] linkto( level.infilstruct.animstruct.movingchopper, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.infilstruct.animstruct.armadarig unlink();
        level.infilstruct.animstruct.armadarig linkto( level.infilstruct.animstruct.movingchopper, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.infilstruct.animstruct.movingchopper scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "movingChopper" );
        level.infilstruct.animstruct.movingchopper.innards scriptmodelplayanim( "wz_infil_mindia8_loop_veh", "movingChopperInnards" );
        level.infilstruct.animstruct.playerpositionents[ "parent_solo" ] scriptmodelplayanim( "wz_infil_mindia8_loop_genpropx10", "prop" );
        level.infilstruct.animstruct.playerpositionents[ "parent_squad" ] scriptmodelplayanim( "wz_infil_mindia8_loop_genpropx10", "prop" );
        
        if ( level.var_ecbb1dc12c3dc87d )
        {
            level waittill( #"play_video_complete" );
        }
        
        level.infilstruct.animstruct.movingchopper notify( #"start_moving" );
        
        if ( level.var_ecbb1dc12c3dc87d )
        {
            wait 3.5;
        }
    }
    
    level.infilstruct.animstruct.aipilot hide();
    level.infilstruct.animstruct.aicopilot hide();
    setomnvar( "ui_hide_player_icons", 0 );
    setomnvar( "ui_in_infil", 2 );
    level thread function_b5322c681125847e();
}

// Namespace br_infils_chopper
// Params 0
// Checksum 0x1e273f00, Offset: 0x35e6
// Size: 0x27
function function_3df1d0cf67a02dd1()
{
    if ( level.var_ecbb1dc12c3dc87d )
    {
        level waittill( #"play_video_complete" );
    }
    
    self notify( #"infil_move" );
}

// Namespace br_infils_chopper
// Params 0, eflags: 0x4
// Checksum 0x527aa8c3, Offset: 0x3615
// Size: 0x57
function private infil_light_dvars()
{
    level endon( #"cleanupinfil" );
    var_48fd9a9f3c3fab0e = getdvarint( @"cg_brcircleenableoutsidevisionset" );
    setdvar( @"cg_brcircleenableoutsidevisionset", 0 );
    utility::waittill_any( "infil_reset_light_dvars", "stopScene" );
    setdvar( @"cg_brcircleenableoutsidevisionset", var_48fd9a9f3c3fab0e );
}

// Namespace br_infils_chopper
// Params 0, eflags: 0x4
// Checksum 0x5b05b6e1, Offset: 0x3674
// Size: 0x163
function private delaystreamtomovingplane()
{
    self endon( #"stopscene" );
    level endon( #"cleanupinfil" );
    
    if ( isdefined( self.movingchopper ) )
    {
        delaytime = getdvarint( @"hash_d01d0472d843d39e", 8 );
        wait delaytime;
        
        if ( !isdefined( self.movingchopper ) )
        {
            return;
        }
        
        streamorigin = self.movingchopper.origin;
        forward = getdvarint( @"hash_7abcda2d7aabbe4c", 0 );
        
        if ( forward > 0 )
        {
            dir = anglestoforward( self.movingchopper.angles );
            streamorigin = self.movingchopper.origin + dir * forward;
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

// Namespace br_infils_chopper
// Params 0, eflags: 0x4
// Checksum 0x6e189c2c, Offset: 0x37df
// Size: 0xce
function private stopstreamtomovingplane()
{
    if ( isdefined( self.movingchopper ) && getdvarint( @"hash_eb8a05afa7735e5f", 1 ) == 1 )
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

// Namespace br_infils_chopper
// Params 0
// Checksum 0x77df7b06, Offset: 0x38b5
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
        player playlocalsound( "br_heli_infil_part1_lr" );
        player clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
        player setsoundsubmix( "solo_cin_igc_music_br_hack", 0.5 );
        player setplayermusicstate( br_infil_intro );
    }
}

// Namespace br_infils_chopper
// Params 0
// Checksum 0x871717d3, Offset: 0x39a1
// Size: 0xa
function animaticstartfunc()
{
    level thread setsoundsubmixfadetoblackamb();
}

// Namespace br_infils_chopper
// Params 1, eflags: 0x4
// Checksum 0x6987dad9, Offset: 0x39b3
// Size: 0xd7
function private setsoundsubmixfadetoblackamb( players )
{
    level endon( #"cleanupinfil" );
    
    if ( !level.var_ecbb1dc12c3dc87d )
    {
        br_infils_util::waitandpause( 2 );
    }
    
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

// Namespace br_infils_chopper
// Params 0
// Checksum 0x7b4b0725, Offset: 0x3a92
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
        return [ "wz_infil_mindia8_jump_genpropx10", level.br_anim[ "wz_infil_mindia8_jump_genpropx10" ], "wz_infil_mindia8_jump01_pl01", player_link_tag ];
    }
    
    if ( dotright > cos45 )
    {
        return [ "wz_infil_mindia8_jump_genpropx10_90_l", level.br_anim[ "wz_infil_mindia8_jump_genpropx10_90_l" ], "wz_infil_mindia8_jump01_pl01_90_l", player_link_tag ];
    }
    
    if ( dotright < -1 * cos45 )
    {
        return [ "wz_infil_mindia8_jump_genpropx10_90_r", level.br_anim[ "wz_infil_mindia8_jump_genpropx10_90_r" ], "wz_infil_mindia8_jump01_pl01_90_r", player_link_tag ];
    }
    
    if ( dotright > 0 )
    {
        return [ "wz_infil_mindia8_jump_genpropx10_180_l", level.br_anim[ "wz_infil_mindia8_jump_genpropx10_180_l" ], "wz_infil_mindia8_jump01_pl01_180_l", player_link_tag ];
    }
    
    return [ "wz_infil_mindia8_jump_genpropx10_180_r", level.br_anim[ "wz_infil_mindia8_jump_genpropx10_180_r" ], "wz_infil_mindia8_jump01_pl01_180_r", player_link_tag ];
}

// Namespace br_infils_chopper
// Params 2
// Checksum 0x4803d1d0, Offset: 0x3c95
// Size: 0xb9
function function_f3afff530d382c20( movedestination, movetime )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self hide();
    
    if ( isdefined( self.innards ) )
    {
        self.innards hide();
    }
    
    self waittill( #"start_moving" );
    self show();
    
    if ( isdefined( self.innards ) )
    {
        self.innards show();
    }
    
    self moveto( movedestination, movetime );
    
    /#
        if ( getdvarint( @"hash_c25457fbe123d92f", 0 ) )
        {
            movetime -= 10;
        }
    #/
    
    thread br_c130::killaftertime( movetime, "c130" );
    self playloopsound( "br_heli_infil_hero_lp" );
}

