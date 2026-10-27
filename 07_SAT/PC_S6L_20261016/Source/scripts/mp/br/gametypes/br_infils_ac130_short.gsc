// scripts\mp\br\gametypes\br_infils_ac130_short.gsc  (hash_49f2f7320be0f6b1.gscc) (size: 11570 Bytes / 0x2d32 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf46a7f23 (4100620067)
// size ...... 11570 (0x2d32)
// includes .. 5   (offset: 0x2902)
// strings ... 76  (offset: 0x292a)
// dev strs .. 0   (offset: 0x2d32)
// exports ... 20  (offset: 0x1d26)
// cseg ...... 0x72f + 0x15f7 (0x1d26)
// imports ... 71  (offset: 0x2046)
// animtree1 . 0   (offset: 0x2d32)
// animtree2 . 0   (offset: 0x2d32)
#using scripts\mp\br\gametypes\br_infils_common;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\music_and_dialog;

#namespace br_infils_ac130_short;

// Namespace br_infils_ac130_short
// Params 0
// Checksum 0xa9e2d455, Offset: 0x74d
// Size: 0x1a3
function init()
{
    assert( isdefined( level.infilstruct ) );
    
    /#
        setdevdvarifuninitialized( @"hash_bfded00ac93c45b7", 1 );
        setdevdvarifuninitialized( @"hash_7f1da0c3501cbdf2", 1 );
    #/
    
    level.infilstruct.c130model = "black::veh9_mil_air_cargo_plane_exterior_infil";
    level.infilstruct.var_f265685cdcfee833 = "veh9_mil_air_cargo_plane_interior_infil";
    level.infilstruct.var_9d24745d02be135e = "tag_body_animate";
    level.infilstruct.c130soundalias = "veh_br_infil_c17_distant_lp";
    level.infilstruct.var_ea87d0ead0c54f1c = 1;
    level.infilstruct.var_dfeffb86c1dd09b6 = 1;
    level.infilstruct.var_cee5041ecb30a2c5 = &function_fdfe0dc503c4f44;
    level.infilstruct.var_3bead1a95b75d55d = &function_2295b0f632c0d19d;
    level.infilstruct.jumpfunc = &jumpfunc;
    level.infilstruct.var_9a4f6a9353c9055c = &function_9a4f6a9353c9055c;
    orbitcamassets = [ "cam_orbit_br_infil_ac130_player1", "cam_orbit_br_infil_ac130_player2", "cam_orbit_br_infil_ac130_player3", "cam_orbit_br_infil_ac130_player4", "cam_orbit_br_infil_ac130_player1" ];
    br_infils_util::set_orbit_cam_info( orbitcamassets );
    br_infils_util::function_8e44037c2a8b1713( "prematch", &prematchstartfunc );
    br_infils_util::function_8e44037c2a8b1713( "fadedown", &fadedownfunc );
    game[ "dialog" ][ "infil_ac130_5_seconds" ] = "dx_br_dmzc_infl_ldms_drop";
}

