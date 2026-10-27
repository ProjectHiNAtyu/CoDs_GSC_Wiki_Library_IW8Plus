// script_75fecbc25d98df76  (hash_75fecbc25d98df76.gscc) (size: 15440 Bytes / 0x3c50 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad84512c (2911129900)
// size ...... 15440 (0x3c50)
// includes .. 27  (offset: 0x3544)
// strings ... 92  (offset: 0x361c)
// dev strs .. 2   (offset: 0x3c38)
// exports ... 30  (offset: 0x222c)
// cseg ...... 0x89b + 0x1991 (0x222c)
// imports ... 120 (offset: 0x26dc)
// animtree1 . 0   (offset: 0x3c50)
// animtree2 . 0   (offset: 0x3c50)
#using script_2f94849b5aff8f5a;
#using script_3067b01582da0888;
#using script_33cd8a7250381109;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle_spawn;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\skirmish_activities;
#using scripts\mp\gametypes\skirmish_bounty;
#using scripts\mp\gametypes\skirmish_respawn;
#using scripts\mp\gametypes\skirmish_supply_drop;
#using scripts\mp\gametypes\skirmish_util;
#using scripts\mp\gametypes\skydive_protection;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\spawnlogic;

#namespace skirmish;

// Namespace skirmish
// Params 0
// Checksum 0xd97febbd, Offset: 0x8b9
// Size: 0x23a
function main()
{
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    function_f9289ff63dd7b58a();
    function_b046546dbef65f4b();
    join_team_aggregator::registeronplayerjointeamcallback( &function_3da4d7c702115eea );
    callback::add( #"player_death", &onplayerdeath );
    callback::add( #"hash_d4bbb4278ed1fcab", &function_e8330199e3be6ed7 );
    callback::add( #"game_ended", &function_2ead6d7add3d72 );
    utility::registersharedfunc( #"hellstorm_missile", #"getcustomstartandtargetposition", &skirmish_util::getcustomstartandtargetposition );
    level.teambased = 1;
    level.multiteambased = 1;
    level.flagmodelhidden = 1;
    level.var_5d54f1947348e054 = 1;
    level.onstartgametype = &onstartgametype;
    level.allowclasschoicefunc = &allowclasschoicefunc;
    level.onplayerconnect = &onplayerconnect;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.var_6ee986c6c0f5d22c = allowed[ 0 ] == "skirmish" || allowed[ 0 ] == "skirmishbt";
    level.modeallowmeleevehicledamage = &modeallowmeleevehicledamage;
    level.var_ac451a7698545a53 = 1;
    level.var_d9d68aeaf1fa45a7 = 1;
    parachute::initparachutedvars();
    
    if ( level.var_dcdc0db91cb047b4 )
    {
        level.var_3d7090888426b83a = namespace_8f31f8198faa9918::initialize();
        level.var_3d7090888426b83a namespace_8f31f8198faa9918::activate();
    }
    
    level thread skirmish_activities::init();
    namespace_ccc9a50b2d185e5::function_2d60a8a96ff40a04();
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
    
    skydive_protection::init();
    level.var_bd070f6dcd0b310e = getdvarint( @"hash_e0a9c1d2e7754999", level.gametypebundle.var_bd070f6dcd0b310e ) == 1;
    
    if ( level.var_bd070f6dcd0b310e )
    {
        level thread skirmish_bounty::init();
    }
    
    level.var_21cde95d1d91bf03 = 1;
    waittillframeend();
    utility::registersharedfunc( #"game", #"showStockLootFeed", undefined );
    level thread skirmish_util::function_812f0dfc302a4016();
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0xe986f84f, Offset: 0xafb
// Size: 0xe4
function private function_f9289ff63dd7b58a()
{
    common::updatecommongametypedvars();
    level.var_f99361513a5fd9f5 = getdvarint( @"hash_7a769a94c3a6033b", level.gametypebundle.var_799be71c7875bfb9 );
    level.var_bf936c274f4a7680 = getdvarint( @"scr_skirmish_supply_drop_disable", level.gametypebundle.supplydropdisable );
    level.var_dcdc0db91cb047b4 = getdvarint( @"hash_e9ed12e5418d3a77", level.gametypebundle.activateanomalies );
    level.var_1794c803a76be877 = getdvarint( @"hash_ac68967326a7eee6", level.gametypebundle.enablewingsuit );
    level.squadsize = getmatchrulesdata( "commonOption", "squadSize" );
    level.var_1552790994371de7 = "icon_medium";
    level.var_f65356c6fd0d4607 = 1;
    function_9e8fedf5e00ccbfb();
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0xf2038969, Offset: 0xbe7
// Size: 0x1fd
function private function_9e8fedf5e00ccbfb()
{
    level.var_45f6a6e0fdf53f22 = getdvarint( @"hash_b0ded14285e2152c", level.gametypebundle.var_45f6a6e0fdf53f22 );
    level.var_67ca8a17f531fb7c = level.gametypebundle.var_a78b06a99c16448d;
    level.var_a0c7e4f01440403c = level.gametypebundle.captureScore;
    level.var_4c4831d3a6e1bae0 = getdvarint( @"hash_50f9d285f86b7916", level.gametypebundle.destroyscore );
    level.var_a1bd02de3891f692 = getdvarint( @"hash_71ec2ba86f35eafe", level.gametypebundle.var_26aee76e43e9a93a );
    level.var_94793072e55acb00 = getdvarint( @"hash_4cfa5d61d4cd7215", level.gametypebundle.var_2a7fa9d57caee6c8 );
    level.var_5e52d5a84546e421 = getdvarint( @"hash_bc7e569b345f2f52", level.gametypebundle.var_ed94b39bce716029 );
    level.var_7459dc7315bee661 = getdvarint( @"hash_2082c88ce053e2f0", level.gametypebundle.var_e40db1cfb47ec6b9 );
    level.var_51328d3d6cd16d3d = getdvarint( @"hash_5013a20f7ffe52f9", level.gametypebundle.var_4e8def2f8cc5a4b );
    level.var_32c152afc08dd0db = getdvarint( @"hash_c0dd1e494f8a6f64", level.gametypebundle.var_f99b4b793c487b19 );
    level.var_296eaddf3f4f7675 = getdvarint( @"hash_3a4646c9d0b29a66", level.gametypebundle.var_278efcf048bb5f23 );
    level.var_ad7564db111429d5 = getdvarint( @"hash_76c91e4258a7dbf2", level.gametypebundle.var_9f9b6dbb7538d427 );
    level.var_9aa66bd5a0a587ad = getdvarint( @"hash_7395869b143a6f22", level.gametypebundle.var_ad39c9a01a8737ff );
}

// Namespace skirmish
// Params 0
// Checksum 0x2a7480c1, Offset: 0xdec
// Size: 0x18
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_war_promode", 0 );
}

// Namespace skirmish
// Params 0
// Checksum 0xbaf6433, Offset: 0xe0c
// Size: 0x1ad
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !game[ "switchedsides" ] )
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
        game_utility_mp::setobjectivetext( entry, &"objectives/war" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/war_hint" );
    }
    
    skirmish_util::function_8809d0eb94bca9ac();
    skirmish_respawn::init();
    initspawns();
    
    if ( level.var_f99361513a5fd9f5 )
    {
        function_3b900311f4d9d488();
    }
    
    if ( !level.var_bf936c274f4a7680 )
    {
        level thread skirmish_supply_drop::init();
    }
    
    function_c68ed12acc019bad();
    var_d7790b9a43a51863 = vehicle_spawn::get_data( "veh_sat_mil_light_heli_mp", 1 );
    
    if ( var_d7790b9a43a51863 )
    {
        var_d7790b9a43a51863.respawndelay = 120;
    }
    
    level thread function_5c0b839ed3ef7071();
    level thread function_5127295b711e749a();
    level thread function_ebcc28e748cc92ed();
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0xbba7479e, Offset: 0xfc1
// Size: 0x7b
function private function_c68ed12acc019bad()
{
    foreach ( teamname in level.teamnamelist )
    {
        setteamplacement( teamname, 1 );
    }
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0xf3f5c05b, Offset: 0x1044
// Size: 0xc9
function private initspawns()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    spawnlogic::function_3a25709674572ad6( #"start", #"start_attackers", spawnkey, spawnlogic::function_61ba521db28762a7(), game[ "attackers" ], 1 );
    spawnlogic::function_3a25709674572ad6( #"start", #"start_defenders", spawnkey, spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ], 1 );
    spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"start_attackers" );
    spawnlogic::function_2e4fbfaa2e5bf603( #"primary", #"start_defenders" );
    spawnlogic::finalizemap();
}

// Namespace skirmish
// Params 1
// Checksum 0x32cd6aac, Offset: 0x1115
// Size: 0x17d
function onplayerdeath( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    
    if ( !( isdefined( attacker ) && isdefined( victim ) ) )
    {
        return;
    }
    
    if ( victim.var_b34a3f453cfe9ffe )
    {
        victim namespace_a0bf8ee672af8086::function_edfaa54bcb41517d( self.var_b34a3f453cfe9ffe );
    }
    
    if ( attacker == victim )
    {
        return;
    }
    
    var_16cae21cdd5c3c65 = level.var_bd070f6dcd0b310e && victim skirmish_bounty::function_45ad351565cca4b6();
    var_edadb65b1dfb90ac = attacker.var_bf516d5ed5a5050d ? var_16cae21cdd5c3c65 ? level.var_7459dc7315bee661 : level.var_94793072e55acb00 : 0;
    var_1e02b180f6dea8c1 = 0;
    
    if ( var_16cae21cdd5c3c65 )
    {
        skirmish_util::function_9bc92b9d0f473f97( level.var_5e52d5a84546e421, "mode_skr_bounty_kill", attacker );
        var_1e02b180f6dea8c1 = 1;
        attacker hud_message::function_78fedf6f526825f4( "skirmish_bounty_elimination", level.gametypebundle.var_e662dd7f27d462eb );
        skirmish_util::function_512ad9c4c66229de( attacker );
    }
    
    if ( var_edadb65b1dfb90ac > 0 )
    {
        skirmish_util::function_9bc92b9d0f473f97( var_edadb65b1dfb90ac, "mode_skr_kill_hvs", attacker );
        var_1e02b180f6dea8c1 = 1;
    }
    
    if ( victim.var_bf516d5ed5a5050d )
    {
        namespace_ccc9a50b2d185e5::function_e6efed248e069b22( victim );
    }
    
    if ( !var_1e02b180f6dea8c1 )
    {
        skirmish_util::function_2c1f06acea1703d6( attacker.team, level.scoremod[ "kill" ], "mode_skr_kill" );
        skirmish_util::function_832b8e2dbca95a6b();
    }
}

// Namespace skirmish
// Params 1, eflags: 0x4
// Checksum 0xd92c865d, Offset: 0x129a
// Size: 0x5f
function private function_e8330199e3be6ed7( hitdata )
{
    attacker = hitdata.attacker;
    victim = hitdata.victim;
    
    if ( victim.skydive_spawnprotection && isplayer( attacker ) )
    {
        waittillframeend();
        attacker playsoundtoplayer( "hit_marker_3d_protected", attacker );
    }
}

// Namespace skirmish
// Params 0
// Checksum 0x4f1051ec, Offset: 0x1301
// Size: 0x7d, Type: bool
function allowclasschoicefunc()
{
    assert( level.gametypebundle.var_a9d5efb23dfeefe, "<dev string:x24>" );
    
    if ( isbot( self ) )
    {
        return true;
    }
    
    if ( !isdefined( self.pers[ "class" ] ) || self.pers[ "class" ] == "" )
    {
        return false;
    }
    
    if ( flags::gameflag( "prematch_started" ) || flags::gameflag( "graceperiod_done" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace skirmish
// Params 1
// Checksum 0x9209973e, Offset: 0x1387
// Size: 0xd5
function onplayerconnect( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    player stats::setextrascore0( player.pers[ "objectives_completed" ] ?? 0, "objectives_completed" );
    player stats::setextrascore1( player.pers[ "top_squad_kills" ] ?? 0, "top_squad_kills" );
    player stats::setextrascore2( player.pers[ "supplies_retrieved" ] ?? 0, "supplies_retrieved" );
    player thread function_45315178290cb21f( player );
    player thread skirmish_respawn::function_56e3a5a3276eb487( player );
    player thread skirmish_respawn::function_7ae5f13d4bc8624d( player );
    player.initialspawn = 1;
    player setclientomnvar( "ui_hud_carried_item_index", 4 );
    player setclientomnvar( "ui_hud_carried_item_count", 0 );
}

// Namespace skirmish
// Params 1
// Checksum 0x5f091ce8, Offset: 0x1464
// Size: 0x13
function onplayerdisconnect( player )
{
    function_3da4d7c702115eea();
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0xe0dfebb0, Offset: 0x147f
// Size: 0xca
function private function_5127295b711e749a()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    wait level.timelimit / 2;
    var_27836a09f9688985 = getteamscore( "allies" ) > getteamscore( "axis" ) ? "allies" : "axis";
    winningteamplayers = teams::getteamdata( var_27836a09f9688985, "players" );
    var_94b89449c066f2e5 = var_27836a09f9688985 == "allies" ? teams::getteamdata( "axis", "players" ) : teams::getteamdata( "allies", "players" );
    dialog::leaderdialogonplayers( #"hash_ea84ff58b0f03907", winningteamplayers );
    dialog::leaderdialogonplayers( #"hash_b9b1760db62a2eff", var_94b89449c066f2e5 );
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0x6479ba6a, Offset: 0x1551
// Size: 0xfa
function private function_ebcc28e748cc92ed()
{
    level endon( #"game_ended" );
    var_27836a09f9688985 = undefined;
    halfscore = level.scorelimit / 2;
    
    while ( !var_27836a09f9688985 )
    {
        alliesscore = getteamscore( "allies" );
        axisscore = getteamscore( "axis" );
        
        if ( alliesscore >= halfscore )
        {
            var_27836a09f9688985 = "allies";
        }
        else if ( axisscore >= halfscore )
        {
            var_27836a09f9688985 = "axis";
        }
        
        wait 1;
    }
    
    alliesplayers = teams::getteamdata( "allies", "players" );
    axisplayers = teams::getteamdata( "axis", "players" );
    dialog::leaderdialogonplayers( #"hash_778047cd6e76af7e", var_27836a09f9688985 == "allies" ? alliesplayers : axisplayers );
    dialog::leaderdialogonplayers( #"hash_15312f5a368de210", var_27836a09f9688985 == "allies" ? axisplayers : alliesplayers );
}

// Namespace skirmish
// Params 0
// Checksum 0xd68c6ba, Offset: 0x1653
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

// Namespace skirmish
// Params 1
// Checksum 0xb1bf5bc2, Offset: 0x16a9
// Size: 0x66
function function_3da4d7c702115eea( player )
{
    var_a9b1e2d2e8ff2e63 = level.teamdata[ "allies" ][ "players" ].size;
    var_925f373ce329353e = level.teamdata[ "axis" ][ "players" ].size;
    setomnvar( "ui_skr_allies_player_count", var_a9b1e2d2e8ff2e63 );
    setomnvar( "ui_skr_axis_player_count", var_925f373ce329353e );
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0x1f5ec52d, Offset: 0x1717
// Size: 0x17
function private function_b046546dbef65f4b()
{
    function_d79bdf4555c40884();
    function_21703af9b6816867();
    function_9a74c8000247c1d8();
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0xd6a5adee, Offset: 0x1736
// Size: 0x124
function private function_9a74c8000247c1d8()
{
    var_5f368964e4f4174e = 2;
    gamelogic_mp::setwaypointiconinfo( "waypoint_locked_secure", var_5f368964e4f4174e, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "ui_icon_waypoint_transmit", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_secure", var_5f368964e4f4174e, "neutral", &"mp_ingame_only/skr_secure_cap", "ui_icon_waypoint_transmit", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_secure_attack", 0, "enemy", &"MP_INGAME_ONLY/OBJ_KILL_CAPS", "ui_icon_waypoint_transmit", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_secure_defend", 0, "friendly", &"mp_ingame_only/obj_protect", "ui_icon_waypoint_transmit", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_locked_secure_hot", var_5f368964e4f4174e, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "ui_icon_waypoint_transmit_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_secure_hot", var_5f368964e4f4174e, "neutral", &"mp_ingame_only/skr_secure_hot_cap", "ui_icon_waypoint_transmit_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_secure_attack_hot", 0, "enemy", &"MP_INGAME_ONLY/OBJ_KILL_CAPS", "ui_icon_waypoint_transmit_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_secure_defend_hot", 0, "friendly", &"mp_ingame_only/obj_protect", "ui_icon_waypoint_transmit_heat", 0, undefined );
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0xe93fc6fd, Offset: 0x1862
// Size: 0x31e
function private function_d79bdf4555c40884()
{
    var_e1a478a31edb8885 = 0;
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_dom", var_e1a478a31edb8885, "neutral", &"mp_ingame_only/skr_siege_caps", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_dom_hot", var_e1a478a31edb8885, "neutral", &"mp_ingame_only/skr_siege_caps_hot", "ui_icon_waypoint_capture_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking", var_e1a478a31edb8885, "friendly", &"mp_ingame_only/skr_sieging_caps", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking_hot", var_e1a478a31edb8885, "friendly", &"mp_ingame_only/skr_sieging_caps_hot", "ui_icon_waypoint_capture_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture", var_e1a478a31edb8885, "enemy", &"mp_ingame_only/skr_siege_caps", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_hot", var_e1a478a31edb8885, "enemy", &"mp_ingame_only/skr_siege_caps_hot", "ui_icon_waypoint_capture_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_hot", var_e1a478a31edb8885, "friendly", &"mp_ingame_only/obj_defend_caps_hot", "ui_icon_waypoint_capture_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defending", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_blocking", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_blocked", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_losing", var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_losing_hot", var_e1a478a31edb8885, "enemy", &"mp_ingame_only/obj_losing_caps_hot", "ui_icon_waypoint_capture_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_captureneutral_hot", var_e1a478a31edb8885, "neutral", &"mp_ingame_only/skr_siege_caps_hot", "ui_icon_waypoint_capture_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_captureneutral", var_e1a478a31edb8885, "neutral", &"mp_ingame_only/skr_siege_caps", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_contested", var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_contested_hot", var_e1a478a31edb8885, "contest", &"mp_ingame_only/obj_contested_caps_hot", "ui_icon_waypoint_capture_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_dom_target", var_e1a478a31edb8885, "neutral", &"mp_ingame_only/skr_siege_caps", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_clearing", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "ui_icon_waypoint_capture", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_reinforcing", var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "ui_icon_waypoint_capture", 0, undefined );
    
    for ( i = 0; i < "abcdefghijklmnopqrstuvwxyz".size ; i++ )
    {
        var_430b2250c968430a = "waypoint_locked_siege_" + "abcdefghijklmnopqrstuvwxyz"[ i ];
        gamelogic_mp::setwaypointiconinfo( var_430b2250c968430a, var_e1a478a31edb8885, "neutral", &"mp_ingame_only/obj_capture_lock_caps", "ui_icon_waypoint_capture", 0 );
    }
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0x91d57e11, Offset: 0x1b88
// Size: 0x1bc
function private function_21703af9b6816867()
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_locked_destroy", 0, "neutral", &"mp_ingame_only/obj_capture_lock_caps", "ui_icon_waypoint_bomb", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_arm", 0, "enemy", &"mp_ingame_only/skr_arm_cap", "ui_icon_waypoint_bomb", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_arming", 0, "enemy", &"mp_ingame_only/skr_arming_cap", "ui_icon_waypoint_bomb", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_defend", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "ui_icon_waypoint_bomb", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_hijack", 0, "enemy", &"mp_ingame_only/skr_hijack_cap", "ui_icon_waypoint_bomb", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_losing", 0, "friendly", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "ui_icon_waypoint_bomb", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_hijacking", 0, "enemy", &"mp_ingame_only/skr_hijacking_cap", "ui_icon_waypoint_bomb", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_arm_hot", 0, "enemy", &"mp_ingame_only/skr_arm_hot_cap", "ui_icon_waypoint_bomb_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_arming_hot", 0, "enemy", &"mp_ingame_only/skr_arming_hot_cap", "ui_icon_waypoint_bomb_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_defend_hot", 0, "friendly", &"mp_ingame_only/obj_defend_caps_hot", "ui_icon_waypoint_bomb_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_hijack_hot", 0, "enemy", &"mp_ingame_only/skr_hijack_hot_cap", "ui_icon_waypoint_bomb_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_losing_hot", 0, "friendly", &"mp_ingame_only/obj_losing_caps_hot", "ui_icon_waypoint_bomb_heat", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_skirmish_bomb_hijacking_hot", 0, "enemy", &"mp_ingame_only/skr_hijacking_hot_cap", "ui_icon_waypoint_bomb_heat", 0, undefined );
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0xd268772, Offset: 0x1d4c
// Size: 0x1a
function private function_3b900311f4d9d488()
{
    function_c6979ff02b9811a0( "allies" );
    function_c6979ff02b9811a0( "axis" );
}

// Namespace skirmish
// Params 1, eflags: 0x4
// Checksum 0x57eb46aa, Offset: 0x1d6e
// Size: 0xac
function private function_c6979ff02b9811a0( team )
{
    objectiveid = objidpoolmanager::requestobjectiveid();
    hqiconposition = function_f191c8d0cb696b23( team );
    objidpoolmanager::update_objective_ownerteam( objectiveid, team );
    objidpoolmanager::update_objective_state( objectiveid, "active" );
    objidpoolmanager::update_objective_icon( objectiveid, "sat_ui_hud_skirmish_headquarter_icon" );
    objidpoolmanager::update_objective_position( objectiveid, hqiconposition );
    objidpoolmanager::update_objective_setbackground( objectiveid, 1 );
    objidpoolmanager::update_objective_setfriendlylabel( objectiveid, &"tacmap_legend/hq_air_spawn" );
    objidpoolmanager::update_objective_setenemylabel( objectiveid, &"tacmap_legend/hq_air_spawn" );
    objidpoolmanager::objective_showdistance( objectiveid, 0 );
    objidpoolmanager::function_586b631e7bbb592a( objectiveid, 1 );
    objective_setpings( objectiveid, 0 );
}

// Namespace skirmish
// Params 1, eflags: 0x4
// Checksum 0xe3970e9e, Offset: 0x1e22
// Size: 0xe2
function private function_f191c8d0cb696b23( team )
{
    spawnpoints = spawnlogic::function_f89ebff0bfb8555( #"start", team );
    
    if ( !spawnpoints || spawnpoints.size == 0 )
    {
        return level.respawndata[ team ].origin;
    }
    
    iconposition = ( 0, 0, 0 );
    
    foreach ( spawnpoint in spawnpoints )
    {
        iconposition += spawnpoint.origin;
    }
    
    return iconposition / spawnpoints.size;
}

// Namespace skirmish
// Params 1
// Checksum 0xf2351472, Offset: 0x1f0d
// Size: 0x3a
function function_cbc4c71019a98d4c( params )
{
    if ( isplayer( self ) && level.var_1794c803a76be877 )
    {
        self.operatorcustomization.suit = "sat_wingsuit_mp";
    }
}

// Namespace skirmish
// Params 1, eflags: 0x4
// Checksum 0xc7064f79, Offset: 0x1f4f
// Size: 0x166
function private function_45315178290cb21f( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    player callback::add( #"hash_1c82c96d0d334fcc", &function_cbc4c71019a98d4c );
    
    while ( isdefined( player ) )
    {
        player waittill( #"skydive_deployparachute" );
        
        if ( player.suit == "sat_wingsuit_mp" )
        {
            player.wingsuitref = player.team == "axis" ? %"c_sat_gear_wingsuit_flaps_03_guild" : %"c_sat_gear_wingsuit_flaps_02_blackops";
            player attach( player.wingsuitref );
            player thread parachute::infilparachutevfx( 1, 0 );
        }
        
        var_7fc83b11ade25e3f = [ "skydive_end", "last_stand_enter", "death_or_disconnect" ];
        
        if ( getdvarint( @"hash_511a0b121e17b192", 1 ) == 1 )
        {
            var_7fc83b11ade25e3f[ var_7fc83b11ade25e3f.size ] = "skydive_touch";
        }
        
        player utility::waittill_any_in_array( var_7fc83b11ade25e3f );
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( player.suit == "sat_wingsuit_mp" )
        {
            if ( isdefined( player.wingsuitref ) )
            {
                player detach( player.wingsuitref );
            }
            
            player setshowcontrail( 0 );
        }
        
        if ( player.inlaststand )
        {
            player skydive_interrupt();
        }
    }
}

// Namespace skirmish
// Params 0, eflags: 0x4
// Checksum 0x4ae03a3f, Offset: 0x20bd
// Size: 0xac
function private function_5c0b839ed3ef7071()
{
    brushmodels = getentarray( "script_brushmodel", #classname );
    
    foreach ( brushmodel in brushmodels )
    {
        if ( brushmodel.script_gameobjectname == "skirmish" )
        {
            brushmodel.override_unresolved_collision = &override_unresolved_collision;
        }
    }
}

// Namespace skirmish
// Params 2, eflags: 0x4
// Checksum 0x27aa219a, Offset: 0x2171
// Size: 0x89
function private override_unresolved_collision( player, ballowsuicide )
{
    /#
        var_798e62c5664f570f = 400;
        var_798e61c5664f54dc = 400;
        var_7525734f0aabb4b9 = "<dev string:x9d>";
        color = ( 1, 1, 1 );
        scale = 1.3;
        duration = 180;
        printtoscreen2d( var_798e62c5664f570f, var_798e61c5664f54dc, var_7525734f0aabb4b9, color, scale, duration );
        println( var_7525734f0aabb4b9 );
    #/
}

// Namespace skirmish
// Params 1, eflags: 0x4
// Checksum 0x71c2a3ee, Offset: 0x2202
// Size: 0xe, Type: bool
function private modeallowmeleevehicledamage( data )
{
    return true;
}

// Namespace skirmish
// Params 1, eflags: 0x4
// Checksum 0xed9c163c, Offset: 0x2219
// Size: 0x13
function private function_2ead6d7add3d72( params )
{
    skirmish_util::function_e415d518bd1916f();
}

