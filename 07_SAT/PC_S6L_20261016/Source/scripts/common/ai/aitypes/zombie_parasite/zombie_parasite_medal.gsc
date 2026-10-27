// scripts\common\ai\aitypes\zombie_parasite\zombie_parasite_medal.gsc  (hash_0b09f2ef46511520.gscc) (size: 846 Bytes / 0x34e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x36ed3957 (921516375)
// size ...... 846 (0x34e)
// includes .. 2   (offset: 0x332)
// strings ... 1   (offset: 0x342)
// dev strs .. 0   (offset: 0x34e)
// exports ... 3   (offset: 0x212)
// cseg ...... 0x62 + 0x1b0 (0x212)
// imports ... 6   (offset: 0x28a)
// animtree1 . 0   (offset: 0x34e)
// animtree2 . 0   (offset: 0x34e)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;

#namespace zombie_parasite_medal;

// Namespace zombie_parasite_medal
// Params 0
// Checksum 0x7eef1038, Offset: 0x80
// Size: 0x45
function function_774fb122cb5c4051()
{
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", self.animsetname, &on_killed_medal );
    }
}

// Namespace zombie_parasite_medal
// Params 4, eflags: 0x4
// Checksum 0x13e6e063, Offset: 0xcd
// Size: 0x145
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( sweapon.type == "bullet" )
    {
        if ( !isdefined( self.var_150ee05c0fbb5037 ) )
        {
            self.var_150ee05c0fbb5037 = { #killcount:1, #triggerid:self.var_30f392ef3b86faf0 };
            return;
        }
        
        if ( self.var_150ee05c0fbb5037.triggerid != self.var_30f392ef3b86faf0 )
        {
            self.var_150ee05c0fbb5037.triggerid = self.var_30f392ef3b86faf0;
            self.var_150ee05c0fbb5037.killcount = 1;
            return;
        }
        
        self.var_150ee05c0fbb5037.killcount++;
        
        if ( self.var_150ee05c0fbb5037.killcount % 3 == 0 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_antiparasitic" );
        }
        
        if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
        {
            utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_antiparasitic" );
        }
    }
}

