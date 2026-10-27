// script_ec83a8d93585fd4  (hash_0ec83a8d93585fd4.gscc) (size: 4656 Bytes / 0x1230 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e7f3d9e (2659138974)
// size ...... 4656 (0x1230)
// includes .. 11  (offset: 0x10e0)
// strings ... 17  (offset: 0x1138)
// dev strs .. 0   (offset: 0x1230)
// exports ... 19  (offset: 0x940)
// cseg ...... 0x198 + 0x7a8 (0x940)
// imports ... 42  (offset: 0xc38)
// animtree1 . 0   (offset: 0x1230)
// animtree2 . 0   (offset: 0x1230)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_sculpture;

// Namespace ztron_arena_sculpture
// Params 0, eflags: 0x5
// Checksum 0x59a01bf5, Offset: 0x1b6
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"sculpture", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_sculpture
// Params 0
// Checksum 0xd337c069, Offset: 0x1d7
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_sculpture
// Params 0
// Checksum 0x3b15d9c9, Offset: 0x1e8
// Size: 0x4c
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "sculpture", &sculpture_init, &sculpture_shutdown );
    utility::add_fx( "ztron_hive_exp", "vfx_sat_zm_parasite_hive_exp_ztron" );
    namespace_e1711960173e16b5::registerchallenge( "sculpture", "sculpture", &sculpture_challenge, &function_d431b862f6bde889, 1, &function_2256d9d6eea3e144 );
}

// Namespace ztron_arena_sculpture
// Params 0
// Checksum 0x9da8b1ff, Offset: 0x23c
// Size: 0x5a
function sculpture_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 2 )
        {
            ztron_bonus_room::function_b018ee630661e155( "racing2" );
        }
    }
}

