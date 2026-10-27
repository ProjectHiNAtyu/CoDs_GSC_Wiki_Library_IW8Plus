// scripts\mp\gametypes\gun.gsc  (hash_6a9843ac9e1d10c2.gscc) (size: 29191 Bytes / 0x7207 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7783a469 (2005116009)
// size ...... 29191 (0x7207)
// includes .. 36  (offset: 0x6613)
// strings ... 140 (offset: 0x6733)
// dev strs .. 12  (offset: 0x713f)
// exports ... 45  (offset: 0x47fb)
// cseg ...... 0xa69 + 0x3d92 (0x47fb)
// imports ... 192 (offset: 0x4f03)
// animtree1 . 0   (offset: 0x7207)
// animtree2 . 0   (offset: 0x7207)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\script;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\arena;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\team_gun;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\persistence;
#using scripts\mp\playerstats_interface;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\weapons;

#namespace gun;

// Namespace gun
// Params 0
// Checksum 0x76d2b4d1, Offset: 0xa87
// Size: 0x22f
function main()
{
    globallogic::init();
    globallogic::setupcallbacks();
    allowed = [];
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    setspecialloadout();
    updategametypedvars();
    setgunladder();
    
    if ( team_gun::function_ab3051539fb113f1() )
    {
        level.teambased = 1;
        level.ignorekdrstats = 1;
        level.disablespawncamera = 1;
        level.var_fcd385b442eeddf6 = getdvarint( @"hash_73aac3f6d560f91f", 10 );
    }
    else
    {
        level.teambased = 0;
        level.ignorekdrstats = 1;
        level.disablespawncamera = 1;
    }
    
    if ( !team_gun::function_ab3051539fb113f1() )
    {
        level thread uav::function_bb7953c7f773188e( 3 );
    }
    
    thread waitthensetstatgroupreadonly();
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"hash_5e4c0033a7bbd7f", &onplayerkilled );
    level.doprematch = 1;
    level.supportintel = 0;
    level.supportnuke = 0;
    level.disablecopycatloadout = 1;
    setomnvar( "ui_killcam_copycat", 0 );
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.ontimelimit = &ontimelimit;
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    level.modifyunifiedpointscallback = &modifyunifiedpointscallback;
    level.checkcustomclosetoscorelimit = &checkcustomclosetoscorelimit;
    
    if ( !level.var_b9f5b44894d6b0f3 )
    {
        level.onplayerscore = &onplayerscore;
    }
    
    if ( team_gun::function_ab3051539fb113f1() )
    {
        level.getspawnpoint = &function_c6076ee71277f787;
        level.modifyunifiedpointscallback = undefined;
        level.onplayerscore = undefined;
        level.onplayerkilled = &function_897fcf80ac7064e2;
        level.ontimelimit = &gamelogic_mp::default_ontimelimit;
    }
    
    /#
        setdevdvarifuninitialized( @"scr_gun_rank_up", 0 );
        setdevdvarifuninitialized( @"scr_gun_rank_down", 0 );
    #/
}

// Namespace gun
// Params 0
// Checksum 0x9703974a, Offset: 0xcbe
// Size: 0x42
function waitthensetstatgroupreadonly()
{
    self endon( #"game_ended" );
    wait 1;
    
    if ( isdefined( level.playerstats ) )
    {
        playerstats_interface::makeplayerstatgroupreadonly( "kdr" );
        playerstats_interface::makeplayerstatgroupreadonly( "losses" );
        playerstats_interface::makeplayerstatgroupreadonly( "winLoss" );
    }
}

// Namespace gun
// Params 0
// Checksum 0x85800138, Offset: 0xd08
// Size: 0x173
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata( 1 );
    var_b26ea0a00e76e9ea = getmatchrulesdata( "gunData", "gunGameWeaponsTable" );
    level.var_b26ea0a00e76e9ea = getscriptbundle( hashcat( %"hash_adeeae037d337c6", var_b26ea0a00e76e9ea ) );
    assert( isdefined( level.var_b26ea0a00e76e9ea ), "<dev string:x24>" );
    var_499781fda422fb5e = getmatchrulesdata( "gunData", "gunGameWeaponTierList" );
    
    if ( isdefined( var_499781fda422fb5e ) )
    {
        level.gungameweapons = getscriptbundle( hashcat( %"hash_586ba1c6dbd22d07", var_499781fda422fb5e ) );
        assert( isdefined( level.gungameweapons ), "<dev string:x75>" + var_499781fda422fb5e );
    }
    
    level.var_6453a55921d17705 = getmatchrulesdata( "gunData", "meleeGivesScore" );
    level.var_41b896ef37b43f9e = getmatchrulesdata( "gunData", "meleeDemotesVictim" );
    level.var_b5d9e21ba11f0ba2 = getmatchrulesdata( "gunData", "gunGameVictoryConditions" );
    level.setback = getmatchrulesdata( "gunData", "setback" );
    level.setbackstreak = getmatchrulesdata( "gunData", "setbackStreak" );
    level.killsperweapon = getmatchrulesdata( "gunData", "killsPerWeapon" );
    level.ladderindex = getmatchrulesdata( "gunData", "ladderIndex" );
    level.useladderindex = getmatchrulesdata( "gunData", "useLadderIndex" );
    setdynamicdvar( @"scr_gun_promode", 0 );
}

// Namespace gun
// Params 0
// Checksum 0x50ca16ca, Offset: 0xe83
// Size: 0x2
function onprecachegametype()
{
    
}

// Namespace gun
// Params 0
// Checksum 0x3b9f4061, Offset: 0xe8d
// Size: 0x111
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
    
    setgunsfinal();
    
    if ( team_gun::function_ab3051539fb113f1() )
    {
        function_1445f4bd06c576a2();
    }
    else
    {
        initspawns();
    }
    
    spawnlogic::finalizemap();
    level.quickmessagetoall = 1;
    
    /#
        level thread function_21faf7f37b326725();
    #/
}

// Namespace gun
// Params 0
// Checksum 0xa20daeba, Offset: 0xfa6
// Size: 0xa9
function initspawns()
{
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::function_6dbabb72223a4bca();
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

// Namespace gun
// Params 0
// Checksum 0x7471b086, Offset: 0x1057
// Size: 0xe2
function function_1445f4bd06c576a2()
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

// Namespace gun
// Params 0
// Checksum 0xdaede16e, Offset: 0x1141
// Size: 0x3b
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.var_b9f5b44894d6b0f3 = getmatchrulesdata( "commonOption", "overrideScoringOnExtraScore5" ) ?? 0;
    setdvar( @"hash_1c6e2fb602f2f4a3", level.var_b9f5b44894d6b0f3 );
}

