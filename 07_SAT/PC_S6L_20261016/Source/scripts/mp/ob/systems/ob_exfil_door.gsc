// scripts\mp\ob\systems\ob_exfil_door.gsc  (hash_7fb36ba07573578a.gscc) (size: 90147 Bytes / 0x16023 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb43c54b3 (3023852723)
// size ...... 90147 (0x16023)
// includes .. 48  (offset: 0x15217)
// strings ... 181 (offset: 0x15397)
// dev strs .. 21  (offset: 0x15f27)
// exports ... 205 (offset: 0xee6b)
// cseg ...... 0xe4b + 0xe020 (0xee6b)
// imports ... 525 (offset: 0x10e73)
// animtree1 . 0   (offset: 0x16023)
// animtree2 . 0   (offset: 0x16023)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scripted_widgets;
#using scripts\common\spatial_zone_container;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\content_manager;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\systems\countdown_timer;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_exfil;
#using scripts\mp\ob\systems\ob_music;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objectives\exfil;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;

#namespace ob_exfil_door;

// Namespace ob_exfil_door
// Params 0, eflags: 0x1
// Checksum 0x24eea2a2, Offset: 0xe69
// Size: 0x7a
function autoexec main()
{
    obsettings = ob::get_ob_settings();
    
    if ( getdvarint( @"scr_ob_exfil_door", obsettings.var_5b209255dcf84140 ?? 0 ) == 0 )
    {
        return;
    }
    
    if ( getdvarint( @"scr_ob_exfil_door", 0 ) == 0 )
    {
        return;
    }
    
    level.var_316fff387ea8d0c2 = &initexfil;
    level.var_1e0643fea933c8d2 = &function_4be018a03b3a456a;
    level.exfildoors = {};
    level.var_6ccf11392270179e = [];
}

