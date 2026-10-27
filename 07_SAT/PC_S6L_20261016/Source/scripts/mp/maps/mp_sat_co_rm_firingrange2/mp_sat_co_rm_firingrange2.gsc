// scripts\mp\maps\mp_sat_co_rm_firingrange2\mp_sat_co_rm_firingrange2.gsc  (hash_0a65d3b6c3b0c421.gscc) (size: 1004 Bytes / 0x3ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d2e2f27 (758001447)
// size ...... 1004 (0x3ec)
// includes .. 5   (offset: 0x328)
// strings ... 13  (offset: 0x350)
// dev strs .. 0   (offset: 0x3ec)
// exports ... 2   (offset: 0x224)
// cseg ...... 0x131 + 0xf3 (0x224)
// imports ... 6   (offset: 0x274)
// animtree1 . 0   (offset: 0x3ec)
// animtree2 . 0   (offset: 0x3ec)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_co_rm_firingrange2\gen\mp_sat_co_rm_firingrange2_art;
#using scripts\mp\maps\mp_sat_co_rm_firingrange2\mp_sat_co_rm_firingrange2_fx;
#using scripts\mp\maps\mp_sat_co_rm_firingrange2\mp_sat_co_rm_firingrange2_lighting;

#namespace mp_sat_co_rm_firingrange2;

// Namespace mp_sat_co_rm_firingrange2
// Params 0
// Checksum 0x4763a88, Offset: 0x14f
// Size: 0xd5
function main()
{
    namespace_711200f8371bd1ba::main();
    namespace_d66e207d07cfd823::main();
    namespace_42b16c82786ced59::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_co_rm_firingrange2" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level.var_904399428c749bf6 = 1;
}

