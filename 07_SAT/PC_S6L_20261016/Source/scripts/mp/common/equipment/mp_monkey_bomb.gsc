// scripts\mp\common\equipment\mp_monkey_bomb.gsc  (hash_439e47e82f40e7db.gscc) (size: 660 Bytes / 0x294 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a2ed2f4 (707711732)
// size ...... 660 (0x294)
// includes .. 3   (offset: 0x270)
// strings ... 1   (offset: 0x288)
// dev strs .. 0   (offset: 0x294)
// exports ... 4   (offset: 0x128)
// cseg ...... 0x6d + 0xbb (0x128)
// imports ... 6   (offset: 0x1c8)
// animtree1 . 0   (offset: 0x294)
// animtree2 . 0   (offset: 0x294)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\mp\common\equipment\monkey_bomb;

#namespace mp_monkey_bomb;

// Namespace mp_monkey_bomb
// Params 0, eflags: 0x5
// Checksum 0xdca409ae, Offset: 0x8b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"monkey_bomb", undefined, undefined, &init );
}

// Namespace mp_monkey_bomb
// Params 0
// Checksum 0x860642c1, Offset: 0xac
// Size: 0x38
function init()
{
    if ( !level.var_cc3b9b1c8c9f3a68 )
    {
        return;
    }
    
    monkey_bomb::monkey_bomb_init();
    level callback::add( #"grenade_fire", &ongrenadeused );
    level.var_54d8aed57d6404ed = 1;
}

// Namespace mp_monkey_bomb
// Params 1
// Checksum 0xcfa10bf7, Offset: 0xec
// Size: 0x3c
function ongrenadeused( params )
{
    if ( params.grenade.equipmentref == "equip_monkey_bomb" )
    {
        thread monkey_bomb::monkey_bomb_used( params.grenade );
    }
}

