// script_43a0f8295780db24  (hash_43a0f8295780db24.gscc) (size: 4506 Bytes / 0x119a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x75761c0c (1970674700)
// size ...... 4506 (0x119a)
// includes .. 1   (offset: 0xf7a)
// strings ... 0   (offset: 0xf82)
// dev strs .. 36  (offset: 0xf82)
// exports ... 10  (offset: 0xa42)
// cseg ...... 0x58 + 0x9ea (0xa42)
// imports ... 26  (offset: 0xbd2)
// animtree1 . 0   (offset: 0x119a)
// animtree2 . 0   (offset: 0x119a)
#using scripts\common\utility;

#namespace namespace_4d948776d7c0cf78;

/#

    // Namespace namespace_4d948776d7c0cf78
    // Params 0, eflags: 0x5
    // Checksum 0xe898a6b0, Offset: 0x76
    // Size: 0x17, Type: dev
    function private autoexec init()
    {
        level.var_e168f636001e6d48 = 0;
        level thread map_screenshots();
    }

    // Namespace namespace_4d948776d7c0cf78
    // Params 0, eflags: 0x4
    // Checksum 0x86f37cce, Offset: 0x95
    // Size: 0x8e, Type: dev
    function private map_screenshots()
    {
        level endon( #"game_ended" );
        
        while ( getdvarint( @"hash_25f0066f16d2db60", 0 ) == 0 )
        {
            wait 1;
        }
        
        if ( level.var_e168f636001e6d48 == 0 )
        {
            capturetype = getdvarint( @"hash_25f0066f16d2db60", 0 );
            
            if ( capturetype == 1 )
            {
                function_2c84df11dac4907e();
            }
            
            if ( capturetype == 2 )
            {
                function_73fddfad5dcf4043();
            }
            
            if ( capturetype == 3 )
            {
                function_6c7cebb23a70ca4c();
            }
            
            if ( capturetype == 4 )
            {
                function_e78680b1d5fc5f7f();
            }
        }
    }

    // Namespace namespace_4d948776d7c0cf78
    // Params 0, eflags: 0x4
    // Checksum 0x791e7465, Offset: 0x12b
    // Size: 0x1dd, Type: dev
    function private function_2c84df11dac4907e()
    {
        captureData = level.screenshotdata;
        screenshotorigins = [];
        screenshotangles = [];
        offset = level.var_e94c78dff814742d;
        
        if ( isdefined( captureData ) )
        {
            function_55e4856b26354fda( 1, 1 );
            
            if ( !isarray( captureData ) )
            {
                captureData = [ captureData ];
            }
            
            foreach ( capture in captureData )
            {
                substrings = strtok( capture, "<dev string:x24>" );
                captureorigin = substrings[ 0 ] + "<dev string:x24>" + substrings[ 1 ] + "<dev string:x24>" + substrings[ 2 ];
                captureangle = "<dev string:x26>" + substrings[ 3 ] + "<dev string:x24>" + substrings[ 4 ];
                
                if ( isdefined( screenshotorigins ) )
                {
                    screenshotorigins[ screenshotorigins.size ] = utility::stringtovec3( captureorigin );
                }
                else
                {
                    screenshotorigins[ 0 ] = utility::stringtovec3( captureorigin );
                }
                
                if ( isdefined( screenshotangles ) )
                {
                    screenshotangles[ screenshotangles.size ] = utility::stringtovec3( captureangle );
                    continue;
                }
                
                screenshotangles[ 0 ] = utility::stringtovec3( captureangle );
            }
            
            for ( i = 0; i < screenshotorigins.size ; i++ )
            {
                if ( isdefined( offset ) )
                {
                    screenshotorigins[ i ] += offset;
                }
                
                capturescreenshot( screenshotorigins[ i ], screenshotangles[ i ], "<dev string:x29>", i, 1, 0 );
                wait 1;
            }
            
            iprintlnbold( "<dev string:x38>" );
            wait 1;
            iprintlnbold( "<dev string:x38>" );
            function_fc97568accdd65f5();
            return;
        }
        
        iprintlnbold( "<dev string:xb1>" );
    }

    // Namespace namespace_4d948776d7c0cf78
    // Params 0, eflags: 0x4
    // Checksum 0x303e6388, Offset: 0x310
    // Size: 0x132, Type: dev
    function private function_73fddfad5dcf4043()
    {
        function_55e4856b26354fda( 1, 1 );
        wait 1;
        camera_anchors = utility::getstructarray( "<dev string:xe6>", "<dev string:xf6>" );
        
        if ( !isdefined( camera_anchors ) || camera_anchors.size == 0 )
        {
            iprintlnbold( "<dev string:x101>" );
            return;
        }
        
        foreach ( camera in camera_anchors )
        {
            if ( !isdefined( camera.script_index ) )
            {
                assertmsg( "<dev string:x150>" );
            }
        }
        
        camera_anchors = utility::array_sort_by_script_index( camera_anchors );
        
        for ( i = 0; i < camera_anchors.size ; i++ )
        {
            capturescreenshot( camera_anchors[ i ].origin, camera_anchors[ i ].angles, "<dev string:x17b>", i, 1, 0 );
            wait 1;
        }
        
        iprintlnbold( "<dev string:x38>" );
        function_fc97568accdd65f5();
    }

    // Namespace namespace_4d948776d7c0cf78
    // Params 0, eflags: 0x4
    // Checksum 0x398c29f0, Offset: 0x44a
    // Size: 0xdd, Type: dev
    function private function_6c7cebb23a70ca4c()
    {
        function_55e4856b26354fda( 1, 1 );
        wait 1;
        camera_anchors = utility::getstructarray( "<dev string:x18a>", "<dev string:xf6>" );
        
        if ( !isdefined( camera_anchors ) || camera_anchors.size == 0 )
        {
            iprintlnbold( "<dev string:x101>" );
            return;
        }
        
        x = 0;
        
        for ( i = 0; i < camera_anchors.size ; i++ )
        {
            offset = camera_anchors[ i ].origin + ( 200, 0, 400 );
            x++;
            capturescreenshot( offset, ( 90, 270, 0 ), "<dev string:x17b>", camera_anchors[ i ].script_noteworthy + "<dev string:x1a8>", 0, 1 );
            wait 1;
        }
        
        iprintlnbold( "<dev string:x38>" );
        function_fc97568accdd65f5();
    }

    // Namespace namespace_4d948776d7c0cf78
    // Params 0, eflags: 0x4
    // Checksum 0x304a3127, Offset: 0x52f
    // Size: 0x1a0, Type: dev
    function private function_e78680b1d5fc5f7f()
    {
        function_55e4856b26354fda( 1, 1 );
        wait 1;
        camera_anchors = getnoentvolumearray( "<dev string:x1b4>", #classname );
        
        if ( !isdefined( camera_anchors ) || camera_anchors.size == 0 )
        {
            iprintlnbold( "<dev string:x101>" );
            return;
        }
        
        for ( i = 0; i < camera_anchors.size ; i++ )
        {
            offset = camera_anchors[ i ].origin + ( 200, 200, 2500 );
            
            if ( isdefined( camera_anchors[ i ].script_label ) )
            {
                capturescreenshot( offset, ( 90, 270, 0 ), "<dev string:x17b>", camera_anchors[ i ].script_label, 0, 1 );
            }
            else if ( isdefined( camera_anchors[ i ].script_parameters ) )
            {
                capturescreenshot( offset, ( 90, 270, 0 ), "<dev string:x17b>", camera_anchors[ i ].script_parameters, 0, 1 );
            }
            else if ( isdefined( camera_anchors[ i ].minimap_id ) )
            {
                capturescreenshot( offset, ( 90, 270, 0 ), "<dev string:x17b>", camera_anchors[ i ].minimap_id, 0, 1 );
            }
            else if ( isdefined( camera_anchors[ i ].script_noteworthy ) )
            {
                capturescreenshot( offset, ( 90, 270, 0 ), "<dev string:x17b>", camera_anchors[ i ].script_noteworthy, 0, 1 );
            }
            
            wait 1;
        }
        
        iprintlnbold( "<dev string:x38>" );
        function_fc97568accdd65f5();
    }

    // Namespace namespace_4d948776d7c0cf78
    // Params 2, eflags: 0x4
    // Checksum 0xde9b51fc, Offset: 0x6d7
    // Size: 0xda, Type: dev
    function private function_55e4856b26354fda( var_45e9a052d0061f9c, var_55fe61cf585795b )
    {
        if ( !isdefined( var_45e9a052d0061f9c ) )
        {
            var_45e9a052d0061f9c = 1;
        }
        
        if ( !isdefined( var_55fe61cf585795b ) )
        {
            var_55fe61cf585795b = 0;
        }
        
        level.var_e168f636001e6d48 = 1;
        adddebugcommand( "<dev string:x1c9>" );
        adddebugcommand( "<dev string:x1d1>" );
        adddebugcommand( "<dev string:x1de>" );
        adddebugcommand( "<dev string:x1ec>" );
        adddebugcommand( "<dev string:x1fa>" );
        
        if ( var_45e9a052d0061f9c )
        {
            adddebugcommand( "<dev string:x1fa>" );
        }
        else
        {
            adddebugcommand( "<dev string:x20c>" );
        }
        
        if ( var_55fe61cf585795b )
        {
            adddebugcommand( "<dev string:x21e>" );
        }
        else
        {
            adddebugcommand( "<dev string:x233>" );
        }
        
        level.var_9555027279498c07 = level.players[ 0 ].origin;
        level.var_b92a7068df44a1c9 = level.players[ 0 ].angles;
    }

    // Namespace namespace_4d948776d7c0cf78
    // Params 0, eflags: 0x4
    // Checksum 0x1c14c3ae, Offset: 0x7b9
    // Size: 0xb0, Type: dev
    function private function_fc97568accdd65f5()
    {
        adddebugcommand( "<dev string:x1c9>" );
        adddebugcommand( "<dev string:x248>" );
        adddebugcommand( "<dev string:x255>" );
        adddebugcommand( "<dev string:x1fa>" );
        adddebugcommand( "<dev string:x233>" );
        level.players[ 0 ] setorigin( level.var_9555027279498c07 );
        level.players[ 0 ] setplayerangles( level.var_b92a7068df44a1c9 );
        level.var_9555027279498c07 = undefined;
        level.var_b92a7068df44a1c9 = undefined;
        setdvar( @"hash_25f0066f16d2db60", 0 );
        level.var_e168f636001e6d48 = 0;
        setdvar( @"hash_431f5fdb23ecdbf9", 1 );
        logstring( "<dev string:x263>" );
    }

    // Namespace namespace_4d948776d7c0cf78
    // Params 6, eflags: 0x4
    // Checksum 0x34802261, Offset: 0x871
    // Size: 0x1d1, Type: dev
    function private capturescreenshot( captureorigin, captureangles, var_1875e2c383e45f33, var_9fcba055ebe2fa12, var_492ee1964fc1c16b, isap )
    {
        if ( !isdefined( var_9fcba055ebe2fa12 ) )
        {
            var_9fcba055ebe2fa12 = "<dev string:x2ac>";
        }
        
        if ( !isdefined( var_492ee1964fc1c16b ) )
        {
            var_492ee1964fc1c16b = 0;
        }
        
        if ( !isdefined( isap ) )
        {
            isap = 0;
        }
        
        if ( isdefined( captureorigin ) && isdefined( captureangles ) )
        {
            iprintlnbold( "<dev string:x2ad>" + captureorigin + "<dev string:x2ba>" + captureangles );
            
            if ( isap )
            {
                level.players[ 0 ] setorigin( captureorigin );
                level.players[ 0 ] setplayerangles( captureangles );
            }
            else
            {
                command = "<dev string:x2c5>" + captureorigin + "<dev string:x24>" + captureangles + "<dev string:x2d1>";
                adddebugcommand( command );
            }
            
            wait 5;
            var_3b05a54abff3c970 = getdvar( @"hash_8a0c32af3db5a1ae" );
            
            if ( !isdefined( var_3b05a54abff3c970 ) || var_3b05a54abff3c970 == "<dev string:x2ac>" )
            {
                var_3b05a54abff3c970 = "<dev string:x2d3>" + level.mapname + "<dev string:x2e3>";
            }
            
            screenshotpath = var_3b05a54abff3c970 + "<dev string:x2f3>" + var_9fcba055ebe2fa12;
            
            if ( var_492ee1964fc1c16b )
            {
                var_22a0e29ab4d6019b = function_584b4ef0baadb1c7();
                var_1ed63394789155a = string( var_22a0e29ab4d6019b[ 0 ] ) + "<dev string:x2fc>" + string( var_22a0e29ab4d6019b[ 1 ] ) + "<dev string:x2fc>" + string( var_22a0e29ab4d6019b[ 2 ] ) + "<dev string:x2fc>" + string( var_22a0e29ab4d6019b[ 3 ] ) + "<dev string:x2fc>" + string( var_22a0e29ab4d6019b[ 4 ] ) + "<dev string:x2fc>" + string( var_22a0e29ab4d6019b[ 5 ] );
                wait 1;
                adddebugcommand( "<dev string:x2fe>" + screenshotpath + "<dev string:x30e>" + var_1ed63394789155a );
            }
            else
            {
                wait 1;
                adddebugcommand( "<dev string:x2fe>" + screenshotpath );
            }
            
            return;
        }
        
        iprintlnbold( "<dev string:x310>" );
    }

#/
