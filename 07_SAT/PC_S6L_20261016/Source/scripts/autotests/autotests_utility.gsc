// scripts\autotests\autotests_utility.gsc  (hash_4c67f790177c4d64.gscc) (size: 7613 Bytes / 0x1dbd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3cf5676 (2748274294)
// size ...... 7613 (0x1dbd)
// includes .. 3   (offset: 0x1ca5)
// strings ... 17  (offset: 0x1cbd)
// dev strs .. 3   (offset: 0x1d99)
// exports ... 37  (offset: 0x1159)
// cseg ...... 0x13e + 0x101b (0x1159)
// imports ... 46  (offset: 0x1721)
// animtree1 . 0   (offset: 0x1dbd)
// animtree2 . 0   (offset: 0x1dbd)
#using scripts\autotests\autotests;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace autotests_utility;

// Namespace autotests_utility
// Params 4
// Checksum 0x4b316214, Offset: 0x15c
// Size: 0xa3
function setup( disableai = 1, forcestart = 1, kickbots = 1, shutdowngulag = 0 )
{
    if ( utility::issharedfuncdefined( #"autotest", #"setup" ) )
    {
        params = { #shutdowngulag:shutdowngulag };
        utility::callsharedfunc( #"autotest", #"setup", params );
    }
    
    setup_internal( disableai, forcestart, kickbots );
}

// Namespace autotests_utility
// Params 3, eflags: 0x4
// Checksum 0xd64f4dc9, Offset: 0x207
// Size: 0x80
function private setup_internal( disableai = 1, forcestart = 1, kickbots = 1 )
{
    autotests::set_dvar( @"hash_5fdf364fef6ac4d0", disableai );
    
    if ( kickbots )
    {
        kick_all_bots();
    }
    
    if ( forcestart )
    {
        autotests::set_dvar( @"br_minplayers", 1 );
        autotests::set_dvar( @"live_lobby_minplayers_start", 1 );
    }
}

// Namespace autotests_utility
// Params 1
// Checksum 0x123c459d, Offset: 0x28f
// Size: 0x9f
function function_ecdb840c49382ae5( bundle )
{
    if ( !issubstr( bundle.var_4d6e7e3028a81906, "Base Positions" ) )
    {
        return;
    }
    
    if ( bundle.var_52c16279149a0065 )
    {
        level.autotests.test_runtime.standbyposition = autotests::get_struct_location( bundle.var_52c16279149a0065 );
    }
    
    if ( bundle.var_a8f94423d23cf0c0 )
    {
        level.autotests.test_runtime.testposition = autotests::get_struct_location( bundle.var_a8f94423d23cf0c0 );
    }
}

// Namespace autotests_utility
// Params 0
// Checksum 0x2b1444ac, Offset: 0x336
// Size: 0x52
function kick_all_bots()
{
    for ( index = level.players.size - 1; index >= 0 ; index-- )
    {
        player = level.players[ index ];
        
        if ( isbot( player ) )
        {
            kick( player getentitynumber() );
        }
    }
}

// Namespace autotests_utility
// Params 3
// Checksum 0x37e6fbb, Offset: 0x390
// Size: 0x8b
function stringtovec3( input, default_value = ( 0, 0, 0 ), delim = "," )
{
    output = default_value;
    
    if ( isstring( input ) )
    {
        values = strtok( input, delim );
        
        if ( values.size == 3 )
        {
            output = ( float( values[ 0 ] ), float( values[ 1 ] ), float( values[ 2 ] ) );
        }
    }
    
    return output;
}

// Namespace autotests_utility
// Params 0
// Checksum 0xf75bb53b, Offset: 0x424
// Size: 0x64
function function_8ea000c274f2063e()
{
    autotests::set_dvar( @"hash_28dfd17294380da3", 0 );
    autotests::set_dvar( @"hash_d391034358a8f258", 60 );
    new_timeout = 1800;
    current_timeout = getdvarint( @"hash_9e49766c62b3af0d" );
    
    if ( new_timeout > current_timeout )
    {
        autotests::set_dvar( @"hash_9e49766c62b3af0d", new_timeout );
    }
}

// Namespace autotests_utility
// Params 0
// Checksum 0x9582eba4, Offset: 0x490
// Size: 0x57
function function_4cd42a15157be748()
{
    if ( utility::callsharedfunc( #"game_utility", #"hash_c7bd2494f8cf6f3c" ) )
    {
        level waittill( #"game_ended" );
        println( "<dev string:x24>" );
        wait 3;
        return;
    }
    
    level waittill( #"exitlevel_called" );
    println( "<dev string:x3f>" );
}

// Namespace autotests_utility
// Params 0
// Checksum 0x36c0ffb6, Offset: 0x4ef
// Size: 0x3d
function cleanup()
{
    if ( utility::issharedfuncdefined( #"autotest", #"cleanup" ) )
    {
        utility::callsharedfunc( #"autotest", #"cleanup" );
    }
    
    cleanup_internal();
}

// Namespace autotests_utility
// Params 0, eflags: 0x4
// Checksum 0x78dabcfb, Offset: 0x534
// Size: 0x2
function private cleanup_internal()
{
    
}

// Namespace autotests_utility
// Params 1
// Checksum 0x40b0bbca, Offset: 0x53e
// Size: 0x108
function test_prematch_done( waitforloadout = 1 )
{
    timems = 65000;
    starttime = gettime();
    var_43bde23ee7ce4df3 = 0;
    isbr = isbrgamemode();
    
    while ( true )
    {
        if ( !isbr && utility::callsharedfunc( #"game", #"hash_cc3439d8b0f2281f", "prematch_done" ) )
        {
            return 0;
        }
        
        if ( utility::callsharedfunc( #"game", #"hash_cc3439d8b0f2281f", "prematch_fade_done" ) )
        {
            if ( isbr && var_43bde23ee7ce4df3 && waitforloadout )
            {
                self waittill( #"naked_spawn" );
                
                while ( true )
                {
                    self waittill( #"weapon_change" );
                    
                    if ( self.primaryweaponobj == self getcurrentweapon() )
                    {
                        while ( self isswitchingweapon() )
                        {
                            waitframe();
                        }
                        
                        return 0;
                    }
                }
            }
            
            return 0;
        }
        else
        {
            var_43bde23ee7ce4df3 = 1;
        }
        
        if ( gettime() >= starttime + timems )
        {
            return 1;
        }
        
        waitframe();
    }
}

// Namespace autotests_utility
// Params 1
// Checksum 0x468b8768, Offset: 0x64e
// Size: 0x35
function change_camera( ent )
{
    if ( getdvarint( @"hash_9f93161692afe33b", 0 ) )
    {
        return;
    }
    
    if ( isautopilot( ent ) )
    {
        return;
    }
    
    self cameralinkto( ent, "tag_camera" );
}

// Namespace autotests_utility
// Params 0
// Checksum 0xd4074dcd, Offset: 0x68b
// Size: 0x8
function reset_camera()
{
    self cameraunlink();
}

// Namespace autotests_utility
// Params 2
// Checksum 0x7c6a17d0, Offset: 0x69b
// Size: 0x4c
function flag_set( flag_name, setter )
{
    level.autotests.test_runtime.flags[ flag_name ] = 1;
    
    if ( isdefined( setter ) )
    {
        level notify( flag_name, setter );
        return;
    }
    
    level notify( flag_name );
}

// Namespace autotests_utility
// Params 1
// Checksum 0xb9531ce3, Offset: 0x6ef
// Size: 0x4a
function flag( flag_name )
{
    assert( isdefined( flag_name ), "<dev string:x60>" );
    flag = level.autotests.test_runtime.flags[ flag_name ];
    return flag;
}

// Namespace autotests_utility
// Params 1
// Checksum 0xe6d5b39a, Offset: 0x742
// Size: 0x21
function flag_wait( flag_name )
{
    while ( !flag( flag_name ) )
    {
        level waittill( flag_name );
    }
}

// Namespace autotests_utility
// Params 2
// Checksum 0x69086b2a, Offset: 0x76b
// Size: 0x68
function flag_wait_or_timeout( flag_name, timeout )
{
    self endon( #"death_or_disconnect" );
    timeout_struct = function_3d2fae7d92f1546b();
    timeout_struct childthread utility::timeout_struct( timeout );
    timeout_struct childthread flag_wait_flag_set( flag_name );
    msg = timeout_struct flag_catch();
    timeout_struct notify( #"die" );
    return msg;
}

// Namespace autotests_utility
// Params 1, eflags: 0x4
// Checksum 0x981b2b84, Offset: 0x7dc
// Size: 0x4f
function private flag_wait_flag_set( flag_name )
{
    self endon( #"die" );
    self.flag_count++;
    
    while ( !flag( flag_name ) )
    {
        level waittill( flag_name );
    }
    
    self.flag_count--;
    self notify( #"returned", flag_name );
}

// Namespace autotests_utility
// Params 0, eflags: 0x4
// Checksum 0x41229553, Offset: 0x833
// Size: 0x3a
function private flag_catch()
{
    while ( self.flag_count )
    {
        self waittill( #"returned", msg );
        
        if ( msg == "timeout" )
        {
            break;
        }
    }
    
    return msg;
}

// Namespace autotests_utility
// Params 1, eflags: 0x4
// Checksum 0xc56b1f21, Offset: 0x876
// Size: 0x47
function private function_8ae9af3a16b26288( total_flags )
{
    while ( self.flag_count == total_flags )
    {
        self waittill( #"returned", msg );
        
        if ( msg == "timeout" )
        {
            break;
        }
    }
    
    return msg;
}

// Namespace autotests_utility
// Params 2
// Checksum 0x4e771bc6, Offset: 0x8c6
// Size: 0xd2
function flag_wait_any_or_timeout( flag_names, timeout )
{
    self endon( #"death_or_disconnect" );
    timeout_struct = function_3d2fae7d92f1546b();
    timeout_struct childthread utility::timeout_struct( timeout );
    
    foreach ( flag_name in flag_names )
    {
        timeout_struct childthread flag_wait_flag_set( flag_name );
    }
    
    msg = timeout_struct function_8ae9af3a16b26288( flag_names.size );
    timeout_struct notify( #"die" );
    return msg;
}

// Namespace autotests_utility
// Params 2
// Checksum 0xa1257322, Offset: 0x9a1
// Size: 0xd5, Type: bool
function flag_wait_all_or_timeout( flag_names, timeout )
{
    self endon( #"death_or_disconnect" );
    timeout_struct = function_3d2fae7d92f1546b();
    timeout_struct childthread utility::timeout_struct( timeout );
    
    foreach ( flag_name in flag_names )
    {
        timeout_struct childthread flag_wait_flag_set( flag_name );
    }
    
    msg = timeout_struct flag_catch();
    timeout_struct notify( #"die" );
    return msg != "timeout";
}

// Namespace autotests_utility
// Params 2
// Checksum 0x240592a4, Offset: 0xa7f
// Size: 0x2f
function function_4104f641c0755805( event, flag_name )
{
    callback::add( event, &function_f72e44a6ac199022, { #flag_name:flag_name } );
}

// Namespace autotests_utility
// Params 2, eflags: 0x4
// Checksum 0x651cf0ea, Offset: 0xab6
// Size: 0x27
function private function_f72e44a6ac199022( params, additionalparams )
{
    flag_set( additionalparams.flag_name );
}

// Namespace autotests_utility
// Params 2
// Checksum 0x284bc14, Offset: 0xae5
// Size: 0x2f
function flag_remove_callback( event, flag_name )
{
    callback::remove( event, &function_f72e44a6ac199022, { #flag_name:flag_name } );
}

// Namespace autotests_utility
// Params 1
// Checksum 0xb2a38b02, Offset: 0xb1c
// Size: 0x40
function flag_clear( flag_name )
{
    if ( !flag( flag_name ) )
    {
        return;
    }
    
    level.autotests.test_runtime.flags[ flag_name ] = 0;
    level notify( flag_name );
}

// Namespace autotests_utility
// Params 0
// Checksum 0x89dd7454, Offset: 0xb64
// Size: 0xb9
function flag_clear_all()
{
    flags = level.autotests.test_runtime.flags;
    
    foreach ( flag, value in flags )
    {
        level.autotests.test_runtime.flags[ flag ] = 0;
        level notify( flag );
    }
}

// Namespace autotests_utility
// Params 1
// Checksum 0x2fc3735, Offset: 0xc25
// Size: 0x2c
function flag_remove( message )
{
    level.autotests.test_runtime.flag[ message ] = undefined;
}

// Namespace autotests_utility
// Params 0
// Checksum 0x21c9176b, Offset: 0xc59
// Size: 0x1f
function flag_remove_all()
{
    level.autotests.test_runtime.flags = undefined;
}

// Namespace autotests_utility
// Params 0, eflags: 0x4
// Checksum 0xfc8a4fc0, Offset: 0xc80
// Size: 0xd
function private function_3d2fae7d92f1546b()
{
    return { #flag_count:0 };
}

// Namespace autotests_utility
// Params 3
// Checksum 0x4c935ef2, Offset: 0xc96
// Size: 0x41
function function_4fdc6ff85bd47c9( list, item, count )
{
    for ( i = 0; i < count ; i++ )
    {
        list[ list.size ] = item;
    }
    
    return list;
}

// Namespace autotests_utility
// Params 3
// Checksum 0xfb481a62, Offset: 0xce0
// Size: 0xa8
function function_ed3ac0ff940c72d8( destlist, srclist, count )
{
    foreach ( item in srclist )
    {
        for ( i = 0; i < count ; i++ )
        {
            destlist[ destlist.size ] = item;
        }
    }
    
    return destlist;
}

// Namespace autotests_utility
// Params 1
// Checksum 0x61c85699, Offset: 0xd91
// Size: 0x36
function function_78cce6d4dbd203c0( position )
{
    groundposition = utility::drop_to_ground( position );
    return groundposition ? ( position[ 0 ], position[ 1 ], groundposition[ 2 ] ) : position;
}

// Namespace autotests_utility
// Params 6
// Checksum 0xe753a16, Offset: 0xdd0
// Size: 0x163
function function_fc09add23c4398c1( type, index = 0, var_9292b7847e9b76ba, var_957b819b3863d7c = 1, var_e58c3fa6d542fad8, group )
{
    count = 0;
    projectstring = function_2da7d4694fda2fdd() + "_";
    
    foreach ( weaponref, weaponstruct in level.weaponmapdata )
    {
        if ( weaponref == var_9292b7847e9b76ba )
        {
            continue;
        }
        
        if ( var_957b819b3863d7c && weaponstruct.uihidden )
        {
            continue;
        }
        
        if ( !var_e58c3fa6d542fad8 && !issubstr( weaponref, projectstring ) )
        {
            continue;
        }
        
        if ( group && weaponstruct.group != group )
        {
            continue;
        }
        
        if ( issubstr( weaponref, "_" + type + "_" ) )
        {
            if ( count == index )
            {
                return [ weaponref, weaponstruct.assetname ];
            }
            
            count++;
        }
    }
}

// Namespace autotests_utility
// Params 0
// Checksum 0x8894ed0a, Offset: 0xf3b
// Size: 0x54
function function_2da7d4694fda2fdd()
{
    projectname = tolower( getprojectname() );
    
    if ( projectname == "wz2" )
    {
        projectname = "t10";
    }
    else if ( projectname == "saw" )
    {
        projectname = "sat";
    }
    else if ( projectname == "REW" )
    {
        projectname = "rex";
    }
    
    return projectname;
}

// Namespace autotests_utility
// Params 3
// Checksum 0xca7ebb8e, Offset: 0xf98
// Size: 0xca
function function_8354eb3723f722f4( bundlelist, itemrefs, var_79e8034b4c51c735 )
{
    foreach ( bundle in bundlelist )
    {
        if ( !function_16e4b52e47772eb5( bundle, var_79e8034b4c51c735 ) )
        {
            continue;
        }
        
        if ( bundle.killstreakref )
        {
            itemrefs[ itemrefs.size ] = bundle.killstreakref;
            continue;
        }
        
        itemrefs[ itemrefs.size ] = bundle.ref;
    }
}

// Namespace autotests_utility
// Params 2
// Checksum 0xa6466f4d, Offset: 0x106a
// Size: 0xef
function function_16e4b52e47772eb5( bundle, var_79e8034b4c51c735 )
{
    if ( !isdefined( bundle ) )
    {
        return 0;
    }
    
    switch ( var_79e8034b4c51c735 )
    {
        case 0:
            var_96e979086fe947a9 = bundle.bundle ?? bundle;
            return ( var_96e979086fe947a9.testinglevel != "None" );
        case 1:
            var_96e979086fe947a9 = bundle.bundle ?? bundle;
            return ( !isdefined( var_96e979086fe947a9.testinglevel ) || var_96e979086fe947a9.testinglevel == "All" );
        default:
            var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Unhandled testingLevel enum value " + var_79e8034b4c51c735, 0, "scripts/autotests/autotests_utility.gsc", 630 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            break;
    }
}

