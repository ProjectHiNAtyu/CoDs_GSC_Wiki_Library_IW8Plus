// scripts\common\activity_nexus\activity_definition_utils.gsc  (hash_0f01501ac138f999.gscc) (size: 36230 Bytes / 0x8d86 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x787a2dde (2021273054)
// size ...... 36230 (0x8d86)
// includes .. 12  (offset: 0x872a)
// strings ... 85  (offset: 0x878a)
// dev strs .. 22  (offset: 0x8c52)
// exports ... 122 (offset: 0x61ae)
// cseg ...... 0xd44 + 0x546a (0x61ae)
// imports ... 132 (offset: 0x74be)
// animtree1 . 0   (offset: 0x8d86)
// animtree2 . 0   (offset: 0x8d86)
#using script_4e1f1a7ef824ddd5;
#using script_570f992e202c79b4;
#using script_77873e194e406c6d;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\activity_nexus\activity_ui;
#using scripts\common\create_script_utility;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;

#namespace activity_definition_utils;

// Namespace activity_definition_utils
// Params 0, eflags: 0x5
// Checksum 0x4b0d9baf, Offset: 0xd62
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_75ef1c018bda9ead", #"activity_common", &function_1a71808721b05e55, undefined );
}

// Namespace activity_definition_utils
// Params 0, eflags: 0x4
// Checksum 0x22966948, Offset: 0xd8b
// Size: 0x2d
function private function_1a71808721b05e55()
{
    /#
        if ( level.activities.activitynexussettings.var_d8571361f6b82809 )
        {
            level thread function_75c8b4b86793e887();
        }
    #/
}

