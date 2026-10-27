// scripts\mp\maps\mp_sat_shipyard\mp_sat_shipyard.gsc  (hash_77e0641c29357f81.gscc) (size: 1597 Bytes / 0x63d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x70444aad (1883523757)
// size ...... 1597 (0x63d)
// includes .. 6   (offset: 0x549)
// strings ... 16  (offset: 0x579)
// dev strs .. 0   (offset: 0x63d)
// exports ... 4   (offset: 0x341)
// cseg ...... 0x181 + 0x1c0 (0x341)
// imports ... 12  (offset: 0x3e1)
// animtree1 . 0   (offset: 0x63d)
// animtree2 . 0   (offset: 0x63d)
#using scripts\common\callbacks;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_shipyard\gen\mp_sat_shipyard_art;
#using scripts\mp\maps\mp_sat_shipyard\mp_sat_shipyard_fx;
#using scripts\mp\maps\mp_sat_shipyard\mp_sat_shipyard_lighting;

#namespace mp_sat_shipyard;

// Namespace mp_sat_shipyard
// Params 0
// Checksum 0xe5a57c57, Offset: 0x19f
// Size: 0xe6
function main()
{
    mp_sat_shipyard_art::main();
    mp_sat_shipyard_fx::main();
    mp_sat_shipyard_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_shipyard" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    callback::add( #"player_spawn_init", &on_spawn_init );
    function_4c3843705e1e2ae7();
}

// Namespace mp_sat_shipyard
// Params 0
// Checksum 0xeca8343c, Offset: 0x28d
// Size: 0xa0
function function_4c3843705e1e2ae7()
{
    e_model_01 = spawn( "script_model", ( -456, 1834, 136.5 ) );
    e_model_01.angles = ( 0, 191.539, 0 );
    e_model_01 setscale( 4 );
    e_model_01 setmodel( "t10_construction_pipes_metal_joint_2way_01" );
    e_model_02 = spawn( "script_model", ( 96.875, 446.375, 185 ) );
    e_model_02.angles = ( 0, 90, 0 );
    e_model_02 setscale( 1 );
    e_model_02 setmodel( "door_old_rusted_metal_02" );
}

// Namespace mp_sat_shipyard
// Params 1
// Checksum 0xfca6c4aa, Offset: 0x335
// Size: 0xc
function on_spawn_init( params )
{
    
}

