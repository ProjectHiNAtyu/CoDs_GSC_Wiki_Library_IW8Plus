// script_29d14bdf8a668403  (hash_29d14bdf8a668403.gscc) (size: 986 Bytes / 0x3da / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa4fd2344 (2768053060)
// size ...... 986 (0x3da)
// includes .. 5   (offset: 0x316)
// strings ... 13  (offset: 0x33e)
// dev strs .. 0   (offset: 0x3da)
// exports ... 2   (offset: 0x212)
// cseg ...... 0x12a + 0xe8 (0x212)
// imports ... 6   (offset: 0x262)
// animtree1 . 0   (offset: 0x3da)
// animtree2 . 0   (offset: 0x3da)
#using script_14dca758522a5ef6;
#using script_3bbcae026fe2dcce;
#using script_508e085b822a3230;
#using scripts\mp\compass;
#using scripts\mp\load;

#namespace mp_sat_rm_socotra2;

// Namespace mp_sat_rm_socotra2
// Params 0
// Checksum 0xde54a122, Offset: 0x148
// Size: 0xca
function main()
{
    namespace_faa591f5af68091e::main();
    namespace_b4936fedcb3c7eff::main();
    namespace_9adcf82af28773a5::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_socotra2" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

