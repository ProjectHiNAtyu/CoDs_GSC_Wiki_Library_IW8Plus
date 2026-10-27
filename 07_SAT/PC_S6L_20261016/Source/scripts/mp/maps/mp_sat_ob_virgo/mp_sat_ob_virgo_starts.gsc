// scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_starts.gsc  (hash_7dfad52114571a85.gscc) (size: 1560 Bytes / 0x618 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4ea23a9f (1319254687)
// size ...... 1560 (0x618)
// includes .. 1   (offset: 0x530)
// strings ... 18  (offset: 0x538)
// dev strs .. 0   (offset: 0x618)
// exports ... 6   (offset: 0x3d0)
// cseg ...... 0x1ff + 0x1d1 (0x3d0)
// imports ... 2   (offset: 0x4c0)
// animtree1 . 0   (offset: 0x618)
// animtree2 . 0   (offset: 0x618)
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace ob_virgo_startpoint;

// Namespace ob_virgo_startpoint
// Params 0
// Checksum 0x85ac668e, Offset: 0x21d
// Size: 0x8e
function function_dde497892d9a4eca()
{
    ob_gametype_story_mission::add_start( "OB_VIRGO_FREEWAY_INTRO", { #loadout:{ #rarity:2, #index:0 }, #joinspawn:1, #power:"virgo_launch", #difficulty:2 } );
    ob_gametype_story_mission::add_start( "OB_VIRGO_FREEWAY_INVERTED" );
    ob_gametype_story_mission::add_start( "OB_VIRGO_FREEWAY_BROKEN" );
    ob_gametype_story_mission::add_start( "OB_VIRGO_FREEWAY_PARKOUR" );
    ob_gametype_story_mission::add_start( "OB_VIRGO_FREEWAY_CRASHSITE" );
    ob_gametype_story_mission::add_start( "OB_VIRGO_FREEWAY_DRONE" );
}

// Namespace ob_virgo_startpoint
// Params 0
// Checksum 0xffb75686, Offset: 0x2b3
// Size: 0x4e
function function_2410a69c1fa2d233()
{
    ob_gametype_story_mission::add_start( "OB_VIRGO_JAPAN_INTRO", { #power:"virgo_launch", #difficulty:2 } );
    ob_gametype_story_mission::add_start( "OB_VIRGO_JAPAN_FIGHT", { #power:"cancer_intro", #difficulty:3 } );
}

// Namespace ob_virgo_startpoint
// Params 0
// Checksum 0x9eb9920f, Offset: 0x309
// Size: 0x40
function init_virgo_carrier_activities()
{
    ob_gametype_story_mission::add_start( "OB_VIRGO_CARRIER_INTRO", { #power:"cancer_intro", #difficulty:3 } );
    ob_gametype_story_mission::add_start( "OB_VIRGO_CARRIER_2" );
    ob_gametype_story_mission::add_start( "OB_VIRGO_CARRIER_3" );
}

// Namespace ob_virgo_startpoint
// Params 0
// Checksum 0x71785eec, Offset: 0x351
// Size: 0x56
function function_b22efc63f5e59851()
{
    ob_gametype_story_mission::add_start( "OB_VIRGO_NM_JPN", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_VIRGO_NM_LA", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_VIRGO_NM_CARRIER", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_VIRGO_NM_REWARD" );
}

// Namespace ob_virgo_startpoint
// Params 0
// Checksum 0xdaad901, Offset: 0x3af
// Size: 0x21
function init_virgo_return()
{
    ob_gametype_story_mission::add_start( "ACTIVITY_STORY_RETURN", { #storycontract:#"virgo_complete" } );
}

