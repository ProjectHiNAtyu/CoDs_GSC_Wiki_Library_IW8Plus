// scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_medal.gsc  (hash_0402c1890bb8c82c.gscc) (size: 663 Bytes / 0x297 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d4034e2 (2101359842)
// size ...... 663 (0x297)
// includes .. 2   (offset: 0x26f)
// strings ... 2   (offset: 0x27f)
// dev strs .. 0   (offset: 0x297)
// exports ... 3   (offset: 0x17f)
// cseg ...... 0x75 + 0x10a (0x17f)
// imports ... 4   (offset: 0x1f7)
// animtree1 . 0   (offset: 0x297)
// animtree2 . 0   (offset: 0x297)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;

#namespace zombie_callisto_medal;

// Namespace zombie_callisto_medal
// Params 0
// Checksum 0x4f50a97b, Offset: 0x93
// Size: 0x45
function function_8d0fb4f96269b349()
{
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", self.animsetname, &on_killed_medal );
    }
}

// Namespace zombie_callisto_medal
// Params 4, eflags: 0x4
// Checksum 0x25949950, Offset: 0xe0
// Size: 0x9f
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( smeansofdeath == "MOD_MELEE" )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_bearessentials" );
        return;
    }
    
    if ( victim.last_dmg_struct.metabonename == "hive_stomach" && victim.last_dmg_struct.biscritical )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_forcedhibernation" );
        return;
    }
    
    namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_toothandclaw" );
}

