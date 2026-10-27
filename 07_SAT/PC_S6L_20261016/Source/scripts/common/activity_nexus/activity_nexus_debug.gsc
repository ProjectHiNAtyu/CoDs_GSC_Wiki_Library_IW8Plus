// scripts\common\activity_nexus\activity_nexus_debug.gsc  (hash_69192f0994851b83.gscc) (size: 18372 Bytes / 0x47c4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5ae56429 (1524982825)
// size ...... 18372 (0x47c4)
// includes .. 14  (offset: 0x3f34)
// strings ... 0   (offset: 0x3fa4)
// dev strs .. 155 (offset: 0x3fa4)
// exports ... 59  (offset: 0x2488)
// cseg ...... 0x58 + 0x2430 (0x2488)
// imports ... 135 (offset: 0x2dc0)
// animtree1 . 0   (offset: 0x47c4)
// animtree2 . 0   (offset: 0x47c4)
#using script_4e1f1a7ef824ddd5;
#using script_6d60a2f06878900a;
#using script_77873e194e406c6d;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_voting;
#using scripts\common\conditional_container;
#using scripts\common\devgui;
#using scripts\common\player_broadcasting;
#using scripts\common\spatial_zone_container;
#using scripts\common\utility;

#namespace activity_nexus_debug;

