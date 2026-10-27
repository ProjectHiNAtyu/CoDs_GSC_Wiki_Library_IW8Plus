// scripts\common\ai\aitypes\zombie_disciple\zombie_disciple_medal.gsc  (hash_3b849bc26ec78e90.gscc) (size: 633 Bytes / 0x279 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x22b63412 (582366226)
// size ...... 633 (0x279)
// includes .. 2   (offset: 0x269)
// strings ... 0   (offset: 0x279)
// dev strs .. 0   (offset: 0x279)
// exports ... 3   (offset: 0x149)
// cseg ...... 0x58 + 0xf1 (0x149)
// imports ... 6   (offset: 0x1c1)
// animtree1 . 0   (offset: 0x279)
// animtree2 . 0   (offset: 0x279)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;

#namespace zombie_disciple_medal;

// Namespace zombie_disciple_medal
// Params 0
// Checksum 0xae2202e9, Offset: 0x76
// Size: 0x45
function function_1608872af183cf53()
{
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", self.animsetname, &on_killed_medal );
    }
}

// Namespace zombie_disciple_medal
// Params 4, eflags: 0x4
// Checksum 0x7e1a72a3, Offset: 0xc3
// Size: 0x86
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( victim.var_10f573f354866b22.size >= 5 )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_disciplined" );
        
        if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
        {
            utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_disciplined" );
        }
    }
}

