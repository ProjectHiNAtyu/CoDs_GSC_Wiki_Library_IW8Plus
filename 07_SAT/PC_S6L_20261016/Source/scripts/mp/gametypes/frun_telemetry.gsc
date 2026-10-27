// scripts\mp\gametypes\frun_telemetry.gsc  (hash_4d593e52458540f5.gscc) (size: 4197 Bytes / 0x1065 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbdaa4d43 (3182054723)
// size ...... 4197 (0x1065)
// includes .. 3   (offset: 0xeb1)
// strings ... 31  (offset: 0xec9)
// dev strs .. 0   (offset: 0x1065)
// exports ... 12  (offset: 0xa41)
// cseg ...... 0x3c9 + 0x678 (0xa41)
// imports ... 19  (offset: 0xc21)
// animtree1 . 0   (offset: 0x1065)
// animtree2 . 0   (offset: 0x1065)
#using script_76f51e444edfa58f;
#using scripts\common\utility;
#using scripts\mp\gametypes\frun_checkpoints;

#namespace frun_telemetry;

// Namespace frun_telemetry
// Params 0
// Checksum 0x60da41bd, Offset: 0x3e7
// Size: 0x2
function init()
{
    
}

// Namespace frun_telemetry
// Params 0
// Checksum 0xdddf5848, Offset: 0x3f1
// Size: 0xd
function function_3c3209794fe4047a()
{
    dlog_recordevent( "dlog_event_frun_match_race_finish", [] );
}

// Namespace frun_telemetry
// Params 0
// Checksum 0xa3164c59, Offset: 0x406
// Size: 0xd
function function_cda276c101c430d4()
{
    dlog_recordevent( "dlog_event_frun_match_race_start", [] );
}

// Namespace frun_telemetry
// Params 1
// Checksum 0xa7d0aeb7, Offset: 0x41b
// Size: 0x73
function function_7dfa050e71fb01c1( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    raceinfo = function_50787897a491fe12( player );
    controllerinfo = function_826c264e8715f874( player );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_frun_player_checkpoint_reached", [ "player_race_info", raceinfo, "player_control_info", controllerinfo ] );
}

// Namespace frun_telemetry
// Params 1
// Checksum 0x62b965b0, Offset: 0x496
// Size: 0x73
function function_254ea37e913e3c00( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    raceinfo = function_50787897a491fe12( player );
    controllerinfo = function_826c264e8715f874( player );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_frun_player_checkpoint_skip", [ "player_race_info", raceinfo, "player_control_info", controllerinfo ] );
}

// Namespace frun_telemetry
// Params 1
// Checksum 0x76c5013f, Offset: 0x511
// Size: 0x73
function function_560b21c5a425f69e( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    raceinfo = function_50787897a491fe12( player );
    controllerinfo = function_826c264e8715f874( player );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_frun_player_checkpoint_reset", [ "player_race_info", raceinfo, "player_control_info", controllerinfo ] );
}

// Namespace frun_telemetry
// Params 3
// Checksum 0x3c0268bf, Offset: 0x58c
// Size: 0xa3
function function_3bca9cbf30164638( player, var_7a8da02a977c0e3e, isfalldamage )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    raceinfo = function_50787897a491fe12( player );
    controllerinfo = function_826c264e8715f874( player );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_frun_player_race_fault", [ "player_race_info", raceinfo, "player_control_info", controllerinfo, "is_fall_damage_fault", isfalldamage, "is_out_of_bounds_fault", var_7a8da02a977c0e3e ] );
}

// Namespace frun_telemetry
// Params 1
// Checksum 0x9ebbe69c, Offset: 0x637
// Size: 0x94
function function_ae6206f684bbf151( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    raceinfo = function_50787897a491fe12( player );
    controllerinfo = function_826c264e8715f874( player );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    var_f3637b7c0f9d8aa5 = namespace_fcff552b98571df1::function_b02442a42a7c59d9( player );
    player dlog_recordplayerevent( "dlog_event_frun_player_race_finish", [ "player_race_info", raceinfo, "player_control_info", controllerinfo, "player_race_podium_rank", var_f3637b7c0f9d8aa5 ] );
}

