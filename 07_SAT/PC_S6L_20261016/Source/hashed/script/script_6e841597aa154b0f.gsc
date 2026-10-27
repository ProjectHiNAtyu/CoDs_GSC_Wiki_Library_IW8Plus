// script_6e841597aa154b0f  (hash_6e841597aa154b0f.gscc) (size: 10253 Bytes / 0x280d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2b4080ef (725647599)
// size ...... 10253 (0x280d)
// includes .. 19  (offset: 0x24fd)
// strings ... 38  (offset: 0x2595)
// dev strs .. 1   (offset: 0x27fd)
// exports ... 29  (offset: 0x169d)
// cseg ...... 0x30c + 0x1391 (0x169d)
// imports ... 84  (offset: 0x1b25)
// animtree1 . 0   (offset: 0x280d)
// animtree2 . 0   (offset: 0x280d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\laststand;
#using scripts\mp\objidpoolmanager;

#namespace namespace_4aabd2c8a4353c13;

// Namespace namespace_4aabd2c8a4353c13
// Params 0, eflags: 0x5
// Checksum 0x45d97ad9, Offset: 0x32a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_55f0bf23421b5c0", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0, eflags: 0x4
// Checksum 0x996bd156, Offset: 0x353
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_CONTRACT_MOSTWANTED", &activity_type_init );
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0
// Checksum 0x1645856f, Offset: 0x36e
// Size: 0x131
function activity_type_init()
{
    if ( getdvarint( @"scr_br_vip_quest_disable", 0 ) )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_MOSTWANTED", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_MOSTWANTED", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_MOSTWANTED", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_MOSTWANTED", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "BRTimerExpired", &timer_expired, "BR_CONTRACT_MOSTWANTED" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &player_killed, "BR_CONTRACT_MOSTWANTED" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerEnterGulagMoment", &player_entergulag, "BR_CONTRACT_MOSTWANTED" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerRespawnedMoment", &player_respawn, "BR_CONTRACT_MOSTWANTED" );
    activity_common::function_2dd4f07fa5c3e911( "BRCacheOpened", &function_33344aaa21c280f8, "BR_CONTRACT_MOSTWANTED" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BR_CONTRACT_MOSTWANTED" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_CONTRACT_MOSTWANTED" );
    level.var_7b549ecd4f7f2b19 = spawnstruct();
    level.var_7b549ecd4f7f2b19.var_f45c29c0ca894ec8 = 21;
    level.var_7b549ecd4f7f2b19.var_3d60cfe23445889c = 0;
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0
// Checksum 0xd2967f16, Offset: 0x4a7
// Size: 0x4b
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    function_bc041d7a3efbfe87( self.varianttag, self.var_332f929de1894b2b );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace namespace_4aabd2c8a4353c13
// Params 2
// Checksum 0xccd1a6c3, Offset: 0x4fa
// Size: 0x13e
function function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "hvt_" + variantname + "_accept" ] ) )
    {
        assert( isdefined( game[ "<dev string:x24>" ] ) );
        game[ "dialog" ][ "mission_hvt_" + variantname + "_accept" ] = data.acceptvo;
        game[ "dialog" ][ "mission_hvt_" + variantname + "_accept_first_person" ] = data.var_98ecaf7d638c1682;
        game[ "dialog" ][ "mission_hvt_" + variantname + "_success" ] = data.successvo;
        game[ "dialog" ][ "mission_hvt_" + variantname + "_success_first_person" ] = data.var_9a9e1c0046ca975f;
        game[ "dialog" ][ "mission_hvt_" + variantname + "_failure" ] = data.failvo;
        game[ "dialog" ][ "mission_hvt_" + variantname + "_eliminated" ] = data.eliminatedvo;
        game[ "dialog" ][ "mission_hvt_" + variantname + "_attacker" ] = data.attackervo;
    }
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0
// Checksum 0x45818365, Offset: 0x640
// Size: 0x2ee
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_ca369031b554da2f notify( #"mostwanted_activity_started" );
    teammates = arrayremove( teams::getteamdata( self.var_ca369031b554da2f.team, "players" ), self.var_ca369031b554da2f );
    br_activity_util::displaysplashtoplayers( teammates, self.var_332f929de1894b2b.acceptsplash );
    br_activity_util::displayplayersplash( self.var_ca369031b554da2f, self.var_332f929de1894b2b.var_a6968efe62d58b96 );
    br_activity_util::activitylog( self, "showing VIP splash to " + self.var_ca369031b554da2f.name );
    
    foreach ( teammate in teammates )
    {
        br_activity_util::activitylog( self, "showing VIP splash to teammate " + self.var_ca369031b554da2f.name );
    }
    
    var_538dbfbe5d7a73c6 = [];
    
    foreach ( player in level.players )
    {
        if ( !player br_public::isplayeringulag() && player::isreallyalive( player ) && !activity_participation::function_e7fc1202ac164928( self, player ) && distance2d( player.origin, self.var_ca369031b554da2f.origin ) <= self.var_332f929de1894b2b.notify_range )
        {
            var_538dbfbe5d7a73c6[ var_538dbfbe5d7a73c6.size ] = player;
        }
    }
    
    br_activity_util::displaysplashtoplayers( var_538dbfbe5d7a73c6, self.var_332f929de1894b2b.var_33836de9c5fcdda );
    level thread br_public::brleaderdialog( "mission_hvt_" + self.varianttag + "_accept", 1, teammates, undefined, 2, undefined, self.var_332f929de1894b2b.var_11c52046ee17c775, 1 );
    level thread br_public::brleaderdialogplayer( "mission_hvt_" + self.varianttag + "_accept_first_person", self.var_ca369031b554da2f, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_a0f3d5edef809e06, undefined, 1 );
    mostwanted_sequence();
    params = spawnstruct();
    params.distance = 0;
    br_activity_util::startcontract();
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0
// Checksum 0xb2019ada, Offset: 0x936
// Size: 0x31
function activity_ended()
{
    self endon( #"instance_destroyed" );
    activity_succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    mostwanted_ended( activity_succeeded );
    mostwanted_cleanup();
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0
// Checksum 0xfd3ba89e, Offset: 0x96f
// Size: 0xe
function function_d4acef179eb9f9b2()
{
    self endon( #"instance_destroyed" );
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0, eflags: 0x4
// Checksum 0x79311808, Offset: 0x985
// Size: 0x53
function private mostwanted_sequence()
{
    function_90be44e239a3c741();
    
    if ( self.var_332f929de1894b2b.useflag )
    {
        self.var_ca369031b554da2f.var_6b6612d9ed859a59 = 1;
        function_37e7688019b2a3e2( self.var_ca369031b554da2f );
    }
    
    thread function_94b56dec7c1f95bc();
    mostwanted_start_timer();
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0, eflags: 0x4
// Checksum 0x9111baa7, Offset: 0x9e0
// Size: 0x80
function private function_90be44e239a3c741()
{
    icon_offset = self.var_ca369031b554da2f.origin + ( 0, 0, self.var_332f929de1894b2b.icon_offset );
    br_contract_manager::createquestobjicon( "ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active", icon_offset );
    br_activity_util::activitylog( self, "Acquired objective ID: " + self.objectiveiconid );
    objective_disableping( self.objectiveiconid, 1 );
    function_125bf9250878659a();
    thread mostwanted_update_icon();
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0, eflags: 0x4
// Checksum 0xddc8ae30, Offset: 0xa68
// Size: 0x1c
function private mostwanted_start_timer()
{
    br_activity_util::function_3fbbc67df36be7bb( self.var_332f929de1894b2b.contracttime );
}

// Namespace namespace_4aabd2c8a4353c13
// Params 1, eflags: 0x4
// Checksum 0x76ad7ec6, Offset: 0xa8c
// Size: 0x222
function private mostwanted_ended( success )
{
    rewards = undefined;
    
    if ( success && isdefined( self.var_ca369031b554da2f ) )
    {
        level thread br_public::brleaderdialogteamexcludeplayer( "mission_hvt_" + self.varianttag + "_success", self.var_ca369031b554da2f.team, self.var_ca369031b554da2f, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_61dfddd29578c7ba, 1 );
        level thread br_public::brleaderdialogplayer( "mission_hvt_" + self.varianttag + "_success_first_person", self.var_ca369031b554da2f, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_d72a9b1da9f44ef3, undefined, 1 );
        self.endstate = "Win";
        rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.rewardgroup, self.var_ca369031b554da2f );
        self.var_ca369031b554da2f.var_da9e389e6db488d9 = gettime();
        
        foreach ( player in teams::getteamdata( self.var_ca369031b554da2f.team, "players" ) )
        {
            function_9d906095b92f071f( player, self.var_ca369031b554da2f, "vip" );
        }
    }
    else
    {
        if ( !self.endstate )
        {
            self.endstate = "Killed";
        }
        
        level thread br_public::brleaderdialogteam( "mission_hvt_" + self.varianttag + "_failure", self.var_ca369031b554da2f.team, 1, 2, undefined, self.var_332f929de1894b2b.var_3071808d4812f79d, undefined, 1 );
    }
    
    br_activity_util::endcontract( success, rewards, self.endstate );
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0, eflags: 0x4
// Checksum 0x29392d3d, Offset: 0xcb6
// Size: 0xd4
function private mostwanted_cleanup()
{
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
    
    br_contract_manager::deletequestobjicon();
    
    if ( self.var_332f929de1894b2b.useflag && isdefined( self.var_ca369031b554da2f ) )
    {
        self.var_ca369031b554da2f.var_6b6612d9ed859a59 = undefined;
        self.var_ca369031b554da2f br::function_ccd86d629929e144();
    }
}

// Namespace namespace_4aabd2c8a4353c13
// Params 3, eflags: 0x4
// Checksum 0xdbe7ff1e, Offset: 0xd92
// Size: 0x7d
function private function_9d906095b92f071f( player, sponsor, analyticsevent )
{
    if ( player.inlaststand )
    {
        player laststand::exit( "last_stand_revived", player );
        return;
    }
    
    if ( !isalive( player ) && !player br_public::isplayerinorgoingtogulag() )
    {
        player thread br_gulag::playergulagautowin( "vipRespawn", sponsor );
        return;
    }
    
    if ( player br_public::isplayerinorgoingtogulag() )
    {
        player thread br_gulag::playerpulloutofgulagwin( sponsor, analyticsevent );
    }
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0, eflags: 0x4
// Checksum 0x70ed1bf, Offset: 0xe17
// Size: 0x92
function private mostwanted_update_icon()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_ca369031b554da2f endon( #"death_or_disconnect" );
    
    while ( true )
    {
        wait self.var_332f929de1894b2b.icon_update_interval;
        neworigin = self.var_ca369031b554da2f.origin + ( 0, 0, self.var_332f929de1894b2b.icon_offset );
        objidpoolmanager::update_objective_position( self.objectiveiconid, neworigin );
    }
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0, eflags: 0x4
// Checksum 0x9336418c, Offset: 0xeb1
// Size: 0x147
function private function_125bf9250878659a()
{
    foreach ( player in level.players )
    {
        br_contract_manager::showquestobjicontoplayer( player );
    }
    
    players = self.playerparticipants;
    entnum = self.var_ca369031b554da2f getentitynumber();
    br_activity_util::activitylog( self, "set contract widget parameter to " + self.var_ca369031b554da2f.name + "(" + entnum + ")" );
    
    foreach ( player in players )
    {
        player br_activity_util::function_525a0dd5ce55a274( entnum );
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
}

// Namespace namespace_4aabd2c8a4353c13
// Params 1
// Checksum 0xd4fc565f, Offset: 0x1000
// Size: 0x2f
function function_220cf16950d590c7( crate )
{
    level endon( #"game_ended" );
    
    while ( isdefined( crate ) )
    {
        waitframe();
    }
    
    crate notify( #"hash_ead8d675d18c5b92" );
}

// Namespace namespace_4aabd2c8a4353c13
// Params 1
// Checksum 0x6778349, Offset: 0x1037
// Size: 0x7e
function function_65fa856fb85f5bb8( origin )
{
    level endon( #"game_ended" );
    self endon( #"hash_ead8d675d18c5b92" );
    crate_hit_time = br_circle_util::gettimetilldangerforpoint( origin );
    
    if ( level utility::waittill_notify_or_timeout_return( "br_circle_relocation", crate_hit_time ) == "timeout" )
    {
        if ( isdefined( self.scriptedobjid ) )
        {
            objidpoolmanager::update_objective_state( self.scriptedobjid, "active" );
        }
        
        return;
    }
    
    thread function_65fa856fb85f5bb8( origin );
    return;
}

// Namespace namespace_4aabd2c8a4353c13
// Params 1
// Checksum 0x3793cfd5, Offset: 0x10bd
// Size: 0x16
function timer_expired( params )
{
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_4aabd2c8a4353c13
// Params 1
// Checksum 0xbe4d9924, Offset: 0x10db
// Size: 0x27c
function player_killed( params )
{
    victim = params.victim;
    attacker = params.attacker;
    player = params.player;
    
    if ( victim == self.var_ca369031b554da2f )
    {
        victim.var_48c4bed69647eb4d = 1;
        
        if ( isdefined( attacker ) )
        {
            if ( self.team == attacker.team )
            {
                self.endstate = "Suicide";
                activity_instance_common::endactivity( self, 0 );
                return;
            }
            
            rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.var_715436d002ba2a83, attacker, attacker.team, self );
            
            if ( self.var_332f929de1894b2b.var_11ec4c3df5eb652c.var_e86b89671e4fd9a7 )
            {
                var_40b965a332bf5634 = br_activity_util::function_396e4d818e829921( attacker );
                var_13624218cd8b0cb6 = ( 0, 0, 0 );
                info = spawnstruct();
                info.origin = var_40b965a332bf5634;
                info.angles = var_13624218cd8b0cb6;
                info.activity = self;
                info.crateinfo = self.var_332f929de1894b2b.var_11ec4c3df5eb652c;
                br_activity_util::function_68426c67d3320967( attacker, info );
            }
            
            splashoverridden = level callback::response( 0, #"hash_eff572fcb538519d", { #rewards:rewards, #player:params.attacker } );
            
            if ( !splashoverridden && isdefined( rewards[ "plunder" ] ) )
            {
                var_f66479ce4f72eae6 = teams::getteamdata( attacker.team, "players" );
                br_activity_util::displaysplashtoplayers( var_f66479ce4f72eae6, self.var_332f929de1894b2b.var_b3f07782025c19ba );
            }
        }
        
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    if ( activity_participation::function_e7fc1202ac164928( self, attacker ) && attacker != victim )
    {
        scoreeventname = #"hash_b39bbfef37b546c7";
        
        if ( self.var_332f929de1894b2b.var_913cec740f4d6c99 == 15 )
        {
            scoreeventname = #"hash_e31c48bd25d692aa";
        }
        
        attacker thread points::doscoreevent( scoreeventname );
        br_activity_util::function_cf8dc263065eabc9( self.var_332f929de1894b2b.var_913cec740f4d6c99 );
    }
}

// Namespace namespace_4aabd2c8a4353c13
// Params 1
// Checksum 0x58b655b6, Offset: 0x135f
// Size: 0x39
function player_entergulag( params )
{
    player = params.player;
    
    if ( !activity_participation::function_e7fc1202ac164928( self, player ) )
    {
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
}

// Namespace namespace_4aabd2c8a4353c13
// Params 1
// Checksum 0xfe8bf4c2, Offset: 0x13a0
// Size: 0x52
function player_respawn( params )
{
    player = params.player;
    
    if ( !activity_participation::function_e7fc1202ac164928( self, player ) )
    {
        br_contract_manager::showquestobjicontoplayer( player );
        return;
    }
    
    player br_activity_util::function_525a0dd5ce55a274( self.var_ca369031b554da2f getentitynumber() );
}

// Namespace namespace_4aabd2c8a4353c13
// Params 1
// Checksum 0x1818b7db, Offset: 0x13fa
// Size: 0x6c
function function_33344aaa21c280f8( params )
{
    player = params.player;
    cache = params.cache;
    
    if ( !isdefined( cache ) )
    {
        return;
    }
    
    player points::doscoreevent( #"hash_397015fa876e62b2" );
    br_activity_util::function_cf8dc263065eabc9( self.var_332f929de1894b2b.var_339d4bdbe7825ec5 );
}

// Namespace namespace_4aabd2c8a4353c13
// Params 1
// Checksum 0xe7f43162, Offset: 0x146e
// Size: 0xbb
function player_joined_activity( params )
{
    player_list = params.playerlist;
    var_99e714060e093089 = params.playerjoinreason;
    
    foreach ( player in player_list )
    {
        br_activity_util::activitylog( self, player.name + " joined activity for reason: " + var_99e714060e093089 );
    }
}

// Namespace namespace_4aabd2c8a4353c13
// Params 1
// Checksum 0x77d8ba0a, Offset: 0x1531
// Size: 0x3b
function function_37e7688019b2a3e2( player )
{
    playerisinvehicle = vehicle::is_in_vehicle();
    
    if ( !playerisinvehicle )
    {
        player br::function_f2d49b5c22624ea2( "prop_zc_game_flag" );
    }
    
    thread function_c0dc082640f52ccd( player );
}

// Namespace namespace_4aabd2c8a4353c13
// Params 2
// Checksum 0x27c976ed, Offset: 0x1574
// Size: 0x8a
function function_7888f8d0ae40c640( playerisinvehicle, player )
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( !playerisinvehicle )
        {
            player waittill( #"vehicle_enter" );
            player br::function_ccd86d629929e144();
        }
        
        player waittill( #"vehicle_exit" );
        playerisinvehicle = 0;
        player br::function_f2d49b5c22624ea2( "prop_zc_game_flag" );
    }
}

// Namespace namespace_4aabd2c8a4353c13
// Params 1
// Checksum 0x70f461db, Offset: 0x1606
// Size: 0x47
function function_c0dc082640f52ccd( player )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    player endon( #"death_or_disconnect" );
    level waittill( #"game_ended" );
    player br::function_ccd86d629929e144();
}

// Namespace namespace_4aabd2c8a4353c13
// Params 0
// Checksum 0xbd15530e, Offset: 0x1655
// Size: 0x48
function function_94b56dec7c1f95bc()
{
    activity = self;
    activity endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    activity.var_ca369031b554da2f waittill( #"disconnect" );
    activity_instance_common::endactivity( self, 0 );
}

