// scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_starts.gsc  (hash_441ed1e831256735.gscc) (size: 1708 Bytes / 0x6ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9544057 (156516439)
// size ...... 1708 (0x6ac)
// includes .. 1   (offset: 0x5b4)
// strings ... 20  (offset: 0x5bc)
// dev strs .. 0   (offset: 0x6ac)
// exports ... 5   (offset: 0x470)
// cseg ...... 0x257 + 0x219 (0x470)
// imports ... 2   (offset: 0x538)
// animtree1 . 0   (offset: 0x6ac)
// animtree2 . 0   (offset: 0x6ac)
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace ob_leo_startpoint;

// Namespace ob_leo_startpoint
// Params 0
// Checksum 0x792f7a6b, Offset: 0x275
// Size: 0x122
function function_7c9d046e3ec59f53()
{
    ob_gametype_story_mission::add_start( "OB_LEO_FACILITY_INTRO_IGC", { #loadout:{ #var_f91170067a6d805c:1, #rarity:0, #index:0 }, #joinspawn:1, #power:"leo_launch", #difficulty:1 } );
    ob_gametype_story_mission::add_start( "OB_LEO_FACILITY_INTRO", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_LEO_FACILITY_PRESENTATION" );
    ob_gametype_story_mission::add_start( "OB_LEO_FACILITY_LABS", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_LEO_FACILITY_MACGUFFIN" );
    ob_gametype_story_mission::add_start( "OB_LEO_FACILITY_MACGUFFIN_CORE", { #loadout:{ #var_f91170067a6d805c:1, #rarity:1, #index:0 }, #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_LEO_FACILITY_ESCAPE_1", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_LEO_FACILITY_CRADLE" );
    ob_gametype_story_mission::add_start( "OB_LEO_FACILITY_ESCAPE_2" );
    ob_gametype_story_mission::add_start( "OB_LEO_FACILITY_TO_JUNGLE" );
}

// Namespace ob_leo_startpoint
// Params 0
// Checksum 0x1a0e71c1, Offset: 0x39f
// Size: 0x4a
function function_8efae75b2bbd10f()
{
    ob_gametype_story_mission::add_start( "OB_LEO_JUNGLE_INTRO", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_LEO_JUNGLE_VILLAGE", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_LEO_JUNGLE_MANSION" );
    ob_gametype_story_mission::add_start( "OB_LEO_JUNGLE_MANSION_DEFEND" );
}

// Namespace ob_leo_startpoint
// Params 0
// Checksum 0x37165cf9, Offset: 0x3f1
// Size: 0x56
function function_d64c96fadd5aae1b()
{
    ob_gametype_story_mission::add_start( "OB_LEO_NM_ATRIUM", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_LEO_NM_MACGUFFIN", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_LEO_NM_JUNGLE", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_LEO_NM_REWARD" );
}

// Namespace ob_leo_startpoint
// Params 0
// Checksum 0x2ee3ed6a, Offset: 0x44f
// Size: 0x21
function init_leo_activity_return()
{
    ob_gametype_story_mission::add_start( "ACTIVITY_STORY_RETURN", { #storycontract:#"leo_complete" } );
}

