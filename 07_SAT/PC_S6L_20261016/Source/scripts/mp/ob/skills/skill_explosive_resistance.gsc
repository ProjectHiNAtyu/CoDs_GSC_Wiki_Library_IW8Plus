// scripts\mp\ob\skills\skill_explosive_resistance.gsc  (hash_3726568005eab760.gscc) (size: 766 Bytes / 0x2fe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7fafde9c (2142232220)
// size ...... 766 (0x2fe)
// includes .. 3   (offset: 0x2d6)
// strings ... 1   (offset: 0x2ee)
// dev strs .. 0   (offset: 0x2fe)
// exports ... 5   (offset: 0x146)
// cseg ...... 0x7d + 0xc9 (0x146)
// imports ... 7   (offset: 0x20e)
// animtree1 . 0   (offset: 0x2fe)
// animtree2 . 0   (offset: 0x2fe)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;

#namespace explosive_resistance;

// Namespace explosive_resistance
// Params 0, eflags: 0x1
// Checksum 0x982f7537, Offset: 0x9b
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"explosive_resistance", &init );
}

// Namespace explosive_resistance
// Params 0
// Checksum 0x80c18c13, Offset: 0xba
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"explosive_resistance", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"explosive_resistance", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace explosive_resistance
// Params 1
// Checksum 0xdfba5b84, Offset: 0x100
// Size: 0x25, Type: bool
function on_give_skill( skill_bundle )
{
    perk::giveperk( "specialty_reduce_explosion_damage", skill_bundle.var_3c419b94e6ef2d68 );
    return true;
}

// Namespace explosive_resistance
// Params 1
// Checksum 0x4af16a35, Offset: 0x12e
// Size: 0x18
function function_c51f1692ecb73bfe( skill_bundle )
{
    perk::removeperk( "specialty_reduce_explosion_damage" );
}

