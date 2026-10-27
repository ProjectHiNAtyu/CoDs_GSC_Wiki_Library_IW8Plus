// scripts\mp\gametypes\conf.gsc  (hash_319312d6f1d06810.gscc) (size: 7389 Bytes / 0x1cdd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2b1b0e6b (723193451)
// size ...... 7389 (0x1cdd)
// includes .. 19  (offset: 0x1a79)
// strings ... 23  (offset: 0x1b11)
// dev strs .. 3   (offset: 0x1cb5)
// exports ... 21  (offset: 0xe79)
// cseg ...... 0x1d0 + 0xca9 (0xe79)
// imports ... 75  (offset: 0x11c1)
// animtree1 . 0   (offset: 0x1cdd)
// animtree2 . 0   (offset: 0x1cdd)
#using script_45dbfb1869cdd1bd;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\temp_v;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\persistence;
#using scripts\mp\spawnlogic;

#namespace conf;

// Namespace conf
// Params 0
// Checksum 0x2623d299, Offset: 0x1ee
// Size: 0x11c
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
    level.checkcustomclosetoscorelimit = &checkcustomclosetoscorelimit;
    level.delayleadtakendialog = 0.25;
    level.conf_fx[ "vanish" ] = loadfxasset( level.dogtagdata.var_ce8f83aec7bb9f4 ?? "" );
    
    if ( game_utility::getgametype() == "conf_v" )
    {
        level.var_5b4b6d7aef345c0e = 1;
    }
}

// Namespace conf
// Params 0
// Checksum 0x9f5b4bf2, Offset: 0x312
// Size: 0x5b
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.scoreconfirm = getmatchrulesdata( "confData", "pointsPerConfirm" ) ?? 1;
    level.scoredeny = getmatchrulesdata( "confData", "pointsPerDeny" ) ?? 0;
    level.killstreakconfirmed = getmatchrulesdata( "confData", "killstreakConfirmed" ) ?? 0;
}

