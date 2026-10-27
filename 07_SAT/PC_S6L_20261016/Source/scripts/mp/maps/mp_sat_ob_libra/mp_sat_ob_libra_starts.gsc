// scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_starts.gsc  (hash_5bf2f1ccfbf708c9.gscc) (size: 1857 Bytes / 0x741 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x836558c3 (2204457155)
// size ...... 1857 (0x741)
// includes .. 2   (offset: 0x5ed)
// strings ... 27  (offset: 0x5fd)
// dev strs .. 0   (offset: 0x741)
// exports ... 2   (offset: 0x4ed)
// cseg ...... 0x2ba + 0x233 (0x4ed)
// imports ... 3   (offset: 0x53d)
// animtree1 . 0   (offset: 0x741)
// animtree2 . 0   (offset: 0x741)
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace ob_libra_startpoint;

// Namespace ob_libra_startpoint
// Params 0
// Checksum 0xdcf89f43, Offset: 0x2d8
// Size: 0x215
function function_97e5a48748c953()
{
    if ( !ob::nightmare() )
    {
        ob_gametype_story_mission::add_start( "OB_LIBRA_APPROACH", { #loadout:{ #rarity:3, #index:0 }, #joinspawn:1, #power:"taurus_intro", #difficulty:3 } );
        ob_gametype_story_mission::add_start( "OB_LIBRA_INFIL", { #joinspawn:1 } );
        ob_gametype_story_mission::add_start( "OB_LIBRA_INFIL_ANALYSIS", { #joinspawn:1 } );
        ob_gametype_story_mission::add_start( "OB_LIBRA_INFIL_STORAGE" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_INFIL_PACKING", { #power:"libra_complete" } );
        ob_gametype_story_mission::add_start( "OB_LIBRA_IGC_ANSWERS" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_AMBUSH" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_AMBUSH_EXIT" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_ARMORY_PREPARE" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_IGC_PROCESSING", { #loadout:{ #rarity:4, #index:0 } } );
        ob_gametype_story_mission::add_start( "OB_LIBRA_PROCESSING_DOORS" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_PROCESSING_LIFT" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_PROCESSING_PUMP" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_BACKTRACK" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_IGC_BOSS_INTRO", { #joinspawn:1 } );
        ob_gametype_story_mission::add_start( "OB_LIBRA_BOSS_1" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_BOSS_2" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_BOSS_3" );
        ob_gametype_story_mission::add_start( "OB_LIBRA_IGC_BOSS_OUTRO", { #joinspawn:1 } );
        ob_gametype_story_mission::add_start( "OB_LIBRA_ESCAPE_1" );
    }
    else
    {
        ob_gametype_story_mission::add_start( "OB_LIBRA_NM_1", { #joinspawn:1 } );
        ob_gametype_story_mission::add_start( "OB_LIBRA_NM_2", { #joinspawn:1 } );
        ob_gametype_story_mission::add_start( "OB_LIBRA_NM_3", { #joinspawn:1 } );
        ob_gametype_story_mission::add_start( "OB_LIBRA_NM_REWARD" );
    }
    
    ob_gametype_story_mission::add_start( "ACTIVITY_STORY_RETURN", { #storycontract:#"libra_complete" } );
}

