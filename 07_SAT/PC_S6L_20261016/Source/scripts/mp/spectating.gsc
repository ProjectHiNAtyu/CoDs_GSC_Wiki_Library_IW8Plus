// scripts\mp\spectating.gsc  (hash_10107dc25f5bd62e.gscc) (size: 8648 Bytes / 0x21c8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6ba2323d (1805791805)
// size ...... 8648 (0x21c8)
// includes .. 12  (offset: 0x1f54)
// strings ... 29  (offset: 0x1fb4)
// dev strs .. 0   (offset: 0x21c8)
// exports ... 20  (offset: 0x1428)
// cseg ...... 0x216 + 0x1212 (0x1428)
// imports ... 64  (offset: 0x1748)
// animtree1 . 0   (offset: 0x21c8)
// animtree2 . 0   (offset: 0x21c8)
#using scripts\common\utility;
#using scripts\mp\codcaster_utils;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gameinstance;
#using scripts\mp\playerlogic;

#namespace spectating;

// Namespace spectating
// Params 0
// Checksum 0xa6d6f034, Offset: 0x234
// Size: 0xb6
function init()
{
    foreach ( entry in level.teamnamelist )
    {
        level.spectateoverride[ entry ] = spawnstruct();
    }
    
    lui_game_event_aggregator::registeronluieventcallback( &freecamcallback );
    join_team_aggregator::registeronplayerjointeamcallback( &onjoinedteam );
    
    if ( getdvarint( @"hash_242c4deac00b8e5b", 0 ) != 0 )
    {
        level thread getlevelmlgcams();
    }
}

// Namespace spectating
// Params 2
// Checksum 0x8fbe9a0f, Offset: 0x2f2
// Size: 0x65
function createmlgcamobject( icon, followrotation )
{
    precacheshader( icon );
    camera = spawn( "script_model", ( 0, 0, 0 ) );
    camera setmodel( "tag_origin" );
    camera.angles = ( 0, 0, 0 );
    return camera;
}

// Namespace spectating
// Params 2
// Checksum 0xb5f07bce, Offset: 0x360
// Size: 0x117
function setlevelmlgcam( index, csvfile )
{
    tableindex = index;
    
    if ( tableindex >= 4 )
    {
        tableindex -= 4;
    }
    
    mapname = tolower( getdvar( @"g_mapname" ) );
    var_a735afa97861decd = tablelookup( csvfile, 0, mapname, tableindex * 2 + 1 );
    
    if ( var_a735afa97861decd != "" )
    {
        var_5ba913b0e8f027c3 = index + 1;
        
        if ( index >= 5 )
        {
            var_5ba913b0e8f027c3 -= 4;
        }
        
        level.cameramapobjs[ index ] = createmlgcamobject( "compass_icon_codcaster_cam", 1 );
        level.numbermapobjs[ index ] = createmlgcamobject( "compass_icon_codcaster_num" + var_5ba913b0e8f027c3, 0 );
        var_80f012aa18050aaf = tablelookup( csvfile, 0, mapname, tableindex * 2 + 2 );
        level.camerapos[ index ] = getcameravecorang( var_a735afa97861decd );
        level.cameraang[ index ] = getcameravecorang( var_80f012aa18050aaf );
        level.camerahighestindex = index;
    }
}

// Namespace spectating
// Params 0
// Checksum 0x81dffb25, Offset: 0x47f
// Size: 0xa1
function getlevelmlgcams()
{
    while ( !isdefined( level.objectiveidpool ) )
    {
        waitframe();
    }
    
    csvfile = "mp/CameraPositions";
    var_9badc4593d1a11b2 = csvfile + "_" + game_utility::getgametype() + ".csv";
    csvfile += ".csv";
    level.cameramapobjs = [];
    level.numbermapobjs = [];
    
    for ( index = 0; index < 4 ; index++ )
    {
        setlevelmlgcam( index, csvfile );
    }
    
    for ( index = 4; index < 8 ; index++ )
    {
        setlevelmlgcam( index, var_9badc4593d1a11b2 );
    }
}

