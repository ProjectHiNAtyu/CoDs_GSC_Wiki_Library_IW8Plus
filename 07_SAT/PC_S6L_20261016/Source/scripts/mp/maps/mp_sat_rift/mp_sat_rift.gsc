// scripts\mp\maps\mp_sat_rift\mp_sat_rift.gsc  (hash_00c6f5bfa06e5ebd.gscc) (size: 979 Bytes / 0x3d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1688e6b6 (378070710)
// size ...... 979 (0x3d3)
// includes .. 5   (offset: 0x30f)
// strings ... 13  (offset: 0x337)
// dev strs .. 0   (offset: 0x3d3)
// exports ... 2   (offset: 0x20b)
// cseg ...... 0x123 + 0xe8 (0x20b)
// imports ... 6   (offset: 0x25b)
// animtree1 . 0   (offset: 0x3d3)
// animtree2 . 0   (offset: 0x3d3)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_rift\gen\mp_sat_rift_art;
#using scripts\mp\maps\mp_sat_rift\mp_sat_rift_fx;
#using scripts\mp\maps\mp_sat_rift\mp_sat_rift_lighting;

#namespace mp_sat_rift;

// Namespace mp_sat_rift
// Params 0
// Checksum 0xcc063c58, Offset: 0x141
// Size: 0xca
function main()
{
    mp_sat_rift_art::main();
    namespace_7d20de44a36d8119::main();
    namespace_f0315036765b1f47::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rift" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

