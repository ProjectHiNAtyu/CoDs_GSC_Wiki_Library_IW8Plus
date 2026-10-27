// scripts\mp\ob\systems\ob_analytics_activity.gsc  (hash_05b34ba0cf5f2a07.gscc) (size: 4055 Bytes / 0xfd7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9002b5d (151006045)
// size ...... 4055 (0xfd7)
// includes .. 1   (offset: 0xe23)
// strings ... 22  (offset: 0xe2b)
// dev strs .. 0   (offset: 0xfd7)
// exports ... 8   (offset: 0xbbf)
// cseg ...... 0x24a + 0x975 (0xbbf)
// imports ... 8   (offset: 0xcff)
// animtree1 . 0   (offset: 0xfd7)
// animtree2 . 0   (offset: 0xfd7)
#using scripts\common\activity_nexus\activity_instance_common;

#namespace ob_analytics_activity;

// Namespace ob_analytics_activity
// Params 0
// Checksum 0x81117180, Offset: 0x268
// Size: 0x1c8
function get_activity_difficulty()
{
    if ( !isdefined( self.difficulty_region ) )
    {
        self.difficulty_region = "difficulty_undefined";
    }
    
    if ( isdefined( self.var_546e4eb5269dbafa ) && self.var_546e4eb5269dbafa != "difficulty_undefined" && self.difficulty_region == "difficulty_undefined" )
    {
        self.difficulty_region = self.var_546e4eb5269dbafa;
    }
    else if ( isdefined( self.difficulty_region_string ) && self.difficulty_region_string != "difficulty_undefined" && self.difficulty_region == "difficulty_undefined" )
    {
        self.difficulty_region = self.difficulty_region_string;
    }
    else if ( isdefined( self.var_66eb7e954697f2de ) && self.var_66eb7e954697f2de != "difficulty_undefined" && self.difficulty_region == "difficulty_undefined" )
    {
        self.difficulty_region = self.var_66eb7e954697f2de;
    }
    else if ( isstring( self.var_17bba413d2e84a79 ) && self.var_17bba413d2e84a79 != "difficulty_undefined" && self.difficulty_region == "difficulty_undefined" )
    {
        self.difficulty_region = self.var_17bba413d2e84a79;
    }
    else if ( isdefined( self.var_8ac4adf7bae6f45a ) && self.var_8ac4adf7bae6f45a != "difficulty_undefined" && self.difficulty_region == "difficulty_undefined" )
    {
        self.difficulty_region = self.var_8ac4adf7bae6f45a;
    }
    
    if ( self.difficulty_region == "difficulty_undefined" && isdefined( level.var_bd706167fc97713c ) )
    {
        self.difficulty_region = [[ level.var_bd706167fc97713c ]]( activity_instance_common::function_776ee11e7acc64a5( self ) );
    }
    
    return self.difficulty_region;
}

// Namespace ob_analytics_activity
// Params 1
// Checksum 0x4aa64875, Offset: 0x439
// Size: 0x18b
function function_48061001a97cc2f8( relevantinfostruct )
{
    if ( self.category != "Contract" )
    {
        return;
    }
    
    player_list = relevantinfostruct.playerlist;
    self.difficulty_region = get_activity_difficulty();
    dlog_recordevent( "dlog_event_ob_activity_abandoned", [ "activity_type", self.type, "activity_threat_level", self.difficulty_region, "activity_location_x", self.var_441d26d05f86b224[ 0 ], "activity_location_y", self.var_441d26d05f86b224[ 1 ], "activity_location_z", self.var_441d26d05f86b224[ 2 ], "activity_class", self.category, "activity_instance", self.varianttag, "activity_time", gettime() - ( self.activity_start_time ?? self.activity_begin_time ) ] );
    
    foreach ( player in player_list )
    {
        on_player_activity_end( player, 2 );
    }
}

