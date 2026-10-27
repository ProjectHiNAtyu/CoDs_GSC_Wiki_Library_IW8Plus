// scripts\mp\br\gamelogic.gsc  (hash_1e1ab6f613139ca1.gscc) (size: 369 Bytes / 0x171 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd15645ce (3512092110)
// size ...... 369 (0x171)
// includes .. 3   (offset: 0x14d)
// strings ... 1   (offset: 0x165)
// dev strs .. 0   (offset: 0x171)
// exports ... 2   (offset: 0xa9)
// cseg ...... 0x69 + 0x40 (0xa9)
// imports ... 3   (offset: 0xf9)
// animtree1 . 0   (offset: 0x171)
// animtree2 . 0   (offset: 0x171)
#using scripts\mp\br\laststand;
#using scripts\mp\gamelogic;
#using scripts\mp\loot;

#namespace gamelogic_br;

// Namespace gamelogic_br
// Params 0
// Checksum 0xace30630, Offset: 0x87
// Size: 0x22
function callback_startgametype()
{
    gamelogic_mp::callback_startgametype();
    
    if ( !game[ "isLaunchChunk" ] )
    {
        thread loot_mp::init();
    }
    
    laststand_br::init();
}

