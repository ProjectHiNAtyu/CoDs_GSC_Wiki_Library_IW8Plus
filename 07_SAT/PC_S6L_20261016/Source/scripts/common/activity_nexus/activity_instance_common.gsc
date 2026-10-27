// scripts\common\activity_nexus\activity_instance_common.gsc  (hash_1aae2eb1ef28b239.gscc) (size: 25867 Bytes / 0x650b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3ed2b07f (1053995135)
// size ...... 25867 (0x650b)
// includes .. 13  (offset: 0x5e87)
// strings ... 48  (offset: 0x5eef)
// dev strs .. 57  (offset: 0x623f)
// exports ... 93  (offset: 0x3b67)
// cseg ...... 0x441 + 0x3726 (0x3b67)
// imports ... 169 (offset: 0x49ef)
// animtree1 . 0   (offset: 0x650b)
// animtree2 . 0   (offset: 0x650b)
#using script_6d60a2f06878900a;
#using script_77873e194e406c6d;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_objective_markers;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\activity_nexus\activity_scriptables;
#using scripts\common\data_tracker;
#using scripts\common\spatial_zone_container;
#using scripts\common\utility;
#using scripts\common\vehicle_tracking;

#namespace activity_instance_common;

// Namespace activity_instance_common
// Params 0
// Checksum 0x7eb5c8fc, Offset: 0x45f
// Size: 0x185
function function_1b1374bf81fbf953()
{
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &function_5a32e107269624af );
    activity_common::function_2dd4f07fa5c3e911( "InstanceBegin", &function_a32f99fb94e3857a );
    activity_common::function_2dd4f07fa5c3e911( "ActivityBegin", &function_a32f99fb94e3857a );
    activity_common::function_2dd4f07fa5c3e911( "InstanceEnd", &function_a32f99fb94e3857a );
    activity_common::function_2dd4f07fa5c3e911( "ActivityEnd", &function_a32f99fb94e3857a );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &activity_participation::function_14f790ff7844b38f );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &activity_participation::function_14f790ff7844b38f );
    activity_common::function_2dd4f07fa5c3e911( "ActivityStartedHibernation", &function_d29621748837696c );
    activity_common::function_2dd4f07fa5c3e911( "ActivityStoppedHibernating", &function_d29621748837696c );
    activitynexussettings = level.activities.activitynexussettings;
    spatial_zones_initialized = 0;
    
    if ( activity_common::function_8fe1a47c40904418( 2 ) )
    {
        var_a578503c11dcf01f = getdvarfloat( @"hash_e19c52a408e0765d", activitynexussettings.var_55b34ed4f4de921f );
        spatial_zone_container::function_3e5d25f80be6b5d1( 0, &function_578009e372d29590, &function_302464b1524a1340, "Awareness_Zone", var_a578503c11dcf01f );
        spatial_zones_initialized = 1;
    }
    
    if ( activity_common::function_8fe1a47c40904418( 0 ) )
    {
        var_ce6f4dc14d8da119 = getdvarfloat( @"hash_9c8124fab915f0eb", activitynexussettings.var_e25ed5d8e7aead5 );
        spatial_zone_container::function_3e5d25f80be6b5d1( 3, &function_117f055342c4dca2, &function_ccebe3423b966f6a, "Hibernation_Zone", var_ce6f4dc14d8da119 );
        spatial_zones_initialized = 1;
    }
    
    if ( spatial_zones_initialized && activitynexussettings.var_b88ab41cf1fa7cbd )
    {
        setdvar( @"hash_c64ec68784a0520a", 1 );
        level thread function_7a436c0e565eb010();
    }
}

// Namespace activity_instance_common
// Params 4
// Checksum 0x7727c8f9, Offset: 0x5ec
// Size: 0x1fd
function createactivityinstance( activitytype, varianttag, originpoint, additionalspawndatastruct )
{
    if ( !isdefined( level.activities.types[ activitytype ] ) )
    {
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x24>" + varianttag + "<dev string:x34>" + activitytype + "<dev string:x4d>", @"hash_22e4e38cab273e93" );
        #/
        
        activity_common::registeractivitytype( activitytype, undefined );
    }
    
    if ( !isdefined( level.activities.definitions[ varianttag ] ) )
    {
        activity_definition_utils::function_2c1f6f3cc3322582( [ varianttag ] );
        
        if ( !isdefined( level.activities.definitions[ varianttag ] ) )
        {
            assertmsg( "<dev string:xd3>" + varianttag );
            return;
        }
    }
    
    activitydefinitiontag = additionalspawndatastruct.scheduleractivitydefinition ?? varianttag;
    activitydefinition = activity_definition_utils::getactivitydefinition( activitydefinitiontag );
    activitycategory = activity_definition_utils::function_897014a17bf1cbdc( activitydefinition );
    newactivityinstance = function_c77b6cb702b892c9( varianttag, activitytype, activitycategory, additionalspawndatastruct, activitydefinitiontag );
    activitynexussettings = level.activities.activitynexussettings;
    
    if ( activitynexussettings.var_df9dd732e8ef4771 && activitydefinition.var_fb5459d9e8df3630 )
    {
        if ( isfunction( activitydefinition.var_282249d8b7ee5bc5 ) )
        {
            struct = spawnstruct();
            
            if ( activitynexussettings.var_bcf792e556f8dd85 )
            {
                struct.objects = [];
            }
            
            [[ activitydefinition.var_282249d8b7ee5bc5 ]]( varianttag, struct, varianttag );
            activitydefinition.var_fb5459d9e8df3630 = 0;
            
            if ( activitynexussettings.var_bcf792e556f8dd85 )
            {
                newactivityinstance.var_5e2e408bea3a39e6 = struct.objects;
            }
        }
    }
    
    activity_common::connectactivityinstance( newactivityinstance );
    activity_common::function_2ba08ba0c0544a1a( 1, [ newactivityinstance, originpoint ], 0 );
    return newactivityinstance;
}

