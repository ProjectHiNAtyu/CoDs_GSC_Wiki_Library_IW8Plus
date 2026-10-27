// scripts\common\system.gsc  (hash_3f51a039c4a1a113.gscc) (size: 4642 Bytes / 0x1222 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc8e93863 (3370727523)
// size ...... 4642 (0x1222)
// includes .. 1   (offset: 0x1166)
// strings ... 4   (offset: 0x116e)
// dev strs .. 8   (offset: 0x11a6)
// exports ... 12  (offset: 0xd4a)
// cseg ...... 0x126 + 0xc24 (0xd4a)
// imports ... 16  (offset: 0xf2a)
// animtree1 . 0   (offset: 0x1222)
// animtree2 . 0   (offset: 0x1222)
#using scripts\common\utility;

#namespace system;

// Namespace system
// Params 5
// Checksum 0x69fb6361, Offset: 0x144
// Size: 0x174
function register( str_name, reqs, func_preinit, func_postinit, var_5c49d92392de0021 = 0 )
{
    print( "<dev string:x24>" + ( isxhash( str_name ) ? getxhashsourcename( str_name ) : str_name ) + "<dev string:x37>" );
    
    if ( !isdefined( level.system_funcs ) )
    {
        level.system_funcs = [];
    }
    
    if ( isdefined( level.system_funcs[ str_name ] ) )
    {
        /#
            if ( !( level.system_funcs[ str_name ].flags & 1 ) )
            {
                system_error( "<dev string:x3a>" + ( isxhash( str_name ) ? getxhashsourcename( str_name ) : str_name ) + "<dev string:x43>" );
            }
        #/
        
        return;
    }
    
    system = { #var_5c49d92392de0021:var_5c49d92392de0021, #flags:0, #reqs:reqs, #postfunc:func_postinit, #prefunc:func_preinit, #systemname:str_name };
    system.flags |= !isdefined( func_preinit ) ? 2 : 0;
    system.flags |= !isdefined( func_postinit ) ? 4 : 0;
    level.system_funcs[ str_name ] = system;
}

// Namespace system
// Params 1
// Checksum 0xfc8e5338, Offset: 0x2c0
// Size: 0x9a
function ignore( str_name )
{
    if ( !isdefined( level.system_funcs[ str_name ] ) )
    {
        register( str_name );
    }
    
    if ( isdefined( level.system_funcs[ str_name ].prefunc ) && level.system_funcs[ str_name ].flags & 2 )
    {
        system_error( "Ignored systems must be set before pre_main begins for that system, use autoexec to ignore immediately without any waits." );
        return;
    }
    
    level.system_funcs[ str_name ].flags |= 1;
}

// Namespace system/event_7b93597c75b40af7
// Params 0, eflags: 0x20
// Checksum 0xb1f2a648, Offset: 0x362
// Size: 0xbd
function event_handler[event_7b93597c75b40af7] function_10e3c751b4555649()
{
    if ( !isdefined( level.system_funcs ) )
    {
        return;
    }
    
    utility::flag_set( "system_preinit_started" );
    
    foreach ( func in level.system_funcs )
    {
        run_pre_systems_internal( func );
        
        if ( !( func.flags & 8 ) )
        {
            thread exec_pre_system( func );
        }
    }
    
    utility::flag_set( "system_preinit_complete" );
}

// Namespace system/init_postmain
// Params 0, eflags: 0x20
// Checksum 0xd1770658, Offset: 0x427
// Size: 0xbb
function event_handler[init_postmain] function_10a47e33bee6ee46()
{
    if ( !isdefined( level.system_funcs ) )
    {
        return;
    }
    
    foreach ( func in level.system_funcs )
    {
        run_post_systems_internal( func );
        
        if ( !( func.flags & 8 ) )
        {
            thread exec_post_system( func );
        }
    }
    
    level.system_funcs = undefined;
    utility::flag_set( "system_postinit_complete" );
}

// Namespace system
// Params 1, eflags: 0x4
// Checksum 0x578ed882, Offset: 0x4ea
// Size: 0x1f7
function private exec_post_system( func )
{
    if ( !isdefined( func ) || func.flags & 1 )
    {
        return;
    }
    
    if ( isdefined( func.reqs ) )
    {
        if ( isarray( func.reqs ) )
        {
            foreach ( req in func.reqs )
            {
                if ( !level.system_funcs[ req ] )
                {
                    continue;
                }
                
                if ( level.system_funcs[ req ].flags & 1 )
                {
                    level.system_funcs[ func.systemname ].flags |= 1;
                    return;
                }
            }
        }
        else if ( level.system_funcs[ req ] )
        {
            if ( level.system_funcs[ func.reqs ].flags & 1 )
            {
                level.system_funcs[ func.systemname ].flags |= 1;
                return;
            }
        }
    }
    
    if ( !( func.flags & 4 ) )
    {
        if ( isdefined( func.reqs ) )
        {
            run_post_systems_internal( func );
        }
        
        func.flags |= 4;
        [[ func.postfunc ]]();
    }
}

// Namespace system
// Params 1, eflags: 0x4
// Checksum 0x7eb4a399, Offset: 0x6e9
// Size: 0x233
function private run_post_systems_internal( func )
{
    /#
        if ( !( func.flags & 2 || func.flags & 1 ) )
        {
            system_error( "<dev string:x3a>" + ( isxhash( func.systemname ) ? getxhashsourcename( func.systemname ) : func.systemname ) + "<dev string:x8b>" );
            func.flags |= 8;
            return;
        }
    #/
    
    if ( isdefined( func.reqs ) )
    {
        if ( isarray( func.reqs ) )
        {
            foreach ( req in func.reqs )
            {
                /#
                    if ( !isdefined( level.system_funcs[ req ] ) )
                    {
                        if ( !func.var_5c49d92392de0021 )
                        {
                            system_error( "<dev string:xf7>" + req + "<dev string:x11d>" );
                            func.flags |= 8;
                        }
                        
                        continue;
                    }
                #/
                
                thread exec_post_system( level.system_funcs[ req ] );
            }
            
            return;
        }
        
        /#
            if ( !isdefined( level.system_funcs[ func.reqs ] ) )
            {
                if ( !func.var_5c49d92392de0021 )
                {
                    system_error( "<dev string:xf7>" + ( isxhash( func.reqs ) ? getxhashsourcename( func.reqs ) : func.reqs ) + "<dev string:x11d>" );
                    func.flags |= 8;
                }
                
                return;
            }
        #/
        
        thread exec_post_system( level.system_funcs[ func.reqs ] );
    }
}

// Namespace system
// Params 1, eflags: 0x4
// Checksum 0x56f6e36e, Offset: 0x924
// Size: 0x200
function private exec_pre_system( func )
{
    if ( !isdefined( func ) || func.flags & 1 )
    {
        return;
    }
    
    if ( isdefined( func.reqs ) )
    {
        if ( isarray( func.reqs ) )
        {
            foreach ( req in func.reqs )
            {
                if ( !level.system_funcs[ req ] )
                {
                    continue;
                }
                
                if ( level.system_funcs[ req ].flags & 1 )
                {
                    level.system_funcs[ func.systemname ].flags |= 1;
                    return;
                }
            }
        }
        else if ( level.system_funcs[ func.reqs ] )
        {
            if ( level.system_funcs[ func.reqs ].flags & 1 )
            {
                level.system_funcs[ func.systemname ].flags |= 1;
                return;
            }
        }
    }
    
    if ( !( func.flags & 2 ) )
    {
        if ( isdefined( func.reqs ) )
        {
            run_pre_systems_internal( func );
        }
        
        [[ func.prefunc ]]();
        func.flags |= 2;
    }
}

// Namespace system
// Params 1, eflags: 0x4
// Checksum 0xa40a3917, Offset: 0xb2c
// Size: 0x1af
function private run_pre_systems_internal( func )
{
    if ( isdefined( func.reqs ) )
    {
        if ( isarray( func.reqs ) )
        {
            foreach ( req in func.reqs )
            {
                /#
                    if ( !isdefined( level.system_funcs[ req ] ) )
                    {
                        if ( !func.var_5c49d92392de0021 )
                        {
                            system_error( "<dev string:xf7>" + req + "<dev string:x11d>" );
                            func.flags |= 8;
                        }
                        
                        continue;
                    }
                #/
                
                thread exec_pre_system( level.system_funcs[ req ] );
            }
            
            return;
        }
        
        /#
            if ( !isdefined( level.system_funcs[ func.reqs ] ) )
            {
                if ( !func.var_5c49d92392de0021 )
                {
                    system_error( "<dev string:xf7>" + ( isxhash( func.reqs ) ? getxhashsourcename( func.reqs ) : func.reqs ) + "<dev string:x11d>" );
                    func.flags |= 8;
                }
                
                return;
            }
        #/
        
        thread exec_pre_system( level.system_funcs[ func.reqs ] );
    }
}

// Namespace system
// Params 0
// Checksum 0x6b24d681, Offset: 0xce3
// Size: 0xf
function function_eca4bddb3f37e51b()
{
    level utility::flag_wait( "system_preinit_complete" );
}

// Namespace system
// Params 0
// Checksum 0x5aae5ae7, Offset: 0xcfa
// Size: 0xf
function function_85885b7687429f06()
{
    level utility::flag_wait( "system_postinit_complete" );
}

// Namespace system
// Params 1
// Checksum 0xbb40df69, Offset: 0xd11
// Size: 0x39
function system_error( msg )
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 0 )
        {
            print( "<dev string:x11f>" + msg );
            return;
        }
    #/
    
    assertmsg( msg );
}

