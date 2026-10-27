// script_361edaa2bbfe16a4  (hash_361edaa2bbfe16a4.gscc) (size: 2986 Bytes / 0xbaa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f37c528 (1060619560)
// size ...... 2986 (0xbaa)
// includes .. 7   (offset: 0xac6)
// strings ... 12  (offset: 0xafe)
// dev strs .. 0   (offset: 0xbaa)
// exports ... 10  (offset: 0x53a)
// cseg ...... 0x125 + 0x415 (0x53a)
// imports ... 36  (offset: 0x6ca)
// animtree1 . 0   (offset: 0xbaa)
// animtree2 . 0   (offset: 0xbaa)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\spawnlogic;

#namespace template;

// Namespace template
// Params 0
// Checksum 0x1333a7e6, Offset: 0x143
// Size: 0xce
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
    callback::add( #"player_spawned", &onspawnplayer );
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
}

// Namespace template
// Params 0
// Checksum 0x4bfe9017, Offset: 0x219
// Size: 0x149
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
        game_utility_mp::setobjectivetext( entry, &"objectives/template" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/template" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"hash_1ffc5eb0426f6ae4" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"hash_36076ec9adea0ac3" );
    }
    
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
        return;
    }
    
    initspawns();
}

// Namespace template
// Params 0
// Checksum 0x56dc7056, Offset: 0x36a
// Size: 0x9
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
}

// Namespace template
// Params 0
// Checksum 0x33c44b51, Offset: 0x37b
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace template
// Params 0
// Checksum 0x3fd5c6aa, Offset: 0x38c
// Size: 0xe2
function initspawns()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_tdm_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_tdm_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_tdm_spawn" );
        spawnlogic::function_17e08e497a9b4136( #"fallback", #"fallback", "mp_tdm_spawn_secondary", 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace template
// Params 0
// Checksum 0x1a9ca1b7, Offset: 0x476
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace template
// Params 1
// Checksum 0x4ebf0fb6, Offset: 0x488
// Size: 0xc
function onspawnplayer( spawndata )
{
    
}

// Namespace template
// Params 6
// Checksum 0xa7a0ce2d, Offset: 0x49c
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace template
// Params 0
// Checksum 0x6dfc5f6c, Offset: 0x4ec
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