// Namespace frun_telemetry
// Params 1
// Checksum 0xa5550517, Offset: 0x6d3
// Size: 0x73
function function_b90947072f2f81c1( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    raceinfo = function_50787897a491fe12( player );
    controllerinfo = function_826c264e8715f874( player );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_frun_player_race_quit", [ "player_race_info", raceinfo, "player_control_info", controllerinfo ] );
}

// Namespace frun_telemetry
// Params 1, eflags: 0x4
// Checksum 0x36df752d, Offset: 0x74e
// Size: 0x23e
function private function_50787897a491fe12( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    currentcheckpoint = player.freeruninfo.currentcheckpoint;
    var_f60e48c6e2569072 = namespace_fcff552b98571df1::function_5c97a2de0e27328a( player, currentcheckpoint );
    var_466eb15f4ce07107 = namespace_fcff552b98571df1::function_a3a4bf509f50b65e();
    var_92ed0deee13600b9 = namespace_fcff552b98571df1::function_99b4e6f99655aaf8( player );
    var_29848a444efafd39 = namespace_fcff552b98571df1::function_76ba268d368eed64( player );
    var_cd440bb3d916ab01 = namespace_fcff552b98571df1::function_dd9b2c9be9a1c678( player );
    var_43c7b617828f0b81 = namespace_fcff552b98571df1::function_96f81f582f42c16c( player );
    var_317786295ce4c7f = frun_checkpoints::function_998a0c9a3974ea3( player, currentcheckpoint.zoneindex );
    var_e54fdf152a7e7fbb = frun_checkpoints::function_a5c43a91dc8632ab( player, currentcheckpoint );
    raceinfo = [ "current_zone", currentcheckpoint.zoneindex ?? 0, "current_checkpoint", currentcheckpoint.checkpointindex ?? 0, "checkpoint_podium_rank", var_f60e48c6e2569072 ?? 0, "since_race_start_ms", var_466eb15f4ce07107 ?? 0, "since_activated_previous_checkpoint_ms", var_92ed0deee13600b9 ?? 0, "since_activated_current_checkpoint_ms", var_29848a444efafd39 ?? 0, "since_activated_previous_zone_ms", var_cd440bb3d916ab01 ?? 0, "since_activated_current_zone_ms", var_43c7b617828f0b81 ?? 0, "total_fault_count", player.freeruninfo.var_84b9cdcdd98678cb ?? 0, "checkpoint_fault_count", var_e54fdf152a7e7fbb ?? 0, "zone_fault_count", var_317786295ce4c7f ?? 0, "position_x", int( player.origin[ 0 ] ?? 0 ), "position_y", int( player.origin[ 1 ] ?? 0 ), "position_z", int( player.origin[ 2 ] ?? 0 ) ];
    return raceinfo;
}

// Namespace frun_telemetry
// Params 1, eflags: 0x4
// Checksum 0x406ddbf1, Offset: 0x995
// Size: 0xab
function private function_826c264e8715f874( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    iskbm = player function_a36eded60cdc3922() != 1;
    var_a00789bfded4bd82 = player utility::function_5cf1306d427dcc14();
    var_7ad960d0921c06fe = player utility::function_e1726295b259f0f8();
    var_f2a92d54e771a0b3 = player utility::function_86e14a9532d21558();
    var_f10916aac7e95657 = [ "control_scheme_is_kbm", iskbm, "auto_sprint_enabled", var_7ad960d0921c06fe, "auto_wall_jump_enabled", var_a00789bfded4bd82, "auto_mantle_enabled", var_f2a92d54e771a0b3 ];
    return var_f10916aac7e95657;
}

