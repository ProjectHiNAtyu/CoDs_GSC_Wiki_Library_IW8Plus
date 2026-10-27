// script_163714830112fb5a  (hash_163714830112fb5a.gscc) (size: 22286 Bytes / 0x570e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5dab511a (1571508506)
// size ...... 22286 (0x570e)
// includes .. 24  (offset: 0x51e6)
// strings ... 60  (offset: 0x52a6)
// dev strs .. 1   (offset: 0x56fe)
// exports ... 53  (offset: 0x371e)
// cseg ...... 0x5d0 + 0x314e (0x371e)
// imports ... 149 (offset: 0x3f66)
// animtree1 . 0   (offset: 0x570e)
// animtree2 . 0   (offset: 0x570e)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_supply_drops;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace namespace_389a4622b15d0224;

// Namespace namespace_389a4622b15d0224
// Params 0, eflags: 0x5
// Checksum 0x680e122a, Offset: 0x5ee
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c45530462a06dead", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_389a4622b15d0224
// Params 0, eflags: 0x4
// Checksum 0xd717858f, Offset: 0x617
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_CONTRACT_OUTLAWS", &activity_type_init );
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0xb25d033b, Offset: 0x632
// Size: 0x115
function activity_type_init()
{
    if ( getdvarint( @"hash_3a254a52687835a7", 0 ) )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_OUTLAWS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_OUTLAWS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_OUTLAWS", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_OUTLAWS", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BR_CONTRACT_OUTLAWS" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_CONTRACT_OUTLAWS" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &player_killed, "BR_CONTRACT_OUTLAWS" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerRespawnedMoment", &player_respawn, "BR_CONTRACT_OUTLAWS" );
    activity_common::function_2dd4f07fa5c3e911( "BRTimerExpired", &timer_expired, "BR_CONTRACT_OUTLAWS" );
    level.var_4c022b3125ee984b = &function_99806e4c34a309bd;
    
    if ( !utility::issharedfuncdefined( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse" ) )
    {
        utility::registersharedfunc( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse", &br_supply_drops::function_4059aab25747f034 );
    }
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x2b1249d8, Offset: 0x74f
// Size: 0x69
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_633b95f115bcc581 = activity_definition_utils::function_4dbc827bb8b7e595( self );
    self.var_3eab3260b0ab724b = &function_3eab3260b0ab724b;
    function_bc041d7a3efbfe87( self.varianttag, self.var_332f929de1894b2b );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace namespace_389a4622b15d0224
// Params 2
// Checksum 0xdcae2985, Offset: 0x7c0
// Size: 0x20a
function function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "wanted_" + variantname + "_teammate_started_contract" ] ) )
    {
        assert( isdefined( game[ "<dev string:x24>" ] ) );
        game[ "dialog" ][ "wanted_" + variantname + "_teammate_started_contract" ] = data.acceptvo;
        game[ "dialog" ][ "wanted_" + variantname + "_player_started_contract" ] = data.var_98ecaf7d638c1682;
        game[ "dialog" ][ "wanted_" + variantname + "_player_killed_target" ] = data.var_1e8aff2b5561a670;
        game[ "dialog" ][ "wanted_" + variantname + "_target_killed" ] = data.var_6834a9002d9d7ec1;
        game[ "dialog" ][ "wanted_" + variantname + "_vip_teammate_died" ] = data.var_aa579fa674c3bf32;
        game[ "dialog" ][ "wanted_" + variantname + "_player_survived" ] = data.var_c9184e3c7136b111;
        game[ "dialog" ][ "wanted_" + variantname + "_vip_teammate_survived" ] = data.var_2ec71940a65ba1a6;
        game[ "dialog" ][ "wanted_" + variantname + "_target_survived" ] = data.var_f12708cd519c17f8;
        game[ "dialog" ][ "wanted_" + variantname + "_team_killed_sheriff" ] = data.var_7fa88711816ae8af;
        game[ "dialog" ][ "wanted_" + variantname + "_target_killed_sheriff" ] = data.var_7de9d39d4c84e969;
        game[ "dialog" ][ "wanted_" + variantname + "_target_hunting_player" ] = data.var_aebb598a652f1175;
        game[ "dialog" ][ "wanted_" + variantname + "_sheriff_target_changed" ] = data.var_af6f6d01ed5f7206;
        game[ "dialog" ][ "wanted_" + variantname + "_enemy_started_contract" ] = data.var_7eaa14885a2e9c3d;
    }
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x51d395b8, Offset: 0x9d2
// Size: 0x36
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread contract_begin();
    
    /#
        level.var_f07a5af7e61f0535 = self.id;
    #/
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xe1707871, Offset: 0xa10
// Size: 0x1f
function activity_ended( activity_succeeded )
{
    self endon( #"instance_destroyed" );
    function_46c3c201fb98e();
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x51a6ab85, Offset: 0xa37
// Size: 0x82
function function_d4acef179eb9f9b2()
{
    self endon( #"instance_destroyed" );
    
    if ( !isdefined( self.cancelled ) )
    {
        if ( isdefined( self.targetteam ) )
        {
            level.var_179b6c3280c0c8f8 = arrayremove( level.var_179b6c3280c0c8f8, teams::getteamdata( self.targetteam, "players" ) );
        }
        
        if ( isdefined( self.targetplayer ) )
        {
            self.targetplayer.var_5cb861c1a2f605e5[ self.team ] = gettime();
        }
    }
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xa632cbe6, Offset: 0xac1
// Size: 0x187
function contract_begin( delayed_feedback = 1 )
{
    if ( !isdefined( self.team ) )
    {
        self.team = self.var_ca369031b554da2f.team;
    }
    
    self.outlaw = self.var_ca369031b554da2f;
    var_2b499286c9d6a3fc = delayed_feedback ? 3 : 0;
    br_activity_util::function_3fbbc67df36be7bb( getdvarint( @"hash_4e1674736d628731", self.var_332f929de1894b2b.contracttime ) + var_2b499286c9d6a3fc );
    
    if ( getdvarint( @"hash_e2f8b5ce48f3dd3f", self.var_332f929de1894b2b.include_sheriff ) )
    {
        function_31d5b6ba96fae0ca();
    }
    else
    {
        br_activity_util::function_4e9e312232df58ab( "outlaws_no_sheriff" );
    }
    
    thread function_b3002bedc7103e36();
    thread function_a8b159ebadb2a9fd( delayed_feedback );
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player callback::add( #"player_spawned", &contract_on_player_spawned );
        player callback::add( #"player_disconnect", &player_on_player_disconnect );
    }
    
    thread function_66e6d748a7c0fd46();
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xd790edf8, Offset: 0xc50
// Size: 0x11f
function function_a8b159ebadb2a9fd( var_ad42df8c420ddd78 )
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( var_ad42df8c420ddd78 )
    {
        wait 3;
    }
    
    function_5cc9503726319b36();
    function_1b13777afc85179d( "outlaws_begin_posse", "outlaws_begin_deputy", #"hash_937e520d727705", undefined, "outlaws_begin_outlaw", "outlaws_begin_sheriff" );
    contract_play_vo( "wanted_" + self.varianttag + "_teammate_started_contract", self.var_332f929de1894b2b.var_11c52046ee17c775, "wanted_" + self.varianttag + "_player_started_contract", self.var_332f929de1894b2b.var_a0f3d5edef809e06, "wanted_" + self.varianttag + "_enemy_started_contract", self.var_332f929de1894b2b.var_bc317c46dd2ed856, "wanted_" + self.varianttag + "_target_hunting_player", self.var_332f929de1894b2b.var_4181c3972b1fbfb2 );
    
    if ( isdefined( self.targetplayer ) )
    {
        function_d0f3e92967f725dd();
    }
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xebbdf4e, Offset: 0xd77
// Size: 0x37
function contract_on_player_spawned( s )
{
    pbgpostfxbundlestart( s.player, %"mp_wz2_manticore_postfx_wildwest" );
    s.player function_bb352b603bc6e70a();
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x13d3bcdf, Offset: 0xdb6
// Size: 0x26
function player_on_player_disconnect( unused )
{
    if ( self.cowboy_hat )
    {
        self.cowboy_hat delete();
    }
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x63b625dc, Offset: 0xde4
// Size: 0x3a0
function function_46c3c201fb98e()
{
    switch ( self.end_result )
    {
        case 0:
            var_e061a7a1235ad21f = "outlaws_failed_outlaw";
            var_a2e1155320ab5c40 = "outlaws_failed_law";
            wanted_score_event = undefined;
            law_score_event = #"hash_72f6e896fdf50051";
            break;
        case 1:
            var_e061a7a1235ad21f = "outlaws_success_timer_outlaw";
            var_a2e1155320ab5c40 = "outlaws_success_timer_law";
            wanted_score_event = #"hash_3e249434af68d12d";
            law_score_event = undefined;
            break;
        case 2:
            var_e061a7a1235ad21f = "outlaws_success_kill_outlaw";
            var_a2e1155320ab5c40 = "outlaws_success_kill_law";
            wanted_score_event = #"hash_7cedd0b47474596f";
            law_score_event = undefined;
            outlaw_score_event = #"hash_a1a81b3f950c6a6b";
            break;
        case 3:
            var_e061a7a1235ad21f = "outlaws_failed_outlaw";
            var_a2e1155320ab5c40 = "outlaws_failed_law";
            wanted_score_event = undefined;
            law_score_event = #"hash_72f6e896fdf50051";
            break;
        default:
            return;
    }
    
    br_contract_manager::deletequestobjicon();
    
    if ( isdefined( self.outlaw ) )
    {
        self.outlaw br::function_ccd86d629929e144();
    }
    
    function_cac093f462002bc3();
    function_e2ce5e6de379388();
    
    if ( isdefined( self.targetplayer ) )
    {
        self.targetplayer br_activity_util::function_9f77cccca136d836();
        self.targetplayer callback::remove( #"player_disconnect", &player_on_player_disconnect );
    }
    
    game_utility::questcircle_delete();
    level callback::callback( "outlaws_complete", { #players:teams::getteamdata( self.team, "players" ) } );
    function_1b13777afc85179d( var_e061a7a1235ad21f, var_a2e1155320ab5c40, wanted_score_event, law_score_event, undefined, undefined, outlaw_score_event );
    
    switch ( self.end_result )
    {
        case 0:
            rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.var_26a71e6050d0db13, self.outlaw_killer, self.outlaw_killer.team );
            break;
        case 1:
            rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.escapedrewardgroup, self.outlaw );
            function_3eab3260b0ab724b( self.var_ca369031b554da2f );
            break;
        case 2:
            rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.var_5d9cb1f605344436, self.outlaw );
            function_3eab3260b0ab724b( self.var_ca369031b554da2f );
            break;
        case 3:
            rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.var_26a71e6050d0db13, self.outlaw_killer, self.outlaw_killer.team );
            function_3eab3260b0ab724b( self.outlaw_killer );
            break;
        default:
            return;
    }
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player callback::remove( #"player_spawned", &contract_on_player_spawned );
        player callback::remove( #"player_disconnect", &player_on_player_disconnect );
    }
}

// Namespace namespace_389a4622b15d0224
// Params 7
// Checksum 0xed6070ff, Offset: 0x118c
// Size: 0x1ea
function function_1b13777afc85179d( wanted_splash, law_splash, wanted_score, law_score, var_342d4da9ba4708f5, var_5a8b5a81d89b156e, outlaw_score_override )
{
    posse = arrayremove( teams::getteamdata( self.team, "players" ), self.outlaw );
    
    if ( isdefined( wanted_splash ) )
    {
        activity_player_broadcasting::function_c2b1e8bad2e95e69( wanted_splash, posse );
    }
    
    if ( isdefined( wanted_score ) )
    {
        points::function_7664124ba4690b6a( posse, wanted_score );
    }
    
    if ( isdefined( wanted_splash ) )
    {
        activity_player_broadcasting::function_c2b1e8bad2e95e69( var_342d4da9ba4708f5 ? var_342d4da9ba4708f5 : wanted_splash, [ self.outlaw ] );
    }
    
    if ( isdefined( wanted_score ) )
    {
        br_contract_manager::giveplayerpoints( self.outlaw, outlaw_score_override ?? wanted_score );
    }
    
    var_538dbfbe5d7a73c6 = [];
    
    foreach ( player in level.players )
    {
        if ( player::isreallyalive( player ) && player.team != self.team )
        {
            var_538dbfbe5d7a73c6[ var_538dbfbe5d7a73c6.size ] = player;
        }
    }
    
    if ( isdefined( var_5a8b5a81d89b156e ) && isdefined( self.targetplayer ) )
    {
        var_538dbfbe5d7a73c6 = arrayremove( var_538dbfbe5d7a73c6, self.targetplayer );
        activity_player_broadcasting::function_c2b1e8bad2e95e69( var_5a8b5a81d89b156e, [ self.targetplayer ] );
        
        if ( isdefined( law_score ) )
        {
            br_contract_manager::giveplayerpoints( self.targetplayer, law_score );
        }
    }
    
    if ( isdefined( law_splash ) )
    {
        activity_player_broadcasting::function_c2b1e8bad2e95e69( law_splash, var_538dbfbe5d7a73c6 );
    }
    
    if ( isdefined( law_score ) )
    {
        points::function_7664124ba4690b6a( var_538dbfbe5d7a73c6, law_score );
    }
}

// Namespace namespace_389a4622b15d0224
// Params 8
// Checksum 0xc5bd16de, Offset: 0x137e
// Size: 0x1af
function contract_play_vo( wanted_vo, var_9217695d7b23bf8a, outlaw_vo, var_751fa39b75c15c55, law_vo, var_f96b7d3a4f1af4b9, sheriff_vo, var_c21a0553866be59a )
{
    posse = arrayremove( teams::getteamdata( self.team, "players" ), self.outlaw );
    
    if ( isdefined( wanted_vo ) )
    {
        level thread br_public::brleaderdialog( wanted_vo, 1, posse, undefined, 2, undefined, var_9217695d7b23bf8a );
    }
    
    if ( isdefined( outlaw_vo ) )
    {
        level thread br_public::brleaderdialogplayer( outlaw_vo, self.outlaw, 1, undefined, 2, undefined, var_751fa39b75c15c55 );
    }
    
    lawplayers = [];
    
    foreach ( player in level.players )
    {
        if ( player::isreallyalive( player ) && player.team != self.team && player != self.targetplayer )
        {
            lawplayers[ lawplayers.size ] = player;
        }
    }
    
    if ( isdefined( law_vo ) )
    {
        level thread br_public::brleaderdialog( law_vo, 1, lawplayers, undefined, 2, undefined, var_f96b7d3a4f1af4b9 );
    }
    
    if ( isdefined( sheriff_vo ) && isdefined( self.targetplayer ) )
    {
        level thread br_public::brleaderdialogplayer( sheriff_vo, self.targetplayer, 1, undefined, 2, undefined, var_c21a0553866be59a );
    }
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x5061a42a, Offset: 0x1535
// Size: 0x101
function function_5cc9503726319b36()
{
    br_contract_manager::createquestobjicon( "ui_mp_br_mapmenu_icon_mp_wz2_manticore_quest_wanted_outlaw", "active", self.outlaw.origin + ( 0, 0, self.var_332f929de1894b2b.icon_offset ) );
    objective_disableping( self.objectiveiconid, 1 );
    
    foreach ( player in level.players )
    {
        if ( player.team != self.team )
        {
            br_contract_manager::showquestobjicontoplayer( player );
            continue;
        }
        
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
    
    thread function_9d593e9a4480a432();
    function_1b03d7ae83b6f99( self.outlaw );
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0xa7a10a6f, Offset: 0x163e
// Size: 0x87
function function_9d593e9a4480a432()
{
    self.outlaw endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        wait self.var_332f929de1894b2b.icon_update_interval;
        br_contract_manager::movequestobjicon( self.outlaw.origin + ( 0, 0, self.var_332f929de1894b2b.icon_offset ) );
    }
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x9274cacf, Offset: 0x16cd
// Size: 0x3d
function function_1b03d7ae83b6f99( player )
{
    playerisinvehicle = player vehicle::is_in_vehicle();
    
    if ( !playerisinvehicle )
    {
        player br::function_f2d49b5c22624ea2( "t10_mc_wanted_fugitive_flag" );
    }
    
    thread function_494f032132a2b71a( player );
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0xaf1c362e, Offset: 0x1712
// Size: 0x91
function function_b3002bedc7103e36()
{
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        if ( player::isreallyalive( player ) )
        {
            player function_bb352b603bc6e70a();
        }
    }
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x8572d66a, Offset: 0x17ab
// Size: 0x6b
function function_bb352b603bc6e70a()
{
    hat = utility::spawn_model( "parts_hat_cowboy_b", undefined, undefined, undefined, 1.15 );
    hat notsolid();
    hat linkto( self, "j_head", ( 5.5, -1.5, 0 ), ( 90, 10, -15 ) );
    hat function_7207895b28c71c79( 1 );
    hat hidefromplayer( self );
    self.cowboy_hat = hat;
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x8f7c6eb1, Offset: 0x181e
// Size: 0xa7
function function_e2ce5e6de379388()
{
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        if ( isdefined( player.cowboy_hat ) )
        {
            player.cowboy_hat delete();
            player.cowboy_hat = undefined;
        }
    }
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x8251c5eb, Offset: 0x18cd
// Size: 0x47
function function_494f032132a2b71a( player )
{
    player endon( #"death_or_disconnect" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level waittill( #"game_ended" );
    player br::function_ccd86d629929e144();
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x91a5a58, Offset: 0x191c
// Size: 0x14c
function function_31d5b6ba96fae0ca()
{
    if ( !isdefined( self.targetteam ) )
    {
        self.targetteam = function_17c0e39dc4a7a649( self.outlaw );
    }
    
    if ( isdefined( self.targetteam ) )
    {
        self.hunterteam = self.team;
        
        if ( !isdefined( self.targetplayer ) )
        {
            self.targetplayer = function_be00a32dd8e82225( self.targetteam, self.outlaw );
        }
        
        if ( isdefined( self.targetplayer ) )
        {
            self.targetplayer br_activity_util::function_e8ab3983ca03f37b( "outlaws_sheriff" );
            self.targetplayer setclientomnvar( "ui_br_objective_duration_time", getdvarint( @"hash_4e1674736d628731", self.var_332f929de1894b2b.contracttime ) * 1000 );
            self.targetplayer setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
            level.var_179b6c3280c0c8f8 = arraycombine( level.var_179b6c3280c0c8f8, teams::getteamdata( self.targetteam, "players" ) );
            thread function_4cfc6964d2ed5cd1();
            self.targetplayer callback::add( #"player_disconnect", &player_on_player_disconnect );
            thread function_86c7abe622d2940d();
        }
        
        return;
    }
    
    br_activity_util::function_4e9e312232df58ab( "outlaws_no_sheriff" );
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xf70313cd, Offset: 0x1a70
// Size: 0x66f
function function_17c0e39dc4a7a649( player )
{
    hunterteam = player.team;
    bestteam = undefined;
    var_ba9a7907c7fae1c0 = 0;
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
        search_bounds += self.var_332f929de1894b2b.searchincrement;
        
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
            if ( function_ddefaed257603dd5( potentialtarget ) )
            {
                excludedteams[ excludedteams.size ] = potentialtarget;
                continue;
            }
            
            if ( !potentialtarget.hasbeentracked && player::isreallyalive( potentialtarget ) && !potentialtarget function_7c7b020074e79414( self ) && !potentialtarget.inlaststand )
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
                    if ( player::isreallyalive( potentialtarget ) )
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
            if ( player::isreallyalive( teammate ) )
            {
                hunterteamsize++;
                var_402384e392946204 += teammate.origin;
            }
        }
        
        var_402384e392946204 /= hunterteamsize;
        
        foreach ( potentialtarget in playerlist )
        {
            var_dbfcc362a6b86751 = 0;
            
            foreach ( teammate in teams::getteamdata( potentialtarget.team, "players" ) )
            {
                if ( player::isreallyalive( teammate ) )
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
                if ( player::isreallyalive( teammate ) )
                {
                    currentteamcenter += teammate.origin;
                }
            }
            
            currentteamcenter /= var_dbfcc362a6b86751;
            var_185575d2f2c4e700 = ( 0, 0, 0 );
            
            foreach ( teammate in teams::getteamdata( bestteam, "players" ) )
            {
                if ( player::isreallyalive( teammate ) )
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

// Namespace namespace_389a4622b15d0224
// Params 2
// Checksum 0x4a868dc7, Offset: 0x20e8
// Size: 0x259
function function_be00a32dd8e82225( sheriff_team, hunter )
{
    bestplunder = undefined;
    var_2d717dee9fceaf51 = undefined;
    targetplayer = undefined;
    var_402384e392946204 = ( 0, 0, 0 );
    hunterteamsize = 0;
    var_358f271df10023ff = 0;
    
    foreach ( teammate in teams::getteamdata( sheriff_team, "players" ) )
    {
        if ( player::isreallyalive( teammate ) )
        {
            var_402384e392946204 += teammate.origin;
            hunterteamsize++;
            
            if ( !teammate function_7c7b020074e79414() )
            {
                var_358f271df10023ff++;
            }
        }
    }
    
    var_402384e392946204 /= hunterteamsize;
    
    foreach ( player in teams::getteamdata( sheriff_team, "players" ) )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( var_358f271df10023ff > 0 && player function_7c7b020074e79414() )
        {
            continue;
        }
        
        if ( !isdefined( targetplayer ) )
        {
            targetplayer = player;
        }
        
        if ( distance2d( var_402384e392946204, player.origin ) < distance2d( var_402384e392946204, targetplayer.origin ) )
        {
            targetplayer = player;
        }
    }
    
    assert( isdefined( targetplayer ) );
    
    foreach ( player in teams::getteamdata( sheriff_team, "players" ) )
    {
        player.hasbeentracked = 1;
    }
    
    return targetplayer;
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0xb97bf73, Offset: 0x234a
// Size: 0x8c
function function_86c7abe622d2940d()
{
    sheriff = self.targetplayer;
    
    if ( player::isreallyalive( sheriff ) )
    {
        hat = utility::spawn_model( "mx_decor_hat_cowboy_01", undefined, undefined, undefined, 1.2 );
        hat notsolid();
        hat linkto( sheriff, "j_head", ( 3.5, -1.5, 0 ), ( 90, 10, -15 ) );
        hat function_7207895b28c71c79( 1 );
        hat hidefromplayer( sheriff );
        sheriff.cowboy_hat = hat;
    }
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x969baac3, Offset: 0x23de
// Size: 0x49
function function_cac093f462002bc3()
{
    sheriff = self.targetplayer;
    
    if ( !isdefined( sheriff ) )
    {
        return;
    }
    
    if ( isdefined( sheriff.cowboy_hat ) )
    {
        sheriff.cowboy_hat delete();
        sheriff.cowboy_hat = undefined;
    }
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x18fbef9f, Offset: 0x242f
// Size: 0xa3
function function_d0f3e92967f725dd()
{
    if ( !game_utility::questcircle_exists() )
    {
        game_utility::questcircle_create( "MTC_Wanted_Br" );
    }
    
    thread sheriff_quest_circle();
    
    foreach ( player in teams::getteamdata( self.hunterteam, "players" ) )
    {
        game_utility::questcircle_showtoplayer( player );
    }
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0xa2431a3e, Offset: 0x24da
// Size: 0x85
function sheriff_quest_circle()
{
    self notify( #"hash_5ab6c76279d1f633" );
    self endon( #"hash_5ab6c76279d1f633" );
    level endon( #"game_ended" );
    self.targetplayer endon( #"death_or_disconnect" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        determinetrackingcircleposition( self.targetplayer );
        determinetrackingcirclesize();
        wait self.var_332f929de1894b2b.var_f3294a70aa4f0b9f;
    }
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xc7d20f1a, Offset: 0x2567
// Size: 0xca
function sheriff_poached( sheriff_killer )
{
    function_cac093f462002bc3();
    contract_play_vo( "wanted_" + self.varianttag + "_sheriff_target_changed", self.var_332f929de1894b2b.var_c20eae2141b05c7a, "wanted_" + self.varianttag + "_sheriff_target_changed", self.var_332f929de1894b2b.var_c20eae2141b05c7a );
    
    if ( isdefined( self.targetplayer ) )
    {
        self.targetplayer br_activity_util::function_9f77cccca136d836();
    }
    else
    {
        function_eefd82c0f43dfefc();
    }
    
    if ( sheriff_killer == self.targetplayer )
    {
        function_eefd82c0f43dfefc();
    }
    else
    {
        self.targetplayer = sheriff_killer;
    }
    
    if ( !isdefined( self.targetplayer ) )
    {
        function_f26bfeb77448286f();
    }
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0xb113cd06, Offset: 0x2639
// Size: 0x71
function function_eefd82c0f43dfefc()
{
    level.var_179b6c3280c0c8f8 = arrayremove( level.var_179b6c3280c0c8f8, teams::getteamdata( self.targetteam, "players" ) );
    self.targetplayer = undefined;
    self.targetteam = undefined;
    function_31d5b6ba96fae0ca();
    
    if ( isdefined( self.targetplayer ) )
    {
        function_1b13777afc85179d( "outlaws_sheriff_change_outlaw", undefined, undefined, undefined, undefined, "outlaws_sheriff_change_sheriff", undefined );
        function_d0f3e92967f725dd();
    }
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x32ea74b9, Offset: 0x26b2
// Size: 0x15
function function_f26bfeb77448286f()
{
    game_utility::questcircle_delete();
    br_activity_util::function_4e9e312232df58ab( "outlaws_no_sheriff" );
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x3d7fdff7, Offset: 0x26cf
// Size: 0x32, Type: bool
function function_7c7b020074e79414( activity )
{
    if ( activity.var_332f929de1894b2b.var_343aa7caf2fec1a3 == 0 )
    {
        return false;
    }
    
    return istrue( self.var_8946ce0ae9eb0955 );
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xf25a323d, Offset: 0x270a
// Size: 0x2d
function function_ddefaed257603dd5( player )
{
    var_657a3abce2509b48 = activity_participation::function_a2ffa98b763c335d( player );
    return var_657a3abce2509b48 activity_participation::function_a63ffe2063075fb4( "Contract" );
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x22008010, Offset: 0x2740
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x361280cb, Offset: 0x2780
// Size: 0x30c
function player_killed( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( victim == self.targetplayer && !activity_participation::function_e7fc1202ac164928( self, attacker ) )
    {
        sheriff_poached( attacker );
        return;
    }
    
    if ( victim == self.outlaw )
    {
        self.outlaw_killer = attacker;
        contract_play_vo( "wanted_" + self.varianttag + "_vip_teammate_died", self.var_332f929de1894b2b.var_13609adf59967596 );
        level thread br_public::brleaderdialogplayer( "wanted_" + self.varianttag + "_player_killed_target", attacker, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_67fa0532ce8469f5 );
        lawplayers = [];
        
        foreach ( player in level.players )
        {
            if ( player::isreallyalive( player ) && player.team != self.team && player != attacker )
            {
                lawplayers[ lawplayers.size ] = player;
            }
        }
        
        level thread br_public::brleaderdialog( "wanted_" + self.varianttag + "_target_killed", 1, lawplayers, undefined, 2, undefined, self.var_332f929de1894b2b.var_bab6b7d899b83cec );
        
        if ( attacker == self.targetplayer )
        {
            self.end_result = 3;
        }
        else
        {
            self.end_result = 0;
        }
        
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    if ( activity_participation::function_e7fc1202ac164928( self, attacker ) )
    {
        if ( victim == self.targetplayer )
        {
            contract_play_vo( "wanted_" + self.varianttag + "_team_killed_sheriff", self.var_332f929de1894b2b.var_66d102a18d2dfe23, "wanted_" + self.varianttag + "_team_killed_sheriff", self.var_332f929de1894b2b.var_66d102a18d2dfe23, "wanted_" + self.varianttag + "_target_killed_sheriff", self.var_332f929de1894b2b.var_6b6432aae5c1085d, "wanted_" + self.varianttag + "_target_killed_sheriff", self.var_332f929de1894b2b.var_6b6432aae5c1085d );
            self.end_result = 2;
            activity_instance_common::endactivity( self, 1 );
            return;
        }
        
        if ( activity_participation::function_e7fc1202ac164928( self, victim ) )
        {
            return;
        }
        
        br_activity_util::function_cf8dc263065eabc9( self.var_332f929de1894b2b.var_913cec740f4d6c99 );
        br_contract_manager::giveplayerpoints( attacker, #"hash_34a489c2dc123f9c" );
    }
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x1942e066, Offset: 0x2a94
// Size: 0x38
function player_respawn( params )
{
    player = params.player;
    
    if ( activity_participation::function_e7fc1202ac164928( self, player ) )
    {
        game_utility::questcircle_showtoplayer( player );
    }
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x4b5b8156, Offset: 0x2ad4
// Size: 0xc8
function timer_expired( params )
{
    contract_play_vo( "wanted_" + self.varianttag + "_vip_teammate_survived", self.var_332f929de1894b2b.var_6bd3a7526e62e61a, "wanted_" + self.varianttag + "_player_survived", self.var_332f929de1894b2b.var_3350dba66a43d65, "wanted_" + self.varianttag + "_target_survived", self.var_332f929de1894b2b.var_1e29d7c16eff5034, "wanted_" + self.varianttag + "_target_survived", self.var_332f929de1894b2b.var_1e29d7c16eff5034 );
    self.end_result = 1;
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xb30fbe60, Offset: 0x2ba4
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

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xaef1b690, Offset: 0x2c4f
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

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x3b008714, Offset: 0x2cfa
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

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xa3d4b915, Offset: 0x2da5
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

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x7a1186a7, Offset: 0x2e51
// Size: 0x15c
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
    
    switch ( var_118a3444f7925a7f )
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

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x93f6d367, Offset: 0x2fb5
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

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x8de35e44, Offset: 0x30b4
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

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xd46861ee, Offset: 0x328a
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

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x3d16df29, Offset: 0x32de
// Size: 0x36
function function_4cfc6964d2ed5cd1()
{
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    self.targetplayer waittill( #"disconnect" );
    function_eefd82c0f43dfefc();
}

// Namespace namespace_389a4622b15d0224
// Params 0
// Checksum 0x1c6dfd2e, Offset: 0x331c
// Size: 0x42
function function_66e6d748a7c0fd46()
{
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    self.outlaw waittill( #"disconnect" );
    self.end_result = 0;
    activity_instance_common::endactivity( self, 0 );
}

// Namespace namespace_389a4622b15d0224
// Params 2
// Checksum 0xa3931e76, Offset: 0x3366
// Size: 0x24c
function function_3eab3260b0ab724b( player, delay )
{
    playerorigin = player.origin;
    playerangles = player.angles;
    playerteam = player.team;
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( player ) )
    {
        playerorigin = player.origin;
        playerangles = player.angles;
        playerteam = player.team;
    }
    
    forward = anglestoforward( playerangles );
    rotationangle = randomfloatrange( 0, 360 );
    offset = rotatepointaroundvector( ( 0, 0, 1 ), forward, rotationangle ) + ( 0, 200, 0 );
    drop_point = isnavmeshloaded() ? getclosestpointonnavmesh( playerorigin + offset ) : playerorigin + offset;
    crate = airdrop::dropcrate( undefined, playerteam, "legendary_supply_drop", drop_point + ( 0, 0, 4096 ), ( 0, randomfloat( 360 ), 0 ), drop_point );
    crate.source = "outlaws_quest";
    crate.skipminimapicon = 1;
    id = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( id > -1 )
    {
        crate setscriptablepartstate( "objective_map", "hidden" );
        fadestart = getdvarint( @"hash_acf74e135c5f10bf", 4921 );
        fadeend = getdvarint( @"hash_fd37bfe2a04152a", 5906 );
        objidpoolmanager::objective_add_objective( id, "current", crate.origin, "ui_map_icon_supply_drop_yellow" );
        objective_addteamtomask( id, playerteam );
        objective_showtoplayersinmask( id );
        objective_setbackground( id, 1 );
        objective_onentity( id, crate );
        objective_setzoffset( id, 75 );
        objective_setdescription( id, &"mp_saw_manticore/wanted_crate_ping" );
        function_ac9886e0e2860e18( id, fadestart, fadeend );
        function_44a344c68a68f28d( id, 1 );
        crate.scriptedobjid = id;
        level.brgametype thread function_225ed237323c6921( crate );
        
        if ( !level.br_circle_disabled )
        {
            crate thread function_47de827e2794534a( drop_point );
        }
    }
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x280b0a20, Offset: 0x35ba
// Size: 0x2f
function function_225ed237323c6921( crate )
{
    level endon( #"game_ended" );
    
    while ( isdefined( crate ) )
    {
        waitframe();
    }
    
    crate notify( #"hash_d949d4d08a186884" );
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0x6e13b3c1, Offset: 0x35f1
// Size: 0x7e
function function_47de827e2794534a( origin )
{
    level endon( #"game_ended" );
    self endon( #"hash_d949d4d08a186884" );
    crate_hit_time = br_circle_util::gettimetilldangerforpoint( origin );
    
    if ( level utility::waittill_notify_or_timeout_return( "br_circle_relocation", crate_hit_time ) == "timeout" )
    {
        if ( isdefined( self.scriptedobjid ) )
        {
            objidpoolmanager::update_objective_state( self.scriptedobjid, "active" );
        }
        
        return;
    }
    
    thread function_47de827e2794534a( origin );
    return;
}

// Namespace namespace_389a4622b15d0224
// Params 1
// Checksum 0xca8ae43b, Offset: 0x3677
// Size: 0xa7
function function_99806e4c34a309bd( player )
{
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_quest_outlaws" );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        var_67aefa490de08177 = var_f67995529827f79.spawnlistname;
        spawncount = var_f67995529827f79.spawncount;
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        common_item::function_38cde6a6acb68ea6( var_67aefa490de08177, spawncount, spawnoptions );
    }
    
    player thread points::doscoreevent( #"br_cacheopen_epic" );
    player playsoundtoplayer( "uin_wz2_loot_container_open_epic", player );
}

