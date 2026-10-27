// scripts\mp\br\gametypes\br_assassination_quest.gsc  (hash_255deb6b2aeb2dfd.gscc) (size: 31064 Bytes / 0x7958 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x323bd59e (842782110)
// size ...... 31064 (0x7958)
// includes .. 17  (offset: 0x7210)
// strings ... 98  (offset: 0x7298)
// dev strs .. 1   (offset: 0x7948)
// exports ... 63  (offset: 0x5458)
// cseg ...... 0xab1 + 0x49a7 (0x5458)
// imports ... 145 (offset: 0x5e30)
// animtree1 . 0   (offset: 0x7958)
// animtree2 . 0   (offset: 0x7958)
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\flags;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace br_assassination_quest;

// Namespace br_assassination_quest
// Params 2
// Checksum 0x2e4621ea, Offset: 0xacf
// Size: 0x700
function getcontractdata( data, questmodifier )
{
    if ( !isdefined( level.asnprops ) )
    {
        level.asnprops = spawnstruct();
        var_47b2c991ea1286f0 = getdvarint( @"hash_364dca8e32d958fa", 0 );
        level.asnprops.time = var_47b2c991ea1286f0 != 0 ? var_47b2c991ea1286f0 : br_contract_manager::function_4bc46e9c9bb0d265( "assassination" );
        level.asnprops.minsearchradius = getdvarint( @"scr_br_asn_min_search_radius", 5000 );
        level.asnprops.searchlimit = getdvarint( @"hash_c7054640761be2ef", 30000 );
        level.asnprops.searchincrement = getdvarint( @"hash_34d149dfddecfa91", 5000 );
        level.asnprops.var_cc11c46c0f96af9f = getdvarint( @"scr_br_asn_min_plunder", 100000 );
        level.asnprops.circlerangemin = getdvarint( @"scr_br_asn_circle_range_min", 100 );
        level.asnprops.circlerangemax = getdvarint( @"scr_br_asn_circle_range_max", 1000 );
        level.asnprops.var_2d361e591980c9ed = getdvarint( @"scr_br_asn_circle_radius_small", 1500 );
        level.asnprops.var_5955ab4680412425 = getdvarint( @"hash_dd2f37f5ec580f08", 2000 );
        level.asnprops.var_120d0e4c404bb3e9 = getdvarint( @"scr_br_asn_circle_radius_large", 3500 );
        level.asnprops.var_c661aaa2338138ba = getdvarint( @"hash_5b3f6111a22668cd", 2500 );
        level.asnprops.var_9045e77431206ed2 = getdvarint( @"hash_befde6c410585907", 5000 );
        level.asnprops.var_bb48e4be7d9b68b3 = getdvarint( @"scr_br_asn_ideal_search_radius", 16000 );
        level.asnprops.var_343aa7caf2fec1a3 = getdvarint( @"hash_581d50a4690192ae", 1 );
        level.asnprops.var_f0967dcfe0f973bc = getdvarint( @"hash_5746ccd8cb2f6b4f", 1 );
        level.asnprops.pingreward = getdvarint( @"hash_27b13c5274e3fd4f", 1 );
        level.asnprops.pingorigin = getdvarint( @"hash_7a8fdce2ac2e873a", 1 );
        level.asnprops.pingamount = getdvarint( @"hash_e3799281611ec0e4", 1 );
        level.asnprops.pingsize = getdvarint( @"hash_b51d8dfbac466b49", 5000 );
        level.asnprops.var_cdc033d63ca9867d = getdvarint( @"hash_97412cd449d400e9", 2 );
        level.asnprops.usecarrier = getdvarint( @"hash_bb1780e30ec28dd8", 1 );
        level.var_179b6c3280c0c8f8 = [];
        assert( isdefined( game[ "<dev string:x24>" ] ) );
        game[ "dialog" ][ "mission_ass_accept" ] = "mssc_wzan_mssn";
        game[ "dialog" ][ "mission_ass_hunted" ] = "mssh_wzan_mssn";
        game[ "dialog" ][ "mission_ass_success" ] = "msss_wzan_mssn";
        game[ "dialog" ][ "mission_ass_hunted_success" ] = "mshs_wzan_mssn";
        game[ "dialog" ][ "mission_ass_hunted_timed_out" ] = "msht_wzan_mssn";
        game[ "dialog" ][ "mission_ass_hunted_fail" ] = "gnrc_wzan_msnf";
        game[ "dialog" ][ "mission_ass_fail" ] = "bnty_wzan_msnf";
        data.funcs[ "onTeamAssigned" ] = &asn_onteamassigned;
        data.basetime = level.asnprops.time;
        utility::registersharedfunc( #"challenges", #"hash_fe4251017975f1a4", &function_a63112a0f410ccf7 );
    }
    
    if ( questmodifier == "master" )
    {
        if ( !isdefined( level.var_ce959728160a4440 ) )
        {
            level.var_ce959728160a4440 = spawnstruct();
            level.var_ce959728160a4440.var_d2bc5b75f09c866a = getdvarint( @"hash_bd8bedf943d59eb", 0 );
            level.var_ce959728160a4440.usedistance = getdvarint( @"hash_fb68cd88f410c9a9", 0 );
            var_47b2c991ea1286f0 = getdvarint( @"hash_5795d68ef70d9001", 0 );
            level.var_ce959728160a4440.time = var_47b2c991ea1286f0 != 0 ? var_47b2c991ea1286f0 : br_contract_manager::function_4bc46e9c9bb0d265( questmodifier + "_" + "assassination" );
        }
        
        assert( isdefined( game[ "<dev string:x24>" ] ) );
        game[ "dialog" ][ "mission_master_ass_accept" ] = "bggm_wzan_mssm";
        game[ "dialog" ][ "mission_master_ass_accept_first_person" ] = "bggm_wzan_msns";
        game[ "dialog" ][ "mission_master_ass_hunted" ] = "mssh_wzan_mssn";
        game[ "dialog" ][ "mission_master_ass_success" ] = "msss_wzan_mssn";
        game[ "dialog" ][ "mission_master_ass_hunted_success" ] = "mshs_wzan_mssn";
        game[ "dialog" ][ "mission_master_ass_hunted_timed_out" ] = "msht_wzan_mssn";
        game[ "dialog" ][ "mission_master_ass_hunted_fail" ] = "gnrc_wzan_msnf";
        game[ "dialog" ][ "mission_master_ass_fail" ] = "bnty_wzan_msnf";
        data.funcs[ "onTeamAssigned" ] = &function_d85006b3f870b5bf;
        data.basetime = level.var_ce959728160a4440.time;
    }
    
    data.funcs[ "onInit" ] = &asn_oninit;
    data.funcs[ "onEnterGulag" ] = &quest_onentergulag;
    data.funcs[ "onPlayerRespawn" ] = &quest_onrespawn;
    data.funcs[ "onPlayerKilled" ] = &quest_onplayerkilled;
    data.funcs[ "onMarkPlayerAsEliminated" ] = &function_22116566150b5d1;
    data.funcs[ "onPlayerDisconnect" ] = &quest_onplayerdisconnect;
    data.funcs[ "onCancel" ] = &quest_oncancel;
    data.funcs[ "onPlayerTearDown" ] = &quest_onplayerteardown;
    data.funcs[ "onPlayerAssimilated" ] = &quest_onplayerassimilated;
    data.funcs[ "onTargetAssimilated" ] = &quest_ontargetassimilated;
    data.funcs[ "onTargetTeamTearDown" ] = &quest_ontargetteamteardown;
    data.funcs[ "onTargetTeamAssimilated" ] = &quest_ontargetteamassimilated;
    data.funcs[ "onFinishContract" ] = &function_1be7c59a593161bc;
    data.funcs[ "bestRespawnMissionOrigin" ] = &function_30e1c8272073cbc1;
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x21055932, Offset: 0x11d7
// Size: 0x26, Type: bool
function function_72f666fd14cbc49c()
{
    if ( level.asnprops.var_343aa7caf2fec1a3 == 0 )
    {
        return false;
    }
    
    return istrue( self.var_8946ce0ae9eb0955 );
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x9ce8d14f, Offset: 0x1206
// Size: 0x4, Type: bool
function asn_oninit()
{
    return true;
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x5f949718, Offset: 0x1213
// Size: 0x396
function function_d85006b3f870b5bf()
{
    self.questmodifier = "master";
    self.category = self.questmodifier + "_" + "assassination";
    var_2caf42ecba63b0b1 = !level.br_circle_disabled && level.br_multi_circle_enabled && level.br_multi_circle.issplit;
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_3bd1158920829264" ) )
    {
        self.targetteam = utility::callsharedfunc( #"gametype", #"hash_3bd1158920829264", self.var_fe0156f1cf4e5f41, var_2caf42ecba63b0b1 );
    }
    else
    {
        self.targetteam = function_194d9aeedd5fc49( self.var_fe0156f1cf4e5f41, var_2caf42ecba63b0b1 );
    }
    
    if ( isdefined( self.targetteam ) )
    {
        self.hunterteam = self.team;
        level.var_179b6c3280c0c8f8 = arraycombine( level.var_179b6c3280c0c8f8, teams::getteamdata( self.targetteam, "players" ) );
        function_72e09138537e825( self.targetteam, self.var_fe0156f1cf4e5f41 );
        
        if ( !isdefined( self.targetplayer ) )
        {
            return;
        }
        
        game_utility::questcircle_create( "master_Assassination_Br" );
        determinetrackingcircleposition( self.targetplayer );
        determinetrackingcirclesize();
        thread function_bb4a3727033ef55c();
        thread function_9935c597e4c662ca();
        thread asn_watchforgameended();
        time = level.var_ce959728160a4440.time;
        time = br_contract_manager::function_2f14979bf83bc3db( time );
        br_contract_manager::function_3fbbc67df36be7bb( time, 0 );
        thread asn_watchtimer( time );
        updateassassinationhud();
        params = spawnstruct();
        params.excludedplayers = [];
        params.excludedplayers[ 0 ] = self.targetplayer;
        
        if ( isdefined( self.var_fe0156f1cf4e5f41 ) )
        {
            params.excludedplayers[ 1 ] = self.var_fe0156f1cf4e5f41;
        }
        
        params.stringvar = self.targetplayer.name;
        br_contract_manager::function_5c7e547ccc13711b( "br_master_assassination_quest_start_target_team", params, undefined, self.targetteam, self.targetsquad );
        br_contract_manager::displayplayersplash( self.targetplayer, "br_master_assassination_quest_start_target_player" );
        
        if ( !br_public::function_379fb7b09f4ef13e() )
        {
            level thread br_public::brleaderdialogteam( "mission_master_ass_hunted", self.targetteam, 1, 2 );
        }
        
        [ var_e7f44e88e610ddcd, var_87a049611c671855 ] = function_efdb363c682f9a11( "br_master_assassination_quest_start_hunter_team", "br_master_assassination_quest_start_tablet_finder" );
        br_contract_manager::function_5c7e547ccc13711b( var_e7f44e88e610ddcd, params );
        
        if ( !br_public::function_379fb7b09f4ef13e() )
        {
            level thread br_public::brleaderdialogplayer( "mission_master_ass_accept_first_person", self.var_fe0156f1cf4e5f41, 1, undefined, 2, undefined, "dx_br_jpbm_" );
            level thread br_public::brleaderdialogteamexcludeplayer( "mission_master_ass_accept", self.hunterteam, self.var_fe0156f1cf4e5f41, 1, undefined, 2, undefined, "dx_br_jpbm_" );
        }
        
        if ( isdefined( self.var_fe0156f1cf4e5f41 ) )
        {
            br_contract_manager::displayplayersplash( self.var_fe0156f1cf4e5f41, var_87a049611c671855, params );
            br_contract_manager::function_ba80ad6a1d946b85( 6, br_contract_manager::getquestindex( self.questmodifier + "_" + "assassination" ) );
        }
        
        return;
    }
    
    self.var_fe0156f1cf4e5f41 lower_message::setlowermessageomnvar( "br_assassination_notargets", undefined, 5 );
    script::demoforcesre( "Removed br_lootcache code here. Create script cache key(s) to spawn items if needed." );
    br_contract_manager::endcontract( undefined, undefined, undefined, undefined, "NoTarget" );
}

// Namespace br_assassination_quest
// Params 2
// Checksum 0x51dbdb35, Offset: 0x15b1
// Size: 0x45
function function_efdb363c682f9a11( var_e7f44e88e610ddcd, var_87a049611c671855 )
{
    var_b5b4ab25593458dc = br_contract_manager::function_7c9586992cf68ed1( var_e7f44e88e610ddcd );
    
    if ( var_e7f44e88e610ddcd != var_b5b4ab25593458dc )
    {
        var_e7f44e88e610ddcd = var_b5b4ab25593458dc;
        var_87a049611c671855 = var_b5b4ab25593458dc;
    }
    
    return [ var_e7f44e88e610ddcd, var_87a049611c671855 ];
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x5cb31471, Offset: 0x15ff
// Size: 0x320
function asn_onteamassigned()
{
    self.questmodifier = "";
    self.category = "assassination";
    var_2caf42ecba63b0b1 = !level.br_circle_disabled && level.br_multi_circle_enabled && level.br_multi_circle.issplit;
    self.targetteam = determinetargetteam( self.var_fe0156f1cf4e5f41, var_2caf42ecba63b0b1, self.paramoverrides );
    
    if ( isdefined( self.targetteam ) )
    {
        self.hunterteam = self.team;
        level.var_179b6c3280c0c8f8 = arraycombine( level.var_179b6c3280c0c8f8, teams::getteamdata( self.targetteam, "players" ) );
        self.targetplayer = determinetargetplayer( self.targetteam, self.var_fe0156f1cf4e5f41, var_2caf42ecba63b0b1, self.paramoverrides );
        
        if ( !isdefined( self.targetplayer ) )
        {
            return;
        }
        
        game_utility::questcircle_create( "Assassination_Br" );
        determinetrackingcircleposition( self.targetplayer );
        determinetrackingcirclesize();
        thread function_bb4a3727033ef55c();
        thread function_9935c597e4c662ca();
        thread asn_watchforgameended();
        time = level.asnprops.time;
        time = br_contract_manager::function_2f14979bf83bc3db( time );
        
        if ( isdefined( self.paramoverrides ) && isdefined( self.paramoverrides.time ) )
        {
            time = self.paramoverrides.time;
        }
        
        br_contract_manager::function_3fbbc67df36be7bb( time, 0 );
        thread asn_watchtimer( time );
        updateassassinationhud();
        
        if ( !self.var_f114a315a5f2b4cc )
        {
            function_732cc7ee4dedd58c();
        }
        
        if ( !br_public::function_379fb7b09f4ef13e() )
        {
            if ( utility::issharedfuncdefined( #"assassination_quest", #"hash_c0d906c57803d43d" ) )
            {
                [[ utility::getsharedfunc( #"assassination_quest", #"hash_c0d906c57803d43d" ) ]]( self.targetteam, self.hunterteam );
            }
            else
            {
                level thread br_public::brleaderdialogteam( "mission_ass_hunted", self.targetteam, 1, 2 );
                level thread br_public::brleaderdialogteam( "mission_ass_accept", self.hunterteam, 1, 2 );
            }
        }
        
        return;
    }
    
    self.var_fe0156f1cf4e5f41 lower_message::setlowermessageomnvar( "br_assassination_notargets", undefined, 5 );
    
    if ( common_item::items_isenabled() )
    {
        var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_quest_assassin_pity" );
        
        if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
        {
            var_172c0b3fd116d7df = var_f67995529827f79.spawnlistname;
            spawncount = var_f67995529827f79.spawncount;
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.var_fe0156f1cf4e5f41.origin, self.var_fe0156f1cf4e5f41.angles );
            common_item::function_38cde6a6acb68ea6( var_172c0b3fd116d7df, spawncount, spawnoptions );
        }
    }
    
    br_contract_manager::endcontract( undefined, undefined, undefined, undefined, "NoTarget" );
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x138cde11, Offset: 0x1927
// Size: 0x143
function function_732cc7ee4dedd58c()
{
    params = spawnstruct();
    params.excludedplayers = [];
    params.excludedplayers[ 0 ] = self.targetplayer;
    
    if ( isdefined( self.var_fe0156f1cf4e5f41 ) )
    {
        params.excludedplayers[ 1 ] = self.var_fe0156f1cf4e5f41;
    }
    
    params.stringvar = self.targetplayer.name;
    function_6f11c7bf1f629583( self.targetteam, "br_assassination_quest_start_target_team", params );
    function_773f72d2a81a582f( self.targetplayer, "br_assassination_quest_start_target_player" );
    var_e7f44e88e610ddcd = "br_assassination_quest_start_hunter_team";
    var_87a049611c671855 = "br_assassination_quest_start_tablet_finder";
    [ var_e7f44e88e610ddcd, var_87a049611c671855 ] = function_efdb363c682f9a11( "br_assassination_quest_start_hunter_team", "br_assassination_quest_start_tablet_finder" );
    function_6f11c7bf1f629583( self.hunterteam, var_e7f44e88e610ddcd, params );
    
    if ( isdefined( self.var_fe0156f1cf4e5f41 ) )
    {
        function_773f72d2a81a582f( self.var_fe0156f1cf4e5f41, var_87a049611c671855, params );
        br_quest_util::displaysquadmessagetoteam( self.hunterteam, self.var_fe0156f1cf4e5f41, 6, br_quest_util::getquestindex( "assassination" ) );
    }
}

// Namespace br_assassination_quest
// Params 7
// Checksum 0x1a9a26a2, Offset: 0x1a72
// Size: 0x75
function function_adbb7217d13b96cd( splashref, contractindex, rewardcash, delay, splashlistoverride, team, squadindex )
{
    if ( isdefined( self.var_95bc436713519563 ) && !arraycontains( self.var_95bc436713519563, splashref ) )
    {
        return;
    }
    
    br_contract_manager::function_1f816e3c3465df7e( splashref, contractindex, rewardcash, delay, splashlistoverride, team, squadindex );
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0x8e6f2617, Offset: 0x1aef
// Size: 0x4b
function function_6f11c7bf1f629583( team, splash_key, params )
{
    if ( isdefined( self.var_95bc436713519563 ) && !arraycontains( self.var_95bc436713519563, splash_key ) )
    {
        return;
    }
    
    br_quest_util::displayteamsplash( team, splash_key, params );
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0xaf3d682f, Offset: 0x1b42
// Size: 0x4b
function function_773f72d2a81a582f( player, splash_key, params )
{
    if ( isdefined( self.var_95bc436713519563 ) && !arraycontains( self.var_95bc436713519563, splash_key ) )
    {
        return;
    }
    
    br_quest_util::displayplayersplash( player, splash_key, params );
}

// Namespace br_assassination_quest
// Params 5
// Checksum 0x47764e5a, Offset: 0x1b95
// Size: 0x80
function function_893c486b8596321c( splash_key, params, splashlistoverride, team = self.team, squadindex = self.squadindex )
{
    if ( isdefined( self.var_95bc436713519563 ) && !arraycontains( self.var_95bc436713519563, splash_key ) )
    {
        return;
    }
    
    br_contract_manager::function_5c7e547ccc13711b( splash_key, params, splashlistoverride, team, squadindex );
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x4b54b25a, Offset: 0x1c1d
// Size: 0x51
function quest_onentergulag( player )
{
    if ( player.team == self.hunterteam )
    {
        game_utility::questcircle_hidefromplayer( player );
        return;
    }
    
    if ( player.team == self.targetteam )
    {
        player hideassassinationtargethud();
    }
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x91b321b4, Offset: 0x1c76
// Size: 0x63
function quest_onrespawn( player )
{
    if ( player.team == self.hunterteam )
    {
        game_utility::questcircle_showtoplayer( player );
        return;
    }
    
    if ( player.team == self.targetteam )
    {
        player showassassinationtargethud( self.targetplayer, self.threat_level );
    }
}

// Namespace br_assassination_quest
// Params 2
// Checksum 0xc33104c6, Offset: 0x1ce1
// Size: 0x1e
function quest_onplayerkilled( attacker, victim )
{
    aq_playerremoved( victim );
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x652eaed4, Offset: 0x1d07
// Size: 0x15
function function_22116566150b5d1( victim )
{
    aq_playerremoved( victim );
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0xa50c5bf5, Offset: 0x1d24
// Size: 0x15
function quest_onplayerdisconnect( player )
{
    aq_playerremoved( player );
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0xc79b1e4e, Offset: 0x1d41
// Size: 0x150
function aq_playerremoved( player )
{
    if ( player.team == self.hunterteam )
    {
        filter = br_contract_manager::function_42827c79f1968770( player, level.contractmanager.defaultfilter );
        
        if ( !br_quest_util::isteamvalid( self.hunterteam, filter ) )
        {
            params = spawnstruct();
            params.intvar = 0;
            questmodifier = "";
            
            if ( function_a27521369409b73() )
            {
                questmodifier = "master_";
            }
            
            rewards = br_contract_manager::function_83f627106ef43736( questmodifier + "assassin_averted", self.targetplayer, self.targetteam, self.tablet, self.targetsquad );
            
            if ( isdefined( rewards[ "plunder" ] ) )
            {
                function_adbb7217d13b96cd( "br_" + questmodifier + "assassination_complete_targets_win", br_contract_manager::function_e01c7810f3c75f0b( questmodifier + "assassination" ), rewards[ "plunder" ], undefined, undefined, self.targetteam, self.targetsquad );
                level thread br_public::brleaderdialogteam( "mission_" + questmodifier + "ass_hunted_timed_out", self.targetteam, 1, 2 );
            }
            
            thread function_72168f47af498225( 0, undefined, "Killed" );
        }
    }
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0xd2e98eb9, Offset: 0x1e99
// Size: 0x107
function quest_oncancel( team )
{
    if ( self.team == team )
    {
        if ( getdvarint( @"hash_339e124f41f186ad", 1 ) == 1 )
        {
            questmodifier = "";
            
            if ( function_a27521369409b73() )
            {
                questmodifier = "master_";
            }
            
            rewards = br_contract_manager::function_83f627106ef43736( questmodifier + "assassin_averted", self.targetplayer, self.targetteam, self.tablet, self.targetsquad );
            
            if ( isdefined( rewards[ "plunder" ] ) )
            {
                function_adbb7217d13b96cd( "br_" + questmodifier + "assassination_complete_targets_win", br_contract_manager::function_e01c7810f3c75f0b( questmodifier + "assassination" ), rewards[ "plunder" ], undefined, undefined, self.targetteam, self.targetsquad );
                level thread br_public::brleaderdialogteam( "mission_" + questmodifier + "ass_hunted_timed_out", self.targetteam, 1, 2 );
            }
        }
        
        thread function_72168f47af498225( 0, undefined, "Cancel" );
    }
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0x5706de99, Offset: 0x1fa8
// Size: 0x134
function quest_onplayerteardown( player, oldteam, newteam )
{
    if ( oldteam == self.team )
    {
        player hideassassinationhud( self );
        
        if ( !br_quest_util::isteamvalid( self.hunterteam, level.contractmanager.defaultfilter ) )
        {
            questmodifier = "";
            
            if ( function_a27521369409b73() )
            {
                questmodifier = "master_";
            }
            
            rewards = br_contract_manager::function_83f627106ef43736( questmodifier + "assassin_averted", self.targetplayer, self.targetteam, self.tablet, self.targetsquad );
            
            if ( isdefined( rewards[ "plunder" ] ) )
            {
                function_adbb7217d13b96cd( "br_" + questmodifier + "assassination_complete_targets_win", br_contract_manager::function_e01c7810f3c75f0b( questmodifier + "assassination" ), rewards[ "plunder" ], undefined, undefined, self.targetteam, self.targetsquad );
                level thread br_public::brleaderdialogteam( "mission_" + questmodifier + "ass_hunted_timed_out", self.targetteam, 1, 2 );
            }
            
            thread function_72168f47af498225( 0, undefined, "Assimilation" );
        }
    }
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0xa3c94376, Offset: 0x20e4
// Size: 0x74
function quest_onplayerassimilated( player, oldteam, newteam )
{
    if ( !isdefined( self.targetplayer ) )
    {
        return;
    }
    
    if ( self.targetplayer == player )
    {
        return;
    }
    
    if ( newteam == self.team )
    {
        player showassassinationhud( self, self.questmodifier );
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
    }
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0x74918a40, Offset: 0x2160
// Size: 0x27
function quest_ontargetteamteardown( player, oldteam, newteam )
{
    player hideassassinationtargethud();
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0x568120cc, Offset: 0x218f
// Size: 0x3a
function quest_ontargetteamassimilated( player, oldteam, newteam )
{
    player function_8fc6926e1c84d855( self.targetplayer, self.threat_level, self );
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0x84fc408f, Offset: 0x21d1
// Size: 0xc0
function quest_ontargetassimilated( player, oldteam, newteam )
{
    player hideassassinationtargethud();
    rewards = undefined;
    
    if ( self.team != newteam )
    {
        questmodifier = "";
        
        if ( function_a27521369409b73() )
        {
            questmodifier = "master_";
        }
        
        rewards = br_contract_manager::function_83f627106ef43736( questmodifier + "assassin_target_vanished", self.var_fe0156f1cf4e5f41 );
        
        if ( isdefined( rewards[ "plunder" ] ) )
        {
            function_adbb7217d13b96cd( "br_" + questmodifier + "assassination_complete_target_vanished", br_contract_manager::function_e01c7810f3c75f0b( questmodifier + "assassination" ), rewards[ "plunder" ] );
        }
    }
    
    thread function_72168f47af498225( 1, rewards, "WinAssimilation" );
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0xe505f336, Offset: 0x2299
// Size: 0x111
function function_72168f47af498225( success, rewards, endstate )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    self notify( #"task_ended" );
    self endon( #"task_ended" );
    level.var_179b6c3280c0c8f8 = arrayremove( level.var_179b6c3280c0c8f8, teams::getteamdata( self.targetteam, "players" ) );
    
    if ( !flags::levelflag( "game_over" ) )
    {
        wait level.contractmanager.var_dc52ccd301b92f4f ?? 0.3;
    }
    
    if ( isdefined( self.var_efa81f3d9b78d1d9 ) )
    {
        self thread [[ self.var_efa81f3d9b78d1d9 ]]( success, endstate );
    }
    
    if ( !self.var_8694b8091d3d20ae )
    {
        removeallaqui();
    }
    
    if ( isdefined( self.targetplayer ) )
    {
        self.targetplayer.var_5cb861c1a2f605e5[ self.hunterteam ] = gettime();
    }
    
    br_contract_manager::endcontract( success, rewards, undefined, undefined, endstate );
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0xf48febbc, Offset: 0x23b2
// Size: 0x87
function function_9935c597e4c662ca()
{
    questmodifier = "";
    endstate = "Win";
    
    if ( function_a27521369409b73() )
    {
        questmodifier = "master_";
    }
    
    self endon( #"task_ended" );
    
    if ( !level.asnprops.var_f0967dcfe0f973bc )
    {
        level endon( #"game_ended" );
    }
    
    self.targetplayer waittill( #"death_or_disconnect" );
    br_contract_manager::function_7864d8f2e3f3454b( self, self.var_fe0156f1cf4e5f41 );
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0xa809f9f7, Offset: 0x2441
// Size: 0x2f4
function function_1be7c59a593161bc( contract, instance, team )
{
    contractref = "assassination";
    dialogsuccess = "mission_ass_success";
    splash = "br_assassination_complete_hunters_win";
    rewardgroup = "assassin_target_killed";
    targetsplash = undefined;
    targetdialog = undefined;
    endstate = "Win";
    
    if ( function_a27521369409b73() )
    {
        contractref = "master_" + "assassination";
        dialogsuccess = "mission_master_ass_success";
    }
    
    var_b6ce26b260404207 = contract.targetplayer.lastkilledby;
    successfullyhunted = isplayer( var_b6ce26b260404207 ) && isdefined( var_b6ce26b260404207.team ) && var_b6ce26b260404207.team == self.team;
    
    if ( !successfullyhunted && isdefined( contract.targetplayer.lastattacker ) && contract.hunterteam == contract.targetplayer.lastattacker.team )
    {
        successfullyhunted = 1;
    }
    
    if ( successfullyhunted )
    {
        if ( function_a27521369409b73() )
        {
            splash = "br_master_assassination_complete_hunters_win";
            targetsplash = "br_master_assassination_target_killed_target_team";
            targetdialog = "mission_master_ass_hunted_fail";
            rewardgroup = "master_assassin_target_killed";
        }
        else
        {
            targetsplash = "br_assassination_target_killed_target_team";
            targetdialog = "mission_ass_hunted_fail";
            
            if ( level.asnprops.pingreward )
            {
                contract thread function_23eba376a9862a9c( var_b6ce26b260404207, contract.targetplayer, level.asnprops );
            }
        }
    }
    else
    {
        endstate = "Vanished";
        
        if ( function_a27521369409b73() )
        {
            splash = "br_master_assassination_complete_target_vanished";
            rewardgroup = "master_assassin_target_vanished";
        }
        else
        {
            splash = "br_assassination_complete_target_vanished";
            rewardgroup = "assassin_target_vanished";
        }
    }
    
    hunterteam = contract.hunterteam;
    targetteam = contract.targetteam;
    
    if ( isdefined( targetsplash ) )
    {
        contract function_6f11c7bf1f629583( targetteam, targetsplash );
    }
    
    if ( isdefined( targetdialog ) )
    {
        level thread br_public::brleaderdialogteam( targetdialog, targetteam, 1, 2.5 );
    }
    
    rewards = br_contract_manager::function_83f627106ef43736( rewardgroup, contract.var_fe0156f1cf4e5f41, hunterteam, contract );
    
    if ( isdefined( rewards[ "plunder" ] ) )
    {
        contract function_adbb7217d13b96cd( splash, br_contract_manager::function_e01c7810f3c75f0b( contractref ), rewards[ "plunder" ], undefined, undefined, hunterteam );
    }
    
    if ( getdvarint( @"hash_827f1bf2224b0d61", 0 ) == 1 )
    {
        contract.var_fe0156f1cf4e5f41 br_contract_manager::function_5f48264a2892eeef( contract.hunterteam );
    }
    
    if ( !br_public::function_379fb7b09f4ef13e() && !level.asnprops.var_f21b95e41e7b314d )
    {
        level thread br_public::brleaderdialogteam( dialogsuccess, hunterteam, 1, 2 );
    }
    
    contract thread function_72168f47af498225( successfullyhunted, rewards, endstate );
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0xf6f206aa, Offset: 0x273d
// Size: 0x34
function function_30e1c8272073cbc1()
{
    contract = self;
    
    if ( isdefined( contract.targetplayer ) )
    {
        return contract.targetplayer.origin;
    }
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0xb842b539, Offset: 0x277a
// Size: 0x28
function asn_watchforgameended()
{
    self endon( #"task_ended" );
    level waittill( #"game_ended" );
    waitframe();
    self notify( #"task_ended" );
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0xc3f05829, Offset: 0x27aa
// Size: 0x16a
function asn_watchtimer( time )
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    wait time;
    params = spawnstruct();
    params.intvar = 0;
    questmodifier = "";
    
    if ( function_a27521369409b73() )
    {
        questmodifier = "master_";
    }
    
    function_893c486b8596321c( "br_" + questmodifier + "assassination_timer_expire_hunters_lose", params );
    rewards = br_contract_manager::function_83f627106ef43736( questmodifier + "assassin_averted", self.targetplayer, self.targetteam, self.tablet, self.targetsquad );
    
    if ( isdefined( rewards[ "plunder" ] ) )
    {
        function_adbb7217d13b96cd( "br_" + questmodifier + "assassination_timer_expire_targets_win", br_contract_manager::function_e01c7810f3c75f0b( questmodifier + "assassination" ), rewards[ "plunder" ], undefined, undefined, self.targetteam, self.targetsquad );
    }
    
    if ( !level.asnprops.var_10a29b751ad7ff7c )
    {
        level thread br_public::brleaderdialogteam( "mission_" + questmodifier + "ass_fail", self.hunterteam, 1, 2 );
        level thread br_public::brleaderdialogteam( "mission_" + questmodifier + "ass_hunted_timed_out", self.targetteam, 1, 2 );
    }
    
    thread function_72168f47af498225( 0, undefined, "Time" );
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x5b8bee61, Offset: 0x291c
// Size: 0x4f
function function_bb4a3727033ef55c()
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        determinetrackingcircleposition( self.targetplayer );
        determinetrackingcirclesize();
        updateassassinationthreatlevel( self.targetteam );
        wait 10;
    }
}

// Namespace br_assassination_quest
// Params 2
// Checksum 0x6554dd30, Offset: 0x2973
// Size: 0x67, Type: bool
function function_43dca0233c4164a7( hunter, victim )
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gametype" ][ #"hash_bb709e6a00b911f6" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        var_dc0f296faffc1a4b = self [[ var_32dbca3143d9c4a5 ]]( hunter, victim );
    }
    else
    {
        var_dc0f296faffc1a4b = 1;
    }
    
    if ( !var_dc0f296faffc1a4b )
    {
        return false;
    }
    
    return true;
}

// Namespace br_assassination_quest
// Params 4
// Checksum 0x1887f473, Offset: 0x29e3
// Size: 0x7f8
function determinetargetteam( player, var_2caf42ecba63b0b1, paramoverrides, searchparams )
{
    if ( isdefined( paramoverrides ) )
    {
        return paramoverrides.targetteam;
    }
    
    if ( !isdefined( searchparams ) )
    {
        searchparams = level.asnprops;
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_aeaafdee9f4bbff1" ) )
    {
        return utility::callsharedfunc( #"gametype", #"hash_aeaafdee9f4bbff1", player, var_2caf42ecba63b0b1 );
    }
    
    hunterteam = player.team;
    bestteam = undefined;
    var_ba9a7907c7fae1c0 = 0;
    potentialtargets = level.players;
    list1 = level.var_179b6c3280c0c8f8;
    list2 = teams::getteamdata( hunterteam, "players" );
    excludedteams = arraycombineunique( list1, list2 );
    search_bounds = 0;
    searchminradius = searchparams.minsearchradius;
    var_cbbb9e520c58a2a8 = searchparams.var_bb48e4be7d9b68b3;
    searchlimit = searchparams.searchlimit;
    var_8cf349a832ce4853 = searchparams.var_112ae0069201f666;
    
    while ( !isdefined( bestteam ) )
    {
        search_bounds += searchparams.searchincrement;
        
        if ( search_bounds < var_cbbb9e520c58a2a8 )
        {
            potentiallist = utility::get_array_of_closest( player.origin, potentialtargets, excludedteams, undefined, searchminradius + search_bounds, searchminradius );
        }
        else
        {
            potentiallist = utility::get_array_of_closest( player.origin, potentialtargets, excludedteams, undefined, searchminradius + search_bounds, undefined );
        }
        
        playerlist = [];
        
        foreach ( potentialtarget in potentiallist )
        {
            if ( !function_43dca0233c4164a7( player, potentialtarget ) )
            {
                continue;
            }
            
            if ( var_2caf42ecba63b0b1 && !br_circle_util::function_554002773c2c21f7( player.origin, potentialtarget.origin ) )
            {
                continue;
            }
            
            if ( !potentialtarget.hasbeentracked && !potentialtarget br_public::isplayerinorgoingtogulag() && player::isreallyalive( potentialtarget ) && !potentialtarget function_72f666fd14cbc49c() )
            {
                playerlist[ playerlist.size ] = potentialtarget;
            }
        }
        
        if ( playerlist.size == 0 )
        {
            if ( search_bounds >= searchlimit )
            {
                if ( var_8cf349a832ce4853 )
                {
                    return;
                }
                
                potentiallist = utility::get_array_of_closest( player.origin, potentialtargets, excludedteams, undefined, undefined, undefined );
                
                foreach ( potentialtarget in potentiallist )
                {
                    if ( !function_43dca0233c4164a7( player, potentialtarget ) )
                    {
                        continue;
                    }
                    
                    if ( var_2caf42ecba63b0b1 && !br_circle_util::function_554002773c2c21f7( player.origin, potentialtarget.origin ) )
                    {
                        continue;
                    }
                    
                    if ( !potentialtarget br_public::isplayerinorgoingtogulag() && player::isreallyalive( potentialtarget ) )
                    {
                        playerlist[ playerlist.size ] = potentialtarget;
                    }
                }
                
                if ( playerlist.size == 0 )
                {
                    return;
                }
            }
        }
        
        hunterteamsize = 0;
        var_402384e392946204 = ( 0, 0, 0 );
        
        foreach ( teammate in teams::getteamdata( hunterteam, "players" ) )
        {
            if ( !teammate br_public::isplayerinorgoingtogulag() && player::isreallyalive( teammate ) )
            {
                hunterteamsize++;
                var_402384e392946204 += teammate.origin;
            }
        }
        
        var_402384e392946204 = hunterteamsize == 0 ? var_402384e392946204 : var_402384e392946204 / hunterteamsize;
        
        foreach ( potentialtarget in playerlist )
        {
            var_dbfcc362a6b86751 = 0;
            
            foreach ( teammate in teams::getteamdata( potentialtarget.team, "players" ) )
            {
                if ( !teammate br_public::isplayerinorgoingtogulag() && player::isreallyalive( teammate ) )
                {
                    var_dbfcc362a6b86751++;
                }
            }
            
            if ( var_dbfcc362a6b86751 == 0 )
            {
                continue;
            }
            
            if ( !isdefined( bestteam ) )
            {
                bestteam = potentialtarget.team;
                var_ba9a7907c7fae1c0 = var_dbfcc362a6b86751;
                continue;
            }
            
            gametype = game_utility::getgametype();
            
            if ( gametype == "plunder" )
            {
                var_f7fd89704d030575 = br_plunder::getteamcarriedplunder( bestteam );
                var_23542beff0c4034c = br_plunder::getteamcarriedplunder( potentialtarget.team );
                
                if ( var_23542beff0c4034c > searchparams.var_cc11c46c0f96af9f )
                {
                    if ( var_23542beff0c4034c > var_f7fd89704d030575 )
                    {
                        bestteam = potentialtarget.team;
                        var_ba9a7907c7fae1c0 = var_dbfcc362a6b86751;
                        continue;
                    }
                }
            }
            
            bestdifference = abs( hunterteamsize - var_ba9a7907c7fae1c0 );
            currentdifference = abs( hunterteamsize - var_dbfcc362a6b86751 );
            
            if ( currentdifference < bestdifference )
            {
                bestteam = potentialtarget.team;
                var_ba9a7907c7fae1c0 = var_dbfcc362a6b86751;
                continue;
            }
            else if ( currentdifference > bestdifference )
            {
                continue;
            }
            
            if ( var_ba9a7907c7fae1c0 < var_dbfcc362a6b86751 )
            {
                bestteam = potentialtarget.team;
                var_ba9a7907c7fae1c0 = var_dbfcc362a6b86751;
                continue;
            }
            else if ( var_ba9a7907c7fae1c0 > var_dbfcc362a6b86751 )
            {
                continue;
            }
            
            currentteamcenter = ( 0, 0, 0 );
            
            foreach ( teammate in teams::getteamdata( potentialtarget.team, "players" ) )
            {
                if ( !teammate br_public::isplayerinorgoingtogulag() && player::isreallyalive( teammate ) )
                {
                    currentteamcenter += teammate.origin;
                }
            }
            
            currentteamcenter /= var_dbfcc362a6b86751;
            var_185575d2f2c4e700 = ( 0, 0, 0 );
            
            foreach ( teammate in teams::getteamdata( bestteam, "players" ) )
            {
                if ( !teammate br_public::isplayerinorgoingtogulag() && player::isreallyalive( teammate ) )
                {
                    currentteamcenter += teammate.origin;
                }
            }
            
            var_185575d2f2c4e700 /= var_dbfcc362a6b86751;
            
            if ( distance2d( var_402384e392946204, currentteamcenter ) < distance2d( var_402384e392946204, var_185575d2f2c4e700 ) )
            {
                bestteam = potentialtarget.team;
                var_ba9a7907c7fae1c0 = var_dbfcc362a6b86751;
            }
        }
    }
    
    return bestteam;
}

// Namespace br_assassination_quest
// Params 4
// Checksum 0x4b789d19, Offset: 0x31e4
// Size: 0x384
function determinetargetplayer( targetteam, hunter, var_2caf42ecba63b0b1, paramoverrides )
{
    if ( isdefined( paramoverrides ) )
    {
        return paramoverrides.targetplayer;
    }
    
    bestplunder = undefined;
    var_2d717dee9fceaf51 = undefined;
    targetplayer = undefined;
    var_402384e392946204 = ( 0, 0, 0 );
    hunterteamsize = 0;
    var_358f271df10023ff = 0;
    
    foreach ( teammate in teams::getteamdata( targetteam, "players" ) )
    {
        if ( !teammate br_public::isplayerinorgoingtogulag() && player::isreallyalive( teammate ) )
        {
            var_402384e392946204 += teammate.origin;
            hunterteamsize++;
            
            if ( !teammate function_72f666fd14cbc49c() )
            {
                var_358f271df10023ff++;
            }
        }
    }
    
    if ( hunterteamsize == 0 )
    {
        return;
    }
    
    var_402384e392946204 /= hunterteamsize;
    
    foreach ( player in teams::getteamdata( targetteam, "players" ) )
    {
        if ( !function_43dca0233c4164a7( hunter, player ) )
        {
            continue;
        }
        
        if ( var_2caf42ecba63b0b1 && !br_circle_util::function_554002773c2c21f7( player.origin, hunter.origin ) )
        {
            continue;
        }
        
        if ( player br_public::isplayerinorgoingtogulag() || !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( var_358f271df10023ff > 0 && player function_72f666fd14cbc49c() )
        {
            continue;
        }
        
        if ( br_public::function_379fb7b09f4ef13e() )
        {
            if ( player.script_noteworthy == "assassination_target" )
            {
                targetplayer = player;
                break;
            }
        }
        
        if ( !isdefined( targetplayer ) )
        {
            targetplayer = player;
        }
        
        gametype = game_utility::getgametype();
        
        if ( gametype == "plunder" )
        {
            playerplunder = player currency::get_currency_amount( "cash" );
            
            if ( isdefined( playerplunder ) )
            {
                var_59f39f5bc6cd02f1 = distance2dsquared( hunter.origin, player.origin );
                
                if ( !isdefined( var_2d717dee9fceaf51 ) || var_59f39f5bc6cd02f1 <= var_2d717dee9fceaf51 )
                {
                    if ( !isdefined( bestplunder ) || playerplunder >= bestplunder )
                    {
                        bestplunder = playerplunder;
                        var_2d717dee9fceaf51 = var_59f39f5bc6cd02f1;
                        targetplayer = player;
                    }
                }
            }
            
            continue;
        }
        
        if ( distance2d( var_402384e392946204, player.origin ) < distance2d( var_402384e392946204, targetplayer.origin ) )
        {
            targetplayer = player;
        }
    }
    
    assert( isdefined( targetplayer ) );
    
    foreach ( player in teams::getteamdata( targetteam, "players" ) )
    {
        player.hasbeentracked = 1;
    }
    
    return targetplayer;
}

// Namespace br_assassination_quest
// Params 2
// Checksum 0xe15d5334, Offset: 0x3571
// Size: 0x7cd
function function_194d9aeedd5fc49( player, var_2caf42ecba63b0b1 )
{
    hunterteam = player.team;
    bestteam = undefined;
    potentialtargets = level.players;
    list1 = level.var_179b6c3280c0c8f8;
    list2 = teams::getteamdata( hunterteam, "players" );
    excludedteams = arraycombineunique( list1, list2 );
    search_bounds = 0;
    searchminradius = level.asnprops.minsearchradius;
    var_cbbb9e520c58a2a8 = level.asnprops.var_bb48e4be7d9b68b3;
    searchlimit = level.asnprops.searchlimit;
    
    while ( !isdefined( bestteam ) )
    {
        playerlist = [];
        
        if ( level.var_ce959728160a4440.usedistance )
        {
            search_bounds += level.asnprops.searchincrement;
            
            if ( search_bounds < var_cbbb9e520c58a2a8 )
            {
                potentiallist = utility::get_array_of_closest( player.origin, potentialtargets, excludedteams, undefined, searchminradius + search_bounds, searchminradius );
            }
            else
            {
                potentiallist = utility::get_array_of_closest( player.origin, potentialtargets, excludedteams, undefined, searchminradius + search_bounds, undefined );
            }
            
            foreach ( potentialtarget in potentiallist )
            {
                if ( level.var_ce959728160a4440.var_d2bc5b75f09c866a && var_2caf42ecba63b0b1 && !br_circle_util::function_554002773c2c21f7( player.origin, potentialtarget.origin ) )
                {
                    continue;
                }
                
                if ( !potentialtarget.var_cd87014e0137fe98 && !potentialtarget br_public::isplayerinorgoingtogulag() && player::isreallyalive( potentialtarget ) && !potentialtarget function_72f666fd14cbc49c() )
                {
                    playerlist[ playerlist.size ] = potentialtarget;
                }
            }
            
            if ( playerlist.size == 0 )
            {
                if ( search_bounds > searchlimit )
                {
                    potentiallist = utility::get_array_of_closest( player.origin, potentialtargets, excludedteams, undefined, undefined, undefined );
                    
                    foreach ( potentialtarget in potentiallist )
                    {
                        if ( !function_43dca0233c4164a7( player, potentialtarget ) )
                        {
                            continue;
                        }
                        
                        if ( level.var_ce959728160a4440.var_d2bc5b75f09c866a && var_2caf42ecba63b0b1 && !br_circle_util::function_554002773c2c21f7( player.origin, potentialtarget.origin ) )
                        {
                            continue;
                        }
                        
                        if ( !potentialtarget br_public::isplayerinorgoingtogulag() && player::isreallyalive( potentialtarget ) )
                        {
                            playerlist[ playerlist.size ] = potentialtarget;
                        }
                    }
                    
                    if ( playerlist.size == 0 )
                    {
                        return;
                    }
                }
            }
        }
        else
        {
            potentiallist = utility::get_array_of_closest( player.origin, potentialtargets, excludedteams, undefined, undefined, undefined );
            
            foreach ( potentialtarget in potentiallist )
            {
                if ( level.var_ce959728160a4440.var_d2bc5b75f09c866a && var_2caf42ecba63b0b1 && !br_circle_util::function_554002773c2c21f7( player.origin, potentialtarget.origin ) )
                {
                    continue;
                }
                
                if ( !potentialtarget.var_cd87014e0137fe98 && !potentialtarget br_public::isplayerinorgoingtogulag() && player::isreallyalive( potentialtarget ) )
                {
                    playerlist[ playerlist.size ] = potentialtarget;
                }
            }
            
            if ( playerlist.size == 0 )
            {
                foreach ( potentialtarget in potentiallist )
                {
                    if ( !function_43dca0233c4164a7( player, potentialtarget ) )
                    {
                        continue;
                    }
                    
                    if ( level.var_ce959728160a4440.var_d2bc5b75f09c866a && var_2caf42ecba63b0b1 && !br_circle_util::function_554002773c2c21f7( player.origin, potentialtarget.origin ) )
                    {
                        continue;
                    }
                    
                    if ( !potentialtarget br_public::isplayerinorgoingtogulag() && player::isreallyalive( potentialtarget ) )
                    {
                        playerlist[ playerlist.size ] = potentialtarget;
                    }
                }
                
                if ( playerlist.size == 0 )
                {
                    return;
                }
            }
        }
        
        targetteams = [];
        
        foreach ( targetplayer in playerlist )
        {
            targetteams[ targetplayer.team ] = br_quest_util::getvalidplayersinteam( targetplayer.team, level.contractmanager.defaultfilter ).size;
        }
        
        bestteam = undefined;
        bestteamkills = -1;
        var_2cac96b092182b7c = -1;
        bestteamscore = -1;
        var_f7fd89704d030575 = -1;
        var_3bd3ee5127a97999 = undefined;
        
        foreach ( team, teamsize in targetteams )
        {
            if ( !isdefined( bestteam ) )
            {
                bestteam = team;
                bestteamkills = gettargetteamkills( team );
                var_2cac96b092182b7c = function_e82828f32f2a14cf( team );
                bestteamscore = gettargetteamscore( team );
                var_f7fd89704d030575 = function_4ac9543d7a2863b8( team );
            }
            
            currentteamkills = gettargetteamkills( team );
            currentteamdamage = function_e82828f32f2a14cf( team );
            currentteamscore = gettargetteamscore( team );
            var_23542beff0c4034c = function_4ac9543d7a2863b8( team );
            
            if ( currentteamkills < bestteamkills )
            {
                continue;
            }
            else if ( currentteamkills > bestteamkills )
            {
                bestteam = team;
                bestteamkills = currentteamkills;
                var_2cac96b092182b7c = currentteamdamage;
                bestteamscore = currentteamscore;
                var_f7fd89704d030575 = var_23542beff0c4034c;
                continue;
            }
            
            if ( currentteamdamage < var_2cac96b092182b7c )
            {
                continue;
            }
            else if ( currentteamdamage > var_2cac96b092182b7c )
            {
                bestteam = team;
                bestteamkills = currentteamkills;
                var_2cac96b092182b7c = currentteamdamage;
                bestteamscore = currentteamscore;
                var_f7fd89704d030575 = var_23542beff0c4034c;
                continue;
            }
            
            if ( currentteamscore < bestteamscore )
            {
                continue;
            }
            else if ( currentteamscore > bestteamscore )
            {
                bestteam = team;
                bestteamkills = currentteamkills;
                var_2cac96b092182b7c = currentteamdamage;
                bestteamscore = currentteamscore;
                var_f7fd89704d030575 = var_23542beff0c4034c;
                continue;
            }
            
            if ( var_23542beff0c4034c < var_f7fd89704d030575 )
            {
                continue;
            }
            
            if ( var_23542beff0c4034c > var_f7fd89704d030575 )
            {
                bestteam = team;
                bestteamkills = currentteamkills;
                var_2cac96b092182b7c = currentteamdamage;
                bestteamscore = currentteamscore;
                var_f7fd89704d030575 = var_23542beff0c4034c;
                continue;
            }
            
            if ( !isdefined( var_3bd3ee5127a97999 ) )
            {
                var_3bd3ee5127a97999 = randomintrange( 1, 3 );
            }
            
            if ( var_3bd3ee5127a97999 == 1 )
            {
                bestteam = team;
                bestteamkills = currentteamkills;
                var_2cac96b092182b7c = currentteamdamage;
                bestteamscore = currentteamscore;
                var_f7fd89704d030575 = var_23542beff0c4034c;
                var_3bd3ee5127a97999 = undefined;
                continue;
            }
            
            var_3bd3ee5127a97999 = undefined;
        }
        
        return bestteam;
    }
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0x2321a7b0, Offset: 0x3d46
// Size: 0x379
function function_72e09138537e825( targetteam, hunter, var_2caf42ecba63b0b1 )
{
    bestplunder = -1;
    bestscore = -1;
    bestdamage = -1;
    bestkills = -1;
    targetplayer = undefined;
    var_8560ccdcd576dea9 = undefined;
    var_358f271df10023ff = 0;
    
    foreach ( teammate in teams::getteamdata( targetteam, "players" ) )
    {
        if ( !teammate br_public::isplayerinorgoingtogulag() && player::isreallyalive( teammate ) )
        {
            if ( !teammate function_72f666fd14cbc49c() )
            {
                var_358f271df10023ff++;
            }
        }
    }
    
    foreach ( player in teams::getteamdata( targetteam, "players" ) )
    {
        if ( !function_43dca0233c4164a7( hunter, player ) )
        {
            continue;
        }
        
        if ( level.var_ce959728160a4440.var_d2bc5b75f09c866a && var_2caf42ecba63b0b1 && !br_circle_util::function_554002773c2c21f7( player.origin, hunter.origin ) )
        {
            continue;
        }
        
        if ( player br_public::isplayerinorgoingtogulag() || !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( var_358f271df10023ff > 0 && player function_72f666fd14cbc49c() )
        {
            continue;
        }
        
        if ( br_public::function_379fb7b09f4ef13e() )
        {
            if ( player.script_noteworthy == "assassination_target" )
            {
                targetplayer = player;
                break;
            }
        }
        
        if ( !isdefined( targetplayer ) )
        {
            targetplayer = player;
            bestplunder = player currency::get_currency_amount( "cash" );
            bestscore = player.score;
            bestdamage = player.extrascore3;
            bestkills = player.kills;
        }
        
        if ( player.kills > bestkills )
        {
            targetplayer = player;
            continue;
        }
        
        if ( player.extrascore3 > bestdamage )
        {
            targetplayer = player;
            continue;
        }
        
        if ( player.score > bestscore )
        {
            targetplayer = player;
            continue;
        }
        
        if ( player currency::get_currency_amount( "cash" ) > bestplunder )
        {
            targetplayer = player;
            continue;
        }
        
        if ( !isdefined( var_8560ccdcd576dea9 ) )
        {
            var_8560ccdcd576dea9 = randomintrange( 1, 3 );
        }
        
        if ( var_8560ccdcd576dea9 == 1 )
        {
            targetplayer = player;
            var_8560ccdcd576dea9 = undefined;
            continue;
        }
        
        var_8560ccdcd576dea9 = undefined;
    }
    
    assert( isdefined( targetplayer ) );
    
    foreach ( player in teams::getteamdata( targetteam, "players" ) )
    {
        player.var_cd87014e0137fe98 = 1;
    }
    
    self.targetplayer = targetplayer;
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x7d7138dc, Offset: 0x40c7
// Size: 0xa4
function determinetrackingcircleposition( targetplayer )
{
    self.var_622ce15ad843d0c8 = targetplayer.origin;
    search_location = ( targetplayer.origin[ 0 ], targetplayer.origin[ 1 ], level.asnprops.var_5955ab4680412425 );
    
    if ( !br_public::function_379fb7b09f4ef13e() )
    {
        search_location += math::random_vector_2d() * randomfloatrange( level.asnprops.circlerangemin, level.asnprops.circlerangemax );
    }
    
    game_utility::questcircle_move( search_location );
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x44bcd4b9, Offset: 0x4173
// Size: 0x197
function determinetrackingcirclesize()
{
    var_beebb530012ad0bb = self.threat_level ?? -1;
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        game_utility::function_d46d8731ed9d281( level.lootleadermarksize );
        self.threat_level = 2;
        function_beb17fd500d4c837( var_beebb530012ad0bb );
        return;
    }
    
    var_118a3444f7925a7f = function_c71712c8f5fe5acc( [ self.hunterteam ] );
    hunterteams = function_e93b6d9bda2355d8( self.targetteam );
    
    if ( hunterteams.size > 1 )
    {
        var_c42d54a81a80a4e8 = function_c71712c8f5fe5acc( hunterteams );
    }
    else
    {
        var_c42d54a81a80a4e8 = var_118a3444f7925a7f;
    }
    
    switch ( var_c42d54a81a80a4e8 )
    {
        case 0:
            self.threat_level = 2;
            break;
        case 1:
            self.threat_level = 1;
            break;
        case 2:
            self.threat_level = 0;
            break;
        default:
            break;
    }
    
    function_beb17fd500d4c837( var_beebb530012ad0bb );
    
    switch ( var_118a3444f7925a7f )
    {
        case 0:
            game_utility::function_d46d8731ed9d281( level.asnprops.var_2d361e591980c9ed );
            break;
        case 1:
            game_utility::function_d46d8731ed9d281( level.asnprops.var_5955ab4680412425 );
            break;
        case 2:
            game_utility::function_d46d8731ed9d281( level.asnprops.var_120d0e4c404bb3e9 );
            break;
    }
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x18906db3, Offset: 0x4312
// Size: 0xf7
function function_beb17fd500d4c837( var_beebb530012ad0bb )
{
    if ( var_beebb530012ad0bb < 0 || self.threat_level == var_beebb530012ad0bb || !isdefined( self.targetteam ) )
    {
        return;
    }
    
    soundalias = "uin_wz2_bounty_threat_down";
    
    if ( self.threat_level > var_beebb530012ad0bb )
    {
        soundalias = "uin_wz2_bounty_threat_up";
    }
    
    foreach ( player in level.teamdata[ self.targetteam ][ "alivePlayers" ] )
    {
        if ( !isdefined( player ) || player br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        player playsoundtoplayer( soundalias, player );
    }
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x265bc960, Offset: 0x4411
// Size: 0x93
function function_e93b6d9bda2355d8( targetteam )
{
    if ( br_publicevents::ispubliceventoftypeactive( %"bountyroyale" ) )
    {
        if ( isdefined( level.var_fdca07a6f0bda1df ) && isdefined( level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15 ) )
        {
            var_57ee2d1096b1e3de = level.var_fdca07a6f0bda1df.var_ed5d663c78f22b15[ targetteam ];
            
            if ( isdefined( var_57ee2d1096b1e3de ) && isdefined( var_57ee2d1096b1e3de.var_6ff8379e9568d24f ) )
            {
                return var_57ee2d1096b1e3de.var_6ff8379e9568d24f;
            }
        }
    }
    
    return [ self.hunterteam ];
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x6211f2b6, Offset: 0x44ad
// Size: 0x1cd
function function_c71712c8f5fe5acc( hunterteams )
{
    hunterplayers = [];
    
    foreach ( team in hunterteams )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            if ( !player br_public::isplayerinorgoingtogulag() && player::isreallyalive( player ) )
            {
                hunterplayers[ hunterplayers.size ] = player;
            }
        }
    }
    
    if ( hunterplayers.size == 0 )
    {
        return 2;
    }
    
    closestdist = undefined;
    
    foreach ( player in hunterplayers )
    {
        dist = distance2d( player.origin, self.targetplayer.origin );
        
        if ( !isdefined( closestdist ) || dist < closestdist )
        {
            closestdist = dist;
        }
    }
    
    return function_5ffc150243fe9719( closestdist );
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x650281f8, Offset: 0x4683
// Size: 0x4c
function function_5ffc150243fe9719( dist )
{
    if ( dist > level.asnprops.var_9045e77431206ed2 )
    {
        return 2;
    }
    
    if ( dist > level.asnprops.var_c661aaa2338138ba )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0xda56ef8f, Offset: 0x46d7
// Size: 0x19f
function determineobjectivevisibility()
{
    foreach ( player in teams::getteamdata( self.hunterteam, "players" ) )
    {
        isingulag = player br_public::isplayerinorgoingtogulag();
        hud_enabled = istrue( player.aq_hudenabled );
        
        if ( isingulag && hud_enabled )
        {
            player hideassassinationhud( self );
        }
        
        if ( !isingulag && !hud_enabled )
        {
            player showassassinationhud( self, self.questmodifier );
        }
    }
    
    foreach ( player in teams::getteamdata( self.targetteam, "players" ) )
    {
        isingulag = player br_public::isplayerinorgoingtogulag();
        hud_enabled = istrue( player.aq_targethudenabled );
        
        if ( isingulag && hud_enabled )
        {
            player hideassassinationtargethud();
        }
        
        if ( !isingulag && !hud_enabled )
        {
            player showassassinationtargethud( self.targetplayer, self.threat_level );
        }
    }
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x22ebe18f, Offset: 0x487e
// Size: 0x62
function getnewtargetplayer( hunter )
{
    if ( function_a27521369409b73() )
    {
        function_72e09138537e825( self.targetteam, hunter );
    }
    else
    {
        self.targetplayer = determinetargetplayer( self.targetteam, hunter );
    }
    
    determinetrackingcircleposition( self.targetplayer );
    determinetrackingcirclesize();
    updateassassinationhud();
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x6c3a9d20, Offset: 0x48e8
// Size: 0x12a
function removeallaqui()
{
    foreach ( player in teams::getteamdata( self.hunterteam, "players" ) )
    {
        player hideassassinationhud( self );
    }
    
    hunterteams = function_e93b6d9bda2355d8( self.targetteam );
    
    if ( hunterteams.size <= 1 )
    {
        foreach ( player in teams::getteamdata( self.targetteam, "players" ) )
        {
            player hideassassinationtargethud();
        }
    }
    
    game_utility::questcircle_delete();
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0xf05c920d, Offset: 0x4a1a
// Size: 0x1fb
function function_23eba376a9862a9c( hunter, victim, paramstruct )
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.var_91770bcd2cf3d204 ) )
    {
        var_2a6a46f1e5442b6b = level.var_91770bcd2cf3d204 * paramstruct.var_cdc033d63ca9867d;
    }
    else
    {
        var_2a6a46f1e5442b6b = 3000 * paramstruct.var_cdc033d63ca9867d;
    }
    
    if ( isdefined( level.var_49394ae30544646e ) )
    {
        var_f8155fd74690d733 = level.var_49394ae30544646e * paramstruct.var_cdc033d63ca9867d;
    }
    else
    {
        var_f8155fd74690d733 = 3 * paramstruct.var_cdc033d63ca9867d;
    }
    
    if ( paramstruct.usecarrier )
    {
        radius = int( paramstruct.pingsize * ( level.var_2ab3ff8456131beb ?? 1 ) );
        pingtime = paramstruct.pingamount * var_f8155fd74690d733 * ( level.var_1099f076e66a8a09 ?? 1 );
    }
    else
    {
        radius = paramstruct.pingsize;
        pingtime = paramstruct.pingamount * var_f8155fd74690d733;
    }
    
    if ( isdefined( self.scriptable ) && int( paramstruct.pingorigin ) == 3 )
    {
        pingorigin = self.scriptable.origin;
    }
    else if ( isdefined( hunter ) && int( paramstruct.pingorigin ) == 2 )
    {
        pingorigin = hunter.origin;
    }
    else if ( isdefined( victim ) )
    {
        pingorigin = victim.origin;
    }
    else
    {
        pingorigin = self.var_622ce15ad843d0c8;
    }
    
    if ( isdefined( pingorigin ) )
    {
        timepassed = 0;
        
        while ( timepassed < pingtime )
        {
            triggerportableradarpingteam( pingorigin, self.hunterteam ?? self.team, radius, var_2a6a46f1e5442b6b );
            wait var_f8155fd74690d733;
            timepassed += var_f8155fd74690d733;
        }
    }
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x52269acc, Offset: 0x4c1d
// Size: 0xa2
function gettargetteamkills( targetteam )
{
    targetteamkills = 0;
    
    foreach ( targetplayer in level.teamdata[ targetteam ][ "players" ] )
    {
        targetteamkills += targetplayer.kills;
    }
    
    return targetteamkills;
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0xb17b8e7a, Offset: 0x4cc8
// Size: 0xa2
function gettargetteamscore( targetteam )
{
    targetteamscore = 0;
    
    foreach ( targetplayer in level.teamdata[ targetteam ][ "players" ] )
    {
        targetteamscore += targetplayer.score;
    }
    
    return targetteamscore;
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0xe1a98d11, Offset: 0x4d73
// Size: 0xa2
function function_e82828f32f2a14cf( targetteam )
{
    var_e51fd20ee42a7f6b = 0;
    
    foreach ( targetplayer in level.teamdata[ targetteam ][ "players" ] )
    {
        var_e51fd20ee42a7f6b += targetplayer.extrascore3;
    }
    
    return var_e51fd20ee42a7f6b;
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x7a45a408, Offset: 0x4e1e
// Size: 0xca
function function_4ac9543d7a2863b8( targetteam )
{
    var_3d4e35dca090e644 = 0;
    
    foreach ( targetplayer in level.teamdata[ targetteam ][ "players" ] )
    {
        var_6355b03aa74e720b = targetplayer currency::get_currency_amount( "cash" );
        
        if ( !isdefined( var_6355b03aa74e720b ) )
        {
            plunder = 0;
            var_3d4e35dca090e644 += plunder;
            continue;
        }
        
        var_3d4e35dca090e644 += var_6355b03aa74e720b;
    }
    
    return var_3d4e35dca090e644;
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x70d1bb44, Offset: 0x4ef1
// Size: 0x11, Type: bool
function function_a27521369409b73()
{
    return self.questmodifier == "master";
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x4d261725, Offset: 0x4f0b
// Size: 0x26
function getplayerkills()
{
    if ( level.br_leaderbystreak )
    {
        return self.killsthislife.size;
    }
    
    return self.kills;
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x23687da9, Offset: 0x4f39
// Size: 0x50
function getfilterformodifier( modifier )
{
    switch ( modifier )
    {
        case #"hash_b62fe7e71b905a1":
        case #"hash_ee90b669e8938abd":
            return level.questinfo.defaultfilter;
        default:
            return 0;
    }
}

// Namespace br_assassination_quest
// Params 2
// Checksum 0x39e091d7, Offset: 0x4f91
// Size: 0x59
function showassassinationhud( instance, questmodifier )
{
    self.aq_hudenabled = 1;
    
    if ( questmodifier == "master" )
    {
        br_contract_manager::uiobjectiveshow( questmodifier + "_" + "assassination" );
    }
    else
    {
        br_contract_manager::uiobjectiveshow( "assassination" );
    }
    
    instance game_utility::questcircle_showtoplayer( self );
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0xef319899, Offset: 0x4ff2
// Size: 0x27
function hideassassinationhud( instance )
{
    self.aq_hudenabled = 0;
    br_contract_manager::uiobjectivehide();
    instance game_utility::questcircle_hidefromplayer( self );
}

// Namespace br_assassination_quest
// Params 1
// Checksum 0x14300b70, Offset: 0x5021
// Size: 0xa2
function updateassassinationthreatlevel( targetteam )
{
    foreach ( player in teams::getteamdata( self.targetteam, "players" ) )
    {
        player br_contract_manager::function_173bf8dac654a1e1( self.targetplayer, self.threat_level );
    }
}

// Namespace br_assassination_quest
// Params 2
// Checksum 0xde7d8901, Offset: 0x50cb
// Size: 0x2a
function showassassinationtargethud( targetplayer, threatlevel )
{
    self.aq_targethudenabled = 1;
    br_contract_manager::function_173bf8dac654a1e1( targetplayer, threatlevel );
}

// Namespace br_assassination_quest
// Params 3
// Checksum 0xf07000cd, Offset: 0x50fd
// Size: 0x63
function function_8fc6926e1c84d855( targetplayer, threatlevel, task )
{
    self.aq_targethudenabled = 1;
    self setclientomnvar( "ui_br_assassination_target_timer", task.missiontime );
    self setclientomnvar( "ui_br_assassination_target_timer_progress_bar", task.totaltime * 1000 );
    br_contract_manager::function_173bf8dac654a1e1( targetplayer, threatlevel );
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0xfb54ebe4, Offset: 0x5168
// Size: 0x18
function hideassassinationtargethud()
{
    self.aq_targethudenabled = 0;
    self setclientomnvar( "ui_br_assassination_target", 0 );
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0xe41c7058, Offset: 0x5188
// Size: 0x160
function updateassassinationhud()
{
    foreach ( player in teams::getteamdata( self.hunterteam, "players" ) )
    {
        player showassassinationhud( self, self.questmodifier );
        player br_contract_manager::uiobjectivesetparameter( self.targetplayer getentitynumber() );
    }
    
    foreach ( player in teams::getteamdata( self.targetteam, "players" ) )
    {
        player showassassinationtargethud( self.targetplayer, self.threat_level );
        player setclientomnvar( "ui_br_assassination_target_timer", self.missiontime );
        player setclientomnvar( "ui_br_assassination_target_timer_progress_bar", self.totaltime * 1000 );
    }
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x27cb9143, Offset: 0x52f0
// Size: 0x62
function gametypeoverrideassassinsearchparams()
{
    overrideparams = 0;
    gametype = game_utility::getgametype();
    
    switch ( gametype )
    {
        case #"hash_59b8e9d05b31ff9":
        case #"hash_8299694594ab149d":
        case #"hash_83058a20a2b7cb50":
        case #"hash_bfabc434c59611fa":
            overrideparams = 1;
            break;
    }
    
    return overrideparams;
}

// Namespace br_assassination_quest
// Params 0
// Checksum 0x4b3b220f, Offset: 0x535b
// Size: 0x20
function function_8225394f018d1121()
{
    if ( !isdefined( level.var_179b6c3280c0c8f8 ) )
    {
        return 0;
    }
    
    return arraycontains( level.var_179b6c3280c0c8f8, self );
}

// Namespace br_assassination_quest
// Params 2
// Checksum 0xeaf18858, Offset: 0x5384
// Size: 0xd3, Type: bool
function function_a63112a0f410ccf7( victim, attacker )
{
    if ( !isdefined( attacker ) || !isdefined( victim ) )
    {
        return false;
    }
    
    attackerteam = attacker.team;
    
    if ( isdefined( attackerteam ) && isdefined( level.contractmanager.var_ec04bf3a584cbd90[ attackerteam ] ) )
    {
        contract = level.contractmanager.var_ec04bf3a584cbd90[ attackerteam ];
        
        if ( contract.category == "assassination" || contract.category == "master_" + "assassination" )
        {
            if ( contract.hunterteam == attackerteam && contract.targetplayer == victim )
            {
                return true;
            }
        }
    }
    
    return false;
}

