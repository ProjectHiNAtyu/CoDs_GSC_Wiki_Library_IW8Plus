// script_57977a85b1eff884  (hash_57977a85b1eff884.gscc) (size: 8811 Bytes / 0x226b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x22cb2905 (583739653)
// size ...... 8811 (0x226b)
// includes .. 12  (offset: 0x1fc7)
// strings ... 35  (offset: 0x2027)
// dev strs .. 0   (offset: 0x226b)
// exports ... 19  (offset: 0x1413)
// cseg ...... 0x2c4 + 0x114f (0x1413)
// imports ... 76  (offset: 0x170b)
// animtree1 . 0   (offset: 0x226b)
// animtree2 . 0   (offset: 0x226b)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dogtag;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnlogic;

#namespace tag_trap;

// Namespace tag_trap
// Params 0
// Checksum 0x4b4ea4b5, Offset: 0x2e2
// Size: 0x124
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    level.var_24f6a6e1dbb7504d = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_tag_trap" );
    allowed[ 0 ] = game_utility::getgametype();
    allowed[ 1 ] = "dom";
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonsuicidedeath = &onsuicidedeath;
    level.modeonspawnplayer = &onspawnplayer;
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
}

// Namespace tag_trap
// Params 0
// Checksum 0xfba8782, Offset: 0x40e
// Size: 0x9
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
}

// Namespace tag_trap
// Params 0
// Checksum 0x83355843, Offset: 0x41f
// Size: 0x179
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
    
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
    }
    else
    {
        initspawns();
    }
    
    level.var_793fa974b997308 = getentarray( "flag_primary", #targetname );
    thread function_c795c7cb2e89d830();
    thread function_7e2a3ff642d2ced6();
    thread function_ff721ac6d642374e();
}

