// script_469b06df5ded098  (hash_0469b06df5ded098.gscc) (size: 2003 Bytes / 0x7d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1342d2b0 (323146416)
// size ...... 2003 (0x7d3)
// includes .. 6   (offset: 0x763)
// strings ... 4   (offset: 0x793)
// dev strs .. 0   (offset: 0x7d3)
// exports ... 10  (offset: 0x3cf)
// cseg ...... 0x9e + 0x331 (0x3cf)
// imports ... 18  (offset: 0x55f)
// animtree1 . 0   (offset: 0x7d3)
// animtree2 . 0   (offset: 0x7d3)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_aethereal_jungle;

// Namespace ztron_arena_aethereal_jungle
// Params 0, eflags: 0x5
// Checksum 0x1f92e6fb, Offset: 0xbc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"aethereal_jungle", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_aethereal_jungle
// Params 0
// Checksum 0x68569295, Offset: 0xdd
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_aethereal_jungle
// Params 0
// Checksum 0xca09bb29, Offset: 0xee
// Size: 0xdb
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "aethereal_jungle", &aethereal_jungle_init, &aethereal_jungle_shutdown );
    namespace_e1711960173e16b5::registerchallenge( "aethereal_jungle", "aethereal_jungle", &aethereal_jungle_challenge, &function_5c06c4f8feb991f9, 1, &function_d163932d5ec4dd34 );
    arena = ztron_arena::function_973956bb5a6e60f7( "aethereal_jungle" );
    
    if ( isdefined( arena ) )
    {
        if ( level.ztron.var_371903e5801e0e08 )
        {
            arena.var_50cd3f3dd72a4817 = getdvarint( @"hash_61375ab5ed6e10d2", 4 );
            return;
        }
        
        if ( level.ztron.var_95d8c7a469393957 )
        {
            arena.var_50cd3f3dd72a4817 = getdvarint( @"hash_e8eb845415d72959", 7 );
            return;
        }
        
        arena.var_50cd3f3dd72a4817 = getdvarint( @"hash_940fcca278538a32", 5 );
    }
}

// Namespace ztron_arena_aethereal_jungle
// Params 0
// Checksum 0x14d705ef, Offset: 0x1d1
// Size: 0x22
function aethereal_jungle_init()
{
    ztron_weather::function_c66678f1a8379c69( "aethereal_jungle", "Wetness", 15, "round_about_to_start" );
    level thread aethereal_jungle_special_event();
}

// Namespace ztron_arena_aethereal_jungle
// Params 0
// Checksum 0x473f5536, Offset: 0x1fb
// Size: 0x2
function aethereal_jungle_shutdown()
{
    
}

// Namespace ztron_arena_aethereal_jungle
// Params 0
// Checksum 0x3f56285a, Offset: 0x205
// Size: 0x73
function aethereal_jungle_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 2 && !level.ztron.var_95d8c7a469393957 )
        {
            ztron_bonus_room::function_b018ee630661e155( ztron_bonus_room::function_cc95fac45228eccd() );
        }
    }
}

// Namespace ztron_arena_aethereal_jungle
// Params 0
// Checksum 0x213e4bbf, Offset: 0x280
// Size: 0x73
function aethereal_jungle_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "abomination" );
    level.ztron.var_37084fa69046d3b4 = 6;
    level.ztron.challenge_delay = gettime() + 15000;
    level.ztron.var_cd3b78b45db638d8.var_e95772ef2aa376a0 = 1;
}

// Namespace ztron_arena_aethereal_jungle
// Params 0
// Checksum 0x953626d8, Offset: 0x2fb
// Size: 0x45
function function_5c06c4f8feb991f9()
{
    level.ztron.var_cd3b78b45db638d8.var_e95772ef2aa376a0 = undefined;
    level.ztron.var_cd3b78b45db638d8 = undefined;
    level.ztron.var_37084fa69046d3b4 = undefined;
}

// Namespace ztron_arena_aethereal_jungle
// Params 0
// Checksum 0xe91c4594, Offset: 0x348
// Size: 0x86
function function_d163932d5ec4dd34()
{
    time = gettime();
    
    if ( level.ztron.var_37084fa69046d3b4 > 0 && time > level.ztron.challenge_delay )
    {
        level.ztron.challenge_delay = time + 20000;
        level.ztron.var_37084fa69046d3b4--;
        return level.ztron.var_cd3b78b45db638d8;
    }
}

