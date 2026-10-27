// script_53b7545c53ce9f5a  (hash_53b7545c53ce9f5a.gscc) (size: 12851 Bytes / 0x3233 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc80b01bd (3356164541)
// size ...... 12851 (0x3233)
// includes .. 5   (offset: 0x2f0f)
// strings ... 59  (offset: 0x2f37)
// dev strs .. 0   (offset: 0x3233)
// exports ... 31  (offset: 0x1fb7)
// cseg ...... 0x56e + 0x1a49 (0x1fb7)
// imports ... 88  (offset: 0x248f)
// animtree1 . 0   (offset: 0x3233)
// animtree2 . 0   (offset: 0x3233)
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\music_and_dialog;

#namespace namespace_56acda7adda17189;

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0x85c0bd96, Offset: 0x58c
// Size: 0x1c2
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
    level.infilstruct.play_scenesystem = &playscene;
    level.infilstruct.prestream_scenesystem = &prestream;
    level.infilstruct.var_3bead1a95b75d55d = &function_2295b0f632c0d19d;
    level.infilstruct.jumpfunc = &jumpfunc;
    level.infilstruct.var_9a4f6a9353c9055c = &function_9a4f6a9353c9055c;
    orbitcamassets = [ "cam_orbit_br_jup_infil_ac130_player1", "cam_orbit_br_jup_infil_ac130_player2", "cam_orbit_br_jup_infil_ac130_player3", "cam_orbit_br_jup_infil_ac130_player4", "cam_orbit_br_jup_infil_ac130_player1" ];
    br_infils_util::set_orbit_cam_info( orbitcamassets );
    br_infils_util::function_8e44037c2a8b1713( "prematch", &prematchstartfunc );
    br_infils_util::function_8e44037c2a8b1713( "fadedown", &fadedownfunc );
}

