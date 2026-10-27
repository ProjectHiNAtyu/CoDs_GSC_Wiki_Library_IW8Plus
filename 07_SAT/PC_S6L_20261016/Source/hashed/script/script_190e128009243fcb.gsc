// script_190e128009243fcb  (hash_190e128009243fcb.gscc) (size: 14531 Bytes / 0x38c3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf559bd63 (4116299107)
// size ...... 14531 (0x38c3)
// includes .. 9   (offset: 0x3563)
// strings ... 16  (offset: 0x35ab)
// dev strs .. 46  (offset: 0x367f)
// exports ... 42  (offset: 0x2253)
// cseg ...... 0x148 + 0x210b (0x2253)
// imports ... 99  (offset: 0x28e3)
// animtree1 . 0   (offset: 0x38c3)
// animtree2 . 0   (offset: 0x38c3)
#using script_16ea1b94f0f381b3;
#using script_56d586e1114dd388;
#using script_5cda26b07ee216bf;
#using script_67ffbe87dc9436fa;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_weyward_summon_stinger;

// Namespace zombie_weyward_summon_stinger
// Params 0
// Checksum 0xedb50506, Offset: 0x166
// Size: 0x13
function function_fa0b98206a382d06()
{
    function_782016accf2a0761();
    
    /#
        function_c3c055594b5012e7();
    #/
}

