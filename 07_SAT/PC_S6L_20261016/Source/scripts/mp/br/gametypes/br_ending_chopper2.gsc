// scripts\mp\br\gametypes\br_ending_chopper2.gsc  (hash_3c427bce1aff2c35.gscc) (size: 74424 Bytes / 0x122b8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d450f0a (1564806922)
// size ...... 74424 (0x122b8)
// includes .. 10  (offset: 0x10658)
// strings ... 559 (offset: 0x106a8)
// dev strs .. 2   (offset: 0x122a0)
// exports ... 91  (offset: 0xd5e8)
// cseg ...... 0x51af + 0x8439 (0xd5e8)
// imports ... 183 (offset: 0xe420)
// animtree1 . 0   (offset: 0x122b8)
// animtree2 . 0   (offset: 0x122b8)
#using scripts\common\math;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\br\gametypes\br_accolades;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_ending_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player_utility;

#namespace br_ending_chopper2;

// Namespace br_ending_chopper2
// Params 0
// Checksum 0xcff5487b, Offset: 0x51cd
// Size: 0x46
function chopperexfil_init()
{
    /#
        setdevdvarifuninitialized( @"hash_70809e88d9881104", 0 );
    #/
    
    utility::delaythread( 0.05, &br_ending_util::function_1c0500c7cf8f9b7, "chopper2" );
    accolades_init();
    level.var_e0308e22e5b02b6c = &function_9263c3eb37cb8039;
    chopperexfil_fx_init();
}

