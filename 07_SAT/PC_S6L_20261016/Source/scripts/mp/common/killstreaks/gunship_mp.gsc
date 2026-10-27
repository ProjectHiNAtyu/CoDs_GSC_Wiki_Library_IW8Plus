// scripts\mp\common\killstreaks\gunship_mp.gsc  (hash_0f7ccad482b72676.gscc) (size: 1700 Bytes / 0x6a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x18628257 (409109079)
// size ...... 1700 (0x6a4)
// includes .. 7   (offset: 0x648)
// strings ... 3   (offset: 0x680)
// dev strs .. 0   (offset: 0x6a4)
// exports ... 6   (offset: 0x314)
// cseg ...... 0x99 + 0x27b (0x314)
// imports ... 19  (offset: 0x404)
// animtree1 . 0   (offset: 0x6a4)
// animtree2 . 0   (offset: 0x6a4)
#using scripts\common\missilelauncher;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\gunship;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\spawnlogic;
#using scripts\mp\weapons;

#namespace gunship_mp;

// Namespace gunship_mp
// Params 0
// Checksum 0xf0647776, Offset: 0xb7
// Size: 0x199
function init()
{
    killstreaks::registerkillstreak( "gunship", &gunship::tryusegunshipfromstruct );
    utility::registersharedfunc( #"gunship", #"hash_9f5916152dc84f2a", &gunship_findboxcenter );
    utility::registersharedfunc( #"gunship", #"getbombingpoint", &gunship_getbombingpoint );
    utility::registersharedfunc( #"gunship", #"attachxrays", &gunship_attachxrays );
    utility::registersharedfunc( #"gunship", #"hash_aad609da4b585443", &weapons::lockonlaunchers_gettargetarray );
    utility::registersharedfunc( #"gunship", #"hash_27a099ef3d3f4d09", &missilelauncher::resetmissilelauncherlocking );
    utility::registersharedfunc( #"gunship", #"hash_b0da44ffae9de781", &missilelauncher::missilelauncher_finalizelock );
    utility::registersharedfunc( #"gunship", #"hash_6e7c6d31324a2e48", &missilelauncher::stingtargstruct_create );
    utility::registersharedfunc( #"gunship", #"hash_6faac5d24e5da258", &missilelauncher::stingtargstruct_getoffsets );
    utility::registersharedfunc( #"gunship", #"hash_51ca9a790ed5093b", &missilelauncher::stingtargstruct_getorigins );
    utility::registersharedfunc( #"gunship", #"hash_87abf7a064255a7d", &missilelauncher::stingtargstruct_getinreticle );
    utility::registersharedfunc( #"gunship", #"hash_b5b0702830fbc1d9", &missilelauncher::stingtargstruct_isinreticle );
    utility::registersharedfunc( #"gunship", #"hash_8e84281c4043bbcb", &missilelauncher::stingtargstruct_getinlos );
    utility::registersharedfunc( #"gunship", #"hash_3eadade5567ff796", &missilelauncher::softsighttest );
}

// Namespace gunship_mp
// Params 2
// Checksum 0xfcc03f38, Offset: 0x258
// Size: 0x1e
function gunship_findboxcenter( mins, maxs )
{
    return spawnlogic::findboxcenter( mins, maxs );
}

// Namespace gunship_mp
// Params 2
// Checksum 0xf58dd59, Offset: 0x27f
// Size: 0x35
function gunship_getbombingpoint( centerpoint, var_d0b84b2215b34610 )
{
    var_9e3443da58c12508 = toma_strike::tomastrike_getrandombombingpoint( centerpoint, var_d0b84b2215b34610 );
    return var_9e3443da58c12508.point;
}

// Namespace gunship_mp
// Params 1
// Checksum 0xd7b80325, Offset: 0x2bd
// Size: 0x22
function gunship_attachxrays( gunship )
{
    gunship setentityhudoutlinedata( 3, gunship.team );
    return gunship;
}

// Namespace gunship_mp
// Params 2
// Checksum 0x75042932, Offset: 0x2e8
// Size: 0x2c
function function_1e8307a2c306ba5f( channel, weaponindex )
{
    if ( channel != "gunship_weapon_selection" )
    {
        return;
    }
    
    self notify( "gunship_switch_weapon_" + weaponindex );
}

