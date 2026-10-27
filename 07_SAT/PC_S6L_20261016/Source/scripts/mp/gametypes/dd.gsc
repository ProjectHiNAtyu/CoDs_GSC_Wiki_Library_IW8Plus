// scripts\mp\gametypes\dd.gsc  (hash_2943bca09c2a8006.gscc) (size: 21123 Bytes / 0x5283 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f8cf16e (2139943278)
// size ...... 21123 (0x5283)
// includes .. 24  (offset: 0x49f7)
// strings ... 112 (offset: 0x4ab7)
// dev strs .. 10  (offset: 0x5203)
// exports ... 43  (offset: 0x2f9b)
// cseg ...... 0x88b + 0x2710 (0x2f9b)
// imports ... 163 (offset: 0x3653)
// animtree1 . 0   (offset: 0x5283)
// animtree2 . 0   (offset: 0x5283)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\matchdata;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace dd;

// Namespace dd
// Params 0
// Checksum 0x5bafb29d, Offset: 0x8a9
// Size: 0x1d0
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    allowed[ 1 ] = "dd_bombzone";
    allowed[ 2 ] = "blocker";
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.objectivebased = 1;
    level.teambased = 1;
    level.nosuspensemusic = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.ondeadevent = &ondeadevent;
    level.ontimelimit = &ontimelimit;
    level.onnormaldeath = &onnormaldeath;
    level.var_813f2ea1f9452bdb = &function_55b47f39f880014a;
    level.gamemodemaydropweapon = &game_utility_mp::isplayeroutsideofanybombsite;
    level.resetuiomnvargamemode = &obj_bombzone::resetuiomnvargamemode;
    level.var_40cd999d911308e0 = &game_utility_mp::function_587ce2553bfdb756;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_50204bc2d6eb5ee9;
    level.bombsplanted = 0;
    level.ddbombmodel = [];
    level.aplanted = 0;
    level.bplanted = 0;
    obj_bombzone::setbombtimeromnvars();
    setomnvar( "ui_bomb_timer_endtime_a", 0 );
    setomnvar( "ui_bomb_timer_endtime_b", 0 );
    setomnvar( "ui_bomb_planted_a", 0 );
    setomnvar( "ui_bomb_planted_b", 0 );
    setomnvar( "ui_bomb_interacting", 0 );
    
    /#
        setdevdvarifuninitialized( @"hash_98151d926a0bebbf", 0 );
    #/
}

// Namespace dd
// Params 0
// Checksum 0x7539b1f7, Offset: 0xa81
// Size: 0x202
function onstartgametype()
{
    setomnvar( "ui_victory_condition_completed", 0 );
    
    if ( game[ "roundsPlayed" ] == 2 )
    {
        game[ "status" ] = "overtime";
        setdvar( @"ui_overtime", 1 );
        setomnvar( o"ui_num_dom_flags", 1 );
    }
    else
    {
        setomnvar( o"ui_num_dom_flags", 2 );
    }
    
    if ( game_utility_mp::inovertime() )
    {
        setomnvar( "ui_round_hint_override_attackers", 1 );
        setomnvar( "ui_round_hint_override_defenders", 1 );
    }
    
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
    
    setclientnamemode( "manual_change" );
    level._effect[ "bomb_explosion" ] = loadfxasset( "vfx_iw9_dmz_bombsite_explo" );
    game_utility_mp::setobjectivetext( game[ "attackers" ], &"objectives/dd_attacker" );
    game_utility_mp::setobjectivetext( game[ "defenders" ], &"objectives/dd_defender" );
    
    if ( level.splitscreen )
    {
        game_utility_mp::setobjectivescoretext( game[ "attackers" ], &"objectives/dd_attacker" );
        game_utility_mp::setobjectivescoretext( game[ "defenders" ], &"objectives/dd_defender" );
    }
    else
    {
        game_utility_mp::setobjectivescoretext( game[ "attackers" ], &"objectives/dd_attacker_score" );
        game_utility_mp::setobjectivescoretext( game[ "defenders" ], &"objectives/dd_defender_score" );
    }
    
    if ( game_utility_mp::inovertime() )
    {
        game_utility_mp::setobjectivehinttext( game[ "attackers" ], &"objectives/dd_overtime_hint" );
        game_utility_mp::setobjectivehinttext( game[ "defenders" ], &"objectives/dd_overtime_hint" );
    }
    else
    {
        game_utility_mp::setobjectivehinttext( game[ "attackers" ], &"objectives/dd_attacker_hint" );
        game_utility_mp::setobjectivehinttext( game[ "defenders" ], &"objectives/dd_defender_hint" );
    }
    
    setupobjectiveicons();
    thread bombs();
}

