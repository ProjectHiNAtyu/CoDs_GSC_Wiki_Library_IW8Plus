// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_starts.gsc  (hash_25f60d241ab08921.gscc) (size: 1943 Bytes / 0x797 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d96aae9 (2643897065)
// size ...... 1943 (0x797)
// includes .. 1   (offset: 0x687)
// strings ... 22  (offset: 0x68f)
// dev strs .. 0   (offset: 0x797)
// exports ... 6   (offset: 0x517)
// cseg ...... 0x27d + 0x29a (0x517)
// imports ... 2   (offset: 0x607)
// animtree1 . 0   (offset: 0x797)
// animtree2 . 0   (offset: 0x797)
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace ob_aries_startpoint;

// Namespace ob_aries_startpoint
// Params 0
// Checksum 0x602e48b0, Offset: 0x29b
// Size: 0xb2
function function_5de80b69cadf84b8()
{
    ob_gametype_story_mission::add_start( "OB_ARIES_RIVER_INTRO", { #loadout:{ #rarity:1, #index:0 }, #joinspawn:1, #power:"aries_launch", #difficulty:1 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_RIVER_JUNGLE", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_RIVER_WATERFALL", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_RIVER_MINEFIELD", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_RIVER_BARGE", { #joinspawn:1 } );
}

// Namespace ob_aries_startpoint
// Params 0
// Checksum 0x6e2b87e1, Offset: 0x355
// Size: 0xa6
function init_aries_nightmare_activities()
{
    ob_gametype_story_mission::add_start( "OB_ARIES_NIGHTMARE_INTRO", { #loadout:{ #rarity:1, #index:1 }, #progressspawn:0, #difficulty:2 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_NIGHTMARE_CORRIDOR", { #joinspawn:1, #power:"sag_intro" } );
    ob_gametype_story_mission::add_start( "OB_ARIES_NIGHTMARE_MAZE", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_NIGHTMARE_CONTAINERTOWER" );
    ob_gametype_story_mission::add_start( "OB_ARIES_NIGHTMARE_CRASHSITE", { #joinspawn:1 } );
}

// Namespace ob_aries_startpoint
// Params 0
// Checksum 0x23f07ab6, Offset: 0x403
// Size: 0x8d
function init_aries_boss_activities()
{
    ob_gametype_story_mission::add_start( "OB_ARIES_BOSS_INTRO", { #loadout:{ #rarity:1, #index:2 }, #progressspawn:0 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_BOSS_PHASEONE", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_BOSS_PHASETWO", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_BOSS_PHASETHREE", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_BOSS_OUTRO" );
}

// Namespace ob_aries_startpoint
// Params 0
// Checksum 0x811a1e30, Offset: 0x498
// Size: 0x21
function function_e436133437cda485()
{
    ob_gametype_story_mission::add_start( "ACTIVITY_STORY_RETURN", { #storycontract:#"aries_complete" } );
}

// Namespace ob_aries_startpoint
// Params 0
// Checksum 0x33e3dfc9, Offset: 0x4c1
// Size: 0x56
function function_3fd951b2f2b783a1()
{
    ob_gametype_story_mission::add_start( "OB_ARIES_NM_JUNGLE", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_NM_BARGE", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_NM_BOSS", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_ARIES_NM_REWARD" );
}

