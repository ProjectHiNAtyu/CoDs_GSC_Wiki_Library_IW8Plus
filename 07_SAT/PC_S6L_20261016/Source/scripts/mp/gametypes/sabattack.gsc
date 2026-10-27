// scripts\mp\gametypes\sabattack.gsc  (hash_1c61ba7a2802002e.gscc) (size: 58914 Bytes / 0xe622 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb3cb11d0 (3016430032)
// size ...... 58914 (0xe622)
// includes .. 44  (offset: 0xd586)
// strings ... 196 (offset: 0xd6e6)
// dev strs .. 14  (offset: 0xe566)
// exports ... 124 (offset: 0x9016)
// cseg ...... 0xf4e + 0x80c8 (0x9016)
// imports ... 388 (offset: 0xa376)
// animtree1 . 0   (offset: 0xe622)
// animtree2 . 0   (offset: 0xe622)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\events;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\hq;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\telemetry_mp;

#namespace sabattack;

// Namespace sabattack
// Params 0
// Checksum 0xd6f9ff9, Offset: 0xf6c
// Size: 0x251
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
    level.onplayerconnect = &onplayerconnect;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onsuicidedeath = &onsuicidedeath;
    level.onnormaldeath = &onnormaldeath;
    level.var_b1c69282cd1f88ba = &function_b1c69282cd1f88ba;
    level.var_40cd999d911308e0 = &function_8d961c2c2caf232c;
    level.onrespawndelay = &getrespawndelay;
    level.modeonspawnplayer = &onspawnplayer;
    level.ontimelimit = &ontimelimit;
    level.onmaprestart = &function_e1ec3bde9690deed;
    level.var_9daab46fe497e39f = &function_6bb7ffffe1138817;
    level.nextroundisfinalround = &nextroundisfinalround;
    level.nextroundismatchpoint = &nextroundismatchpoint;
    level.wingamebytype = "teamScores";
    level.forcehalftime = 1;
    level.var_71e380fabc40f094 = 1;
    level.var_2c3e193d00dbfcea = "switching_sides";
    level callback::add( #"killstreak_begin_use", &function_21396bf10feb0abc );
    level callback::add( #"killstreak_finish_use", &on_killstreak_finish_use );
    level._effect[ "vfx_sat_sabotage_carry_vm" ] = loadfxasset( "vfx_sat_sabotage_carry_vm" );
    level._effect[ "vfx_sat_sabotage_carry_wm" ] = loadfxasset( "vfx_sat_sabotage_carry_wm" );
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
    
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    utility::registersharedfunc( #"gametype", #"hash_c0713b1d38d78d84", &function_3b47de6ef763f89 );
    level function_64313f41694d6fca();
    level thread initaudio();
    level thread function_7c6e4d2f6c576b01();
}

// Namespace sabattack
// Params 1, eflags: 0x4
// Checksum 0xecb7b91f, Offset: 0x11c5
// Size: 0x42
function private function_3b47de6ef763f89( player )
{
    if ( player == level.flagcarrier )
    {
        level.flagstate = "dropped";
        level notify( #"flag_state_changed" );
        player notify( #"flag_state_changed" );
    }
}

// Namespace sabattack
// Params 1, eflags: 0x4
// Checksum 0x191642e8, Offset: 0x120f
// Size: 0xfc
function private function_8314535b81f548e( deathdata )
{
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    
    if ( !victim.oob )
    {
        function_c99930779b5eece4( victim, attacker );
    }
    
    if ( victim == level.flagcarrier && level.var_dd42bed3367cf763 )
    {
        level ontimelimit();
    }
    
    if ( level.var_dbeaf99627787f48 )
    {
        var_c252f9bfd9ae6a57 = teams::getteamdata( victim.team, "aliveCount" );
        
        if ( var_c252f9bfd9ae6a57 == 0 )
        {
            winner = team_utility::getotherteam( victim.team );
            gamescore::giveteamscoreforobjective( winner, 1, 0, undefined, 1 );
            function_b030ab0585296a45( game[ "end_reason" ][ "mp_faction_eliminated" ], winner );
            return;
        }
        
        if ( var_c252f9bfd9ae6a57 == 1 )
        {
            victim sabattack_givelastonteamwarning();
        }
    }
}

// Namespace sabattack
// Params 0, eflags: 0x4
// Checksum 0xc6442cfb, Offset: 0x1313
// Size: 0xea
function private function_34601cc809766808()
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "sabattack_obj_kill_count" ] ) )
        {
            self.leaderboarddata[ "sabattack_obj_kill_count" ] = self.leaderboarddata[ "sabattack_obj_kill_count" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "sabattack_obj_kill_count" ] ) )
        {
            [[ level.leaderboardfunc[ "sabattack_obj_kill_count" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( self.pers[ "sabattack_obj_kill_count" ] ) )
        {
            self.pers[ "sabattack_obj_kill_count" ] = self.pers[ "sabattack_obj_kill_count" ] + 1;
        }
    }
    
    stats::setextrascore1( self.pers[ "sabattack_obj_kill_count" ] );
}

// Namespace sabattack
// Params 0
// Checksum 0x3a405e1a, Offset: 0x1405
// Size: 0x9
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
}

// Namespace sabattack
// Params 0
// Checksum 0xcd374c59, Offset: 0x1416
// Size: 0x260
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
        level.var_c1ac9852af29ae0 = 1;
        level.var_dd42bed3367cf763 = 0;
        
        if ( level.allowSuddenDeath )
        {
            level thread function_3327783ff0ce3137();
        }
        
        function_5fccb9ced4bc291();
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
    }
    else
    {
        initspawns();
    }
    
    level.roundkills[ game[ "attackers" ] ] = 0;
    level.roundkills[ game[ "defenders" ] ] = 0;
    self.var_7a8784dd3bfbf9a2 = 0;
    
    if ( !game[ "sabattack_dlogs" ] )
    {
        game[ "sabattack_dlogs" ] = {};
        thread function_d239cda79ff15a4e();
    }
    else
    {
        game[ "sabattack_dlogs" ].var_c8eddfcfab3ad0b0 = "neutral";
    }
    
    thread function_10ed552162ebaaef();
    thread function_299b18c42e582337();
    thread function_79f8f7423a17d1fd( -2 );
    setomnvar( "ui_allies_no_respawn", 0 );
    setomnvar( "ui_axis_no_respawn", 0 );
    
    if ( game_utility_mp::inovertime() || game_utility_mp::intimetobeat() )
    {
        setomnvar( "ui_scorelimit", game_utility_mp::istimetobeatvalid() ? game[ "timeToBeatScore" ] : 1 );
        setomnvar( "ui_show_time_to_beat", 1 );
    }
    
    setomnvar( "ui_sabattack_sudden_death", 1 );
    setomnvar( "ui_sabattack_sudden_death", 0 );
}

// Namespace sabattack
// Params 0
// Checksum 0x98814c28, Offset: 0x167e
// Size: 0x576
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.activeCarrierOvertime = getdvarint( @"hash_550053e61167bc59", getmatchrulesdata( "sabattackData", "activeCarrierOvertime" ) );
    level.activeCarrierExtraTime = getdvarint( @"hash_800603bdcca090c", getmatchrulesdata( "sabattackData", "activeCarrierExtraTime" ) );
    level.forceCarrierPistol = getdvarint( @"hash_1beddd44ada96d12", getmatchrulesdata( "sabattackData", "forceCarrierPistol" ) );
    level.pausemodetimer = getdvarint( @"hash_2481d2fe07c1e737", getmatchrulesdata( "kothData", "pauseTime" ) );
    level.overtime = getmatchrulesdata( "sabattackData", "sabattackOvertime" );
    level.var_94539d0656590c27 = getdvarint( @"hash_54cfb12d4cf3ce13", 1 );
    level.var_a87e29ac2a1a3444 = getdvarint( @"hash_faaf665f9f72de3", 0 );
    level.flagRandomizeOrder = getdvarint( @"hash_59825d64bfd98ad4", getmatchrulesdata( "sabattackData", "flagRandomizeOrder" ) );
    level.showFlagOnPlayer = getdvarint( @"hash_c24535eafd821560", getmatchrulesdata( "sabattackData", "showFlagOnPlayer" ) );
    level.flagRespawnType = getdvarint( @"scr_sabattack_flag_respawn_behavior", getmatchrulesdata( "sabattackData", "flagRespawnType" ) );
    level.flagResetType = getdvarint( @"hash_a6e9d8a36fb20f19", getmatchrulesdata( "sabattackData", "flagResetType" ) );
    level.objpingdelay = getdvarfloat( @"hash_804b58c9453cb329", getmatchrulesdata( "sabattackData", "carrierPingDelay" ) );
    level.var_9846a3db6f6a3006 = getdvarint( @"hash_964b135eab5a936e", getmatchrulesdata( "sabattackData", "giveCarrierRadarPing" ) );
    level.flagRespawnTime = getmatchrulesdata( "sabattackData", "flagRespawnTime" );
    level.flagResetTime = getdvarint( @"scr_sabattack_flag_reset_time", getmatchrulesdata( "sabattackData", "flagResetTime" ) );
    level.var_f957b56c9eb2da0e = min( getmatchrulesdata( "sabattackData", "flagResetWarning" ), level.flagResetTime );
    level.flagResetOOB = getdvarint( @"hash_978ace87b1a39cbd", getmatchrulesdata( "sabattackData", "flagResetOOB" ) );
    level.flagResetOOBPenaltyTime = getdvarint( @"hash_fffc2f05f845962d", getmatchrulesdata( "sabattackData", "flagResetOOBPenaltyTime" ) );
    level.allowCarrierVFX = getdvarint( @"hash_672c631dc4d94888", getmatchrulesdata( "sabattackData", "allowCarrierVFX" ) );
    level.allowCarrierOutlines = getdvarint( @"hash_27bfee9553b2aa3", getmatchrulesdata( "sabattackData", "allowCarrierOutlines" ) );
    level.zonecapturescore = getmatchrulesdata( "sabattackData", "captureScore" );
    level.zoneHideOnNeutral = getdvarint( @"hash_ec1ea17db7eeb803", getmatchrulesdata( "sabattackData", "zoneHideOnNeutral" ) );
    level.zoneEMPEffect = getdvarint( @"hash_4385cd79102762ad", getmatchrulesdata( "sabattackData", "zoneEMPEffect" ) );
    level.zoneEMPScrambleIntensity = getdvarint( @"hash_ac3d9f2a93f7bc1b", getmatchrulesdata( "sabattackData", "zoneEMPScrambleIntensity" ) );
    level.zoneEMPDuration = getdvarfloat( @"hash_2a34335aa6669e36", getmatchrulesdata( "sabattackData", "zoneEMPDuration" ) );
    level.var_ed5e3594465c7efc = getmatchrulesdata( "sabattackData", "zoneEMPRange" );
    level.suddenDeathAUAV = getdvarint( @"hash_9afa1470922b8db2", getmatchrulesdata( "sabattackData", "suddenDeathAUAV" ) );
    level.allowSuddenDeath = getdvarint( @"hash_f65d80372ec96654", getmatchrulesdata( "sabattackData", "allowSuddenDeath" ) );
    level.suddenDeathScoreDiff = getdvarint( @"hash_1d1bd7f7411db1bf", getmatchrulesdata( "sabattackData", "suddenDeathScoreDiff" ) );
    level.var_28c129113dbf6ccf = getdvarint( @"hash_3d17535767aa57dc", getmatchrulesdata( "sabattackData", "allowTTB" ) );
    game_utility_mp::setovertimelimitdvar( getdvarint( @"hash_dcdeda6c76be7214", getmatchrulesdata( "sabattackData", "ttbTime" ) ) );
    level.var_16f41764c4fab65c = getdvarint( @"hash_7fefb7158101b7d3", getmatchrulesdata( "sabattackData", "ttbRoundCount" ) );
    level.var_dfca4b32020d8029 = getdvarint( @"hash_d18154a452079555", getmatchrulesdata( "sabattackData", "antiStall" ) );
    level.var_2f94f6cd8fbda1d7 = getdvarint( @"hash_4346a9ae4766ef9", 10 );
    level.var_2879696b36d50c54 = level.var_2f94f6cd8fbda1d7 * 1000;
    level.var_82e85a0f5c559b2b = getdvarint( @"hash_6987d6aec62e2d41", 0 );
    level.var_d6fa458e88929c45 = getdvarint( @"hash_5f825433cfba947a", 0 );
    level.var_c187869cc791af04 = getdvarint( @"hash_2b61248d2f24893d", 0 );
    level.var_b3771cb2c2c65592 = getdvarfloat( @"hash_b9a9c5cbb9555295", 0 );
    level.var_63dcf652e83b7179 = [];
    level.jipscorelimit = getdvarint( @"hash_5f4abe7e01ef54e", 3 );
    level.jiptimelimit = getdvarint( @"hash_f5e1bc5662eb364d", 180 );
    
    if ( level.var_28c129113dbf6ccf && level.allowSuddenDeath )
    {
        level.var_28c129113dbf6ccf = 0;
        assertmsg( "<dev string:x4a>" );
    }
    
    level.var_5282f6a475fe8220 = getdvarint( @"scr_sabattack_manual_drop", getmatchrulesdata( "carryData", "manualDropEnabled" ) );
}

