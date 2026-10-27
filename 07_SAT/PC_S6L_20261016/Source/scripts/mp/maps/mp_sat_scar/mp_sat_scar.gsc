// scripts\mp\maps\mp_sat_scar\mp_sat_scar.gsc  (hash_30aa0e425ac7ec31.gscc) (size: 1543 Bytes / 0x607 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1649bc41 (373931073)
// size ...... 1543 (0x607)
// includes .. 9   (offset: 0x4f3)
// strings ... 17  (offset: 0x53b)
// dev strs .. 0   (offset: 0x607)
// exports ... 4   (offset: 0x2f3)
// cseg ...... 0x16b + 0x188 (0x2f3)
// imports ... 12  (offset: 0x393)
// animtree1 . 0   (offset: 0x607)
// animtree2 . 0   (offset: 0x607)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\animation_suite;
#using scripts\mp\common\utility\game;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_scar\gen\mp_sat_scar_art;
#using scripts\mp\maps\mp_sat_scar\mp_sat_scar_fx;
#using scripts\mp\maps\mp_sat_scar\mp_sat_scar_lighting;

#namespace mp_sat_scar;

// Namespace mp_sat_scar
// Params 0
// Checksum 0xf90ee848, Offset: 0x189
// Size: 0xef
function main()
{
    mp_sat_scar_art::main();
    mp_sat_scar_fx::main();
    mp_sat_scar_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_scar" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    callback::add( #"player_spawn_init", &on_spawn_init );
    level thread animation_suite::animationsuite();
    level thread function_c6113dde5ac43052();
}

// Namespace mp_sat_scar
// Params 1
// Checksum 0x87d38e81, Offset: 0x280
// Size: 0xc
function on_spawn_init( params )
{
    
}

// Namespace mp_sat_scar
// Params 0
// Checksum 0xe0a01aee, Offset: 0x294
// Size: 0x5f
function function_c6113dde5ac43052()
{
    level waittill( #"match_start_real_countdown" );
    wait 2;
    
    if ( ( !game_utility_mp::isroundbased() || !game[ "roundsPlayed" ] ) && level.gametype != "dm" )
    {
        wait 3;
        utility::exploder( "sat_scar_infil_missile" );
        wait 4.8;
        utility::exploder( "sat_scar_infil_explo" );
        wait 1;
    }
}

