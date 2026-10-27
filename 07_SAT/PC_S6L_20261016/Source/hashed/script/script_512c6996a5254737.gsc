// script_512c6996a5254737  (hash_512c6996a5254737.gscc) (size: 16048 Bytes / 0x3eb0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8667113f (2254901567)
// size ...... 16048 (0x3eb0)
// includes .. 22  (offset: 0x39e4)
// strings ... 59  (offset: 0x3a94)
// dev strs .. 4   (offset: 0x3e80)
// exports ... 47  (offset: 0x2470)
// cseg ...... 0x3e8 + 0x2088 (0x2470)
// imports ... 117 (offset: 0x2bc8)
// animtree1 . 0   (offset: 0x3eb0)
// animtree2 . 0   (offset: 0x3eb0)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\ob\ob_interactions_util;

#namespace activity_bongo_redeploy_station;

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x5
// Checksum 0x91235d5f, Offset: 0x406
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_bongo_redeploy_station", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x3bc3ca64, Offset: 0x42f
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BONGO_REDEPLOY_STATION", &redeploy_station_activity_type_init );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x72344fbd, Offset: 0x44a
// Size: 0xa8
function private redeploy_station_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BONGO_REDEPLOY_STATION", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BONGO_REDEPLOY_STATION", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BONGO_REDEPLOY_STATION", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_944074f3079c1d4e( "BONGO_REDEPLOY_STATION", 4, &get_center );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined, "BONGO_REDEPLOY_STATION" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left, "BONGO_REDEPLOY_STATION" );
    
    if ( !isdefined( level.var_1aff81a7080bac1b ) )
    {
        level.var_1aff81a7080bac1b = [];
    }
    
    level.var_1aff81a7080bac1b[ "saw_bongo_redeploy_station_objective_marker" ] = %"ping_location_go";
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x77534bb9, Offset: 0x4fa
// Size: 0x2dd
function private activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    scheduleractivitydefinition = activity_instance_common::function_a45920af4495e9f( self ).scheduleractivitydefinition;
    
    if ( isdefined( scheduleractivitydefinition ) )
    {
        var_3d58f715e02cdedd = getscriptbundle( hashcat( %"activitydefinition:", scheduleractivitydefinition ) );
        
        if ( isdefined( var_3d58f715e02cdedd ) )
        {
            self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( var_3d58f715e02cdedd );
        }
    }
    
    if ( !isdefined( self.var_332f929de1894b2b ) )
    {
        self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    }
    
    if ( !isdefined( level.var_2c65a4a6e05bcef7 ) )
    {
        level.var_2c65a4a6e05bcef7 = "redeploy_capture_point";
    }
    
    if ( !isdefined( level.activities.definitions[ level.var_2c65a4a6e05bcef7 ] ) )
    {
        activity_definition_utils::function_74af1ab4059e3c06( self.var_332f929de1894b2b.var_819b3f38f3cc43bf, level.var_2c65a4a6e05bcef7 );
    }
    
    linked_structs = activity_instance_common::function_c78d8509d1f980d4( self );
    origin = linked_structs[ 0 ].origin;
    station_origin = utility::drop_to_ground( origin );
    self.station = spawnscriptable( self.var_332f929de1894b2b.towerscriptable, station_origin, linked_structs[ 0 ].angles );
    self.station.activity = self;
    self.station.interact = interaction::register_scriptable_interact( self.station, &on_tower_used, undefined, undefined, &tower_interact_hint, 1 );
    self.station.marker = spawnscriptable( self.var_332f929de1894b2b.var_eecf9bfd2ac7acbe, station_origin );
    self.station.ownedmarker = spawnscriptable( self.var_332f929de1894b2b.var_373e57633dbbc267, station_origin );
    self.numcharges = self.var_332f929de1894b2b.numcharges;
    function_bc041d7a3efbfe87( self.varianttag, self.var_332f929de1894b2b );
    self.var_9699265805219bc9 = 1;
    self.var_d7902a99156f281e = &function_d7902a99156f281e;
    activity_definition_utils::function_16b3cfd89a1669f7( 2, self );
    activity_definition_utils::function_a0a94881bc380bbf( 0, self );
    activity_instance_common::function_46135a69bddfec2c( self );
    level callback::callback( #"redeploy_station_setup", { #station:self.station } );
    utility::callsharedfunc( #"bongo", #"hash_e4108d66df2f65d3", self.station.marker, 1 );
    utility::callsharedfunc( #"bongo", #"hash_e4108d66df2f65d3", self.station.ownedmarker, 0 );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0xb8ca6eba, Offset: 0x7df
// Size: 0x34
function private function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.station function_5e6ab36023a64e0a();
    
    /#
        thread function_709405dfa8ec5597();
    #/
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x7048b0e5, Offset: 0x81b
// Size: 0x52
function private function_d4acef179eb9f9b2()
{
    if ( self.captureactivity )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self.captureactivity );
    }
    
    self.station function_8d91dd750ae709fb();
    level callback::callback( #"redeploy_station_destroy", { #station:self.station } );
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0xb75f6df9, Offset: 0x875
// Size: 0xad, Type: bool
function private function_d7902a99156f281e( player )
{
    teammates = teams::getteamdata( player.team, "players" );
    
    foreach ( teammate in teammates )
    {
        if ( teammate != player && !player::isreallyalive( teammate ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x77906749, Offset: 0x92b
// Size: 0x15
function private get_center()
{
    return self.station.origin;
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0xbcf2a7a1, Offset: 0x949
// Size: 0x13d
function private player_joined( relevant_info_struct )
{
    if ( !isdefined( self.var_7b2ac829756f4854 ) )
    {
        self.var_7b2ac829756f4854 = [];
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        var_3bf2a2d6de70c374 = teams::getteamdata( player.team, "players" );
        
        if ( teams::getteamdata( player.team, "aliveCount" ) < var_3bf2a2d6de70c374.size )
        {
            if ( !arraycontains( self.var_7b2ac829756f4854, player ) )
            {
                self.var_7b2ac829756f4854[ self.var_7b2ac829756f4854.size ] = player;
                level thread br_public::brleaderdialogplayer( "redeploy_tower_" + self.varianttag + "_approach", player, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_90d2488226a1079f );
            }
        }
        
        br_analytics::function_63a0465c6e14c930( self, player );
    }
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0xeb6aa1e0, Offset: 0xa8e
// Size: 0x88
function private player_left( relevant_info_struct )
{
    foreach ( player in relevant_info_struct.playerlist )
    {
        br_analytics::function_d9845418c8b51cff( self, player );
    }
}

// Namespace activity_bongo_redeploy_station
// Params 2, eflags: 0x4
// Checksum 0xa30892c9, Offset: 0xb1e
// Size: 0xc8
function private function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "redeploy_tower_" + variantname + "_approach" ] ) )
    {
        game[ "dialog" ][ "redeploy_tower_" + variantname + "_approach" ] = data.var_4310ead0bb84e72b;
        game[ "dialog" ][ "redeploy_tower_" + variantname + "_success" ] = data.var_722663430868f18e;
        game[ "dialog" ][ "redeploy_tower_" + variantname + "_revive_team" ] = data.var_686456bbdc992e7b;
        game[ "dialog" ][ "redeploy_tower_" + variantname + "_start" ] = data.var_a996cbdc20244121;
    }
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0x62c5a8ff, Offset: 0xbee
// Size: 0x9c, Type: bool
function private function_dcd2b43a2e6d5bc5( team )
{
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( !player::isreallyalive( player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace activity_bongo_redeploy_station
// Params 2, eflags: 0x4
// Checksum 0xb5624c24, Offset: 0xc93
// Size: 0x1d5
function private tower_interact_hint( usable, player )
{
    if ( activity_instance_common::getactivitystate( usable.activity ) != "Active" )
    {
        return { #string:&"br_gametype_bongo/activity_redeploy_shutdown", #type:"HINT_NOBUTTON" };
    }
    
    if ( usable.activity.oncooldown )
    {
        return { #string:&"br_gametype_bongo/activity_redeploy_cooldown_hint", #type:"HINT_NOBUTTON" };
    }
    
    if ( usable.activity.captureactivity )
    {
        if ( activity_participation::function_e7fc1202ac164928( usable.activity.captureactivity, player ) || activity_instance_common::getactivitystate( usable.activity.captureactivity ) != "Active" )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        else
        {
            return { #string:&"br_gametype_bongo/activity_redeploy_already_in_progress_hint", #type:"HINT_NOBUTTON" };
        }
    }
    
    if ( !usable.activity.numcharges )
    {
        return { #string:&"br_gametype_bongo/activity_redeploy_no_charges_hint", #type:"HINT_NOBUTTON" };
    }
    
    if ( !function_dcd2b43a2e6d5bc5( player.team ) && !getdvarint( @"scr_bongo_redeploy_station_test", 0 ) )
    {
        return { #string:&"br_gametype_bongo/activity_redeploy_no_redeployable_teammates_hint", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"br_gametype_bongo/activity_redeploy_initiate_hint", #type:"HINT_BUTTON" };
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0xdeaa3676, Offset: 0xe71
// Size: 0xd1
function private on_tower_used( player )
{
    activity = self.activity;
    
    if ( !function_dcd2b43a2e6d5bc5( player.team ) && !getdvarint( @"scr_bongo_redeploy_station_test", 0 ) )
    {
        return;
    }
    
    if ( activity.captureactivity || activity.numcharges <= 0 || activity.oncooldown || activity_instance_common::getactivitystate( activity ) != "Active" )
    {
        return;
    }
    
    thread c_link_interact( player, self.activity.var_332f929de1894b2b.usetime ?? 1, &on_interact_success, { #activity:self.activity } );
}

// Namespace activity_bongo_redeploy_station
// Params 4, eflags: 0x4
// Checksum 0x544afdc9, Offset: 0xf4a
// Size: 0x7a
function private c_link_interact( player, duration, successcallback, callbackparams )
{
    player endon( #"disconnect" );
    player giveweapon( "earpiece_press_sat_ob" );
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, duration, self, 1, 1, 0, -1, "ClinkInteractions" );
    player canceloffhands();
    
    if ( var_fab006cdb4f6e516 )
    {
        player [[ successcallback ]]( callbackparams );
    }
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0x3efad869, Offset: 0xfcc
// Size: 0x1f
function private on_interact_success( params )
{
    params.activity spawn_capture_point( self );
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0x8bc88ae9, Offset: 0xff3
// Size: 0x20c
function private spawn_capture_point( initiatingplayer )
{
    activity = self;
    scriptable = activity.station;
    scriptable function_5c538d39467afafb( activity.var_332f929de1894b2b.circlesize );
    var_8182f156f509ce36 = teams::getteamdata( initiatingplayer.team, "players" );
    activity_player_common::function_674cca638cafcae3( var_8182f156f509ce36, activity, "ui_activity_scriptable_index", activity.station.index, -1 );
    activity_definition_utils::function_a0a94881bc380bbf( 1, activity, { #players:var_8182f156f509ce36 } );
    activity.captureactivity = activity_instance_common::function_9b387cb1af0d5b4b( level.var_2c65a4a6e05bcef7, scriptable.origin, { #owningactivity:self, #var_f05781a0c58e1aaf:"BONGO_REDEPLOY_STATION" } );
    activity.captureactivity.parentactivity = activity;
    activity_participation::function_bc67362dace4370c( activity.captureactivity, initiatingplayer );
    activity.captureactivity.player = initiatingplayer;
    function_1c9e6e26253bd094( scriptable.ownedmarker, scriptable.marker, initiatingplayer.team );
    activity thread function_c4d0fdf24913b348( activity.captureactivity );
    activity thread charge_state_watcher( activity.captureactivity );
    level thread br_public::brleaderdialogteam( "redeploy_tower_" + self.varianttag + "_start", initiatingplayer.team, 1, 2, undefined, self.var_332f929de1894b2b.var_b38da3de526dca55 );
    activity.captureactivity thread function_aed1b9ea48e77877( activity );
    activity.captureactivity thread function_c3e7786e72fb77aa( activity );
    activity.captureactivity thread function_b93befa939398c6a( activity );
    thread function_f86391a9991537e6( activity, initiatingplayer.team );
}

// Namespace activity_bongo_redeploy_station
// Params 1
// Checksum 0xcb041130, Offset: 0x1207
// Size: 0x8e
function function_c4d0fdf24913b348( captureactivity )
{
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        if ( !self || !captureactivity )
        {
            return;
        }
        
        if ( self.var_332f929de1894b2b.var_ca82131e555df506 <= captureactivity.var_4a62b0f6788ba18e )
        {
            self.station function_4613106073681c52();
            return;
        }
        
        if ( isdefined( captureactivity.var_4a62b0f6788ba18e ) )
        {
            self.station function_70576dbab4f88e19( "progress_percentage", captureactivity.var_4a62b0f6788ba18e );
        }
        
        waitframe();
    }
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0xb24176bd, Offset: 0x129d
// Size: 0xb2
function private charge_state_watcher( captureactivity )
{
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    self endon( #"hash_4c7c5de73041541c" );
    captureactivity endon( #"instance_destroyed" );
    captureactivity endon( #"activity_ended" );
    chargestates = [ "active_1", "active_2", "active_3" ];
    
    while ( true )
    {
        var_897f0094d6449e93 = chargestates[ int( ( captureactivity.var_4a62b0f6788ba18e ?? 0 ) * 3 ) ];
        self.station setscriptablepartstate( "Charge Panels", var_897f0094d6449e93 );
        waitframe();
    }
}

// Namespace activity_bongo_redeploy_station
// Params 2, eflags: 0x4
// Checksum 0x178a6243, Offset: 0x1357
// Size: 0x118
function private function_f86391a9991537e6( activity, team )
{
    activity endon( #"activity_ended" );
    activity.captureactivity endon( #"activity_ended" );
    activity.captureactivity endon( #"activity_succeeded" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( !function_dcd2b43a2e6d5bc5( team ) && !getdvarint( @"scr_bongo_redeploy_station_test", 0 ) )
        {
            foreach ( player in activity_instance_common::function_4225efca86f0dea9( activity.captureactivity ) )
            {
                player hud_message::showerrormessage( %"br_gametype_bongo/activity_redeploy_no_redeployable_teammates_hint" );
            }
            
            activity_instance_common::endactivity( activity.captureactivity );
            return;
        }
    }
}

// Namespace activity_bongo_redeploy_station
// Params 3, eflags: 0x4
// Checksum 0x251023cd, Offset: 0x1477
// Size: 0xbc
function private function_1c9e6e26253bd094( ownedmarker, marker, team )
{
    teammates = teams::getteamdata( team, "players" );
    
    foreach ( teammate in teammates )
    {
        ownedmarker function_6113853a877d5460( teammate );
        marker function_d6a7b7ef13a57f38( teammate );
    }
    
    ownedmarker.team = team;
}

// Namespace activity_bongo_redeploy_station
// Params 2, eflags: 0x4
// Checksum 0x30540d90, Offset: 0x153b
// Size: 0xcc
function private function_f82f5ad777a6bedb( ownedmarker, marker )
{
    assert( ownedmarker.team );
    teammates = teams::getteamdata( ownedmarker.team, "players" );
    
    foreach ( teammate in teammates )
    {
        ownedmarker function_d6a7b7ef13a57f38( teammate );
        marker function_6113853a877d5460( teammate );
    }
    
    ownedmarker.team = undefined;
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0xd4f61b10, Offset: 0x160f
// Size: 0x96
function private function_b93befa939398c6a( var_9710f66cee2bfbe0 )
{
    var_819b3f38f3cc43bf = self;
    var_819b3f38f3cc43bf endon( #"activity_ended" );
    level waittill( #"game_ended" );
    function_f82f5ad777a6bedb( var_9710f66cee2bfbe0.station.ownedmarker, var_9710f66cee2bfbe0.station.marker );
    var_819b3f38f3cc43bf.result = "cleaned_up";
    function_8b84c408522eb676( function_5146bbbb582af507( var_819b3f38f3cc43bf ) );
    var_9710f66cee2bfbe0.station function_573fa6a5d294fb44();
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0xf5bd2f47, Offset: 0x16ad
// Size: 0x14b
function private function_aed1b9ea48e77877( var_9710f66cee2bfbe0 )
{
    var_819b3f38f3cc43bf = self;
    var_9710f66cee2bfbe0 endon( #"instance_destroyed" );
    var_819b3f38f3cc43bf waittill( #"activity_succeeded" );
    initiatingplayer = self.player;
    var_8182f156f509ce36 = teams::getteamdata( initiatingplayer.team, "players" );
    activity_definition_utils::function_a0a94881bc380bbf( 2, var_9710f66cee2bfbe0, { #players:var_8182f156f509ce36 } );
    function_f82f5ad777a6bedb( var_9710f66cee2bfbe0.station.ownedmarker, var_9710f66cee2bfbe0.station.marker );
    
    foreach ( player in self.var_21196410eda12485 )
    {
        if ( player challenges::challengesenabledforplayer() )
        {
            challenges::function_37e945722d6497f3( player, "redeploy", 1 );
        }
    }
    
    var_819b3f38f3cc43bf thread do_respawns( var_9710f66cee2bfbe0, self.var_21196410eda12485 );
}

// Namespace activity_bongo_redeploy_station
// Params 2, eflags: 0x4
// Checksum 0xc817745a, Offset: 0x1800
// Size: 0x22b
function private do_respawns( var_9710f66cee2bfbe0, var_1a4ea09a1be7ad45 )
{
    var_819b3f38f3cc43bf = self;
    origin = activity_instance_common::function_776ee11e7acc64a5( var_819b3f38f3cc43bf );
    var_e9f8f568835206ba = function_5146bbbb582af507( var_819b3f38f3cc43bf );
    var_9710f66cee2bfbe0.station thread function_53af3244a8dcd3f5( var_9710f66cee2bfbe0.var_332f929de1894b2b.circlesize );
    var_9710f66cee2bfbe0 notify( #"hash_4c7c5de73041541c" );
    
    foreach ( player in activity_instance_common::function_4225efca86f0dea9( var_819b3f38f3cc43bf ) )
    {
        if ( player::isreallyalive( player ) )
        {
            level thread br_public::brleaderdialogplayer( "redeploy_tower_" + self.parentactivity.varianttag + "_success", player, 1, undefined, 2, undefined, self.parentactivity.var_332f929de1894b2b.var_11f87a6ededa3182 );
            continue;
        }
        
        assert( isdefined( var_819b3f38f3cc43bf.player ), "<dev string:x2b>" );
        var_9710f66cee2bfbe0.station redeploy_player( player, var_819b3f38f3cc43bf.player, "redeploy_station", var_1a4ea09a1be7ad45 );
        level thread br_contract_manager::utilflare_shootflare( origin, "revive", 1 );
        var_e9f8f568835206ba.respawn_count += 1;
        br_activity_util::function_333e692c891758bb( var_819b3f38f3cc43bf.player, "teammatesRedeployed" );
        wait var_9710f66cee2bfbe0.var_332f929de1894b2b.respawnspacing;
    }
    
    /#
        if ( getdvarint( @"scr_bongo_redeploy_station_test", 0 ) )
        {
            wait var_9710f66cee2bfbe0.var_332f929de1894b2b.respawnspacing;
        }
    #/
    
    function_8b84c408522eb676( var_e9f8f568835206ba );
    br_activity_util::function_333e692c891758bb( var_819b3f38f3cc43bf.player, "activitiesCompleted" );
    var_9710f66cee2bfbe0 thread capture_point_cleanup();
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0xa47d88cc, Offset: 0x1a33
// Size: 0x99
function private function_c3e7786e72fb77aa( var_9710f66cee2bfbe0 )
{
    var_819b3f38f3cc43bf = self;
    var_9710f66cee2bfbe0 endon( #"instance_destroyed" );
    var_819b3f38f3cc43bf waittill( #"activity_failed" );
    activity_definition_utils::function_a0a94881bc380bbf( 0, var_9710f66cee2bfbe0 );
    function_f82f5ad777a6bedb( var_9710f66cee2bfbe0.station.ownedmarker, var_9710f66cee2bfbe0.station.marker );
    function_8b84c408522eb676( function_5146bbbb582af507( var_819b3f38f3cc43bf ) );
    var_9710f66cee2bfbe0.station function_573fa6a5d294fb44();
    var_9710f66cee2bfbe0 thread capture_point_cleanup();
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x8d11a0c, Offset: 0x1ad4
// Size: 0x98
function private capture_point_cleanup()
{
    self.oncooldown = 1;
    self.station.marker setscriptablepartstate( "objective", "cooldown" );
    activity_definition_utils::function_a0a94881bc380bbf( 0, self );
    self.station utility::delaythread( self.var_332f929de1894b2b.var_7d525066440e1e00, &function_ca257d13651e5496 );
    self.captureactivity = undefined;
    wait self.var_332f929de1894b2b.cooldown;
    self.oncooldown = 0;
    self.station function_5e6ab36023a64e0a();
}

// Namespace activity_bongo_redeploy_station
// Params 4, eflags: 0x4
// Checksum 0x474f71e2, Offset: 0x1b74
// Size: 0x1d1
function private redeploy_player( player, sponsor, analyticsevent, var_133fade9a486f7ed )
{
    if ( isdefined( var_133fade9a486f7ed ) )
    {
        foreach ( captureplayer in var_133fade9a486f7ed )
        {
            if ( captureplayer != sponsor )
            {
                captureplayer points::doscoreevent( #"hash_e72b717ae412fadd" );
            }
        }
    }
    
    if ( isdefined( sponsor ) )
    {
        sponsor points::doscoreevent( #"hash_e72b717ae412fadd" );
    }
    
    if ( player.inlaststand )
    {
        player laststand::exit( "last_stand_revived", player );
        return;
    }
    
    respawnpoint = function_cf9fac546dd7ab5e();
    player.var_ecce78452b9a6c18 = 1;
    
    if ( !isalive( player ) && !player br_public::isplayerinorgoingtogulag() )
    {
        if ( player.respawningfromtoken )
        {
            player.var_ad882e8f12cd3d2a = 0;
            player.var_9132049fb3d1b450 = 0;
            player.respawnpoint = respawnpoint;
        }
        else
        {
            level thread br_public::brleaderdialogplayer( "redeploy_tower_" + self.activity.varianttag + "_revive_team", player, 0, 1, 2, undefined, self.activity.var_332f929de1894b2b.var_1281277c0aa53c8f );
            player thread br_gulag::playergulagautowin( "redeploy_station", sponsor, 0, 0, 0, 0, 0, undefined, respawnpoint );
        }
        
        return;
    }
    
    if ( player br_public::isplayerinorgoingtogulag() )
    {
        player thread br_gulag::playerpulloutofgulagwin( sponsor, analyticsevent );
    }
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x83413f30, Offset: 0x1d4d
// Size: 0x4a
function private function_5e6ab36023a64e0a()
{
    self setscriptablepartstate( "redeploy_station", "usable" );
    self setscriptablepartstate( "Crackle", "idle" );
    self setscriptablepartstate( "Charge Panels", "solid_blue" );
    self.marker setscriptablepartstate( "objective", "available" );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x3392aa46, Offset: 0x1d9f
// Size: 0x6a
function private function_ccb8a59cc7d858b6()
{
    self setscriptablepartstate( "Crackle", "idle" );
    self setscriptablepartstate( "Beam", "idle" );
    self setscriptablepartstate( "Portal", "idle" );
    self setscriptablepartstate( "vfx_circle", "no_circle" );
    self setscriptablepartstate( "Charge Panels", "depleted" );
    self.marker setscriptablepartstate( "objective", "disable" );
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0xaf622095, Offset: 0x1e11
// Size: 0x15
function private function_5c538d39467afafb( circlesize )
{
    function_e1756d8edb67b180( circlesize );
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0x35b88332, Offset: 0x1e2e
// Size: 0x2a
function private function_e1756d8edb67b180( circlesize )
{
    self setscriptablepartstate( "vfx_circle", "circle_" + circlesize );
    self.var_9d774cbcd4fcb591 = circlesize;
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x80514cae, Offset: 0x1e60
// Size: 0x41
function private function_573fa6a5d294fb44()
{
    if ( self.var_9d774cbcd4fcb591 )
    {
        self setscriptablepartstate( "vfx_circle", "circle_" + self.var_9d774cbcd4fcb591 + "_end" );
        return;
    }
    
    self setscriptablepartstate( "vfx_circle", "no_circle" );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x7ef8dbe, Offset: 0x1ea9
// Size: 0x12
function private function_4613106073681c52()
{
    self setscriptablepartstate( "Crackle", "play" );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0xb0080b43, Offset: 0x1ec3
// Size: 0x12
function private function_ca257d13651e5496()
{
    self setscriptablepartstate( "Crackle", "idle" );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0xfa835ce9, Offset: 0x1edd
// Size: 0x12
function private function_5f43010eebb141ae()
{
    self setscriptablepartstate( "Beam", "play" );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0xf45bd948, Offset: 0x1ef7
// Size: 0x32
function private function_c1e6b8def2fad55a()
{
    self setscriptablepartstate( "Beam", "idle" );
    self setscriptablepartstate( "vfx_circle", "no_circle" );
    self setscriptablepartstate( "Charge Panels", "depleted" );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x97a4ddf0, Offset: 0x1f31
// Size: 0x12
function private function_97017d39cc993727()
{
    self setscriptablepartstate( "Portal", "play" );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0x7ba25fb9, Offset: 0x1f4b
// Size: 0x12
function private function_fd2c4ff81220daef()
{
    self setscriptablepartstate( "Portal", "close" );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0xea4c1e77, Offset: 0x1f65
// Size: 0x12
function private function_80e77a9d09b2b8cb()
{
    self setscriptablepartstate( "Portal", "idle" );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0xbddb1cbc, Offset: 0x1f7f
// Size: 0xde
function private function_cf9fac546dd7ab5e()
{
    offset = ( 0, 0, 24000 );
    origin = self.origin + offset;
    dangerorigin = br_circle::getdangercircleorigin();
    var_931622191ef21a0b = br_circle::getdangercircleradius() - getdvarint( @"hash_b81f6efbdcaf5034", 5000 );
    currentradius = distance2d( origin, dangerorigin );
    
    if ( currentradius > var_931622191ef21a0b )
    {
        origin = ( dangerorigin[ 0 ] + var_931622191ef21a0b * ( origin[ 0 ] - dangerorigin[ 0 ] ) / currentradius, dangerorigin[ 1 ] + var_931622191ef21a0b * ( origin[ 1 ] - dangerorigin[ 1 ] ) / currentradius, origin[ 2 ] );
    }
    
    angles = ( 0, vectortoyaw( dangerorigin - origin ), 0 );
    portalposition = { #angles:angles, #origin:origin };
    return portalposition;
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0x74dd16c9, Offset: 0x2066
// Size: 0x15b
function private function_53af3244a8dcd3f5( circlesize )
{
    level endon( #"game_ended" );
    var_55ceac6f42cd3527 = self.activity.var_332f929de1894b2b.beamdelay;
    beamstop = var_55ceac6f42cd3527 + self.activity.var_332f929de1894b2b.beamduration;
    portalstart = self.activity.var_332f929de1894b2b.portaldelay;
    portalclose = portalstart + self.activity.var_332f929de1894b2b.var_88d45c4c9e41bd94;
    portalstop = portalclose + self.activity.var_332f929de1894b2b.var_a26ad7f0c44a3380;
    utility::delaythread( var_55ceac6f42cd3527, &function_5f43010eebb141ae );
    utility::delaythread( beamstop, &function_c1e6b8def2fad55a );
    utility::delaythread( portalstart, &function_97017d39cc993727 );
    utility::delaythread( portalclose, &function_fd2c4ff81220daef );
    utility::delaythread( portalstop, &function_80e77a9d09b2b8cb );
    function_573fa6a5d294fb44();
    self.marker setscriptablepartstate( "objective", "cooldown" );
    self setscriptablepartstate( "Charge Panels", "solid_yellow" );
}

// Namespace activity_bongo_redeploy_station
// Params 0, eflags: 0x4
// Checksum 0xbf1d72bc, Offset: 0x21c9
// Size: 0x27
function private function_8d91dd750ae709fb()
{
    function_ccb8a59cc7d858b6();
    self setscriptablepartstate( "Charge Panels", "depleted" );
    self.ownedmarker freescriptable();
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0xd8bee50f, Offset: 0x21f8
// Size: 0xcf
function private function_5146bbbb582af507( var_819b3f38f3cc43bf )
{
    stationorigin = var_819b3f38f3cc43bf.parentactivity.station.origin;
    return { #respawn_count:0, #result:var_819b3f38f3cc43bf.result, #end_time_ms:gettime(), #start_time_ms:var_819b3f38f3cc43bf.starttime, #tower_z:stationorigin[ 2 ], #tower_y:stationorigin[ 1 ], #tower_x:stationorigin[ 0 ], #tower_id:var_819b3f38f3cc43bf.parentactivity.id, #player:var_819b3f38f3cc43bf.player };
}

// Namespace activity_bongo_redeploy_station
// Params 1, eflags: 0x4
// Checksum 0x6c447822, Offset: 0x22d0
// Size: 0x122
function private function_8b84c408522eb676( event )
{
    if ( !event.player )
    {
        return;
    }
    
    event.player dlog_recordplayerevent( "dlog_event_activity_redeploy_capture_point_end", [ "tower_id", event.tower_id ?? 0, "tower_x", event.tower_x ?? 0, "tower_y", event.tower_y ?? 0, "tower_z", event.tower_z ?? 0, "start_time_ms", event.start_time_ms ?? 0, "end_time_ms", event.end_time_ms ?? 0, "result", event.result ?? "", "respawn_count", event.respawn_count ?? 0 ] );
}

/#

    // Namespace activity_bongo_redeploy_station
    // Params 0, eflags: 0x4
    // Checksum 0xeac8ed8, Offset: 0x23fa
    // Size: 0x76, Type: dev
    function private function_709405dfa8ec5597()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        origin = activity_instance_common::function_776ee11e7acc64a5( self );
        
        while ( true )
        {
            waitframe();
            print3d( origin + ( 0, 0, 100 ), ( self.numcharges ?? "<dev string:x91>" ) + "<dev string:x93>", ( 0, 0.75, 0 ), 1, 1 );
        }
    }

#/
