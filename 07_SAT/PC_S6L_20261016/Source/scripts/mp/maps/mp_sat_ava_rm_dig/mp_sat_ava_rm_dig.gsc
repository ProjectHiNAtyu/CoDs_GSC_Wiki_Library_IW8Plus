// scripts\mp\maps\mp_sat_ava_rm_dig\mp_sat_ava_rm_dig.gsc  (hash_011d9236cc5e2d6d.gscc) (size: 1007 Bytes / 0x3ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe00c04b3 (3758884019)
// size ...... 1007 (0x3ef)
// includes .. 5   (offset: 0x31f)
// strings ... 14  (offset: 0x347)
// dev strs .. 0   (offset: 0x3ef)
// exports ... 2   (offset: 0x21b)
// cseg ...... 0x137 + 0xe4 (0x21b)
// imports ... 6   (offset: 0x26b)
// animtree1 . 0   (offset: 0x3ef)
// animtree2 . 0   (offset: 0x3ef)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_ava_rm_dig\gen\mp_sat_ava_rm_dig_art;
#using scripts\mp\maps\mp_sat_ava_rm_dig\mp_sat_ava_rm_dig_fx;
#using scripts\mp\maps\mp_sat_ava_rm_dig\mp_sat_ava_rm_dig_lighting;

#namespace mp_sat_ava_rm_dig;

// Namespace mp_sat_ava_rm_dig
// Params 0
// Checksum 0x625ab9f3, Offset: 0x155
// Size: 0xc6
function main()
{
    namespace_c877dd7916b940a::main();
    namespace_b8dbd24d3a6fa9b3::main();
    namespace_7cca39cf72293469::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    compass::setupminimap( "compass_map_mp_sat_ava_rm_dig" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

