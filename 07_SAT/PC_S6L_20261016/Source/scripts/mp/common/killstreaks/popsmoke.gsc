// scripts\mp\common\killstreaks\popsmoke.gsc  (hash_50f73f1e6d92dfea.gscc) (size: 734 Bytes / 0x2de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf190334f (4052759375)
// size ...... 734 (0x2de)
// includes .. 1   (offset: 0x2b2)
// strings ... 3   (offset: 0x2ba)
// dev strs .. 0   (offset: 0x2de)
// exports ... 2   (offset: 0x19e)
// cseg ...... 0x89 + 0x115 (0x19e)
// imports ... 7   (offset: 0x1ee)
// animtree1 . 0   (offset: 0x2de)
// animtree2 . 0   (offset: 0x2de)
#using scripts\common\utility;

#namespace popsmoke;

// Namespace popsmoke
// Params 1
// Checksum 0x1aaded0d, Offset: 0xa7
// Size: 0xf7
function popsmoke_deploy( smoketags = [ "tag_origin" ] )
{
    if ( !isarray( smoketags ) )
    {
        smoketags = [ smoketags ];
    }
    
    owner = self.owner;
    
    foreach ( tag in smoketags )
    {
        utility::function_7c10ea82c1e305b8( tag, "popsmoke" );
        grenade = magicgrenademanual( "popsmoke_grenade_mp", self gettagorigin( tag ), anglestoup( self gettagangles( tag ) ) * 300 );
        grenade.owner = owner;
        wait 0.25;
    }
}

