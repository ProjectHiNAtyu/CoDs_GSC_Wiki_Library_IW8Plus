// scripts\mp\gametypes\common.gsc  (hash_0fd32f08e72b657f.gscc) (size: 61043 Bytes / 0xee73 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb1c72085 (2982617221)
// size ...... 61043 (0xee73)
// includes .. 56  (offset: 0xd92b)
// strings ... 307 (offset: 0xdaeb)
// dev strs .. 25  (offset: 0xed3b)
// exports ... 137 (offset: 0x940f)
// cseg ...... 0x1909 + 0x7b06 (0x940f)
// imports ... 381 (offset: 0xa977)
// animtree1 . 0   (offset: 0xee73)
// animtree2 . 0   (offset: 0xee73)
#using scripts\common\ai\stealth\player;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\calloutmarkerping_mp;
#using scripts\mp\cash;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\connect_event_aggregator;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\cranked;
#using scripts\mp\damage;
#using scripts\mp\flags;
#using scripts\mp\flashpoint;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\obj_dogtag;
#using scripts\mp\gametypes\team_gun;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\lightarmor;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\mp_gameskill;
#using scripts\mp\persistence;
#using scripts\mp\playerachievements;
#using scripts\mp\playerhealth;
#using scripts\mp\rank;
#using scripts\mp\spawnselection;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace common;

