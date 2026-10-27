// scripts\common\ai\aitypes\zombie_shade\zombie_shade_audio.gsc  (hash_612512fe7c58049f.gscc) (size: 2822 Bytes / 0xb06 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x998e87f0 (2576254960)
// size ...... 2822 (0xb06)
// includes .. 4   (offset: 0x926)
// strings ... 33  (offset: 0x946)
// dev strs .. 0   (offset: 0xb06)
// exports ... 7   (offset: 0x5ba)
// cseg ...... 0x28a + 0x330 (0x5ba)
// imports ... 20  (offset: 0x6d2)
// animtree1 . 0   (offset: 0xb06)
// animtree2 . 0   (offset: 0xb06)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_shade_audio;

// Namespace zombie_shade_audio
// Params 0
// Checksum 0x725158a1, Offset: 0x2a8
// Size: 0x130
function function_45dd9f685e16e82a()
{
    zombie_vox::register_vox_state( "ambient", "ambient", "vox_ai_shade_ambient", 1, 3000 );
    zombie_vox::register_vox_state( "melee", "melee", "vox_ai_shade_melee", 2, 1500 );
    zombie_vox::register_vox_state( "melee_vehicle", "melee_vehicle", "vo`give ammox_ai_shade_melee", 2, 1500 );
    zombie_vox::register_vox_state( "jump_vehicle", "jump_vehicle", "vox_ai_shade_jump_onto_vehicle", 2 );
    zombie_vox::register_vox_state( "on_vehicle_roar", "on_vehicle_roar", "vox_ai_shade_roar", 2, 1500 );
    zombie_vox::register_vox_state( "pain", "pain", "vox_ai_shade_pain", 3, 1500 );
    zombie_vox::register_vox_state( "stunned", "stunned", "vox_ai_shade_stunned", 3, 1500 );
    zombie_vox::register_vox_state( "blackhole", "blackhole", "vox_ai_shade_blackhole", 3, 1500 );
    zombie_vox::register_vox_state( "knockdown", "knockdown", "vox_ai_shade_knockdown", 3, 1750 );
    zombie_vox::register_vox_state( "jump", "jump", "vox_ai_shade_jump", 2, 1750 );
    zombie_vox::register_vox_state( "land", "land", "vox_ai_shade_land", 2, 1750 );
    level thread manage_ambient_cap();
}

// Namespace zombie_shade_audio
// Params 0
// Checksum 0x90e628ea, Offset: 0x3e0
// Size: 0x26
function init_zombie_shade_audio()
{
    thread play_zombie_ambient_repeating();
    zombie_vox::register_play_vox_fn( &play_zombie_vo );
    callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
}

// Namespace zombie_shade_audio
// Params 6, eflags: 0x4
// Checksum 0x430b782, Offset: 0x40e
// Size: 0x6f
function private play_zombie_vo( event, zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    if ( !zombie val::get( "allow_vo" ) )
    {
        return;
    }
    
    if ( zombie utility::function_9f2c41c1dcc8c94( "gib_head", "gibbed_alive" ) )
    {
        return;
    }
    
    zombie_vox::function_e7828eef0e4316d6( zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_shade_audio
// Params 1, eflags: 0x4
// Checksum 0x322ab3b9, Offset: 0x485
// Size: 0x6b
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( "sound_vo", "off" );
    }
    
    if ( utility::function_9f2c41c1dcc8c94( "gib_head", "gibbed" ) )
    {
        return;
    }
    
    level thread zombie_vox::function_e7828eef0e4316d6( params.body, "death", "vox_ai_shade_death", 4 );
}

// Namespace zombie_shade_audio
// Params 0
// Checksum 0x135c6d0a, Offset: 0x4f8
// Size: 0x8a
function play_zombie_ambient_repeating()
{
    var_fd16a9c5c5ac1ab1 = 3;
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    while ( true )
    {
        if ( isdefined( level.var_7538460147be1e93 ) )
        {
            level.var_7538460147be1e93++;
            
            if ( level.var_7538460147be1e93 < var_fd16a9c5c5ac1ab1 && !self.var_a8e9ab5fba96d982 )
            {
                zombie_vox::function_5ac4bed4a907abf5( "ambient" );
                waitframe();
                utility::ent_flag_waitopen_any( "playing_vo" );
            }
        }
        
        wait randomfloatrange( 1, 2.5 );
    }
}

// Namespace zombie_shade_audio
// Params 0, eflags: 0x4
// Checksum 0xa457b4e6, Offset: 0x58a
// Size: 0x30
function private manage_ambient_cap()
{
    level endon( #"game_ended" );
    level.var_7538460147be1e93 = 0;
    
    while ( true )
    {
        level.var_7538460147be1e93 = 0;
        wait 0.1;
    }
}

