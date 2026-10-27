// scripts\common\ai\aitypes\zombie_abom\zombie_abom_medal.gsc  (hash_4ae5a886f2360ac8.gscc) (size: 542 Bytes / 0x21e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xce604b92 (3462417298)
// size ...... 542 (0x21e)
// includes .. 2   (offset: 0x20e)
// strings ... 0   (offset: 0x21e)
// dev strs .. 0   (offset: 0x21e)
// exports ... 3   (offset: 0x122)
// cseg ...... 0x58 + 0xca (0x122)
// imports ... 4   (offset: 0x19a)
// animtree1 . 0   (offset: 0x21e)
// animtree2 . 0   (offset: 0x21e)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;

#namespace zombie_abom_medal;

// Namespace zombie_abom_medal
// Params 0
// Checksum 0xdad3bf58, Offset: 0x76
// Size: 0x45
function function_69609f334e1c25a7()
{
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", self.animsetname, &on_killed_medal );
    }
}

// Namespace zombie_abom_medal
// Params 4, eflags: 0x4
// Checksum 0x6276d2e8, Offset: 0xc3
// Size: 0x5f
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_decapitated" );
    
    if ( victim.last_dmg_struct.var_64c8bb12f016e6ac )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_opportunist" );
    }
}

