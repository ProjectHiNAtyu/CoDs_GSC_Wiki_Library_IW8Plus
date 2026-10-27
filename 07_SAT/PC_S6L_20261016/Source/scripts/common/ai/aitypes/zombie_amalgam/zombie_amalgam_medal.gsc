// scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_medal.gsc  (hash_0f5fde6d7a94a9dc.gscc) (size: 570 Bytes / 0x23a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x215174ff (558986495)
// size ...... 570 (0x23a)
// includes .. 2   (offset: 0x22a)
// strings ... 0   (offset: 0x23a)
// dev strs .. 0   (offset: 0x23a)
// exports ... 3   (offset: 0x13a)
// cseg ...... 0x58 + 0xe2 (0x13a)
// imports ... 4   (offset: 0x1b2)
// animtree1 . 0   (offset: 0x23a)
// animtree2 . 0   (offset: 0x23a)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;

#namespace zombie_amalgam_medal;

// Namespace zombie_amalgam_medal
// Params 0
// Checksum 0x1f847a9a, Offset: 0x76
// Size: 0x45
function function_3e2ebd0315b2a350()
{
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", self.animsetname, &on_killed_medal );
    }
}

// Namespace zombie_amalgam_medal
// Params 4, eflags: 0x4
// Checksum 0x8616fab0, Offset: 0xc3
// Size: 0x77
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_exorcised" );
    
    if ( victim.var_1e965f25e58fcda6 >= 5 )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_amputator" );
    }
    
    if ( !victim.var_19c07e250767547 )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_malpractice" );
    }
}

