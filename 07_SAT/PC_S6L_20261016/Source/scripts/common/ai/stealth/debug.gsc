// scripts\common\ai\stealth\debug.gsc  (hash_7980b6b79a1821a0.gscc) (size: 21449 Bytes / 0x53c9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8ced7a10 (2364373520)
// size ...... 21449 (0x53c9)
// includes .. 4   (offset: 0x4da5)
// strings ... 9   (offset: 0x4dc5)
// dev strs .. 96  (offset: 0x4e39)
// exports ... 47  (offset: 0x3859)
// cseg ...... 0xd3 + 0x3786 (0x3859)
// imports ... 105 (offset: 0x3fb1)
// animtree1 . 0   (offset: 0x53c9)
// animtree2 . 0   (offset: 0x53c9)
#using scripts\common\ai\smartobjects\utility;
#using scripts\common\ai\stealth\utility;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace debug;

/#

    // Namespace debug
    // Params 0
    // Checksum 0x6499633d, Offset: 0xf1
    // Size: 0x15d, Type: dev
    function debug_manager()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        setdvarifuninitialized( @"debug_stealth", "<dev string:x24>" );
        setdvarifuninitialized( @"debug_stealth_chat", "<dev string:x24>" );
        setdvarifuninitialized( @"debug_stealth_smartobjects", "<dev string:x24>" );
        setdvarifuninitialized( @"hash_e24fb561372dfef1", -1 );
        setdvarifuninitialized( @"debug_stealth_regions", "<dev string:x24>" );
        setdvarifuninitialized( @"hash_f30debd28e3f37e1", "<dev string:x24>" );
        setdvarifuninitialized( @"hash_99b5f3d24be9d6ca", "<dev string:x26>" );
        setdvarifuninitialized( @"debug_stealth_doors", "<dev string:x24>" );
        thread function_e7db81d4180edec7();
        utility::registersharedfunc( #"stealth_debug", #"hash_443faf8f48737297", &function_38a89e455afa7450 );
        
        while ( true )
        {
            waitframe();
            
            if ( !debug_enabled() )
            {
                continue;
            }
            
            draw_corpses();
            function_5e8e71749fd1541c( "<dev string:x27>", "<dev string:x2f>" );
            function_5e8e71749fd1541c( "<dev string:x27>", "<dev string:x41>" + utility::flag( "<dev string:x53>" ) );
            function_5e8e71749fd1541c( "<dev string:x27>", "<dev string:x63>" + utility::flag( "<dev string:x75>" ) );
            function_5ba9bfa952d6ff42( "<dev string:x27>" );
            debug_smart_objects();
            debug_stealth_regions();
            function_38814e133c1f49a1();
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x51aecf29, Offset: 0x256
    // Size: 0xfd, Type: dev
    function debug_player()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        self endon( #"death" );
        
        while ( true )
        {
            if ( debug_enabled() )
            {
                if ( isdefined( level.player.stealth ) && level.player utility::flag( "<dev string:x53>" ) )
                {
                    function_5e8e71749fd1541c( "<dev string:x85>", "<dev string:x8c>" );
                }
                
                function_5e8e71749fd1541c( "<dev string:x85>", "<dev string:xa3>" );
                function_5e8e71749fd1541c( "<dev string:x85>", "<dev string:xac>" + self.script_stealthgroup );
                function_5e8e71749fd1541c( "<dev string:x85>", "<dev string:xbc>" + level.player.maxvisibledist );
                
                if ( level.player utility::ent_flag( "<dev string:xcd>" ) )
                {
                    function_5e8e71749fd1541c( "<dev string:x85>", "<dev string:xdf>" );
                }
            }
            
            function_5ba9bfa952d6ff42( "<dev string:x85>" );
            waitframe();
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0xa7a5f336, Offset: 0x35b
    // Size: 0xa4, Type: dev
    function debug_friendly()
    {
        self endon( #"death" );
        setdvarifuninitialized( @"debug_stealthally", "<dev string:xe9>" );
        
        while ( true )
        {
            if ( debug_enabled() )
            {
                space = 10;
                count = 0;
                
                if ( utility::ent_flag( "<dev string:xcd>" ) )
                {
                    print3d( self.origin + ( 0, 0, count * space * -1 ), "<dev string:xec>", ( 0.2, 1, 0.2 ), 1, 0.5 );
                }
                
                count++;
                draw_enemies( "<dev string:xf6>" );
                waitframe();
                continue;
            }
            
            wait 1;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x290cbd3b, Offset: 0x407
    // Size: 0xb2, Type: dev
    function debug_enemy()
    {
        self endon( #"death" );
        setdvarifuninitialized( @"debug_stealthenemy", "<dev string:xe9>" );
        setdvarifuninitialized( @"debug_stealth_fov", "<dev string:x24>" );
        setdevdvarifuninitialized( @"debug_ai_magic", 0 );
        
        while ( true )
        {
            if ( self.in_melee_death )
            {
                return;
            }
            
            if ( debug_enabled() )
            {
                if ( debug_entindex() == -1 || debug_entindex() == self getentitynumber() )
                {
                    function_3107cfe44ffab();
                }
                
                num = debug_enemy_ent();
                
                if ( num == self getentitynumber() )
                {
                    function_8601c9d47442f12e();
                }
                
                waitframe();
                continue;
            }
            
            wait 1;
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0xe60cc40d, Offset: 0x4c1
    // Size: 0x2a, Type: dev
    function debug_enabled()
    {
        dvar = getunarchiveddebugdvar( @"debug_stealth", "<dev string:x24>" );
        return int( dvar );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x3d045974, Offset: 0x4f3
    // Size: 0x13, Type: dev
    function debug_entindex()
    {
        return getdvarint( @"ai_debugentindex" );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x52b2c12c, Offset: 0x50e
    // Size: 0x2a, Type: dev
    function debug_enemy_ent()
    {
        dvar = getunarchiveddebugdvar( @"debug_stealthenemy", "<dev string:xe9>" );
        return int( dvar );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x37b02f6d, Offset: 0x540
    // Size: 0x2a, Type: dev
    function function_f93f2fe7411eab2()
    {
        dvar = getunarchiveddebugdvar( @"debug_stealthally", "<dev string:xe9>" );
        return int( dvar );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x7d924eb6, Offset: 0x572
    // Size: 0x2a, Type: dev
    function function_653cacbf75533a43()
    {
        dvar = getunarchiveddebugdvar( @"debug_stealth_fov", "<dev string:x24>" );
        return int( dvar );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x60b552a7, Offset: 0x5a4
    // Size: 0x2a, Type: dev
    function function_84b0614de1d7b8c2()
    {
        dvar = getunarchiveddebugdvar( @"debug_stealth_chat", "<dev string:x24>" );
        return int( dvar );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x2fa00e7a, Offset: 0x5d6
    // Size: 0x2a, Type: dev
    function function_1cad6e74a2c30ffb()
    {
        dvar = getunarchiveddebugdvar( @"debug_stealth_smartobjects", "<dev string:x24>" );
        return int( dvar );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x42052240, Offset: 0x608
    // Size: 0x2a, Type: dev
    function function_817a471634422739()
    {
        dvar = getunarchiveddebugdvar( @"debug_stealth_regions", "<dev string:x24>" );
        return int( dvar );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x48d9ec01, Offset: 0x63a
    // Size: 0x2a, Type: dev
    function function_3908289d1e337507()
    {
        dvar = getunarchiveddebugdvar( @"hash_f30debd28e3f37e1", "<dev string:x24>" );
        return int( dvar );
    }

    // Namespace debug
    // Params 0
    // Checksum 0xd7f2ceca, Offset: 0x66c
    // Size: 0x2a, Type: dev
    function function_d5e5e14286d931d1()
    {
        dvar = getunarchiveddebugdvar( @"hash_350b154807f4d745", "<dev string:x24>" );
        return int( dvar );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x5b56b04, Offset: 0x69e
    // Size: 0x18, Type: dev
    function function_4cb7606cf801922f()
    {
        return getunarchiveddebugdvar( @"hash_99b5f3d24be9d6ca", "<dev string:x24>" );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x35f1655c, Offset: 0x6be
    // Size: 0x2a, Type: dev
    function function_10d2fdbe408b6548()
    {
        dvar = getunarchiveddebugdvar( @"hash_2c56d0045f1cd82e", "<dev string:x24>" );
        return int( dvar );
    }

    // Namespace debug
    // Params 3
    // Checksum 0x444f7b65, Offset: 0x6f0
    // Size: 0x6e, Type: dev
    function thick_line( start, end, color )
    {
        num = 3;
        
        for ( i = 0; i < num ; i++ )
        {
            start += ( 0, 0, num * 0.05 );
            end += ( 0, 0, num * 0.05 );
            line( start, end, color );
        }
    }

    // Namespace debug
    // Params 4
    // Checksum 0xd899c424, Offset: 0x766
    // Size: 0x79, Type: dev
    function thick_cylinder( start, end, radius, color )
    {
        num = 3;
        
        for ( i = 0; i < num ; i++ )
        {
            start += ( 0, 0, num * 0.05 );
            end += ( 0, 0, num * 0.05 );
            cylinder( start, end, radius, color );
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0xb124c08b, Offset: 0x7e7
    // Size: 0x107, Type: dev
    function stealth_debug_print( msg )
    {
        if ( !utility::flag( "<dev string:x53>" ) )
        {
            return;
        }
        
        type = undefined;
        name = undefined;
        
        if ( isdefined( self.script_noteworthy ) )
        {
            type = "<dev string:xfd>";
            name = self.script_noteworthy;
        }
        else if ( isdefined( self.targetname ) )
        {
            type = "<dev string:x10f>";
            name = self.targetname;
        }
        
        actor = "<dev string:x11a>" + self getentitynumber() + "<dev string:x12b>" + self.unique_id + "<dev string:x131>" + self.export;
        
        if ( isdefined( type ) )
        {
            actor += "<dev string:x13b>" + type + "<dev string:x13d>" + name;
        }
        
        txt = "<dev string:x140>" + actor + "<dev string:x14f>" + msg;
        println( txt );
        
        if ( getdvarint( @"stealth_debug_prints" ) == 1 )
        {
            thread function_fe461be91da7b140( msg );
        }
    }

    // Namespace debug
    // Params 2
    // Checksum 0x2c0d86f5, Offset: 0x8f6
    // Size: 0x111, Type: dev
    function function_5e8e71749fd1541c( type, msg )
    {
        if ( !isdefined( level.stealth.debug.screen[ type ] ) )
        {
            level.stealth.debug.screen[ type ] = 0;
        }
        
        x = 10;
        
        if ( type == "<dev string:x27>" )
        {
            y = 50;
        }
        else if ( type == "<dev string:x85>" )
        {
            y = 150;
        }
        else if ( type == "<dev string:x156>" )
        {
            y = 250;
        }
        else
        {
            y = 350;
        }
        
        y += level.stealth.debug.screen[ type ] * 10;
        printtoscreen2d( x, y, msg, ( 1, 1, 1 ), 0.75 );
        level.stealth.debug.screen[ type ]++;
    }

    // Namespace debug
    // Params 1
    // Checksum 0xefc59d9d, Offset: 0xa0f
    // Size: 0x31, Type: dev
    function function_5ba9bfa952d6ff42( type )
    {
        level.stealth.debug.screen[ type ] = 0;
    }

    // Namespace debug
    // Params 2
    // Checksum 0x87b7343a, Offset: 0xa48
    // Size: 0xed, Type: dev
    function debug_points( points, endonevent )
    {
        if ( !debug_enabled() )
        {
            return;
        }
        
        self endon( #"death" );
        self endon( endonevent );
        
        while ( true )
        {
            foreach ( point in points )
            {
                if ( isdefined( point.used_time ) )
                {
                    print3d( point.origin, string( point.used_time ) );
                    line( point.origin, self.origin );
                }
            }
            
            waitframe();
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0xf48d5ab, Offset: 0xb3d
    // Size: 0x136, Type: dev
    function debug_alert( type )
    {
        if ( !debug_enabled() )
        {
            return;
        }
        
        self endon( #"death" );
        self notify( #"stop_debug_alert" );
        self endon( #"stop_debug_alert" );
        color = ( 0.2, 1, 0.2 );
        msg = "<dev string:x15b>";
        
        if ( type == "<dev string:x162>" )
        {
            color = ( 1, 1, 0 );
            msg = "<dev string:x16b>";
        }
        else if ( type == "<dev string:x16d>" )
        {
            color = ( 1, 0.5, 0.25 );
            msg = "<dev string:x16b>";
        }
        else if ( type == "<dev string:x176>" )
        {
            color = ( 1, 0, 0 );
            msg = "<dev string:x17d>";
        }
        else if ( type == "<dev string:x17f>" )
        {
            color = ( 1, 0, 0 );
            msg = "<dev string:x18b>";
        }
        
        timer = gettime() + 5000;
        
        while ( gettime() < timer )
        {
            waitframe();
            print3d( self.origin + ( 0, 0, 72 ), msg, color, 1, 3 );
        }
    }

    // Namespace debug
    // Params 4
    // Checksum 0xa26137bb, Offset: 0xc7b
    // Size: 0x4d, Type: dev
    function function_7b40091262f062dc( msg, offset, scale, color )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        function_38a89e455afa7450( msg, color, 1, scale, offset );
    }

    // Namespace debug
    // Params 6
    // Checksum 0x25ab30d9, Offset: 0xcd0
    // Size: 0x3af, Type: dev
    function function_38a89e455afa7450( text, color, alpha, scale, offset, life )
    {
        if ( !debug_enabled() && !function_d5e5e14286d931d1() )
        {
            return;
        }
        
        if ( !( isdefined( text ) && isdefined( self.stealth ) ) )
        {
            return;
        }
        
        if ( !isdefined( offset ) )
        {
            offset = ( 0, 0, 92 );
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 0.5;
        }
        
        if ( !isdefined( life ) )
        {
            life = 3;
        }
        
        spacing = 10 * scale;
        riserate = 0;
        start = gettime();
        
        if ( !isdefined( self.stealth.debug_rising ) )
        {
            self.stealth.debug_rising = [];
            self.stealth.debug_rising_idx = -1;
        }
        
        self.stealth.debug_rising_idx++;
        myid = self.stealth.debug_rising_idx;
        self.stealth.debug_rising[ myid ] = offset;
        previd = myid - 1;
        
        while ( isdefined( self.stealth.debug_rising[ previd ] ) )
        {
            delta = self.stealth.debug_rising[ previd ][ 2 ] - self.stealth.debug_rising[ previd + 1 ][ 2 ];
            
            if ( delta >= spacing )
            {
                break;
            }
            
            self.stealth.debug_rising[ previd ] = ( self.stealth.debug_rising[ previd ][ 0 ], self.stealth.debug_rising[ previd ][ 1 ], self.stealth.debug_rising[ previd + 1 ][ 2 ] + spacing + delta );
            previd -= 1;
        }
        
        draworigin = self.stealth.debug_rising[ myid ];
        
        while ( gettime() - start < life * 1000 )
        {
            waitframe();
            
            if ( isdefined( self.stealth ) && isdefined( self.stealth.debug_rising[ myid ] ) && isalive( self ) )
            {
                draworigin = self.origin + self.stealth.debug_rising[ myid ];
            }
            
            print3d( draworigin, text, color, alpha, scale, 1 );
            draworigin = ( draworigin[ 0 ], draworigin[ 1 ], draworigin[ 2 ] + riserate );
            
            if ( isdefined( self.stealth ) && isdefined( self.stealth.debug_rising[ myid ] ) && isalive( self ) )
            {
                self.stealth.debug_rising[ myid ] = ( self.stealth.debug_rising[ myid ][ 0 ], self.stealth.debug_rising[ myid ][ 1 ], self.stealth.debug_rising[ myid ][ 2 ] + riserate );
            }
        }
        
        if ( isdefined( self.stealth ) && isdefined( self.stealth.debug_rising[ myid ] ) && isalive( self ) )
        {
            self.stealth.debug_rising[ myid ] = undefined;
        }
    }

    // Namespace debug
    // Params 2
    // Checksum 0xfad9fb46, Offset: 0x1087
    // Size: 0x1bf, Type: dev
    function draw_enemies( team, offset )
    {
        enemies = getaiarray( team );
        
        if ( team == "<dev string:xf6>" )
        {
            enemies[ enemies.size ] = level.player;
        }
        
        yellow = ( 1, 1, 0 );
        green = ( 0, 1, 0 );
        red = ( 1, 0, 0 );
        
        foreach ( enemy in enemies )
        {
            yellow_dist = squared( enemy.maxvisibledist + 200 );
            vis_dist = squared( enemy.maxvisibledist );
            distsqrd = distancesquared( enemy.origin, self.origin );
            
            if ( distsqrd < vis_dist )
            {
                color = red;
            }
            else if ( distsqrd < yellow_dist )
            {
                color = yellow;
            }
            else
            {
                color = green;
            }
            
            line( self.origin, enemy.origin, color );
            
            if ( function_10d2fdbe408b6548() > 0 )
            {
                sphere( self.origin, enemy.maxvisibledist, ( 0.88, 0.44, 0.88 ), 1, 1 );
            }
        }
    }

    // Namespace debug
    // Params 1
    // Checksum 0xcaf2ee54, Offset: 0x124e
    // Size: 0xa6, Type: dev
    function function_79d2f03ff8ef58af( agent )
    {
        dvar = getunarchiveddebugdvar( @"debug_ai_magic", "<dev string:x24>" );
        
        if ( isdefined( agent ) )
        {
            switch ( dvar )
            {
                case #"hash_31100fbc01bd387c":
                    return 1;
                case #"hash_311012bc01bd3d35":
                    if ( agent.type != "<dev string:x192>" )
                    {
                        return 1;
                    }
                    
                    return 0;
                case #"hash_311011bc01bd3ba2":
                    if ( agent.type == "<dev string:x192>" )
                    {
                        return 1;
                    }
                    
                    return 0;
                default:
                    return 0;
            }
        }
        
        return 0;
    }

    // Namespace debug
    // Params 0
    // Checksum 0xfc76217b, Offset: 0x12fc
    // Size: 0x47a, Type: dev
    function function_1d6eb9f521f230bc()
    {
        count = 0;
        var_f7dd7c3be24273f = function_79d2f03ff8ef58af( self );
        
        if ( var_f7dd7c3be24273f )
        {
            space = 20;
            white = ( 1, 1, 1 );
            red = ( 1, 0, 0 );
            yellow = ( 1, 1, 0 );
            green = ( 0, 1, 0 );
            size = 1;
            agenttype = "<dev string:x26>";
            viewpos = level.players[ 0 ] getvieworigin();
            scale = utility::function_e0618b428067bdd7( self.origin, viewpos, 1200 );
            
            if ( scale < 2 )
            {
                size *= scale;
                space *= scale;
            }
            
            if ( isdefined( self.agent_type ) )
            {
                agenttype += "<dev string:x19b>" + self.agent_type;
            }
            
            if ( agenttype.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), agenttype, white, 1, size );
                count++;
            }
            
            str_spawnfilter = "<dev string:x26>";
            
            if ( isdefined( self.ob ) && isdefined( self.ob.spawnfilter ) )
            {
                str_spawnfilter += "<dev string:x1a2>" + self.ob.spawnfilter;
            }
            
            if ( str_spawnfilter.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), str_spawnfilter, white, 1, size );
                count++;
            }
            
            agentstats = "<dev string:x26>";
            healthcolor = green;
            
            if ( isdefined( self.health ) )
            {
                agentstats += "<dev string:x1b0>" + self.health + "<dev string:x1ba>" + self.maxhealth + "<dev string:x1bc>";
                healthpct = self.health / self.maxhealth;
                
                if ( healthpct < 0.33 )
                {
                    healthcolor = red;
                }
                else if ( healthpct < 0.66 )
                {
                    healthcolor = yellow;
                }
                
                if ( isdefined( self.armorhealth ) )
                {
                    agentstats += "<dev string:x1be>" + self.armorhealth + "<dev string:x1c8>";
                }
            }
            
            if ( agentstats.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), agentstats, healthcolor, 1, size );
                count++;
            }
            
            loadout = "<dev string:x26>";
            
            if ( isdefined( self.primaryweapon ) )
            {
                loadout += "<dev string:x1cc>" + getweaponbasename( self.primaryweapon );
                
                if ( isdefined( self.secondaryweapon ) )
                {
                    loadout += "<dev string:x1d0>" + getweaponnamewithdefaultattachments( self.secondaryweapon );
                }
            }
            
            if ( loadout.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), loadout, white, 1, size );
                count++;
            }
            
            str_accuracy = "<dev string:x26>";
            
            if ( isdefined( self.accuracy ) )
            {
                str_accuracy += "<dev string:x1d5>" + self.accuracy + "<dev string:x1e0>" + self.baseaccuracy;
            }
            
            if ( str_accuracy.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), str_accuracy, white, 1, size );
                count++;
            }
            
            var_bb721f82a22e86ec = "<dev string:x26>";
            var_4255c06e2bb58915 = "<dev string:x26>";
            
            if ( isdefined( self.var_b2a3949fb18f37ac ) )
            {
                var_bb721f82a22e86ec += "<dev string:x1ea>" + self.var_b2a3949fb18f37ac + "<dev string:x1f6>" + round( self.gameskillmisstimedistancefactoroverride * 1000, 0.01 );
                playerdistance = distance( self.origin, viewpos );
                var_4255c06e2bb58915 += "<dev string:x205>" + round( playerdistance ) + "<dev string:x20e>" + round( playerdistance * self.gameskillmisstimedistancefactoroverride + self.var_b2a3949fb18f37ac, 0.01 );
            }
            
            if ( var_bb721f82a22e86ec.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), var_bb721f82a22e86ec, white, 1, size );
                count++;
                print3d( self.origin - ( 0, 0, count * space ), var_4255c06e2bb58915, white, 1, size );
                count++;
            }
        }
        
        return count;
    }

    // Namespace debug
    // Params 0
    // Checksum 0xec322553, Offset: 0x177e
    // Size: 0x59f, Type: dev
    function function_3107cfe44ffab()
    {
        space = 20;
        count = 0;
        size = 2;
        white = ( 1, 1, 1 );
        red = ( 1, 0, 0 );
        yellow = ( 1, 1, 0 );
        green = ( 0, 1, 0 );
        
        if ( function_653cacbf75533a43() )
        {
            draw_fov();
        }
        
        if ( utility::ismp() )
        {
            count = function_1d6eb9f521f230bc();
            
            if ( count > 0 )
            {
                size = 1;
                viewpos = level.players[ 0 ] getvieworigin();
                scale = utility::function_e0618b428067bdd7( self.origin, viewpos, 1200 );
                
                if ( scale < 2 )
                {
                    size *= scale;
                    space *= scale;
                }
            }
        }
        
        animstr = "<dev string:x21b>";
        patrolstyle = utility::get_patrol_style();
        
        if ( isdefined( patrolstyle ) )
        {
            animstr = patrolstyle;
        }
        
        szstate = "<dev string:x222>";
        szsubstate = "<dev string:x26>";
        bounded = 0;
        
        if ( isdefined( self.stealth_bsmstate ) )
        {
            switch ( self.stealth_bsmstate )
            {
                case 0:
                    szstate = "<dev string:x22a>";
                    break;
                case 1:
                    szstate = "<dev string:x22f>";
                    
                    if ( isdefined( level.stealth.investigate_volumes[ self.script_stealthgroup ] ) )
                    {
                        bounded = 1;
                    }
                    
                    break;
                case 2:
                    szstate = "<dev string:x233>";
                    
                    if ( isdefined( level.stealth.hunt_volumes[ self.script_stealthgroup ] ) )
                    {
                        bounded = 1;
                    }
                    
                    szsubstate = "<dev string:x238>";
                    break;
                case 3:
                    szstate = "<dev string:x242>";
                    
                    if ( isdefined( level.stealth.combat_volumes[ self.script_stealthgroup ] ) )
                    {
                        bounded = 1;
                    }
                    
                    break;
            }
        }
        
        print3d( self.origin - ( 0, 0, count * space ), self getentitynumber() + "<dev string:x249>" + szstate + szsubstate, white, 1, size );
        count++;
        print3d( self.origin - ( 0, 0, count * space ), "<dev string:x251>" + animstr, white, 1, size );
        count++;
        print3d( self.origin - ( 0, 0, count * space ), "<dev string:x258>" + self.var_6002aa8166897fd7, white, 1, size );
        count++;
        print3d( self.origin - ( 0, 0, count * space ), "<dev string:x25e>" + self.var_3367d5143630fda0, white, 1, size );
        count++;
        nextline = "<dev string:x26>";
        
        if ( isdefined( self.enemy ) )
        {
            nextline += "<dev string:x269>" + self.enemy getentitynumber() + "<dev string:x13b>";
        }
        
        if ( bounded )
        {
            nextline += "<dev string:x271>";
        }
        
        if ( nextline.size > 0 )
        {
            print3d( self.origin - ( 0, 0, count * space ), nextline, yellow, 1, size );
            count++;
        }
        
        if ( isdefined( self.lightmeter ) )
        {
            print3d( self.origin - ( 0, 0, count * space ), "<dev string:x279>" + self.lightmeter, red, 1, size );
            count++;
        }
        
        group = "<dev string:x26>";
        
        if ( isdefined( self.script_stealthgroup ) )
        {
            group = "<dev string:x286>" + self.script_stealthgroup + "<dev string:x13b>";
        }
        
        if ( group.size > 0 )
        {
            print3d( self.origin - ( 0, 0, count * space ), group, white, 1, size );
            count++;
        }
        
        eventlist = geteventlist( self );
        
        if ( isdefined( eventlist ) )
        {
            eventlistname = getxhashsourcename( eventlist );
            print3d( self.origin - ( 0, 0, count * space ), "<dev string:x295>" + eventlistname, white, 1, size );
            count++;
        }
        
        if ( !self [[ self.fnisinstealthcombat ]]() )
        {
            for ( iplayer = 0; iplayer < level.players.size ; iplayer++ )
            {
                ts = self getthreatsight( level.players[ iplayer ] );
                
                if ( ts > 0 )
                {
                    txt = iplayer + "<dev string:x13d>" + ts;
                    
                    if ( self cansee( level.players[ iplayer ] ) )
                    {
                        color = red;
                    }
                    else
                    {
                        color = green;
                    }
                    
                    print3d( self.origin - ( 0, 0, count * space ), txt, color, 1, size );
                    count++;
                }
            }
        }
        
        if ( isdefined( self.shootposoverride ) )
        {
            line( self geteye(), self.shootposoverride, ( 1, 1, 0 ) );
        }
        
        facingstart = self.origin + ( 0, 0, 8 );
        facingend = self.origin + ( 0, 0, 8 ) + anglestoforward( self.angles ) * 36;
        line( facingstart, facingend, ( 0, 0, 1 ) );
        
        if ( function_10d2fdbe408b6548() > 0 )
        {
            draw_enemies( "<dev string:xf6>" );
        }
    }

    // Namespace debug
    // Params 3
    // Checksum 0x66b4d14a, Offset: 0x1d25
    // Size: 0x64, Type: dev
    function function_67377f838ebee38( baseangles, angle, angleidx )
    {
        if ( angleidx == 0 )
        {
            return anglestoforward( baseangles + ( angle, 0, 0 ) );
        }
        
        if ( angleidx == 1 )
        {
            return anglestoforward( baseangles + ( 0, angle, 0 ) );
        }
        
        if ( angleidx == 2 )
        {
            return anglestoforward( baseangles + ( 0, 0, angle ) );
        }
    }

    // Namespace debug
    // Params 8
    // Checksum 0x4ce8c0b, Offset: 0x1d91
    // Size: 0xee, Type: dev
    function draw_arc( origin, startangle, endangle, baseangles, len, angleidx, numarcs, color )
    {
        assert( startangle < endangle );
        prevpt = origin + len * function_67377f838ebee38( baseangles, startangle, angleidx );
        nextpt = prevpt;
        line( origin, prevpt, color );
        angledelta = ( endangle - startangle ) / numarcs;
        
        for ( i = 1; i < numarcs + 1 ; i++ )
        {
            angle = startangle + angledelta * i;
            nextpt = origin + len * function_67377f838ebee38( baseangles, angle, angleidx );
            line( prevpt, nextpt, color );
            prevpt = nextpt;
        }
        
        line( origin, nextpt, color );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x1ad55494, Offset: 0x1e87
    // Size: 0x150, Type: dev
    function draw_fov()
    {
        dot = self.fovcosine;
        
        if ( isdefined( self.enemy ) )
        {
            dot = self.fovcosinebusy;
        }
        
        color = ( 1, 0, 0 );
        fov_yaw = acos( dot );
        
        if ( isai( self ) )
        {
            eye_yaw = self gettagangles( "<dev string:x2a1>" )[ 1 ];
        }
        else
        {
            eye_yaw = self gettagangles( "<dev string:x2a9>" )[ 1 ];
        }
        
        viewdist = level.player.maxvisibledist;
        
        if ( isai( self ) )
        {
            start = self gettagorigin( "<dev string:x2a1>" );
        }
        else
        {
            start = self gettagorigin( "<dev string:x2a9>" );
        }
        
        arc_segs = 10;
        draw_arc( start, -1 * fov_yaw, fov_yaw, ( 0, eye_yaw, 0 ), viewdist, 1, arc_segs, color );
        
        if ( self.fovcosinez > dot )
        {
            color *= 0.5;
            fov_pitch = acos( self.fovcosinez );
            eye_pitch = 0;
            draw_arc( start, -1 * fov_pitch, fov_pitch, ( eye_pitch, eye_yaw, 0 ), viewdist, 0, arc_segs, color );
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x9565fab0, Offset: 0x1fdf
    // Size: 0x122, Type: dev
    function function_8601c9d47442f12e()
    {
        function_5e8e71749fd1541c( "<dev string:x2b4>", "<dev string:x2ba>" + self getentitynumber() + "<dev string:x1bc>" );
        function_5e8e71749fd1541c( "<dev string:x2b4>", "<dev string:xac>" + self.script_stealthgroup );
        function_5e8e71749fd1541c( "<dev string:x2b4>", "<dev string:x2ce>" + self.alertlevel );
        
        if ( isdefined( self.enemy ) )
        {
            enemy = self.enemy getentitynumber();
        }
        else
        {
            enemy = "<dev string:x2db>";
        }
        
        function_5e8e71749fd1541c( "<dev string:x2b4>", "<dev string:x269>" + enemy );
        function_5e8e71749fd1541c( "<dev string:x2b4>", "<dev string:x2e5>" + self.stealth.ai_event );
        
        if ( self.team == "<dev string:xf6>" )
        {
            team = "<dev string:x2f5>";
        }
        else
        {
            team = "<dev string:xf6>";
        }
        
        enemies = getaiarray( team );
        
        if ( team == "<dev string:xf6>" )
        {
            enemies[ enemies.size ] = level.player;
        }
        
        function_5ba9bfa952d6ff42( "<dev string:x2b4>" );
    }

    // Namespace debug
    // Params 0
    // Checksum 0xc45e8af9, Offset: 0x2109
    // Size: 0x28b, Type: dev
    function function_e7db81d4180edec7()
    {
        cmaxlines = 16;
        cmaxtime = 30000;
        level.stealth.chatbox = [];
        level.stealth.var_3b63d8b5acd2fd24 = 0;
        level.stealth.var_e0864a327c2de1cf = 0;
        cstartx = 50;
        cstarty = 340;
        clinespacing = 20;
        cscale = 1.5;
        textcolor = ( 1, 1, 1 );
        levelstealth = level.stealth;
        
        while ( true )
        {
            if ( function_84b0614de1d7b8c2() )
            {
                var_f9a828d117a90032 = gettime() - cmaxtime;
                
                if ( levelstealth.var_e0864a327c2de1cf > 0 )
                {
                    cury = cstarty;
                    curline = levelstealth.var_3b63d8b5acd2fd24;
                    
                    for ( iline = 0; iline < levelstealth.var_e0864a327c2de1cf ; iline++ )
                    {
                        if ( levelstealth.chatbox[ curline ].time > var_f9a828d117a90032 )
                        {
                            text = "<dev string:x26>";
                            
                            if ( isstring( levelstealth.chatbox[ curline ].speaker ) )
                            {
                                text += levelstealth.chatbox[ curline ].speaker;
                            }
                            else
                            {
                                foreach ( speaker in levelstealth.chatbox[ curline ].speaker )
                                {
                                    if ( isdefined( speaker ) )
                                    {
                                        text += "<dev string:x13b>" + speaker getentitynumber();
                                    }
                                }
                                
                                levelstealth.chatbox[ curline ].speaker = text;
                            }
                            
                            text += "<dev string:x13d>" + levelstealth.chatbox[ curline ].text;
                            printtoscreen2d( cstartx, cury, text, textcolor, cscale );
                            cury += clinespacing;
                        }
                        
                        curline = ( curline + 1 ) % cmaxlines;
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace debug
    // Params 2
    // Checksum 0x7da7ad5f, Offset: 0x239c
    // Size: 0x1be, Type: dev
    function function_99160db0ba80d27b( speaker, line )
    {
        cmaxlines = 16;
        stealth = level.stealth;
        var_b8f0a385a232dca7 = ( stealth.var_3b63d8b5acd2fd24 + stealth.var_e0864a327c2de1cf ) % cmaxlines;
        curtime = gettime();
        var_dd65f75306450e2f = var_b8f0a385a232dca7 - 1;
        
        if ( var_dd65f75306450e2f < 0 )
        {
            var_dd65f75306450e2f = cmaxlines - 1;
        }
        
        if ( isdefined( stealth.chatbox[ var_dd65f75306450e2f ] ) && stealth.chatbox[ var_dd65f75306450e2f ].time == curtime && stealth.chatbox[ var_dd65f75306450e2f ].text == line )
        {
            stealth.chatbox[ var_dd65f75306450e2f ].speaker[ stealth.chatbox[ var_dd65f75306450e2f ].speaker.size ] = speaker;
            return;
        }
        
        s = spawnstruct();
        s.speaker = [ speaker ];
        s.text = line;
        s.time = curtime;
        stealth.chatbox[ var_b8f0a385a232dca7 ] = s;
        
        if ( var_b8f0a385a232dca7 == stealth.var_3b63d8b5acd2fd24 && stealth.var_e0864a327c2de1cf > 0 )
        {
            stealth.var_3b63d8b5acd2fd24 = ( stealth.var_3b63d8b5acd2fd24 + 1 ) % cmaxlines;
        }
        else
        {
            stealth.var_e0864a327c2de1cf++;
        }
        
        assert( stealth.var_e0864a327c2de1cf <= cmaxlines );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x8c8e7791, Offset: 0x2562
    // Size: 0x25f, Type: dev
    function draw_corpses()
    {
        if ( !debug_enabled() || !( isdefined( level.stealth ) && isdefined( level.stealth.corpse ) ) )
        {
            return;
        }
        
        if ( !isdefined( level.fngetcorpsearrayfunc ) )
        {
            return;
        }
        
        color = ( 1, 1, 0 );
        found_color = ( 0.9, 0, 0 );
        corpses = [[ level.fngetcorpsearrayfunc ]]();
        guys = getaiarray( "<dev string:x2f5>" );
        
        foreach ( corpse in corpses )
        {
            corpseorigin = getcorpseorigin( corpse );
            
            if ( getcorpseignored( corpse ) )
            {
                continue;
            }
            else if ( getcorpsefound( corpse ) )
            {
                print3d( corpseorigin, "<dev string:x2fa>" );
                continue;
            }
            else
            {
                print3d( corpseorigin, "<dev string:x307>" );
            }
            
            line( corpse.origin, corpseorigin );
            corpsedistances = getstealthcorpsedistances();
            
            foreach ( guy in guys )
            {
                if ( !isdefined( guy.stealth ) )
                {
                    continue;
                }
                
                if ( guy [[ guy.fnisinstealthcombat ]]() )
                {
                    continue;
                }
                
                dist = distancesquared( corpseorigin, guy.origin );
                
                if ( dist < corpsedistances.detect_distsqrd )
                {
                    line( guy.origin, corpseorigin, found_color );
                    continue;
                }
                
                if ( dist < corpsedistances.sight_distsqrd )
                {
                    line( guy.origin, corpseorigin, color );
                }
            }
        }
    }

    // Namespace debug
    // Params 2
    // Checksum 0x2b7f99d5, Offset: 0x27c9
    // Size: 0x93, Type: dev
    function function_fe461be91da7b140( message, duration )
    {
        self notify( #"hash_60765f522d73ffeb" );
        self endon( #"hash_60765f522d73ffeb" );
        self endon( #"death" );
        
        if ( !isdefined( duration ) )
        {
            duration = 5;
        }
        
        for ( time = 0; time < duration * 20 ; time++ )
        {
            print3d( self.origin + ( 0, 0, 45 ), message, ( 0.48, 9.4, 0.76 ), 0.85 );
            waitframe();
        }
    }

    // Namespace debug
    // Params 3
    // Checksum 0x3c944c88, Offset: 0x2864
    // Size: 0xc3, Type: dev
    function draw_axis( origin, angles, length )
    {
        axes = anglestoaxis( angles );
        forward = axes[ "<dev string:x30e>" ] * length;
        right = axes[ "<dev string:x316>" ] * length;
        up = axes[ "<dev string:x31c>" ] * length;
        line( origin - forward, origin + forward, ( 1, 0, 0 ), 1 );
        line( origin - up, origin + up, ( 0, 1, 0 ), 1 );
        line( origin - right, origin + right, ( 0, 0, 1 ), 1 );
    }

    // Namespace debug
    // Params 0
    // Checksum 0x778b11c7, Offset: 0x292f
    // Size: 0x213, Type: dev
    function debug_smart_objects()
    {
        if ( !isdefined( anim.smartobjectpoints ) )
        {
            return;
        }
        
        debughunt = function_1cad6e74a2c30ffb();
        
        if ( debughunt == 0 )
        {
            return;
        }
        
        colorgray = ( 0.7, 0.7, 0.7 );
        
        foreach ( obj in anim.smartobjectpoints )
        {
            angles = ( 0, 0, 0 );
            
            if ( isdefined( obj.angles ) )
            {
                angles = obj.angles;
            }
            
            draw_axis( obj.origin, angles, 12 );
            
            if ( debughunt == 2 )
            {
                print3d( obj.origin - ( 0, 0, 12 ), obj.script_smartobject, colorgray, 1, 0.3, 1 );
                objtype = utility::getsmartobjecttype( obj.script_smartobject );
                
                if ( isdefined( objtype ) && isdefined( objtype.fngetinfo ) )
                {
                    info = [[ objtype.fngetinfo ]]();
                    
                    if ( isdefined( info.radiussqrd ) )
                    {
                        r = sqrt( info.radiussqrd );
                        draw_arc( obj.origin, 0, 360, angles, r, 1, 8, colorgray );
                    }
                    
                    if ( isdefined( obj.claimer ) )
                    {
                        print3d( obj.origin - ( 0, 0, 18 ), "<dev string:x31f>" + obj.claimer getentitynumber(), colorgray, 1, 0.3, 1 );
                    }
                }
            }
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0x2a34c4a6, Offset: 0x2b4a
    // Size: 0x346, Type: dev
    function debug_stealth_regions()
    {
        var_6bc823f73431d89d = function_817a471634422739();
        
        if ( var_6bc823f73431d89d == 0 )
        {
            return;
        }
        
        if ( !isdefined( level.stealth.hunt_stealth_group_region_sets ) )
        {
            return;
        }
        
        debuggroup = function_4cb7606cf801922f();
        
        foreach ( group, group_data in level.stealth.hunt_stealth_group_region_sets )
        {
            if ( debuggroup != group && debuggroup != "<dev string:x26>" )
            {
                continue;
            }
            
            foreach ( region in group_data.hunt_regions )
            {
                for ( i = 1; i < region.route_points.size ; i++ )
                {
                    p0 = region.route_points[ i - 1 ];
                    p1 = region.route_points[ i ];
                    line( p0.origin, p1.origin, ( 0, 0.7, 0 ), 1, 0, 1 );
                }
                
                if ( isdefined( region.smart_objects ) )
                {
                    foreach ( smart_object in region.smart_objects )
                    {
                        draw_arc( smart_object.origin, 0, 360, smart_object.angles, 10, 1, 3, ( 0.7, 0, 0 ) );
                    }
                }
                
                if ( isdefined( region.region_links ) )
                {
                    foreach ( link in region.region_links )
                    {
                        line( link.transition_point.origin, link.transition_to_point.origin, ( 0.7, 0.7, 0 ), 1, 0, 1 );
                    }
                }
            }
        }
    }

    // Namespace debug
    // Params 0
    // Checksum 0xba2793f9, Offset: 0x2e98
    // Size: 0x413, Type: dev
    function function_38814e133c1f49a1()
    {
        var_3316000d75340f70 = function_3908289d1e337507();
        
        if ( var_3316000d75340f70 == 0 )
        {
            return;
        }
        
        if ( !isdefined( level.stealth.hunt_stealth_group_region_sets ) )
        {
            return;
        }
        
        debuggroup = function_4cb7606cf801922f();
        
        foreach ( group, group_data in level.stealth.hunt_stealth_group_region_sets )
        {
            if ( debuggroup != group && debuggroup != "<dev string:x26>" )
            {
                continue;
            }
            
            foreach ( region in group_data.hunt_regions )
            {
                assert( isdefined( region.approx_location ) );
                space = 10;
                count = 0;
                size = 0.5;
                white = ( 1, 1, 1 );
                print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x324>" + region.index, white, 1, size );
                count++;
                print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x32c>" + region.bfs_score, white, 1, size );
                count++;
                print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x338>" + region.shared_data.bfs_assigned, white, 1, size );
                count++;
                print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x343>" + region.shared_data.in_region, white, 1, size );
                count++;
                print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x34f>" + region.stealth_group, white, 1, size );
                cooldowndiff = region.shared_data.bfs_cooldown - gettime();
                
                if ( cooldowndiff > 0 )
                {
                    count++;
                    print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x357>" + cooldowndiff, white, 1, size );
                }
            }
            
            foreach ( region in group_data.hunt_regions )
            {
                foreach ( link in region.region_links )
                {
                    toregion = link.region;
                    line( region.approx_location, toregion.approx_location, ( 0, 0, 0.7 ), 1, 0, 1 );
                }
            }
        }
    }

#/

// Namespace debug
// Params 1
// Checksum 0xecee5ee0, Offset: 0x32b3
// Size: 0x320
function function_5287a2d90d4c0e3c( toggle = 1 )
{
    self endon( #"death" );
    self endon( #"hash_9af6545c89d9987f" );
    
    if ( toggle )
    {
        while ( true )
        {
            if ( !utility::flag( "stealth_enabled" ) || !isdefined( self.stealth ) || !self.stealth_enabled )
            {
                self notify( #"hash_9af6545c89d9987f" );
                return;
            }
            
            if ( !isalive( self ) )
            {
                self notify( #"hash_9af6545c89d9987f" );
                return;
            }
            
            stealthstate = self.stealth_bsmstate;
            
            switch ( stealthstate )
            {
                case 0:
                    newbsmstate = "idle";
                    stealthcolor = ( 1, 0.8, 0.5 );
                    break;
                case 1:
                    newbsmstate = "investigate";
                    stealthcolor = ( 0.8, 0.8, 0.2 );
                    break;
                case 2:
                    newbsmstate = "hunt";
                    stealthcolor = ( 0.8, 0.8, 0.2 );
                    break;
                case 3:
                    newbsmstate = "combat";
                    stealthcolor = ( 1, 0.1, 0.1 );
                    break;
            }
            
            sightconfig = self getsightconfigtemplateoverride() ?? "default sight";
            
            /#
                var_4a8eee194263f102 = getxhashsourcename( sightconfig );
            #/
            
            stealthbundle = level.stealth.var_4f05136f0457bdc4 ?? "no stealth bundle found";
            skit = self getinteractionid();
            
            /#
                entnum = self getentitynumber();
            #/
            
            /#
                print3d( self.origin - ( 0, 0, 20 ), "<dev string:x362>" + entnum, ( 1, 0.8, 0.5 ), 0.8, 0.5, 1, 1 );
            #/
            
            /#
                print3d( self.origin - ( 0, 0, 27 ), "<dev string:x36a>" + newbsmstate, stealthcolor, 0.8, 0.5, 1, 1 );
            #/
            
            /#
                print3d( self.origin - ( 0, 0, 34 ), "<dev string:x37a>" + var_4a8eee194263f102, ( 1, 0.8, 0.5 ), 0.8, 0.5, 1, 1 );
            #/
            
            /#
                print3d( self.origin - ( 0, 0, 41 ), "<dev string:x389>" + stealthbundle, ( 1, 0.8, 0.5 ), 0.8, 0.5, 1, 1 );
            #/
            
            if ( skit )
            {
                skitname = function_80eb2badd88a772d( skit );
                
                /#
                    print3d( self.origin - ( 0, 0, 48 ), "<dev string:x39a>" + skitname, ( 1, 0.8, 0.5 ), 0.8, 0.5, 1, 1 );
                #/
            }
            
            waitframe();
        }
        
        return;
    }
    
    self notify( #"hash_9af6545c89d9987f" );
}

/#

    // Namespace debug
    // Params 0
    // Checksum 0xd109b4f9, Offset: 0x35db
    // Size: 0x30, Type: dev
    function stealth_setup_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3a1>" );
        devgui::add_devgui_func( "<dev string:x3b2>", "<dev string:x3cd>", &function_d469a6bc6003f009, 1 );
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace debug
// Params 0
// Checksum 0x17b20bc9, Offset: 0x3613
// Size: 0x8f
function function_d469a6bc6003f009()
{
    if ( !isdefined( level.stealth.var_57776e144b318c1f ) )
    {
        level.stealth.var_57776e144b318c1f = 0;
    }
    
    if ( level.stealth.var_57776e144b318c1f == 0 )
    {
        level.stealth.var_57776e144b318c1f = 1;
        level thread function_8bfc0112b53bfe1();
        return;
    }
    
    level.stealth.var_57776e144b318c1f = 0;
    level notify( #"hash_9862c331ff55cd1c" );
    level thread function_a290ee7984b0b0aa();
}

// Namespace debug
// Params 0
// Checksum 0x601c18f8, Offset: 0x36aa
// Size: 0xe1
function function_8bfc0112b53bfe1()
{
    level endon( #"hash_9862c331ff55cd1c" );
    
    while ( true )
    {
        all_enemies = getaiarray( "axis", "neutral" );
        
        foreach ( enemy in all_enemies )
        {
            if ( !isdefined( enemy.var_57776e144b318c1f ) )
            {
                enemy.var_57776e144b318c1f = 0;
            }
            
            if ( enemy.var_57776e144b318c1f == 0 )
            {
                enemy.var_57776e144b318c1f = 1;
                enemy thread function_5287a2d90d4c0e3c( 1 );
            }
        }
        
        wait 0.25;
    }
}

// Namespace debug
// Params 0
// Checksum 0x1f06b3f, Offset: 0x3793
// Size: 0xc6
function function_a290ee7984b0b0aa()
{
    all_enemies = getaiarray( "axis", "neutral" );
    
    foreach ( enemy in all_enemies )
    {
        if ( !isdefined( enemy.var_57776e144b318c1f ) )
        {
            enemy.var_57776e144b318c1f = 0;
        }
        
        if ( enemy.var_57776e144b318c1f == 1 )
        {
            enemy.var_57776e144b318c1f = 0;
            enemy thread function_5287a2d90d4c0e3c( 0 );
        }
    }
}