// Namespace br_ending_chopper2
// Params 0
// Checksum 0x7457f622, Offset: 0x521b
// Size: 0x1b
function chopperexfil_fx_init()
{
    level._effect[ "player_disconnect" ] = loadfxasset( "vfx_iw8_br_gameplay_disconnect_player" );
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0xcd5ff171, Offset: 0x523e
// Size: 0x39
function function_c98a0498c8c97021( accolade, shotfunc )
{
    if ( !isdefined( level.var_391b7f5537bbf1a7 ) )
    {
        level.var_391b7f5537bbf1a7 = [];
    }
    
    level.var_391b7f5537bbf1a7[ accolade ] = shotfunc;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x69e39614, Offset: 0x527f
// Size: 0x1f
function function_9263c3eb37cb8039( winnerplayers, var_c71a8bc30a7b241b )
{
    thread function_cf6e6d9cae907f4a( winnerplayers, var_c71a8bc30a7b241b );
}

// Namespace br_ending_chopper2
// Params 3, eflags: 0x4
// Checksum 0x2dcec44d, Offset: 0x52a6
// Size: 0x114
function private function_cf6e6d9cae907f4a( winners, var_410ded744dab958f, movetime )
{
    soundbank = "mp_gamemode_br_exfils";
    
    if ( utility::issharedfuncdefined( #"hash_c2ceec7db51f55c1", #"getexfilsoundbank" ) )
    {
        soundbank = [[ utility::getsharedfunc( #"hash_c2ceec7db51f55c1", #"getexfilsoundbank" ) ]]();
    }
    
    audio_utility::snd_transient_load( soundbank );
    clearmusicstate();
    wait 1;
    
    if ( !isdefined( winners ) )
    {
        winners = [];
    }
    
    if ( !isdefined( var_410ded744dab958f ) )
    {
        var_410ded744dab958f = ( 0, 0, 0 );
    }
    
    if ( !isdefined( movetime ) )
    {
        movetime = 7;
    }
    
    endorigin = var_410ded744dab958f + ( 0, 0, 360 );
    startorigin = endorigin + ( -7200, 7200, 1800 );
    tempent = spawn( "script_model", startorigin );
    tempent forcenetfieldhighlod( 1 );
    waitframe();
    tempent playsoundonmovingent( "veh_br_palfa_exfil_incoming" );
    tempent moveto( endorigin, movetime );
    wait movetime;
    tempent delete();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x7b14d87b, Offset: 0x53c2
// Size: 0x11f6
function chopperexfil_pack( var_410ded744dab958f = ( 0, 0, 0 ) )
{
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_br_infil_exfil_player_focus", -1 );
    }
    
    if ( !getdvarint( @"scr_br_ending_placement" ) )
    {
        self.transientname = get_chopperexfil_transient();
        
        if ( !isdefined( self.transientname ) )
        {
            assertmsg( "<dev string:x24>" );
            return;
        }
        
        loadinfiltransient( self.transientname );
        setomnvarforallclients( "ui_br_end_game_splash_type", 18 );
        
        for ( var_9c9751620202d0b9 = 0; !var_9c9751620202d0b9 ; var_9c9751620202d0b9 = function_cb3f113c9a5d56f7( self.transientname ) )
        {
            waitframe();
        }
    }
    
    chopper = br_ending_util::function_7142ded48d484762( "veh9_mil_air_heli_palfa_doors_open_x_vehphys_mp_exfil", undefined, "veh9_mil_air_heli_palfa_physics_mp_exfil" );
    chopper setscriptablepartstate( "engine", "on", 0 );
    chopper vehicle_turnengineoff();
    chopper.dontteleport = 1;
    scenename = level.var_631053d3735ca753 ?? "chopper2";
    lightingrig = br_ending_util::function_88dc0218d2006993( scenename, chopper );
    self.lightingrig = lightingrig;
    self.exfilchopper = chopper;
    br_ending_util::chopperexfil_set_brcircle();
    self.winners = function_5713d46873b29625( self.winners );
    
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
    else
    {
        function_b4ffe65cd6c9efe3( chopper, self.winners[ 0 ] );
    }
    
    var_6d87168a0c29eeaa = getdvarint( @"hash_cf55e0f95935f5af", 1 );
    
    if ( getdvarint( @"scr_br_ending_placement" ) || getdvarint( @"hash_2d200a3da7fb2518" ) )
    {
        var_6d87168a0c29eeaa = 0;
    }
    
    var_f754ef14b29cf391 = undefined;
    var_324866c301b322ef = getdvar( @"hash_ad33abd04b38d2fa", "" );
    var_324867c301b32522 = getdvar( @"hash_ad33aad04b38d0c7", "" );
    var_324868c301b32755 = getdvar( @"hash_ad33a9d04b38ce94", "" );
    var_324861c301b317f0 = getdvar( @"hash_ad33a8d04b38cc61", "" );
    var_324862c301b31a23 = getdvar( @"hash_ad33a7d04b38ca2e", "" );
    var_324863c301b31c56 = getdvar( @"hash_ad33a6d04b38c7fb", "" );
    
    if ( var_324866c301b322ef != "" || var_324867c301b32522 != "" || var_324868c301b32755 != "" || var_324861c301b317f0 != "" || var_324862c301b31a23 != "" || var_324863c301b31c56 != "" )
    {
        var_f754ef14b29cf391 = [];
        var_f754ef14b29cf391[ 0 ] = var_324866c301b322ef;
        var_f754ef14b29cf391[ 1 ] = var_324867c301b32522;
        var_f754ef14b29cf391[ 2 ] = var_324868c301b32755;
        var_f754ef14b29cf391[ 3 ] = var_324861c301b317f0;
        var_f754ef14b29cf391[ 4 ] = var_324862c301b31a23;
        var_f754ef14b29cf391[ 5 ] = var_324863c301b31c56;
    }
    
    br_accolades::function_8ffb08c901d9d792( self.winners );
    br_ending::function_c64a9bbb6771df41( self.winners );
    br_accolades::function_53910fe003f40d9( self.winners, var_6d87168a0c29eeaa, var_f754ef14b29cf391 );
    npc = br_ending_util::spawn_script_model( "fullbody_mp_ally_helicopter_crew_chief_exfil" );
    npc hide( 1 );
    self.npc = npc;
    npc2 = br_ending_util::spawn_script_model( "fullbody_usmc_ar_br_infil" );
    npc2 hide( 1 );
    self.npc2 = npc2;
    self.cam = br_ending_util::create_cam();
    
    if ( utility::issharedfuncdefined( #"hash_c2ceec7db51f55c1", #"getanimpack" ) )
    {
        self.pack = self [[ utility::getsharedfunc( #"hash_c2ceec7db51f55c1", #"getanimpack" ) ]]( chopper, lightingrig, npc, 0.25 );
    }
    else
    {
        self.packs = [];
        n = 0;
        self.packs[ n ] = br_ending_util::create_animpack( "scene1" );
        self.packs[ n ] br_ending_util::set_pack_fov( 55 );
        self.packs[ n ] br_ending_util::add_pack_startfunc( [], &introstartfunc );
        self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh010" ] );
        self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( lightingrig );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "wz_iw9_exfil_intro_operator01_sh010" ], level.br_anim[ "wz_iw9_exfil_intro_operator01_fem_sh010" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "wz_iw9_exfil_intro_operator02_sh010" ], level.br_anim[ "wz_iw9_exfil_intro_operator02_fem_sh010" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "wz_iw9_exfil_intro_operator03_sh010" ], level.br_anim[ "wz_iw9_exfil_intro_operator03_fem_sh010" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "wz_iw9_exfil_intro_operator04_sh010" ], level.br_anim[ "wz_iw9_exfil_intro_operator04_fem_sh010" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 4 ], level.br_anim[ "wz_iw9_exfil_intro_operator05_sh010" ], level.br_anim[ "wz_iw9_exfil_intro_operator05_fem_sh010" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 5 ], level.br_anim[ "wz_iw9_exfil_intro_operator06_sh010" ], level.br_anim[ "wz_iw9_exfil_intro_operator06_fem_sh010" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 6 ], level.br_anim[ "wz_iw9_exfil_intro_operator07_sh010" ], level.br_anim[ "wz_iw9_exfil_intro_operator07_fem_sh010" ] );
        self.packs[ n ] br_ending_util::add_pack_modelanim( npc, level.br_anim[ "wz_iw9_exfil_intro_doorguy_sh010" ] );
        self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_intro_camera_sh010" ], "wz_iw9_exfil_intro_xcam_sh010" );
        n++;
        self.packs[ n ] = br_ending_util::create_animpack( "scene3" );
        self.packs[ n ] br_ending_util::set_pack_fov( 55 );
        self.packs[ n ] br_ending_util::add_pack_startfunc( [], &function_e6b8ccd2d74c6aff );
        self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh030" ] );
        self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( lightingrig );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "wz_iw9_exfil_intro_operator01_sh030" ], level.br_anim[ "wz_iw9_exfil_intro_operator01_fem_sh030" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "wz_iw9_exfil_intro_operator02_sh030" ], level.br_anim[ "wz_iw9_exfil_intro_operator02_fem_sh030" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "wz_iw9_exfil_intro_operator03_sh030" ], level.br_anim[ "wz_iw9_exfil_intro_operator03_fem_sh030" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "wz_iw9_exfil_intro_operator04_sh030" ], level.br_anim[ "wz_iw9_exfil_intro_operator04_fem_sh030" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 4 ], level.br_anim[ "wz_iw9_exfil_intro_operator05_sh030" ], level.br_anim[ "wz_iw9_exfil_intro_operator05_fem_sh030" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 5 ], level.br_anim[ "wz_iw9_exfil_intro_operator06_sh030" ], level.br_anim[ "wz_iw9_exfil_intro_operator06_fem_sh030" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 6 ], level.br_anim[ "wz_iw9_exfil_intro_operator07_sh030" ], level.br_anim[ "wz_iw9_exfil_intro_operator07_fem_sh030" ] );
        self.packs[ n ] br_ending_util::add_pack_modelanim( npc, level.br_anim[ "wz_iw9_exfil_intro_doorguy_sh030" ] );
        self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_intro_camera_sh030" ], "wz_iw9_exfil_intro_xcam_sh030" );
        n++;
        self.packs[ n ] = br_ending_util::create_animpack( "scene4" );
        self.packs[ n ] br_ending_util::set_pack_fov( 55 );
        self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh040" ] );
        self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( lightingrig );
        
        if ( self.winners.size == 1 )
        {
            self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "wz_iw9_exfil_intro_operator01_solo_sh040" ], level.br_anim[ "wz_iw9_exfil_intro_operator01_solo_fem_sh040" ] );
        }
        else
        {
            self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "wz_iw9_exfil_intro_operator01_sh040" ], level.br_anim[ "wz_iw9_exfil_intro_operator01_fem_sh040" ] );
        }
        
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "wz_iw9_exfil_intro_operator02_sh040" ], level.br_anim[ "wz_iw9_exfil_intro_operator02_fem_sh040" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "wz_iw9_exfil_intro_operator03_sh040" ], level.br_anim[ "wz_iw9_exfil_intro_operator03_fem_sh040" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "wz_iw9_exfil_intro_operator04_sh040" ], level.br_anim[ "wz_iw9_exfil_intro_operator04_fem_sh040" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 4 ], level.br_anim[ "wz_iw9_exfil_intro_operator05_sh040" ], level.br_anim[ "wz_iw9_exfil_intro_operator05_fem_sh040" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 5 ], level.br_anim[ "wz_iw9_exfil_intro_operator06_sh040" ], level.br_anim[ "wz_iw9_exfil_intro_operator06_fem_sh040" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 6 ], level.br_anim[ "wz_iw9_exfil_intro_operator07_sh040" ], level.br_anim[ "wz_iw9_exfil_intro_operator07_fem_sh040" ] );
        self.packs[ n ] br_ending_util::add_pack_modelanim( npc, level.br_anim[ "wz_iw9_exfil_intro_doorguy_sh040" ] );
        self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_intro_camera_sh040" ], "wz_iw9_exfil_intro_xcam_sh040" );
        n++;
        self.packs[ n ] = br_ending_util::create_animpack( "scene5" );
        self.packs[ n ] br_ending_util::set_pack_fov( 55 );
        self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh050" ] );
        self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( lightingrig );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "wz_iw9_exfil_intro_operator01_sh050" ], level.br_anim[ "wz_iw9_exfil_intro_operator01_fem_sh050" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "wz_iw9_exfil_intro_operator02_sh050" ], level.br_anim[ "wz_iw9_exfil_intro_operator02_fem_sh050" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "wz_iw9_exfil_intro_operator03_sh050" ], level.br_anim[ "wz_iw9_exfil_intro_operator03_fem_sh050" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "wz_iw9_exfil_intro_operator04_sh050" ], level.br_anim[ "wz_iw9_exfil_intro_operator04_fem_sh050" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 4 ], level.br_anim[ "wz_iw9_exfil_intro_operator05_sh050" ], level.br_anim[ "wz_iw9_exfil_intro_operator05_fem_sh050" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 5 ], level.br_anim[ "wz_iw9_exfil_intro_operator06_sh050" ], level.br_anim[ "wz_iw9_exfil_intro_operator06_fem_sh050" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 6 ], level.br_anim[ "wz_iw9_exfil_intro_operator07_sh050" ], level.br_anim[ "wz_iw9_exfil_intro_operator07_fem_sh050" ] );
        self.packs[ n ] br_ending_util::add_pack_modelanim( npc, level.br_anim[ "wz_iw9_exfil_intro_doorguy_sh050" ] );
        self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_intro_camera_sh050" ], "wz_iw9_exfil_intro_xcam_sh050" );
        n++;
        self.packs[ n ] = br_ending_util::create_animpack( "scene6" );
        self.packs[ n ] br_ending_util::set_pack_fov( 55 );
        self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
        self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_9d918f2d31d3241f );
        self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh060" ] );
        self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( lightingrig );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "wz_iw9_exfil_intro_operator01_sh060" ], level.br_anim[ "wz_iw9_exfil_intro_operator01_fem_sh060" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "wz_iw9_exfil_intro_operator02_sh060" ], level.br_anim[ "wz_iw9_exfil_intro_operator02_fem_sh060" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "wz_iw9_exfil_intro_operator03_sh060" ], level.br_anim[ "wz_iw9_exfil_intro_operator03_fem_sh060" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "wz_iw9_exfil_intro_operator04_sh060" ], level.br_anim[ "wz_iw9_exfil_intro_operator04_fem_sh060" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 4 ], level.br_anim[ "wz_iw9_exfil_intro_operator05_sh060" ], level.br_anim[ "wz_iw9_exfil_intro_operator05_fem_sh060" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 5 ], level.br_anim[ "wz_iw9_exfil_intro_operator06_sh060" ], level.br_anim[ "wz_iw9_exfil_intro_operator06_fem_sh060" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 6 ], level.br_anim[ "wz_iw9_exfil_intro_operator07_sh060" ], level.br_anim[ "wz_iw9_exfil_intro_operator07_fem_sh060" ] );
        self.packs[ n ] br_ending_util::add_pack_modelanim( npc, level.br_anim[ "wz_iw9_exfil_intro_doorguy_sh060" ] );
        self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_intro_camera_sh060" ], "wz_iw9_exfil_intro_xcam_sh060" );
        n = function_8bc7500bcaa8a30a( n );
        n++;
        self.packs[ n ] = br_ending_util::create_animpack( "scene56" );
        self.packs[ n ] br_ending_util::set_pack_fov( 65 );
        self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
        self.packs[ n ] br_ending_util::add_pack_startfunc( [], &outrofunc );
        self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &outroendfunc );
        self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "wz_iw9_exfil_outro_helicopter_sh010" ] );
        self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( lightingrig );
        self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_outro_camera_sh010" ], "wz_iw9_exfil_outro_xcam_sh010" );
    }
    
    self.var_fa52d7e97dced8c7 = getstartorigin( self.origin, self.angles, level.br_anim[ "wz_iw9_exfil_acc_assists_helicopter_sh010" ] );
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0xaca00668, Offset: 0x65c0
// Size: 0x63
function function_b4ffe65cd6c9efe3( chopper, player )
{
    if ( isdefined( player.vehiclecustomization ) )
    {
        mtx = vehicle::function_a634e7859d837381( player, "veh9_palfa" );
        
        if ( isdefined( mtx ) )
        {
            chopper.mtx = mtx;
            chopper function_ab60c6b563088b74( mtx.ref );
        }
    }
}

