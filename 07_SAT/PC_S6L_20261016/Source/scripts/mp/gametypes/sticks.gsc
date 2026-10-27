// scripts\mp\gametypes\sticks.gsc  (hash_67509c766d136317.gscc) (size: 5966 Bytes / 0x174e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf632fd2e (4130536750)
// size ...... 5966 (0x174e)
// includes .. 14  (offset: 0x1522)
// strings ... 24  (offset: 0x1592)
// dev strs .. 8   (offset: 0x16ea)
// exports ... 18  (offset: 0xb5e)
// cseg ...... 0x1f6 + 0x968 (0xb5e)
// imports ... 61  (offset: 0xe2e)
// animtree1 . 0   (offset: 0x174e)
// animtree2 . 0   (offset: 0x174e)
#using scripts\common\callbacks;
#using scripts\mp\class;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\stats;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\persistence;
#using scripts\mp\spawnlogic;

#namespace sticks;

// Namespace sticks
// Params 0
// Checksum 0xb74769a0, Offset: 0x214
// Size: 0xfb
function main()
{
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"player_death", &onplayerkilled );
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.onplayerscore = &onplayerscore;
    level.didhalfscorevoboost = 0;
    level.var_b9f5b44894d6b0f3 = 1;
    level.denyclasschoice = 1;
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    createloadouts();
}

// Namespace sticks
// Params 0
// Checksum 0xa41d4607, Offset: 0x317
// Size: 0xb
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata( 1 );
}

// Namespace sticks
// Params 0
// Checksum 0x4c80064, Offset: 0x32a
// Size: 0x5a
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.var_b9f5b44894d6b0f3 = getmatchrulesdata( "commonOption", "overrideScoringOnExtraScore5" ) ?? 1;
    setdvar( @"hash_a04518df9d9f211e", 0 );
    setdvar( @"hash_1c6e2fb602f2f4a3", level.var_b9f5b44894d6b0f3 );
    setdvar( @"meatshield_enabled", 0 );
}

// Namespace sticks
// Params 0
// Checksum 0x1ff1a844, Offset: 0x38c
// Size: 0xda
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/dm" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/dm" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/dm_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/dm_hint" );
    }
    
    initspawns();
}

