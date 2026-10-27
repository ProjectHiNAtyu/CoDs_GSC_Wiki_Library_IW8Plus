// script_c445446891e2e86  (hash_0c445446891e2e86.gscc) (size: 14659 Bytes / 0x3943 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad334d2c (2905820460)
// size ...... 14659 (0x3943)
// includes .. 21  (offset: 0x33cb)
// strings ... 79  (offset: 0x3473)
// dev strs .. 2   (offset: 0x392b)
// exports ... 28  (offset: 0x220b)
// cseg ...... 0x85e + 0x19ad (0x220b)
// imports ... 110 (offset: 0x266b)
// animtree1 . 0   (offset: 0x3943)
// animtree2 . 0   (offset: 0x3943)
#using script_1369f66fa8958a74;
#using script_2b130da9c9a8b980;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\hints;
#using scripts\common\puzzles\connection_puzzle;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\objidpoolmanager;

#namespace namespace_5f9a6cbc0f6e9aac;

/#

    // Namespace namespace_5f9a6cbc0f6e9aac
    // Params 0
    // Checksum 0xcb5795f2, Offset: 0x87c
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0, eflags: 0x5
// Checksum 0xd36fc958, Offset: 0x889
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_93f6a4b0f6618ff9", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0, eflags: 0x4
// Checksum 0x180382e0, Offset: 0x8b2
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_FACILITY_MACGUFFIN";
    activity_common::registeractivitytype( "OB_LEO_FACILITY_MACGUFFIN", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_MACGUFFIN", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_MACGUFFIN", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_MACGUFFIN", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_FACILITY_MACGUFFIN" );
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0xc060dab9, Offset: 0x929
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance facility_macguffin_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0x4ec172c9, Offset: 0x98e
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance thread facility_macguffin_main();
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0x56600e0d, Offset: 0x9d3
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 1
// Checksum 0xc1276e67, Offset: 0x9f7
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

