// script_3e24b5d1cc84b043  (hash_3e24b5d1cc84b043.gscc) (size: 9393 Bytes / 0x24b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb9792751 (3111724881)
// size ...... 9393 (0x24b1)
// includes .. 12  (offset: 0x221d)
// strings ... 31  (offset: 0x227d)
// dev strs .. 3   (offset: 0x248d)
// exports ... 24  (offset: 0x154d)
// cseg ...... 0x28a + 0x12c3 (0x154d)
// imports ... 78  (offset: 0x190d)
// animtree1 . 0   (offset: 0x24b1)
// animtree2 . 0   (offset: 0x24b1)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_scavenger_quest;
#using scripts\mp\loot\common_cache;

#namespace namespace_bb4df4c71dc18989;

// Namespace namespace_bb4df4c71dc18989
// Params 0, eflags: 0x5
// Checksum 0x1f5bcd15, Offset: 0x2a8
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"hash_7ea368be11665718", [ #"br_activity_manager", #"activity_common" ], &function_538033a540e63c70, undefined );
}

// Namespace namespace_bb4df4c71dc18989
// Params 0, eflags: 0x4
// Checksum 0xfcbfa1d9, Offset: 0x2e3
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_CONTRACT_SCAVENGER", &activity_type_init );
}

// Namespace namespace_bb4df4c71dc18989
// Params 0
// Checksum 0x169f50a0, Offset: 0x2fe
// Size: 0x118
function activity_type_init()
{
    if ( getdvarint( @"scr_br_scavenger_quest_disable", 0 ) )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_SCAVENGER", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_SCAVENGER", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_SCAVENGER", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_SCAVENGER", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BR_CONTRACT_SCAVENGER" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_CONTRACT_SCAVENGER" );
    activity_common::function_2dd4f07fa5c3e911( "BRTimerExpired", &timer_expired, "BR_CONTRACT_SCAVENGER" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &scavenger_player_killed, "BR_CONTRACT_SCAVENGER" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerEnterGulagMoment", &function_4d150c2d49c299f5, "BR_CONTRACT_SCAVENGER" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerRespawnedMoment", &scavenger_player_respawn, "BR_CONTRACT_SCAVENGER" );
    activity_common::function_2dd4f07fa5c3e911( "BRCircleTick", &function_3e863740a88dd75d, "BR_CONTRACT_SCAVENGER" );
    
    if ( level.var_e4594d201dbdb749.size > 0 )
    {
        br_scavenger_quest::function_d61b29ded0232e9c( level.var_e4594d201dbdb749 );
    }
}

// Namespace namespace_bb4df4c71dc18989
// Params 2
// Checksum 0xa1b194d1, Offset: 0x41e
// Size: 0x10c
function function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "scavenger_" + variantname + "_missionstart" ] ) )
    {
        game[ "dialog" ][ "scavenger_" + variantname + "_missionstart" ] = data.startvo;
        game[ "dialog" ][ "scavenger_" + variantname + "_onesecured" ] = data.onesecuredvo;
        game[ "dialog" ][ "scavenger_" + variantname + "_twosecured" ] = data.twosecuredvo;
        game[ "dialog" ][ "scavenger_" + variantname + "_missioncomplete" ] = data.missioncompletevo;
        game[ "dialog" ][ "scavenger_" + variantname + "_timeout" ] = data.timeoutvo;
        game[ "dialog" ][ "scavenger_" + variantname + "_circle_fail" ] = data.var_7996b2d5b768cfd1;
    }
}

// Namespace namespace_bb4df4c71dc18989
// Params 0
// Checksum 0xf2e72ca8, Offset: 0x532
// Size: 0x6d
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    function_bc041d7a3efbfe87( self.varianttag, self.var_332f929de1894b2b );
    var_23bb53db4c5cf9c5 = function_b9dbee94704376a1();
    
    if ( var_23bb53db4c5cf9c5 )
    {
        activity_instance_common::function_46135a69bddfec2c( self );
        return;
    }
    
    activity_instance_common::function_9aeeabe50fc9cc3e( self );
}

// Namespace namespace_bb4df4c71dc18989
// Params 0
// Checksum 0xaf29ed8, Offset: 0x5a7
// Size: 0xbd
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.collected = 0;
    br_activity_util::function_3fbbc67df36be7bb( self.var_332f929de1894b2b.contracttime );
    br_activity_util::function_951f899c3ca23364( 0 );
    level thread br_public::brleaderdialogteam( "scavenger_" + self.varianttag + "_missionstart", self.team, 1, 1, undefined, self.var_332f929de1894b2b.var_5486d2d12b5e3459, undefined, 1 );
    function_ff06c9e4c3f27546( 0 );
    params = spawnstruct();
    params.distance = self.totaldistance;
    br_activity_util::startcontract( params );
}

