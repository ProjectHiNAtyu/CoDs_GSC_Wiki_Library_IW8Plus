// scripts\mp\minefields.gsc  (hash_16b87c6b95574bd0.gscc) (size: 1025 Bytes / 0x401 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72b0f6e7 (1924200167)
// size ...... 1025 (0x401)
// includes .. 1   (offset: 0x3c9)
// strings ... 4   (offset: 0x3d1)
// dev strs .. 0   (offset: 0x401)
// exports ... 4   (offset: 0x211)
// cseg ...... 0xab + 0x166 (0x211)
// imports ... 10  (offset: 0x2b1)
// animtree1 . 0   (offset: 0x401)
// animtree2 . 0   (offset: 0x401)
#using scripts\mp\flags;

#namespace minefields;

// Namespace minefields
// Params 0
// Checksum 0x275d5ff6, Offset: 0xc9
// Size: 0x65
function minefields()
{
    minefields = getentarray( "minefield", #targetname );
    
    if ( minefields.size > 0 )
    {
        level._effect[ "mine_explosion" ] = loadfxasset( "vfx_core_explo_weap_gre_dirt_cg" );
    }
    
    for ( i = 0; i < minefields.size ; i++ )
    {
        minefields[ i ] thread minefield_think();
    }
}

// Namespace minefields
// Params 0
// Checksum 0xb41d3f20, Offset: 0x136
// Size: 0x42
function minefield_think()
{
    flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        self waittill( #"trigger", other );
        
        if ( isplayer( other ) )
        {
            other thread minefield_kill( self );
        }
    }
}

// Namespace minefields
// Params 1
// Checksum 0x52054ba4, Offset: 0x180
// Size: 0x91
function minefield_kill( trigger )
{
    if ( isdefined( self.minefield ) )
    {
        return;
    }
    
    self.minefield = 1;
    wait 0.5;
    wait randomfloat( 0.5 );
    
    if ( isdefined( self ) && self istouching( trigger ) )
    {
        origin = self getorigin();
        range = 300;
        maxdamage = 2000;
        mindamage = 50;
        radiusdamage( origin, range, maxdamage, mindamage );
    }
    
    self.minefield = undefined;
}

