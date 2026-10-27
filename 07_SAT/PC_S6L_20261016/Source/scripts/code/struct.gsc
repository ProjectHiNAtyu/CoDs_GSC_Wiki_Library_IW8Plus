// scripts\code\struct.gsc  (hash_34a720e17d0e697b.gscc) (size: 2287 Bytes / 0x8ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a4d8b0b (709724939)
// size ...... 2287 (0x8ef)
// includes .. 1   (offset: 0x85f)
// strings ... 10  (offset: 0x867)
// dev strs .. 1   (offset: 0x8df)
// exports ... 5   (offset: 0x5f7)
// cseg ...... 0x11d + 0x4da (0x5f7)
// imports ... 14  (offset: 0x6bf)
// animtree1 . 0   (offset: 0x8ef)
// animtree2 . 0   (offset: 0x8ef)
#using scripts\common\utility;

#namespace struct;

// Namespace struct/bootstrap
// Params 0, eflags: 0x24
// Checksum 0x769edebe, Offset: 0x13b
// Size: 0x44
function private event_handler[bootstrap] bootstrap()
{
    level.struct_class_names = [ "script_agent_noteworthy":[], "variantname":[], "script_vehicleref":[], "script_linkname":[], "script_noteworthy":[], "targetname":[], "target":[] ];
    init_global_scriptbundles();
}

// Namespace struct/spawnstruct
// Params 1, eflags: 0x24
// Checksum 0xccc0c4b7, Offset: 0x187
// Size: 0xb4
function private event_handler[spawnstruct] spawn_struct( struct )
{
    if ( struct.var_cadb121fd1be05b0 || struct.targetname == "delete_on_load" )
    {
        return;
    }
    
    if ( level.create_script && struct.var_a55b0b7889573538 )
    {
        return;
    }
    
    if ( level.struct_filter_override && ![[ level.struct_filter_override ]]( struct ) )
    {
        return;
    }
    else if ( level.struct_filter && ![[ level.struct_filter ]]( struct ) )
    {
        return;
    }
    
    if ( struct.script_noteworthy == "vfx_ambientwar_node" )
    {
        utility::function_d25424f1ac9f1290( struct );
        return;
    }
    
    utility::addstruct( struct );
}

// Namespace struct
// Params 0, eflags: 0x4
// Checksum 0x29771343, Offset: 0x243
// Size: 0x3aa
function private init_global_scriptbundles()
{
    level.projectbundle = getprojectscriptbundle();
    level.gamemodebundle = getgamemodescriptbundle();
    level.gametypebundle = getgametypescriptbundle();
    level.mapinfobundle = getmapscriptbundle();
    
    if ( isdefined( level.gametypebundle.additionalscriptbundles ) )
    {
        level.gametypebundle.var_ae100eea97c7fcc7 = [];
        
        foreach ( bundle in level.gametypebundle.additionalscriptbundles )
        {
            if ( !bundle.var_48cc9bf9fa3db0a || !bundle.var_33ebe182767e4f6e )
            {
                continue;
            }
            
            level.gametypebundle.var_ae100eea97c7fcc7[ bundle.var_48cc9bf9fa3db0a ] = getscriptbundle( bundle.var_33ebe182767e4f6e );
        }
    }
    
    if ( isdefined( level.gametypebundle.botscriptbundles ) && !isinfrontend() )
    {
        var_fc18dbe439223a8b = [];
        
        foreach ( var_7d8c0c1bcea2afc9 in level.gametypebundle.botscriptbundles )
        {
            if ( !var_7d8c0c1bcea2afc9.var_48cc9bf9fa3db0a || !var_7d8c0c1bcea2afc9.var_33ebe182767e4f6e )
            {
                continue;
            }
            
            scriptbundle = getscriptbundle( var_7d8c0c1bcea2afc9.var_33ebe182767e4f6e );
            
            if ( !scriptbundle )
            {
                continue;
            }
            
            assert( !var_fc18dbe439223a8b[ var_7d8c0c1bcea2afc9.var_48cc9bf9fa3db0a ], "<dev string:x24>" );
            var_fc18dbe439223a8b[ var_7d8c0c1bcea2afc9.var_48cc9bf9fa3db0a ] = scriptbundle;
        }
        
        level.gametypebundle.var_fd3a1a6b45be175c = var_fc18dbe439223a8b;
    }
    
    if ( isdefined( level.mapinfobundle.additionalscriptbundles ) )
    {
        level.mapinfobundle.var_ae100eea97c7fcc7 = [];
        
        foreach ( bundle in level.mapinfobundle.additionalscriptbundles )
        {
            if ( !bundle.var_48cc9bf9fa3db0a || !bundle.var_33ebe182767e4f6e )
            {
                continue;
            }
            
            assert( !level.mapinfobundle.var_ae100eea97c7fcc7[ bundle.var_48cc9bf9fa3db0a ], "<dev string:x24>" );
            level.mapinfobundle.var_ae100eea97c7fcc7[ bundle.var_48cc9bf9fa3db0a ] = getscriptbundle( bundle.var_33ebe182767e4f6e );
        }
    }
    
    utility::flag_set( "init_global_scriptbundles" );
    
    /#
        if ( !isinfrontend() )
        {
            assert( isdefined( level.projectbundle ) );
            assert( isdefined( level.gamemodebundle ) );
        }
    #/
}

// Namespace struct
// Params 0
// Checksum 0x80da4a24, Offset: 0x5f5
// Size: 0x2
function dummy()
{
    
}

