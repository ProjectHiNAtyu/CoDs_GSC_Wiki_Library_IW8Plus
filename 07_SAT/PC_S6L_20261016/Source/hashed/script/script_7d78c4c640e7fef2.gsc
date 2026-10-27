// script_7d78c4c640e7fef2  (hash_7d78c4c640e7fef2.gscc) (size: 2205 Bytes / 0x89d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8ffa50c0 (2415546560)
// size ...... 2205 (0x89d)
// includes .. 7   (offset: 0x811)
// strings ... 6   (offset: 0x849)
// dev strs .. 0   (offset: 0x89d)
// exports ... 12  (offset: 0x401)
// cseg ...... 0xb6 + 0x34b (0x401)
// imports ... 20  (offset: 0x5e1)
// animtree1 . 0   (offset: 0x89d)
// animtree2 . 0   (offset: 0x89d)
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_babylon;

// Namespace ztron_arena_babylon
// Params 0, eflags: 0x5
// Checksum 0x88bcf2b4, Offset: 0xd4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"babylon", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_babylon
// Params 0
// Checksum 0x48516e86, Offset: 0xf5
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_babylon
// Params 0
// Checksum 0x8f7ca2c0, Offset: 0x106
// Size: 0x3b
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "babylon", &babylon_init, &babylon_shutdown );
    ztron_challenge::registerchallenge( "babylon", "babylon", &babylon_challenge, &function_dcef67b5315fb777, 1, &function_3c07247246c5dcda );
}

// Namespace ztron_arena_babylon
// Params 0
// Checksum 0x8c80c233, Offset: 0x149
// Size: 0x21
function babylon_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "light_armored_zombie" );
}

// Namespace ztron_arena_babylon
// Params 0
// Checksum 0x5042d85d, Offset: 0x172
// Size: 0x15
function function_dcef67b5315fb777()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_babylon
// Params 0
// Checksum 0xc0ac918d, Offset: 0x18f
// Size: 0x4a
function function_3c07247246c5dcda()
{
    chance = 70;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 40;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

// Namespace ztron_arena_babylon
// Params 0
// Checksum 0x8b974afa, Offset: 0x1e2
// Size: 0x29
function babylon_init()
{
    ztron_weather::function_c66678f1a8379c69( "babylon", "Wetness", 5, "round_about_to_start" );
    thread rats_horde_spawn();
    level thread babylon_special_event();
}

// Namespace ztron_arena_babylon
// Params 0
// Checksum 0x1d901c46, Offset: 0x213
// Size: 0x72
function babylon_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 2 && !level.ztron.var_95d8c7a469393957 )
        {
            ztron_bonus_room::function_b018ee630661e155( "racing" );
        }
    }
}

// Namespace ztron_arena_babylon
// Params 0
// Checksum 0xe47eb9e8, Offset: 0x28d
// Size: 0xe
function babylon_shutdown()
{
    self notify( #"rats_horde_shutdown" );
}

// Namespace ztron_arena_babylon
// Params 0, eflags: 0xc
// Checksum 0x1dd7a379, Offset: 0x2a3
// Size: 0x6b
function private rats_horde_spawn()
{
    self notify( #"hash_be92b3c531452016" );
    self endon( #"hash_be92b3c531452016" );
    self endon( #"rats_horde_shutdown" );
    self.var_a1b095082e69a9c8 = ztron_arena::function_eb3bad474c41ae42( "rats_horde" );
    
    for ( roundcount = 0; true ; roundcount++ )
    {
        level waittill( #"round_about_to_start" );
        wait 5;
        thread rats_horde_spawn_loop( roundcount );
    }
}

// Namespace ztron_arena_babylon
// Params 1, eflags: 0xc
// Checksum 0xd05dd279, Offset: 0x316
// Size: 0xeb
function private rats_horde_spawn_loop( roundcount )
{
    self notify( #"hash_82ebd1f6819e4db3" );
    self endon( #"hash_82ebd1f6819e4db3" );
    level endon( #"round_over" );
    self endon( #"rats_horde_shutdown" );
    
    while ( true )
    {
        traps = arrayrandomize( self.var_a1b095082e69a9c8 );
        pathcount = roundcount + 1;
        
        for ( i = 0; i < pathcount ; i++ )
        {
            if ( i < self.var_a1b095082e69a9c8.size )
            {
                trap = traps[ i ];
                trap.trigger_radius = 30;
                trap.trigger_height = 45;
                trap.speed = 150;
                ztron_hazard::function_ed33fea23f0d8109( #"rats_horde", #"create", trap, 0 );
            }
        }
        
        wait 10;
    }
}

