// script_3953cae29477fdd4  (hash_3953cae29477fdd4.gscc) (size: 19653 Bytes / 0x4cc5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a64b7e4 (1516550116)
// size ...... 19653 (0x4cc5)
// includes .. 23  (offset: 0x489d)
// strings ... 43  (offset: 0x4955)
// dev strs .. 3   (offset: 0x4ca1)
// exports ... 50  (offset: 0x3135)
// cseg ...... 0x354 + 0x2de1 (0x3135)
// imports ... 126 (offset: 0x3905)
// animtree1 . 0   (offset: 0x4cc5)
// animtree2 . 0   (offset: 0x4cc5)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_assassination_quest;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace namespace_2acee5c054dc328c;

// Namespace namespace_2acee5c054dc328c
// Params 0, eflags: 0x5
// Checksum 0x249ae17b, Offset: 0x372
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_e4dcf95ab693eab", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_2acee5c054dc328c
// Params 0, eflags: 0x4
// Checksum 0x7f66e963, Offset: 0x39b
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_CONTRACT_BOUNTY", &activity_type_init );
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0xd8cd1a09, Offset: 0x3b6
// Size: 0xef
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_BOUNTY", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_BOUNTY", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_BOUNTY", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_BOUNTY", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BR_CONTRACT_BOUNTY" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_CONTRACT_BOUNTY" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &player_killed, "BR_CONTRACT_BOUNTY" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerEnterGulagMoment", &player_entergulag, "BR_CONTRACT_BOUNTY" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerRespawnedMoment", &player_respawn, "BR_CONTRACT_BOUNTY" );
    activity_common::function_2dd4f07fa5c3e911( "BRTimerExpired", &timer_expired, "BR_CONTRACT_BOUNTY" );
    utility::registersharedfunc( #"challenges", #"hash_fe4251017975f1a4", &function_54071707336fc8a4 );
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0x2c9d6fdf, Offset: 0x4ad
// Size: 0x4b
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    function_bc041d7a3efbfe87( self.varianttag, self.var_332f929de1894b2b );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace namespace_2acee5c054dc328c
// Params 2
// Checksum 0xbe4b6594, Offset: 0x500
// Size: 0x194
function function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "mission_" + variantname + "_accept" ] ) )
    {
        game[ "dialog" ][ "mission_" + variantname + "_accept" ] = data.var_35004c1bd1f599d7;
        game[ "dialog" ][ "mission_" + variantname + "_accept_first_person" ] = data.var_fdf9ad0f5f57aece;
        game[ "dialog" ][ "mission_" + variantname + "_success" ] = data.var_722663430868f18e;
        game[ "dialog" ][ "mission_" + variantname + "_fail" ] = data.var_201f1e5780482f6f;
        game[ "dialog" ][ "mission_" + variantname + "_poached" ] = data.var_74af3ab9b3e30843;
        game[ "dialog" ][ "mission_" + variantname + "_hunted" ] = data.var_656d9951feac6e07;
        game[ "dialog" ][ "mission_" + variantname + "_hunted_team" ] = data.var_81599b95f5f62096;
        game[ "dialog" ][ "mission_" + variantname + "_hunted_success" ] = data.var_c7ba6aade39e1fba;
        game[ "dialog" ][ "mission_" + variantname + "_hunted_timed_out" ] = data.var_66d7265d223cfcda;
        game[ "dialog" ][ "mission_" + variantname + "_hunted_fail" ] = data.var_112606f36466b973;
    }
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0x7731a213, Offset: 0x69c
// Size: 0x73
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    bounty_begin();
    
    if ( self.cancelled )
    {
        return;
    }
    
    params = spawnstruct();
    params.distance = distance2d( self.var_441d26d05f86b224, self.targetplayer.origin );
    br_activity_util::startcontract( params );
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0xd65d8b01, Offset: 0x717
// Size: 0x7a
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( self.targetplayer )
    {
        self.targetplayer.var_5cb861c1a2f605e5[ self.team ] = gettime();
    }
    
    if ( !self.cancelled )
    {
        activity_succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
        bounty_ended( activity_succeeded );
    }
    
    bounty_cleanup();
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0x82bbd511, Offset: 0x799
// Size: 0x5d
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( !isdefined( activity_instance.cancelled ) )
    {
        level.var_179b6c3280c0c8f8 = arrayremove( level.var_179b6c3280c0c8f8, teams::getteamdata( self.targetteam, "players" ) );
        function_41276a70e2083ce8();
    }
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0x88f4e81e, Offset: 0x7fe
// Size: 0x6cb
function bounty_begin()
{
    if ( !isdefined( self.team ) )
    {
        self.team = self.var_ca369031b554da2f.team;
    }
    
    self.var_2caf42ecba63b0b1 = !level.br_circle_disabled && level.br_multi_circle_enabled && level.br_multi_circle.issplit;
    
    switch ( self.var_332f929de1894b2b.selectionmethod )
    {
        case #"hash_f81f6f6ee4ce49a2":
            self.targetteam = br_assassination_quest::determinetargetteam( self.var_ca369031b554da2f, self.var_2caf42ecba63b0b1, undefined, self.var_332f929de1894b2b );
            
            if ( isdefined( self.targetteam ) )
            {
                self.targetplayer = br_assassination_quest::determinetargetplayer( self.targetteam, self.var_ca369031b554da2f, self.var_2caf42ecba63b0b1 );
            }
            
            if ( isdefined( self.targetplayer ) )
            {
                level.var_179b6c3280c0c8f8 = arraycombine( level.var_179b6c3280c0c8f8, teams::getteamdata( self.targetteam, "players" ) );
            }
            
            break;
        case #"hash_88e5a25c217b013a":
            self.targetteam = function_bc40a9ce9b6e1c57( self.var_ca369031b554da2f, self.var_2caf42ecba63b0b1 );
            
            if ( isdefined( self.targetteam ) )
            {
                self.targetplayer = function_f332b156d97626f( self.targetteam, self.var_ca369031b554da2f, self.var_2caf42ecba63b0b1 );
            }
            
            if ( isdefined( self.targetplayer ) )
            {
                level.var_179b6c3280c0c8f8 = arraycombine( level.var_179b6c3280c0c8f8, teams::getteamdata( self.targetteam, "players" ) );
            }
            
            break;
        case #"hash_cf3b79ccb49199e2":
            if ( isdefined( self.targetteam ) )
            {
                self.targetplayer = br_assassination_quest::determinetargetplayer( self.targetteam, self.var_ca369031b554da2f, self.var_2caf42ecba63b0b1 );
            }
            
            if ( isdefined( self.targetplayer ) )
            {
                level.var_179b6c3280c0c8f8 = arraycombine( level.var_179b6c3280c0c8f8, teams::getteamdata( self.targetteam, "players" ) );
            }
            
            break;
        default:
            assertmsg( "<dev string:x2b>" );
            break;
    }
    
    if ( !isdefined( self.targetplayer ) )
    {
        self.var_ca369031b554da2f lower_message::setlowermessageomnvar( "br_assassination_notargets", undefined, 5 );
        
        if ( common_item::items_isenabled() )
        {
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( self.var_332f929de1894b2b.pityrewardcache );
            
            if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
            {
                var_172c0b3fd116d7df = var_f67995529827f79.spawnlistname;
                spawncount = var_f67995529827f79.spawncount;
                spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.var_ca369031b554da2f.origin, self.var_fe0156f1cf4e5f41.angles );
                common_item::function_38cde6a6acb68ea6( var_172c0b3fd116d7df, spawncount, spawnoptions );
            }
        }
        
        self.cancelled = 1;
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    foreach ( player in function_e81b47418f8e5d47() )
    {
        if ( player == self.var_ca369031b554da2f )
        {
            player thread hud_message::showsplash( self.var_332f929de1894b2b.var_8854615c68b94be9 );
            continue;
        }
        
        player thread hud_message::showsplash( self.var_332f929de1894b2b.var_893fee996ae057c0 );
    }
    
    if ( isdefined( self.var_ca369031b554da2f ) )
    {
        level thread br_public::brleaderdialogplayer( "mission_" + self.varianttag + "_accept_first_person", self.var_ca369031b554da2f, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_e3ef2dac93f4bdcb, undefined, 1 );
        level thread br_public::brleaderdialogteamexcludeplayer( "mission_" + self.varianttag + "_accept", self.team, self.var_ca369031b554da2f, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_74c338def881a3c2, 1 );
    }
    else
    {
        level thread br_public::brleaderdialogteam( "mission_" + self.varianttag + "_accept", self.team, 1, 2, undefined, self.var_332f929de1894b2b.var_74c338def881a3c2, undefined, 1 );
    }
    
    foreach ( player in function_315692e8880af5d5() )
    {
        if ( player == self.targetplayer )
        {
            if ( self.var_332f929de1894b2b.var_4fc67133ff634208 != "" )
            {
                player thread hud_message::showsplash( self.var_332f929de1894b2b.var_4fc67133ff634208 );
            }
            
            continue;
        }
        
        if ( self.var_332f929de1894b2b.var_7b8baa3cefff6404 != "" )
        {
            player thread hud_message::showsplash( self.var_332f929de1894b2b.var_7b8baa3cefff6404 );
        }
    }
    
    level thread br_public::brleaderdialogplayer( "mission_" + self.varianttag + "_hunted", self.targetplayer, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_cf7393e19030a11b, undefined, 1 );
    level thread br_public::brleaderdialogteamexcludeplayer( "mission_" + self.varianttag + "_hunted_team", self.targetteam, self.targetplayer, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_41216185f5a650ea, 1 );
    game_utility::questcircle_create( "Assassination_Br" );
    determinetrackingcircleposition( self.targetplayer );
    determinetrackingcirclesize();
    thread watchcircle();
    thread watchforgameended();
    thread function_9097f4fee4aaa5c7();
    thread function_4c9bf3340f578b07();
    br_activity_util::function_3fbbc67df36be7bb( self.var_332f929de1894b2b.contracttime );
    activity_definition_utils::updatetimer( self.var_332f929de1894b2b.contracttime, self );
    function_e5f1dfb8e79fa571();
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x5624cdf9, Offset: 0xed1
// Size: 0x38
function bounty_ended( succeeded )
{
    if ( level.gameended )
    {
        assertmsg( "<dev string:x5f>" );
        return;
    }
    
    function_e394423d592489fc( succeeded );
    function_edd8d20240ab42a5( succeeded );
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x1c64226d, Offset: 0xf11
// Size: 0x253
function function_e394423d592489fc( succeeded )
{
    if ( succeeded )
    {
        if ( !self.poached )
        {
            br_activity_util::displaysplashtoplayers( function_e81b47418f8e5d47(), self.var_332f929de1894b2b.splashsucess );
            level thread br_public::brleaderdialogteam( "mission_" + self.varianttag + "_success", self.team, 1, 2, undefined, self.var_332f929de1894b2b.var_11f87a6ededa3182, undefined, 1 );
        }
        else
        {
            br_activity_util::displaysplashtoplayers( function_e81b47418f8e5d47(), self.var_332f929de1894b2b.splashpoached );
            level thread br_public::brleaderdialogteam( "mission_" + self.varianttag + "_poached", self.team, 1, 2, undefined, self.var_332f929de1894b2b.var_327b63da4f178f57, undefined, 1 );
        }
        
        enemyplayers = function_315692e8880af5d5();
        
        if ( self.var_332f929de1894b2b.var_593df5eff5f3ea35 != "" )
        {
            br_activity_util::displaysplashtoplayers( enemyplayers, self.var_332f929de1894b2b.var_593df5eff5f3ea35 );
        }
        
        level thread br_public::brleaderdialogteam( "mission_" + self.varianttag + "_hunted_fail", self.targetteam, 1, 2, undefined, self.var_332f929de1894b2b.var_6027a2ad6ff0d367, undefined, 1 );
        return;
    }
    
    br_activity_util::displaysplashtoplayers( function_e81b47418f8e5d47(), self.var_332f929de1894b2b.splashfail );
    enemyplayers = function_315692e8880af5d5();
    
    if ( self.var_332f929de1894b2b.var_77975e33576cf148 != "" )
    {
        br_activity_util::displaysplashtoplayers( enemyplayers, self.var_332f929de1894b2b.var_77975e33576cf148 );
    }
    
    level thread br_public::brleaderdialogteam( "mission_" + self.varianttag + "_fail", self.team, 1, 2, undefined, self.var_332f929de1894b2b.var_7a0b26b908419be3, undefined, 1 );
    level thread br_public::brleaderdialogteam( "mission_" + self.varianttag + "_hunted_success", self.targetteam, 1, 2, undefined, self.var_332f929de1894b2b.var_49da90b3c96729fe, undefined, 1 );
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x33de23c5, Offset: 0x116c
// Size: 0x187
function function_edd8d20240ab42a5( succeeded )
{
    if ( !flags::levelflag( "game_over" ) )
    {
    }
    
    if ( succeeded )
    {
        if ( self.poached )
        {
            rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.poachedrewardgroup, self.var_ca369031b554da2f );
        }
        else
        {
            rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.rewardgroup, self.var_ca369031b554da2f );
            
            if ( self.var_332f929de1894b2b.pingreward )
            {
                thread br_assassination_quest::function_23eba376a9862a9c( self.targetplayer.lastkilledby, self.targetplayer, self.var_332f929de1894b2b );
            }
        }
    }
    else
    {
        rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.avertedrewardgroup, self.targetplayer, self.targetteam );
    }
    
    if ( succeeded )
    {
        self.endstate = self.poached ? "Vanished" : "Win";
    }
    else if ( !isdefined( self.endstate ) )
    {
        self.endstate = "Killed";
    }
    
    br_activity_util::endcontract( succeeded, rewards, self.endstate );
    
    if ( isdefined( self.var_19d735a171153362 ) && isdefined( self.overridecontext ) )
    {
        self.overridecontext thread [[ self.var_19d735a171153362 ]]( self, succeeded, self.endstate );
    }
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0x79c1edf, Offset: 0x12fb
// Size: 0x2
function bounty_cleanup()
{
    
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0xc781b0b8, Offset: 0x1305
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0xfeeb61a4, Offset: 0x1345
// Size: 0xa6
function player_killed( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( victim == self.targetplayer )
    {
        victim.var_5cb861c1a2f605e5[ self.team ] = gettime();
        
        if ( !activity_participation::function_e7fc1202ac164928( self, attacker ) )
        {
            self.poached = 1;
        }
        
        activity_instance_common::endactivity( self, 1 );
        return;
    }
    
    if ( activity_participation::function_e7fc1202ac164928( self, victim ) )
    {
        if ( !br_activity_util::function_79f1eba39959ffed( self ) )
        {
            activity_instance_common::endactivity( self, 0 );
        }
    }
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x14e1ed7b, Offset: 0x13f3
// Size: 0x5c
function player_entergulag( params )
{
    player = params.player;
    
    if ( activity_participation::function_e7fc1202ac164928( self, player ) )
    {
        game_utility::questcircle_hidefromplayer( player );
        return;
    }
    
    if ( player.team == self.targetteam )
    {
        player function_ca67d15b266a8999();
    }
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0xca9f153a, Offset: 0x1457
// Size: 0x92
function player_respawn( params )
{
    player = params.player;
    
    if ( activity_instance_common::getactivitystate( self ) != "Active" && !getdvarint( @"hash_783b1293901654d6", 0 ) )
    {
        return;
    }
    
    if ( activity_participation::function_e7fc1202ac164928( self, player ) )
    {
        game_utility::questcircle_showtoplayer( player );
        return;
    }
    
    if ( player.team == self.targetteam )
    {
        player function_85c402ca21b97aa2( self.targetplayer, self.threat_level );
    }
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0xd8a8d899, Offset: 0x14f1
// Size: 0x23
function timer_expired( params )
{
    self.endstate = "Time";
    activity_instance_common::endactivity( self, 0 );
}

// Namespace namespace_2acee5c054dc328c
// Params 2
// Checksum 0x8ca1fceb, Offset: 0x151c
// Size: 0xf9, Type: bool
function function_54071707336fc8a4( victim, attacker )
{
    if ( !isdefined( attacker ) || !isdefined( victim ) )
    {
        return false;
    }
    
    attackerteam = attacker.team;
    var_aecc96ba19b0e317 = activity_participation::function_e8eabd79cc49540e( attacker, "BR_CONTRACT_BOUNTY" );
    
    foreach ( bountyactivity in var_aecc96ba19b0e317 )
    {
        activityinstance = level.activities.instances[ bountyactivity.instanceid ];
        
        if ( activityinstance.targetplayer == victim )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_2acee5c054dc328c
// Params 2
// Checksum 0x6f2fb86b, Offset: 0x161e
// Size: 0x542
function function_bc40a9ce9b6e1c57( player, var_2caf42ecba63b0b1 )
{
    hunterteam = player.team;
    bestteam = undefined;
    potentialtargets = level.players;
    list1 = level.var_179b6c3280c0c8f8;
    list2 = teams::getteamdata( hunterteam, "players" );
    excludedteams = arraycombineunique( list1, list2 );
    search_bounds = 0;
    searchminradius = self.var_332f929de1894b2b.minsearchradius;
    var_cbbb9e520c58a2a8 = self.var_332f929de1894b2b.var_bb48e4be7d9b68b3;
    searchlimit = self.var_332f929de1894b2b.searchlimit;
    
    while ( !isdefined( bestteam ) )
    {
        playerlist = [];
        potentiallist = utility::get_array_of_closest( player.origin, potentialtargets, excludedteams, undefined, undefined, undefined );
        
        foreach ( potentialtarget in potentiallist )
        {
            if ( var_2caf42ecba63b0b1 && !br_circle_util::function_554002773c2c21f7( player.origin, potentialtarget.origin ) )
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

// Namespace namespace_2acee5c054dc328c
// Params 3
// Checksum 0x4ed93c14, Offset: 0x1b68
// Size: 0x325
function function_f332b156d97626f( targetteam, hunter, var_2caf42ecba63b0b1 )
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
    
    return targetplayer;
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0xf91af111, Offset: 0x1e96
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

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x4c1d4221, Offset: 0x1f41
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

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x2ef923c8, Offset: 0x1fec
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

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x87236853, Offset: 0x2097
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

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x7eaf0f91, Offset: 0x216a
// Size: 0x28, Type: bool
function function_72f666fd14cbc49c( activity_data )
{
    if ( activity_data.var_343aa7caf2fec1a3 == 0 )
    {
        return false;
    }
    
    return istrue( self.var_8946ce0ae9eb0955 );
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x6e2faa42, Offset: 0x219b
// Size: 0xa4
function determinetrackingcircleposition( targetplayer )
{
    self.var_622ce15ad843d0c8 = targetplayer.origin;
    search_location = ( targetplayer.origin[ 0 ], targetplayer.origin[ 1 ], self.var_332f929de1894b2b.var_5955ab4680412425 );
    
    if ( !br_public::function_379fb7b09f4ef13e() )
    {
        search_location += math::random_vector_2d() * randomfloatrange( self.var_332f929de1894b2b.circlerangemin, self.var_332f929de1894b2b.circlerangemax );
    }
    
    game_utility::questcircle_move( search_location );
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0x613e06f5, Offset: 0x2247
// Size: 0x264
function determinetrackingcirclesize()
{
    var_beebb530012ad0bb = self.threat_level ?? -1;
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        game_utility::function_d46d8731ed9d281( level.lootleadermarksize );
        self.threat_level = 2;
        function_9db1f5842978a32a( var_beebb530012ad0bb );
        return;
    }
    
    var_118a3444f7925a7f = function_c71712c8f5fe5acc( [ self.team ] );
    hunterteams = function_e93b6d9bda2355d8( self.targetteam );
    
    if ( hunterteams.size > 1 )
    {
        var_c42d54a81a80a4e8 = function_c71712c8f5fe5acc( hunterteams );
    }
    else
    {
        var_c42d54a81a80a4e8 = var_118a3444f7925a7f;
    }
    
    if ( level.gametype == "bongo" )
    {
        distancetotarget = function_8bf5fc2c811d4c6e( hunterteams );
        
        if ( distancetotarget <= self.var_332f929de1894b2b.var_ab5ff59e33caef13 )
        {
            self.threat_level = 4;
        }
        else if ( distancetotarget <= self.var_332f929de1894b2b.var_ab5ffa9e33cafa12 )
        {
            self.threat_level = 3;
        }
        else if ( distancetotarget <= self.var_332f929de1894b2b.var_ab5ffb9e33cafc45 )
        {
            self.threat_level = 2;
        }
        else if ( distancetotarget <= self.var_332f929de1894b2b.var_ab5ff89e33caf5ac )
        {
            self.threat_level = 1;
        }
        else
        {
            self.threat_level = 0;
        }
    }
    else
    {
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
    }
    
    function_9db1f5842978a32a( var_beebb530012ad0bb );
    
    switch ( var_118a3444f7925a7f )
    {
        case 0:
            game_utility::function_d46d8731ed9d281( self.var_332f929de1894b2b.var_2d361e591980c9ed );
            break;
        case 1:
            game_utility::function_d46d8731ed9d281( self.var_332f929de1894b2b.var_5955ab4680412425 );
            break;
        case 2:
            game_utility::function_d46d8731ed9d281( self.var_332f929de1894b2b.var_120d0e4c404bb3e9 );
            break;
    }
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x57bb8c1b, Offset: 0x24b3
// Size: 0xf7
function function_9db1f5842978a32a( var_beebb530012ad0bb )
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

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x69a759b4, Offset: 0x25b2
// Size: 0x21
function function_d23d643f29b17249( activity_instance )
{
    self.aq_hudenabled = 1;
    activity_instance game_utility::questcircle_showtoplayer( self );
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x3af2fe1d, Offset: 0x25db
// Size: 0x27
function function_1156fafae10204ee( activity_instance )
{
    self.aq_hudenabled = 0;
    br_contract_manager::uiobjectivehide();
    activity_instance game_utility::questcircle_hidefromplayer( self );
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x66f8921b, Offset: 0x260a
// Size: 0xa2
function function_5d75b7850e103e0e( targetteam )
{
    foreach ( player in teams::getteamdata( self.targetteam, "players" ) )
    {
        player br_contract_manager::function_173bf8dac654a1e1( self.targetplayer, self.threat_level );
    }
}

// Namespace namespace_2acee5c054dc328c
// Params 2
// Checksum 0x793ba487, Offset: 0x26b4
// Size: 0x2a
function function_85c402ca21b97aa2( targetplayer, threatlevel )
{
    self.aq_targethudenabled = 1;
    br_contract_manager::function_173bf8dac654a1e1( targetplayer, threatlevel );
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0x914285ea, Offset: 0x26e6
// Size: 0x18
function function_ca67d15b266a8999()
{
    self.aq_targethudenabled = 0;
    self setclientomnvar( "ui_br_assassination_target", 0 );
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0x3c120b55, Offset: 0x2706
// Size: 0x1e6
function function_e5f1dfb8e79fa571()
{
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player function_d23d643f29b17249( self );
    }
    
    foreach ( player in function_d7d4f7004916305() )
    {
        if ( level.gametype == "bongo" || getprojectname() == "REW" )
        {
            player activity_definition_utils::function_63ba9cba37249190( self.targetplayer getentitynumber(), self );
            continue;
        }
        
        player br_contract_manager::uiobjectivesetparameter( self.targetplayer getentitynumber() );
    }
    
    foreach ( player in function_ff4a3eabfee809e7() )
    {
        player function_85c402ca21b97aa2( self.targetplayer, self.threat_level );
        player setclientomnvar( "ui_br_assassination_target_timer", self.missiontime );
        player setclientomnvar( "ui_br_assassination_target_timer_progress_bar", self.totaltime * 1000 );
    }
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0xce723b95, Offset: 0x28f4
// Size: 0x12a
function function_41276a70e2083ce8()
{
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player function_1156fafae10204ee( self );
    }
    
    hunterteams = function_e93b6d9bda2355d8( self.targetteam );
    
    if ( hunterteams.size <= 1 )
    {
        foreach ( player in teams::getteamdata( self.targetteam, "players" ) )
        {
            player function_ca67d15b266a8999();
        }
    }
    
    game_utility::questcircle_delete();
}

// Namespace namespace_2acee5c054dc328c
// Params 0, eflags: 0x4
// Checksum 0xbf087618, Offset: 0x2a26
// Size: 0x6c
function private function_e81b47418f8e5d47()
{
    if ( self.var_332f929de1894b2b.var_d8afb0382ebbfee9 == "None" )
    {
        return [];
    }
    
    if ( self.var_332f929de1894b2b.var_d8afb0382ebbfee9 == "PickupPlayerOnly" && self.var_ca369031b554da2f )
    {
        return [ self.var_ca369031b554da2f ];
    }
    
    return teams::getteamdata( self.team, "players" );
}

// Namespace namespace_2acee5c054dc328c
// Params 0, eflags: 0x4
// Checksum 0x657d4052, Offset: 0x2a9b
// Size: 0x6c
function private function_315692e8880af5d5()
{
    if ( self.var_332f929de1894b2b.var_6aa6f0ca5fe1d93b == "None" )
    {
        return [];
    }
    
    if ( self.var_332f929de1894b2b.var_6aa6f0ca5fe1d93b == "TargetPlayerOnly" && self.targetplayer )
    {
        return [ self.targetplayer ];
    }
    
    return teams::getteamdata( self.targetteam, "players" );
}

// Namespace namespace_2acee5c054dc328c
// Params 0, eflags: 0x4
// Checksum 0x8bb834f7, Offset: 0x2b10
// Size: 0x4e
function private function_d7d4f7004916305()
{
    if ( self.var_332f929de1894b2b.var_e0adf56423969483 == "PickupPlayerOnly" && self.var_ca369031b554da2f )
    {
        return [ self.var_ca369031b554da2f ];
    }
    
    return teams::getteamdata( self.team, "players" );
}

// Namespace namespace_2acee5c054dc328c
// Params 0, eflags: 0x4
// Checksum 0x6adb33f3, Offset: 0x2b67
// Size: 0x4e
function private function_ff4a3eabfee809e7()
{
    if ( self.var_332f929de1894b2b.var_a340ec75037b0aa1 == "TargetPlayerOnly" && self.targetplayer )
    {
        return [ self.targetplayer ];
    }
    
    return teams::getteamdata( self.targetteam, "players" );
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0xce17075d, Offset: 0x2bbe
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
    
    return [ self.team ];
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x2f3f5cdc, Offset: 0x2c5a
// Size: 0x1ca
function function_8bf5fc2c811d4c6e( hunterteams )
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
        return 2147483647;
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
    
    return closestdist;
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0xa6e88b17, Offset: 0x2e2d
// Size: 0x28
function function_c71712c8f5fe5acc( hunterteams )
{
    closestdist = function_8bf5fc2c811d4c6e( hunterteams );
    return function_5ffc150243fe9719( closestdist );
}

// Namespace namespace_2acee5c054dc328c
// Params 1
// Checksum 0x31e95146, Offset: 0x2e5e
// Size: 0x4c
function function_5ffc150243fe9719( dist )
{
    if ( dist > self.var_332f929de1894b2b.var_9045e77431206ed2 )
    {
        return 2;
    }
    
    if ( dist > self.var_332f929de1894b2b.var_c661aaa2338138ba )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_2acee5c054dc328c
// Params 4
// Checksum 0x8c1f2311, Offset: 0x2eb2
// Size: 0xba, Type: bool
function function_6a015dc94c111927( hunterteam, targetteam, var_19d735a171153362, overridecontext )
{
    activitystate = activity_instance_common::getactivitystate( self );
    
    if ( activitystate != "Idle" )
    {
        return false;
    }
    
    self.var_332f929de1894b2b.selectionmethod = "ScriptOverride";
    self.team = hunterteam;
    self.hunterteam = hunterteam;
    self.targetteam = targetteam;
    self.var_19d735a171153362 = var_19d735a171153362;
    self.overridecontext = overridecontext;
    hunterplayers = teams::getteamdata( hunterteam, "alivePlayers" );
    activity_participation::function_fb0ec90aaf6d4c61( self, hunterplayers );
    return true;
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0xe6381b7f, Offset: 0x2f75
// Size: 0x25
function watchforgameended()
{
    self endon( #"instance_destroyed" );
    level waittill( #"game_ended" );
    waitframe();
    activity_instance_common::endactivity( self, 0 );
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0x7a175a42, Offset: 0x2fa2
// Size: 0x5d
function watchcircle()
{
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        determinetrackingcircleposition( self.targetplayer );
        determinetrackingcirclesize();
        function_5d75b7850e103e0e( self.targetteam );
        wait self.var_332f929de1894b2b.var_f3294a70aa4f0b9f;
    }
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0x12beded, Offset: 0x3007
// Size: 0x49
function function_9097f4fee4aaa5c7()
{
    activity = self;
    activity endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    activity.targetplayer waittill( #"disconnect" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_2acee5c054dc328c
// Params 0
// Checksum 0xfd576228, Offset: 0x3058
// Size: 0xdd
function function_4c9bf3340f578b07()
{
    activity = self;
    activity endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        var_88b519152b97f56a = undefined;
        playerlist = activity_instance_common::function_4225efca86f0dea9( activity );
        
        foreach ( player in playerlist )
        {
            if ( !isdefined( var_88b519152b97f56a ) )
            {
                var_88b519152b97f56a = player;
            }
        }
        
        if ( !var_88b519152b97f56a )
        {
            break;
        }
        
        var_88b519152b97f56a waittill( #"disconnect" );
    }
    
    activity_instance_common::endactivity( self, 0 );
}

