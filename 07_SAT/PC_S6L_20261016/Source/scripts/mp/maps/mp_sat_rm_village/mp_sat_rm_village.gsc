// scripts\mp\maps\mp_sat_rm_village\mp_sat_rm_village.gsc  (hash_3df72947b6b02061.gscc) (size: 985 Bytes / 0x3d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe18f7b4 (3189307316)
// size ...... 985 (0x3d9)
// includes .. 5   (offset: 0x315)
// strings ... 13  (offset: 0x33d)
// dev strs .. 0   (offset: 0x3d9)
// exports ... 2   (offset: 0x211)
// cseg ...... 0x129 + 0xe8 (0x211)
// imports ... 6   (offset: 0x261)
// animtree1 . 0   (offset: 0x3d9)
// animtree2 . 0   (offset: 0x3d9)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_rm_village\gen\mp_sat_rm_village_art;
#using scripts\mp\maps\mp_sat_rm_village\mp_sat_rm_village_fx;
#using scripts\mp\maps\mp_sat_rm_village\mp_sat_rm_village_lighting;

#namespace mp_sat_rm_village;

// Namespace mp_sat_rm_village
// Params 0
// Checksum 0x743d7032, Offset: 0x147
// Size: 0xca
function main()
{
    mp_sat_rm_village_art::main();
    mp_sat_rm_village_fx::main();
    mp_sat_rm_village_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_village" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

