// scripts\mp\bots\bots_gametype_skirmish.gsc  (hash_5dfd2a4f1d9ccd35.gscc) (size: 751 Bytes / 0x2ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd893bfe1 (3633561569)
// size ...... 751 (0x2ef)
// includes .. 3   (offset: 0x2a7)
// strings ... 4   (offset: 0x2bf)
// dev strs .. 0   (offset: 0x2ef)
// exports ... 5   (offset: 0x137)
// cseg ...... 0xa7 + 0x90 (0x137)
// imports ... 6   (offset: 0x1ff)
// animtree1 . 0   (offset: 0x2ef)
// animtree2 . 0   (offset: 0x2ef)
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_util;

#namespace bots_gametype_skirmish;

// Namespace bots_gametype_skirmish
// Params 0
// Checksum 0x3db0e0f8, Offset: 0xc5
// Size: 0x2c
function main()
{
    setup_callbacks();
    setup_bot_skirmish();
    autopilot::initialize( undefined, undefined, [ "bot_skirmish_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_skirmish
// Params 0
// Checksum 0xca56b6a6, Offset: 0xf9
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_skirmish_think;
}

// Namespace bots_gametype_skirmish
// Params 0
// Checksum 0xa9c9fbb6, Offset: 0x118
// Size: 0x2
function setup_bot_skirmish()
{
    
}

// Namespace bots_gametype_skirmish
// Params 0
// Checksum 0x1e8e4c2e, Offset: 0x122
// Size: 0x15
function bot_skirmish_think()
{
    bots_util_mp::bot_set_personality( "run_and_gun" );
    bots::bot_default_think();
}