// Namespace br_ending_chopper2
// Params 0
// Checksum 0xba124774, Offset: 0x662b
// Size: 0x6d8
function function_10355abd5fe8eef9()
{
    argsarray = [];
    guyradius = 30;
    guyheight = 68;
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator01_sh010" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator02_sh010" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator03_sh010" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator04_sh010" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator05_sh010" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator06_sh010" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator07_sh010" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator01_sh030" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator02_sh030" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator03_sh030" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator04_sh030" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator05_sh030" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator06_sh030" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator07_sh030" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator01_sh040" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator02_sh040" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator03_sh040" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator04_sh040" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator05_sh040" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator06_sh040" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator07_sh040" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator01_sh050" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator02_sh050" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator03_sh050" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator04_sh050" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator05_sh050" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator06_sh050" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator07_sh050" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator01_sh060" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator02_sh060" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator03_sh060" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator04_sh060" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator05_sh060" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator06_sh060" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "wz_iw9_exfil_intro_operator07_sh060" ], 0, undefined, guyradius, guyheight );
    choppermodel = "veh9_mil_air_heli_palfa_doors_open_x_vehphys_mp_exfil";
    chopperoriginoffset = ( 0, 0, -70 );
    chopperradius = 350;
    choppersegments = 10;
    usevehicleanimtree = 1;
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh010" ], 0, chopperoriginoffset, chopperradius, usevehicleanimtree );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh030" ], 0, chopperoriginoffset, chopperradius, usevehicleanimtree );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh040" ], 0, chopperoriginoffset, chopperradius, usevehicleanimtree );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh050" ], 0, chopperoriginoffset, chopperradius, usevehicleanimtree );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh060" ], 0, chopperoriginoffset, chopperradius, usevehicleanimtree );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_outro_helicopter_sh010" ], 0, chopperoriginoffset, chopperradius, usevehicleanimtree );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_outro_helicopter_sh010" ], 0.99, chopperoriginoffset, chopperradius, usevehicleanimtree );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh010" ], chopperoriginoffset, chopperradius, choppersegments, usevehicleanimtree );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh030" ], chopperoriginoffset, chopperradius, choppersegments, usevehicleanimtree );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh040" ], chopperoriginoffset, chopperradius, choppersegments, usevehicleanimtree );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh050" ], chopperoriginoffset, chopperradius, choppersegments, usevehicleanimtree );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_intro_helicopter_sh060" ], chopperoriginoffset, chopperradius, choppersegments, usevehicleanimtree );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "wz_iw9_exfil_outro_helicopter_sh010" ], chopperoriginoffset, chopperradius, 200, usevehicleanimtree );
    return argsarray;
}

// Namespace br_ending_chopper2
// Params 0, eflags: 0x4
// Checksum 0x2fe3fbc1, Offset: 0x6d0c
// Size: 0x111
function private interior_lights_disable()
{
    lightnames = [ "light_009", "light_010", "light_003", "light_012", "light_008", "light_012", "light_013", "light_016" ];
    
    if ( isdefined( self.lightingrig ) )
    {
        foreach ( light in self.lightingrig.lights )
        {
            if ( isdefined( light.name ) && arraycontains( lightnames, light.name ) )
            {
                light.override_intensity = 0;
            }
        }
    }
}

// Namespace br_ending_chopper2
// Params 0, eflags: 0x4
// Checksum 0x176cad07, Offset: 0x6e25
// Size: 0x10b
function private function_545d6ebbda3a8121()
{
    lightnames = [ "light_009", "light_010", "light_003", "light_012", "light_008", "light_012", "light_013", "light_016" ];
    
    if ( isdefined( self.lightingrig ) )
    {
        foreach ( light in self.lightingrig.lights )
        {
            if ( isdefined( light.name ) && arraycontains( lightnames, light.name ) )
            {
                light.override_intensity = undefined;
            }
        }
    }
}

// Namespace br_ending_chopper2
// Params 1, eflags: 0x4
// Checksum 0x282becec, Offset: 0x6f38
// Size: 0x67
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
    self setscriptablepartstate( "wind", string( var_7c1f8026968ff956 ), 1 );
}

