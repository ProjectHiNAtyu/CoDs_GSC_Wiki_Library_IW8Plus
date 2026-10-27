// scripts\mp\maps\mp_sat_karma\mp_sat_karma_audio.gsc  (hash_255b8c366a7a3734.gscc) (size: 861 Bytes / 0x35d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28339985 (674470277)
// size ...... 861 (0x35d)
// includes .. 1   (offset: 0x349)
// strings ... 1   (offset: 0x351)
// dev strs .. 0   (offset: 0x35d)
// exports ... 5   (offset: 0x195)
// cseg ...... 0x66 + 0x12f (0x195)
// imports ... 8   (offset: 0x25d)
// animtree1 . 0   (offset: 0x35d)
// animtree2 . 0   (offset: 0x35d)
#using scripts\mp\common\utility\trigger;

#namespace mp_sat_karma_audio;

// Namespace mp_sat_karma_audio
// Params 0
// Checksum 0x79e8f2eb, Offset: 0x84
// Size: 0x9
function main()
{
    thread function_1e4154c5662214da();
}

// Namespace mp_sat_karma_audio
// Params 0
// Checksum 0x6f20232c, Offset: 0x95
// Size: 0x52
function function_1e4154c5662214da()
{
    level endon( #"game_ended" );
    level waittill( #"matchstarttimer_done" );
    trig = getent( "audio_xray", #targetname );
    
    if ( isdefined( trig ) )
    {
        thread trigger::makeenterexittrigger( trig, &function_a4e1962f04160a8e, &function_c639b7d56167d118 );
    }
}

// Namespace mp_sat_karma_audio
// Params 2
// Checksum 0x90d1eba8, Offset: 0xef
// Size: 0x4f
function function_a4e1962f04160a8e( enterent, trigger )
{
    if ( isplayer( enterent ) && isalive( enterent ) )
    {
        playsoundatpos( enterent.origin + ( 0, 0, 30 ), #"hash_e3947a92aeecde4a" );
    }
}

// Namespace mp_sat_karma_audio
// Params 2
// Checksum 0x62d198aa, Offset: 0x146
// Size: 0x4f
function function_c639b7d56167d118( exitent, trigger )
{
    if ( isplayer( exitent ) && isalive( exitent ) )
    {
        playsoundatpos( exitent.origin + ( 0, 0, 30 ), #"hash_159df5021a5e3f6a" );
    }
}

