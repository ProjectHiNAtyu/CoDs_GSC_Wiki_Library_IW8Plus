// script_6b56d7e66ae770bc  (hash_6b56d7e66ae770bc.gscc) (size: 556 Bytes / 0x22c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6c54f15e (1817506142)
// size ...... 556 (0x22c)
// includes .. 2   (offset: 0x200)
// strings ... 2   (offset: 0x210)
// dev strs .. 0   (offset: 0x22c)
// exports ... 4   (offset: 0x104)
// cseg ...... 0x7a + 0x8a (0x104)
// imports ... 3   (offset: 0x1a4)
// animtree1 . 0   (offset: 0x22c)
// animtree2 . 0   (offset: 0x22c)
#using script_5fbb037f63a7a8a1;
#using scripts\asm\asm;

#namespace namespace_4971355493d96d89;

// Namespace namespace_4971355493d96d89
// Params 0
// Checksum 0x93c7cf77, Offset: 0x98
// Size: 0x40
function function_1adf760b26931d8a()
{
    self.leap_attack_state = "leap_in";
    zombie_leap_attack_asm::function_3d8cd69a5c5394a0( 200, getdvarfloat( @"phobos_leap_end", 0.2 ), getdvarfloat( @"phobos_leap_end", 1 ) );
}

// Namespace namespace_4971355493d96d89
// Params 0
// Checksum 0x2708be78, Offset: 0xe0
// Size: 0xe
function function_f7d845fe8c934a7a()
{
    asm::function_7256f5ba459c840b( "leap_in" );
}

// Namespace namespace_4971355493d96d89
// Params 0
// Checksum 0xcf66a33d, Offset: 0xf6
// Size: 0xe
function function_a842a936c41c5dde()
{
    asm::function_7256f5ba459c840b( "post_leap_attack_in" );
}

