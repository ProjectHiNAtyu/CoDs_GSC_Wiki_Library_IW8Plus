// scripts\common\scriptable_group_spatial.gsc  (hash_65a9a12b46a1fac2.gscc) (size: 6422 Bytes / 0x1916 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6eb6af5 (3605752565)
// size ...... 6422 (0x1916)
// includes .. 4   (offset: 0x17e2)
// strings ... 3   (offset: 0x1802)
// dev strs .. 19  (offset: 0x1832)
// exports ... 17  (offset: 0x10f6)
// cseg ...... 0x9b + 0x105b (0x10f6)
// imports ... 34  (offset: 0x139e)
// animtree1 . 0   (offset: 0x1916)
// animtree2 . 0   (offset: 0x1916)
#using scripts\common\callbacks;
#using scripts\common\scriptable_group;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;

#namespace scriptable_group_spatial;

// Namespace scriptable_group_spatial
// Params 2
// Checksum 0x4259d42b, Offset: 0xb9
// Size: 0x174
function function_3d8f0445c920e8f7( group_size_max, var_9cdf4c1d415741eb )
{
    if ( !isdefined( level.var_85115ba1660b27ec ) )
    {
        level.var_85115ba1660b27ec = spawnstruct();
        level.var_85115ba1660b27ec.maxcount = group_size_max;
        level.var_85115ba1660b27ec.batchsize = var_9cdf4c1d415741eb;
        level.var_a5a628bfce794894 = spawnstruct();
        level.var_a5a628bfce794894.var_f8e8dd24758b3513 = 0;
        level.var_a5a628bfce794894.var_86f31f99e5fd0a4c = 0;
        level.var_a5a628bfce794894.var_ed447719b208673f = 0;
        level.var_a5a628bfce794894.var_badf6169944edf43 = getdvarint( @"hash_c0fbcba3cf212d0d", 4 );
    }
    
    assert( level.var_85115ba1660b27ec.batchsize < level.var_85115ba1660b27ec.maxcount, "<dev string:x24>" );
    
    if ( level.commonitem.var_d9665d85ee830b4c == 1 || level.commonitem.var_d9665d85ee830b4c == 3 )
    {
        br_circle::registercirclecallbacks( 23, &function_81dce8004dc00087, &function_81dce8004dc00087 );
        return;
    }
    
    if ( level.commonitem.var_d9665d85ee830b4c == 4 )
    {
        br_circle::registercirclecallbacks( 23, &function_159a35ef54a81e98, &function_159a35ef54a81e98 );
    }
}

// Namespace scriptable_group_spatial
// Params 1
// Checksum 0x242c7877, Offset: 0x235
// Size: 0xa3
function function_5c34c712fcfd241e( group_id )
{
    if ( !isdefined( level.scriptable_groups ) )
    {
        level.scriptable_groups = [];
    }
    
    assert( !isdefined( level.scriptable_groups[ group_id ] ), "<dev string:x92>" + group_id + "<dev string:xad>" );
    group = spawnstruct();
    group.scriptables = [];
    group.start_id = 0;
    group.current_id = 0;
    group.group_id = group_id;
    level.scriptable_groups[ group_id ] = group;
    level thread scriptable_group::function_c9a139c16ff9d4e7( group );
}

