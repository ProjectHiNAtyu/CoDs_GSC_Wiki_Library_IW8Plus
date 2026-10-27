// script_fa23170fddd5c01  (hash_0fa23170fddd5c01.gscc) (size: 4186 Bytes / 0x105a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9497dc7a (2492980346)
// size ...... 4186 (0x105a)
// includes .. 8   (offset: 0xf56)
// strings ... 13  (offset: 0xf96)
// dev strs .. 0   (offset: 0x105a)
// exports ... 14  (offset: 0x8da)
// cseg ...... 0x151 + 0x789 (0x8da)
// imports ... 38  (offset: 0xb0a)
// animtree1 . 0   (offset: 0x105a)
// animtree2 . 0   (offset: 0x105a)
#using script_36f4df0af71365fa;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_arena_lava_cave;

// Namespace ztron_arena_lava_cave
// Params 0, eflags: 0x5
// Checksum 0xabab9cdc, Offset: 0x16f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"lava_cave", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_lava_cave
// Params 0
// Checksum 0x6512e14d, Offset: 0x190
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_lava_cave
// Params 0
// Checksum 0xa1734934, Offset: 0x1a1
// Size: 0x71
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "lava_cave", &lava_cave_init, &lava_cave_shutdown );
    namespace_e1711960173e16b5::registerchallenge( "lava_cave", "lava_cave", &lava_cave_challenge, &function_1498af2bc083a34e, 1, &function_54a00ac27f6415f7 );
    arena = ztron_arena::function_973956bb5a6e60f7( "lava_cave" );
    arena.var_bbb74b6dde0dc6bd = 1;
    arena.exitvfx = "ztron_lava_cave_exit";
}

// Namespace ztron_arena_lava_cave
// Params 0
// Checksum 0x6b982de, Offset: 0x21a
// Size: 0x59
function lava_cave_init()
{
    ztron_enemy::function_c432c192a10985ad( "mannequin" );
    ztron_enemy::function_c432c192a10985ad( "barreler_zombie" );
    var_3933c97045c92f4 = utility::getstructarray( "lava_cave_event_elemental_terrain", "targetname" );
    var_3933c97045c92f4 = arrayrandomize( var_3933c97045c92f4 );
    self.var_14624c950f648777 = var_3933c97045c92f4;
    level thread function_8448a561329cf3f7();
    level thread lava_cave_special_event();
}

// Namespace ztron_arena_lava_cave
// Params 0
// Checksum 0x577fff5, Offset: 0x27b
// Size: 0x73
function lava_cave_special_event()
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

