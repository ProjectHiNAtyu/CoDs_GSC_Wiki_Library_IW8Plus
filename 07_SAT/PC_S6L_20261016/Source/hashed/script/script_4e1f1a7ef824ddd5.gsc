// script_4e1f1a7ef824ddd5  (hash_4e1f1a7ef824ddd5.gscc) (size: 12854 Bytes / 0x3236 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95c06c15 (2512415765)
// size ...... 12854 (0x3236)
// includes .. 6   (offset: 0x2e9e)
// strings ... 38  (offset: 0x2ece)
// dev strs .. 26  (offset: 0x30e6)
// exports ... 49  (offset: 0x223a)
// cseg ...... 0x4b0 + 0x1d8a (0x223a)
// imports ... 38  (offset: 0x29e2)
// animtree1 . 0   (offset: 0x3236)
// animtree2 . 0   (offset: 0x3236)
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\data_tracker;
#using scripts\common\player_broadcasting;
#using scripts\common\progress_tracker;
#using scripts\common\spatial_zone_container;

#namespace namespace_2aca03e533f9f843;

// Namespace namespace_2aca03e533f9f843
// Params 0
// Checksum 0xc71082fd, Offset: 0x4ce
// Size: 0x1d6
function function_7975ee848848e12a()
{
    if ( isdefined( level.var_204c07e9b30c1d38 ) )
    {
        return;
    }
    
    level.var_204c07e9b30c1d38 = { #var_bb0e1e042ea255bd:[] };
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_ActivityBroadcastData_ActivationName_StringReference" ] = "StringReference";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_StringReference_ActivationName" ] = "StringReference";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_ActivityBroadcastData_ActivationName_SplashReference" ] = "TitleSplash";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_Splash_ActivationName" ] = "TitleSplash";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_ActivityBroadcastData_ActivationName_MusicReference" ] = "Music";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_Music_ActivationName" ] = "Music";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_ActivityBroadcastData_ActivationName_OverlordReference" ] = "Overlord";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_Overlord_ActivationName" ] = "Overlord";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_ActivityBroadcastData_ActivationName_OverlordConversation" ] = "Overlord";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_OverlordConversation_ActivationName" ] = "Overlord";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_OverlordList_ActivationName" ] = "OverlordList";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_ActivityBroadcastData_ActivationName_Omnvar" ] = "Omnvar";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_OmnvarConversation_ActivationName" ] = "Omnvar";
    level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ "Types_StringText_ActivationName" ] = "StringText";
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x816d1b95, Offset: 0x6ac
// Size: 0x25b
function function_2b7077459c53fdd3( var_68aeb141d2220f90 )
{
    var_68aeb141d2220f90 = var_68aeb141d2220f90 ?? [];
    var_421de54621e2c0ac = [];
    
    foreach ( var_68ea23b25cadc243 in var_68aeb141d2220f90 )
    {
        broadcasttype = var_68ea23b25cadc243.variant_object.broadcasttype;
        
        if ( broadcasttype == "Multiple" )
        {
            foreach ( var_319c151ef5aae55e in var_68ea23b25cadc243.variant_object.broadcastdata )
            {
                var_de5a37b0fd8cf91e = var_319c151ef5aae55e.variant_object.broadcasttype;
                var_421de54621e2c0ac[ var_421de54621e2c0ac.size ] = function_eb84a5b72a389166( var_68ea23b25cadc243, var_de5a37b0fd8cf91e, [ var_319c151ef5aae55e ] );
            }
            
            continue;
        }
        
        if ( broadcasttype == "ActivationNameBucket" )
        {
            foreach ( var_86661996bdc3a00f in var_68ea23b25cadc243.variant_object.broadcastdata )
            {
                var_e47d27f33f641b77 = level.var_204c07e9b30c1d38.var_bb0e1e042ea255bd[ var_86661996bdc3a00f.variant_type ];
                var_fd1469c4cfb8c912 = function_eb84a5b72a389166( var_68ea23b25cadc243, var_e47d27f33f641b77, [ var_86661996bdc3a00f ], var_86661996bdc3a00f.variant_object.activationname );
                var_421de54621e2c0ac[ var_421de54621e2c0ac.size ] = var_fd1469c4cfb8c912;
            }
            
            continue;
        }
        
        var_421de54621e2c0ac[ var_421de54621e2c0ac.size ] = function_eb84a5b72a389166( var_68ea23b25cadc243 );
    }
    
    return var_421de54621e2c0ac;
}

