// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis.gsc  (hash_7c8eac47648e6881.gscc) (size: 24069 Bytes / 0x5e05 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf325f04d (4079349837)
// size ...... 24069 (0x5e05)
// includes .. 25  (offset: 0x54f1)
// strings ... 135 (offset: 0x55b9)
// dev strs .. 16  (offset: 0x5d31)
// exports ... 44  (offset: 0x3c19)
// cseg ...... 0xaf6 + 0x3123 (0x3c19)
// imports ... 141 (offset: 0x42f9)
// animtree1 . 0   (offset: 0x5e05)
// animtree2 . 0   (offset: 0x5e05)
#using script_5260134e41589c6e;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scripted_widgets;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\electric_power_switch;
#using scripts\mp\load;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_audio;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_boss_fight;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_fx;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_lighting;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_quest_mq;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_radiation_cloud;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_script_game_over_scenes_create_script;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_accelerant;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\traps\electro_shock_trap;

#namespace zm_sat_mantis;

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xec62458d, Offset: 0xb14
// Size: 0x3ce
function main()
{
    zm_sat_mantis_art::main();
    zm_sat_mantis_audio::main();
    zm_sat_mantis_fx::main();
    zm_sat_mantis_lighting::main();
    zm_sat_mantis_radiation_cloud::main();
    zm_vo::function_c0b0828d1107c141( undefined, 1 );
    load::main();
    compass::setupminimap( "compass_map_zm_sat_mantis" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    setdvarifuninitialized( @"hash_bb4d4e9d5661c0f9", 0 );
    level.ttlos_suppressasserts = 1;
    level.var_41b52e54c6e6ac2c = &function_791601c1d3d804e9;
    level thread zm_round_spawning::function_c134fd55f45903e6( %"hash_3c513ee76e77f2c6" );
    level thread zm_round_accelerant::init_round_accelerant();
    level.vending_machines_powered_on_at_start = 1;
    electric_power_switch::function_2d462dbfcc76b0db( 1 );
    zm_sat_mantis_script_game_over_scenes_create_script::main();
    level thread electro_shock_trap::init();
    level thread function_28795cf8d887e305();
    level thread init_clock_hands();
    level thread mailbox_spawns();
    level thread function_6d7ba853093ced3b();
    level thread handle_dynamic_traversal();
    level thread function_c682e94af51a3ee7();
    level thread function_9b5013bf1e6a6be4();
    level thread function_15e610769d64e7f();
    activateworldevent( "we_vfx_nuke_vista" );
    level thread function_b0403080fa98cfa2();
    level thread function_dd911324c56a9f26( "door_cul_to_truck_f" );
    level thread function_946ccb0df66e0d8d( "door_cul_to_truck_p" );
    level thread init_lost_soul_zombie();
    level thread function_f35e4a6ef1b4545b();
    level thread function_18d7a0868d0f3dc0();
    level thread init_cars_navmesh();
    function_97f071991b379f23( 1 );
    
    /#
        level devgui_mantis();
    #/
    
    level.var_59f211cd543ad7ea = [ "zone_backyard1_b_p", "zone_backyard2_b_p", "zone_backyard1_a_p", "zone_backyard2_a_p", "zone_culdesac_1_p", "zone_culdesac_2_p", "zone_culdesac_3_p", "zone_culdesac_4_p", "zone_street_1_p", "zone_street_2_p", "zone_street_3_p", "zone_street_4_p", "zone_street_5_p", "zone_street_6_p", "zone_street_7_p", "zone_house1_garage_p", "zone_house1_downstairs_p", "zone_house1_upstairs_p", "zone_house2_garage_p", "zone_house2_downstairs_p", "zone_house2_upstairs_p", "zone_truck_top_p", "zone_truck_p", "zone_bus_top_p", "zone_deck1_p", "zone_deck2_p" ];
    level.var_1b3c422d98197927 = [ "zone_backyard1_b_f", "zone_backyard2_b_f", "zone_backyard1_a_f", "zone_backyard2_a_f", "zone_culdesac_1_f", "zone_culdesac_2_f", "zone_culdesac_3_f", "zone_culdesac_4_f", "zone_street_1_f", "zone_street_2_f", "zone_street_3_f", "zone_street_4_f", "zone_street_5_f", "zone_street_6_f", "zone_street_7_f", "zone_house1_garage_f", "zone_house1_downstairs_f", "zone_house1_upstairs_f", "zone_house2_garage_f", "zone_house2_downstairs_f", "zone_house2_upstairs_f", "zone_truck_top_f", "zone_truck_f", "zone_bus_top_f", "zone_deck1_f", "zone_deck2_f" ];
    utility::registersharedfunc( #"hash_be7eb02741915d95", #"hash_be7eb02741915d95", &function_8990be05f8594a2c );
    utility::registersharedfunc( #"hash_1d7f6cc83b109f24", #"hash_1d7f6cc83b109f24", &function_c890b7670ca21799 );
    utility::registersharedfunc( #"survival_mode", #"hash_f09f680a0b4acd00", &function_67dce7c33a01cd09 );
    level callback::add( "on_zombie_methone_spawned", &function_5823a84d39a2f4e2 );
}

// Namespace zm_sat_mantis
// Params 1, eflags: 0x4
// Checksum 0xafaa995c, Offset: 0xeea
// Size: 0x19
function private function_5823a84d39a2f4e2( params )
{
    self enabletraversals( 1, "dog" );
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xda1a6ca1, Offset: 0xf0b
// Size: 0xda
function init_lost_soul_zombie()
{
    level endon( #"game_ended" );
    level._effect[ "lost_soul_orb" ] = loadfxasset( "vfx_sat_levels_zm_mantis_mq_energy_ball" );
    level._effect[ "piano_teacher_despawn" ] = loadfxasset( "vfx_sat_levels_zm_mantis_music_sheet_piano_teacher_despawn" );
    level utility::flag_wait( "begin_round_logic" );
    var_7bb7f76253ce460a = utility::getstructarray( "lost_soul_fire_start_pos" );
    
    foreach ( pos in var_7bb7f76253ce460a )
    {
        pos thread zm_sat_mantis_quest_mq::function_c442449c28833212( 3, 10, 15 );
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x6c8b4eb7, Offset: 0xfed
// Size: 0x113
function function_c682e94af51a3ee7()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    set_boss_fight_clips( 0 );
    var_6f062f6b6dd39249 = getentarray( "mw_ee_clip", "script_noteworthy" );
    
    if ( var_6f062f6b6dd39249 )
    {
        foreach ( mw_ee_clip in var_6f062f6b6dd39249 )
        {
            mw_ee_clip connectpaths();
            mw_ee_clip notsolid();
            mw_ee_clip hide();
        }
    }
    
    clip = getent( "scarf_mannequin_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip connectpaths();
        clip notsolid();
    }
    
    clip = getent( "lost_key_crate_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip connectpaths();
        clip notsolid();
    }
    
    zm_sat_mantis_boss_fight::function_908d83d7abfab440();
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xf5966c39, Offset: 0x1108
// Size: 0xef
function function_9b5013bf1e6a6be4()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    var_ebf5dd32e0a9ded3 = utility::getent_or_struct_array( "pap_collision", "script_noteworthy" );
    
    if ( !isdefined( var_ebf5dd32e0a9ded3 ) || var_ebf5dd32e0a9ded3.size <= 0 )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        return;
    }
    
    foreach ( brushmodel_collision_ent in var_ebf5dd32e0a9ded3 )
    {
        if ( !isdefined( brushmodel_collision_ent ) )
        {
            continue;
        }
        
        if ( brushmodel_collision_ent.classname == "script_brushmodel" )
        {
            brushmodel_collision_ent connectpaths();
            brushmodel_collision_ent hide();
            brushmodel_collision_ent hide();
        }
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x28fa1ad4, Offset: 0x11ff
// Size: 0xbe
function function_15e610769d64e7f()
{
    if ( getdvarint( @"hash_ae6d72cc003b6461", 1 ) >= 0 )
    {
        teleport_room_structs = utility::getstructarray( "teleport_room", "targetname" );
        
        foreach ( struct in teleport_room_structs )
        {
            struct.origin += ( 20000, 0, 0 );
        }
    }
}

// Namespace zm_sat_mantis
// Params 0, eflags: 0x4
// Checksum 0x4c8ba74f, Offset: 0x12c5
// Size: 0x9e
function private function_6d7ba853093ced3b()
{
    utility::flag_wait( "subclass_to_aitype_map_initialized" );
    zone_spawner::function_eeee6cc39266a2a3( { #target:"zone_backyard2_b_f", #script_animation:"spawn", #script_noteworthy:"zombie_base|zombie_base_armored_light|zombie_base_armored_heavy", #origin:( 55870, -31958, -109 ) } );
    zone_spawner::function_eeee6cc39266a2a3( { #target:"zone_backyard2_b_p", #script_animation:"spawn", #script_noteworthy:"zombie_base|zombie_base_armored_light|zombie_base_armored_heavy", #origin:( 78381, -31975, -109 ) } );
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xc25cd262, Offset: 0x136b
// Size: 0xa1
function handle_dynamic_traversal()
{
    var_95b6d59473871cdb = getnodearray( "dynamic_traversal", #script_noteworthy );
    
    if ( var_95b6d59473871cdb.size < 0 )
    {
        return;
    }
    
    foreach ( var_85b597ea50b4bcc7 in var_95b6d59473871cdb )
    {
        function_30dc1efdafe7681e( var_85b597ea50b4bcc7, 0 );
        var_85b597ea50b4bcc7 thread function_f1115d0c53240e07();
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x9d692d30, Offset: 0x1414
// Size: 0x32
function function_f1115d0c53240e07()
{
    level endon( #"game_ended" );
    
    if ( self.script_flag_wait )
    {
        utility::flag_wait( self.script_flag_wait );
    }
    
    function_30dc1efdafe7681e( self, 1 );
}

// Namespace zm_sat_mantis
// Params 1
// Checksum 0xc2b8a468, Offset: 0x144e
// Size: 0x263
function function_97f071991b379f23( var_94df53508b7a5a75 )
{
    if ( ( var_94df53508b7a5a75 ?? 0 ) == ( level.var_ccc6013a81b23680 ?? 0 ) )
    {
        return;
    }
    
    level.var_ccc6013a81b23680 = var_94df53508b7a5a75 ?? 0;
    
    if ( var_94df53508b7a5a75 )
    {
        clp_bus = getent( "bf_bus_nav_island", #script_noteworthy );
        clp_bus dockmovingplatform( undefined );
        clp_truck = getent( "bf_truck_nav_island", #script_noteworthy );
        clp_truck dockmovingplatform( undefined );
        clp_car = getent( "bf_car_nav_island", #script_noteworthy );
        
        if ( clp_car )
        {
            clp_car dockmovingplatform( undefined );
        }
    }
    else
    {
        clp_bus = getent( "bf_bus_nav_island", #script_noteworthy );
        clp_bus undockmovingplatform( undefined );
        clp_truck = getent( "bf_truck_nav_island", #script_noteworthy );
        clp_truck undockmovingplatform( undefined );
        clp_car = getent( "bf_car_nav_island", #script_noteworthy );
        
        if ( clp_car )
        {
            clp_car undockmovingplatform( undefined );
        }
    }
    
    var_10b0ce95e7e29116 = getnodearray( "traversals_hide_in_bossfight", #script_noteworthy );
    
    foreach ( start_node in var_10b0ce95e7e29116 )
    {
        end_node = getnode( start_node.target, "targetname" );
        n_start_offset = 0;
        n_end_offset = 0;
        
        if ( start_node.animscript == "traverse_warp_down" )
        {
            n_start_offset = 200;
            n_end_offset = 0;
        }
        else if ( start_node.animscript == "traverse_warp_up" )
        {
            n_start_offset = 0;
            n_end_offset = 200;
        }
        
        n_start_offset = start_node.script_int ?? n_start_offset;
        n_end_offset = end_node.script_int ?? n_end_offset;
        
        if ( var_94df53508b7a5a75 )
        {
            destroynavlink( start_node );
            createnavlink( start_node.target, start_node.origin + ( 0, 0, n_start_offset ), end_node.origin + ( 0, 0, n_end_offset ) );
            continue;
        }
        
        destroynavlink( start_node );
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x87c59a91, Offset: 0x16b9
// Size: 0x10b
function function_b0403080fa98cfa2()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"pre_timetravel_done" );
        current_timeline = level.timetravel.timeline.name;
        
        foreach ( player in level.players )
        {
            if ( player.is_timetraveling )
            {
                player waittill( #"timetravel_player_done" );
            }
            
            if ( current_timeline == "past" )
            {
                activateworldevent( "we_vfx_nuke_vista", 1, player );
                continue;
            }
            
            if ( current_timeline == "future" )
            {
                deactivateworldevent( "we_vfx_nuke_vista", 1, player );
            }
        }
    }
}

// Namespace zm_sat_mantis
// Params 1
// Checksum 0x404f1fb, Offset: 0x17cc
// Size: 0x21
function function_dd911324c56a9f26( flag_wait )
{
    utility::flag_wait( flag_wait );
    activateworldevent( "we_lgt_truck_future", 1 );
}

// Namespace zm_sat_mantis
// Params 1
// Checksum 0x7af80233, Offset: 0x17f5
// Size: 0x21
function function_946ccb0df66e0d8d( flag_wait )
{
    utility::flag_wait( flag_wait );
    activateworldevent( "we_lgt_truck_past", 1 );
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xa9f57a8d, Offset: 0x181e
// Size: 0x75
function function_f35e4a6ef1b4545b()
{
    if ( !getdvarint( @"hash_bb9c6e9d56b8b577", 0 ) )
    {
        return;
    }
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        return;
    }
    
    level._effect[ "dbee_cover_fx" ] = loadfxasset( "vfx_sat_levels_zm_firefly_fog_spawning" );
    level utility::flag_wait_all( "zm_quest_initialized", "scriptables_ready", "begin_round_logic" );
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_lost_key", #"hash_f5470ae7b63284be" ) != 1 )
    {
        level thread function_9c7cbc0a516037f5();
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xd21b50a5, Offset: 0x189b
// Size: 0x142
function function_9c7cbc0a516037f5()
{
    while ( true )
    {
        level waittill( #"timetravel_done", next_timeline );
        
        if ( utility::flag( "start_boss_fight" ) )
        {
            continue;
        }
        
        if ( level.var_1afbd4d6fe9ef1fe.current_time == "1:3" && next_timeline == "past" )
        {
            var_c620d7130d574875 = utility::getstruct( "sq_clock_reward_loc", "targetname" );
            des_struct = utility::getstruct( var_c620d7130d574875.target, "targetname" );
            level thread function_7090600b7759a94( var_c620d7130d574875.origin + ( 0, 0, 50 ), des_struct.origin );
            
            foreach ( player in level.players )
            {
                player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis
// Params 2
// Checksum 0xd8730372, Offset: 0x19e5
// Size: 0xc4
function function_7090600b7759a94( v_source_loc, var_54ab98a98b57d4a3 )
{
    level endon( #"game_ended" );
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_mantis_dbee_rewards", "default" );
    playfx( level._effect[ "dbee_cover_fx" ], v_source_loc );
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        if ( var_8b5270de14dff72e[ i ] )
        {
            random_point = getrandomnavpoint( var_54ab98a98b57d4a3, 100 ) + ( 0, 0, 4 );
            common_item::function_47324f290423b2d1( var_8b5270de14dff72e[ i ], v_source_loc, random_point, undefined, 1 );
            wait 0.1;
        }
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_lost_key", #"hash_f5470ae7b63284be", 1 );
}

// Namespace zm_sat_mantis
// Params 1
// Checksum 0x46b77b96, Offset: 0x1ab1
// Size: 0x11e
function function_8990be05f8594a2c( task_zone )
{
    current_timeline = level.timetravel.timeline.name;
    
    if ( !isdefined( current_timeline ) )
    {
        return 1;
    }
    
    foreach ( player in level.players )
    {
        if ( player.is_timetraveling )
        {
            player waittill( #"timetravel_player_done" );
        }
    }
    
    if ( current_timeline == "past" )
    {
        if ( arraycontains( level.var_59f211cd543ad7ea, task_zone.zone_name ) )
        {
            return 1;
        }
        
        return;
    }
    
    if ( current_timeline == "future" )
    {
        if ( arraycontains( level.var_1b3c422d98197927, task_zone.zone_name ) )
        {
            return 1;
        }
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x60512c03, Offset: 0x1bd8
// Size: 0x181
function function_67dce7c33a01cd09()
{
    if ( level.poiname == "future" && level.var_1b3c422d98197927 )
    {
        foreach ( loc in level.var_31998b7ccf36d152 )
        {
            if ( !arraycontains( level.var_1b3c422d98197927, loc.script_location ) )
            {
                level.var_31998b7ccf36d152 = arrayremove( level.var_31998b7ccf36d152, loc );
            }
        }
        
        return;
    }
    
    if ( level.poiname == "past" && level.var_59f211cd543ad7ea )
    {
        foreach ( loc in level.var_31998b7ccf36d152 )
        {
            if ( !arraycontains( level.var_59f211cd543ad7ea, loc.script_location ) )
            {
                level.var_31998b7ccf36d152 = arrayremove( level.var_31998b7ccf36d152, loc );
            }
        }
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x8214624f, Offset: 0x1d61
// Size: 0xce
function function_c890b7670ca21799()
{
    current_timeline = level.timetravel.timeline.name;
    
    foreach ( player in level.players )
    {
        if ( current_timeline == "past" )
        {
            level.var_bf936ccc57156561 = "past";
            continue;
        }
        
        if ( current_timeline == "future" )
        {
            level.var_bf936ccc57156561 = "future";
        }
    }
}

// Namespace zm_sat_mantis
// Params 4
// Checksum 0x4193e5ef, Offset: 0x1e38
// Size: 0x10d
function register_clock_time_notify( str_time, str_notify_name, var_43186c83e53eaa0e, b_ignore_time_travel = 0 )
{
    if ( !isdefined( level.var_1afbd4d6fe9ef1fe ) )
    {
        level.var_1afbd4d6fe9ef1fe = spawnstruct();
    }
    
    if ( !isdefined( level.var_1afbd4d6fe9ef1fe.clock_notifies ) )
    {
        level.var_1afbd4d6fe9ef1fe.clock_notifies = [];
    }
    
    if ( !isdefined( level.var_1afbd4d6fe9ef1fe.clock_notifies[ str_notify_name ] ) )
    {
        level.var_1afbd4d6fe9ef1fe.clock_notifies[ str_notify_name ] = spawnstruct();
    }
    
    level.var_1afbd4d6fe9ef1fe.clock_notifies[ str_notify_name ].str_time = str_time;
    level.var_1afbd4d6fe9ef1fe.clock_notifies[ str_notify_name ].var_b239242e92309dc0 = var_43186c83e53eaa0e;
    level.var_1afbd4d6fe9ef1fe.clock_notifies[ str_notify_name ].b_ignore_time_travel = b_ignore_time_travel;
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xc7894cb6, Offset: 0x1f4d
// Size: 0x313
function init_clock_hands()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !isdefined( level.var_1afbd4d6fe9ef1fe ) )
    {
        level.var_1afbd4d6fe9ef1fe = spawnstruct();
    }
    
    level.var_1afbd4d6fe9ef1fe.var_5dc0cb5a45082cad = getentarray( "clock_hand", #targetname );
    
    foreach ( clock_hand in level.var_1afbd4d6fe9ef1fe.var_5dc0cb5a45082cad )
    {
        clock_hand setcandamage( 1 );
        clock_hand thread function_b448f58632b30211();
        clock_hand.var_f5a543a5f1e2755e = -63;
        
        if ( clock_hand.script_noteworthy == "hour" )
        {
            level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4 = clock_hand;
            continue;
        }
        
        if ( clock_hand.script_noteworthy == "minute" )
        {
            level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292 = clock_hand;
        }
    }
    
    level.var_1afbd4d6fe9ef1fe.var_abac0a810e144f57 = level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4.angles[ 2 ];
    random_time_hour = set_random_time( "hour" );
    var_b90bb8191bcda085 = set_random_time( "min" );
    level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4.angles += ( 0, 0, random_time_hour * 30 * -1 );
    level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292.angles += ( 0, 0, var_b90bb8191bcda085 * 30 * -1 );
    level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4.angles += ( 0, 0, var_b90bb8191bcda085 * 2.5 * -1 );
    level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4 normalizeangles();
    level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292 normalizeangles();
    level.var_1afbd4d6fe9ef1fe.current_time = string( random_time_hour ) + ":" + string( var_b90bb8191bcda085 );
    
    /#
        iprintlnbold( "<dev string:x6d>" + level.var_1afbd4d6fe9ef1fe.current_time );
    #/
    
    level.var_1afbd4d6fe9ef1fe thread function_abc3cfcb73c83e3();
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xf6210a4b, Offset: 0x2268
// Size: 0x87
function normalizeangles()
{
    if ( self == level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292 )
    {
        current_z_angles = mod( round( self.angles[ 2 ] ), 360 );
    }
    else
    {
        current_z_angles = mod( self.angles[ 2 ], 360 );
    }
    
    if ( current_z_angles < 0 )
    {
        current_z_angles += 360;
    }
    
    self.angles = ( self.angles[ 0 ], self.angles[ 1 ], current_z_angles );
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x90b4d8dc, Offset: 0x22f7
// Size: 0x1e2
function function_abc3cfcb73c83e3()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_8e605aa68308d14" );
        current_time_hour = level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4 function_480c03b11721dc89();
        current_time_mins = level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292 function_480c03b11721dc89();
        
        /#
            iprintlnbold( "<dev string:x6d>" + string( current_time_hour ) + "<dev string:x7c>" + string( current_time_mins ) );
        #/
        
        level.var_1afbd4d6fe9ef1fe.current_time = string( current_time_hour ) + ":" + string( current_time_mins );
        
        if ( isdefined( level.var_1afbd4d6fe9ef1fe.clock_notifies ) )
        {
            foreach ( str_notify_name, notify_info in level.var_1afbd4d6fe9ef1fe.clock_notifies )
            {
                if ( notify_info.str_time == string( current_time_hour ) + ":" + string( current_time_mins ) )
                {
                    if ( !notify_info.b_ignore_time_travel )
                    {
                        if ( !level utility::flag( "timetravel_ongoing" ) )
                        {
                            continue;
                        }
                        
                        /#
                            iprintlnbold( "<dev string:x7e>" + str_notify_name );
                        #/
                        
                        level thread function_edfe31fc161fbb20( str_notify_name );
                    }
                    else
                    {
                        level utility::flag_set( str_notify_name );
                        
                        if ( notify_info.var_b239242e92309dc0 )
                        {
                            function_a5c1175d3ea3c25a( level.var_1afbd4d6fe9ef1fe.clock_notifies, notify_info );
                        }
                    }
                    
                    continue;
                }
                
                level utility::flag_clear( str_notify_name );
            }
        }
    }
}

// Namespace zm_sat_mantis
// Params 1
// Checksum 0x6e93baa6, Offset: 0x24e1
// Size: 0xee
function function_edfe31fc161fbb20( str_notify_name )
{
    level endon( #"game_ended" );
    level utility::flag_waitopen( "timetravel_ongoing" );
    time_need = level.var_1afbd4d6fe9ef1fe.clock_notifies[ str_notify_name ].str_time;
    current_times = strtok( level.var_1afbd4d6fe9ef1fe.current_time, ":" );
    
    if ( time_need == string( current_times[ 0 ] ) + ":" + string( current_times[ 1 ] ) )
    {
        level utility::flag_set( str_notify_name );
        
        if ( level.var_1afbd4d6fe9ef1fe.clock_notifies[ str_notify_name ].var_b239242e92309dc0 )
        {
            function_a5c1175d3ea3c25a( level.var_1afbd4d6fe9ef1fe.clock_notifies, level.var_1afbd4d6fe9ef1fe.clock_notifies[ str_notify_name ] );
        }
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xc704b0c8, Offset: 0x25d7
// Size: 0x4a
function function_480c03b11721dc89()
{
    current_z_angles = mod( self.var_f5a543a5f1e2755e - self.angles[ 2 ] + 360, 360 );
    
    if ( current_z_angles < 0 )
    {
        current_z_angles += 360;
    }
    
    return int( current_z_angles / 30 );
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xd3ad512b, Offset: 0x262a
// Size: 0x1fd
function function_b448f58632b30211()
{
    self endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( !isplayer( attacker ) )
        {
            continue;
        }
        
        if ( level utility::flag( "clock_hand_damage_taken" ) )
        {
            continue;
        }
        
        level utility::flag_set( "clock_hand_damage_taken" );
        
        if ( self == level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292 )
        {
            level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292 rotateby( ( 0, 0, -30 ), 0.5 );
            level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4 rotateby( ( 0, 0, -2.5 ), 0.5 );
            playsoundatpos( level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292.origin, #"hash_8b18089424717c95" );
        }
        else
        {
            level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4 rotateby( ( 0, 0, -30 ), 0.5 );
            playsoundatpos( level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4.origin, #"hash_3619888d2223a197" );
        }
        
        wait 0.6;
        level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4 normalizeangles();
        level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292 normalizeangles();
        level notify( #"hash_8e605aa68308d14" );
        wait 0.5;
        level utility::flag_clear( "clock_hand_damage_taken" );
    }
}

// Namespace zm_sat_mantis
// Params 1
// Checksum 0x766c1293, Offset: 0x282f
// Size: 0x72
function set_random_time( var_3d54b67f4a304edb )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( var_3d54b67f4a304edb == "hour" )
        {
            random_time_hour = randomint( 12 );
            
            if ( random_time_hour != 1 )
            {
                return random_time_hour;
            }
        }
        else if ( var_3d54b67f4a304edb == "min" )
        {
            var_b90bb8191bcda085 = randomint( 12 );
            
            if ( var_b90bb8191bcda085 != 3 )
            {
                return var_b90bb8191bcda085;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xa69ef197, Offset: 0x28a9
// Size: 0x75
function function_28795cf8d887e305()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "zm_sat_mantis_quest_mq_cs_completed" );
    s_garage_door = utility::getstruct( "garage_door", "targetname" );
    s_garage_door.sbl = spawnscriptable( s_garage_door.script_noteworthy, s_garage_door.origin, s_garage_door.angles );
}

// Namespace zm_sat_mantis
// Params 1
// Checksum 0x4241c8f9, Offset: 0x2926
// Size: 0x16
function function_791601c1d3d804e9( s_exfil )
{
    return [ "zone_bus" ];
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x6b133ae6, Offset: 0x2945
// Size: 0x1d5
function init_cars_navmesh()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "loading_screen_over" );
    var_2a345ab3ef50328c = getentarray( "hidden_prop", #script_noteworthy );
    
    foreach ( model in var_2a345ab3ef50328c )
    {
        a_clips = getentarray( model.targetname, #target );
        
        foreach ( clip in a_clips )
        {
            clip linkto( model );
            
            if ( clip.script_noteworthy == "island" )
            {
                clip dockmovingplatform( undefined );
            }
        }
        
        foreach ( clip in a_clips )
        {
            if ( clip.script_noteworthy == "nav_cut" )
            {
                wait 0.2;
                createnavbadplacebyent( clip );
            }
        }
    }
    
    level thread function_443c9e011db1a06b();
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x25aef1dd, Offset: 0x2b22
// Size: 0x1e4
function function_443c9e011db1a06b()
{
    level endon( #"game_ended" );
    var_95b6d59473871cdb = getnodearray( "dynamic_traversal", #script_noteworthy );
    
    if ( var_95b6d59473871cdb.size > 0 )
    {
        foreach ( starter_node in var_95b6d59473871cdb )
        {
            if ( starter_node.script_flag_wait == "door_cul_to_truck_f" )
            {
                end_node = getnode( starter_node.target, #targetname );
                
                if ( isdefined( end_node ) )
                {
                    destroynavlink( starter_node );
                }
            }
        }
        
        level utility::flag_wait( "door_cul_to_truck_f" );
        
        foreach ( starter_node in var_95b6d59473871cdb )
        {
            if ( starter_node.script_flag_wait == "door_cul_to_truck_f" )
            {
                end_node = getnode( starter_node.target, #targetname );
                
                if ( isdefined( end_node ) )
                {
                    var_6a8f9d2bd26c68e0 = starter_node.script_int ?? 0;
                    var_2073f210b8fb10a3 = end_node.script_int ?? 0;
                    createnavlink( starter_node.target, starter_node.origin + ( 0, 0, var_6a8f9d2bd26c68e0 ), end_node.origin + ( 0, 0, var_2073f210b8fb10a3 ), starter_node );
                }
            }
        }
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x967ef1c2, Offset: 0x2d0e
// Size: 0x2e3
function function_ae0561e420148611()
{
    if ( isdefined( level.var_8b88f7d5701efd7d ) && !level.var_8b88f7d5701efd7d )
    {
        return;
    }
    
    level.var_8b88f7d5701efd7d = 0;
    var_95b6d59473871cdb = getnodearray( "dynamic_traversal", #script_noteworthy );
    
    if ( var_95b6d59473871cdb.size > 0 )
    {
        foreach ( starter_node in var_95b6d59473871cdb )
        {
            if ( starter_node.script_flag_wait == "door_cul_to_truck_f" )
            {
                destroynavlink( starter_node );
            }
        }
    }
    
    var_2a345ab3ef50328c = getentarray( "hidden_prop", #script_noteworthy );
    
    foreach ( model in var_2a345ab3ef50328c )
    {
        a_clips = getentarray( model.targetname, #target );
        waitframe();
        
        foreach ( clip in a_clips )
        {
            if ( clip.script_noteworthy == "island" )
            {
            }
            
            if ( clip.script_noteworthy == "nav_cut" )
            {
                clip connectpaths();
            }
        }
        
        model.origin += ( 0, 0, -10000 );
    }
    
    var_8f711d5a4b615ba2 = getscriptablearray( "doorbuy_truck_1_f", #targetname );
    
    foreach ( doorbuy in var_8f711d5a4b615ba2 )
    {
        if ( isdefined( doorbuy ) )
        {
            doorbuy.current_state = doorbuy getscriptablepartstate( "base" );
            waitframe();
            doorbuy setscriptablepartstate( "base", "hidden" );
        }
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0xbc5bfc4c, Offset: 0x2ff9
// Size: 0x367
function function_a15e37d395e34804()
{
    if ( level.var_8b88f7d5701efd7d )
    {
        return;
    }
    
    level.var_8b88f7d5701efd7d = 1;
    var_2a345ab3ef50328c = getentarray( "hidden_prop", #script_noteworthy );
    
    foreach ( model in var_2a345ab3ef50328c )
    {
        model.origin += ( 0, 0, 10000 );
        a_clips = getentarray( model.targetname, #target );
        waitframe();
        
        foreach ( clip in a_clips )
        {
            if ( clip.script_noteworthy == "island" )
            {
            }
            
            if ( clip.script_noteworthy == "nav_cut" )
            {
                createnavobstaclebyent( clip );
            }
        }
    }
    
    var_8f711d5a4b615ba2 = getscriptablearray( "doorbuy_truck_1_f", #targetname );
    
    foreach ( doorbuy in var_8f711d5a4b615ba2 )
    {
        if ( isdefined( doorbuy ) )
        {
            doorbuy setscriptablepartstate( "base", "idle" );
            waitframe();
            waitframe();
            doorbuy setscriptablepartstate( "base", doorbuy.current_state );
        }
    }
    
    wait 1;
    var_95b6d59473871cdb = getnodearray( "dynamic_traversal", #script_noteworthy );
    
    if ( var_95b6d59473871cdb.size > 0 )
    {
        foreach ( starter_node in var_95b6d59473871cdb )
        {
            if ( starter_node.script_flag_wait == "door_cul_to_truck_f" )
            {
                end_node = getnode( starter_node.target, #targetname );
                
                if ( isdefined( end_node ) )
                {
                    destroynavlink( starter_node );
                    var_6a8f9d2bd26c68e0 = starter_node.script_int ?? 0;
                    var_2073f210b8fb10a3 = end_node.script_int ?? 0;
                    createnavlink( starter_node.target, starter_node.origin + ( 0, 0, var_6a8f9d2bd26c68e0 ), end_node.origin + ( 0, 0, var_2073f210b8fb10a3 ), starter_node );
                }
            }
        }
    }
}

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x3852aedc, Offset: 0x3368
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

// Namespace zm_sat_mantis
// Params 0
// Checksum 0x1f0bb001, Offset: 0x3394
// Size: 0x119
function mailbox_spawns()
{
    if ( !function_80daf2f20b4e6e6d() )
    {
        s_fn_mb = utility::getstruct( "fn_mb" );
        s_pn_mb = utility::getstruct( "pn_mb" );
        level.fn_mailbox = spawnscriptable( "zm_sat_mb_fn", s_fn_mb.origin, s_fn_mb.angles );
        level.pn_mailbox = spawnscriptable( "zm_sat_mb_pn", s_pn_mb.origin, s_pn_mb.angles );
    }
    
    if ( function_80daf2f20b4e6e6d() )
    {
        level utility::waittill_notify_or_timeout( "relic_level_set", 15 );
        
        if ( level.zm_relic_tier < 2 )
        {
            s_fn_mb = utility::getstruct( "fn_mb" );
            s_pn_mb = utility::getstruct( "pn_mb" );
            level.fn_mailbox = spawnscriptable( "zm_sat_mb_fn", s_fn_mb.origin, s_fn_mb.angles );
            level.pn_mailbox = spawnscriptable( "zm_sat_mb_pn", s_pn_mb.origin, s_pn_mb.angles );
        }
    }
}

// Namespace zm_sat_mantis
// Params 1
// Checksum 0x565165eb, Offset: 0x34b5
// Size: 0x489
function set_boss_fight_clips( b_is_close )
{
    if ( b_is_close )
    {
        var_bb37cfa5b54c79c4 = getentarray( "bf_house_clp", "targetname" );
        
        foreach ( clip in var_bb37cfa5b54c79c4 )
        {
            clip solid();
            clip disconnectpaths();
        }
        
        if ( !isdefined( level.bf_doors ) )
        {
            level.bf_doors = [];
        }
        
        var_f144346027c675dd = utility::getstructarray( "bf_door_mdl", "targetname" );
        
        foreach ( loc in var_f144346027c675dd )
        {
            my_mdl = utility::spawn_model( loc.script_label, loc.origin, loc.angles );
            level.bf_doors[ level.bf_doors.size ] = my_mdl;
        }
        
        a_window_locs = utility::getstructarray( "bf_window_mdl", "targetname" );
        
        foreach ( win in a_window_locs )
        {
            win.window_scriptable = spawnscriptable( win.script_label, win.origin, win.angles );
            win.window_scriptable setscriptablepartstate( "base", "closed" );
        }
        
        return;
    }
    
    var_bb37cfa5b54c79c4 = getentarray( "bf_house_clp", "targetname" );
    
    foreach ( clip in var_bb37cfa5b54c79c4 )
    {
        clip notsolid();
        clip connectpaths();
    }
    
    foreach ( mdl in level.bf_doors )
    {
        if ( mdl )
        {
            mdl delete();
        }
    }
    
    a_window_locs = utility::getstructarray( "bf_window_mdl", "targetname" );
    
    foreach ( win in a_window_locs )
    {
        if ( isdefined( win.window_scriptable ) )
        {
            win.window_scriptable freescriptable();
        }
    }
    
    var_dd5147eb36a3795b = utility::getstructarray( "hold_out_pos", "targetname" );
    
    foreach ( var_ed100f9a07836d02 in var_dd5147eb36a3795b )
    {
        clip = getent( "boss_black_dome_clip_" + var_ed100f9a07836d02.script_noteworthy, #targetname );
        
        if ( clip )
        {
            clip notsolid();
            clip connectpaths();
        }
    }
}

// Namespace zm_sat_mantis
// Params 0, eflags: 0x4
// Checksum 0x85cfd44f, Offset: 0x3946
// Size: 0x6e
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
}

/#

    // Namespace zm_sat_mantis
    // Params 0, eflags: 0x4
    // Checksum 0xd320f598, Offset: 0x39bc
    // Size: 0x44, Type: dev
    function private devgui_mantis()
    {
        devgui::function_9082edeb5db93280( "<dev string:x8d>" );
        devgui::add_devgui_func( "<dev string:xb4>", "<dev string:xd1>", &function_cbdccce38bb68171 );
        devgui::add_devgui_func( "<dev string:xf5>", "<dev string:x113>", &function_7a242d6c4c3e8663 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_mantis
    // Params 0
    // Checksum 0x5017a4d2, Offset: 0x3a08
    // Size: 0x92, Type: dev
    function function_cbdccce38bb68171()
    {
        position = { #vertical_anchor:1, #horizontal_anchor:1, #top:0, #left:0 };
        widget_struct = { #position:position };
        ui::lui_registercallback( "<dev string:x138>", &function_33247e9064cc31cf );
        ui::lui_registercallback( "<dev string:x150>", &function_e5fa50de8648e801 );
        level.players[ 0 ] scripted_widgets::create( "<dev string:x166>", "<dev string:x173>", widget_struct );
    }

    // Namespace zm_sat_mantis
    // Params 1
    // Checksum 0xc81bcbba, Offset: 0x3aa2
    // Size: 0xf, Type: dev
    function function_33247e9064cc31cf( value )
    {
        
    }

    // Namespace zm_sat_mantis
    // Params 1
    // Checksum 0xbcb3b29d, Offset: 0x3ab9
    // Size: 0x16, Type: dev
    function function_e5fa50de8648e801( value )
    {
        function_7a242d6c4c3e8663();
    }

    // Namespace zm_sat_mantis
    // Params 0
    // Checksum 0x60fac73a, Offset: 0x3ad7
    // Size: 0x3e, Type: dev
    function function_7a242d6c4c3e8663()
    {
        ui::function_c2505ff7b7fc55a4( "<dev string:x138>", &function_33247e9064cc31cf );
        ui::function_c2505ff7b7fc55a4( "<dev string:x150>", &function_e5fa50de8648e801 );
        level.players[ 0 ] scripted_widgets::destroy( "<dev string:x166>" );
    }

    // Namespace zm_sat_mantis
    // Params 0
    // Checksum 0x2a3966e2, Offset: 0x3b1d
    // Size: 0xfc, Type: dev
    function function_288672b38940d8b1()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            level utility::flag_set( "<dev string:x193>" );
            level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292 rotateby( ( 0, 0, -30 ), 0.05 );
            level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4 rotateby( ( 0, 0, -2.5 ), 0.05 );
            wait 0.1;
            level.var_1afbd4d6fe9ef1fe.var_6d18a09fb1a59ed4 normalizeangles();
            level.var_1afbd4d6fe9ef1fe.var_b05d5ab7261f1292 normalizeangles();
            level notify( #"hash_8e605aa68308d14" );
            wait 0.1;
            
            if ( level.var_1afbd4d6fe9ef1fe.current_time == "<dev string:x1ab>" )
            {
                break;
            }
        }
        
        level utility::flag_clear( "<dev string:x193>" );
        iprintlnbold( "<dev string:x1af>" );
    }

#/
