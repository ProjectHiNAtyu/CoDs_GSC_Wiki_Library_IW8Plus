// script_48f9d5bebaf0b897  (hash_48f9d5bebaf0b897.gscc) (size: 6494 Bytes / 0x195e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7275b6f0 (1920317168)
// size ...... 6494 (0x195e)
// includes .. 14  (offset: 0x17b2)
// strings ... 13  (offset: 0x1822)
// dev strs .. 6   (offset: 0x1912)
// exports ... 15  (offset: 0xe6e)
// cseg ...... 0x182 + 0xcec (0xe6e)
// imports ... 60  (offset: 0x10c6)
// animtree1 . 0   (offset: 0x195e)
// animtree2 . 0   (offset: 0x195e)
#using script_74e6f1aa7cbd0a56;
#using script_ae3d6d8e8ba78b9;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;
#using scripts\mp\interaction;

#namespace namespace_485eba3dc5c06acb;

// Namespace namespace_485eba3dc5c06acb
// Params 0, eflags: 0x5
// Checksum 0xba4a94fc, Offset: 0x1a0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8d67705c90025312", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_485eba3dc5c06acb
// Params 0, eflags: 0x4
// Checksum 0xa494052a, Offset: 0x1c9
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BONGO_OPERATOR_MISSION_5", &activity_type_init );
}

// Namespace namespace_485eba3dc5c06acb
// Params 0
// Checksum 0x4831c748, Offset: 0x1e4
// Size: 0x11b
function init()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    deflist = activity_definition_utils::function_326a5e04c9b438f5( "BONGO_OPERATOR_MISSION_5" );
    
    if ( deflist.size == 0 )
    {
        return;
    }
    
    variantlist = [];
    
    foreach ( variant, def in deflist )
    {
        variantlist[ variantlist.size ] = variant;
    }
    
    foreach ( variant in variantlist )
    {
        activity_instance_common::function_9b387cb1af0d5b4b( variant );
    }
}

// Namespace namespace_485eba3dc5c06acb
// Params 0
// Checksum 0xe2e2e7e4, Offset: 0x307
// Size: 0x180
function activity_type_init()
{
    if ( getdvarint( @"hash_ce80d6e80552f6c3", 0 ) || game_utility_mp::privatematch() )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BONGO_OPERATOR_MISSION_5", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BONGO_OPERATOR_MISSION_5", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BONGO_OPERATOR_MISSION_5", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BONGO_OPERATOR_MISSION_5", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_9fd46b47e0d8481d( 7, &function_9af87475d798c56d );
    
    if ( !isdefined( level.activitymanager.operatormissions[ "BONGO_OPERATOR_MISSION_5" ] ) )
    {
        level.activitymanager.operatormissions[ "BONGO_OPERATOR_MISSION_5" ] = {};
    }
    
    if ( !isdefined( level.activitymanager.operatormissions[ "BONGO_OPERATOR_MISSION_5" ].poistructs ) )
    {
        level.activitymanager.operatormissions[ "BONGO_OPERATOR_MISSION_5" ].poistructs = [];
    }
    
    level.activitymanager.operatormissions[ "BONGO_OPERATOR_MISSION_5" ].poistructs[ "OPERATOR_MISSION_5_POI1" ] = utility::getstruct( "OPERATOR_MISSION_5_POI1", "script_noteworthy" );
    level.activitymanager.operatormissions[ "BONGO_OPERATOR_MISSION_5" ].poistructs[ "OPERATOR_MISSION_5_POI2" ] = utility::getstruct( "OPERATOR_MISSION_5_POI2", "script_noteworthy" );
    thread init();
    namespace_d140b0f877922129::function_a6c30643d0d1bdec( "BONGO_OPERATOR_MISSION_5" );
}

// Namespace namespace_485eba3dc5c06acb
// Params 1, eflags: 0x4
// Checksum 0xa77f4650, Offset: 0x48f
// Size: 0x11b
function private function_9af87475d798c56d( relevantparameters )
{
    activity_participation::function_d9a1042dcc00e541( relevantparameters );
    activity_instance = relevantparameters[ 0 ];
    interactscriptables = relevantparameters[ 1 ];
    activity_instance.joinerscriptables = interactscriptables;
    activity_instance thread function_3fcbf5ededf07606();
    
    if ( !( getdvarint( @"hash_8399c43fb235fee2", 0 ) == 1 ) )
    {
        return;
    }
    
    spawnchance = getdvarfloat( @"hash_4a4774a251abd369", 0.5 );
    spawnsuccess = randomfloatrange( 0, 1 ) <= spawnchance;
    
    if ( !spawnsuccess )
    {
        foreach ( interactscriptable in interactscriptables )
        {
            if ( isdefined( interactscriptable ) )
            {
                interactscriptable setscriptablepartstate( "nexus_activity_joiner_phone", "visible_no_icon" );
                interactscriptable function_7653c765b6c7b815();
            }
        }
        
        return;
    }
}

