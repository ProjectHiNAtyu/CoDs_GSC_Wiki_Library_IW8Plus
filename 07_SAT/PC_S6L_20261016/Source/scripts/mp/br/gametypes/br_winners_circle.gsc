// scripts\mp\br\gametypes\br_winners_circle.gsc  (hash_172c1bf5d6d22f2d.gscc) (size: 19903 Bytes / 0x4dbf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd916a927 (3642140967)
// size ...... 19903 (0x4dbf)
// includes .. 20  (offset: 0x49d3)
// strings ... 47  (offset: 0x4a73)
// dev strs .. 14  (offset: 0x4ceb)
// exports ... 48  (offset: 0x3113)
// cseg ...... 0x656 + 0x2abd (0x3113)
// imports ... 142 (offset: 0x3893)
// animtree1 . 0   (offset: 0x4dbf)
// animtree2 . 0   (offset: 0x4dbf)
#using script_52a473ac9352028b;
#using scripts\common\callbacks;
#using scripts\common\omnvar_utility;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_accolades;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\deathicons;
#using scripts\mp\dev;
#using scripts\mp\emote;
#using scripts\mp\music_br;
#using scripts\mp\operator;
#using scripts\mp\playerlogic;
#using scripts\mp\scene;
#using scripts\mp\weapons;

#namespace br_winners_circle;

