// scripts\mp\ftue\utility\ftue_telemetry.gsc  (hash_5693b37bfb748170.gscc) (size: 2902 Bytes / 0xb56 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfde834c2 (4259853506)
// size ...... 2902 (0xb56)
// includes .. 3   (offset: 0xa26)
// strings ... 22  (offset: 0xa3e)
// dev strs .. 0   (offset: 0xb56)
// exports ... 12  (offset: 0x65e)
// cseg ...... 0x20e + 0x450 (0x65e)
// imports ... 16  (offset: 0x83e)
// animtree1 . 0   (offset: 0xb56)
// animtree2 . 0   (offset: 0xb56)
#using scripts\common\telemetry_utils;
#using scripts\mp\ftue\utility\ftue_player;
#using scripts\mp\ftue\utility\ftue_progress;

#namespace ftue_telemetry;

// Namespace ftue_telemetry
// Params 1
// Checksum 0x44029c2, Offset: 0x22c
// Size: 0x36
function function_4613112d313d82ad( context )
{
    if ( level.var_aea84cee62752c55 )
    {
        return;
    }
    
    function_f71328d5e780865e();
    level.var_72750ad9b5ba32d4 = context;
    level.var_aea84cee62752c55 = 1;
}

// Namespace ftue_telemetry
// Params 1
// Checksum 0xf46ec36a, Offset: 0x26a
// Size: 0x76
function function_394c8146182787a9( matchid )
{
    data = spawnstruct();
    data.player = self;
    data.stepname = function_4fbc7ca864dd5047( matchid );
    data.stepnumber = 1000;
    data.ismandatory = 1;
    data.isautomatic = 1;
    telemetry_utils::function_af2d366f9522f76f( "mobile_ftue_step_start", data );
}

// Namespace ftue_telemetry
// Params 2
// Checksum 0x64a9be13, Offset: 0x2e8
// Size: 0x8f
function function_81211bd09c666dd2( matchid, stepnumber )
{
    data = spawnstruct();
    data.player = self;
    data.stepname = function_4fbc7ca864dd5047( matchid );
    data.stepnumber = stepnumber;
    data.ismandatory = 1;
    data.isautomatic = 1;
    data.result = "SUCCESS";
    telemetry_utils::function_af2d366f9522f76f( "mobile_ftue_step_finished", data );
}

// Namespace ftue_telemetry
// Params 0, eflags: 0x4
// Checksum 0x46091dbf, Offset: 0x37f
// Size: 0x35
function private function_f71328d5e780865e()
{
    telemetry_utils::function_5995f9c2ef729dbd( "mobile_ftue_step_start", &function_bb220e55d74594c3 );
    telemetry_utils::function_5995f9c2ef729dbd( "mobile_ftue_step_finished", &function_d380ff93d88c281f );
    telemetry_utils::function_5995f9c2ef729dbd( "mobile_ftue_step_single", &function_a4813748afaaaa35 );
}

// Namespace ftue_telemetry
// Params 1, eflags: 0x4
// Checksum 0x90bdca97, Offset: 0x3bc
// Size: 0x2a
function private function_bb220e55d74594c3( data )
{
    data.player dlog_recordplayerevent( "dlog_event_ftue_step_start", function_d21eb53f5672fb0e( data ), 0 );
}

// Namespace ftue_telemetry
// Params 1, eflags: 0x4
// Checksum 0xbed4dbb3, Offset: 0x3ee
// Size: 0x42
function private function_d380ff93d88c281f( data )
{
    telemetrydata = function_d21eb53f5672fb0e( data );
    telemetrydata = function_c1f2200f5f7bc95f( telemetrydata, data );
    data.player dlog_recordplayerevent( "dlog_event_ftue_step_finished", telemetrydata );
}

// Namespace ftue_telemetry
// Params 1, eflags: 0x4
// Checksum 0xaa10685e, Offset: 0x438
// Size: 0x59
function private function_a4813748afaaaa35( data )
{
    telemetrydata = function_d21eb53f5672fb0e( data );
    data.player dlog_recordplayerevent( "dlog_event_ftue_step_start", telemetrydata );
    telemetrydata = function_c1f2200f5f7bc95f( telemetrydata, data );
    data.player dlog_recordplayerevent( "dlog_event_ftue_step_finished", telemetrydata );
}

// Namespace ftue_telemetry
// Params 1, eflags: 0x4
// Checksum 0x8e317ebc, Offset: 0x499
// Size: 0x12f
function private function_d21eb53f5672fb0e( data )
{
    rank = data.player ftue_player::ftue_player_getrank();
    expertise = data.player ftue_progress::function_1a1277c0b2dc47a6();
    stepnumber = 0;
    
    if ( isdefined( data.stepnumber ) )
    {
        stepnumber = int( data.stepnumber );
    }
    
    return [ "context", level.var_72750ad9b5ba32d4, "step_name", data.stepname, "step_number", stepnumber, "tutorial_type", "GAME", "tutorial_expertise", expertise, "mandatory_step", istrue( data.ismandatory ), "player_rank", rank, "automatic", istrue( data.isautomatic ), "ftue_version", "0.0.0", "progress_version", 0 ];
}

// Namespace ftue_telemetry
// Params 2, eflags: 0x4
// Checksum 0x991695ec, Offset: 0x5d1
// Size: 0x33
function private function_c1f2200f5f7bc95f( telemetryvalues, data )
{
    telemetryvalues[ telemetryvalues.size ] = "result";
    telemetryvalues[ telemetryvalues.size ] = data.result;
    return telemetryvalues;
}

// Namespace ftue_telemetry
// Params 1, eflags: 0x4
// Checksum 0x82970e9, Offset: 0x60d
// Size: 0x14
function private function_4fbc7ca864dd5047( matchid )
{
    return "ftue_match_" + matchid;
}

// Namespace ftue_telemetry
// Params 1
// Checksum 0xe2dea67, Offset: 0x62a
// Size: 0x34
function function_c2e3eef45c40fb05( step )
{
    telemetrydata = [ "initialization_step", step ];
    dlog_recordevent( "dlog_event_mobile_ftue_contextual_tips_initialization", telemetrydata );
}

