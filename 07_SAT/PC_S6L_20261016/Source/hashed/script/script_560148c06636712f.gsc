// script_560148c06636712f  (hash_560148c06636712f.gscc) (size: 1065 Bytes / 0x429 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74433ae1 (1950563041)
// size ...... 1065 (0x429)
// includes .. 3   (offset: 0x3d9)
// strings ... 4   (offset: 0x3f1)
// dev strs .. 0   (offset: 0x429)
// exports ... 6   (offset: 0x1d1)
// cseg ...... 0xa8 + 0x129 (0x1d1)
// imports ... 10  (offset: 0x2c1)
// animtree1 . 0   (offset: 0x429)
// animtree2 . 0   (offset: 0x429)
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\system;

#namespace zm_bgb_indiegestion;

// Namespace zm_bgb_indiegestion
// Params 0, eflags: 0x5
// Checksum 0xa8aa49cf, Offset: 0xc6
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "indiegestion", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_indiegestion
// Params 0
// Checksum 0x3fd89888, Offset: 0xeb
// Size: 0x32
function __init__()
{
    bgb::register( "indiegestion", "time", 180, &enable, &disable, undefined );
    level callback::add( "pre_killed_body_cloned", &on_ai_killed );
}

// Namespace zm_bgb_indiegestion
// Params 0
// Checksum 0xc8317b40, Offset: 0x125
// Size: 0x2
function enable()
{
    
}

// Namespace zm_bgb_indiegestion
// Params 0
// Checksum 0x74d4fe23, Offset: 0x12f
// Size: 0x2
function disable()
{
    
}

// Namespace zm_bgb_indiegestion
// Params 1, eflags: 0x4
// Checksum 0xa9816ff9, Offset: 0x139
// Size: 0x98
function private on_ai_killed( params )
{
    foreach ( player in level.players )
    {
        if ( player bgb::is_enabled( "indiegestion" ) )
        {
            self playsound( "evt_bgb_indiegestion_death" );
            return;
        }
    }
}