// Namespace gun
// Params 1
// Checksum 0x8f46010, Offset: 0x1184
// Size: 0xbf
function onplayerconnect( player )
{
    player thread keepweaponsloaded();
    player class::function_e84a99f0f4904c66();
    player.pers[ "gamemodeLoadout" ] = level.gun_loadouts[ "axis" ];
    player.gungamegunindex = 0;
    player.gungameprevgunindex = 0;
    player thread refillammo();
    player thread refillsinglecountammo();
    
    if ( team_gun::function_ab3051539fb113f1() && !isbot( player ) )
    {
        player notifyonplayercommand( "gun_game_next", "+weapnext" );
    }
    
    if ( level.var_b9f5b44894d6b0f3 )
    {
        player stats::function_fe615555f60e88b9( player.pers[ "extrascore5" ] ?? 0, "extrascore5" );
    }
}

// Namespace gun
// Params 0
// Checksum 0xaa07db67, Offset: 0x124b
// Size: 0xb3
function keepweaponsloaded()
{
    self loadweaponsforplayer( [ level.gun_guns[ 0 ], level.gun_guns[ 1 ] ], 1 );
    closeweapons = [];
    
    while ( true )
    {
        self waittill( #"hash_f77fe48d346666e" );
        closeweapons[ 0 ] = level.gun_guns[ int( max( 0, self.gungamegunindex - level.setback ) ) ];
        closeweapons[ 1 ] = level.gun_guns[ self.gungamegunindex ];
        closeweapons[ 2 ] = level.gun_guns[ self.gungamegunindex + 1 ];
        self loadweaponsforplayer( closeweapons, 1 );
    }
}

// Namespace gun
// Params 0
// Checksum 0xe1796f57, Offset: 0x1306
// Size: 0x65
function getspawnpoint()
{
    spawnpoint = undefined;
    
    if ( level.ingraceperiod )
    {
        spawnpoints = spawnlogic::getstartspawnpoints();
        
        if ( !isdefined( level.requiresminstartspawns ) )
        {
            assert( spawnpoints.size != 0 || spawnpoints.size >= 8, "<dev string:xbe>" + 8 + "<dev string:xd5>" );
        }
    }
    
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace gun
// Params 0
// Checksum 0xdc5ae6b9, Offset: 0x1374
// Size: 0xbb
function function_c6076ee71277f787()
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

// Namespace gun
// Params 1
// Checksum 0x78f76c15, Offset: 0x1438
// Size: 0x55
function onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    
    if ( self.var_3ecbff0225153315 )
    {
        thread hud_message::showsplash( #"dropped_gun_rank" );
        self.var_3ecbff0225153315 = undefined;
    }
    
    thread function_2c02b071fcf603b7();
    level notify( #"spawned_player" );
}

// Namespace gun
// Params 0
// Checksum 0xa2fd860b, Offset: 0x1495
// Size: 0x69
function function_2c02b071fcf603b7()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( team_gun::function_ab3051539fb113f1() )
    {
        team_gun::function_7f7964a1bdd7adc5();
    }
    
    if ( level.gameended && self.gungamegunindex == level.gun_guns.size )
    {
        self.gungamegunindex = self.gungameprevgunindex;
    }
    
    thread givenextgun( 1 );
}

// Namespace gun
// Params 1
// Checksum 0x898b42a7, Offset: 0x1506
// Size: 0x982
function onplayerkilled( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    smeansofdeath = deathdata.meansofdeath;
    objweapon = deathdata.objweapon;
    
    if ( level.gameended )
    {
        return;
    }
    
    ismeleeweapon = weapon_utility::isriotshield( objweapon );
    isknife = weapon_utility::isknifeonly( objweapon.basename ) || weapon::function_e93a21a657377115( objweapon );
    isexecution = smeansofdeath == "MOD_EXECUTION";
    var_c62b097252632e9d = smeansofdeath == "MOD_MELEE_TAKEDOWN";
    
    if ( !isdefined( victim.ladderdeathsthisweapon ) )
    {
        victim.ladderdeathsthisweapon = 0;
    }
    
    victim.ladderdeathsthisweapon++;
    
    if ( smeansofdeath == "MOD_FALLING" || attacker == victim || smeansofdeath == "MOD_MELEE" && ( isknife || level.var_41b896ef37b43f9e ) || victim.ladderdeathsthisweapon == level.setbackstreak || isexecution || var_c62b097252632e9d )
    {
        victim.ladderdeathsthisweapon = 0;
        victim notify( #"hash_f77fe48d346666e" );
        victim.gungameprevgunindex = victim.gungamegunindex;
        victim.gungamegunindex = int( max( 0, victim.gungamegunindex - level.setback ) );
        
        if ( victim.gungameprevgunindex > victim.gungamegunindex )
        {
            if ( level.var_b9f5b44894d6b0f3 )
            {
                victim stats::function_fe615555f60e88b9( maxint( victim.pers[ "extrascore5" ] - level.setback, 0 ) );
            }
            else
            {
                victim gamescore::giveplayerscore( #"dropped_gun_rank", 1 );
            }
            
            if ( level.gametypebundle.var_5881c0da20cc1684 )
            {
                victim.var_3ecbff0225153315 = 1;
            }
            else
            {
                victim thread rank::scoreeventpopup( #"dropped_gun_rank" );
            }
            
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
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe3>" );
                
                if ( isdefined( victim.pers[ "setbacks" ] ) )
                {
                    victim.pers[ "setbacks" ] = victim.pers[ "setbacks" ] + 1;
                }
            }
            
            victim persistence::statsetchild( "round", "setbacks", victim.pers[ "setbacks" ] );
            victim gameplay_sound_fx::playlocalsoundfx( #"gun_rank_down" );
            
            if ( isplayer( victim ) )
            {
                victim stats::setextrascore1( victim.pers[ "setbacks" ], "setbacks" );
            }
            
            extra_info_0 = getxhash( "Gun_Game_Previous_Rank: " + string( victim.gungameprevgunindex ) );
            extra_info_1 = getxhash( "Gun_Game_New_Rank: " + string( victim.gungamegunindex ) );
            extra_info_2 = getxhash( "Gun_Game_Current_Weapon_Before_Demotion: " + victim.primaryweapon );
            function_a46674787658909a( victim, "gun_game_demoted", extra_info_0, extra_info_1, extra_info_2 );
        }
        
        if ( smeansofdeath == "MOD_MELEE" )
        {
            if ( victim.gungameprevgunindex )
            {
                attacker thread points::doscoreevent( #"dropped_enemy_gun_rank" );
            }
            
            attacker updateknivesperminute();
            attacker points::doscoreevent( #"mode_gun_melee" );
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
            {
                if ( isdefined( attacker.leaderboarddata[ "stabs" ] ) )
                {
                    attacker.leaderboarddata[ "stabs" ] = attacker.leaderboarddata[ "stabs" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "stabs" ] ) )
                {
                    [[ level.leaderboardfunc[ "stabs" ] ]]( attacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe3>" );
                
                if ( isdefined( attacker.pers[ "stabs" ] ) )
                {
                    attacker.pers[ "stabs" ] = attacker.pers[ "stabs" ] + 1;
                }
            }
            
            attacker persistence::statsetchild( "round", "stabs", attacker.pers[ "stabs" ] );
            
            if ( isplayer( attacker ) )
            {
                attacker stats::setextrascore0( attacker.pers[ "stabs" ], "stabs" );
            }
            
            attacker dialog::leaderdialogonplayer( #"humiliate", "gametype" );
        }
        
        if ( attacker == victim )
        {
            return;
        }
    }
    
    if ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_IMPACT" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_FIRE" || smeansofdeath == "MOD_MELEE" && !isknife && level.var_6453a55921d17705 || smeansofdeath == "MOD_MELEE" && isknife || isexecution || var_c62b097252632e9d )
    {
        baseprimary = getweaponbasename( attacker.primaryweapon );
        
        if ( !attacker canprogressingunrank( objweapon, baseprimary, isexecution ) )
        {
            return;
        }
        
        if ( !isdefined( attacker.ladderkillsthisweapon ) )
        {
            attacker.ladderkillsthisweapon = 0;
        }
        
        attacker.ladderkillsthisweapon++;
        
        if ( attacker.ladderkillsthisweapon != level.killsperweapon )
        {
            return;
        }
        
        attacker.ladderkillsthisweapon = 0;
        attacker.ladderdeathsthisweapon = 0;
        attacker.gungameprevgunindex = attacker.gungamegunindex;
        attacker.gungamegunindex++;
        attacker notify( #"hash_f77fe48d346666e" );
        
        if ( level.var_b9f5b44894d6b0f3 )
        {
            attacker stats::function_fe615555f60e88b9( attacker.pers[ "extrascore5" ] + 1 );
        }
        else
        {
            attacker gamescore::giveplayerscore( #"gained_gun_rank", 1 );
        }
        
        if ( attacker.gungamegunindex == level.gun_guns.size - 2 )
        {
            level.kick_afk_check = 1;
        }
        
        if ( attacker isonlastkill() )
        {
            losingplayers = [];
            
            foreach ( p in level.players )
            {
                if ( p != attacker )
                {
                    losingplayers[ losingplayers.size ] = p;
                }
            }
            
            dialog::leaderdialogonplayers( #"lasttier_enemy", losingplayers );
            attacker dialog::leaderdialogonplayer( #"lasttier_friendly" );
            attacker hud_message::showsplash( "gun_final_kill" );
            sound::playsoundonplayers( "mp_enemy_obj_captured" );
            level thread hud_util::teamplayercardsplash( "callout_top_gun_rank", attacker );
        }
        
        if ( attacker.gungamegunindex < level.gun_guns.size )
        {
            extra_info_0 = getxhash( "Gun_Game_Previous_Rank: " + string( attacker.gungameprevgunindex ) );
            extra_info_1 = getxhash( "Gun_Game_New_Rank: " + string( attacker.gungamegunindex ) );
            extra_info_2 = getxhash( "Gun_Game_Weapon_Used: " + attacker.primaryweapon );
            function_a46674787658909a( attacker, "gun_game_gained_gun_rank", extra_info_0, extra_info_1, extra_info_2 );
            
            if ( level.gametypebundle.var_dc878407d9c47b41 )
            {
                attacker points::doscoreevent( #"gained_gun_rank" );
            }
            else
            {
                points = rank::getscoreinfovalue( #"gained_gun_rank" );
                attacker thread rank::scorepointspopup( points );
                attacker thread rank::scoreeventpopup( #"gained_gun_rank" );
            }
            
            attacker gameplay_sound_fx::playlocalsoundfx( #"gun_rank_up" );
            attacker thread givenextgun( 0 );
        }
        
        if ( isdefined( attacker.lastgunrankincreasetime ) && gettime() - attacker.lastgunrankincreasetime < 5000 )
        {
            attacker points::doscoreevent( #"mode_gun_quick_kill" );
        }
        
        attacker.lastgunrankincreasetime = gettime();
    }
}

// Namespace gun
// Params 10
// Checksum 0x7503516a, Offset: 0x1e90
// Size: 0x2a3
function function_897fcf80ac7064e2( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid )
{
    awardteam = attacker.pers[ "team" ];
    
    if ( !isdefined( level.var_3dd228e013b9d386 ) )
    {
        level.var_3dd228e013b9d386 = [];
    }
    
    if ( !isdefined( level.var_4eeecb77cf60cfea ) )
    {
        level.var_4eeecb77cf60cfea = [];
    }
    
    if ( !isdefined( level.var_3dd228e013b9d386[ awardteam ] ) )
    {
        level.var_3dd228e013b9d386[ awardteam ] = level.var_fcd385b442eeddf6;
    }
    
    if ( !isdefined( level.var_4eeecb77cf60cfea[ awardteam ] ) )
    {
        level.var_4eeecb77cf60cfea[ awardteam ] = 0;
    }
    
    currentscore = getteamscore( awardteam ) + 1;
    ismeleeweapon = weapon_utility::isriotshield( objweapon );
    isknife = weapon_utility::isknifeonly( objweapon.basename ) || weapon::function_e93a21a657377115( objweapon );
    isexecution = smeansofdeath == "MOD_EXECUTION";
    
    if ( smeansofdeath == "MOD_FALLING" || attacker == self || smeansofdeath == "MOD_MELEE" && isknife )
    {
        return;
    }
    
    if ( currentscore == level.var_3dd228e013b9d386[ awardteam ] )
    {
        level.var_4eeecb77cf60cfea[ awardteam ]++;
        level.var_3dd228e013b9d386[ awardteam ] += level.var_fcd385b442eeddf6;
        
        foreach ( player in teams::getteamdata( awardteam, "players" ) )
        {
            player.gungamegunindex = level.var_4eeecb77cf60cfea[ awardteam ];
            player.gungameprevgunindex = level.var_4eeecb77cf60cfea[ awardteam ] - 1;
            points = rank::getscoreinfovalue( #"gained_gun_rank" );
            player thread rank::scorepointspopup( points );
            player thread rank::scoreeventpopup( #"gained_gun_rank" );
            player gameplay_sound_fx::playlocalsoundfx( #"gun_rank_up" );
            player thread givenextgun( 0 );
        }
    }
}

// Namespace gun
// Params 1
// Checksum 0xad7b7508, Offset: 0x213b
// Size: 0x308
function givenextgun( dosetspawnweapon )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !dosetspawnweapon )
    {
        val::set( "spawn_weapon", "weapon_switch", 0 );
    }
    
    if ( team_gun::function_ab3051539fb113f1() && !dosetspawnweapon )
    {
        result = wait_button_pressed_or_timeout( 5 );
        
        if ( !result )
        {
            return;
        }
    }
    
    newweaponobj = getnextgun();
    newweaponobj = weapons::updatesavedaltstate( newweaponobj );
    inventory_utility::_giveweapon( newweaponobj, undefined, undefined, 1 );
    
    if ( dosetspawnweapon )
    {
        self setspawnweapon( newweaponobj );
        
        foreach ( weapon in self.weaponlist )
        {
            if ( weapon == newweaponobj )
            {
                continue;
            }
            
            if ( isdefined( self.climbweapon ) && getweaponbasename( weapon ) == getweaponbasename( self.climbweapon ) )
            {
                continue;
            }
            
            if ( isdefined( self.swimweapon ) && getweaponbasename( weapon ) == getweaponbasename( self.swimweapon ) )
            {
                continue;
            }
            
            thread inventory_utility::takeweaponwhensafe( weapon );
        }
    }
    
    self.pers[ "primaryWeapon" ] = newweaponobj.basename;
    self.primaryweapon = newweaponobj.basename;
    self.primaryweaponobj = newweaponobj;
    gameplay_telemetry::function_3e91d2222fa2419f();
    inventory_utility::_switchtoweapon( newweaponobj );
    knifeassetname = "jup_jp23_me_knife_mp";
    
    if ( isdefined( level.gamemodebundle.defaultknife ) )
    {
        knifebundle = getscriptbundle( level.gamemodebundle.defaultknife );
        knifeassetname = knifebundle.asset;
    }
    
    if ( self.gungamegunindex != level.gun_guns.size - 1 )
    {
        self givestartammo( newweaponobj );
        knifeweapon = weapon_utility::function_d2c8356dc369d9ce( knifeassetname );
        self giveweapon( knifeweapon );
        self assignweaponmeleeslot( knifeweapon );
    }
    
    if ( !dosetspawnweapon )
    {
        currentweapon = self.lastweaponobj;
        thread takeweaponwhensafegungame( currentweapon, 1 );
    }
    
    giveortakethrowingknife( newweaponobj.basename );
    weapons::updatetogglescopestate( newweaponobj );
    self.gungameprevgunindex = self.gungamegunindex;
    
    if ( !isdefined( self.lastgunpromotiontime ) )
    {
        self.lastgunpromotiontime = gettime();
    }
    
    var_4b52e804870373d8 = ( gettime() - self.lastgunpromotiontime ) / 1000;
    self.lastgunpromotiontime = gettime();
    
    if ( var_4b52e804870373d8 > self.pers[ "longestTimeSpentOnWeapon" ] )
    {
        self.pers[ "longestTimeSpentOnWeapon" ] = var_4b52e804870373d8;
    }
}

// Namespace gun
// Params 1
// Checksum 0x3f427ac7, Offset: 0x244b
// Size: 0x5b, Type: bool
function wait_button_pressed_or_timeout( time )
{
    self endon( #"disconnect" );
    self notify( #"wait_button_pressed_or_timeout" );
    self endon( #"wait_button_pressed_or_timeout" );
    hud_message::showerrormessage( %"mp/gun_game_press_for_next_gun" );
    msg = utility::waittill_any_timeout( time, "gun_game_next" );
    return true;
}

// Namespace gun
// Params 2
// Checksum 0xeeb64040, Offset: 0x24af
// Size: 0x53
function takeweaponwhensafegungame( weapon, allowswitch )
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( !inventory_utility::iscurrentweapon( weapon ) )
        {
            break;
        }
        
        waitframe();
    }
    
    inventory_utility::_takeweapon( weapon );
    
    if ( allowswitch )
    {
        val::reset_all( "spawn_weapon" );
    }
}

// Namespace gun
// Params 1
// Checksum 0xc6bbdb71, Offset: 0x250a
// Size: 0x43
function getnextgun( indexoverride )
{
    gunindex = self.gungamegunindex;
    
    if ( isdefined( indexoverride ) )
    {
        gunindex = indexoverride;
    }
    
    newweapon = level.gun_guns[ gunindex ];
    return newweapon;
}

// Namespace gun
// Params 0
// Checksum 0x4216a243, Offset: 0x2556
// Size: 0xc2
function ontimelimit()
{
    winners = gethighestprogressedplayers();
    
    if ( !isdefined( winners ) || !winners.size )
    {
        thread gamelogic_mp::endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
        return;
    }
    
    if ( winners.size == 1 )
    {
        thread gamelogic_mp::endgame( winners[ 0 ], game[ "end_reason" ][ "time_limit_reached" ] );
        return;
    }
    
    if ( winners[ winners.size - 1 ].gungamegunindex > winners[ winners.size - 2 ].gungamegunindex )
    {
        thread gamelogic_mp::endgame( winners[ winners.size - 1 ], game[ "end_reason" ][ "time_limit_reached" ] );
        return;
    }
    
    thread gamelogic_mp::endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace gun
// Params 0
// Checksum 0x76aec4a8, Offset: 0x2620
// Size: 0xb0
function gethighestprogressedplayers()
{
    highestprogress = -1;
    highestprogressedplayers = [];
    
    foreach ( player in level.players )
    {
        if ( player.gungamegunindex >= highestprogress )
        {
            highestprogress = player.gungamegunindex;
            highestprogressedplayers[ highestprogressedplayers.size ] = player;
        }
    }
    
    return highestprogressedplayers;
}

// Namespace gun
// Params 0
// Checksum 0x478c118, Offset: 0x26d9
// Size: 0x77
function refillammo()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"reload_ammo_added" );
        currentweapon = self getcurrentweapon();
        clipsize = weaponclipsize( currentweapon );
        startingammo = weaponstartammo( currentweapon );
        stockammo = startingammo - clipsize;
        self setweaponammostock( currentweapon, stockammo );
    }
}

// Namespace gun
// Params 0
// Checksum 0x4c3e8017, Offset: 0x2758
// Size: 0x77
function refillsinglecountammo()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( player::isreallyalive( self ) && self.team != "spectator" && isdefined( self.primaryweapon ) && self getammocount( self.primaryweapon ) == 0 )
        {
            wait 2;
            self notify( #"reload" );
            wait 1;
            continue;
        }
        
        waitframe();
    }
}

// Namespace gun
// Params 0
// Checksum 0xe6b4e5b8, Offset: 0x27d7
// Size: 0xaa6
function setgunladder()
{
    level.gun_guns = [];
    level.selectedweapons = [];
    
    if ( level.useladderindex )
    {
        switch ( level.ladderindex )
        {
            case 1:
            case 4:
            case 5:
            case 6:
                if ( game_utility_mp::matchmakinggame() && getdvarint( @"hash_fb3e643c9cdd861", 0 ) == 1 )
                {
                    level.gun_guns[ 0 ] = { #weaponcategory:"rand_pistol" };
                    level.gun_guns[ 1 ] = { #weaponcategory:"rand_shotgun" };
                    level.gun_guns[ 2 ] = { #weaponcategory:"rand_smg" };
                    level.gun_guns[ 3 ] = { #weaponcategory:"rand_assault" };
                    level.gun_guns[ 4 ] = { #weaponcategory:"rand_lmg" };
                    level.gun_guns[ 5 ] = { #weaponcategory:"rand_sniper" };
                    level.gun_guns[ 6 ] = { #weaponcategory:"rand_smg" };
                    level.gun_guns[ 7 ] = { #weaponcategory:"rand_assault" };
                    level.gun_guns[ 8 ] = { #weaponcategory:"rand_lmg" };
                    level.gun_guns[ 9 ] = { #weaponcategory:"rand_launcher" };
                    level.gun_guns[ 10 ] = { #weaponcategory:"rand_shotgun" };
                    level.gun_guns[ 11 ] = { #weaponcategory:"rand_smg" };
                    level.gun_guns[ 12 ] = { #weaponcategory:"rand_assault" };
                    level.gun_guns[ 13 ] = { #weaponcategory:"rand_shotgun" };
                    level.gun_guns[ 14 ] = { #weaponcategory:"rand_assault" };
                    level.gun_guns[ 15 ] = { #weaponcategory:"rand_sniper" };
                    level.gun_guns[ 16 ] = { #weaponcategory:"rand_pistol" };
                    level.gun_guns[ 17 ] = { #weaponcategory:"rand_knife_end" };
                }
                else
                {
                    level.gun_guns[ 0 ] = { #weaponcategory:"rand_assault" };
                    level.gun_guns[ 1 ] = { #weaponcategory:"rand_smg" };
                    level.gun_guns[ 2 ] = { #weaponcategory:"rand_shotgun" };
                    level.gun_guns[ 3 ] = { #weaponcategory:"rand_lmg" };
                    level.gun_guns[ 4 ] = { #weaponcategory:"rand_assault" };
                    level.gun_guns[ 5 ] = { #weaponcategory:"rand_dmr" };
                    level.gun_guns[ 6 ] = { #weaponcategory:"rand_pistol" };
                    level.gun_guns[ 7 ] = { #weaponcategory:"rand_assault" };
                    level.gun_guns[ 8 ] = { #weaponcategory:"rand_smg" };
                    level.gun_guns[ 9 ] = { #weaponcategory:"rand_launcher" };
                    level.gun_guns[ 10 ] = { #weaponcategory:"rand_dmr" };
                    level.gun_guns[ 11 ] = { #weaponcategory:"rand_lmg" };
                    level.gun_guns[ 12 ] = { #weaponcategory:"rand_assault" };
                    level.gun_guns[ 13 ] = { #weaponcategory:"rand_smg" };
                    level.gun_guns[ 14 ] = { #weaponcategory:"rand_sniper" };
                    level.gun_guns[ 15 ] = { #weaponcategory:"rand_shotgun" };
                    level.gun_guns[ 16 ] = { #weaponcategory:"rand_pistol" };
                    level.gun_guns[ 17 ] = { #weaponcategory:"rand_knife_end" };
                }
                
                break;
            case 2:
                level.gun_guns[ 0 ] = { #weaponcategory:"rand_pistol" };
                level.gun_guns[ 1 ] = { #weaponcategory:"rand_shotgun" };
                level.gun_guns[ 2 ] = { #weaponcategory:"rand_smg" };
                level.gun_guns[ 3 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 4 ] = { #weaponcategory:"rand_pistol" };
                level.gun_guns[ 5 ] = { #weaponcategory:"rand_shotgun" };
                level.gun_guns[ 6 ] = { #weaponcategory:"rand_smg" };
                level.gun_guns[ 7 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 8 ] = { #weaponcategory:"rand_pistol" };
                level.gun_guns[ 9 ] = { #weaponcategory:"rand_shotgun" };
                level.gun_guns[ 10 ] = { #weaponcategory:"rand_smg" };
                level.gun_guns[ 11 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 12 ] = { #weaponcategory:"rand_pistol" };
                level.gun_guns[ 13 ] = { #weaponcategory:"rand_shotgun2" };
                level.gun_guns[ 14 ] = { #weaponcategory:"rand_smg" };
                level.gun_guns[ 15 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 16 ] = { #weaponcategory:"rand_pistol" };
                level.gun_guns[ 17 ] = { #weaponcategory:"rand_knife_end" };
                break;
            case 3:
                level.gun_guns[ 0 ] = { #weaponcategory:"rand_pistol" };
                level.gun_guns[ 1 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 2 ] = { #weaponcategory:"rand_lmg" };
                level.gun_guns[ 3 ] = { #weaponcategory:"rand_launcher" };
                level.gun_guns[ 4 ] = { #weaponcategory:"rand_sniper" };
                level.gun_guns[ 5 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 6 ] = { #weaponcategory:"rand_lmg" };
                level.gun_guns[ 7 ] = { #weaponcategory:"rand_launcher" };
                level.gun_guns[ 8 ] = { #weaponcategory:"rand_sniper" };
                level.gun_guns[ 9 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 10 ] = { #weaponcategory:"rand_lmg" };
                level.gun_guns[ 11 ] = { #weaponcategory:"rand_launcher" };
                level.gun_guns[ 12 ] = { #weaponcategory:"rand_sniper2" };
                level.gun_guns[ 13 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 14 ] = { #weaponcategory:"rand_sniper2" };
                level.gun_guns[ 15 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 16 ] = { #weaponcategory:"rand_pistol" };
                level.gun_guns[ 17 ] = { #weaponcategory:"rand_knife_end" };
                break;
            case 7:
                level.gun_guns[ 0 ] = { #weaponcategory:"rand_pistol" };
                level.gun_guns[ 1 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 2 ] = { #weaponcategory:"rand_lmg" };
                level.gun_guns[ 3 ] = { #weaponcategory:"rand_smg" };
                level.gun_guns[ 4 ] = { #weaponcategory:"rand_sniper" };
                level.gun_guns[ 5 ] = { #weaponcategory:"rand_pistol" };
                level.gun_guns[ 6 ] = { #weaponcategory:"rand_lmg" };
                level.gun_guns[ 7 ] = { #weaponcategory:"rand_battle_rifle" };
                level.gun_guns[ 8 ] = { #weaponcategory:"rand_dmr" };
                level.gun_guns[ 9 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 10 ] = { #weaponcategory:"rand_smg" };
                level.gun_guns[ 11 ] = { #weaponcategory:"rand_battle_rifle" };
                level.gun_guns[ 12 ] = { #weaponcategory:"rand_dmr" };
                level.gun_guns[ 13 ] = { #weaponcategory:"rand_assault" };
                level.gun_guns[ 14 ] = { #weaponcategory:"rand_smg" };
                level.gun_guns[ 15 ] = { #weaponcategory:"rand_smg" };
                level.gun_guns[ 16 ] = { #weaponcategory:"rand_pistol" };
                level.gun_guns[ 17 ] = { #weaponcategory:"rand_knife_end" };
                break;
        }
        
        return;
    }
    
    level.gun_guns = level.gungameweapons.weaponlist;
}

// Namespace gun
// Params 0
// Checksum 0xce7ff5b6, Offset: 0x3285
// Size: 0x1bc
function setgunsfinal()
{
    level.selectedweapons = [];
    function_a412f4ddef3cec7d();
    
    for ( i = 0; i < level.gun_guns.size ; i++ )
    {
        curgun = level.gun_guns[ i ];
        
        if ( isstartstr( curgun.weaponcategory, "rand_" ) )
        {
            weapondata = function_a2141e5b0ed7b293( curgun.weaponcategory );
            
            if ( level.ladderindex == 4 || level.ladderindex == 5 )
            {
                level.gun_guns[ i ] = weapon::giveweaponblueprint( weapondata[ "weapon" ], weapondata[ "variantID" ] );
            }
            else
            {
                level.gun_guns[ i ] = function_d3f34a8855cf982f( weapondata );
            }
            
            continue;
        }
        
        rootname = weapon::getweaponrootname( level.gun_guns[ i ] );
        level.selectedweapons[ rootname ] = 1;
        newweapon = rootname;
        numattachments = 0;
        
        if ( level.ladderindex == 4 || level.ladderindex == 5 )
        {
            newweapon = weapon::buildweapon( rootname );
        }
        else
        {
            newweapon = gun_createrandomweapon( rootname, numattachments, undefined, utility::function_2a082dafe6f4bd5b() );
        }
        
        level.gun_guns[ i ] = newweapon;
    }
    
    level.selectedweapons = undefined;
    
    if ( level.gametype == "gun" )
    {
        level.scorelimit = level.gun_guns.size;
        level.roundscorelimit = level.gun_guns.size;
        level.totalscorelimit = level.gun_guns.size;
    }
}

// Namespace gun
// Params 0
// Checksum 0xe3f696de, Offset: 0x3449
// Size: 0x7
function getrandomarchetype()
{
    return "archetype_assault";
}

// Namespace gun
// Params 0
// Checksum 0x73a10250, Offset: 0x3459
// Size: 0x24c
function setspecialloadout()
{
    level.gun_loadouts[ "axis" ][ "loadoutPrimary" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutPrimaryAttachment" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutPrimaryCamo" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutPrimaryReticle" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutPrimaryVariantID" ] = 0;
    level.gun_loadouts[ "axis" ][ "loadoutSecondary" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutSecondaryAttachment" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutSecondaryCamo" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutSecondaryReticle" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutSecondaryVariantID" ] = 0;
    level.gun_loadouts[ "axis" ][ "loadoutEquipmentPrimary" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutEquipmentSecondary" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutOffhand" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutStreakType" ] = "assault";
    level.gun_loadouts[ "axis" ][ "loadoutKillstreak1" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutKillstreak2" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutKillstreak3" ] = "none";
    level.gun_loadouts[ "axis" ][ "loadoutPerks" ] = [];
    level.gun_loadouts[ "axis" ][ "loadoutGesture" ] = "playerData";
    level.gun_loadouts[ "allies" ] = level.gun_loadouts[ "axis" ];
}

// Namespace gun
// Params 0
// Checksum 0xb1ff9aa3, Offset: 0x36ad
// Size: 0x1ba
function function_a8cd98b9646d71cd()
{
    level.weaponcategories = [];
    
    for ( row = 0; true ; row++ )
    {
        categoryname = tablelookupbyrow( "mp/gunGameWeapons.csv", row, 0 );
        
        if ( categoryname == "" )
        {
            break;
        }
        
        if ( !isdefined( level.weaponcategories[ categoryname ] ) )
        {
            level.weaponcategories[ categoryname ] = [];
        }
        
        requiredpack = tablelookupbyrow( "mp/gunGameWeapons.csv", row, 5 );
        
        if ( requiredpack == "" || getdvarint( requiredpack, 0 ) == 1 )
        {
            data = [];
            data[ "weapon" ] = weapon::getweaponrootname( tablelookupbyrow( "mp/gunGameWeapons.csv", row, 1 ) );
            data[ "min" ] = int( tablelookupbyrow( "mp/gunGameWeapons.csv", row, 2 ) );
            data[ "max" ] = int( tablelookupbyrow( "mp/gunGameWeapons.csv", row, 3 ) );
            data[ "perk" ] = tablelookupbyrow( "mp/gunGameWeapons.csv", row, 4 );
            
            if ( level.ladderindex == 4 || level.ladderindex == 5 )
            {
                if ( !isdefined( game[ "arenaWeaponCategories" ] ) )
                {
                    level.arenaloadouts = 13;
                    arena::function_d49af0499dd7b945();
                }
                
                data[ "variantID" ] = arena::function_aaf3c5e13b8de8fd( data[ "weapon" ] );
            }
            
            data[ "allowed" ] = int( tablelookupbyrow( "mp/gunGameWeapons.csv", row, 7 ) );
            
            if ( ( level.ladderindex == 4 || level.ladderindex == 6 ) && !data[ "allowed" ] )
            {
                row++;
                continue;
            }
            
            level.weaponcategories[ categoryname ][ level.weaponcategories[ categoryname ].size ] = data;
        }
    }
}

// Namespace gun
// Params 0
// Checksum 0xe9f22bd1, Offset: 0x386f
// Size: 0x23c
function function_a412f4ddef3cec7d()
{
    level.weaponcategories = [];
    
    foreach ( ggweapondata in level.var_b26ea0a00e76e9ea.weaponsTable )
    {
        if ( !isdefined( level.weaponcategories[ ggweapondata.groupname ] ) )
        {
            level.weaponcategories[ ggweapondata.groupname ] = [];
        }
        
        data = [];
        data[ "weapon" ] = ggweapondata.baseweapon;
        data[ "min" ] = ggweapondata.minattachments;
        data[ "max" ] = ggweapondata.maxattachments;
        data[ "perk" ] = ggweapondata.bonusperk;
        
        if ( isdefined( ggweapondata.attachmentpresets ) )
        {
            data[ "attachments" ] = ggweapondata.attachmentpresets;
        }
        
        if ( level.useladderindex && ( level.ladderindex == 4 || level.ladderindex == 5 ) )
        {
            if ( !isdefined( game[ "arenaWeaponCategories" ] ) )
            {
                level.arenaloadouts = 13;
                arena::function_d49af0499dd7b945();
            }
            
            data[ "variantID" ] = arena::function_aaf3c5e13b8de8fd( data[ "weapon" ] );
        }
        else if ( level.ladderindex == 5 )
        {
            var_25d99aafdc05f3ba = ggweapondata.var_65cecf0dc22bc96e;
            data[ "variantID" ] = utility::get_random_variant_id( var_25d99aafdc05f3ba );
            data[ "attachments" ] = undefined;
        }
        
        data[ "allowed" ] = ggweapondata.var_8ac10d965f3e997a;
        
        if ( ( level.ladderindex == 4 || level.ladderindex == 6 ) && !data[ "allowed" ] )
        {
            continue;
        }
        
        level.weaponcategories[ ggweapondata.groupname ][ level.weaponcategories[ ggweapondata.groupname ].size ] = data;
    }
}

// Namespace gun
// Params 1
// Checksum 0x2ba52f69, Offset: 0x3ab3
// Size: 0x19f
function function_a2141e5b0ed7b293( categoryname )
{
    weaponlist = level.weaponcategories[ categoryname ];
    
    if ( isdefined( weaponlist ) && weaponlist.size > 0 )
    {
        newweapon = "";
        data = undefined;
        
        for ( loopcount = 0; true ; loopcount++ )
        {
            index = randomintrange( 0, weaponlist.size );
            data = weaponlist[ index ];
            rootname = weapon::getweaponrootname( data[ "weapon" ] );
            var_db5dd066600dce99 = 1;
            
            if ( level.ladderindex == 4 || level.ladderindex == 6 )
            {
                var_db5dd066600dce99 = data[ "allowed" ];
            }
            
            if ( isdefined( level.selectedweapons ) && !isdefined( level.selectedweapons[ rootname ] ) && var_db5dd066600dce99 || loopcount > weaponlist.size )
            {
                level.selectedweapons[ rootname ] = 1;
                
                for ( i = 0; i < level.weaponcategories[ categoryname ].size ; i++ )
                {
                    if ( level.weaponcategories[ categoryname ][ i ][ "weapon" ] == data[ "weapon" ] )
                    {
                        level.weaponcategories[ categoryname ][ i ] = undefined;
                        
                        if ( isint( i ) )
                        {
                            function_cdc669dbc8ea2101( level.weaponcategories[ categoryname ] );
                        }
                        
                        break;
                    }
                }
                
                break;
            }
        }
        
        return data;
    }
    
    assertmsg( "<dev string:x109>" + categoryname + "<dev string:x127>" + level.var_b26ea0a00e76e9ea );
    return "none";
}

// Namespace gun
// Params 1
// Checksum 0xeaaeb4d2, Offset: 0x3c5a
// Size: 0x57
function function_d3f34a8855cf982f( weapondata )
{
    numattachments = randomintrange( weapondata[ "min" ], weapondata[ "max" ] + 1 );
    newweapon = gun_createrandomweapon( weapondata[ "weapon" ], numattachments, weapondata[ "variantID" ], utility::function_2a082dafe6f4bd5b(), weapondata );
    return newweapon;
}

// Namespace gun
// Params 5
// Checksum 0x89ec4956, Offset: 0x3cba
// Size: 0x176
function gun_createrandomweapon( rootname, numattachments, variantid, hasnvg, weapondata )
{
    if ( ( !isdefined( numattachments ) || !getdvarint( @"hash_76d3386761ef7fb6", 0 ) ) && !level.var_f4b0dd42d71621b2 )
    {
        numattachments = 0;
    }
    
    var_ba7d2b302d6ae466 = weapon::buildweapon( rootname, undefined, undefined, undefined, variantid, undefined, undefined, undefined, hasnvg );
    var_9dcdad9d4b81bfc4 = [];
    
    if ( numattachments > 0 )
    {
        var_9dcdad9d4b81bfc4 = weapons::function_300b8e06e0756ba5( var_ba7d2b302d6ae466, numattachments, 0, undefined, 1000 );
    }
    else if ( isdefined( weapondata[ "attachments" ] ) && weapondata[ "attachments" ].size > 0 )
    {
        var_8044f9da5d35b66c = randomintrange( 0, weapondata[ "attachments" ].size );
        
        foreach ( var_6f1c3633937700db in weapondata[ "attachments" ][ var_8044f9da5d35b66c ].weaponattachments )
        {
            var_9dcdad9d4b81bfc4[ var_9dcdad9d4b81bfc4.size ] = var_6f1c3633937700db.attachment;
        }
    }
    
    if ( var_9dcdad9d4b81bfc4.size > 0 )
    {
        var_ba7d2b302d6ae466 = weapon::buildweapon( rootname, var_9dcdad9d4b81bfc4, undefined, undefined, variantid, undefined, undefined, undefined, hasnvg );
    }
    
    return var_ba7d2b302d6ae466;
}

// Namespace gun
// Params 1
// Checksum 0xc946f39d, Offset: 0x3e39
// Size: 0x74
function giveortakethrowingknife( currentweapon )
{
    equipment_mp::takeequipment( "primary" );
    
    if ( weapon_utility::isknifeonly( currentweapon ) )
    {
        perk::giveperk( "specialty_scavenger" );
        perk::giveperk( "specialty_pitcher" );
        throwingweapon = getmatchrulesdata( "gunData", "gunGameThrowingWeapon" ) ?? "equip_throwing_knife";
        equipment_mp::giveequipment( throwingweapon, "primary" );
        thread equipment_mp::incrementequipmentammo( throwingweapon );
    }
}

// Namespace gun
// Params 1
// Checksum 0x1d647835, Offset: 0x3eb5
// Size: 0x34, Type: bool
function isvalidthrowingknifekill( killweapon )
{
    if ( killweapon.basename == "throwingknife_mp" )
    {
        return true;
    }
    
    return killweapon.classname == "throwingknife";
}

// Namespace gun
// Params 1
// Checksum 0xd048d85d, Offset: 0x3ef2
// Size: 0x25, Type: bool
function checkcustomclosetoscorelimit( team )
{
    assert( isplayer( self ) );
    return self.score == 14;
}

// Namespace gun
// Params 5
// Checksum 0xccc24358, Offset: 0x3f20
// Size: 0x1ba
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
        
        assert( isint( originalpoints ) || isfloat( originalpoints ), "<dev string:xe3>" );
        
        if ( isdefined( player.pers[ "gamemodeScore" ] ) )
        {
            player.pers[ "gamemodeScore" ] = player.pers[ "gamemodeScore" ] + originalpoints;
        }
    }
    
    newscore = player.pers[ "gamemodeScore" ];
    player persistence::statsetchild( "round", "gamemodeScore", newscore );
    score = 0;
    
    if ( event == "gained_gun_rank" )
    {
        score = 1;
    }
    else if ( event == "dropped_gun_rank" )
    {
        setbackscore = level.setback;
        score = setbackscore * -1;
    }
    else if ( event == "assist_ffa" || event == "kill" )
    {
        player script::bufferednotify( "earned_score_buffered", originalpoints );
    }
    
    assert( isdefined( score ) );
    return score;
}

// Namespace gun
// Params 0
// Checksum 0x51caa1ae, Offset: 0x40e3
// Size: 0x54
function updateknivesperminute()
{
    if ( !isdefined( self.knivesperminute ) )
    {
        self.numknives = 0;
        self.knivesperminute = 0;
    }
    
    self.numknives++;
    
    if ( game_utility_mp::getminutespassed() < 1 )
    {
        return;
    }
    
    self.knivesperminute = self.numknives / game_utility_mp::getminutespassed();
}

// Namespace gun
// Params 5
// Checksum 0xb3a254a5, Offset: 0x413f
// Size: 0x91
function modifyunifiedpointscallback( points, event, player, objweapon, eventinfo )
{
    if ( isdefined( objweapon ) && ( objweapon.basename == "iw9_me_knife_mp" || objweapon.basename == "iw8_me_akimboblunt_mp" || objweapon.basename == "iw8_me_akimboblades_mp" ) )
    {
        if ( isdefined( player ) && player.knivesperminute >= 10 )
        {
            return 0;
        }
    }
    
    return points;
}

// Namespace gun
// Params 3
// Checksum 0xb123259d, Offset: 0x41d9
// Size: 0x18e, Type: bool
function canprogressingunrank( objweapon, baseprimary, isexecution )
{
    if ( isonlastkill() )
    {
        if ( level.var_b5d9e21ba11f0ba2 == #"all_kills_win" )
        {
            extra_info_0 = #"hash_c445d8168ebc5b8b";
            extra_info_1 = #"";
            extra_info_2 = #"";
            function_a46674787658909a( self, "gun_game_final_kill", extra_info_0, extra_info_1, extra_info_2 );
            return true;
        }
        
        if ( isexecution )
        {
            if ( level.var_b5d9e21ba11f0ba2 == #"executions_only" || level.var_b5d9e21ba11f0ba2 == #"throwing_knife_or_executions" )
            {
                extra_info_0 = #"hash_5afef0527584eab1";
                extra_info_1 = #"";
                extra_info_2 = #"";
                function_a46674787658909a( self, "gun_game_final_kill", extra_info_0, extra_info_1, extra_info_2 );
                return true;
            }
        }
        
        if ( isvalidthrowingknifekill( objweapon ) )
        {
            if ( level.var_b5d9e21ba11f0ba2 == #"throwing_knife_only" || level.var_b5d9e21ba11f0ba2 == #"throwing_knife_or_executions" )
            {
                extra_info_0 = #"hash_4aa4cfb553ad0ec";
                extra_info_1 = #"";
                extra_info_2 = #"";
                function_a46674787658909a( self, "gun_game_final_kill", extra_info_0, extra_info_1, extra_info_2 );
                return true;
            }
        }
        
        return false;
    }
    
    if ( objweapon.basename == baseprimary )
    {
        return true;
    }
    
    if ( objweapon.basename == "dragonsbreath_mp" )
    {
        return true;
    }
    
    return false;
}

// Namespace gun
// Params 0
// Checksum 0xb39b0d18, Offset: 0x4370
// Size: 0x19, Type: bool
function isonlastkill()
{
    return self.gungamegunindex == level.gun_guns.size - 1;
}

/#

    // Namespace gun
    // Params 0
    // Checksum 0xdcab18d1, Offset: 0x4392
    // Size: 0x391, Type: dev
    function function_21faf7f37b326725()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            rankup = getdvarint( @"scr_gun_rank_up", 0 );
            rankdown = getdvarint( @"scr_gun_rank_down", 0 );
            
            if ( rankup || rankdown )
            {
                foreach ( player in level.players )
                {
                    baseprimary = getweaponbasename( player.primaryweapon );
                    player.gungameprevgunindex = player.gungamegunindex;
                    updategun = 0;
                    
                    if ( rankup )
                    {
                        newrank = player.gungamegunindex + 1;
                        
                        if ( newrank >= level.gun_guns.size - 1 )
                        {
                            player iprintlnbold( "<dev string:x164>" );
                        }
                        else
                        {
                            player.gungamegunindex++;
                            updategun = 1;
                            player gamescore::giveplayerscore( #"gained_gun_rank", 1 );
                            points = rank::getscoreinfovalue( #"gained_gun_rank" );
                            player thread rank::scorepointspopup( points );
                            player thread rank::scoreeventpopup( #"gained_gun_rank" );
                            player gameplay_sound_fx::playlocalsoundfx( #"gun_rank_up" );
                        }
                        
                        setdvar( @"scr_gun_rank_up", 0 );
                    }
                    else
                    {
                        newrank = player.gungamegunindex - 1;
                        
                        if ( newrank < 0 )
                        {
                            player iprintlnbold( "<dev string:x199>" );
                        }
                        else
                        {
                            player.gungamegunindex--;
                            updategun = 1;
                            player thread rank::scoreeventpopup( #"dropped_gun_rank" );
                            player gamescore::giveplayerscore( #"dropped_gun_rank", 1 );
                            
                            if ( !( istrue( game[ "<dev string:x1cf>" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                            {
                                if ( isdefined( player.leaderboarddata[ "<dev string:x1dd>" ] ) )
                                {
                                    player.leaderboarddata[ "<dev string:x1dd>" ] = player.leaderboarddata[ "<dev string:x1dd>" ] + 1;
                                }
                                
                                if ( isdefined( level.leaderboardfunc[ "<dev string:x1dd>" ] ) )
                                {
                                    [[ level.leaderboardfunc[ "<dev string:x1dd>" ] ]]( player, 1 );
                                }
                                
                                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe3>" );
                                
                                if ( isdefined( player.pers[ "<dev string:x1dd>" ] ) )
                                {
                                    player.pers[ "<dev string:x1dd>" ] = player.pers[ "<dev string:x1dd>" ] + 1;
                                }
                            }
                            
                            player persistence::statsetchild( "<dev string:x1e6>", "<dev string:x1dd>", player.pers[ "<dev string:x1dd>" ] );
                            player gameplay_sound_fx::playlocalsoundfx( #"gun_rank_down" );
                            
                            if ( isplayer( player ) )
                            {
                                player stats::setextrascore1( player.pers[ "<dev string:x1dd>" ], "<dev string:x1dd>" );
                            }
                        }
                        
                        setdvar( @"scr_gun_rank_down", 0 );
                    }
                    
                    if ( updategun )
                    {
                        player notify( #"hash_f77fe48d346666e" );
                        player thread givenextgun( 0 );
                        player.lastgunrankincreasetime = gettime();
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace gun
    // Params 0
    // Checksum 0x3dc16df0, Offset: 0x472b
    // Size: 0x20, Type: dev
    function auto_rank_up()
    {
        while ( true )
        {
            wait 6;
            setdvar( @"scr_gun_rank_up", 1 );
        }
    }

#/

// Namespace gun
// Params 5
// Checksum 0xe1860cbf, Offset: 0x4753
// Size: 0xa8
function function_a46674787658909a( player, eventname, extra_info_0, extra_info_1, extra_info_2 )
{
    telemetry_data = {};
    telemetry_data.player = player;
    telemetry_data.eventname = eventname;
    telemetry_data.position = player.origin;
    telemetry_data.extra_info_0 = extra_info_0;
    telemetry_data.extra_info_1 = extra_info_1;
    telemetry_data.extra_info_2 = extra_info_2;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
}

