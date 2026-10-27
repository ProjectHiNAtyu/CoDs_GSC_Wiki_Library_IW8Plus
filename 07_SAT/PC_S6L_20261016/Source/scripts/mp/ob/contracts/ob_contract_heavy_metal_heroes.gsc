// scripts\mp\ob\contracts\ob_contract_heavy_metal_heroes.gsc  (hash_73df76c4cac28cf7.gscc) (size: 34585 Bytes / 0x8719 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x61efe359 (1643111257)
// size ...... 34585 (0x8719)
// includes .. 36  (offset: 0x8205)
// strings ... 60  (offset: 0x8325)
// dev strs .. 8   (offset: 0x86b5)
// exports ... 78  (offset: 0x5761)
// cseg ...... 0x6f9 + 0x5068 (0x5761)
// imports ... 247 (offset: 0x6391)
// animtree1 . 0   (offset: 0x8719)
// animtree2 . 0   (offset: 0x8719)
#using script_3455b106458253e7;
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\systems\countdown_timer;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\vehicles\damage;

#namespace ob_contract_heavy_metal_heroes;

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x5
// Checksum 0x43f1156, Offset: 0x717
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_56713aeb57079a71", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0x6d1a0223, Offset: 0x740
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_HEAVY_METAL_HEROES", &activity_type_init );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0x83a8eab5, Offset: 0x75b
// Size: 0x158
function private activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_HEAVY_METAL_HEROES", 0, &function_a28ae045c0c397d1 );
    activity_common::function_944074f3079c1d4e( "REV_OB_HEAVY_METAL_HEROES", 1, &function_2e16dc2b421c18b9 );
    activity_common::function_944074f3079c1d4e( "REV_OB_HEAVY_METAL_HEROES", 2, &function_2412ca6b042f8219 );
    activity_common::function_944074f3079c1d4e( "REV_OB_HEAVY_METAL_HEROES", 3, &function_cfe6a3cd001f9536 );
    activity_common::function_944074f3079c1d4e( "REV_OB_HEAVY_METAL_HEROES", 4, &function_c18b8da93eaf0a55 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_HEAVY_METAL_HEROES" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_HEAVY_METAL_HEROES" );
    level.var_9d8e0c9c02c4989 = [];
    level callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    level callback::add( #"hash_8267c353428d4773", &can_enter_vehicle );
    level callback::add( #"hash_652eb614ba902b3d", &on_player_damaged );
    level callback::add( #"player_vehicle_enter", &on_enter_vehicle );
    level callback::add( #"player_vehicle_seat_switch", &function_43005fe1b193eff4 );
    level callback::add( #"player_vehicle_exit", &function_ae5443addadebb98 );
    scriptable::scriptable_adddamagedcallback( &roadblock_damaged );
    level.var_f4fbc46e88020267 = throttle::throttle_initialize( "hmh_roadblock", 2 );
    level.var_2ffc35c0415132de = [ "sat_cover_toggleable_decor_barrels_gameplay_red", "sat_cover_toggleable_decor_barrels_kaboom_explosive" ];
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0x2e9c7542, Offset: 0x8bb
// Size: 0x2e4
function private function_a28ae045c0c397d1()
{
    self.s_center = utility::getstruct( self.varianttag, "targetname" );
    custom_props = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_12aa6de031706445 = 1;
    self.var_4f92c012bae0b7c4 = custom_props.var_95586341dbb46fa4;
    self.var_8145195a546f53ab = custom_props.var_c91e009231ca99ad;
    self.var_cf4fadcab95e9938 = self.var_8145195a546f53ab * 1000;
    self.var_819ac6c47b97e64e = custom_props.var_45b17c8d0e4d491;
    self.var_59e5d4c2cb3eb38f = self.var_819ac6c47b97e64e * 1000;
    self.var_a23534a97e1b8f04 = custom_props.var_ca9e106c1f919d96;
    self.var_f0750406fc5af6bc = custom_props.var_bb6b1bc50574479;
    self.var_d72980167bf0f2c3 = custom_props.var_80ca7fc8a4153a71;
    self.var_a638c66629c8997d = custom_props.var_e598d55ba97f634;
    self.var_9ac5266c981c854b = custom_props.var_81c1400bd01d7f3b;
    self.var_65a2e244df8de586 = custom_props.var_1b94dd92faa770e;
    self.var_202c1f9e662ad308 = custom_props.var_1e2b352bf920ca5f ?? 0.3;
    self.var_dbe9dce9a9150034 = custom_props.var_df604e64e32a980f;
    self.var_a56eb9b345a223ba = custom_props.var_9fea65c33d926ba;
    self.var_c556cae8af7abc1f = custom_props.var_ddd5d36afcd9eded;
    self.var_f4b9f639b94dd3ad = custom_props.var_5e698ecba17ffc7a;
    self.var_3217fef5724ca9e1 = self.var_a23534a97e1b8f04;
    var_7b04d39f32340279 = [];
    
    foreach ( item in custom_props.var_aef281554a89a096 )
    {
        var_7b04d39f32340279[ var_7b04d39f32340279.size ] = item.scale;
    }
    
    self.var_7b04d39f32340279 = var_7b04d39f32340279;
    self.var_f648567308f6f6f1 = custom_props.var_40959b72abd17859;
    waitframe();
    
    if ( !setup_player_vehicle() )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    setup_path();
    setup_goal_ramp();
    self.low_speed_threshold = custom_props.lowspeedthreshold;
    self.var_687be6fe68eb271f = custom_props.var_20a5d58b9162ec7e;
    self.var_d7db203c5e7660aa = custom_props.var_f0f0395f1d40f725;
    self.var_f7f7f372047a46c = 0;
    self.reward_spawnpoint = self.s_center namespace_be3150865da9d2f1::get_linked_structs_filtered( "reward", "script_noteworthy" )[ 0 ];
    function_ce5efb1ca4370e9a();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xbb0ec70b, Offset: 0xba7
// Size: 0x25c
function private function_ce5efb1ca4370e9a()
{
    self.var_4f92c012bae0b7c4 = getdvarfloat( @"hash_c4e01d0b18659d", self.var_4f92c012bae0b7c4 );
    self.var_8145195a546f53ab = getdvarint( @"hash_918213c540012ca", self.var_8145195a546f53ab );
    self.var_cf4fadcab95e9938 = self.var_8145195a546f53ab * 1000;
    self.var_819ac6c47b97e64e = getdvarint( @"hash_b725a74d2b8ac203", self.var_819ac6c47b97e64e );
    self.var_59e5d4c2cb3eb38f = self.var_819ac6c47b97e64e * 1000;
    self.var_a23534a97e1b8f04 = getdvarint( @"hash_38776f207650d5dd", self.var_a23534a97e1b8f04 );
    self.var_f0750406fc5af6bc = getdvarint( @"hash_cee0ba27f7e74a05", self.var_f0750406fc5af6bc );
    self.var_d72980167bf0f2c3 = getdvarint( @"hash_627128632d7765aa", self.var_d72980167bf0f2c3 );
    self.var_a638c66629c8997d = getdvarint( @"hash_f97119e9ab265c00", self.var_a638c66629c8997d );
    self.var_9ac5266c981c854b = getdvarint( @"hash_361ae7093dd09eb0", self.var_9ac5266c981c854b );
    self.var_65a2e244df8de586 = getdvarint( @"hash_33a384b23f092915", self.var_65a2e244df8de586 );
    self.low_speed_threshold = getdvarfloat( @"hash_4ed12a33cdbf41ed", self.low_speed_threshold );
    self.var_687be6fe68eb271f = getdvarfloat( @"hash_374c4423a18ecfdc", self.var_687be6fe68eb271f );
    self.var_d7db203c5e7660aa = getdvarfloat( @"hash_61d050067043a205", self.var_d7db203c5e7660aa );
    self.var_202c1f9e662ad308 = getdvarfloat( @"hash_1adf623402b1b497", self.var_202c1f9e662ad308 );
    self.var_dbe9dce9a9150034 = getdvarint( @"hash_9e66d5ab916d89db", self.var_dbe9dce9a9150034 );
    self.var_a56eb9b345a223ba = getdvarint( @"hash_8de87ace65585dcf", self.var_a56eb9b345a223ba );
    self.var_c556cae8af7abc1f = getdvarint( @"hash_99c283a4d762f096", self.var_c556cae8af7abc1f );
    self.var_f648567308f6f6f1 = getdvarfloat( @"hash_aea8d4cee12d13b6", self.var_f648567308f6f6f1 );
    self.var_f4b9f639b94dd3ad = getdvarint( @"hash_38faa75a6731eed2", self.var_f4b9f639b94dd3ad );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xb4ece1e9, Offset: 0xe0b
// Size: 0x25f
function private function_2e16dc2b421c18b9()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    leveldatafordamagestate = vehicle_damage::function_9a9c7f377e631a4d( %"hash_bcbce1d4939f5a", "heavy" );
    leveldatafordamagestate.onentercallback = &function_62f7eab2b05c8f8d;
    leveldatafordamagestate.onexitcallback = &function_4be5bdeb29bd3501;
    thread update_checkpoint();
    seat_id_array = vehicle_occupancy::function_8a8e1601e7e6610( self.player_vehicle );
    
    foreach ( seat_id in seat_id_array )
    {
        vehicle_damage::set_occupant_damage_scale( self.player_vehicle vehicle::get_ref(), seat_id, self.var_f648567308f6f6f1 );
    }
    
    driver = self.playerparticipants[ 0 ];
    self.player_vehicle vehphys_setdefaultmotion();
    
    if ( isalive( driver ) )
    {
        vehicle_occupancy::enter( self.player_vehicle, "driver", driver, undefined, 1 );
    }
    
    self.vehicle_marker = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "heavy_metal_heroes_vehicle_marker", 0, 1 );
    objidpoolmanager::update_objective_onentity( self.vehicle_marker, self.player_vehicle );
    vehicle_interact::allow_use( self.player_vehicle, 1 );
    vehicle_occupancy::allow_movement( self.player_vehicle, 0, 0 );
    function_16023117256fc000( self.playerparticipants, 0 );
    pre_start_timer();
    function_16023117256fc000( self.playerparticipants, 1 );
    thread function_59da50a9bbfa1f49();
    vehicle_occupancy::allow_movement( self.player_vehicle, 1 );
    self.player_vehicle setcandamage( 1 );
    function_3fe81445c1c78f72();
    thread vehicle_speed_watcher();
    thread function_617f7de8182feb4b();
    thread function_5eff36af7b28c68d();
    thread function_f81a0e3e5a719b44();
    thread function_f6b03a24397ea9de();
    thread function_e4860ec6b0d723d6( self.player_vehicle );
    
    /#
        thread debug_spawn_agents();
        thread debug_draw_checkpoint_trigger();
        thread function_cbc9bc14f933f7d9();
        thread function_b7696ee98977ca20();
        thread function_7a13d90705d2fbf7();
        thread function_9c73fc3c18d70587();
        thread function_8ecdac488a1def86();
    #/
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0x86124420, Offset: 0x1072
// Size: 0x5a
function private function_2412ca6b042f8219()
{
    level musicbank_utility::function_4f253fd35ec68cbc( self.playerparticipants, #"hash_ce91aeb0ea00cc17" );
    activity_succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    
    if ( activity_succeeded )
    {
        thread function_256a9fa66e0ba95a( 5 );
    }
    else
    {
        function_5b73fe0352eea40d();
    }
    
    self.player_vehicle = undefined;
    thread cleanup_course( 5 );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0x8063874e, Offset: 0x10d4
// Size: 0x40
function private function_cfe6a3cd001f9536()
{
    level musicbank_utility::function_4f253fd35ec68cbc( self.playerparticipants, #"hash_ce91aeb0ea00cc17" );
    
    if ( self.player_vehicle )
    {
        function_5b73fe0352eea40d();
        self.player_vehicle = undefined;
    }
    
    thread cleanup_course();
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0xc
// Checksum 0xe8901b57, Offset: 0x111c
// Size: 0x2a4
function private cleanup_course( delay_seconds )
{
    self notify( #"hash_eb9e612c47559b4c" );
    self endon( #"hash_eb9e612c47559b4c" );
    
    if ( delay_seconds )
    {
        wait delay_seconds;
    }
    
    foreach ( checkpoint_scriptable in self.checkpoint_scriptable_array )
    {
        checkpoint_scriptable freescriptable();
    }
    
    self.checkpoint_scriptable_array = undefined;
    
    if ( self.var_5aae2ccabea14a1b )
    {
        self.var_5aae2ccabea14a1b delete();
        self.var_5aae2ccabea14a1b = undefined;
    }
    
    foreach ( item in self.item_array )
    {
        function_c7f8e8205f2e9b74( item );
    }
    
    self.item_array = undefined;
    
    foreach ( sign_struct in self.sign_struct_array )
    {
        remove_sign( sign_struct );
    }
    
    self.sign_struct_array = undefined;
    
    if ( self.end_point_ramp )
    {
        self.end_point_ramp freescriptable();
        self.end_point_ramp = undefined;
    }
    
    foreach ( scriptable in self.var_df6dcbdfa7a826c6 )
    {
        throttle::throttle_wait_in_queue( level.var_f4fbc46e88020267, self );
        scriptable setscriptablepartstate( #"state", #"hidden" );
        scriptable.hmh_roadblock_enabled = undefined;
    }
    
    self.var_df6dcbdfa7a826c6 = undefined;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 2, eflags: 0x4
// Checksum 0x18b5fa45, Offset: 0x13c8
// Size: 0x68, Type: bool
function private function_d8467e758ce7e501( paramstruct, var_28f126819639413f )
{
    activity_instance = paramstruct.activityinstance;
    
    if ( activity_instance.type != "REV_OB_HEAVY_METAL_HEROES" )
    {
        if ( var_28f126819639413f.player_vehicle && function_9bdeefb2e4311e78( self, var_28f126819639413f.player_vehicle ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x9567ff80, Offset: 0x1439
// Size: 0x12b
function private player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        guid = player player::getuniqueid();
        level.var_9d8e0c9c02c4989[ guid ] = self;
        level musicbank_utility::function_5aca66c390aa347d( player, #"hash_ce91aeb0ea00cc17" );
        player thread function_ccde296b9b7df9e9( self );
        player setclientomnvar( "ui_ob_enable_hmh_boost_prompt", 1 );
        player setclientomnvar( "ui_ob_hmh_show_slow_warning_level", self.slow_warning_level ?? 0 );
        player.var_753b31fc1dd0e162 = 1;
        player callback::add( #"hash_caf9b33006ac87e0", &function_d8467e758ce7e501, self );
    }
    
    if ( self.var_91caabbb915d5a7d )
    {
        function_16023117256fc000( player_list, 1 );
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0xaf569753, Offset: 0x156c
// Size: 0x15e
function private player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        guid = player player::getuniqueid();
        level.var_9d8e0c9c02c4989[ guid ] = undefined;
        player notify( #"hash_2860f566072a9669" );
        player setclientomnvar( "ui_ob_enable_hmh_boost_prompt", 0 );
        player setclientomnvar( "ui_ob_hmh_show_slow_warning_level", 0 );
        player setclientomnvar( "ui_ob_hmh_show_pre_race_text", 0 );
        player setclientomnvar( "ui_cranked_meter_is_shown", 0 );
        player setclientomnvar( "ui_match_start_countdown", 0 );
        player setclientomnvar( "ui_ob_hmh_time_gain_roadblock", 0 );
        player setclientomnvar( "ui_ob_hmh_time_gain_enemy", 0 );
        player thread countdown_timer::close( "ob_hmh_timer" );
        player.var_753b31fc1dd0e162 = undefined;
        level musicbank_utility::function_4f253fd35ec68cbc( player, #"hash_ce91aeb0ea00cc17" );
        player callback::remove( #"hash_caf9b33006ac87e0", &function_d8467e758ce7e501, self );
    }
    
    function_16023117256fc000( player_list, 0 );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xe79e4b27, Offset: 0x16d2
// Size: 0x209, Type: bool
function private setup_player_vehicle()
{
    var_d8b98e445a72f35b = level.activities.var_3a2ba6751c464ab7[ self.id ] ?? [];
    assert( var_d8b98e445a72f35b.size == 1 );
    self.joiner_scriptable = var_d8b98e445a72f35b[ 0 ];
    var_465b20e0d8be9bfd = self.joiner_scriptable.origin;
    var_79858549043f6653 = self.joiner_scriptable.angles;
    vehicle_ref = %"hash_bcbce1d4939f5a";
    spawn_data = { #triggerrecycle:1, #var_499a16b493ff31ed:1, #initai:0, #team:"neutral", #angles:var_79858549043f6653, #origin:var_465b20e0d8be9bfd };
    spawn_data vehicle_spawn::prevent_respawn();
    spawn_fail = {};
    self.player_vehicle = ob_resource_manager::activity_spawn_vehicle( vehicle_ref, spawn_data, spawn_fail );
    
    if ( !self.player_vehicle )
    {
        logstring( "Failed to spawn player vehicle for Heavy Metal Heroes activity." );
        return false;
    }
    
    self.player_vehicle vehphys_forcekeyframedmotion();
    self.player_vehicle.dontspawnhusk = 1;
    damage::set_post_mod_damage_callback( %"hash_bcbce1d4939f5a", &modify_vehicle_damage );
    self.player_vehicle setcandamage( 0 );
    self.player_vehicle.heavy_metal_heroes_activity_instance = self;
    self.player_vehicle.var_8104535d1b0b4e4 = 1;
    vehicle_interact::allow_use( self.player_vehicle, 0 );
    self.joiner_scriptable utility::scriptable_setparententity( self.player_vehicle, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.player_vehicle_scriptable = self.player_vehicle getlinkedscriptableinstance();
    self.player_vehicle_scriptable interaction::set_interact_hint_callback( &function_ea9e27f5ec5eab06 );
    return true;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xe742a515, Offset: 0x18e4
// Size: 0xc0
function private setup_path()
{
    start_points = self.s_center namespace_be3150865da9d2f1::get_linked_structs_filtered( "start_point", "script_noteworthy" );
    assert( start_points.size == 1 );
    self.start_point = start_points[ 0 ];
    point_iter = self.start_point;
    self.path_node_array = [];
    
    while ( point_iter.target )
    {
        self.path_node_array[ self.path_node_array.size ] = point_iter;
        point_iter = utility::getstruct( point_iter.target, "targetname" );
    }
    
    self.path_node_array[ self.path_node_array.size ] = point_iter;
    self.end_point = point_iter;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0x5e60173f, Offset: 0x19ac
// Size: 0xa0
function private setup_goal_ramp()
{
    goal_ramp_points = self.s_center namespace_be3150865da9d2f1::get_linked_structs_filtered( "goal_ramp_point", "script_noteworthy" );
    
    if ( goal_ramp_points.size >= 1 )
    {
        goal_ramp_point = goal_ramp_points[ 0 ];
        self.end_point_ramp = spawnscriptable( "heavy_metal_heroes_goal_ramp", goal_ramp_point.origin, goal_ramp_point.angles );
        return;
    }
    
    self.end_point_ramp = spawnscriptable( "heavy_metal_heroes_goal_ramp", self.end_point.origin, self.end_point.angles );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0x71ca66ad, Offset: 0x1a54
// Size: 0x15
function private function_c18b8da93eaf0a55()
{
    return self.player_vehicle.origin;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0x47026c9e, Offset: 0x1a72
// Size: 0x34b
function private pre_start_timer()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_91caabbb915d5a7d = 0;
    wait 2.2;
    var_a979c5baab5ea957 = 30;
    var_67548756b46dc539 = 3;
    
    while ( var_a979c5baab5ea957 )
    {
        var_61befe477d2de25a = [];
        
        foreach ( player in self.playerparticipants )
        {
            if ( function_9bdeefb2e4311e78( player, self.player_vehicle ) )
            {
                var_61befe477d2de25a[ var_61befe477d2de25a.size ] = player;
            }
        }
        
        if ( var_61befe477d2de25a.size == self.playerparticipants.size )
        {
            break;
        }
        
        foreach ( player in self.playerparticipants )
        {
            if ( !player scripted_widgets::is_active( "ob_hmh_timer" ) )
            {
                player thread countdown_timer::create( "ob_hmh_timer", "scripted_widget_countdown_banner_sat_ob_hmh", var_a979c5baab5ea957, undefined, &"hash_2c7501fd53da1fbb" );
            }
        }
        
        wait 1;
        var_a979c5baab5ea957 -= 1;
    }
    
    foreach ( player in self.playerparticipants )
    {
        player thread countdown_timer::close( "ob_hmh_timer" );
    }
    
    self notify( #"hash_d924268aebc6524e" );
    
    while ( var_67548756b46dc539 )
    {
        foreach ( player in self.playerparticipants )
        {
            player setclientomnvar( "ui_match_start_countdown", var_67548756b46dc539 );
        }
        
        wait 1;
        var_67548756b46dc539 -= 1;
    }
    
    foreach ( player in self.playerparticipants )
    {
        player setclientomnvar( "ui_ob_hmh_show_pre_race_text", 1 );
        player setclientomnvar( "ui_match_start_countdown", 0 );
        player utility::delaycallendon( 1, "death_or_disconnect", &setclientomnvar, "ui_ob_hmh_show_pre_race_text", 0 );
    }
    
    self notify( #"hmh_countdown_finished" );
    self.var_91caabbb915d5a7d = 1;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xf2928098, Offset: 0x1dc5
// Size: 0x216
function private function_617f7de8182feb4b()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"hash_27aecde850607f6b" );
    assert( self.var_3217fef5724ca9e1 > 0 );
    
    while ( self.var_3217fef5724ca9e1 > 0 && self.player_vehicle vehicle::isvehiclealive() )
    {
        self.var_3217fef5724ca9e1 = min( self.var_3217fef5724ca9e1, self.var_a23534a97e1b8f04 );
        
        if ( self.var_d363a0f4f509cbec && gettime() > self.var_d363a0f4f509cbec )
        {
            self.var_3217fef5724ca9e1 -= 0.1 * self.var_4f92c012bae0b7c4;
        }
        else
        {
            self.var_3217fef5724ca9e1 -= 0.1;
        }
        
        /#
            if ( getdvarint( @"hash_421a1822c8acc062", 0 ) )
            {
                if ( self.var_3217fef5724ca9e1 / self.var_a23534a97e1b8f04 < 0.05 )
                {
                    self.var_3217fef5724ca9e1 = 0.05 * self.var_a23534a97e1b8f04;
                }
            }
        #/
        
        if ( self.var_3217fef5724ca9e1 <= 0 )
        {
            break;
        }
        
        foreach ( player in self.playerparticipants )
        {
            if ( player.var_5eaabe0343c8ea0 != self.var_a23534a97e1b8f04 )
            {
                player setclientomnvar( "ui_cranked_timer_time_max", int( self.var_a23534a97e1b8f04 * 1000 ) );
                player.var_5eaabe0343c8ea0 = self.var_a23534a97e1b8f04;
            }
            
            player setclientomnvar( "ui_cranked_timer_time", int( self.var_3217fef5724ca9e1 * 1000 ) );
        }
        
        wait 0.1;
    }
    
    activity_instance_common::endactivity( self, 0 );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0xdf298fd4, Offset: 0x1fe3
// Size: 0x2c8
function private function_256a9fa66e0ba95a( max_delay_seconds )
{
    player_vehicle = self.player_vehicle;
    player_vehicle setcandamage( 0 );
    player_vehicle notify( #"hmh_boost_fx_cleanup" );
    previous_vehicle_z = player_vehicle gettagorigin( "tag_hood_d0" )[ 2 ];
    max_delay_milliseconds = max_delay_seconds * 1000;
    start_time = gettime();
    
    while ( gettime() - start_time <= max_delay_milliseconds )
    {
        current_vehicle_z = player_vehicle gettagorigin( "tag_hood_d0" )[ 2 ];
        
        if ( current_vehicle_z < previous_vehicle_z )
        {
            break;
        }
        
        previous_vehicle_z = current_vehicle_z;
        wait 0.5;
    }
    
    vehicle_occupants = vehicle_occupancy::get_all_occupants( player_vehicle );
    
    foreach ( occupant in vehicle_occupants )
    {
        vehicle_occupancy::exit( player_vehicle, occupant.seatid, occupant, undefined, 1 );
    }
    
    wait 0.5;
    
    if ( !player_vehicle vehicle_isonground() )
    {
        vehicle_occupants = utility::function_8391781ea0784541( vehicle_occupants );
        vehicle_forward_vector = anglestoforward( player_vehicle.angles );
        player_vehicle notify( #"hmh_boost_fx_on" );
        var_59bd58a87993e0e5 = ( vehicle_forward_vector[ 0 ], vehicle_forward_vector[ 1 ], 0 );
        player_vehicle vehicle_setvelocity( ( 0, 0, 400 ) + var_59bd58a87993e0e5 * 2000 );
        
        foreach ( occupant in vehicle_occupants )
        {
            if ( occupant iswingsuitdeployed() )
            {
                continue;
            }
            
            content_filter = trace::create_contents( 0, 1, 0, 1, 0, 0, 1 );
            trace_result = trace::ray_trace( occupant.origin, occupant.origin + ( 0, 0, -200 ), player_vehicle, content_filter );
            
            if ( trace_result[ "hittype" ] && trace_result[ "hittype" ] != "hittype_none" )
            {
                continue;
            }
            
            occupant skydive_beginfreefall();
            occupant skydive_deployparachute();
            occupant setvelocity( ( 0, 0, 200 ) + var_59bd58a87993e0e5 * 150 );
        }
    }
    
    player_vehicle setcandamage( 1 );
    player_vehicle utility::delaythreadendon( 2, "death", &vehicle::explode );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xc6064753, Offset: 0x22b3
// Size: 0x30
function private function_5b73fe0352eea40d()
{
    if ( !self.player_vehicle )
    {
        return;
    }
    
    vehicle_occupancy::eject_all_occupants( self.player_vehicle );
    self.player_vehicle vehicle::explode();
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0x483db9a2, Offset: 0x22eb
// Size: 0x12
function private function_3fe81445c1c78f72()
{
    thread function_ec4da7a8e1314077( self.s_center );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xa20bd664, Offset: 0x2305
// Size: 0x552
function private update_checkpoint()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.active_checkpoint = self.start_point;
    self.checkpoint_scriptable_array = [];
    self.checkpoint_scriptable_array[ 0 ] = spawnscriptable( "heavy_metal_heroes_checkpoint", self.active_checkpoint.origin, self.active_checkpoint.angles );
    self.checkpoint_scriptable_array[ 1 ] = spawnscriptable( "heavy_metal_heroes_checkpoint", self.active_checkpoint.origin, self.active_checkpoint.angles );
    self.var_7645a87924d5a459 = 0;
    self.checkpoint_scriptable_array[ self.var_7645a87924d5a459 ] setscriptablepartstate( #"checkpoint_vfx", #"on" );
    self.var_5aae2ccabea14a1b = spawn( "noent_volume_trigger_box", self.active_checkpoint.origin, 0, ( 30, 150, 230 ), ( 30, 150, 230 ) );
    self.var_5aae2ccabea14a1b.angles = self.active_checkpoint.angles;
    self.checkpoint_marker = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_heavy_metal_heroes_checkpoint", 0, 1 );
    objidpoolmanager::update_objective_position( self.checkpoint_marker, self.player_vehicle.origin );
    ob_contract_ui_widget::function_572260f3b30f1e52( 1, self.var_f7f7f372047a46c, self.path_node_array.size, self.playerparticipants );
    self waittill( #"hash_d924268aebc6524e" );
    objidpoolmanager::update_objective_position( self.checkpoint_marker, self.active_checkpoint.origin );
    objidpoolmanager::update_objective_setzoffset( self.checkpoint_marker, 300 );
    self.start_time = gettime();
    
    while ( true )
    {
        self.var_5aae2ccabea14a1b waittill( #"trigger", ent );
        
        if ( ent == self.player_vehicle )
        {
            thread function_ec4da7a8e1314077( self.active_checkpoint );
            ent vehicle_damage::add_health( self.var_65a2e244df8de586 );
            self.checkpoint_scriptable_array[ self.var_7645a87924d5a459 ] setscriptablepartstate( #"checkpoint_vfx", #"triggered" );
            self.var_f7f7f372047a46c++;
            ob_contract_ui_widget::function_572260f3b30f1e52( 1, self.var_f7f7f372047a46c, self.path_node_array.size, self.playerparticipants );
            self.var_7645a87924d5a459 = abs( self.var_7645a87924d5a459 - 1 );
            
            if ( self.var_f7f7f372047a46c >= self.path_node_array.size )
            {
                function_9ba7fbd7cd2c3806();
                break;
            }
            
            foreach ( player in self.playerparticipants )
            {
                if ( function_9bdeefb2e4311e78( player, self.player_vehicle ) )
                {
                    player playlocalsound( "evt_sat_wc_s5_race_checkpoint" );
                }
            }
            
            if ( self.var_f7f7f372047a46c >= 5 )
            {
                function_2831379a6c240c2( self.path_node_array[ self.var_f7f7f372047a46c - 5 ] );
            }
            
            if ( self.var_f7f7f372047a46c >= 3 )
            {
                function_c736829d010a8c38( self.path_node_array[ self.var_f7f7f372047a46c - 3 ] );
            }
            
            self.active_checkpoint = self.path_node_array[ self.var_f7f7f372047a46c ];
            checkpoint_ground_origin = getgroundposition( self.active_checkpoint.origin + ( 0, 0, 100 ), 1 );
            self.checkpoint_scriptable_array[ self.var_7645a87924d5a459 ].origin = checkpoint_ground_origin;
            self.checkpoint_scriptable_array[ self.var_7645a87924d5a459 ].angles = self.active_checkpoint.angles;
            self.checkpoint_scriptable_array[ self.var_7645a87924d5a459 ] setscriptablepartstate( #"checkpoint_vfx", #"on" );
            self.var_5aae2ccabea14a1b.origin = checkpoint_ground_origin;
            self.var_5aae2ccabea14a1b.angles = self.active_checkpoint.angles;
            objidpoolmanager::update_objective_position( self.checkpoint_marker, self.active_checkpoint.origin );
            wait 1;
        }
    }
    
    self notify( #"hash_27aecde850607f6b" );
    var_dd1fce694add64d0 = math::round_float( ( gettime() - self.start_time ) / 1000, 2, 1 );
    spawn_reward();
    activity_player_common::function_674cca638cafcae3( self.playerparticipants, self, "ui_mission_completion_time", var_dd1fce694add64d0, 0 );
    waitframe();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x89d540a, Offset: 0x285f
// Size: 0x5f
function private function_351a854e4774db82( struct )
{
    assert( struct.target );
    struct.checkpoint_encounter = activity_ai_encounters::function_92b671064b0b1ce2( struct.target, 1, 0, 1, 0 );
    activity_ai_encounters::function_52d1342183200a8f( struct.checkpoint_encounter, &on_agent_spawned, [ self ] );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x5ae24811, Offset: 0x28c6
// Size: 0x37
function private function_c82b873ae586eb93( struct )
{
    if ( struct.checkpoint_encounter )
    {
        activity_ai_encounters::function_1010ba035d94f9f1( struct.checkpoint_encounter );
        struct.checkpoint_encounter = undefined;
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0xf129baef, Offset: 0x2905
// Size: 0x13d
function private function_ec4da7a8e1314077( checkpoint )
{
    linked_struct_array = checkpoint utility::get_linked_structs();
    
    foreach ( struct in linked_struct_array )
    {
        if ( !isdefined( struct.script_label ) )
        {
            continue;
        }
        
        switch ( struct.script_label )
        {
            case #"hash_49b0921043e8a5ca":
                function_656d14ad31a24113( struct );
                break;
            case #"hash_88aa41e64aa08b4":
                function_3463876293d62824( struct );
                break;
            case #"hash_690f9f8babbfa6c":
                function_351a854e4774db82( struct );
                break;
            case #"hash_90c460bd0ca7c985":
                spawn_item( struct );
                break;
            case #"hash_decf194a020a3bba":
                set_vehicle_headlights( struct );
                break;
            case #"hash_d130218a04155204":
                spawn_sign( struct );
                break;
        }
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x1bf1e26e, Offset: 0x2a4a
// Size: 0xca
function private function_2831379a6c240c2( checkpoint )
{
    linked_struct_array = checkpoint utility::get_linked_structs();
    
    foreach ( struct in linked_struct_array )
    {
        switch ( struct.script_label )
        {
            case #"hash_90c460bd0ca7c985":
                function_c7f8e8205f2e9b74( struct );
                break;
            case #"hash_d130218a04155204":
                remove_sign( struct );
                break;
        }
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xe6811c3, Offset: 0x2b1c
// Size: 0x119
function private function_9ba7fbd7cd2c3806()
{
    foreach ( scriptable in self.var_8a63a97938896645 )
    {
        scriptable setscriptablepartstate( #"state", #"end" );
    }
    
    foreach ( player in self.playerparticipants )
    {
        if ( function_9bdeefb2e4311e78( player, self.player_vehicle ) )
        {
            player playlocalsound( "evt_sat_wc_s5_race_finish" );
        }
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x4471fd1e, Offset: 0x2c3d
// Size: 0xb2
function private function_c736829d010a8c38( checkpoint )
{
    linked_struct_array = checkpoint utility::get_linked_structs();
    
    foreach ( struct in linked_struct_array )
    {
        switch ( struct.script_label )
        {
            case #"hash_690f9f8babbfa6c":
                function_c82b873ae586eb93( struct );
                break;
        }
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x929a912d, Offset: 0x2cf7
// Size: 0xfe
function private function_3463876293d62824( struct )
{
    scriptable_array = getentitylessscriptablearray( struct.target, #targetname );
    
    if ( !isdefined( self.var_df6dcbdfa7a826c6 ) )
    {
        self.var_df6dcbdfa7a826c6 = [];
    }
    
    foreach ( scriptable in scriptable_array )
    {
        if ( scriptable getscriptableparthasstate( #"state", #"end" ) )
        {
            if ( !isdefined( self.var_8a63a97938896645 ) )
            {
                self.var_8a63a97938896645 = [];
            }
            
            self.var_8a63a97938896645[ self.var_8a63a97938896645.size ] = scriptable;
        }
        
        thread function_e922ec6c109967d1( scriptable );
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0xf2a48154, Offset: 0x2dfd
// Size: 0x97
function private function_e922ec6c109967d1( scriptable )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    throttle::throttle_wait_in_queue( level.var_f4fbc46e88020267, self );
    nearby_player_array = getplayersinradius( scriptable.origin, 100 );
    
    if ( nearby_player_array.size )
    {
        return;
    }
    
    self.var_df6dcbdfa7a826c6[ self.var_df6dcbdfa7a826c6.size ] = scriptable;
    scriptable.hmh_roadblock_enabled = 1;
    scriptable setscriptablepartstate( #"state", #"visible" );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x84cbe13b, Offset: 0x2e9c
// Size: 0xbc
function private function_656d14ad31a24113( struct )
{
    var_5d77587cedddea42 = getentarray( struct.target, #targetname );
    
    foreach ( bridge_piece in var_5d77587cedddea42 )
    {
        if ( bridge_piece.bridgedirection == #"down" )
        {
            bridge_piece notify( #"activate" );
        }
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x75477d8b, Offset: 0x2f60
// Size: 0xb2
function private spawn_item( struct )
{
    var_34cdd5cda21b2ad1 = spawnscriptable( struct.script_parameters, struct.origin, struct.angles );
    item_trigger = spawn( "noent_volume_trigger_radius", struct.origin, 0, 50, 50 );
    
    if ( !isdefined( self.item_array ) )
    {
        self.item_array = [];
    }
    
    struct.var_34cdd5cda21b2ad1 = var_34cdd5cda21b2ad1;
    struct.item_trigger = item_trigger;
    self.item_array[ self.item_array.size ] = struct;
    thread function_f58789eb44f43ce1( struct );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0xe2bc5234, Offset: 0x301a
// Size: 0x278
function private function_f58789eb44f43ce1( struct )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        struct.item_trigger waittill( #"trigger", ent );
        
        if ( ent == self.player_vehicle )
        {
            foreach ( player in self.playerparticipants )
            {
                if ( function_9bdeefb2e4311e78( player, self.player_vehicle ) )
                {
                    player playlocalsound( "evt_sat_wc_s5_race_item" );
                }
            }
            
            switch ( struct.script_parameters )
            {
                case #"hash_88aba63627164ffa":
                    self.player_vehicle function_bb449a59e0a2405b( 100 );
                    break;
                case #"hash_1a8fd6bfa6f7486f":
                    function_de19aadb99b1a9dd( struct );
                    break;
                case #"hash_51ef7167ca31fa6":
                    self.player_vehicle vehicle_damage::restore_max_health();
                    
                    foreach ( player in self.playerparticipants )
                    {
                        if ( function_9bdeefb2e4311e78( player, self.player_vehicle ) && player utility::callsharedfunc( #"ammo_item", #"can_refill_ammo" ) )
                        {
                            player utility::callsharedfunc( #"ammo_item", #"hash_3767b91cf7dcf69c" );
                        }
                    }
                    
                    break;
            }
            
            struct.item_trigger triggerdisable();
            
            if ( struct.var_34cdd5cda21b2ad1 getscriptableparthasstate( #"body", #"loot" ) )
            {
                struct.var_34cdd5cda21b2ad1 setscriptablepartstate( #"body", #"loot" );
                wait 0.5;
            }
            else
            {
                wait 5;
            }
            
            function_c7f8e8205f2e9b74( struct );
            break;
        }
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0xc166475d, Offset: 0x329a
// Size: 0x5e
function private function_c7f8e8205f2e9b74( struct )
{
    if ( struct.var_34cdd5cda21b2ad1 )
    {
        struct.var_34cdd5cda21b2ad1 freescriptable();
        struct.var_34cdd5cda21b2ad1 = undefined;
    }
    
    if ( struct.item_trigger )
    {
        struct.item_trigger delete();
        struct.item_trigger = undefined;
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x9c0da8f, Offset: 0x3300
// Size: 0x38
function private function_de19aadb99b1a9dd( var_971419554aa6e36c )
{
    vehicle = self.player_vehicle;
    
    if ( !vehicle function_6b4da52d63f1a32b( var_971419554aa6e36c ) )
    {
        return;
    }
    
    thread function_860e5ad7bfecd4e( vehicle );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x6580926, Offset: 0x3340
// Size: 0x7f
function private function_860e5ad7bfecd4e( vehicle )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    vehicle endon( #"death" );
    var_bd770cf600f1cf15 = vehicle vehicle_gettopspeedforward();
    vehicle notify( #"hmh_boost_fx_on" );
    vehicle vehicle_settopspeedforward( self.var_687be6fe68eb271f );
    wait self.var_d7db203c5e7660aa;
    vehicle vehicle_settopspeedforward( var_bd770cf600f1cf15 );
    vehicle notify( #"hmh_boost_fx_off" );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0xbac37642, Offset: 0x33c7
// Size: 0xe2
function private function_e4860ec6b0d723d6( vehicle )
{
    vehicle endon( #"death" );
    boost_stack = 0;
    
    while ( true )
    {
        msg = vehicle utility::waittill_any_return( "hmh_boost_fx_on", "hmh_boost_fx_off", "hmh_boost_fx_cleanup" );
        
        if ( msg == "hmh_boost_fx_on" )
        {
            boost_stack++;
            
            if ( boost_stack == 1 )
            {
                vehicle setscriptablepartstate( #"boost", #"on" );
            }
            
            continue;
        }
        
        if ( msg == "hmh_boost_fx_off" )
        {
            boost_stack = max( boost_stack - 1, 0 );
            
            if ( boost_stack == 0 )
            {
                vehicle setscriptablepartstate( #"boost", #"off" );
            }
            
            continue;
        }
        
        if ( msg == "hmh_boost_fx_cleanup" )
        {
            boost_stack = 0;
            vehicle setscriptablepartstate( #"boost", #"off" );
        }
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x2f219d6e, Offset: 0x34b1
// Size: 0x6d, Type: bool
function private function_6b4da52d63f1a32b( var_971419554aa6e36c )
{
    veh_forward_dir = anglestoforward( ( 0, self.angles[ 1 ], 0 ) );
    panel_forward_dir = anglestoforward( ( 0, var_971419554aa6e36c.var_34cdd5cda21b2ad1.angles[ 1 ], 0 ) );
    vector_dot = vectordot( veh_forward_dir, panel_forward_dir );
    return vector_dot > 0.5;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xe04633c2, Offset: 0x3527
// Size: 0x95
function private vehicle_speed_watcher()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.player_vehicle endon( #"death" );
    
    while ( true )
    {
        speed = self.player_vehicle vehicle_getspeed();
        
        if ( speed < self.low_speed_threshold )
        {
            if ( !self.var_d363a0f4f509cbec )
            {
                self.var_d363a0f4f509cbec = gettime() + self.var_cf4fadcab95e9938;
            }
        }
        else
        {
            self.var_d363a0f4f509cbec = undefined;
        }
        
        wait 0.1;
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0x45d865e6, Offset: 0x35c4
// Size: 0x206
function private function_5eff36af7b28c68d()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.slow_warning_level = 0;
    
    while ( true )
    {
        if ( self.var_d363a0f4f509cbec )
        {
            if ( gettime() > self.var_d363a0f4f509cbec )
            {
                if ( self.slow_warning_level != 2 )
                {
                    self.slow_warning_level = 2;
                    
                    foreach ( player in self.playerparticipants )
                    {
                        player setclientomnvar( "ui_ob_hmh_show_slow_warning_level", 2 );
                    }
                }
            }
            else if ( self.slow_warning_level != 1 )
            {
                self.slow_warning_level = 1;
                
                foreach ( player in self.playerparticipants )
                {
                    player setclientomnvar( "ui_ob_hmh_show_slow_warning_level", 1 );
                }
            }
        }
        else if ( self.slow_warning_level != 0 )
        {
            foreach ( player in self.playerparticipants )
            {
                player setclientomnvar( "ui_ob_hmh_show_slow_warning_level", 0 );
            }
            
            self.slow_warning_level = 0;
        }
        
        wait 0.1;
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 4
// Checksum 0x188e5312, Offset: 0x37d2
// Size: 0x7b
function on_agent_spawned( requestid, userdata, agent, data )
{
    agent callback::add( "spawn_animscripted", &on_spawn_animscripted );
    
    if ( agent.unittype == "zombie" )
    {
        agent region_difficulty_manager::function_410b4f83b0a5b98( "difficulty5" );
    }
    else
    {
        agent ob_humans::function_5bc0e59d126a6295( "difficulty5" );
    }
    
    agent.is_hmh_agent = 1;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1
// Checksum 0xc8b441c7, Offset: 0x3855
// Size: 0x25
function on_spawn_animscripted( params )
{
    utility::delaycallendon( 0.02, "death", &animmode, "zonly_physics" );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1
// Checksum 0xa9a3e8d, Offset: 0x3882
// Size: 0x1b0
function function_8c5e06ee1e60aeb7( params )
{
    attacker = params.eattacker ?? params.attacker;
    var_6927b27a68eccd9e = attacker;
    
    if ( !isplayer( attacker ) )
    {
        if ( isplayer( attacker.owner ) )
        {
            var_6927b27a68eccd9e = attacker.owner;
        }
        else if ( isplayer( params.einflictor.owner ) )
        {
            var_6927b27a68eccd9e = params.einflictor.owner;
        }
        else
        {
            return;
        }
    }
    
    guid = var_6927b27a68eccd9e player::getuniqueid();
    activity_instance = level.var_9d8e0c9c02c4989[ guid ];
    
    if ( activity_instance )
    {
        if ( distance( activity_instance.player_vehicle.origin, var_6927b27a68eccd9e.origin ) > 5000 )
        {
            return;
        }
        
        current_time = gettime();
        last_time_killed_enemy = current_time;
        
        if ( activity_instance.var_d363a0f4f509cbec )
        {
            activity_instance.var_d363a0f4f509cbec = last_time_killed_enemy + activity_instance.var_59e5d4c2cb3eb38f;
        }
        
        var_d8ee62d6b9efa1bf = 0;
        
        if ( params.einflictor vehicle::is_vehicle() )
        {
            var_d8ee62d6b9efa1bf = activity_instance function_ca06b2dd9367e041( activity_instance.var_d72980167bf0f2c3 );
        }
        else
        {
            var_d8ee62d6b9efa1bf = activity_instance function_ca06b2dd9367e041( activity_instance.var_f0750406fc5af6bc );
        }
        
        activity_instance add_vehicle_countdown_timer( var_d8ee62d6b9efa1bf, var_6927b27a68eccd9e, 0 );
        activity_instance.player_vehicle function_bb449a59e0a2405b( activity_instance.var_9ac5266c981c854b );
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 3
// Checksum 0xcb00873d, Offset: 0x3a3a
// Size: 0x46
function add_vehicle_countdown_timer( seconds_to_add, var_6927b27a68eccd9e, is_roadblock_hit )
{
    if ( seconds_to_add <= 0 )
    {
        return;
    }
    
    self.var_3217fef5724ca9e1 += seconds_to_add;
    function_5dac77c1035f4ff( seconds_to_add, var_6927b27a68eccd9e, is_roadblock_hit );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1
// Checksum 0x492c4aa2, Offset: 0x3a88
// Size: 0x79
function on_player_damaged( params )
{
    attacker = params.eattacker ?? params.attacker;
    
    if ( attacker.is_hmh_agent || params.einflictor.is_hmh_agent )
    {
        params.idamage = min( params.idamage, 1 );
        return;
    }
    
    return;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1
// Checksum 0xf17688fd, Offset: 0x3b09
// Size: 0x80, Type: bool
function can_enter_vehicle( params )
{
    vehicle = params.vehicle;
    
    if ( !vehicle.heavy_metal_heroes_activity_instance )
    {
        return true;
    }
    
    player = params.player;
    guid = player player::getuniqueid();
    activity_instance = level.var_9d8e0c9c02c4989[ guid ];
    return activity_instance == vehicle.heavy_metal_heroes_activity_instance;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1
// Checksum 0xb9d62b7, Offset: 0x3b92
// Size: 0x19f
function function_ca06b2dd9367e041( var_a08301ff6d817e41 )
{
    activity_instance = self;
    var_699a5af99f56363d = clamp( activity_instance.playerparticipants.size, 0, 4 );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        if ( !function_9bdeefb2e4311e78( player, activity_instance.player_vehicle ) )
        {
            var_699a5af99f56363d--;
        }
    }
    
    var_b7046932af023c84 = self.var_7b04d39f32340279[ var_699a5af99f56363d ] * var_a08301ff6d817e41;
    current_time_seconds = utility::function_6f5d2e1f1ff70482( gettime() );
    
    if ( activity_instance.var_3867c05f53414b51 )
    {
        if ( current_time_seconds == activity_instance.var_3867c05f53414b51 )
        {
            if ( activity_instance.var_9300799317bce80b + var_b7046932af023c84 > activity_instance.var_a638c66629c8997d )
            {
                var_9fd6c66bf2dae1f4 = activity_instance.var_a638c66629c8997d - activity_instance.var_9300799317bce80b;
                activity_instance.var_9300799317bce80b = activity_instance.var_a638c66629c8997d;
                return var_9fd6c66bf2dae1f4;
            }
            
            activity_instance.var_9300799317bce80b += var_b7046932af023c84;
            return var_b7046932af023c84;
        }
    }
    
    activity_instance.var_3867c05f53414b51 = current_time_seconds;
    activity_instance.var_9300799317bce80b = var_b7046932af023c84;
    return var_b7046932af023c84;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 3
// Checksum 0x903f3b31, Offset: 0x3d3a
// Size: 0x194
function function_5dac77c1035f4ff( seconds_to_add, var_6927b27a68eccd9e, is_roadblock_hit )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( seconds_to_add > 0 )
    {
        foreach ( player in self.playerparticipants )
        {
            if ( player != vehicle_occupancy::get_driver( self.player_vehicle ) && var_6927b27a68eccd9e != player )
            {
                continue;
            }
            
            if ( !player.var_abadc456f7d145b3 )
            {
                player.var_369ea76f6116914f = 0;
                player.var_2373b697ba455360 = 0;
            }
            
            if ( is_roadblock_hit )
            {
                player.var_369ea76f6116914f += seconds_to_add;
                player setclientomnvar( "ui_ob_hmh_time_gain_roadblock", math::round_float( player.var_369ea76f6116914f, 2, 0 ) );
                player thread function_5e31e6fce5d145b( self, "ui_ob_hmh_time_gain_roadblock", 3 );
                continue;
            }
            
            player.var_2373b697ba455360 += seconds_to_add;
            player setclientomnvar( "ui_ob_hmh_time_gain_enemy", math::round_float( player.var_2373b697ba455360, 2, 0 ) );
            player thread function_5e31e6fce5d145b( self, "ui_ob_hmh_time_gain_enemy", 3 );
        }
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 3, eflags: 0x4
// Checksum 0x424e7a22, Offset: 0x3ed6
// Size: 0x7b
function private function_5e31e6fce5d145b( activity_instance, omnvar_name, delay_seconds )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self endon( #"disconnect" );
    self notify( omnvar_name + "_cleanup" );
    self endon( omnvar_name + "_cleanup" );
    self.var_abadc456f7d145b3 = 1;
    wait delay_seconds;
    self.var_abadc456f7d145b3 = 0;
    self setclientomnvar( omnvar_name, 0 );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 2, eflags: 0x4
// Checksum 0x656d58bd, Offset: 0x3f59
// Size: 0x8c
function private function_16023117256fc000( player_list, to_show )
{
    foreach ( player in player_list )
    {
        player setclientomnvar( "ui_cranked_meter_is_shown", to_show );
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0xc
// Checksum 0x25580ef4, Offset: 0x3fed
// Size: 0x125
function private function_ccde296b9b7df9e9( activity_instance )
{
    self notify( #"hash_a265bce9897d278b" );
    self endon( #"hash_a265bce9897d278b" );
    player = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    player endon( #"disconnect" );
    player endon( #"hash_2860f566072a9669" );
    activity_instance.player_vehicle endon( #"death" );
    state = -1;
    
    while ( true )
    {
        if ( activity_instance.player_vehicle vehicle_occupancy::function_3080323254ba6900( player ) )
        {
            if ( state != 0 )
            {
                activity_instance ob_contract_ui_widget::function_d3aa02fc5d62637d( "REV_OB_HEAVY_METAL_HEROES", [ player ] );
                state = 0;
            }
        }
        else if ( function_9bdeefb2e4311e78( player, activity_instance.player_vehicle ) )
        {
            if ( state != 1 )
            {
                activity_instance ob_contract_ui_widget::function_d3aa02fc5d62637d( "REV_OB_HEAVY_METAL_HEROES_KILL_FOR_TIME_BONUS", [ player ] );
                state = 1;
            }
        }
        else if ( state != 2 )
        {
            activity_instance ob_contract_ui_widget::function_d3aa02fc5d62637d( "REV_OB_HEAVY_METAL_HEROES_ENTER_VEHICLE", [ player ] );
            state = 2;
        }
        
        wait 1;
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1
// Checksum 0x26c7f69, Offset: 0x411a
// Size: 0x91
function on_enter_vehicle( params )
{
    if ( !params.vehicle.heavy_metal_heroes_activity_instance )
    {
        return;
    }
    
    activity_instance = params.vehicle.heavy_metal_heroes_activity_instance;
    
    if ( params.seatid == "driver" )
    {
        params.player setclientomnvar( "ui_veh_show_boost", 1 );
    }
    
    activity_instance thread function_6b9833468baa6de6( params.vehicle, activity_instance.checkpoint_marker );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1
// Checksum 0xa7d16cc8, Offset: 0x41b3
// Size: 0xd2
function function_43005fe1b193eff4( params )
{
    if ( !params.vehicle.heavy_metal_heroes_activity_instance )
    {
        return;
    }
    
    activity_instance = params.vehicle.heavy_metal_heroes_activity_instance;
    
    if ( params.seatid == "driver" )
    {
        params.player setclientomnvar( "ui_veh_show_boost", 1 );
    }
    else if ( params.oldseatid == "driver" )
    {
        params.player setclientomnvar( "ui_veh_show_boost", 0 );
    }
    
    activity_instance thread function_6b9833468baa6de6( params.vehicle, activity_instance.checkpoint_marker );
    activity_instance thread function_9377bb852ca91ea( params.vehicle );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1
// Checksum 0xff39089, Offset: 0x428d
// Size: 0xa2
function function_ae5443addadebb98( params )
{
    if ( !params.vehicle.heavy_metal_heroes_activity_instance )
    {
        return;
    }
    
    activity_instance = params.vehicle.heavy_metal_heroes_activity_instance;
    params.vehicle vehicle_spawn::stop_watching_abandoned();
    params.player setclientomnvar( "ui_veh_show_boost", 0 );
    activity_instance thread function_6b9833468baa6de6( params.vehicle, activity_instance.checkpoint_marker );
    activity_instance thread function_9377bb852ca91ea( params.vehicle );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 2
// Checksum 0x2ddebb3c, Offset: 0x4337
// Size: 0x106
function function_6b9833468baa6de6( vehicle, marker )
{
    self notify( #"hash_7133b709b45fbbae" );
    self endon( #"hash_7133b709b45fbbae" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !self.var_91caabbb915d5a7d )
    {
        self waittill( #"hash_d924268aebc6524e" );
    }
    
    driver = vehicle_occupancy::get_driver( vehicle );
    objidpoolmanager::objective_playermask_hidefromall( marker );
    
    if ( driver )
    {
        objidpoolmanager::objective_playermask_addshowplayer( marker, driver );
        return;
    }
    
    foreach ( player in self.playerparticipants )
    {
        objidpoolmanager::objective_playermask_addshowplayer( marker, player );
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xeb6aa20, Offset: 0x4445
// Size: 0x271
function private function_59da50a9bbfa1f49()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.player_vehicle endon( #"death" );
    self.player_vehicle.var_23e3d3102967ca10 = 100;
    var_51d26796a1575908 = -1;
    previous_driver = undefined;
    var_4813e1c30557c846 = self.var_f4b9f639b94dd3ad * 1000;
    boost_state_set = 0;
    
    while ( true )
    {
        driver = vehicle_occupancy::get_driver( self.player_vehicle );
        
        if ( !self.player_vehicle function_cb9640aa0dbf3a74() && self.player_vehicle.var_23e3d3102967ca10 >= 100 )
        {
            self.player_vehicle function_ccacc3fd2c146e8( 1 );
        }
        
        if ( self.player_vehicle function_78fd833e3178e9b6() )
        {
            if ( !boost_state_set )
            {
                self.player_vehicle notify( #"hmh_boost_fx_on" );
                boost_state_set = 1;
            }
            
            if ( !self.player_vehicle.boost_start_time || self.player_vehicle.var_23e3d3102967ca10 == 100 )
            {
                self.player_vehicle.boost_start_time = gettime();
                self.player_vehicle.var_23e3d3102967ca10 = 0;
            }
            else
            {
                boost_elapsed = gettime() - self.player_vehicle.boost_start_time;
                
                if ( boost_elapsed >= var_4813e1c30557c846 )
                {
                    self.player_vehicle function_66b412c0366630c5();
                    self.player_vehicle function_ccacc3fd2c146e8( 0 );
                    self.player_vehicle.boost_start_time = undefined;
                    
                    if ( driver )
                    {
                        driver setclientomnvar( "ui_killstreak_boost_recharge_percentage", 0 );
                    }
                }
                else if ( driver )
                {
                    driver setclientomnvar( "ui_killstreak_boost_recharge_percentage", ( var_4813e1c30557c846 - boost_elapsed ) / var_4813e1c30557c846 );
                }
            }
        }
        else
        {
            if ( boost_state_set )
            {
                self.player_vehicle notify( #"hmh_boost_fx_off" );
                boost_state_set = 0;
            }
            
            if ( var_51d26796a1575908 != self.player_vehicle.var_23e3d3102967ca10 || previous_driver != driver )
            {
                if ( driver )
                {
                    driver setclientomnvar( "ui_killstreak_boost_recharge_percentage", self.player_vehicle.var_23e3d3102967ca10 / 100 );
                }
            }
        }
        
        var_51d26796a1575908 = self.player_vehicle.var_23e3d3102967ca10;
        previous_driver = driver;
        waitframe();
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x1e22d4f4, Offset: 0x46be
// Size: 0x2f
function private function_bb449a59e0a2405b( value )
{
    if ( value <= 0 )
    {
        return;
    }
    
    self.var_23e3d3102967ca10 = min( self.var_23e3d3102967ca10 + value, 100 );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xabae93e2, Offset: 0x46f5
// Size: 0x184
function private function_f6b03a24397ea9de()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.player_vehicle endon( #"death" );
    self.uturn_marker = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "heavy_metal_heroes_uturn_sign_marker", 1, 1 );
    objidpoolmanager::objective_playermask_hidefromallplayers( self.uturn_marker );
    objidpoolmanager::update_objective_onentity( self.uturn_marker, self.player_vehicle );
    prev_hidden = 1;
    previous_driver = undefined;
    
    while ( true )
    {
        driver = vehicle_occupancy::get_driver( self.player_vehicle );
        
        if ( !driver )
        {
            objidpoolmanager::objective_playermask_hidefromallplayers( self.uturn_marker );
            prev_hidden = 1;
        }
        else
        {
            var_3b4163ea6d58bd4 = vectornormalize( self.active_checkpoint.origin - self.player_vehicle.origin );
            vehicle_forward_vector = anglestoforward( self.player_vehicle.angles );
            
            if ( vectordot( var_3b4163ea6d58bd4, vehicle_forward_vector ) < -0.707 )
            {
                if ( prev_hidden || previous_driver != driver )
                {
                    objidpoolmanager::objective_playermask_addshowplayer( self.uturn_marker, driver );
                    objidpoolmanager::objective_pin_player( self.uturn_marker, driver );
                }
                
                prev_hidden = 0;
            }
            else
            {
                if ( !prev_hidden )
                {
                    objidpoolmanager::objective_playermask_hidefromallplayers( self.uturn_marker );
                }
                
                prev_hidden = 1;
            }
        }
        
        previous_driver = driver;
        wait 1;
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x18e3c341, Offset: 0x4881
// Size: 0x5b
function private set_vehicle_headlights( struct )
{
    enabled = struct.script_parameters == "1";
    
    if ( enabled )
    {
        self.player_vehicle vehicle_interact::lights_on( "headlights" );
        return;
    }
    
    self.player_vehicle vehicle_interact::lights_off( "headlights" );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0xf831b313, Offset: 0x48e4
// Size: 0x4c
function private function_f81a0e3e5a719b44()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.player_vehicle endon( #"death" );
    self.player_vehicle waittill( #"veh_submerged" );
    activity_instance_common::endactivity( self, 0 );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0xc
// Checksum 0xefc97b0d, Offset: 0x4938
// Size: 0x10b
function private function_9377bb852ca91ea( vehicle )
{
    self notify( #"hash_2e17fec7bfe3c0db" );
    self endon( #"hash_2e17fec7bfe3c0db" );
    
    if ( !vehicle vehicle::isvehiclealive() )
    {
        return;
    }
    
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    vehicle endon( #"death" );
    
    while ( true )
    {
        if ( activity_instance_common::getactivitystate( self ) != "Active" )
        {
            break;
        }
        
        if ( !vehicle_occupancy::get_driver( vehicle ) )
        {
            foreach ( player in self.playerparticipants )
            {
                player hud_message::showerrormessage( %"hash_4289b3c62045cf04", undefined, 3 );
            }
        }
        else
        {
            break;
        }
        
        wait 5;
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x9f6edba8, Offset: 0x4a4b
// Size: 0x6f, Type: bool
function private modify_vehicle_damage( data )
{
    if ( self.heavy_metal_heroes_activity_instance && ( weapon_utility::function_c1972d0d01397a22( data.objweapon ) || weapon_utility::function_186e07887b6bbeb1( data.objweapon ) ) )
    {
        data.damage *= self.heavy_metal_heroes_activity_instance.var_202c1f9e662ad308;
    }
    
    return true;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 11
// Checksum 0xea69b7e1, Offset: 0x4ac3
// Size: 0x344
function roadblock_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !instance.hmh_roadblock_enabled )
    {
        return;
    }
    
    if ( arraycontains( level.var_2ffc35c0415132de, instance.type ) )
    {
        agent_array = getaiarrayinradius( instance.origin, 150 );
        
        foreach ( agent in agent_array )
        {
            if ( agent.is_hmh_agent )
            {
                agent dodamage( agent.health * 10, instance.origin, eattacker );
                continue;
            }
            
            agent dodamage( 10, instance.origin, eattacker );
        }
        
        scriptable_array = getentitylessscriptablearray( undefined, undefined, instance.origin, 150 );
        
        foreach ( nearby_scriptable in scriptable_array )
        {
            if ( arraycontains( level.var_2ffc35c0415132de, nearby_scriptable.type ) )
            {
                nearby_scriptable scriptabledodamage( 500, einflictor, eattacker );
            }
        }
    }
    
    activity_instance = eattacker.heavy_metal_heroes_activity_instance;
    
    if ( !activity_instance )
    {
        var_6927b27a68eccd9e = eattacker;
        
        if ( !isplayer( eattacker ) )
        {
            if ( isplayer( eattacker.owner ) )
            {
                var_6927b27a68eccd9e = eattacker.owner;
            }
            else if ( isplayer( einflictor.owner ) )
            {
                var_6927b27a68eccd9e = einflictor.owner;
            }
            else
            {
                return;
            }
        }
        
        guid = var_6927b27a68eccd9e player::getuniqueid();
        activity_instance = level.var_9d8e0c9c02c4989[ guid ];
        
        if ( !activity_instance )
        {
            return;
        }
    }
    
    if ( eattacker == activity_instance.player_vehicle || einflictor == activity_instance.player_vehicle )
    {
        activity_instance.player_vehicle dodamage( activity_instance.var_dbe9dce9a9150034, instance.origin );
    }
    
    activity_instance.player_vehicle function_bb449a59e0a2405b( activity_instance.var_a56eb9b345a223ba );
    var_d8ee62d6b9efa1bf = activity_instance function_ca06b2dd9367e041( activity_instance.var_c556cae8af7abc1f );
    activity_instance add_vehicle_countdown_timer( var_d8ee62d6b9efa1bf, var_6927b27a68eccd9e, 1 );
    instance.hmh_roadblock_enabled = 0;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 2, eflags: 0x4
// Checksum 0xaf5016d6, Offset: 0x4e0f
// Size: 0x2b, Type: bool
function private function_9bdeefb2e4311e78( player, vehicle )
{
    return vehicle_occupancy::get_occupant_seat( vehicle, player ) || player getgroundentity() == vehicle;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0x30a2f02c, Offset: 0x4e43
// Size: 0xa2
function private spawn_sign( struct )
{
    if ( !isdefined( self.sign_struct_array ) )
    {
        self.sign_struct_array = [];
    }
    
    parameters_array = strtok( struct.script_parameters, "," );
    sign_scriptable = spawnscriptable( parameters_array[ 0 ], struct.origin, struct.angles );
    sign_scriptable setscriptablepartstate( #"sign", parameters_array[ 1 ] );
    struct.sign_scriptable = sign_scriptable;
    self.sign_struct_array[ self.sign_struct_array.size ] = struct;
}

// Namespace ob_contract_heavy_metal_heroes
// Params 1, eflags: 0x4
// Checksum 0xb27d3638, Offset: 0x4eed
// Size: 0x35
function private remove_sign( struct )
{
    if ( struct.sign_scriptable )
    {
        struct.sign_scriptable freescriptable();
        struct.sign_scriptable = undefined;
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 0, eflags: 0x4
// Checksum 0x869992a7, Offset: 0x4f2a
// Size: 0x179
function private spawn_reward()
{
    zone_def_bundle = common_item::function_f852430ffb889f14( self.start_point.origin, [ #"hash_32a95aa45b53f917" ] );
    var_b8940482a4a47246 = ob_activity_utility::function_aaf7ae640bd564ff( #"contract_heavy_metal_heroes", self.reward_spawnpoint.origin, self.reward_spawnpoint.angles, zone_def_bundle );
    
    foreach ( player in self.playerparticipants )
    {
        if ( player )
        {
            foreach ( loot_item in var_b8940482a4a47246 )
            {
                ping_id = player calloutmarkerping::function_920a63c06abdefe8( loot_item getscriptableindex() );
                player calloutmarkerping_hide( ping_id );
                player calloutmarkerping_show( ping_id, player );
            }
        }
    }
}

// Namespace ob_contract_heavy_metal_heroes
// Params 2, eflags: 0x4
// Checksum 0xbc2c1290, Offset: 0x50ab
// Size: 0x40
function private function_62f7eab2b05c8f8d( oldstateref, data )
{
    if ( vehicle::is_husk() )
    {
        vehicle_damage::function_56353dccab157e56( data );
        return;
    }
    
    vehicle_damage::function_d7e4fea731d24020( data, 1 );
    vehicle_damage::function_721a99ea5b048315( data, 1 );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 2, eflags: 0x4
// Checksum 0x86d631d2, Offset: 0x50f3
// Size: 0x40
function private function_4be5bdeb29bd3501( newstateref, data )
{
    if ( vehicle::is_husk() )
    {
        vehicle_damage::function_32e3d0ee599bd470( data );
        return;
    }
    
    vehicle_damage::function_f60f559ead41cb86( data, 1 );
    vehicle_damage::function_d034de5e6901e7f7( data, 1 );
}

// Namespace ob_contract_heavy_metal_heroes
// Params 2, eflags: 0x4
// Checksum 0xb263f7e6, Offset: 0x513b
// Size: 0x9a
function private function_ea9e27f5ec5eab06( usable, player )
{
    guid = player player::getuniqueid();
    activity_instance = level.var_9d8e0c9c02c4989[ guid ];
    
    if ( !activity_instance || usable != activity_instance.player_vehicle_scriptable )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"hash_2547e1423bd337c6", #type:"HINT_NOICON" };
}

/#

    // Namespace ob_contract_heavy_metal_heroes
    // Params 0, eflags: 0x4
    // Checksum 0x3d899987, Offset: 0x51de
    // Size: 0x1b8, Type: dev
    function private function_7a13d90705d2fbf7()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        self.player_vehicle endon( #"death" );
        attacker = self.player_vehicle;
        
        while ( true )
        {
            waitframe();
            
            if ( !getdvarint( @"hash_8014a8608684bc42", 0 ) )
            {
                continue;
            }
            
            setdvar( @"hash_8014a8608684bc42", 0 );
            drop_item_list = [ "<dev string:x24>", "<dev string:x44>" ];
            item_to_spawn = drop_item_list[ randomint( drop_item_list.size ) ];
            var_7e6ec07125a10545 = anglestoforward( attacker.angles + ( 0, randomfloatrange( -15, 15 ), 0 ) );
            drop_position = attacker.origin + var_7e6ec07125a10545 * randomfloatrange( 500, 1000 );
            contents = trace::create_contents( 0, 1, 0, 0, 0, 0, 0, 0, 0, 1 );
            trace_result = trace::ray_trace( drop_position + ( 0, 0, 200 ), drop_position - ( 0, 0, 200 ), [ attacker ], contents );
            
            if ( trace_result[ "<dev string:x63>" ] != "<dev string:x6b>" && trace_result[ "<dev string:x78>" ] )
            {
                spawn_position = trace_result[ "<dev string:x78>" ];
                struct = spawnstruct();
                struct.script_parameters = item_to_spawn;
                struct.origin = spawn_position;
                struct.angles = ( 0, 0, 0 );
                spawn_item( struct );
            }
        }
    }

    // Namespace ob_contract_heavy_metal_heroes
    // Params 0, eflags: 0x4
    // Checksum 0x12e3c716, Offset: 0x539e
    // Size: 0xc8, Type: dev
    function private debug_spawn_agents()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_c1e417c9e963b511", 0 ) && self.var_3217fef5724ca9e1 <= 20 )
            {
                zombie_aitype = function_b3988325430ce242( "<dev string:x81>" );
                team = "<dev string:x8d>";
                origin = self.player_vehicle.origin + anglestoforward( self.player_vehicle.angles ) * 900;
                agent = mp_agent::spawnnewagentaitype( zombie_aitype, origin, ( 0, 0, 0 ), team );
            }
            
            wait 1;
        }
    }

    // Namespace ob_contract_heavy_metal_heroes
    // Params 0, eflags: 0x4
    // Checksum 0xb8088cde, Offset: 0x546e
    // Size: 0xc0, Type: dev
    function private function_9c73fc3c18d70587()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        self.player_vehicle endon( #"death" );
        
        while ( true )
        {
            waitframe();
            
            if ( !getdvarint( @"hash_f0a7e071763953f0", 0 ) )
            {
                continue;
            }
            
            setdvar( @"hash_f0a7e071763953f0", 0 );
            struct = spawnstruct();
            struct.script_parameters = "<dev string:x9e>";
            struct.origin = self.player_vehicle.origin;
            struct.angles = ( 0, 0, 0 );
            spawn_sign( struct );
        }
    }

    // Namespace ob_contract_heavy_metal_heroes
    // Params 0, eflags: 0x4
    // Checksum 0x70f7af86, Offset: 0x5536
    // Size: 0x42, Type: dev
    function private debug_draw_checkpoint_trigger()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            drawtrigger( self.var_5aae2ccabea14a1b, ( 1, 0, 0 ), 0 );
            waitframe();
        }
    }

    // Namespace ob_contract_heavy_metal_heroes
    // Params 0, eflags: 0x4
    // Checksum 0x1f9a1cca, Offset: 0x5580
    // Size: 0xc2, Type: dev
    function private function_cbc9bc14f933f7d9()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            foreach ( item in self.item_array )
            {
                if ( item.item_trigger )
                {
                    drawtrigger( item.item_trigger, ( 0, 0.8, 0 ), 0 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob_contract_heavy_metal_heroes
    // Params 0, eflags: 0x4
    // Checksum 0x76964fa7, Offset: 0x564a
    // Size: 0xb7, Type: dev
    function private function_b7696ee98977ca20()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_3f933d0c7a322083", 0 ) )
            {
                setdvar( @"hash_3f933d0c7a322083", 0 );
                
                while ( self.var_f7f7f372047a46c < self.path_node_array.size - 2 )
                {
                    self.var_5aae2ccabea14a1b notify( #"trigger", self.player_vehicle );
                    waitframe();
                }
                
                self.player_vehicle.origin = self.path_node_array[ self.var_f7f7f372047a46c ].origin;
                break;
            }
            
            wait 1;
        }
    }

    // Namespace ob_contract_heavy_metal_heroes
    // Params 0, eflags: 0x4
    // Checksum 0x40e8f1bc, Offset: 0x5709
    // Size: 0x58, Type: dev
    function private function_8ecdac488a1def86()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_767139ab1895c59", 0 ) )
            {
                function_860e5ad7bfecd4e( self.player_vehicle );
                setdvar( @"hash_767139ab1895c59", 0 );
            }
            
            wait 1;
        }
    }

#/