// Namespace spectating
// Params 1
// Checksum 0xa0ae8d45, Offset: 0x528
// Size: 0x6d
function getcameravecorang( elementstring )
{
    var_33965ef43072da7d = strtok( elementstring, " " );
    var_62cf2b97bbce5e06 = ( 0, 0, 0 );
    
    if ( isdefined( var_33965ef43072da7d[ 0 ] ) && isdefined( var_33965ef43072da7d[ 1 ] ) && isdefined( var_33965ef43072da7d[ 2 ] ) )
    {
        var_62cf2b97bbce5e06 = ( int( var_33965ef43072da7d[ 0 ] ), int( var_33965ef43072da7d[ 1 ] ), int( var_33965ef43072da7d[ 2 ] ) );
    }
    
    return var_62cf2b97bbce5e06;
}

// Namespace spectating
// Params 1
// Checksum 0xd1f7067, Offset: 0x59e
// Size: 0x15
function onjoinedteam( player )
{
    player setspectatepermissions();
}

// Namespace spectating
// Params 1
// Checksum 0x4d354253, Offset: 0x5bb
// Size: 0x7f
function onjoinedspectators( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player thread onspectatingclient();
    player thread onspectatingmlgcamera();
    player setspectatepermissions();
    player setclientomnvar( "ui_callout_area_id", -1 );
    
    if ( player iscodcaster() || player.pers[ "codcaster" ] )
    {
        player setcodcaster( 1 );
        player thread updatecodcaster();
        player thread autoattachtoplayer();
        player thread saveendgamelocals();
    }
}

