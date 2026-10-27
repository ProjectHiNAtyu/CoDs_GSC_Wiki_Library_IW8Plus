// scripts\anim\weaponlist.gsc  (hash_76ff4ba096a6f8aa.gscc) (size: 1781 Bytes / 0x6f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x581267a4 (1477601188)
// size ...... 1781 (0x6f5)
// includes .. 1   (offset: 0x689)
// strings ... 6   (offset: 0x691)
// dev strs .. 2   (offset: 0x6dd)
// exports ... 10  (offset: 0x369)
// cseg ...... 0x90 + 0x2d9 (0x369)
// imports ... 13  (offset: 0x4f9)
// animtree1 . 0   (offset: 0x6f5)
// animtree2 . 0   (offset: 0x6f5)
#using scripts\anim\utility_common;

#namespace weaponlist;

// Namespace weaponlist
// Params 0
// Checksum 0x7f862567, Offset: 0xae
// Size: 0x33, Type: bool
function usingautomaticweapon()
{
    return weaponisauto( self.weapon ) || weaponisbeam( self.weapon ) || weaponburstcount( self.weapon ) > 0;
}

// Namespace weaponlist
// Params 0
// Checksum 0xe1c3420f, Offset: 0xea
// Size: 0x23, Type: bool
function usingsemiautoweapon()
{
    return weaponissemiauto( self.weapon ) || weaponburstcount( self.weapon ) == 1;
}

// Namespace weaponlist
// Params 0
// Checksum 0x9ca8eed9, Offset: 0x116
// Size: 0x28
function autoshootanimrate()
{
    if ( usingautomaticweapon() )
    {
        return ( 0.1 / weaponfiretime( self.weapon ) );
    }
    
    return 0.5;
}

// Namespace weaponlist
// Params 0
// Checksum 0x6f1cea2a, Offset: 0x146
// Size: 0x40
function burstshootanimrate()
{
    if ( usingautomaticweapon() )
    {
        return ( 0.1 / weaponfiretime( self.weapon ) );
    }
    
    if ( utility_common::ispistol( self.weapon ) )
    {
        return 1;
    }
    
    return 0.2;
}

// Namespace weaponlist
// Params 0
// Checksum 0x48e62eb9, Offset: 0x18e
// Size: 0x7
function waitaftershot()
{
    return 0.25;
}

// Namespace weaponlist
// Params 1
// Checksum 0x1a3f2d38, Offset: 0x19e
// Size: 0x59
function shootanimtime( semiautofire )
{
    if ( !usingautomaticweapon() || semiautofire == 1 )
    {
        rand = 0.5 + randomfloat( 1 );
        return ( weaponfiretime( self.weapon ) * rand );
    }
    
    return weaponfiretime( self.weapon );
}

// Namespace weaponlist
// Params 0
// Checksum 0x5d7955d7, Offset: 0x1ff
// Size: 0x6d
function refillclip()
{
    assert( isdefined( self.weapon ), "<dev string:x24>" + self.model );
    
    if ( isnullweapon( self.weapon ) )
    {
        self.bulletsinclip = 0;
        return 0;
    }
    
    self.bulletsinclip = weaponclipsize( self.weapon );
    assert( self.bulletsinclip > 0, "<dev string:x44>" );
}

// Namespace weaponlist
// Params 5
// Checksum 0xe11baf1a, Offset: 0x274
// Size: 0xc5
function add_weapon( name, type, time, clipsize, anims )
{
    assert( isdefined( name ) );
    assert( isdefined( type ) );
    
    if ( !isdefined( time ) )
    {
        time = 3;
    }
    
    if ( !isdefined( clipsize ) )
    {
        time = 1;
    }
    
    if ( !isdefined( anims ) )
    {
        anims = "rifle";
    }
    
    name = tolower( name );
    anim.aiweapon[ name ][ "type" ] = type;
    anim.aiweapon[ name ][ "time" ] = time;
    anim.aiweapon[ name ][ "clipsize" ] = clipsize;
    anim.aiweapon[ name ][ "anims" ] = anims;
}

// Namespace weaponlist
// Params 1
// Checksum 0xf3b3ef56, Offset: 0x341
// Size: 0x28
function addturret( turret )
{
    anim.aiweapon[ tolower( turret ) ][ "type" ] = "turret";
}

