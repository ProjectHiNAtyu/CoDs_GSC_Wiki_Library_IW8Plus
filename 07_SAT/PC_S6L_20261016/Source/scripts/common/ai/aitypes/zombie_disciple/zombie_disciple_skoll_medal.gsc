// scripts\common\ai\aitypes\zombie_disciple\zombie_disciple_skoll_medal.gsc  (hash_7ea6a500235b9e44.gscc) (size: 630 Bytes / 0x276 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c7c303e (1014771774)
// size ...... 630 (0x276)
// includes .. 2   (offset: 0x266)
// strings ... 0   (offset: 0x276)
// dev strs .. 0   (offset: 0x276)
// exports ... 3   (offset: 0x146)
// cseg ...... 0x58 + 0xee (0x146)
// imports ... 6   (offset: 0x1be)
// animtree1 . 0   (offset: 0x276)
// animtree2 . 0   (offset: 0x276)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;

#namespace zombie_disciple_skoll_medal;

// Namespace zombie_disciple_skoll_medal
// Params 0
// Checksum 0x7ee014ae, Offset: 0x76
// Size: 0x45
function function_17a7f10d4c86dd8f()
{
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", self.animsetname, &on_killed_medal );
    }
}

// Namespace zombie_disciple_skoll_medal
// Params 4, eflags: 0x4
// Checksum 0x53f75b7, Offset: 0xc3
// Size: 0x83
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( !victim.var_767be00663f05e7c )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_prophetic" );
        
        if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
        {
            utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_prophetic" );
        }
    }
}

