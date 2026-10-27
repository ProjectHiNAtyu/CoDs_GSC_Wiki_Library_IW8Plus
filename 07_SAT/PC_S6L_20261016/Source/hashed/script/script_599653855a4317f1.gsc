// script_599653855a4317f1  (hash_599653855a4317f1.gscc) (size: 10839 Bytes / 0x2a57 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4ef1a21a (1324458522)
// size ...... 10839 (0x2a57)
// includes .. 15  (offset: 0x25bb)
// strings ... 0   (offset: 0x2633)
// dev strs .. 73  (offset: 0x2633)
// exports ... 32  (offset: 0x1887)
// cseg ...... 0x58 + 0x182f (0x1887)
// imports ... 63  (offset: 0x1d87)
// animtree1 . 0   (offset: 0x2a57)
// animtree2 . 0   (offset: 0x2a57)
#using script_12443be69148a4fa;
#using script_1924b557dd30ebee;
#using script_1f9db1ea1ffd6741;
#using script_299b5dbadaf2b146;
#using script_45583617ae826370;
#using script_4cf6e8a5c419dee5;
#using script_68fc38d757ac68d3;
#using script_7439d62b3781dc9f;
#using script_75e52fe033895595;
#using script_770669934978bef0;
#using script_79e727c8633026e2;
#using scripts\common\utility;
#using scripts\common\vehicle_spawn;
#using scripts\mp\flags;
#using scripts\mp\matchdata;

#namespace dmz_logging;