/#

    // Namespace activity_nexus_debug
    // Params 0
    // Checksum 0x19d72777, Offset: 0x76
    // Size: 0x2f, Type: dev
    function function_3a45e311cf4d30b7()
    {
        pathprefix = "<dev string:x24>";
        
        if ( utility::issp() )
        {
            pathprefix = "<dev string:x27>";
        }
        
        return pathprefix + "<dev string:x2a>";
    }

    // Namespace activity_nexus_debug
    // Params 0
    // Checksum 0x5cef9e0e, Offset: 0xad
    // Size: 0x412, Type: dev
    function function_a57a09800d3ae1d7()
    {
        var_72a41c61e0a93ba7 = function_3a45e311cf4d30b7();
        devgui::add_devgui_func( var_72a41c61e0a93ba7 + "<dev string:x3b>", "<dev string:x4f>", &function_b3622208d7086953, 0, 0 );
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x61>" );
        devgui::add_devgui_func( "<dev string:x7c>", "<dev string:x96>", &function_8f446fc622b352e0 );
        devgui::add_devgui_func( "<dev string:xac>", "<dev string:xc6>", &function_1772d11ad9fafc51 );
        devgui::add_devgui_func( "<dev string:xe4>", "<dev string:xfc>", &function_143db9187f353bb3 );
        devgui::add_devgui_func( "<dev string:x110>", "<dev string:x141>", &function_7bae501e24e7329a );
        devgui::add_devgui_func( "<dev string:x160>", "<dev string:x181>", &function_9c546cdbf8fb9489 );
        devgui::add_devgui_func( "<dev string:x19b>", "<dev string:x1be>", &function_e2a6b80c3f3aa974 );
        devgui::add_devgui_func( "<dev string:x1d7>", "<dev string:x1fd>", &function_7543fd893e36758e );
        devgui::add_devgui_func( "<dev string:x219>", "<dev string:x23c>", &function_d176c140ffeaa458 );
        devgui::add_devgui_func( "<dev string:x255>", "<dev string:x27d>", &function_635323876131e2e0 );
        devgui::add_devgui_func( "<dev string:x29a>", "<dev string:x2c5>", &function_c44b12ec086d432d );
        devgui::add_devgui_func( "<dev string:x2e5>", "<dev string:x313>", &function_40d0d60749cec4d );
        devgui::add_devgui_func( "<dev string:x335>", "<dev string:x35e>", &function_86917a22cd4060db );
        devgui::add_devgui_func( "<dev string:x378>", "<dev string:x39d>", &function_35f054aa05fa605e );
        devgui::add_devgui_func( "<dev string:x3b8>", "<dev string:x3de>", &function_c7ede2082c7d5f49 );
        devgui::add_devgui_func( "<dev string:x403>", "<dev string:x422>", &function_78e111ef05563b81 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x438>" );
        devgui::add_devgui_func( "<dev string:x45c>", "<dev string:x475>", &function_ff69add1918b0b29 );
        devgui::add_devgui_func( "<dev string:x493>", "<dev string:x4a7>", &function_c8b5b571c00b533d );
        devgui::add_devgui_func( "<dev string:x4ce>", "<dev string:x4e3>", &function_b709afb2f824a694 );
        devgui::add_devgui_func( "<dev string:x50b>", "<dev string:x522>", &function_5d615f465720a8ee );
        devgui::add_devgui_func( "<dev string:x54c>", "<dev string:x563>", &function_6a1bc96b5263090d );
        devgui::add_devgui_func( "<dev string:x57e>", "<dev string:x592>", &function_a16148172b9183a );
        devgui::add_devgui_func( "<dev string:x5aa>", "<dev string:x5c5>", &function_5bc8631464cc2ea8 );
        devgui::add_devgui_func( "<dev string:x5e5>", "<dev string:x608>", &function_bfd33a043e737180 );
        devgui::add_devgui_func( "<dev string:x623>", "<dev string:x646>", &function_b551d82df1a209d0 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x661>" );
        devgui::add_devgui_func( "<dev string:x45c>", "<dev string:x685>", &function_429accbb1d130f8f );
        devgui::add_devgui_func( "<dev string:x4ce>", "<dev string:x6a3>", &function_e342bd0a0eadcffa );
        devgui::add_devgui_func( "<dev string:x50b>", "<dev string:x6cb>", &function_9a18ec3941b21f6c );
        devgui::add_devgui_func( "<dev string:x54c>", "<dev string:x6f5>", &function_bb01fe791b3037cb );
        devgui::add_devgui_func( "<dev string:x57e>", "<dev string:x710>", &function_f937515f9b8631bc );
        devgui::add_devgui_func( "<dev string:x5aa>", "<dev string:x728>", &function_8356c8a661f01b86 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x748>" );
        devgui::add_devgui_func( "<dev string:x751>", "<dev string:x75c>", &function_8f63787000cc2a03 );
        devgui::add_devgui_func( "<dev string:x76e>", "<dev string:x78f>", &function_4253353a3c05fa52 );
        devgui::add_devgui_func( "<dev string:x7ae>", "<dev string:x7d7>", &function_137519f5cbb97015 );
        devgui::add_devgui_func( "<dev string:x7fd>", "<dev string:x823>", &function_a09b53dad2531b54 );
        devgui::add_devgui_func( "<dev string:x847>", "<dev string:x871>", &function_f007c02f66f95f21 );
        devgui::add_devgui_func( "<dev string:x898>", "<dev string:x8c1>", &function_bf7049a7c9d21ff4 );
        devgui::add_devgui_func( "<dev string:x8e7>", "<dev string:x913>", &function_9ded647c7e840d13 );
        devgui::add_devgui_func( "<dev string:x93c>", "<dev string:x967>", &function_56dc99f612035ffe );
        devgui::add_devgui_func( "<dev string:x98f>", "<dev string:x9bf>", &function_af57940330b93c03 );
        devgui::function_77df7fe7dd273e10();
        activity_player_broadcasting::function_22e418c00e4f046d();
        activity_voting::function_52715f99efaf4a43();
        thread function_1772d11ad9fafc51();
        level.activities.var_e19a335333e508fd = &function_d3dd70f2622c7e15;
    }

    // Namespace activity_nexus_debug
    // Params 2, eflags: 0x4
    // Checksum 0xdc2a8fe6, Offset: 0x4c7
    // Size: 0x295, Type: dev
    function private function_d3dd70f2622c7e15( variant, activitydefinition )
    {
        category = activity_definition_utils::function_897014a17bf1cbdc( activitydefinition );
        customproperties = activity_definition_utils::function_9129cd8075c85c09( activitydefinition );
        type = customproperties.activitytype;
        var_72a41c61e0a93ba7 = function_3a45e311cf4d30b7();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x9e3>" + category + "<dev string:x9f3>" + type + "<dev string:x9f3>" );
        devgui::function_cd4e263c1f3018ae( variant, "<dev string:x9f5>" + "<dev string:xa04>" + type + "<dev string:xa04>" + variant, &function_cc21d49b6b23441b );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:xa06>" + category + "<dev string:x9f3>" + type + "<dev string:x9f3>" );
        devgui::function_cd4e263c1f3018ae( type, "<dev string:xa25>" + "<dev string:xa04>" + type, &function_419188e666e9ee5c );
        devgui::function_77df7fe7dd273e10();
        var_f504771295c70965 = activity_definition_utils::function_4dbc827bb8b7e595( activitydefinition );
        activitynexussettings = level.activities.activitynexussettings;
        
        if ( !activitynexussettings.var_5301c7b48f743f30 )
        {
            devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:xa39>" + category + "<dev string:x9f3>" + type + "<dev string:x9f3>" + variant + "<dev string:x9f3>" );
            
            for ( i = 0; i < var_f504771295c70965.var_3e21aec4f4280788.size ; i++ )
            {
                broadcastdefinition = var_f504771295c70965.var_3e21aec4f4280788[ i ];
                optionname = namespace_2aca03e533f9f843::function_d1d334a81e442623( broadcastdefinition );
                
                if ( !isdefined( optionname ) )
                {
                    activationmoment = namespace_2aca03e533f9f843::function_8dd79a05f1b16fbb( broadcastdefinition ) ?? "<dev string:xa53>";
                    
                    if ( activationmoment == "<dev string:xa54>" )
                    {
                        activationname = broadcastdefinition.activationname;
                        activationmoment = activationname ?? activationmoment;
                    }
                    
                    broadcasttype = namespace_2aca03e533f9f843::function_763d2ceaafcd9e70( broadcastdefinition ) ?? "<dev string:xa53>";
                    optionname = activationmoment + "<dev string:xa63>" + broadcasttype;
                }
                
                devgui::function_cd4e263c1f3018ae( optionname + "<dev string:xa65>", "<dev string:xa78>" + "<dev string:xa04>" + type + "<dev string:xa04>" + variant + "<dev string:xa04>" + i + "<dev string:xa04>" + "<dev string:xa8a>", &function_fde9970b9ffb31bc );
                devgui::function_cd4e263c1f3018ae( optionname + "<dev string:xa8f>", "<dev string:xa78>" + "<dev string:xa04>" + type + "<dev string:xa04>" + variant + "<dev string:xa04>" + i, &function_fde9970b9ffb31bc );
            }
            
            devgui::function_77df7fe7dd273e10();
        }
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xc35bb28f, Offset: 0x764
    // Size: 0x88, Type: dev
    function private function_b3622208d7086953()
    {
        foreach ( activityinstance in level.activities.instances )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( activityinstance );
        }
    }

    // Namespace activity_nexus_debug
    // Params 1, eflags: 0x4
    // Checksum 0xd5eab6cf, Offset: 0x7f4
    // Size: 0x1a0, Type: dev
    function private function_fde9970b9ffb31bc( params )
    {
        type = params[ 0 ];
        variant = params[ 1 ];
        id = int( params[ 2 ] );
        var_6fcc0261719bbaae = params[ 3 ] == "<dev string:xa8a>";
        activitydefinition = activity_definition_utils::getactivitydefinition( variant );
        var_f504771295c70965 = activity_definition_utils::function_4dbc827bb8b7e595( activitydefinition );
        broadcastdefinition = var_f504771295c70965.var_3e21aec4f4280788[ id ];
        
        if ( var_6fcc0261719bbaae )
        {
            var_2dad3e6205619265 = { #id:0 };
            broadcastinstance = namespace_2aca03e533f9f843::function_312eb00c9a80736a( broadcastdefinition, var_2dad3e6205619265 );
            player_broadcasting::broadcasttoplayer( function_654efc1380781476(), broadcastinstance );
            return;
        }
        
        allinstances = level.activities.instances;
        associatedactivityinstance = undefined;
        
        foreach ( activityinstance in allinstances )
        {
            if ( isdefined( activityinstance ) )
            {
                if ( activityinstance.varianttag == variant )
                {
                    associatedactivityinstance = activityinstance;
                    break;
                }
            }
        }
        
        if ( isdefined( associatedactivityinstance ) )
        {
            broadcastinstance = namespace_2aca03e533f9f843::function_312eb00c9a80736a( broadcastdefinition, associatedactivityinstance );
            associatedactivityinstance activity_player_broadcasting::broadcast( broadcastinstance, associatedactivityinstance.playerparticipants );
        }
    }

    // Namespace activity_nexus_debug
    // Params 1, eflags: 0x4
    // Checksum 0x3ddc0ada, Offset: 0x99c
    // Size: 0x55, Type: dev
    function private function_cc21d49b6b23441b( params )
    {
        type = params[ 0 ];
        variant = params[ 1 ];
        additionalspawndatastruct = spawnstruct();
        additionalspawndatastruct.var_a460646428aef1f6 = 1;
        activity_instance_common::createactivityinstance( type, variant, undefined, additionalspawndatastruct );
    }

    // Namespace activity_nexus_debug
    // Params 1, eflags: 0x4
    // Checksum 0x948f15ee, Offset: 0x9f9
    // Size: 0x79, Type: dev
    function private function_419188e666e9ee5c( params )
    {
        type = params[ 0 ];
        conditions = conditional_container::function_c60cc45fbd15f1c1();
        conditional_container::addcondition( conditions, &function_65fb1702378337e1, type );
        activityinstance = function_bf7eb8830a24d0da( undefined, conditions );
        
        if ( activityinstance )
        {
            function_654efc1380781476() setorigin( activity_instance_common::function_776ee11e7acc64a5( activityinstance ) );
            return;
        }
        
        iprintlnbold( "<dev string:xaa3>" + type );
    }

    // Namespace activity_nexus_debug
    // Params 2
    // Checksum 0x526160, Offset: 0xa7a
    // Size: 0x36, Type: dev
    function function_65fb1702378337e1( activity_instance, type )
    {
        return activity_instance_common::getactivitytype( activity_instance ) == type && activity_instance_common::getactivitystate( activity_instance ) == "<dev string:xac6>";
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x84a95531, Offset: 0xab8
    // Size: 0x1a, Type: dev
    function private function_e2a6b80c3f3aa974()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xacd>", @"hash_a00113a9b1ef6889" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xec910c96, Offset: 0xada
    // Size: 0x1a, Type: dev
    function private function_7543fd893e36758e()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xae4>", @"hash_7dcd46145689db67" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x6390e693, Offset: 0xafc
    // Size: 0x1a, Type: dev
    function private function_635323876131e2e0()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xafe>", @"hash_b237a1ac303ee55a" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x2f342d18, Offset: 0xb1e
    // Size: 0x1a, Type: dev
    function private function_c44b12ec086d432d()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xb1a>", @"hash_48eb96c92bbb2a7f" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xb8528115, Offset: 0xb40
    // Size: 0x1a, Type: dev
    function private function_d176c140ffeaa458()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xb39>", @"hash_eed6299c07f902c9" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xef9fd2ae, Offset: 0xb62
    // Size: 0x1a, Type: dev
    function private function_40d0d60749cec4d()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xb59>", @"hash_fcafa83bbaff533" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x9102da0, Offset: 0xb84
    // Size: 0x1a, Type: dev
    function private function_86917a22cd4060db()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xb7b>", @"hash_9102480cbcc5c577" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x963c1d0f, Offset: 0xba6
    // Size: 0x1a, Type: dev
    function private function_35f054aa05fa605e()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xb97>", @"hash_a669088f2f58cc1b" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x2821d35c, Offset: 0xbc8
    // Size: 0x1a, Type: dev
    function private function_7bae501e24e7329a()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xbb0>", @"hash_6bb7a21834ec1a50" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xfc77b4b1, Offset: 0xbea
    // Size: 0x1a, Type: dev
    function private function_9c546cdbf8fb9489()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xbd3>", @"hash_c7e9b1c5bebfd07a" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x2bb1230f, Offset: 0xc0c
    // Size: 0x1a, Type: dev
    function private function_c7ede2082c7d5f49()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xbf1>", @"hash_1ad4082edc7d24da" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x73506bc, Offset: 0xc2e
    // Size: 0x1a, Type: dev
    function private function_8f446fc622b352e0()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xc0c>", @"hash_f62328cf574cda8c" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xc55b687a, Offset: 0xc50
    // Size: 0x1a, Type: dev
    function private function_78e111ef05563b81()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xc29>", @"hash_d03d5702956b8642" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xf4a763ca, Offset: 0xc72
    // Size: 0x3d, Type: dev
    function private function_143db9187f353bb3()
    {
        function_635323876131e2e0();
        function_d176c140ffeaa458();
        function_40d0d60749cec4d();
        function_86917a22cd4060db();
        function_9c546cdbf8fb9489();
        function_e2a6b80c3f3aa974();
        function_7543fd893e36758e();
        function_78e111ef05563b81();
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xaf949110, Offset: 0xcb7
    // Size: 0x1a, Type: dev
    function private function_4253353a3c05fa52()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xc43>", @"hash_22e4e38cab273e93" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x6d7959c9, Offset: 0xcd9
    // Size: 0x1a, Type: dev
    function private function_137519f5cbb97015()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xc5d>", @"hash_f972c083ecfc0669" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x89353d88, Offset: 0xcfb
    // Size: 0x1a, Type: dev
    function private function_f007c02f66f95f21()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xc7f>", @"hash_c6dd0e44e8224971" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x21aeb31e, Offset: 0xd1d
    // Size: 0x1a, Type: dev
    function private function_a09b53dad2531b54()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xca2>", @"hash_39bc09a8c55a7875" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x8b8ac4f2, Offset: 0xd3f
    // Size: 0x1a, Type: dev
    function private function_bf7049a7c9d21ff4()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xcc1>", @"hash_ee2680c4a8804012" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xfc4c969b, Offset: 0xd61
    // Size: 0x1a, Type: dev
    function private function_9ded647c7e840d13()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xce3>", @"hash_3b38e79d9ffe7e9f" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xff5e5d5b, Offset: 0xd83
    // Size: 0x1a, Type: dev
    function private function_56dc99f612035ffe()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xd08>", @"hash_26b7e4a2ecc0df79" );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x1b0d15b9, Offset: 0xda5
    // Size: 0x165, Type: dev
    function private function_af57940330b93c03()
    {
        proximitywarningthreshold = getdvarint( @"hash_b5da5bc16db49d93", 1000 );
        sqradius = proximitywarningthreshold * proximitywarningthreshold;
        var_149d6487219bd2f = utility::getstructarray( "<dev string:xd24>", "<dev string:xd43>" );
        warningsfoundstruct = spawnstruct();
        warningsfoundstruct.table = [];
        namespace_634561435cfb3169::activitynexuslog( "<dev string:xd4e>", 2 );
        
        foreach ( var_e6a3bb3a54c73566 in var_149d6487219bd2f )
        {
            function_6a5fc303c445617e( var_e6a3bb3a54c73566, warningsfoundstruct );
        }
        
        var_fe2112dd97f64f0f = [];
        namespace_634561435cfb3169::activitynexuslog( "<dev string:xd83>", 2 );
        
        foreach ( var_e6a3bb3a54c73566 in var_149d6487219bd2f )
        {
            function_84f7444477be51bd( var_e6a3bb3a54c73566, warningsfoundstruct );
        }
    }

    // Namespace activity_nexus_debug
    // Params 2, eflags: 0x4
    // Checksum 0x61b6e5f9, Offset: 0xf12
    // Size: 0x188, Type: dev
    function private function_6a5fc303c445617e( var_efbda752ef48e38e, warningsfoundstruct )
    {
        proximitywarningthreshold = getdvarint( @"hash_b5da5bc16db49d93", 1000 );
        sqradius = proximitywarningthreshold * proximitywarningthreshold;
        var_149d6487219bd2f = utility::getstructarray( "<dev string:xd24>", "<dev string:xd43>" );
        varianttag_a = var_efbda752ef48e38e.script_noteworthy;
        
        foreach ( var_efbda652ef48e15b in var_149d6487219bd2f )
        {
            varianttag_b = var_efbda652ef48e15b.script_noteworthy;
            
            if ( varianttag_a == varianttag_b || function_5739fd72c8c426c2( warningsfoundstruct, varianttag_a, varianttag_b ) )
            {
                continue;
            }
            
            var_b44393d3931049aa = distancesquared( var_efbda752ef48e38e.origin, var_efbda652ef48e15b.origin );
            
            if ( var_b44393d3931049aa < sqradius )
            {
                var_6f971871fb9cded6 = distance( var_efbda752ef48e38e.origin, var_efbda652ef48e15b.origin );
                namespace_634561435cfb3169::activitynexuslog( "<dev string:xdc8>" + varianttag_a + "<dev string:xde2>" + varianttag_b + "<dev string:xe08>" + var_6f971871fb9cded6 + "<dev string:xe0d>", 2 );
                function_66a6f3f66bc841a6( warningsfoundstruct, varianttag_a, varianttag_b );
            }
        }
    }

    // Namespace activity_nexus_debug
    // Params 2, eflags: 0x4
    // Checksum 0x38b12245, Offset: 0x10a2
    // Size: 0x1a7, Type: dev
    function private function_84f7444477be51bd( var_e6a3bb3a54c73566, warningsfoundstruct )
    {
        proximitywarningthreshold = getdvarint( @"hash_b5da5bc16db49d93", 1000 );
        sqradius = proximitywarningthreshold * proximitywarningthreshold;
        joinervarianttag = var_e6a3bb3a54c73566.script_noteworthy;
        
        foreach ( varianttag, activitydefinition in level.activities.definitions )
        {
            if ( varianttag != joinervarianttag && spatial_zone_container::function_3819f09eefb741e2( activitydefinition, "<dev string:xe15>" ) && !function_5739fd72c8c426c2( warningsfoundstruct, joinervarianttag, varianttag ) )
            {
                var_572e323233214bf9 = spatial_zone_container::function_f7fc3e6c249a8256( activitydefinition, "<dev string:xe15>" );
                
                if ( var_572e323233214bf9.size == 1 )
                {
                    var_2bc891f41aa6cc2b = var_572e323233214bf9[ 0 ];
                    centeroriginpoint = activitydefinition spatial_zone_container::function_2676e037929f0833( var_2bc891f41aa6cc2b );
                    var_788781717a8400 = distancesquared( var_e6a3bb3a54c73566.origin, centeroriginpoint );
                    
                    if ( var_788781717a8400 < sqradius )
                    {
                        var_a30b1f0dc72d9b14 = distance( var_e6a3bb3a54c73566.origin, centeroriginpoint );
                        namespace_634561435cfb3169::activitynexuslog( "<dev string:xdc8>" + joinervarianttag + "<dev string:xe29>" + varianttag + "<dev string:xe08>" + var_a30b1f0dc72d9b14 + "<dev string:xe0d>", 2 );
                        function_66a6f3f66bc841a6( warningsfoundstruct, joinervarianttag, varianttag );
                    }
                }
            }
        }
    }

    // Namespace activity_nexus_debug
    // Params 3, eflags: 0x4
    // Checksum 0xbfc29556, Offset: 0x1251
    // Size: 0x55, Type: dev
    function private function_66a6f3f66bc841a6( warningsfoundstruct, varianttag_a, varianttag_b )
    {
        if ( !isdefined( warningsfoundstruct.table[ varianttag_a ] ) )
        {
            warningsfoundstruct.table[ varianttag_a ] = [];
        }
        
        warningsfoundstruct.table[ varianttag_a ][ varianttag_b ] = 1;
    }

    // Namespace activity_nexus_debug
    // Params 3, eflags: 0x4
    // Checksum 0xfadb84d2, Offset: 0x12ae
    // Size: 0x75, Type: dev
    function private function_5739fd72c8c426c2( warningsfoundstruct, varianttag_a, varianttag_b )
    {
        if ( isdefined( warningsfoundstruct.table[ varianttag_a ] ) && warningsfoundstruct.table[ varianttag_a ][ varianttag_b ] )
        {
            return 1;
        }
        
        if ( isdefined( warningsfoundstruct.table[ varianttag_b ] ) && warningsfoundstruct.table[ varianttag_b ][ varianttag_a ] )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x7b109c94, Offset: 0x132b
    // Size: 0x2f, Type: dev
    function private function_8f63787000cc2a03()
    {
        function_4253353a3c05fa52();
        function_a09b53dad2531b54();
        function_f007c02f66f95f21();
        function_bf7049a7c9d21ff4();
        function_9ded647c7e840d13();
        function_56dc99f612035ffe();
    }

    // Namespace activity_nexus_debug
    // Params 4, eflags: 0x4
    // Checksum 0x32ec9bd8, Offset: 0x1362
    // Size: 0x2ba, Type: dev
    function private function_1a5c6b159f3f63ea( spatialzone, name, color, drawframeduration )
    {
        instance = self;
        varianttag = instance.varianttag;
        zonespheres = spatial_zone_container::function_f7fc3e6c249a8256( instance, spatialzone );
        
        foreach ( zonesphere in zonespheres )
        {
            center = spatial_zone_container::function_2676e037929f0833( zonesphere );
            radius = spatial_zone_container::function_231d9e91d8ef7b5f( zonesphere );
            drawcylinder = istrue( zonesphere.shouldignoreheight );
            
            if ( drawcylinder )
            {
                print3d( center + ( 0, 0, 1000 ), name + varianttag + "<dev string:xe61>", ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
                cylinder( center + ( 0, 0, -1000 ), center + ( 0, 0, 1000 ), radius, color, 0, drawframeduration );
                continue;
            }
            
            print3d( center + ( 0, 0, radius ), name + varianttag + "<dev string:xe79>", ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
            sphere( center, radius, color, 0, drawframeduration );
        }
        
        foreach ( noenttrigger in self.noenttriggers ?? [] )
        {
            resultcolor = color;
            
            if ( noenttrigger.exittrigger )
            {
                resultcolor = ( color[ 0 ] * 0.75, color[ 1 ] * 0.75, color[ 2 ] * 0.75 );
            }
            
            print3d( noenttrigger.origin, name + varianttag + "<dev string:xe79>", ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
            drawtrigger( noenttrigger, resultcolor, 0, drawframeduration );
        }
        
        if ( !isdefined( level.var_447f2b3387ea8129 ) )
        {
            level.var_447f2b3387ea8129 = 0;
        }
        
        level.var_447f2b3387ea8129 += self.noenttriggers.size ?? 0;
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xac45009b, Offset: 0x1624
    // Size: 0xa2f, Type: dev
    function private function_1772d11ad9fafc51()
    {
        drawframeduration = 50;
        var_e8161a2bfd98dea4 = [];
        
        while ( true )
        {
            if ( getdvarint( @"hash_f62328cf574cda8c", 0 ) == 1 )
            {
                level.var_447f2b3387ea8129 = 0;
                
                foreach ( instance in level.activities.instances )
                {
                    varianttag = instance.varianttag;
                    center = activity_instance_common::function_776ee11e7acc64a5( instance );
                    type_filter = getdvar( @"hash_4c77efcbf690866c", "<dev string:xa53>" );
                    variant_filter = getdvar( @"hash_ce575194bb9bfa81", "<dev string:xa53>" );
                    
                    if ( variant_filter != "<dev string:xa53>" && varianttag != variant_filter )
                    {
                        continue;
                    }
                    
                    if ( type_filter != "<dev string:xa53>" && activity_instance_common::getactivitytype( instance ) != type_filter )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( var_e8161a2bfd98dea4[ varianttag ] ) )
                    {
                        var_e8161a2bfd98dea4[ varianttag ] = spawnstruct();
                        var_e8161a2bfd98dea4[ varianttag ].var_fbc65214be7c46ca = activity_definition_utils::function_b6096963d0181099( instance );
                        var_e8161a2bfd98dea4[ varianttag ].var_c406b938d594e916 = activity_definition_utils::function_6c3cc9191c5b0d36( instance );
                    }
                    
                    if ( getdvarint( @"hash_9102480cbcc5c577", 0 ) == 1 )
                    {
                        spatialzonenames = spatial_zone_container::function_db3efdf4ec087c3f( instance );
                        
                        foreach ( spatialzonename in spatialzonenames )
                        {
                            iscustomzone = spatialzonename != "<dev string:xe7b>" && spatialzonename != "<dev string:xe8a>" && spatialzonename != "<dev string:xe9e>" && spatialzonename != "<dev string:xeb8>" && spatialzonename != "<dev string:xec9>";
                            
                            if ( iscustomzone )
                            {
                                instance function_1a5c6b159f3f63ea( spatialzonename, "<dev string:xee0>" + spatialzonename + "<dev string:xef6>", ( 0, 0, 0 ), drawframeduration );
                            }
                        }
                    }
                    
                    if ( getdvarint( @"hash_eed6299c07f902c9", 0 ) == 1 && spatial_zone_container::function_3819f09eefb741e2( instance, "<dev string:xe7b>" ) )
                    {
                        instance function_1a5c6b159f3f63ea( "<dev string:xe7b>", "<dev string:xef9>", ( 1, 0.4, 0 ), drawframeduration );
                    }
                    
                    var_1bea20177c7358cc = activity_participation::function_e7fc1202ac164928( instance, level.players[ 0 ] );
                    
                    if ( getdvarint( @"hash_b237a1ac303ee55a", 0 ) == 1 && spatial_zone_container::function_3819f09eefb741e2( instance, "<dev string:xe8a>" ) )
                    {
                        color = var_1bea20177c7358cc ? ( 0.4, 0.85, 1 ) : ( 0, 0.4, 1 );
                        instance function_1a5c6b159f3f63ea( "<dev string:xe8a>", "<dev string:xf13>", color, drawframeduration );
                    }
                    
                    if ( getdvarint( @"hash_48eb96c92bbb2a7f", 0 ) == 1 && spatial_zone_container::function_3819f09eefb741e2( instance, "<dev string:xec9>" ) )
                    {
                        color = var_1bea20177c7358cc ? ( 1, 0.9, 0.4 ) : ( 1, 0.7, 0 );
                        instance function_1a5c6b159f3f63ea( "<dev string:xec9>", "<dev string:xf32>", color, drawframeduration );
                    }
                    
                    if ( getdvarint( @"hash_fcafa83bbaff533", 0 ) == 1 && spatial_zone_container::function_3819f09eefb741e2( instance, "<dev string:xe9e>" ) )
                    {
                        if ( var_e8161a2bfd98dea4[ varianttag ].var_fbc65214be7c46ca )
                        {
                            instance function_1a5c6b159f3f63ea( "<dev string:xe9e>", "<dev string:xf54>", ( 0.4, 1, 0 ), drawframeduration );
                        }
                        else
                        {
                            print3d( center + ( 0, 0, 250 ), "<dev string:xf70>" + varianttag + "<dev string:xe79>", ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
                        }
                    }
                    
                    if ( getdvarint( @"hash_a669088f2f58cc1b", 0 ) == 1 && spatial_zone_container::function_3819f09eefb741e2( instance, "<dev string:xeb8>" ) )
                    {
                        if ( istrue( instance.var_2c769a213204c445.var_403dace0b683ab5a ) )
                        {
                            instance function_1a5c6b159f3f63ea( "<dev string:xeb8>", "<dev string:xf9a>", ( 0.8, 0.4, 0.8 ), drawframeduration );
                        }
                        else
                        {
                            instance function_1a5c6b159f3f63ea( "<dev string:xeb8>", "<dev string:xf9a>", ( 1, 1, 1 ), drawframeduration );
                        }
                    }
                    
                    if ( getdvarint( @"hash_1ad4082edc7d24da", 0 ) == 1 && spatial_zone_container::function_3819f09eefb741e2( instance, "<dev string:xeb8>" ) )
                    {
                        if ( instance.var_edcfe5dcdc005aaf )
                        {
                            print3d( center + ( 0, 0, 1000 ), "<dev string:xfad>" + varianttag + "<dev string:xe79>", ( 1, 0, 0 ), 1, 2, drawframeduration, 1 );
                            sphere( center, 1000, ( 1, 0, 0 ), 0, drawframeduration );
                        }
                        else
                        {
                            print3d( center + ( 0, 0, 1000 ), "<dev string:xfbb>" + varianttag + "<dev string:xe79>", ( 0, 1, 0 ), 1, 2, drawframeduration, 1 );
                            sphere( center, 1000, ( 0, 1, 0 ), 0, drawframeduration );
                        }
                    }
                    
                    if ( getdvarint( @"hash_6bb7a21834ec1a50", 0 ) == 1 )
                    {
                        print3d( center + ( 0, 0, 300 ), "<dev string:xfc3>" + instance.type + "<dev string:xfca>" + varianttag + "<dev string:xfd5>" + instance.id, ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
                        
                        if ( isstring( instance.var_9d7bc02bbcf5ef6f ) )
                        {
                            print3d( center + ( 0, 0, 250 ), "<dev string:xfdb>" + instance.state + "<dev string:xfeb>" + instance.var_9d7bc02bbcf5ef6f, ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
                        }
                        else
                        {
                            print3d( center + ( 0, 0, 250 ), "<dev string:xfdb>" + instance.state, ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
                        }
                        
                        print3d( center + ( 0, 0, 200 ), "<dev string:x100e>" + instance.playerparticipants.size, ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
                    }
                    
                    if ( getdvarint( @"hash_c7e9b1c5bebfd07a", 0 ) == 1 )
                    {
                        print3d( center + ( 0, 0, 25 ), "<dev string:x1028>" + varianttag + "<dev string:xe79>", ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
                        sphere( center, 50, ( 0.5, 0, 0.5 ), 0, drawframeduration );
                    }
                    
                    if ( getdvarint( @"hash_a00113a9b1ef6889", 0 ) == 1 && instance.state == "<dev string:x1037>" )
                    {
                        if ( var_e8161a2bfd98dea4[ varianttag ].var_c406b938d594e916 )
                        {
                            activityjoininteracts = level.activities.var_3a2ba6751c464ab7[ instance.id ] ?? [];
                            
                            foreach ( joininteract in activityjoininteracts )
                            {
                                print3d( joininteract.origin + ( 0, 0, 150 ), "<dev string:x103c>" + varianttag + "<dev string:xe79>", ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
                                cylinder( joininteract.origin, joininteract.origin + ( 0, 0, 150 ), 20, ( 0.25, 0.5, 0.37 ), 0, drawframeduration );
                            }
                        }
                    }
                    
                    if ( getdvarint( @"hash_7dcd46145689db67", 0 ) == 1 )
                    {
                        rewardstructs = activity_rewards::function_4695b849b6007a6d( instance );
                        
                        foreach ( rewardstruct in rewardstructs )
                        {
                            if ( isdefined( rewardstruct.origin ) && isdefined( rewardstruct.angles ) )
                            {
                                print3d( rewardstruct.origin + ( 0, 0, 25 ), "<dev string:x1055>" + varianttag + "<dev string:xe79>", ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
                                orientedbox( rewardstruct.origin, ( 50, 50, 50 ), rewardstruct.angles, ( 0.15, 0.8, 0.42 ), 0, drawframeduration );
                            }
                        }
                    }
                }
                
                if ( getdvarint( @"hash_d03d5702956b8642", 0 ) == 1 )
                {
                    posx = 100;
                    posy = 100;
                    
                    if ( level.var_447f2b3387ea8129 )
                    {
                        printtoscreen2d( posx, posy, "<dev string:x1071>" + level.var_447f2b3387ea8129, undefined, undefined, drawframeduration );
                        posx += 20;
                    }
                }
            }
            
            for ( count = 0; count <= drawframeduration ; count++ )
            {
                waitframe();
            }
        }
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x498dd9b0, Offset: 0x205b
    // Size: 0xe, Type: dev
    function private function_6a1bc96b5263090d()
    {
        function_e243b1861abc669a( 1 );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xc07d0b7c, Offset: 0x2071
    // Size: 0xd, Type: dev
    function private function_a16148172b9183a()
    {
        function_e243b1861abc669a( 0 );
    }

    // Namespace activity_nexus_debug
    // Params 1, eflags: 0x4
    // Checksum 0x95ee6dbe, Offset: 0x2086
    // Size: 0x31, Type: dev
    function private function_e243b1861abc669a( success )
    {
        instance = function_bf7eb8830a24d0da();
        
        if ( isdefined( instance ) )
        {
            activity_instance_common::endactivity( instance, success );
        }
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x37dc3500, Offset: 0x20bf
    // Size: 0x26, Type: dev
    function private function_5bc8631464cc2ea8()
    {
        instance = function_bf7eb8830a24d0da();
        
        if ( isdefined( instance ) )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( instance );
        }
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x1a6160f, Offset: 0x20ed
    // Size: 0x26, Type: dev
    function private function_ff69add1918b0b29()
    {
        instance = function_bf7eb8830a24d0da();
        
        if ( isdefined( instance ) )
        {
            activity_instance_common::function_852865f5a195559f( instance );
        }
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x43ea614a, Offset: 0x211b
    // Size: 0xe, Type: dev
    function private function_bfd33a043e737180()
    {
        function_af426b51b6cbae55( 1 );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x443b4260, Offset: 0x2131
    // Size: 0xe, Type: dev
    function private function_b551d82df1a209d0()
    {
        function_af426b51b6cbae55( -1 );
    }

    // Namespace activity_nexus_debug
    // Params 1, eflags: 0x4
    // Checksum 0xca50742b, Offset: 0x2147
    // Size: 0x31, Type: dev
    function private function_af426b51b6cbae55( offsetamount )
    {
        instance = function_bf7eb8830a24d0da();
        
        if ( isdefined( instance ) )
        {
            activity_instance_common::function_fe41d48bb636bd33( instance, offsetamount );
        }
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x3b4a69a0, Offset: 0x2180
    // Size: 0x2b, Type: dev
    function private function_654efc1380781476()
    {
        if ( isdefined( level.players ) )
        {
            return level.players[ 0 ];
        }
        
        return level.player;
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x535d24e6, Offset: 0x21b3
    // Size: 0x31, Type: dev
    function private function_c8b5b571c00b533d()
    {
        instance = function_bf7eb8830a24d0da();
        hostplayer = function_654efc1380781476();
        activity_participation::function_bc67362dace4370c( instance, hostplayer );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x9e504af, Offset: 0x21ec
    // Size: 0x31, Type: dev
    function private function_b709afb2f824a694()
    {
        instance = function_bf7eb8830a24d0da();
        hostplayer = function_654efc1380781476();
        activity_participation::function_61aa2b2879f2c0a2( instance, hostplayer );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xd99aad1d, Offset: 0x2225
    // Size: 0x33, Type: dev
    function private function_5d615f465720a8ee()
    {
        instance = function_bf7eb8830a24d0da();
        hostplayer = function_654efc1380781476();
        activity_participation::function_61aa2b2879f2c0a2( instance, hostplayer, 1 );
    }

    // Namespace activity_nexus_debug
    // Params 2, eflags: 0x4
    // Checksum 0xe9acecb9, Offset: 0x2260
    // Size: 0x63, Type: dev
    function private function_bf7eb8830a24d0da( var_5c55d558c26c1cca, conditionalcontainer )
    {
        hostplayer = function_654efc1380781476();
        closestinstance = undefined;
        
        if ( isplayer( hostplayer ) )
        {
            instance = activity_common::function_3eba33db536a1da6( hostplayer.origin, var_5c55d558c26c1cca, conditionalcontainer );
            closestinstance = instance;
        }
        
        return closestinstance;
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xbb3f5000, Offset: 0x22cb
    // Size: 0xe, Type: dev
    function private function_bb01fe791b3037cb()
    {
        function_bf90436c4a017a18( 1 );
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x6445fab1, Offset: 0x22e1
    // Size: 0xd, Type: dev
    function private function_f937515f9b8631bc()
    {
        function_bf90436c4a017a18( 0 );
    }

    // Namespace activity_nexus_debug
    // Params 1, eflags: 0x4
    // Checksum 0x74d171df, Offset: 0x22f6
    // Size: 0x31, Type: dev
    function private function_bf90436c4a017a18( success )
    {
        instance = function_3eafeb4d8c6cdefc();
        
        if ( isdefined( instance ) )
        {
            activity_instance_common::endactivity( instance, success );
        }
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x84de2c9a, Offset: 0x232f
    // Size: 0x26, Type: dev
    function private function_8356c8a661f01b86()
    {
        instance = function_3eafeb4d8c6cdefc();
        
        if ( isdefined( instance ) )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( instance );
        }
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xb2a40f95, Offset: 0x235d
    // Size: 0x26, Type: dev
    function private function_429accbb1d130f8f()
    {
        instance = function_3eafeb4d8c6cdefc();
        
        if ( isdefined( instance ) )
        {
            activity_instance_common::function_852865f5a195559f( instance );
        }
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0xf8d7acdd, Offset: 0x238b
    // Size: 0x37, Type: dev
    function private function_e342bd0a0eadcffa()
    {
        instance = function_3eafeb4d8c6cdefc();
        
        if ( isdefined( instance ) )
        {
            hostplayer = function_654efc1380781476();
            activity_participation::function_61aa2b2879f2c0a2( instance, hostplayer );
        }
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x28a8056f, Offset: 0x23ca
    // Size: 0x39, Type: dev
    function private function_9a18ec3941b21f6c()
    {
        instance = function_3eafeb4d8c6cdefc();
        
        if ( isdefined( instance ) )
        {
            hostplayer = function_654efc1380781476();
            activity_participation::function_61aa2b2879f2c0a2( instance, hostplayer, 1 );
        }
    }

    // Namespace activity_nexus_debug
    // Params 0, eflags: 0x4
    // Checksum 0x6a8273f3, Offset: 0x240b
    // Size: 0x7d, Type: dev
    function private function_3eafeb4d8c6cdefc()
    {
        hostplayer = function_654efc1380781476();
        
        if ( isplayer( hostplayer ) && isdefined( hostplayer.activities.focusedactivityid ) )
        {
            id = hostplayer.activities.focusedactivityid;
            instance = level.activities.instances[ id ];
            return instance;
        }
        
        return;
    }

#/
