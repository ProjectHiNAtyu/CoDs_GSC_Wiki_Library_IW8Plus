// script_1ee31ed331a67edd  (hash_1ee31ed331a67edd.gscc) (size: 1576 Bytes / 0x628 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c72c1c5 (2087895493)
// size ...... 1576 (0x628)
// includes .. 6   (offset: 0x5ec)
// strings ... 1   (offset: 0x61c)
// dev strs .. 0   (offset: 0x628)
// exports ... 8   (offset: 0x2a0)
// cseg ...... 0x60 + 0x240 (0x2a0)
// imports ... 18  (offset: 0x3e0)
// animtree1 . 0   (offset: 0x628)
// animtree2 . 0   (offset: 0x628)
#using scripts\common\objective_marker_bundle_helper;
#using scripts\common\rewards\reward_cache;
#using scripts\common\rewards\reward_cache_settings;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\objidpoolmanager;

#namespace reward_cache_mp;

// Namespace reward_cache_mp
// Params 0, eflags: 0x5
// Checksum 0x1870062f, Offset: 0x7e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"reward_cache_mp", undefined, &function_d2058cc7ae449354, undefined );
}

// Namespace reward_cache_mp
// Params 0, eflags: 0x4
// Checksum 0xd03f062a, Offset: 0x9f
// Size: 0x98
function private function_d2058cc7ae449354()
{
    utility::registersharedfunc( #"reward_cache", #"showrewardcachemarkertoplayer", &function_8cc3a97b12ce034f );
    utility::registersharedfunc( #"reward_cache", #"hiderewardcachemarkerfromplayer", &function_50c68d6d250378c1 );
    utility::registersharedfunc( #"reward_cache", #"updaterewardcachemarkerposition", &function_5c89f34d221e695c );
    utility::registersharedfunc( #"reward_cache", #"createrewardcacheobjectivemarker", &function_ee43f848d045a583 );
    utility::registersharedfunc( #"reward_cache", #"destroyrewardcacheobjectivemarker", &function_de8083401ed1800b );
}

// Namespace reward_cache_mp
// Params 2, eflags: 0x4
// Checksum 0x546c5504, Offset: 0x13f
// Size: 0x80
function private function_ee43f848d045a583( rewardcachesettings, origin )
{
    markerbundlename = reward_cache_settings::getobjectivemarkerbundlename( rewardcachesettings );
    
    if ( !isdefined( markerbundlename ) )
    {
        return -1;
    }
    
    objectiveid = objective_marker_bundle_helper::function_d98e9d627f2d8c28( markerbundlename );
    
    if ( objectiveid == -1 )
    {
        return;
    }
    
    zoffset = reward_cache_settings::function_951d16c76d05ac34( rewardcachesettings );
    
    if ( !isdefined( zoffset ) )
    {
    }
    else
    {
        objidpoolmanager::update_objective_setzoffset( objectiveid, zoffset );
    }
    
    objidpoolmanager::update_objective_position( objectiveid, origin );
    return objectiveid;
}

// Namespace reward_cache_mp
// Params 2, eflags: 0x4
// Checksum 0xbf4b1f66, Offset: 0x1c8
// Size: 0x29
function private function_8cc3a97b12ce034f( rewardcache, player )
{
    objidpoolmanager::objective_playermask_addshowplayer( rewardcache.objectivemarkerid, player );
}

// Namespace reward_cache_mp
// Params 2, eflags: 0x4
// Checksum 0x89b7e69a, Offset: 0x1f9
// Size: 0x29
function private function_50c68d6d250378c1( rewardcache, player )
{
    objidpoolmanager::objective_playermask_hidefrom( rewardcache.objectivemarkerid, player );
}

// Namespace reward_cache_mp
// Params 1, eflags: 0x4
// Checksum 0x9db7d9a3, Offset: 0x22a
// Size: 0x34
function private function_5c89f34d221e695c( rewardcache )
{
    objectiveid = rewardcache.objectivemarkerid;
    objidpoolmanager::update_objective_position( objectiveid, reward_cache::function_f4cf6bc9ebcdf5ea( rewardcache ) );
}

// Namespace reward_cache_mp
// Params 1, eflags: 0x4
// Checksum 0xa0c998c3, Offset: 0x266
// Size: 0x3a
function private function_de8083401ed1800b( rewardcache )
{
    objectivemarkerid = rewardcache.objectivemarkerid;
    objidpoolmanager::update_objective_state( objectivemarkerid, "done" );
    objidpoolmanager::returnobjectiveid( objectivemarkerid );
}

