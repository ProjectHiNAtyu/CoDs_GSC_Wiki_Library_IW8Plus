// scripts\mp\br\gametypes\br_safecrack_quest.gsc  (hash_35e1a0bf98fae03a.gscc) (size: 28331 Bytes / 0x6eab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee5e4a01 (3999156737)
// size ...... 28331 (0x6eab)
// includes .. 21  (offset: 0x6847)
// strings ... 86  (offset: 0x68ef)
// dev strs .. 8   (offset: 0x6e1f)
// exports ... 57  (offset: 0x479f)
// cseg ...... 0x77b + 0x4024 (0x479f)
// imports ... 195 (offset: 0x5087)
// animtree1 . 1   (offset: 0x6e7f)
// animtree2 . 2   (offset: 0x6e8b)
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_chain_manager;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\br\gametypes\br_scavenger_quest;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_safes;
#using scripts\mp\entityheadicons;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_cache;
#using scripts\mp\objidpoolmanager;

#namespace br_safecrack_quest;

// Namespace br_safecrack_quest
// Params 1
// Checksum 0xdd6e6eb, Offset: 0x799
// Size: 0x597
function getcontractdata( data )
{
    scriptable::scriptable_addusedcallbackbypart( "safe", &function_fc9d7ffc6d980f45 );
    dmz_safes::script_model_anims();
    level.br_safecrack_quest = spawnstruct();
    var_47b2c991ea1286f0 = getdvarint( @"hash_5ea4fa2ae23946a7", 0 );
    level.br_safecrack_quest.time = var_47b2c991ea1286f0 != 0 ? var_47b2c991ea1286f0 : br_contract_manager::function_4bc46e9c9bb0d265( "safecracker" );
    level.br_safecrack_quest.timebonus = getdvarint( @"hash_cfd8130a7ac5bdcf", 90 );
    level.br_safecrack_quest.numsafes = getdvarint( @"hash_62eed71e92d5aed0", 1 );
    level.br_safecrack_quest.var_55db45be21f8dda8 = getdvarint( @"hash_952302af5ebc79d4", 3000 );
    level.br_safecrack_quest.var_c33514bcf1bd0170 = level.br_safecrack_quest.var_55db45be21f8dda8 * level.br_safecrack_quest.var_55db45be21f8dda8;
    level.br_safecrack_quest.var_6ea8390fe564dc8e = getdvarint( @"hash_fb53e617c8ba412a", 11800 );
    level.br_safecrack_quest.var_e0e47fe181d63062 = level.br_safecrack_quest.var_6ea8390fe564dc8e * level.br_safecrack_quest.var_6ea8390fe564dc8e;
    level.br_safecrack_quest.var_7e8e825f5e123833 = getdvarfloat( @"hash_5d0dbfbbd490c400", 4 );
    level.br_safecrack_quest.var_a923bc5e857f7ff = getdvarint( @"hash_b8bc0db35821cdca", 5000 );
    level.br_safecrack_quest.var_593f6d0ec779dec1 = getdvarint( @"hash_9928ca92a88608a4", 9900 );
    level.br_safecrack_quest.var_40300831b7786959 = getdvarint( @"hash_a868de1aa94e39c", 1 );
    level.br_safecrack_quest.var_89bae1f3eecc784a = getdvarint( @"hash_6197c0161edb1dc5", 1 );
    level.br_safecrack_quest.safedeletedelay = getdvarint( @"hash_bb228e00bd7b5c27", 45 );
    level.br_safecrack_quest.var_c1873a447470e4c6 = getdvarfloat( @"hash_d2c15d7f43bb9e4c", 5 );
    level.br_safecrack_quest.var_93d89a31c1566b50 = getdvarint( @"hash_54dca27f5ecfa36e", 1000 );
    level.br_safecrack_quest.var_a816396920a72e6b = getdvarfloat( @"hash_829de2bbb4cef69f", 4 );
    level.br_safecrack_quest.var_db9da11abe8106c9 = getdvarint( @"hash_efae0b9a025ad8ba", 1 );
    level.br_safecrack_quest.usedrill = getdvarint( @"hash_ababf6639b219f6b", 1 );
    level.br_safecrack_quest.capturetime = getdvarint( @"scr_br_safe_capture_time", 45 );
    level.br_safecrack_quest.captureradius = getdvarint( @"scr_br_safe_capture_radius", 400 );
    level.br_safecrack_quest.playmusic = getdvarint( @"scr_br_safe_play_music", 0 );
    level.br_safecrack_quest.var_47993bbceb8df306 = 21;
    level.br_safecrack_quest.var_27de48b1defb8ee0 = 0;
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "mission_safecrack_accept" ] = "sfcr_wzan_msss";
    game[ "dialog" ][ "mission_safecrack_success" ] = "sfcr_wzan_msnc";
    game[ "dialog" ][ "mission_safecrack_fail" ] = "sfcr_wzan_tmlr";
    game[ "dialog" ][ "mission_safecrack_safe1" ] = "sfcr_wzan_tmsn";
    game[ "dialog" ][ "mission_safecrack_safe1_first_person" ] = "sfcr_wzan_plsn";
    game[ "dialog" ][ "mission_safecrack_safe2" ] = "sfcr_wzan_tmst";
    game[ "dialog" ][ "mission_safecrack_safe2_first_person" ] = "sfcr_wzan_plst";
    data.funcs[ "onInit" ] = &quest_oninit;
    data.funcs[ "onShowAgain" ] = &quest_onshowagain;
    data.funcs[ "onTeamAssigned" ] = &quest_onteamassigned;
    data.funcs[ "onEnterGulag" ] = &quest_onentergulag;
    data.funcs[ "onPlayerRespawn" ] = &quest_onrespawn;
    data.funcs[ "onPlayerKilled" ] = &quest_onplayerkilled;
    data.funcs[ "onMarkPlayerAsEliminated" ] = &function_22116566150b5d1;
    data.funcs[ "onPlayerDisconnect" ] = &quest_onplayerdisconnect;
    data.funcs[ "onCancel" ] = &quest_oncancel;
    data.funcs[ "onPlayerTearDown" ] = &quest_onplayerteardown;
    data.funcs[ "onPlayerAssimilated" ] = &quest_onplayerassimilated;
    data.funcs[ "circleTick" ] = &function_70034271e970d006;
    data.funcs[ "onTimerExpired" ] = &function_88679453542a90b3;
    data.funcs[ "validateContractNotInStronghold" ] = &function_3bb84e539e07451a;
    data.funcs[ "onEliteTearDown" ] = &quest_oneliteteardown;
    function_12f9411960afdc14();
    
    /#
        debug_init();
    #/
}

#using_animtree( "script_model" );

