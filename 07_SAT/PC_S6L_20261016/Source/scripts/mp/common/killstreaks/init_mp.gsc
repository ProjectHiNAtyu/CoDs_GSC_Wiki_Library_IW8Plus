// scripts\mp\common\killstreaks\init_mp.gsc  (hash_1709f5071634a3de.gscc) (size: 3710 Bytes / 0xe7e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd5b471a5 (3585372581)
// size ...... 3710 (0xe7e)
// includes .. 36  (offset: 0xcee)
// strings ... 9   (offset: 0xe0e)
// dev strs .. 0   (offset: 0xe7e)
// exports ... 2   (offset: 0x642)
// cseg ...... 0xd1 + 0x571 (0x642)
// imports ... 52  (offset: 0x692)
// animtree1 . 0   (offset: 0xe7e)
// animtree2 . 0   (offset: 0xe7e)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\airdrop_escort_mp;
#using scripts\mp\common\killstreaks\airdrop_mp;
#using scripts\mp\common\killstreaks\airdrop_multiple_mp;
#using scripts\mp\common\killstreaks\airstrike_mp;
#using scripts\mp\common\killstreaks\chopper_support_mp;
#using scripts\mp\common\killstreaks\circle_peek;
#using scripts\mp\common\killstreaks\cluster_spike_mp;
#using scripts\mp\common\killstreaks\cruise_predator_mp;
#using scripts\mp\common\killstreaks\death_switch;
#using scripts\mp\common\killstreaks\deployablebox;
#using scripts\mp\common\killstreaks\emp_drone_mp;
#using scripts\mp\common\killstreaks\emp_drone_targeted_mp;
#using scripts\mp\common\killstreaks\helicopter;
#using scripts\mp\common\killstreaks\helper_drone_mp;
#using scripts\mp\common\killstreaks\hover_jet_mp;
#using scripts\mp\common\killstreaks\juggernaut_mp;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\manual_turret_mp;
#using scripts\mp\common\killstreaks\mapselect;
#using scripts\mp\common\killstreaks\nuke_mp;
#using scripts\mp\common\killstreaks\remote_turret_mp;
#using scripts\mp\common\killstreaks\remoteturret;
#using scripts\mp\common\killstreaks\sentry_gun_mp;
#using scripts\mp\common\killstreaks\target_marker;
#using scripts\mp\common\killstreaks\throwback_marker;
#using scripts\mp\common\killstreaks\toma_strike_mp;
#using scripts\mp\common\killstreaks\uav_bigmap_mp;
#using scripts\mp\common\killstreaks\uav_mp;
#using scripts\mp\common\killstreaks\white_phosphorus_mp;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\gametypes\jugg_mosh;
#using scripts\mp\outofbounds;

#namespace init_mp;

