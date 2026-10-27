// scripts\autotests\mp\test_mp_selfplay.gsc  (hash_5e082bf46ac5fe20.gscc) (size: 1433 Bytes / 0x599 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x711cb11f (1897705759)
// size ...... 1433 (0x599)
// includes .. 3   (offset: 0x531)
// strings ... 6   (offset: 0x549)
// dev strs .. 0   (offset: 0x599)
// exports ... 4   (offset: 0x2ad)
// cseg ...... 0x10e + 0x19f (0x2ad)
// imports ... 17  (offset: 0x34d)
// animtree1 . 0   (offset: 0x599)
// animtree2 . 0   (offset: 0x599)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_player;

#namespace test_mp_selfplay;

// Namespace test_mp_selfplay/testautomation
// Params 0, eflags: 0x20
// Checksum 0x6e3ae1fb, Offset: 0x12c
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_selfplay.gsc", #"test", &start_test, &setup );
}

// Namespace test_mp_selfplay
// Params 0
// Checksum 0x5137eeb7, Offset: 0x155
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

// Namespace test_mp_selfplay
// Params 0
// Checksum 0x4e963ad7, Offset: 0x219
// Size: 0x93
function start_test()
{
    player = level.autotests.test_runtime.player;
    starttime = gettime();
    
    while ( !isautopilot( player ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 5000 )
        {
            autotests::function_d84657f448aaeef6( "Player not autopiloted within 5 seconds!", 0, "scripts/autotests/mp/test_mp_selfplay.gsc", 37 );
            return;
        }
    }
    
    autotests_utility::function_4cd42a15157be748();
    autotests::function_d84657f448aaeef6( "Force fpstool flush", 1, "scripts/autotests/mp/test_mp_selfplay.gsc", 41 );
    setomnvarforallclients( "fpstool_force_finish", 1 );
    return 0;
}

