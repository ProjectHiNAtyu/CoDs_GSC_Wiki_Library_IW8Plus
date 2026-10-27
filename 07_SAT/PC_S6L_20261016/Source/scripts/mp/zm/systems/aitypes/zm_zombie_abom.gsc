// scripts\mp\zm\systems\aitypes\zm_zombie_abom.gsc  (hash_38732efef155ff43.gscc) (size: 642 Bytes / 0x282 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58a737e9 (1487353833)
// size ...... 642 (0x282)
// includes .. 1   (offset: 0x26a)
// strings ... 1   (offset: 0x272)
// dev strs .. 0   (offset: 0x282)
// exports ... 4   (offset: 0x15a)
// cseg ...... 0x67 + 0xf3 (0x15a)
// imports ... 4   (offset: 0x1fa)
// animtree1 . 0   (offset: 0x282)
// animtree2 . 0   (offset: 0x282)
#using scripts\mp\zm\spawners\zone_spawner;

#namespace zm_zombie_abom;

// Namespace zm_zombie_abom
// Params 2
// Checksum 0xe5d7270e, Offset: 0x85
// Size: 0x26
function precache( classname, aitypescriptbundle )
{
    zone_spawner::register_can_spawn_agent( "zombie_abom", &can_spawn_abomination );
}

// Namespace zm_zombie_abom
// Params 0, eflags: 0x4
// Checksum 0x35079f81, Offset: 0xb3
// Size: 0x34, Type: bool
function private can_spawn_abomination()
{
    var_efe46fc4a3ad8f68 = zone_spawner::function_835973438f299e55( "zombie_abom" );
    var_7175eb0c319a9143 = function_dce75abc3198e5e5();
    
    if ( var_efe46fc4a3ad8f68 >= var_7175eb0c319a9143 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_zombie_abom
// Params 0, eflags: 0x4
// Checksum 0xeef3d3eb, Offset: 0xf0
// Size: 0x6a
function private function_dce75abc3198e5e5()
{
    var_ac07512145efb190 = level.players.size;
    
    switch ( var_ac07512145efb190 )
    {
        case 1:
        default:
            return 1;
        case 2:
            return 2;
        case 3:
            return 3;
        case 4:
            return 4;
    }
}

