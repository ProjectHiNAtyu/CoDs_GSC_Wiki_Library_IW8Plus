// scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos_medal.gsc  (hash_2faa30bb9b211e74.gscc) (size: 585 Bytes / 0x249 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec4aa3d0 (3964314576)
// size ...... 585 (0x249)
// includes .. 2   (offset: 0x239)
// strings ... 0   (offset: 0x249)
// dev strs .. 0   (offset: 0x249)
// exports ... 3   (offset: 0x135)
// cseg ...... 0x58 + 0xdd (0x135)
// imports ... 5   (offset: 0x1ad)
// animtree1 . 0   (offset: 0x249)
// animtree2 . 0   (offset: 0x249)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;

#namespace zombie_karkinos_medal;

// Namespace zombie_karkinos_medal
// Params 0
// Checksum 0xf0b437f8, Offset: 0x76
// Size: 0x45
function function_837d19342ee3d28a()
{
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", self.animsetname, &on_killed_medal );
    }
}

// Namespace zombie_karkinos_medal
// Params 4, eflags: 0x4
// Checksum 0x10f2ecb6, Offset: 0xc3
// Size: 0x72
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( victim.shield_is_on && victim.var_fd553a3e336c17f7 < gettime() && victim.last_dmg_struct.biscritical )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_shieldbreaker" );
    }
}