/#

    // Namespace dmz_logging
    // Params 0
    // Checksum 0xeb3aedb1, Offset: 0x76
    // Size: 0x88, Type: dev
    function function_b20a9b3532ebf922()
    {
        if ( function_9ad9cb8f9a72e86c() )
        {
            level thread function_c082b4acd2eafc3d();
        }
        
        utility::registersharedfunc( #"logging", #"addevent", &addlogevent );
        setdvarifuninitialized( @"hash_9f23e8d498251b68", 0 );
        
        while ( !isdefined( level.struct_class_names ) )
        {
            waitframe();
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_9f23e8d498251b68", 0 ) == 1 )
            {
                setdvar( @"hash_9f23e8d498251b68", 0 );
                function_60c56b44dbe3562f();
            }
            
            waitframe();
        }
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0xdeca3aab, Offset: 0x106
    // Size: 0x197, Type: dev
    function private function_c082b4acd2eafc3d()
    {
        level endon( #"game_ended" );
        waitframe();
        
        while ( !flags::gameflagexists( "<dev string:x24>" ) )
        {
            waitframe();
        }
        
        flags::gameflagwait( "<dev string:x24>" );
        wait 5;
        fileid = openfile( "<dev string:x32>" + matchdata::getmatchstarttimeutc() + "<dev string:x5b>", "<dev string:x60>" );
        linenum = 0;
        
        foreach ( stringlist in [ function_7b647322f0855416( 1 ), function_e18b39342fae0f3d( 1 ), function_4490e63e222073f4(), level.var_9568bc294f8516b0 ] )
        {
            foreach ( string in stringlist )
            {
                linenum++;
                fprintln( fileid, string );
                
                if ( linenum > 2500 )
                {
                    linenum = 0;
                    waitframe();
                }
            }
        }
        
        fileid = closefile( fileid );
        level.var_643b2685e70f4b6d = 1;
        level.var_9568bc294f8516b0 = undefined;
    }

    // Namespace dmz_logging
    // Params 8
    // Checksum 0x7eacc9e9, Offset: 0x2a5
    // Size: 0xd4, Type: dev
    function addlogevent( identifier, classname, script_noteworthy, model, targetname, target, poi, origin )
    {
        if ( function_9ad9cb8f9a72e86c() )
        {
            if ( !isdefined( level.var_9568bc294f8516b0 ) )
            {
                level.var_9568bc294f8516b0 = [];
            }
            
            level.var_9568bc294f8516b0[ level.var_9568bc294f8516b0.size ] = function_9baa28f3ab6e1341( identifier ) + function_452dda2303628275( gettime() ) + function_825f0b882f5dedbd( classname ) + function_c19de4bbb8b968a2( script_noteworthy ) + function_151d3291017b0823( model ) + function_c03d5552a9cbb468( targetname ) + function_7ee1762e5e805553( target ) + function_a7be8b2ca84f6292( poi ) + function_8f1d8af21717ee2c( origin );
        }
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0xa1175142, Offset: 0x381
    // Size: 0x25, Type: dev
    function private function_9ad9cb8f9a72e86c()
    {
        return getdvarint( @"hash_1a2b4309113c3e63", 0 ) == 1 && !level.var_643b2685e70f4b6d;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0xc6e739c1, Offset: 0x3ae
    // Size: 0xd6, Type: dev
    function private function_4490e63e222073f4()
    {
        strings = [];
        lootcount = getlootspawnpointcount();
        linenum = 0;
        
        for ( i = 0; i < lootcount ; i++ )
        {
            loot = getlootspawnpoint( i );
            
            if ( !loot.game_extrainfo )
            {
                continue;
            }
            
            if ( loot.type == 0 )
            {
                strings[ strings.size ] = "<dev string:x66>" + function_8f1d8af21717ee2c( loot.origin );
            }
            else if ( loot.type == 1 )
            {
                strings[ strings.size ] = "<dev string:x8e>" + function_8f1d8af21717ee2c( loot.origin );
            }
            
            linenum++;
            
            if ( linenum > 2500 )
            {
                linenum = 0;
                waitframe();
            }
        }
        
        return strings;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0x4f37c77, Offset: 0x48c
    // Size: 0x1b5, Type: dev
    function private function_60c56b44dbe3562f()
    {
        fileid = openfile( "<dev string:xb7>" + "<dev string:xce>" + matchdata::getmatchstarttimeutc() + "<dev string:x5b>", "<dev string:x60>" );
        funcs = [ &function_7b647322f0855416, &function_e18b39342fae0f3d, &function_d52409d981937562, &function_5286d6d9a3cb23e4, &function_485eeffeefc88acf, &function_158947764fbe1b23, &function_9ec34166f0b1f88a, &function_d120e92ba0ae275b, &function_c0ad2c307af4056c, &function_1e2a974650803205, &function_c08b65c9bfeb7e0b, &function_1a2719733138f3d1, &function_e7c005e7e7f259e6, &function_bf65566024b954e2 ];
        linenum = 0;
        
        foreach ( func in funcs )
        {
            foreach ( string in [[ func ]]() )
            {
                fprintln( fileid, string );
                linenum++;
                
                if ( linenum % 2500 == 0 )
                {
                    waitframe();
                }
            }
        }
        
        fileid = closefile( fileid );
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0x2bef4d57, Offset: 0x649
    // Size: 0x1a7, Type: dev
    function private function_d52409d981937562()
    {
        startpointstrings = [];
        
        foreach ( startpoint in utility::getstructarray( "<dev string:xe4>", "<dev string:xf8>" ) )
        {
            startpointstrings[ startpointstrings.size ] = "<dev string:x10a>" + "<dev string:xe4>" + "<dev string:x146>" + function_a7be8b2ca84f6292( startpoint.script_poi ) + function_8f1d8af21717ee2c( startpoint.origin );
        }
        
        for ( i = 1; utility::getstructarray( "<dev string:x14d>" + i, "<dev string:xf8>" ).size > 0 ; i++ )
        {
            foreach ( startpoint in utility::getstructarray( "<dev string:x14d>" + i, "<dev string:xf8>" ) )
            {
                startpointstrings[ startpointstrings.size ] = "<dev string:x16d>" + i + "<dev string:x185>" + "<dev string:xe4>" + i + "<dev string:x146>" + function_a7be8b2ca84f6292( startpoint.script_poi ) + function_8f1d8af21717ee2c( startpoint.origin );
            }
        }
        
        return startpointstrings;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0x68a60e5e, Offset: 0x7f8
    // Size: 0x1a7, Type: dev
    function private function_5286d6d9a3cb23e4()
    {
        exfilstrings = [];
        
        foreach ( exfil in utility::getstructarray( "<dev string:x1b1>", "<dev string:xf8>" ) )
        {
            exfilstrings[ exfilstrings.size ] = "<dev string:x1c5>" + "<dev string:x1b1>" + "<dev string:x146>" + function_a7be8b2ca84f6292( exfil.script_poi ) + function_8f1d8af21717ee2c( exfil.origin );
        }
        
        for ( i = 1; utility::getstructarray( "<dev string:x20a>" + i, "<dev string:xf8>" ).size > 0 ; i++ )
        {
            foreach ( exfil in utility::getstructarray( "<dev string:x20a>" + i, "<dev string:xf8>" ) )
            {
                exfilstrings[ exfilstrings.size ] = "<dev string:x221>" + i + "<dev string:x185>" + "<dev string:x20a>" + i + "<dev string:x146>" + function_a7be8b2ca84f6292( exfil.script_poi ) + function_8f1d8af21717ee2c( exfil.origin );
            }
        }
        
        return exfilstrings;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0x31e01d90, Offset: 0x9a7
    // Size: 0xb9, Type: dev
    function private function_485eeffeefc88acf()
    {
        uavstrings = [];
        
        foreach ( uav in utility::getstructarray( "<dev string:x23c>", "<dev string:x246>" ) )
        {
            uavstrings[ uavstrings.size ] = "<dev string:x251>" + function_a7be8b2ca84f6292( uav.script_poi ) + function_8f1d8af21717ee2c( uav.origin );
        }
        
        return uavstrings;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0xed955c0f, Offset: 0xa68
    // Size: 0xcb, Type: dev
    function private function_9ec34166f0b1f88a()
    {
        fortressstrings = [];
        
        foreach ( fortress in utility::getstructarray( "<dev string:x2b3>", "<dev string:x246>" ) )
        {
            fortressstrings[ fortressstrings.size ] = "<dev string:x2bc>" + fortress.script_noteworthy + "<dev string:x2fb>" + fortress.target + "<dev string:x31a>" + function_8f1d8af21717ee2c( fortress.origin );
        }
        
        return fortressstrings;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0xe913105f, Offset: 0xb3b
    // Size: 0xd0, Type: dev
    function private function_d120e92ba0ae275b()
    {
        hotzonestrings = [];
        
        foreach ( zoneindex in level.hotzoneindices )
        {
            zoneinfo = function_4e52a812b6d1d965( zoneindex );
            
            if ( zoneinfo.ishotzone )
            {
                hotzonestrings[ hotzonestrings.size ] = "<dev string:x31d>" + zoneinfo.name + "<dev string:x356>" + function_8f1d8af21717ee2c( zoneinfo.midpoint );
            }
        }
        
        return hotzonestrings;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0x5d60ba1f, Offset: 0xc13
    // Size: 0xb9, Type: dev
    function private function_c0ad2c307af4056c()
    {
        buystationstrings = [];
        
        foreach ( buystation in utility::getstructarray( "<dev string:x35f>", "<dev string:x246>" ) )
        {
            buystationstrings[ buystationstrings.size ] = "<dev string:x36b>" + function_a7be8b2ca84f6292( buystation.script_poi ) + function_8f1d8af21717ee2c( buystation.origin );
        }
        
        return buystationstrings;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0xdf666e47, Offset: 0xcd4
    // Size: 0x155, Type: dev
    function private function_1e2a974650803205()
    {
        gasstationstrings = [];
        
        foreach ( gasstation in utility::getstructarray( "<dev string:x3e3>", "<dev string:x246>" ) )
        {
            gasstationstrings[ gasstationstrings.size ] = "<dev string:x3ef>" + function_a7be8b2ca84f6292( gasstation.script_poi ) + function_8f1d8af21717ee2c( gasstation.origin );
        }
        
        foreach ( gasstation in utility::getstructarray( "<dev string:x43b>", "<dev string:x246>" ) )
        {
            gasstationstrings[ gasstationstrings.size ] = "<dev string:x44e>" + function_a7be8b2ca84f6292( gasstation.script_poi ) + function_8f1d8af21717ee2c( gasstation.origin );
        }
        
        return gasstationstrings;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0x693589bf, Offset: 0xe31
    // Size: 0xd1, Type: dev
    function private function_c08b65c9bfeb7e0b()
    {
        reinforcestrings = [];
        
        foreach ( node in utility::getstructarray( "<dev string:x4a8>", "<dev string:xf8>" ) )
        {
            reinforcestrings[ reinforcestrings.size ] = "<dev string:x4b4>" + function_c03d5552a9cbb468( node.targetname ) + "<dev string:x31a>" + function_a7be8b2ca84f6292( node.script_poi ) + function_8f1d8af21717ee2c( node.origin );
        }
        
        return reinforcestrings;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0xb438d5b3, Offset: 0xf0a
    // Size: 0x162, Type: dev
    function private function_1a2719733138f3d1()
    {
        vehiclespawnstrings = [];
        
        foreach ( vehicleref, vehicledata in level.var_a7bf93687486b5ba )
        {
            if ( !isstring( vehicleref ) )
            {
                continue;
            }
            
            foreach ( spawnstruct in vehicle_spawn::get_spawn_structs( vehicleref ) )
            {
                vehicletype = spawnstruct.vehicletype;
                
                if ( !isdefined( vehicletype ) )
                {
                    vehicletype = vehicleref;
                }
                
                vehiclespawnstrings[ vehiclespawnstrings.size ] = "<dev string:x520>" + vehicletype + "<dev string:x52c>" + vehicletype + "<dev string:x31a>" + function_151d3291017b0823( vehicledata.model ) + "<dev string:x146>" + function_8f1d8af21717ee2c( spawnstruct.origin );
            }
        }
        
        return vehiclespawnstrings;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0x201961ec, Offset: 0x1074
    // Size: 0x118, Type: dev
    function private function_e7c005e7e7f259e6()
    {
        struct = spawnstruct();
        struct.strings = [];
        getaiarraystrings( level.firstkillfoddernodes, struct, "<dev string:x538>" );
        getaiarraystrings( level.looseguardnodes, struct, "<dev string:x54a>" );
        getaiarraystrings( level.var_97796c8ddfa2ed4a, struct, "<dev string:x550>" );
        getaiarraystrings( utility::getstructarray( "<dev string:x558>", "<dev string:xf8>" ), struct, "<dev string:x56e>" );
        
        foreach ( path in level.patrolpaths )
        {
            getaiarraystrings( path.path, struct, "<dev string:x57c>" );
        }
        
        return struct.strings;
    }

    // Namespace dmz_logging
    // Params 3, eflags: 0x4
    // Checksum 0x32a58a76, Offset: 0x1194
    // Size: 0x111, Type: dev
    function private getaiarraystrings( array, struct, identifier )
    {
        foreach ( node in array )
        {
            struct.strings[ struct.strings.size ] = "<dev string:x520>" + identifier + "<dev string:x588>" + function_c19de4bbb8b968a2( node.script_noteworthy ) + "<dev string:x31a>" + function_c03d5552a9cbb468( node.targetname ) + function_7ee1762e5e805553( node.target ) + function_a7be8b2ca84f6292( node.script_poi ) + function_8f1d8af21717ee2c( node.origin );
        }
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0x61886f0b, Offset: 0x12ad
    // Size: 0xc4, Type: dev
    function private function_bf65566024b954e2()
    {
        strings = [];
        lootcount = getlootspawnpointcount();
        linenum = 0;
        
        for ( i = 0; i < lootcount ; i++ )
        {
            loot = getlootspawnpoint( i );
            
            if ( loot.type == 0 )
            {
                strings[ strings.size ] = "<dev string:x5a1>" + function_8f1d8af21717ee2c( loot.origin );
            }
            else if ( loot.type == 1 )
            {
                strings[ strings.size ] = "<dev string:x5c2>" + function_8f1d8af21717ee2c( loot.origin );
            }
            
            linenum++;
            
            if ( linenum > 2500 )
            {
                linenum = 0;
                waitframe();
            }
        }
        
        return strings;
    }

    // Namespace dmz_logging
    // Params 0, eflags: 0x4
    // Checksum 0xe4cebf3a, Offset: 0x1379
    // Size: 0x19b, Type: dev
    function private function_158947764fbe1b23()
    {
        activitystrings = [];
        activityfuncs = [];
        activityfuncs[ "<dev string:x5e4>" ] = &namespace_521b355ce75f6eac::function_746bdfc760ec9b18;
        activityfuncs[ "<dev string:x5e8>" ] = &namespace_4c5dd9edb2d6e4a8::function_746bdfc760ec9b18;
        activityfuncs[ "<dev string:x5ef>" ] = &namespace_9db1e12416591c99::function_746bdfc760ec9b18;
        activityfuncs[ "<dev string:x5f4>" ] = &namespace_76299fb251d3aacd::function_746bdfc760ec9b18;
        activityfuncs[ "<dev string:x5f9>" ] = &namespace_1ff0dda307309968::function_746bdfc760ec9b18;
        activityfuncs[ "<dev string:x5ff>" ] = &namespace_5ab652de57e3c043::function_746bdfc760ec9b18;
        activityfuncs[ "<dev string:x604>" ] = &namespace_137eb3a00b0ea8c6::function_746bdfc760ec9b18;
        activityfuncs[ "<dev string:x608>" ] = &namespace_87e5a35991b973ad::function_746bdfc760ec9b18;
        activityfuncs[ "<dev string:x610>" ] = &namespace_a7cd3da1542a2432::function_746bdfc760ec9b18;
        activityfuncs[ "<dev string:x615>" ] = &namespace_b0d5e7f43c6af238::function_746bdfc760ec9b18;
        activityfuncs[ "<dev string:x622>" ] = &namespace_84d989e8789e6a05::function_746bdfc760ec9b18;
        
        foreach ( name, func in activityfuncs )
        {
            foreach ( node in [[ func ]]() )
            {
                activitystrings[ activitystrings.size ] = getactivitystring( node, name );
                
                if ( activitystrings.size % 2500 == 0 )
                {
                    waitframe();
                }
            }
        }
        
        return activitystrings;
    }

    // Namespace dmz_logging
    // Params 2, eflags: 0x4
    // Checksum 0xfedd899d, Offset: 0x151c
    // Size: 0x8a, Type: dev
    function private getactivitystring( node, name )
    {
        return "<dev string:x520>" + name + "<dev string:x62f>" + name + function_c19de4bbb8b968a2( node.script_noteworthy ) + function_151d3291017b0823( node.model ) + function_c03d5552a9cbb468( node.targetname ) + "<dev string:x31a>" + function_a7be8b2ca84f6292( node.script_poi ) + function_8f1d8af21717ee2c( node.origin );
    }

    // Namespace dmz_logging
    // Params 1, eflags: 0x4
    // Checksum 0xba7567e8, Offset: 0x15ae
    // Size: 0x3d, Type: dev
    function private function_7b647322f0855416( includetime )
    {
        return [ "<dev string:x644>" + ( istrue( includetime ) ? "<dev string:x658>" : "<dev string:x660>" ) + "<dev string:x52c>" + 2 + "<dev string:x661>" ];
    }

    // Namespace dmz_logging
    // Params 1, eflags: 0x4
    // Checksum 0x72bac0c5, Offset: 0x15f3
    // Size: 0xf2, Type: dev
    function private function_e18b39342fae0f3d( includetime )
    {
        assert( isdefined( level.mapcorners ) && isdefined( level.minimapmaterial ) );
        strings = [];
        
        foreach ( corner in level.mapcorners )
        {
            strings[ strings.size ] = "<dev string:x671>" + ( includetime ? "<dev string:x658>" : "<dev string:x660>" ) + "<dev string:x52c>" + level.minimapmaterial + "<dev string:x68b>" + function_8f1d8af21717ee2c( corner.origin );
        }
        
        return strings;
    }

    // Namespace dmz_logging
    // Params 1, eflags: 0x4
    // Checksum 0x3d0f7b0b, Offset: 0x16ed
    // Size: 0x24, Type: dev
    function private function_9baa28f3ab6e1341( identifier )
    {
        if ( isdefined( identifier ) )
        {
            return ( "<dev string:x520>" + identifier );
        }
        
        return "<dev string:x696>";
    }

    // Namespace dmz_logging
    // Params 1, eflags: 0x4
    // Checksum 0x54c8b1cd, Offset: 0x1719
    // Size: 0x24, Type: dev
    function private function_452dda2303628275( timestep )
    {
        if ( isdefined( timestep ) )
        {
            return ( "<dev string:x698>" + timestep );
        }
        
        return "<dev string:x31a>";
    }

    // Namespace dmz_logging
    // Params 1, eflags: 0x4
    // Checksum 0xbb912aef, Offset: 0x1745
    // Size: 0x24, Type: dev
    function private function_825f0b882f5dedbd( classname )
    {
        if ( isdefined( classname ) )
        {
            return ( "<dev string:x52c>" + classname );
        }
        
        return "<dev string:x31a>";
    }

    // Namespace dmz_logging
    // Params 1, eflags: 0x4
    // Checksum 0xaea64961, Offset: 0x1771
    // Size: 0x24, Type: dev
    function private function_c19de4bbb8b968a2( script_noteworthy )
    {
        if ( isdefined( script_noteworthy ) )
        {
            return ( "<dev string:x69f>" + script_noteworthy );
        }
        
        return "<dev string:x31a>";
    }

    // Namespace dmz_logging
    // Params 1, eflags: 0x4
    // Checksum 0x7ee16b1, Offset: 0x179d
    // Size: 0x24, Type: dev
    function private function_151d3291017b0823( model )
    {
        if ( isdefined( model ) )
        {
            return ( "<dev string:x6b3>" + model );
        }
        
        return "<dev string:x31a>";
    }

    // Namespace dmz_logging
    // Params 1, eflags: 0x4
    // Checksum 0xbd5cf0da, Offset: 0x17c9
    // Size: 0x24, Type: dev
    function private function_c03d5552a9cbb468( targetname )
    {
        if ( isdefined( targetname ) )
        {
            return ( "<dev string:x6bb>" + targetname );
        }
        
        return "<dev string:x31a>";
    }

    // Namespace dmz_logging
    // Params 1, eflags: 0x4
    // Checksum 0x3def9b0e, Offset: 0x17f5
    // Size: 0x24, Type: dev
    function private function_7ee1762e5e805553( target )
    {
        if ( isdefined( target ) )
        {
            return ( "<dev string:x6c8>" + target );
        }
        
        return "<dev string:x31a>";
    }

    // Namespace dmz_logging
    // Params 1, eflags: 0x4
    // Checksum 0x7b60cf1b, Offset: 0x1821
    // Size: 0x3a, Type: dev
    function private function_8f1d8af21717ee2c( origin )
    {
        assert( isdefined( origin ) );
        return "<dev string:x6d1>" + origin[ 0 ] + "<dev string:x6d1>" + origin[ 1 ] + "<dev string:x6d1>" + origin[ 2 ];
    }

    // Namespace dmz_logging
    // Params 1, eflags: 0x4
    // Checksum 0x99b0a746, Offset: 0x1863
    // Size: 0x24, Type: dev
    function private function_a7be8b2ca84f6292( poi )
    {
        if ( isdefined( poi ) )
        {
            return ( "<dev string:x6d3>" + poi );
        }
        
        return "<dev string:x31a>";
    }

#/
