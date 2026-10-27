// scripts\asm\soldier\zombie_react.gsc  (hash_695d2053fc9315b3.gscc) (size: 322 Bytes / 0x142 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x44d9028c (1155072652)
// size ...... 322 (0x142)
// includes .. 0   (offset: 0x136)
// strings ... 1   (offset: 0x136)
// dev strs .. 0   (offset: 0x142)
// exports ... 2   (offset: 0xe6)
// cseg ...... 0x62 + 0x84 (0xe6)
// imports ... 0   (offset: 0x136)
// animtree1 . 0   (offset: 0x142)
// animtree2 . 0   (offset: 0x142)
#namespace zombie_react;

// Namespace zombie_react
// Params 4
// Checksum 0xec0075c3, Offset: 0x80
// Size: 0x65, Type: bool
function isenemyzombie( asmname, statename, tostatename, params )
{
    return isdefined( self.enemy ) && isdefined( self.enemy.unittype ) && self.enemy.unittype == "zombie";
}