// Namespace sabattack
// Params 0
// Checksum 0x3ca33ca4, Offset: 0x1bfc
// Size: 0x1ba
function initspawns()
{
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    spawnlogic::function_3a25709674572ad6( #"start", #"start_attackers", spawnkey, spawnlogic::function_61ba521db28762a7(), game[ "attackers" ], 1 );
    spawnlogic::function_3a25709674572ad6( #"start", #"start_defenders", spawnkey, spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ], 1 );
    var_e118b5270b7db352 = [ "zoneA_unlocked", "zoneA_locked", "zoneB_unlocked", "zoneB_locked" ];
    var_540375a0f1234755 = [ #"zonea_unlocked_attackers", #"zonea_locked_attackers", #"zoneb_unlocked_attackers", #"zoneb_locked_attackers" ];
    spawnlogic::function_1a2e309f5ceed01c( #"primary", #"primary_attackers", var_540375a0f1234755, spawnkey, "attacker", var_e118b5270b7db352, game[ "attackers" ], 1 );
    var_88cf7607bd1201ee = [ "zoneA_unlocked", "zoneA_locked", "zoneB_unlocked", "zoneB_locked" ];
    var_72ec1c4fb7641fd9 = [ #"zonea_unlocked_defenders", #"zonea_locked_defenders", #"zoneb_unlocked_defenders", #"zoneb_locked_defenders" ];
    spawnlogic::function_1a2e309f5ceed01c( #"primary", #"primary_defenders", var_72ec1c4fb7641fd9, spawnkey, "defender", var_88cf7607bd1201ee, game[ "defenders" ], 1 );
    spawnlogic::finalizemap();
}

// Namespace sabattack
// Params 0
// Checksum 0x76008ffb, Offset: 0x1dbe
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace sabattack
// Params 1
// Checksum 0x66c70ee9, Offset: 0x1dd0
// Size: 0x7b
function onplayerconnect( player )
{
    player setclientomnvar( "ui_hud_carried_item_index", 3 );
    player setclientomnvar( "ui_hud_carried_item_count", 0 );
    player.sabattack_firstspawn = 1;
    player stats::setextrascore0( player.pers[ "overcharge_count" ] ?? 0, "overcharge_count" );
    player stats::setextrascore1( player.pers[ "sabattack_obj_kill_count" ] ?? 0, "sabattack_obj_kill_count" );
}

// Namespace sabattack
// Params 1
// Checksum 0x63b162f9, Offset: 0x1e53
// Size: 0x5c
function onplayerdisconnect( player )
{
    player function_af496cff2a931ca3();
    
    if ( player == level.flagcarrier )
    {
        level.flagstate = "dropped";
        level notify( #"flag_state_changed" );
        setomnvar( "ui_sabattack_anti_stall", 0 );
    }
    
    if ( level.var_dbeaf99627787f48 )
    {
        thread function_a7565235a4c3df67();
    }
}

// Namespace sabattack
// Params 1
// Checksum 0xbd1d0382, Offset: 0x1eb7
// Size: 0x113
function onspawnplayer( spawndata )
{
    self setclientomnvar( "ui_hud_carried_item_count", 0 );
    self.var_ff37a8d694120230 = undefined;
    self function_3181733c19782bcc( 1 );
    self function_134cd2c60d3a7edf( 1 );
    
    if ( level.var_dbeaf99627787f48 )
    {
        thread function_e13b51079f8e4e0d();
        level thread function_a7565235a4c3df67();
    }
    
    if ( self.var_5ca4ed51593cd9a9 )
    {
        forceclearvfx();
    }
    
    if ( !self.sabattack_firstspawn )
    {
        return;
    }
    
    if ( game_utility_mp::inovertime() || game_utility_mp::intimetobeat() )
    {
        self setclientomnvar( "ui_friendly_time_to_beat", self.team == game[ "timeToBeatTeam" ] ? game[ "timeToBeat" ] : game[ "timeToBeatOld" ] );
        self setclientomnvar( "ui_enemy_time_to_beat", self.team != game[ "timeToBeatTeam" ] ? game[ "timeToBeat" ] : game[ "timeToBeatOld" ] );
        
        if ( level.codcasterenabled )
        {
            codcaster_utils::function_c2c643e0ac6e6a6( game[ "timeToBeatTeam" ], game[ "timeToBeat" ], game[ "timeToBeatOld" ] );
        }
    }
    
    self.sabattack_firstspawn = 0;
}

// Namespace sabattack
// Params 1
// Checksum 0xb0b40531, Offset: 0x1fd2
// Size: 0x11d
function onsuicidedeath( victim )
{
    if ( victim )
    {
        victim stoploopsound( #"hash_e231d9adc5bd23b0" );
        
        if ( victim == level.flagcarrier )
        {
            shouldreset = victim.lastattacker.classname == "trigger_hurt" || victim.forcereset;
            level.flagstate = shouldreset && level.flagResetOOB ? "reset" : "dropped";
            level.var_5ed907a605f62563 = level.flagstate == "reset" && level.flagResetOOBPenaltyTime > 0 ? 1 : 0;
            
            if ( level.flagstate == "reset" )
            {
                level function_57af2e919b37686c();
            }
            
            level notify( #"flag_state_changed" );
            victim hud_message::clearsplashqueue();
            victim hud_message::function_cb764616620ad77();
            
            if ( level.var_dd42bed3367cf763 )
            {
                level ontimelimit();
            }
        }
    }
    
    if ( level.var_dbeaf99627787f48 )
    {
        thread function_a7565235a4c3df67();
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x3f769b51, Offset: 0x20f7
// Size: 0x9e
function function_3c2004899d2a57c7()
{
    level.flagstate = "reset";
    level.var_5ed907a605f62563 = level.flagResetOOBPenaltyTime > 0 ? 1 : 0;
    level function_57af2e919b37686c();
    function_c14570348203e217();
    thread function_9487c9bc98d4cc91( #"hash_2637d97757bf15f5", game[ "defenders" ] );
    thread function_9487c9bc98d4cc91( #"hash_2637d97757bf15f5", game[ "attackers" ] );
    thread function_79f8f7423a17d1fd( -1 );
    self.var_9311dede1535ffac = undefined;
    self.manualdrop = undefined;
    setomnvar( "ui_sabattack_anti_stall", 0 );
    level notify( #"flag_state_changed" );
}

// Namespace sabattack
// Params 6
// Checksum 0xac03bd23, Offset: 0x219d
// Size: 0xd6
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( victim )
    {
        victim stoploopsound( #"hash_e231d9adc5bd23b0" );
        
        if ( isdefined( victim.carryflag ) )
        {
            victim detach( victim.carryflag, "tag_stowed_back3" );
            victim.carryflag = undefined;
        }
        
        if ( victim == level.flagcarrier )
        {
            victim hud_message::clearsplashqueue();
            victim hud_message::function_cb764616620ad77();
            
            if ( level.var_dd42bed3367cf763 )
            {
                level ontimelimit();
            }
        }
    }
    
    if ( level.var_dbeaf99627787f48 )
    {
        thread function_a7565235a4c3df67();
    }
}

// Namespace sabattack
// Params 0
// Checksum 0xf4517822, Offset: 0x227b
// Size: 0x15
function function_b1c69282cd1f88ba()
{
    if ( level.var_dbeaf99627787f48 )
    {
        thread function_a7565235a4c3df67();
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x5e580fd, Offset: 0x2298
// Size: 0x13
function getrespawndelay()
{
    return level.var_dbeaf99627787f48 ? 0 : undefined;
}

// Namespace sabattack
// Params 0
// Checksum 0x9aceb989, Offset: 0x22b4
// Size: 0xd7
function forceclearvfx()
{
    if ( self.var_5ca4ed51593cd9a9 )
    {
        stopfxontagforclients( utility::getfx( "vfx_sat_sabotage_carry_vm" ), self.var_5ca4ed51593cd9a9, "tag_origin", self );
        vfxwm = utility::getfx( "vfx_sat_sabotage_carry_wm" );
        
        foreach ( player in level.players )
        {
            stopfxontagforclients( vfxwm, self.var_5ca4ed51593cd9a9, "tag_origin", player );
        }
        
        self.var_5ca4ed51593cd9a9 delete();
    }
}

// Namespace sabattack
// Params 0
// Checksum 0xf74d131d, Offset: 0x2393
// Size: 0x2a3
function ontimelimit()
{
    var_b48628a5f615444a = game[ "teamScores" ][ "axis" ] == game[ "teamScores" ][ "allies" ];
    scorediff = function_e84ecccbc50e4a9();
    
    if ( !isdefined( level.extratime ) )
    {
        level.extratime = 0;
    }
    
    if ( activeCarrierOvertime( scorediff ) )
    {
        level notify( #"hash_4c181b8bef7da5ae" );
        level.var_dd42bed3367cf763 = 1;
        level.extratime = level.activeCarrierExtraTime;
        level thread overtimealert();
        return;
    }
    
    if ( !level.var_c1ac9852af29ae0 )
    {
        level.var_9d3d25e9b6e37d4b = 1;
        thread gamelogic_mp::endgame( "halftime", game[ "end_reason" ][ "time_limit_reached" ] );
        level thread halftimedialog();
        return;
    }
    
    if ( !level.var_dbeaf99627787f48 )
    {
        if ( scorediff >= level.suddenDeathScoreDiff )
        {
            function_b030ab0585296a45( game[ "end_reason" ][ "time_limit_reached" ] );
            return;
        }
        else
        {
            if ( !level.allowSuddenDeath )
            {
                function_b030ab0585296a45( game[ "end_reason" ][ "time_limit_reached" ] );
                return;
            }
            
            var_21742735d847b22b = 0;
            
            if ( level.var_dd42bed3367cf763 )
            {
                timeremaining = gamelogic_mp::gettimeremaining();
                var_21742735d847b22b = level.activeCarrierExtraTime - int( timeremaining / 1000 );
            }
            
            level.extratime = level.overtime + var_21742735d847b22b;
            level.var_dbeaf99627787f48 = 1;
            level.var_dd42bed3367cf763 = 0;
            level function_2107ac1a3622cc93( level.extratime, scorediff );
            return;
        }
        
        return;
    }
    
    if ( !var_b48628a5f615444a )
    {
        function_b030ab0585296a45( game[ "end_reason" ][ "time_limit_reached" ] );
        return;
    }
    
    axislives = teams::getteamdata( "axis", "aliveCount" );
    allieslives = teams::getteamdata( "allies", "aliveCount" );
    
    if ( axislives != allieslives )
    {
        winner = axislives > allieslives ? "axis" : "allies";
        gamescore::giveteamscoreforobjective( winner, 1, 0, undefined, 1 );
        function_b030ab0585296a45( game[ "end_reason" ][ "time_limit_reached" ], winner );
    }
    
    if ( isdefined( level.flagcarrier ) )
    {
        gamescore::giveteamscoreforobjective( level.flagcarrier.team, 1, 0, undefined, 1 );
        function_b030ab0585296a45( game[ "end_reason" ][ "time_limit_reached" ], level.flagcarrier.team );
        return;
    }
    
    function_b030ab0585296a45( game[ "end_reason" ][ "time_limit_reached" ] );
    return;
}

// Namespace sabattack
// Params 0
// Checksum 0xe95a2467, Offset: 0x263e
// Size: 0xf5
function overtimealert()
{
    foreach ( player in level.players )
    {
        otsplash = player.team == level.flagcarrier.team ? #"hash_8b957c6c06b429e6" : #"hash_e1c55987eeda391c";
        player hud_message::function_78fedf6f526825f4( otsplash, level.gametypebundle.var_e662dd7f27d462eb );
        
        if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
        {
            continue;
        }
        
        player dialog::leaderdialogonplayer( "overtime" );
    }
}

// Namespace sabattack
// Params 1
// Checksum 0xe5f88e1e, Offset: 0x273b
// Size: 0x107
function activeCarrierOvertime( scorediff )
{
    var_4d4d736583fb034f = game_utility_mp::inovertime() || game_utility_mp::intimetobeat();
    
    if ( var_4d4d736583fb034f )
    {
        return 0;
    }
    
    if ( level.activeCarrierOvertime && level.flagcarrier && !level.var_dd42bed3367cf763 )
    {
        winner = game[ "teamScores" ][ "axis" ] > game[ "teamScores" ][ "allies" ] ? "axis" : "allies";
        var_87ab411d2af0bd55 = level.flagcarrier.team == winner;
        var_386152ddb5cb1f72 = scorediff <= level.suddenDeathScoreDiff;
        
        if ( !level.var_c1ac9852af29ae0 )
        {
            return 1;
        }
        else if ( !level.allowSuddenDeath && !var_87ab411d2af0bd55 )
        {
            return var_386152ddb5cb1f72;
        }
        else if ( var_386152ddb5cb1f72 && !var_87ab411d2af0bd55 )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace sabattack
// Params 1
// Checksum 0x5fb20d7b, Offset: 0x284a
// Size: 0x119
function function_6bb7ffffe1138817( team )
{
    var_4d4d736583fb034f = game_utility_mp::inovertime() || game_utility_mp::intimetobeat();
    
    if ( game[ "overtimeRoundsPlayed" ] == 1 && var_4d4d736583fb034f )
    {
        if ( game_utility_mp::istimetobeatrulegametype() )
        {
            winner = team_utility::getotherteam( self.ownerteam );
            function_b030ab0585296a45( game[ "end_reason" ][ "time_limit_reached" ], winner );
        }
        
        return;
    }
    
    if ( level.nukeinfo.detonated || level.forfeitinprogress || level.hostforcedend )
    {
        return 0;
    }
    
    if ( !level.var_c1ac9852af29ae0 )
    {
        endreason = level.var_9d3d25e9b6e37d4b ? game[ "end_reason" ][ "time_limit_reached" ] : game[ "end_reason" ][ "score_limit_reached" ];
        level thread gamelogic_mp::endgame_regularmp( "halftime", endreason, undefined, undefined, undefined );
        level thread halftimedialog();
        return;
    }
    
    function_b030ab0585296a45( game[ "end_reason" ][ "score_limit_reached" ] );
}

// Namespace sabattack
// Params 0
// Checksum 0xa31e4b7d, Offset: 0x296b
// Size: 0x9d
function halftimedialog()
{
    wait 0.5;
    
    foreach ( player in level.players )
    {
        if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
        {
            continue;
        }
        
        player dialog::leaderdialogonplayer( "halftime" );
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x57a640fd, Offset: 0x2a10
// Size: 0x3, Type: bool
function nextroundisfinalround()
{
    return false;
}

// Namespace sabattack
// Params 0
// Checksum 0x87a07ede, Offset: 0x2a1c
// Size: 0x3, Type: bool
function nextroundismatchpoint()
{
    return false;
}

// Namespace sabattack
// Params 0
// Checksum 0x2a355866, Offset: 0x2a28
// Size: 0x9
function function_e1ec3bde9690deed()
{
    codcasterclientmatchdata::function_1340113cb5a43c2c();
}

// Namespace sabattack
// Params 0
// Checksum 0x483deb9a, Offset: 0x2a39
// Size: 0x47
function function_7c6e4d2f6c576b01()
{
    level endon( #"game_ended" );
    level endon( #"hash_ec29001269f7bfb5" );
    level waittill( #"matchstarttimer_done" );
    
    if ( level.jiptimelimit >= 0 )
    {
        wait level.jiptimelimit;
        level function_a14deb691144654e();
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x49f31372, Offset: 0x2a88
// Size: 0x20
function function_a14deb691144654e()
{
    canceljoins();
    setnojipscore( 1 );
    setnojiptime( 1 );
    level.nojip = 1;
}

// Namespace sabattack
// Params 0
// Checksum 0x6dba4c8c, Offset: 0x2ab0
// Size: 0x18
function function_5fccb9ced4bc291()
{
    setnojipscore( 0 );
    setnojiptime( 0 );
    level.nojip = 0;
}

// Namespace sabattack
// Params 2
// Checksum 0x4c5ad7d2, Offset: 0x2ad0
// Size: 0x9d
function function_b030ab0585296a45( endreason, otwinner )
{
    if ( isdefined( otwinner ) )
    {
        level thread gamelogic_mp::endgame_regularmp( otwinner, endreason, undefined, undefined, undefined );
    }
    
    winner = "tie";
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    
    if ( axisscore > alliesscore )
    {
        winner = "axis";
    }
    else if ( axisscore < alliesscore )
    {
        winner = "allies";
    }
    
    level thread gamelogic_mp::endgame_regularmp( winner, endreason, undefined, undefined, undefined );
}

// Namespace sabattack
// Params 0
// Checksum 0x7c127856, Offset: 0x2b75
// Size: 0x51, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ game[ "defenders" ] ] );
    alliesscore = int( game[ "teamScores" ][ game[ "attackers" ] ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

// Namespace sabattack
// Params 0, eflags: 0x4
// Checksum 0x6e97657d, Offset: 0x2bcf
// Size: 0x1b
function private initaudio()
{
    level endon( #"game_ended" );
    waittillframeend();
    audio_utility::snd_transient_load( "mp_gametype_sabattack_sat" );
}

// Namespace sabattack
// Params 2
// Checksum 0x58f2125d, Offset: 0x2bf2
// Size: 0x213
function function_2107ac1a3622cc93( extratime, scorediff )
{
    if ( level.suddenDeathAUAV )
    {
        uav::uav_setteamradarstrength( "axis", getuavstrengthlevelshowenemydirectional() );
        uav::uav_setteamradarstrength( "allies", getuavstrengthlevelshowenemydirectional() );
    }
    
    foreach ( player in level.players )
    {
        player.waitingtospawn = undefined;
        player thread playerlogic::waittillcanspawnclient( 1 );
    }
    
    wait 0.5;
    setomnvar( "ui_sabattack_sudden_death", 1 );
    codcaster_utils::function_3038b6eafc46c037( 27 );
    
    if ( scorediff == 0 )
    {
        function_530ae183b7838bb1( "axis" );
        function_530ae183b7838bb1( "allies" );
    }
    else
    {
        level.var_6722b55d551af835 = game[ "teamScores" ][ "axis" ] > game[ "teamScores" ][ "allies" ] ? "axis" : "allies";
        losingteam = team_utility::getotherteam( level.var_6722b55d551af835 );
        function_530ae183b7838bb1( losingteam );
    }
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) && player::isreallyalive( player ) )
        {
            player thread function_e13b51079f8e4e0d();
        }
    }
    
    thread function_9487c9bc98d4cc91( #"hash_e8445d3e889fa705", game[ "defenders" ] );
    thread function_9487c9bc98d4cc91( #"hash_e8445d3e889fa705", game[ "attackers" ] );
    thread function_a7565235a4c3df67();
}

// Namespace sabattack
// Params 0
// Checksum 0xb1676194, Offset: 0x2e0d
// Size: 0xe9
function function_e13b51079f8e4e0d()
{
    self notify( #"hash_d4d3345d29b7d37a" );
    self endon( #"hash_d4d3345d29b7d37a" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( level.suddenDeathAUAV )
    {
        thread suddenDeathAUAV();
    }
    
    if ( self.var_b8b7e2b1e7a5a7a0 )
    {
        return;
    }
    
    dialog::leaderdialogonplayer( #"sudden_death" );
    var_19be58d99cfe82e = self.team == level.var_6722b55d551af835 ? #"hash_21c74c7a567a2a72" : #"hash_5f94eb6df8452936";
    hud_message::function_78fedf6f526825f4( var_19be58d99cfe82e, level.gametypebundle.var_e662dd7f27d462eb );
    self.var_b8b7e2b1e7a5a7a0 = 1;
    wait 0.5;
    hud_message::function_78fedf6f526825f4( #"hash_f4fc8f557abe13d2", level.gametypebundle.var_e662dd7f27d462eb );
}

// Namespace sabattack
// Params 0
// Checksum 0xc7ae455a, Offset: 0x2efe
// Size: 0x46
function suddenDeathAUAV()
{
    self notify( #"hash_65bb91d4a67baddb" );
    self endon( #"hash_65bb91d4a67baddb" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        triggeroneoffradarsweep( self, 1000 );
        wait 1;
    }
}

// Namespace sabattack
// Params 0
// Checksum 0xbcc425f8, Offset: 0x2f4c
// Size: 0x65
function sabattack_givelastonteamwarning()
{
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_teammate_alive_callout", self, self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_enemy_alive_callout", self, otherteam );
    level notify( #"last_alive", self );
}

// Namespace sabattack
// Params 1
// Checksum 0xe277db6e, Offset: 0x2fb9
// Size: 0x61
function function_530ae183b7838bb1( team )
{
    teams::setteamdata( team, "noRespawns", 1 );
    
    if ( !isdefined( level.var_c6b02af9c0f45ca2 ) )
    {
        level.var_c6b02af9c0f45ca2 = [];
    }
    
    level.var_c6b02af9c0f45ca2[ team ] = gettime();
    setomnvar( "ui_" + team + "_no_respawn", 1 );
    function_cae49d4fbe5ead63( team );
}

// Namespace sabattack
// Params 1
// Checksum 0xf6e40dee, Offset: 0x3022
// Size: 0xac
function function_cae49d4fbe5ead63( team )
{
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        player thread hq::showrespawnwarningmessage();
    }
    
    dialog::statusdialog( #"team_no_lives", team, "lives" );
}

// Namespace sabattack
// Params 0, eflags: 0x4
// Checksum 0x59723d0b, Offset: 0x30d6
// Size: 0x69
function private function_3327783ff0ce3137()
{
    level endon( #"game_ended" );
    level endon( #"hash_4c181b8bef7da5ae" );
    
    while ( gamelogic_mp::gettimeremaining() / 1000 >= 10 )
    {
        level waittill( #"match_ending_very_soon" );
    }
    
    scorediff = function_e84ecccbc50e4a9();
    
    if ( scorediff < level.suddenDeathScoreDiff )
    {
        thread hud_util::showsplashtoall( "sabattack_flag_sudden_death_warning_splash", 10 );
    }
}

// Namespace sabattack
// Params 1
// Checksum 0x7616853a, Offset: 0x3147
// Size: 0x16b
function function_255652fc7d46d8f3( rewardteam )
{
    if ( rewardteam == level.var_6722b55d551af835 )
    {
        function_b030ab0585296a45( game[ "end_reason" ][ "score_limit_reached" ] );
        return;
    }
    
    scorediff = function_e84ecccbc50e4a9();
    winner = game[ "teamScores" ][ "axis" ] > game[ "teamScores" ][ "allies" ] ? "axis" : "allies";
    
    if ( scorediff == 0 )
    {
        wait 0.5;
        function_530ae183b7838bb1( level.var_6722b55d551af835 );
        players = teams::getteamdata( level.var_6722b55d551af835, "players" );
        
        foreach ( player in players )
        {
            player hud_message::function_78fedf6f526825f4( #"hash_ec4cd120fd1a8e9f", level.gametypebundle.var_e662dd7f27d462eb );
        }
    }
    
    if ( winner != level.var_6722b55d551af835 && scorediff > 0 )
    {
        function_b030ab0585296a45( game[ "end_reason" ][ "score_limit_reached" ] );
    }
}

// Namespace sabattack
// Params 0
// Checksum 0xe09a4efe, Offset: 0x32ba
// Size: 0x68
function function_a7565235a4c3df67()
{
    axisdata = teams::getteamdata( "axis", "aliveCount" );
    alliesdata = teams::getteamdata( "allies", "aliveCount" );
    setomnvar( "ui_allies_alive", alliesdata );
    setomnvar( "ui_axis_alive", axisdata );
    setomnvar( "ui_allies_lives_remaining", alliesdata );
    setomnvar( "ui_axis_lives_remaining", axisdata );
}

// Namespace sabattack
// Params 0, eflags: 0x4
// Checksum 0xc8b837a8, Offset: 0x332a
// Size: 0x139
function private function_299b18c42e582337()
{
    level endon( #"game_ended" );
    self.flagcarrier = undefined;
    self.flagstate = "unlocked";
    statebefore = undefined;
    flaglocation = function_fc2d3d457e25d10( 1 );
    flag_makepickup( flaglocation );
    thread flag_watchpickup();
    
    while ( true )
    {
        if ( self.flagstate == statebefore )
        {
            waitframe();
            continue;
        }
        
        statebefore = self.flagstate;
        
        switch ( self.flagstate )
        {
            case #"hash_7746a10b0d76f87c":
                flag_stateunlocked();
                break;
            case #"hash_fe5fa5c9d2a3157c":
                flag_statepickup();
                break;
            case #"hash_1fc80e465db6b005":
                flag_statedropped();
                break;
            case #"hash_1da4229a165378a0":
                flag_statereset();
                break;
            case #"hash_4f37b2e4955fbc1f":
                flag_statecaptured();
                break;
            default:
                /#
                    iprintlnbold( "<dev string:xa9>" );
                #/
                
                break;
        }
        
        if ( self.flagstate != "captured" )
        {
            level thread function_99240e28810e170a( self.flagstate );
        }
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x7da32f5b, Offset: 0x346b
// Size: 0x22
function flag_stateunlocked()
{
    game[ "sabattack_dlogs" ].var_c8eddfcfab3ad0b0 = "neutral";
    thread function_871edcd623d8244( 0, 0 );
}

// Namespace sabattack
// Params 0
// Checksum 0x717884f8, Offset: 0x3495
// Size: 0x9f
function flag_statepickup()
{
    function_68158179022acff2();
    var_4d4d736583fb034f = game_utility_mp::inovertime() || game_utility_mp::intimetobeat();
    
    if ( level.pausemodetimer && !var_4d4d736583fb034f )
    {
        level gamelogic_mp::pausetimer();
    }
    
    function_d962bac1591c693c();
    thread function_157531f98340ad();
    thread function_eed093f5030f08a6();
    thread function_871edcd623d8244( 2, 0 );
    thread function_9487c9bc98d4cc91( #"hash_52d40c9b4862fedc", game[ "defenders" ], self.flagcarrier );
    thread function_9487c9bc98d4cc91( #"hash_52d40c9b4862fedc", game[ "attackers" ], self.flagcarrier );
}

// Namespace sabattack
// Params 0
// Checksum 0x62f04a44, Offset: 0x353c
// Size: 0x180
function flag_statedropped()
{
    if ( self.flagcarrier )
    {
        thread hud_util::teamplayercardsplash( "sabattack_flag_dropped_splash", self.flagcarrier, undefined, undefined, 1 );
        
        if ( level.var_c187869cc791af04 )
        {
            otherteam = game_utility_mp::getotherteam( self.flagcarrier.team )[ 0 ];
            level thread function_7e2f4f34e9f6e6ec( "flag_drop", self.flagcarrier.team, "flag" );
            level thread function_7e2f4f34e9f6e6ec( "flag_drop_enemy", otherteam, "flag" );
        }
        
        if ( !level.var_a87e29ac2a1a3444 && self.var_680c481fb5a582c4 )
        {
            navmeshorigin = getclosestpointonnavmesh( self.flagcarrier.origin );
            
            if ( navmeshorigin )
            {
                self.var_680c481fb5a582c4.origin = navmeshorigin;
                self.var_680c481fb5a582c4.angles = ( 0, self.flagcarrier.angles[ 1 ], 0 );
            }
        }
        
        function_57af2e919b37686c();
    }
    
    function_e8ebfc9ce9486cfb();
    function_c14570348203e217();
    thread function_9487c9bc98d4cc91( #"hash_9b4911428a517ced", game[ "defenders" ] );
    thread function_9487c9bc98d4cc91( #"hash_9b4911428a517ced", game[ "attackers" ] );
    thread function_871edcd623d8244( 3, 0 );
    thread function_79f8f7423a17d1fd( -1 );
    self.var_9311dede1535ffac = undefined;
    self.manualdrop = undefined;
}

// Namespace sabattack
// Params 0
// Checksum 0x54d9d8be, Offset: 0x36c4
// Size: 0x14d
function flag_statereset()
{
    game[ "sabattack_dlogs" ].var_ea5ee11260856ef3 = undefined;
    function_68158179022acff2();
    level.var_f4d13777a227fce3 = undefined;
    
    if ( level.var_5ed907a605f62563 )
    {
        function_514552107a968cb5( 1 );
        endtime = int( gettime() + 1000 * ( level.flagResetOOBPenaltyTime + 1 ) );
        setomnvar( "ui_hardpoint_timer", endtime );
        function_c14570348203e217();
        wait level.flagResetOOBPenaltyTime;
        function_7862798ff616d461();
        level.var_5ed907a605f62563 = undefined;
    }
    
    flag_makepickup( function_530d399600e13c30() );
    thread flag_watchpickup();
    function_c14570348203e217();
    thread function_9487c9bc98d4cc91( #"hash_9570adf34181a116", game[ "defenders" ] );
    thread function_9487c9bc98d4cc91( #"hash_9570adf34181a116", game[ "attackers" ] );
    thread function_871edcd623d8244( 4, 0 );
    dialog::statusdialog( "flag_reset", "axis" );
    dialog::statusdialog( "flag_reset", "allies" );
    thread hud_util::showsplashtoall( "sabattack_flag_reset_splash" );
    thread function_79f8f7423a17d1fd( -2 );
    level notify( #"flag_reset" );
    game[ "sabattack_dlogs" ].var_c8eddfcfab3ad0b0 = "neutral";
    level.var_a660edc4804f8be9 = undefined;
    level.var_712aadda09e8ccdf = undefined;
}

// Namespace sabattack
// Params 0
// Checksum 0xdf03d8c1, Offset: 0x3819
// Size: 0xdc
function flag_statecaptured()
{
    level thread function_99240e28810e170a( "captured" );
    level.var_f4d13777a227fce3 = undefined;
    function_514552107a968cb5();
    function_c14570348203e217();
    thread function_79f8f7423a17d1fd( -3 );
    level thread function_e03b6347cfcb195f();
    wait level.flagRespawnTime;
    flag_makepickup();
    thread flag_watchpickup();
    dialog::statusdialog( "flag_new", "axis" );
    dialog::statusdialog( "flag_new", "allies" );
    game[ "sabattack_dlogs" ].var_ea5ee11260856ef3 = undefined;
    level thread function_99240e28810e170a( "unlocked" );
    thread function_9487c9bc98d4cc91( #"hash_9570adf34181a116", game[ "defenders" ] );
    thread function_9487c9bc98d4cc91( #"hash_9570adf34181a116", game[ "attackers" ] );
    thread function_871edcd623d8244( 4, 0 );
    level.var_a660edc4804f8be9 = undefined;
    level.var_712aadda09e8ccdf = undefined;
}

// Namespace sabattack
// Params 0
// Checksum 0x8207db20, Offset: 0x38fd
// Size: 0xcc
function function_e03b6347cfcb195f()
{
    self notify( #"hash_b54e6ed3f02e60e" );
    self endon( #"hash_b54e6ed3f02e60e" );
    level endon( #"game_ended" );
    level endon( #"flag_state_changed" );
    extratime = level.flagstate == "dropped" ? 0 : 1;
    endtime = int( gettime() + 1000 * ( level.flagRespawnTime + extratime ) );
    setomnvar( "ui_hardpoint_timer", endtime );
    
    while ( gettime() < endtime - extratime * 1000 )
    {
        setomnvar( "ui_sabattack_flag_available_timer", int( ( endtime - gettime() ) / 1000 ) );
        wait 0.1;
    }
    
    setomnvar( "ui_sabattack_flag_available_timer", -1 );
    thread function_79f8f7423a17d1fd( -2 );
}

// Namespace sabattack
// Params 0
// Checksum 0x48bb01aa, Offset: 0x39d1
// Size: 0x7c
function function_865ec6aab2c81d0a()
{
    if ( !isdefined( self.flag_influencer ) && spawnlogic::function_2afb75ddc98a1485( #"gametype_flag" ) )
    {
        if ( isplayer( self ) )
        {
            self.flag_influencer = spawnlogic::addspawninfluencer( #"gametype_flag", self.origin, "neutral", self, self );
            return;
        }
        
        self.flag_influencer = spawnlogic::addspawninfluencer( #"gametype_flag", self.origin, "neutral" );
    }
}

// Namespace sabattack
// Params 0
// Checksum 0xf695f23c, Offset: 0x3a55
// Size: 0x3b
function flag_removeinfluencer()
{
    if ( isdefined( self.flag_influencer ) )
    {
        if ( !isplayer( self ) || isalive( self ) )
        {
            spawnlogic::removespawninfluencer( self.flag_influencer );
        }
        
        self.flag_influencer = undefined;
    }
}

// Namespace sabattack
// Params 1
// Checksum 0x417be757, Offset: 0x3a98
// Size: 0x160
function flag_makepickup( flagdroppoint )
{
    level endon( #"game_ended" );
    function_7862798ff616d461();
    var_281dc15248665182 = flagdroppoint ?? function_fc2d3d457e25d10();
    
    /#
        if ( self.var_7a8784dd3bfbf9a2 )
        {
            thread flagdebug( var_281dc15248665182.origin );
        }
    #/
    
    self.var_e4d7f49e8039a388 = spawn( "script_model", var_281dc15248665182.origin + ( 0, 0, 0 ) );
    self.var_e4d7f49e8039a388.trigger = spawn( "trigger_radius", var_281dc15248665182.origin, 0, 20, 60 );
    self.var_e4d7f49e8039a388 setmodel( "sat_electronics_parts_misc_emp_device_01" );
    self.var_e4d7f49e8039a388.angles = var_281dc15248665182.angles;
    self.var_e4d7f49e8039a388 function_e5d4d794d013eeec();
    self.var_e4d7f49e8039a388 playloopsound( #"hash_526882526e3966e6" );
    
    if ( level.pausemodetimer )
    {
        level gamelogic_mp::resumetimer();
    }
    
    game[ "sabattack_dlogs" ].var_c8eddfcfab3ad0b0 = "neutral";
    game[ "sabattack_dlogs" ].var_dea243d0ec7da0f8 = var_281dc15248665182.origin;
    self.var_e4d7f49e8039a388 function_865ec6aab2c81d0a();
}

// Namespace sabattack
// Params 0
// Checksum 0x66efb503, Offset: 0x3c00
// Size: 0x18c
function flag_watchpickup()
{
    self endon( #"game_ended" );
    self endon( #"flag_state_changed" );
    
    while ( true )
    {
        self.var_e4d7f49e8039a388.trigger waittill( #"trigger", player );
        var_8f3ca8c9d6e5b1dd = level.var_aff27edcd82ce6b8 == player && gettime() < level.var_cf752d7e03369ac8 + 1000;
        var_32a53fe0dc2312e1 = isplayer( player ) && player::isreallyalive( player );
        var_bac952c44ae7edc7 = player utility::isusingremote() || isdefined( player.spawningafterremotedeath );
        
        if ( !var_32a53fe0dc2312e1 || player ismeatshieldvictim() || var_bac952c44ae7edc7 || var_8f3ca8c9d6e5b1dd )
        {
            continue;
        }
        
        if ( level.forceCarrierPistol )
        {
            if ( player ismeatshieldattacker() || player [[ utility::getsharedfunc( #"executions", #"is_in_takedown" ) ]]() )
            {
                continue;
            }
        }
        
        level.var_f4d13777a227fce3 = { #angles:self.var_e4d7f49e8039a388.angles, #origin:self.var_e4d7f49e8039a388.origin };
        self.flagcarrier = player;
        self.flagstate = "pickedUp";
        self notify( #"flag_state_changed" );
        self.var_e4d7f49e8039a388 stoploopsound( #"hash_526882526e3966e6" );
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x53182713, Offset: 0x3d94
// Size: 0x5f
function function_68158179022acff2()
{
    if ( isdefined( self.var_e4d7f49e8039a388 ) )
    {
        self.var_e4d7f49e8039a388 function_104e4861525d1597();
        self.var_e4d7f49e8039a388 flag_removeinfluencer();
        self.var_e4d7f49e8039a388.trigger delete();
        self.var_e4d7f49e8039a388 delete();
        self.var_e4d7f49e8039a388 = undefined;
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x94f63f4a, Offset: 0x3dfb
// Size: 0x31e
function function_d962bac1591c693c()
{
    if ( self.flagcarrier )
    {
        self.flagcarrier function_6e2cefae6bac0751();
        self.flagcarrier class::disableclassswapallowed();
        
        if ( level.showFlagOnPlayer )
        {
            self.flagcarrier attach( "sat_electronics_parts_misc_emp_device_01", "tag_stowed_back3", 1 );
            self.flagcarrier.carryflag = "sat_electronics_parts_misc_emp_device_01";
        }
        
        self.flagcarrier function_865ec6aab2c81d0a();
        self.flagcarrier setclientomnvar( "ui_hud_carried_item_count", 1 );
        thread hud_util::teamplayercardsplash( "sabattack_flag_pickup_splash", self.flagcarrier, undefined, undefined, 1 );
        self.flagcarrier thread hud_message::function_78fedf6f526825f4( "sabattack_flag_pickup_you_splash", level.gametypebundle.var_e662dd7f27d462eb );
        self.flagcarrier setgametypevip( 1 );
        self.flagcarrier playsoundtoplayer( #"hash_5de2a5ae70b4741", self.flagcarrier );
        self.flagcarrier playloopsound( #"hash_e231d9adc5bd23b0" );
        otherteam = game_utility_mp::getotherteam( self.flagcarrier.team )[ 0 ];
        level thread function_7e2f4f34e9f6e6ec( "flag_pickup", self.flagcarrier.team, "flag" );
        level thread function_7e2f4f34e9f6e6ec( "flag_pickup_enemy", otherteam, "flag" );
        self.flagcarrier outline_create();
        
        if ( !self.flagcarrier.var_ff37a8d694120230 )
        {
            self.flagcarrier thread points::doscoreevent( #"hash_84d69951eceed05f" );
        }
        
        if ( level.var_9846a3db6f6a3006 )
        {
            level.flagcarrier thread function_1df70f0216bd2e0b();
            
            if ( game_utility::function_ae97372c83da7acc() )
            {
                level.flagcarrier player::showminimap();
            }
        }
        
        game[ "sabattack_dlogs" ].var_c8eddfcfab3ad0b0 = self.flagcarrier.team;
        game[ "sabattack_dlogs" ].var_dea243d0ec7da0f8 = self.flagcarrier.origin;
        game[ "sabattack_dlogs" ].var_ea5ee11260856ef3 = self.flagcarrier getplayerunoid();
        
        if ( self.flagcarrier.team == game[ "defenders" ] )
        {
            function_949376910ff35c27( level.allieszone, level.axiszone );
        }
        else
        {
            function_949376910ff35c27( level.axiszone, level.allieszone );
        }
        
        if ( level.var_dfca4b32020d8029 )
        {
            level thread function_cee3f439e8130815();
        }
        
        thread function_79f8f7423a17d1fd();
        
        if ( level.forceCarrierPistol )
        {
            self.flagcarrier thread function_a7c4ca3b754df8e1();
        }
        
        if ( level.var_5282f6a475fe8220 )
        {
            thread function_2550c440764221b1( 0, 80 );
            self.flagcarrier thread function_1bd870c75e16f712();
        }
        
        self.flagcarrier.finishedpickup = 1;
    }
}

// Namespace sabattack
// Params 1, eflags: 0xc
// Checksum 0x2da48835, Offset: 0x4121
// Size: 0x196
function private function_79f8f7423a17d1fd( dropped )
{
    self notify( #"hash_8046e7304248c42f" );
    self endon( #"hash_8046e7304248c42f" );
    level endon( #"game_ended" );
    
    if ( isdefined( dropped ) )
    {
        setomnvar( "ui_sabattack_flag_owner_id", dropped );
        
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_sabattack_flag_ownership", 0 );
        }
        
        return;
    }
    
    setomnvar( "ui_sabattack_flag_owner_id", level.flagcarrier getentitynumber() );
    
    foreach ( player in level.players )
    {
        var_3399734f39458d3f = player.team == level.flagcarrier.team ? 1 : 2;
        var_3399734f39458d3f = player == level.flagcarrier ? 3 : var_3399734f39458d3f;
        player setclientomnvar( "ui_sabattack_flag_ownership", var_3399734f39458d3f );
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x525a13c, Offset: 0x42bf
// Size: 0xdb
function function_1df70f0216bd2e0b()
{
    self notify( #"hash_eaec24f8e50bdf4b" );
    self endon( #"hash_eaec24f8e50bdf4b" );
    level endon( #"game_ended" );
    level endon( #"flag_state_changed" );
    self endon( #"death_or_disconnect" );
    bundle = level.streakglobals.streakbundles[ "radar_ping" ];
    self setclientomnvar( "radar_ping", function_43b5ed5a14a56573( #"scriptbundle_killstreak", bundle.var_d80db24c90d421fb ) );
    self function_744ec8023439271f( int( bundle.radarpingsweepradius ), int( bundle.radarpingsweeptime * 1000 ), int( bundle.var_2962c1bc94835e40 * 1000 ) );
    wait int( bundle.radarpingsweeptime * 1000 );
    self function_c67c92094ae6ccf7();
}

// Namespace sabattack
// Params 0
// Checksum 0x9884e837, Offset: 0x43a2
// Size: 0x181
function function_57af2e919b37686c()
{
    if ( self.flagcarrier )
    {
        self.flagcarrier.finishedpickup = undefined;
        self.flagcarrier function_c67c92094ae6ccf7();
        gameobjects::function_8e7cb6f7dd4de4a5( self.flagcarrier, 0 );
        
        if ( game_utility::function_ae97372c83da7acc() )
        {
            self.flagcarrier player::hideminimap();
        }
        
        if ( level.allowCarrierOutlines )
        {
            self.flagcarrier outline_clear();
        }
        
        self.flagcarrier function_af496cff2a931ca3();
        self.flagcarrier flag_removeinfluencer();
        self.flagcarrier setgametypevip( 0 );
        self.flagcarrier setclientomnvar( "ui_hud_carried_item_count", 0 );
        self.flagcarrier stoploopsound( #"hash_e231d9adc5bd23b0" );
        
        if ( isdefined( self.flagcarrier.carryflag ) )
        {
            self.flagcarrier detach( self.flagcarrier.carryflag, "tag_stowed_back3" );
            self.flagcarrier.carryflag = undefined;
        }
        
        if ( level.forceCarrierPistol )
        {
            self.flagcarrier thread function_465bde3b55c20d03();
        }
        
        self.flagcarrier = undefined;
        game[ "sabattack_dlogs" ].var_c8eddfcfab3ad0b0 = "neutral";
    }
    else
    {
        assertmsg( "<dev string:xba>" );
    }
    
    level.var_8b19ee2132ba7788 = undefined;
    setomnvar( "ui_sabattack_anti_stall", 0 );
}

// Namespace sabattack
// Params 0
// Checksum 0x692a489e, Offset: 0x452b
// Size: 0xb5
function function_e8ebfc9ce9486cfb()
{
    safedrop = self.var_680c481fb5a582c4.origin ? self.var_680c481fb5a582c4 : level.var_f4d13777a227fce3;
    safedrop.origin = self.var_9311dede1535ffac && self.manualdrop ? self.var_9311dede1535ffac[ "position" ] : safedrop.origin;
    
    if ( safedrop && level.var_94539d0656590c27 )
    {
        flag_makepickup( safedrop );
        thread flag_watchpickup();
        thread flag_reset();
        return;
    }
    
    flag_makepickup();
    thread flag_watchpickup();
}

// Namespace sabattack
// Params 0
// Checksum 0x906ccb44, Offset: 0x45e8
// Size: 0x8c
function flag_reset()
{
    self endon( #"flag_state_changed" );
    setomnvar( "ui_sabattack_flag_available_timer", -1 );
    
    if ( level.flagResetTime != level.var_f957b56c9eb2da0e )
    {
        wait level.flagResetTime - level.var_f957b56c9eb2da0e;
        objidpoolmanager::objective_showtimer( self.var_e4d7f49e8039a388.var_1c94978644faa280, 1 );
        level thread function_e03b6347cfcb195f();
    }
    
    wait level.var_f957b56c9eb2da0e;
    self.flagstate = "reset";
    self notify( #"flag_state_changed" );
}

// Namespace sabattack
// Params 1
// Checksum 0x609f7447, Offset: 0x467c
// Size: 0xca
function function_cb4437502197f14e( player )
{
    player val::reset_all( "carry" );
    player function_3181733c19782bcc( 0 );
    player function_134cd2c60d3a7edf( 0 );
    player val::set( "carry", "weapon_pickup", 0 );
    player val::set( "carry", "weapon_switch", 0 );
    player val::set( "carry", "weapon_switch_clip", 0 );
    player val::set( "carry", "remote_killstreaks", 0 );
    player val::set( "carry", "offhand_primary_weapons", 0 );
    player val::set( "carry", "offhand_secondary_weapons", 0 );
    player val::set( "carry", "force_enable_offhand_sprays", 0 );
    player val::set( "carry", "supers", 0 );
}

// Namespace sabattack
// Params 0
// Checksum 0x6a806f06, Offset: 0x474e
// Size: 0x292
function function_a7c4ca3b754df8e1()
{
    self endon( #"death_or_disconnect" );
    level endon( #"flag_state_changed" );
    self cancelreload();
    function_cb4437502197f14e( self );
    self notify( #"killstreak_cancel" );
    self notify( #"equip_deploy_cancel" );
    self notify( #"cancel_deploy" );
    self notify( #"killstreak_stowable_weapon_switched" );
    thread callback::callback( #"killstreak_cancel" );
    wait 0.2;
    
    while ( self isswitchingweapon() || self getcurrentweapon().type == "equipdeploy" )
    {
        wait 0.2;
    }
    
    currentweapons = self getweaponslistprimaries();
    pistol = undefined;
    
    foreach ( weap in currentweapons )
    {
        if ( weapon::getweapongroup( weap ) == "weapon_pistol" )
        {
            pistol = weap;
            break;
        }
    }
    
    if ( self isswitchingweapon() && self isdroppingweapon() )
    {
        weapon = self getcurrentweapon();
        
        if ( weapon == pistol )
        {
            inventory_utility::_switchtoweaponimmediate( weapon );
        }
    }
    
    if ( pistol )
    {
        inventory_utility::domonitoredweaponswitch( pistol, undefined, 1, 1 );
        self.switchweapon = pistol;
    }
    else
    {
        currentweapon = self getcurrentweapon();
        self.switchweapon = weapon::function_1344ad15d2d7bd21( currentweapon ) ? self.lastnormalweaponobj : currentweapon;
        self.switchweapon = killstreak_utility::iskillstreakdeployweapon( self.switchweapon ) ? self.lastnormalweaponobj : self.switchweapon;
        
        if ( currentweapon.basename == "none" )
        {
            self.switchweapon = self.lastnormalweaponobj;
        }
        
        flagcarrierweapon = weapon_utility::function_d2c8356dc369d9ce( "sat_pi_timir" );
        self giveweapon( flagcarrierweapon, undefined, undefined, 0, 1 );
        self.givenweapon = flagcarrierweapon;
        inventory_utility::domonitoredweaponswitch( flagcarrierweapon, undefined, 1, 1 );
    }
    
    val::set( "carry", "offhand_primary_weapons", 1 );
    val::set( "carry", "offhand_secondary_weapons", 1 );
    val::set( "carry", "force_enable_offhand_sprays", 1 );
    val::set( "carry", "supers", 1 );
}

// Namespace sabattack
// Params 0
// Checksum 0x23a711ea, Offset: 0x49e8
// Size: 0x9c
function function_465bde3b55c20d03()
{
    self endon( #"death_or_disconnect" );
    val::set( "carry", "weapon_switch", 1 );
    
    if ( self.givenweapon )
    {
        self takeweapon( self.givenweapon );
        self.givenweapon = undefined;
        inventory_utility::domonitoredweaponswitch( self.switchweapon );
    }
    else
    {
        inventory_utility::domonitoredweaponswitch( self.switchweapon );
    }
    
    if ( self.switchweapon )
    {
        self.switchweapon = undefined;
    }
    
    waitframe();
    val::reset_all( "carry" );
    self function_3181733c19782bcc( 1 );
    self function_134cd2c60d3a7edf( 1 );
}

// Namespace sabattack
// Params 0
// Checksum 0x48ff1c41, Offset: 0x4a8c
// Size: 0x5b
function function_157531f98340ad()
{
    level endon( #"game_ended" );
    level endon( #"flag_state_changed" );
    self.flagcarrier utility::waittill_any( "death_or_disconnect", "meatshield_victim_start" );
    
    if ( isdefined( self.flagcarrier ) )
    {
        self.flagstate = "dropped";
        self notify( #"flag_state_changed" );
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x3b99639d, Offset: 0x4aef
// Size: 0xe5
function function_eed093f5030f08a6()
{
    level endon( #"game_ended" );
    self endon( #"flag_state_changed" );
    self.flagcarrier endon( #"death_or_disconnect" );
    self.var_680c481fb5a582c4 = spawnstruct();
    
    while ( true )
    {
        if ( isdefined( self.flagcarrier ) )
        {
            function_b20117ca63f463df();
            
            if ( !player::isreallyalive( self.flagcarrier ) )
            {
                self.flagstate = self.flagcarrier.forcereset && level.flagResetOOB ? "reset" : "dropped";
                level.var_5ed907a605f62563 = level.flagstate == "reset" && level.flagResetOOBPenaltyTime > 0 ? 1 : 0;
                self notify( #"flag_state_changed" );
            }
        }
        
        wait 0.1;
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x9140a33d, Offset: 0x4bdc
// Size: 0x174
function function_b20117ca63f463df()
{
    var_4c6efdd8994486db = self.flagcarrier outofbounds::istouchingoobtrigger();
    fcisonground = self.flagcarrier isonground();
    var_51256f44f0baecd0 = self.flagcarrier isswimming();
    var_afa8304607bffa3 = self.flagcarrier getgroundentity();
    var_62ba1c66e7827a78 = getclosestpointonnavmesh( self.flagcarrier.origin );
    
    if ( var_62ba1c66e7827a78 )
    {
        var_58bb5279a9d9983a = distancesquared( var_62ba1c66e7827a78, self.flagcarrier.origin );
        var_61048be25a30705b = var_58bb5279a9d9983a < 10000;
        
        if ( level.var_94539d0656590c27 && fcisonground && !var_4c6efdd8994486db && !var_51256f44f0baecd0 && !var_afa8304607bffa3 ismovingplatform() && var_61048be25a30705b )
        {
            self.var_680c481fb5a582c4.origin = var_62ba1c66e7827a78;
            self.var_680c481fb5a582c4.angles = ( 0, self.flagcarrier.angles[ 1 ], 0 );
            
            /#
                debugstar( var_62ba1c66e7827a78, ( 1, 0, 0 ), 10 );
            #/
        }
    }
    
    self.flagcarrier.forcereset = var_4c6efdd8994486db && level.flagResetOOB ? 1 : undefined;
}

// Namespace sabattack
// Params 0, eflags: 0xc
// Checksum 0xaa1cd4f0, Offset: 0x4d58
// Size: 0xcb
function private function_1bd870c75e16f712()
{
    self notify( #"hash_39e12e21577a903b" );
    self endon( #"hash_39e12e21577a903b" );
    level endon( #"game_ended" );
    level endon( #"hash_4c181b8bef7da5ae" );
    level endon( #"flag_state_changed" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c771aa21f4708079" );
    wait 0.5;
    self waittill( #"manual_drop" );
    
    if ( level.flagcarrier != self )
    {
        return;
    }
    
    level.var_aff27edcd82ce6b8 = self;
    level.var_cf752d7e03369ac8 = gettime();
    level.flagstate = "dropped";
    level.manualdrop = 1;
    self.var_ff37a8d694120230 = 1;
    self notify( #"flag_state_changed" );
    level notify( #"flag_state_changed" );
}

// Namespace sabattack
// Params 2, eflags: 0xc
// Checksum 0x7b35dd79, Offset: 0x4e2b
// Size: 0x3eb
function private function_2550c440764221b1( offsetangle, dropdist )
{
    self notify( #"hash_36aa24745715f31c" );
    self endon( #"hash_36aa24745715f31c" );
    level endon( #"game_ended" );
    level endon( #"flag_state_changed" );
    level.flagcarrier endon( #"death_or_disconnect" );
    wait 0.5;
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1 );
    
    while ( level.flagcarrier )
    {
        if ( outofbounds::isoob( level.flagcarrier ) )
        {
            level gameobjects::function_8e7cb6f7dd4de4a5( level.flagcarrier, 0 );
            waitframe();
            continue;
        }
        
        if ( level.var_dd42bed3367cf763 && !level.var_dbeaf99627787f48 )
        {
            level gameobjects::function_8e7cb6f7dd4de4a5( level.flagcarrier, 0 );
            return;
        }
        
        trace = undefined;
        height = level.flagcarrier geteye()[ 2 ] - level.flagcarrier.origin[ 2 ];
        end = level.flagcarrier.origin + ( 0, 0, height / 2 );
        forward = anglestoforward( level.flagcarrier getplayerangles() );
        x = forward[ 0 ] * cos( offsetangle ) - forward[ 1 ] * sin( offsetangle );
        y = forward[ 0 ] * sin( offsetangle ) + forward[ 1 ] * cos( offsetangle );
        newforward = ( x, y, 0 );
        endvector = dropdist * vectornormalize( newforward );
        height = level.flagcarrier geteye()[ 2 ] - level.flagcarrier.origin[ 2 ];
        start = level.flagcarrier.origin + ( 0, 0, height / 2 );
        end = start + endvector;
        trace = trace::sphere_trace( start, end, 5, undefined, contents );
        
        /#
            if ( getdvarint( @"hash_a1028bc0f66ae86", 0 ) )
            {
                trace::draw_trace( trace, ( 0, 0, 1 ) );
            }
        #/
        
        candrop = trace[ "fraction" ] == 1;
        
        if ( candrop )
        {
            if ( gameobjects::function_a2d0c78e8e979d04( level.flagcarrier ) )
            {
                level gameobjects::function_8e7cb6f7dd4de4a5( level.flagcarrier, 0 );
            }
            else
            {
                secondtrace = trace::ray_trace( end, end - ( 0, 0, height ), undefined, contents );
                
                /#
                    if ( getdvarint( @"hash_a1028bc0f66ae86", 0 ) )
                    {
                        trace::draw_trace( secondtrace, ( 1, 0, 0 ) );
                    }
                #/
                
                if ( outofbounds::ispointinoutofbounds( secondtrace[ "position" ] ) || outofbounds::ispointinoutofbounds( secondtrace[ "position" ] + ( 0, 0, 12 ) ) || gameobjects::function_f87f2e6a9fbe6dfa( secondtrace[ "position" ] ) )
                {
                    level gameobjects::function_8e7cb6f7dd4de4a5( level.flagcarrier, 0 );
                }
                else if ( vectordot( secondtrace[ "normal" ], ( 0, 0, 1 ) ) > 0.8 )
                {
                    candrop = 1;
                    
                    if ( isdefined( secondtrace[ "entity" ] ) )
                    {
                        if ( level gameobjects::function_f324dbe762656555( secondtrace[ "entity" ] ) )
                        {
                            candrop = 0;
                        }
                    }
                    
                    secondtrace[ "position" ] = getclosestpointonnavmesh( secondtrace[ "position" ] );
                    level gameobjects::function_8e7cb6f7dd4de4a5( level.flagcarrier, candrop, secondtrace );
                }
                else
                {
                    level gameobjects::function_8e7cb6f7dd4de4a5( level.flagcarrier, 0 );
                }
            }
        }
        else
        {
            level gameobjects::function_8e7cb6f7dd4de4a5( level.flagcarrier, 0 );
        }
        
        if ( !level.flagcarrier isonground() )
        {
            level gameobjects::function_8e7cb6f7dd4de4a5( level.flagcarrier, 0 );
        }
        
        waitframe();
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x614cff79, Offset: 0x521e
// Size: 0x1e2
function outline_create()
{
    if ( !player::isreallyalive( self ) )
    {
        return;
    }
    
    if ( level.allowCarrierOutlines )
    {
        self.var_e403791cb9b6226 = outline::outlineviewmodelenable( self, "outlinefill_you_sabattack", #"level_script" );
        self.friendlyoutlineid = outline::outlineenableforteam( self, self.team, "outlinefill_friendly_hvt", "level_script", undefined, 1 );
        self.var_e82835bccfbadc6d = outline::outlineenableforteam( self, team_utility::getotherteam( self.team ), "outlinefill_enemy_hvt", "level_script", undefined, 1 );
    }
    
    if ( level.allowCarrierVFX )
    {
        if ( !self.var_5ca4ed51593cd9a9 )
        {
            self.var_5ca4ed51593cd9a9 = spawn( "script_model", self gettagorigin( "j_spineupper" ) );
            self.var_5ca4ed51593cd9a9 setmodel( "tag_origin" );
            self.var_5ca4ed51593cd9a9 linkto( self, "j_spineupper", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            waitframe();
            vfxwm = utility::getfx( "vfx_sat_sabotage_carry_wm" );
            
            foreach ( player in level.players )
            {
                if ( isdefined( self.var_5ca4ed51593cd9a9 ) && player != self )
                {
                    playfxontagforclients( vfxwm, self.var_5ca4ed51593cd9a9, "tag_origin", player );
                    waitframe();
                }
            }
            
            playfxontagforclients( utility::getfx( "vfx_sat_sabotage_carry_vm" ), self.var_5ca4ed51593cd9a9, "tag_origin", self );
        }
        
        thread function_6b15d23f205cfa42( self.var_5ca4ed51593cd9a9 );
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x22a05db2, Offset: 0x5408
// Size: 0x58
function outline_clear()
{
    if ( self.friendlyoutlineid && self.var_e82835bccfbadc6d )
    {
        outline::outlinedisable( self.friendlyoutlineid, self );
        outline::outlinedisable( self.var_e82835bccfbadc6d, self );
        outline::outlineviewmodeldisable( self.var_e403791cb9b6226, self );
        self.var_e403791cb9b6226 = undefined;
    }
}

// Namespace sabattack
// Params 1, eflags: 0x4
// Checksum 0x3d1073ee, Offset: 0x5468
// Size: 0xeb
function private function_6b15d23f205cfa42( var_5ca4ed51593cd9a9 )
{
    utility::waittill_any_ents( self, "death_or_disconnect", self, "flag_state_changed", level, "game_ended" );
    
    if ( self )
    {
        vfxwm = utility::getfx( "vfx_sat_sabotage_carry_wm" );
        
        foreach ( player in level.players )
        {
            if ( var_5ca4ed51593cd9a9 )
            {
                stopfxontagforclients( vfxwm, var_5ca4ed51593cd9a9, "tag_origin", player );
            }
        }
        
        if ( var_5ca4ed51593cd9a9 )
        {
            stopfxontagforclients( utility::getfx( "vfx_sat_sabotage_carry_vm" ), var_5ca4ed51593cd9a9, "tag_origin", self );
        }
    }
    
    if ( var_5ca4ed51593cd9a9 )
    {
        var_5ca4ed51593cd9a9 delete();
    }
}

// Namespace sabattack
// Params 1, eflags: 0x4
// Checksum 0xb43c14d1, Offset: 0x555b
// Size: 0xe5
function private function_21396bf10feb0abc( params )
{
    player = params.streakinfo.owner;
    
    if ( level.flagcarrier == player && killstreak::isremotekillstreak( params.streakinfo.streakname ) )
    {
        if ( params.streakinfo.streakname == "valkyrie_rocket" )
        {
            player waittill( #"valkyrie_fired" );
            stopfxontagforclients( utility::getfx( "vfx_sat_sabotage_carry_vm" ), player.var_5ca4ed51593cd9a9, "tag_origin", player );
            player waittill( #"hash_769534f8253e5aa7" );
            player thread function_13ef779f2072686d();
            return;
        }
        
        stopfxontagforclients( utility::getfx( "vfx_sat_sabotage_carry_vm" ), player.var_5ca4ed51593cd9a9, "tag_origin", player );
    }
}

// Namespace sabattack
// Params 1, eflags: 0x4
// Checksum 0xddba65b4, Offset: 0x5648
// Size: 0xa8
function private on_killstreak_finish_use( params )
{
    player = params.streakinfo.owner;
    var_efc75a327ba957ce = killstreak::isremotekillstreak( params.streakinfo.streakname );
    isvalkyrie = params.streakinfo.streakname == "valkyrie_rocket";
    
    if ( level.flagcarrier == player && player::isreallyalive( player ) && !isvalkyrie && var_efc75a327ba957ce )
    {
        player thread function_13ef779f2072686d();
    }
}

// Namespace sabattack
// Params 0, eflags: 0x4
// Checksum 0xd8bdbfcf, Offset: 0x56f8
// Size: 0x47
function private function_13ef779f2072686d()
{
    if ( level.flagcarrier == self && self.var_5ca4ed51593cd9a9 && player::isreallyalive( self ) )
    {
        playfxontagforclients( utility::getfx( "vfx_sat_sabotage_carry_vm" ), self.var_5ca4ed51593cd9a9, "tag_origin", self );
    }
}

// Namespace sabattack
// Params 1
// Checksum 0x18c275cf, Offset: 0x5747
// Size: 0x168
function function_514552107a968cb5( delayedreset )
{
    if ( delayedreset )
    {
        nextlocation = level.flagspawnpos[ level.var_7a2ebb4dd0b67273 ];
    }
    else if ( level.flagRespawnType == 2 )
    {
        nextlocation = level.flagspawnpos[ 0 ];
    }
    else
    {
        nextlocation = level.var_7a2ebb4dd0b67273 == level.flagspawnpos.size - 1 ? level.flagspawnpos[ 0 ] : level.flagspawnpos[ level.var_7a2ebb4dd0b67273 + 1 ];
    }
    
    self.var_843012416f04a9f1 = spawn( "script_model", nextlocation.origin );
    self.var_843012416f04a9f1.offset3d = ( 0, 0, 15 );
    self.var_843012416f04a9f1.objid = objidpoolmanager::requestobjectiveid();
    self.var_843012416f04a9f1 function_f67d5b77f43a583a( self.var_843012416f04a9f1.objid, &"MP_INGAME_ONLY/OBJ_NEXT_CAPS" );
    objidpoolmanager::function_4c19b2a4563b489( self.var_843012416f04a9f1.objid, 1 );
    objidpoolmanager::objective_set_pulsate( self.var_843012416f04a9f1.objid, 1 );
    objective_objectiveid( self.var_843012416f04a9f1.objid, 2 );
}

// Namespace sabattack
// Params 0
// Checksum 0x5eb1b832, Offset: 0x58b7
// Size: 0x41
function function_7862798ff616d461()
{
    if ( isdefined( self.var_843012416f04a9f1 ) )
    {
        objidpoolmanager::returnobjectiveid( self.var_843012416f04a9f1.objid );
        self.var_843012416f04a9f1 delete();
        self.var_843012416f04a9f1 = undefined;
    }
}

// Namespace sabattack
// Params 0
// Checksum 0xcc6acb1d, Offset: 0x5900
// Size: 0x85
function function_e5d4d794d013eeec()
{
    self.offset3d = ( 0, 0, 15 );
    self.var_1c94978644faa280 = objidpoolmanager::requestobjectiveid();
    function_f67d5b77f43a583a( self.var_1c94978644faa280, &"mp_ingame_only/obj_take_caps" );
    objidpoolmanager::function_6dfdf7da8037a1ee( self.var_1c94978644faa280 );
    objidpoolmanager::update_objective_size( self.var_1c94978644faa280, "icon_small_medium" );
    function_5a1f9b4d7de0b23b( self.var_1c94978644faa280, 1 );
    objective_objectiveid( self.var_1c94978644faa280, 12 );
}

// Namespace sabattack
// Params 2
// Checksum 0x31afdcc4, Offset: 0x598d
// Size: 0x7a
function function_f67d5b77f43a583a( objid, objlabel )
{
    objective_setbackground( objid, 0 );
    objective_setzoffset( objid, 45 );
    objective_position( objid, self.origin + self.offset3d );
    objective_state( objid, "current" );
    objective_setplayintro( objid, 0 );
    objective_setownerteam( objid, "neutral" );
    objidpoolmanager::objective_showtimer( objid, 0 );
    function_60375dd8364de99a( objid, "sat_ui_sabattack_icon_waypoint_emp", objlabel );
}

// Namespace sabattack
// Params 0
// Checksum 0xf9575e97, Offset: 0x5a0f
// Size: 0x29
function function_104e4861525d1597()
{
    if ( isdefined( self.var_1c94978644faa280 ) )
    {
        objidpoolmanager::returnobjectiveid( self.var_1c94978644faa280 );
        self.var_1c94978644faa280 = undefined;
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x5e2b68c4, Offset: 0x5a40
// Size: 0x24e
function function_6e2cefae6bac0751()
{
    self.offset3d = ( 0, 0, 35 );
    self.objidnumfriend = objidpoolmanager::requestobjectiveid();
    
    if ( isdefined( self.objidnumfriend ) )
    {
        function_d3230295f92e7522( self.objidnumfriend, &"mp_ingame_only/obj_protect_caps" );
        objective_removeallfrommask( self.objidnumfriend );
        
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            if ( player != self )
            {
                objective_addclienttomask( self.objidnumfriend, player );
            }
        }
        
        objidpoolmanager::update_objective_size( self.objidnumfriend, "icon_small_medium" );
        objective_showtoplayersinmask( self.objidnumfriend );
        function_eb48368e1cb0b7c( self.objidnumfriend, 1 );
        objective_setspecialobjectivedisplay( self.objidnumfriend, 1 );
        objective_setenemylabel( self.objidnumfriend, &"MP_INGAME_ONLY/OBJ_KILL_CAPS" );
    }
    
    self.objidnumenemy = objidpoolmanager::requestobjectiveid();
    
    if ( isdefined( self.objidnumenemy ) )
    {
        function_d3230295f92e7522( self.objidnumenemy, &"MP_INGAME_ONLY/OBJ_KILL_CAPS" );
        
        foreach ( var_dc14799d14fca3b8 in team_utility::getenemyteams( self.team ) )
        {
            objidpoolmanager::objective_teammask_addtomask( self.objidnumenemy, var_dc14799d14fca3b8 );
        }
        
        objidpoolmanager::update_objective_size( self.objidnumenemy, "icon_small_medium" );
        function_90a7a0e6b30de7b9( self.objidnumenemy, 1 );
    }
    
    function_5a1f9b4d7de0b23b( self.objidnumfriend, 1 );
    function_5a1f9b4d7de0b23b( self.objidnumenemy, 1 );
    thread function_7281fdab5e394d4();
}

// Namespace sabattack
// Params 3
// Checksum 0xa8bfccf2, Offset: 0x5c96
// Size: 0x2e
function function_60375dd8364de99a( objid, objicon, objlabel )
{
    objective_icon( objid, objicon );
    objective_setlabel( objid, objlabel );
}

// Namespace sabattack
// Params 2
// Checksum 0x67e1a626, Offset: 0x5ccc
// Size: 0x86
function function_d3230295f92e7522( objid, objlabel )
{
    objective_setbackground( objid, 0 );
    objective_setzoffset( objid, 30 );
    objective_position( objid, self geteye() + self.offset3d );
    objective_state( objid, "active" );
    objective_setplayintro( objid, 0 );
    objective_setownerteam( objid, self.team );
    objective_objectiveid( objid, 12 );
    function_60375dd8364de99a( objid, "sat_ui_sabattack_icon_waypoint_emp", objlabel );
    waitframe();
    objective_state( objid, "current" );
}

// Namespace sabattack
// Params 0
// Checksum 0xa22fdf8e, Offset: 0x5d5a
// Size: 0x138
function function_7281fdab5e394d4()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_be6e93c793773faf" );
    self endon( #"hash_be6e93c793773faf" );
    
    if ( !isdefined( level.objpingdelay ) )
    {
        level.objpingdelay = 0;
    }
    
    previousupdatetime = gettime();
    
    while ( isdefined( self.objidnumfriend ) )
    {
        objpos = self geteye() + self.offset3d;
        objidpoolmanager::update_objective_position( self.objidnumfriend, objpos );
        objective_ping( self.objidnumfriend );
        currtime = gettime();
        
        if ( currtime - previousupdatetime >= level.objpingdelay * 1000 )
        {
            objidpoolmanager::update_objective_position( self.objidnumenemy, objpos );
            objective_ping( self.objidnumenemy );
            previousupdatetime = currtime;
            
            if ( level.flagcarrier )
            {
                level.flagcarrier.botorigin = level.flagcarrier.origin;
                
                if ( level.var_9846a3db6f6a3006 )
                {
                    level.flagcarrier thread function_1df70f0216bd2e0b();
                }
            }
        }
        
        waitframe();
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x9f7e750d, Offset: 0x5e9a
// Size: 0x50
function function_af496cff2a931ca3()
{
    if ( isdefined( self.objidnumfriend ) )
    {
        objidpoolmanager::returnobjectiveid( self.objidnumfriend );
        self.objidnumfriend = undefined;
    }
    
    if ( isdefined( self.objidnumenemy ) )
    {
        objidpoolmanager::returnobjectiveid( self.objidnumenemy );
        self.objidnumenemy = undefined;
    }
}

// Namespace sabattack
// Params 0
// Checksum 0xdf399aad, Offset: 0x5ef2
// Size: 0x1b6
function function_10ed552162ebaaef()
{
    level.axiszone = [];
    level.allieszone = [];
    level.allzones = [];
    
    foreach ( zone in level.var_e1221a6f06aed99d )
    {
        level.axiszone[ level.axiszone.size ] = zone_create( zone, game[ "defenders" ], zone.script_noteworthy, "axis" );
    }
    
    foreach ( zone in level.var_99514dc2cb317036 )
    {
        level.allieszone[ level.allieszone.size ] = zone_create( zone, game[ "attackers" ], zone.script_noteworthy, "allies" );
    }
    
    level.allzones = arraycombine( level.allzones, level.axiszone );
    level.allzones = arraycombine( level.allzones, level.allieszone );
    function_c14570348203e217();
    
    if ( level.var_dfca4b32020d8029 )
    {
        thread function_6be2a4a5a41450a8();
    }
}

// Namespace sabattack
// Params 2
// Checksum 0x7b03256e, Offset: 0x60b0
// Size: 0x62
function function_3acc256f1efdef30( array, zoneid )
{
    switch ( zoneid )
    {
        case #"hash_31103fbc01bd840c":
            return array[ 0 ];
        case #"hash_311042bc01bd88c5":
            return array[ 1 ];
        case #"hash_311041bc01bd8732":
            return array[ 2 ];
        default:
            return array[ 2 ];
    }
}

// Namespace sabattack
// Params 1
// Checksum 0x8b7a028d, Offset: 0x611a
// Size: 0x50
function function_5554ab8201222244( objkey )
{
    switch ( objkey )
    {
        case #"hash_31103fbc01bd840c":
            return 3;
        case #"hash_311042bc01bd88c5":
            return 5;
        case #"hash_311041bc01bd8732":
            return 7;
        default:
            return;
    }
}

// Namespace sabattack
// Params 1
// Checksum 0xa5a60d84, Offset: 0x6172
// Size: 0x50
function function_4ba16d9b6cfd7b6c( objkey )
{
    switch ( objkey )
    {
        case #"hash_31103fbc01bd840c":
            return 1;
        case #"hash_311042bc01bd88c5":
            return 2;
        case #"hash_311041bc01bd8732":
            return 3;
        default:
            return;
    }
}

// Namespace sabattack
// Params 1
// Checksum 0x79fb110c, Offset: 0x61ca
// Size: 0xa4
function zone_removeinfluencer( influencer )
{
    if ( isdefined( self.spawninfluencers[ influencer ] ) )
    {
        foreach ( var_487eb02e544d3e8b in self.spawninfluencers[ influencer ] )
        {
            spawnlogic::removespawninfluencer( var_487eb02e544d3e8b );
        }
        
        self.spawninfluencers[ influencer ] = undefined;
    }
}

// Namespace sabattack
// Params 3
// Checksum 0x150a6eb4, Offset: 0x6276
// Size: 0x11a
function function_95fda8f983774ae2( enabled, spawn_set, influencer )
{
    if ( !enabled )
    {
        zone_removeinfluencer( influencer );
        return;
    }
    
    if ( isdefined( self.spawninfluencers[ influencer ] ) )
    {
        return;
    }
    
    self.spawninfluencers[ influencer ] = [];
    
    foreach ( set in self.spawnsets[ spawn_set ] )
    {
        if ( !spawnlogic::useablespawnset( set ) )
        {
            continue;
        }
        
        var_487eb02e544d3e8b = spawnlogic::addspawninfluencer( influencer, self.trigger.origin );
        spawnlogic::influencersetspawnpointlist( var_487eb02e544d3e8b, set );
        self.spawninfluencers[ influencer ][ self.spawninfluencers[ influencer ].size ] = var_487eb02e544d3e8b;
    }
}

// Namespace sabattack
// Params 1
// Checksum 0x7e2a5f03, Offset: 0x6398
// Size: 0x7a
function function_54252dbc1f58fce3( locked )
{
    function_95fda8f983774ae2( locked, #"locked", #"hash_55ac03d620e3c019" );
    function_95fda8f983774ae2( !locked, #"locked", #"hash_4bd73b4f0c33be74" );
    function_95fda8f983774ae2( locked, #"unlocked", #"hash_ad553d4ee4b0de19" );
    function_95fda8f983774ae2( !locked, #"unlocked", #"hash_eb9f1ad7b54d88fe" );
}

// Namespace sabattack
// Params 4
// Checksum 0x946b18bb, Offset: 0x641a
// Size: 0x1ea
function zone_create( trigger, team, zoneid, dlogsteam )
{
    zonestruct = spawn( "script_model", trigger.origin );
    zonestruct.ownerteam = team;
    zonestruct setmodel( "sabattack_zone_script_fx_origin" );
    zonestruct.origin = trigger.origin;
    zonestruct.trigger = trigger;
    zonestruct.zoneid = zoneid;
    zonestruct.dlogsteam = dlogsteam;
    zonestruct.var_c078c56a993c121a = 0;
    zonestruct.var_144d9d8ca44ad231 = function_5554ab8201222244( zoneid );
    zonestruct.overloadassists = [];
    thread zone_create_waypoint( zonestruct );
    waitframe();
    zonestruct setscriptablepartstate( "main", zonestruct.ownerteam );
    zonestruct.spawnsets = [];
    zonestruct.spawnsets[ #"unlocked" ] = [ function_3acc256f1efdef30( [ #"zonea_unlocked_attackers", #"zoneb_unlocked_attackers" ], zoneid ), function_3acc256f1efdef30( [ #"zonea_unlocked_defenders", #"zoneb_unlocked_defenders" ], zoneid ) ];
    zonestruct.spawnsets[ #"locked" ] = [ function_3acc256f1efdef30( [ #"zonea_locked_attackers", #"zoneb_locked_attackers" ], zoneid ), function_3acc256f1efdef30( [ #"zonea_locked_defenders", #"zonea_locked_defenders" ], zoneid ) ];
    zonestruct.spawninfluencers = [];
    zonestruct function_54252dbc1f58fce3( 0 );
    zonestruct thread function_928da2a8f72771de();
    return zonestruct;
}

// Namespace sabattack
// Params 1
// Checksum 0xd9ce9449, Offset: 0x660d
// Size: 0xfd
function zone_create_waypoint( zonestruct )
{
    zonestruct.offset3d = ( 0, 0, 120 );
    objidnum = objidpoolmanager::requestobjectiveid();
    zonestruct.objidnum = objidnum;
    objidpoolmanager::function_6dfdf7da8037a1ee( objidnum );
    objidpoolmanager::update_objective_size( objidnum, "icon_small_medium" );
    objective_setbackground( objidnum, 0 );
    objective_position( objidnum, zonestruct.origin + zonestruct.offset3d );
    objective_state( objidnum, "current" );
    objective_setplayintro( objidnum, 0 );
    objective_setownerteam( objidnum, zonestruct.ownerteam );
    objective_objectiveid( objidnum, zonestruct.var_144d9d8ca44ad231 );
    function_60375dd8364de99a( objidnum, "icon_sat_waypoint_dom_" + zonestruct.zoneid, "zone" );
    objidpoolmanager::update_objective_setfriendlylabel( objidnum, &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS" );
    objidpoolmanager::update_objective_setenemylabel( objidnum, &"MP_INGAME_ONLY/OBJ_TARGET_CAPS" );
}

// Namespace sabattack
// Params 0
// Checksum 0x12c4dc76, Offset: 0x6712
// Size: 0x28e
function function_928da2a8f72771de()
{
    level endon( #"game_ended" );
    self endon( #"flag_state_changed" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( isdefined( level.var_e4d7f49e8039a388 ) )
        {
            wait 0.1;
            continue;
        }
        
        if ( !isplayer( player ) || !player::isreallyalive( player ) || player != level.flagcarrier || !player.finishedpickup || player.team == self.ownerteam )
        {
            continue;
        }
        
        game[ "sabattack_dlogs" ].var_dea243d0ec7da0f8 = player.origin;
        player.var_ff37a8d694120230 = undefined;
        level function_57af2e919b37686c();
        player notify( #"hash_c771aa21f4708079" );
        player thread points::doscoreevent( #"sabattack_capture_sector" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "overcharge_count" ] ) )
            {
                player.leaderboarddata[ "overcharge_count" ] = player.leaderboarddata[ "overcharge_count" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "overcharge_count" ] ) )
            {
                [[ level.leaderboardfunc[ "overcharge_count" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( player.pers[ "overcharge_count" ] ) )
            {
                player.pers[ "overcharge_count" ] = player.pers[ "overcharge_count" ] + 1;
            }
        }
        
        player codcasterclientmatchdata::function_8ecc753b54a5740f( 24, 1 );
        codcaster_utils::function_3038b6eafc46c037( 26, player.team, player getentitynumber(), function_4ba16d9b6cfd7b6c( self.zoneid ) );
        player stats::setextrascore0( player.pers[ "overcharge_count" ] );
        thread function_8242fda9573c7b9f( self.overloadassists );
        level gameobjects::function_8e7cb6f7dd4de4a5( player, 0 );
        thread function_8cc2b4ccaff93a9c( player );
        
        if ( level.zoneEMPEffect )
        {
            thread function_b3e6ffa20ba846bf( player );
        }
        
        level.flagstate = "captured";
        player notify( #"flag_state_changed" );
        level notify( #"flag_state_changed" );
        wait 1;
    }
}

// Namespace sabattack
// Params 1
// Checksum 0x6a0b2971, Offset: 0x69a8
// Size: 0x1d0
function function_8cc2b4ccaff93a9c( flagcarrier )
{
    level endon( #"game_ended" );
    rewardteam = game_utility_mp::getotherteam( self.ownerteam )[ 0 ];
    self.var_c078c56a993c121a++;
    game[ "sabattack_dlogs" ].var_e6c482ba3007ac85[ self.dlogsteam ][ self.zoneid ]++;
    thread hud_util::showsplashtoallexceptteam( self.ownerteam, "sabattack_zone_captured_friendly", undefined, undefined, undefined, undefined, level.gametypebundle.var_e662dd7f27d462eb );
    thread hud_util::showsplashtoallexceptteam( rewardteam, "sabattack_zone_captured_enemy", undefined, undefined, undefined, undefined, level.gametypebundle.var_e662dd7f27d462eb );
    dialog::statusdialog( "zone_sabotage", rewardteam, "flag" );
    dialog::statusdialog( "zone_sabotage_enemy", self.ownerteam, "flag" );
    challenges::function_a3678ff124a05f01( flagcarrier );
    gamescore::giveteamscoreforobjective( rewardteam, level.zonecapturescore, 0, undefined, 1 );
    thread function_871edcd623d8244( 5, 1 );
    thread function_9487c9bc98d4cc91( #"hash_b30cc61e8dad9ed1", team_utility::getotherteam( self.ownerteam ) );
    thread function_9487c9bc98d4cc91( #"hash_1e4ef0ac270cddb", self.ownerteam );
    
    if ( level.var_dbeaf99627787f48 )
    {
        level thread function_255652fc7d46d8f3( rewardteam );
    }
    
    self setscriptablepartstate( "main", "explode" );
    
    if ( game[ "teamScores" ][ rewardteam ] == level.jipscorelimit && !level.var_c1ac9852af29ae0 )
    {
        level function_a14deb691144654e();
        level notify( #"hash_ec29001269f7bfb5" );
    }
    
    if ( level.var_dd42bed3367cf763 )
    {
        waitframe();
        level ontimelimit();
    }
    
    wait 0.5;
    level thread function_55879e89b9e74573( self.ownerteam );
}

// Namespace sabattack
// Params 1
// Checksum 0x3abe47b, Offset: 0x6b80
// Size: 0xd8
function function_8242fda9573c7b9f( captureassists )
{
    level endon( #"game_ended" );
    var_a4020b90a4634fc4 = gettime() - 10000;
    
    foreach ( var_ae879115024f6155 in captureassists )
    {
        if ( var_ae879115024f6155.timestamp > var_a4020b90a4634fc4 && var_ae879115024f6155.player != level.flagcarrier )
        {
            var_ae879115024f6155.player thread points::doscoreevent( #"sabattack_capture_assist" );
        }
    }
}

// Namespace sabattack
// Params 1, eflags: 0x4
// Checksum 0xdf0cf9d7, Offset: 0x6c60
// Size: 0x257
function private function_b3e6ffa20ba846bf( scoringplayer )
{
    position = self.origin + ( 0, 0, 10 );
    nonplayeremped = 0;
    ents = emp_debuff::empdebuff_get_emp_ents( position, level.var_ed5e3594465c7efc );
    objweapon = makeweapon( "emp_grenade_mp" );
    
    foreach ( ent in ents )
    {
        if ( isplayer( ent ) )
        {
            continue;
        }
        
        entowner = ent.owner;
        
        if ( isdefined( entowner ) )
        {
            if ( !player_utility::playersareenemies( scoringplayer, entowner ) )
            {
                continue;
            }
        }
        
        data = damage_utility::packdamagedata( scoringplayer, ent, 1, objweapon, "MOD_EXPLOSIVE", scoringplayer, position );
        data.issubmunition = 0;
        data.scoreevent = data.victim.bundle.empedscoreevent;
        thread function_8414fd72ca678da3( data );
        nonplayeremped++;
    }
    
    if ( nonplayeremped >= 3 )
    {
        scoringplayer thread points::doscoreevent( #"emp_triple_disrupt" );
    }
    
    players = getplayersinradius( position, level.var_ed5e3594465c7efc );
    
    foreach ( player in players )
    {
        if ( !player emp_debuff::can_be_empd() )
        {
            continue;
        }
        
        if ( !player_utility::playersareenemies( scoringplayer, player ) )
        {
            continue;
        }
        
        data = damage_utility::packdamagedata( scoringplayer, player, 1, objweapon, "MOD_EXPLOSIVE", scoringplayer, position );
        data.scoreevent = #"emped_player";
        thread _emp_grenade_apply_player( data );
    }
}

// Namespace sabattack
// Params 1, eflags: 0x4
// Checksum 0x75212dfd, Offset: 0x6ebf
// Size: 0x48
function private function_8414fd72ca678da3( data )
{
    emp_debuff::apply_emp_struct( data );
    _emp_grenade_end_early( data, level.zoneEMPDuration );
    
    if ( isdefined( data.victim ) )
    {
        data.victim emp_debuff::remove_emp();
    }
}

// Namespace sabattack
// Params 1, eflags: 0x4
// Checksum 0x34ab1dc0, Offset: 0x6f0f
// Size: 0x1d6
function private _emp_grenade_apply_player( data )
{
    emp_debuff::apply_emp_struct( data );
    gamescore::trackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
    data.victim emp_debuff::play_emp_scramble( level.zoneEMPScrambleIntensity );
    data.victim.emp_grenade_tracker = { #weaponobj:data.objweapon };
    telemetry_mp::function_594cbdc6a4d8098a( data.victim, data.attacker, data.objweapon, data.grenadeid );
    
    if ( level.empgrenadesettings.emp_grenade_do_stun )
    {
        data.victim shellshock_utility_cpmp::_shellshock( %"emp", #"stun", level.zoneEMPDuration, 1 );
    }
    
    _emp_grenade_end_early( data, level.zoneEMPDuration );
    
    if ( isdefined( data.victim ) )
    {
        data.victim.emp_grenade_tracker = undefined;
        telemetry_mp::function_edb43d25c7bd56c6( data.victim, data.objweapon, data.grenadeid );
        data.victim emp_debuff::remove_emp();
        data.victim emp_debuff::stop_emp_scramble( level.zoneEMPScrambleIntensity );
        
        if ( player::isreallyalive( data.attacker ) )
        {
            gamescore::untrackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
        }
    }
}

// Namespace sabattack
// Params 2, eflags: 0x4
// Checksum 0xcbcc5dfe, Offset: 0x70ed
// Size: 0x3a
function private _emp_grenade_end_early( data, duration )
{
    data.victim endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait duration;
}

// Namespace sabattack
// Params 2
// Checksum 0xc228e19, Offset: 0x712f
// Size: 0x125
function function_949376910ff35c27( var_8c68f220eeb40c9d, var_b8ed9617b1ca8064 )
{
    if ( isdefined( var_8c68f220eeb40c9d ) )
    {
        foreach ( zone in var_8c68f220eeb40c9d )
        {
            objective_state( zone.objidnum, "current" );
        }
    }
    
    if ( isdefined( var_b8ed9617b1ca8064 ) )
    {
        foreach ( zone in var_b8ed9617b1ca8064 )
        {
            objective_state( zone.objidnum, "active" );
            calloutmarkerping::function_73084f64fa34a5a8( zone.objidnum );
        }
    }
}

// Namespace sabattack
// Params 1
// Checksum 0x35368aaf, Offset: 0x725c
// Size: 0x14f
function function_55879e89b9e74573( shutdownteam )
{
    self endon( #"game_ended" );
    
    foreach ( zone in level.allzones )
    {
        if ( zone.ownerteam == shutdownteam )
        {
            zone setscriptablepartstate( "main", "disabled" );
        }
        
        zone.overloadassists = [];
    }
    
    wait level.flagRespawnTime;
    
    foreach ( zone in level.allzones )
    {
        if ( zone.ownerteam == shutdownteam )
        {
            zone setscriptablepartstate( "main", zone.ownerteam );
        }
    }
}

// Namespace sabattack
// Params 0
// Checksum 0x30ce2b51, Offset: 0x73b3
// Size: 0x55
function function_c14570348203e217()
{
    if ( level.zoneHideOnNeutral )
    {
        function_949376910ff35c27( undefined, level.axiszone );
        function_949376910ff35c27( undefined, level.allieszone );
        return;
    }
    
    function_949376910ff35c27( level.axiszone, undefined );
    function_949376910ff35c27( level.allieszone, undefined );
}

// Namespace sabattack
// Params 0
// Checksum 0x3067748b, Offset: 0x7410
// Size: 0xca
function function_d239cda79ff15a4e()
{
    game[ "sabattack_dlogs" ].var_e6c482ba3007ac85 = [];
    game[ "sabattack_dlogs" ].var_e6c482ba3007ac85[ "axis" ][ "a" ] = 0;
    game[ "sabattack_dlogs" ].var_e6c482ba3007ac85[ "axis" ][ "b" ] = 0;
    game[ "sabattack_dlogs" ].var_e6c482ba3007ac85[ "allies" ][ "a" ] = 0;
    game[ "sabattack_dlogs" ].var_e6c482ba3007ac85[ "allies" ][ "b" ] = 0;
    game[ "sabattack_dlogs" ].var_c8eddfcfab3ad0b0 = "neutral";
    game[ "sabattack_dlogs" ].var_dea243d0ec7da0f8 = [ 0, 0, 0 ];
}

// Namespace sabattack
// Params 2
// Checksum 0xe9929e73, Offset: 0x74e2
// Size: 0xaa
function dlog_getteampositions( players, axis )
{
    teampos = [];
    
    foreach ( player in players )
    {
        if ( player::isreallyalive( player ) )
        {
            teampos[ teampos.size ] = player.origin[ axis ];
        }
    }
    
    return teampos;
}

// Namespace sabattack
// Params 1
// Checksum 0xc8a9bb6, Offset: 0x7595
// Size: 0xcd
function function_f4a4d0fb9cf70cb4( players )
{
    var_400293aed908c694 = [];
    
    foreach ( player in players )
    {
        if ( player::isreallyalive( player ) )
        {
            unoid = player getplayerunoid();
            unoid = unoid != "-1" && unoid != "" ? unoid : player.clientid;
            var_400293aed908c694[ var_400293aed908c694.size ] = unoid;
        }
    }
    
    return var_400293aed908c694;
}

// Namespace sabattack
// Params 1
// Checksum 0x14924d71, Offset: 0x766b
// Size: 0x2c1
function function_99240e28810e170a( flagstate )
{
    var_57e751c3de406314 = level.teamdata[ game[ "defenders" ] ][ "players" ];
    var_a071833d06ad3d6f = level.teamdata[ game[ "attackers" ] ][ "players" ];
    var_340de713e7d3fc45 = dlog_getteampositions( var_57e751c3de406314, 0 );
    var_340de613e7d3fa12 = dlog_getteampositions( var_57e751c3de406314, 1 );
    var_dd78bd45e525c738 = function_f4a4d0fb9cf70cb4( var_57e751c3de406314 );
    var_aa987a9339b19d7a = dlog_getteampositions( var_a071833d06ad3d6f, 0 );
    var_aa987b9339b19fad = dlog_getteampositions( var_a071833d06ad3d6f, 1 );
    var_a01e523347d680d = function_f4a4d0fb9cf70cb4( var_a071833d06ad3d6f );
    dlog_recordevent( "dlog_event_mp_sabattack_objective_state", [ "player_axis_pos_x", var_340de713e7d3fc45 ?? [], "player_axis_pos_y", var_340de613e7d3fa12 ?? [], "player_axis_uno_id", var_dd78bd45e525c738 ?? [], "player_allies_pos_x", var_aa987a9339b19d7a ?? [], "player_allies_pos_y", var_aa987b9339b19fad ?? [], "player_allies_uno_id", var_a01e523347d680d ?? [], "flag_owner", game[ "sabattack_dlogs" ].var_c8eddfcfab3ad0b0 ?? "undefined", "flag_pos_x", game[ "sabattack_dlogs" ].var_dea243d0ec7da0f8[ 0 ] ?? 0, "flag_pos_y", game[ "sabattack_dlogs" ].var_dea243d0ec7da0f8[ 1 ] ?? 0, "flag_state", flagstate ?? "undefined", "flag_origin_id", game[ "sabattack_dlogs" ].var_ec2e9e1d669b22e5 ?? 0, "flag_carrier_id", game[ "sabattack_dlogs" ].var_ea5ee11260856ef3 ?? 0, "objective_axis_a", game[ "sabattack_dlogs" ].var_e6c482ba3007ac85[ "axis" ][ "a" ] ?? 0, "objective_axis_b", game[ "sabattack_dlogs" ].var_e6c482ba3007ac85[ "axis" ][ "b" ] ?? 0, "objective_allies_a", game[ "sabattack_dlogs" ].var_e6c482ba3007ac85[ "allies" ][ "a" ] ?? 0, "objective_allies_b", game[ "sabattack_dlogs" ].var_e6c482ba3007ac85[ "allies" ][ "b" ] ?? 0 ] );
}

// Namespace sabattack
// Params 0
// Checksum 0x83b9d55, Offset: 0x7934
// Size: 0x209
function function_64313f41694d6fca()
{
    var_ff87b9cbd3924d43 = getentarray( "axis_zone", #targetname );
    var_d8129d407d1374dc = getentarray( "allies_zone", #targetname );
    var_b7fe6280f47e8e5d = utility::getstructarray( "sabattack_flag" );
    
    if ( !var_b7fe6280f47e8e5d )
    {
        assertmsg( "<dev string:xeb>" );
    }
    
    foreach ( ent in var_ff87b9cbd3924d43 )
    {
        level.var_e1221a6f06aed99d[ ent.script_noteworthy ] = ent;
    }
    
    foreach ( ent in var_d8129d407d1374dc )
    {
        level.var_99514dc2cb317036[ ent.script_noteworthy ] = ent;
    }
    
    foreach ( flagstruct in var_b7fe6280f47e8e5d )
    {
        level.flagspawnpos[ int( flagstruct.script_noteworthy ) ] = flagstruct;
    }
    
    level.var_7a2ebb4dd0b67273 = 0;
    
    if ( level.flagRandomizeOrder )
    {
        level.flagspawnpos = arrayrandomize( level.flagspawnpos );
    }
}

// Namespace sabattack
// Params 1
// Checksum 0x8fa78572, Offset: 0x7b45
// Size: 0x18, Type: bool
function function_8d961c2c2caf232c( player )
{
    return player == level.flagcarrier;
}

// Namespace sabattack
// Params 2
// Checksum 0x309fe9b4, Offset: 0x7b66
// Size: 0x397
function function_c99930779b5eece4( victim, attacker )
{
    if ( !isplayer( attacker ) || !isplayer( victim ) || attacker.team == victim.team )
    {
        return;
    }
    
    foreach ( zone in level.allzones )
    {
        var_ea80f21858941a32 = distancesquared( zone.origin, attacker.origin );
        var_6e5e87709df64131 = distancesquared( zone.origin, victim.origin );
        
        if ( zone.ownerteam == attacker.team && var_6e5e87709df64131 < 250000 )
        {
            assiststruct = { #timestamp:gettime(), #player:victim };
            zone.overloadassists[ zone.overloadassists.size ] = assiststruct;
        }
        
        if ( victim == level.flagcarrier && attacker != victim )
        {
            carrierkill = 1;
            
            if ( var_6e5e87709df64131 <= 160000 && zone.ownerteam == attacker.team )
            {
                stoppedshort = 1;
            }
        }
        
        if ( victim != level.flagcarrier )
        {
            var_95ab8afe4c00afb7 = level.flagcarrier ? distancesquared( zone.origin, level.flagcarrier.origin ) : undefined;
            var_95ab8afe4c00afb7 = !var_95ab8afe4c00afb7 && level.var_e4d7f49e8039a388 ? distancesquared( zone.origin, level.var_e4d7f49e8039a388.origin ) : var_95ab8afe4c00afb7;
            isinrange = var_ea80f21858941a32 < 105625 && var_95ab8afe4c00afb7 < 105625;
        }
        
        if ( isinrange )
        {
            attacker thread function_34601cc809766808();
            
            if ( zone.ownerteam == attacker.team )
            {
                attacker events::function_20a5f572df6afd43();
                break;
            }
            
            attacker events::function_58da673c1c3fc9f2();
            break;
        }
    }
    
    if ( carrierkill )
    {
        scoreevent = stoppedshort ? #"sabattack_stopped_short" : #"sabattack_kill_carrier";
        attacker thread points::doscoreevent( scoreevent );
        attacker thread function_34601cc809766808();
        attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 25, 1 );
    }
    
    if ( attacker == level.flagcarrier )
    {
        attacker thread points::doscoreevent( #"hash_b90e4a810f4b4b44" );
        attacker thread function_34601cc809766808();
        attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 26, 1 );
        return;
    }
    
    if ( attacker.team == level.flagcarrier.team )
    {
        var_d7c933cab2b4e44c = distancesquared( level.flagcarrier.origin, attacker.origin );
        
        if ( var_d7c933cab2b4e44c < 105625 )
        {
            attacker thread points::doscoreevent( #"hash_33cff698d896a6a9" );
            attacker thread function_34601cc809766808();
        }
    }
}

// Namespace sabattack
// Params 1
// Checksum 0xa1f63918, Offset: 0x7f05
// Size: 0x124
function function_fc2d3d457e25d10( firstflag )
{
    game[ "sabattack_dlogs" ].var_ec2e9e1d669b22e5 = 0;
    
    if ( firstflag )
    {
        return level.flagspawnpos[ 0 ];
    }
    
    if ( level.flagRespawnType == 0 )
    {
        if ( level.var_7a2ebb4dd0b67273 == level.flagspawnpos.size - 1 )
        {
            level.var_7a2ebb4dd0b67273 = 0;
            return level.flagspawnpos[ level.var_7a2ebb4dd0b67273 ];
        }
        else
        {
            level.var_7a2ebb4dd0b67273++;
            game[ "sabattack_dlogs" ].var_ec2e9e1d669b22e5 = level.var_7a2ebb4dd0b67273;
        }
        
        return level.flagspawnpos[ level.var_7a2ebb4dd0b67273 ];
    }
    
    if ( level.flagRespawnType == 1 )
    {
        game[ "sabattack_dlogs" ].var_ec2e9e1d669b22e5 = utility::array_random( level.flagspawnpos );
        return game[ "sabattack_dlogs" ].var_ec2e9e1d669b22e5;
    }
    
    if ( level.flagRespawnType == 2 )
    {
        return level.flagspawnpos[ 0 ];
    }
    
    return level.flagspawnpos[ 0 ];
}

// Namespace sabattack
// Params 0
// Checksum 0xdf9a09fc, Offset: 0x8031
// Size: 0x55
function function_530d399600e13c30()
{
    if ( level.flagResetType == 0 )
    {
        return level.flagspawnpos[ level.var_7a2ebb4dd0b67273 ];
    }
    
    if ( level.flagResetType == 1 )
    {
        return level.flagspawnpos[ 0 ];
    }
    
    return utility::array_random( level.flagspawnpos );
}

// Namespace sabattack
// Params 0, eflags: 0x4
// Checksum 0x2b19a4b1, Offset: 0x808e
// Size: 0x347
function private function_6be2a4a5a41450a8()
{
    level endon( #"game_ended" );
    var_8256c339490c0b2e = ( 0, 0, 0 );
    var_7361d5a4eaefbfca = ( 0, 0, 0 );
    
    foreach ( zone in level.axiszone )
    {
        var_8256c339490c0b2e += zone.origin;
    }
    
    foreach ( zone in level.allieszone )
    {
        var_7361d5a4eaefbfca += zone.origin;
    }
    
    var_8256c339490c0b2e /= level.axiszone.size;
    var_7361d5a4eaefbfca /= level.allieszone.size;
    dist = level.var_82e85a0f5c559b2b;
    diraxis = vectornormalize( var_7361d5a4eaefbfca - var_8256c339490c0b2e );
    dirallies = vectornormalize( var_8256c339490c0b2e - var_7361d5a4eaefbfca );
    
    foreach ( zone in level.axiszone )
    {
        zone.var_4ed87a63fa709c7a = zone.origin + diraxis * dist;
    }
    
    foreach ( zone in level.allieszone )
    {
        zone.var_4ed87a63fa709c7a = zone.origin + dirallies * dist;
    }
    
    /#
        if ( getdvarint( @"hash_5d415a9b26790631", 0 ) )
        {
            thread function_db1abc37d70466e5( var_8256c339490c0b2e, var_7361d5a4eaefbfca );
        }
    #/
    
    level.var_492e50e8b77d81bf = function_2f4cda1f126bb632( level.axiszone[ 0 ].var_4ed87a63fa709c7a, level.axiszone[ 1 ].var_4ed87a63fa709c7a, level.flagspawnpos[ 0 ].origin );
    level.var_d4d4bb9fa607b4bc = function_2f4cda1f126bb632( level.allieszone[ 0 ].var_4ed87a63fa709c7a, level.allieszone[ 1 ].var_4ed87a63fa709c7a, level.flagspawnpos[ 0 ].origin );
}

// Namespace sabattack
// Params 0, eflags: 0xc
// Checksum 0xe11a4850, Offset: 0x83dd
// Size: 0x34c
function private function_cee3f439e8130815()
{
    self notify( #"hash_3b98305478eddd4f" );
    self endon( #"hash_3b98305478eddd4f" );
    level endon( #"game_ended" );
    level endon( #"hash_1b1f8349ca64d6b3" );
    level endon( #"flag_reset" );
    level endon( #"flag_state_changed" );
    
    if ( !level.flagcarrier )
    {
        return;
    }
    
    friendlyzones = level.flagcarrier.team == game[ "defenders" ] ? level.axiszone : level.allieszone;
    
    while ( true )
    {
        if ( !level.flagcarrier )
        {
            wait 5;
            continue;
        }
        
        var_a6f4f1d28f301d3f = !function_7fa904130e7a9030( friendlyzones[ 0 ].var_4ed87a63fa709c7a, friendlyzones[ 1 ].var_4ed87a63fa709c7a );
        
        if ( var_a6f4f1d28f301d3f )
        {
            if ( !level.var_8b19ee2132ba7788 )
            {
                level.var_8b19ee2132ba7788 = gettime();
            }
            
            if ( !isdefined( level.var_a660edc4804f8be9[ level.flagcarrier.team ] ) )
            {
                level.var_a660edc4804f8be9[ level.flagcarrier.team ] = 0;
                level.var_712aadda09e8ccdf[ level.flagcarrier.team ] = 1000;
            }
            else
            {
                var_38ab1a8ecfb1cfbd = gettime();
                level.var_a660edc4804f8be9[ level.flagcarrier.team ] += var_38ab1a8ecfb1cfbd - level.var_8b19ee2132ba7788;
                level.var_8b19ee2132ba7788 = var_38ab1a8ecfb1cfbd;
                setomnvar( "ui_sabattack_anti_stall_timer", int( ( level.var_2879696b36d50c54 - level.var_a660edc4804f8be9[ level.flagcarrier.team ] ) / 1000 ) + 1 );
                setomnvar( "ui_sabattack_anti_stall", 1 );
                
                if ( level.var_a660edc4804f8be9[ level.flagcarrier.team ] > level.var_712aadda09e8ccdf[ level.flagcarrier.team ] )
                {
                    level.var_712aadda09e8ccdf[ level.flagcarrier.team ] += 1000;
                    level thread function_9487c9bc98d4cc91( #"hash_365ac8ce656cd2a6", game[ "defenders" ] );
                    level thread function_9487c9bc98d4cc91( #"hash_365ac8ce656cd2a6", game[ "attackers" ] );
                }
            }
            
            if ( level.var_a660edc4804f8be9[ level.flagcarrier.team ] > level.var_2879696b36d50c54 )
            {
                level.var_a660edc4804f8be9 = undefined;
                level.var_712aadda09e8ccdf = undefined;
                level.var_8b19ee2132ba7788 = undefined;
                level.flagcarrier forceclearvfx();
                level function_3c2004899d2a57c7();
                iprintlnbold( " CARRIER STALLED FOR TOO LONG, RESET EMP!" );
                level notify( #"hash_1b1f8349ca64d6b3" );
            }
        }
        else
        {
            level.var_8b19ee2132ba7788 = undefined;
            setomnvar( "ui_sabattack_anti_stall", 0 );
        }
        
        wait 0.2;
    }
}

// Namespace sabattack
// Params 2, eflags: 0x4
// Checksum 0x5aa07f7e, Offset: 0x8731
// Size: 0x8f, Type: bool
function private function_7fa904130e7a9030( linea, lineb )
{
    if ( !level.flagcarrier )
    {
        return false;
    }
    
    sideplayer = function_2f4cda1f126bb632( linea, lineb, level.flagcarrier.origin );
    sideflag = level.flagcarrier.team == game[ "defenders" ] ? level.var_492e50e8b77d81bf : level.var_d4d4bb9fa607b4bc;
    return sideflag * sideplayer >= 0;
}

// Namespace sabattack
// Params 3, eflags: 0x4
// Checksum 0xc7a1888c, Offset: 0x87c9
// Size: 0x41
function private function_2f4cda1f126bb632( linea, lineb, vectororigin )
{
    return ( lineb[ 0 ] - linea[ 0 ] ) * ( vectororigin[ 1 ] - linea[ 1 ] ) - ( lineb[ 1 ] - linea[ 1 ] ) * ( vectororigin[ 0 ] - linea[ 0 ] );
}

// Namespace sabattack
// Params 0, eflags: 0x4
// Checksum 0x8b85d94f, Offset: 0x8813
// Size: 0x21
function private function_e84ecccbc50e4a9()
{
    return abs( game[ "teamScores" ][ "axis" ] - game[ "teamScores" ][ "allies" ] );
}

// Namespace sabattack
// Params 3, eflags: 0x4
// Checksum 0xa8312354, Offset: 0x883d
// Size: 0x90
function private function_7e2f4f34e9f6e6ec( dialog, team, group )
{
    if ( level.var_d6fa458e88929c45 )
    {
        return;
    }
    
    if ( !level.var_63dcf652e83b7179[ dialog ] || level.var_63dcf652e83b7179[ dialog ] < gettime() )
    {
        dialog::statusdialog( dialog, team, group );
        level notify( dialog + "timeout" );
        waitframe();
        level.var_63dcf652e83b7179[ dialog ] = gettime() + level.var_b3771cb2c2c65592 * 1000;
        level thread function_3ae8ebe3ee4df4f3( dialog );
    }
}

// Namespace sabattack
// Params 1, eflags: 0x4
// Checksum 0x2a4ed83f, Offset: 0x88d5
// Size: 0x39
function private function_3ae8ebe3ee4df4f3( dialog )
{
    level endon( #"game_ended" );
    level endon( dialog + "timeout" );
    wait level.var_b3771cb2c2c65592;
    level.var_63dcf652e83b7179[ dialog ] = undefined;
}

// Namespace sabattack
// Params 3
// Checksum 0x131b380b, Offset: 0x8916
// Size: 0xbb
function function_9487c9bc98d4cc91( sfxref, team, var_f27652a61981188d )
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( player.team == team && player != var_f27652a61981188d )
        {
            player playlocalsound( sfxref );
        }
    }
}

// Namespace sabattack
// Params 2
// Checksum 0x36734596, Offset: 0x89d9
// Size: 0x257
function function_871edcd623d8244( flagstate, var_bd6746070c636f69 )
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_sabattackDebugFlagState", flagstate );
        player setclientomnvar( "ui_sabattackDebugSectorState", var_bd6746070c636f69 );
        friendlya = level.axiszone[ 0 ].ownerteam == player.team ? level.axiszone[ 0 ].var_c078c56a993c121a : level.allieszone[ 0 ].var_c078c56a993c121a;
        friendlyb = level.axiszone[ 1 ].ownerteam == player.team ? level.axiszone[ 1 ].var_c078c56a993c121a : level.allieszone[ 1 ].var_c078c56a993c121a;
        enemya = level.axiszone[ 0 ].ownerteam == player.team ? level.allieszone[ 0 ].var_c078c56a993c121a : level.axiszone[ 0 ].var_c078c56a993c121a;
        enemyb = level.axiszone[ 1 ].ownerteam == player.team ? level.allieszone[ 1 ].var_c078c56a993c121a : level.axiszone[ 1 ].var_c078c56a993c121a;
        player setclientomnvar( "ui_sabattackFriendlySectorA", friendlya );
        player setclientomnvar( "ui_sabattackFriendlySectorB", friendlyb );
        player setclientomnvar( "ui_sabattackEnemySectorA", enemya );
        player setclientomnvar( "ui_sabattackEnemySectorB", enemyb );
    }
}

/#

    // Namespace sabattack
    // Params 1
    // Checksum 0x2aaca63d, Offset: 0x8c38
    // Size: 0x5e, Type: dev
    function flagdebug( flagdroppoint )
    {
        level endon( #"game_ended" );
        self endon( #"flag_state_changed" );
        
        while ( true )
        {
            cylinder( flagdroppoint, flagdroppoint + ( 0, 0, 60 ), 20, ( 0, 1, 0 ), 0, 10 );
            wait 0.01;
        }
    }

    // Namespace sabattack
    // Params 0
    // Checksum 0x4b99e06a, Offset: 0x8c9e
    // Size: 0x76, Type: dev
    function function_6d90b52e7f66709a()
    {
        player = level.player;
        player_origin = player getorigin();
        string_position = "<dev string:x144>" + int( player_origin[ 0 ] ) + "<dev string:x146>" + int( player_origin[ 1 ] ) + "<dev string:x146>" + int( player_origin[ 2 ] ) + "<dev string:x149>";
        function_3bc604f9c0efa918( string_position );
        iprintlnbold( "<dev string:x14b>" );
    }

    // Namespace sabattack
    // Params 2
    // Checksum 0xbb972f05, Offset: 0x8d1c
    // Size: 0x2fa, Type: dev
    function function_db1abc37d70466e5( attaso, var_31c0ae991ef770e6 )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            foreach ( zone in level.axiszone )
            {
                cylinder( zone.origin, zone.origin + ( 0, 0, 80 ), 60, ( 0, 0, 1 ), 0, 1 );
                line( zone.origin, zone.var_4ed87a63fa709c7a, ( 1, 1, 0 ), 1 );
            }
            
            foreach ( zone in level.allieszone )
            {
                cylinder( zone.origin, zone.origin + ( 0, 0, 80 ), 60, ( 1, 0, 0 ), 0, 1 );
                line( zone.origin, zone.var_4ed87a63fa709c7a, ( 1, 1, 0 ), 1 );
            }
            
            line( attaso, var_31c0ae991ef770e6, ( 0, 1, 0 ), 1 );
            line( level.axiszone[ 0 ].var_4ed87a63fa709c7a, level.axiszone[ 1 ].var_4ed87a63fa709c7a, ( 0, 0, 1 ), 1 );
            line( level.allieszone[ 0 ].var_4ed87a63fa709c7a, level.allieszone[ 1 ].var_4ed87a63fa709c7a, ( 1, 0, 0 ), 1 );
            
            if ( level.var_a660edc4804f8be9[ "<dev string:x170>" ] )
            {
                printtoscreen2d( 200, 1000, "<dev string:x175>" + level.var_a660edc4804f8be9[ "<dev string:x170>" ] / 1000 + "<dev string:x189>", ( 1, 0, 0 ), 2, 1 );
            }
            
            if ( level.var_a660edc4804f8be9[ "<dev string:x193>" ] )
            {
                printtoscreen2d( 200, 1050, "<dev string:x19a>" + level.var_a660edc4804f8be9[ "<dev string:x193>" ] / 1000 + "<dev string:x189>", ( 0, 0, 1 ), 2, 1 );
            }
            
            waitframe();
        }
    }

#/
