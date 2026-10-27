// script_19c82990747977bd  (hash_19c82990747977bd.gscc) (size: 2069 Bytes / 0x815 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7aa259a6 (2057460134)
// size ...... 2069 (0x815)
// includes .. 6   (offset: 0x76d)
// strings ... 7   (offset: 0x79d)
// dev strs .. 0   (offset: 0x815)
// exports ... 11  (offset: 0x375)
// cseg ...... 0xc1 + 0x2b4 (0x375)
// imports ... 20  (offset: 0x52d)
// animtree1 . 0   (offset: 0x815)
// animtree2 . 0   (offset: 0x815)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_town_square;

// Namespace ztron_arena_town_square
// Params 0, eflags: 0x5
// Checksum 0xc4d22c39, Offset: 0xdf
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"town_square", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_town_square
// Params 0
// Checksum 0x52cfd6cc, Offset: 0x100
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_town_square
// Params 0
// Checksum 0x82028d0b, Offset: 0x111
// Size: 0x4b
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "town_square", &town_square_init, &town_square_shutdown );
    ztron_challenge::registerchallenge( "town_square", "town_square", &town_square_challenge, &function_2b2421d77d3c9c0a, 1, &function_cf7c150eb8e8ee2b );
    ztron_arena::function_37c3ad87b4c84a3f( "town_square", 36, 7 );
}

// Namespace ztron_arena_town_square
// Params 0
// Checksum 0x66bc6250, Offset: 0x164
// Size: 0x49
function function_a3d03b6e7de433ea()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    if ( level.players.size > 1 )
    {
        return;
    }
    
    wait 180;
    level.ztron.minkillcount = 0;
}

// Namespace ztron_arena_town_square
// Params 0
// Checksum 0xdeee5bd1, Offset: 0x1b5
// Size: 0x39
function town_square_challenge()
{
    level thread function_a3d03b6e7de433ea();
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "heavy_armored_zombie" );
    ztron_arena::function_37c3ad87b4c84a3f( "town_square", 26, 7 );
}

// Namespace ztron_arena_town_square
// Params 0
// Checksum 0x88f3e56a, Offset: 0x1f6
// Size: 0x25
function function_2b2421d77d3c9c0a()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
    ztron_arena::function_37c3ad87b4c84a3f( "town_square", 36, 7 );
}

// Namespace ztron_arena_town_square
// Params 0
// Checksum 0x9656ec89, Offset: 0x223
// Size: 0x97
function function_39af7fe41fb09e52()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 2 )
        {
            if ( level.ztron.var_371903e5801e0e08 )
            {
                ztron_bonus_room::function_b018ee630661e155( "eggxit" );
                continue;
            }
            
            if ( !level.ztron.var_95d8c7a469393957 )
            {
                ztron_bonus_room::function_b018ee630661e155( ztron_bonus_room::function_cc95fac45228eccd() );
            }
        }
    }
}

// Namespace ztron_arena_town_square
// Params 0
// Checksum 0xc8ecad71, Offset: 0x2c2
// Size: 0x4a
function function_cf7c150eb8e8ee2b()
{
    chance = 80;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 40;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

// Namespace ztron_arena_town_square
// Params 0
// Checksum 0x5ba7aa4b, Offset: 0x315
// Size: 0x4a
function town_square_init()
{
    ztron_weather::function_c66678f1a8379c69( "town_square", "Snow", 5, "round_about_to_start", 12 );
    ztron_weather::function_c66678f1a8379c69( "town_square", "Wetness", 5, "round_about_to_start", 12 );
    ztron_enemy::function_c432c192a10985ad( "mannequin" );
    level thread function_39af7fe41fb09e52();
}

// Namespace ztron_arena_town_square
// Params 0
// Checksum 0x2afd7871, Offset: 0x367
// Size: 0xe
function town_square_shutdown()
{
    ztron_enemy::function_103f4348c83c32ce( "mannequin" );
}

