// script_470a1cbf28112ece  (hash_470a1cbf28112ece.gscc) (size: 2027 Bytes / 0x7eb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf2018f35 (4060188469)
// size ...... 2027 (0x7eb)
// includes .. 7   (offset: 0x72f)
// strings ... 8   (offset: 0x767)
// dev strs .. 1   (offset: 0x7df)
// exports ... 11  (offset: 0x32b)
// cseg ...... 0xdc + 0x24f (0x32b)
// imports ... 21  (offset: 0x4e3)
// animtree1 . 0   (offset: 0x7eb)
// animtree2 . 0   (offset: 0x7eb)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_fort_courtyard;

// Namespace ztron_arena_fort_courtyard
// Params 0, eflags: 0x5
// Checksum 0xa5f027f9, Offset: 0xfa
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"fort_courtyard", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_fort_courtyard
// Params 0
// Checksum 0x5362de15, Offset: 0x11b
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_fort_courtyard
// Params 0
// Checksum 0xc9601486, Offset: 0x12c
// Size: 0x67
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "fort_courtyard", &fort_courtyard_init, &fort_courtyard_shutdown );
    ztron_challenge::registerchallenge( "fort_courtyard", "fort_courtyard", &fort_courtyard_challenge, &function_f4527722e65206ab, 1, &function_553cf551db29aa6, &function_f6460138c1d6567c );
    
    if ( !level.ztron.var_371903e5801e0e08 )
    {
        ztron_arena::function_37c3ad87b4c84a3f( "fort_courtyard", 46, 10 );
    }
}

// Namespace ztron_arena_fort_courtyard
// Params 0
// Checksum 0x4c5538df, Offset: 0x19b
// Size: 0x3c
function fort_courtyard_init()
{
    ztron_weather::function_c66678f1a8379c69( "fort_courtyard", "Snow", 5, "round_about_to_start" );
    ztron_weather::function_c66678f1a8379c69( "fort_courtyard", "Wetness", 10, "round_about_to_start", 10 );
    level thread fort_courtyard_special_event();
}

// Namespace ztron_arena_fort_courtyard
// Params 0
// Checksum 0x3d1f1250, Offset: 0x1df
// Size: 0x2
function fort_courtyard_shutdown()
{
    
}

// Namespace ztron_arena_fort_courtyard
// Params 0
// Checksum 0x7b900777, Offset: 0x1e9
// Size: 0x5a
function fort_courtyard_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 2 )
        {
            ztron_bonus_room::function_b018ee630661e155( "rail_shooter" );
        }
    }
}

// Namespace ztron_arena_fort_courtyard
// Params 0
// Checksum 0x3a5203c9, Offset: 0x24b
// Size: 0x21
function fort_courtyard_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "vermin" );
}

// Namespace ztron_arena_fort_courtyard
// Params 0
// Checksum 0x9c0eba98, Offset: 0x274
// Size: 0x15
function function_f4527722e65206ab()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_fort_courtyard
// Params 0
// Checksum 0x1e5ec43e, Offset: 0x291
// Size: 0x4a
function function_553cf551db29aa6()
{
    chance = 100;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 60;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

// Namespace ztron_arena_fort_courtyard
// Params 0
// Checksum 0xf8668edd, Offset: 0x2e4
// Size: 0x46
function function_f6460138c1d6567c()
{
    var_13e779d5bde58881 = utility::getstructarray( "fort_courtyard_vermin_spawn", "targetname" );
    assert( var_13e779d5bde58881.size > 0, "<dev string:x24>" );
    spawnspot = var_13e779d5bde58881[ randomintrange( 0, var_13e779d5bde58881.size ) ];
    return spawnspot;
}