// Namespace spectating
// Params 0
// Checksum 0xfb80ee44, Offset: 0x642
// Size: 0x86
function onspectatingclient()
{
    self endon( #"disconnect" );
    self endon( #"joined_team" );
    
    for ( ;; )
    {
        self waittill( #"spectating_cycle" );
        player = self getspectatingplayer();
        
        if ( isdefined( player ) )
        {
            if ( isdefined( player.calloutarea ) )
            {
                areaid = level.calloutglobals.areaidmap[ player.calloutarea ];
                self setclientomnvar( "ui_callout_area_id", areaid );
            }
        }
    }
}

// Namespace spectating
// Params 0
// Checksum 0xfbc570ec, Offset: 0x6d0
// Size: 0x6c
function onspectatingmlgcamera()
{
    self endon( #"disconnect" );
    self endon( #"joined_team" );
    
    for ( ;; )
    {
        self waittill( #"spectating_mlg_camera" );
        selectedcamera = self getmlgselectedcamera();
        
        if ( self iscodcaster() || self.pers[ "codcaster" ] )
        {
            if ( isdefined( selectedcamera ) )
            {
                self setclientomnvar( "ui_callout_area_id", -1 );
            }
        }
    }
}

// Namespace spectating
// Params 2
// Checksum 0x7c1f0fde, Offset: 0x744
// Size: 0x27
function freecamcallback( channel, view )
{
    if ( channel == "mlg_view_change" )
    {
        playerlogic::resetuidvarsonspectate();
    }
}

// Namespace spectating
// Params 1
// Checksum 0x2c2f7b51, Offset: 0x773
// Size: 0x51
function updatespectatesettings( instanceid )
{
    level endon( #"game_ended" );
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        level.players[ index ] setspectatepermissions( undefined, instanceid );
    }
}

// Namespace spectating
// Params 0
// Checksum 0x56a5f591, Offset: 0x7cc
// Size: 0x171
function autoattachtoplayer()
{
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    self endon( #"spectating_mlg_camera" );
    level utility::waittill_any( "prematch_started", "prematch_done", "start_mode_setup", "infil_started" );
    level.lastspectatedplayer = game[ "lastSpectatedPlayer" ];
    
    for ( ;; )
    {
        selectedclientnum = undefined;
        
        if ( !self iscodcaster() || self isspectatingplayer() || self ismlgfreecamenabled() || self ismlgaerialcamenabled() )
        {
            break;
        }
        
        if ( level.players.size > 1 )
        {
            if ( level.currentround > 1 && isdefined( level.lastspectatedplayer ) )
            {
                selectedclientnum = level.lastspectatedplayer;
            }
            else
            {
                foreach ( entry in level.teamnamelist )
                {
                    aliveplayers = teams::getfriendlyplayers( entry, 1 );
                    
                    if ( aliveplayers.size > 0 )
                    {
                        selectedclientnum = player::getlowestclientnum( aliveplayers, 1 );
                    }
                }
            }
            
            if ( isdefined( selectedclientnum ) )
            {
                self spectateclientnum( selectedclientnum );
                break;
            }
        }
        
        wait 1;
    }
}

// Namespace spectating
// Params 0
// Checksum 0x7c81499a, Offset: 0x945
// Size: 0x87
function updatecodcaster()
{
    self endon( #"joined_team" );
    self endon( #"disconnect" );
    self.iswatchingcodcasterball = 0;
    self.codcasterballcamfollow = undefined;
    self.spectatingplayerbeforeballcam = undefined;
    
    for ( ;; )
    {
        if ( self iscodcaster() && self isspectatingplayer() )
        {
            player = self getspectatingplayer();
            
            if ( isdefined( player ) )
            {
                level.lastspectatedplayer = player.clientid;
            }
            
            player codcaster_utils::function_ba4d0515f8c36de2( self );
        }
        
        wait 0.05;
    }
}

// Namespace spectating
// Params 0
// Checksum 0x1156c65c, Offset: 0x9d4
// Size: 0x20
function saveendgamelocals()
{
    level waittill( #"game_ended" );
    game[ "lastSpectatedPlayer" ] = level.lastspectatedplayer;
}

// Namespace spectating
// Params 2
// Checksum 0xc13bede5, Offset: 0x9fc
// Size: 0x6c6
function setspectatepermissions( gameended, var_9ce2956d554dac7a )
{
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        var_e8b77a42a12f4bfc = var_9ce2956d554dac7a == self.instanceid;
        
        if ( !var_e8b77a42a12f4bfc && ( gameinstance::is_instance_complete( self.instanceid ) || game[ "eliminated" ][ self.team ] ) )
        {
            if ( level.teambased )
            {
                self allowspectateteam( self.team, 0 );
                self allowspectateteam( "freelook", 0 );
                self allowspectateteam( "none", 0 );
                relevantteams = gameinstance::get_instance_teams( self.instanceid );
                
                foreach ( entry in level.teamnamelist )
                {
                    instanceid = gameinstance::get_instance_id( entry );
                    
                    if ( gameinstance::is_instance_complete( instanceid ) )
                    {
                        self allowspectateteam( entry, 0 );
                        continue;
                    }
                    
                    self allowspectateteam( entry, 1 );
                }
            }
            
            player::updatesessionstate( "spectator" );
            return;
        }
    }
    
    if ( level.gameended && gettime() - level.gameendtime >= 2000 && !level.postgameexfil )
    {
        if ( level.teambased )
        {
            foreach ( entry in level.teamnamelist )
            {
                self allowspectateteam( entry, 0 );
            }
        }
        
        self allowspectateteam( "freelook", 0 );
        self allowspectateteam( "none", 1 );
        return;
    }
    
    spectatetype = getmatchrulesdata( "commonOption", "spectateModeAllowed" );
    
    if ( getdvarint( @"hash_e32ebdbb97a1ec4e", 0 ) == 1 )
    {
        spectatetype = 2;
    }
    
    if ( self iscodcaster() )
    {
        spectatetype = 2;
    }
    
    if ( self.inspawncamera || isdefined( self.setspawnpoint ) && playerlogic::mayspawn() )
    {
        spectatetype = 0;
    }
    
    if ( gameended )
    {
        spectatetype = 2;
    }
    
    if ( level.disablespectate )
    {
        spectatetype = 0;
    }
    
    team = self.sessionteam;
    
    switch ( spectatetype )
    {
        case 0:
            setdisabled();
            break;
        case 1:
            self notify( #"hash_ac2c85ed6cf507ac" );
            
            if ( team != "spectator" && team != "codcaster" )
            {
                if ( level.gametype == "sd" || level.gametype == "arena" )
                {
                    if ( team == "allies" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 1 );
                    }
                    else if ( team == "axis" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 2 );
                    }
                }
                
                setteamorplayeronly( team );
            }
            else if ( isdefined( self.pers[ "last_team" ] ) )
            {
                if ( level.gametype == "sd" || level.gametype == "arena" )
                {
                    if ( self.pers[ "last_team" ] == "allies" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 1 );
                    }
                    else if ( self.pers[ "last_team" ] == "axis" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 2 );
                    }
                }
                
                team = self.pers[ "last_team" ];
                setteamorplayeronly( team );
            }
            else if ( level.prematchstarted )
            {
                randidx = randomint( level.teamnamelist.size );
                setteamorplayeronly( level.teamnamelist[ randidx ] );
                
                if ( level.gametype == "sd" || level.gametype == "arena" )
                {
                    self setclientomnvar( "ui_team_before_spectating", randidx );
                }
            }
            else
            {
                setteamorplayeronly( "allies" );
                
                if ( level.gametype == "sd" || level.gametype == "arena" )
                {
                    self setclientomnvar( "ui_team_before_spectating", 1 );
                }
                
                thread waitforgamestartspectate();
                return;
            }
            
            break;
        case 2:
            setfreelook( gameended );
            break;
        case 3:
            if ( team == "spectator" || team == "codcaster" )
            {
                setfreelook();
            }
            else
            {
                setteamorplayeronly( team );
            }
            
            break;
    }
    
    if ( team_utility::isgameplayteam( team ) )
    {
        if ( level.spectateoverride[ team ].allowfreespectate )
        {
            self allowspectateteam( "freelook", 1 );
        }
        
        if ( level.spectateoverride[ team ].allowenemyspectate )
        {
            enemyteams = team_utility::getenemyteams( team );
            
            foreach ( entry in enemyteams )
            {
                self allowspectateteam( entry, 1 );
            }
        }
    }
    
    var_3b8df423e0822a90 = game_utility_mp::privatematch() && isbrgamemode();
    
    /#
        if ( getdvarint( @"hash_f7fccc8ff6925d24", 0 ) != 0 )
        {
            var_3b8df423e0822a90 = 1;
        }
    #/
    
    if ( var_3b8df423e0822a90 && ( self.sessionteam == "spectator" || self.sessionteam == "codcaster" ) )
    {
        foreach ( entry in level.teamnamelist )
        {
            if ( !team_utility::isgameplayteam( entry ) )
            {
                continue;
            }
            
            self allowspectateteam( entry, 1 );
        }
        
        player::updatesessionstate( "spectator" );
    }
}

// Namespace spectating
// Params 0
// Checksum 0xe0883914, Offset: 0x10ca
// Size: 0x2e
function waitforgamestartspectate()
{
    self endon( #"hash_ac2c85ed6cf507ac" );
    self endon( #"disconnect" );
    level waittill( #"prematch_started" );
    thread setspectatepermissions();
}

// Namespace spectating
// Params 0
// Checksum 0xd8a19b57, Offset: 0x1100
// Size: 0x93
function setdisabled()
{
    self allowspectateteam( "freelook", 0 );
    self allowspectateteam( "none", 0 );
    
    foreach ( entry in level.teamnamelist )
    {
        self allowspectateteam( entry, 0 );
    }
}

// Namespace spectating
// Params 1
// Checksum 0x6e2e8d09, Offset: 0x119b
// Size: 0x13d
function setteamorplayeronly( team )
{
    self allowspectateteam( "freelook", 0 );
    
    if ( level.teambased )
    {
        self allowspectateteam( "none", 0 );
        
        foreach ( entry in level.teamnamelist )
        {
            if ( team == entry )
            {
                self allowspectateteam( entry, 1 );
                continue;
            }
            
            self allowspectateteam( entry, 0 );
        }
        
        return;
    }
    
    self allowspectateteam( "none", 1 );
    
    foreach ( entry in level.teamnamelist )
    {
        self allowspectateteam( entry, 1 );
    }
}

// Namespace spectating
// Params 1
// Checksum 0x1058bdfb, Offset: 0x12e0
// Size: 0x148
function setfreelook( gameended )
{
    self allowspectateteam( "freelook", 1 );
    self allowspectateteam( "none", 1 );
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        foreach ( entry in level.teamnamelist )
        {
            self allowspectateteam( entry, 1 );
        }
        
        if ( gameended )
        {
            thread playerlogic::spawnspectator( undefined, undefined, 1 );
        }
        
        return;
    }
    
    if ( self iscodcaster() )
    {
        self allowspectateteam( "allies", 1 );
        self allowspectateteam( "axis", 1 );
        thread waitforgamestartspectate();
        return;
    }
    
    team = self.sessionteam;
    
    if ( self == level.players[ 0 ] || team == "spectator" || team == "codcaster" )
    {
        self allowspectateteam( "allies", 1 );
        self allowspectateteam( "axis", 0 );
        thread waitforgamestartspectate();
    }
}

