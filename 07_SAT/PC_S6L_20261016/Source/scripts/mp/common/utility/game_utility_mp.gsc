// scripts\mp\common\utility\game_utility_mp.gsc  (hash_7ca947eb17954434.gscc) (size: 887 Bytes / 0x377 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a27471b (2586265371)
// size ...... 887 (0x377)
// includes .. 3   (offset: 0x35f)
// strings ... 0   (offset: 0x377)
// dev strs .. 0   (offset: 0x377)
// exports ... 5   (offset: 0x207)
// cseg ...... 0x9c + 0x16b (0x207)
// imports ... 5   (offset: 0x2cf)
// animtree1 . 0   (offset: 0x377)
// animtree2 . 0   (offset: 0x377)
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\matchdata;

#namespace game_utility_mp;

// Namespace game_utility_mp
// Params 0
// Checksum 0xb663eed, Offset: 0xba
// Size: 0x20
function game_utility_mp_init()
{
    utility::registersharedfunc( #"game_utility", #"gettimesincegamestart", &game_utility_mp_gettimesincegamestart );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xc4ceee3f, Offset: 0xe2
// Size: 0xc
function game_utility_mp_gettimesincegamestart()
{
    return matchdata::gettimefrommatchstart( gettime() );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x9244bc58, Offset: 0xf7
// Size: 0x76, Type: bool
function function_486a77b9c5d2bd09()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_1e4846dca3ccf38":
        case #"hash_ca6516c10db2c95":
        case #"hash_18e1b9ff1e247c84":
        case #"hash_7f9c384a34cc392f":
        case #"hash_9a6f07d0214a87db":
        case #"hash_c065cef60f38490a":
        case #"hash_c7f4420f385eeb3d":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x68c87114, Offset: 0x176
// Size: 0x90, Type: bool
function modeusesgroundwarteamoobtriggers( trigger )
{
    if ( isdefined( trigger.script_team ) )
    {
        switch ( game_utility::getgametype() )
        {
            case #"hash_1e4846dca3ccf38":
            case #"hash_ca6516c10db2c95":
            case #"hash_18e1b9ff1e247c84":
            case #"hash_7f9c384a34cc392f":
            case #"hash_9a6f07d0214a87db":
            case #"hash_c065cef60f38490a":
            case #"hash_c7f4420f385eeb3d":
                return true;
            default:
                return false;
        }
    }
    
    return true;
}

