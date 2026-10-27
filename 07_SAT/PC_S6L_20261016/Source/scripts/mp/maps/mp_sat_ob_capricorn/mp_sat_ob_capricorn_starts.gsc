// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_starts.gsc  (hash_6e89a33620f0ed2d.gscc) (size: 1760 Bytes / 0x6e0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x18bc5dc1 (414997953)
// size ...... 1760 (0x6e0)
// includes .. 1   (offset: 0x5d0)
// strings ... 22  (offset: 0x5d8)
// dev strs .. 0   (offset: 0x6e0)
// exports ... 2   (offset: 0x500)
// cseg ...... 0x2f0 + 0x210 (0x500)
// imports ... 2   (offset: 0x550)
// animtree1 . 0   (offset: 0x6e0)
// animtree2 . 0   (offset: 0x6e0)
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace ob_capricorn_startpoint;

// Namespace ob_capricorn_startpoint
// Params 0
// Checksum 0xe4e3363c, Offset: 0x30e
// Size: 0x1f2
function init_capricorn_activities()
{
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_INTRO", { #loadout:{ #var_f91170067a6d805c:1, #rarity:1, #index:0 }, #joinspawn:1, #power:"capricorn_launch", #difficulty:2 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_HIJACK", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_HIJACK_VIP" );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_HIJACK_BOSS" );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_HIJACK_THROTTLE" );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_FORGE", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_FORGE_01", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_FORGE_02" );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_FORGE_RETURN_TO_ELEVATOR", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_FORGE_RESTRICTED_AREA", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_FORGE_RESTRICTED_AREA_COMPUTER_START", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_FORGE_RESTRICTED_AREA_COMPUTER", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_FORGE_RESTRICTED_AREA_GARAGE_COMPLETED", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_ROJI", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_ROJI_GAME_CENTER", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_ROJI_ROOFTOP", { #joinspawn:1, #power:"aqua_intro" } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_ROJI_ROOFTOP_ELEVATOR", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_ROOF" );
    ob_gametype_story_mission::add_start( "OB_CAPRICORN_ROOF_EMP" );
    ob_gametype_story_mission::add_start( "ACTIVITY_STORY_RETURN", { #storycontract:#"capricorn_complete" } );
}

