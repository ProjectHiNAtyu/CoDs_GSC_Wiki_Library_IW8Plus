// scripts\mp\zm\systems\zm_quest.gsc  (hash_0c1369b1abe9a0d1.gscc) (size: 113581 Bytes / 0x1bbad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd38baf3b (3549146939)
// size ...... 113581 (0x1bbad)
// includes .. 51  (offset: 0x1a8bd)
// strings ... 161 (offset: 0x1aa55)
// dev strs .. 111 (offset: 0x1b51d)
// exports ... 285 (offset: 0x1352d)
// cseg ...... 0xc8a + 0x128a3 (0x1352d)
// imports ... 508 (offset: 0x161b5)
// animtree1 . 0   (offset: 0x1bbad)
// animtree2 . 0   (offset: 0x1bbad)
#using script_162f01e3286930e2;
#using script_16ea1b94f0f381b3;
#using script_2693dc72a65ba196;
#using script_6f9701cc1b74444b;
#using script_735da1d84fa56eae;
#using script_ee205068c2d1e4d;
#using scripts\anim\utility;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\scriptable_group;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\powerups\nuke;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\playerlogic;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_exfil;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_interaction;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_quest;

// Namespace zm_quest
// Params 0, eflags: 0x5
// Checksum 0x6d0162ed, Offset: 0xca8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_quest", undefined, &init, undefined );
}

