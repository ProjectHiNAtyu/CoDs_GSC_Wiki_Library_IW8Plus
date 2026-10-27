// scripts\vehicle\pluto\pluto_spawn.gsc  (hash_11fce3bc1115e908.gscc) (size: 702 Bytes / 0x2be / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x24325386 (607277958)
// size ...... 702 (0x2be)
// includes .. 4   (offset: 0x26e)
// strings ... 3   (offset: 0x28e)
// dev strs .. 1   (offset: 0x2b2)
// exports ... 3   (offset: 0x132)
// cseg ...... 0x90 + 0xa2 (0x132)
// imports ... 7   (offset: 0x1aa)
// animtree1 . 0   (offset: 0x2be)
// animtree2 . 0   (offset: 0x2be)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\vehicle\pluto\pluto_shared;

#namespace pluto_spawn;

// Namespace pluto_spawn
// Params 0, eflags: 0x5
// Checksum 0xdfdf3301, Offset: 0xae
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"pluto", undefined, undefined, &post_main );
}

// Namespace pluto_spawn
// Params 0
// Checksum 0x9054d3b3, Offset: 0xcf
// Size: 0x63
function post_main()
{
    if ( !pluto_veh::function_bdd68e56b5bb1269() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_wait( "vehicle_init_done" );
    spawn_struct = utility::getstruct( "pluto_start_spawn", "targetname" );
    assert( spawn_struct, "<dev string:x24>" );
    vehicle::spawn( %"hash_62a07b56f29782f5", spawn_struct );
}

