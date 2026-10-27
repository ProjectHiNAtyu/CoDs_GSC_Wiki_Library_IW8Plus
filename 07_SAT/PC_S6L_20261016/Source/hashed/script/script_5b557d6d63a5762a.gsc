// script_5b557d6d63a5762a  (hash_5b557d6d63a5762a.gscc) (size: 5099 Bytes / 0x13eb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9eff539 (2851075385)
// size ...... 5099 (0x13eb)
// includes .. 12  (offset: 0x12cf)
// strings ... 13  (offset: 0x132f)
// dev strs .. 1   (offset: 0x13df)
// exports ... 9   (offset: 0xbfb)
// cseg ...... 0x147 + 0xab4 (0xbfb)
// imports ... 47  (offset: 0xd63)
// animtree1 . 0   (offset: 0x13eb)
// animtree2 . 0   (offset: 0x13eb)
#using script_3953cae29477fdd4;
#using script_6e841597aa154b0f;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_assassination_quest;
#using scripts\mp\br\gametypes\br_supply_drops;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\flags;
#using scripts\mp\objidpoolmanager;

#namespace activity_hop_vehicle_bounty;

// Namespace activity_hop_vehicle_bounty
// Params 0
// Checksum 0xe46869ca, Offset: 0x165
// Size: 0x1dd
function init()
{
    level endon( #"game_ended" );
    hopbundle = level.brgametype.hop_bundle;
    
    if ( !hopbundle.hop_vehicle_bounty_enabled )
    {
        return;
    }
    
    level.var_32736e4d8d0785dc = { #var_87449c973343263:-999999, #activitydefname:hopbundle.var_f2c27f31f3820b34 ?? "wz_sat_activity_bongo_hp_bounty", #var_315868abc72ccc5:getdvarint( @"hash_4e1727d19f7ccb53", hopbundle.var_45c22b85a36b49a3 ?? 6 ), #var_83aca0bdea0bb510:getdvarint( @"hash_70b993b49f0e465d", hopbundle.var_62ab43dd367b3f1f ?? 60000 ), #var_57f75b9cfb98a18:getdvarint( @"hash_5805ca1a3bb298d3", hopbundle.var_d39efda2c5f32e39 ?? 15000 ), #var_d29bbda53546ae08:getdvarint( @"hash_942ea2a028f6d0e0", hopbundle.hop_vehicle_bounty_global_cooldown ?? 6000 ), #var_cc0e4315eede2fec:[] };
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    if ( !isdefined( level.activities.definitions[ "hop_vehicle_bounty" ] ) )
    {
        activity_definition_utils::function_74af1ab4059e3c06( level.var_32736e4d8d0785dc.activitydefname, "hop_vehicle_bounty" );
    }
    
    var_2886a12087a3a649 = getscriptbundle( hashcat( %"activitydefinition:", level.var_32736e4d8d0785dc.activitydefname ) );
    level.var_32736e4d8d0785dc.var_254d4c01c9580d1d = activity_definition_utils::function_9129cd8075c85c09( var_2886a12087a3a649 );
    utility::registersharedfunc( #"player", #"vehiclebounty", &function_25cba91b53f3426d );
    level.var_32736e4d8d0785dc.enabled = 1;
}

// Namespace activity_hop_vehicle_bounty
// Params 0
// Checksum 0x8df3786b, Offset: 0x34a
// Size: 0x19a
function function_25cba91b53f3426d()
{
    if ( !level.var_32736e4d8d0785dc.enabled )
    {
        return;
    }
    
    player = self;
    bounty = level.var_32736e4d8d0785dc;
    bounty.var_d29bbda53546ae08 = getdvarint( @"hash_942ea2a028f6d0e0", bounty.var_d29bbda53546ae08 );
    bounty.var_57f75b9cfb98a18 = getdvarint( @"hash_5805ca1a3bb298d3", bounty.var_57f75b9cfb98a18 );
    bounty.var_83aca0bdea0bb510 = getdvarint( @"hash_70b993b49f0e465d", bounty.var_83aca0bdea0bb510 );
    bounty.var_315868abc72ccc5 = getdvarint( @"hash_4e1727d19f7ccb53", bounty.var_315868abc72ccc5 );
    currenttime = gettime();
    var_49337f1e68f3fe4f = currenttime - bounty.var_87449c973343263;
    
    if ( var_49337f1e68f3fe4f < bounty.var_d29bbda53546ae08 )
    {
        return;
    }
    
    if ( !isdefined( player.var_a158c297c424ab64 ) )
    {
        player.var_a158c297c424ab64 = 0;
    }
    
    if ( currenttime < player.var_a158c297c424ab64 )
    {
        return;
    }
    
    if ( function_47619873e06d26e0( player.team ) )
    {
        return;
    }
    
    function_10b67de62486ae56();
    
    if ( bounty.var_cc0e4315eede2fec.size >= bounty.var_315868abc72ccc5 )
    {
        return;
    }
    
    targetteam = br_assassination_quest::determinetargetteam( player, 0, undefined, bounty.var_254d4c01c9580d1d );
    
    if ( !isdefined( targetteam ) )
    {
        return;
    }
    
    spawnvehiclebounty( player, targetteam );
    return 1;
}

// Namespace activity_hop_vehicle_bounty
// Params 2, eflags: 0x4
// Checksum 0x9a6779cc, Offset: 0x4ed
// Size: 0xde
function private spawnvehiclebounty( initiatingplayer, targetteam )
{
    bounty = level.var_32736e4d8d0785dc;
    bountyinstance = activity_instance_common::function_9b387cb1af0d5b4b( "hop_vehicle_bounty" );
    
    if ( !isdefined( bountyinstance ) )
    {
        println( "<dev string:x24>" );
        return;
    }
    
    bountyinstance.var_ca369031b554da2f = initiatingplayer;
    bountyinstance.var_32736e4d8d0785dc = 1;
    bountyinstance.var_579f14da7b65a8a2 = [];
    bountyinstance.var_4df5a307e0b8a12 = [];
    bountyinstance.var_f44da30922b216ca = 0;
    bountyinstance namespace_2acee5c054dc328c::function_6a015dc94c111927( initiatingplayer.team, targetteam, &function_35ec3c40c2bafc9b, level );
    bounty.var_cc0e4315eede2fec[ bounty.var_cc0e4315eede2fec.size ] = bountyinstance;
    bounty.var_87449c973343263 = gettime();
}

// Namespace activity_hop_vehicle_bounty
// Params 3, eflags: 0x4
// Checksum 0x91ec2f9a, Offset: 0x5d3
// Size: 0x1a2
function private function_35ec3c40c2bafc9b( contract, success, endstate )
{
    if ( success )
    {
        br_activity_util::function_381d1d8f56715c32( contract.team, "activitiesCompleted" );
        
        if ( endstate == "Win" && getdvarint( @"hash_ca7c0ac099f20e96", 1 ) )
        {
            utility::registersharedfunc( #"player", #"hash_7771d16073fdcc05", &function_9162be509ccc1d92 );
            
            if ( !utility::issharedfuncdefined( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse" ) )
            {
                utility::registersharedfunc( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse", &br_supply_drops::function_4059aab25747f034 );
            }
            
            function_9162be509ccc1d92( contract.var_ca369031b554da2f );
        }
    }
    
    if ( contract.var_ca369031b554da2f )
    {
        bounty = level.var_32736e4d8d0785dc;
        
        if ( bounty )
        {
            if ( success && endstate == "Win" )
            {
                contract.var_ca369031b554da2f.var_a158c297c424ab64 = gettime() + bounty.var_83aca0bdea0bb510;
            }
            else
            {
                contract.var_ca369031b554da2f.var_a158c297c424ab64 = gettime() + bounty.var_57f75b9cfb98a18;
            }
        }
        
        contract.var_ca369031b554da2f notify( #"hash_997e3037333c0a59" );
    }
    
    if ( level.var_32736e4d8d0785dc )
    {
        level.var_32736e4d8d0785dc.var_cc0e4315eede2fec = arrayremove( level.var_32736e4d8d0785dc.var_cc0e4315eede2fec, contract );
    }
    
    contract function_59fd972216991bd0();
}

// Namespace activity_hop_vehicle_bounty
// Params 0, eflags: 0x4
// Checksum 0x94c390a1, Offset: 0x77d
// Size: 0xd6
function private function_10b67de62486ae56()
{
    state = level.var_32736e4d8d0785dc;
    pruned = [];
    
    foreach ( instance in state.var_cc0e4315eede2fec )
    {
        if ( isdefined( instance ) )
        {
            instancestate = activity_instance_common::getactivitystate( instance );
            
            if ( instancestate != "Ended" && instancestate != "Cleanup" )
            {
                pruned[ pruned.size ] = instance;
            }
        }
    }
    
    state.var_cc0e4315eede2fec = pruned;
}

// Namespace activity_hop_vehicle_bounty
// Params 1, eflags: 0x4
// Checksum 0xa8a94183, Offset: 0x85b
// Size: 0xcb, Type: bool
function private function_47619873e06d26e0( team )
{
    foreach ( instance in level.var_32736e4d8d0785dc.var_cc0e4315eede2fec )
    {
        if ( isdefined( instance ) && instance.team == team )
        {
            instancestate = activity_instance_common::getactivitystate( instance );
            
            if ( instancestate != "Ended" && instancestate != "Cleanup" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace activity_hop_vehicle_bounty
// Params 0, eflags: 0x4
// Checksum 0x841cdaac, Offset: 0x92f
// Size: 0x77
function private function_59fd972216991bd0()
{
    if ( level.activitymanager )
    {
        level.activitymanager.var_cc0e4315eede2fec = arrayremove( level.activitymanager.var_cc0e4315eede2fec, self );
        
        if ( level.activitymanager.var_ec04bf3a584cbd90[ self.team ] )
        {
            level.activitymanager.var_ec04bf3a584cbd90[ self.team ] = undefined;
        }
    }
}

// Namespace activity_hop_vehicle_bounty
// Params 1
// Checksum 0xd47d665a, Offset: 0x9ae
// Size: 0x24d
function function_9162be509ccc1d92( player )
{
    playerorigin = player.origin;
    playerangles = player.angles;
    playerteam = player.team;
    
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
    crate.source = "vip_quest";
    crate.skipminimapicon = 1;
    id = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( id > -1 )
    {
        crate setscriptablepartstate( "objective_map", "hidden" );
        fadestart = getdvarint( @"hash_3f485fe18a08de25", 4921 );
        fadeend = getdvarint( @"hash_18160829d60f2e3c", 5906 );
        objidpoolmanager::objective_add_objective( id, "current", crate.origin, "ui_map_icon_supply_drop_yellow" );
        objective_addalltomask( id );
        objective_showtoplayersinmask( id );
        objective_setbackground( id, 1 );
        objective_onentity( id, crate );
        objective_setzoffset( id, 75 );
        objective_setdescription( id, &"mp_saw_manticore/wanted_crate_ping" );
        function_ac9886e0e2860e18( id, fadestart, fadeend );
        function_44a344c68a68f28d( id, 1 );
        crate.scriptedobjid = id;
        player calloutmarkerping::function_5d7b7302e94b97c2( crate.scriptedobjid );
        level.brgametype thread namespace_4aabd2c8a4353c13::function_220cf16950d590c7( crate );
        
        if ( !level.br_circle_disabled )
        {
            crate thread namespace_4aabd2c8a4353c13::function_65fa856fb85f5bb8( drop_point );
        }
    }
}

