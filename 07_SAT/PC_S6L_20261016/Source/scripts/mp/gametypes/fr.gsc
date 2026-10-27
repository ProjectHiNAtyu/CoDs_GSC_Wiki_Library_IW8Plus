// scripts\mp\gametypes\fr.gsc  (hash_16691a533b0c86fa.gscc) (size: 4453 Bytes / 0x1165 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc3f13346 (3287364422)
// size ...... 4453 (0x1165)
// includes .. 13  (offset: 0xf99)
// strings ... 21  (offset: 0x1001)
// dev strs .. 0   (offset: 0x1165)
// exports ... 12  (offset: 0x815)
// cseg ...... 0x191 + 0x684 (0x815)
// imports ... 49  (offset: 0x9f5)
// animtree1 . 0   (offset: 0x1165)
// animtree2 . 0   (offset: 0x1165)
#using script_1e423a56bab234bd;
#using script_60e2a37437417e6d;
#using script_7a471b80bc5ba3b1;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\player_broadcasting;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\spawnlogic;

#namespace fr;

// Namespace fr
// Params 0
// Checksum 0xfc642a84, Offset: 0x1af
// Size: 0x161
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
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    game[ "dialog" ][ "gametype" ] = "gametype_tdm";
    game[ "dialog" ][ "boost" ] = "boost_tdm";
    game[ "dialog" ][ "offense_obj" ] = "boost_tdm";
    game[ "dialog" ][ "defense_obj" ] = "boost_tdm";
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
    
    fr_safehouse::fr_safehouse_init();
    fr_activities::function_28c73955d5c2fd05();
    initializeactivities();
    player_broadcasting::function_7fc000126b792810();
    
    if ( getdvarint( @"hash_3a0783f0e1830d67", 0 ) )
    {
        namespace_da4330528ad516c8::function_a6c5a773a1a531d0();
        fr_activities::fr_activity_init( "test_0" );
    }
}

// Namespace fr
// Params 0
// Checksum 0x76fa608, Offset: 0x318
// Size: 0x9
function initializeactivities()
{
    activity_common::function_3abef4d1ee430ea4();
}

// Namespace fr
// Params 0
// Checksum 0x93597b5, Offset: 0x329
// Size: 0x18
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_war_promode", 0 );
}

// Namespace fr
// Params 0
// Checksum 0xefcb6b46, Offset: 0x349
// Size: 0x16d
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
        game_utility_mp::setobjectivetext( entry, &"objectives/war" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/war_hint" );
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
    
    if ( getdvarint( @"hash_3a0783f0e1830d67", 0 ) )
    {
        fr_activities::fr_activity_start( "test_0" );
    }
}

// Namespace fr
// Params 0
// Checksum 0x17f0ab2b, Offset: 0x4be
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace fr
// Params 0
// Checksum 0x7b651da8, Offset: 0x4cf
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

// Namespace fr
// Params 0
// Checksum 0xd5bd4c7c, Offset: 0x61f
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

// Namespace fr
// Params 1
// Checksum 0xb8e5258e, Offset: 0x6e3
// Size: 0x27
function onspawnplayer( revivespawn )
{
    if ( level.fr_safehouse_enabled )
    {
        fr_safehouse::fr_safehouse_enter();
    }
    
    namespace_e55955ff7520be97::function_ecea5c2a0aaa9c90( self );
}

// Namespace fr
// Params 6
// Checksum 0x83942e57, Offset: 0x712
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace fr
// Params 10
// Checksum 0xbdadbf35, Offset: 0x762
// Size: 0x5d
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    
}

// Namespace fr
// Params 0
// Checksum 0x49c8bf16, Offset: 0x7c7
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

