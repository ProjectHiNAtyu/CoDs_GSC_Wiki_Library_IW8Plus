// scripts\asm\soldier\cp.gsc  (hash_4fa7f12cf0b115ea.gscc) (size: 395 Bytes / 0x18b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8977b12e (2306322734)
// size ...... 395 (0x18b)
// includes .. 0   (offset: 0x18b)
// strings ... 0   (offset: 0x18b)
// dev strs .. 0   (offset: 0x18b)
// exports ... 3   (offset: 0xf7)
// cseg ...... 0x58 + 0x9f (0xf7)
// imports ... 1   (offset: 0x16f)
// animtree1 . 0   (offset: 0x18b)
// animtree2 . 0   (offset: 0x18b)
#namespace cp;

// Namespace cp
// Params 4
// Checksum 0x106838f1, Offset: 0x76
// Size: 0x3d, Type: bool
function transition_parachutestate( asmname, statename, tostatename, params )
{
    return self._blackboard.parachutestate == params;
}

// Namespace cp
// Params 4
// Checksum 0xf798ab71, Offset: 0xbc
// Size: 0x3a, Type: bool
function function_563c078ca2aa117c( asmname, statename, tostatename, params )
{
    return self codemoverequested() && isdefined( self.grenade );
}

