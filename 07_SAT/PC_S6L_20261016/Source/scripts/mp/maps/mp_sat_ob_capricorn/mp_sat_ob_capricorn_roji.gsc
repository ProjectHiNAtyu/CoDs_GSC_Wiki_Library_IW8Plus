// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_roji.gsc  (hash_3a0ea7b537cc978e.gscc) (size: 10983 Bytes / 0x2ae7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb03921 (263207201)
// size ...... 10983 (0x2ae7)
// includes .. 19  (offset: 0x26e3)
// strings ... 59  (offset: 0x277b)
// dev strs .. 0   (offset: 0x2ae7)
// exports ... 25  (offset: 0x179f)
// cseg ...... 0x693 + 0x110c (0x179f)
// imports ... 96  (offset: 0x1b87)
// animtree1 . 0   (offset: 0x2ae7)
// animtree2 . 0   (offset: 0x2ae7)
#using script_35713297c4efa490;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\coop;
#using scripts\mp\gametypes\rogue_perks;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_audio;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_vo;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_vtol_utils;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace mp_sat_ob_capricorn_roji;

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x5
// Checksum 0x21e3d7a, Offset: 0x6b1
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_ob_capricorn_roji", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0xaeab64be, Offset: 0x6da
// Size: 0x10e
function private function_538033a540e63c70()
{
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_ROJI", "OB_CAPRICORN_ROJI", [ { #result:undefined, #var_de54801bc657ab2c:&phase_roji } ] );
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_ROJI", "OB_CAPRICORN_ROJI_GAME_CENTER", [ { #result:undefined, #var_de54801bc657ab2c:&function_dcadda633fa4f31 } ] );
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_ROJI", "OB_CAPRICORN_ROJI_ROOFTOP", [ { #result:undefined, #var_de54801bc657ab2c:&function_b5bcd40556ff822e } ] );
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_ROJI", "OB_CAPRICORN_ROJI_ROOFTOP_ELEVATOR", [ { #result:undefined, #var_de54801bc657ab2c:&function_5482d1a5c3099201 }, { #result:undefined, #var_de54801bc657ab2c:&function_af2bfc2551dc04e } ] );
    ob_story_mission_activity_setup::function_13cff85d193f6c27( "CAPRICORN_ROJI", &function_4cdb5a97d55541ca );
    ob_story_mission_activity_setup::function_159af14427677b6c( "CAPRICORN_ROJI", &function_178cb684fc28b201 );
    ob_story_mission_activity_setup::function_2f991abf23ddce4c( "CAPRICORN_ROJI", &roji_player_setup );
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0x96d459b5, Offset: 0x7f0
// Size: 0xef
function private phase_roji()
{
    thread mp_sat_ob_capricorn_vo::function_4b74802884508537();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_ROJI_PLAZA" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_roji_tower_bottom", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "tower_bottom_reached", undefined, undefined, 1, 1, 0, 1, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level notify( #"hash_e9d8f99b4699a0e2" );
    thread function_7827a665908e4f27();
    level utility::flag_wait( "encounter_capricorn_roji_train_station_triggered" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_ROJI" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_roji_train_station_top", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "train_station_top_reached", undefined, undefined, 0, 1, 0, 1, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( "flag_roji_trainstation_roof_reached", "capricorn_roji_train_station_top" );
    level utility::flag_wait( "flag_roji_trainstation_roof_reached" );
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0xe6619be1, Offset: 0x8e7
// Size: 0x6d
function private function_dcadda633fa4f31()
{
    function_6bf310c7ee590a6b();
    level callback::add( #"player_spawned", &function_e4204e7cad729b8d, self );
    thread mp_sat_ob_capricorn_vo::function_a6f4336c43443f42();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_ROJI_GAME_CENTER" );
    level utility::flag_wait( "OB_CAPRICORN_ROJI_BAR_ROOF_HELI" );
    thread ob_story_mission_utils::function_273dfd9583646854( "roji_trail_vtol_gamecenter", undefined, undefined, undefined, 110, 140, 0, 80, 40, undefined, undefined, undefined, "capricorn_world_vtol" );
    level utility::flag_wait( "flag_roji_gamecenter_reached" );
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0x11e5b066, Offset: 0x95c
// Size: 0x5f
function private function_b5bcd40556ff822e()
{
    if ( !isdefined( level.var_3d9fc7aa7b25b565.var_b8cec91d28d0f393 ) )
    {
        function_6bf310c7ee590a6b();
        level callback::add( #"player_spawned", &function_e4204e7cad729b8d, self );
    }
    
    thread mp_sat_ob_capricorn_vo::function_8f79c47dd1e9da71();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_ROJI_ROOFTOP" );
    thread function_18cdf689f3ef996f();
    level utility::flag_wait( "flag_roji_hotel_reached" );
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0xf22f0954, Offset: 0x9c3
// Size: 0xff
function private function_5482d1a5c3099201()
{
    if ( !isdefined( level.var_3d9fc7aa7b25b565.var_b8cec91d28d0f393 ) )
    {
        function_6bf310c7ee590a6b();
        level callback::add( #"player_spawned", &function_e4204e7cad729b8d, self );
    }
    
    thread mp_sat_ob_capricorn_vo::function_eb81b3d5f6e6df7a();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_ROJI_ROOFTOP_ELEVATOR" );
    interactstruct = utility::getstruct( "roji_roof_elevator_outside_interact" );
    interact = interaction::register_interact( interactstruct.origin, 64, &roji_roof_elevator_outside_interact, &"jup_ob_objectives/interact_activate" );
    interact setcursorhint( "HINT_BUTTON" );
    utility::flag_wait( "roji_roof_elevator_interact_outside_done" );
    level callback::remove( #"player_spawned", &function_e4204e7cad729b8d, self );
    capricorn_audio::function_51804a8f7fa5669f( interactstruct.origin );
    elevator_origin = level.var_d94fd043f14f11c9[ "roof_small_elevator_bottom" ][ 0 ].origin;
    capricorn_audio::function_4537eb28a10b8825( elevator_origin );
    wait 3;
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0x4f7052fb, Offset: 0xaca
// Size: 0x236
function private function_af2bfc2551dc04e()
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"force_open" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "roof_small_elevator_bottom" );
    }
    
    interactstruct = utility::getstruct( "roji_roof_elevator_inside_interact" );
    interact = interaction::register_interact( interactstruct.origin, 64, &roji_roof_elevator_inside_interact, &"jup_ob_objectives/interact_activate" );
    interact setcursorhint( "HINT_BUTTON" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_roji_tower_elevator", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "tower_top_reached", undefined, undefined, 0, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( "roji_roof_elevator_interact_inside_done", "capricorn_roji_tower_elevator" );
    level waittill( #"roji_roof_elevator_interact_inside_done", player );
    capricorn_audio::function_51804a8f7fa5669f( interactstruct.origin );
    thread function_de49c0f1703e6bd6();
    var_ba7c3b8fa9d3823 = spawnstruct();
    var_ba7c3b8fa9d3823.origin = ( -12028, -48484.9, 2805 );
    options = spawnstruct();
    options.flag_countdown = "flag_regroup_roji_roof_completed";
    options.fadestartnone = 1;
    options.var_227ead15d2892709 = 1;
    options.var_ba7c3b8fa9d3823 = var_ba7c3b8fa9d3823;
    options.triggerradius = 400;
    options.var_560eecb53e318cbf = 1;
    thread coop::function_164d95b45992525( options );
    level utility::flag_wait( "flag_regroup_roji_roof_completed" );
    level notify( #"hash_a90894fda4feb874" );
    
    foreach ( player in level.players )
    {
        level thread game_utility::fadetoblackforplayer( player, 1, 1 );
    }
    
    wait 1;
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0xf077af90, Offset: 0xd08
// Size: 0x188
function private function_de49c0f1703e6bd6()
{
    var_76edadbf00d1fdbd = [];
    
    foreach ( player in level.players )
    {
        player_objectives = player waypoint_objective_handler::function_22c79c4675aa5cd9();
        
        foreach ( objective, data in player_objectives )
        {
            if ( player waypoint_objective_handler::function_c2eeb9e0ffc2533d( objective ) == 1 )
            {
                if ( !isdefined( var_76edadbf00d1fdbd[ objective ] ) )
                {
                    var_76edadbf00d1fdbd[ objective ] = [];
                }
                
                var_76edadbf00d1fdbd[ objective ][ var_76edadbf00d1fdbd[ objective ].size ] = player;
            }
        }
    }
    
    foreach ( objective, players in var_76edadbf00d1fdbd )
    {
        level mp_sat_ob_capricorn::cancel_waypoint_objective_handler( objective, players );
    }
}

// Namespace mp_sat_ob_capricorn_roji
// Params 1, eflags: 0x4
// Checksum 0xcd1d85d4, Offset: 0xe98
// Size: 0x1e
function private roji_roof_elevator_outside_interact( player )
{
    utility::flag_set( "roji_roof_elevator_interact_outside_done" );
    self delete();
}

// Namespace mp_sat_ob_capricorn_roji
// Params 1, eflags: 0x4
// Checksum 0xd48a0ad3, Offset: 0xebe
// Size: 0x20
function private roji_roof_elevator_inside_interact( player )
{
    utility::flag_set( "roji_roof_elevator_interact_inside_done", player );
    self delete();
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0xf7f22d58, Offset: 0xee6
// Size: 0xb2
function private function_4cdb5a97d55541ca()
{
    thread mp_sat_ob_capricorn::function_c89c8c8e27d1c8ec();
    thread set_roji_minimap();
    activity_ai_encounters::function_79c1b913ce172ac5( self, "encounter_trigger_parkour", &function_f410d5b2a1113609, &activity_ai_encounters::function_952687d67d74fdef );
    thread function_6069874c6149b511();
    thread function_4b4e81705634d9ec();
    thread function_cf0e4493cde84422( 1 );
    thread ob_story_mission_utils::item_spawn_weapon( "s_roji_weapon", "roji_staged_gear_clean_up", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_roji_equipment", "roji_staged_gear_clean_up", 1 );
    thread ob_story_mission_utils::function_fa27c4afc0f886da( "s_roji_item", "roji_staged_gear_clean_up", 1 );
    thread ob_story_mission_utils::function_e6799e9a19df2365( "capricorn_roji_caches" );
    level thread ob_story_mission_utils::function_b0bc4cf3be6ad752( "roji_trigger_fails" );
    thread mp_sat_ob_capricorn::encounter_create_squad( "encounter_capricorn_roji_park", "01" );
    thread mp_sat_ob_capricorn::encounter_create_squad( "encounter_capricorn_roji_park", "02" );
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0x646ab5fa, Offset: 0xfa0
// Size: 0x14
function private function_178cb684fc28b201()
{
    level utility::flag_set( "roji_staged_gear_clean_up" );
    removeallcorpses();
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0xe7fcf736, Offset: 0xfbc
// Size: 0x76
function private set_roji_minimap()
{
    level endon( #"hash_3873487e84716366" );
    var_5139be75347d9c67 = spawn( "trigger_radius", ( -13008, -58005, 85 ), 0, 250, 90 );
    var_120fe2231ed00b50 = spawn( "trigger_radius", ( -13008, -58837, 85 ), 0, 250, 90 );
    var_5139be75347d9c67 childthread function_d819538ad36f8e8e( "roji" );
    var_120fe2231ed00b50 childthread function_d819538ad36f8e8e( "restricted_area" );
}

// Namespace mp_sat_ob_capricorn_roji
// Params 1, eflags: 0x4
// Checksum 0xc4a97d05, Offset: 0x103a
// Size: 0x88
function private function_d819538ad36f8e8e( zone_name )
{
    volume = getnoentvolumearray( "minimap_volume_" + zone_name, "targetname" )[ 0 ];
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && zone_name != ent.var_9bed8855167dd7c8 )
        {
            ent.var_9bed8855167dd7c8 = zone_name;
            ent compass::setupminimap( "compass_map_mp_sat_ob_capricorn_" + zone_name, undefined, undefined, volume );
        }
    }
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0x1ed431ec, Offset: 0x10ca
// Size: 0x74
function private function_6069874c6149b511()
{
    level endon( #"hash_3873487e84716366" );
    trigger = getnoentvolumearray( "roji_wall_jump_hint_trigger", "targetname" );
    
    while ( true )
    {
        trigger[ 0 ] waittill( #"trigger", player );
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_wall_jump", &"sat_ob_story_missions_capricorn/ob_capricorn_wall_jump_hint", 10 );
    }
}

// Namespace mp_sat_ob_capricorn_roji
// Params 1, eflags: 0x4
// Checksum 0xf458cec, Offset: 0x1146
// Size: 0x15
function private roji_player_setup( player )
{
    player thread rogue_perks::ability_infinitetacsprint();
}

// Namespace mp_sat_ob_capricorn_roji
// Params 3, eflags: 0x4
// Checksum 0xe0bfa3d, Offset: 0x1163
// Size: 0x9a
function private function_f410d5b2a1113609( activity_instance, encounter_name, player )
{
    level notify( #"hash_a90894fda4feb874" );
    droneoptions = spawnstruct();
    droneoptions.activationdelay = 0.3;
    droneoptions.scannerlogic = 1;
    droneoptions.var_bd2b4756836f0b9a = 2;
    droneoptions.var_75fab83acb648e4e = 1000;
    mp_sat_ob_capricorn::spawn_turret_drone( activity_instance, encounter_name, droneoptions );
    utility::flag_set( encounter_name + "_triggered" );
    thread mp_sat_ob_capricorn::function_36a2524eb4edf91a( activity_instance, encounter_name );
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0
// Checksum 0xa53eb6b5, Offset: 0x1205
// Size: 0xa7
function function_7827a665908e4f27()
{
    heli_scene_struct = utility::getstruct( "sat_cin_cap_490_roji_intro_heli" );
    heli_scene_struct scene::init();
    vtol = mp_sat_ob_capricorn_vtol_utils::function_1da6426434fdf6b();
    vtol_scene_struct = utility::getstruct( "sat_cin_cap_490_roji_intro_vtol" );
    vtol_scene_struct scene::init( vtol );
    vtol playrumblelooponentity( "capricorn_world_vtol" );
    vtol_scene_struct thread scene::play( vtol, "idle" );
    level utility::flag_wait( "OB_CAPRICORN_ROJI_METRO_VTOL" );
    heli_scene_struct thread scene::play();
    vtol_scene_struct scene::play( vtol, "take_off" );
    vtol stoprumble( "capricorn_world_vtol" );
    vtol delete();
    vtol = undefined;
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0
// Checksum 0xbe265fd4, Offset: 0x12b4
// Size: 0x38
function function_18cdf689f3ef996f()
{
    heli_scene_struct = utility::getstruct( "sat_cin_cap_495_roji_arcade_heli" );
    level utility::flag_wait( "OB_CAPRICORN_ROJI_ARCADE_ROOF_HELI" );
    heli_scene_struct scene::init();
    heli_scene_struct thread scene::play();
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0
// Checksum 0x2a098a55, Offset: 0x12f4
// Size: 0x1ae
function function_4b4e81705634d9ec()
{
    if ( getdvarint( @"hash_8d15b5b3f90ff719", 0 ) == 1 )
    {
        return;
    }
    
    level.var_b12bafcd8af9ed95 = [];
    var_26ad585bf3f8d930 = getscriptbundle( %"hash_5047cdc04aa73ee7" );
    var_d5dea03251ea138b = utility::getstructarray( "roji_drone_main_search", "targetname" );
    
    foreach ( drone_struct in var_d5dea03251ea138b )
    {
        drone_difficulty_region = region_difficulty_manager::get_region_difficulty( drone_struct.origin );
        spawn_options = { #hackable:0, #showhealthbar:0, #var_1cb68d8eeac5c90d:1, #spawn_angles:drone_struct.angles, #difficulty_region:drone_difficulty_region, #var_2858c1d9ffae3f84:var_26ad585bf3f8d930.var_2858c1d9ffae3f84, #goal:#"hash_6573e43fb6b70d11", #canlootdrop:0, #canmove:1, #spawnpos:drone_struct.origin, #enableaimassist:1, #candamage:1 };
        drone = function_30f06e6162b5f013( spawn_options, drone_struct );
        level.var_b12bafcd8af9ed95[ level.var_b12bafcd8af9ed95.size ] = drone;
    }
}

// Namespace mp_sat_ob_capricorn_roji
// Params 2
// Checksum 0xf315b5fc, Offset: 0x14aa
// Size: 0x4a
function function_30f06e6162b5f013( spawn_options, node )
{
    drone = ob_flying_drone::function_d664e23d9508b462( spawn_options );
    drone thread ob_flying_drone::function_aba08bf509c70293( node );
    drone ob_flying_drone::function_e0de4dce57ae487();
    
    /#
        drone thread ob_flying_drone::function_5fc6b44c9edd444a();
    #/
    
    return drone;
}

// Namespace mp_sat_ob_capricorn_roji
// Params 0, eflags: 0x4
// Checksum 0xed57a5d5, Offset: 0x14fd
// Size: 0x93
function private function_6bf310c7ee590a6b()
{
    level.var_3d9fc7aa7b25b565.var_b8cec91d28d0f393 = 1;
    
    foreach ( player in level.players )
    {
        player thread function_e4204e7cad729b8d( undefined, self );
    }
}

// Namespace mp_sat_ob_capricorn_roji
// Params 2, eflags: 0x4
// Checksum 0x70d61792, Offset: 0x1598
// Size: 0x16d
function private function_e4204e7cad729b8d( params, activity )
{
    player = self;
    player endon( #"death" );
    player endon( #"hash_24928a6c9cd6611f" );
    player.currentobjective = "capricorn_roji_tower_top";
    
    if ( !player waypoint_objective_handler::function_c2eeb9e0ffc2533d( player.currentobjective ) )
    {
        activity thread ob_story_mission_utils::function_56960723e6738b6c( undefined, player.currentobjective, { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "tower_top_reached", undefined, [ player ], 0, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    }
    
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( "roji_roof_elevator_interact_outside_done", "capricorn_roji_tower_top" );
    
    while ( true )
    {
        player waittill( #"player_teleport_start" );
        mp_sat_ob_capricorn::cancel_waypoint_objective_handler( player.currentobjective, player );
        player waittill( #"player_teleport_end" );
        
        if ( !player waypoint_objective_handler::function_c2eeb9e0ffc2533d( player.currentobjective ) )
        {
            activity thread ob_story_mission_utils::function_56960723e6738b6c( undefined, player.currentobjective, { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "tower_top_reached", undefined, [ player ], 0, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
        }
    }
}

// Namespace mp_sat_ob_capricorn_roji
// Params 1, eflags: 0x4
// Checksum 0x4637a273, Offset: 0x170d
// Size: 0x92
function private function_cf0e4493cde84422( move_statue )
{
    model_hand = getent( "hand_statue_move", "targetname" );
    var_e65dff31d9660d95 = getent( "hand_statue_mic", "targetname" );
    model_collision = getent( "hand_statue_collision", "targetname" );
    var_e65dff31d9660d95 linkto( model_hand );
    model_collision linkto( model_hand );
    
    while ( move_statue )
    {
        model_hand rotateyaw( -90, 5, 1, 1 );
        wait 5;
        model_hand rotateyaw( 90, 5, 1, 1 );
        wait 5;
    }
}

