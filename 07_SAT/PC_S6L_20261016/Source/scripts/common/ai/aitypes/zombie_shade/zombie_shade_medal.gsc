// scripts\common\ai\aitypes\zombie_shade\zombie_shade_medal.gsc  (hash_7343985786c83be6.gscc) (size: 670 Bytes / 0x29e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ea80038 (2661810232)
// size ...... 670 (0x29e)
// includes .. 2   (offset: 0x28e)
// strings ... 0   (offset: 0x29e)
// dev strs .. 0   (offset: 0x29e)
// exports ... 3   (offset: 0x186)
// cseg ...... 0x58 + 0x12e (0x186)
// imports ... 5   (offset: 0x1fe)
// animtree1 . 0   (offset: 0x29e)
// animtree2 . 0   (offset: 0x29e)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;

#namespace zombie_shade_medal;

// Namespace zombie_shade_medal
// Params 0
// Checksum 0x5a705d69, Offset: 0x76
// Size: 0x45
function function_9b70bb641b6d50cb()
{
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", self.animsetname, &on_killed_medal );
    }
}

// Namespace zombie_shade_medal
// Params 4, eflags: 0x4
// Checksum 0x2fedfca8, Offset: 0xc3
// Size: 0xc3
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", victim.subclass );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ victim.subclass ] ) && self.rapidkill_data[ victim.subclass ].rapidkill_count === 5 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_staydown" );
        }
    }
}