// Namespace zm_quest
// Params 0
// Checksum 0x168763b5, Offset: 0xcc9
// Size: 0x7ec
function init()
{
    if ( utility::flag( "zm_quest_initialized" ) )
    {
        return;
    }
    
    level.zm_quests = [];
    level.zm_quests_by_type = [];
    level.zm_quests_steps = [];
    level.var_fc0bd7abe0e47b86 = [];
    level.var_fa5888e13888b19e = vote_system_shared::register_vote_hud();
    level.var_bf3c2011b07eba63 = spawnstruct();
    level.var_bf3c2011b07eba63.players = [];
    level.var_bf3c2011b07eba63.global = spawnstruct();
    level.var_bf3c2011b07eba63.global.list = [];
    level.var_bf3c2011b07eba63.global.root = undefined;
    level.var_7dc4bd9a391322b0 = [];
    level.var_7dc4bd9a391322b0[ #"mainquest" ] = 1;
    level.var_7dc4bd9a391322b0[ #"sidequest" ] = 2;
    level.var_7dc4bd9a391322b0[ #"endgameevent" ] = 3;
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_c6e643be7fa46df1", &function_11b75e2232ce3d4 );
    level.zm_quests_by_type[ #"none" ] = [];
    level.zm_quests_by_type[ #"mainquest" ] = [];
    level.zm_quests_by_type[ #"papQuest" ] = [];
    level.zm_quests_by_type[ #"wwQuest" ] = [];
    level.zm_quests_by_type[ #"sidequest" ] = [];
    level.zm_quests_by_type[ #"wwuquest" ] = [];
    questlist = [];
    var_f7a05bce6abda33e = level.gametypebundle.var_b09c117eeaa192d4;
    
    if ( var_f7a05bce6abda33e && var_f7a05bce6abda33e != %"" )
    {
        var_b0faeb99b625bb62 = getscriptbundle( var_f7a05bce6abda33e );
        
        if ( var_b0faeb99b625bb62.questitems )
        {
            questlist = function_38769acd9eaa5d37( questlist, var_b0faeb99b625bb62.questitems );
        }
    }
    
    var_cd16a2e74383ea61 = getactivemapinfobundle();
    var_3bce12372a2ec65e = var_cd16a2e74383ea61.var_b09c117eeaa192d4;
    
    if ( isdefined( var_3bce12372a2ec65e ) && var_3bce12372a2ec65e != %"" )
    {
        var_b819821dcc9ee902 = getscriptbundle( var_3bce12372a2ec65e );
        
        if ( isdefined( var_b819821dcc9ee902.questitems ) )
        {
            questlist = function_38769acd9eaa5d37( questlist, var_b819821dcc9ee902.questitems );
        }
    }
    
    /#
        function_509752a4eed3d65b();
    #/
    
    foreach ( quest_struct in questlist )
    {
        if ( !isdefined( quest_struct.questitem ) )
        {
            continue;
        }
        
        quest_bundle = getscriptbundle( quest_struct.questitem );
        
        if ( !( isdefined( quest_bundle.ref ) && isdefined( quest_bundle.steps ) ) || isdefined( level.zm_quests[ quest_bundle.ref ] ) )
        {
            continue;
        }
        
        quest = {};
        quest.bundle = quest_struct.questitem;
        quest.ref = quest_bundle.ref;
        quest.type = quest_bundle.type;
        quest.global_index = level.zm_quests.size;
        quest.dont_save = istrue( quest_bundle.dontsave );
        quest.started = 0;
        quest.completed = 0;
        quest utility::ent_flag_clear( "zm_quest_completed" );
        quest.var_364f3d4bcc4bae91 = 0;
        quest.var_7be076c9078045aa = -1;
        quest.steps = [];
        quest.save_kvps = [];
        quest.var_3340892d836ba5a2 = istrue( quest_bundle.var_3e6b81b66c484d67 );
        quest.ui_priority = 1;
        
        if ( isdefined( quest_bundle.uipriority ) )
        {
            quest.ui_priority = level.var_7dc4bd9a391322b0[ quest_bundle.uipriority ];
        }
        
        quest.var_94c5b7d04e0c2501 = istrue( quest_bundle.hideui );
        quest.var_f932d7ebb6cec30e = 0;
        
        if ( quest_bundle.var_3d24445f6d644a43 && isdefined( level.directed_mode ) )
        {
            quest.var_94c5b7d04e0c2501 = !quest.var_94c5b7d04e0c2501;
        }
        
        quest.skip_splash = istrue( quest_bundle.var_f4ec16d7f40a032d );
        
        if ( quest_bundle.var_f932d7ebb6cec30e && game_utility::function_d68874417f3eea5c() )
        {
            quest.var_f932d7ebb6cec30e = 1;
            level.var_a74764204d9643c = 1;
            quest.skip_splash = 1;
        }
        
        level.zm_quests[ quest_bundle.ref ] = quest;
        level.zm_quests_steps[ quest_bundle.ref ] = [];
        level.zm_quests_by_type[ quest.type ][ level.zm_quests_by_type[ quest.type ].size ] = quest;
        step_index = 0;
        i = 0;
        
        while ( i < quest_bundle.steps.size )
        {
            bundle_quest_step = quest_bundle.steps[ i ];
            
            if ( isdefined( bundle_quest_step ) )
            {
                init_quest_step( bundle_quest_step, quest, step_index, undefined );
                step_index += 1;
            }
            
            i += 1;
        }
        
        /#
            function_6b4dc9f1f5413551( quest );
        #/
    }
    
    function_3c363613c60958f5( "zm_vote_active" );
    function_c96bc1e38a98d40b();
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( #"player_disconnect", &on_player_disconnect );
    level callback::add( "on_round_end", &on_round_end );
    level callback::add( #"zm_mq_quest_complete", &function_77f2932995dea67 );
    
    if ( !getdvarint( @"hash_ccef2121830537e5", 0 ) )
    {
        level callback::add( "zm_exfil_started", &on_exfil_started );
    }
    
    ui::lui_registercallback( "quest_ui_splash_ready", &quest_ui_splash_ready_callback );
    ui::lui_registercallback( "quest_ui_tracker_showing", &quest_ui_tracker_showing_callback );
    setdvarifuninitialized( @"hash_ec5ffe1a34b9c8a3", 1 );
    setdvarifuninitialized( @"scr_debug_enable_story_mode", 0 );
    setdvarifuninitialized( @"hash_24ce4359896128f", 1 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_99f702f8a47fa187", &function_c3c490f409120802 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"enable_guidance", &function_e38b6d374e95fda7 );
    utility::registersharedfunc( #"zombie", #"hash_7a41dc50abbdc8bf", &function_eb3a5a6c3f4f3ba6 );
    utility::registersharedfunc( #"zombie", #"hash_b02bf237a5e905cd", &function_b94186b3fb991490 );
    utility::registersharedfunc( #"zombie", #"hash_cddf053c89de9cd1", &function_e4eb2d1c1bd8fc4e );
    level.var_ac69b2dd43dca6f8 = namespace_db949aa4357455dc::register();
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x33>", "<dev string:x65>", &function_e5cb97271688832a );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7f>", "<dev string:xaa>", &function_e5cb97271688832a );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc4>", "<dev string:xe6>", &function_857c8ef819af350f );
        devgui::function_cd4e263c1f3018ae( "<dev string:xff>", "<dev string:x121>", &function_857c8ef819af350f );
        devgui::function_77df7fe7dd273e10();
    #/
    
    utility::flag_set( "zm_quest_initialized" );
}

// Namespace zm_quest
// Params 2, eflags: 0x40 variadic
// Checksum 0x37957b52, Offset: 0x14bd
// Size: 0xf9
function function_38769acd9eaa5d37( ... )
{
    array = [];
    
    foreach ( temparray in vararg )
    {
        foreach ( item in temparray )
        {
            array[ array.size ] = item;
        }
    }
    
    return array;
}

/#

    // Namespace zm_quest
    // Params 1, eflags: 0xc
    // Checksum 0x5417093, Offset: 0x15bf
    // Size: 0x88, Type: dev
    function private function_857c8ef819af350f( params )
    {
        self notify( #"hash_ab776d8240a78d8c" );
        self endon( #"hash_ab776d8240a78d8c" );
        utility::flag_wait( "<dev string:x13a>" );
        var_5fc9666ddf44b5a0 = function_9fb47da273dae94a();
        setdvar( @"hash_24ce4359896128f", int( params[ 0 ] ) );
        iprintlnbold( "<dev string:x14c>" + params[ 0 ] );
        wait 3;
        var_f8e901bebcdb4c05 = function_3477750f338de598( var_5fc9666ddf44b5a0, &"ZM_T10_QUARTZ/MISSION_COMPLETE_EXFIL", undefined, 0 );
    }

    // Namespace zm_quest
    // Params 0, eflags: 0x4
    // Checksum 0xf94c8a1b, Offset: 0x164f
    // Size: 0xa0, Type: dev
    function private function_9fb47da273dae94a()
    {
        var_5fc9666ddf44b5a0 = utility::getstruct( "<dev string:x193>", "<dev string:x1a6>" );
        
        if ( !isdefined( var_5fc9666ddf44b5a0 ) )
        {
            var_5fc9666ddf44b5a0 = utility::getstruct( "<dev string:x1b1>", "<dev string:x1a6>" );
        }
        
        if ( !isdefined( var_5fc9666ddf44b5a0 ) )
        {
            s_destination = utility::getstruct( "<dev string:x1cf>", "<dev string:x1e8>" );
        }
        
        if ( !isdefined( var_5fc9666ddf44b5a0 ) )
        {
            var_5fc9666ddf44b5a0 = { #angles:level.players[ 0 ].angles, #origin:level.players[ 0 ].origin };
        }
        
        return var_5fc9666ddf44b5a0;
    }

    // Namespace zm_quest
    // Params 1, eflags: 0xc
    // Checksum 0x341b165f, Offset: 0x16f7
    // Size: 0xac, Type: dev
    function private function_e5cb97271688832a( params )
    {
        self notify( #"hash_af776c2a2ab31383" );
        self endon( #"hash_af776c2a2ab31383" );
        utility::flag_wait( "<dev string:x13a>" );
        var_5fc9666ddf44b5a0 = utility::getstruct( "<dev string:x193>", "<dev string:x1a6>" );
        
        if ( !isdefined( var_5fc9666ddf44b5a0 ) )
        {
            var_5fc9666ddf44b5a0 = { #angles:level.players[ 0 ].angles, #origin:level.players[ 0 ].origin };
        }
        
        var_f8e901bebcdb4c05 = function_5df636f8e334ab81( var_5fc9666ddf44b5a0, int( params[ 0 ] ) );
    }

#/

// Namespace zm_quest
// Params 1
// Checksum 0xf82caa49, Offset: 0x17ab
// Size: 0x39
function on_round_end( params )
{
    level notify( #"on_round_end" );
    
    if ( !isdefined( level.var_e7a6c6acb4a24e2c ) )
    {
        level.var_e7a6c6acb4a24e2c = 1;
    }
    
    level.var_e7a6c6acb4a24e2c++;
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0xb52a76e6, Offset: 0x17ec
// Size: 0xc3
function private function_77f2932995dea67( params )
{
    main_quests = level.zm_quests_by_type[ #"mainquest" ];
    
    foreach ( quest in main_quests )
    {
        quest.var_66751ff7ae3ea95f = 1;
    }
    
    if ( zm_save::is_save_load_enabled() )
    {
        zm_save::save_session( 0 );
        
        if ( zm_save::is_autosave_enabled() )
        {
            zm_save::commit_session( 1 );
        }
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0xed6f3f2f, Offset: 0x18b7
// Size: 0x15
function on_exfil_started( params )
{
    function_e66ab24194b8627e( 1 );
}

// Namespace zm_quest
// Params 0
// Checksum 0x2a9571f6, Offset: 0x18d4
// Size: 0x22
function function_7f2616a7e45d747d()
{
    if ( !isdefined( level.var_e7a6c6acb4a24e2c ) )
    {
        level.var_e7a6c6acb4a24e2c = 1;
    }
    
    return level.var_e7a6c6acb4a24e2c;
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0xde6ae95b, Offset: 0x18ff
// Size: 0x21
function private on_player_connect( params )
{
    function_8fa317fbecf5f68d();
    function_abfda2143c855ed2();
    init_client_inventory_data();
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0xfa825c25, Offset: 0x1928
// Size: 0x13
function private on_player_disconnect( params )
{
    function_98a53764946505c7();
}

// Namespace zm_quest
// Params 4, eflags: 0x4
// Checksum 0x2f943ec1, Offset: 0x1943
// Size: 0x3dd
function private init_quest_step( bundle_quest_step, quest, step_index, var_d502348c16c8d691 )
{
    if ( !isdefined( bundle_quest_step.ref ) || isdefined( level.zm_quests_steps[ quest.ref ][ bundle_quest_step.ref ] ) )
    {
        return;
    }
    
    quest_step = {};
    quest_step.ref = bundle_quest_step.ref;
    quest_step.quest = quest;
    quest_step.index = step_index;
    quest_step.var_d502348c16c8d691 = var_d502348c16c8d691;
    quest_step.global_index = level.var_fc0bd7abe0e47b86.size;
    quest_step.steps = [];
    quest_step.var_54132625f1a1346f = [];
    quest_step.started = 0;
    quest_step.completed = 0;
    quest_step.b_skipped = 0;
    quest_step.b_save_restored = 0;
    quest_step.b_restarted = 0;
    quest_step.current_progress = 0;
    quest_step.var_cf684f09b6c37c3a = bundle_quest_step.var_be6e69352563f113;
    quest_step.start_time_limit = bundle_quest_step.var_c3f8bf26aa5d3b72;
    quest_step.linear_substeps = !bundle_quest_step.var_945d99e85bd0021;
    quest_step.var_94c5b7d04e0c2501 = bundle_quest_step.noui;
    quest_step.var_9f1a5c448531eb7a = bundle_quest_step.var_f1015dd5c62ab822;
    quest_step.skip_splash = bundle_quest_step.var_f4ec16d7f40a032d;
    quest_step.var_c51acbb2ef22425b = istrue( bundle_quest_step.var_f89c3b3743d9e1d7 );
    quest_step.ui_priority = quest.ui_priority;
    
    if ( bundle_quest_step.var_194b092f5ea914ae )
    {
        i = 0;
        
        while ( i < bundle_quest_step.var_194b092f5ea914ae.size )
        {
            data = bundle_quest_step.var_194b092f5ea914ae[ i ];
            
            if ( data )
            {
                if ( data.starttimelimit )
                {
                    quest_step.start_time_limit = data.starttimelimit;
                }
                
                if ( data.maxprogress )
                {
                    quest_step.var_cf684f09b6c37c3a = data.maxprogress;
                }
            }
            
            i += 1;
        }
    }
    
    if ( isdefined( var_d502348c16c8d691 ) )
    {
        var_d502348c16c8d691.steps[ var_d502348c16c8d691.steps.size ] = quest_step;
    }
    else
    {
        quest.steps[ quest.steps.size ] = quest_step;
    }
    
    level.zm_quests_steps[ quest.ref ][ bundle_quest_step.ref ] = quest_step;
    level.var_fc0bd7abe0e47b86[ level.var_fc0bd7abe0e47b86.size ] = { #step_ref:bundle_quest_step.ref, #quest_ref:quest.ref };
    
    if ( isdefined( bundle_quest_step.steps ) )
    {
        sub_step_index = 0;
        i = 0;
        
        while ( i < bundle_quest_step.steps.size )
        {
            var_12702fab4a8f126d = bundle_quest_step.steps[ i ];
            
            if ( isdefined( var_12702fab4a8f126d ) )
            {
                init_quest_step( var_12702fab4a8f126d, quest, sub_step_index, quest_step );
                sub_step_index += 1;
            }
            
            i += 1;
        }
    }
    
    if ( !quest_step.linear_substeps && isdefined( bundle_quest_step.var_a933ad0b636e6afc ) )
    {
        quest_step.substeps_required = bundle_quest_step.var_a933ad0b636e6afc;
        return;
    }
    
    quest_step.substeps_required = quest_step.steps.size;
}

// Namespace zm_quest
// Params 1
// Checksum 0x6a380a68, Offset: 0x1d28
// Size: 0x6e
function get_quest( quest_ref )
{
    assert( isxhash( quest_ref ) );
    assert( utility::flag( "<dev string:x1fa>" ), "<dev string:x20f>" );
    quest = level.zm_quests[ quest_ref ];
    
    if ( !isdefined( quest ) )
    {
        assertmsg( "<dev string:x23b>" + getxhashsourcename( quest_ref ) + "<dev string:x256>" );
        return;
    }
    
    return quest;
}

// Namespace zm_quest
// Params 1
// Checksum 0x765f81e4, Offset: 0x1d9f
// Size: 0x3e
function get_quest_relaxed( quest_ref )
{
    assert( isxhash( quest_ref ) );
    assert( utility::flag( "<dev string:x1fa>" ), "<dev string:x20f>" );
    return level.zm_quests[ quest_ref ];
}

// Namespace zm_quest
// Params 2
// Checksum 0xc7519d87, Offset: 0x1de6
// Size: 0xbe
function get_quest_step( quest_ref, step_ref )
{
    assert( isxhash( quest_ref ) && isxhash( step_ref ) );
    assert( utility::flag( "<dev string:x1fa>" ), "<dev string:x20f>" );
    quest_steps = level.zm_quests_steps[ quest_ref ];
    
    if ( !isdefined( quest_steps ) )
    {
        assertmsg( "<dev string:x23b>" + getxhashsourcename( quest_ref ) + "<dev string:x256>" );
        return;
    }
    
    quest_step = quest_steps[ step_ref ];
    
    if ( !isdefined( quest_step ) )
    {
        assertmsg( "<dev string:x259>" + getxhashsourcename( step_ref ) + "<dev string:x273>" + getxhashsourcename( quest_ref ) + "<dev string:x256>" );
        return;
    }
    
    return quest_step;
}

// Namespace zm_quest
// Params 2
// Checksum 0xbf5e96d2, Offset: 0x1ead
// Size: 0x68
function get_quest_step_relaxed( quest_ref, step_ref )
{
    assert( isxhash( quest_ref ) && isxhash( step_ref ) );
    assert( utility::flag( "<dev string:x1fa>" ), "<dev string:x20f>" );
    quest_steps = level.zm_quests_steps[ quest_ref ];
    
    if ( isdefined( quest_steps ) )
    {
        return quest_steps[ step_ref ];
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0x5211aab7, Offset: 0x1f1e
// Size: 0x8a
function register_quest_step( quest_ref, step_ref, setup_func, cleanup_func )
{
    assert( !isdefined( setup_func ) || isfunction( setup_func ) );
    assert( !isdefined( cleanup_func ) || isfunction( cleanup_func ) );
    quest_step = get_quest_step( quest_ref, step_ref );
    
    if ( isdefined( quest_step ) )
    {
        quest_step.setup_func = setup_func;
        quest_step.cleanup_func = cleanup_func;
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x3e6b4dc0, Offset: 0x1fb0
// Size: 0x53
function function_3c363613c60958f5( flag )
{
    if ( !isdefined( level.var_dada1106e11830fd ) )
    {
        level.var_dada1106e11830fd = [];
    }
    
    if ( isdefined( flag ) && !arraycontains( level.var_dada1106e11830fd, flag ) )
    {
        level.var_dada1106e11830fd[ level.var_dada1106e11830fd.size ] = flag;
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x11384eea, Offset: 0x200b
// Size: 0x53
function function_7fb356c0028d0a64( flag )
{
    if ( !isdefined( level.var_dada1106e11830fd ) )
    {
        level.var_dada1106e11830fd = [];
    }
    
    if ( isdefined( flag ) && arraycontains( level.var_dada1106e11830fd, flag ) )
    {
        level.var_dada1106e11830fd = arrayremove( level.var_dada1106e11830fd, flag );
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0x4ad840d4, Offset: 0x2066
// Size: 0xd2, Type: bool
function function_f98968f17772726c( var_5465e4887fca9c32, var_8d948fdf6e1f5b10 )
{
    if ( !isdefined( level.var_dada1106e11830fd ) )
    {
        level.var_dada1106e11830fd = [];
    }
    
    foreach ( flag in level.var_dada1106e11830fd )
    {
        if ( var_5465e4887fca9c32 && flag == "special_round_is_ongoing" )
        {
            continue;
        }
        
        if ( isdefined( var_8d948fdf6e1f5b10 ) && arraycontains( var_8d948fdf6e1f5b10, flag ) )
        {
            continue;
        }
        
        if ( utility::flag( flag ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_quest
// Params 1
// Checksum 0xa36927ec, Offset: 0x2141
// Size: 0x1e4
function start_quest( quest_ref )
{
    level endon( #"game_ended" );
    quest = get_quest( quest_ref );
    
    if ( !isdefined( quest ) )
    {
        return;
    }
    
    if ( quest.started || quest.completed )
    {
        return;
    }
    
    quest endon( #"zm_quest_restarted" );
    
    /#
        var_8abd4b17a47441a9 = getdvar( @"scr_skip_to_step", "<dev string:x285>" );
        
        if ( var_8abd4b17a47441a9 != "<dev string:x285>" )
        {
            thread zm_utility::open_sesame();
            function_9c25cc085d998528( quest_ref, getxhash( var_8abd4b17a47441a9 ) );
            return;
        }
    #/
    
    quest.started = 1;
    quest.var_7be076c9078045aa = 0;
    
    while ( quest.var_7be076c9078045aa < quest.steps.size )
    {
        function_50af5653142f727e( quest, quest.steps[ quest.var_7be076c9078045aa ] );
        quest.var_7be076c9078045aa += 1;
    }
    
    quest.completed = 1;
    quest notify( #"zm_quest_completed" );
    quest utility::ent_flag_set( "zm_quest_completed" );
    last_quest_step = quest.steps[ quest.steps.size - 1 ];
    
    if ( !function_69122a4776ff975e( quest.ref, last_quest_step.ref ) )
    {
        function_fba942a1cfd85f5d( 1, 1, quest.ref, last_quest_step.ref );
        function_fb3af5600f6a9441( 4, 1, quest.ref, last_quest_step.ref );
        waitframe();
        function_fba942a1cfd85f5d( 0, 1, quest.ref, last_quest_step.ref );
    }
}

// Namespace zm_quest
// Params 5
// Checksum 0x1bf4639, Offset: 0x232d
// Size: 0x272
function function_9c25cc085d998528( quest_ref, step_ref, completed_substeps = [], save_restored = 0, restarted )
{
    target_quest_step = get_quest_step( quest_ref, step_ref );
    
    if ( !isdefined( target_quest_step ) )
    {
        return;
    }
    
    if ( isdefined( target_quest_step.var_d502348c16c8d691 ) && !target_quest_step.var_d502348c16c8d691.linear_substeps )
    {
        assertmsg( "<dev string:x286>" + getxhashsourcename( quest_ref ) + "<dev string:x2b1>" + getxhashsourcename( step_ref ) + "<dev string:x2c1>" + getxhashsourcename( target_quest_step.var_d502348c16c8d691.ref ) + "<dev string:x2ee>" );
        return;
    }
    
    quest = target_quest_step.quest;
    
    if ( quest.started )
    {
        assertmsg( "<dev string:x373>" + getxhashsourcename( quest_ref ) + "<dev string:x256>" );
        return;
    }
    
    for ( current_quest_step = target_quest_step; isdefined( current_quest_step.var_d502348c16c8d691 ) ; current_quest_step = current_quest_step.var_d502348c16c8d691 )
    {
        i = 0;
        
        while ( i < current_quest_step.index )
        {
            function_e65609834444650c( current_quest_step.var_d502348c16c8d691.steps[ i ], save_restored );
            i += 1;
        }
    }
    
    i = 0;
    
    while ( i < current_quest_step.index )
    {
        function_e65609834444650c( quest.steps[ i ], save_restored );
        i += 1;
    }
    
    if ( completed_substeps.size > 0 && !target_quest_step.linear_substeps && target_quest_step.steps.size > 0 )
    {
        foreach ( sub_step in target_quest_step.steps )
        {
            if ( arraycontains( completed_substeps, sub_step.ref ) )
            {
                function_e65609834444650c( sub_step, save_restored );
            }
        }
    }
    
    start_quest( quest_ref );
}

// Namespace zm_quest
// Params 1
// Checksum 0x8dfce7b3, Offset: 0x25a7
// Size: 0xec
function quit_quest( quest_ref )
{
    quest = get_quest( quest_ref );
    
    if ( !isdefined( quest ) || !quest.started || quest.completed || quest.var_364f3d4bcc4bae91 )
    {
        return;
    }
    
    quest notify( #"zm_quest_quit" );
    var_7be076c9078045aa = quest.steps[ quest.var_7be076c9078045aa ];
    
    if ( !function_69122a4776ff975e( quest_ref, var_7be076c9078045aa.ref ) )
    {
        function_fba942a1cfd85f5d( 1, 1, quest_ref, var_7be076c9078045aa.ref );
        function_fb3af5600f6a9441( 3, 1, quest_ref, var_7be076c9078045aa.ref );
        waitframe();
        function_fba942a1cfd85f5d( 0, 1, quest.ref, var_7be076c9078045aa.ref );
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0x9632d2e9, Offset: 0x269b
// Size: 0x60
function restart_quest( quest_ref, var_4f47e65cca7b41b5 )
{
    quest = get_quest( quest_ref );
    
    if ( !isdefined( quest ) )
    {
        return;
    }
    
    if ( quest.started )
    {
        quest notify( #"zm_quest_restarted" );
        waitframe();
        reset_quest( quest, var_4f47e65cca7b41b5 );
    }
    
    thread start_quest( quest_ref );
}

// Namespace zm_quest
// Params 3
// Checksum 0xcb13a069, Offset: 0x2703
// Size: 0x6d
function function_80abdea0cd4c89a7( quest_ref, step_ref, completed_substeps )
{
    quest = get_quest( quest_ref );
    
    if ( !isdefined( quest ) )
    {
        return;
    }
    
    if ( quest.started )
    {
        quest notify( #"zm_quest_restarted" );
        waitframe();
        reset_quest( quest );
    }
    
    thread function_9c25cc085d998528( quest_ref, step_ref, completed_substeps, undefined, 1 );
}

// Namespace zm_quest
// Params 3
// Checksum 0x72415bdf, Offset: 0x2778
// Size: 0x99
function function_4eefe6de31f5ddab( quest_ref, key, value )
{
    assert( isxhash( key ) && isint( value ) );
    quest = get_quest( quest_ref );
    
    if ( !isdefined( quest ) )
    {
        return;
    }
    
    if ( !isdefined( quest.save_kvps[ key ] ) && quest.save_kvps.size == 16 )
    {
        assertmsg( "<dev string:x3ae>" + quest_ref );
        return;
    }
    
    quest.save_kvps[ key ] = value;
}

// Namespace zm_quest
// Params 2
// Checksum 0xc1a21e88, Offset: 0x2819
// Size: 0x61
function function_73720cdf21c3cfd7( quest_ref, key )
{
    assert( isxhash( key ) );
    quest = get_quest( quest_ref );
    
    if ( !isdefined( quest ) )
    {
        return;
    }
    
    if ( !isdefined( quest.save_kvps[ key ] ) )
    {
        return;
    }
    
    return quest.save_kvps[ key ];
}

// Namespace zm_quest
// Params 3
// Checksum 0xb09e07d8, Offset: 0x2883
// Size: 0x83
function function_e6efb222fcbc8b5c( quest_ref, key, increment = 1 )
{
    assert( isxhash( key ) );
    assert( isint( increment ) );
    quest = get_quest( quest_ref );
    
    if ( !isdefined( quest ) )
    {
        return;
    }
    
    quest.save_kvps[ key ] = ( quest.save_kvps[ key ] ?? 0 ) + increment;
}

// Namespace zm_quest
// Params 2
// Checksum 0x87891836, Offset: 0x290e
// Size: 0xd8
function function_6265be8d0549e1b1( quest_ref, key_to_remove )
{
    assert( isxhash( key_to_remove ) );
    quest = get_quest( quest_ref );
    
    if ( !isdefined( quest ) )
    {
        return;
    }
    
    newarray = [];
    
    foreach ( key, integer in quest.save_kvps )
    {
        if ( key_to_remove == key )
        {
            continue;
        }
        
        newarray[ key ] = integer;
    }
    
    quest.save_kvps = newarray;
}

// Namespace zm_quest
// Params 1
// Checksum 0x9da676a4, Offset: 0x29ee
// Size: 0x2b
function is_quest_complete( quest_ref )
{
    quest = get_quest( quest_ref );
    return quest.completed;
}

// Namespace zm_quest
// Params 1
// Checksum 0x131e0020, Offset: 0x2a22
// Size: 0x9f
function function_28476b8b9f7c812f( var_e83e4364c364f4bf )
{
    foreach ( quest_ref in var_e83e4364c364f4bf )
    {
        quest = get_quest( quest_ref );
        
        if ( !isdefined( quest ) )
        {
            continue;
        }
        
        quest utility::ent_flag_wait( "zm_quest_completed" );
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0xbabe14fe, Offset: 0x2ac9
// Size: 0x35
function is_quest_step_complete( quest_ref, step_ref )
{
    quest_step = get_quest_step( quest_ref, step_ref );
    return quest_step.completed;
}

// Namespace zm_quest
// Params 1
// Checksum 0x22b1f52a, Offset: 0x2b07
// Size: 0xd7
function function_6c9f82781275fd8a( quest_type )
{
    if ( !utility::flag( "zm_quest_initialized" ) )
    {
        return 0;
    }
    
    assert( isdefined( level.zm_quests_by_type[ quest_type ] ), "<dev string:x3ef>" );
    completed = 1;
    
    foreach ( quest in level.zm_quests_by_type[ quest_type ] )
    {
        if ( !quest.dont_save )
        {
            completed &= quest.completed;
        }
    }
    
    return completed;
}

// Namespace zm_quest
// Params 1
// Checksum 0x9d80c5a4, Offset: 0x2be7
// Size: 0xc7
function function_d3e416cf1ef9e891( quest_type )
{
    if ( !utility::flag( "zm_quest_initialized" ) )
    {
        return 0;
    }
    
    assert( isdefined( level.zm_quests_by_type[ quest_type ] ), "<dev string:x3ef>" );
    completed = 0;
    
    foreach ( quest in level.zm_quests_by_type[ quest_type ] )
    {
        completed |= quest.completed;
    }
    
    return completed;
}

// Namespace zm_quest
// Params 0
// Checksum 0xc5d5c701, Offset: 0x2cb7
// Size: 0x11
function is_main_quest_complete()
{
    return function_6c9f82781275fd8a( #"mainquest" );
}

// Namespace zm_quest
// Params 0
// Checksum 0xbbedb206, Offset: 0x2cd1
// Size: 0x11
function is_pap_quest_complete()
{
    return function_6c9f82781275fd8a( #"papQuest" );
}

// Namespace zm_quest
// Params 0
// Checksum 0x90c6bd2a, Offset: 0x2ceb
// Size: 0x11
function is_ww_quest_complete()
{
    return function_6c9f82781275fd8a( #"wwQuest" );
}

// Namespace zm_quest
// Params 0
// Checksum 0xa9ac3795, Offset: 0x2d05
// Size: 0x15
function get_all_side_quests()
{
    return level.zm_quests_by_type[ #"sidequest" ];
}

// Namespace zm_quest
// Params 3
// Checksum 0x672a4d48, Offset: 0x2d23
// Size: 0xaa
function function_e65609834444650c( step, save_restored, skipped = 1 )
{
    if ( step.completed )
    {
        return;
    }
    
    step.b_skipped = istrue( skipped );
    step.b_save_restored = istrue( save_restored );
    step.completed = 1;
    step notify( #"hash_2c4eefaf7e2b24b6" );
    
    for ( i = 0; i < step.steps.size ; i++ )
    {
        function_e65609834444650c( step.steps[ i ], save_restored );
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0x38f567ee, Offset: 0x2dd5
// Size: 0xb0
function function_fce1c478766746db()
{
    if ( !utility::flag( "zm_quest_initialized" ) )
    {
        return "";
    }
    
    foreach ( quest in level.zm_quests_by_type[ #"wwuquest" ] )
    {
        if ( quest.completed )
        {
            return quest.ref;
        }
    }
    
    return "";
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0x5c4a8e22, Offset: 0x2e8e
// Size: 0x5cb
function private function_50af5653142f727e( quest, var_7be076c9078045aa )
{
    level endon( #"game_ended" );
    quest endon( #"zm_quest_restarted" );
    quest endon( #"zm_quest_quit" );
    var_d502348c16c8d691 = var_7be076c9078045aa.var_d502348c16c8d691;
    
    if ( var_d502348c16c8d691.linear_substeps && var_7be076c9078045aa.index > 0 )
    {
        var_9b69f851734acea6 = var_d502348c16c8d691.steps[ var_7be076c9078045aa.index - 1 ];
        
        if ( !var_9b69f851734acea6.completed )
        {
            function_8f14128dc4232902( quest, var_9b69f851734acea6 );
        }
        
        if ( quest.completed || quest.var_364f3d4bcc4bae91 )
        {
            return;
        }
    }
    
    var_7be076c9078045aa.started = 1;
    
    if ( quest.type == #"mainquest" )
    {
        level callback::callback( #"hash_5d197f6c9b862419", { #var_10b9a2bce841a5f2:var_7be076c9078045aa.ref, #var_544dc6c47711ac4a:quest.ref } );
    }
    
    if ( !var_7be076c9078045aa.b_skipped && !function_69122a4776ff975e( quest.ref, var_7be076c9078045aa.ref ) )
    {
        foreach ( player in level.players )
        {
            prioritystep = player function_6029a1fbca9c133d();
            
            if ( prioritystep )
            {
                var_a961ce164c7f7080 = prioritystep.quest_ref == quest.ref && prioritystep.step_ref == var_7be076c9078045aa.ref;
                
                if ( !var_a961ce164c7f7080 )
                {
                    continue;
                }
            }
            
            player function_e66ab24194b8627e();
        }
        
        waitframe();
        function_fba942a1cfd85f5d( 1, 1, quest.ref, var_7be076c9078045aa.ref );
        
        if ( isdefined( var_d502348c16c8d691 ) )
        {
            function_fb3af5600f6a9441( 1, 1, quest.ref, var_7be076c9078045aa.ref );
        }
        else
        {
            function_fb3af5600f6a9441( 2, 1, quest.ref, var_7be076c9078045aa.ref );
        }
        
        if ( !function_8e570ed3ac04e96( quest.ref, var_7be076c9078045aa.ref ) )
        {
            function_2d6f8f354bd50452( quest, var_7be076c9078045aa );
        }
    }
    
    childthread function_a2d695360c41f5f7( quest, var_7be076c9078045aa );
    
    if ( !quest.var_364f3d4bcc4bae91 && !var_7be076c9078045aa.completed && !var_7be076c9078045aa.var_e314f32f9ed4335 )
    {
        function_def6f08b07a6e264( quest, var_7be076c9078045aa );
    }
    
    if ( var_7be076c9078045aa.steps.size > 0 )
    {
        i = 0;
        
        while ( i < var_7be076c9078045aa.steps.size )
        {
            thread function_50af5653142f727e( quest, var_7be076c9078045aa.steps[ i ] );
            i += 1;
        }
    }
    else
    {
        if ( !function_69122a4776ff975e( quest.ref, var_7be076c9078045aa.ref ) )
        {
            function_fba942a1cfd85f5d( 0, 1, quest.ref, var_7be076c9078045aa.ref );
        }
        
        var_7be076c9078045aa.completed = 1;
        var_7be076c9078045aa notify( #"hash_2c4eefaf7e2b24b6" );
    }
    
    if ( !quest.var_364f3d4bcc4bae91 && !var_7be076c9078045aa.completed )
    {
        function_8f14128dc4232902( quest, var_7be076c9078045aa );
    }
    
    /#
        iprintlnbold( "<dev string:x402>" + getxhashsourcename( var_7be076c9078045aa.ref ) + "<dev string:x413>" + getxhashsourcename( quest.ref ) + "<dev string:x256>" );
    #/
    
    if ( quest.type == #"mainquest" && !quest.var_364f3d4bcc4bae91 )
    {
        level callback::callback( #"zm_mq_step_complete", { #var_10b9a2bce841a5f2:var_7be076c9078045aa.ref, #var_544dc6c47711ac4a:quest.ref } );
    }
    
    if ( isdefined( var_7be076c9078045aa.cleanup_func ) )
    {
        if ( getcodegate( #"hash_74248fa51bc2587" ) && var_7be076c9078045aa.b_save_restored )
        {
            profilestart();
            var_7be076c9078045aa [[ var_7be076c9078045aa.cleanup_func ]]( var_7be076c9078045aa.b_skipped, var_7be076c9078045aa.b_save_restored );
            profilestop();
        }
        else
        {
            var_7be076c9078045aa [[ var_7be076c9078045aa.cleanup_func ]]( var_7be076c9078045aa.b_skipped, var_7be076c9078045aa.b_save_restored );
        }
    }
    
    if ( quest.var_364f3d4bcc4bae91 )
    {
        /#
            iprintlnbold( "<dev string:x424>" + getxhashsourcename( quest.ref ) + "<dev string:x256>" );
        #/
        
        return;
    }
    
    if ( isdefined( var_d502348c16c8d691 ) )
    {
        var_d502348c16c8d691.var_54132625f1a1346f[ var_d502348c16c8d691.var_54132625f1a1346f.size ] = var_7be076c9078045aa.ref;
        
        if ( var_d502348c16c8d691.var_54132625f1a1346f.size >= var_d502348c16c8d691.substeps_required )
        {
            if ( !function_69122a4776ff975e( quest.ref, var_7be076c9078045aa.ref ) )
            {
                function_fba942a1cfd85f5d( 0, 1, quest.ref, var_d502348c16c8d691.ref );
            }
            
            var_d502348c16c8d691.completed = 1;
            var_d502348c16c8d691 notify( #"hash_2c4eefaf7e2b24b6" );
        }
    }
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0xcc7c68d8, Offset: 0x3461
// Size: 0x4e
function private function_8f14128dc4232902( quest, quest_step )
{
    level endon( #"game_ended" );
    quest endon( #"zm_quest_quit", #"zm_quest_restarted", #"zm_quest_completed" );
    quest_step waittill( #"hash_2c4eefaf7e2b24b6" );
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0x44719d60, Offset: 0x34b7
// Size: 0x59
function private function_2d6f8f354bd50452( quest, quest_step )
{
    level endon( #"game_ended" );
    quest endon( #"zm_quest_quit", #"zm_quest_restarted", #"zm_quest_completed" );
    quest_step endon( #"hash_2c4eefaf7e2b24b6", #"hash_a625cbef8957f1b6" );
    wait 20;
}

// Namespace zm_quest
// Params 0, eflags: 0x4
// Checksum 0x5d32bf5d, Offset: 0x3518
// Size: 0x99
function private function_975c4749f485038f()
{
    var_2f97ca9512591822 = 0;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player issplitscreenplayer() )
        {
            var_2f97ca9512591822 = 1;
            break;
        }
    }
    
    return var_2f97ca9512591822;
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0x1403eec2, Offset: 0x35ba
// Size: 0xe7
function private function_a2d695360c41f5f7( quest, quest_step )
{
    level endon( #"game_ended" );
    quest endon( #"zm_quest_quit", #"zm_quest_restarted", #"zm_quest_completed" );
    quest_step endon( #"hash_2c4eefaf7e2b24b6" );
    
    if ( isdefined( quest_step.setup_func ) )
    {
        if ( getcodegate( #"hash_74248fa51bc2587" ) && quest_step.b_save_restored )
        {
            profilestart();
            quest_step [[ quest_step.setup_func ]]( quest_step.b_skipped, quest_step.b_save_restored );
            profilestop();
        }
        else
        {
            quest_step [[ quest_step.setup_func ]]( quest_step.b_skipped, quest_step.b_save_restored );
        }
    }
    
    quest_step.var_e314f32f9ed4335 = 1;
    quest_step notify( #"hash_fc2e57a20fed0508" );
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0x93f7c7b8, Offset: 0x36a9
// Size: 0x5b
function private function_def6f08b07a6e264( quest, quest_step )
{
    level endon( #"game_ended" );
    quest endon( #"zm_quest_quit", #"zm_quest_restarted", #"zm_quest_completed" );
    quest_step endon( #"hash_2c4eefaf7e2b24b6" );
    quest_step waittill( #"hash_fc2e57a20fed0508" );
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0xd4e67479, Offset: 0x370c
// Size: 0xe2
function private reset_quest( quest, var_4f47e65cca7b41b5 )
{
    quest.started = 0;
    quest.completed = 0;
    quest utility::ent_flag_clear( "zm_quest_completed" );
    quest.restarted = 1;
    quest.var_364f3d4bcc4bae91 = 0;
    quest.var_7be076c9078045aa = -1;
    
    foreach ( step in quest.steps )
    {
        reset_step( step, var_4f47e65cca7b41b5 );
    }
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0xe24caf21, Offset: 0x37f6
// Size: 0x107
function private reset_step( step, var_4f47e65cca7b41b5 )
{
    if ( !step.started && !var_4f47e65cca7b41b5 )
    {
        return;
    }
    
    step.var_54132625f1a1346f = [];
    step.started = 0;
    step.completed = 0;
    step.b_skipped = 0;
    step.b_save_restored = 0;
    step.b_restarted = 1;
    step.current_progress = 0;
    step.var_e314f32f9ed4335 = undefined;
    
    foreach ( step in step.steps )
    {
        reset_step( step, var_4f47e65cca7b41b5 );
    }
}

// Namespace zm_quest
// Params 12
// Checksum 0x4174fb35, Offset: 0x3905
// Size: 0x203
function function_b98d4144845ffc13( var_f0bff9392cf9a351, priority, icon, iconsize, state, v_position, offset, str_label, var_3f77d5fa92c1edbb, var_580f8891b7f1d3f3, b_play_intro = 0, var_895bdd0db4c4515 = [] )
{
    if ( isdefined( level.var_a74764204d9643c ) )
    {
        return;
    }
    
    if ( !isarray( level.var_1c3df44430e8c1ed ) )
    {
        level.var_1c3df44430e8c1ed = [];
    }
    
    objectiveindex = objidpoolmanager::requestobjectiveid( priority );
    level.var_1c3df44430e8c1ed[ var_f0bff9392cf9a351 ] = objectiveindex;
    objidpoolmanager::update_objective_icon( objectiveindex, icon );
    objidpoolmanager::update_objective_size( objectiveindex, iconsize );
    objidpoolmanager::update_objective_state( objectiveindex, state );
    objidpoolmanager::update_objective_position( objectiveindex, v_position );
    objidpoolmanager::update_objective_setbackground( objectiveindex, 1 );
    
    if ( isdefined( offset ) )
    {
        objidpoolmanager::update_objective_setzoffset( objectiveindex, offset );
    }
    
    if ( isistring( str_label ) )
    {
        objective_setlabel( objectiveindex, str_label );
    }
    
    if ( isistring( var_3f77d5fa92c1edbb ) )
    {
        objective_setdescription( objectiveindex, var_3f77d5fa92c1edbb );
    }
    
    if ( var_580f8891b7f1d3f3 )
    {
        objective_setshowoncompass( objectiveindex, var_580f8891b7f1d3f3 );
    }
    
    objidpoolmanager::objective_set_play_intro( objectiveindex, b_play_intro );
    utility::callsharedfunc( #"objective", #"hash_10d5e3bb8a551724", objectiveindex, v_position );
    var_895bdd0db4c4515 = !isarray( var_895bdd0db4c4515 ) ? [ var_895bdd0db4c4515 ] : var_895bdd0db4c4515;
    
    foreach ( target in var_895bdd0db4c4515 )
    {
        if ( isdefined( objectiveindex ) )
        {
            calloutmarkerping::function_9bd4bf4f8fe74b16( target, objectiveindex, 6 );
        }
    }
    
    level.var_a988cad983cc2980[ objectiveindex ] = var_895bdd0db4c4515;
    return objectiveindex;
}

// Namespace zm_quest
// Params 13
// Checksum 0x18122c02, Offset: 0x3b11
// Size: 0x21a
function function_dc297429579c6e7f( var_f0bff9392cf9a351, priority, icon, iconsize, state, entity, offset, str_label, var_3f77d5fa92c1edbb, var_580f8891b7f1d3f3, b_play_intro = 0, var_554e96ca40dac471 = 1, var_895bdd0db4c4515 = [] )
{
    if ( isdefined( level.var_a74764204d9643c ) )
    {
        return;
    }
    
    if ( !isarray( level.var_1c3df44430e8c1ed ) )
    {
        level.var_1c3df44430e8c1ed = [];
    }
    
    objectiveindex = objidpoolmanager::requestobjectiveid( priority );
    level.var_1c3df44430e8c1ed[ var_f0bff9392cf9a351 ] = objectiveindex;
    objidpoolmanager::update_objective_icon( objectiveindex, icon );
    objidpoolmanager::update_objective_size( objectiveindex, iconsize );
    objidpoolmanager::update_objective_state( objectiveindex, state );
    objidpoolmanager::update_objective_onentity( objectiveindex, entity );
    objidpoolmanager::update_objective_setbackground( objectiveindex, 1 );
    
    if ( isdefined( offset ) )
    {
        objidpoolmanager::update_objective_setzoffset( objectiveindex, offset );
    }
    
    if ( isistring( str_label ) )
    {
        objective_setlabel( objectiveindex, str_label );
    }
    
    if ( isistring( var_3f77d5fa92c1edbb ) )
    {
        objective_setdescription( objectiveindex, var_3f77d5fa92c1edbb );
    }
    
    if ( var_580f8891b7f1d3f3 )
    {
        objective_setshowoncompass( objectiveindex, var_580f8891b7f1d3f3 );
    }
    
    objidpoolmanager::objective_set_play_intro( objectiveindex, b_play_intro );
    
    if ( var_554e96ca40dac471 )
    {
        utility::callsharedfunc( #"objective", #"hash_10d5e3bb8a551724", objectiveindex, entity );
    }
    
    var_895bdd0db4c4515 = !isarray( var_895bdd0db4c4515 ) ? [ var_895bdd0db4c4515 ] : var_895bdd0db4c4515;
    
    foreach ( target in var_895bdd0db4c4515 )
    {
        if ( isdefined( objectiveindex ) )
        {
            calloutmarkerping::function_9bd4bf4f8fe74b16( target, objectiveindex, 6 );
        }
    }
    
    level.var_a988cad983cc2980[ objectiveindex ] = var_895bdd0db4c4515;
    return objectiveindex;
}

// Namespace zm_quest
// Params 1
// Checksum 0xf6449a38, Offset: 0x3d34
// Size: 0xb0
function function_c9361bc5efa2b5c6( var_3f77d5fa92c1edbb )
{
    text = newhudelem();
    text.alignx = "left";
    text.aligny = "middle";
    text.horzalign = "left";
    text.vertalign = "top";
    text.x = 15;
    text.y = 140;
    text.sort = 5;
    text.fontscale = 1;
    text.alpha = 1;
    text settext( var_3f77d5fa92c1edbb );
    return text;
}

// Namespace zm_quest
// Params 1
// Checksum 0x925853e2, Offset: 0x3ded
// Size: 0xe1
function complete_objective_waypoints( var_a5324728d52dddf1 )
{
    if ( !isdefined( level.var_1c3df44430e8c1ed ) )
    {
        level.var_1c3df44430e8c1ed = [];
    }
    
    if ( isstring( var_a5324728d52dddf1 ) || isxhash( var_a5324728d52dddf1 ) )
    {
        if ( isdefined( level.var_1c3df44430e8c1ed[ var_a5324728d52dddf1 ] ) )
        {
            function_cecd616ee8fe31c0( level.var_1c3df44430e8c1ed[ var_a5324728d52dddf1 ] );
            
            if ( objidpoolmanager::function_fb05d646a96ed99e( level.var_1c3df44430e8c1ed[ var_a5324728d52dddf1 ] ) )
            {
                return;
            }
            
            objidpoolmanager::returnobjectiveid( level.var_1c3df44430e8c1ed[ var_a5324728d52dddf1 ] );
            level.var_1c3df44430e8c1ed[ var_a5324728d52dddf1 ] = undefined;
        }
    }
    else
    {
        function_cecd616ee8fe31c0( var_a5324728d52dddf1 );
        
        if ( objidpoolmanager::function_fb05d646a96ed99e( var_a5324728d52dddf1 ) )
        {
            return;
        }
        
        objidpoolmanager::returnobjectiveid( var_a5324728d52dddf1 );
        level.var_1c3df44430e8c1ed = function_b20fb12633342399( level.var_1c3df44430e8c1ed, var_a5324728d52dddf1 );
    }
    
    if ( level.var_1c3df44430e8c1ed.size == 0 )
    {
        level.var_1c3df44430e8c1ed = undefined;
    }
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0xee10924c, Offset: 0x3ed6
// Size: 0x9b
function private function_cecd616ee8fe31c0( objective_id )
{
    var_895bdd0db4c4515 = level.var_a988cad983cc2980[ objective_id ];
    
    if ( !var_895bdd0db4c4515 )
    {
        return;
    }
    
    foreach ( target in var_895bdd0db4c4515 )
    {
        calloutmarkerping::function_ab4e5514677fba94( target );
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0x31d8c597, Offset: 0x3f79
// Size: 0xa8
function function_61f7df5fddf96cd1()
{
    if ( !isdefined( level.var_1c3df44430e8c1ed ) || level.var_1c3df44430e8c1ed.size == 0 )
    {
        return;
    }
    
    foreach ( obj_id in level.var_1c3df44430e8c1ed )
    {
        if ( objidpoolmanager::function_fb05d646a96ed99e( obj_id ) )
        {
            continue;
        }
        
        objidpoolmanager::objective_playermask_hidefromallplayers( obj_id );
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0xd6048027, Offset: 0x4029
// Size: 0xa8
function function_a62dc5b7c911530()
{
    if ( !isdefined( level.var_1c3df44430e8c1ed ) || level.var_1c3df44430e8c1ed.size == 0 )
    {
        return;
    }
    
    foreach ( obj_id in level.var_1c3df44430e8c1ed )
    {
        if ( objidpoolmanager::function_fb05d646a96ed99e( obj_id ) )
        {
            continue;
        }
        
        objidpoolmanager::objective_playermask_showtoallplayers( obj_id );
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0xa23f2220, Offset: 0x40d9
// Size: 0xa3
function function_b20fb12633342399( ents, remover )
{
    newents = [];
    
    if ( !isdefined( ents ) )
    {
        return;
    }
    
    foreach ( key, item in ents )
    {
        if ( item == remover )
        {
            continue;
        }
        
        newents[ key ] = item;
    }
    
    return newents;
}

// Namespace zm_quest
// Params 2
// Checksum 0xe84dcd92, Offset: 0x4185
// Size: 0x10c
function function_56cf15df978764ec( var_33b7e71de40a14ae, var_49e2378364e13ca9 )
{
    level endon( #"open_sesame" );
    quest_step = self;
    quest_step endon( #"hash_2c4eefaf7e2b24b6" );
    
    if ( !isarray( var_33b7e71de40a14ae.a_door_path ) || var_33b7e71de40a14ae.a_door_path.size < 1 )
    {
        return;
    }
    
    if ( quest_step utility::ent_flag( "waypoint_guide_complete" ) )
    {
        return;
    }
    
    quest_step utility::ent_flag_clear( "waypoint_guide_complete" );
    
    foreach ( door_path in var_33b7e71de40a14ae.a_door_path )
    {
        quest_step thread function_c8b19e66e9855c1a( door_path, var_33b7e71de40a14ae, var_49e2378364e13ca9 );
    }
    
    quest_step utility::ent_flag_wait( "waypoint_guide_complete" );
}

// Namespace zm_quest
// Params 3, eflags: 0x4
// Checksum 0x2e7608c, Offset: 0x4299
// Size: 0xa24
function private function_c8b19e66e9855c1a( door_path, var_33b7e71de40a14ae, var_49e2378364e13ca9 )
{
    level endon( #"open_sesame" );
    quest_step = self;
    quest_step endon( #"hash_2c4eefaf7e2b24b6" );
    door_objid = undefined;
    prev_door = undefined;
    prev_door_trigger = undefined;
    
    foreach ( i_door, str_door_targetname in door_path )
    {
        if ( quest_step utility::ent_flag( "waypoint_guide_complete" ) || quest_step.completed )
        {
            if ( isdefined( door_objid ) && !objidpoolmanager::function_fb05d646a96ed99e( door_objid ) )
            {
                complete_objective_waypoints( door_objid );
            }
            
            break;
        }
        
        a_doors = utility::getent_or_struct_array( str_door_targetname, "targetname" );
        
        if ( isdefined( var_33b7e71de40a14ae.var_4ca493ecb729ed30 ) )
        {
            var_4ca493ecb729ed30 = var_33b7e71de40a14ae.var_4ca493ecb729ed30;
        }
        else
        {
            var_4ca493ecb729ed30 = utility::get_closest_player();
        }
        
        var_5d76c667192314e5 = utility::get_array_of_closest( var_4ca493ecb729ed30.origin, a_doors );
        closest_door = var_5d76c667192314e5[ 0 ];
        door_trigger = closest_door.s_doorbuy ?? closest_door.var_fc824b622a52db8d[ 0 ].s_doorbuy;
        
        if ( !isdefined( door_trigger ) && isdefined( closest_door.door.s_doorbuy ) )
        {
            door_trigger = closest_door.door.s_doorbuy;
        }
        
        if ( !isdefined( door_trigger ) && isdefined( closest_door.var_1d6cddfc47031bff[ "doorbuy_trigger" ] ) )
        {
            if ( closest_door.var_1d6cddfc47031bff[ "doorbuy_trigger" ].size > 1 )
            {
                [ door_trigger ] = utility::get_array_of_closest( var_4ca493ecb729ed30.origin, closest_door.var_1d6cddfc47031bff[ "doorbuy_trigger" ] );
            }
            else
            {
                door_trigger = closest_door.var_1d6cddfc47031bff[ "doorbuy_trigger" ][ 0 ];
            }
        }
        
        var_bd49d9ad52faf61 = "waypoint_" + i_door + "_complete";
        
        if ( isdefined( door_trigger.script_flag_set ) )
        {
            if ( isdefined( prev_door_trigger.script_flag_set ) )
            {
                level utility::flag_wait( prev_door_trigger.script_flag_set );
            }
            
            if ( isdefined( door_trigger.script_flag_set ) )
            {
                a_doors = door_trigger.doors ?? door_trigger.interact.doors;
                
                if ( !isdefined( a_doors ) )
                {
                    a_doors = var_5d76c667192314e5;
                }
                
                v_pos = undefined;
                
                if ( isdefined( var_33b7e71de40a14ae.var_6cb8e5150331fe50 ) && var_33b7e71de40a14ae.var_6cb8e5150331fe50.size > 0 && a_doors.size > 0 )
                {
                    if ( arraycompare( var_33b7e71de40a14ae.var_6cb8e5150331fe50, a_doors ) )
                    {
                        a_v_pos = [];
                        
                        foreach ( door in a_doors )
                        {
                            v_pos = door.minimap_scriptable.origin;
                            
                            if ( isdefined( v_pos ) )
                            {
                                if ( isdefined( var_33b7e71de40a14ae.custom_z_offset ) )
                                {
                                    zoffset = var_33b7e71de40a14ae.custom_z_offset;
                                }
                                else
                                {
                                    zoffset = ( 0, 0, 60 );
                                }
                            }
                            else
                            {
                                zoffset = ( 0, 0, 0 );
                            }
                            
                            if ( !isdefined( v_pos ) )
                            {
                                v_pos = closest_door.origin;
                            }
                            
                            v_pos += zoffset;
                            a_v_pos[ a_v_pos.size ] = v_pos;
                        }
                    }
                }
                else if ( isdefined( closest_door.minimap_scriptable ) )
                {
                    v_pos = closest_door.minimap_scriptable.origin;
                }
                else
                {
                    foreach ( door in a_doors )
                    {
                        if ( isdefined( door.minimap_scriptable ) )
                        {
                            if ( !isdefined( v_pos ) )
                            {
                                v_pos = door.minimap_scriptable.origin;
                                continue;
                            }
                            
                            current_pos_dist = distancesquared( var_4ca493ecb729ed30.origin, v_pos );
                            new_pos_dist = distancesquared( var_4ca493ecb729ed30.origin, door.minimap_scriptable.origin );
                            
                            if ( new_pos_dist < current_pos_dist )
                            {
                                v_pos = door.minimap_scriptable.origin;
                            }
                        }
                    }
                }
                
                if ( isdefined( v_pos ) )
                {
                    if ( isdefined( var_33b7e71de40a14ae.custom_z_offset ) )
                    {
                        zoffset = var_33b7e71de40a14ae.custom_z_offset;
                    }
                    else
                    {
                        zoffset = ( 0, 0, 60 );
                    }
                }
                else
                {
                    zoffset = ( 0, 0, 0 );
                }
                
                if ( !isdefined( v_pos ) )
                {
                    v_pos = closest_door.origin;
                }
                
                v_pos += zoffset;
                var_f0bff9392cf9a351 = "doorbuy_wait_" + door_trigger.script_flag_set;
                
                if ( isdefined( a_v_pos ) )
                {
                    a_door_objid = [];
                    
                    foreach ( pos in a_v_pos )
                    {
                        door_objid = function_b98d4144845ffc13( var_f0bff9392cf9a351, var_49e2378364e13ca9.priority, var_49e2378364e13ca9.icon, var_49e2378364e13ca9.var_1c669d7332ae2d99, var_49e2378364e13ca9.state, pos, var_49e2378364e13ca9.offset, var_49e2378364e13ca9.str_label, var_49e2378364e13ca9.var_3f77d5fa92c1edbb, var_49e2378364e13ca9.var_580f8891b7f1d3f3, var_49e2378364e13ca9.b_play_intro );
                        a_door_objid[ a_door_objid.size ] = door_objid;
                    }
                }
                else
                {
                    door_objid = function_b98d4144845ffc13( var_f0bff9392cf9a351, var_49e2378364e13ca9.priority, var_49e2378364e13ca9.icon, var_49e2378364e13ca9.var_1c669d7332ae2d99, var_49e2378364e13ca9.state, v_pos, var_49e2378364e13ca9.offset, var_49e2378364e13ca9.str_label, var_49e2378364e13ca9.var_3f77d5fa92c1edbb, var_49e2378364e13ca9.var_580f8891b7f1d3f3, var_49e2378364e13ca9.b_play_intro );
                }
                
                var_94f8c1d1d1291cd0 = strtok( door_trigger.script_flag_set, " " );
                var_b3eb00bce5e6b29d = strtok( door_trigger.script_flag_set, "," );
                var_1007b5ff447ee53e = [ var_94f8c1d1d1291cd0[ 0 ], var_b3eb00bce5e6b29d[ 0 ] ];
                quest_step thread function_e27fceed76fccda4( var_1007b5ff447ee53e, var_bd49d9ad52faf61 );
                var_108b8a4ceaf331df = [ "waypoint_guide_complete" ];
                
                if ( var_33b7e71de40a14ae.var_e0edaabf62a145d9 )
                {
                    var_108b8a4ceaf331df[ var_108b8a4ceaf331df.size ] = var_bd49d9ad52faf61;
                }
                else
                {
                    quest_step utility::ent_flag_clear( var_bd49d9ad52faf61 );
                }
                
                foreach ( door in a_doors )
                {
                    if ( !isdefined( door.minimap_scriptable ) && !door utility::function_de1f80d93273abf5() )
                    {
                        continue;
                    }
                    
                    target = door.minimap_scriptable ?? door;
                    
                    if ( isdefined( door_objid ) )
                    {
                        calloutmarkerping::function_9bd4bf4f8fe74b16( target, door_objid, 6 );
                    }
                }
                
                var_108b8a4ceaf331df[ var_108b8a4ceaf331df.size ] = "door_bought";
                var_d8e4f3e26b1ea4e5 = quest_step utility::function_e2baa5896d5756cc( var_108b8a4ceaf331df );
                quest_step notify( var_bd49d9ad52faf61 );
                params = spawnstruct();
                params.door_index = i_door;
                params.str_door_targetname = str_door_targetname;
                params.var_33b7e71de40a14ae = var_33b7e71de40a14ae;
                quest_step callback::callback( "on_waypoint_door_bought", params );
                
                foreach ( door in a_doors )
                {
                    if ( !isdefined( door.minimap_scriptable ) && !door utility::function_de1f80d93273abf5() )
                    {
                        continue;
                    }
                    
                    target = door.minimap_scriptable ?? door;
                    
                    if ( isdefined( target ) )
                    {
                        calloutmarkerping::function_ab4e5514677fba94( target );
                    }
                }
                
                if ( isdefined( a_door_objid ) )
                {
                    foreach ( door_objid in a_door_objid )
                    {
                        complete_objective_waypoints( door_objid );
                    }
                    
                    a_v_pos = undefined;
                    a_door_objid = undefined;
                    var_33b7e71de40a14ae.var_6cb8e5150331fe50 = undefined;
                }
                else
                {
                    complete_objective_waypoints( door_objid );
                }
            }
        }
        
        if ( var_33b7e71de40a14ae.var_e0edaabf62a145d9 )
        {
            quest_step utility::ent_flag_set( var_bd49d9ad52faf61 );
        }
        
        prev_door = closest_door;
        prev_door_trigger = door_trigger;
    }
    
    quest_step utility::ent_flag_set( "waypoint_guide_complete" );
}

// Namespace zm_quest
// Params 0, eflags: 0x4
// Checksum 0x9f008397, Offset: 0x4cc5
// Size: 0x2
function private function_293e54cdeb99a9b2()
{
    
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0xfb1f425f, Offset: 0x4ccf
// Size: 0x3c
function private function_e27fceed76fccda4( a_flags_wait, str_endon )
{
    self endon( str_endon );
    utility::ent_flag_clear( "door_bought" );
    level utility::flag_wait_any_array( a_flags_wait );
    utility::ent_flag_set( "door_bought" );
}

// Namespace zm_quest
// Params 2
// Checksum 0xa3f739dc, Offset: 0x4d13
// Size: 0xb6
function fake_physicslaunch( target_pos, power )
{
    start_pos = self.origin;
    gravity = getdvarfloat( @"bg_gravity", 0 ) * -1;
    dist = distance( start_pos, target_pos );
    time = dist / power;
    delta = target_pos - start_pos;
    drop = 0.5 * gravity * time * time;
    velocity = ( delta[ 0 ] / time, delta[ 1 ] / time, ( delta[ 2 ] - drop ) / time );
    self movegravity( velocity, time );
    return time;
}

// Namespace zm_quest
// Params 3
// Checksum 0x6bd56023, Offset: 0x4dd2
// Size: 0xcd
function force_zombie_goal( var_c6969b9fb8f1cf23, var_c409a7f752d8e6fb, priority = 3 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"force_end_current_goal" );
    
    if ( !isdefined( var_c409a7f752d8e6fb ) )
    {
        var_c409a7f752d8e6fb = 25;
    }
    
    zombie_attractor_manager::function_7eb1aaa8bc7cc15( var_c6969b9fb8f1cf23, priority );
    
    while ( true )
    {
        dis = distancesquared( self.var_5e0be30a5816a64d, var_c6969b9fb8f1cf23.origin );
        
        /#
            sphere( var_c6969b9fb8f1cf23.origin, 15, ( 1, 0, 0 ), 0, 50 );
        #/
        
        if ( dis < squared( var_c409a7f752d8e6fb ) )
        {
            zombie_attractor_manager::function_dcfb4c31f1d97cd2( var_c6969b9fb8f1cf23 );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_quest
// Params 9
// Checksum 0xc83e436f, Offset: 0x4ea7
// Size: 0x217
function function_835556fe63cd2edd( original_pos, n_radius, b_force_all_zombies = 0, var_110cc40fad107c09 = 1, var_8473f30fa3f8a348 = 0, var_79aebce64a2c1ae4 = 1, b_forceannihilate = 0, var_44d820283d9ecf85 = 1, var_5d179ebcf5a552e4 = 0 )
{
    zombies = getaiarrayinradius( original_pos, n_radius, "team_two_hundred" );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie.b_ignore_cleanup || zombie.b_cleanup_no_respawn || zombie.b_ignore_impact_damage && !b_force_all_zombies )
        {
            continue;
        }
        
        if ( zombie utility::ent_flag( "scene_active" ) )
        {
            continue;
        }
        
        if ( zombie.aicategory == "boss" )
        {
            continue;
        }
        
        if ( zombie.aicategory == "elite" || zombie.aicategory == "hvt" )
        {
            if ( !b_force_all_zombies )
            {
                continue;
            }
            
            if ( var_5d179ebcf5a552e4 )
            {
                if ( zombie zm_cleanup_manager::teleport_zombie( b_force_all_zombies ) )
                {
                    continue;
                }
            }
        }
        
        if ( var_110cc40fad107c09 )
        {
            zombie.var_e8f8a2469663d564 = 1;
            zombie zm_cleanup_manager::function_dd62e2042418b7e5();
        }
        
        if ( var_44d820283d9ecf85 )
        {
            waittime = 0.5 * distance( original_pos, zombie.origin ) / 2000;
        }
        
        level thread impact_zombie( original_pos, zombie, waittime, var_8473f30fa3f8a348, var_79aebce64a2c1ae4, b_forceannihilate );
    }
}

// Namespace zm_quest
// Params 6, eflags: 0x4
// Checksum 0x5231176a, Offset: 0x50c6
// Size: 0x14f
function private impact_zombie( original_pos, zombie, waittime, var_8473f30fa3f8a348, var_79aebce64a2c1ae4, b_forceannihilate )
{
    level endon( #"game_ended" );
    zombie endon( #"death" );
    
    if ( waittime >= level.framedurationseconds )
    {
        wait waittime;
    }
    
    if ( var_79aebce64a2c1ae4 )
    {
        impact_vector = vectornormalize( zombie.origin + ( 0, 0, 50 ) - original_pos ) * 6000;
        zombie.ragdollimpactvector = impact_vector;
        zombie.ragdollhitloc = "torso_lower";
        
        if ( issubstr( zombie.subclass, "zombie_base" ) )
        {
            zombie.do_immediate_ragdoll = 1;
        }
    }
    else
    {
        zombie.noragdoll = 1;
    }
    
    zombie.var_a13bed1ac47e1b2c = 1;
    zombie.no_powerups = 1;
    
    if ( !var_8473f30fa3f8a348 )
    {
        zombie.nocorpse = 1;
    }
    
    if ( b_forceannihilate )
    {
        zombie.forceannihilate = 1;
    }
    
    if ( zombie.magic_bullet_shield )
    {
        zombie ai::stop_magic_bullet_shield();
    }
    
    zombie kill();
}

// Namespace zm_quest
// Params 0
// Checksum 0x457672c3, Offset: 0x521d
// Size: 0x8d0
function function_c96bc1e38a98d40b()
{
    if ( !isdefined( level.var_22e4c1cc787645ac ) )
    {
        level.var_22e4c1cc787645ac = spawnstruct();
    }
    
    if ( !isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794 ) )
    {
        level.var_22e4c1cc787645ac.var_778ed9fad43aa794 = spawnstruct();
    }
    
    if ( !isdefined( level.var_22e4c1cc787645ac.var_e0770897ab25c140 ) )
    {
        level.var_22e4c1cc787645ac.var_e0770897ab25c140 = spawnstruct();
    }
    
    mapinfo = getactivemapinfobundle();
    var_89bbabeea696160 = undefined;
    
    if ( isdefined( mapinfo.var_ca80f058eecbf8f0 ) && mapinfo.var_ca80f058eecbf8f0 != %"" )
    {
        var_89bbabeea696160 = getscriptbundle( mapinfo.var_ca80f058eecbf8f0 );
    }
    
    if ( isdefined( var_89bbabeea696160.questitems ) )
    {
        level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests = [];
        level.var_22e4c1cc787645ac.var_778ed9fad43aa794.var_9844f814b11f5527 = [];
        level.var_22e4c1cc787645ac.var_e0770897ab25c140.quests = [];
        level.var_22e4c1cc787645ac.var_e0770897ab25c140.var_9844f814b11f5527 = [];
        
        foreach ( questindex, questitem in var_89bbabeea696160.questitems )
        {
            if ( !isdefined( questitem.questitem ) )
            {
                continue;
            }
            
            quest = getscriptbundle( questitem.questitem );
            
            if ( quest.var_d4d52716e61444af )
            {
                var_10e4668438d4d7af = level.var_22e4c1cc787645ac.var_e0770897ab25c140;
            }
            else
            {
                var_10e4668438d4d7af = level.var_22e4c1cc787645ac.var_778ed9fad43aa794;
            }
            
            var_10e4668438d4d7af.quests[ quest.ref ] = spawnstruct();
            var_10e4668438d4d7af.quests[ quest.ref ].var_d4d52716e61444af = quest.var_d4d52716e61444af;
            var_10e4668438d4d7af.quests[ quest.ref ].var_c6da261b8770c9df = quest.var_c6da261b8770c9df;
            var_10e4668438d4d7af.quests[ quest.ref ].index = questindex;
            var_10e4668438d4d7af.quests[ quest.ref ].ref = quest.ref;
            var_10e4668438d4d7af.quests[ quest.ref ].visible = quest.var_93d7c08934e6fe53;
            var_10e4668438d4d7af.quests[ quest.ref ].var_abbebdb114e4f57f = 0;
            var_10e4668438d4d7af.quests[ quest.ref ].phases = [];
            var_10e4668438d4d7af.var_9844f814b11f5527[ questindex ] = quest.ref;
            
            /#
                function_b94da42e778631ae( quest.ref );
            #/
            
            if ( isdefined( quest.phases ) )
            {
                phaseindex = 0;
                
                foreach ( var_478f6aec28bee176 in quest.phases )
                {
                    phase = getscriptbundle( var_478f6aec28bee176.phase );
                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ] = spawnstruct();
                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].index = phaseindex;
                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].ref = phase.ref;
                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items = [];
                    
                    /#
                        function_efe1c13dd1edb00e( quest.ref, phaseindex );
                    #/
                    
                    if ( isdefined( phase.items ) )
                    {
                        itemindex = 0;
                        
                        foreach ( var_b3062827c2eddcbd in phase.items )
                        {
                            item = getscriptbundle( var_b3062827c2eddcbd.item );
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ] = spawnstruct();
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].index = itemindex;
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].ref = item.ref;
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].visible = item.var_93d7c08934e6fe53;
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].var_2a61bf1bab364376 = 0;
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].stages = [];
                            
                            if ( isdefined( item.stages ) )
                            {
                                var_565464acd8627e74 = 0;
                                
                                foreach ( var_c2e71910a31e4207 in item.stages )
                                {
                                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].stages[ var_565464acd8627e74 ] = spawnstruct();
                                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].stages[ var_565464acd8627e74 ].amountneeded = var_c2e71910a31e4207.amountneeded;
                                    var_565464acd8627e74++;
                                }
                                
                                /#
                                    function_eea02feb5226b324( quest.ref, phaseindex, item.ref, var_565464acd8627e74 );
                                #/
                            }
                            
                            itemindex++;
                        }
                    }
                    
                    phaseindex++;
                }
            }
        }
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x8b80aac9, Offset: 0x5af5
// Size: 0x774
function function_40bcf84e95b7b798( var_d4571264204419f1 )
{
    var_10e4668438d4d7af = var_d4571264204419f1;
    mapinfo = getactivemapinfobundle();
    var_89bbabeea696160 = undefined;
    
    if ( isdefined( mapinfo.var_ca80f058eecbf8f0 ) && mapinfo.var_ca80f058eecbf8f0 != %"" )
    {
        var_89bbabeea696160 = getscriptbundle( mapinfo.var_ca80f058eecbf8f0 );
    }
    
    if ( isdefined( var_89bbabeea696160.questitems ) )
    {
        foreach ( questindex, questitem in var_89bbabeea696160.questitems )
        {
            if ( !isdefined( questitem.questitem ) )
            {
                continue;
            }
            
            quest = getscriptbundle( questitem.questitem );
            
            if ( !quest.var_d4d52716e61444af )
            {
                continue;
            }
            
            var_10e4668438d4d7af.quests[ quest.ref ] = spawnstruct();
            var_10e4668438d4d7af.quests[ quest.ref ].var_d4d52716e61444af = quest.var_d4d52716e61444af;
            var_10e4668438d4d7af.quests[ quest.ref ].var_c6da261b8770c9df = quest.var_c6da261b8770c9df;
            var_10e4668438d4d7af.quests[ quest.ref ].index = questindex;
            var_10e4668438d4d7af.quests[ quest.ref ].ref = quest.ref;
            var_10e4668438d4d7af.quests[ quest.ref ].visible = quest.var_93d7c08934e6fe53;
            var_10e4668438d4d7af.quests[ quest.ref ].var_abbebdb114e4f57f = 0;
            var_10e4668438d4d7af.quests[ quest.ref ].phases = [];
            var_10e4668438d4d7af.var_9844f814b11f5527[ questindex ] = quest.ref;
            
            if ( isdefined( quest.phases ) )
            {
                phaseindex = 0;
                
                foreach ( var_478f6aec28bee176 in quest.phases )
                {
                    phase = getscriptbundle( var_478f6aec28bee176.phase );
                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ] = spawnstruct();
                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].index = phaseindex;
                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].ref = phase.ref;
                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items = [];
                    
                    if ( isdefined( phase.items ) )
                    {
                        itemindex = 0;
                        
                        foreach ( var_b3062827c2eddcbd in phase.items )
                        {
                            item = getscriptbundle( var_b3062827c2eddcbd.item );
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ] = spawnstruct();
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].index = itemindex;
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].ref = item.ref;
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].visible = item.var_93d7c08934e6fe53;
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].var_2a61bf1bab364376 = 0;
                            var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].stages = [];
                            
                            if ( isdefined( item.stages ) )
                            {
                                var_565464acd8627e74 = 0;
                                
                                foreach ( var_c2e71910a31e4207 in item.stages )
                                {
                                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].stages[ var_565464acd8627e74 ] = spawnstruct();
                                    var_10e4668438d4d7af.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].stages[ var_565464acd8627e74 ].amountneeded = var_c2e71910a31e4207.amountneeded;
                                    var_565464acd8627e74++;
                                }
                            }
                            
                            itemindex++;
                        }
                    }
                    
                    phaseindex++;
                }
            }
        }
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0x6c4e83b6, Offset: 0x6271
// Size: 0x89
function init_client_inventory_data()
{
    if ( !isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a ) )
    {
        level.var_22e4c1cc787645ac.var_aa0587a7855b967a = [];
    }
    
    player_id = self getentitynumber();
    level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ] = spawnstruct();
    function_40bcf84e95b7b798( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ] );
    function_46fae903d910097c();
    utility::ent_flag_set( "finish_init_client_inventory_data" );
}

// Namespace zm_quest
// Params 0
// Checksum 0xf36d5e6e, Offset: 0x6302
// Size: 0x1e5
function function_46fae903d910097c()
{
    player_id = self getentitynumber();
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests ) )
    {
        foreach ( quest in level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests )
        {
            function_a57d1f0655542b50( quest.ref, quest.var_abbebdb114e4f57f );
        }
        
        if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.var_9844f814b11f5527 ) )
        {
            function_44fe3dcaa8005357();
        }
    }
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests ) )
    {
        foreach ( quest in level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests )
        {
            function_a57d1f0655542b50( quest.ref, quest.var_abbebdb114e4f57f, self );
        }
        
        if ( isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].var_9844f814b11f5527 ) )
        {
            function_44fe3dcaa8005357();
        }
    }
}

// Namespace zm_quest
// Params 3
// Checksum 0xc76bcfcc, Offset: 0x64ef
// Size: 0x431
function function_a57d1f0655542b50( quest_ref, var_1e562e6847201882, player )
{
    assert( isxhash( quest_ref ) );
    
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    else
    {
        player_id = undefined;
    }
    
    var_9c3b47fc1d714f47 = get_inventory_quest_index( quest_ref, player_id );
    
    if ( !( isdefined( quest_ref ) && isdefined( var_9c3b47fc1d714f47 ) && isdefined( var_1e562e6847201882 ) && isdefined( level.var_22e4c1cc787645ac ) ) )
    {
        return;
    }
    
    var_fad7feee4d4df255 = [];
    
    if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
    {
        foreach ( item in level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].phases[ var_1e562e6847201882 ].items )
        {
            var_fad7feee4d4df255[ item.index ] = spawnstruct();
            var_fad7feee4d4df255[ item.index ].visibility = item.visible;
            var_fad7feee4d4df255[ item.index ].var_2a61bf1bab364376 = item.var_2a61bf1bab364376;
        }
    }
    else
    {
        foreach ( item in level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].phases[ var_1e562e6847201882 ].items )
        {
            var_fad7feee4d4df255[ item.index ] = spawnstruct();
            var_fad7feee4d4df255[ item.index ].visibility = item.visible;
            var_fad7feee4d4df255[ item.index ].var_2a61bf1bab364376 = item.var_2a61bf1bab364376;
        }
    }
    
    var_9d8133ee9177f14e = int( var_1e562e6847201882 ) & 7;
    var_c9fbd82683c43b6f = 0;
    var_ee18ef677c2bc908 = 0;
    
    for ( i = 0; i < 6 ; i++ )
    {
        if ( !isdefined( var_fad7feee4d4df255[ i ] ) )
        {
            var_fad7feee4d4df255[ i ] = spawnstruct();
        }
        
        var_fad7feee4d4df255[ i ].visibility = var_fad7feee4d4df255[ i ].visibility ?? 0;
        var_fad7feee4d4df255[ i ].var_2a61bf1bab364376 = var_fad7feee4d4df255[ i ].var_2a61bf1bab364376 ?? 0;
        var_c9fbd82683c43b6f += ( int( var_fad7feee4d4df255[ i ].visibility ) & 1 ) << var_ee18ef677c2bc908;
        var_ee18ef677c2bc908 += 1;
        var_c9fbd82683c43b6f += ( int( var_fad7feee4d4df255[ i ].var_2a61bf1bab364376 ) & 15 ) << var_ee18ef677c2bc908;
        var_ee18ef677c2bc908 += 4;
    }
    
    var_59fd68dba20fa2e3 = "ui_zm_inventory_quest_" + var_9c3b47fc1d714f47 + 1;
    var_5fd53ec29820eec4 = "ui_zm_inventory_quest_items_" + var_9c3b47fc1d714f47 + 1;
    
    if ( isdefined( player_id ) )
    {
        player setclientomnvar( var_59fd68dba20fa2e3, var_9d8133ee9177f14e );
        player setclientomnvar( var_5fd53ec29820eec4, var_c9fbd82683c43b6f );
        return;
    }
    
    foreach ( player in level.players )
    {
        player setclientomnvar( var_59fd68dba20fa2e3, var_9d8133ee9177f14e );
        player setclientomnvar( var_5fd53ec29820eec4, var_c9fbd82683c43b6f );
    }
}

// Namespace zm_quest
// Params 6
// Checksum 0x5967564a, Offset: 0x6928
// Size: 0x146, Type: bool
function function_fbaa101a54a3ce89( quest_ref, var_1e562e6847201882, item_ref, var_41f8529e24f6fb4b, amount, player )
{
    assert( isxhash( quest_ref ) && isxhash( item_ref ) );
    
    if ( !( isdefined( quest_ref ) && isdefined( var_1e562e6847201882 ) && isdefined( item_ref ) && isdefined( var_41f8529e24f6fb4b ) ) )
    {
        return false;
    }
    
    var_41f8529e24f6fb4b = function_2b3236bd3ec53687( quest_ref, var_1e562e6847201882, item_ref, var_41f8529e24f6fb4b, player );
    amountneeded = undefined;
    
    if ( isdefined( player ) )
    {
        amountneeded = level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player getentitynumber() ].quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].stages[ var_41f8529e24f6fb4b ].amountneeded;
    }
    else
    {
        amountneeded = level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].stages[ var_41f8529e24f6fb4b ].amountneeded;
    }
    
    return !isdefined( amountneeded ) || amount >= amountneeded;
}

// Namespace zm_quest
// Params 2
// Checksum 0x645ed306, Offset: 0x6a77
// Size: 0xeb
function get_inventory_quest_index( quest_ref, player_id )
{
    assert( isxhash( quest_ref ) );
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
    {
        return level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].index;
    }
    
    if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
    {
        return level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].index;
    }
    
    assertmsg( "<dev string:x435>" + getxhashsourcename( quest_ref ) + "<dev string:x446>" );
}

// Namespace zm_quest
// Params 4
// Checksum 0xb0b3eea3, Offset: 0x6b6a
// Size: 0x150
function function_4fb414c4dfe38da5( quest_ref, var_1e562e6847201882, item_ref, player )
{
    assert( isxhash( quest_ref ) && isxhash( item_ref ) );
    
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
    {
        return level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].index;
    }
    
    if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
    {
        return level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].index;
    }
    
    assertmsg( "<dev string:x435>" + getxhashsourcename( quest_ref ) + "<dev string:x446>" );
}

// Namespace zm_quest
// Params 2
// Checksum 0x1d1675d7, Offset: 0x6cc2
// Size: 0x10a
function function_dc4d707e25ce44d6( quest_ref, var_1e562e6847201882 )
{
    assert( isxhash( quest_ref ) );
    phase_ref = undefined;
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
    {
        phase_ref = level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].phases[ var_1e562e6847201882 ].ref;
    }
    else if ( isdefined( level.var_22e4c1cc787645ac.var_e0770897ab25c140.quests[ quest_ref ] ) )
    {
        phase_ref = level.var_22e4c1cc787645ac.var_e0770897ab25c140.quests[ quest_ref ].phases[ var_1e562e6847201882 ].ref;
    }
    else
    {
        assertmsg( "<dev string:x435>" + getxhashsourcename( quest_ref ) + "<dev string:x446>" );
    }
    
    return phase_ref;
}

// Namespace zm_quest
// Params 3
// Checksum 0x4f1eec5a, Offset: 0x6dd5
// Size: 0x10e
function function_414f5738fd71d248( quest_ref, var_1e562e6847201882, player )
{
    assert( isxhash( quest_ref ) );
    
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
    {
        level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].var_abbebdb114e4f57f = var_1e562e6847201882;
        return;
    }
    
    if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
    {
        level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].var_abbebdb114e4f57f = var_1e562e6847201882;
        return;
    }
    
    assertmsg( "<dev string:x435>" + getxhashsourcename( quest_ref ) + "<dev string:x446>" );
}

// Namespace zm_quest
// Params 2
// Checksum 0x32266665, Offset: 0x6eeb
// Size: 0x104
function function_23669314446ef229( quest_ref, player )
{
    assert( isxhash( quest_ref ) );
    
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
    {
        return level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].var_abbebdb114e4f57f;
    }
    
    if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
    {
        return level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].var_abbebdb114e4f57f;
    }
    
    assertmsg( "<dev string:x435>" + getxhashsourcename( quest_ref ) + "<dev string:x446>" );
    return;
}

// Namespace zm_quest
// Params 5
// Checksum 0x694bbbdf, Offset: 0x6ff7
// Size: 0x1fe
function function_2b3236bd3ec53687( quest_ref, var_1e562e6847201882, item_ref, var_41f8529e24f6fb4b, player )
{
    assert( isxhash( quest_ref ) && isxhash( item_ref ) );
    
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    stages = undefined;
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].stages ) )
    {
        stages = level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].stages;
    }
    else if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].stages ) )
    {
        stages = level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].stages;
    }
    
    if ( isdefined( stages ) && var_41f8529e24f6fb4b > stages.size )
    {
        /#
            iprintlnbold( "<dev string:x45f>" + getxhashsourcename( quest_ref ) + "<dev string:x49a>" + getxhashsourcename( item_ref ) + "<dev string:x49e>" + var_41f8529e24f6fb4b + "<dev string:x4ad>" + stages.size + "<dev string:x4b4>" );
        #/
        
        return stages.size;
    }
    
    if ( !isdefined( stages ) )
    {
        assertmsg( "<dev string:x435>" + getxhashsourcename( quest_ref ) + "<dev string:x4b6>" );
    }
    
    return var_41f8529e24f6fb4b;
}

// Namespace zm_quest
// Params 5
// Checksum 0x6a2b9309, Offset: 0x71fe
// Size: 0x16b
function function_b5d10e9625f13230( quest_ref, var_1e562e6847201882, item_ref, var_41f8529e24f6fb4b, player )
{
    assert( isxhash( quest_ref ) && isxhash( item_ref ) );
    
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    var_41f8529e24f6fb4b = function_2b3236bd3ec53687( quest_ref, var_1e562e6847201882, item_ref, var_41f8529e24f6fb4b, player );
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
    {
        level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].var_2a61bf1bab364376 = var_41f8529e24f6fb4b;
        return;
    }
    
    if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
    {
        level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].var_2a61bf1bab364376 = var_41f8529e24f6fb4b;
        return;
    }
    
    assertmsg( "<dev string:x435>" + getxhashsourcename( quest_ref ) + "<dev string:x446>" );
}

// Namespace zm_quest
// Params 5
// Checksum 0x276d318, Offset: 0x7371
// Size: 0x165
function function_db2af38a83f7fdc6( quest_ref, var_1e562e6847201882, item_ref, var_a2507cfe675b67db, player )
{
    assert( isxhash( quest_ref ) && isxhash( item_ref ) );
    
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    if ( !isdefined( var_a2507cfe675b67db ) )
    {
        var_a2507cfe675b67db = 1;
    }
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
    {
        level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].visible = var_a2507cfe675b67db;
        return;
    }
    
    if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
    {
        level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].visible = var_a2507cfe675b67db;
        return;
    }
    
    assertmsg( "<dev string:x435>" + getxhashsourcename( quest_ref ) + "<dev string:x446>" );
}

// Namespace zm_quest
// Params 4
// Checksum 0xd3d03cd4, Offset: 0x74de
// Size: 0x15f
function get_inventory_item_visibility( quest_ref, var_1e562e6847201882, item_ref, player )
{
    assert( isxhash( quest_ref ) && isxhash( item_ref ) );
    
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    isvisible = 0;
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
    {
        isvisible = level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].visible;
    }
    else if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
    {
        isvisible = level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].visible;
    }
    else
    {
        assertmsg( "<dev string:x435>" + getxhashsourcename( quest_ref ) + "<dev string:x446>" );
    }
    
    return isvisible;
}

// Namespace zm_quest
// Params 2
// Checksum 0xea2849af, Offset: 0x7646
// Size: 0x112
function function_86adcc348d04ff29( quest_ref, player )
{
    assert( isxhash( quest_ref ) );
    
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    isvisible = 0;
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
    {
        isvisible = level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].visible;
    }
    else if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
    {
        isvisible = level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].visible;
    }
    else
    {
        assertmsg( "<dev string:x435>" + getxhashsourcename( quest_ref ) + "<dev string:x446>" );
    }
    
    return isvisible;
}

// Namespace zm_quest
// Params 3
// Checksum 0x6b47f995, Offset: 0x7761
// Size: 0x117
function function_98432f89334662d5( quest_ref, show_quest, player )
{
    assert( isxhash( quest_ref ) );
    
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    if ( !isdefined( show_quest ) )
    {
        show_quest = 1;
    }
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
    {
        level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].visible = show_quest;
        return;
    }
    
    if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
    {
        level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].visible = show_quest;
        return;
    }
    
    assertmsg( "<dev string:x435>" + getxhashsourcename( quest_ref ) + "<dev string:x446>" );
}

// Namespace zm_quest
// Params 6
// Checksum 0xf9c1136d, Offset: 0x7880
// Size: 0x83
function function_b57dfe9625966b0b( quest_ref, var_1e562e6847201882, item_ref, var_41f8529e24f6fb4b, var_a2507cfe675b67db, player )
{
    assert( isxhash( quest_ref ) && isxhash( item_ref ) );
    function_414f5738fd71d248( quest_ref, var_1e562e6847201882, player );
    function_b5d10e9625f13230( quest_ref, var_1e562e6847201882, item_ref, var_41f8529e24f6fb4b, player );
    function_db2af38a83f7fdc6( quest_ref, var_1e562e6847201882, item_ref, var_a2507cfe675b67db, player );
    function_a57d1f0655542b50( quest_ref, var_1e562e6847201882, player );
}

// Namespace zm_quest
// Params 4
// Checksum 0x8c4775c, Offset: 0x790b
// Size: 0x12e
function function_6b5f09e88a4edfce( quest_ref, var_1e562e6847201882, item_ref, player )
{
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    var_7089410b4e99793d = 0;
    
    if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
    {
        var_7089410b4e99793d = level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].var_2a61bf1bab364376 > 0;
    }
    else if ( isdefined( player_id ) && isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
    {
        var_7089410b4e99793d = level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].phases[ var_1e562e6847201882 ].items[ item_ref ].var_2a61bf1bab364376 > 0;
    }
    
    return var_7089410b4e99793d;
}

// Namespace zm_quest
// Params 0
// Checksum 0xbc58142c, Offset: 0x7a42
// Size: 0x1ce
function function_44fe3dcaa8005357()
{
    foreach ( player in level.players )
    {
        var_d91180c60887f4ba = 0;
        player_id = player getentitynumber();
        
        for ( i = 0; i < 6 ; i++ )
        {
            quest_ref = level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].var_9844f814b11f5527[ i ];
            
            if ( !isdefined( quest_ref ) )
            {
                quest_ref = level.var_22e4c1cc787645ac.var_778ed9fad43aa794.var_9844f814b11f5527[ i ];
            }
            
            if ( isdefined( quest_ref ) )
            {
                if ( isdefined( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ] ) )
                {
                    var_d91180c60887f4ba += ( int( level.var_22e4c1cc787645ac.var_aa0587a7855b967a[ player_id ].quests[ quest_ref ].visible ) & 1 ) << i;
                    continue;
                }
                
                if ( isdefined( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ] ) )
                {
                    var_d91180c60887f4ba += ( int( level.var_22e4c1cc787645ac.var_778ed9fad43aa794.quests[ quest_ref ].visible ) & 1 ) << i;
                }
            }
        }
        
        player setclientomnvar( "ui_zm_inventory_quests_vis", var_d91180c60887f4ba );
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x3b4735bd, Offset: 0x7c18
// Size: 0x32
function function_e637e99dca570fa5( a_elems )
{
    if ( isdefined( level.var_668cf83021861bb3 ) )
    {
        /#
            iprintln( "<dev string:x4da>" );
        #/
        
        return;
    }
    
    level.var_668cf83021861bb3 = a_elems;
}

// Namespace zm_quest
// Params 0
// Checksum 0x530b94e2, Offset: 0x7c52
// Size: 0x38
function function_bf2af92f784b18b6()
{
    if ( isdefined( level.var_668cf83021861bb3 ) )
    {
        level.var_668cf83021861bb3 = arrayremove( level.var_668cf83021861bb3, level.var_668cf83021861bb3 );
        level.var_668cf83021861bb3 = undefined;
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0x185efe0d, Offset: 0x7c92
// Size: 0x98
function function_ff8fe8f57b9ddf3e()
{
    if ( isdefined( level.var_668cf83021861bb3 ) && level.var_668cf83021861bb3.size > 0 )
    {
        foreach ( elem in level.var_668cf83021861bb3 )
        {
            elem hud_util::hideelem();
        }
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0xf526aa7c, Offset: 0x7d32
// Size: 0x98
function function_9a9ecb816092f35()
{
    if ( isdefined( level.var_668cf83021861bb3 ) && level.var_668cf83021861bb3.size > 0 )
    {
        foreach ( elem in level.var_668cf83021861bb3 )
        {
            elem hud_util::showelem();
        }
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0x8afdcd8d, Offset: 0x7dd2
// Size: 0x96
function function_d80df37d3fe931dc()
{
    switch ( self.operatorcustomization.operatorref )
    {
        case %"t10_rus_pl_weaver":
            return "weaver";
        case %"t10_gbr_pl_grey":
            return "grey";
        case %"t10_usa_pl_carver":
            return "carver";
        case %"t10_phl_pl_maya":
            return "maya";
        case %"sat_usa_pl_amber":
            return "dempsey";
        case %"sat_jpn_pl_scarlet":
            return "takeo";
        default:
            return;
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0x7cd15426, Offset: 0x7e70
// Size: 0x98
function function_6b720aa50aaaedd3()
{
    current_operators = [];
    
    foreach ( player in level.players )
    {
        operatorref = player function_d80df37d3fe931dc();
        current_operators[ current_operators.size ] = operatorref;
    }
    
    return current_operators;
}

// Namespace zm_quest
// Params 2
// Checksum 0x8c4bcb5f, Offset: 0x7f11
// Size: 0xba
function function_9394bf2845454024( event, var_1fb24399f08e86f9 = 2 )
{
    if ( !level.overlord.events )
    {
        return;
    }
    
    var_1a80ce4ffd9d426d = [];
    
    for ( i = 0; i < var_1fb24399f08e86f9 ; i++ )
    {
        var_99957b91adadef09 = hashcat( event, string( i ) );
        vo_event = level.overlord.events[ var_99957b91adadef09 ];
        
        if ( vo_event )
        {
            var_1a80ce4ffd9d426d[ var_1a80ce4ffd9d426d.size ] = var_99957b91adadef09;
        }
    }
    
    /#
        if ( !var_1a80ce4ffd9d426d.size )
        {
            iprintlnbold( "<dev string:x541>" + getxhashsourcename( event ) );
        }
    #/
    
    return var_1a80ce4ffd9d426d;
}

// Namespace zm_quest
// Params 3
// Checksum 0x3f1e4f7e, Offset: 0x7fd4
// Size: 0x9b
function play_vo_events( events, players, n_delay_before )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( players ) )
    {
        players = level.players;
    }
    
    assert( isarray( events ), "<dev string:x582>" );
    function_bb9f147d5cc43c19( players );
    utility::flag_waitopen( "player_banter_playing" );
    level.var_445da93d1acc5bca = 1;
    event = utility::array_random( events );
    overlord::playevent( event, players, n_delay_before, 1, 1 );
    waittillframeend();
    level.var_445da93d1acc5bca = 0;
}

// Namespace zm_quest
// Params 4
// Checksum 0x76a7bda7, Offset: 0x8077
// Size: 0xa9
function function_d5ef98341fd6a057( conversations, players, n_delay_before, var_3226ffc41619dbe2 )
{
    level endon( #"game_ended" );
    assert( isarray( conversations ), "<dev string:x59e>" );
    
    if ( !isdefined( var_3226ffc41619dbe2 ) )
    {
        var_3226ffc41619dbe2 = 0;
    }
    
    if ( !isdefined( players ) )
    {
        players = level.players;
    }
    
    function_bb9f147d5cc43c19( players );
    utility::flag_waitopen( "player_banter_playing" );
    level.var_445da93d1acc5bca = 1;
    conversation = utility::array_random( conversations );
    overlord::playconversation( conversation, players, n_delay_before, var_3226ffc41619dbe2 );
    level.var_445da93d1acc5bca = 0;
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0x81e50183, Offset: 0x8128
// Size: 0xf5
function private function_bb9f147d5cc43c19( players )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        var_d592a89fb3c95647 = 1;
        
        foreach ( player in players )
        {
            if ( player overlord::function_2a4336a2a72f769c() && gettime() < player.var_5d3b2a20a597a075.endtime || player overlord::function_5b9a94f0c7f2bb5b() && gettime() < player.var_54025b165a4e02d8.endtime )
            {
                var_d592a89fb3c95647 = 0;
                break;
            }
        }
        
        if ( var_d592a89fb3c95647 )
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0xf0181127, Offset: 0x8225
// Size: 0x26
function function_8934bb2a9028bdc5()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( is_vo_active() )
        {
            wait 1;
            continue;
        }
        
        return;
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0xa9542109, Offset: 0x8253
// Size: 0x9e, Type: bool
function is_vo_active()
{
    if ( utility::flag( "player_banter_playing" ) )
    {
        return true;
    }
    
    foreach ( player in level.players )
    {
        if ( player overlord::function_5b9a94f0c7f2bb5b() || player overlord::function_2a4336a2a72f769c() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_quest
// Params 3
// Checksum 0xe4cbf6ce, Offset: 0x82fa
// Size: 0x123
function function_943d56a5fe5194de( var_fdd603bac8adef14, ais = getaiarray( "team_two_hundred" ), b_skip_screen_flash )
{
    foreach ( ai in ais )
    {
        if ( !ai.var_15598d8e493afe88 )
        {
            ai zm_cleanup_manager::function_dd62e2042418b7e5();
        }
    }
    
    if ( !isdefined( level.players[ 0 ] ) )
    {
        return;
    }
    
    if ( var_fdd603bac8adef14 )
    {
        level.players[ 0 ] thread nuke::function_abd449c71a89e094( "nuke", level.players[ 0 ], 1, 1, 1, undefined, b_skip_screen_flash );
        return;
    }
    
    level.players[ 0 ] thread nuke::function_6c5906115e825d8f( level.players[ 0 ].origin, ais, "nuke", 1 );
}

// Namespace zm_quest
// Params 2
// Checksum 0x16bec221, Offset: 0x8425
// Size: 0x96
function nuke_zombies( var_fdd603bac8adef14, ais = getaiarray( "team_two_hundred" ) )
{
    if ( !isdefined( level.players[ 0 ] ) )
    {
        return;
    }
    
    if ( var_fdd603bac8adef14 )
    {
        level.players[ 0 ] thread nuke::function_abd449c71a89e094( "nuke", level.players[ 0 ], 1, 1, 1 );
        return;
    }
    
    level.players[ 0 ] thread nuke::function_6c5906115e825d8f( level.players[ 0 ].origin, ais, "nuke", 1 );
}

// Namespace zm_quest
// Params 10
// Checksum 0xfe28b3c1, Offset: 0x84c3
// Size: 0x190
function function_37acbb1a4a80d259( var_80443cd4f512c477, var_d8e646f5fdfb1e70, var_8bdbf470bbd736c4 = 2000, var_b418cb52dbca2613 = 100, b_force_evolve = 0, var_aaab9ed74aa76dc2, var_8d449b07071097c0, var_ae78eaeea8430741, var_6312bbd31744f16d, var_22f864c06ba32b89 )
{
    if ( issubstr( self.subclass, "vermin" ) || issubstr( self.subclass, "zombie_base" ) )
    {
        if ( var_80443cd4f512c477 )
        {
            namespace_659599414270bd0a::function_748dd662235c0bf();
        }
        
        if ( !isdefined( var_d8e646f5fdfb1e70 ) )
        {
            var_d8e646f5fdfb1e70 = 0;
        }
        
        namespace_659599414270bd0a::enable_emergence_spawning( 1 );
        namespace_659599414270bd0a::function_efc0cf237cec322b( var_8bdbf470bbd736c4 );
        namespace_659599414270bd0a::function_cc83d10b65f73ee( var_d8e646f5fdfb1e70 );
        namespace_659599414270bd0a::set_emergence_spawning_through_death_percentage( var_b418cb52dbca2613 );
        
        if ( isdefined( b_force_evolve ) )
        {
            namespace_659599414270bd0a::force_emergence_spawning( b_force_evolve );
        }
        
        return;
    }
    
    if ( utility::issharedfuncdefined( self.subclass, #"hash_ac1e78b85ea96df4" ) )
    {
        if ( var_80443cd4f512c477 )
        {
            val::reset( "round_spawn", "dont_evolve" );
        }
        
        thread utility::callsharedfunc( self.subclass, #"hash_ac1e78b85ea96df4", { #b_force_evolve:b_force_evolve, #var_22f864c06ba32b89:var_22f864c06ba32b89, #var_6312bbd31744f16d:var_6312bbd31744f16d, #var_ae78eaeea8430741:var_ae78eaeea8430741, #var_d8e646f5fdfb1e70:var_d8e646f5fdfb1e70, #var_8d449b07071097c0:var_8d449b07071097c0, #var_aaab9ed74aa76dc2:var_aaab9ed74aa76dc2, #var_b418cb52dbca2613:var_b418cb52dbca2613 } );
    }
}

// Namespace zm_quest
// Params 0, eflags: 0x4
// Checksum 0x24b81681, Offset: 0x865b
// Size: 0x9
function private function_da345476f7b8f714()
{
    vote_system_shared::function_64400cb8ec45efe6();
}

// Namespace zm_quest
// Params 4
// Checksum 0xf49684a, Offset: 0x866c
// Size: 0x7a
function vote_think( e_starter, var_3faf858e79cd17bb, var_601a9be5417aec8c, var_6ed4c2d63a2ca333 )
{
    if ( vote_system_shared::function_932a27e677b1ce60( var_601a9be5417aec8c ) )
    {
        return 0;
    }
    
    s_squad = vote_system_shared::function_5b06e345046c1f58();
    s_vote = vote_system_shared::vote_think( e_starter, var_3faf858e79cd17bb, s_squad, level.var_fa5888e13888b19e, var_601a9be5417aec8c, var_6ed4c2d63a2ca333 );
    return s_vote ? s_vote.b_passed : 0;
}

// Namespace zm_quest
// Params 3
// Checksum 0xbad593e1, Offset: 0x86ef
// Size: 0xd3
function quest_vote_think( e_starter, var_3faf858e79cd17bb, is_final_exfil_vote )
{
    var_2ca1f5b2b79323fb = { #var_166907ebb0de0d4f:0, #var_87e37f4965e851d0:&function_da345476f7b8f714, #var_6ed4c2d63a2ca333:undefined, #var_b72894a2aece4207:undefined, #ask_everyone:undefined, #is_final_exfil_vote:is_final_exfil_vote, #is_quest_vote:1, #is_independent:0, #is_choice:0, #skip_hotjoin:0, #var_5b2ea08e3eb36908:0, #var_eb81a73511f3a2d1:0, #var_601a9be5417aec8c:undefined };
    s_vote = vote_system_shared::function_5877646ce75d19f5( e_starter, var_3faf858e79cd17bb, level.var_fa5888e13888b19e, var_2ca1f5b2b79323fb );
    return s_vote;
}

// Namespace zm_quest
// Params 2
// Checksum 0x6f435a36, Offset: 0x87cb
// Size: 0xca
function player_choice( e_starter, var_3faf858e79cd17bb )
{
    var_2ca1f5b2b79323fb = { #var_166907ebb0de0d4f:0, #var_87e37f4965e851d0:&function_da345476f7b8f714, #var_6ed4c2d63a2ca333:undefined, #var_b72894a2aece4207:undefined, #ask_everyone:undefined, #is_final_exfil_vote:0, #is_quest_vote:0, #is_independent:0, #is_choice:1, #skip_hotjoin:0, #var_5b2ea08e3eb36908:0, #var_eb81a73511f3a2d1:1, #var_601a9be5417aec8c:undefined };
    s_vote = vote_system_shared::function_5877646ce75d19f5( e_starter, var_3faf858e79cd17bb, level.var_fa5888e13888b19e, var_2ca1f5b2b79323fb );
    return s_vote;
}

// Namespace zm_quest
// Params 7
// Checksum 0x118c3862, Offset: 0x889e
// Size: 0xfc
function function_c18b4d9b23790934( e_starter, var_3faf858e79cd17bb, var_601a9be5417aec8c, var_6ed4c2d63a2ca333, var_b72894a2aece4207, var_da6afd4eed7b415b, var_bf284adce0359502 )
{
    var_2ca1f5b2b79323fb = { #var_166907ebb0de0d4f:0, #var_87e37f4965e851d0:&function_da345476f7b8f714, #var_6ed4c2d63a2ca333:var_6ed4c2d63a2ca333, #var_b72894a2aece4207:var_b72894a2aece4207, #ask_everyone:var_bf284adce0359502, #is_final_exfil_vote:0, #is_quest_vote:0, #is_independent:1, #is_choice:0, #skip_hotjoin:1, #var_5b2ea08e3eb36908:var_da6afd4eed7b415b, #var_eb81a73511f3a2d1:0, #var_601a9be5417aec8c:var_601a9be5417aec8c };
    s_vote = vote_system_shared::function_5877646ce75d19f5( e_starter, var_3faf858e79cd17bb, level.var_fa5888e13888b19e, var_2ca1f5b2b79323fb );
    return s_vote;
}

// Namespace zm_quest
// Params 0
// Checksum 0x80dc7af6, Offset: 0x89a3
// Size: 0x12
function function_4cee1b2cda04b53c()
{
    vote_system_shared::function_8d3121fa204f0320( level.var_fa5888e13888b19e );
}

// Namespace zm_quest
// Params 1
// Checksum 0xa84192de, Offset: 0x89bd
// Size: 0x18
function function_7a70a4e0e16c14eb( s_vote )
{
    vote_system_shared::function_5f3e7ae15b92c1a6( s_vote, undefined, 0, 0 );
}

// Namespace zm_quest
// Params 3
// Checksum 0x6d58e98d, Offset: 0x89dd
// Size: 0x2b
function function_7f3e7223420b1ab4( s_vote, var_ab5184cfea519870, var_bf284adce0359502 )
{
    vote_system_shared::function_5f3e7ae15b92c1a6( s_vote, undefined, var_ab5184cfea519870, var_bf284adce0359502 );
}

// Namespace zm_quest
// Params 1
// Checksum 0xa5d6f27d, Offset: 0x8a10
// Size: 0x15
function function_6f2fa8c4032fed5c( s_vote )
{
    vote_system_shared::function_752a0cdea978e60e( s_vote );
}

// Namespace zm_quest
// Params 1
// Checksum 0xa9bc38d2, Offset: 0x8a2d
// Size: 0x15
function function_18b8b1284f9cc97( s_vote )
{
    vote_system_shared::function_ef294a79ae99e889( s_vote );
}

// Namespace zm_quest
// Params 2
// Checksum 0x531ed895, Offset: 0x8a4a
// Size: 0x1f
function function_d35d5b5cb059d60( s_vote, b_vote_accepted )
{
    vote_system_shared::function_559077787377cc42( s_vote, b_vote_accepted );
}

// Namespace zm_quest
// Params 1
// Checksum 0x33688c19, Offset: 0x8a71
// Size: 0x119
function function_47a12c351658a3fc( s_vote )
{
    foreach ( player in level.players )
    {
        if ( vote_system_shared::function_48e94cd3f360f966( s_vote.vote_hud, player ) )
        {
            b_vote_accepted = arraycontains( s_vote.a_players_accepted, player );
            var_47f423505424e8d2 = b_vote_accepted ? 1 : -1;
            vote_result_sound = b_vote_accepted ? #"uin_cer_zm_squadvote_success" : #"hash_4410b48f4b9e6d34";
            s_vote.vote_hud namespace_b6e912eaebaaa52b::set_player_vote( player, var_47f423505424e8d2 );
            s_vote.vote_hud namespace_b6e912eaebaaa52b::set_vote_result( player, var_47f423505424e8d2 );
            player playlocalsound( vote_result_sound );
        }
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0x84f56f13, Offset: 0x8b92
// Size: 0x1f
function function_eaa6dd445369ce09( s_vote, n_delay )
{
    vote_system_shared::function_fd6d54427847bcfd( s_vote, n_delay );
}

// Namespace zm_quest
// Params 3
// Checksum 0xa756b051, Offset: 0x8bb9
// Size: 0x123
function createclientfontstring( text, font, fontscale )
{
    fontelem = newclienthudelem( self );
    fontelem.elemtype = "font";
    fontelem.font = font;
    fontelem.fontscale = fontscale;
    fontelem.basefontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.color = ( 1, 1, 1 );
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem hud_util::setparent( level.uiparent );
    fontelem.hidden = 0;
    fontelem.archived = 0;
    fontelem settext( text );
    return fontelem;
}

// Namespace zm_quest
// Params 3
// Checksum 0xcbcc23f9, Offset: 0x8ce5
// Size: 0x199
function createclientbar( color, width, height )
{
    barelem = newclienthudelem( self );
    barelem.x = 0;
    barelem.y = 0;
    barelem.frac = 0;
    barelem.color = color;
    barelem.sort = -2;
    barelem.shader = "progress_bar_fill";
    barelem setshader( "progress_bar_fill", width, height );
    barelem.hidden = 0;
    barelem.archived = 0;
    barelembg = newclienthudelem( self );
    barelembg.elemtype = "bar";
    barelembg.width = width;
    barelembg.height = height;
    barelembg.xoffset = 0;
    barelembg.yoffset = 0;
    barelembg.bar = barelem;
    barelembg.children = [];
    barelembg.sort = -3;
    barelembg.color = ( 0, 0, 0 );
    barelembg.alpha = 0.5;
    barelembg hud_util::setparent( level.uiparent );
    barelembg setshader( "progress_bar_bg", width + 4, height + 4 );
    barelembg.hidden = 0;
    barelembg.archived = 0;
    return barelembg;
}

// Namespace zm_quest
// Params 0
// Checksum 0x4659d2ff, Offset: 0x8e87
// Size: 0x64
function update_time_progress()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    start_time = gettime();
    
    while ( true )
    {
        bar_fac = utility::function_6f5d2e1f1ff70482( gettime() - start_time ) / 30;
        bar_fac = clamp( bar_fac, 0, 1 );
        hud_util::updatebar( 1 - bar_fac );
        waitframe();
    }
}

// Namespace zm_quest
// Params 10
// Checksum 0xc729c05a, Offset: 0x8ef3
// Size: 0x2d9
function function_b8743f5a9219cf9b( original_pos, targetpos, var_521d025b303e59da, fly_z_offset, angles_blend_speed, var_99dfa1bd6d86270a, var_bb08488146c540f, var_abb9bf56d9a02e67, override_distance, var_f071a0344c75277a )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"delete" );
    self.angles = vectortoangles( ( 0, 0, 1 ) );
    waitframe();
    
    if ( isdefined( var_521d025b303e59da ) && level._effect[ var_521d025b303e59da ] != 0 )
    {
        playfxontag( level._effect[ var_521d025b303e59da ], self, "tag_origin" );
    }
    
    if ( isdefined( var_abb9bf56d9a02e67 ) && var_abb9bf56d9a02e67.size >= 2 )
    {
        self playsound( var_abb9bf56d9a02e67[ 0 ] );
        waitframe();
        self playloopsound( var_abb9bf56d9a02e67[ 1 ] );
    }
    
    wait_duration = var_99dfa1bd6d86270a ?? 1;
    wait wait_duration;
    
    if ( !isdefined( fly_z_offset ) )
    {
        fly_z_offset = 100;
    }
    
    if ( fly_z_offset > 0 )
    {
        self movez( fly_z_offset, 1 );
        self waittill( #"movedone" );
    }
    
    if ( !isdefined( angles_blend_speed ) )
    {
        angles_blend_speed = 0.02;
    }
    
    fly_speed = var_bb08488146c540f ?? 10;
    angles_blend = 0;
    
    while ( isdefined( targetpos ) )
    {
        if ( isent( targetpos ) )
        {
            v_destination = targetpos.origin;
        }
        else
        {
            v_destination = targetpos;
        }
        
        face_angles = vectortoangles( v_destination - self.origin );
        new_angles = anglelerpquatfrac( self.angles, face_angles, angles_blend );
        self.angles = new_angles;
        self.origin = anglestoforward( self.angles ) * fly_speed + self.origin;
        
        if ( angles_blend <= 1 )
        {
            angles_blend += angles_blend_speed;
            angles_blend = clamp( angles_blend, 0, 1 );
        }
        
        if ( !isdefined( var_521d025b303e59da ) )
        {
            /#
                sphere( self.origin, 10, ( 1, 1, 0 ), 0, 500 );
            #/
        }
        
        dis = distancesquared( v_destination, self.origin );
        
        if ( isdefined( override_distance ) )
        {
            if ( dis <= override_distance )
            {
                break;
            }
        }
        else if ( dis <= 100 )
        {
            break;
        }
        
        waitframe();
    }
    
    /#
        sphere( self.origin, 15, ( 1, 0, 0 ), 0, 500 );
    #/
    
    self notify( #"curve_done" );
    level utility::flag_set( "curve_done" );
    
    if ( isdefined( var_abb9bf56d9a02e67 ) && var_abb9bf56d9a02e67.size >= 3 )
    {
        self playsound( var_abb9bf56d9a02e67[ 2 ] );
        waitframe();
        self stoploopsound();
    }
    
    waitframe();
    
    if ( !isdefined( var_f071a0344c75277a ) )
    {
        var_f071a0344c75277a = 1;
    }
    
    if ( isdefined( self ) && var_f071a0344c75277a )
    {
        self delete();
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x7330f509, Offset: 0x91d4
// Size: 0x130
function free_zombies( number )
{
    ais = getaiarray( "team_two_hundred" );
    
    if ( ais.size >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 - number - 2 )
    {
        i = 0;
        
        foreach ( ai in ais )
        {
            ai.var_a13bed1ac47e1b2c = 1;
            ai.no_powerups = 1;
            ai.nocorpse = 1;
            ai.no_powerups = 1;
            ai val::set( "zm_quest", "ignore_cleanup", 1 );
            ai.b_cleanup_no_respawn = 1;
            ai.var_a13bed1ac47e1b2c = 1;
            ai kill();
            i++;
            
            if ( i >= number )
            {
                break;
            }
        }
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0x778fd94b, Offset: 0x930c
// Size: 0x16
function function_765655c7699f9fb7()
{
    level.var_654073823a58b613 = undefined;
    level.var_876df33c4d1c4f08 = undefined;
}

// Namespace zm_quest
// Params 1
// Checksum 0x2efe1408, Offset: 0x932a
// Size: 0x25
function function_fe2a9a31ab8fbcab( var_9e41dd30435985b7 )
{
    level.var_654073823a58b613 = &function_b75cbf51b5e2bbb0;
    level.var_876df33c4d1c4f08 = var_9e41dd30435985b7;
}

// Namespace zm_quest
// Params 0
// Checksum 0x701099ee, Offset: 0x9357
// Size: 0x190
function function_b75cbf51b5e2bbb0()
{
    var_28dfa6f197d4d46a = zone_manager::function_90e5c3e2272b0130( self.origin + ( 0, 0, 32 ) );
    
    if ( isdefined( var_28dfa6f197d4d46a ) )
    {
        str_ignore_zone = var_28dfa6f197d4d46a.zone_name;
    }
    
    var_d741aeceea421b0e = utility::getstructarray( "player_respawn_point", "targetname" );
    var_7d2a636b261c6545 = [];
    
    foreach ( var_1e4139ca72a33905 in var_d741aeceea421b0e )
    {
        var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( var_1e4139ca72a33905.origin );
        
        if ( isdefined( var_8c4fe62d01999d1e ) && isdefined( str_ignore_zone ) && !arraycontains( level.var_876df33c4d1c4f08, var_8c4fe62d01999d1e.zone_name ) )
        {
            continue;
        }
        
        if ( zone_manager::function_65305a611c6226d9( var_1e4139ca72a33905.origin ) )
        {
            var_7d2a636b261c6545[ var_7d2a636b261c6545.size ] = var_1e4139ca72a33905;
        }
    }
    
    var_a87104a582b02a9e = undefined;
    
    if ( var_7d2a636b261c6545.size > 0 )
    {
        var_ba4504ab9b6e7a9a = utility::array_random( var_7d2a636b261c6545 );
        var_aa9244ac3dd1149 = utility::getstructarray( var_ba4504ab9b6e7a9a.target, "targetname" );
        var_c4dbda4969a702ac = self getentitynumber();
        var_a87104a582b02a9e = var_aa9244ac3dd1149[ var_c4dbda4969a702ac ];
    }
    
    return var_a87104a582b02a9e;
}

// Namespace zm_quest
// Params 1
// Checksum 0x98f127a6, Offset: 0x94f0
// Size: 0x32
function disable_specific_player_bgb( var_94d1ab5da995e573 )
{
    if ( var_94d1ab5da995e573 )
    {
        val::set( "disable_specific_player_bgb", "allow_scripted_bgb_use", 0 );
        return;
    }
    
    val::reset_all( "disable_specific_player_bgb" );
}

// Namespace zm_quest
// Params 0
// Checksum 0xaa8eb777, Offset: 0x952a
// Size: 0xd
function function_d7216beb89a22329()
{
    level.var_eeb6ebe322e71cd1 = 1;
}

// Namespace zm_quest
// Params 0
// Checksum 0x4af25063, Offset: 0x953f
// Size: 0xc
function function_d04a18ed4295a8cd()
{
    level.var_eeb6ebe322e71cd1 = undefined;
}

// Namespace zm_quest
// Params 0
// Checksum 0x929bca81, Offset: 0x9553
// Size: 0x10
function function_7d75aa8ca4d23fd()
{
    level.var_2fb58637e118b8bd = &function_257b383ff3e70ec6;
}

// Namespace zm_quest
// Params 1
// Checksum 0xb09b8341, Offset: 0x956b
// Size: 0xd, Type: bool
function function_257b383ff3e70ec6( params )
{
    return false;
}

// Namespace zm_quest
// Params 0
// Checksum 0x71f300c7, Offset: 0x9581
// Size: 0xc
function function_d51b7a8bcd03969a()
{
    level.var_2fb58637e118b8bd = undefined;
}

// Namespace zm_quest
// Params 1
// Checksum 0x80d9c960, Offset: 0x9595
// Size: 0xa9
function get_specific_ai_count( aitype )
{
    n_count = 0;
    zombies = getaiarray( "team_two_hundred" );
    
    foreach ( zombie in zombies )
    {
        if ( zombie.subclass == aitype )
        {
            n_count++;
        }
    }
    
    return n_count;
}

// Namespace zm_quest
// Params 4
// Checksum 0x99d80866, Offset: 0x9647
// Size: 0x3da
function function_3477750f338de598( s_destination, exfil_title, b_fade_to_black = 1, n_fade_out_time = 0.25 )
{
    if ( getdvarint( @"hash_24ce4359896128f", 0 ) )
    {
        b_ended_game = function_5df636f8e334ab81( s_destination, undefined, b_fade_to_black );
        return b_ended_game;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player function_adc80aa6cf639396();
            
            if ( b_fade_to_black )
            {
                level thread game_utility::fadetoblackforplayerkeepui( player, 1, n_fade_out_time );
            }
        }
    }
    
    wait 0.25;
    
    if ( isdefined( level.directed_mode ) )
    {
        level.b_zm_game_over = 1;
        level thread gamelogic_zm::endgame( getdvar( @"scr_force_team", "allies" ), game[ "end_reason" ][ "objective_completed" ] );
        return 1;
    }
    
    var_3faf858e79cd17bb = spawnstruct();
    var_3faf858e79cd17bb.init_message = exfil_title;
    s_vote = quest_vote_think( undefined, var_3faf858e79cd17bb, 1 );
    
    if ( s_vote.a_players_accepted.size == level.players.size )
    {
        level callback::callback( "zm_exfil_success" );
        level.b_zm_game_over = 1;
        zm_exfil::function_8f261015e4f861ae( 1 );
        
        if ( b_fade_to_black )
        {
            foreach ( player in level.players )
            {
                level utility::delaythreadendon( 0.25, "disconnect", &game_utility::fadetoblackforplayerkeepui, player, 0, 0.25 );
            }
            
            wait 0.5;
        }
        
        level thread gamelogic_zm::endgame( getdvar( @"scr_force_team", "allies" ), game[ "end_reason" ][ "objective_completed" ] );
        return 1;
    }
    
    if ( s_vote.a_players_declined.size > 0 )
    {
        foreach ( player in level.players )
        {
            if ( player.var_ed9be6e0aa7daf4d )
            {
                s_vote.a_players_accepted = arrayremove( s_vote.a_players_accepted, player );
                s_vote.a_players_declined = arraycombineunique( s_vote.a_players_declined, [ player ] );
                player.var_ed9be6e0aa7daf4d = undefined;
            }
        }
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && arraycontains( s_vote.a_players_accepted, player ) && !player ishost() )
        {
            player thread function_23e1a6e7fe7093f5();
            continue;
        }
        
        player thread function_e14af363c6e9d5b7( s_destination, b_fade_to_black, n_fade_out_time );
    }
    
    return 0;
}

// Namespace zm_quest
// Params 0, eflags: 0x4
// Checksum 0xaa5654ab, Offset: 0x9a2a
// Size: 0x94
function private function_adc80aa6cf639396()
{
    val::set( "quest_final_exfil", "allow_movement", 0 );
    val::set( "quest_final_exfil", "killstreaks", 0 );
    val::set( "quest_final_exfil", "freezecontrols_allowlook", 1 );
    val::set( "quest_final_exfil", "ignoreme", 1 );
    val::set( "quest_final_exfil", "fire", 0 );
    val::set( "quest_final_exfil", "show_hud", 0 );
    val::set( "quest_final_exfil", "allow_jump", 0 );
    val::set( "quest_final_exfil", "allow_battlechatter_vo", 0 );
}

// Namespace zm_quest
// Params 3
// Checksum 0x7c61e2fa, Offset: 0x9ac6
// Size: 0x519, Type: bool
function function_5df636f8e334ab81( s_destination, b_ignore_end_game = 0, b_fade_to_black = 1 )
{
    if ( utility::flag( "zm_vote_active" ) || utility::flag( "exfil_active" ) )
    {
        return false;
    }
    
    utility::flag_set( "zm_vote_active" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player function_adc80aa6cf639396();
            
            if ( b_fade_to_black )
            {
                level thread game_utility::fadetoblackforplayerkeepui( player, 1, 0.25 );
            }
        }
    }
    
    if ( b_fade_to_black )
    {
        wait 0.25;
    }
    
    var_a68d8c6d03bd08a4 = 1;
    
    if ( !isdefined( level.directed_mode ) )
    {
        s_vote = function_21310dadbeead810();
        var_a68d8c6d03bd08a4 = s_vote.a_players_declined.size == level.players.size;
    }
    
    if ( var_a68d8c6d03bd08a4 && !b_ignore_end_game )
    {
        level.b_zm_game_over = 1;
        
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_zm_mq_complete", 1 );
            
            if ( level.var_ac69b2dd43dca6f8 namespace_db949aa4357455dc::is_open( player ) )
            {
                level.var_ac69b2dd43dca6f8 namespace_db949aa4357455dc::close( player );
            }
        }
        
        zm_exfil::function_8f261015e4f861ae( 1 );
        
        foreach ( player in level.players )
        {
            if ( b_fade_to_black )
            {
                level utility::delaythreadendon( 0.25, "disconnect", &game_utility::fadetoblackforplayerkeepui, player, 0, 0.25 );
            }
        }
        
        wait 0.5;
        level thread gamelogic_zm::endgame( getdvar( @"scr_force_team", "allies" ), game[ "end_reason" ][ "objective_completed" ] );
        utility::flag_clear( "zm_vote_active" );
        level callback::callback( "zm_exfil_success" );
        return true;
    }
    
    if ( s_vote.a_players_accepted.size > 0 )
    {
        foreach ( player in level.players )
        {
            if ( player.var_ed9be6e0aa7daf4d )
            {
                s_vote.a_players_declined = arrayremove( s_vote.a_players_declined, player );
                s_vote.a_players_accepted = arraycombineunique( s_vote.a_players_accepted, [ player ] );
                player.var_ed9be6e0aa7daf4d = undefined;
            }
        }
    }
    
    foreach ( player in level.players )
    {
        if ( level.var_ac69b2dd43dca6f8 namespace_db949aa4357455dc::is_open( player ) )
        {
            level.var_ac69b2dd43dca6f8 namespace_db949aa4357455dc::close( player );
        }
    }
    
    foreach ( player in s_vote.a_players_accepted )
    {
        player thread function_e14af363c6e9d5b7( s_destination, 1, 0 );
    }
    
    foreach ( player in s_vote.a_players_declined )
    {
        player thread function_23e1a6e7fe7093f5( b_ignore_end_game );
    }
    
    utility::flag_clear( "zm_vote_active" );
    return false;
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0xded788cc, Offset: 0x9fe8
// Size: 0x201
function private function_21310dadbeead810( b_fade_to_black, n_fade_out_time )
{
    s_vote = { #a_players_declined:[], #a_players_accepted:[] };
    
    foreach ( player in level.players )
    {
        player thread function_5b241be79c9b7056( s_vote );
    }
    
    n_timeout = 30;
    
    while ( n_timeout > 0 )
    {
        s_vote.a_players_accepted = function_5713d46873b29625( s_vote.a_players_accepted );
        s_vote.a_players_declined = function_5713d46873b29625( s_vote.a_players_declined );
        n_players_selected_option = s_vote.a_players_accepted.size + s_vote.a_players_declined.size;
        
        if ( n_players_selected_option >= level.players.size )
        {
            break;
        }
        
        wait 0.5;
        n_timeout -= 0.5;
    }
    
    if ( n_timeout <= 0 )
    {
        level notify( #"hash_c1d3db4322e3170d" );
    }
    
    foreach ( player in level.players )
    {
        if ( !arraycontains( s_vote.a_players_accepted, player ) && !arraycontains( s_vote.a_players_declined, player ) )
        {
            s_vote.a_players_declined[ s_vote.a_players_declined.size ] = player;
        }
    }
    
    return s_vote;
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0x186c27fc, Offset: 0xa1f2
// Size: 0x1dd, Type: bool
function private function_5b241be79c9b7056( s_vote )
{
    level endon( #"hash_c1d3db4322e3170d" );
    self endon( #"disconnect" );
    
    if ( !level.var_ac69b2dd43dca6f8 namespace_db949aa4357455dc::is_open( self ) )
    {
        level.var_ac69b2dd43dca6f8 namespace_db949aa4357455dc::open( self );
    }
    
    if ( isbot( self ) && isalive( self ) && self.sessionstate == "playing" )
    {
        wait getdvarint( @"hash_b4e387faf907c31f", 4 );
        
        if ( getdvarint( @"hash_6e8b31590c83b6", 0 ) )
        {
            msg = "ui_zm_quest_continue_playing";
        }
        else
        {
            msg = "ui_zm_quest_finish_playing";
        }
    }
    else if ( !isbot( self ) && isalive( self ) && self.sessionstate == "playing" )
    {
        while ( true )
        {
            self waittill( #"luinotifyserver", result, value );
            
            if ( value == self getentitynumber() )
            {
                if ( result == "ui_zm_quest_continue_playing" )
                {
                    msg = "ui_zm_quest_continue_playing";
                    break;
                }
                
                if ( result == "ui_zm_quest_finish_playing" )
                {
                    msg = "ui_zm_quest_finish_playing";
                    break;
                }
            }
        }
    }
    else
    {
        msg = "ui_zm_quest_finish_playing";
        self.var_ed9be6e0aa7daf4d = 1;
    }
    
    if ( level.var_ac69b2dd43dca6f8 namespace_db949aa4357455dc::is_open( self ) )
    {
        level.var_ac69b2dd43dca6f8 namespace_db949aa4357455dc::close( self );
    }
    
    if ( !isdefined( msg ) )
    {
        return false;
    }
    
    if ( msg == "ui_zm_quest_continue_playing" )
    {
        self playlocalsound( "uin_cer_zm_squadvote_accept" );
        s_vote.a_players_accepted[ s_vote.a_players_accepted.size ] = self;
        return true;
    }
    else if ( msg == "ui_zm_quest_finish_playing" )
    {
        self playlocalsound( "uin_cer_zm_squadvote_decline" );
        s_vote.a_players_declined[ s_vote.a_players_declined.size ] = self;
        return false;
    }
    
    return false;
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0x71d08ce2, Offset: 0xa3d8
// Size: 0x13f
function private function_23e1a6e7fe7093f5( b_ignore_end_game = 0 )
{
    self endon( #"disconnect" );
    level thread game_utility::fadetoblackforplayerkeepui( self, 0, 0.25 );
    val::reset_all( "quest_final_exfil" );
    
    if ( b_ignore_end_game || self ishost() )
    {
        return;
    }
    
    spawnpoint = spawnstruct();
    spawnpoint.origin = self.exfilpos;
    spawnpoint.angles = self.angles;
    playerlogic::removefromalivecount( 1 );
    teams::validatealivecount( "extract", self.team, self );
    thread playerlogic::spawnspectator( spawnpoint.origin, spawnpoint.angles, 1 );
    self freezecontrols( 1 );
    self playerhide();
    self setclientdvar( @"ui_opensummary", 1 );
    gamelogic_zm::function_f8889f49a761d327( self );
    gamelogic_zm::function_aef8211f6eecb301( self );
    self setclientomnvar( "ui_zm_mq_complete", 1 );
    self setclientomnvar( "post_game_state", 5 );
    thread hud_message::teamoutcomenotify( self.team, 0, game[ "end_reason" ][ "objective_completed" ] );
    wait 5;
    kick( self getentitynumber(), &"exe/playerkicked_extracted" );
}

// Namespace zm_quest
// Params 3, eflags: 0x4
// Checksum 0xfa8b2aee, Offset: 0xa51f
// Size: 0xe3
function private function_e14af363c6e9d5b7( s_destination, b_fade_to_black, n_fade_out_time )
{
    self endon( #"disconnect" );
    val::reset_all( "quest_final_exfil" );
    
    if ( !isalive( self ) || self.sessionstate == "spectator" )
    {
        self.var_14955bc056bab547 = 1;
        thread playerlogic::spawnclient();
    }
    else if ( self.inlaststand )
    {
        thread laststand::exit( "last_stand_self_revive" );
    }
    
    if ( b_fade_to_black )
    {
        level utility::delaythread( 0.5, &game_utility::fadetoblackforplayerkeepui, self, 0, 0.25 );
    }
    
    while ( !isalive( self ) || self.sessionstate == "spectator" )
    {
        waitframe();
    }
    
    if ( isdefined( s_destination ) )
    {
        level thread zm_fasttravel::function_cbb08198e7c84adf( s_destination, self, undefined, undefined, n_fade_out_time );
    }
    
    self setclientdvar( @"ui_opensummary", 1 );
}

/#

    // Namespace zm_quest
    // Params 1
    // Checksum 0xb26bfaca, Offset: 0xa60a
    // Size: 0xdf, Type: dev
    function function_8a9e1480fc21c85b( s_vote )
    {
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        self.vote_hud.var_a8e853f391b80753 = createclientfontstring( "<dev string:x285>", "<dev string:x5be>", 1 );
        self.vote_hud.var_a8e853f391b80753 hud_util::setpoint( "<dev string:x5c6>", "<dev string:x5c6>", 20, 75 );
        self.vote_hud.var_a8e853f391b80753 endon( #"death" );
        
        while ( true )
        {
            if ( isdefined( s_vote.n_players_needed ) )
            {
                self.vote_hud.var_a8e853f391b80753 setdevtext( "<dev string:x5cb>" + s_vote.n_players_needed + "<dev string:x5d1>" );
            }
            
            wait 0.1;
        }
    }

#/

// Namespace zm_quest
// Params 11
// Checksum 0xc9778b6b, Offset: 0xa6f1
// Size: 0x95b
function cleanup_zombies_manually( var_77585a99f124122f, var_13dd6ed97b00e2af, original_position, radius, var_d69b33c803d79f0a, var_5db89d8aea223286, b_force_all_zombies, var_4f8258f941f93bfd, b_skip_audio, b_flash_duration, var_1ef9bf2210b88ae0 )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( b_flash_duration ) )
    {
        b_flash_duration = 1;
    }
    
    if ( !var_5db89d8aea223286 )
    {
        var_1ef9bf2210b88ae0 = 0;
        
        if ( isdefined( var_13dd6ed97b00e2af ) )
        {
            screen_flash_players = [];
            
            foreach ( player in level.players )
            {
                zone = player zone_manager::get_current_zone();
                var_51a1bd2599589421 = isdefined( zone ) && ( isarray( var_13dd6ed97b00e2af ) && arraycontains( var_13dd6ed97b00e2af, zone.zone_name ) || !isarray( var_13dd6ed97b00e2af ) && zone.zone_name == var_13dd6ed97b00e2af );
                
                if ( var_51a1bd2599589421 )
                {
                    screen_flash_players[ screen_flash_players.size ] = player;
                    
                    if ( !b_skip_audio )
                    {
                        player playsoundevent( %"sndevent_powerup_nuke" );
                    }
                    
                    player thread function_9983e3b5a8247550( 0.3, 1 );
                }
            }
            
            wait 0.96;
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( !b_skip_audio )
                {
                    player playsoundevent( %"sndevent_powerup_nuke" );
                }
            }
            
            function_dde171cfa89fecfa( 0.3, 1 );
        }
    }
    
    foreach ( player in level.players )
    {
        player val::set( "cleanup_player_protection", "damage", 0 );
    }
    
    wait 0.5;
    var_3b8ce4aed8a00de7 = [];
    zombies = [];
    var_50fe4df5540f411a = zm_utility::get_active_zombies();
    
    if ( var_4f8258f941f93bfd && isdefined( var_13dd6ed97b00e2af ) )
    {
        foreach ( zombie in var_50fe4df5540f411a )
        {
            zombie_zone_struct = zombie zone_manager::get_current_zone();
            
            if ( isdefined( zombie_zone_struct ) && ( isarray( var_13dd6ed97b00e2af ) && arraycontains( var_13dd6ed97b00e2af, zombie_zone_struct.zone_name ) || !isarray( var_13dd6ed97b00e2af ) && var_13dd6ed97b00e2af == zombie_zone_struct.zone_name ) )
            {
                zombies[ zombies.size ] = zombie;
            }
        }
    }
    else if ( isdefined( original_position ) && isdefined( radius ) )
    {
        zombies_in_radius = getaiarrayinradius( original_position, radius, "team_two_hundred" );
        
        foreach ( var_915257d4b1251540 in zombies_in_radius )
        {
            if ( arraycontains( var_50fe4df5540f411a, var_915257d4b1251540 ) )
            {
                zombies[ zombies.size ] = var_915257d4b1251540;
            }
        }
    }
    else
    {
        zombies = zm_utility::get_active_zombies();
    }
    
    zombies = utility::array_removedead_or_dying( zombies );
    
    foreach ( zombie in zombies )
    {
        if ( isdefined( var_13dd6ed97b00e2af ) && !zombie.b_ignore_cleanup )
        {
            zone_name = zone_manager::function_ac62281be3d43322( zombie.origin );
            
            if ( !isdefined( zone_name ) )
            {
                zone_name = zombie.spawn_loc.zone_name;
            }
            
            if ( zone_name )
            {
                var_9180f9c7d87e2236 = isarray( var_13dd6ed97b00e2af ) && arraycontains( var_13dd6ed97b00e2af, zone_name ) || !isarray( var_13dd6ed97b00e2af ) && zone_name == var_13dd6ed97b00e2af;
                
                if ( var_9180f9c7d87e2236 )
                {
                    var_3b8ce4aed8a00de7[ var_3b8ce4aed8a00de7.size ] = zombie;
                    zombie.var_a13bed1ac47e1b2c = 1;
                }
            }
            
            continue;
        }
        
        if ( b_force_all_zombies )
        {
            var_3b8ce4aed8a00de7[ var_3b8ce4aed8a00de7.size ] = zombie;
            zombie.var_a13bed1ac47e1b2c = 1;
            continue;
        }
        
        if ( !zombie.b_ignore_cleanup )
        {
            var_3b8ce4aed8a00de7[ var_3b8ce4aed8a00de7.size ] = zombie;
            zombie.var_a13bed1ac47e1b2c = 1;
        }
    }
    
    var_3d785e8e4d6745c9 = b_flash_duration * 1000;
    
    if ( var_d69b33c803d79f0a )
    {
        cleanup_func = var_77585a99f124122f ? undefined : &function_f98c783a2e11dde3;
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player thread nuke::function_6c5906115e825d8f( player.origin, var_3b8ce4aed8a00de7, "nuke", 1, cleanup_func );
                break;
            }
        }
    }
    else
    {
        var_4ce2be89357100be = 0;
        
        foreach ( zombie in var_3b8ce4aed8a00de7 )
        {
            if ( var_1ef9bf2210b88ae0 )
            {
                zombie.full_gib = 1;
                zombie.forceannihilate = 1;
            }
            else if ( !var_5db89d8aea223286 )
            {
                zombie.nocorpse = 1;
            }
            
            if ( ( zombie.aicategory == "elite" || zombie.aicategory == "hvt" ) && !var_77585a99f124122f && !b_force_all_zombies )
            {
                if ( !zombie zm_cleanup_manager::teleport_zombie() )
                {
                    if ( zombie.magic_bullet_shield || zombie.damageshield )
                    {
                        if ( !zombie val::get( "damageshield_allow_delete" ) )
                        {
                            continue;
                        }
                        
                        zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
                    }
                    
                    if ( !zombie.ignore_enemy_count )
                    {
                        zombie zm_cleanup_manager::function_dd62e2042418b7e5();
                    }
                    
                    zombie kill();
                    var_4ce2be89357100be++;
                    
                    if ( var_4ce2be89357100be >= 2 )
                    {
                        var_4ce2be89357100be = 0;
                        var_3d785e8e4d6745c9 -= getframeduration();
                        waitframe();
                    }
                }
                
                continue;
            }
            
            if ( zombie.magic_bullet_shield || zombie.damageshield )
            {
                if ( !zombie val::get( "damageshield_allow_delete" ) )
                {
                    continue;
                }
                
                zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
            }
            
            if ( !var_77585a99f124122f && !zombie.ignore_enemy_count )
            {
                zombie zm_cleanup_manager::function_dd62e2042418b7e5();
            }
            
            zombie kill();
            var_4ce2be89357100be++;
            
            if ( var_4ce2be89357100be >= 2 )
            {
                var_4ce2be89357100be = 0;
                var_3d785e8e4d6745c9 -= getframeduration();
                waitframe();
            }
        }
        
        removeallcorpses();
    }
    
    if ( var_3d785e8e4d6745c9 >= 0 )
    {
        wait var_3d785e8e4d6745c9 * 0.001;
    }
    
    if ( !var_5db89d8aea223286 )
    {
        if ( isdefined( var_13dd6ed97b00e2af ) && isdefined( screen_flash_players ) )
        {
            foreach ( player in screen_flash_players )
            {
                player thread function_edeaa43aa04b462b( 0.5 );
            }
            
            wait 1.63;
        }
        else
        {
            function_6d1da30199c231db( 0.5 );
        }
    }
    
    foreach ( player in level.players )
    {
        player val::reset_all( "cleanup_player_protection" );
    }
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0x60a2c778, Offset: 0xb054
// Size: 0x24
function private function_f98c783a2e11dde3( zombie )
{
    if ( !zombie.ignore_enemy_count )
    {
        zombie zm_cleanup_manager::function_dd62e2042418b7e5();
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0xcc36b21b, Offset: 0xb080
// Size: 0x17b
function function_dde171cfa89fecfa( var_24c3037417857a23, n_target_alpha )
{
    if ( isdefined( level.white_screen_overlay ) )
    {
        return;
    }
    
    level.white_screen_overlay = newhudelem();
    level.white_screen_overlay.x = 0;
    level.white_screen_overlay.y = 0;
    level.white_screen_overlay setshader( "white", 640, 480 );
    level.white_screen_overlay.alignx = "left";
    level.white_screen_overlay.aligny = "top";
    level.white_screen_overlay.sort = 1;
    level.white_screen_overlay.horzalign = "fullscreen";
    level.white_screen_overlay.vertalign = "fullscreen";
    level.white_screen_overlay.alpha = 0;
    level.white_screen_overlay.foreground = 1;
    level.white_screen_overlay.archived = 0;
    screen_alpha = 0;
    rate = float( n_target_alpha ) / float( var_24c3037417857a23 * 100 );
    
    while ( true )
    {
        screen_alpha += rate;
        set_white_screen( screen_alpha );
        
        if ( screen_alpha >= n_target_alpha )
        {
            break;
        }
        
        wait 0.01;
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0x4297d8ab, Offset: 0xb203
// Size: 0x1d0
function function_9983e3b5a8247550( var_24c3037417857a23, n_target_alpha )
{
    self endon( #"disconnect" );
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        while ( isdefined( self.white_screen_overlay ) )
        {
            wait 0.5;
        }
        
        level utility::flag_set( "player_" + self getentitynumber() + "_screen_flashed" );
        return;
    }
    
    self.white_screen_overlay = newclienthudelem( self );
    self.white_screen_overlay.x = 0;
    self.white_screen_overlay.y = 0;
    self.white_screen_overlay setshader( "white", 640, 480 );
    self.white_screen_overlay.alignx = "left";
    self.white_screen_overlay.aligny = "top";
    self.white_screen_overlay.sort = 1;
    self.white_screen_overlay.horzalign = "fullscreen";
    self.white_screen_overlay.vertalign = "fullscreen";
    self.white_screen_overlay.alpha = 0;
    self.white_screen_overlay.foreground = 1;
    self.white_screen_overlay.archived = 0;
    screen_alpha = 0;
    rate = float( n_target_alpha ) / float( var_24c3037417857a23 * 100 );
    
    while ( true )
    {
        screen_alpha += rate;
        function_743203d27737e1bd( screen_alpha );
        
        if ( screen_alpha >= n_target_alpha )
        {
            break;
        }
        
        wait 0.01;
    }
    
    level utility::flag_set( "player_" + self getentitynumber() + "_screen_flashed" );
}

// Namespace zm_quest
// Params 1
// Checksum 0xe5617008, Offset: 0xb3db
// Size: 0x96
function function_6d1da30199c231db( var_24c3037417857a23 )
{
    if ( !isdefined( level.white_screen_overlay ) )
    {
        return;
    }
    
    screen_alpha = level.white_screen_overlay.alpha;
    rate = float( screen_alpha ) / float( var_24c3037417857a23 * 100 );
    
    while ( true )
    {
        screen_alpha -= rate;
        set_white_screen( screen_alpha );
        wait 0.01;
        
        if ( screen_alpha <= 0 )
        {
            break;
        }
    }
    
    if ( isdefined( level.white_screen_overlay ) )
    {
        level.white_screen_overlay destroy();
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x8f492bcb, Offset: 0xb479
// Size: 0x96
function function_edeaa43aa04b462b( var_24c3037417857a23 )
{
    if ( !isdefined( self.white_screen_overlay ) )
    {
        return;
    }
    
    screen_alpha = self.white_screen_overlay.alpha;
    rate = float( screen_alpha ) / float( var_24c3037417857a23 * 100 );
    
    while ( true )
    {
        screen_alpha -= rate;
        function_743203d27737e1bd( screen_alpha );
        wait 0.01;
        
        if ( screen_alpha <= 0 )
        {
            break;
        }
    }
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay destroy();
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0xdb075bf1, Offset: 0xb517
// Size: 0x36
function set_white_screen( screen_alpha )
{
    if ( isdefined( level.white_screen_overlay ) )
    {
        level.white_screen_overlay.alpha = clamp( screen_alpha, 0, 1 );
    }
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0x8e938e6a, Offset: 0xb555
// Size: 0x36
function private function_743203d27737e1bd( screen_alpha )
{
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay.alpha = clamp( screen_alpha, 0, 1 );
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0x409dfbe4, Offset: 0xb593
// Size: 0xc0
function function_80483728d5b044a2( time, earthquake_scale, earthquake_radius, override_rumble )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( earthquake_scale ) )
    {
        earthquake_scale = 0.3;
    }
    
    if ( !isdefined( earthquake_radius ) )
    {
        earthquake_radius = 1000;
    }
    
    if ( !isdefined( override_rumble ) )
    {
        override_rumble = "damage_light";
    }
    
    start_time = gettime();
    
    while ( true )
    {
        lasttime = utility::function_6f5d2e1f1ff70482( gettime() - start_time );
        self earthquakeforplayer( earthquake_scale, 0.1, self.origin, earthquake_radius );
        self playrumbleonentity( override_rumble );
        
        if ( lasttime > time )
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_quest
// Params 3
// Checksum 0x56335ca5, Offset: 0xb65b
// Size: 0x92
function function_7a193b5cd4ce0202( earthquake_scale, earthquake_radius, override_rumble )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"stop_camera_shake_rumber" );
    
    if ( !isdefined( earthquake_scale ) )
    {
        earthquake_scale = 0.3;
    }
    
    if ( !isdefined( earthquake_radius ) )
    {
        earthquake_radius = 1000;
    }
    
    if ( !isdefined( override_rumble ) )
    {
        override_rumble = "damage_light";
    }
    
    while ( true )
    {
        self earthquakeforplayer( earthquake_scale, 0.1, self.origin, earthquake_radius );
        self playrumbleonentity( override_rumble );
        wait 0.1;
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0xd2170c77, Offset: 0xb6f5
// Size: 0x135
function function_537ffe28010f5e83( earthquake_scale, earthquake_radius, override_rumble, rumble_radius )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"stop_camera_shake_rumber" );
    
    if ( !isdefined( earthquake_scale ) )
    {
        earthquake_scale = 0.3;
    }
    
    if ( !isdefined( earthquake_radius ) )
    {
        earthquake_radius = 1000;
    }
    
    if ( !isdefined( override_rumble ) )
    {
        override_rumble = "damage_light";
    }
    
    if ( !isdefined( rumble_radius ) )
    {
        rumble_radius = 1000;
    }
    
    while ( true )
    {
        earthquake( earthquake_scale, 0.1, self.origin, earthquake_radius );
        players = getplayersinradius( self.origin, rumble_radius );
        
        foreach ( player in players )
        {
            if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
            {
                continue;
            }
            
            player playrumbleonentity( override_rumble );
        }
        
        wait 0.1;
    }
}

// Namespace zm_quest
// Params 3
// Checksum 0xc52a1b9e, Offset: 0xb832
// Size: 0x91
function function_6c4de661b29fc88c( earthquake_scale, earthquake_radius, override_rumble )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"stop_camera_shake_rumber" );
    
    if ( !isdefined( earthquake_scale ) )
    {
        earthquake_scale = 0.3;
    }
    
    if ( !isdefined( earthquake_radius ) )
    {
        earthquake_radius = 1000;
    }
    
    if ( !isdefined( override_rumble ) )
    {
        override_rumble = "damage_light";
    }
    
    while ( true )
    {
        earthquake( earthquake_scale, 0.1, self.origin, earthquake_radius );
        self playrumbleonentity( override_rumble );
        wait 0.1;
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0xc14350f, Offset: 0xb8cb
// Size: 0x74
function function_640be494549054c8( earthquake_scale, earthquake_radius )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"stop_camera_shake_rumber" );
    
    if ( !isdefined( earthquake_scale ) )
    {
        earthquake_scale = 0.3;
    }
    
    if ( !isdefined( earthquake_radius ) )
    {
        earthquake_radius = 1000;
    }
    
    while ( true )
    {
        earthquake( earthquake_scale, 0.1, self.origin, earthquake_radius );
        wait 0.1;
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0x490d0f55, Offset: 0xb947
// Size: 0xe
function function_8ae84a0e3ff864b0()
{
    self notify( #"stop_camera_shake_rumber" );
}

// Namespace zm_quest
// Params 1
// Checksum 0x41f66b98, Offset: 0xb95d
// Size: 0xfe
function function_c83051c4765753ac( n_round_num )
{
    zombie_utils::set_zombie_round_difficulty( n_round_num );
    
    if ( self.subclass == "zombie_base" || self.subclass == "zombie_base_armored_heavy" || self.subclass == "zombie_parasite" || self.subclass == "zombie_vermin" )
    {
        self.kiastring = #"zombie_kia_mission_kill";
    }
    else if ( self.subclass == "zombie_mangler" || self.subclass == "zombie_mimic" )
    {
        self.kiastring = #"zombie_kia_mission_kill_special";
    }
    else if ( self.subclass == "zombie_amalgam_nathan" )
    {
        self.kiastring = #"zombie_kia_elite_nathan";
    }
    else
    {
        self.kiastring = #"zombie_kia_mission_kill_elite";
    }
    
    self.no_powerups = 1;
    self.var_7ee152b43c7188e1 = 1;
}

// Namespace zm_quest
// Params 2
// Checksum 0x8f57dc2d, Offset: 0xba63
// Size: 0x17f
function function_d1ab96f924ba75f4( dis_check, var_c6317c958fe750a3 = 0 )
{
    level endon( #"game_ended" );
    var_4dcff7b91f7ed893 = 0;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            dis = distancesquared( player.origin, self.origin );
            
            if ( dis < squared( dis_check ) && abs( player.origin[ 2 ] - self.origin[ 2 ] ) < 20 )
            {
                if ( var_c6317c958fe750a3 )
                {
                    view_pos = player geteye();
                    view_forward = anglestoforward( player getplayerangles() );
                    normal = vectornormalize( self.origin - view_pos );
                    dot = vectordot( view_forward, normal );
                    
                    if ( dot > 0.7 )
                    {
                        var_4dcff7b91f7ed893 = 1;
                        break;
                    }
                }
                else
                {
                    var_4dcff7b91f7ed893 = 1;
                }
                
                break;
            }
        }
        
        if ( var_4dcff7b91f7ed893 )
        {
            break;
        }
        
        quest_throttle_wait();
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x47e1c85c, Offset: 0xbbea
// Size: 0x101
function function_86087eb932daecb9( dis_check )
{
    level endon( #"game_ended" );
    var_4dcff7b91f7ed893 = 0;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            dis = distancesquared( ( player.origin[ 0 ], player.origin[ 1 ], 0 ), ( self.origin[ 0 ], self.origin[ 1 ], 0 ) );
            
            if ( dis < squared( dis_check ) )
            {
                var_4dcff7b91f7ed893 = 1;
                break;
            }
        }
        
        if ( var_4dcff7b91f7ed893 )
        {
            break;
        }
        
        quest_throttle_wait();
    }
}

// Namespace zm_quest
// Params 3
// Checksum 0xaacd45b9, Offset: 0xbcf3
// Size: 0xa0
function player_distance_and_look_at_for_duration_looping_check( dis_check, var_4c4cef69bd88cd0d, var_31688a0f3073df86 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_23483437d9201194" );
    var_5dfe03e530764070 = gettime();
    
    if ( !isdefined( var_31688a0f3073df86 ) )
    {
        var_31688a0f3073df86 = 0;
    }
    
    while ( true )
    {
        b_has_player_look_at = function_c003bcea47ed77fe( dis_check, var_4c4cef69bd88cd0d );
        
        if ( !b_has_player_look_at )
        {
            var_5dfe03e530764070 = gettime();
        }
        else if ( gettime() - var_5dfe03e530764070 > utility::function_4b74c15943231980( var_31688a0f3073df86 ) )
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_quest
// Params 3
// Checksum 0xf0f30b43, Offset: 0xbd9b
// Size: 0x79
function player_distance_and_look_at_looping_check( dis_check, var_4c4cef69bd88cd0d, interval = 0.1 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_c77e7f75ec06d7bb" );
    b_has_player_look_at = 0;
    
    while ( true )
    {
        b_has_player_look_at = function_c003bcea47ed77fe( dis_check, var_4c4cef69bd88cd0d );
        
        if ( b_has_player_look_at )
        {
            break;
        }
        
        wait interval;
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0x48d324d7, Offset: 0xbe1c
// Size: 0x11d, Type: bool
function function_c003bcea47ed77fe( dis_check, var_4c4cef69bd88cd0d )
{
    foreach ( player in level.players )
    {
        view_pos = player geteye();
        view_forward = anglestoforward( player getplayerangles() );
        normal = vectornormalize( self.origin - view_pos );
        dot = vectordot( view_forward, normal );
        dis = distancesquared( self.origin, player.origin );
        
        if ( dis < squared( dis_check ) )
        {
            if ( !var_4c4cef69bd88cd0d )
            {
                if ( dot > 0.7 )
                {
                    return true;
                }
                
                continue;
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace zm_quest
// Params 8
// Checksum 0x6d19dfc0, Offset: 0xbf42
// Size: 0x2ad
function spawn_zombies_at_location( ai_type, a_spawn_pos, spawn_amount, var_d1b27b9c8339e71e, dis, b_ignore_cleanup, var_6c4d9c2b169872fe, b_ignore_wait = 0 )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( b_ignore_cleanup ) )
    {
        b_ignore_cleanup = 1;
    }
    
    n_round_difficulty = var_6c4d9c2b169872fe ?? zm_round_logic::get_rb_round_number();
    
    if ( !isarray( a_spawn_pos ) )
    {
        a_spawn_pos = [ a_spawn_pos ];
    }
    
    zombies = [];
    i = 0;
    
    while ( i < spawn_amount )
    {
        spawn_pos = utility::array_random( a_spawn_pos );
        
        if ( isvector( spawn_pos ) )
        {
            zombie = agent_manager::spawn_agent( ai_type, spawn_pos, ( 0, 0, 0 ), "team_two_hundred" );
        }
        else
        {
            zombie = agent_manager::spawn_agent( ai_type, spawn_pos.origin, ( 0, 0, 0 ), "team_two_hundred" );
        }
        
        if ( isdefined( zombie ) )
        {
            zombie.no_powerups = 1;
            zombie val::set( "zm_quest_spawn", "ignore_cleanup", b_ignore_cleanup );
            zombie.ignore_enemy_count = 1;
            zombie.b_cleanup_no_respawn = 1;
            zombie.var_825b17c932865df = 1;
            zombie.b_ignore_cleanup = 1;
            zombie.var_a13bed1ac47e1b2c = 1;
            
            if ( zombie.aicategory == "normal" )
            {
                zombie.kiastring = #"zombie_kia_mission_kill";
            }
            else if ( zombie.aicategory == "special" )
            {
                zombie.kiastring = #"zombie_kia_mission_kill_special";
            }
            else
            {
                zombie.kiastring = #"zombie_kia_mission_kill_elite";
            }
            
            zombie zombie_utils::function_a8ce00e0448cb6f0( "sprint", "zm_quest", 6 );
            zombie zombie_utils::set_zombie_round_difficulty( n_round_difficulty );
            
            if ( isstruct( spawn_pos ) && isdefined( spawn_pos.script_animation ) )
            {
                zombie thread zone_spawner::function_ce10e453e7f7bb8e( spawn_pos );
            }
            
            i++;
            
            if ( var_d1b27b9c8339e71e )
            {
                if ( !isdefined( self.a_zombies_spawned ) )
                {
                    self.a_zombies_spawned = [];
                }
                
                self.a_zombies_spawned[ self.a_zombies_spawned.size ] = zombie;
                zombie.ignoreall = 1;
            }
            
            zombies[ zombies.size ] = zombie;
        }
        
        if ( !b_ignore_wait )
        {
            wait randomfloatrange( 0.5, 2 );
            continue;
        }
        
        waitframe();
    }
    
    if ( var_d1b27b9c8339e71e )
    {
        thread function_f9b05facec4e4603( dis );
    }
    
    return zombies;
}

// Namespace zm_quest
// Params 1
// Checksum 0x7e813826, Offset: 0xc1f8
// Size: 0xaa
function function_f9b05facec4e4603( dis )
{
    level endon( #"game_ended" );
    player_distance_and_look_at_looping_check( 1500, 1 );
    
    foreach ( zombie in self.a_zombies_spawned )
    {
        if ( isalive( zombie ) )
        {
            zombie.ignoreall = 0;
        }
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0x96ed5f77, Offset: 0xc2aa
// Size: 0xcf
function function_91f9590e98d57ff6( org_or_ent, use_callback, var_b2107da793be51f7, radius_type )
{
    var_45b620bc30783968 = undefined;
    
    if ( isvector( org_or_ent ) )
    {
        var_45b620bc30783968 = spawnscriptable( "zm_quest_scriptable_interact", org_or_ent );
    }
    else if ( isvector( org_or_ent.origin ) )
    {
        var_45b620bc30783968 = spawnscriptable( "zm_quest_scriptable_interact", org_or_ent.origin );
    }
    
    if ( !isdefined( var_45b620bc30783968 ) )
    {
        print( "<dev string:x5e6>" );
        return;
    }
    
    if ( !isdefined( radius_type ) )
    {
        radius_type = "small";
    }
    
    var_45b620bc30783968 utility::function_7c10ea82c1e305b8( "base", radius_type );
    
    if ( isfunction( var_b2107da793be51f7 ) )
    {
        var_45b620bc30783968 interaction::set_interact_hint_callback( var_b2107da793be51f7 );
    }
    
    if ( isfunction( use_callback ) )
    {
        var_45b620bc30783968 = interaction::register_scriptable_interact( var_45b620bc30783968, use_callback );
    }
    
    return var_45b620bc30783968;
}

// Namespace zm_quest
// Params 0
// Checksum 0x568d2402, Offset: 0xc382
// Size: 0xf
function function_9170db4686f796e2()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self freescriptable();
}

// Namespace zm_quest
// Params 1
// Checksum 0xf182ffb8, Offset: 0xc399
// Size: 0xda, Type: bool
function function_33e20bfbb976c774( var_87886397e909c08b )
{
    level endon( #"game_ended" );
    
    if ( isdefined( var_87886397e909c08b ) && !isarray( var_87886397e909c08b ) )
    {
        var_87886397e909c08b = [ var_87886397e909c08b ];
    }
    
    foreach ( player in level.players )
    {
        player_current_zone = player zone_manager::get_current_zone();
        
        if ( isdefined( player_current_zone ) )
        {
            zone_name = zone_manager::function_2bcd755aabfd3cad( player_current_zone );
            
            if ( arraycontains( var_87886397e909c08b, zone_name ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_quest
// Params 1
// Checksum 0x530632db, Offset: 0xc47c
// Size: 0x80
function function_823ee6000b6e1947( var_8d885b4aed0bef01 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ var_8d885b4aed0bef01 + 1 ] ) )
    {
        next_special_rounds = level.var_a009ab14ee0d3223.specialroundspawns[ var_8d885b4aed0bef01 + 1 ];
        level.var_a009ab14ee0d3223.specialroundspawns[ var_8d885b4aed0bef01 + 1 ] = undefined;
        zm_round_spawning::schedule_special_round( var_8d885b4aed0bef01 + 2, next_special_rounds );
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0xda89ac93, Offset: 0xc504
// Size: 0x188
function function_ae46cbf17977a609( var_ed466fad37317edc, var_217013215a686073 )
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( self.var_26a3bc6d23901a53 ) )
        {
            self.var_26a3bc6d23901a53 = namespace_26a3bc6d23901a53::register();
        }
        
        if ( !self.var_26a3bc6d23901a53 namespace_26a3bc6d23901a53::is_open( player ) && isalive( player ) )
        {
            self.var_26a3bc6d23901a53 namespace_26a3bc6d23901a53::open( player );
        }
        
        self.var_26a3bc6d23901a53 namespace_26a3bc6d23901a53::function_1faee175fc3e0f1e( player, var_ed466fad37317edc );
    }
    
    if ( !isdefined( var_217013215a686073 ) )
    {
        var_217013215a686073 = 3;
    }
    
    wait var_217013215a686073;
    
    foreach ( player in level.players )
    {
        if ( self.var_26a3bc6d23901a53 namespace_26a3bc6d23901a53::is_open( player ) )
        {
            self.var_26a3bc6d23901a53 namespace_26a3bc6d23901a53::close( player );
        }
    }
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0x26863c63, Offset: 0xc694
// Size: 0x128
function private function_2a9497a1fef050c9( quest_ref, step_ref )
{
    quest_step = get_quest_step( quest_ref, step_ref );
    
    if ( isdefined( quest_step ) )
    {
        priority_struct = spawnstruct();
        priority_struct.id = getxhash( string( quest_step.global_index ) );
        priority_struct.quest_ref = quest_ref;
        priority_struct.step_ref = step_ref;
        priority_struct.ui_priority = quest_step.ui_priority;
        priority_struct.ui_status = 0;
        priority_struct.ui_current_progress = 0;
        priority_struct.var_314d56282a534ba7 = quest_step.var_cf684f09b6c37c3a ?? 1;
        priority_struct.ui_current_time = ( quest_step.start_time_limit ?? 0 ) * 1000;
        priority_struct.ui_time_frozen = 1;
        priority_struct.var_b9fb7efe7963267a = 1;
        priority_struct.var_598b5faa7acff56b = 1;
        priority_struct.prev_node = undefined;
        priority_struct.next_node = undefined;
        return priority_struct;
    }
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0x42eddb69, Offset: 0xc7c5
// Size: 0x44
function private function_9e9560e12d39bdb( quest_ref, step_ref )
{
    quest_step = get_quest_step( quest_ref, step_ref );
    
    if ( isdefined( quest_step ) )
    {
        return getxhash( string( quest_step.global_index ) );
    }
}

// Namespace zm_quest
// Params 0, eflags: 0x4
// Checksum 0x602e1f35, Offset: 0xc812
// Size: 0x70
function private function_8fa317fbecf5f68d()
{
    n_entitynum = self getentitynumber();
    level.var_bf3c2011b07eba63.players[ n_entitynum ] = spawnstruct();
    level.var_bf3c2011b07eba63.players[ n_entitynum ].list = [];
    level.var_bf3c2011b07eba63.players[ n_entitynum ].root = undefined;
}

// Namespace zm_quest
// Params 0, eflags: 0x4
// Checksum 0x7a778db5, Offset: 0xc88a
// Size: 0xc9
function private function_98a53764946505c7()
{
    n_entitynum = self getentitynumber();
    var_ed21dc748c067c31 = level.var_bf3c2011b07eba63.players[ n_entitynum ];
    temproot = var_ed21dc748c067c31.root;
    
    while ( isdefined( temproot ) )
    {
        lastnode = temproot;
        temproot = temproot.next_node;
        lastnode.next_node = undefined;
        lastnode.prev_node = undefined;
        var_ed21dc748c067c31.list[ lastnode.id ] = undefined;
    }
    
    if ( isdefined( var_ed21dc748c067c31 ) )
    {
        var_ed21dc748c067c31.root = undefined;
        var_ed21dc748c067c31.list = undefined;
    }
    
    level.var_bf3c2011b07eba63.players[ n_entitynum ] = undefined;
}

// Namespace zm_quest
// Params 3, eflags: 0x4
// Checksum 0xc70135e2, Offset: 0xc95b
// Size: 0x1cd
function private function_d085c2e911088eb6( var_5ac1f726a1e2d08, quest_ref, step_ref )
{
    step_struct = function_2a9497a1fef050c9( quest_ref, step_ref );
    
    if ( !isdefined( step_struct ) )
    {
        return;
    }
    
    var_42a73e69d1a996ea = level.var_bf3c2011b07eba63.global;
    
    if ( !var_5ac1f726a1e2d08 )
    {
        var_42a73e69d1a996ea = level.var_bf3c2011b07eba63.players[ self getentitynumber() ];
    }
    
    if ( !isdefined( var_42a73e69d1a996ea ) )
    {
        return;
    }
    
    var_42a73e69d1a996ea.list[ step_struct.id ] = step_struct;
    
    if ( isdefined( var_42a73e69d1a996ea.root ) )
    {
        for ( temproot = var_42a73e69d1a996ea.root; isdefined( temproot ) ; temproot = temproot.next_node )
        {
            struct = var_42a73e69d1a996ea.list[ temproot.id ];
            
            if ( step_struct.ui_priority >= temproot.ui_priority )
            {
                if ( isdefined( struct.prev_node ) )
                {
                    struct.prev_node.next_node = step_struct;
                }
                
                step_struct.prev_node = struct.prev_node;
                step_struct.next_node = struct;
                struct.prev_node = step_struct;
                
                if ( !isdefined( step_struct.prev_node ) )
                {
                    var_42a73e69d1a996ea.root = step_struct;
                }
                
                break;
            }
            
            if ( !isdefined( struct.next_node ) )
            {
                struct.next_node = step_struct;
                step_struct.prev_node = struct;
                break;
            }
        }
    }
    else
    {
        var_42a73e69d1a996ea.root = step_struct;
    }
    
    return step_struct;
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0x8b55d43d, Offset: 0xcb31
// Size: 0x21c
function private function_45c2c5b0c12434f3( var_5ac1f726a1e2d08, step_struct )
{
    if ( !isdefined( step_struct ) )
    {
        return;
    }
    
    var_42a73e69d1a996ea = level.var_bf3c2011b07eba63.global;
    
    if ( !var_5ac1f726a1e2d08 )
    {
        var_42a73e69d1a996ea = level.var_bf3c2011b07eba63.players[ self getentitynumber() ];
    }
    
    if ( !isdefined( var_42a73e69d1a996ea ) )
    {
        return;
    }
    
    if ( isdefined( var_42a73e69d1a996ea.root ) )
    {
        for ( temproot = var_42a73e69d1a996ea.root; isdefined( temproot ) ; temproot = temproot.next_node )
        {
            struct = var_42a73e69d1a996ea.list[ temproot.id ];
            
            if ( step_struct.ui_priority >= temproot.ui_priority )
            {
                if ( temproot.quest_ref == step_struct.quest_ref && temproot.step_ref == step_struct.step_ref )
                {
                    break;
                }
                
                if ( isdefined( step_struct.prev_node ) )
                {
                    step_struct.prev_node.next_node = step_struct.next_node;
                }
                
                if ( isdefined( step_struct.next_node ) )
                {
                    step_struct.next_node.prev_node = step_struct.prev_node;
                }
                
                if ( isdefined( struct.prev_node ) )
                {
                    struct.prev_node.next_node = step_struct;
                }
                
                step_struct.prev_node = struct.prev_node;
                step_struct.next_node = struct;
                struct.prev_node = step_struct;
                
                if ( !isdefined( step_struct.prev_node ) )
                {
                    var_42a73e69d1a996ea.root = step_struct;
                }
                
                break;
            }
            
            if ( !isdefined( struct.next_node ) )
            {
                struct.next_node = step_struct;
                step_struct.prev_node = struct;
                break;
            }
        }
    }
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0xc41c547, Offset: 0xcd55
// Size: 0xf9, Type: bool
function private function_aaea541a715b8d13( var_5ac1f726a1e2d08, step_struct )
{
    if ( isdefined( step_struct ) )
    {
        if ( isdefined( step_struct.prev_node ) )
        {
            step_struct.prev_node.next_node = step_struct.next_node;
        }
        else if ( !var_5ac1f726a1e2d08 )
        {
            level.var_bf3c2011b07eba63.players[ self getentitynumber() ].root = step_struct.next_node;
        }
        else
        {
            level.var_bf3c2011b07eba63.global.root = step_struct.next_node;
        }
        
        if ( isdefined( step_struct.next_node ) )
        {
            step_struct.next_node.prev_node = step_struct.prev_node;
        }
        
        step_struct.prev_node = undefined;
        step_struct.next_node = undefined;
        return true;
    }
    
    return false;
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0x155790b7, Offset: 0xce57
// Size: 0x118
function private function_85a9a5fa1c313296( var_5ac1f726a1e2d08, quest_ref )
{
    var_f08031c74e36025a = 0;
    
    if ( !isdefined( quest_ref ) )
    {
        return 0;
    }
    
    var_42a73e69d1a996ea = level.var_bf3c2011b07eba63.global;
    
    if ( !var_5ac1f726a1e2d08 )
    {
        var_42a73e69d1a996ea = level.var_bf3c2011b07eba63.players[ self getentitynumber() ];
    }
    
    if ( !isdefined( var_42a73e69d1a996ea ) )
    {
        return 0;
    }
    
    if ( isdefined( var_42a73e69d1a996ea.root ) )
    {
        for ( temproot = var_42a73e69d1a996ea.root; isdefined( temproot ) ; temproot = temproot.next_node )
        {
            struct = var_42a73e69d1a996ea.list[ temproot.id ];
            
            if ( quest_ref == temproot.quest_ref )
            {
                nextroot = temproot.next_node;
                removed = function_aaea541a715b8d13( var_5ac1f726a1e2d08, temproot );
                
                if ( removed )
                {
                    var_f08031c74e36025a = 1;
                }
                
                temproot = nextroot;
                continue;
            }
        }
    }
    
    return var_f08031c74e36025a;
}

// Namespace zm_quest
// Params 2
// Checksum 0x5ad6f384, Offset: 0xcf78
// Size: 0x38
function function_a81dd416b9036f0e( var_5ac1f726a1e2d08, quest_ref )
{
    is_changed = function_85a9a5fa1c313296( var_5ac1f726a1e2d08, quest_ref );
    
    if ( is_changed )
    {
        function_62242b3a7443794e( var_5ac1f726a1e2d08 );
    }
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0xef555354, Offset: 0xcfb8
// Size: 0x8b, Type: bool
function private function_ff00532081a20cce( var_5ac1f726a1e2d08, step_struct )
{
    if ( isdefined( step_struct ) )
    {
        var_42a73e69d1a996ea = level.var_bf3c2011b07eba63.global;
        
        if ( !var_5ac1f726a1e2d08 )
        {
            var_42a73e69d1a996ea = level.var_bf3c2011b07eba63.players[ self getentitynumber() ];
        }
        
        return ( isdefined( step_struct.prev_node ) || isdefined( step_struct.next_node ) || var_42a73e69d1a996ea.root == step_struct );
    }
    
    return false;
}

// Namespace zm_quest
// Params 3, eflags: 0x4
// Checksum 0xd771fa1, Offset: 0xd04c
// Size: 0x8e
function private function_9cae2ea135b91a5a( var_5ac1f726a1e2d08, quest_ref, step_ref )
{
    var_42a73e69d1a996ea = level.var_bf3c2011b07eba63.global;
    
    if ( !var_5ac1f726a1e2d08 )
    {
        var_42a73e69d1a996ea = level.var_bf3c2011b07eba63.players[ self getentitynumber() ];
    }
    
    key = function_9e9560e12d39bdb( quest_ref, step_ref );
    
    if ( !isdefined( var_42a73e69d1a996ea ) )
    {
        return;
    }
    
    if ( isdefined( key ) )
    {
        return var_42a73e69d1a996ea.list[ key ];
    }
}

// Namespace zm_quest
// Params 0, eflags: 0x4
// Checksum 0xcefe27ba, Offset: 0xd0e3
// Size: 0xa9
function private function_6029a1fbca9c133d()
{
    var_cdc5eba0347d3a97 = level.var_bf3c2011b07eba63.global.root;
    var_7df8c64893b91aeb = level.var_bf3c2011b07eba63.players[ self getentitynumber() ].root;
    var_3612b24a4eeb0908 = var_cdc5eba0347d3a97;
    
    if ( isdefined( var_7df8c64893b91aeb.ui_priority ) )
    {
        if ( isdefined( var_cdc5eba0347d3a97.ui_priority ) )
        {
            if ( var_7df8c64893b91aeb.ui_priority >= var_cdc5eba0347d3a97.ui_priority )
            {
                var_3612b24a4eeb0908 = var_7df8c64893b91aeb;
            }
        }
        else
        {
            var_3612b24a4eeb0908 = var_7df8c64893b91aeb;
        }
    }
    
    return var_3612b24a4eeb0908;
}

// Namespace zm_quest
// Params 1
// Checksum 0x84255ff3, Offset: 0xd195
// Size: 0x4a, Type: bool
function function_209ca091001f4c64( quest_ref )
{
    var_cdc5eba0347d3a97 = level.var_bf3c2011b07eba63.global.root;
    
    if ( var_cdc5eba0347d3a97.quest_ref == quest_ref )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_quest
// Params 2
// Checksum 0x21de383, Offset: 0xd1e8
// Size: 0x65, Type: bool
function function_625cc874b6861487( quest_ref, step_ref )
{
    var_cdc5eba0347d3a97 = level.var_bf3c2011b07eba63.global.root;
    
    if ( var_cdc5eba0347d3a97.quest_ref == quest_ref && var_cdc5eba0347d3a97.step_ref == step_ref )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_quest
// Params 0, eflags: 0x4
// Checksum 0xaf88a0a3, Offset: 0xd256
// Size: 0x1c6
function private function_abfda2143c855ed2()
{
    prioritystep = function_6029a1fbca9c133d();
    
    if ( isdefined( prioritystep ) )
    {
        var_df4780164b035ff3 = level.zm_quests[ prioritystep.quest_ref ].global_index + 1;
        var_d61d72b59ec1d8a3 = level.zm_quests_steps[ prioritystep.quest_ref ][ prioritystep.step_ref ].global_index + 1;
        stepchanged = self getclientomnvar( "ui_zm_current_quest_id" ) != var_df4780164b035ff3 || self getclientomnvar( "ui_zm_current_quest_step_id" ) != var_d61d72b59ec1d8a3;
        self setclientomnvar( "ui_zm_current_quest_id", int( var_df4780164b035ff3 ) );
        self setclientomnvar( "ui_zm_current_quest_step_id", int( var_d61d72b59ec1d8a3 ) );
        
        if ( stepchanged || self getclientomnvar( "ui_zm_current_quest_status" ) != prioritystep.ui_status )
        {
            self setclientomnvar( "ui_zm_current_quest_status", int( prioritystep.ui_status ) );
            self setclientomnvar( "ui_zm_current_quest_status_notify", gettime() );
        }
        
        if ( stepchanged )
        {
            self setclientomnvar( "ui_zm_current_quest_step_time", int( prioritystep.ui_current_time ) );
            self setclientomnvar( "ui_zm_current_quest_step_time_notify", gettime() );
        }
        
        self setclientomnvar( "ui_zm_current_quest_step_time_frozen", prioritystep.ui_time_frozen );
        self setclientomnvar( "ui_zm_current_quest_step_progress", int( prioritystep.ui_current_progress ) );
        self setclientomnvar( "ui_zm_current_quest_step_progress_max", int( prioritystep.var_314d56282a534ba7 ) );
        self setclientomnvar( "ui_zm_current_quest_step_placement", int( prioritystep.var_b9fb7efe7963267a ) );
        self setclientomnvar( "ui_zm_current_quest_step_max_placement", int( prioritystep.var_598b5faa7acff56b ) );
        return;
    }
    
    function_b95dd121b2b40ce8();
}

// Namespace zm_quest
// Params 4
// Checksum 0xfac0c070, Offset: 0xd424
// Size: 0x117
function function_fba942a1cfd85f5d( is_active, var_5ac1f726a1e2d08, quest_ref, step_ref )
{
    if ( function_6a1f8c4f4bf33bf1( quest_ref ) )
    {
        return;
    }
    
    haschanged = 0;
    step_struct = function_9cae2ea135b91a5a( var_5ac1f726a1e2d08, quest_ref, step_ref );
    isinqueue = function_ff00532081a20cce( var_5ac1f726a1e2d08, step_struct );
    
    if ( is_active )
    {
        if ( !isinqueue )
        {
            step_struct = function_d085c2e911088eb6( var_5ac1f726a1e2d08, quest_ref, step_ref );
        }
        else
        {
            function_45c2c5b0c12434f3( var_5ac1f726a1e2d08, step_struct );
        }
        
        haschanged = 1;
    }
    else if ( isinqueue )
    {
        haschanged = function_aaea541a715b8d13( var_5ac1f726a1e2d08, step_struct );
    }
    
    if ( haschanged )
    {
        function_62242b3a7443794e( var_5ac1f726a1e2d08 );
        
        if ( isdefined( level.directed_mode ) && isdefined( step_struct ) && is_active )
        {
            if ( step_struct.ui_priority == level.var_7dc4bd9a391322b0[ #"mainquest" ] )
            {
                level.directed_mode.var_fcdcd383b4f959ed = step_ref;
                level.directed_mode.var_ec54378cf831e7c1 = quest_ref;
            }
        }
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0xebb4e539, Offset: 0xd543
// Size: 0x66
function function_fb3af5600f6a9441( status, var_5ac1f726a1e2d08, quest_ref, step_ref )
{
    if ( function_6a1f8c4f4bf33bf1( quest_ref ) )
    {
        return;
    }
    
    step_struct = function_9cae2ea135b91a5a( var_5ac1f726a1e2d08, quest_ref, step_ref );
    
    if ( isdefined( step_struct ) )
    {
        step_struct.ui_status = status;
        function_62242b3a7443794e( var_5ac1f726a1e2d08 );
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x6c3b49d9, Offset: 0xd5b1
// Size: 0x94
function function_62242b3a7443794e( var_5ac1f726a1e2d08 )
{
    if ( var_5ac1f726a1e2d08 )
    {
        foreach ( player in level.players )
        {
            player function_abfda2143c855ed2();
        }
        
        return;
    }
    
    function_abfda2143c855ed2();
}

// Namespace zm_quest
// Params 0, eflags: 0x4
// Checksum 0xcdfd5f69, Offset: 0xd64d
// Size: 0xa8
function private function_b95dd121b2b40ce8()
{
    level endon( #"game_ended" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setclientomnvar( "ui_zm_current_quest_id", 0 );
    self setclientomnvar( "ui_zm_current_quest_step_id", 0 );
    self setclientomnvar( "ui_zm_current_quest_status", 0 );
    self setclientomnvar( "ui_zm_current_quest_status_notify", gettime() );
    self setclientomnvar( "ui_zm_current_quest_step_time", 0 );
    self setclientomnvar( "ui_zm_current_quest_step_time_frozen", 1 );
    self setclientomnvar( "ui_zm_current_quest_step_progress", 0 );
    self setclientomnvar( "ui_zm_current_quest_step_progress_max", 1 );
    self setclientomnvar( "ui_zm_current_quest_step_placement", 1 );
    self setclientomnvar( "ui_zm_current_quest_step_max_placement", 1 );
}

// Namespace zm_quest
// Params 1
// Checksum 0xb52cbbc5, Offset: 0xd6fd
// Size: 0x94
function function_e66ab24194b8627e( var_5ac1f726a1e2d08 )
{
    if ( var_5ac1f726a1e2d08 )
    {
        foreach ( player in level.players )
        {
            player function_b95dd121b2b40ce8();
        }
        
        return;
    }
    
    function_b95dd121b2b40ce8();
}

// Namespace zm_quest
// Params 4
// Checksum 0x959ff805, Offset: 0xd799
// Size: 0x163
function function_612a9ad0db22c29c( time, var_5ac1f726a1e2d08, quest_ref, step_ref )
{
    step_struct = function_9cae2ea135b91a5a( var_5ac1f726a1e2d08, quest_ref, step_ref );
    
    if ( !isdefined( time ) )
    {
        time = 0;
    }
    
    if ( isdefined( step_struct ) )
    {
        if ( time < 0 )
        {
            time = 0;
        }
        
        step_struct.ui_current_time = time;
        
        if ( var_5ac1f726a1e2d08 )
        {
            foreach ( player in level.players )
            {
                priority_step = player function_6029a1fbca9c133d();
                
                if ( isdefined( priority_step ) && step_struct == priority_step )
                {
                    player setclientomnvar( "ui_zm_current_quest_step_time", int( priority_step.ui_current_time ) );
                    player setclientomnvar( "ui_zm_current_quest_step_time_notify", gettime() );
                }
            }
            
            return;
        }
        
        priority_step = function_6029a1fbca9c133d();
        
        if ( isdefined( priority_step ) && step_struct == priority_step )
        {
            self setclientomnvar( "ui_zm_current_quest_step_time", int( priority_step.ui_current_time ) );
            self setclientomnvar( "ui_zm_current_quest_step_time_notify", gettime() );
        }
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0xac2605f7, Offset: 0xd904
// Size: 0x132
function function_194bde735238c397( var_e5557a1483620915, var_5ac1f726a1e2d08, quest_ref, step_ref )
{
    step_struct = function_9cae2ea135b91a5a( var_5ac1f726a1e2d08, quest_ref, step_ref );
    
    if ( !isdefined( var_e5557a1483620915 ) )
    {
        var_e5557a1483620915 = 0;
    }
    
    if ( isdefined( step_struct ) )
    {
        step_struct.ui_time_frozen = var_e5557a1483620915;
        
        if ( var_5ac1f726a1e2d08 )
        {
            foreach ( player in level.players )
            {
                priority_step = player function_6029a1fbca9c133d();
                
                if ( isdefined( priority_step ) && step_struct == priority_step )
                {
                    player setclientomnvar( "ui_zm_current_quest_step_time_frozen", priority_step.ui_time_frozen );
                }
            }
            
            return;
        }
        
        priority_step = function_6029a1fbca9c133d();
        
        if ( isdefined( priority_step ) && step_struct == priority_step )
        {
            self setclientomnvar( "ui_zm_current_quest_step_time_frozen", priority_step.ui_time_frozen );
        }
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0x30050e3a, Offset: 0xda3e
// Size: 0x146
function function_9f49b2a045ece8ae( progress, var_5ac1f726a1e2d08, quest_ref, step_ref )
{
    if ( function_6a1f8c4f4bf33bf1( quest_ref ) )
    {
        return;
    }
    
    if ( !isdefined( progress ) )
    {
        progress = 0;
    }
    
    step_struct = function_9cae2ea135b91a5a( var_5ac1f726a1e2d08, quest_ref, step_ref );
    
    if ( isdefined( step_struct ) )
    {
        step_struct.ui_current_progress = progress;
        
        if ( var_5ac1f726a1e2d08 )
        {
            foreach ( player in level.players )
            {
                priority_step = player function_6029a1fbca9c133d();
                
                if ( isdefined( priority_step ) && step_struct == priority_step )
                {
                    player setclientomnvar( "ui_zm_current_quest_step_progress", int( priority_step.ui_current_progress ) );
                }
            }
            
            return;
        }
        
        priority_step = function_6029a1fbca9c133d();
        
        if ( isdefined( priority_step ) && step_struct == priority_step )
        {
            self setclientomnvar( "ui_zm_current_quest_step_progress", int( priority_step.ui_current_progress ) );
        }
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0x89d3dfd2, Offset: 0xdb8c
// Size: 0x13a
function function_c2af37f835cd840b( progress = 0, var_5ac1f726a1e2d08, quest_ref, step_ref )
{
    step_struct = function_9cae2ea135b91a5a( var_5ac1f726a1e2d08, quest_ref, step_ref );
    
    if ( isdefined( step_struct ) )
    {
        step_struct.var_314d56282a534ba7 = progress;
        
        if ( var_5ac1f726a1e2d08 )
        {
            foreach ( player in level.players )
            {
                priority_step = player function_6029a1fbca9c133d();
                
                if ( isdefined( priority_step ) && step_struct == priority_step )
                {
                    player setclientomnvar( "ui_zm_current_quest_step_progress_max", int( priority_step.var_314d56282a534ba7 ) );
                }
            }
            
            return;
        }
        
        priority_step = function_6029a1fbca9c133d();
        
        if ( isdefined( priority_step ) && step_struct == priority_step )
        {
            self setclientomnvar( "ui_zm_current_quest_step_progress_max", int( priority_step.var_314d56282a534ba7 ) );
        }
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0x583c5fcb, Offset: 0xdcce
// Size: 0x147
function function_bf63bf6d044ad598( placement, var_5ac1f726a1e2d08, quest_ref, step_ref )
{
    if ( function_6a1f8c4f4bf33bf1( quest_ref ) )
    {
        return;
    }
    
    if ( !isdefined( placement ) )
    {
        placement = 1;
    }
    
    step_struct = function_9cae2ea135b91a5a( var_5ac1f726a1e2d08, quest_ref, step_ref );
    
    if ( isdefined( step_struct ) )
    {
        step_struct.var_b9fb7efe7963267a = placement;
        
        if ( var_5ac1f726a1e2d08 )
        {
            foreach ( player in level.players )
            {
                priority_step = player function_6029a1fbca9c133d();
                
                if ( isdefined( priority_step ) && step_struct == priority_step )
                {
                    player setclientomnvar( "ui_zm_current_quest_step_placement", int( priority_step.var_b9fb7efe7963267a ) );
                }
            }
            
            return;
        }
        
        priority_step = function_6029a1fbca9c133d();
        
        if ( isdefined( priority_step ) && step_struct == priority_step )
        {
            self setclientomnvar( "ui_zm_current_quest_step_placement", int( priority_step.var_b9fb7efe7963267a ) );
        }
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0xe73be8cf, Offset: 0xde1d
// Size: 0x147
function function_49f2a6a3c1320a6d( placement, var_5ac1f726a1e2d08, quest_ref, step_ref )
{
    if ( function_6a1f8c4f4bf33bf1( quest_ref ) )
    {
        return;
    }
    
    if ( !isdefined( placement ) )
    {
        placement = 1;
    }
    
    step_struct = function_9cae2ea135b91a5a( var_5ac1f726a1e2d08, quest_ref, step_ref );
    
    if ( isdefined( step_struct ) )
    {
        step_struct.var_598b5faa7acff56b = placement;
        
        if ( var_5ac1f726a1e2d08 )
        {
            foreach ( player in level.players )
            {
                priority_step = player function_6029a1fbca9c133d();
                
                if ( isdefined( priority_step ) && step_struct == priority_step )
                {
                    player setclientomnvar( "ui_zm_current_quest_step_max_placement", int( priority_step.var_598b5faa7acff56b ) );
                }
            }
            
            return;
        }
        
        priority_step = function_6029a1fbca9c133d();
        
        if ( isdefined( priority_step ) && step_struct == priority_step )
        {
            self setclientomnvar( "ui_zm_current_quest_step_max_placement", int( priority_step.var_598b5faa7acff56b ) );
        }
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0xbe574324, Offset: 0xdf6c
// Size: 0x62, Type: bool
function function_69122a4776ff975e( quest_ref, step_ref )
{
    return !get_quest_step( quest_ref, step_ref ).var_9f1a5c448531eb7a && ( get_quest( quest_ref ).var_94c5b7d04e0c2501 || get_quest_step( quest_ref, step_ref ).var_94c5b7d04e0c2501 || function_6a1f8c4f4bf33bf1( quest_ref ) );
}

// Namespace zm_quest
// Params 2
// Checksum 0x3a6d8d79, Offset: 0xdfd7
// Size: 0x63, Type: bool
function function_8e570ed3ac04e96( quest_ref, step_ref )
{
    skip_splash = get_quest( quest_ref ).skip_splash || get_quest_step( quest_ref, step_ref ).skip_splash;
    return skip_splash || level.issplitscreen || function_975c4749f485038f();
}

// Namespace zm_quest
// Params 1
// Checksum 0xfacb9153, Offset: 0xe043
// Size: 0x77
function quest_ui_splash_ready_callback( global_step_index )
{
    refs = level.var_fc0bd7abe0e47b86[ global_step_index - 1 ];
    
    if ( !isdefined( refs ) )
    {
        assertmsg( "<dev string:x60d>" + global_step_index );
        return;
    }
    
    quest_step = level.zm_quests_steps[ refs.quest_ref ][ refs.step_ref ];
    quest_step notify( #"hash_a625cbef8957f1b6" );
}

// Namespace zm_quest
// Params 1
// Checksum 0xb5a985a9, Offset: 0xe0c2
// Size: 0x77
function quest_ui_tracker_showing_callback( global_step_index )
{
    refs = level.var_fc0bd7abe0e47b86[ global_step_index - 1 ];
    
    if ( !isdefined( refs ) )
    {
        assertmsg( "<dev string:x60d>" + global_step_index );
        return;
    }
    
    quest_step = level.zm_quests_steps[ refs.quest_ref ][ refs.step_ref ];
    quest_step notify( #"hash_a0a98d92a4f74f0f" );
}

// Namespace zm_quest
// Params 3
// Checksum 0xdd889a6d, Offset: 0xe141
// Size: 0x44
function function_cd1f2fee4749fb0a( var_5ac1f726a1e2d08, quest_ref, step_ref )
{
    if ( function_6a1f8c4f4bf33bf1( quest_ref ) )
    {
        return;
    }
    
    function_fba942a1cfd85f5d( 1, var_5ac1f726a1e2d08, quest_ref, step_ref );
    function_fb3af5600f6a9441( 2, var_5ac1f726a1e2d08, quest_ref, step_ref );
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0x78bfa988, Offset: 0xe18d
// Size: 0x23
function private function_1912aecb9ed77aff( player, is_visible )
{
    player setclientomnvar( "ui_zm_current_quest_show_placement_splash", is_visible );
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0xbb731bb6, Offset: 0xe1b8
// Size: 0x23
function private function_b26980b4ad8d0deb( player, is_visible )
{
    player setclientomnvar( "ui_zm_current_quest_show_leaderboard_winner", is_visible );
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0x2a21c1f7, Offset: 0xe1e3
// Size: 0x86
function private function_70dc572d6b709cbc( is_visible )
{
    foreach ( player in level.players )
    {
        function_1912aecb9ed77aff( player, is_visible );
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x2120d407, Offset: 0xe271
// Size: 0x16d
function function_e4996840a6b66669( results_ranked )
{
    var_7d0502f35e23ab7c = 0;
    var_61a4bb12f171cae7 = [];
    
    for ( place = 1; place <= 4 ; place++ )
    {
        var_61a4bb12f171cae7[ place ] = 0;
    }
    
    for ( i = 0; i < results_ranked.size ; i++ )
    {
        result_info = results_ranked[ i ];
        viewer = result_info.player;
        
        if ( !isdefined( viewer ) )
        {
            continue;
        }
        
        place = result_info.rank + 1;
        
        if ( place <= 4 )
        {
            var_3dcff50288da379e = viewer getentitynumber();
            var_61a4bb12f171cae7[ place ] = result_info.score;
            
            if ( var_3dcff50288da379e >= 0 && var_3dcff50288da379e <= 254 )
            {
                var_f28daf16d8ba46f = ( place - 1 ) * 8;
                var_6f613b634646fba4 = 255 << var_f28daf16d8ba46f;
                var_b287baabfa59e379 = var_3dcff50288da379e + 1 << var_f28daf16d8ba46f;
                var_7d0502f35e23ab7c = var_7d0502f35e23ab7c & ~var_6f613b634646fba4 | var_b287baabfa59e379;
            }
        }
    }
    
    for ( i = 0; i < results_ranked.size ; i++ )
    {
        viewer = results_ranked[ i ].player;
        
        if ( !isdefined( viewer ) )
        {
            continue;
        }
        
        viewer setclientomnvar( "ui_zm_current_quest_team_members_places", var_7d0502f35e23ab7c );
        
        for ( place = 1; place <= 4 ; place++ )
        {
            viewer setclientomnvar( "ui_zm_current_quest_team_members_score_" + place, var_61a4bb12f171cae7[ place ] );
        }
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0x8494ae2b, Offset: 0xe3e6
// Size: 0x9d
function function_b507b93ea423985d( should_show_placement_splash, var_e0bbb18dbea3c7d = level.players )
{
    if ( should_show_placement_splash )
    {
        foreach ( player in var_e0bbb18dbea3c7d )
        {
            function_1912aecb9ed77aff( player, should_show_placement_splash );
        }
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x47a69b8a, Offset: 0xe48b
// Size: 0x20
function function_2e24ab669108dde5( player )
{
    function_1912aecb9ed77aff( player, 0 );
    function_b26980b4ad8d0deb( player, 0 );
}

// Namespace zm_quest
// Params 10
// Checksum 0x88823312, Offset: 0xe4b3
// Size: 0x34e
function function_f3521e80c38a757e( wave_name, wave_index, zombie_amount, var_d2dea1eb5c269d79 = 1, var_8e4c78eb67893204, var_2fb6a110d014431d, var_8e4c7beb6789389d, var_2fb69e10d0143c84, var_8e4c7aeb6789366a, var_2fb69f10d0143eb7 )
{
    if ( !isdefined( level.var_e3064ad51e263dae ) )
    {
        level.var_e3064ad51e263dae = [];
    }
    
    if ( !isdefined( level.var_e3064ad51e263dae[ wave_name ] ) )
    {
        level.var_e3064ad51e263dae[ wave_name ] = [];
    }
    
    if ( !isdefined( level.var_e3064ad51e263dae[ wave_name ][ "wave_info" ] ) )
    {
        level.var_e3064ad51e263dae[ wave_name ][ "wave_info" ] = [];
    }
    
    if ( !isdefined( level.var_e3064ad51e263dae[ wave_name ][ "wave_info" ][ wave_index ] ) )
    {
        level.var_e3064ad51e263dae[ wave_name ][ "wave_info" ][ wave_index ] = spawnstruct();
    }
    
    path = level.var_e3064ad51e263dae[ wave_name ][ "wave_info" ][ wave_index ];
    
    if ( !isdefined( path.wave_amount ) )
    {
        path.wave_amount = 0;
    }
    
    if ( !isdefined( path.zombie_info ) )
    {
        path.zombie_info = [];
    }
    
    if ( !isdefined( path.zombie_info[ path.zombie_info.size ] ) )
    {
        path.zombie_info[ path.zombie_info.size ] = spawnstruct();
    }
    
    path.zombie_info[ path.zombie_info.size - 1 ].zombie_amount = zombie_amount;
    path.zombie_info[ path.zombie_info.size - 1 ].var_d2dea1eb5c269d79 = var_d2dea1eb5c269d79;
    path.zombie_info[ path.zombie_info.size - 1 ].zombie_types = [];
    
    for ( i = 1; i < 4 ; i++ )
    {
        switch ( i )
        {
            case 1:
                zombie_type = var_8e4c78eb67893204;
                spawn_weight = var_2fb6a110d014431d;
                break;
            case 2:
                zombie_type = var_8e4c7beb6789389d;
                spawn_weight = var_2fb69e10d0143c84;
                break;
            case 3:
                zombie_type = var_8e4c7aeb6789366a;
                spawn_weight = var_2fb69f10d0143eb7;
                break;
            default:
                break;
        }
        
        if ( isdefined( zombie_type ) )
        {
            if ( !isdefined( path.zombie_info[ path.zombie_info.size - 1 ].zombie_types[ i ] ) )
            {
                path.zombie_info[ path.zombie_info.size - 1 ].zombie_types[ i ] = spawnstruct();
            }
            
            path.zombie_info[ path.zombie_info.size - 1 ].zombie_types[ i ].zombie_type = zombie_type;
        }
        
        if ( isdefined( spawn_weight ) )
        {
            path.zombie_info[ path.zombie_info.size - 1 ].zombie_types[ i ].spawn_weight = spawn_weight;
        }
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0x89cd55ae, Offset: 0xe809
// Size: 0x21c
function function_cbb3f5643d6c0a01( wave_name, str_zonename )
{
    var_a65a556e144e8c0b = utility::getstructarray( str_zonename, "target" );
    
    if ( !isdefined( level.var_e3064ad51e263dae[ wave_name ][ "spawner" ] ) )
    {
        level.var_e3064ad51e263dae[ wave_name ][ "spawner" ] = [];
    }
    
    foreach ( spawner in var_a65a556e144e8c0b )
    {
        if ( isdefined( spawner.script_noteworthy ) )
        {
            var_9c99761dce6c924 = strtok( spawner.script_noteworthy, "|" );
            
            foreach ( subclass in var_9c99761dce6c924 )
            {
                if ( !isdefined( level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ subclass ] ) )
                {
                    level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ subclass ] = [];
                }
                
                level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ subclass ][ level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ subclass ].size ] = spawner;
            }
            
            continue;
        }
        
        if ( !isdefined( level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ "common_spawner" ] ) )
        {
            level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ "common_spawner" ] = [];
        }
        
        level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ "common_spawner" ][ level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ "common_spawner" ].size ] = spawner;
    }
}

// Namespace zm_quest
// Params 3
// Checksum 0x30c97962, Offset: 0xea2d
// Size: 0x233
function function_86c8e7751b4764f0( wave_name, str_targetname, var_8e3b9e4dc9fcc8c = 0 )
{
    if ( !isdefined( zombie_type ) )
    {
        zombie_type = "zombie_base";
    }
    
    if ( var_8e3b9e4dc9fcc8c )
    {
        var_d2a6a0c2cf61e6ba = level.var_1d03be60f0a95b1c[ str_targetname ];
        
        if ( !isdefined( var_d2a6a0c2cf61e6ba ) )
        {
            /#
                iprintlnbold( "<dev string:x63a>" + str_targetname + "<dev string:x662>" + wave_name + "<dev string:x68c>" );
            #/
            
            return;
        }
    }
    else
    {
        var_d2a6a0c2cf61e6ba = utility::getstructarray( utility::getstruct( str_targetname, "targetname" ).target, "targetname" );
    }
    
    if ( !isdefined( level.var_e3064ad51e263dae[ wave_name ][ "spawner" ] ) )
    {
        level.var_e3064ad51e263dae[ wave_name ][ "spawner" ] = [];
    }
    
    foreach ( spawner in var_d2a6a0c2cf61e6ba )
    {
        if ( isdefined( spawner.script_noteworthy ) )
        {
            if ( !isdefined( level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ spawner.script_noteworthy ] ) )
            {
                level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ spawner.script_noteworthy ] = [];
            }
            
            level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ spawner.script_noteworthy ][ level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ spawner.script_noteworthy ].size ] = spawner;
            continue;
        }
        
        if ( !isdefined( level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ "common_spawner" ] ) )
        {
            level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ "common_spawner" ] = [];
        }
        
        level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ "common_spawner" ][ level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ "common_spawner" ].size ] = spawner;
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x693f35f7, Offset: 0xec68
// Size: 0x37
function cleanup_wave_spawner( wave_name )
{
    if ( !isdefined( level.var_e3064ad51e263dae[ wave_name ] ) )
    {
        level.var_e3064ad51e263dae[ wave_name ] = [];
    }
    
    level.var_e3064ad51e263dae[ wave_name ] = [];
}

// Namespace zm_quest
// Params 2
// Checksum 0xdb3db413, Offset: 0xeca7
// Size: 0x44
function function_9488b7fb21f3ab49( params, s_additional_params )
{
    if ( self.var_9ee436be1a5adf9c )
    {
        if ( s_additional_params.var_badb51b09196e156 && self.b_turned )
        {
            return;
        }
        
        thread function_c80938ebe76dfa2b();
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0xc5ba9b83, Offset: 0xecf3
// Size: 0x2a
function function_27f77ea735342058( params )
{
    if ( self.var_9ee436be1a5adf9c )
    {
        self.b_turned = 1;
        thread function_c80938ebe76dfa2b();
    }
}

// Namespace zm_quest
// Params 10
// Checksum 0x6b28c560, Offset: 0xed25
// Size: 0x312
function function_e1cd49cb5cfe7833( wave_name, override_wave_interval, override_round_difficulty, var_a7068df5cdd622b0 = 1, n_wave_timeout, var_badb51b09196e156 = 0, func_override_droplist, b_ignore_cleanup = 1, b_allow_recycling = 1, var_53b9cbd8aea1973e )
{
    level endon( wave_name + "stop_wave_spawner" );
    level endon( #"game_ended" );
    s_additional_params = spawnstruct();
    s_additional_params.var_badb51b09196e156 = var_badb51b09196e156;
    level callback::add( #"on_ai_killed", &function_9488b7fb21f3ab49, s_additional_params );
    
    if ( var_badb51b09196e156 )
    {
        level callback::add( "on_turned", &function_27f77ea735342058 );
    }
    
    if ( isdefined( override_round_difficulty ) )
    {
        round_difficulty = override_round_difficulty;
    }
    else
    {
        round_difficulty = zm_round_logic::get_rb_round_number();
    }
    
    if ( isdefined( override_wave_interval ) )
    {
        wave_interval = override_wave_interval;
    }
    else
    {
        wave_interval = 5;
    }
    
    wave_info_path = level.var_e3064ad51e263dae[ wave_name ][ "wave_info" ];
    function_3329c782f2fda682( wave_info_path );
    
    while ( true )
    {
        foreach ( wave_index, wave_info in wave_info_path )
        {
            level thread function_2e182317dbf918cd( wave_name, wave_info, n_wave_timeout );
            wait 1;
            
            foreach ( info in wave_info.zombie_info )
            {
                info.myparent = wave_info;
                info.wave_name = wave_name;
                info.round_difficulty = round_difficulty;
                info.var_a7068df5cdd622b0 = var_a7068df5cdd622b0;
                info.func_override_droplist = func_override_droplist;
                info.b_ignore_cleanup = b_ignore_cleanup;
                info.b_allow_recycling = b_allow_recycling;
                info.var_53b9cbd8aea1973e = var_53b9cbd8aea1973e;
                info thread spawn_wave_zombies();
            }
            
            /#
                iprintlnbold( "<dev string:x68e>" + wave_index + "<dev string:x693>" );
            #/
            
            level waittill( #"hash_7e06161e5410128c" );
            
            if ( wave_index < wave_info_path.size - 1 )
            {
                wait wave_interval;
            }
        }
        
        break;
    }
    
    /#
        iprintlnbold( wave_name + "<dev string:x6a2>" );
    #/
    
    level callback::remove( #"on_ai_killed", &function_9488b7fb21f3ab49 );
    level callback::remove( "on_turned", &function_27f77ea735342058 );
}

// Namespace zm_quest
// Params 10
// Checksum 0x83cd305, Offset: 0xf03f
// Size: 0x3b1
function function_9414c909ca3295c4( wave_name, override_wave_interval, override_round_difficulty, var_a7068df5cdd622b0 = 1, func_override_droplist, b_ignore_cleanup = 1, b_allow_recycling = 1, var_53b9cbd8aea1973e, b_full_points = 0, var_a852315056f0d085 = 0 )
{
    level endon( wave_name + "stop_wave_spawner" );
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_9488b7fb21f3ab49 ) )
    {
        level callback::add( #"on_ai_killed", &function_9488b7fb21f3ab49 );
    }
    
    if ( isdefined( override_round_difficulty ) )
    {
        round_difficulty = zm_round_logic::get_rb_round_number() > override_round_difficulty ? zm_round_logic::get_rb_round_number() : override_round_difficulty;
    }
    else
    {
        round_difficulty = zm_round_logic::get_rb_round_number();
    }
    
    if ( isdefined( override_wave_interval ) )
    {
        wave_interval = override_wave_interval;
    }
    else
    {
        wave_interval = 5;
    }
    
    wave_info_path = level.var_e3064ad51e263dae[ wave_name ][ "wave_info" ];
    function_3329c782f2fda682( wave_info_path );
    
    while ( true )
    {
        foreach ( wave_index, wave_info in wave_info_path )
        {
            flag_index = 0;
            finish_spawn_flags = [];
            
            foreach ( info in wave_info.zombie_info )
            {
                info.myparent = wave_info;
                info.finish_spawn_flag = wave_name + wave_index + flag_index + "finish_spawn";
                info.wave_name = wave_name;
                info.round_difficulty = round_difficulty;
                info.var_a7068df5cdd622b0 = var_a7068df5cdd622b0;
                info.func_override_droplist = func_override_droplist;
                info.b_ignore_cleanup = b_ignore_cleanup;
                info.b_allow_recycling = b_allow_recycling;
                info.var_53b9cbd8aea1973e = var_53b9cbd8aea1973e;
                info.b_full_points = b_full_points;
                info.var_a852315056f0d085 = var_a852315056f0d085;
                info thread spawn_wave_zombies();
                finish_spawn_flags[ finish_spawn_flags.size ] = info.finish_spawn_flag;
                flag_index++;
            }
            
            level utility::flag_wait_all_array( finish_spawn_flags );
            
            foreach ( flag in finish_spawn_flags )
            {
                level utility::flag_clear( flag );
            }
            
            /#
                iprintlnbold( "<dev string:x68e>" + wave_index + "<dev string:x6ab>" );
            #/
            
            wait wave_interval;
        }
    }
    
    /#
        iprintlnbold( wave_name + "<dev string:x6a2>" );
    #/
    
    level callback::remove( #"on_ai_killed", &function_9488b7fb21f3ab49 );
}

// Namespace zm_quest
// Params 9
// Checksum 0x63cf9a9c, Offset: 0xf3f8
// Size: 0x34d
function function_c058b90bfd86cc05( wave_name, override_wave_interval, override_round_difficulty, var_a7068df5cdd622b0 = 1, func_override_droplist, b_ignore_cleanup = 1, b_allow_recycling = 1, var_53b9cbd8aea1973e, b_full_points = 0 )
{
    level endon( wave_name + "stop_wave_spawner" );
    level endon( #"game_ended" );
    
    if ( isdefined( override_round_difficulty ) )
    {
        round_difficulty = zm_round_logic::get_rb_round_number() > override_round_difficulty ? zm_round_logic::get_rb_round_number() : override_round_difficulty;
    }
    else
    {
        round_difficulty = zm_round_logic::get_rb_round_number();
    }
    
    if ( isdefined( override_wave_interval ) )
    {
        wave_interval = override_wave_interval;
    }
    else
    {
        wave_interval = 5;
    }
    
    wave_info_path = level.var_e3064ad51e263dae[ wave_name ][ "wave_info" ];
    function_3329c782f2fda682( wave_info_path );
    
    while ( true )
    {
        finish_spawn_flags = [];
        
        foreach ( wave_index, wave_info in wave_info_path )
        {
            flag_index = 0;
            
            foreach ( info in wave_info.zombie_info )
            {
                info.myparent = wave_info;
                info.finish_spawn_flag = wave_name + wave_index + flag_index + "finish_spawn";
                info.wave_name = wave_name;
                info.round_difficulty = round_difficulty;
                info.var_a7068df5cdd622b0 = var_a7068df5cdd622b0;
                info.func_override_droplist = func_override_droplist;
                info.b_ignore_cleanup = b_ignore_cleanup;
                info.b_allow_recycling = b_allow_recycling;
                info.var_53b9cbd8aea1973e = var_53b9cbd8aea1973e;
                info.b_full_points = b_full_points;
                info thread spawn_wave_zombies();
                finish_spawn_flags[ finish_spawn_flags.size ] = info.finish_spawn_flag;
                flag_index++;
            }
            
            /#
                iprintlnbold( "<dev string:x68e>" + wave_index + "<dev string:x6ab>" );
            #/
        }
        
        level utility::flag_wait_all_array( finish_spawn_flags );
        
        foreach ( flag in finish_spawn_flags )
        {
            level utility::flag_clear( flag );
        }
        
        /#
            iprintlnbold( wave_name + "<dev string:x6a2>" );
        #/
        
        wait wave_interval;
    }
}

// Namespace zm_quest
// Params 3
// Checksum 0xe916d3bd, Offset: 0xf74d
// Size: 0xef
function stop_wave_spawner( wave_name, b_cleanup_spawned_zombies, var_2e559d7f79adfa96 )
{
    level notify( wave_name + "stop_wave_spawner" );
    level callback::remove( #"on_ai_killed", &function_9488b7fb21f3ab49 );
    
    if ( var_2e559d7f79adfa96 )
    {
        return;
    }
    
    if ( b_cleanup_spawned_zombies )
    {
        if ( isdefined( level.var_e3064ad51e263dae[ wave_name ][ "spawned_zombies" ] ) )
        {
            level.var_e3064ad51e263dae[ wave_name ][ "spawned_zombies" ] = utility::array_removedead_or_dying( level.var_e3064ad51e263dae[ wave_name ][ "spawned_zombies" ] );
            
            if ( isdefined( level.players[ 0 ] ) )
            {
                level.players[ 0 ] thread nuke::function_6c5906115e825d8f( level.players[ 0 ].origin, level.var_e3064ad51e263dae[ wave_name ][ "spawned_zombies" ], "nuke", 1 );
            }
        }
        
        return;
    }
    
    cleanup_zombies_manually( 1, undefined, undefined, undefined, 1, 1, 1 );
}

// Namespace zm_quest
// Params 3
// Checksum 0xafa25911, Offset: 0xf844
// Size: 0xb9
function function_2e182317dbf918cd( wave_name, wave_info, n_wave_timeout )
{
    level endon( #"game_ended" );
    level endon( wave_name + "stop_wave_spawner" );
    
    if ( !isdefined( wave_info.wave_amount ) )
    {
        return;
    }
    
    level.var_604c48c3d6a79635 = 0;
    time = 0;
    
    while ( true )
    {
        if ( level.var_604c48c3d6a79635 >= wave_info.wave_amount )
        {
            break;
        }
        
        wait 0.1;
        
        if ( isdefined( n_wave_timeout ) )
        {
            time += 0.1;
            
            if ( time >= n_wave_timeout )
            {
                break;
            }
        }
    }
    
    /#
        iprintlnbold( "<dev string:x6ba>" );
    #/
    
    level notify( #"hash_7e06161e5410128c" );
}

// Namespace zm_quest
// Params 1
// Checksum 0xabe79279, Offset: 0xf905
// Size: 0x115
function function_3329c782f2fda682( wave_info_path )
{
    foreach ( wave_info in wave_info_path )
    {
        wave_info.wave_amount = 0;
        
        foreach ( info in wave_info.zombie_info )
        {
            wave_info.wave_amount += info.zombie_amount;
        }
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0x32d8ddff, Offset: 0xfa22
// Size: 0x3a9
function spawn_wave_zombies()
{
    level endon( #"game_ended" );
    level endon( self.wave_name + "stop_wave_spawner" );
    finish_spawn_flag = self.finish_spawn_flag;
    sparams = spawnstruct();
    sparams.wave_name = self.wave_name;
    sparams.round_difficulty = self.round_difficulty;
    sparams.var_a7068df5cdd622b0 = self.var_a7068df5cdd622b0 ?? 0;
    sparams.func_override_droplist = self.func_override_droplist;
    sparams.b_ignore_cleanup = self.b_ignore_cleanup;
    sparams.b_full_points = self.b_full_points;
    max_active_zombies = self.var_53b9cbd8aea1973e ?? level.var_a009ab14ee0d3223.var_63a0ca44b877a390;
    sparams.var_a852315056f0d085 = self.var_a852315056f0d085;
    spawn_count = 0;
    
    while ( true )
    {
        if ( spawn_count >= self.zombie_amount )
        {
            break;
        }
        
        var_71386e3f25e25f9d = 0;
        zombies = zm_utility::get_active_zombies();
        
        if ( self.b_allow_recycling )
        {
            foreach ( zombie in zombies )
            {
                if ( !zombie.b_ignore_cleanup )
                {
                    var_71386e3f25e25f9d = 1;
                    break;
                }
            }
        }
        
        if ( ( zombies.size >= max_active_zombies || getfreeagentcount() == 0 ) && !var_71386e3f25e25f9d )
        {
            wait 0.1;
            continue;
        }
        
        sparams.zombie_type = get_random_zombie_type();
        println( "<dev string:x6d0>" + self.zombie_amount + "<dev string:x6df>" + sparams.zombie_type + "<dev string:x6e1>" + zombies.size );
        
        if ( !sparams.var_a7068df5cdd622b0 )
        {
            sparams.spawner = get_random_spawn_pos( self.wave_name, sparams.zombie_type );
            sparams.origin = sparams.spawner.origin;
            
            if ( var_71386e3f25e25f9d )
            {
                zombie = zm_utility::function_9f6754719bfeaeb1( [ "normal" ], &function_e12f244597701aef, sparams, undefined, self.var_53b9cbd8aea1973e );
            }
            else
            {
                zombie = function_e12f244597701aef( sparams );
            }
        }
        else if ( var_71386e3f25e25f9d )
        {
            zombie = zm_utility::function_9f6754719bfeaeb1( [ "normal" ], &function_a7df932b183d9ab9, sparams, undefined, self.var_53b9cbd8aea1973e );
        }
        else
        {
            zombie = function_a7df932b183d9ab9( sparams );
        }
        
        if ( isai( zombie ) && isalive( zombie ) )
        {
            params = spawnstruct();
            params.zombie = zombie;
            callback::callback( "wave_spawner_zombie_spawned", params );
            spawn_count++;
            
            if ( spawn_count >= self.zombie_amount )
            {
                break;
            }
        }
        
        var_d2dea1eb5c269d79 = self.var_d2dea1eb5c269d79 == 0 ? 0.1 : self.var_d2dea1eb5c269d79;
        
        if ( spawn_count < int( self.zombie_amount / 3 ) )
        {
            var_d2dea1eb5c269d79 = 0.1;
        }
        
        wait var_d2dea1eb5c269d79;
        quest_throttle_wait();
    }
    
    if ( isdefined( finish_spawn_flag ) )
    {
        level utility::flag_set( finish_spawn_flag );
    }
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0xfb061849, Offset: 0xfdd3
// Size: 0x52
function private function_e12f244597701aef( sparams )
{
    zombie = agent_manager::spawn_agent( sparams.zombie_type, sparams.origin, ( 0, 0, 0 ), "team_two_hundred" );
    init_wave_zombie( zombie, sparams );
    return zombie;
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0x16d6fc91, Offset: 0xfe2e
// Size: 0x5c
function private function_a7df932b183d9ab9( sparams )
{
    zombie = agent_spawner::spawn_agent( sparams.zombie_type );
    
    if ( !isdefined( zombie ) )
    {
        /#
            iprintlnbold( "<dev string:x6f5>" + sparams.zombie_type + "<dev string:x716>" );
        #/
        
        return;
    }
    
    init_wave_zombie( zombie, sparams );
    return zombie;
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0xf11d1344, Offset: 0xfe93
// Size: 0x26d
function private init_wave_zombie( zombie, sparams )
{
    if ( zombie )
    {
        zombie.no_powerups = 1;
        zombie val::set( "zm_quest_spawn_wave", "ignore_cleanup", sparams.b_ignore_cleanup );
        zombie.ignore_enemy_count = 1;
        zombie.var_9ee436be1a5adf9c = 1;
        zombie.b_cleanup_no_respawn = 1;
        zombie.wave_name = sparams.wave_name;
        
        if ( isdefined( sparams.func_override_droplist ) )
        {
            if ( !isfunction( sparams.func_override_droplist ) )
            {
                assertmsg( "<dev string:x727>" );
            }
            else
            {
                zombie.var_50c96a5c56dab386 = sparams.func_override_droplist;
            }
        }
        
        if ( !isdefined( level.var_e3064ad51e263dae[ sparams.wave_name ][ "spawned_zombies" ] ) )
        {
            level.var_e3064ad51e263dae[ sparams.wave_name ][ "spawned_zombies" ] = [];
        }
        
        level.var_e3064ad51e263dae[ sparams.wave_name ][ "spawned_zombies" ][ level.var_e3064ad51e263dae[ sparams.wave_name ][ "spawned_zombies" ].size ] = zombie;
        
        if ( !isdefined( sparams.b_full_points ) )
        {
            sparams.b_full_points = 0;
        }
        
        if ( !sparams.b_full_points )
        {
            if ( zombie.aicategory == "normal" )
            {
                zombie.kiastring = #"zombie_kia_mission_kill";
            }
            else if ( zombie.aicategory == "special" )
            {
                zombie.kiastring = #"zombie_kia_mission_kill_special";
            }
            else
            {
                zombie.kiastring = #"zombie_kia_mission_kill_elite";
            }
        }
        
        zombie zombie_utils::set_zombie_round_difficulty( sparams.round_difficulty );
        move_speed = zm_round_spawning::function_6211dbc10409aa10( sparams.round_difficulty );
        zombie zombie_utils::function_a8ce00e0448cb6f0( move_speed, "zm_quest", 6 );
        
        if ( sparams.var_a852315056f0d085 )
        {
            zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        }
        
        if ( isdefined( sparams.spawner.script_animation ) )
        {
            zombie thread zone_spawner::function_ce10e453e7f7bb8e( sparams.spawner );
        }
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0x8af4c016, Offset: 0x10108
// Size: 0xe8
function get_random_zombie_type()
{
    if ( self.zombie_types.size == 1 )
    {
        return self.zombie_types[ 1 ].zombie_type;
    }
    
    random_index = randomintrange( 0, 100 );
    base_weight = 0;
    
    foreach ( info in self.zombie_types )
    {
        if ( random_index <= info.spawn_weight + base_weight )
        {
            return info.zombie_type;
        }
        
        base_weight += info.spawn_weight;
    }
}

// Namespace zm_quest
// Params 2
// Checksum 0x3903b845, Offset: 0x101f8
// Size: 0x162
function get_random_spawn_pos( wave_name, aitype )
{
    if ( aitype == "zombie_base_armored_heavy" || aitype == "zombie_base_armored_light" || aitype == "zombie_vermin" )
    {
        aitype = "zombie_base";
    }
    else if ( issubstr( aitype, "zombie_viper" ) )
    {
        aitype = [ "zombie_amalgam", "zombie_ghoul" ];
    }
    
    if ( isarray( aitype ) )
    {
        spawns_array = [];
        
        foreach ( ai in aitype )
        {
            spawns_array = arraycombine( spawns_array, level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ ai ] );
        }
        
        return utility::array_random( spawns_array );
    }
    
    if ( isdefined( level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ aitype ] ) )
    {
        return utility::array_random( level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ aitype ] );
    }
    
    return utility::array_random( level.var_e3064ad51e263dae[ wave_name ][ "spawner" ][ "common_spawner" ] );
}

// Namespace zm_quest
// Params 0
// Checksum 0x7eb6798b, Offset: 0x10362
// Size: 0x56
function function_97f4d1f4a32be7bc()
{
    switch ( level.players.size )
    {
        case 1:
            return 1;
        case 2:
            return 1.25;
        case 3:
            return 1.5;
        case 4:
            return 2;
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0xf6ec5f58, Offset: 0x103c0
// Size: 0x25
function function_c80938ebe76dfa2b()
{
    if ( isdefined( level.var_604c48c3d6a79635 ) )
    {
        level.var_604c48c3d6a79635++;
    }
    
    level notify( #"wave_zombie_killed" );
}

// Namespace zm_quest
// Params 1
// Checksum 0x55ca40c9, Offset: 0x103ed
// Size: 0x509
function function_2e003fa13e881f92( reward_location )
{
    var_553852fcf8d6a028 = 20;
    
    if ( isstruct( reward_location ) )
    {
        v_reward_location = reward_location.origin;
    }
    else if ( isstring( reward_location ) )
    {
        s_reward_loc = utility::getstruct( reward_location, "targetname" );
        v_reward_location = s_reward_loc.origin;
    }
    else if ( isvector( reward_location ) )
    {
        v_reward_location = reward_location;
    }
    
    if ( !isdefined( v_reward_location ) )
    {
        return;
    }
    
    s_bundle = getscriptbundle( level.gamemodebundle.var_3a97f7b452e7a88c );
    n_drop_radius = s_bundle.spawnradius;
    var_60632a5620f703cb = s_bundle.var_8c6f42ca360c4a91 ?? 0;
    var_9bc2b60491678146 = s_bundle.var_6a0d8cc2d9099bd3 ?? 0;
    var_6226dcaf2e9e418b = s_bundle.var_b3732fec0494ad32 ?? 0;
    n_weapon_count = s_bundle.var_a607ad63a429223b ?? 0;
    var_4e02982db4f3126b = s_bundle.var_cbc9b50f6b5fa287 ?? 0;
    var_e00193286517c534 = s_bundle.var_73ec52440c1f96d5 ?? 0;
    var_55b43e8a14e3ed7 = s_bundle.var_ed7b9cc7a088dad0 ?? 0;
    random_points = getrandomnavpoints( v_reward_location, n_drop_radius, var_60632a5620f703cb );
    
    for ( i = 0; i < random_points.size ; i++ )
    {
        random_points[ i ] = utility::drop_to_ground( random_points[ i ], 500 ) + ( 0, 0, var_553852fcf8d6a028 );
        powerups::powerup_drop( "bonus_points_team", random_points[ i ], undefined, undefined, "quest" );
    }
    
    random_points = getrandomnavpoints( v_reward_location, n_drop_radius, var_9bc2b60491678146 );
    var_42527d39242189fe = common_item::items_selectfromlist( s_bundle.currencyitemspawnlist, var_9bc2b60491678146 );
    
    for ( i = 0; i < random_points.size ; i++ )
    {
        if ( !isdefined( var_42527d39242189fe[ i ] ) )
        {
            continue;
        }
        
        random_points[ i ] = utility::drop_to_ground( random_points[ i ], 500 );
        common_item::function_a87dc047f584d2c7( var_42527d39242189fe[ i ], random_points[ i ] );
    }
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && !player.inlaststand )
        {
            player thread function_154144be2ce27a8d();
        }
    }
    
    random_points = getrandomnavpoints( v_reward_location, n_drop_radius, var_6226dcaf2e9e418b );
    var_dcc8c923a36fb895 = common_item::items_selectfromlist( s_bundle.wonderweaponitemspawnlist, var_6226dcaf2e9e418b );
    
    for ( i = 0; i < random_points.size ; i++ )
    {
        if ( !isdefined( var_dcc8c923a36fb895[ i ] ) )
        {
            continue;
        }
        
        random_points[ i ] = utility::drop_to_ground( random_points[ i ], 500 );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( random_points[ i ] );
        s_item_bundle = getscriptbundle( var_dcc8c923a36fb895[ i ] );
        item_weapon::function_b960bc85ea91de14( s_item_bundle, spawnoptions );
    }
    
    random_points = getrandomnavpoints( v_reward_location, n_drop_radius, n_weapon_count );
    var_578ef8c6d450cad1 = common_item::items_selectfromlist( s_bundle.weaponitemspawnlist, n_weapon_count );
    
    for ( i = 0; i < random_points.size ; i++ )
    {
        if ( !isdefined( var_578ef8c6d450cad1[ i ] ) )
        {
            continue;
        }
        
        random_points[ i ] = utility::drop_to_ground( random_points[ i ], 500 );
        str_legendary_weapon = hashcat( var_578ef8c6d450cad1[ i ], "_orange" );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( random_points[ i ] );
        s_item_bundle = getscriptbundle( str_legendary_weapon );
        
        if ( !isdefined( s_item_bundle ) )
        {
            s_item_bundle = getscriptbundle( var_578ef8c6d450cad1[ i ] );
        }
        
        item_weapon::function_b960bc85ea91de14( s_item_bundle, spawnoptions );
    }
    
    random_points = getrandomnavpoints( v_reward_location, n_drop_radius, var_e00193286517c534 );
    var_776c7f05ec2b3c6c = common_item::items_selectfromlist( s_bundle.ammomoditemspawnlist, var_e00193286517c534 );
    
    for ( i = 0; i < random_points.size ; i++ )
    {
        if ( !isdefined( var_776c7f05ec2b3c6c[ i ] ) )
        {
            continue;
        }
        
        random_points[ i ] = utility::drop_to_ground( random_points[ i ], 500 );
        common_item::function_a87dc047f584d2c7( var_776c7f05ec2b3c6c[ i ], random_points[ i ] );
    }
    
    random_points = getrandomnavpoints( v_reward_location, n_drop_radius, var_4e02982db4f3126b );
    var_7cab07b711bece69 = common_item::items_selectfromlist( s_bundle.upgradeitemspawnlist, var_4e02982db4f3126b );
    
    for ( i = 0; i < random_points.size ; i++ )
    {
        if ( !isdefined( var_7cab07b711bece69[ i ] ) )
        {
            continue;
        }
        
        random_points[ i ] = utility::drop_to_ground( random_points[ i ], 500 );
        common_item::function_a87dc047f584d2c7( var_7cab07b711bece69[ i ], random_points[ i ] );
    }
    
    if ( s_bundle.var_891db1e772825cb )
    {
        random_points = getrandomnavpoints( v_reward_location, n_drop_radius, var_55b43e8a14e3ed7 );
        var_7cab07b711bece69 = common_item::items_selectfromlist( s_bundle.var_891db1e772825cb, var_55b43e8a14e3ed7 );
        
        for ( i = 0; i < random_points.size ; i++ )
        {
            if ( !isdefined( var_7cab07b711bece69[ i ] ) )
            {
                continue;
            }
            
            random_points[ i ] = utility::drop_to_ground( random_points[ i ], 500 );
            common_item::function_a87dc047f584d2c7( var_7cab07b711bece69[ i ], random_points[ i ] );
        }
    }
}

// Namespace zm_quest
// Params 0, eflags: 0x4
// Checksum 0x149256a8, Offset: 0x108fe
// Size: 0xf8
function private function_154144be2ce27a8d()
{
    self endon( #"death_or_disconnect" );
    valid_perks = zombie_perks::get_perks_str_array();
    
    if ( isdefined( valid_perks ) && valid_perks.size != 0 )
    {
        perk_name = valid_perks[ 0 ];
        gesture = level._custom_perks[ perk_name ].perk_bottle_weapon ?? "cer_zm_vm_ges_001";
        utility::function_72b6372d2d8c997( gesture, 1 );
        
        foreach ( perk in valid_perks )
        {
            if ( !zombie_perks::has_perk( perk ) )
            {
                zombie_perks::give_perk( perk, undefined, perk_name === valid_perks[ 0 ] );
            }
            
            wait 0.1;
        }
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0x80ee01db, Offset: 0x109fe
// Size: 0x60b
function update_guidance( huddata, quest_ref, step_ref, var_ea6cb90f36a2e7bf = 0 )
{
    level endon( #"game_ended" );
    function_b5d75b34f712db9a();
    
    if ( !isdefined( level.directed_mode ) )
    {
        return;
    }
    
    if ( !var_ea6cb90f36a2e7bf )
    {
        if ( isdefined( level.directed_mode.var_ec54378cf831e7c1 ) )
        {
            if ( level.zm_quests_steps[ level.directed_mode.var_ec54378cf831e7c1 ][ level.directed_mode.var_fcdcd383b4f959ed ] === utility::function_f1933af772476229( level.zm_quests_steps[ level.directed_mode.var_ec54378cf831e7c1 ] ) && !level.directed_mode.var_b75d36ea70a4ebc9 )
            {
                function_fb3af5600f6a9441( 4, 1, level.directed_mode.var_ec54378cf831e7c1, level.directed_mode.var_fcdcd383b4f959ed );
                waitframe();
                function_a81dd416b9036f0e( 1, level.directed_mode.var_ec54378cf831e7c1 );
                level.directed_mode.var_b75d36ea70a4ebc9 = 1;
                wait 10;
                
                if ( !level.directed_mode.var_b75d36ea70a4ebc9 || level.zm_quests_steps[ level.directed_mode.var_ec54378cf831e7c1 ][ level.directed_mode.var_fcdcd383b4f959ed ] != utility::function_f1933af772476229( level.zm_quests_steps[ level.directed_mode.var_ec54378cf831e7c1 ] ) )
                {
                    level.directed_mode.var_b75d36ea70a4ebc9 = 0;
                    return;
                }
                
                level.directed_mode.var_b75d36ea70a4ebc9 = 0;
            }
        }
    }
    
    if ( isdefined( huddata ) )
    {
        foreach ( hudobject in huddata )
        {
            if ( isdefined( hudobject[ 0 ] ) )
            {
                var_73fb6215ee18ec22 = spawnstruct();
                var_73fb6215ee18ec22.index = level.directed_mode.var_f1879f50f4eeaca3.size;
                var_73fb6215ee18ec22.offset = hudobject[ 1 ];
                var_73fb6215ee18ec22.radius = hudobject[ 2 ];
                var_73fb6215ee18ec22.var_7658622ac37ea4e5 = hudobject[ 4 ];
                var_73fb6215ee18ec22.var_895bdd0db4c4515 = ( isdefined( hudobject[ 5 ] ) && !isarray( hudobject[ 5 ] ) ? [ hudobject[ 5 ] ] : hudobject[ 5 ] ) ?? [];
                var_73fb6215ee18ec22.origin = isvector( hudobject[ 0 ] ) ? hudobject[ 0 ] : hudobject[ 0 ].origin;
                level.directed_mode.var_f1879f50f4eeaca3[ level.directed_mode.var_f1879f50f4eeaca3.size ] = var_73fb6215ee18ec22;
                
                if ( isdefined( hudobject[ 0 ] ) && !isdefined( var_73fb6215ee18ec22.radius ) )
                {
                    if ( !isdefined( var_73fb6215ee18ec22.offset ) )
                    {
                        var_73fb6215ee18ec22.offset = 20;
                    }
                    
                    if ( isent( hudobject[ 0 ] ) )
                    {
                        var_73fb6215ee18ec22.objindex = function_dc297429579c6e7f( string( var_73fb6215ee18ec22.index ), 0, "ui_icon_zm_objective", undefined, "current", hudobject[ 0 ], var_73fb6215ee18ec22.offset, hudobject[ 3 ], undefined, 1, 0, undefined, var_73fb6215ee18ec22.var_895bdd0db4c4515 );
                    }
                    else
                    {
                        var_73fb6215ee18ec22.objindex = function_b98d4144845ffc13( string( var_73fb6215ee18ec22.index ), 0, "ui_icon_zm_objective", undefined, "current", var_73fb6215ee18ec22.origin, var_73fb6215ee18ec22.offset, hudobject[ 3 ], undefined, 1, 0, var_73fb6215ee18ec22.var_895bdd0db4c4515 );
                    }
                    
                    continue;
                }
                
                if ( isdefined( var_73fb6215ee18ec22.radius ) )
                {
                    if ( var_73fb6215ee18ec22.offset > 0 )
                    {
                        level.directed_mode.var_f1879f50f4eeaca3[ level.directed_mode.var_f1879f50f4eeaca3.size - 1 ] game_utility::questcircle_create( "testCircle_Orange", utility::getrandompointincircle( var_73fb6215ee18ec22.origin, var_73fb6215ee18ec22.offset ), var_73fb6215ee18ec22.radius );
                    }
                    else
                    {
                        level.directed_mode.var_f1879f50f4eeaca3[ level.directed_mode.var_f1879f50f4eeaca3.size - 1 ] game_utility::questcircle_create( "testCircle_Orange", var_73fb6215ee18ec22.origin, var_73fb6215ee18ec22.radius );
                    }
                    
                    if ( var_73fb6215ee18ec22.var_7658622ac37ea4e5 )
                    {
                        level.directed_mode.var_f1879f50f4eeaca3[ level.directed_mode.var_f1879f50f4eeaca3.size - 1 ] thread game_utility::function_de7fe184eb0e834c();
                        continue;
                    }
                    
                    level.directed_mode.var_f1879f50f4eeaca3[ level.directed_mode.var_f1879f50f4eeaca3.size - 1 ] game_utility::questcircle_showtoall();
                }
            }
        }
    }
    
    if ( isdefined( quest_ref ) && isdefined( step_ref ) )
    {
        quest_step = get_quest_step( quest_ref, step_ref );
        
        if ( level.directed_mode.var_fcdcd383b4f959ed != step_ref || level.directed_mode.var_ec54378cf831e7c1 != quest_ref )
        {
            function_fba942a1cfd85f5d( 1, 1, quest_ref, step_ref );
            
            if ( level.zm_quests_steps[ quest_ref ][ step_ref ] == utility::array_get_first_item( level.zm_quests_steps[ quest_ref ] ) )
            {
                function_fb3af5600f6a9441( 1, 1, quest_ref, step_ref );
                return;
            }
            
            function_fb3af5600f6a9441( 2, 1, quest_ref, step_ref );
        }
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x1268f6be, Offset: 0x11011
// Size: 0xc7
function function_38cacc34ddb8431c( player )
{
    if ( !isdefined( level.directed_mode ) )
    {
        return;
    }
    
    foreach ( hudobject in level.directed_mode.var_f1879f50f4eeaca3 )
    {
        if ( isdefined( hudobject.radius ) == 0 )
        {
            objidpoolmanager::objective_playermask_hidefrom( hudobject.objindex, player );
            continue;
        }
        
        hudobject game_utility::questcircle_hidefromplayer( player );
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x9bf55c86, Offset: 0x110e0
// Size: 0xd6
function function_1a1a1e0bd84ac45e( player )
{
    if ( !isdefined( level.directed_mode ) )
    {
        return;
    }
    
    foreach ( hudobject in level.directed_mode.var_f1879f50f4eeaca3 )
    {
        if ( isdefined( hudobject.radius ) == 0 )
        {
            if ( isdefined( hudobject.objindex ) )
            {
                objidpoolmanager::objective_playermask_addshowplayer( hudobject.objindex, player );
            }
            
            continue;
        }
        
        hudobject game_utility::questcircle_showtoplayer( player );
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x26ae27e3, Offset: 0x111be
// Size: 0x109
function function_5b5c737326035ea( var_f6faf92a6f00f654 )
{
    if ( !isdefined( level.directed_mode ) )
    {
        return;
    }
    
    foreach ( hudobject in level.directed_mode.var_f1879f50f4eeaca3 )
    {
        if ( hudobject.index == var_f6faf92a6f00f654 )
        {
            if ( isdefined( hudobject.radius ) == 0 )
            {
                complete_objective_waypoints( string( hudobject.index ) );
            }
            else
            {
                hudobject game_utility::questcircle_delete();
            }
            
            level.directed_mode.var_f1879f50f4eeaca3 = arrayremove( level.directed_mode.var_f1879f50f4eeaca3, hudobject );
            break;
        }
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0xb2318a86, Offset: 0x112cf
// Size: 0x5a
function clear_all_guidance()
{
    if ( isdefined( level.directed_mode ) )
    {
        level.directed_mode.var_b75d36ea70a4ebc9 = 0;
        level.directed_mode.var_fcdcd383b4f959ed = undefined;
        level.directed_mode.var_ec54378cf831e7c1 = undefined;
        function_e66ab24194b8627e( 1 );
    }
    
    function_b5d75b34f712db9a();
}

// Namespace zm_quest
// Params 0
// Checksum 0xbf3fd414, Offset: 0x11331
// Size: 0xd3
function function_b5d75b34f712db9a()
{
    if ( !isdefined( level.directed_mode ) )
    {
        return;
    }
    
    foreach ( hudobject in level.directed_mode.var_f1879f50f4eeaca3 )
    {
        if ( isdefined( hudobject.radius ) == 0 )
        {
            complete_objective_waypoints( string( hudobject.index ) );
            continue;
        }
        
        hudobject game_utility::questcircle_delete();
    }
    
    level.directed_mode.var_f1879f50f4eeaca3 = [];
}

// Namespace zm_quest
// Params 0
// Checksum 0x21151d5f, Offset: 0x1140c
// Size: 0x58, Type: bool
function function_b0a5181ebe7bb905()
{
    if ( getdvarint( @"scr_debug_enable_story_mode", 0 ) )
    {
        if ( !isdefined( level.directed_mode ) )
        {
            level.directed_mode = spawnstruct();
        }
    }
    
    return isdefined( level.directed_mode ) || getdvarint( @"scr_debug_enable_story_mode", 0 ) || level utility::flag( "debug_enable_story_mode" );
}

// Namespace zm_quest
// Params 3
// Checksum 0xa4eaa6c9, Offset: 0x1146d
// Size: 0x62
function update_round_cap( var_7c9e4e64512f6acc, var_db116d47ae64a6f2, var_151a167f3d733235 = 5 )
{
    if ( isdefined( level.directed_mode ) )
    {
        if ( var_7c9e4e64512f6acc > zm_round_logic::get_rb_round_cap() || var_db116d47ae64a6f2 == 1 )
        {
            zm_round_logic::set_rb_round_cap( var_7c9e4e64512f6acc );
            wait var_151a167f3d733235;
            zm_utility::function_3558e91cc9f432c1( zm_round_logic::get_rb_round_cap() );
        }
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0xf5bd88e2, Offset: 0x114d7
// Size: 0xc
function set_max_round_cap()
{
    level thread update_round_cap( 15 );
}

// Namespace zm_quest
// Params 0
// Checksum 0xd42b3251, Offset: 0x114eb
// Size: 0xc
function function_7fab7522eb770d3d()
{
    level thread update_round_cap( 10 );
}

// Namespace zm_quest
// Params 0
// Checksum 0x930addf2, Offset: 0x114ff
// Size: 0x4f
function quest_throttle_wait()
{
    if ( !isdefined( level.zm_quest_throttle ) )
    {
        level.zm_quest_throttle = throttle::throttle_initialize( "zm_quest_throttle", 1, level.framedurationseconds );
    }
    
    throttle_wait_event = spawnstruct();
    throttle::throttle_wait_in_queue( level.zm_quest_throttle, throttle_wait_event );
}

// Namespace zm_quest
// Params 0
// Checksum 0xc0478fce, Offset: 0x11556
// Size: 0x14, Type: bool
function function_9b18c35fba5c3d31()
{
    if ( utility::ent_flag( "field_upgrade_in_use" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_quest
// Params 1
// Checksum 0x17e2bb57, Offset: 0x11573
// Size: 0x86
function function_3cd20480f3896964( pos )
{
    foreach ( player in level.players )
    {
        player predictstreamposuntilcleared( pos, 3 );
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x8b15edec, Offset: 0x11601
// Size: 0x83
function function_7f9022845008a2f9( pos )
{
    foreach ( player in level.players )
    {
        player clearpredictedstreampos();
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0xe1e373f3, Offset: 0x1168c
// Size: 0x16f
function function_2850bf8c7015dc92( var_bd9125e451671092 )
{
    if ( !isarray( var_bd9125e451671092 ) && var_bd9125e451671092.size != 0 )
    {
        return;
    }
    
    items = scriptable_group::function_dbae202082772159( "common_items" );
    items = function_5713d46873b29625( items );
    
    foreach ( item in items )
    {
        if ( isdefined( item ) )
        {
            quest_throttle_wait();
            
            foreach ( zone in var_bd9125e451671092 )
            {
                current_zone = zone_manager::function_90e5c3e2272b0130( item.origin );
                
                if ( !isdefined( current_zone ) )
                {
                    continue;
                }
                
                current_zone_name = zone_manager::function_2bcd755aabfd3cad( current_zone );
                
                if ( isdefined( current_zone_name ) && arraycontains( var_bd9125e451671092, current_zone_name ) )
                {
                    level thread common_item::function_869d7676e359a627( item );
                    break;
                }
            }
        }
    }
}

// Namespace zm_quest
// Params 3
// Checksum 0x290008b6, Offset: 0x11803
// Size: 0x5b
function spawn_quest_item( v_position, v_angles, item )
{
    spawnoptions = common_item::function_bc5ff2958b71a708( v_position, v_angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.critical = 1;
    return common_item::function_61c2c0251e742ffd( item, 1, spawnoptions );
}

// Namespace zm_quest
// Params 3
// Checksum 0xa47ecbc2, Offset: 0x11867
// Size: 0x7f
function function_f6c8318893f5557b( v_position, v_angles, item )
{
    item_bundle = getscriptbundle( item );
    spawnoptions = common_item::function_bc5ff2958b71a708( v_position, v_angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.critical = 1;
    positioningdata = common_item::function_b4bee4333994e45a( v_position, v_angles );
    return common_item::function_2352d25db9e97696( item_bundle, 1, positioningdata, spawnoptions );
}

// Namespace zm_quest
// Params 3
// Checksum 0x8031f1cd, Offset: 0x118ef
// Size: 0x2c
function drop_quest_item( v_position, v_drop_position, item )
{
    return common_item::function_47324f290423b2d1( item, v_position, v_drop_position, 1, 1 );
}

// Namespace zm_quest
// Params 0
// Checksum 0xf5d451b8, Offset: 0x11924
// Size: 0x114, Type: bool
function function_fe144040df1a30f5()
{
    var_e20a53a4691be8de = 0;
    
    foreach ( weapon in self.primaryinventory )
    {
        if ( !isdefined( weapon ) || weapon::isunderwaterweapon( weapon ) || weapon::isclimbweapon( weapon ) || weapon::isgunlessweapon( weapon ) || weapon::ismeleeoverrideweapon( weapon ) || weapon.basename == "none" || weapon.inventorytype != "primary" )
        {
            continue;
        }
        
        var_e20a53a4691be8de++;
    }
    
    if ( var_e20a53a4691be8de > 3 )
    {
        item_weapon::items_weapon_removeweapon( { #dontdrop:0, #slotname:#"primary_0" } );
        return true;
    }
    
    return false;
}

// Namespace zm_quest
// Params 4
// Checksum 0x31726c4f, Offset: 0x11a41
// Size: 0x135
function show_splash_item_picked_up( quest_ref, item_ref, var_41f8529e24f6fb4b, player )
{
    if ( !player )
    {
        return;
    }
    
    var_55d1b16ebceb15c7 = get_inventory_quest_index( quest_ref, player getentitynumber() );
    var_de62e2ee16779fce = function_23669314446ef229( quest_ref, player );
    var_96e4faf416364416 = function_4fb414c4dfe38da5( quest_ref, var_de62e2ee16779fce, item_ref, player );
    var_1d501fd0a26de022 = function_2b3236bd3ec53687( quest_ref, var_de62e2ee16779fce, item_ref, var_41f8529e24f6fb4b, player );
    
    if ( isdefined( var_55d1b16ebceb15c7 ) && isdefined( var_de62e2ee16779fce ) && isdefined( var_96e4faf416364416 ) && isdefined( var_1d501fd0a26de022 ) )
    {
        var_1541441b498a1355 = function_58a56454a0055b02( var_55d1b16ebceb15c7, var_de62e2ee16779fce, var_96e4faf416364416, var_1d501fd0a26de022 );
        
        foreach ( l_player in level.players )
        {
            l_player thread hud_message::showsplash( "zm_quest_item_picked_up", var_1541441b498a1355, player );
        }
    }
}

// Namespace zm_quest
// Params 4, eflags: 0x4
// Checksum 0x8bcecc6f, Offset: 0x11b7e
// Size: 0x8c
function private function_58a56454a0055b02( quest_idx, phase_idx, item_idx, stage_idx )
{
    bitwidth = 4;
    bitshift = 4;
    bitmask = ( 1 << bitwidth ) - 1;
    result = 0;
    result = ( result << bitshift ) + ( quest_idx & bitmask );
    result = ( result << bitshift ) + ( phase_idx & bitmask );
    result = ( result << bitshift ) + ( item_idx & bitmask );
    result = ( result << bitshift ) + ( stage_idx & bitmask );
    return result;
}

// Namespace zm_quest
// Params 1
// Checksum 0x10a685f1, Offset: 0x11c13
// Size: 0x109
function function_c3c490f409120802( params )
{
    if ( isfunction( level.var_fbdc588490ca877d ) )
    {
        level thread [[ level.var_fbdc588490ca877d ]]();
    }
    
    quest = get_quest( getxhash( params[ 0 ] ) );
    var_25f11e450f2971b9 = int( params[ 1 ] ?? 0 ) > 0;
    
    if ( !quest.started )
    {
        iprintlnbold( "The quest [" + params[ 0 ] + "] has not been started yet!" );
        return;
    }
    
    if ( quest.completed )
    {
        iprintlnbold( "The quest [" + params[ 0 ] + "] has already been completed!" );
        return;
    }
    
    i = 0;
    
    while ( i < quest.steps.size - 1 )
    {
        function_e65609834444650c( quest.steps[ i ], 0 );
        i += 1;
    }
    
    if ( var_25f11e450f2971b9 )
    {
        function_e65609834444650c( quest.steps[ quest.steps.size - 1 ], 0 );
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0xb6801a60, Offset: 0x11d24
// Size: 0x1d6
function function_11b75e2232ce3d4( params )
{
    skip_to_step_name = getxhash( params[ 0 ] );
    var_25f11e450f2971b9 = int( params[ 1 ] ?? 0 ) > 0;
    
    if ( params[ 2 ] )
    {
        var_544dc6c47711ac4a = getxhash( params[ 2 ] );
    }
    
    if ( !var_544dc6c47711ac4a )
    {
        foreach ( var_544dc6c47711ac4a, var_ce3e191e00ec67c9 in level.zm_quests )
        {
            if ( !level.zm_quests[ var_544dc6c47711ac4a ].started )
            {
                continue;
            }
            
            if ( level.zm_quests[ var_544dc6c47711ac4a ].completed )
            {
                continue;
            }
            
            if ( !isdefined( level.zm_quests[ var_544dc6c47711ac4a ].steps ) )
            {
                continue;
            }
            
            found_quest_name = function_5cfd067cd06d4e3a( var_544dc6c47711ac4a, level.zm_quests[ var_544dc6c47711ac4a ], skip_to_step_name );
            
            if ( found_quest_name )
            {
                break;
            }
        }
    }
    else
    {
        found_quest_name = var_544dc6c47711ac4a;
    }
    
    if ( !isdefined( found_quest_name ) )
    {
        return;
    }
    
    quest = level.zm_quests[ found_quest_name ];
    
    if ( !quest.started )
    {
        iprintlnbold( "The quest [" + ( params[ 2 ] ?? params[ 0 ] ) + "] has not been started yet!" );
        return;
    }
    
    if ( quest.completed )
    {
        iprintlnbold( "The quest [" + ( params[ 2 ] ?? params[ 0 ] ) + "] has already been completed!" );
        return;
    }
    
    target_quest_step = get_quest_step( getxhash( found_quest_name ), skip_to_step_name );
    function_17814e7b1d03d00f( target_quest_step, var_25f11e450f2971b9 );
}

// Namespace zm_quest
// Params 3, eflags: 0x4
// Checksum 0xa4aad80a, Offset: 0x11f02
// Size: 0xd1
function private function_5cfd067cd06d4e3a( var_544dc6c47711ac4a, step, skip_to_step_name )
{
    if ( step.ref == skip_to_step_name )
    {
        return var_544dc6c47711ac4a;
    }
    
    if ( step.steps.size > 0 )
    {
        foreach ( var_ca114aa12dee1e8e in step.steps )
        {
            found_quest_name = function_5cfd067cd06d4e3a( var_544dc6c47711ac4a, var_ca114aa12dee1e8e, skip_to_step_name );
            
            if ( found_quest_name )
            {
                return found_quest_name;
            }
        }
    }
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0xe2d0e36d, Offset: 0x11fdb
// Size: 0xf5
function private function_17814e7b1d03d00f( target_quest_step, var_25f11e450f2971b9 = 0 )
{
    for ( current_quest_step = target_quest_step; isdefined( current_quest_step.var_d502348c16c8d691 ) ; current_quest_step = current_quest_step.var_d502348c16c8d691 )
    {
        if ( current_quest_step.var_d502348c16c8d691.linear_substeps )
        {
            i = 0;
            
            while ( i < current_quest_step.index )
            {
                function_e65609834444650c( current_quest_step.var_d502348c16c8d691.steps[ i ], 0 );
                i += 1;
            }
        }
    }
    
    i = 0;
    
    while ( i < current_quest_step.index )
    {
        function_e65609834444650c( target_quest_step.quest.steps[ i ], 0 );
        i += 1;
    }
    
    if ( var_25f11e450f2971b9 )
    {
        function_e65609834444650c( target_quest_step, 0 );
    }
}

// Namespace zm_quest
// Params 1
// Checksum 0x20edea30, Offset: 0x120d8
// Size: 0x32
function function_e38b6d374e95fda7( params )
{
    if ( !isdefined( level.directed_mode ) )
    {
        level.directed_mode = spawnstruct();
    }
    
    level utility::flag_set( "debug_enable_story_mode" );
}

// Namespace zm_quest
// Params 1
// Checksum 0x9714c430, Offset: 0x12112
// Size: 0x10c, Type: bool
function function_e4eb2d1c1bd8fc4e( params )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !params.var_27fce690e19877a5 )
    {
        self setscriptablepartstate( "sndCrafting", "crafting", 0 );
    }
    
    function_eb3a5a6c3f4f3ba6( params );
    zm_interaction::function_307c21197e0798d4( params.hud_description );
    result = zm_interaction::function_df340931f1a0fe6e( params.hold_time, params.var_b35caf93a1ae502d, params.radius, params.save_progress, params.saved_use_object, params.var_f0d87f75743a9881 );
    
    if ( isdefined( self.var_a0de55e36be21b7a ) )
    {
        zm_interaction::function_7c7ed762cd4d0333();
    }
    
    if ( !params.var_5ac1788a1dff4c92 )
    {
        if ( result )
        {
            self setscriptablepartstate( "sndCrafting", "success", 0 );
        }
        else
        {
            self setscriptablepartstate( "sndCrafting", "fail", 0 );
        }
    }
    
    function_b94186b3fb991490( params );
    return istrue( result );
}

// Namespace zm_quest
// Params 1
// Checksum 0xc030fc3, Offset: 0x12227
// Size: 0x72
function function_eb3a5a6c3f4f3ba6( params )
{
    assert( isdefined( params.craft_reason ) );
    assert( !self.is_crafting );
    setup_player_crafting( params.craft_reason, params.allow_movement );
    inventory_utility::givegunlessweapon();
    thread utility::function_72b6372d2d8c997( params.gesture ?? "cer_zm_vm_ges_knucklecrack", 1 );
}

// Namespace zm_quest
// Params 1
// Checksum 0x3d559ae, Offset: 0x122a1
// Size: 0x63
function function_b94186b3fb991490( params )
{
    assert( isdefined( params.craft_reason ) );
    assert( self.is_crafting );
    release_player_crafting( params.craft_reason );
    inventory_utility::takegunlessweapon();
    self takeweapon( params.gesture ?? "cer_zm_vm_ges_knucklecrack" );
}

// Namespace zm_quest
// Params 2, eflags: 0x4
// Checksum 0xb39a29d2, Offset: 0x1230c
// Size: 0x76
function private setup_player_crafting( reason, allow_movement )
{
    self.is_crafting = 1;
    val::set( reason, "allow_movement", istrue( allow_movement ) );
    val::set( reason, "killstreaks", 0 );
    val::set( reason, "melee", 0 );
    val::set( reason, "armor", 0 );
    val::set( reason, "usability", 0 );
    disable_specific_player_bgb( 1 );
}

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0xc5866aa4, Offset: 0x1238a
// Size: 0x27
function private release_player_crafting( reason )
{
    self.is_crafting = 0;
    val::reset_all( reason );
    disable_specific_player_bgb( 0 );
}

// Namespace zm_quest
// Params 0
// Checksum 0xc2c6a765, Offset: 0x123b9
// Size: 0x125
function cleanup_deployed_killstreaks()
{
    foreach ( dawg in level.dawgs )
    {
        dawg dodamage( dawg.health, dawg.origin, undefined, undefined, "MOD_CRUSH" );
    }
    
    var_294f90bddc79e02d = getentarray( "veh_remote_turret_zm", "targetname" );
    
    foreach ( turret in var_294f90bddc79e02d )
    {
        turret notify( #"kill_turret", 0, 0, 0 );
    }
}

// Namespace zm_quest
// Params 4
// Checksum 0xf2c40428, Offset: 0x124e6
// Size: 0x154
function function_3d98cd2b7249fcbd( var_dc58879cfee40e71, var_ed466fad37317edc, str_caption, b_fill = 1 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"blackhole_teleporting" );
    self endon( #"hash_319c8abafd318fa" );
    
    if ( self.var_a0de55e36be21b7a && self.var_a0de55e36be21b7a Interactionholding::is_open( self ) )
    {
        assertmsg( "<dev string:x762>" );
        return;
    }
    
    thread function_faeaba1097c36100();
    utility::ent_flag_set( "quicktime_hud_active" );
    thread zm_interaction::function_307c21197e0798d4( var_ed466fad37317edc, str_caption );
    start_time = gettime();
    
    while ( true )
    {
        if ( utility::ent_flag( "pause_quicktime_progress_bar" ) )
        {
            waitframe();
            continue;
        }
        
        time_elapsed = utility::function_6f5d2e1f1ff70482( gettime() - start_time );
        
        if ( time_elapsed >= var_dc58879cfee40e71 )
        {
            zm_interaction::function_7c7ed762cd4d0333();
            self notify( #"hash_ac35a31662bb63f" );
            utility::ent_flag_clear( "quicktime_hud_active" );
            self notify( #"hash_319c8abafd318fa" );
            return;
        }
        
        if ( b_fill )
        {
            progress = time_elapsed / var_dc58879cfee40e71;
        }
        else
        {
            progress = ( var_dc58879cfee40e71 - time_elapsed ) / var_dc58879cfee40e71;
        }
        
        zm_interaction::function_45e51da251cd5e3a( progress );
        waitframe();
    }
}

// Namespace zm_quest
// Params 0
// Checksum 0xb5aab253, Offset: 0x12642
// Size: 0xe
function function_2adcdbfad350618()
{
    utility::ent_flag_set( "pause_quicktime_progress_bar" );
}

// Namespace zm_quest
// Params 0
// Checksum 0x7cc42b75, Offset: 0x12658
// Size: 0xe
function function_22b6ab0c275ce00b()
{
    utility::ent_flag_clear( "pause_quicktime_progress_bar" );
}

// Namespace zm_quest
// Params 0
// Checksum 0x57e57ffd, Offset: 0x1266e
// Size: 0x2d
function function_6adb74d5d90e96f6()
{
    self notify( #"hash_319c8abafd318fa" );
    utility::ent_flag_clear( "pause_quicktime_progress_bar" );
    utility::ent_flag_clear( "quicktime_hud_active" );
    zm_interaction::function_7c7ed762cd4d0333();
}

// Namespace zm_quest
// Params 0, eflags: 0xc
// Checksum 0xaf79e02, Offset: 0x126a3
// Size: 0x48
function private function_faeaba1097c36100()
{
    self notify( #"hash_8488fed07108f8a0" );
    self endon( #"hash_8488fed07108f8a0" );
    self endon( #"hash_319c8abafd318fa" );
    level waittill( #"start_game_ended" );
    
    if ( utility::ent_flag( "quicktime_hud_active" ) )
    {
        thread function_6adb74d5d90e96f6();
    }
}

/#

    // Namespace zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0xd80c7c36, Offset: 0x126f3
    // Size: 0x132, Type: dev
    function private function_6b4dc9f1f5413551( quest )
    {
        var_c97c1fa76d5f85fe = "<dev string:x7ce>" + getxhashsourcename( quest.ref ) + "<dev string:x7d8>";
        devgui::function_9082edeb5db93280( var_c97c1fa76d5f85fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7da>", "<dev string:x7e6>" + getxhashsourcename( quest.ref ), &devgui_start_quest );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7f3>", "<dev string:x801>" + getxhashsourcename( quest.ref ), &devgui_restart_quest );
        devgui::function_cd4e263c1f3018ae( "<dev string:x810>", "<dev string:x81b>" + getxhashsourcename( quest.ref ), &devgui_quit_quest );
        devgui::function_77df7fe7dd273e10();
        
        foreach ( quest_step in quest.steps )
        {
            function_6f2fe2e00a070608( quest_step, var_c97c1fa76d5f85fe );
        }
    }

    // Namespace zm_quest
    // Params 2, eflags: 0x4
    // Checksum 0xeb65719c, Offset: 0x1282d
    // Size: 0x16a, Type: dev
    function private function_6f2fe2e00a070608( quest_step, parent_devgui_path )
    {
        var_c97c1fa76d5f85fe = parent_devgui_path + "<dev string:x827>" + quest_step.index + "<dev string:x829>" + getxhashsourcename( quest_step.ref ) + "<dev string:x7d8>";
        devgui::function_9082edeb5db93280( var_c97c1fa76d5f85fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:x82c>", "<dev string:x839>" + getxhashsourcename( quest_step.quest.ref ) + "<dev string:x842>" + getxhashsourcename( quest_step.ref ), &function_a92a7831b6b55322 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x844>", "<dev string:x852>" + getxhashsourcename( quest_step.quest.ref ) + "<dev string:x842>" + getxhashsourcename( quest_step.ref ), &function_f4862fe4218197b2 );
        devgui::function_77df7fe7dd273e10();
        
        foreach ( var_7542f759b12f5dfb in quest_step.steps )
        {
            function_6f2fe2e00a070608( var_7542f759b12f5dfb, var_c97c1fa76d5f85fe );
        }
    }

    // Namespace zm_quest
    // Params 1
    // Checksum 0x1eb7ae74, Offset: 0x1299f
    // Size: 0x42, Type: dev
    function function_bc99f123a684344f( quest_ref )
    {
        target_quest = get_quest( quest_ref );
        
        if ( isdefined( target_quest ) )
        {
            devgui::function_9082edeb5db93280( "<dev string:x7ce>" + getxhashsourcename( quest_ref ) + "<dev string:x85c>" );
        }
    }

    // Namespace zm_quest
    // Params 0
    // Checksum 0xe371f7da, Offset: 0x129e9
    // Size: 0xc, Type: dev
    function function_c1400a2f4670c23f()
    {
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_quest
    // Params 2
    // Checksum 0xe1a9c950, Offset: 0x129fd
    // Size: 0xe9, Type: dev
    function function_1b5b11caffa04d9a( quest_ref, step_ref )
    {
        target_quest_step = get_quest_step( quest_ref, step_ref );
        
        if ( isdefined( target_quest_step ) )
        {
            current_quest_step = target_quest_step;
            
            for ( var_c97c1fa76d5f85fe = "<dev string:x827>" + current_quest_step.index + "<dev string:x829>" + getxhashsourcename( current_quest_step.ref ) + "<dev string:x7d8>"; isdefined( current_quest_step.var_d502348c16c8d691 ) ; var_c97c1fa76d5f85fe = "<dev string:x827>" + current_quest_step.index + "<dev string:x829>" + getxhashsourcename( current_quest_step.ref ) + "<dev string:x7d8>" + var_c97c1fa76d5f85fe )
            {
                current_quest_step = current_quest_step.var_d502348c16c8d691;
            }
            
            devgui::function_9082edeb5db93280( "<dev string:x7ce>" + getxhashsourcename( quest_ref ) + "<dev string:x7d8>" + var_c97c1fa76d5f85fe + "<dev string:x866>" );
        }
    }

    // Namespace zm_quest
    // Params 0
    // Checksum 0x18a18140, Offset: 0x12aee
    // Size: 0xc, Type: dev
    function function_394bdba74beda0aa()
    {
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_quest
    // Params 1
    // Checksum 0x9a792d9b, Offset: 0x12b02
    // Size: 0x1d, Type: dev
    function devgui_start_quest( params )
    {
        thread start_quest( getxhash( params[ 0 ] ) );
    }

    // Namespace zm_quest
    // Params 1
    // Checksum 0x41813ea4, Offset: 0x12b27
    // Size: 0x1d, Type: dev
    function devgui_restart_quest( params )
    {
        thread restart_quest( getxhash( params[ 0 ] ) );
    }

    // Namespace zm_quest
    // Params 1
    // Checksum 0x5c008dc9, Offset: 0x12b4c
    // Size: 0x1d, Type: dev
    function devgui_quit_quest( params )
    {
        thread quit_quest( getxhash( params[ 0 ] ) );
    }

    // Namespace zm_quest
    // Params 1
    // Checksum 0x49e4e585, Offset: 0x12b71
    // Size: 0xd4, Type: dev
    function function_a92a7831b6b55322( params )
    {
        quest_ref = params[ 0 ];
        step_ref = params[ 1 ];
        target_quest_step = get_quest_step( getxhash( quest_ref ), getxhash( step_ref ) );
        
        if ( !isdefined( target_quest_step ) )
        {
            return;
        }
        
        if ( !target_quest_step.quest.started )
        {
            iprintlnbold( "<dev string:x86f>" + quest_ref + "<dev string:x87b>" );
            return;
        }
        
        if ( target_quest_step.quest.completed )
        {
            iprintlnbold( "<dev string:x86f>" + quest_ref + "<dev string:x897>" );
            return;
        }
        
        if ( target_quest_step.completed )
        {
            iprintlnbold( "<dev string:x8b5>" + step_ref + "<dev string:x897>" );
            return;
        }
        
        function_17814e7b1d03d00f( target_quest_step );
    }

    // Namespace zm_quest
    // Params 1
    // Checksum 0x30a90ccc, Offset: 0x12c4d
    // Size: 0xde, Type: dev
    function function_f4862fe4218197b2( params )
    {
        quest_ref = params[ 0 ];
        step_ref = params[ 1 ];
        target_quest_step = get_quest_step( getxhash( quest_ref ), getxhash( step_ref ) );
        
        if ( !isdefined( target_quest_step ) )
        {
            return;
        }
        
        if ( !target_quest_step.quest.started )
        {
            iprintlnbold( "<dev string:x86f>" + quest_ref + "<dev string:x87b>" );
            return;
        }
        
        if ( target_quest_step.quest.completed )
        {
            iprintlnbold( "<dev string:x86f>" + quest_ref + "<dev string:x897>" );
            return;
        }
        
        if ( target_quest_step.completed )
        {
            iprintlnbold( "<dev string:x8b5>" + step_ref + "<dev string:x897>" );
            return;
        }
        
        function_a92a7831b6b55322( params );
        function_e65609834444650c( target_quest_step, 0 );
    }

    // Namespace zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0xd4be23a4, Offset: 0x12d33
    // Size: 0x4c, Type: dev
    function private function_b94da42e778631ae( quest_ref )
    {
        devgui::function_9082edeb5db93280( "<dev string:x8c6>" + getxhashsourcename( quest_ref ) + "<dev string:x7d8>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8da>", "<dev string:x8f2>" + getxhashsourcename( quest_ref ), &function_b4fb7852a224c117 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0x6dde16a7, Offset: 0x12d87
    // Size: 0x52, Type: dev
    function private function_b4fb7852a224c117( params )
    {
        visibility = function_86adcc348d04ff29( getxhash( params[ 0 ] ), level.player );
        function_98432f89334662d5( getxhash( params[ 0 ] ), !visibility, level.player );
        function_44fe3dcaa8005357();
    }

    // Namespace zm_quest
    // Params 2, eflags: 0x4
    // Checksum 0x3b6ee6b4, Offset: 0x12de1
    // Size: 0x9c, Type: dev
    function private function_efe1c13dd1edb00e( quest_ref, var_1e562e6847201882 )
    {
        phase_ref = function_dc4d707e25ce44d6( quest_ref, var_1e562e6847201882 );
        var_8df81108461c85a8 = "<dev string:x904>" + var_1e562e6847201882;
        
        if ( isdefined( phase_ref ) )
        {
            var_8df81108461c85a8 = getxhashsourcename( phase_ref );
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x8c6>" + getxhashsourcename( quest_ref ) + "<dev string:x7d8>" + var_8df81108461c85a8 + "<dev string:x7d8>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x90b>", "<dev string:x915>" + getxhashsourcename( quest_ref ) + "<dev string:x842>" + var_1e562e6847201882, &function_3e5012b361ddb2b8 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0xde150a98, Offset: 0x12e85
    // Size: 0x5a, Type: dev
    function private function_3e5012b361ddb2b8( params )
    {
        quest_ref = getxhash( params[ 0 ] );
        var_1e562e6847201882 = int( params[ 1 ] );
        function_414f5738fd71d248( quest_ref, var_1e562e6847201882, level.player );
        function_a57d1f0655542b50( quest_ref, var_1e562e6847201882, level.player );
    }

    // Namespace zm_quest
    // Params 4, eflags: 0x4
    // Checksum 0x116c06f7, Offset: 0x12ee7
    // Size: 0x13a, Type: dev
    function private function_eea02feb5226b324( quest_ref, var_1e562e6847201882, item_ref, stage_count )
    {
        phase_ref = function_dc4d707e25ce44d6( quest_ref, var_1e562e6847201882 );
        var_8df81108461c85a8 = "<dev string:x904>" + var_1e562e6847201882;
        
        if ( isdefined( phase_ref ) )
        {
            var_8df81108461c85a8 = getxhashsourcename( phase_ref );
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x8c6>" + getxhashsourcename( quest_ref ) + "<dev string:x7d8>" + var_8df81108461c85a8 + "<dev string:x7d8>" + getxhashsourcename( item_ref ) + "<dev string:x7d8>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x926>", "<dev string:x93d>" + getxhashsourcename( quest_ref ) + "<dev string:x842>" + var_1e562e6847201882 + "<dev string:x842>" + getxhashsourcename( item_ref ), &function_207a09ecb827c436 );
        
        for ( i = 0; i <= stage_count ; i++ )
        {
            display_text = i == 0 ? "<dev string:x94d>" : "<dev string:x954>" + i;
            devgui::function_cd4e263c1f3018ae( display_text, "<dev string:x95f>" + getxhashsourcename( quest_ref ) + "<dev string:x842>" + var_1e562e6847201882 + "<dev string:x842>" + getxhashsourcename( item_ref ) + "<dev string:x842>" + i, &function_8b5efc61a4c8ef7c );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0xfc2d6fa2, Offset: 0x13029
    // Size: 0x8d, Type: dev
    function private function_207a09ecb827c436( params )
    {
        quest_ref = getxhash( params[ 0 ] );
        var_1e562e6847201882 = int( params[ 1 ] );
        item_ref = getxhash( params[ 2 ] );
        visibility = get_inventory_item_visibility( quest_ref, var_1e562e6847201882, item_ref, level.player );
        function_db2af38a83f7fdc6( quest_ref, var_1e562e6847201882, item_ref, !visibility, level.player );
        function_a57d1f0655542b50( quest_ref, var_1e562e6847201882, level.player );
    }

    // Namespace zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0x32454991, Offset: 0x130be
    // Size: 0x81, Type: dev
    function private function_8b5efc61a4c8ef7c( params )
    {
        quest_ref = getxhash( params[ 0 ] );
        var_1e562e6847201882 = int( params[ 1 ] );
        item_ref = getxhash( params[ 2 ] );
        var_41f8529e24f6fb4b = int( params[ 3 ] );
        function_b5d10e9625f13230( quest_ref, var_1e562e6847201882, item_ref, var_41f8529e24f6fb4b, level.player );
        function_a57d1f0655542b50( quest_ref, var_1e562e6847201882, level.player );
    }

    // Namespace zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0xf1c6166d, Offset: 0x13147
    // Size: 0x9d, Type: dev
    function private function_8591adf86cb2e575( params )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "<dev string:x970>", 1 );
            player setclientomnvar( "<dev string:x98b>", gettime() );
        }
    }

    // Namespace zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0x503ebc9a, Offset: 0x131ec
    // Size: 0x9d, Type: dev
    function private function_f1ea915fbc8355ce( params )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "<dev string:x970>", 2 );
            player setclientomnvar( "<dev string:x98b>", gettime() );
        }
    }

    // Namespace zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0x56902a94, Offset: 0x13291
    // Size: 0x9d, Type: dev
    function private function_88da86e42e9af5ea( params )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "<dev string:x970>", 3 );
            player setclientomnvar( "<dev string:x98b>", gettime() );
        }
    }

    // Namespace zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0x434f727e, Offset: 0x13336
    // Size: 0x9d, Type: dev
    function private function_fd9cfe1d0888120c( params )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "<dev string:x970>", 4 );
            player setclientomnvar( "<dev string:x98b>", gettime() );
        }
    }

    // Namespace zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0x4046605d, Offset: 0x133db
    // Size: 0x9c, Type: dev
    function private function_71b25956f0df424f( params )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "<dev string:x970>", 0 );
            player setclientomnvar( "<dev string:x98b>", gettime() );
        }
    }

    // Namespace zm_quest
    // Params 0, eflags: 0x4
    // Checksum 0xc1727fd8, Offset: 0x1347f
    // Size: 0x86, Type: dev
    function private function_509752a4eed3d65b()
    {
        devgui::function_9082edeb5db93280( "<dev string:x9ad>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9c3>", "<dev string:x9cd>", &function_8591adf86cb2e575 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9e3>", "<dev string:x9ee>", &function_f1ea915fbc8355ce );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa05>", "<dev string:xa12>", &function_fd9cfe1d0888120c );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa2b>", "<dev string:xa36>", &function_88da86e42e9af5ea );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa4d>", "<dev string:xa58>", &function_71b25956f0df424f );
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace zm_quest
// Params 1, eflags: 0x4
// Checksum 0x460d644a, Offset: 0x1350d
// Size: 0x1f, Type: bool
function private function_6a1f8c4f4bf33bf1( quest_ref )
{
    return istrue( get_quest( quest_ref ).var_f932d7ebb6cec30e );
}

