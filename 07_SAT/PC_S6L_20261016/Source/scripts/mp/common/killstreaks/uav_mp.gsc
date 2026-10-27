// scripts\mp\common\killstreaks\uav_mp.gsc  (hash_2d72416e525b6efe.gscc) (size: 3389 Bytes / 0xd3d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51aa5ccb (1370119371)
// size ...... 3389 (0xd3d)
// includes .. 5   (offset: 0xb89)
// strings ... 17  (offset: 0xbb1)
// dev strs .. 0   (offset: 0xd3d)
// exports ... 4   (offset: 0x919)
// cseg ...... 0x1fd + 0x71c (0x919)
// imports ... 15  (offset: 0x9b9)
// animtree1 . 0   (offset: 0xd3d)
// animtree2 . 0   (offset: 0xd3d)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\remoteuav;
#using scripts\mp\common\killstreaks\uav;

#namespace uav_mp;

// Namespace uav_mp
// Params 0
// Checksum 0x74ae9b, Offset: 0x21b
// Size: 0x415
function init_uav_mp()
{
    killstreaks::registerkillstreak( "uav", &uav::tryuseuavfromstruct );
    killstreaks::registerkillstreak( "counter_uav", &uav::tryuseuavfromstruct );
    killstreaks::registerkillstreak( "directional_uav", &uav::tryuseuavfromstruct );
    uav_bundle = level.streakglobals.streakbundles[ "uav" ];
    level.radarviewtime = uav_bundle.var_8ba0de493efe1af9 ?? 25;
    level.uavsettings = [];
    level.uavsettings[ "uav" ] = spawnstruct();
    level.uavsettings[ "uav" ].timeout = level.radarviewtime;
    level.uavsettings[ "uav" ].health = 999999;
    level.uavsettings[ "uav" ].maxhealth = uav_bundle.maxhealth ?? 450;
    level.uavsettings[ "uav" ].streakname = "uav";
    level.uavsettings[ "uav" ].modelbase = uav_bundle.uavxcompositemodel ?? uav_bundle.uavmodel ?? "veh9_mil_air_uav_small_mp";
    level.uavsettings[ "uav" ].sound_explode = "mp_uav_explo_dist";
    level.uavsettings[ "uav" ].teamsplash = uav_bundle.usedsplashref ?? #"used_uav";
    level.uavsettings[ "uav" ].votimeout = "timeout_uav";
    level.uavsettings[ "uav" ].calloutdestroyed = "callout_destroyed_uav";
    level.uavsettings[ "uav" ].addfunc = &uav::uav_addactiveuav;
    level.uavsettings[ "uav" ].removefunc = &uav::uav_removeactiveuav;
    init_counter_uav();
    auav_bundle = level.streakglobals.streakbundles[ "directional_uav" ] ?? spawnstruct();
    level.uavsettings[ "directional_uav" ] = spawnstruct();
    level.uavsettings[ "directional_uav" ].timeout = auav_bundle.var_8ba0de493efe1af9 ?? getdvarint( @"hash_9f9e7d3a7b0b123d", 50 );
    level.uavsettings[ "directional_uav" ].health = 999999;
    level.uavsettings[ "directional_uav" ].maxhealth = auav_bundle.maxhealth ?? 2000;
    level.uavsettings[ "directional_uav" ].streakname = "directional_uav";
    level.uavsettings[ "directional_uav" ].modelbase = auav_bundle.auavmodel ?? "veh9_mil_air_uav_small_mp";
    level.uavsettings[ "directional_uav" ].votimeout = "timeout_directional_uav";
    level.uavsettings[ "directional_uav" ].teamsplash = auav_bundle.usedsplashref ?? #"used_directional_uav";
    level.uavsettings[ "directional_uav" ].addfunc = &uav::uav_addactiveuav;
    level.uavsettings[ "directional_uav" ].removefunc = &uav::uav_removeactiveuav;
    callback::add( #"player_spawned", &uav::onplayerspawned );
    utility::registersharedfunc( #"uav", #"hash_9506ae4b51f5cbf0", &remoteuav::remoteuav_processtaggedassist );
    utility::registersharedfunc( #"uav", #"attachxrays", &uav_attachxrays );
}

// Namespace uav_mp
// Params 0
// Checksum 0x2bdeb70, Offset: 0x638
// Size: 0x2b6
function init_counter_uav()
{
    cuav_bundle = level.streakglobals.streakbundles[ "counter_uav" ];
    
    if ( !isdefined( cuav_bundle ) )
    {
        cuav_bundle = spawnstruct();
    }
    
    level.uavsettings[ "counter_uav" ] = spawnstruct();
    level.uavsettings[ "counter_uav" ].timeout = cuav_bundle.var_8ba0de493efe1af9 ?? 23;
    level.uavsettings[ "counter_uav" ].health = 999999;
    level.uavsettings[ "counter_uav" ].maxhealth = cuav_bundle.maxhealth ?? 800;
    level.uavsettings[ "counter_uav" ].streakname = "counter_uav";
    level.uavsettings[ "counter_uav" ].modelbase = cuav_bundle.cuavxcompositemodel ?? cuav_bundle.cuavmodel ?? "veh8_mil_air_cuniform";
    level.uavsettings[ "counter_uav" ].modelbasealt = cuav_bundle.var_961feb0fe7272197 ?? cuav_bundle.cuavmodel_alt ?? "veh8_mil_air_cuniform_east";
    level.uavsettings[ "counter_uav" ].fx_leave_tag = "tag_origin";
    level.uavsettings[ "counter_uav" ].sound_explode = "scrambler_drone_explode";
    level.uavsettings[ "counter_uav" ].votimeout = "counter_uav_timeout";
    level.uavsettings[ "counter_uav" ].vodestroyed = "destroyed_scrambler_drone_guard";
    level.uavsettings[ "counter_uav" ].votimedout = "timeout_scrambler_drone_guard";
    level.uavsettings[ "counter_uav" ].teamsplash = cuav_bundle.usedsplashref ?? #"used_scrambler_drone_guard";
    level.uavsettings[ "counter_uav" ].destroyedsplash = "callout_destroyed_scrambler_drone_guard";
    level.uavsettings[ "counter_uav" ].scorepopup = "destroyed_scrambler_drone_guard";
    level.uavsettings[ "counter_uav" ].calloutdestroyed = "callout_destroyed_counter_uav";
    level.uavsettings[ "counter_uav" ].addfunc = &uav::uav_addactivecounteruav;
    level.uavsettings[ "counter_uav" ].removefunc = &uav::uav_removeactivecounteruav;
}

// Namespace uav_mp
// Params 1
// Checksum 0x1f3f8727, Offset: 0x8f6
// Size: 0x22
function uav_attachxrays( uavmodel )
{
    uavmodel setentityhudoutlinedata( 3, uavmodel.team );
    return uavmodel;
}

