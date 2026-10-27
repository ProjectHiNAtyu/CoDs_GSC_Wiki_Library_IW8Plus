// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust.gsc  (hash_535e38c05fbe9765.gscc) (size: 7478 Bytes / 0x1d36 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74ff4bd7 (1962888151)
// size ...... 7478 (0x1d36)
// includes .. 16  (offset: 0x1a4e)
// strings ... 46  (offset: 0x1ace)
// dev strs .. 0   (offset: 0x1d36)
// exports ... 15  (offset: 0x11d2)
// cseg ...... 0x34c + 0xe86 (0x11d2)
// imports ... 50  (offset: 0x142a)
// animtree1 . 0   (offset: 0x1d36)
// animtree2 . 0   (offset: 0x1d36)
#using script_64704521879e3d88;
#using script_65fce064e9f42d6e;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_audio;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_floating_rocks;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_fx;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_lighting;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_rb;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;

#namespace zm_sat_locust;

// Namespace zm_sat_locust
// Params 0
// Checksum 0xf38c230c, Offset: 0x36a
// Size: 0x1ac
function main()
{
    zm_sat_locust_art::main();
    zm_sat_locust_fx::main();
    zm_sat_locust_lighting::main();
    zm_sat_locust_audio::main();
    namespace_c0b4f2882c9d100f::function_8464c50734af5965();
    load::main();
    compass::setupminimap( "compass_map_zm_sat_locust" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level callback::add( "zone_changed", &on_zone_changed );
    level.var_7a5a3a48204781da = &function_40d7e60e0d7d4884;
    level.var_4798e0076da78416 = [ "vtol_warship", "hellstorm_missile", "chopper_door_gunner", "toma_strike", "ground_drone_unit", "dawg", "rcxd", "sentry_gun" ];
    level.var_82608d37301e46de = [ "zone_lighthouse_int_puzzle", "zone_lighthouse_int_puzzle_3" ];
    level.var_796be4543cb83fec = [ "zone_lighthouse_int_puzzle", "zone_lighthouse_int_puzzle_3" ];
    level.var_cc4f3ae072c8b107 = [ "zone_lighthouse_int_puzzle", "zone_lighthouse_int_puzzle_3" ];
    shadow_rift_common::function_99944af57c3d2c54( "zone_robot_head" );
    level.ttlos_suppressasserts = 1;
    level thread zm_sat_locust_rb::init();
    level thread init_staged_items();
    level thread magicbox_materials();
    level thread init_oob();
    level thread skull_spawn();
    level thread function_18d7a0868d0f3dc0();
    setdvar( @"hash_44a9f0f91a98f576", 20 );
    setdvar( @"hash_37f05b20e6e2b254", 15 );
    setdvar( @"hash_3bdc2896f05e40ac", 0.5 );
}

// Namespace zm_sat_locust
// Params 0
// Checksum 0xc59525bf, Offset: 0x51e
// Size: 0xfb
function magicbox_materials()
{
    utility::flag_wait( "magicbox_ready" );
    
    foreach ( s_magic_box in level.var_1bbb5557537e2c0c )
    {
        while ( !isdefined( s_magic_box.mdl_magicbox ) )
        {
            waitframe();
        }
        
        zone = zone_manager::function_90e5c3e2272b0130( s_magic_box.mdl_magicbox.origin );
        state = zone.zone_name != "zone_shipyard_warehouse_2" ? "snow" : "default";
        s_magic_box.mdl_magicbox utility::function_32b24db3127bff40( "material", state );
    }
}

// Namespace zm_sat_locust
// Params 0
// Checksum 0x3f296b49, Offset: 0x621
// Size: 0x5a2
function init_staged_items()
{
    utility::flag_wait( "begin_round_logic" );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:( 0, 268, 0 ), #spawnorigin:( 4078, 588, 276 ), #asset:%"zmloot_sat_offhand_molotov" };
    molotov = zm_sat_locust_util::spawn_quest_item( params );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:( 0, 262.199, 0 ), #spawnorigin:( 2401, 6392, 286 ), #asset:%"zmloot_sat_offhand_molotov" };
    molotov = zm_sat_locust_util::spawn_quest_item( params );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:( 0, 214.299, 0 ), #spawnorigin:( -359, 2827, -140 ), #asset:%"zmloot_sat_offhand_molotov" };
    molotov = zm_sat_locust_util::spawn_quest_item( params );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:( 0, 268, 0 ), #spawnorigin:( 3196, 3892, 135 ), #asset:%"zmloot_sat_offhand_molotov" };
    molotov = zm_sat_locust_util::spawn_quest_item( params );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:( 0, 185.798, 0 ), #spawnorigin:( 6497, 1086, 218 ), #asset:%"zmloot_sat_offhand_molotov" };
    molotov = zm_sat_locust_util::spawn_quest_item( params );
    
    if ( !utility::flag( "zone_fishery_lab_opened" ) )
    {
        params = { #spawntype:#"spawn_at_pos", #spawnangles:( 0, 0, 0 ), #spawnorigin:( 4232, 3218, 175 ), #asset:%"zmloot_sat_killstreak_rcxd" };
        rcxd = zm_sat_locust_util::spawn_quest_item( params );
        rcxd.var_e78811eec0c27aa = 1;
        zm_sat_locust_util::function_295a36ef38f5acae( #"rcxd_staged_item", rcxd );
    }
    
    if ( !utility::flag( "mq_rl_step_03_d" ) )
    {
        params = { #spawntype:#"spawn_at_pos", #spawnangles:( 328.865, 51.6628, 56.2438 ), #spawnorigin:( 4826, 6820, 284 ), #asset:%"zmloot_killstreak_zm_dinj" };
        mutant_injector = zm_sat_locust_util::spawn_quest_item( params );
        mutant_injector.var_e78811eec0c27aa = 1;
        zm_sat_locust_util::function_295a36ef38f5acae( #"dinj_staged_item", mutant_injector );
    }
    
    params = { #spawntype:#"spawn_at_pos", #spawnangles:( 0, -90, 0 ), #spawnorigin:( 6536, 9852, 705 ), #asset:%"zmloot_sat_offhand_monkey_bomb" };
    monkey_bomb = zm_sat_locust_util::spawn_quest_item( params );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:( 0, 73.8995, 0 ), #spawnorigin:( 6430, 9628, 708 ), #asset:%"zmloot_sat_offhand_mini_sentry" };
    point_turret = zm_sat_locust_util::spawn_quest_item( params );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:( 0, 33.8993, 0 ), #spawnorigin:( 6890, 9662, 670 ), #asset:%"zmloot_sat_offhand_blackhole_bomb" };
    kazimir = zm_sat_locust_util::spawn_quest_item( params );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:( -90, 180, 90 ), #spawnorigin:( 7021, 9864, 710 ), #asset:%"zmloot_sat_offhand_combataxe" };
    combat_axe = zm_sat_locust_util::spawn_quest_item( params );
    var_70117b04419ae6db = [];
    params = { #spawntype:#"spawn_at_pos", #spawnangles:( 0, 357.5, 0 ), #spawnorigin:( 6801, 10356, 676 ), #asset:%"zmloot_sat_offhand_gas_grenade" };
    psych_grenade = zm_sat_locust_util::spawn_quest_item( params );
    var_70117b04419ae6db[ var_70117b04419ae6db.size ] = psych_grenade;
    params = { #spawntype:#"spawn_at_pos", #spawnangles:( 0, 0, 24.2993 ), #spawnorigin:( 6169.5, 10227, 675 ), #asset:%"zmloot_sat_offhand_thermobaric_grenade" };
    thermo_grenade = zm_sat_locust_util::spawn_quest_item( params );
    var_70117b04419ae6db[ var_70117b04419ae6db.size ] = thermo_grenade;
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_67940ffe36651660", var_70117b04419ae6db );
}

// Namespace zm_sat_locust
// Params 2, eflags: 0x4
// Checksum 0x7a9f0bfb, Offset: 0xbcb
// Size: 0x74
function private function_40d7e60e0d7d4884( streakitem, slotnumber )
{
    if ( isdefined( self.var_b43d27527f482c08 ) && arraycontains( level.var_4798e0076da78416, streakitem.streakname ) )
    {
        return 0;
    }
    
    if ( isdefined( self.var_163ee79762bc0a64 ) && arraycontains( level.var_14f114e0c14850f8, streakitem.streakname ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace zm_sat_locust
// Params 1, eflags: 0x4
// Checksum 0xc3322134, Offset: 0xc47
// Size: 0xaf
function private on_zone_changed( params )
{
    if ( isdefined( params.zone_struct ) )
    {
        if ( level.var_82608d37301e46de && arraycontains( level.var_82608d37301e46de, params.zone_struct.script_zone_name ) )
        {
            self.var_b43d27527f482c08 = 1;
        }
        else
        {
            self.var_b43d27527f482c08 = undefined;
        }
        
        if ( level.var_227f7ba40322bd7a && arraycontains( level.var_227f7ba40322bd7a, params.zone_struct.script_zone_name ) )
        {
            self.var_163ee79762bc0a64 = 1;
            return;
        }
        
        self.var_163ee79762bc0a64 = undefined;
    }
}

// Namespace zm_sat_locust
// Params 0, eflags: 0x4
// Checksum 0xf450ebce, Offset: 0xcfe
// Size: 0xed
function private init_oob()
{
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.outofboundstriggers = arraycombine( level.outofboundstriggers, getnoentvolumearray( "OutOfBounds", #targetname ) );
    
    foreach ( oob in level.outofboundstriggers )
    {
        oob.get_out_of_bounds_time_override = &function_212f6456c77a65e9;
    }
    
    life_brush = getnoentvolumearray( "fishery_island_life", #targetname )[ 0 ];
    zm_player::function_ff714b8751ab0002( life_brush );
}

// Namespace zm_sat_locust
// Params 1, eflags: 0x4
// Checksum 0x57796e4a, Offset: 0xdf3
// Size: 0xd, Type: bool
function private function_212f6456c77a65e9( ent )
{
    return false;
}

// Namespace zm_sat_locust
// Params 0
// Checksum 0xd08d18d4, Offset: 0xe09
// Size: 0x23, Type: bool
function function_80daf2f20b4e6e6d()
{
    if ( getdvarint( @"hash_70ef86ad43e08120", 0 ) )
    {
        return true;
    }
    
    if ( game_utility::function_d68874417f3eea5c() )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_locust
// Params 0
// Checksum 0x59df6e64, Offset: 0xe35
// Size: 0x1da
function skull_spawn()
{
    if ( !function_80daf2f20b4e6e6d() )
    {
        var_9d5e6c6a6ded4a2c = utility::getstructarray( "dh_1" );
        var_9d5e6f6a6ded50c5 = utility::getstructarray( "dh_2" );
        var_9d5e6e6a6ded4e92 = utility::getstructarray( "dh_3" );
        var_9d5e696a6ded4393 = utility::getstructarray( "dh_4" );
        utility::spawn_model( "t10_decor_deer_skull_01", var_9d5e6c6a6ded4a2c[ 1 ].origin, var_9d5e6c6a6ded4a2c[ 1 ].angles );
        utility::spawn_model( "t10_decor_deer_skull_01", var_9d5e6f6a6ded50c5[ 1 ].origin, var_9d5e6f6a6ded50c5[ 1 ].angles );
        utility::spawn_model( "t10_decor_deer_skull_01", var_9d5e6e6a6ded4e92[ 1 ].origin, var_9d5e6e6a6ded4e92[ 1 ].angles );
        utility::spawn_model( "t10_decor_deer_skull_01", var_9d5e696a6ded4393[ 1 ].origin, var_9d5e696a6ded4393[ 1 ].angles );
        utility::spawn_model( "sat_zm_locust_animal_fur_01", utility::getstruct( "dh_gh_1" ).origin, utility::getstruct( "dh_gh_1" ).angles );
        utility::spawn_model( "sat_zm_locust_animal_fur_01", utility::getstruct( "dh_gh_2" ).origin, utility::getstruct( "dh_gh_2" ).angles );
        utility::spawn_model( "sat_zm_locust_animal_fur_01", utility::getstruct( "dh_gh_3" ).origin, utility::getstruct( "dh_gh_3" ).angles );
        utility::spawn_model( "sat_zm_locust_animal_fur_01", utility::getstruct( "dh_gh_4" ).origin, utility::getstruct( "dh_gh_4" ).angles );
    }
}

// Namespace zm_sat_locust
// Params 0
// Checksum 0xb09ee0dc, Offset: 0x1017
// Size: 0x2e
function function_3efce57265da8ada()
{
    ww_kill_triggers = getnoentvolumearray( "ww_kill_trigger", #targetname );
    utility::array_thread( ww_kill_triggers, &floating_kill_triggers );
}

// Namespace zm_sat_locust
// Params 0
// Checksum 0x69f1a2e2, Offset: 0x104d
// Size: 0x2b
function function_459d352ce27eca06()
{
    ww_lighthouse_middle = getnoentvolumearray( "ww_lighthouse_middle", #targetname )[ 0 ];
    ww_lighthouse_middle thread function_dfd3d34858418f3a();
}

// Namespace zm_sat_locust
// Params 0, eflags: 0xc
// Checksum 0x3b6c337d, Offset: 0x1080
// Size: 0x85
function private function_dfd3d34858418f3a()
{
    self notify( #"hash_5abd7056b50a9614" );
    self endon( #"hash_5abd7056b50a9614" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        self waittill( #"trigger", entity );
        
        if ( isplayer( entity ) )
        {
            if ( entity.is_resetting )
            {
                continue;
            }
            
            spawn_point = entity zone_manager::function_aeaa8dd788ed9b16( undefined, 0, undefined, undefined, undefined, 1 );
            entity zm_sat_locust_floating_rocks::function_b8628007359aae67( spawn_point );
            wait 0.1;
        }
    }
}

// Namespace zm_sat_locust
// Params 0, eflags: 0x4
// Checksum 0x9346e210, Offset: 0x110d
// Size: 0x42
function private floating_kill_triggers()
{
    level endon( #"zm_game_over" );
    wait 1.5;
    
    for ( ;; )
    {
        self waittill( #"trigger", entity );
        
        if ( isscriptedai( entity ) )
        {
            entity zm_sat_locust_util::kill_zombie();
        }
    }
}

// Namespace zm_sat_locust
// Params 0, eflags: 0x4
// Checksum 0xac7e7c93, Offset: 0x1157
// Size: 0x7b
function private function_18d7a0868d0f3dc0()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "begin_round_logic" );
    level.var_4c33e1cd56ccc717 = getent( "rh_col_coffin", #targetname );
    
    if ( !isdefined( level.var_4c33e1cd56ccc717 ) )
    {
        return;
    }
    
    level.var_4c33e1cd56ccc717 connectpaths();
    level.var_4c33e1cd56ccc717 notsolid();
    level utility::flag_set( "rh_col_set" );
}

