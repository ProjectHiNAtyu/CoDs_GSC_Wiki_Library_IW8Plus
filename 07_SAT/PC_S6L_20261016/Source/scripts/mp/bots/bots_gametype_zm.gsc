// scripts\mp\bots\bots_gametype_zm.gsc  (hash_41378995c229c92c.gscc) (size: 834 Bytes / 0x342 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x257b23a3 (628827043)
// size ...... 834 (0x342)
// includes .. 2   (offset: 0x302)
// strings ... 4   (offset: 0x312)
// dev strs .. 0   (offset: 0x342)
// exports ... 5   (offset: 0x192)
// cseg ...... 0xa1 + 0xf1 (0x192)
// imports ... 6   (offset: 0x25a)
// animtree1 . 0   (offset: 0x342)
// animtree2 . 0   (offset: 0x342)
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_util;

#namespace bots_gametype_zm;

// Namespace bots_gametype_zm
// Params 0
// Checksum 0x2b28f646, Offset: 0xbf
// Size: 0x2c
function main()
{
    setup_callbacks();
    setup_bot_zm();
    autopilot::initialize( undefined, undefined, [ "bot_zm_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_zm
// Params 0
// Checksum 0x7447981a, Offset: 0xf3
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_zm_think;
}

// Namespace bots_gametype_zm
// Params 0
// Checksum 0x85820244, Offset: 0x112
// Size: 0x2
function setup_bot_zm()
{
    
}

// Namespace bots_gametype_zm
// Params 0
// Checksum 0xc44cde62, Offset: 0x11c
// Size: 0x76
function bot_zm_think()
{
    self notify( #"bot_zm_think" );
    self endon( #"bot_zm_think" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    bots_util_mp::bot_set_personality( "run_and_gun" );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        self [[ self.personality_update_function ]]();
        wait 0.05;
    }
}

