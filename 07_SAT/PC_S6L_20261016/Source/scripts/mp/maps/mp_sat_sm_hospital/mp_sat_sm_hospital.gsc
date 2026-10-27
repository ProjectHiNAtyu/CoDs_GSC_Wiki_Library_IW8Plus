// scripts\mp\maps\mp_sat_sm_hospital\mp_sat_sm_hospital.gsc  (hash_050571e66532792f.gscc) (size: 837 Bytes / 0x345 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x837d279e (2206017438)
// size ...... 837 (0x345)
// includes .. 6   (offset: 0x29d)
// strings ... 10  (offset: 0x2cd)
// dev strs .. 0   (offset: 0x345)
// exports ... 2   (offset: 0x189)
// cseg ...... 0xea + 0x9f (0x189)
// imports ... 7   (offset: 0x1d9)
// animtree1 . 0   (offset: 0x345)
// animtree2 . 0   (offset: 0x345)
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_sm_hospital\gen\mp_sat_sm_hospital_art;
#using scripts\mp\maps\mp_sat_sm_hospital\mp_sat_sm_hospital_fx;
#using scripts\mp\maps\mp_sat_sm_hospital\mp_sat_sm_hospital_lighting;

#namespace mp_sat_sm_hospital;

// Namespace mp_sat_sm_hospital
// Params 0
// Checksum 0x5f5012a8, Offset: 0x108
// Size: 0x81
function main()
{
    mp_sat_sm_hospital_art::main();
    namespace_b56b9691f77c97f3::main();
    mp_sat_sm_hospital_lighting::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_sm_hospital" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread animation_suite::animationsuite();
}

