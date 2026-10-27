// script_4a7771b340b2999c  (hash_4a7771b340b2999c.gscc) (size: 6640 Bytes / 0x19f0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6fe58774 (1877313396)
// size ...... 6640 (0x19f0)
// includes .. 15  (offset: 0x1828)
// strings ... 13  (offset: 0x18a0)
// dev strs .. 8   (offset: 0x1988)
// exports ... 17  (offset: 0xdac)
// cseg ...... 0x1b6 + 0xbf6 (0xdac)
// imports ... 69  (offset: 0x1054)
// animtree1 . 0   (offset: 0x19f0)
// animtree2 . 0   (offset: 0x19f0)
#using script_74e6f1aa7cbd0a56;
#using script_ae3d6d8e8ba78b9;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;

#namespace namespace_485eb53dc5c05fcc;

// Namespace namespace_485eb53dc5c05fcc
// Params 0, eflags: 0x5
// Checksum 0xc4fbd5c5, Offset: 0x1d4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8d67755c90025b91", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_485eb53dc5c05fcc
// Params 0, eflags: 0x4
// Checksum 0xdcab06fc, Offset: 0x1fd
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_BONGO_DEMPSEY_TWO", &activity_type_init );
}

// Namespace namespace_485eb53dc5c05fcc
// Params 0
// Checksum 0x99bb9e09, Offset: 0x218
// Size: 0x259
function init()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    var_17167ff6115b2e7b = level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_TWO" ].dogtagstructs;
    spawncount = getdvarint( @"hash_d388513031ce3f3e", 2 );
    selectedstructs = [];
    
    while ( selectedstructs.size < spawncount && var_17167ff6115b2e7b.size > 0 )
    {
        randomindex = randomint( var_17167ff6115b2e7b.size );
        selectedstructs[ selectedstructs.size ] = var_17167ff6115b2e7b[ randomindex ];
        var_17167ff6115b2e7b[ randomindex ] = undefined;
        
        if ( isint( randomindex ) )
        {
            function_cdc669dbc8ea2101( var_17167ff6115b2e7b );
        }
    }
    
    foreach ( struct in selectedstructs )
    {
        spawn_options = common_item::function_bc5ff2958b71a708( struct.origin );
        scriptable = common_item::function_61c2c0251e742ffd( %"hash_34dce2f35b546dd4", 1, spawn_options );
    }
    
    level.var_d989f9f26d1a3d86 = getentitylessscriptablearray( "OPERATOR_MISSION_8_PAINT_CANS", "script_noteworthy" );
    
    foreach ( scriptable in level.var_d989f9f26d1a3d86 )
    {
        interaction::register_scriptable_interact( scriptable, &increase_counter );
        scriptable function_7653c765b6c7b815();
        
        foreach ( player in level.players )
        {
            scriptable function_d6a7b7ef13a57f38( player );
        }
    }
}

// Namespace namespace_485eb53dc5c05fcc
// Params 1
// Checksum 0x77e6d5e1, Offset: 0x479
// Size: 0x3d
function on_quest_item_used( params )
{
    if ( params.bundle.ref != "saw_consumable_operator_mission_8_dog_tag" )
    {
        return;
    }
    
    namespace_d140b0f877922129::function_6c41fb1074085195( self, "REV_BONGO_DEMPSEY_TWO", "BONGO_OPERATOR_MISSION_8_VARIANT1" );
}

// Namespace namespace_485eb53dc5c05fcc
// Params 0
// Checksum 0x282d1e7b, Offset: 0x4be
// Size: 0x165
function activity_type_init()
{
    if ( getdvarint( @"hash_ce80e1e805530ef4", 0 ) || game_utility_mp::privatematch() )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_TWO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_TWO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_TWO", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_BONGO_DEMPSEY_TWO", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_329b56359dd3548d", "BONGO_OPERATOR_MISSION_8_VARIANT1" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &bongo_player_killed, "REV_BONGO_DEMPSEY_TWO" );
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_TWO" ] = {};
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_TWO" ].dogtagstructs = utility::getstructarray( "OPERATOR_MISSION_8_DOG_TAG_SPAWN", "script_noteworthy" );
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_TWO" ].var_166f98c8f8ce7dfd = %"hash_34dce2f35b546dd4";
    level.activitymanager.operatormissions[ "REV_BONGO_DEMPSEY_TWO" ].var_3e59c5268003950a = [];
    
    /#
        thread function_951e1e707f1f2e0a();
    #/
    
    level callback::add( "quest_item_used", &on_quest_item_used );
    level thread init();
    namespace_d140b0f877922129::function_a6c30643d0d1bdec( "REV_BONGO_DEMPSEY_TWO" );
}

