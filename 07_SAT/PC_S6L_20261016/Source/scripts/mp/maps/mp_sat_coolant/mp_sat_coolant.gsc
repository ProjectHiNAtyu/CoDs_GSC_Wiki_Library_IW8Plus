// scripts\mp\maps\mp_sat_coolant\mp_sat_coolant.gsc  (hash_0a40b4d831713345.gscc) (size: 1047 Bytes / 0x417 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x61cbdc5d (1640750173)
// size ...... 1047 (0x417)
// includes .. 6   (offset: 0x33f)
// strings ... 14  (offset: 0x36f)
// dev strs .. 0   (offset: 0x417)
// exports ... 2   (offset: 0x21f)
// cseg ...... 0x134 + 0xeb (0x21f)
// imports ... 7   (offset: 0x26f)
// animtree1 . 0   (offset: 0x417)
// animtree2 . 0   (offset: 0x417)
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_coolant\gen\mp_sat_coolant_art;
#using scripts\mp\maps\mp_sat_coolant\mp_sat_coolant_fx;
#using scripts\mp\maps\mp_sat_coolant\mp_sat_coolant_lighting;

#namespace mp_sat_coolant;

// Namespace mp_sat_coolant
// Params 0
// Checksum 0xe87a88f6, Offset: 0x152
// Size: 0xcd
function main()
{
    mp_sat_coolant_art::main();
    namespace_1394358664c520d4::main();
    namespace_1996fb77d26a0262::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    compass::setupminimap( "compass_map_mp_sat_coolant" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    thread animation_suite::animationsuite();
}