// Namespace init_mp
// Params 0
// Checksum 0xfc935781, Offset: 0xef
// Size: 0x553
function init()
{
    level.killstreaktriggeredfunc = &killstreaks::streakglobals_onkillstreaktriggered;
    level.killstreakbeginusefunc = &killstreaks::streakglobals_onkillstreakbeginuse;
    callback::add( #"killstreak_finish_use", &killstreaks::streakglobals_onkillstreakfinishuse );
    killstreaks::initkillstreakdata();
    
    if ( !isdefined( level.killstreaksetups ) )
    {
        level.killstreaksetups = [];
    }
    
    thread target_marker::init();
    thread mapselect::init();
    thread throwback_marker::init();
    thread helicopter::init();
    
    if ( getdvarint( @"hash_41e841cf6efad236", 0 ) || getdvar( @"ui_gametype", "" ) == "conf_jugg" )
    {
        thread jugg_mosh::init();
    }
    
    thread deployablebox::init();
    thread remoteturret::init();
    thread death_switch::init();
    thread circle_peek::init();
    utility::registersharedfunc( #"cruise_predator", #"init", &cruise_predator_mp::init );
    utility::registersharedfunc( #"sentry_gun", #"init", &sentry_gun_mp::init );
    utility::registersharedfunc( #"airstrike", #"init", &airstrike_mp::init );
    utility::registersharedfunc( #"juggernaut", #"init", &juggernaut_mp::init );
    utility::registersharedfunc( #"airdrop", #"init", &airdrop_mp::init );
    utility::registersharedfunc( #"airdrop_multiple", #"init", &airdrop_multiple_mp::airdrop_multiple_init );
    utility::registersharedfunc( #"airdrop_escort", #"init", &airdrop_escort_mp::airdrop_escort_init );
    utility::registersharedfunc( #"white_phosphorus", #"init", &white_phosphorus_mp::init );
    utility::registersharedfunc( #"manual_turret", #"init", &manual_turret_mp::init );
    utility::registersharedfunc( #"toma_strike", #"init", &toma_strike_mp::init );
    utility::registersharedfunc( #"hash_377e0ed7e4fc0a98", #"init", &chopper_support_mp::init );
    utility::registersharedfunc( #"uav", #"init", &uav_mp::init_uav_mp );
    utility::registersharedfunc( #"uav_bigmap", #"init", &uav_bigmap_mp::init );
    utility::registersharedfunc( #"emp_drone", #"init", &emp_drone_mp::init );
    utility::registersharedfunc( #"emp_drone_targeted", #"init", &emp_drone_targeted_mp::init );
    utility::registersharedfunc( #"helper_drone", #"init", &helper_drone_mp::helper_drone_init );
    utility::registersharedfunc( #"nuke", #"init", &nuke_mp::init );
    utility::registersharedfunc( #"hover_jet", #"init", &hover_jet_mp::init );
    utility::registersharedfunc( #"cluster_spike", #"init", &cluster_spike_mp::init );
    utility::registersharedfunc( #"remote_turret", #"init", &remote_turret_mp::init );
    weapon::initkillstreakweaponmap();
    
    if ( isdefined( level.mapcustomkillstreakfunc ) )
    {
        [[ level.mapcustomkillstreakfunc ]]();
    }
    
    level.killstreakrounddelay = getmatchrulesdata( "commonOption", "killstreakDelay" );
    level.killstreakactivatedtime = [];
    
    if ( game_utility_mp::function_57f7c589ea92d695() && getdvarint( @"hash_4d5bd224f3f2f0bf", 1 ) )
    {
        setdvar( @"hash_daa203ef7cfc6ee2", 1 );
        killstreak1 = getdvar( @"hash_328d09718871cea9", "none" );
        killstreak2 = getdvar( @"hash_328d06718871c810", "uav" );
        killstreak3 = getdvar( @"hash_328d07718871ca43", "directional_uav" );
        setdvar( hashcat( @"hash_7129c8b31055dff8", 1 ), killstreak1 );
        setdvar( hashcat( @"hash_7129c8b31055dff8", 2 ), killstreak2 );
        setdvar( hashcat( @"hash_7129c8b31055dff8", 3 ), killstreak3 );
    }
    
    if ( game_utility_mp::ismutationgamemode() && getdvarint( @"hash_52510a23c3e3de3c", 1 ) )
    {
        setdvar( @"hash_daa203ef7cfc6ee2", 1 );
        killstreak1 = getdvar( @"hash_a534c1c236717066", "cluster_spike" );
        killstreak2 = getdvar( @"hash_a534c0c236716e33", "airdrop_escort" );
        killstreak3 = getdvar( @"hash_a534bfc236716c00", "directional_uav" );
        setdvar( hashcat( @"hash_7129c8b31055dff8", 1 ), killstreak1 );
        setdvar( hashcat( @"hash_7129c8b31055dff8", 2 ), killstreak2 );
        setdvar( hashcat( @"hash_7129c8b31055dff8", 3 ), killstreak3 );
    }
    
    if ( !isdefined( level.var_9394f65c684e87fb ) )
    {
        level.var_9394f65c684e87fb = getdvarint( @"hash_daa203ef7cfc6ee2", 0 );
    }
    
    level thread killstreaks::onplayerconnect();
    level thread killstreaks::storescorestreakpointsongameend();
    outofbounds::killstreakregisteroobcallbacks();
    callback::add( #"player_spawned", &killstreaks::onplayerspawned );
    lui_game_event_aggregator::registeronluieventcallback( &killstreaks::listenkillstreakaction );
    lui_game_event_aggregator::registeronluieventcallback( &killstreaks::function_8b7328ae6e5f8f71 );
    level thread killstreaks::function_5ccf864a8230c0ce();
    
    /#
        setdevdvarifuninitialized( @"hash_2c01d701bac5d9d3", 0 );
        setdevdvarifuninitialized( @"hash_698613e6c8c52243", 0 );
    #/
}

