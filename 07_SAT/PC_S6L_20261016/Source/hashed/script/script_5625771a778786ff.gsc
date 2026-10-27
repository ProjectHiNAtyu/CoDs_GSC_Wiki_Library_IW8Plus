// script_5625771a778786ff  (hash_5625771a778786ff.gscc) (size: 2015 Bytes / 0x7df / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe647abbb (3863456699)
// size ...... 2015 (0x7df)
// includes .. 6   (offset: 0x75f)
// strings ... 5   (offset: 0x78f)
// dev strs .. 0   (offset: 0x7df)
// exports ... 12  (offset: 0x383)
// cseg ...... 0xa2 + 0x2e1 (0x383)
// imports ... 18  (offset: 0x563)
// animtree1 . 0   (offset: 0x7df)
// animtree2 . 0   (offset: 0x7df)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_estate_courtyard;

// Namespace ztron_arena_estate_courtyard
// Params 0, eflags: 0x5
// Checksum 0x7748cdeb, Offset: 0xc0
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"estate_courtyard", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_estate_courtyard
// Params 0
// Checksum 0x4e06703e, Offset: 0xe1
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_estate_courtyard
// Params 0
// Checksum 0xbb07515e, Offset: 0xf2
// Size: 0x3b
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "estate_courtyard", &estate_courtyard_init, &estate_courtyard_shutdown );
    ztron_challenge::registerchallenge( "estate_courtyard", "estate_courtyard", &estate_courtyard_challenge, &function_b894fac8fe98cf74, 1, &function_397c735643fd24d5 );
}

// Namespace ztron_arena_estate_courtyard
// Params 0
// Checksum 0xb540d988, Offset: 0x135
// Size: 0x70
function estate_courtyard_init()
{
    ztron_weather::function_c66678f1a8379c69( "estate_courtyard", "Snow", 5, "round_about_to_start", 12 );
    ztron_weather::function_c66678f1a8379c69( "estate_courtyard", "Wetness", 5, "round_about_to_start", 12 );
    level.ztron.var_845785fe1acb998a = &function_903ad0895928478e;
    level.ztron.var_19104e5e9d7f256a = &function_b8ca4a67e46eaaa6;
    level thread function_b9352020c0b31d89();
}

// Namespace ztron_arena_estate_courtyard
// Params 0
// Checksum 0x386afaa8, Offset: 0x1ad
// Size: 0x73
function function_b9352020c0b31d89()
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

// Namespace ztron_arena_estate_courtyard
// Params 1, eflags: 0x4
// Checksum 0x1fc7b5f5, Offset: 0x228
// Size: 0x43
function private function_903ad0895928478e( mode )
{
    switch ( mode )
    {
        case 2:
            return 800;
        case 3:
            return 1000;
        default:
            return;
    }
}

// Namespace ztron_arena_estate_courtyard
// Params 1, eflags: 0x4
// Checksum 0x2d197ca7, Offset: 0x273
// Size: 0x47
function private function_b8ca4a67e46eaaa6( mode )
{
    switch ( mode )
    {
        case 2:
            return 1.8;
        case 3:
            return 2.25;
        default:
            return;
    }
}

// Namespace ztron_arena_estate_courtyard
// Params 0
// Checksum 0x45e92242, Offset: 0x2c2
// Size: 0x28
function estate_courtyard_shutdown()
{
    level.ztron.var_845785fe1acb998a = undefined;
    level.ztron.var_19104e5e9d7f256a = undefined;
}

// Namespace ztron_arena_estate_courtyard
// Params 0
// Checksum 0xcb07de81, Offset: 0x2f2
// Size: 0x21
function estate_courtyard_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "amalgam" );
}

// Namespace ztron_arena_estate_courtyard
// Params 0
// Checksum 0x9de57c79, Offset: 0x31b
// Size: 0x15
function function_b894fac8fe98cf74()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_estate_courtyard
// Params 0
// Checksum 0xddc56dd4, Offset: 0x338
// Size: 0x4a
function function_397c735643fd24d5()
{
    chance = 3;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 2;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