// Namespace namespace_485eba3dc5c06acb
// Params 0, eflags: 0x4
// Checksum 0x806c9c55, Offset: 0x5b2
// Size: 0xe5
function private function_3fcbf5ededf07606()
{
    activity_instance = self;
    activity_instance endon( #"activity_started" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( true )
    {
        interval = getdvarfloat( @"hash_eafdffe4cd1c5633", 9 );
        wait interval;
        
        foreach ( joiner in activity_instance.joinerscriptables )
        {
            if ( isdefined( joiner ) )
            {
                playsoundatpos( joiner.origin, "evt_sat_bo_phone_ring" );
            }
        }
    }
}

// Namespace namespace_485eba3dc5c06acb
// Params 0
// Checksum 0x9ae2f240, Offset: 0x69f
// Size: 0x166
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.master_struct = level.activitymanager.operatormissions[ "BONGO_OPERATOR_MISSION_5" ].poistructs[ activity_instance.varianttag ];
    activity_instance.var_d989f9f26d1a3d86 = getentitylessscriptablearray( activity_instance.master_struct.targetname, "target" );
    
    for ( i = 0; i < activity_instance.var_d989f9f26d1a3d86.size ; i++ )
    {
        scriptable = activity_instance.var_d989f9f26d1a3d86[ i ];
        interaction::register_scriptable_interact( scriptable, &increase_counter );
        scriptable function_7653c765b6c7b815();
        
        foreach ( player in level.players )
        {
            scriptable function_d6a7b7ef13a57f38( player );
        }
    }
    
    namespace_d140b0f877922129::function_f80325596346f8e3( activity_instance );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_485eba3dc5c06acb
// Params 0
// Checksum 0x9eaeef3f, Offset: 0x80d
// Size: 0x26b
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance notify( #"activity_started" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "operatorMissionStarted", "BONGO_OPERATOR_MISSION_5", 1 );
    }
    
    activityjoininteracts = level.activities.var_3a2ba6751c464ab7[ self.id ] ?? [];
    
    foreach ( joiner in activityjoininteracts )
    {
        joiner setscriptablepartstate( "nexus_activity_joiner_phone", "visible_no_icon" );
        joiner function_7653c765b6c7b815();
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

// Namespace namespace_485eba3dc5c06acb
// Params 1
// Checksum 0xd932f190, Offset: 0xa80
// Size: 0x198
function increase_counter( player )
{
    activity_instance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "BONGO_OPERATOR_MISSION_5" );
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

// Namespace namespace_485eba3dc5c06acb
// Params 1
// Checksum 0x84d29f6a, Offset: 0xc20
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

// Namespace namespace_485eba3dc5c06acb
// Params 0
// Checksum 0xa7abea16, Offset: 0xcb4
// Size: 0x25
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_d140b0f877922129::function_7af74d49b1f930e9( activity_instance );
}

/#

    // Namespace namespace_485eba3dc5c06acb
    // Params 0, eflags: 0x4
    // Checksum 0x2abe38a5, Offset: 0xce1
    // Size: 0x45, Type: dev
    function private function_951e1e707f1f2e0a()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x46>", "<dev string:x5a>", &function_5b7d9a27fef07ca9 );
        devgui::add_devgui_func( "<dev string:x75>", "<dev string:x86>", &function_cf13fa7f76045736 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_485eba3dc5c06acb
    // Params 1, eflags: 0x4
    // Checksum 0x1460973d, Offset: 0xd2e
    // Size: 0x11b, Type: dev
    function private function_5b7d9a27fef07ca9( cheatplayers )
    {
        if ( !isdefined( cheatplayers ) )
        {
            cheatplayers = level.players;
        }
        
        incrementedmissions = [];
        
        foreach ( player in cheatplayers )
        {
            activityinstance = player namespace_d140b0f877922129::function_a6777c1e450f38eb( "<dev string:xa6>" );
            
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

    // Namespace namespace_485eba3dc5c06acb
    // Params 1, eflags: 0x4
    // Checksum 0x778d93fd, Offset: 0xe51
    // Size: 0x1d, Type: dev
    function private function_cf13fa7f76045736( cheatplayers )
    {
        namespace_d140b0f877922129::completemission( cheatplayers, "<dev string:xa6>" );
    }

#/
