// scripts\mp\maps\mp_sat_rm_vertigo\mp_sat_rm_vertigo.gsc  (hash_73aad677e72f0091.gscc) (size: 1028 Bytes / 0x404 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x87421f50 (2269257552)
// size ...... 1028 (0x404)
// includes .. 6   (offset: 0x338)
// strings ... 13  (offset: 0x368)
// dev strs .. 0   (offset: 0x404)
// exports ... 2   (offset: 0x218)
// cseg ...... 0x129 + 0xef (0x218)
// imports ... 7   (offset: 0x268)
// animtree1 . 0   (offset: 0x404)
// animtree2 . 0   (offset: 0x404)
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_rm_vertigo\gen\mp_sat_rm_vertigo_art;
#using scripts\mp\maps\mp_sat_rm_vertigo\mp_sat_rm_vertigo_fx;
#using scripts\mp\maps\mp_sat_rm_vertigo\mp_sat_rm_vertigo_lighting;

#namespace mp_sat_rm_vertigo;

// Namespace mp_sat_rm_vertigo
// Params 0
// Checksum 0x991a51b9, Offset: 0x147
// Size: 0xd1
function main()
{
    mp_sat_rm_vertigo_art::main();
    mp_sat_rm_vertigo_fx::main();
    mp_sat_rm_vertigo_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_vertigo" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    thread animation_suite::animationsuite();
}