/#

    // Namespace namespace_5f9a6cbc0f6e9aac
    // Params 0
    // Checksum 0x8ced31e2, Offset: 0xab3
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 1
// Checksum 0xef22cc24, Offset: 0xac0
// Size: 0x19
function player_setup( player )
{
    activity_instance = self;
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0xb4579c49, Offset: 0xae1
// Size: 0x98
function facility_macguffin_start()
{
    thread mp_sat_ob_leo_util::function_96b32ff9e4b0fc4c();
    thread mp_sat_ob_leo_util::function_d2eaefb295692571();
    thread namespace_fc92da645acfbbdc::function_1b86168fadcfb49d();
    mp_sat_ob_leo_util::unlock_door( "central_to_lower_atrium_door" );
    mp_sat_ob_leo_util::unlock_door( "central_to_junction_door" );
    mp_sat_ob_leo_util::unlock_door( "junction_to_central_door" );
    mp_sat_ob_leo_util::turn_off_force_field( "presentation_ff", "targetname", 1 );
    mp_sat_ob_leo_util::turn_on_force_field( "quantum_security_ff" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "facility_macguffin_door_interact", undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    thread leo_audio::snd_leo_quantum_computer_loop();
    thread leo_audio::function_e0e6a157fbbbfcea();
    namespace_42f25eb087152c68::macguffin_cinematic();
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0xd6d607e9, Offset: 0xb81
// Size: 0x13a
function facility_macguffin_main()
{
    a_spawn_points = utility::getstructarray( "facility_macguffin_teleport" );
    ob_story_mission_utils::set_revive_spawns( a_spawn_points );
    connection_puzzle_init();
    level thread function_9bc4dd40e9e4f95d();
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_facility_macguffin_weapon", "facility_to_jungle_complete", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_facility_macguffin_equipment", "facility_to_jungle_complete", 1 );
    level.var_b7d4bcabaacc1f47 = 2;
    level thread mp_sat_ob_leo_vo::facility_macguffin_vo();
    thread facility_macguffin_objectives();
    thread qc_bots();
    
    foreach ( player in level.players )
    {
        player thread jailbreak_hint();
    }
    
    level utility::flag_wait( "button_puzzle_complete" );
    thread leo_audio::function_52eae48a78348120();
    level utility::flag_set( "facility_macguffin_complete" );
    ob_story_mission_utils::set_revive_spawns( undefined );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0xda0b4ddd, Offset: 0xcc3
// Size: 0xba
function function_9bc4dd40e9e4f95d()
{
    tutorial_trigger = getent( "trig_jailbreak_tutorial", "targetname" );
    
    if ( ob::nightmare() )
    {
        return;
    }
    
    var_816926b4b2d4b31d = [];
    
    while ( true )
    {
        tutorial_trigger waittill( #"trigger", var_b075bf5fecbc413 );
        
        if ( var_816926b4b2d4b31d[ var_b075bf5fecbc413 getentitynumber() ] || isautopilot( var_b075bf5fecbc413 ) )
        {
            continue;
        }
        
        var_816926b4b2d4b31d[ var_b075bf5fecbc413 getentitynumber() ] = 1;
        var_b075bf5fecbc413 utility::callsharedfunc( #"hint", #"add_wait", "jailbreak_hint", undefined, undefined, "hint_close_anim_complete", undefined, undefined, 0, [ "HintDisplay", "DialogueSpeaker", "JailBreak" ] );
    }
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0xbbf8b5a3, Offset: 0xd85
// Size: 0x360
function facility_macguffin_objectives()
{
    level.macguffin_activity = self;
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( %"hash_49801ae1739ded3c" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "quantum_hatch_struct", undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    interact_struct = utility::getstruct( "quantum_hatch_struct", "script_noteworthy" );
    interact = interaction::register_interact( interact_struct.origin, 64, &function_8025f9b7dcc10133, &"sat_ob_story_missions/leo_interact_take", undefined, undefined, undefined, "HINT_BUTTON" );
    interact.activity_instance = self;
    level utility::flag_wait( "facility_macguffin_core_tried" );
    ob_story_mission_utils::objective_marker_clear( self.var_8029d4363972e15 );
    level.gate_buttons_pressed = 0;
    self.var_1019f53cb44ccf2d = utility::getstructarray( "facility_macguffin_console_interact", "script_noteworthy" );
    flag_array = [];
    count = 0;
    
    foreach ( struct in self.var_1019f53cb44ccf2d )
    {
        struct.var_8029d4363972e15 = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_storymissionmain", 0, 1 );
        objidpoolmanager::update_objective_position( struct.var_8029d4363972e15, struct.origin + ( 0, 0, 16 ) );
        struct thread function_a35e3aa3a4870fc0();
        struct.flag = "flag_" + struct.script_noteworthy + count;
        flag_array[ flag_array.size ] = struct.flag;
        struct.interact = interaction::register_interact( struct.origin, 64, &on_facility_macguffin_console_interact, &"sat_ob_story_missions/leo_interact_console", undefined, undefined, undefined, "HINT_BUTTON" );
        struct.interact.activity_instance = self;
        struct.interact.var_490060d47d9e122a = struct.targetname;
        
        if ( struct.interact.var_490060d47d9e122a == "facility_macguffin_console_interact_2" )
        {
            struct.interact thread ob_story_mission_utils::function_e89ed2a08ce38bbf( struct.interact.var_490060d47d9e122a, "scripted_widget_connection_puzzle_3side_4player_sat_2" );
        }
        else
        {
            struct.interact thread ob_story_mission_utils::function_e89ed2a08ce38bbf( struct.interact.var_490060d47d9e122a, "scripted_widget_connection_puzzle_3side_4player_sat_default" );
        }
        
        count++;
    }
    
    while ( true )
    {
        ret = utility::flag_wait_any_array_return( flag_array );
        
        if ( isdefined( ret ) )
        {
            flag_array = arrayremove( flag_array, ret );
            i = int( removesubstr( ret, "flag_facility_macguffin_console_interact" ) );
            var_8029d4363972e15 = self.var_1019f53cb44ccf2d[ i ].var_8029d4363972e15;
            
            if ( flag_array.size == 0 )
            {
                break;
            }
        }
        
        waitframe();
    }
    
    level utility::flag_set( "facility_macguffin_item_ready" );
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0x5c541eb8, Offset: 0x10ed
// Size: 0xc0
function function_9f6591c65bcd38a()
{
    var_55fb688e1d94c6a7 = utility::getstruct( "facility_macguffin_console_interact_1" );
    struct_2 = utility::getstruct( "facility_macguffin_console_interact_2" );
    var_55fb688e1d94c6a7.var_8029d4363972e15 = level.macguffin_activity namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_storymissionmain", 0, 1 );
    objidpoolmanager::update_objective_position( var_55fb688e1d94c6a7.var_8029d4363972e15, var_55fb688e1d94c6a7.origin );
    struct_2.var_8029d4363972e15 = level.macguffin_activity namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_storymissionmain", 0, 1 );
    objidpoolmanager::update_objective_position( struct_2.var_8029d4363972e15, struct_2.origin );
    var_55fb688e1d94c6a7 thread function_a35e3aa3a4870fc0();
    struct_2 thread function_a35e3aa3a4870fc0();
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0x6bce3150, Offset: 0x11b5
// Size: 0x28
function function_a35e3aa3a4870fc0()
{
    level waittill( self.targetname );
    level.macguffin_activity namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_8029d4363972e15 );
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 1
// Checksum 0xc0d5124c, Offset: 0x11e5
// Size: 0x32
function function_8025f9b7dcc10133( player )
{
    self makeunusable();
    level utility::flag_set( "facility_macguffin_core_tried" );
    thread leo_audio::snd_leo_quantum_computer_access_denied();
    waypoint_objective_handler::waypoint_objective_handler_cancel( "quantum_hatch_struct" );
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 1
// Checksum 0x87f1fbe4, Offset: 0x121f
// Size: 0x725
function on_facility_macguffin_console_interact( player )
{
    if ( !val::get( "allow_connection_puzzle" ) )
    {
        return;
    }
    
    self makeunusable();
    connection_puzzle_asset = hashcat( %"scriptedwidget:", "scripted_widget_connection_puzzle_3side_4player_sat_default" );
    
    if ( self.var_490060d47d9e122a == "facility_macguffin_console_interact_2" )
    {
        connection_puzzle_asset = hashcat( %"scriptedwidget:", "scripted_widget_connection_puzzle_3side_4player_sat_2" );
    }
    
    player thread mp_sat_ob_libra_util::start_interact_scene( self.var_490060d47d9e122a + "_scene" );
    
    if ( player connection_puzzle::open( connection_puzzle_asset, self.var_490060d47d9e122a ) )
    {
        if ( self.var_490060d47d9e122a == "facility_macguffin_console_interact_2" )
        {
            consoles = getscriptablearray( "macguffin_console_2", "targetname" );
            
            foreach ( var_190f59357d8260f7 in consoles )
            {
                var_190f59357d8260f7 setscriptablepartstate( #"base", #"hash_cacbb81f762001c3" );
            }
        }
        else
        {
            consoles = getscriptablearray( "macguffin_console_1", "targetname" );
            
            foreach ( var_190f59357d8260f7 in consoles )
            {
                var_190f59357d8260f7 setscriptablepartstate( #"base", #"hash_cacbbd1f76200a42" );
            }
        }
        
        level utility::flag_set( "flag_quantum_one_console_interacted" );
        
        foreach ( spectator in level.players )
        {
            if ( spectator != player )
            {
                spectator thread connection_puzzle::open( connection_puzzle_asset, self.var_490060d47d9e122a, 1 );
            }
        }
        
        finished = player utility::waittill_any_return( "ConnectionPuzzleClosed", "ConnectionPuzzleCompleted", "death_or_disconnect" );
        
        if ( isplayer( player ) )
        {
            player mp_sat_ob_libra_util::function_d68eec31414afe2e( self.var_490060d47d9e122a + "_scene" );
            player connection_puzzle::close();
        }
        
        foreach ( p in level.players )
        {
            if ( p != player )
            {
                p connection_puzzle::close_spectator( connection_puzzle_asset, self.var_490060d47d9e122a );
            }
        }
        
        if ( finished == "ConnectionPuzzleCompleted" || connection_puzzle::is_instance_complete( connection_puzzle_asset, self.var_490060d47d9e122a ) )
        {
            level notify( self.var_490060d47d9e122a );
            level.gate_buttons_pressed++;
            
            foreach ( struct in self.activity_instance.var_1019f53cb44ccf2d )
            {
                if ( struct.interact == self )
                {
                    level utility::flag_set( struct.flag );
                }
            }
            
            if ( !level utility::flag( "start_button_timer" ) )
            {
                level utility::flag_set( "start_button_timer" );
            }
            
            /#
                iprintlnbold( level.gate_buttons_pressed + "<dev string:x24>" );
            #/
            
            level utility::flag_set( "flag_quantum_one_console_overriden" );
            ob_story_mission_utils::remove_connection_puzzle_streaming_volume();
            
            if ( level.gate_buttons_pressed == level.var_b7d4bcabaacc1f47 )
            {
                /#
                    iprintlnbold( "<dev string:x38>" );
                #/
                
                level utility::flag_set( "button_puzzle_complete" );
                
                if ( isdefined( self ) )
                {
                    self delete();
                }
            }
            
            if ( self.var_490060d47d9e122a == "facility_macguffin_console_interact_2" )
            {
                consoles = getscriptablearray( "macguffin_console_2", "targetname" );
                
                foreach ( var_190f59357d8260f7 in consoles )
                {
                    var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_operational" );
                }
            }
            else
            {
                consoles = getscriptablearray( "macguffin_console_1", "targetname" );
                
                foreach ( var_190f59357d8260f7 in consoles )
                {
                    var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_operational" );
                }
            }
        }
        else
        {
            waitframe();
            self makeusable();
            interaction::set_interact_hint_string( &"sat_ob_story_missions/leo_interact_console" );
            
            if ( self.var_490060d47d9e122a == "facility_macguffin_console_interact_2" )
            {
                consoles = getscriptablearray( "macguffin_console_2", "targetname" );
                
                foreach ( var_190f59357d8260f7 in consoles )
                {
                    var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
                }
            }
            else
            {
                consoles = getscriptablearray( "macguffin_console_1", "targetname" );
                
                foreach ( var_190f59357d8260f7 in consoles )
                {
                    var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
                }
            }
        }
        
        return;
    }
    
    waitframe();
    
    if ( isplayer( player ) )
    {
        player mp_sat_ob_libra_util::function_d68eec31414afe2e( self.var_490060d47d9e122a + "_scene" );
    }
    
    self makeusable();
    interaction::set_interact_hint_string( &"sat_ob_story_missions/leo_interact_console" );
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0, eflags: 0x4
// Checksum 0x9a2a9c16, Offset: 0x194c
// Size: 0x195
function private connection_puzzle_init()
{
    consoles = getscriptablearray( "macguffin_console_1", "targetname" );
    
    foreach ( var_190f59357d8260f7 in consoles )
    {
        var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
    }
    
    consoles = getscriptablearray( "macguffin_console_2", "targetname" );
    
    foreach ( var_190f59357d8260f7 in consoles )
    {
        var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
    }
    
    asset = hashcat( %"scriptedwidget:", "scripted_widget_connection_puzzle_3side_4player_sat_default" );
    asset_2 = hashcat( %"scriptedwidget:", "scripted_widget_connection_puzzle_3side_4player_sat_2" );
    thread connection_puzzle::init_from_layout( asset, "leo_qc_1", "facility_macguffin_console_interact_1", undefined, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator" );
    thread connection_puzzle::init_from_layout( asset_2, "leo_qc_2", "facility_macguffin_console_interact_2", undefined, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator_2" );
    thread function_2e122204a2a9f941();
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0, eflags: 0x4
// Checksum 0x21925e4, Offset: 0x1ae9
// Size: 0xac
function private function_2e122204a2a9f941()
{
    level endon( #"death" );
    
    while ( true )
    {
        level waittill( #"ConnectionPuzzleCompleted", data );
        
        foreach ( player in data.players )
        {
            player notify( #"ConnectionPuzzleCompleted" );
        }
    }
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0xd022fb09, Offset: 0x1b9d
// Size: 0x17a
function qc_bots()
{
    level.var_3655f3d1e424e3e1 = [];
    setup_qc_bots( [ "qc_bot_00", "qc_bot_01", "qc_bot_02", "qc_bot_03", "qc_bot_04", "qc_bot_05" ] );
    playersize = level.players.size;
    
    if ( playersize > 2 )
    {
        setup_qc_bots( [ "qc_bot_00_a", "qc_bot_01_a", "qc_bot_02_a", "qc_bot_03_a", "qc_bot_04_a" ] );
    }
    
    thread open_blast_door();
    level utility::flag_wait( "facility_macguffin_core_item_acquired" );
    wait 2;
    function_ad0c2947e3d2c6d2( [ "qc_bot_00", "qc_bot_05" ] );
    thread leo_audio::function_24c0f8ec1f7e2162();
    
    if ( playersize > 2 )
    {
        function_ad0c2947e3d2c6d2( [ "qc_bot_00_a", "qc_bot_04_a" ] );
    }
    
    wait 4;
    function_ad0c2947e3d2c6d2( [ "qc_bot_01", "qc_bot_04" ] );
    thread leo_audio::function_24c0f7ec1f7e1f2f();
    
    if ( playersize > 2 )
    {
        function_ad0c2947e3d2c6d2( [ "qc_bot_01_a", "qc_bot_03_a" ] );
    }
    
    wait 4;
    function_ad0c2947e3d2c6d2( [ "qc_bot_02", "qc_bot_03" ] );
    thread leo_audio::function_24c0f6ec1f7e1cfc();
    
    if ( playersize > 2 )
    {
        function_ad0c2947e3d2c6d2( [ "qc_bot_02_a" ] );
    }
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 1
// Checksum 0xc448defe, Offset: 0x1d1f
// Size: 0xae
function setup_qc_bots( var_f5d61977cb3b9be2 )
{
    foreach ( struct in var_f5d61977cb3b9be2 )
    {
        scene_struct = utility::getstruct( struct, "targetname" );
        scene_struct scene::add_spawn_function( &function_4449ac3ff68fe56c, "Types_Actor" );
        scene_struct thread scene::play( undefined, "idle" );
    }
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 1
// Checksum 0x4cfdc295, Offset: 0x1dd5
// Size: 0x12a
function function_ad0c2947e3d2c6d2( var_f5d61977cb3b9be2 )
{
    foreach ( struct in var_f5d61977cb3b9be2 )
    {
        scene_struct = utility::getstruct( struct, "targetname" );
        bots = scene_struct scene::get_entities();
        
        foreach ( bot in bots )
        {
            bot notify( #"hash_992479d4601226ab" );
        }
        
        scene_struct thread scene::play( undefined, "exit_0" + randomintrange( 1, 5 ) );
    }
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0x1d81ee59, Offset: 0x1f07
// Size: 0xa0
function function_4449ac3ff68fe56c()
{
    level.var_3655f3d1e424e3e1[ level.var_3655f3d1e424e3e1.size ] = self;
    self.team = "team_hundred_ninety";
    self.ignoreall = 1;
    mp_sat_ob_libra_util::function_90c440460dba0ba2( 0 );
    self.var_24954f14e27b448d = 0;
    val::set( "qc_guild_bot_spawn", "ignoreme", 1 );
    self waittill( #"hash_992479d4601226ab" );
    wait 2;
    self.var_24954f14e27b448d = 1;
    self.ignoreall = 0;
    val::reset( "qc_guild_bot_spawn", "ignoreme" );
    self waittill( #"death" );
    function_622400a8495e19b6();
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0x719df0ab, Offset: 0x1faf
// Size: 0x37
function function_622400a8495e19b6()
{
    level.var_3655f3d1e424e3e1 = utility::array_removedead_or_dying( level.var_3655f3d1e424e3e1 );
    
    if ( level.var_3655f3d1e424e3e1.size < 1 )
    {
        level utility::flag_set( "flag_qc_guild_bots_dead" );
    }
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0xf2981ee0, Offset: 0x1fee
// Size: 0x125
function open_blast_door()
{
    level utility::flag_wait( "facility_macguffin_core_interacted_with" );
    wait 11;
    bot_door_l_clip = getent( "sbm_quantum_bot_door_l", "targetname" );
    bot_door_l = getent( "quantum_bot_door_l", "targetname" );
    bot_door_r_clip = getent( "sbm_quantum_bot_door_r", "targetname" );
    bot_door_r = getent( "quantum_bot_door_r", "targetname" );
    bot_door_l_clip connectpaths();
    bot_door_r_clip connectpaths();
    bot_door_l_clip moveto( bot_door_l_clip.origin + ( 208, 0, 0 ), 3, 1, 1 );
    bot_door_l moveto( bot_door_l.origin + ( 208, 0, 0 ), 3, 1, 1 );
    bot_door_r_clip moveto( bot_door_r_clip.origin + ( -208, 0, 0 ), 3, 1, 1 );
    bot_door_r moveto( bot_door_r.origin + ( -208, 0, 0 ), 3, 1, 1 );
    level thread leo_audio::function_9f2ae7bd84918dfd( bot_door_l, bot_door_r );
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0x3c3eae1, Offset: 0x211b
// Size: 0xcd
function jailbreak_hint()
{
    level endon( #"flag_leo_cradle_cinematic_start" );
    
    if ( ob::nightmare() )
    {
        return;
    }
    
    scriptables = getentitylessscriptablearray( "leo_jailbreak", "script_noteworthy" );
    
    if ( isdefined( scriptables ) && scriptables.size > 0 )
    {
        jailbreak_machine = scriptables[ 0 ];
        
        if ( isdefined( jailbreak_machine ) )
        {
            jailbreak_machine.tag_origin = utility::function_1808878d1c511ce8( jailbreak_machine.origin, jailbreak_machine.angles );
            thread hints::function_ccd82ecebe5d387e( jailbreak_machine.tag_origin, "jailbreak_machine_waypoint", undefined, "scripted_widget_anchor_overhead_obstructed_ingame_tutorial", undefined, 0, undefined, undefined, "jbm_used" );
        }
    }
    
    thread jailbreak_hint_cleanup();
    self waittill( #"jbm_used" );
    hints::hint_add_simple( "leo_jailbreak_hint", &"sat_ob_story_missions/leo_jailbreak_hint", 10 );
}

// Namespace namespace_5f9a6cbc0f6e9aac
// Params 0
// Checksum 0x2ef8ec3e, Offset: 0x21f0
// Size: 0x1b
function jailbreak_hint_cleanup()
{
    level utility::flag_wait( "flag_leo_cradle_cinematic_start" );
    self notify( #"jbm_used" );
}