// Namespace namespace_2aca03e533f9f843
// Params 2
// Checksum 0x819a8bd6, Offset: 0x910
// Size: 0x189
function function_5403291ba35ad13f( var_f504771295c70965, broadcastdefinitions )
{
    if ( !isarray( broadcastdefinitions ) || broadcastdefinitions.size == 0 )
    {
        return;
    }
    
    for ( var_37cef259d5c840f9 = 0; var_37cef259d5c840f9 < broadcastdefinitions.size ; var_37cef259d5c840f9++ )
    {
        broadcastdefinition = broadcastdefinitions[ var_37cef259d5c840f9 ];
        broadcastdefinition.id = var_f504771295c70965.var_8e8e3e6c78f88433;
        var_f504771295c70965.var_8e8e3e6c78f88433++;
        var_4fecda9cb158c52d = broadcastdefinition.activationmoment ?? "None";
        
        if ( var_4fecda9cb158c52d == "ActivationName" )
        {
            broadcastactivationname = broadcastdefinition.activationname;
            
            if ( isdefined( broadcastactivationname ) )
            {
                if ( !isdefined( var_f504771295c70965.var_3184d3dd50546cc3[ broadcastactivationname ] ) )
                {
                    var_f504771295c70965.var_3184d3dd50546cc3[ broadcastactivationname ] = [];
                }
                
                activationnamearraysize = var_f504771295c70965.var_3184d3dd50546cc3[ broadcastactivationname ].size;
                var_f504771295c70965.var_3184d3dd50546cc3[ broadcastactivationname ][ activationnamearraysize ] = broadcastdefinition;
                var_f504771295c70965.var_3e21aec4f4280788[ var_f504771295c70965.var_3e21aec4f4280788.size ] = broadcastdefinition;
            }
            
            continue;
        }
        
        if ( !isdefined( var_f504771295c70965.var_8b90311fda82dea4[ var_4fecda9cb158c52d ] ) )
        {
            var_f504771295c70965.var_8b90311fda82dea4[ var_4fecda9cb158c52d ] = [];
        }
        
        var_d68eeaf31ea517de = var_f504771295c70965.var_8b90311fda82dea4[ var_4fecda9cb158c52d ].size;
        var_f504771295c70965.var_8b90311fda82dea4[ var_4fecda9cb158c52d ][ var_d68eeaf31ea517de ] = broadcastdefinition;
        var_f504771295c70965.var_3e21aec4f4280788[ var_f504771295c70965.var_3e21aec4f4280788.size ] = broadcastdefinition;
    }
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x8f0ce251, Offset: 0xaa1
// Size: 0x29, Type: bool
function function_72b6028c320ba24e( broadcastinstance )
{
    return broadcastinstance.broadcastdefinition.activationmoment ?? "None";
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xce4cc9f7, Offset: 0xad3
// Size: 0x29, Type: bool
function function_7dc960412c91616d( broadcastinstance )
{
    return broadcastinstance.broadcastdefinition.deactivationmoment ?? "None";
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x98ff4d46, Offset: 0xb05
// Size: 0x29, Type: bool
function getbroadcastdestination( broadcastinstance )
{
    return broadcastinstance.broadcastdefinition.destination ?? "Instance";
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x328390fa, Offset: 0xb37
// Size: 0x1d
function function_a0a2837d2275b131( broadcastinstance )
{
    return function_fbe90d075add832c( broadcastinstance.broadcastdefinition );
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xa2db3fd1, Offset: 0xb5d
// Size: 0x21
function getactivationname( broadcastinstance )
{
    return broadcastinstance.broadcastdefinition.activationname;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xf730e7bd, Offset: 0xb87
// Size: 0x21
function getdeactivationname( broadcastinstance )
{
    return broadcastinstance.broadcastdefinition.deactivationname;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xc9a8eaf3, Offset: 0xbb1
// Size: 0xc3
function function_17903639bb0d3288( broadcastinstance )
{
    /#
        broadcastdestination = broadcastinstance.broadcastdefinition.destination ?? "<dev string:x24>";
        
        if ( "<dev string:x2d>" != broadcastdestination )
        {
            assertmsg( "<dev string:x36>" + broadcastinstance player_broadcasting::getbroadcastuniqueid() + "<dev string:x47>" );
            return;
        }
    #/
    
    activityinstance = self;
    broadcastinstancespatialzonename = "Broadcast Spatial Zone: " + broadcastinstance player_broadcasting::getbroadcastuniqueid();
    
    if ( !spatial_zone_container::function_3819f09eefb741e2( activityinstance, broadcastinstancespatialzonename ) )
    {
        zoneinfostruct = broadcastinstance.broadcastdefinition.var_51e99de153650289;
        activity_definition_utils::function_77f316c8a973cf7a( activityinstance, broadcastinstancespatialzonename, zoneinfostruct );
    }
    
    return spatial_zone_container::function_84f653d797112085( activityinstance, broadcastinstancespatialzonename );
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x3cdf8ea1, Offset: 0xc7d
// Size: 0x59, Type: bool
function function_8dd79a05f1b16fbb( broadcastdefinition )
{
    /#
        if ( !isdefined( broadcastdefinition.activationmoment ) )
        {
            uniquename = broadcastdefinition.uniquename;
            assert( isdefined( uniquename ), "<dev string:xa5>" );
        }
    #/
    
    return broadcastdefinition.activationmoment ?? "None";
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xa9114e85, Offset: 0xcdf
// Size: 0x1f, Type: bool
function function_32df469e1b66b838( broadcastdefinition )
{
    return broadcastdefinition.deactivationmoment ?? "None";
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xd8660eac, Offset: 0xd07
// Size: 0x17
function function_763d2ceaafcd9e70( broadcastdefinition )
{
    return broadcastdefinition.type;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x2bdbffe2, Offset: 0xd27
// Size: 0x1f, Type: bool
function function_9605b8e6136b42d6( broadcastdefinition )
{
    return broadcastdefinition.destination ?? "Instance";
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x9b270f9f, Offset: 0xd4f
// Size: 0xb5
function function_fbe90d075add832c( broadcastdefinition )
{
    assert( isdefined( broadcastdefinition.priority ), "<dev string:x122>" );
    prioritynum = 2;
    
    switch ( broadcastdefinition.priority )
    {
        case #"hash_4f2a820d1b7462cf":
            prioritynum = 0;
            break;
        case #"hash_3e26921a2943163d":
            prioritynum = 1;
            break;
        case #"hash_4d3d7a9f6b7b2fb6":
            prioritynum = 2;
            break;
        case #"hash_1dd8746c9fb86ec1":
            prioritynum = 3;
            break;
        case #"hash_ee858280143c22fb":
            prioritynum = 4;
            break;
        default:
            break;
    }
    
    return prioritynum;
}

// Namespace namespace_2aca03e533f9f843
// Params 2
// Checksum 0x90c678c9, Offset: 0xe0d
// Size: 0x160, Type: bool
function function_554224fe208bff0b( broadcastinstance = self, uniquename )
{
    assert( player_broadcasting::function_674ee71664c02724( broadcastinstance ), "<dev string:x180>" );
    dataobjects = broadcastinstance player_broadcasting::function_d95fdf9867bbbdc3();
    
    foreach ( dataobject in dataobjects )
    {
        dynamicdatastructs = dataobject.dynamicdata ?? [];
        
        if ( dynamicdatastructs.size > 0 )
        {
            if ( isdefined( uniquename ) )
            {
                foreach ( dynamicdatastruct in dynamicdatastructs )
                {
                    if ( uniquename == dynamicdatastruct.variant_object.uniquename )
                    {
                        return true;
                    }
                }
                
                continue;
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x21b8de46, Offset: 0xf76
// Size: 0x17
function function_d1d334a81e442623( broadcastdefinition )
{
    return broadcastdefinition.uniquename;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xd834b89e, Offset: 0xf96
// Size: 0x67
function function_15b2bfee9e1dc1bc( broadcastdefinition )
{
    /#
        activationmoment = broadcastdefinition.activationmoment ?? "<dev string:x20b>";
        assert( activationmoment == "<dev string:x210>", "<dev string:x21f>" );
        assert( isdefined( broadcastdefinition.activationname ), "<dev string:x289>" );
    #/
    
    return broadcastdefinition.activationname;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x800bc12, Offset: 0x1006
// Size: 0x17
function function_b1effa61a85b0ea3( broadcastdefinition )
{
    return broadcastdefinition.deactivationname;
}

// Namespace namespace_2aca03e533f9f843
// Params 2
// Checksum 0x241ed879, Offset: 0x1026
// Size: 0x62
function function_312eb00c9a80736a( broadcastdefinition, associatedactivityinstance )
{
    var_ecefb2dc545926da = associatedactivityinstance.id + " broadcast ID: " + broadcastdefinition.id;
    activebroadcastinstance = activity_player_broadcasting::getactivebroadcastinstance( var_ecefb2dc545926da );
    
    if ( isdefined( activebroadcastinstance ) )
    {
        return activebroadcastinstance;
    }
    
    return function_4d15fd0d217eee2e( broadcastdefinition, associatedactivityinstance );
}

// Namespace namespace_2aca03e533f9f843
// Params 2
// Checksum 0x14c6d3cd, Offset: 0x1091
// Size: 0xd8
function function_c710a41fae98cbec( activationmoment, associatedactivityinstance )
{
    var_482e32ad011c21a3 = [];
    var_a953217975e7cf60 = associatedactivityinstance.var_2c769a213204c445;
    
    if ( !isdefined( var_a953217975e7cf60.var_1eaa249a063a0dba ) )
    {
        var_2d87a428473bc24b = undefined;
    }
    
    var_2d87a428473bc24b = istrue( var_a953217975e7cf60.var_1eaa249a063a0dba[ activationmoment ] );
    
    if ( !isdefined( var_2d87a428473bc24b ) || var_2d87a428473bc24b )
    {
        var_f504771295c70965 = activity_definition_utils::function_4dbc827bb8b7e595( associatedactivityinstance );
        var_149c29864caf2d81 = var_f504771295c70965.var_8b90311fda82dea4[ activationmoment ];
        
        if ( isdefined( var_149c29864caf2d81 ) )
        {
            for ( broadcastarrayindex = 0; broadcastarrayindex < var_149c29864caf2d81.size ; broadcastarrayindex++ )
            {
                broadcastdefinition = var_149c29864caf2d81[ broadcastarrayindex ];
                var_482e32ad011c21a3[ var_482e32ad011c21a3.size ] = function_312eb00c9a80736a( broadcastdefinition, associatedactivityinstance );
            }
        }
    }
    
    return var_482e32ad011c21a3;
}

// Namespace namespace_2aca03e533f9f843
// Params 2
// Checksum 0xdb6142b8, Offset: 0x1172
// Size: 0xdb
function function_d4938f10afc95724( activityinstance, uniquename )
{
    var_3b891b1c7abfe2ad = undefined;
    var_f504771295c70965 = activity_definition_utils::function_4dbc827bb8b7e595( activityinstance );
    
    /#
        var_47d0fbba26d25e6e = 0;
    #/
    
    for ( broadcastarrayindex = 0; broadcastarrayindex < var_f504771295c70965.var_3e21aec4f4280788.size ; broadcastarrayindex++ )
    {
        broadcastdefinition = var_f504771295c70965.var_3e21aec4f4280788[ broadcastarrayindex ];
        broadcastuniquename = broadcastdefinition.uniquename;
        
        if ( broadcastuniquename == uniquename )
        {
            var_3b891b1c7abfe2ad = function_312eb00c9a80736a( broadcastdefinition, activityinstance );
            
            /#
                var_47d0fbba26d25e6e++;
            #/
        }
    }
    
    /#
        if ( var_47d0fbba26d25e6e == 0 )
        {
            assertmsg( "<dev string:x2e2>" );
        }
        else if ( var_47d0fbba26d25e6e > 1 )
        {
            assertmsg( "<dev string:x369>" );
        }
    #/
    
    return var_3b891b1c7abfe2ad;
}

// Namespace namespace_2aca03e533f9f843
// Params 3
// Checksum 0xd24099f2, Offset: 0x1256
// Size: 0xb8
function function_a9c87ab2939586d3( activationname, associatedactivityinstance, specificbroadcasttype )
{
    var_7b21b93501a3984a = [];
    var_f504771295c70965 = activity_definition_utils::function_4dbc827bb8b7e595( associatedactivityinstance );
    var_6f4f8caf050a6897 = var_f504771295c70965.var_3184d3dd50546cc3[ activationname ];
    
    if ( isdefined( var_6f4f8caf050a6897 ) )
    {
        for ( broadcastarrayindex = 0; broadcastarrayindex < var_6f4f8caf050a6897.size ; broadcastarrayindex++ )
        {
            broadcastdefinition = var_6f4f8caf050a6897[ broadcastarrayindex ];
            broadcasttypeisallowed = !isdefined( specificbroadcasttype ) || specificbroadcasttype == broadcastdefinition.type;
            
            if ( broadcasttypeisallowed )
            {
                var_7b21b93501a3984a[ var_7b21b93501a3984a.size ] = function_312eb00c9a80736a( broadcastdefinition, associatedactivityinstance );
            }
        }
    }
    
    return var_7b21b93501a3984a;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x434288d4, Offset: 0x1317
// Size: 0x30
function function_a12099f1a0098ac0( broadcastdataobject )
{
    assert( isdefined( broadcastdataobject.stringreference ), "<dev string:x40b>" );
    return broadcastdataobject.stringreference;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x866a091a, Offset: 0x1350
// Size: 0x30
function function_a0c228acf304b0b6( broadcastdataobject )
{
    assert( isdefined( broadcastdataobject.splashreference ), "<dev string:x471>" );
    return broadcastdataobject.splashreference;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xa08cb7c5, Offset: 0x1389
// Size: 0x17
function function_f239baab75e464dd( broadcastdataobject )
{
    return broadcastdataobject.splashlistoverride;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xecb69e0b, Offset: 0x13a9
// Size: 0x17
function function_c7ae09f981d840dc( broadcastdataobject )
{
    return broadcastdataobject.splashdelay;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xff15f751, Offset: 0x13c9
// Size: 0x17
function function_822c710a6d0e6dae( broadcastdataobject )
{
    return broadcastdataobject.musicreference;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x7d83e3c5, Offset: 0x13e9
// Size: 0x17
function function_d0f7937bb785acc4( broadcastdataobject )
{
    return broadcastdataobject.musicdelay;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xf4c6157f, Offset: 0x1409
// Size: 0x30
function function_252db8813aaa17aa( broadcastdataobject )
{
    assert( isdefined( broadcastdataobject.var_3543d9eb46f58f8e ), "<dev string:x4d7>" );
    return broadcastdataobject.var_3543d9eb46f58f8e;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x3ad8fa28, Offset: 0x1442
// Size: 0x18, Type: bool
function function_3d27a1ebdd4c4ce6( broadcastdataobject )
{
    return istrue( broadcastdataobject.isoverlordconversation );
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x1ad37ee4, Offset: 0x1463
// Size: 0x18, Type: bool
function function_8f40b0da2744bec2( broadcastdataobject )
{
    return istrue( broadcastdataobject.shouldinterruptcurrent );
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xcf5722bf, Offset: 0x1484
// Size: 0x17
function function_31e84005fb5b9b08( broadcastdataobject )
{
    return broadcastdataobject.var_ba62d1173d751da4;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x71ba3832, Offset: 0x14a4
// Size: 0x30
function function_cb600fd486bdb72a( broadcastdataobject )
{
    assert( isdefined( broadcastdataobject.omnvarname ), "<dev string:x545>" );
    return broadcastdataobject.omnvarname;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xa347111d, Offset: 0x14dd
// Size: 0x30
function function_7993e978a51f1a99( broadcastdataobject )
{
    assert( isdefined( broadcastdataobject.omnvartype ), "<dev string:x5a6>" );
    return broadcastdataobject.omnvartype;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xbe717e1c, Offset: 0x1516
// Size: 0x146
function function_223197707cc140fe( broadcastdataobject )
{
    omnvartype = function_7993e978a51f1a99( broadcastdataobject );
    
    if ( !isdefined( broadcastdataobject.omnvarvalue ) )
    {
        switch ( omnvartype )
        {
            case #"hash_4730906c2f53f03e":
                return 0;
            case #"hash_7e95f72ed09f139d":
                return 0;
            case #"hash_3e4a6f464c850b65":
                return 0;
            case #"hash_2ac140ce3b5ea398":
                return "";
            default:
                assertmsg( "<dev string:x607>" + ( omnvartype ?? "<dev string:x64d>" ) + "<dev string:x657>" );
                break;
        }
    }
    
    switch ( omnvartype )
    {
        case #"hash_4730906c2f53f03e":
            return int( broadcastdataobject.omnvarvalue );
        case #"hash_7e95f72ed09f139d":
            return ( int( broadcastdataobject.omnvarvalue ) != 0 );
        case #"hash_3e4a6f464c850b65":
            return float( broadcastdataobject.omnvarvalue );
        case #"hash_2ac140ce3b5ea398":
            return broadcastdataobject.omnvarvalue;
        default:
            assertmsg( "<dev string:x607>" + ( omnvartype ?? "<dev string:x64d>" ) + "<dev string:x657>" );
            break;
    }
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x173bf135, Offset: 0x1664
// Size: 0x17
function function_e66727a6acee8a5f( broadcastdataobject )
{
    return broadcastdataobject.var_2b485668a319993b;
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x60db6f3a, Offset: 0x1684
// Size: 0x9b
function function_1b17545f10298abf( broadcastdataobject )
{
    if ( isdefined( broadcastdataobject.stylesettings ) )
    {
        if ( isarray( broadcastdataobject.stylesettings ) && broadcastdataobject.stylesettings.size > 0 )
        {
            return broadcastdataobject.stylesettings[ 0 ].variant_object.broadcaststyle;
        }
        else if ( isstruct( broadcastdataobject.stylesettings ) )
        {
            return broadcastdataobject.stylesettings.variant_object.broadcaststyle;
        }
    }
    
    return "None";
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0x8915bcf4, Offset: 0x1728
// Size: 0x8f
function function_47a2d930b02016bf( broadcastdataobject )
{
    if ( isdefined( broadcastdataobject.stylesettings ) )
    {
        if ( isarray( broadcastdataobject.stylesettings ) && broadcastdataobject.stylesettings.size > 0 )
        {
            return broadcastdataobject.stylesettings[ 0 ].variant_object;
        }
        else if ( isstruct( broadcastdataobject.stylesettings ) )
        {
            return broadcastdataobject.stylesettings.variant_object;
        }
    }
    
    assertmsg( "<dev string:x697>" );
}

// Namespace namespace_2aca03e533f9f843
// Params 1
// Checksum 0xa3c77645, Offset: 0x17c0
// Size: 0x1b, Type: bool
function function_4f657490daa8ca51( broadcastdataobject )
{
    return broadcastdataobject.dynamicdata ?? [];
}

// Namespace namespace_2aca03e533f9f843
// Params 3
// Checksum 0x97b83fda, Offset: 0x17e4
// Size: 0x118
function function_e2456da4d8c9ce1( broadcastinstance, broadcastdataobject, var_9f4849fc51ce426c )
{
    dynamicdatastructs = broadcastdataobject.dynamicdata ?? [];
    var_41ea3c9a10d47610 = dynamicdatastructs[ var_9f4849fc51ce426c ];
    
    if ( isdefined( var_41ea3c9a10d47610 ) )
    {
        associateddatatracker = broadcastinstance player_broadcasting::function_a716cbac4f23f938();
        var_74ddd9ad69cbf619 = function_8f3c2b12ce217c( var_41ea3c9a10d47610 );
        dynamicdatatype = function_f77ad16204c954b8( var_41ea3c9a10d47610 );
        var_af420e81183b4b27 = associateddatatracker data_tracker::function_72b9e57bfc6deb7a( var_74ddd9ad69cbf619 );
        dynamicdataformat = var_41ea3c9a10d47610.variant_object.format ?? undefined;
        var_3b81e3094f48ac7d = { #format:dynamicdataformat, #value:undefined, #type:dynamicdatatype };
        
        if ( var_af420e81183b4b27 )
        {
            var_3b81e3094f48ac7d.value = associateddatatracker data_tracker::getdatavalue( var_74ddd9ad69cbf619 );
        }
        else
        {
            var_3b81e3094f48ac7d.value = function_8a08d2b171c8be4a( var_41ea3c9a10d47610 );
        }
        
        return var_3b81e3094f48ac7d;
    }
}

// Namespace namespace_2aca03e533f9f843
// Params 4
// Checksum 0xe222d4d4, Offset: 0x1905
// Size: 0x1c5
function function_66deba6127b6ba4( broadcastformat, startingvalue, currentvalue, endvalue )
{
    if ( broadcastformat == "X_Complete" )
    {
        return [ currentvalue ];
    }
    else if ( broadcastformat == "X_Remaining" )
    {
        assert( isdefined( endvalue ), "<dev string:x705>" );
        remainingvalue = abs( endvalue - currentvalue );
        return [ remainingvalue ];
    }
    else if ( broadcastformat == "X_Out_Of_Y" )
    {
        assert( isdefined( endvalue ), "<dev string:x705>" );
        return [ currentvalue, endvalue ];
    }
    else if ( broadcastformat == "X_Percentage_Complete" )
    {
        assert( isdefined( endvalue ), "<dev string:x705>" );
        totalvalue = abs( endvalue - startingvalue );
        percentagecomplete = currentvalue / totalvalue * 100;
        
        if ( endvalue < startingvalue )
        {
            numerator = totalvalue - currentvalue;
            percentagecomplete = numerator / totalvalue * 100;
        }
        
        return [ percentagecomplete ];
    }
    else if ( broadcastformat == "X_Percentage_Remaining" )
    {
        assert( isdefined( endvalue ), "<dev string:x705>" );
        totalvalue = abs( endvalue - startingvalue );
        percentageremaining = currentvalue / totalvalue * 100;
        
        if ( endvalue > startingvalue )
        {
            numerator = totalvalue - currentvalue;
            percentageremaining = numerator / totalvalue * 100;
        }
        
        return [ percentageremaining ];
    }
    else if ( broadcastformat == "XX_YY_Clock" )
    {
        minutes = currentvalue / 60;
        leftnumber = floor( minutes );
        rightnumber = floor( ( minutes - leftnumber ) * 60 );
        return [ leftnumber, rightnumber ];
    }
    else
    {
        assertmsg( "<dev string:x769>" );
    }
    
    return [ currentvalue ];
}

// Namespace namespace_2aca03e533f9f843
// Params 2, eflags: 0x4
// Checksum 0xd1297f4d, Offset: 0x1ad3
// Size: 0xc6
function private function_4d15fd0d217eee2e( broadcastdefinition, associatedactivityinstance )
{
    broadcastinstance = player_broadcasting::function_f13a82c402b6308f( broadcastdefinition.type );
    broadcastinstance.groupid = associatedactivityinstance.id;
    broadcastinstance.uniqueid = associatedactivityinstance.id + " broadcast ID: " + broadcastdefinition.id;
    broadcastinstance.broadcastdefinition = broadcastdefinition;
    broadcastinstance.var_7dfc6ab3a8ad954d = istrue( broadcastdefinition.var_7dfc6ab3a8ad954d );
    broadcastinstance.broadcastdataobjects = broadcastdefinition.broadcastdataobjects;
    broadcastinstance player_broadcasting::function_e4c57927206b93fc( associatedactivityinstance );
    function_76849de8ec2f4ae8( broadcastinstance, broadcastdefinition, associatedactivityinstance );
    return broadcastinstance;
}

// Namespace namespace_2aca03e533f9f843
// Params 3, eflags: 0x4
// Checksum 0xf1c23436, Offset: 0x1ba2
// Size: 0xe6
function private function_76849de8ec2f4ae8( broadcastinstance, broadcastdefinition, associatedactivityinstance )
{
    var_f98aa3d4e1c7a436 = istrue( broadcastdefinition.var_f5f468009a5b98c3 );
    var_7e256f8317a878a6 = !istrue( broadcastdefinition.var_e3b59605ee21ecf9 );
    broadcastconflictresolutionoption = broadcastdefinition.broadcastconflictresolutionoption ?? level.activities.var_a4fd71cdbb5546e5[ broadcastdefinition.type ] ?? "None";
    var_13e1db5338546002 = broadcastconflictresolutionoption != "None";
    activity_player_broadcasting::function_210338c60bbfa246( broadcastinstance, associatedactivityinstance, var_7e256f8317a878a6, var_f98aa3d4e1c7a436, var_13e1db5338546002 );
    
    if ( broadcastconflictresolutionoption != "None" )
    {
        if ( broadcastconflictresolutionoption == "Delay" )
        {
            var_367fbf2bb993acaa = broadcastdefinition.var_6a8944dfeb13314b ?? 10;
            broadcastinstance player_broadcasting::function_2f5e3169b01237e8( var_367fbf2bb993acaa );
        }
    }
}

// Namespace namespace_2aca03e533f9f843
// Params 1, eflags: 0x4
// Checksum 0x897cd516, Offset: 0x1c90
// Size: 0x78
function private function_8f3c2b12ce217c( var_2b4456b42635a943 )
{
    /#
        defaultuniquename = "<dev string:x7d0>";
        
        if ( !isdefined( var_2b4456b42635a943.variant_object.uniquename ) || var_2b4456b42635a943.variant_object.uniquename == defaultuniquename )
        {
            assertmsg( "<dev string:x804>" );
        }
    #/
    
    return var_2b4456b42635a943.variant_object.uniquename;
}

// Namespace namespace_2aca03e533f9f843
// Params 1, eflags: 0x4
// Checksum 0x8301779d, Offset: 0x1d11
// Size: 0x21
function private function_f77ad16204c954b8( var_df6de0b51ad9db55 )
{
    return var_df6de0b51ad9db55.variant_object.dynamicdatatype;
}

// Namespace namespace_2aca03e533f9f843
// Params 1, eflags: 0x4
// Checksum 0x6f695714, Offset: 0x1d3b
// Size: 0x69
function private function_8a08d2b171c8be4a( var_df6de0b51ad9db55 )
{
    dynamicdatatype = function_f77ad16204c954b8( var_df6de0b51ad9db55 );
    defaultvalue = var_df6de0b51ad9db55.variant_object.defaultvalue;
    
    if ( dynamicdatatype == "ProgressTracker" )
    {
        return progress_tracker::createprogresstracker( defaultvalue.defaultstartingvalue, defaultvalue.defaultfinalvalue );
    }
    
    return defaultvalue;
}

// Namespace namespace_2aca03e533f9f843
// Params 4, eflags: 0x4
// Checksum 0x7f0ba46b, Offset: 0x1dad
// Size: 0x48c
function private function_eb84a5b72a389166( var_a460c3f71ae91b9a, var_b26c894f0b4a58cd, var_d6a22964dc16e99b, activationnameoverride )
{
    scriptbundlebroadcast = var_a460c3f71ae91b9a.variant_object;
    broadcasttype = var_b26c894f0b4a58cd ?? scriptbundlebroadcast.broadcasttype;
    broadcastdefinition = { #hasdynamicdata:undefined, #uniquename:undefined, #deactivationname:undefined, #activationname:undefined, #deactivationmoment:undefined, #activationmoment:undefined, #var_6a8944dfeb13314b:undefined, #broadcastconflictresolutionoption:undefined, #var_e3b59605ee21ecf9:undefined, #var_8efdce03c52f7421:undefined, #var_f5f468009a5b98c3:undefined, #var_7dfc6ab3a8ad954d:undefined, #priority:undefined, #destination:"Instance", #broadcastdataobjects:[], #type:broadcasttype };
    broadcastdefinition.priority = scriptbundlebroadcast.priority;
    broadcastdefinition.uniquename = scriptbundlebroadcast.uniquename;
    broadcastdefinition.var_7dfc6ab3a8ad954d = scriptbundlebroadcast.var_7dfc6ab3a8ad954d;
    broadcastdefinition.var_f5f468009a5b98c3 = scriptbundlebroadcast.var_f5f468009a5b98c3;
    broadcastdefinition.var_8efdce03c52f7421 = scriptbundlebroadcast.var_8efdce03c52f7421;
    broadcastdefinition.var_e3b59605ee21ecf9 = scriptbundlebroadcast.var_e3b59605ee21ecf9;
    broadcastdefinition.uniquename = scriptbundlebroadcast.uniquename;
    broadcastdefinition.activationmoment = scriptbundlebroadcast.activationmoment[ 0 ].variant_object.activitymoment ?? scriptbundlebroadcast.activationmoment[ 0 ].variant_object.activationmoment;
    broadcastdefinition.activationname = activationnameoverride ?? scriptbundlebroadcast.activationmoment[ 0 ].variant_object.activationname;
    broadcastdefinition.deactivationmoment = scriptbundlebroadcast.deactivationmoment[ 0 ].variant_object.activitymoment ?? scriptbundlebroadcast.deactivationmoment[ 0 ].variant_object.deactivationmoment;
    broadcastdefinition.deactivationname = scriptbundlebroadcast.deactivationmoment[ 0 ].variant_object.activationname;
    broadcastdefinition.destination = scriptbundlebroadcast.destination[ 0 ].variant_object.broadcastdestination ?? "Instance";
    broadcastdefinition.broadcastconflictresolutionoption = scriptbundlebroadcast.var_42a5ed51e40aebfb[ 0 ].variant_object.broadcastconflictresolutionoption;
    
    if ( isdefined( broadcastdefinition.activationname ) && !isdefined( broadcastdefinition.activationmoment ) )
    {
        broadcastdefinition.activationmoment = "ActivationName";
    }
    
    if ( broadcastdefinition.destination == "Distance" )
    {
        broadcastdefinition.var_51e99de153650289 = scriptbundlebroadcast.destination[ 0 ].variant_object.broadcastdistance[ 0 ].variant_object;
    }
    
    broadcastdefinition.broadcastdataobjects = [];
    broadcastdataobjects = var_d6a22964dc16e99b ?? scriptbundlebroadcast.broadcastdata;
    var_530d601981deb003 = undefined;
    
    foreach ( broadcastdataobject in broadcastdataobjects )
    {
        var_b64fe64a52320557 = structcopy( broadcastdataobject.variant_object, 1 );
        
        if ( var_b64fe64a52320557.dynamicdata.size == 0 )
        {
            var_b64fe64a52320557.dynamicdata = undefined;
        }
        else
        {
            var_530d601981deb003 = 1;
        }
        
        broadcastdefinition.broadcastdataobjects[ broadcastdefinition.broadcastdataobjects.size ] = var_b64fe64a52320557;
    }
    
    broadcastdefinition.hasdynamicdata = var_530d601981deb003;
    return broadcastdefinition;
}

