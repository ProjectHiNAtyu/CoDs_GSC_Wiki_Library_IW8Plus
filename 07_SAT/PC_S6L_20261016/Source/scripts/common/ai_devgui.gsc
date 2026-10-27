// scripts\common\ai_devgui.gsc  (hash_25fcb5afc6976419.gscc) (size: 2906 Bytes / 0xb5a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf02d9184 (4029518212)
// size ...... 2906 (0xb5a)
// includes .. 3   (offset: 0xa76)
// strings ... 0   (offset: 0xa8e)
// dev strs .. 17  (offset: 0xa8e)
// exports ... 7   (offset: 0x5fa)
// cseg ...... 0x58 + 0x5a2 (0x5fa)
// imports ... 28  (offset: 0x712)
// animtree1 . 0   (offset: 0xb5a)
// animtree2 . 0   (offset: 0xb5a)
#using scripts\common\ai;
#using scripts\common\devgui;
#using scripts\common\values;

#namespace ai_devgui;

/#

    // Namespace ai_devgui
    // Params 0
    // Checksum 0x4240dd5d, Offset: 0x76
    // Size: 0x9b, Type: dev
    function init_ai_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x2d>", "<dev string:x36>", &kill_all_ai );
        devgui::add_devgui_func( "<dev string:x42>", "<dev string:x51>", &force_kill_all_ai );
        devgui::add_devgui_func( "<dev string:x63>", "<dev string:x75>", &function_20e54edc2a0ad21d );
        devgui::add_devgui_func( "<dev string:x8a>", "<dev string:xaf>", &function_6487b728b6717a29 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xd4>" );
        devgui::add_devgui_func( "<dev string:xe9>", "<dev string:x104>", &function_1223bd166ba7a0e6, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ai_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x91b37978, Offset: 0x119
    // Size: 0x9c, Type: dev
    function private kill_all_ai()
    {
        all_ai = getaiarray();
        
        foreach ( ai in all_ai )
        {
            if ( isalive( ai ) && !ai.magic_bullet_shield )
            {
                ai kill();
            }
        }
    }

    // Namespace ai_devgui
    // Params 0, eflags: 0x4
    // Checksum 0xd0b29823, Offset: 0x1bd
    // Size: 0xbf, Type: dev
    function private force_kill_all_ai()
    {
        all_ai = getaiarray();
        
        foreach ( ai in all_ai )
        {
            if ( isalive( ai ) )
            {
                if ( ai.magic_bullet_shield )
                {
                    ai ai::stop_magic_bullet_shield();
                }
                
                ai val::nuke( "<dev string:x11e>" );
                ai val::nuke( "<dev string:x12b>" );
                ai kill();
            }
        }
    }

    // Namespace ai_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x6c9f7098, Offset: 0x284
    // Size: 0x1a8, Type: dev
    function private function_20e54edc2a0ad21d()
    {
        ai_enabled = getdvarint( @"ai_enabled" );
        all_ai = getaiarray();
        
        if ( ai_enabled == 0 )
        {
            setsaveddvar( @"ai_enabled", 1 );
            
            foreach ( ai in all_ai )
            {
                if ( isdefined( ai ) && isdefined( ai.animplaybackrateoriginal ) )
                {
                    ai.animplaybackratedefault = ai.animplaybackrateoriginal;
                    ai.animplaybackrateoriginal = undefined;
                    ai restartanim( ai getnormalizedanimtime() );
                }
            }
            
            return;
        }
        
        setsaveddvar( @"ai_enabled", 0 );
        
        foreach ( ai in all_ai )
        {
            if ( isdefined( ai ) )
            {
                if ( !isdefined( ai.animplaybackrateoriginal ) )
                {
                    ai.animplaybackrateoriginal = ai.animplaybackratedefault;
                }
                
                ai.animplaybackratedefault = 1e-06;
                ai restartanim( ai getnormalizedanimtime() );
            }
        }
    }

    // Namespace ai_devgui
    // Params 0, eflags: 0x4
    // Checksum 0xf458ac6d, Offset: 0x434
    // Size: 0x1a, Type: dev
    function private function_6487b728b6717a29()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x139>", @"hash_f90ace673a710be7" );
    }

    // Namespace ai_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x74e5427f, Offset: 0x456
    // Size: 0x1a4, Type: dev
    function private function_1223bd166ba7a0e6()
    {
        if ( !areanynavvolumesloaded() )
        {
            iprintlnbold( "<dev string:x15a>" );
            return;
        }
        
        iprintlnbold( "<dev string:x17f>" );
        player = level.players[ 0 ];
        
        while ( true )
        {
            waitframe();
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            forward = anglestoforward( player getplayerangles() );
            startpos = player.origin + ( 0, 0, 36 ) + forward * 64;
            endpos = player.origin + ( 0, 0, 36 ) + forward * 800;
            startsnapped = getclosestpointonnavmesh3d( startpos );
            endsnapped = getclosestpointonnavmesh3d( endpos );
            
            if ( !isdefined( startsnapped ) || !isdefined( endsnapped ) )
            {
                continue;
            }
            
            sphere( startsnapped, 8, ( 0, 1, 0 ) );
            sphere( endsnapped, 8, ( 0, 1, 0 ) );
            pathpts = findpath3d( startsnapped, endsnapped );
            
            if ( isdefined( pathpts ) && pathpts.size > 0 )
            {
                line( startsnapped, pathpts[ 0 ], ( 0, 0, 1 ), 1 );
                
                for ( i = 1; i < pathpts.size ; i++ )
                {
                    sphere( pathpts[ i - 1 ], 6, ( 1, 1, 0 ) );
                    line( pathpts[ i - 1 ], pathpts[ i ], ( 0, 0, 1 ), 1 );
                }
            }
        }
    }

#/
