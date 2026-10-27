// scripts\mp\ob\activities\locked_in\ob_activity_locked_in.gsc  (hash_166461b10fae200b.gscc) (size: 63814 Bytes / 0xf946 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x69759ebe (1769316030)
// size ...... 63814 (0xf946)
// includes .. 34  (offset: 0xe726)
// strings ... 110 (offset: 0xe836)
// dev strs .. 220 (offset: 0xee3a)
// exports ... 175 (offset: 0x9686)
// cseg ...... 0xad6 + 0x8bb0 (0x9686)
// imports ... 423 (offset: 0xb1de)
// animtree1 . 0   (offset: 0xf946)
// animtree2 . 0   (offset: 0xf946)
#using script_16ea1b94f0f381b3;
#using script_3455b106458253e7;
#using script_572da4be40f40273;
#using script_60cd1c57e94be8d7;
#using script_61b40095fd0502f0;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\hud_util;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\bots\bots;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\locked_in\ob_activity_locked_in_firewall;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\activities\ob_robot_charging;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_locked_in;

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x5
// Checksum 0xce9c946b, Offset: 0xaf4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_locked_in", #"activity_common", &function_2e8a5c986bf29933, undefined );
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x7840bd78, Offset: 0xb1d
// Size: 0x1a
function private function_2e8a5c986bf29933()
{
    init_block_walls();
    activity_common::registeractivitytype( "REV_OB_LOCKED_IN", &activity_init );
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x1f0ab37a, Offset: 0xb3f
// Size: 0x1a0
function private activity_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_LOCKED_IN", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_LOCKED_IN", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_LOCKED_IN", 2, &activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_LOCKED_IN", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_4b55ce0113456ec6, "REV_OB_LOCKED_IN" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &on_player_left_activity, "REV_OB_LOCKED_IN" );
    activity_common::function_2dd4f07fa5c3e911( "InstanceBegin", &function_48e49a495be3abc7 );
    level ob_activity_locked_in_firewall::firewall_setup();
    level._effect[ "locked_in_defend_guild_bots_area_circle_vfx" ] = loadfxasset( "vfx_sat_levels_wc_terminal_defence_circle" );
    level._effect[ "locked_in_onslaught_cradle_influence_vfx" ] = loadfxasset( "vfx_iw8_level_lab_halon_gas_screen" );
    namespace_a350a26c6d662a6a::function_910fedc165e15ba( "locked_in_onslaught", "heavy", %"sat_mp_sat_lm_avalon_ob_cradle_md_03", "locked_in_onslaught_cradle_influence_vfx" );
    utility::registersharedfunc( #"ob_activity_locked_in", #"hash_cb2779e19a817757", &function_8f129499fd06b5f5 );
    utility::registersharedfunc( #"ob_activity_locked_in", #"hash_3ca2423be7fff6d1", &function_49249e31d3699bb2 );
    utility::registersharedfunc( #"ob_activity_locked_in", #"hash_14be8027375a5e11", &function_517a6cf81ebb13a7 );
    level callback::add( #"player_death", &on_player_killed );
    level callback::add( #"player_spawned", &on_player_spawned );
    level callback::add( #"ob_locked_in_key_pickup", &function_b9a6d375f1b6bcce );
    level callback::add( #"hash_57e9466dae6341a5", &function_c08725d38632a74f );
    
    /#
        level thread init_devgui();
    #/
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x681ababb, Offset: 0xce7
// Size: 0x105
function private function_48e49a495be3abc7( relevant_info_struct )
{
    poi_activity_instance = self;
    
    if ( poi_activity_instance.type != "REV_OB_POI_BOSS" )
    {
        return;
    }
    
    foreach ( instance in level.activities.instances )
    {
        if ( instance.type == "REV_OB_LOCKED_IN" )
        {
            if ( function_1b4e6100adebc502( instance.varianttag, self ) )
            {
                if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
                {
                    logstring( "[LIKM] " + instance.varianttag + " is close since POI boss area overlapped (poi boss picked)" );
                }
                
                activity_instance_common::function_9aeeabe50fc9cc3e( instance );
            }
        }
    }
}

// Namespace ob_activity_locked_in
// Params 4, eflags: 0x44 variadic
// Checksum 0x6b3e0da9, Offset: 0xdf4
// Size: 0x10d
function private function_109126e93479d900( activity_info, callback, ... )
{
    if ( !activity_info )
    {
        return;
    }
    
    zones = activity_info.var_8339fb4f2d23dabf.zones;
    
    if ( !zones )
    {
        return;
    }
    
    zone = zones[ "OB_Spacer_Spatial_Zone" ];
    
    if ( !zone )
    {
        return;
    }
    
    spheres = zone.spheres;
    
    if ( !spheres.size )
    {
        return;
    }
    
    foreach ( var_913f4c7e63bf151f in spheres )
    {
        result = [[ callback ]]( var_913f4c7e63bf151f, flat_args( vararg, varargcount ) );
        
        if ( result )
        {
            return result;
        }
    }
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x625c8702, Offset: 0xf09
// Size: 0x87
function private function_b96b353f4af8458f( var_d235846313ec5774, var_bada048924c74c1c )
{
    locked_in_origin = var_d235846313ec5774.origin;
    locked_in_radius = var_d235846313ec5774.radius;
    poi_boss_origin = var_bada048924c74c1c.origin;
    poi_boss_radius = var_bada048924c74c1c.radius;
    var_afe6053c5ca68cf3 = distance2dsquared( locked_in_origin, poi_boss_origin ) <= squared( locked_in_radius + poi_boss_radius );
    return var_afe6053c5ca68cf3;
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x5f4af87f, Offset: 0xf99
// Size: 0x52
function private function_4c7b7d3884c85bc1( var_bada048924c74c1c, locked_in_variant_tag )
{
    var_39ef4021e7774e13 = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ locked_in_variant_tag ];
    var_afe6053c5ca68cf3 = function_109126e93479d900( var_39ef4021e7774e13, &function_b96b353f4af8458f, var_bada048924c74c1c );
    return var_afe6053c5ca68cf3;
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x82680742, Offset: 0xff4
// Size: 0x6e, Type: bool
function private function_1b4e6100adebc502( locked_in_variant_tag, poi_activity_instance )
{
    var_e3a87042e28d7e8d = poi_activity_instance.varianttag;
    var_bed4bbbcbeb1f36b = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ var_e3a87042e28d7e8d ];
    var_afe6053c5ca68cf3 = function_109126e93479d900( var_bed4bbbcbeb1f36b, &function_4c7b7d3884c85bc1, locked_in_variant_tag );
    
    if ( var_afe6053c5ca68cf3 )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x2e12a97d, Offset: 0x106b
// Size: 0x397
function private activity_setup()
{
    self endon( #"instance_destroyed" );
    wait 2;
    
    if ( level.var_a80ded1786689dd2.var_49b84de435120dab && level.var_a80ded1786689dd2.var_7f2933490dcf54f1 )
    {
        if ( function_1b4e6100adebc502( self.varianttag, level.var_a80ded1786689dd2.var_7f2933490dcf54f1 ) )
        {
            if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
            {
                logstring( "[LIKM] " + self.varianttag + " is closed since POI boss area overlapped (locked in setup)" );
            }
            
            activity_instance_common::function_9aeeabe50fc9cc3e( self );
            return;
        }
    }
    
    namespace_6677ae6d9a73bda::init();
    var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    self.participate_countdown_duration = var_91c91f4a631c481d.var_5e82df6821a816dd;
    self.firewall_health = var_91c91f4a631c481d.firewallhealth;
    self.firewall_time_limit = var_91c91f4a631c481d.firewalltimelimit;
    self.firewall_remain_percent_to_show_outline = var_91c91f4a631c481d.var_7696b3ca62afddef;
    self.firewall_activate_charging_bots_delay = var_91c91f4a631c481d.var_dcdaa1ea5f95827d;
    self.defend_duration = var_91c91f4a631c481d.defendduration;
    self.defend_time_limit = var_91c91f4a631c481d.var_affc87c6083b73d6;
    self.defend_activate_charging_bots_delay = var_91c91f4a631c481d.var_66599376a1505f29;
    self.defend_max_waves = var_91c91f4a631c481d.var_b745997856125732;
    self.defend_wave_interval = var_91c91f4a631c481d.var_8c2b977722a2da22;
    self.var_36410471a6704ff5 = function_d78d28cb4273392c( var_91c91f4a631c481d.defend_encounter_thresholds, "defend_encounter_thresholds" );
    self.onslaught_duration = var_91c91f4a631c481d.onslaughtduration;
    self.var_3d8d833baaca8b7c = function_d78d28cb4273392c( var_91c91f4a631c481d.onslaught_encounter_thresholds, "onslaught_encounter_thresholds" );
    
    if ( self.defend_time_limit < self.defend_duration )
    {
        assertmsg( "<dev string:x24>" );
        self.defend_time_limit = self.defend_duration;
    }
    
    self.defend_max_waves = maxint( self.defend_max_waves, 0 );
    
    if ( self.defend_max_waves > 0 )
    {
        if ( self.defend_wave_interval <= 0 )
        {
            assertmsg( "<dev string:x94>" + 10 + "<dev string:x10c>" );
            self.defend_wave_interval = 10;
        }
        
        latest_duration = self.defend_wave_interval * ( self.defend_max_waves - 1 );
        
        if ( latest_duration >= self.defend_duration )
        {
            assertmsg( "<dev string:x13a>" );
            activity_instance_common::function_9aeeabe50fc9cc3e( self );
            return;
        }
    }
    
    self.var_c4ba58fd936d79f1 = utility::getstruct( self.varianttag, "targetname" );
    self.difficulty_region = "difficulty5";
    
    if ( !function_e5e7bc16e51e1f49() )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    setup_sentry_turrets( self.var_c4ba58fd936d79f1 );
    setup_warning_blocks( self.var_c4ba58fd936d79f1 );
    utility::flag_wait( "ai_spawn_director_create_script_processed" );
    
    if ( !function_af596592dd4ce7cd( self.var_c4ba58fd936d79f1 ) )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    if ( !function_6554c926480d981a( self.var_c4ba58fd936d79f1 ) )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    if ( !function_b36f6e8670856539( self.var_c4ba58fd936d79f1 ) )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    if ( !function_91f08a0f88e59e31( self.var_c4ba58fd936d79f1 ) )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    if ( !setup_reward( self.var_c4ba58fd936d79f1 ) )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x1b4f6de6, Offset: 0x140a
// Size: 0x131
function private function_477932e3884ea1fd()
{
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    success = function_15b15a2f230344be( self.var_c4ba58fd936d79f1, self.s_terminal );
    
    if ( !success )
    {
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    self.var_475cbe2f555a96d8 = "locked_in_objective_location_" + self.varianttag;
    function_1c4c7ef874191be2( self.var_475cbe2f555a96d8, self.var_c4ba58fd936d79f1.origin, self.var_c4ba58fd936d79f1.radius );
    function_ce2ae0b5ea999e5c( self.defend_guild_bots_encounter_id, self.var_36410471a6704ff5 );
    function_ce2ae0b5ea999e5c( self.onslaught_encounter_id, self.var_3d8d833baaca8b7c );
    function_cddd40a03a3ae8d7();
    success = function_b3aee78e2d37f912( self.var_c4ba58fd936d79f1 );
    
    if ( !success )
    {
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    success = function_c7fefba328838dec();
    
    if ( !success )
    {
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    success = function_4cf9060b1a4be99c();
    function_2af2a87c5b8ac924();
    
    if ( success )
    {
        function_8280d9d39cb6f724();
    }
    
    activity_instance_common::endactivity( self, success );
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0xd7964603, Offset: 0x1543
// Size: 0x34
function private activity_end()
{
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        logstring( "[LIKM] " + self.varianttag + " end " );
    }
    
    activity_cleanup();
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x9e94c8de, Offset: 0x157f
// Size: 0x49
function private function_d4acef179eb9f9b2()
{
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        logstring( "[LIKM] " + self.varianttag + " destroy " );
    }
    
    activity_cleanup();
    function_1f2f96ccdec24c91();
    function_1606349019f9a7a9();
    function_39267c540074dea6();
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x73aca255, Offset: 0x15d0
// Size: 0x50
function private activity_cleanup()
{
    if ( self.var_475cbe2f555a96d8 )
    {
        function_71799ce2c69ce5a9( self.var_475cbe2f555a96d8 );
        self.var_475cbe2f555a96d8 = undefined;
    }
    
    function_2af2a87c5b8ac924();
    destroy_warning_blocks();
    function_73bb9adc0323aea1();
    function_eb1941453fd6a371();
    function_fa2ad8af010fa4cf();
    function_8542d4d2b8ba7707();
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x3921f368, Offset: 0x1628
// Size: 0x13c, Type: bool
function private function_af596592dd4ce7cd( var_c4ba58fd936d79f1 )
{
    s_terminal = var_c4ba58fd936d79f1 namespace_be3150865da9d2f1::get_linked_struct_filtered( "command_node_terminal", "script_noteworthy" );
    
    if ( !s_terminal )
    {
        assertmsg( "<dev string:x1b2>" + self.varianttag + "<dev string:x1db>" + "<dev string:x205>" + "<dev string:x21b>" );
        return false;
    }
    
    self.s_terminal = s_terminal;
    existed_terminals = getentitylessscriptablearray( undefined, undefined, s_terminal.origin, 100, #"terminal" );
    
    if ( existed_terminals.size )
    {
        terminal_scriptable = existed_terminals[ 0 ];
    }
    else
    {
        terminal_scriptable = function_ffb1b8b5420190fb( s_terminal.origin, s_terminal.angles );
    }
    
    terminal_scriptable setscriptablepartstate( #"terminal", #"usable" );
    terminal_scriptable.linked_activity_instance = self;
    s_terminal.terminal_scriptable = terminal_scriptable;
    s_terminal.var_5461ea430344e215 = function_648e919594e5e14d( s_terminal );
    
    if ( !function_80483fd89a7425c9( var_c4ba58fd936d79f1 ) )
    {
        return false;
    }
    
    if ( !setup_participate_area_info( var_c4ba58fd936d79f1 ) )
    {
        return false;
    }
    
    if ( !setup_participate_ai_encounter( s_terminal ) )
    {
        return false;
    }
    
    function_60d46d33607c2957( 0 );
    return true;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0xa68c2c4a, Offset: 0x176d
// Size: 0x138
function private function_8542d4d2b8ba7707()
{
    self.var_76cb6f8f45327ae1 = undefined;
    self.var_944574382a25d302 = undefined;
    function_d8cd8164557381e4( 0 );
    self.var_2bf434cae30601c5 = undefined;
    self.participate_trigger_volume = undefined;
    self.var_4ba1aa8d204d345c = undefined;
    
    if ( isdefined( self.s_terminal.var_5461ea430344e215 ) )
    {
        calloutmarkerping::function_73084f64fa34a5a8( self.s_terminal.var_5461ea430344e215 );
        namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.s_terminal.var_5461ea430344e215 );
        self.s_terminal.var_5461ea430344e215 = undefined;
    }
    
    function_cf8a053342eb515c( self.s_terminal );
    
    if ( self.s_terminal.terminal_scriptable )
    {
        self.s_terminal.terminal_scriptable setscriptablepartstate( #"terminal", #"hash_dbe231011bfa73f0" );
        self.s_terminal.terminal_scriptable notify( #"hash_2340fd93c4bb2c7c" );
        self.s_terminal.terminal_scriptable.linked_activity_instance = undefined;
        self.s_terminal.terminal_scriptable = undefined;
    }
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0xa2351c9d, Offset: 0x18ad
// Size: 0x4a
function private function_1606349019f9a7a9()
{
    if ( self.tactical_ability_case )
    {
        self.tactical_ability_case freescriptable();
        self.tactical_ability_case = undefined;
    }
    
    if ( self.super_ability_case )
    {
        self.super_ability_case freescriptable();
        self.super_ability_case = undefined;
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xf6fb6fb8, Offset: 0x18ff
// Size: 0x7d, Type: bool
function private function_80483fd89a7425c9( var_c4ba58fd936d79f1 )
{
    var_4ba1aa8d204d345c = var_c4ba58fd936d79f1 namespace_be3150865da9d2f1::get_linked_structs_filtered( "ability_case_drop_point", "script_noteworthy" );
    self.var_4ba1aa8d204d345c = var_4ba1aa8d204d345c;
    
    if ( !var_4ba1aa8d204d345c.size || var_4ba1aa8d204d345c.size < 2 )
    {
        assertmsg( "<dev string:x21d>" + self.varianttag + "<dev string:x25e>" + var_4ba1aa8d204d345c.size + "<dev string:x267>" + "<dev string:x2aa>" + "<dev string:x21b>" );
        return false;
    }
    
    return true;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xc7c8fb8e, Offset: 0x1985
// Size: 0x67, Type: bool
function private setup_participate_area_info( var_c4ba58fd936d79f1 )
{
    var_101bc5e990568fd3 = self.varianttag + "_PARTICIPATE_AREA";
    participate_areas = getnoentvolumearray( var_101bc5e990568fd3, #targetname );
    
    if ( !participate_areas.size )
    {
        assertmsg( "<dev string:x2c2>" + var_101bc5e990568fd3 );
        return false;
    }
    
    self.participate_trigger_volume = participate_areas[ 0 ];
    return true;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xfa9ae257, Offset: 0x19f5
// Size: 0x160, Type: bool
function private setup_participate_ai_encounter( s_terminal )
{
    /#
        if ( getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "<dev string:x308>" ), 0 ) )
        {
            return true;
        }
    #/
    
    var_985ebf5d547ca878 = self.varianttag + "_PARTICIPATE_ENCOUNTER";
    self.var_944574382a25d302 = activity_ai_encounters::function_92b671064b0b1ce2( var_985ebf5d547ca878, 0, 0, 1, 2 );
    
    if ( isdefined( self.var_944574382a25d302 ) )
    {
        ai_spawn_director::function_5c8b22954b3bfa37( self.var_944574382a25d302, &function_5b775fa6fe67ac6e, self );
        rein_goal_origin = s_terminal.origin;
        rein_goal_radius = s_terminal.var_bd0bcf1748163778 ? int( s_terminal.var_bd0bcf1748163778 ) : 500;
        var_b77be3de97ed3658 = s_terminal.var_4d433da9852c2079 ? int( s_terminal.var_4d433da9852c2079 ) : 80;
        ai_spawn_director::add_spawned_callback( self.var_944574382a25d302, &function_5617506f4880534b, [ self, rein_goal_origin, rein_goal_radius, var_b77be3de97ed3658 ] );
        ai_spawn_director::function_baa5d26d8804d5da( self.var_944574382a25d302, &function_34d5017e87d4a33d, [ self, rein_goal_origin, rein_goal_radius, var_b77be3de97ed3658 ] );
    }
    else
    {
        assertmsg( "<dev string:x326>" + var_985ebf5d547ca878 );
        return false;
    }
    
    return true;
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0xb04fd809, Offset: 0x1b5e
// Size: 0x260, Type: bool
function private function_15b15a2f230344be( var_c4ba58fd936d79f1, s_terminal )
{
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    
    /#
        thread function_737243439429b4fc( s_terminal.terminal_scriptable, "<dev string:x377>", self );
        thread function_177713a5d32d9225();
    #/
    
    register_active_terminal( s_terminal );
    self waittill( #"hash_843a7be69894608c" );
    function_cf8a053342eb515c( s_terminal );
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        logstring( "[LIKM] " + self.varianttag + " participate phase started" );
    }
    
    if ( !s_terminal )
    {
        assertmsg( "<dev string:x380>" + self.varianttag );
        return false;
    }
    
    function_60d46d33607c2957( 1 );
    calloutmarkerping::function_73084f64fa34a5a8( s_terminal.var_5461ea430344e215 );
    show_warning_blocks( 1 );
    function_6bfab4bb3adf3ff0();
    countdown = get_participate_countdown_duration();
    
    /#
        s_terminal.terminal_scriptable thread function_c03a43dfbbef7678( countdown, "<dev string:x3b1>" );
    #/
    
    var_4f676ac1aa69c28c = function_90a74999dbb7d91d( countdown );
    childthread function_912341bf1b6fa07( self.participate_trigger_volume );
    
    if ( getdvarint( @"hash_c2105dfb5c840eff", 0 ) )
    {
        /#
            utility::waittill_any_timeout( countdown, "<dev string:x3c6>" );
        #/
    }
    else
    {
        wait countdown;
    }
    
    self notify( #"hash_fb6df4dc89de4dc5" );
    ensure_participants( self.participate_trigger_volume, 1, 0 );
    var_498bc94516b0c26a = self.playerparticipants;
    show_warning_blocks( 0 );
    
    if ( var_498bc94516b0c26a.size == 0 )
    {
        function_c5d97378c723b5d9( var_4f676ac1aa69c28c );
        return false;
    }
    
    function_60d46d33607c2957( 2 );
    thread function_f1d0ece16271145e();
    function_d8cd8164557381e4( 1 );
    
    foreach ( player in var_498bc94516b0c26a )
    {
        player val::set( "ob_locked_in", "ascender_use", 0 );
        player val::set( "ob_locked_in", "vehicle_use", 0 );
        player.var_91afdcee12ba0c8b = 1;
    }
    
    return true;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x23a6f70, Offset: 0x1dc7
// Size: 0x2e
function private function_6bfab4bb3adf3ff0()
{
    if ( !isdefined( self.var_944574382a25d302 ) )
    {
        return;
    }
    
    activity_ai_encounters::function_48582991402cac50( self.var_944574382a25d302, 1 );
    self.var_76cb6f8f45327ae1 = 1;
}

// Namespace ob_activity_locked_in
// Params 3, eflags: 0x4
// Checksum 0x6615ffb2, Offset: 0x1dfd
// Size: 0x3f
function private function_5b775fa6fe67ac6e( request_id, user_data, var_62a6b384c0358219 )
{
    activity_instance = user_data;
    
    if ( !activity_instance )
    {
        return 0;
    }
    
    return activity_instance.var_76cb6f8f45327ae1;
}

// Namespace ob_activity_locked_in
// Params 4, eflags: 0x4
// Checksum 0xe2b9f7c8, Offset: 0x1e45
// Size: 0x111
function private function_5617506f4880534b( encounter_id, user_data, agent, var_23727b9f7278a780 )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent ob_humans::function_5bc0e59d126a6295( "difficulty5" );
    activity_instance = user_data[ 0 ];
    
    if ( !activity_instance )
    {
        return;
    }
    
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    agent.qsetgoalpos = 1;
    agent.disabledropfromcombat = 1;
    rein_goal_origin = user_data[ 1 ];
    rein_goal_radius = user_data[ 2 ];
    var_b77be3de97ed3658 = user_data[ 3 ];
    agent utility::ent_flag_wait( "stealth_enabled" );
    agent setstealthstate( "combat" );
    agent function_5c62b4d416b852ec( rein_goal_origin, rein_goal_radius, var_b77be3de97ed3658 );
    agent function_b8244c540aa8e664( rein_goal_origin, rein_goal_radius + 120 );
    agent namespace_6677ae6d9a73bda::function_20336f89f16f7bb8();
    agent.var_437f238159c83b57 = 1;
}

// Namespace ob_activity_locked_in
// Params 3, eflags: 0x4
// Checksum 0xfb48d513, Offset: 0x1f5e
// Size: 0xe5
function private function_34d5017e87d4a33d( encounter_id, user_data, agent )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    activity_instance = user_data[ 0 ];
    
    if ( !activity_instance )
    {
        return;
    }
    
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    rein_goal_origin = user_data[ 1 ];
    rein_goal_radius = user_data[ 2 ];
    var_b77be3de97ed3658 = user_data[ 3 ];
    agent ob_activity_utility::function_311417deee5b4c1c();
    waitframe();
    agent function_5c62b4d416b852ec( rein_goal_origin, rein_goal_radius, var_b77be3de97ed3658 );
    
    while ( true )
    {
        utility::waittill_notify_or_timeout( "goal", 45 );
        
        if ( self iswithinscriptgoalradius() )
        {
            break;
        }
    }
    
    agent.var_a2591b7b6a16fd5d = 0;
    agent function_b8244c540aa8e664( rein_goal_origin, rein_goal_radius + 120 );
}

// Namespace ob_activity_locked_in
// Params 3, eflags: 0x4
// Checksum 0x93320c67, Offset: 0x204b
// Size: 0x85
function private function_5c62b4d416b852ec( rein_goal_origin, rein_goal_radius, var_b77be3de97ed3658 )
{
    agent = self;
    
    if ( !( isdefined( agent.script_stealthgroup ) && isdefined( level.stealth.combat_volumes[ agent.script_stealthgroup ] ) ) )
    {
        goal_pos = getclosestpointonnavmesh( rein_goal_origin );
        agent.goalheight = var_b77be3de97ed3658;
        agent setgoalpos( goal_pos, rein_goal_radius );
    }
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x5e1f8b, Offset: 0x20d8
// Size: 0x3b
function private function_b8244c540aa8e664( origin, radius )
{
    agent = self;
    
    if ( !agent.isactive )
    {
        return;
    }
    
    agent function_fa32376aaa88a7a2( origin, radius );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x9f0b89df, Offset: 0x211b
// Size: 0x3c
function private function_912341bf1b6fa07( trigger )
{
    trigger endon( #"death" );
    self endon( #"hash_fb6df4dc89de4dc5" );
    
    while ( true )
    {
        ensure_participants( trigger, 0, 1 );
        wait 1;
    }
}

// Namespace ob_activity_locked_in
// Params 3, eflags: 0x4
// Checksum 0x20701b16, Offset: 0x215f
// Size: 0x120
function private ensure_participants( trigger, var_1f6d980d47cb1d5c, var_e7660497d639c797 )
{
    trigger endon( #"death" );
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        if ( !trigger )
        {
            return;
        }
        
        is_in = player istouching( trigger );
        
        if ( is_in && player::isreallyalive( player ) )
        {
            if ( !activity_participation::function_e7fc1202ac164928( self, player ) )
            {
                activity_participation::function_bc67362dace4370c( self, player );
            }
        }
        else if ( activity_participation::function_e7fc1202ac164928( self, player ) )
        {
            activity_participation::function_61aa2b2879f2c0a2( self, player );
            
            if ( var_1f6d980d47cb1d5c )
            {
            }
        }
        
        if ( var_e7660497d639c797 )
        {
            waitframe();
        }
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x77b02079, Offset: 0x2287
// Size: 0x42
function private function_d8cd8164557381e4( should_lock )
{
    if ( !self.var_2bf434cae30601c5 )
    {
        return;
    }
    
    if ( should_lock )
    {
        show_blocker( self.var_2bf434cae30601c5 );
        return;
    }
    
    hide_blocker( self.var_2bf434cae30601c5 );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x78544ef8, Offset: 0x22d1
// Size: 0x214
function private function_90a74999dbb7d91d( countdown )
{
    players = getplayersinradius( self.var_c4ba58fd936d79f1.origin, getdvarint( @"hash_fa725cb73c179b41", 50000 ), getdvarint( @"hash_3404e0016a3d3b8b", 60000 ) );
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        foreach ( p in level.players )
        {
            if ( arraycontains( players, p ) )
            {
                logstring( "[LIKM] announce player [" + p.name + "] " + self.varianttag + " will begin in " + countdown + " seconds" );
                continue;
            }
            
            distance = distance2d( p.origin, self.var_c4ba58fd936d79f1.origin );
            z_offset = abs( p.origin[ 2 ] - self.var_c4ba58fd936d79f1.origin[ 2 ] );
            in_radius = distance <= getdvarint( @"hash_fa725cb73c179b41", 50000 ) ? "true" : "false";
            in_z_offset = z_offset <= getdvarint( @"hash_3404e0016a3d3b8b", 60000 ) ? "true" : "false";
            logstring( "[LIKM] not announce " + p.name + " in_radius:" + in_radius + " in_z_offset:" + in_z_offset );
        }
    }
    
    activity_player_broadcasting::function_cb4750c84882dd07( "locked_in_will_lock_down", players );
    activity_definition_utils::function_a0a94881bc380bbf( 0, self );
    activity_definition_utils::updatetimer( countdown, self );
    return players;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x83eed6cf, Offset: 0x24ee
// Size: 0x87
function private function_c5d97378c723b5d9( var_4f676ac1aa69c28c )
{
    foreach ( player in var_4f676ac1aa69c28c )
    {
        player thread namespace_9d8e359c3b1041e5::showsplashsharedfunc( #"hash_91885e3912a6ab5" );
    }
}

// Namespace ob_activity_locked_in
// Params 4, eflags: 0x4
// Checksum 0x5847fe18, Offset: 0x257d
// Size: 0x86
function private function_ffb1b8b5420190fb( origin, angles, var_2bffe6b64e444906, var_af5a1f64ce1b5058 )
{
    scriptable = spawnscriptable( %"hash_3b3aa301c166993e", origin, angles );
    on_used_func = &function_f8d266d4ddd71ec8;
    hint_callback_func = &terminal_hint_callback;
    
    /#
        if ( var_2bffe6b64e444906 )
        {
            on_used_func = var_2bffe6b64e444906;
        }
        
        if ( var_af5a1f64ce1b5058 )
        {
            hint_callback_func = var_af5a1f64ce1b5058;
        }
    #/
    
    interaction::register_scriptable_interact( scriptable, on_used_func, undefined, undefined, hint_callback_func );
    return scriptable;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x8000946c, Offset: 0x260c
// Size: 0x87
function private function_f8d266d4ddd71ec8( player )
{
    if ( !self.linked_activity_instance )
    {
        return;
    }
    
    if ( !namespace_6677ae6d9a73bda::function_c55a70928f89278e( player ) )
    {
        return;
    }
    
    namespace_6677ae6d9a73bda::free_a_key( player );
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        logstring( "[LIKM] one key used" );
    }
    
    self setscriptablepartstate( #"terminal", #"unusable_planted" );
    activity_instance = self.linked_activity_instance;
    activity_instance notify( #"hash_843a7be69894608c", player );
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x7936b607, Offset: 0x269b
// Size: 0xa0
function private terminal_hint_callback( scriptable, player )
{
    if ( !player )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( !namespace_6677ae6d9a73bda::function_c55a70928f89278e( player ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_5e0cf05a7ba1cbc6", #type:"HINT_NOBUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_e3489595b23c507", #type:"HINT_BUTTON" };
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xc2067164, Offset: 0x2744
// Size: 0x169
function private function_60d46d33607c2957( new_state )
{
    if ( new_state != 0 && new_state != 1 && new_state != 2 )
    {
        assertmsg( "<dev string:x3ed>" + new_state );
        return;
    }
    
    if ( self.var_7dc199ddda6b1e41 == new_state )
    {
        return;
    }
    
    objidnum = self.s_terminal.var_5461ea430344e215;
    self.var_7dc199ddda6b1e41 = new_state;
    
    if ( self.var_7dc199ddda6b1e41 == 0 )
    {
        players = [];
        
        foreach ( player in level.players )
        {
            if ( namespace_6677ae6d9a73bda::function_c55a70928f89278e( player ) )
            {
                players[ players.size ] = player;
            }
        }
        
        if ( players.size )
        {
            function_84a63ab9da0808da( objidnum, 0, players );
        }
        
        return;
    }
    
    if ( self.var_7dc199ddda6b1e41 == 1 )
    {
        function_84a63ab9da0808da( objidnum, 1 );
        return;
    }
    
    if ( self.var_7dc199ddda6b1e41 == 2 )
    {
        var_498bc94516b0c26a = self.playerparticipants;
        function_84a63ab9da0808da( objidnum, 0, var_498bc94516b0c26a );
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x7dce0e2d, Offset: 0x28b5
// Size: 0x7f
function private function_648e919594e5e14d( s_terminal )
{
    var_5461ea430344e215 = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_locked_in_terminal", 0, 0 );
    objidpoolmanager::update_objective_position( var_5461ea430344e215, s_terminal.origin + ( 0, 0, 80 ) );
    objective_removeallfrommask( var_5461ea430344e215 );
    objective_showtoplayersinmask( var_5461ea430344e215 );
    hovercard_id = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hash_7ef196f6e42bfd6e" );
    function_3f1a6a0ae5901866( var_5461ea430344e215, hovercard_id );
    return var_5461ea430344e215;
}

// Namespace ob_activity_locked_in
// Params 3, eflags: 0x4
// Checksum 0xf15ce51b, Offset: 0x293d
// Size: 0x43
function private function_84a63ab9da0808da( var_5461ea430344e215, is_all_players, players_array )
{
    objective_removeallfrommask( var_5461ea430344e215 );
    
    if ( is_all_players )
    {
        objective_hidefromplayersinmask( var_5461ea430344e215 );
        return;
    }
    
    if ( !players_array )
    {
        return;
    }
    
    namespace_d7fa4530141146a5::function_7c5730b9151d91( players_array, var_5461ea430344e215 );
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0xf21f6cf2, Offset: 0x2988
// Size: 0x10f
function private function_f1d0ece16271145e()
{
    if ( !self.var_4ba1aa8d204d345c.size || self.var_4ba1aa8d204d345c.size < 2 )
    {
        assertmsg( "<dev string:x414>" + self.var_4ba1aa8d204d345c.size + "<dev string:x462>" );
        return;
    }
    
    points = arrayrandomize( self.var_4ba1aa8d204d345c );
    var_21c3b67f1a74cd8e = points[ 0 ].origin;
    drop_angles = points[ 0 ].angles;
    self.tactical_ability_case = utility::callsharedfunc( #"ability_case", #"spawn", var_21c3b67f1a74cd8e, "super_black_hat", undefined, #"tactical", drop_angles );
    var_21c3b67f1a74cd8e = points[ 1 ].origin;
    drop_angles = points[ 1 ].angles;
    self.super_ability_case = utility::callsharedfunc( #"ability_case", #"spawn", var_21c3b67f1a74cd8e, "super_vision_pulse", undefined, #"default", drop_angles );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xb6a18660, Offset: 0x2a9f
// Size: 0x1e
function private function_6554c926480d981a( var_c4ba58fd936d79f1 )
{
    self.firewalls_destroyed = 0;
    return setup_firewalls( var_c4ba58fd936d79f1 );
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0xd75be771, Offset: 0x2ac6
// Size: 0x23
function private function_fa2ad8af010fa4cf()
{
    self.var_e0c7b561c9a2bd58 = undefined;
    self.firewalls_destroyed = 0;
    ob_activity_locked_in_firewall::function_dae173aeb1a50001( &on_firewall_destroyed, self );
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0xc5abdd9e, Offset: 0x2af1
// Size: 0x9d
function private function_1f2f96ccdec24c91()
{
    foreach ( var_e39f05514bc5a668 in self.s_firewalls )
    {
        if ( var_e39f05514bc5a668.e_firewall )
        {
            var_e39f05514bc5a668.e_firewall ob_activity_locked_in_firewall::function_6670c8de4d0bed14();
            var_e39f05514bc5a668.e_firewall = undefined;
        }
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xca076d2d, Offset: 0x2b96
// Size: 0x2ee, Type: bool
function private setup_firewalls( var_c4ba58fd936d79f1 )
{
    if ( !var_c4ba58fd936d79f1 )
    {
        assertmsg( "<dev string:x479>" );
        return false;
    }
    
    var_6469c1e4d3ac4060 = var_c4ba58fd936d79f1 namespace_be3150865da9d2f1::get_linked_struct_filtered( "firewall_spawn_root", "script_noteworthy" );
    
    if ( !var_6469c1e4d3ac4060 )
    {
        assertmsg( "<dev string:x4bb>" + var_c4ba58fd936d79f1.targetname + "<dev string:x1db>" + "<dev string:x4fd>" );
        return false;
    }
    
    s_firewalls = var_6469c1e4d3ac4060 namespace_be3150865da9d2f1::get_linked_structs_filtered( "firewall_spawn", "script_noteworthy" );
    
    if ( !s_firewalls.size )
    {
        assertmsg( "<dev string:x511>" + var_6469c1e4d3ac4060.targetname + "<dev string:x54f>" + "<dev string:x578>" );
        return false;
    }
    
    var_a511e8b1685b11e0 = float( var_6469c1e4d3ac4060.var_235de1e35f60da4f ?? "1.0" );
    var_b7683ae503cabf6e = float( var_6469c1e4d3ac4060.var_5accfd2db39d41b7 ?? "1.0" );
    
    /#
        var_a511e8b1685b11e0 = getdvarfloat( @"hash_29d431a2bbcb5b79", var_a511e8b1685b11e0 );
        var_b7683ae503cabf6e = getdvarfloat( @"hash_ea80a77068d9eb41", var_b7683ae503cabf6e );
    #/
    
    var_c8a31dd39b2c1fd2 = int( ceil( var_a511e8b1685b11e0 * s_firewalls.size ) );
    
    if ( !var_c8a31dd39b2c1fd2 )
    {
        assertmsg( "<dev string:x587>" + self.varianttag + "<dev string:x5bc>" + s_firewalls.size + "<dev string:x5c6>" + var_a511e8b1685b11e0 + "<dev string:x5d2>" + var_c8a31dd39b2c1fd2 );
        return false;
    }
    
    var_3c8741fb2d93bbd8 = int( ceil( var_b7683ae503cabf6e * var_c8a31dd39b2c1fd2 ) );
    
    if ( !var_3c8741fb2d93bbd8 )
    {
        assertmsg( "<dev string:x5e7>" + self.varianttag + "<dev string:x5bc>" + var_c8a31dd39b2c1fd2 + "<dev string:x5c6>" + var_b7683ae503cabf6e + "<dev string:x5d2>" + var_3c8741fb2d93bbd8 );
        return false;
    }
    
    self.var_d622c8954bda1fee = var_3c8741fb2d93bbd8;
    self.s_firewalls = function_e956b562488e79cc( s_firewalls, var_c8a31dd39b2c1fd2 );
    
    foreach ( var_e39f05514bc5a668 in self.s_firewalls )
    {
        var_e39f05514bc5a668.health = get_firewall_health();
        var_e39f05514bc5a668.var_ff41aba15eadee14 = var_e39f05514bc5a668 namespace_be3150865da9d2f1::get_linked_structs_filtered( "drone_spawn", "script_noteworthy" );
        
        if ( !var_e39f05514bc5a668.var_ff41aba15eadee14.size )
        {
            iprintln( "WARNING! Locked In: [Step3] no drone spawn points found linked to " + var_e39f05514bc5a668.targetname + ". Link structs with script_noteworthy = " + "drone_spawn" + " and will use attacker or firewall entity as default spawn point" );
        }
        
        e_firewall = ob_activity_locked_in_firewall::function_37c842ffd11cc4a0( var_e39f05514bc5a668, self );
        var_e39f05514bc5a668.e_firewall = e_firewall;
    }
    
    ob_activity_locked_in_firewall::function_3369c062236b8a16( &on_firewall_destroyed, self );
    
    if ( !setup_firewall_guild_bots_encounter() )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x3732803f, Offset: 0x2e8d
// Size: 0x8d, Type: bool
function private setup_firewall_guild_bots_encounter()
{
    /#
        if ( getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "<dev string:x61d>" ), 0 ) )
        {
            return true;
        }
    #/
    
    var_9ce72ff40fef8071 = self.varianttag + "_FIREWALL_GUILD_BOTS_ENCOUNTER";
    self.var_e0c7b561c9a2bd58 = activity_ai_encounters::function_92b671064b0b1ce2( var_9ce72ff40fef8071, 1, 0, 1, 2 );
    
    if ( !isdefined( self.var_e0c7b561c9a2bd58 ) )
    {
        assertmsg( "<dev string:x638>" + var_9ce72ff40fef8071 );
        return false;
    }
    
    activity_ai_encounters::function_52d1342183200a8f( self.var_e0c7b561c9a2bd58, &function_19290580a65bd12d, self );
    return true;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x2d65d21b, Offset: 0x2f23
// Size: 0x301
function private function_b3aee78e2d37f912( var_c4ba58fd936d79f1 )
{
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        player_name_list = "";
        participants = self.playerparticipants;
        
        foreach ( player in participants )
        {
            player_name_list += player.name + ", ";
        }
        
        logstring( "[LIKM] " + self.varianttag + " firewall phase started, participants = " + player_name_list );
    }
    
    var_f160198685285947 = self.s_firewalls;
    required_count = self.var_d622c8954bda1fee;
    
    if ( required_count > var_f160198685285947.size )
    {
        assertmsg( "<dev string:x683>" + var_c4ba58fd936d79f1.center_index + "<dev string:x6cb>" + var_c4ba58fd936d79f1.name + "<dev string:x25e>" + var_f160198685285947.size + "<dev string:x6ce>" + required_count );
        return 0;
    }
    
    foreach ( var_e39f05514bc5a668 in var_f160198685285947 )
    {
        var_e39f05514bc5a668.e_firewall ob_activity_locked_in_firewall::activate_firewall();
    }
    
    time_limit_s = get_firewall_time_limit();
    function_f2740f124420874d( required_count, time_limit_s );
    activate_delay = get_firewall_activate_charging_bots_delay();
    childthread utility::delay_notify( activate_delay, "locked_in_active_bots_in_destroy_firewall_phase" );
    childthread function_f977542ee64ec7b6();
    
    /#
        players_debug_print( self.playerparticipants, "<dev string:x6da>" + required_count + "<dev string:x6e3>" );
    #/
    
    msg = utility::waittill_any_timeout( time_limit_s, "all_firewalls_destroyed" );
    self notify( #"hash_76b265873640b19" );
    activity_definition_utils::updatetimer( 0, self );
    
    foreach ( var_e39f05514bc5a668 in var_f160198685285947 )
    {
        if ( var_e39f05514bc5a668.e_firewall ob_activity_locked_in_firewall::is_firewall_activated() )
        {
            var_e39f05514bc5a668.e_firewall ob_activity_locked_in_firewall::function_8babea4f625910ad();
        }
    }
    
    if ( msg == "all_firewalls_destroyed" )
    {
        wait 1;
        return 1;
    }
    
    return 0;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0xc
// Checksum 0x635f8dee, Offset: 0x322c
// Size: 0x150
function private function_f977542ee64ec7b6()
{
    self notify( #"hash_e80e0bf6a2f117fc" );
    self endon( #"hash_e80e0bf6a2f117fc" );
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    self endon( #"hash_76b265873640b19" );
    percent = get_firewall_remain_percent_to_show_outline();
    required_count = int( ceil( percent * self.var_d622c8954bda1fee / 100 ) );
    
    while ( true )
    {
        self waittill( #"firewall_is_destroyed" );
        remain = self.var_d622c8954bda1fee - self.firewalls_destroyed;
        
        if ( remain <= 0 )
        {
            break;
        }
        
        if ( remain > required_count )
        {
            continue;
        }
        
        foreach ( var_e39f05514bc5a668 in self.s_firewalls )
        {
            if ( var_e39f05514bc5a668.e_firewall ob_activity_locked_in_firewall::is_firewall_activated() )
            {
                var_e39f05514bc5a668.e_firewall ob_activity_locked_in_firewall::show_outline( 1 );
            }
        }
        
        break;
    }
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x1487c198, Offset: 0x3384
// Size: 0xbf
function private on_firewall_destroyed( activity_instance, var_46159e2772b2df4 )
{
    if ( var_46159e2772b2df4 )
    {
        return;
    }
    
    required_count = activity_instance.var_d622c8954bda1fee;
    activity_instance.firewalls_destroyed++;
    activity_instance notify( #"firewall_is_destroyed" );
    
    /#
        players_debug_print( activity_instance.playerparticipants, "<dev string:x6f6>" + activity_instance.firewalls_destroyed + "<dev string:x702>" + required_count );
    #/
    
    var_cd5b89e2f1810ec2 = clampint( activity_instance.firewalls_destroyed, 0, required_count );
    activity_definition_utils::updateprogress( var_cd5b89e2f1810ec2, activity_instance, required_count );
    
    if ( activity_instance.firewalls_destroyed == required_count )
    {
        activity_instance notify( #"all_firewalls_destroyed" );
    }
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x535a5f61, Offset: 0x344b
// Size: 0x40
function private function_f2740f124420874d( var_3c8741fb2d93bbd8, time_limit_s )
{
    activity_player_broadcasting::function_cb4750c84882dd07( "locked_in_lock_down_begin" );
    activity_definition_utils::function_a0a94881bc380bbf( 1, self );
    activity_definition_utils::updatetimer( time_limit_s, self );
    activity_definition_utils::updateprogress( 0, self, var_3c8741fb2d93bbd8 );
}

// Namespace ob_activity_locked_in
// Params 4, eflags: 0x4
// Checksum 0x56feaa72, Offset: 0x3493
// Size: 0xb0
function private function_19290580a65bd12d( requestid, activity_instance, agent, data )
{
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    agent endon( #"death" );
    agent function_49f15c18129ee886( activity_instance );
    
    if ( agent.subclass == #"dawg" )
    {
        ob_activity_utility::setup_dawg_on_spawned( agent );
    }
    
    if ( data.waveindex == 0 )
    {
        if ( function_a8cd47747c30ec54( data.spawnfilter ) )
        {
            agent childthread ob_robot_charging::function_8e231efbddecc102();
            agent childthread function_b5c35a59377ebbcb( activity_instance );
        }
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x4d842a74, Offset: 0x354b
// Size: 0x40, Type: bool
function private function_a8cd47747c30ec54( spawn_filter )
{
    if ( !spawn_filter )
    {
        return false;
    }
    
    return spawn_filter == #"firewall_guild_bot_charging_pad" || spawn_filter == #"hash_121b7e36fa1c7ff6" || spawn_filter == #"firewall_dawg_charging_pad";
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xfe88b16c, Offset: 0x3594
// Size: 0x57
function private function_b5c35a59377ebbcb( activity_instance )
{
    agent = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    agent endon( #"death" );
    activity_instance waittill( #"locked_in_active_bots_in_destroy_firewall_phase" );
    agent thread ob_robot_charging::activate_robot();
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x63dd9ef7, Offset: 0x35f3
// Size: 0x9e
function private function_ecab317ff40c6631()
{
    var_f160198685285947 = self.s_firewalls;
    
    foreach ( var_e39f05514bc5a668 in var_f160198685285947 )
    {
        if ( var_e39f05514bc5a668.e_firewall )
        {
            var_e39f05514bc5a668.e_firewall ob_activity_locked_in_firewall::function_a08f109bc062fffe();
        }
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xa3009ec7, Offset: 0x3699
// Size: 0xd3, Type: bool
function private function_b36f6e8670856539( var_c4ba58fd936d79f1 )
{
    defend_struct = var_c4ba58fd936d79f1 namespace_be3150865da9d2f1::get_linked_struct_filtered( "defend_area", "script_noteworthy" );
    
    if ( !defend_struct )
    {
        assertmsg( "<dev string:x706>" + self.varianttag + "<dev string:x1db>" + "<dev string:x754>" );
        return false;
    }
    
    defend_radius = 300;
    self.defend_origin = defend_struct.origin;
    self.defend_radius = defend_radius;
    self.var_d02c5baaa35eb2ba = function_23ff11e6fbb03763( defend_struct );
    
    if ( !setup_defend_encounter() )
    {
        return false;
    }
    
    var_4927c4176c13e56e = defend_struct namespace_be3150865da9d2f1::get_linked_structs_filtered( "defend_dawg_spawn_info", "script_noteworthy" );
    
    if ( var_4927c4176c13e56e.size )
    {
        self.var_c1f21b313ef4d92e = make_defend_dawg_spawn_info( var_4927c4176c13e56e );
    }
    
    return true;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x8c875460, Offset: 0x3775
// Size: 0x114
function private function_23ff11e6fbb03763( defend_struct )
{
    var_f5db82daf16e64b6 = defend_struct.var_297c4a455dbf7232;
    
    if ( !var_f5db82daf16e64b6 )
    {
        assertmsg( "<dev string:x760>" + self.varianttag + "<dev string:x7a4>" + "<dev string:x754>" + "<dev string:x7d5>" );
        return;
    }
    
    waves_array = strtok( var_f5db82daf16e64b6, "," );
    
    if ( !waves_array )
    {
        assertmsg( "<dev string:x7ff>" + self.varianttag + "<dev string:x845>" );
        return;
    }
    
    waves_dict = [];
    count = 0;
    
    /#
        previous_index = undefined;
    #/
    
    for ( i = 0; i < waves_array.size ; i++ )
    {
        wave_index = int( waves_array[ i ] );
        waves_dict[ wave_index ] = count;
        count++;
        
        /#
            if ( isdefined( previous_index ) )
            {
                assert( previous_index < wave_index, "<dev string:x88e>" + self.varianttag + "<dev string:x8e2>" );
            }
            
            previous_index = wave_index;
        #/
    }
    
    return waves_dict;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x63270412, Offset: 0x3892
// Size: 0xc4, Type: bool
function private setup_defend_encounter()
{
    /#
        if ( getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "<dev string:x912>" ), 0 ) )
        {
            return true;
        }
    #/
    
    var_9ce72ff40fef8071 = self.varianttag + "_DEFEND_GUILD_BOTS_ENCOUNTER";
    self.defend_guild_bots_encounter_id = activity_ai_encounters::function_92b671064b0b1ce2( var_9ce72ff40fef8071, 1, 0, 1, 2 );
    
    if ( !isdefined( self.defend_guild_bots_encounter_id ) )
    {
        assertmsg( "<dev string:x92b>" + var_9ce72ff40fef8071 );
        return false;
    }
    
    ai_spawn_director::function_5c8b22954b3bfa37( self.defend_guild_bots_encounter_id, &function_342e07a393a6caad, self );
    var_5dc298dfb5cfa8c5 = get_defend_max_waves();
    self.var_24e6b84b230d5fff = function_5e846601bd279333( var_5dc298dfb5cfa8c5 );
    activity_ai_encounters::function_52d1342183200a8f( self.defend_guild_bots_encounter_id, &function_612280a537022e31, self );
    return true;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x914d3127, Offset: 0x395f
// Size: 0xcc
function private function_5e846601bd279333( max_waves )
{
    var_181baa8e4bba4017 = [];
    
    for ( wave_index = 0; wave_index < max_waves ; wave_index++ )
    {
        foreach ( prefix in [ #"hash_783e4dd8d133ee9e", #"hash_16a6dd1ed0b8d89b", #"hash_f3c4931fba54e4ee" ] )
        {
            var_181baa8e4bba4017[ hashcat( prefix, wave_index ) ] = wave_index;
        }
    }
    
    return var_181baa8e4bba4017;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xb5da8bc6, Offset: 0x3a34
// Size: 0x13e
function private make_defend_dawg_spawn_info( var_4927c4176c13e56e )
{
    var_7552482be5f95dde = [];
    
    foreach ( s_spawn_info in var_4927c4176c13e56e )
    {
        origin = s_spawn_info.origin;
        angles = s_spawn_info.angles;
        wave_index = s_spawn_info.var_79b7c655ce049d61;
        
        if ( wave_index )
        {
            i_wave_index = int( wave_index );
            
            if ( !isdefined( var_7552482be5f95dde[ i_wave_index ] ) )
            {
                var_7552482be5f95dde[ i_wave_index ] = [];
            }
            
            spawn_info = { #angles:angles, #origin:origin };
            var_7552482be5f95dde[ i_wave_index ][ var_7552482be5f95dde[ i_wave_index ].size ] = spawn_info;
            continue;
        }
        
        assertmsg( "<dev string:x974>" + s_spawn_info.targetname + "<dev string:x9dc>" + "<dev string:xa0e>" + "<dev string:xa25>" );
    }
    
    return var_7552482be5f95dde;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0xa7b226fb, Offset: 0x3b7b
// Size: 0x109
function private function_eb1941453fd6a371()
{
    self.defend_guild_bots_encounter_id = undefined;
    destroy_circle( self.var_73287bf7e8430e6 );
    self.var_73287bf7e8430e6 = undefined;
    function_bbad547a7d6c9fbd( self.var_ccccfcce7fb2be71 );
    self.var_ccccfcce7fb2be71 = undefined;
    self.defend_origin = undefined;
    self.defend_radius = undefined;
    self.var_24e6b84b230d5fff = undefined;
    self.var_e4d43105b27fe7a7 = undefined;
    self.var_d02c5baaa35eb2ba = undefined;
    self.var_c1f21b313ef4d92e = undefined;
    
    if ( self.var_e3f985ebf17c9623 )
    {
        foreach ( fake_owner in self.var_e3f985ebf17c9623 )
        {
            fake_owner delete();
        }
        
        self.var_e3f985ebf17c9623 = undefined;
    }
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x5018144f, Offset: 0x3c8c
// Size: 0x23a, Type: bool
function private function_c7fefba328838dec()
{
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        player_name_list = "";
        participants = self.playerparticipants;
        
        foreach ( player in participants )
        {
            player_name_list += player.name + ", ";
        }
        
        logstring( "[LIKM] " + self.varianttag + " defend phase started, participants = " + player_name_list );
    }
    
    defend_radius = self.defend_radius;
    
    if ( !defend_radius )
    {
        assertmsg( "<dev string:xa55>" + self.varianttag );
        return false;
    }
    
    defend_origin = self.defend_origin;
    
    if ( !defend_origin )
    {
        assertmsg( "<dev string:xa89>" + self.varianttag );
        return false;
    }
    
    time_limit_s = get_defend_time_limit();
    function_dcb4d9306bb49a94( time_limit_s );
    function_ecab317ff40c6631();
    function_5ee902f9f80e756d();
    self.var_ccccfcce7fb2be71 = function_d66c6e5d3ecbe9fe( defend_origin );
    self.var_73287bf7e8430e6 = create_circle( defend_origin, defend_radius, 0, "neutral", self.playerparticipants );
    childthread function_9d7f7420110d9ec();
    thread function_9f07166f173b67a4( defend_origin, defend_radius );
    msg = utility::waittill_any_timeout( time_limit_s, "locked_in_defend_success" );
    self notify( #"hash_af054e194ea298ba" );
    destroy_circle( self.var_73287bf7e8430e6 );
    self.var_73287bf7e8430e6 = undefined;
    function_bbad547a7d6c9fbd( self.var_ccccfcce7fb2be71 );
    self.var_ccccfcce7fb2be71 = undefined;
    activity_definition_utils::updatetimer( 0, self );
    
    if ( msg != "locked_in_defend_success" )
    {
        return false;
    }
    
    if ( self.playerparticipants.size == 0 )
    {
        return false;
    }
    
    wait 1;
    return true;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xe61daa0a, Offset: 0x3ecf
// Size: 0x37
function private function_dcb4d9306bb49a94( time_limit_s )
{
    activity_player_broadcasting::function_cb4750c84882dd07( "locked_in_defend_begin" );
    activity_definition_utils::function_a0a94881bc380bbf( 2, self );
    activity_definition_utils::updatetimer( time_limit_s, self );
    activity_definition_utils::updateprogress( 0, self, 1 );
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0xc
// Checksum 0x43a63d64, Offset: 0x3f0e
// Size: 0x18f
function private function_9f07166f173b67a4( defend_origin, defend_radius )
{
    self notify( #"hash_4970106344c4d369" );
    self endon( #"hash_4970106344c4d369" );
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    self endon( #"hash_af054e194ea298ba" );
    
    /#
        thread debug_draw_circle( defend_origin, defend_radius, ( 1, 0.5, 0 ), [ "<dev string:xabd>" ] );
    #/
    
    required_duration = get_defend_duration();
    defend_duration = 0;
    self.var_e4d43105b27fe7a7 = 0;
    function_232f96045fc89279( self.var_e4d43105b27fe7a7 );
    
    while ( defend_duration < required_duration )
    {
        wait 1;
        
        if ( !function_8da693c7cdade740( defend_origin, defend_radius ) )
        {
            continue;
        }
        
        defend_duration++;
        
        if ( self.var_e4d43105b27fe7a7 + 1 < get_defend_max_waves() )
        {
            threshold = ( self.var_e4d43105b27fe7a7 + 1 ) * get_defend_wave_interval();
            
            if ( defend_duration >= threshold )
            {
                self.var_e4d43105b27fe7a7++;
                function_232f96045fc89279( self.var_e4d43105b27fe7a7 );
            }
        }
        
        var_f262e1407e048b77 = clampint( defend_duration, 0, required_duration );
        i_percent = int( var_f262e1407e048b77 / required_duration * 100 );
        activity_definition_utils::updateprogress( i_percent, self, 100 );
        
        /#
            remain = required_duration - var_f262e1407e048b77;
            players_debug_print( self.playerparticipants, "<dev string:xacc>" + remain + "<dev string:xad3>" );
        #/
    }
    
    self notify( #"locked_in_defend_success" );
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0xc5746d8f, Offset: 0x40a5
// Size: 0xb6, Type: bool
function private function_8da693c7cdade740( center_origin, radius )
{
    players_in_radius = getplayersinradius( center_origin, radius, 180, 1 );
    
    foreach ( player in players_in_radius )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !activity_participation::function_e7fc1202ac164928( self, player ) )
        {
            continue;
        }
        
        return true;
    }
    
    return false;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xc4aaf4d5, Offset: 0x4164
// Size: 0x95
function private function_ffbbcdd2f2eafadd( player_list )
{
    if ( !self.var_73287bf7e8430e6 )
    {
        return;
    }
    
    foreach ( player in player_list )
    {
        self.var_73287bf7e8430e6 game_utility::questcircle_hidefromplayer( player );
    }
}

// Namespace ob_activity_locked_in
// Params 3, eflags: 0x4
// Checksum 0x55a458bd, Offset: 0x4201
// Size: 0x50, Type: bool
function private function_342e07a393a6caad( request_id, user_data, var_62a6b384c0358219 )
{
    activity_instance = user_data;
    
    if ( !activity_instance )
    {
        return false;
    }
    
    should_reinforce = activity_instance function_8d20309c2c9ecce9( var_62a6b384c0358219 );
    
    if ( should_reinforce )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x6984f1b7, Offset: 0x425a
// Size: 0x25
function private function_232f96045fc89279( wave_index )
{
    self notify( "locked_in_defend_wave_begin_" + wave_index );
    self notify( #"hash_7177a3671e4c9047", wave_index );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x32ba2a3f, Offset: 0x4287
// Size: 0x58, Type: bool
function private function_8d20309c2c9ecce9( wave_index )
{
    if ( !isdefined( self.var_e4d43105b27fe7a7 ) )
    {
        return false;
    }
    
    if ( self.var_d02c5baaa35eb2ba )
    {
        var_4eae9f4b78c4317b = self.var_d02c5baaa35eb2ba[ self.var_e4d43105b27fe7a7 ];
        return ( wave_index == var_4eae9f4b78c4317b );
    }
    
    return self.var_e4d43105b27fe7a7 == wave_index;
}

// Namespace ob_activity_locked_in
// Params 4, eflags: 0x4
// Checksum 0x9ff9a014, Offset: 0x42e8
// Size: 0xbe
function private function_612280a537022e31( requestid, activity_instance, agent, data )
{
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    agent endon( #"death" );
    agent function_49f15c18129ee886( activity_instance );
    
    if ( agent.subclass == "dawg" )
    {
        ob_activity_utility::setup_dawg_on_spawned( agent );
    }
    
    if ( data.waveindex == 0 )
    {
        wave_index = activity_instance function_cac85509d0bc8f40( data.spawnfilter );
        
        if ( isdefined( wave_index ) )
        {
            agent childthread ob_robot_charging::function_8e231efbddecc102();
            agent childthread function_fb069316a231df9b( activity_instance, wave_index );
        }
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xbf14ac62, Offset: 0x43ae
// Size: 0x1f
function private function_cac85509d0bc8f40( spawn_filter )
{
    if ( !spawn_filter )
    {
        return;
    }
    
    return self.var_24e6b84b230d5fff[ spawn_filter ];
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0xfd703816, Offset: 0x43d6
// Size: 0x74
function private function_fb069316a231df9b( activity_instance, wave_index )
{
    agent = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    agent endon( #"death" );
    activity_instance waittill( "locked_in_defend_wave_begin_" + wave_index );
    activate_delay = activity_instance get_defend_activate_charging_bots_delay();
    wait activate_delay;
    agent thread ob_robot_charging::activate_robot();
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0xc
// Checksum 0x522d1621, Offset: 0x4452
// Size: 0x13d
function private function_9d7f7420110d9ec()
{
    self notify( #"hash_bd2406f14edfbed3" );
    self endon( #"hash_bd2406f14edfbed3" );
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    self endon( #"hash_af054e194ea298ba" );
    level endon( #"game_ended" );
    
    if ( !self.var_c1f21b313ef4d92e )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"hash_7177a3671e4c9047", wave_index );
        
        if ( !self.var_c1f21b313ef4d92e[ wave_index ] )
        {
            continue;
        }
        
        spawn_infos = self.var_c1f21b313ef4d92e[ wave_index ];
        
        foreach ( spawn_info in spawn_infos )
        {
            origin = spawn_info.origin;
            angles = spawn_info.angles;
            thread function_e3f2f06ad33c284( origin, angles );
        }
    }
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x46e0f4db, Offset: 0x4597
// Size: 0x88
function private function_e3f2f06ad33c284( spawn_point, spawn_angles )
{
    self endon( #"hash_af054e194ea298ba" );
    
    if ( !isdefined( self.var_e3f985ebf17c9623 ) )
    {
        self.var_e3f985ebf17c9623 = [];
    }
    
    fake_owner = ob_activity_utility::ob_create_trap_owner( spawn_point );
    fake_owner.var_6b368a0a50a424c5 = 1;
    fake_owner endon( #"death" );
    self.var_e3f985ebf17c9623[ self.var_e3f985ebf17c9623.size ] = fake_owner;
    ob_activity_utility::function_ded5fcf7673a2ae6( fake_owner, spawn_point, spawn_angles );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x200087d2, Offset: 0x4627
// Size: 0x50
function private function_d66c6e5d3ecbe9fe( defend_area_origin )
{
    if ( !self.playerparticipants.size )
    {
        return;
    }
    
    var_fcdb838fe60a71d9 = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_locked_in_defend_area", 0, 1 );
    objidpoolmanager::update_objective_position( var_fcdb838fe60a71d9, defend_area_origin + ( 0, 0, 80 ) );
    return var_fcdb838fe60a71d9;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x6ab834e1, Offset: 0x4680
// Size: 0x1d
function private function_bbad547a7d6c9fbd( var_fcdb838fe60a71d9 )
{
    if ( !isdefined( var_fcdb838fe60a71d9 ) )
    {
        return;
    }
    
    namespace_d7fa4530141146a5::function_501e44ea1cb9219d( var_fcdb838fe60a71d9 );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x4d8fd317, Offset: 0x46a5
// Size: 0xbb, Type: bool
function private function_91f08a0f88e59e31( var_c4ba58fd936d79f1 )
{
    /#
        if ( getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "<dev string:xad5>" ), 0 ) )
        {
            return true;
        }
    #/
    
    self.var_26d9f196913c7273 = undefined;
    encounter_targetname = self.varianttag + "_ONSLAUGHT_ENCOUNTER";
    self.onslaught_encounter_id = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 0, 0, 1, 2 );
    
    if ( !isdefined( self.onslaught_encounter_id ) )
    {
        assertmsg( "<dev string:xaf1>" + encounter_targetname );
        return false;
    }
    
    activity_ai_encounters::function_d33de057e760c97b( self.onslaught_encounter_id, &function_c94915425d7baaca, [ self ] );
    activity_ai_encounters::function_52d1342183200a8f( self.onslaught_encounter_id, &function_91ee5c7f5c92ba24, self );
    return true;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x5bba5af8, Offset: 0x4769
// Size: 0x1d
function private function_73bb9adc0323aea1()
{
    self.onslaught_encounter_id = undefined;
    self.var_26d9f196913c7273 = undefined;
    function_c32dd0c5eab60008();
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x7b59de45, Offset: 0x478e
// Size: 0x1eb, Type: bool
function private function_4cf9060b1a4be99c()
{
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        player_name_list = "";
        participants = self.playerparticipants;
        
        foreach ( player in participants )
        {
            player_name_list += player.name + ", ";
        }
        
        logstring( "[LIKM] " + self.varianttag + " onslaught phase started, participants = " + player_name_list );
    }
    
    function_5fdb746c41a5fa79();
    
    if ( isdefined( self.onslaught_encounter_id ) )
    {
        activity_ai_encounters::function_48582991402cac50( self.onslaught_encounter_id, 1 );
    }
    
    survive_time = get_onslaught_duration();
    
    /#
        players_debug_print( self.playerparticipants, "<dev string:xb32>" + survive_time + "<dev string:xb4d>" );
    #/
    
    activity_definition_utils::updatetimer( survive_time, self );
    
    if ( getdvarint( @"hash_c2105dfb5c840eff", 0 ) )
    {
        /#
            utility::waittill_any_timeout( survive_time, "<dev string:xb50>" );
        #/
    }
    else
    {
        wait survive_time;
    }
    
    self notify( #"locked_in_onslaught_completed" );
    self.var_26d9f196913c7273 = 1;
    
    if ( self.s_terminal.terminal_scriptable )
    {
        self.s_terminal.terminal_scriptable setscriptablepartstate( #"terminal", #"unusable_destroyed" );
    }
    
    childthread function_b0fcfc5c810260ba( 1 );
    childthread function_f36b1d8b1ef9fcac();
    function_8ed9429f96ca0822( self.playerparticipants );
    return true;
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x21375215, Offset: 0x4982
// Size: 0x36, Type: bool
function private function_c94915425d7baaca( requestid, user_data )
{
    activity_instance = user_data[ 0 ];
    
    if ( activity_instance.var_26d9f196913c7273 )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_activity_locked_in
// Params 4, eflags: 0x4
// Checksum 0x4574e9f5, Offset: 0x49c1
// Size: 0x31
function private function_91ee5c7f5c92ba24( requestid, activity_instance, agent, data )
{
    agent function_49f15c18129ee886( activity_instance );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0xc
// Checksum 0xe124e608, Offset: 0x49fa
// Size: 0x18f
function private function_b0fcfc5c810260ba( delay = 0 )
{
    self notify( #"hash_7d4499ab49b7078e" );
    self endon( #"hash_7d4499ab49b7078e" );
    level endon( #"game_ended" );
    
    if ( delay )
    {
        wait delay;
    }
    
    function_39267c540074dea6();
    function_b9ba7e08f677f663( self.var_944574382a25d302 );
    function_b9ba7e08f677f663( self.var_e0c7b561c9a2bd58 );
    function_b9ba7e08f677f663( self.defend_guild_bots_encounter_id );
    
    if ( self.var_e3f985ebf17c9623 )
    {
        foreach ( fake_owner in self.var_e3f985ebf17c9623 )
        {
            if ( !fake_owner.dawglist )
            {
                continue;
            }
            
            foreach ( dawg in fake_owner.dawglist )
            {
                dawg dawg::dawg_self_destruct();
            }
            
            fake_owner delete();
        }
        
        self.var_e3f985ebf17c9623 = undefined;
    }
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0xc
// Checksum 0xe7cbfad0, Offset: 0x4b91
// Size: 0x111
function private function_f36b1d8b1ef9fcac()
{
    self notify( #"hash_767529b210551bea" );
    self endon( #"hash_767529b210551bea" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.onslaught_encounter_id ) )
    {
        return;
    }
    
    if ( !activity_ai_encounters::function_e9bac21ccee7cf24( self.onslaught_encounter_id ) )
    {
        return;
    }
    
    data = function_9b649316adcccbaa( self.onslaught_encounter_id );
    
    foreach ( agent in data.ai )
    {
        if ( !isalive( agent ) )
        {
            continue;
        }
        
        agent val::set( "locked_in_agent", "ignoreall", 1 );
    }
    
    self waittill( #"locked_in_onslaught_kill_bots" );
    function_b9ba7e08f677f663( self.onslaught_encounter_id );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x87771340, Offset: 0x4caa
// Size: 0xc2
function private function_b9ba7e08f677f663( ai_encounter_id )
{
    if ( !isdefined( ai_encounter_id ) )
    {
        return;
    }
    
    if ( !activity_ai_encounters::function_e9bac21ccee7cf24( ai_encounter_id ) )
    {
        return;
    }
    
    data = function_9b649316adcccbaa( ai_encounter_id );
    
    foreach ( agent in data.ai )
    {
        if ( !isalive( agent ) )
        {
            continue;
        }
        
        agent thread function_a041a54f40b7dc8a();
    }
    
    activity_ai_encounters::function_1010ba035d94f9f1( ai_encounter_id );
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x9e5e4927, Offset: 0x4d74
// Size: 0x5c
function private function_a041a54f40b7dc8a()
{
    self endon( #"death" );
    self.var_a13bed1ac47e1b2c = 1;
    self.dropweapon = 0;
    self.nodrop = 1;
    val::set( "locked_in_agent", "ignoreall", 1 );
    var_68d856e9730bd509 = randomfloat( 2 );
    wait var_68d856e9730bd509;
    self kill();
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x2aca1435, Offset: 0x4dd8
// Size: 0x23
function private function_5fdb746c41a5fa79()
{
    activity_player_broadcasting::function_cb4750c84882dd07( "locked_in_survive_onslaught" );
    activity_definition_utils::function_a0a94881bc380bbf( 3, self );
    activity_definition_utils::updateprogress( 0, self, 1 );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0xc
// Checksum 0x67ebd21b, Offset: 0x4e03
// Size: 0x130
function private function_8ed9429f96ca0822( players )
{
    self notify( #"hash_218eabc8aa8b07b8" );
    self endon( #"hash_218eabc8aa8b07b8" );
    
    if ( !players.size )
    {
        return;
    }
    
    ui_show_delay = 2;
    ui_show_duration = 1;
    ui_hide_delay = 2;
    ui_hide_duration = 3;
    var_5add1da6fc6fea9a = 0;
    kill_bots_delay = ui_show_delay + ui_show_duration + ui_hide_delay + ui_hide_duration * 0.5 - 2;
    childthread utility::delay_notify( kill_bots_delay, "locked_in_onslaught_kill_bots" );
    function_7c65635f46b20436( players, 0, ui_show_delay, ui_show_duration, ui_hide_delay, ui_hide_duration, var_5add1da6fc6fea9a );
    
    if ( players.size )
    {
        foreach ( player in players )
        {
            player.var_dffd7a708f1095d9 = 0;
            player hud_util::function_e71c430005379a39( "locked_in_onslaught_custom_overlay" );
        }
    }
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0xc6bdfb8f, Offset: 0x4f3b
// Size: 0xb5
function private function_c32dd0c5eab60008()
{
    self notify( #"hash_892ba6fee6dbd1b" );
    
    foreach ( player in level.players )
    {
        if ( player.var_dffd7a708f1095d9 )
        {
            namespace_a350a26c6d662a6a::function_df8118cc37c9e245( player, "locked_in_onslaught" );
            player hud_util::function_e71c430005379a39( "locked_in_onslaught_custom_overlay" );
            player.var_dffd7a708f1095d9 = 0;
        }
    }
}

// Namespace ob_activity_locked_in
// Params 7, eflags: 0xc
// Checksum 0xc43bebef, Offset: 0x4ff8
// Size: 0x21e
function private function_7c65635f46b20436( players, is_in, ui_show_delay = 0, ui_show_duration = 3, ui_hide_delay = 0, ui_hide_duration = 2, var_5add1da6fc6fea9a = 0 )
{
    self notify( #"hash_869888ffba9a35d0" );
    self endon( #"hash_869888ffba9a35d0" );
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    self endon( #"hash_892ba6fee6dbd1b" );
    sfx_duration = ui_show_delay + ui_show_duration + ui_hide_delay + ui_hide_duration + var_5add1da6fc6fea9a;
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "locked_in_onslaught", sfx_duration, undefined, players );
    
    if ( ui_show_delay )
    {
        wait ui_show_delay;
    }
    
    if ( players.size )
    {
        foreach ( player in players )
        {
            player giveandfireoffhand( "sat_ob_activity_crash_site_blast_start" );
            player hud_util::function_a7b5c7ac6074b623( "locked_in_onslaught_custom_overlay", "white", ( 0.9, 0.95, 1 ) );
            player thread hud_util::fade_out( ui_show_duration, "locked_in_onslaught_custom_overlay" );
        }
        
        if ( ui_show_duration )
        {
            wait ui_show_duration;
        }
    }
    else
    {
        return;
    }
    
    if ( ui_hide_delay )
    {
        wait ui_hide_delay;
    }
    
    if ( players.size )
    {
        foreach ( player in players )
        {
            player thread hud_util::fade_in( ui_hide_duration, "locked_in_onslaught_custom_overlay" );
        }
        
        if ( ui_hide_duration )
        {
            wait ui_hide_duration;
        }
    }
    else
    {
        return;
    }
    
    if ( var_5add1da6fc6fea9a )
    {
        wait var_5add1da6fc6fea9a;
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xa806c9d0, Offset: 0x521e
// Size: 0xc1
function private function_4b55ce0113456ec6( params )
{
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        player_list = params.playerlist;
        
        foreach ( player in player_list )
        {
            logstring( "[LIKM] " + player.name + " joined " + self.varianttag );
        }
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xe8308077, Offset: 0x52e7
// Size: 0x184
function private on_player_left_activity( params )
{
    player_list = params.playerlist;
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        foreach ( player in player_list )
        {
            logstring( "[LIKM] " + player.name + " left " + self.varianttag );
        }
    }
    
    function_ffbbcdd2f2eafadd( player_list );
    
    foreach ( player in player_list )
    {
        if ( player.var_91afdcee12ba0c8b )
        {
            player val::reset_all( "ob_locked_in" );
            player.var_91afdcee12ba0c8b = undefined;
        }
    }
    
    if ( self.playerparticipants.size == 0 )
    {
        if ( self.var_f59e42cdd69d83f3 )
        {
            /#
                if ( self.var_a06dd70584727039 )
                {
                    return;
                }
            #/
            
            activity_instance_common::endactivity( self, 0 );
        }
    }
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x2dd2c703, Offset: 0x5473
// Size: 0xd
function private function_cddd40a03a3ae8d7()
{
    self.var_f59e42cdd69d83f3 = 1;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x86f8c7f4, Offset: 0x5488
// Size: 0xc
function private function_2af2a87c5b8ac924()
{
    self.var_f59e42cdd69d83f3 = 0;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x4ea58cc1, Offset: 0x549c
// Size: 0x5f
function private function_8f129499fd06b5f5( player )
{
    if ( !player.var_c7c8628ac02fd8ab )
    {
        return;
    }
    
    location = player.origin;
    angles = player.angles;
    return { #angles:angles, #location:location };
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x5968bf2, Offset: 0x5504
// Size: 0x22, Type: bool
function private function_49249e31d3699bb2( player )
{
    return player.var_c7c8628ac02fd8ab && !isalive( player );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xdf5f0cda, Offset: 0x552f
// Size: 0x17
function private function_517a6cf81ebb13a7( player )
{
    return player.var_c7c8628ac02fd8ab;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x384c4661, Offset: 0x554f
// Size: 0x118
function private on_player_killed( params )
{
    player = self;
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        logstring( "[LIKM] " + player.name + " is killed " );
    }
    
    var_785507a7c4b22579 = activity_participation::function_e8eabd79cc49540e( player, [ "REV_OB_LOCKED_IN" ] );
    
    if ( !var_785507a7c4b22579.size )
    {
        return;
    }
    
    assert( var_785507a7c4b22579.size <= 1, "<dev string:xb6b>" + player.name + "<dev string:xb7e>" );
    var_b2c69d2982228013 = level.activities.instances[ getfirstarraykey( var_785507a7c4b22579 ) ];
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        logstring( "[LIKM] " + player.name + " is killed, " + "participating " + var_b2c69d2982228013.varianttag );
    }
    
    if ( var_b2c69d2982228013.var_f59e42cdd69d83f3 )
    {
        player.var_c7c8628ac02fd8ab = 1;
    }
    
    var_b2c69d2982228013 function_2e6b4e304e83dae1( player );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x3f68d0d8, Offset: 0x566f
// Size: 0x24
function private on_player_spawned( params )
{
    player = self;
    player.var_c7c8628ac02fd8ab = undefined;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x3afccecf, Offset: 0x569b
// Size: 0x4e
function private function_2e6b4e304e83dae1( player )
{
    if ( !player )
    {
        assertmsg( "<dev string:xbcf>" );
        return;
    }
    
    activity_participation::function_61aa2b2879f2c0a2( self, player );
    
    if ( self.playerparticipants.size == 0 )
    {
        if ( self.var_f59e42cdd69d83f3 )
        {
            activity_instance_common::endactivity( self, 0 );
        }
    }
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x3af5194f, Offset: 0x56f1
// Size: 0x9c
function private init_block_walls()
{
    all_block_walls = getentarray( "LOCKED_IN_BLOCK_WALLS", #targetname );
    
    if ( !all_block_walls )
    {
        return;
    }
    
    foreach ( e_wall in all_block_walls )
    {
        e_wall.moverdoesnotkill = 1;
    }
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x6028c768, Offset: 0x5795
// Size: 0x66, Type: bool
function private function_e5e7bc16e51e1f49()
{
    var_2bf434cae30601c5 = undefined;
    noteworthy_ref = self.varianttag + "_BLOCK_WALLS";
    var_2bf434cae30601c5 = getent( noteworthy_ref, #script_noteworthy );
    
    if ( !var_2bf434cae30601c5 )
    {
        assertmsg( "<dev string:xc22>" + noteworthy_ref );
        return false;
    }
    
    self.var_2bf434cae30601c5 = var_2bf434cae30601c5;
    function_d8cd8164557381e4( 0 );
    return true;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xb4faeab1, Offset: 0x5804
// Size: 0x1a
function private show_blocker( blocker )
{
    blocker show();
    blocker solid();
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x6f93168f, Offset: 0x5826
// Size: 0x1a
function private hide_blocker( blocker )
{
    blocker hide();
    blocker notsolid();
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xe99f172c, Offset: 0x5848
// Size: 0x8a
function private setup_warning_blocks( var_c4ba58fd936d79f1 )
{
    var_6469c1e4d3ac4060 = var_c4ba58fd936d79f1 namespace_be3150865da9d2f1::get_linked_struct_filtered( "warning_blocks_root", "script_noteworthy" );
    
    if ( !var_6469c1e4d3ac4060 )
    {
        println( "<dev string:xc66>" + self.varianttag + "<dev string:xca8>" + "<dev string:xcbb>" );
        return;
    }
    
    self.var_8ff2366e2fc4c39b = var_6469c1e4d3ac4060 namespace_be3150865da9d2f1::get_linked_structs_filtered( "block_d", "script_noteworthy" );
    self.var_e6ea17080f26eca7 = var_6469c1e4d3ac4060 namespace_be3150865da9d2f1::get_linked_structs_filtered( "block_w", "script_noteworthy" );
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x591c7f9c, Offset: 0x58da
// Size: 0x15e
function private destroy_warning_blocks()
{
    if ( self.var_8ff2366e2fc4c39b )
    {
        foreach ( var_1e8dcea37965c118 in self.var_8ff2366e2fc4c39b )
        {
            if ( var_1e8dcea37965c118.scriptable )
            {
                var_1e8dcea37965c118.scriptable freescriptable();
                var_1e8dcea37965c118.scriptable = undefined;
            }
        }
    }
    
    self.var_8ff2366e2fc4c39b = undefined;
    
    if ( self.var_e6ea17080f26eca7 )
    {
        foreach ( var_a3fbd9d0f367b5d4 in self.var_e6ea17080f26eca7 )
        {
            if ( var_a3fbd9d0f367b5d4.scriptable )
            {
                var_a3fbd9d0f367b5d4.scriptable freescriptable();
                var_a3fbd9d0f367b5d4.scriptable = undefined;
            }
        }
    }
    
    self.var_e6ea17080f26eca7 = undefined;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x8b1bf7d8, Offset: 0x5a40
// Size: 0x1d8
function private show_warning_blocks( b_show )
{
    state = b_show ? #"active" : #"hidden";
    
    if ( self.var_8ff2366e2fc4c39b )
    {
        foreach ( var_1e8dcea37965c118 in self.var_8ff2366e2fc4c39b )
        {
            if ( !var_1e8dcea37965c118.scriptable )
            {
                var_1e8dcea37965c118.scriptable = spawnscriptable( %"hash_612f995e7ce8ed08", var_1e8dcea37965c118.origin, var_1e8dcea37965c118.angles );
            }
            
            var_1e8dcea37965c118.scriptable setscriptablepartstate( #"body", state );
        }
    }
    
    if ( self.var_e6ea17080f26eca7 )
    {
        foreach ( var_a3fbd9d0f367b5d4 in self.var_e6ea17080f26eca7 )
        {
            if ( !var_a3fbd9d0f367b5d4.scriptable )
            {
                var_a3fbd9d0f367b5d4.scriptable = spawnscriptable( %"hash_141ed95cd2bc7658", var_a3fbd9d0f367b5d4.origin, var_a3fbd9d0f367b5d4.angles );
            }
            
            var_a3fbd9d0f367b5d4.scriptable setscriptablepartstate( #"body", state );
        }
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xb2fe3af8, Offset: 0x5c20
// Size: 0x62, Type: bool
function private setup_reward( var_c4ba58fd936d79f1 )
{
    var_c56b6ee6272e1ddf = var_c4ba58fd936d79f1 namespace_be3150865da9d2f1::get_linked_struct_filtered( "reward", "script_noteworthy" );
    
    if ( !var_c56b6ee6272e1ddf )
    {
        assertmsg( "<dev string:xccf>" + self.varianttag + "<dev string:xca8>" + "<dev string:xd08>" );
        return false;
    }
    
    self.var_c56b6ee6272e1ddf = var_c56b6ee6272e1ddf;
    return true;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x519c010, Offset: 0x5c8b
// Size: 0x153
function private function_8280d9d39cb6f724()
{
    if ( !self.var_c56b6ee6272e1ddf )
    {
        return;
    }
    
    if ( !self.playerparticipants.size )
    {
        return;
    }
    
    spawn_pos = self.var_c56b6ee6272e1ddf.origin;
    spawn_angles = self.var_c56b6ee6272e1ddf.angles;
    spawn_options = common_item::items_initspawnoptions_spawnfromposition( spawn_pos, spawn_angles );
    exotic_weapon = common_item::function_61c2c0251e742ffd( %"hash_6746660b468e32bb", undefined, spawn_options );
    exotic_weapon.scriptable_index = exotic_weapon getscriptableindex();
    ob_item_select::function_1dfd8b3bc8e33dd8( exotic_weapon );
    ob_item_select::function_923ddf97f6cdbee( exotic_weapon, self.playerparticipants );
    
    foreach ( player in self.playerparticipants )
    {
        ping_id = player calloutmarkerping::function_920a63c06abdefe8( exotic_weapon.scriptable_index );
        player calloutmarkerping_hide( ping_id );
        player calloutmarkerping_show( ping_id, player );
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xb950d7d9, Offset: 0x5de6
// Size: 0x5f
function private setup_sentry_turrets( var_c4ba58fd936d79f1 )
{
    var_9adacde8cbaf7869 = var_c4ba58fd936d79f1 namespace_be3150865da9d2f1::get_linked_structs_filtered( "sentry_turret", "script_noteworthy" );
    
    if ( !var_9adacde8cbaf7869 )
    {
        println( "<dev string:xd0f>" + "<dev string:xd46>" + "<dev string:xd54>" + self.varianttag );
        return;
    }
    
    self.var_d199e114f41a2fa1 = var_9adacde8cbaf7869;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0xc5801cab, Offset: 0x5e4d
// Size: 0x101
function private function_5ee902f9f80e756d()
{
    if ( !self.var_d199e114f41a2fa1 )
    {
        return;
    }
    
    foreach ( var_e3317567061a2182 in self.var_d199e114f41a2fa1 )
    {
        if ( var_e3317567061a2182.var_6b520d79503404f5 )
        {
            continue;
        }
        
        var_e3317567061a2182.allowemp = 1;
        var_e3317567061a2182.var_b9ac62a4e325b4be = #"killstreak";
        var_640d708a2e518fd8 = ob_soldier_util::ob_sentry_turret_spawn( var_e3317567061a2182 );
        
        if ( isdefined( var_640d708a2e518fd8.colmodel ) )
        {
            var_640d708a2e518fd8.colmodel show();
        }
        
        var_640d708a2e518fd8.var_437f238159c83b57 = 1;
        var_e3317567061a2182.var_6b520d79503404f5 = var_640d708a2e518fd8;
    }
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x95cbea5e, Offset: 0x5f56
// Size: 0xd6
function private function_39267c540074dea6()
{
    if ( !self.var_d199e114f41a2fa1 )
    {
        return;
    }
    
    foreach ( s_turret_info in self.var_d199e114f41a2fa1 )
    {
        var_640d708a2e518fd8 = s_turret_info.var_6b520d79503404f5;
        
        if ( var_640d708a2e518fd8 )
        {
            skipshutdown = 0;
            wasdestroyed = 1;
            var_640d708a2e518fd8 notify( #"kill_turret", skipshutdown, wasdestroyed );
            s_turret_info.var_6b520d79503404f5 = undefined;
        }
    }
    
    self.var_d199e114f41a2fa1 = undefined;
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x83002453, Offset: 0x6034
// Size: 0x137
function private function_d78d28cb4273392c( origin_thresholds, debug_text )
{
    if ( !origin_thresholds.size )
    {
        return;
    }
    
    var_c78685fa8c535be1 = [];
    sorted_array = [];
    
    for ( i = 0; i < origin_thresholds.size ; i++ )
    {
        data = origin_thresholds[ i ];
        
        if ( !data.participantthreshold )
        {
            assertmsg( "<dev string:xd67>" + debug_text );
            continue;
        }
        
        if ( !data.buckettag )
        {
            assertmsg( "<dev string:xd97>" + debug_text );
            continue;
        }
        
        if ( var_c78685fa8c535be1[ data.participantthreshold ] )
        {
            assertmsg( "<dev string:xdbc>" + data.participantthreshold + "<dev string:xde7>" + debug_text );
            continue;
        }
        
        var_c78685fa8c535be1[ data.participantthreshold ] = data.buckettag;
        copied_data = { #buckettag:data.buckettag, #participantthreshold:data.participantthreshold };
        sorted_array[ sorted_array.size ] = copied_data;
    }
    
    arraysort( sorted_array, undefined, &function_9bc857c4332915bc );
    return sorted_array;
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x4caac3c8, Offset: 0x6174
// Size: 0x2c, Type: bool
function private function_9bc857c4332915bc( a, b )
{
    return a.participantthreshold < b.participantthreshold;
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x52375593, Offset: 0x61a9
// Size: 0xcf
function private function_ce2ae0b5ea999e5c( encounter_id, var_838ce174f71b49aa )
{
    if ( !isdefined( encounter_id ) )
    {
        return;
    }
    
    count = self.playerparticipants.size;
    
    if ( !count )
    {
        return;
    }
    
    /#
        count = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "<dev string:xded>" ), count );
    #/
    
    var_335fbfd29103783e = undefined;
    
    for ( i = var_838ce174f71b49aa.size - 1; i >= 0 ; i-- )
    {
        data = var_838ce174f71b49aa[ i ];
        
        if ( count >= data.participantthreshold )
        {
            var_335fbfd29103783e = data.buckettag;
            break;
        }
    }
    
    if ( !var_335fbfd29103783e )
    {
        assertmsg( "<dev string:xe09>" + count );
        return;
    }
    
    function_1a9d724a960fa19d( encounter_id, var_335fbfd29103783e, 1 );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xe6c96c7a, Offset: 0x6280
// Size: 0x70
function private function_49f15c18129ee886( activity_instance )
{
    agent = self;
    agent ob_humans::function_5bc0e59d126a6295( "difficulty5" );
    agent namespace_6677ae6d9a73bda::function_20336f89f16f7bb8();
    agent.var_437f238159c83b57 = 1;
    
    if ( activity_instance.participate_trigger_volume )
    {
        agent function_23741795e43fc95c( activity_instance.participate_trigger_volume );
        agent setgoalvolumeauto( activity_instance.participate_trigger_volume );
    }
}

// Namespace ob_activity_locked_in
// Params 5, eflags: 0x4
// Checksum 0xd2b1d24, Offset: 0x62f8
// Size: 0x110
function private create_circle( origin, radius, z_offset = 0, team, players )
{
    if ( !players )
    {
        return;
    }
    
    circle_holder = spawnstruct();
    circle_holder game_utility::questcircle_create( "Search_Area_Contract_Ob", origin, radius );
    circle_holder game_utility::questcircle_hidefromall();
    
    foreach ( player in players )
    {
        circle_holder game_utility::questcircle_showtoplayer( player );
    }
    
    circle_holder.active_fx = spawnfx( utility::getfx( "locked_in_defend_guild_bots_area_circle_vfx" ), origin + ( 0, 0, z_offset ) );
    triggerfx( circle_holder.active_fx, -2 );
    return circle_holder;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x827e29f8, Offset: 0x6411
// Size: 0x45
function private destroy_circle( circle_holder )
{
    if ( !circle_holder )
    {
        return;
    }
    
    circle_holder game_utility::questcircle_delete();
    
    if ( circle_holder.active_fx )
    {
        circle_holder.active_fx delete();
        circle_holder.active_fx = undefined;
    }
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0xdbbcc532, Offset: 0x645e
// Size: 0x33
function private get_participate_countdown_duration()
{
    self.participate_countdown_duration = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "participate_countdown_duration" ), self.participate_countdown_duration );
    return self.participate_countdown_duration;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x5c8dfa9, Offset: 0x649a
// Size: 0x33
function private get_defend_duration()
{
    self.defend_duration = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "defend_duration" ), self.defend_duration );
    return self.defend_duration;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x788e5036, Offset: 0x64d6
// Size: 0x33
function private get_onslaught_duration()
{
    self.onslaught_duration = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "onslaught_duration" ), self.onslaught_duration );
    return self.onslaught_duration;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x19970ff7, Offset: 0x6512
// Size: 0x33
function private get_firewall_health()
{
    self.firewall_health = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "firewall_health" ), self.firewall_health );
    return self.firewall_health;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x62eaeb91, Offset: 0x654e
// Size: 0x33
function private get_firewall_time_limit()
{
    self.firewall_time_limit = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "firewall_time_limit" ), self.firewall_time_limit );
    return self.firewall_time_limit;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x1e7996e9, Offset: 0x658a
// Size: 0x33
function private get_firewall_remain_percent_to_show_outline()
{
    self.firewall_remain_percent_to_show_outline = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "firewall_remain_percent_to_show_outline" ), self.firewall_remain_percent_to_show_outline );
    return self.firewall_remain_percent_to_show_outline;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x36279803, Offset: 0x65c6
// Size: 0x33
function private get_firewall_activate_charging_bots_delay()
{
    self.firewall_activate_charging_bots_delay = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "firewall_activate_charging_bots_delay" ), self.firewall_activate_charging_bots_delay );
    return self.firewall_activate_charging_bots_delay;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x9c3a49a9, Offset: 0x6602
// Size: 0x33
function private get_defend_time_limit()
{
    self.defend_time_limit = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "defend_time_limit" ), self.defend_time_limit );
    return self.defend_time_limit;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x238cac00, Offset: 0x663e
// Size: 0x33
function private get_defend_activate_charging_bots_delay()
{
    self.defend_activate_charging_bots_delay = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "defend_activate_charging_bots_delay" ), self.defend_activate_charging_bots_delay );
    return self.defend_activate_charging_bots_delay;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0x74b25c42, Offset: 0x667a
// Size: 0x33
function private get_defend_max_waves()
{
    self.defend_max_waves = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "defend_max_waves" ), self.defend_max_waves );
    return self.defend_max_waves;
}

// Namespace ob_activity_locked_in
// Params 0, eflags: 0x4
// Checksum 0xac0b4e8, Offset: 0x66b6
// Size: 0x33
function private get_defend_wave_interval()
{
    self.defend_wave_interval = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "defend_wave_interval" ), self.defend_wave_interval );
    return self.defend_wave_interval;
}

// Namespace ob_activity_locked_in
// Params 3, eflags: 0x4
// Checksum 0x8530da53, Offset: 0x66f2
// Size: 0x4a
function private function_e956b562488e79cc( array, slice_size, var_6c8b486daa2b7320 )
{
    if ( array.size <= slice_size )
    {
        if ( var_6c8b486daa2b7320 )
        {
            return arrayrandomize( array );
        }
        else
        {
            return arraycopy( array );
        }
        
        return;
    }
    
    return utility::array_random_slice( array, slice_size );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xde180c15, Offset: 0x6744
// Size: 0xca
function private register_active_terminal( terminal )
{
    if ( !isdefined( level.var_e190b3ff905cf275 ) )
    {
        level.var_e190b3ff905cf275 = [];
    }
    
    level.var_e190b3ff905cf275[ level.var_e190b3ff905cf275.size ] = terminal;
    
    if ( level.var_4a0ff078c559e907.size )
    {
        foreach ( player in level.var_4a0ff078c559e907 )
        {
            function_6cf3c9124c2f530d( player, terminal );
        }
        
        level.var_4a0ff078c559e907 = undefined;
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x90cfcf06, Offset: 0x6816
// Size: 0x30
function private function_cf8a053342eb515c( terminal )
{
    if ( level.var_e190b3ff905cf275 )
    {
        level.var_e190b3ff905cf275 = arrayremove( level.var_e190b3ff905cf275, terminal );
    }
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x78050c1e, Offset: 0x684e
// Size: 0xdd
function private function_17dd4eb97668a339( origin )
{
    if ( !level.var_e190b3ff905cf275 )
    {
        return;
    }
    
    closest_terminal = undefined;
    closest_distance = undefined;
    
    foreach ( terminal in level.var_e190b3ff905cf275 )
    {
        distance = distance( origin, terminal.origin );
        
        if ( !closest_terminal )
        {
            closest_terminal = terminal;
            closest_distance = distance;
            continue;
        }
        
        if ( distance < closest_distance )
        {
            closest_terminal = terminal;
            closest_distance = distance;
        }
    }
    
    return closest_terminal;
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0x694673e9, Offset: 0x6934
// Size: 0xfe
function private function_b9a6d375f1b6bcce( params )
{
    player = params.player;
    
    foreach ( terminal in level.var_e190b3ff905cf275 )
    {
        objective_addclienttomask( terminal.var_5461ea430344e215, player );
    }
    
    closest_terminal = function_17dd4eb97668a339( player.origin );
    
    if ( !closest_terminal )
    {
        if ( !isdefined( level.var_4a0ff078c559e907 ) )
        {
            level.var_4a0ff078c559e907 = [];
        }
        
        level.var_4a0ff078c559e907[ level.var_4a0ff078c559e907.size ] = player;
        return;
    }
    
    function_6cf3c9124c2f530d( player, closest_terminal );
}

// Namespace ob_activity_locked_in
// Params 1, eflags: 0x4
// Checksum 0xffa424a4, Offset: 0x6a3a
// Size: 0xa3
function private function_c08725d38632a74f( params )
{
    player = params.player;
    
    foreach ( terminal in level.var_e190b3ff905cf275 )
    {
        objective_removeclientfrommask( terminal.var_5461ea430344e215, player );
    }
}

// Namespace ob_activity_locked_in
// Params 2, eflags: 0x4
// Checksum 0x29d2a388, Offset: 0x6ae5
// Size: 0x62
function private function_6cf3c9124c2f530d( player, terminal )
{
    var_aa493b4d7ee50b68 = terminal.var_5461ea430344e215;
    ping_id = player calloutmarkerping::function_5d7b7302e94b97c2( var_aa493b4d7ee50b68 );
    player calloutmarkerping_hide( ping_id );
    player calloutmarkerping_show( ping_id, player );
    player thread namespace_9d8e359c3b1041e5::showsplashsharedfunc( #"hash_603598d55641c8bf" );
}

/#

    // Namespace ob_activity_locked_in
    // Params 3, eflags: 0x4
    // Checksum 0x11965115, Offset: 0x6b4f
    // Size: 0xa8, Type: dev
    function private function_737243439429b4fc( target, endon_string, activity_instance )
    {
        if ( !getdvarint( @"hash_c2105dfb5c840eff", 0 ) )
        {
            return;
        }
        
        while ( !level.players[ 0 ] )
        {
            waitframe();
        }
        
        p = level.players[ 0 ];
        p endon( #"death_or_disconnect" );
        p endon( endon_string );
        activity_instance endon( #"instance_destroyed" );
        activity_instance endon( #"activity_ended" );
        p childthread debug_line_to_target( target, "<dev string:x377>", ( 1, 0, 0 ), 100 );
    }

    // Namespace ob_activity_locked_in
    // Params 4, eflags: 0x4
    // Checksum 0x7f73435d, Offset: 0x6bff
    // Size: 0xc4, Type: dev
    function private debug_line_to_target( target, text, color, radius )
    {
        if ( !isdefined( radius ) )
        {
            radius = 20;
        }
        
        if ( !getdvarint( @"hash_c2105dfb5c840eff", 0 ) )
        {
            return;
        }
        
        self endon( #"death_or_disconnect" );
        level endon( #"game_ended" );
        target endon( #"death" );
        
        while ( true )
        {
            waitframe();
            
            if ( !self || !target )
            {
                break;
            }
            
            line( self.origin, target.origin, color );
            sphere( target.origin, radius, color );
            print3d( target.origin, text, color );
        }
    }

    // Namespace ob_activity_locked_in
    // Params 5, eflags: 0x4
    // Checksum 0x4c248d9e, Offset: 0x6ccb
    // Size: 0xf3, Type: dev
    function private function_c03a43dfbbef7678( countdown, text_prefix, z_offset, color, scale )
    {
        if ( !isdefined( z_offset ) )
        {
            z_offset = 100;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        if ( !getdvarint( @"hash_c2105dfb5c840eff", 0 ) )
        {
            return;
        }
        
        self endon( #"death" );
        end_time = gettime() + countdown * 1000;
        
        while ( gettime() <= end_time )
        {
            waitframe();
            
            if ( !self )
            {
                break;
            }
            
            remain_s = ( end_time - gettime() ) * 0.001;
            text = text_prefix ? text_prefix + remain_s : remain_s;
            print3d( self.origin + ( 0, 0, z_offset ), text, color, 1, scale, 1, 1 );
        }
    }

    // Namespace ob_activity_locked_in
    // Params 4, eflags: 0x4
    // Checksum 0xefe63da, Offset: 0x6dc6
    // Size: 0xe5, Type: dev
    function private debug_draw_circle( center_origin, radius, color, endon_list )
    {
        if ( !getdvarint( @"hash_c2105dfb5c840eff", 0 ) )
        {
            return;
        }
        
        self endon( #"instance_destroyed" );
        self endon( #"activity_ended" );
        
        if ( endon_list && endon_list.size > 0 )
        {
            foreach ( endon_event in endon_list )
            {
                self endon( endon_event );
            }
        }
        
        while ( true )
        {
            waitframe();
            utility::draw_circle( center_origin, radius, color );
        }
    }

    // Namespace ob_activity_locked_in
    // Params 2, eflags: 0x4
    // Checksum 0xddde59b, Offset: 0x6eb3
    // Size: 0xa3, Type: dev
    function private players_debug_print( players, text )
    {
        if ( !getdvarint( @"hash_c2105dfb5c840eff", 0 ) )
        {
            return;
        }
        
        if ( !players )
        {
            return;
        }
        
        foreach ( player in players )
        {
            player iprintlnbold( text );
        }
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0xc
    // Checksum 0x3b55317d, Offset: 0x6f5e
    // Size: 0x2f6, Type: dev
    function private function_177713a5d32d9225()
    {
        self notify( #"hash_f94406e4704e1703" );
        self endon( #"hash_f94406e4704e1703" );
        
        if ( !getdvarint( @"hash_c2105dfb5c840eff", 0 ) )
        {
            return;
        }
        
        self endon( #"hash_fb6df4dc89de4dc5" );
        self endon( #"instance_destroyed" );
        self endon( #"activity_ended" );
        p = level.players[ 0 ];
        p endon( #"death_or_disconnect" );
        center = self.var_c4ba58fd936d79f1.origin;
        var_799675bb93252eae = getdvarint( @"hash_fa725cb73c179b41", 50000 );
        z_offset_limit = getdvarint( @"hash_3404e0016a3d3b8b", 60000 );
        
        while ( true )
        {
            distance = distance2d( p.origin, center );
            z_distance = abs( p.origin[ 2 ] - center[ 2 ] );
            
            if ( distance <= var_799675bb93252eae && z_distance <= z_offset_limit )
            {
                line( p.origin, center, ( 0, 1, 0 ) );
                sphere( center, 10, ( 0, 1, 0 ) );
            }
            else
            {
                if ( distance > var_799675bb93252eae )
                {
                    var_9a94a8fc01eeac08 = ( center[ 0 ], center[ 1 ], p.origin[ 2 ] );
                    line( p.origin, var_9a94a8fc01eeac08, ( 1, 0, 0 ) );
                    point = ( var_9a94a8fc01eeac08 - p.origin ) * ( distance - var_799675bb93252eae ) / distance + p.origin;
                    sphere( point, 10, ( 1, 0, 0 ) );
                    print3d( point, "<dev string:xe49>" + distance - var_799675bb93252eae, ( 1, 0, 0 ) );
                }
                
                if ( z_distance > z_offset_limit )
                {
                    var_d4c14b169971f098 = ( p.origin[ 0 ], p.origin[ 1 ], center[ 2 ] );
                    line( p.origin, var_d4c14b169971f098, ( 1, 0, 0 ) );
                    point = ( var_d4c14b169971f098 - p.origin ) * ( z_distance - z_offset_limit ) / z_distance + p.origin;
                    sphere( point, 10, ( 1, 0, 0 ) );
                    print3d( point, "<dev string:xe53>" + z_distance - z_offset_limit, ( 1, 0, 0 ) );
                }
            }
            
            bottom = center - ( 0, 0, 1 ) * z_offset_limit;
            top = center + ( 0, 0, 1 ) * z_offset_limit;
            cylinder( bottom, top, var_799675bb93252eae, ( 1, 1, 0 ), 0, 1 );
            waitframe();
        }
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0xc
    // Checksum 0x72bbc484, Offset: 0x725c
    // Size: 0x3d2, Type: dev
    function private init_devgui()
    {
        self notify( #"hash_eae0c7ccbd84d6a" );
        self endon( #"hash_eae0c7ccbd84d6a" );
        wait 1;
        root = "<dev string:xe5d>" + "<dev string:xe83>" + "<dev string:xe94>";
        namespace_6677ae6d9a73bda::devgui_init( root + "<dev string:xe96>" );
        devgui::function_9082edeb5db93280( root + "<dev string:xea2>" );
        devgui::add_devgui_func( "<dev string:xeb3>", "<dev string:xeca>", &function_99e0ba08fb70b5c8 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xee9>", "<dev string:xef6>", &function_13cc34afd6877a77 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf10>", "<dev string:xf21>", &function_13cc34afd6877a77 );
        devgui::add_devgui_func( "<dev string:xf3b>", "<dev string:xf4f>", &function_c8710278aea6091 );
        devgui::add_devgui_func( "<dev string:xf69>", "<dev string:xf7c>", &function_645ffa432ae0df85 );
        devgui::add_devgui_func( "<dev string:xf99>", "<dev string:xfa6>", &function_e78cc33d86b54fca );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root + "<dev string:xfc9>" );
        devgui::add_devgui_func( "<dev string:xf99>", "<dev string:xfda>", &function_c42844ab47dabc26 );
        devgui::add_devgui_func( "<dev string:xffa>", "<dev string:x1018>", &function_5f776af28d192292 );
        devgui::add_devgui_func( "<dev string:x103c>", "<dev string:x1050>", &function_c845bfe61012576b );
        devgui::add_devgui_func( "<dev string:x106e>", "<dev string:x1085>", &function_997d7318a1db5ee3 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root + "<dev string:x10a6>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x10c0>", "<dev string:x10da>", &function_7e021a166947cbc1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x10fa>", "<dev string:x1117>", &function_7e021a166947cbc1 );
        devgui::add_devgui_func( "<dev string:xf99>", "<dev string:x1137>", &function_af83b9dd3de92ab9 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root + "<dev string:x1160>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1172>", "<dev string:x1183>", &function_ff9c7c206fb7583d );
        devgui::function_cd4e263c1f3018ae( "<dev string:x11a7>", "<dev string:x11b6>", &function_ff9c7c206fb7583d );
        devgui::function_cd4e263c1f3018ae( "<dev string:x11d8>", "<dev string:x11ec>", &function_ff9c7c206fb7583d );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1213>", "<dev string:x1225>", &function_ff9c7c206fb7583d );
        devgui::add_devgui_func( "<dev string:x124a>", "<dev string:x1255>", &function_d2a66ca4eba66712 );
        devgui::add_devgui_func( "<dev string:x1274>", "<dev string:x1289>", &create_gas_circle );
        devgui::add_devgui_func( "<dev string:x12ae>", "<dev string:x12c4>", &delete_gas_circle );
        devgui::add_devgui_func( "<dev string:xf99>", "<dev string:x12ea>", &function_5d0d3d45a4eed2b7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x130b>", "<dev string:x1325>", &function_129ff266c632bc71 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1345>", "<dev string:x1362>", &function_129ff266c632bc71 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root + "<dev string:x1385>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x138d>", "<dev string:x13af>", &function_a7c0994b44f96ca2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x13d7>", "<dev string:x13fa>", &function_a7c0994b44f96ca2 );
        devgui::add_devgui_func( "<dev string:x1422>", "<dev string:x143a>", &function_3818b074a0680b06 );
        devgui::add_devgui_func( "<dev string:x145c>", "<dev string:x146f>", &function_8a6ce542db41a098 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( root + "<dev string:x148c>" );
        devgui::add_devgui_func( "<dev string:x1497>", "<dev string:x14ba>", &function_b94d09a2c7b03cc2 );
        devgui::add_devgui_func( "<dev string:x14e7>", "<dev string:x1500>", &function_9c2a8d0e44efe3c2 );
        devgui::add_devgui_func( "<dev string:x152d>", "<dev string:x1554>", &function_7a6ca6aed82e6eda );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1580>", "<dev string:x158e>", &function_37a74113ffc32ed5 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x15a9>", "<dev string:x15b7>", &function_37a74113ffc32ed5 );
        devgui::add_devgui_func( "<dev string:x15d2>", "<dev string:x15f5>", &function_6d9982b43ee22b3c );
        devgui::add_devgui_func( "<dev string:x1627>", "<dev string:x1642>", &function_3c077d91f369c76b );
        devgui::add_devgui_func( "<dev string:x166c>", "<dev string:x1683>", &function_2c0a6a109b3d1c4d );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_activity_locked_in
    // Params 1, eflags: 0x4
    // Checksum 0xf8150daa, Offset: 0x7636
    // Size: 0x1cb, Type: dev
    function private function_13cc34afd6877a77( params )
    {
        level endon( #"game_ended" );
        use_other = int( params[ 0 ] ) == 1;
        me = level.players[ 0 ];
        my_f = anglestoforward( me.angles );
        spawn_pos = me.origin + my_f * 100;
        var_75dfc1e0635d644a = me;
        
        if ( use_other )
        {
            var_75dfc1e0635d644a = undefined;
            waiting_bot = 0;
            
            while ( !var_75dfc1e0635d644a )
            {
                waitframe();
                
                if ( level.players.size > 1 )
                {
                    var_75dfc1e0635d644a = level.players[ 1 ];
                }
                
                if ( !var_75dfc1e0635d644a && !waiting_bot )
                {
                    waiting_bot = 1;
                    bots::spawn_bots( 1, me.team );
                }
            }
        }
        
        namespace_6677ae6d9a73bda::function_1840dacbac83750d( var_75dfc1e0635d644a );
        terminal_scriptable = function_ffb1b8b5420190fb( spawn_pos, me.angles, &function_e47b8a0bfd950f60 );
        terminal_scriptable setscriptablepartstate( #"terminal", #"usable" );
        terminal_scriptable.var_b07344e898c3b7e0 = var_75dfc1e0635d644a.name;
        var_ea8f160333513528 = 256;
        useradius = 128;
        me childthread function_d70dbdce52001dd3( terminal_scriptable, var_ea8f160333513528, "<dev string:x16a9>", 30 );
        me childthread function_d70dbdce52001dd3( terminal_scriptable, useradius, "<dev string:x16bb>", 60 );
        me childthread function_d7c5536f51797cb3( terminal_scriptable );
        
        if ( !isdefined( level.var_55ccb277e8de3817 ) )
        {
            level.var_55ccb277e8de3817 = [];
        }
        
        record = { #terminal_scriptable:terminal_scriptable };
        level.var_55ccb277e8de3817[ level.var_55ccb277e8de3817.size ] = record;
    }

    // Namespace ob_activity_locked_in
    // Params 4, eflags: 0x4
    // Checksum 0x18e1ce7, Offset: 0x7809
    // Size: 0xe4, Type: dev
    function private function_d70dbdce52001dd3( scriptable, radius, text, z_offset )
    {
        player = self;
        player endon( #"death_or_disconnect" );
        scriptable endon( #"death" );
        
        while ( true )
        {
            waitframe();
            in_radius = distancesquared( scriptable.origin, player.origin ) <= squared( radius );
            color = in_radius ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            sphere( scriptable.origin, radius, color );
            print3d( scriptable.origin + ( 0, 0, z_offset ), text, color, 1, 0.5 );
        }
    }

    // Namespace ob_activity_locked_in
    // Params 2, eflags: 0x4
    // Checksum 0xd4a3a6a2, Offset: 0x78f5
    // Size: 0x1f0, Type: dev
    function private function_d7c5536f51797cb3( scriptable, axis_length )
    {
        if ( !isdefined( axis_length ) )
        {
            axis_length = 50;
        }
        
        level endon( #"game_ended" );
        scriptable endon( #"death" );
        
        while ( true )
        {
            waitframe();
            
            if ( !scriptable )
            {
                break;
            }
            
            org = scriptable.origin;
            fwd = anglestoforward( scriptable.angles );
            right = anglestoright( scriptable.angles );
            up = anglestoup( scriptable.angles );
            fwd_end = org + fwd * axis_length;
            right_end = org + right * axis_length;
            up_end = org + up * axis_length;
            line( org, fwd_end, ( 1, 0, 0 ) );
            line( org, right_end, ( 0, 1, 0 ) );
            line( org, up_end, ( 0, 0, 1 ) );
            print3d( fwd_end, #"forward", ( 1, 0, 0 ), 0.8, 0.5 );
            print3d( right_end, #"right", ( 0, 1, 0 ), 0.8, 0.5 );
            print3d( up_end, #"up", ( 0, 0, 1 ), 0.8, 0.5 );
            distance = distance( scriptable.origin, self.origin );
            print3d( org, scriptable.var_b07344e898c3b7e0 + org + "<dev string:x16c5>" + distance + "<dev string:x16c5>", ( 1, 1, 1 ), 1, 0.5, 1, 1 );
        }
    }

    // Namespace ob_activity_locked_in
    // Params 1, eflags: 0x4
    // Checksum 0x7226be81, Offset: 0x7aed
    // Size: 0x1a8, Type: dev
    function private function_e47b8a0bfd950f60( player )
    {
        var_1056b101d8460b51 = self.var_b07344e898c3b7e0 ?? "<dev string:x16c7>";
        msg = player.name + "<dev string:x16cf>" + var_1056b101d8460b51 + "<dev string:x16f2>";
        
        if ( !self.allowed_players || !arraycontains( self.allowed_players, player ) )
        {
            foreach ( p in level.players )
            {
                p iprintlnbold( "<dev string:x16f4>" + msg );
            }
            
            return;
        }
        
        self.allowed_players = undefined;
        
        foreach ( p in level.players )
        {
            p iprintlnbold( "<dev string:x1702>" + msg );
        }
        
        if ( isdefined( self.var_5461ea430344e215 ) )
        {
            if ( !objidpoolmanager::function_fb05d646a96ed99e( self.var_5461ea430344e215 ) )
            {
                objidpoolmanager::returnobjectiveid( self.var_5461ea430344e215 );
            }
            
            self.var_5461ea430344e215 = undefined;
        }
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x387b4e6a, Offset: 0x7c9d
    // Size: 0xec, Type: dev
    function private function_c8710278aea6091()
    {
        if ( !level.var_55ccb277e8de3817 )
        {
            return;
        }
        
        foreach ( terminal_record in level.var_55ccb277e8de3817 )
        {
            terminal_record.terminal_scriptable freescriptable();
            obj_id = terminal_record.terminal_scriptable.var_5461ea430344e215;
            
            if ( isdefined( obj_id ) )
            {
                if ( !objidpoolmanager::function_fb05d646a96ed99e( obj_id ) )
                {
                    objidpoolmanager::returnobjectiveid( obj_id );
                }
                
                terminal_record.terminal_scriptable.var_5461ea430344e215 = undefined;
            }
        }
        
        level.var_55ccb277e8de3817 = undefined;
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x8488e8b, Offset: 0x7d91
    // Size: 0x1ce, Type: dev
    function private function_99e0ba08fb70b5c8()
    {
        me = level.players[ 0 ];
        terminals = [];
        
        foreach ( instance in level.activities.instances )
        {
            if ( instance.type != "<dev string:xe83>" )
            {
                continue;
            }
            
            if ( instance.s_terminal && instance.s_terminal.origin )
            {
                terminals[ terminals.size ] = instance.s_terminal;
            }
        }
        
        if ( !terminals.size )
        {
            me iprintlnbold( "<dev string:x170c>" );
            return;
        }
        
        if ( !isdefined( level.var_438f3cb5da04e78c ) )
        {
            level.var_438f3cb5da04e78c = 0;
        }
        
        index = level.var_438f3cb5da04e78c % terminals.size;
        level.var_438f3cb5da04e78c = ( index + 1 ) % terminals.size;
        s_terminal = terminals[ index ];
        fwd = anglestoforward( s_terminal.angles );
        tp_pos = s_terminal.origin + fwd * 80;
        facing_yaw = s_terminal.angles[ 1 ] + 180;
        me setorigin( tp_pos );
        me setplayerangles( ( 0, facing_yaw, 0 ) );
        me iprintlnbold( "<dev string:x1731>" + index + 1 + "<dev string:x702>" + terminals.size );
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x5efa71fe, Offset: 0x7f67
    // Size: 0xe7, Type: dev
    function private function_645ffa432ae0df85()
    {
        me = level.players[ 0 ];
        fwd = anglestoforward( me.angles );
        var_a5f0bdcf12718957 = me.origin + fwd * 100;
        right = anglestoright( me.angles );
        var_a5f0becf12718b8a = var_a5f0bdcf12718957 + right * 80;
        spawn_angles = me.angles;
        utility::callsharedfunc( #"ability_case", #"spawn", var_a5f0bdcf12718957, "<dev string:x1749>", undefined, #"tactical", spawn_angles );
        utility::callsharedfunc( #"ability_case", #"spawn", var_a5f0becf12718b8a, "<dev string:x1759>", undefined, #"default", spawn_angles );
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x338dd40e, Offset: 0x8056
    // Size: 0x2b, Type: dev
    function private function_e78cc33d86b54fca()
    {
        activity_instance = function_260a3678ae9a7a93();
        
        if ( !activity_instance )
        {
            return;
        }
        
        activity_instance notify( #"hash_24e14dac7ee32c58" );
    }

    // Namespace ob_activity_locked_in
    // Params 2, eflags: 0xc
    // Checksum 0xd693729a, Offset: 0x8089
    // Size: 0x9c, Type: dev
    function private draw_ai_info( ai_type, subclass )
    {
        self notify( #"hash_160fcce964468e77" );
        self endon( #"hash_160fcce964468e77" );
        self endon( #"death" );
        
        while ( true )
        {
            waitframe();
            
            if ( !self )
            {
                break;
            }
            
            origin = self.origin;
            print3d( origin, ai_type + "<dev string:x176c>" + subclass + "<dev string:x176c>" + self.unittype, ( 1, 1, 1 ), 1, 0.3, 1, 1 );
        }
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x193424cf, Offset: 0x812d
    // Size: 0x10f, Type: dev
    function private function_c42844ab47dabc26()
    {
        activity_instance = function_8b58d0669fba51d9();
        
        if ( !activity_instance )
        {
            return;
        }
        
        me = level.players[ 0 ];
        
        if ( !me )
        {
            return;
        }
        
        var_8a0eb0589015695b = activity_instance.s_firewalls;
        
        foreach ( var_e39f05514bc5a668 in var_8a0eb0589015695b )
        {
            if ( var_e39f05514bc5a668.e_firewall && var_e39f05514bc5a668.e_firewall ob_activity_locked_in_firewall::is_firewall_activated() )
            {
                var_e39f05514bc5a668.e_firewall dodamage( var_e39f05514bc5a668.e_firewall.maxhealth, me.origin, me, me );
                wait 1;
            }
        }
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x568d22b7, Offset: 0x8244
    // Size: 0xd0, Type: dev
    function private function_5f776af28d192292()
    {
        activity_instance = function_8b58d0669fba51d9();
        
        if ( !activity_instance )
        {
            return;
        }
        
        level.var_2b46b2c8d3252e3 = !level.var_2b46b2c8d3252e3;
        
        foreach ( var_e39f05514bc5a668 in activity_instance.s_firewalls )
        {
            if ( var_e39f05514bc5a668.e_firewall ob_activity_locked_in_firewall::is_firewall_activated() )
            {
                var_e39f05514bc5a668.e_firewall ob_activity_locked_in_firewall::show_outline( level.var_2b46b2c8d3252e3 );
            }
        }
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0xe8d44dd4, Offset: 0x831c
    // Size: 0x176, Type: dev
    function private function_c845bfe61012576b()
    {
        me = level.players[ 0 ];
        fwd = anglestoforward( me.angles );
        spawn_pos = me.origin + fwd * 300;
        health = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "<dev string:x176e>" ), 100 );
        var_e39f05514bc5a668 = { #origin:spawn_pos };
        var_e39f05514bc5a668.health = health;
        
        if ( !isdefined( me.var_ce2057a33d51007b ) )
        {
            me.var_ce2057a33d51007b = {};
        }
        
        if ( !isdefined( me.var_ce2057a33d51007b.playerparticipants ) )
        {
            me.var_ce2057a33d51007b.playerparticipants = [ me ];
        }
        
        ob_activity_locked_in_firewall::function_3369c062236b8a16( &function_d20b42da3e0ac619, me.var_ce2057a33d51007b );
        e_firewall = ob_activity_locked_in_firewall::function_37c842ffd11cc4a0( var_e39f05514bc5a668, me.var_ce2057a33d51007b );
        e_firewall ob_activity_locked_in_firewall::activate_firewall();
        
        if ( !isdefined( level.var_99b3a26243bbb7a0 ) )
        {
            level.var_99b3a26243bbb7a0 = [];
        }
        
        level.var_99b3a26243bbb7a0[ level.var_99b3a26243bbb7a0.size ] = e_firewall;
        function_645ffa432ae0df85();
        me iprintlnbold( "<dev string:x177e>" + spawn_pos + "<dev string:x1798>" + health + "<dev string:x16f2>" );
    }

    // Namespace ob_activity_locked_in
    // Params 2, eflags: 0x4
    // Checksum 0x71ca3416, Offset: 0x849a
    // Size: 0xaa, Type: dev
    function private function_d20b42da3e0ac619( activity_instance, var_46159e2772b2df4 )
    {
        origin = self.origin;
        
        foreach ( p in level.players )
        {
            p iprintlnbold( "<dev string:x17a3>" + origin );
        }
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x6590aef5, Offset: 0x854c
    // Size: 0xe0, Type: dev
    function private function_997d7318a1db5ee3()
    {
        me = level.players[ 0 ];
        
        if ( !level.var_99b3a26243bbb7a0 )
        {
            me iprintlnbold( "<dev string:x17bf>" );
            return;
        }
        
        count = 0;
        
        foreach ( e_firewall in level.var_99b3a26243bbb7a0 )
        {
            if ( isdefined( e_firewall ) )
            {
                e_firewall ob_activity_locked_in_firewall::function_6670c8de4d0bed14();
                count++;
            }
        }
        
        level.var_99b3a26243bbb7a0 = undefined;
        me iprintlnbold( "<dev string:x17dd>" + count + "<dev string:x17e8>" );
    }

    // Namespace ob_activity_locked_in
    // Params 1, eflags: 0x4
    // Checksum 0x3b7ba519, Offset: 0x8634
    // Size: 0xf, Type: dev
    function private function_7e021a166947cbc1( params )
    {
        
    }

    // Namespace ob_activity_locked_in
    // Params 2, eflags: 0x4
    // Checksum 0x61592394, Offset: 0x864b
    // Size: 0x22, Type: dev
    function private function_5231a235f49b5724( request_id, user_data )
    {
        return level.var_f6945318c582548a;
    }

    // Namespace ob_activity_locked_in
    // Params 1, eflags: 0x4
    // Checksum 0x428d380a, Offset: 0x8675
    // Size: 0xb9, Type: dev
    function private function_129ff266c632bc71( params )
    {
        is_spawn = int( params[ 0 ] );
        
        if ( !is_spawn )
        {
            level.var_10aeaf6e6e20c6da = 1;
            return;
        }
        
        me = level.players[ 0 ];
        spawn_origin = me.origin;
        spawn_radius = 500;
        level.var_10aeaf6e6e20c6da = 0;
        request_id = level activity_ai_encounters::function_eb8506829193f5eb( "<dev string:x17fb>", spawn_origin, spawn_radius, 1, 0, 1, 2 );
        activity_ai_encounters::function_d33de057e760c97b( request_id, &function_e4eae8a2a1cb5168, [] );
        me iprintlnbold( "<dev string:x1827>" + request_id + "<dev string:x16f2>" );
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x3f10860c, Offset: 0x8736
    // Size: 0x2b, Type: dev
    function private function_af83b9dd3de92ab9()
    {
        activity_instance = function_8b58d0669fba51d9();
        
        if ( !activity_instance )
        {
            return;
        }
        
        activity_instance notify( #"locked_in_defend_success" );
    }

    // Namespace ob_activity_locked_in
    // Params 2, eflags: 0x4
    // Checksum 0xf1d28e46, Offset: 0x8769
    // Size: 0x22, Type: dev
    function private function_e4eae8a2a1cb5168( request_id, user_data )
    {
        return level.var_10aeaf6e6e20c6da;
    }

    // Namespace ob_activity_locked_in
    // Params 1, eflags: 0xc
    // Checksum 0xe3fd3b35, Offset: 0x8793
    // Size: 0x48d, Type: dev
    function private function_ff9c7c206fb7583d( params )
    {
        self notify( #"hash_65b2c985d8ea91f6" );
        self endon( #"hash_65b2c985d8ea91f6" );
        level endon( #"game_ended" );
        is_start = params[ 0 ] == "<dev string:x1851>";
        has_hw = params[ 1 ] == "<dev string:x1857>";
        me = level.players[ 0 ];
        players = [ me ];
        
        if ( is_start )
        {
            pre_duration = 6;
            iprintln( "<dev string:x185a>" + pre_duration + "<dev string:x186d>" );
            level childthread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "<dev string:x1876>", pre_duration, undefined, players );
            wait 2;
            var_748d21f0ae3805f1 = 3;
            iprintln( "<dev string:x188a>" + var_748d21f0ae3805f1 + "<dev string:x186d>" );
            
            foreach ( player in players )
            {
                player hud_util::function_a7b5c7ac6074b623( "<dev string:x189f>", "<dev string:x18c2>", ( 0.9, 0.95, 1 ) );
                player thread hud_util::fade_out( var_748d21f0ae3805f1, "<dev string:x189f>" );
            }
            
            wait var_748d21f0ae3805f1;
            
            if ( has_hw )
            {
                hw_delay = 2;
                iprintln( "<dev string:x18c8>" + hw_delay + "<dev string:x18e3>" );
                wait hw_delay;
                
                foreach ( player in players )
                {
                    player function_a565dafac620d68e( "<dev string:x18ef>" );
                }
            }
            else
            {
                iprintln( "<dev string:x1912>" );
            }
            
            wait 2;
            post_duration = 5;
            iprintln( "<dev string:x1938>" + post_duration + "<dev string:x186d>" );
            thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "<dev string:x1876>", post_duration, undefined, players );
            fade_in_duration = 3;
            
            foreach ( player in players )
            {
                player thread hud_util::fade_in( fade_in_duration, "<dev string:x189f>" );
            }
            
            iprintln( "<dev string:x1957>" );
            return;
        }
        
        pre_duration = 3;
        iprintln( "<dev string:x185a>" + pre_duration + "<dev string:x186d>" );
        level childthread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "<dev string:x1876>", pre_duration, undefined, players );
        wait pre_duration;
        fade_out_duration = 3;
        iprintln( "<dev string:x188a>" + fade_out_duration + "<dev string:x186d>" );
        
        foreach ( player in players )
        {
            player hud_util::function_a7b5c7ac6074b623( "<dev string:x189f>", "<dev string:x18c2>", ( 0.9, 0.95, 1 ) );
            player thread hud_util::fade_out( fade_out_duration, "<dev string:x189f>" );
        }
        
        wait fade_out_duration;
        delay = 3;
        iprintln( "<dev string:x197a>" + delay + "<dev string:x18e3>" );
        wait delay;
        fade_in_duration = 1.2;
        iprintln( "<dev string:x199d>" + fade_in_duration + "<dev string:x18e3>" );
        
        foreach ( player in players )
        {
            if ( has_hw )
            {
                player function_72cf2eee8e035013( "<dev string:x18ef>" );
            }
            
            player hud_util::function_a7b5c7ac6074b623( "<dev string:x189f>", "<dev string:x18c2>", ( 0.9, 0.95, 1 ) );
            player thread hud_util::fade_in( fade_in_duration, "<dev string:x189f>" );
        }
        
        iprintln( "<dev string:x19bb>" );
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x8f9069ef, Offset: 0x8c28
    // Size: 0x15, Type: dev
    function private function_d2a66ca4eba66712()
    {
        function_8ed9429f96ca0822( level.players );
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x802d5b47, Offset: 0x8c45
    // Size: 0x99, Type: dev
    function private create_gas_circle()
    {
        me = level.players[ 0 ];
        me_pos = me.origin;
        radius = 1000;
        e_gas_circle = spawnbrcircle( me_pos[ 0 ], me_pos[ 1 ], radius );
        level.var_bd91a783ff691084 = e_gas_circle;
        e_gas_circle hide();
        e_gas_circle showtoplayer( me );
        e_gas_circle game_utility::questcircle_create( "<dev string:x19dc>", me_pos, radius );
        e_gas_circle game_utility::questcircle_showtoplayer( me );
        function_3cd2087fed4e663a( 6, 6, 0, 0.8 );
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x40cdfc90, Offset: 0x8ce6
    // Size: 0x3b, Type: dev
    function private delete_gas_circle()
    {
        if ( !level.var_bd91a783ff691084 )
        {
            return;
        }
        
        level.var_bd91a783ff691084 game_utility::questcircle_delete();
        level.var_bd91a783ff691084 delete();
        level.var_bd91a783ff691084 = undefined;
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x448a0f42, Offset: 0x8d29
    // Size: 0x2b, Type: dev
    function private function_5d0d3d45a4eed2b7()
    {
        activity_instance = function_8b58d0669fba51d9();
        
        if ( !activity_instance )
        {
            return;
        }
        
        activity_instance notify( #"hash_c21a2ccbb6eb43e4" );
    }

    // Namespace ob_activity_locked_in
    // Params 1, eflags: 0x4
    // Checksum 0x3affa855, Offset: 0x8d5c
    // Size: 0x49, Type: dev
    function private function_a7c0994b44f96ca2( params )
    {
        activity_instance = function_8b58d0669fba51d9();
        
        if ( !activity_instance )
        {
            return;
        }
        
        should_pause = params[ 0 ] == "<dev string:x19ee>";
        activity_instance.var_a06dd70584727039 = should_pause;
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x1f826c2, Offset: 0x8dad
    // Size: 0x55, Type: dev
    function private function_3818b074a0680b06()
    {
        me = level.players[ 0 ];
        activity_instance = function_8b58d0669fba51d9();
        
        if ( !activity_instance )
        {
            me iprintlnbold( "<dev string:x19f0>" );
            return;
        }
        
        activity_participation::function_61aa2b2879f2c0a2( activity_instance, me );
        me iprintlnbold( "<dev string:x1a27>" );
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x4bdfbc56, Offset: 0x8e0a
    // Size: 0x6e, Type: dev
    function private function_8a6ce542db41a098()
    {
        me = level.players[ 0 ];
        activity_instance = function_260a3678ae9a7a93();
        
        if ( !activity_instance )
        {
            me iprintlnbold( "<dev string:x1a50>" );
            return;
        }
        
        if ( activity_participation::function_e7fc1202ac164928( activity_instance, me ) )
        {
            me iprintlnbold( "<dev string:x1a74>" );
            return;
        }
        
        activity_participation::function_bc67362dace4370c( activity_instance, me );
        me iprintlnbold( "<dev string:x1aad>" );
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x706166e7, Offset: 0x8e80
    // Size: 0x5d, Type: dev
    function private function_b94d09a2c7b03cc2()
    {
        me = level.players[ 0 ];
        me hud_util::function_a7b5c7ac6074b623( "<dev string:x189f>", "<dev string:x18c2>", ( 0.9, 0.95, 1 ) );
        me thread hud_util::fade_out( 3, "<dev string:x189f>" );
        wait 1;
        me hud_util::function_e71c430005379a39( "<dev string:x189f>" );
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x6de5ee1b, Offset: 0x8ee5
    // Size: 0x3e, Type: dev
    function private function_9c2a8d0e44efe3c2()
    {
        hud_util::showsplashtoall( #"hash_ef378ebe3928ab56" );
        setomnvar( o"ui_world_event_timer", gettime() + 10000 );
        wait 5;
        hud_util::showsplashtoall( #"hash_eab614d9b7996773" );
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x498d1f0a, Offset: 0x8f2b
    // Size: 0x10c, Type: dev
    function private function_7a6ca6aed82e6eda()
    {
        me = level.players[ 0 ];
        activity_instance = function_260a3678ae9a7a93();
        
        if ( !activity_instance )
        {
            me iprintlnbold( "<dev string:x1ad2>" );
            return;
        }
        
        defend_origin = activity_instance.defend_origin;
        bot = undefined;
        
        if ( level.players.size < 2 )
        {
            bots::spawn_bots( 1, me.team );
            
            while ( level.players.size < 2 )
            {
                wait 1;
            }
        }
        
        bot = level.players[ 1 ];
        
        if ( !bot )
        {
            me iprintlnbold( "<dev string:x1b03>" );
            return;
        }
        
        bot setorigin( defend_origin );
        bot botsetflag( "<dev string:x1b14>", 1 );
        
        if ( !activity_participation::function_e7fc1202ac164928( activity_instance, bot ) )
        {
            activity_participation::function_bc67362dace4370c( activity_instance, bot );
        }
        
        wait 3;
        
        if ( activity_participation::function_e7fc1202ac164928( activity_instance, me ) )
        {
            activity_participation::function_61aa2b2879f2c0a2( activity_instance, me );
        }
        
        me iprintlnbold( "<dev string:x1b25>" );
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0xbfffb2ca, Offset: 0x903f
    // Size: 0x11a, Type: dev
    function private function_260a3678ae9a7a93()
    {
        me = level.players[ 0 ];
        var_4d79e07f953cb000 = me.origin;
        d = -1;
        closest_instance = undefined;
        
        foreach ( instance in level.activities.instances )
        {
            if ( instance.type == "<dev string:xe83>" )
            {
                var_3fa62a1f09b981e = distance2dsquared( var_4d79e07f953cb000, instance.var_c4ba58fd936d79f1.origin );
                
                if ( d < 0 )
                {
                    d = var_3fa62a1f09b981e;
                    closest_instance = instance;
                }
                
                if ( var_3fa62a1f09b981e < d )
                {
                    d = var_3fa62a1f09b981e;
                    closest_instance = instance;
                }
            }
        }
        
        return closest_instance;
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x750f8f4f, Offset: 0x9161
    // Size: 0x6e, Type: dev
    function private function_8b58d0669fba51d9()
    {
        me = level.players[ 0 ];
        
        if ( !me )
        {
            return;
        }
        
        var_785507a7c4b22579 = activity_participation::function_e8eabd79cc49540e( me, [ "<dev string:xe83>" ] );
        
        if ( !var_785507a7c4b22579.size )
        {
            return;
        }
        
        var_b2c69d2982228013 = level.activities.instances[ getfirstarraykey( var_785507a7c4b22579 ) ];
        return var_b2c69d2982228013;
    }

    // Namespace ob_activity_locked_in
    // Params 1, eflags: 0x4
    // Checksum 0xfd74f7eb, Offset: 0x91d7
    // Size: 0xc8, Type: dev
    function private function_37a74113ffc32ed5( params )
    {
        should_show = params[ 0 ] == "<dev string:x19ee>";
        all_block_walls = getentarray( "<dev string:x1b6f>", #targetname );
        
        if ( !all_block_walls )
        {
            return;
        }
        
        foreach ( e_wall in all_block_walls )
        {
            if ( should_show )
            {
                show_blocker( e_wall );
                continue;
            }
            
            hide_blocker( e_wall );
        }
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x3e64a38d, Offset: 0x92a7
    // Size: 0x11e, Type: dev
    function private function_6d9982b43ee22b3c()
    {
        var_88f86d1cfc12aa77 = 3;
        var_48ea3e609587fb4a = 0;
        
        foreach ( activity_instance in level.activities.instances )
        {
            if ( activity_instance.type != "<dev string:xe83>" )
            {
                continue;
            }
            
            current_state = activity_instance_common::getactivitystate( activity_instance );
            
            if ( current_state == "<dev string:x1b85>" )
            {
                activity_instance.resetcooldown = 1;
                activity_instance_common::function_9aeeabe50fc9cc3e( activity_instance );
            }
            else if ( current_state == "<dev string:x1b8a>" )
            {
                activity_instance.resetcooldown = 1;
                activity_instance_common::endactivity( activity_instance, 0 );
            }
            else
            {
                continue;
            }
            
            var_48ea3e609587fb4a++;
            var_48ea3e609587fb4a %= var_88f86d1cfc12aa77;
            
            if ( var_48ea3e609587fb4a == 0 )
            {
                waitframe();
            }
        }
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0xaafa1a88, Offset: 0x93cd
    // Size: 0xc4, Type: dev
    function private function_3c077d91f369c76b()
    {
        me = level.players[ 0 ];
        spawn_pos = me.origin;
        spawn_angles = me.angles;
        var_e3317567061a2182 = spawnstruct();
        var_e3317567061a2182.origin = spawn_pos;
        var_e3317567061a2182.angles = spawn_angles;
        var_e3317567061a2182.allowemp = 1;
        var_e3317567061a2182.var_b9ac62a4e325b4be = #"killstreak";
        var_640d708a2e518fd8 = ob_soldier_util::ob_sentry_turret_spawn( var_e3317567061a2182 );
        
        if ( isdefined( var_640d708a2e518fd8.colmodel ) )
        {
            var_640d708a2e518fd8.colmodel show();
        }
    }

    // Namespace ob_activity_locked_in
    // Params 0, eflags: 0x4
    // Checksum 0x4f51034, Offset: 0x9499
    // Size: 0x1ed, Type: dev
    function private function_2c0a6a109b3d1c4d()
    {
        me = level.players[ 0 ];
        
        while ( level.players.size < 5 )
        {
            bots::spawn_bots( 1, me.team );
            wait 2;
        }
        
        locked_in_instance = function_8b58d0669fba51d9();
        
        if ( !locked_in_instance )
        {
            return;
        }
        
        foreach ( p in level.players )
        {
            if ( isbot( p ) )
            {
                p val::reset( "<dev string:x1b91>", "<dev string:x1ba2>" );
            }
            
            if ( !activity_participation::function_e7fc1202ac164928( locked_in_instance, p ) )
            {
                activity_participation::function_bc67362dace4370c( locked_in_instance, p );
            }
        }
        
        wait 1;
        
        foreach ( p in level.players )
        {
            same_squad = squad_utility::function_6a77a8d0f8eb25b5( me, p );
            
            if ( same_squad )
            {
                continue;
            }
            
            if ( player::isreallyalive( p ) )
            {
                mf = anglestoforward( me.angles );
                p setorigin( me.origin + mf * 100 );
                p botsetflag( "<dev string:x1b14>", 1 );
                wait 2;
                p dodamage( 200, p.origin, undefined, undefined, "<dev string:x1bb7>" );
                break;
            }
        }
    }

#/