// Namespace tag_trap
// Params 0
// Checksum 0xc6436af7, Offset: 0x5a0
// Size: 0x1ac
function function_c795c7cb2e89d830()
{
    level endon( #"game_ended" );
    level.var_b4256850b0e42c13 = 0;
    level.var_a0bb5fc91749774c = 0;
    
    while ( true )
    {
        level waittill( #"hash_d45c9edba70c5f14", player );
        axispoints = 0;
        allypoints = 0;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( player.team == "axis" )
            {
                axispoints += player.tagscarried ?? 0;
                axispoints += player.var_23dc427b6031ac61 ?? 0;
                continue;
            }
            
            allypoints += player.tagscarried ?? 0;
            allypoints += player.var_23dc427b6031ac61 ?? 0;
        }
        
        game[ "teamScores" ][ "axis" ] = axispoints;
        game[ "teamScores" ][ "allies" ] = allypoints;
        gamescore::updatetotalteamscore( "axis" );
        gamescore::updatetotalteamscore( "allies" );
        
        if ( level.var_b4256850b0e42c13 != axispoints || level.var_a0bb5fc91749774c != allypoints )
        {
            level.var_b4256850b0e42c13 = axispoints;
            level.var_a0bb5fc91749774c = allypoints;
            level notify( #"hash_b68eda7c221656ba" );
        }
    }
}

// Namespace tag_trap
// Params 2
// Checksum 0xed4d2f76, Offset: 0x754
// Size: 0x3a
function function_e5264d6090b70b51( winner, timetowait )
{
    level endon( #"hash_9b2c4d7e67b18434" );
    wait timetowait;
    gamelogic_mp::endgame( winner, game[ "end_reason" ][ "score_limit_reached" ] );
}

// Namespace tag_trap
// Params 0
// Checksum 0xbdff3ace, Offset: 0x796
// Size: 0x601
function function_7e2a3ff642d2ced6()
{
    level endon( #"game_ended" );
    setomnvar( "ui_match_timer_hidden", 1 );
    var_38adbe84648df51 = "";
    var_bfc2b2f5fb93bf7 = 0;
    scorelimit = getmatchrulesdata( "commonOption", "scoreLimit" );
    timelimit = getmatchrulesdata( "commonOption", "timeLimit" );
    
    while ( true )
    {
        level waittill( #"hash_b68eda7c221656ba", player );
        var_bf7e3c7ace97fedd = [];
        
        foreach ( player in level.players )
        {
            tagscarried = player.var_23dc427b6031ac61 ?? 0;
            
            if ( tagscarried < ( level.var_24f6a6e1dbb7504d.var_704a94f5428e034b ?? 3 ) )
            {
                continue;
            }
            
            if ( !isdefined( var_bf7e3c7ace97fedd[ player.team ] ) )
            {
                playerinfo = spawnstruct();
                playerinfo.player = player;
                playerinfo.tags = tagscarried;
                playerinfo.team = player.team;
                var_bf7e3c7ace97fedd[ player.team ] = playerinfo;
                continue;
            }
            
            if ( tagscarried > var_bf7e3c7ace97fedd[ player.team ].tags )
            {
                var_bf7e3c7ace97fedd[ player.team ].player = player;
                var_bf7e3c7ace97fedd[ player.team ].tags = tagscarried;
            }
        }
        
        if ( isdefined( level.var_bf7e3c7ace97fedd ) )
        {
            foreach ( carrier in level.var_bf7e3c7ace97fedd )
            {
                if ( !isdefined( carrier.player ) )
                {
                    continue;
                }
                
                if ( !isdefined( var_bf7e3c7ace97fedd[ carrier.team ] ) )
                {
                    continue;
                }
                
                if ( carrier.tags == var_bf7e3c7ace97fedd[ carrier.team ].tags )
                {
                    var_bf7e3c7ace97fedd[ carrier.team ].player = level.var_bf7e3c7ace97fedd[ carrier.team ].player;
                }
            }
        }
        
        level.var_bf7e3c7ace97fedd = var_bf7e3c7ace97fedd;
        
        foreach ( player in level.players )
        {
            if ( isdefined( level.var_bf7e3c7ace97fedd[ player.team ] ) && level.var_bf7e3c7ace97fedd[ player.team ].player == player )
            {
                if ( !isdefined( player.trackedobject ) )
                {
                    player.trackedobject = player gameobjects::createtrackedobject( player, ( 0, 0, 80 ) );
                    objidpoolmanager::objective_set_play_intro( player.trackedobject.objidnum, 0 );
                    objidpoolmanager::objective_set_play_outro( player.trackedobject.objidnum, 0 );
                    player.trackedobject gameobjects::setobjectivestatusicons( "waypoint_dogtags_friendly", "waypoint_dogtags_friendly" );
                    player.trackedobject gameobjects::setvisibleteam( "enemy" );
                    player hud_message::showsplash( "mp_gametype_tag_trap_tag_carrier_marked" );
                }
                
                continue;
            }
            
            if ( isdefined( player.trackedobject ) )
            {
                player.trackedobject gameobjects::deletetrackedobject();
                player.trackedobject = undefined;
            }
        }
        
        if ( game[ "teamScores" ][ "axis" ] < scorelimit && game[ "teamScores" ][ "allies" ] < scorelimit )
        {
            var_38adbe84648df51 = "";
            var_bfc2b2f5fb93bf7 = 0;
            level notify( #"hash_9b2c4d7e67b18434" );
            setomnvar( "ui_match_timer_hidden", 1 );
            continue;
        }
        
        winningteam = "axis";
        winningpoints = game[ "teamScores" ][ "axis" ];
        
        if ( game[ "teamScores" ][ "allies" ] > game[ "teamScores" ][ "axis" ] )
        {
            winningteam = "allies";
            winningpoints = game[ "teamScores" ][ "allies" ];
        }
        
        if ( winningteam != var_38adbe84648df51 && winningpoints > var_bfc2b2f5fb93bf7 )
        {
            level notify( #"hash_9b2c4d7e67b18434" );
            var_38adbe84648df51 = winningteam;
            var_bfc2b2f5fb93bf7 = winningpoints;
        }
        else
        {
            continue;
        }
        
        setomnvar( "ui_match_timer_hidden", 0 );
        setgameendtime( int( gettime() + timelimit * 1000 ) );
        
        foreach ( player in level.players )
        {
            if ( player.team == winningteam )
            {
                player hud_message::showsplash( "mp_gametype_tag_trap_allies_win_threat" );
                continue;
            }
            
            player hud_message::showsplash( "mp_gametype_tag_trap_enemies_win_threat" );
        }
        
        thread function_e5264d6090b70b51( var_38adbe84648df51, timelimit );
    }
}

// Namespace tag_trap
// Params 0
// Checksum 0x63f92254, Offset: 0xd9f
// Size: 0x2b2
function function_ff721ac6d642374e()
{
    level endon( #"game_ended" );
    
    if ( level.var_793fa974b997308.size == 0 )
    {
        return;
    }
    
    level waittill( #"matchstarttimer_done" );
    
    for ( k = 0; k < level.var_793fa974b997308.size ; k++ )
    {
        tagspawn = level.var_793fa974b997308[ k ];
        obj_dogtag::spawntag( undefined, undefined, "gold", tagspawn.origin );
    }
    
    visuals[ 0 ] = spawn( "script_model", ( 0, 0, 0 ) );
    visuals[ 0 ] setasgametypeobjective();
    visuals[ 0 ] hide();
    visuals[ 1 ] = spawn( "script_model", ( 0, 0, 0 ) );
    visuals[ 1 ] setasgametypeobjective();
    visuals[ 1 ] hide();
    trigger = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );
    objectivemarker = gameobjects::createuseobject( "neutral", trigger, visuals, ( 0, 0, 16 ) );
    objectivemarker.team = "neutral";
    objectivemarker.lastusedtime = 0;
    objectivemarker.offset3d = ( 0, 0, 24 );
    objectivemarker gameobjects::setvisibleteam( "none" );
    objectivemarker gameobjects::setobjectivestatusicons( "waypoint_dogtags_friendly", "waypoint_dogtags_friendly", objectivemarker.objidnum, "neutral" );
    
    while ( true )
    {
        wait level.var_24f6a6e1dbb7504d.var_39b2f7618a76e4d - 10;
        tagspawn = level.var_793fa974b997308[ randomint( level.var_793fa974b997308.size ) ];
        spawnorigin = tagspawn.origin;
        objectivemarker.curorigin = spawnorigin;
        objectivemarker.trigger.origin = spawnorigin;
        objidpoolmanager::update_objective_position( objectivemarker.objidnum, spawnorigin + ( 0, 0, 35 ) );
        objectivemarker gameobjects::setvisibleteam( "any" );
        wait 10;
        objectivemarker.curorigin = ( 0, 0, 0 );
        objectivemarker.trigger.origin = ( 0, 0, 0 );
        objidpoolmanager::update_objective_position( objectivemarker.objidnum, ( 0, 0, 0 ) );
        objidpoolmanager::function_eb808b97701a4793( objectivemarker.objidnum );
        obj_dogtag::spawntag( undefined, undefined, "gold", spawnorigin );
    }
}

// Namespace tag_trap
// Params 0
// Checksum 0x6aa2bc85, Offset: 0x1059
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace tag_trap
// Params 0
// Checksum 0xa153ee78, Offset: 0x106a
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

// Namespace tag_trap
// Params 0
// Checksum 0x43fa5663, Offset: 0x1154
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace tag_trap
// Params 1
// Checksum 0x324c0791, Offset: 0x1166
// Size: 0xc
function onplayerconnect( player )
{
    
}

// Namespace tag_trap
// Params 1
// Checksum 0x132e78c6, Offset: 0x117a
// Size: 0x38
function onplayerdisconnect( player )
{
    if ( isdefined( player.trackedobject ) )
    {
        player.trackedobject gameobjects::deletetrackedobject();
        player.trackedobject = undefined;
    }
}

// Namespace tag_trap
// Params 1
// Checksum 0x9eac0a66, Offset: 0x11ba
// Size: 0x1c
function onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
}

// Namespace tag_trap
// Params 6
// Checksum 0xe993b9d6, Offset: 0x11de
// Size: 0x53
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    level thread function_754a1644852a85cc( attacker, victim );
}

// Namespace tag_trap
// Params 1
// Checksum 0xba3a483e, Offset: 0x1239
// Size: 0x17
function onsuicidedeath( victim )
{
    level thread function_754a1644852a85cc( undefined, victim );
}

// Namespace tag_trap
// Params 2
// Checksum 0x5071af80, Offset: 0x1258
// Size: 0x40
function showtoteam( gameobject, team )
{
    gameobject endon( #"death" );
    gameobject endon( #"reset" );
    self setscriptablepartstate( "visibility", "show", 0 );
}

// Namespace tag_trap
// Params 2
// Checksum 0x213e267d, Offset: 0x12a0
// Size: 0x11d
function function_754a1644852a85cc( attacker, victim )
{
    if ( isagent( victim ) )
    {
        return;
    }
    
    dropparameters = spawnstruct();
    dropparameters.var_ae9955a29d0be226 = 200;
    dropparameters.var_aebc67a29d325174 = 400;
    dropparameters.movetime = 0.8;
    dropcap = level.var_24f6a6e1dbb7504d.var_d23dcce721d105e9 ?? 5;
    droppercentage = level.var_24f6a6e1dbb7504d.var_7998e7165df5f09b ?? 0.5;
    tagscarried = victim.var_23dc427b6031ac61 ?? 0;
    tagsdropped = dropcap + int( ( tagscarried - dropcap ) * droppercentage );
    
    if ( tagsdropped > tagscarried )
    {
        tagsdropped = tagscarried;
    }
    
    for ( k = 0; k < tagsdropped ; k++ )
    {
        obj_dogtag::spawntag( attacker, victim, "gold", undefined, dropparameters );
        wait 0.15;
    }
    
    victim obj_dogtag::function_20ead08067305b90( tagscarried - tagsdropped );
}

// Namespace tag_trap
// Params 0
// Checksum 0x349aa8b8, Offset: 0x13c5
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

