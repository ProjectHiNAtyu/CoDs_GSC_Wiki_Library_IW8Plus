// scripts\mp\maps\mp_sat_co_sm_flat\mp_sat_co_sm_flat.gsc  (hash_0344f34d72939729.gscc) (size: 880 Bytes / 0x370 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbabfc676 (3133130358)
// size ...... 880 (0x370)
// includes .. 5   (offset: 0x2b8)
// strings ... 12  (offset: 0x2e0)
// dev strs .. 0   (offset: 0x370)
// exports ... 2   (offset: 0x1bc)
// cseg ...... 0x10e + 0xae (0x1bc)
// imports ... 6   (offset: 0x20c)
// animtree1 . 0   (offset: 0x370)
// animtree2 . 0   (offset: 0x370)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_co_sm_flat\gen\mp_sat_co_sm_flat_art;
#using scripts\mp\maps\mp_sat_co_sm_flat\mp_sat_co_sm_flat_fx;
#using scripts\mp\maps\mp_sat_co_sm_flat\mp_sat_co_sm_flat_lighting;

#namespace mp_sat_co_sm_flat;

// Namespace mp_sat_co_sm_flat
// Params 0
// Checksum 0x39f5ff8d, Offset: 0x12c
// Size: 0x90
function main()
{
    namespace_ef32bca3b17c5b4::main();
    namespace_790af16636933b09::main();
    namespace_6a8c18b10db3ceb7::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_co_sm_flat" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

