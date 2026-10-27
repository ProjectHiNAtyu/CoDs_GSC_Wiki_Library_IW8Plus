// scripts\mp\maps\mp_saw_sierra\mp_saw_sierra.gsc  (hash_6e4b9fc8c0793719.gscc) (size: 2470 Bytes / 0x9a6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe591bf8 (240720888)
// size ...... 2470 (0x9a6)
// includes .. 8   (offset: 0x876)
// strings ... 14  (offset: 0x8b6)
// dev strs .. 0   (offset: 0x9a6)
// exports ... 3   (offset: 0x686)
// cseg ...... 0x169 + 0x51d (0x686)
// imports ... 13  (offset: 0x6fe)
// animtree1 . 0   (offset: 0x9a6)
// animtree2 . 0   (offset: 0x9a6)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_staged_items;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_saw_sierra\mp_saw_sierra_br;
#using scripts\mp\poi;
#using scripts\mp\stationary_notes;

#namespace mp_saw_sierra;

// Namespace mp_saw_sierra
// Params 1
// Checksum 0xc4dd3f35, Offset: 0x187
// Size: 0xfc
function main( compassmaterial = "compass_map_mp_saw_sierra" )
{
    load::main();
    thread function_eab0c90a4f66defd();
    compass::setupminimap( compassmaterial, undefined, 16 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread poi::poi_init();
    
    if ( !isdefined( level.outofboundstriggers ) )
    {
        level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    }
    
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggersplanetrace = getentarray( "OutOfBounds", #targetname );
    game_utility::registerlargemap();
    
    if ( isbrgamemode() )
    {
        mp_saw_sierra_br::init();
    }
    
    utility::flag_wait( "scriptables_ready" );
    level thread br_staged_items::init();
    level thread stationary_notes::snote_init();
}

// Namespace mp_saw_sierra
// Params 0, eflags: 0x4
// Checksum 0x6a4d0ca4, Offset: 0x28b
// Size: 0x3fb
function private function_eab0c90a4f66defd()
{
    modeldefs = [ [ ( 30761.3, 4004.97, -936 ), ( 0, 225, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 29635.4, 4813.7, -933.75 ), ( 0, 225, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 29635.4, 4813.7, -933.75 ), ( 0, 225, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 30693.4, 4187.05, -936 ), ( 0, 135, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 30729, 4042.62, -863 ), ( 0, 45, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 30811.3, 4125, -863 ), ( 0, 45, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 30943.2, 4074.44, -936 ), ( 0, 135, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 30982.8, 3180.99, -936 ), ( 0, 47, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 30876, 4257.94, -936 ), ( 0, 225, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 31050.3, 3248.52, -936 ), ( 0, 47, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 31171.3, 3014.5, -857.75 ), ( 0, 45, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 30621, 4456.46, -936 ), ( 0, 225, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 30689.5, 4525.05, -936 ), ( 0, 225, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 31169.3, 3003.33, -936 ), ( 0, 45, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 31238.4, 3072.45, -936 ), ( 0, 45, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 30973.6, 4296.12, -936 ), ( 0, 225, 0 ), "blocker_storage_shipping_container_20ft_closed" ], [ ( 29780.4, 4726, -929.75 ), ( 0, 315, 0 ), "blocker_mout_barrier_concrete_96_d" ], [ ( 30986.2, 3104, -929.75 ), ( 0, 315, 0 ), "blocker_mout_barrier_concrete_96_d" ] ];
    utility::flag_wait( "scriptables_ready" );
    
    foreach ( modeldef in modeldefs )
    {
        model = spawnscriptable( modeldef[ 2 ], modeldef[ 0 ], modeldef[ 1 ] );
    }
}