// Namespace ob_analytics_activity
// Params 1
// Checksum 0xea82f434, Offset: 0x5cc
// Size: 0x15b
function on_activity_complete( relevantinfostruct )
{
    dlog_recordevent( "dlog_event_ob_activity_completed", [ "activity_type", self.type, "activity_threat_level", self.difficulty_region, "activity_location_x", self.var_441d26d05f86b224[ 0 ], "activity_location_y", self.var_441d26d05f86b224[ 1 ], "activity_location_z", self.var_441d26d05f86b224[ 2 ], "activity_class", self.category, "activity_instance", self.varianttag, "activity_time", gettime() - ( self.activity_start_time ?? self.activity_begin_time ) ] );
    
    foreach ( player in self.playerparticipants )
    {
        on_player_activity_end( player, 1 );
    }
}

// Namespace ob_analytics_activity
// Params 1
// Checksum 0xd3b0625, Offset: 0x72f
// Size: 0x169
function on_activity_failed( relevantinfostruct )
{
    self.difficulty_region = get_activity_difficulty();
    dlog_recordevent( "dlog_event_ob_activity_failed", [ "activity_type", self.type, "activity_threat_level", self.difficulty_region, "activity_location_x", self.var_441d26d05f86b224[ 0 ], "activity_location_y", self.var_441d26d05f86b224[ 1 ], "activity_location_z", self.var_441d26d05f86b224[ 2 ], "activity_class", self.category, "activity_instance", self.varianttag, "activity_time", gettime() - ( self.activity_start_time ?? self.activity_begin_time ) ] );
    
    foreach ( player in self.playerparticipants )
    {
        on_player_activity_end( player, 0 );
    }
}

// Namespace ob_analytics_activity
// Params 1
// Checksum 0x6a16ee33, Offset: 0x8a0
// Size: 0xd5
function on_activity_begin( relevantinfostruct )
{
    self.difficulty_region = get_activity_difficulty();
    self.activity_begin_time = gettime();
    dlog_recordevent( "dlog_event_ob_activity_started", [ "activity_type", self.type, "activity_threat_level", self.difficulty_region, "activity_location_x", self.var_441d26d05f86b224[ 0 ], "activity_location_y", self.var_441d26d05f86b224[ 1 ], "activity_location_z", self.var_441d26d05f86b224[ 2 ], "activity_class", self.category, "activity_instance", self.varianttag ] );
}

// Namespace ob_analytics_activity
// Params 1
// Checksum 0x823ddb6e, Offset: 0x97d
// Size: 0xea
function function_4b55ce0113456ec6( relevantinfostruct )
{
    if ( !isdefined( self.telemetry ) )
    {
        self.telemetry = [];
    }
    
    self.telemetry[ "player_participate_time_begin" ] = [];
    player_list = relevantinfostruct.playerlist;
    
    foreach ( player in player_list )
    {
        self.telemetry[ "player_participate_time_begin" ][ player.guid ] = gettime();
    }
    
    if ( !isdefined( self.activity_start_time ) )
    {
        self.activity_start_time = gettime();
    }
}

// Namespace ob_analytics_activity
// Params 2
// Checksum 0xe194192a, Offset: 0xa6f
// Size: 0x150
function on_player_activity_end( player, result )
{
    participate_time_begin = gettime();
    
    if ( self.telemetry[ "player_participate_time_begin" ][ player.guid ] )
    {
        participate_time_begin = self.telemetry[ "player_participate_time_begin" ][ player.guid ];
    }
    
    player dlog_recordplayerevent( "dlog_event_ob_player_activity_end", [ "activity_type", self.type, "activity_class", self.category, "activity_instance", self.varianttag, "activity_threat_level", self.difficulty_region, "result", result, "participate_time", gettime() - participate_time_begin, "player_x", player.origin[ 0 ], "player_y", player.origin[ 1 ], "player_z", player.origin[ 2 ], "session_squad_id", player.sessionsquadid ] );
}

