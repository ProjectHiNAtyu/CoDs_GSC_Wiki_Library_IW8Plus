// scripts\common\ai\aitypes\zombie_loom_minion\zombie_loom_minion_audio.gsc  (hash_12cac594068d4e8d.gscc) (size: 941 Bytes / 0x3ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x493e7c81 (1228831873)
// size ...... 941 (0x3ad)
// includes .. 2   (offset: 0x361)
// strings ... 5   (offset: 0x371)
// dev strs .. 0   (offset: 0x3ad)
// exports ... 6   (offset: 0x191)
// cseg ...... 0xa6 + 0xeb (0x191)
// imports ... 8   (offset: 0x281)
// animtree1 . 0   (offset: 0x3ad)
// animtree2 . 0   (offset: 0x3ad)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;

#namespace zombie_loom_minion_audio;

// Namespace zombie_loom_minion_audio
// Params 0
// Checksum 0x274f48ba, Offset: 0xc4
// Size: 0xa
function function_21b025ba754e4741()
{
    level thread manage_ambient_cap();
}

// Namespace zombie_loom_minion_audio
// Params 0
// Checksum 0xfb7cf92c, Offset: 0xd6
// Size: 0x1a
function init_zombie_loom_minion_audio()
{
    thread play_zombie_ambient_repeating();
    callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
}

// Namespace zombie_loom_minion_audio
// Params 1, eflags: 0x4
// Checksum 0xee821f7e, Offset: 0xf8
// Size: 0x57
function private function_7920cd06bcb55c15( params )
{
    assert( isdefined( params.body ) );
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( "sound_vo", "off" );
    }
    
    level thread zombie_vox::function_e7828eef0e4316d6( params.body, "death", "vox_ai_loom_minion_death", 4 );
}

// Namespace zombie_loom_minion_audio
// Params 0
// Checksum 0x78129998, Offset: 0x157
// Size: 0x2
function play_zombie_ambient_repeating()
{
    
}

// Namespace zombie_loom_minion_audio
// Params 0, eflags: 0x4
// Checksum 0x71b48fdf, Offset: 0x161
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