// Namespace zombie_weyward_summon_stinger
// Params 0
// Checksum 0xb3f52288, Offset: 0x181
// Size: 0xe
function cancel_summon_stingers()
{
    self notify( #"summon_stingers_cancelled" );
}

// Namespace zombie_weyward_summon_stinger
// Params 0
// Checksum 0x20c78865, Offset: 0x197
// Size: 0x2c9
function init_zombie_weyward_summon_stinger()
{
    self.summon_stingers = [];
    self.var_df5ab04f8f7f36d3 = 0;
    self.var_c0e8b84193f6520a = 0;
    self.var_eb9512e8109a7a12 = 0;
    self.var_ec3ea362b0eab751 = 0;
    self.stingers_empowered = 0;
    thread function_3f683d754f9e75f();
    thread function_2b54c4befaefb179();
    callback::add( "new_weyward_phase", &function_43b62d71e174c50d );
    function_6a1df65d2e6cf5e5();
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_cfd675b386613abe = settings.var_d51b62a54a76cba ?? 4;
    self.summon_spawn_delay = settings.var_b6651cc2e9e64e0f ?? 0.1;
    self.summon_cooldown_s = settings.summoncooldown ?? 15;
    self.summon_spawn_dist = settings.var_f720631762162550 ?? 80;
    self.var_541fc4c17e2c260d = settings.var_4cabb64e6c1e2396 ?? 300;
    self.var_93443979802798ca = settings.var_ec7d8314e547112a ?? 1;
    self.var_fbd12e414c61609d = settings.var_f3a80a392b77bc9a ?? 0;
    self.var_d8a2716437e66cda = [];
    self.var_2ae118be4ccb86b3 = [];
    self.var_2ae118be4ccb86b3[ 2 ] = [];
    self.var_2ae118be4ccb86b3[ 2 ][ 1 ] = settings.var_9f75fbb0ac3254f ?? 8;
    self.var_2ae118be4ccb86b3[ 2 ][ 2 ] = settings.var_9f760bb0ac32782 ?? 8;
    self.var_2ae118be4ccb86b3[ 2 ][ 3 ] = settings.var_9f761bb0ac329b5 ?? 8;
    self.var_2ae118be4ccb86b3[ 2 ][ 4 ] = settings.var_9f75abb0ac31a50 ?? 10;
    self.var_2ae118be4ccb86b3[ 2 ][ 5 ] = settings.var_9f75bbb0ac31c83 ?? 10;
    self.var_2ae118be4ccb86b3[ 3 ] = [];
    self.var_2ae118be4ccb86b3[ 3 ][ 1 ] = settings.var_6a4a9a3a3fa87752 ?? 8;
    self.var_2ae118be4ccb86b3[ 3 ][ 2 ] = settings.var_6a4a993a3fa8751f ?? 8;
    self.var_2ae118be4ccb86b3[ 3 ][ 3 ] = settings.var_6a4a983a3fa872ec ?? 8;
    self.var_2ae118be4ccb86b3[ 3 ][ 4 ] = settings.var_6a4a973a3fa870b9 ?? 9;
    self.var_28d8aba3737a394f = [];
    self.var_28d8aba3737a394f[ 2 ] = settings.var_cb7036c8156d3e9 ?? 4;
    self.var_28d8aba3737a394f[ 3 ] = settings.var_c8c56ed21430a0ca ?? 4;
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0x89fa7b9d, Offset: 0x468
// Size: 0xc6
function private function_782016accf2a0761()
{
    level.var_7c15bf56925abe38 = [];
    var_c6961af56721e8db = 0;
    
    for ( phase_num = 1; phase_num <= 3 ; phase_num++ )
    {
        phase_structs = utility::getstructarray( "phase_" + phase_num, "targetname" );
        
        if ( !phase_structs.size )
        {
            continue;
        }
        
        pattern_sets = function_9bfdf7bf0f1396c1( phase_structs );
        
        if ( !pattern_sets.size )
        {
            continue;
        }
        
        level.var_7c15bf56925abe38[ phase_num ] = pattern_sets;
        var_c6961af56721e8db += pattern_sets.size;
    }
    
    /#
        if ( var_c6961af56721e8db > 0 )
        {
            println( "<dev string:x24>" + var_c6961af56721e8db + "<dev string:x43>" + level.var_7c15bf56925abe38.size + "<dev string:x59>" );
            return;
        }
        
        println( "<dev string:x63>" );
    #/
}

// Namespace zombie_weyward_summon_stinger
// Params 1, eflags: 0x4
// Checksum 0x87511667, Offset: 0x536
// Size: 0x13a
function private function_9bfdf7bf0f1396c1( phase_structs )
{
    var_e246c8bfbfecdd0e = [];
    var_e2d7cf7ac97dc3ce = 0;
    
    foreach ( pat_struct in phase_structs )
    {
        pattern_num = pat_struct.groupid;
        pattern_num = int( strtok( pattern_num, "_" )[ 1 ] );
        
        if ( !pattern_num )
        {
            println( "<dev string:xc9>" + pat_struct.groupid + "<dev string:x103>" + pat_struct.origin );
            continue;
        }
        
        if ( !var_e246c8bfbfecdd0e[ pattern_num ] )
        {
            var_e246c8bfbfecdd0e[ pattern_num ] = [];
        }
        
        var_e246c8bfbfecdd0e[ pattern_num ][ var_e246c8bfbfecdd0e[ pattern_num ].size ] = pat_struct;
        var_e2d7cf7ac97dc3ce = max( var_e2d7cf7ac97dc3ce, pattern_num );
    }
    
    pattern_sets = [];
    
    for ( pattern_num = 1; pattern_num <= var_e2d7cf7ac97dc3ce ; pattern_num++ )
    {
        if ( var_e246c8bfbfecdd0e[ pattern_num ] )
        {
            pattern_sets[ pattern_sets.size ] = var_e246c8bfbfecdd0e[ pattern_num ];
        }
    }
    
    return pattern_sets;
}

// Namespace zombie_weyward_summon_stinger
// Params 1, eflags: 0x4
// Checksum 0x615dedfa, Offset: 0x679
// Size: 0x2e
function private function_6a560353b541eef1( phase_num )
{
    pattern_sets = level.var_7c15bf56925abe38[ phase_num ];
    
    if ( !pattern_sets )
    {
        return [];
    }
    
    return pattern_sets;
}

// Namespace zombie_weyward_summon_stinger
// Params 2
// Checksum 0xe1b3fc92, Offset: 0x6b0
// Size: 0x10c
function function_3f9c13f46df1f303( taskid, params )
{
    assert( isalive( self ) && isai( self ) );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return anim.failure;
    }
    
    if ( zombie_stun::is_stunned() )
    {
        return anim.failure;
    }
    
    if ( !getdvarint( @"hash_39dc9763981a8d6c", self.var_93443979802798ca ) )
    {
        return anim.failure;
    }
    
    if ( !zombie_weyward_shadow_soul::function_56db8ae62fa6ec66( 2 ) )
    {
        return anim.failure;
    }
    
    if ( namespace_f8b8d50b63bcec41::function_36394163e6e2ab8d() )
    {
        return anim.running;
    }
    
    if ( !function_f0d74d5b3f8df4b8() )
    {
        return anim.failure;
    }
    
    if ( !isalive( self.enemy ) && !self getaiblackboarddynamic( "no_enemies_detected" ) )
    {
        return anim.failure;
    }
    
    if ( self.wipe_attack_active )
    {
        return anim.failure;
    }
    
    namespace_f8b8d50b63bcec41::function_623484f9e2ef43f6();
    return anim.success;
}

// Namespace zombie_weyward_summon_stinger
// Params 0
// Checksum 0xb56488e5, Offset: 0x7c5
// Size: 0xb
function function_1e8ea900b7d3d48f()
{
    return self.var_eb9512e8109a7a12;
}

// Namespace zombie_weyward_summon_stinger
// Params 3
// Checksum 0x27e38acb, Offset: 0x7d9
// Size: 0x2a6
function function_7522313fe70458eb( start_pos, end_pos, var_7f34180df115288 )
{
    if ( self.wipe_attack_active )
    {
        return;
    }
    
    seg = ( end_pos[ 0 ] - start_pos[ 0 ], end_pos[ 1 ] - start_pos[ 1 ], 0 );
    seg_len = length( seg );
    
    if ( seg_len <= 0 )
    {
        return;
    }
    
    seg_dir = vectornormalize( seg );
    
    /#
        if ( function_a621dc93b2fa8228() )
        {
            function_409800e23a68edf8( start_pos, end_pos, seg_dir, seg_len, var_7f34180df115288 );
        }
    #/
    
    foreach ( stinger in self.summon_stingers )
    {
        if ( !isalive( stinger ) )
        {
            continue;
        }
        
        to_stinger = ( stinger.origin[ 0 ] - start_pos[ 0 ], stinger.origin[ 1 ] - start_pos[ 1 ], 0 );
        along_path = vectordot( to_stinger, seg_dir );
        
        if ( along_path < 0 || along_path > seg_len )
        {
            /#
                if ( function_a621dc93b2fa8228() )
                {
                    print3d( stinger.origin + ( 0, 0, 40 ), "<dev string:x109>" + int( along_path ) + "<dev string:x110>", ( 1, 0, 0 ) );
                }
            #/
            
            continue;
        }
        
        var_8b69ebbd466a77c7 = length( to_stinger - seg_dir * along_path );
        
        if ( var_8b69ebbd466a77c7 > var_7f34180df115288 )
        {
            /#
                if ( function_a621dc93b2fa8228() )
                {
                    print3d( stinger.origin + ( 0, 0, 40 ), "<dev string:x120>" + int( var_8b69ebbd466a77c7 ) + "<dev string:x126>" + int( var_7f34180df115288 ) + "<dev string:x137>", ( 1, 0.5, 0 ) );
                }
            #/
            
            continue;
        }
        
        stinger.var_30b5e6fc9ca7628e = 1;
        stinger zombie_weyward_stinger::start_stinger_retract();
        
        /#
            if ( function_a621dc93b2fa8228() )
            {
                sphere( stinger.origin, 20, ( 0, 1, 0 ), 0, 1000 );
                print3d( stinger.origin + ( 0, 0, 40 ), "<dev string:x139>" + int( along_path ) + "<dev string:x14c>" + int( var_8b69ebbd466a77c7 ) + "<dev string:x137>", ( 0, 1, 0 ) );
            }
        #/
    }
}

/#

    // Namespace zombie_weyward_summon_stinger
    // Params 5, eflags: 0x4
    // Checksum 0xd0f331ac, Offset: 0xa87
    // Size: 0x167, Type: dev
    function private function_409800e23a68edf8( start_pos, end_pos, seg_dir, seg_len, var_7f34180df115288 )
    {
        perp_dir = ( seg_dir[ 1 ] * -1, seg_dir[ 0 ], 0 );
        var_4f853fcbcf44e4ca = start_pos + perp_dir * var_7f34180df115288;
        var_2a40e0063f47037 = start_pos - perp_dir * var_7f34180df115288;
        end_left = end_pos + perp_dir * var_7f34180df115288;
        end_right = end_pos - perp_dir * var_7f34180df115288;
        line( start_pos, end_pos, ( 1, 1, 0 ), 1, 0, 1000 );
        line( var_4f853fcbcf44e4ca, end_left, ( 1, 0.5, 0 ), 1, 0, 1000 );
        line( var_2a40e0063f47037, end_right, ( 1, 0.5, 0 ), 1, 0, 1000 );
        line( var_4f853fcbcf44e4ca, var_2a40e0063f47037, ( 1, 0.5, 0 ), 1, 0, 1000 );
        line( end_left, end_right, ( 1, 0.5, 0 ), 1, 0, 1000 );
        var_b1074c004b513429 = ( start_pos + end_pos ) * 0.5;
        print3d( var_b1074c004b513429 + ( 0, 0, 20 ), "<dev string:x153>" + int( seg_len ) + "<dev string:x166>" + int( var_7f34180df115288 ) + "<dev string:x137>", ( 1, 1, 0 ) );
    }

#/

// Namespace zombie_weyward_summon_stinger
// Params 0
// Checksum 0xe01fc63b, Offset: 0xbf6
// Size: 0x26a
function function_7a2184f90f6cd2aa()
{
    if ( function_a2f36b31ab851b8b() )
    {
        function_7bfb468e97fae75f();
        return;
    }
    
    max_stingers = getdvarint( @"hash_3c3ba4efc542cb40", self.var_cfd675b386613abe );
    var_389c73dfbab4500a = getdvarfloat( @"hash_af5238193585d48", self.summon_spawn_dist );
    var_b1ac6b8c12a5ac75 = getdvarfloat( @"hash_ccea94395aebb6bb", self.var_541fc4c17e2c260d );
    players = [];
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            players[ players.size ] = player;
        }
    }
    
    if ( !players.size )
    {
        return;
    }
    
    var_679bf6a58c8c4384 = min( players.size, max_stingers );
    overflow_count = max_stingers - var_679bf6a58c8c4384;
    
    for ( i = 0; i < var_679bf6a58c8c4384 ; i++ )
    {
        player = players[ i ];
        forward = anglestoforward( player.angles );
        target_pos = player.origin + forward * var_389c73dfbab4500a;
        nav_trace = navtrace( player.origin, target_pos, self, 1 );
        spawn_pos = nav_trace[ "position" ];
        thread spawn_stinger( spawn_pos, vectortoangles( player.origin - spawn_pos ), 1 );
    }
    
    if ( overflow_count > 0 )
    {
        angle_step = 360 / overflow_count;
        
        for ( overflow_index = 0; overflow_index < overflow_count ; overflow_index++ )
        {
            player = players[ overflow_index % players.size ];
            angle = angle_step * overflow_index;
            target_pos = player.origin + ( cos( angle ) * var_b1ac6b8c12a5ac75, sin( angle ) * var_b1ac6b8c12a5ac75, 0 );
            nav_trace = navtrace( player.origin, target_pos, self, 1 );
            spawn_pos = nav_trace[ "position" ];
            thread spawn_stinger( spawn_pos, vectortoangles( player.origin - spawn_pos ), 1 );
            waitframe();
        }
    }
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0xb91695ba, Offset: 0xe68
// Size: 0x3b, Type: bool
function private function_a2f36b31ab851b8b()
{
    if ( !getdvarint( @"hash_2242dba082fac317", self.var_fbd12e414c61609d ) )
    {
        return false;
    }
    
    var_abbebdb114e4f57f = zombie_weyward_shadow_soul::get_weyward_phase();
    return function_6a560353b541eef1( var_abbebdb114e4f57f ).size > 0;
}

