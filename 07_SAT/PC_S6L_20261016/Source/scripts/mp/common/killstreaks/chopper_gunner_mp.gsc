// scripts\mp\common\killstreaks\chopper_gunner_mp.gsc  (hash_55338aa7b86f5abd.gscc) (size: 1979 Bytes / 0x7bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8336533b (2201375547)
// size ...... 1979 (0x7bb)
// includes .. 7   (offset: 0x767)
// strings ... 2   (offset: 0x79f)
// dev strs .. 0   (offset: 0x7bb)
// exports ... 9   (offset: 0x39f)
// cseg ...... 0x86 + 0x319 (0x39f)
// imports ... 21  (offset: 0x507)
// animtree1 . 0   (offset: 0x7bb)
// animtree2 . 0   (offset: 0x7bb)
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\targetmarkergroups;
#using scripts\common\utility;
#using scripts\common\vehicle_damage;
#using scripts\mp\common\killstreaks\chopper_gunner;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace chopper_gunner_mp;

// Namespace chopper_gunner_mp
// Params 0, eflags: 0x1
// Checksum 0x26d422fa, Offset: 0xa4
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "chopper_gunner" ), &init );
}

// Namespace chopper_gunner_mp
// Params 0
// Checksum 0xd9486b67, Offset: 0xc3
// Size: 0xce
function init()
{
    killstreaks::registerkillstreak( "chopper_gunner", &chopper_gunner::tryusechoppergunnerfromstruct );
    utility::registersharedfunc( #"chopper_gunner", #"set_vehicle_hit_damage_data", &chopper_gunner_set_vehicle_hit_damage_data );
    utility::registersharedfunc( #"chopper_gunner", #"findtargetstruct", &chopper_gunner_findtargetstruct );
    utility::registersharedfunc( #"chopper_gunner", #"assigntargetmarkers", &chopper_gunner_assigntargetmarkers );
    utility::registersharedfunc( #"chopper_gunner", #"attachxrays", &chopper_gunner_attachxrays );
    utility::registersharedfunc( #"chopper_gunner", #"handlethermalswitch", &chopper_gunner_handlethermalswitch );
    utility::registersharedfunc( #"chopper_gunner", #"hash_f3394fa941d2f2c8", &function_244581340ccd51af );
    chopper_gunner::init();
}

// Namespace chopper_gunner_mp
// Params 2
// Checksum 0x64198b77, Offset: 0x199
// Size: 0x1f
function chopper_gunner_set_vehicle_hit_damage_data( ref, hitstokill )
{
    vehicle_damage::set_vehicle_hit_damage_data( ref, hitstokill );
}

// Namespace chopper_gunner_mp
// Params 2
// Checksum 0xd52cae25, Offset: 0x1c0
// Size: 0x1e
function chopper_gunner_findtargetstruct( structlinkname, var_a421ae2a63911fea )
{
    return chopper_support::choppersupport_findtargetstruct( structlinkname, var_a421ae2a63911fea );
}

// Namespace chopper_gunner_mp
// Params 0
// Checksum 0xc69acfb5, Offset: 0x1e7
// Size: 0x153
function chopper_gunner_assigntargetmarkers()
{
    var_361a7ab2055af3a = [];
    var_55dee18287c32af9 = [];
    character_array = level.players;
    
    foreach ( player in character_array )
    {
        if ( level.teambased && player.team == self.team || player == self.owner )
        {
            var_55dee18287c32af9[ var_55dee18287c32af9.size ] = player;
            continue;
        }
        
        if ( isdefined( player.perks[ "specialty_noscopeoutline" ] ) )
        {
            continue;
        }
        
        var_361a7ab2055af3a[ var_361a7ab2055af3a.size ] = player;
    }
    
    self.enemytargetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerenemy", self.owner, var_361a7ab2055af3a, self.owner, 0, 1, 1 );
    self.friendlytargetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerfriendly", self.owner, var_55dee18287c32af9, self.owner, 1, 1 );
}

// Namespace chopper_gunner_mp
// Params 1
// Checksum 0x6ea82c25, Offset: 0x342
// Size: 0x22
function chopper_gunner_attachxrays( choppergunner )
{
    choppergunner setentityhudoutlinedata( 3, choppergunner.team );
    return choppergunner;
}

// Namespace chopper_gunner_mp
// Params 1
// Checksum 0xfede92b5, Offset: 0x36d
// Size: 0x15
function chopper_gunner_handlethermalswitch( thirdperson )
{
    chopper_gunner::choppergunner_handlethermalswitch( thirdperson );
}

// Namespace chopper_gunner_mp
// Params 1
// Checksum 0x998ee97e, Offset: 0x38a
// Size: 0x15
function function_244581340ccd51af( thirdperson )
{
    chopper_gunner::function_72ebf2213d77c3d6( thirdperson );
}