// Namespace namespace_485eb53dc5c05fcc
// Params 0
// Checksum 0xf5bb54ce, Offset: 0x62b
// Size: 0x4c
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_d989f9f26d1a3d86 = getentitylessscriptablearray( "OPERATOR_MISSION_8_PAINT_CANS", "script_noteworthy" );
    namespace_d140b0f877922129::function_f80325596346f8e3( activity_instance );
}

// Namespace namespace_485eb53dc5c05fcc
// Params 0
// Checksum 0x8a57941, Offset: 0x67f
// Size: 0x1b4
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "operatorMissionStarted", "REV_BONGO_DEMPSEY_TWO", 1 );
    }
    
    activity_instance.progresscount = 0;
    activity_instance.trackedscriptables = [];
    
    for ( i = 0; i < activity_instance.var_d989f9f26d1a3d86.size ; i++ )
    {
        activity_instance.trackedscriptables[ activity_instance.trackedscriptables.size ] = activity_instance.var_d989f9f26d1a3d86[ i ];
    }
    
    namespace_d140b0f877922129::function_2d3a0d2ebec9534b( activity_instance, "useable" );
    activityvariantdefinition = activity_instance activity_definition_utils::function_837a0c8626c9b419();
    var_f2d9e7c8174d06a3 = activity_definition_utils::function_d32fa66f2924c90d( activityvariantdefinition );
    
    if ( !isdefined( var_f2d9e7c8174d06a3 ) )
    {
        return;
    }
    
    activityindex = function_43b5ed5a14a56573( #"scriptbundle_uiactivityinfo", var_f2d9e7c8174d06a3 );
    players = activity_instance.playerparticipants;
    activity_player_common::function_674cca638cafcae3( players, activity_instance, "ui_activity_index", activityindex, -1 );
    operator_mission_ui::updateprogress( 0, activity_instance, 10 );
    activity_instance namespace_d140b0f877922129::function_ccbc489c228fd653( activity_instance.var_d989f9f26d1a3d86 );
}

// Namespace namespace_485eb53dc5c05fcc
// Params 1
// Checksum 0x28a9de96, Offset: 0x83b
// Size: 0x198
function increase_counter( player )
{
    activity_instance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "REV_BONGO_DEMPSEY_TWO" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    scriptable = self;
    
    foreach ( playerinactivity in activity_instance.playerparticipants )
    {
        scriptable disablescriptableplayeruse( playerinactivity );
        
        if ( scriptable scriptablemaskallowed() )
        {
            scriptable function_d6a7b7ef13a57f38( playerinactivity );
        }
    }
    
    currentcount = activity_instance.progresscount + 1;
    activity_instance.progresscount = currentcount;
    operator_mission_ui::updateprogress( currentcount, activity_instance, 10 );
    player playsoundtoplayer( "evt_sat_bo_spraycan_pickup", player );
    
    if ( currentcount == 10 )
    {
        foreach ( playerinactivity in activity_instance.playerparticipants )
        {
            activity_instance game_utility::questcircle_hidefromplayer( playerinactivity );
        }
        
        activity_instance_common::endactivity( activity_instance, 1 );
    }
}

// Namespace namespace_485eb53dc5c05fcc
// Params 1
// Checksum 0xedcf8370, Offset: 0x9db
// Size: 0x1f
function bongo_player_killed( params )
{
    namespace_d140b0f877922129::onplayerkilled( self, params.victim );
}