// Namespace ztron_arena_sculpture
// Params 0
// Checksum 0x719671ce, Offset: 0x29e
// Size: 0xad
function function_8c12d157034599d0()
{
    level endon( #"ztron_game_is_over" );
    level utility::flag_set( "arena_hold_teleporter" );
    
    if ( !level.ztron.var_95d8c7a469393957 )
    {
        level.ztron.var_3678ff7453f3c5cf = "slayer_arena_activated";
        level waittill( #"hash_824e1ffce3b44832" );
        level notify( #"kill_teleporter" );
    }
    else
    {
        level.ztron.var_3678ff7453f3c5cf = "slayer_intro_done";
        level waittill( #"slayer_intro_done" );
        level.ztron.var_3678ff7453f3c5cf = undefined;
    }
    
    level utility::flag_clear( "arena_hold_teleporter" );
}

// Namespace ztron_arena_sculpture
// Params 0
// Checksum 0x2f8cfa41, Offset: 0x353
// Size: 0x86
function function_93db9b03e1fe239b()
{
    if ( level.ztron.blitzmode )
    {
        return;
    }
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        level.ztron.var_d0972e445894306d = 1200;
        return;
    }
    
    note = level utility::waittill_any_return( "teleporter_being_opened" );
    level thread function_8c12d157034599d0();
    level thread ztron_slayer::function_1485aa63334f37b0( "beta", "sculpture" );
    level waittill( #"slayer_intro_done" );
}

// Namespace ztron_arena_sculpture
// Params 0
// Checksum 0x4970ec07, Offset: 0x3e1
// Size: 0x21
function sculpture_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "parasite" );
}

// Namespace ztron_arena_sculpture
// Params 0
// Checksum 0x1387885c, Offset: 0x40a
// Size: 0x15
function function_d431b862f6bde889()
{
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_arena_sculpture
// Params 0
// Checksum 0x2218f75a, Offset: 0x427
// Size: 0x4a
function function_2256d9d6eea3e144()
{
    chance = 5;
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        chance = 3;
    }
    
    if ( randomint( 100 ) < chance )
    {
        return level.ztron.var_cd3b78b45db638d8;
    }
}

// Namespace ztron_arena_sculpture
// Params 0
// Checksum 0xedec3117, Offset: 0x47a
// Size: 0x46
function sculpture_init()
{
    ztron_weather::function_c66678f1a8379c69( "sculpture", "Snow", 3, "round_about_to_start", 8 );
    ztron_weather::function_c66678f1a8379c69( "sculpture", "Wetness", 5, "round_about_to_start", 8 );
    level thread function_93db9b03e1fe239b();
    level thread sculpture_special_event();
}

// Namespace ztron_arena_sculpture
// Params 0
// Checksum 0x48dca5b7, Offset: 0x4c8
// Size: 0x2
function sculpture_shutdown()
{
    
}

// Namespace ztron_arena_sculpture
// Params 0, eflags: 0x4
// Checksum 0x34b08a56, Offset: 0x4d2
// Size: 0x8f, Type: bool
function private is_round_over()
{
    hivenumber = 0;
    
    foreach ( hivespot in self.hivespots )
    {
        if ( function_538ae779e2438090( hivespot ) )
        {
            hivenumber++;
        }
    }
    
    return hivenumber == 0;
}

// Namespace ztron_arena_sculpture
// Params 1, eflags: 0x4
// Checksum 0xd33a6f30, Offset: 0x56a
// Size: 0x18, Type: bool
function private function_538ae779e2438090( hivespot )
{
    return isdefined( hivespot.script_model );
}

// Namespace ztron_arena_sculpture
// Params 0, eflags: 0x4
// Checksum 0x5b28a3d9, Offset: 0x58b
// Size: 0x94
function private hive_clear()
{
    self waittill( #"hive_shutdown" );
    self.var_2d9687bd0601271a = undefined;
    
    foreach ( hivespot in self.hivespots )
    {
        hivespot.var_2d8041df79adb2db = undefined;
    }
}

// Namespace ztron_arena_sculpture
// Params 0, eflags: 0x4
// Checksum 0x5b2802d6, Offset: 0x627
// Size: 0xa4
function private hive_spawn()
{
    self endon( #"hive_shutdown" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        hivespots = arrayrandomize( self.hivespots );
        
        for ( i = 0; i < 2 ; i++ )
        {
            if ( i < hivespots.size )
            {
                hivespot = hivespots[ i ];
                hivespot.var_2d8041df79adb2db = gettime() + 3000;
                ztron_hazard::function_ed33fea23f0d8109( #"enemy_spawner", #"create", hivespot, 0 );
                hivespot thread hive_think();
            }
        }
    }
}

// Namespace ztron_arena_sculpture
// Params 0, eflags: 0xc
// Checksum 0x6eee0b5f, Offset: 0x6d3
// Size: 0x65
function private hive_think()
{
    self notify( #"hash_ef5952920b1b143c" );
    self endon( #"hash_ef5952920b1b143c" );
    arena = level.ztron.active_arena;
    arena endon( #"hive_shutdown" );
    self waittill( #"destroy_hazard" );
    arena thread function_13a74c3dc6482cb5( self.origin );
}

// Namespace ztron_arena_sculpture
// Params 1, eflags: 0x4
// Checksum 0x371645bb, Offset: 0x740
// Size: 0x9f
function private function_13a74c3dc6482cb5( position )
{
    position = getgroundposition( position, 10 );
    hiveexp = utility::spawn_model( "tag_origin", position );
    hiveexp.trigger = spawn( "trigger_radius", position, 0, 64, 64 );
    playfxontag( utility::getfx( "ztron_hive_exp" ), hiveexp, "tag_origin" );
    hiveexp thread function_75766ccd629ede03();
    level utility::waittill_any_timeout( 8, "ztron_exit_taken", "ztron_teleporter_taken" );
    stopfxontag( utility::getfx( "ztron_hive_exp" ), hiveexp, "tag_origin" );
    hiveexp ztron_util::deletemedelay();
}

// Namespace ztron_arena_sculpture
// Params 0, eflags: 0xc
// Checksum 0xbe6cd6fa, Offset: 0x7e7
// Size: 0x159
function private function_75766ccd629ede03()
{
    self notify( #"hash_e09b8974606511d5" );
    self endon( #"hash_e09b8974606511d5" );
    self endon( #"death" );
    self.trigger endon( #"death" );
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_3bdb62af4e924e0f", 0 ) && isdefined( self.trigger ) )
            {
                drawtrigger( self.trigger, ( 1, 0, 0 ), 0, 30, 0, ( 1, 0, 0 ) );
            }
        #/
        
        if ( !isdefined( self.trigger ) )
        {
            break;
        }
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.ztron.vehicle ) )
            {
                continue;
            }
            
            if ( !player istouching( self.trigger ) )
            {
                continue;
            }
            
            player thread ztron_player_utility::function_1dc834c65d7c8ea( 3, 0.5 );
        }
        
        wait 0.1;
    }
}

