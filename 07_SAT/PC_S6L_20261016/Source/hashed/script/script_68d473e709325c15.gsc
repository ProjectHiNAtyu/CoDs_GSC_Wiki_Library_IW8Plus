// script_68d473e709325c15  (hash_68d473e709325c15.gscc) (size: 3028 Bytes / 0xbd4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9b63bdf6 (2607005174)
// size ...... 3028 (0xbd4)
// includes .. 8   (offset: 0xa1c)
// strings ... 28  (offset: 0xa5c)
// dev strs .. 0   (offset: 0xbd4)
// exports ... 4   (offset: 0x740)
// cseg ...... 0x1e6 + 0x55a (0x740)
// imports ... 18  (offset: 0x7e0)
// animtree1 . 0   (offset: 0xbd4)
// animtree2 . 0   (offset: 0xbd4)
#using script_1e6ff175103c832e;
#using script_51d7f003398826f4;
#using script_906975eb2f14246;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\load;

#namespace mp_sat_barrel;

// Namespace mp_sat_barrel
// Params 0
// Checksum 0x61461a73, Offset: 0x204
// Size: 0xe0
function main()
{
    namespace_5f67e743709a1d0b::main();
    namespace_70048abf189e93e0::main();
    namespace_b75cd873cb29afae::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_barrel" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread animation_suite::animationsuite();
    thread function_7cb6303f75084cc0();
    setup_no_deploy_zones();
}

// Namespace mp_sat_barrel
// Params 0, eflags: 0x4
// Checksum 0xb0a4584c, Offset: 0x2ec
// Size: 0xd4
function private setup_no_deploy_zones()
{
    var_619d6a48f5a56867 = getentarray( "no_equipment_zone", #script_noteworthy );
    weaponfilter = [ #"dart_mark_zero":1, #"drone_launcher":1 ];
    
    foreach ( var_4f16c60769e4f39a in var_619d6a48f5a56867 )
    {
        var_4f16c60769e4f39a.weaponfilter = weaponfilter;
    }
    
    callback::callback( #"hash_500e33f5505ca842", { #var_619d6a48f5a56867:var_619d6a48f5a56867 } );
}

// Namespace mp_sat_barrel
// Params 0
// Checksum 0x100fac43, Offset: 0x3c8
// Size: 0x378
function function_7cb6303f75084cc0()
{
    level waittill( #"scriptables_ready" );
    train_start = utility::getstruct( "train_start", "targetname" );
    train_end = utility::getstruct( "train_end", "targetname" );
    node = utility::getstruct( "train_node", "script_noteworthy" );
    
    if ( !isdefined( node ) )
    {
        return;
    }
    
    node.mover = spawn( "script_origin", train_start.origin );
    node.var_6a9d06707eca9ac7 = [];
    segments = getentarray( node.target, "targetname" );
    
    if ( segments.size <= 0 )
    {
        return;
    }
    
    foreach ( ent in segments )
    {
        if ( ent.script_noteworthy == "train_front" )
        {
            node.train_front = ent;
        }
        
        if ( ent.script_noteworthy == "train_back" )
        {
            node.train_back = ent;
        }
        
        if ( ent.script_noteworthy == "train_cabin" )
        {
            node.var_6a9d06707eca9ac7[ node.var_6a9d06707eca9ac7.size ] = ent;
        }
    }
    
    if ( isdefined( node.var_6a9d06707eca9ac7 ) )
    {
        foreach ( cabin in node.var_6a9d06707eca9ac7 )
        {
            cabin linkto( node.mover );
        }
        
        node.train_front enablelinkto();
        node.train_front linkto( node.mover );
        node.train_back enablelinkto();
        node.train_back linkto( node.mover );
    }
    
    level waittill( #"prematch_done" );
    direction = "up";
    
    while ( true )
    {
        if ( direction == "up" )
        {
            node.mover moveto( train_end.origin, 15 );
            node.train_front setscriptablepartstate( "sfx", "on" );
            node.train_back setscriptablepartstate( "sfx", "off" );
            direction = "down";
            wait randomintrange( 45, 125 );
        }
        
        if ( direction == "down" )
        {
            node.mover moveto( train_start.origin, 15 );
            node.train_front setscriptablepartstate( "sfx", "off" );
            node.train_back setscriptablepartstate( "sfx", "on" );
            direction = "up";
            wait randomintrange( 45, 125 );
        }
    }
}