// Namespace conf
// Params 0
// Checksum 0x8acd83ac, Offset: 0x375
// Size: 0x240
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
        game_utility_mp::setobjectivetext( entry, &"objectives/conf" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/conf" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/conf_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/conf_hint" );
    }
    
    initspawns();
    
    if ( level.dogtagsenabled )
    {
        level.dogtagallyonusecb = &dogtagallyonusecb;
        level.dogtagenemyonusecb = &dogtagenemyonusecb;
    }
    else
    {
        collectibles::initialize();
        callback::add( #"collectible_on_spawned", &collectiblespawned );
        callback::add( #"hash_64d5ef3aec7665f8", &function_616ab6b4ec977c84 );
        callback::add( #"hash_163ce3e6ccfcab8d", &function_6402fe41e96c7cad );
    }
    
    if ( function_af97119c53ff9092() )
    {
        halfscore = int( game_utility_mp::getscorelimit() / 2 );
        
        foreach ( team in level.teamnamelist )
        {
            function_b38d64e2ddc0d075( team, halfscore );
        }
    }
    
    /#
        thread function_d8499e5cde081c3a();
    #/
}

// Namespace conf
// Params 0
// Checksum 0x38b1dc48, Offset: 0x5bd
// Size: 0xd1
function initspawns()
{
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::function_6dbabb72223a4bca();
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

// Namespace conf
// Params 0
// Checksum 0xaee3e0ac, Offset: 0x696
// Size: 0x18
function updategametypedvars()
{
    common::updatecommongametypedvars();
    setdynamicdvar( @"scr_conf_promode", 0 );
}

// Namespace conf
// Params 0
// Checksum 0xfbf3dd6b, Offset: 0x6b6
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace conf
// Params 6
// Checksum 0x46cfb2f1, Offset: 0x6c8
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace conf
// Params 1
// Checksum 0x6edd59ab, Offset: 0x718
// Size: 0x1c
function onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill_collect_tags" );
}

// Namespace conf
// Params 1
// Checksum 0xa76a32c7, Offset: 0x73c
// Size: 0x4a, Type: bool
function checkcustomclosetoscorelimit( team )
{
    assert( isdefined( team ) );
    scorelimit = 10;
    var_d262c35ec7ded597 = level.roundscorelimit - getteamscore( team );
    
    if ( var_d262c35ec7ded597 <= scorelimit )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace conf
    // Params 0
    // Checksum 0x3f0c2f89, Offset: 0x78f
    // Size: 0xa2, Type: dev
    function function_d8499e5cde081c3a()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x24>", getdvarint( @"scr_give_score_allies" ), 0 );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x2b>", getdvarint( @"scr_give_score_axis" ), 0 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_d8499e5cde081c3a();
    }

#/

// Namespace conf
// Params 1, eflags: 0x4
// Checksum 0xec6398c6, Offset: 0x839
// Size: 0x27
function private collectiblespawned( params )
{
    gameplay_sound_fx::function_28103d3430792dce( params.spawn_origin, #"token_spawned" );
}

// Namespace conf
// Params 1, eflags: 0x4
// Checksum 0x5011a78a, Offset: 0x868
// Size: 0x1a8
function private function_616ab6b4ec977c84( params )
{
    gameplay_sound_fx::function_28103d3430792dce( params.player.origin, #"token_denied" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( params.player ) ) )
    {
        if ( isdefined( params.player.leaderboarddata[ "denied" ] ) )
        {
            params.player.leaderboarddata[ "denied" ] = params.player.leaderboarddata[ "denied" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "denied" ] ) )
        {
            [[ level.leaderboardfunc[ "denied" ] ]]( params.player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x30>" );
        
        if ( isdefined( params.player.pers[ "denied" ] ) )
        {
            params.player.pers[ "denied" ] = params.player.pers[ "denied" ] + 1;
        }
    }
    
    params.player persistence::statsetchild( "round", "denied", params.player.pers[ "denied" ] );
    dogtagallyonusecb( params.player );
}

// Namespace conf
// Params 1, eflags: 0x4
// Checksum 0x60d37bdb, Offset: 0xa18
// Size: 0x1a8
function private function_6402fe41e96c7cad( params )
{
    gameplay_sound_fx::function_28103d3430792dce( params.player.origin, #"token_confirmed" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( params.player ) ) )
    {
        if ( isdefined( params.player.leaderboarddata[ "confirmed" ] ) )
        {
            params.player.leaderboarddata[ "confirmed" ] = params.player.leaderboarddata[ "confirmed" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "confirmed" ] ) )
        {
            [[ level.leaderboardfunc[ "confirmed" ] ]]( params.player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x30>" );
        
        if ( isdefined( params.player.pers[ "confirmed" ] ) )
        {
            params.player.pers[ "confirmed" ] = params.player.pers[ "confirmed" ] + 1;
        }
    }
    
    params.player persistence::statsetchild( "round", "confirmed", params.player.pers[ "confirmed" ] );
    dogtagenemyonusecb( params.player );
}

// Namespace conf
// Params 1
// Checksum 0x888ee143, Offset: 0xbc8
// Size: 0x73
function dogtagallyonusecb( player )
{
    if ( isplayer( player ) )
    {
        player stats::setextrascore1( player.pers[ "denied" ], "denied" );
        player gamescore::giveteamscoreforobjective( player.pers[ "team" ], level.scoredeny, 0 );
        
        if ( function_4a6c38a05e6fc7f7() )
        {
            player givesuper();
        }
        
        player thread function_c3c6a729ca46502a();
    }
}

// Namespace conf
// Params 0, eflags: 0xc
// Checksum 0xa10c6650, Offset: 0xc43
// Size: 0x7d
function private function_c3c6a729ca46502a()
{
    self notify( #"hash_c29ec9a990f4d2ee" );
    self endon( #"hash_c29ec9a990f4d2ee" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.var_1ff1f3e81c4017f ) )
    {
        self.var_1ff1f3e81c4017f = 0;
    }
    
    self.var_1ff1f3e81c4017f += 1;
    wait 2;
    
    if ( self.var_1ff1f3e81c4017f >= 5 )
    {
        thread points::doscoreevent( #"mode_kc_mass_deny" );
    }
    
    self.var_1ff1f3e81c4017f = undefined;
}

// Namespace conf
// Params 1
// Checksum 0xafa0e390, Offset: 0xcc8
// Size: 0x13b
function dogtagenemyonusecb( player )
{
    if ( isplayer( player ) )
    {
        player dialog::leaderdialogonplayer( #"kill_confirmed", undefined, undefined, undefined, 4 );
        player stats::setextrascore0( player.pers[ "confirmed" ], "confirmed" );
        
        if ( function_4a6c38a05e6fc7f7() )
        {
            player givesuper();
        }
        
        if ( level.killstreakconfirmed )
        {
            if ( !isdefined( player.perks[ "specialty_killstreak_to_scorestreak" ] ) )
            {
                player killstreaks::givestreakpoints( #"capture", 1, 0 );
            }
            else
            {
                player killstreaks::givestreakpoints( #"capture", 1, 150 );
            }
        }
        
        player codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
    }
    
    player gamescore::giveteamscoreforobjective( player.pers[ "team" ], level.scoreconfirm, 0 );
    
    if ( function_af97119c53ff9092() )
    {
        otherteam = team_utility::getotherteam( player.pers[ "team" ] );
        newenemyscore = getteamscore( player.pers[ "team" ] );
        function_b38d64e2ddc0d075( otherteam, game_utility_mp::getscorelimit() - newenemyscore );
    }
}

// Namespace conf
// Params 0
// Checksum 0x5dcbe528, Offset: 0xe0b
// Size: 0x9
function givesuper()
{
    temp_v::function_b6bc6293e5bcfc9a();
}

// Namespace conf
// Params 0
// Checksum 0xf0a0d994, Offset: 0xe1c
// Size: 0xe, Type: bool
function function_af97119c53ff9092()
{
    return game_utility::getgametype() == "conf_tw";
}

// Namespace conf
// Params 0
// Checksum 0xa65d8719, Offset: 0xe33
// Size: 0xe, Type: bool
function function_4a6c38a05e6fc7f7()
{
    return game_utility::getgametype() == "conf_v";
}

// Namespace conf
// Params 2
// Checksum 0x3a93d33a, Offset: 0xe4a
// Size: 0x2f
function function_b38d64e2ddc0d075( team, score )
{
    gamescore::setteamscore( team, score, 0 );
    level notify( #"update_team_score", team, score );
}

