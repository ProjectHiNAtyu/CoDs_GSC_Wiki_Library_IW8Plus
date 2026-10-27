// scripts\mp\gametypes\sharp.gsc  (hash_181f897b8e85dd84.gscc) (size: 12199 Bytes / 0x2fa7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf7d57415 (4157961237)
// size ...... 12199 (0x2fa7)
// includes .. 18  (offset: 0x2c13)
// strings ... 47  (offset: 0x2ca3)
// dev strs .. 7   (offset: 0x2f53)
// exports ... 26  (offset: 0x1bbb)
// cseg ...... 0x3f0 + 0x17cb (0x1bbb)
// imports ... 106 (offset: 0x1fcb)
// animtree1 . 0   (offset: 0x2fa7)
// animtree2 . 0   (offset: 0x2fa7)
#using script_19aec99df234f03a;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\script;
#using scripts\mp\class;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace sharp;

// Namespace sharp
// Params 0
// Checksum 0xcd897d74, Offset: 0x40e
// Size: 0x151
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
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.onplayerdamaged = &onplayerdamaged;
    
    if ( level.teambased )
    {
        level.var_2d8ab98961edff5f = &function_d2471cd15336248e;
    }
    
    if ( !level.var_b9f5b44894d6b0f3 )
    {
        level.onplayerscore = &onplayerscore;
    }
    else
    {
        callback::add( #"hash_5e4c0033a7bbd7f", &updateplayerscore );
    }
    
    level.didhalfscorevoboost = 0;
    
    /#
        thread function_217a0b1e58bb9a8();
    #/
    
    level.denyclasschoice = 1;
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    level.loadout_changes = 0;
    createloadouts();
    function_ddce29e0356a0b59();
    thread function_cdc6fded985fe9e0();
    thread function_8dd96fb865cf434d();
}

// Namespace sharp
// Params 0
// Checksum 0xe4c554f9, Offset: 0x567
// Size: 0x22
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata( 1 );
    level.ladderindex = getmatchrulesdata( "gunData", "ladderIndex" );
}

// Namespace sharp
// Params 0
// Checksum 0xab0e862f, Offset: 0x591
// Size: 0x5e
function updategametypedvars()
{
    common::updatecommongametypedvars();
    setdvarifuninitialized( @"hash_94084550cb0f64e7", 1.2, 1, 2 );
    setdvar( @"hash_b7318d7f06303895", 1 );
    level.var_b9f5b44894d6b0f3 = getdvarint( @"hash_1c6e2fb602f2f4a3", getmatchrulesdata( "commonOption", "overrideScoringOnExtraScore5" ) ?? 0 );
}

// Namespace sharp
// Params 0
// Checksum 0x13812abd, Offset: 0x5f7
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

