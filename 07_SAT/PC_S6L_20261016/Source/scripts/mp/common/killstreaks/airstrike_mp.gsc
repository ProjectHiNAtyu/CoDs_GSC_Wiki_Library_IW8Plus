// scripts\mp\common\killstreaks\airstrike_mp.gsc  (hash_1855f2d6d50250a8.gscc) (size: 2116 Bytes / 0x844 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13fc4893 (335300755)
// size ...... 2116 (0x844)
// includes .. 6   (offset: 0x768)
// strings ... 9   (offset: 0x798)
// dev strs .. 0   (offset: 0x844)
// exports ... 6   (offset: 0x4e4)
// cseg ...... 0x119 + 0x3cb (0x4e4)
// imports ... 13  (offset: 0x5d4)
// animtree1 . 0   (offset: 0x844)
// animtree2 . 0   (offset: 0x844)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\mapselect;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\spawnlogic;

#namespace airstrike_mp;

// Namespace airstrike_mp
// Params 0
// Checksum 0xbd7afc5, Offset: 0x137
// Size: 0x7a
function init()
{
    utility::registersharedfunc( #"airstrike", #"airstrike_params", &init_airstrike_params );
    utility::registersharedfunc( #"airstrike", #"getselectmappoint", &airstrike_getmapselectpoint );
    utility::registersharedfunc( #"airstrike", #"hash_bc456c37cf700436", &airstrike_startmapselectsequence );
    utility::registersharedfunc( #"airstrike", #"addSpawnInfluencer", &airstrike_addspawninfluencer );
}

// Namespace airstrike_mp
// Params 0
// Checksum 0xd0557422, Offset: 0x1b9
// Size: 0x26e
function init_airstrike_params()
{
    level endon( #"game_ended" );
    
    if ( !level.var_efe904b9522300b6 )
    {
        level waittill( #"hash_64c4c3e529bcdb13" );
    }
    
    level.airstrikesettings = [];
    streakbundles = level.streakglobals.streakbundles;
    bundle = streakbundles[ "precision_airstrike" ];
    
    if ( !level.var_80c8fcefb5ff5fe7 || bundle )
    {
        killstreaks::registerkillstreak( "precision_airstrike", &airstrike::tryuseairstrikefromstruct );
        level.airstrikesettings[ "precision_airstrike" ] = { #deployweaponobj:weapon_utility::function_d2c8356dc369d9ce( bundle.deployweaponname ?? "iw9_spotter_scope_mp" ), #var_a9893cd64762fe63:"ks_airstrike_mp", #modelbase:"veh8_mil_air_alfa10", #streakname:"precision_airstrike" };
    }
    
    bundle = streakbundles[ "napalm_strike" ];
    
    if ( !level.var_80c8fcefb5ff5fe7 || bundle )
    {
        level.airstrikesettings[ "napalm_strike" ] = { #deployweaponobj:weapon_utility::function_d2c8356dc369d9ce( bundle.deployweaponname ?? "iw9_spotter_scope_mp" ), #var_a9893cd64762fe63:"ks_airstrike_mp", #modelbase:"veh8_mil_air_alfa10", #streakname:"napalm_strike" };
    }
    
    bundle = streakbundles[ "multi_airstrike" ];
    
    if ( !level.var_80c8fcefb5ff5fe7 || bundle )
    {
        killstreaks::registerkillstreak( "multi_airstrike", &airstrike::tryuseairstrikefromstruct );
        level.airstrikesettings[ "multi_airstrike" ] = { #deployweaponobj:makeweapon( bundle.deployweaponname ?? mapselect::mapselect_getweapon() ), #var_a9893cd64762fe63:"ks_airstrike_mp", #modelbase:"veh8_mil_air_alfa10", #streakname:"multi_airstrike" };
    }
    
    bundle = streakbundles[ "fuel_airstrike" ];
    
    if ( !level.var_80c8fcefb5ff5fe7 || bundle )
    {
        killstreaks::registerkillstreak( "fuel_airstrike", &airstrike::tryuseairstrikefromstruct );
        level.airstrikesettings[ "fuel_airstrike" ] = { #deployweaponobj:makeweapon( bundle.deployweaponname ?? mapselect::mapselect_getweapon() ), #var_a9893cd64762fe63:"ks_fuelstrike_mp", #modelbase:"veh9_mil_air_suniform25_mp", #streakname:"fuel_airstrike" };
    }
}

// Namespace airstrike_mp
// Params 3
// Checksum 0xce041ba3, Offset: 0x42f
// Size: 0x28
function airstrike_getmapselectpoint( streakinfo, selectnum, directionalselection )
{
    return mapselect::function_ec95e9f1b6d329fb( streakinfo, selectnum, directionalselection );
}

// Namespace airstrike_mp
// Params 5
// Checksum 0x2f6c82dd, Offset: 0x460
// Size: 0x3e
function airstrike_startmapselectsequence( navmesh, directionalselection, directionaltype, selectortype, streakinfo )
{
    mapselect::function_74e31405d43e142( navmesh, directionalselection, directionaltype, selectortype, streakinfo );
}

// Namespace airstrike_mp
// Params 5
// Checksum 0x55e9eb18, Offset: 0x4a6
// Size: 0x3e
function airstrike_addspawninfluencer( influencerdef, pos, friendlyteam, playerowner, parentent )
{
    spawnlogic::addspawninfluencer( influencerdef, pos, friendlyteam, playerowner, parentent );
}

