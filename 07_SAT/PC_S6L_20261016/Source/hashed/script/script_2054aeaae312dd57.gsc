// script_2054aeaae312dd57  (hash_2054aeaae312dd57.gscc) (size: 6923 Bytes / 0x1b0b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc83c8b1a (3359410970)
// size ...... 6923 (0x1b0b)
// includes .. 4   (offset: 0x19ab)
// strings ... 0   (offset: 0x19cb)
// dev strs .. 24  (offset: 0x19cb)
// exports ... 20  (offset: 0x102f)
// cseg ...... 0x58 + 0xfd7 (0x102f)
// imports ... 52  (offset: 0x134f)
// animtree1 . 0   (offset: 0x1b0b)
// animtree2 . 0   (offset: 0x1b0b)
#using script_2986aa4b0ff2bddf;
#using script_3d2770dc09c1243;
#using script_77aea2ef08e83635;
#using scripts\mp\bots\bots_gametype_super_shared;

#namespace mit_dev;

/#

    // Namespace mit_dev
    // Params 0
    // Checksum 0xcb3bdc46, Offset: 0x76
    // Size: 0x123, Type: dev
    function function_de79bb826fe1097b()
    {
        if ( !mit::function_168f26942e588420() )
        {
            return;
        }
        
        setdvar( @"hash_a9944abc2f276e96", 1 );
        setdvar( @"hash_824c718cad3c0f17", 0 );
        setdvar( @"hash_3af754b1c955b13", 1 );
        setdvar( @"ai_shownavmesh", 2 );
        setdvar( @"ai_shownavmeshsolid", 1 );
        setdvar( @"ai_showpaths", 1 );
        setdvar( @"bot_drawdebug", 5 );
        setdvar( @"bot_drawdebugstatus", 2 );
        level thread devcommandwatcher( @"hash_f97641d4915507b5", &function_fc7bfd93bbc41c7e, "<dev string:x24>", 6, 7, 3 );
        level thread devcommandwatcher( @"hash_b32ed87f6e94907d", &function_fc7bfd93bbc41c7e, "<dev string:x2e>", 6, 7, 3 );
        level thread devcommandwatcher( @"hash_5ad71dff2cbc6584", &function_fc7bfd93bbc41c7e, "<dev string:x3d>", 4, 5, 3 );
        level thread devcommandwatcher( @"hash_ab0fdb09cd6a53f9", &function_f9234fcee81a7425, "<dev string:x4a>" );
        level thread devcommandwatcher( @"drawconnectivity", &function_8e7c7c72cf79ede4 );
    }

    // Namespace mit_dev
    // Params 0
    // Checksum 0xc1e5e1f1, Offset: 0x1a1
    // Size: 0x3a, Type: dev
    function function_8e86bb7229f75af4()
    {
        return level.mit.var_72e876a187fa152d && self.clientid == level.mit.var_76f5ec9218f2306d;
    }

    // Namespace mit_dev
    // Params 0
    // Checksum 0x6ca708d1, Offset: 0x1e3
    // Size: 0x3a, Type: dev
    function function_6029df97b80478b5()
    {
        return level.mit.var_98f6fd54f07d25c4 && self.clientid == level.mit.var_76f5ec9218f2306d;
    }

    // Namespace mit_dev
    // Params 0
    // Checksum 0x28fd8adb, Offset: 0x225
    // Size: 0xb4, Type: dev
    function function_8c73559ab29ba7a9()
    {
        startpos = level.mit.var_72e876a187fa152d.startpos;
        targetpos = level.mit.var_72e876a187fa152d.targetpos;
        level.mit.var_72e876a187fa152d = undefined;
        placeobserver( startpos, startpos + ( 0, 0, 36 ) );
        failedresult = mit::botteleport( startpos, 50, 100 );
        
        if ( isdefined( failedresult ) )
        {
            assert( "<dev string:x56>" );
            return;
        }
        
        mit_roaming::testprocess( targetpos );
    }

    // Namespace mit_dev
    // Params 0
    // Checksum 0x348ccbf5, Offset: 0x2e1
    // Size: 0xbd, Type: dev
    function function_9853b5c1f82853d0()
    {
        window = level.mit.var_98f6fd54f07d25c4.window;
        testcase = level.mit.var_98f6fd54f07d25c4.testcase;
        level.mit.var_98f6fd54f07d25c4 = undefined;
        startpos = testcase.var_bf5f886705e114e6;
        observerpos = startpos - testcase.forwardvector * 40 + ( 0, 0, 20 );
        placeobserver( startpos, observerpos );
        mit_windows::testwindow( window, testcase );
    }

    // Namespace mit_dev
    // Params 7, eflags: 0x4
    // Checksum 0x5de2ff4e, Offset: 0x3a6
    // Size: 0xce, Type: dev
    function private function_fc7bfd93bbc41c7e( command, arglist, dvarname, expectedcommand, startpositionargument, targetpositionargument, var_f714238c696b184 )
    {
        if ( command != expectedcommand )
        {
            iprintln( "<dev string:x75>" + expectedcommand + "<dev string:xab>" );
            return;
        }
        
        startpos = function_7ad605827915adfd( arglist[ startpositionargument ] );
        targetpos = function_7ad605827915adfd( arglist[ targetpositionargument ] );
        errorpos = function_7ad605827915adfd( arglist[ var_f714238c696b184 ] );
        
        if ( !( isdefined( startpos ) && isdefined( targetpos ) ) )
        {
            function_6f237c945e4baa98( dvarname, expectedcommand, startpositionargument, targetpositionargument );
            return;
        }
        
        function_c2dea3bf53594c1( startpos, targetpos );
        thread function_2e0b3191c910a660( startpos, targetpos, errorpos );
    }

    // Namespace mit_dev
    // Params 2, eflags: 0x4
    // Checksum 0xeb29513c, Offset: 0x47c
    // Size: 0x4a, Type: dev
    function private function_c2dea3bf53594c1( startpos, targetpos )
    {
        level.mit.var_72e876a187fa152d = { #targetpos:targetpos, #startpos:startpos };
        function_97e56c7ee547c45c();
    }

    // Namespace mit_dev
    // Params 3, eflags: 0x4
    // Checksum 0xd73c0bc5, Offset: 0x4ce
    // Size: 0xaf, Type: dev
    function private function_8e7c7c72cf79ede4( command, arglist, dvarname )
    {
        cmdargstr = "<dev string:xd0>";
        
        for ( i = 0; i < arglist.size ; i++ )
        {
            cmdargstr += arglist[ i ] + "<dev string:xd1>";
        }
        
        pos1 = function_7ad605827915adfd( cmdargstr, 0 );
        pos2 = function_7ad605827915adfd( cmdargstr, 1 );
        
        if ( !( isdefined( pos1 ) && isdefined( pos2 ) ) )
        {
            iprintln( "<dev string:xd3>" + getxhashsourcename( dvarname ) + "<dev string:xdb>" );
            return;
        }
        
        thread function_2e0b3191c910a660( pos1, pos2 );
    }

    // Namespace mit_dev
    // Params 3, eflags: 0xc
    // Checksum 0x8fc6b97, Offset: 0x585
    // Size: 0x204, Type: dev
    function private function_2e0b3191c910a660( startpos, endpos, errorpos )
    {
        self notify( #"hash_1c3812bfc02b91fc" );
        self endon( #"hash_1c3812bfc02b91fc" );
        pathpositions = level.players[ 0 ] findpath( startpos, endpos );
        
        if ( !pathpositions.size )
        {
            printtoscreen2d( 700, 150, "<dev string:xf5>", ( 1, 0, 0 ), 3, 100 );
        }
        else if ( distance2dsquared( pathpositions[ pathpositions.size - 1 ], endpos ) > 2 )
        {
            printtoscreen2d( 700, 150, "<dev string:x103>", ( 1, 0, 0 ), 3, 100 );
        }
        
        while ( true )
        {
            sphere( startpos, 13.5, ( 1, 0, 1 ), 0, level.var_59de0a10a714e6b0 );
            sphere( endpos, 8, ( 0, 0, 1 ), 0, level.var_59de0a10a714e6b0 );
            
            if ( isdefined( errorpos ) )
            {
                sphere( errorpos, 8, ( 1, 0, 0 ), 0, level.var_59de0a10a714e6b0 );
            }
            
            if ( pathpositions.size )
            {
                foreach ( point in pathpositions )
                {
                    sphere( point, 4, ( 0, 1, 0 ), 0, level.var_59de0a10a714e6b0 );
                }
                
                for ( i = 0; i < pathpositions.size - 1 ; i++ )
                {
                    line( pathpositions[ i ], pathpositions[ i + 1 ], ( 1, 0.5, 0 ), 1, 0, level.var_59de0a10a714e6b0 );
                }
            }
            
            wait level.var_f63fbf49aed40e23;
        }
    }

    // Namespace mit_dev
    // Params 4, eflags: 0x4
    // Checksum 0xb5057b29, Offset: 0x791
    // Size: 0xd8, Type: dev
    function private function_f9234fcee81a7425( command, arglist, dvarname, expectedcommand )
    {
        if ( command != expectedcommand )
        {
            iprintln( "<dev string:x75>" + expectedcommand + "<dev string:xab>" );
            return;
        }
        
        startpos = function_7ad605827915adfd( arglist[ 6 ] );
        targetpos = function_7ad605827915adfd( arglist[ 7 ] );
        errorpos = function_7ad605827915adfd( arglist[ 5 ] );
        windowpos = function_7ad605827915adfd( arglist[ 4 ] );
        
        if ( !( isdefined( startpos ) && isdefined( targetpos ) && isdefined( errorpos ) && isdefined( windowpos ) ) )
        {
            function_6f237c945e4baa98( dvarname, expectedcommand, 6, 7, 5, 4 );
            return;
        }
        
        function_3426b3d208c606e6( windowpos, startpos );
        thread function_d5b406e3e08cea29( startpos, targetpos, errorpos );
    }

    // Namespace mit_dev
    // Params 2, eflags: 0x4
    // Checksum 0xa0ad91be, Offset: 0x871
    // Size: 0x1d6, Type: dev
    function private function_3426b3d208c606e6( windowpos, startpos )
    {
        const_max_dist_sq = squared( 10 );
        targetwindow = undefined;
        
        foreach ( window in level.mit.window.windows )
        {
            if ( distancesquared( window.var_19ee8de22b08132e, windowpos ) < const_max_dist_sq )
            {
                targetwindow = window;
                break;
            }
        }
        
        if ( !isdefined( targetwindow ) )
        {
            return;
        }
        
        var_3272f9ed96f6f3c7 = undefined;
        mindistsq = undefined;
        testcases = targetwindow.testcases;
        
        foreach ( testcase in testcases )
        {
            distsq = distance2dsquared( testcase.var_bf5f886705e114e6, startpos );
            
            if ( !isdefined( mindistsq ) || distsq < mindistsq )
            {
                var_3272f9ed96f6f3c7 = testcase;
                mindistsq = distsq;
            }
        }
        
        level.mit.var_98f6fd54f07d25c4 = { #testcase:var_3272f9ed96f6f3c7, #window:targetwindow };
        function_97e56c7ee547c45c();
    }

    // Namespace mit_dev
    // Params 3, eflags: 0xc
    // Checksum 0x121584a9, Offset: 0xa4f
    // Size: 0xab, Type: dev
    function private function_d5b406e3e08cea29( startpos, endpos, errorpos )
    {
        self notify( #"hash_1f0b3b0da32e351e" );
        self endon( #"hash_1f0b3b0da32e351e" );
        
        while ( true )
        {
            sphere( startpos, 8, ( 1, 0, 1 ), 0, level.var_59de0a10a714e6b0 );
            sphere( endpos, 8, ( 0, 0, 1 ), 0, level.var_59de0a10a714e6b0 );
            sphere( errorpos, 8, ( 1, 0, 0 ), 0, level.var_59de0a10a714e6b0 );
            wait level.var_f63fbf49aed40e23;
        }
    }

    // Namespace mit_dev
    // Params 0, eflags: 0x4
    // Checksum 0x75f84626, Offset: 0xb02
    // Size: 0x19a, Type: dev
    function private function_97e56c7ee547c45c()
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isdefined( level.mit.var_76f5ec9218f2306d ) )
            {
                if ( level.mit.var_76f5ec9218f2306d == player.clientid )
                {
                    player notify( #"hash_aef39e4f069d3cee" );
                    break;
                }
                
                continue;
            }
            
            if ( isbot( player ) )
            {
                level.mit.var_76f5ec9218f2306d = player.clientid;
                player notify( #"hash_aef39e4f069d3cee" );
                break;
            }
        }
        
        if ( !isdefined( level.mit.var_76f5ec9218f2306d ) )
        {
            botinfo = { #name:"<dev string:xd0>" };
            botconnected = level namespace_ef4547f85724edd1::spawnbots( [ botinfo ], "<dev string:x116>", undefined, undefined, "<dev string:x121>" );
            
            if ( isarray( botconnected ) && isdefined( botconnected[ 0 ] ) )
            {
                level.mit.var_76f5ec9218f2306d = botconnected[ 0 ].clientid;
                return;
            }
            
            assert( "<dev string:x12e>" );
        }
    }

    // Namespace mit_dev
    // Params 2, eflags: 0x4
    // Checksum 0xb102486, Offset: 0xca4
    // Size: 0x64, Type: dev
    function private placeobserver( startpos, observerpos )
    {
        defaultplayer = level.players[ 0 ];
        defaultplayer dontinterpolate();
        
        if ( !defaultplayer isnoclip() )
        {
            defaultplayer noclip();
        }
        
        defaultplayer setorigin( observerpos );
        defaultplayer setplayerangles( vectortoangles( startpos - observerpos ) );
        wait 0.5;
    }

    // Namespace mit_dev
    // Params 4, eflags: 0x44 variadic
    // Checksum 0xbfdf68f8, Offset: 0xd10
    // Size: 0xb7, Type: dev
    function private devcommandwatcher( dvarname, commandhandlerfunc, ... )
    {
        setdevdvar( dvarname, "<dev string:xd0>" );
        
        while ( true )
        {
            waitframe();
            dvarvalue = getdvar( dvarname );
            
            if ( dvarvalue == "<dev string:xd0>" )
            {
                continue;
            }
            
            setdevdvar( dvarname, "<dev string:xd0>" );
            tokens = strtok( dvarvalue, "<dev string:x153>", 1 );
            
            if ( !tokens.size )
            {
                continue;
            }
            
            command = tokens[ 0 ];
            arglist = arrayremove( tokens, command );
            [[ commandhandlerfunc ]]( command, arglist, dvarname, flat_args( vararg, varargcount ) );
        }
    }

    // Namespace mit_dev
    // Params 1, eflags: 0x4
    // Checksum 0x5724b986, Offset: 0xdcf
    // Size: 0x49, Type: dev
    function private strtovec3( str )
    {
        values = strtok( str, "<dev string:x155>" );
        
        if ( values.size == 3 )
        {
            return ( float( values[ 0 ] ), float( values[ 1 ] ), float( values[ 2 ] ) );
        }
        
        return;
    }

    // Namespace mit_dev
    // Params 3, eflags: 0x4
    // Checksum 0x4d9839c2, Offset: 0xe20
    // Size: 0x4d, Type: dev
    function private function_d09b96e8d365585( str, chr, startindex )
    {
        for ( i = startindex; i < str.size ; i++ )
        {
            if ( str[ i ] == chr )
            {
                return i;
            }
        }
        
        return -1;
    }

    // Namespace mit_dev
    // Params 2, eflags: 0x4
    // Checksum 0x8453606c, Offset: 0xe75
    // Size: 0xab, Type: dev
    function private function_7ad605827915adfd( str, index )
    {
        if ( !isdefined( index ) )
        {
            index = 0;
        }
        
        assert( index >= 0 );
        var_caf27590bbd6657b = -1;
        var_56417b1cb9b69c80 = -1;
        
        for ( i = 0; i <= index ; i++ )
        {
            var_caf27590bbd6657b = function_d09b96e8d365585( str, "<dev string:x157>", var_56417b1cb9b69c80 + 1 );
            
            if ( var_caf27590bbd6657b == -1 )
            {
                return;
            }
            
            var_56417b1cb9b69c80 = function_d09b96e8d365585( str, "<dev string:x159>", var_caf27590bbd6657b + 1 );
            
            if ( var_56417b1cb9b69c80 == -1 )
            {
                return;
            }
        }
        
        return strtovec3( getsubstr( str, var_caf27590bbd6657b + 1, var_56417b1cb9b69c80 ) );
    }

    // Namespace mit_dev
    // Params 4, eflags: 0x44 variadic
    // Checksum 0xc7406fc4, Offset: 0xf28
    // Size: 0x107, Type: dev
    function private function_6f237c945e4baa98( dvarname, command, ... )
    {
        assert( varargcount > 0 );
        maxindex = -1;
        indexset = [];
        
        for ( i = 0; i < varargcount ; i++ )
        {
            index = vararg[ i ];
            assert( isint( index ) && index >= 0 );
            indexset[ index ] = 1;
            
            if ( index > maxindex )
            {
                maxindex = index;
            }
        }
        
        errormsg = "<dev string:xd3>" + getxhashsourcename( dvarname ) + "<dev string:xd1>" + command;
        
        for ( i = 0; i <= maxindex ; i++ )
        {
            if ( indexset[ i ] )
            {
                errormsg += "<dev string:x15b>" + i + "<dev string:x160>";
                continue;
            }
            
            errormsg += "<dev string:x162>" + i;
        }
        
        errormsg += "<dev string:x166>";
        iprintln( errormsg );
    }

#/
