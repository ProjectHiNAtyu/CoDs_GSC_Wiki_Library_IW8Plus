// scripts\mp\ftue\utility\ftue_sound.gsc  (hash_079b958000e312a8.gscc) (size: 1044 Bytes / 0x414 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x347711fd (880218621)
// size ...... 1044 (0x414)
// includes .. 0   (offset: 0x3cc)
// strings ... 6   (offset: 0x3cc)
// dev strs .. 0   (offset: 0x414)
// exports ... 5   (offset: 0x1f0)
// cseg ...... 0xcb + 0x125 (0x1f0)
// imports ... 9   (offset: 0x2b8)
// animtree1 . 0   (offset: 0x414)
// animtree2 . 0   (offset: 0x414)
#namespace ftue_sound;

// Namespace ftue_sound
// Params 0
// Checksum 0xdabf5586, Offset: 0xe9
// Size: 0x1a
function ftue_sound_init()
{
    function_71da6afd8f285aaf( 0.2 );
    function_3bf91d787467b79c( "mgl_ftue_tutorial_loop_01" );
}

// Namespace ftue_sound
// Params 2
// Checksum 0xed2c662d, Offset: 0x10b
// Size: 0x49
function function_da224db4447be8dc( soundalias, loop )
{
    assert( isdefined( soundalias ) );
    
    if ( isdefined( loop ) )
    {
        if ( loop )
        {
            self playloopsound( soundalias );
        }
        else
        {
            self playlocalsound( soundalias );
        }
        
        return;
    }
    
    self playlocalsound( soundalias );
}

// Namespace ftue_sound
// Params 1
// Checksum 0x626bc650, Offset: 0x15c
// Size: 0x1e
function function_3bf91d787467b79c( musicstate )
{
    assert( isdefined( musicstate ) );
    setmusicstate( musicstate );
}

// Namespace ftue_sound
// Params 1
// Checksum 0xe83ae0f5, Offset: 0x182
// Size: 0x6e
function function_71da6afd8f285aaf( volume )
{
    if ( getdvarint( @"snd_volume_mute", 0 ) == 1 )
    {
        return;
    }
    
    clamp( volume, 0, 1 );
    function_4ccf2548376945d3( "wpn_plr", volume );
    function_4ccf2548376945d3( "wpn_plr_atmo", volume );
    function_4ccf2548376945d3( "wpn_plr_mech", volume );
    function_4ccf2548376945d3( "wpn_reflections", volume );
    function_4ccf2548376945d3( "wpn_reflections_dist", volume );
}