// Namespace namespace_485eb53dc5c05fcc
// Params 1
// Checksum 0x84d2aa6d, Offset: 0xa02
// Size: 0x8c
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_da716dafcf40f8d2( activity_instance );
    activityvariantdefinition = activity_instance activity_definition_utils::function_837a0c8626c9b419();
    var_f2d9e7c8174d06a3 = activity_definition_utils::function_d32fa66f2924c90d( activityvariantdefinition );
    
    if ( !isdefined( var_f2d9e7c8174d06a3 ) )
    {
        return;
    }
    
    players = activity_instance.playerparticipants;
    activity_player_common::function_674cca638cafcae3( players, activity_instance, "ui_activity_index", -1, -1 );
    activity_instance game_utility::questcircle_hidefromall();
}

// Namespace namespace_485eb53dc5c05fcc
// Params 0
// Checksum 0xa7abdf11, Offset: 0xa96
// Size: 0x25
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_7af74d49b1f930e9( activity_instance );
}

/#

    // Namespace namespace_485eb53dc5c05fcc
    // Params 0, eflags: 0x4
    // Checksum 0xe7459a65, Offset: 0xac3
    // Size: 0x63, Type: dev
    function private function_951e1e707f1f2e0a()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x48>", "<dev string:x4e>", &function_cdd89f140d97000b );
        devgui::add_devgui_func( "<dev string:x6d>", "<dev string:x81>", &function_991413b9ad85b124 );
        devgui::add_devgui_func( "<dev string:x9e>", "<dev string:xaf>", &function_3d4283d4519f3673 );
        devgui::function_77df7fe7dd273e10();
        level thread function_60251d3506f7495();
    }

    // Namespace namespace_485eb53dc5c05fcc
    // Params 0, eflags: 0x4
    // Checksum 0x25608cbe, Offset: 0xb2e
    // Size: 0x111, Type: dev
    function private function_60251d3506f7495()
    {
        while ( true )
        {
            waitframe();
            
            if ( !isdefined( level.players ) )
            {
                continue;
            }
            
            cheatplayers = level.players;
            var_6e4cf32910d62e5b = getdvar( @"cheat_player" );
            
            if ( isdefined( var_6e4cf32910d62e5b ) )
            {
                foreach ( player in level.players )
                {
                    if ( player.name == var_6e4cf32910d62e5b )
                    {
                        cheatplayers = [ player ];
                        break;
                    }
                }
            }
            
            var_4eb4fb904b92f39e = getdvarint( @"hash_977d3524f4316b05", 0 );
            
            if ( var_4eb4fb904b92f39e )
            {
                setdvar( @"hash_977d3524f4316b05", 0 );
                function_cdd89f140d97000b( cheatplayers );
            }
        }
    }

    // Namespace namespace_485eb53dc5c05fcc
    // Params 1, eflags: 0x4
    // Checksum 0x217020ea, Offset: 0xc47
    // Size: 0x11b, Type: dev
    function private function_991413b9ad85b124( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        incrementedmissions = [];
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:xd1>" );
            
            if ( !activityinstance )
            {
                continue;
            }
            
            if ( incrementedmissions[ activityinstance.id ] )
            {
                continue;
            }
            
            incrementedmissions[ activityinstance.id ] = 1;
            currentcount = activityinstance.progresscount + 1;
            activityinstance.progresscount = currentcount;
            operator_mission_ui::updateprogress( currentcount, activityinstance, 10 );
            
            if ( currentcount >= 10 )
            {
                activity_instance_common::endactivity( activityinstance, 1 );
            }
        }
    }

    // Namespace namespace_485eb53dc5c05fcc
    // Params 1, eflags: 0x4
    // Checksum 0x836ee6ca, Offset: 0xd6a
    // Size: 0x1d, Type: dev
    function private function_3d4283d4519f3673( cheatplayers )
    {
        namespace_d140b0f877922129::completemission( cheatplayers, "<dev string:xd1>" );
    }

    // Namespace namespace_485eb53dc5c05fcc
    // Params 1, eflags: 0x4
    // Checksum 0xb3a7571a, Offset: 0xd8f
    // Size: 0x1d, Type: dev
    function private function_cdd89f140d97000b( cheatplayers )
    {
        namespace_d140b0f877922129::function_49bfdfbd9ca98114( cheatplayers, "<dev string:xd1>" );
    }

#/
