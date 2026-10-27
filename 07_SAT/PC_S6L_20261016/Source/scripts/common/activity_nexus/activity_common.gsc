// scripts\common\activity_nexus\activity_common.gsc  (hash_157e7fec25404847.gscc) (size: 19252 Bytes / 0x4b34 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb47474c5 (3027530949)
// size ...... 19252 (0x4b34)
// includes .. 15  (offset: 0x4758)
// strings ... 31  (offset: 0x47d0)
// dev strs .. 37  (offset: 0x4970)
// exports ... 72  (offset: 0x2fd8)
// cseg ...... 0x364 + 0x2c74 (0x2fd8)
// imports ... 102 (offset: 0x3b18)
// animtree1 . 0   (offset: 0x4b34)
// animtree2 . 0   (offset: 0x4b34)
#using script_1f139695c61f1549;
#using script_4e1f1a7ef824ddd5;
#using script_570f992e202c79b4;
#using script_6d60a2f06878900a;
#using script_77873e194e406c6d;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_nexus_debug;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\system;
#using scripts\common\utility;

#namespace activity_common;

// Namespace activity_common
// Params 0, eflags: 0x5
// Checksum 0x5a806077, Offset: 0x382
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"activity_common", undefined, &function_838572d3a3477903, undefined );
}

// Namespace activity_common
// Params 0, eflags: 0x4
// Checksum 0xd9ca571d, Offset: 0x3a3
// Size: 0xa
function private function_838572d3a3477903()
{
    level thread function_8cf2a123305f4bcb();
}

// Namespace activity_common
// Params 0, eflags: 0x4
// Checksum 0x9cb2ae9c, Offset: 0x3b5
// Size: 0x36
function private function_8cf2a123305f4bcb()
{
    if ( isdefined( level.gametypebundle.activitynexussettings ) && getdvarint( @"scr_activities_enabled", 1 ) == 1 )
    {
        function_3abef4d1ee430ea4();
    }
}

/#

    // Namespace activity_common
    // Params 0, eflags: 0x4
    // Checksum 0xf474d3f1, Offset: 0x3f3
    // Size: 0x5, Type: dev
    function private function_2fd0e4ee113ab376()
    {
        
    }

#/

