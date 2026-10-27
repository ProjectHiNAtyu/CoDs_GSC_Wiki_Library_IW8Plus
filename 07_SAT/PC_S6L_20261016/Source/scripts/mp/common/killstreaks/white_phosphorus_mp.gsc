// scripts\mp\common\killstreaks\white_phosphorus_mp.gsc  (hash_125ee02ab7989d2f.gscc) (size: 844 Bytes / 0x34c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdbd0da2c (3687897644)
// size ...... 844 (0x34c)
// includes .. 4   (offset: 0x310)
// strings ... 1   (offset: 0x330)
// dev strs .. 1   (offset: 0x33c)
// exports ... 4   (offset: 0x168)
// cseg ...... 0x6c + 0xfc (0x168)
// imports ... 9   (offset: 0x208)
// animtree1 . 0   (offset: 0x34c)
// animtree2 . 0   (offset: 0x34c)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\mapselect;
#using scripts\mp\common\killstreaks\white_phosphorus;

#namespace white_phosphorus_mp;

// Namespace white_phosphorus_mp
// Params 0
// Checksum 0x8dafcca2, Offset: 0x8a
// Size: 0x4f
function init()
{
    killstreaks::registerkillstreak( "white_phosphorus", &white_phosphorus::tryusewpfromstruct );
    utility::registersharedfunc( #"white_phosphorus", #"hash_bc456c37cf700436", &white_phosphorus_startmapselectsequence );
    utility::registersharedfunc( #"white_phosphorus", #"getselectmappoint", &white_phosphorus_getmapselectpoint );
}

// Namespace white_phosphorus_mp
// Params 4
// Checksum 0x9daca1a3, Offset: 0xe1
// Size: 0x44
function white_phosphorus_startmapselectsequence( navmesh, directionalselection, directionaltype, selectortype )
{
    assert( isplayer( self ), "<dev string:x24>" );
    mapselect::function_74e31405d43e142( navmesh, directionalselection, directionaltype );
}

// Namespace white_phosphorus_mp
// Params 3
// Checksum 0xb71b15fe, Offset: 0x12d
// Size: 0x3a
function white_phosphorus_getmapselectpoint( streakinfo, selectnum, directionalselection )
{
    assert( isplayer( self ), "<dev string:x24>" );
    return mapselect::function_ec95e9f1b6d329fb( streakinfo, selectnum, directionalselection );
}

