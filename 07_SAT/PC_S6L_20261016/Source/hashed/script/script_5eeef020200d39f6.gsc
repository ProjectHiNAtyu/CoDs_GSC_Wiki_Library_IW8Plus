// script_5eeef020200d39f6  (hash_5eeef020200d39f6.gscc) (size: 3730 Bytes / 0xe92 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdf5a29e7 (3747228135)
// size ...... 3730 (0xe92)
// includes .. 3   (offset: 0xc8a)
// strings ... 1   (offset: 0xca2)
// dev strs .. 23  (offset: 0xcae)
// exports ... 22  (offset: 0x6fe)
// cseg ...... 0x6d + 0x691 (0x6fe)
// imports ... 13  (offset: 0xa6e)
// animtree1 . 0   (offset: 0xe92)
// animtree2 . 0   (offset: 0xe92)
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_fog_setup;

// Namespace zm_sat_locust_fog_setup
// Params 0, eflags: 0x5
// Checksum 0x71437932, Offset: 0x8b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_786febc7c504949b", undefined, undefined, &init );
}

// Namespace zm_sat_locust_fog_setup
// Params 0
// Checksum 0x16228a53, Offset: 0xac
// Size: 0x1a
function init()
{
    level utility::flag_wait( "scriptables_ready" );
    
    /#
        level thread init_mq_debug();
    #/
}

