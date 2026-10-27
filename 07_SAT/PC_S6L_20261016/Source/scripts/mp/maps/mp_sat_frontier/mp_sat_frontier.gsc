// scripts\mp\maps\mp_sat_frontier\mp_sat_frontier.gsc  (hash_388e11e93b873f45.gscc) (size: 1424 Bytes / 0x590 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa938e9e0 (2839079392)
// size ...... 1424 (0x590)
// includes .. 9   (offset: 0x4a0)
// strings ... 14  (offset: 0x4e8)
// dev strs .. 0   (offset: 0x590)
// exports ... 4   (offset: 0x2a0)
// cseg ...... 0x147 + 0x159 (0x2a0)
// imports ... 12  (offset: 0x340)
// animtree1 . 0   (offset: 0x590)
// animtree2 . 0   (offset: 0x590)
#using scripts\common\active_env\moving_platforms;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_frontier\gen\mp_sat_frontier_art;
#using scripts\mp\maps\mp_sat_frontier\mp_sat_frontier_fx;
#using scripts\mp\maps\mp_sat_frontier\mp_sat_frontier_lighting;

#namespace mp_sat_frontier;

// Namespace mp_sat_frontier
// Params 0
// Checksum 0xbb100672, Offset: 0x165
// Size: 0xfc
function main()
{
    mp_sat_frontier_art::main();
    mp_sat_frontier_fx::main();
    mp_sat_frontier_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_frontier" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( #"player_spawn_init", &on_spawn_init );
    level thread moving_platforms::moving_platforms_init();
}

// Namespace mp_sat_frontier
// Params 1, eflags: 0x4
// Checksum 0x207914f4, Offset: 0x269
// Size: 0x23
function private on_player_spawned( params )
{
    if ( !utility::function_cfcadadaf7557e6b( self ) )
    {
        player::_setsuit( "sat_defaultsuit_mp_snow_deep" );
    }
}

// Namespace mp_sat_frontier
// Params 1
// Checksum 0x89a4170d, Offset: 0x294
// Size: 0xc
function on_spawn_init( params )
{
    
}

