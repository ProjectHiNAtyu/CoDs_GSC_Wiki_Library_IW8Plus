// scripts\mp\destructibles\destructibles_behaviors.gsc  (hash_31b7946079cd804f.gscc) (size: 631 Bytes / 0x277 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33c28d10 (868388112)
// size ...... 631 (0x277)
// includes .. 1   (offset: 0x257)
// strings ... 0   (offset: 0x25f)
// dev strs .. 2   (offset: 0x25f)
// exports ... 4   (offset: 0x163)
// cseg ...... 0x58 + 0x10b (0x163)
// imports ... 3   (offset: 0x203)
// animtree1 . 0   (offset: 0x277)
// animtree2 . 0   (offset: 0x277)
#using script_22b6a37515112f37;

#namespace destructible_behaviors;

// Namespace destructible_behaviors
// Params 0
// Checksum 0x6602a05d, Offset: 0x76
// Size: 0x17
function init()
{
    register_behavior( #"soul_harvest", &soul_harvest::execute );
}

// Namespace destructible_behaviors
// Params 3, eflags: 0x4
// Checksum 0xf720dd06, Offset: 0x95
// Size: 0x77
function private register_behavior( id, execute_callback, stop_callback )
{
    if ( !isdefined( level.destructibles.var_157122fd854d543d ) )
    {
        level.destructibles.var_157122fd854d543d = [];
    }
    
    level.destructibles.var_157122fd854d543d[ id ] = { #stop:stop_callback, #execute:execute_callback };
}

// Namespace destructible_behaviors
// Params 1
// Checksum 0x5a47fbe4, Offset: 0x114
// Size: 0x4e
function get_behavior( behavior_id )
{
    behavior = level.destructibles.var_157122fd854d543d[ behavior_id ];
    
    if ( !isdefined( behavior ) )
    {
        assertmsg( "<dev string:x24>" + behavior_id + "<dev string:x5f>" );
        return;
    }
    
    return behavior;
}

