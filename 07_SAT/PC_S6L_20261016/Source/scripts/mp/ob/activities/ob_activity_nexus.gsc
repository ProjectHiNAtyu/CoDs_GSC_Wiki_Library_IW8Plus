// scripts\mp\ob\activities\ob_activity_nexus.gsc  (hash_7873888781757e2f.gscc) (size: 5377 Bytes / 0x1501 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6bdf72f5 (1809806069)
// size ...... 5377 (0x1501)
// includes .. 16  (offset: 0x1391)
// strings ... 3   (offset: 0x1411)
// dev strs .. 17  (offset: 0x1435)
// exports ... 13  (offset: 0xa79)
// cseg ...... 0x8b + 0x9ee (0xa79)
// imports ... 61  (offset: 0xc81)
// animtree1 . 0   (offset: 0x1501)
// animtree2 . 0   (offset: 0x1501)
#using script_22aa38b6bedad90a;
#using script_4dbf393b22261d86;
#using script_77873e194e406c6d;
#using script_7eab314a5c18ea10;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\player_broadcasting;
#using scripts\common\system;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_starter;
#using scripts\mp\ob\activities\ob_activity_voting;
#using scripts\mp\ob\systems\ob_activity_instance_common;
#using scripts\mp\ob\systems\ob_activity_manager;

#namespace ob_activity_nexus;

// Namespace ob_activity_nexus
// Params 0, eflags: 0x5
// Checksum 0x2270646a, Offset: 0xa9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_activity_nexus", undefined, &function_f4681074cda3255f, undefined );
}

// Namespace ob_activity_nexus
// Params 0, eflags: 0x4
// Checksum 0x1eaf99a2, Offset: 0xca
// Size: 0xa
function private function_f4681074cda3255f()
{
    level thread function_5e83e215868f0a92();
}

// Namespace ob_activity_nexus
// Params 1, eflags: 0x4
// Checksum 0x42a2fa78, Offset: 0xdc
// Size: 0xa0
function private function_d6358626d6fa3376( params )
{
    activity_common::function_fa76765b37c0370d();
    
    foreach ( var_29e064d5673991a8 in level.activities.var_520f9c52039bc4a1 )
    {
        function_5170e8ecfb2e5fe7( undefined, var_29e064d5673991a8.var_612e0b25b87384b9 );
    }
}

// Namespace ob_activity_nexus
// Params 0
// Checksum 0x3db0b64f, Offset: 0x184
// Size: 0x144
function function_5e83e215868f0a92()
{
    activity_common::function_3abef4d1ee430ea4();
    ob_activity_voting::function_2828191605885a74();
    var_be6d32d0af4abdc8 = level.activities.playerfocusconditions;
    conditional_container::addcondition( var_be6d32d0af4abdc8, &namespace_e1c8f2179967550d::function_a185cc42dd8b626c, [] );
    activity_common::function_9fd46b47e0d8481d( 0, &registeractivity );
    activity_common::function_9fd46b47e0d8481d( 1, &ob_activity_instance_common::setupinstance );
    activity_common::function_9fd46b47e0d8481d( 4, &ob_activity_instance_common::cleanupinstance );
    activity_common::function_9fd46b47e0d8481d( 7, &ob_activity_starter::function_366c395db7231a5e );
    activity_common::function_9fd46b47e0d8481d( 9, &ob_activity_rewards::ob_openlootablecontainer );
    activity_common::function_9fd46b47e0d8481d( 10, &ob_activity_rewards::function_d5422be66a10dac0 );
    activity_common::function_9fd46b47e0d8481d( 8, &ob_activity_instance_common::function_e4e72aef67109761 );
    activity_common::function_9fd46b47e0d8481d( 11, &namespace_e1c8f2179967550d::function_28efaa36817be8e7 );
    activity_common::function_9fd46b47e0d8481d( 13, &function_80a08c0c839df13d );
    activity_common::function_9fd46b47e0d8481d( 14, &namespace_e1c8f2179967550d::function_17b1aba9c6f1eb57 );
    level.activities.defaultfunctions[ 7 ] = &ob_activity_rewards::function_91481a82c41f9021;
    level.activities.defaultfunctions[ 8 ] = &ob_activity_voting::function_8515664faece0dee;
    level callback::add( "zip_teleport_player", &function_eb680b3e71db3e8b );
    level callback::add( "register_activities", &function_d6358626d6fa3376 );
    level.activities.var_48788c8c3f477931 = [];
    
    /#
        activity_rewards_debug::function_37bf94fc2e69d250();
    #/
}