// Namespace scriptable_group_spatial
// Params 2
// Checksum 0x9a6b1137, Offset: 0x2e0
// Size: 0x155
function function_b7b6ffa8483b3c0b( group_id, instance )
{
    if ( !isdefined( level.scriptable_groups[ group_id ] ) )
    {
        assertmsg( "<dev string:xcc>" + group_id + "<dev string:xf1>" );
        return;
    }
    
    switch ( level.commonitem.var_d9665d85ee830b4c )
    {
        case 1:
            function_cbc237df247ac413();
            break;
        case 2:
            function_9fb437df811b85c6();
            break;
        case 3:
            function_df2d119518956e81();
            break;
        case 4:
            function_7254d4c9c9b6b48a();
            break;
        default:
            break;
    }
    
    group = level.scriptable_groups[ group_id ];
    instance.group_instance_id = group.current_id;
    group.scriptables[ instance.group_instance_id ] = instance;
    group.current_id++;
    instance callback::callback( #"scriptable_group_addition", group );
    
    /#
        if ( level.commonitem.var_8be065896d711ba0 )
        {
            instance.var_67c7b50cd56ec741 = gettime() / 1000;
        }
    #/
}

// Namespace scriptable_group_spatial
// Params 3
// Checksum 0xb12972c3, Offset: 0x43d
// Size: 0x131
function function_81dce8004dc00087( dangercircleorigin, dangercircleradius, thresholdradius )
{
    foreach ( group in level.scriptable_groups )
    {
        itemschecked = 0;
        
        foreach ( instance in group.scriptables )
        {
            if ( itemschecked == 15 )
            {
                break;
            }
            
            if ( isdefined( instance ) )
            {
                instance.isingas = is_instance_in_gas( instance );
                itemschecked++;
            }
        }
    }
}

// Namespace scriptable_group_spatial
// Params 3
// Checksum 0x4971f9d8, Offset: 0x576
// Size: 0x131
function function_159a35ef54a81e98( dangercircleorigin, dangercircleradius, thresholdradius )
{
    foreach ( group in level.scriptable_groups )
    {
        itemschecked = 0;
        
        foreach ( instance in group.scriptables )
        {
            if ( itemschecked == 15 )
            {
                break;
            }
            
            if ( isdefined( instance ) )
            {
                instance.isingas = function_3a22fefe9b5009fb( instance );
                itemschecked++;
            }
        }
    }
}

// Namespace scriptable_group_spatial
// Params 0, eflags: 0x4
// Checksum 0x5247e62c, Offset: 0x6af
// Size: 0x13c
function private function_cbc237df247ac413()
{
    weapongroup = level.scriptable_groups[ "common_items_weapons" ];
    var_673b5e7759f87e80 = level.scriptable_groups[ "common_items_nonweapons" ];
    totalcount = weapongroup.scriptables.size + var_673b5e7759f87e80.scriptables.size;
    
    if ( totalcount < level.var_85115ba1660b27ec.maxcount )
    {
        return;
    }
    
    instancesdeleted = function_cc27c9113d84c33f( instancesdeleted, var_673b5e7759f87e80, &is_instance_in_gas );
    
    if ( instancesdeleted == level.var_85115ba1660b27ec.batchsize )
    {
        return;
    }
    
    instancesdeleted = function_cc27c9113d84c33f( instancesdeleted, weapongroup, &is_instance_in_gas );
    
    if ( instancesdeleted == level.var_85115ba1660b27ec.batchsize )
    {
        return;
    }
    
    instancesdeleted = remove_instances( instancesdeleted, var_673b5e7759f87e80 );
    
    if ( instancesdeleted == level.var_85115ba1660b27ec.batchsize )
    {
        return;
    }
    
    instancesdeleted = remove_instances( instancesdeleted, weapongroup );
    
    if ( instancesdeleted == level.var_85115ba1660b27ec.batchsize )
    {
        return;
    }
    
    assert( instancesdeleted != level.var_85115ba1660b27ec.batchsize, "<dev string:x11a>" );
}

// Namespace scriptable_group_spatial
// Params 0, eflags: 0x4
// Checksum 0x3bfb2910, Offset: 0x7f3
// Size: 0xe8
function private function_9fb437df811b85c6()
{
    weapongroup = level.scriptable_groups[ "common_items_weapons" ];
    var_673b5e7759f87e80 = level.scriptable_groups[ "common_items_nonweapons" ];
    totalcount = weapongroup.scriptables.size + var_673b5e7759f87e80.scriptables.size;
    
    if ( totalcount < level.var_85115ba1660b27ec.maxcount )
    {
        return;
    }
    
    instancesdeleted = remove_instances( instancesdeleted, var_673b5e7759f87e80 );
    
    if ( instancesdeleted == level.var_85115ba1660b27ec.batchsize )
    {
        return;
    }
    
    instancesdeleted = remove_instances( instancesdeleted, weapongroup );
    
    if ( instancesdeleted == level.var_85115ba1660b27ec.batchsize )
    {
        return;
    }
    
    assert( instancesdeleted != level.var_85115ba1660b27ec.batchsize, "<dev string:x176>" );
}

// Namespace scriptable_group_spatial
// Params 1
// Checksum 0x94f5c738, Offset: 0x8e3
// Size: 0xc3
function function_50e6dd6d052fdd09( instancetypes )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        totaldeleted = 0;
        
        foreach ( group in level.scriptable_groups )
        {
            totaldeleted += function_cc27c9113d84c33f( 0, group, &is_instance_in_gas, instancetypes );
        }
        
        if ( totaldeleted == 0 )
        {
            break;
        }
        
        wait 0.5;
    }
}