// Namespace br_winners_circle
// Params 0, eflags: 0x1
// Checksum 0x21883308, Offset: 0x674
// Size: 0x5a7
function autoexec main()
{
    if ( level.gametypebundle.winnerscircletype != #"brwinnerscircle" || !getdvarint( @"scr_br_winners_circle_enabled", 0 ) )
    {
        return;
    }
    
    cameraents = getentarray( "br_winners_circle_cam_ent", "targetname" );
    
    /#
        if ( cameraents.size == 0 )
        {
            clientcharas = [];
            location = ( 70000, -27000, -1000 );
            cameraent = spawn( "<dev string:x24>", location );
            cameraent setmodel( "<dev string:x31>" );
            clientcharas[ clientcharas.size ] = spawn( "<dev string:x41>", location + ( 296, 56, -30 ), 0, 0, 1, "<dev string:x52>" );
            clientcharas[ clientcharas.size ] = spawn( "<dev string:x41>", location + ( 296, -56, -30 ), 0, 0, 2, "<dev string:x52>" );
            clientcharas[ clientcharas.size ] = spawn( "<dev string:x41>", location + ( 296, -160, -30 ), 0, 0, 3, "<dev string:x52>" );
            clientcharas[ clientcharas.size ] = spawn( "<dev string:x41>", location + ( 296, 160, -30 ), 0, 0, 4, "<dev string:x52>" );
            
            foreach ( chara in clientcharas )
            {
                chara.angles = ( 0, 180, 0 );
            }
            
            cameraents = [ cameraent ];
        }
    #/
    
    if ( cameraents.size == 0 )
    {
        return;
    }
    
    mapinfo = getactivemapinfobundle();
    defaultscenename = mapinfo.var_d7e0adfd0e07292f ?? "default";
    var_3f2c1303dc415cc7 = [];
    
    foreach ( camera in cameraents )
    {
        camera scriptmodelplayanim( "wz_br_cer_exfil_s1_winners_circle_cam" );
        scene = spawnstruct();
        scenename = camera.script_noteworthy ?? defaultscenename;
        
        if ( isdefined( var_3f2c1303dc415cc7[ scenename ] ) )
        {
            script::demoforcesre( "Winners circle scene with name '" + scenename + "' already exists!" );
            continue;
        }
        
        scene.name = scenename;
        scene.camera = camera;
        var_3f2c1303dc415cc7[ scenename ] = scene;
    }
    
    if ( var_3f2c1303dc415cc7.size == 1 )
    {
        defaultscenename = scenename;
    }
    
    if ( !isdefined( var_3f2c1303dc415cc7[ defaultscenename ] ) )
    {
        script::demoforcesre( "Default winners circle scene '" + defaultscenename + "' was not found!" );
        return;
    }
    
    level.brwinnerscircle = spawnstruct();
    var_4a1d57c16bdcd276 = getentarray( "script_character", "classname" );
    
    foreach ( chara in var_4a1d57c16bdcd276 )
    {
        chara forcenetfieldhighlod( 1 );
    }
    
    callback::add( #"on_squad_eliminated", &onteameliminated );
    level.brwinnerscircle.var_f78dd935033102ca = &function_ca3ca4601a58169a;
    level.brwinnerscircle.activatewinnerscircle = &activatewinnerscircle;
    level.brwinnerscircle.setwinners = &function_f1986998d32ef926;
    level.brwinnerscircle.deactivate = &function_9caaecc48a685128;
    level.brwinnerscircle.deactivateimmediate = &function_4b5ee3c36ed12c2d;
    level.brwinnerscircle.var_41b10fd9fb1a88d3 = &function_22ba3a262694b6f1;
    level.brwinnerscircle.var_de4265ac3d27121c = &function_2229e2aff4a938f4;
    
    /#
        level.brwinnerscircle.var_39b5a2ab65a0aa6c = &function_1e08ed23bb00dc27;
        level.brwinnerscircle.var_4a1d57c16bdcd276 = var_4a1d57c16bdcd276;
    #/
    
    level.brwinnerscircle.var_3f2c1303dc415cc7 = var_3f2c1303dc415cc7;
    level.brwinnerscircle.viewingteam = [];
    level.brwinnerscircle.var_8c72aa87b4135825 = [];
    level.brwinnerscircle.defaultscenename = defaultscenename;
    level.brwinnerscircle.usesquads = !squad_utility::function_1df8c3bebd512a8c();
    level.brwinnerscircle.hwconfig = mapinfo.var_ddd86338425ef131 ?? %"hw_jup_mp_wz2_cin_cer";
    
    if ( level.gametypebundle.brwinnerscircle )
    {
        level.brwinnerscircle.camerasettings = getscriptbundlefieldvalue( level.gametypebundle.brwinnerscircle, #"camerasettings" );
    }
    
    if ( !isdefined( level.brwinnerscircle.camerasettings ) )
    {
        level.brwinnerscircle.camerasettings = "br_winners_circle_camera";
    }
}

// Namespace br_winners_circle
// Params 1
// Checksum 0x76f8b4ad, Offset: 0xc23
// Size: 0x110
function onteameliminated( params )
{
    if ( level.brwinnerscircle.usesquads )
    {
        return;
    }
    
    level endon( #"game_ended" );
    teamplayers = teams::getteamdata( params.team, "players" );
    
    if ( teamplayers.size == 0 )
    {
        return;
    }
    
    function_add4d32966c18ab2( params.team, level.brwinnerscircle.defaultscenename );
    
    if ( level.gameended )
    {
        return;
    }
    
    foreach ( player in teamplayers )
    {
        if ( !isdefined( player ) || isalive( player ) )
        {
            continue;
        }
        
        player thread function_43572ed84ab439c7();
    }
}

// Namespace br_winners_circle
// Params 0
// Checksum 0xe097b0e8, Offset: 0xd3b
// Size: 0x94
function function_43572ed84ab439c7()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !self.br_spectatorinitialized )
    {
        self waittill( #"br_spectatorInitialized" );
    }
    
    pbgpostfxbundlekillall( self );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, val );
        
        if ( channel == "ui_ready_for_winners_circle" )
        {
            if ( !isalive( self ) && !function_22ba3a262694b6f1( self ) )
            {
                thread function_ca3ca4601a58169a();
                thread function_c0755dd570b2ecde();
                return;
            }
        }
    }
}

// Namespace br_winners_circle
// Params 0
// Checksum 0xd487354e, Offset: 0xdd7
// Size: 0x86
function function_c0755dd570b2ecde()
{
    self notify( #"hash_a2fada6234b688b1" );
    self endon( #"hash_a2fada6234b688b1" );
    self endon( #"disconnect" );
    self endon( #"jailbreak_respawn" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message );
        
        if ( message == "br_winners_circle_toggle" )
        {
            if ( function_22ba3a262694b6f1( self ) )
            {
                thread function_9caaecc48a685128();
            }
            else
            {
                thread function_ca3ca4601a58169a();
            }
        }
        
        waitframe();
    }
}

// Namespace br_winners_circle
// Params 0
// Checksum 0xe56a2302, Offset: 0xe65
// Size: 0xa6
function function_f1a120b8b6006adf()
{
    self notify( #"hash_875d373305cfe9d9" );
    self endon( #"hash_875d373305cfe9d9" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message );
        
        if ( message == "br_winners_circle_toggle" )
        {
            if ( !isdefined( self.var_bf0ef69bc92de89c ) || self.var_bf0ef69bc92de89c == level.brwinnerscircle.var_98a0a1962baa11dc )
            {
                thread function_ca3ca4601a58169a();
            }
            else
            {
                thread function_fc34073e1a01b360( level.brwinnerscircle.winnersscene );
            }
        }
        
        waitframe();
    }
}

// Namespace br_winners_circle
// Params 1
// Checksum 0xf1ee1011, Offset: 0xf13
// Size: 0x36
function function_ca3ca4601a58169a( scenename )
{
    self endon( #"disconnect" );
    sceneinfo = function_2c1d0f98c575125c( self, scenename );
    function_fc34073e1a01b360( sceneinfo );
}

// Namespace br_winners_circle
// Params 0
// Checksum 0xc9e0f1a9, Offset: 0xf51
// Size: 0x1d8
function activatewinnerscircle()
{
    if ( !isdefined( level.brwinnerscircle.winnersscene ) )
    {
        winningteam = "none";
    }
    else
    {
        winningteam = level.brwinnerscircle.winnersscene.team;
    }
    
    var_fc8269b1273c82c2 = getdvarfloat( @"hash_69e7af0bb9afe525", 30 );
    level.brwinnerscircle.var_3b9595474a3720fd = function_7b4c4655bcc50709( int( var_fc8269b1273c82c2 * 1000 ) );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "post_game_state", 14 );
        winnersscene = function_1bccf6cd8b2c6318( player, winningteam );
        player thread function_fc34073e1a01b360( winnersscene );
        
        if ( player.team != winningteam && winningteam != "none" )
        {
            player thread function_f1a120b8b6006adf();
        }
    }
    
    deathicons::removealldeathicons();
    squadid = function_3c7290d895e5e564( winningteam );
    teamplayers = function_910227633bd7a563( winningteam, squadid );
    callback::callback( #"hash_9d92d48a58900ff6", { #teamplayers:teamplayers } );
    endtime = gettime() + var_fc8269b1273c82c2 * 1000;
    
    while ( gettime() < endtime )
    {
        if ( level.players.size == 0 )
        {
            waitframe();
            break;
        }
        
        wait 1;
    }
    
    level notify( #"br_winners_circle_finished" );
}

// Namespace br_winners_circle
// Params 0
// Checksum 0x23286734, Offset: 0x1131
// Size: 0x75
function function_1d2f70d591e967bc()
{
    self endon( #"hash_a7c0ee412dcb35eb" );
    self endon( #"disconnect" );
    logstring( "FADE TO BLACK DEBUG:  br_winners_circle - respawnFadeToBlack fade in" );
    
    if ( !level.elite_ironclad.nukelaunched )
    {
        br_spawnrespawn::function_1d2f70d591e967bc();
    }
    
    if ( getdvarint( @"hash_871bde235e6664fc", 1 ) )
    {
        wait getdvarfloat( @"hash_e65c1ee89425b6b4", 5 );
        logstring( "FADE TO BLACK DEBUG:  br_winners_circle - respawnFadeToBlack fade out" );
        br_spawnrespawn::function_24b79e9319c6f02f();
    }
}

// Namespace br_winners_circle
// Params 1
// Checksum 0x7d1c8c01, Offset: 0x11ae
// Size: 0x3ac
function function_fc34073e1a01b360( sceneinfo )
{
    self endon( #"disconnect" );
    self endon( #"br_winners_circle_end" );
    function_fc088fdf052b4014( sceneinfo );
    function_9ec537116350ffed( sceneinfo );
    clientnum = self getentitynumber();
    timelimitms = int( getdvarfloat( @"hash_69e7af0bb9afe525", 30 ) * 1000 );
    level.brwinnerscircle.var_3b9595474a3720fd = function_7b4c4655bcc50709( timelimitms );
    
    if ( isdefined( level.brwinnerscircle.var_3b9595474a3720fd ) )
    {
        for ( pollcount = 0; pollcount < 20 ; pollcount++ )
        {
            allready = 1;
            
            for ( i = 0; i < level.brwinnerscircle.var_3b9595474a3720fd.size ; i++ )
            {
                if ( level.brwinnerscircle.var_3b9595474a3720fd[ i ] >= 0 && !function_d56db8b35cc9ce12( level.brwinnerscircle.var_3b9595474a3720fd[ i ] ) )
                {
                    allready = 0;
                    break;
                }
            }
            
            if ( allready )
            {
                break;
            }
            
            wait 0.1;
        }
    }
    
    scene::function_e96a757b2bdad619( clientnum, sceneinfo.var_c355d4a46d74189d );
    self.var_deb431d783a2b824 = 1;
    self notify( #"br_winners_circle_start" );
    var_c932a87b4f427603 = istrue( self.brwinnerscircle );
    var_78304c52fa4435c8 = self.var_58edfd73ba4630d9 != sceneinfo.scenelocation.name;
    
    if ( !var_c932a87b4f427603 )
    {
        self setclientomnvar( "ui_br_winners_circle_active", 1 );
        self freezecontrols( 1 );
        music_br::function_3f8afb44656937d7( self );
        
        if ( !isalive( self ) )
        {
            self.var_50e971a93ad3692e = self.playertospectate;
            br_spectate::playerclearspectatekillchainsystem();
        }
    }
    else
    {
        thread function_1d2f70d591e967bc();
        self setclientomnvar( "ui_br_winners_circle_viewing_scene", 0 );
        wait 0.3;
        self setclientomnvar( "ui_br_winners_circle_active", 0 );
        waitframe();
        self setclientomnvar( "ui_br_winners_circle_active", 1 );
        function_e62f8c724ef1ab54( self.var_bf0ef69bc92de89c );
    }
    
    if ( var_78304c52fa4435c8 )
    {
        waitforstream = function_240c98eb9068e0a3( sceneinfo.scenelocation.camera.origin );
        thread function_1d2f70d591e967bc();
        
        if ( waitforstream )
        {
            function_1046723ad5890ebc( 5 );
            function_ffdbfd1cde25df36();
        }
    }
    
    self notify( #"br_winners_circle_visible" );
    
    if ( !var_c932a87b4f427603 )
    {
        if ( !isalive( self ) || isdefined( level.brwinnerscircle.var_98a0a1962baa11dc ) )
        {
            function_5ae433bddc962028( sceneinfo.scenelocation.camera );
        }
        
        function_b33be51db325db53( 1 );
    }
    
    key = function_7b2fbe1612db9720( sceneinfo.team, sceneinfo.squad );
    function_8a42585bd6e47e9f( key );
    self.var_58edfd73ba4630d9 = sceneinfo.scenelocation.name;
    
    if ( var_78304c52fa4435c8 )
    {
        self cameralinkto( sceneinfo.scenelocation.camera, "j_prop_1", 0, 1 );
        wait 0.3;
    }
    
    pbgpostfxbundlekillall( self );
    self notify( #"hash_a7c0ee412dcb35eb" );
    br_spawnrespawn::function_24b79e9319c6f02f();
    self setclientomnvar( "ui_br_winners_circle_viewing_scene", 1 );
    
    if ( !var_c932a87b4f427603 )
    {
        self playlocalsound( "uin_winnerscircle_enter" );
        self setsoundsubmix( "wz2_winners_circle", 0.5 );
    }
    
    function_d26bac8a0b8e0232( sceneinfo );
    self.var_deb431d783a2b824 = undefined;
}

// Namespace br_winners_circle
// Params 0
// Checksum 0x479eba9b, Offset: 0x1562
// Size: 0x11e
function function_9caaecc48a685128()
{
    self endon( #"disconnect" );
    self endon( #"br_winners_circle_end" );
    
    if ( isdefined( level.brwinnerscircle.var_98a0a1962baa11dc ) )
    {
        script::demoforcesre( "Attempting to leave winners circle after game has ended!!" );
        return;
    }
    
    music_br::function_f3392105d8ec1ad2( self );
    
    if ( isalive( self ) )
    {
        waitforstream = function_240c98eb9068e0a3( self.origin );
    }
    
    thread function_1d2f70d591e967bc();
    wait 0.3;
    self setclientomnvar( "ui_br_winners_circle_active", 0 );
    self setclientomnvar( "ui_br_winners_circle_viewing_scene", 0 );
    self clearsoundsubmix( "wz2_winners_circle", 0.5 );
    
    if ( !isalive( self ) )
    {
        logstring( "FADE TO BLACK DEBUG:  leaveTeamCircle - no fade out, not alive" );
        function_ad4cc939ebb5d062();
    }
    else
    {
        if ( waitforstream )
        {
            function_1046723ad5890ebc( 5 );
            function_ffdbfd1cde25df36();
        }
        
        self notify( #"hash_a7c0ee412dcb35eb" );
        br_spawnrespawn::function_24b79e9319c6f02f();
    }
    
    function_b33be51db325db53( 0 );
    function_e62f8c724ef1ab54( self.var_bf0ef69bc92de89c );
    self.var_58edfd73ba4630d9 = undefined;
    self cameraunlink();
    self freezecontrols( 0 );
    self notify( #"br_winners_circle_end" );
}

// Namespace br_winners_circle
// Params 0
// Checksum 0xaf69c05b, Offset: 0x1688
// Size: 0x9e
function function_4b5ee3c36ed12c2d()
{
    self notify( #"br_winners_circle_end" );
    
    if ( self.var_deb431d783a2b824 )
    {
        self clearpredictedstreampos();
    }
    
    self setclientomnvar( "ui_br_winners_circle_viewing_scene", 0 );
    self setclientomnvar( "ui_br_winners_circle_active", 0 );
    self clearsoundsubmix( "wz2_winners_circle", 0.5 );
    
    if ( !isalive( self ) )
    {
        function_ad4cc939ebb5d062();
    }
    
    function_b33be51db325db53( 0 );
    self.var_58edfd73ba4630d9 = undefined;
    
    if ( isdefined( self.var_bf0ef69bc92de89c ) )
    {
        function_e62f8c724ef1ab54( self.var_bf0ef69bc92de89c );
    }
    
    self cameraunlink();
    self freezecontrols( 0 );
    self.var_deb431d783a2b824 = undefined;
}

// Namespace br_winners_circle
// Params 3
// Checksum 0x636a6a2d, Offset: 0x172e
// Size: 0x2d5
function function_cfe12cc8bfe5ee22( team, scenename, squadid )
{
    sceneinfo = spawnstruct();
    sceneinfo.var_5b6d3d8924ce9881 = [];
    var_8ec497f12f07a5de = [];
    teammates = function_910227633bd7a563( team, squadid );
    
    for ( i = 0; i < teammates.size ; i++ )
    {
        player = teammates[ i ];
        var_c355d4a46d74189d = spawnstruct();
        var_c355d4a46d74189d.clientnum = player getentitynumber();
        var_c355d4a46d74189d.characterindex = i + 1;
        var_c355d4a46d74189d.operatorref = player.micontext.var_a9c6c85962429e1c ?? player.operatorcustomization.operatorref;
        var_c355d4a46d74189d.skinref = player.micontext.var_716d2096928c8cab ?? player.operatorcustomization.skinref;
        var_c355d4a46d74189d.weaponname = player function_658cd866bbe100d6();
        var_8ec497f12f07a5de[ var_8ec497f12f07a5de.size ] = var_c355d4a46d74189d;
        assert( isxhashasset( var_c355d4a46d74189d.operatorref ), "<dev string:x64>" + ( var_c355d4a46d74189d.operatorref ?? "<dev string:x72>" ) + "<dev string:x81>" + var_c355d4a46d74189d.clientnum + "<dev string:x90>" + ( player.name ?? "<dev string:x94>" ) + "<dev string:x95>" );
        assert( isxhashasset( var_c355d4a46d74189d.skinref ), "<dev string:xd8>" + ( var_c355d4a46d74189d.operatorskin ?? "<dev string:xe7>" ) + "<dev string:x81>" + var_c355d4a46d74189d.clientnum + "<dev string:x90>" + ( player.name ?? "<dev string:x94>" ) + "<dev string:x95>" );
        var_5b6d3d8924ce9881 = spawnstruct();
        var_5b6d3d8924ce9881.var_c355d4a46d74189d = var_c355d4a46d74189d;
        var_5b6d3d8924ce9881.player = player;
        var_5b6d3d8924ce9881.accoladeref = player.var_4f97df463efd71b5 ?? "";
        var_5b6d3d8924ce9881.var_f60031aca22cc8dc = player.var_f60031aca22cc8dc ?? 0;
        sceneinfo.var_5b6d3d8924ce9881[ sceneinfo.var_5b6d3d8924ce9881.size ] = var_5b6d3d8924ce9881;
    }
    
    sceneinfo.var_c355d4a46d74189d = var_8ec497f12f07a5de;
    sceneinfo.team = team;
    sceneinfo.squad = squadid;
    sceneinfo.mvpindex = function_ead824df9963a891( sceneinfo );
    sceneinfo.scenelocation = function_5c5e20b9a15e9545( scenename );
    return sceneinfo;
}

// Namespace br_winners_circle
// Params 2
// Checksum 0x1a03bd5b, Offset: 0x1a0c
// Size: 0x175
function function_f1986998d32ef926( winningteam, scenename )
{
    if ( isdefined( level.brwinnerscircle.winnersscene ) )
    {
        script::demoforcesre( "Winners for winners circle have already been set! Overriding previous winners" );
    }
    
    if ( level.brwinnerscircle.usesquads )
    {
        squadid = function_3c7290d895e5e564( winningteam );
        
        if ( squadid == -1 )
        {
            return;
        }
    }
    
    teamplayers = function_910227633bd7a563( winningteam, squadid );
    
    if ( teamplayers.size == 0 )
    {
        return;
    }
    
    foreach ( player in teamplayers )
    {
        if ( !isdefined( player.var_4f97df463efd71b5 ) )
        {
            br_accolades::function_8ffb08c901d9d792( teamplayers );
            break;
        }
    }
    
    var_98a0a1962baa11dc = function_7b2fbe1612db9720( winningteam, squadid );
    winnersscene = function_cfe12cc8bfe5ee22( winningteam, scenename, squadid );
    level.brwinnerscircle.var_8c72aa87b4135825[ var_98a0a1962baa11dc ] = winnersscene;
    level.brwinnerscircle.var_98a0a1962baa11dc = var_98a0a1962baa11dc;
    level.brwinnerscircle.winnersscene = winnersscene;
}

// Namespace br_winners_circle
// Params 1
// Checksum 0x45025575, Offset: 0x1b89
// Size: 0x3c, Type: bool
function function_240c98eb9068e0a3( streamorigin )
{
    if ( isbot( self ) || self isplayerheadless() )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_ae18305251d17205", 0 ) )
    {
        return false;
    }
    
    self predictstreamposuntilcleared( streamorigin );
    return true;
}

// Namespace br_winners_circle
// Params 1
// Checksum 0xff3da7e7, Offset: 0x1bce
// Size: 0x3a
function function_1046723ad5890ebc( timeout )
{
    self endon( #"hash_5386f3d4c1f51fe7" );
    thread function_cdf2fd94c3132f97( timeout );
    
    while ( !self ispredictedstreamposready() )
    {
        waitframe();
    }
    
    self notify( #"hash_5386f3d4c1f51fe7" );
}

// Namespace br_winners_circle
// Params 1
// Checksum 0x85869108, Offset: 0x1c10
// Size: 0x33
function function_cdf2fd94c3132f97( timelimit )
{
    self endon( #"disconnect" );
    self endon( #"hash_5386f3d4c1f51fe7" );
    wait timelimit;
    self notify( #"hash_5386f3d4c1f51fe7" );
}

// Namespace br_winners_circle
// Params 0
// Checksum 0xdeb2392a, Offset: 0x1c4b
// Size: 0x14
function function_ffdbfd1cde25df36()
{
    self clearpredictedstreampos();
    self notify( #"hash_5386f3d4c1f51fe7" );
}

// Namespace br_winners_circle
// Params 0
// Checksum 0x38b716cc, Offset: 0x1c67
// Size: 0x130
function function_ad4cc939ebb5d062()
{
    player = self;
    var_8b05b9a35d90c710 = player.var_50e971a93ad3692e;
    player.var_50e971a93ad3692e = undefined;
    playertospectate = br_spectate::getbestspectatecandidate( player, var_8b05b9a35d90c710 );
    
    if ( isdefined( playertospectate ) )
    {
        br_spectate::assignspectatortospectateplayer( player, playertospectate );
        return;
    }
    
    numeliminated = 0;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.br_iseliminated )
        {
            numeliminated++;
        }
    }
    
    if ( !level.gameended && level.players.size > 1 && numeliminated != level.players.size )
    {
        script::demoforcesre( "Couldn't find spectate candidate to return to. numEliminated: " + numeliminated + ". Tot Players: " + level.players.size );
    }
}

// Namespace br_winners_circle
// Params 1
// Checksum 0x2d8a4832, Offset: 0x1d9f
// Size: 0x6f
function function_5ae433bddc962028( cam )
{
    player = self;
    spawnpoint = spawnstruct();
    spawnpoint.origin = cam.origin;
    spawnpoint.angles = cam.angles;
    player playerlogic::spawnintermission( spawnpoint, undefined, 0 );
    player player::updatesessionstate( "dead" );
}

// Namespace br_winners_circle
// Params 1
// Checksum 0xddbf96c2, Offset: 0x1e16
// Size: 0x5a
function function_b33be51db325db53( inwinnerscircle )
{
    if ( inwinnerscircle && !self.brwinnerscircle )
    {
        function_2b1e5f99b393daf7();
    }
    else if ( !inwinnerscircle && self.brwinnerscircle )
    {
        function_733a18206326a6bb();
    }
    
    self.brwinnerscircle = inwinnerscircle;
    level notify( #"hash_7f6b2a7b2d05df3e" );
}

// Namespace br_winners_circle
// Params 0
// Checksum 0x9030d2d8, Offset: 0x1e78
// Size: 0x34
function function_2b1e5f99b393daf7()
{
    self function_a565dafac620d68e( level.brwinnerscircle.hwconfig );
    self cameraset( level.brwinnerscircle.camerasettings );
}

// Namespace br_winners_circle
// Params 0
// Checksum 0xd759e934, Offset: 0x1eb4
// Size: 0x21
function function_733a18206326a6bb()
{
    self function_72cf2eee8e035013( level.brwinnerscircle.hwconfig );
    self cameradefault();
}

// Namespace br_winners_circle
// Params 1
// Checksum 0x9ac46eec, Offset: 0x1edd
// Size: 0x26, Type: bool
function function_22ba3a262694b6f1( player )
{
    return player.brwinnerscircle || player.var_deb431d783a2b824;
}

// Namespace br_winners_circle
// Params 1
// Checksum 0x68471420, Offset: 0x1f0c
// Size: 0xce
function function_d26bac8a0b8e0232( sceneinfo )
{
    foreach ( var_5b6d3d8924ce9881 in sceneinfo.var_5b6d3d8924ce9881 )
    {
        if ( !isdefined( var_5b6d3d8924ce9881.player ) )
        {
            continue;
        }
        
        var_5b6d3d8924ce9881.player notify( #"hash_32049ffad2db3d90" );
        var_5b6d3d8924ce9881.player thread function_fbd68bef9d885c24( var_5b6d3d8924ce9881.var_c355d4a46d74189d.characterindex );
    }
}

// Namespace br_winners_circle
// Params 1
// Checksum 0xae3db42d, Offset: 0x1fe2
// Size: 0xbe
function function_fbd68bef9d885c24( characterindex )
{
    self endon( #"br_winners_circle_end" );
    self endon( #"hash_32049ffad2db3d90" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, slotindex );
        
        if ( message == "try_emote3p" )
        {
            emoteref = emote::function_d97161a916a220af( slotindex );
            emoteindex = emote::function_205b1d52b38d3b0e( emoteref );
            scenekey = function_7b2fbe1612db9720( self.team, self.sessionsquadid );
            var_19049fe2ec011cf3 = function_180813f6bfec5143( scenekey );
            thread emote::function_e517ecb74bbd6b77( var_19049fe2ec011cf3, characterindex, emoteindex );
            waitframe();
        }
    }
}

// Namespace br_winners_circle
// Params 1
// Checksum 0xde43f741, Offset: 0x20a8
// Size: 0x8b
function function_d686da411642eb1b( scenekey )
{
    if ( !isdefined( level.brwinnerscircle.viewingteam[ scenekey ] ) )
    {
        return;
    }
    
    level.brwinnerscircle.viewingteam[ scenekey ] = function_5713d46873b29625( level.brwinnerscircle.viewingteam[ scenekey ] );
    
    if ( level.brwinnerscircle.viewingteam[ scenekey ].size == 0 )
    {
        level.brwinnerscircle.viewingteam[ scenekey ] = undefined;
    }
}

// Namespace br_winners_circle
// Params 1
// Checksum 0xe5407482, Offset: 0x213b
// Size: 0x78
function function_8a42585bd6e47e9f( scenekey )
{
    if ( !isdefined( level.brwinnerscircle.viewingteam[ scenekey ] ) )
    {
        level.brwinnerscircle.viewingteam[ scenekey ] = [];
    }
    
    level.brwinnerscircle.viewingteam[ scenekey ][ level.brwinnerscircle.viewingteam[ scenekey ].size ] = self;
    self.var_bf0ef69bc92de89c = scenekey;
}

// Namespace br_winners_circle
// Params 1
// Checksum 0x24728e54, Offset: 0x21bb
// Size: 0x108
function function_e62f8c724ef1ab54( scenekey )
{
    if ( !isdefined( self.var_bf0ef69bc92de89c ) )
    {
        script::demoforcesre( "Player could not be removed; player is not viewing any winners circle!" );
        return;
    }
    
    if ( !isdefined( level.brwinnerscircle.viewingteam[ scenekey ] ) )
    {
        script::demoforcesre( "Player could not be removed; not found viewing winners circle for given team!" );
        return;
    }
    
    originalsize = level.brwinnerscircle.viewingteam[ scenekey ].size;
    level.brwinnerscircle.viewingteam[ scenekey ] = arrayremove( level.brwinnerscircle.viewingteam[ scenekey ], self );
    
    if ( originalsize == level.brwinnerscircle.viewingteam[ scenekey ].size )
    {
        script::demoforcesre( "Player could not be removed; not found viewing winners circle for given team!" );
    }
    
    if ( level.brwinnerscircle.viewingteam[ scenekey ].size == 0 )
    {
        level.brwinnerscircle.viewingteam[ scenekey ] = undefined;
    }
    
    self.var_bf0ef69bc92de89c = undefined;
}

// Namespace br_winners_circle
// Params 1
// Checksum 0xedd4195d, Offset: 0x22cb
// Size: 0x2b
function function_180813f6bfec5143( scenekey )
{
    function_d686da411642eb1b( scenekey );
    return level.brwinnerscircle.viewingteam[ scenekey ];
}

// Namespace br_winners_circle
// Params 2
// Checksum 0x1f22ec2d, Offset: 0x22ff
// Size: 0xaa
function function_4ba17bb1d3f614a0( sceneinfo, index )
{
    foreach ( var_c355d4a46d74189d in sceneinfo.var_c355d4a46d74189d )
    {
        if ( var_c355d4a46d74189d.characterindex == index )
        {
            return var_c355d4a46d74189d;
        }
    }
    
    script::demoforcesre( "Scene does not contain client info for character index " + index );
}

// Namespace br_winners_circle
// Params 1
// Checksum 0xa7992c4, Offset: 0x23b2
// Size: 0x8c
function function_fc088fdf052b4014( sceneinfo )
{
    for ( i = 0; i < sceneinfo.var_5b6d3d8924ce9881.size ; i++ )
    {
        omnvarname = "ui_br_winners_circle_accolade_" + i + 1;
        
        if ( !hasomnvar( omnvarname ) )
        {
            break;
        }
        
        accoladeindex = level.var_3abb05bb58a5e16e[ sceneinfo.var_5b6d3d8924ce9881[ i ].accoladeref ] ?? 0;
        self setclientomnvar( omnvarname, accoladeindex );
    }
}

// Namespace br_winners_circle
// Params 1
// Checksum 0x2bb4eb91, Offset: 0x2446
// Size: 0x14d
function function_9ec537116350ffed( sceneinfo )
{
    if ( utility::issharedfuncdefined( #"br_winners_circle", #"hash_418a4c51fcf5f883" ) )
    {
        var_55a511158069c0c9 = utility::callsharedfunc( #"br_winners_circle", #"hash_418a4c51fcf5f883", sceneinfo );
    }
    else
    {
        objectiverating = 0;
        var_6f699fef11efec7c = function_91eb07229a3a91ef( "objective_rating_gradetable", objectiverating );
        var_f1f5003ae55eb8ec = 0;
        var_81d806004f0cf436 = function_91eb07229a3a91ef( "accuracy_gradetable", var_f1f5003ae55eb8ec );
        mvpindex = int( clamp( sceneinfo.mvpindex, 0, 3 ) );
        contractscompleted = self.brmissionscompleted ?? 0;
        contractscompleted = int( clamp( contractscompleted, 0, 255 ) );
        var_55a511158069c0c9 = 0;
        currentoffset = 0;
        var_55a511158069c0c9 = omnvar_utility::repackomnvar( currentoffset, 2, var_55a511158069c0c9, mvpindex );
        currentoffset += 2;
        var_55a511158069c0c9 = omnvar_utility::repackomnvar( currentoffset, 4, var_55a511158069c0c9, var_6f699fef11efec7c );
        currentoffset += 4;
        var_55a511158069c0c9 = omnvar_utility::repackomnvar( currentoffset, 4, var_55a511158069c0c9, var_81d806004f0cf436 );
        currentoffset += 4;
        var_55a511158069c0c9 = omnvar_utility::repackomnvar( currentoffset, 8, var_55a511158069c0c9, contractscompleted );
        currentoffset += 8;
    }
    
    self setclientomnvar( "ui_br_winners_circle_extra_data", var_55a511158069c0c9 );
}

// Namespace br_winners_circle
// Params 2
// Checksum 0x7eccc70, Offset: 0x259b
// Size: 0x102
function function_91eb07229a3a91ef( gradetable, rawvalue )
{
    gradetablebundle = getscriptbundle( "gradetable:" + gradetable );
    
    if ( !isdefined( gradetablebundle ) )
    {
        script::demoforcesre( "Grade table '" + gradetable + "' not found!" );
        return 0;
    }
    
    rawvalue = float( rawvalue );
    var_ce3ea9777970b629 = undefined;
    chosenindex = undefined;
    
    for ( i = 0; i < gradetablebundle.var_33b3e8200e06fd7d.size ; i++ )
    {
        grade = gradetablebundle.var_33b3e8200e06fd7d[ i ];
        
        if ( rawvalue >= grade.var_2ead72286aa38384 )
        {
            if ( !isdefined( var_ce3ea9777970b629 ) || grade.var_2ead72286aa38384 > var_ce3ea9777970b629.var_2ead72286aa38384 )
            {
                var_ce3ea9777970b629 = grade;
                chosenindex = i;
            }
        }
    }
    
    if ( !isdefined( chosenindex ) )
    {
        script::demoforcesre( "Could not get a valid grade for value " + rawvalue + " in grade table: " + gradetable );
        return 0;
    }
    
    return chosenindex;
}

// Namespace br_winners_circle
// Params 1
// Checksum 0xc4d9cd91, Offset: 0x26a6
// Size: 0x101
function function_ead824df9963a891( sceneinfo )
{
    mvpindex = [];
    var_99095f3ccf809b04 = -2147483647;
    
    foreach ( index, var_5b6d3d8924ce9881 in sceneinfo.var_5b6d3d8924ce9881 )
    {
        if ( var_5b6d3d8924ce9881.var_f60031aca22cc8dc == var_99095f3ccf809b04 )
        {
            mvpindex[ mvpindex.size ] = index;
        }
        
        if ( var_5b6d3d8924ce9881.var_f60031aca22cc8dc > var_99095f3ccf809b04 )
        {
            mvpindex = [ index ];
            var_99095f3ccf809b04 = var_5b6d3d8924ce9881.var_f60031aca22cc8dc;
        }
    }
    
    if ( mvpindex.size == 0 )
    {
        script::demoforcesre( "Could not find a valid mvp index!" );
        return 0;
    }
    
    var_7c986a92981169e4 = utility::array_random( mvpindex );
    return var_7c986a92981169e4;
}

// Namespace br_winners_circle
// Params 0
// Checksum 0x1d120890, Offset: 0x27b0
// Size: 0xbb
function function_658cd866bbe100d6()
{
    var_51fb46d6c62615e2 = self.lastnormalweaponobj ?? self.currentprimaryweapon;
    
    if ( var_51fb46d6c62615e2.basename == level.laststandweapon )
    {
        var_51fb46d6c62615e2 = self.laststandoldweaponobj;
    }
    
    if ( self.var_2584bf6454cbc727 )
    {
        var_51fb46d6c62615e2 = self.var_2584bf6454cbc727;
    }
    
    if ( !weapons::isnormallastweapon( var_51fb46d6c62615e2 ) || !winners_circle::function_43fef757978b336b( var_51fb46d6c62615e2 ) )
    {
        var_51fb46d6c62615e2 = getscriptbundlefieldvalue( level.gametypebundle.brwinnerscircle, #"hash_fc656c1427201777" );
        
        if ( !isdefined( var_51fb46d6c62615e2 ) || var_51fb46d6c62615e2.size == 0 )
        {
            var_51fb46d6c62615e2 = "iw9_pi_golf17_mp";
        }
        
        var_51fb46d6c62615e2 = weapon::buildweapon( var_51fb46d6c62615e2 );
    }
    
    return var_51fb46d6c62615e2;
}

// Namespace br_winners_circle
// Params 3
// Checksum 0xc1cba168, Offset: 0x2874
// Size: 0xeb
function function_add4d32966c18ab2( team, scenename, squadid )
{
    teamplayers = function_910227633bd7a563( team, squadid );
    
    if ( teamplayers.size == 0 )
    {
        return;
    }
    
    br_accolades::function_8ffb08c901d9d792( teamplayers );
    key = function_7b2fbe1612db9720( team, squadid );
    level.brwinnerscircle.var_8c72aa87b4135825[ key ] = function_cfe12cc8bfe5ee22( team, scenename, squadid );
    
    foreach ( player in teamplayers )
    {
        player.var_4f97df463efd71b5 = undefined;
    }
}

// Namespace br_winners_circle
// Params 3
// Checksum 0x44cfb634, Offset: 0x2967
// Size: 0x73
function function_2229e2aff4a938f4( team, scenename, squadid )
{
    key = function_7b2fbe1612db9720( team, squadid );
    
    if ( key == level.brwinnerscircle.var_98a0a1962baa11dc )
    {
        return;
    }
    
    if ( !isdefined( level.brwinnerscircle.var_8c72aa87b4135825[ key ] ) )
    {
        function_add4d32966c18ab2( team, scenename, squadid );
    }
}

// Namespace br_winners_circle
// Params 1
// Checksum 0x99f8355c, Offset: 0x29e2
// Size: 0x8e
function function_5c5e20b9a15e9545( scenename = level.brwinnerscircle.defaultscenename )
{
    scene = level.brwinnerscircle.var_3f2c1303dc415cc7[ scenename ];
    
    if ( !isdefined( scene ) )
    {
        script::demoforcesre( "Winners circle scene '" + scenename + "' does not exist! Using default instead." );
        return level.brwinnerscircle.var_3f2c1303dc415cc7[ level.brwinnerscircle.defaultscenename ];
    }
    
    return scene;
}

// Namespace br_winners_circle
// Params 2
// Checksum 0x9a731211, Offset: 0x2a79
// Size: 0x69
function function_910227633bd7a563( team, squadid )
{
    if ( level.brwinnerscircle.usesquads )
    {
        assert( isdefined( squadid ), "<dev string:xf2>" );
        return teams::getsquadmates( team, squadid );
    }
    
    if ( !teams::function_b00ab7e503f33379( team, "players" ) )
    {
        return [];
    }
    
    return teams::getteamdata( team, "players" );
}

// Namespace br_winners_circle
// Params 2
// Checksum 0x5041bf36, Offset: 0x2aea
// Size: 0x44
function function_7b2fbe1612db9720( team, squadid )
{
    if ( level.brwinnerscircle.usesquads )
    {
        assert( isdefined( squadid ), "<dev string:x11c>" );
        return squadid;
    }
    
    return team;
}

// Namespace br_winners_circle
// Params 2
// Checksum 0xb9db3a0, Offset: 0x2b36
// Size: 0x82
function function_2c1d0f98c575125c( player, scenename )
{
    key = function_7b2fbe1612db9720( player.team, player.sessionsquadid );
    sceneinfo = level.brwinnerscircle.var_8c72aa87b4135825[ key ] ?? player function_cfe12cc8bfe5ee22( player.team, scenename, player.sessionsquadid );
    return sceneinfo;
}

// Namespace br_winners_circle
// Params 1
// Checksum 0x9f9dd952, Offset: 0x2bc1
// Size: 0x87
function function_3c7290d895e5e564( team )
{
    if ( !teams::function_b00ab7e503f33379( team, "players" ) )
    {
        return -1;
    }
    
    players = teams::getteamdata( team, "players" );
    
    if ( players.size == 0 )
    {
        return -1;
    }
    
    if ( utility::issharedfuncdefined( #"br_winners_circle", #"hash_fc621907a6ef6c9b" ) )
    {
        return utility::callsharedfunc( #"br_winners_circle", #"hash_fc621907a6ef6c9b", team );
    }
    
    return players[ 0 ].sessionsquadid;
}

// Namespace br_winners_circle
// Params 2
// Checksum 0x73a6d119, Offset: 0x2c51
// Size: 0x52
function function_1bccf6cd8b2c6318( player, winningteam )
{
    if ( player.team == winningteam || winningteam == "none" )
    {
        return function_2c1d0f98c575125c( player );
    }
    
    return level.brwinnerscircle.winnersscene;
}

/#

    // Namespace br_winners_circle
    // Params 2
    // Checksum 0x78e938b2, Offset: 0x2cab
    // Size: 0x1dc, Type: dev
    function function_1e08ed23bb00dc27( overrideskin, scenename )
    {
        self endon( #"disconnect" );
        skinRefs = operator::function_27f5412663e0a09();
        sceneinfo = spawnstruct();
        sceneinfo.var_5b6d3d8924ce9881 = [];
        var_8ec497f12f07a5de = [];
        
        for ( i = 0; i < 4 ; i++ )
        {
            var_c355d4a46d74189d = spawnstruct();
            var_c355d4a46d74189d.clientnum = self getentitynumber();
            var_c355d4a46d74189d.characterindex = i + 1;
            var_c355d4a46d74189d.skinref = function_c82104de716510cc( skinRefs, overrideskin );
            var_c355d4a46d74189d.operatorref = operator::function_30f20ce375c4ee40( var_c355d4a46d74189d.skinref );
            var_c355d4a46d74189d.weaponname = function_658cd866bbe100d6();
            var_8ec497f12f07a5de[ var_8ec497f12f07a5de.size ] = var_c355d4a46d74189d;
            var_5b6d3d8924ce9881 = spawnstruct();
            var_5b6d3d8924ce9881.var_c355d4a46d74189d = var_c355d4a46d74189d;
            var_5b6d3d8924ce9881.player = self;
            var_5b6d3d8924ce9881.accoladeref = self.var_4f97df463efd71b5 ?? "<dev string:x94>";
            var_5b6d3d8924ce9881.var_f60031aca22cc8dc = self.var_f60031aca22cc8dc ?? 0;
            sceneinfo.var_5b6d3d8924ce9881[ sceneinfo.var_5b6d3d8924ce9881.size ] = var_5b6d3d8924ce9881;
        }
        
        sceneinfo.var_c355d4a46d74189d = var_8ec497f12f07a5de;
        sceneinfo.team = self.team;
        sceneinfo.squad = self.sessionsquadid;
        sceneinfo.mvpindex = function_ead824df9963a891( sceneinfo );
        sceneinfo.scenelocation = function_5c5e20b9a15e9545( scenename );
        function_fc34073e1a01b360( sceneinfo );
        thread function_6c90c7d85653099a( sceneinfo );
    }

    // Namespace br_winners_circle
    // Params 2
    // Checksum 0x98f09bc5, Offset: 0x2e8f
    // Size: 0x3f, Type: dev
    function function_c82104de716510cc( skinRefs, overrideskin )
    {
        skinref = overrideskin ?? utility::array_random( skinRefs );
        dev_mp::function_7620e0b2c7508d1e( self, skinref );
        waitframe();
        return skinref;
    }

    // Namespace br_winners_circle
    // Params 1
    // Checksum 0xf816335a, Offset: 0x2ed6
    // Size: 0x13a, Type: dev
    function function_6c90c7d85653099a( sceneinfo )
    {
        self endon( #"disconnect" );
        self endon( #"br_winners_circle_end" );
        self endon( #"br_winners_circle_start" );
        
        while ( true )
        {
            foreach ( clientchara in level.brwinnerscircle.var_4a1d57c16bdcd276 )
            {
                index = clientchara getclientcharacterindex();
                var_c355d4a46d74189d = function_4ba17bb1d3f614a0( sceneinfo, index );
                skinref = var_c355d4a46d74189d.skinref;
                textheightoffset = 4 * ( index - 1 );
                pos = clientchara.origin + ( 0, 0, textheightoffset );
                var_b2966a3120c97bb3 = getxhashsourcename( skinref );
                print3d( pos, var_b2966a3120c97bb3, undefined, undefined, 0.2 );
            }
            
            waitframe();
        }
    }

#/

// Namespace br_winners_circle
// Params 1, eflags: 0x4
// Checksum 0xdfe1f428, Offset: 0x3018
// Size: 0xfa
function private function_7b4c4655bcc50709( timeoutms )
{
    var_70abbcd8388a1f80 = getscriptbundle( level.gametypebundle.brwinnerscircle );
    
    if ( !isdefined( var_70abbcd8388a1f80 ) )
    {
        return [];
    }
    
    var_add46cbbf96a99dc = [];
    var_add46cbbf96a99dc[ 0 ] = var_70abbcd8388a1f80.var_2469bbd1d4e532d;
    var_add46cbbf96a99dc[ 1 ] = var_70abbcd8388a1f80.var_24698bd1d4e4c94;
    var_add46cbbf96a99dc[ 2 ] = var_70abbcd8388a1f80.var_24699bd1d4e4ec7;
    var_add46cbbf96a99dc[ 3 ] = var_70abbcd8388a1f80.var_24696bd1d4e482e;
    indices = [];
    
    for ( i = 0; i < var_add46cbbf96a99dc.size ; i++ )
    {
        if ( !var_add46cbbf96a99dc[ i ] )
        {
            continue;
        }
        
        var_fd57da2e84bde403 = getscriptbundle( var_add46cbbf96a99dc[ i ] );
        
        if ( !isdefined( var_fd57da2e84bde403 ) )
        {
            continue;
        }
        
        collection = var_fd57da2e84bde403.var_f4c776d49172271e;
        
        if ( !collection )
        {
            continue;
        }
        
        indices[ indices.size ] = function_57b963e4635ebcf9( collection, timeoutms );
    }
    
    return indices;
}