// Namespace activity_common
// Params 0
// Checksum 0xe57c2179, Offset: 0x400
// Size: 0xdd
function function_3abef4d1ee430ea4()
{
    if ( utility::flag( "activity_nexus_init_complete" ) )
    {
        return;
    }
    
    level.activities = function_5d58e172f0166ad0();
    activity_instance_common::function_1b1374bf81fbf953();
    namespace_e55955ff7520be97::function_2654b580d1cc4ea1( level.activities );
    activity_player_broadcasting::function_6eb258f51ed07851( level.activities );
    namespace_634561435cfb3169::function_562ded5a5af2cce1( level.activities );
    
    if ( function_8fe1a47c40904418( 3 ) )
    {
        level thread function_d259a48c79e82fd5();
    }
    
    function_8184a1a151ec1e26();
    function_fa76765b37c0370d();
    function_a285de515f50c5f0( 1, &activity_instance_common::setupinstance );
    function_a285de515f50c5f0( 8, &activity_participation::function_3bd36f038dc2b339 );
    function_a285de515f50c5f0( 7, &activity_participation::function_d9a1042dcc00e541 );
    level callback::add( #"register_activity_variant_definitions", &function_21c20837bb50091e );
    level thread function_5f6de6d9d4a7e8b5();
    utility::flag_set( "activity_nexus_init_complete" );
    
    /#
        activity_nexus_debug::function_a57a09800d3ae1d7();
        function_702e1db87224e642();
    #/
}

// Namespace activity_common
// Params 0, eflags: 0x4
// Checksum 0x10bdd028, Offset: 0x4e5
// Size: 0x11
function private function_5f6de6d9d4a7e8b5()
{
    system::function_85885b7687429f06();
    level thread activity_definition_utils::function_39e63e1ba6bb0132();
}

// Namespace activity_common
// Params 0, eflags: 0x4
// Checksum 0x6133884c, Offset: 0x4fe
// Size: 0x284
function private function_5d58e172f0166ad0()
{
    var_c1480fdbd46c428b = spawnstruct();
    var_c1480fdbd46c428b.types = [];
    var_c1480fdbd46c428b.definitions = [];
    var_c1480fdbd46c428b.instances = [];
    var_c1480fdbd46c428b.var_3a2ba6751c464ab7 = [];
    var_c1480fdbd46c428b.nexusoverrides = [];
    var_c1480fdbd46c428b.defaultfunctions = [];
    var_c1480fdbd46c428b.var_d520b27efd9742e5 = [];
    var_c1480fdbd46c428b.var_2ab2308e2350011c = [];
    var_c1480fdbd46c428b.var_d6002571bf84000f = [];
    var_c1480fdbd46c428b.var_7c4f0abc069ef777 = [];
    var_c1480fdbd46c428b.var_520f9c52039bc4a1 = [];
    var_c1480fdbd46c428b.var_487c8bbaf23e85c = 0;
    var_c1480fdbd46c428b.var_cd6ac69624ab4588 = [];
    
    if ( isdefined( level.gametypebundle.activitynexussettings ) )
    {
        activitynexussettings = getscriptbundle( level.gametypebundle.activitynexussettings );
    }
    
    if ( !isdefined( activitynexussettings ) )
    {
        activitynexussettings = getscriptbundle( "activitynexussettings:default_activitynexussettings" );
    }
    
    var_c1480fdbd46c428b.activitynexussettings = activitynexussettings;
    var_c1480fdbd46c428b.var_761525ac1f9b6c7 = function_4d3c3c13e0c518fa();
    var_c1480fdbd46c428b.var_d3b2bc276f3a2973 = namespace_4d597cbac7f48986::function_57d71970ad2eab25( activitynexussettings.activitydefinitioncachesize );
    var_c1480fdbd46c428b.var_ecd90a9fee3dfb36 = [];
    var_c1480fdbd46c428b.defaultfunctions[ 0 ] = &activity_instance_common::function_83ee46defb637d87;
    var_c1480fdbd46c428b.defaultfunctions[ 1 ] = &activity_instance_common::function_8981d2a4c2c8af1f;
    var_c1480fdbd46c428b.defaultfunctions[ 2 ] = &activity_instance_common::function_1a76eced6fe86097;
    var_c1480fdbd46c428b.defaultfunctions[ 3 ] = &activity_instance_common::function_bc98ac5775bd8084;
    var_c1480fdbd46c428b.defaultfunctions[ 4 ] = &activity_instance_common::function_94763020f8207b8b;
    var_c1480fdbd46c428b.defaultfunctions[ 6 ] = &activity_rewards::getrewardgroups;
    var_c1480fdbd46c428b.var_dd80223f1900e086 = [];
    var_c1480fdbd46c428b.activitymoments = [ "InstanceBegin", "InstanceEnd", "ActivityBegin", "ActivityEnd", "ActivitySuccess", "ActivityFailure", "PlayerJoin", "PlayerLeave", "PlayerAbandon", "PlayerRefocusedOnActivity", "PlayerEnteredAwarenessZone", "PlayerExitedAwarenessZone", "ActivityStartedHibernation", "ActivityStoppedHibernating" ];
    var_c1480fdbd46c428b function_6f362e53b158b091();
    var_c1480fdbd46c428b.var_7882cd355890cc53 = function_1c84d65e80ffc570( var_c1480fdbd46c428b.activitynexussettings );
    return var_c1480fdbd46c428b;
}

// Namespace activity_common
// Params 1, eflags: 0x4
// Checksum 0xec2acb3, Offset: 0x78b
// Size: 0x2f2
function private function_1c84d65e80ffc570( activitynexussettings )
{
    var_7882cd355890cc53 = { #enabledvariantstruct:{ #variantmap:[], #inclusionrule:"DisableTheseActivities" }, #var_36e6e172fa2b42a6:{ #typemap:[], #inclusionrule:"DisableTheseActivities" }, #var_d861953567e43a5a:{ #categorymap:[], #inclusionrule:"DisableTheseActivities" } };
    
    if ( isdefined( activitynexussettings ) )
    {
        var_7882cd355890cc53.var_d861953567e43a5a.inclusionrule = activitynexussettings.var_e26d4b1b6f2ad9e2.inclusionrule;
        var_7882cd355890cc53.var_36e6e172fa2b42a6.inclusionrule = activitynexussettings.var_972e5b6a1b11de9e.inclusionrule;
        var_7882cd355890cc53.enabledvariantstruct.inclusionrule = activitynexussettings.var_8ae0f151d48b3e81.inclusionrule;
        
        foreach ( var_3a256b3e9e49e8db in activitynexussettings.var_e26d4b1b6f2ad9e2.var_6e9c3a02854078c7 )
        {
            var_7882cd355890cc53.var_d861953567e43a5a.categorymap[ var_3a256b3e9e49e8db.value ] = 1;
        }
        
        foreach ( var_e4013744b2f3a8f3 in activitynexussettings.var_972e5b6a1b11de9e.toggledactivitytypes )
        {
            var_7882cd355890cc53.var_36e6e172fa2b42a6.typemap[ var_e4013744b2f3a8f3.value ] = 1;
        }
        
        foreach ( toggledvariantstruct in activitynexussettings.var_8ae0f151d48b3e81.var_c2bfbff5e2c1a7ad )
        {
            var_7882cd355890cc53.enabledvariantstruct.variantmap[ toggledvariantstruct.value ] = 1;
        }
    }
    else
    {
        assertmsg( "<dev string:x24>" );
    }
    
    return var_7882cd355890cc53;
}

// Namespace activity_common
// Params 0, eflags: 0x4
// Checksum 0x9a53df8d, Offset: 0xa86
// Size: 0xc
function private function_6f362e53b158b091()
{
    self.activitymomentcallbacks = [];
}

// Namespace activity_common
// Params 0, eflags: 0x4
// Checksum 0xda4f373e, Offset: 0xa9a
// Size: 0x5a
function private function_d259a48c79e82fd5()
{
    level endon( #"game_ended" );
    
    /#
        if ( !utility::flag( "<dev string:xb9>" ) )
        {
            namespace_634561435cfb3169::activitynexuslog( "<dev string:xd7>", @"hash_4a93c7546965668" );
        }
    #/
    
    utility::flag_wait( "ai_spawn_director_initialized" );
    utility::callsharedfunc( #"ai_spawn_director", #"activityaiencounterinit" );
}

/#

    // Namespace activity_common
    // Params 0, eflags: 0x4
    // Checksum 0x7e424db3, Offset: 0xafc
    // Size: 0x9d, Type: dev
    function private function_702e1db87224e642()
    {
        namespace_634561435cfb3169::activitynexuslog( "<dev string:x163>", @"hash_4a93c7546965668" );
        
        if ( !function_8fe1a47c40904418( 0 ) )
        {
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x18b>", @"hash_4a93c7546965668" );
        }
        
        if ( !function_8fe1a47c40904418( 1 ) )
        {
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x1e2>", @"hash_4a93c7546965668" );
        }
        
        if ( !function_8fe1a47c40904418( 2 ) )
        {
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x23a>", @"hash_4a93c7546965668" );
        }
        
        if ( !function_8fe1a47c40904418( 3 ) )
        {
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x29b>", @"hash_4a93c7546965668" );
        }
    }

    // Namespace activity_common
    // Params 0, eflags: 0x4
    // Checksum 0xac1a7622, Offset: 0xba1
    // Size: 0x5, Type: dev
    function private function_26c1dec33f2cbc41()
    {
        
    }

#/

// Namespace activity_common
// Params 2
// Checksum 0xade458fd, Offset: 0xbae
// Size: 0x11d
function registeractivitytype( activitytype, initfunction = undefined )
{
    if ( !utility::flag( "activity_nexus_init_complete" ) )
    {
        return;
    }
    
    if ( !isdefined( level.activities.types[ activitytype ] ) && function_27be3931cf682460( activitytype ) )
    {
        level.activities.types[ activitytype ] = spawnstruct();
        activitytypestruct = level.activities.types[ activitytype ];
        activitytypestruct.shareddata = {};
        
        if ( isdefined( level.activities.nexusoverrides[ 0 ] ) )
        {
            function_2ba08ba0c0544a1a( 0, [ activitytype ], 0 );
        }
        
        activitytypestruct function_6f362e53b158b091();
        
        if ( isfunction( initfunction ) )
        {
            [[ initfunction ]]();
        }
        else
        {
            /#
                namespace_634561435cfb3169::activitynexuslog( "<dev string:x2fa>" + activitytype, @"hash_72a413c7683cfc8d" );
            #/
        }
        
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x344>" + activitytype + "<dev string:x354>", @"hash_72a413c7683cfc8d" );
        #/
    }
}

// Namespace activity_common
// Params 3
// Checksum 0xa606353c, Offset: 0xcd3
// Size: 0xbc
function function_3dd1ab7de513044f( activitymoment, callbackfunction, activitytype )
{
    callbackcontainer = level.activities;
    
    if ( isdefined( activitytype ) )
    {
        if ( !level.activities.types || !level.activities.types[ activitytype ] )
        {
            return 0;
        }
        
        callbackcontainer = level.activities.types[ activitytype ];
    }
    
    if ( !callbackcontainer.activitymomentcallbacks || !callbackcontainer.activitymomentcallbacks[ activitymoment ] )
    {
        return 0;
    }
    
    return arraycontains( callbackcontainer.activitymomentcallbacks[ activitymoment ], callbackfunction );
}

// Namespace activity_common
// Params 3
// Checksum 0x221df586, Offset: 0xd98
// Size: 0xda
function function_2dd4f07fa5c3e911( activitymoment, callbackfunction, activitytype )
{
    callbackcontainer = level.activities;
    
    if ( isdefined( activitytype ) )
    {
        assert( isdefined( level.activities.types[ activitytype ] ), "<dev string:x38f>" );
        callbackcontainer = level.activities.types[ activitytype ];
    }
    
    assert( isdefined( callbackcontainer.activitymomentcallbacks ), "<dev string:x3d7>" );
    
    if ( !isdefined( callbackcontainer.activitymomentcallbacks[ activitymoment ] ) )
    {
        callbackcontainer.activitymomentcallbacks[ activitymoment ] = [];
    }
    
    callbackarraysize = callbackcontainer.activitymomentcallbacks[ activitymoment ].size;
    callbackcontainer.activitymomentcallbacks[ activitymoment ][ callbackarraysize ] = callbackfunction;
}

// Namespace activity_common
// Params 2
// Checksum 0x5a5cc659, Offset: 0xe7a
// Size: 0x66
function function_b1f11552b32b5a58( activitymoment, relevantinfostruct )
{
    function_1bea2b983bb8abad( level.activities, activitymoment, relevantinfostruct );
    activitytype = self.type;
    function_1bea2b983bb8abad( level.activities.types[ activitytype ], activitymoment, relevantinfostruct );
    callback::callback( activitymoment, relevantinfostruct );
}

// Namespace activity_common
// Params 1
// Checksum 0xe6af81aa, Offset: 0xee8
// Size: 0x67
function connectactivityinstance( activityinstance )
{
    instid = activityinstance.id;
    level.activities.instances[ instid ] = activityinstance;
    function_d630366b03a83c40( activityinstance );
    
    if ( activity_definition_utils::function_31ae56e3ed53afc0( activityinstance ) )
    {
        level.activities.var_d520b27efd9742e5[ instid ] = activityinstance;
    }
}

// Namespace activity_common
// Params 1
// Checksum 0x683c908d, Offset: 0xf57
// Size: 0x8d
function function_d630366b03a83c40( activityinstance )
{
    instid = activityinstance.id;
    
    if ( activity_definition_utils::function_65a59cc724e4ec89( activityinstance, 0 ) )
    {
        level.activities.var_2ab2308e2350011c[ instid ] = activityinstance;
    }
    
    if ( activity_definition_utils::function_78afebeb162cfa68( activityinstance ) )
    {
        level.activities.var_d6002571bf84000f[ instid ] = activityinstance;
    }
    
    if ( activity_definition_utils::function_fbd3d5a133e04d8a( activityinstance ) )
    {
        level.activities.var_7c4f0abc069ef777[ instid ] = activityinstance;
    }
}

// Namespace activity_common
// Params 1
// Checksum 0xadd4c0e, Offset: 0xfec
// Size: 0x65
function function_15af4039c83423a6( activityinstance )
{
    instid = activityinstance.id;
    level.activities.var_2ab2308e2350011c[ instid ] = undefined;
    level.activities.var_d6002571bf84000f[ instid ] = undefined;
    level.activities.var_7c4f0abc069ef777[ instid ] = undefined;
}

// Namespace activity_common
// Params 1
// Checksum 0xce59a435, Offset: 0x1059
// Size: 0x83
function disconnectactivityinstance( activityinstance )
{
    instid = activityinstance.id;
    level.activities.var_cd6ac69624ab4588[ level.activities.var_cd6ac69624ab4588.size ] = instid;
    level.activities.instances[ instid ] = undefined;
    level.activities.var_d520b27efd9742e5[ instid ] = undefined;
    function_15af4039c83423a6( activityinstance );
}

// Namespace activity_common
// Params 2
// Checksum 0x712a73c4, Offset: 0x10e4
// Size: 0x203
function function_cb0bd0d51905badf( joininteracts, associatedactivityinstance )
{
    instanceid = associatedactivityinstance.id;
    var_ca3f65fdba0a9ed2 = level.activities;
    
    if ( !isarray( joininteracts ) )
    {
        joininteracts = [ joininteracts ];
    }
    
    /#
        if ( isdefined( var_ca3f65fdba0a9ed2.var_3a2ba6751c464ab7[ instanceid ] ) )
        {
            foreach ( joininteract in joininteracts )
            {
                joininteractkey = function_f02c63b99c9614c9( var_ca3f65fdba0a9ed2.var_3a2ba6751c464ab7[ instanceid ], joininteract );
                
                if ( isdefined( joininteractkey ) )
                {
                    activityinstance = level.activities.instances[ instanceid ];
                    activityvariantname = activityinstance.varianttag;
                    activitytype = activityinstance.type;
                    assert( "<dev string:x41e>" + activitytype + "<dev string:x499>" + activityvariantname );
                    return;
                }
            }
        }
    #/
    
    foreach ( joininteract in joininteracts )
    {
        joininteract.associatedactivityinstance = associatedactivityinstance;
        
        if ( !isdefined( var_ca3f65fdba0a9ed2.var_3a2ba6751c464ab7[ instanceid ] ) )
        {
            var_ca3f65fdba0a9ed2.var_3a2ba6751c464ab7[ instanceid ] = [];
        }
        
        var_ca3f65fdba0a9ed2.var_3a2ba6751c464ab7[ instanceid ][ var_ca3f65fdba0a9ed2.var_3a2ba6751c464ab7[ instanceid ].size ] = joininteract;
    }
}

// Namespace activity_common
// Params 1
// Checksum 0xb5910674, Offset: 0x12ef
// Size: 0xe8
function function_5293d009a2fe9978( associatedactivityinstance )
{
    instanceid = associatedactivityinstance.id;
    var_ca3f65fdba0a9ed2 = level.activities;
    activityjoininteracts = var_ca3f65fdba0a9ed2.var_3a2ba6751c464ab7[ instanceid ];
    
    if ( isdefined( activityjoininteracts ) )
    {
        foreach ( activityjoininteract in activityjoininteracts )
        {
            if ( isdefined( activityjoininteract ) )
            {
                activityjoininteract.associatedactivityinstance = associatedactivityinstance;
                activityjoininteract.associatedactivityinstance = undefined;
            }
        }
        
        var_ca3f65fdba0a9ed2.var_3a2ba6751c464ab7[ instanceid ] = undefined;
    }
}

// Namespace activity_common
// Params 3, eflags: 0x4
// Checksum 0x5ad36670, Offset: 0x13df
// Size: 0xce
function private function_1bea2b983bb8abad( activitymomentcallbackcontainer, activitymoment, relevantinfostruct )
{
    var_3d3beb3c212d444d = isdefined( activitymomentcallbackcontainer.activitymomentcallbacks[ activitymoment ] ) && activitymomentcallbackcontainer.activitymomentcallbacks[ activitymoment ].size > 0;
    
    if ( var_3d3beb3c212d444d )
    {
        foreach ( callback in activitymomentcallbackcontainer.activitymomentcallbacks[ activitymoment ] )
        {
            self thread [[ callback ]]( relevantinfostruct );
        }
    }
}

// Namespace activity_common
// Params 1, eflags: 0x4
// Checksum 0x28a62770, Offset: 0x14b5
// Size: 0x13
function private function_21c20837bb50091e( params )
{
    activity_definition_utils::function_39e63e1ba6bb0132();
}

/#

    // Namespace activity_common
    // Params 0, eflags: 0x4
    // Checksum 0xd3a2b5d7, Offset: 0x14d0
    // Size: 0x5, Type: dev
    function private function_b39008193fede840()
    {
        
    }

#/

// Namespace activity_common
// Params 3
// Checksum 0xcdcece4, Offset: 0x14dd
// Size: 0x84
function function_dd98a8f03079aa86( activitycategory, activityfunctiontype, fn )
{
    if ( !isdefined( level.activities.var_5b91f4265dd3b5d8[ activitycategory ] ) )
    {
        level.activities.var_5b91f4265dd3b5d8[ activitycategory ] = [];
    }
    
    if ( !isdefined( level.activities.var_5b91f4265dd3b5d8[ activitycategory ][ activityfunctiontype ] ) )
    {
        level.activities.var_5b91f4265dd3b5d8[ activitycategory ][ activityfunctiontype ] = fn;
    }
}

// Namespace activity_common
// Params 2
// Checksum 0x3b9bcb6c, Offset: 0x1569
// Size: 0x8b
function function_f8e122bba9be6ceb( activitycategory, activityfunctiontype )
{
    if ( !activitycategory || !activityfunctiontype )
    {
        return;
    }
    
    if ( !level.activities.var_5b91f4265dd3b5d8 || !level.activities.var_5b91f4265dd3b5d8[ activitycategory ] || !level.activities.var_5b91f4265dd3b5d8[ activitycategory ][ activityfunctiontype ] )
    {
        return;
    }
    
    return level.activities.var_5b91f4265dd3b5d8[ activitycategory ][ activityfunctiontype ];
}

// Namespace activity_common
// Params 3
// Checksum 0xadf2c04d, Offset: 0x15fd
// Size: 0x3e
function function_fc5e37706648886e( activitycategory, activityfunctiontype, relevantinfostruct )
{
    var_f58e1bd0c7540abb = function_f8e122bba9be6ceb( activitycategory, activityfunctiontype );
    
    if ( var_f58e1bd0c7540abb )
    {
        return [[ var_f58e1bd0c7540abb ]]( relevantinfostruct );
    }
}

// Namespace activity_common
// Params 2
// Checksum 0xb60cdcf4, Offset: 0x1644
// Size: 0x4d
function function_9fd46b47e0d8481d( nexusoverridetype, overridefunction )
{
    if ( isdefined( nexusoverridetype ) && isfunction( overridefunction ) )
    {
        level.activities.nexusoverrides[ nexusoverridetype ] = overridefunction;
        return;
    }
    
    assertmsg( "<dev string:x49d>" );
}

// Namespace activity_common
// Params 3
// Checksum 0xf54f60a6, Offset: 0x1699
// Size: 0xc0
function function_944074f3079c1d4e( activitytype, activityfunctiontype, overridefunction )
{
    if ( !isdefined( level.activities.types[ activitytype ] ) )
    {
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x4ea>" + activityfunctiontype + "<dev string:x50b>" + activitytype + "<dev string:x512>" + "<dev string:x51b>", @"hash_22e4e38cab273e93" );
        #/
        
        registeractivitytype( activitytype, undefined );
    }
    
    activitytypestruct = level.activities.types[ activitytype ];
    
    if ( !isdefined( activitytypestruct.commonfunctions ) )
    {
        activitytypestruct.commonfunctions = [];
    }
    
    activitytypestruct.commonfunctions[ activityfunctiontype ] = overridefunction;
}

// Namespace activity_common
// Params 3
// Checksum 0x26f6423b, Offset: 0x1761
// Size: 0xaa
function runactivityfunction( activityinstance, activityfunctiontype, relevantinfostruct )
{
    activitytype = activityinstance.type;
    assert( isdefined( level.activities.types[ activitytype ] ), "<dev string:x5b9>" );
    activityfunction = getactivityfunction( activitytype, activityfunctiontype );
    assert( isdefined( activityfunction ), "<dev string:x610>" );
    
    if ( function_e10908e9dc57637f( activityfunctiontype ) )
    {
        if ( isdefined( relevantinfostruct ) )
        {
            return activityinstance [[ activityfunction ]]( relevantinfostruct );
        }
        else
        {
            return activityinstance [[ activityfunction ]]();
        }
    }
    
    activityinstance thread function_c56a39cd4ea702e0( activityinstance, activityfunction, relevantinfostruct );
}

// Namespace activity_common
// Params 2
// Checksum 0x666fe18c, Offset: 0x1813
// Size: 0x9d
function getactivityfunction( activitytype, activityfunctiontype )
{
    assert( isdefined( level.activities.types[ activitytype ] ), "<dev string:x5b9>" );
    activitytypestruct = level.activities.types[ activitytype ];
    
    if ( !activitytypestruct.commonfunctions || !activitytypestruct.commonfunctions.size )
    {
        return function_c18ae2ea1e9c715a( activityfunctiontype );
    }
    
    return activitytypestruct.commonfunctions[ activityfunctiontype ] ?? function_c18ae2ea1e9c715a( activityfunctiontype );
}

// Namespace activity_common
// Params 1
// Checksum 0x3d469392, Offset: 0x18b9
// Size: 0x22
function function_c18ae2ea1e9c715a( activityfunctiontype )
{
    return level.activities.defaultfunctions[ activityfunctiontype ];
}

// Namespace activity_common
// Params 2
// Checksum 0xbad093bb, Offset: 0x18e4
// Size: 0x4f, Type: bool
function function_460fd843724fc9b1( activitytype, activityfunctiontype )
{
    defaultactivityfunction = function_c18ae2ea1e9c715a( activityfunctiontype );
    currentactivityfunction = getactivityfunction( activitytype, activityfunctiontype );
    
    if ( !isdefined( currentactivityfunction ) || defaultactivityfunction == currentactivityfunction )
    {
        return false;
    }
    
    return true;
}

// Namespace activity_common
// Params 1
// Checksum 0xd8b230bb, Offset: 0x193c
// Size: 0x23, Type: bool
function function_e9bc8a898f05077d( nexusoverridetype )
{
    return isdefined( level.activities.nexusoverrides[ nexusoverridetype ] );
}

// Namespace activity_common
// Params 3
// Checksum 0x73c3308f, Offset: 0x1968
// Size: 0x89
function function_2ba08ba0c0544a1a( nexusoverridetype, relevantparameters, shouldthread )
{
    if ( isfunction( level.activities.nexusoverrides[ nexusoverridetype ] ) )
    {
        if ( shouldthread )
        {
            return self thread [[ level.activities.nexusoverrides[ nexusoverridetype ] ]]( relevantparameters );
        }
        else
        {
            return [[ level.activities.nexusoverrides[ nexusoverridetype ] ]]( relevantparameters );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x684>" );
}

// Namespace activity_common
// Params 2, eflags: 0x4
// Checksum 0x878de73a, Offset: 0x19f9
// Size: 0x3a
function private function_a285de515f50c5f0( nexusoverridetype, function )
{
    if ( !isdefined( level.activities.nexusoverrides[ nexusoverridetype ] ) )
    {
        function_9fd46b47e0d8481d( nexusoverridetype, function );
    }
}

// Namespace activity_common
// Params 1, eflags: 0x4
// Checksum 0xe870df5b, Offset: 0x1a3b
// Size: 0x44
function private function_e10908e9dc57637f( activityfunctiontype )
{
    var_9693e52c9a8ef91e = [ 4, 5, 6, 7, 8, 10 ];
    return arraycontains( var_9693e52c9a8ef91e, activityfunctiontype );
}

// Namespace activity_common
// Params 3, eflags: 0x4
// Checksum 0xf67fb401, Offset: 0x1a88
// Size: 0x5a
function private function_c56a39cd4ea702e0( activityinstance, overridefunction, relevantinfostruct )
{
    activityinstance endon( #"instance_destroyed" );
    
    if ( isfunction( overridefunction ) )
    {
        if ( isdefined( relevantinfostruct ) )
        {
            activityinstance [[ overridefunction ]]( relevantinfostruct );
        }
        else
        {
            activityinstance [[ overridefunction ]]();
        }
        
        return;
    }
    
    assertmsg( "<dev string:x6cc>" );
}

/#

    // Namespace activity_common
    // Params 0, eflags: 0x4
    // Checksum 0x149a7489, Offset: 0x1aea
    // Size: 0x5, Type: dev
    function private function_cbc93eb46f7d34b5()
    {
        
    }

#/

// Namespace activity_common
// Params 1
// Checksum 0x28e53a7f, Offset: 0x1af7
// Size: 0x51
function function_e1df676808c1d1e3( var_612e0b25b87384b9 )
{
    if ( !utility::flag( "activity_nexus_init_complete" ) )
    {
        return;
    }
    
    level.activities.var_520f9c52039bc4a1[ level.activities.var_520f9c52039bc4a1.size ] = { #var_612e0b25b87384b9:var_612e0b25b87384b9 };
}

// Namespace activity_common
// Params 0
// Checksum 0x93c3b77, Offset: 0x1b50
// Size: 0xa
function function_fa76765b37c0370d()
{
    level thread function_29b3d1634de44643();
}

// Namespace activity_common
// Params 1
// Checksum 0xb2c8d37d, Offset: 0x1b62
// Size: 0x42
function function_d54f02a6971bb9ab( activityvariantname )
{
    var_ca3f65fdba0a9ed2 = level.activities;
    
    if ( isdefined( var_ca3f65fdba0a9ed2.var_dd80223f1900e086[ activityvariantname ] ) )
    {
        return var_ca3f65fdba0a9ed2.var_dd80223f1900e086[ activityvariantname ];
    }
}

// Namespace activity_common
// Params 2
// Checksum 0x3e265b02, Offset: 0x1bad
// Size: 0x119
function function_98ded9c70478e2bf( activitytype, variantfilter )
{
    var_ca3f65fdba0a9ed2 = level.activities;
    
    if ( var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5[ activitytype ] )
    {
        if ( variantfilter && activitytype != variantfilter )
        {
            filterednodes = [];
            variantlength = variantfilter.size;
            
            foreach ( node in var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5[ activitytype ] )
            {
                variant = getsubstr( node.variantstruct.name, 0, variantlength );
                
                if ( variant == variantfilter )
                {
                    filterednodes[ filterednodes.size ] = node;
                }
            }
            
            return filterednodes;
        }
        
        return var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5[ activitytype ];
    }
}

// Namespace activity_common
// Params 1
// Checksum 0x2d5aac6f, Offset: 0x1ccf
// Size: 0x5d
function function_9b15260622ed4dbe( activitytype )
{
    assert( isdefined( level.activities.types[ activitytype ] ), "<dev string:x703>" );
    activitytypestruct = level.activities.types[ activitytype ];
    return activitytypestruct.shareddata;
}

// Namespace activity_common
// Params 0
// Checksum 0x3ab48081, Offset: 0x1d35
// Size: 0x15
function function_bfafd481c8062532()
{
    return level.activities.var_761525ac1f9b6c7;
}

// Namespace activity_common
// Params 0
// Checksum 0xeb59a36, Offset: 0x1d53
// Size: 0x1f
function function_7f6dd954bcc3f939()
{
    var_746f354b2ae301a2 = function_bfafd481c8062532();
    return var_746f354b2ae301a2.var_c801d95a4eddacdd;
}

// Namespace activity_common
// Params 1
// Checksum 0xfbbf3305, Offset: 0x1d7b
// Size: 0x2c
function function_7b714d2eb39b5e9( activitycategory )
{
    var_746f354b2ae301a2 = function_bfafd481c8062532();
    return var_746f354b2ae301a2.var_e18eebd3f78e2944[ activitycategory ];
}

// Namespace activity_common
// Params 0, eflags: 0x4
// Checksum 0x2476a828, Offset: 0x1db0
// Size: 0x4f0
function private function_29b3d1634de44643()
{
    level endon( #"game_ended" );
    var_ca3f65fdba0a9ed2 = level.activities;
    
    if ( var_ca3f65fdba0a9ed2.var_2672eee610fd72c0 )
    {
        return;
    }
    
    var_ca3f65fdba0a9ed2.var_2672eee610fd72c0 = 1;
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    activitynexussettings = level.activities.activitynexussettings;
    
    if ( activitynexussettings.var_9524cfa780ae0ff4 )
    {
        utility::flag_wait( "create_script_initialized" );
    }
    
    variantscriptstructs = utility::getstructarray( "activity_nexus_variant", "targetname" );
    variantscriptstructs = arraycombine( variantscriptstructs, utility::getstructarray( "activity_nexus_variant", "script_noteworthy" ) );
    var_ca3f65fdba0a9ed2.var_dd80223f1900e086 = [];
    var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5 = [];
    variantcounts = [];
    
    foreach ( variantscriptstruct in variantscriptstructs )
    {
        if ( isdefined( variantscriptstruct.name ) && variantscriptstruct.name != "" || variantscriptstruct.var_ba5009a3f1cfb61b )
        {
            if ( !variantscriptstruct.var_ba5009a3f1cfb61b && isdefined( variantscriptstruct.name ) && variantscriptstruct.name != "" && var_ca3f65fdba0a9ed2.var_dd80223f1900e086[ variantscriptstruct.name ] )
            {
                continue;
            }
            
            variantscriptstructinfo = { #linkedstructs:variantscriptstruct function_dbff04faaa238b39(), #variantstruct:variantscriptstruct };
            activitytype = undefined;
            
            if ( variantscriptstruct.activity_bundle )
            {
                var_34bb6763f902e86c = variantscriptstruct.activity_bundle;
                
                if ( !isxhashasset( var_34bb6763f902e86c ) )
                {
                    var_9955f93e8f3e6b37 = strtok( var_34bb6763f902e86c, ":" );
                    
                    if ( var_9955f93e8f3e6b37.size == 1 )
                    {
                        var_34bb6763f902e86c = "activitydefinition:" + var_34bb6763f902e86c;
                    }
                }
                
                customproperties = activity_definition_utils::function_9129cd8075c85c09( getscriptbundle( var_34bb6763f902e86c ) );
                activitytype = customproperties.activitytype;
            }
            
            variantbase = undefined;
            
            if ( variantscriptstruct.var_ba5009a3f1cfb61b && !isdefined( variantscriptstruct.variantindex ) )
            {
                variantbase = isdefined( variantscriptstruct.name ) && variantscriptstruct.name != "" ? variantscriptstruct.name : activitytype;
                
                if ( variantbase && variantcounts[ variantbase ] )
                {
                    variantscriptstruct.name = variantbase + "_variant_index_" + variantcounts[ variantbase ];
                }
                else
                {
                    variantscriptstruct.name = variantbase;
                }
            }
            
            var_ca3f65fdba0a9ed2.var_dd80223f1900e086[ variantscriptstruct.name ] = variantscriptstructinfo;
            
            if ( activitytype )
            {
                if ( !isdefined( var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5[ activitytype ] ) )
                {
                    var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5[ activitytype ] = [];
                }
                
                var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5[ activitytype ][ var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5[ activitytype ].size ] = variantscriptstructinfo;
            }
            
            if ( variantbase )
            {
                if ( !isdefined( variantcounts[ variantbase ] ) )
                {
                    variantcounts[ variantbase ] = 0;
                }
                
                variantscriptstruct.variantindex = variantcounts[ variantbase ];
                variantcounts[ variantbase ]++;
            }
        }
    }
    
    utility::flag_set( "activity_map_data_cached" );
    
    /#
        if ( isdefined( var_ca3f65fdba0a9ed2.var_dd80223f1900e086 ) )
        {
            foreach ( activityvariantname, variantscriptstructinfo in var_ca3f65fdba0a9ed2.var_dd80223f1900e086 )
            {
                level.var_c89b26c59f225dcc = [];
                variantstruct = variantscriptstructinfo.variantstruct;
                var_b815e2ea79ce8836 = activityvariantname;
                
                while ( isdefined( variantstruct ) )
                {
                    if ( isdefined( level.var_c89b26c59f225dcc[ var_b815e2ea79ce8836 ] ) )
                    {
                        assertmsg( "<dev string:x748>" + var_b815e2ea79ce8836 + "<dev string:x787>" + variantstruct.parentvariant + "<dev string:x79f>" + var_b815e2ea79ce8836 + "<dev string:x7bb>" );
                        break;
                    }
                    
                    level.var_c89b26c59f225dcc[ var_b815e2ea79ce8836 ] = 1;
                    
                    if ( isstring( variantstruct.parentvariant ) )
                    {
                        var_b815e2ea79ce8836 = variantstruct.parentvariant;
                        variantscriptstructinfo = var_ca3f65fdba0a9ed2.var_dd80223f1900e086[ var_b815e2ea79ce8836 ];
                        variantstruct = variantscriptstructinfo.variantstruct;
                        continue;
                    }
                    
                    variantstruct = undefined;
                }
            }
        }
    #/
    
    var_ca3f65fdba0a9ed2.var_2672eee610fd72c0 = 0;
}

// Namespace activity_common
// Params 0, eflags: 0x4
// Checksum 0x4667d148, Offset: 0x22a8
// Size: 0x48
function private function_4d3c3c13e0c518fa()
{
    var_761525ac1f9b6c7 = spawnstruct();
    var_761525ac1f9b6c7.var_c801d95a4eddacdd = [];
    var_761525ac1f9b6c7.var_e18eebd3f78e2944 = [];
    var_761525ac1f9b6c7.var_91cc064b6ec8a6c = [];
    var_761525ac1f9b6c7.var_3d3e562ecf5625f8 = [];
    return var_761525ac1f9b6c7;
}

// Namespace activity_common
// Params 0, eflags: 0x4
// Checksum 0x3286855c, Offset: 0x22f9
// Size: 0x26
function private function_8184a1a151ec1e26()
{
    var_761525ac1f9b6c7 = function_bfafd481c8062532();
    function_1ec2c7cdebaf2e4f( var_761525ac1f9b6c7 );
    function_494ea9a97c0148ec( var_761525ac1f9b6c7 );
}

// Namespace activity_common
// Params 1, eflags: 0x4
// Checksum 0x856afa5d, Offset: 0x2327
// Size: 0x2c3
function private function_1ec2c7cdebaf2e4f( var_761525ac1f9b6c7 )
{
    bundlenames = getscriptbundlenames( "activityplayerbroadcast" );
    
    foreach ( var_cd90e38e534ed7d1 in bundlenames )
    {
        var_daf2dccf5508304a = getscriptbundle( var_cd90e38e534ed7d1 );
        
        if ( isdefined( var_daf2dccf5508304a ) )
        {
            var_3b532650e973bd1f = isdefined( var_daf2dccf5508304a.activityplayerbroadcasts ) && var_daf2dccf5508304a.activityplayerbroadcasts.size > 0;
            var_7ab0b735a1743f06 = isdefined( var_daf2dccf5508304a.sharingoptions ) && var_daf2dccf5508304a.sharingoptions.size > 0;
            
            if ( var_3b532650e973bd1f && var_7ab0b735a1743f06 )
            {
                broadcastsharingoptions = var_daf2dccf5508304a.sharingoptions[ 0 ].variant_object;
                
                if ( broadcastsharingoptions.var_78bba94883ddaa51 )
                {
                    var_bbd73544d6d77c10 = namespace_2aca03e533f9f843::function_2b7077459c53fdd3( var_daf2dccf5508304a.activityplayerbroadcasts );
                    
                    foreach ( var_d4fd22cb605323c3 in var_bbd73544d6d77c10 )
                    {
                        var_761525ac1f9b6c7.var_c801d95a4eddacdd[ var_761525ac1f9b6c7.var_c801d95a4eddacdd.size ] = var_d4fd22cb605323c3;
                    }
                    
                    continue;
                }
                
                if ( broadcastsharingoptions.var_2f39334fecc740c7 && isdefined( broadcastsharingoptions.activitycategory ) )
                {
                    var_24422ec54fe19c0f = broadcastsharingoptions.activitycategory;
                    assert( var_24422ec54fe19c0f != "<dev string:x7e4>", "<dev string:x7e9>" );
                    
                    if ( !isdefined( var_761525ac1f9b6c7.var_e18eebd3f78e2944[ var_24422ec54fe19c0f ] ) )
                    {
                        var_761525ac1f9b6c7.var_e18eebd3f78e2944[ var_24422ec54fe19c0f ] = [];
                    }
                    
                    var_bbd73544d6d77c10 = namespace_2aca03e533f9f843::function_2b7077459c53fdd3( var_daf2dccf5508304a.activityplayerbroadcasts );
                    
                    foreach ( var_d4fd22cb605323c3 in var_bbd73544d6d77c10 )
                    {
                        var_761525ac1f9b6c7.var_e18eebd3f78e2944[ var_24422ec54fe19c0f ][ var_761525ac1f9b6c7.var_e18eebd3f78e2944[ var_24422ec54fe19c0f ].size ] = var_d4fd22cb605323c3;
                    }
                }
            }
        }
    }
}

// Namespace activity_common
// Params 1, eflags: 0x4
// Checksum 0x6bd2a69b, Offset: 0x25f2
// Size: 0xa2
function private function_494ea9a97c0148ec( var_761525ac1f9b6c7 )
{
    bundlenames = getscriptbundlenames( "activityrewards" );
    
    foreach ( bundlename in bundlenames )
    {
        bundle = getscriptbundle( bundlename );
        function_7212d1f7f86ef1c4( var_761525ac1f9b6c7, bundle );
    }
}

// Namespace activity_common
// Params 2, eflags: 0x4
// Checksum 0x816efa66, Offset: 0x269c
// Size: 0xc8
function private function_7212d1f7f86ef1c4( var_761525ac1f9b6c7, var_d0c176d485a082a1 )
{
    sharingtype = namespace_191965e8dea0924e::function_8eed7508d9aa91e8( var_d0c176d485a082a1 );
    
    if ( !isdefined( sharingtype ) || sharingtype == "DontShareWithActivities" )
    {
        return;
    }
    
    var_58f11b8182039c5d = namespace_191965e8dea0924e::function_b493dffc6327a910( var_d0c176d485a082a1 );
    
    if ( !isdefined( var_58f11b8182039c5d ) || var_58f11b8182039c5d.size == 0 )
    {
        return;
    }
    
    switch ( sharingtype )
    {
        case #"hash_5e3671de7b9f5a2a":
            function_16453b83c04c6b4e( var_761525ac1f9b6c7, var_58f11b8182039c5d );
            return;
        case #"hash_31d6baffebed40ac":
            categorytype = namespace_191965e8dea0924e::function_1fac541a92b053dc( var_d0c176d485a082a1 );
            function_f7d2bf01cfbb270f( var_761525ac1f9b6c7, categorytype, var_58f11b8182039c5d );
            return;
        default:
            assertmsg( "<dev string:x872>" + sharingtype );
            return;
    }
}

// Namespace activity_common
// Params 2, eflags: 0x4
// Checksum 0xcc93a261, Offset: 0x276c
// Size: 0x99
function private function_16453b83c04c6b4e( var_761525ac1f9b6c7, var_58f11b8182039c5d )
{
    foreach ( var_39a67e5028456b23 in var_58f11b8182039c5d )
    {
        var_761525ac1f9b6c7.var_91cc064b6ec8a6c[ var_761525ac1f9b6c7.var_91cc064b6ec8a6c.size ] = var_39a67e5028456b23;
    }
}

// Namespace activity_common
// Params 3, eflags: 0x4
// Checksum 0xc511f42e, Offset: 0x280d
// Size: 0xf3
function private function_f7d2bf01cfbb270f( var_761525ac1f9b6c7, categorytype, var_58f11b8182039c5d )
{
    assert( isdefined( categorytype ) );
    assert( categorytype != "<dev string:x7e4>", "<dev string:x89f>" );
    
    if ( !isdefined( var_761525ac1f9b6c7.var_3d3e562ecf5625f8[ categorytype ] ) )
    {
        var_761525ac1f9b6c7.var_3d3e562ecf5625f8[ categorytype ] = [];
    }
    
    foreach ( var_39a67e5028456b23 in var_58f11b8182039c5d )
    {
        size = var_761525ac1f9b6c7.var_3d3e562ecf5625f8[ categorytype ].size;
        var_761525ac1f9b6c7.var_3d3e562ecf5625f8[ categorytype ][ size ] = var_39a67e5028456b23;
    }
}

/#

    // Namespace activity_common
    // Params 0, eflags: 0x4
    // Checksum 0xb2188f1c, Offset: 0x2908
    // Size: 0x5, Type: dev
    function private function_51bf2f30a862b173()
    {
        
    }

#/

// Namespace activity_common
// Params 0
// Checksum 0x9d605759, Offset: 0x2915
// Size: 0xc, Type: bool
function function_54d6e6ddd48363b7()
{
    return isdefined( level.activities );
}

// Namespace activity_common
// Params 1
// Checksum 0xbe857351, Offset: 0x292a
// Size: 0x44
function getactivityinstance( instanceid )
{
    activityinstance = level.activities.instances[ instanceid ];
    
    if ( !isdefined( activityinstance ) )
    {
        assertmsg( "<dev string:x934>" );
    }
    
    return activityinstance;
}

// Namespace activity_common
// Params 3
// Checksum 0xad432201, Offset: 0x2977
// Size: 0x3e, Type: bool
function isactivityenabled( activitycategory, activitytype, activityvariantname )
{
    return function_7d88a1011efc9b5c( activitycategory ) && function_27be3931cf682460( activitytype ) && function_6600377543df075( activityvariantname );
}

// Namespace activity_common
// Params 1
// Checksum 0xc255c1ca, Offset: 0x29be
// Size: 0x95
function function_7d88a1011efc9b5c( activitycategory )
{
    var_ca3f65fdba0a9ed2 = level.activities;
    
    if ( var_ca3f65fdba0a9ed2.var_7882cd355890cc53.var_d861953567e43a5a.inclusionrule === "EnableTheseActivities" )
    {
        return istrue( var_ca3f65fdba0a9ed2.var_7882cd355890cc53.var_d861953567e43a5a.categorymap[ activitycategory ] );
    }
    
    return !isdefined( var_ca3f65fdba0a9ed2.var_7882cd355890cc53.var_d861953567e43a5a.categorymap[ activitycategory ] );
}

// Namespace activity_common
// Params 1
// Checksum 0xb2890578, Offset: 0x2a5b
// Size: 0x95
function function_27be3931cf682460( activitytype )
{
    var_ca3f65fdba0a9ed2 = level.activities;
    
    if ( var_ca3f65fdba0a9ed2.var_7882cd355890cc53.var_36e6e172fa2b42a6.inclusionrule === "EnableTheseActivities" )
    {
        return istrue( var_ca3f65fdba0a9ed2.var_7882cd355890cc53.var_36e6e172fa2b42a6.typemap[ activitytype ] );
    }
    
    return !isdefined( var_ca3f65fdba0a9ed2.var_7882cd355890cc53.var_36e6e172fa2b42a6.typemap[ activitytype ] );
}

// Namespace activity_common
// Params 1
// Checksum 0xf5faa8d7, Offset: 0x2af8
// Size: 0xbd
function function_8fe1a47c40904418( var_c8a53dc4bedf1a8 )
{
    activitynexussettings = level.activities.activitynexussettings;
    
    switch ( var_c8a53dc4bedf1a8 )
    {
        case 0:
            return istrue( activitynexussettings.var_10b2a22e8755c871 );
        case 1:
            return istrue( activitynexussettings.var_79f4a131a8c0f709 );
        case 2:
            return istrue( activitynexussettings.var_27cd59cfb04a15e1 );
        case 3:
            return istrue( activitynexussettings.var_1af43cdc88922dab );
        default:
            assertmsg( "<dev string:x967>" + var_c8a53dc4bedf1a8 + "<dev string:x981>" );
            return 0;
    }
}

// Namespace activity_common
// Params 1
// Checksum 0x392c1f2a, Offset: 0x2bbd
// Size: 0x95
function function_6600377543df075( activityvariantname )
{
    var_ca3f65fdba0a9ed2 = level.activities;
    
    if ( var_ca3f65fdba0a9ed2.var_7882cd355890cc53.enabledvariantstruct.inclusionrule === "EnableTheseActivities" )
    {
        return istrue( var_ca3f65fdba0a9ed2.var_7882cd355890cc53.enabledvariantstruct.variantmap[ activityvariantname ] );
    }
    
    return !isdefined( var_ca3f65fdba0a9ed2.var_7882cd355890cc53.enabledvariantstruct.variantmap[ activityvariantname ] );
}

// Namespace activity_common
// Params 1
// Checksum 0x69d6d68c, Offset: 0x2c5a
// Size: 0x5b, Type: bool
function function_b4301e0f6e69fe4( activityinstance )
{
    if ( isdefined( activityinstance ) && activity_instance_common::isactivityinstance( activityinstance ) )
    {
        instanceid = activityinstance.id;
        var_fad0d724929dbe9 = level.activities.instances[ instanceid ];
        return ( var_fad0d724929dbe9 == activityinstance );
    }
    
    return false;
}

// Namespace activity_common
// Params 0
// Checksum 0x42dcf507, Offset: 0x2cbe
// Size: 0x15
function function_394486cf35d84dc8()
{
    return level.activities.instances;
}

// Namespace activity_common
// Params 1
// Checksum 0x38c43ff8, Offset: 0x2cdc
// Size: 0xba
function function_9e8e0e51c25e8d84( varianttag )
{
    foreach ( activityinstance in level.activities.instances )
    {
        if ( isdefined( activityinstance ) )
        {
            if ( activityinstance.varianttag == varianttag && !activity_participation::isactivityfull( activityinstance ) )
            {
                return activityinstance;
            }
        }
    }
    
    /#
        iprintln( "<dev string:x9f4>" );
    #/
}

// Namespace activity_common
// Params 3
// Checksum 0xe428476e, Offset: 0x2d9f
// Size: 0x10e
function function_3eba33db536a1da6( point, var_5c55d558c26c1cca, conditionalcontainer )
{
    closestinstance = undefined;
    closestdistance = undefined;
    
    if ( !isdefined( var_5c55d558c26c1cca ) )
    {
        var_5c55d558c26c1cca = level.activities.instances;
    }
    
    foreach ( activityinstance in var_5c55d558c26c1cca )
    {
        var_74636b77f20ea905 = !isdefined( conditionalcontainer ) || conditional_container::function_33051347e9187361( conditionalcontainer, activityinstance );
        
        if ( var_74636b77f20ea905 )
        {
            distancesq = distancesquared( point, activity_instance_common::function_776ee11e7acc64a5( activityinstance ) );
            
            if ( !( isdefined( closestinstance ) && isdefined( closestdistance ) ) || distancesq < closestdistance )
            {
                closestdistance = distancesq;
                closestinstance = activityinstance;
            }
        }
    }
    
    return closestinstance;
}

// Namespace activity_common
// Params 0
// Checksum 0x45a35537, Offset: 0x2eb6
// Size: 0x9a
function getuniqueinstanceid()
{
    if ( level.activities.var_cd6ac69624ab4588.size > 0 )
    {
        id = level.activities.var_cd6ac69624ab4588[ 0 ];
        level.activities.var_cd6ac69624ab4588 = arrayremove( level.activities.var_cd6ac69624ab4588, id );
        return id;
    }
    else
    {
        id = level.activities.var_487c8bbaf23e85c;
        level.activities.var_487c8bbaf23e85c++;
    }
    
    return id;
}

// Namespace activity_common
// Params 0, eflags: 0x4
// Checksum 0xd39c427b, Offset: 0x2f59
// Size: 0x48
function private function_dbff04faaa238b39()
{
    targetnamestructs = [];
    
    if ( self.target )
    {
        targetnamestructs = utility::getstructarray( self.target, "targetname" );
    }
    
    linktostructs = utility::get_linked_structs();
    return arraycombineunique( targetnamestructs, linktostructs );
}

// Namespace activity_common
// Params 0
// Checksum 0x1a71f3b6, Offset: 0x2faa
// Size: 0x2d, Type: bool
function function_8769b060f0a2bf()
{
    activitynexussettings = level.activities.activitynexussettings;
    return !activitynexussettings.var_c5c4f66e44ed5f3c;
}

