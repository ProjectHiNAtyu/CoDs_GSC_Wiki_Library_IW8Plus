// scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_audio.gsc  (hash_040f3d3cf813a9d9.gscc) (size: 1194 Bytes / 0x4aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e437109 (2655219977)
// size ...... 1194 (0x4aa)
// includes .. 2   (offset: 0x41e)
// strings ... 9   (offset: 0x42e)
// dev strs .. 0   (offset: 0x4aa)
// exports ... 5   (offset: 0x252)
// cseg ...... 0x121 + 0x131 (0x252)
// imports ... 9   (offset: 0x31a)
// animtree1 . 0   (offset: 0x4aa)
// animtree2 . 0   (offset: 0x4aa)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\utility;

#namespace zombie_hermes_audio;

// Namespace zombie_hermes_audio
// Params 0
// Checksum 0x47766db1, Offset: 0x13f
// Size: 0x6e
function function_7d58d6c5ab44526f()
{
    if ( utility::flag( "hermes_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "hermes_audio" );
    zombie_vox::register_vox_state( "pain_vox", "pain_vox", "vox_ai_hermes_pain", 3, 2600 );
    zombie_vox::register_vox_state( "big_missile_attack_vox", "big_missile_attack_vox", "vox_ai_hermes_big_missile_attack", 3, 3600 );
    zombie_vox::register_vox_state( "big_missile_attack_end_vox", "big_missile_attack_end_vox", "vox_ai_hermes_big_missile_attack_end", 3, 2700 );
}

// Namespace zombie_hermes_audio
// Params 0
// Checksum 0x76ae7ea9, Offset: 0x1b5
// Size: 0xe
function init_zombie_hermes_audio()
{
    zombie_vox::register_play_vox_fn( &play_zombie_vo );
}

// Namespace zombie_hermes_audio
// Params 6, eflags: 0x4
// Checksum 0xc45df16a, Offset: 0x1cb
// Size: 0x47
function private play_zombie_vo( event, zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    zombie_vox::function_e7828eef0e4316d6( zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_hermes_audio
// Params 1, eflags: 0x4
// Checksum 0x59b11a47, Offset: 0x21a
// Size: 0x38
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( "sound_vo", "off" );
    }
}