// Namespace zombie_weyward_summon_stinger
// Params 1, eflags: 0x4
// Checksum 0x57a22319, Offset: 0xeac
// Size: 0xd3
function private function_2f927ee429d6877f( origin )
{
    var_fbcdacbc86c740d4 = undefined;
    nearest_dist_sq = undefined;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        dist_sq = distancesquared( origin, player.origin );
        
        if ( !isdefined( var_fbcdacbc86c740d4 ) || dist_sq < nearest_dist_sq )
        {
            var_fbcdacbc86c740d4 = player;
            nearest_dist_sq = dist_sq;
        }
    }
    
    return var_fbcdacbc86c740d4;
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0x9f4e20c1, Offset: 0xf88
// Size: 0x96
function private function_3cace6628fd3ac43()
{
    foreach ( stinger in self.summon_stingers )
    {
        if ( isalive( stinger ) )
        {
            stinger kill( self.origin, self );
        }
    }
    
    self.summon_stingers = [];
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0xd717196c, Offset: 0x1026
// Size: 0x1eb
function private function_7bfb468e97fae75f()
{
    var_abbebdb114e4f57f = zombie_weyward_shadow_soul::get_weyward_phase();
    pattern_sets = function_6a560353b541eef1( var_abbebdb114e4f57f );
    
    if ( !pattern_sets.size )
    {
        return;
    }
    
    function_3cace6628fd3ac43();
    var_be2c380a1a7ab094 = self.var_d8a2716437e66cda[ var_abbebdb114e4f57f ];
    pattern_index = function_5fb3b04df6896dde( pattern_sets.size, var_be2c380a1a7ab094 );
    pattern_structs = pattern_sets[ pattern_index ];
    pattern_structs = function_dac7b0f94d063de0( pattern_structs, var_abbebdb114e4f57f );
    self.var_c0e8b84193f6520a = pattern_structs.size;
    var_d2dea1eb5c269d79 = getdvarfloat( @"hash_326fcdcf6cc48c7", self.summon_spawn_delay );
    
    foreach ( pat_struct in pattern_structs )
    {
        var_b2d3fdd84b0be01c = function_2f927ee429d6877f( pat_struct.origin );
        
        if ( var_b2d3fdd84b0be01c )
        {
            dir_to_player = var_b2d3fdd84b0be01c.origin - pat_struct.origin;
            spawn_angles = vectortoangles( dir_to_player );
        }
        else
        {
            spawn_angles = ( 0, 0, 0 );
        }
        
        thread spawn_stinger( pat_struct.origin, spawn_angles );
        wait var_d2dea1eb5c269d79;
    }
    
    self.var_d8a2716437e66cda[ var_abbebdb114e4f57f ] = pattern_index;
    thread zombie_weyward_shadow_soul::function_d80fa2e6b8d59763( self.var_496ad46884d3a847, self.var_4493c9d11fb7a3ea );
    
    /#
        if ( function_a621dc93b2fa8228() )
        {
            println( "<dev string:x173>" + var_abbebdb114e4f57f + "<dev string:x192>" + pattern_index + 1 + "<dev string:x1a4>" + pattern_sets.size + "<dev string:x1a6>" + pattern_structs.size + "<dev string:x1a9>" );
        }
    #/
}

// Namespace zombie_weyward_summon_stinger
// Params 2, eflags: 0x4
// Checksum 0x1277c45a, Offset: 0x1219
// Size: 0x113
function private function_dac7b0f94d063de0( pattern_structs, phase_num )
{
    base_counts = self.var_2ae118be4ccb86b3[ phase_num ];
    
    if ( !base_counts )
    {
        return pattern_structs;
    }
    
    pattern_num = int( strtok( pattern_structs[ 0 ].groupid, "_" )[ 1 ] );
    base_count = base_counts[ pattern_num ];
    
    if ( !base_count )
    {
        return pattern_structs;
    }
    
    stinger_count = base_count;
    
    if ( level.players.size > 1 )
    {
        stinger_count += function_f20c6bdf3454bfab( phase_num );
    }
    
    stinger_count = clamp( stinger_count, 1, pattern_structs.size );
    
    /#
        if ( function_a621dc93b2fa8228() )
        {
            println( "<dev string:x173>" + phase_num + "<dev string:x1b4>" + pattern_num + "<dev string:x1be>" + stinger_count + "<dev string:x1a4>" + pattern_structs.size + "<dev string:x1c6>" + base_count + "<dev string:x1d7>" + level.players.size + "<dev string:x1da>" );
        }
    #/
    
    if ( stinger_count >= pattern_structs.size )
    {
        return pattern_structs;
    }
    
    return utility::array_random_slice( pattern_structs, stinger_count );
}

// Namespace zombie_weyward_summon_stinger
// Params 1, eflags: 0x4
// Checksum 0x9e9386eb, Offset: 0x1335
// Size: 0x68
function private function_f20c6bdf3454bfab( phase_num )
{
    mp_increase = self.var_28d8aba3737a394f[ phase_num ];
    
    switch ( phase_num )
    {
        case 2:
            return getdvarint( @"hash_7bca50cbe7c7685e", mp_increase );
        case 3:
            return getdvarint( @"hash_c26efe1faf1611fd", mp_increase );
    }
    
    return mp_increase;
}

// Namespace zombie_weyward_summon_stinger
// Params 2, eflags: 0x4
// Checksum 0x78d8125, Offset: 0x13a6
// Size: 0x4e
function private function_5fb3b04df6896dde( count, last_index )
{
    if ( count <= 1 )
    {
        return 0;
    }
    
    if ( !isdefined( last_index ) )
    {
        return randomint( count );
    }
    
    index = randomint( count - 1 );
    
    if ( index >= last_index )
    {
        index++;
    }
    
    return index;
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0x9c72585b, Offset: 0x13fd
// Size: 0x65, Type: bool
function private function_f0d74d5b3f8df4b8()
{
    cooldown = getdvarfloat( @"hash_1b27a9a261968733", self.summon_cooldown_s ) * 1000;
    current_time = gettime();
    
    if ( self.var_df5ab04f8f7f36d3 > 0 )
    {
        var_cc8f8e7d2ce57f7 = current_time - self.var_df5ab04f8f7f36d3;
        
        if ( var_cc8f8e7d2ce57f7 < cooldown )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0x4fe1ff1a, Offset: 0x146b
// Size: 0x2f
function private function_7dc10cb20f83f1ba()
{
    self endon( #"death" );
    self endon( #"hash_85d1febbf9d105aa" );
    
    while ( true )
    {
        function_2fd9a4cfa0746cac();
        wait 0.5;
    }
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0x10793a9, Offset: 0x14a2
// Size: 0xb6
function private function_2fd9a4cfa0746cac()
{
    if ( !self.var_c0e8b84193f6520a )
    {
        self.var_eb9512e8109a7a12 = 0;
        return;
    }
    
    var_85488894d604da5b = 0;
    
    foreach ( stinger in self.summon_stingers )
    {
        if ( isalive( stinger ) )
        {
            var_85488894d604da5b++;
        }
    }
    
    self.var_eb9512e8109a7a12 = var_85488894d604da5b / self.var_c0e8b84193f6520a;
}

// Namespace zombie_weyward_summon_stinger
// Params 1, eflags: 0x4
// Checksum 0x545ca5ec, Offset: 0x1560
// Size: 0x13
function private function_43b62d71e174c50d( params )
{
    function_6a1df65d2e6cf5e5();
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0xbcb227ec, Offset: 0x157b
// Size: 0x26
function private function_6a1df65d2e6cf5e5()
{
    if ( zombie_weyward_shadow_soul::function_56db8ae62fa6ec66( 2 ) && function_a2f36b31ab851b8b() )
    {
        function_5785a58eb8e085c5();
        return;
    }
    
    function_1b97114026d7abcd();
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0x4ca3ff4c, Offset: 0x15a9
// Size: 0x21
function private function_5785a58eb8e085c5()
{
    if ( self.var_ec3ea362b0eab751 )
    {
        return;
    }
    
    self.var_ec3ea362b0eab751 = 1;
    thread function_7dc10cb20f83f1ba();
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0x39363186, Offset: 0x15d2
// Size: 0x2e
function private function_1b97114026d7abcd()
{
    if ( self.var_ec3ea362b0eab751 )
    {
        self.var_ec3ea362b0eab751 = 0;
        self notify( #"hash_85d1febbf9d105aa" );
    }
    
    self.var_eb9512e8109a7a12 = 0;
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0xc2c9fb92, Offset: 0x1608
// Size: 0x2a
function private function_3f683d754f9e75f()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"summon_stingers_notetrack" );
        thread run_summon_stingers();
    }
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0x81787ada, Offset: 0x163a
// Size: 0x1ce
function private run_summon_stingers()
{
    self endon( #"death" );
    self endon( #"summon_stingers_cancelled" );
    self.var_df5ab04f8f7f36d3 = gettime();
    
    if ( function_a2f36b31ab851b8b() )
    {
        function_7bfb468e97fae75f();
        return;
    }
    
    var_d2dea1eb5c269d79 = getdvarfloat( @"hash_326fcdcf6cc48c7", self.summon_spawn_delay );
    var_389c73dfbab4500a = getdvarfloat( @"hash_af5238193585d48", self.summon_spawn_dist );
    enemies = self function_f017e352a29a57a1( self.origin, 2600, 1 );
    
    foreach ( enemy in enemies )
    {
        if ( !isplayer( enemy ) || !isalive( enemy ) )
        {
            continue;
        }
        
        forward = anglestoforward( enemy.angles );
        target_pos = enemy.origin + forward * var_389c73dfbab4500a;
        nav_trace = navtrace( enemy.origin, target_pos, self, 1 );
        spawn_pos = nav_trace[ "position" ];
        dir_to_player = enemy.origin - spawn_pos;
        spawn_angles = vectortoangles( dir_to_player );
        thread spawn_stinger( spawn_pos, spawn_angles );
        wait var_d2dea1eb5c269d79;
    }
    
    /#
        if ( function_a621dc93b2fa8228() )
        {
            println( "<dev string:x1e4>" + self.summon_stingers.size );
        }
    #/
}

// Namespace zombie_weyward_summon_stinger
// Params 3, eflags: 0x4
// Checksum 0x86d43193, Offset: 0x1810
// Size: 0x2ea
function private spawn_stinger( spawn_pos, spawn_angles, force_spawn = 0 )
{
    self endon( #"death" );
    function_f35bd98f93d019dc();
    
    if ( self.wipe_attack_active )
    {
        return;
    }
    
    /#
        origin_spawn_pos = spawn_pos;
    #/
    
    var_467c345fcf636212 = force_spawn ? 8 : 0;
    spawn_pos = function_de1d7d9de11f3490( spawn_pos, 100, var_467c345fcf636212 );
    
    if ( !spawn_pos )
    {
        /#
            if ( function_a621dc93b2fa8228() )
            {
                println( "<dev string:x217>" + origin_spawn_pos );
            }
        #/
        
        return;
    }
    
    max_stingers = getdvarint( @"hash_3c3ba4efc542cb40", self.var_cfd675b386613abe );
    
    if ( self.summon_stingers.size >= max_stingers )
    {
        function_834fd81d9634b579();
    }
    
    stinger = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( function_b3988325430ce242( "zombie_weyward_stinger" ), spawn_pos, spawn_angles, self.team );
    
    while ( !stinger )
    {
        zombies = arrayrandomize( getaiarray( "team_two_hundred" ) );
        
        foreach ( zombie in zombies )
        {
            if ( !isalive( zombie ) || issubstr( zombie.subclass, "zombie_weyward" ) || issubstr( zombie.subclass, "zombie_wither" ) || issubstr( zombie.subclass, "hvt" ) )
            {
                continue;
            }
            
            zombie.nocorpse = 1;
            zombie kill();
            waitframe();
            waitframe();
            break;
        }
        
        stinger = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( function_b3988325430ce242( "zombie_weyward_stinger" ), spawn_pos, spawn_angles, self.team );
        
        if ( stinger )
        {
            break;
        }
        
        waitframe();
    }
    
    stinger.stinger_owner = self;
    stinger.stinger_spawn_time = gettime();
    
    if ( self.stingers_empowered )
    {
        stinger.empowered = 1;
        stinger utility::function_7c10ea82c1e305b8( "empowered", "on" );
    }
    
    self.var_11e27b50f16bf174 = length( stinger getboundshalfsize() ) * 2;
    callback::callback( "on_summoned_by_weyward", { #ent:stinger } );
    stinger thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "spawn", "spawn_end" );
    self.summon_stingers[ self.summon_stingers.size ] = stinger;
    thread function_624910e906846241( stinger );
    
    /#
        if ( function_a621dc93b2fa8228() )
        {
            println( "<dev string:x24b>" + spawn_pos + "<dev string:x269>" + self.summon_stingers.size );
        }
    #/
}

// Namespace zombie_weyward_summon_stinger
// Params 3, eflags: 0x4
// Checksum 0x9bea82ab, Offset: 0x1b02
// Size: 0x1df
function private function_de1d7d9de11f3490( origin, var_7b56c61605009bec, candidate_count )
{
    candidates = [ origin ];
    
    if ( candidate_count > 0 )
    {
        angle_step = 360 / candidate_count;
        
        for ( direction_index = 0; direction_index < candidate_count ; direction_index++ )
        {
            angle = angle_step * direction_index;
            target = origin + ( cos( angle ) * var_7b56c61605009bec * 2, sin( angle ) * var_7b56c61605009bec * 2, 0 );
            candidates[ candidates.size ] = target;
        }
    }
    
    check_distance_sq = var_7b56c61605009bec * var_7b56c61605009bec;
    
    foreach ( candidate in candidates )
    {
        overlaps_stinger = 0;
        
        foreach ( stinger in self.summon_stingers )
        {
            if ( isalive( stinger ) )
            {
                nav_trace = navtrace( origin, candidate, self, 1 );
                target = nav_trace[ "position" ];
                
                if ( target && distancesquared( target, stinger.origin ) < check_distance_sq )
                {
                    overlaps_stinger = 1;
                    break;
                }
            }
        }
        
        if ( !overlaps_stinger )
        {
            return candidate;
        }
    }
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0x27d2dc52, Offset: 0x1cea
// Size: 0x9b
function private function_834fd81d9634b579()
{
    if ( self.summon_stingers.size == 0 )
    {
        return;
    }
    
    oldest = self.summon_stingers[ 0 ];
    
    if ( isalive( oldest ) )
    {
        oldest.forceannihilate = 1;
        oldest kill( self.origin, self );
    }
    
    remaining = [];
    
    for ( i = 1; i < self.summon_stingers.size ; i++ )
    {
        remaining[ remaining.size ] = self.summon_stingers[ i ];
    }
    
    self.summon_stingers = remaining;
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0x8fffa56, Offset: 0x1d8d
// Size: 0x98
function private function_f35bd98f93d019dc()
{
    alive_stingers = [];
    
    foreach ( stinger in self.summon_stingers )
    {
        if ( isalive( stinger ) )
        {
            alive_stingers[ alive_stingers.size ] = stinger;
        }
    }
    
    self.summon_stingers = alive_stingers;
}

// Namespace zombie_weyward_summon_stinger
// Params 1, eflags: 0x4
// Checksum 0x6073ca6b, Offset: 0x1e2d
// Size: 0x4e
function private function_624910e906846241( stinger )
{
    self endon( #"death" );
    stinger waittill( #"death" );
    function_f35bd98f93d019dc();
    
    /#
        if ( function_a621dc93b2fa8228() )
        {
            println( "<dev string:x273>" + self.summon_stingers.size );
        }
    #/
}

// Namespace zombie_weyward_summon_stinger
// Params 0, eflags: 0x4
// Checksum 0x699c97fa, Offset: 0x1e83
// Size: 0xb1
function private function_2b54c4befaefb179()
{
    self waittill( #"death" );
    
    foreach ( stinger in self.summon_stingers )
    {
        if ( isalive( stinger ) )
        {
            stinger.forceannihilate = 1;
            stinger kill( self.origin, self );
        }
    }
    
    self.summon_stingers = [];
}

/#

    // Namespace zombie_weyward_summon_stinger
    // Params 0, eflags: 0x4
    // Checksum 0xc938b73f, Offset: 0x1f3c
    // Size: 0x9c, Type: dev
    function private function_c3c055594b5012e7()
    {
        devgui::function_9082edeb5db93280( "<dev string:x29f>" );
        devgui::add_devgui_func( "<dev string:x2c7>", "<dev string:x2dd>", &force_summon_stingers );
        devgui::add_devgui_func( "<dev string:x2fb>", "<dev string:x30d>", &function_682ca4fd8641ca78 );
        devgui::add_devgui_func( "<dev string:x329>", "<dev string:x33f>", &function_8e3e64175c454fd1 );
        devgui::add_devgui_func( "<dev string:x35b>", "<dev string:x36f>", &function_22cddab0d6e3f254 );
        devgui::add_devgui_func( "<dev string:x38b>", "<dev string:x39f>", &function_237db269b94f1048 );
        devgui::add_devgui_func( "<dev string:x3bb>", "<dev string:x3ce>", &dev_spawn_stinger );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_weyward_summon_stinger
    // Params 1, eflags: 0x4
    // Checksum 0x6d77b7f8, Offset: 0x1fe0
    // Size: 0x4f, Type: dev
    function private force_summon_stingers( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x3e0>" );
        
        if ( isdefined( weyward ) )
        {
            weyward notify( #"summon_stingers" );
        }
    }

    // Namespace zombie_weyward_summon_stinger
    // Params 1, eflags: 0x4
    // Checksum 0x45dcf3fb, Offset: 0x2037
    // Size: 0xea, Type: dev
    function private function_682ca4fd8641ca78( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x3e0>" );
        
        if ( isdefined( weyward ) )
        {
            foreach ( stinger in weyward.summon_stingers )
            {
                if ( isalive( stinger ) )
                {
                    stinger.forceannihilate = 1;
                    stinger kill( weyward.origin, weyward );
                }
            }
            
            weyward.summon_stingers = [];
        }
    }

    // Namespace zombie_weyward_summon_stinger
    // Params 1, eflags: 0x4
    // Checksum 0xa4f5a928, Offset: 0x2129
    // Size: 0x24, Type: dev
    function private function_8e3e64175c454fd1( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x3ef>", @"hash_508858307b737fc6" );
    }

    // Namespace zombie_weyward_summon_stinger
    // Params 1, eflags: 0x4
    // Checksum 0x5979cbaf, Offset: 0x2155
    // Size: 0x24, Type: dev
    function private function_22cddab0d6e3f254( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x40c>", @"hash_2242dba082fac317" );
    }

    // Namespace zombie_weyward_summon_stinger
    // Params 1, eflags: 0x4
    // Checksum 0x15e856ba, Offset: 0x2181
    // Size: 0x4b, Type: dev
    function private function_237db269b94f1048( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x3e0>" );
        
        if ( isdefined( weyward ) )
        {
            weyward thread function_7bfb468e97fae75f();
        }
    }

    // Namespace zombie_weyward_summon_stinger
    // Params 0, eflags: 0x4
    // Checksum 0x362a7bca, Offset: 0x21d4
    // Size: 0x16, Type: dev
    function private function_a621dc93b2fa8228()
    {
        return getdvarint( @"hash_508858307b737fc6", 0 ) > 0;
    }

    // Namespace zombie_weyward_summon_stinger
    // Params 0, eflags: 0x4
    // Checksum 0xfca84fab, Offset: 0x21f2
    // Size: 0x61, Type: dev
    function private dev_spawn_stinger()
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x3e0>" );
        
        if ( isdefined( weyward ) )
        {
            origin = devgui::function_97024c0a6d1256a6();
            weyward thread spawn_stinger( origin, ( 0, 0, 0 ), 1 );
        }
    }

#/
