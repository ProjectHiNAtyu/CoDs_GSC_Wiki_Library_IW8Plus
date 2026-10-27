// scripts\mp\art.gsc  (hash_31fcfd26e002b5ad.gscc) (size: 4206 Bytes / 0x106e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a878754 (713525076)
// size ...... 4206 (0x106e)
// includes .. 1   (offset: 0xf96)
// strings ... 0   (offset: 0xf9e)
// dev strs .. 17  (offset: 0xf9e)
// exports ... 14  (offset: 0x9ee)
// cseg ...... 0x58 + 0x996 (0x9ee)
// imports ... 29  (offset: 0xc1e)
// animtree1 . 0   (offset: 0x106e)
// animtree2 . 0   (offset: 0x106e)
#using scripts\common\utility;

#namespace art;

/#

    // Namespace art
    // Params 0
    // Checksum 0x5f6b7204, Offset: 0x76
    // Size: 0x5d, Type: dev
    function main()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        setdevdvarifuninitialized( @"scr_art_tweak", 0 );
        thread tweakart();
        tess_init();
        
        if ( !isdefined( level.script ) )
        {
            level.script = tolower( getdvar( @"g_mapname" ) );
        }
    }

    // Namespace art
    // Params 0
    // Checksum 0xded3597d, Offset: 0xdb
    // Size: 0x46, Type: dev
    function inittweaks()
    {
        setdevdvar( @"r_artusetweaks", 1 );
        
        if ( !isdefined( level.buttons ) )
        {
            level.buttons = [];
        }
        
        level._clearalltextafterhudelem = 0;
        iprintlnbold( "<dev string:x24>" );
        hud_init();
    }

    // Namespace art
    // Params 0
    // Checksum 0x8c90c51d, Offset: 0x129
    // Size: 0x8b, Type: dev
    function tweakart()
    {
        if ( !isdefined( level.tweakfile ) )
        {
            level.tweakfile = 0;
        }
        
        setdevdvar( @"scr_fog_fraction", "<dev string:x36>" );
        setdevdvar( @"scr_art_dump", "<dev string:x3a>" );
        printed = 0;
        
        for ( ;; )
        {
            while ( getdvarint( @"scr_art_tweak", 0 ) == 0 )
            {
                wait 0.05;
            }
            
            if ( !printed )
            {
                printed = 1;
                inittweaks();
            }
            
            dumpsettings();
            wait 0.05;
        }
    }

    // Namespace art
    // Params 0
    // Checksum 0x2235b04, Offset: 0x1bc
    // Size: 0x115, Type: dev
    function tess_init()
    {
        using_tessellation = getdvarint( @"r_tessellation" );
        
        if ( using_tessellation == 0 )
        {
            return;
        }
        
        level.tess = spawnstruct();
        level.tess.cutoff_distance_current = 635;
        level.tess.cutoff_distance_goal = level.tess.cutoff_distance_current;
        level.tess.cutoff_falloff_current = 587;
        level.tess.cutoff_falloff_goal = level.tess.cutoff_falloff_current;
        level.tess.time_remaining = 0;
        setdvar( @"r_tessellationcutoffdistance", level.tess.cutoff_distance_current );
        setdvar( @"r_tessellationcutofffalloff", level.tess.cutoff_falloff_current );
        thread tess_update();
    }

    // Namespace art
    // Params 3
    // Checksum 0xec5657e7, Offset: 0x2d9
    // Size: 0x63, Type: dev
    function tess_set_goal( cutoff_distance, cutoff_falloff, blend_time )
    {
        level.tess.cutoff_distance_goal = cutoff_distance;
        level.tess.cutoff_falloff_goal = cutoff_falloff;
        level.tess.time_remaining = blend_time;
    }

    // Namespace art
    // Params 0
    // Checksum 0x80e8e4a5, Offset: 0x344
    // Size: 0x238, Type: dev
    function tess_update()
    {
        while ( true )
        {
            cutoff_distance_old = level.tess.cutoff_distance_current;
            cutoff_falloff_old = level.tess.cutoff_falloff_current;
            waitframe();
            
            if ( level.tess.time_remaining > 0 )
            {
                frames = level.tess.time_remaining * 20;
                distance_increment = ( level.tess.cutoff_distance_goal - level.tess.cutoff_distance_current ) / frames;
                falloff_increment = ( level.tess.cutoff_falloff_goal - level.tess.cutoff_falloff_current ) / frames;
                level.tess.cutoff_distance_current += distance_increment;
                level.tess.cutoff_falloff_current += falloff_increment;
                level.tess.time_remaining -= level.framedurationseconds;
            }
            else
            {
                level.tess.cutoff_distance_current = level.tess.cutoff_distance_goal;
                level.tess.cutoff_falloff_current = level.tess.cutoff_falloff_goal;
            }
            
            if ( cutoff_distance_old != level.tess.cutoff_distance_current )
            {
                setdvar( @"r_tessellationcutoffdistance", level.tess.cutoff_distance_current );
            }
            
            if ( cutoff_falloff_old != level.tess.cutoff_falloff_current )
            {
                setdvar( @"r_tessellationcutofffalloff", level.tess.cutoff_falloff_current );
            }
        }
    }

    // Namespace art
    // Params 0
    // Checksum 0xd0da2aef, Offset: 0x584
    // Size: 0xa5, Type: dev
    function dumpsettings()
    {
        if ( getdvarint( @"scr_art_dump" ) == 0 )
        {
            return 0;
        }
        
        setdevdvar( @"scr_art_dump", "<dev string:x3a>" );
        utility::fileprint_launcher_start_file();
        utility::fileprint_launcher( "<dev string:x3c>" );
        utility::fileprint_launcher( "<dev string:x8f>" );
        utility::fileprint_launcher( "<dev string:x96>" );
        utility::fileprint_launcher( "<dev string:x98>" );
        utility::fileprint_launcher( "<dev string:xb1>" );
        
        if ( !utility::fileprint_launcher_end_file( "<dev string:xb3>" + level.script + "<dev string:xd3>", 1 ) )
        {
            return;
        }
        
        iprintlnbold( "<dev string:xdc>" );
        println( "<dev string:xed>" );
    }

    // Namespace art
    // Params 2
    // Checksum 0x508369cb, Offset: 0x631
    // Size: 0x99, Type: dev
    function button_down( btn, btn2 )
    {
        pressed = level.players[ 0 ] buttonpressed( btn );
        
        if ( !pressed )
        {
            pressed = level.players[ 0 ] buttonpressed( btn2 );
        }
        
        if ( !isdefined( level.buttons[ btn ] ) )
        {
            level.buttons[ btn ] = 0;
        }
        
        if ( gettime() < level.buttons[ btn ] )
        {
            return 0;
        }
        
        level.buttons[ btn ] = gettime() + 400;
        return pressed;
    }

    // Namespace art
    // Params 0
    // Checksum 0xd398cc8a, Offset: 0x6d2
    // Size: 0x17b, Type: dev
    function hud_init()
    {
        listsize = 7;
        hudelems = [];
        spacer = 15;
        div = int( listsize / 2 );
        org = 240 - div * spacer;
        alphainc = 0.5 / div;
        alpha = alphainc;
        
        for ( i = 0; i < listsize ; i++ )
        {
            hudelems[ i ] = _newhudelem();
            hudelems[ i ].location = 0;
            hudelems[ i ].alignx = "<dev string:x10a>";
            hudelems[ i ].aligny = "<dev string:x10f>";
            hudelems[ i ].foreground = 1;
            hudelems[ i ].fontscale = 2;
            hudelems[ i ].sort = 20;
            
            if ( i == div )
            {
                hudelems[ i ].alpha = 1;
            }
            else
            {
                hudelems[ i ].alpha = alpha;
            }
            
            hudelems[ i ].x = 20;
            hudelems[ i ].y = org;
            hudelems[ i ] _settext( "<dev string:x116>" );
            
            if ( i == div )
            {
                alphainc *= -1;
            }
            
            alpha += alphainc;
            org += spacer;
        }
        
        level.spam_group_hudelems = hudelems;
    }

    // Namespace art
    // Params 0
    // Checksum 0x81c90452, Offset: 0x855
    // Size: 0x45, Type: dev
    function _newhudelem()
    {
        if ( !isdefined( level.scripted_elems ) )
        {
            level.scripted_elems = [];
        }
        
        elem = newhudelem();
        level.scripted_elems[ level.scripted_elems.size ] = elem;
        return elem;
    }

    // Namespace art
    // Params 1
    // Checksum 0x14e144ff, Offset: 0x8a2
    // Size: 0xe6, Type: dev
    function _settext( text )
    {
        self.realtext = text;
        self setdevtext( "<dev string:x118>" );
        thread _clearalltextafterhudelem();
        var_a8d7a4ace4c18132 = 0;
        
        foreach ( elem in level.scripted_elems )
        {
            if ( isdefined( elem.realtext ) )
            {
                var_a8d7a4ace4c18132 += elem.realtext.size;
                elem setdevtext( elem.realtext );
            }
        }
        
        println( "<dev string:x11a>" + var_a8d7a4ace4c18132 );
    }

    // Namespace art
    // Params 0
    // Checksum 0xf09e9194, Offset: 0x990
    // Size: 0x33, Type: dev
    function _clearalltextafterhudelem()
    {
        if ( level._clearalltextafterhudelem )
        {
            return;
        }
        
        level._clearalltextafterhudelem = 1;
        self clearalltextafterhudelem();
        wait 0.05;
        level._clearalltextafterhudelem = 0;
    }

    // Namespace art
    // Params 0
    // Checksum 0x3f395ee0, Offset: 0x9cb
    // Size: 0x23, Type: dev
    function reset_cmds()
    {
        setdevdvar( @"hash_de86d29dde73df", 0 );
        setdevdvar( @"hash_cc21f65bade3fb07", 0 );
    }

#/
