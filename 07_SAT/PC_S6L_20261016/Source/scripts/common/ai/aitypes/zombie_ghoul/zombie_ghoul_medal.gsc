// scripts\common\ai\aitypes\zombie_ghoul\zombie_ghoul_medal.gsc  (hash_4fc8c3b82dff2cee.gscc) (size: 660 Bytes / 0x294 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x885393d0 (2287178704)
// size ...... 660 (0x294)
// includes .. 2   (offset: 0x284)
// strings ... 0   (offset: 0x294)
// dev strs .. 0   (offset: 0x294)
// exports ... 3   (offset: 0x164)
// cseg ...... 0x58 + 0x10c (0x164)
// imports ... 6   (offset: 0x1dc)
// animtree1 . 0   (offset: 0x294)
// animtree2 . 0   (offset: 0x294)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;

#namespace zombie_ghoul_medal;

// Namespace zombie_ghoul_medal
// Params 0
// Checksum 0xed792bce, Offset: 0x76
// Size: 0x45
function function_c4fe4b7bc84836a7()
{
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", self.animsetname, &on_killed_medal );
    }
}

// Namespace zombie_ghoul_medal
// Params 4, eflags: 0x4
// Checksum 0x4c370639, Offset: 0xc3
// Size: 0xa1
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( isdefined( victim ) && victim.var_da701e38d0bbf750 )
    {
        if ( victim.last_dmg_struct.biscritical )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_domed" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_domed" );
            }
        }
    }
}