// Namespace br_safecrack_quest
// Params 0
// Checksum 0x367556b1, Offset: 0xd38
// Size: 0xc6
function function_b45fd249c7d15779()
{
    level.scr_animtree[ "safe_drill_player" ] = #animtree;
    level.scr_anim[ "safe_drill_player" ][ "safedrill_enter" ] = %jup_wz_cq_safedrill_enter_sdr;
    level.scr_eventanim[ "safe_drill_player" ][ "safedrill_enter" ] = %"cq_safedrill_enter";
    level.scr_viewmodelanim[ "safe_drill_player" ][ "safedrill_enter" ] = "jup_wz_cq_safedrill_enter_sdr";
    level.scr_anim[ "safe_drill_player" ][ "safedrill_exit" ] = %jup_wz_cq_safedrill_exit_sdr;
    level.scr_eventanim[ "safe_drill_player" ][ "safedrill_exit" ] = %"cq_safedrill_exit";
    level.scr_viewmodelanim[ "safe_drill_player" ][ "safedrill_exit" ] = "jup_wz_cq_safedrill_exit_sdr";
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0x862ce802, Offset: 0xe06
// Size: 0x10d, Type: bool
function quest_oninit()
{
    self.safestructs = [];
    safelocations = function_77ff85f8e0480566( self.iselite );
    
    if ( !function_361f7a01917ce5d4( safelocations ) )
    {
        logstring( "br_safecrack_quest::quest_onInit - Safecracker quest failed to find a Safe!" );
        return false;
    }
    
    foreach ( safelocation in safelocations )
    {
        safestruct = spawnstruct();
        safestruct.progressstruct = spawnstruct();
        safestruct.progressstruct.safelocation = safelocation;
        safestruct.safelocation = safelocation;
        self.safestructs[ self.safestructs.size ] = safestruct;
    }
    
    self.safescracked = 0;
    return true;
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0xb27638b8, Offset: 0xf1c
// Size: 0x3, Type: bool
function quest_onshowagain()
{
    return false;
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0x9038e912, Offset: 0xf28
// Size: 0x2ce
function quest_onteamassigned()
{
    self.category = "safecracker";
    teamname = self.team;
    time = level.br_safecrack_quest.time;
    
    if ( !self.iselite )
    {
        br_contract_manager::function_87e10a6e85d45d58( "safecracker" );
        time = br_contract_manager::function_2f14979bf83bc3db( time );
        br_contract_manager::function_3fbbc67df36be7bb( time, 0 );
    }
    else
    {
        br_contract_manager::function_87e10a6e85d45d58( "elite_safecracker" );
    }
    
    self.safes = [];
    
    foreach ( safestruct in self.safestructs )
    {
        safestruct.safe = safe_spawn( safestruct.safelocation.origin, safestruct.safelocation.angles );
        safestruct.safe.safestruct = safestruct;
        safestruct.safe.teams = self.teams;
    }
    
    if ( level.br_safecrack_quest.var_40300831b7786959 )
    {
        foreach ( safestruct in self.safestructs )
        {
            safestruct function_418c503e85a71447( teamname, self.iselite );
            safestruct.progressstruct function_6a3d715186eba5cf( teamname, self.iselite );
            safestruct function_c30a8e9e9b5da6f6( teamname );
        }
    }
    else
    {
        self.safestructs[ 0 ] function_418c503e85a71447( teamname, self.iselite );
        safestruct.progressstruct function_6a3d715186eba5cf( teamname, self.iselite );
        self.safestructs[ 0 ] function_c30a8e9e9b5da6f6( teamname );
    }
    
    if ( !self.iselite )
    {
        br_contract_manager::function_5c7e547ccc13711b( "br_safecracker_quest_start_team" );
        br_contract_manager::function_ba80ad6a1d946b85( 6, br_contract_manager::getquestindex( "safecracker" ) );
        level thread br_public::brleaderdialogteam( "mission_safecrack_accept", teamname, 1, 2, undefined, "dx_br_jpbm_" );
        return;
    }
    
    level thread br_public::brleaderdialogteam( "arrow_start_safecrack", teamname, undefined, 2 );
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0x9c77f8d9, Offset: 0x11fe
// Size: 0x20
function quest_onentergulag( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        function_a16f86d4dce53a17( player );
    }
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0x5c53f275, Offset: 0x1226
// Size: 0x35
function quest_onrespawn( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        function_2ce1dfb50619006( player );
    }
    
    if ( self.iselite )
    {
        br_elite_broken_arrow::arrow_onplayerrespawn( player );
    }
}

// Namespace br_safecrack_quest
// Params 2
// Checksum 0x37705256, Offset: 0x1263
// Size: 0x1e
function quest_onplayerkilled( attacker, victim )
{
    safecracker_playerremoved( victim );
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0x916ff844, Offset: 0x1289
// Size: 0x15
function function_22116566150b5d1( victim )
{
    safecracker_playerremoved( victim );
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0x514d0d65, Offset: 0x12a6
// Size: 0x15
function quest_onplayerdisconnect( player )
{
    safecracker_playerremoved( player );
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0x43a97c98, Offset: 0x12c3
// Size: 0x2a
function quest_oncancel( team )
{
    if ( self.team == team )
    {
        function_62d7554f9f5e5e6f( 0, undefined, undefined, "Cancel" );
    }
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0xf3ba63e4, Offset: 0x12f5
// Size: 0xa0
function safecracker_playerremoved( player )
{
    if ( self.iselite )
    {
        return;
    }
    
    if ( player.team == self.team )
    {
        filter = br_contract_manager::function_42827c79f1968770( player, level.contractmanager.defaultfilter );
        
        if ( !br_quest_util::isteamvalid( self.team, filter ) )
        {
            if ( level.br_safecrack_quest.var_db9da11abe8106c9 && self.finalbombplanted )
            {
                return;
            }
            
            function_62d7554f9f5e5e6f( 0, undefined, undefined, "Killed" );
        }
    }
}

// Namespace br_safecrack_quest
// Params 3
// Checksum 0x23abc006, Offset: 0x139d
// Size: 0x123
function function_dd72e973244442d1( success, rewards, endstate )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    self notify( #"task_ended" );
    br_contract_manager::endcontract( success, rewards, undefined, undefined, endstate );
    function_d2632165fedd3b1( self.team, !self.iselite );
    wait level.contractmanager.var_dc52ccd301b92f4f ?? 0.3;
    
    if ( level.br_safecrack_quest.playmusic )
    {
        foreach ( teamplayer in teams::getteamdata( self.team, "players" ) )
        {
            teamplayer stopplayermusicstate( "dmz_trap_drill" );
        }
    }
}

// Namespace br_safecrack_quest
// Params 3
// Checksum 0xf8053388, Offset: 0x14c8
// Size: 0x10b
function quest_onplayerteardown( player, oldteam, newteam )
{
    if ( oldteam == self.team )
    {
        function_a16f86d4dce53a17( player );
        player br_contract_manager::uiobjectivehide();
        
        foreach ( safestruct in self.safestructs )
        {
            if ( isdefined( safestruct.safe ) )
            {
                safestruct.safe disablescriptableplayeruse( player );
            }
        }
        
        if ( !br_quest_util::isteamvalid( self.team, level.contractmanager.defaultfilter ) )
        {
            thread function_325b88d1e08006b4();
            thread function_dd72e973244442d1( 0, undefined, "Assimilation" );
        }
    }
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0xba14939f, Offset: 0x15db
// Size: 0x2d
function quest_oneliteteardown( team )
{
    task = self;
    task thread function_325b88d1e08006b4();
    task function_d2632165fedd3b1( team, 0 );
}

// Namespace br_safecrack_quest
// Params 3
// Checksum 0x796c1f61, Offset: 0x1610
// Size: 0xea
function quest_onplayerassimilated( player, oldteam, newteam )
{
    if ( newteam == self.team )
    {
        function_2ce1dfb50619006( player );
        player br_contract_manager::uiobjectiveshow( "safecracker" );
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
        
        foreach ( safestruct in self.safestructs )
        {
            if ( isdefined( safestruct.safe ) )
            {
                safestruct.safe enablescriptableplayeruse( player );
            }
        }
    }
}

// Namespace br_safecrack_quest
// Params 2
// Checksum 0x3cda7669, Offset: 0x1702
// Size: 0x11f
function function_70034271e970d006( dangercircleorigin, var_1bdc861911b3625e )
{
    if ( self.var_b6c5eeeebd9383f5 )
    {
        return;
    }
    
    foreach ( safestruct in self.safestructs )
    {
        if ( isdefined( safestruct.safe ) )
        {
            if ( safestruct.safe.bombplanted )
            {
                continue;
            }
            
            if ( safestruct.safe.drilling )
            {
                continue;
            }
            
            if ( !br_circle_util::ispointindangercircle( safestruct.safe.origin ) )
            {
                self.var_b6c5eeeebd9383f5 = 1;
                function_62d7554f9f5e5e6f( 1, "br_safecracker_quest_obj_circle", "mission_safecrack_fail", "Circle", "dx_br_jpbm_" );
                return;
            }
        }
    }
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0x8113f007, Offset: 0x1829
// Size: 0x14a
function function_88679453542a90b3()
{
    if ( self.iselite )
    {
        return;
    }
    
    foreach ( safestruct in self.safestructs )
    {
        if ( isdefined( safestruct.safe ) && safestruct.safe.bombplanted && !safestruct.safe.opened )
        {
            wait level.br_safecrack_quest.var_c1873a447470e4c6;
            br_contract_manager::function_a21d0af31443edfc();
            return;
        }
        
        if ( isdefined( safestruct.safe ) && safestruct.safe.drilling && !safestruct.safe.opened )
        {
            wait 5;
            br_contract_manager::function_a21d0af31443edfc();
            return;
        }
    }
    
    function_62d7554f9f5e5e6f( 1, "br_safecracker_quest_timer_expired", "mission_safecrack_fail", "Time", "dx_br_jpbm_" );
}

// Namespace br_safecrack_quest
// Params 5
// Checksum 0xa9697b6a, Offset: 0x197b
// Size: 0x95
function function_62d7554f9f5e5e6f( var_267793167a94cafb, splashref, voiceref, endstate, prefixoverride )
{
    if ( var_267793167a94cafb )
    {
        params = spawnstruct();
        params.intvar = 0;
        
        if ( !self.iselite )
        {
            br_contract_manager::function_5c7e547ccc13711b( splashref, params );
        }
        
        level thread br_public::brleaderdialogteam( voiceref, self.team, 1, 2, undefined, prefixoverride );
    }
    
    thread function_325b88d1e08006b4();
    thread function_dd72e973244442d1( 0, undefined, endstate );
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0x6c9a25ed, Offset: 0x1a18
// Size: 0x12a
function function_c30a8e9e9b5da6f6( teamname )
{
    self.safe setscriptablepartstate( "safe", "usable_not_open" );
    
    foreach ( player in level.players )
    {
        self.safe disablescriptableplayeruse( player );
    }
    
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        self.safe enablescriptableplayeruse( player );
    }
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0xaa6cca46, Offset: 0x1b4a
// Size: 0x398
function function_77ff85f8e0480566( iselite )
{
    safelocations = [];
    searchorigin = self.tablet.origin;
    var_b5eefdf655fda772 = undefined;
    locations = function_2aebfcc4122cc879( searchorigin );
    maxrange = level.br_safecrack_quest.var_6ea8390fe564dc8e;
    
    if ( iselite && !isdefined( locations ) )
    {
        maxrange = level.br_safecrack_quest.var_6ea8390fe564dc8e * level.br_safecrack_quest.var_7e8e825f5e123833;
        locations = function_82e8625986eae9bc( searchorigin );
    }
    
    if ( !isdefined( locations ) || locations.size < level.br_safecrack_quest.numsafes )
    {
        return;
    }
    
    if ( !level.br_circle_disabled )
    {
        var_baa7342c2419df11 = br_circle_util::function_472c93858e491e0a( self.tablet.origin );
        var_b5eefdf655fda772 = br_circle_util::function_b880c0f9998fdd69( var_baa7342c2419df11 );
    }
    
    for ( i = 0; i < level.br_safecrack_quest.numsafes ; i++ )
    {
        bestsafe = undefined;
        var_7a4dfc9ff5d7c219 = maxrange;
        
        foreach ( safe in locations )
        {
            if ( safe.inuse )
            {
                continue;
            }
            
            dist = distance2d( safe.origin, searchorigin );
            
            if ( !level.br_circle_disabled )
            {
                if ( !isdefined( safe.circletimeline ) )
                {
                    safe.circletimeline = br_circle_util::function_472c93858e491e0a( safe.origin );
                }
                
                var_4d410ddbe3d207be = br_circle_util::function_b880c0f9998fdd69( safe.circletimeline );
                
                if ( var_4d410ddbe3d207be < var_b5eefdf655fda772 )
                {
                    continue;
                }
            }
            
            var_ac99ac222f6bbc72 = 0;
            
            if ( dist < level.br_safecrack_quest.var_593f6d0ec779dec1 )
            {
                if ( dist < level.br_safecrack_quest.var_a923bc5e857f7ff )
                {
                    var_ac99ac222f6bbc72 = level.br_safecrack_quest.var_a923bc5e857f7ff - dist;
                }
            }
            else
            {
                var_ac99ac222f6bbc72 = dist - level.br_safecrack_quest.var_593f6d0ec779dec1;
            }
            
            if ( var_ac99ac222f6bbc72 < var_7a4dfc9ff5d7c219 )
            {
                if ( ai_fortress::function_fd527fe79c5d43e8( safe.origin, 0 ) )
                {
                    continue;
                }
                
                if ( br_scavenger_quest::function_9e34ff6f77321bef( safe.origin ) )
                {
                    continue;
                }
                
                if ( br_bunker_utility::function_5f3fda39a064e862( safe.origin ) )
                {
                    continue;
                }
                
                if ( locksandkeys::function_9894956c856a7904( safe.origin ) )
                {
                    continue;
                }
                
                var_7a4dfc9ff5d7c219 = var_ac99ac222f6bbc72;
                bestsafe = safe;
                
                if ( var_ac99ac222f6bbc72 <= 0 )
                {
                    break;
                }
            }
        }
        
        if ( isdefined( bestsafe ) )
        {
            bestsafe.inuse = 1;
            safelocations[ i ] = bestsafe;
            searchorigin = bestsafe.origin;
        }
    }
    
    if ( getdvarint( @"hash_aeb9e701a8ae6d", 1 ) && self.iselite && safelocations.size == 0 )
    {
        safelocations = function_1ae72939eb6ce630();
    }
    
    if ( safelocations.size < level.br_safecrack_quest.numsafes )
    {
        return;
    }
    
    return safelocations;
}

// Namespace br_safecrack_quest
// Params 2
// Checksum 0x812303ae, Offset: 0x1eeb
// Size: 0x43
function function_6c0f2d7c22d474ee( origin, angles )
{
    s_domnode = spawnstruct();
    s_domnode.origin = origin;
    s_domnode.angles = angles;
    return s_domnode;
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0xedcb367b, Offset: 0x1f37
// Size: 0x22d
function function_f47dfa464cf86eb1( origin )
{
    var_5d57e6b1782b7223 = [];
    temparray = [];
    temparray[ temparray.size ] = function_6c0f2d7c22d474ee( ( -543, -2456, 120 ), ( 0, 180, 0 ) );
    temparray[ temparray.size ] = function_6c0f2d7c22d474ee( ( -375, -640, 120 ), ( 0, 180, 0 ) );
    temparray[ temparray.size ] = function_6c0f2d7c22d474ee( ( 1921, -2767, 120 ), ( 0, 270, 0 ) );
    temparray[ temparray.size ] = function_6c0f2d7c22d474ee( ( 727, -668, 120 ), ( 0, 0, 0 ) );
    temparray[ temparray.size ] = function_6c0f2d7c22d474ee( ( 3949, 471, 120 ), ( 0, 90, 0 ) );
    temparray[ temparray.size ] = function_6c0f2d7c22d474ee( ( 5259, 485, 120 ), ( 0, 270, 0 ) );
    temparray[ temparray.size ] = function_6c0f2d7c22d474ee( ( 2914, 1449, 120 ), ( 0, 270, 0 ) );
    level.br_safecrack_quest.var_c3cd102377cdabe0 = temparray;
    
    foreach ( safe in level.br_safecrack_quest.var_c3cd102377cdabe0 )
    {
        if ( safe.inuse )
        {
            continue;
        }
        
        distsq = distance2dsquared( origin, safe.origin );
        
        if ( distsq >= level.br_safecrack_quest.var_c33514bcf1bd0170 && distsq <= level.br_safecrack_quest.var_e0e47fe181d63062 )
        {
            var_5d57e6b1782b7223[ var_5d57e6b1782b7223.size ] = safe;
        }
    }
    
    if ( var_5d57e6b1782b7223.size == 0 )
    {
        return;
    }
    
    return var_5d57e6b1782b7223;
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0x6f4c9406, Offset: 0x216d
// Size: 0x6b
function function_12f9411960afdc14()
{
    if ( !isdefined( level.br_safecrack_quest.var_c3cd102377cdabe0 ) )
    {
        dmz_safes = utility::getstructarray( "dmz_safe", "script_noteworthy" );
        br_safes = utility::getstructarray( "br_safe", "script_noteworthy" );
        level.br_safecrack_quest.var_c3cd102377cdabe0 = arraycombine( dmz_safes, br_safes );
    }
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0x8b723577, Offset: 0x21e0
// Size: 0x3a
function function_2aebfcc4122cc879( origin )
{
    return function_89b8b7d7bf3e21c( origin, level.br_safecrack_quest.var_c33514bcf1bd0170, level.br_safecrack_quest.var_e0e47fe181d63062 );
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0x7ca4247c, Offset: 0x2223
// Size: 0x86
function function_82e8625986eae9bc( origin )
{
    var_a4a55e0a2955f319 = level.br_safecrack_quest.var_7e8e825f5e123833 * level.br_safecrack_quest.var_7e8e825f5e123833;
    var_c33514bcf1bd0170 = level.br_safecrack_quest.var_c33514bcf1bd0170;
    var_e0e47fe181d63062 = level.br_safecrack_quest.var_e0e47fe181d63062 * var_a4a55e0a2955f319;
    return function_89b8b7d7bf3e21c( origin, var_c33514bcf1bd0170, var_e0e47fe181d63062 );
}

// Namespace br_safecrack_quest
// Params 3
// Checksum 0xd02750ae, Offset: 0x22b2
// Size: 0xf7
function function_89b8b7d7bf3e21c( origin, var_c33514bcf1bd0170, var_e0e47fe181d63062 )
{
    function_12f9411960afdc14();
    var_5d57e6b1782b7223 = [];
    
    foreach ( safe in level.br_safecrack_quest.var_c3cd102377cdabe0 )
    {
        if ( safe.inuse )
        {
            continue;
        }
        
        distsq = distance2dsquared( origin, safe.origin );
        
        if ( distsq >= var_c33514bcf1bd0170 && distsq <= var_e0e47fe181d63062 )
        {
            var_5d57e6b1782b7223[ var_5d57e6b1782b7223.size ] = safe;
        }
    }
    
    if ( var_5d57e6b1782b7223.size == 0 )
    {
        return;
    }
    
    return var_5d57e6b1782b7223;
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0x20079ffc, Offset: 0x23b2
// Size: 0x16b
function function_1ae72939eb6ce630()
{
    circlecenter = br_circle::getnextsafecircleorigin();
    circleradius = br_circle::getnextsafecircleradius();
    safelocations = [];
    bestdist = undefined;
    bestsafe = undefined;
    
    foreach ( safe in level.br_safecrack_quest.var_c3cd102377cdabe0 )
    {
        if ( safe.inuse )
        {
            continue;
        }
        
        if ( ai_fortress::function_fd527fe79c5d43e8( safe.origin, 0 ) )
        {
            continue;
        }
        
        if ( br_scavenger_quest::function_9e34ff6f77321bef( safe.origin ) )
        {
            continue;
        }
        
        if ( br_bunker_utility::function_5f3fda39a064e862( safe.origin ) )
        {
            continue;
        }
        
        if ( locksandkeys::function_9894956c856a7904( safe.origin ) )
        {
            continue;
        }
        
        dist = distance2dsquared( circlecenter, safe.origin );
        
        if ( !isdefined( bestdist ) || dist < bestdist )
        {
            bestdist = dist;
            bestsafe = safe;
        }
    }
    
    if ( isdefined( bestsafe ) )
    {
        safelocations[ 0 ] = bestsafe;
    }
    
    return safelocations;
}

// Namespace br_safecrack_quest
// Params 2
// Checksum 0x3022bab1, Offset: 0x2526
// Size: 0x152
function safe_spawn( origin, angles = ( 0, 0, 0 ) )
{
    var_72911a7432604ae1 = "br_quest_safe";
    
    if ( self.iselite )
    {
        var_72911a7432604ae1 = "br_nuke_safe";
    }
    
    if ( isdefined( level.var_48f37338243b6919 ) )
    {
        var_72911a7432604ae1 = [[ level.var_48f37338243b6919 ]]();
    }
    
    safe = spawnscriptable( var_72911a7432604ae1, origin, angles );
    safe.task = self;
    safe.capturetime = level.br_safecrack_quest.capturetime;
    safe.trigger = spawn( "trigger_radius", origin, 0, int( level.br_safecrack_quest.captureradius ), int( level.br_safecrack_quest.captureradius ) );
    safe.trigger utility::trigger_off();
    safe thread safe_watchtrigger( safe.trigger, level.br_safecrack_quest.captureradius );
    safe setscriptablepartstate( "safe", "unusable" );
    safe.bombplanted = 0;
    safe utility::function_8a74027bdea84771( &function_2b989a34106d988f );
    return safe;
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0x81791ac5, Offset: 0x2681
// Size: 0x47, Type: bool
function function_2b989a34106d988f()
{
    safe = self;
    
    if ( !self.opened && isdefined( safe.task ) )
    {
        safe.task function_62d7554f9f5e5e6f( 0, undefined, undefined, "AreaSwap" );
    }
    
    return false;
}

// Namespace br_safecrack_quest
// Params 6
// Checksum 0x4d6935e5, Offset: 0x26d1
// Size: 0x42a
function function_fc9d7ffc6d980f45( instance, part, state, player, bautouse, usestring )
{
    if ( player utility::callsharedfunc( #"gametype", #"hash_673db8bb5562ee19", instance ) )
    {
        return;
    }
    
    task = instance.task;
    
    if ( state == "usable_not_open" )
    {
        if ( player.team != task.team )
        {
            /#
                player iprintlnbold( "<dev string:x2b>" );
            #/
            
            return;
        }
        
        if ( level.br_safecrack_quest.usedrill )
        {
            instance.drilling = 1;
        }
        else
        {
            instance.bombplanted = 1;
        }
        
        if ( getdvarint( @"hash_2bd07e31cfab5dbf", 1 ) )
        {
            forwardvector = anglestoforward( instance.angles );
            sidevector = anglestoleft( instance.angles );
            instance.lootspawnpoint = spawnstruct();
            instance.lootspawnpoint.origin = instance.origin + forwardvector * 18 + sidevector * 10;
            instance.lootspawnpoint.angles = instance.angles + ( 0, -70, 0 );
        }
        
        if ( level.br_safecrack_quest.usedrill )
        {
            instance.trigger utility::trigger_on();
            instance setscriptablepartstate( part, "unusable" );
            instance thread dmz_safes::function_d369e14e462e6113( player );
            instance dmz_safes::function_f2cbcef06349c1f6( player, part );
            
            if ( instance.successfuluse )
            {
                objidpoolmanager::objective_set_play_intro( instance.safestruct.progressstruct.objectiveiconid, 0 );
                objidpoolmanager::update_objective_state( instance.safestruct.progressstruct.objectiveiconid, "current" );
                objidpoolmanager::objective_show_progress( instance.safestruct.progressstruct.objectiveiconid, 1 );
                objidpoolmanager::objective_teammask_addtomask( instance.safestruct.progressstruct.objectiveiconid, player.team );
                
                if ( task.iselite )
                {
                    task br_quest_util::uiobjectiveshowtoteam( "elite_safecracker_loot", task.teams[ 0 ] );
                    level thread br_contract_manager::utilflare_shootflare( instance.origin, "revive" );
                }
                
                if ( level.br_safecrack_quest.playmusic )
                {
                    dmz_audio::function_32ff837bc21a4833( player.team, "dmz_trap_drill", 0.5 );
                }
                
                instance thread safedrill_update( player );
            }
            else
            {
                instance.drilling = 0;
                instance setscriptablepartstate( part, "usable_not_open" );
            }
        }
        else
        {
            instance thread function_82ad73c5f828b382( player );
        }
        
        return;
    }
    
    if ( state == "usable_open" )
    {
        if ( !isdefined( instance.contents ) )
        {
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_quest_safe" );
            
            if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
            {
                common_cache::fillcontentsfromlist( instance, var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount );
            }
            
            level.br_safecrack_quest.var_27de48b1defb8ee0 += 1;
            
            if ( level.br_safecrack_quest.var_27de48b1defb8ee0 >= level.br_safecrack_quest.var_47993bbceb8df306 )
            {
                level.br_safecrack_quest.var_27de48b1defb8ee0 = 0;
            }
            
            instance.containertype = 4;
        }
        
        common_cache::function_60ce579fa7d3b6da( instance, part, state, player, bautouse, usestring );
    }
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0x46bb4241, Offset: 0x2b03
// Size: 0x4e
function function_f9ed5aebc78ad5db( dangericonent )
{
    dangericonent endon( #"death" );
    self waittill( #"death" );
    
    if ( isdefined( dangericonent.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( dangericonent.headiconid );
    }
    
    dangericonent delete();
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0xf572200, Offset: 0x2b59
// Size: 0x273
function function_82ad73c5f828b382( player )
{
    level endon( #"game_ended" );
    self setscriptablepartstate( "safe", "unusable" );
    dangericonent = player weapon::_launchgrenade( "safe_c4_danger_icon_mp", self.origin, ( 0, 0, 0 ), 100, 1 );
    dangericonent.weapon_object = makeweapon( "safe_c4_danger_icon_mp" );
    
    if ( self.task.safescracked == 2 || level.br_safecrack_quest.numsafes == 1 )
    {
        self.task.finalbombplanted = 1;
    }
    
    normforwardvec = vectornormalize( anglestoforward( self.angles ) );
    fwdoffset = normforwardvec * 19;
    origin = self.origin + fwdoffset + ( 0, 0, 30 );
    bomb = spawn( "script_model", origin );
    bomb.angles = self.angles + ( 0, -90, 0 );
    var_9628cb7bcce2364d = normforwardvec * 139;
    navobstacle = createnavbadplacebybounds( self.origin + var_9628cb7bcce2364d, ( 160, 280, 80 ), self.angles );
    bomb setmodel( "offhand_wm_c4_br_safe" );
    bomb setscriptablepartstate( "effects", "plant" );
    bomb thread function_f9ed5aebc78ad5db( dangericonent );
    bomb thread function_867c059a96660a10( level.br_safecrack_quest.var_c1873a447470e4c6 );
    wait level.br_safecrack_quest.var_c1873a447470e4c6;
    bomb.angles = self.angles;
    bomb.origin += fwdoffset;
    bomb setscriptablepartstate( "effects", "explodeWall" );
    wait 0.2;
    thread safe_opensafe( player );
    
    if ( isdefined( dangericonent.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( dangericonent.headiconid );
    }
    
    if ( isdefined( dangericonent ) )
    {
        dangericonent delete();
    }
    
    bomb hide();
    
    if ( isdefined( navobstacle ) )
    {
        destroynavobstacle( navobstacle );
    }
    
    wait 1.8;
    bomb delete();
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0x86aeeb17, Offset: 0x2dd4
// Size: 0x1aa
function function_867c059a96660a10( var_1d6a54705fb5167 )
{
    level endon( #"game_ended" );
    self endon( #"bomb_exploded" );
    self endon( #"bomb_defused" );
    self endon( #"death" );
    bomb = self;
    
    if ( soundexists( "breach_c4_plant_05" ) )
    {
        bomb playsound( "breach_c4_plant_05" );
    }
    
    var_86352882b34dd555 = int( var_1d6a54705fb5167 );
    var_5caf844838d733d2 = var_1d6a54705fb5167 - var_86352882b34dd555;
    
    if ( var_5caf844838d733d2 > 0 )
    {
        wait var_5caf844838d733d2;
        var_1d6a54705fb5167 = var_86352882b34dd555;
    }
    
    ticktime = 0.5;
    starttime = gettime();
    endtime = starttime + var_1d6a54705fb5167 * 1000;
    now = starttime;
    
    while ( now < endtime )
    {
        now = gettime();
        var_f4f3f0356fef8102 = endtime - now;
        
        if ( var_f4f3f0356fef8102 <= 1000 && soundexists( "breach_warning_beep_05" ) )
        {
            bomb playsound( "breach_warning_beep_05" );
            ticktime = 0.05;
        }
        else if ( var_f4f3f0356fef8102 <= 2000 && soundexists( "breach_warning_beep_04" ) )
        {
            bomb playsound( "breach_warning_beep_04" );
            ticktime = 0.25;
        }
        else if ( var_f4f3f0356fef8102 <= 3000 && soundexists( "breach_warning_beep_03" ) )
        {
            bomb playsound( "breach_warning_beep_03" );
            ticktime = 0.5;
        }
        else if ( var_f4f3f0356fef8102 <= 4000 && soundexists( "breach_warning_beep_02" ) )
        {
            bomb playsound( "breach_warning_beep_02" );
        }
        else if ( soundexists( "breach_warning_beep_01" ) )
        {
            bomb playsound( "breach_warning_beep_01" );
        }
        
        wait ticktime;
    }
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0xfc6f703e, Offset: 0x2f86
// Size: 0x660
function safe_opensafe( player )
{
    task = self.task;
    teamname = task.team;
    players = teams::getteamdata( teamname, "players" );
    self setscriptablepartstate( "safe", "opening" );
    
    if ( level.br_safecrack_quest.playmusic )
    {
        foreach ( teamplayer in teams::getteamdata( teamname, "players" ) )
        {
            teamplayer stopplayermusicstate( "dmz_trap_drill" );
        }
    }
    
    self.opened = 1;
    
    if ( getdvarint( @"hash_2bd07e31cfab5dbf", 1 ) )
    {
        foreach ( player in level.players )
        {
            self disablescriptableplayeruse( player );
        }
        
        level.br_safecrack_quest.var_27de48b1defb8ee0 += 1;
        
        if ( level.br_safecrack_quest.var_27de48b1defb8ee0 >= level.br_safecrack_quest.var_47993bbceb8df306 )
        {
            level.br_safecrack_quest.var_27de48b1defb8ee0 = 0;
        }
        
        foreach ( player in players )
        {
            self disablescriptableplayeruse( player );
        }
        
        wait 0.8;
        br_quest_util::questrewarddropitems( player.team, self.lootspawnpoint.origin, self.lootspawnpoint.angles, "br_quest_safe" );
    }
    
    thread function_97fcc0b844853037();
    
    if ( isdefined( task ) )
    {
        task.safescracked++;
        
        if ( task.safescracked < level.br_safecrack_quest.numsafes )
        {
            if ( task.safescracked == 2 )
            {
                level thread br_public::brleaderdialogteamexcludeplayer( "mission_safecrack_safe2", player.team, player, 1, undefined, 2 );
                level thread br_public::brleaderdialogplayer( "mission_safecrack_safe2_first_person", player, 1, undefined, 2 );
            }
            else if ( task.safescracked == 1 )
            {
                level thread br_public::brleaderdialogteamexcludeplayer( "mission_safecrack_safe1", player.team, player, 1, undefined, 2 );
                level thread br_public::brleaderdialogplayer( "mission_safecrack_safe1_first_person", player, 1, undefined, 2 );
            }
            
            task br_contract_manager::function_ba80ad6a1d946b85( 7, br_contract_manager::getquestindex( "safecracker" ), player );
            
            if ( level.br_safecrack_quest.var_89bae1f3eecc784a )
            {
                time = task br_contract_manager::function_7f2bcd04a826b94e( level.br_safecrack_quest.timebonus );
                task br_contract_manager::function_3a67c27d33cb206c( time );
            }
            
            if ( !level.br_safecrack_quest.var_40300831b7786959 )
            {
                if ( !task.iselite )
                {
                    task br_contract_manager::function_5c7e547ccc13711b( "br_safecracker_quest_next_location" );
                }
                
                var_3843c9b7192b583f = task.safestructs[ task.safescracked ];
                var_3843c9b7192b583f.objectiveiconid = self.safestruct.objectiveiconid;
                self.safestruct.objectiveiconid = undefined;
                var_3843c9b7192b583f br_contract_manager::movequestobjicon( var_3843c9b7192b583f.safelocation.origin );
                var_3843c9b7192b583f function_c30a8e9e9b5da6f6( teamname );
            }
            else
            {
                self.safestruct function_4c3aa5b6f92d6f8( teamname, 0 );
            }
        }
        else
        {
            task br_contract_manager::function_ba80ad6a1d946b85( 8, br_contract_manager::getquestindex( "safecracker" ), player );
            rewards = undefined;
            
            if ( getdvarint( @"hash_2bd07e31cfab5dbf", 1 ) )
            {
                rewards = task br_contract_manager::function_7d7e225a8f9c9222( "safecracker", self.lootspawnpoint );
            }
            else
            {
                rewards = task br_contract_manager::function_7d7e225a8f9c9222( "safecracker", self );
            }
            
            if ( !br_public::istutorial() )
            {
                if ( isdefined( rewards[ "plunder" ] ) && !task.iselite )
                {
                    task thread br_contract_manager::function_1f816e3c3465df7e( "br_safecracker_quest_complete", br_contract_manager::function_e01c7810f3c75f0b( "safecracker" ), rewards[ "plunder" ], 1 );
                }
                
                level thread br_public::brleaderdialogteam( "mission_safecrack_success", teamname, 1, 3.5 );
            }
            
            task thread function_dd72e973244442d1( 1, rewards, "Win" );
        }
        
        foreach ( player in players )
        {
            player br_contract_manager::uiobjectivesetparameter( task.safescracked );
        }
        
        task br_contract_manager::function_9fe564137142e8ee( task.safescracked );
        playersquad = teams::getfriendlyplayers( player.team, 0 );
        
        foreach ( teammate in playersquad )
        {
            teammate notify( #"hash_fe8368d98cacf961" );
        }
    }
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0x6721ac28, Offset: 0x35ee
// Size: 0x124
function function_325b88d1e08006b4()
{
    foreach ( safestruct in self.safestructs )
    {
        if ( isdefined( safestruct.safe ) )
        {
            var_b5ac39bac279ba2f = safestruct.safe getscriptablepartstate( "safe" );
            
            if ( var_b5ac39bac279ba2f == "usable_not_open" )
            {
                safestruct.safe function_68cfdcf46f7b022d();
                continue;
            }
            
            if ( isdefined( var_b5ac39bac279ba2f ) && ( var_b5ac39bac279ba2f == "unusable_intro_drilling" || var_b5ac39bac279ba2f == "unusable_drilling" ) )
            {
                safestruct.safe setscriptablepartstate( "safe", "usable_not_open" );
                waitframe();
                safestruct.safe setscriptablepartstate( "safe", "unusable" );
                safestruct.safe function_97fcc0b844853037();
            }
        }
    }
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0x625349f9, Offset: 0x371a
// Size: 0x29
function function_97fcc0b844853037()
{
    level endon( #"game_ended" );
    wait level.br_safecrack_quest.safedeletedelay;
    function_68cfdcf46f7b022d();
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0xea80f3e8, Offset: 0x374b
// Size: 0x8b
function function_68cfdcf46f7b022d()
{
    if ( isdefined( self.safestruct ) && self.safestruct.safelocation.inuse )
    {
        self.safestruct.safelocation.inuse = 0;
    }
    
    if ( isdefined( self.entity ) )
    {
        self.entity delete();
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    self freescriptable();
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0x1bfd6cc5, Offset: 0x37de
// Size: 0x5d, Type: bool
function function_361f7a01917ce5d4( safelocations )
{
    if ( !isdefined( safelocations ) )
    {
        return false;
    }
    
    for ( i = 0; i < level.br_safecrack_quest.numsafes ; i++ )
    {
        safelocation = safelocations[ i ];
        
        if ( !isdefined( safelocation ) )
        {
            safelocations = undefined;
            return false;
        }
    }
    
    return true;
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0xfee5d367, Offset: 0x3844
// Size: 0xb3, Type: bool
function function_15f6850bdb1cb926()
{
    player = self.var_fe0156f1cf4e5f41;
    
    foreach ( safestruct in self.safestructs )
    {
        if ( !br_circle_util::function_554002773c2c21f7( safestruct.safelocation.origin, player.origin ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_safecrack_quest
// Params 0
// Checksum 0xeeb1224d, Offset: 0x3900
// Size: 0x1d0, Type: bool
function function_3bb84e539e07451a()
{
    if ( !isdefined( self.safestructs ) )
    {
        return false;
    }
    
    foreach ( safestruct in self.safestructs )
    {
        if ( ai_fortress::function_fd527fe79c5d43e8( safestruct.safelocation.origin, 0 ) )
        {
            foreach ( var_5d9bf769d7ce1c72 in self.safestructs )
            {
                var_5d9bf769d7ce1c72.safelocation.inuse = 0;
            }
            
            self.safestructs = undefined;
            resetsuccessful = quest_oninit();
            
            if ( !resetsuccessful )
            {
                /#
                    if ( !isdefined( level.contractmanager.var_eafbea6258b86e23 ) )
                    {
                        level.contractmanager.var_eafbea6258b86e23 = 0;
                    }
                    
                    level.contractmanager.var_eafbea6258b86e23 += 1;
                    println( "<dev string:x50>" + level.contractmanager.var_eafbea6258b86e23 );
                #/
                
                self.tablet thread br_contract_manager::tablethide();
                return false;
            }
        }
    }
    
    return true;
}

// Namespace br_safecrack_quest
// Params 2
// Checksum 0x4acf40c2, Offset: 0x3ad9
// Size: 0xb3
function function_6a3d715186eba5cf( teamname, iselite )
{
    if ( iselite )
    {
        br_contract_manager::createquestobjicon( "ui_map_icon_elite_safe", "current", self.safelocation.origin + ( 0, 0, 55 ) );
        objective_setbackground( self.objectiveiconid, 1 );
        objective_settint( self.objectiveiconid, 246, 192, 72 );
    }
    else
    {
        br_contract_manager::createquestobjicon( "ui_mp_br_mapmenu_icon_safebreaker_objective", "current", self.safelocation.origin + ( 0, 0, 55 ) );
    }
    
    objective_removeallfrommask( self.objectiveiconid );
}

// Namespace br_safecrack_quest
// Params 2
// Checksum 0x8edc2d54, Offset: 0x3b94
// Size: 0x111
function function_418c503e85a71447( teamname, iselite )
{
    if ( iselite )
    {
        br_contract_manager::createquestobjicon( "ui_map_icon_elite_safe", "current", self.safelocation.origin + ( 0, 0, 55 ) );
        objective_setdescription( self.objectiveiconid, &"mp_br_ingame/loot_card_elite_safe_title" );
        objective_setbackground( self.objectiveiconid, 1 );
        objective_settint( self.objectiveiconid, 246, 192, 72 );
    }
    else
    {
        br_contract_manager::createquestobjicon( "ui_mp_br_mapmenu_icon_safebreaker_objective", "current", self.safelocation.origin + ( 0, 0, 55 ) );
    }
    
    objective_removeallfrommask( self.objectiveiconid );
    self.safe.task thread br_contract_manager::function_b6def068f44f04c9( self.objectiveiconid, teamname, iselite );
    objective_setshowdistance( self.objectiveiconid, 0 );
    thread function_18caa28fb42945bf( self.team, iselite );
}

// Namespace br_safecrack_quest
// Params 2
// Checksum 0x105274df, Offset: 0x3cad
// Size: 0x8f
function function_18caa28fb42945bf( teamname, iselite )
{
    level endon( #"game_ended" );
    
    if ( level.br_safecrack_quest.var_a816396920a72e6b > 0 )
    {
        wait level.br_safecrack_quest.var_a816396920a72e6b;
    }
    
    if ( iselite )
    {
        questchain = quest_chain::function_2d09fe0b8396ea40( teamname );
        
        if ( isdefined( questchain ) )
        {
            objective_setshowdistance( self.objectiveiconid, 1 );
        }
        
        return;
    }
    
    objective_setshowdistance( self.objectiveiconid, 1 );
}

// Namespace br_safecrack_quest
// Params 2
// Checksum 0x55bfaa3, Offset: 0x3d44
// Size: 0x90
function function_d2632165fedd3b1( teamname, questcomplete )
{
    foreach ( safestruct in self.safestructs )
    {
        safestruct function_4c3aa5b6f92d6f8( teamname, questcomplete );
    }
}

// Namespace br_safecrack_quest
// Params 2
// Checksum 0xcc00c56b, Offset: 0x3ddc
// Size: 0x168
function function_4c3aa5b6f92d6f8( teamname, hidewidget )
{
    if ( isdefined( self.objectiveiconid ) )
    {
        foreach ( player in teams::getteamdata( teamname, "players" ) )
        {
            function_8eab514f2a9a28b1( player, hidewidget );
        }
        
        br_contract_manager::deletequestobjicon();
        self.objectiveiconid = undefined;
    }
    
    if ( isdefined( self.progressstruct.objectiveiconid ) )
    {
        foreach ( player in teams::getteamdata( teamname, "players" ) )
        {
            self.progressstruct function_8eab514f2a9a28b1( player, hidewidget );
        }
        
        self.progressstruct br_contract_manager::deletequestobjicon();
        self.progressstruct.objectiveiconid = undefined;
    }
}

// Namespace br_safecrack_quest
// Params 2
// Checksum 0x6e7d97dc, Offset: 0x3f4c
// Size: 0x2c
function function_8eab514f2a9a28b1( player, hidewidget )
{
    br_contract_manager::hidequestobjiconfromplayer( player );
    
    if ( hidewidget )
    {
        player br_contract_manager::uiobjectivehide();
    }
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0xf5ab1cf3, Offset: 0x3f80
// Size: 0x95
function function_a16f86d4dce53a17( player )
{
    foreach ( safestruct in self.safestructs )
    {
        if ( isdefined( safestruct.objectiveiconid ) )
        {
            safestruct br_contract_manager::hidequestobjiconfromplayer( player );
        }
    }
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0xe75fd33b, Offset: 0x401d
// Size: 0x95
function function_2ce1dfb50619006( player )
{
    foreach ( safestruct in self.safestructs )
    {
        if ( isdefined( safestruct.objectiveiconid ) )
        {
            safestruct br_contract_manager::showquestobjicontoplayer( player );
        }
    }
}

// Namespace br_safecrack_quest
// Params 1
// Checksum 0xe5a452a7, Offset: 0x40ba
// Size: 0x17e
function safedrill_update( player )
{
    level endon( #"game_ended" );
    self endon( #"safe_unlocked" );
    self.task endon( #"task_ended" );
    self.progress = 0;
    shownplayers = [];
    
    while ( true )
    {
        if ( isdefined( self.trigger ) && !self.trigger.trigger_off )
        {
            if ( self.nearbyplayers.size > 0 )
            {
                self.drilling = 1;
                self.progress = min( self.capturetime, self.progress + level.framedurationseconds );
            }
            else
            {
                self.drilling = 0;
                self.progress = max( 0, self.progress - level.framedurationseconds * 0.5 );
            }
            
            progress = self.progress / self.capturetime;
            shownplayers = self.safestruct.progressstruct function_481db6338db1d4cf( self.nearbyplayers, shownplayers, progress );
            objidpoolmanager::objective_set_progress( self.safestruct.progressstruct.objectiveiconid, progress );
            
            if ( self.progress >= self.capturetime )
            {
                thread safe_opensafe( player );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace br_safecrack_quest
// Params 3
// Checksum 0xad74fc20, Offset: 0x4240
// Size: 0x142
function function_481db6338db1d4cf( nearbyplayers, shownplayers, progress )
{
    allplayers = arraycombine( nearbyplayers, shownplayers );
    var_153d7595b0bea5fd = shownplayers;
    
    foreach ( player in allplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !arraycontains( shownplayers, player ) && arraycontains( nearbyplayers, player ) )
        {
            objidpoolmanager::objective_playermask_addshowplayer( self.objectiveiconid, player );
            objidpoolmanager::objective_pin_player( self.objectiveiconid, player );
            objidpoolmanager::function_b3b969f2930890eb( 2, player );
            objidpoolmanager::function_9d3f184285ca25e4( &"mp_dmz_missions/opening_safe", player );
            var_153d7595b0bea5fd[ var_153d7595b0bea5fd.size ] = player;
            continue;
        }
        
        if ( arraycontains( shownplayers, player ) && !arraycontains( nearbyplayers, player ) )
        {
            objidpoolmanager::objective_playermask_hidefrom( self.objectiveiconid, player );
            var_153d7595b0bea5fd = arrayremove( var_153d7595b0bea5fd, player );
        }
    }
    
    return var_153d7595b0bea5fd;
}

// Namespace br_safecrack_quest
// Params 2
// Checksum 0xb64c244b, Offset: 0x438b
// Size: 0xce
function safe_watchtrigger( trigger, radius )
{
    level endon( #"game_ended" );
    self endon( #"safe_unlocked" );
    self.task endon( #"task_ended" );
    self.nearbyplayers = [];
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) || arraycontains( self.nearbyplayers, player ) )
        {
            continue;
        }
        
        if ( !arraycontains( self.teams, player.team ) )
        {
            continue;
        }
        
        self.nearbyplayers[ self.nearbyplayers.size ] = player;
        thread function_79d1503b8379b9bc( trigger, player, radius );
    }
}

// Namespace br_safecrack_quest
// Params 3
// Checksum 0xa4373ff7, Offset: 0x4461
// Size: 0x90
function function_79d1503b8379b9bc( trigger, player, radius )
{
    while ( isalive( player ) && isdefined( self.trigger ) && distance( trigger.origin, player.origin ) < radius * 1.2 )
    {
        wait 0.2;
    }
    
    if ( isdefined( self.nearbyplayers ) && isdefined( player ) )
    {
        self.nearbyplayers = arrayremove( self.nearbyplayers, player );
    }
}

/#

    // Namespace br_safecrack_quest
    // Params 0
    // Checksum 0x78f59630, Offset: 0x44f9
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x84>" );
        devgui::add_devgui_func( "<dev string:x9c>", "<dev string:xb5>", &function_8a3afa004006daff );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_safecrack_quest
    // Params 0
    // Checksum 0xcbb8cfb3, Offset: 0x452f
    // Size: 0x10e, Type: dev
    function function_8a3afa004006daff()
    {
        if ( !level.br_safecrack_quest.var_36b99b5cac2bce99 )
        {
            level.br_safecrack_quest.var_36b99b5cac2bce99 = 1;
            level thread function_e3d929155a0e43e8();
            return;
        }
        
        level.br_safecrack_quest.var_36b99b5cac2bce99 = 0;
        level notify( #"hash_31d6820182852c40" );
        
        foreach ( safe in level.br_safecrack_quest.var_c3cd102377cdabe0 )
        {
            if ( isdefined( safe.safe ) )
            {
                safe.safe freescriptable();
                safe.debug_spawned = 0;
            }
        }
        
        iprintlnbold( "<dev string:xce>" );
    }

    // Namespace br_safecrack_quest
    // Params 0
    // Checksum 0xbfb64, Offset: 0x4645
    // Size: 0x15a, Type: dev
    function function_e3d929155a0e43e8()
    {
        level endon( #"game_ended" );
        level endon( #"hash_31d6820182852c40" );
        iprintlnbold( "<dev string:xf2>" );
        
        while ( true )
        {
            foreach ( safe in level.br_safecrack_quest.var_c3cd102377cdabe0 )
            {
                if ( distance2d( level.player.origin, safe.origin ) < 1500 )
                {
                    if ( !isdefined( safe.safe ) && !safe.debug_spawned )
                    {
                        safe.safe = safe_spawn( safe.origin, safe.angles );
                        safe.debug_spawned = 1;
                    }
                    
                    continue;
                }
                
                if ( isdefined( safe.safe ) )
                {
                    safe.safe freescriptable();
                    safe.debug_spawned = 0;
                }
            }
            
            wait 1;
        }
    }

#/
