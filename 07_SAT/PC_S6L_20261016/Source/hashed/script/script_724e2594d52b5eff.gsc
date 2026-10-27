// script_724e2594d52b5eff  (hash_724e2594d52b5eff.gscc) (size: 923 Bytes / 0x39b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9d71cc (261976524)
// size ...... 923 (0x39b)
// includes .. 3   (offset: 0x343)
// strings ... 5   (offset: 0x35b)
// dev strs .. 0   (offset: 0x39b)
// exports ... 4   (offset: 0x1fb)
// cseg ...... 0xdf + 0x11c (0x1fb)
// imports ... 6   (offset: 0x29b)
// animtree1 . 0   (offset: 0x39b)
// animtree2 . 0   (offset: 0x39b)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\hud_message;

#namespace namespace_303ec23c8e402127;

// Namespace namespace_303ec23c8e402127
// Params 0, eflags: 0x5
// Checksum 0x352a7c7a, Offset: 0xfd
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_aa3afeaad9e4cb46", undefined, undefined, &post_main );
}

// Namespace namespace_303ec23c8e402127
// Params 0, eflags: 0x4
// Checksum 0x929302d7, Offset: 0x11e
// Size: 0x9
function private post_main()
{
    thread function_c94db9ee9c3a3060();
}

// Namespace namespace_303ec23c8e402127
// Params 0, eflags: 0x4
// Checksum 0xcf9079b3, Offset: 0x12f
// Size: 0xcc
function private function_c94db9ee9c3a3060()
{
    while ( true )
    {
        ret = level utility::waittill_any_return_params( "ConnectionPuzzleCompleted", "ConnectionPuzzleFailed" );
        splash_ref = "sat_ob_connection_puzzle_fail";
        
        if ( ret[ "message" ] == "ConnectionPuzzleCompleted" )
        {
            splash_ref = "sat_ob_connection_puzzle_success";
        }
        
        foreach ( player in ret[ 0 ].players )
        {
            player thread hud_message::showsplash( splash_ref, undefined, player );
        }
    }
}