// Namespace ob_activity_nexus
// Params 1
// Checksum 0xc9f02109, Offset: 0x2d0
// Size: 0x80
function registeractivity( relevantparameters )
{
    activitytype = relevantparameters[ 0 ];
    activitytypestruct = level.activities.types[ activitytype ];
    activitytypestruct.commonfunctions[ 5 ] = activity_common::function_c18ae2ea1e9c715a( 5 );
    activitytypestruct.commonfunctions[ 7 ] = activity_common::function_c18ae2ea1e9c715a( 7 );
    activitytypestruct.commonfunctions[ 8 ] = activity_common::function_c18ae2ea1e9c715a( 8 );
}

// Namespace ob_activity_nexus
// Params 3
// Checksum 0x74cac98e, Offset: 0x358
// Size: 0x2ad
function function_5170e8ecfb2e5fe7( initfunction = undefined, var_12e5f6176e827fc7, var_be199bb9e036b40b )
{
    assert( isfunction( var_12e5f6176e827fc7 ), "<dev string:x24>" );
    var_bffb2dadef9b5a4d = [[ var_12e5f6176e827fc7 ]]();
    assert( isfunction( var_bffb2dadef9b5a4d.metadatafunction ), "<dev string:x7a>" );
    
    if ( !isdefined( var_be199bb9e036b40b ) )
    {
        var_be199bb9e036b40b = [];
    }
    
    var_410832b7518f6ee = 0;
    var_4cafe1b275c2065 = spawnstruct();
    var_4cafe1b275c2065.var_2b81a57e0a625d34 = [];
    var_67fe8b19a4d54144 = [[ var_bffb2dadef9b5a4d.metadatafunction ]]();
    
    foreach ( activityvariantname, var_6a1b5d581429fafd in var_67fe8b19a4d54144 )
    {
        /#
            if ( !( isdefined( var_6a1b5d581429fafd.locationorigin ) && isdefined( var_6a1b5d581429fafd.locationradius ) ) )
            {
                assertmsg( "<dev string:xd3>" + activityvariantname + "<dev string:xfd>" );
            }
        #/
        
        var_1f17725d59f6006a = function_f02c63b99c9614c9( var_be199bb9e036b40b, activityvariantname );
        var_f316b60501957d74 = !isdefined( var_1f17725d59f6006a );
        variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( activityvariantname );
        
        if ( variantscriptstructinfo.variantstruct.var_2cfd453d1fc7102c == "1" || !activity_common::function_6600377543df075( activityvariantname ) )
        {
            var_f316b60501957d74 = 0;
        }
        
        if ( var_f316b60501957d74 )
        {
            activitydefinitionbundle = function_4226758f80b35f6d( activityvariantname, var_67fe8b19a4d54144, var_bffb2dadef9b5a4d, var_4cafe1b275c2065 );
            var_2d78e1bb4b4d8fff = function_b4aedd0ea5b35623( activitydefinitionbundle, activityvariantname );
            activitycategory = var_2d78e1bb4b4d8fff.activitycategory;
            activitytype = var_2d78e1bb4b4d8fff.activitytype;
            
            if ( !activity_common::isactivityenabled( activitycategory, activitytype, activityvariantname ) )
            {
                /#
                    namespace_634561435cfb3169::activitynexuslog( "<dev string:x118>" + activitytype + "<dev string:x123>" + activityvariantname + "<dev string:x127>", @"hash_72a413c7683cfc8d" );
                #/
                
                continue;
            }
            
            if ( !ob_activity_manager::function_a50b0d2185211831( activitycategory, activitytype ) && !var_410832b7518f6ee )
            {
                var_410832b7518f6ee = function_aa915d741969067e( initfunction, var_12e5f6176e827fc7, activitycategory, activitytype );
            }
            else if ( !var_410832b7518f6ee )
            {
                ob_activity_manager::function_56a218667f3f96b7( activitycategory, activitytype, var_12e5f6176e827fc7 );
                var_410832b7518f6ee = 1;
            }
            
            ob_activity_manager::function_2c95c6046bda9988( var_2d78e1bb4b4d8fff );
            activity_definition_utils::function_894aafedf7770c7b( activityvariantname, var_67fe8b19a4d54144, var_bffb2dadef9b5a4d );
            continue;
        }
        
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x183>" + activityvariantname + "<dev string:x196>", @"hash_72a413c7683cfc8d" );
        #/
    }
}

