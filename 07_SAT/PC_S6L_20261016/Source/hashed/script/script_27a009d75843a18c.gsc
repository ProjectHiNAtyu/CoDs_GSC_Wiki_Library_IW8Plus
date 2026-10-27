// script_27a009d75843a18c  (hash_27a009d75843a18c.gscc) (size: 1692 Bytes / 0x69c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x490f6817 (1225746455)
// size ...... 1692 (0x69c)
// includes .. 6   (offset: 0x610)
// strings ... 6   (offset: 0x640)
// dev strs .. 0   (offset: 0x69c)
// exports ... 10  (offset: 0x2b8)
// cseg ...... 0xa9 + 0x20f (0x2b8)
// imports ... 16  (offset: 0x448)
// animtree1 . 0   (offset: 0x69c)
// animtree2 . 0   (offset: 0x69c)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_church;

// Namespace ztron_arena_church
// Params 0, eflags: 0x5
// Checksum 0xe3e462eb, Offset: 0xc7
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"church", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_church
// Params 0
// Checksum 0x9cb14ec1, Offset: 0xe8
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_church
// Params 0
// Checksum 0xbaab71bd, Offset: 0xf9
// Size: 0x3b
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "church", &church_init, &church_shutdown );
    ztron_challenge::registerchallenge( "church", "church", &church_challenge, &function_19a8e7f237a2729, 1, &function_a43dd22fda18aca4 );
}

// Namespace ztron_arena_church
// Params 0
// Checksum 0x7161f4b6, Offset: 0x13c
// Size: 0x3a
function church_init()
{
    ztron_weather::function_c66678f1a8379c69( "church", "Snow", 3, "round_about_to_start" );
    ztron_weather::function_c66678f1a8379c69( "church", "Wetness", 10, "round_about_to_start" );
    level thread church_special_event();
}

// Namespace ztron_arena_church
// Params 0
// Checksum 0x734e3518, Offset: 0x17e
// Size: 0x2
function church_shutdown()
{
    
}

// Namespace ztron_arena_church
// Params 0
// Checksum 0x97b5b208, Offset: 0x188
// Size: 0x97
function church_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 2 )
        {
            if ( level.ztron.var_371903e5801e0e08 )
            {
                ztron_bonus_room::function_b018ee630661e155( "rail_shooter" );
                continue;
            }
            
            if ( !level.ztron.var_95d8c7a469393957 )
            {
                ztron_bonus_room::function_b018ee630661e155( ztron_bonus_room::function_cc95fac45228eccd() );
            }
        }
    }
}

// Namespace ztron_arena_church
// Params 0
// Checksum 0x4b8d31d5, Offset: 0x227
// Size: 0x21
function church_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "disciple" );
}

// Namespace ztron_arena_church
// Params 0
// Checksum 0x9c534065, Offset: 0x250
// Size: 0x15
function function_19a8e7f237a2729()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_church
// Params 0
// Checksum 0x38c6da17, Offset: 0x26d
// Size: 0x4a
function function_a43dd22fda18aca4()
{
    chance = 6;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 3;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

