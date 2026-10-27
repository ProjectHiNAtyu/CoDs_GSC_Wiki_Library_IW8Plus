// scripts\mp\br\gametypes\br_gametype_clash.gsc  (hash_5e3bd60a1d21bcd0.gscc) (size: 56220 Bytes / 0xdb9c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc01741ba (3222749626)
// size ...... 56220 (0xdb9c)
// includes .. 50  (offset: 0xcb70)
// strings ... 146 (offset: 0xcd00)
// dev strs .. 126 (offset: 0xd558)
// exports ... 121 (offset: 0x8c2c)
// cseg ...... 0xb3a + 0x80f2 (0x8c2c)
// imports ... 357 (offset: 0x9f14)
// animtree1 . 0   (offset: 0xdb9c)
// animtree2 . 0   (offset: 0xdb9c)
#using script_2bcdd4c5a6662216;
#using script_483700f5ed917102;
#using script_4d353564709b2ccd;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\mp\armor;
#using scripts\mp\br\br_sam_turret;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_movingtrain;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\br\gametypes\br_vehicles;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\music_br;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\uav_tower;

#namespace br_gametype_clash;

// Namespace br_gametype_clash
// Params 0
// Checksum 0x557a5b0f, Offset: 0xb58
// Size: 0x179
function main()
{
    level.var_dd10333ade220938 = &init;
    level.var_24950bfd23e063a1 = &circle_override;
    level.var_190a8d6a5539850d = &kiosk_spawn_override;
    level.onteamscore = &function_807257b4805fb2b2;
    level.var_32cd3f9427fdc5d9 = 1;
    level.var_5ab0498cf1ac995e = 1;
    level callback::add( #"player_connect", &function_5f971d031206e7d8 );
    level callback::add( #"on_contract_start", &contracts_on_start );
    level callback::add( #"on_contract_completed", &contracts_on_completed );
    level callback::add( #"hash_2c631dc23e0ee99b", &function_4d14a2b737d1bb4 );
    level callback::add( #"hash_9d92d48a58900ff6", &winners_circle_on_activate );
    init_variables();
    br_clash_bots::init();
    level thread init_location_data();
    setdvar( @"hash_6aa5db768e3011d3", 0 );
    setdvar( @"scr_ssc_use_uav_tower", 0 );
    level.dontendonscore = 1;
    level.var_5195f9fa56bdff5 = 1;
    level.var_a27e6eedf72c9dd1 = 1;
    level.var_90854497526d85e2 = 1;
    level.var_4b1d806e34262a54 = 1;
    level.disablelaststand = 1;
    level.var_26fe3b6e1c4fde1 = 1;
    level.objectivescaler = 1;
    level.var_dbdd35c475d50ae3 = 1;
    level.brenableagents = 1;
    level.supportsai = 1;
    br_clash_vtol::chopper_init();
    br::main();
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xadc4b8f0, Offset: 0xcd9
// Size: 0x2f5
function init()
{
    br_gametypes::enablefeature( #"allowlatejoiners" );
    br_gametypes::disablefeature( #"plundersites" );
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::disablefeature( #"onelife" );
    br_gametypes::disablefeature( #"playercountlandmarks" );
    br_gametypes::disablefeature( #"movingcircle" );
    br_gametypes::disablefeature( #"randomizecirclecenter" );
    br_gametypes::disablefeature( #"planesnaptooob" );
    br_gametypes::disablefeature( #"hash_56a2d01019099833" );
    br_gametypes::disablefeature( #"hash_6b2317b5c9d88269" );
    br_gametypes::disablefeature( #"hash_de234998671449be" );
    br_gametypes::disablefeature( #"hash_a1e2467effef085c" );
    br_gametypes::disablefeature( #"hash_ee46d235dcd7bb0" );
    utility::registersharedfunc( #"gametype", #"hash_e1a48c13a7e1e696", &gametype_onstartgametype );
    utility::registersharedfunc( #"gametype", #"droponplayerdeath", &gametype_droponplayerdeath );
    utility::registersharedfunc( #"gametype", #"playershouldrespawn", &gametype_shouldrespawn );
    utility::registersharedfunc( #"gametype", #"markplayeraseliminatedonkilled", &gametype_markplayeraseliminatedonkilled );
    utility::registersharedfunc( #"gametype", #"mapcenterfinalcircle", &function_e62b9ea8139de01c );
    utility::registersharedfunc( #"gametype", #"hash_251cc1c137f65b9e", &gametype_spawnhandled );
    utility::registersharedfunc( #"gametype", #"playerkilledspawn", &gametype_playerrespawn );
    utility::registersharedfunc( #"gametype", #"infilsequence", &function_d1dccf97c5ee9b77 );
    utility::registersharedfunc( #"gametype", #"isteameliminated", &function_9a5954e9b78fdff8 );
    utility::registersharedfunc( #"gametype", #"hash_9274b776f2a290a6", &function_9e9294e1796d9412 );
    utility::registersharedfunc( #"gametype", #"hash_1c48ad8e4dae6be5", &function_2d550da4c966c7e1 );
    utility::registersharedfunc( #"gametype", #"hash_c9f08d54474fc48b", &function_347e7011fde30d0f );
    level.br_skipending = 1;
    setomnvar( "ui_br_circle_num", 1 );
    
    /#
        debug_init();
    #/
    
    level._effect[ "clash_infil_name" ] = loadfxasset( "vfx_t10_gameplay_br_clash_infil_name_test" );
    
    if ( br_public::function_9dc52a7da56f6544() )
    {
        level thread function_e4905fde167b5bd6();
    }
    
    level.clash.score_event_table = [ 40:#"hash_85c9676cbfd5e5b5", 20:#"hash_85c25b6cbfcfb2a3", 15:#"hash_85b86e6cbfc77e67", 10:#"hash_85b8696cbfc775e8", 5:#"hash_82222bfc2165b514", 2:#"hash_82222afc2165b361", 1:#"hash_822227fc2165ae48" ];
    thread init_post_main();
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x796d324d, Offset: 0xfd6
// Size: 0x472
function init_variables()
{
    level.clash = {};
    level.forcedisablelaststand = 1;
    level.clash.location_override = getdvar( @"hash_d0257569e3ef5bb6", "random" );
    level.clash.spawn_height = getdvarint( @"hash_ba734aa322b528a5", 2500 );
    level.clash.var_5f00e57303385896 = getdvarint( @"hash_2306d36be2a1b46a", 5 );
    level.clash.infil_delay_time = getdvarint( @"hash_cf456f8a0dd61f2c", 1 );
    level.clash.var_6cfc14172e1d3143 = getdvarint( @"hash_f18b48ffd21b201b", 1 );
    level.clash.fade_buffer = getdvarint( @"hash_d686bd4f30791c43", 1000 );
    level.clash.var_51990d5c173e80a3 = getdvarint( @"hash_24abbbc70738b219", 3000 );
    level.clash.var_4129e35c0a7db18b = getdvarint( @"hash_1731b5c6fdb91da1", 7000 );
    level.clash.var_474d3a24fbcc1b5f = getdvarint( @"hash_4dd86a17097c6d35", 10000 );
    level.clash.tablets_per_team = getdvarint( @"hash_f931c06d8f93b7b5", 4 );
    level.clash.var_24a3e9612ee536b3 = getdvarint( @"hash_431808e63ef86a7b", 10 );
    level.clash.sam_sites_enabled = getdvarint( @"hash_8078a78f7e101964", 0 );
    level.clash.var_895ba95168337de7 = getdvarint( @"hash_2deb09df6eff5bf3", 1 );
    level.clash.name_fx_model = getdvar( @"hash_4f68801bfb0b4282", "saw_clash_name_fx_sierra" );
    objidpoolmanager::function_d15ca529817626c( "low", level.clash.var_51990d5c173e80a3, level.clash.var_51990d5c173e80a3 + level.clash.fade_buffer );
    objidpoolmanager::function_d15ca529817626c( "med", level.clash.var_4129e35c0a7db18b, level.clash.var_4129e35c0a7db18b + level.clash.fade_buffer );
    objidpoolmanager::function_d15ca529817626c( "high", level.clash.var_474d3a24fbcc1b5f, level.clash.var_474d3a24fbcc1b5f + level.clash.fade_buffer );
    level.clash.score_limit = getmatchrulesdata( "commonOption", "scoreLimit" );
    level.clash.time_limit = getmatchrulesdata( "commonOption", "timeLimit" );
    level.clash.highest_score = 0;
    level.clash.tiebreaker_team = "allies";
    level.var_8a80723669278851 = getdvarint( @"hash_aebbfcbfeec5caa1", 1 );
    level.clash.cs_flag_name = getdvar( @"hash_b8459928750ce87" );
    level.clash.var_9544f686edfe58b4 = getdvar( @"hash_ccb0d6fa0bf1d1b6" );
    disabled_activities = getdvar( @"hash_2b3d42c83f8de19a", "" );
    level.clash.disabled_activities = [];
    
    if ( disabled_activities != "" )
    {
        level.clash.disabled_activities = strtok( disabled_activities, "," );
    }
    
    disabled_locations = getdvar( @"hash_e561818fee969495", "" );
    level.clash.disabled_locations = [];
    
    if ( disabled_locations != "" )
    {
        level.clash.disabled_locations = strtok( disabled_locations, "," );
    }
    
    scriptable::scriptable_addusedcallbackbypart( "body", &function_6fc91b28972c065f );
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xbc62773d, Offset: 0x1450
// Size: 0x1e9
function init_dialog()
{
    level.clash.dialog_prefix = "dx_br_srs4_";
    level.clash.dialog_prefix_new = "dx_br_brcl_";
    game[ "dialog" ][ "gametype" ] = "lmcl_wzan_gmty";
    game[ "dialog" ][ "gametype_desc" ] = "brcc_wzan_gamd";
    game[ "dialog" ][ "score_friendly_50_percent" ] = "lmcl_wzan_sf50";
    game[ "dialog" ][ "score_friendly_90_percent" ] = "lmcl_wzan_sf90";
    game[ "dialog" ][ "score_friendly_ahead_50" ] = "lmcl_wzan_fa50";
    game[ "dialog" ][ "score_enemy_50_percent" ] = "lmcl_wzan_se50";
    game[ "dialog" ][ "score_enemy_90_percent" ] = "lmcl_wzan_se90";
    game[ "dialog" ][ "score_enemy_ahead_50" ] = "lmcl_wzan_ea50";
    game[ "dialog" ][ "timer_50" ] = "lmcl_wzan_cl50";
    game[ "dialog" ][ "timer_25" ] = "lmcl_wzan_cl25";
    game[ "dialog" ][ "timer_final_min" ] = "lmcl_wzan_cfmn";
    game[ "dialog" ][ "timer_50_losing" ] = "lmcl_wzan_c50l";
    game[ "dialog" ][ "timer_25_losing" ] = "lmcl_wzan_c25l";
    game[ "dialog" ][ "timer_final_min_losing" ] = "lmcl_wzan_cfml";
    game[ "dialog" ][ "timer_50_winning" ] = "lmcl_wzan_c50w";
    game[ "dialog" ][ "timer_25_winning" ] = "lmcl_wzan_c25w";
    game[ "dialog" ][ "timer_final_min_winning" ] = "lmcl_wzan_cfmw";
    game[ "dialog" ][ "match_overtime" ] = "lmcl_wzan_crov";
    game[ "dialog" ][ "matrch_draw" ] = "lmcl_wzan_crdr";
    game[ "dialog" ][ "match_victory" ] = "brcc_wzan_mawi";
    game[ "dialog" ][ "match_loss" ] = "brcc_wzan_malo";
    game[ "dialog" ][ "vtol_friendly" ] = "brcc_wzan_clvf";
    game[ "dialog" ][ "vtol_enemy" ] = "brcc_wzan_clve";
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xe261fb86, Offset: 0x1641
// Size: 0x7d
function init_post_main()
{
    waitframe();
    level.numendgame = undefined;
    level flags::gameflaginit( "clash_ending", 0 );
    init_activities();
    init_dialog();
    level.var_897bde4d916801b4 = &function_a63b7867ce2c0519;
    level.finalkillcamskipteamremaining = &function_3787d0512e4acc1a;
    
    if ( !getdvarint( @"hash_c64ec68784a0520a", 0 ) )
    {
    }
    
    utility::registersharedfunc( #"br_gametype_clash", #"hud_show_score", &hud_show_score );
    level thread init_prematch_fade_done();
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xef847b14, Offset: 0x16c6
// Size: 0x70
function init_prematch_fade_done()
{
    flags::gameflaginit( "infil_complete", 0 );
    flags::gameflagwait( "prematch_fade_done" );
    setomnvarforallclients( "ui_open_menu_from_script", -1 );
    wait 1;
    level init_hud();
    level init_kiosks();
    level init_uav_towers();
    level init_sam_sites();
    level thread init_vehicles();
    level thread init_callbacks();
    level function_a0838d5080d8cca0();
    level.var_be56c651557bc33c = 1;
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xa1857b0, Offset: 0x173e
// Size: 0x24
function init_callbacks()
{
    level callback::add( #"player_death", &match_on_player_death );
    rejoin_utility::function_70467cdf042579e5( &function_9ec71463f32ce2a7 );
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x65af5af0, Offset: 0x176a
// Size: 0x5e
function init_hud()
{
    setomnvar( "ui_match_timer_hidden", 0 );
    _ = {};
    _.ally_id = function_2ad15fd7dbc00f8a( "allies" );
    _.axis_id = function_2ad15fd7dbc00f8a( "axis" );
    level.clash.hud = _;
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x6ad5f6ef, Offset: 0x17d0
// Size: 0x2c6
function init_activities()
{
    _ = {};
    _.eventsettings = level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_6457144717a86f43" ];
    assert( isdefined( _.eventsettings ), "<dev string:x24>" + "<dev string:x3f>" + "<dev string:x62>" + "<dev string:x76>" );
    
    foreach ( variant in _.eventsettings.var_b7da2d4e0b4ea057 )
    {
        activity_definition_utils::function_74af1ab4059e3c06( variant.activityvariantdefinition, variant.activityvariantname );
    }
    
    _.activities = [];
    
    foreach ( type, type_data in level.activities.types )
    {
        if ( arraycontains( level.clash.disabled_activities, type ) )
        {
            continue;
        }
        
        defs = activity_definition_utils::function_326a5e04c9b438f5( type );
        variants = [];
        
        foreach ( variant, variant_data in defs )
        {
            variants[ variant ] = { #times_spawned:0, #varianttag:variant };
        }
        
        if ( variants.size > 0 )
        {
            _.activities[ type ] = { #instances:[], #times_selected:0, #variants:variants, #type:type };
        }
    }
    
    _.instances = [];
    level.clash.activity_manager = _;
    activity_common::function_2dd4f07fa5c3e911( "InstanceBegin", &function_dd85aaa7ce05c803 );
    activity_common::function_2dd4f07fa5c3e911( "InstanceEnd", &function_f79a9201f760e21b );
    
    /#
        debug_init_activities();
    #/
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x24ad8635, Offset: 0x1a9e
// Size: 0x457
function init_contracts()
{
    if ( !level.clash.var_6cfc14172e1d3143 )
    {
        return;
    }
    
    level.clash.contract_manager = {};
    var_d2333c193f6671d = ( level.clash.location.origin[ 0 ], level.clash.location.origin[ 1 ], -10000 );
    small_nodes = function_54a828312dd17e19( var_d2333c193f6671d, 20000, level.clash.location.radius * 0.8, #"hash_2f83453ffdf69f", #"ground", #"empty" );
    med_nodes = function_54a828312dd17e19( var_d2333c193f6671d, 20000, level.clash.location.radius * 0.8, #"loot_spawn_medium", #"ground", #"empty" );
    large_nodes = function_54a828312dd17e19( var_d2333c193f6671d, 20000, level.clash.location.radius * 0.8, #"loot_spawn_large", #"ground", #"empty" );
    nodes = [];
    nodes[ "allies" ] = [];
    nodes[ "axis" ] = [];
    
    foreach ( node_index in small_nodes )
    {
        node_info = function_7f6d88f06b34e603( node_index );
        
        /#
            if ( getdvarint( @"hash_987fb9ef04c48841", 0 ) )
            {
                sphere( node_info.origin, 10, ( 1, 1, 0 ), 0, 10000 );
            }
        #/
        
        nodes[ function_2488974474e84883( node_info.origin ) ][ nodes[ function_2488974474e84883( node_info.origin ) ].size ] = node_index;
    }
    
    foreach ( node_index in med_nodes )
    {
        node_info = function_7f6d88f06b34e603( node_index );
        
        /#
            if ( getdvarint( @"hash_987fb9ef04c48841", 0 ) )
            {
                sphere( node_info.origin, 15, ( 0, 1, 0 ), 0, 10000 );
            }
        #/
        
        nodes[ function_2488974474e84883( node_info.origin ) ][ nodes[ function_2488974474e84883( node_info.origin ) ].size ] = node_index;
    }
    
    foreach ( node_index in large_nodes )
    {
        node_info = function_7f6d88f06b34e603( node_index );
        
        /#
            if ( getdvarint( @"hash_987fb9ef04c48841", 0 ) )
            {
                sphere( node_info.origin, 20, ( 1, 0, 0 ), 0, 10000 );
            }
        #/
        
        nodes[ function_2488974474e84883( node_info.origin ) ][ nodes[ function_2488974474e84883( node_info.origin ) ].size ] = node_index;
    }
    
    level.clash.contract_manager.nodes = nodes;
    level.clash.contract_manager thread function_5a209a47eb0fde17( "axis" );
    level.clash.contract_manager thread function_5a209a47eb0fde17( "allies" );
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x3eeb871b, Offset: 0x1efd
// Size: 0x1be
function init_vehicles()
{
    level endon( #"game_ended" );
    
    if ( !getdvarint( @"hash_43d77ec578ec65d", 1 ) )
    {
        return;
    }
    
    wait 5;
    
    foreach ( vehicle_spawn in level.clash.location.map_structs[ "clash_vehicle_spawn" ] )
    {
        if ( !vehicle::is_loaded( vehicle_spawn.script_noteworthy ) )
        {
            println( "<dev string:xe2>" + "<dev string:xf6>" + vehicle_spawn.origin + "<dev string:x109>" + vehicle_spawn.script_noteworthy + "<dev string:x11e>" );
            continue;
        }
        
        infil_only = isdefined( vehicle_spawn.infil_only ) ? int( vehicle_spawn.infil_only ) : 0;
        
        if ( infil_only )
        {
            vehicle_spawn vehicle_spawn::set_flag( 8 );
        }
        
        spawn_data = br_vehicles::vehiclespawn_getspawndata( vehicle_spawn );
        spawn_data.spawnflags = vehicle_spawn.spawnflags;
        vehicle = vehicle::spawn( vehicle_spawn.script_noteworthy, spawn_data );
        
        /#
            if ( !isdefined( vehicle ) )
            {
                println( "<dev string:xe2>" + "<dev string:x158>" + vehicle_spawn.script_noteworthy + "<dev string:x16a>" + vehicle_spawn.origin + "<dev string:x171>" );
            }
        #/
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x3dddf807, Offset: 0x20c3
// Size: 0x14b
function init_kiosks()
{
    callback::add( #"hash_440e335c78393d75", &function_ee346b1e16a0270a );
    
    foreach ( kiosk_spawn in level.clash.location.map_structs[ "clash_kiosk_spawn" ] )
    {
        kiosk_spawn.instance = common_kiosk::function_27da31038bf50233( kiosk_spawn );
        level.common_armory_kiosk.instances = arraycombineunique( level.common_armory_kiosk.instances, [ kiosk_spawn.instance ] );
        kiosk_spawn.instance setscriptablepartstate( "br_plunder_box", "open" );
    }
    
    level.clash.kiosk_specials = [ "saw_clash_special_vtol":&function_e5b418336cc7ff, "saw_clash_special_uav_takeover":&function_3a46ce9c5ba0c8ee, "saw_clash_special_bombardment":&function_9b50496b73e247ab, "saw_clash_special_mg_trucks":&function_a5be8eebbfc2eee3 ];
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x640e9a11, Offset: 0x2216
// Size: 0x156
function init_uav_towers()
{
    if ( !level.clash.var_895ba95168337de7 || !uav_tower::function_d54bbc8100ac0b16() )
    {
        return;
    }
    
    foreach ( uav_tower_spawn in level.clash.location.map_structs[ "clash_uav_tower" ] )
    {
        tower = uav_tower::function_e9d70c7951442090( uav_tower_spawn, "scriptable_uav_tower_clash" );
        
        if ( tower.capturezone.objidnum )
        {
            objidpoolmanager::function_91c357c4f0f071a7( tower.capturezone.objidnum, "low" );
            objidpoolmanager::function_586b631e7bbb592a( tower.capturezone.objidnum, 1 );
            function_24edb8a97f6832f0( tower.capturezone.objidnum, 1 );
            function_8eab38514b79538d( tower.capturezone.objidnum, 2000 );
        }
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xef323b48, Offset: 0x2374
// Size: 0xe4
function init_sam_sites()
{
    if ( !level.clash.sam_sites_enabled )
    {
        return;
    }
    
    spawn_params = { #var_2a9c48e7b5fcf6a4:1, #deactivate:1 };
    
    foreach ( sam_site_spawn in level.clash.location.map_structs[ "clash_sam_site" ] )
    {
        br_sam_turret::init_location( sam_site_spawn.origin, sam_site_spawn.angles, spawn_params );
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xb67802ca, Offset: 0x2460
// Size: 0x196
function function_e4905fde167b5bd6()
{
    if ( !br_public::function_9dc52a7da56f6544() )
    {
        return;
    }
    
    if ( !isdefined( level.wztrain_info ) )
    {
        level.wztrain_info = {};
    }
    
    level.wztrain_info.train_vfx_init_callback = &train_vfx_init_override;
    level.wztrain_info.forceidle = 1;
    level utility::flag_wait( "wztrain_anim_playing" );
    
    if ( level.clash.location.train_pct < 0 )
    {
        br_movingtrain::train_stop();
        br_movingtrain::train_elements_disable();
        return;
    }
    
    br_movingtrain::function_e2ce3bada3bdf46f( "cargo_train", 0 );
    br_movingtrain::function_fac91c4df3c88eaf( "cargo_train", level.clash.location.train_pct );
    wait 1;
    br_movingtrain::train_stop();
    br_movingtrain::function_a7fe262888da18b5( "cargo_train" );
    wait 5;
    train_array = level.wztrain_info.trains[ "cargo_train" ];
    
    foreach ( train in train_array )
    {
        if ( train.ammo_restock )
        {
            train.ammo_restock setscriptablepartstate( "military_ammo_restock", "disabled" );
        }
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x37fad08b, Offset: 0x25fe
// Size: 0x171
function function_6a380f72fd2e49b5()
{
    level.clash.vtols = { #locations:[], #instances:[] };
    
    foreach ( loc in level.clash.location.map_structs[ "clash_vtol_zone" ] )
    {
        if ( loc.script_noteworthy )
        {
            if ( !isdefined( level.clash.vtols.locations[ loc.script_noteworthy ] ) )
            {
                level.clash.vtols.locations[ loc.script_noteworthy ] = [];
            }
            
            level.clash.vtols.locations[ loc.script_noteworthy ][ level.clash.vtols.locations[ loc.script_noteworthy ].size ] = loc;
        }
    }
}

// Namespace br_gametype_clash
// Params 0, eflags: 0x4
// Checksum 0x8d9b3137, Offset: 0x2777
// Size: 0x763
function private init_location_data()
{
    level endon( #"game_ended" );
    
    if ( level.clash.cs_flag_name == "" )
    {
        flag_name = "create_script_initialized";
    }
    else
    {
        flag_name = level.clash.cs_flag_name + "_completed";
    }
    
    utility::flag_wait( flag_name );
    level.clash.locations = [];
    location_settings = level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_409cdca329ebf734" ];
    assert( isdefined( location_settings ), "<dev string:x24>" + "<dev string:x184>" + "<dev string:x62>" + "<dev string:x1aa>" );
    
    foreach ( loc in location_settings.locationlist )
    {
        if ( arraycontains( level.clash.disabled_locations, loc ) )
        {
            continue;
        }
        
        var_399a0f97e8cb8e0b = { #train_pct:loc.trainenabled ? loc.trainpct : -1, #weight:loc.selectionweight, #name:loc.locationref };
        level.clash.locations[ var_399a0f97e8cb8e0b.name ] = var_399a0f97e8cb8e0b;
    }
    
    location_structs = utility::getstructarray( "clash_location", "targetname" );
    
    foreach ( data in location_structs )
    {
        loc = level.clash.locations[ data.script_noteworthy ];
        
        if ( !isdefined( loc ) )
        {
            continue;
        }
        
        loc.initialized = 1;
        loc.origin = data.origin;
        loc.angles = data.angles;
        loc.radius = data.radius;
        loc.script_linkto = data.script_linkto;
        loc.spawn_angle_min = 0;
        loc.spawn_angle_max = 30;
        loc.spawn_dist_min = getdvarfloat( @"hash_dc38f12ae83b76ab", 0.9 );
        loc.spawn_dist_max = getdvarfloat( @"hash_dc16072ae8155f55", 0.99 );
        loc.spawn_face_enemy = 1;
        loc.team_data = [];
        spawn_angle = loc.angles[ 1 ];
        spawn_vector = anglestoforward( ( 0, spawn_angle, 0 ) );
        spawn_origin = loc.origin + spawn_vector * loc.radius * loc.spawn_dist_min;
        loc.team_data[ "allies" ] = { #spawn_height:level.clash.spawn_height, #spawn_vector:spawn_vector, #spawn_origin:spawn_origin, #spawn_angle:spawn_angle };
        spawn_angle = ( loc.angles[ 1 ] + 180 ) % 360;
        spawn_vector = anglestoforward( ( 0, spawn_angle, 0 ) );
        spawn_origin = loc.origin + spawn_vector * loc.radius * loc.spawn_dist_min;
        loc.team_data[ "axis" ] = { #spawn_height:level.clash.spawn_height, #spawn_vector:spawn_vector, #spawn_origin:spawn_origin, #spawn_angle:spawn_angle };
    }
    
    level.clash.var_62a7d416e2dc06e4 = [];
    keys = getarraykeys( level.clash.locations );
    
    foreach ( key in keys )
    {
        if ( !level.clash.locations[ key ].initialized )
        {
            println( "<dev string:xe2>" + "<dev string:x219>" + key + "<dev string:x224>" );
            level.clash.locations[ key ] = undefined;
            continue;
        }
        
        level.clash.locations[ key ].initialized = undefined;
        
        if ( level.clash.locations[ key ].weight > 0 )
        {
            level.clash.var_62a7d416e2dc06e4[ key ] = level.clash.locations[ key ].weight;
        }
    }
    
    /#
        debug_init_locations();
    #/
    
    foreach ( loc in level.clash.locations )
    {
        map_structs = loc utility::get_linked_structs();
        
        foreach ( struct in map_structs )
        {
            if ( !isdefined( loc.map_structs[ struct.targetname ] ) )
            {
                loc.map_structs[ struct.targetname ] = [];
            }
            
            loc.map_structs[ struct.targetname ][ loc.map_structs[ struct.targetname ].size ] = struct;
        }
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x4a2e5dce, Offset: 0x2ee2
// Size: 0x22
function circle_override()
{
    level.br_level.staticcircle = 1;
    level.br_multi_circle_enabled = 0;
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x785d7a73, Offset: 0x2f0c
// Size: 0x14
function function_a63b7867ce2c0519( var_e4b308e319a579e1 )
{
    level thread function_d3972e0bdce7f926();
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x8108e70d, Offset: 0x2f28
// Size: 0x276
function function_d3972e0bdce7f926()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_fade_done" );
    wait 3;
    circle_vec = ( level.clash.location.origin[ 0 ], level.clash.location.origin[ 1 ], level.clash.location.radius );
    safecircleent = spawn( "script_model", circle_vec );
    safecircleui = spawn( "script_model", safecircleent.origin );
    dangercircleent = spawnbrcircle( level.clash.location.origin[ 0 ], level.clash.location.origin[ 1 ], level.clash.location.radius );
    dangercircleui = spawn( "script_model", dangercircleent.origin );
    circleents = spawnstruct();
    circleents.safeent = safecircleent;
    circleents.safeui = safecircleui;
    circleents.dangerent = dangercircleent;
    circleents.dangerui = dangercircleui;
    level.clash.circle_ents = circleents;
    dangercircleent setbrcircleents( safecircleent, dangercircleui, dangercircleui );
    level.br_circle.dangercircleent = dangercircleent;
    level.br_circle.circleindex = 0;
    
    if ( getdvarint( @"hash_8c6493d110974c0", 0 ) )
    {
        diameter = level.clash.location.radius * 2;
        level.clash.circle_ents.square_exclusion = function_e47908fae7dc9b80( level.clash.location.origin, ( diameter, diameter, diameter ), ( 0, 0, 0 ), 2, 0 );
    }
    
    flags::gameflagwait( "infil_complete" );
    level thread br_circle::circledamagetick();
}

// Namespace br_gametype_clash
// Params 0, eflags: 0x4
// Checksum 0xc365a9b0, Offset: 0x31a6
// Size: 0x25a
function private location_select()
{
    assert( level.clash.locations.size > 0, "<dev string:x24>" + "<dev string:x241>" + "<dev string:x62>" + "<dev string:x264>" );
    override = getdvar( @"hash_d0257569e3ef5bb6" );
    
    if ( isdefined( level.clash.locations[ override ] ) )
    {
        level.clash.location = level.clash.locations[ override ];
    }
    else if ( level.clash.var_62a7d416e2dc06e4.size )
    {
        total_weight = 0;
        
        foreach ( loc, weight in level.clash.var_62a7d416e2dc06e4 )
        {
            total_weight += weight;
        }
        
        rand = randomintrange( 0, total_weight ) + 1;
        
        foreach ( loc, weight in level.clash.var_62a7d416e2dc06e4 )
        {
            selection = loc;
            rand -= weight;
            
            if ( rand <= 0 )
            {
                break;
            }
        }
        
        level.clash.location = level.clash.locations[ selection ];
    }
    
    level.clash.var_62a7d416e2dc06e4 = undefined;
    
    if ( !isdefined( level.clash.location ) )
    {
        level.clash.location = utility::array_random( level.clash.locations );
    }
    
    level thread function_b4066f25c45d15b2();
}

// Namespace br_gametype_clash
// Params 0, eflags: 0x4
// Checksum 0xaa5a54f4, Offset: 0x3408
// Size: 0x551
function private function_b4066f25c45d15b2()
{
    level.clash.location.redeploy_spawns = [];
    level.clash.location.redeploy_spawns[ "allies" ] = [];
    level.clash.location.redeploy_spawns[ "axis" ] = [];
    spawn_count = getmatchrulesdata( "commonOption", "teamSize" );
    trace_count = getdvarint( @"hash_7a3134c4b1dcc976", 5 );
    
    while ( !isdefined( level.teamnamelist ) )
    {
        waitframe();
    }
    
    tracesthisframe = 0;
    valid_teams = [ "allies", "axis" ];
    
    foreach ( team in valid_teams )
    {
        level.clash.location.team_data[ team ].forward_dir = vectornormalize( level.clash.location.origin - level.clash.location.team_data[ team ].spawn_origin );
        
        for ( i = 0; i < spawn_count ; i++ )
        {
            spawn_point = spawnstruct();
            spawn_angles = vectortoangles( level.clash.location.team_data[ team ].spawn_vector );
            random_yaw = randomfloatrange( level.clash.location.spawn_angle_min, level.clash.location.spawn_angle_max );
            spawn_vector = anglestoforward( ( 0, spawn_angles[ 1 ] + ( utility::cointoss() ? random_yaw : random_yaw * -1 ), 0 ) );
            random_dist = randomfloatrange( level.clash.location.spawn_dist_min, level.clash.location.spawn_dist_max );
            spawn_origin = level.clash.location.origin + spawn_vector * level.clash.location.radius * random_dist;
            
            if ( level.clash.location.spawn_face_enemy )
            {
                enemy_spawn_dir = level.clash.location.team_data[ team_utility::getotherteam( team ) ].spawn_origin - spawn_origin;
                spawn_angles = vectortoangles( enemy_spawn_dir );
            }
            else
            {
                spawn_angles = vectortoangles( spawn_vector * -1 );
            }
            
            tracecontents = trace::create_default_contents( 1 );
            highestz = 0;
            highesttraceindex = 0;
            results = [];
            
            for ( j = 0; j < trace_count ; j++ )
            {
                result = trace::ray_trace( spawn_origin + ( 0, 0, 10000 ), spawn_origin - ( 0, 0, 20000 ) + anglestoforward( spawn_angles ) * j * 2000, undefined, tracecontents )[ "position" ];
                results[ results.size ] = result;
                
                if ( result[ 2 ] > highestz )
                {
                    highestz = result[ 2 ];
                    highesttraceindex = j;
                }
                
                tracesthisframe++;
                
                if ( tracesthisframe == 5 )
                {
                    waitframe();
                    tracesthisframe = 0;
                }
            }
            
            spawn_origin = ( spawn_origin[ 0 ], spawn_origin[ 1 ], highestz + level.clash.location.team_data[ team ].spawn_height );
            spawn_point.origin = spawn_origin;
            spawn_point.traceresults = results;
            spawn_point.highesttraceindex = highesttraceindex;
            spawn_point.angles = spawn_angles;
            spawn_point.time = gettime();
            spawn_point.team = team;
            spawn_point.index = -1;
            level.clash.location.redeploy_spawns[ team ][ level.clash.location.redeploy_spawns[ team ].size ] = spawn_point;
        }
    }
    
    level.clash.location.var_7e77ad77ccd67541 = 1;
    utility::flag_set( "clash_location_spawn_points_complete" );
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x93089199, Offset: 0x3961
// Size: 0xd4
function function_ea83ec4242766ab5( use_ground_spawn = 0 )
{
    if ( use_ground_spawn && isdefined( self.clash_infil_spawn_area ) )
    {
        origin = self.clash_infil_spawn_area function_50687901b42c5033( 100, 5 );
        origin = br_public::droptogroundmultitrace( origin );
        angles = self.clash_infil_spawn_area.angles;
        self.clash_infil_spawn_area.slot++;
        self.clash_infil_spawn_area = undefined;
        return { #angles:angles, #origin:origin };
    }
    
    return utility::array_random( level.clash.location.redeploy_spawns[ self.team ] );
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0xfcc7ae48, Offset: 0x3a3d
// Size: 0x9a
function player_infil( infil_mode )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( infil_mode == 1 )
    {
        function_1ad3bd1d233d2aa5();
    }
    else
    {
        player_infil_in_air();
    }
    
    self clearsoundsubmix( "mp_br_lobby_fade", 0 );
    level thread br_public::brleaderdialogplayer( "gametype_desc", self, 0, 1, undefined, undefined, level.clash.dialog_prefix_new );
    self.pers[ "distTrackingPassed" ] = 0;
    br::resetafkchecks( self, 0 );
    self setclientomnvar( "ui_br_infiled", 1 );
}

// Namespace br_gametype_clash
// Params 0, eflags: 0x4
// Checksum 0xaf31d226, Offset: 0x3adf
// Size: 0x3c
function private player_infil_in_air()
{
    self endon( #"death_or_disconnect" );
    player_spawn_internal( 0, level.clash.infil_delay_time );
    br_spawnrespawn::function_24b79e9319c6f02f();
    level notify( #"clash_player_infilled" );
}

// Namespace br_gametype_clash
// Params 0, eflags: 0x4
// Checksum 0xceec13d2, Offset: 0x3b23
// Size: 0x27f
function private function_1ad3bd1d233d2aa5()
{
    self endon( #"death_or_disconnect" );
    player_spawn_internal( 1, level.clash.infil_delay_time );
    val::set( "clash_infil", "show_hud", 0 );
    val::set( "clash_infil", "freezecontrols", 1 );
    self cameralinkto( self.infil_camera_ent, "tag_origin", 1, 1 );
    br_spawnrespawn::function_24b79e9319c6f02f();
    self playerhide();
    var_ba5386ba9faef8aa = level.clash.location.infil_cameras[ team_utility::getotherteam( self.team ) ];
    end_cam = level.clash.location.infil_cameras[ self.team ];
    look_dir = vectornormalize( var_ba5386ba9faef8aa.origin - end_cam.origin );
    look_angles = generateaxisanglesfromforwardvector( look_dir, ( 0, 0, 1 ) );
    self.infil_camera_ent.origin = var_ba5386ba9faef8aa.origin + ( 0, 0, 500 );
    self.infil_camera_ent.angles = look_angles + ( 20, 0, 0 );
    self.infil_camera_ent moveto( end_cam.origin, 8, 0, 2 );
    wait 8;
    level thread br_public::brleaderdialogplayer( "gametype", self, 0, 1, undefined, undefined, level.clash.dialog_prefix );
    eye_origin = self gettagorigin( "tag_eye" );
    eye_angles = self.angles;
    self.infil_camera_ent moveto( eye_origin, 4, 2, 2 );
    self.infil_camera_ent rotateto( eye_angles, 4, 2, 2 );
    thread gameobjects::forceunsetdemeanor( 1 );
    music_br::function_68293509b7c0bc7( self );
    wait 4;
    self cameraunlink();
    self playershow();
    self.infil_camera_ent delete();
    thread gameobjects::forceunsetdemeanor( 0 );
    wait 0.5;
    self.brneverlanded = 0;
    val::reset( "clash_infil", "show_hud" );
    val::reset( "clash_infil", "freezecontrols" );
    level notify( #"clash_player_infilled" );
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0xa2fc8d00, Offset: 0x3daa
// Size: 0xcb
function function_be6143c2102a4ae9( endon_string )
{
    level endon( endon_string );
    
    while ( true )
    {
        streakinfo = spawnstruct();
        point = br_circle::getrandompointincircle( level.clash.location.origin, level.clash.location.radius * 0.3 );
        missile = spawn( "script_model", point );
        missile thread toma_strike::function_5a8f351cdf789664( missile.origin, missile.angles, undefined, level.players[ 0 ], 0, streakinfo );
        wait randomfloatrange( 0.25, 1 );
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x7b7e638f, Offset: 0x3e7d
// Size: 0x87
function function_1f714ec0b3abde6a()
{
    for ( i = 0; i < 2 ; i++ )
    {
        player = level.players[ 0 ];
        point = br_circle::getrandompointincircle( level.clash.location.origin, 5000 );
        player airstrike::callprecisionairstrikeonlocation( point );
        wait randomfloatrange( 0.5, 2 );
    }
    
    level notify( #"hash_7aa34cbd6fa3c48b" );
}

// Namespace br_gametype_clash
// Params 2
// Checksum 0x7d894b8e, Offset: 0x3f0c
// Size: 0x73
function player_respawn( death_data, first_death )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( level.gameended )
    {
        return;
    }
    
    while ( self.killcam )
    {
        waitframe();
    }
    
    thread player_respawn_intermission();
    thread function_b0950d0ea14382da();
    player_spawn_internal( 0, level.clash.var_5f00e57303385896 );
}

// Namespace br_gametype_clash
// Params 2, eflags: 0x4
// Checksum 0x569b5d4a, Offset: 0x3f87
// Size: 0x1ab
function private player_spawn_internal( use_ground_spawn, wait_time )
{
    level endon( #"hash_edfcaecd14a734a" );
    spawn_point = function_ea83ec4242766ab5( use_ground_spawn );
    stream_origin = br_spawnrespawn::playerprestreamrespawnorigin( spawn_point );
    omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_cursor_pos_override_x", level.clash.location.origin[ 0 ] );
    omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_cursor_pos_override_y", level.clash.location.origin[ 1 ] );
    omnvar_utility::setcachedclientomnvar( "ui_compass_tacopsmap_size_override", level.clash.location.radius + 500 );
    wait wait_time;
    
    if ( !isalive( self ) )
    {
        playerlogic::spawnplayer( undefined, 0 );
    }
    
    if ( !arraycontains( level.teamdata[ self.team ][ "alivePlayers" ], self ) )
    {
        playerlogic::addtoalivecount( "clash" );
    }
    
    omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 0 );
    damage::resetplayervariables();
    respawn_struct = {};
    
    if ( use_ground_spawn )
    {
        respawn_struct.skipbattlechatter = 1;
        respawn_struct.skipparachute = 1;
    }
    
    br_spawnrespawn::br_respawn( spawn_point, stream_origin, respawn_struct );
    
    if ( getdvarint( @"hash_80cba43c91c7392a", 0 ) )
    {
        class::giveloadout( self.team, self.class );
    }
    
    armor::function_164c824617d7e8d7( 3 );
    br_utility::unmarkplayeraseliminated( self );
    self setplayerangles( ( 0, spawn_point.angles[ 1 ], 0 ) );
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x2f27f3bd, Offset: 0x413a
// Size: 0x59
function player_respawn_intermission( show_map )
{
    self notify( #"hash_73f9f38d02f88669" );
    self endon( #"hash_73f9f38d02f88669" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    wait 1;
    omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 2 );
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x56225ddb, Offset: 0x419b
// Size: 0xb6
function function_5f971d031206e7d8( params )
{
    musicbank_utility::function_4f253fd35ec68cbc( self );
    
    if ( level flags::gameflag( "infil_complete" ) )
    {
        self waittill( #"loadout_class_selected" );
        player_infil( 0 );
        return;
    }
    
    if ( level flags::gameflag( "prematch_fade_done" ) )
    {
        utility::flag_wait( "clash_location_spawn_points_complete" );
        spawn_areas = level.clash.location.infil_spawns[ self.team ];
        index = self.sessionsquadid % spawn_areas.size;
        self.clash_infil_spawn_area = spawn_areas[ index ];
        player_infil( 1 );
    }
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x9c112de5, Offset: 0x4259
// Size: 0x14
function function_9ec71463f32ce2a7( player )
{
    musicbank_utility::function_4f253fd35ec68cbc( self );
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x30210384, Offset: 0x4275
// Size: 0x2a5
function start_match()
{
    flags::gameflagwait( "prematch_done" );
    location_select();
    init_contracts();
    function_6a380f72fd2e49b5();
    level.br_level.br_circlecenters = [ level.clash.location.origin, level.clash.location.origin ];
    level.br_level.br_circleradii = [ level.clash.location.radius, level.clash.location.radius ];
    level.br_level.br_circleminimapradii = [ level.clash.location.radius, level.clash.location.radius ];
    cross_angles = ( 0, mod( level.clash.location.angles[ 1 ] - 90, 360 ), 0 );
    var_91924ab1040d73db = br_c130::spawnc130pathstructnewinternal( level.clash.location.origin, cross_angles, 8500, level.clash.location.radius * 2 );
    setomnvar( "ui_br_c130_path_start_x", int( var_91924ab1040d73db.startptui[ 0 ] ) );
    setomnvar( "ui_br_c130_path_start_y", int( var_91924ab1040d73db.startptui[ 1 ] ) );
    setomnvar( "ui_br_c130_path_end_x", int( var_91924ab1040d73db.endptui[ 0 ] ) );
    setomnvar( "ui_br_c130_path_end_y", int( var_91924ab1040d73db.endptui[ 1 ] ) );
    level.br_level.br_circledelaytimes = [ 10000, 10000 ];
    level.br_level.br_circleclosetimes = [ 10000, 10000 ];
    level.br_level.br_circleshowdelaydanger = [ 0, 0 ];
    level.br_level.br_circleshowdelaysafe = [ 0, 0 ];
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x6e4c0c2e, Offset: 0x4522
// Size: 0x302
function start_infil()
{
    level.disablepingvo = 1;
    flags::gameflagset( "prematch_fade_done" );
    gamelogic_mp::pausetimer();
    infil_mode = getdvarint( @"hash_90c01d51ed95af4a", 1 );
    
    foreach ( player in level.players )
    {
        player br_spawnrespawn::function_1d2f70d591e967bc();
    }
    
    if ( infil_mode == 1 )
    {
        success = function_c631622450b8ec82();
        
        if ( !success )
        {
            infil_mode = 0;
        }
        else
        {
            music_br::function_af7220102b36ae29( level.players );
        }
    }
    else
    {
        while ( !level.clash.location.var_7e77ad77ccd67541 )
        {
            waitframe();
        }
    }
    
    level notify( #"hash_edfcaecd14a734a" );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player ismeatshieldvictim() )
        {
            player stopmeatshield( 14 );
        }
        
        player setclientomnvar( "ui_br_infil_started", 1 );
        player setclientomnvar( "ui_br_infiled", 0 );
        player br_public::function_85f6a1f0ca78ff67();
        player.plotarmor = 1;
        player.brneverlanded = 1;
        player.respawningbr = 1;
        player thread player_infil( infil_mode );
        player gameobjects::init_player_gameobjects();
    }
    
    level thread function_be6143c2102a4ae9( "clash_player_infilled" );
    level waittill( #"clash_player_infilled" );
    flags::gameflagset( "infil_complete" );
    gamelogic_mp::resumetimer();
    level thread function_b04d974eaf8775f9();
    level thread function_4f0a502122ac29bb();
    level.clash.activity_manager thread function_5ef18511d0f60f49();
    waitframe();
    level.disablepingvo = 0;
    
    foreach ( player in level.players )
    {
        player.plotarmor = undefined;
    }
    
    if ( isdefined( level.clash.name_fx_ent ) )
    {
        wait 10;
        level.clash.name_fx_ent delete();
    }
}

// Namespace br_gametype_clash
// Params 0, eflags: 0x4
// Checksum 0x36d23e64, Offset: 0x482c
// Size: 0x39b, Type: bool
function private function_c631622450b8ec82()
{
    level.clash.location.infil_cameras = [];
    
    foreach ( struct in level.clash.location.map_structs[ "clash_infil" ] )
    {
        if ( struct.script_noteworthy == "namefx" )
        {
            level.clash.location.var_ae4f5ffbbd8f9e64 = struct;
            continue;
        }
        
        level.clash.location.infil_cameras[ struct.script_noteworthy ] = struct;
    }
    
    if ( level.clash.location.infil_cameras.size < 2 )
    {
        println( "<dev string:x280>" + "<dev string:x292>" );
        return false;
    }
    
    level.clash.name_fx_ent = spawn( "script_model", level.clash.location.var_ae4f5ffbbd8f9e64.origin );
    level.clash.name_fx_ent.angles = level.clash.location.angles + ( 0, 90, 0 );
    level.clash.name_fx_ent setmodel( level.clash.name_fx_model );
    level.clash.name_fx_ent forcenetfieldhighlod( 1 );
    level.clash.name_fx_ent setscriptablepartstate( "name_fx", level.clash.location.name, 0 );
    
    /#
        if ( !level.clash.name_fx_ent getscriptableparthasstate( "<dev string:x2da>", level.clash.location.name ) )
        {
            level.clash.name_fx_ent setscriptablepartstate( "<dev string:x2da>", "<dev string:x2e2>" );
        }
    #/
    
    max_per_frame = 5;
    i = 0;
    
    foreach ( player in level.players )
    {
        player.infil_camera_ent = spawn( "script_model", player.origin );
        player.infil_camera_ent setmodel( "tag_origin" );
        player.infil_camera_ent thread infil_camera_watcher( player );
        i++;
        
        if ( i >= max_per_frame )
        {
            waitframe();
            i = 0;
        }
    }
    
    function_8f272ce0f51621a1();
    return true;
}

// Namespace br_gametype_clash
// Params 0, eflags: 0x4
// Checksum 0xc6445921, Offset: 0x4bd0
// Size: 0x2af
function private function_8f272ce0f51621a1()
{
    /#
        if ( level.clash.location.infil_spawns )
        {
            return;
        }
    #/
    
    offset = 200;
    
    foreach ( spawn_area in level.clash.location.map_structs[ "clash_infil_spawn" ] )
    {
        spawn_area.slot = 0;
        spawn_area.right = anglestoright( spawn_area.angles );
        spawn_area.back = -1 * anglestoforward( spawn_area.angles );
        spawn_area.grid_start = spawn_area.origin - ( spawn_area.right + spawn_area.back ) * offset;
        
        if ( !isdefined( level.clash.location.infil_spawns[ spawn_area.script_noteworthy ] ) )
        {
            level.clash.location.infil_spawns[ spawn_area.script_noteworthy ] = [];
        }
        
        level.clash.location.infil_spawns[ spawn_area.script_noteworthy ][ level.clash.location.infil_spawns[ spawn_area.script_noteworthy ].size ] = spawn_area;
    }
    
    foreach ( player in level.players )
    {
        spawn_areas = level.clash.location.infil_spawns[ player.team ];
        index = player.sessionsquadid % spawn_areas.size;
        player.clash_infil_spawn_area = spawn_areas[ index ];
    }
}

// Namespace br_gametype_clash
// Params 1, eflags: 0x4
// Checksum 0x4a71ac55, Offset: 0x4e87
// Size: 0x2c
function private infil_camera_watcher( player )
{
    self endon( #"death" );
    player waittill( #"death_or_disconnect" );
    self delete();
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x9b71efc3, Offset: 0x4ebb
// Size: 0x8d
function match_on_player_death( params )
{
    if ( !isdefined( params.attacker ) || params.attacker == params.victim )
    {
        return;
    }
    
    killer = params.attacker;
    points = killer.clash_double_points ? 2 : 1;
    level gamescore::giveteamscoreforobjective( killer.team, points );
    hud_show_score( killer, points );
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xc1f65807, Offset: 0x4f50
// Size: 0x54
function function_b04d974eaf8775f9()
{
    level endon( #"clash_ending" );
    level thread function_5597a9e3b1925cfc();
    level thread function_6379b8bbcf654fcb();
    wait level.clash.time_limit;
    
    /#
        if ( getdvarint( @"hash_4609e5d1ea9e3f04", 0 ) )
        {
            return;
        }
    #/
    
    level thread match_end( "time_limit_reached" );
}

// Namespace br_gametype_clash
// Params 3
// Checksum 0x3a0fdd07, Offset: 0x4fac
// Size: 0x8b
function function_807257b4805fb2b2( team, score, score_event )
{
    if ( score > level.clash.highest_score )
    {
        level.clash.highest_score = score;
        level.clash.tiebreaker_team = team;
    }
    
    if ( score >= level.clash.score_limit )
    {
        level thread match_end( "score_limit_reached", team );
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xf99fa9b4, Offset: 0x503f
// Size: 0x261
function function_4f0a502122ac29bb()
{
    level endon( #"clash_ending" );
    score_thresholds = [ level.clash.score_limit * 0.5, level.clash.score_limit * 0.9 ];
    var_38f9e03637c6ab1e = [ "50_percent", "90_percent" ];
    dialog_data = [];
    
    for ( var_2b12af7970ad425e = gettime();  ; var_2b12af7970ad425e = gettime() )
    {
        level waittill( #"update_team_score", team, score );
        
        if ( gettime() - var_2b12af7970ad425e < 10000 )
        {
            continue;
        }
        
        if ( !isdefined( dialog_data[ team ] ) )
        {
            dialog_data[ team ] = { #var_b23ed1ece665bf8a:0, #threshold:0 };
        }
        
        threshold = score_thresholds[ dialog_data[ team ].threshold ];
        
        if ( threshold && score > threshold )
        {
            suffix = var_38f9e03637c6ab1e[ dialog_data[ team ].threshold ];
            dialog_data[ team ].threshold++;
            var_d3aafe8cf4f3bb04 = teams::getfriendlyplayers( team, 0 );
            var_2f0e7e6815a92743 = teams::getenemyplayers( team, 0 );
            level thread br_public::brleaderdialog( "score_friendly_" + suffix, 0, var_d3aafe8cf4f3bb04, 1, 1, undefined, level.clash.dialog_prefix );
            
            if ( suffix == "50_percent" && score > gamescore::getteamscore( team_utility::getotherteam( team ) ) || suffix == "90_percent" )
            {
                level thread br_public::brleaderdialog( "score_enemy_" + suffix, 0, var_2f0e7e6815a92743, 1, 1, undefined, level.clash.dialog_prefix );
            }
            
            var_2b12af7970ad425e = gettime();
            continue;
        }
        
        if ( !dialog_data[ team ].var_b23ed1ece665bf8a )
        {
            enemy_team = team_utility::getotherteam( team );
            
            if ( score - gamescore::getteamscore( enemy_team ) > 50 )
            {
                dialog_data[ team ].var_b23ed1ece665bf8a = 1;
                var_2f0e7e6815a92743 = teams::getfriendlyplayers( enemy_team, 0 );
                level thread br_public::brleaderdialog( "score_enemy_ahead_50", 0, var_2f0e7e6815a92743, 1, 1, undefined, level.clash.dialog_prefix );
            }
        }
    }
}

// Namespace br_gametype_clash
// Params 2
// Checksum 0x3b9dd0e7, Offset: 0x52a8
// Size: 0x2a7
function match_end( reason, winner = gamescore::calculatewinningteam() )
{
    if ( winner == "none" )
    {
        winner = level.clash.tiebreaker_team;
        gamescore::setteamscore( winner, gamescore::getteamscore( winner ) + 1, 0 );
    }
    
    println( "<dev string:x2ea>" + "<dev string:x2f3>" + reason + "<dev string:x308>" + winner );
    level callback::remove( #"player_connect", &function_5f971d031206e7d8 );
    flags::gameflagset( "clash_ending" );
    level.clash.winning_team = winner;
    level.clash.activity_manager thread function_e57123a31f9d197c();
    
    foreach ( vtol in level.clash.vtols.instances )
    {
        vtol thread namespace_d8aa62974d31a92f::chopper_flyaway();
    }
    
    if ( winner != "none" )
    {
        winning_players = teams::getfriendlyplayers( winner, 0 );
        losing_players = teams::getenemyplayers( winner, 0 );
        level thread br_public::brleaderdialog( "match_victory", 0, winning_players, 1, 1, undefined, level.clash.dialog_prefix_new );
        level thread br_public::brleaderdialog( "match_loss", 0, losing_players, 1, 1, undefined, level.clash.dialog_prefix_new );
    }
    else
    {
        level thread br_public::brleaderdialog( "match_draw", 0, undefined, 1, 1, undefined, level.clash.dialog_prefix );
    }
    
    foreach ( player in level.players )
    {
        player.br_spectatorinitialized = 1;
    }
    
    level.modespawnendofgame = &function_4c2a5d2bbe85866d;
    gamelogic_mp::endgame( winner, game[ "end_reason" ][ reason ], game[ "end_reason" ][ reason ] );
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x9a7410c7, Offset: 0x5557
// Size: 0xb, Type: bool
function function_4c2a5d2bbe85866d()
{
    thread function_55352fd1ff14e9df();
    return true;
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x1fc7b125, Offset: 0x556b
// Size: 0x99
function function_55352fd1ff14e9df()
{
    self endon( #"disconnect" );
    fallback_location = { #angles:( 0, 0, 0 ), #origin:level.clash.location.origin + ( 0, 0, 1000 ) };
    wait 5;
    thread playerlogic::spawnintermission( level.clash.location.map_structs[ "clash_spectator_cam" ][ 0 ] ?? fallback_location );
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0xdeae6a3c, Offset: 0x560c
// Size: 0x3a
function winners_circle_on_activate( params )
{
    if ( level.br_circle.dangercircleent )
    {
        level.br_circle.dangercircleent delete();
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x573fb4bd, Offset: 0x564e
// Size: 0x1a4
function function_5597a9e3b1925cfc()
{
    level endon( #"clash_ending" );
    times = [ level.clash.time_limit * 0.5, level.clash.time_limit * 0.25, 1 ];
    dialog_names = [ "timer_50", "timer_25", "timer_final_min" ];
    current_time_sec = gettime() / 1000;
    end_time_sec = current_time_sec + level.clash.time_limit;
    
    for ( i = 0; i < times.size ; i++ )
    {
        wait end_time_sec - current_time_sec - times[ i ];
        current_time_sec = gettime() / 1000;
        current_winner = gamescore::calculatewinningteam();
        
        if ( current_winner == "none" )
        {
            level thread br_public::brleaderdialog( dialog_names[ i ], 0, undefined, 1, 3, undefined, level.clash.dialog_prefix );
            continue;
        }
        
        winning_players = teams::getfriendlyplayers( current_winner, 0 );
        losing_players = teams::getenemyplayers( current_winner, 0 );
        level thread br_public::brleaderdialog( dialog_names[ i ] + "_losing", 0, losing_players, 1, 3, undefined, level.clash.dialog_prefix );
        level thread br_public::brleaderdialog( dialog_names[ i ] + "_winning", 0, winning_players, 1, 3, undefined, level.clash.dialog_prefix );
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x22621334, Offset: 0x57fa
// Size: 0x7f
function function_6379b8bbcf654fcb()
{
    level endon( #"clash_ending" );
    music_delay = 30;
    current_time_sec = gettime() / 1000;
    end_time_sec = current_time_sec + level.clash.time_limit;
    wait end_time_sec - current_time_sec - music_delay;
    musicbank_utility::function_4f253fd35ec68cbc( level.players );
    musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_88e7d146b5895d38" );
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x48594b18, Offset: 0x5881
// Size: 0xa
function gametype_onstartgametype()
{
    level thread start_match();
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xe5208e4d, Offset: 0x5893
// Size: 0x9
function function_d1dccf97c5ee9b77()
{
    start_infil();
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xe9b9ced3, Offset: 0x58a4
// Size: 0xdb, Type: bool
function gametype_droponplayerdeath()
{
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    spawnoptions.isdeathevent = 1;
    filter = { #dropperks:1, #dropkillstreak:1, #dropsuper:1, #droparmor:1, #dropcash:1, #dropammo:1 };
    
    if ( !item_weapon::items_weapon_removeweapon( { #spawnoptions:spawnoptions, #weapon:self.lastnormalweaponobj } ) )
    {
        weapon = item_weapon::function_e7484276ad85f220( #"primary_0" );
        item_weapon::items_weapon_removeweapon( { #spawnoptions:spawnoptions, #weapon:weapon } );
    }
    
    common_inventory::function_71114c5adfb01f7b( spawnoptions, filter );
    return true;
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x1acaea64, Offset: 0x5988
// Size: 0xd
function gametype_markplayeraseliminatedonkilled()
{
    return flags::gameflag( "clash_ending" );
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0xa8e6c4bf, Offset: 0x599e
// Size: 0xd, Type: bool
function function_9a5954e9b78fdff8( teamname )
{
    return false;
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0xea5403b8, Offset: 0x59b4
// Size: 0xc
function function_9e9294e1796d9412( winnerplayers )
{
    
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xbebd11a2, Offset: 0x59c9
// Size: 0xe, Type: bool
function gametype_shouldrespawn()
{
    return !flags::gameflag( "clash_ending" );
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x87a2a276, Offset: 0x59e0
// Size: 0x17
function gametype_spawnhandled( player )
{
    return flags::gameflag( "prematch_done" );
}

// Namespace br_gametype_clash
// Params 2
// Checksum 0xf6656ca7, Offset: 0x5a00
// Size: 0x58, Type: bool
function gametype_playerrespawn( death_data, final_death )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( flags::gameflag( "clash_ending" ) )
    {
        death_data.victim thread br_spectate::spawnspectator( death_data, 1, 0 );
        return false;
    }
    
    thread player_respawn( death_data );
    return true;
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x66203db3, Offset: 0x5a61
// Size: 0x1f
function function_e62b9ea8139de01c()
{
    return level.clash.location.origin;
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xb07fddde, Offset: 0x5a89
// Size: 0x2
function function_2d550da4c966c7e1()
{
    
}

// Namespace br_gametype_clash
// Params 2
// Checksum 0x852e6db0, Offset: 0x5a94
// Size: 0x2d
function function_347e7011fde30d0f( botloadoutphase, botdifficulty )
{
    return level.br_level.var_90935020921adca4[ 0 ][ botdifficulty ];
}

// Namespace br_gametype_clash
// Params 1, eflags: 0x4
// Checksum 0x2aa2e9b8, Offset: 0x5aca
// Size: 0xf3
function private function_2ad15fd7dbc00f8a( team )
{
    id = objidpoolmanager::requestobjectiveid( 99 );
    assert( id > -1, "<dev string:x24>" + "<dev string:x314>" + "<dev string:x62>" + "<dev string:x33f>" );
    objidpoolmanager::update_objective_ownerteam( id, team );
    objidpoolmanager::update_objective_state( id, "active" );
    objidpoolmanager::update_objective_icon( id, "jup_ui_map_icon_stronghold" );
    objidpoolmanager::update_objective_position( id, level.clash.location.team_data[ team ].spawn_origin );
    objidpoolmanager::update_objective_setbackground( id, 1 );
    objidpoolmanager::objective_showdistance( id, 0 );
    objective_setpings( id, 0 );
    objective_disableping( id, 1 );
    objective_sethideelevation( id, 1 );
    objidpoolmanager::update_objective_setfriendlylabel( id, &"BR_GAMETYPE_CLASH/FRIENDLY_SPAWN" );
    objidpoolmanager::update_objective_setenemylabel( id, &"BR_GAMETYPE_CLASH/ENEMY_SPAWN" );
}

// Namespace br_gametype_clash
// Params 2
// Checksum 0xc8724c6e, Offset: 0x5bc5
// Size: 0xe7
function hud_show_score( players, score )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( score > 0 )
        {
            player thread function_3681643daa77dbe4( score );
        }
        
        if ( level.clash.score_event_table[ score ] )
        {
            player points::doscoreevent( level.clash.score_event_table[ score ] );
        }
    }
}

// Namespace br_gametype_clash
// Params 1, eflags: 0xc
// Checksum 0xcbe6a594, Offset: 0x5cb4
// Size: 0x58
function private function_3681643daa77dbe4( score )
{
    self notify( #"hash_ed1bf653e7eb7aa6" );
    self endon( #"hash_ed1bf653e7eb7aa6" );
    level endon( #"clash_ending" );
    self endon( #"death_or_disconnect" );
    self setclientomnvar( "ui_notify_team_score", score );
    wait 2;
    self setclientomnvar( "ui_notify_team_score", 0 );
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xb97c5fb7, Offset: 0x5d14
// Size: 0x37b
function function_5ef18511d0f60f49()
{
    level endon( #"game_ended" );
    level endon( #"clash_ending" );
    
    /#
        self.debug = { #selected_events:[] };
    #/
    
    self.start_timestamp = gettime();
    
    for ( i = 0; i < self.eventsettings.var_311d5d4c2b63bc2.size ; i++ )
    {
        var_798eb39eadbc47d3 = self.eventsettings.var_311d5d4c2b63bc2[ i ];
        var_c642b1666ec6e202 = self.start_timestamp + var_798eb39eadbc47d3.time * 60000;
        delay = max( var_c642b1666ec6e202 - gettime(), 0 );
        wait delay / 1000;
        event_group = self.eventsettings.var_41bb25ef107192ed[ var_798eb39eadbc47d3.groupindex ];
        valid_types = [];
        
        foreach ( event in event_group.events )
        {
            if ( !isdefined( self.activities[ event.activitytype ] ) )
            {
                continue;
            }
            
            if ( event.var_667f1f247d4dfd6e > 0 && self.activities[ event.activitytype ].times_selected >= event.var_667f1f247d4dfd6e )
            {
                continue;
            }
            
            if ( event.maxactive > 0 && self.activities[ event.activitytype ].instances.size >= event.maxactive )
            {
                continue;
            }
            
            valid_types[ valid_types.size ] = event.activitytype;
        }
        
        if ( valid_types.size <= 0 )
        {
            /#
                debug_data = { #error:"<dev string:x364>", #timestamp:gettime() - self.start_timestamp };
                self.debug.selected_events[ self.debug.selected_events.size ] = debug_data;
            #/
            
            continue;
        }
        
        activity_type = utility::array_random( valid_types );
        activity = self.activities[ activity_type ];
        activity.times_selected++;
        variant = activity_select_variant( activity );
        
        if ( !isdefined( variant ) )
        {
            continue;
        }
        
        /#
            debug_data = { #variant:variant.varianttag, #activity:activity.type, #timestamp:gettime() - self.start_timestamp };
            self.debug.selected_events[ self.debug.selected_events.size ] = debug_data;
            
            if ( self.debug_hud_elems )
            {
                function_5dfb4807d0c211b9();
            }
        #/
        
        activity_instance_common::createactivityinstance( activity.type, variant.varianttag );
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x3db5efd0, Offset: 0x6097
// Size: 0xff
function function_e57123a31f9d197c()
{
    foreach ( type in level.clash.activity_manager.activities )
    {
        foreach ( instance in type.instances )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( instance );
        }
    }
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x772ba589, Offset: 0x619e
// Size: 0xc0
function activity_select_variant( activity )
{
    valid = [];
    
    foreach ( variant in activity.variants )
    {
        if ( !isdefined( activity.instances[ variant.varianttag ] ) )
        {
            valid[ valid.size ] = variant;
        }
    }
    
    select = utility::array_random( valid );
    return select;
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0xd18f0614, Offset: 0x6267
// Size: 0x73
function function_dd85aaa7ce05c803( params )
{
    if ( level.clash.activity_manager.activities[ self.type ] )
    {
        level.clash.activity_manager.activities[ self.type ].instances[ self.varianttag ] = self;
    }
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0xfc1b05d3, Offset: 0x62e2
// Size: 0x71
function function_f79a9201f760e21b( params )
{
    if ( level.clash.activity_manager.activities[ self.type ] )
    {
        level.clash.activity_manager.activities[ self.type ].instances[ self.varianttag ] = undefined;
    }
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0xc39dbdd0, Offset: 0x635b
// Size: 0x16f
function function_5a209a47eb0fde17( team )
{
    level endon( #"game_ended" );
    level endon( #"clash_ending" );
    self.var_6c3b056960c1dfa6[ team ] = [];
    wait 5;
    
    for ( ;; )
    {
        while ( self.var_6c3b056960c1dfa6[ team ].size < level.clash.tablets_per_team )
        {
            node = function_a8237a4c426f1b77( team );
            
            if ( !node )
            {
                continue;
            }
            
            spawn_options = common_item::function_bc5ff2958b71a708( node.origin, node.angles );
            spawn_options.var_fd47e835523b473f = 1;
            spawn_options.cleanupdisabled = 1;
            spawn_options.critical = 1;
            scriptables = getarraykeys( level.activitymanager.var_3f09331d04a683ad );
            selection = scriptables[ randomint( scriptables.size ) ];
            tablet = common_item::items_spawnitemfromscriptable( selection, 1, spawn_options );
            waitframe();
            
            if ( !isdefined( tablet ) )
            {
                println( "<dev string:x280>" + "<dev string:x380>" + selection );
                continue;
            }
            
            tablet setscriptablepartstate( selection, "visible" );
            self.var_6c3b056960c1dfa6[ team ][ self.var_6c3b056960c1dfa6[ team ].size ] = tablet;
            level.var_dc9f6f8625d974c5 = tablet;
            waitframe();
        }
        
        wait 30;
    }
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x39cbb9f3, Offset: 0x64d2
// Size: 0xfa
function function_a8237a4c426f1b77( team )
{
    for ( attempts = 0; attempts < 3 ; attempts++ )
    {
        i = randomint( self.nodes[ team ].size );
        node_info = function_7f6d88f06b34e603( self.nodes[ team ][ i ] );
        
        foreach ( tablet in self.var_6c3b056960c1dfa6[ team ] )
        {
            if ( distance2dsquared( tablet.origin, node_info.origin ) < 250000 )
            {
            }
        }
        
        break;
    }
    
    return node_info;
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0xff34ec29, Offset: 0x65d5
// Size: 0xed
function contracts_on_start( params )
{
    foreach ( team, active_tablets in level.clash.contract_manager.var_6c3b056960c1dfa6 )
    {
        if ( arraycontains( active_tablets, params.task.tablet ) )
        {
            level.clash.contract_manager.var_6c3b056960c1dfa6[ team ] = arrayremove( active_tablets, params.task.tablet );
            break;
        }
    }
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0xc2ce9d2a, Offset: 0x66ca
// Size: 0xcc
function contracts_on_completed( params )
{
    level gamescore::giveteamscoreforobjective( params.players[ 0 ].team, level.clash.var_24a3e9612ee536b3 );
    
    foreach ( player in params.players )
    {
        hud_show_score( player, level.clash.var_24a3e9612ee536b3 );
    }
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x4ecfc587, Offset: 0x679e
// Size: 0xd, Type: bool
function kiosk_spawn_override( instances )
{
    return false;
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x5b93d539, Offset: 0x67b4
// Size: 0x9b
function function_4d14a2b737d1bb4( params )
{
    assert( level.clash.kiosk_specials[ params.itemdata.ref ], "<dev string:x24>" + "<dev string:x3a2>" + "<dev string:x62>" + "<dev string:x3cf>" + params.itemdata.ref );
    [[ level.clash.kiosk_specials[ params.itemdata.ref ] ]]( params );
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0xace0aa74, Offset: 0x6857
// Size: 0x87, Type: bool
function function_ee346b1e16a0270a( params )
{
    if ( params.itemdata.ref != %"saw_clash_special_vtol" )
    {
        return true;
    }
    
    if ( level.clash.vtols.instances.size > 0 )
    {
        params.player hud_message::showerrormessage( &"hash_19c3be4c2722587d" );
        params.player common_kiosk::_closepurchasemenuwithresponse( 2 );
        return false;
    }
    
    return true;
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x2147449b, Offset: 0x68e7
// Size: 0x1d
function function_a5be8eebbfc2eee3( params )
{
    vehicle_upgrade_spawn( "veh_sat_medium_truck_wz", "veh_sat_medium_truck_mg_wz" );
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x7bc7efd0, Offset: 0x690c
// Size: 0x10d
function function_9b50496b73e247ab( params )
{
    loser_base = level.clash.location.team_data[ team_utility::getotherteam( params.player.team ) ].spawn_origin;
    origin = level.clash.location.team_data[ params.player.team ].spawn_origin;
    offset = ( loser_base - origin ) * 0.75;
    target = { #origin:origin + offset };
    params.player thread toma_strike::function_bc1265319f0001e1( target, level.clash.location.radius, 1.5, 100, 0.25, 1 );
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x3ee8a3ee, Offset: 0x6a21
// Size: 0xeb
function function_3a46ce9c5ba0c8ee( params )
{
    foreach ( tower in level.uavtowers )
    {
        var_ab010e5e3c8aa1f4 = tower.uav_station.var_cba25aeb0b0992a9;
        tower.uav_station.var_cba25aeb0b0992a9 = 1;
        level thread uav_tower::function_ad35065b87cb760c( tower.uav_station, undefined, undefined, params.player );
        tower.uav_station.var_cba25aeb0b0992a9 = var_ab010e5e3c8aa1f4;
    }
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x10855951, Offset: 0x6b14
// Size: 0x2da
function function_e5b418336cc7ff( params )
{
    vtol_team = params.player.team;
    team_locs = level.clash.vtols.locations[ vtol_team ];
    loc = team_locs[ 0 ];
    dist = distance2dsquared( loc.origin, params.player.origin );
    
    for ( i = 1; i < team_locs.size ; i++ )
    {
        new_dist = distance2dsquared( loc.origin, params.player.origin );
        
        if ( new_dist < dist )
        {
            loc = team_locs[ i ];
            dist = new_dist;
        }
    }
    
    assert( isdefined( loc ), "<dev string:x24>" + "<dev string:x403>" + "<dev string:x62>" + "<dev string:x42c>" );
    infildistance = level.clash.location.radius + 1000;
    infillocation = loc.origin - level.clash.location.team_data[ vtol_team ].forward_dir * infildistance;
    infillocation += ( 0, 0, 1000 );
    level thread br_public::brleaderdialogteam( "vtol_friendly", params.player.team, 0, 1, undefined, level.clash.dialog_prefix_new );
    level thread br_public::brleaderdialogteam( "vtol_enemy", team_utility::getotherteam( params.player.team ), 0, 1, undefined, level.clash.dialog_prefix_new );
    spawn_params = { #lifetime:120, #infillocation:infillocation, #location:loc, #accel:50, #speed:45, #health:12000, #team:vtol_team };
    vtol = br_clash_vtol::chopper_spawn( loc, spawn_params );
    vtol.owner = params.player;
    level.clash.vtols.instances[ level.clash.vtols.instances.size ] = vtol;
    vtol thread function_7eb34722491856f( vtol_team );
}

// Namespace br_gametype_clash
// Params 1, eflags: 0x4
// Checksum 0x3d7bd039, Offset: 0x6df6
// Size: 0x69
function private function_7eb34722491856f( team )
{
    level endon( #"game_ended" );
    utility::waittill_any( "death", "flyaway" );
    level.clash.vtols.instances = arrayremove( level.clash.vtols.instances, self );
}

// Namespace br_gametype_clash
// Params 2
// Checksum 0x1c3e9bc4, Offset: 0x6e67
// Size: 0x142
function vehicle_upgrade_spawn( old_vehicle_name, new_vehicle_name )
{
    vehicles = vehicle_tracking::function_5820a38c9873992e();
    
    foreach ( vehicle in vehicles )
    {
        if ( vehicle.vehiclename == old_vehicle_name )
        {
            old_spawn_data = vehicle.spawndata;
            spawn_data = br_vehicles::vehiclespawn_getspawndata( { #angles:old_spawn_data.angles, #origin:old_spawn_data.origin } );
            spawn_data.spawnflags = old_spawn_data.spawnflags;
            old_spawn_data vehicle_spawn::set_flag( 8 );
            
            if ( !vehicle.watchingabandoned && vehicle.occupants.size <= 0 )
            {
                vehicle delete();
            }
            
            vehicle = vehicle::spawn( new_vehicle_name, spawn_data );
        }
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x1b733be, Offset: 0x6fb1
// Size: 0x4, Type: bool
function train_vfx_init_override()
{
    return true;
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0xf0cf909, Offset: 0x6fbe
// Size: 0x5c
function function_b0950d0ea14382da()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    br_spawnrespawn::function_1d2f70d591e967bc();
    val::set( "clash_respawn", "freezecontrols_allowlook", 1 );
    self waittill( #"spawned_player" );
    wait 2;
    val::reset( "clash_respawn", "freezecontrols_allowlook" );
    br_spawnrespawn::function_24b79e9319c6f02f();
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x9daef5f3, Offset: 0x7022
// Size: 0xdb
function function_b8b4fe25bd08b89f( origin )
{
    closest_dist = -1;
    closest_team = undefined;
    
    foreach ( team_name, team_data in level.clash.location.team_data )
    {
        team_dist = distance2dsquared( origin, team_data.spawn_origin );
        
        if ( closest_dist < 0 || team_dist < closest_dist )
        {
            closest_dist = team_dist;
            closest_team = team_name;
        }
    }
    
    return closest_team;
}

// Namespace br_gametype_clash
// Params 1
// Checksum 0x2294d97, Offset: 0x7106
// Size: 0x7d
function function_2488974474e84883( origin )
{
    is_allied = vectordot( level.clash.location.team_data[ "allies" ].spawn_vector, origin - level.clash.location.origin ) > 0;
    return is_allied ? "allies" : "axis";
}

// Namespace br_gametype_clash
// Params 3
// Checksum 0x2ec08bfa, Offset: 0x718c
// Size: 0x7d
function function_50687901b42c5033( cell_size, num_cols, slot = self.slot )
{
    col = slot % num_cols;
    row = int( floor( slot / num_cols ) );
    return self.grid_start + self.right * cell_size * col + self.back * cell_size * row;
}

// Namespace br_gametype_clash
// Params 6
// Checksum 0x79e049d0, Offset: 0x7212
// Size: 0x8a
function function_6fc91b28972c065f( scriptable, part, state, player, bautouse, usestring )
{
    if ( part == "body" )
    {
        scriptable.last_player_used = player;
    }
    
    if ( scriptable.type == "br_reusable_loot_cache" )
    {
        var_9621e1a28d672bda = 150;
        scriptable thread function_8bd21f0ca6c88b07( scriptable.origin, var_9621e1a28d672bda );
    }
}

// Namespace br_gametype_clash
// Params 2
// Checksum 0x2b20f2b5, Offset: 0x72a4
// Size: 0x136
function function_8bd21f0ca6c88b07( position, radius )
{
    level endon( #"game_ended" );
    self notify( #"hash_ec851c9bc7e37ed5" );
    self endon( #"hash_ec851c9bc7e37ed5" );
    wait getdvarint( @"hash_fd0c403fee9dc217", 90 );
    
    while ( true )
    {
        a_nearby_players = getplayersinradius( self.origin, 768 );
        
        if ( a_nearby_players.size == 0 )
        {
            break;
        }
        
        wait 5;
    }
    
    scriptables_in_radius = getlootscriptablearrayinradius( undefined, undefined, position, radius );
    
    foreach ( scriptable in scriptables_in_radius )
    {
        if ( scriptable == self )
        {
            continue;
        }
        
        if ( scriptable getscriptableisreserved() )
        {
            scriptable freescriptable();
            continue;
        }
        
        part_name = scriptable function_7c320131bd49bb18()[ 0 ];
        scriptable setscriptablepartstate( part_name, "hidden", 1 );
    }
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x5f8c2e33, Offset: 0x73e2
// Size: 0x94
function function_a0838d5080d8cca0()
{
    a = getentitylessscriptablearray( "scriptable_military_ammo_restock_noent", "classname" );
    
    foreach ( var_b3053b25c717315a in a )
    {
        var_b3053b25c717315a setscriptablepartstate( "military_ammo_restock", "hidden" );
    }
}

// Namespace br_gametype_clash
// Params 2
// Checksum 0xab6e6559, Offset: 0x747e
// Size: 0x17, Type: bool
function function_57a9611d81ed2f0d( origin, radius )
{
    return true;
}

// Namespace br_gametype_clash
// Params 0
// Checksum 0x53fc0054, Offset: 0x749e
// Size: 0x14, Type: bool
function function_3787d0512e4acc1a()
{
    if ( flags::gameflag( "clash_ending" ) )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x61c071e9, Offset: 0x74bb
    // Size: 0x357, Type: dev
    function debug_init()
    {
        level.clash.debug = {};
        setdvarifuninitialized( @"hash_61cea5926d176b0", 500, 1, 1000 );
        setdvarifuninitialized( @"hash_4b62c60511ee58a3", 900, 60, 7200 );
        setdvarifuninitialized( @"hash_4c1f28f1086aab21", 1, 1, 100 );
        setdvarifuninitialized( @"hash_53ab672ea3d1c17e", 12000, 2000, 24000 );
        setdvarifuninitialized( @"hash_cc15a42fb42e9f7f", 0, 0, 10000 );
        devgui::function_9082edeb5db93280( "<dev string:x450>" );
        devgui::add_devgui_func( "<dev string:x45f>", "<dev string:x465>", &debug_draw_clear, 0, 0 );
        devgui::add_devgui_func( "<dev string:x47d>", "<dev string:x48b>", &function_a25b32e923ba45b7, 0, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x4ab>" );
        devgui::add_devgui_func( "<dev string:x4be>", "<dev string:x4ce>", &debug_update_settings );
        devgui::add_devgui_dvar( "<dev string:x4f1>", "<dev string:x4fc>" );
        devgui::add_devgui_dvar( "<dev string:x514>", "<dev string:x520>" );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x539>" );
        devgui::add_devgui_dvar( "<dev string:x549>", "<dev string:x55c>", 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x57c>", "<dev string:x590>", &function_b2982071983d6c44, 0, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5af>", "<dev string:x5c0>", &function_b2982071983d6c44, 0, 2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5df>", "<dev string:x5f2>" + level.clash.score_limit, &function_b2982071983d6c44, 0, 3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x612>", "<dev string:x622>" + level.clash.score_limit, &function_b2982071983d6c44, 0, 4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x642>", "<dev string:x654>", &function_89403e5b646d3fd0, 0, 5 );
        devgui::add_devgui_func( "<dev string:x673>", "<dev string:x686>", &function_a46ec2f575a0511b, 0, 6 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x6a2>" );
        devgui::add_devgui_dvar( "<dev string:x6b8>", "<dev string:x6c4>", 0 );
        devgui::add_devgui_func( "<dev string:x6ea>", "<dev string:x6fb>", &function_12a017fafaebf047 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x71a>" );
        devgui::add_devgui_func( "<dev string:x72a>", "<dev string:x73e>", &function_1113a0f97faa8fac );
        devgui::add_devgui_func( "<dev string:x765>", "<dev string:x775>", &function_fac194f552f6c2db );
        devgui::add_devgui_func( "<dev string:x798>", "<dev string:x7ac>", &function_1cc054fd129accf2 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x7cd>" );
        devgui::add_devgui_func( "<dev string:x7dd>", "<dev string:x7e9>", &function_4d05d617c5331408 );
        devgui::add_devgui_func( "<dev string:x80d>", "<dev string:x81d>", &function_c057f29b224637f0 );
        devgui::add_devgui_func( "<dev string:x840>", "<dev string:x84d>", &function_1a9b5cd7dca2d8fb );
        devgui::add_devgui_func( "<dev string:x872>", "<dev string:x880>", &function_2acff8856e66fd00 );
        devgui::add_devgui_func( "<dev string:x8a6>", "<dev string:x8b1>", &function_f278bbe9916cfd51 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x8d4>" );
        devgui::add_devgui_func( "<dev string:x8e4>", "<dev string:x8f9>", &function_2883653ca6300d6f );
        devgui::add_devgui_dvar( "<dev string:x917>", "<dev string:x925>" );
        devgui::add_devgui_func( "<dev string:x947>", "<dev string:x963>", &function_a3c5271a061f2714 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x8e44c40c, Offset: 0x781a
    // Size: 0x165, Type: dev
    function debug_init_locations()
    {
        devgui::function_9082edeb5db93280( "<dev string:x98a>" );
        
        foreach ( loc in level.clash.locations )
        {
            devgui::function_cd4e263c1f3018ae( loc.name, "<dev string:x9ab>" + loc.name, &function_ca24356d6e6365bd );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x9cd>" );
        
        foreach ( loc in level.clash.locations )
        {
            devgui::function_cd4e263c1f3018ae( loc.name, "<dev string:x9e5>" + loc.name, &function_9ddd0f72e62cc408 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x5fa349a7, Offset: 0x7987
    // Size: 0x10d, Type: dev
    function debug_init_activities()
    {
        devgui::function_9082edeb5db93280( "<dev string:xa07>" );
        
        foreach ( name, activity in level.clash.activity_manager.activities )
        {
            devgui::function_cd4e263c1f3018ae( name, "<dev string:xa1e>" + name, &debug_start_event );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xa3e>" );
        devgui::add_devgui_func( "<dev string:xa4f>", "<dev string:xa58>", &function_e57123a31f9d197c, 2 );
        devgui::add_devgui_func( "<dev string:xa74>", "<dev string:xa7e>", &function_5dfb4807d0c211b9, 3 );
        devgui::add_devgui_func( "<dev string:xaa1>", "<dev string:xaab>", &function_923da4dd98e2d52d, 4 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x61b6deaf, Offset: 0x7a9c
    // Size: 0x65, Type: dev
    function debug_update_settings()
    {
        if ( utility::flag( "<dev string:xacf>" ) )
        {
            iprintlnbold( "<dev string:xae2>" );
        }
        
        level.clash.score_limit = getdvarint( @"hash_61cea5926d176b0", 500 );
        level.clash.time_limit = getdvarint( @"hash_4b62c60511ee58a3", 900 );
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x866415ae, Offset: 0x7b09
    // Size: 0x11, Type: dev
    function debug_draw_clear()
    {
        level notify( #"clash_clear_debug" );
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x4a4431b7, Offset: 0x7b22
    // Size: 0xae, Type: dev
    function function_a25b32e923ba45b7()
    {
        if ( level.clash.locations.size <= 0 )
        {
            return;
        }
        
        level notify( #"clash_clear_debug" );
        
        foreach ( loc in level.clash.locations )
        {
            debug_draw_location( loc );
        }
    }

    // Namespace br_gametype_clash
    // Params 1
    // Checksum 0x33c36522, Offset: 0x7bd8
    // Size: 0x56, Type: dev
    function function_ca24356d6e6365bd( args )
    {
        if ( !isdefined( level.clash.locations[ args[ 0 ] ] ) )
        {
            return;
        }
        
        level notify( #"clash_clear_debug" );
        debug_draw_location( level.clash.locations[ args[ 0 ] ] );
    }

    // Namespace br_gametype_clash
    // Params 1
    // Checksum 0x7f4aad44, Offset: 0x7c36
    // Size: 0x20, Type: dev
    function debug_draw_location( loc )
    {
        if ( !isdefined( loc ) )
        {
            return;
        }
        
        loc thread function_b96d2f79afebaa47();
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x22fb6bd2, Offset: 0x7c5e
    // Size: 0x2e6, Type: dev
    function function_b96d2f79afebaa47()
    {
        self notify( #"hash_acc955a5201f392b" );
        self endon( #"hash_acc955a5201f392b" );
        level endon( #"game_ended", #"clash_clear_debug" );
        colors = [ "<dev string:xb1e>":( 1, 0, 0 ), "<dev string:xb17>":( 0, 0, 1 ) ];
        height = 10000;
        segments = 5;
        segment_height = height / segments;
        org_bot = self.origin - ( 0, 0, height * 0.5 );
        
        for ( ;; )
        {
            for ( i = 0; i < segments ; i++ )
            {
                bot = org_bot + ( 0, 0, segment_height * i );
                top = bot + ( 0, 0, segment_height );
                cylinder( bot, top, self.radius, ( 1, 1, 1 ), 1 );
            }
            
            print3d( top, "<dev string:xb23>" + self.name, ( 1, 1, 1 ), 1, 10, 1, 1 );
            
            foreach ( team, data in self.team_data )
            {
                sphere( data.spawn_origin, 200, colors[ team ], 1 );
                print3d( data.spawn_origin, team + "<dev string:xb2e>", ( 1, 1, 1 ), 1, 10, 1, 1 );
                
                if ( self === level.clash.location )
                {
                    foreach ( i, point in level.redeploy_spawns[ team ] )
                    {
                        sphere( point.origin, 100, colors[ team ], 1 );
                        print3d( point.origin, team + "<dev string:xb36>" + i + 1, ( 1, 1, 1 ), 1, 2, 1, 1 );
                        line( point.origin, point.origin - ( 0, 0, 10000 ), colors[ team ], 1, 1 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_gametype_clash
    // Params 1
    // Checksum 0xe68c2905, Offset: 0x7f4c
    // Size: 0x92, Type: dev
    function function_b2982071983d6c44( args )
    {
        if ( !isdefined( args[ 0 ] ) )
        {
            args[ 0 ] = 0;
        }
        
        if ( !isdefined( args[ 1 ] ) )
        {
            args[ 1 ] = getdvarint( @"hash_4c1f28f1086aab21", 1 );
        }
        
        team = int( args[ 0 ] ) == 0 ? level.players[ 0 ].team : team_utility::getotherteam( level.players[ 0 ].team );
        level gamescore::giveteamscoreforobjective( team, int( args[ 1 ] ) );
    }

    // Namespace br_gametype_clash
    // Params 1
    // Checksum 0x231e99d1, Offset: 0x7fe6
    // Size: 0x4b, Type: dev
    function function_89403e5b646d3fd0( args )
    {
        if ( !isdefined( args[ 0 ] ) )
        {
            args[ 0 ] = getdvarint( @"hash_4c1f28f1086aab21", 0 );
        }
        
        level gamescore::giveteamscoreforobjective( level.players[ 0 ].team, int( args[ 0 ] ) );
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x47dffeb2, Offset: 0x8039
    // Size: 0xd, Type: dev
    function function_12a017fafaebf047()
    {
        level thread function_6c0d60f60d9918f0();
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0xa2fb3cae, Offset: 0x804e
    // Size: 0x139, Type: dev
    function function_6c0d60f60d9918f0()
    {
        self notify( #"hash_995417c6f1c591d" );
        self endon( #"hash_995417c6f1c591d" );
        level endon( #"game_ended" );
        height = 10000;
        segments = 5;
        segment_height = height / segments;
        org_bot = level.players[ 0 ].origin - ( 0, 0, height * 0.5 );
        text_origin = level.players[ 0 ].origin + ( 0, 0, 200 );
        
        for ( ;; )
        {
            radius = getdvarint( @"hash_53ab672ea3d1c17e", 12000 );
            
            for ( i = 0; i < segments ; i++ )
            {
                bot = org_bot + ( 0, 0, segment_height * i );
                top = bot + ( 0, 0, segment_height );
                cylinder( bot, top, radius, ( 1, 1, 1 ), 1 );
            }
            
            print3d( text_origin, radius, ( 1, 1, 1 ), 1, 10, 1, 1 );
            waitframe();
        }
    }

    // Namespace br_gametype_clash
    // Params 1
    // Checksum 0xfbe26d17, Offset: 0x818f
    // Size: 0x6f, Type: dev
    function function_9ddd0f72e62cc408( args )
    {
        location = args[ 0 ];
        
        if ( !level.clash.locations[ location ] )
        {
            iprintlnbold( "<dev string:xb3f>" + location );
            return;
        }
        
        setdvar( @"hash_d0257569e3ef5bb6", location );
        
        if ( level flags::gameflag( "<dev string:xb58>" ) )
        {
            adddebugcommand( "<dev string:xb67>" );
        }
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0xb78cd17c, Offset: 0x8206
    // Size: 0x17, Type: dev
    function function_1113a0f97faa8fac()
    {
        level.players[ 0 ] thread function_1ad3bd1d233d2aa5();
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x4b01daee, Offset: 0x8225
    // Size: 0x109, Type: dev
    function function_fac194f552f6c2db()
    {
        player = level.players[ 0 ];
        
        if ( isdefined( level.debug_name_fx ) )
        {
            level.debug_name_fx delete();
        }
        
        level.debug_name_fx = spawn( "<dev string:xb74>", player.origin );
        level.debug_name_fx.angles = level.clash.location.angles + ( 0, 90, 0 );
        level.debug_name_fx setmodel( "<dev string:xb81>" );
        level.debug_name_fx forcenetfieldhighlod( 1 );
        level.debug_name_fx setscriptablepartstate( "<dev string:x2da>", level.clash.location.name );
        sphere( player.origin, 100, ( 1, 0, 0 ), 0, 2000 );
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0xe35367ee, Offset: 0x8336
    // Size: 0x22, Type: dev
    function function_4d05d617c5331408()
    {
        level thread function_9b50496b73e247ab( { #player:level.players[ 0 ] } );
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x798ae063, Offset: 0x8360
    // Size: 0x22, Type: dev
    function function_c057f29b224637f0()
    {
        level thread function_a5be8eebbfc2eee3( { #player:level.players[ 0 ] } );
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x131312dc, Offset: 0x838a
    // Size: 0x22, Type: dev
    function function_1a9b5cd7dca2d8fb()
    {
        level thread function_3a46ce9c5ba0c8ee( { #player:level.players[ 0 ] } );
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x9a57502b, Offset: 0x83b4
    // Size: 0x22, Type: dev
    function function_2acff8856e66fd00()
    {
        level thread function_e5b418336cc7ff( { #player:level.players[ 0 ] } );
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x7b1a57f7, Offset: 0x83de
    // Size: 0xd8, Type: dev
    function function_f278bbe9916cfd51()
    {
        enemy_team = team_utility::getotherteam( level.players[ 0 ].team );
        var_cda59cc8b5ebd6c2 = undefined;
        
        foreach ( player in level.players )
        {
            if ( player.team == enemy_team )
            {
                var_cda59cc8b5ebd6c2 = player;
                break;
            }
        }
        
        if ( !var_cda59cc8b5ebd6c2 )
        {
            return;
        }
        
        level thread function_e5b418336cc7ff( { #player:var_cda59cc8b5ebd6c2 } );
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0xa324c5a0, Offset: 0x84be
    // Size: 0x80, Type: dev
    function function_2883653ca6300d6f()
    {
        player = level.players[ 0 ];
        setdvar( @"hash_cc15a42fb42e9f7f", level.clash.location.train_pct * 10000 );
        player omnvar_utility::setcachedclientomnvar( "<dev string:xb99>", 0 );
        player omnvar_utility::setcachedclientomnvar( "<dev string:xbc4>", 0 );
        player omnvar_utility::setcachedclientomnvar( "<dev string:xbef>", 0 );
        level thread function_a51cdfac1f6239a0();
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0xf2d99da8, Offset: 0x8546
    // Size: 0x95, Type: dev
    function function_a51cdfac1f6239a0()
    {
        self notify( #"hash_697b1017bb52c2a8" );
        self endon( #"hash_697b1017bb52c2a8" );
        level endon( #"game_ended" );
        last_pct = 0;
        
        for ( ;; )
        {
            pct = getdvarfloat( @"hash_cc15a42fb42e9f7f", 0 ) / 10000;
            
            if ( pct != last_pct )
            {
                br_movingtrain::function_fac91c4df3c88eaf( "<dev string:xc12>", pct );
                level.wztrain_info.animstruct[ "<dev string:xc12>" ].initialtime = pct;
                last_pct = pct;
            }
            
            waitframe();
        }
    }

    // Namespace br_gametype_clash
    // Params 0, eflags: 0x4
    // Checksum 0xc8068bcf, Offset: 0x85e3
    // Size: 0x2a, Type: dev
    function private function_a3c5271a061f2714()
    {
        pct = getdvarfloat( @"hash_cc15a42fb42e9f7f", 0 ) / 10000;
        function_3bc604f9c0efa918( pct );
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0xe7208856, Offset: 0x8615
    // Size: 0x201, Type: dev
    function function_1cc054fd129accf2()
    {
        if ( !isdefined( level.clash.location.infil_spawns ) )
        {
            function_8f272ce0f51621a1();
        }
        
        print_duration = 60;
        print_duration_frames = int( print_duration / level.framedurationseconds );
        var_5d74c721fce17e73 = 52;
        half_cell = 50;
        
        foreach ( team_spawns in level.clash.location.infil_spawns )
        {
            var_6824c52d45658d98 = int( var_5d74c721fce17e73 / team_spawns.size );
            
            foreach ( spawn in team_spawns )
            {
                cylinder( spawn.origin - ( 0, 0, 100 ), spawn.origin + ( 0, 0, 100 ), 400, ( 1, 0, 0 ), 1, print_duration_frames );
                
                for ( i = 0; i < var_6824c52d45658d98 ; i++ )
                {
                    origin = spawn function_50687901b42c5033( 100, 5, i );
                    sphere( origin, half_cell, ( 1, 0, 0 ), 1, print_duration_frames );
                }
            }
        }
    }

    // Namespace br_gametype_clash
    // Params 1
    // Checksum 0xea4f4363, Offset: 0x881e
    // Size: 0x89, Type: dev
    function debug_start_event( args )
    {
        activity = level.clash.activity_manager.activities[ args[ 0 ] ];
        variant = level.clash.activity_manager activity_select_variant( activity );
        
        if ( activity && variant )
        {
            activity_instance_common::createactivityinstance( activity.type, variant.varianttag );
        }
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x188abc00, Offset: 0x88af
    // Size: 0x2a4, Type: dev
    function function_5dfb4807d0c211b9()
    {
        function_923da4dd98e2d52d();
        manager = level.clash.activity_manager;
        var_9a8af9ee100bf651 = 100;
        var_9a8af8ee100bf41e = 50;
        line_height = 15;
        manager.debug_hud_elems = [];
        
        for ( i = 0; i < manager.eventsettings.var_311d5d4c2b63bc2.size ; i++ )
        {
            hud = newhudelem();
            hud.archived = 0;
            hud.alignx = "<dev string:xc1e>";
            hud.aligny = "<dev string:xc23>";
            hud.horzalign = "<dev string:xc27>";
            hud.vertalign = "<dev string:xc27>";
            hud.foreground = 1;
            hud.fontscale = 1.2;
            hud.alpha = 1;
            hud.x = var_9a8af9ee100bf651;
            hud.y = var_9a8af8ee100bf41e + i * line_height;
            selection = manager.debug.selected_events[ i ];
            
            if ( selection )
            {
                if ( selection.error )
                {
                    hud.color = ( 1, 0, 0 );
                    hud setdevtext( "<dev string:xc32>" + i + "<dev string:xc34>" + selection.timestamp / 1000 + "<dev string:xc38>" + selection.error );
                }
                else
                {
                    hud.color = ( 0.7, 1, 0.7 );
                    hud setdevtext( "<dev string:xc32>" + i + "<dev string:xc34>" + selection.timestamp / 1000 + "<dev string:xc38>" + selection.activity + "<dev string:xc34>" + selection.variant );
                }
            }
            else
            {
                hud setdevtext( "<dev string:xc32>" + i + "<dev string:xc34>" + manager.eventsettings.var_311d5d4c2b63bc2[ i ].time * 60 + "<dev string:xc3b>" + manager.eventsettings.var_311d5d4c2b63bc2[ i ].groupindex );
            }
            
            manager.debug_hud_elems[ manager.debug_hud_elems.size ] = hud;
        }
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x6cd20d68, Offset: 0x8b5b
    // Size: 0xb7, Type: dev
    function function_923da4dd98e2d52d()
    {
        manager = level.clash.activity_manager;
        
        if ( !isdefined( manager.debug_hud_elems ) )
        {
            return;
        }
        
        foreach ( elem in manager.debug_hud_elems )
        {
            elem destroy();
        }
        
        manager.debug_hud_elems = undefined;
    }

    // Namespace br_gametype_clash
    // Params 0
    // Checksum 0x880bb3cd, Offset: 0x8c1a
    // Size: 0x12, Type: dev
    function function_a46ec2f575a0511b()
    {
        level thread match_end( "<dev string:xc46>" );
    }

#/
