// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_arcxd_racing_quest.gsc  (hash_02f38e5e1c5d889c.gscc) (size: 35489 Bytes / 0x8aa1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x672e1f (6762015)
// size ...... 35489 (0x8aa1)
// includes .. 34  (offset: 0x813d)
// strings ... 115 (offset: 0x824d)
// dev strs .. 39  (offset: 0x88a9)
// exports ... 79  (offset: 0x5371)
// cseg ...... 0x950 + 0x4a21 (0x5371)
// imports ... 276 (offset: 0x5fc9)
// animtree1 . 0   (offset: 0x8aa1)
// animtree2 . 0   (offset: 0x8aa1)
#using script_16ea1b94f0f381b3;
#using script_54d7585f0a1791e6;
#using script_60ecf0e6d7ee7771;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\scene;
#using scripts\common\shellshock_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\weaponmetadata;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_fasttravel_core;
#using scripts\mp\zm\systems\zm_live_spectate;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_firefly_arcxd_racing_quest;

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0, eflags: 0x1
// Checksum 0x34e6b059, Offset: 0x96e
// Size: 0x1d
function autoexec main()
{
    if ( !getdvarint( @"hash_dfe5227c40e9c4e0", 0 ) )
    {
        return;
    }
    
    level thread init();
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0, eflags: 0x4
// Checksum 0x91a63123, Offset: 0x993
// Size: 0x10f
function private init()
{
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "zm_sat_firefly_bear_attack_quest_cs_completed" );
    level.bear_attack_quest = zm_quest::get_quest( #"hash_74eea7ea11e2a755" );
    level._effect[ "arcxd_racing_reset_spawn" ] = loadfxasset( "vfx_t10_gameplay_zm_boat_respawn" );
    level._effect[ "arcxd_racing_reset_despawn" ] = loadfxasset( "vfx_t10_levels_zm_opal_constellation_despawn" );
    zm_quest::register_quest_step( #"hash_74eea7ea11e2a755", #"init_hidden_arcxd", &function_d5562140c6ace0b0, &function_a7e5b856e1c002db );
    zm_quest::register_quest_step( #"hash_74eea7ea11e2a755", #"hash_7f9ffd08ad16e404", &function_97a82704d7851c09, &function_f5285b1ee335635a );
    zm_quest::register_quest_step( #"hash_74eea7ea11e2a755", #"race_start", &function_7cd4455c6c807f4e, &function_ef410671918c01d5 );
    zm_quest::function_3c363613c60958f5( "arecxd_racing_active" );
    zm_quest::function_3c363613c60958f5( "arcxd_racing_voting" );
    level.var_42f8e7da9c2866e5 = namespace_2918ad6c52d71794::register();
    function_e5170f6e8f8b519c();
    level thread arcxd_setup();
    
    /#
        setup_arcxd_racing_devgui();
    #/
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x183ee488, Offset: 0xaaa
// Size: 0x2c
function arcxd_setup()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "begin_round_logic" );
    level thread zm_quest::start_quest( #"hash_74eea7ea11e2a755" );
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x8bb5f3f, Offset: 0xade
// Size: 0x1a1
function function_e5170f6e8f8b519c()
{
    if ( level.arcxd_racing )
    {
        return;
    }
    
    level.arcxd_racing = spawnstruct();
    level.arcxd_racing.attempt = 0;
    level.arcxd_racing.var_dea9e167df26bcb3 = 0;
    level.arcxd_racing.locked_pluto = undefined;
    level.arcxd_racing.finish_trigger = getnoentvolumearray( "arcxd_racing_finish", "script_noteworthy" )[ 0 ];
    level.arcxd_racing.var_d9906d678f78a3fa = [ { #trophy:%"sat_zm_arcxd_racing_trophy_1st", #time_usage:35000, #score_event:#"hash_9694de673aca5f0f" }, { #trophy:%"sat_zm_arcxd_racing_trophy_2nd", #time_usage:45000, #score_event:#"hash_9694df673aca60c2" }, { #trophy:%"sat_zm_arcxd_racing_trophy_3rd", #time_usage:60000, #score_event:#"hash_9694e0673aca6275" }, { #trophy:%"sat_zm_arcxd_racing_trophy_4th", #time_usage:90000, #score_event:#"hash_9694d9673aca5690" } ];
    level.arcxd_racing.var_396cce885f7c3331 = [ "player_green", "player_yellow", "player_cyan", "player_pink" ];
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0xad864b3e, Offset: 0xc87
// Size: 0x2a
function function_d5562140c6ace0b0( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    toy_car_init( b_save_restored );
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0x794cd6c1, Offset: 0xcb9
// Size: 0x15
function function_a7e5b856e1c002db( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0x2de4f43f, Offset: 0xcd6
// Size: 0x3e
function function_97a82704d7851c09( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( !b_save_restored )
    {
        level utility::flag_wait_all( "zone_launchpad_rocket_enabled", "zone_launchpad_underground_enabled", "zone_launchpad_underground_02_enabled" );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0xb992beb2, Offset: 0xd1c
// Size: 0x15
function function_f5285b1ee335635a( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0x791a6fee, Offset: 0xd39
// Size: 0x1ce
function function_7cd4455c6c807f4e( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level.arcxd_racing.b_is_active = 1;
    
    while ( level.arcxd_racing.attempt < 3 )
    {
        function_bdfbdc25d28f0b79();
        active_toy_car = level.arcxd_racing.var_f3801229fe540032[ level.arcxd_racing.attempt ];
        level thread enable_toy_car( active_toy_car );
        level waittill( #"arcxd_racing_start" );
        function_7dbb8fe94bf5641();
        level waittill( #"hash_88accb6f320e9238" );
        
        foreach ( player in level.players )
        {
            if ( !player )
            {
                continue;
            }
            
            player utility::ent_flag_set( "player_has_finished_rcxd_racing" );
        }
        
        level thread function_e1401926e8c3536();
        level.arcxd_racing.attempt++;
        level.arcxd_racing.var_dea9e167df26bcb3 = zm_round_logic::get_rb_round_number() + 5;
        zm_quest::function_4eefe6de31f5ddab( #"hash_74eea7ea11e2a755", #"hash_d32655d390623fa4", level.arcxd_racing.attempt );
        zm_quest::function_4eefe6de31f5ddab( #"hash_74eea7ea11e2a755", #"hash_7b8c9994f1985d36", level.arcxd_racing.var_dea9e167df26bcb3 );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x65c38696, Offset: 0xf0f
// Size: 0x90
function function_bdfbdc25d28f0b79()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.arcxd_racing.var_dea9e167df26bcb3 ) )
    {
        return;
    }
    
    current_round = zm_round_logic::get_rb_round_number();
    
    if ( current_round >= level.arcxd_racing.var_dea9e167df26bcb3 )
    {
        return;
    }
    
    while ( zm_round_logic::get_rb_round_number() < level.arcxd_racing.var_dea9e167df26bcb3 || zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
    {
        level waittill( #"on_round_start" );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0x8da72d1, Offset: 0xfa7
// Size: 0x1c
function function_ef410671918c01d5( b_skipped, b_save_restored )
{
    function_2469c456e232c67b();
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0, eflags: 0x4
// Checksum 0x9dc60884, Offset: 0xfcb
// Size: 0xe3
function private function_b9fd27dcc5e5a116()
{
    if ( !level.arcxd_racing || isdefined( level.arcxd_racing.locked_pluto ) )
    {
        return;
    }
    
    if ( !isdefined( level.wonder_veh ) || !level.wonder_veh vehicle::is_vehicle() )
    {
        return;
    }
    
    if ( !level.wonder_veh utility::function_9f2c41c1dcc8c94( "single", "vehicle_use" ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_ee3a6dc51896d3d8" ) )
    {
        level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_ee3a6dc51896d3d8" );
    }
    
    level pluto_veh::set_vehicle_usable_state( level.wonder_veh, 0 );
    level.arcxd_racing.locked_pluto = level.wonder_veh;
    utility::delaythread( 5, &function_2469c456e232c67b );
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0, eflags: 0x4
// Checksum 0xba2112dd, Offset: 0x10b6
// Size: 0x7c
function private function_2469c456e232c67b()
{
    if ( !level.arcxd_racing || !isdefined( level.arcxd_racing.locked_pluto ) )
    {
        return;
    }
    
    pluto = level.arcxd_racing.locked_pluto;
    level.arcxd_racing.locked_pluto = undefined;
    
    if ( !isdefined( pluto ) || !pluto vehicle::is_vehicle() )
    {
        return;
    }
    
    level pluto_veh::set_vehicle_usable_state( pluto, 1 );
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x663a7739, Offset: 0x113a
// Size: 0x5e1
function function_7dbb8fe94bf5641()
{
    level endon( #"game_ended" );
    level endon( #"hash_88accb6f320e9238" );
    zm_fasttravel_core::function_8649f9a98d2d9ce3();
    
    if ( level.europa )
    {
        level.europa utility::callsharedfunc( #"europa", #"hash_c3e2334e7794ce1a", 0 );
        level.europa utility::callsharedfunc( #"europa", #"hash_f611d6f3acf4e752", 1 );
    }
    
    if ( isdefined( level.wonder_veh ) && utility::issharedfuncdefined( #"veh_pluto", #"hash_4b9482ccfc73d4d2" ) && !utility::callsharedfunc( #"veh_pluto", #"hash_4b9482ccfc73d4d2" ) && utility::issharedfuncdefined( #"veh_pluto", #"hash_c662103c9de1c046" ) )
    {
        level.wonder_veh thread utility::callsharedfunc( #"veh_pluto", #"hash_c662103c9de1c046" );
    }
    
    a_s_warp_loc = utility::getstructarray( "arcxd_racing_player_start_loc", "script_noteworthy" );
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        player.arcxd_racing_finish_time = undefined;
    }
    
    fade_to_black_for_all( 1, 0.1 );
    level thread function_bae25b627bb8c043();
    zm_round_spawning::pause_round_spawning( 1, "arcxd_racing_pause_spawning" );
    level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 1, 1 );
    function_4623c6246bb50fef( a_s_warp_loc[ 0 ].origin );
    wait 0.5;
    function_89bbada31d481b6d( 1 );
    level.var_5d45eba3b2a7c833 = [];
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        player utility::function_d5a54acde3e473ca( 1 );
        player dontinterpolate();
        var_6787895101874fb4 = player getentitynumber();
        player setadditionalstreamposuntilcleared( a_s_warp_loc[ var_6787895101874fb4 ].origin, 3 );
        player setorigin( a_s_warp_loc[ var_6787895101874fb4 ].origin );
        player setplayerangles( a_s_warp_loc[ var_6787895101874fb4 ].angles );
        player.var_e6b3b2d95c1484e = a_s_warp_loc[ var_6787895101874fb4 ].angles;
        player.var_cbc39ccf0c9580a5 = utility::getstruct( a_s_warp_loc[ var_6787895101874fb4 ].target, "targetname" );
        player.var_48cf427ce60b411d = 0;
        player setclientomnvar( "ui_zm_is_arcxd_race", 1 );
    }
    
    wait 3;
    function_b40e74b2ef1176d();
    level thread dancing_zombie_monitor();
    level thread enable_rank_trigger();
    level thread moving_platform_monitor();
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        a_spawn_origin = utility::getstructarray( "arcxd_racing_start_position", "script_noteworthy" );
        var_6787895101874fb4 = player getentitynumber();
        level thread function_60457ba2eeb608e8( player, a_spawn_origin[ var_6787895101874fb4 ] );
        player.var_27be9bb33ddb8efc = 1;
        player.var_5dbaf6674c071204 = 0;
    }
    
    wait 0.5;
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"arcxd_race" );
    fade_to_black_for_all( 0, 0.1 );
    function_e513208ecc21558a();
    
    foreach ( start_blocker in level.var_5d45eba3b2a7c833 )
    {
        start_blocker delete();
    }
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        player zm_quest::function_fba942a1cfd85f5d( 1, 0, #"hash_74eea7ea11e2a755", #"race_start" );
        player zm_quest::function_fb3af5600f6a9441( 1, 0, #"hash_74eea7ea11e2a755", #"race_start" );
        player zm_quest::function_612a9ad0db22c29c( 90000, 0, #"hash_74eea7ea11e2a755", #"race_start" );
        player zm_quest::function_194bde735238c397( 0, 0, #"hash_74eea7ea11e2a755", #"race_start" );
        player zm_quest::function_9f49b2a045ece8ae( 1, 0, #"hash_74eea7ea11e2a755", #"race_start" );
        player utility::function_d5a54acde3e473ca( 0 );
        player clearadditionalstreampos();
        player thread function_e185f2a7d4e2900a();
    }
    
    level thread function_d8140e62a6f210();
    level thread function_d1869ff3d6fc9cb9();
    level thread function_b9f4cd7d0d5b3191();
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xb0d907be, Offset: 0x1723
// Size: 0x48
function function_bae25b627bb8c043()
{
    level endon( #"game_ended" );
    start_time = gettime();
    var_17521a9b3a1491bc = 10000;
    
    while ( gettime() - start_time < var_17521a9b3a1491bc )
    {
        zm_quest::cleanup_deployed_killstreaks();
        wait 0.1;
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0x21e8e276, Offset: 0x1773
// Size: 0xa4
function function_4623c6246bb50fef( origin )
{
    var_8c769878aad1f71e = utility::function_b7f3d374aa10aa51( "zm_living_world", "targetname", origin, 3000 );
    
    foreach ( living_world_struct in var_8c769878aad1f71e )
    {
        level notify( living_world_struct.var_3920f827ef511acd[ 0 ] );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xc21e0174, Offset: 0x181f
// Size: 0x29
function function_d8140e62a6f210()
{
    level endon( #"game_ended" );
    level endon( #"hash_88accb6f320e9238" );
    wait 90;
    level notify( #"hash_88accb6f320e9238" );
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x1916091e, Offset: 0x1850
// Size: 0x145
function function_e513208ecc21558a()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        level.var_42f8e7da9c2866e5 namespace_2918ad6c52d71794::open( player );
        level.var_42f8e7da9c2866e5 namespace_2918ad6c52d71794::set_remain_time( player, 5 );
    }
    
    level thread function_ce23d37d35308fb9();
    wait 5;
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        level.var_42f8e7da9c2866e5 namespace_2918ad6c52d71794::close( player );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xac5396ff, Offset: 0x199d
// Size: 0x134
function function_ce23d37d35308fb9()
{
    for ( n_count = 5; n_count > 0 ; n_count-- )
    {
        foreach ( player in level.players )
        {
            if ( !player )
            {
                continue;
            }
            
            player playlocalsound( "evt_arcxd_race_countdown" );
            player function_e61e4845853c4632( n_count );
        }
        
        wait 1;
    }
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        player playlocalsound( "evt_arcxd_race_countdown_final" );
        player playlocalsound( "dx_zm_fesd_estg_zpas_ffesdaxrr" );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0x5bcb4091, Offset: 0x1ad9
// Size: 0x4c
function function_e61e4845853c4632( n_count )
{
    var_7285fe57ae3ae8b1 = [ "dx_zm_fesd_estg_zpas_ffesdaxr1", "dx_zm_fesd_estg_zpas_ffesdaxr2", "dx_zm_fesd_estg_zpas_ffesdaxr3" ];
    
    if ( isdefined( var_7285fe57ae3ae8b1[ n_count - 1 ] ) )
    {
        self playlocalsound( var_7285fe57ae3ae8b1[ n_count - 1 ] );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xbe350fcf, Offset: 0x1b2d
// Size: 0x417
function function_e1401926e8c3536()
{
    level endon( #"game_ended" );
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"arcxd_race" );
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hash_74eea7ea11e2a755", #"race_start" );
    }
    
    fade_to_black_for_all( 1, 0.1 );
    wait 0.5;
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            continue;
        }
        
        player zm_live_spectate::function_794d0c5793d9aed3();
        player setplayerangles( player.var_e6b3b2d95c1484e );
    }
    
    level notify( #"arcxd_racing_cleanup" );
    function_75006fa11bfb23ec();
    minimum_finish_time = 9999999;
    first_place_player = undefined;
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            continue;
        }
        
        if ( player.var_5dbaf6674c071204 && player.arcxd_racing_finish_time < minimum_finish_time )
        {
            minimum_finish_time = player.arcxd_racing_finish_time;
            first_place_player = player;
        }
    }
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            continue;
        }
        
        if ( player.var_27be9bb33ddb8efc && isdefined( player.arcxd_racing_veh ) )
        {
            player function_ec734ab67c642dc1( player.arcxd_racing_veh );
        }
        
        player.var_27be9bb33ddb8efc = undefined;
        player.var_5dbaf6674c071204 = undefined;
        player.var_48cf427ce60b411d = undefined;
        player.arc_rank_trigger = undefined;
        player.arc_distance_to_target = undefined;
        player val::reset_all( "arcxd_racing" );
        player setclientomnvar( "ui_zm_is_arcxd_race", 0 );
    }
    
    zm_quest::function_d04a18ed4295a8cd();
    function_4b5380805b55c916( first_place_player );
    level val::reset( "arcxd_race_tasks", "task_logic_activate" );
    utility::delaythread( 30, &zm_round_spawning::pause_round_spawning, 0, "arcxd_racing_pause_spawning" );
    
    if ( level.europa )
    {
        level.europa utility::callsharedfunc( #"europa", #"hash_c3e2334e7794ce1a", 1 );
        level.europa utility::callsharedfunc( #"europa", #"hash_f611d6f3acf4e752", 0 );
    }
    
    utility::flag_clear( "arecxd_racing_active" );
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0x62881816, Offset: 0x1f4c
// Size: 0xf8
function function_89bbada31d481b6d( var_923d563e401cdc45 )
{
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        player val::set( "arcxd_racing", "ignoreme", var_923d563e401cdc45 );
        player val::set( "arcxd_racing", "killstreaks", !var_923d563e401cdc45 );
        player val::set( "arcxd_racing", "damage", !var_923d563e401cdc45 );
        player val::set( "arcxd_racing", "reload", !var_923d563e401cdc45 );
        player val::set( "arcxd_racing", "ignore_afk", var_923d563e401cdc45 );
    }
    
    zm_quest::function_d7216beb89a22329();
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x6a988b1a, Offset: 0x204c
// Size: 0x22e
function function_d1869ff3d6fc9cb9()
{
    level endon( #"game_ended" );
    level endon( #"hash_88accb6f320e9238" );
    
    if ( !level.arcxd_racing.finish_trigger )
    {
        return;
    }
    
    start_time = gettime();
    
    /#
        level.arcxd_racing.start_time = start_time;
    #/
    
    while ( true )
    {
        level.arcxd_racing.finish_trigger waittill( #"trigger", ent );
        
        if ( level.arcxd_racing.b_is_active && ent vehicle::is_vehicle() && isplayer( ent.owner ) && !ent.owner.var_5dbaf6674c071204 )
        {
            player = ent.owner;
            player.var_5dbaf6674c071204 = 1;
            player.arcxd_racing_finish_time = gettime() - start_time;
            player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hash_74eea7ea11e2a755", #"race_start" );
            player notify( #"arcxd_racing_finish" );
            player playlocalsound( "evt_arcxd_race_player_finish" );
            var_d13a88f94e638ef3 = 1;
            
            foreach ( other_player in level.players )
            {
                if ( isalive( other_player ) && other_player.var_27be9bb33ddb8efc && !other_player.var_5dbaf6674c071204 )
                {
                    var_d13a88f94e638ef3 = 0;
                    break;
                }
            }
            
            if ( var_d13a88f94e638ef3 )
            {
                level notify( #"hash_88accb6f320e9238" );
                continue;
            }
            
            if ( player.var_27be9bb33ddb8efc )
            {
                player function_ec734ab67c642dc1( player.arcxd_racing_veh );
                player zm_live_spectate::function_5647f60a40d71849();
            }
        }
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x5e43eea, Offset: 0x2282
// Size: 0x86
function function_b9f4cd7d0d5b3191()
{
    level endon( #"game_ended" );
    level endon( #"hash_88accb6f320e9238" );
    wait 1;
    
    while ( true )
    {
        a_player_sort = arraysort( level.players, undefined, &function_1935d712d4719974 );
        
        for ( i = 0; i < a_player_sort.size ; i++ )
        {
            a_player_sort[ i ] zm_quest::function_9f49b2a045ece8ae( i + 1, 0, #"hash_74eea7ea11e2a755", #"race_start" );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0x887f2981, Offset: 0x2310
// Size: 0xb4, Type: bool
function function_1935d712d4719974( playera, playerb )
{
    if ( playera.var_5dbaf6674c071204 && playerb.var_5dbaf6674c071204 )
    {
        return ( playera.arcxd_racing_finish_time < playerb.arcxd_racing_finish_time );
    }
    
    if ( playera.var_5dbaf6674c071204 )
    {
        return true;
    }
    
    if ( playerb.var_5dbaf6674c071204 )
    {
        return false;
    }
    
    if ( playera.var_48cf427ce60b411d == playerb.var_48cf427ce60b411d )
    {
        return ( playera.arc_distance_to_target < playerb.arc_distance_to_target );
    }
    
    return playera.var_48cf427ce60b411d > playerb.var_48cf427ce60b411d;
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xb3430bbe, Offset: 0x23cd
// Size: 0x2f
function function_b2fc1ed344d9ca82()
{
    clip = getent( "axr_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip notsolid();
        clip hide();
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xb88ef360, Offset: 0x2404
// Size: 0x23e
function function_b40e74b2ef1176d()
{
    clip = getent( "axr_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip solid();
        clip show();
    }
    
    a_rails = utility::getstructarray( "arcxd_rail", "script_noteworthy" );
    
    foreach ( rail in a_rails )
    {
        if ( rail.targetname )
        {
            rail.mdl = spawnscriptable( rail.targetname, rail.origin, rail.angles );
        }
    }
    
    a_arrows = utility::getstructarray( "arc_arrow", "script_noteworthy" );
    
    foreach ( arrow in a_arrows )
    {
        if ( arrow.targetname )
        {
            arrow.mdl = utility::spawn_model( arrow.targetname, arrow.origin, arrow.angles );
        }
    }
    
    var_d48cf327cea906ae = getentarray( "arcxd_racing_clip_to_ignore", "script_noteworthy" );
    
    foreach ( clip_to_ignore in var_d48cf327cea906ae )
    {
        clip_to_ignore notsolid();
        clip_to_ignore hide();
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xd1ebd3cb, Offset: 0x264a
// Size: 0x1d6
function function_75006fa11bfb23ec()
{
    function_b2fc1ed344d9ca82();
    a_rails = utility::getstructarray( "arcxd_rail", "script_noteworthy" );
    
    foreach ( rail in a_rails )
    {
        if ( rail.mdl )
        {
            rail.mdl freescriptable();
        }
    }
    
    a_arrows = utility::getstructarray( "arc_arrow", "script_noteworthy" );
    
    foreach ( arrow in a_arrows )
    {
        if ( arrow.targetname )
        {
            arrow.mdl delete();
        }
    }
    
    var_d48cf327cea906ae = getentarray( "arcxd_racing_clip_to_ignore", "script_noteworthy" );
    
    foreach ( clip_to_ignore in var_d48cf327cea906ae )
    {
        clip_to_ignore solid();
        clip_to_ignore show();
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0xdcf402e1, Offset: 0x2828
// Size: 0x33a
function dancing_zombie_monitor( _monitor )
{
    level endon( #"game_ended" );
    a_s_zombie_locs = utility::getstructarray( "arcxd_racing_dancing_zombie_loc", "script_noteworthy" );
    var_644c244a4ca4550e = utility::getstruct( "scene_arcxd_base_dance", "targetname" );
    var_8a9f72e4d92d20d0 = [ "shot_0", "shot_1", "shot_2", "shot_3", "shot_4", "shot_5", "shot_6", "shot_7", "shot_8", "shot_9", "shot_10", "shot_11", "shot_12", "shot_13", "shot_14", "shot_15", "shot_16" ];
    var_844660002a6c7a01 = [];
    
    foreach ( loc in a_s_zombie_locs )
    {
        mdl_zmb = agent_manager::spawn_agent( "zombie_base", loc.origin, loc.angles, "team_two_hundred" );
        
        if ( isdefined( mdl_zmb ) )
        {
            mdl_zmb val::set( "sq_arc_racing", "show_healthbar", 0 );
            mdl_zmb val::set( "sq_arc_racing", "ignore_cleanup", 1 );
            mdl_zmb val::set( "sq_arc_racing", "disallow_knockdown", 1 );
            mdl_zmb val::set( "sq_arc_racing", "damage", 0 );
            mdl_zmb.scripted_mode = 1;
            mdl_zmb.ignoreall = 1;
            mdl_zmb.no_powerups = 1;
            mdl_zmb.var_a13bed1ac47e1b2c = 1;
            mdl_zmb.var_7ee152b43c7188e1 = 1;
            mdl_zmb.b_ignore_death_perception = 1;
            mdl_zmb.str_scene_animset_override = "zombie_base_zm_scene";
            mdl_zmb.collide_with_ai = 0;
            var_844660002a6c7a01[ var_844660002a6c7a01.size ] = mdl_zmb;
            mdl_zmb notify( #"hash_b29c1a978f0e4627" );
            mdl_zmb thread zombie_vox::function_2373b7dab1283d18();
            mdl_zmb function_66dc8b6ae969f66d( 1 );
            mdl_zmb.var_e9bbea7fb47205ef = 1;
            mdl_zmb.nocorpse = 1;
            loc thread scene::play( mdl_zmb, utility::array_random( var_8a9f72e4d92d20d0 ), "sat_zm_arcxd_racing_base_zombie_dance" );
        }
        
        waitframe();
    }
    
    level waittill( #"arcxd_racing_cleanup" );
    
    foreach ( zmb in var_844660002a6c7a01 )
    {
        if ( isdefined( zmb ) )
        {
            zmb kill();
            waitframe();
        }
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x584b3b77, Offset: 0x2b6a
// Size: 0x8c
function enable_rank_trigger()
{
    var_fa6f66f4bb715bb4 = getnoentvolumearray( "arc_route_trigger", "script_noteworthy" );
    
    foreach ( rank_trigger in var_fa6f66f4bb715bb4 )
    {
        rank_trigger thread rank_trigger_monitor();
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x37378ab, Offset: 0x2bfe
// Size: 0x16d
function rank_trigger_monitor()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    level endon( #"hash_88accb6f320e9238" );
    var_ed92d3edd3eded9 = utility::getstruct( self.targetname, "target" );
    reset_struct = utility::getstruct( self.target, "targetname" );
    rank_index = self.script_int;
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( level.arcxd_racing.b_is_active && ent vehicle::is_vehicle() && isplayer( ent.owner ) && !ent.owner.var_5dbaf6674c071204 )
        {
            player = ent.owner;
            
            if ( player.var_48cf427ce60b411d <= rank_index || !player function_a77ab1770ab2f1d6() )
            {
                player.var_48cf427ce60b411d = rank_index;
                player.arc_rank_trigger = self;
                player.arc_distance_to_target = distancesquared( ent.origin, var_ed92d3edd3eded9.origin );
                
                if ( isdefined( reset_struct ) )
                {
                    player.var_267f8f90b084fd4b = reset_struct;
                }
            }
        }
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xe1eb2e1a, Offset: 0x2d73
// Size: 0x12e
function moving_platform_monitor()
{
    level endon( #"game_ended" );
    platform_start = utility::getstruct( "arc_moving_platform", "script_noteworthy" );
    platform_end = utility::getstruct( platform_start.target, "targetname" );
    clip = getent( "axr_plt_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip solid();
        clip show();
    }
    
    platform_start.mdl = utility::spawn_model( %"mx_decor_tree_round_grate_01", platform_start.origin, platform_start.angles );
    clip.origin = platform_start.origin;
    clip linkto( platform_start.mdl );
    platform_start.mdl thread platform_move( platform_start.origin, platform_end.origin );
    level waittill( #"arcxd_racing_cleanup" );
    clip unlink();
    platform_start.mdl delete();
    
    if ( clip )
    {
        clip notsolid();
        clip hide();
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0x7d8caf72, Offset: 0x2ea9
// Size: 0x78
function platform_move( start, end )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level endon( #"arcxd_racing_cleanup" );
    
    while ( true )
    {
        self moveto( end, 5, 0.5, 0.5 );
        wait 5;
        wait 1;
        self moveto( start, 5, 0.5, 0.5 );
        wait 5;
        wait 1.5;
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xe0787a4e, Offset: 0x2f29
// Size: 0x1e
function function_a77ab1770ab2f1d6()
{
    if ( self.rank_trigger )
    {
        return self istouching( self.rank_trigger );
    }
    
    return 0;
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0xb5d74a1c, Offset: 0x2f50
// Size: 0x423
function toy_car_init( b_save_restored )
{
    level endon( #"game_ended" );
    level.arcxd_racing.var_f3801229fe540032 = utility::getstructarray( "arcxd_toy_car", "script_noteworthy" );
    level.arcxd_racing.var_f3801229fe540032 = arrayrandomize( level.arcxd_racing.var_f3801229fe540032 );
    level.var_8b90db5d524d6af2 = [ #"hash_164a97c8b4bd158f", #"hash_164a98c8b4bd1742", #"hash_164a99c8b4bd18f5" ];
    
    if ( b_save_restored )
    {
        level.arcxd_racing.attempt = zm_quest::function_73720cdf21c3cfd7( #"hash_74eea7ea11e2a755", #"hash_d32655d390623fa4" );
        
        if ( !isdefined( level.arcxd_racing.attempt ) )
        {
            level.arcxd_racing.attempt = 0;
        }
        
        level.arcxd_racing.var_dea9e167df26bcb3 = zm_quest::function_73720cdf21c3cfd7( #"hash_74eea7ea11e2a755", #"hash_7b8c9994f1985d36" );
        
        if ( !isdefined( level.arcxd_racing.var_dea9e167df26bcb3 ) )
        {
            level.arcxd_racing.var_dea9e167df26bcb3 = 0;
        }
        
        if ( level.arcxd_racing.attempt >= 3 )
        {
            return;
        }
        
        var_63ebff8f30a9bcf2 = [];
        
        foreach ( toy_car_slot in level.var_8b90db5d524d6af2 )
        {
            toy_car_num = zm_quest::function_73720cdf21c3cfd7( #"hash_74eea7ea11e2a755", toy_car_slot );
            
            foreach ( toy_car in level.arcxd_racing.var_f3801229fe540032 )
            {
                if ( toy_car_num == int( toy_car.script_int ) )
                {
                    var_63ebff8f30a9bcf2[ var_63ebff8f30a9bcf2.size ] = toy_car;
                    break;
                }
            }
        }
        
        level.arcxd_racing.var_f3801229fe540032 = var_63ebff8f30a9bcf2;
    }
    
    for ( i = 0; i < level.arcxd_racing.var_f3801229fe540032.size ; i++ )
    {
        zm_quest::function_4eefe6de31f5ddab( #"hash_74eea7ea11e2a755", level.var_8b90db5d524d6af2[ i ], int( level.arcxd_racing.var_f3801229fe540032[ i ].script_int ) );
    }
    
    foreach ( toy_car in level.arcxd_racing.var_f3801229fe540032 )
    {
        toy_car.scriptable = spawnscriptable( "sat_zm_arcxd_racing_starter", toy_car.origin, toy_car.angles );
        toy_car.interact = interaction::register_interact( toy_car.origin, 100, &function_674aacf46c6db5ae );
        toy_car.interact setusefov( 120 );
        toy_car.interact interaction::set_interact_hint_callback( &toy_car_hint_callback );
        toy_car.interact.s_toy_car = toy_car;
        toy_car.interact disableplayeruseforallplayers();
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0xb99e606c, Offset: 0x337b
// Size: 0x1ad
function function_674aacf46c6db5ae( player )
{
    if ( player.interactions_disabled )
    {
        return;
    }
    
    if ( !level.boat_racing.var_d935a37e545d5b07 && !utility::flag( "arcxd_racing_voting" ) && function_d91a63332f0a88b3() )
    {
        params = spawnstruct();
        params.timestamp = gettime();
        params.var_be82617e5e8087bd = [ player ];
        params.questname = #"hash_4bfb1e1d1b7518e2";
        params.event = #"zm_sq_quest_complete";
        level callback::callback( "zm_sq_quest_complete", params );
        utility::flag_set( "arcxd_racing_voting" );
        var_3faf858e79cd17bb = spawnstruct();
        var_3faf858e79cd17bb.init_message = &"hash_368ffead421750f5";
        var_3faf858e79cd17bb.description = &"hash_7e85ae790bf177fa";
        function_8a3a5640f8c47aac( 0 );
        b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb );
        
        if ( b_passed && function_d91a63332f0a88b3() )
        {
            level thread battlechatter_mp::trysaylocalsound( player, #"hash_5212ed7ec42f115a" );
            function_b9fd27dcc5e5a116();
            utility::flag_set( "arecxd_racing_active" );
            disable_toy_car( self.s_toy_car );
            level.arcxd_racing.var_d935a37e545d5b07 = 1;
            level notify( #"arcxd_racing_start" );
            level val::set( "arcxd_race_tasks", "task_logic_activate", 0 );
        }
        
        utility::delaythread( 2, &function_8a3a5640f8c47aac, 1 );
        utility::flag_clear( "arcxd_racing_voting" );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0xe2fc7a06, Offset: 0x3530
// Size: 0x9a
function function_8a3a5640f8c47aac( var_f1fbc291f2430b1e )
{
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        player val::set( "arcxd_racing", "killstreaks", var_f1fbc291f2430b1e );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x71fe4ca0, Offset: 0x35d2
// Size: 0xd8, Type: bool
function function_d91a63332f0a88b3()
{
    if ( zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
    {
        return false;
    }
    
    if ( !zm_quest::function_f98968f17772726c( 0, [ "arcxd_racing_voting" ] ) )
    {
        return false;
    }
    
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            if ( player.ismutantinjection )
            {
                return false;
            }
        }
    }
    
    if ( utility::flag( "zm_vote_active" ) || utility::flag( "exfil_active" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0xfc0c2e42, Offset: 0x36b3
// Size: 0x36
function toy_car_hint_callback( usable, player )
{
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0x6e08ff0d, Offset: 0x36f2
// Size: 0x50
function disable_toy_car( toy_car )
{
    toy_car.interact disableplayeruseforallplayers();
    toy_car.scriptable setscriptablepartstate( "model", "hide" );
    toy_car.scriptable setscriptablepartstate( "fx", "despawn" );
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0x77bdddb7, Offset: 0x374a
// Size: 0x50
function enable_toy_car( toy_car )
{
    toy_car.interact enableplayeruseforallplayers();
    toy_car.scriptable setscriptablepartstate( "model", "show" );
    toy_car.scriptable setscriptablepartstate( "fx", "spawn" );
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0xe0cf8571, Offset: 0x37a2
// Size: 0x177
function function_60457ba2eeb608e8( owner, spawn_origin )
{
    level endon( #"game_ended" );
    start_blocker = utility::spawn_model( "sat_zm_drone_arcxd_box", spawn_origin.origin, spawn_origin.angles );
    
    if ( level.var_5d45eba3b2a7c833 )
    {
        level.var_5d45eba3b2a7c833[ level.var_5d45eba3b2a7c833.size ] = start_blocker;
    }
    
    streakitem = killstreaks::createstreakitemstruct( "rcxd" );
    streakitem.available = 1;
    streakitem.quantity = 1;
    streakinfo = killstreak_utility::createstreakinfo( "rcxd", owner );
    streakinfo.mpstreaksysteminfo = streakitem;
    rcxd = rcxd_shared::creatercxd( "rcxd", owner, streakinfo, spawn_origin.origin );
    rcxd.maxhealth = 100;
    rcxd.health = 100;
    rcxd.currenthealth = 100;
    rcxd.lifetime = 999;
    
    if ( !isdefined( rcxd ) )
    {
        return;
    }
    
    owner function_7d86615e41f3b63f( rcxd );
    rcxd vehicle_teleport( rcxd.origin, spawn_origin.angles );
    owner.arcxd_racing_veh = rcxd;
    owner setclientomnvar( "ui_killstreak_lifetime", 1 );
    rcxd thread rcxd_shared::function_899aef7aa02b06ec();
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0x8f97b898, Offset: 0x3921
// Size: 0x1e4
function function_7d86615e41f3b63f( rcxd )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( utility::isusingremote() )
    {
        player::clearusingremote();
    }
    
    player::setusingremote( rcxd.streakinfo.streakname );
    self.restoreangles = self getplayerangles();
    rcxd vehicle_damage::set_can_damage( 0 );
    data = spawnstruct();
    data.deathoverridecallback = &rcxd_shared::function_86ce53096e8db304;
    rcxd thread namespace_9d8e359c3b1041e5::handlemovingplatformssharedfunc( data );
    rcxd setotherent( self );
    rcxd.driver = self;
    rcxd.ispiloted = 1;
    self unlink();
    
    if ( rcxd.empcount > 0 )
    {
        namespace_9d8e359c3b1041e5::freezelookcontrolssharedfunc( 1 );
    }
    else
    {
        self usevehicle( rcxd, 0 );
    }
    
    rcxd.controlslinked = 1;
    self painvisionoff();
    killstreak_shared::killstreak_savenvgstate();
    rcxd.starttime = gettime();
    rcxd.endtime = rcxd.starttime + int( rcxd.lifetime * 1000 );
    self setclientomnvar( "ui_killstreak_countdown", rcxd.endtime );
    self setclientomnvar( "ui_killstreak_health", 1 );
    self setclientomnvar( "ui_killstreak_damage_state", 0 );
    namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( rcxd.streakinfo.streakname, "on" );
    killstreak_shared::function_9fc2f7ee10890d99( "rcxd" );
    shellshock_utility::_stopshellshock();
    val::set( "rcxd", "shellshock", 0 );
    namespace_9d8e359c3b1041e5::registerentforoobsharedfunc( rcxd, "killstreak" );
    function_3d87a59a4ab8b451();
    val::set( "rcxd_spawn", "player_for_spawn_logic", 0 );
    namespace_9d8e359c3b1041e5::addspawnviewersharedfunc( rcxd );
    namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0x7614638, Offset: 0x3b0d
// Size: 0x42
function function_ec734ab67c642dc1( arcxd )
{
    self endon( #"disconnect" );
    
    if ( utility::isusingremote() )
    {
        player::clearusingremote();
    }
    
    rcxd_shared::function_97ec301a6784838a( arcxd );
    self.arcxd_racing_veh = undefined;
    arcxd delete();
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0xd7974616, Offset: 0x3b57
// Size: 0x303
function function_4b5380805b55c916( first_place_player )
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            continue;
        }
        
        player utility::function_d5a54acde3e473ca( 1 );
    }
    
    wait 0.5;
    fade_to_black_for_all( 0, 0.1 );
    level thread function_fe70f17765654562( first_place_player );
    ending_scene();
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            continue;
        }
        
        player.reward_index = player function_631b876832782221();
        trophy_scriptable = level.arcxd_racing.var_d9906d678f78a3fa[ player.reward_index ].trophy;
        mdl_trophy = spawnscriptable( trophy_scriptable, player.var_cbc39ccf0c9580a5.origin, player.var_cbc39ccf0c9580a5.angles );
        waitframe();
        
        if ( !player )
        {
            continue;
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            continue;
        }
        
        player utility::function_d5a54acde3e473ca( 0 );
        params = spawnstruct();
        params.scoreevent = level.arcxd_racing.var_d9906d678f78a3fa[ player.reward_index ].score_event;
        player callback::callback( "zombie_score_event", params );
        
        if ( isdefined( mdl_trophy ) )
        {
            mdl_trophy utility::function_32b24db3127bff40( "base", "default" );
            mdl_trophy utility::function_32b24db3127bff40( "owner_fx", level.arcxd_racing.var_396cce885f7c3331[ player.sessionuimemberindex ] );
            mdl_trophy.cache_interact = function_283f0d18e4feccb1( mdl_trophy, player );
            mdl_trophy thread trophy_cleanup_watcher( player );
            mdl_trophy thread trophy_timeout_watcher( player );
            mdl_trophy thread function_fcced499f0d7aa8f();
        }
        
        player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0x288ba68, Offset: 0x3e62
// Size: 0x38
function function_fe70f17765654562( first_place_player )
{
    level endon( #"game_ended" );
    
    if ( first_place_player )
    {
        first_place_player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"arcxd_racing_finish", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0x623517c1, Offset: 0x3ea2
// Size: 0xa2
function fade_to_black_for_all( var_1081d16c40304bd0, time = 0 )
{
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        level thread game_utility::fadetoblackforplayer( player, var_1081d16c40304bd0, time );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0x4becf282, Offset: 0x3f4c
// Size: 0xe0
function function_283f0d18e4feccb1( trophy, player )
{
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_arcxd_ee_rewards", string( player.reward_index ) );
    interact = function_5e615e25b6e4d9dd( trophy.origin, var_8b5270de14dff72e, player, 2 );
    
    foreach ( unknown_player in level.players )
    {
        if ( unknown_player && unknown_player != player )
        {
            interact disableplayeruse( unknown_player );
        }
    }
    
    return interact;
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 4
// Checksum 0x39a62482, Offset: 0x4035
// Size: 0x18d
function function_5e615e25b6e4d9dd( position, var_8b5270de14dff72e, player, item_count )
{
    inventory_group = %"hash_30d1f71d3877d096";
    interact = common_cache::function_74364c32a1e82886( inventory_group, position, 50, &function_89993741a2bfbd11 );
    common_cache::function_61ef9e0b74e10aaf( interact.cache, var_8b5270de14dff72e );
    interact sethintonobstruction( "show" );
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        item_name = var_8b5270de14dff72e[ i ];
        weapondata = undefined;
        
        if ( common_item::function_3cba34a99d02cd9( item_name ) == "weapon" )
        {
            scriptbundlestruct = getscriptbundlefieldvalues( item_name, [ #"baseweapon", #"rarity" ] );
            weaponname = scriptbundlestruct.baseweapon;
            rarity = scriptbundlestruct.rarity;
            favoriteweapon = player weaponmetadata::function_c68204eff69ed046( weaponname );
            
            if ( isdefined( favoriteweapon ) )
            {
                item_name = item_weapon::function_3da93a43aae4473d( favoriteweapon.basename, rarity );
                weapondata = item_weapon::function_fdc74b9be99fda2f( favoriteweapon );
                weapondata.rarity = rarity;
                weapondata.weaponobj = favoriteweapon;
            }
        }
        
        skipomnvars = !isdefined( weapondata );
        common_cache::function_990ee9d9acd2d1d5( interact.cache, player, item_name, undefined, skipomnvars, undefined, weapondata );
    }
    
    return interact;
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 2
// Checksum 0xc6ff14c6, Offset: 0x41cb
// Size: 0x40
function function_89993741a2bfbd11( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"shared_hintstrings/open_cache", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0x55376f30, Offset: 0x4214
// Size: 0x72
function trophy_cleanup_watcher( owner )
{
    level endon( #"game_ended" );
    owner endon( #"death" );
    level endon( #"hash_6ad271a7e306f8a9" );
    
    while ( isdefined( self ) && isdefined( self.cache_interact ) )
    {
        if ( common_cache::iscontainerempty( self.cache_interact.cache ) )
        {
            break;
        }
        
        wait 0.5;
    }
    
    cleanup_trophy();
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0x2c5553c3, Offset: 0x428e
// Size: 0x61
function trophy_timeout_watcher( owner )
{
    level endon( #"game_ended" );
    owner endon( #"death" );
    self endon( #"death" );
    self endon( #"hash_d7aeb953c169e549" );
    wait 30;
    level notify( #"hash_6ad271a7e306f8a9" );
    owner notify( #"hash_8a8ef4559547679b" );
    waitframe();
    cleanup_trophy();
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x39ea668a, Offset: 0x42f7
// Size: 0x67
function cleanup_trophy()
{
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "base", "kill" );
        
        if ( isdefined( self.root ) )
        {
            self.root delete();
        }
        
        if ( isdefined( self.cache_interact ) )
        {
            self.cache_interact notify( #"death" );
            self.cache_interact delete();
        }
        
        self freescriptable();
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x95209cec, Offset: 0x4366
// Size: 0x88
function function_fcced499f0d7aa8f()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait_time = randomfloat( 1 );
    wait wait_time;
    
    if ( isdefined( self ) )
    {
        if ( !isdefined( self.root ) )
        {
            self.root = utility::spawn_model( "tag_origin", self.origin, self.angles );
            waitframe();
            self scriptablesetparententity( self.root );
        }
        
        self.root thread do_floating();
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xa62ed00c, Offset: 0x43f6
// Size: 0x70
function do_floating()
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self movez( 5, 1, 0.5, 0.5 );
        self waittill( #"movedone" );
        self movez( -5, 1, 0.5, 0.5 );
        self waittill( #"movedone" );
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xb3be1db1, Offset: 0x446e
// Size: 0xbb
function function_631b876832782221()
{
    if ( !self.arcxd_racing_finish_time )
    {
        return ( level.arcxd_racing.var_d9906d678f78a3fa.size - 1 );
    }
    
    for ( i = 0; i < level.arcxd_racing.var_d9906d678f78a3fa.size ; i++ )
    {
        reward = level.arcxd_racing.var_d9906d678f78a3fa[ i ];
        
        if ( self.arcxd_racing_finish_time < level.arcxd_racing.var_d9906d678f78a3fa[ i ].time_usage )
        {
            return i;
        }
    }
    
    return level.arcxd_racing.var_d9906d678f78a3fa.size - 1;
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0xd7605e9b, Offset: 0x4532
// Size: 0x8f
function ending_scene()
{
    level endon( #"game_ended" );
    mdl_bunny = utility::spawn_model( %"t10_zm_mystery_box_plinth_bunny_fxanim", ( 0, 0, 0 ) );
    s_scene_node = utility::getstruct( "arcxd_racing_ending_scene", "script_noteworthy" );
    s_scene_node thread scene::play( mdl_bunny, "shot_ending" );
    mdl_bunny utility::delaycall( 0.1, &playsound, "evt_arcxd_bunny_ending_appear" );
    n_scene_duration = s_scene_node scene::function_b3c7b792a7a154fa( "shot_ending" );
    wait n_scene_duration;
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0, eflags: 0x4
// Checksum 0x799765b6, Offset: 0x45c9
// Size: 0x85
function private function_3d87a59a4ab8b451()
{
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    fullscreenfxparams = { #visionset:bundle.var_28b586ad7dc362cb ?? "killstreak_rcxd_drive", #postfxbundlename:bundle.var_1f1feedfdba0656d };
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 0
// Checksum 0x1f8e831a, Offset: 0x4656
// Size: 0xb3
function function_e185f2a7d4e2900a()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"arcxd_racing_finish" );
    self.var_a5c5fa83303b533a = gettime();
    veh = self.arcxd_racing_veh;
    
    while ( isdefined( self ) && isdefined( veh ) )
    {
        attackbuttoncur = 0;
        var_95ddbb5eccdfd7d8 = veh function_e4c70df6ddff5c2d() == 0;
        
        if ( var_95ddbb5eccdfd7d8 && self usinggamepad() )
        {
            attackbuttoncur = self fragbuttonpressed() || self usebuttonpressed();
        }
        else
        {
            attackbuttoncur = self attackbuttonpressed() || self usebuttonpressed();
        }
        
        if ( attackbuttoncur )
        {
            reset_vehicle( veh );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_arcxd_racing_quest
// Params 1
// Checksum 0x5f3a531f, Offset: 0x4711
// Size: 0x126
function reset_vehicle( veh )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) || !isdefined( self.var_267f8f90b084fd4b ) )
    {
        return;
    }
    
    if ( isdefined( veh ) && gettime() - self.var_a5c5fa83303b533a >= 1500 )
    {
        veh endon( #"death" );
        self.var_a5c5fa83303b533a = gettime();
    }
    else
    {
        return;
    }
    
    if ( isdefined( self.var_267f8f90b084fd4b.origin ) )
    {
        veh vehicle_setspeed( 0 );
        playfx( utility::getfx( "arcxd_racing_reset_despawn" ), veh.origin, veh.angles );
        veh vehicle_teleport( self.var_267f8f90b084fd4b.origin + ( 0, 0, 40 ), self.var_267f8f90b084fd4b.angles );
        waitframe();
        veh vehicle_setspeed( 0 );
        playfx( utility::getfx( "arcxd_racing_reset_spawn" ), veh.origin, veh.angles );
    }
}

/#

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0x94846b32, Offset: 0x483f
    // Size: 0x17a, Type: dev
    function setup_arcxd_racing_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x35>", "<dev string:x40>", &function_140d2e1b75c741a5 );
        devgui::add_devgui_func( "<dev string:x4b>", "<dev string:x56>", &function_b479f8eb2c8dae5d );
        devgui::add_devgui_func( "<dev string:x61>", "<dev string:x75>", &function_ee5fcedad676480c );
        devgui::add_devgui_func( "<dev string:x89>", "<dev string:x9d>", &function_552d99623ceb92af );
        devgui::add_devgui_func( "<dev string:xab>", "<dev string:xc0>", &function_f18fe22d8375b89d );
        devgui::add_devgui_func( "<dev string:xc8>", "<dev string:xde>", &function_935cc7fa1cd65579, 1 );
        devgui::add_devgui_func( "<dev string:xf2>", "<dev string:x107>", &debug_moving_platform );
        devgui::add_devgui_func( "<dev string:x11c>", "<dev string:x129>", &function_b179aa43ddf904b7 );
        devgui::add_devgui_func( "<dev string:x136>", "<dev string:x142>", &function_41f6e6a29bf77c61 );
        devgui::add_devgui_func( "<dev string:x14e>", "<dev string:x15b>", &debug_start_arcxd_racing );
        devgui::add_devgui_func( "<dev string:x168>", "<dev string:x170>", &debug_test_vo );
        devgui::add_devgui_func( "<dev string:x178>", "<dev string:x195>", &function_e4ec277796cebc10 );
        devgui::add_devgui_func( "<dev string:x1b2>", "<dev string:x1c1>", &function_4929cf1d247751e7 );
        devgui::add_devgui_func( "<dev string:x1d1>", "<dev string:x1df>", &function_4a5c89513e1da2cb );
        devgui::add_devgui_func( "<dev string:x1f4>", "<dev string:x205>", &function_4a774fe1cfc41619 );
        devgui::add_devgui_func( "<dev string:x216>", "<dev string:x238>", &debug_cleanup_killstreaks );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0x6158a773, Offset: 0x49c1
    // Size: 0xc9, Type: dev
    function function_140d2e1b75c741a5()
    {
        foreach ( player in level.players )
        {
            spawn_origin = spawnstruct();
            spawn_origin.origin = player.origin + ( 60, 0, 0 );
            spawn_origin.angles = player.angles;
            function_60457ba2eeb608e8( player, spawn_origin );
        }
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0xe23af302, Offset: 0x4a92
    // Size: 0x89, Type: dev
    function function_b479f8eb2c8dae5d()
    {
        foreach ( player in level.players )
        {
            player function_ec734ab67c642dc1( player.arcxd_racing_veh );
        }
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0x1acf30a7, Offset: 0x4b23
    // Size: 0x11, Type: dev
    function function_ee5fcedad676480c()
    {
        level notify( #"arcxd_racing_cleanup" );
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0x78e992a8, Offset: 0x4b3c
    // Size: 0x11, Type: dev
    function function_552d99623ceb92af()
    {
        level notify( #"hash_88accb6f320e9238" );
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0xa08adccd, Offset: 0x4b55
    // Size: 0x10d, Type: dev
    function function_f18fe22d8375b89d()
    {
        foreach ( player in level.players )
        {
            player zm_quest::function_fba942a1cfd85f5d( 1, 0, #"hash_74eea7ea11e2a755", #"race_start" );
            player zm_quest::function_fb3af5600f6a9441( 1, 0, #"hash_74eea7ea11e2a755", #"race_start" );
            player zm_quest::function_612a9ad0db22c29c( 90000, 0, #"hash_74eea7ea11e2a755", #"race_start" );
            player zm_quest::function_194bde735238c397( 0, 0, #"hash_74eea7ea11e2a755", #"race_start" );
            player zm_quest::function_9f49b2a045ece8ae( 1, 0, #"hash_74eea7ea11e2a755", #"race_start" );
        }
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0x6f837624, Offset: 0x4c6a
    // Size: 0x95, Type: dev
    function function_935cc7fa1cd65579()
    {
        level endon( #"game_ended" );
        
        while ( level.arcxd_racing.var_f3801229fe540032[ level.arcxd_racing.attempt ] )
        {
            location = level.arcxd_racing.var_f3801229fe540032[ level.arcxd_racing.attempt ].origin;
            sphere( location, 30, ( 0, 1, 0 ), 0, 1 );
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0xeb29e44, Offset: 0x4d07
    // Size: 0xd, Type: dev
    function debug_moving_platform()
    {
        level thread moving_platform_monitor();
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0xc378af9e, Offset: 0x4d1c
    // Size: 0x2a, Type: dev
    function function_b179aa43ddf904b7()
    {
        player = level.players[ 0 ];
        player playsoundtoplayer( "<dev string:x25a>", player );
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0xd2342425, Offset: 0x4d4e
    // Size: 0x23b, Type: dev
    function function_41f6e6a29bf77c61()
    {
        level endon( #"game_ended" );
        player = level.players[ 0 ];
        var_7040d8210019b7c = spawnscriptable( %"sat_zm_arcxd_racing_trophy_1st", player.origin + ( 0, 30, 0 ), player.angles );
        var_70410821001a215 = spawnscriptable( %"sat_zm_arcxd_racing_trophy_2nd", player.origin + ( 0, 60, 0 ), player.angles );
        var_7040f8210019fe2 = spawnscriptable( %"sat_zm_arcxd_racing_trophy_3rd", player.origin + ( 0, 90, 0 ), player.angles );
        var_7040a82100194e3 = spawnscriptable( %"sat_zm_arcxd_racing_trophy_4th", player.origin + ( 0, 120, 0 ), player.angles );
        waitframe();
        var_7040d8210019b7c thread function_fcced499f0d7aa8f();
        var_7040d8210019b7c utility::function_32b24db3127bff40( "<dev string:x27a>", "<dev string:x27f>" );
        var_7040d8210019b7c utility::function_32b24db3127bff40( "<dev string:x287>", level.arcxd_racing.var_396cce885f7c3331[ 0 ] );
        var_70410821001a215 thread function_fcced499f0d7aa8f();
        var_70410821001a215 utility::function_32b24db3127bff40( "<dev string:x27a>", "<dev string:x27f>" );
        var_70410821001a215 utility::function_32b24db3127bff40( "<dev string:x287>", level.arcxd_racing.var_396cce885f7c3331[ 1 ] );
        var_7040f8210019fe2 thread function_fcced499f0d7aa8f();
        var_7040f8210019fe2 utility::function_32b24db3127bff40( "<dev string:x27a>", "<dev string:x27f>" );
        var_7040f8210019fe2 utility::function_32b24db3127bff40( "<dev string:x287>", level.arcxd_racing.var_396cce885f7c3331[ 2 ] );
        var_7040a82100194e3 thread function_fcced499f0d7aa8f();
        var_7040a82100194e3 utility::function_32b24db3127bff40( "<dev string:x27a>", "<dev string:x27f>" );
        var_7040a82100194e3 utility::function_32b24db3127bff40( "<dev string:x287>", level.arcxd_racing.var_396cce885f7c3331[ 3 ] );
        wait 20;
        var_7040d8210019b7c cleanup_trophy();
        var_70410821001a215 cleanup_trophy();
        var_7040f8210019fe2 cleanup_trophy();
        var_7040a82100194e3 cleanup_trophy();
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0xd91cea03, Offset: 0x4f91
    // Size: 0x43, Type: dev
    function debug_start_arcxd_racing()
    {
        toy_car = level.arcxd_racing.var_f3801229fe540032[ 0 ];
        toy_car.interact function_674aacf46c6db5ae( level.players[ 0 ] );
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0xef87a310, Offset: 0x4fdc
    // Size: 0x3f, Type: dev
    function debug_test_vo()
    {
        level endon( #"game_ended" );
        function_ce23d37d35308fb9();
        wait 3;
        level.players[ 0 ] namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"arcxd_racing_finish", #"bc_flavor_player_positive" );
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0x880dfb14, Offset: 0x5023
    // Size: 0x1af, Type: dev
    function function_e4ec277796cebc10()
    {
        player = level.players[ 1 ];
        veh = player.arcxd_racing_veh;
        
        if ( level.arcxd_racing.b_is_active && veh vehicle::is_vehicle() && isplayer( player ) && !player.var_5dbaf6674c071204 )
        {
            player.var_5dbaf6674c071204 = 1;
            player.arcxd_racing_finish_time = gettime() - level.arcxd_racing.start_time;
            player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hash_74eea7ea11e2a755", #"race_start" );
            player notify( #"arcxd_racing_finish" );
            player playlocalsound( "<dev string:x290>" );
            var_d13a88f94e638ef3 = 1;
            
            foreach ( other_player in level.players )
            {
                if ( isalive( other_player ) && other_player.var_27be9bb33ddb8efc && !other_player.var_5dbaf6674c071204 )
                {
                    var_d13a88f94e638ef3 = 0;
                    break;
                }
            }
            
            if ( var_d13a88f94e638ef3 )
            {
                level notify( #"hash_88accb6f320e9238" );
                return;
            }
            
            player function_ec734ab67c642dc1( player.arcxd_racing_veh );
            player zm_live_spectate::function_5647f60a40d71849();
        }
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0x6cdfde00, Offset: 0x51da
    // Size: 0x17, Type: dev
    function function_4929cf1d247751e7()
    {
        level.players[ 0 ] zm_live_spectate::function_5647f60a40d71849();
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0xa8ed1623, Offset: 0x51f9
    // Size: 0x17, Type: dev
    function function_4a5c89513e1da2cb()
    {
        level.players[ 0 ] zm_live_spectate::function_794d0c5793d9aed3();
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0xd42ed999, Offset: 0x5218
    // Size: 0xd, Type: dev
    function debug_cleanup_killstreaks()
    {
        level thread function_bae25b627bb8c043();
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 0
    // Checksum 0x5322ca3b, Offset: 0x522d
    // Size: 0x88, Type: dev
    function function_4a774fe1cfc41619()
    {
        player = level.players[ 0 ];
        player.reward_index = 0;
        test_num = 300;
        function_eb2cc8088d98155c( player, test_num );
        player.reward_index = 1;
        function_eb2cc8088d98155c( player, test_num );
        player.reward_index = 2;
        function_eb2cc8088d98155c( player, test_num );
        player.reward_index = 3;
        function_eb2cc8088d98155c( player, test_num );
    }

    // Namespace zm_sat_firefly_arcxd_racing_quest
    // Params 2, eflags: 0x4
    // Checksum 0xf66f2775, Offset: 0x52bd
    // Size: 0xb4, Type: dev
    function private function_eb2cc8088d98155c( player, test_num )
    {
        for ( i = 0; i < test_num ; i++ )
        {
            var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "<dev string:x2ad>", string( player.reward_index ) );
            interact = function_5e615e25b6e4d9dd( player.origin + ( 30, 0, 40 ), var_8b5270de14dff72e, player, 2 );
            waitframe();
            
            if ( isdefined( interact ) )
            {
                common_cache::function_7afda593c8230cf4( interact.cache, player );
                interact notify( #"death" );
                interact delete();
            }
            
            waitframe();
        }
    }

#/
