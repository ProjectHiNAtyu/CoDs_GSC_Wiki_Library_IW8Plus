// scripts\mp\maps\mp_sat_sur_lighthouse\mp_sat_sur_lighthouse.gsc  (hash_5d14f2be99a342b1.gscc) (size: 818 Bytes / 0x332 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x78f5603d (2029346877)
// size ...... 818 (0x332)
// includes .. 5   (offset: 0x286)
// strings ... 11  (offset: 0x2ae)
// dev strs .. 0   (offset: 0x332)
// exports ... 2   (offset: 0x18e)
// cseg ...... 0xfb + 0x93 (0x18e)
// imports ... 6   (offset: 0x1de)
// animtree1 . 0   (offset: 0x332)
// animtree2 . 0   (offset: 0x332)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_sur_lighthouse\gen\mp_sat_sur_lighthouse_art;
#using scripts\mp\maps\mp_sat_sur_lighthouse\mp_sat_sur_lighthouse_fx;
#using scripts\mp\maps\mp_sat_sur_lighthouse\mp_sat_sur_lighthouse_lighting;

#namespace mp_sat_sur_lighthouse;

// Namespace mp_sat_sur_lighthouse
// Params 0
// Checksum 0x19935ccd, Offset: 0x119
// Size: 0x75
function main()
{
    mp_sat_sur_lighthouse_art::main();
    mp_sat_sur_lighthouse_fx::main();
    mp_sat_sur_lighthouse_lighting::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_sur_lighthouse" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