// Namespace sticks
// Params 0
// Checksum 0xfbd2e9ba, Offset: 0x46e
// Size: 0xa2
function initspawns()
{
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_e2bf4a9ddf11bc78( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start", "mp_dm_spawn_start", undefined, 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary", "mp_dm_spawn" );
        spawnlogic::function_9bd2654564d3372d( #"fallback", #"fallback", "mp_tdm_spawn_secondary", undefined, 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace sticks
// Params 0
// Checksum 0x72c34cab, Offset: 0x518
// Size: 0x66
function getspawnpoint()
{
    if ( level.ingraceperiod )
    {
        if ( level.ingraceperiod )
        {
            spawnpoints = spawnlogic::getstartspawnpoints();
            
            if ( !isdefined( level.requiresminstartspawns ) )
            {
                assert( spawnpoints.size != 0 || spawnpoints.size >= 8, "<dev string:x24>" + 8 + "<dev string:x3b>" );
            }
        }
    }
    
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace sticks
// Params 1
// Checksum 0x3d238194, Offset: 0x587
// Size: 0x28
function onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    level notify( #"spawned_player" );
}

// Namespace sticks
// Params 6
// Checksum 0xd3649feb, Offset: 0x5b7
// Size: 0x96
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( !level.didhalfscorevoboost )
    {
        attackerscore = attacker.pers[ "extraScore5" ];
        
        if ( attackerscore >= int( level.scorelimit * level.currentround - level.scorelimit / 2 ) )
        {
            thread dohalftimevo( attacker );
        }
    }
}

// Namespace sticks
// Params 1
// Checksum 0x400a2a2a, Offset: 0x655
// Size: 0x4d
function onplayerkilled( deathdata )
{
    if ( deathdata.attacker == deathdata.victim || deathdata.meansofdeath == "MOD_SUICIDE" )
    {
        deathdata.victim function_a66940b69c2f23b4();
    }
}

// Namespace sticks
// Params 5
// Checksum 0xa2760f49, Offset: 0x6aa
// Size: 0x9b
function onplayerscore( event, player, originalpoints, victim, eventinfo )
{
    player stats::function_fe615555f60e88b9( player.pers[ "extrascore5" ] + originalpoints );
    
    if ( event == #"elimination_combataxe" )
    {
        player stats::setextrascore0( player.pers[ "extrascore0" ] + 1 );
        player dialog::leaderdialogonplayer( #"humiliate", "gametype" );
        victim function_a66940b69c2f23b4();
    }
    
    return originalpoints;
}

// Namespace sticks
// Params 0
// Checksum 0xb3ef955f, Offset: 0x74e
// Size: 0x115
function function_a66940b69c2f23b4()
{
    stats::function_fe615555f60e88b9( 0 );
    stats::setextrascore1( self.pers[ "extrascore1" ] + 1 );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "setbacks" ] ) )
        {
            self.leaderboarddata[ "setbacks" ] = self.leaderboarddata[ "setbacks" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "setbacks" ] ) )
        {
            [[ level.leaderboardfunc[ "setbacks" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x49>" );
        
        if ( isdefined( self.pers[ "setbacks" ] ) )
        {
            self.pers[ "setbacks" ] = self.pers[ "setbacks" ] + 1;
        }
    }
    
    persistence::statsetchild( "round", "setbacks", self.pers[ "setbacks" ] );
}

// Namespace sticks
// Params 1
// Checksum 0xa53faf84, Offset: 0x86b
// Size: 0xa8
function dohalftimevo( attacker )
{
    attacker dialog::leaderdialogonplayer( "ffa_lead_first" );
    newarray = arraysort( level.players, undefined, &compare_player_score );
    
    if ( isdefined( newarray[ 1 ] ) )
    {
        newarray[ 1 ] dialog::leaderdialogonplayer( "ffa_lead_second" );
    }
    
    if ( isdefined( newarray[ 2 ] ) && newarray.size > 2 )
    {
        newarray[ 2 ] dialog::leaderdialogonplayer( "ffa_lead_third" );
    }
    
    if ( isdefined( newarray[ newarray.size - 1 ] ) && newarray.size > 3 )
    {
        newarray[ newarray.size - 1 ] dialog::leaderdialogonplayer( "ffa_lead_last" );
    }
    
    level.didhalfscorevoboost = 1;
}

// Namespace sticks
// Params 2
// Checksum 0xd86c42ca, Offset: 0x91b
// Size: 0x38, Type: bool
function compare_player_score( left, right )
{
    return left.pers[ "extrascore5" ] >= right.pers[ "extrascore5" ];
}

// Namespace sticks
// Params 1
// Checksum 0xb3a23e7a, Offset: 0x95c
// Size: 0x50
function onplayerconnect( player )
{
    player class::function_e84a99f0f4904c66();
    player.pers[ "gamemodeLoadout" ] = function_86e5b1603761ed9d();
    player stats::setextrascore2( player.pers[ "extrascore5" ] ?? 0, "extrascore5" );
}

// Namespace sticks
// Params 0
// Checksum 0x2ce7345b, Offset: 0x9b4
// Size: 0x13e
function createloadouts()
{
    level.var_bfecd355a230c40c = [];
    
    /#
        assert( isdefined( level.gametypebundle.var_14a374941dd4696c ), "<dev string:x6f>" );
        assert( level.gametypebundle.var_14a374941dd4696c.size == 1, "<dev string:xd5>" );
    #/
    
    classtablebundle = getscriptbundle( level.gametypebundle.var_14a374941dd4696c[ 0 ].bundle );
    
    /#
        assert( isdefined( classtablebundle ), "<dev string:xfd>" );
        assert( classtablebundle.classlist.size == 1, "<dev string:xd5>" );
    #/
    
    loadoutentry = classtablebundle.classlist[ 0 ];
    assert( isdefined( loadoutentry ), "<dev string:x139>" );
    var_79240becd50c909e = hashcat( %"classtableentry:", loadoutentry.entry );
    var_227506a321482ad6 = getscriptbundle( var_79240becd50c909e );
    assert( isdefined( var_227506a321482ad6 ), "<dev string:x175>" );
    sticksloadout = class::function_79947c7814a64d0e( var_227506a321482ad6 );
    level.currentloadout = sticksloadout;
}

// Namespace sticks
// Params 0
// Checksum 0x605852db, Offset: 0xafa
// Size: 0xb
function function_86e5b1603761ed9d()
{
    return level.currentloadout;
}

// Namespace sticks
// Params 0
// Checksum 0x4fad5219, Offset: 0xb0e
// Size: 0x50
function ontimelimit()
{
    winner = gamescore::gethighestscoringplayer();
    
    if ( game[ "finalRound" ] == 1 )
    {
        thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "objective_completed" ] );
        return;
    }
    
    thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
}

