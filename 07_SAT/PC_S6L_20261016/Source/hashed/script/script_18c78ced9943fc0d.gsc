// script_18c78ced9943fc0d  (hash_18c78ced9943fc0d.gscc) (size: 2549 Bytes / 0x9f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa567360f (2775004687)
// size ...... 2549 (0x9f5)
// includes .. 8   (offset: 0x945)
// strings ... 8   (offset: 0x985)
// dev strs .. 0   (offset: 0x9f5)
// exports ... 11  (offset: 0x535)
// cseg ...... 0xdc + 0x459 (0x535)
// imports ... 21  (offset: 0x6ed)
// animtree1 . 0   (offset: 0x9f5)
// animtree2 . 0   (offset: 0x9f5)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_aethereal_swamp;

// Namespace ztron_arena_aethereal_swamp
// Params 0, eflags: 0x5
// Checksum 0x67fdbb86, Offset: 0xfa
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"aethereal_swamp", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_aethereal_swamp
// Params 0
// Checksum 0x886584a7, Offset: 0x11b
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_aethereal_swamp
// Params 0
// Checksum 0xcc8ef6f0, Offset: 0x12c
// Size: 0x3b
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "aethereal_swamp", &aethereal_swamp_init, &aethereal_swamp_shutdown );
    ztron_challenge::registerchallenge( "aethereal_swamp", "aethereal_swamp", &aethereal_swamp_challenge, &function_4be3ebb7e563b986, 1, &function_d0c4c5c6a700398f );
}

// Namespace ztron_arena_aethereal_swamp
// Params 0
// Checksum 0x30f12c06, Offset: 0x16f
// Size: 0x54
function aethereal_swamp_init()
{
    ztron_weather::function_c66678f1a8379c69( "aethereal_swamp", "Wetness", 15, "round_about_to_start" );
    level.ztron.var_cbfc78346d18c0a0 = &function_c7a6d7c23caa5f8f;
    self.var_220593ca19df8dd6 = utility::getstructarray( "aethereal_swamp_rise_spot", "targetname" );
    level thread aethereal_swamp_special_event();
}

// Namespace ztron_arena_aethereal_swamp
// Params 0
// Checksum 0x686da1ed, Offset: 0x1cb
// Size: 0x69
function aethereal_swamp_shutdown()
{
    enemy_def = ztron_enemy::function_96eea0d09d5640d1( "riser_zombie" );
    
    if ( isdefined( enemy_def ) && isdefined( self.var_e06edc6a881a62fd ) )
    {
        enemy_def.original_chance = self.var_e06edc6a881a62fd;
        enemy_def.spawn_chance = self.var_e06edc6a881a62fd;
    }
    
    level.ztron.var_cbfc78346d18c0a0 = undefined;
}

// Namespace ztron_arena_aethereal_swamp
// Params 0
// Checksum 0xe6b9a9e0, Offset: 0x23c
// Size: 0x21
function aethereal_swamp_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "toxic" );
}

// Namespace ztron_arena_aethereal_swamp
// Params 0
// Checksum 0xd7625248, Offset: 0x265
// Size: 0xdf
function aethereal_swamp_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 3 )
        {
            enemy_def = ztron_enemy::function_96eea0d09d5640d1( "riser_zombie" );
            
            if ( isdefined( enemy_def ) )
            {
                level.ztron.active_arena.var_e06edc6a881a62fd = enemy_def.original_chance;
                enemy_def.original_chance = 50;
            }
        }
        
        if ( level.ztron.arena_rounds_left == 2 && !level.ztron.var_95d8c7a469393957 )
        {
            ztron_bonus_room::function_b018ee630661e155( "eggxit" );
        }
    }
}

// Namespace ztron_arena_aethereal_swamp
// Params 0
// Checksum 0xef7a22f1, Offset: 0x34c
// Size: 0x15
function function_4be3ebb7e563b986()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_aethereal_swamp
// Params 0
// Checksum 0xc50cd1a8, Offset: 0x369
// Size: 0x4a
function function_d0c4c5c6a700398f()
{
    chance = 100;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 50;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

// Namespace ztron_arena_aethereal_swamp
// Params 0
// Checksum 0x95d662a0, Offset: 0x3bc
// Size: 0x178
function function_c7a6d7c23caa5f8f()
{
    if ( !isdefined( level.ztron.active_arena.var_220593ca19df8dd6 ) || level.ztron.active_arena.var_220593ca19df8dd6.size <= 0 )
    {
        return;
    }
    
    closetplayer = ztron_player_utility::function_55e798aacb02a82f( self.origin );
    
    if ( isdefined( closetplayer ) )
    {
        validspots = [];
        
        foreach ( spot in level.ztron.active_arena.var_220593ca19df8dd6 )
        {
            dist = distance( spot.origin, closetplayer.origin );
            
            if ( dist >= 128 && dist <= 256 )
            {
                validspots[ validspots.size ] = spot;
            }
        }
        
        if ( validspots.size > 0 )
        {
            spawnloc = utility::array_random( validspots );
            return spawnloc;
        }
    }
    
    spawnloc = utility::array_random( level.ztron.active_arena.var_220593ca19df8dd6 );
    return spawnloc;
}

