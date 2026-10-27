// scripts\common\ai\aitypes\zombie_parasite\zombie_parasite_audio.gsc  (hash_5f77a79da71bf6dd.gscc) (size: 1721 Bytes / 0x6b9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa96b628d (2842387085)
// size ...... 1721 (0x6b9)
// includes .. 2   (offset: 0x5b5)
// strings ... 18  (offset: 0x5c5)
// dev strs .. 0   (offset: 0x6b9)
// exports ... 6   (offset: 0x37d)
// cseg ...... 0x199 + 0x1e4 (0x37d)
// imports ... 11  (offset: 0x46d)
// animtree1 . 0   (offset: 0x6b9)
// animtree2 . 0   (offset: 0x6b9)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\utility;

#namespace zombie_parasite_audio;

// Namespace zombie_parasite_audio
// Params 0
// Checksum 0x57d81ac9, Offset: 0x1b7
// Size: 0x9a
function init_zombie_parasite_audio_global()
{
    zombie_vox::register_vox_state( "ambient", "ambient", "vox_ai_parasite_ambient", 1 );
    zombie_vox::register_vox_state( "spit_tell", "spit_tell", "vox_ai_parasite_preattack", 2 );
    zombie_vox::register_vox_state( "spit_attack", "spit_attack", "vox_ai_parasite_spit", 3 );
    zombie_vox::register_vox_state( "spawn", "spawn", "vox_ai_parasite_spawn", 3 );
    zombie_vox::register_vox_state( "startle", "startle", "vox_ai_parasite_startle", 2 );
    zombie_vox::register_vox_state( "evolution", "evolution", "vox_ai_parasite_evolution", 3 );
    level thread manage_ambient_cap();
}

// Namespace zombie_parasite_audio
// Params 0
// Checksum 0x8a76c0fa, Offset: 0x259
// Size: 0x9
function init_zombie_parasite_audio()
{
    thread play_zombie_ambient_repeating();
}

// Namespace zombie_parasite_audio
// Params 1, eflags: 0x4
// Checksum 0xfec339c7, Offset: 0x26a
// Size: 0x57
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( "sound_vo", "off" );
    }
    
    level thread zombie_vox::function_e7828eef0e4316d6( params.body, "death", "vox_ai_parasite_death", 4 );
}

// Namespace zombie_parasite_audio
// Params 0
// Checksum 0x1f20edc4, Offset: 0x2c9
// Size: 0x7c
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
            
            if ( level.var_7538460147be1e93 < var_fd16a9c5c5ac1ab1 )
            {
                zombie_vox::function_5ac4bed4a907abf5( "ambient" );
                waitframe();
                utility::ent_flag_waitopen_any( "playing_vo" );
            }
        }
        
        wait randomfloatrange( 1, 2.5 );
    }
}

// Namespace zombie_parasite_audio
// Params 0, eflags: 0x4
// Checksum 0xead0c55c, Offset: 0x34d
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

