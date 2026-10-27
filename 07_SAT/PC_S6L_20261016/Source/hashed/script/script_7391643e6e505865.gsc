// script_7391643e6e505865  (hash_7391643e6e505865.gscc) (size: 1508 Bytes / 0x5e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xac6e8899 (2892925081)
// size ...... 1508 (0x5e4)
// includes .. 8   (offset: 0x4f0)
// strings ... 15  (offset: 0x530)
// dev strs .. 0   (offset: 0x5e4)
// exports ... 3   (offset: 0x2fc)
// cseg ...... 0x148 + 0x1b4 (0x2fc)
// imports ... 13  (offset: 0x374)
// animtree1 . 0   (offset: 0x5e4)
// animtree2 . 0   (offset: 0x5e4)
#using script_34d07f02badd8094;
#using script_709f5f888cd7904d;
#using script_7719396d33864d24;
#using script_9e2d3bc456e9d9e;
#using scripts\common\active_env\moving_platforms;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\load;

#namespace mp_sat_rm_frenetic;

// Namespace mp_sat_rm_frenetic
// Params 0
// Checksum 0x56f719f3, Offset: 0x166
// Size: 0xdd
function main()
{
    namespace_b96d3ef14d200485::main();
    namespace_e08bd746742e9ade::main();
    namespace_ec44d0420ce53ca4::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    function_298bb4b0e9f9e647();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_frenetic" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread moving_platforms::moving_platforms_init();
    level thread namespace_9802b2422c258ec9::main();
}

// Namespace mp_sat_rm_frenetic
// Params 0, eflags: 0x4
// Checksum 0x9adcb811, Offset: 0x24b
// Size: 0xb1
function private function_298bb4b0e9f9e647()
{
    var_f0ea585a6d12887b = getentarray( "propHuntOOBs", #script_noteworthy );
    var_3ec3bb552a1449d0 = getxhash( game_utility::getgametype() );
    
    if ( var_3ec3bb552a1449d0 != #"prop" )
    {
        foreach ( trigger in var_f0ea585a6d12887b )
        {
            trigger delete();
        }
    }
}

