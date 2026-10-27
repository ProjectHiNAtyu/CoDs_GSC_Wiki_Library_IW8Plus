// scripts\mp\staged_items_debug.gsc  (hash_456285181e58db9f.gscc) (size: 3368 Bytes / 0xd28 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9de048a9 (2648721577)
// size ...... 3368 (0xd28)
// includes .. 3   (offset: 0xbd0)
// strings ... 0   (offset: 0xbe8)
// dev strs .. 25  (offset: 0xbe8)
// exports ... 12  (offset: 0x668)
// cseg ...... 0x58 + 0x610 (0x668)
// imports ... 31  (offset: 0x848)
// animtree1 . 0   (offset: 0xd28)
// animtree2 . 0   (offset: 0xd28)
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace staged_items_debug;

/#

    // Namespace staged_items_debug
    // Params 0, eflags: 0x5
    // Checksum 0xa83c1a6a, Offset: 0x76
    // Size: 0x41, Type: dev
    function private autoexec register_shared_funcs()
    {
        utility::registersharedfunc( #"staged_items_debug", #"init_debug", &init_debug );
        utility::registersharedfunc( #"staged_items_debug", #"hash_3cb77d76691c1485", &function_9b515861da4008e7 );
    }

    // Namespace staged_items_debug
    // Params 0, eflags: 0x4
    // Checksum 0xbdbefdad, Offset: 0xbf
    // Size: 0xd, Type: dev
    function private function_9b515861da4008e7()
    {
        level thread function_11b44476f516508e();
    }

    // Namespace staged_items_debug
    // Params 0
    // Checksum 0x6d1ce971, Offset: 0xd4
    // Size: 0x5a, Type: dev
    function init_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x35>", "<dev string:x43>", &function_6513f4dd475502d3 );
        devgui::add_devgui_func( "<dev string:x65>", "<dev string:x7e>", &function_728420d33d5e4f47 );
        devgui::add_devgui_func( "<dev string:x9c>", "<dev string:xb3>", &function_d6e2a13c6d40e7d0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace staged_items_debug
    // Params 0
    // Checksum 0xbbc40ede, Offset: 0x136
    // Size: 0x88, Type: dev
    function function_11b44476f516508e()
    {
        level endon( #"game_ended" );
        level.var_8887cc996f44515e = utility::getstructarray( "<dev string:xd2>", "<dev string:xde>" );
        level.var_478e2a05269c0d46 = getdvarint( @"hash_3df94caabfcf1e0f", 0 );
        
        if ( !level.var_478e2a05269c0d46 )
        {
            return;
        }
        
        level waittill( #"prematch_over" );
        player = level.players[ 0 ];
        player waittill( #"infil_landing_done" );
        function_8510a394ddc71353();
    }

    // Namespace staged_items_debug
    // Params 0
    // Checksum 0xb7c72391, Offset: 0x1c6
    // Size: 0x68, Type: dev
    function function_6513f4dd475502d3()
    {
        if ( level.var_ce8c61b1e73fca09 )
        {
            level.var_ce8c61b1e73fca09 = undefined;
            level notify( #"hash_2b53473cbfa48743" );
            printtoscreen2d( 400, 300, "<dev string:xf0>", ( 1, 0, 0 ), 1, 15 );
            return;
        }
        
        level.var_478e2a05269c0d46 = getdvarint( @"hash_3df94caabfcf1e0f", 12 );
        function_8510a394ddc71353();
    }

    // Namespace staged_items_debug
    // Params 0
    // Checksum 0x3da29dcf, Offset: 0x236
    // Size: 0x53, Type: dev
    function function_8510a394ddc71353()
    {
        level.var_ce8c61b1e73fca09 = 1;
        var_5b2cf4681042f093 = level.var_8887cc996f44515e;
        
        if ( var_5b2cf4681042f093 && var_5b2cf4681042f093.size > 0 )
        {
            player = level.players[ 0 ];
            player thread function_23e6caa34b343d91( player, var_5b2cf4681042f093 );
        }
    }

    // Namespace staged_items_debug
    // Params 2
    // Checksum 0x6479a77c, Offset: 0x291
    // Size: 0x1a1, Type: dev
    function function_23e6caa34b343d91( player, var_5b2cf4681042f093 )
    {
        level endon( #"game_ended" );
        level endon( #"hash_2b53473cbfa48743" );
        player notifyonplayercommand( "<dev string:x108>", "<dev string:x119>" );
        player notifyonplayercommand( "<dev string:x123>", "<dev string:x134>" );
        index = level.var_61d0756f81cd345d ?? 0;
        
        while ( true )
        {
            item = var_5b2cf4681042f093[ index ];
            groundpos = getgroundposition( item.origin, 25 );
            destination = ( groundpos ?? item.origin ) + ( 0, 0, 35 );
            label = item.script_parameters ?? "<dev string:x13e>";
            player setorigin( destination );
            printtoscreen2d( 400, 300, "<dev string:x156>" + index + 1 + "<dev string:x158>" + var_5b2cf4681042f093.size + "<dev string:x15a>" + label, ( 1, 1, 1 ), 1, 15 );
            thread function_b57158b4a9ec3002( player, item.origin );
            player notify( #"hash_fc4856e05253cf68" );
            thread function_34aa6ee7f6d6e8aa( player );
            input = player utility::waittill_any_return( "<dev string:x108>", "<dev string:x123>", "<dev string:x15d>" );
            
            if ( input == "<dev string:x123>" )
            {
                index = ( index - 1 + var_5b2cf4681042f093.size ) % var_5b2cf4681042f093.size;
            }
            else
            {
                index = ( index + 1 ) % var_5b2cf4681042f093.size;
            }
            
            level.var_61d0756f81cd345d = index;
        }
    }

    // Namespace staged_items_debug
    // Params 1
    // Checksum 0xb52fd871, Offset: 0x43a
    // Size: 0x4b, Type: dev
    function function_34aa6ee7f6d6e8aa( player )
    {
        level endon( #"game_ended" );
        level endon( #"hash_2b53473cbfa48743" );
        player endon( #"hash_fc4856e05253cf68" );
        wait level.var_478e2a05269c0d46;
        player notify( #"time_elapsed" );
    }

    // Namespace staged_items_debug
    // Params 2
    // Checksum 0x8dfd43bf, Offset: 0x48d
    // Size: 0x70, Type: dev
    function function_b57158b4a9ec3002( player, itemorigin )
    {
        player endon( #"hash_4a83a99ca6755702" );
        player endon( #"hash_d05dbb547f23bbd6" );
        player endon( #"time_elapsed" );
        level endon( #"hash_2b53473cbfa48743" );
        
        while ( true )
        {
            debug::line( player, itemorigin, ( 1, 0, 0 ), 0.1 );
            waitframe();
        }
    }

    // Namespace staged_items_debug
    // Params 0
    // Checksum 0x8f17bb6a, Offset: 0x505
    // Size: 0x135, Type: dev
    function function_728420d33d5e4f47()
    {
        currentweapon = level.players[ 0 ] getcurrentweapon();
        
        if ( !isweapon( currentweapon ) )
        {
            return;
        }
        
        camo = getweaponcamoname( currentweapon ) ?? "<dev string:x16a>";
        default_attachments = getweapondefaultattachments( currentweapon );
        var_9dfeb02640d0aaea = currentweapon.basename + "<dev string:x174>" + camo;
        
        foreach ( attachment in currentweapon.attachments )
        {
            attachmententry = attachment;
            
            if ( arraycontains( default_attachments, attachment ) )
            {
                attachmententry = "<dev string:x176>" + attachmententry;
            }
            
            var_9dfeb02640d0aaea = var_9dfeb02640d0aaea + "<dev string:x174>" + attachmententry;
        }
        
        filenum = openfile( "<dev string:x17f>", "<dev string:x192>" );
        fprintln( filenum, var_9dfeb02640d0aaea );
        closefile( filenum );
    }

    // Namespace staged_items_debug
    // Params 0
    // Checksum 0x1d5e34c8, Offset: 0x642
    // Size: 0x26, Type: dev
    function function_d6e2a13c6d40e7d0()
    {
        filenum = openfile( "<dev string:x17f>", "<dev string:x199>" );
        closefile( filenum );
    }

#/