// Namespace ztron_arena_lava_cave
// Params 0
// Checksum 0x4ef8b395, Offset: 0x2f6
// Size: 0xad
function function_8448a561329cf3f7()
{
    level endon( #"arena_completed", #"ztron_game_is_over" );
    terrains = level.ztron.active_arena.var_14624c950f648777;
    i = 0;
    
    while ( i < terrains.size )
    {
        level waittill( #"round_begin" );
        
        if ( level.ztron.arena_rounds_left == 4 )
        {
            continue;
        }
        
        while ( i < 4 - level.ztron.arena_rounds_left )
        {
            level childthread function_b4f877d442038284( terrains[ i ] );
            i++;
        }
    }
}

// Namespace ztron_arena_lava_cave
// Params 0
// Checksum 0xc0ae22bf, Offset: 0x3ab
// Size: 0x21
function lava_cave_shutdown()
{
    function_b908fd78f7df3f78();
    ztron_enemy::function_103f4348c83c32ce( "mannequin" );
    ztron_enemy::function_103f4348c83c32ce( "barreler_zombie" );
}

// Namespace ztron_arena_lava_cave
// Params 0
// Checksum 0xad87eae2, Offset: 0x3d4
// Size: 0x15
function function_1498af2bc083a34e()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_lava_cave
// Params 0
// Checksum 0x3331d687, Offset: 0x3f1
// Size: 0x4a
function function_54a00ac27f6415f7()
{
    chance = 10;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 5;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

// Namespace ztron_arena_lava_cave
// Params 0
// Checksum 0xd839dbf0, Offset: 0x444
// Size: 0x21
function lava_cave_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "hellhound" );
}

// Namespace ztron_arena_lava_cave
// Params 1
// Checksum 0x49206275, Offset: 0x46d
// Size: 0x2ac
function function_b4f877d442038284( terrainstruct )
{
    targets = ztron_util::function_2d9de5c7b97db39( terrainstruct.target, "targetname" );
    targets = arraycombine( targets, utility::getstructarray( terrainstruct.target, "targetname" ) );
    terrainstruct.navbadplaces = [];
    var_ef88dfe3d7a9e8fb = [];
    
    foreach ( target in targets )
    {
        if ( isstruct( target ) && target.script_noteworthy == "lava_model" && isdefined( target.script_parameters ) )
        {
            var_f87120e371a2593c = utility::spawn_model( target.script_parameters, target.origin + ( 0, 0, -64 ), target.angles ?? ( 0, 0, 0 ) );
            var_f87120e371a2593c movez( 64, 1.5 );
            terrainstruct.var_f87120e371a2593c = var_f87120e371a2593c;
            terrainstruct.terrainraised = 1;
        }
        else if ( isstruct( target ) && target.script_noteworthy == "lava_vfx" )
        {
            vfx_scriptable = spawnscriptable( "scriptable_zombie_triton_lava_bomb_aoe_ztron_lava_cave", target.origin );
            vfx_scriptable setscriptablepartstate( "impact", "impact" );
            var_ef88dfe3d7a9e8fb[ var_ef88dfe3d7a9e8fb.size ] = vfx_scriptable;
        }
        
        if ( issubstr( target.code_classname, "trigger_box" ) )
        {
            navbadplace = createnavbadplacebyent( target, 14.9 );
            terrainstruct.navbadplaces[ terrainstruct.navbadplaces.size ] = navbadplace;
        }
    }
    
    wait 1.5;
    
    if ( var_ef88dfe3d7a9e8fb.size > 0 )
    {
        foreach ( vfx_scriptable in var_ef88dfe3d7a9e8fb )
        {
            vfx_scriptable setscriptablepartstate( "impact", "off" );
            vfx_scriptable freescriptable();
        }
    }
    
    terrainstruct.iseventbased = 1;
    namespace_8b88d3ab6f21188c::function_e77e60658a87d640( terrainstruct );
}

// Namespace ztron_arena_lava_cave
// Params 1
// Checksum 0x97d15faa, Offset: 0x721
// Size: 0x136
function function_6683cc6fe5e286df( terrainstruct )
{
    if ( terrainstruct.terrainraised )
    {
        targets = ztron_util::function_2d9de5c7b97db39( terrainstruct.target, "targetname" );
        
        if ( isdefined( terrainstruct.var_f87120e371a2593c ) )
        {
            terrainstruct.var_f87120e371a2593c.origin += ( 0, 0, -64 );
            terrainstruct.var_f87120e371a2593c delete();
            terrainstruct.var_f87120e371a2593c = undefined;
        }
        
        foreach ( navbadplace in terrainstruct.navbadplaces )
        {
            if ( isdefined( navbadplace ) )
            {
                destroynavobstacle( navbadplace );
            }
        }
        
        terrainstruct.terrainraised = 0;
    }
    
    terrainstruct notify( #"destroy_hazard" );
}

// Namespace ztron_arena_lava_cave
// Params 0
// Checksum 0xa88577c9, Offset: 0x85f
// Size: 0x7b
function function_b908fd78f7df3f78()
{
    foreach ( var_b107b25d793b0faf in self.var_14624c950f648777 )
    {
        function_6683cc6fe5e286df( var_b107b25d793b0faf );
    }
}

