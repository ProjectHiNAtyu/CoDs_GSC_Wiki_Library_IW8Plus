// scripts\common\scriptable_group.gsc  (hash_5032ed8da1128621.gscc) (size: 3800 Bytes / 0xed8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6cbb8dbe (1824230846)
// size ...... 3800 (0xed8)
// includes .. 2   (offset: 0xdec)
// strings ... 12  (offset: 0xdfc)
// dev strs .. 5   (offset: 0xe90)
// exports ... 8   (offset: 0xab8)
// cseg ...... 0x12b + 0x98d (0xab8)
// imports ... 17  (offset: 0xbf8)
// animtree1 . 0   (offset: 0xed8)
// animtree2 . 0   (offset: 0xed8)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\game_utility;

#namespace scriptable_group;

// Namespace scriptable_group
// Params 3
// Checksum 0x59d9aa2e, Offset: 0x149
// Size: 0x158
function function_54e1543b9d498b1f( group_id, group_size_max, var_9cdf4c1d415741eb )
{
    if ( !isdefined( level.scriptable_groups ) )
    {
        level.scriptable_groups = [];
    }
    
    assert( !isdefined( level.scriptable_groups[ group_id ] ), "<dev string:x24>" + group_id + "<dev string:x3f>" );
    group = spawnstruct();
    group.scriptables = [];
    group.start_id = 0;
    group.current_id = 0;
    group.group_id = group_id;
    group.max_count = group_size_max;
    group.cleanup_batch_size = var_9cdf4c1d415741eb;
    assert( group.cleanup_batch_size < group.max_count, "<dev string:x24>" + group_id + "<dev string:x5e>" );
    level.var_39e900d2d6f99b7c = spawnstruct();
    level.var_39e900d2d6f99b7c.var_86f31f99e5fd0a4c = 0;
    level.var_39e900d2d6f99b7c.var_ed447719b208673f = 0;
    level.var_39e900d2d6f99b7c.var_badf6169944edf43 = getdvarint( @"hash_a1ec8d784676a3d8", 4 );
    level thread function_c9a139c16ff9d4e7( group );
    level.scriptable_groups[ group_id ] = group;
}

// Namespace scriptable_group
// Params 1
// Checksum 0x250dc368, Offset: 0x2a9
// Size: 0x40
function function_dbae202082772159( group_id )
{
    if ( isdefined( level.scriptable_groups[ group_id ] ) )
    {
        group = level.scriptable_groups[ group_id ];
        return group.scriptables;
    }
}

