// scripts\mp\bots\bots_gametype_war.gsc  (hash_0e494dd5debda9c7.gscc) (size: 756 Bytes / 0x2f4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6a5122b5 (1783702197)
// size ...... 756 (0x2f4)
// includes .. 3   (offset: 0x2b8)
// strings ... 3   (offset: 0x2d0)
// dev strs .. 0   (offset: 0x2f4)
// exports ... 5   (offset: 0x12c)
// cseg ...... 0x97 + 0x95 (0x12c)
// imports ... 7   (offset: 0x1f4)
// animtree1 . 0   (offset: 0x2f4)
// animtree2 . 0   (offset: 0x2f4)
#using script_3d2770dc09c1243;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots;

#namespace bots_gametype_war;

// Namespace bots_gametype_war
// Params 0
// Checksum 0x7e4e4b2a, Offset: 0xb5
// Size: 0x3d
function main()
{
    if ( mit::function_d154accecda01f06() )
    {
        mit::initialize();
        return;
    }
    
    setup_callbacks();
    setup_bot_war();
    autopilot::initialize( undefined, undefined, [ "bot_default_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_war
// Params 0
// Checksum 0x3a55d433, Offset: 0xfa
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_war_think;
}

// Namespace bots_gametype_war
// Params 0
// Checksum 0x54aea94b, Offset: 0x119
// Size: 0x2
function setup_bot_war()
{
    
}

// Namespace bots_gametype_war
// Params 0
// Checksum 0x61777e02, Offset: 0x123
// Size: 0x9
function bot_war_think()
{
    bots::bot_default_think();
}