// Namespace namespace_bb4df4c71dc18989
// Params 0
// Checksum 0x68c39a63, Offset: 0x66c
// Size: 0x31
function activity_ended()
{
    self endon( #"instance_destroyed" );
    succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    scavenger_ended( succeeded );
    scavenger_cleanup();
}

// Namespace namespace_bb4df4c71dc18989
// Params 0
// Checksum 0x25ca36c0, Offset: 0x6a5
// Size: 0xa4
function function_d4acef179eb9f9b2()
{
    activity = self;
    activity endon( #"instance_destroyed" );
    
    foreach ( cache in activity.cachedata )
    {
        if ( isdefined( cache.objectiveiconid ) )
        {
            cache br_contract_manager::deletequestobjicon();
        }
    }
}

// Namespace namespace_bb4df4c71dc18989
// Params 1
// Checksum 0x13e3b95b, Offset: 0x751
// Size: 0x47
function scavenger_ended( succeeded )
{
    rewards = undefined;
    
    if ( succeeded )
    {
        self.endstate = "Win";
        rewards = scavenger_rewards();
    }
    
    br_activity_util::endcontract( succeeded, rewards, self.endstate );
}

// Namespace namespace_bb4df4c71dc18989
// Params 0
// Checksum 0xd5535d6e, Offset: 0x7a0
// Size: 0x56
function scavenger_rewards()
{
    node = self.cachedata[ self.cachedata.size - 1 ].cachenode;
    rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.rewardgroup, node );
    return rewards;
}

// Namespace namespace_bb4df4c71dc18989
// Params 0
// Checksum 0x82ea5156, Offset: 0x7ff
// Size: 0xf9
function scavenger_cleanup()
{
    foreach ( cache in self.cachedata )
    {
        if ( !cache.collected && isdefined( cache.cacheentity ) )
        {
            cache.cacheentity function_7653c765b6c7b815();
            
            if ( self.var_332f929de1894b2b.var_49641b3ede16b76e > 0 )
            {
                cache.cacheentity utility::delaycallendon( self.var_332f929de1894b2b.var_49641b3ede16b76e, "death", &delete );
                continue;
            }
            
            cache.cacheentity delete();
        }
    }
}

// Namespace namespace_bb4df4c71dc18989
// Params 1
// Checksum 0xe4ab96ea, Offset: 0x900
// Size: 0x43
function scavenger_player_killed( params )
{
    if ( activity_participation::function_e7fc1202ac164928( self, params.victim ) )
    {
        if ( !br_activity_util::function_79f1eba39959ffed( self ) )
        {
            self.endstate = "Killed";
            activity_instance_common::endactivity( self, 0 );
        }
    }
}

// Namespace namespace_bb4df4c71dc18989
// Params 1
// Checksum 0xde1fa321, Offset: 0x94b
// Size: 0xb6
function function_4d150c2d49c299f5( params )
{
    player = params.player;
    
    if ( activity_participation::function_e7fc1202ac164928( self, player ) )
    {
        foreach ( cacheobj in self.cachedata )
        {
            if ( isdefined( cacheobj.objectiveiconid ) )
            {
                cacheobj br_contract_manager::hidequestobjiconfromplayer( player );
            }
        }
    }
}

// Namespace namespace_bb4df4c71dc18989
// Params 1
// Checksum 0xdf933411, Offset: 0xa09
// Size: 0xb6
function scavenger_player_respawn( params )
{
    player = params.player;
    
    if ( activity_participation::function_e7fc1202ac164928( self, player ) )
    {
        foreach ( cacheobj in self.cachedata )
        {
            if ( isdefined( cacheobj.objectiveiconid ) )
            {
                cacheobj br_contract_manager::showquestobjicontoplayer( player );
            }
        }
    }
}

// Namespace namespace_bb4df4c71dc18989
// Params 1
// Checksum 0x56adf631, Offset: 0xac7
// Size: 0x19d
function function_3e863740a88dd75d( params )
{
    if ( self.var_b6c5eeeebd9383f5 )
    {
        return;
    }
    
    foreach ( cache in self.cachedata )
    {
        if ( !cache.collected && isdefined( cache.cacheentity ) )
        {
            if ( !br_circle_util::ispointindangercircle( cache.cacheentity.origin, level.var_ea96217a33eb6457 ) )
            {
                if ( !isdefined( cache.cacheentity.var_145290aab5fc9cca ) )
                {
                    cache.cacheentity.var_145290aab5fc9cca = gettime() + utility::function_4b74c15943231980( self.var_332f929de1894b2b.var_7534fb724afd7b91 );
                }
                
                if ( gettime() >= cache.cacheentity.var_145290aab5fc9cca )
                {
                    level thread br_public::brleaderdialogteam( "scavenger_" + self.varianttag + "_circle_fail", self.team, 1, 1, undefined, self.var_332f929de1894b2b.var_bddea2f4a049fb25, undefined, 1 );
                    self.var_b6c5eeeebd9383f5 = 1;
                    self.endstate = "Circle";
                    activity_instance_common::endactivity( self, 0 );
                    return;
                }
            }
        }
    }
}

// Namespace namespace_bb4df4c71dc18989
// Params 1
// Checksum 0xab17abdd, Offset: 0xc6c
// Size: 0x23
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace namespace_bb4df4c71dc18989
// Params 1
// Checksum 0xe48e1fe9, Offset: 0xc97
// Size: 0x87
function timer_expired( relevant_info_struct )
{
    activity = self;
    player_list = relevant_info_struct.playerlist;
    level thread br_public::brleaderdialogteam( "scavenger_" + self.varianttag + "_timeout", self.team, 1, 1, undefined, self.var_332f929de1894b2b.var_2b503cef95d417ea, undefined, 1 );
    self.endstate = "Time";
    activity_instance_common::endactivity( activity, 0 );
}

// Namespace namespace_bb4df4c71dc18989
// Params 0
// Checksum 0x50b0af0c, Offset: 0xd26
// Size: 0x168, Type: bool
function function_b9dbee94704376a1()
{
    if ( !isdefined( self.cachedata ) )
    {
        self.cachedata = [];
    }
    
    if ( !isdefined( self.cachescollected ) )
    {
        self.cachescollected = 0;
    }
    
    bestcaches = function_4a6cfc43287c4d0e();
    
    if ( !isdefined( bestcaches ) )
    {
        return false;
    }
    
    self.totaldistance = distance2d( self.var_441d26d05f86b224, bestcaches[ 0 ].origin );
    
    for ( i = 0; i < self.var_332f929de1894b2b.cachespawncount ; i++ )
    {
        self.cachedata[ i ] = spawnstruct();
        self.cachedata[ i ].cachenode = bestcaches[ i ];
        self.cachedata[ i ].collected = 0;
        
        if ( !isdefined( self.cachedata[ i ].cachenode ) )
        {
            self.cachedata = undefined;
            return false;
        }
        
        if ( bestcaches[ i + 1 ] )
        {
            self.totaldistance += distance2d( bestcaches[ i ].origin, bestcaches[ i + 1 ].origin );
        }
        
        disablelootspawnpoint( self.cachedata[ i ].cachenode.index );
    }
    
    return true;
}

// Namespace namespace_bb4df4c71dc18989
// Params 0
// Checksum 0x34c2efec, Offset: 0xe97
// Size: 0x85
function function_4a6cfc43287c4d0e()
{
    searchorigin = self.var_1103806baee402d5;
    locations = getunusedlootcachepoints( searchorigin, self.var_332f929de1894b2b.var_969fe1df0f49bfbb, self.var_332f929de1894b2b.var_aad0bb484dd85e49, 1 );
    
    if ( !isdefined( locations ) || locations.size < self.var_332f929de1894b2b.cachespawncount )
    {
        return;
    }
    
    return br_scavenger_quest::function_4877939499134596( searchorigin, self.var_332f929de1894b2b, locations );
}

// Namespace namespace_bb4df4c71dc18989
// Params 1
// Checksum 0x5b15492, Offset: 0xf25
// Size: 0xc6
function function_ff06c9e4c3f27546( cacheindex )
{
    activity = self;
    cachedata = activity.cachedata[ cacheindex ];
    cachenode = cachedata.cachenode;
    cachedata.cacheentity = activity spawnscavengerlootcache( cachenode.origin, cachenode.angles );
    cachedata br_contract_manager::createquestobjicon( "ui_mp_br_mapmenu_icon_scavengerhunt_objective", "current", undefined, self );
    objectiveid = cachedata.objectiveiconid;
    objective_removeallfrommask( objectiveid );
    objective_onentity( objectiveid, cachedata.cacheentity );
    objective_setzoffset( objectiveid, 65 );
    activity br_activity_util::function_87a015bf03f9d1f6( objectiveid );
}

// Namespace namespace_bb4df4c71dc18989
// Params 2
// Checksum 0x6cdea9fe, Offset: 0xff3
// Size: 0x7d
function spawnscavengerlootcache( inorigin, inangles )
{
    cacheentity = spawn( "script_model", inorigin );
    cacheentity.angles = inangles;
    cacheentity setmodel( "military_loot_crate_01_br_scavenger_01" );
    cacheentity setscriptablepartstate( "body", "scavenger_closed" );
    cacheentity common_cache::function_e35d5e97bd22367( &scavengerlootcacheused );
    cacheentity.activity = self;
    thread function_4db08f00bd40d49b( cacheentity );
    return cacheentity;
}

// Namespace namespace_bb4df4c71dc18989
// Params 1
// Checksum 0x672e05a0, Offset: 0x1079
// Size: 0x115
function function_4db08f00bd40d49b( cacheentity )
{
    activity = self;
    activity endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    cacheentity endon( #"death" );
    cacheentity function_7653c765b6c7b815();
    
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
            
            cacheentity enablescriptableplayeruse( player );
        }
        
        assert( isdefined( var_88b519152b97f56a ), "<dev string:x2b>" );
        
        if ( !var_88b519152b97f56a )
        {
            break;
        }
        
        cacheentity setotherent( var_88b519152b97f56a );
        var_88b519152b97f56a waittill( #"disconnect" );
    }
}

// Namespace namespace_bb4df4c71dc18989
// Params 6
// Checksum 0x7c78e07d, Offset: 0x1196
// Size: 0x3b7
function scavengerlootcacheused( instance, part, state, player, bautouse, usestring )
{
    var_ef091d37dff54373 = instance;
    cacheentity = var_ef091d37dff54373.entity;
    
    if ( state == "scavenger_closed" && isdefined( cacheentity ) )
    {
        activity = cacheentity.activity;
        assert( isdefined( activity ), "<dev string:x5f>" );
        var_ef091d37dff54373 setscriptablepartstate( "body", "scavenger_opening" );
        activity.collected++;
        
        if ( activity.collected == 1 )
        {
            cachename = "br_quest_scav_one";
        }
        else if ( activity.collected == 2 )
        {
            cachename = "br_quest_scav_two";
        }
        else
        {
            cachename = "br_quest_scav_three";
        }
        
        spawnliststruct = common_cache::function_73fc13f2febd3a2( cachename );
        
        if ( isdefined( spawnliststruct.spawnlistname ) && isdefined( spawnliststruct.spawncount ) )
        {
            common_cache::fillcontentsfromlist( var_ef091d37dff54373, spawnliststruct.spawnlistname, spawnliststruct.spawncount );
        }
        
        common_cache::opencache( var_ef091d37dff54373, player, undefined, 1 );
        cachedata = undefined;
        
        foreach ( cacheobj in activity.cachedata )
        {
            if ( cacheobj.cacheentity == instance.entity )
            {
                cachedata = cacheobj;
            }
        }
        
        if ( isdefined( cachedata ) )
        {
            cachedata.collected = 1;
            cachedata br_contract_manager::deletequestobjicon();
            cachedata.objectiveiconid = undefined;
        }
        
        activity br_activity_util::function_951f899c3ca23364( activity.collected );
        
        if ( activity.collected < activity.var_332f929de1894b2b.cachespawncount )
        {
            if ( activity.collected == 1 )
            {
                level thread br_public::brleaderdialogteam( "scavenger_" + activity.varianttag + "_onesecured", activity.team, 1, 1, undefined, activity.var_332f929de1894b2b.var_c0d671bf31af347e, undefined, 1 );
            }
            else if ( activity.collected == 2 )
            {
                level thread br_public::brleaderdialogteam( "scavenger_" + activity.varianttag + "_twosecured", activity.team, 1, 1, undefined, activity.var_332f929de1894b2b.var_d5db524aecc11074, undefined, 1 );
            }
            
            if ( activity.var_332f929de1894b2b.timebonus > 0 )
            {
                activity br_activity_util::function_3a67c27d33cb206c( activity.var_332f929de1894b2b.timebonus );
            }
            
            activity function_ff06c9e4c3f27546( activity.collected );
        }
        else
        {
            level thread br_public::brleaderdialogteam( "scavenger_" + activity.varianttag + "_missioncomplete", activity.team, 1, 1, undefined, activity.var_332f929de1894b2b.var_601fcc20770ed644, undefined, 1 );
            activity_instance_common::endactivity( activity, 1 );
        }
        
        cacheentity utility::delaycallendon( 5, "death", &delete );
    }
}

