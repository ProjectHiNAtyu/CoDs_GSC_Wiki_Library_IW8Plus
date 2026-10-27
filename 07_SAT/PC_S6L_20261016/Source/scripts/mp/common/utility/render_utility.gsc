// scripts\mp\common\utility\render_utility.gsc  (hash_69b805511ed79cb8.gscc) (size: 824 Bytes / 0x338 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5008f796 (1342764950)
// size ...... 824 (0x338)
// includes .. 0   (offset: 0x2f8)
// strings ... 4   (offset: 0x2f8)
// dev strs .. 0   (offset: 0x338)
// exports ... 3   (offset: 0x200)
// cseg ...... 0xf7 + 0x109 (0x200)
// imports ... 3   (offset: 0x278)
// animtree1 . 0   (offset: 0x338)
// animtree2 . 0   (offset: 0x338)
#namespace render_utility;

// Namespace render_utility
// Params 4
// Checksum 0xcf969a04, Offset: 0x115
// Size: 0x8a
function function_2636a65c7f96feff( aberration, radius, strength, distortion )
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    
    if ( isdefined( aberration ) )
    {
        self setclientomnvar( "chromatic_aberration_override", aberration );
    }
    
    if ( isdefined( radius ) )
    {
        self setclientomnvar( "chromatic_aberration_radius_override", radius );
    }
    
    if ( isdefined( strength ) )
    {
        self setclientomnvar( "chromatic_aberration_strength_override", strength );
    }
    
    if ( isdefined( distortion ) )
    {
        self setclientomnvar( "chromatic_aberration_distortion_override", distortion );
    }
}

// Namespace render_utility
// Params 0
// Checksum 0x7c00b15c, Offset: 0x1a7
// Size: 0x59
function function_7d5ac95f0cd3294a()
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    self setclientomnvar( "chromatic_aberration_override", 0 );
    self setclientomnvar( "chromatic_aberration_radius_override", 0 );
    self setclientomnvar( "chromatic_aberration_strength_override", 0 );
    self setclientomnvar( "chromatic_aberration_distortion_override", 0 );
}

