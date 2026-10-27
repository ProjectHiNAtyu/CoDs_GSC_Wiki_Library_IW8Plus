// scripts\code\struct.csc  (hash_13b474e16ae0700f.gscc) (size: 689 Bytes / 0x2b1 / CSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8810f66d (2282813037)
// size ...... 689 (0x2b1)
// includes .. 0   (offset: 0x251)
// strings ... 8   (offset: 0x251)
// dev strs .. 0   (offset: 0x2b1)
// exports ... 3   (offset: 0x1d9)
// cseg ...... 0xe9 + 0xf0 (0x1d9)
// imports ... 0   (offset: 0x251)
// animtree1 . 0   (offset: 0x2b1)
// animtree2 . 0   (offset: 0x2b1)
#namespace struct;

// Namespace struct/bootstrap
// Params 0, eflags: 0x24
// Checksum 0x992194e6, Offset: 0x107
// Size: 0x3d
function private event_handler[bootstrap] bootstrap()
{
    level.struct_class_names = [ "script_agent_noteworthy":[], "variantname":[], "script_vehicleref":[], "script_linkname":[], "script_noteworthy":[], "targetname":[], "target":[] ];
}

// Namespace struct/spawnstruct
// Params 1, eflags: 0x24
// Checksum 0x2b1ac6ba, Offset: 0x14c
// Size: 0x8d
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
    
    if ( level.struct_filter && ![[ level.struct_filter ]]( struct ) )
    {
        return;
    }
}