// Namespace ob_activity_nexus
// Params 4, eflags: 0x4
// Checksum 0xf91a25d8, Offset: 0x60d
// Size: 0x73, Type: bool
function private function_aa915d741969067e( initfunction = undefined, var_12e5f6176e827fc7, activitycategory, activitytype )
{
    if ( !isdefined( level.activities.types[ activitytype ] ) && isfunction( initfunction ) )
    {
        activity_common::registeractivitytype( activitytype, initfunction );
    }
    
    ob_activity_manager::ob_register_class( activitycategory, activitytype, var_12e5f6176e827fc7, undefined, &function_715f55d2f6c1fb4e, undefined, undefined );
    return true;
}

// Namespace ob_activity_nexus
// Params 4, eflags: 0x4
// Checksum 0xfc7921c4, Offset: 0x689
// Size: 0xc7
function private function_4226758f80b35f6d( activityvariant, var_67fe8b19a4d54144, var_bffb2dadef9b5a4d, var_4cafe1b275c2065 )
{
    activitydefinitionbundlename = activity_definition_utils::function_608e492974320c76( activityvariant, var_67fe8b19a4d54144, var_bffb2dadef9b5a4d );
    
    if ( !isdefined( activitydefinitionbundlename ) )
    {
        assertmsg( "<dev string:x232>" + activityvariant + "<dev string:x25e>" );
        return;
    }
    
    activitydefinitionbundle = undefined;
    
    if ( isdefined( var_4cafe1b275c2065.var_2b81a57e0a625d34[ activitydefinitionbundlename ] ) )
    {
        activitydefinitionbundle = var_4cafe1b275c2065.var_2b81a57e0a625d34[ activitydefinitionbundlename ];
    }
    else
    {
        activitydefinitionbundle = getscriptbundle( activitydefinitionbundlename );
        var_4cafe1b275c2065.var_2b81a57e0a625d34[ activitydefinitionbundlename ] = activitydefinitionbundle;
        assert( isdefined( activitydefinitionbundle ), "<dev string:x2a9>" + activitydefinitionbundlename + "<dev string:x2bc>" + activityvariant + "<dev string:x2d3>" );
    }
    
    return activitydefinitionbundle;
}

