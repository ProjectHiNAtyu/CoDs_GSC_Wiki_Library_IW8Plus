// scripts\common\activity_nexus\activity_participation.gsc  (hash_50cece4fabbdcc75.gscc) (size: 19611 Bytes / 0x4c9b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x90772249 (2423726665)
// size ...... 19611 (0x4c9b)
// includes .. 14  (offset: 0x49db)
// strings ... 24  (offset: 0x4a4b)
// dev strs .. 19  (offset: 0x4b93)
// exports ... 74  (offset: 0x2f23)
// cseg ...... 0x389 + 0x2b9a (0x2f23)
// imports ... 123 (offset: 0x3ab3)
// animtree1 . 0   (offset: 0x4c9b)
// animtree2 . 0   (offset: 0x4c9b)
#using script_4e1f1a7ef824ddd5;
#using script_77873e194e406c6d;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\activity_nexus\activity_scriptables;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\player_broadcasting;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\utility;

#namespace activity_participation;

/#

    // Namespace activity_participation
    // Params 0, eflags: 0x4
    // Checksum 0x9bae19e1, Offset: 0x3a7
    // Size: 0x5, Type: dev
    function private function_2fd0e4ee113ab376()
    {
        
    }

#/

// Namespace activity_participation
// Params 0
// Checksum 0x7d4407b, Offset: 0x3b4
// Size: 0xd6
function function_ef4e919227bc4515()
{
    activitynexussettings = level.activities.activitynexussettings;
    var_26c61aea0429590b = getdvarfloat( @"hash_fad3c5e3b27f4e7e", activitynexussettings.var_e886fa3c14b1fb5f );
    var_a6cb07f7a6d80824 = getdvarfloat( @"hash_d01337f1fb1a133", activitynexussettings.var_47918e035f07a38c );
    
    if ( activity_common::function_8fe1a47c40904418( 2 ) )
    {
        spatial_zone_container::function_3e5d25f80be6b5d1( 1, &function_8b4a743eef338128, &function_b38d32695d903a80, "Proximity_Join_Zone", var_26c61aea0429590b );
        spatial_zone_container::function_3e5d25f80be6b5d1( 2, &function_2a6cfa0172f499c1, &function_44cacb7961053d7d, "Proximity_Abandon_Zone", var_a6cb07f7a6d80824 );
    }
    
    if ( activitynexussettings.var_cdd5fd7b55ca60fe )
    {
        callback::add( #"player_used_item", &function_3d633b2860910cae );
        return;
    }
    
    scriptable::scriptable_addusedcallback( &function_e32ca5507a685778 );
}

// Namespace activity_participation
// Params 1
// Checksum 0x1e00f1b1, Offset: 0x492
// Size: 0x1c7
function function_922f35ea8811f298( activityinstance )
{
    activityinstance.participationconditions = spawnstruct();
    activityinstance.participationconditions conditional_container::function_3c3be461141746c0();
    conditional_container::addcondition( activityinstance.participationconditions, &function_3d02626f747c5143, [ activityinstance, activity_definition_utils::getmaxplayercount( activityinstance ) ], undefined, "Activity Instance already at Max Players." );
    conditional_container::addcondition( activityinstance.participationconditions, &activity_instance_common::function_405d871db57a010, [ activityinstance ], undefined, "Activity Instance has Ended." );
    conditional_container::addcondition( activityinstance.participationconditions, &function_ad5bd80478398b57, [ activityinstance ], undefined, "Player is already participating in this Activity Instance." );
    
    if ( activity_definition_utils::function_3fd7ab2fbc0fbc72( activityinstance ) )
    {
        conditional_container::addcondition( activityinstance.participationconditions, &activity_instance_common::function_77b0ef7c93812bbe, [ activityinstance, "Awareness_Zone" ], undefined, "Player is not within the Awarenss Zone." );
    }
    
    if ( activity_definition_utils::function_78fa68ce3733accd( activityinstance ) )
    {
        conditional_container::addcondition( activityinstance.participationconditions, &function_2d11884b67f01fb9, [ activityinstance ], undefined, "Player is already participating in an Activity Instance with the same Type." );
    }
    
    if ( activity_definition_utils::function_a79b1feb5419d1ac( activityinstance ) )
    {
        conditional_container::addcondition( activityinstance.participationconditions, &function_846bf57804dbe69b, [ activityinstance ], undefined, "Player is already participating in any Activity Instance." );
    }
    
    if ( activity_definition_utils::function_6e5624d15e574a2a( activityinstance ) )
    {
        conditional_container::addcondition( activityinstance.participationconditions, &activity_player_common::function_a4d7e63988b570a7, [ activityinstance ], undefined, "Player is already participating in an Activity Instance with the same Category." );
    }
    
    if ( activity_common::function_8fe1a47c40904418( 0 ) && spatial_zone_container::function_3819f09eefb741e2( activityinstance, "Hibernation_Zone" ) )
    {
        var_f55363b8ef6d5a18 = spatial_zone_container::function_84f653d797112085( activityinstance, "Hibernation_Zone" );
        
        if ( var_f55363b8ef6d5a18.size == 0 )
        {
            activity_instance_common::function_e80ace5c61b13188( activityinstance, 1 );
        }
    }
    
    if ( activity_definition_utils::function_65a59cc724e4ec89( activityinstance, 0 ) )
    {
        function_adecd3e45b4e2277( activityinstance );
    }
}

/#

    // Namespace activity_participation
    // Params 0, eflags: 0x4
    // Checksum 0xe481e7e, Offset: 0x661
    // Size: 0x5, Type: dev
    function private function_8c7fcd1ff2ede50()
    {
        
    }

#/

// Namespace activity_participation
// Params 3
// Checksum 0x195957c8, Offset: 0x66e
// Size: 0xb7
function function_bc67362dace4370c( activityinstance, player, playerjoinreason = "PlayerJoinedOther" )
{
    var_3f953936eadb7eb9 = activityinstance.playerparticipants.size >= activity_definition_utils::getminplayercount( activityinstance );
    var_7804c527d1b00b4b = activityinstance.playerparticipants.size == activity_definition_utils::getmaxplayercount( activityinstance );
    var_e576ac9f6664779c = { #var_cc672e7ea8b829dd:1, #var_d81ca0c471c5d7d0:[], #var_f2ba5752c3b888f1:[], #var_5c3c448215646795:[] };
    function_700ebe79a3bc64ed( var_e576ac9f6664779c, activityinstance, player, playerjoinreason );
    return function_f34c9754092c45d3( activityinstance, var_e576ac9f6664779c, var_3f953936eadb7eb9, var_7804c527d1b00b4b );
}

// Namespace activity_participation
// Params 3
// Checksum 0xeeee527f, Offset: 0x72e
// Size: 0x164
function function_fb0ec90aaf6d4c61( activityinstance, playerlist, playerjoinreason = "PlayerJoinedOther" )
{
    assert( isarray( playerlist ), "<dev string:x24>" );
    var_3f953936eadb7eb9 = activityinstance.playerparticipants.size >= activity_definition_utils::getminplayercount( activityinstance );
    var_7804c527d1b00b4b = activityinstance.playerparticipants.size == activity_definition_utils::getmaxplayercount( activityinstance );
    var_e576ac9f6664779c = { #var_cc672e7ea8b829dd:1, #var_d81ca0c471c5d7d0:[], #var_f2ba5752c3b888f1:[], #var_5c3c448215646795:[] };
    level callback::callback( #"hash_4e0cfe1df091e586", { #playerjoinreason:playerjoinreason, #playerlist:playerlist, #activityinstance:activityinstance } );
    
    foreach ( player in playerlist )
    {
        function_700ebe79a3bc64ed( var_e576ac9f6664779c, activityinstance, player, playerjoinreason );
    }
    
    return function_f34c9754092c45d3( activityinstance, var_e576ac9f6664779c, var_3f953936eadb7eb9, var_7804c527d1b00b4b );
}

// Namespace activity_participation
// Params 5, eflags: 0x4
// Checksum 0x75146494, Offset: 0x89b
// Size: 0x260
function private function_700ebe79a3bc64ed( var_e576ac9f6664779c, activityinstance, player, playerjoinreason = "PlayerJoinedOther", var_476825db60eddcb5 = 1 )
{
    var_e44515e5d93fde4d = conditional_container::function_fc04dbbd557e99c1( activityinstance.participationconditions, player );
    
    if ( var_e44515e5d93fde4d.var_2060d7fd72693be3 )
    {
        activityinstance.playerparticipants[ activityinstance.playerparticipants.size ] = player;
        var_e576ac9f6664779c.var_5c3c448215646795[ var_e576ac9f6664779c.var_5c3c448215646795.size ] = player;
        
        if ( !isdefined( var_e576ac9f6664779c.var_d81ca0c471c5d7d0[ playerjoinreason ] ) )
        {
            var_e576ac9f6664779c.var_d81ca0c471c5d7d0[ playerjoinreason ] = [];
        }
        
        var_e576ac9f6664779c.var_d81ca0c471c5d7d0[ playerjoinreason ][ var_e576ac9f6664779c.var_d81ca0c471c5d7d0[ playerjoinreason ].size ] = player;
        function_e93ffc647c10ad9d( player, activityinstance, playerjoinreason );
        activityinstance notify( #"player_joined", player );
        
        if ( var_476825db60eddcb5 )
        {
            activitydefinition = activityinstance activity_definition_utils::function_837a0c8626c9b419();
            var_717b8d1df648b9f9 = activity_definition_utils::function_f35ffc5fdda1d8eb( activitydefinition );
            
            if ( var_717b8d1df648b9f9 )
            {
                var_c4ceab2584e08433 = activity_player_common::function_44ef43ff1f6d21d4( player );
                
                foreach ( playersquadgroupmember in var_c4ceab2584e08433 )
                {
                    if ( player != playersquadgroupmember && !isdefined( function_f02c63b99c9614c9( activityinstance.playerparticipants, playersquadgroupmember ) ) )
                    {
                        function_700ebe79a3bc64ed( var_e576ac9f6664779c, activityinstance, playersquadgroupmember, "PlayerJoinedSquad", 0 );
                    }
                }
            }
        }
        
        return;
    }
    
    var_e576ac9f6664779c.var_f2ba5752c3b888f1[ var_e576ac9f6664779c.var_f2ba5752c3b888f1.size ] = player;
    var_e576ac9f6664779c.var_cc672e7ea8b829dd = 0;
    
    /#
        var_e576ac9f6664779c.var_1e5eb0d9cba2f0ea = var_e576ac9f6664779c.var_1e5eb0d9cba2f0ea ?? [];
        playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
        var_e576ac9f6664779c.var_1e5eb0d9cba2f0ea[ playerguid ] = var_e44515e5d93fde4d.var_59e679186bcfdb0f;
    #/
}

// Namespace activity_participation
// Params 4, eflags: 0x4
// Checksum 0x9071fd6a, Offset: 0xb03
// Size: 0x16c
function private function_f34c9754092c45d3( activityinstance, var_e576ac9f6664779c, var_3f953936eadb7eb9, var_7804c527d1b00b4b )
{
    if ( var_e576ac9f6664779c.var_5c3c448215646795.size > 0 )
    {
        foreach ( playerjoinreason, var_8f7c7a975348410 in var_e576ac9f6664779c.var_d81ca0c471c5d7d0 )
        {
            activity_instance_common::announceactivitymoment( activityinstance, "PlayerJoin", { #playerjoinreason:playerjoinreason, #playerlist:var_8f7c7a975348410 } );
        }
        
        if ( activityinstance.playerparticipants.size >= activity_definition_utils::getminplayercount( activityinstance ) && !var_3f953936eadb7eb9 )
        {
            if ( activity_instance_common::function_589f2d290acdba2e( activityinstance, "Minimum Player Participation Blocker" ) )
            {
                activity_instance_common::function_3e3a340f4b0f8f1e( activityinstance, "Minimum Player Participation Blocker", "Minimum player count has been reached" );
            }
            
            activityinstance notify( #"hash_c28ffe8723729c53" );
        }
        
        if ( activityinstance.playerparticipants.size == activity_definition_utils::getmaxplayercount( activityinstance ) && !var_7804c527d1b00b4b )
        {
            activityinstance notify( #"hash_fe33d793f1f65135" );
        }
        
        activity_instance_common::function_e80ace5c61b13188( activityinstance, 0 );
    }
    
    /#
        function_f05d2deef53453f( activityinstance, var_e576ac9f6664779c );
    #/
    
    return var_e576ac9f6664779c.var_cc672e7ea8b829dd;
}

/#

    // Namespace activity_participation
    // Params 2, eflags: 0x4
    // Checksum 0x1823c2bf, Offset: 0xc78
    // Size: 0x1a0, Type: dev
    function private function_f05d2deef53453f( activityinstance, var_e576ac9f6664779c )
    {
        if ( namespace_634561435cfb3169::function_a940a26e08d4ac7e( @"hash_39bc09a8c55a7875" ) )
        {
            if ( var_e576ac9f6664779c.var_5c3c448215646795.size > 0 )
            {
                foreach ( playerjoinreason, var_8f7c7a975348410 in var_e576ac9f6664779c.var_d81ca0c471c5d7d0 )
                {
                    namespace_634561435cfb3169::activitynexuslog( "<dev string:x90>" + playerjoinreason, @"hash_39bc09a8c55a7875", activityinstance, var_8f7c7a975348410 );
                }
            }
            
            if ( var_e576ac9f6664779c.var_f2ba5752c3b888f1.size > 0 )
            {
                foreach ( player in var_e576ac9f6664779c.var_f2ba5752c3b888f1 )
                {
                    playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
                    var_8f82608fff988fe3 = var_e576ac9f6664779c.var_1e5eb0d9cba2f0ea[ playerguid ];
                    namespace_634561435cfb3169::activitynexuslog( "<dev string:xb7>" + var_8f82608fff988fe3, @"hash_39bc09a8c55a7875", activityinstance, player );
                }
            }
        }
    }

    // Namespace activity_participation
    // Params 0, eflags: 0x4
    // Checksum 0xcc42000b, Offset: 0xe20
    // Size: 0x5, Type: dev
    function private function_296f8996d7792898()
    {
        
    }

#/

// Namespace activity_participation
// Params 1
// Checksum 0xc69d3618, Offset: 0xe2d
// Size: 0x48
function function_a45fd1c5cc774007( activityinstance )
{
    /#
        if ( !spatial_zone_container::function_3819f09eefb741e2( activityinstance, "<dev string:xe4>" ) )
        {
            namespace_634561435cfb3169::activitynexuslog( "<dev string:xf8>", @"hash_39bc09a8c55a7875", activityinstance, undefined, 2 );
        }
    #/
    
    activityinstance.var_df26c6d3af731001 = 1;
}

// Namespace activity_participation
// Params 1
// Checksum 0x46f3fd19, Offset: 0xe7d
// Size: 0x25
function function_5e5913e13bf9cb28( activityinstance )
{
    activityinstance.var_df26c6d3af731001 = undefined;
    spatial_zone_container::function_4f9fccd04a537897( activityinstance, "Proximity_Join_Zone" );
}

// Namespace activity_participation
// Params 1
// Checksum 0x25e4fcfa, Offset: 0xeaa
// Size: 0x18, Type: bool
function function_5d733a45bcf51ef1( activityinstance )
{
    return istrue( activityinstance.var_df26c6d3af731001 );
}

// Namespace activity_participation
// Params 1
// Checksum 0x8f746ac8, Offset: 0xecb
// Size: 0xe3
function function_b38d32695d903a80( var_54c779cf281bb58d )
{
    activityinstance = self;
    spatialzonename = var_54c779cf281bb58d.zonename;
    player = var_54c779cf281bb58d.player;
    playerinzone = var_54c779cf281bb58d.enteredzone;
    assert( activity_instance_common::isactivityinstance( activityinstance ), "<dev string:x18e>" );
    assert( spatialzonename == "<dev string:xe4>", "<dev string:x1e2>" );
    assert( isplayer( player ), "<dev string:x241>" );
    
    if ( isdefined( level.activities.nexusoverrides[ 14 ] ) )
    {
        activity_common::function_2ba08ba0c0544a1a( 14, [ activityinstance, player, playerinzone ], 0 );
        return;
    }
    
    if ( playerinzone )
    {
        function_bc67362dace4370c( activityinstance, player, "PlayerJoinedProximity" );
    }
}

// Namespace activity_participation
// Params 0, eflags: 0x4
// Checksum 0x8b29ca73, Offset: 0xfb6
// Size: 0xf1
function private function_8b4a743eef338128()
{
    var_d6002571bf84000f = level.activities.var_d6002571bf84000f;
    var_fc3a8827a8711422 = [];
    
    foreach ( instance in var_d6002571bf84000f )
    {
        if ( istrue( instance.var_df26c6d3af731001 ) && instance.playerparticipants.size < instance.var_2c769a213204c445.maxplayercount && isdefined( instance.var_8339fb4f2d23dabf.zones[ "Proximity_Join_Zone" ] ) )
        {
            var_fc3a8827a8711422[ var_fc3a8827a8711422.size ] = instance;
        }
    }
    
    return var_fc3a8827a8711422;
}

/#

    // Namespace activity_participation
    // Params 0, eflags: 0x4
    // Checksum 0xd257ade7, Offset: 0x10b0
    // Size: 0x5, Type: dev
    function private function_f1a7a6394acab4c6()
    {
        
    }

#/

// Namespace activity_participation
// Params 1
// Checksum 0x616c4f8c, Offset: 0x10bd
// Size: 0xc6
function function_d9a1042dcc00e541( relevantparameters )
{
    activityinstance = relevantparameters[ 0 ];
    interactscriptables = relevantparameters[ 1 ];
    
    foreach ( interactscriptable in interactscriptables )
    {
        interactscriptable.var_edc89ff04fe6a343 = { #joincallbackfunction:undefined, #var_e498f1f42b006739:0, #activityinstance:activityinstance };
    }
    
    activity_scriptables::function_12e3c036c773688f( activityinstance, interactscriptables );
}

// Namespace activity_participation
// Params 3
// Checksum 0xba8e0eba, Offset: 0x118b
// Size: 0x8c
function function_7dd54a3f491d8ec8( interactscriptable, var_66e640a46b0aff52, callbackfunction )
{
    activityinstance = self;
    
    if ( isdefined( interactscriptable ) )
    {
        interactscriptable.var_edc89ff04fe6a343 = { #joincallbackfunction:callbackfunction, #var_e498f1f42b006739:istrue( var_66e640a46b0aff52 ), #activityinstance:activityinstance };
        activity_scriptables::function_12e3c036c773688f( activityinstance, interactscriptable );
        return;
    }
    
    assertmsg( "<dev string:x281>" + activityinstance.varianttag + "<dev string:x2b3>" );
}

// Namespace activity_participation
// Params 6
// Checksum 0x1b4d1bf1, Offset: 0x121f
// Size: 0x43
function function_e32ca5507a685778( instance, part, state, player, bautouse, usestring )
{
    function_105829eb4256cd73( instance, player );
}

// Namespace activity_participation
// Params 1
// Checksum 0xc60ba7cb, Offset: 0x126a
// Size: 0x1f
function function_3d633b2860910cae( params )
{
    function_105829eb4256cd73( params.item, self );
}

// Namespace activity_participation
// Params 2
// Checksum 0x5310f290, Offset: 0x1291
// Size: 0x106
function function_105829eb4256cd73( instance, player )
{
    if ( isdefined( instance ) && isdefined( instance.var_edc89ff04fe6a343 ) )
    {
        var_c8b9bfb7b4c3d6d9 = 1;
        
        if ( utility::issharedfuncdefined( #"activity", #"hash_6cef4604e39b1588" ) )
        {
            var_c8b9bfb7b4c3d6d9 = utility::callsharedfunc( #"activity", #"hash_6cef4604e39b1588", player );
        }
        
        var_ddb00c04496655d1 = instance.var_edc89ff04fe6a343.activityinstance;
        
        if ( isdefined( var_ddb00c04496655d1 ) && var_c8b9bfb7b4c3d6d9 && !isdefined( function_f02c63b99c9614c9( var_ddb00c04496655d1.playerparticipants, player ) ) )
        {
            playedjoined = function_bc67362dace4370c( var_ddb00c04496655d1, player, "PlayerJoinedInteract" );
            
            if ( playedjoined && isdefined( instance.var_edc89ff04fe6a343.joincallbackfunction ) )
            {
                var_ddb00c04496655d1 [[ instance.var_edc89ff04fe6a343.joincallbackfunction ]]( var_ddb00c04496655d1, instance, player );
            }
        }
    }
}

// Namespace activity_participation
// Params 1
// Checksum 0x3f0dd592, Offset: 0x139f
// Size: 0x99
function function_6c92bb685deb5c9b( activityinstance )
{
    activityjoininteracts = level.activities.var_3a2ba6751c464ab7[ activityinstance.id ] ?? [];
    
    if ( isarray( activityjoininteracts ) && activityjoininteracts.size > 0 )
    {
        relevantinfostruct = { #playerlist:level.players ?? level.player };
        relevantinfostruct.joininteracts[ activityinstance.id ] = activityjoininteracts;
        function_14f790ff7844b38f( relevantinfostruct );
    }
}

// Namespace activity_participation
// Params 1
// Checksum 0x2d2029a9, Offset: 0x1440
// Size: 0x9b
function function_14f790ff7844b38f( relevantinfostruct )
{
    activitynexussettings = level.activities.activitynexussettings;
    
    if ( activitynexussettings.var_7e2625172921f62 )
    {
        return;
    }
    
    var_11ea5fd7c2ff27f8 = getdvarfloat( @"hash_556de73f87d68d35", activitynexussettings.var_ffe980977fb15cca );
    var_3a2ba6751c464ab7 = relevantinfostruct.joininteracts ?? level.activities.var_3a2ba6751c464ab7;
    relevantinfostruct thread utility::function_a38b3ca4783bca3b( var_3a2ba6751c464ab7, &function_74f1213a1998a8b6, undefined, undefined, var_11ea5fd7c2ff27f8, 0 );
}

// Namespace activity_participation
// Params 1
// Checksum 0x597a840a, Offset: 0x14e3
// Size: 0x188
function function_3bd36f038dc2b339( relevantparameters )
{
    jointinteractscriptables = [];
    activityinstance = relevantparameters[ 0 ];
    activityvariantname = activityinstance.varianttag;
    activitydefinition = activityinstance activity_definition_utils::function_837a0c8626c9b419();
    scriptableasset = activity_definition_utils::function_8d582a1239b166de( activitydefinition );
    
    for ( variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( activityvariantname ); isdefined( variantscriptstructinfo ) ; variantscriptstructinfo = undefined )
    {
        variantstruct = variantscriptstructinfo.variantstruct;
        linkedstructs = variantscriptstructinfo.linkedstructs;
        
        foreach ( linkedstruct in linkedstructs )
        {
            var_a3fce574d6e49fdc = linkedstruct.targetname === "activity_nexus_instance_joiner";
            
            if ( var_a3fce574d6e49fdc )
            {
                joininteractscriptable = spawnscriptable( scriptableasset, linkedstruct.origin, linkedstruct.angles );
                jointinteractscriptables[ jointinteractscriptables.size ] = joininteractscriptable;
            }
        }
        
        parentactivityvariantname = variantstruct.parent;
        
        if ( isstring( parentactivityvariantname ) )
        {
            variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( parentactivityvariantname );
            continue;
        }
    }
    
    return jointinteractscriptables;
}

// Namespace activity_participation
// Params 1
// Checksum 0x6f9e7e93, Offset: 0x1674
// Size: 0x4a
function function_84e353f7f3b1ebc9( activityinstance )
{
    if ( activity_definition_utils::function_6c3cc9191c5b0d36( activityinstance ) )
    {
        activityjoininteracts = activity_common::function_2ba08ba0c0544a1a( 8, [ activityinstance ], 0 );
        activity_common::function_2ba08ba0c0544a1a( 7, [ activityinstance, activityjoininteracts ], 0 );
    }
}

// Namespace activity_participation
// Params 2, eflags: 0x4
// Checksum 0xf5873d14, Offset: 0x16c6
// Size: 0x17e
function private function_74f1213a1998a8b6( var_6e8dd8167d18391e, activityinstanceid )
{
    playerlist = self.playerlist;
    
    foreach ( player in playerlist )
    {
        if ( isplayer( player ) && var_6e8dd8167d18391e.size > 0 && activity_instance_common::isactivityinstance( var_6e8dd8167d18391e[ 0 ].associatedactivityinstance ) )
        {
            activityinstance = var_6e8dd8167d18391e[ 0 ].associatedactivityinstance;
            playerparticipationconditions = activityinstance.participationconditions;
            var_1c05e61a4bb4e652 = conditional_container::function_33051347e9187361( playerparticipationconditions, player );
            
            foreach ( activityjoininteract in var_6e8dd8167d18391e )
            {
                if ( isdefined( activityjoininteract ) )
                {
                    if ( var_1c05e61a4bb4e652 )
                    {
                        activityjoininteract enablescriptableplayeruse( player );
                        continue;
                    }
                    
                    activityjoininteract disablescriptableplayeruse( player );
                }
            }
        }
    }
}

/#

    // Namespace activity_participation
    // Params 0, eflags: 0x4
    // Checksum 0xbdaa684d, Offset: 0x184c
    // Size: 0x5, Type: dev
    function private function_96d45020cee198b6()
    {
        
    }

#/

// Namespace activity_participation
// Params 2
// Checksum 0xc599fd53, Offset: 0x1859
// Size: 0x25
function function_d041ee0ec570299d( enttodamage, callbackfunction )
{
    function_6e57a22ab1afc731( [ enttodamage ], callbackfunction );
}

// Namespace activity_participation
// Params 2
// Checksum 0xc4d52ba4, Offset: 0x1886
// Size: 0x94
function function_6e57a22ab1afc731( entstodamage, callbackfunction )
{
    foreach ( ent in entstodamage )
    {
        thread function_16eeb51746e24f4f( self, ent, callbackfunction );
        thread function_c7de1353a4bc2ba4( self, ent, callbackfunction );
    }
}

// Namespace activity_participation
// Params 3, eflags: 0x4
// Checksum 0xaa703afb, Offset: 0x1922
// Size: 0x103
function private function_16eeb51746e24f4f( activityinstance, ent, callbackfunction )
{
    ent endon( #"death" );
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        ent waittill( #"damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        function_29234f65a0ef3b26( activityinstance, ent, attacker, callbackfunction );
        waitframe();
    }
}

// Namespace activity_participation
// Params 3, eflags: 0x4
// Checksum 0x55b0dd36, Offset: 0x1a2d
// Size: 0x75
function private function_c7de1353a4bc2ba4( activityinstance, ent, callbackfunction )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    ent waittill( #"death", attacker, meansofdeath );
    function_29234f65a0ef3b26( activityinstance, ent, attacker, callbackfunction );
}

// Namespace activity_participation
// Params 4, eflags: 0x4
// Checksum 0xbc4dd8f7, Offset: 0x1aaa
// Size: 0x86
function private function_29234f65a0ef3b26( activityinstance, attacked, attacker, callbackfunction )
{
    if ( isplayer( attacker ) && isdefined( activityinstance.playerparticipants ) && !isdefined( function_f02c63b99c9614c9( activityinstance.playerparticipants, attacker ) ) )
    {
        playerjoined = function_bc67362dace4370c( activityinstance, attacker, "PlayerJoinedDamage" );
        
        if ( playerjoined && isdefined( callbackfunction ) )
        {
            [[ callbackfunction ]]( activityinstance, attacked, attacker );
        }
    }
}

/#

    // Namespace activity_participation
    // Params 0
    // Checksum 0x960a5aa8, Offset: 0x1b38
    // Size: 0x5, Type: dev
    function function_62f8600e27833f8c()
    {
        
    }

#/

// Namespace activity_participation
// Params 3
// Checksum 0x9e25036b, Offset: 0x1b45
// Size: 0x62, Type: bool
function function_61aa2b2879f2c0a2( activityinstance, player, abandoning = 0 )
{
    var_a5c21b2569dded07 = [];
    
    if ( abandoning )
    {
        var_a5c21b2569dded07 = function_50b4099984bf1d04( activityinstance, [ player ] );
    }
    else
    {
        var_a5c21b2569dded07 = function_dd782fbeb3b07e39( activityinstance, [ player ] );
    }
    
    return var_a5c21b2569dded07.size > 0;
}

// Namespace activity_participation
// Params 3
// Checksum 0x52d49615, Offset: 0x1bb0
// Size: 0x42
function function_dd782fbeb3b07e39( activityinstance, playerlist, abandoning = 0 )
{
    if ( abandoning )
    {
        return function_50b4099984bf1d04( activityinstance, playerlist );
    }
    
    return function_6bb697dfc5eadea2( activityinstance, playerlist );
}

// Namespace activity_participation
// Params 1
// Checksum 0x565522a0, Offset: 0x1bfa
// Size: 0x1f
function function_1f1a3bd685df59e8( activityinstance )
{
    return function_dd782fbeb3b07e39( activityinstance, activityinstance.playerparticipants );
}

// Namespace activity_participation
// Params 3
// Checksum 0xdd713ee8, Offset: 0x1c22
// Size: 0x44
function function_1b2fcd30f5842df5( activityinstance, player, abandoning = 0 )
{
    var_c4ceab2584e08433 = activity_player_common::function_44ef43ff1f6d21d4( player );
    return function_dd782fbeb3b07e39( activityinstance, var_c4ceab2584e08433, abandoning );
}

// Namespace activity_participation
// Params 3
// Checksum 0x1ea9f6a6, Offset: 0x1c6f
// Size: 0xee
function function_5213b2515c8b4f77( activityinstance, player, abandoning = 0 )
{
    var_c4ceab2584e08433 = activity_player_common::function_44ef43ff1f6d21d4( player );
    currentparticipants = activityinstance.playerparticipants;
    playersremoved = [];
    
    foreach ( participant in currentparticipants )
    {
        if ( !arraycontains( var_c4ceab2584e08433, participant ) )
        {
            result = function_61aa2b2879f2c0a2( activityinstance, participant, abandoning );
            
            if ( result )
            {
                playersremoved[ playersremoved.size ] = participant;
            }
        }
    }
    
    return playersremoved;
}

// Namespace activity_participation
// Params 3, eflags: 0x4
// Checksum 0x3eebdf82, Offset: 0x1d66
// Size: 0x12e
function private function_6bb697dfc5eadea2( activityinstance, playerlist, abandon )
{
    var_a5c21b2569dded07 = [];
    
    foreach ( player in playerlist )
    {
        if ( isdefined( function_f02c63b99c9614c9( activityinstance.playerparticipants, player ) ) )
        {
            activityinstance.playerparticipants = arrayremove( activityinstance.playerparticipants, player );
            function_2435aaee2b5ee2cd( player, activityinstance );
            activityinstance notify( #"player_left", player );
            var_a5c21b2569dded07[ var_a5c21b2569dded07.size ] = player;
        }
    }
    
    if ( var_a5c21b2569dded07.size > 0 )
    {
        activity_instance_common::announceactivitymoment( activityinstance, "PlayerLeave", { #abandon:abandon, #playerlist:var_a5c21b2569dded07 } );
        
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x2ca>", @"hash_39bc09a8c55a7875", activityinstance, var_a5c21b2569dded07 );
        #/
    }
    
    return var_a5c21b2569dded07;
}

/#

    // Namespace activity_participation
    // Params 0
    // Checksum 0x8d2bd5b5, Offset: 0x1e9d
    // Size: 0x5, Type: dev
    function function_64cadb2cf2c15c0b()
    {
        
    }

#/

// Namespace activity_participation
// Params 4
// Checksum 0x722f6f61, Offset: 0x1eaa
// Size: 0x88
function function_267e1d48764a0750( activityinstance, player, abandontriggertype, var_bbeeb012100e0aa2 )
{
    activitydefinition = activityinstance activity_definition_utils::function_837a0c8626c9b419();
    var_ac6585d669832320 = activity_definition_utils::function_dcdc4984a7c518e9( activitydefinition, abandontriggertype );
    var_a55cbf84d5f69650 = activity_definition_utils::function_868c1e057e9368da( activitydefinition, abandontriggertype );
    
    if ( var_a55cbf84d5f69650 )
    {
        function_29c5d149b75265a7( activityinstance, player, var_ac6585d669832320, var_bbeeb012100e0aa2 );
        return;
    }
    
    function_50b4099984bf1d04( activityinstance, [ player ], var_ac6585d669832320 );
}

// Namespace activity_participation
// Params 3, eflags: 0x4
// Checksum 0xf845a24a, Offset: 0x1f3a
// Size: 0xa4
function private function_50b4099984bf1d04( activityinstance, playerlist, var_bc5f9589dc41e229 = 1 )
{
    var_a2a2fe2794308690 = function_6bb697dfc5eadea2( activityinstance, playerlist, 1 );
    
    if ( var_bc5f9589dc41e229 )
    {
        activityinstance activity_player_broadcasting::function_cb4750c84882dd07( "PlayerAbandonNotification", var_a2a2fe2794308690 );
    }
    
    if ( activity_definition_utils::function_65a59cc724e4ec89( activityinstance, 2 ) )
    {
        var_a636dcecbf28d235 = function_50f0526b31e6a999( activityinstance, var_a2a2fe2794308690 );
    }
    
    var_a2a2fe2794308690 = arraycombine( var_a2a2fe2794308690, var_a636dcecbf28d235 );
    relevantinfostruct = { #playerlist:var_a2a2fe2794308690 };
    activity_instance_common::announceactivitymoment( activityinstance, "PlayerAbandon", relevantinfostruct );
    return var_a2a2fe2794308690;
}

// Namespace activity_participation
// Params 4, eflags: 0x4
// Checksum 0x17a6c790, Offset: 0x1fe7
// Size: 0xb6
function private function_29c5d149b75265a7( activityinstance, player, var_bc5f9589dc41e229 = 1, var_bbeeb012100e0aa2 )
{
    abandontriggercomplete = 0;
    
    if ( !activity_player_common::function_9c9b820cfe15a80a( player, activityinstance ) )
    {
        activity_player_common::function_7dd92a1f01ccc6e9( player, activityinstance );
        
        /#
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x2e1>", @"hash_39bc09a8c55a7875", activityinstance, [ player ] );
        #/
        
        var_94ecc051e40f0c85 = activityinstance function_f905f2798fecdc59( activityinstance, player, var_bc5f9589dc41e229, var_bbeeb012100e0aa2 );
        activity_player_common::function_fd5dfb647d6fbc16( player, activityinstance );
        
        if ( var_94ecc051e40f0c85 )
        {
            abandontriggercomplete = 1;
        }
    }
    
    if ( abandontriggercomplete )
    {
        function_50b4099984bf1d04( activityinstance, [ player ], var_bc5f9589dc41e229 );
    }
}

// Namespace activity_participation
// Params 4, eflags: 0x4
// Checksum 0xc3f7a64a, Offset: 0x20a5
// Size: 0x153
function private function_f905f2798fecdc59( activityinstance, player, var_ac6585d669832320, var_bbeeb012100e0aa2 )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    broadcastinstances = undefined;
    var_94ecc051e40f0c85 = 0;
    
    if ( var_ac6585d669832320 )
    {
        broadcastinstances = namespace_2aca03e533f9f843::function_a9c87ab2939586d3( "PlayerLeaveWarning", activityinstance );
        player_broadcasting::function_5e1c0f6552045c72( player, broadcastinstances );
    }
    
    var_77ba18015d913fdd = gettime();
    activitynexussettings = level.activities.activitynexussettings;
    var_89ed1d85a8ff120c = activitynexussettings.var_a95bf48696b37fd0;
    
    while ( true )
    {
        var_38ab1a8ecfb1cfbd = gettime();
        var_a47764d20d3a6345 = ( var_38ab1a8ecfb1cfbd - var_77ba18015d913fdd ) / 1000;
        var_b1bf3537e033fa5e = 0;
        
        if ( isdefined( var_bbeeb012100e0aa2 ) && var_bbeeb012100e0aa2 conditional_container::function_6282ae60ffa66695() )
        {
            var_b1bf3537e033fa5e = conditional_container::function_33051347e9187361( var_bbeeb012100e0aa2, player );
        }
        
        if ( var_b1bf3537e033fa5e )
        {
            break;
        }
        else if ( var_a47764d20d3a6345 >= var_89ed1d85a8ff120c )
        {
            /#
                namespace_634561435cfb3169::activitynexuslog( "<dev string:x310>", @"hash_39bc09a8c55a7875", activityinstance, [ player ] );
            #/
            
            var_94ecc051e40f0c85 = 1;
            break;
        }
        
        waitframe();
    }
    
    if ( var_ac6585d669832320 )
    {
        player_broadcasting::function_c2b475946583f034( player, broadcastinstances );
    }
    
    return var_94ecc051e40f0c85;
}

// Namespace activity_participation
// Params 2, eflags: 0x4
// Checksum 0xd150f39b, Offset: 0x2201
// Size: 0x158
function private function_50f0526b31e6a999( activityinstance, var_a2a2fe2794308690 )
{
    var_794ab44788075b2e = [];
    
    foreach ( player in var_a2a2fe2794308690 )
    {
        playersquad = activity_player_common::function_44ef43ff1f6d21d4( player );
        
        foreach ( var_c89d2f2f719aaf98 in playersquad )
        {
            if ( var_c89d2f2f719aaf98 != player && isdefined( function_f02c63b99c9614c9( activityinstance.playerparticipants, var_c89d2f2f719aaf98 ) ) )
            {
                var_794ab44788075b2e[ var_794ab44788075b2e.size ] = var_c89d2f2f719aaf98;
            }
        }
    }
    
    var_a636dcecbf28d235 = function_6bb697dfc5eadea2( activityinstance, var_794ab44788075b2e );
    
    if ( activity_definition_utils::function_dcdc4984a7c518e9( activityinstance, 2 ) )
    {
        activityinstance activity_player_broadcasting::function_cb4750c84882dd07( "PlayerAbandonNotification", var_a636dcecbf28d235 );
    }
    
    return var_a636dcecbf28d235;
}

// Namespace activity_participation
// Params 2, eflags: 0x4
// Checksum 0xf8be7006, Offset: 0x2362
// Size: 0x6e
function private function_8f12e784ba92f8a6( activityinstance, player )
{
    if ( isdefined( function_f02c63b99c9614c9( activityinstance.playerparticipants, player ) ) )
    {
        var_a98eca997eaf47f2 = spawnstruct();
        var_a98eca997eaf47f2 conditional_container::function_3c3be461141746c0();
        conditional_container::addcondition( var_a98eca997eaf47f2, &activity_instance_common::function_77b0ef7c93812bbe, [ activityinstance, "Proximity_Abandon_Zone" ] );
        function_267e1d48764a0750( activityinstance, player, 0, var_a98eca997eaf47f2 );
    }
}

/#

    // Namespace activity_participation
    // Params 0
    // Checksum 0xe734457e, Offset: 0x23d8
    // Size: 0x5, Type: dev
    function function_e9376b59709073ff()
    {
        
    }

#/

// Namespace activity_participation
// Params 1
// Checksum 0x717739dd, Offset: 0x23e5
// Size: 0x48
function function_adecd3e45b4e2277( activityinstance )
{
    /#
        if ( !spatial_zone_container::function_3819f09eefb741e2( activityinstance, "<dev string:x358>" ) )
        {
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x36f>", @"hash_39bc09a8c55a7875", activityinstance, undefined, 2 );
        }
    #/
    
    activityinstance.var_d467b93a06ae2411 = 1;
}

// Namespace activity_participation
// Params 1
// Checksum 0xd52f8e17, Offset: 0x2435
// Size: 0x25
function function_3edfb79e1bae6698( activityinstance )
{
    activityinstance.var_d467b93a06ae2411 = undefined;
    spatial_zone_container::function_4f9fccd04a537897( activityinstance, "Proximity_Abandon_Zone" );
}

// Namespace activity_participation
// Params 1
// Checksum 0x37563496, Offset: 0x2462
// Size: 0x18, Type: bool
function function_ce4baa6ff3a9ed21( activityinstance )
{
    return istrue( activityinstance.var_d467b93a06ae2411 );
}

// Namespace activity_participation
// Params 1
// Checksum 0xb6f04434, Offset: 0x2483
// Size: 0xb5
function function_44cacb7961053d7d( var_54c779cf281bb58d )
{
    activityinstance = self;
    spatialzonename = var_54c779cf281bb58d.zonename;
    player = var_54c779cf281bb58d.player;
    playerinzone = var_54c779cf281bb58d.enteredzone;
    assert( activity_instance_common::isactivityinstance( activityinstance ), "<dev string:x18e>" );
    assert( spatialzonename == "<dev string:x358>", "<dev string:x3fb>" );
    assert( isplayer( player ), "<dev string:x241>" );
    
    if ( !playerinzone && istrue( activityinstance.var_d467b93a06ae2411 ) )
    {
        function_8f12e784ba92f8a6( activityinstance, player );
    }
}

// Namespace activity_participation
// Params 0, eflags: 0x4
// Checksum 0x78591726, Offset: 0x2540
// Size: 0xe5
function private function_2a6cfa0172f499c1()
{
    var_ca3f65fdba0a9ed2 = level.activities;
    var_2ab2308e2350011c = var_ca3f65fdba0a9ed2.var_2ab2308e2350011c;
    var_c5b37022069b7ff5 = [];
    
    foreach ( instance in var_2ab2308e2350011c )
    {
        participatingplayercount = instance.playerparticipants.size;
        
        if ( spatial_zone_container::function_3819f09eefb741e2( instance, "Proximity_Abandon_Zone" ) && istrue( instance.var_d467b93a06ae2411 ) && participatingplayercount > 0 )
        {
            var_c5b37022069b7ff5[ var_c5b37022069b7ff5.size ] = instance;
        }
    }
    
    return var_c5b37022069b7ff5;
}

/#

    // Namespace activity_participation
    // Params 0
    // Checksum 0xd7761221, Offset: 0x262e
    // Size: 0x5, Type: dev
    function function_f863c83f8572cb2d()
    {
        
    }

#/

// Namespace activity_participation
// Params 1
// Checksum 0x435b0fc0, Offset: 0x263b
// Size: 0x21, Type: bool
function isactivityfull( activityinstance )
{
    return activityinstance.playerparticipants.size == activity_definition_utils::getmaxplayercount( activityinstance );
}

// Namespace activity_participation
// Params 2
// Checksum 0x345c9237, Offset: 0x2665
// Size: 0xc5, Type: bool
function function_7d9e88b09010d55a( player, activityvariantname )
{
    var_e287da7b36de07d7 = function_e8eabd79cc49540e( player );
    
    foreach ( instanceid, instanceinfostruct in var_e287da7b36de07d7 )
    {
        activityinstance = level.activities.instances[ instanceid ];
        
        if ( activityinstance.varianttag == activityvariantname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace activity_participation
// Params 2
// Checksum 0xe722f9d5, Offset: 0x2733
// Size: 0x2f, Type: bool
function function_75a087aafc3f50a4( player, types )
{
    var_e287da7b36de07d7 = function_e8eabd79cc49540e( player, types );
    return var_e287da7b36de07d7.size > 0;
}

// Namespace activity_participation
// Params 2
// Checksum 0x2cdedb4f, Offset: 0x276b
// Size: 0x9a, Type: bool
function function_e7fc1202ac164928( activityinstance, player )
{
    /#
        foundplayer = function_f02c63b99c9614c9( activityinstance.playerparticipants, player );
        var_e287da7b36de07d7 = function_e8eabd79cc49540e( player );
        foundinstanceid = var_e287da7b36de07d7[ activityinstance.id ];
        
        if ( isdefined( foundplayer ) && !isdefined( foundinstanceid ) || !isdefined( foundplayer ) && isdefined( foundinstanceid ) )
        {
            assertmsg( "<dev string:x45d>" );
        }
    #/
    
    return isdefined( function_f02c63b99c9614c9( activityinstance.playerparticipants, player ) );
}

// Namespace activity_participation
// Params 2
// Checksum 0x640c3473, Offset: 0x280e
// Size: 0x108
function function_e8eabd79cc49540e( player, types )
{
    var_502a5f74699d2293 = activity_player_common::function_ef912bdece1bc4ef( player );
    
    if ( isarray( var_502a5f74699d2293.participatingactivities ) && isarray( types ) )
    {
        result = [];
        
        foreach ( instanceid, activityinfostruct in var_502a5f74699d2293.participatingactivities )
        {
            activityinstance = level.activities.instances[ instanceid ];
            
            if ( arraycontains( types, activityinstance.type ) )
            {
                result[ instanceid ] = activityinfostruct;
            }
        }
        
        return result;
    }
    
    return var_502a5f74699d2293.participatingactivities;
}

// Namespace activity_participation
// Params 1
// Checksum 0xfbb6bcf5, Offset: 0x291f
// Size: 0x115
function function_a2ffa98b763c335d( player )
{
    var_e038b0f89c0db652 = spawnstruct();
    var_e038b0f89c0db652.var_17c317da52d9edca = 1;
    var_e038b0f89c0db652.var_3a1b6f52043e32b1 = [];
    var_e038b0f89c0db652.var_ed75c40304082166 = [];
    var_ccc91d79bfa22c3a = function_e8eabd79cc49540e( player );
    
    foreach ( activityinstanceid, activityinfostruct in var_ccc91d79bfa22c3a )
    {
        activityinstance = level.activities.instances[ activityinstanceid ];
        activityinstancecategory = activityinstance.category;
        var_e038b0f89c0db652 function_1fe7dd1f1820e6d( activityinstance, activityinstancecategory );
        
        if ( activity_definition_utils::function_6e5624d15e574a2a( activityinstance ) )
        {
            var_e038b0f89c0db652 function_690e357062226148( activityinstance, activityinstancecategory );
        }
    }
    
    return var_e038b0f89c0db652;
}

// Namespace activity_participation
// Params 1
// Checksum 0xf58e51b1, Offset: 0x2a3d
// Size: 0x21, Type: bool
function function_17c317da52d9edca( var_91ddbdd72b7a6e82 )
{
    return isstruct( var_91ddbdd72b7a6e82 ) && var_91ddbdd72b7a6e82.var_17c317da52d9edca;
}

// Namespace activity_participation
// Params 1
// Checksum 0x117fc13f, Offset: 0x2a67
// Size: 0x5f, Type: bool
function function_c9d70465e10a69e1( activityinstancecategory )
{
    var_e038b0f89c0db652 = self;
    assert( function_17c317da52d9edca( var_e038b0f89c0db652 ), "<dev string:x4b9>" );
    
    if ( isdefined( var_e038b0f89c0db652.var_ed75c40304082166[ activityinstancecategory ] ) )
    {
        var_3c037140e30f3b9d = var_e038b0f89c0db652.var_ed75c40304082166[ activityinstancecategory ].size;
        return ( var_3c037140e30f3b9d > 0 );
    }
    
    return false;
}

// Namespace activity_participation
// Params 1
// Checksum 0xad76ab, Offset: 0x2acf
// Size: 0x5f, Type: bool
function function_a63ffe2063075fb4( activityinstancecategory )
{
    var_e038b0f89c0db652 = self;
    assert( function_17c317da52d9edca( var_e038b0f89c0db652 ), "<dev string:x4b9>" );
    
    if ( isdefined( var_e038b0f89c0db652.var_3a1b6f52043e32b1[ activityinstancecategory ] ) )
    {
        var_3c037140e30f3b9d = var_e038b0f89c0db652.var_3a1b6f52043e32b1[ activityinstancecategory ].size;
        return ( var_3c037140e30f3b9d > 0 );
    }
    
    return false;
}

// Namespace activity_participation
// Params 2, eflags: 0x4
// Checksum 0x4291cbe1, Offset: 0x2b37
// Size: 0x83
function private function_1fe7dd1f1820e6d( activityinstance, activityinstancecategory )
{
    var_e038b0f89c0db652 = self;
    assert( function_17c317da52d9edca( var_e038b0f89c0db652 ), "<dev string:x4b9>" );
    
    if ( !isdefined( var_e038b0f89c0db652.var_3a1b6f52043e32b1[ activityinstancecategory ] ) )
    {
        var_e038b0f89c0db652.var_3a1b6f52043e32b1[ activityinstancecategory ] = [];
    }
    
    var_5d2228525a405493 = var_e038b0f89c0db652.var_3a1b6f52043e32b1[ activityinstancecategory ].size;
    var_e038b0f89c0db652.var_3a1b6f52043e32b1[ activityinstancecategory ][ var_5d2228525a405493 ] = activityinstance;
}

// Namespace activity_participation
// Params 2, eflags: 0x4
// Checksum 0x4be7ddc1, Offset: 0x2bc2
// Size: 0x83
function private function_690e357062226148( activityinstance, activityinstancecategory )
{
    var_e038b0f89c0db652 = self;
    assert( function_17c317da52d9edca( var_e038b0f89c0db652 ), "<dev string:x4b9>" );
    
    if ( !isdefined( var_e038b0f89c0db652.var_ed75c40304082166[ activityinstancecategory ] ) )
    {
        var_e038b0f89c0db652.var_ed75c40304082166[ activityinstancecategory ] = [];
    }
    
    var_5d2228525a405493 = var_e038b0f89c0db652.var_ed75c40304082166[ activityinstancecategory ].size;
    var_e038b0f89c0db652.var_ed75c40304082166[ activityinstancecategory ][ var_5d2228525a405493 ] = activityinstance;
}

// Namespace activity_participation
// Params 3, eflags: 0x4
// Checksum 0x6875f359, Offset: 0x2c4d
// Size: 0x6f
function private function_7ff34b66748a92a1( player, activityinstance, playerjoinreason )
{
    var_951219e42f27afab = spawnstruct();
    var_951219e42f27afab.currentlyabandoning = 0;
    var_951219e42f27afab.joinreason = playerjoinreason;
    var_951219e42f27afab.var_c1037ce8aa4e3ba8 = 0;
    var_951219e42f27afab.instanceid = activityinstance.id;
    return var_951219e42f27afab;
}

// Namespace activity_participation
// Params 3, eflags: 0x4
// Checksum 0x5196b947, Offset: 0x2cc5
// Size: 0x60
function private function_e93ffc647c10ad9d( player, activityinstance, playerjoinreason )
{
    var_951219e42f27afab = function_7ff34b66748a92a1( player, activityinstance, playerjoinreason );
    var_502a5f74699d2293 = activity_player_common::function_ef912bdece1bc4ef( player );
    var_502a5f74699d2293.participatingactivities[ activityinstance.id ] = var_951219e42f27afab;
}

// Namespace activity_participation
// Params 2, eflags: 0x4
// Checksum 0x436fba8c, Offset: 0x2d2d
// Size: 0x5b
function private function_2435aaee2b5ee2cd( player, activityinstance )
{
    var_502a5f74699d2293 = activity_player_common::function_ef912bdece1bc4ef( player );
    
    if ( isdefined( var_502a5f74699d2293.participatingactivities[ activityinstance.id ] ) )
    {
        var_502a5f74699d2293.participatingactivities[ activityinstance.id ] = undefined;
    }
}

/#

    // Namespace activity_participation
    // Params 0
    // Checksum 0xce03820b, Offset: 0x2d90
    // Size: 0x5, Type: dev
    function function_e37c42226fdad080()
    {
        
    }

#/

// Namespace activity_participation
// Params 2
// Checksum 0x13b9438e, Offset: 0x2d9d
// Size: 0x69, Type: bool
function function_3d02626f747c5143( player, params )
{
    assert( params.size == 2 && isdefined( params[ 0 ] ), "<dev string:x506>" );
    activityinstance = params[ 0 ];
    maxplayercount = params[ 1 ];
    instanceisfull = activityinstance.playerparticipants.size == maxplayercount;
    return !instanceisfull;
}

// Namespace activity_participation
// Params 2
// Checksum 0x3fef473a, Offset: 0x2e0f
// Size: 0x5e, Type: bool
function function_ad5bd80478398b57( player, params )
{
    assert( params.size == 1 && isdefined( params[ 0 ] ), "<dev string:x506>" );
    activityinstance = params[ 0 ];
    var_569451dec9323eb8 = isdefined( function_f02c63b99c9614c9( activityinstance.playerparticipants, player ) );
    return !var_569451dec9323eb8;
}

// Namespace activity_participation
// Params 2
// Checksum 0x545d91af, Offset: 0x2e76
// Size: 0x5f, Type: bool
function function_2d11884b67f01fb9( player, params )
{
    assert( params.size == 1 && isdefined( params[ 0 ] ), "<dev string:x506>" );
    activityinstance = params[ 0 ];
    var_2eb1e6c826edfc70 = function_7d9e88b09010d55a( player, activityinstance.varianttag );
    return !var_2eb1e6c826edfc70;
}

// Namespace activity_participation
// Params 2
// Checksum 0x991dcc3d, Offset: 0x2ede
// Size: 0x1e, Type: bool
function function_846bf57804dbe69b( player, params )
{
    return !function_75a087aafc3f50a4( player );
}

// Namespace activity_participation
// Params 2
// Checksum 0x7fff6fde, Offset: 0x2f05
// Size: 0x1d, Type: bool
function function_d1ee7fc846133adf( player, params )
{
    return function_75a087aafc3f50a4( player );
}

