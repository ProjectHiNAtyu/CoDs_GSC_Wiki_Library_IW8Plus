// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_starts.gsc  (hash_73b3762a3f857e9f.gscc) (size: 2304 Bytes / 0x900 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x44c25fc8 (1153589192)
// size ...... 2304 (0x900)
// includes .. 1   (offset: 0x7c8)
// strings ... 25  (offset: 0x7d0)
// dev strs .. 0   (offset: 0x900)
// exports ... 6   (offset: 0x64c)
// cseg ...... 0x2e4 + 0x368 (0x64c)
// imports ... 2   (offset: 0x73c)
// animtree1 . 0   (offset: 0x900)
// animtree2 . 0   (offset: 0x900)
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace ob_gemini_startpoint;

// Namespace ob_gemini_startpoint
// Params 0
// Checksum 0x18c32c9e, Offset: 0x302
// Size: 0x14d
function function_3e73da858166a840()
{
    ob_gametype_story_mission::add_start( "OB_GEMINI_TUNNELS_INTRO", { #loadout:{ #rarity:2, #index:0 }, #forceloadout:1, #var_8504ec12ea75e5d0:1, #joinspawn:1, #power:"gemini_launch", #difficulty:3 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_TUNNELS_SOLITARY", { #forceloadout:1, #var_8504ec12ea75e5d0:1, #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_TUNNELS_PRISON", { #var_8504ec12ea75e5d0:1, #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_TUNNELS_ANTEROOM", { #loadout:{ #rarity:2, #index:4 }, #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_TUNNELS_ELEVATOR" );
    ob_gametype_story_mission::add_start( "OB_GEMINI_TUNNELS_MINE", { #loadout:{ #rarity:2, #index:1 }, #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_TUNNELS_PIT", { #joinspawn:1 } );
}

// Namespace ob_gemini_startpoint
// Params 0
// Checksum 0xba314326, Offset: 0x457
// Size: 0xb2
function function_c4b14cf6527efb77()
{
    ob_gametype_story_mission::add_start( "OB_GEMINI_CABIN_INTRO", { #loadout:{ #rarity:3, #index:2 }, #progressspawn:0, #power:"gemini_launch", #difficulty:3 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_CABIN_WILDERNESS", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_CABIN_INITIALMEMORY", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_CABIN_MEMORYCAPTURE", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_CABIN_BARRAGE", { #joinspawn:1 } );
}

// Namespace ob_gemini_startpoint
// Params 0
// Checksum 0x84c0f767, Offset: 0x511
// Size: 0xb4
function function_e49a3335192f8ba2()
{
    ob_gametype_story_mission::add_start( "OB_GEMINI_PRISON_INTRO", { #difficulty:3 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_PRISON_UNDERGROUND", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_PRISON_MINECARTS", { #loadout:{ #rarity:3, #index:3 }, #joinspawn:1, #power:"taurus_intro" } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_PRISON_ARMORY", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_PRISON_TOPSIDE", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_PRISON_FINALPUSH" );
}

// Namespace ob_gemini_startpoint
// Params 0
// Checksum 0xfa93d68, Offset: 0x5cd
// Size: 0x21
function function_9f3cf62b9569d0d8()
{
    ob_gametype_story_mission::add_start( "ACTIVITY_STORY_RETURN", { #storycontract:#"gemini_complete" } );
}

// Namespace ob_gemini_startpoint
// Params 0
// Checksum 0xaea40492, Offset: 0x5f6
// Size: 0x56
function init_gemini_nm()
{
    ob_gametype_story_mission::add_start( "OB_GEMINI_NM_1", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_NM_2", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_NM_3", { #joinspawn:1 } );
    ob_gametype_story_mission::add_start( "OB_GEMINI_NM_REWARD" );
}

