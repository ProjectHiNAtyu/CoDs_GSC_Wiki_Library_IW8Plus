// script_74e6f1aa7cbd0a56  (hash_74e6f1aa7cbd0a56.gscc) (size: 2347 Bytes / 0x92b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d63ac6a (1029942378)
// size ...... 2347 (0x92b)
// includes .. 4   (offset: 0x8a7)
// strings ... 8   (offset: 0x8c7)
// dev strs .. 0   (offset: 0x92b)
// exports ... 7   (offset: 0x5fb)
// cseg ...... 0x1be + 0x43d (0x5fb)
// imports ... 13  (offset: 0x713)
// animtree1 . 0   (offset: 0x92b)
// animtree2 . 0   (offset: 0x92b)
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\omnvar_utility;
#using scripts\common\utility;

#namespace operator_mission_ui;

// Namespace operator_mission_ui
// Params 4
// Checksum 0xba46ecdb, Offset: 0x1dc
// Size: 0xdc
function updateprogress( currentprogress, activityinstance, maxprogress, optionalparameters )
{
    activity_definition_utils::updateprogress( currentprogress, activityinstance, maxprogress, optionalparameters );
    
    if ( !isdefined( currentprogress ) && !isdefined( maxprogress ) )
    {
        return;
    }
    
    if ( !activity_instance_common::isactivityinstance( activityinstance ) )
    {
        utility::production_map_assert( 0, "updateProgressForPlayers: no valid activity instance specified" );
        return;
    }
    
    if ( !isdefined( optionalparameters ) )
    {
        optionalparameters = {};
    }
    
    optionalparameters.players = activityinstance.playerparticipants;
    
    if ( isdefined( currentprogress ) )
    {
        if ( !isdefined( optionalparameters ) )
        {
            optionalparameters = {};
        }
        
        optionalparameters.var_70ceaa17995f7807 = 0;
        function_1c90859b607a24a2( "ui_operator_mission_progress", currentprogress, activityinstance, optionalparameters );
    }
    
    if ( isdefined( maxprogress ) )
    {
        if ( !isdefined( optionalparameters ) )
        {
            optionalparameters = {};
        }
        
        optionalparameters.var_70ceaa17995f7807 = 0;
        function_1c90859b607a24a2( "ui_operator_mission_progress_max", maxprogress, activityinstance, optionalparameters );
    }
    
    thread function_c88c5f89fc9cc571( activityinstance );
}

// Namespace operator_mission_ui
// Params 3
// Checksum 0xdad3f368, Offset: 0x2c0
// Size: 0xb1
function function_a0a94881bc380bbf( stepindex, activityinstance, optionalparameters )
{
    activity_definition_utils::function_a0a94881bc380bbf( stepindex, activityinstance, optionalparameters );
    
    if ( !isdefined( stepindex ) )
    {
        utility::production_map_assert( 0, "updateStepIndex : stepIndex is invalid!" );
        return;
    }
    
    if ( !activity_instance_common::isactivityinstance( activityinstance ) )
    {
        utility::production_map_assert( 0, "updateStepIndex: no valid activity instance specified" );
        return;
    }
    
    if ( !isdefined( optionalparameters ) )
    {
        optionalparameters = {};
    }
    
    if ( !isdefined( optionalparameters.players ) )
    {
        optionalparameters.players = activityinstance.playerparticipants;
    }
    
    optionalparameters.var_70ceaa17995f7807 = 0;
    function_1c90859b607a24a2( "ui_operator_mission_step_index", stepindex ?? 0, activityinstance, optionalparameters );
    thread function_c88c5f89fc9cc571( activityinstance );
    return 1;
}

// Namespace operator_mission_ui
// Params 2
// Checksum 0xbd8cf976, Offset: 0x37a
// Size: 0x99
function function_f9de8532e304341e( activityinstance, optionalparameters )
{
    activityvariantdefinition = activityinstance activity_definition_utils::function_837a0c8626c9b419();
    var_f2d9e7c8174d06a3 = activity_definition_utils::function_d32fa66f2924c90d( activityvariantdefinition );
    
    if ( !isdefined( var_f2d9e7c8174d06a3 ) )
    {
        return;
    }
    
    activityindex = function_43b5ed5a14a56573( #"scriptbundle_uiactivityinfo", var_f2d9e7c8174d06a3 );
    
    if ( !isdefined( optionalparameters ) )
    {
        optionalparameters = {};
    }
    
    if ( !isdefined( optionalparameters.players ) )
    {
        optionalparameters.players = activityinstance.playerparticipants;
    }
    
    function_1c90859b607a24a2( "ui_operator_mission_index", activityindex, activityinstance, optionalparameters );
}

// Namespace operator_mission_ui
// Params 2
// Checksum 0xd8180067, Offset: 0x41b
// Size: 0x61
function function_3b2c7f51f615befd( activityinstance, optionalparameters = {} )
{
    if ( !isdefined( optionalparameters.players ) )
    {
        optionalparameters.players = activityinstance.playerparticipants;
    }
    
    optionalparameters.var_70ceaa17995f7807 = -1;
    function_1c90859b607a24a2( "ui_operator_mission_index", -1, activityinstance, optionalparameters );
}

// Namespace operator_mission_ui
// Params 1, eflags: 0x4
// Checksum 0xe094d542, Offset: 0x484
// Size: 0x93
function private function_c88c5f89fc9cc571( activityinstance )
{
    if ( !activityinstance )
    {
        return;
    }
    
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    if ( activityinstance.forcefocus )
    {
        return;
    }
    
    var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activityinstance );
    forcetime = getdvarfloat( @"hash_ffdd4c21dc544074", var_332f929de1894b2b.focusoverride ?? 5 );
    activityinstance.forcefocus = 1;
    wait forcetime;
    activityinstance.forcefocus = undefined;
}

// Namespace operator_mission_ui
// Params 4, eflags: 0x4
// Checksum 0x39f96050, Offset: 0x51f
// Size: 0xdc
function private function_1c90859b607a24a2( omnvar, value, activityinstance, optionalparameters )
{
    if ( !activity_instance_common::isactivityinstance( activityinstance ) )
    {
        utility::production_map_assert( 0, "setOmnvarForPlayers: no valid activity instance specified" );
        return;
    }
    
    players = optionalparameters.players;
    
    if ( !isdefined( players ) )
    {
        players = activityinstance.playerparticipants;
    }
    
    foreach ( player in players )
    {
        player omnvar_utility::setcachedclientomnvar( omnvar, value );
    }
}