/#

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x141e632a, Offset: 0xce
    // Size: 0x5a, Type: dev
    function init_mq_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x2f>", "<dev string:x47>", &function_b481ef5ef65096da );
        devgui::add_devgui_func( "<dev string:x53>", "<dev string:x6a>", &function_5f89143bd586e355 );
        devgui::add_devgui_func( "<dev string:x75>", "<dev string:x8c>", &function_223745c59b31e661 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0xdf180582, Offset: 0x130
    // Size: 0x5c, Type: dev
    function function_b481ef5ef65096da()
    {
        fog_spawn = utility::getstruct( "<dev string:x97>" );
        level.fog_1 = spawnscriptable( "<dev string:x9f>", fog_spawn.origin, fog_spawn.angles );
        level.fog_1 setscriptablepartstate( "<dev string:xab>", "<dev string:xb1>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x4c8621c6, Offset: 0x194
    // Size: 0x1d, Type: dev
    function function_5f89143bd586e355()
    {
        level.fog_1 setscriptablepartstate( "<dev string:xab>", "<dev string:xb6>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0xa78cd188, Offset: 0x1b9
    // Size: 0x1d, Type: dev
    function function_223745c59b31e661()
    {
        level.fog_1 setscriptablepartstate( "<dev string:xab>", "<dev string:xbb>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x2b7725c3, Offset: 0x1de
    // Size: 0x77, Type: dev
    function function_a2cae7826148e9d7()
    {
        fog_spawn = utility::getstruct( "<dev string:xbf>" );
        level.fog_2 = spawnscriptable( "<dev string:x9f>", fog_spawn.origin, fog_spawn.angles );
        level.fog_2 setscriptablepartstate( "<dev string:xc7>", "<dev string:xb1>" );
        wait 60;
        level.fog_2 setscriptablepartstate( "<dev string:xc7>", "<dev string:xb6>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x4b9ca94a, Offset: 0x25d
    // Size: 0x5c, Type: dev
    function function_18b811753de8dbd6()
    {
        fog_spawn = utility::getstruct( "<dev string:xbf>" );
        level.fog_2 = spawnscriptable( "<dev string:x9f>", fog_spawn.origin, fog_spawn.angles );
        level.fog_2 setscriptablepartstate( "<dev string:xc7>", "<dev string:xb6>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0xb811f29c, Offset: 0x2c1
    // Size: 0x1d, Type: dev
    function function_203d0d5f93991e9e()
    {
        level.fog_2 setscriptablepartstate( "<dev string:xc7>", "<dev string:xbb>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0xfa071ee1, Offset: 0x2e6
    // Size: 0x77, Type: dev
    function function_fa3c06e56704feac()
    {
        fog_spawn = utility::getstruct( "<dev string:xcd>" );
        level.fog_3 = spawnscriptable( "<dev string:x9f>", fog_spawn.origin, fog_spawn.angles );
        level.fog_3 setscriptablepartstate( "<dev string:xd5>", "<dev string:xb1>" );
        wait 60;
        level.fog_3 setscriptablepartstate( "<dev string:xd5>", "<dev string:xb6>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x80c07aef, Offset: 0x365
    // Size: 0x5c, Type: dev
    function function_a0a36ef95abc14ff()
    {
        fog_spawn = utility::getstruct( "<dev string:xcd>" );
        level.fog_3 = spawnscriptable( "<dev string:x9f>", fog_spawn.origin, fog_spawn.angles );
        level.fog_3 setscriptablepartstate( "<dev string:xd5>", "<dev string:xb6>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x44a11af, Offset: 0x3c9
    // Size: 0x1d, Type: dev
    function function_f9969367981145f7()
    {
        level.fog_3 setscriptablepartstate( "<dev string:xd5>", "<dev string:xbb>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0xa1c4b5cc, Offset: 0x3ee
    // Size: 0x77, Type: dev
    function function_21e5212b1e0f3bc1()
    {
        fog_spawn = utility::getstruct( "<dev string:xdb>" );
        level.fog_4 = spawnscriptable( "<dev string:x9f>", fog_spawn.origin, fog_spawn.angles );
        level.fog_4 setscriptablepartstate( "<dev string:xe3>", "<dev string:xb1>" );
        wait 60;
        level.fog_4 setscriptablepartstate( "<dev string:xe3>", "<dev string:xb6>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x9dc54a57, Offset: 0x46d
    // Size: 0x5c, Type: dev
    function function_8d46b8cce7286088()
    {
        fog_spawn = utility::getstruct( "<dev string:xdb>" );
        level.fog_4 = spawnscriptable( "<dev string:x9f>", fog_spawn.origin, fog_spawn.angles );
        level.fog_4 setscriptablepartstate( "<dev string:xe3>", "<dev string:xb6>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x872bb4b4, Offset: 0x4d1
    // Size: 0x1d, Type: dev
    function function_a54fe856310127dc()
    {
        level.fog_4 setscriptablepartstate( "<dev string:xe3>", "<dev string:xbb>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x70b48eee, Offset: 0x4f6
    // Size: 0x77, Type: dev
    function function_ef32a6241f9df6e6()
    {
        fog_spawn = utility::getstruct( "<dev string:xe9>" );
        level.fog_5 = spawnscriptable( "<dev string:x9f>", fog_spawn.origin, fog_spawn.angles );
        level.fog_5 setscriptablepartstate( "<dev string:xf1>", "<dev string:xb1>" );
        wait 60;
        level.fog_5 setscriptablepartstate( "<dev string:xf1>", "<dev string:xb6>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x569999f2, Offset: 0x575
    // Size: 0x5c, Type: dev
    function function_ce5dbe905c05c751()
    {
        fog_spawn = utility::getstruct( "<dev string:xe9>" );
        level.fog_5 = spawnscriptable( "<dev string:x9f>", fog_spawn.origin, fog_spawn.angles );
        level.fog_5 setscriptablepartstate( "<dev string:xf1>", "<dev string:xb6>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x3b705787, Offset: 0x5d9
    // Size: 0x1d, Type: dev
    function function_e4c70ea6d660a6ad()
    {
        level.fog_5 setscriptablepartstate( "<dev string:xf1>", "<dev string:xbb>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0xd855c5c9, Offset: 0x5fe
    // Size: 0x77, Type: dev
    function function_9acefc27facfd9e3()
    {
        fog_spawn = utility::getstruct( "<dev string:xf7>" );
        level.fog_6 = spawnscriptable( "<dev string:x9f>", fog_spawn.origin, fog_spawn.angles );
        level.fog_6 setscriptablepartstate( "<dev string:xff>", "<dev string:xb1>" );
        wait 60;
        level.fog_6 setscriptablepartstate( "<dev string:xff>", "<dev string:xb6>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0xd00deb5c, Offset: 0x67d
    // Size: 0x5c, Type: dev
    function function_3317ffd9dbf47192()
    {
        fog_spawn = utility::getstruct( "<dev string:xf7>" );
        level.fog_6 = spawnscriptable( "<dev string:x9f>", fog_spawn.origin, fog_spawn.angles );
        level.fog_6 setscriptablepartstate( "<dev string:xff>", "<dev string:xb6>" );
    }

    // Namespace zm_sat_locust_fog_setup
    // Params 0
    // Checksum 0x24ed7493, Offset: 0x6e1
    // Size: 0x1d, Type: dev
    function function_7f005bc5db1c730a()
    {
        level.fog_6 setscriptablepartstate( "<dev string:xff>", "<dev string:xbb>" );
    }

#/