// Namespace namespace_56acda7adda17189
// Params 1
// Checksum 0x91769074, Offset: 0x756
// Size: 0x1db
function function_fdfe0dc503c4f44( movingc130 )
{
    animstruct = spawnstruct();
    animstruct.cleanupfunc = &infilcleanup;
    animstruct.var_751e0e63f6c6f6ec = &function_1ad287fcb5253b3c;
    animstruct.movingc130 = movingc130;
    
    if ( getdvarint( @"hash_794056489aa0efdd", 0 ) )
    {
        return animstruct;
    }
    
    sceneent = getent( "infil_exfil_hq_origin", #targetname );
    
    if ( !isdefined( sceneent ) )
    {
        sceneent = spawnstruct();
        sceneent.origin = ( 0, 0, 0 );
        sceneent.angles = ( 0, 0, 0 );
    }
    
    animstruct.hqorigin = getdvarvector( @"hash_e30e6380ab2f16f7", sceneent.origin );
    animstruct.hqangles = sceneent.angles;
    level.infilstruct.var_eebe498248baa141 = animstruct.hqorigin;
    animstruct.scenename = "jup_wz_infil_scene";
    animstruct.randomizedshots = function_5c18e6a2d01f20a8();
    animstruct.sceneroots = [];
    teams = function_b0d92cfa8cc72e75( level.infilstruct.players );
    
    foreach ( teamname, team in teams )
    {
        function_cbfe3df5f410c4f9( animstruct, teamname );
    }
    
    return animstruct;
}

// Namespace namespace_56acda7adda17189
// Params 0, eflags: 0x4
// Checksum 0x556e84dd, Offset: 0x93a
// Size: 0x183
function private function_5c18e6a2d01f20a8()
{
    const_shots = [ "shot_010", "shot_020", "shot_030", "shot_040", "shot_050", "shot_060", "shot_070", "shot_080", "shot_090", "shot_100" ];
    const_shots_randomized = [ 1, 1, 1, 1, 1, 1, 0, 0, 0, 1 ];
    var_65d389c3930a2a2b = [ 0, 0, 1, 0, 1, 0, 0, 0, 0, 0 ];
    var_c6fded36f3f5e6cb = [ "_A", "_B", "_C" ];
    outshots = [];
    mixup = "";
    
    for ( shotidx = 0; shotidx < const_shots.size ; shotidx++ )
    {
        if ( !const_shots_randomized[ shotidx ] )
        {
            mixup = "";
        }
        else if ( !var_65d389c3930a2a2b[ shotidx ] )
        {
            mixup = utility::array_random( var_c6fded36f3f5e6cb );
        }
        
        shot = const_shots[ shotidx ];
        outshots[ outshots.size ] = shot + mixup;
    }
    
    return outshots;
}

// Namespace namespace_56acda7adda17189
// Params 1
// Checksum 0x685b8cea, Offset: 0xac6
// Size: 0xcf
function prestream( animstruct )
{
    teams = function_b0d92cfa8cc72e75( level.infilstruct.players );
    function_12db9af2534c1de4( animstruct, teams );
    
    foreach ( teamname, team in teams )
    {
        sceneroot = animstruct.sceneroots[ teamname ];
        sceneroot scene::pre_stream( team, animstruct.randomizedshots );
    }
}

// Namespace namespace_56acda7adda17189
// Params 1
// Checksum 0x8abb7870, Offset: 0xb9d
// Size: 0x370
function playscene( animstruct )
{
    if ( getdvarint( @"hash_794056489aa0efdd", 0 ) )
    {
        animstruct teleporttomovingplane();
        return;
    }
    
    thread function_f9048b0e202fa9d1();
    function_4924576f6b3f7071();
    teams = function_b0d92cfa8cc72e75( level.infilstruct.players );
    function_12db9af2534c1de4( animstruct, teams );
    
    foreach ( teamname, team in teams )
    {
        br_infils_util::refreshteamvisibilityforteam( teamname );
    }
    
    foreach ( player in level.infilstruct.players )
    {
        animstruct thread function_cba1ea95716651c3( player );
    }
    
    foreach ( player in level.infilstruct.players )
    {
        player setclientomnvar( "ui_br_infil_exfil_player_focus", 1 );
    }
    
    level.var_f3fbdba6f7407494 = 0;
    level.var_7519dc90085b1d1a = 0;
    teamidx = 0;
    
    foreach ( teamname, team in teams )
    {
        sceneroot = animstruct.sceneroots[ teamname ];
        
        if ( teamidx == 0 )
        {
            sceneroot scene::function_f922341b264d32c8( 0 );
        }
        else
        {
            sceneroot scene::function_f922341b264d32c8( 1 );
        }
        
        if ( teamidx == teams.size - 1 )
        {
            sceneroot scene::play( team, animstruct.randomizedshots );
        }
        else
        {
            sceneroot thread scene::play( team, animstruct.randomizedshots );
        }
        
        teamidx++;
    }
    
    foreach ( teamname, team in teams )
    {
        sceneroot = animstruct.sceneroots[ teamname ];
        sceneroot scene::cleanup();
    }
    
    animstruct notify( #"hash_21d386ac254ba247" );
    audio_utility::function_5b885ff87a1180d4( level.players, "jup_br_infil_igc", 1 );
    function_2e88c49a092aadb9();
    animstruct teleporttomovingplane();
    waitframe();
    waitframe();
    animstruct.sceneroots = undefined;
}

// Namespace namespace_56acda7adda17189
// Params 2, eflags: 0x4
// Checksum 0xb06e4590, Offset: 0xf15
// Size: 0xa8
function private function_12db9af2534c1de4( animstruct, allteams = function_b0d92cfa8cc72e75( level.infilstruct.players ) )
{
    foreach ( teamname, team in allteams )
    {
        function_cbfe3df5f410c4f9( animstruct, teamname );
    }
}

// Namespace namespace_56acda7adda17189
// Params 2, eflags: 0x4
// Checksum 0x7e4c5719, Offset: 0xfc5
// Size: 0xf3
function private function_cbfe3df5f410c4f9( animstruct, teamname )
{
    if ( !isdefined( animstruct.sceneroots ) )
    {
        animstruct.sceneroots = [];
    }
    
    if ( isdefined( animstruct.sceneroots[ teamname ] ) )
    {
        return;
    }
    
    sceneroot = spawnstruct();
    sceneroot.origin = animstruct.hqorigin;
    sceneroot.angles = animstruct.hqangles;
    animstruct.sceneroots[ teamname ] = sceneroot;
    sceneroot scene::set_scriptbundle( animstruct.scenename );
    
    if ( animstruct.sceneroots.size == 1 )
    {
        shotnames = animstruct.randomizedshots;
        scene::add_scene_func( sceneroot, &function_1239e5267110edae, shotnames[ 0 ] );
        scene::add_scene_func( sceneroot, &function_e614a113e9db2d80, shotnames[ shotnames.size - 1 ] );
    }
}

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0xbc04f9f2, Offset: 0x10c0
// Size: 0x21
function function_1239e5267110edae()
{
    if ( level.var_f3fbdba6f7407494 )
    {
        return;
    }
    
    level.var_f3fbdba6f7407494 = 1;
    function_e99ce9bc0e774a4e();
}

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0xc353587e, Offset: 0x10e9
// Size: 0xbd
function function_e614a113e9db2d80()
{
    if ( level.var_7519dc90085b1d1a )
    {
        return;
    }
    
    level.var_7519dc90085b1d1a = 1;
    shots = scene::get_shot_names();
    shotlength = scene::function_b3c7b792a7a154fa( shots[ shots.size - 1 ] );
    fadestarttime = max( 0, shotlength - 1.5 );
    fadeendtime = shotlength + 0.75;
    wait fadestarttime;
    br_infils_util::function_c050cae6f9bcb77f( 1, level.infilstruct.players, "hq_transition" );
    wait fadeendtime - fadestarttime;
    br_infils_util::function_573cdd2bc439ec67( 0.5, level.infilstruct.players, "hq_transition" );
}

// Namespace namespace_56acda7adda17189
// Params 0, eflags: 0x4
// Checksum 0x6b03ef22, Offset: 0x11ae
// Size: 0x246
function private function_e99ce9bc0e774a4e()
{
    sceneroots = level.infilstruct.animstruct.sceneroots;
    parachutes = function_a3c61c6c5803ea3e( self );
    
    foreach ( parachute in parachutes )
    {
        parachute hide();
    }
    
    var_c98edf6c8c06ef9d = function_2deca4f65c23943f( self );
    
    foreach ( flatparachute in var_c98edf6c8c06ef9d )
    {
        flatparachute hide();
    }
    
    foreach ( sceneroot in sceneroots )
    {
        playersinscene = function_1e326f4ce9514ee0( sceneroot );
        
        for ( playeridx = 0; playeridx < playersinscene.size ; playeridx++ )
        {
            foreach ( player in playersinscene )
            {
                if ( isdefined( parachutes[ playeridx ] ) )
                {
                    parachutes[ playeridx ] showtoplayer( player );
                }
                
                if ( isdefined( var_c98edf6c8c06ef9d[ playeridx ] ) )
                {
                    var_c98edf6c8c06ef9d[ playeridx ] showtoplayer( player );
                }
            }
        }
    }
}

// Namespace namespace_56acda7adda17189
// Params 1, eflags: 0x4
// Checksum 0xd84222d, Offset: 0x13fc
// Size: 0x56
function private function_1e326f4ce9514ee0( sceneroot )
{
    playersents = [];
    
    for ( playeridx = 1; playeridx <= 4 ; playeridx++ )
    {
        var_a414c5209a55eeef = "Player" + playeridx;
        playersents[ playersents.size ] = sceneroot scene::get_entity( var_a414c5209a55eeef );
    }
    
    return playersents;
}

// Namespace namespace_56acda7adda17189
// Params 1, eflags: 0x4
// Checksum 0x7afec84c, Offset: 0x145b
// Size: 0x56
function private function_a3c61c6c5803ea3e( sceneroot )
{
    parachutes = [];
    
    for ( i = 1; i <= 4 ; i++ )
    {
        parachutename = "Parachute0" + i;
        parachutes[ parachutes.size ] = sceneroot scene::get_entity( parachutename );
    }
    
    return parachutes;
}

// Namespace namespace_56acda7adda17189
// Params 1, eflags: 0x4
// Checksum 0x6c7b0156, Offset: 0x14ba
// Size: 0x56
function private function_2deca4f65c23943f( sceneroot )
{
    var_c98edf6c8c06ef9d = [];
    
    for ( i = 1; i <= 4 ; i++ )
    {
        parachutename = "Flat_Parachute0" + i;
        var_c98edf6c8c06ef9d[ var_c98edf6c8c06ef9d.size ] = sceneroot scene::get_entity( parachutename );
    }
    
    return var_c98edf6c8c06ef9d;
}

// Namespace namespace_56acda7adda17189
// Params 1, eflags: 0x4
// Checksum 0x7db237ba, Offset: 0x1519
// Size: 0x14a
function private function_cba1ea95716651c3( player )
{
    self endon( #"hash_21d386ac254ba247" );
    sceneroot = self.sceneroots[ player.team ];
    player waittill( #"disconnect" );
    parachute = undefined;
    flatparachute = undefined;
    playersinscene = function_1e326f4ce9514ee0( sceneroot );
    
    for ( playeridx = 0; playeridx < playersinscene.size ; playeridx++ )
    {
        if ( player == playersinscene[ playeridx ] )
        {
            parachute = sceneroot scene::get_entity( "Parachute0" + playeridx );
            flatparachute = sceneroot scene::get_entity( "Flat_Parachute0" + playeridx );
            break;
        }
    }
    
    playersinscene = function_5713d46873b29625( playersinscene );
    
    foreach ( otherplayer in playersinscene )
    {
        if ( player != otherplayer )
        {
            if ( isdefined( parachute ) )
            {
                parachute hidefromplayer( otherplayer );
            }
            
            if ( isdefined( parachute ) )
            {
                flatparachute hidefromplayer( otherplayer );
            }
        }
    }
}

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0xf7584ae2, Offset: 0x166b
// Size: 0x68
function function_f9048b0e202fa9d1()
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_infil_amb_lr" );
    wait 17.5;
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_infil_c17_takeoff_spinup_lssrss" );
    wait 2.75;
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_infil_c17_takeoff_main_lr" );
    wait 3.3;
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_infil_c17_transition_lr" );
}

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0xf2b9985f, Offset: 0x16db
// Size: 0x152
function teleporttomovingplane()
{
    assert( isdefined( self.movingc130 ) );
    self.movingc130.animname = "infilCargoPlane";
    self.movingc130 scriptmodelplayanim( "wz_br_jup_infil_idle_crgopln", "infilCargoPlane" );
    
    if ( !level.infilstruct.var_df720711dd79fea7 || br_infils_util::function_7d2f9d2a086bd511() )
    {
        self.movingc130 notify( #"start_moving" );
    }
    
    setomnvar( "ui_hide_player_icons", 0 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setallstreamloaddist( 0 );
        player unlink();
        player playerlinkto( self.movingc130, "tag_body_animate" );
        player setplayerangles( self.movingc130.angles );
    }
    
    thread function_1886f6e725624c15();
}

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0xe6580447, Offset: 0x1835
// Size: 0x34
function function_1886f6e725624c15()
{
    wait 0.1;
    function_8480689471b795a0();
    
    if ( isdefined( self.movingc130 ) )
    {
        self.movingc130 setscriptablepartstate( "br_fx", "clouds" );
    }
}

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0x766a92a1, Offset: 0x1871
// Size: 0x1a
function function_8480689471b795a0()
{
    self.movingc130 setscriptablepartstate( "int_lights_green_all", "on" );
}

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0x998018d7, Offset: 0x1893
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
    
    if ( infilanimindex >= 4 )
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

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0xfec2423e, Offset: 0x1ab9
// Size: 0x34
function jumpfunc()
{
    if ( getdvarint( @"hash_549df6ab370a2bc4", 1 ) )
    {
        self lerpfovscalefactor( 0, 0 );
        self setclientdvar( @"cg_disable_user_fov", 0 );
    }
}

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0x9fda1459, Offset: 0x1af5
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

// Namespace namespace_56acda7adda17189
// Params 0, eflags: 0x4
// Checksum 0x6cbbc444, Offset: 0x1b81
// Size: 0x14
function private prematchstartfunc()
{
    level.nosuspensemusic = 1;
    thread music_and_dialog::stopsuspensemusic();
}

// Namespace namespace_56acda7adda17189
// Params 0, eflags: 0x4
// Checksum 0x409f6b5c, Offset: 0x1b9d
// Size: 0xa
function private fadedownfunc()
{
    level thread function_818e211bb54ccc2a();
}

// Namespace namespace_56acda7adda17189
// Params 0, eflags: 0x4
// Checksum 0xdfd275c5, Offset: 0x1baf
// Size: 0x41
function private function_818e211bb54ccc2a()
{
    clearmusicstate();
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "jup_br_infil_igc", 1 );
    wait 2.5;
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_br_lobby_fade", 0 );
}

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0x94cebbdf, Offset: 0x1bf8
// Size: 0x9
function infilcleanup()
{
    br_infils_util::function_3855f5796f4d2b65();
}

// Namespace namespace_56acda7adda17189
// Params 0
// Checksum 0xd9da1cc7, Offset: 0x1c09
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

// Namespace namespace_56acda7adda17189
// Params 1, eflags: 0x4
// Checksum 0xa590582e, Offset: 0x1c6d
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

// Namespace namespace_56acda7adda17189
// Params 0, eflags: 0x4
// Checksum 0x6b3dca68, Offset: 0x1d4e
// Size: 0xb4
function private function_4924576f6b3f7071()
{
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
        }
    }
}

// Namespace namespace_56acda7adda17189
// Params 0, eflags: 0x4
// Checksum 0x5f0a0fd2, Offset: 0x1e0a
// Size: 0xb4
function private function_2e88c49a092aadb9()
{
    var_2754701952ea4d67 = getdvarint( @"hash_7f1da0c3501cbdf2", 1 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( var_2754701952ea4d67 )
        {
            player function_72cf2eee8e035013( %"hash_34c59bed7392d266" );
        }
    }
}

// Namespace namespace_56acda7adda17189
// Params 1, eflags: 0x4
// Checksum 0x3a1f0c12, Offset: 0x1ec6
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