// Namespace scriptable_group_spatial
// Params 0, eflags: 0x4
// Checksum 0x7adbf13c, Offset: 0x9ae
// Size: 0xbb
function private function_df2d119518956e81()
{
    var_86799b15d26bf7d8 = level.scriptable_groups[ "common_items" ];
    
    if ( var_86799b15d26bf7d8.scriptables.size < level.var_85115ba1660b27ec.maxcount )
    {
        return;
    }
    
    instancesdeleted = function_cc27c9113d84c33f( instancesdeleted, var_86799b15d26bf7d8, &is_instance_in_gas );
    
    if ( instancesdeleted == level.var_85115ba1660b27ec.batchsize )
    {
        return;
    }
    
    instancesdeleted = remove_instances( instancesdeleted, var_86799b15d26bf7d8 );
    
    if ( instancesdeleted == level.var_85115ba1660b27ec.batchsize )
    {
        return;
    }
    
    assert( instancesdeleted != level.var_85115ba1660b27ec.batchsize, "<dev string:x1ca>" );
}

// Namespace scriptable_group_spatial
// Params 0, eflags: 0x4
// Checksum 0x6c7cf735, Offset: 0xa71
// Size: 0xbb
function private function_7254d4c9c9b6b48a()
{
    var_86799b15d26bf7d8 = level.scriptable_groups[ "common_items" ];
    
    if ( var_86799b15d26bf7d8.scriptables.size < level.var_85115ba1660b27ec.maxcount )
    {
        return;
    }
    
    instancesdeleted = function_cc27c9113d84c33f( instancesdeleted, var_86799b15d26bf7d8, &function_3a22fefe9b5009fb );
    
    if ( instancesdeleted == level.var_85115ba1660b27ec.batchsize )
    {
        return;
    }
    
    instancesdeleted = remove_instances( instancesdeleted, var_86799b15d26bf7d8 );
    
    if ( instancesdeleted == level.var_85115ba1660b27ec.batchsize )
    {
        return;
    }
    
    assert( instancesdeleted != level.var_85115ba1660b27ec.batchsize, "<dev string:x21d>" );
}

// Namespace scriptable_group_spatial
// Params 4
// Checksum 0x26dc9047, Offset: 0xb34
// Size: 0x20d
function function_cc27c9113d84c33f( var_d54079001a3e0806 = 0, group, var_bd77011348a39322, var_baa3deaa4abcfde3 )
{
    totaldeleted = var_d54079001a3e0806;
    
    foreach ( instance in group.scriptables )
    {
        if ( totaldeleted == level.var_85115ba1660b27ec.batchsize )
        {
            break;
        }
        
        if ( isdefined( instance ) && !instance.critical && ( !isdefined( var_baa3deaa4abcfde3 ) || !isdefined( instance.type ) || arraycontains( var_baa3deaa4abcfde3, instance.type ) ) )
        {
            instance.isingas = [[ var_bd77011348a39322 ]]( instance );
            
            if ( instance.isingas )
            {
                if ( instance.group_instance_id == group.current_id - 1 && !isdefined( var_baa3deaa4abcfde3 ) )
                {
                    break;
                }
                
                function_17fc683477710789( instance, group, instance.group_instance_id );
                totaldeleted++;
            }
        }
    }
    
    var_6301c1f6cf9c22f9 = totaldeleted - var_d54079001a3e0806;
    
    if ( level.var_a5a628bfce794894 )
    {
        if ( var_6301c1f6cf9c22f9 > 0 )
        {
            level.var_a5a628bfce794894.var_86f31f99e5fd0a4c += 1;
        }
        
        level.var_a5a628bfce794894.var_ed447719b208673f += var_6301c1f6cf9c22f9;
        level.var_a5a628bfce794894.var_f8e8dd24758b3513 += var_6301c1f6cf9c22f9;
    }
    
    return totaldeleted;
}

