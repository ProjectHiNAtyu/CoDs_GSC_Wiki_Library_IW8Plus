// scripts\mp\gametypes\bounty.gsc  (hash_7f1a93b7c2555b45.gscc) (size: 13489 Bytes / 0x34b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xedafbf87 (3987718023)
// size ...... 13489 (0x34b1)
// includes .. 24  (offset: 0x3011)
// strings ... 58  (offset: 0x30d1)
// dev strs .. 5   (offset: 0x3469)
// exports ... 25  (offset: 0x1eb1)
// cseg ...... 0x4d0 + 0x19e1 (0x1eb1)
// imports ... 113 (offset: 0x2299)
// animtree1 . 0   (offset: 0x34b1)
// animtree2 . 0   (offset: 0x34b1)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnlogic;

#namespace bounty;

// Namespace bounty
// Params 0
// Checksum 0xcd2ae605, Offset: 0x4ee
// Size: 0x1f4
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.bounty = spawnstruct();
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    level.bounty = spawnstruct();
    updategametypedvars();
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        game[ "dialog" ][ "gametype" ] = "dx_mp_boun_game_uktl_bnt1";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "dx_mp_boun_game_uktl_bynm";
    }
    
    game[ "dialog" ][ "offense_obj" ] = "dx_mp_boun_game_uktl_bybo";
    game[ "dialog" ][ "defense_obj" ] = "dx_mp_boun_game_uktl_bybo";
    game[ "dialog" ][ "bounty_new_targets_warning" ] = "dx_mp_boun_game_uktl_bytw";
    game[ "dialog" ][ "bounty_new_target" ] = "dx_mp_boun_game_uktl_bynt";
    game[ "dialog" ][ "bounty_become_target" ] = "dx_mp_boun_game_uktl_bybt";
    
    if ( !isdefined( level.waypointcolors[ "bounty_enemy" ] ) )
    {
        gamelogic_mp::setwaypointiconinfo( "bounty_enemy", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_hvt_enemy", 0, undefined );
    }
    
    if ( !isdefined( level.waypointcolors[ "bounty_friendly" ] ) )
    {
        gamelogic_mp::setwaypointiconinfo( "bounty_friendly", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hvt_friendly", 0, 12 );
    }
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
    
    callback::add( #"hash_57a74c8771bf7e7", &dontconsiderafk );
    level thread function_3c3d245b24f05683();
}

// Namespace bounty
// Params 1
// Checksum 0xc36fbb28, Offset: 0x6ea
// Size: 0x3b, Type: bool
function dontconsiderafk( params )
{
    if ( arraycontains( level.bounty.hvts[ self.pers[ "team" ] ], self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bounty
// Params 0
// Checksum 0xfaddd49a, Offset: 0x72e
// Size: 0x81
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_war_promode", 0 );
    setdynamicdvar( @"hash_5d63372846c76438", getmatchrulesdata( "bountyData", "hvtsPerTeam" ) );
    setdynamicdvar( @"hash_dd0cfb059eb759f1", getmatchrulesdata( "bountyData", "pointsPerHVTKill" ) );
    
    if ( getdvarint( @"jup", 0 ) )
    {
        setdynamicdvar( @"hash_5d63372846c76438", 1 );
        setdynamicdvar( @"hash_dd0cfb059eb759f1", 5 );
    }
}

// Namespace bounty
// Params 0
// Checksum 0x56011fc5, Offset: 0x7b7
// Size: 0x15e
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/bounty" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/bounty" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/bounty_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/bounty_hint" );
    }
    
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
    }
    else
    {
        initspawns();
    }
    
    bradley_spawner::inittankspawns();
    
    /#
        if ( false )
        {
            function_3d2f6adc4704da26();
        }
    #/
}

// Namespace bounty
// Params 0, eflags: 0x4
// Checksum 0x26fdcd78, Offset: 0x91d
// Size: 0x152
function private function_3c3d245b24f05683()
{
    level waittill( #"prematch_over" );
    level.bounty.hvts = [];
    
    if ( isdefined( level.scoremod[ "kill" ] ) )
    {
        level.bounty.pointsperhvtkill -= level.scoremod[ "kill" ];
        
        if ( level.bounty.pointsperhvtkill < 0 )
        {
            level.bounty.pointsperhvtkill = 0;
        }
    }
    
    foreach ( teamname in level.teamnamelist )
    {
        level.bounty.hvts[ teamname ] = [];
    }
    
    wait 10;
    level thread function_68f3872d55f877d7();
    callback::add( #"player_spawned", &onplayerspawn );
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
}

// Namespace bounty
// Params 0
// Checksum 0xf50ac8eb, Offset: 0xa77
// Size: 0x10f
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.bounty.hvtsperteam = dvars::dvarintvalue( "hvtsPerTeam", 1, 1, 6 );
    level.bounty.pointsperhvtkill = dvars::dvarintvalue( "pointsPerHVTKill", 5, 1, 25 );
    level.bounty.warnteamhvtchange = dvars::dvarintvalue( "warnTeamHVTChange", 0, 0, 1 );
    level.bounty.hvtrefreshinterval = dvars::dvarintvalue( "hvtRefreshInterval", 30, 0, 120 );
    level.bounty.hvtrefreshwarntime = dvars::dvarintvalue( "hvtRefreshWarnTime", 10, 0, 30 );
    level.bounty.hvtmarkerpingenabled = dvars::dvarintvalue( "hvtMarkerPingEnabled", 0, 0, 1 );
    level.bounty.hvtmarkerpinginterval = dvars::dvarfloatvalue( "hvtMarkerPingInterval", 5, 0, 60 );
}

// Namespace bounty
// Params 0
// Checksum 0xc16c877b, Offset: 0xb8e
// Size: 0x148
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
    spawnlogic::addspawnpointslegacy( game[ "attackers" ], "mp_tdm_spawn_allies_start" );
    spawnlogic::addspawnpointslegacy( game[ "defenders" ], "mp_tdm_spawn_axis_start" );
    attackers = spawnlogic::getspawnpointarray( "mp_tdm_spawn_allies_start" );
    defenders = spawnlogic::getspawnpointarray( "mp_tdm_spawn_axis_start" );
    spawnlogic::registerspawnset( #"start_attackers", attackers );
    spawnlogic::registerspawnset( #"start_defenders", defenders );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn_secondary", 1, 1 );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn_secondary", 1, 1 );
    spawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    spawnssecondary = spawnlogic::getspawnpointarray( "mp_tdm_spawn_secondary" );
    spawnlogic::registerspawnset( #"primary", spawns );
    spawnlogic::registerspawnset( #"fallback", spawnssecondary );
    spawnlogic::finalizemap();
}

// Namespace bounty
// Params 0
// Checksum 0x6fb4d6af, Offset: 0xcde
// Size: 0xbb
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    spawnpoint = undefined;
    
    if ( spawnlogic::shoulduseteamstartspawn() )
    {
        if ( spawnteam == game[ "attackers" ] )
        {
            spawnlogic::activatespawnset( #"start_attackers", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_attackers" );
        }
        else
        {
            spawnlogic::activatespawnset( #"start_defenders", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_defenders" );
        }
    }
    else
    {
        spawnlogic::activatespawnset( #"primary", 1 );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"fallback" );
    }
    
    return spawnpoint;
}

// Namespace bounty
// Params 1
// Checksum 0x1d973553, Offset: 0xda2
// Size: 0x1c
function onspawnplayer( revivespawn )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
}

// Namespace bounty
// Params 6
// Checksum 0x67453035, Offset: 0xdc6
// Size: 0x26a
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( isdefined( victim.trackedobject ) )
    {
        objidpoolmanager::update_objective_state( victim.trackedobject.pingobjidnum, "invisible" );
    }
    
    attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
    
    if ( isdefined( victim ) && arraycontains( level.bounty.hvts[ victim.team ], victim ) )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "hvtKills" ] ) )
            {
                attacker.leaderboarddata[ "hvtKills" ] = attacker.leaderboarddata[ "hvtKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "hvtKills" ] ) )
            {
                [[ level.leaderboardfunc[ "hvtKills" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( attacker.pers[ "hvtKills" ] ) )
            {
                attacker.pers[ "hvtKills" ] = attacker.pers[ "hvtKills" ] + 1;
            }
        }
        
        attacker stats::setextrascore0( attacker.pers[ "hvtKills" ], "hvtKills" );
        attacker thread points::function_aa3f27bc29d005fc( #"hvt_kill", objweapon, victim );
        
        if ( level.bounty.pointsperhvtkill > 0 )
        {
            gamescore::giveteamscoreforobjective( attacker.team, level.bounty.pointsperhvtkill, 0 );
            attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 15, level.bounty.pointsperhvtkill );
        }
        
        victim gameplay_sound_fx::function_6dac8db778849e61( #"hash_71b1e912d24778f8", victim.team, undefined, victim );
        victim gameplay_sound_fx::function_6dac8db778849e61( #"hash_62bce722b6d2d3c0", team_utility::getotherteam( victim.team ), undefined, victim );
    }
}

/#

    // Namespace bounty
    // Params 0
    // Checksum 0x728284c4, Offset: 0x1038
    // Size: 0x282, Type: dev
    function function_3d2f6adc4704da26()
    {
        wait 5;
        ents = getentarray( "<dev string:x4a>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        ents = getentarray( "<dev string:x55>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x4a>", "<dev string:x68>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x55>", "<dev string:x68>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
    }

#/

// Namespace bounty
// Params 0
// Checksum 0xf3c125c5, Offset: 0x12c2
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

// Namespace bounty
// Params 0, eflags: 0x4
// Checksum 0xb3217d09, Offset: 0x1318
// Size: 0x267
function private function_68f3872d55f877d7()
{
    self endon( #"game_ended" );
    
    if ( !level.bounty.var_a1fa2fbd6627aa19 )
    {
        level.bounty.var_a1fa2fbd6627aa19 = 1;
    }
    else
    {
        return;
    }
    
    while ( true )
    {
        foreach ( teamname in level.teamnamelist )
        {
            function_52d2e158c71e5460( teamname );
        }
        
        if ( level.bounty.warnteamhvtchange )
        {
            assert( level.bounty.hvtrefreshinterval > level.bounty.hvtrefreshwarntime, "<dev string:x7a>" );
            wait level.bounty.hvtrefreshinterval - level.bounty.hvtrefreshwarntime;
            
            foreach ( teamname in level.teamnamelist )
            {
                dialog::statusdialog( #"bounty_new_targets_warning", teamname );
                
                foreach ( player in teams::getteamdata( teamname, "alivePlayers" ) )
                {
                    player hud_message::showsplash( "bounty_hvt_warn_change" );
                    player gameplay_sound_fx::playlocalsoundfx( #"bounty_new_target" );
                }
            }
            
            wait level.bounty.hvtrefreshwarntime;
            continue;
        }
        
        wait level.bounty.hvtrefreshinterval;
    }
}

// Namespace bounty
// Params 2, eflags: 0x4
// Checksum 0xfd8530ca, Offset: 0x1587
// Size: 0x253
function private function_52d2e158c71e5460( teamname, ignoretimestamp )
{
    newhvts = [];
    players = function_6c9b42f03b1c766d( teamname );
    
    foreach ( player in players )
    {
        if ( newhvts.size < level.bounty.hvtsperteam )
        {
            if ( !arraycontains( level.bounty.hvts[ teamname ], player ) )
            {
                newhvts[ newhvts.size ] = player;
                continue;
            }
        }
        
        player gameplay_sound_fx::playlocalsoundfx( "bounty_new_target" );
    }
    
    dialog::statusdialog( #"bounty_new_target", teamname, undefined, newhvts );
    
    foreach ( player in level.bounty.hvts[ teamname ] )
    {
        if ( isdefined( player ) && !arraycontains( newhvts, player ) )
        {
            player thread function_596e25a66a677b5a();
        }
    }
    
    foreach ( player in newhvts )
    {
        if ( isdefined( player ) && !arraycontains( level.bounty.hvts[ teamname ], player ) )
        {
            player thread function_8ddbd79128e0137d();
        }
    }
    
    level.bounty.hvts[ teamname ] = newhvts;
    
    if ( !ignoretimestamp )
    {
        level.bounty.var_a006dc8d2d277001 = gettime();
    }
}

// Namespace bounty
// Params 0, eflags: 0x4
// Checksum 0x26cc05eb, Offset: 0x17e2
// Size: 0xe1
function private function_8ddbd79128e0137d()
{
    self endon( #"disconnect" );
    self endon( #"bounty_unmarked" );
    self notify( #"bounty_marked" );
    
    if ( !player::isreallyalive( self ) )
    {
        self waittill( #"spawned_player" );
    }
    
    self.nosuspensemusic = 1;
    
    if ( getdvarint( @"hash_61e9133b2e499a6c" ) )
    {
        self setplayermusicstate( "mp_sd_bombplanted_30_playlist_classic" );
    }
    else
    {
        self setplayermusicstate( "mp_sd_bombplanted_30_playlist" );
    }
    
    function_9efc59c3faf6a307();
    hud_message::showsplash( "bounty_hvt_marked" );
    dialog::leaderdialogonplayer( #"bounty_become_target" );
    gameplay_sound_fx::playlocalsoundfx( #"bounty_marked_player" );
    gameplay_sound_fx::function_6dac8db778849e61( #"bounty_marked_enemy", self.team, self, self );
    gameplay_sound_fx::function_6dac8db778849e61( #"bounty_marked_team", team_utility::getotherteam( self.team ), undefined, self );
}

// Namespace bounty
// Params 0, eflags: 0x4
// Checksum 0x5b49d659, Offset: 0x18cb
// Size: 0x7f
function private function_596e25a66a677b5a()
{
    self endon( #"disconnect" );
    self endon( #"bounty_marked" );
    self notify( #"bounty_unmarked" );
    self.nosuspensemusic = undefined;
    self setplayermusicstate( "" );
    function_25fa0c68686d6f81();
    waitframe();
    
    if ( isplayer( self ) )
    {
        if ( !player::isreallyalive( self ) )
        {
            self waittill( #"spawned_player" );
        }
        
        hud_message::showsplash( "bounty_hvt_unmarked" );
        gameplay_sound_fx::playlocalsoundfx( #"bounty_unmarked_player" );
    }
}

// Namespace bounty
// Params 0, eflags: 0x4
// Checksum 0x2a5b37dd, Offset: 0x1952
// Size: 0x22d
function private function_9efc59c3faf6a307()
{
    if ( !isdefined( self.trackedobject ) )
    {
        trackedobject = gameobjects::createtrackedobject( self, ( 0, 0, 100 ) );
        objidpoolmanager::objective_set_play_intro( trackedobject.objidnum, 0 );
        objidpoolmanager::objective_set_play_outro( trackedobject.objidnum, 0 );
        trackedobject.objidpingfriendly = level.bounty.hvtmarkerpingenabled != 0;
        trackedobject.objidpingenemy = 0;
        trackedobject.objpingdelay = level.bounty.hvtmarkerpinginterval;
        trackedobject gameobjects::setobjectivestatusicons( "bounty_friendly" );
        trackedobject gameobjects::setvisibleteam( "friendly" );
        self.trackedobject = trackedobject;
        trackedobject.pingobjidnum = objidpoolmanager::requestobjectiveid( 99 );
        objidpoolmanager::objective_add_objective( trackedobject.pingobjidnum, "current", self.origin );
        objidpoolmanager::objective_set_play_intro( trackedobject.pingobjidnum, 0 );
        objidpoolmanager::objective_set_play_outro( trackedobject.pingobjidnum, 0 );
        objidpoolmanager::update_objective_ownerteam( trackedobject.pingobjidnum, self.team );
        trackedobject gameobjects::updatecompassicon( "enemy", trackedobject.pingobjidnum );
        objidpoolmanager::update_objective_icon( trackedobject.pingobjidnum, level.waypointshader[ "bounty_enemy" ] );
        objidpoolmanager::update_objective_setenemylabel( trackedobject.pingobjidnum, level.waypointstring[ "bounty_enemy" ] );
        objidpoolmanager::update_objective_state( trackedobject.pingobjidnum, "current" );
        objidpoolmanager::update_objective_objectiveid( trackedobject.pingobjidnum, 0 );
    }
    else
    {
        self.trackedobject gameobjects::setvisibleteam( "friendly" );
        objidpoolmanager::update_objective_state( self.trackedobject.pingobjidnum, "current" );
    }
    
    if ( !isdefined( self.bountyobject ) )
    {
        self.bountyobject = "prop_king_game_flag";
        self attach( self.bountyobject, "tag_stowed_back3", 1 );
    }
}

// Namespace bounty
// Params 0, eflags: 0x4
// Checksum 0xf0babac0, Offset: 0x1b87
// Size: 0x98
function private function_25fa0c68686d6f81()
{
    if ( isdefined( self.trackedobject ) )
    {
        if ( isdefined( self.trackedobject.pingobjidnum ) )
        {
            objidpoolmanager::returnobjectiveid( self.trackedobject.pingobjidnum );
            self.trackedobject.pingobjidnum = undefined;
        }
        
        self.trackedobject gameobjects::deletetrackedobject();
        self.trackedobject = undefined;
    }
    
    if ( isdefined( self.bountyobject ) )
    {
        self detach( self.bountyobject, "tag_stowed_back3" );
        self.bountyobject = undefined;
    }
}

// Namespace bounty
// Params 0, eflags: 0x4
// Checksum 0xd14ed162, Offset: 0x1c27
// Size: 0x5c, Type: bool
function private function_8a340c7906740e9a()
{
    if ( isdefined( self.bountyobject ) )
    {
        attachsize = self getattachsize();
        
        for ( i = 0; i < attachsize ; i++ )
        {
            attached = self getattachmodelname( i );
            
            if ( attached == self.bountyobject )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace bounty
// Params 1, eflags: 0x4
// Checksum 0xef5b9bd6, Offset: 0x1c8c
// Size: 0x66
function private onplayerspawn( params )
{
    if ( isdefined( self.bountyobject ) && !function_8a340c7906740e9a() )
    {
        self attach( self.bountyobject, "tag_stowed_back3", 1 );
    }
    
    if ( isdefined( self.trackedobject ) )
    {
        objidpoolmanager::update_objective_state( self.trackedobject.pingobjidnum, "current" );
    }
}

// Namespace bounty
// Params 1, eflags: 0x4
// Checksum 0xd4115e60, Offset: 0x1cfa
// Size: 0x11b
function private onplayerdisconnect( player )
{
    if ( isdefined( level.bounty.var_a006dc8d2d277001 ) && arraycontains( level.bounty.hvts[ player.team ], player ) )
    {
        var_8a3b25158d315f9a = level.bounty.hvtrefreshinterval * 1000;
        hvtrefreshwarntime = level.bounty.hvtrefreshwarntime * 1000 * level.bounty.warnteamhvtchange;
        var_73e3339ddbb28523 = level.bounty.var_a006dc8d2d277001 + var_8a3b25158d315f9a - hvtrefreshwarntime - gettime();
        
        if ( var_73e3339ddbb28523 > 5000 )
        {
            function_52d2e158c71e5460( player.team, 1 );
            return;
        }
        
        player thread function_596e25a66a677b5a();
        arrayremove( level.bounty.hvts[ player.team ], player );
    }
}

// Namespace bounty
// Params 1, eflags: 0x4
// Checksum 0x1dc39a02, Offset: 0x1e1d
// Size: 0x25
function private getplayerkills( player = self )
{
    return player.pers[ "kills" ];
}

// Namespace bounty
// Params 2, eflags: 0x4
// Checksum 0x87bf6213, Offset: 0x1e4b
// Size: 0x26, Type: bool
function private function_dce9f49cf9bffb7c( lhs, rhs )
{
    return getplayerkills( lhs ) > getplayerkills( rhs );
}

// Namespace bounty
// Params 1, eflags: 0x4
// Checksum 0x506ba801, Offset: 0x1e7a
// Size: 0x36
function private function_6c9b42f03b1c766d( teamname )
{
    players = level.teamdata[ teamname ][ "players" ];
    return arraysort( players, undefined, &function_dce9f49cf9bffb7c );
}

