// scripts\mp\common\weapons\sat_sh_husky_gl.gsc  (hash_1b361cbc569e5447.gscc) (size: 773 Bytes / 0x305 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5cc1aa9d (1556195997)
// size ...... 773 (0x305)
// includes .. 2   (offset: 0x2d1)
// strings ... 3   (offset: 0x2e1)
// dev strs .. 0   (offset: 0x305)
// exports ... 4   (offset: 0x189)
// cseg ...... 0xa1 + 0xe8 (0x189)
// imports ... 6   (offset: 0x229)
// animtree1 . 0   (offset: 0x305)
// animtree2 . 0   (offset: 0x305)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace sat_sh_husky_gl;

// Namespace sat_sh_husky_gl
// Params 0, eflags: 0x1
// Checksum 0x7ab87b0d, Offset: 0xbf
// Size: 0x18
function autoexec function_742ae6d3977da39a()
{
    level callback::add( #"grenade_fire", &function_8d01b181124fac40 );
}

// Namespace sat_sh_husky_gl
// Params 1
// Checksum 0x2af8bda4, Offset: 0xdf
// Size: 0x5a
function function_8d01b181124fac40( grenadedata )
{
    grenade = grenadedata.grenade;
    
    if ( grenade.weapon_name != "sat_sh_husky_mp" )
    {
        return;
    }
    
    if ( !grenade.weapon_object hasattachment( "sat_firemod_firetype_gl_sh_husky" ) )
    {
        return;
    }
    
    grenade thread function_744d070e5fa6aac8();
}

// Namespace sat_sh_husky_gl
// Params 0, eflags: 0x4
// Checksum 0x3fd0faa7, Offset: 0x141
// Size: 0x48
function private function_744d070e5fa6aac8()
{
    self endon( #"death" );
    self waittill( #"missile_impact", hitent, pos );
    utility::waittill_any_timeout( 0.15, "missile_impact" );
    self detonate();
}