// Namespace ob_exfil_door
// Params 0
// Checksum 0x180a7346, Offset: 0xeeb
// Size: 0x3c
function function_fbf793c284a15f01()
{
    if ( level.exfildoors.activedoors.size <= 0 )
    {
        return level.exfilspawnpoints[ 0 ];
    }
    
    return level.exfildoors.activedoors[ 0 ];
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x45b17f94, Offset: 0xf30
// Size: 0xd4c
function private initexfil()
{
    exfildoors = level.exfildoors;
    ob_settings = ob::get_ob_settings();
    function_f4150a6e4e65a9c7();
    ob_exfil_activity_init();
    function_841be9aed0a8f421();
    utility::registersharedfunc( #"instanceInventory", #"ismaptomapexfil", &ob_exfil::function_391b310b880fab80 );
    utility::registersharedfunc( #"ob_exfil_door", #"escape", &usedoor );
    utility::registersharedfunc( #"ob_exfil_door", #"hash_7f1df46a0020a91d", &close_doors );
    utility::registersharedfunc( #"activity", #"hash_6cef4604e39b1588", &function_af03327c7a85cd73 );
    utility::registersharedfunc( #"player", #"hash_d4410b0e9a24e367", &function_eb7ea4f9c3e600bc );
    function_f3027df969163df0();
    level utility::waittill_any( "prematch_started", "prematch_done", "start_mode_setup", "infil_started" );
    exfildoors.activedoors = [];
    exfildoors.var_a42f7557ecd5bf2d = getdvarint( @"hash_d2f85fbdb464c5d2", level.gametypebundle.exfildoors.var_a42f7557ecd5bf2d ?? 4 );
    assert( exfildoors.var_a42f7557ecd5bf2d > 0, "<dev string:x24>" );
    exfildoors.var_d523e6d657eec702 = clamp( ceil( level.players.size * level.gametypebundle.exfildoors.percenttarget ), level.gametypebundle.exfildoors.minescapes, level.gametypebundle.exfildoors.maxescapes );
    exfildoors.var_a4008fd14c9f4b99 = level.exfilspawnpoints.size;
    
    if ( getdvarint( @"scr_ob_exfil_door_force_spawn_all", ob_settings.var_61d9ab50e6c0bfbf ?? 0 ) )
    {
        exfildoors.var_315868abc72ccc5 = exfildoors.var_a4008fd14c9f4b99;
    }
    else
    {
        exfildoors.var_315868abc72ccc5 = minint( maxint( level.gametypebundle.exfildoors.var_315868abc72ccc5 ?? 0, 4 ), exfildoors.var_a4008fd14c9f4b99 );
    }
    
    exfildoors.currentspawned = 0;
    exfildoors.teleportmovie = level.gametypebundle.exfildoors.interactionmovie ?? "chi_wc_exfil";
    exfildoors.scriptablemodel = level.gametypebundle.exfildoors.scriptablemodel ?? %"sat_ava_decor_wc_cradle_portal_01_rigged";
    exfildoors.spawnlogic = level.gametypebundle.exfildoors.spawnlogic ?? #"spawnfilter";
    exfildoors.unlimitedescapes = getdvarint( @"hash_1fefb04076357b5", level.gametypebundle.exfildoors.unlimitedescapes ?? 0 );
    exfildoors.var_6593c4731fbef776 = getdvarint( @"hash_174a50a925c72fbe", 0 );
    exfildoors.var_2c026573a4378ad5 = getdvar( @"scr_ob_exfil_door_type", "default" );
    exfildoors.var_4ef8b1fc3b33bbc1 = %"hash_52350d83d32895a";
    exfildoors.var_716dbf32d16e4150 = getdvarint( @"hash_165117c9504a451a", 1 );
    exfildoors.scriptablemodel = exfildoors.var_716dbf32d16e4150 ? "sat_ob_exfil_site" : exfildoors.scriptablemodel;
    
    if ( exfildoors.var_716dbf32d16e4150 )
    {
        exfildoors.var_50dc848530b474de = getdvarint( @"hash_f24da4ef3e5e4dfd", 1 );
        exfildoors.var_60734f62429a2944 = getdvarint( @"hash_87b1a2e77a2f403b", 1 );
        exfildoors.landingradius = getdvarint( @"hash_793e8ed2bab2a59d", 700 );
    }
    
    exfildoors.activationdelay = getdvarint( @"hash_97306f18571ee4e3", level.gametypebundle.exfildoors.activationdelay ?? 90 );
    exfildoors.interactionhint = level.gametypebundle.exfildoors.interactionhint;
    exfildoors.closedicon = level.gametypebundle.exfildoors.closedicon;
    exfildoors.var_3915101deef0430b = level.gametypebundle.exfildoors.usableicon;
    exfildoors.escapeicon = level.gametypebundle.exfildoors.escapeicon;
    exfildoors.var_545afc9b3f57f251 = level.gametypebundle.exfildoors.unusableicon;
    exfildoors.var_edb309392c45f0a3 = "ui_icon_zm_objective_white_ping";
    exfildoors.iconsize = level.gametypebundle.exfildoors.iconsize;
    exfildoors.minibossicon = "sat_ui_wc_storystep_icon";
    exfildoors.var_41ae6024a36f5a38 = getdvarint( @"hash_a52c9c5a137cf363", 1 );
    exfildoors.var_7e2c9c0dede7b426 = getdvarint( @"hash_6075a5e4efb63507", 0 );
    exfildoors.var_b51931f4d46574a3 = getdvarint( @"hash_e099fa46dfb82ff0", 0 );
    exfildoors.var_514046136b01e204 = getdvarint( @"hash_6eac69a48bea63f5", 0 );
    exfildoors.var_575b008daf162253 = level.gametypebundle.exfildoors.var_575b008daf162253;
    exfildoors.var_4b1af9788adee531 = level.gametypebundle.exfildoors.var_4b1af9788adee531;
    exfildoors.var_81b8ca816c480c03 = level.gametypebundle.exfildoors.var_81b8ca816c480c03;
    exfildoors.var_9e82b5beb9861f29 = level.gametypebundle.exfildoors.var_81b8ca816c480c03;
    exfildoors.var_74f695a15bd00fe8 = level.gametypebundle.exfildoors.var_74f695a15bd00fe8;
    exfildoors.var_643af3b0c17c7ff4 = level.gametypebundle.exfildoors.var_643af3b0c17c7ff4;
    exfildoors.var_17b5864fdda8cfc4 = level.gametypebundle.exfildoors.var_17b5864fdda8cfc4;
    exfildoors.var_9bb0578b1505b90e = level.gametypebundle.exfildoors.var_9bb0578b1505b90e;
    exfildoors.var_a08917991a2f537b = level.gametypebundle.exfildoors.var_a08917991a2f537b;
    exfildoors.var_a3539af042faf0cf = level.gametypebundle.exfildoors.var_a3539af042faf0cf;
    exfildoors.var_afe8a5d9bb1ff1f0 = level.gametypebundle.exfildoors.var_afe8a5d9bb1ff1f0;
    level.ob_exfil_throttle = throttle::throttle_initialize( "ob_exfil_player", 1, level.framedurationseconds * 3 );
    exfildoors.captureradius = getdvarint( @"hash_c431abc3280b2c4a", level.gametypebundle.exfildoors.captureradius ?? 500 );
    exfildoors.capturetime = getdvarint( @"hash_418ae87b324eef95", level.gametypebundle.exfildoors.capturetime ?? 30 );
    exfildoors.capturegraceperiod = getdvarint( @"hash_622e1e8f316b88e8", level.gametypebundle.exfildoors.capturegraceperiod ?? 5 );
    exfildoors.exitradius = getdvarint( @"hash_902b57f515d9f31f", level.gametypebundle.exfildoors.exitradius ?? 120 );
    exfildoors.spawndelay = getdvarint( @"hash_104928fb3f290aa2", level.gametypebundle.exfildoors.spawndelay ?? 300 );
    exfildoors.var_9bb96be513470a1 = getdvarint( @"hash_1887bf948771208e", 3 );
    exfildoors.var_16b631fc903a87aa = getdvarint( @"hash_361097b4555034f5", 20 );
    exfildoors.var_3e72cf064a564d5e = getdvarint( @"hash_1602e52eea7654ec", 240 );
    exfildoors.var_502dc9f24b5cdf4a = getdvarint( @"hash_c36040bb3a14a390", 180 );
    exfildoors.cooldowntime = getdvarint( @"hash_5b41c576a85b614a", level.gametypebundle.exfildoors.cooldowntime ?? 180 );
    exfildoors.var_d4f7a382f8d02a28 = getdvarfloat( @"hash_b64915afea8140a6", level.gametypebundle.exfildoors.var_d4f7a382f8d02a28 ?? 0.3 );
    exfildoors.sprintchance = [];
    exfildoors.sprintchance[ "difficulty_easy" ] = 5;
    exfildoors.sprintchance[ "difficulty_normal" ] = 20;
    exfildoors.sprintchance[ "difficulty_hard" ] = 50;
    exfildoors.sprintchance[ "difficulty_darkaether" ] = 80;
    exfildoors.sprintchance[ "difficulty5" ] = 80;
    exfildoors.sprintchance[ "difficulty_last" ] = 80;
    exfildoors.var_c31708f0ea9d2b90 = [];
    exfildoors.var_c31708f0ea9d2b90[ "squad_solo" ] = 4;
    exfildoors.var_c31708f0ea9d2b90[ "squad_small" ] = 6;
    exfildoors.var_c31708f0ea9d2b90[ "squad_large" ] = 8;
    exfildoors.var_c3a64c52632fa7d9 = [];
    exfildoors.var_c3a64c52632fa7d9[ "squad_solo" ] = 4;
    exfildoors.var_c3a64c52632fa7d9[ "squad_small" ] = 6;
    exfildoors.var_c3a64c52632fa7d9[ "squad_large" ] = 8;
    exfildoors.var_fa0d12e1f93b8a3 = [];
    exfildoors.var_fa0d12e1f93b8a3[ "difficulty_easy" ] = 15;
    exfildoors.var_fa0d12e1f93b8a3[ "difficulty_normal" ] = 45;
    exfildoors.var_fa0d12e1f93b8a3[ "difficulty_hard" ] = 60;
    exfildoors.var_fa0d12e1f93b8a3[ "difficulty_darkaether" ] = 120;
    exfildoors.var_fa0d12e1f93b8a3[ "difficulty5" ] = 180;
    exfildoors.var_fa0d12e1f93b8a3[ "difficulty_last" ] = exfildoors.var_3e72cf064a564d5e;
    level.var_5b1aa9671f69f4e9[ "difficulty_easy" ] = 0;
    level.var_5b1aa9671f69f4e9[ "difficulty_normal" ] = 0;
    level.var_5b1aa9671f69f4e9[ "difficulty_hard" ] = 0;
    level.var_5b1aa9671f69f4e9[ "difficulty_darkaether" ] = 0;
    level.var_5b1aa9671f69f4e9[ "difficulty5" ] = 0;
    level.var_c9beb633f5fe093f[ "difficulty_easy" ] = 2;
    level.var_c9beb633f5fe093f[ "difficulty_normal" ] = 6;
    level.var_c9beb633f5fe093f[ "difficulty_hard" ] = 3;
    level.var_c9beb633f5fe093f[ "difficulty_darkaether" ] = 1;
    level.var_c9beb633f5fe093f[ "difficulty5" ] = -1;
    level._effect[ "zombie_exfil_soul_trail" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_weapons_dark_aether_blade_trail" );
    level._effect[ "zombie_exfil_soul_ambient" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_weapons_dark_aether_blade_ambient" );
    level._effect[ "zombie_exfil_soul_impact" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_weapons_dark_aether_blade_impact" );
    level._effect[ "ob_portal_exfil" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_outbreak_tear_destabilizing" );
    callback::add( "on_zombie_ai_killed", &on_ai_killed );
    callback::add( "300_seconds_to_end", &function_faf5430998076cbf );
    callback::add( "900_seconds_to_end", &function_fb0f4690e7404478 );
    
    if ( exfildoors.var_50dc848530b474de )
    {
        vehicle_tracking::reserve_vehicle( exfildoors.var_315868abc72ccc5 );
    }
    
    if ( level.exfilspawnpoints.size )
    {
        /#
            function_3191d4d791f1823f();
            setdvarifuninitialized( @"hash_deb4f16568b92c30", 0 );
            setdvarifuninitialized( @"hash_a92084919397a6d5", 0 );
            thread devgui_debug_spawn();
            thread function_cc460da53f6000ae();
        #/
        
        thread function_b9fb5260cb1ab094();
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x44>" );
    #/
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x207a8f6a, Offset: 0x1c84
// Size: 0x1a1
function private function_841be9aed0a8f421()
{
    exfildoors = level.exfildoors;
    
    if ( !isdefined( exfildoors.var_b27569ebe1090157 ) )
    {
        exfildoors.var_b27569ebe1090157 = [];
    }
    
    if ( !isdefined( exfildoors.var_b27569ebe1090157[ "set_to_active" ] ) )
    {
        exfildoors.var_b27569ebe1090157[ "set_to_active" ] = [];
    }
    
    if ( !isdefined( exfildoors.var_b27569ebe1090157[ "set_to_open" ] ) )
    {
        exfildoors.var_b27569ebe1090157[ "set_to_open" ] = [];
    }
    
    if ( !isdefined( exfildoors.var_b27569ebe1090157[ "set_to_escape" ] ) )
    {
        exfildoors.var_b27569ebe1090157[ "set_to_escape" ] = [];
    }
    
    set_to_active = exfildoors.var_b27569ebe1090157[ "set_to_active" ];
    set_to_open = exfildoors.var_b27569ebe1090157[ "set_to_open" ];
    set_to_escape = exfildoors.var_b27569ebe1090157[ "set_to_escape" ];
    set_to_active[ "active_default" ] = &function_a22a4c3083518d5e;
    set_to_active[ "active_timer" ] = &function_d71a0fde2f56a8bd;
    set_to_active[ "active_interact" ] = &function_848887cae58d9202;
    set_to_active[ "active_approach" ] = &function_ac55c04a8966c870;
    set_to_active[ "active_near" ] = &function_a22a4c3083518d5e;
    set_to_open[ "open_default" ] = &function_e4767367ae5a55d3;
    set_to_open[ "open_flood" ] = &function_61fefc5bb2b0b6a3;
    set_to_open[ "open_capture" ] = &function_bbe86e4f38b6108c;
    set_to_open[ "open_defend" ] = &function_19756800070aaf6a;
    set_to_escape[ "escape_default" ] = &function_3626b35950c85463;
    set_to_escape[ "escape_boarding" ] = &function_2e71ebd68abe0c31;
    set_to_escape[ "escape_interact" ] = &function_54c430d3d4a958b3;
    set_to_escape[ "escape_near" ] = &function_3626b35950c85463;
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0x3688f6d6, Offset: 0x1e2d
// Size: 0x66
function private function_6ebb3f12c8f1ea04( transition, type )
{
    var_b27569ebe1090157 = level.exfildoors.var_b27569ebe1090157;
    
    if ( !isdefined( var_b27569ebe1090157 ) || !isdefined( var_b27569ebe1090157[ transition ] ) )
    {
        return;
    }
    
    var_9420d1abd7ee483e = var_b27569ebe1090157[ transition ];
    
    if ( !isdefined( var_9420d1abd7ee483e[ type ] ) )
    {
        return;
    }
    
    self [[ var_9420d1abd7ee483e[ type ] ]]();
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xc09f02f7, Offset: 0x1e9b
// Size: 0x459
function private function_f4150a6e4e65a9c7()
{
    exfildoors = level.exfildoors;
    
    if ( !isdefined( exfildoors.ob_exfil_settings ) )
    {
        exfildoors.ob_exfil_settings = [];
    }
    
    ob_settings = exfildoors.ob_exfil_settings;
    
    if ( !isdefined( ob_settings[ "default" ] ) )
    {
        ob_settings[ "default" ] = {};
    }
    
    if ( !isdefined( ob_settings[ "mwz" ] ) )
    {
        ob_settings[ "mwz" ] = {};
    }
    
    if ( !isdefined( ob_settings[ "final" ] ) )
    {
        ob_settings[ "final" ] = {};
    }
    
    if ( !isdefined( ob_settings[ "simple" ] ) )
    {
        ob_settings[ "simple" ] = {};
    }
    
    default_ob = ob_settings[ "default" ];
    mwz_ob = ob_settings[ "mwz" ];
    final_ob = ob_settings[ "final" ];
    simple_ob = ob_settings[ "simple" ];
    default_ob.exfiltype = #"hash_c401715f6e7df32f";
    default_ob.active_type = "active_interact";
    default_ob.open_type = "open_defend";
    default_ob.escape_type = "escape_boarding";
    default_ob.var_4eea5dd195b08709 = 1;
    default_ob.var_e2b81afb1f04c568 = 1;
    default_ob.var_81eb8427a16f22c = 1;
    default_ob.var_6593c4731fbef776 = exfildoors.var_6593c4731fbef776;
    default_ob.var_b51931f4d46574a3 = exfildoors.var_b51931f4d46574a3;
    mwz_ob.exfiltype = #"hash_c401715f6e7df32f";
    mwz_ob.active_type = "active_interact";
    mwz_ob.open_type = "open_flood";
    mwz_ob.escape_type = "escape_boarding";
    mwz_ob.var_4eea5dd195b08709 = 0;
    mwz_ob.var_e2b81afb1f04c568 = 1;
    mwz_ob.var_81eb8427a16f22c = 1;
    mwz_ob.hideactivity = 1;
    mwz_ob.var_26a4f0bfbd871eb4 = 0;
    mwz_ob.approachtime = 10;
    mwz_ob.activityvariant = "OB_EXFIL_MWZ";
    mwz_ob.var_c990964cb2f53594 = 1;
    mwz_ob.var_6593c4731fbef776 = exfildoors.var_6593c4731fbef776;
    mwz_ob.var_b51931f4d46574a3 = exfildoors.var_b51931f4d46574a3;
    final_ob.exfiltype = #"hash_c401715f6e7df32f";
    final_ob.active_type = "active_timer";
    final_ob.open_type = "open_defend";
    final_ob.escape_type = "escape_boarding";
    final_ob.var_44fb208ffe048e9a = 300;
    final_ob.var_e2b81afb1f04c568 = 1;
    final_ob.var_91250b5093a4be6 = 1;
    final_ob.var_81eb8427a16f22c = 1;
    final_ob.difficultyoverride = "difficulty_last";
    final_ob.var_50d7fb2d3a5fad4 = 5;
    simple_ob.exfiltype = #"hash_c401715f6e7df32f";
    simple_ob.active_type = "active_timer";
    simple_ob.open_type = "open_default";
    simple_ob.escape_type = "escape_interact";
    simple_ob.var_4eea5dd195b08709 = 1;
    simple_ob.var_6593c4731fbef776 = exfildoors.var_6593c4731fbef776;
    simple_ob.var_b51931f4d46574a3 = exfildoors.var_b51931f4d46574a3;
    simple_ob.var_4e6a7b032853bbbd = 1;
    default_ob.navmeshsettings = { #var_449846521333c31b:1, #var_ad801995e84e31ae:&function_d87b8abe983d8b3c, #var_e976814839225a7c:[ "walkable_vtol_open_doors_navmesh" ], #var_d77476e4230097f7:0, #var_6c2c71716cbaeb4:0 };
    mwz_ob.navmeshsettings = { #var_449846521333c31b:1, #var_ad801995e84e31ae:&function_d87b8abe983d8b3c, #var_e976814839225a7c:[ "walkable_vtol_open_doors_navmesh" ], #var_d77476e4230097f7:0, #var_6c2c71716cbaeb4:1 };
    final_ob.navmeshsettings = default_ob.navmeshsettings;
    simple_ob.navmeshsettings = default_ob.navmeshsettings;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xac3773d2, Offset: 0x22fc
// Size: 0x82
function private ob_exfil_activity_init()
{
    activity_type = "REV_OB_EXFIL";
    activity_bundle_clear = "sat_ob_activitydefinition_exfil_clear";
    activity_bundle_mwz = "sat_ob_activitydefinition_exfil_mwz";
    var_c8e230c00ccda98b = "OB_EXFIL_CLEAR";
    var_39521b6f129ef46c = "OB_EXFIL_MWZ";
    activity_definition_utils::function_74af1ab4059e3c06( activity_bundle_clear, var_c8e230c00ccda98b );
    activity_definition_utils::function_74af1ab4059e3c06( activity_bundle_mwz, var_39521b6f129ef46c );
    activity_common::registeractivitytype( activity_type, &ob_exfil_activity_type_init );
    content_manager::function_3209da123476142f( "sat_ob_exfil", &function_3867121d66a72fb8 );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x1a01413f, Offset: 0x2386
// Size: 0xba
function private ob_exfil_activity_type_init()
{
    activity_type = "REV_OB_EXFIL";
    activity_common::function_944074f3079c1d4e( activity_type, 0, &exfil_activity_setup );
    activity_common::function_944074f3079c1d4e( activity_type, 1, &exfil_activity_start );
    activity_common::function_944074f3079c1d4e( activity_type, 2, &exfil_activity_cleanup );
    activity_common::function_944074f3079c1d4e( activity_type, 3, &exfil_activity_destroy );
    activity_common::function_944074f3079c1d4e( activity_type, 4, &function_6c6e855b2bd7df12 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &exfil_player_joined_activity, "REV_OB_EXFIL" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &exfil_player_left_activity, "REV_OB_EXFIL" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_fc7766f3b79998df, "REV_OB_EXFIL" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerExitedAwarenessZone", &function_d3834cca095affb3, "REV_OB_EXFIL" );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xbca380ee, Offset: 0x2448
// Size: 0x67
function private exfil_activity_setup()
{
    self.var_91c91f4a631c481d = activity_definition_utils::function_837a0c8626c9b419();
    self.var_8a5f3e13cb58e019 = activity_definition_utils::function_9129cd8075c85c09( self );
    var_4fe2d491bc9efbff = ob_activity_manager::function_ed1dae3a9cce08d2( self.varianttag );
    
    if ( isarray( var_4fe2d491bc9efbff ) && var_4fe2d491bc9efbff.size > 0 )
    {
        self notify( #"hash_f543a5d2df692eb9" );
        level thread ob_activity_manager::function_8c2371421d37415a( var_4fe2d491bc9efbff[ 0 ], 100 );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x71354f4e, Offset: 0x24b7
// Size: 0x42
function private exfil_activity_start()
{
    exfil = self.exfil;
    
    if ( exfil && isarray( exfil.nearbyplayers ) )
    {
        activity_participation::function_fb0ec90aaf6d4c61( self, exfil.nearbyplayers );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x35faa6d9, Offset: 0x2501
// Size: 0x2
function private exfil_activity_cleanup()
{
    
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x83f8147b, Offset: 0x250b
// Size: 0x2
function private exfil_activity_destroy()
{
    
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xb3d3492f, Offset: 0x2515
// Size: 0x1bc
function private exfil_player_joined_activity( relevant_info_struct )
{
    door = self.exfil;
    open = door.open;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    var_ad179bc5856f6448 = open.soulscollected ?? 0;
    var_294f7254924f69f0 = self.targetkillcount ?? open.soulsneeded ?? 0;
    stepindex = self.stepindex;
    
    foreach ( player in player_list )
    {
        level musicbank_utility::function_5aca66c390aa347d( player, #"activity_loop" );
        player ob_music::function_a21b9cecb6565243();
    }
    
    rewardamount = ob_activity_definition_utils::function_e55fda458ce2c4cc( self );
    
    if ( isdefined( rewardamount ) )
    {
        activity_definition_utils::updatereward( rewardamount, self );
    }
    
    if ( door.var_495a14578a9bb8f3[ "abandon" ] && door.var_e0e1735fb24f7e85 )
    {
        var_43c55aadacc3b027 = door.var_495a14578a9bb8f3[ "abandon" ].var_43c55aadacc3b027;
        timeremaining = ( var_43c55aadacc3b027 - gettime() ) / 1000;
        activity_definition_utils::updatetimer( timeremaining, self );
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xc2b34111, Offset: 0x26d9
// Size: 0xa6
function private exfil_player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        level musicbank_utility::function_4f253fd35ec68cbc( player, #"activity_loop" );
        player thread ob_music::function_f38728afc2151f12();
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xcd16de9e, Offset: 0x2787
// Size: 0x18, Type: bool
function private function_af03327c7a85cd73( player )
{
    return !player.b_completed_exfil;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x4f518d4e, Offset: 0x27a8
// Size: 0x17
function private function_eb7ea4f9c3e600bc( player )
{
    return player.b_completed_exfil;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xa24b5ed5, Offset: 0x27c8
// Size: 0xc
function private function_fc7766f3b79998df( relevant_info_struct )
{
    
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x276583b3, Offset: 0x27dc
// Size: 0xc
function private function_d3834cca095affb3( relevant_info_struct )
{
    
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x74f7a188, Offset: 0x27f0
// Size: 0x6d
function private function_6c6e855b2bd7df12()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    centerpoint = ( 0, 0, 0 );
    
    if ( self.exfil && self.exfil.origin )
    {
        centerpoint = self.exfil.origin;
    }
    
    return centerpoint;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x1ce3f038, Offset: 0x2866
// Size: 0xc
function private function_3867121d66a72fb8( instance )
{
    
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x7784daa6, Offset: 0x287a
// Size: 0x22d
function private function_f3027df969163df0()
{
    if ( !isdefined( level.exfilspawnpoints ) )
    {
        level.exfilspawnpoints = [];
    }
    
    if ( !isdefined( level.var_5d369d187ab9ad18 ) )
    {
        level.var_5d369d187ab9ad18 = [];
    }
    
    level.var_8b3626fbdd7f4fd6[ "difficulty_easy" ] = [];
    level.var_8b3626fbdd7f4fd6[ "difficulty_normal" ] = [];
    level.var_8b3626fbdd7f4fd6[ "difficulty_hard" ] = [];
    level.var_8b3626fbdd7f4fd6[ "difficulty_darkaether" ] = [];
    exfilspawnfilter = getdvar( @"scr_exfil_spawn_filter", "" );
    spawnpoints = utility::getstructarray( "ob_exfil_spawnpoint", "targetname" );
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( exfilspawnfilter != "" && spawnpoint.script_noteworthy != exfilspawnfilter )
        {
            continue;
        }
        
        if ( spawnpoint.script_parameters == "scripted" )
        {
            level.var_5d369d187ab9ad18 = arraycombineunique( level.var_5d369d187ab9ad18, [ spawnpoint ] );
            continue;
        }
        
        if ( spawnpoint.script_parameters != "disabled" && !arraycontains( level.exfilspawnpoints, spawnpoint ) )
        {
            var_56af1fc2cd2ca5df = region_difficulty_manager::get_region_difficulty( spawnpoint.origin );
            spawnpoint.regiondifficulty = var_56af1fc2cd2ca5df;
            spawnpoint.currentlyinuse = 0;
            level.exfilspawnpoints[ level.exfilspawnpoints.size ] = spawnpoint;
            level.var_8b3626fbdd7f4fd6[ var_56af1fc2cd2ca5df ][ level.var_8b3626fbdd7f4fd6[ var_56af1fc2cd2ca5df ].size ] = spawnpoint;
        }
    }
    
    var_ad666df5e18b33ea = [ "walkable_vtol_open_doors_navmesh" ];
    
    if ( isarray( var_ad666df5e18b33ea ) )
    {
        exfil::function_2880df3073531a72( var_ad666df5e18b33ea );
    }
    
    level callback::callback( #"hash_5848300c673f351a" );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x2d4f3b42, Offset: 0x2aaf
// Size: 0xec
function private function_b9fb5260cb1ab094()
{
    level endon( #"game_ended" );
    level utility::waittill_any_return_params_or_timeout( level.exfildoors.spawndelay, "ob_exfil_door_force_spawn" );
    thread function_363a08bec775bb9b();
    
    while ( level.exfildoors.activedoors.size + level.exfilspawnpoints.size > 0 )
    {
        level waittill( #"hash_1f5ae793c9951b6d" );
    }
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player thread function_52e96fadcc0be567( 0 );
        }
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x7ef92f08, Offset: 0x2ba3
// Size: 0x281
function private function_363a08bec775bb9b()
{
    level endon( #"game_ended" );
    level endon( #"hash_e4d4577c72081791" );
    callback::callback( #"hash_9fdadb77c6e149b4" );
    
    foreach ( spawnpoint in level.exfilspawnpoints )
    {
        level.var_5b1aa9671f69f4e9[ spawnpoint.regiondifficulty ]++;
        level thread spawnexfildoor( spawnpoint );
    }
    
    level thread function_6f4d346bdb858b2f();
    wait 5;
    
    while ( true )
    {
        foreach ( regiondifficulty in [ "difficulty_easy", "difficulty_normal", "difficulty_hard", "difficulty_darkaether" ] )
        {
            if ( level.var_5b1aa9671f69f4e9[ regiondifficulty ] > 0 )
            {
                continue;
            }
            
            bestspawnpoint = undefined;
            var_68fac1da0a78364d = 2147483647;
            
            foreach ( spawnpoint in level.var_8b3626fbdd7f4fd6[ regiondifficulty ] )
            {
                var_792e23a4c84ecd0c = spawnpoint.cooldowntime - gettime();
                
                if ( !spawnpoint.currentlyinuse && var_792e23a4c84ecd0c < var_68fac1da0a78364d )
                {
                    var_68fac1da0a78364d = var_792e23a4c84ecd0c;
                    bestspawnpoint = spawnpoint;
                }
            }
            
            if ( !bestspawnpoint )
            {
                continue;
            }
            
            level notify( "cancel_cooldown_" + bestspawnpoint.name );
            wait 1;
            level.var_5b1aa9671f69f4e9[ bestspawnpoint.regiondifficulty ]++;
            level thread spawnexfildoor( bestspawnpoint );
        }
        
        wait level.exfildoors.var_16b631fc903a87aa;
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xcb89d6f8, Offset: 0x2e2c
// Size: 0x39
function private function_6f4d346bdb858b2f()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_1f5ae793c9951b6d", respawnlocation );
        level thread function_e8c3f1b4722f2e80( respawnlocation );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xd983085a, Offset: 0x2e6d
// Size: 0x98, Type: bool
function private function_f4456a325992bb4a()
{
    foreach ( exfildoor in level.exfildoors.activedoors )
    {
        if ( exfildoor.difficulty_int == self.difficulty_int )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xb530a006, Offset: 0x2f0e
// Size: 0x100
function private function_f16810cd3305a90a()
{
    ob_settings = ob::get_ob_settings();
    
    if ( getdvarint( @"scr_ob_exfil_door_force_spawn_all", ob_settings.var_61d9ab50e6c0bfbf ?? 0 ) )
    {
        return function_db1bae95882b9509();
    }
    
    switch ( level.exfildoors.spawnlogic )
    {
        case #"spawnfilter":
            location = function_f5ad4cfd4f9e1ab3();
            break;
        case #"random":
            location = function_db1bae95882b9509();
            break;
        case #"hash_b2dae834967c4612":
            location = function_a1d1fa998d75b529();
            break;
        case #"nearest":
            location = function_f20a3e246a0dc3a4();
            break;
        case #"averagedistance":
            location = function_d56ad752a55da575();
            break;
        case #"hash_7a60554a0419cfc4":
            location = function_c77af03178f373f9();
            break;
        default:
            location = function_f5ad4cfd4f9e1ab3();
            break;
    }
    
    return location;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xcff32da6, Offset: 0x3017
// Size: 0x147
function private function_b6f6211a0eb4a07f( player )
{
    if ( !isdefined( self.doorent ) )
    {
        return;
    }
    
    if ( !self.doorent function_6d244195f4353fab( player ) )
    {
        return 0;
    }
    
    door = self.doorent;
    door.activatedplayers = [];
    door setscriptablepartstate( #"interact", #"unusable" );
    self notify( #"hash_fda985d5cd0080a7" );
    squad = teams::function_72b89edf6b47c40a( player );
    
    if ( squad.players )
    {
        foreach ( squadmember in squad.players )
        {
            if ( !isplayer( squadmember ) )
            {
                continue;
            }
            
            door.activatedplayers[ squadmember.guid ] = squadmember.guid;
            squadmember thread function_dcc05ab887f29834( "exfil_no_weapon_fire" );
        }
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0xc
// Checksum 0x3d131111, Offset: 0x3166
// Size: 0xa3
function private function_dcc05ab887f29834( flag )
{
    self notify( #"hash_963d69c30e263cfe" );
    self endon( #"hash_963d69c30e263cfe" );
    self endon( #"disconnect" );
    utility::ent_flag_set( flag );
    
    while ( true )
    {
        self waittill( #"weapon_fired", weapon );
        
        if ( weapon.type && ( weapon.type == "locationselect" || weapon.type == "equipdeploy" ) )
        {
            continue;
        }
        
        break;
    }
    
    utility::ent_flag_clear( flag, 1 );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xe6aed288, Offset: 0x3211
// Size: 0x5a
function private function_d5e6eecf06944c30( player )
{
    if ( !isdefined( self.doorent ) )
    {
        return;
    }
    
    door = self.doorent;
    
    if ( door.state == "escape" )
    {
        door usedoor( player );
    }
    
    self notify( #"hash_9c5a1e31eba92118" );
}

// Namespace ob_exfil_door
// Params 1
// Checksum 0x2cc78012, Offset: 0x3273
// Size: 0x40
function function_be76c213a346fa5f( state )
{
    level endon( #"game_ended" );
    door = self;
    door.nextstate = state;
    door notify( #"state_changed" );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xb477ac5a, Offset: 0x32bb
// Size: 0x16c
function private function_ad9ab626849ddb8c( state )
{
    level endon( #"game_ended" );
    door = self;
    door.previousstate = door.state;
    door.state = state;
    door notify( #"state_changed" );
    
    if ( isarray( door.var_2b04f42f93823c0c ) )
    {
        for ( i = door.var_2b04f42f93823c0c.size - 1; i >= 0 ; i-- )
        {
            door [[ door.var_2b04f42f93823c0c[ i ] ]]();
        }
        
        door.var_2b04f42f93823c0c = [];
    }
    
    door notify( door.state );
    
    switch ( state )
    {
        case #"hash_3a820ea654c6bde4":
            break;
        case #"hash_8cdeb1780071702":
            door function_b2c1daa259240f7b();
            break;
        case #"hash_33ced97798fe3cc5":
            door function_ca62712349336731();
            break;
        case #"hash_ffbe1bfa2e9bc347":
            door function_dd101fa52c5d09b3();
            break;
        case #"hash_21c69ec47c409a66":
            door function_93dec806a61df830();
            break;
        case #"hash_f0e5a0c514491f25":
            door function_ae42eb835f799e63();
            break;
        default:
            door.nextstate = "closed";
            return;
    }
}

// Namespace ob_exfil_door
// Params 3
// Checksum 0xd8ab84f7, Offset: 0x342f
// Size: 0xa4f
function spawnexfildoor( location, var_43ad9fbc68124926, spawndata )
{
    level endon( #"game_ended" );
    exfildoors = level.exfildoors;
    
    if ( !isdefined( spawndata ) )
    {
        spawndata = {};
    }
    
    ob_settings = ob::get_ob_settings();
    ob_exfil_type = ob_settings.var_faaeed3d4a7670a5 ?? {};
    exfiltype = var_43ad9fbc68124926 ?? location.type ?? exfildoors.var_2c026573a4378ad5 ?? "default";
    doorsettings = exfildoors.ob_exfil_settings[ exfiltype ];
    activity_variant = doorsettings.activityvariant ?? "OB_EXFIL_CLEAR";
    activity_instance = activity_instance_common::createactivityinstance( "REV_OB_EXFIL", activity_variant, location.origin );
    activity_instance.stepindex = 0;
    
    if ( !activity_instance )
    {
        level.var_5b1aa9671f69f4e9[ location.regiondifficulty ]--;
        return;
    }
    
    level spatial_zone_container::function_847140d2863dfbf8( activity_instance, "OB_Spacer_Spatial_Zone", location.origin, 100, 1 );
    var_ac3df33fdf29bc45 = ob_activity_manager::function_8500471444e81d43( activity_instance, [] );
    
    if ( !var_ac3df33fdf29bc45 )
    {
        activity_instance function_2e9b2ee3d0fa6ab3();
        level.var_5b1aa9671f69f4e9[ location.regiondifficulty ]--;
        return;
    }
    
    exfildoors.currentspawned++;
    location.currentlyinuse = 1;
    spawnlocation = location.origin;
    var_26364526ada33046 = doorsettings.exfiltype == #"hash_c401715f6e7df32f";
    
    if ( getdvarint( @"hash_d5225a741be1e348", 1 ) )
    {
        heightadjust = getdvarint( @"hash_db604cc1c55621d2", var_26364526ada33046 ? 0 : 50 );
        spawnlocation = getgroundposition( spawnlocation, 5 ) + ( 0, 0, heightadjust );
    }
    
    function_1c4c7ef874191be2( "exfil_portal" + location.origin, spawnlocation, 3000, 1 );
    var_c5d6500f9b63bb43 = level.exfildoors.scriptablemodel;
    door = spawnscriptable( var_c5d6500f9b63bb43, spawnlocation, location.angles );
    activity_instance.exfil = door;
    door.active = spawnstruct();
    door.open = spawnstruct();
    door.escape = spawnstruct();
    active = door.active;
    open = door.open;
    escape = door.escape;
    door.exfiltype = doorsettings.exfiltype ?? #"hash_c401715f6e7df32f";
    active.type = doorsettings.active_type ?? "active_default";
    open.type = doorsettings.open_type ?? "open_default";
    escape.type = doorsettings.escape_type ?? "escape_default";
    door.remaining_escapes = level.exfildoors.var_a42f7557ecd5bf2d;
    door.var_c2581f8e7f0a1df2 = -1;
    door.state = "dormant_state";
    door.var_81eb8427a16f22c = doorsettings.var_81eb8427a16f22c;
    door.difficulty = doorsettings.difficultyoverride ?? region_difficulty_manager::get_region_difficulty( door.origin );
    door.difficulty_int = doorsettings.var_50d7fb2d3a5fad4 ?? region_difficulty_manager::get_region_difficulty_int( door.origin );
    door.location = location;
    door.var_4e6a7b032853bbbd = doorsettings.var_4e6a7b032853bbbd;
    door.selectedplayers = spawndata.selectedplayers;
    door.activity_instance = activity_instance;
    
    if ( var_26364526ada33046 )
    {
        door.approachtime = doorsettings.approachtime ?? 45;
    }
    
    if ( door.difficulty != location.regiondifficulty )
    {
        level.var_5b1aa9671f69f4e9[ location.regiondifficulty ]--;
        level.var_5b1aa9671f69f4e9[ door.difficulty ]++;
    }
    
    door.nearbyradius = ob_exfil_type.nearbyradius ?? 2500;
    door.notifyradius = ob_exfil_type.notifyradius ?? 3000;
    door.var_a716abfaa090cb99 = ob_exfil_type.var_a716abfaa090cb99 ?? 1500;
    door.var_b4b3f1f4bbab5553 = ob_exfil_type.var_b4b3f1f4bbab5553 ?? 850;
    door.var_e25843312071cca9 = ob_exfil_type.var_e25843312071cca9 ?? 1000;
    door.var_9396af4d3bf7b824 = ob_exfil_type.var_9396af4d3bf7b824 ?? 200;
    door.abandonradius = getdvarint( @"hash_f691d8b3dad6961b", ob_exfil_type.abandonradius ?? 1200 );
    door.var_6e7f37dd673e6693 = getdvarint( @"hash_d7da9bfd259ba994", ob_exfil_type.var_6e7f37dd673e6693 );
    door.var_e0e1735fb24f7e85 = getdvarint( @"hash_bf305abb8be9f09f", ob_exfil_type.var_e0e1735fb24f7e85 ?? 300 );
    door.var_26a4f0bfbd871eb4 = getdvarint( @"hash_5176530c889624b9", doorsettings.var_26a4f0bfbd871eb4 ?? ob_exfil_type.var_26a4f0bfbd871eb4 ?? 1 );
    door.var_c990964cb2f53594 = getdvarint( @"hash_aeb42feded0919bd", doorsettings.var_c990964cb2f53594 ?? 0 );
    open.updatedifficulty = doorsettings.var_6593c4731fbef776;
    open.var_91250b5093a4be6 = doorsettings.var_91250b5093a4be6;
    open.var_516d2a9a33959f9f = doorsettings.var_516d2a9a33959f9f;
    escape.timetowait = getdvarint( @"hash_4e9e6b7098406cb7", ob_exfil_type.timetowait ?? ( var_26364526ada33046 ? 45 : 20 ) );
    escape.var_735c179f1fa90996 = getdvarint( @"hash_5dae6d00533ffda6", var_26364526ada33046 ? 10 : 10 );
    escape.var_2687aca5dc3c5f0e = getdvarint( @"hash_d25d8861bebdf7db", var_26364526ada33046 ? 5 : 10 );
    escape.timetoland = 15;
    escape.var_44fb208ffe048e9a = doorsettings.var_44fb208ffe048e9a;
    escape.var_e2b81afb1f04c568 = doorsettings.var_e2b81afb1f04c568;
    escape.var_4eea5dd195b08709 = doorsettings.var_4eea5dd195b08709;
    door.navmeshsettings = doorsettings.navmeshsettings;
    door.var_633b95f115bcc581 = {};
    
    if ( var_26364526ada33046 )
    {
        var_633b95f115bcc581 = door.var_633b95f115bcc581;
        var_633b95f115bcc581.abandoned = ob_exfil_type.var_acb43f15ce63d016;
        var_633b95f115bcc581.abandoning = ob_exfil_type.var_b3a6a42510d738f;
        var_633b95f115bcc581.cancelled = ob_exfil_type.var_8f4f03b1efc3fa5b;
        var_633b95f115bcc581.championdefeated = ob_exfil_type.var_b54f263c0bc71e39;
        var_633b95f115bcc581.dangerincoming = ob_exfil_type.var_ae7cb49e820c2723;
        var_633b95f115bcc581.vehicleinbound = ob_exfil_type.var_be3095bc4444b815;
        var_633b95f115bcc581.leaving = ob_exfil_type.var_5b5a685171525d22;
        var_633b95f115bcc581.success = ob_exfil_type.var_3f2950c814fd814b;
        var_633b95f115bcc581.teammateescaped = ob_exfil_type.var_1d45c34b07490cd1;
    }
    
    door.var_2b04f42f93823c0c = [];
    door.var_9c1964c340deb16 = [];
    door.var_99be1c0cdb453bf6 = [];
    door thread function_e47e1d3e2c878d5();
    
    if ( exfildoors.landingradius )
    {
        door.var_2eb52ea1bb4ab171 = spawn( "trigger_radius", door.origin + ( 0, 0, -5000 ), 0, exfildoors.landingradius, 10000 );
        thread trigger::makeenterexittrigger( door.var_2eb52ea1bb4ab171, &function_2937e4590f303c3f, &function_15074e0577870941, undefined, undefined, &function_3558142dc320f639 );
    }
    
    if ( !var_26364526ada33046 )
    {
        door.objid = location objidpoolmanager::createobjective( self.var_545afc9b3f57f251 ?? level.exfildoors.var_545afc9b3f57f251, undefined, 0, 0, 0, level.exfildoors.iconsize );
        objidpoolmanager::update_objective_position( door.objid, spawnlocation + ( 0, 0, 150 ) );
        objidpoolmanager::objective_showdistance( door.objid, 1 );
        objidpoolmanager::objective_show_progress( door.objid, 0 );
        objidpoolmanager::objective_playermask_showtoall( door.objid );
        objidpoolmanager::function_de3fb937d4f45f38( door.objid, 1000, 2000 );
        function_24edb8a97f6832f0( door.objid, 1 );
        function_d1fb910ef06fd658( door.objid, 1000, 2000 );
    }
    
    level.exfildoors.activedoors[ level.exfildoors.activedoors.size ] = door;
    door.nextstate = "ready_state";
    
    while ( door.state != "closed" )
    {
        door function_ad9ab626849ddb8c( door.nextstate );
    }
}

// Namespace ob_exfil_door
// Params 3, eflags: 0x4
// Checksum 0x63afbbf1, Offset: 0x3e86
// Size: 0x16d
function private plotcircle( center_origin, radius, step_size )
{
    centerx = center_origin[ 0 ];
    centery = center_origin[ 1 ];
    circle_vertices = [];
    points = ceil( 6.28318 * radius / step_size );
    step_size = 6.28318 / points;
    theta = 0;
    
    while ( theta < 6.28318 )
    {
        radians = theta * 57.2958;
        x = round( centerx + radius * cos( radians ) );
        y = round( centery + radius * sin( radians ) );
        z = center_origin[ 2 ];
        origin = ( x, y, z );
        start_pos = origin + ( 0, 0, 1024 );
        end_pos = origin - ( 0, 0, 1024 );
        contents = trace::create_world_contents();
        hit_trace = trace::sphere_trace( start_pos, end_pos, 5, undefined, contents );
        
        if ( hit_trace && hit_trace[ "hittype" ] != "hittype_none" )
        {
            end_pos = hit_trace[ "position" ];
        }
        
        circle_vertices[ circle_vertices.size ] = end_pos;
        theta += step_size;
    }
    
    return circle_vertices;
}

// Namespace ob_exfil_door
// Params 5
// Checksum 0x440121c7, Offset: 0x3ffc
// Size: 0x126
function function_a017d1ec37595fa( chevron_type, circle_origin, radius, step_size, var_ef43d1064d479fdd = 0 )
{
    circle_vertices = plotcircle( circle_origin, radius, step_size );
    player = level.players[ 0 ];
    clientid = player getentitynumber();
    payload = [ #"teamselect", clientid ];
    chevrons = [];
    
    for ( i = 0; i < circle_vertices.size ; i++ )
    {
        direction = undefined;
        
        if ( var_ef43d1064d479fdd )
        {
            direction = circle_origin - circle_vertices[ i ];
        }
        else
        {
            direction = circle_vertices[ i ] - circle_origin;
        }
        
        angles = vectortoangles( direction );
        
        if ( !circle_vertices[ i ] )
        {
            continue;
        }
        
        chevron = spawnscriptable( chevron_type, circle_vertices[ i ], angles, undefined, payload );
        chevron setscriptablepartstate( "chevron", "idle" );
        chevrons[ chevrons.size ] = chevron;
    }
    
    return chevrons;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x65810b70, Offset: 0x412b
// Size: 0x81
function private deletechevrons( chevron_array )
{
    foreach ( chevron in chevron_array )
    {
        chevron freescriptable();
    }
    
    chevron_array = [];
    return chevron_array;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x2aa432d3, Offset: 0x41b5
// Size: 0x7e
function private function_c2ce1e3a80374257()
{
    door = self;
    
    if ( isdefined( door.active.trigger ) )
    {
        return;
    }
    
    groundposition = getgroundposition( door.origin, 5 );
    door.active.trigger = spawn( "trigger_radius", groundposition, 0, door.active.capturerange, 512 );
}

// Namespace ob_exfil_door
// Params 3, eflags: 0x4
// Checksum 0x8b24dae4, Offset: 0x423b
// Size: 0xc0
function private function_9314d6b5929c8613( opening_state, transitiontime = level.exfildoors.activationdelay / 6, playtransition = 1 )
{
    var_9bb96be513470a1 = level.exfildoors.var_9bb96be513470a1;
    var_5f96ba8023b274e5 = !playtransition || transitiontime <= var_9bb96be513470a1;
    
    if ( !var_5f96ba8023b274e5 )
    {
        self setscriptablepartstate( #"portal_pending", getxhash( "portal_stage_0" + opening_state ) );
        wait var_9bb96be513470a1;
        transitiontime -= var_9bb96be513470a1;
    }
    
    self setscriptablepartstate( #"portal", getxhash( "portal_stage_0" + opening_state ) );
    wait transitiontime;
}

// Namespace ob_exfil_door
// Params 3, eflags: 0x4
// Checksum 0x6041ab29, Offset: 0x4303
// Size: 0xb1
function private function_d0176888ed4b9106( targetstate, var_f5598f23e8e55125, var_4c3803c59c1cb3d0 )
{
    for ( nextstate = self.var_c2581f8e7f0a1df2 + 1; nextstate < targetstate ; nextstate++ )
    {
        self.var_c2581f8e7f0a1df2 = nextstate;
        var_5bf4181502fba917 = self.var_c2581f8e7f0a1df2 == 5;
        showtransition = !var_5bf4181502fba917 && var_f5598f23e8e55125 || var_5bf4181502fba917 && var_4c3803c59c1cb3d0;
        transitiontime = showtransition ? 3.5 : 1;
        function_9314d6b5929c8613( self.var_c2581f8e7f0a1df2 + 1, transitiontime );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xec83303, Offset: 0x43bc
// Size: 0x8b
function private function_9ae78bd779e6c9a()
{
    if ( level.exfildoors.unlimitedescapes )
    {
        objidpoolmanager::objective_set_show_progress( self.objid, 0 );
        return;
    }
    
    objidpoolmanager::objective_set_progress_count( self.objid, self.remaining_escapes, level.exfildoors.var_a42f7557ecd5bf2d );
    
    if ( self.remaining_escapes > 1 )
    {
        return;
    }
    
    if ( self.remaining_escapes == 1 )
    {
        hud_util::showsplashtoall( "ob_door_final_escape", self.remaining_escapes );
        return;
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x5ca7b58, Offset: 0x444f
// Size: 0x3b
function private function_b2c1daa259240f7b()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"state_changed" );
    function_ebbbac3451f81652();
    self.nextstate = "active_state";
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x366e72ec, Offset: 0x4492
// Size: 0x136
function private function_ebbbac3451f81652()
{
    if ( function_26364526ada33046() )
    {
        self setscriptablepartstate( #"ob_exfil_icon", #"ready" );
        return;
    }
    
    self setscriptablepartstate( #"portal", #"portal_stage_01" );
    self setscriptablepartstate( #"beam", #"unusable" );
    self setscriptablepartstate( #"pulse", #"off" );
    objidpoolmanager::update_objective_icon( self.objid, self.var_545afc9b3f57f251 ?? level.exfildoors.var_545afc9b3f57f251 );
    objidpoolmanager::update_objective_setbackground( self.objid, 14 );
    objidpoolmanager::update_objective_setneutrallabel( self.objid, self.var_575b008daf162253 ?? level.exfildoors.var_575b008daf162253 );
    objidpoolmanager::update_objective_description( self.objid, self.var_575b008daf162253 ?? level.exfildoors.var_575b008daf162253 );
    objidpoolmanager::update_objective_state( self.objid, "current" );
    wait level.exfildoors.var_9bb96be513470a1;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xfd230691, Offset: 0x45d0
// Size: 0x15, Type: bool
function private function_26364526ada33046()
{
    return self.exfiltype == #"hash_c401715f6e7df32f";
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x7cfaf59d, Offset: 0x45ee
// Size: 0x17
function private function_7b5528a9bc0462ea( type )
{
    self.doortype = type;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xf366575a, Offset: 0x460d
// Size: 0x195
function private function_ca62712349336731()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"state_changed" );
    door = self;
    active = door.active;
    
    if ( door.var_4e6a7b032853bbbd )
    {
        doorinteract = door function_c29ab91f732e0767();
        
        foreach ( player in level.players )
        {
            doorinteract disablescriptablepartplayeruse( #"interact", player );
        }
        
        foreach ( player in door.selectedplayers )
        {
            doorinteract enablescriptablepartplayeruse( #"interact", player );
        }
    }
    
    door function_2723f82176647bac();
    door function_6ebb3f12c8f1ea04( "set_to_active", active.type );
    door.nextstate = "open_state";
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x42d1be19, Offset: 0x47aa
// Size: 0x5b
function private function_2723f82176647bac()
{
    door = self;
    
    if ( door function_26364526ada33046() )
    {
        door setscriptablepartstate( #"ob_exfil_icon", #"active" );
        return;
    }
    
    objidpoolmanager::update_objective_icon( door.objid, level.exfildoors.closedicon );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xc85e5372, Offset: 0x480d
// Size: 0x107
function private function_dd101fa52c5d09b3()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"state_changed" );
    door = self;
    open = door.open;
    callback::callback( #"ob_exfil_door_open" );
    open.starttime = gettime();
    
    if ( !open.var_516d2a9a33959f9f )
    {
        door function_db71d891711643fa();
    }
    
    var_1cc7d16b07c9c2b9 = door.var_6e7f37dd673e6693 || door.var_e0e1735fb24f7e85;
    
    if ( var_1cc7d16b07c9c2b9 )
    {
        door childthread function_30a4c76dc77cd458();
    }
    
    if ( open.updatedifficulty )
    {
        door.difficulty = region_difficulty_manager::get_region_difficulty( door.origin );
    }
    
    door function_6ebb3f12c8f1ea04( "set_to_open", open.type );
    door.nextstate = "escape";
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xdabb0e85, Offset: 0x491c
// Size: 0x1b6
function private function_db71d891711643fa()
{
    door = self;
    
    if ( door.var_26a4f0bfbd871eb4 )
    {
        door game_utility::questcircle_create( "ExfilDoor_Ob", door.origin, door.var_e25843312071cca9 );
        door game_utility::questcircle_showtoall();
    }
    
    if ( door function_26364526ada33046() )
    {
        vspeed = 35;
        var_cbbd9c332d27c1d3 = door.approachtime;
        var_aa8e512f7d86e59c = utility::mph_to_ips( vspeed );
        spawndistance = var_cbbd9c332d27c1d3 * var_aa8e512f7d86e59c;
        var_4a1e4cdbe9485a48 = level.mapcenter - door.origin;
        var_4a1e4cdbe9485a48 = vectornormalize( ( var_4a1e4cdbe9485a48[ 0 ], var_4a1e4cdbe9485a48[ 1 ], 0 ) );
        spawnlocation = door.origin + var_4a1e4cdbe9485a48 * spawndistance;
        spawnlocation = function_be4318402c9c1594( spawnlocation ) + ( 0, 0, 8000 );
        spawnangle = ( 0, 0, 0 );
        door.escapevehicle = function_17fa59bd27909396( spawnlocation, spawnangle );
        door setscriptablepartstate( #"ob_exfil_icon", #"open" );
        door setscriptablepartstate( #"ob_exfil_smoke", #"active" );
        door thread function_75928ee6f4d0de21();
        
        if ( door.var_81eb8427a16f22c )
        {
            function_ef385881e5580ce9( door.origin, door.notifyradius, "karm_wcshutdown_vtol_inbound" );
        }
        
        wait 1;
        return;
    }
    
    objidpoolmanager::update_objective_icon( door.objid, level.exfildoors.var_3915101deef0430b );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xf526371, Offset: 0x4ada
// Size: 0x32c
function private function_30a4c76dc77cd458()
{
    door = self;
    open = door.open;
    var_9f49f6fb927229e4 = level.var_aa651267740d4cb1;
    var_1f2881c9921e7e7e = {};
    var_1f2881c9921e7e7e.radiussq = squared( door.abandonradius );
    var_1f2881c9921e7e7e.var_43c55aadacc3b027 = var_9f49f6fb927229e4 ?? 2147483647;
    
    if ( door.var_6e7f37dd673e6693 )
    {
        var_1f2881c9921e7e7e.callbackleft = "players_left_abandon";
        var_1f2881c9921e7e7e.notifyleft = "left_abandon";
        var_1f2881c9921e7e7e.notifyempty = "players_abandoning_exfil";
        door callback::add( var_1f2881c9921e7e7e.callbackleft, &function_9bca046cc983f606 );
    }
    
    if ( door.var_e0e1735fb24f7e85 )
    {
        var_43c55aadacc3b027 = door.var_e0e1735fb24f7e85 * 1000 + ( open.starttime ?? 2147483647 );
        var_1f2881c9921e7e7e.var_43c55aadacc3b027 = minint( var_1f2881c9921e7e7e.var_43c55aadacc3b027, var_43c55aadacc3b027 );
    }
    
    door.var_495a14578a9bb8f3[ "abandon" ] = var_1f2881c9921e7e7e;
    door.var_2b04f42f93823c0c[ door.var_2b04f42f93823c0c.size ] = &function_4eddb61c624dc5a4;
    
    while ( true )
    {
        var_43c55aadacc3b027 = var_1f2881c9921e7e7e.var_43c55aadacc3b027;
        
        if ( var_1f2881c9921e7e7e.var_ebb19653de245a7f && door.var_6e7f37dd673e6693 )
        {
            var_baa430a78832f055 = door.var_6e7f37dd673e6693 * 1000 + var_1f2881c9921e7e7e.var_ebb19653de245a7f;
            var_43c55aadacc3b027 = minint( var_43c55aadacc3b027, var_baa430a78832f055 );
        }
        
        var_9d7460efa597f69a = var_43c55aadacc3b027 - gettime();
        
        if ( var_9d7460efa597f69a < 0 )
        {
            break;
        }
        
        if ( var_1f2881c9921e7e7e.notifyempty )
        {
            door utility::waittill_notify_or_timeout( var_1f2881c9921e7e7e.notifyempty, var_9d7460efa597f69a / 1000 );
        }
        else
        {
            wait var_9d7460efa597f69a / 1000;
        }
        
        waitframe();
    }
    
    switch ( level.gametypebundle.exfildoors.abandonedlogic )
    {
        case #"reset":
            foreach ( func in door.var_99be1c0cdb453bf6 )
            {
                door [[ func ]]();
            }
            
            door.var_99be1c0cdb453bf6 = [];
            door.var_c2581f8e7f0a1df2 = -1;
            door function_be76c213a346fa5f( "ready_state" );
            break;
        default:
            assertmsg( "<dev string:x7b>" );
        case #"close":
            door.abandoned = 1;
            door function_be76c213a346fa5f( "closed" );
            break;
    }
    
    callback::callback( #"hash_4b8b8158c6a2a94b" );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x115ec207, Offset: 0x4e0e
// Size: 0xe5
function private function_9bca046cc983f606( params )
{
    if ( !params.isempty )
    {
        if ( self.var_633b95f115bcc581.leaving )
        {
            foreach ( player in params.playersleft )
            {
                player thread hud_message::showsplash( self.var_633b95f115bcc581.leaving );
            }
        }
        
        return;
    }
    
    function_7786b5b197d1bda2( self.notifyradius, self.var_633b95f115bcc581.abandoning );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xe6f07cb5, Offset: 0x4efb
// Size: 0x69
function private function_4eddb61c624dc5a4()
{
    door = self;
    var_1f2881c9921e7e7e = door.var_495a14578a9bb8f3[ "abandon" ];
    
    if ( !var_1f2881c9921e7e7e )
    {
        return;
    }
    
    if ( var_1f2881c9921e7e7e.callbackleft )
    {
        door callback::remove( var_1f2881c9921e7e7e.callbackleft, &function_9bca046cc983f606 );
    }
    
    door.var_495a14578a9bb8f3[ "abandon" ] = undefined;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x33534a88, Offset: 0x4f6c
// Size: 0x19f
function private function_93dec806a61df830()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"state_changed" );
    door = self;
    escape = door.escape;
    self.var_2b04f42f93823c0c[ self.var_2b04f42f93823c0c.size ] = &function_e1b6bbb1dd92a3a4;
    
    if ( escape.var_44fb208ffe048e9a )
    {
        remainingtime = function_cc2d2ca482a35362();
        timetowait = remainingtime - escape.var_44fb208ffe048e9a;
        wait timetowait;
    }
    
    door function_7af7db5d73e7b4ed();
    
    if ( door.activity_instance )
    {
        door.activity_instance.stepindex = 1;
        activity_definition_utils::function_a0a94881bc380bbf( door.activity_instance.stepindex, door.activity_instance );
    }
    
    remainingtime = function_cc2d2ca482a35362();
    var_1a4b30dd5baeb485 = max( remainingtime - escape.var_735c179f1fa90996, 0 );
    
    if ( !escape.var_44fb208ffe048e9a && escape.timetowait )
    {
        var_1a4b30dd5baeb485 = min( escape.timetowait, var_1a4b30dd5baeb485 );
    }
    
    escape.var_126cb2c6ab482f4e = var_1a4b30dd5baeb485 * 1000 + gettime();
    
    if ( escape.var_e2b81afb1f04c568 )
    {
        door function_731131c319a5b0ac();
    }
    
    door function_6ebb3f12c8f1ea04( "set_to_escape", escape.type );
    door.nextstate = "closed";
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x640cc225, Offset: 0x5113
// Size: 0x20a
function private function_7af7db5d73e7b4ed()
{
    door = self;
    
    if ( door.var_26a4f0bfbd871eb4 )
    {
        game_utility::questcircle_delete();
    }
    
    if ( door function_26364526ada33046() )
    {
        if ( isdefined( door.escapevehicle ) && !door.escapevehicle.arrived )
        {
            door.escapevehicle waittill( #"vehicle_arrived" );
        }
        
        if ( door.var_81eb8427a16f22c )
        {
            function_ef385881e5580ce9( door.origin, door.notifyradius, "karm_wcshutdown_vtol_touchdown" );
        }
        
        door setscriptablepartstate( #"ob_exfil_icon", #"escape" );
        door setscriptablepartstate( #"ob_exfil_smoke", #"escape" );
        door function_931ccc9722ea96fa();
        return;
    }
    
    door setscriptablepartstate( #"pulse", #"escape" );
    door childthread function_d0176888ed4b9106( 6, 1, 1 );
    objidpoolmanager::update_objective_icon( door.objid, level.exfildoors.escapeicon );
    
    if ( !level.exfildoors.unlimitedescapes )
    {
        objidpoolmanager::objective_set_progress_count( door.objid, door.remaining_escapes, level.exfildoors.var_a42f7557ecd5bf2d );
        function_7786b5b197d1bda2( door.notifyradius, "ob_escape_portal_ready", door.remaining_escapes );
    }
    else
    {
        objidpoolmanager::objective_set_show_progress( door.objid, 0 );
        function_7786b5b197d1bda2( door.notifyradius, "ob_splash_escape_portal_unlimited_ready" );
    }
    
    objidpoolmanager::update_objective_setneutrallabel( door.objid, level.exfildoors.var_9bb0578b1505b90e );
    objidpoolmanager::update_objective_description( door.objid, level.exfildoors.var_9bb0578b1505b90e );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xe58569ce, Offset: 0x5325
// Size: 0x5f
function private function_731131c319a5b0ac()
{
    door = self;
    
    if ( getdvarint( @"hash_2074fef149e02df3", 1 ) == 0 )
    {
        return;
    }
    
    door callback::add( "players_joined_escape", &function_bdd996dcad11441d );
    door function_bdd996dcad11441d( { #departing:0, #playersjoined:door.nearbyplayers } );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xa4d008b2, Offset: 0x538c
// Size: 0x13
function private function_e1b6bbb1dd92a3a4()
{
    callback::remove( "players_joined_escape", &function_bdd996dcad11441d );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xfbeb505d, Offset: 0x53a7
// Size: 0x5a
function private function_d5dbafdf7f9a1c42()
{
    door = self;
    escape = door.escape;
    waitframe();
    var_1a4b30dd5baeb485 = ( escape.var_126cb2c6ab482f4e - gettime() ) / 1000;
    
    if ( var_1a4b30dd5baeb485 > 0 )
    {
        wait var_1a4b30dd5baeb485;
    }
    
    door notify( #"door_used_up" );
}

// Namespace ob_exfil_door
// Params 0
// Checksum 0x34b1eaad, Offset: 0x5409
// Size: 0x270
function function_ae42eb835f799e63()
{
    level endon( #"game_ended" );
    door = self;
    assert( arraycontains( level.exfildoors.activedoors, door ) );
    level.exfildoors.currentspawned--;
    level.exfildoors.activedoors = arrayremove( level.exfildoors.activedoors, door );
    door.location.currentlyinuse = 0;
    door function_ee3b7b5a2951daca();
    wait 1;
    
    if ( door.active && door.active.zone && door.active.zone.objidnum )
    {
        objidpoolmanager::returnobjectiveid( door.active.zone.objidnum );
    }
    
    objidpoolmanager::returnobjectiveid( door.objid );
    function_71799ce2c69ce5a9( "exfil_portal" + door.location.origin );
    door function_ce5a413e9be3c312();
    
    if ( isarray( door.var_9c1964c340deb16 ) )
    {
        for ( i = door.var_9c1964c340deb16.size - 1; i >= 0 ; i-- )
        {
            door [[ door.var_9c1964c340deb16[ i ] ]]();
        }
        
        door.var_9c1964c340deb16 = [];
    }
    
    if ( door.escapevehicle )
    {
        door.escapevehicle waittill( #"death" );
        
        while ( isdefined( door.escapevehicle ) )
        {
            waitframe();
        }
    }
    
    door notify( #"death" );
    waitframe();
    level.var_5b1aa9671f69f4e9[ door.difficulty ]--;
    
    if ( door.var_2eb52ea1bb4ab171 )
    {
        trigger::cleanup_enter_exit_trigger( door.var_2eb52ea1bb4ab171, 1 );
        door.var_2eb52ea1bb4ab171 delete();
    }
    
    respawnlocation = door.location;
    
    if ( door isscriptableinstance() )
    {
        door freescriptable();
    }
    else
    {
        door delete();
    }
    
    level notify( #"hash_1f5ae793c9951b6d", respawnlocation );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xa7e9b2c, Offset: 0x5681
// Size: 0x88
function private function_e8c3f1b4722f2e80( respawnlocation )
{
    level endon( #"game_ended" );
    level endon( "cancel_cooldown_" + respawnlocation.name );
    respawnlocation.cooldowntime = gettime() + level.exfildoors.cooldowntime * 1000;
    wait level.exfildoors.cooldowntime;
    level.var_5b1aa9671f69f4e9[ respawnlocation.regiondifficulty ]++;
    level thread spawnexfildoor( respawnlocation );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xbc94be, Offset: 0x5711
// Size: 0x4b
function private function_fb0f4690e7404478( params )
{
    level.exfildoors.cooldowntime = int( level.exfildoors.cooldowntime * level.exfildoors.var_d4f7a382f8d02a28 );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xbd138431, Offset: 0x5764
// Size: 0x265
function private function_ee3b7b5a2951daca()
{
    door = self;
    var_26364526ada33046 = door function_26364526ada33046();
    
    if ( door.var_26a4f0bfbd871eb4 )
    {
        game_utility::questcircle_delete();
    }
    
    if ( var_26364526ada33046 && door.escapevehicle )
    {
        door.abandoned = !door.escapevehicle.canexfil;
    }
    
    if ( door.abandoned )
    {
        function_7786b5b197d1bda2( door.notifyradius, door.var_633b95f115bcc581.abandoned );
        
        if ( var_26364526ada33046 && door.var_81eb8427a16f22c )
        {
            function_ef385881e5580ce9( door.origin, door.notifyradius, "karm_wcshutdown_vtol_cancel" );
        }
    }
    else
    {
        function_7786b5b197d1bda2( door.notifyradius, door.var_633b95f115bcc581.closed );
    }
    
    if ( var_26364526ada33046 )
    {
        vtol = door.escapevehicle;
        door setscriptablepartstate( #"ob_exfil_smoke", #"off" );
        
        if ( vtol )
        {
            if ( vtol.islanded )
            {
                door function_3e2eda1dc6c29681();
            }
            
            if ( !door.abandoned && !vtol.var_841ac822880e1d5a )
            {
                vtol function_a6f1528fa9ee3b98( "karm_wcshutdown_vtol_success" );
            }
            
            if ( door.abandoned || !vtol.var_841ac822880e1d5a )
            {
                door setscriptablepartstate( #"ob_exfil_icon", #"close" );
                door thread function_cbfcc1fd7d9ea20a();
            }
        }
        
        return;
    }
    
    objidpoolmanager::update_objective_icon( door.objid, self.var_545afc9b3f57f251 ?? level.exfildoors.var_545afc9b3f57f251 );
    door setscriptablepartstate( #"beam", #"off" );
    door setscriptablepartstate( #"pulse", #"off" );
    door function_9314d6b5929c8613( 1, 3.5 );
    door setscriptablepartstate( #"portal", #"off" );
    door setscriptablepartstate( #"portal_pending", #"off" );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x46bd7d86, Offset: 0x59d1
// Size: 0x22
function private function_cc2d2ca482a35362()
{
    remainingtime = ( level.var_aa651267740d4cb1 - gettime() ) / 1000;
    return remainingtime;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x18bc79d, Offset: 0x59fc
// Size: 0x121
function private function_52f557d15f30d392()
{
    if ( isdefined( self.open.trigger ) )
    {
        return;
    }
    
    exfiltriggers = getentarray( "exfil_door_trigger", #targetname );
    
    foreach ( trigger in exfiltriggers )
    {
        if ( self.location.origin == trigger.origin )
        {
            self.open.trigger = trigger;
            return;
        }
    }
    
    groundposition = getgroundposition( self.location.origin, 5 );
    self.open.trigger = spawn( "trigger_radius", groundposition, 0, 512, 512 );
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0x68257638, Offset: 0x5b25
// Size: 0x64
function private function_df976ae1237ce2a8( minrange, maxrange )
{
    angle = randomfloat( 360 );
    dist = randomfloatrange( minrange, maxrange );
    x = cos( angle ) * dist;
    y = sin( angle ) * dist;
    return ( x, y, 0 );
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0x5fac7ee7, Offset: 0x5b92
// Size: 0x36
function private function_69ba9ba4b41ca8ee( available, maxburst )
{
    if ( available < 2 )
    {
        return maxint( 0, available );
    }
    
    return randomint( minint( available, maxburst ) - 1 ) + 1;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xcb458fef, Offset: 0x5bd1
// Size: 0xb3
function private function_ce5a413e9be3c312()
{
    foreach ( ai in self.open.spawnedai )
    {
        if ( isalive( ai ) )
        {
            ai.var_a13bed1ac47e1b2c = 1;
            ai.var_8b7eef0172518298 = undefined;
            ai.forceannihilate = 1;
            ai kill();
        }
    }
}

// Namespace ob_exfil_door
// Params 5, eflags: 0x4
// Checksum 0x9cc76b6d, Offset: 0x5c8c
// Size: 0x1f4
function private function_442305994dfe883d( innerradius, outerradius, maxcount, enemyspawntype, var_2a5fa9b2868542da )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( isdefined( var_2a5fa9b2868542da ) )
    {
        self endon( var_2a5fa9b2868542da );
    }
    
    door = self;
    open = door.open;
    
    if ( !isdefined( open.spawnedai ) )
    {
        open.spawnedai = [];
    }
    
    spawncount = 0;
    player = level.players[ 0 ];
    team = "team_hundred_ninety";
    
    if ( !isdefined( innerradius ) )
    {
        innerradius = 1;
    }
    
    if ( !isdefined( outerradius ) )
    {
        outerradius = 1000;
    }
    
    if ( !isdefined( maxcount ) )
    {
        maxcount = 10;
    }
    
    aitype = enemyspawntype ?? "sat_spawner_zombie_base_ob";
    
    while ( true )
    {
        if ( isdefined( open.spawnedai ) )
        {
            spawncount = open.spawnedai.size;
        }
        
        burstcount = function_69ba9ba4b41ca8ee( maxcount - spawncount, 3 );
        
        if ( burstcount < 1 )
        {
            wait 0.5;
            continue;
        }
        
        for ( j = 0; j < burstcount ; j++ )
        {
            spawnposition = door.origin + function_df976ae1237ce2a8( innerradius, outerradius );
            spawnposition = getgroundposition( spawnposition, 8 );
            
            if ( !isdefined( spawnposition ) )
            {
                continue;
            }
            
            spawnrotation = ( 0, 0, randomfloat( 360 ) );
            agent = mp_agent::spawnnewagentaitype( aitype, spawnposition, spawnrotation, team );
            
            if ( isdefined( agent ) )
            {
                open.spawnedai[ open.spawnedai.size ] = agent;
                agent aieventlistenerevent( "combat", player, player.origin );
            }
            
            waitframe();
        }
        
        wait randomintrange( 1, 4 );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xe66368c8, Offset: 0x5e88
// Size: 0x1b7
function private function_e47d672ee8fb1054()
{
    door = self;
    open = door.open;
    open.soulsneeded = 0;
    open.soulscollected = 0;
    
    if ( !isdefined( open.var_1b0a4d89cb879b7c ) )
    {
        open.var_1b0a4d89cb879b7c = [];
    }
    
    if ( !isdefined( open.spawnedai ) )
    {
        open.spawnedai = [];
    }
    
    if ( !isdefined( open.var_1ab16aaea31f9a21 ) )
    {
        open.var_1ab16aaea31f9a21 = 0;
    }
    
    function_7786b5b197d1bda2( door.notifyradius, door.var_633b95f115bcc581.dangerincoming );
    wait 1;
    
    if ( !door function_b5fa3b25110305b() )
    {
        return;
    }
    
    activity_instance_common::function_46135a69bddfec2c( door.activity_instance );
    
    if ( door.var_81eb8427a16f22c )
    {
        function_ef385881e5580ce9( door.origin, door.notifyradius, "karm_wcshutdown_vtol_clear" );
    }
    
    if ( !door function_26364526ada33046() )
    {
        objidpoolmanager::update_objective_setneutrallabel( door.objid, level.exfildoors.var_74f695a15bd00fe8 );
        objidpoolmanager::update_objective_description( door.objid, level.exfildoors.var_74f695a15bd00fe8 );
    }
    
    if ( getdvarint( @"hash_bc4c7b90d9dffa2c", 1 ) )
    {
        door childthread function_b832cc7fe3efca00( "all_souls_collected" );
    }
    
    door utility::ent_flag_wait( "wave_spawn_finished" );
    waitframe();
    door utility::ent_flag_clear( "wave_spawn_finished" );
    door childthread function_2349cc03d3fe0138( 2 );
    door waittill( #"all_souls_collected" );
    wait 2;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x9a894b45, Offset: 0x6047
// Size: 0x183
function private function_b5fa3b25110305b()
{
    door = self;
    open = door.open;
    playersinrange = door.nearbyplayers ?? getplayersinradius( door.origin, 2000 );
    wavestruct = spawnstruct();
    wavestruct.door = door;
    wavestruct.hassoul = 1;
    wavestruct.var_b9bad1456ea0f2ac = level.exfildoors.var_c31708f0ea9d2b90[ function_95a3c39601a6b2ac() ];
    wavestruct.var_a939b2cca9eb639e = 0;
    wavestruct.var_2d8041df79adb2db = gettime();
    wavestruct.var_ff1216aee67109b0 = 10;
    wavestruct.var_b618ce0a703f219c = 3;
    
    if ( door.activity_instance )
    {
        var_1675647f579e9b1e = 5;
        door.activity_instance.targetkillcount = wavestruct.var_b9bad1456ea0f2ac * var_1675647f579e9b1e;
        activity_definition_utils::updateprogress( open.soulscollected, door.activity_instance, door.activity_instance.targetkillcount );
        activity_definition_utils::function_a0a94881bc380bbf( door.activity_instance.stepindex, door.activity_instance );
    }
    
    spawnedwave = door function_8061ff1e2045ae0e( wavestruct );
    return spawnedwave;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xfeb1f7a8, Offset: 0x61d3
// Size: 0xfa
function private function_b8fdb1f1f698ae50()
{
    door = self;
    
    if ( !door function_4a699260dd6079a2() )
    {
        return;
    }
    
    activity_instance = door.activity_instance;
    activity_instance.targetkillcount = 1;
    activity_instance.stepindex = 1;
    activity_definition_utils::function_a0a94881bc380bbf( activity_instance.stepindex, activity_instance );
    
    if ( door.var_81eb8427a16f22c )
    {
        function_ef385881e5580ce9( door.origin, door.notifyradius, "karm_wcshutdown_vtol_boss" );
    }
    
    door utility::ent_flag_wait( "boss_killed" );
    door utility::ent_flag_clear( "boss_killed" );
    activity_definition_utils::updateprogress( 1, activity_instance, 1 );
    function_7786b5b197d1bda2( door.notifyradius, door.var_633b95f115bcc581.championdefeated );
    wait 2;
    activity_instance_common::endactivity( activity_instance, 1 );
    door.activity_instance = undefined;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x6d71acc6, Offset: 0x62d5
// Size: 0x12c
function private function_4a699260dd6079a2()
{
    door = self;
    open = door.open;
    open.soulsneeded = 0;
    open.soulscollected = 0;
    wavestruct = spawnstruct();
    wavestruct.door = door;
    wavestruct.var_b9bad1456ea0f2ac = level.exfildoors.var_c3a64c52632fa7d9[ function_95a3c39601a6b2ac() ];
    wavestruct.var_a939b2cca9eb639e = 0;
    wavestruct.var_2d8041df79adb2db = gettime();
    wavestruct.var_ff1216aee67109b0 = 5;
    wavestruct.var_b618ce0a703f219c = 3;
    wavestruct.var_2e7dc80e31a8516 = 1;
    door function_8061ff1e2045ae0e( wavestruct );
    var_16075a287c2ca557 = spawnstruct();
    var_16075a287c2ca557.door = door;
    var_16075a287c2ca557.var_2e7dc80e31a8516 = 1;
    var_16075a287c2ca557.hassoul = 1;
    var_16075a287c2ca557.finalwave = 1;
    spawnedboss = door function_c2b63c3b42d8a79( var_16075a287c2ca557 );
    return spawnedboss;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x6eec74c9, Offset: 0x640a
// Size: 0xf8, Type: bool
function private function_c2b63c3b42d8a79( wavestruct )
{
    encounter = level.gametypebundle.exfildoors.bossencounter;
    
    if ( !encounter )
    {
        return false;
    }
    
    door = self;
    request_id = ai_spawn_director::spawn_request( encounter, door.origin, door.var_9396af4d3bf7b824, 1, 1, 0 );
    ai_spawn_director::add_spawned_callback( request_id, &function_4b82e3d82cd7157a, wavestruct );
    ai_spawn_director::function_c4cace40604d2bf9( request_id, &function_2fb16ead341c4844, door );
    ai_spawn_director::function_5a08798970350207( request_id, &function_a21e54a316e9e43a, wavestruct );
    function_64ac8c4e752f4dca( request_id, 0 );
    function_1a9d724a960fa19d( request_id, door.difficulty + "_defend", 1 );
    door.open.var_1b0a4d89cb879b7c[ door.open.var_1b0a4d89cb879b7c.size ] = request_id;
    return true;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x9bae9b43, Offset: 0x650b
// Size: 0x148, Type: bool
function private function_8061ff1e2045ae0e( wavestruct )
{
    if ( wavestruct.var_2e7dc80e31a8516 )
    {
        encounter = level.gametypebundle.exfildoors.var_b3f6ebe98c03ba9e;
    }
    else
    {
        encounter = level.gametypebundle.exfildoors.floodencounter;
    }
    
    if ( !encounter )
    {
        return false;
    }
    
    door = self;
    flood_request_id = ai_spawn_director::spawn_request( encounter, door.origin, door.var_e25843312071cca9, 1, 1, 0 );
    ai_spawn_director::add_spawned_callback( flood_request_id, &function_4b82e3d82cd7157a, wavestruct );
    ai_spawn_director::function_c99d360d62c49a9c( flood_request_id, &function_f85b4111dd27fb66, wavestruct );
    ai_spawn_director::function_53289c032f506bb1( flood_request_id, &function_75a56ce4e556fb39, wavestruct );
    ai_spawn_director::function_c4cace40604d2bf9( flood_request_id, &function_2fb16ead341c4844, door );
    ai_spawn_director::function_5a08798970350207( flood_request_id, &function_a21e54a316e9e43a, wavestruct );
    function_64ac8c4e752f4dca( flood_request_id, 0 );
    function_1a9d724a960fa19d( flood_request_id, door.difficulty + "_defend", 1 );
    door.open.var_1b0a4d89cb879b7c[ door.open.var_1b0a4d89cb879b7c.size ] = flood_request_id;
    return true;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x5af875a4, Offset: 0x665c
// Size: 0xe9
function private function_1cc8e3490a040a7e( location )
{
    level endon( #"game_ended" );
    door = self;
    targetlocation = door.origin + ( 0, 0, randomfloatrange( 25, 50 ) );
    fxtag = "j_head";
    soultag = "tag_origin";
    soul = utility::spawn_model( soultag, location );
    waitframe();
    playfxontag( utility::getfx( "zombie_exfil_soul_trail" ), soul, soultag );
    soul moveto( soul.origin + ( 0, 0, 50 ), 1, 0, 1 );
    soul waittill( #"movedone" );
    playfx( utility::getfx( "zombie_exfil_soul_impact" ), soul.origin );
    door function_97374e0c83cfcbbc();
    soul delete();
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x7b27759, Offset: 0x674d
// Size: 0x112
function private function_19b719ecef2d4269( location )
{
    level endon( #"game_ended" );
    door = self;
    targetlocation = door.origin + ( 0, 0, randomfloatrange( 25, 50 ) );
    fxtag = "j_head";
    soultag = "tag_origin";
    soul = utility::spawn_model( soultag, location );
    waitframe();
    playfxontag( utility::getfx( "zombie_exfil_soul_trail" ), soul, soultag );
    soul moveto( soul.origin + ( 0, 0, 50 ), 1, 0, 1 );
    soul waittill( #"movedone" );
    wait randomfloatrange( 0.15, 0.5 );
    soul moveto( targetlocation, 2, 2 );
    soul waittill( #"movedone" );
    playfx( utility::getfx( "zombie_exfil_soul_impact" ), soul.origin );
    door function_97374e0c83cfcbbc();
    soul delete();
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x95890e5d, Offset: 0x6867
// Size: 0x6a
function private function_7c1d8b19f6a38e08()
{
    fxtag = "j_head";
    self.soulfx = utility::spawn_model( "tag_origin", self gettagorigin( fxtag ) );
    self.soulfx linkto( self, fxtag );
    waitframe();
    
    if ( self.soulfx )
    {
        playfxontag( utility::getfx( "zombie_exfil_soul_trail" ), self.soulfx, "tag_origin" );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xf234e5b8, Offset: 0x68d9
// Size: 0x7c
function private function_438f8370a3c75c82()
{
    self endon( #"death_or_disconnect" );
    player = self;
    fxtag = "j_head";
    player.exfilfx = utility::spawn_model( "tag_origin", player gettagorigin( fxtag ) );
    player.exfilfx linkto( player, fxtag );
    waitframe();
    playfxontag( utility::getfx( "ob_portal_exfil" ), player.exfilfx, "tag_origin" );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xc01d17e7, Offset: 0x695d
// Size: 0x10d
function private function_7c595f7713b04ce8( door )
{
    level endon( #"game_ended" );
    self.escapestarttime = gettime();
    
    if ( !isdefined( self.escapeprogress ) )
    {
        self.escapeprogress = 0;
    }
    
    var_1a4b30dd5baeb485 = 3;
    progressbarhud = hud_util::createbar( ( 1, 0, 0 ), 100, 20 );
    progressbarhud hud_util::setpoint( "CENTER", "TOP", 0, 80 );
    progressbarhud.alpha = 0.65;
    progressbarhud.bar.alpha = 0.65;
    progressbarhud hud_util::updatebar( 0 );
    waitframe();
    timefrac = 0;
    
    while ( self.exfiltime && timefrac <= 1 )
    {
        timefrac = ( gettime() - self.escapestarttime ) / var_1a4b30dd5baeb485 * 1000;
        progressbarhud hud_util::updatebar( clamp( timefrac, 0, 1 ) );
        waitframe();
    }
    
    progressbarhud hud_util::destroyelem();
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x86d0234, Offset: 0x6a72
// Size: 0x245
function private function_e47e1d3e2c878d5()
{
    level endon( #"game_ended" );
    door = self;
    door.var_495a14578a9bb8f3 = [];
    var_156e06f4a6f5190f = {};
    var_156e06f4a6f5190f.nearbyplayers = [];
    var_156e06f4a6f5190f.radiussq = squared( door.nearbyradius );
    var_156e06f4a6f5190f.callbackjoined = "players_joined_escape";
    var_156e06f4a6f5190f.notifyjoined = "joined_escape";
    var_156e06f4a6f5190f.callbackleft = "players_left_escape";
    var_156e06f4a6f5190f.notifyleft = "left_escape";
    var_156e06f4a6f5190f.notifyempty = "players_left_exfil";
    door.var_495a14578a9bb8f3[ door.var_495a14578a9bb8f3.size ] = var_156e06f4a6f5190f;
    var_1534ef88f6128c48 = [];
    door.var_ebb19653de245a7f = undefined;
    
    while ( isdefined( door ) && door.state != "closed" )
    {
        door.nearbyplayers = getplayersinradius( door.origin, door.nearbyradius );
        
        foreach ( var_dc3ba4fab2f22e32 in door.var_495a14578a9bb8f3 )
        {
            door function_2a2e94fc0a96f73d( var_dc3ba4fab2f22e32 );
        }
        
        wait 0.25;
    }
    
    params = spawnstruct();
    params.playersleft = var_1534ef88f6128c48;
    door callback::callback( "players_left_escape", params );
    
    foreach ( player in var_1534ef88f6128c48 )
    {
        player notify( #"left_escape" );
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xfbbc433e, Offset: 0x6cbf
// Size: 0x30c
function private function_2a2e94fc0a96f73d( var_dc3ba4fab2f22e32 )
{
    door = self;
    
    if ( !isdefined( var_dc3ba4fab2f22e32.nearbyplayers ) )
    {
        var_dc3ba4fab2f22e32.nearbyplayers = [];
    }
    
    nearbyplayers = [];
    
    foreach ( player in door.nearbyplayers )
    {
        distancesq = distancesquared( door.origin, player.origin );
        
        if ( distancesq <= var_dc3ba4fab2f22e32.radiussq )
        {
            nearbyplayers[ nearbyplayers.size ] = player;
        }
    }
    
    var_cc4ab5994cb50831 = arrayremove( nearbyplayers, var_dc3ba4fab2f22e32.nearbyplayers );
    var_c7a3b6fce3d82b30 = arrayremove( var_dc3ba4fab2f22e32.nearbyplayers, nearbyplayers );
    var_dc3ba4fab2f22e32.nearbyplayers = nearbyplayers;
    
    if ( var_cc4ab5994cb50831.size )
    {
        if ( var_dc3ba4fab2f22e32.callbackjoined )
        {
            params = spawnstruct();
            params.playersjoined = var_cc4ab5994cb50831;
            door callback::callback( var_dc3ba4fab2f22e32.callbackjoined, params );
        }
        
        if ( var_dc3ba4fab2f22e32.notifyjoined )
        {
            foreach ( player in var_cc4ab5994cb50831 )
            {
                player notify( var_dc3ba4fab2f22e32.notifyjoined );
            }
        }
        
        var_dc3ba4fab2f22e32.var_ebb19653de245a7f = undefined;
    }
    
    if ( var_c7a3b6fce3d82b30.size )
    {
        if ( var_dc3ba4fab2f22e32.callbackleft )
        {
            params = spawnstruct();
            params.playersleft = var_c7a3b6fce3d82b30;
            params.isempty = !var_dc3ba4fab2f22e32.nearbyplayers.size;
            door callback::callback( var_dc3ba4fab2f22e32.callbackleft, params );
        }
        
        if ( var_dc3ba4fab2f22e32.notifyleft )
        {
            foreach ( player in var_c7a3b6fce3d82b30 )
            {
                player notify( var_dc3ba4fab2f22e32.notifyleft );
            }
        }
        
        if ( var_dc3ba4fab2f22e32.notifyempty && !var_dc3ba4fab2f22e32.nearbyplayers.size )
        {
            var_dc3ba4fab2f22e32.var_ebb19653de245a7f = gettime();
            self notify( var_dc3ba4fab2f22e32.notifyempty );
        }
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xd63b2125, Offset: 0x6fd3
// Size: 0x33
function private function_854afbb31a126f13()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self waittill( #"escape_abandoned" );
    function_be76c213a346fa5f( "closed" );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x397d8967, Offset: 0x700e
// Size: 0x9f
function private function_132940809d0c095d( players )
{
    if ( getdvarint( @"hash_42e8a3ce627d77ae", 1 ) && isarray( players ) )
    {
        foreach ( player in players )
        {
            player thread countdown_timer::close( "vtol_escape_timer" );
        }
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x195b91d, Offset: 0x70b5
// Size: 0xb8
function private function_bdd996dcad11441d( params )
{
    if ( getdvarint( @"hash_42e8a3ce627d77ae", 1 ) && isarray( params.playersjoined ) )
    {
        foreach ( player in params.playersjoined )
        {
            player thread function_51af47185a15b5ef( self, params.departing );
        }
    }
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0x74236b71, Offset: 0x7175
// Size: 0x83
function private function_c45c2817766481bb( door, targettime )
{
    level endon( #"game_ended" );
    timerhud = hud_util::createtimer( "default", 1.5 );
    timerhud hud_util::setpoint( "CENTER", "CENTER", 0, -180 );
    timerhud settimer( targettime );
    utility::waittill_any_ents( self, "left_escape", self, "death_or_disconnect", door, "death", door, "state_changed" );
    timerhud destroy();
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0xd10fd042, Offset: 0x7200
// Size: 0x107
function private function_51af47185a15b5ef( door, departing )
{
    level endon( #"game_ended" );
    escape = door.escape;
    
    if ( !escape.var_126cb2c6ab482f4e || escape.var_ae23e04b6abf15eb )
    {
        return;
    }
    
    timeleft = ( escape.var_126cb2c6ab482f4e - gettime() ) / 1000;
    
    if ( !departing )
    {
        thread countdown_timer::create( "vtol_escape_timer", "scripted_widget_vtol_escape_timer", timeleft, undefined, &"sat_ob/escape_vtol_board" );
    }
    else if ( !scripted_widgets::is_active( "vtol_escape_timer" ) )
    {
        thread countdown_timer::create( "vtol_escape_timer", "scripted_widget_vtol_escape_timer", timeleft, undefined, &"sat_ob/escape_vtol_departure" );
    }
    else
    {
        thread countdown_timer::update_message( "vtol_escape_timer", &"sat_ob/escape_vtol_departure" );
        thread countdown_timer::update_countdown( "vtol_escape_timer", timeleft );
    }
    
    utility::waittill_any_ents( self, "left_escape", self, "death_or_disconnect", door, "death" );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xfdcaa1e7, Offset: 0x730f
// Size: 0x32
function private function_134723ec2be115ea( door )
{
    self.var_18e14cf07f90ac4d = door;
    
    if ( getdvarint( @"hash_42e8a3ce627d77ae", 1 ) )
    {
        thread function_51af47185a15b5ef( door );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x890666c3, Offset: 0x7349
// Size: 0x43
function private function_6434c6e5dd766b2()
{
    self.var_18e14cf07f90ac4d = undefined;
    self notify( #"left_escape" );
    
    if ( isdefined( self.exfilfx ) )
    {
        stopfxontag( utility::getfx( "ob_portal_exfil" ), self.exfilfx, "tag_origin" );
    }
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0xde6c939, Offset: 0x7394
// Size: 0x1b4, Type: bool
function private function_f85b4111dd27fb66( requestid, userdata )
{
    door = userdata.door;
    canspawnai = door.open.spawnedai.size < userdata.var_ff1216aee67109b0;
    var_e6db7c9aaeaf4510 = door.open.var_1ab16aaea31f9a21 < userdata.var_b618ce0a703f219c;
    unlimitedwaves = !userdata.var_b9bad1456ea0f2ac;
    useswaves = isdefined( userdata.var_a939b2cca9eb639e ) && !unlimitedwaves;
    var_27b28b905a1f25e2 = unlimitedwaves || useswaves && userdata.var_a939b2cca9eb639e < userdata.var_b9bad1456ea0f2ac;
    
    if ( userdata.wavedelay )
    {
        var_faf3afa401a6a0a6 = var_27b28b905a1f25e2 && canspawnai && !userdata.var_2d8041df79adb2db;
        canspawnai &= userdata.var_2d8041df79adb2db && userdata.var_2d8041df79adb2db <= gettime();
        
        if ( var_faf3afa401a6a0a6 )
        {
            userdata.var_2d8041df79adb2db = userdata.wavedelay * 1000 + gettime();
            return false;
        }
    }
    
    if ( var_27b28b905a1f25e2 && canspawnai )
    {
        if ( useswaves )
        {
            userdata.var_a939b2cca9eb639e++;
            
            if ( userdata.var_a939b2cca9eb639e == userdata.var_b9bad1456ea0f2ac )
            {
                userdata.finalwave = 1;
            }
        }
        
        function_1a9d724a960fa19d( requestid, "spawn_special_defend", var_e6db7c9aaeaf4510 );
        return true;
    }
    
    return false;
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0x2ce56e2e, Offset: 0x7551
// Size: 0x20
function private function_75a56ce4e556fb39( requestid, userdata )
{
    return userdata.shouldshutdown;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xd7e81ae6, Offset: 0x757a
// Size: 0x14
function private function_d843ebe201829d9a( params )
{
    on_ai_killed( undefined );
}

// Namespace ob_exfil_door
// Params 4, eflags: 0x4
// Checksum 0x102d799a, Offset: 0x7596
// Size: 0x39a
function private function_4b82e3d82cd7157a( requestid, userdata, agent, data )
{
    level endon( #"game_ended" );
    
    if ( !isalive( agent ) || !isdefined( userdata.door ) )
    {
        return;
    }
    
    door = userdata.door;
    open = door.open;
    agent.door = door;
    open.spawnedai[ open.spawnedai.size ] = agent;
    agent callback::add( "on_turned", &function_d843ebe201829d9a );
    
    if ( getdvarint( @"hash_677bc7514f11d37c", 1 ) )
    {
        agent zombie_emergence_spawning::function_80623a2279a4d888();
        agent val::set( "defend_spawn", "dont_evolve" );
        agent utility::ent_flag_set( "ghoul_evolve_disabled" );
    }
    
    if ( data.spawnsetname == #"hard_special" || data.spawnsetname == #"aether_special" )
    {
        agent.isspecial = 1;
        open.var_1ab16aaea31f9a21++;
    }
    
    if ( agent.basearchetype == "zombie_base" )
    {
        agent utility::ent_flag_set( "defend" );
        agent zombie_utils::function_a8ce00e0448cb6f0( door function_65fc7fc3a8b8953a(), "defend", 1000 );
    }
    
    agent function_fa32376aaa88a7a2( door.origin, 1250 );
    
    if ( userdata.hassoul )
    {
        agent val::set( "defend", "toggle_eye_glow", 1 );
        agent thread function_7c1d8b19f6a38e08();
        agent.var_8b7eef0172518298 = 1;
        open.soulsneeded++;
    }
    
    if ( userdata.var_2e7dc80e31a8516 && agent.var_8b7eef0172518298 )
    {
        door.var_336008feba6b5556 = agent;
        
        if ( level.exfildoors.var_41ae6024a36f5a38 )
        {
            agent.objid = agent objidpoolmanager::createobjective( level.exfildoors.minibossicon, undefined, 0, 1, 0, "icon_small" );
            objidpoolmanager::update_objective_state( agent.objid, "invisible" );
            objidpoolmanager::objective_showdistance( agent.objid, 0 );
            objidpoolmanager::update_objective_setzoffset( agent.objid, 100 );
            objidpoolmanager::function_de3fb937d4f45f38( agent.objid, 1000, 2000 );
            function_24edb8a97f6832f0( agent.objid, 1 );
            function_d1fb910ef06fd658( agent.objid, 1000, 2000 );
            objective_disableping( agent.objid, 1 );
        }
        
        while ( !isdefined( agent.difficulty ) )
        {
            waitframe();
        }
        
        agent.healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", %"hash_512075e957ca0e3b" );
        
        if ( isalive( agent ) )
        {
            agent waittill( #"death" );
        }
        
        door.var_336008feba6b5556 = undefined;
        
        if ( agent.objid )
        {
            objidpoolmanager::returnobjectiveid( agent.objid );
            agent.objid = undefined;
        }
        
        wait 1.5;
        door notify( #"stop_spawn" );
        door utility::ent_flag_set( "boss_killed" );
        door function_ce5a413e9be3c312();
        door.bosskiller = agent.lastattacker;
    }
}

// Namespace ob_exfil_door
// Params 3, eflags: 0x4
// Checksum 0x6bcd8f4f, Offset: 0x7938
// Size: 0x126
function private function_a21e54a316e9e43a( requestid, userdata, var_b06d38cf76935416 )
{
    userdata.var_2d8041df79adb2db = undefined;
    
    if ( userdata.finalwave )
    {
        door = userdata.door;
        open = door.open;
        userdata.shouldshutdown = 1;
        
        if ( userdata.hassoul )
        {
            if ( !isdefined( open.soulsneeded ) )
            {
                open.soulsneeded = 0;
            }
        }
        
        open.var_1b0a4d89cb879b7c = arrayremove( open.var_1b0a4d89cb879b7c, requestid );
        
        if ( door.activity_instance )
        {
            door.activity_instance.targetkillcount = open.soulsneeded;
            activity_definition_utils::updateprogress( open.soulscollected, door.activity_instance, door.activity_instance.targetkillcount );
        }
        
        door utility::ent_flag_set( "wave_spawn_finished" );
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xd039c2fb, Offset: 0x7a66
// Size: 0x122
function private spawned_ai_killed( params )
{
    agent = self;
    door = agent.door;
    open = door.open;
    open.spawnedai = arrayremove( open.spawnedai, agent );
    
    if ( agent.isspecial )
    {
        open.var_1ab16aaea31f9a21--;
    }
    
    if ( agent.soulfx )
    {
        agent.soulfx unlink();
        agent.soulfx delete();
        agent.soulfx = undefined;
    }
    
    if ( agent.objid )
    {
        objidpoolmanager::returnobjectiveid( agent.objid );
        agent.objid = undefined;
    }
    
    if ( agent.var_8b7eef0172518298 )
    {
        fxtag = "j_head";
        
        if ( door function_26364526ada33046() )
        {
            door function_97374e0c83cfcbbc();
            return;
        }
        
        door thread function_19b719ecef2d4269( agent gettagorigin( fxtag ) );
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x28d7e0dc, Offset: 0x7b90
// Size: 0x5d
function private on_ai_killed( params )
{
    agent = self;
    
    if ( !agent.door || !arraycontains( agent.door.open.spawnedai, agent ) )
    {
        return;
    }
    
    agent spawned_ai_killed( params );
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0xcc3e5538, Offset: 0x7bf5
// Size: 0x2a
function private function_2fb16ead341c4844( requestid, door )
{
    self.var_a13bed1ac47e1b2c = 1;
    self.var_8b7eef0172518298 = undefined;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x17fa6e5f, Offset: 0x7c27
// Size: 0x70
function private function_97374e0c83cfcbbc()
{
    door = self;
    open = door.open;
    
    if ( open && isdefined( open.soulscollected ) )
    {
        open.soulscollected++;
        
        if ( door.activity_instance )
        {
            activity_definition_utils::updateprogress( open.soulscollected, door.activity_instance );
        }
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x8f2bdeb, Offset: 0x7c9f
// Size: 0x43
function private function_65fc7fc3a8b8953a()
{
    shouldsprint = utility::percent_chance( level.exfildoors.sprintchance[ self.difficulty ] );
    return shouldsprint ? "sprint" : "run";
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x92616fe7, Offset: 0x7ceb
// Size: 0x48
function private function_95a3c39601a6b2ac()
{
    if ( !isarray( self.nearbyplayers ) || self.nearbyplayers.size < 2 )
    {
        return "squad_solo";
    }
    else if ( self.nearbyplayers.size < 5 )
    {
        return "squad_small";
    }
    
    return "squad_large";
}

// Namespace ob_exfil_door
// Params 3, eflags: 0x4
// Checksum 0xc7ddca59, Offset: 0x7d3c
// Size: 0x1c1
function private function_2349cc03d3fe0138( endstage, var_f5598f23e8e55125, var_4c3803c59c1cb3d0 )
{
    door = self;
    open = door.open;
    
    if ( !isdefined( open.soulscollected ) )
    {
        open.soulscollected = 0;
    }
    
    if ( !isdefined( var_f5598f23e8e55125 ) )
    {
        var_f5598f23e8e55125 = 1;
    }
    
    if ( !isdefined( var_4c3803c59c1cb3d0 ) )
    {
        var_4c3803c59c1cb3d0 = 1;
    }
    
    startstage = self.var_c2581f8e7f0a1df2;
    targetstage = startstage;
    
    while ( !open.soulsneeded )
    {
        wait 0.25;
    }
    
    while ( self.var_c2581f8e7f0a1df2 < endstage )
    {
        if ( !open.spawnedai.size && open.soulscollected != open.soulsneeded )
        {
            wait 3;
            open.soulscollected = open.soulsneeded;
        }
        
        targetstage = maxint( targetstage, int( math::lerp( startstage, endstage, open.soulscollected / open.soulsneeded ) ) );
        
        if ( targetstage > self.var_c2581f8e7f0a1df2 )
        {
            self.var_c2581f8e7f0a1df2++;
            
            if ( !door function_26364526ada33046() )
            {
                var_5bf4181502fba917 = self.var_c2581f8e7f0a1df2 == endstage;
                showtransition = !var_5bf4181502fba917 && var_f5598f23e8e55125 || var_5bf4181502fba917 && var_4c3803c59c1cb3d0;
                transitiontime = showtransition ? 3.5 : 1;
                function_9314d6b5929c8613( self.var_c2581f8e7f0a1df2 + 1, transitiontime );
            }
        }
        
        wait 0.25;
    }
    
    self notify( #"all_souls_collected" );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x2cce5d58, Offset: 0x7f05
// Size: 0xe9
function private function_c058362e7fc2f04a()
{
    maxrangesq = self.var_a716abfaa090cb99 * self.var_a716abfaa090cb99;
    
    while ( true )
    {
        foreach ( agent in self.open.spawnedai )
        {
            if ( isalive( agent ) && !agent.var_e740e6be4a35ebda && distancesquared( agent.origin, self.origin ) > maxrangesq )
            {
                agent thread function_b41aaf914cbeb183( self );
            }
        }
        
        wait 0.25;
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x46766769, Offset: 0x7ff6
// Size: 0x1bd
function private function_b832cc7fe3efca00( finishnotify )
{
    if ( isdefined( finishnotify ) )
    {
        self endon( finishnotify );
    }
    
    var_621c3ff321d4b7ea = 30;
    var_b0925a02ed763499 = 3;
    utility::ent_flag_wait( "wave_spawn_finished" );
    
    while ( self.open.spawnedai.size > var_b0925a02ed763499 )
    {
        wait 1;
    }
    
    wait var_621c3ff321d4b7ea;
    
    foreach ( ai in self.open.spawnedai )
    {
        if ( isalive( ai ) )
        {
            ai.objid = ai objidpoolmanager::createobjective( level.exfildoors.var_edb309392c45f0a3, undefined, 0, 1, 0, "icon_small" );
            objidpoolmanager::update_objective_state( ai.objid, "active" );
            objidpoolmanager::function_eb808b97701a4793( ai.objid );
            
            foreach ( player in self.nearbyplayers )
            {
                objidpoolmanager::objective_playermask_addshowplayer( ai.objid, player );
            }
        }
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x80739780, Offset: 0x81bb
// Size: 0x10d
function private function_b41aaf914cbeb183( door )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    door endon( #"death" );
    minrangesq = 810000;
    startspeed = self.var_361a087ab08adc1c;
    var_e0e1735fb24f7e85 = 5;
    var_30eeee0b7bfb1718 = gettime() + var_e0e1735fb24f7e85 * 1000;
    doorstruct = spawnstruct();
    doorstruct.origin = door.origin;
    thread zombie_attractor_manager::function_7eb1aaa8bc7cc15( doorstruct );
    self.var_e740e6be4a35ebda = 1;
    self.var_361a087ab08adc1c = "sprint";
    
    while ( var_30eeee0b7bfb1718 > gettime() && distancesquared( self.origin, door.origin ) > minrangesq )
    {
        wait 0.1;
    }
    
    zombie_attractor_manager::function_dcfb4c31f1d97cd2( doorstruct );
    self.var_e740e6be4a35ebda = 0;
    self.var_361a087ab08adc1c = startspeed;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x3154f21e, Offset: 0x82d0
// Size: 0x2c
function private function_c29ab91f732e0767()
{
    assert( isdefined( self ) );
    doorinteract = self;
    
    if ( !doorinteract isscriptableinstance() )
    {
        doorinteract = self getlinkedscriptableinstance();
    }
    
    return doorinteract;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x7ab54f63, Offset: 0x8305
// Size: 0x67
function private function_848887cae58d9202()
{
    self.var_2b04f42f93823c0c[ self.var_2b04f42f93823c0c.size ] = &function_680a0574e16306a9;
    function_7b5528a9bc0462ea( 1 );
    function_1b6d4a8e8323bf83();
    doorinteract = function_c29ab91f732e0767();
    doorinteract.doorent = self;
    interaction::register_scriptable_interact( doorinteract, &function_b6f6211a0eb4a07f );
    doorinteract waittill( #"hash_fda985d5cd0080a7" );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x8d0a65bd, Offset: 0x8374
// Size: 0x82
function private function_1b6d4a8e8323bf83()
{
    self setscriptablepartstate( #"interact", #"usable" );
    
    if ( !function_26364526ada33046() )
    {
        objidpoolmanager::update_objective_setneutrallabel( self.objid, self.var_4b1af9788adee531 ?? level.exfildoors.var_4b1af9788adee531 );
        objidpoolmanager::update_objective_description( self.objid, self.var_4b1af9788adee531 ?? level.exfildoors.var_4b1af9788adee531 );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x78960acf, Offset: 0x83fe
// Size: 0x44
function private function_680a0574e16306a9()
{
    doorinteract = function_c29ab91f732e0767();
    self setscriptablepartstate( #"interact", #"unusable" );
    level.interacts = arrayremove( level.interacts, doorinteract );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xcb49ff5a, Offset: 0x844a
// Size: 0x44
function private function_6d244195f4353fab( params )
{
    if ( utility::issharedfuncdefined( #"ob_exfil_door", #"hash_b4a1e6cb7d4ab15c" ) )
    {
        return utility::callsharedfunc( #"ob_exfil_door", #"hash_b4a1e6cb7d4ab15c", params );
    }
    
    return 1;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x94938f9a, Offset: 0x8497
// Size: 0xd
function private function_d71a0fde2f56a8bd()
{
    function_7b5528a9bc0462ea( 0 );
    wait 5;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x6bea832b, Offset: 0x84ac
// Size: 0x1a4
function private function_ac55c04a8966c870()
{
    function_7b5528a9bc0462ea( 2 );
    var_1527221f0f92cc16 = getdvarint( @"hash_ba0e9ca95287d797", 0 );
    var_4f73446409e48512 = var_1527221f0f92cc16 - self.var_c2581f8e7f0a1df2;
    
    if ( var_4f73446409e48512 <= 0 || var_1527221f0f92cc16 >= 6 )
    {
        return;
    }
    
    if ( !function_26364526ada33046() )
    {
        objidpoolmanager::update_objective_setneutrallabel( self.objid, self.var_81b8ca816c480c03 ?? level.exfildoors.var_81b8ca816c480c03 );
        objidpoolmanager::update_objective_description( self.objid, self.var_81b8ca816c480c03 ?? level.exfildoors.var_81b8ca816c480c03 );
    }
    
    var_1e7316db44fdff52 = getdvarint( @"hash_2ac59c5282bd4c23", 1000 );
    var_67e73b4b91497471 = getdvarint( @"hash_241600b50e603d1a", 300 );
    stepsize = ( var_1e7316db44fdff52 - var_67e73b4b91497471 ) / var_4f73446409e48512;
    nextstep = var_1e7316db44fdff52;
    
    while ( self.var_c2581f8e7f0a1df2 < var_1527221f0f92cc16 )
    {
        function_6d244195f4353fab( nextstep );
        inrange = getplayersinradius( self.origin, nextstep );
        
        if ( inrange.size )
        {
            self.var_c2581f8e7f0a1df2++;
            
            if ( !function_26364526ada33046() )
            {
                nextstep = var_1e7316db44fdff52 - stepsize * self.var_c2581f8e7f0a1df2;
                transitiontime = self.var_c2581f8e7f0a1df2 == var_1527221f0f92cc16 ? 3.5 : 1;
                function_9314d6b5929c8613( self.var_c2581f8e7f0a1df2 + 1, transitiontime );
            }
            
            continue;
        }
        
        wait 0.5;
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x1fadef06, Offset: 0x8658
// Size: 0x3c6
function private function_a22a4c3083518d5e()
{
    door = self;
    active = door.active;
    door function_7b5528a9bc0462ea( 3 );
    self.var_2b04f42f93823c0c[ self.var_2b04f42f93823c0c.size ] = &function_ad7806127cf58f89;
    
    if ( !door function_26364526ada33046() )
    {
        objidpoolmanager::update_objective_setneutrallabel( self.objid, self.var_9e82b5beb9861f29 ?? level.exfildoors.var_9e82b5beb9861f29 );
        objidpoolmanager::update_objective_description( self.objid, self.var_9e82b5beb9861f29 ?? level.exfildoors.var_9e82b5beb9861f29 );
    }
    
    active.captured = 0;
    active.capturetime = 3;
    active.capturerange = 512;
    door function_c2ce1e3a80374257();
    
    if ( level.exfildoors.var_7e2c9c0dede7b426 )
    {
        active.chevrons = function_a017d1ec37595fa( "sat_wc_drone_skyfall_chevron", active.trigger.origin, active.trigger.radius, 200, 0 );
    }
    
    if ( !active.watchingcapture )
    {
        active.watchingcapture = 1;
        seticonnames();
        
        if ( isdefined( active.trigger ) )
        {
            zone = gameobjects::createuseobject( "neutral", active.trigger, [], ( 0, 0, 60 ), undefined, 0, 1 );
        }
        
        zone gameobjects::setobjectivestatusicons( level.iconneutral );
        zone gameobjects::cancontestclaim( 0 );
        zone gameobjects::pinobjiconontriggertouch();
        zone gameobjects::setusetime( active.capturetime );
        objidpoolmanager::update_objective_state( zone.objidnum, "empty" );
        objidpoolmanager::update_objective_onentity( zone.objidnum, self );
        objidpoolmanager::update_objective_setzoffset( zone.objidnum, 60 );
        objidpoolmanager::update_objective_setneutrallabel( zone.objidnum, level.exfildoors.var_9e82b5beb9861f29 );
        objidpoolmanager::function_9d4895ed38151e46( zone.objidnum, 1 );
        objidpoolmanager::function_de3fb937d4f45f38( zone.objidnum, 1000, 2000 );
        function_24edb8a97f6832f0( zone.objidnum, 1 );
        function_d1fb910ef06fd658( zone.objidnum, 1000, 2000 );
        zone gameobjects::setvisibleteam( "none" );
        zone gameobjects::allowuse( "any" );
        zone.decaygraceperiod = 0;
        zone.decayrate = 1000;
        
        if ( isdefined( active.trigger ) )
        {
            function_ca1cc2938b2b4271( zone.objidnum, active.trigger );
        }
        
        zone.id = "hardpoint";
        zone.checkuseconditioninthink = 1;
        zone.onbeginuse = &function_4a5e20d3eebc0688;
        zone.onenduse = &function_d1707a99387563c4;
        zone.onuseupdate = &function_56c850be83d14246;
        zone.onunoccupied = &function_950a632745ffacaf;
        zone.doorent = door;
        active.zone = zone;
    }
    
    if ( isdefined( active.zone ) )
    {
        active.zone.forcedecaying = 0;
        objidpoolmanager::objective_show_progress( active.zone.objidnum, 0 );
    }
    
    self waittill( #"exfil_captured" );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xf7807561, Offset: 0x8a26
// Size: 0x88
function private function_ad7806127cf58f89()
{
    if ( self.active.zone )
    {
        self.active.zone gameobjects::deleteuseobject();
        self.active.zone = undefined;
    }
    
    if ( self.active.chevrons )
    {
        deletechevrons( self.active.chevrons );
        self.active.chevrons = undefined;
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xf10f261f, Offset: 0x8ab6
// Size: 0x16
function private function_4a5e20d3eebc0688( player )
{
    player thread function_b4e317a65157efd4( self );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x3bb36f3d, Offset: 0x8ad4
// Size: 0x19
function private function_d1707a99387563c4( player )
{
    player notify( #"temp_player_left" );
}

// Namespace ob_exfil_door
// Params 4, eflags: 0x4
// Checksum 0x32ca4612, Offset: 0x8af5
// Size: 0x115
function private function_56c850be83d14246( team, progress, change, capplayer )
{
    door = self.doorent;
    
    if ( door && door.active.captured )
    {
        return;
    }
    
    door.active.progress = progress;
    
    if ( progress >= 0 && progress < 1 )
    {
        objidpoolmanager::objective_show_progress( self.objidnum, 1 );
        return;
    }
    
    if ( progress >= 1 )
    {
        capplayer notify( #"left_escape" );
        door.active.captured = 1;
        objidpoolmanager::objective_show_progress( self.objidnum, 0 );
        self.forcedecaying = 0;
        door.var_c2581f8e7f0a1df2++;
        door function_9314d6b5929c8613( door.var_c2581f8e7f0a1df2 + 1, 3.5 );
        door notify( #"exfil_captured" );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x84fd131c, Offset: 0x8c12
// Size: 0x1e
function private function_950a632745ffacaf()
{
    objidpoolmanager::objective_set_progress( self.objidnum, 0 );
    self.forcedecaying = 1;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x464a62aa, Offset: 0x8c38
// Size: 0x90
function private function_b4e317a65157efd4( door )
{
    level endon( #"game_ended" );
    progressbarhud = hud_util::createbar( ( 1, 0.5, 0.5 ), 100, 25 );
    progressbarhud hud_util::setpoint( "CENTER", "CENTER", 0, -150 );
    progressbarhud hud_util::updatebar( door.active.progress );
    utility::waittill_any_ents( self, "temp_player_left", self, "death_or_disconnect", door, "death" );
    progressbarhud destroy();
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x3893c554, Offset: 0x8cd0
// Size: 0x3a9
function private function_61fefc5bb2b0b6a3()
{
    door = self;
    open = door.open;
    
    if ( !isdefined( open.var_1b0a4d89cb879b7c ) )
    {
        open.var_1b0a4d89cb879b7c = [];
    }
    
    if ( !isdefined( open.spawnedai ) )
    {
        open.spawnedai = [];
    }
    
    if ( !isdefined( open.var_1ab16aaea31f9a21 ) )
    {
        open.var_1ab16aaea31f9a21 = 0;
    }
    
    door.var_2b04f42f93823c0c[ door.var_2b04f42f93823c0c.size ] = &function_8f3ed61ec57a8d92;
    door.var_9c1964c340deb16[ door.var_9c1964c340deb16.size ] = &function_caf85330de3359e6;
    door.var_99be1c0cdb453bf6[ door.var_99be1c0cdb453bf6.size ] = &function_caf85330de3359e6;
    door.var_99be1c0cdb453bf6[ door.var_99be1c0cdb453bf6.size ] = &function_ce5a413e9be3c312;
    remainingtime = function_cc2d2ca482a35362();
    var_2b6cc868708d4ca1 = remainingtime - door.escape.timetowait - door.escape.var_735c179f1fa90996;
    open.var_2ac3ca6dacfeb97a = getdvarint( @"hash_a82d80d794d2fc8", level.exfildoors.var_fa0d12e1f93b8a3[ door.difficulty ] );
    open.var_2ac3ca6dacfeb97a = max( min( open.var_2ac3ca6dacfeb97a, var_2b6cc868708d4ca1 ), 0 );
    timetowait = door.escape.timetowait ?? 0;
    timetoland = door.escape.timetoland ?? 0;
    var_1faa2518adb82728 = open.var_2ac3ca6dacfeb97a + timetowait + timetoland;
    
    if ( door.activity_instance )
    {
        activity_instance_common::function_46135a69bddfec2c( door.activity_instance );
        activity_definition_utils::updatetimer( var_1faa2518adb82728, door.activity_instance );
    }
    
    if ( !door function_26364526ada33046() )
    {
        objidpoolmanager::update_objective_setneutrallabel( door.objid, level.exfildoors.var_575b008daf162253 );
        objidpoolmanager::update_objective_description( door.objid, level.exfildoors.var_575b008daf162253 );
    }
    
    if ( open.showchevrons )
    {
        open.chevrons = function_a017d1ec37595fa( "sat_wc_drone_skyfall_chevron", door.origin, door.abandonradius, 200, 0 );
    }
    
    door function_fa46062812b7122e();
    door childthread function_c058362e7fc2f04a();
    wavestruct = spawnstruct();
    wavestruct.door = door;
    wavestruct.var_2d8041df79adb2db = gettime();
    wavestruct.var_ff1216aee67109b0 = 15;
    wavestruct.var_b618ce0a703f219c = 3;
    door function_8061ff1e2045ae0e( wavestruct );
    
    if ( open.var_516d2a9a33959f9f )
    {
        var_16075a287c2ca557 = spawnstruct();
        var_16075a287c2ca557.door = door;
        var_16075a287c2ca557.finalwave = 1;
        var_16075a287c2ca557.radius = 300;
        remainingtime = function_cc2d2ca482a35362();
        timetowait = remainingtime - 480;
        wait timetowait;
        door function_c2b63c3b42d8a79( var_16075a287c2ca557 );
        remainingtime = function_cc2d2ca482a35362();
        timetowait = remainingtime - 420;
        wait timetowait;
        door function_db71d891711643fa();
        return;
    }
    
    wait open.var_2ac3ca6dacfeb97a;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x4a1ac321, Offset: 0x9081
// Size: 0x10b
function private function_fa46062812b7122e()
{
    door = self;
    open = door.open;
    
    if ( getdvarint( @"hash_d8ae29df3dc20265", 0 ) == 0 )
    {
        return;
    }
    
    if ( open.var_91250b5093a4be6 )
    {
        foreach ( player in level.players )
        {
            player thread function_c45c2817766481bb( door, open.var_2ac3ca6dacfeb97a );
        }
        
        return;
    }
    
    open.var_d61d6866f66dc8bf = gettime();
    door callback::add( "players_joined_escape", &function_abb2ee94e8f158b5 );
    function_abb2ee94e8f158b5( { #playersjoined:door.nearbyplayers } );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x72901ff4, Offset: 0x9194
// Size: 0xe2
function private function_abb2ee94e8f158b5( params )
{
    if ( isarray( params.playersjoined ) )
    {
        timepassed = ( gettime() - self.open.var_d61d6866f66dc8bf ) / 1000;
        var_849d50d65f464227 = self.open.var_2ac3ca6dacfeb97a - timepassed;
        
        foreach ( player in params.playersjoined )
        {
            player thread function_c45c2817766481bb( self, var_849d50d65f464227 );
        }
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x3cd4d81b, Offset: 0x927e
// Size: 0x6d
function private function_8f3ed61ec57a8d92()
{
    if ( self.open.chevrons )
    {
        deletechevrons( self.open.chevrons );
        self.open.chevrons = undefined;
    }
    
    if ( !self.open.var_91250b5093a4be6 )
    {
        callback::remove( "players_joined_escape", &function_abb2ee94e8f158b5 );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x7b6fd546, Offset: 0x92f3
// Size: 0xb5
function private function_caf85330de3359e6()
{
    if ( isarray( self.open.var_1b0a4d89cb879b7c ) )
    {
        foreach ( requestid in self.open.var_1b0a4d89cb879b7c )
        {
            ai_spawn_director::cancel_spawn_request( requestid, 0, 1 );
        }
        
        self.open.var_1b0a4d89cb879b7c = undefined;
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x10f1c242, Offset: 0x93b0
// Size: 0x311
function private function_bbe86e4f38b6108c()
{
    door = self;
    open = door.open;
    open.captured = 0;
    open.var_c0602359c8cb06d1 = getdvarint( @"hash_e23cfef13d5d3964", 15 );
    door.var_2b04f42f93823c0c[ door.var_2b04f42f93823c0c.size ] = &function_14b4624e3bf55d79;
    door function_e776c6ea1a40e349();
    door function_52f557d15f30d392();
    
    if ( level.exfildoors.var_b51931f4d46574a3 )
    {
        open.chevrons = function_a017d1ec37595fa( "sat_wc_drone_skyfall_chevron", open.trigger.origin, open.trigger.radius, 200, 0 );
    }
    
    if ( !door.watchingcapture )
    {
        door.watchingcapture = 1;
        seticonnames();
        
        if ( isdefined( door.trigger ) )
        {
            zone = gameobjects::createuseobject( "neutral", door.trigger, [], ( 0, 0, 60 ), undefined, 0, 1 );
        }
        
        zone gameobjects::setobjectivestatusicons( level.iconneutral );
        zone gameobjects::cancontestclaim( 0 );
        zone gameobjects::pinobjiconontriggertouch();
        zone gameobjects::setusetime( level.exfildoors.capturetime );
        objidpoolmanager::update_objective_onentity( zone.objidnum, door );
        objidpoolmanager::update_objective_setzoffset( zone.objidnum, 60 );
        objidpoolmanager::update_objective_setneutrallabel( zone.objidnum, level.exfildoors.var_643af3b0c17c7ff4 );
        zone gameobjects::setvisibleteam( "any" );
        zone gameobjects::allowuse( "any" );
        zone.decaygraceperiod = level.exfildoors.capturegraceperiod;
        zone.decayrate = 50;
        
        if ( isdefined( door.trigger ) )
        {
            function_ca1cc2938b2b4271( zone.objidnum, door.trigger );
        }
        
        zone.id = "hardpoint";
        zone.checkuseconditioninthink = 1;
        zone.onbeginuse = &zoneonusebegin;
        zone.onuseupdate = &function_9d203a9a89eb4c9d;
        zone.onunoccupied = &zoneonunoccupied;
        zone.doorent = door;
        open.zone = zone;
    }
    
    if ( isdefined( open.zone ) )
    {
        open.zone.forcedecaying = 0;
        objidpoolmanager::objective_show_progress( open.zone.objidnum, 0 );
    }
    
    door function_442305994dfe883d( 300, 1000, door.var_c0602359c8cb06d1, "sat_spawner_zombie_base_ob", "exfil_captured" );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x145b684b, Offset: 0x96c9
// Size: 0xb0
function private function_e776c6ea1a40e349()
{
    door = self;
    
    if ( !door function_26364526ada33046() )
    {
        objidpoolmanager::update_objective_setneutrallabel( door.objid, level.exfildoors.var_643af3b0c17c7ff4 );
        objidpoolmanager::update_objective_description( door.objid, level.exfildoors.var_643af3b0c17c7ff4 );
        door setscriptablepartstate( #"portal", #"portal_stage_01" );
        door setscriptablepartstate( #"beam", #"usable" );
        door setscriptablepartstate( #"pulse", #"off" );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xc66d3922, Offset: 0x9781
// Size: 0x88
function private function_14b4624e3bf55d79()
{
    if ( self.open.zone )
    {
        self.open.zone gameobjects::deleteuseobject();
        self.open.zone = undefined;
    }
    
    if ( self.open.chevrons )
    {
        deletechevrons( self.open.chevrons );
        self.open.chevrons = undefined;
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xf6cdf829, Offset: 0x9811
// Size: 0x7c
function private zoneonusebegin( player )
{
    door = self.doorent;
    
    if ( door.state == "escape" || door.open.captured )
    {
        return;
    }
    
    objidpoolmanager::objective_show_progress( self.objidnum, 1 );
    door function_d1964064b2de9c30();
    thread gameobjects::useobjectdecay( player.team );
}

// Namespace ob_exfil_door
// Params 4, eflags: 0x4
// Checksum 0x9c901d16, Offset: 0x9895
// Size: 0xdf
function private function_9d203a9a89eb4c9d( team, progress, change, capplayer )
{
    door = self.doorent;
    
    if ( door.state == "escape" || door.open.captured )
    {
        return;
    }
    
    objidpoolmanager::objective_show_progress( self.objidnum, 1 );
    
    if ( progress >= 1 )
    {
        door.open.captured = 1;
        objidpoolmanager::objective_show_progress( self.objidnum, 0 );
        self.forcedecaying = 0;
        door.var_c2581f8e7f0a1df2 = 5;
        door function_9314d6b5929c8613( 6, 4 );
        door notify( #"exfil_captured" );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x62fb5d76, Offset: 0x997c
// Size: 0x69
function private zoneonunoccupied()
{
    door = self.doorent;
    
    if ( door.state == "escape" || door.open.captured )
    {
        return;
    }
    
    door setscriptablepartstate( #"pulse", #"off" );
    self.forcedecaying = 1;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x6a9dd829, Offset: 0x99ed
// Size: 0x109
function private function_e4767367ae5a55d3()
{
    if ( function_26364526ada33046() )
    {
        return;
    }
    
    var_2e317f5fc0ad17c7 = level.exfildoors.activationdelay / 6;
    
    if ( var_2e317f5fc0ad17c7 - level.exfildoors.var_9bb96be513470a1 <= 0 )
    {
        var_5f96ba8023b274e5 = 1;
        level.exfildoors.var_9bb96be513470a1 = var_2e317f5fc0ad17c7;
    }
    
    for ( i = self.var_c2581f8e7f0a1df2 ?? 1; i < 6 ; i++ )
    {
        if ( !var_5f96ba8023b274e5 )
        {
            wait var_2e317f5fc0ad17c7 - level.exfildoors.var_9bb96be513470a1;
            self setscriptablepartstate( #"portal_pending", getxhash( "portal_stage_0" + i + 1 ) );
        }
        
        wait level.exfildoors.var_9bb96be513470a1;
        self setscriptablepartstate( #"portal", getxhash( "portal_stage_0" + i + 1 ) );
        self.var_c2581f8e7f0a1df2 = i;
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x500e6c2f, Offset: 0x9afe
// Size: 0x11e
function private function_19756800070aaf6a( wavesinfo )
{
    door = self;
    open = door.open;
    open.soulsneeded = 0;
    open.soulscollected = 0;
    
    if ( !isdefined( open.var_1b0a4d89cb879b7c ) )
    {
        open.var_1b0a4d89cb879b7c = [];
    }
    
    if ( !isdefined( open.spawnedai ) )
    {
        open.spawnedai = [];
    }
    
    if ( !isdefined( open.var_1ab16aaea31f9a21 ) )
    {
        open.var_1ab16aaea31f9a21 = 0;
    }
    
    door.var_2b04f42f93823c0c[ door.var_2b04f42f93823c0c.size ] = &function_7471a0ad91ba6dc5;
    wait 5;
    
    if ( level.exfildoors.var_b51931f4d46574a3 )
    {
        open.chevrons = function_a017d1ec37595fa( "sat_wc_drone_skyfall_chevron", door.origin, door.var_b4b3f1f4bbab5553, 200, 0 );
    }
    
    door childthread function_c058362e7fc2f04a();
    door function_e47d672ee8fb1054();
    wait 2;
    door function_b8fdb1f1f698ae50();
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x7d464c7d, Offset: 0x9c24
// Size: 0x136
function private function_7471a0ad91ba6dc5()
{
    door = self;
    open = door.open;
    
    if ( open.chevrons )
    {
        deletechevrons( open.chevrons );
        open.chevrons = undefined;
    }
    
    if ( isarray( open.var_1b0a4d89cb879b7c ) )
    {
        foreach ( requestid in open.var_1b0a4d89cb879b7c )
        {
            ai_spawn_director::cancel_spawn_request( requestid, 0, 1 );
        }
        
        open.var_1b0a4d89cb879b7c = undefined;
    }
    
    door notify( #"defend_complete" );
    door notify( #"stop_spawn" );
    door function_ce5a413e9be3c312();
    
    if ( door.activity_instance )
    {
        door.activity_instance function_2e9b2ee3d0fa6ab3();
        door.activity_instance = undefined;
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x47b708e, Offset: 0x9d62
// Size: 0x28
function private function_2e9b2ee3d0fa6ab3()
{
    if ( self.currentactivitystate == "Active" )
    {
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    activity_instance_common::function_9aeeabe50fc9cc3e( self );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x1f3325c6, Offset: 0x9d92
// Size: 0x147
function private function_54c430d3d4a958b3()
{
    door = self;
    escape = door.escape;
    door.var_2b04f42f93823c0c[ door.var_2b04f42f93823c0c.size ] = &function_db16f39443c44da6;
    
    if ( door function_26364526ada33046() )
    {
        door setscriptablepartstate( #"interact", #"usable_escape" );
    }
    else
    {
        objidpoolmanager::update_objective_setneutrallabel( door.objid, level.exfildoors.var_a3539af042faf0cf );
        objidpoolmanager::update_objective_description( door.objid, level.exfildoors.var_a3539af042faf0cf );
        door setscriptablepartstate( #"beam", #"usable" );
        door setscriptablepartstate( #"interact", #"usable" );
    }
    
    doorinteract = door function_c29ab91f732e0767();
    doorinteract.doorent = door;
    interaction::register_scriptable_interact( doorinteract, &function_d5e6eecf06944c30 );
    
    if ( escape.var_e2b81afb1f04c568 && escape.var_126cb2c6ab482f4e )
    {
        door childthread function_d5dbafdf7f9a1c42();
    }
    
    door waittill( #"door_used_up" );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x57c0fd41, Offset: 0x9ee1
// Size: 0x66
function private function_db16f39443c44da6()
{
    doorinteract = function_c29ab91f732e0767();
    
    if ( !function_26364526ada33046() )
    {
        self setscriptablepartstate( #"beam", #"unusable" );
    }
    
    self setscriptablepartstate( #"interact", #"unusable" );
    level.interacts = arrayremove( level.interacts, doorinteract );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xed3343ce, Offset: 0x9f4f
// Size: 0xe7
function private function_2e71ebd68abe0c31()
{
    door = self;
    escape = door.escape;
    waittime = max( ( escape.var_126cb2c6ab482f4e - gettime() ) / 1000 - escape.var_2687aca5dc3c5f0e, 0 );
    
    if ( escape.var_4eea5dd195b08709 )
    {
        door childthread function_1b9b2f094d8e1348();
    }
    
    door utility::waittill_notify_or_timeout( "vehicle_squad_boarded", waittime );
    door function_3e2eda1dc6c29681();
    
    if ( door.activity_instance )
    {
        door.activity_instance function_2e9b2ee3d0fa6ab3();
        door.activity_instance = undefined;
    }
    
    door setscriptablepartstate( #"ob_exfil_icon", #"close" );
    door.escapevehicle function_a6f1528fa9ee3b98( "karm_wcshutdown_vtol_success" );
    door function_cbfcc1fd7d9ea20a();
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x74cbf894, Offset: 0xa03e
// Size: 0x230
function private function_1b9b2f094d8e1348()
{
    door = self;
    escape = door.escape;
    vtol = door.escapevehicle;
    vtol endon( #"hash_915a90e39b3f6b5a" );
    waitframe();
    var_2870ae57fdf631db = [];
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            var_a0768b85b7d3965d = vtol function_2f2b9ae9cc19460a( player );
            
            if ( var_a0768b85b7d3965d )
            {
                if ( !arraycontains( var_2870ae57fdf631db, player ) )
                {
                    var_2870ae57fdf631db[ var_2870ae57fdf631db.size ] = player;
                }
                
                continue;
            }
            
            if ( arraycontains( var_2870ae57fdf631db, player ) )
            {
                var_2870ae57fdf631db = arrayremove( var_2870ae57fdf631db, player );
            }
        }
        
        foreach ( player in var_2870ae57fdf631db )
        {
            squadmembers = player squad_utility::getsquadmembers( undefined, 1 );
            missingmembers = arrayremove( squadmembers, var_2870ae57fdf631db );
            
            if ( !missingmembers.size )
            {
                escape.var_126cb2c6ab482f4e = escape.var_2687aca5dc3c5f0e * 1000 + gettime();
                
                if ( door.activity_instance )
                {
                    activity_definition_utils::updatetimer( escape.var_2687aca5dc3c5f0e, door.activity_instance );
                }
                
                params = spawnstruct();
                params.playersjoined = door.nearbyplayers;
                params.departing = 1;
                door function_bdd996dcad11441d( params );
                door notify( #"vehicle_squad_boarded" );
                return;
            }
        }
        
        wait 0.2;
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xf1e6c2b8, Offset: 0xa276
// Size: 0x348
function private function_3626b35950c85463()
{
    door = self;
    escape = door.escape;
    escape.var_56b295eb5735351b = [];
    door.var_2b04f42f93823c0c[ door.var_2b04f42f93823c0c.size ] = &function_7c1edfdc0e19c91a;
    var_735c179f1fa90996 = 3;
    var_f322d49bb961fef0 = level.exfildoors.exitradius * level.exfildoors.exitradius;
    var_cc2a7b3c090b156c = getgroundposition( door.origin, 5 );
    objidpoolmanager::update_objective_setneutrallabel( door.objid, level.exfildoors.var_a08917991a2f537b );
    objidpoolmanager::update_objective_description( door.objid, level.exfildoors.var_a08917991a2f537b );
    
    if ( level.exfildoors.var_514046136b01e204 )
    {
        escape.chevrons = function_a017d1ec37595fa( "sat_wc_drone_skyfall_chevron", var_cc2a7b3c090b156c, level.exfildoors.exitradius, 200, 0 );
    }
    
    while ( true )
    {
        var_8a0a46a36bdcefa7 = door.nearbyplayers ?? getplayersinradius( var_cc2a7b3c090b156c, 2000 );
        var_13cd73f9af7ce853 = arrayremove( var_8a0a46a36bdcefa7, escape.var_56b295eb5735351b );
        var_418b3dcdfe4acf33 = arrayremove( escape.var_56b295eb5735351b, var_8a0a46a36bdcefa7 );
        escape.var_56b295eb5735351b = var_8a0a46a36bdcefa7;
        var_b81ac8fbb391202d = 0;
        
        foreach ( player in var_418b3dcdfe4acf33 )
        {
            player function_6434c6e5dd766b2();
        }
        
        foreach ( player in var_8a0a46a36bdcefa7 )
        {
            var_2f1652851ed9ad32 = player::isaliveandnotinlaststand( player );
            
            if ( var_2f1652851ed9ad32 && distancesquared( player.origin, var_cc2a7b3c090b156c ) <= var_f322d49bb961fef0 )
            {
                if ( !player.exfiltime )
                {
                    player.exfiltime = gettime() + var_735c179f1fa90996 * 1000;
                    player thread function_7c595f7713b04ce8( door );
                    player thread function_438f8370a3c75c82();
                }
                else if ( gettime() >= player.exfiltime )
                {
                    door usedoor( player );
                }
                
                var_b81ac8fbb391202d = 1;
                continue;
            }
            
            if ( player.exfiltime )
            {
                player.exfiltime = undefined;
            }
        }
        
        if ( !var_b81ac8fbb391202d && gettime() > escape.var_126cb2c6ab482f4e )
        {
            break;
        }
        
        wait 0.03;
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x7ac4cb8, Offset: 0xa5c6
// Size: 0xd8
function private function_7c1edfdc0e19c91a()
{
    foreach ( player in self.escape.var_56b295eb5735351b )
    {
        player notify( #"left_escape" );
    }
    
    if ( self.escape.chevrons )
    {
        deletechevrons( self.escape.chevrons );
        self.escape.chevrons = undefined;
    }
    
    self notify( #"door_used_up" );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x64224bf3, Offset: 0xa6a6
// Size: 0x93
function private seticonnames()
{
    level.iconneutral = "waypoint_captureneutral";
    level.waypointcolors[ level.iconneutral ] = "neutral";
    level.waypointbgtype[ level.iconneutral ] = 0;
    level.waypointstring[ level.iconneutral ] = level.exfildoors.var_5b4212a9aa91aa5;
    level.waypointshader[ level.iconneutral ] = "icon_waypoint_dom_a";
    level.waypointpulses[ level.iconneutral ] = 0;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x443578, Offset: 0xa741
// Size: 0xca
function private function_d1964064b2de9c30()
{
    if ( self.state != "capturing" )
    {
        objidpoolmanager::update_objective_setneutrallabel( self.objid, level.exfildoors.var_17b5864fdda8cfc4 );
        objidpoolmanager::update_objective_description( self.objid, level.exfildoors.var_17b5864fdda8cfc4 );
        self setscriptablepartstate( #"pulse", #"capturing" );
        self.state = "capturing";
    }
    
    if ( isdefined( self.zone ) )
    {
        self.zone.forcedecaying = 0;
        objidpoolmanager::objective_show_progress( self.zone.objidnum, 1 );
    }
    
    self notify( self.state );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xa729bee5, Offset: 0xa813
// Size: 0x14
function private function_4be018a03b3a456a()
{
    if ( self.exfildoorused )
    {
        return self geteye();
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xe2e7229f, Offset: 0xa82f
// Size: 0x18d
function private function_b8d60681a17dfb9( player )
{
    player endon( #"death_or_disconnect" );
    player.exfildoorused = 1;
    player.b_completed_exfil = 1;
    player.var_22bd8935826c4bc5 = 1;
    player.var_bdeeca1e699ddbdb = 1;
    function_96f03754015567f0( player );
    
    if ( !isdefined( player.s_exfil ) )
    {
        player.s_exfil = {};
    }
    
    player.s_exfil.origin = self.origin;
    player val::set( "exfil", "ignoreme", 1 );
    player val::set( "exfil", "freezecontrols", 1 );
    player val::set( "exfil", "damage", 0 );
    player val::set( "exfil", "weapon", 0 );
    player val::set( "exfil", "breath_system", 0 );
    player val::set( "exfil", "cg_drawcrosshair", 0 );
    player val::set( "exfil", "show_weapon_hud", 0 );
    player cleardamageindicators();
    wait 0.35;
    player playerhide();
    
    if ( self.var_633b95f115bcc581 && self.var_633b95f115bcc581.success )
    {
        player thread hud_message::showsplash( self.var_633b95f115bcc581.success );
    }
    
    wait 1.5;
    thread ob_exfil::function_7945ba0143ab037d( player, self.exfiltype );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xdabce51, Offset: 0xa9c4
// Size: 0xe4
function private function_96f03754015567f0( escapedplayer )
{
    if ( !( isdefined( escapedplayer ) && isdefined( self.var_633b95f115bcc581 ) && isdefined( self.var_633b95f115bcc581.teammateescaped ) ) )
    {
        return;
    }
    
    a_squad_members = escapedplayer squad_utility::getsquadmembers();
    
    foreach ( var_8a958389218cbbb3 in a_squad_members )
    {
        if ( !isdefined( var_8a958389218cbbb3 ) || var_8a958389218cbbb3 == escapedplayer )
        {
            continue;
        }
        
        var_8a958389218cbbb3 thread hud_message::showsplash( self.var_633b95f115bcc581.teammateescaped, undefined, escapedplayer );
    }
}

// Namespace ob_exfil_door
// Params 4, eflags: 0x4
// Checksum 0x1fab997b, Offset: 0xaab0
// Size: 0xd0
function private function_7786b5b197d1bda2( radius, splashname, optionalnumber, playerforplayercard )
{
    if ( !splashname )
    {
        return;
    }
    
    nearbyplayers = radius > 0 ? getplayersinradius( self.origin, radius ) : self.nearbyplayers;
    
    foreach ( player in nearbyplayers )
    {
        player thread hud_message::showsplash( splashname, optionalnumber, playerforplayercard );
    }
}

// Namespace ob_exfil_door
// Params 3, eflags: 0x4
// Checksum 0x71eb2599, Offset: 0xab88
// Size: 0x4f
function private function_ef385881e5580ce9( origin, radius, dialogalias )
{
    nearbyplayers = radius > 0 ? getplayersinradius( origin, radius ) : self.nearbyplayers;
    level thread overlord::playevent( dialogalias, nearbyplayers );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xa1dfe79a, Offset: 0xabdf
// Size: 0xb0
function private function_a6f1528fa9ee3b98( dialogalias )
{
    nearbyplayers = [];
    
    foreach ( player in level.players )
    {
        var_a0768b85b7d3965d = function_a8ed7f4bb436e7a0( player );
        
        if ( var_a0768b85b7d3965d )
        {
            nearbyplayers[ nearbyplayers.size ] = player;
        }
    }
    
    level thread overlord::playevent( dialogalias, nearbyplayers );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xfe6bac3d, Offset: 0xac97
// Size: 0x10c
function private function_a85e95d446802804()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        nearby_ai = getaiarrayinradius( self.origin, 1000 );
        
        foreach ( ai in nearby_ai )
        {
            if ( !isalive( ai ) )
            {
                continue;
            }
            
            ground_ent = ai getgroundentity();
            
            if ( !ground_ent || self != ground_ent && self.var_dc64ea91291dad76 != ground_ent )
            {
                continue;
            }
            
            ai.var_a13bed1ac47e1b2c = 1;
            ai.forceannihilate = 1;
            ai kill();
        }
        
        wait 0.5;
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xdf99822d, Offset: 0xadab
// Size: 0xa4
function private escapesquad( escapingplayer )
{
    var_8dd6fc446d76bd33 = teams::getsquadmates( escapingplayer.team, escapingplayer.sessionsquadid );
    
    foreach ( squadmate in var_8dd6fc446d76bd33 )
    {
        usedoor( squadmate );
    }
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0x77c372df, Offset: 0xae57
// Size: 0x1d0
function private usedoor( escapingplayer, bforce )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( function_26364526ada33046() && self.escapevehicle )
    {
        var_f5bf2caa110f2670 = self.escapevehicle.canexfil;
    }
    
    if ( !bforce )
    {
        if ( self.state != "escape" && !var_f5bf2caa110f2670 )
        {
            return;
        }
        
        if ( escapingplayer.b_completed_exfil )
        {
            return;
        }
    }
    
    if ( escapingplayer )
    {
        ob_settings = ob::get_ob_settings();
        thread function_b8d60681a17dfb9( escapingplayer );
        escapingplayer notifyonplayercommandremove( "cancel_door_use", "-usereload" );
        escapingplayer notifyonplayercommandremove( "cancel_door_use", "-activate" );
        
        if ( getdvarint( @"hash_38b0507d605cedaa", ob_settings.var_479717f90758fb9b ?? 0 ) )
        {
            escapesquad( escapingplayer );
        }
    }
    
    foreach ( player in level.players )
    {
        self enablescriptablepartplayeruse( #"interact", player );
    }
    
    self.var_ff3959095054d01b = 0;
    self.remaining_escapes--;
    
    if ( !function_26364526ada33046() )
    {
        function_9ae78bd779e6c9a();
    }
    
    if ( self.remaining_escapes >= 1 || level.exfildoors.unlimitedescapes )
    {
        return;
    }
    
    self notify( #"door_used_up" );
}

// Namespace ob_exfil_door
// Params 0
// Checksum 0xed90e38a, Offset: 0xb02f
// Size: 0xad
function function_cf2ec10942d5bbfb()
{
    assert( arraycontains( level.exfildoors.activedoors, self ) );
    level.exfildoors.currentspawned--;
    level.exfildoors.locations[ level.exfildoors.locations.size ] = self.location;
    level.exfildoors.activedoors = arrayremove( level.exfildoors.activedoors, self );
    objidpoolmanager::returnobjectiveid( self.objid );
    self delete();
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xbf064277, Offset: 0xb0e4
// Size: 0x83
function private close_doors( doors )
{
    foreach ( door in doors )
    {
        door function_be76c213a346fa5f( "closed" );
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x9cd74887, Offset: 0xb16f
// Size: 0x1bb
function private function_9a298dcd436e686( user )
{
    user endon( #"interaction_complete" );
    
    if ( self.state != "escape" )
    {
        return;
    }
    
    self.var_ff3959095054d01b = 1;
    
    foreach ( player in level.players )
    {
        if ( player != user )
        {
            self disablescriptablepartplayeruse( #"interact", player );
        }
    }
    
    user notifyonplayercommand( "cancel_door_use", "-usereload" );
    user notifyonplayercommand( "cancel_door_use", "-activate" );
    
    if ( user usebuttonpressed( 1 ) )
    {
        user utility::waittill_any( "cancel_door_use", "death_or_disconnect" );
    }
    
    self.var_ff3959095054d01b = 0;
    user notifyonplayercommandremove( "cancel_door_use", "-usereload" );
    user notifyonplayercommandremove( "cancel_door_use", "-activate" );
    
    foreach ( player in level.players )
    {
        if ( player != user )
        {
            self enablescriptablepartplayeruse( #"interact", player );
            continue;
        }
        
        if ( isdefined( user ) )
        {
            thread function_77c8cc36db9960f2( user );
        }
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x5f5e762f, Offset: 0xb332
// Size: 0x5a
function private function_77c8cc36db9960f2( player )
{
    player endon( #"death_or_disconnect" );
    self endon( #"deleted" );
    self disablescriptablepartplayeruse( #"interact", player );
    wait 0.5;
    
    if ( !self.var_ff3959095054d01b )
    {
        self enablescriptablepartplayeruse( #"interact", player );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xd1dc12b5, Offset: 0xb394
// Size: 0xf2
function private function_cea3e3ddf925aba1()
{
    self endon( #"death_or_disconnect" );
    overlay_state_off = 0;
    var_a0559c761d5a74bb = 10;
    var_33f5b5f4851b6009 = 6;
    isencrypted = 0;
    self setclientomnvar( "ui_br_bink_overlay_state", var_a0559c761d5a74bb );
    utility::hidehudenable();
    self playsoundtoplayer( "bik_jup_ob_teleport", self );
    self setsoundsubmix( "jup_ob_endgame", 0.1 );
    
    if ( getdvarint( @"hash_8666e0ca4158983a", 1 ) )
    {
        level thread game_utility::fadetoblackforplayerkeepui( self, 1, 1 );
        game_utility::function_d4ba0aa63f12e375( 1 );
        wait 1;
    }
    else
    {
        self playcinematicforplayer( level.exfildoors.teleportmovie, 1, isencrypted );
        wait var_33f5b5f4851b6009 - 0.1;
        level thread game_utility::fadetoblackforplayer( self, 1, 0.1 );
        wait 0.1;
        self stopcinematicforplayer();
    }
    
    utility::hidehuddisable();
    self setclientomnvar( "ui_br_bink_overlay_state", overlay_state_off );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x89d81610, Offset: 0xb48e
// Size: 0x88
function private function_52e96fadcc0be567( reason )
{
    switch ( reason )
    {
        case 0:
            /#
                iprintlnbold( self.name + "<dev string:x9e>" );
            #/
            
            break;
        case 1:
            /#
                iprintlnbold( self.name + "<dev string:xc2>" );
            #/
            
            break;
        case 2:
            /#
                iprintlnbold( self.name + "<dev string:xe2>" );
            #/
            
            break;
    }
}

/#

    // Namespace ob_exfil_door
    // Params 0, eflags: 0x4
    // Checksum 0x6f038956, Offset: 0xb51e
    // Size: 0x103, Type: dev
    function private function_3191d4d791f1823f()
    {
        devgui::function_9082edeb5db93280( "<dev string:x106>" );
        devgui::add_devgui_func( "<dev string:x116>", "<dev string:x139>", &function_3aa9d52d5370662b );
        devgui::add_devgui_func( "<dev string:x14d>", "<dev string:x165>", &function_89b6eef19befd94a );
        devgui::add_devgui_func( "<dev string:x17b>", "<dev string:x184>", &function_ccb39f6d6020d25, 1 );
        
        foreach ( exfilsp in level.exfilspawnpoints )
        {
            exfilsp function_830e072dba77380e();
            devgui::function_cd4e263c1f3018ae( "<dev string:x193>" + exfilsp.name, "<dev string:x1a0>" + exfilsp.name, &function_9e5873c0f4ce074 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_exfil_door
    // Params 0
    // Checksum 0xc77905de, Offset: 0xb629
    // Size: 0x4b, Type: dev
    function function_830e072dba77380e()
    {
        if ( !isdefined( self.name ) )
        {
            if ( !isdefined( level.var_17493d1b4d4a2a83 ) )
            {
                level.var_17493d1b4d4a2a83 = 0;
            }
            
            self.name = "<dev string:x1a7>" + level.var_17493d1b4d4a2a83;
            level.var_17493d1b4d4a2a83++;
        }
    }

    // Namespace ob_exfil_door
    // Params 0, eflags: 0x4
    // Checksum 0xc58f9c6f, Offset: 0xb67c
    // Size: 0x2d, Type: dev
    function private function_89b6eef19befd94a()
    {
        level.exfildoors.unlimitedescapes = !level.exfildoors.unlimitedescapes;
    }

    // Namespace ob_exfil_door
    // Params 0, eflags: 0x4
    // Checksum 0x17dffd02, Offset: 0xb6b1
    // Size: 0xa5, Type: dev
    function private function_3aa9d52d5370662b()
    {
        exfildoor = function_fbf793c284a15f01();
        
        foreach ( player in level.players )
        {
            player setorigin( exfildoor.origin + ( 50, 50, 100 ) );
        }
    }

    // Namespace ob_exfil_door
    // Params 0, eflags: 0x4
    // Checksum 0x9999417c, Offset: 0xb75e
    // Size: 0x12f, Type: dev
    function private function_ccb39f6d6020d25()
    {
        while ( true )
        {
            foreach ( spawnpoint in level.exfilspawnpoints )
            {
                debug::sphere( spawnpoint.origin, 500, "<dev string:x1ae>" );
            }
            
            foreach ( door in level.exfildoors.activedoors )
            {
                debug::sphere( spawnpoint.origin, 500, "<dev string:x1b3>" );
            }
            
            wait 5;
        }
    }

    // Namespace ob_exfil_door
    // Params 0, eflags: 0x4
    // Checksum 0xf6ff30c8, Offset: 0xb895
    // Size: 0x1bb, Type: dev
    function private devgui_debug_spawn()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_f9895c9faea5e623" ) )
            {
                if ( level.exfilspawnpoints.size == 0 )
                {
                    level.exfilspawnpoints[ 0 ] = { #type:"<dev string:x1b9>", #angles:level.players[ 0 ].angles, #origin:level.players[ 0 ].origin };
                }
                
                location = undefined;
                
                switch ( getdvarint( @"hash_f9895c9faea5e623" ) )
                {
                    case 2:
                        location = function_f20a3e246a0dc3a4( 0 );
                        break;
                    case 3:
                        location = function_a1d1fa998d75b529( 0 );
                        break;
                    case 4:
                        location = function_d56ad752a55da575( 0 );
                        break;
                    case 5:
                        location = function_db1bae95882b9509( 0 );
                        break;
                    case 6:
                        location = function_f5ad4cfd4f9e1ab3( 0 );
                        break;
                    case 7:
                        location = function_36e6cf100643b1da();
                        finaldoor = 1;
                        break;
                }
                
                if ( isdefined( location ) && !location.currentlyinuse )
                {
                    level.var_5b1aa9671f69f4e9[ location.regiondifficulty ]++;
                    level notify( "<dev string:x1c1>" + location.name );
                    level thread spawnexfildoor( location, finaldoor ? "<dev string:x1d2>" : undefined, { #selectedplayers:level.players } );
                }
                
                setdvar( @"hash_f9895c9faea5e623", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace ob_exfil_door
    // Params 0, eflags: 0x4
    // Checksum 0xc11c751d, Offset: 0xba58
    // Size: 0x310, Type: dev
    function private function_cc460da53f6000ae()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_a92084919397a6d5" ) )
            {
                door = undefined;
                
                switch ( getdvarint( @"hash_a92084919397a6d5" ) )
                {
                    case 1:
                        dist = 2147483647;
                        
                        foreach ( player in level.players )
                        {
                            foreach ( active_door in level.exfildoors.activedoors )
                            {
                                var_5b23ce381dc8a1df = distancesquared( active_door.origin, player.origin );
                                
                                if ( var_5b23ce381dc8a1df < dist )
                                {
                                    dist = var_5b23ce381dc8a1df;
                                    door = active_door;
                                }
                            }
                        }
                        
                        break;
                    case 2:
                        dist = 0;
                        
                        foreach ( player in level.players )
                        {
                            foreach ( active_door in level.exfildoors.activedoors )
                            {
                                var_5b23ce381dc8a1df = distancesquared( active_door.origin, player.origin );
                                
                                if ( var_5b23ce381dc8a1df > dist )
                                {
                                    dist = var_5b23ce381dc8a1df;
                                    door = active_door;
                                }
                            }
                        }
                        
                        break;
                }
                
                if ( door )
                {
                    foreach ( player in level.players )
                    {
                        door thread usedoor( player, 1 );
                    }
                }
                
                setdvar( @"hash_a92084919397a6d5", 0 );
            }
            
            waitframe();
        }
    }

#/

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xb70e439b, Offset: 0xbd70
// Size: 0x19a
function private function_f20a3e246a0dc3a4( var_af7892f4eaf4beb6 = 1 )
{
    nearest_dist = 2147483647;
    var_17011eaaeed2dd22 = 0;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.sessionstate != "playing" )
        {
            continue;
        }
        
        foreach ( index, location in level.exfilspawnpoints )
        {
            dist = distancesquared( player.origin, location.origin );
            
            if ( dist < nearest_dist )
            {
                nearest_dist = dist;
                var_17011eaaeed2dd22 = index;
            }
        }
    }
    
    location = level.exfilspawnpoints[ var_17011eaaeed2dd22 ];
    
    if ( var_af7892f4eaf4beb6 )
    {
        level.exfilspawnpoints[ var_17011eaaeed2dd22 ] = undefined;
        
        if ( isint( var_17011eaaeed2dd22 ) )
        {
            function_cdc669dbc8ea2101( level.exfilspawnpoints );
        }
    }
    
    return location;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xd7086994, Offset: 0xbf13
// Size: 0x1b0
function private function_a1d1fa998d75b529( var_af7892f4eaf4beb6 = 1 )
{
    var_a762560fad02f5ea = 0;
    var_17011eaaeed2dd22 = 0;
    
    foreach ( index, location in level.exfilspawnpoints )
    {
        nearest_dist = 2147483647;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || player.sessionstate != "playing" )
            {
                continue;
            }
            
            dist = distancesquared( player.origin, location.origin );
            
            if ( dist < nearest_dist )
            {
                nearest_dist = dist;
            }
        }
        
        if ( nearest_dist > var_a762560fad02f5ea )
        {
            var_17011eaaeed2dd22 = index;
            var_a762560fad02f5ea = nearest_dist;
        }
    }
    
    location = level.exfilspawnpoints[ var_17011eaaeed2dd22 ];
    
    if ( var_af7892f4eaf4beb6 )
    {
        level.exfilspawnpoints[ var_17011eaaeed2dd22 ] = undefined;
        
        if ( isint( var_17011eaaeed2dd22 ) )
        {
            function_cdc669dbc8ea2101( level.exfilspawnpoints );
        }
    }
    
    return location;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x483b0b05, Offset: 0xc0cc
// Size: 0x1cc
function private function_d56ad752a55da575( var_af7892f4eaf4beb6 = 1 )
{
    aggregate_pos = ( 0, 0, 0 );
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.sessionstate != "playing" )
        {
            continue;
        }
        
        aggregate_pos += player.origin;
    }
    
    average_pos = aggregate_pos / level.players.size;
    nearest_dist = 2147483647;
    
    foreach ( index, location in level.exfilspawnpoints )
    {
        dist = distancesquared( average_pos, location.origin );
        
        if ( dist < nearest_dist )
        {
            nearest_dist = dist;
            var_17011eaaeed2dd22 = index;
        }
    }
    
    location = level.exfilspawnpoints[ var_17011eaaeed2dd22 ];
    
    if ( var_af7892f4eaf4beb6 )
    {
        level.exfilspawnpoints[ var_17011eaaeed2dd22 ] = undefined;
        
        if ( isint( var_17011eaaeed2dd22 ) )
        {
            function_cdc669dbc8ea2101( level.exfilspawnpoints );
        }
    }
    
    return location;
}

// Namespace ob_exfil_door
// Params 1
// Checksum 0x1b488cfe, Offset: 0xc2a1
// Size: 0x6f
function function_db1bae95882b9509( var_af7892f4eaf4beb6 = 1 )
{
    locationindex = randomint( level.exfilspawnpoints.size );
    location = level.exfilspawnpoints[ locationindex ];
    
    if ( var_af7892f4eaf4beb6 )
    {
        level.exfilspawnpoints[ locationindex ] = undefined;
        
        if ( isint( locationindex ) )
        {
            function_cdc669dbc8ea2101( level.exfilspawnpoints );
        }
    }
    
    return location;
}

// Namespace ob_exfil_door
// Params 1
// Checksum 0xbae2029a, Offset: 0xc319
// Size: 0xb8
function function_411eb495addeeaf( tier )
{
    foreach ( spawnpoint in level.exfilspawnpoints )
    {
        if ( isdefined( tier ) )
        {
            var_72b4ca1d3d3eaa28 = region_difficulty_manager::get_region_difficulty_int( spawnpoint.origin );
            
            if ( tier != var_72b4ca1d3d3eaa28 )
            {
                continue;
            }
        }
        
        location = spawnpoint;
        break;
    }
    
    return location;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x1edbf431, Offset: 0xc3da
// Size: 0x124
function private function_f5ad4cfd4f9e1ab3( var_af7892f4eaf4beb6 = 1 )
{
    locationindex = randomint( level.exfilspawnpoints.size );
    location = level.exfilspawnpoints[ locationindex ];
    exfilspawnfilter = getdvar( @"scr_exfil_spawn_filter", "" );
    
    foreach ( index, spawnpoint in level.exfilspawnpoints )
    {
        if ( exfilspawnfilter != "" && spawnpoint.script_label != exfilspawnfilter )
        {
            continue;
        }
        
        location = spawnpoint;
        locationindex = index;
        break;
    }
    
    if ( var_af7892f4eaf4beb6 )
    {
        level.exfilspawnpoints[ locationindex ] = undefined;
        
        if ( isint( locationindex ) )
        {
            function_cdc669dbc8ea2101( level.exfilspawnpoints );
        }
    }
    
    return location;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xcd5b417e, Offset: 0xc507
// Size: 0x17d
function private function_c77af03178f373f9( var_af7892f4eaf4beb6 = 1 )
{
    mincount = 2147483647;
    targetregion = undefined;
    
    foreach ( region, count in level.var_5b1aa9671f69f4e9 )
    {
        if ( count == level.var_c9beb633f5fe093f[ region ] )
        {
            continue;
        }
        
        if ( count < mincount )
        {
            mincount = count;
            targetregion = region;
        }
    }
    
    if ( !isdefined( targetregion ) )
    {
        return;
    }
    
    foreach ( locationindex, spawnpoint in level.exfilspawnpoints )
    {
        region = region_difficulty_manager::get_region_difficulty( spawnpoint.origin );
        
        if ( region == targetregion )
        {
            if ( var_af7892f4eaf4beb6 )
            {
                level.exfilspawnpoints[ locationindex ] = undefined;
                
                if ( isint( locationindex ) )
                {
                    function_cdc669dbc8ea2101( level.exfilspawnpoints );
                }
            }
            
            return spawnpoint;
        }
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x863a69ba, Offset: 0xc68d
// Size: 0x23
function private function_36e6cf100643b1da()
{
    if ( isdefined( level.ob_escalation ) )
    {
        return level.ob_escalation.var_dedc7dcd0dafaf3d;
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xcae78dc0, Offset: 0xc6b9
// Size: 0x5
function private function_ca13d10a517de0f1()
{
    wait 10;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xedf9b3ba, Offset: 0xc6c6
// Size: 0x85
function private function_faf5430998076cbf( params )
{
    foreach ( player in level.players )
    {
        player function_ee8d38a1cf99b120();
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x9bf4b092, Offset: 0xc753
// Size: 0x13d
function private function_ee8d38a1cf99b120()
{
    var_f84752badbf8bf5d = 1;
    nearest_dist = undefined;
    nearest_door = undefined;
    
    if ( var_f84752badbf8bf5d )
    {
        playertier = region_difficulty_manager::get_region_difficulty_int( self.origin );
    }
    
    foreach ( door in level.exfildoors.activedoors )
    {
        if ( var_f84752badbf8bf5d )
        {
            doortier = region_difficulty_manager::get_region_difficulty_int( door.origin );
            
            if ( playertier != doortier )
            {
                continue;
            }
        }
        
        dist = distancesquared( self.origin, door.origin );
        
        if ( !isdefined( nearest_door ) || dist < nearest_dist )
        {
            nearest_dist = dist;
            nearest_door = door;
        }
    }
    
    if ( nearest_door )
    {
        scriptableindex = nearest_door getscriptableindex();
        calloutmarkerping::function_920a63c06abdefe8( scriptableindex );
    }
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0x2b0cb3e2, Offset: 0xc898
// Size: 0x529
function private function_17fa59bd27909396( spawnlocation, spawnangle )
{
    door = self;
    exfildoors = level.exfildoors;
    spawndata = spawnstruct();
    spawndata.origin = spawnlocation;
    spawndata.angles = spawnangle;
    spawndata.spawntype = "GAME_MODE";
    spawndata.script_vehiclebundle = door.var_4ef8b1fc3b33bbc1 ?? exfildoors.var_4ef8b1fc3b33bbc1;
    spawndata.var_8e91d3ada982e3ef = ( 1, 0.25, 0.5 );
    spawndata vehicle_spawn::prevent_respawn();
    vtol = undefined;
    var_ace202d0c6b9306a = 0;
    reservevehicles = exfildoors.var_50dc848530b474de;
    
    while ( !isdefined( vtol ) )
    {
        if ( reservevehicles )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
        }
        
        vtol = spawndata vehicle::function_dcbcdc00863e94d6();
        
        if ( isdefined( vtol ) )
        {
            break;
        }
        
        if ( reservevehicles )
        {
            vehicle_tracking::reserve_vehicle();
        }
        
        var_ace202d0c6b9306a++;
        logstring( "==OB Exfil: Vehicle failed to spawn at " + spawndata.origin + ". Attempts: " + var_ace202d0c6b9306a );
        wait 1;
    }
    
    vtol.var_d543261e69382d13 = 0;
    vtol.var_b1e7f946abc78a83 = 10000;
    vtol.dontspawnhusk = 1;
    vtol.var_dc64ea91291dad76 = vtol setupramp();
    vtol.handleeventcallback = &function_a8ae0b816e361bb8;
    vtol.script_disconnectpaths = 1;
    vtol.exfilhelicopter = 1;
    vtol.has_interior = 1;
    vtol.var_4efa4e2adc37ef3[ #"hash_414fb3731e9bfb98" ] = 1;
    vtol.var_fa5c4117855bfaf7 = spawn( "trigger_box", vtol.origin, 0, ( 267, 65, 50 ), ( 267, 65, 50 ) );
    vtol.var_fa5c4117855bfaf7 enablelinkto();
    vtol.var_fa5c4117855bfaf7 linkto( vtol, "tag_origin", ( -97, 0, -75 ), ( 0, 0, 0 ) );
    thread trigger::makeenterexittrigger( vtol.var_fa5c4117855bfaf7, &function_ecc108b632e98979, &function_c5320e45c1c09fcf, undefined, undefined, &function_3558142dc320f639 );
    vtol.var_2164fe73eb509331 = spawn( "trigger_box", vtol.origin, 0, ( 190, 50, 50 ), ( 190, 50, 50 ) );
    vtol.var_2164fe73eb509331 enablelinkto();
    vtol.var_2164fe73eb509331 linkto( vtol, "tag_origin", ( -50, 0, -75 ), ( 0, 0, 0 ) );
    thread trigger::makeenterexittrigger( vtol.var_2164fe73eb509331, &function_816050cea2f08017, &function_ffbc472eb944c28b, undefined, undefined, &function_3558142dc320f639 );
    
    if ( getdvarint( @"hash_2c8adcb66604a5f2", 0 ) == 0 )
    {
        vtol.var_8726d0249a96d9d9 = [];
        vtol.var_8726d0249a96d9d9[ 0 ] = { #height:150, #radius:150, #offset:( 0, 0, -135 ) };
        vtol.var_8726d0249a96d9d9[ 1 ] = { #height:150, #radius:150, #offset:( 240, 0, -125 ) };
        vtol.var_8726d0249a96d9d9[ 2 ] = { #height:150, #radius:150, #offset:( -240, 0, -135 ) };
        vtol.var_8726d0249a96d9d9[ 3 ] = { #height:100, #radius:195, #offset:( -580, 0, -20 ) };
        vtol.var_8726d0249a96d9d9[ 4 ] = { #height:100, #radius:75, #offset:( 140, -390, -30 ) };
        vtol.var_8726d0249a96d9d9[ 5 ] = { #height:100, #radius:75, #offset:( 140, 390, -30 ) };
    }
    
    vtol function_d2b8ee2e1275daaf( 1 );
    vtol forcenetfieldhighlod( 1 );
    vtol vehicle_damage::set_can_damage( 0 );
    vehicle_interact::allow_use( vtol, 0 );
    
    if ( isdefined( vtol getscriptablepartstate( #"vehicle_active_camo_fx", 0 ) ) )
    {
        vtol setscriptablepartstate( #"vehicle_active_camo_fx", #"camo_fx_on", 0 );
    }
    
    if ( vtol.var_dc64ea91291dad76 )
    {
        vtol.var_dc64ea91291dad76 hide();
    }
    
    vtol thread function_c851f13a9a4f6a4d();
    vtol.navmeshsettings = door.navmeshsettings;
    return vtol;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x35637f46, Offset: 0xcdca
// Size: 0x34
function private function_8a09ef6f4b91eb5d()
{
    b_walkable = getdvarint( @"hash_ab8956c864b4d3a4", self.navmeshsettings.var_6c2c71716cbaeb4 ) ?? 0;
    return b_walkable;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x73c851f4, Offset: 0xce07
// Size: 0x34
function private function_3d45358b15a889e4()
{
    b_block = getdvarint( @"hash_c64dbbac911fb138", self.navmeshsettings.var_449846521333c31b ) ?? 0;
    return b_block;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x44429787, Offset: 0xce44
// Size: 0x7c
function private function_fdc2f0d287a9abc4()
{
    if ( isdefined( self.var_8a41b6dfbb17096c ) )
    {
        return;
    }
    
    vehicle_code::vehicle_remove_navobstacle();
    var_8d6fa17fc906e338 = ( 315, 70, 42.5 );
    var_5969dfe38149ffda = ( 85, 0, -197 );
    var_5969dfe38149ffda = rotatevector( var_5969dfe38149ffda, self.angles );
    self.var_8a41b6dfbb17096c = createnavobstaclebybounds( self.origin + var_5969dfe38149ffda, var_8d6fa17fc906e338, self.angles );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xbc0f75c2, Offset: 0xcec8
// Size: 0x29
function private function_f40905d3563194d2()
{
    if ( !isdefined( self.var_8a41b6dfbb17096c ) )
    {
        return;
    }
    
    destroynavobstacle( self.var_8a41b6dfbb17096c );
    self.var_8a41b6dfbb17096c = undefined;
}

// Namespace ob_exfil_door
// Params 0
// Checksum 0xf86e19c1, Offset: 0xcef9
// Size: 0x36a
function function_d87b8abe983d8b3c()
{
    vtol = self;
    navmeshsettings = vtol.navmeshsettings;
    var_ace665dbb1517dbc = ( 132, 60, -120 );
    var_8552c6b64e1033c7 = ( 132, 90, -120 );
    var_fbacd16f6d8cded = ( 132, -60, -120 );
    var_4f61c55b917fc544 = ( 132, -90, -120 );
    var_eb3485451060e57a = ( -330, 30, -160 );
    var_dbb738a1f06ab361 = ( -370, 30, -140 );
    var_fe417252bee72e2b = ( -330, -30, -160 );
    var_3b0f81c6157d0a7e = ( -370, -30, -140 );
    var_c61524571115d9a = ( -330, 0, -160 );
    var_90a8f6032fe2b301 = ( -370, 0, -140 );
    var_97a796626baef1fa = [];
    var_97a796626baef1fa[ 0 ] = { #var_ee619f7676464495:1, #v_inside:var_ace665dbb1517dbc, #v_outside:var_8552c6b64e1033c7, #str_name_prefix:"traverse_vtol_front_left" };
    var_97a796626baef1fa[ 1 ] = { #var_ee619f7676464495:1, #v_inside:var_fbacd16f6d8cded, #v_outside:var_4f61c55b917fc544, #str_name_prefix:"traverse_vtol_front_right" };
    var_97a796626baef1fa[ 2 ] = { #var_ee619f7676464495:1, #v_inside:var_eb3485451060e57a, #v_outside:var_dbb738a1f06ab361, #str_name_prefix:"traverse_vtol_rear_left_ramp" };
    var_97a796626baef1fa[ 3 ] = { #var_ee619f7676464495:1, #v_inside:var_fe417252bee72e2b, #v_outside:var_3b0f81c6157d0a7e, #str_name_prefix:"traverse_vtol_rear_right_ramp" };
    var_97a796626baef1fa[ 4 ] = { #var_ee619f7676464495:1, #v_inside:var_c61524571115d9a, #v_outside:var_90a8f6032fe2b301, #str_name_prefix:"traverse_vtol_rear_middle_ramp" };
    
    foreach ( navlink in var_97a796626baef1fa )
    {
        navlink.v_inside = coordtransform( navlink.v_inside, vtol.origin, vtol.angles );
        navlink.v_outside = coordtransform( navlink.v_outside, vtol.origin, vtol.angles );
        navlink.v_outside = getgroundposition( navlink.v_outside, 8 );
    }
    
    return { #var_97a796626baef1fa:var_97a796626baef1fa, #var_94d8b3084a534b9a:( 0, 0, 0 ), #var_5576c1583c24ff1:( 0, 0, -6 ), #str_link_tag:"tag_origin", #var_e976814839225a7c:navmeshsettings.var_e976814839225a7c ?? [ "walkable_vtol_open_doors_navmesh" ] };
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x2e03fa65, Offset: 0xd26c
// Size: 0x30
function private function_c851f13a9a4f6a4d()
{
    level endon( #"game_ended" );
    self endon( #"vehicle_deleted" );
    self waittill( #"death" );
    level exfil_vehicle_delete( self );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x7cd8c500, Offset: 0xd2a4
// Size: 0x7b
function private setupramp()
{
    ramplocation = self gettagorigin( "tag_ramp_lower_animate" );
    rampangles = self gettagangles( "tag_ramp_lower_animate" );
    var_dc64ea91291dad76 = spawn( "script_model", ramplocation );
    var_dc64ea91291dad76.angles = rampangles;
    var_dc64ea91291dad76 setmodel( %"veh_sat_mil_air_vtol_buzzard_ramp_lower" );
    var_dc64ea91291dad76 linkto( self, "tag_ramp_lower_animate" );
    var_dc64ea91291dad76.parent = self;
    return var_dc64ea91291dad76;
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xfbd46860, Offset: 0xd328
// Size: 0xb3
function private function_a8ae0b816e361bb8( vehicle )
{
    if ( !isalive( vehicle ) || vehicle.chopperexfilhit )
    {
        return;
    }
    
    vtolspeed = self vehicle_getspeed();
    vtolspeed = max( vtolspeed, self.veh_speed );
    
    if ( vtolspeed == 0 )
    {
        return;
    }
    
    vehicle_occupancy::eject_all_occupants( vehicle );
    vehicle.chopperexfilhit = 1;
    vehicle.dontspawnhusk = 1;
    
    if ( vehicle vehicle::is_killstreak() )
    {
        vehicle dodamage( vehicle.health + 20000, self.origin, vehicle, vehicle, "MOD_CRUSH" );
        return;
    }
    
    vehicle thread vehicle::explode();
}

// Namespace ob_exfil_door
// Params 3, eflags: 0x4
// Checksum 0xb70521b5, Offset: 0xd3e3
// Size: 0x25, Type: bool
function private function_3558142dc320f639( var_11bf9622e9646279, trigger, payload )
{
    return !isplayer( var_11bf9622e9646279 );
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0x5ae416f1, Offset: 0xd411
// Size: 0x4c
function private function_2937e4590f303c3f( player, trigger )
{
    exfildoors = level.exfildoors;
    
    if ( exfildoors.var_60734f62429a2944 )
    {
        player val::set( "exfil_site", "remote_killstreaks", 0 );
    }
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0x1b580ca7, Offset: 0xd465
// Size: 0x46
function private function_15074e0577870941( player, trigger )
{
    exfildoors = level.exfildoors;
    
    if ( exfildoors.var_60734f62429a2944 )
    {
        player val::reset_all( "exfil_site" );
    }
}

// Namespace ob_exfil_door
// Params 3, eflags: 0x4
// Checksum 0xeff53759, Offset: 0xd4b3
// Size: 0x9a
function private function_ecc108b632e98979( player, trigger, payload )
{
    exfildoors = level.exfildoors;
    
    if ( player.isjuggernaut )
    {
        player notify( #"remote_robot_manual_exit" );
    }
    
    if ( player.ismutantinjection || player.mutantinjectiontransformed )
    {
        player notify( #"mutantinjection_exit" );
    }
    
    if ( exfildoors.var_60734f62429a2944 )
    {
        player val::set( "exfil_vehicle_interior", "remote_killstreaks", 0 );
    }
}

// Namespace ob_exfil_door
// Params 3, eflags: 0x4
// Checksum 0x4c4c6f67, Offset: 0xd555
// Size: 0x4f
function private function_c5320e45c1c09fcf( player, trigger, payload )
{
    exfildoors = level.exfildoors;
    
    if ( exfildoors.var_60734f62429a2944 )
    {
        player val::reset_all( "exfil_vehicle_interior" );
    }
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0xe96607c9, Offset: 0xd5ac
// Size: 0x4b
function private function_816050cea2f08017( player, trigger )
{
    player notify( #"exfil_vtol_trigger" );
    player.var_800c49fd6b078495 = trigger;
    
    if ( !isai( player ) )
    {
        function_89182a274183f293( "exfil_vtol", "exfil_vtol", player );
    }
}

// Namespace ob_exfil_door
// Params 2, eflags: 0x4
// Checksum 0x4045c95b, Offset: 0xd5ff
// Size: 0xce
function private function_ffbc472eb944c28b( player, trigger )
{
    regiondifficulty = region_difficulty_manager::get_region_difficulty( player.origin );
    
    switch ( regiondifficulty )
    {
        case #"hash_5343b465e56ec9a4":
        case #"hash_651f76c0ad6741ec":
        case #"hash_c0250ffc2e87f2ff":
        case #"hash_c02510fc2e87f492":
            state = "cradle";
            break;
        case #"hash_7bb2cd766703d463":
        case #"hash_af83e47edfa8900a":
        default:
            state = "";
            break;
    }
    
    player.var_800c49fd6b078495 = undefined;
    
    if ( !isai( player ) )
    {
        function_89182a274183f293( "exfil_vtol", state, player );
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xe3052230, Offset: 0xd6d5
// Size: 0x23c
function private function_75928ee6f4d0de21()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    door = self;
    vtol = door.escapevehicle;
    vspeed = 35;
    vaccel = 15;
    vdecel = 15;
    targetlocation = door.origin + ( 0, 0, 2000 );
    function_7786b5b197d1bda2( door.notifyradius, door.var_633b95f115bcc581.vehicleinbound );
    targetangle = targetlocation - vtol.origin;
    targetangle = vectortoyaw( targetangle );
    vtol vehicle_helisetai( targetlocation, vspeed, vaccel, vdecel, 1, 1, targetangle, 0, 0, 1, 0, 0, 1 );
    vtol sethoverparams( 50, 25, 25 );
    vtol setrotorsactive( 1 );
    vtol vehicle_turnengineon();
    vtol setscriptablepartstate( #"engine", #"on_all" );
    vtol setscriptablepartstate( #"thrusters", #"horizontal" );
    vtol setscriptablepartstate( #"flaps", #"off", 0 );
    wait 2;
    vtol setscriptablepartstate( #"blinking_lights", #"on" );
    vtol setscriptablepartstate( #"interior_light", #"on" );
    vtol setscriptablepartstate( #"vehicle_active_camo_fx", #"camo_fx_deactivate", 0 );
    
    if ( vtol.var_dc64ea91291dad76 )
    {
        vtol.var_dc64ea91291dad76 show();
    }
    
    vtol setneargoalnotifydist( 300 );
    vtol waittill( #"near_goal" );
    vtol setscriptablepartstate( #"engine", #"on_main" );
    vtol setscriptablepartstate( #"thrusters", #"dynamic" );
    vtol setscriptablepartstate( #"flaps", #"on", 0 );
    wait 1;
    vtol.arrived = 1;
    vtol notify( #"vehicle_arrived" );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x9545460a, Offset: 0xd919
// Size: 0x317
function private function_931ccc9722ea96fa()
{
    door = self;
    vtol = door.escapevehicle;
    vtol notify( #"vehicle_parking" );
    heightadjust = 170;
    vspeed = 20;
    vaccel = 5;
    targetlocation = door.origin;
    vhalfsize = vtol getboundshalfsize();
    vradius = max( vhalfsize[ 0 ], vhalfsize[ 1 ] );
    highestlocation = function_d7b4b95f667bee27( targetlocation, vradius / 2, 8 );
    targetlocation = ( targetlocation[ 0 ], targetlocation[ 1 ], highestlocation[ 2 ] + heightadjust );
    targetangle = targetlocation - highestlocation;
    targetyaw = vectortoyaw( targetangle );
    
    /#
        if ( getdvarint( @"hash_d45cefb383219de5", 0 ) )
        {
            debug::sphere( targetlocation, 40, ( 0, 0, 1 ), 5 );
            debug::sphere( highestlocation, 40, ( 0, 1, 0 ), 5 );
        }
    #/
    
    vtol vehicle_setspeed( vspeed, vaccel );
    vtol setyawspeed( 45, 45, 45, 0.1 );
    vtol setgoalyaw( targetyaw );
    vtol settargetyaw( targetyaw );
    vtol function_d2b8ee2e1275daaf( 0 );
    wait 2;
    vtol setvehgoalpos( targetlocation, 1 );
    vtol sethoverparams( 0, 0, 0 );
    
    if ( self.var_c990964cb2f53594 )
    {
        vtol setscriptablepartstate( #"doors", #"open" );
    }
    
    vtol setscriptablepartstate( #"landing_gear", #"down" );
    vtol setneargoalnotifydist( 100 );
    vtol thread function_58d4ddb498e494ae( { #angles:targetangle, #origin:targetlocation } );
    vtol thread function_ded1f3fe1967bccb();
    vtol waittill( #"near_goal" );
    
    if ( self.vehicleblocker )
    {
        self.vehicleblocker.origin = self.origin;
        self.vehicleblocker.angles = self.angles;
    }
    
    vtol setscriptablepartstate( #"hash_6db0031fd1e8d129", #"open" );
    playsoundatpos( vtol.origin + ( 0, 0, 15 ), #"hash_96022d8ebda73f5a" );
    wait 3;
    vtol.canexfil = 1;
    vtol setscriptablepartstate( #"engine", #"on_main" );
    
    if ( door function_8a09ef6f4b91eb5d() )
    {
        func_build = vtol.navmeshsettings.var_ad801995e84e31ae ?? &function_d87b8abe983d8b3c;
        var_8d423848a1600df0 = vtol [[ func_build ]]();
        vtol exfil::function_8ae9818165e25a9c( var_8d423848a1600df0 );
    }
    
    if ( door function_3d45358b15a889e4() )
    {
        vtol function_fdc2f0d287a9abc4();
    }
    
    vtol notify( #"vehicle_parked" );
    vtol.islanded = 1;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x9432d923, Offset: 0xdc38
// Size: 0xd1
function private function_5834d41ef8114db8()
{
    vtol = self;
    a_players = getplayersinradius( vtol.origin + ( 0, 0, -125 ), 300 );
    
    foreach ( player in a_players )
    {
        v_dir = vectornormalize2( player.origin - vtol.origin );
        player knockback( v_dir, 2000, 0 );
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xcf423132, Offset: 0xdd11
// Size: 0x3aa
function private function_65faa6ea05f0c11e( target_location )
{
    vtol = self;
    
    foreach ( push_check in vtol.var_8726d0249a96d9d9 )
    {
        push_check.origin = coordtransform( push_check.offset, vtol.origin, vtol.angles );
    }
    
    a_players = getplayersinradius( vtol.origin + ( 0, 0, -125 ), 1000 );
    
    /#
        if ( getdvarint( @"hash_d45cefb383219de5", 0 ) )
        {
            debug::sphere( vtol.origin + ( 0, 0, -125 ), 600, ( 1, 0, 0 ), 0.1 );
            
            foreach ( push_check in vtol.var_8726d0249a96d9d9 )
            {
                debug::cylinder( push_check.origin, push_check.origin - ( 0, 0, push_check.height ), push_check.radius, ( 0, 1, 0 ), 0.1 );
            }
        }
    #/
    
    foreach ( player in a_players )
    {
        if ( !isalive( player ) || player.sessionstate != "playing" )
        {
            continue;
        }
        
        foreach ( push_check in vtol.var_8726d0249a96d9d9 )
        {
            dist_sqr = distance2dsquared( player.origin, push_check.origin );
            top_check = player.origin[ 2 ] <= push_check.origin[ 2 ];
            bottom_check = player.origin[ 2 ] >= push_check.origin[ 2 ] - push_check.height;
            
            if ( top_check && bottom_check && dist_sqr <= push_check.radius * push_check.radius )
            {
                v_dir = vectornormalize2( player.origin - vtol.origin );
                player knockback( v_dir, 1500, 0 );
                break;
            }
        }
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0xcc655903, Offset: 0xe0c3
// Size: 0x7b
function private function_58d4ddb498e494ae( target_location )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    vtol = self;
    var_9c6889d14bb2c961 = !isdefined( vtol.var_8726d0249a96d9d9 );
    
    while ( !vtol.canexfil )
    {
        if ( var_9c6889d14bb2c961 )
        {
            vtol function_5834d41ef8114db8();
        }
        else
        {
            vtol function_65faa6ea05f0c11e( target_location );
        }
        
        wait 0.1;
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xb175300a, Offset: 0xe146
// Size: 0x53
function private function_ded1f3fe1967bccb()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.vehicleblocker = utility::spawn_model( %"sat_gameplay_collision_for_vehicle", self.origin, self.angles );
    self.vehicleblocker linkto( self );
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x3578d0e, Offset: 0xe1a1
// Size: 0x19b
function private function_3e2eda1dc6c29681()
{
    door = self;
    vtol = door.escapevehicle;
    vtol notify( #"hash_915a90e39b3f6b5a" );
    vtol playsoundonmovingent( #"hash_4d597aa8b038251a" );
    targetlocation = door.origin + ( 0, 0, 1000 );
    
    if ( door function_8a09ef6f4b91eb5d() )
    {
        vtol thread exfil::function_2cb1277f20ee1f9f( undefined );
        b_transfer = vtol.navmeshsettings.var_d77476e4230097f7 ?? 0;
        vtol exfil::function_e375225728c23ec9( b_transfer );
    }
    
    vtol function_f40905d3563194d2();
    vtol setscriptablepartstate( #"engine", #"on_main" );
    vtol function_d2b8ee2e1275daaf( 1 );
    wait 5;
    
    if ( self.var_c990964cb2f53594 )
    {
        vtol setscriptablepartstate( #"doors", #"closed" );
    }
    
    vtol notify( #"hash_77168d94c2755d4a" );
    door function_132940809d0c095d( door.nearbyplayers );
    vtol thread function_a85e95d446802804();
    vtol thread function_e50aaea4d7c56fe9();
    vtol thread exfil::function_25ebbe6e8a21f6b8();
    vtol setvehgoalpos( targetlocation );
    vtol sethoverparams( 50, 25, 25 );
    vtol setneargoalnotifydist( 150 );
    vtol waittill( #"near_goal" );
    vtol cleargoalyaw();
    vtol cleartargetyaw();
    vtol setscriptablepartstate( #"landing_gear", #"up" );
    vtol.islanded = 0;
    wait 0.5;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x49c53469, Offset: 0xe344
// Size: 0xa0
function private function_e50aaea4d7c56fe9()
{
    foreach ( player in level.players )
    {
        var_a0768b85b7d3965d = function_a8ed7f4bb436e7a0( player );
        
        if ( var_a0768b85b7d3965d )
        {
            level.var_6ccf11392270179e[ level.var_6ccf11392270179e.size ] = player;
        }
    }
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x800de147, Offset: 0xe3ec
// Size: 0x247
function private function_cbfcc1fd7d9ea20a()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    door = self;
    vtol = door.escapevehicle;
    vtol.var_841ac822880e1d5a = 1;
    vspeed = 35;
    vaccel = 15;
    targetescape = door.abandoned ? vtol.origin + ( 3000, 0, 2000 ) : door.origin + ( 3000, 0, 4000 );
    var_14fa052a95136bb6 = targetescape + ( 3000, 0, 6000 );
    vtol vehicle_helisetai( targetescape, vspeed, vaccel, vaccel, 1, 1, 0, 0, 0, 0, 0, 0, 0 );
    vtol setscriptablepartstate( #"engine", #"on_all", 0 );
    vtol setscriptablepartstate( #"flaps", #"off", 0 );
    vtol setneargoalnotifydist( 100 );
    vtol waittill( #"near_goal" );
    vtol vehicle_helisetai( var_14fa052a95136bb6, vspeed * 1.5, vaccel * 1.5, vaccel * 1.5, 1, 1, 0, 0, 0, 1, 0, 0, 1 );
    door thread function_695da650459bccc0();
    vtol setscriptablepartstate( #"engine", #"booster", 0 );
    vtol setscriptablepartstate( #"hash_6db0031fd1e8d129", #"closed" );
    vtol setneargoalnotifydist( 1000 );
    vtol waittill( #"near_goal" );
    vtol setscriptablepartstate( #"vehicle_active_camo_fx", #"camo_fx_activate", 0 );
    vtol setscriptablepartstate( #"engine", #"off", 0 );
    vtol setscriptablepartstate( #"blinking_lights", #"off", 0 );
    
    if ( vtol.var_dc64ea91291dad76 )
    {
        vtol.var_dc64ea91291dad76 hide();
    }
    
    vtol setneargoalnotifydist( 400 );
    vtol waittill( #"near_goal" );
    door notify( #"door_used_up" );
    level thread exfil_vehicle_delete( vtol );
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x189ff44c, Offset: 0xe63b
// Size: 0xf7
function private exfil_vehicle_delete( vehicle )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( vehicle ) || vehicle.is_deleting )
    {
        return;
    }
    
    vehicle.is_deleting = 1;
    vehicle exfil::function_25ebbe6e8a21f6b8();
    vehicle function_f40905d3563194d2();
    
    if ( vehicle.var_fa5c4117855bfaf7 )
    {
        trigger::cleanup_enter_exit_trigger( vehicle.var_fa5c4117855bfaf7, 1 );
        vehicle.var_fa5c4117855bfaf7 delete();
    }
    
    if ( vehicle.var_2164fe73eb509331 )
    {
        trigger::cleanup_enter_exit_trigger( vehicle.var_2164fe73eb509331, 1 );
        vehicle.var_2164fe73eb509331 delete();
    }
    
    vehicle.dontspawnhusk = 1;
    vehicle.var_dc64ea91291dad76 delete();
    vehicle::death( vehicle );
    
    if ( level.exfildoors.var_50dc848530b474de )
    {
        vehicle_tracking::reserve_vehicle();
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x75d42486, Offset: 0xe73a
// Size: 0x73
function private function_2f2b9ae9cc19460a( player )
{
    vtol = self;
    var_a0768b85b7d3965d = vehicle_occupancy::function_dbf7952d671b64c( player, vtol );
    
    if ( !var_a0768b85b7d3965d )
    {
        playerplatformparent = player getmovingplatformparent();
        var_a0768b85b7d3965d = playerplatformparent.parent == vtol;
    }
    
    if ( var_a0768b85b7d3965d && vtol.has_interior )
    {
        var_a0768b85b7d3965d = vtol function_a8ed7f4bb436e7a0( player );
    }
    
    return var_a0768b85b7d3965d;
}

// Namespace ob_exfil_door
// Params 1
// Checksum 0xb3f90530, Offset: 0xe7b6
// Size: 0x7a
function function_a8ed7f4bb436e7a0( player )
{
    vtol = self;
    
    if ( vtol.has_interior && isdefined( vtol.var_fa5c4117855bfaf7 ) && isdefined( vtol.var_fa5c4117855bfaf7.triggerenterents ) )
    {
        playerid = player getentitynumber();
        return isdefined( vtol.var_fa5c4117855bfaf7.triggerenterents[ playerid ] );
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x357c2adf, Offset: 0xe838
// Size: 0x10a
function private function_5464d0847045dc73( origin )
{
    transform = coordtransformtranspose( origin, self.origin, self.angles );
    var_623dcede971438fd = math::function_47d0ed373b25c699( transform, ( -390, -65, -170 ), ( 170, 65, -45 ) );
    
    /#
        if ( getdvarint( @"hash_91fe5f6c46bb1571", 0 ) == 1 )
        {
            aabb_min = ( -390, -65, -170 );
            aabb_max = ( 170, 65, -45 );
            aabb_half_size = ( aabb_max - aabb_min ) * 0.5;
            aabb_offset = ( aabb_min + aabb_max ) * 0.5;
            aabb_offset = coordtransform( aabb_offset, self.origin, self.angles );
            debug::function_76204bee46fa39fd( aabb_offset, aabb_half_size, self.angles, 0.2, ( 1, 0, 0 ) );
        }
    #/
    
    return var_623dcede971438fd;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0x55a13463, Offset: 0xe94b
// Size: 0x159
function private function_695da650459bccc0()
{
    level endon( #"game_ended" );
    self.escapevehicle endon( #"death" );
    door = self;
    vtol = door.escapevehicle;
    playersescaped = [];
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            var_a0768b85b7d3965d = vtol function_a8ed7f4bb436e7a0( player );
            var_ed8b0e6d3d98aca8 = arraycontains( playersescaped, player );
            
            if ( !var_ed8b0e6d3d98aca8 && var_a0768b85b7d3965d )
            {
                canexfil = vtol.canexfil && !player.isjuggernaut;
                
                if ( canexfil )
                {
                    playersescaped[ playersescaped.size ] = player;
                    door usedoor( player );
                    continue;
                }
                
                player setorigin( vtol.origin + ( 0, 0, -200 ) );
            }
        }
        
        wait 0.2;
    }
}

// Namespace ob_exfil_door
// Params 3, eflags: 0x4
// Checksum 0x363e0aaa, Offset: 0xeaac
// Size: 0xe4
function private function_d7b4b95f667bee27( location, radius, count )
{
    if ( count < 2 )
    {
        return location;
    }
    
    stepsize = 6.28318 * radius / count;
    var_30fa81e0a811cbf5 = plotcircle( location, radius, stepsize );
    highestpoint = ( 0, 0, -10000 );
    
    foreach ( vert in var_30fa81e0a811cbf5 )
    {
        if ( vert[ 2 ] > highestpoint[ 2 ] )
        {
            highestpoint = vert;
        }
    }
    
    return highestpoint;
}

// Namespace ob_exfil_door
// Params 0, eflags: 0x4
// Checksum 0xfd9d80d1, Offset: 0xeb99
// Size: 0xb8
function private function_9d597b8ae4e8c1a7()
{
    door = self;
    var_4a1e4cdbe9485a48 = vectornormalize( ( 0, 0, door.origin[ 2 ] ) - door.origin );
    spawnlocation = door.origin + var_4a1e4cdbe9485a48 * 10000 + ( 0, 0, 8000 );
    spawnangle = ( 0, 0, 0 );
    door.escapevehicle = function_17fa59bd27909396( spawnlocation, spawnangle );
    waitframe();
    door function_75928ee6f4d0de21();
    door function_931ccc9722ea96fa();
    door function_3e2eda1dc6c29681();
    wait 2;
    door function_cbfcc1fd7d9ea20a();
}

// Namespace ob_exfil_door
// Params 1
// Checksum 0xff558c3, Offset: 0xec59
// Size: 0xb2
function function_4c8ac0dbd10c57( str_name )
{
    exfils = 0;
    
    foreach ( s_exfil in level.exfilspawnpoints )
    {
        if ( s_exfil.name == str_name )
        {
            return s_exfil;
        }
        else if ( "Exfil_" + exfils == str_name )
        {
            return s_exfil;
        }
        
        exfils++;
    }
}

// Namespace ob_exfil_door
// Params 1, eflags: 0x4
// Checksum 0x2a1f1b01, Offset: 0xed13
// Size: 0x158
function private function_9e5873c0f4ce074( params )
{
    door = function_4c8ac0dbd10c57( params[ 0 ] );
    var_4a1e4cdbe9485a48 = vectornormalize( ( 0, 0, door.origin[ 2 ] ) - door.origin );
    spawnlocation = door.origin + var_4a1e4cdbe9485a48 * 10000 + ( 0, 0, 8000 );
    spawnangle = ( 0, 0, 0 );
    
    foreach ( player in level.players )
    {
        player setorigin( door.origin + ( 50, 50, 100 ) );
    }
    
    door.escapevehicle = function_17fa59bd27909396( spawnlocation, spawnangle );
    waitframe();
    door function_75928ee6f4d0de21();
    door function_931ccc9722ea96fa();
    door function_3e2eda1dc6c29681();
    wait 2;
    door function_cbfcc1fd7d9ea20a();
}

