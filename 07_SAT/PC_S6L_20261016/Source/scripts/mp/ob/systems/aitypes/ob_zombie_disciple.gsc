// scripts\mp\ob\systems\aitypes\ob_zombie_disciple.gsc  (hash_5c17c8178990ff33.gscc) (size: 358 Bytes / 0x166 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x245242c7 (609370823)
// size ...... 358 (0x166)
// includes .. 2   (offset: 0x14a)
// strings ... 1   (offset: 0x15a)
// dev strs .. 0   (offset: 0x166)
// exports ... 2   (offset: 0xc2)
// cseg ...... 0x67 + 0x5b (0xc2)
// imports ... 2   (offset: 0x112)
// animtree1 . 0   (offset: 0x166)
// animtree2 . 0   (offset: 0x166)
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;

#namespace ob_zombie_disciple;

// Namespace ob_zombie_disciple
// Params 2
// Checksum 0xb356b576, Offset: 0x85
// Size: 0x3d
function precache( classname, aitypescriptbundle )
{
    aitypes = agent_utils::get_aitype_by_subclass( "zombie_base" );
    level.var_c9fa5883a2c15ba5 = utility::array_random( aitypes );
}