// Namespace activity_instance_common
// Params 3
// Checksum 0xae456546, Offset: 0x7f2
// Size: 0x86
function function_9b387cb1af0d5b4b( varianttag, originpoint, additionalspawndatastruct )
{
    activitydefinitiontag = additionalspawndatastruct.scheduleractivitydefinition ?? varianttag;
    activitydefinition = activity_definition_utils::getactivitydefinition( activitydefinitiontag );
    
    if ( isdefined( activitydefinition ) )
    {
        customproperties = activity_definition_utils::function_9129cd8075c85c09( activitydefinition );
        activitytype = customproperties.activitytype;
        return createactivityinstance( activitytype, varianttag, originpoint, additionalspawndatastruct );
    }
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x63375c19, Offset: 0x880
// Size: 0x1a
function function_46135a69bddfec2c( activityinstance )
{
    activityinstance thread function_93590b0cc63e45bb( "Active" );
}

// Namespace activity_instance_common
// Params 1
// Checksum 0xe6e8e4db, Offset: 0x8a2
// Size: 0x1a
function function_9aeeabe50fc9cc3e( activityinstance )
{
    function_cab2c090dc1845e2( activityinstance, "Cleanup" );
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x616799c3, Offset: 0x8c4
// Size: 0x1a
function function_852865f5a195559f( activityinstance )
{
    function_cab2c090dc1845e2( activityinstance, "Active" );
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x91e3097b, Offset: 0x8e6
// Size: 0x62
function setupinstance( relevantparameters )
{
    activityinstance = relevantparameters[ 0 ];
    originpointoverride = relevantparameters[ 1 ];
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    function_52f2d85f9950e6e3( activityinstance, originpointoverride );
    waitframe();
    activity_common::runactivityfunction( activityinstance, 0 );
    waitframe();
    function_549306d1d2e15050( activityinstance );
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x8b66bc94, Offset: 0x950
// Size: 0x60
function function_68f3f41c0fdc02f3( relevantparameters )
{
    activityinstance = relevantparameters[ 0 ];
    originpointoverride = relevantparameters[ 1 ];
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    function_52f2d85f9950e6e3( activityinstance, originpointoverride );
    activity_common::runactivityfunction( activityinstance, 0 );
    function_549306d1d2e15050( activityinstance );
}

// Namespace activity_instance_common
// Params 2
// Checksum 0xece4d6ee, Offset: 0x9b8
// Size: 0x6c
function endactivity( activityinstance, activitysuccess )
{
    currentactivitystate = activityinstance.state;
    
    if ( currentactivitystate != "Active" )
    {
        assertmsg( "<dev string:x118>" + currentactivitystate );
        return;
    }
    
    if ( activitysuccess )
    {
        function_e1f926a35b8c11e( activityinstance );
    }
    else
    {
        function_ab24c2f8d5bd4253( activityinstance );
    }
    
    level thread function_5386dc28e4deeec1( activityinstance );
}

// Namespace activity_instance_common
// Params 3
// Checksum 0xa3e032e1, Offset: 0xa2c
// Size: 0xbe
function function_5e2f9c673ccd965f( activityinstance, var_14d3c6aa1c479f1e, relevantinfostruct = spawnstruct() )
{
    if ( !isdefined( relevantinfostruct.playerlist ) )
    {
        relevantinfostruct.playerlist = activityinstance.playerparticipants;
    }
    
    relevantinfostruct.var_14d3c6aa1c479f1e = var_14d3c6aa1c479f1e;
    activityinstance activity_player_broadcasting::function_cb4750c84882dd07( var_14d3c6aa1c479f1e, relevantinfostruct.playerlist );
    activityinstance activity_player_broadcasting::function_b9b05383569833c7( var_14d3c6aa1c479f1e );
    activity_rewards::function_a1243aea0ef35dd9( activityinstance, "ActivationName", var_14d3c6aa1c479f1e, relevantinfostruct.rewardstructoverride );
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x170>" + var_14d3c6aa1c479f1e, @"hash_22e4e38cab273e93", activityinstance, relevantinfostruct.playerlist );
    #/
}

// Namespace activity_instance_common
// Params 3
// Checksum 0xa9894717, Offset: 0xaf2
// Size: 0xdd
function announceactivitymoment( activityinstance, activitymoment, relevantinfostruct = spawnstruct() )
{
    if ( !isdefined( relevantinfostruct.playerlist ) )
    {
        relevantinfostruct.playerlist = activityinstance.playerparticipants;
    }
    
    relevantinfostruct.activitymoment = activitymoment;
    activityinstance activity_player_broadcasting::function_849396805a2d9d98( activitymoment, relevantinfostruct.playerlist );
    activityinstance activity_player_broadcasting::function_b48d25e3756ccf58( activitymoment );
    namespace_49c2d747a467dc5f::function_87f86c330140a1ee( activityinstance, activitymoment );
    activity_scriptables::function_a7d7e6902efa9fe5( activityinstance, activitymoment );
    activity_rewards::function_a1243aea0ef35dd9( activityinstance, activitymoment, undefined, relevantinfostruct.rewardstructoverride );
    activityinstance activity_common::function_b1f11552b32b5a58( activitymoment, relevantinfostruct );
    activityinstance notify( activitymoment );
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x189>" + activitymoment, @"hash_22e4e38cab273e93", activityinstance, relevantinfostruct.playerlist );
    #/
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x118d2b62, Offset: 0xbd7
// Size: 0x17
function getinstanceid( activityinstance )
{
    return activityinstance.id;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x24efadd3, Offset: 0xbf7
// Size: 0x17
function getactivitystate( activityinstance )
{
    return activityinstance.state;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x83f7809c, Offset: 0xc17
// Size: 0x17
function function_846712888f1deea3( activityinstance )
{
    return activityinstance.previousstate;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x1095b136, Offset: 0xc37
// Size: 0x18
function function_be0fb090edaf64f( activityinstance )
{
    return activityinstance.playerparticipants.size;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x8867cf2e, Offset: 0xc58
// Size: 0x17
function function_4225efca86f0dea9( activityinstance )
{
    return activityinstance.playerparticipants;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x5efc078e, Offset: 0xc78
// Size: 0x17
function getactivityvariantname( activityinstance )
{
    return activityinstance.varianttag;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0xb21d13c2, Offset: 0xc98
// Size: 0x17
function getactivitytype( activityinstance )
{
    return activityinstance.type;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x5d88d21, Offset: 0xcb8
// Size: 0x17
function getactivitycategory( activityinstance )
{
    return activityinstance.category;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0xa5dd5d6a, Offset: 0xcd8
// Size: 0x17
function function_67d99765fda0e40f( activityinstance )
{
    return activityinstance.participationconditions;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x8fcd0161, Offset: 0xcf8
// Size: 0x1b, Type: bool
function function_9b599023b3237e1a( activityinstance )
{
    return activityinstance.var_86737cbe11bf496e ?? [];
}

// Namespace activity_instance_common
// Params 1
// Checksum 0xbb4b37bd, Offset: 0xd1c
// Size: 0x17
function function_b3f1eecfa40e08c8( activityinstance )
{
    return activityinstance.var_c01a5323cc5fc8c0;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x96a29cc1, Offset: 0xd3c
// Size: 0x17
function function_feab7f5d34b69826( activityinstance )
{
    return activityinstance.var_aef199e9dadf99c2;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x27dd38a5, Offset: 0xd5c
// Size: 0x17
function function_74c4f6090ce6a660( activityinstance )
{
    return activityinstance.var_edcfe5dcdc005aaf;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0xb88cb6a5, Offset: 0xd7c
// Size: 0x52, Type: bool
function function_6bb0be4a3940d6e3( activityinstance )
{
    currentactivitystate = activityinstance.state;
    var_816b32294b353c64 = currentactivitystate == "Ended" || currentactivitystate == "Cleanup";
    return var_816b32294b353c64 && activityinstance.successfullycompleted;
}

// Namespace activity_instance_common
// Params 2
// Checksum 0x82d69f00, Offset: 0xdd7
// Size: 0x2e, Type: bool
function function_3533b5cedda7ea38( activityinstance, transitionstate )
{
    var_bfad33d693451095 = function_40d17b50716a32d4( activityinstance, transitionstate );
    return var_bfad33d693451095 == 0;
}

// Namespace activity_instance_common
// Params 2, eflags: 0x4
// Checksum 0x7992bd81, Offset: 0xe0e
// Size: 0xd4
function private function_40d17b50716a32d4( activityinstance, transitionstate )
{
    fromstate = activityinstance.state;
    blockercount = 0;
    
    if ( isdefined( activityinstance.var_1b92afc66cfe9394[ fromstate ] ) )
    {
        if ( isdefined( activityinstance.var_1b92afc66cfe9394[ fromstate ][ transitionstate ] ) )
        {
            blockercount += activityinstance.var_1b92afc66cfe9394[ fromstate ][ transitionstate ];
        }
        
        if ( isdefined( activityinstance.var_1b92afc66cfe9394[ fromstate ][ "Any" ] ) )
        {
            blockercount += activityinstance.var_1b92afc66cfe9394[ fromstate ][ "Any" ];
        }
    }
    
    if ( isdefined( activityinstance.var_1b92afc66cfe9394[ "Any" ][ transitionstate ] ) )
    {
        blockercount += activityinstance.var_1b92afc66cfe9394[ "Any" ][ transitionstate ];
    }
    
    return blockercount;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x127493af, Offset: 0xeeb
// Size: 0x40, Type: bool
function isactivityinstance( possibleactivityinstance )
{
    return isstruct( possibleactivityinstance ) && possibleactivityinstance.varianttag && possibleactivityinstance.type && isdefined( possibleactivityinstance.id );
}

// Namespace activity_instance_common
// Params 2
// Checksum 0x9f02b544, Offset: 0xf34
// Size: 0x51
function function_cbd9eccae7248167( activityinstance, omnvar )
{
    if ( !activityinstance data_tracker::function_72b9e57bfc6deb7a( omnvar ) )
    {
        assertmsg( "<dev string:x19b>" + omnvar + "<dev string:x1a8>" );
        return;
    }
    
    var_74e092fab50d5bbb = activityinstance data_tracker::getdatavalue( omnvar );
    return var_74e092fab50d5bbb[ 0 ];
}

// Namespace activity_instance_common
// Params 2
// Checksum 0x10bb7c30, Offset: 0xf8e
// Size: 0x52
function function_36c2913457195db6( activityinstance, omnvar )
{
    if ( !activityinstance data_tracker::function_72b9e57bfc6deb7a( omnvar ) )
    {
        assertmsg( "<dev string:x19b>" + omnvar + "<dev string:x1ea>" );
        return;
    }
    
    var_74e092fab50d5bbb = activityinstance data_tracker::getdatavalue( omnvar );
    return var_74e092fab50d5bbb[ 1 ];
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x35708314, Offset: 0xfe9
// Size: 0x58, Type: bool
function function_188180ca913da025( activityinstance )
{
    activitytype = activityinstance.type;
    centerpointactivityfunction = activity_common::getactivityfunction( activitytype, 4 );
    var_7c14c74b8a8910a8 = &function_94763020f8207b8b;
    
    if ( isdefined( centerpointactivityfunction ) && centerpointactivityfunction != var_7c14c74b8a8910a8 )
    {
        return true;
    }
    
    return false;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x60557b65, Offset: 0x104a
// Size: 0xaf
function function_776ee11e7acc64a5( activityinstance )
{
    assert( isactivityinstance( activityinstance ), "<dev string:x232>" );
    centerpoint = undefined;
    activitytype = activityinstance.type;
    
    if ( activity_common::function_460fd843724fc9b1( activitytype, 4 ) )
    {
        centerpoint = activity_common::runactivityfunction( activityinstance, 4 );
    }
    
    if ( !isdefined( centerpoint ) && isdefined( activityinstance.var_441d26d05f86b224 ) )
    {
        centerpoint = activityinstance.var_441d26d05f86b224;
    }
    
    if ( !isdefined( centerpoint ) )
    {
        centerpoint = activityinstance function_94763020f8207b8b();
    }
    
    assert( isdefined( centerpoint ), "<dev string:x286>" );
    activityinstance.var_441d26d05f86b224 = centerpoint;
    return centerpoint;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x3b343d52, Offset: 0x1102
// Size: 0x1b, Type: bool
function function_a45920af4495e9f( activityinstance )
{
    return activityinstance.additionalspawndata ?? {};
}

// Namespace activity_instance_common
// Params 2
// Checksum 0x8dab37c5, Offset: 0x1126
// Size: 0x32, Type: bool
function function_589f2d290acdba2e( activityinstance, uniquenamestring )
{
    var_faa32340102ca7a6 = activityinstance.var_616e5ae39235196f[ uniquenamestring ];
    return isdefined( var_faa32340102ca7a6 );
}

// Namespace activity_instance_common
// Params 3
// Checksum 0xb9630461, Offset: 0x1161
// Size: 0x72
function function_245ea339f8da9fdf( activityinstance, filtervalue, filterkey = "targetname" )
{
    activityvariantname = activityinstance.varianttag;
    var_d5d087aef198e6f2 = activity_common::function_d54f02a6971bb9ab( activityvariantname );
    var_1f80be556985509a = var_d5d087aef198e6f2.variantstruct;
    return var_1f80be556985509a utility::get_linked_structs( filtervalue, filterkey );
}

// Namespace activity_instance_common
// Params 3
// Checksum 0x5febda44, Offset: 0x11dc
// Size: 0x157
function function_c78d8509d1f980d4( activityinstance, var_5f1f6eab155c653 = 0, targetname )
{
    var_3d732d27ee16422e = [];
    filteredstructs = [];
    activityvariantname = activityinstance.varianttag;
    
    for ( variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( activityvariantname ); isdefined( variantscriptstructinfo ) ; variantscriptstructinfo = undefined )
    {
        var_3d732d27ee16422e = arraycombine( var_3d732d27ee16422e, variantscriptstructinfo.linkedstructs );
        
        if ( var_5f1f6eab155c653 && isstring( variantscriptstructinfo.variantstruct.parent ) )
        {
            activityvariantname = variantscriptstructinfo.variantstruct.parent;
            variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( activityvariantname );
            continue;
        }
    }
    
    if ( targetname )
    {
        foreach ( struct in var_3d732d27ee16422e )
        {
            if ( struct.targetname == targetname )
            {
                filteredstructs[ filteredstructs.size ] = struct;
            }
        }
    }
    else
    {
        filteredstructs = var_3d732d27ee16422e;
    }
    
    return filteredstructs;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x8b3ee24, Offset: 0x133c
// Size: 0x9f
function function_cd2690a2bc0c11dc( activityinstance )
{
    var_e4d368f9e8153fb6 = [];
    activityvariantname = activityinstance.varianttag;
    
    for ( variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( activityvariantname ); isdefined( variantscriptstructinfo ) ; variantscriptstructinfo = undefined )
    {
        if ( isstring( variantscriptstructinfo.variantstruct.parent ) )
        {
            activityvariantname = variantscriptstructinfo.variantstruct.parent;
            variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( activityvariantname );
            var_e4d368f9e8153fb6[ var_e4d368f9e8153fb6.size ] = variantscriptstructinfo.variantstruct;
            continue;
        }
    }
    
    return var_e4d368f9e8153fb6;
}

// Namespace activity_instance_common
// Params 2
// Checksum 0xb81e0083, Offset: 0x13e4
// Size: 0x3e
function function_81b574fc71c0945c( activityinstance, newpriorityscore )
{
    assert( newpriorityscore >= 1 && newpriorityscore <= 10, "<dev string:x32c>" );
    activityinstance.var_c01a5323cc5fc8c0 = newpriorityscore;
}

// Namespace activity_instance_common
// Params 2
// Checksum 0x2123d3a, Offset: 0x142a
// Size: 0x4c
function function_fe41d48bb636bd33( activityinstance, scoreoffset )
{
    newpriorityscore = activityinstance.var_c01a5323cc5fc8c0;
    newpriorityscore += scoreoffset;
    activityinstance.var_c01a5323cc5fc8c0 = int( clamp( newpriorityscore, 1, 10 ) );
}

// Namespace activity_instance_common
// Params 2
// Checksum 0xccca7dbc, Offset: 0x147e
// Size: 0x77
function function_99e73a946c1a6920( activityinstance, var_cc80fd98f06f0d2e )
{
    if ( !isdefined( activityinstance.var_86737cbe11bf496e ) )
    {
        activityinstance.var_86737cbe11bf496e = [];
    }
    
    activityinstance.var_86737cbe11bf496e = arraycombineunique( activityinstance.var_86737cbe11bf496e, [ var_cc80fd98f06f0d2e ] );
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x35b>", @"hash_22e4e38cab273e93", activityinstance, activityinstance.var_86737cbe11bf496e );
    #/
}

// Namespace activity_instance_common
// Params 4
// Checksum 0x410553df, Offset: 0x14fd
// Size: 0x4f
function function_c3911b0306ab7c81( activityinstance, fromstate, tostate, reasonstring = undefined )
{
    fromstate = fromstate ?? activityinstance.state;
    function_dce1f4726e27145e( activityinstance, fromstate, tostate, undefined, reasonstring );
}

// Namespace activity_instance_common
// Params 5
// Checksum 0x5beda42, Offset: 0x1554
// Size: 0x95
function function_a1d94c2267cba15( activityinstance, fromstate, tostate, uniquenamestring = undefined, reasonstring = undefined )
{
    if ( isdefined( activityinstance.var_616e5ae39235196f[ uniquenamestring ] ) )
    {
        assertmsg( "<dev string:x388>" + uniquenamestring + "<dev string:x3b9>" + activityinstance.varianttag );
        return;
    }
    
    fromstate = fromstate ?? activityinstance.state;
    function_dce1f4726e27145e( activityinstance, fromstate, tostate, uniquenamestring, reasonstring );
}

// Namespace activity_instance_common
// Params 4
// Checksum 0x46772d9d, Offset: 0x15f1
// Size: 0x9b
function function_32302285cf865c56( activityinstance, fromstate, tostate, reasonstring = undefined )
{
    fromstate = fromstate ?? activityinstance.state;
    
    if ( isdefined( activityinstance.var_1b92afc66cfe9394[ fromstate ][ tostate ] ) )
    {
        activityinstance.var_1b92afc66cfe9394[ fromstate ][ tostate ] = max( activityinstance.var_1b92afc66cfe9394[ fromstate ][ tostate ] - 1, 0 );
        activityinstance notify( #"hash_4a1fc46867187532" );
        function_ff161bfa7efd3443( activityinstance, 0, fromstate, tostate, undefined, reasonstring );
    }
}

// Namespace activity_instance_common
// Params 3
// Checksum 0x1c8caa21, Offset: 0x1694
// Size: 0xef
function function_3e3a340f4b0f8f1e( activityinstance, uniquenamestring, reasonstring = undefined )
{
    var_faa32340102ca7a6 = activityinstance.var_616e5ae39235196f[ uniquenamestring ];
    
    if ( isdefined( var_faa32340102ca7a6 ) )
    {
        fromstate = var_faa32340102ca7a6.fromstate;
        tostate = var_faa32340102ca7a6.tostate;
        activityinstance.var_1b92afc66cfe9394[ fromstate ][ tostate ] = max( activityinstance.var_1b92afc66cfe9394[ fromstate ][ tostate ] - 1, 0 );
        activityinstance.var_616e5ae39235196f[ uniquenamestring ] = undefined;
        activityinstance notify( #"hash_4a1fc46867187532" );
        function_ff161bfa7efd3443( activityinstance, 0, fromstate, tostate, uniquenamestring, reasonstring );
        return;
    }
    
    assertmsg( "<dev string:x3db>" + uniquenamestring + "<dev string:x40b>" + activityinstance.varianttag + "<dev string:x41e>" );
}

// Namespace activity_instance_common
// Params 4
// Checksum 0xe071186d, Offset: 0x178b
// Size: 0xad
function function_dde540f74dc06621( activityinstance, omnvar, value, resetvalue )
{
    var_46cfd10a962d440c = activityinstance data_tracker::function_72b9e57bfc6deb7a( omnvar );
    
    if ( var_46cfd10a962d440c )
    {
        activityinstance data_tracker::updatedata( omnvar, [ value, resetvalue ] );
        return;
    }
    
    activityinstance data_tracker::adddata( omnvar, "Array", [ value, resetvalue ] );
    
    if ( !isdefined( activityinstance.var_7c698b8c97c7c92c ) )
    {
        activityinstance.var_7c698b8c97c7c92c = [];
    }
    
    activityinstance.var_7c698b8c97c7c92c[ activityinstance.var_7c698b8c97c7c92c.size ] = omnvar;
}

// Namespace activity_instance_common
// Params 2
// Checksum 0x489d07c1, Offset: 0x1840
// Size: 0x8c
function function_e80ace5c61b13188( activityinstance, var_edcfe5dcdc005aaf )
{
    if ( istrue( activityinstance.var_2c769a213204c445.var_403dace0b683ab5a ) )
    {
        var_49858f57f7fb0a86 = activityinstance.var_edcfe5dcdc005aaf;
        activityinstance.var_edcfe5dcdc005aaf = var_edcfe5dcdc005aaf ? 1 : undefined;
        
        if ( var_edcfe5dcdc005aaf && !var_49858f57f7fb0a86 )
        {
            announceactivitymoment( activityinstance, "ActivityStartedHibernation" );
            return;
        }
        
        if ( var_49858f57f7fb0a86 )
        {
            announceactivitymoment( activityinstance, "ActivityStoppedHibernating" );
        }
    }
}

// Namespace activity_instance_common
// Params 0
// Checksum 0x848814de, Offset: 0x18d4
// Size: 0x2f
function function_83ee46defb637d87()
{
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x44e>", @"hash_22e4e38cab273e93", self, undefined, 2 );
    #/
    
    if ( activity_common::function_8769b060f0a2bf() )
    {
        function_46135a69bddfec2c( self );
    }
}

/#

    // Namespace activity_instance_common
    // Params 0
    // Checksum 0xfb7cce1b, Offset: 0x190b
    // Size: 0x1e, Type: dev
    function function_8981d2a4c2c8af1f()
    {
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x4a8>", @"hash_22e4e38cab273e93", self, undefined, 2 );
    }

    // Namespace activity_instance_common
    // Params 0
    // Checksum 0xe0540075, Offset: 0x1931
    // Size: 0x1e, Type: dev
    function function_1a76eced6fe86097()
    {
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x502>", @"hash_22e4e38cab273e93", self, undefined, 2 );
    }

    // Namespace activity_instance_common
    // Params 0
    // Checksum 0x8fcf6a8a, Offset: 0x1957
    // Size: 0x1e, Type: dev
    function function_bc98ac5775bd8084()
    {
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x55a>", @"hash_22e4e38cab273e93", self, undefined, 2 );
    }

#/

// Namespace activity_instance_common
// Params 0
// Checksum 0xc5cdaaf1, Offset: 0x197d
// Size: 0xa4
function function_94763020f8207b8b()
{
    activityinstance = self;
    
    if ( spatial_zone_container::function_3819f09eefb741e2( activityinstance, "Center_Spatial_Zone" ) )
    {
        var_f14fc229bca4b103 = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "Center_Spatial_Zone" );
        assert( var_f14fc229bca4b103.size == 1, "<dev string:x5b6>" );
        var_921677f59da9e582 = var_f14fc229bca4b103[ 0 ];
        return spatial_zone_container::function_2676e037929f0833( var_921677f59da9e582 );
    }
    
    if ( isdefined( activityinstance.var_1103806baee402d5 ) )
    {
        return activityinstance.var_1103806baee402d5;
    }
    
    /#
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x606>", @"hash_22e4e38cab273e93", activityinstance, undefined, 3 );
    #/
    
    return ( 0, 0, 0 );
}

// Namespace activity_instance_common
// Params 2
// Checksum 0x9643a291, Offset: 0x1a2a
// Size: 0x7e
function function_77b0ef7c93812bbe( player, params )
{
    assert( params.size == 2 && isdefined( params[ 0 ] ) && isstring( params[ 1 ] ), "<dev string:x655>" );
    activityinstance = params[ 0 ];
    spatialzonename = params[ 1 ];
    
    if ( !spatial_zone_container::function_3819f09eefb741e2( activityinstance, spatialzonename ) )
    {
        return 0;
    }
    
    var_c4a0644a2719e082 = spatial_zone_container::function_c6b163965cbc2caa( player, activityinstance, spatialzonename );
    return var_c4a0644a2719e082;
}

// Namespace activity_instance_common
// Params 2
// Checksum 0xb94a0a8f, Offset: 0x1ab1
// Size: 0x6f, Type: bool
function function_405d871db57a010( player, params )
{
    assert( params.size == 1 && isdefined( params[ 0 ] ), "<dev string:x655>" );
    activityinstance = params[ 0 ];
    activitycurrentstate = activityinstance.state;
    
    if ( activitycurrentstate == "Ended" || activitycurrentstate == "Cleanup" )
    {
        return false;
    }
    
    return true;
}

// Namespace activity_instance_common
// Params 5, eflags: 0x4
// Checksum 0x2437bceb, Offset: 0x1b29
// Size: 0x1f4
function private function_c77b6cb702b892c9( varianttag, activitytype, category, additionalspawndatastruct, activitydefinitiontag )
{
    if ( isdefined( additionalspawndatastruct ) )
    {
        assert( isstruct( additionalspawndatastruct ), "<dev string:x6a6>" );
    }
    
    newactivityinstance = spawnstruct();
    newactivityinstance.varianttag = varianttag;
    newactivityinstance.activitydefinitiontag = activitydefinitiontag ?? varianttag;
    newactivityinstance.id = activity_common::getuniqueinstanceid();
    newactivityinstance.type = activitytype;
    newactivityinstance.category = category ?? "None";
    newactivityinstance.additionalspawndata = additionalspawndatastruct;
    newactivityinstance.var_2c769a213204c445 = spawnstruct();
    newactivityinstance.state = "Spawned";
    newactivityinstance.var_616e5ae39235196f = [];
    newactivityinstance.var_1b92afc66cfe9394 = [];
    newactivityinstance.playerparticipants = [];
    newactivityinstance.var_aef199e9dadf99c2 = [];
    newactivityinstance.var_8398e655b520bf26 = gettime();
    newactivityinstance.var_edcfe5dcdc005aaf = undefined;
    newactivityinstance.successfullycompleted = undefined;
    newactivityinstance.var_441d26d05f86b224 = undefined;
    newactivityinstance.var_e7b6adbe385c7c18 = undefined;
    newactivityinstance.var_c01a5323cc5fc8c0 = undefined;
    newactivityinstance.previousstate = undefined;
    newactivityinstance.var_86737cbe11bf496e = undefined;
    newactivityinstance.activebroadcasts = undefined;
    newactivityinstance.objectivemarkers = undefined;
    newactivityinstance.var_9c4a0b2cae577c1b = undefined;
    newactivityinstance.var_d916a0349fb35326 = undefined;
    newactivityinstance.var_7c698b8c97c7c92c = undefined;
    newactivityinstance.var_48c2202698ec0bc9 = undefined;
    spatial_zone_container::function_389ac59074912882( newactivityinstance );
    data_tracker::function_201f17e24a1e13b9( newactivityinstance );
    newactivityinstance data_tracker::adddatastring( "ActivityTypeName", activitytype );
    newactivityinstance data_tracker::adddatastring( "ActivityVariantName", varianttag );
    newactivityinstance data_tracker::addcallback( &activity_player_broadcasting::function_a1894473756950fa );
    return newactivityinstance;
}

// Namespace activity_instance_common
// Params 5, eflags: 0x4
// Checksum 0x3b78e721, Offset: 0x1d26
// Size: 0x5b
function private function_1ffae83696c2a693( activityinstance, fromstate, tostate, uniquenamestring = undefined, reasonstring = undefined )
{
    if ( !function_589f2d290acdba2e( activityinstance, uniquenamestring ) )
    {
        function_a1d94c2267cba15( activityinstance, fromstate, tostate, uniquenamestring, reasonstring );
    }
}

// Namespace activity_instance_common
// Params 5, eflags: 0x4
// Checksum 0x71bcb30, Offset: 0x1d89
// Size: 0xeb
function private function_dce1f4726e27145e( activityinstance, fromstate, tostate, uniquenamestring = undefined, reasonstring = undefined )
{
    if ( isdefined( uniquenamestring ) )
    {
        activityinstance.var_616e5ae39235196f[ uniquenamestring ] = { #tostate:tostate, #fromstate:fromstate };
    }
    
    if ( !isdefined( activityinstance.var_1b92afc66cfe9394[ fromstate ] ) )
    {
        activityinstance.var_1b92afc66cfe9394[ fromstate ] = [];
    }
    
    if ( !isdefined( activityinstance.var_1b92afc66cfe9394[ fromstate ][ tostate ] ) )
    {
        activityinstance.var_1b92afc66cfe9394[ fromstate ][ tostate ] = int( 0 );
    }
    
    activityinstance.var_1b92afc66cfe9394[ fromstate ][ tostate ] += 1;
    function_ff161bfa7efd3443( activityinstance, 1, fromstate, tostate, uniquenamestring, reasonstring );
}

// Namespace activity_instance_common
// Params 3, eflags: 0x4
// Checksum 0xb61a6b9e, Offset: 0x1e7c
// Size: 0x3d
function private function_9058619c6b87dc5e( activityinstance, uniquenamestring, reasonstring = undefined )
{
    if ( function_589f2d290acdba2e( activityinstance, uniquenamestring ) )
    {
        function_3e3a340f4b0f8f1e( activityinstance, uniquenamestring, reasonstring );
    }
}

// Namespace activity_instance_common
// Params 2, eflags: 0x4
// Checksum 0xde71b9d4, Offset: 0x1ec1
// Size: 0xd6
function private function_52f2d85f9950e6e3( activityinstance, originpointoverride )
{
    activityinstance.var_1103806baee402d5 = originpointoverride;
    activity_definition_utils::function_9937227c287fd481( activityinstance );
    
    if ( isdefined( originpointoverride ) )
    {
        if ( spatial_zone_container::function_3819f09eefb741e2( activityinstance, "Center_Spatial_Zone" ) )
        {
            spatial_zone_container::function_a16a7e6ae5875495( activityinstance, "Center_Spatial_Zone" );
        }
        
        spatial_zone_container::function_847140d2863dfbf8( activityinstance, "Center_Spatial_Zone", originpointoverride );
    }
    
    if ( activity_common::function_8fe1a47c40904418( 0 ) && !spatial_zone_container::function_3819f09eefb741e2( activityinstance, "Hibernation_Zone" ) )
    {
        activity_definition_utils::function_1063440938a288c4( activityinstance, "Hibernation_Zone" );
    }
    
    function_a2c07fb4a811acc0( activityinstance );
    activityinstance.var_c01a5323cc5fc8c0 = activity_definition_utils::function_2130f1b5ae6ebcee( activityinstance );
    activity_participation::function_922f35ea8811f298( activityinstance );
    function_d254f39675b8cdd5( activityinstance, "Idle" );
    function_c3911b0306ab7c81( activityinstance, "Idle", "Active", "Waiting for initial Instance setup to be complete" );
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0xf73a125e, Offset: 0x1f9f
// Size: 0x3b
function private function_549306d1d2e15050( activityinstance )
{
    announceactivitymoment( activityinstance, "InstanceBegin" );
    activity_participation::function_84e353f7f3b1ebc9( activityinstance );
    function_32302285cf865c56( activityinstance, "Idle", "Active", "Initial Instance setup is now complete" );
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0x8b3c5b97, Offset: 0x1fe2
// Size: 0xf9
function private function_90239727b0b6d96e( activityinstance )
{
    announceactivitymoment( activityinstance, "InstanceEnd" );
    activitynexussettings = level.activities.activitynexussettings;
    
    if ( activitynexussettings.var_bcf792e556f8dd85 )
    {
        function_5e3f130a92ca1975( activityinstance );
    }
    
    activity_common::runactivityfunction( activityinstance, 3 );
    activity_scriptables::activityscriptablecleanup( activityinstance );
    function_780d410bee71c1bd( activityinstance );
    
    if ( isdefined( level.activities.nexusoverrides[ 4 ] ) )
    {
        activity_common::function_2ba08ba0c0544a1a( 4, [ activityinstance ], 1 );
    }
    
    if ( activityinstance.playerparticipants.size > 0 )
    {
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x6ce>", @"hash_22e4e38cab273e93", activityinstance, activityinstance.playerparticipants, 2 );
        #/
        
        activity_participation::function_1f1a3bd685df59e8( activityinstance );
    }
    
    activity_common::function_5293d009a2fe9978( activityinstance );
    activity_common::disconnectactivityinstance( activityinstance );
    activityinstance notify( #"instance_destroyed" );
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0xdc013b, Offset: 0x20e3
// Size: 0x69
function private function_5e3f130a92ca1975( activityinstance )
{
    function_eeeabd83ba497727( activityinstance.var_5e2e408bea3a39e6 );
    function_baa61181d6ba2d3d( activityinstance.var_5e2e408bea3a39e6 );
    activitydefinition = activity_definition_utils::getactivitydefinition( activityinstance.activitydefinitiontag ?? activityinstance.varianttag );
    activitydefinition.var_fb5459d9e8df3630 = 1;
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0x442290e9, Offset: 0x2154
// Size: 0x39a
function private function_eeeabd83ba497727( structs )
{
    to_remove_struct_class_names = [];
    
    foreach ( struct in structs )
    {
        if ( isdefined( struct.targetname ) )
        {
            if ( !isdefined( to_remove_struct_class_names[ "targetname" ][ struct.targetname ] ) )
            {
                to_remove_struct_class_names[ "targetname" ][ struct.targetname ] = [];
            }
            
            size = to_remove_struct_class_names[ "targetname" ][ struct.targetname ].size;
            to_remove_struct_class_names[ "targetname" ][ struct.targetname ][ size ] = struct;
        }
        
        if ( isstring( struct.target ) )
        {
            if ( !isdefined( to_remove_struct_class_names[ "target" ][ struct.target ] ) )
            {
                to_remove_struct_class_names[ "target" ][ struct.target ] = [];
            }
            
            size = to_remove_struct_class_names[ "target" ][ struct.target ].size;
            to_remove_struct_class_names[ "target" ][ struct.target ][ size ] = struct;
        }
        
        if ( isdefined( struct.script_noteworthy ) )
        {
            if ( !isdefined( to_remove_struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ] ) )
            {
                to_remove_struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ] = [];
            }
            
            size = to_remove_struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ].size;
            to_remove_struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ][ size ] = struct;
        }
        
        if ( isdefined( struct.script_linkname ) )
        {
            if ( !isdefined( to_remove_struct_class_names[ "script_linkname" ][ struct.script_linkname ] ) )
            {
                to_remove_struct_class_names[ "script_linkname" ][ struct.script_linkname ] = [];
            }
            
            size = to_remove_struct_class_names[ "script_linkname" ][ struct.script_linkname ].size;
            to_remove_struct_class_names[ "script_linkname" ][ struct.script_linkname ][ size ] = struct;
        }
        
        if ( isdefined( struct.variantname ) )
        {
            if ( !isdefined( to_remove_struct_class_names[ "variantname" ][ struct.variantname ] ) )
            {
                to_remove_struct_class_names[ "variantname" ][ struct.variantname ] = [];
            }
            
            size = to_remove_struct_class_names[ "variantname" ][ struct.variantname ].size;
            to_remove_struct_class_names[ "variantname" ][ struct.variantname ][ size ] = struct;
        }
    }
    
    foreach ( classname in [ "targetname", "target", "script_noteworthy", "script_linkname", "variantname" ] )
    {
        foreach ( classkey, array in to_remove_struct_class_names[ classname ] )
        {
            function_a907fbc88a9d9af0( classname, classkey, array );
        }
    }
}

// Namespace activity_instance_common
// Params 3, eflags: 0x4
// Checksum 0x8e36a790, Offset: 0x24f6
// Size: 0x199
function private function_a907fbc88a9d9af0( classname, classkey, structs )
{
    replacementarray = [];
    arraysize = level.struct_class_names[ classname ][ classkey ].size;
    randomid = randomint( 2147483647 );
    
    foreach ( struct in structs )
    {
        struct.var_a2558f9193e20648 = randomid;
    }
    
    for ( structindex = 0; structindex < arraysize ; structindex++ )
    {
        value = level.struct_class_names[ classname ][ classkey ][ structindex ];
        
        if ( value.var_a2558f9193e20648 != randomid )
        {
            replacementarray[ replacementarray.size ] = value;
        }
    }
    
    foreach ( struct in structs )
    {
        struct.var_a2558f9193e20648 = undefined;
    }
    
    if ( replacementarray.size != arraysize )
    {
        level.struct_class_names[ classname ][ classkey ] = replacementarray;
    }
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0x1d06fcbc, Offset: 0x2697
// Size: 0xc4
function private function_baa61181d6ba2d3d( objects )
{
    foreach ( object in objects )
    {
        if ( isstruct( object ) )
        {
            continue;
        }
        
        var_96485d9c5a2fdac4 = object.classname && isstartstr( object.classname, "noent_volume" );
        
        if ( isent( object ) || var_96485d9c5a2fdac4 )
        {
            object delete();
        }
    }
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0xa4db1b15, Offset: 0x2763
// Size: 0x5e
function private function_9f58452a83750b64( activityinstance )
{
    activityinstance endon( #"activity_started" );
    announceactivitymoment( activityinstance, "ActivityBegin" );
    
    if ( isdefined( level.activities.nexusoverrides[ 2 ] ) )
    {
        activity_common::function_2ba08ba0c0544a1a( 2, [ activityinstance ], 1 );
    }
    
    activity_common::runactivityfunction( activityinstance, 1 );
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0x66e673f6, Offset: 0x27c9
// Size: 0x76
function private function_3649a07d06d4d850( activityinstance )
{
    announceactivitymoment( activityinstance, "ActivityEnd" );
    activity_common::runactivityfunction( activityinstance, 2 );
    function_d2b9c513a4d84c21( activityinstance );
    
    if ( isdefined( level.activities.nexusoverrides[ 3 ] ) )
    {
        activity_common::function_2ba08ba0c0544a1a( 3, [ activityinstance ], 1 );
    }
    
    activityinstance notify( #"activity_ended" );
    waitframe();
    activityinstance thread function_93590b0cc63e45bb( "Cleanup" );
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0xc87e9c45, Offset: 0x2847
// Size: 0xb1
function private function_e1f926a35b8c11e( activityinstance )
{
    foreach ( player in activityinstance.playerparticipants )
    {
        function_99e73a946c1a6920( activityinstance, player );
    }
    
    activityinstance.successfullycompleted = 1;
    announceactivitymoment( activityinstance, "ActivitySuccess" );
    activityinstance notify( #"activity_succeeded" );
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0xf0a3d6af, Offset: 0x2900
// Size: 0x27
function private function_ab24c2f8d5bd4253( activityinstance )
{
    announceactivitymoment( activityinstance, "ActivityFailure" );
    activityinstance notify( #"activity_failed" );
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0x647f4c64, Offset: 0x292f
// Size: 0x1b
function private function_5386dc28e4deeec1( activityinstance )
{
    waitframe();
    activityinstance thread function_93590b0cc63e45bb( "Ended" );
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0x7f43144, Offset: 0x2952
// Size: 0x44
function private function_d2b9c513a4d84c21( activityinstance )
{
    activityinstance activity_progress_tracking::function_a349dbc284b26b2f();
    activityinstance namespace_49c2d747a467dc5f::function_149cc4ac5d1f2479();
    activityinstance spatial_zone_container::function_419417792d934793();
    
    if ( activity_participation::function_5d733a45bcf51ef1( activityinstance ) )
    {
        activity_participation::function_5e5913e13bf9cb28( activityinstance );
    }
    
    activity_participation::function_1f1a3bd685df59e8( activityinstance );
}

// Namespace activity_instance_common
// Params 2, eflags: 0x4
// Checksum 0x54bfd73d, Offset: 0x299e
// Size: 0x10a
function private function_e8f76cf5bbac8511( activityinstance, var_1add81fc387f85de )
{
    activityinstance endon( #"instance_destroyed" );
    fromstate = var_1add81fc387f85de.fromstate;
    tostate = var_1add81fc387f85de.tostate;
    uniquename = var_1add81fc387f85de.uniquename;
    timedelay = var_1add81fc387f85de.timedelay;
    var_8398e655b520bf26 = activityinstance.var_8398e655b520bf26;
    currenttimems = gettime();
    statechangetime = utility::function_6f5d2e1f1ff70482( var_8398e655b520bf26 );
    currenttime = utility::function_6f5d2e1f1ff70482( currenttimems );
    var_8445d7b89423f2de = currenttime - statechangetime;
    
    if ( timedelay > var_8445d7b89423f2de )
    {
        function_1ffae83696c2a693( activityinstance, fromstate, tostate, uniquename, "Waiting for a " + timedelay + " second time delay to elapse" );
        wait timedelay;
        function_9058619c6b87dc5e( activityinstance, uniquename, "The " + timedelay + " second time delay is over" );
    }
}

// Namespace activity_instance_common
// Params 2, eflags: 0x4
// Checksum 0xf4f4c537, Offset: 0x2ab0
// Size: 0xd0
function private function_cab2c090dc1845e2( activityinstance, nextactivitystate )
{
    currentactivitystate = activityinstance.state;
    
    if ( nextactivitystate == "Active" && currentactivitystate == "Idle" )
    {
        function_d254f39675b8cdd5( activityinstance, nextactivitystate );
        function_9f58452a83750b64( activityinstance );
        return;
    }
    
    if ( nextactivitystate == "Ended" && currentactivitystate == "Active" )
    {
        function_d254f39675b8cdd5( activityinstance, nextactivitystate );
        thread function_3649a07d06d4d850( activityinstance );
        return;
    }
    
    if ( nextactivitystate == "Cleanup" && currentactivitystate != "Cleanup" )
    {
        function_d254f39675b8cdd5( activityinstance, nextactivitystate );
        
        if ( currentactivitystate == "Active" || currentactivitystate == "Idle" )
        {
            function_d2b9c513a4d84c21( activityinstance );
        }
        
        function_90239727b0b6d96e( activityinstance );
    }
}

// Namespace activity_instance_common
// Params 1, eflags: 0xc
// Checksum 0x2e6cefa8, Offset: 0x2b88
// Size: 0xb2
function private function_93590b0cc63e45bb( transitionstate )
{
    self notify( #"hash_c5738b877d130f17" );
    self endon( #"hash_c5738b877d130f17" );
    activityinstance = self;
    activityinstance endon( #"instance_destroyed" );
    activityinstance endon( #"hash_cd359b944e88899d" );
    currentactivitystate = activityinstance.state;
    function_29ae521f206c51d7( activityinstance, currentactivitystate, transitionstate );
    
    while ( !function_3533b5cedda7ea38( activityinstance, transitionstate ) )
    {
        /#
            activityinstance.var_9d7bc02bbcf5ef6f = transitionstate;
        #/
        
        activityinstance waittill( #"hash_4a1fc46867187532" );
    }
    
    /#
        activityinstance.var_9d7bc02bbcf5ef6f = undefined;
    #/
    
    thread function_cab2c090dc1845e2( activityinstance, transitionstate );
}

// Namespace activity_instance_common
// Params 3, eflags: 0x4
// Checksum 0xccb872cc, Offset: 0x2c42
// Size: 0x180
function private function_29ae521f206c51d7( activityinstance, fromstate, tostate )
{
    var_94aa8ab04072fb77 = activity_definition_utils::function_4745f33d7aa0a13( activityinstance, fromstate, tostate );
    
    foreach ( var_1add81fc387f85de in var_94aa8ab04072fb77 )
    {
        if ( var_1add81fc387f85de.uniquename == "Players Within Zone Blocker" )
        {
            activityinstance thread function_7a01f4f629f3eac1( var_1add81fc387f85de, 1 );
            continue;
        }
        
        if ( var_1add81fc387f85de.uniquename == "Players Outside Zone Blocker" )
        {
            activityinstance thread function_7a01f4f629f3eac1( var_1add81fc387f85de, 0 );
            continue;
        }
        
        if ( var_1add81fc387f85de.uniquename == "Minimum Player Participation Blocker" )
        {
            function_1ffae83696c2a693( activityinstance, var_1add81fc387f85de.fromstate, var_1add81fc387f85de.tostate, "Minimum Player Participation Blocker", "Waiting until minimum player count is met" );
            continue;
        }
        
        if ( var_1add81fc387f85de.uniquename == "Time Delay Blocker" )
        {
            thread function_e8f76cf5bbac8511( activityinstance, var_1add81fc387f85de );
            continue;
        }
        
        if ( var_1add81fc387f85de.uniquename == "Vehicle Count Blocker" )
        {
            activityinstance thread function_fad003f94853299c( var_1add81fc387f85de );
            continue;
        }
        
        if ( var_1add81fc387f85de.uniquename == "Player FOV Blocker" )
        {
            thread function_42cf6c6bc3841826( activityinstance, var_1add81fc387f85de );
        }
    }
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0xc13936d8, Offset: 0x2dca
// Size: 0x45
function private function_5a32e107269624af( relevantinfostruct )
{
    activityinstance = self;
    
    if ( activityinstance.playerparticipants.size == 0 && activity_definition_utils::function_1fcf0e2dc0d1c7be( activityinstance ) )
    {
        waitframe();
        activityinstance function_93590b0cc63e45bb( "Cleanup" );
    }
}

// Namespace activity_instance_common
// Params 2, eflags: 0x4
// Checksum 0x5340804f, Offset: 0x2e17
// Size: 0xc8
function private function_d254f39675b8cdd5( activityinstance, activityinstancestate )
{
    if ( activityinstancestate == "Spawned" )
    {
        assertmsg( "<dev string:x7ae>" );
        return;
    }
    
    currentactivitystate = activityinstance.state;
    activityinstance.previousstate = currentactivitystate;
    activityinstance.state = activityinstancestate;
    activityinstance.var_8398e655b520bf26 = gettime();
    
    /#
        if ( namespace_634561435cfb3169::function_a940a26e08d4ac7e( @"hash_f972c083ecfc0669" ) )
        {
            logstring = "<dev string:x867>" + currentactivitystate + "<dev string:x88e>" + activityinstancestate + "<dev string:x894>";
            namespace_634561435cfb3169::activitynexuslog( logstring, @"hash_f972c083ecfc0669", activityinstance );
        }
    #/
    
    activityinstance notify( #"hash_cd359b944e88899d" );
}

// Namespace activity_instance_common
// Params 6, eflags: 0x4
// Checksum 0x2e47e22d, Offset: 0x2ee7
// Size: 0x162
function private function_ff161bfa7efd3443( activityinstance, beingadded, fromstate, tostate, uniquenamestring, reasonstring )
{
    /#
        if ( namespace_634561435cfb3169::function_a940a26e08d4ac7e( @"hash_f972c083ecfc0669" ) )
        {
            blockercount = activityinstance.var_1b92afc66cfe9394[ fromstate ][ tostate ];
            uniquenamestring = isdefined( uniquenamestring ) ? "<dev string:x896>" + uniquenamestring : "<dev string:x8a4>";
            logprefix = beingadded ? "<dev string:x8a5>" : "<dev string:x8c6>";
            logmiddle = uniquenamestring + "<dev string:x8e9>" + blockercount + "<dev string:x8fb>" + fromstate + "<dev string:x88e>" + tostate + "<dev string:x928>";
            logsuffix = ( isstring( reasonstring ) ? "<dev string:x956>" + reasonstring : "<dev string:x8a4>" ) + "<dev string:x894>";
            namespace_634561435cfb3169::activitynexuslog( logprefix + logmiddle + logsuffix, @"hash_f972c083ecfc0669", activityinstance );
            blockercount = function_40d17b50716a32d4( activityinstance, tostate );
            currentactivitystate = activityinstance.state;
            logstring = "<dev string:x978>" + blockercount + "<dev string:x988>" + tostate + "<dev string:x9b7>";
            namespace_634561435cfb3169::activitynexuslog( logstring, @"hash_f972c083ecfc0669", activityinstance );
        }
    #/
}

// Namespace activity_instance_common
// Params 1, eflags: 0xc
// Checksum 0x9799d71, Offset: 0x3051
// Size: 0x107
function private function_fad003f94853299c( var_1add81fc387f85de )
{
    self notify( #"hash_34c796ebd410d88c" );
    self endon( #"hash_34c796ebd410d88c" );
    activityinstance = self;
    activityinstance endon( #"instance_destroyed" );
    activityinstance endon( #"hash_cd359b944e88899d" );
    vehiclecount = var_1add81fc387f85de.vehiclecount;
    fromstate = var_1add81fc387f85de.fromstate;
    tostate = var_1add81fc387f85de.tostate;
    loggingreasonstring = "";
    var_1ef6a17d80fae135 = 5;
    
    while ( true )
    {
        if ( !vehicle_tracking::can_spawn_vehicle( vehiclecount ) )
        {
            /#
                loggingreasonstring = "<dev string:x9e1>" + vehiclecount + "<dev string:xa24>";
            #/
            
            function_1ffae83696c2a693( activityinstance, fromstate, tostate, "Vehicle Count Blocker", loggingreasonstring );
        }
        else
        {
            /#
                loggingreasonstring = "<dev string:xa2d>" + vehiclecount + "<dev string:xa24>";
            #/
            
            function_9058619c6b87dc5e( activityinstance, "Vehicle Count Blocker", loggingreasonstring );
        }
        
        wait var_1ef6a17d80fae135;
    }
}

// Namespace activity_instance_common
// Params 2, eflags: 0xc
// Checksum 0x3f0d4ced, Offset: 0x3160
// Size: 0x1ae
function private function_7a01f4f629f3eac1( var_1add81fc387f85de, playersdesired )
{
    self notify( #"hash_ed090db19e0fa437" );
    self endon( #"hash_ed090db19e0fa437" );
    activityinstance = self;
    activityinstance endon( #"instance_destroyed" );
    activityinstance endon( #"hash_cd359b944e88899d" );
    loggingdvar = @"hash_22e4e38cab273e93";
    var_bff83a9335829a16 = "";
    var_6ac723d384dc78d8 = "";
    
    /#
        if ( playersdesired )
        {
            var_bff83a9335829a16 = "<dev string:xa6b>";
            var_6ac723d384dc78d8 = "<dev string:xa8c>";
        }
        else
        {
            var_bff83a9335829a16 = "<dev string:xaa3>";
            var_6ac723d384dc78d8 = "<dev string:xac6>";
        }
    #/
    
    fromstate = var_1add81fc387f85de.fromstate;
    tostate = var_1add81fc387f85de.tostate;
    uniquename = var_1add81fc387f85de.uniquename;
    zoneinfostruct = var_1add81fc387f85de.zoneinfostruct;
    var_7db8abd53b2ee019 = uniquename + fromstate + tostate;
    
    if ( !spatial_zone_container::function_3819f09eefb741e2( activityinstance, var_7db8abd53b2ee019 ) )
    {
        activity_definition_utils::function_77f316c8a973cf7a( activityinstance, var_7db8abd53b2ee019, zoneinfostruct );
    }
    
    while ( true )
    {
        if ( !activityinstance.var_edcfe5dcdc005aaf )
        {
            playersinradius = spatial_zone_container::function_84f653d797112085( activityinstance, var_7db8abd53b2ee019 );
            
            if ( playersinradius.size > 0 )
            {
                if ( playersdesired )
                {
                    function_9058619c6b87dc5e( activityinstance, var_7db8abd53b2ee019, var_6ac723d384dc78d8 );
                }
                else
                {
                    function_1ffae83696c2a693( activityinstance, fromstate, tostate, var_7db8abd53b2ee019, var_bff83a9335829a16 );
                }
            }
            else if ( playersinradius.size == 0 )
            {
                if ( playersdesired )
                {
                    function_1ffae83696c2a693( activityinstance, fromstate, tostate, var_7db8abd53b2ee019, var_bff83a9335829a16 );
                }
                else
                {
                    function_9058619c6b87dc5e( activityinstance, var_7db8abd53b2ee019, var_6ac723d384dc78d8 );
                }
            }
        }
        
        wait 1.5;
    }
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0xd1839917, Offset: 0x3316
// Size: 0x92
function private function_a32f99fb94e3857a( relevantinfostruct )
{
    activityinstance = self;
    activitydefinition = activityinstance activity_definition_utils::function_837a0c8626c9b419();
    activationmoment = activity_definition_utils::function_a771e0faeddcc15e( activitydefinition );
    deactivationmoment = activity_definition_utils::function_d946edd15270dfdf( activitydefinition );
    
    if ( !activity_participation::function_5d733a45bcf51ef1( activityinstance ) )
    {
        if ( activationmoment == relevantinfostruct.activitymoment )
        {
            activity_participation::function_a45fd1c5cc774007( activityinstance );
        }
        
        return;
    }
    
    if ( deactivationmoment == relevantinfostruct.activitymoment )
    {
        activity_participation::function_5e5913e13bf9cb28( activityinstance );
    }
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0xc265649b, Offset: 0x33b0
// Size: 0x91
function private function_780d410bee71c1bd( activityinstance )
{
    spatialzonenames = spatial_zone_container::function_db3efdf4ec087c3f( activityinstance );
    
    foreach ( spatialzonename in spatialzonenames )
    {
        spatial_zone_container::function_4f9fccd04a537897( activityinstance, spatialzonename );
    }
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0xf4977eb9, Offset: 0x3449
// Size: 0x68
function private function_a2c07fb4a811acc0( activityinstance )
{
    activity_player_broadcasting::function_999f4d62e6798267( activityinstance );
    var_a953217975e7cf60 = activityinstance.var_2c769a213204c445;
    var_a953217975e7cf60.var_e50c170eb4ea5213 = activity_definition_utils::function_4bbcb4818269953d( activityinstance );
    var_a953217975e7cf60.var_403dace0b683ab5a = activity_definition_utils::function_31ae56e3ed53afc0( activityinstance );
    var_a953217975e7cf60.maxplayercount = activity_definition_utils::getmaxplayercount( activityinstance );
}

// Namespace activity_instance_common
// Params 0, eflags: 0x4
// Checksum 0xe68e30d5, Offset: 0x34b9
// Size: 0x22
function private function_117f055342c4dca2()
{
    var_ca3f65fdba0a9ed2 = level.activities;
    return var_ca3f65fdba0a9ed2.var_d520b27efd9742e5;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0x3394d79f, Offset: 0x34e4
// Size: 0xe5
function function_ccebe3423b966f6a( var_54c779cf281bb58d )
{
    activityinstance = self;
    spatialzonename = var_54c779cf281bb58d.zonename;
    player = var_54c779cf281bb58d.player;
    playerinzone = var_54c779cf281bb58d.enteredzone;
    var_1d8b76e369a86de = [[ var_54c779cf281bb58d.var_de8af980c94ffa6b ]]( var_54c779cf281bb58d );
    assert( isactivityinstance( activityinstance ), "<dev string:xae6>" );
    assert( spatialzonename == "<dev string:xb3a>", "<dev string:xb4b>" );
    assert( isplayer( player ), "<dev string:xba7>" );
    
    if ( playerinzone )
    {
        function_e80ace5c61b13188( activityinstance, 0 );
        return;
    }
    
    if ( var_1d8b76e369a86de.size == 0 && activityinstance.playerparticipants.size == 0 )
    {
        function_e80ace5c61b13188( activityinstance, 1 );
    }
}

// Namespace activity_instance_common
// Params 0, eflags: 0x4
// Checksum 0xef897e61, Offset: 0x35d1
// Size: 0xbb
function private function_578009e372d29590()
{
    var_7c4f0abc069ef777 = level.activities.var_7c4f0abc069ef777;
    var_10b0d8f61a9d0ae2 = [];
    
    foreach ( instance in var_7c4f0abc069ef777 )
    {
        if ( isdefined( instance.var_8339fb4f2d23dabf.zones[ "Awareness_Zone" ] ) )
        {
            var_10b0d8f61a9d0ae2[ var_10b0d8f61a9d0ae2.size ] = instance;
        }
    }
    
    return var_10b0d8f61a9d0ae2;
}

// Namespace activity_instance_common
// Params 1
// Checksum 0xc7d276cf, Offset: 0x3695
// Size: 0xf2
function function_302464b1524a1340( var_54c779cf281bb58d )
{
    activityinstance = self;
    spatialzonename = var_54c779cf281bb58d.zonename;
    player = var_54c779cf281bb58d.player;
    playerinzone = var_54c779cf281bb58d.enteredzone;
    firsttimeinzone = var_54c779cf281bb58d.firsttimeinzone;
    assert( isactivityinstance( activityinstance ), "<dev string:xae6>" );
    assert( spatialzonename == "<dev string:xbe7>", "<dev string:xbf6>" );
    assert( isplayer( player ), "<dev string:xba7>" );
    activitydefinition = activity_definition_utils::function_837a0c8626c9b419( activityinstance );
    
    if ( playerinzone )
    {
        if ( !function_c15f2c77ab99aff1( activityinstance, player ) )
        {
            function_68934289d7dda6cd( activityinstance, player, firsttimeinzone );
        }
        
        return;
    }
    
    if ( function_c15f2c77ab99aff1( activityinstance, player ) )
    {
        function_7484adb72ab4051( activityinstance, player );
    }
}

// Namespace activity_instance_common
// Params 2, eflags: 0x4
// Checksum 0x5e49646d, Offset: 0x378f
// Size: 0x4a, Type: bool
function private function_c15f2c77ab99aff1( activityinstance, player )
{
    playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
    return isdefined( activityinstance.var_aef199e9dadf99c2[ playerguid ] );
}

// Namespace activity_instance_common
// Params 3, eflags: 0x4
// Checksum 0xc041aeb4, Offset: 0x37e2
// Size: 0x94
function private function_68934289d7dda6cd( activityinstance, player, firsttimeinzone )
{
    playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
    activityinstance.var_aef199e9dadf99c2[ playerguid ] = 1;
    relevantinfostruct = spawnstruct();
    relevantinfostruct.playerlist = [ player ];
    relevantinfostruct.firsttimeinzone = firsttimeinzone;
    announceactivitymoment( activityinstance, "PlayerEnteredAwarenessZone", relevantinfostruct );
}

// Namespace activity_instance_common
// Params 2, eflags: 0x4
// Checksum 0x98b053ed, Offset: 0x387e
// Size: 0x7a
function private function_7484adb72ab4051( activityinstance, player )
{
    playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
    activityinstance.var_aef199e9dadf99c2[ playerguid ] = undefined;
    relevantinfostruct = spawnstruct();
    relevantinfostruct.playerlist = [ player ];
    announceactivitymoment( activityinstance, "PlayerExitedAwarenessZone", relevantinfostruct );
}

// Namespace activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0x2157aed3, Offset: 0x3900
// Size: 0x6b
function private function_d29621748837696c( relevantinfostruct )
{
    activityinstance = self;
    instid = activityinstance.id;
    
    if ( relevantinfostruct.activitymoment == "ActivityStartedHibernation" )
    {
        activity_common::function_15af4039c83423a6( activityinstance );
        return;
    }
    
    if ( relevantinfostruct.activitymoment == "ActivityStoppedHibernating" )
    {
        activity_common::function_d630366b03a83c40( activityinstance );
    }
}

// Namespace activity_instance_common
// Params 2, eflags: 0x4
// Checksum 0x31908a6b, Offset: 0x3973
// Size: 0x1cb
function private function_42cf6c6bc3841826( activityinstance, var_1add81fc387f85de )
{
    activityinstance endon( #"instance_destroyed" );
    activityinstance endon( #"hash_cd359b944e88899d" );
    playerfov = var_1add81fc387f85de.fov;
    checkradius = var_1add81fc387f85de.checkradius;
    fromstate = var_1add81fc387f85de.fromstate;
    tostate = var_1add81fc387f85de.tostate;
    loggingreasonstring = "";
    
    /#
        loggingreasonstring = "<dev string:xc50>";
    #/
    
    fov_cos = cos( playerfov );
    var_1ef6a17d80fae135 = 5;
    
    while ( true )
    {
        center_point = function_776ee11e7acc64a5( activityinstance );
        var_6ed2a31e1a58d5d6 = 0;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || !utility::playerwithindistance( player, center_point, checkradius ) )
            {
                continue;
            }
            
            eye_origin = player geteye();
            is_in_fov = utility::within_fov( eye_origin, player getplayerangles(), center_point, fov_cos );
            
            if ( is_in_fov )
            {
                function_1ffae83696c2a693( activityinstance, fromstate, tostate, "Player FOV Blocker", loggingreasonstring );
                var_6ed2a31e1a58d5d6 = 1;
                break;
            }
        }
        
        if ( !var_6ed2a31e1a58d5d6 )
        {
            function_9058619c6b87dc5e( activityinstance, "Player FOV Blocker", loggingreasonstring );
        }
        
        wait var_1ef6a17d80fae135;
    }
}

// Namespace activity_instance_common
// Params 0, eflags: 0x4
// Checksum 0x16520563, Offset: 0x3b46
// Size: 0x21
function private function_7a436c0e565eb010()
{
    level endon( #"game_ended" );
    utility::flag_wait( "spatial_zone_container_init_complete" );
    spatial_zone_container::function_78d783cad237664e();
}