// Namespace dd
// Params 0
// Checksum 0x8d430534, Offset: 0xc8b
// Size: 0xb8
function function_55b47f39f880014a()
{
    var_4f5682e5ceeda333 = 0;
    dialogref = undefined;
    
    if ( !isdefined( game[ "roundsPlayed" ] ) )
    {
        var_4f5682e5ceeda333 = 0;
    }
    else if ( game[ "roundsPlayed" ] == 2 )
    {
        dialogref = #"boost_demo_ot";
    }
    else if ( self.team == game[ "attackers" ] )
    {
        dialogref = #"boost_demoattack_short";
    }
    else if ( self.team == game[ "defenders" ] )
    {
        dialogref = #"boost_demodefend_short";
    }
    
    if ( dialog_utility::dialogueexists( dialogref, self.team ) )
    {
        dialog::leaderdialogonplayer( dialogref, "introboost" );
        var_cd24a0144448ee0c = 1;
    }
    
    return var_cd24a0144448ee0c;
}

// Namespace dd
// Params 0
// Checksum 0x4360239c, Offset: 0xd4c
// Size: 0xb0
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.planttime = getmatchrulesdata( "bombData", "plantTime" ) ?? 5;
    level.defusetime = getmatchrulesdata( "bombData", "defuseTime" ) ?? 5;
    level.bombtimer = getmatchrulesdata( "bombData", "bombTimer" ) ?? 45;
    level.ddtimetoadd = getmatchrulesdata( "demData", "extraTime" ) ?? 120;
    level.overtime = getmatchrulesdata( "demData", "overtimeLimit" ) ?? 1;
    level.silentplant = getmatchrulesdata( "bombData", "silentPlant" ) ?? 0;
}

// Namespace dd
// Params 0
// Checksum 0x80435f2c, Offset: 0xe04
// Size: 0x41
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.resetprogress = dvars::dvarintvalue( "resetProgress", 1, 0, 1 );
    setdynamicdvar( @"scr_dd_promode", 0 );
    game_utility_mp::setovertimelimitdvar( level.overtime );
}

