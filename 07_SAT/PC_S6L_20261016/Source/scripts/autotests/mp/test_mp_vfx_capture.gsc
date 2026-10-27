// scripts\autotests\mp\test_mp_vfx_capture.gsc  (hash_63bd613ea1d02b87.gscc) (size: 1370 Bytes / 0x55a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfdf76bde (4260850654)
// size ...... 1370 (0x55a)
// includes .. 4   (offset: 0x4e6)
// strings ... 6   (offset: 0x506)
// dev strs .. 0   (offset: 0x55a)
// exports ... 4   (offset: 0x27e)
// cseg ...... 0x116 + 0x168 (0x27e)
// imports ... 16  (offset: 0x31e)
// animtree1 . 0   (offset: 0x55a)
// animtree2 . 0   (offset: 0x55a)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_player;
#using scripts\mp\gamelogic;

#namespace test_mp_vfx_capture;

// Namespace test_mp_vfx_capture/testautomation
// Params 0, eflags: 0x20
// Checksum 0x7a6961f9, Offset: 0x134
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_vfx_capture.gsc", #"test", &start_test, &setup );
}

// Namespace test_mp_vfx_capture
// Params 0
// Checksum 0x7056125c, Offset: 0x15d
// Size: 0xbb, Type: bool
function setup()
{
    autotests::set_dvar( @"cg_drawautotestresultpanel", 0 );
    autotests_utility::function_8ea000c274f2063e();
    autotests::function_5c8c87763724c132();
    player = autotests_utility_player::get_player();
    level.autotests.test_runtime.player = player;
    player function_ffb0711adb6d8d0d();
    desired_players = getdvarint( @"scr_test_mp_selfplay_num_players", getmaxclients() );
    
    if ( desired_players != -1 )
    {
        bots_to_spawn = desired_players - level.players.size;
        setdvar( @"dev_spawnbots", bots_to_spawn );
        autotests::report_info( "Spawning Max Bots (set dev_spawnBots " + bots_to_spawn + ")" );
    }
    
    return true;
}

// Namespace test_mp_vfx_capture
// Params 0
// Checksum 0x24e1bc31, Offset: 0x221
// Size: 0x5c, Type: bool
function start_test()
{
    wait 60;
    autotests::function_d84657f448aaeef6( "Turning ON particle_profile_trace", 1, "scripts/autotests/mp/test_mp_vfx_capture.gsc", 40 );
    setomnvarforallclients( "particle_profiler", 1 );
    wait 30;
    setomnvarforallclients( "particle_profiler", 0 );
    autotests::function_d84657f448aaeef6( "Turning OFF particle_profile_trace", 1, "scripts/autotests/mp/test_mp_vfx_capture.gsc", 46 );
    wait 5;
    level thread gamelogic_mp::forceend();
    autotests_utility::function_4cd42a15157be748();
    return false;
}

