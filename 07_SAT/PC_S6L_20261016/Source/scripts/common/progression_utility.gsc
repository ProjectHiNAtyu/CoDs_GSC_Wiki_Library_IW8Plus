// scripts\common\progression_utility.gsc  (hash_3f8889c16399185c.gscc) (size: 2484 Bytes / 0x9b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x82deb9d1 (2195634641)
// size ...... 2484 (0x9b4)
// includes .. 0   (offset: 0x954)
// strings ... 2   (offset: 0x954)
// dev strs .. 6   (offset: 0x96c)
// exports ... 16  (offset: 0x544)
// cseg ...... 0x6a + 0x4da (0x544)
// imports ... 12  (offset: 0x7c4)
// animtree1 . 0   (offset: 0x9b4)
// animtree2 . 0   (offset: 0x9b4)
#namespace progression_utility;

// Namespace progression_utility
// Params 0
// Checksum 0xed0678ed, Offset: 0x88
// Size: 0x65
function getranktablebundle()
{
    assert( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.ranktable ), "<dev string:x24>" );
    ranktablebundle = getscriptbundle( level.gamemodebundle.ranktable );
    assert( isdefined( ranktablebundle ), "<dev string:x4d>" );
    return ranktablebundle;
}

// Namespace progression_utility
// Params 1
// Checksum 0x9255747f, Offset: 0xf6
// Size: 0x30
function getrankbundle( rankbundlename )
{
    rankbundle = getscriptbundle( rankbundlename );
    assert( isdefined( rankbundle ), "<dev string:x64>" );
    return rankbundle;
}

// Namespace progression_utility
// Params 1
// Checksum 0x6d1e780e, Offset: 0x12f
// Size: 0x56
function getrankinfostruct( rankid )
{
    ranktablebundle = getranktablebundle();
    assert( length( ranktablebundle.ranklist ) > rankid );
    return getrankbundle( ranktablebundle.ranklist[ rankid ].rank );
}

// Namespace progression_utility
// Params 1
// Checksum 0x3dc3882a, Offset: 0x18e
// Size: 0x1e
function function_17f2711b0e810836( rankid )
{
    return getrankinfostruct( rankid ).ingamerankname;
}

// Namespace progression_utility
// Params 2
// Checksum 0xf178357e, Offset: 0x1b5
// Size: 0x71
function getrankinfoicon( rankid, prestigeid )
{
    ranktablebundle = getranktablebundle();
    
    if ( isdefined( ranktablebundle.prestigeiconlist ) && length( ranktablebundle.prestigeiconlist ) > prestigeid )
    {
        return ranktablebundle.prestigeiconlist[ prestigeid ];
    }
    
    return getrankinfostruct( rankid ).icon;
}

// Namespace progression_utility
// Params 1
// Checksum 0x3e60858d, Offset: 0x22e
// Size: 0x1e
function getrankinfolevel( rankid )
{
    return getrankinfostruct( rankid ).ingamerank;
}

// Namespace progression_utility
// Params 1
// Checksum 0xb0d09036, Offset: 0x255
// Size: 0x22
function getrankinfominxp( rankid )
{
    return level.ranktable[ rankid ].minxp;
}

// Namespace progression_utility
// Params 1
// Checksum 0x749165d9, Offset: 0x280
// Size: 0x22
function getrankinfoxpamt( rankid )
{
    return level.ranktable[ rankid ].xptonext;
}

// Namespace progression_utility
// Params 1
// Checksum 0xb0d09036, Offset: 0x2ab
// Size: 0x22
function getrankinfomaxxp( rankid )
{
    return level.ranktable[ rankid ].maxxp;
}

// Namespace progression_utility
// Params 0
// Checksum 0xa973f160, Offset: 0x2d6
// Size: 0x4f
function getrank()
{
    rankxp = self.pers[ "rankxp" ];
    rankid = self.pers[ "rank" ];
    
    if ( rankxp < getrankinfomaxxp( rankid ) )
    {
        return rankid;
    }
    
    return getrankforxp( rankxp );
}

// Namespace progression_utility
// Params 1
// Checksum 0xeb83d53b, Offset: 0x32e
// Size: 0xb5
function getrankforxp( xpval )
{
    if ( xpval >= getrankinfominxp( level.maxrank ) )
    {
        return level.maxrank;
    }
    
    low = 0;
    high = level.maxrank - 1;
    
    do
    {
        mid = low + high >> 1;
        rank = level.ranktable[ mid ];
        
        if ( rank.maxxp <= xpval )
        {
            low = mid + 1;
            continue;
        }
        
        if ( rank.minxp > xpval )
        {
            high = mid - 1;
            continue;
        }
        
        return mid;
    }
    while ( low <= high );
}

// Namespace progression_utility
// Params 0
// Checksum 0x60af1d0e, Offset: 0x3eb
// Size: 0x65
function getweaponranktablebundle()
{
    assert( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.weaponranktable ), "<dev string:x7a>" );
    weaponranktablebundle = getscriptbundle( level.gamemodebundle.weaponranktable );
    assert( isdefined( weaponranktablebundle ), "<dev string:xa9>" );
    return weaponranktablebundle;
}

// Namespace progression_utility
// Params 0
// Checksum 0x4b58ee04, Offset: 0x459
// Size: 0x52
function function_7bde1faea3e37e6()
{
    assert( isdefined( level.gamemodebundle ) );
    
    if ( !isdefined( level.gamemodebundle.var_d7d85d1113d7d3d2 ) )
    {
        return;
    }
    
    var_8dfdaabeb8f5f04a = getscriptbundle( level.gamemodebundle.var_d7d85d1113d7d3d2 );
    return var_8dfdaabeb8f5f04a;
}

// Namespace progression_utility
// Params 1
// Checksum 0x8ce084b8, Offset: 0x4b4
// Size: 0x30
function function_7602a04bc7c08c34( rankbundlename )
{
    weaponrankbundle = getscriptbundle( rankbundlename );
    assert( isdefined( weaponrankbundle ), "<dev string:xca>" );
    return weaponrankbundle;
}

// Namespace progression_utility
// Params 1
// Checksum 0x82f2d089, Offset: 0x4ed
// Size: 0x56
function getweaponranktableentry( rankid )
{
    ranktablebundle = getweaponranktablebundle();
    assert( length( ranktablebundle.weaponranklist ) > rankid );
    return getrankbundle( ranktablebundle.weaponranklist[ rankid ].rank );
}