// Namespace br_ending_chopper2
// Params 0, eflags: 0x4
// Checksum 0xb17b5fd1, Offset: 0x6fa7
// Size: 0x1a3
function private function_6dfeac0c11b159d7()
{
    self endon( #"stopwind" );
    var_78646f63d599c123 = getdvarfloat( @"hash_35e512315ec17f9e", -175 );
    windmaxdistance = getdvarfloat( @"hash_35c124315e992c7c", -275 );
    
    while ( true )
    {
        baseorigin = self.exfilchopper.origin;
        baseangles = self.exfilchopper.angles;
        
        if ( !isdefined( baseangles ) )
        {
            baseangles = ( 0, 0, 0 );
        }
        
        basedirection = anglestoforward( baseangles );
        operators = arraycombine( self.winners, [ self.npc ] );
        
        foreach ( operator in operators )
        {
            if ( !isdefined( operator ) )
            {
                continue;
            }
            
            if ( operator.isdisconnectplayer )
            {
                continue;
            }
            
            var_220144d011477a92 = operator.origin - baseorigin;
            projection = math::scalar_projection( basedirection, var_220144d011477a92 );
            projectionpercent = ( projection - var_78646f63d599c123 ) / ( windmaxdistance - var_78646f63d599c123 );
            operator function_cc6f5ee219e0effc( projectionpercent );
        }
        
        wait 0.1;
    }
}

// Namespace br_ending_chopper2
// Params 0, eflags: 0x4
// Checksum 0x224be26c, Offset: 0x7152
// Size: 0xca
function private clearplayerwind()
{
    self notify( #"stopwind" );
    operators = arraycombine( self.winners, [ self.npc ] );
    
    foreach ( operator in operators )
    {
        if ( !isdefined( operator ) )
        {
            continue;
        }
        
        if ( operator.isdisconnectplayer )
        {
            continue;
        }
        
        operator setscriptablepartstate( "wind", "1", 1 );
    }
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x73d61565, Offset: 0x7224
// Size: 0x18b
function introstartfunc( array )
{
    self.npc show();
    level thread function_3bdb569e587d40d( self.winners );
    interior_lights_disable();
    operators = arraycombine( self.winners, [ self.npc ] );
    
    foreach ( operator in operators )
    {
        if ( !isdefined( operator ) )
        {
            continue;
        }
        
        if ( operator.isdisconnectplayer )
        {
            continue;
        }
        
        operator setscriptablepartstate( "wind", "100", 1 );
    }
    
    if ( getdvarint( @"hash_b44ba42bba42b79e", 1 ) )
    {
        if ( isdefined( self.var_fa52d7e97dced8c7 ) )
        {
            foreach ( player in level.players )
            {
                player predictstreamposuntilcleared( self.var_fa52d7e97dced8c7 );
            }
        }
    }
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xbc2ae4b7, Offset: 0x73b7
// Size: 0x13
function function_e6b8ccd2d74c6aff( array )
{
    thread function_6dfeac0c11b159d7();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xaec4cb92, Offset: 0x73d2
// Size: 0x1c
function function_2a7c5716131a1e93( array )
{
    self.npc hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x95644ff8, Offset: 0x73f6
// Size: 0x150
function function_3bdb569e587d40d( winners )
{
    max_exfil_players = 7;
    
    if ( !isdefined( winners ) )
    {
        winners = [];
    }
    
    winnerssize = min( winners.size, max_exfil_players );
    assert( winners.size >= 0 && winners.size <= 7, "<dev string:x42>" );
    musicstate = audio_utility::function_d4d265f3dcd0a13c( "br_exfil_intro1" );
    musicstate_classic = audio_utility::function_d4d265f3dcd0a13c( "br_exfil_intro1_classic" );
    soundalias = "scn_br_palfa_exfil_intro";
    
    if ( winnerssize > 0 )
    {
        musicset = "br_exfil_intro" + winnerssize;
        musicstate = audio_utility::function_d4d265f3dcd0a13c( musicset );
        musicstate_classic = audio_utility::function_d4d265f3dcd0a13c( musicset + "_classic" );
        prefix = "scn_br_palfa_exfil_";
        
        if ( utility::issharedfuncdefined( #"hash_c2ceec7db51f55c1", #"hash_e84a326f18043d4" ) )
        {
            prefix = [[ utility::getsharedfunc( #"hash_c2ceec7db51f55c1", #"hash_e84a326f18043d4" ) ]]();
        }
        
        soundalias = prefix + winnerssize + "player";
    }
    
    audio_utility::function_6a0ed3b9fb942369( level.players, musicstate, undefined, undefined, musicstate_classic );
    audio_utility::function_63bf1584c79c055( level.players, soundalias );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_br_exfil_fade", 4 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xc6d96266, Offset: 0x754e
// Size: 0x203
function function_9d918f2d31d3241f( array )
{
    foreach ( player in level.players )
    {
        player setclienttriggeraudiozone( "br_exfil_palfa_int", 0 );
    }
    
    function_2a7c5716131a1e93( array );
    exfilvisionset = level.var_1c6c0eb6eb07b336 ?? "mp_saba_exfil";
    player_utility::_visionsetnaked( exfilvisionset, 0 );
    hwconfiguratoraddasset( %"hash_270c7fe96829828b" );
    fistsweapon = level.defaultfist;
    
    foreach ( player in self.winners )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.player_rig ) && isdefined( player.player_rig.avatar ) && isdefined( player.player_rig.avatar.weaponent ) )
        {
            player.player_rig.avatar.weaponent delete();
        }
        
        if ( player.isdisconnectplayer )
        {
            continue;
        }
        
        player clearaccessory();
        player takeallweapons();
        player giveweapon( fistsweapon );
        player switchtoweaponimmediate( fistsweapon );
    }
    
    function_545d6ebbda3a8121();
    clearplayerwind();
    thread function_4d57a4a4954d94ac();
}

// Namespace br_ending_chopper2
// Params 0
// Checksum 0xe75ddf3e, Offset: 0x7759
// Size: 0x158
function function_4d57a4a4954d94ac()
{
    previousscenename = "scene6";
    targetscenename = "scene56";
    var_547a1a53c1d79521 = 0;
    accoladetime = 0;
    
    foreach ( pack in self.packs )
    {
        if ( pack.anime == targetscenename )
        {
            break;
        }
        
        if ( !var_547a1a53c1d79521 && pack.anime == previousscenename )
        {
            var_547a1a53c1d79521 = 1;
            continue;
        }
        
        if ( var_547a1a53c1d79521 )
        {
            if ( isdefined( pack.xcamasset ) )
            {
                xcamlength = getxcamlength( pack.xcamasset );
                accoladetime += xcamlength;
                continue;
            }
            
            animlength = getanimlength( level.scr_anim[ "endingCam" ][ pack.anime ] );
            accoladetime += animlength;
        }
    }
    
    accoladetime -= accoladetime % 0.05;
    level thread function_8a8b2f8750054e86( accoladetime );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x2d63c062, Offset: 0x78b9
// Size: 0x178
function hideallbutfocusplayer( array )
{
    if ( array.size > 0 )
    {
        playernumber = array[ 0 ];
        
        if ( isdefined( playernumber ) )
        {
            foreach ( winner in self.winners )
            {
                if ( isplayer( winner ) )
                {
                    if ( winner getentitynumber() == playernumber )
                    {
                        winner player_utility::function_b54a1e23734ef07();
                        winner player_utility::function_4688d689820ff1ed( "br_ending_chopper2::hideAllButFocusPlayer()" );
                        continue;
                    }
                    
                    winner player_utility::function_dbe5a52a6654a982();
                    winner player_utility::function_9d378d725bb4831e( "br_ending_chopper2::hideAllButFocusPlayer()" );
                }
            }
            
            foreach ( rig in self.player_rigs )
            {
                if ( rig.playernum == playernumber )
                {
                    rig br_ending_util::function_e5548380733078a6( 0, 1 );
                    continue;
                }
                
                rig br_ending_util::function_e5548380733078a6( 1, 1 );
            }
        }
    }
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xc5c09993, Offset: 0x7a39
// Size: 0x38
function assistsstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_assists" );
    hideallbutfocusplayer( array );
    self.npc show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x67805ca6, Offset: 0x7a79
// Size: 0x1c
function function_2dbdf6bb702339fd( array )
{
    self.npc hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x342dbb21, Offset: 0x7a9d
// Size: 0x38
function biggunsstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_bigguns" );
    hideallbutfocusplayer( array );
    self.turret show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x734ff5a5, Offset: 0x7add
// Size: 0x1c
function function_197fafb3609caaea( array )
{
    self.turret hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x5dbb9efc, Offset: 0x7b01
// Size: 0x38
function interrogatorstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_interrogator" );
    hideallbutfocusplayer( array );
    self.phones show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xf9904de4, Offset: 0x7b41
// Size: 0x1c
function function_9e6b3fea6d611a6f( array )
{
    self.phones hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x22121c73, Offset: 0x7b65
// Size: 0x38
function survivorstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_survivor" );
    hideallbutfocusplayer( array );
    self.npc show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x48f49cc7, Offset: 0x7ba5
// Size: 0x1c
function function_24b55530295d7967( array )
{
    self.npc hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x1a253112, Offset: 0x7bc9
// Size: 0x38
function commandostartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_commando" );
    hideallbutfocusplayer( array );
    self.shotgun show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x159d60d1, Offset: 0x7c09
// Size: 0x1c
function function_71fe78090b561257( array )
{
    self.shotgun hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x559c7058, Offset: 0x7c2d
// Size: 0x38
function killerstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_killer" );
    hideallbutfocusplayer( array );
    self.pistol show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x9408078a, Offset: 0x7c6d
// Size: 0x1c
function function_b651854398d29cec( array )
{
    self.pistol hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x89cd626, Offset: 0x7c91
// Size: 0x38
function assassinstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_assassin" );
    hideallbutfocusplayer( array );
    self.knife show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xf776c0b8, Offset: 0x7cd1
// Size: 0x1c
function function_1fe1e0b856ce92a2( array )
{
    self.knife hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xdefc1789, Offset: 0x7cf5
// Size: 0x38
function machiniststartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_machinist" );
    hideallbutfocusplayer( array );
    self.trophy show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xe5740b1f, Offset: 0x7d35
// Size: 0x1c
function function_91b83ce8b55d6a67( array )
{
    self.trophy hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x98525bbb, Offset: 0x7d59
// Size: 0x46
function pyrostartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_pyro" );
    hideallbutfocusplayer( array );
    self.molotov show();
    self.lighter show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x331e9313, Offset: 0x7da7
// Size: 0x2c
function function_cea7e4112c0490d5( array )
{
    self.molotov hide( 1 );
    self.lighter hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x41b79c08, Offset: 0x7ddb
// Size: 0x38
function breacherstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_breacher" );
    hideallbutfocusplayer( array );
    self.map show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xfa936987, Offset: 0x7e1b
// Size: 0x1c
function function_5457d5e2b44b6e97( array )
{
    self.map hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xde702d8c, Offset: 0x7e3f
// Size: 0x38
function moneybagsstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_moneybags" );
    hideallbutfocusplayer( array );
    self.duffels show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xf8dad023, Offset: 0x7e7f
// Size: 0x1c
function function_694951e706aa270c( array )
{
    self.duffels hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x932eca1, Offset: 0x7ea3
// Size: 0x38
function marksmanstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_marksman" );
    hideallbutfocusplayer( array );
    self.ar show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xb935731b, Offset: 0x7ee3
// Size: 0x1c
function function_7d29049118ed480b( array )
{
    self.ar hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xdc39088e, Offset: 0x7f07
// Size: 0x38
function sniperstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_sniper" );
    hideallbutfocusplayer( array );
    self.sniper show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x4ea832e6, Offset: 0x7f47
// Size: 0x1c
function function_2383c5cf981aeecc( array )
{
    self.sniper hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x60d04c74, Offset: 0x7f6b
// Size: 0x38
function scoutstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_scout" );
    hideallbutfocusplayer( array );
    self.tablet show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x452e580d, Offset: 0x7fab
// Size: 0x1c
function function_ba0ebb389cf33f37( array )
{
    self.tablet hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x6e65ec6d, Offset: 0x7fcf
// Size: 0x38
function teamobjectivesstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_team_objectives" );
    hideallbutfocusplayer( array );
    self.laptop show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x43b31856, Offset: 0x800f
// Size: 0x1c
function function_e4e738dce43260c6( array )
{
    self.laptop hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x94182c67, Offset: 0x8033
// Size: 0x54
function trapperstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_trapper" );
    hideallbutfocusplayer( array );
    self.claymore show();
    self.claymore_stack show();
    self.c4_stack show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x299dd9e6, Offset: 0x808f
// Size: 0x3c
function function_694df9fa97ac390b( array )
{
    self.claymore hide( 1 );
    self.claymore_stack hide( 1 );
    self.c4_stack hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xa6c3f290, Offset: 0x80d3
// Size: 0x70
function scavengerstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_scavenger" );
    hideallbutfocusplayer( array );
    self.sniper show();
    self.shotgun show();
    self.pistol show();
    self.ar show();
    self.duffels show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xa9faca6d, Offset: 0x814b
// Size: 0x5c
function function_2246bd4fc9e8431d( array )
{
    self.sniper hide( 1 );
    self.shotgun hide( 1 );
    self.pistol hide( 1 );
    self.ar hide( 1 );
    self.duffels hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x69562a95, Offset: 0x81af
// Size: 0x8c
function supplierstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_supplier" );
    hideallbutfocusplayer( array );
    self.sniper show();
    self.shotgun show();
    self.pistol show();
    self.ar show();
    self.duffels show();
    self.vest show();
    self.npc2 show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x77868d50, Offset: 0x8243
// Size: 0x7c
function function_24c7f1ecd07cb309( array )
{
    self.sniper hide( 1 );
    self.shotgun hide( 1 );
    self.pistol hide( 1 );
    self.ar hide( 1 );
    self.duffels hide( 1 );
    self.vest hide( 1 );
    self.npc2 hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x787399f9, Offset: 0x82c7
// Size: 0x38
function medicstartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_medic" );
    hideallbutfocusplayer( array );
    self.stim show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x1af19467, Offset: 0x8307
// Size: 0x1c
function function_90192778a7b6e0fb( array )
{
    self.stim hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x6077e6c4, Offset: 0x832b
// Size: 0x38
function ghoststartfunc( array )
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_accolade_ghost" );
    hideallbutfocusplayer( array );
    self.dogtags show();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x7ef50da2, Offset: 0x836b
// Size: 0x1c
function function_9f850dbe7c6e6cbc( array )
{
    self.dogtags hide( 1 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xe50f746c, Offset: 0x838f
// Size: 0xce
function function_8a8b2f8750054e86( accoladetime = 0 )
{
    if ( accoladetime > 1.5 )
    {
        waittime = accoladetime - 1.5;
        wait waittime;
    }
    
    foreach ( player in level.players )
    {
        player clearclienttriggeraudiozone( 1.5 );
    }
    
    audio_utility::function_63bf1584c79c055( level.players, "scn_br_palfa_exfil_outro" );
    clearmusicstate();
}

// Namespace br_ending_chopper2
// Params 0
// Checksum 0x9e2223bf, Offset: 0x8465
// Size: 0xb8
function function_b77f149ea834670d()
{
    level waittill( #"br_credits_complete" );
    delaytime = getdvarfloat( @"hash_c88b807ea15b731f", 0 );
    fadedowntime = getdvarfloat( @"hash_a1ceffe4417264d1", 1 );
    fadeholdtime = getdvarfloat( @"hash_c9f5c9db0c714fae", 2 );
    fadeuptime = getdvarfloat( @"hash_4633bce56a15979a", 1 );
    
    if ( delaytime > 0 )
    {
        wait delaytime;
    }
    
    level.var_c9629f760ada35ea = 1;
    level thread br_ending_util::function_e89c7c78b10aa4a( fadedowntime, fadeholdtime, fadeuptime );
    
    if ( fadedowntime > 0 )
    {
        wait fadedowntime;
    }
    
    level notify( #"br_ending_skip_scene" );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x8a59848d, Offset: 0x8525
// Size: 0x18
function function_7648d828712a9f90( val )
{
    level notify( #"br_credits_complete" );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xf318bc8e, Offset: 0x8545
// Size: 0xfe
function outrofunc( array )
{
    if ( getdvarint( @"hash_b44ba42bba42b79e", 1 ) )
    {
        foreach ( player in level.players )
        {
            player clearpredictedstreampos();
        }
    }
    
    player_utility::_visionsetnaked( "", 0 );
    hwconfiguratorremoveasset( %"hash_270c7fe96829828b" );
    hwconfiguratoraddasset( %"hash_2d625fb2f0ff42fb" );
    
    if ( !br_public::isanytutorialorbotpracticematch() )
    {
        setomnvarforallclients( "post_game_state", 14 );
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    }
    
    level ui::lui_registercallback( "br_credits_complete", &function_7648d828712a9f90 );
    level thread function_b77f149ea834670d();
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0xbfeaae2f, Offset: 0x864b
// Size: 0x4c
function outroendfunc( array )
{
    if ( !level.var_c9629f760ada35ea )
    {
        level thread br_ending_util::function_e89c7c78b10aa4a( undefined, 2, 1 );
    }
    
    level.var_c9629f760ada35ea = undefined;
    hwconfiguratorremoveasset( %"hash_2d625fb2f0ff42fb" );
    level thread function_7f7b1eab3d58d251();
}

// Namespace br_ending_chopper2
// Params 0
// Checksum 0x5b9bb1af, Offset: 0x869f
// Size: 0x3d
function function_7f7b1eab3d58d251()
{
    wait 60;
    soundbank = utility::callsharedfunc( #"hash_c2ceec7db51f55c1", #"getexfilsoundbank" ) ?? "mp_gamemode_br_exfils";
    audio_utility::snd_transient_unload( soundbank );
}

// Namespace br_ending_chopper2
// Params 0
// Checksum 0xca4f3e47, Offset: 0x86e4
// Size: 0x1a
function get_chopperexfil_transient()
{
    return utility::callsharedfunc( #"hash_c2ceec7db51f55c1", #"get_exfil_transient" );
}

// Namespace br_ending_chopper2
// Params 0
// Checksum 0xd10c9bba, Offset: 0x8707
// Size: 0x156
function accolades_init()
{
    function_c98a0498c8c97021( "assists", &function_c07632cf73b60d41 );
    function_c98a0498c8c97021( "bigguns", &function_abf555a180986d4b );
    function_c98a0498c8c97021( "interrogator", &function_f6ebbf00d6fe8a68 );
    function_c98a0498c8c97021( "survivor", &function_e92b129a754fa168 );
    function_c98a0498c8c97021( "commando", &function_24bb5ae09b7a1f50 );
    function_c98a0498c8c97021( "killer", &function_ed987d3bea07c011 );
    function_c98a0498c8c97021( "assassin", &function_41d5b353e6b0a46f );
    function_c98a0498c8c97021( "machinist", &function_15b4ea45652ce23c );
    function_c98a0498c8c97021( "pyro", &function_3cb6b0901e5d5bb6 );
    function_c98a0498c8c97021( "breacher", &function_b19b6fee76cdc234 );
    function_c98a0498c8c97021( "moneybags", &function_2594a615b9f55b25 );
    function_c98a0498c8c97021( "marksman", &function_b8c452c3973e6960 );
    function_c98a0498c8c97021( "sniper", &function_4f7765832172dd5 );
    function_c98a0498c8c97021( "scout", &function_17ea2a3d991ae210 );
    function_c98a0498c8c97021( "teamobjectives", &function_6873f81c30ccb893 );
    function_c98a0498c8c97021( "trapper", &function_fc9209844cc78898 );
    function_c98a0498c8c97021( "scavenger", &function_70f5cacf43461cda );
    function_c98a0498c8c97021( "supplier", &function_f488a6c1164edf52 );
    function_c98a0498c8c97021( "medic", &function_7f5f50e3482c9cc8 );
    function_c98a0498c8c97021( "ghost", &function_b87e89b29ba6bf31 );
}

// Namespace br_ending_chopper2
// Params 1
// Checksum 0x2e92c75f, Offset: 0x8865
// Size: 0x121
function function_8bc7500bcaa8a30a( n )
{
    foreach ( accoladestruct in level.var_2dd8c7a5ed41f9d9 )
    {
        accoladeref = accoladestruct.ref;
        player = accoladestruct.player;
        accoladedata = level.var_c99fd4f0f41403f8[ accoladeref ];
        assert( isdefined( accoladedata ) );
        assert( isdefined( accoladedata.name ) );
        assert( isdefined( level.var_391b7f5537bbf1a7 ) );
        var_e87d589e365341a = level.var_391b7f5537bbf1a7[ accoladedata.name ];
        assert( isdefined( var_e87d589e365341a ) );
        n = [[ var_e87d589e365341a ]]( n, player );
    }
    
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0xc0221785, Offset: 0x898f
// Size: 0xe3
function function_8007a474b1bddea1( player, array )
{
    assert( isdefined( array ) );
    assert( array.size == 2 );
    assert( isstring( array[ 0 ] ) );
    accoladeref = array[ 0 ];
    var_8a8cec2053930b6c = array[ 1 ];
    accoladeindex = level.var_3abb05bb58a5e16e[ accoladeref ];
    assert( isdefined( accoladeindex ) );
    assert( accoladeindex >= 0 && accoladeindex < 256 );
    var_8cdadf7b291501d7 = 0;
    
    if ( isdefined( var_8a8cec2053930b6c ) )
    {
        var_8cdadf7b291501d7 = var_8a8cec2053930b6c getentitynumber();
    }
    
    assert( var_8cdadf7b291501d7 >= 0 && var_8cdadf7b291501d7 < 256 );
    omnvarvalue = var_8cdadf7b291501d7;
    omnvarvalue |= accoladeindex << 8;
    player setclientomnvar( "ui_br_infil_exfil_player_focus", omnvarvalue );
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x3a757d86, Offset: 0x8a7a
// Size: 0x1ce
function function_c07632cf73b60d41( n, player )
{
    assert( isdefined( self.npc ) );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "assists" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 48 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &assistsstartfunc );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_2dbdf6bb702339fd );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "assists", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_assists_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_assists_operator01_sh010" ], level.br_anim[ "wz_iw9_exfil_acc_assists_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.npc, level.br_anim[ "wz_iw9_exfil_acc_assists_operator02_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_assists_camera_sh010" ], "wz_IW9_exfil_acc_assists_xcam_sh010" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x6362261c, Offset: 0x8c51
// Size: 0x1ee
function function_abf555a180986d4b( n, player )
{
    if ( !isdefined( self.turret ) )
    {
        self.turret = br_ending_util::spawn_script_model( "weapon_vm_mg_sentry_turret_exfil" );
        self.turret hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "biggunsA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 40 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &biggunsstartfunc );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_197fafb3609caaea );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "bigguns", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_bigguns_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_bigguns_operator01_sh010" ], level.br_anim[ "wz_iw9_exfil_acc_bigguns_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.turret, level.br_anim[ "wz_iw9_exfil_acc_bigguns_mg_sentry_turret_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_bigguns_camera_sh010" ], "wz_iw9_exfil_acc_bigguns_xcam_sh010" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0xe5eab4c1, Offset: 0x8e48
// Size: 0x2ff
function function_f6ebbf00d6fe8a68( n, player )
{
    if ( !isdefined( self.phones ) )
    {
        self.phones = br_ending_util::spawn_script_model( "offhand1h_smartphone_exfil" );
        self.phones hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "interrogatorA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &interrogatorstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "interrogator", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_interrogator_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_interrogator_operator01_sh010" ], level.br_anim[ "wz_iw9_exfil_acc_interrogator_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.phones, level.br_anim[ "wz_iw9_exfil_acc_interrogator_smphones_01_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_interrogator_camera_sh010" ], "wz_iw9_exfil_acc_interrogator_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "interrogatorB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_9e6b3fea6d611a6f );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_interrogator_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_interrogator_operator01_sh020" ], level.br_anim[ "wz_iw9_exfil_acc_interrogator_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.phones, level.br_anim[ "wz_iw9_exfil_acc_interrogator_smphones_01_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_interrogator_camera_sh020" ], "wz_iw9_exfil_acc_interrogator_xcam_sh020" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x87de4bd9, Offset: 0x9150
// Size: 0x1ce
function function_e92b129a754fa168( n, player )
{
    assert( isdefined( self.npc ) );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "survivor" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 55 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &survivorstartfunc );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_24b55530295d7967 );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "survivor", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_survivor_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_survivor_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_survivor_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.npc, level.br_anim[ "wz_IW9_exfil_acc_survivor_operator02_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_survivor_camera_sh010" ], "wz_iw9_exfil_acc_survivor_xcam_sh010" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0xc082dcab, Offset: 0x9327
// Size: 0x521
function function_24bb5ae09b7a1f50( n, player )
{
    if ( !isdefined( self.shotgun ) )
    {
        self.shotgun = br_ending_util::spawn_script_model( "wpn_vm_p12_sh_mike1014_exfil" );
        self.shotgun hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "commandoA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &commandostartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "commando", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_commando_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_commando_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_commando_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.shotgun, level.br_anim[ "wz_IW9_exfil_acc_commando_sh_mike1014_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_commando_camera_sh010" ], "wz_iw9_exfil_acc_commando_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "commandoB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_commando_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_commando_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_commando_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.shotgun, level.br_anim[ "wz_IW9_exfil_acc_commando_sh_mike1014_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_commando_camera_sh020" ], "wz_iw9_exfil_acc_commando_xcam_sh020" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "commandoC" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_commando_helicopter_sh030" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_commando_operator01_sh030" ], level.br_anim[ "wz_IW9_exfil_acc_commando_operator01_fem_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.shotgun, level.br_anim[ "wz_IW9_exfil_acc_commando_sh_mike1014_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_commando_camera_sh030" ], "wz_iw9_exfil_acc_commando_xcam_sh030" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "commandoD" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_71fe78090b561257 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_commando_helicopter_sh040" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_commando_operator01_sh040" ], level.br_anim[ "wz_IW9_exfil_acc_commando_operator01_fem_sh040" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.shotgun, level.br_anim[ "wz_IW9_exfil_acc_commando_sh_mike1014_sh040" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_commando_camera_sh040" ], "wz_iw9_exfil_acc_commando_xcam_sh040" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0xd9900654, Offset: 0x9851
// Size: 0x410
function function_ed987d3bea07c011( n, player )
{
    if ( !isdefined( self.pistol ) )
    {
        self.pistol = br_ending_util::spawn_script_model( "wpn_vm_p27_pi_papa220_exfil" );
        self.pistol hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "killerA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 42 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &killerstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "killer", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_killer_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_killer_operator01_sh010" ], level.br_anim[ "wz_iw9_exfil_acc_killer_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.pistol, level.br_anim[ "wz_iw9_exfil_acc_killer_pipapa220_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_killer_camera_sh010" ], "wz_iw9_exfil_acc_killer_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "killerB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 42 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_killer_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_killer_operator01_sh020" ], level.br_anim[ "wz_iw9_exfil_acc_killer_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.pistol, level.br_anim[ "wz_iw9_exfil_acc_killer_pipapa220_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_killer_camera_sh020" ], "wz_iw9_exfil_acc_killer_xcam_sh020" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "killerC" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 65 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_b651854398d29cec );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_killer_helicopter_sh030" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_killer_operator01_sh030" ], level.br_anim[ "wz_iw9_exfil_acc_killer_operator01_fem_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.pistol, level.br_anim[ "wz_iw9_exfil_acc_killer_pipapa220_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_killer_camera_sh030" ], "wz_iw9_exfil_acc_killer_xcam_sh030" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x11fd9356, Offset: 0x9c6a
// Size: 0x410
function function_41d5b353e6b0a46f( n, player )
{
    if ( !isdefined( self.knife ) )
    {
        self.knife = br_ending_util::spawn_script_model( "att_wm_p33_me_tac_knife02_exfil" );
        self.knife hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "assassinA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &assassinstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "assassin", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_assassin_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_assassin_operator01_sh010" ], level.br_anim[ "wz_iw9_exfil_acc_assassin_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.knife, level.br_anim[ "wz_iw9_exfil_acc_assassin_knife_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_assassin_camera_sh010" ], "wz_iw9_exfil_acc_assassin_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "assassinB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_assassin_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_assassin_operator01_sh020" ], level.br_anim[ "wz_iw9_exfil_acc_assassin_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.knife, level.br_anim[ "wz_iw9_exfil_acc_assassin_knife_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_assassin_camera_sh020" ], "wz_iw9_exfil_acc_assassin_xcam_sh020" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "assassinC" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_1fe1e0b856ce92a2 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_assassin_helicopter_sh030" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_assassin_operator01_sh030" ], level.br_anim[ "wz_iw9_exfil_acc_assassin_operator01_fem_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.knife, level.br_anim[ "wz_iw9_exfil_acc_assassin_knife_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_assassin_camera_sh030" ], "wz_iw9_exfil_acc_assassin_xcam_sh030" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x971eaa68, Offset: 0xa083
// Size: 0x2ff
function function_15b4ea45652ce23c( n, player )
{
    if ( !isdefined( self.trophy ) )
    {
        self.trophy = br_ending_util::spawn_script_model( "offhand_2h_vm_trophy_system_exfil" );
        self.trophy hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "machinistA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 55 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &machiniststartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "machinist", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_machinist_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_machinist_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_machinist_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.trophy, level.br_anim[ "wz_IW9_exfil_acc_machinist_2htrophy_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_machinist_camera_sh010" ], "wz_iw9_exfil_acc_machinist_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "machinistB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 65 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_91b83ce8b55d6a67 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_machinist_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_machinist_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_machinist_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.trophy, level.br_anim[ "wz_IW9_exfil_acc_machinist_2htrophy_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_machinist_camera_sh020" ], "wz_iw9_exfil_acc_machinist_xcam_sh020" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0xa70984fc, Offset: 0xa38b
// Size: 0x4c3
function function_3cb6b0901e5d5bb6( n, player )
{
    if ( !isdefined( self.molotov ) )
    {
        self.molotov = br_ending_util::spawn_script_model( "offhand_2h_vm_molotov_exfil" );
        self.molotov hide( 1 );
    }
    
    if ( !isdefined( self.lighter ) )
    {
        self.lighter = br_ending_util::spawn_script_model( "equipment_lighter_wm_exfil" );
        self.lighter hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "pyroA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 40 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &pyrostartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "pyro", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_pyro_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_pyro_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_pyro_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.molotov, level.br_anim[ "wz_IW9_exfil_acc_pyro_molotov_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.lighter, level.br_anim[ "wz_IW9_exfil_acc_pyro_lighter_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_pyro_camera_sh010" ], "wz_iw9_exfil_acc_pyro_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "pyroB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 40 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_pyro_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_pyro_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_pyro_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.molotov, level.br_anim[ "wz_IW9_exfil_acc_pyro_molotov_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.lighter, level.br_anim[ "wz_IW9_exfil_acc_pyro_lighter_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_pyro_camera_sh020" ], "wz_iw9_exfil_acc_pyro_xcam_sh020" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "pyroC" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 40 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_cea7e4112c0490d5 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_pyro_helicopter_sh030" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_pyro_operator01_sh030" ], level.br_anim[ "wz_IW9_exfil_acc_pyro_operator01_fem_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.molotov, level.br_anim[ "wz_IW9_exfil_acc_pyro_molotov_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.lighter, level.br_anim[ "wz_IW9_exfil_acc_pyro_lighter_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_pyro_camera_sh030" ], "wz_iw9_exfil_acc_pyro_xcam_sh030" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x5199a08b, Offset: 0xa857
// Size: 0x2ff
function function_b19b6fee76cdc234( n, player )
{
    if ( !isdefined( self.map ) )
    {
        self.map = br_ending_util::spawn_script_model( "accessory_paper_wall_map_exfil" );
        self.map hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "breacherA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 65 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &breacherstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "breacher", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_breacher_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_breacher_operator01_sh010" ], level.br_anim[ "wz_iw9_exfil_acc_breacher_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.map, level.br_anim[ "wz_iw9_exfil_acc_breacher_map_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_breacher_camera_sh010" ], "wz_iw9_exfil_acc_breacher_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "breacherB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 65 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_5457d5e2b44b6e97 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_iw9_exfil_acc_breacher_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_iw9_exfil_acc_breacher_operator01_sh020" ], level.br_anim[ "wz_iw9_exfil_acc_breacher_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.map, level.br_anim[ "wz_iw9_exfil_acc_breacher_map_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_iw9_exfil_acc_breacher_camera_sh020" ], "wz_iw9_exfil_acc_breacher_xcam_sh020" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x91f07ce0, Offset: 0xab5f
// Size: 0x410
function function_2594a615b9f55b25( n, player )
{
    if ( !isdefined( self.duffels ) )
    {
        self.duffels = br_ending_util::spawn_script_model( "accessory_money_bag_large_exfil" );
        self.duffels hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "moneybagsA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 40 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &moneybagsstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "moneybags", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_moneybags_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_moneybags_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_moneybags_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.duffels, level.br_anim[ "wz_IW9_exfil_acc_moneybags_moneybag01_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_moneybags_camera_sh010" ], "wz_iw9_exfil_acc_moneybags_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "moneybagsB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 40 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_moneybags_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_moneybags_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_moneybags_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.duffels, level.br_anim[ "wz_IW9_exfil_acc_moneybags_moneybag01_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_moneybags_camera_sh020" ], "wz_iw9_exfil_acc_moneybags_xcam_sh020" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "moneybagsC" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 55 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_694951e706aa270c );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_moneybags_helicopter_sh030" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_moneybags_operator01_sh030" ], level.br_anim[ "wz_IW9_exfil_acc_moneybags_operator01_fem_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.duffels, level.br_anim[ "wz_IW9_exfil_acc_moneybags_moneybag01_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_moneybags_camera_sh030" ], "wz_iw9_exfil_acc_moneybags_xcam_sh030" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0xf2c05478, Offset: 0xaf78
// Size: 0x410
function function_b8c452c3973e6960( n, player )
{
    if ( !isdefined( self.ar ) )
    {
        self.ar = br_ending_util::spawn_script_model( "wpn_wm_p01_ar_mike4_exfil" );
        self.ar hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "marksmanA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 40 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &marksmanstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "marksman", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_marksman_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_marksman_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_marksman_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.ar, level.br_anim[ "wz_IW9_exfil_acc_marksman_mike4_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_marksman_camera_sh010" ], "wz_iw9_exfil_acc_marksman_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "marksmanB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 55 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_marksman_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_marksman_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_marksman_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.ar, level.br_anim[ "wz_IW9_exfil_acc_marksman_mike4_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_marksman_camera_sh020" ], "wz_iw9_exfil_acc_marksman_xcam_sh020" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "marksmanC" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 65 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_7d29049118ed480b );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_marksman_helicopter_sh030" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_marksman_operator01_sh030" ], level.br_anim[ "wz_IW9_exfil_acc_marksman_operator01_fem_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.ar, level.br_anim[ "wz_IW9_exfil_acc_marksman_mike4_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_marksman_camera_sh030" ], "wz_iw9_exfil_acc_marksman_xcam_sh030" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0xc44dbdbd, Offset: 0xb391
// Size: 0x410
function function_4f7765832172dd5( n, player )
{
    if ( !isdefined( self.sniper ) )
    {
        self.sniper = br_ending_util::spawn_script_model( "weapon_wm_sn_alpha50_exfil" );
        self.sniper hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "sniperA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 55 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &sniperstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "sniper", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_sniper_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_sniper_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_sniper_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.sniper, level.br_anim[ "wz_IW9_exfil_acc_sniper_snalpha50_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_sniper_camera_sh010" ], "wz_iw9_exfil_acc_sniper_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "sniperB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_sniper_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_sniper_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_sniper_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.sniper, level.br_anim[ "wz_IW9_exfil_acc_sniper_snalpha50_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_sniper_camera_sh020" ], "wz_iw9_exfil_acc_sniper_xcam_sh020" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "sniperC" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 42 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_2383c5cf981aeecc );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_sniper_helicopter_sh030" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_sniper_operator01_sh030" ], level.br_anim[ "wz_IW9_exfil_acc_sniper_operator01_fem_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.sniper, level.br_anim[ "wz_IW9_exfil_acc_sniper_snalpha50_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_sniper_camera_sh030" ], "wz_iw9_exfil_acc_sniper_xcam_sh030" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x54f9e1f0, Offset: 0xb7aa
// Size: 0x410
function function_17ea2a3d991ae210( n, player )
{
    if ( !isdefined( self.tablet ) )
    {
        self.tablet = br_ending_util::spawn_script_model( "offhand_1h_vm_tablet_ui_v0" );
        self.tablet hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "scoutA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 35 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &scoutstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "scout", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_scout_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_scout_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_scout_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.tablet, level.br_anim[ "wz_IW9_exfil_acc_scout_tablet_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_scout_camera_sh010" ], "wz_iw9_exfil_acc_scout_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "scoutB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 45 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_scout_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_scout_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_scout_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.tablet, level.br_anim[ "wz_IW9_exfil_acc_scout_tablet_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_scout_camera_sh020" ], "wz_iw9_exfil_acc_scout_xcam_sh020" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "scoutC" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 65 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_ba0ebb389cf33f37 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_scout_helicopter_sh030" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_scout_operator01_sh030" ], level.br_anim[ "wz_IW9_exfil_acc_scout_operator01_fem_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.tablet, level.br_anim[ "wz_IW9_exfil_acc_scout_tablet_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_scout_camera_sh030" ], "wz_iw9_exfil_acc_scout_xcam_sh030" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x14269688, Offset: 0xbbc3
// Size: 0x410
function function_6873f81c30ccb893( n, player )
{
    if ( !isdefined( self.laptop ) )
    {
        self.laptop = br_ending_util::spawn_script_model( "device_laptop_exfil" );
        self.laptop hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "teamObjectivesA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 35 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &teamobjectivesstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "teamobjectives", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_team_objectives_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_team_objectives_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_team_objectives_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.laptop, level.br_anim[ "wz_IW9_exfil_acc_team_objectives_laptop_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_team_objectives_camera_sh010" ], "wz_IW9_exfil_acc_team_objectives_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "teamObjectivesB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 55 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_team_objectives_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_team_objectives_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_team_objectives_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.laptop, level.br_anim[ "wz_IW9_exfil_acc_team_objectives_laptop_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_team_objectives_camera_sh020" ], "wz_IW9_exfil_acc_team_objectives_xcam_sh020" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "teamObjectivesC" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 55 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_e4e738dce43260c6 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_team_objectives_helicopter_sh030" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_team_objectives_operator01_sh030" ], level.br_anim[ "wz_IW9_exfil_acc_team_objectives_operator01_fem_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.laptop, level.br_anim[ "wz_IW9_exfil_acc_team_objectives_laptop_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_team_objectives_camera_sh030" ], "wz_IW9_exfil_acc_team_objectives_xcam_sh030" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0xe8ad0e7, Offset: 0xbfdc
// Size: 0x40f
function function_fc9209844cc78898( n, player )
{
    if ( !isdefined( self.claymore ) )
    {
        self.claymore = br_ending_util::spawn_script_model( "offhand_2h_vm_c4_exfil" );
        self.claymore hide( 1 );
    }
    
    if ( !isdefined( self.claymore_stack ) )
    {
        self.claymore_stack = br_ending_util::spawn_script_model( "offhand_wm_claymore_stack_exfil" );
        self.claymore_stack hide( 1 );
    }
    
    if ( !isdefined( self.c4_stack ) )
    {
        self.c4_stack = br_ending_util::spawn_script_model( "offhand_wm_c4_stack_exfil" );
        self.c4_stack hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "trapperA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &trapperstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "trapper", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_trapper_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_trapper_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_trapper_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.claymore, level.br_anim[ "wz_IW9_exfil_acc_trapper_claymore_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.claymore_stack, level.br_anim[ "wz_IW9_exfil_acc_trapper_stack_claymore_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.c4_stack, level.br_anim[ "wz_IW9_exfil_acc_trapper_stack_c4_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_trapper_camera_sh010" ], "wz_iw9_exfil_acc_trapper_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "trapperB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 42 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_694df9fa97ac390b );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_trapper_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_trapper_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_trapper_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.claymore, level.br_anim[ "wz_IW9_exfil_acc_trapper_claymore_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.claymore_stack, level.br_anim[ "wz_IW9_exfil_acc_trapper_stack_claymore_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.c4_stack, level.br_anim[ "wz_IW9_exfil_acc_trapper_stack_c4_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_trapper_camera_sh020" ], "wz_iw9_exfil_acc_trapper_xcam_sh020" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x2bb0f2a, Offset: 0xc3f4
// Size: 0x6dc
function function_70f5cacf43461cda( n, player )
{
    if ( !isdefined( self.sniper ) )
    {
        self.sniper = br_ending_util::spawn_script_model( "weapon_wm_sn_alpha50_exfil" );
        self.sniper hide( 1 );
    }
    
    if ( !isdefined( self.shotgun ) )
    {
        self.shotgun = br_ending_util::spawn_script_model( "wpn_vm_p12_sh_mike1014_exfil" );
        self.shotgun hide( 1 );
    }
    
    if ( !isdefined( self.pistol ) )
    {
        self.pistol = br_ending_util::spawn_script_model( "wpn_vm_p27_pi_papa220_exfil" );
        self.pistol hide( 1 );
    }
    
    if ( !isdefined( self.ar ) )
    {
        self.ar = br_ending_util::spawn_script_model( "wpn_wm_p01_ar_mike4_exfil" );
        self.ar hide( 1 );
    }
    
    if ( !isdefined( self.duffels ) )
    {
        self.duffels = br_ending_util::spawn_script_model( "accessory_money_bag_large_exfil" );
        self.duffels hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "scavengerA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &scavengerstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "scavenger", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_scavenger_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_scavenger_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_scavenger_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.sniper, level.br_anim[ "wz_IW9_exfil_acc_scavenger_alpha50_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.shotgun, level.br_anim[ "wz_IW9_exfil_acc_scavenger_mike1014_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.pistol, level.br_anim[ "wz_IW9_exfil_acc_scavenger_papa220_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.ar, level.br_anim[ "wz_IW9_exfil_acc_scavenger_mike4_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.duffels, level.br_anim[ "wz_IW9_exfil_acc_scavenger_money_bag_large_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_scavenger_camera_sh010" ], "wz_iw9_exfil_acc_scavenger_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "scavengerB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 50 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_scavenger_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_scavenger_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_scavenger_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.sniper, level.br_anim[ "wz_IW9_exfil_acc_scavenger_alpha50_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.shotgun, level.br_anim[ "wz_IW9_exfil_acc_scavenger_mike1014_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.pistol, level.br_anim[ "wz_IW9_exfil_acc_scavenger_papa220_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.ar, level.br_anim[ "wz_IW9_exfil_acc_scavenger_mike4_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.duffels, level.br_anim[ "wz_IW9_exfil_acc_scavenger_money_bag_large_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_scavenger_camera_sh020" ], "wz_iw9_exfil_acc_scavenger_xcam_sh020" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "scavengerC" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 42 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_2246bd4fc9e8431d );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_scavenger_helicopter_sh030" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_scavenger_operator01_sh030" ], level.br_anim[ "wz_IW9_exfil_acc_scavenger_operator01_fem_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.sniper, level.br_anim[ "wz_IW9_exfil_acc_scavenger_alpha50_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.shotgun, level.br_anim[ "wz_IW9_exfil_acc_scavenger_mike1014_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.pistol, level.br_anim[ "wz_IW9_exfil_acc_scavenger_papa220_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.ar, level.br_anim[ "wz_IW9_exfil_acc_scavenger_mike4_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.duffels, level.br_anim[ "wz_IW9_exfil_acc_scavenger_money_bag_large_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_scavenger_camera_sh030" ], "wz_iw9_exfil_acc_scavenger_xcam_sh030" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x9ed7b97d, Offset: 0xcad9
// Size: 0x60f
function function_f488a6c1164edf52( n, player )
{
    assert( isdefined( self.npc2 ) );
    
    if ( !isdefined( self.sniper ) )
    {
        self.sniper = br_ending_util::spawn_script_model( "weapon_wm_sn_alpha50_exfil" );
        self.sniper hide( 1 );
    }
    
    if ( !isdefined( self.shotgun ) )
    {
        self.shotgun = br_ending_util::spawn_script_model( "wpn_vm_p12_sh_mike1014_exfil" );
        self.shotgun hide( 1 );
    }
    
    if ( !isdefined( self.pistol ) )
    {
        self.pistol = br_ending_util::spawn_script_model( "wpn_vm_p27_pi_papa220_exfil" );
        self.pistol hide( 1 );
    }
    
    if ( !isdefined( self.ar ) )
    {
        self.ar = br_ending_util::spawn_script_model( "wpn_wm_p01_ar_mike4_exfil" );
        self.ar hide( 1 );
    }
    
    if ( !isdefined( self.duffels ) )
    {
        self.duffels = br_ending_util::spawn_script_model( "accessory_money_bag_large_exfil" );
        self.duffels hide( 1 );
    }
    
    if ( !isdefined( self.vest ) )
    {
        self.vest = br_ending_util::spawn_script_model( "props_armor_pickup_light_exfil" );
        self.vest hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "supplierA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 35 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &supplierstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "supplier", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_supplier_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_supplier_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_supplier_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.sniper, level.br_anim[ "wz_IW9_exfil_acc_supplier_alpha50_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.shotgun, level.br_anim[ "wz_IW9_exfil_acc_supplier_mike1014_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.pistol, level.br_anim[ "wz_IW9_exfil_acc_supplier_papa220_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.ar, level.br_anim[ "wz_IW9_exfil_acc_supplier_mike4_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.duffels, level.br_anim[ "wz_IW9_exfil_acc_supplier_money_bag_large_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.vest, level.br_anim[ "wz_IW9_exfil_acc_supplier_vest_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.npc2, level.br_anim[ "wz_IW9_exfil_acc_supplier_operator02_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_supplier_camera_sh010" ], "wz_iw9_exfil_acc_supplier_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "supplierB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 42 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_24c7f1ecd07cb309 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_supplier_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_supplier_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_supplier_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.sniper, level.br_anim[ "wz_IW9_exfil_acc_supplier_alpha50_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.shotgun, level.br_anim[ "wz_IW9_exfil_acc_supplier_mike1014_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.pistol, level.br_anim[ "wz_IW9_exfil_acc_supplier_papa220_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.ar, level.br_anim[ "wz_IW9_exfil_acc_supplier_mike4_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.duffels, level.br_anim[ "wz_IW9_exfil_acc_supplier_money_bag_large_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.vest, level.br_anim[ "wz_IW9_exfil_acc_supplier_vest_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.npc2, level.br_anim[ "wz_IW9_exfil_acc_supplier_operator02_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_supplier_camera_sh020" ], "wz_iw9_exfil_acc_supplier_xcam_sh020" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0xf03985c7, Offset: 0xd0f1
// Size: 0x2ff
function function_7f5f50e3482c9cc8( n, player )
{
    if ( !isdefined( self.stim ) )
    {
        self.stim = br_ending_util::spawn_script_model( "weapon_wm_stim_exfil" );
        self.stim hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "medicA" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 48 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &medicstartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "medic", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_medic_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_medic_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_medic_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.stim, level.br_anim[ "wz_IW9_exfil_acc_medic_stim_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_medic_camera_sh010" ], "wz_iw9_exfil_acc_medic_xcam_sh010" );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "medicB" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 65 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_90192778a7b6e0fb );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_medic_helicopter_sh020" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_medic_operator01_sh020" ], level.br_anim[ "wz_IW9_exfil_acc_medic_operator01_fem_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.stim, level.br_anim[ "wz_IW9_exfil_acc_medic_stim_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_medic_camera_sh020" ], "wz_iw9_exfil_acc_medic_xcam_sh020" );
    return n;
}

// Namespace br_ending_chopper2
// Params 2
// Checksum 0x366c0d, Offset: 0xd3f9
// Size: 0x1ee
function function_b87e89b29ba6bf31( n, player )
{
    if ( !isdefined( self.dogtags ) )
    {
        self.dogtags = br_ending_util::spawn_script_model( "c_t10_gear_usa_dogtag_exfil" );
        self.dogtags hide( 1 );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "ghost" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::set_pack_fov( 48 );
    self.packs[ n ] br_ending_util::function_19d9726ab575306d( 0.25 );
    self.packs[ n ] br_ending_util::function_6bebfdad268ca836( 0.25 );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [ player getentitynumber() ], &ghoststartfunc );
    self.packs[ n ] br_ending_util::function_9597cbd14a6857e3( [ "ghost", player ], &function_8007a474b1bddea1 );
    self.packs[ n ] br_ending_util::function_97184132912f1dc3( [], &function_9f850dbe7c6e6cbc );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.exfilchopper, level.br_anim[ "wz_IW9_exfil_acc_ghost_helicopter_sh010" ] );
    self.packs[ n ] br_ending_util::function_cac49eb1af86a29e( self.lightingrig );
    self.packs[ n ] br_ending_util::add_pack_playeranim( player, level.br_anim[ "wz_IW9_exfil_acc_ghost_operator01_sh010" ], level.br_anim[ "wz_IW9_exfil_acc_ghost_operator01_fem_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( self.dogtags, level.br_anim[ "wz_IW9_exfil_acc_ghost_dogtag_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "wz_IW9_exfil_acc_ghost_camera_sh010" ], "wz_iw9_exfil_acc_ghost_xcam_sh010" );
    return n;
}

