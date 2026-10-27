// scripts\common\activity_nexus\activity_objective_markers.gsc  (hash_6852b85528e74b9b.gscc) (size: 1683 Bytes / 0x693 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x83bbc30 (138132528)
// size ...... 1683 (0x693)
// includes .. 5   (offset: 0x62f)
// strings ... 4   (offset: 0x657)
// dev strs .. 0   (offset: 0x693)
// exports ... 8   (offset: 0x357)
// cseg ...... 0xad + 0x2aa (0x357)
// imports ... 14  (offset: 0x497)
// animtree1 . 0   (offset: 0x693)
// animtree2 . 0   (offset: 0x693)
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_scriptables;
#using scripts\common\spatial_zone_container;
#using scripts\common\utility;

#namespace activity_objective_markers;

// Namespace activity_objective_markers
// Params 2
// Checksum 0x6977f730, Offset: 0xcb
// Size: 0xdd
function function_87f86c330140a1ee( activityinstance, activitymoment )
{
    if ( istrue( activityinstance.var_2c769a213204c445.var_e50c170eb4ea5213 ) )
    {
        type = activity_definition_utils::function_48c2921599efd7a7( activityinstance );
        spawnmoment = activity_definition_utils::function_63b3e35daebe550e( activityinstance );
        destroymoment = activity_definition_utils::function_48f55085337a366f( activityinstance );
        
        if ( spawnmoment == activitymoment )
        {
            if ( type == "Scriptable" )
            {
                function_781dae1420a6b622( activityinstance );
            }
            else
            {
                utility::callsharedfunc( #"hash_61266e374b6a4978", #"hash_cfba68776eb6b6d1", activityinstance );
            }
            
            activity_instance_common::announceactivitymoment( activityinstance, "ObjectiveMarkerSpawned" );
            return;
        }
        
        if ( destroymoment == activitymoment )
        {
            if ( type == "GSCScript" )
            {
                utility::callsharedfunc( #"hash_61266e374b6a4978", #"hash_82d433365dffce54", activityinstance );
            }
        }
    }
}

// Namespace activity_objective_markers
// Params 1
// Checksum 0xb455b030, Offset: 0x1b0
// Size: 0x17
function function_1dafaa12626eed2b( activityinstance )
{
    return activityinstance.var_e7b6adbe385c7c18;
}

// Namespace activity_objective_markers
// Params 2
// Checksum 0x34ff4f4d, Offset: 0x1d0
// Size: 0x5f
function function_238da7a43b91b2b6( var_f3260707d02e2cd0, var_cd0daf425b585f9b )
{
    var_e7b6adbe385c7c18 = spawnstruct();
    var_e7b6adbe385c7c18.objectivemarkertype = var_f3260707d02e2cd0;
    
    if ( var_f3260707d02e2cd0 == "Scriptable" )
    {
        var_e7b6adbe385c7c18.scriptable = var_cd0daf425b585f9b;
    }
    else
    {
        var_e7b6adbe385c7c18.objectivemarkerid = var_cd0daf425b585f9b;
    }
    
    return var_e7b6adbe385c7c18;
}

// Namespace activity_objective_markers
// Params 1
// Checksum 0xf1635142, Offset: 0x238
// Size: 0x27
function function_12b8e5d644d86f4e( player )
{
    utility::callsharedfunc( #"hash_61266e374b6a4978", #"hash_2c771489de24ca63", player );
}

// Namespace activity_objective_markers
// Params 1
// Checksum 0xdf37a879, Offset: 0x267
// Size: 0x27
function function_4438b88dbb95b69d( player )
{
    utility::callsharedfunc( #"hash_61266e374b6a4978", #"hash_a9dac899f49dbbe", player );
}

// Namespace activity_objective_markers
// Params 0
// Checksum 0xb242cea9, Offset: 0x296
// Size: 0x1b
function function_149cc4ac5d1f2479()
{
    utility::callsharedfunc( #"hash_61266e374b6a4978", #"hash_32b413eabeba80ce" );
}

// Namespace activity_objective_markers
// Params 1, eflags: 0x4
// Checksum 0xd925d7ec, Offset: 0x2b9
// Size: 0x9e
function private function_781dae1420a6b622( activityinstance )
{
    var_1376e209398b4f33 = activity_definition_utils::function_9461b89496773d9( activityinstance );
    origin = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    destroymoment = activity_definition_utils::function_48f55085337a366f( activityinstance );
    
    if ( spatial_zone_container::function_3819f09eefb741e2( activityinstance, "Objective_Marker_Center_Zone" ) )
    {
        origin = spatial_zone_container::function_46a131256b075dc1( activityinstance, "Objective_Marker_Center_Zone" );
    }
    
    scriptable = activity_scriptables::function_e54570745bff582e( activityinstance, var_1376e209398b4f33, origin, destroymoment );
    var_e7b6adbe385c7c18 = function_238da7a43b91b2b6( "Scriptable", scriptable );
    activityinstance.var_e7b6adbe385c7c18 = var_e7b6adbe385c7c18;
}

