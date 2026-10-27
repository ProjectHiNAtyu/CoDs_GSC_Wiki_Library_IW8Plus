// scripts\mp\common\killstreaks\emp_drone_targeted_mp.gsc  (hash_2ec3d5d1dd2335ac.gscc) (size: 838 Bytes / 0x346 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3904e169 (956621161)
// size ...... 838 (0x346)
// includes .. 3   (offset: 0x32e)
// strings ... 0   (offset: 0x346)
// dev strs .. 0   (offset: 0x346)
// exports ... 5   (offset: 0x19a)
// cseg ...... 0x58 + 0x142 (0x19a)
// imports ... 7   (offset: 0x262)
// animtree1 . 0   (offset: 0x346)
// animtree2 . 0   (offset: 0x346)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\mapselect;
#using scripts\mp\damage;

#namespace emp_drone_targeted_mp;

// Namespace emp_drone_targeted_mp
// Params 0
// Checksum 0x32749083, Offset: 0x76
// Size: 0x5c
function init()
{
    utility::registersharedfunc( #"empdronetargeted", #"getselectmappoint", &emp_drone_targeted_getmapselectpoint );
    utility::registersharedfunc( #"empdronetargeted", #"hash_bc456c37cf700436", &emp_drone_targeted_startmapselectsequence );
    utility::registersharedfunc( #"empdronetargeted", #"monitordamage", &emp_drone_targeted_monitordamage );
}

// Namespace emp_drone_targeted_mp
// Params 3
// Checksum 0xd3e21675, Offset: 0xda
// Size: 0x28
function emp_drone_targeted_getmapselectpoint( streakinfo, selectnum, directionalselection )
{
    return mapselect::function_ec95e9f1b6d329fb( streakinfo, selectnum, directionalselection );
}

// Namespace emp_drone_targeted_mp
// Params 4
// Checksum 0xa9197707, Offset: 0x10b
// Size: 0x34
function emp_drone_targeted_startmapselectsequence( navmesh, directionalselection, directionaltype, selectortype )
{
    mapselect::function_74e31405d43e142( navmesh, directionalselection, directionaltype, selectortype );
}

// Namespace emp_drone_targeted_mp
// Params 7
// Checksum 0x7617779c, Offset: 0x147
// Size: 0x53
function emp_drone_targeted_monitordamage( maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken )
{
    damage::monitordamage( maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken );
}

