// scripts\common\intel.gsc  (hash_2097ba89a07c57e4.gscc) (size: 7309 Bytes / 0x1c8d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd75868a5 (3612895397)
// size ...... 7309 (0x1c8d)
// includes .. 4   (offset: 0x1afd)
// strings ... 23  (offset: 0x1b1d)
// dev strs .. 7   (offset: 0x1c39)
// exports ... 22  (offset: 0x1199)
// cseg ...... 0x1cd + 0xfcc (0x1199)
// imports ... 50  (offset: 0x1509)
// animtree1 . 0   (offset: 0x1c8d)
// animtree2 . 0   (offset: 0x1c8d)
#using script_16ea1b94f0f381b3;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;

#namespace intel;

// Namespace intel
// Params 0, eflags: 0x5
// Checksum 0x93d98558, Offset: 0x1eb
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"intel", undefined, &preinit, &function_8e6f42288af40642 );
}

// Namespace intel
// Params 0
// Checksum 0xba82c86, Offset: 0x210
// Size: 0x61
function preinit()
{
    if ( !is_intel_enabled() )
    {
        return;
    }
    
    utility::registersharedfunc( #"intel", #"collect_intel", &collect_intel );
    utility::registersharedfunc( #"intel", #"hash_ae79a668b3bc0aeb", &function_7bdd201f26261cbe );
    scene::function_85b13b837056bc8b( &function_1aec23f3358ebed7 );
    scene::function_53de0775d8452750( &function_6633400a9a724c82 );
}

// Namespace intel
// Params 0
// Checksum 0x490fff54, Offset: 0x279
// Size: 0xc3
function function_1aec23f3358ebed7()
{
    if ( !isdefined( level.var_bb461868542d6ed3 ) )
    {
        return;
    }
    
    foreach ( mdl_intel in level.var_bb461868542d6ed3 )
    {
        if ( mdl_intel utility::function_9f2c41c1dcc8c94( mdl_intel.type, "visible" ) )
        {
            mdl_intel utility::function_7c10ea82c1e305b8( mdl_intel.type, "hidden" );
            mdl_intel.var_f6fb87fac0412713 = 1;
        }
    }
}

// Namespace intel
// Params 0
// Checksum 0x3dd6168, Offset: 0x344
// Size: 0xb3
function function_6633400a9a724c82()
{
    if ( !isdefined( level.var_bb461868542d6ed3 ) )
    {
        return;
    }
    
    foreach ( mdl_intel in level.var_bb461868542d6ed3 )
    {
        if ( mdl_intel.var_f6fb87fac0412713 )
        {
            mdl_intel utility::function_7c10ea82c1e305b8( mdl_intel.type, "visible" );
            mdl_intel.var_f6fb87fac0412713 = undefined;
        }
    }
}

// Namespace intel
// Params 0
// Checksum 0x47db5d45, Offset: 0x3ff
// Size: 0x19e
function function_8e6f42288af40642()
{
    if ( !is_intel_enabled() )
    {
        return;
    }
    
    utility::flag_wait( "scriptables_ready" );
    var_d981cebbe5db0ec0 = level.gametypebundle.inteltag;
    
    if ( !isdefined( var_d981cebbe5db0ec0 ) )
    {
        var_d981cebbe5db0ec0 = "zombie_intel";
    }
    
    level.var_d269a296de42db6b = utility::getstructarray( var_d981cebbe5db0ec0, "script_noteworthy" );
    scriptables = getentitylessscriptablearray( var_d981cebbe5db0ec0, "script_noteworthy" );
    
    foreach ( scriptable in scriptables )
    {
        assert( !scriptable isscriptable(), "<dev string:x24>" );
        assert( scriptable isscriptableinstance(), "<dev string:x7b>" );
        assert( !scriptable getscriptableisreserved(), "<dev string:xc7>" );
        scriptable.script_string = scriptable.type;
    }
    
    level.var_d269a296de42db6b = arraycombine( level.var_d269a296de42db6b, scriptables );
    level.var_1929d52bee550c97 = 0;
    level.var_5e8c1b99eb6194bb = [];
    level.var_bb461868542d6ed3 = [];
    level.var_6a8cdd5424fe2710 = getarraykeys( level.var_b15dba0426867c77 );
    level.var_34153452a8dfb6e2 = level.var_6a8cdd5424fe2710.size;
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_f3b5cabd9ba10c27", &function_facdfefc1c0f0318 );
}

// Namespace intel
// Params 0, eflags: 0x4
// Checksum 0xef326566, Offset: 0x5a5
// Size: 0x1c, Type: bool
function private is_intel_enabled()
{
    if ( level.gametypebundle.enableintel )
    {
        return true;
    }
    
    return false;
}

// Namespace intel
// Params 1, eflags: 0x4
// Checksum 0xe3c38292, Offset: 0x5ca
// Size: 0x13b
function private function_facdfefc1c0f0318( params )
{
    level.var_bb461868542d6ed3 = function_5713d46873b29625( level.var_bb461868542d6ed3 );
    logstring( "====INTEL ITEM SCRIPTABLE SPAWNS" );
    
    foreach ( i, var_9440440b88a2f6fb in level.var_bb461868542d6ed3 )
    {
        if ( isdefined( var_9440440b88a2f6fb.owningplayer ) )
        {
            var_e8871f801a9f5539 = var_9440440b88a2f6fb.owningplayer getentitynumber();
        }
        else
        {
            var_e8871f801a9f5539 = "none";
        }
        
        str_intel_name = var_9440440b88a2f6fb.s_intel.ref ?? var_9440440b88a2f6fb.type;
        logstring( i + " " + str_intel_name + " ($c" + var_9440440b88a2f6fb.index + "): owner entnum " + var_e8871f801a9f5539 );
    }
    
    logstring( "====INTEL ITEM SCRIPTABLE SPAWNS TOTAL: " + level.var_bb461868542d6ed3.size );
}

// Namespace intel
// Params 1, eflags: 0x4
// Checksum 0x76eaa07e, Offset: 0x70d
// Size: 0x373
function private function_c1df74e26817e678( mapname )
{
    level.var_6a1a92d6efc02e19 = [];
    level.var_b15dba0426867c77 = [];
    var_fec0fa8977e5d160 = getscriptbundlenames( #"hash_5fd1077d1e5323f" );
    
    foreach ( var_beb9a551ec550967 in var_fec0fa8977e5d160 )
    {
        var_a47ed4d2752104ce = getscriptbundle( var_beb9a551ec550967 );
        
        foreach ( s_intel_list in var_a47ed4d2752104ce.intellists )
        {
            foreach ( s_intel_entry in s_intel_list.intelentries )
            {
                if ( !isdefined( s_intel_entry.intelentry ) )
                {
                    continue;
                }
                
                s_intel = getscriptbundle( s_intel_entry.intelentry );
                assert( isdefined( s_intel.ref ), "<dev string:x133>" + getxhashsourcename( s_intel_entry.intelentry ) );
                
                if ( !is_in_current_season( s_intel ) )
                {
                    continue;
                }
                
                is_valid_map = 1;
                
                if ( isdefined( s_intel.mapname ) )
                {
                    is_valid_map = s_intel.mapname == mapname;
                    
                    if ( isdefined( s_intel.var_2bb7b345bd283a5 ) )
                    {
                        foreach ( list_entry in s_intel.var_2bb7b345bd283a5 )
                        {
                            if ( list_entry.altmapname == mapname )
                            {
                                is_valid_map = 1;
                                break;
                            }
                        }
                    }
                }
                
                if ( !is_valid_map )
                {
                    continue;
                }
                
                var_b5a21eea1e8f8c07 = utility::getsharedfunc( #"intel", #"hash_f21e61b24dd07f00" );
                
                if ( var_b5a21eea1e8f8c07 )
                {
                    var_f673df30cce7d085 = [[ var_b5a21eea1e8f8c07 ]]( s_intel );
                    
                    if ( var_f673df30cce7d085 )
                    {
                        continue;
                    }
                }
                
                if ( !isdefined( level.var_6a1a92d6efc02e19[ s_intel_list.var_4c8d63ab855aaef6 ] ) )
                {
                    level.var_6a1a92d6efc02e19[ s_intel_list.var_4c8d63ab855aaef6 ] = [];
                }
                
                level.var_6a1a92d6efc02e19[ s_intel_list.var_4c8d63ab855aaef6 ][ getxhash( s_intel.ref ) ] = s_intel;
                level.var_b15dba0426867c77[ getxhash( s_intel.ref ) ] = s_intel;
            }
        }
    }
}

// Namespace intel
// Params 1
// Checksum 0x9791e9f7, Offset: 0xa88
// Size: 0x26, Type: bool
function is_intel_valid( str_intel_name )
{
    return isdefined( str_intel_name ) && arraycontains( level.var_6a8cdd5424fe2710, getxhash( str_intel_name ) );
}

// Namespace intel
// Params 0, eflags: 0x4
// Checksum 0x557a97eb, Offset: 0xab7
// Size: 0x9d
function private function_54b709e97f690761()
{
    var_34153452a8dfb6e2 = 0;
    var_b77051a4f72b5b81 = getarraykeys( level.var_b15dba0426867c77 );
    
    foreach ( str_intel_name in var_b77051a4f72b5b81 )
    {
        if ( player_has_intel( str_intel_name ) )
        {
            var_34153452a8dfb6e2++;
        }
    }
    
    return var_34153452a8dfb6e2;
}

// Namespace intel
// Params 1, eflags: 0x4
// Checksum 0x4ba4adb2, Offset: 0xb5d
// Size: 0x39, Type: bool
function private is_in_current_season( s_intel )
{
    if ( !isdefined( s_intel.season ) || s_intel.season <= level.var_1929d52bee550c97 )
    {
        return true;
    }
    
    return false;
}

// Namespace intel
// Params 1
// Checksum 0xa50f7fa0, Offset: 0xb9f
// Size: 0xa5
function function_26a590a81bb1e5af( player )
{
    if ( player.interactions_disabled )
    {
        return;
    }
    
    switch ( self.s_intel.inteltype )
    {
        case #"audiolog":
            break;
        case #"Document":
            break;
        case #"artifact":
            break;
    }
    
    if ( !isdefined( str_intel_name ) )
    {
        str_intel_name = self.s_intel.ref;
    }
    
    player thread utility::callsharedfunc( #"intel", #"collect_intel", str_intel_name, self );
}

// Namespace intel
// Params 4
// Checksum 0x49b8c49e, Offset: 0xc4c
// Size: 0x30
function collect_intel( str_intel_name, mdl_intel, e_sound_source, b_skip_audio )
{
    assert( 0 );
}

// Namespace intel
// Params 1
// Checksum 0x954de85b, Offset: 0xc84
// Size: 0x77, Type: bool
function player_has_intel( str_intel_name )
{
    assert( isdefined( str_intel_name ), "<dev string:x14b>" );
    
    if ( !is_intel_enabled() )
    {
        return false;
    }
    
    if ( isxhash( str_intel_name ) )
    {
        str_intel_name = level.var_b15dba0426867c77[ str_intel_name ].ref;
    }
    
    if ( function_d402db54cb5bee5c() && utility::callsharedfunc( #"intel", #"get_intel_collected", str_intel_name ) )
    {
        return true;
    }
    
    return false;
}

// Namespace intel
// Params 1
// Checksum 0x9753cf16, Offset: 0xd04
// Size: 0x32
function set_intel_stat( str_intel_name )
{
    if ( function_d402db54cb5bee5c() )
    {
        utility::callsharedfunc( #"intel", #"set_intel_collected", str_intel_name, 1 );
    }
}

// Namespace intel
// Params 0
// Checksum 0xc2380810, Offset: 0xd3e
// Size: 0x24, Type: bool
function function_d402db54cb5bee5c()
{
    if ( level.var_e5411e6e4bed8600 || getdvarint( @"hash_5042b2386a2d3296", 0 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace intel
// Params 1
// Checksum 0xc3cf1f92, Offset: 0xd6b
// Size: 0x2a
function get_intel_list( str_intel_type )
{
    a_s_intel = level.var_6a1a92d6efc02e19[ str_intel_type ] ?? [];
    return a_s_intel;
}

// Namespace intel
// Params 1
// Checksum 0x3153f0f4, Offset: 0xd9e
// Size: 0x105
function function_5ac74c7d9763e7d7( str_intel_type )
{
    if ( isdefined( level.var_a2d1850dcd377888 ) )
    {
        str_intel_name = level.var_a2d1850dcd377888;
        level.var_a2d1850dcd377888 = undefined;
        return str_intel_name;
    }
    
    a_s_intel = get_intel_list( str_intel_type );
    
    if ( !isarray( a_s_intel ) || !a_s_intel.size )
    {
        println( "<dev string:x185>" + getxhashsourcename( str_intel_type ) + "<dev string:x1a4>" );
        return;
    }
    
    foreach ( s_intel in a_s_intel )
    {
        if ( !player_has_intel( s_intel.ref ) )
        {
            return s_intel.ref;
        }
    }
}

// Namespace intel
// Params 1
// Checksum 0xa59ed22d, Offset: 0xeab
// Size: 0xa0, Type: bool
function function_39bf7a56e562b1d4( str_intel_type )
{
    a_s_intel = get_intel_list( str_intel_type );
    
    foreach ( s_intel in a_s_intel )
    {
        if ( !player_has_intel( s_intel.ref ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace intel
// Params 1
// Checksum 0xe9ff5bd2, Offset: 0xf54
// Size: 0x8d, Type: bool
function function_1ba3132f2aafe8cc( str_intel_name )
{
    foreach ( player in level.players )
    {
        if ( !player player_has_intel( str_intel_name ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace intel
// Params 7
// Checksum 0x91025f1b, Offset: 0xfea
// Size: 0x1af
function function_7bdd201f26261cbe( player, intel, map, game_type, playlist_id, playlist_name, matchtime_ms )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    client_uno_id = player getplayerunoid();
    intel_name = isdefined( intel.str_intel_name ) ? getxhash( intel.str_intel_name ) : #"";
    intel_type = intel.s_intel.inteltype ?? #"";
    origin = isdefined( intel.mdl_intel ) ? intel.mdl_intel.origin : player.origin;
    dlog_recordevent( "dlog_event_zm_intel_collected", [ "map", map, "game_type", game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "matchtime_ms", matchtime_ms, "client_uno_id", client_uno_id, "intel_name", intel_name, "intel_type", intel_type, "pos_x", origin[ 0 ], "pos_y", origin[ 1 ], "pos_z", origin[ 2 ] ] );
}

