// script_262824aef921ad87  (hash_262824aef921ad87.gscc) (size: 671 Bytes / 0x29f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf872188d (4168226957)
// size ...... 671 (0x29f)
// includes .. 2   (offset: 0x27b)
// strings ... 1   (offset: 0x28b)
// dev strs .. 0   (offset: 0x29f)
// exports ... 3   (offset: 0x13f)
// cseg ...... 0x6c + 0xd3 (0x13f)
// imports ... 7   (offset: 0x1b7)
// animtree1 . 0   (offset: 0x29f)
// animtree2 . 0   (offset: 0x29f)
#using scripts\common\callbacks;
#using scripts\mp\loot\common_cache;

#namespace specialty_looter;

// Namespace specialty_looter
// Params 0, eflags: 0x1
// Checksum 0xcb94f11, Offset: 0x8a
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"lootCacheAddAdditionalLoot", &addadditionalloot );
}

// Namespace specialty_looter
// Params 1, eflags: 0x4
// Checksum 0x6d706b87, Offset: 0xaa
// Size: 0x95
function private addadditionalloot( params )
{
    if ( isplayer( self ) && self hasperk( "specialty_looter" ) )
    {
        chance = level.perkbundles[ "specialty_looter" ].looter_chance;
        
        if ( randomfloat( 100 ) < chance )
        {
            var_cab6559204c0e0d6 = common_cache::function_73fc13f2febd3a2( "specialty_looter" );
            common_cache::function_a136b84fc5c0dfab( params.cache, var_cab6559204c0e0d6.spawnlist, var_cab6559204c0e0d6.spawncount, 1 );
        }
    }
}