// Namespace common
// Params 0
// Checksum 0x730312d, Offset: 0x1927
// Size: 0x128
function setupcommoncallbacks()
{
    level.onnormaldeath = &oncommonnormaldeath;
    level.onsuicidedeath = &oncommonsuicidedeath;
    level.onteamchangedeath = &oncommonteamchangedeath;
    addspecialistdialog();
    level.var_885d3c647bfeebc3 = &function_885d3c647bfeebc3;
    [[ level.var_885d3c647bfeebc3 ]]();
    function_f22100b70b7be286();
    function_d5f384ddea865da();
    function_524560d2d6c87449();
    function_2da9f3f04a883d1c();
    function_f74f31d61b67577();
    function_7f8bc379edf2db1f();
    function_90073dd5a95d7789();
    function_8ec16b91852dfeac();
    function_6e93daf9adbbe95b();
    function_fb24bb58f0e3974a();
    level.spawnprotectionexception = undefined;
    join_team_aggregator::registeronplayerjointeamcallback( &onplayerjointeamcommon );
    function_59db47a8fd9a0762();
    utility::registersharedfunc( #"player", #"hash_1f1ccdc6843fdbb", &function_8ff835bf23198a0 );
    utility::registersharedfunc( #"player", #"hash_c707c518748873ce", &function_6f182a842ea5e2f1 );
    utility::registersharedfunc( #"player", #"hash_a769545511e9bef", &function_d85a92c557ea5a52 );
    utility::registersharedfunc( #"player", #"hash_804044713d3198ac", &function_79211cd1f2b54512 );
}

// Namespace common
// Params 0
// Checksum 0xb535d9b9, Offset: 0x1a57
// Size: 0xda
function function_885d3c647bfeebc3()
{
    setdynamicdvar( @"scr_game_aiagentsinmp", getmatchrulesdata( "commonOption", "aiAgentsInMP" ) );
    setdynamicdvar( @"scr_game_aispawnondeath", getmatchrulesdata( "commonOption", "aiSpawnOnDeath" ) );
    setdynamicdvar( @"scr_game_buymode", getmatchrulesdata( "commonOption", "buyMode" ) );
    setdynamicdvar( @"hash_4e33f79a5437aa5c", getmatchrulesdata( "commonOption", "classForceLoadouts" ) );
    setdynamicdvar( @"hash_d57ff1df5bcafc0e", getmatchrulesdata( "commonOption", "allowCalloutMarkerPing" ) );
    setdynamicdvar( @"hash_2ffb8f1240874ed8", getmatchrulesdata( "commonOption", "alliedAgentsNamePlatesForceHidden" ) );
    
    if ( getdvarint( @"hash_969da081cdd3cead", 0 ) )
    {
        setdynamicdvar( @"scr_game_aiagentsinmp", 1 );
        setdynamicdvar( @"scr_game_aispawnondeath", 0 );
    }
}

// Namespace common
// Params 0
// Checksum 0xcb6b8c25, Offset: 0x1b39
// Size: 0x2d
function commononstartgametype()
{
    level.usepingsystem = getdvarint( @"hash_d57ff1df5bcafc0e", 1 );
    
    if ( level.usepingsystem )
    {
        calloutmarkerping_mp::calloutmarkerping_init();
    }
}

// Namespace common
// Params 0
// Checksum 0x3097877b, Offset: 0x1b6e
// Size: 0xdf
function updatecommongametypedvars()
{
    if ( isdefined( game_utility_mp::function_4b7180ed8c2e9742( "dogtagsettings" ) ) )
    {
        level.dogtagsenabled = 1;
        obj_dogtag::init();
    }
    else
    {
        level.dogtagsenabled = 0;
    }
    
    level.mtxkillthresholdstage1 = int( clamp( getdvarint( @"hash_39892290cce0c05", 10 ), 1, 10000 ) );
    level.mtxkillthresholdstage2 = int( clamp( getdvarint( @"hash_3988f290cce056c", 20 ), 1, 10000 ) );
    level.var_5b9c78d5e5581287 = int( clamp( getdvarint( @"hash_39890290cce079f", 30 ), 1, 10000 ) );
    assert( level.mtxkillthresholdstage1 < level.mtxkillthresholdstage2, "<dev string:x24>" );
    assert( level.mtxkillthresholdstage2 < level.var_5b9c78d5e5581287, "<dev string:x61>" );
}

// Namespace common
// Params 6
// Checksum 0xbd118580, Offset: 0x1c55
// Size: 0x59b
function oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    score = 0;
    
    if ( isbot( self ) && isdefined( self.isbotmedicrole ) )
    {
        self.isbotmedicrole = undefined;
    }
    
    if ( level.flashpointactive && isdefined( attacker ) && isdefined( attacker.team ) )
    {
        flashpoint::flashpoint_processnewevent( attacker, victim, gettime(), "kill_by_" + attacker.team );
    }
    
    if ( isdefined( attacker.damagetrigger ) && isdefined( attacker.damagetrigger.objweapon ) && attacker.damagetrigger.objweapon.basename == "iw9_racecar_mp" )
    {
        return 1;
    }
    
    var_11e7af11ea100dd0 = game_utility_mp::islaststandenabled() && victim.playergoingintols;
    
    if ( !var_11e7af11ea100dd0 && isdefined( attacker.team ) && attacker.team != self.team )
    {
        var_18031baf2fc2d180 = level.scoremod[ "death" ] * -1;
        
        if ( var_18031baf2fc2d180 != 0 )
        {
            if ( level.teambased )
            {
                level gamescore::giveteamscoreforobjective( victim.pers[ "team" ], var_18031baf2fc2d180, 0 );
            }
            else
            {
                attacker gamescore::giveplayerscore( #"kill", var_18031baf2fc2d180 );
            }
        }
        
        score = level.scoremod[ "kill" ];
        
        if ( iskillstreakweapon )
        {
            score += level.scoremod[ "kskill" ];
        }
        
        if ( meansofdeath == "MOD_HEAD_SHOT" )
        {
            score += level.scoremod[ "headshot" ];
        }
    }
    
    if ( isdefined( level.var_2d8ab98961edff5f ) )
    {
        score = attacker [[ level.var_2d8ab98961edff5f ]]( score, victim, var_11e7af11ea100dd0, lifeid );
    }
    
    if ( team_gun::function_ab3051539fb113f1() )
    {
        isknife = weapon_utility::isknifeonly( objweapon.basename ) || weapon::isakimbomeleeweapon( objweapon.basename ) || weapon::function_33e74163843b348e( objweapon.basename ) || weapon::function_e93a21a657377115( objweapon );
        isexecution = meansofdeath == "MOD_EXECUTION";
        
        if ( isexecution || meansofdeath == "MOD_MELEE" && isknife )
        {
            score = 0;
            victimteamscore = getteamscore( victim.pers[ "team" ] );
            
            if ( victimteamscore > 0 && !( victimteamscore % level.var_fcd385b442eeddf6 == 0 ) )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                {
                    if ( isdefined( victim.leaderboarddata[ "setbacks" ] ) )
                    {
                        victim.leaderboarddata[ "setbacks" ] = victim.leaderboarddata[ "setbacks" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "setbacks" ] ) )
                    {
                        [[ level.leaderboardfunc[ "setbacks" ] ]]( victim, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x9e>" );
                    
                    if ( isdefined( victim.pers[ "setbacks" ] ) )
                    {
                        victim.pers[ "setbacks" ] = victim.pers[ "setbacks" ] + 1;
                    }
                }
                
                victim persistence::statsetchild( "round", "setbacks", victim.pers[ "setbacks" ] );
                victim stats::setextrascore1( victim.pers[ "setbacks" ], "setbacks" );
                level gamescore::giveteamscoreforobjective( victim.pers[ "team" ], -1, 0 );
            }
        }
    }
    
    if ( isdefined( level.var_702441c61cdd5ec8 ) )
    {
        score += victim [[ level.var_702441c61cdd5ec8 ]]() ? getdvarint( @"hash_8c874586f2124786", 4 ) : 0;
    }
    
    if ( level.gametype == "war" && getdvarint( @"hash_4753586a2ac8718f", 0 ) == 1 )
    {
        headsize = victim getclientomnvar( "ui_voxel_head_size" );
        score *= headsize;
    }
    
    if ( score != 0 )
    {
        if ( level.teambased )
        {
            level gamescore::giveteamscoreforobjective( attacker.pers[ "team" ], score, 0 );
        }
        else
        {
            attacker gamescore::giveplayerscore( #"kill", score, victim );
        }
    }
    
    if ( isdefined( level.var_6dec3d2bdd75f49a ) )
    {
        level thread [[ level.var_6dec3d2bdd75f49a ]]( victim, attacker );
    }
    
    if ( game_utility::function_ae97372c83da7acc() && getdvarint( @"hash_6ce02fdc43b4f5cf", 0 ) != 0 )
    {
        victim spawnhealthpickup();
    }
    
    if ( isplayer( attacker ) && !isbrgamemode() )
    {
        killfeeddata = meansofdeath == "MOD_HEAD_SHOT";
        killfeeddata += level.scoremod[ "kill" ] << 4;
        attacker killfeedevent( killfeeddata, victim getentitynumber() );
    }
    
    if ( utility::issharedfuncdefined( #"hash_e8cc48aecfa87408", #"hash_8f0a0e35806a9f12" ) )
    {
        utility::callsharedfunc( #"hash_e8cc48aecfa87408", #"hash_8f0a0e35806a9f12", victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    }
}

// Namespace common
// Params 1
// Checksum 0xe718a066, Offset: 0x21f8
// Size: 0xd1
function oncommonsuicidedeath( victim )
{
    callback::callback( #"hash_69215f7cb166ba95", { #victim:victim } );
    
    if ( isdefined( level.scoremod ) )
    {
        var_18031baf2fc2d180 = level.scoremod[ "death" ] * -1;
        
        if ( var_18031baf2fc2d180 != 0 )
        {
            if ( level.teambased )
            {
                level gamescore::giveteamscoreforobjective( victim.pers[ "team" ], var_18031baf2fc2d180, 0 );
            }
        }
    }
    
    if ( isdefined( level.modeonsuicidedeath ) )
    {
        [[ level.modeonsuicidedeath ]]( victim );
    }
    
    if ( utility::issharedfuncdefined( #"hash_e8cc48aecfa87408", #"hash_1fc06d21c34e5c7d" ) )
    {
        utility::callsharedfunc( #"hash_e8cc48aecfa87408", #"hash_1fc06d21c34e5c7d" );
    }
}

// Namespace common
// Params 1
// Checksum 0x146ab692, Offset: 0x22d1
// Size: 0x43
function oncommonteamchangedeath( victim )
{
    callback::callback( #"hash_b08f691cf30f9def", { #victim:victim } );
    
    if ( isdefined( level.modeonteamchangedeath ) )
    {
        [[ level.modeonteamchangedeath ]]( victim );
    }
}

// Namespace common
// Params 1
// Checksum 0x8b4e0ffd, Offset: 0x231c
// Size: 0xc
function dogtagcommonallyonusecb( player )
{
    
}

// Namespace common
// Params 1
// Checksum 0x83f2f18c, Offset: 0x2330
// Size: 0xc
function dogtagcommonenemyonusecb( player )
{
    
}

// Namespace common
// Params 1
// Checksum 0x1b8ad628, Offset: 0x2344
// Size: 0x155
function onspawnplayercommon( revivespawn )
{
    if ( game[ "inLiveLobby" ] )
    {
        var_8925574bd1d3f939 = level.allowprematchdamage && level.spawnprotectiontimer;
        thread managespawnprotection( var_8925574bd1d3f939 );
    }
    else if ( level.spawnprotectiontimer && !revivespawn )
    {
        if ( isdefined( level.spawnprotectionexception ) )
        {
            if ( [[ level.spawnprotectionexception ]]() )
            {
                thread managespawnprotection( 1 );
            }
        }
        else
        {
            thread managespawnprotection( 1 );
        }
    }
    
    if ( self.var_c19506b543ae5021 )
    {
        thread function_de294efa1b7f245();
    }
    
    if ( level.disablesupersprint )
    {
        self allowsupersprint( 0 );
    }
    
    if ( level.disablemount )
    {
        self allowmountside( 0 );
        self allowmounttop( 0 );
    }
    
    if ( isdefined( level.modeonspawnplayer ) )
    {
        [[ level.modeonspawnplayer ]]( revivespawn );
    }
    else
    {
        thread updatematchstatushintonspawncommon();
    }
    
    if ( game_utility_mp::function_57a25addb5327c1a() )
    {
        updatealiveomnvars();
    }
    
    if ( game[ "practiceRound" ] )
    {
        if ( level.snowballfight )
        {
            thread snowballfighthint();
        }
        else
        {
            self sethudtutorialmessage( "MP_INGAME_ONLY/PRACTICE_ROUND", 1 );
        }
    }
    else if ( !isagent( self ) )
    {
        self clearhudtutorialmessage();
    }
    
    if ( isdefined( level.elevatoronspawnplayer ) )
    {
        self [[ level.elevatoronspawnplayer ]]();
    }
}

// Namespace common
// Params 1
// Checksum 0x8246970c, Offset: 0x24a1
// Size: 0x10c
function nvghintnotify( nummessages )
{
    self endon( #"disconnect" );
    self notify( #"hash_71b93136c2ad91a5" );
    self endon( #"hash_71b93136c2ad91a5" );
    firstspawn = 1;
    
    if ( !isdefined( nummessages ) )
    {
        nummessages = 0;
    }
    
    while ( true )
    {
        if ( firstspawn )
        {
            self waittill( #"giveloadout" );
        }
        else
        {
            self waittill( #"spawned" );
        }
        
        if ( nummessages < 2 )
        {
            if ( self usinggamepad() )
            {
                msg = "hint_use_nvg";
            }
            else
            {
                msg = "hint_use_nvg_kb";
            }
            
            if ( flags::gameflag( "infil_will_run" ) && !flags::gameflag( "prematch_done" ) )
            {
                level waittill( #"prematch_done" );
                wait 5;
                lower_message::setlowermessageomnvar( msg );
                wait 5;
                lower_message::setlowermessageomnvar( "clear_lower_msg" );
            }
            else
            {
                if ( !nummessages )
                {
                    wait 5;
                }
                
                lower_message::setlowermessageomnvar( msg );
                wait 5;
                lower_message::setlowermessageomnvar( "clear_lower_msg" );
            }
            
            nummessages++;
            continue;
        }
        
        break;
    }
}

// Namespace common
// Params 0
// Checksum 0x1ad1a074, Offset: 0x25b5
// Size: 0x2d
function function_490196f3e51aca75()
{
    if ( self iscodcaster() )
    {
        return;
    }
    
    achievementid = getdvarint( @"hash_7b6a932574c43db8", 0 );
    self function_fdf029c4be6546a3( achievementid );
}

// Namespace common
// Params 2
// Checksum 0x69d44706, Offset: 0x25ea
// Size: 0x11e
function function_34d520dd8ca5ec48( achievementid, progressdata )
{
    var_4e012b9657875994 = getdvarint( @"hash_7b6a932574c43db8", 0 );
    trialtimelimit = getdvarint( @"hash_a82da6c4bfc1360a", 9000 );
    
    if ( achievementid == var_4e012b9657875994 )
    {
        trial_progress_id = playerachievements::function_a550b9c75bcbee5e( "progress" );
        progress = 0;
        
        for ( index = 0; index < progressdata.progress_values.size ; index++ )
        {
            progress_id = progressdata.progress_values[ index ].progress_id;
            
            if ( trial_progress_id == progress_id )
            {
                progress = progressdata.progress_values[ index ].progress;
                break;
            }
        }
        
        println( "<dev string:xc4>" + self.name + "<dev string:xfe>" + achievementid + "<dev string:x108>" + progress );
        
        if ( progress >= trialtimelimit )
        {
            kick( self getentitynumber(), &"exe/playerkicked", 1 );
        }
    }
}

// Namespace common
// Params 11
// Checksum 0x8442fde3, Offset: 0x2710
// Size: 0xe3
function onplayerkilledcommon( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid, iskillstreakweapon )
{
    if ( game_utility_mp::function_57a25addb5327c1a() )
    {
        updatealiveomnvars();
    }
    
    if ( isdefined( level.onplayerkilled ) )
    {
        [[ level.onplayerkilled ]]( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    }
    
    if ( isdefined( level.var_3d7553a7983b5a4e ) )
    {
        [[ level.var_3d7553a7983b5a4e ]]( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    }
    
    if ( function_3f447a2206625db7() )
    {
        if ( isbot( self ) )
        {
            self.classcallback = "gamemode";
        }
    }
}

// Namespace common
// Params 0
// Checksum 0xe6a6848e, Offset: 0x27fb
// Size: 0x131
function onplayerconnectcommon()
{
    while ( true )
    {
        level waittill( #"connected", player );
        
        if ( isdefined( level.onplayerconnect ) )
        {
            level thread [[ level.onplayerconnect ]]( player );
        }
        
        if ( level.droparmorondeath )
        {
            player.var_d5e836adfb09a0ef = [];
        }
        
        if ( game_utility::function_a43ada404e8c591f() )
        {
            player thread function_a55b10615603537e();
        }
        
        if ( utility::function_2a082dafe6f4bd5b() && !common_inventory::function_5c64d2b24a8c3e18() )
        {
            player thread nvghintnotify();
        }
        
        if ( function_3f447a2206625db7() )
        {
            level.denyclasschoice = 1;
            player class::function_e84a99f0f4904c66();
            player.pers[ "gamemodeLoadout" ] = game[ "forceRandomLoadout" ][ game[ "forceRandomLoadoutIndex" ] ];
        }
        
        if ( level.usepingsystem )
        {
            player calloutmarkerping::initplayer();
        }
        
        if ( isdefined( player ) && utility::level_supports_ai() )
        {
            level thread initplayeraisettings( player );
        }
        
        if ( !player isplayerpremium() )
        {
            if ( getdvarint( @"hash_7b6a932574c43db8", 0 ) != 0 )
            {
                println( "<dev string:x114>" + self.name );
                player function_490196f3e51aca75();
            }
        }
    }
}

// Namespace common
// Params 1
// Checksum 0x151841ae, Offset: 0x2934
// Size: 0x7e
function initplayeraisettings( player )
{
    player endon( #"disconnect" );
    
    if ( !isdefined( level.difficultytype ) )
    {
        level ai_mp_controller::function_71bf1a00b0b8d267();
    }
    
    player.gameskill = mp_gameskill::get_gameskill();
    player mp_gameskill::set_difficulty_from_locked_settings();
    player.owner = undefined;
    utility::flag_wait( "level_stealth_initialized" );
    
    while ( !isdefined( player.team ) )
    {
        waitframe();
    }
    
    player player::main();
}

// Namespace common
// Params 1
// Checksum 0x55fc4bcb, Offset: 0x29ba
// Size: 0x3a
function onplayerdisconnectcommon( player )
{
    if ( game_utility_mp::function_57a25addb5327c1a() )
    {
        player updatealiveomnvars();
    }
    
    if ( isdefined( level.onplayerdisconnect ) )
    {
        player thread [[ level.onplayerdisconnect ]]( player );
    }
}

// Namespace common
// Params 1
// Checksum 0x4aaf94ae, Offset: 0x29fc
// Size: 0x4c
function onplayerjointeamcommon( player )
{
    if ( isdefined( level.onplayerjointeam ) )
    {
        [[ level.onplayerjointeam ]]( self );
    }
    
    if ( obj_dogtag::dogtagsenabled() )
    {
        obj_dogtag::onplayerjoinedteam( player );
    }
    
    if ( utility::function_2a082dafe6f4bd5b() )
    {
        player thread nvghintnotify( 1 );
    }
}

// Namespace common
// Params 1
// Checksum 0x6adb8fc1, Offset: 0x2a50
// Size: 0x86
function managespawnprotection( usetimer )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_bfad9621a40b949" );
    thread function_70cc9e5cbce9150d();
    
    if ( !level.allowprematchdamage )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    if ( usetimer )
    {
        if ( level.var_a0fa6b3f11de99b2 )
        {
            self setclientomnvar( "ui_player_spawn_protection_time", level.spawnprotectiontimer );
        }
        
        wait level.spawnprotectiontimer;
    }
    
    function_6b65663570bf5d41();
}

// Namespace common
// Params 0
// Checksum 0x80f07e77, Offset: 0x2ade
// Size: 0x37
function function_de294efa1b7f245()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_d9461c8b3a52ccb0" );
    wait level.var_44d02731194e3f49;
    game_utility_mp::function_18eeb0e3becb75c2();
}

// Namespace common
// Params 0
// Checksum 0xa0fd53cd, Offset: 0x2b1d
// Size: 0xa7
function function_70cc9e5cbce9150d()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_bfad9621a40b949" );
    self waittill( #"spawned_player" );
    self.spawnprotection = 1;
    
    if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.var_ea952db43b9178cb ) )
    {
        if ( level.gametypebundle.var_ea952db43b9178cb > 0 )
        {
            lightarmor::setlightarmorvalue( self, level.gametypebundle.var_ea952db43b9178cb, undefined, 0 );
        }
        
        return;
    }
    
    lightarmor::setlightarmorvalue( self, 1000, undefined, 0 );
}

// Namespace common
// Params 0
// Checksum 0xa6fb1c6c, Offset: 0x2bcc
// Size: 0x7f
function function_6b65663570bf5d41()
{
    if ( isdefined( self ) )
    {
        self.spawnprotection = 0;
    }
    
    if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.var_ea952db43b9178cb ) )
    {
        if ( level.gametypebundle.var_ea952db43b9178cb > 0 )
        {
            lightarmor::lightarmor_unset( self );
        }
    }
    else
    {
        lightarmor::lightarmor_unset( self );
    }
    
    if ( level.var_a0fa6b3f11de99b2 )
    {
        self setclientomnvar( "ui_player_spawn_protection_time", 0 );
    }
    
    game_utility_mp::function_153de18b888f365d();
}

// Namespace common
// Params 0
// Checksum 0x69ee2c75, Offset: 0x2c53
// Size: 0x22f
function updatealiveomnvars()
{
    if ( isdefined( level.updatealiveomnvars ) )
    {
        self [[ level.updatealiveomnvars ]]();
        return;
    }
    
    if ( level.var_42bd3318e5a83e )
    {
        setomnvar( "ui_allies_alive", teams::function_d301e967593ece1b( "allies" ) );
        setomnvar( "ui_axis_alive", teams::function_d301e967593ece1b( "axis" ) );
    }
    else
    {
        setomnvar( "ui_allies_alive", teams::getteamdata( "allies", "aliveCount" ) );
        setomnvar( "ui_axis_alive", teams::getteamdata( "axis", "aliveCount" ) );
    }
    
    setomnvar( "ui_allies_team_size", teams::getteamcount( "allies" ) );
    setomnvar( "ui_axis_team_size", teams::getteamcount( "axis" ) );
    
    foreach ( player in level.players )
    {
        if ( !team_utility::isgameplayteam( player.team ) || game[ "eliminated" ][ player.team ] )
        {
            continue;
        }
        
        if ( level.var_42bd3318e5a83e )
        {
            player setclientomnvar( "ui_friendly_alive", teams::function_d301e967593ece1b( player.team ) );
        }
        else
        {
            player setclientomnvar( "ui_friendly_alive", teams::getteamdata( player.team, "aliveCount" ) );
        }
        
        player setclientomnvar( "ui_friendly_team_size", teams::getteamcount( player.team ) );
        enemyteam = team_utility::getotherteam( player.team );
        
        if ( isdefined( enemyteam ) )
        {
            if ( level.var_42bd3318e5a83e )
            {
                player setclientomnvar( "ui_enemy_alive", teams::function_d301e967593ece1b( enemyteam ) );
            }
            else
            {
                player setclientomnvar( "ui_enemy_alive", teams::getteamdata( enemyteam, "aliveCount" ) );
            }
            
            player setclientomnvar( "ui_enemy_team_size", teams::getteamcount( enemyteam ) );
        }
    }
}

// Namespace common
// Params 0
// Checksum 0x4e59e075, Offset: 0x2e8a
// Size: 0x1e
function updatematchstatushintonspawncommon()
{
    level endon( #"game_ended" );
    hud_message::function_ef4318a0090caa0f( #"kill" );
}

// Namespace common
// Params 0
// Checksum 0xf05b3c96, Offset: 0x2eb0
// Size: 0x1a
function ffmessageonspawn()
{
    wait 1;
    
    if ( isdefined( self ) )
    {
        hud_message::showerrormessage( %"mp/friendly_fire_will_not" );
    }
}

// Namespace common
// Params 0
// Checksum 0xae9c69f5, Offset: 0x2ed2
// Size: 0x158
function addspecialistdialog()
{
    game[ "dialog" ][ "specialty_warhead" ] = "perk_amped";
    game[ "dialog" ][ "specialty_tac_resist" ] = "perk_amped";
    game[ "dialog" ][ "specialty_covert_ops" ] = "perk_coldblooded";
    game[ "dialog" ][ "specialty_hustle" ] = "perk_doubletime";
    game[ "dialog" ][ "specialty_eod" ] = "perk_eod";
    game[ "dialog" ][ "specialty_guerrilla" ] = "perk_ghost";
    game[ "dialog" ][ "specialty_surveillance" ] = "perk_highalert";
    game[ "dialog" ][ "specialty_heavy_metal" ] = "perk_killchain";
    game[ "dialog" ][ "specialty_munitions_2" ] = "perk_overkill";
    game[ "dialog" ][ "specialty_strategist" ] = "perk_pointman";
    game[ "dialog" ][ "specialty_quick_fix" ] = "perk_quickfix";
    game[ "dialog" ][ "specialty_restock" ] = "perk_restock";
    game[ "dialog" ][ "specialty_scavenger" ] = "perk_scavenger";
    game[ "dialog" ][ "specialty_extra_shrapnel" ] = "perk_shrapnel";
    game[ "dialog" ][ "specialty_specialist_bonus" ] = "perk_specialistbonus";
    game[ "dialog" ][ "specialty_tactical_recon" ] = "perk_spotter";
    game[ "dialog" ][ "specialty_huntmaster" ] = "perk_tracker";
    game[ "dialog" ][ "specialty_tune_up" ] = "perk_tuneup";
}

// Namespace common
// Params 0
// Checksum 0xa58598d5, Offset: 0x3032
// Size: 0x1d
function function_d5f384ddea865da()
{
    if ( getdvarint( @"scr_game_buymode", 0 ) == 1 )
    {
        function_70079b4ecbf59c30();
    }
}

// Namespace common
// Params 0
// Checksum 0xe16f2545, Offset: 0x3057
// Size: 0xcb
function function_70079b4ecbf59c30()
{
    function_e936c77b199b8ba();
    setomnvar( "ui_buy_mode", 1 );
    level.var_a43ada404e8c591f = 1;
    level.var_e62c96df590e2664 = &function_e62c96df590e2664;
    level.noinventory = 1;
    level.br_plunder_enabled = 1;
    level.var_99e6db424e4b2f5c = 1;
    level.armoronweaponswitchlongpress = 1;
    setdvar( @"hash_ed6e4ffa933af621", 1 );
    setdvar( @"scr_game_allow_loot", 1 );
    setdvar( @"bg_piggybackarmoronnvg", 1 );
    common_kiosk::setbuystation( "core" );
    
    if ( level.var_99e6db424e4b2f5c )
    {
        level.var_cc4ceaea968640d2 = &points::function_cc4ceaea968640d2;
    }
    
    level thread function_9af446de81948b90();
    level thread function_52e4ef15ac84744a();
    
    /#
        level thread function_2f48aabdaff9b0d9();
    #/
}

// Namespace common
// Params 0
// Checksum 0x37633b7b, Offset: 0x312a
// Size: 0x9c
function function_9af446de81948b90()
{
    waitframe();
    
    if ( utility::issharedfuncdefined( #"hash_d2bd141a0077e2dc", #"hash_a15f6baadf2003f7" ) )
    {
        level ui::lui_registercallback( "buy_menu_open", utility::getsharedfunc( #"hash_d2bd141a0077e2dc", #"hash_a15f6baadf2003f7" ) );
    }
    else
    {
        level ui::lui_registercallback( "buy_menu_open", &common_kiosk::armorykioskused );
    }
    
    level ui::lui_registercallback( "buy_menu_close", &function_ec3e89e4306b2291 );
    utility::callsharedfunc( #"hash_d2bd141a0077e2dc", #"init" );
    level.var_b9ea12c4f2229c53 = 1;
    level.var_87a21a3e41dc2e5d = &function_87a21a3e41dc2e5d;
}

// Namespace common
// Params 1, eflags: 0x4
// Checksum 0xba7677b4, Offset: 0x31ce
// Size: 0x18
function private function_ec3e89e4306b2291( value )
{
    self notify( #"buy_menu_close" );
}

// Namespace common
// Params 0
// Checksum 0x79121683, Offset: 0x31ee
// Size: 0x21d
function function_e936c77b199b8ba()
{
    var_4e16d2c6e256253f = [];
    var_4e16d2c6e256253f[ var_4e16d2c6e256253f.size ] = getent( "cyber_empzone_axis", #targetname );
    var_4e16d2c6e256253f[ var_4e16d2c6e256253f.size ] = getent( "cyber_empzone_allies", #targetname );
    cyberemptriggers = getentarray( "cyber_emp_pickup_trig", #targetname );
    
    foreach ( trig in cyberemptriggers )
    {
        var_4e16d2c6e256253f[ var_4e16d2c6e256253f.size ] = trig;
    }
    
    if ( var_4e16d2c6e256253f.size == 0 )
    {
        primaryflags = getentarray( "flag_primary", #targetname );
        
        foreach ( flag in primaryflags )
        {
            var_4e16d2c6e256253f[ var_4e16d2c6e256253f.size ] = flag;
            break;
        }
    }
    
    var_972719b73a1d4d39 = [];
    
    foreach ( temp in var_4e16d2c6e256253f )
    {
        newtemp = spawnstruct();
        newtemp.origin = temp.origin;
        newtemp.angles = temp.angles;
        var_972719b73a1d4d39[ var_972719b73a1d4d39.size ] = newtemp;
    }
    
    level thread function_908505eaeb9dc980( var_972719b73a1d4d39 );
}

// Namespace common
// Params 1
// Checksum 0x8a333357, Offset: 0x3413
// Size: 0x1d8
function function_908505eaeb9dc980( buystationslocs )
{
    waitframe();
    level.buystations = [];
    radiantstations = utility::getstructarray( "buystation_loc", "targetname" );
    
    foreach ( loc in radiantstations )
    {
        radiantstations[ radiantstations.size ] = radiantstations;
    }
    
    if ( radiantstations.size > 0 )
    {
        buystationslocs = radiantstations;
    }
    
    tracecontents = trace::create_default_contents( 1 );
    
    foreach ( loc in buystationslocs )
    {
        if ( radiantstations.size == 0 )
        {
            groundorigin = utility::drop_to_ground( loc.origin + anglestoforward( loc.angles ) * 50, 50, -200, undefined, tracecontents );
            spawnangles = loc.angles;
        }
        else
        {
            groundorigin = loc.origin;
            spawnangles = loc.angles;
        }
        
        buystation = spawnscriptable( "br_plunder_box", groundorigin, spawnangles );
        buystation setscriptablepartstate( "br_plunder_box", "visible" );
        buystation.var_8eeb10a67fe3cf31 = 0;
        level.buystations[ level.buystations.size ] = buystation;
    }
}

// Namespace common
// Params 0
// Checksum 0x239a4671, Offset: 0x35f3
// Size: 0x2a
function function_52e4ef15ac84744a()
{
    level.var_f3b7334ff88e938a = &cranked::function_f3b7334ff88e938a;
    waitframe();
    
    if ( level.crankedbombtimer == 0 )
    {
        level.crankedbombtimer = 30;
    }
}

// Namespace common
// Params 1
// Checksum 0x3a5ae6, Offset: 0x3625
// Size: 0x62
function function_f3af9dea2e124c68( squadindex )
{
    player = self;
    player.br_squadindex = squadindex;
    newextrainfo = player.game_extrainfo & 65528;
    newextrainfo |= squadindex;
    player.game_extrainfo = newextrainfo;
    player setclientomnvar( "ui_client_squad_index", 1 );
}

// Namespace common
// Params 2
// Checksum 0xa2278b7c, Offset: 0x368f
// Size: 0x75
function function_87a21a3e41dc2e5d( instance, player )
{
    if ( isint( instance ) )
    {
        instance = player;
        instance.var_8eeb10a67fe3cf31 = 0;
        instance.objectivekey = "_a";
    }
    
    if ( instance.var_8eeb10a67fe3cf31 || level.var_b9ea12c4f2229c53 )
    {
        player setclientomnvar( "ui_buystation_override", common_kiosk::function_9d041619b6fccf18( "core" ) );
    }
}

// Namespace common
// Params 1
// Checksum 0x6ad95ce9, Offset: 0x370c
// Size: 0xd0
function function_e62c96df590e2664( itemref )
{
    switch ( itemref )
    {
        case #"hash_25789111b74943b4":
        case #"hash_a825dc92f843028d":
            self.pers[ "armor_buy_plates" ]++;
            break;
        case #"hash_a7a7446a3194cb49":
            if ( player::isreallyalive( self ) )
            {
                if ( isdefined( self.armorhealth ) && self.armorhealth < self.maxarmorhealth )
                {
                    armor::setarmorhealth( int( clamp( self.armorhealth + level.var_1bfbe247e8d32b1b, 0, self.maxarmorhealth ) ) );
                }
            }
            else
            {
                self.pers[ "armor_buy_plates_instant" ]++;
                thread armor::function_dafd2aecc00237e1();
            }
        default:
            break;
    }
}

// Namespace common
// Params 0
// Checksum 0x694b7350, Offset: 0x37e4
// Size: 0x48
function function_a55b10615603537e()
{
    cash::function_3909082084ad6974();
    function_f3af9dea2e124c68( 1 );
    
    if ( !isdefined( self.pers[ "armor_buy_plates" ] ) )
    {
        self.pers[ "armor_buy_plates" ] = 0;
        self.pers[ "armor_buy_plates_instant" ] = 0;
    }
}

/#

    // Namespace common
    // Params 0
    // Checksum 0xa3714711, Offset: 0x3834
    // Size: 0xcb, Type: dev
    function function_2f48aabdaff9b0d9()
    {
        setdevdvarifuninitialized( @"hash_1ede0bb893291602", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_1ede0bb893291602", 0 ) > 0 )
            {
                foreach ( player in level.players )
                {
                    player br_plunder::playerplunderpickup( getdvarint( @"hash_1ede0bb893291602", 0 ), undefined, 1 );
                }
            }
            
            setdevdvar( @"hash_1ede0bb893291602", 0 );
            wait 1;
        }
    }

#/

// Namespace common
// Params 0
// Checksum 0xabcdb1d9, Offset: 0x3907
// Size: 0x41
function function_524560d2d6c87449()
{
    level.var_79e4b952dd2abbde = getdvarint( @"hash_4e33f79a5437aa5c", 0 ) > 0 ? getdvarint( @"hash_4e33f79a5437aa5c", 0 ) : undefined;
    
    if ( function_3f447a2206625db7() )
    {
        level thread function_9864b0bed1bdf18e();
    }
}

// Namespace common
// Params 0
// Checksum 0xd2239cd0, Offset: 0x3950
// Size: 0xd, Type: bool
function function_3f447a2206625db7()
{
    return level.var_79e4b952dd2abbde > 0;
}

// Namespace common
// Params 0
// Checksum 0xd937e41e, Offset: 0x3966
// Size: 0x2a
function function_9864b0bed1bdf18e()
{
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    level.bots_gametype_handles_class_choice = 1;
    waitframe();
    thread function_5353b46bb47de924();
    function_2103fa16528f67b();
}

// Namespace common
// Params 0
// Checksum 0xb17518e4, Offset: 0x3998
// Size: 0x108
function function_5353b46bb47de924()
{
    /#
        if ( getdvarint( @"hash_b665ceb14dabc0ed", -1 ) != -1 )
        {
            function_4b8af7a90ae2e1a4();
            game[ "<dev string:x14f>" ] = 0;
            return;
        }
    #/
    
    if ( !isdefined( game[ "roundsPlayed" ] ) )
    {
        game[ "roundsPlayed" ] = 0;
    }
    
    if ( game[ "roundsPlayed" ] == 0 )
    {
        if ( game[ "practiceRound" ] )
        {
            function_4b8af7a90ae2e1a4();
            game[ "forceRandomLoadoutIndex" ] = 0;
        }
        else if ( !isdefined( game[ "practiceRound" ] ) || game[ "didSnowFight" ] )
        {
            if ( game[ "didSnowFight" ] )
            {
                game[ "didSnowFight" ] = undefined;
            }
            
            function_4b8af7a90ae2e1a4();
            game[ "forceRandomLoadoutIndex" ] = 0;
        }
        
        return;
    }
    
    level.loadoutchangeround = level.var_79e4b952dd2abbde;
    
    if ( level.loadoutchangeround != 0 )
    {
        if ( game[ "roundsPlayed" ] % level.loadoutchangeround == 0 )
        {
            game[ "forceRandomLoadoutIndex" ]++;
        }
        
        if ( game[ "forceRandomLoadoutIndex" ] == game[ "forceRandomLoadout" ].size )
        {
            game[ "forceRandomLoadoutIndex" ] = 0;
        }
        
        return;
    }
    
    game[ "forceRandomLoadoutIndex" ] = 0;
}

// Namespace common
// Params 0
// Checksum 0x1f95ac6a, Offset: 0x3aa8
// Size: 0x224
function function_4b8af7a90ae2e1a4()
{
    game[ "forceRandomLoadout" ] = [];
    loadouts = [];
    classidx = 0;
    table = level.classtablename;
    
    /#
        if ( getdvarint( @"hash_b665ceb14dabc0ed", -1 ) != -1 )
        {
            classidx = getdvarint( @"hash_b665ceb14dabc0ed", 0 );
            loadouts[ loadouts.size ] = function_932f7e47934b1174( table, classidx );
            game[ "<dev string:x167>" ] = arrayrandomize( loadouts );
            return;
        }
    #/
    
    numloadouts = class::function_868832c7872f848e( table );
    
    while ( classidx < numloadouts )
    {
        loadouts[ loadouts.size ] = function_932f7e47934b1174( table, classidx );
        classidx++;
    }
    
    overrideweapons = undefined;
    overridechance = undefined;
    var_abd656464f5efefe = getdvar( @"hash_76bc70aac09a0054", "" );
    var_8e84d718b6d13f26 = getdvarfloat( @"hash_680f5c2690e8d15f", 0 );
    
    if ( var_abd656464f5efefe != "" && var_8e84d718b6d13f26 > 0 )
    {
        weapontokens = strtok( var_abd656464f5efefe, "," );
        
        foreach ( variantkey in weapontokens )
        {
            var_88d9d54f4dd56018 = strtok( variantkey, "|" );
            
            if ( var_88d9d54f4dd56018.size == 2 )
            {
                rootweapon = var_88d9d54f4dd56018[ 0 ];
                variantid = int( var_88d9d54f4dd56018[ 1 ] );
                
                if ( !isdefined( overrideweapons ) )
                {
                    overrideweapons = [];
                    overridechance = var_8e84d718b6d13f26;
                }
                
                struct = spawnstruct();
                struct.rootweapon = rootweapon;
                struct.variantid = variantid;
                overrideweapons[ overrideweapons.size ] = struct;
            }
        }
    }
    
    loadouts = function_f37b6fad814f9058( loadouts, 99, overrideweapons, overridechance );
    game[ "forceRandomLoadout" ] = arrayrandomize( loadouts );
}

// Namespace common
// Params 2
// Checksum 0xe88a8b9d, Offset: 0x3cd4
// Size: 0x250
function function_932f7e47934b1174( table, classindex )
{
    loadoutarray = [];
    loadoutarray[ "loadoutArchetype" ] = "archetype_assault";
    loadoutarray[ "loadoutPrimary" ] = class::table_getweapon( table, classindex, 0 );
    wildcard = class::function_6e209ed6e2db2b0b( table, classindex );
    maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        attachstring = class::getattachmentloadoutstring( attachmentindex, #"primary" );
        loadoutarray[ attachstring ] = class::table_getweaponattachment( table, classindex, 0, attachmentindex );
    }
    
    loadoutarray[ "loadoutPrimaryCamo" ] = class::table_getweaponcamo( table, classindex, 0 );
    loadoutarray[ "loadoutPrimaryReticle" ] = class::table_getweaponreticle( table, classindex, 0 );
    loadoutarray[ "loadoutPrimaryVariantID" ] = 0;
    loadoutarray[ "loadoutSecondary" ] = class::table_getweapon( table, classindex, 1 );
    maxsecondaryattachments = weapon::getmaxsecondaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments ; attachmentindex++ )
    {
        attachstring = class::getattachmentloadoutstring( attachmentindex, #"secondary" );
        loadoutarray[ attachstring ] = class::table_getweaponattachment( table, classindex, 1, attachmentindex );
    }
    
    if ( level.specialdayloadouts )
    {
        loadoutarray[ "loadoutSecondaryCamo" ] = class::table_getweaponcamo( table, classindex, 1 );
    }
    else
    {
        loadoutarray[ "loadoutSecondaryCamo" ] = class::table_getweaponcamo( table, classindex, 1 );
    }
    
    loadoutarray[ "loadoutSecondaryReticle" ] = class::table_getweaponreticle( table, classindex, 1 );
    loadoutarray[ "loadoutSecondaryVariantID" ] = 0;
    loadoutarray[ "loadoutEquipmentPrimary" ] = class::table_getequipmentprimary( table, classindex );
    loadoutarray[ "loadoutExtraEquipmentPrimary" ] = class::table_getextraequipmentprimary( table, classindex );
    loadoutarray[ "loadoutEquipmentSecondary" ] = class::table_getequipmentsecondary( table, classindex );
    loadoutarray[ "loadoutExtraEquipmentSecondary" ] = class::table_getextraequipmentsecondary( table, classindex );
    loadoutarray[ "loadoutPerks" ] = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        perk = class::table_getperk( table, classindex, i );
        
        if ( perk != "specialty_null" )
        {
            loadoutarray[ "loadoutPerks" ][ loadoutarray[ "loadoutPerks" ].size ] = perk;
        }
    }
    
    loadoutarray[ "loadoutGesture" ] = "playerData";
    loadoutarray[ "loadoutExecution" ] = "playerData";
    loadoutarray[ "loadoutFieldUpgrade1" ] = "none";
    loadoutarray[ "loadoutFieldUpgrade2" ] = "none";
    return loadoutarray;
}

// Namespace common
// Params 4
// Checksum 0x91eba8bc, Offset: 0x3f2d
// Size: 0x196
function function_f37b6fad814f9058( loadouts, count, overrideweapons, overridechance )
{
    selectedloadouts = [];
    
    for ( num = 0; num < count && loadouts.size > 0 ; num++ )
    {
        loadout = loadouts[ randomint( loadouts.size ) ];
        var_3be37e68ae048b5b = loadout[ "loadoutPrimary" ];
        
        if ( isdefined( overrideweapons ) && isdefined( overridechance ) )
        {
            var_e4b416b35ec36826 = function_254f9e5c75e78c93( var_3be37e68ae048b5b );
            filteredweapons = function_dbecdb6e0ebd862c( overrideweapons, var_e4b416b35ec36826 );
            
            if ( filteredweapons.size > 0 )
            {
                if ( randomfloat( 1 ) < overridechance )
                {
                    idxrandom = randomint( filteredweapons.size );
                    var_5a0a6c15389a7cd3 = filteredweapons[ idxrandom ];
                    overrideweapons[ idxrandom ] = undefined;
                    
                    if ( isint( idxrandom ) )
                    {
                        function_cdc669dbc8ea2101( overrideweapons );
                    }
                    
                    loadout[ "loadoutPrimary" ] = var_5a0a6c15389a7cd3.rootweapon;
                    loadout[ "loadoutPrimaryVariantID" ] = var_5a0a6c15389a7cd3.variantid;
                    loadout[ "loadoutPrimaryCamo" ] = "none";
                    loadout[ "loadoutPrimaryReticle" ] = "none";
                    maxprimaryattachments = weapon::function_45ab75ece154ca8f();
                    
                    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
                    {
                        attachstring = class::getattachmentloadoutstring( attachmentindex, #"primary" );
                        loadout[ attachstring ] = "none";
                    }
                }
            }
        }
        
        selectedloadouts[ selectedloadouts.size ] = loadout;
        loadouts = function_345dd5b0ea2aeeb0( loadouts, var_3be37e68ae048b5b );
    }
    
    return selectedloadouts;
}

// Namespace common
// Params 2
// Checksum 0x80045bd8, Offset: 0x40cc
// Size: 0xa9
function function_dbecdb6e0ebd862c( var_e7b7522bf560dc88, var_e4b416b35ec36826 )
{
    filtered = [];
    
    foreach ( struct in var_e7b7522bf560dc88 )
    {
        if ( function_254f9e5c75e78c93( struct.rootweapon ) == var_e4b416b35ec36826 )
        {
            filtered[ filtered.size ] = struct;
        }
    }
    
    return filtered;
}

// Namespace common
// Params 2
// Checksum 0x6a83327b, Offset: 0x417e
// Size: 0xc2
function function_345dd5b0ea2aeeb0( loadouts, var_3be37e68ae048b5b )
{
    filtered = [];
    group = function_254f9e5c75e78c93( var_3be37e68ae048b5b );
    
    foreach ( loadout in loadouts )
    {
        currgroup = function_254f9e5c75e78c93( loadout[ "loadoutPrimary" ] );
        
        if ( group != currgroup )
        {
            filtered[ filtered.size ] = loadout;
        }
    }
    
    return filtered;
}

// Namespace common
// Params 1
// Checksum 0x6070b495, Offset: 0x4249
// Size: 0x46
function function_254f9e5c75e78c93( rootweapon )
{
    group = "none";
    
    if ( rootweapon != "none" )
    {
        group = weapon::getweapongroup( rootweapon );
        
        if ( group == "weapon_dmr" )
        {
            group = "weapon_sniper";
        }
    }
    
    return group;
}

// Namespace common
// Params 0
// Checksum 0x5c4bf53d, Offset: 0x4298
// Size: 0x13
function updatehighpriorityweapons()
{
    self loadweaponsforplayer( level.loadweapons, 1 );
}

// Namespace common
// Params 0
// Checksum 0xf4874b38, Offset: 0x42b3
// Size: 0x163
function function_2103fa16528f67b()
{
    level.loadweapons = [];
    primaries = [];
    secondaries = [];
    loadout = game[ "forceRandomLoadout" ][ game[ "forceRandomLoadoutIndex" ] ];
    primary = loadout[ "loadoutPrimary" ];
    secondary = loadout[ "loadoutSecondary" ];
    
    if ( primary != "none" )
    {
        primaries[ primaries.size ] = function_53bd4868c58c3b1b( primary, loadout, 1 );
    }
    
    if ( secondary != "none" )
    {
        secondaries[ secondaries.size ] = function_f2e755912ed66b77( secondary, loadout, 1 );
    }
    
    if ( !isdefined( level.loadoutchangeround ) )
    {
        level.loadoutchangeround = 1;
    }
    
    if ( level.loadoutchangeround != 0 )
    {
        nextloadoutindex = game[ "forceRandomLoadoutIndex" ] + 1;
        
        if ( game[ "forceRandomLoadoutIndex" ] == game[ "forceRandomLoadout" ].size - 1 )
        {
            nextloadoutindex = 0;
        }
        
        nextloadout = game[ "forceRandomLoadout" ][ nextloadoutindex ];
        nextprimary = nextloadout[ "loadoutPrimary" ];
        nextsecondary = nextloadout[ "loadoutSecondary" ];
        
        if ( nextprimary != "none" )
        {
            primaries[ primaries.size ] = function_53bd4868c58c3b1b( nextprimary, nextloadout );
        }
        
        if ( nextsecondary != "none" )
        {
            secondaries[ secondaries.size ] = function_f2e755912ed66b77( nextsecondary, nextloadout );
        }
    }
    
    level.loadweapons = arraycombine( primaries, secondaries );
}

// Namespace common
// Params 3
// Checksum 0xaf430b45, Offset: 0x441e
// Size: 0x10f
function function_53bd4868c58c3b1b( primary, loadout, currentloadout )
{
    allattachments = [];
    
    for ( i = 1; i < 6 ; i++ )
    {
        concat = i;
        
        if ( i == 1 )
        {
            concat = "";
        }
        
        attachment = loadout[ "loadoutPrimaryAttachment" + concat ];
        
        if ( attachment != "none" )
        {
            allattachments[ allattachments.size ] = attachment;
        }
    }
    
    rootname = weapon::getweaponrootname( primary );
    camoname = "camo_none";
    reticleindex = "none";
    variantid = undefined;
    attachmentids = undefined;
    cosmeticattachment = undefined;
    stickers = undefined;
    newweaponobject = weapon::buildweapon( rootname, allattachments, camoname, reticleindex, variantid, attachmentids, cosmeticattachment, stickers );
    newweapon = getcompleteweaponname( newweaponobject );
    return newweapon;
}

// Namespace common
// Params 3
// Checksum 0xbea4452a, Offset: 0x4536
// Size: 0xde
function function_f2e755912ed66b77( secondary, loadout, currentloadout )
{
    allattachments = [];
    
    for ( i = 1; i < 6 ; i++ )
    {
        concat = i;
        
        if ( i == 1 )
        {
            concat = "";
        }
        
        attachment = loadout[ "loadoutSecondaryAttachment" + concat ];
        
        if ( attachment != "none" )
        {
            allattachments[ allattachments.size ] = attachment;
        }
    }
    
    camoname = "camo_none";
    reticleindex = "none";
    rootname = weapon::getweaponrootname( secondary );
    newweaponobject = weapon::buildweapon( rootname, allattachments, camoname, reticleindex );
    newweapon = getcompleteweaponname( newweaponobject );
    return newweapon;
}

// Namespace common
// Params 0
// Checksum 0xae524a4f, Offset: 0x461d
// Size: 0x7d
function function_f22100b70b7be286()
{
    if ( getdvarint( @"scr_game_aiagentsinmp", 0 ) == 1 )
    {
        level.var_26957a14f92507d = 1;
        
        if ( getdvarint( @"scr_game_aispawnondeath", 0 ) == 1 )
        {
            level.var_6dec3d2bdd75f49a = &function_6dec3d2bdd75f49a;
            level.var_9a456b714194b2d9 = &function_9a456b714194b2d9;
        }
        
        level thread function_6d4e3ca451f8ba4c();
        utility::flag_init( "stealth_enabled" );
        utility::flag_init( "level_stealth_initialized" );
        utility::flag_init( "stealth_spotted" );
    }
}

// Namespace common
// Params 0
// Checksum 0x4206d6d4, Offset: 0x46a2
// Size: 0xfb
function function_6d4e3ca451f8ba4c()
{
    level.var_d95835502ec96520 = getdvarint( @"hash_742ec92f3f5c3b41", 12 );
    ai_mp_controller::init();
    
    if ( !isdefined( level.difficultytype ) )
    {
        level ai_mp_controller::function_71bf1a00b0b8d267();
    }
    
    utility::registersharedfunc( #"ai", #"droplootonagentdeath", &droplootonagentdeath );
    
    while ( !isdefined( level.teamnamelist ) )
    {
        waitframe();
    }
    
    foreach ( team in level.teamnamelist )
    {
        budgetname = team + "_agents";
        ai_mp_controller::aibudget_registercategory( budgetname, level.var_d95835502ec96520 );
    }
}

// Namespace common
// Params 2
// Checksum 0xedd7b7f7, Offset: 0x47a5
// Size: 0x26c
function function_6dec3d2bdd75f49a( victim, attacker )
{
    if ( victim.deaths % 5 == 0 )
    {
        victim.var_1fdcb9688c71dba3 = 1;
    }
    
    budgetname = victim.team + "_agents";
    totalspawned = ai_mp_controller::function_62448bd2c6f12ae9( budgetname );
    var_7a6d859df4c2ee8 = level.var_d95835502ec96520 - totalspawned;
    
    if ( var_7a6d859df4c2ee8 <= 0 )
    {
        return;
    }
    
    goalpos = undefined;
    spawnpoint = victim [[ level.getspawnpoint ]]();
    team = victim.team;
    wait 0.15;
    
    if ( isdefined( spawnpoint ) )
    {
        if ( isdefined( attacker ) )
        {
            goalpos = attacker.origin;
        }
        else
        {
            goalpos = spawnpoint.origin;
        }
        
        if ( victim.var_1fdcb9688c71dba3 )
        {
            var_b6933894644e835a = getdvarint( @"hash_4ec508aa0002244", 1 );
            
            if ( var_b6933894644e835a > 0 )
            {
                for ( i = 0; i < var_b6933894644e835a ; i++ )
                {
                    agent = ai_mp_controller::ai_mp_requestspawnagent( "enemy_mp_jugg_base", spawnpoint.origin, spawnpoint.angles, "absolute", budgetname, "jugg", budgetname, team );
                    
                    if ( isdefined( agent ) )
                    {
                        agent thread function_7c3197fc1ba5824( agent, team );
                        agent thread ai_behavior::function_ec43a817c7bf1915( agent, goalpos );
                        agent.doavoidanceblocking = 0;
                    }
                }
            }
            
            victim.var_1fdcb9688c71dba3 = undefined;
            return;
        }
        
        numagents = getdvarint( @"hash_65d94ddfef09716a", 1 );
        
        if ( numagents > 0 )
        {
            for ( i = 0; i < numagents ; i++ )
            {
                aitype = ai_mp_controller::function_b86341658788836c();
                agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnpoint.origin, spawnpoint.angles, "absolute", budgetname, "jugg", budgetname, team );
                
                if ( isdefined( agent ) )
                {
                    agent thread function_7c3197fc1ba5824( agent, team );
                    agent thread ai_behavior::function_ec43a817c7bf1915( agent, goalpos );
                    
                    if ( team == "allies" )
                    {
                        agent agent_utils::overrideagentsettings( "body_mp_eastern_geist_1_1_lod1", "head_mp_eastern_bale_1_1" );
                    }
                    else
                    {
                        agent agent_utils::overrideagentsettings( "body_spetsnaz_cqc", "head_spetsnaz_cqc" );
                    }
                    
                    agent.doavoidanceblocking = 0;
                }
            }
        }
    }
}

// Namespace common
// Params 2
// Checksum 0xee0f189a, Offset: 0x4a19
// Size: 0x33
function function_7c3197fc1ba5824( agent, team )
{
    waitframe();
    agent.gameskill = mp_gameskill::get_gameskill();
    agent mp_gameskill::apply_difficulty_settings( 1 );
}

// Namespace common
// Params 1
// Checksum 0xc398f728, Offset: 0x4a54
// Size: 0xbe
function function_421fc72cf14974bf( agent )
{
    if ( agent.team == "axis" )
    {
        body = "body_spetsnaz_cqc";
        head = "head_spetsnaz_cqc";
    }
    else
    {
        body = "body_mp_eastern_geist_1_1_lod1";
        head = "head_mp_eastern_bale_1_1";
    }
    
    weapon = undefined;
    grenade_type = agent_utils::function_c7ac99e13a55d70e();
    grenadeammo = getdvarint( @"hash_ce85f7cc40b562f5", 0 );
    armor = 0;
    agent agent_utils::overrideagentsettings( body, head, weapon, grenade_type, grenadeammo, armor );
    agent.baseaccuracy = getdvarfloat( @"hash_949a1d9903e71c7a", 0.4 );
}

// Namespace common
// Params 1
// Checksum 0xf7fc2fa7, Offset: 0x4b1a
// Size: 0x35
function droplootonagentdeath( params )
{
    self [[ level.weapondropfunction ]]( params.eattacker, self.damagemod ?? "MOD_RIFLE_BULLET" );
}

// Namespace common
// Params 2
// Checksum 0xb2eb8da5, Offset: 0x4b57
// Size: 0x95
function function_9a456b714194b2d9( attacker, victim )
{
    score = level.scoremod[ "kill" ];
    
    if ( isdefined( level.var_1fccdf402d0756ac ) )
    {
        score = attacker [[ level.var_1fccdf402d0756ac ]]( score, victim );
    }
    
    if ( score != 0 )
    {
        if ( level.teambased )
        {
            level gamescore::giveteamscoreforobjective( attacker.pers[ "team" ], score, 0 );
            return;
        }
        
        attacker gamescore::giveplayerscore( #"kill", score, victim );
    }
}

// Namespace common
// Params 0
// Checksum 0x42b4e31e, Offset: 0x4bf4
// Size: 0x15d
function function_2da9f3f04a883d1c()
{
    arenasoccer = undefined;
    
    if ( game_utility::getgametype() == "arena" )
    {
        objmodifier = 0;
        
        if ( isusingmatchrulesdata() )
        {
            objmodifier = getmatchrulesdata( "arenaData", "objModifier" );
        }
        else
        {
            objmodifier = dvars::dvarintvalue( "objModifier", 0, 0, 3 );
        }
        
        if ( objmodifier == 3 )
        {
            arenasoccer = 1;
        }
    }
    
    level.var_2728e64d27108af0 = 0;
    matchmakingmatch = getdvarint( @"onlinegame" ) && !getdvarint( @"xblive_privatematch" );
    
    if ( matchmakingmatch )
    {
        level.var_2728e64d27108af0 = getdvarint( @"hash_750e151e9a3727e7", 0 );
    }
    
    /#
        level.var_2728e64d27108af0 = getdvarint( @"hash_750e151e9a3727e7", 0 );
    #/
    
    if ( level.var_2728e64d27108af0 || arenasoccer )
    {
        function_961d6071d55ca4a7();
        level.setupsoccerball = &setupsoccerball;
        level thread [[ level.setupsoccerball ]]();
        level thread entity::global_physics_sound_monitor();
        
        if ( getdvarint( @"hash_c8724ebc0f08ec3e", 1 ) == 1 )
        {
            setupdialog();
            level function_f0e08ac5ba194f6a();
            
            if ( getdvarint( @"hash_71c708ca0182656b", 3 ) > 0 )
            {
                if ( !isdefined( game[ "multiBall" ] ) )
                {
                    game[ "multiBall" ] = 0;
                }
            }
        }
        
        return;
    }
    
    level.var_2728e64d27108af0 = undefined;
}

// Namespace common
// Params 0
// Checksum 0x22cd01d3, Offset: 0x4d59
// Size: 0x24e
function setupsoccerball()
{
    level.soccerballs = [];
    spawnpositions = [];
    spawnpos = undefined;
    
    if ( game_utility::getgametype() == "arena" )
    {
        arenaflag = getentarray( "flag_arena", #targetname );
        spawnpos = arenaflag[ 0 ].origin + ( 0, 0, 30 );
    }
    else
    {
        spawnpositions = [];
        primaryflags = getentarray( "flag_primary", #targetname );
        
        foreach ( flag in primaryflags )
        {
            if ( flag.script_label == "_b" )
            {
                spawnpositions[ spawnpositions.size ] = flag.origin;
                break;
            }
        }
        
        if ( spawnpositions.size == 0 )
        {
            println( "<dev string:x17a>" );
            return;
        }
        
        spawnpositions = arrayrandomize( spawnpositions );
        spawnpos = spawnpositions[ 0 ];
        
        if ( getdvar( @"ui_mapname" ) == "mp_firingrange" )
        {
            spawnpos = ( -194, -858, 90 );
        }
    }
    
    var_e1f1c908fc04594b = [];
    cyberemptriggers = getentarray( "cyber_emp_pickup_trig", #targetname );
    
    foreach ( trig in cyberemptriggers )
    {
        var_e1f1c908fc04594b[ var_e1f1c908fc04594b.size ] = trig.origin;
    }
    
    level.var_e1f1c908fc04594b = var_e1f1c908fc04594b;
    
    if ( getdvarint( @"hash_23e676668434d769", 0 ) == 1 && var_e1f1c908fc04594b.size > 0 )
    {
        spawnpositions = arraycombine( spawnpositions, var_e1f1c908fc04594b );
        spawnpositions = arrayrandomize( spawnpositions );
        spawnpos = spawnpositions[ 0 ];
    }
    
    level thread createball( spawnpos, 1 );
}

// Namespace common
// Params 2
// Checksum 0x4959d0c0, Offset: 0x4faf
// Size: 0x246
function createball( spawnpos, waittime )
{
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    tracestart = spawnpos + ( 0, 0, 64 );
    traceend = spawnpos + ( 0, 0, -64 );
    trace = trace::ray_trace( tracestart, traceend, undefined, trace::create_default_contents( 1 ) );
    spawnpos = trace[ "position" ] + ( 0, 0, 30 );
    soccerball = spawnstruct();
    soccerball.angles = ( 0, 0, 0 );
    soccerball.visuals = spawn( "script_model", spawnpos );
    soccerball.visuals setmodel( "art_stadium_ball" );
    soccerball.visuals dontinterpolate();
    soccerball.resetposition = spawnpos;
    soccerball.issoccerball = 1;
    soccerball.onreset = &onsoccerballreset;
    soccerball.var_15ebc92e4e11237a = &function_15ebc92e4e11237a;
    soccerball.var_fefca4aa4772092e = &function_38d10cb9c07b6817;
    angles = ( 0, 30, 0 );
    up = anglestoup( angles );
    
    if ( getdvar( @"ui_mapname" ) == "mp_m_stadium" )
    {
        force = up * 500 + ( 0, 0, 80 );
    }
    else
    {
        force = up * 50 + ( 0, 0, 80 );
    }
    
    waittillframeend();
    flags::gameflagwait( "prematch_done" );
    soccerball.visuals physicslaunchserver( soccerball.visuals.origin, force );
    soccerball thread outofboundswatcher();
    soccerball thread function_c72558bd6ffe9943();
    
    if ( getdvarint( @"hash_c8724ebc0f08ec3e", 1 ) == 1 )
    {
        soccerball thread function_f2e1a8a2458b8545();
    }
    
    if ( isdefined( soccerball.var_fefca4aa4772092e ) )
    {
        soccerball [[ soccerball.var_fefca4aa4772092e ]]();
    }
    
    level.soccerballs[ level.soccerballs.size ] = soccerball;
}

// Namespace common
// Params 0
// Checksum 0x76417b61, Offset: 0x51fd
// Size: 0x35
function function_38d10cb9c07b6817()
{
    self.visuals thread entity::register_physics_collisions();
    self.visuals physics_registerforcollisioncallback();
    entity::register_physics_collision_func( self.visuals, &ball_impact_sounds );
}

// Namespace common
// Params 9
// Checksum 0xbd7dabb3, Offset: 0x523a
// Size: 0x151
function ball_impact_sounds( var_38d10cea9da84c59, body0, body1, flag0, flag1, position, normal, impulse, collided_ent )
{
    bodyid = var_38d10cea9da84c59 physics_getbodyid( 0 );
    vel = physics_getbodylinvel( bodyid );
    bounceforce = length( vel );
    
    if ( isdefined( var_38d10cea9da84c59.playing_sound ) || bounceforce < 70 )
    {
        return;
    }
    
    var_38d10cea9da84c59 endon( #"death" );
    var_38d10cea9da84c59.playing_sound = 1;
    surface = physics_getsurfacetypefromflags( flag1 );
    surfacetype = getsubstr( surface[ "name" ], 9 );
    
    if ( surfacetype == "user_terrain1" )
    {
        var_38d10cea9da84c59 playsound( "soc_ball_bounce_small" );
    }
    else if ( bounceforce < 180 )
    {
        var_38d10cea9da84c59 playsurfacesound( "soc_ball_bounce_small", surfacetype );
    }
    else if ( bounceforce < 260 )
    {
        var_38d10cea9da84c59 playsurfacesound( "soc_ball_bounce_med", surfacetype );
    }
    else
    {
        var_38d10cea9da84c59 playsurfacesound( "soc_ball_bounce_large", surfacetype );
    }
    
    /#
    #/
    
    wait 0.1;
    var_38d10cea9da84c59.playing_sound = undefined;
}

// Namespace common
// Params 1
// Checksum 0xa8e3bbcd, Offset: 0x5393
// Size: 0x181
function onsoccerballreset( var_5497eb02d8a085fc )
{
    self.ignorereset = 1;
    
    if ( !var_5497eb02d8a085fc )
    {
        wait 0.5;
        self.visuals playsound( "soc_ball_vanish" );
        playfx( level.soccer_fx[ "vanish" ], self.visuals.origin );
    }
    else
    {
        wait 0.1;
        playfx( level.soccer_fx[ "vanish" ], self.visuals.origin );
    }
    
    self.visuals hide();
    wait 1;
    self.visuals.origin = self.resetposition;
    angles = ( 0, 30, 0 );
    up = anglestoup( angles );
    
    if ( level.mapname == "mp_m_stadium" )
    {
        force = up * 500 + ( 0, 0, 80 );
    }
    else
    {
        force = up * 50 + ( 0, 0, 80 );
    }
    
    self.visuals show();
    self.visuals physicslaunchserver( self.visuals.origin, force );
    self.ignorereset = 0;
    
    if ( isdefined( self.var_fefca4aa4772092e ) )
    {
        self [[ self.var_fefca4aa4772092e ]]();
    }
}

// Namespace common
// Params 1
// Checksum 0x297458ca, Offset: 0x551c
// Size: 0x545
function function_15ebc92e4e11237a( goal )
{
    if ( self.ignorereset )
    {
        self.ignorereset = 0;
        return;
    }
    
    if ( game[ "switchedsides" ] )
    {
        goalteam = team_utility::getotherteam( goal.team );
        
        if ( goalteam == "allies" )
        {
            game[ "axisGoals" ]++;
            exploderid = "goal_1";
        }
        else
        {
            game[ "alliesGoals" ]++;
            exploderid = "goal_2";
        }
    }
    else
    {
        goalteam = goal.team;
        
        if ( goalteam == "allies" )
        {
            game[ "alliesGoals" ]++;
            exploderid = "goal_2";
        }
        else
        {
            game[ "axisGoals" ]++;
            exploderid = "goal_1";
        }
    }
    
    if ( isdefined( exploderid ) )
    {
        utility::exploder( exploderid );
    }
    
    var_4cd7b2e28fa46bc8 = "tv_goal";
    
    if ( isdefined( var_4cd7b2e28fa46bc8 ) )
    {
        utility::exploder( var_4cd7b2e28fa46bc8 );
    }
    
    goal.goalsscored++;
    level function_6b90e9c1860056a7( goal );
    goal thread function_61cae75973c3d9f7();
    
    if ( game_utility::getgametype() == "arena" )
    {
        foreach ( player in level.players )
        {
            if ( player.team == goalteam )
            {
                if ( player.team == "allies" )
                {
                    player thread function_d5ca2a498ef2d21f( "dx_mpa_rutl_" + "summer_game_goal" + utility::array_random( level.goaldialog ), "summer_game_goal", 2, "soccer_goal_them" );
                }
                else
                {
                    player thread function_d5ca2a498ef2d21f( "dx_mpa_uktl_" + "summer_game_goal" + utility::array_random( level.goaldialog ), "summer_game_goal", 2, "soccer_goal_them" );
                }
                
                continue;
            }
            
            if ( player.team == "allies" )
            {
                player thread function_d5ca2a498ef2d21f( "dx_mpa_uktl_" + "summer_game_goal" + utility::array_random( level.goaldialog ), "summer_game_goal", 2, "soccer_goal_us" );
                continue;
            }
            
            player thread function_d5ca2a498ef2d21f( "dx_mpa_rutl_" + "summer_game_goal" + utility::array_random( level.goaldialog ), "summer_game_goal", 2, "soccer_goal_us" );
        }
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( player.team == "allies" )
            {
                player thread function_d5ca2a498ef2d21f( "dx_mpa_uktl_" + "summer_game_goal" + utility::array_random( level.goaldialog ), "summer_game_goal", 2, "soccer_goal_us" );
                continue;
            }
            
            player thread function_d5ca2a498ef2d21f( "dx_mpa_rutl_" + "summer_game_goal" + utility::array_random( level.goaldialog ), "summer_game_goal", 2, "soccer_goal_us" );
        }
    }
    
    self.visuals thread function_a3c04224dfa3b11e();
    attacheditems = self.visuals getlinkedchildren();
    
    foreach ( item in attacheditems )
    {
        if ( isdefined( item ) )
        {
            item unlink( 1 );
        }
    }
    
    if ( isdefined( self.onreset ) )
    {
        self thread [[ self.onreset ]]( 1 );
    }
    
    if ( goal.goalsscored >= 10 && isdefined( game[ "multiBall" ] ) && !game[ "multiBall" ] || getdvarint( @"hash_9fc6cedb80cfd5f7", 0 ) == 1 && isdefined( game[ "multiBall" ] ) && !game[ "multiBall" ] )
    {
        game[ "multiBall" ] = 1;
        
        foreach ( player in level.players )
        {
            player thread hud_message::showsplash( "soccer_multiball" );
        }
        
        if ( level.var_e1f1c908fc04594b.size > 0 )
        {
            multiballs = getdvarint( @"hash_71c708ca0182656b", 3 );
            
            for ( i = 0; i < multiballs ; i++ )
            {
                createball( level.var_e1f1c908fc04594b[ i ] );
            }
        }
    }
}

// Namespace common
// Params 0
// Checksum 0x2fda216e, Offset: 0x5a69
// Size: 0x1e
function function_a3c04224dfa3b11e()
{
    self playsound( "soc_ball_explode" );
    wait 1.5;
    self playsound( "soc_ball_goal_music" );
}

// Namespace common
// Params 2
// Checksum 0xd87f0330, Offset: 0x5a8f
// Size: 0x193
function function_61cae75973c3d9f7( playsfx, waittime )
{
    for ( i = 0; i < min( self.goalsscored, 10 ) ; i++ )
    {
        playfx( level.gos_fx[ "gos_fireworks" ], self.trigger.origin + ( randomintrange( -100, 100 ), randomintrange( -100, 100 ), randomintrange( -25, 60 ) ), anglestoforward( self.trigger.angles + ( randomintrange( int( max( clamp( 0 - i * 5, -19, 0 ), -20 ) ), int( min( 20, 1 + i * 5 ) ) ), randomintrange( int( max( clamp( 0 - i * 5, -19, 0 ), -20 ) ), int( min( 20, 1 + i * 5 ) ) ), 0 ) ), anglestoup( self.trigger.angles + ( randomintrange( int( max( clamp( 0 - i * 5, -19, 0 ), -20 ) ), int( min( 20, 1 + i * 5 ) ) ), randomintrange( int( max( clamp( 0 - i * 5, -19, 0 ), -20 ) ), int( min( 20, 1 + i * 5 ) ) ), 0 ) ) );
        
        if ( playsfx )
        {
            level thread function_fe04807712ae0304( self.trigger.origin );
        }
        
        if ( isdefined( waittime ) )
        {
            wait waittime;
        }
    }
}

// Namespace common
// Params 1
// Checksum 0x408f73c1, Offset: 0x5c2a
// Size: 0xee
function function_6b90e9c1860056a7( goal )
{
    foreach ( struct in level.var_424bf26b245fe39f )
    {
        if ( struct.scoreteam == goal.team )
        {
            if ( goal.goalsscored >= 10 )
            {
                struct.scriptable setscriptablepartstate( "score", "10" );
                continue;
            }
            
            struct.scriptable setscriptablepartstate( "score", "0" + string( goal.goalsscored ) );
        }
    }
}

// Namespace common
// Params 0
// Checksum 0x9e71164c, Offset: 0x5d20
// Size: 0x304
function outofboundswatcher()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( self.ignorereset )
        {
            continue;
        }
        
        if ( isdefined( self.resetnow ) )
        {
            self.resetnow = undefined;
            
            if ( isdefined( self.onreset ) )
            {
                self thread [[ self.onreset ]]();
            }
            
            continue;
        }
        
        for ( index = 0; index < level.radtriggers.size ; index++ )
        {
            if ( !self.visuals istouching( level.radtriggers[ index ] ) )
            {
                continue;
            }
            
            if ( isdefined( self.onreset ) )
            {
                self thread [[ self.onreset ]]();
            }
        }
        
        for ( index = 0; index < level.minetriggers.size ; index++ )
        {
            if ( !self.visuals istouching( level.minetriggers[ index ] ) )
            {
                continue;
            }
            
            if ( isdefined( self.onreset ) )
            {
                self thread [[ self.onreset ]]();
            }
        }
        
        for ( index = 0; index < level.hurttriggers.size ; index++ )
        {
            if ( !self.visuals istouching( level.hurttriggers[ index ] ) )
            {
                continue;
            }
            
            if ( isdefined( self.onreset ) )
            {
                self thread [[ self.onreset ]]();
            }
        }
        
        if ( level.ballallowedtriggers.size )
        {
            self.allowedintrigger = 0;
            
            foreach ( trigger in level.ballallowedtriggers )
            {
                if ( self.visuals istouching( trigger ) )
                {
                    self.allowedintrigger = 1;
                    break;
                }
            }
        }
        
        if ( isdefined( level.outofboundstriggers ) )
        {
            foreach ( trigger in level.outofboundstriggers )
            {
                if ( self.allowedintrigger )
                {
                    break;
                }
                
                if ( !self.visuals istouching( trigger ) )
                {
                    continue;
                }
                
                if ( isdefined( self.onreset ) )
                {
                    self thread [[ self.onreset ]]();
                }
            }
        }
        
        if ( isdefined( self.autoresettime ) )
        {
            wait self.autoresettime;
            
            if ( !isdefined( self.carrier ) )
            {
                if ( isdefined( self.onreset ) )
                {
                    self thread [[ self.onreset ]]();
                }
            }
        }
    }
}

// Namespace common
// Params 0
// Checksum 0x9f1cc4bd, Offset: 0x602c
// Size: 0x6e
function function_c72558bd6ffe9943()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 0.25;
        
        if ( self.ignorereset )
        {
            continue;
        }
        
        if ( distancesquared( self.visuals.origin, self.resetposition ) > 9000000 )
        {
            if ( isdefined( self.onreset ) )
            {
                self thread [[ self.onreset ]]();
            }
        }
    }
}

// Namespace common
// Params 0
// Checksum 0x5bad604a, Offset: 0x60a2
// Size: 0x212
function function_f0e08ac5ba194f6a()
{
    var_321230be685c29c9 = getentarray( "allies_goal", #targetname );
    var_cb2adc8aa3f080fc = getentarray( "axis_goal", #targetname );
    
    if ( var_321230be685c29c9.size > 0 && var_cb2adc8aa3f080fc.size > 0 )
    {
        level.alliesgoal = spawnstruct();
        level.alliesgoal.team = "allies";
        level.alliesgoal.trigger = var_321230be685c29c9[ 0 ];
        level.alliesgoal.entsinside = [];
        level.axisgoal = spawnstruct();
        level.axisgoal.team = "axis";
        level.axisgoal.trigger = var_cb2adc8aa3f080fc[ 0 ];
        level.axisgoal.entsinside = [];
        level.axisgoal.goalsscored = 0;
        
        if ( !isdefined( game[ "roundsPlayed" ] ) || game[ "roundsPlayed" ] == 0 )
        {
            game[ "alliesGoals" ] = 0;
            level.alliesgoal.goalsscored = 0;
            game[ "axisGoals" ] = 0;
            level.axisgoal.goalsscored = 0;
        }
        else if ( game[ "switchedsides" ] )
        {
            level.axisgoal.goalsscored = game[ "alliesGoals" ];
            level.alliesgoal.goalsscored = game[ "axisGoals" ];
        }
        else
        {
            level.alliesgoal.goalsscored = game[ "alliesGoals" ];
            level.axisgoal.goalsscored = game[ "axisGoals" ];
        }
        
        level.var_1a6b72a9e46ae09b = [ level.axisgoal, level.alliesgoal ];
        level thread function_88f8227fae790bc3();
        return;
    }
    
    level notify( #"hash_c05341f5752a2de5" );
}

// Namespace common
// Params 0
// Checksum 0x16ccfe92, Offset: 0x62bc
// Size: 0x21c
function function_88f8227fae790bc3()
{
    wait 1;
    level.alliesscorestructs = utility::getstructarray( "home", "targetname" );
    level.axisscorestructs = utility::getstructarray( "away", "targetname" );
    level.var_424bf26b245fe39f = arraycombine( level.alliesscorestructs, level.axisscorestructs );
    
    foreach ( struct in level.alliesscorestructs )
    {
        struct.scriptable = spawn( "script_model", struct.origin );
        struct.scriptable.angles = struct.angles;
        struct.scriptable setmodel( "vfx_stadium_scoreboard_scriptable" );
        struct.scoreteam = "allies";
    }
    
    foreach ( struct in level.axisscorestructs )
    {
        struct.scriptable = spawn( "script_model", struct.origin );
        struct.scriptable.angles = struct.angles;
        struct.scriptable setmodel( "vfx_stadium_scoreboard_scriptable" );
        struct.scoreteam = "axis";
    }
    
    level function_6b90e9c1860056a7( level.alliesgoal );
    level function_6b90e9c1860056a7( level.axisgoal );
}

// Namespace common
// Params 1
// Checksum 0x706beb0b, Offset: 0x64e0
// Size: 0x13b
function function_f2e1a8a2458b8545( triggerstruct )
{
    level endon( #"game_ended" );
    level endon( #"hash_c05341f5752a2de5" );
    
    while ( !isdefined( level.var_1a6b72a9e46ae09b ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        wait 0.05;
        
        if ( self.ignorereset )
        {
            continue;
        }
        
        for ( index = 0; index < level.var_1a6b72a9e46ae09b.size ; index++ )
        {
            if ( !function_124c3e44da534dd1( level.var_1a6b72a9e46ae09b[ index ], self.visuals ) )
            {
                continue;
            }
            
            if ( !function_44c501177810d283( level.var_1a6b72a9e46ae09b[ index ], self.visuals ) )
            {
                continue;
            }
            
            entnum = self.visuals getentitynumber();
            level.var_1a6b72a9e46ae09b[ index ].entsinside[ entnum ] = self.visuals;
            self.visuals.var_d3c886011c5a6cef = level.var_1a6b72a9e46ae09b[ index ];
            
            if ( isdefined( self.var_15ebc92e4e11237a ) )
            {
                [[ self.var_15ebc92e4e11237a ]]( level.var_1a6b72a9e46ae09b[ index ] );
            }
        }
    }
}

// Namespace common
// Params 2
// Checksum 0x775fef8f, Offset: 0x6623
// Size: 0x3d, Type: bool
function function_44c501177810d283( triggerstruct, ent )
{
    entnum = ent getentitynumber();
    
    if ( isdefined( triggerstruct.entsinside[ entnum ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace common
// Params 2
// Checksum 0x1fe5fbaa, Offset: 0x6669
// Size: 0x6a, Type: bool
function function_124c3e44da534dd1( triggerstruct, ent )
{
    if ( !ent istouching( triggerstruct.trigger ) )
    {
        entnum = ent getentitynumber();
        triggerstruct.entsinside[ entnum ] = undefined;
        
        if ( ent.var_d3c886011c5a6cef == triggerstruct )
        {
            ent.var_d3c886011c5a6cef = undefined;
        }
        
        return false;
    }
    
    return true;
}

// Namespace common
// Params 1
// Checksum 0xb1b167fa, Offset: 0x66dc
// Size: 0x45
function function_fe04807712ae0304( origin )
{
    sound = "gos_firework_scream_sfx";
    playsoundatpos( origin, sound );
    wait 1.5;
    playsoundatpos( origin + ( 0, 0, 600 ), "gos_firework_explo_sfx" );
}

// Namespace common
// Params 0
// Checksum 0x4d60f403, Offset: 0x6729
// Size: 0x147
function function_961d6071d55ca4a7()
{
    level.gos_fx[ "gos_fireworks" ] = loadfxasset( "vfx_iw8_mp_gamemode_gos_firework" );
    level.soccer_fx[ "vanish" ] = loadfxasset( "vfx_iw8_mp_gamemode_soccer_ball_burst" );
    level.soccer_fx[ "score_00" ] = loadfxasset( "vfx_iw8_mp_level_stadium_stad_score_00" );
    level.soccer_fx[ "score_01" ] = loadfxasset( "vfx_iw8_mp_level_stadium_stad_score_01" );
    level.soccer_fx[ "score_02" ] = loadfxasset( "vfx_iw8_mp_level_stadium_stad_score_02" );
    level.soccer_fx[ "score_03" ] = loadfxasset( "vfx_iw8_mp_level_stadium_stad_score_03" );
    level.soccer_fx[ "score_04" ] = loadfxasset( "vfx_iw8_mp_level_stadium_stad_score_04" );
    level.soccer_fx[ "score_05" ] = loadfxasset( "vfx_iw8_mp_level_stadium_stad_score_05" );
    level.soccer_fx[ "score_06" ] = loadfxasset( "vfx_iw8_mp_level_stadium_stad_score_06" );
    level.soccer_fx[ "score_07" ] = loadfxasset( "vfx_iw8_mp_level_stadium_stad_score_07" );
    level.soccer_fx[ "score_08" ] = loadfxasset( "vfx_iw8_mp_level_stadium_stad_score_08" );
    level.soccer_fx[ "score_09" ] = loadfxasset( "vfx_iw8_mp_level_stadium_stad_score_09" );
    level.soccer_fx[ "score_10" ] = loadfxasset( "vfx_iw8_mp_level_stadium_stad_score_10" );
}

// Namespace common
// Params 0
// Checksum 0x49e23bc9, Offset: 0x6878
// Size: 0x60
function setupdialog()
{
    game[ "dialog" ][ "summer_game_goal_1" ] = "summer_game_goal_1";
    game[ "dialog" ][ "summer_game_goal_2" ] = "summer_game_goal_2";
    game[ "dialog" ][ "summer_game_goal_3" ] = "summer_game_goal_3";
    level.goaldialog = [ "_1", "_2", "_3" ];
}

// Namespace common
// Params 4
// Checksum 0x9f3f4955, Offset: 0x68e0
// Size: 0xbd
function function_d5ca2a498ef2d21f( dialog, dialogref, time, splash )
{
    self notify( #"hash_a7919ded9f29deb9" );
    self endon( #"hash_a7919ded9f29deb9" );
    
    if ( !isdefined( level.lastteamstatustime[ "allies" ][ dialogref ] ) )
    {
        level.lastteamstatustime[ "allies" ][ dialogref ] = 0;
    }
    
    if ( gettime() < level.lastteamstatustime[ "allies" ][ dialogref ] + time * 1000 )
    {
        return;
    }
    
    self queuedialogforplayer( #"queue1", dialog, dialogref, time );
    level.lastteamstatustime[ "allies" ][ dialogref ] = gettime();
    thread hud_message::showsplash( splash );
}

// Namespace common
// Params 0
// Checksum 0xae2f9a8f, Offset: 0x69a5
// Size: 0x59
function snowballfighthint()
{
    self endon( #"death" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        thread print::tutorialprint( "MP_INGAME_ONLY/PRACTICE_ROUND", 5 );
        wait 6;
        flags::gameflagwait( "prematch_done" );
        thread print::tutorialprint( "MP_INGAME_ONLY/SNOWBALL_FIGHT", 5 );
        return;
    }
    
    thread print::tutorialprint( "MP_INGAME_ONLY/SNOWBALL_FIGHT", 5 );
}

// Namespace common
// Params 0
// Checksum 0xc3e0394, Offset: 0x6a06
// Size: 0x3c
function function_f74f31d61b67577()
{
    level.var_5215d773a35158c2 = getdvarfloat( @"hash_a88f1329561bc6e1", getmatchrulesdata( "commonOption", "carePackageDropTime" ) );
    
    if ( level.var_5215d773a35158c2 > 0 )
    {
        level thread randomcarepackagedrops();
    }
}

// Namespace common
// Params 1
// Checksum 0x6648a522, Offset: 0x6a4a
// Size: 0xd9
function function_5417e8ba9ceb3b76( bundle )
{
    if ( isdefined( level.var_8a67923391725ffc ) || bundle.crateentries.size == 0 )
    {
        return;
    }
    
    level.var_8a67923391725ffc = [];
    
    foreach ( killstreak in bundle.crateentries )
    {
        if ( killstreak.weight > 0 )
        {
            level.var_8a67923391725ffc[ killstreak.name ] = killstreak.weight;
        }
    }
}

// Namespace common
// Params 0
// Checksum 0x48e7b7f8, Offset: 0x6b2b
// Size: 0x1b5
function randomcarepackagedrops()
{
    level endon( #"game_ended" );
    waitframe();
    flags::gameflagwait( "prematch_done" );
    wait level.var_5215d773a35158c2;
    worldbounds = getnavbounds();
    worldmidpoint = worldbounds.midpoint;
    var_41642016dd09f4ff = int( worldbounds.halfsize[ 0 ] );
    var_f2ab902bc98cc80 = int( worldbounds.halfsize[ 1 ] );
    
    if ( level.gametypebundle.var_cce99e640ee9e221 )
    {
        bundle = getscriptbundle( level.gametypebundle.var_cce99e640ee9e221 );
        
        if ( isdefined( bundle ) )
        {
            function_5417e8ba9ceb3b76( bundle );
        }
        else
        {
            assertmsg( "<dev string:x1a4>" );
        }
    }
    
    if ( !isdefined( bundle ) )
    {
        bundle = killstreak_utility::function_f943c0602acdc2af( "airdrop" );
    }
    
    cratetype = getdropzonecratetype( bundle );
    streakinfo = spawnstruct();
    streakinfo.bundle = bundle;
    
    while ( true )
    {
        waittime = 1;
        dropposition = worldmidpoint + ( randomintrange( -1 * var_41642016dd09f4ff, var_41642016dd09f4ff ), randomintrange( -1 * var_f2ab902bc98cc80, var_f2ab902bc98cc80 ), 0 );
        position = getclosestpointonnavmesh( dropposition );
        finalpos = airdrop::function_bd2eb7c465e874f7( position, 1 );
        
        if ( isdefined( finalpos[ 0 ] ) )
        {
            airdrop::function_5f514aed135bd60f( undefined, finalpos[ 0 ], ( randomfloat( 360 ), 0, 0 ), streakinfo, cratetype, 0 );
            waittime = level.var_5215d773a35158c2;
            cratetype = getdropzonecratetype( bundle );
        }
        
        hostmigration::waitlongdurationwithhostmigrationpause( waittime );
    }
}

// Namespace common
// Params 1
// Checksum 0xf70915ea, Offset: 0x6ce8
// Size: 0x111
function getdropzonecratetype( bundle )
{
    cratetype = undefined;
    
    if ( level.var_8a67923391725ffc )
    {
        cratetype = airdrop::getrandomkeyfromweightsarray( level.var_8a67923391725ffc );
    }
    else if ( bundle.crateentries )
    {
        cratetype = airdrop::getrandomkillstreak();
    }
    else
    {
        if ( !isdefined( level.grnd_previouscratetypes ) )
        {
            level.grnd_previouscratetypes = [];
        }
        
        if ( !isdefined( level.grnd_previouscratetypes[ "mega" ] ) && randomintrange( 0, 100 ) < 5 )
        {
            cratetype = "mega";
        }
        else
        {
            if ( level.grnd_previouscratetypes.size )
            {
                for ( maxtries = 20; maxtries ; maxtries-- )
                {
                    cratetype = airdrop::getrandomkillstreak();
                    
                    if ( isdefined( level.grnd_previouscratetypes[ cratetype ] ) )
                    {
                        cratetype = undefined;
                        continue;
                    }
                    
                    break;
                }
            }
            
            if ( !isdefined( cratetype ) )
            {
                cratetype = airdrop::getrandomkillstreak();
            }
            
            level.grnd_previouscratetypes[ cratetype ] = 1;
            
            if ( level.grnd_previouscratetypes.size == 15 )
            {
                level.grnd_previouscratetypes = [];
            }
        }
    }
    
    return cratetype;
}

// Namespace common
// Params 0
// Checksum 0x3d1e43b, Offset: 0x6e02
// Size: 0xd, Type: bool
function function_70adce42ed4205fe()
{
    return level.var_5215d773a35158c2 > 0;
}

// Namespace common
// Params 0
// Checksum 0x4a0b178f, Offset: 0x6e18
// Size: 0x27f
function function_7f8bc379edf2db1f()
{
    level.tier1modeenabled = getmatchrulesdata( "commonOption", "tier1ModeEnabled" );
    level.var_f766d7ff069f4c4e = getdvarint( @"hash_509b01d1370107af", 0 ) == 1;
    level.var_7b3d16bfb6e6f111 = getdvarint( @"hash_e05a6970966d8552", 0 );
    level.var_43bc9a09bb599294 = getdvarint( @"hash_4a592b7d1efa862d", 0 );
    level.var_c6310d9d8e28e0c4 = getdvarint( @"hash_4c748c9425636394", 0 );
    level.testrandomrealismclients = getdvarint( @"hash_596700a25033a832", 0 ) == 1;
    setomnvar( "ui_realism_mode", game_utility::function_d3f8957534dc62af() );
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        if ( !isbrgamemode() )
        {
            level.modifyplayerdamage = &damage::gamemodemodifyplayerdamage;
        }
        
        setdvar( @"jump_slowdownenable", 1 );
        setdvar( @"sprintleap_enabled", 0 );
        
        if ( !spawnselection::function_fc43ecf617088f49() )
        {
            level.disablespawncamera = 1;
        }
        
        if ( level.var_c6310d9d8e28e0c4 )
        {
            level.var_838828a17c03692f = [];
            level.var_838828a17c03692f[ "rocketlauncher" ] = getdvarfloat( @"hash_2b6ceef99f7c775", 0.75 );
            level.var_838828a17c03692f[ "sniper" ] = getdvarfloat( @"hash_2b2aaef99f38272", 0.8 );
            level.var_838828a17c03692f[ "mg" ] = getdvarfloat( @"hash_263c3ef999d0b4f", 0.85 );
            level.var_838828a17c03692f[ "rifle" ] = getdvarfloat( @"hash_274c6ef99af1c44", 0.9 );
            level.var_838828a17c03692f[ "smg" ] = getdvarfloat( @"hash_2b2a9ef99f3803f", 0.95 );
            level.var_838828a17c03692f[ "spread" ] = getdvarfloat( @"hash_2b2b3ef99f3963d", 0.95 );
            level.var_838828a17c03692f[ "grenade" ] = getdvarfloat( @"hash_27db6ef99b917c2", 1 );
            level.var_838828a17c03692f[ "melee" ] = getdvarfloat( @"hash_263c5ef999d0fb5", 1 );
            level.var_838828a17c03692f[ "pistol" ] = getdvarfloat( @"hash_2bfa5ef9a018bf8", 1 );
        }
        
        /#
            setdevdvarifuninitialized( @"hash_74cf84c8f4c62dd0", 0 );
            setdevdvarifuninitialized( @"hash_1a0e0937636134eb", 0 );
        #/
        
        connect_event_aggregator::registeronconnectcallback( &function_27b0e6ee0f2c450f );
        callback::add( #"player_spawned", &function_27b0e6ee0f2c450f );
    }
}

// Namespace common
// Params 1
// Checksum 0x1e4bde28, Offset: 0x709f
// Size: 0x74
function function_27b0e6ee0f2c450f( params )
{
    if ( level.testrandomrealismclients )
    {
        if ( !isdefined( self.isrealismenabled ) )
        {
            if ( utility::cointoss() )
            {
                self setclientomnvar( "ui_realism_hud", 1 );
                self.isrealismenabled = 1;
            }
            else
            {
                self setclientomnvar( "ui_realism_hud", 0 );
                self.isrealismenabled = 0;
            }
        }
        
        return;
    }
    
    self setclientomnvar( "ui_realism_hud", game_utility::function_d3f8957534dc62af() );
}

// Namespace common
// Params 0
// Checksum 0x283aa854, Offset: 0x711b
// Size: 0x226
function spawnhealthpickup()
{
    droplocation = self.origin;
    startpos = droplocation + ( 0, 0, 14 );
    stance = self getstance();
    zoffset = 35;
    
    if ( stance == "prone" )
    {
        zoffset = 14;
    }
    
    if ( stance == "crouch" )
    {
        zoffset = 25;
    }
    
    movetostartpos = droplocation + ( 0, 0, zoffset );
    randomangle = ( 0, randomfloat( 360 ), 0 );
    randomdir = anglestoforward( randomangle );
    randomdst = randomfloatrange( 30, 150 );
    testpos = startpos + randomdst * randomdir;
    movetoendpos = playerphysicstrace( startpos, testpos );
    
    if ( !isdefined( self.healthpickup ) )
    {
        visuals = [];
        visuals[ 0 ] = spawn( "script_model", movetostartpos );
        visuals[ 0 ] setmodel( "noglow::lm_heal_first_aid_kit_vfx" );
        trigger = spawn( "trigger_radius", movetostartpos, 0, 32, 32 );
        trigger utility::trigger_off();
        pickup = gameobjects::createuseobject( "neutral", trigger, visuals, undefined, undefined, 1 );
        pickup.onuse = &healthpickup_onuse;
        pickup.usetime = 0;
        pickup gameobjects::allowuse( "any" );
        pickup.owner = self;
        self.healthpickup = pickup;
        self.healthpickup thread monitordisconnect();
    }
    else
    {
        self.healthpickup.curorigin = movetostartpos;
        self.healthpickup.visuals[ 0 ].origin = movetostartpos;
        self.healthpickup.trigger.origin = movetostartpos;
    }
    
    self.healthpickup thread function_91f66ef1b072f435( movetostartpos, movetoendpos );
    
    if ( level.var_43bc9a09bb599294 > 0 )
    {
        self.healthpickup thread monitortimeout();
    }
}

// Namespace common
// Params 2
// Checksum 0xff8a6550, Offset: 0x7349
// Size: 0xe4
function function_91f66ef1b072f435( startpos, endpos )
{
    self endon( #"death" );
    initialforce = ( endpos - startpos ) * 25;
    self.visuals[ 0 ] physicslaunchserver( self.visuals[ 0 ].origin, initialforce );
    wait 1;
    
    if ( isdefined( self.trigger ) && isdefined( self.visuals[ 0 ] ) )
    {
        self.trigger.origin = self.visuals[ 0 ].origin;
        self.curorigin = self.visuals[ 0 ].origin;
        self.visuals[ 0 ] physicsstopserver();
        self.trigger utility::trigger_on();
    }
}

// Namespace common
// Params 2
// Checksum 0x9aca4369, Offset: 0x7435
// Size: 0xdb
function healthpickup_onuse( player, team )
{
    if ( player.health <= 0 || player.health == player.maxhealth )
    {
        return;
    }
    
    if ( player killstreak::isjuggernaut() )
    {
        return;
    }
    
    player playsoundtoplayer( "fly_pickup_gen", player );
    player thread function_c46c2dfdcdf78636();
    
    if ( level.var_f766d7ff069f4c4e )
    {
        if ( level.var_7b3d16bfb6e6f111 == 0 )
        {
            player.health = player.maxhealth;
        }
        else
        {
            player.health = min( player.health + level.var_7b3d16bfb6e6f111, player.maxhealth );
        }
    }
    else
    {
        playerhealth::forcehealthregen( player );
    }
    
    function_eef881cc4e2bc410();
}

// Namespace common
// Params 0
// Checksum 0xdbf0839, Offset: 0x7518
// Size: 0x8e
function function_c46c2dfdcdf78636()
{
    self endon( #"death_or_disconnect" );
    superref = supers_mp::getcurrentsuperref();
    deadsilenceactive = supers_mp::issuperinuse() && isdefined( superref ) && superref == "super_deadsilence";
    
    if ( !deadsilenceactive )
    {
        self lerpfovbypreset( "zombiedefault" );
    }
    
    wait 0.5;
    superref = supers_mp::getcurrentsuperref();
    deadsilenceactive = supers_mp::issuperinuse() && isdefined( superref ) && superref == "super_deadsilence";
    
    if ( !deadsilenceactive )
    {
        self lerpfovbypreset( "default_2seconds" );
    }
}

// Namespace common
// Params 0
// Checksum 0x22f1e21, Offset: 0x75ae
// Size: 0x16
function monitordisconnect()
{
    self waittill( #"disconnect" );
    function_eef881cc4e2bc410();
}

// Namespace common
// Params 0
// Checksum 0x86f9cc1d, Offset: 0x75cc
// Size: 0x37
function monitortimeout()
{
    self endon( #"death" );
    self notify( #"hash_1cb4e2787d080934" );
    self endon( #"hash_1cb4e2787d080934" );
    wait level.var_43bc9a09bb599294;
    function_eef881cc4e2bc410();
}

// Namespace common
// Params 0
// Checksum 0xce214a4d, Offset: 0x760b
// Size: 0x39
function function_eef881cc4e2bc410()
{
    if ( isdefined( self.owner ) )
    {
        self.owner.healthpickup = undefined;
    }
    
    self.visuals[ 0 ] delete();
    gameobjects::deleteuseobject();
}

// Namespace common
// Params 0
// Checksum 0xbb7f4101, Offset: 0x764c
// Size: 0x2a
function function_fb24bb58f0e3974a()
{
    if ( !getmatchrulesdata( "commonOption", "possessionEnabled" ) )
    {
        return;
    }
    
    callback::add( #"player_death", &function_a95113897657837d );
}

// Namespace common
// Params 1
// Checksum 0x9a08a1b1, Offset: 0x767e
// Size: 0x61
function function_a95113897657837d( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    
    if ( isdefined( attacker.vehicle ) )
    {
        return;
    }
    else if ( attacker utility::isusingremote() )
    {
        return;
    }
    
    thread function_d34f0da52241b985( attacker, victim );
}

// Namespace common
// Params 4
// Checksum 0xb9a9f6fc, Offset: 0x76e7
// Size: 0x1f8
function function_d34f0da52241b985( attacker, victim, victimloadout, attackerloadout )
{
    level endon( #"game_ended" );
    attacker endon( #"death_or_disconnect" );
    victimloadout = function_4a18864dcc886aa2( victim );
    attackerloadout = function_4a18864dcc886aa2( attacker );
    attacker.pers[ "gamemodeLoadout" ] = victimloadout;
    victim.pers[ "gamemodeLoadout" ] = undefined;
    victimeye = victim geteye();
    attackereye = attacker geteye();
    var_2fddbefa9142aa9a = attacker getplayerangles();
    victimpos = victim.origin;
    victimang = vectortoangles( victimeye - attackereye );
    victim_model = self.operatorcustomization.skinref;
    var_42ce1f093fa261ec = attacker.streakpoints;
    tag = spawn( "script_model", attackereye );
    tag setmodel( "tag_origin" );
    tag.angles = var_2fddbefa9142aa9a;
    attacker cameralinkto( tag, "tag_origin", 1, 1 );
    attacker player_utility::function_dbe5a52a6654a982( 1 );
    val::set_array( "possession", [ "fire", "offhand_weapons", "allow_movement" ], 0 );
    lerptime = getdvarfloat( @"hash_b3133d200920a9ee", 0.3 );
    tag moveto( victimeye, lerptime );
    wait lerptime / 2;
    tag rotateto( victimang, lerptime / 2 );
    wait lerptime / 2;
    val::reset_all( "possession" );
    attacker setorigin( victimpos );
    attacker cameraunlink();
    attacker player_utility::function_b54a1e23734ef07( 1 );
    attacker class::giveloadout( attacker.team, "gamemode", undefined, 0, 0 );
}

// Namespace common
// Params 1
// Checksum 0x90c49f47, Offset: 0x78e7
// Size: 0x518
function function_4a18864dcc886aa2( player )
{
    classstruct = undefined;
    
    if ( isdefined( player.juggcontext.prevclassstruct ) )
    {
        classstruct = player.juggcontext.prevclassstruct;
    }
    else
    {
        classstruct = player.classstruct;
    }
    
    copystruct = [];
    copystruct[ "loadoutArchetype" ] = classstruct.loadoutarchetype;
    copystruct[ "loadoutPrimary" ] = classstruct.loadoutprimary;
    copystruct[ "loadoutPrimaryAttachments" ] = classstruct.loadoutprimaryattachments;
    copystruct[ "loadoutPrimaryAttachmentIDs" ] = classstruct.loadoutprimaryattachmentids;
    copystruct[ "loadoutPrimaryBlueprintAttachmentIgnoreList" ] = classstruct.loadoutPrimaryBlueprintAttachmentIgnoreList;
    copystruct[ "loadoutPrimaryCamo" ] = classstruct.loadoutprimarycamo;
    copystruct[ "loadoutPrimaryCosmeticAttachment" ] = classstruct.loadoutprimarycosmeticattachment;
    copystruct[ "loadoutPrimaryLootItemID" ] = classstruct.loadoutprimarylootitemid;
    copystruct[ "loadoutPrimaryReticle" ] = classstruct.loadoutprimaryreticle;
    copystruct[ "loadoutPrimaryStickers" ] = classstruct.loadoutprimaryweaponstickers;
    copystruct[ "loadoutPrimaryVariantID" ] = classstruct.loadoutprimaryvariantid;
    copystruct[ "loadoutSecondary" ] = classstruct.loadoutsecondary;
    copystruct[ "loadoutSecondaryAttachments" ] = classstruct.loadoutsecondaryattachments;
    copystruct[ "loadoutSecondaryAttachmentIDs" ] = classstruct.loadoutsecondaryattachmentids;
    copystruct[ "loadoutSecondaryBlueprintAttachmentIgnoreList" ] = classstruct.loadoutSecondaryBlueprintAttachmentIgnoreList;
    copystruct[ "loadoutSecondaryCamo" ] = classstruct.loadoutsecondarycamo;
    copystruct[ "loadoutSecondaryCosmeticAttachment" ] = classstruct.loadoutsecondarycosmeticattachment;
    copystruct[ "loadoutSecondaryLootItemID" ] = classstruct.loadoutsecondarylootitemid;
    copystruct[ "loadoutSecondaryReticle" ] = classstruct.loadoutsecondaryreticle;
    copystruct[ "loadoutSecondaryStickers" ] = classstruct.loadoutsecondarystickers;
    copystruct[ "loadoutSecondaryVariantID" ] = classstruct.loadoutsecondaryvariantid;
    
    if ( level.tertiaryweaponslotenabled )
    {
        copystruct[ "loadoutTertiary" ] = classstruct.loadouttertiary;
        copystruct[ "loadoutTertiaryAttachments" ] = classstruct.loadoutTertiaryAttachments;
        copystruct[ "loadoutTertiaryAttachmentIDs" ] = classstruct.loadoutTertiaryAttachmentIDs;
        copystruct[ "loadoutTertiaryBlueprintAttachmentIgnoreList" ] = classstruct.loadoutTertiaryBlueprintAttachmentIgnoreList;
        copystruct[ "loadoutTertiaryCamo" ] = classstruct.loadouttertiarycamo;
        copystruct[ "loadoutTertiaryReticle" ] = classstruct.loadouttertiaryreticle;
        copystruct[ "loadoutTertiaryLootItemID" ] = classstruct.loadoutTertiaryLootItemID;
        copystruct[ "loadoutTertiaryVariantID" ] = classstruct.loadouttertiaryvariantid;
        copystruct[ "loadoutTertiaryCosmeticAttachment" ] = classstruct.loadoutTertiaryCosmeticAttachment;
        copystruct[ "loadoutTertiaryStickers" ] = classstruct.loadoutTertiaryStickers;
    }
    
    copystruct[ "loadoutMeleeSlot" ] = classstruct.loadoutmeleeslot;
    copystruct[ "loadoutPerksFromGamemode" ] = classstruct.loadoutperksfromgamemode;
    copystruct[ "loadoutPerks" ] = classstruct.loadoutperks;
    copystruct[ "loadoutPerkStreaks" ] = classstruct.loadoutperkstreaks;
    copystruct[ "loadoutStandardPerks" ] = classstruct.loadoutstandardperks;
    copystruct[ "loadoutExtraPerks" ] = classstruct.loadoutextraperks;
    copystruct[ "loadoutRigTrait" ] = classstruct.loadoutrigtrait;
    copystruct[ "loadoutUsingSpecialist" ] = classstruct.loadoutusingspecialist;
    copystruct[ "loadoutEquipmentPrimary" ] = classstruct.loadoutequipmentprimary;
    copystruct[ "loadoutEquipmentPrimaryAttachments" ] = classstruct.loadoutEquipmentPrimaryAttachments;
    copystruct[ "loadoutExtraEquipmentPrimary" ] = classstruct.loadoutextraequipmentprimary;
    copystruct[ "loadoutEquipmentSecondary" ] = classstruct.loadoutequipmentsecondary;
    copystruct[ "loadoutEquipmentSecondaryAttachments" ] = classstruct.loadoutEquipmentSecondaryAttachments;
    copystruct[ "loadoutExtraEquipmentSecondary" ] = classstruct.loadoutextraequipmentsecondary;
    
    if ( level.var_613ba3e28ca2d235 )
    {
        copystruct[ "loadoutEquipmentTertiary" ] = classstruct.loadoutEquipmentTertiary;
        copystruct[ "loadoutEquipmentTertiaryAttachments" ] = classstruct.loadoutEquipmentTertiaryAttachments;
        copystruct[ "loadoutExtraEquipmentTertiary" ] = classstruct.loadoutExtraEquipmentTertiary;
    }
    
    copystruct[ "loadoutSuper" ] = classstruct.loadoutsuper;
    copystruct[ "loadoutGesture" ] = classstruct.loadoutgesture;
    copystruct[ "loadoutFieldUpgrade1" ] = classstruct.loadoutfieldupgrade1;
    copystruct[ "loadoutFieldUpgrade1Attachments" ] = classstruct.loadoutFieldUpgrade1Attachments;
    copystruct[ "loadoutFieldUpgrade2" ] = classstruct.loadoutfieldupgrade2;
    copystruct[ "loadoutFieldUpgrade2Attachments" ] = classstruct.loadoutFieldUpgrade2Attachments;
    copystruct[ "loadoutStreaksFilled" ] = classstruct.loadoutstreaksfilled;
    copystruct[ "loadoutStreakType" ] = classstruct.loadoutstreaktype;
    copystruct[ "loadoutKillstreak1" ] = classstruct.loadoutkillstreak1;
    copystruct[ "loadoutKillstreak2" ] = classstruct.loadoutkillstreak2;
    copystruct[ "loadoutKillstreak3" ] = classstruct.loadoutkillstreak3;
    copystruct[ "loadoutKillstreak1BlueprintIndex" ] = classstruct.loadoutKillstreak1BlueprintIndex;
    copystruct[ "loadoutKillstreak2BlueprintIndex" ] = classstruct.loadoutKillstreak2BlueprintIndex;
    copystruct[ "loadoutKillstreak3BlueprintIndex" ] = classstruct.loadoutKillstreak3BlueprintIndex;
    return copystruct;
}

// Namespace common
// Params 0
// Checksum 0x46440a42, Offset: 0x7e08
// Size: 0x19
function function_90073dd5a95d7789()
{
    level.casualModeEnabled = getmatchrulesdata( "commonOption", "casualModeEnabled" );
}

// Namespace common
// Params 0
// Checksum 0xc1b30cc1, Offset: 0x7e29
// Size: 0x19
function function_8ec16b91852dfeac()
{
    level.hardcoremodeenabled = getmatchrulesdata( "commonOption", "hardcoreModeEnabled" );
}

// Namespace common
// Params 0
// Checksum 0xc910996b, Offset: 0x7e4a
// Size: 0x19
function function_6e93daf9adbbe95b()
{
    level.isFaceOffMode = getmatchrulesdata( "commonOption", "isFaceOffMode" );
}

// Namespace common
// Params 2
// Checksum 0xba58fb22, Offset: 0x7e6b
// Size: 0x95
function killfeedevent( killfeeddata, victimid )
{
    struct = spawnstruct();
    struct.killfeeddata = killfeeddata;
    struct.victimid = victimid;
    
    if ( !isdefined( self.killfeedqueue ) )
    {
        self.killfeedqueue = utility::queue_create( 32 );
    }
    
    self.killfeedqueue = utility::queue_enqueue( self.killfeedqueue, struct );
    thread processkilleventfeed();
    
    if ( game_utility::getgametype() == "gwtdm" )
    {
        thread awardbonusaftertime();
    }
}

// Namespace common
// Params 0
// Checksum 0x8eef7425, Offset: 0x7f08
// Size: 0xc0
function processkilleventfeed()
{
    self endon( #"disconnect" );
    self notify( #"processkilleventfeed" );
    self endon( #"processkilleventfeed" );
    waittillframeend();
    
    while ( isdefined( self.killfeedqueue ) && self.killfeedqueue.array.size > 0 )
    {
        struct = utility::queue_peek( self.killfeedqueue );
        self.killfeedqueue = utility::queue_dequeue( self.killfeedqueue );
        self setclientomnvar( "ui_killfeed_victim_id", struct.victimid );
        self setclientomnvar( "ui_killfeed_data", struct.killfeeddata );
        self setclientomnvar( "ui_killfeed_notify", gettime() );
        waitframe();
    }
}

// Namespace common
// Params 0
// Checksum 0xfedc3441, Offset: 0x7fd0
// Size: 0x27f
function awardbonusaftertime()
{
    self endon( #"disconnect" );
    self notify( #"awardbonusaftertime" );
    self endon( #"awardbonusaftertime" );
    
    if ( !isdefined( self.killfeedbonus ) )
    {
        self.killfeedbonus = 0;
    }
    
    self.killfeedbonus++;
    bonuswindow = getdvarfloat( @"hash_a44760277d3fe8a5", 5 );
    wait bonuswindow;
    var_b953543d7e8d89ac = 0;
    
    if ( self.killfeedbonus > 15 )
    {
        var_b953543d7e8d89ac = 15;
    }
    else if ( self.killfeedbonus > 10 )
    {
        var_b953543d7e8d89ac = 10;
    }
    else if ( self.killfeedbonus > 7 )
    {
        var_b953543d7e8d89ac = 5;
    }
    else if ( self.killfeedbonus > 5 )
    {
        var_b953543d7e8d89ac = 3;
    }
    else if ( self.killfeedbonus > 3 )
    {
        var_b953543d7e8d89ac = 1;
    }
    
    self.killfeedbonus = 0;
    
    if ( var_b953543d7e8d89ac == 0 )
    {
        return;
    }
    
    gamescore::giveteamscoreforobjective( self.team, var_b953543d7e8d89ac, 0 );
    
    if ( getdvarint( @"hash_2e405e2912dc4a44", 0 ) == 1 )
    {
        thread rank::scoreeventpopup( hashcat( #"hash_2c8bcbb02ec7ff9b", var_b953543d7e8d89ac ) );
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "contribution" ] ) )
        {
            self.leaderboarddata[ "contribution" ] = self.leaderboarddata[ "contribution" ] + var_b953543d7e8d89ac;
        }
        
        if ( isdefined( level.leaderboardfunc[ "contribution" ] ) )
        {
            [[ level.leaderboardfunc[ "contribution" ] ]]( self, var_b953543d7e8d89ac );
        }
        
        assert( isint( var_b953543d7e8d89ac ) || isfloat( var_b953543d7e8d89ac ), "<dev string:x9e>" );
        
        if ( isdefined( self.pers[ "contribution" ] ) )
        {
            self.pers[ "contribution" ] = self.pers[ "contribution" ] + var_b953543d7e8d89ac;
        }
    }
    
    stats::setextrascore0( self.pers[ "contribution" ], "contribution" );
    killfeeddata = 0;
    killfeeddata += 6;
    killfeeddata += var_b953543d7e8d89ac << 4;
    struct = spawnstruct();
    struct.killfeeddata = killfeeddata;
    struct.victimid = -1;
    self.killfeedqueue = utility::queue_enqueue( self.killfeedqueue, struct );
    thread processkilleventfeed();
}

// Namespace common
// Params 0
// Checksum 0x38df8b, Offset: 0x8257
// Size: 0x37
function removespawnprotectiononnotify()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_bfad9621a40b949" );
    utility::waittill_any( "parachute_landed", "vehicle_enter", "weapon_fired" );
    function_6b65663570bf5d41();
}

// Namespace common
// Params 0
// Checksum 0x8a7ad9af, Offset: 0x8296
// Size: 0x33
function removespawnprotectiononads()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_bfad9621a40b949" );
    
    while ( self playerads() < 0.7 )
    {
        waitframe();
    }
    
    function_6b65663570bf5d41();
}

// Namespace common
// Params 0
// Checksum 0xb4241313, Offset: 0x82d1
// Size: 0x141
function function_59db47a8fd9a0762()
{
    maxspeedboost = level.gametypebundle.var_94feb4984cb0762a ?? level.gamemodebundle.maxspeedboost ?? 1.08;
    var_ce0c00bf147d0c98 = level.gametypebundle.var_60ff135e44259908 ?? level.gamemodebundle.var_ce0c00bf147d0c98 ?? 1.35;
    var_86ef12ce7c86eb40 = level.gametypebundle.var_e7f50f3061ee8f70 ?? level.gamemodebundle.var_86ef12ce7c86eb40 ?? 1.4;
    var_d1a4e49cb2f36dd2 = level.gametypebundle.var_a38bbd2034193daa ?? level.gamemodebundle.var_d1a4e49cb2f36dd2 ?? 1.08;
    level.var_3d09e599104f58f3 = [];
    level.var_3d09e599104f58f3[ 2 ] = maxspeedboost;
    level.var_3d09e599104f58f3[ 3 ] = var_ce0c00bf147d0c98;
    level.var_3d09e599104f58f3[ 4 ] = var_86ef12ce7c86eb40;
    level.var_3d09e599104f58f3[ 5 ] = var_d1a4e49cb2f36dd2;
    
    /#
        level thread function_d05b0ba8da6b568a();
    #/
}

// Namespace common
// Params 0
// Checksum 0xbdb9b118, Offset: 0x841a
// Size: 0x31b
function function_79211cd1f2b54512()
{
    currentstance = 2;
    
    switch ( self getstance() )
    {
        case #"hash_3fed0cbd303639eb":
            currentstance = 3;
            break;
        case #"hash_d91940431ed7c605":
            currentstance = 4;
            break;
        case #"hash_c6775c88e38f7803":
        default:
            if ( self issprinting() )
            {
                currentstance = 5;
            }
            
            break;
    }
    
    maxspeedboost = level.var_3d09e599104f58f3[ currentstance ] ?? 1.08;
    maxspeedboost = isdefined( self.perks[ "specialty_super_speed_script" ] ) ? getdvarfloat( @"hash_94084550cb0f64e7", 2 ) : maxspeedboost;
    speedperc = weapons::getplayerspeedbyweapon();
    
    if ( isdefined( self.var_6ce8c611b34fbad0 ) && !( self.var_6ce8c611b34fbad0 & 2 ) )
    {
        speedperc = 1;
    }
    
    additivetotal = 0;
    var_b708aeb049a91d7e = 1;
    var_d2352c4f21ca289a = isdefined( self.var_6ce8c611b34fbad0 ) && self.var_6ce8c611b34fbad0 & 1;
    
    if ( isarray( self.movespeedscalers ) && !var_d2352c4f21ca289a )
    {
        foreach ( scaler in self.movespeedscalers )
        {
            if ( isdefined( self.var_6ce8c611b34fbad0 ) && isdefined( scaler[ 1 ] ) && self.var_6ce8c611b34fbad0 & scaler[ 1 ] )
            {
                continue;
            }
            
            switch ( scaler[ 0 ] )
            {
                case 1:
                    if ( scaler[ currentstance ] )
                    {
                        additivetotal += scaler[ currentstance ];
                    }
                    
                    break;
                case 3:
                    if ( scaler[ currentstance ] )
                    {
                        var_b708aeb049a91d7e *= scaler[ currentstance ];
                    }
                    
                    break;
                case 2:
                    var_b708aeb049a91d7e *= scaler[ 2 ] ?? 1;
                    break;
                case 0:
                default:
                    additivetotal += scaler[ 2 ] ?? 0;
                    break;
            }
        }
    }
    
    if ( self.var_39fde66f57a0d09a )
    {
        additivetotal += self.var_39fde66f57a0d09a;
    }
    
    speedperc = speedperc * var_b708aeb049a91d7e + additivetotal;
    
    if ( getdvarint( @"hash_b7318d7f06303895", 0 ) == 0 && !self.var_39fde66f57a0d09a )
    {
        speedperc = clamp( speedperc, 0, maxspeedboost );
    }
    
    if ( isdefined( self.var_7a73125bb658e366[ currentstance ] ) )
    {
        speedperc = self.var_7a73125bb658e366[ currentstance ];
    }
    
    if ( isdvardefined( @"hash_9333dbd7040164e4" ) )
    {
        speedperc *= getdvarfloat( @"hash_9333dbd7040164e4" );
    }
    
    /#
        self.var_ed65a6b490a1f726 = speedperc;
    #/
    
    self.var_10642c4e8e304f16 = speedperc;
    self setmovespeedscale( speedperc );
}

// Namespace common
// Params 1
// Checksum 0x6e38e2c9, Offset: 0x873d
// Size: 0x19
function function_af33f049f75aa1ab( scaler )
{
    function_eb085e20748bf083( scaler, scaler, scaler, scaler );
}

// Namespace common
// Params 4
// Checksum 0xc1a2bae1, Offset: 0x875e
// Size: 0x79
function function_eb085e20748bf083( scalerstand, scalercrouch, scalerprone, scalersprint )
{
    if ( !isdefined( self.var_7a73125bb658e366 ) )
    {
        self.var_7a73125bb658e366 = [];
    }
    
    self.var_7a73125bb658e366[ 2 ] = scalerstand;
    self.var_7a73125bb658e366[ 3 ] = scalercrouch;
    self.var_7a73125bb658e366[ 4 ] = scalerprone;
    self.var_7a73125bb658e366[ 5 ] = scalersprint;
}

// Namespace common
// Params 0
// Checksum 0xf8f4d25, Offset: 0x87df
// Size: 0xc
function function_41f80bfd8512bf7c()
{
    self.var_7a73125bb658e366 = [];
}

// Namespace common
// Params 1
// Checksum 0x433937d0, Offset: 0x87f3
// Size: 0x2f, Type: bool
function function_8ff835bf23198a0( name )
{
    if ( !isdefined( self.movespeedscalers ) )
    {
        self.movespeedscalers = [];
    }
    
    return isdefined( self.movespeedscalers[ name ] );
}

// Namespace common
// Params 2
// Checksum 0x8992d228, Offset: 0x882b
// Size: 0x21
function function_ac4bf3256b2545e3( name, scaler )
{
    function_ac00f4b68093b840( name, 0, scaler );
}

// Namespace common
// Params 2
// Checksum 0x5c884c46, Offset: 0x8854
// Size: 0x22
function function_6f182a842ea5e2f1( name, scaler )
{
    function_ac00f4b68093b840( name, 2, scaler );
}

// Namespace common
// Params 5
// Checksum 0xf0a6fcbc, Offset: 0x887e
// Size: 0x41
function function_983eeeeb432f3d8( name, scalerstand, scalercrouch, scalerprone, scalersprint )
{
    function_ac00f4b68093b840( name, 1, scalerstand, scalercrouch, scalerprone, scalersprint );
}

// Namespace common
// Params 5
// Checksum 0x76c36c77, Offset: 0x88c7
// Size: 0x41
function function_6d745772528457ca( name, scalerstand, scalercrouch, scalerprone, scalersprint )
{
    function_ac00f4b68093b840( name, 3, scalerstand, scalercrouch, scalerprone, scalersprint );
}

// Namespace common
// Params 2
// Checksum 0x8e4ff1bb, Offset: 0x8910
// Size: 0x38
function function_a0f5c85d465c5f0a( name, scaler )
{
    if ( function_8ff835bf23198a0( name ) )
    {
        self.movespeedscalers[ name ] = undefined;
    }
    
    function_ac00f4b68093b840( name, 0, scaler );
}

// Namespace common
// Params 2
// Checksum 0xe2a4b2f1, Offset: 0x8950
// Size: 0x39
function function_1f09590404e452e4( name, scaler )
{
    if ( function_8ff835bf23198a0( name ) )
    {
        self.movespeedscalers[ name ] = undefined;
    }
    
    function_ac00f4b68093b840( name, 2, scaler );
}

// Namespace common
// Params 5
// Checksum 0xd663ba59, Offset: 0x8991
// Size: 0x58
function function_78021bb179add5f3( name, scalerstand, scalercrouch, scalerprone, scalersprint )
{
    if ( function_8ff835bf23198a0( name ) )
    {
        self.movespeedscalers[ name ] = undefined;
    }
    
    function_ac00f4b68093b840( name, 1, scalerstand, scalercrouch, scalerprone, scalersprint );
}

// Namespace common
// Params 5
// Checksum 0x8498c86b, Offset: 0x89f1
// Size: 0x58
function function_dbe1e4d9bd688221( name, scalerstand, scalercrouch, scalerprone, scalersprint )
{
    if ( function_8ff835bf23198a0( name ) )
    {
        self.movespeedscalers[ name ] = undefined;
    }
    
    function_ac00f4b68093b840( name, 3, scalerstand, scalercrouch, scalerprone, scalersprint );
}

// Namespace common
// Params 2
// Checksum 0x77a693ac, Offset: 0x8a51
// Size: 0x1f
function function_473eb5f3e0662540( name, scaler )
{
    function_dc77ac08c0419343( name, scaler );
}

// Namespace common
// Params 5
// Checksum 0x41cd1170, Offset: 0x8a78
// Size: 0x3e
function function_dced5d3fba787685( name, scalerstand, scalercrouch, scalerprone, scalersprint )
{
    function_dc77ac08c0419343( name, scalerstand, scalercrouch, scalerprone, scalersprint );
}

// Namespace common
// Params 2
// Checksum 0xdae6d05e, Offset: 0x8abe
// Size: 0x9a
function function_11a0a06c67c80f4d( name, filter )
{
    if ( !isdefined( self.movespeedscalers ) )
    {
        self.movespeedscalers = [];
    }
    
    /#
        if ( !isdefined( self.movespeedscalers[ name ] ) )
        {
            assertmsg( "<dev string:x1ef>" + name + "<dev string:x21c>" );
        }
    #/
    
    if ( !isdefined( self.movespeedscalers[ name ][ 1 ] ) )
    {
        self.movespeedscalers[ name ][ 1 ] = 0;
    }
    
    self.movespeedscalers[ name ][ 1 ] |= filter;
}

// Namespace common
// Params 2
// Checksum 0x983f0c90, Offset: 0x8b60
// Size: 0xbe
function function_c318feeff6c48f4c( name, filter )
{
    if ( !isdefined( self.movespeedscalers ) )
    {
        self.movespeedscalers = [];
    }
    
    /#
        if ( !isdefined( self.movespeedscalers[ name ] ) )
        {
            assertmsg( "<dev string:x232>" + name + "<dev string:x21c>" );
        }
    #/
    
    if ( !isdefined( self.movespeedscalers[ name ][ 1 ] ) )
    {
        self.movespeedscalers[ name ][ 1 ] = 0;
    }
    
    self.movespeedscalers[ name ][ 1 ] &= ~filter;
    
    if ( self.movespeedscalers[ name ][ 1 ] == 0 )
    {
        self.movespeedscalers[ name ][ 1 ] = undefined;
    }
}

// Namespace common
// Params 1
// Checksum 0x882e3f01, Offset: 0x8c26
// Size: 0x37
function function_a6a0ecdb12c8e351( filter )
{
    if ( !isdefined( self.var_6ce8c611b34fbad0 ) )
    {
        self.var_6ce8c611b34fbad0 = 0;
    }
    
    self.var_6ce8c611b34fbad0 |= filter;
}

// Namespace common
// Params 1
// Checksum 0x5fa4a756, Offset: 0x8c65
// Size: 0x50
function function_65276d8c156b2ec9( filter )
{
    if ( !isdefined( self.var_6ce8c611b34fbad0 ) )
    {
        self.var_6ce8c611b34fbad0 = 0;
    }
    
    self.var_6ce8c611b34fbad0 &= ~filter;
    
    if ( self.var_6ce8c611b34fbad0 == 0 )
    {
        self.var_6ce8c611b34fbad0 = undefined;
    }
}

// Namespace common
// Params 6, eflags: 0x4
// Checksum 0x4838f268, Offset: 0x8cbd
// Size: 0xd1
function private function_ac00f4b68093b840( name, type, scalerstand, scalercrouch, scalerprone, scalersprint )
{
    if ( !isdefined( self.movespeedscalers ) )
    {
        self.movespeedscalers = [];
    }
    
    /#
        if ( isdefined( self.movespeedscalers[ name ] ) )
        {
            assertmsg( "<dev string:x263>" + name + "<dev string:x28e>" );
        }
    #/
    
    self.movespeedscalers[ name ][ 0 ] = type;
    self.movespeedscalers[ name ][ 2 ] = scalerstand;
    self.movespeedscalers[ name ][ 3 ] = scalercrouch;
    self.movespeedscalers[ name ][ 4 ] = scalerprone;
    self.movespeedscalers[ name ][ 5 ] = scalersprint;
}

// Namespace common
// Params 5, eflags: 0x4
// Checksum 0x87524e89, Offset: 0x8d96
// Size: 0x15c
function private function_dc77ac08c0419343( name, scalerstand, scalercrouch, scalerprone, scalersprint )
{
    if ( !isdefined( self.movespeedscalers ) )
    {
        self.movespeedscalers = [];
    }
    
    /#
        if ( !isdefined( self.movespeedscalers[ name ] ) )
        {
            assertmsg( "<dev string:x2a2>" + name + "<dev string:x2d0>" );
        }
    #/
    
    if ( isdefined( self.movespeedscalers[ name ][ 2 ] ) && isdefined( scalerstand ) )
    {
        self.movespeedscalers[ name ][ 2 ] += scalerstand;
    }
    
    if ( isdefined( self.movespeedscalers[ name ][ 3 ] ) && isdefined( scalercrouch ) )
    {
        self.movespeedscalers[ name ][ 3 ] += scalercrouch;
    }
    
    if ( isdefined( self.movespeedscalers[ name ][ 4 ] ) && isdefined( scalerprone ) )
    {
        self.movespeedscalers[ name ][ 4 ] += scalerprone;
    }
    
    if ( isdefined( self.movespeedscalers[ name ][ 5 ] ) && isdefined( scalersprint ) )
    {
        self.movespeedscalers[ name ][ 5 ] += scalersprint;
    }
}

// Namespace common
// Params 1
// Checksum 0x869057f, Offset: 0x8efa
// Size: 0x58
function function_d85a92c557ea5a52( name )
{
    if ( !isdefined( self.movespeedscalers ) )
    {
        self.movespeedscalers = [];
    }
    
    /#
        if ( !isdefined( self.movespeedscalers[ name ] ) )
        {
            assertmsg( "<dev string:x2e5>" + name + "<dev string:x2d0>" );
        }
    #/
    
    self.movespeedscalers[ name ] = undefined;
}

// Namespace common
// Params 1
// Checksum 0x2b371be3, Offset: 0x8f5a
// Size: 0x5d
function get_gametype_asset( ref_hash )
{
    assert( isdefined( level.gametypebundle.var_b0cd073ebcb21c0e[ ref_hash ].assetref ), "<dev string:x313>" );
    return level.gametypebundle.var_b0cd073ebcb21c0e[ ref_hash ].assetref;
}

/#

    // Namespace common
    // Params 0
    // Checksum 0x483f82c3, Offset: 0x8fc0
    // Size: 0x9d, Type: dev
    function function_402b01db03247288()
    {
        setdvarifuninitialized( @"hash_a0399e84bbbf61af", 1 );
        setdvarifuninitialized( @"hash_b33e7ef4c3012307", 1 );
        setdvarifuninitialized( @"hash_154b480a4a533581", 1 );
        setdvarifuninitialized( @"hash_5a545e448fffa0b1", 1 );
        setdvarifuninitialized( @"hash_d93c57fe08db1420", 1 );
        setdvarifuninitialized( @"hash_e3c8697391df5018", 1 );
        setdvarifuninitialized( @"hash_2479130450b45772", 1 );
        setdvarifuninitialized( @"hash_5294fc174f163102", 1 );
    }

    // Namespace common
    // Params 2
    // Checksum 0x1c37dd53, Offset: 0x9065
    // Size: 0x10c, Type: dev
    function function_63599ecefc1097e4( name, type )
    {
        scalerstand = getdvarfloat( @"hash_a0399e84bbbf61af", 1 );
        scalercrouch = getdvarfloat( @"hash_b33e7ef4c3012307", 1 );
        scalerprone = getdvarfloat( @"hash_154b480a4a533581", 1 );
        scalersprint = getdvarfloat( @"hash_5a545e448fffa0b1", 1 );
        
        switch ( type )
        {
            case 1:
                function_983eeeeb432f3d8( name, scalerstand, scalercrouch, scalerprone, scalersprint );
                break;
            case 3:
                function_6d745772528457ca( name, scalerstand, scalercrouch, scalerprone, scalersprint );
                break;
            case 2:
                function_6f182a842ea5e2f1( name, scalerstand );
                break;
            case 0:
            default:
                function_ac4bf3256b2545e3( name, scalerstand );
                break;
        }
    }

    // Namespace common
    // Params 1
    // Checksum 0x168925c4, Offset: 0x9179
    // Size: 0x18, Type: dev
    function function_c005bd240162422b( name )
    {
        function_d85a92c557ea5a52( name );
    }

    // Namespace common
    // Params 0
    // Checksum 0xd684ad82, Offset: 0x9199
    // Size: 0x84, Type: dev
    function function_3beb6ed1f11ee8ac()
    {
        scalerstand = getdvarfloat( @"hash_d93c57fe08db1420", 1 );
        scalercrouch = getdvarfloat( @"hash_e3c8697391df5018", 1 );
        scalerprone = getdvarfloat( @"hash_2479130450b45772", 1 );
        scalersprint = getdvarfloat( @"hash_5294fc174f163102", 1 );
        function_eb085e20748bf083( scalerstand, scalercrouch, scalerprone, scalersprint );
    }

    // Namespace common
    // Params 0
    // Checksum 0xb2808d26, Offset: 0x9225
    // Size: 0x1ea, Type: dev
    function function_d05b0ba8da6b568a()
    {
        level endon( #"game_ended" );
        function_402b01db03247288();
        
        while ( true )
        {
            if ( getdvarint( @"hash_3bed81e454bcab61", -1 ) != -1 )
            {
                type = getdvarint( @"hash_3bed81e454bcab61", 0 );
                setdvar( @"hash_3bed81e454bcab61", -1 );
                scalername = "<dev string:x331>" + type;
                
                foreach ( player in level.players )
                {
                    if ( player function_8ff835bf23198a0( scalername ) )
                    {
                        player iprintlnbold( "<dev string:x33b>" + scalername );
                        player function_c005bd240162422b( scalername );
                        continue;
                    }
                    
                    player iprintlnbold( "<dev string:x35e>" + scalername );
                    player function_63599ecefc1097e4( scalername, type );
                }
            }
            
            if ( getdvarint( @"hash_30ff1ba6eea19962", 0 ) != 0 )
            {
                setdvar( @"hash_30ff1ba6eea19962", 0 );
                
                foreach ( player in level.players )
                {
                    if ( player.var_7a73125bb658e366.size > 0 )
                    {
                        player iprintlnbold( "<dev string:x37f>" );
                        player function_41f80bfd8512bf7c();
                        continue;
                    }
                    
                    player iprintlnbold( "<dev string:x3aa>" );
                    player function_3beb6ed1f11ee8ac();
                }
            }
            
            wait 1;
        }
    }

#/
