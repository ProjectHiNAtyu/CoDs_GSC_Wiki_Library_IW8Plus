// scripts\autotests\mp\test_mp_grenade_mayhem.gsc  (hash_6d02fd9c15bb48b6.gscc) (size: 1960 Bytes / 0x7a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbb8eec51 (3146706001)
// size ...... 1960 (0x7a8)
// includes .. 5   (offset: 0x720)
// strings ... 8   (offset: 0x748)
// dev strs .. 0   (offset: 0x7a8)
// exports ... 6   (offset: 0x3a8)
// cseg ...... 0x116 + 0x292 (0x3a8)
// imports ... 23  (offset: 0x498)
// animtree1 . 0   (offset: 0x7a8)
// animtree2 . 0   (offset: 0x7a8)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\utility;

#namespace test_mp_grenade_mayhem;

// Namespace test_mp_grenade_mayhem/testautomation
// Params 0, eflags: 0x20
// Checksum 0xfdb2d3fc, Offset: 0x134
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_grenade_mayhem.gsc", #"test", &start_test, &setup );
}

// Namespace test_mp_grenade_mayhem
// Params 0
// Checksum 0xf2e65d35, Offset: 0x15d
// Size: 0x12, Type: bool
function setup()
{
    autotests_utility::function_8ea000c274f2063e();
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace test_mp_grenade_mayhem
// Params 0
// Checksum 0x36782049, Offset: 0x178
// Size: 0xf1, Type: bool
function start_test()
{
    desired_players = getdvarint( @"scr_test_mp_selfplay_num_players", getmaxclients() );
    bots_to_spawn = desired_players - level.players.size;
    setdvar( @"dev_spawnbots", bots_to_spawn );
    autotests::report_info( "Spawning Max Bots (set dev_spawnBots " + bots_to_spawn + ")" );
    var_565caf5149264872 = utility::callsharedfunc( #"game_utility", #"hash_c7bd2494f8cf6f3c" );
    
    if ( !var_565caf5149264872 )
    {
        player = autotests_utility_player::get_player();
        player function_ffb0711adb6d8d0d();
    }
    
    if ( self.parameters.size > 0 )
    {
        position = autotests_utility::stringtovec3( self.parameters[ 0 ], player.origin );
        player setorigin( position );
    }
    
    setup_grenade_mayhem( player.origin );
    autotests_utility::function_4cd42a15157be748();
    return false;
}

// Namespace test_mp_grenade_mayhem
// Params 1
// Checksum 0xbcfc92a9, Offset: 0x272
// Size: 0xd5
function setup_grenade_mayhem( location )
{
    wait 5;
    autotests::set_dvar( @"hash_32322b10d68941aa", 1 );
    autotests::set_dvar( @"player_sustainammo", 1 );
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"equipment", #"hash_54e1244070e4625c", "equip_frag", "primary" );
        player thread bot_set_goal( location, 500 );
    }
}

// Namespace test_mp_grenade_mayhem
// Params 2, eflags: 0x4
// Checksum 0xfaf4304e, Offset: 0x34f
// Size: 0x59
function private bot_set_goal( goal_pos, radius )
{
    self botclearscriptgoal();
    waitframe();
    reachable_pos = self getclosestreachablepointonnavmesh( goal_pos );
    optional_params[ "override_goal_type" ] = "objective";
    optional_params[ "dont_leave_goal_during_combat" ] = 1;
    bots_scripted_defense::patrol_area( reachable_pos, radius, optional_params );
}

