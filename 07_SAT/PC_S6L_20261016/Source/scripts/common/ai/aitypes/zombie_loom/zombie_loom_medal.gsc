// scripts\common\ai\aitypes\zombie_loom\zombie_loom_medal.gsc  (hash_56fb7c2044a9e31c.gscc) (size: 537 Bytes / 0x219 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd0aac1c1 (3500851649)
// size ...... 537 (0x219)
// includes .. 2   (offset: 0x209)
// strings ... 0   (offset: 0x219)
// dev strs .. 0   (offset: 0x219)
// exports ... 3   (offset: 0x11d)
// cseg ...... 0x58 + 0xc5 (0x11d)
// imports ... 4   (offset: 0x195)
// animtree1 . 0   (offset: 0x219)
// animtree2 . 0   (offset: 0x219)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;

#namespace zombie_loom_medal;

// Namespace zombie_loom_medal
// Params 0
// Checksum 0x3fe8dfc0, Offset: 0x76
// Size: 0x45
function function_b19f39e07ee0d40d()
{
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", self.animsetname, &on_killed_medal );
    }
}

// Namespace zombie_loom_medal
// Params 4, eflags: 0x4
// Checksum 0xcda69a77, Offset: 0xc3
// Size: 0x5a
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( !istrue( victim.var_865aafa52f1e6798 ) )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_arachnophobia" );
        return;
    }
    
    namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_35829f0b13d93fb9" );
}