// Namespace ob_activity_nexus
// Params 2, eflags: 0x4
// Checksum 0xbd8cfc13, Offset: 0x759
// Size: 0xc1
function private function_b4aedd0ea5b35623( activitydefinitionbundle, activityvariantname )
{
    activitycustomproperties = activity_definition_utils::function_9129cd8075c85c09( activitydefinitionbundle );
    var_2d78e1bb4b4d8fff = spawnstruct();
    var_2d78e1bb4b4d8fff.activitycategory = activity_definition_utils::function_897014a17bf1cbdc( activitydefinitionbundle );
    var_2d78e1bb4b4d8fff.activitytype = activitycustomproperties.activitytype;
    var_2d78e1bb4b4d8fff.var_4312b79c960726b6 = activityvariantname;
    var_2d78e1bb4b4d8fff.var_ec6d64d71dc7a62b = undefined;
    var_198a30d4bf7f5853 = activity_definition_utils::function_e9cffc15e34b2ea3( activitydefinitionbundle );
    
    if ( isdefined( var_198a30d4bf7f5853 ) )
    {
        var_2d78e1bb4b4d8fff.var_ec6d64d71dc7a62b = var_198a30d4bf7f5853.var_622af9ed9146813f;
    }
    
    var_2d78e1bb4b4d8fff.var_e43d97c215c8145e = ob_activity_definition_utils::function_ee700758cb24d61f( activityvariantname, activitydefinitionbundle );
    return var_2d78e1bb4b4d8fff;
}

// Namespace ob_activity_nexus
// Params 2, eflags: 0x4
// Checksum 0x2cb5e060, Offset: 0x823
// Size: 0x8d
function private function_715f55d2f6c1fb4e( var_49b766acb5226cde, params )
{
    assert( isarray( params ) && params.size >= 3 && params.size <= 4, "<dev string:x349>" );
    activitytype = params[ 0 ];
    varianttag = params[ 1 ];
    var_a98d07f7a054ff29 = params[ 2 ];
    additionalspawndatastruct = params[ 3 ];
    activityinstance = activity_instance_common::createactivityinstance( activitytype, varianttag, undefined, additionalspawndatastruct );
    return activityinstance;
}

// Namespace ob_activity_nexus
// Params 1, eflags: 0x4
// Checksum 0x1924ef0a, Offset: 0x8b9
// Size: 0x13d
function private function_eb680b3e71db3e8b( position )
{
    if ( !( isdefined( position ) && isdefined( position.origin ) ) )
    {
        assertmsg( "<dev string:x39b>" );
        return;
    }
    
    var_1d1735dea2ceacd7 = position.origin;
    var_f8683fa368c9526b = 10000;
    var_c6a18ace1b9e88ad = 5;
    var_b83867c744e07a60 = 0;
    
    foreach ( instance in level.activities.instances )
    {
        if ( !isdefined( instance ) )
        {
            continue;
        }
        
        var_5d7f8115d24e2b1f = activity_instance_common::function_776ee11e7acc64a5( instance );
        var_fd667b5b15d515f1 = distance2dsquared( var_1d1735dea2ceacd7, var_5d7f8115d24e2b1f );
        var_b1f10d401875f319 = var_f8683fa368c9526b * var_f8683fa368c9526b;
        
        if ( var_fd667b5b15d515f1 <= var_b1f10d401875f319 )
        {
            activity_instance_common::function_e80ace5c61b13188( instance, 0 );
        }
        
        var_b83867c744e07a60++;
        
        if ( var_b83867c744e07a60 >= var_c6a18ace1b9e88ad )
        {
            waitframe();
            var_b83867c744e07a60 = 0;
        }
    }
}

// Namespace ob_activity_nexus
// Params 1, eflags: 0x4
// Checksum 0x9b10a20, Offset: 0x9fe
// Size: 0x7b
function private function_80a08c0c839df13d( relevantparameters )
{
    assert( isarray( relevantparameters ) && relevantparameters.size == 2, "<dev string:x413>" );
    var_62dc0596d42b82c8 = relevantparameters[ 0 ];
    activityinstance = relevantparameters[ 1 ];
    
    if ( player_broadcasting::function_674ee71664c02724( var_62dc0596d42b82c8 ) )
    {
        broadcastinstance = var_62dc0596d42b82c8;
        conditional_container::addcondition( var_62dc0596d42b82c8, &namespace_e1c8f2179967550d::function_40cd7a0b02ad86f7, [ broadcastinstance, activityinstance ] );
    }
}

