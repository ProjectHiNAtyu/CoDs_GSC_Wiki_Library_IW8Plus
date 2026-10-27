// scripts\common\ai\aitypes\zombie_vermin\zombie_vermin_audio.gsc  (hash_6937db634c2ea27d.gscc) (size: 936 Bytes / 0x3a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x326b315e (845885790)
// size ...... 936 (0x3a8)
// includes .. 2   (offset: 0x35c)
// strings ... 5   (offset: 0x36c)
// dev strs .. 0   (offset: 0x3a8)
// exports ... 6   (offset: 0x18c)
// cseg ...... 0xa1 + 0xeb (0x18c)
// imports ... 8   (offset: 0x27c)
// animtree1 . 0   (offset: 0x3a8)
// animtree2 . 0   (offset: 0x3a8)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;

#namespace zombie_vermin_audio;

// Namespace zombie_vermin_audio
// Params 0
// Checksum 0x2d572111, Offset: 0xbf
// Size: 0xa
function init_zombie_vermin_audio_global()
{
    level thread manage_ambient_cap();
}

// Namespace zombie_vermin_audio
// Params 0
// Checksum 0xc2193511, Offset: 0xd1
// Size: 0x1a
function init_zombie_vermin_audio()
{
    thread play_zombie_ambient_repeating();
    callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
}

// Namespace zombie_vermin_audio
// Params 1, eflags: 0x4
// Checksum 0x39d4707f, Offset: 0xf3
// Size: 0x57
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( "sound_vo", "off" );
    }
    
    level thread zombie_vox::function_e7828eef0e4316d6( params.body, "death", "vox_ai_vermin_death", 4 );
}

// Namespace zombie_vermin_audio
// Params 0
// Checksum 0xe1c6a9cd, Offset: 0x152
// Size: 0x2
function play_zombie_ambient_repeating()
{
    
}

// Namespace zombie_vermin_audio
// Params 0, eflags: 0x4
// Checksum 0xe860bf8a, Offset: 0x15c
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

