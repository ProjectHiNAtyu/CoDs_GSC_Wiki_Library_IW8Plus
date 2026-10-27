// script_5c010b4d203aa66  (hash_05c010b4d203aa66.gscc) (size: 2418 Bytes / 0x972 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc1b87a12 (3250092562)
// size ...... 2418 (0x972)
// includes .. 6   (offset: 0x896)
// strings ... 13  (offset: 0x8c6)
// dev strs .. 0   (offset: 0x972)
// exports ... 9   (offset: 0x502)
// cseg ...... 0x19f + 0x363 (0x502)
// imports ... 19  (offset: 0x66a)
// animtree1 . 0   (offset: 0x972)
// animtree2 . 0   (offset: 0x972)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\gametypes\zm_rb_survival;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_pap_quest;
#using scripts\mp\zm\systems\zm_fog_spawning;

#namespace namespace_f37852973cef32eb;

// Namespace namespace_f37852973cef32eb
// Params 0, eflags: 0x5
// Checksum 0xb55c2750, Offset: 0x1bd
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_rb_survival_ashwood", undefined, &pre_main_init, &post_main_init );
}

// Namespace namespace_f37852973cef32eb
// Params 0, eflags: 0x4
// Checksum 0xdd6591d4, Offset: 0x1e2
// Size: 0xe6
function private pre_main_init()
{
    if ( !function_e5ec37367deeb8a1() )
    {
        return;
    }
    
    var_eb5a3cf877c90c29 = { #name:"script_struct agent_spawner", #target:"zone_sunken_sheriff_exterior", #targetname:"zone_agent_spawn", #script_noteworthy:"zombie_base|zombie_base_armored_heavy|zombie_base_armored_light", #angles:( 0, 90, 0 ), #origin:( 3850.4, -2201.35, -38.561 ) };
    
    if ( isdefined( level.zone_spawn_locations ) )
    {
        level.zone_spawn_locations = arraycombineunique( level.zone_spawn_locations, [ var_eb5a3cf877c90c29 ] );
    }
    
    level utility::registersharedfunc( #"hash_280e25dd3ca205d4", #"power_flag_override", &function_f443c34fda1a1f33 );
    level utility::registersharedfunc( #"firefly_pap_quest", #"hash_c87b411e7826157c", &function_50a20180bd417146 );
}

// Namespace namespace_f37852973cef32eb
// Params 0, eflags: 0x4
// Checksum 0x56b63b10, Offset: 0x2d0
// Size: 0x40
function private post_main_init()
{
    if ( !function_e5ec37367deeb8a1() )
    {
        return;
    }
    
    level.vending_machines_powered_on_at_start = 0;
    register_fog_area();
    level thread function_a72d9820c3c9d812();
    level utility::clearsharedfunc( #"veh_pluto", #"on_breakdown" );
}

// Namespace namespace_f37852973cef32eb
// Params 0, eflags: 0x4
// Checksum 0x45fd3002, Offset: 0x318
// Size: 0x2f, Type: bool
function private function_e5ec37367deeb8a1()
{
    if ( !game_utility::function_21211f3255f8ea58() )
    {
        return false;
    }
    
    poiname = namespace_5a5804f117f6c87b::function_64c3a9143299dacb();
    
    if ( poiname != "ashwood" )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_f37852973cef32eb
// Params 0
// Checksum 0x5a3e4c05, Offset: 0x350
// Size: 0x53
function register_fog_area()
{
    level utility::flag_wait( "map_fog_spawning_init_finished" );
    zm_fog_spawning::register_fog_zone( "zone_sunken_garage", "zone_sunken" );
    zm_fog_spawning::register_fog_zone( "zone_sunken_north", "zone_sunken" );
    zm_fog_spawning::register_fog_zone( "zone_sunken_south", "zone_sunken" );
    zm_fog_spawning::register_fog_zone( "zone_sunken", "zone_sunken_south" );
}

// Namespace namespace_f37852973cef32eb
// Params 0, eflags: 0x4
// Checksum 0x75cc39c3, Offset: 0x3ab
// Size: 0x1c
function private function_f443c34fda1a1f33()
{
    level utility::flag_clear( "power_on3" );
    level utility::flag_clear( "power_on" );
}

// Namespace namespace_f37852973cef32eb
// Params 0, eflags: 0x4
// Checksum 0xab0a8ac9, Offset: 0x3d0
// Size: 0xa
function private function_50a20180bd417146()
{
    level thread zm_sat_firefly_pap_quest::function_2aa22232fa3bfbf6();
}

// Namespace namespace_f37852973cef32eb
// Params 0, eflags: 0x4
// Checksum 0xce85289, Offset: 0x3e2
// Size: 0x120
function private function_a72d9820c3c9d812()
{
    level endon( #"game_ended" );
    level.var_af6ac0182161b54e = 1;
    
    while ( !isdefined( level.wonder_veh.stagerequested ) )
    {
        wait 0.1;
    }
    
    wait 0.3;
    level.wonder_veh vehicle_teleport( level.var_1b7735821fd80ddd.s_pluto_spawn.origin, ( 0, 90, 0 ) );
    
    if ( isdefined( level.zm_save_info ) )
    {
        level.zm_save_info.var_a039f009852790bd = 1;
    }
    
    level.wonder_veh.startpos = level.var_1b7735821fd80ddd.s_pluto_spawn.origin;
    level.wonder_veh.startangles = ( 0, 90, 0 );
    level waittill( #"hash_9dbe2e17bffd3b9" );
    level utility::flag_set( "upgraded_pluto_to_stage_" + 83 );
    level.wonder_veh.stagerequested = 83;
}

