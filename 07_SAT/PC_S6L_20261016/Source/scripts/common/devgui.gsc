// scripts\common\devgui.gsc  (hash_38eb8f4be20d54f4.gscc) (size: 6533 Bytes / 0x1985 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3039094a (809044298)
// size ...... 6533 (0x1985)
// includes .. 2   (offset: 0x17d9)
// strings ... 6   (offset: 0x17e9)
// dev strs .. 23  (offset: 0x1831)
// exports ... 21  (offset: 0xee9)
// cseg ...... 0x9e + 0xe4b (0xee9)
// imports ... 46  (offset: 0x1231)
// animtree1 . 0   (offset: 0x1985)
// animtree2 . 0   (offset: 0x1985)
#using scripts\common\trace;
#using scripts\common\utility;

#namespace devgui;

/#

    // Namespace devgui
    // Params 0
    // Checksum 0x136641f3, Offset: 0xbc
    // Size: 0x8b, Type: dev
    function init_devgui()
    {
        if ( getdvarint( @"scr_devgui_enabled", 1 ) != 1 )
        {
            level.devguidisabled = 1;
            return;
        }
        
        if ( !isdefined( level.devgui_cmd_funcs ) )
        {
            level.devgui_cmd_funcs = [];
        }
        
        if ( !isdefined( level.devgui_cmd_funcs_tokens ) )
        {
            level.devgui_cmd_funcs_tokens = [];
        }
        
        if ( !isdefined( level.devgui_threads ) )
        {
            level.devgui_threads = [];
        }
        
        level notify( #"monitor_devgui_start" );
        level thread monitor_devgui();
        setdevdvarifuninitialized( @"hash_81d89e4abec64203", 0 );
    }

#/

// Namespace devgui
// Params 0
// Checksum 0xa4d3614, Offset: 0x14f
// Size: 0xc, Type: bool
function is_enabled()
{
    return !level.devguidisabled;
}

// Namespace devgui
// Params 0
// Checksum 0x1911ff14, Offset: 0x164
// Size: 0x214
function add_debug_command_process()
{
    if ( !is_enabled() )
    {
        return;
    }
    
    if ( level.add_debug_command_process_running )
    {
        return;
    }
    
    if ( level.add_debug_command_process.size == 0 )
    {
        return;
    }
    
    level.add_debug_command_process_running = 1;
    
    if ( !utility::issp() && !level.var_83627dbb3a5731b5 )
    {
        level utility::flag_wait( "onStartGameTypeFinished" );
    }
    
    if ( getdvarint( @"hash_a16da1867b1c0848", 0 ) == 1 )
    {
        while ( !isdefined( level.players.size ) || level.players.size < getdvarint( @"hash_6ad5a8e0d95c5aa4", 1 ) )
        {
            waitframe();
        }
    }
    else
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
    }
    
    for ( i = 0; i < level.add_debug_command_process.size ; i++ )
    {
        cmd = level.add_debug_command_process[ i ];
        cmd += "\n";
        
        while ( !adddebugcommand( cmd ) )
        {
            waitframe();
        }
        
        if ( getdvarint( @"hash_a16da1867b1c0848", 0 ) == 1 && utility::issharedfuncdefined( #"devgui", #"hash_4977958f159a16fc", 0 ) && utility::callsharedfunc( #"game", #"isdedicatedserver" ) )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player ) )
                {
                    while ( !utility::callsharedfunc( #"devgui", #"hash_4977958f159a16fc", player, cmd ) )
                    {
                        wait 1;
                        
                        if ( !isdefined( player ) )
                        {
                            break;
                        }
                    }
                }
            }
            
            if ( i % 10 == 0 )
            {
                waitframe();
            }
        }
    }
    
    level.add_debug_command_process_running = undefined;
    level.add_debug_command_process = undefined;
}

// Namespace devgui
// Params 1
// Checksum 0x467f48cd, Offset: 0x380
// Size: 0x4b
function add_debug_command( cmd )
{
    if ( !is_enabled() )
    {
        return;
    }
    
    if ( !isdefined( level.add_debug_command_process ) )
    {
        level.add_debug_command_process = [];
    }
    
    level.add_debug_command_process[ level.add_debug_command_process.size ] = cmd;
    thread add_debug_command_process();
}

// Namespace devgui
// Params 3
// Checksum 0x1e0ec6b7, Offset: 0x3d3
// Size: 0xce
function add_devgui_command( path, cmd, index )
{
    if ( !is_enabled() )
    {
        return;
    }
    
    if ( !isdefined( index ) )
    {
        assert( isdefined( level.var_900614a0226892b7 ) );
        index = level.var_900614a0226892b7.index;
        level.var_900614a0226892b7.index++;
    }
    
    if ( isdefined( level.var_900614a0226892b7 ) && isdefined( level.var_900614a0226892b7.base_path ) )
    {
        path = level.var_900614a0226892b7.base_path + path;
    }
    
    thread add_debug_command( "devgui_cmd \"" + path + ":" + index + "\" \"" + cmd + "\" all\n" );
}

/#

    // Namespace devgui
    // Params 5
    // Checksum 0xcca5868b, Offset: 0x4a9
    // Size: 0x11b, Type: dev
    function add_devgui_func( path, name, func, toggle, index )
    {
        if ( !is_enabled() )
        {
            return;
        }
        
        if ( !isdefined( index ) )
        {
            assert( isdefined( level.var_900614a0226892b7 ) );
            index = level.var_900614a0226892b7.index;
            level.var_900614a0226892b7.index++;
        }
        
        if ( isdefined( level.var_900614a0226892b7 ) && isdefined( level.var_900614a0226892b7.base_path ) )
        {
            path = level.var_900614a0226892b7.base_path + path;
        }
        
        name = utility::string_replace( name, "<dev string:x24>", "<dev string:x26>", 100 );
        thread add_debug_command( "<dev string:x28>" + path + "<dev string:x35>" + index + "<dev string:x37>" + "<dev string:x41>" + "<dev string:x24>" + name + "<dev string:x50>" );
        level.devgui_cmd_funcs[ name ] = create_cmd( func, toggle );
    }

    // Namespace devgui
    // Params 3
    // Checksum 0x36e3b6da, Offset: 0x5cc
    // Size: 0xe2, Type: dev
    function add_devgui_dvar( path, dvar, index )
    {
        if ( !is_enabled() )
        {
            return;
        }
        
        if ( !isdefined( index ) )
        {
            assert( isdefined( level.var_900614a0226892b7 ) );
            index = level.var_900614a0226892b7.index;
            level.var_900614a0226892b7.index++;
        }
        
        if ( isdefined( level.var_900614a0226892b7 ) && isdefined( level.var_900614a0226892b7.base_path ) )
        {
            path = level.var_900614a0226892b7.base_path + path;
        }
        
        if ( isxhashdvar( dvar ) )
        {
            dvar = getxhashsourcename( dvar );
        }
        
        thread add_debug_command( "<dev string:x53>" + path + "<dev string:x35>" + index + "<dev string:x61>" + dvar + "<dev string:x64>" );
    }

    // Namespace devgui
    // Params 3
    // Checksum 0xf17de18, Offset: 0x6b6
    // Size: 0xdd, Type: dev
    function function_eaac4ba4b3caf621( path, dvar_xhash, index )
    {
        if ( !is_enabled() )
        {
            return;
        }
        
        if ( !isdefined( index ) )
        {
            assert( isdefined( level.var_900614a0226892b7 ) );
            index = level.var_900614a0226892b7.index;
            level.var_900614a0226892b7.index++;
        }
        
        if ( isdefined( level.var_900614a0226892b7 ) && isdefined( level.var_900614a0226892b7.base_path ) )
        {
            path = level.var_900614a0226892b7.base_path + path;
        }
        
        setdevdvarifuninitialized( dvar_xhash, 0 );
        thread add_debug_command( "<dev string:x28>" + path + "<dev string:x35>" + index + "<dev string:x66>" + getxhashsourcename( dvar_xhash ) + "<dev string:x72>" );
    }

    // Namespace devgui
    // Params 5
    // Checksum 0x64379311, Offset: 0x79b
    // Size: 0x152, Type: dev
    function function_cd4e263c1f3018ae( path, name_with_params, func, toggle, index )
    {
        if ( !is_enabled() )
        {
            return;
        }
        
        name_with_params = utility::string_replace( name_with_params, "<dev string:x24>", "<dev string:x26>", 100 );
        params = strtok( name_with_params, "<dev string:x79>" );
        name = params[ 0 ];
        params[ 0 ] = undefined;
        
        if ( isint( 0 ) )
        {
            function_cdc669dbc8ea2101( params );
        }
        
        if ( !isdefined( index ) )
        {
            assert( isdefined( level.var_900614a0226892b7 ) );
            index = level.var_900614a0226892b7.index;
            level.var_900614a0226892b7.index++;
        }
        
        if ( isdefined( level.var_900614a0226892b7 ) && isdefined( level.var_900614a0226892b7.base_path ) )
        {
            path = level.var_900614a0226892b7.base_path + path;
        }
        
        thread add_debug_command( "<dev string:x28>" + path + "<dev string:x35>" + index + "<dev string:x37>" + "<dev string:x41>" + "<dev string:x24>" + name_with_params + "<dev string:x50>" );
        level.devgui_cmd_funcs_tokens[ name ] = create_cmd( func, toggle );
    }

#/

// Namespace devgui
// Params 1
// Checksum 0xc822840a, Offset: 0x8f5
// Size: 0x95
function function_9082edeb5db93280( base_path )
{
    if ( !is_enabled() )
    {
        return;
    }
    
    assert( !isdefined( level.var_900614a0226892b7 ), "<dev string:x7b>" );
    
    if ( isdefined( level.var_900614a0226892b7 ) )
    {
        assertmsg( "<dev string:xb2>" + level.var_900614a0226892b7.base_path );
    }
    
    level.var_900614a0226892b7 = spawnstruct();
    level.var_900614a0226892b7.index = 0;
    level.var_900614a0226892b7.base_path = base_path;
}

// Namespace devgui
// Params 0
// Checksum 0xbde7bf72, Offset: 0x992
// Size: 0x29
function function_77df7fe7dd273e10()
{
    if ( !is_enabled() )
    {
        return;
    }
    
    assert( isdefined( level.var_900614a0226892b7 ) );
    level.var_900614a0226892b7 = undefined;
}

/#

    // Namespace devgui
    // Params 0
    // Checksum 0x7665a41e, Offset: 0x9c3
    // Size: 0xae, Type: dev
    function function_97024c0a6d1256a6()
    {
        if ( !is_enabled() )
        {
            return;
        }
        
        player = level.players[ 0 ];
        player_forward = anglestoforward( player getplayerangles() );
        result = trace::ray_trace( player geteye(), player geteye() + player_forward * 10000 );
        
        if ( isdefined( result[ "<dev string:xd8>" ] ) && result[ "<dev string:xe1>" ] < 1 )
        {
            new_pos = utility::drop_to_ground( result[ "<dev string:xd8>" ] + -1 * player_forward * 32, 24, -300 ) + ( 0, 0, 16 );
            return new_pos;
        }
        
        return;
    }

    // Namespace devgui
    // Params 1
    // Checksum 0x78ecd55e, Offset: 0xa79
    // Size: 0x73, Type: dev
    function function_847216deb449a506( params )
    {
        if ( !is_enabled() )
        {
            return;
        }
        
        model = params[ 0 ];
        spawn_location = function_97024c0a6d1256a6();
        spawn_z_offset = getdvarfloat( @"hash_2ae4e76b04454913", 0 );
        spawned_object = spawn( "<dev string:xea>", spawn_location + ( 0, 0, spawn_z_offset ) );
        spawned_object setmodel( model );
    }

    // Namespace devgui
    // Params 2
    // Checksum 0x5df97c3a, Offset: 0xaf4
    // Size: 0x4e, Type: dev
    function function_3f8a26ec96988e80( dvar, dvar_hash )
    {
        if ( !is_enabled() )
        {
            return;
        }
        
        iprintlnbold( "<dev string:xf7>" + dvar + "<dev string:xff>" + !getdvarint( dvar_hash, 0 ) );
        setdvar( dvar_hash, !getdvarint( dvar_hash, 0 ) );
    }

    // Namespace devgui
    // Params 1
    // Checksum 0xa0ab6d93, Offset: 0xb4a
    // Size: 0x3a, Type: dev
    function is_toggle_thread_active( name )
    {
        if ( !is_enabled() )
        {
            return;
        }
        
        return isdefined( self ) && isdefined( self.devgui_threads ) && isdefined( self.devgui_threads[ name ] );
    }

    // Namespace devgui
    // Params 3
    // Checksum 0x743a8900, Offset: 0xb8c
    // Size: 0xd0, Type: dev
    function toggle_thread( name, func, params )
    {
        if ( !is_enabled() )
        {
            return;
        }
        
        if ( !isdefined( self.devgui_threads ) )
        {
            self.devgui_threads = [];
        }
        
        if ( is_toggle_thread_active( name ) )
        {
            self.devgui_threads[ name ] notify( #"hash_62084ea0f9f3850e" );
            self.devgui_threads[ name ] = undefined;
            return;
        }
        
        self.devgui_threads[ name ] = spawnstruct();
        self.devgui_threads[ name ] endon( #"hash_62084ea0f9f3850e" );
        self.devgui_threads[ name ] endon( #"death" );
        
        if ( isdefined( params ) )
        {
            [[ func ]]( params );
        }
        else
        {
            [[ func ]]();
        }
        
        self.devgui_threads[ name ] = undefined;
    }

    // Namespace devgui
    // Params 1
    // Checksum 0xe7ca3639, Offset: 0xc64
    // Size: 0x6b, Type: dev
    function remove_devgui_menu( path )
    {
        if ( !is_enabled() )
        {
            return;
        }
        
        if ( isdefined( level.var_900614a0226892b7 ) && isdefined( level.var_900614a0226892b7.base_path ) )
        {
            path = level.var_900614a0226892b7.base_path + path;
        }
        
        thread add_debug_command( "<dev string:x102>" + path + "<dev string:x64>" );
    }

    // Namespace devgui
    // Params 2
    // Checksum 0xf29a7464, Offset: 0xcd7
    // Size: 0x4e, Type: dev
    function remove_devgui_dvar( path, dvar )
    {
        if ( !is_enabled() )
        {
            return;
        }
        
        assert( isxhashdvar( dvar ), "<dev string:x112>" );
        deregisterdvar( dvar );
        dvar = getxhashsourcename( dvar );
        thread remove_devgui_menu( path );
    }

    // Namespace devgui
    // Params 0, eflags: 0x4
    // Checksum 0x8163162b, Offset: 0xd2d
    // Size: 0x16c, Type: dev
    function private monitor_devgui()
    {
        level endon( #"game_ended" );
        level endon( #"monitor_devgui_start" );
        
        while ( true )
        {
            waitframe();
            name = getdvar( @"scr_devgui_cmd" );
            
            if ( name == "<dev string:x178>" )
            {
                continue;
            }
            
            setdvar( @"scr_devgui_cmd", "<dev string:x178>" );
            
            if ( isdefined( level.devgui_cmd_funcs[ name ] ) )
            {
                if ( level.devgui_cmd_funcs[ name ].toggle )
                {
                    level thread toggle_thread( name, level.devgui_cmd_funcs[ name ].func );
                }
                else
                {
                    thread [[ level.devgui_cmd_funcs[ name ].func ]]();
                }
                
                continue;
            }
            
            tokens = strtok( name, "<dev string:x79>" );
            name = tokens[ 0 ];
            params = arraycopy( tokens );
            params[ 0 ] = undefined;
            
            if ( isint( 0 ) )
            {
                function_cdc669dbc8ea2101( params );
            }
            
            if ( isdefined( level.devgui_cmd_funcs_tokens[ name ] ) )
            {
                if ( level.devgui_cmd_funcs_tokens[ name ].toggle )
                {
                    level thread toggle_thread( name, level.devgui_cmd_funcs_tokens[ name ].func, params );
                    continue;
                }
                
                thread [[ level.devgui_cmd_funcs_tokens[ name ].func ]]( params );
            }
        }
    }

    // Namespace devgui
    // Params 2, eflags: 0x4
    // Checksum 0x2e74e415, Offset: 0xea1
    // Size: 0x48, Type: dev
    function private create_cmd( func, toggle )
    {
        cmd = spawnstruct();
        cmd.func = func;
        cmd.toggle = istrue( toggle );
        return cmd;
    }

#/