// Namespace dd
// Params 0
// Checksum 0x877a753c, Offset: 0xe4d
// Size: 0x35b
function initspawns()
{
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3a25709674572ad6( #"start", #"start_attackers", spawnkey, spawnlogic::function_61ba521db28762a7(), game[ "attackers" ], 1 );
        spawnlogic::function_3a25709674572ad6( #"start", #"start_defenders", spawnkey, spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ], 1 );
        valuekeys = [ "zoneA_active", "zoneA_destroyed", "zoneB_active", "zoneB_destroyed" ];
        var_540375a0f1234755 = [ #"zonea_active_attackers", #"zonea_destroyed_attackers", #"zoneb_active_attackers", #"zoneb_destroyed_attackers" ];
        var_72ec1c4fb7641fd9 = [ #"zonea_active_defenders", #"zonea_destroyed_defenders", #"zoneb_active_defenders", #"zoneb_destroyed_defenders" ];
        spawnlogic::function_1a2e309f5ceed01c( "holding", #"primary_attackers", var_540375a0f1234755, spawnkey, "attacker", valuekeys, game[ "attackers" ] );
        spawnlogic::function_1a2e309f5ceed01c( "holding", #"primary_defenders", var_72ec1c4fb7641fd9, spawnkey, "defender", valuekeys, game[ "defenders" ] );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"primary_attackers" );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"primary_defenders" );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"zonea_active_attackers" );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"zoneb_active_attackers" );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"zonea_active_defenders" );
        spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"zoneb_active_defenders" );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_dd_spawn_attacker_start", game[ "attackers" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_dd_spawn_defender_start", game[ "defenders" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_attackers", "mp_dd_spawn_attacker", game[ "attackers" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_defenders", "mp_dd_spawn_defender", game[ "defenders" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"zonea", "mp_dd_spawn_attacker_a", game[ "attackers" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"zonea", "mp_dd_spawn_defender_a", game[ "defenders" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"zoneb", "mp_dd_spawn_attacker_b", game[ "attackers" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"zoneb", "mp_dd_spawn_defender_b", game[ "defenders" ], 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace dd
// Params 0
// Checksum 0x73133088, Offset: 0x11b0
// Size: 0x206
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        return spawnlogic::function_3f9d5fcfb93d4190( self );
    }
    else if ( spawnlogic::shoulduseteamstartspawn() )
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
        spawnset = undefined;
        fallbackspawnset = undefined;
        
        if ( spawnteam == game[ "attackers" ] )
        {
            if ( game_utility_mp::inovertime() || !level.aplanted && !level.bplanted )
            {
                spawnset = #"primary_attackers";
            }
            else if ( level.aplanted && !level.bplanted )
            {
                spawnset = #"zonea";
            }
            else if ( level.bplanted && !level.aplanted )
            {
                spawnset = #"zoneb";
            }
            else
            {
                spawnset = #"primary_attackers";
            }
        }
        else if ( game_utility_mp::inovertime() || !level.aplanted && !level.bplanted )
        {
            spawnset = #"primary_defenders";
        }
        else if ( level.aplanted && !level.bplanted )
        {
            spawnset = #"zonea";
        }
        else if ( level.bplanted && !level.aplanted )
        {
            spawnset = #"zoneb";
        }
        else
        {
            spawnset = #"primary_defenders";
        }
        
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, spawnset, fallbackspawnset );
    }
    
    return spawnpoint;
}

// Namespace dd
// Params 1
// Checksum 0x3c5b7ae1, Offset: 0x13bf
// Size: 0x10c
function onspawnplayer( spawndata )
{
    bombteam = getbombteam();
    self setclientomnvar( "ui_hud_carried_item_index", 0 );
    
    if ( game_utility_mp::inovertime() || self.pers[ "team" ] == bombteam )
    {
        self setclientomnvar( "ui_carrying_bomb", 1 );
        self setclientomnvar( "ui_hud_carried_item_count", 1 );
        self.isplanting = 0;
        self.isdefusing = 0;
        self.isbombcarrier = 1;
    }
    else
    {
        self.isplanting = 0;
        self.isdefusing = 0;
        self.isbombcarrier = 0;
    }
    
    stats::setextrascore0( self.pers[ "plants" ] ?? 0, "plants" );
    stats::setextrascore1( self.pers[ "defuses" ] ?? 0, "defuses" );
    stats::setextrascore2( self.pers[ "extrascore2" ] ?? 0, "objectivekills" );
    level notify( #"spawned_player" );
}

// Namespace dd
// Params 0
// Checksum 0xeef1a44d, Offset: 0x14d3
// Size: 0x9
function getbombteam()
{
    return game[ "attackers" ];
}

// Namespace dd
// Params 0
// Checksum 0x75719daf, Offset: 0x14e5
// Size: 0x3d
function hidecarryiconongameend()
{
    self endon( #"disconnect" );
    level waittill( #"game_ended" );
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
    }
}

// Namespace dd
// Params 2
// Checksum 0xbc2aa636, Offset: 0x152a
// Size: 0xe2
function dd_endgame( winningteam, endreasontext )
{
    setomnvar( "ui_bomb_interacting", 0 );
    thread gamelogic_mp::endgame( winningteam, endreasontext );
    
    foreach ( bombzone in level.objectives )
    {
        dlog_recordevent( "dlog_event_mp_objective_status", [ "key", bombzone.objectivekey, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ), "is_active", 0 ] );
    }
}

// Namespace dd
// Params 1
// Checksum 0x31e2d98b, Offset: 0x1614
// Size: 0xdd
function ondeadevent( team )
{
    if ( level.bombexploded > 0 || level.bombdefused )
    {
        return;
    }
    
    if ( team == "all" )
    {
        if ( level.bombplanted )
        {
            dd_endgame( game[ "attackers" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        }
        else
        {
            dd_endgame( game[ "defenders" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        }
        
        return;
    }
    
    if ( team == game[ "attackers" ] )
    {
        if ( level.bombplanted )
        {
            return;
        }
        
        level thread dd_endgame( game[ "defenders" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
        return;
    }
    
    if ( team == game[ "defenders" ] )
    {
        level thread dd_endgame( game[ "attackers" ], game[ "end_reason" ][ "mp_faction_eliminated" ] );
    }
}

// Namespace dd
// Params 6
// Checksum 0x7295934c, Offset: 0x16f9
// Size: 0x36d
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( victim.isplanting )
    {
        thread utility::trycall( level.matchdata_logvictimkillevent, lifeid, "planting" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
            {
                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
            {
                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( attacker.pers[ "defends" ] ) )
            {
                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
            }
        }
        
        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
    }
    else if ( victim.isdefusing )
    {
        thread utility::trycall( level.matchdata_logvictimkillevent, lifeid, "defusing" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
            {
                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
            {
                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( attacker.pers[ "defends" ] ) )
            {
                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
            }
        }
        
        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
    }
    
    foreach ( bombzone in level.objectives )
    {
        eithertouching = obj_bombzone::distsquaredcheck( attacker.origin, victim.origin, bombzone.trigger.origin );
        
        if ( eithertouching )
        {
            attacker stats::setextrascore2( attacker.pers[ "extrascore2" ] + 1 );
            break;
        }
    }
}

// Namespace dd
// Params 1, eflags: 0x4
// Checksum 0x27096af1, Offset: 0x1a6e
// Size: 0x74
function private function_8314535b81f548e( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    
    if ( victim.isplanting )
    {
        attacker thread events::function_1aa2f7550e20dc20();
    }
    else if ( victim.isdefusing )
    {
        attacker thread events::function_7993ea01a4c8736b();
    }
    
    victim obj_bombzone::bombzone_awardgenericbombzonemedals( attacker, victim );
}

// Namespace dd
// Params 0
// Checksum 0x93ab14ea, Offset: 0x1aea
// Size: 0x42
function ontimelimit()
{
    if ( game_utility_mp::inovertime() )
    {
        dd_endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
        return;
    }
    
    dd_endgame( game[ "defenders" ], game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace dd
// Params 0
// Checksum 0xa262ebdb, Offset: 0x1b34
// Size: 0x333
function bombs()
{
    waittillframeend();
    level.bombplanted = 0;
    level.bombdefused = 0;
    level.bombexploded = 0;
    level.multibomb = 1;
    triggers = getentarray( "dd_bombzone", #targetname );
    
    /#
        verifybombzones( triggers );
    #/
    
    level.objectives = [];
    
    foreach ( trigger in triggers )
    {
        bombzone = obj_bombzone::setupobjective( trigger, 1, 1 );
        
        if ( isdefined( bombzone ) )
        {
            bombzone.onbeginuse = &onbeginuse;
            bombzone.onenduse = &onenduse;
            bombzone.onuse = &onuseplantobject;
            bombzone function_ef8656809a2271ac();
            bombzone function_5788ea11b0c57d4f();
            level.objectives[ bombzone.objectivekey ] = bombzone;
        }
    }
    
    initspawns();
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    foreach ( bombzone in level.objectives )
    {
        reservedobjid = obj_bombzone::getreservedobjid( bombzone.objectivekey );
        bombzone gameobjects::requestid( 1, 1, reservedobjid );
        
        if ( game_utility_mp::inovertime() )
        {
            bombzone gameobjects::setobjectivestatusicons( "waypoint_target_neutral" );
        }
        else
        {
            bombzone gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
        }
        
        bombzone gameobjects::setvisibleteam( "any" );
        matchtimems = matchdata::function_47550968a937b67e( gettime() );
        dlog_recordevent( "dlog_event_mp_objective_status", [ "key", bombzone.objectivekey, "match_time_ms", matchtimems, "is_active", 1 ] );
        dlog_recordevent( "dlog_event_mp_objective_move", [ "pos_x", bombzone.curorigin[ 0 ], "pos_y", bombzone.curorigin[ 1 ], "key", bombzone.objectivekey, "match_time_ms", matchtimems ] );
        dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", bombzone.objectivekey, "team", "neutral", "match_time_ms", matchtimems ] );
    }
}

// Namespace dd
// Params 1
// Checksum 0xd2cd488a, Offset: 0x1e6f
// Size: 0x15
function onbeginuse( player )
{
    obj_bombzone::bombzone_onbeginuse( player );
}

// Namespace dd
// Params 3
// Checksum 0xfdcd3032, Offset: 0x1e8c
// Size: 0x29
function onenduse( team, player, result )
{
    obj_bombzone::bombzone_onenduse( team, player, result );
}

// Namespace dd
// Params 1
// Checksum 0xede1d106, Offset: 0x1ebd
// Size: 0x98
function onuseplantobject( player )
{
    skipplayers = [];
    skipplayers[ skipplayers.size ] = player;
    level thread hud_message::notifyteam( "emp_planted", "emp_planted_enemy", player.team, skipplayers );
    player thread hud_message::showsplash( "emp_planted", rank::getscoreinfovalue( #"plant" ) );
    obj_bombzone::bombzone_onuseplantobject( player );
    
    if ( level.bombexploded == 1 )
    {
        level callback::callback( #"music_event", { #event_type:#"bomb_planted" } );
    }
}

// Namespace dd
// Params 1
// Checksum 0x6a4d2aa1, Offset: 0x1f5d
// Size: 0xd5
function resetbombzone( player )
{
    if ( game_utility_mp::inovertime() )
    {
        gameobjects::setownerteam( "neutral" );
        gameobjects::setobjectivestatusicons( "waypoint_target" );
    }
    else
    {
        gameobjects::setownerteam( game[ "defenders" ] );
        gameobjects::allowuse( "enemy" );
        gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
    }
    
    gameobjects::setusehinttext( &"mp/hold_to_plant_explosives" );
    self.id = "bomb_zone";
    gameobjects::setusetime( level.planttime );
    gameobjects::setvisibleteam( "any" );
    var_b25e82880942a851 = level.gametypebundle.bombweapon ?? "briefcase_bomb_mp";
    self.useweapon = makeweapon( var_b25e82880942a851 );
    self.bombexploded = undefined;
}

// Namespace dd
// Params 0
// Checksum 0xd418fd59, Offset: 0x203a
// Size: 0x43
function setupfordefusing()
{
    gameobjects::allowuse( "friendly" );
    gameobjects::setusetime( level.defusetime );
    gameobjects::setkeyobject( undefined );
    gameobjects::setobjectivestatusicons( "waypoint_defuse", "waypoint_defend" );
    gameobjects::setvisibleteam( "any" );
}

// Namespace dd
// Params 2
// Checksum 0xa371da10, Offset: 0x2085
// Size: 0x188
function bombplanted( destroyedobj, player )
{
    destroyedobj endon( #"defused" );
    playerteam = player.team;
    level.bombsplanted += 1;
    gamelogic_mp::pausetimer();
    level.timepausestart = gettime();
    level.timelimitoverride = 1;
    level.bombplanted = 1;
    level.destroyedobject = destroyedobj;
    
    if ( level.destroyedobject.objectivekey == "_a" )
    {
        level.aplanted = 1;
    }
    else
    {
        level.bplanted = 1;
    }
    
    level.destroyedobject.bombplanted = 1;
    level.tickingobject = destroyedobj.visuals[ 0 ];
    
    if ( isdefined( level.gametypebundle.var_829f4f028cd0d42c ) )
    {
        dropbombmodel( player, destroyedobj.objectivekey );
    }
    
    destroyedobj.bombdefused = 0;
    destroyedobj gameobjects::allowuse( "none" );
    destroyedobj gameobjects::setvisibleteam( "none" );
    
    if ( game_utility_mp::inovertime() )
    {
        destroyedobj gameobjects::setownerteam( team_utility::getotherteam( player.team ) );
    }
    
    destroyedobj setupfordefusing();
    destroyedobj function_e0c298ef0637e3bf();
    destroyedobj bombtimerwait( destroyedobj );
    destroyedobj thread bombhandler( player, "explode", playerteam );
}

// Namespace dd
// Params 3
// Checksum 0xa3da978a, Offset: 0x2215
// Size: 0x280
function bombhandler( player, desttype, playerteam )
{
    level.bombsplanted -= 1;
    
    if ( self.objectivekey == "_a" )
    {
        level.aplanted = 0;
    }
    else
    {
        level.bplanted = 0;
    }
    
    restarttimer();
    obj_bombzone::setbombtimeromnvars();
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( desttype == "explode" )
    {
        self.bombexploded = 1;
        
        if ( isdefined( player ) )
        {
            if ( !isdefined( player.bombsexploded ) )
            {
                player.bombsexploded = 0;
            }
            
            player.bombsexploded++;
            
            if ( player.bombsexploded == level.objectives.size )
            {
                player thread points::doscoreevent( #"personal_double_bombsites" );
                player.bombsexploded = 0;
            }
        }
        
        timelimit = level.timelimit;
        
        if ( timelimit != 0 && !game_utility_mp::inovertime() && level.bombexploded < 2 && level.ddtimetoadd > 0 )
        {
            level.extratime = level.bombexploded * level.ddtimetoadd;
            timeleft = gamelogic_mp::gettimeremaining();
            
            if ( level.timerstoppedforgamemode )
            {
                timeleft -= level.bombtimer * 1000;
            }
            
            setgameendtime( gettime() + int( timeleft ) );
            
            if ( hasomnvar( o"ui_match_extra_time" ) )
            {
                setomnvar( o"ui_match_extra_time", int( level.extratime ) );
            }
        }
        
        wait 2;
        
        if ( game_utility_mp::inovertime() || level.bombexploded > 1 )
        {
            if ( level.nukeinfo.incoming )
            {
                return;
            }
            
            dd_endgame( playerteam, game[ "end_reason" ][ "target_destroyed" ] );
        }
        else if ( level.ddtimetoadd > 0 )
        {
            dialog::statusdialog( "bomb_destroyed_en", game[ "defenders" ] );
            level thread hud_message::notifyteam( "callout_time_added", "callout_time_added", player.team );
        }
        
        function_1ca9320f27a84d70();
        return;
    }
    
    player notify( "bomb_defused" + self.objectivekey );
    self notify( #"defused" );
    resetbombzone( player );
    function_1f680a8030657674();
}

// Namespace dd
// Params 2
// Checksum 0x94072d17, Offset: 0x249d
// Size: 0x113
function dropbombmodel( player, site )
{
    trace = trace::ray_trace( player.origin + ( 0, 0, 20 ), player.origin - ( 0, 0, 2000 ), player, trace::create_default_contents( 1 ) );
    tempangle = randomfloat( 360 );
    forward = ( cos( tempangle ), sin( tempangle ), 0 );
    forward = vectornormalize( forward - trace[ "normal" ] * vectordot( forward, trace[ "normal" ] ) );
    dropangles = vectortoangles( forward );
    level.ddbombmodel[ site ] = spawn( "script_model", trace[ "position" ] );
    level.ddbombmodel[ site ].angles = dropangles;
    level.ddbombmodel[ site ] setmodel( level.gametypebundle.var_829f4f028cd0d42c );
}

// Namespace dd
// Params 0
// Checksum 0x3b26e7fd, Offset: 0x25b8
// Size: 0x64
function restarttimer()
{
    if ( game_utility_mp::inovertime() )
    {
        if ( level.bombexploded == 1 )
        {
            return;
        }
    }
    else if ( level.bombexploded > 1 )
    {
        return;
    }
    
    if ( level.bombsplanted <= 0 )
    {
        gamelogic_mp::resumetimer();
        level.timepaused = gettime() - level.timepausestart;
        level.timelimitoverride = 0;
    }
}

// Namespace dd
// Params 1
// Checksum 0x14054f46, Offset: 0x2624
// Size: 0xa5
function bombtimerwait( siteloc )
{
    level endon( #"game_ended" );
    level endon( "bomb_defused" + siteloc.objectivekey );
    
    if ( game_utility_mp::inovertime() )
    {
        siteloc.waittime = level.bombtimer;
    }
    else
    {
        siteloc.waittime = level.bombtimer;
    }
    
    level thread update_ui_timers( siteloc );
    
    while ( siteloc.waittime >= 0 )
    {
        siteloc.waittime--;
        
        if ( siteloc.waittime >= 0 )
        {
            wait 1;
        }
        
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace dd
// Params 1
// Checksum 0x5813ed7d, Offset: 0x26d1
// Size: 0xd0
function update_ui_timers( siteloc )
{
    level endon( #"game_ended" );
    level endon( #"disconnect" );
    level endon( "bomb_defused" + siteloc.objectivekey );
    level endon( "bomb_exploded" + siteloc.objectivekey );
    var_fc65cde94aa01b65 = siteloc.waittime * 1000 + gettime();
    setdvar( hashcat( @"ui_bombtimer", siteloc.objectivekey ), var_fc65cde94aa01b65 );
    level waittill( #"host_migration_begin" );
    timepassed = hostmigration::waittillhostmigrationdone();
    
    if ( timepassed > 0 )
    {
        setdvar( hashcat( @"ui_bombtimer", siteloc.objectivekey ), var_fc65cde94aa01b65 + timepassed );
    }
}

// Namespace dd
// Params 1
// Checksum 0xeb094735, Offset: 0x27a9
// Size: 0x3e
function bombdefused( sitedefused )
{
    level.tickingobject gamelogic_mp::stoptickingsound();
    sitedefused.bombdefused = 1;
    level notify( "bomb_defused" + sitedefused.objectivekey );
}

// Namespace dd
// Params 0
// Checksum 0xf3f91377, Offset: 0x27ef
// Size: 0x107
function setupobjectiveicons()
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_target_neutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_a", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_b", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0 );
    gamelogic_mp::setwaypointiconinfo( "waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0 );
}

// Namespace dd
// Params 1
// Checksum 0xe02efc2, Offset: 0x28fe
// Size: 0x4f
function function_f6cf25f9c109edf5( array )
{
    switch ( self.objectivekey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return array[ 0 ];
        case #"hash_fac2c2f6bddd4504":
            return array[ 1 ];
        default:
            return array[ 1 ];
    }
}

// Namespace dd
// Params 1
// Checksum 0xc0985d15, Offset: 0x2955
// Size: 0x42
function function_f8ad3ad792b5c4fc( objectivekey )
{
    switch ( objectivekey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return #"zonea";
        case #"hash_fac2c2f6bddd4504":
            return #"zoneb";
    }
}

// Namespace dd
// Params 0
// Checksum 0x521dee58, Offset: 0x29a0
// Size: 0x11e
function function_ef8656809a2271ac()
{
    self.spawnset = [];
    self.spawnset[ #"active_attackers" ] = function_f6cf25f9c109edf5( [ #"zonea_active_attackers", #"zoneb_active_attackers" ] );
    self.spawnset[ #"destroyed_attackers" ] = function_f6cf25f9c109edf5( [ #"zonea_destroyed_attackers", #"zoneb_destroyed_attackers" ] );
    self.spawnset[ #"active_defenders" ] = function_f6cf25f9c109edf5( [ #"zonea_active_defenders", #"zoneb_active_defenders" ] );
    self.spawnset[ #"destroyed_defenders" ] = function_f6cf25f9c109edf5( [ #"zonea_destroyed_defenders", #"zoneb_destroyed_defenders" ] );
    spawn_set = function_f8ad3ad792b5c4fc( self.objectivekey );
    spawn_points = spawnlogic::getspawnset( spawn_set );
    
    if ( spawn_points.size )
    {
        self.spawnset = spawn_set;
    }
}

// Namespace dd
// Params 0
// Checksum 0xd892fdee, Offset: 0x2ac6
// Size: 0x2
function function_5788ea11b0c57d4f()
{
    
}

// Namespace dd
// Params 0
// Checksum 0x73fb112c, Offset: 0x2ad0
// Size: 0x9b
function removeinfluencers()
{
    if ( !isdefined( self.influencers ) )
    {
        self.influencers = [];
    }
    
    foreach ( influencer in self.influencers )
    {
        spawnlogic::removespawninfluencer( influencer );
    }
    
    self.influencers = [];
}

// Namespace dd
// Params 0
// Checksum 0xd72478d4, Offset: 0x2b73
// Size: 0x84
function function_449bbec68b60adaa()
{
    foreach ( influencer in self.influencers )
    {
        spawnlogic::influencersetspawnpointlist( influencer, self.spawnset );
    }
}

// Namespace dd
// Params 1
// Checksum 0xf646ebb7, Offset: 0x2bff
// Size: 0xdc
function createinfluencers( keys )
{
    removeinfluencers();
    
    if ( !isdefined( self.spawnset ) )
    {
        return;
    }
    
    foreach ( key in keys )
    {
        if ( isdefined( self.influencerkeys[ key ] ) )
        {
            self.influencers[ self.influencers.size ] = spawnlogic::addspawninfluencer( self.influencerkeys[ key ], self.trigger.origin );
        }
    }
    
    function_449bbec68b60adaa();
}

// Namespace dd
// Params 0
// Checksum 0x6fe9af0b, Offset: 0x2ce3
// Size: 0x9
function function_1f680a8030657674()
{
    removeinfluencers();
}

// Namespace dd
// Params 0
// Checksum 0x24aaf255, Offset: 0x2cf4
// Size: 0x13
function function_e0c298ef0637e3bf()
{
    createinfluencers( [ "planted" ] );
}

// Namespace dd
// Params 2
// Checksum 0x54ab6910, Offset: 0x2d0f
// Size: 0x93
function function_77205ae3530e2d8d( spawnset, influencer_def )
{
    if ( spawnlogic::useablespawnset( self.spawnset[ spawnset ] ) )
    {
        if ( !isdefined( self.spawninfluencers ) )
        {
            self.spawninfluencers = [];
        }
        
        influencer = spawnlogic::addspawninfluencer( influencer_def, self.trigger.origin );
        spawnlogic::influencersetspawnpointlist( influencer, self.spawnset[ spawnset ] );
        self.spawninfluencers[ self.spawninfluencers.size ] = influencer;
    }
}

// Namespace dd
// Params 0
// Checksum 0x5a8212e6, Offset: 0x2daa
// Size: 0x7a
function function_1ca9320f27a84d70()
{
    spawnlogic::function_2e4fbfaa2e5bf603( #"primary", self.spawnset[ #"destroyed_defenders" ] );
    spawnlogic::function_2e4fbfaa2e5bf603( #"primary", self.spawnset[ #"destroyed_attackers" ] );
    function_77205ae3530e2d8d( #"active_defenders", #"hash_d841f6b057ed9349" );
    function_77205ae3530e2d8d( #"active_attackers", #"hash_6f9203c430f48d09" );
}

// Namespace dd
// Params 0
// Checksum 0xa4a96580, Offset: 0x2e2c
// Size: 0x2
function function_c3fb397811bdf75d()
{
    
}

/#

    // Namespace dd
    // Params 1
    // Checksum 0xd65e7b50, Offset: 0x2e36
    // Size: 0x165, Type: dev
    function verifybombzones( bombzones )
    {
        missing = "<dev string:x4a>";
        
        if ( bombzones.size != 3 )
        {
            founda = 0;
            foundb = 0;
            foundc = 0;
            
            foreach ( bombzone in bombzones )
            {
                if ( issubstr( tolower( bombzone.script_label ), "<dev string:x4b>" ) )
                {
                    founda = 1;
                    continue;
                }
                
                if ( issubstr( tolower( bombzone.script_label ), "<dev string:x4d>" ) )
                {
                    foundb = 1;
                    continue;
                }
                
                if ( issubstr( tolower( bombzone.script_label ), "<dev string:x4f>" ) )
                {
                    foundc = 1;
                }
            }
            
            if ( !founda )
            {
                missing += "<dev string:x51>";
            }
            
            if ( !foundb )
            {
                missing += "<dev string:x55>";
            }
            
            if ( !foundc )
            {
                missing += "<dev string:x59>";
            }
        }
        
        if ( missing != "<dev string:x4a>" )
        {
            assertmsg( "<dev string:x5d>" + missing + "<dev string:x68>" );
        }
    }

#/
