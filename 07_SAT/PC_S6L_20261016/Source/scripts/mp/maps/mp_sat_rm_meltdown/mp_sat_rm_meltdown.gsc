// scripts\mp\maps\mp_sat_rm_meltdown\mp_sat_rm_meltdown.gsc  (hash_4e0fbd9f7e2af5dd.gscc) (size: 1788 Bytes / 0x6fc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x505ab441 (1348121665)
// size ...... 1788 (0x6fc)
// includes .. 6   (offset: 0x618)
// strings ... 15  (offset: 0x648)
// dev strs .. 0   (offset: 0x6fc)
// exports ... 3   (offset: 0x3e4)
// cseg ...... 0x154 + 0x290 (0x3e4)
// imports ... 15  (offset: 0x45c)
// animtree1 . 0   (offset: 0x6fc)
// animtree2 . 0   (offset: 0x6fc)
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_rm_meltdown\gen\mp_sat_rm_meltdown_art;
#using scripts\mp\maps\mp_sat_rm_meltdown\mp_sat_rm_meltdown_fx;
#using scripts\mp\maps\mp_sat_rm_meltdown\mp_sat_rm_meltdown_lighting;

#namespace mp_sat_rm_meltdown;

// Namespace mp_sat_rm_meltdown
// Params 0
// Checksum 0x99628705, Offset: 0x172
// Size: 0xd1
function main()
{
    mp_sat_rm_meltdown_art::main();
    mp_sat_rm_meltdown_fx::main();
    mp_sat_rm_meltdown_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_meltdown" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    function_fbd0609917dc105d();
}

// Namespace mp_sat_rm_meltdown
// Params 0
// Checksum 0x3cee6331, Offset: 0x24b
// Size: 0x199
function function_fbd0609917dc105d()
{
    var_3ec3bb552a1449d0 = getxhash( game_utility::getgametype() );
    a_e_ents_to_remove = getentarray( "remove_for_gametype_sd", #script_noteworthy );
    
    if ( var_3ec3bb552a1449d0 != #"sd" && var_3ec3bb552a1449d0 != #"dd" )
    {
        foreach ( e_ent in a_e_ents_to_remove )
        {
            if ( isdefined( e_ent.script_float ) )
            {
                e_new_model = spawn( "script_model", e_ent.origin );
                e_new_model setscale( e_ent.script_float );
                e_new_model.angles = e_ent.angles;
                e_new_model setmodel( e_ent.model );
                e_ent delete();
            }
        }
        
        return;
    }
    
    foreach ( e_ent in a_e_ents_to_remove )
    {
        e_ent connectpaths();
        e_ent delete();
    }
}

