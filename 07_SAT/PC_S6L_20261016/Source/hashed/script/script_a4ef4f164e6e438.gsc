// script_a4ef4f164e6e438  (hash_0a4ef4f164e6e438.gscc) (size: 3041 Bytes / 0xbe1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6627dbd8 (1713888216)
// size ...... 3041 (0xbe1)
// includes .. 9   (offset: 0xaf9)
// strings ... 11  (offset: 0xb41)
// dev strs .. 0   (offset: 0xbe1)
// exports ... 14  (offset: 0x5e9)
// cseg ...... 0x11a + 0x4cf (0x5e9)
// imports ... 26  (offset: 0x819)
// animtree1 . 0   (offset: 0xbe1)
// animtree2 . 0   (offset: 0xbe1)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_dry_garden;

// Namespace ztron_arena_dry_garden
// Params 0, eflags: 0x5
// Checksum 0xecf34ea7, Offset: 0x138
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"dry_garden", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_dry_garden
// Params 0
// Checksum 0x6144c559, Offset: 0x159
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_dry_garden
// Params 0
// Checksum 0x82c54955, Offset: 0x16a
// Size: 0x3b
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "dry_garden", &dry_garden_init, &dry_garden_shutdown );
    namespace_e1711960173e16b5::registerchallenge( "dry_garden", "dry_garden", &dry_garden_challenge, &function_b58c236299dbaa2d, 1, &function_8a9cbbfd2edf89d0 );
}

// Namespace ztron_arena_dry_garden
// Params 0
// Checksum 0xc2521d78, Offset: 0x1ad
// Size: 0x72
function dry_garden_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 2 && !level.ztron.var_95d8c7a469393957 )
        {
            ztron_bonus_room::function_b018ee630661e155( "side_scroller1" );
        }
    }
}

// Namespace ztron_arena_dry_garden
// Params 0, eflags: 0xc
// Checksum 0x457d1fb8, Offset: 0x227
// Size: 0x4f
function private function_bea5626e1e4009ae()
{
    self notify( #"hash_b5b5024668581c28" );
    self endon( #"hash_b5b5024668581c28" );
    level endon( #"ztron_game_is_over", #"arena_deactivated" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        level.var_8972cc8b6869f399 = 1;
    }
}

// Namespace ztron_arena_dry_garden
// Params 0
// Checksum 0xfecec2c1, Offset: 0x27e
// Size: 0x10d
function dry_garden_init()
{
    ztron_weather::function_c66678f1a8379c69( "dry_garden", "Snow", 3, "round_about_to_start", 12 );
    ztron_weather::function_c66678f1a8379c69( "dry_garden", "Wetness", 5, "round_about_to_start", 12 );
    
    if ( !isdefined( level.ztron.heavyarmordef ) )
    {
        level.ztron.heavyarmordef = ztron_enemy::function_96eea0d09d5640d1( "heavy_armored_zombie" );
    }
    
    level.ztron.var_eb927027004f4817 = [];
    level.ztron.var_eb927027004f4817[ level.ztron.var_eb927027004f4817.size ] = level.ztron.heavyarmordef;
    level.ztron.var_cbfc78346d18c0a0 = &function_34f8424731ceb1a4;
    self.var_74dcc18e9abdfa37 = 7;
    thread function_bea5626e1e4009ae();
    level thread dry_garden_special_event();
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        level thread function_d534c675a9cb5db7();
    }
}

// Namespace ztron_arena_dry_garden
// Params 0
// Checksum 0x77cc0baf, Offset: 0x393
// Size: 0x32
function dry_garden_shutdown()
{
    level.var_8972cc8b6869f399 = 0;
    level.ztron.var_cbfc78346d18c0a0 = undefined;
    level.ztron.var_eb927027004f4817 = undefined;
}

// Namespace ztron_arena_dry_garden
// Params 0
// Checksum 0x9ec2b127, Offset: 0x3cd
// Size: 0x21
function dry_garden_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "ghoul" );
}

// Namespace ztron_arena_dry_garden
// Params 0
// Checksum 0xc13d70d7, Offset: 0x3f6
// Size: 0x15
function function_b58c236299dbaa2d()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_dry_garden
// Params 0
// Checksum 0xbef1623f, Offset: 0x413
// Size: 0x4a
function function_8a9cbbfd2edf89d0()
{
    chance = 8;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 5;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

// Namespace ztron_arena_dry_garden
// Params 0
// Checksum 0x4c63f2b8, Offset: 0x466
// Size: 0x41
function function_60fefb6b39425fc()
{
    level endon( #"ztron_game_is_over" );
    level utility::flag_set( "arena_hold_teleporter" );
    level waittill( #"hash_824e1ffce3b44832" );
    level notify( #"kill_teleporter" );
    level utility::flag_clear( "arena_hold_teleporter" );
}

// Namespace ztron_arena_dry_garden
// Params 0
// Checksum 0x6d22603f, Offset: 0x4af
// Size: 0x71
function function_d534c675a9cb5db7()
{
    if ( level.ztron.blitzmode )
    {
        return;
    }
    
    note = level utility::waittill_any_return( "teleporter_being_opened" );
    level.ztron.var_3678ff7453f3c5cf = "slayer_arena_activated";
    level thread function_60fefb6b39425fc();
    level thread ztron_slayer::function_1485aa63334f37b0( "beta", "dry_garden" );
    level waittill( #"hash_28620f26f5b39c43" );
}

// Namespace ztron_arena_dry_garden
// Params 0
// Checksum 0x994053f3, Offset: 0x528
// Size: 0xc0
function function_34f8424731ceb1a4()
{
    if ( !level.ztron.active_arena.var_220593ca19df8dd6.size )
    {
        return;
    }
    
    var_47d4e4a0ac15a445 = ( 23896, -42088, 160 );
    var_48dc892be99604b7 = 65536;
    closestplayer = ztron_player_utility::function_55e798aacb02a82f( self.origin );
    
    if ( !isdefined( closestplayer ) )
    {
        return;
    }
    
    if ( distance2dsquared( closestplayer.origin, var_47d4e4a0ac15a445 ) > var_48dc892be99604b7 )
    {
        return;
    }
    
    spawnloc = spawnstruct();
    spawnloc.origin = self.origin;
    spawnloc.angles = self.angles;
    return spawnloc;
}

