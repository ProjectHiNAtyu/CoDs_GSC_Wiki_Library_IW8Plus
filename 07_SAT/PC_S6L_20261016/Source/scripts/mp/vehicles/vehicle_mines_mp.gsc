// scripts\mp\vehicles\vehicle_mines_mp.gsc  (hash_45161d316ab714fb.gscc) (size: 363 Bytes / 0x16b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77084279 (1997030009)
// size ...... 363 (0x16b)
// includes .. 1   (offset: 0x163)
// strings ... 0   (offset: 0x16b)
// dev strs .. 0   (offset: 0x16b)
// exports ... 3   (offset: 0xb3)
// cseg ...... 0x58 + 0x5b (0xb3)
// imports ... 2   (offset: 0x12b)
// animtree1 . 0   (offset: 0x16b)
// animtree2 . 0   (offset: 0x16b)
#using scripts\common\utility;

#namespace vehicle_mines_mp;

// Namespace vehicle_mines_mp
// Params 0
// Checksum 0xbbd592cf, Offset: 0x76
// Size: 0x20
function vehicle_mines_mp_init()
{
    utility::registersharedfunc( #"vehicle_mines", #"trigger", &vehicle_mines_mp_minetrigger );
}

// Namespace vehicle_mines_mp
// Params 2
// Checksum 0x9b50f127, Offset: 0x9e
// Size: 0x15
function vehicle_mines_mp_minetrigger( vehicle, mine )
{
    
}