// Namespace scriptable_group
// Params 2
// Checksum 0xf8308546, Offset: 0x2f2
// Size: 0xaf
function function_c40c50e09efedb23( group_id, instance )
{
    if ( !isdefined( level.scriptable_groups[ group_id ] ) )
    {
        assertmsg( "<dev string:xaf>" + group_id + "<dev string:xd4>" );
        return;
    }
    
    group = level.scriptable_groups[ group_id ];
    function_d8e397e9de5a7c0( group );
    instance.group_instance_id = group.current_id;
    group.scriptables[ instance.group_instance_id ] = instance;
    group.current_id++;
    instance callback::callback( #"scriptable_group_addition", group );
}

// Namespace scriptable_group
// Params 1
// Checksum 0x36b24ecb, Offset: 0x3a9
// Size: 0x12f
function function_cf6114f2daaf2924( instancetypes )
{
    foreach ( group in level.scriptable_groups )
    {
        foreach ( instance in group.scriptables )
        {
            if ( isdefined( instance ) && isdefined( instance.type ) && arraycontains( instancetypes, instance.type ) )
            {
                if ( instance.isingas )
                {
                    function_3359d6f82b103a4e( group, instance );
                }
            }
        }
    }
}

// Namespace scriptable_group
// Params 2
// Checksum 0xf0dfedc0, Offset: 0x4e0
// Size: 0xba
function function_3359d6f82b103a4e( group_id, instance )
{
    if ( !isdefined( level.scriptable_groups[ group_id ] ) )
    {
        assertmsg( "<dev string:xaf>" + group_id + "<dev string:xd4>" );
        return;
    }
    
    group = level.scriptable_groups[ group_id ];
    instance callback::callback( #"scriptable_group_removal", group );
    group.scriptables[ instance.group_instance_id ] = undefined;
    instance.group_instance_id = undefined;
    instance.isingas = undefined;
    
    /#
        if ( level.commonitem.var_8be065896d711ba0 )
        {
            instance.var_67c7b50cd56ec741 = undefined;
        }
    #/
}

// Namespace scriptable_group
// Params 1
// Checksum 0xad8274cd, Offset: 0x5a2
// Size: 0x3b8
function function_c9a139c16ff9d4e7( group )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( group ) )
    {
        return;
    }
    
    var_badf6169944edf43 = level.var_a5a628bfce794894.var_badf6169944edf43 ?? level.var_39e900d2d6f99b7c.var_badf6169944edf43 ?? 4;
    
    while ( true )
    {
        wait var_badf6169944edf43;
        
        if ( level.var_a5a628bfce794894.var_ed447719b208673f === 0 || level.var_39e900d2d6f99b7c.var_ed447719b208673f === 0 )
        {
            continue;
        }
        
        eventparams = [];
        eventparams[ eventparams.size ] = "group_id";
        eventparams[ eventparams.size ] = group.group_id ?? "";
        eventparams[ eventparams.size ] = "max_items";
        maxitems = group.max_count ?? level.var_85115ba1660b27ec.maxcount ?? -1;
        eventparams[ eventparams.size ] = maxitems;
        eventparams[ eventparams.size ] = "clean_batch_size";
        var_9ab124a0dfe879a0 = group.cleanup_batch_size ?? level.var_85115ba1660b27ec.batchsize ?? -1;
        eventparams[ eventparams.size ] = var_9ab124a0dfe879a0;
        eventparams[ eventparams.size ] = "gas_clear_items";
        var_f8e8dd24758b3513 = level.var_a5a628bfce794894.var_f8e8dd24758b3513 ?? -1;
        
        if ( isdefined( level.var_a5a628bfce794894.var_f8e8dd24758b3513 ) )
        {
            level.var_a5a628bfce794894.var_f8e8dd24758b3513 = 0;
        }
        
        eventparams[ eventparams.size ] = var_f8e8dd24758b3513;
        eventparams[ eventparams.size ] = "total_number_cleanups";
        var_86f31f99e5fd0a4c = level.var_a5a628bfce794894.var_86f31f99e5fd0a4c ?? level.var_39e900d2d6f99b7c.var_86f31f99e5fd0a4c ?? -1;
        
        if ( isdefined( level.var_a5a628bfce794894.var_86f31f99e5fd0a4c ) )
        {
            level.var_a5a628bfce794894.var_86f31f99e5fd0a4c = 0;
        }
        
        if ( isdefined( level.var_39e900d2d6f99b7c.var_86f31f99e5fd0a4c ) )
        {
            level.var_39e900d2d6f99b7c.var_86f31f99e5fd0a4c = 0;
        }
        
        eventparams[ eventparams.size ] = var_86f31f99e5fd0a4c;
        eventparams[ eventparams.size ] = "recently_cleaned_up_amount";
        var_ed447719b208673f = level.var_a5a628bfce794894.var_ed447719b208673f ?? level.var_39e900d2d6f99b7c.var_ed447719b208673f ?? -1;
        
        if ( isdefined( level.var_a5a628bfce794894.var_ed447719b208673f ) )
        {
            level.var_a5a628bfce794894.var_ed447719b208673f = 0;
        }
        
        if ( isdefined( level.var_39e900d2d6f99b7c.var_ed447719b208673f ) )
        {
            level.var_39e900d2d6f99b7c.var_ed447719b208673f = 0;
        }
        
        eventparams[ eventparams.size ] = var_ed447719b208673f;
        eventparams[ eventparams.size ] = "map_name";
        mapname = game_utility::getmapname() ?? "";
        eventparams[ eventparams.size ] = mapname;
        eventparams[ eventparams.size ] = "playlist_id";
        playlistid = getplaylistid() ?? 0;
        eventparams[ eventparams.size ] = playlistid;
        eventparams[ eventparams.size ] = "match_time";
        matchtime = gettime() ?? 0;
        eventparams[ eventparams.size ] = matchtime;
        eventparams[ eventparams.size ] = "circle_index";
        circleindex = -1;
        
        if ( isdefined( level.br_circle.circleindex ) )
        {
            circleindex = level.br_circle.circleindex;
        }
        
        eventparams[ eventparams.size ] = circleindex;
        dlog_recordevent( "dlog_event_scriptable_group", eventparams );
    }
}

// Namespace scriptable_group
// Params 1, eflags: 0x4
// Checksum 0xc3ba5b41, Offset: 0x962
// Size: 0x156
function private function_d8e397e9de5a7c0( group )
{
    if ( group.scriptables.size < group.max_count )
    {
        return;
    }
    
    num_instances_deleted = 0;
    
    for ( id = group.start_id; id < group.current_id ; id++ )
    {
        if ( num_instances_deleted == group.cleanup_batch_size )
        {
            break;
        }
        
        instance = group.scriptables[ id ];
        
        if ( isdefined( instance ) && !instance.critical )
        {
            instance callback::callback( #"scriptable_group_deletion", group );
            
            if ( isent( instance ) )
            {
                instance delete();
            }
            else
            {
                instance notify( #"death" );
                instance freescriptable();
            }
            
            num_instances_deleted++;
        }
        
        group.scriptables[ id ] = undefined;
        group.start_id++;
    }
    
    if ( num_instances_deleted > 0 )
    {
        level.var_39e900d2d6f99b7c.var_86f31f99e5fd0a4c += 1;
    }
    
    level.var_39e900d2d6f99b7c.var_ed447719b208673f += num_instances_deleted;
}