/#

    // Namespace activity_definition_utils
    // Params 0, eflags: 0x4
    // Checksum 0xd4b098ed, Offset: 0xdc0
    // Size: 0x14b, Type: dev
    function private function_75c8b4b86793e887()
    {
        while ( true )
        {
            level waittill( #"hash_7e967560bc92fa01", var_facf97ba9e42d82d );
            
            if ( var_facf97ba9e42d82d.asset_type != "<dev string:x24>" )
            {
                continue;
            }
            
            if ( !level.activities.var_d3b2bc276f3a2973 namespace_4d597cbac7f48986::function_5c0524b11019fac5( var_facf97ba9e42d82d.asset_name ) )
            {
                continue;
            }
            
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x37>" + var_facf97ba9e42d82d.asset_name + "<dev string:x71>", @"hash_72a413c7683cfc8d" );
            level.activities.var_d3b2bc276f3a2973 namespace_4d597cbac7f48986::removefromcache( var_facf97ba9e42d82d.asset_name );
            level.activities.var_a4a513e0fe075256 namespace_4d597cbac7f48986::removefromcache( var_facf97ba9e42d82d.asset_name );
            activityvariantdefinition = { #associatedscriptbundlename:var_facf97ba9e42d82d.asset_name, #isactivitydefinition:1 };
            activitydefinitionscriptbundle = function_46ffa9802d35187a( var_facf97ba9e42d82d.asset_name, activityvariantdefinition );
            level.activities.var_ecd90a9fee3dfb36[ var_facf97ba9e42d82d.asset_name ] = activitydefinitionscriptbundle.customproperties;
        }
    }

#/

// Namespace activity_definition_utils
// Params 0
// Checksum 0xd61c01b2, Offset: 0xf13
// Size: 0x10
function function_39e63e1ba6bb0132()
{
    function_6bd660c7f44c1f4d();
    function_8e61e0c482c0d59e();
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0xf79c8188, Offset: 0xf2b
// Size: 0x1f9
function function_74af1ab4059e3c06( associatedscriptbundlename, activityvariant )
{
    if ( isdefined( level.activities.definitions[ activityvariant ] ) )
    {
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x9a>" + activityvariant + "<dev string:xa5>", @"hash_72a413c7683cfc8d" );
        #/
        
        return getactivitydefinition( activityvariant );
    }
    
    if ( !isxhashasset( associatedscriptbundlename ) )
    {
        var_9955f93e8f3e6b37 = strtok( associatedscriptbundlename, ":" );
        
        if ( var_9955f93e8f3e6b37.size == 1 )
        {
            associatedscriptbundlename = "activitydefinition:" + associatedscriptbundlename;
        }
        
        associatedscriptbundlename = getxhashasset( associatedscriptbundlename );
    }
    
    activityvariantdefinition = { #associatedscriptbundlename:associatedscriptbundlename, #isactivitydefinition:1 };
    activitydefinitionscriptbundle = function_46ffa9802d35187a( associatedscriptbundlename, activityvariantdefinition );
    activitycategory = function_897014a17bf1cbdc( activitydefinitionscriptbundle );
    activitytype = function_39e5d416275f6445( activitydefinitionscriptbundle );
    
    if ( !activity_common::isactivityenabled( activitycategory, activitytype, activityvariant ) )
    {
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x9a>" + activitytype + "<dev string:xe6>" + activityvariant + "<dev string:xea>", @"hash_72a413c7683cfc8d" );
        #/
        
        return;
    }
    
    if ( !isdefined( level.activities.definitions[ activityvariant ] ) )
    {
        if ( !isdefined( level.activities.var_ecd90a9fee3dfb36[ associatedscriptbundlename ] ) )
        {
            level.activities.var_ecd90a9fee3dfb36[ associatedscriptbundlename ] = activitydefinitionscriptbundle.customproperties;
        }
        
        level.activities.definitions[ activityvariant ] = activityvariantdefinition;
        utility::flag_set( "activity_nexus_definition_registered" );
        
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x146>" + activityvariant + "<dev string:x159>", @"hash_72a413c7683cfc8d" );
            
            if ( isdefined( level.activities.var_e19a335333e508fd ) )
            {
                [[ level.activities.var_e19a335333e508fd ]]( activityvariant, activityvariantdefinition );
            }
        #/
    }
    
    return getactivitydefinition( activityvariant );
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0xb439c8fe, Offset: 0x112d
// Size: 0xbc
function function_6bd660c7f44c1f4d( var_6a7a7b3aaf420352 = 1, var_be199bb9e036b40b = undefined )
{
    foreach ( var_29e064d5673991a8 in level.activities.var_520f9c52039bc4a1 )
    {
        function_664cf0573acf7598( var_29e064d5673991a8.var_612e0b25b87384b9, var_6a7a7b3aaf420352, var_be199bb9e036b40b );
    }
    
    activity_common::function_fa76765b37c0370d();
}

// Namespace activity_definition_utils
// Params 3
// Checksum 0xd68ab39d, Offset: 0x11f1
// Size: 0x20e
function function_664cf0573acf7598( var_70b71038e3e18d26, var_6a7a7b3aaf420352 = 1, var_be199bb9e036b40b = undefined )
{
    utility::production_map_assert( isfunction( var_70b71038e3e18d26 ), "The Create Script 'GetInfo' function passed in is either undefined or not a function." );
    var_bffb2dadef9b5a4d = [[ var_70b71038e3e18d26 ]]();
    utility::production_map_assert( isfunction( var_bffb2dadef9b5a4d.metadatafunction ), "The Create Script 'getActivityInstanceMetaData' function passed is undefined or invalid." );
    var_67fe8b19a4d54144 = [[ var_bffb2dadef9b5a4d.metadatafunction ]]();
    
    if ( !isdefined( var_be199bb9e036b40b ) )
    {
        var_be199bb9e036b40b = [];
    }
    
    if ( var_6a7a7b3aaf420352 && isfunction( var_bffb2dadef9b5a4d.mainfunction ) )
    {
        [[ var_bffb2dadef9b5a4d.mainfunction ]]();
    }
    
    activitynexussettings = level.activities.activitynexussettings;
    
    foreach ( activityvariantname, variantmetadata in var_67fe8b19a4d54144 )
    {
        var_1f17725d59f6006a = function_f02c63b99c9614c9( var_be199bb9e036b40b, activityvariantname );
        var_f316b60501957d74 = !isdefined( var_1f17725d59f6006a );
        
        if ( var_f316b60501957d74 && !isdefined( level.activities.definitions[ activityvariantname ] ) )
        {
            function_894aafedf7770c7b( activityvariantname, var_67fe8b19a4d54144, var_bffb2dadef9b5a4d );
            
            if ( !activitynexussettings.var_df9dd732e8ef4771 )
            {
                struct = spawnstruct();
                [[ var_bffb2dadef9b5a4d.var_934f068483ae4ddb ]]( activityvariantname, struct, activityvariantname );
            }
            
            continue;
        }
        
        /#
            if ( isdefined( level.activities.definitions[ activityvariantname ] ) )
            {
                namespace_634561435cfb3169::activitynexuslog( "<dev string:x9a>" + activityvariantname + "<dev string:xa5>", @"hash_72a413c7683cfc8d" );
                continue;
            }
            
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x9a>" + activityvariantname + "<dev string:x194>", @"hash_72a413c7683cfc8d" );
        #/
    }
}

// Namespace activity_definition_utils
// Params 3
// Checksum 0xf5b719ec, Offset: 0x1407
// Size: 0xc0
function function_894aafedf7770c7b( activityvariantname, var_67fe8b19a4d54144, var_bffb2dadef9b5a4d )
{
    scriptbundlename = function_608e492974320c76( activityvariantname, var_67fe8b19a4d54144, var_bffb2dadef9b5a4d );
    variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( activityvariantname );
    
    if ( isdefined( scriptbundlename ) && variantscriptstructinfo.variantstruct.var_2cfd453d1fc7102c != "1" )
    {
        activitydefinition = function_74af1ab4059e3c06( scriptbundlename, activityvariantname );
        
        if ( isdefined( activitydefinition ) )
        {
            activitydefinition.var_fb5459d9e8df3630 = 1;
            activitydefinition.var_282249d8b7ee5bc5 = var_bffb2dadef9b5a4d.var_934f068483ae4ddb;
            activitydefinition.var_49b766acb5226cde = var_bffb2dadef9b5a4d.metadatafunction;
        }
    }
}

// Namespace activity_definition_utils
// Params 3
// Checksum 0xfbd59753, Offset: 0x14cf
// Size: 0x104
function function_608e492974320c76( activityvariantname, var_67fe8b19a4d54144, var_bffb2dadef9b5a4d )
{
    activitydefinitionbundlename = undefined;
    var_6a1b5d581429fafd = var_67fe8b19a4d54144[ activityvariantname ];
    
    if ( !isdefined( var_6a1b5d581429fafd ) )
    {
        return function_ebeacac960b1bd3e( activityvariantname );
    }
    
    if ( isdefined( var_6a1b5d581429fafd.scriptbundle ) && var_6a1b5d581429fafd.scriptbundle != "" )
    {
        activitydefinitionbundlename = var_6a1b5d581429fafd.scriptbundle;
    }
    else if ( isdefined( var_6a1b5d581429fafd.parentvariant ) )
    {
        return function_608e492974320c76( var_6a1b5d581429fafd.parentvariant, var_67fe8b19a4d54144, var_bffb2dadef9b5a4d );
    }
    
    if ( !isdefined( activitydefinitionbundlename ) && isdefined( var_bffb2dadef9b5a4d.scriptbundle ) && var_bffb2dadef9b5a4d.scriptbundle != "" )
    {
        activitydefinitionbundlename = var_bffb2dadef9b5a4d.scriptbundle;
    }
    
    var_9955f93e8f3e6b37 = strtok( activitydefinitionbundlename, ":" );
    
    if ( var_9955f93e8f3e6b37.size == 1 )
    {
        activitydefinitionbundlename = "activitydefinition:" + activitydefinitionbundlename;
    }
    
    return activitydefinitionbundlename;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x96f00bdd, Offset: 0x15dc
// Size: 0x109
function function_2c1f6f3cc3322582( var_7605e6a744ed0ba0 )
{
    activityvariantstructs = level.activities.var_dd80223f1900e086;
    
    foreach ( activityvariantstruct in activityvariantstructs )
    {
        if ( isdefined( activityvariantstruct.variantstruct.activity_bundle ) && activityvariantstruct.variantstruct.activity_bundle != "" )
        {
            activityvariantname = activityvariantstruct.variantstruct.name;
            var_f316b60501957d74 = isdefined( function_f02c63b99c9614c9( var_7605e6a744ed0ba0, activityvariantname ) );
            
            if ( var_f316b60501957d74 )
            {
                function_d6e5b263d3ada8d5( activityvariantstruct );
            }
        }
    }
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xb8683530, Offset: 0x16ed
// Size: 0x119
function function_8e61e0c482c0d59e( var_4ff2ea7f120f6246 )
{
    activity_common::function_fa76765b37c0370d();
    
    if ( !isdefined( var_4ff2ea7f120f6246 ) )
    {
        var_4ff2ea7f120f6246 = [];
    }
    
    activityvariantstructs = level.activities.var_dd80223f1900e086;
    
    foreach ( activityvariantstruct in activityvariantstructs )
    {
        if ( isdefined( activityvariantstruct.variantstruct.activity_bundle ) && activityvariantstruct.variantstruct.activity_bundle != "" )
        {
            activityvariantname = activityvariantstruct.variantstruct.name;
            var_b92299b8f181b6b6 = isdefined( function_f02c63b99c9614c9( var_4ff2ea7f120f6246, activityvariantname ) );
            
            if ( !var_b92299b8f181b6b6 )
            {
                function_d6e5b263d3ada8d5( activityvariantstruct );
            }
        }
    }
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xc52d7c1d, Offset: 0x180e
// Size: 0x6b
function function_9937227c287fd481( activityinstance )
{
    activitydefinition = function_837a0c8626c9b419( activityinstance );
    
    if ( isdefined( activitydefinition.var_49b766acb5226cde ) )
    {
        function_3c7069402fa2172e( activityinstance, activitydefinition.var_49b766acb5226cde );
    }
    
    function_ae58efce66efaf8d( activityinstance );
    activityvariantname = activityinstance.varianttag;
    function_46f5af01b35899df( activityvariantname, activityinstance );
}

// Namespace activity_definition_utils
// Params 3
// Checksum 0xee33bdf5, Offset: 0x1881
// Size: 0x24b
function function_46f5af01b35899df( activityvariantname, spatialzonecontainer, specificzonename )
{
    for ( variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( activityvariantname ); isdefined( variantscriptstructinfo ) ; variantscriptstructinfo = undefined )
    {
        variantstruct = variantscriptstructinfo.variantstruct;
        
        if ( isdefined( variantstruct.origin ) && spatial_zone_container::function_3819f09eefb741e2( spatialzonecontainer, "Center_Spatial_Zone" ) == 0 )
        {
            spatial_zone_container::function_847140d2863dfbf8( spatialzonecontainer, "Center_Spatial_Zone", variantstruct.origin );
        }
        
        linkedstructs = variantscriptstructinfo.linkedstructs;
        
        foreach ( linkedstruct in linkedstructs )
        {
            var_e473840ecda32a60 = ( linkedstruct.targetname === "activity_nexus_spatial_zone" || linkedstruct.activity_type_key === "activity_nexus_spatial_zone" ) && isstring( linkedstruct.script_noteworthy ) && linkedstruct.script_noteworthy != "";
            
            if ( var_e473840ecda32a60 )
            {
                if ( isdefined( specificzonename ) && linkedstruct.script_noteworthy != specificzonename )
                {
                    continue;
                }
                
                zoneinfostruct = function_85ef28a4069ec23f( spatialzonecontainer, linkedstruct.script_noteworthy );
                ignoreheight = zoneinfostruct.ignoreheightvalue == 1;
                spatial_zone_container::function_847140d2863dfbf8( spatialzonecontainer, linkedstruct.script_noteworthy, linkedstruct.origin, linkedstruct.radius, ignoreheight );
                
                if ( activity_instance_common::isactivityinstance( spatialzonecontainer ) && zoneinfostruct.var_35f4d21e238902eb == 1 )
                {
                    spatial_zone_container::function_3edbf3270263b31b( spatialzonecontainer, linkedstruct.script_noteworthy, &activity_instance_common::function_776ee11e7acc64a5, [ spatialzonecontainer ] );
                }
            }
        }
        
        parentactivityvariantname = variantstruct.parent;
        
        if ( isstring( parentactivityvariantname ) )
        {
            variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( parentactivityvariantname );
            continue;
        }
    }
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x16ed8543, Offset: 0x1ad4
// Size: 0x42
function getactivitydefinition( varianttag )
{
    activitydef = level.activities.definitions[ varianttag ];
    utility::production_map_assert( isdefined( activitydef ), "The activity definition being retrieved is undefined. Activity Variant Tag:" + varianttag );
    return activitydef;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x89ca3b03, Offset: 0x1b1f
// Size: 0xca
function function_326a5e04c9b438f5( activitytype )
{
    activitydefinitionlist = [];
    utility::production_map_assert( isdefined( level.activities.types[ activitytype ] ), "Activity type has not been registered yet." );
    
    foreach ( activityvariantname, activitydefinition in level.activities.definitions )
    {
        if ( function_39e5d416275f6445( activitydefinition ) == activitytype )
        {
            activitydefinitionlist[ activityvariantname ] = activitydefinition;
        }
    }
    
    return activitydefinitionlist;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x8da846f6, Offset: 0x1bf2
// Size: 0xcb
function function_d795f5e961e88824( activitytype )
{
    var_f1809456dfd99830 = [];
    utility::production_map_assert( isdefined( level.activities.types[ activitytype ] ), "Activity type has not been registered yet." );
    
    foreach ( activityvariantname, activitydefinition in level.activities.definitions )
    {
        if ( function_39e5d416275f6445( activitydefinition ) == activitytype )
        {
            var_f1809456dfd99830[ var_f1809456dfd99830.size ] = activityvariantname;
        }
    }
    
    return var_f1809456dfd99830;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x94306610, Offset: 0x1cc6
// Size: 0x47
function function_837a0c8626c9b419( activityinstance = self )
{
    utility::production_map_assert( activity_instance_common::isactivityinstance( activityinstance ), "This function requires that an Activity Instance struct is either passed in as an argument or is 'self.' Neither are true in this case." );
    return getactivitydefinition( activityinstance.activitydefinitiontag ?? activityinstance.varianttag );
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x65d52afd, Offset: 0x1d16
// Size: 0x2b
function private function_39e5d416275f6445( var_e0bbf417e9178e6 )
{
    customproperties = function_9129cd8075c85c09( var_e0bbf417e9178e6 );
    return customproperties.activitytype;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xd4afbeff, Offset: 0x1d4a
// Size: 0x6c
function function_897014a17bf1cbdc( var_e0bbf417e9178e6 )
{
    activitycustomproperties = function_7519b3cb84aa1601( var_e0bbf417e9178e6 );
    
    if ( isdefined( activitycustomproperties.activitytypegroup[ 0 ].variant_object.activitycategory ) )
    {
        return activitycustomproperties.activitytypegroup[ 0 ].variant_object.activitycategory;
    }
    
    return "None";
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0x11790c66, Offset: 0x1dbf
// Size: 0x152
function function_ac11e0fa8d55a478( var_e0bbf417e9178e6, abandontriggertype )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    var_e8daac372dd15d10 = var_310e111620b410d7.var_fb4dd0352a7b7099.playerabandonsettings;
    var_241f820ed67e94be = var_310e111620b410d7.var_fb4dd0352a7b7099.playerabandontriggers;
    var_6178a1328dfaef88 = undefined;
    
    if ( abandontriggertype == 0 )
    {
        if ( isdefined( var_e8daac372dd15d10.var_284b29f91b257f2d ) && var_e8daac372dd15d10.var_284b29f91b257f2d.size > 0 )
        {
            var_6178a1328dfaef88 = var_e8daac372dd15d10.var_284b29f91b257f2d;
        }
        else
        {
            var_6178a1328dfaef88 = var_241f820ed67e94be.var_5363846658bb4e31;
        }
    }
    else if ( abandontriggertype == 1 )
    {
        if ( isdefined( var_e8daac372dd15d10.var_f1ed5c4b2cbcfb6d ) && var_e8daac372dd15d10.var_f1ed5c4b2cbcfb6d.size > 0 )
        {
            var_6178a1328dfaef88 = var_e8daac372dd15d10.var_f1ed5c4b2cbcfb6d;
        }
        else
        {
            var_6178a1328dfaef88 = var_241f820ed67e94be.var_b66328fcefdc5a0a;
        }
    }
    else if ( abandontriggertype == 2 )
    {
        var_6178a1328dfaef88 = var_241f820ed67e94be.var_75ecd3e9f8da3e2e;
    }
    else if ( abandontriggertype == 3 )
    {
        var_6178a1328dfaef88 = var_241f820ed67e94be.var_f393956a4ef608b5;
    }
    
    /#
        if ( !isdefined( var_6178a1328dfaef88 ) )
        {
            utility::production_map_assert( 0, "<dev string:x22f>" + abandontriggertype + "<dev string:x246>" );
        }
    #/
    
    return var_6178a1328dfaef88;
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0x930ad17b, Offset: 0x1f1a
// Size: 0x62, Type: bool
function function_65a59cc724e4ec89( var_e0bbf417e9178e6, abandontriggertype )
{
    var_6178a1328dfaef88 = function_ac11e0fa8d55a478( var_e0bbf417e9178e6, abandontriggertype );
    
    if ( isarray( var_6178a1328dfaef88 ) && var_6178a1328dfaef88.size == 1 )
    {
        return istrue( var_6178a1328dfaef88[ 0 ].variant_object.var_2aed9f2a24e6ec3e );
    }
    
    return istrue( var_6178a1328dfaef88.isenabled );
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0xe6e44e9f, Offset: 0x1f85
// Size: 0x65, Type: bool
function function_868c1e057e9368da( var_e0bbf417e9178e6, abandontriggertype )
{
    var_6178a1328dfaef88 = function_ac11e0fa8d55a478( var_e0bbf417e9178e6, abandontriggertype );
    
    if ( isarray( var_6178a1328dfaef88 ) && var_6178a1328dfaef88.size == 1 )
    {
        return istrue( var_6178a1328dfaef88[ 0 ].variant_object.var_a55cbf84d5f69650 );
    }
    
    return var_6178a1328dfaef88.var_79b007c16dba1689 ?? 0;
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0x1f5c47fd, Offset: 0x1ff3
// Size: 0x66, Type: bool
function function_dcdc4984a7c518e9( var_e0bbf417e9178e6, abandontriggertype )
{
    var_6178a1328dfaef88 = function_ac11e0fa8d55a478( var_e0bbf417e9178e6, abandontriggertype );
    
    if ( isarray( var_6178a1328dfaef88 ) && var_6178a1328dfaef88.size == 1 )
    {
        return istrue( var_6178a1328dfaef88[ 0 ].variant_object.var_ef8d9e5ff2915aa6 );
    }
    
    return var_6178a1328dfaef88.broadcastenabled ?? 1;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x7f2e2352, Offset: 0x2062
// Size: 0x96
function function_9129cd8075c85c09( var_e0bbf417e9178e6 )
{
    activitycustomproperties = function_7519b3cb84aa1601( var_e0bbf417e9178e6 );
    
    if ( isdefined( activitycustomproperties ) && isdefined( activitycustomproperties.activitytypegroup ) && activitycustomproperties.activitytypegroup.size > 0 )
    {
        var_2fdf266ead510f82 = activitycustomproperties.activitytypegroup[ 0 ].variant_object.var_2fdf266ead510f82;
        
        if ( isdefined( var_2fdf266ead510f82 ) )
        {
            return var_2fdf266ead510f82[ 0 ].variant_object;
        }
    }
    
    /#
        utility::production_map_assert( 0, "<dev string:x266>" );
    #/
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x5ae0fbe1, Offset: 0x2101
// Size: 0xa1
function function_13b825099ff661e( activityinstance )
{
    activityvariantdefinition = activityinstance function_837a0c8626c9b419();
    var_f2d9e7c8174d06a3 = function_d32fa66f2924c90d( activityvariantdefinition );
    
    if ( isdefined( var_f2d9e7c8174d06a3 ) )
    {
        var_e2de1e5756b8675d = getscriptbundle( var_f2d9e7c8174d06a3 );
        
        if ( isdefined( var_e2de1e5756b8675d ) )
        {
            activityinstance.var_641e35580847346e = function_43b5ed5a14a56573( #"scriptbundle_uiactivityinfo", var_f2d9e7c8174d06a3 );
            
            if ( isdefined( activityinstance.var_641e35580847346e ) )
            {
                function_136ef61241bb5c46( activityinstance.var_641e35580847346e, self, { #players:[] } );
                self.var_f9892c97568a5184 = 1;
            }
        }
    }
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0x38383969, Offset: 0x21aa
// Size: 0x43
function function_f63a19539743efa6( activityinstance, var_923bcd5ca69db028 )
{
    if ( var_923bcd5ca69db028 && activityinstance )
    {
        function_136ef61241bb5c46( var_923bcd5ca69db028, self, { #players:[] } );
        activityinstance.var_f9892c97568a5184 = 1;
    }
}

// Namespace activity_definition_utils
// Params 4
// Checksum 0xa7d1c9ba, Offset: 0x21f5
// Size: 0x5e
function function_f23bdcfc447427ae( playerlist, startingprogress, maxprogress, rewardamount = -1 )
{
    updateprogress( startingprogress, self, maxprogress, { #players:playerlist } );
    updatereward( rewardamount, self, { #players:playerlist } );
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0x9ce36d54, Offset: 0x225b
// Size: 0x2c
function function_4978eb24baa84155( activityinstance, players )
{
    function_136ef61241bb5c46( -1, activityinstance, { #players:players } );
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0xe1f68bde, Offset: 0x228f
// Size: 0x44
function function_798b996657602cd2( activityinstance, players )
{
    if ( isdefined( activityinstance.var_641e35580847346e ) )
    {
        function_136ef61241bb5c46( activityinstance.var_641e35580847346e, activityinstance, { #players:players } );
    }
}

// Namespace activity_definition_utils
// Params 3
// Checksum 0xdaee037f, Offset: 0x22db
// Size: 0xa3
function updatetimer( var_60b6fd3cb8075d10, activityinstance, optionalparameters )
{
    if ( !isdefined( var_60b6fd3cb8075d10 ) )
    {
        return;
    }
    
    if ( !activity_instance_common::isactivityinstance( activityinstance ) )
    {
        utility::production_map_assert( 0, "updateTimerForPlayers: no valid activity instance specified" );
        return;
    }
    
    var_8aed4c80d7354bc2 = 0;
    
    if ( var_60b6fd3cb8075d10 != 0 )
    {
        var_8aed4c80d7354bc2 = int( max( 0, gettime() + var_60b6fd3cb8075d10 * 1000 ) );
    }
    
    if ( !isdefined( optionalparameters ) )
    {
        optionalparameters = {};
    }
    
    optionalparameters.var_70ceaa17995f7807 = 0;
    optionalparameters.players = activityinstance function_9a67de09579cf0a2();
    function_1c90859b607a24a2( "ui_activity_end_time", var_8aed4c80d7354bc2, activityinstance, optionalparameters );
}

// Namespace activity_definition_utils
// Params 4
// Checksum 0x15142ef3, Offset: 0x2386
// Size: 0xd1
function updateprogress( currentprogress, activityinstance, maxprogress, optionalparameters )
{
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
    
    if ( !isdefined( optionalparameters.players ) )
    {
        optionalparameters.players = activityinstance function_9a67de09579cf0a2();
    }
    
    if ( isdefined( currentprogress ) )
    {
        if ( !isdefined( optionalparameters ) )
        {
            optionalparameters = {};
        }
        
        optionalparameters.var_70ceaa17995f7807 = 0;
        function_1c90859b607a24a2( "ui_activity_progress", currentprogress, activityinstance, optionalparameters );
    }
    
    if ( isdefined( maxprogress ) )
    {
        if ( !isdefined( optionalparameters ) )
        {
            optionalparameters = {};
        }
        
        optionalparameters.var_70ceaa17995f7807 = 0;
        function_1c90859b607a24a2( "ui_activity_progress_max", maxprogress, activityinstance, optionalparameters );
    }
}

// Namespace activity_definition_utils
// Params 3
// Checksum 0x6435f231, Offset: 0x245f
// Size: 0x9a
function function_a0a94881bc380bbf( stepindex, activityinstance, optionalparameters )
{
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
        optionalparameters.players = activityinstance function_9a67de09579cf0a2();
    }
    
    optionalparameters.var_70ceaa17995f7807 = 0;
    function_1c90859b607a24a2( "ui_activity_step_index", stepindex ?? 0, activityinstance, optionalparameters );
    return 1;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xea0e5eb9, Offset: 0x2502
// Size: 0x41
function function_563df3652cd3d9c4( activityinstance )
{
    if ( !activity_instance_common::isactivityinstance( activityinstance ) )
    {
        utility::production_map_assert( 0, "updateStepIndex: no valid activity instance specified" );
        return;
    }
    
    storedomnvarvalue = activity_instance_common::function_cbd9eccae7248167( activityinstance, "ui_activity_step_index" );
    return storedomnvarvalue;
}

// Namespace activity_definition_utils
// Params 3
// Checksum 0x381b1d12, Offset: 0x254c
// Size: 0x9a
function function_16b3cfd89a1669f7( state, activityinstance, optionalparameters )
{
    if ( !isdefined( state ) )
    {
        utility::production_map_assert( 0, "updateActivityState : state is invalid!" );
        return;
    }
    
    if ( !activity_instance_common::isactivityinstance( activityinstance ) )
    {
        utility::production_map_assert( 0, "updateActivityState: no valid activity instance specified" );
        return;
    }
    
    if ( !isdefined( optionalparameters ) )
    {
        optionalparameters = {};
    }
    
    if ( !isdefined( optionalparameters.players ) )
    {
        optionalparameters.players = activityinstance function_9a67de09579cf0a2();
    }
    
    optionalparameters.var_70ceaa17995f7807 = 0;
    function_1c90859b607a24a2( "ui_activity_state", state ?? 0, activityinstance, optionalparameters );
    return 1;
}

// Namespace activity_definition_utils
// Params 3
// Checksum 0xd74846bd, Offset: 0x25ef
// Size: 0x97
function function_63ba9cba37249190( descparam, activityinstance, optionalparameters )
{
    if ( !isdefined( descparam ) )
    {
        utility::production_map_assert( 0, "UpdateActivityDescParam : descParam is invalid!" );
        return;
    }
    
    if ( !activity_instance_common::isactivityinstance( activityinstance ) )
    {
        utility::production_map_assert( 0, "UpdateActivityDescParam: no valid activity instance specified" );
        return;
    }
    
    if ( !isdefined( optionalparameters ) )
    {
        optionalparameters = {};
    }
    
    if ( !isdefined( optionalparameters.players ) )
    {
        optionalparameters.players = activityinstance function_9a67de09579cf0a2();
    }
    
    optionalparameters.var_70ceaa17995f7807 = -1;
    function_1c90859b607a24a2( "ui_activity_description_param", descparam, activityinstance, optionalparameters );
    return 1;
}

// Namespace activity_definition_utils
// Params 0
// Checksum 0xa67b6d3a, Offset: 0x268f
// Size: 0x10e
function function_9a67de09579cf0a2()
{
    activityinstance = self;
    
    if ( !activity_instance_common::isactivityinstance( activityinstance ) )
    {
        utility::production_map_assert( 0, "getActivityFocusedPlayers: no valid activity instance specified" );
        return;
    }
    
    players = activityinstance.playerparticipants;
    focusedplayers = [];
    activityinstanceid = activityinstance.id;
    
    foreach ( player in players )
    {
        var_71c9481d44c7260c = namespace_e55955ff7520be97::function_e811448130016c90( player );
        var_8edab14b17925e81 = var_71c9481d44c7260c.id;
        
        if ( player.var_e0d9496db5b74827 == activityinstanceid || var_8edab14b17925e81 == activityinstanceid )
        {
            focusedplayers[ focusedplayers.size ] = player;
        }
    }
    
    return focusedplayers;
}

// Namespace activity_definition_utils
// Params 3
// Checksum 0xc85fc45d, Offset: 0x27a6
// Size: 0x79
function updatereward( rewardamount, activityinstance, optionalparameters )
{
    if ( !isdefined( rewardamount ) )
    {
        return;
    }
    
    if ( !activity_instance_common::isactivityinstance( activityinstance ) )
    {
        utility::production_map_assert( 0, "updateRewardForPlayers: no valid activity instance specified" );
        return;
    }
    
    if ( !isdefined( optionalparameters ) )
    {
        optionalparameters = {};
    }
    
    optionalparameters.var_70ceaa17995f7807 = 0;
    optionalparameters.players = activityinstance function_9a67de09579cf0a2();
    function_1c90859b607a24a2( "ui_activity_reward_amount", rewardamount, activityinstance, optionalparameters );
}

// Namespace activity_definition_utils
// Params 3, eflags: 0x4
// Checksum 0x80052b84, Offset: 0x2827
// Size: 0x66
function private function_136ef61241bb5c46( index, activityinstance, optionalparameters )
{
    if ( !isdefined( index ) )
    {
        return;
    }
    
    if ( !activity_instance_common::isactivityinstance( activityinstance ) )
    {
        utility::production_map_assert( 0, "updateActivityIndexForPlayers: no valid activity instance specified" );
        return;
    }
    
    if ( !isdefined( optionalparameters ) )
    {
        optionalparameters = {};
    }
    
    optionalparameters.var_70ceaa17995f7807 = -1;
    function_1c90859b607a24a2( "ui_activity_index", index, activityinstance, optionalparameters );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xcb5b13a5, Offset: 0x2895
// Size: 0x18, Type: bool
function function_a0de4120bd59665( activityinstance )
{
    return !activityinstance.var_f9892c97568a5184;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x96b2d096, Offset: 0x28b6
// Size: 0x16a
function function_f3faf60f17dfa84e( player )
{
    var_e5001cec409fcb5c = namespace_e55955ff7520be97::function_4d91a4618b9a4e05( player, &function_a0de4120bd59665 );
    var_10ae9c5b1a4aa3d1 = var_e5001cec409fcb5c.id;
    var_71c9481d44c7260c = namespace_e55955ff7520be97::function_e811448130016c90( player );
    var_8edab14b17925e81 = var_71c9481d44c7260c.id;
    
    if ( var_10ae9c5b1a4aa3d1 === var_8edab14b17925e81 )
    {
        var_10ae9c5b1a4aa3d1 = undefined;
    }
    
    if ( player.var_e0d9496db5b74827 === var_8edab14b17925e81 )
    {
        player.var_e0d9496db5b74827 = undefined;
    }
    
    if ( player.var_e0d9496db5b74827 === var_10ae9c5b1a4aa3d1 )
    {
        return;
    }
    
    if ( isdefined( player.var_e0d9496db5b74827 ) )
    {
        var_45978d8f0c4e57ac = level.activities.instances[ player.var_e0d9496db5b74827 ];
        var_45978d8f0c4e57ac activity_ui::function_9b636510b59558bf( [ player ] );
        player.var_e0d9496db5b74827 = undefined;
        relevantinfostruct = spawnstruct();
        relevantinfostruct.playerlist = [ player ];
        activity_instance_common::announceactivitymoment( var_45978d8f0c4e57ac, "PlayerLoseFocusedOnActivity", relevantinfostruct );
    }
    
    if ( isdefined( var_10ae9c5b1a4aa3d1 ) )
    {
        var_e5001cec409fcb5c activity_ui::function_14f2860d96cf2c0f( [ player ] );
        player.var_e0d9496db5b74827 = var_10ae9c5b1a4aa3d1;
        relevantinfostruct = spawnstruct();
        relevantinfostruct.playerlist = [ player ];
        activity_instance_common::announceactivitymoment( var_e5001cec409fcb5c, "PlayerFocusedOnActivity", relevantinfostruct );
    }
}

// Namespace activity_definition_utils
// Params 4, eflags: 0x4
// Checksum 0x4d9cb96, Offset: 0x2a28
// Size: 0x91
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
    
    var_70ceaa17995f7807 = optionalparameters.var_70ceaa17995f7807 ?? 0;
    namespace_e55955ff7520be97::function_674cca638cafcae3( players, activityinstance, omnvar, value, var_70ceaa17995f7807 );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x99d4952e, Offset: 0x2ac1
// Size: 0x65
function getminplayercount( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    
    if ( !isdefined( var_310e111620b410d7.var_fb4dd0352a7b7099.playerjoinsettings.minplayercount ) )
    {
        return 0;
    }
    
    return var_310e111620b410d7.var_fb4dd0352a7b7099.playerjoinsettings.minplayercount;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x7e621641, Offset: 0x2b2f
// Size: 0x72
function getmaxplayercount( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    
    if ( !isdefined( var_310e111620b410d7.var_fb4dd0352a7b7099.playerjoinsettings.maxplayercount ) )
    {
        utility::production_map_assert( 0, "An activity with a maximum player count of 0 doesn't make sense. Check to see if the ScriptBundle was setup properly" );
        return 0;
    }
    
    return var_310e111620b410d7.var_fb4dd0352a7b7099.playerjoinsettings.maxplayercount;
}

// Namespace activity_definition_utils
// Params 3
// Checksum 0x9cff9020, Offset: 0x2baa
// Size: 0x3b
function function_4745f33d7aa0a13( var_e0bbf417e9178e6, fromstate, tostate )
{
    var_94aa8ab04072fb77 = [];
    var_94aa8ab04072fb77 = function_621f97c4662893e( var_e0bbf417e9178e6, fromstate, tostate, var_94aa8ab04072fb77 );
    return var_94aa8ab04072fb77;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x7ac6d5ba, Offset: 0x2bee
// Size: 0x40, Type: bool
function function_3fd7ab2fbc0fbc72( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return istrue( var_310e111620b410d7.var_fb4dd0352a7b7099.playerjoinsettings.var_32f3cd5d6b5c65ca );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xddedc035, Offset: 0x2c37
// Size: 0x40, Type: bool
function function_78fa68ce3733accd( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return istrue( var_310e111620b410d7.var_fb4dd0352a7b7099.playerjoinsettings.var_c781cf9442a118d5 );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x93ece5d2, Offset: 0x2c80
// Size: 0x40, Type: bool
function function_a79b1feb5419d1ac( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return istrue( var_310e111620b410d7.var_fb4dd0352a7b7099.playerjoinsettings.var_98edc118b0c8a2e4 );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xca6900dc, Offset: 0x2cc9
// Size: 0x5f, Type: bool
function function_6e5624d15e574a2a( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    activitycategory = function_897014a17bf1cbdc( var_e0bbf417e9178e6 );
    
    if ( activitycategory == "None" )
    {
        return false;
    }
    
    return istrue( var_310e111620b410d7.var_fb4dd0352a7b7099.playerjoinsettings.var_a63bac43c15176f );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x1f3c6d09, Offset: 0x2d31
// Size: 0x65
function function_a20ffdf4fe1e295( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    var_d436933c01954baa = var_310e111620b410d7.var_b6b515a8f1cc711c[ 0 ].variant_object.var_a6cf6e2e0cc37ee5 ?? var_310e111620b410d7.var_34859f69d60856fc.var_a6cf6e2e0cc37ee5;
    return var_d436933c01954baa;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x666a8938, Offset: 0x2d9f
// Size: 0x9e
function function_2ec319b548dd67b9( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    var_c70c4775e79b63db = "ActivityBegin";
    var_fd3f0c6992254e06 = var_310e111620b410d7.var_b6b515a8f1cc711c[ 0 ].variant_object.var_bd83beebb26f08d6;
    
    if ( isdefined( var_fd3f0c6992254e06 ) && var_fd3f0c6992254e06.size > 0 )
    {
        var_c70c4775e79b63db = var_fd3f0c6992254e06[ 0 ].variant_object.activitymoment;
    }
    else
    {
        var_c70c4775e79b63db = var_310e111620b410d7.var_34859f69d60856fc.var_bd83beebb26f08d6;
    }
    
    return var_c70c4775e79b63db;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x7f967e8, Offset: 0x2e46
// Size: 0x9e
function function_73d42e405d0be3bc( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    var_e379888dc95d6cdc = "InstanceEnd";
    var_410aea93224f4921 = var_310e111620b410d7.var_b6b515a8f1cc711c[ 0 ].variant_object.var_5ba973ff6b5ff715;
    
    if ( isdefined( var_410aea93224f4921 ) && var_410aea93224f4921.size > 0 )
    {
        var_e379888dc95d6cdc = var_410aea93224f4921[ 0 ].variant_object.activitymoment;
    }
    else
    {
        var_e379888dc95d6cdc = var_310e111620b410d7.var_34859f69d60856fc.var_5ba973ff6b5ff715;
    }
    
    return var_e379888dc95d6cdc;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xada7d796, Offset: 0x2eed
// Size: 0x6a, Type: bool
function function_b6096963d0181099( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    var_d542216912fb199d = var_310e111620b410d7.var_b6b515a8f1cc711c[ 0 ].variant_object.stopspawningambientai;
    
    if ( !isdefined( var_d542216912fb199d ) )
    {
        var_d542216912fb199d = var_310e111620b410d7.var_34859f69d60856fc.var_ab92f6aad9f95732;
    }
    
    return istrue( var_d542216912fb199d );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xaa4cf72d, Offset: 0x2f60
// Size: 0x6a, Type: bool
function function_79a44503e178233f( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    despawnambients = var_310e111620b410d7.var_b6b515a8f1cc711c[ 0 ].variant_object.var_4c7e877986bfcaf1;
    
    if ( !isdefined( despawnambients ) )
    {
        despawnambients = var_310e111620b410d7.var_34859f69d60856fc.var_4c7e877986bfcaf1;
    }
    
    return istrue( despawnambients );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xea9ea1f4, Offset: 0x2fd3
// Size: 0x2c, Type: bool
function function_345d1a67cc09745c( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return istrue( var_310e111620b410d7.var_f8a2cf0dbfcabd63 );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x96ddd2d4, Offset: 0x3008
// Size: 0x3b, Type: bool
function function_147c9690b67bc543( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return var_310e111620b410d7.switchtoactivityloadout && isdefined( var_310e111620b410d7.activityloadout );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x9ee51ef, Offset: 0x304c
// Size: 0x2b
function function_52d1572302536f8d( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return var_310e111620b410d7.activityloadout;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x5aef0f53, Offset: 0x3080
// Size: 0x2b
function function_d32fa66f2924c90d( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return var_310e111620b410d7.var_7d57d9d2e6e66c3a;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x8f1802bd, Offset: 0x30b4
// Size: 0x2b
function function_7f4baa8b732295a9( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return var_310e111620b410d7.var_4e346b4523fd5fb7;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xd92ae5d9, Offset: 0x30e8
// Size: 0x2b
function function_a79589ad364e3951( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return var_310e111620b410d7.var_aa9eae974909a0d2;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x588f2ef2, Offset: 0x311c
// Size: 0x2b
function function_d9f0456f4d684482( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return var_310e111620b410d7.spawndata;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xc475488e, Offset: 0x3150
// Size: 0x60
function function_49729590f54b71b6( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    
    if ( var_310e111620b410d7.var_e379ec45c491c3b7 && var_310e111620b410d7.var_e379ec45c491c3b7.size )
    {
        return var_310e111620b410d7.var_e379ec45c491c3b7[ 0 ].variant_object.activitymoment;
    }
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x3dcf15dc, Offset: 0x31b9
// Size: 0x78
function function_4dbc827bb8b7e595( var_e0bbf417e9178e6 )
{
    var_8afda28105e1bec = [];
    scriptbundlename = function_edd604fe050e6cba( var_e0bbf417e9178e6 );
    var_8afda28105e1bec = level.activities.var_a4a513e0fe075256 namespace_4d597cbac7f48986::function_5c0524b11019fac5( scriptbundlename );
    
    if ( !isdefined( var_8afda28105e1bec ) )
    {
        function_163c2b796194beb7( scriptbundlename, var_e0bbf417e9178e6 );
        var_8afda28105e1bec = level.activities.var_a4a513e0fe075256 namespace_4d597cbac7f48986::function_5c0524b11019fac5( scriptbundlename );
    }
    
    return var_8afda28105e1bec;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x61b48560, Offset: 0x323a
// Size: 0x59
function function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 )
{
    customproperties = function_7519b3cb84aa1601( var_e0bbf417e9178e6 );
    
    if ( isdefined( customproperties.activitytypegroup ) && customproperties.activitytypegroup.size > 0 )
    {
        return customproperties.activitytypegroup[ 0 ].variant_object;
    }
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x58c1b7d1, Offset: 0x329c
// Size: 0x99
function function_4e0655e047df12b8( radiantobjectidentifier )
{
    utility::production_map_assert( isdefined( radiantobjectidentifier.name ), "The name for this Radiant Object Struct is not defined" );
    utility::production_map_assert( isdefined( radiantobjectidentifier.key ), "The key for this Radiant Object Struct is not defined" );
    struct = utility::getstruct( radiantobjectidentifier.name, radiantobjectidentifier.key );
    utility::production_map_assert( isdefined( struct ), "The Radiant Object Struct with Key: " + radiantobjectidentifier.key + " and Name: " + radiantobjectidentifier.name + " was not found." );
    return struct;
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0xb930c2fa, Offset: 0x333e
// Size: 0x1e
function function_d3ef1a62652daf90( var_e0bbf417e9178e6, activityspatialzonename )
{
    return function_85ef28a4069ec23f( var_e0bbf417e9178e6, activityspatialzonename );
}

// Namespace activity_definition_utils
// Params 3, eflags: 0x4
// Checksum 0xe7fc390d, Offset: 0x3365
// Size: 0x202, Type: bool
function private function_6e645939f41233e7( triggeringent, trigger, params )
{
    if ( activity_common::getactivityfunction( function_42c6fdc9dfef0672( params ), 10 ) )
    {
        relevantinfostruct = { #trigger:trigger, #triggeringent:triggeringent };
        result = activity_common::runactivityfunction( params, 10, relevantinfostruct );
        
        if ( result )
        {
            return true;
        }
    }
    
    if ( activity_common::function_f8e122bba9be6ceb( params.category, "NoEntTriggerFilter" ) )
    {
        relevantinfostruct = { #activityinstance:params, #player:triggeringent };
        result = activity_common::function_fc5e37706648886e( params.category, "NoEntTriggerFilter", relevantinfostruct );
        
        if ( result )
        {
            return true;
        }
    }
    
    if ( trigger.zonename == "Proximity_Join_Zone" && !activity_participation::function_5d733a45bcf51ef1( params ) )
    {
        return true;
    }
    
    if ( isplayer( triggeringent ) )
    {
        return false;
    }
    
    if ( triggeringent.occupants || triggeringent.turretoccupants )
    {
        foreach ( player in triggeringent.occupants )
        {
            if ( isplayer( player ) )
            {
                return false;
            }
        }
        
        foreach ( player in triggeringent.turretoccupants )
        {
            if ( isplayer( player ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace activity_definition_utils
// Params 3
// Checksum 0xdf89a3f7, Offset: 0x3570
// Size: 0x2a0
function function_77f316c8a973cf7a( spatialzonecontainer, spatialzonename, zoneinfostruct )
{
    if ( zoneinfostruct.usecustomdistance )
    {
        radius = function_c14df926dd2a7160( zoneinfostruct.var_b41d7a0bdbf73429 );
        ignoreheight = function_91abc7bd913f3cf1( zoneinfostruct );
        spatial_zone_container::function_847140d2863dfbf8( spatialzonecontainer, spatialzonename, undefined, radius, ignoreheight );
        
        if ( activity_instance_common::isactivityinstance( spatialzonecontainer ) )
        {
            activityinstance = spatialzonecontainer;
            spatial_zone_container::function_3edbf3270263b31b( activityinstance, spatialzonename, &activity_instance_common::function_776ee11e7acc64a5, [ activityinstance ] );
        }
        
        return;
    }
    
    if ( zoneinfostruct.var_e99b8e4a42e15499 )
    {
        var_4fe9a68acf0b6c0e = { #zoneinfostruct:zoneinfostruct, #spatialzonename:spatialzonename };
        
        if ( isstruct( spatialzonecontainer ) && spatialzonecontainer.varianttag && spatialzonecontainer.type && isdefined( spatialzonecontainer.id ) && ( !zoneinfostruct.var_aaec74d81ea8d50c || !zoneinfostruct.var_aaec74d81ea8d50c[ 0 ] || zoneinfostruct.var_aaec74d81ea8d50c[ 0 ] != "InstanceBegin" ) )
        {
            activitymoment = zoneinfostruct.var_aaec74d81ea8d50c[ 0 ] ?? "ActivityBegin";
            
            if ( !isdefined( spatialzonecontainer.var_4fe9a68acf0b6c0e ) )
            {
                spatialzonecontainer.var_4fe9a68acf0b6c0e = [];
            }
            
            if ( !isdefined( spatialzonecontainer.var_4fe9a68acf0b6c0e[ activitymoment ] ) )
            {
                spatialzonecontainer.var_4fe9a68acf0b6c0e[ activitymoment ] = [];
            }
            
            spatialzonecontainer.var_4fe9a68acf0b6c0e[ activitymoment ][ spatialzonecontainer.var_4fe9a68acf0b6c0e[ activitymoment ].size ] = var_4fe9a68acf0b6c0e;
            customproperties = function_9129cd8075c85c09( spatialzonecontainer );
            
            if ( !activity_common::function_3dd1ab7de513044f( zoneinfostruct.var_aaec74d81ea8d50c[ 0 ] ?? "ActivityBegin", &function_c04adc0d1a7440aa, customproperties.activitytype ) )
            {
                activity_common::function_2dd4f07fa5c3e911( zoneinfostruct.var_aaec74d81ea8d50c[ 0 ] ?? "ActivityBegin", &function_c04adc0d1a7440aa, customproperties.activitytype );
            }
        }
        else
        {
            spatialzonecontainer function_c04adc0d1a7440aa( undefined, var_4fe9a68acf0b6c0e );
        }
        
        return;
    }
    
    if ( zoneinfostruct.var_5fe9da8703efd79d )
    {
        function_1063440938a288c4( spatialzonecontainer, spatialzonename );
        return;
    }
    
    if ( zoneinfostruct.var_bd1d6827ce0e7426 )
    {
        linkedspatialzonename = function_aa7e89b49cce728a( zoneinfostruct );
        
        if ( isstring( linkedspatialzonename ) )
        {
            var_54b108be81360468 = ( zoneinfostruct.var_bb17488b0463057d ?? 100 ) / 100;
            spatial_zone_container::function_b14c4bcd92a0c6f2( spatialzonecontainer, spatialzonename, linkedspatialzonename, var_54b108be81360468 );
        }
    }
}

// Namespace activity_definition_utils
// Params 2, eflags: 0x4
// Checksum 0xe0ab5384, Offset: 0x3818
// Size: 0x5f2
function private function_c04adc0d1a7440aa( relevantinfostruct, var_4fe9a68acf0b6c0e )
{
    spatialzonecontainer = self;
    
    if ( !isdefined( var_4fe9a68acf0b6c0e ) )
    {
        var_4fe9a68acf0b6c0e = spatialzonecontainer.var_4fe9a68acf0b6c0e[ relevantinfostruct.activitymoment ];
    }
    
    if ( spatialzonecontainer.noenttriggers && spatialzonecontainer.noenttriggers.size )
    {
        return;
    }
    
    foreach ( data in var_4fe9a68acf0b6c0e )
    {
        spatialzonename = data.spatialzonename;
        zoneinfostruct = data.zoneinfostruct;
        noenttrigger = undefined;
        var_d27bb469e5bc94f2 = undefined;
        heightoffset = zoneinfostruct.heightoffset ?? 0;
        height = zoneinfostruct.height ?? 10000;
        zoneorigin = spatialzonecontainer.var_1103806baee402d5 + ( 0, 0, heightoffset );
        triggerflags = 528;
        
        if ( zoneinfostruct.length && zoneinfostruct.width )
        {
            triggersize = ( zoneinfostruct.length, zoneinfostruct.width, height );
            noenttrigger = spawn( "noent_volume_trigger_box", zoneorigin, triggerflags, triggersize, triggersize );
            noenttrigger.triggersize = triggersize;
            
            if ( zoneinfostruct.lengthmod != 1 || zoneinfostruct.heightmod != 1 || zoneinfostruct.widthmod != 1 || zoneinfostruct.var_88c177ae806db2a3 )
            {
                triggersize *= ( zoneinfostruct.lengthmod, zoneinfostruct.widthmod, zoneinfostruct.heightmod );
                var_d27bb469e5bc94f2 = spawn( "noent_volume_trigger_box", zoneorigin, triggerflags, triggersize, triggersize );
                var_d27bb469e5bc94f2.triggersize = triggersize;
            }
        }
        else if ( zoneinfostruct.radius )
        {
            noenttrigger = spawn( "noent_volume_trigger_radius", zoneorigin, triggerflags, zoneinfostruct.radius, height );
            noenttrigger.radius = zoneinfostruct.radius;
            noenttrigger.height = height;
            
            if ( zoneinfostruct.radiusmod != 1 || zoneinfostruct.heightmod != 1 || zoneinfostruct.var_88c177ae806db2a3 )
            {
                radiusmod = zoneinfostruct.radius * zoneinfostruct.radiusmod;
                heightmod = height * zoneinfostruct.heightmod;
                var_d27bb469e5bc94f2 = spawn( "noent_volume_trigger_radius", zoneorigin, triggerflags, radiusmod, heightmod );
                var_d27bb469e5bc94f2.radius = radiusmod;
                var_d27bb469e5bc94f2.height = heightmod;
            }
        }
        
        if ( !noenttrigger )
        {
            if ( spatialzonecontainer.var_4fe9a68acf0b6c0e && spatialzonecontainer.var_4fe9a68acf0b6c0e[ relevantinfostruct.activitymoment ] )
            {
                spatialzonecontainer.var_4fe9a68acf0b6c0e[ relevantinfostruct.activitymoment ] = undefined;
            }
            
            utility::production_map_assert( 0, "No radius, length, width, or height specified for no ent trigger spawn for spatial zone: " + spatialzonename + "." );
            return;
        }
        
        noenttrigger.heightoffset = heightoffset;
        
        if ( var_d27bb469e5bc94f2 )
        {
            var_d27bb469e5bc94f2.heightoffset = heightoffset * ( zoneinfostruct.heightmod ?? 1 );
        }
        
        [ entercallback, exitcallback ] = spatial_zone_container::function_5f8d3afa30682284( spatialzonename );
        
        if ( !spatial_zone_container::function_3819f09eefb741e2( spatialzonecontainer, spatialzonename ) )
        {
            spatial_zone_container::addspatialzone( spatialzonecontainer, spatialzonename );
        }
        
        if ( activity_instance_common::isactivityinstance( spatialzonecontainer ) && !zoneinfostruct.var_9efe8b18da6688b6 )
        {
            activityinstance = spatialzonecontainer;
            spatial_zone_container::function_3edbf3270263b31b( activityinstance, spatialzonename, &activity_instance_common::function_776ee11e7acc64a5, [ activityinstance ] );
        }
        
        noenttrigger.zonename = spatialzonename;
        
        if ( var_d27bb469e5bc94f2 )
        {
            var_d27bb469e5bc94f2.zonename = spatialzonename;
        }
        
        if ( exitcallback && var_d27bb469e5bc94f2 )
        {
            [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( noenttrigger, entercallback, undefined, undefined, undefined, &function_6e645939f41233e7, spatialzonecontainer );
            
            if ( !isdefined( spatialzonecontainer.noenttriggers ) )
            {
                spatialzonecontainer.noenttriggers = [];
            }
            
            spatialzonecontainer.noenttriggers[ spatialzonecontainer.noenttriggers.size ] = noenttrigger;
            [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( var_d27bb469e5bc94f2, undefined, exitcallback, undefined, undefined, &function_6e645939f41233e7, spatialzonecontainer );
            
            if ( !isdefined( spatialzonecontainer.noenttriggers ) )
            {
                spatialzonecontainer.noenttriggers = [];
            }
            
            spatialzonecontainer.noenttriggers[ spatialzonecontainer.noenttriggers.size ] = var_d27bb469e5bc94f2;
            
            /#
                var_d27bb469e5bc94f2.exittrigger = 1;
            #/
            
            continue;
        }
        
        [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( noenttrigger, entercallback, exitcallback, undefined, undefined, &function_6e645939f41233e7, spatialzonecontainer );
        
        if ( !isdefined( spatialzonecontainer.noenttriggers ) )
        {
            spatialzonecontainer.noenttriggers = [];
        }
        
        spatialzonecontainer.noenttriggers[ spatialzonecontainer.noenttriggers.size ] = noenttrigger;
    }
    
    if ( spatialzonecontainer.var_4fe9a68acf0b6c0e && spatialzonecontainer.var_4fe9a68acf0b6c0e[ relevantinfostruct.activitymoment ] )
    {
        spatialzonecontainer.var_4fe9a68acf0b6c0e[ relevantinfostruct.activitymoment ] = undefined;
    }
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0x697bce0a, Offset: 0x3e12
// Size: 0x110
function function_1063440938a288c4( spatialzonecontainer, spatialzonename )
{
    if ( isdefined( level.activities.nexusoverrides[ 12 ] ) )
    {
        activity_common::function_2ba08ba0c0544a1a( 12, [ spatialzonecontainer, spatialzonename ] );
        return;
    }
    
    if ( spatialzonename == "Hibernation_Zone" )
    {
        activitynexussettings = level.activities.activitynexussettings;
        var_8b92d5b16b70587e = activitynexussettings.var_70508fd968ce1f70[ 0 ].variant_object;
        
        if ( isdefined( var_8b92d5b16b70587e ) )
        {
            function_77f316c8a973cf7a( spatialzonecontainer, "Hibernation_Zone", var_8b92d5b16b70587e );
        }
        else
        {
            var_ba6ca3689a2a7bd2 = 10000;
            spatial_zone_container::function_847140d2863dfbf8( spatialzonecontainer, "Hibernation_Zone", undefined, var_ba6ca3689a2a7bd2 );
        }
        
        if ( activity_instance_common::isactivityinstance( spatialzonecontainer ) )
        {
            activityinstance = spatialzonecontainer;
            spatial_zone_container::function_3edbf3270263b31b( activityinstance, spatialzonename, &activity_instance_common::function_776ee11e7acc64a5, [ activityinstance ] );
        }
        
        return;
    }
    
    utility::production_map_assert( 0, "'UseGameModeDefault' was selected to define the: " + spatialzonename + " zone but no Game Mode default or Nexus default has been specified for that zone." );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xc30010fa, Offset: 0x3f2a
// Size: 0x5e, Type: bool
function function_6c3cc9191c5b0d36( var_e0bbf417e9178e6 )
{
    playerjointriggers = function_caadc60fcea307c5( var_e0bbf417e9178e6 );
    var_ffe003e0e00b3795 = playerjointriggers.var_ffe003e0e00b3795;
    
    if ( isdefined( var_ffe003e0e00b3795 ) && var_ffe003e0e00b3795.size == 1 )
    {
        return true;
    }
    
    return istrue( playerjointriggers.var_548dde7885bac469.var_a077b43de86e44cd );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xf20ea710, Offset: 0x3f91
// Size: 0x8d, Type: bool
function function_9ba046b276151c3b( var_e0bbf417e9178e6 )
{
    if ( function_6c3cc9191c5b0d36( var_e0bbf417e9178e6 ) )
    {
        playerjointriggers = function_caadc60fcea307c5( var_e0bbf417e9178e6 );
        var_ffe003e0e00b3795 = playerjointriggers.var_ffe003e0e00b3795;
        
        if ( isdefined( var_ffe003e0e00b3795 ) && var_ffe003e0e00b3795.size == 1 )
        {
            return ( var_ffe003e0e00b3795[ 0 ].variant_type == "Types_SpawnInteractScriptablesOnScriptStructs" );
        }
        
        return true;
    }
    
    /#
        activitytype = function_42c6fdc9dfef0672( var_e0bbf417e9178e6 );
        utility::production_map_assert( 0, "<dev string:x2b0>" + activitytype );
    #/
    
    return false;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x2098d45b, Offset: 0x4027
// Size: 0xa3
function function_8d582a1239b166de( var_e0bbf417e9178e6 )
{
    if ( function_6c3cc9191c5b0d36( var_e0bbf417e9178e6 ) )
    {
        playerjointriggers = function_caadc60fcea307c5( var_e0bbf417e9178e6 );
        var_ffe003e0e00b3795 = playerjointriggers.var_ffe003e0e00b3795;
        
        if ( isdefined( var_ffe003e0e00b3795 ) && var_ffe003e0e00b3795.size == 1 )
        {
            return var_ffe003e0e00b3795[ 0 ].variant_object.interactscriptable;
        }
        
        return playerjointriggers.var_548dde7885bac469.interactscriptable;
    }
    
    /#
        activitytype = function_42c6fdc9dfef0672( var_e0bbf417e9178e6 );
        utility::production_map_assert( 0, "<dev string:x2b0>" + activitytype );
    #/
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x785ed5c6, Offset: 0x40d3
// Size: 0x49, Type: bool
function function_f35ffc5fdda1d8eb( var_e0bbf417e9178e6 )
{
    playerjointriggers = function_caadc60fcea307c5( var_e0bbf417e9178e6 );
    var_a992a28c8f440e25 = playerjointriggers.var_a992a28c8f440e25;
    
    if ( isdefined( var_a992a28c8f440e25 ) )
    {
        return istrue( var_a992a28c8f440e25.var_ec74a21f93061dc9 );
    }
    
    return false;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x37a9bbb6, Offset: 0x4125
// Size: 0x74, Type: bool
function function_78afebeb162cfa68( var_e0bbf417e9178e6 )
{
    playerjointriggers = function_caadc60fcea307c5( var_e0bbf417e9178e6 );
    joinsettings = playerjointriggers.proximityjoinsettings;
    
    if ( isdefined( joinsettings ) && joinsettings.size == 1 )
    {
        return istrue( joinsettings[ 0 ].variant_object.proximityjoinenabled );
    }
    
    return istrue( playerjointriggers.var_d8054272153fa68.proximityjoinenabled );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xc6f01d76, Offset: 0x41a2
// Size: 0xce
function function_a771e0faeddcc15e( var_e0bbf417e9178e6 )
{
    if ( function_78afebeb162cfa68( var_e0bbf417e9178e6 ) )
    {
        playerjointriggers = function_caadc60fcea307c5( var_e0bbf417e9178e6 );
        joinsettings = playerjointriggers.proximityjoinsettings;
        
        if ( isdefined( joinsettings ) && joinsettings.size == 1 )
        {
            var_f855dd5d22859a96 = joinsettings[ 0 ].variant_object.var_1038b25e1f99e93e;
            
            if ( isdefined( var_f855dd5d22859a96 ) && var_f855dd5d22859a96.size == 1 )
            {
                return var_f855dd5d22859a96[ 0 ].variant_object.activitymoment;
            }
            
            return;
        }
        
        activatemoment = playerjointriggers.var_d8054272153fa68.var_5eb824f196400190;
        
        if ( isdefined( activatemoment ) && activatemoment != "None" )
        {
            return activatemoment;
        }
    }
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x4e926bb8, Offset: 0x4279
// Size: 0xce
function function_d946edd15270dfdf( var_e0bbf417e9178e6 )
{
    if ( function_78afebeb162cfa68( var_e0bbf417e9178e6 ) )
    {
        playerjointriggers = function_caadc60fcea307c5( var_e0bbf417e9178e6 );
        joinsettings = playerjointriggers.proximityjoinsettings;
        
        if ( isdefined( joinsettings ) && joinsettings.size == 1 )
        {
            var_5b85539597ecd60e = joinsettings[ 0 ].variant_object.var_e46842d5e582d126;
            
            if ( isdefined( var_5b85539597ecd60e ) && var_5b85539597ecd60e.size == 1 )
            {
                return var_5b85539597ecd60e[ 0 ].variant_object.activitymoment;
            }
            
            return;
        }
        
        deactivatemoment = playerjointriggers.var_d8054272153fa68.var_7a83b47b605323f1;
        
        if ( isdefined( deactivatemoment ) && deactivatemoment != "None" )
        {
            return deactivatemoment;
        }
    }
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x8924a1bd, Offset: 0x4350
// Size: 0x43
function function_2130f1b5ae6ebcee( var_e0bbf417e9178e6 )
{
    playerfocussettings = function_3ab57b65d8d29d2d( var_e0bbf417e9178e6 );
    
    if ( !( isdefined( playerfocussettings ) && isdefined( playerfocussettings.var_c01a5323cc5fc8c0 ) ) )
    {
        return 0;
    }
    
    return playerfocussettings.var_c01a5323cc5fc8c0;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xcbe1a3e9, Offset: 0x439c
// Size: 0x7b, Type: bool
function function_4bbcb4818269953d( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    
    if ( isdefined( var_310e111620b410d7.activitycenterobjectivemarker ) && var_310e111620b410d7.activitycenterobjectivemarker.size == 1 )
    {
        return isdefined( var_310e111620b410d7.activitycenterobjectivemarker[ 0 ].variant_object.var_f3260707d02e2cd0 );
    }
    
    return istrue( var_310e111620b410d7.activitycenterobjectivemarkersettings.var_76f258c7b154c925 );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x8b54cc5f, Offset: 0x4420
// Size: 0x68, Type: bool
function function_f9aac5b745dab95a( activityinstance )
{
    if ( !activityinstance || activityinstance.category != "Activity" && activityinstance.category != "Startup" )
    {
        return false;
    }
    
    return level.gametypebundle && level.gametypebundle.activitynexussettings == %"hash_125e94968e8e0545";
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x8e6a58ee, Offset: 0x4491
// Size: 0x6e, Type: bool
function function_48c2921599efd7a7( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    assert( function_4bbcb4818269953d( var_e0bbf417e9178e6 ), "<dev string:x321>" );
    return var_310e111620b410d7.activitycenterobjectivemarker[ 0 ].variant_object.var_f3260707d02e2cd0 ?? var_310e111620b410d7.activitycenterobjectivemarkersettings.var_f3260707d02e2cd0;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x96f11792, Offset: 0x4508
// Size: 0xfc
function function_9461b89496773d9( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    assert( function_4bbcb4818269953d( var_e0bbf417e9178e6 ), "<dev string:x38b>" );
    objectivemarkertype = function_48c2921599efd7a7( var_e0bbf417e9178e6 );
    objectivemarkerasset = undefined;
    
    if ( objectivemarkertype == "Scriptable" )
    {
        objectivemarkerasset = var_310e111620b410d7.activitycenterobjectivemarker[ 0 ].variant_object.objectivemarkerscriptable ?? var_310e111620b410d7.activitycenterobjectivemarkersettings.objectivemarkerscriptable;
    }
    else if ( objectivemarkertype == "GSCScript" )
    {
        objectivemarkerasset = var_310e111620b410d7.activitycenterobjectivemarker[ 0 ].variant_object.objectivemarkerscriptbundle ?? var_310e111620b410d7.activitycenterobjectivemarkersettings.objectivemarkerscriptbundle;
    }
    else
    {
        utility::production_map_assert( 0, "Activity Objective Marker Asset Type: " + objectivemarkertype + " is unregonized." );
    }
    
    return objectivemarkerasset;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x14dcb2b1, Offset: 0x460d
// Size: 0x84, Type: bool
function function_63b3e35daebe550e( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    assert( function_4bbcb4818269953d( var_e0bbf417e9178e6 ), "<dev string:x38b>" );
    return var_310e111620b410d7.activitycenterobjectivemarker[ 0 ].variant_object.var_4bdbfe745477ce09[ 0 ].variant_object.activitymoment ?? var_310e111620b410d7.activitycenterobjectivemarkersettings.var_4bdbfe745477ce09;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x32b9a8a3, Offset: 0x469a
// Size: 0x84, Type: bool
function function_48f55085337a366f( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    assert( function_4bbcb4818269953d( var_e0bbf417e9178e6 ), "<dev string:x38b>" );
    return var_310e111620b410d7.activitycenterobjectivemarker[ 0 ].variant_object.var_cfc799fec790bd22[ 0 ].variant_object.activitymoment ?? var_310e111620b410d7.activitycenterobjectivemarkersettings.var_cfc799fec790bd22;
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x779fad22, Offset: 0x4727
// Size: 0x7b, Type: bool
function function_f5e99efc55cb0385( var_e0bbf417e9178e6 )
{
    assert( function_4bbcb4818269953d( var_e0bbf417e9178e6 ), "<dev string:x38b>" );
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    var_a521ee1c54530913 = var_310e111620b410d7.activitycenterobjectivemarker[ 0 ].variant_object.var_a521ee1c54530913 ?? var_310e111620b410d7.activitycenterobjectivemarkersettings.var_a521ee1c54530913;
    return istrue( var_a521ee1c54530913 );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xe73c8496, Offset: 0x47ab
// Size: 0x7b, Type: bool
function function_ca3542bdf90eb3d( var_e0bbf417e9178e6 )
{
    assert( function_4bbcb4818269953d( var_e0bbf417e9178e6 ), "<dev string:x38b>" );
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    shouldpin = var_310e111620b410d7.activitycenterobjectivemarker[ 0 ].variant_object.shouldpin ?? var_310e111620b410d7.activitycenterobjectivemarkersettings.shouldpin;
    return istrue( shouldpin );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x671e27cd, Offset: 0x482f
// Size: 0x18, Type: bool
function function_91abc7bd913f3cf1( zoneinfostruct )
{
    return istrue( zoneinfostruct.ignoreheightvalue );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xfefc2e8, Offset: 0x4850
// Size: 0x40, Type: bool
function function_1fcf0e2dc0d1c7be( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return istrue( var_310e111620b410d7.var_390a857a39f72e01.var_7089b64c87d90b69.var_32d7cb032bbb2ffd );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xb9eda692, Offset: 0x4899
// Size: 0x36, Type: bool
function function_31ae56e3ed53afc0( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return istrue( var_310e111620b410d7.hibernationsettings.hibernationisenabled );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x3287ff68, Offset: 0x48d8
// Size: 0x19
function function_fbd3d5a133e04d8a( var_e0bbf417e9178e6 )
{
    return function_e8a6ef17c276c981( var_e0bbf417e9178e6, "Awareness_Zone" );
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0x180bee98, Offset: 0x48fa
// Size: 0x38
function function_65cbe62d5b3c2c15( var_e0bbf417e9178e6 )
{
    if ( isdefined( var_e0bbf417e9178e6 ) )
    {
        var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
        
        if ( isdefined( var_310e111620b410d7 ) )
        {
            return var_310e111620b410d7.activityrewardcaches;
        }
    }
}

// Namespace activity_definition_utils
// Params 1
// Checksum 0xca596bfd, Offset: 0x493b
// Size: 0x46
function function_d117dfdfdf545089( var_e0bbf417e9178e6 )
{
    associatedscriptbundlename = function_edd604fe050e6cba( var_e0bbf417e9178e6 );
    
    if ( isdefined( associatedscriptbundlename ) )
    {
        var_912abeb41a29e46 = getscriptbundle( associatedscriptbundlename );
        return var_912abeb41a29e46;
    }
    
    utility::production_map_assert( 0, "This activity definition reference struct does not have a reference to a valid activity definition" );
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0x32c678c3, Offset: 0x498a
// Size: 0x29
function function_fa4a668eb5639428( var_66a6ad52ba244acd, index )
{
    if ( !index )
    {
        return var_66a6ad52ba244acd;
    }
    
    return var_66a6ad52ba244acd + "_variant_index_" + index;
}

// Namespace activity_definition_utils
// Params 2
// Checksum 0x1cf4c61, Offset: 0x49bc
// Size: 0x156
function function_55ff2d76b3964922( activityinstance, var_1522759968e978ca )
{
    if ( activityinstance.var_8339fb4f2d23dabf.zones )
    {
        return;
    }
    
    foreach ( zonetype, zone in self.var_8339fb4f2d23dabf.zones )
    {
        if ( !zone.spheres || var_1522759968e978ca && zonetype != var_1522759968e978ca )
        {
            continue;
        }
        
        foreach ( spherezone in zone.spheres )
        {
            if ( !spherezone.radius )
            {
                continue;
            }
            
            return spherezone.radius;
        }
    }
}

// Namespace activity_definition_utils
// Params 2, eflags: 0x4
// Checksum 0x51a03928, Offset: 0x4b1b
// Size: 0x1b6
function private function_3c7069402fa2172e( activityinstance, var_49b766acb5226cde )
{
    activitytype = activityinstance.type;
    varianttag = activityinstance.varianttag;
    var_6c54aa9d69b5458a = undefined;
    
    if ( isdefined( var_49b766acb5226cde ) )
    {
        var_e72507408e24565 = [[ var_49b766acb5226cde ]]();
        var_6c54aa9d69b5458a = var_e72507408e24565[ varianttag ];
    }
    
    /#
        if ( !( isdefined( var_6c54aa9d69b5458a.scriptstructorigin ) && isdefined( var_6c54aa9d69b5458a.scriptstructoriginoffset ) ) )
        {
            utility::production_map_assert( 0, "<dev string:x3f6>" + activitytype + "<dev string:x423>" + varianttag + "<dev string:x425>" );
        }
    #/
    
    cscenterstruct = spawnstruct();
    cscenterstruct.origin = var_6c54aa9d69b5458a.scriptstructorigin;
    cscenterstruct.angles = ( 0, 0, 0 );
    create_script_utility::translate_position_with_offset_data( var_6c54aa9d69b5458a.cf, cscenterstruct, var_6c54aa9d69b5458a.scriptstructoriginoffset, ( 0, 0, 0 ) );
    spatial_zone_container::function_847140d2863dfbf8( activityinstance, "Center_Spatial_Zone", cscenterstruct.origin );
    
    if ( isdefined( var_6c54aa9d69b5458a.var_f645acd3eb21a6bc ) )
    {
        foreach ( spatialzonename, var_5161fb8d609f347a in var_6c54aa9d69b5458a.var_f645acd3eb21a6bc )
        {
            function_f06ce6187b459f2d( activityinstance, spatialzonename, var_6c54aa9d69b5458a, var_5161fb8d609f347a );
        }
    }
}

// Namespace activity_definition_utils
// Params 4, eflags: 0x4
// Checksum 0x46340035, Offset: 0x4cd9
// Size: 0x195
function private function_f06ce6187b459f2d( activitydefinition, spatialzonename, instancemetadata, zonemetadata )
{
    zoneinfostruct = function_d3ef1a62652daf90( activitydefinition, spatialzonename );
    var_e79c9341384f12de = !isdefined( zoneinfostruct ) || zoneinfostruct.var_d10d8478f88f982;
    var_b77b55a17a7cdf8e = isdefined( zonemetadata );
    
    if ( var_b77b55a17a7cdf8e && var_e79c9341384f12de )
    {
        function_87f141fddcfecb4( zonemetadata, instancemetadata.cf, instancemetadata.scriptstructoriginoffset );
        
        if ( isdefined( zoneinfostruct ) && zoneinfostruct.var_35f4d21e238902eb )
        {
            spatial_zone_container::function_5252f95edcf9e32c( activitydefinition, spatialzonename );
        }
        else
        {
            spatial_zone_container::addspatialzone( activitydefinition, spatialzonename );
        }
        
        for ( sphereindex = 0; sphereindex < zonemetadata.locationorigin.size ; sphereindex++ )
        {
            origin = zonemetadata.locationorigin[ sphereindex ];
            radius = zonemetadata.locationradius[ sphereindex ];
            
            if ( isdefined( zoneinfostruct ) )
            {
                ignoreheight = function_91abc7bd913f3cf1( zoneinfostruct );
                spatial_zone_container::function_847140d2863dfbf8( activitydefinition, spatialzonename, origin, radius, ignoreheight );
                continue;
            }
            
            spatial_zone_container::function_847140d2863dfbf8( activitydefinition, spatialzonename, origin, radius );
        }
    }
    
    /#
        if ( var_b77b55a17a7cdf8e && isdefined( zoneinfostruct ) && !zoneinfostruct.var_d10d8478f88f982 )
        {
            activitytype = function_42c6fdc9dfef0672( activitydefinition );
            utility::production_map_assert( 0, "<dev string:x461>" + activitytype + "<dev string:x471>" + spatialzonename + "<dev string:x483>" );
        }
    #/
}

// Namespace activity_definition_utils
// Params 3, eflags: 0x4
// Checksum 0xee029614, Offset: 0x4e76
// Size: 0xb6
function private function_87f141fddcfecb4( var_28fd8e4fdc33db4f, createscriptfile, centeroffset )
{
    for ( originindex = 0; originindex < var_28fd8e4fdc33db4f.locationorigin.size ; originindex++ )
    {
        center = spawnstruct();
        center.origin = var_28fd8e4fdc33db4f.locationorigin[ originindex ];
        center.angles = ( 0, 0, 0 );
        create_script_utility::translate_position_with_offset_data( createscriptfile, center, centeroffset, ( 0, 0, 0 ) );
        var_28fd8e4fdc33db4f.locationorigin[ originindex ] = center.origin;
    }
}

// Namespace activity_definition_utils
// Params 2, eflags: 0x4
// Checksum 0x3d49b3a0, Offset: 0x4f34
// Size: 0x7b
function private function_46ffa9802d35187a( scriptbundlename, var_e0bbf417e9178e6 )
{
    activitydefinitionbundle = level.activities.var_d3b2bc276f3a2973 namespace_4d597cbac7f48986::function_5c0524b11019fac5( scriptbundlename );
    
    if ( !isdefined( activitydefinitionbundle ) )
    {
        activitydefinitionbundle = getscriptbundle( scriptbundlename );
        
        if ( isdefined( activitydefinitionbundle ) )
        {
            function_41d2b3aaf78ce876( scriptbundlename, activitydefinitionbundle, var_e0bbf417e9178e6 );
            level.activities.var_d3b2bc276f3a2973 namespace_4d597cbac7f48986::addtocache( scriptbundlename, activitydefinitionbundle );
        }
    }
    
    return activitydefinitionbundle;
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x14910812, Offset: 0x4fb8
// Size: 0x73
function private function_edd604fe050e6cba( var_e0bbf417e9178e6 )
{
    associatedscriptbundlename = undefined;
    
    if ( activity_instance_common::isactivityinstance( var_e0bbf417e9178e6 ) )
    {
        activitydefinition = function_837a0c8626c9b419( var_e0bbf417e9178e6 );
        associatedscriptbundlename = activitydefinition.associatedscriptbundlename;
    }
    else if ( function_5302a6396b276aff( var_e0bbf417e9178e6 ) )
    {
        activitydefinition = var_e0bbf417e9178e6;
        associatedscriptbundlename = activitydefinition.associatedscriptbundlename;
    }
    
    utility::production_map_assert( isdefined( associatedscriptbundlename ), "This activity definition reference struct does not have a reference to a valid activity definition" );
    return associatedscriptbundlename;
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0xe17387bf, Offset: 0x5034
// Size: 0x130
function private function_ae58efce66efaf8d( activityinstance )
{
    if ( function_e8a6ef17c276c981( activityinstance, "Awareness_Zone" ) )
    {
        zoneinfostruct = function_85ef28a4069ec23f( activityinstance, "Awareness_Zone" );
        function_77f316c8a973cf7a( activityinstance, "Awareness_Zone", zoneinfostruct );
    }
    
    if ( function_e8a6ef17c276c981( activityinstance, "Proximity_Join_Zone" ) )
    {
        zoneinfostruct = function_85ef28a4069ec23f( activityinstance, "Proximity_Join_Zone" );
        function_77f316c8a973cf7a( activityinstance, "Proximity_Join_Zone", zoneinfostruct );
    }
    
    if ( function_e8a6ef17c276c981( activityinstance, "Proximity_Abandon_Zone" ) )
    {
        zoneinfostruct = function_85ef28a4069ec23f( activityinstance, "Proximity_Abandon_Zone" );
        function_77f316c8a973cf7a( activityinstance, "Proximity_Abandon_Zone", zoneinfostruct );
    }
    
    if ( function_e8a6ef17c276c981( activityinstance, "Ambient_AI_Exclusion_Zone" ) )
    {
        zoneinfostruct = function_85ef28a4069ec23f( activityinstance, "Ambient_AI_Exclusion_Zone" );
        function_77f316c8a973cf7a( activityinstance, "Ambient_AI_Exclusion_Zone", zoneinfostruct );
    }
    
    if ( function_e8a6ef17c276c981( activityinstance, "Hibernation_Zone" ) )
    {
        zoneinfostruct = function_85ef28a4069ec23f( activityinstance, "Hibernation_Zone" );
        function_77f316c8a973cf7a( activityinstance, "Hibernation_Zone", zoneinfostruct );
    }
    
    if ( function_e8a6ef17c276c981( activityinstance, "Objective_Marker_Center_Zone" ) )
    {
        zoneinfostruct = function_85ef28a4069ec23f( activityinstance, "Objective_Marker_Center_Zone" );
        function_77f316c8a973cf7a( activityinstance, "Objective_Marker_Center_Zone", zoneinfostruct );
    }
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x4bc9d088, Offset: 0x516c
// Size: 0x2d
function private function_aa7e89b49cce728a( zoneinfostruct )
{
    return zoneinfostruct.spatialzonename[ 0 ].variant_object.spatialzonename;
}

// Namespace activity_definition_utils
// Params 2, eflags: 0x4
// Checksum 0xbcb52097, Offset: 0x51a2
// Size: 0x4b
function private function_e8a6ef17c276c981( var_e0bbf417e9178e6, activityspatialzone )
{
    zoneinfostruct = function_85ef28a4069ec23f( var_e0bbf417e9178e6, activityspatialzone );
    
    if ( isdefined( zoneinfostruct ) )
    {
        var_249ac670a9afbc2 = !isdefined( zoneinfostruct.var_69c0f72c44c30bba );
        return var_249ac670a9afbc2;
    }
    
    return 0;
}

// Namespace activity_definition_utils
// Params 2, eflags: 0x4
// Checksum 0x72934e7c, Offset: 0x51f6
// Size: 0xb1
function private function_85ef28a4069ec23f( var_e0bbf417e9178e6, activityspatialzone )
{
    zoneinfostruct = undefined;
    
    if ( activityspatialzone == "Awareness_Zone" )
    {
        zoneinfostruct = function_f9b1943dc02c2bf5( var_e0bbf417e9178e6 );
    }
    else if ( activityspatialzone == "Proximity_Join_Zone" )
    {
        zoneinfostruct = function_afc72bbd926571e5( var_e0bbf417e9178e6 );
    }
    else if ( activityspatialzone == "Ambient_AI_Exclusion_Zone" )
    {
        zoneinfostruct = function_1f7304c35aba062a( var_e0bbf417e9178e6 );
    }
    else if ( activityspatialzone == "Hibernation_Zone" )
    {
        zoneinfostruct = function_aed1655a59cf08b3( var_e0bbf417e9178e6 );
    }
    else if ( activityspatialzone == "Proximity_Abandon_Zone" )
    {
        zoneinfostruct = function_5dd606cbfd46dd2d( var_e0bbf417e9178e6 );
    }
    else if ( activityspatialzone == "Objective_Marker_Center_Zone" )
    {
        zoneinfostruct = function_5d42b2eea9ef5f88( var_e0bbf417e9178e6 );
    }
    
    return zoneinfostruct;
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x57e28cdb, Offset: 0x52b0
// Size: 0x35
function private function_3ab57b65d8d29d2d( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return var_310e111620b410d7.var_fb4dd0352a7b7099.playerfocussettings;
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0xdca96961, Offset: 0x52ee
// Size: 0xb2
function private function_40742eaedfb92ecb( var_e0bbf417e9178e6 )
{
    if ( activity_instance_common::isactivityinstance( var_e0bbf417e9178e6 ) )
    {
        activitydefinition = function_837a0c8626c9b419( var_e0bbf417e9178e6 );
        associatedscriptbundle = function_46ffa9802d35187a( activitydefinition.associatedscriptbundlename, var_e0bbf417e9178e6 );
        return associatedscriptbundle.var_310e111620b410d7;
    }
    else if ( function_5302a6396b276aff( var_e0bbf417e9178e6 ) )
    {
        activitydefinition = var_e0bbf417e9178e6;
        associatedscriptbundle = function_46ffa9802d35187a( activitydefinition.associatedscriptbundlename, var_e0bbf417e9178e6 );
        return associatedscriptbundle.var_310e111620b410d7;
    }
    else if ( isdefined( var_e0bbf417e9178e6.var_310e111620b410d7 ) )
    {
        return var_e0bbf417e9178e6.var_310e111620b410d7;
    }
    
    utility::production_map_assert( 0, "This activity definition reference struct does not have a reference to a valid activity definition" );
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x5842271c, Offset: 0x53a9
// Size: 0xa8
function private function_7519b3cb84aa1601( var_e0bbf417e9178e6 )
{
    if ( activity_instance_common::isactivityinstance( var_e0bbf417e9178e6 ) )
    {
        activitydefinition = function_837a0c8626c9b419( var_e0bbf417e9178e6 );
        return level.activities.var_ecd90a9fee3dfb36[ activitydefinition.associatedscriptbundlename ];
    }
    else if ( function_5302a6396b276aff( var_e0bbf417e9178e6 ) )
    {
        activitydefinition = var_e0bbf417e9178e6;
        return level.activities.var_ecd90a9fee3dfb36[ activitydefinition.associatedscriptbundlename ];
    }
    else if ( isdefined( var_e0bbf417e9178e6.customproperties ) )
    {
        return var_e0bbf417e9178e6.customproperties;
    }
    
    utility::production_map_assert( 0, "This activity definition reference struct does not have a reference to a valid activity definition" );
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x634f366a, Offset: 0x545a
// Size: 0x2b
function private function_42c6fdc9dfef0672( var_e0bbf417e9178e6 )
{
    customproperties = function_9129cd8075c85c09( var_e0bbf417e9178e6 );
    return customproperties.activitytype;
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x8c73c715, Offset: 0x548e
// Size: 0x113
function private function_d6e5b263d3ada8d5( var_1a296ee5190c141c )
{
    if ( isdefined( level.activities.definitions[ var_1a296ee5190c141c.variantstruct.name ] ) )
    {
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x9a>" + var_1a296ee5190c141c.variantstruct.name + "<dev string:xa5>", @"hash_72a413c7683cfc8d" );
        #/
        
        return getactivitydefinition( var_1a296ee5190c141c.variantstruct.name );
    }
    
    activityvariantname = var_1a296ee5190c141c.variantstruct.name;
    bundlename = var_1a296ee5190c141c.variantstruct.activity_bundle;
    
    if ( !isdefined( bundlename ) )
    {
        bundlename = function_ebeacac960b1bd3e( activityvariantname );
    }
    
    if ( isstring( bundlename ) && bundlename != "" )
    {
        activitydefinition = function_74af1ab4059e3c06( bundlename, activityvariantname );
        return activitydefinition;
    }
    
    utility::production_map_assert( 0, "Did not find the associated Script Bundle for the Map Placed Activity: " + activityvariantname );
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0xee2c04ee, Offset: 0x55a9
// Size: 0xc5
function private function_ebeacac960b1bd3e( activityvariantname )
{
    var_3b9ee7f22be7d51d = undefined;
    
    for ( variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( activityvariantname ); !isdefined( var_3b9ee7f22be7d51d ) && isdefined( variantscriptstructinfo ) ; variantscriptstructinfo = undefined )
    {
        var_6a1b5d581429fafd = variantscriptstructinfo.variantstruct;
        
        if ( isdefined( var_6a1b5d581429fafd.activity_bundle ) )
        {
            var_3b9ee7f22be7d51d = var_6a1b5d581429fafd.activity_bundle;
            continue;
        }
        
        if ( isstring( var_6a1b5d581429fafd.parent ) )
        {
            variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( var_6a1b5d581429fafd.parent );
            continue;
        }
    }
    
    var_9955f93e8f3e6b37 = strtok( var_3b9ee7f22be7d51d, ":" );
    
    if ( var_9955f93e8f3e6b37.size == 1 )
    {
        var_3b9ee7f22be7d51d = "activitydefinition:" + var_3b9ee7f22be7d51d;
    }
    
    return var_3b9ee7f22be7d51d;
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x797ff9b8, Offset: 0x5677
// Size: 0x36
function private function_c14df926dd2a7160( distancesettings )
{
    if ( !isdefined( distancesettings.customdistance ) )
    {
        utility::production_map_assert( 0, "A custom value for this distance setting was requested despite the distance being set to 0 or undefined." );
        return 0;
    }
    
    return distancesettings.customdistance;
}

// Namespace activity_definition_utils
// Params 3, eflags: 0x4
// Checksum 0x103c7909, Offset: 0x56b6
// Size: 0x8f
function private function_213d5fa71f7ef9e6( var_e0bbf417e9178e6, startstate, endstate )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    
    if ( startstate == "Idle" && endstate == "Active" )
    {
        return var_310e111620b410d7.var_390a857a39f72e01.var_ddf05e1d3b18dfa2;
    }
    
    if ( startstate == "Ended" && endstate == "Cleanup" )
    {
        return var_310e111620b410d7.var_390a857a39f72e01.var_d0fcfda134433e23;
    }
}

// Namespace activity_definition_utils
// Params 3, eflags: 0x4
// Checksum 0xf497f0a7, Offset: 0x574d
// Size: 0x81
function private function_41d2b3aaf78ce876( scriptbundlename, scriptbundle, var_e0bbf417e9178e6 )
{
    var_cdf5d4e388e93647 = level.activities.var_a4a513e0fe075256 namespace_4d597cbac7f48986::function_5c0524b11019fac5( scriptbundlename );
    
    if ( !isdefined( var_cdf5d4e388e93647 ) )
    {
        function_163c2b796194beb7( scriptbundlename, var_e0bbf417e9178e6, scriptbundle );
    }
    
    scriptbundle.var_310e111620b410d7.playerbroadcasts = undefined;
    scriptbundle.var_310e111620b410d7.customproperties = undefined;
}

// Namespace activity_definition_utils
// Params 3, eflags: 0x4
// Checksum 0x2caae987, Offset: 0x57d6
// Size: 0x125
function private function_163c2b796194beb7( scriptbundlename, var_e0bbf417e9178e6, var_e83ffdaa9562dbe3 = function_d117dfdfdf545089( var_e0bbf417e9178e6 ) )
{
    activitycategory = function_897014a17bf1cbdc( var_e83ffdaa9562dbe3 );
    var_e1c0d0b5ea1f2b13 = activity_common::function_7f6dd954bcc3f939();
    var_ad034c4c6b049bde = activity_common::function_7b714d2eb39b5e9( activitycategory );
    var_8afda28105e1bec = namespace_2aca03e533f9f843::function_2b7077459c53fdd3( var_e83ffdaa9562dbe3.var_310e111620b410d7.activityplayerbroadcasts );
    var_9b86fc481bac755 = namespace_2aca03e533f9f843::function_2b7077459c53fdd3( var_e83ffdaa9562dbe3.var_310e111620b410d7.playerbroadcasts );
    var_f504771295c70965 = { #var_8e8e3e6c78f88433:0, #var_3e21aec4f4280788:[], #var_3184d3dd50546cc3:[], #var_8b90311fda82dea4:[] };
    namespace_2aca03e533f9f843::function_5403291ba35ad13f( var_f504771295c70965, var_e1c0d0b5ea1f2b13 );
    namespace_2aca03e533f9f843::function_5403291ba35ad13f( var_f504771295c70965, var_ad034c4c6b049bde );
    namespace_2aca03e533f9f843::function_5403291ba35ad13f( var_f504771295c70965, var_8afda28105e1bec );
    namespace_2aca03e533f9f843::function_5403291ba35ad13f( var_f504771295c70965, var_9b86fc481bac755 );
    level.activities.var_a4a513e0fe075256 namespace_4d597cbac7f48986::addtocache( scriptbundlename, var_f504771295c70965 );
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x910a30e8, Offset: 0x5903
// Size: 0x59
function private function_f9b1943dc02c2bf5( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    
    if ( isdefined( var_310e111620b410d7.var_afb82823e7216cae ) && var_310e111620b410d7.var_afb82823e7216cae.size > 0 )
    {
        return var_310e111620b410d7.var_afb82823e7216cae[ 0 ].variant_object;
    }
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x6d7a12f0, Offset: 0x5965
// Size: 0xea
function private function_afc72bbd926571e5( var_e0bbf417e9178e6 )
{
    if ( function_78afebeb162cfa68( var_e0bbf417e9178e6 ) )
    {
        playerjointriggers = function_caadc60fcea307c5( var_e0bbf417e9178e6 );
        joinsettings = playerjointriggers.proximityjoinsettings;
        
        if ( isdefined( joinsettings ) && joinsettings.size == 1 )
        {
            if ( isdefined( joinsettings[ 0 ].variant_object.var_bb2544ec4d4533fb ) && joinsettings[ 0 ].variant_object.var_bb2544ec4d4533fb.size > 0 )
            {
                return joinsettings[ 0 ].variant_object.var_bb2544ec4d4533fb[ 0 ].variant_object;
            }
            
            return;
        }
        
        var_bb2544ec4d4533fb = playerjointriggers.var_d8054272153fa68.var_bb2544ec4d4533fb;
        
        if ( isdefined( var_bb2544ec4d4533fb ) && var_bb2544ec4d4533fb.size > 0 )
        {
            return var_bb2544ec4d4533fb[ 0 ].variant_object;
        }
    }
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0xa3a0fa83, Offset: 0x5a58
// Size: 0x8e
function private function_1f7304c35aba062a( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    
    if ( function_b6096963d0181099( var_e0bbf417e9178e6 ) )
    {
        var_bb9202e52801ef7d = var_310e111620b410d7.var_b6b515a8f1cc711c[ 0 ].variant_object.var_bf0099445a88df09 ?? var_310e111620b410d7.var_34859f69d60856fc.var_45eaa8fc412d7398;
        
        if ( isarray( var_bb9202e52801ef7d ) && var_bb9202e52801ef7d.size > 0 )
        {
            return var_bb9202e52801ef7d[ 0 ].variant_object;
        }
    }
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0xf1f78aa7, Offset: 0x5aef
// Size: 0x77
function private function_aed1655a59cf08b3( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    
    if ( isdefined( var_310e111620b410d7.hibernationsettings.var_1b70ca8d29ca863c ) && var_310e111620b410d7.hibernationsettings.var_1b70ca8d29ca863c.size > 0 )
    {
        return var_310e111620b410d7.hibernationsettings.var_1b70ca8d29ca863c[ 0 ].variant_object;
    }
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0xe8385a54, Offset: 0x5b6f
// Size: 0x5c
function private function_5d42b2eea9ef5f88( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    var_45c7ee998620b9b9 = var_310e111620b410d7.activitycenterobjectivemarkersettings.var_45c7ee998620b9b9;
    
    if ( isdefined( var_45c7ee998620b9b9 ) && var_45c7ee998620b9b9.size > 0 )
    {
        return var_45c7ee998620b9b9[ 0 ].variant_object;
    }
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x8f64201b, Offset: 0x5bd4
// Size: 0xce
function private function_5dd606cbfd46dd2d( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    var_5363846658bb4e31 = function_ac11e0fa8d55a478( var_e0bbf417e9178e6, 0 );
    
    if ( isarray( var_5363846658bb4e31 ) && isdefined( var_5363846658bb4e31[ 0 ].variant_object.var_a1d322feda017656[ 0 ].variant_object ) )
    {
        return var_5363846658bb4e31[ 0 ].variant_object.var_a1d322feda017656[ 0 ].variant_object;
    }
    
    var_b6d4b39a3d555217 = var_310e111620b410d7.var_fb4dd0352a7b7099.playerabandontriggers.var_a1d322feda017656;
    
    if ( isdefined( var_b6d4b39a3d555217 ) && var_b6d4b39a3d555217.size > 0 )
    {
        return var_b6d4b39a3d555217[ 0 ].variant_object;
    }
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0xbf87b752, Offset: 0x5cab
// Size: 0x3f
function private function_caadc60fcea307c5( var_e0bbf417e9178e6 )
{
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    return var_310e111620b410d7.var_fb4dd0352a7b7099.playerjoinsettings.playerjointriggers;
}

// Namespace activity_definition_utils
// Params 1, eflags: 0x4
// Checksum 0x3fe89da4, Offset: 0x5cf3
// Size: 0x18, Type: bool
function private function_5302a6396b276aff( activitydefinition )
{
    return istrue( activitydefinition.isactivitydefinition );
}

// Namespace activity_definition_utils
// Params 4, eflags: 0x4
// Checksum 0x1a4531a4, Offset: 0x5d14
// Size: 0x499
function private function_621f97c4662893e( var_e0bbf417e9178e6, fromstate, tostate, var_94aa8ab04072fb77 )
{
    var_94aa8ab04072fb77 = var_94aa8ab04072fb77 ?? [];
    var_310e111620b410d7 = function_40742eaedfb92ecb( var_e0bbf417e9178e6 );
    var_390a857a39f72e01 = var_310e111620b410d7.var_390a857a39f72e01;
    
    if ( isarray( var_390a857a39f72e01.var_84e9829da15875c3 ) )
    {
        foreach ( var_291f3cb14de3a70d in var_390a857a39f72e01.var_84e9829da15875c3 )
        {
            if ( isarray( var_291f3cb14de3a70d.var_b3bc337a73344cae ) )
            {
                if ( var_291f3cb14de3a70d.fromstate != fromstate && var_291f3cb14de3a70d.fromstate != "Any" || var_291f3cb14de3a70d.tostate != tostate && var_291f3cb14de3a70d.tostate != "Any" )
                {
                    continue;
                }
                
                foreach ( var_cbe4ff5cfa4b1ee9 in var_291f3cb14de3a70d.var_b3bc337a73344cae )
                {
                    if ( var_cbe4ff5cfa4b1ee9.variant_type == "Types_MustHavePlayersNearbyCondition" )
                    {
                        var_1add81fc387f85de = { #uniquename:"Players Within Zone Blocker", #tostate:var_291f3cb14de3a70d.tostate, #fromstate:var_291f3cb14de3a70d.fromstate };
                        var_1add81fc387f85de.zoneinfostruct = var_cbe4ff5cfa4b1ee9.variant_object.var_ea68aaeea2b91dc[ 0 ].variant_object;
                        var_94aa8ab04072fb77[ var_94aa8ab04072fb77.size ] = var_1add81fc387f85de;
                    }
                    
                    if ( var_cbe4ff5cfa4b1ee9.variant_type == "Types_MustHavePlayersFarAwayCondition" )
                    {
                        var_1add81fc387f85de = { #uniquename:"Players Outside Zone Blocker", #tostate:var_291f3cb14de3a70d.tostate, #fromstate:var_291f3cb14de3a70d.fromstate };
                        var_1add81fc387f85de.zoneinfostruct = var_cbe4ff5cfa4b1ee9.variant_object.var_ea68aaeea2b91dc[ 0 ].variant_object;
                        var_94aa8ab04072fb77[ var_94aa8ab04072fb77.size ] = var_1add81fc387f85de;
                    }
                    
                    if ( var_cbe4ff5cfa4b1ee9.variant_type == "Types_MustMeetMinimumPlayerCountCondition" )
                    {
                        if ( getminplayercount( var_e0bbf417e9178e6 ) > 0 )
                        {
                            var_1add81fc387f85de = { #uniquename:"Minimum Player Participation Blocker", #tostate:var_291f3cb14de3a70d.tostate, #fromstate:var_291f3cb14de3a70d.fromstate };
                            var_94aa8ab04072fb77[ var_94aa8ab04072fb77.size ] = var_1add81fc387f85de;
                        }
                    }
                    
                    if ( var_cbe4ff5cfa4b1ee9.variant_type == "Types_MustWaitForSpecifiedTimeDelayCondition" )
                    {
                        var_1add81fc387f85de = { #uniquename:"Time Delay Blocker", #tostate:var_291f3cb14de3a70d.tostate, #fromstate:var_291f3cb14de3a70d.fromstate };
                        var_1add81fc387f85de.timedelay = var_cbe4ff5cfa4b1ee9.variant_object.timedelay;
                        var_94aa8ab04072fb77[ var_94aa8ab04072fb77.size ] = var_1add81fc387f85de;
                    }
                    
                    if ( var_cbe4ff5cfa4b1ee9.variant_type == "Types_MustHaveVehicleCountCondition" )
                    {
                        var_1add81fc387f85de = { #uniquename:"Vehicle Count Blocker", #tostate:var_291f3cb14de3a70d.tostate, #fromstate:var_291f3cb14de3a70d.fromstate };
                        var_1add81fc387f85de.vehiclecount = var_cbe4ff5cfa4b1ee9.variant_object.vehiclecount;
                        var_94aa8ab04072fb77[ var_94aa8ab04072fb77.size ] = var_1add81fc387f85de;
                    }
                    
                    if ( var_cbe4ff5cfa4b1ee9.variant_type == "Types_MustOutsidePlayerFov" )
                    {
                        var_1add81fc387f85de = { #uniquename:"Player FOV Blocker", #tostate:var_291f3cb14de3a70d.tostate, #fromstate:var_291f3cb14de3a70d.fromstate };
                        var_1add81fc387f85de.fov = var_cbe4ff5cfa4b1ee9.variant_object.fov;
                        var_1add81fc387f85de.checkradius = var_cbe4ff5cfa4b1ee9.variant_object.checkradius;
                        var_94aa8ab04072fb77[ var_94aa8ab04072fb77.size ] = var_1add81fc387f85de;
                    }
                }
            }
        }
    }
    
    return var_94aa8ab04072fb77;
}

