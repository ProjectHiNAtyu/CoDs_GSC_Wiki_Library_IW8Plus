// scripts\mp\common\killstreaks\init.gsc  (hash_6b25aecbffa69b68.gscc) (size: 2008 Bytes / 0x7d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd71cb17d (3608981885)
// size ...... 2008 (0x7d8)
// includes .. 23  (offset: 0x6c0)
// strings ... 8   (offset: 0x778)
// dev strs .. 0   (offset: 0x7d8)
// exports ... 4   (offset: 0x2e8)
// cseg ...... 0xe2 + 0x206 (0x2e8)
// imports ... 29  (offset: 0x388)
// animtree1 . 0   (offset: 0x7d8)
// animtree2 . 0   (offset: 0x7d8)
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\assault_drone;
#using scripts\mp\common\killstreaks\auto_drone;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\killstreaks\cluster_spike;
#using scripts\mp\common\killstreaks\cruise_predator;
#using scripts\mp\common\killstreaks\emp_drone;
#using scripts\mp\common\killstreaks\emp_drone_targeted;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\hover_jet;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\killstreaks\manual_turret;
#using scripts\mp\common\killstreaks\nuke;
#using scripts\mp\common\killstreaks\sentry_gun;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\killstreaks\uav_bigmap;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\utility\game_utility;

#namespace init;

// Namespace init
// Params 0
// Checksum 0x2d996efd, Offset: 0x100
// Size: 0x11b
function init()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) == 1 )
    {
        return;
    }
    
    if ( getdvarint( @"hash_742caa13b3c2e685", 0 ) == 1 )
    {
        return;
    }
    
    /#
        utility::issharedfuncdefined( #"killstreak", #"init", 1 );
    #/
    
    [[ utility::getsharedfunc( #"killstreak", #"init" ) ]]();
    function_a1338798aedc37e0();
    killstreak_shared::function_38dc8b5c461532cb();
    level thread function_98488fc133c50316();
    level thread airdrop::init();
    level thread airstrike::init();
    level thread juggernaut::init();
    level thread toma_strike::init();
    level thread uav::init();
    level thread helper_drone::init();
    level thread manual_turret::init();
    level thread emp_drone_targeted::init();
    level thread nuke::init();
    level thread emp_drone::init();
    level thread auto_drone::init();
    level thread cluster_spike::init();
    level thread assault_drone::init();
    level thread sentry_gun::init();
    level thread uav_bigmap::init();
    
    if ( !isbrgamemode() )
    {
        level thread hover_jet::init();
        level thread cruise_predator::init();
        level thread white_phosphorus::init();
        level thread chopper_support::init();
    }
}

// Namespace init
// Params 0
// Checksum 0xa5030f7d, Offset: 0x223
// Size: 0x57
function function_a1338798aedc37e0()
{
    leveldataforvehicle = vehicle_omnvar::clear_data( "killstreak", 1 );
    leveldataforvehicle.warningbits[ "missileLocking" ] = 2;
    leveldataforvehicle.warningbits[ "burningDown" ] = 1;
    leveldataforvehicle.warningbits[ "missileIncoming" ] = 4;
}

// Namespace init
// Params 0
// Checksum 0xdbe33537, Offset: 0x282
// Size: 0x66
function function_98488fc133c50316()
{
    if ( level.scripted_spawner_func && level.scripted_spawner_func.size > 0 )
    {
        utility::flag_wait( "strike_init_done" );
    }
    
    level.heli_structs_entrances = game_utility::getlocalestructarray( "ks_heli_entrance" );
    level.heli_structs_goals = game_utility::getlocalestructarray( "ks_heli_goal" );
    level.heli_structs_paths = game_utility::getlocalestructarray( "ks_heli_path" );
}

