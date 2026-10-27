// scripts\mp\maps\mp_sat_co_rm_veiled\mp_sat_co_rm_veiled.gsc  (hash_3106477e05a27e11.gscc) (size: 987 Bytes / 0x3db / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5cdd3090 (1557999760)
// size ...... 987 (0x3db)
// includes .. 5   (offset: 0x317)
// strings ... 13  (offset: 0x33f)
// dev strs .. 0   (offset: 0x3db)
// exports ... 2   (offset: 0x213)
// cseg ...... 0x12b + 0xe8 (0x213)
// imports ... 6   (offset: 0x263)
// animtree1 . 0   (offset: 0x3db)
// animtree2 . 0   (offset: 0x3db)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_co_rm_veiled\gen\mp_sat_co_rm_veiled_art;
#using scripts\mp\maps\mp_sat_co_rm_veiled\mp_sat_co_rm_veiled_fx;
#using scripts\mp\maps\mp_sat_co_rm_veiled\mp_sat_co_rm_veiled_lighting;

#namespace mp_sat_co_rm_veiled;

// Namespace mp_sat_co_rm_veiled
// Params 0
// Checksum 0xc9e176f2, Offset: 0x149
// Size: 0xca
function main()
{
    namespace_9b21a6d068083221::main();
    mp_sat_co_rm_veiled_fx::main();
    namespace_cecc7894beb44ae8::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_co_rm_veiled" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

