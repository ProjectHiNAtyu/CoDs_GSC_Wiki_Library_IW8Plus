// scripts\common\flags.gsc  (hash_73467331bafea03b.gscc) (size: 533 Bytes / 0x215 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x830d8a63 (2198702691)
// size ...... 533 (0x215)
// includes .. 1   (offset: 0x1f5)
// strings ... 2   (offset: 0x1fd)
// dev strs .. 0   (offset: 0x215)
// exports ... 3   (offset: 0x10d)
// cseg ...... 0x71 + 0x9c (0x10d)
// imports ... 4   (offset: 0x185)
// animtree1 . 0   (offset: 0x215)
// animtree2 . 0   (offset: 0x215)
#using scripts\common\utility;

#namespace flags;

// Namespace flags
// Params 0
// Checksum 0x2d23dfac, Offset: 0x8f
// Size: 0x52
function init_flags()
{
    if ( !utility::add_init_script( "init_flags", &init_flags ) )
    {
        return;
    }
    
    level.flag = [];
    level.flags_lock = [];
    level.generic_index = 0;
    level.flag_struct = spawnstruct();
    level.flag_struct assign_unique_id();
}

// Namespace flags
// Params 0
// Checksum 0x590191c6, Offset: 0xe9
// Size: 0x24
function assign_unique_id()
{
    self.unique_id = "generic" + level.generic_index;
    level.generic_index++;
}

