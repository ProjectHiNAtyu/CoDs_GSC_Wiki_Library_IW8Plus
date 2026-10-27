// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_audio.gsc  (hash_4021b4ae35d7cc31.gscc) (size: 957 Bytes / 0x3bd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x38be247b (951985275)
// size ...... 957 (0x3bd)
// includes .. 2   (offset: 0x369)
// strings ... 5   (offset: 0x379)
// dev strs .. 0   (offset: 0x3bd)
// exports ... 5   (offset: 0x1a5)
// cseg ...... 0xaa + 0xfb (0x1a5)
// imports ... 9   (offset: 0x26d)
// animtree1 . 0   (offset: 0x3bd)
// animtree2 . 0   (offset: 0x3bd)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\utility;

#namespace zombie_phobos_audio;

// Namespace zombie_phobos_audio
// Params 0
// Checksum 0xb42969a9, Offset: 0xc8
// Size: 0x38
function function_41f16ac1f5cce9f4()
{
    if ( utility::flag( "phobos_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "phobos_audio" );
    zombie_vox::register_vox_state( "pain_vox", "pain_vox", "vox_ai_zombie_phobos_pain_short", 3, 2600 );
}

// Namespace zombie_phobos_audio
// Params 0
// Checksum 0x2731d480, Offset: 0x108
// Size: 0xe
function init_zombie_phobos_audio()
{
    zombie_vox::register_play_vox_fn( &play_zombie_vo );
}

// Namespace zombie_phobos_audio
// Params 6, eflags: 0x4
// Checksum 0x95c25b43, Offset: 0x11e
// Size: 0x47
function private play_zombie_vo( event, zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    zombie_vox::function_e7828eef0e4316d6( zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_phobos_audio
// Params 1, eflags: 0x4
// Checksum 0x5587bf2a, Offset: 0x16d
// Size: 0x38
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( "sound_vo", "off" );
    }
}