// Namespace br_infils_ac130_short
// Params 1
// Checksum 0x88d145ac, Offset: 0x8f8
// Size: 0x9c2
function function_fdfe0dc503c4f44( movingc130 )
{
    animstruct = spawnstruct();
    animstruct.origin = getdvarvector( @"br_infil_anim_pos", ( 0, 0, 0 ) );
    animstruct.angles = ( 0, 0, 0 );
    animstruct.cleanupfunc = &infilcleanup;
    animstruct.var_751e0e63f6c6f6ec = &function_1ad287fcb5253b3c;
    animstruct.movingc130 = movingc130;
    animstruct.movingc130.animname = "movingC130";
    animstruct.camerarunner = animstruct br_infils_util::spawn_script_model( "generic_prop_x30", "camera" );
    animstruct.camerarunner.angles = getdvarvector( @"hash_a243c97d0dc94bd7", animstruct.camerarunner.angles );
    animstruct.camerarunner linkto( animstruct.movingc130, "tag_body_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 0 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag1" );
    animstruct.playertags[ 1 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag2" );
    animstruct.playertags[ 2 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag3" );
    animstruct.playertags[ 3 ] = animstruct br_infils_util::spawn_script_model( "tag_player", "playerTag4" );
    animstruct.playertags[ 0 ] linkto( animstruct.camerarunner, "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 1 ] linkto( animstruct.camerarunner, "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 2 ] linkto( animstruct.camerarunner, "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.playertags[ 3 ] linkto( animstruct.camerarunner, "j_prop_5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
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
    animstruct.packs = [];
    n = 0;
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

// Namespace br_infils_ac130_short
// Params 1
// Checksum 0x1962f2e2, Offset: 0x12c3
// Size: 0x3dc
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
            player setclientdvar( @"cg_fov", array[ 0 ] );
            player setclientdvar( @"cg_disable_user_fov", 1 );
        }
    }
}

// Namespace br_infils_ac130_short
// Params 1
// Checksum 0x6956105d, Offset: 0x16a7
// Size: 0x1c
function function_6997506bbd112cbe( array )
{
    function_2382a170e8bf0851( array );
    teleporttomovingplane();
}

// Namespace br_infils_ac130_short
// Params 0
// Checksum 0x88d1a714, Offset: 0x16cb
// Size: 0x23
function function_6fdcd4475087fc56()
{
    self.manualoverridewindmaterial = undefined;
    player::setwind( "1" );
    self setallstreamloaddist( 0 );
}

// Namespace br_infils_ac130_short
// Params 0
// Checksum 0x1b30ab2a, Offset: 0x16f6
// Size: 0x11d
function teleporttomovingplane()
{
    self.movingc130 setscriptablepartstate( "running_lights", "on" );
    setomnvar( "ui_hide_player_icons", 0 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setallstreamloaddist( 0 );
        player clearpredictedstreampos();
    }
    
    if ( isdefined( self.movingc130 ) )
    {
        if ( !level.infilstruct.var_df720711dd79fea7 || br_infils_util::function_7d2f9d2a086bd511() )
        {
            self.movingc130 notify( #"start_moving" );
        }
    }
    
    level notify( #"hash_c14217752dacdeed" );
    thread function_327cc5b9e5eeb626();
    br_infils_util::function_fffda20dc2c2df07( &function_6fdcd4475087fc56 );
}

// Namespace br_infils_ac130_short
// Params 0
// Checksum 0x574aaa75, Offset: 0x181b
// Size: 0xf
function function_327cc5b9e5eeb626()
{
    wait 0.1;
    function_8480689471b795a0();
}

// Namespace br_infils_ac130_short
// Params 0
// Checksum 0xbdd63c7b, Offset: 0x1832
// Size: 0x1a
function function_8480689471b795a0()
{
    self.movingc130 setscriptablepartstate( "int_lights_green_all", "on" );
}

// Namespace br_infils_ac130_short
// Params 0
// Checksum 0xaac38e45, Offset: 0x1854
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

// Namespace br_infils_ac130_short
// Params 0
// Checksum 0x357eece4, Offset: 0x1a62
// Size: 0x34
function jumpfunc()
{
    if ( getdvarint( @"hash_549df6ab370a2bc4", 1 ) )
    {
        self lerpfovscalefactor( 0, 0 );
        self setclientdvar( @"cg_disable_user_fov", 0 );
    }
}

// Namespace br_infils_ac130_short
// Params 0
// Checksum 0xac9982a6, Offset: 0x1a9e
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

// Namespace br_infils_ac130_short
// Params 0, eflags: 0x4
// Checksum 0xe863892f, Offset: 0x1b2a
// Size: 0x20
function private prematchstartfunc()
{
    level.nosuspensemusic = 1;
    thread music_and_dialog::stopsuspensemusic();
    audio_utility::snd_transient_load( "mp_gamemode_br_infils" );
}

// Namespace br_infils_ac130_short
// Params 0, eflags: 0x4
// Checksum 0x8b23c586, Offset: 0x1b52
// Size: 0xa
function private fadedownfunc()
{
    level thread function_818e211bb54ccc2a();
}

// Namespace br_infils_ac130_short
// Params 0, eflags: 0x4
// Checksum 0x360258d5, Offset: 0x1b64
// Size: 0x27
function private function_818e211bb54ccc2a()
{
    clearmusicstate();
    wait 2.5;
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_br_lobby_fade", 0 );
}

// Namespace br_infils_ac130_short
// Params 0
// Checksum 0x393da6a6, Offset: 0x1b93
// Size: 0x1c
function infilcleanup()
{
    br_infils_util::function_3855f5796f4d2b65();
    audio_utility::snd_transient_unload( "mp_gamemode_br_infils" );
    br_infils_common::cleanupents();
}

// Namespace br_infils_ac130_short
// Params 0
// Checksum 0xea998a38, Offset: 0x1bb7
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

// Namespace br_infils_ac130_short
// Params 1, eflags: 0x4
// Checksum 0x6870d297, Offset: 0x1c1b
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

// Namespace br_infils_ac130_short
// Params 1, eflags: 0x4
// Checksum 0x2906cb7c, Offset: 0x1cfc
// Size: 0x19
function private function_91ed8e384d4e1fa6( skinname )
{
    self function_ce21f4102d5d17f6( skinname, "iw9_avatar_scriptable_mp" );
}

// Namespace br_infils_ac130_short
// Params 0
// Checksum 0x43e902ec, Offset: 0x1d1d
// Size: 0x9
function function_60ca5349741930ba()
{
    self setallstreamloaddist( 0 );
}

