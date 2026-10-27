// scripts\mp\gametypes\benchmark.gsc  (hash_7166c0214dc91c9f.gscc) (size: 2525 Bytes / 0x9dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5dad352e (1571632430)
// size ...... 2525 (0x9dd)
// includes .. 9   (offset: 0x925)
// strings ... 8   (offset: 0x96d)
// dev strs .. 0   (offset: 0x9dd)
// exports ... 9   (offset: 0x451)
// cseg ...... 0xd6 + 0x37b (0x451)
// imports ... 31  (offset: 0x5b9)
// animtree1 . 0   (offset: 0x9dd)
// animtree2 . 0   (offset: 0x9dd)
#using scripts\mp\common\utility\benchmark_mp_utils;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\spawnlogic;

#namespace benchmark;

// Namespace benchmark
// Params 0
// Checksum 0xfe8c8859, Offset: 0xf4
// Size: 0xdc
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
    level.disableforfeit = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.endgame = &benchmarkendgame;
    
    /#
        if ( benchmark_mp_utils::function_1213863ac8d76692() )
        {
            thread benchmark_mp_utils::function_309c07effd44c8f1();
        }
    #/
}

// Namespace benchmark
// Params 0
// Checksum 0x7de383de, Offset: 0x1d8
// Size: 0x18
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_war_promode", 0 );
}

// Namespace benchmark
// Params 0
// Checksum 0xfb7308f9, Offset: 0x1f8
// Size: 0x12d
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
    
    bradley_spawner::inittankspawns();
}

// Namespace benchmark
// Params 0
// Checksum 0x185f3970, Offset: 0x32d
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace benchmark
// Params 0
// Checksum 0xf17b7019, Offset: 0x33e
// Size: 0x39
function getspawnpoint()
{
    spawnarray = spawnlogic::getspawnpointarray( "mp_spawn_point" );
    
    if ( !isdefined( spawnarray ) || spawnarray.size == 0 )
    {
        spawnarray = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    }
    
    return spawnarray[ 0 ];
}

// Namespace benchmark
// Params 1
// Checksum 0xa8313ddb, Offset: 0x380
// Size: 0x1c
function onspawnplayer( revivespawn )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
}

// Namespace benchmark
// Params 6
// Checksum 0x8c3bbc0c, Offset: 0x3a4
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace benchmark
// Params 3
// Checksum 0xad99bebe, Offset: 0x3f4
// Size: 0x5d
function benchmarkendgame( winner, endreasontext, nukedetonated )
{
    if ( level.gameended )
    {
        return;
    }
    
    playerendmatch();
    setclientmatchdata( "isPublicMatch", 0 );
    sendclientmatchdata();
    level notify( #"exitlevel_called" );
    exitlevel( 0 );
    level.gameended = 1;
}

