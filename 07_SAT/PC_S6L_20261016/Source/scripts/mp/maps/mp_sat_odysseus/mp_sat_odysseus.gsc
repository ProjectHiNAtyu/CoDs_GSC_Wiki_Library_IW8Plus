// scripts\mp\maps\mp_sat_odysseus\mp_sat_odysseus.gsc  (hash_676ed7757900937d.gscc) (size: 920 Bytes / 0x398 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5fb5cf2 (100359410)
// size ...... 920 (0x398)
// includes .. 5   (offset: 0x2e0)
// strings ... 12  (offset: 0x308)
// dev strs .. 0   (offset: 0x398)
// exports ... 2   (offset: 0x1e0)
// cseg ...... 0x113 + 0xcd (0x1e0)
// imports ... 6   (offset: 0x230)
// animtree1 . 0   (offset: 0x398)
// animtree2 . 0   (offset: 0x398)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_odysseus\gen\mp_sat_odysseus_art;
#using scripts\mp\maps\mp_sat_odysseus\mp_sat_odysseus_fx;
#using scripts\mp\maps\mp_sat_odysseus\mp_sat_odysseus_lighting;

#namespace mp_sat_odysseus;

// Namespace mp_sat_odysseus
// Params 0
// Checksum 0x2d27435, Offset: 0x131
// Size: 0xaf
function main()
{
    mp_sat_odysseus_art::main();
    mp_sat_odysseus_fx::main();
    mp_sat_odysseus_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_odysseus" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