// Namespace scriptable_group_spatial
// Params 2, eflags: 0x4
// Checksum 0xf0812f49, Offset: 0xd4a
// Size: 0x160
function private remove_instances( var_d54079001a3e0806 = 0, group )
{
    totaldeleted = var_d54079001a3e0806;
    
    foreach ( instance in group.scriptables )
    {
        if ( totaldeleted == level.var_85115ba1660b27ec.batchsize )
        {
            break;
        }
        
        if ( isdefined( instance ) && !instance.critical && !instance.var_22cae40c41e63f97 )
        {
            function_17fc683477710789( instance, group, instance.group_instance_id );
            totaldeleted++;
        }
    }
    
    var_6301c1f6cf9c22f9 = totaldeleted - var_d54079001a3e0806;
    
    if ( var_6301c1f6cf9c22f9 > 0 )
    {
        level.var_a5a628bfce794894.var_86f31f99e5fd0a4c += 1;
    }
    
    level.var_a5a628bfce794894.var_ed447719b208673f += var_6301c1f6cf9c22f9;
    return totaldeleted;
}

// Namespace scriptable_group_spatial
// Params 3, eflags: 0x4
// Checksum 0xdfca0227, Offset: 0xeb3
// Size: 0x14e
function private function_17fc683477710789( instance, group, id )
{
    instance callback::callback( #"scriptable_group_deletion", group );
    
    /#
        if ( level.commonitem.var_8be065896d711ba0 )
        {
            thread function_e1c8da45f937272c( instance.origin );
            logstring( "<dev string:x28a>" + group.group_id + "<dev string:x2a2>" + group.scriptables.size + "<dev string:x2b2>" );
            logstring( "<dev string:x2bf>" + instance.type + "<dev string:x2f0>" + id + "<dev string:x303>" + group.group_id + "<dev string:x312>" + group.current_id + "<dev string:x331>" );
            currenttime = gettime() / 1000;
            
            if ( currenttime - instance.var_67c7b50cd56ec741 < 10 )
            {
                logstring( "<dev string:x333>" + instance.type + "<dev string:x361>" );
            }
        }
    #/
    
    if ( isent( instance ) )
    {
        instance delete();
    }
    else
    {
        instance notify( #"death" );
        instance freescriptable();
    }
    
    group.scriptables[ id ] = undefined;
}

// Namespace scriptable_group_spatial
// Params 1
// Checksum 0x5c48d3a, Offset: 0x1009
// Size: 0x5c, Type: bool
function is_instance_in_gas( instance )
{
    if ( br_circle_util::function_32ead8efde5943f5() )
    {
        return false;
    }
    
    origin = instance.origin;
    
    if ( br_circle_util::function_4c6afbf2b757376a( origin, 0 ) )
    {
        return false;
    }
    
    return !br_circle_util::ispointindangercircle( origin, level.var_ea96217a33eb6457 ) || br_circle_util::function_4c6afbf2b757376a( origin, 1 );
}

// Namespace scriptable_group_spatial
// Params 1, eflags: 0x4
// Checksum 0x6a7ed8ce, Offset: 0x106e
// Size: 0x45, Type: bool
function private function_3a22fefe9b5009fb( instance )
{
    if ( br_circle_util::function_32ead8efde5943f5() )
    {
        return false;
    }
    
    origin = instance.origin;
    
    if ( br_circle_util::function_4c6afbf2b757376a( origin, 0 ) )
    {
        return false;
    }
    
    return !br_circle_util::ispointindangercircle( origin );
}

// Namespace scriptable_group_spatial
// Params 1
// Checksum 0x6495fb3d, Offset: 0x10bc
// Size: 0x3a
function function_e1c8da45f937272c( origin )
{
    level endon( #"hash_b5690f3bb0edd7b" );
    
    while ( true )
    {
        /#
            sphere( origin, 10, ( 1, 0, 0 ) );
        #/
        
        waitframe();
    }
}