// Namespace sharp
// Params 0
// Checksum 0x7d42a6b2, Offset: 0x6d9
// Size: 0x150
function initspawns()
{
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( level.teambased )
    {
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
    }
    else if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
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

// Namespace sharp
// Params 0
// Checksum 0x8ff4703a, Offset: 0x831
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

// Namespace sharp
// Params 1
// Checksum 0x39cfdaf8, Offset: 0x8a0
// Size: 0x4c
function onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    self.var_2c86b6b3191f8056 = 0;
    function_7c1a047498aeddef();
    namespace_69e3a436b5d8370e::function_66186e21ab56457c();
    level notify( #"spawned_player" );
    hud_message::showsplash( "equipped_perks_mp" );
}

// Namespace sharp
// Params 1
// Checksum 0xe17a5f6d, Offset: 0x8f4
// Size: 0x104
function updateplayerscore( deathdata )
{
    attacker = deathdata.attacker;
    adjustedscore = rank::getscoreinfovalue( #"score_increment" );
    assert( isdefined( adjustedscore ) );
    basescore = adjustedscore;
    
    if ( attacker.var_2c86b6b3191f8056 )
    {
        adjustedscore *= 2;
    }
    
    if ( level.var_4d3dbf22dde53bd1 )
    {
        adjustedscore *= 2;
    }
    
    if ( attacker.var_2c86b6b3191f8056 || level.var_4d3dbf22dde53bd1 )
    {
        attacker stats::setextrascore2( attacker.pers[ "extrascore2" ] + adjustedscore );
        
        if ( level.teambased && adjustedscore - basescore > 0 )
        {
            level gamescore::giveteamscoreforobjective( attacker.pers[ "team" ], adjustedscore - basescore, 0 );
        }
    }
    
    attacker stats::function_fe615555f60e88b9( attacker.pers[ "extrascore5" ] + adjustedscore );
}

// Namespace sharp
// Params 6
// Checksum 0x4c3e4a84, Offset: 0xa00
// Size: 0x152
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( !level.didhalfscorevoboost )
    {
        if ( attacker.score >= int( level.scorelimit * level.currentround - level.scorelimit / 2 ) )
        {
            thread dohalftimevo( attacker );
        }
    }
    
    if ( attacker.score == level.scorelimit - 2 )
    {
        level.kick_afk_check = 1;
    }
    
    streak = attacker.pers[ "killChains" ];
    
    if ( isdefined( streak ) )
    {
        attacker stats::setextrascore1( streak );
    }
    
    attacker stats::setextrascore3( attacker.pers[ "longestStreak" ], "longeststreak" );
    attacker.var_ec07ce486ea56ecd++;
    
    if ( attacker.var_ec07ce486ea56ecd == 3 )
    {
        attacker thread points::doscoreevent( #"triple_kill_sharpshooter" );
    }
    
    attacker givebonus( attacker.killcountthislife );
    
    if ( level.teambased )
    {
        common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    }
}

// Namespace sharp
// Params 15
// Checksum 0xa3104807, Offset: 0xb5a
// Size: 0xd5
function onplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage )
{
    if ( eattacker != victim && eattacker.team != victim.team && isplayer( eattacker ) )
    {
        eattacker stats::setextrascore0( eattacker.pers[ "damage" ], "damage" );
    }
}

// Namespace sharp
// Params 5
// Checksum 0x150df7e8, Offset: 0xc37
// Size: 0x2f0
function onplayerscore( event, player, originalpoints, victim, eventinfo )
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "gamemodeScore" ] ) )
        {
            player.leaderboarddata[ "gamemodeScore" ] = player.leaderboarddata[ "gamemodeScore" ] + originalpoints;
        }
        
        if ( isdefined( level.leaderboardfunc[ "gamemodeScore" ] ) )
        {
            [[ level.leaderboardfunc[ "gamemodeScore" ] ]]( player, originalpoints );
        }
        
        assert( isint( originalpoints ) || isfloat( originalpoints ), "<dev string:x49>" );
        
        if ( isdefined( player.pers[ "gamemodeScore" ] ) )
        {
            player.pers[ "gamemodeScore" ] = player.pers[ "gamemodeScore" ] + originalpoints;
        }
    }
    
    if ( isdefined( eventinfo ) )
    {
        if ( eventinfo.var_a1142360cbd74f69 )
        {
            return ( level.gametypebundle.var_e6d8e56a8f68419d ? originalpoints : 0 );
        }
    }
    
    adjustedscore = rank::getscoreinfovalue( #"score_increment" );
    assert( isdefined( adjustedscore ) );
    var_9f71c6384859861d = level.gamemodebundle.var_67302f78b191f13a && eventinfo.var_9f71c6384859861d;
    
    if ( event == #"kill" || var_9f71c6384859861d && ( player.var_2c86b6b3191f8056 || level.var_4d3dbf22dde53bd1 ) )
    {
        basescore = adjustedscore;
        
        if ( player.var_2c86b6b3191f8056 )
        {
            adjustedscore *= 2;
        }
        
        if ( level.var_4d3dbf22dde53bd1 )
        {
            adjustedscore *= 2;
        }
        
        player stats::setextrascore2( player.pers[ "extrascore2" ] + adjustedscore );
        
        if ( level.teambased && adjustedscore - basescore > 0 )
        {
            level gamescore::giveteamscoreforobjective( player.pers[ "team" ], adjustedscore - basescore, 0 );
        }
        
        return ( level.gametypebundle.var_e6d8e56a8f68419d ? originalpoints : adjustedscore );
    }
    else if ( event == #"kill" || var_9f71c6384859861d || isdefined( eventinfo ) && eventinfo.iskillstreakkill )
    {
        return ( level.gametypebundle.var_e6d8e56a8f68419d ? originalpoints : adjustedscore );
    }
    else if ( event == #"assist_ffa" )
    {
        player script::bufferednotify( "earned_score_buffered", originalpoints );
    }
    
    return level.gametypebundle.var_e6d8e56a8f68419d ? originalpoints : 0;
}

// Namespace sharp
// Params 1
// Checksum 0xa94f2d7d, Offset: 0xf30
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

// Namespace sharp
// Params 2
// Checksum 0xd41cc033, Offset: 0xfe0
// Size: 0x2c, Type: bool
function compare_player_score( left, right )
{
    return left.score >= right.score;
}

// Namespace sharp
// Params 1
// Checksum 0x30e241da, Offset: 0x1015
// Size: 0xb9
function onplayerconnect( player )
{
    player class::function_e84a99f0f4904c66();
    player.pers[ "gamemodeLoadout" ] = function_86e5b1603761ed9d();
    player stats::setextrascore2( player.pers[ "extrascore2" ] ?? 0, "extrascore2" );
    player.var_ec07ce486ea56ecd = 0;
    
    if ( level.gametypebundle.var_b861684883c8d831 )
    {
        player callback::add( #"reload", &function_f442b6f02070a04 );
    }
    
    if ( level.var_b9f5b44894d6b0f3 )
    {
        player stats::function_fe615555f60e88b9( player.pers[ "extrascore5" ] ?? 0, "extrascore5" );
    }
}

// Namespace sharp
// Params 1
// Checksum 0x9234a1bb, Offset: 0x10d6
// Size: 0x84
function function_f442b6f02070a04( params )
{
    foreach ( weapon in self.primaryweapons )
    {
        self givemaxammo( weapon );
    }
}

// Namespace sharp
// Params 0
// Checksum 0x2bef3716, Offset: 0x1162
// Size: 0x2d9
function createloadouts()
{
    level.var_91c21a7253c7a37f = [];
    assert( isdefined( level.gametypebundle.var_14a374941dd4696c ), "<dev string:x6f>" );
    
    foreach ( var_471f67719c37edf3 in level.gametypebundle.var_14a374941dd4696c )
    {
        classtablebundle = getscriptbundle( var_471f67719c37edf3.bundle );
        assert( isdefined( classtablebundle ), "<dev string:xdb>" );
        var_c4996f9a3e920475 = arrayrandomize( classtablebundle.classlist );
        
        foreach ( loadoutentry in var_c4996f9a3e920475 )
        {
            assert( isdefined( loadoutentry ), "<dev string:x117>" );
            var_79240becd50c909e = hashcat( %"classtableentry:", loadoutentry.entry );
            var_227506a321482ad6 = getscriptbundle( var_79240becd50c909e );
            assert( isdefined( var_227506a321482ad6 ), "<dev string:x152>" );
            sharploadout = class::function_79947c7814a64d0e( var_227506a321482ad6 );
            
            if ( isdefined( level.ladderindex ) )
            {
                switch ( level.ladderindex )
                {
                    case 4:
                    case 5:
                    case 6:
                        if ( isdefined( sharploadout[ "loadoutPrimaryVariantID" ] ) && sharploadout[ "loadoutPrimaryVariantID" ] != "-1" )
                        {
                            sharploadout[ "loadoutPrimaryVariantID" ] = class::table_parseweaponvariantidvalue( sharploadout[ "loadoutPrimary" ], sharploadout[ "loadoutPrimaryVariantID" ], 0 );
                            class::function_48beae0092e1c9e9( sharploadout );
                        }
                        
                        if ( isdefined( sharploadout[ "loadoutSecondaryVariantID" ] ) && sharploadout[ "loadoutSecondaryVariantID" ] != "-1" )
                        {
                            sharploadout[ "loadoutSecondaryVariantID" ] = class::table_parseweaponvariantidvalue( sharploadout[ "loadoutSecondary" ], sharploadout[ "loadoutSecondaryVariantID" ], 0 );
                            class::function_b39175d63d495f69( sharploadout );
                        }
                        
                        if ( isdefined( sharploadout[ "loadoutTertiaryVariantID" ] ) && sharploadout[ "loadoutTertiaryVariantID" ] != "-1" )
                        {
                            sharploadout[ "loadoutTertiaryVariantID" ] = class::table_parseweaponvariantidvalue( sharploadout[ "loadoutTertiary" ], sharploadout[ "loadoutTertiaryVariantID" ], 0 );
                        }
                    default:
                        break;
                }
            }
            
            level.var_91c21a7253c7a37f[ level.var_91c21a7253c7a37f.size ] = sharploadout;
        }
    }
}

// Namespace sharp
// Params 0
// Checksum 0x6c28d022, Offset: 0x1443
// Size: 0xb
function function_86e5b1603761ed9d()
{
    return level.currentloadout;
}

// Namespace sharp
// Params 0
// Checksum 0x8716ee4, Offset: 0x1457
// Size: 0x49
function function_ddce29e0356a0b59()
{
    level.currentloadout = level.var_91c21a7253c7a37f[ level.loadout_changes ];
    level.loadout_changes++;
    
    if ( level.loadout_changes == level.var_91c21a7253c7a37f.size )
    {
        level.loadout_changes = 0;
    }
}

// Namespace sharp
// Params 1
// Checksum 0xc0ae3033, Offset: 0x14a8
// Size: 0x1b3
function function_cdc6fded985fe9e0( var_526800466f506c0f )
{
    level endon( #"disconnect" );
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    
    while ( true )
    {
        countdown_time = 45;
        nextsecond = gettime();
        
        while ( countdown_time > 0 )
        {
            foreach ( player in level.players )
            {
                player setclientomnvar( "ui_sharp_loadout_countdown", countdown_time - 1 );
                
                if ( countdown_time == 5 )
                {
                    player gameplay_sound_fx::playlocalsoundfx( "sharpshooter_countdown_warning" );
                    continue;
                }
                
                if ( countdown_time < 5 )
                {
                    player gameplay_sound_fx::playlocalsoundfx( "sharpshooter_countdown_tick" );
                }
            }
            
            nextsecond += 1000;
            wait ( nextsecond - gettime() ) * 0.001;
            countdown_time--;
        }
        
        function_ddce29e0356a0b59();
        
        foreach ( player in level.players )
        {
            player thread dialog::leaderdialogonplayer( #"change_weapon", "gametype" );
            thread function_b9255c9e0fe0ecc0( player );
        }
    }
}

// Namespace sharp
// Params 1
// Checksum 0x221d570a, Offset: 0x1663
// Size: 0xc7
function function_b9255c9e0fe0ecc0( player )
{
    player.pers[ "gamemodeLoadout" ] = function_86e5b1603761ed9d();
    player setclientomnvar( "ui_sharp_loadout_countdown", 0 );
    player class::giveloadout( player.team, "gamemode" );
    player hud_message::showsplash( "equipped_perks_mp" );
    player gameplay_sound_fx::playlocalsoundfx( #"hash_a3de10a733807413" );
    player.var_ec07ce486ea56ecd = 0;
    
    if ( player.killcountthislife )
    {
        for ( index = 1; index <= player.killcountthislife ; index++ )
        {
            appliedperk = player givebonus( index, 0 );
            
            if ( !appliedperk )
            {
                break;
            }
        }
    }
}

// Namespace sharp
// Params 0
// Checksum 0xde3cc8b6, Offset: 0x1732
// Size: 0x102
function function_8dd96fb865cf434d()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    setomnvar( "ui_double_score_active", 0 );
    timetowait = level.timelimit - ( level.gametypebundle.var_9dea43438d7d045e ?? 60 );
    wait timetowait < 0 ? 0 : timetowait;
    level.var_4d3dbf22dde53bd1 = 1;
    setomnvar( "ui_double_score_active", 1 );
    
    foreach ( player in level.players )
    {
        player function_7c1a047498aeddef();
        player gameplay_sound_fx::playlocalsoundfx( #"hash_1745f02f4f318207" );
    }
}

// Namespace sharp
// Params 0
// Checksum 0xb441d3eb, Offset: 0x183c
// Size: 0x59
function function_7c1a047498aeddef()
{
    if ( !level.gametypebundle.var_e6d8e56a8f68419d )
    {
        return;
    }
    
    scalar = 1;
    
    if ( self.var_2c86b6b3191f8056 )
    {
        scalar *= 2;
    }
    
    if ( level.var_4d3dbf22dde53bd1 )
    {
        scalar *= 2;
    }
    
    self.point_scalar = scalar;
}

// Namespace sharp
// Params 4
// Checksum 0xd65a7156, Offset: 0x189d
// Size: 0x4f
function function_d2471cd15336248e( score, victim, var_11e7af11ea100dd0, lifeid )
{
    if ( self.var_2c86b6b3191f8056 )
    {
        score *= 2;
    }
    
    if ( level.var_4d3dbf22dde53bd1 )
    {
        score *= 2;
    }
    
    return score;
}

// Namespace sharp
// Params 2
// Checksum 0x32a89e40, Offset: 0x18f5
// Size: 0x145
function givebonus( streak, shouldplaysound = 1 )
{
    appliedperk = 1;
    var_9125286f4ca0d294 = "none";
    
    switch ( streak )
    {
        case 1:
            perk::giveperk( "specialty_super_speed" );
            var_9125286f4ca0d294 = #"hash_e96119e6a36c7562";
            break;
        case 2:
            perk::giveperk( "specialty_fastreload" );
            var_9125286f4ca0d294 = #"hash_ac55e0e680bbd2d8";
            break;
        case 3:
            perk::giveperk( "specialty_fastsprintrecovery" );
            var_9125286f4ca0d294 = #"hash_36d9c5a6bd726d5a";
            break;
        case 4:
            perk::giveperk( "specialty_quickdraw" );
            var_9125286f4ca0d294 = #"hash_3f582223b02448ea";
            break;
        case 5:
            self.var_2c86b6b3191f8056 = 1;
            function_7c1a047498aeddef();
            var_9125286f4ca0d294 = #"hash_4dff5323b7aec1b2";
            break;
        default:
            appliedperk = 0;
            break;
    }
    
    if ( var_9125286f4ca0d294 != "none" && shouldplaysound )
    {
        gameplay_sound_fx::playlocalsoundfx( var_9125286f4ca0d294 );
    }
    
    if ( appliedperk )
    {
        thread namespace_69e3a436b5d8370e::function_323d8c9159939a6d( streak );
    }
    
    return appliedperk;
}

/#

    // Namespace sharp
    // Params 0
    // Checksum 0xdd8152cf, Offset: 0x1a43
    // Size: 0x178, Type: dev
    function function_217a0b1e58bb9a8()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 || getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                points = 0;
                pointsallies = getdvarint( @"scr_give_score_allies", 0 );
                pointsaxis = getdvarint( @"scr_give_score_axis", 0 );
                
                if ( pointsallies > 0 )
                {
                    points = pointsallies;
                }
                
                if ( pointsaxis > 0 )
                {
                    points = pointsaxis;
                }
                
                if ( pointsallies < 0 || pointsaxis < 0 )
                {
                    points = getdvarint( @"scr_sharp_scorelimit" ) - 1;
                }
                
                foreach ( player in level.players )
                {
                    for ( i = 0; i < points ; i++ )
                    {
                        player gamescore::giveplayerscore( #"kill", 1 );
                    }
                    
                    waitframe();
                }
                
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_217a0b1e58bb9a8();
    }

#/
