// scripts\mp\common\killstreaks\cruise_predator_mp.gsc  (hash_0f55e70648dfbbe3.gscc) (size: 1569 Bytes / 0x621 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97f15ed4 (2549178068)
// size ...... 1569 (0x621)
// includes .. 4   (offset: 0x571)
// strings ... 8   (offset: 0x591)
// dev strs .. 0   (offset: 0x621)
// exports ... 5   (offset: 0x3a1)
// cseg ...... 0xeb + 0x2b6 (0x3a1)
// imports ... 9   (offset: 0x469)
// animtree1 . 0   (offset: 0x621)
// animtree2 . 0   (offset: 0x621)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\cruise_predator;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\events;

#namespace cruise_predator_mp;

// Namespace cruise_predator_mp
// Params 0
// Checksum 0xc9be6257, Offset: 0x109
// Size: 0x61
function init()
{
    killstreaks::registerkillstreak( "cruise_predator", &cruise_predator::tryusecruisepredatorfromstruct );
    utility::registersharedfunc( "cruise_predator", #"registervo", &cruisepredator_registervo );
    utility::registersharedfunc( "cruise_predator", #"eventrecord", &cruisepredator_eventrecord );
    utility::registersharedfunc( "cruise_predator", #"assigntargetmarkers", &cruisepredator_assigntargetmarkers );
}

// Namespace cruise_predator_mp
// Params 0
// Checksum 0x4bd7f909, Offset: 0x172
// Size: 0x5f
function cruisepredator_registervo()
{
    game[ "dialog" ][ "cruise_predator" + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "cruise_predator" + "_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "cruise_predator" + "_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
}

// Namespace cruise_predator_mp
// Params 1
// Checksum 0x68af6da2, Offset: 0x1d9
// Size: 0x1b
function cruisepredator_eventrecord( explodepos )
{
    if ( isdefined( explodepos ) )
    {
        events::predatormissileimpact( explodepos );
    }
}

// Namespace cruise_predator_mp
// Params 1
// Checksum 0x72f574a8, Offset: 0x1fc
// Size: 0x1a4
function cruisepredator_assigntargetmarkers( user )
{
    var_361a7ab2055af3a = [];
    var_d79ad8c4fb866425 = [];
    characterarray = level.players;
    groupsstruct = spawnstruct();
    
    foreach ( player in characterarray )
    {
        if ( level.teambased && player.team == user.team || player == user )
        {
            var_d79ad8c4fb866425[ var_d79ad8c4fb866425.size ] = player;
            continue;
        }
        
        if ( isdefined( player.perks[ "specialty_noscopeoutline" ] ) )
        {
            continue;
        }
        
        var_361a7ab2055af3a[ var_361a7ab2055af3a.size ] = player;
    }
    
    if ( isdefined( level.killstreak_additional_targets ) )
    {
        foreach ( target in level.killstreak_additional_targets )
        {
            var_361a7ab2055af3a[ var_361a7ab2055af3a.size ] = target;
        }
    }
    
    groupsstruct.enemytargetmarkergroup = var_361a7ab2055af3a;
    groupsstruct.friendlytargetmarkergroup = var_d79ad8c4fb866425;
    return groupsstruct;
}

