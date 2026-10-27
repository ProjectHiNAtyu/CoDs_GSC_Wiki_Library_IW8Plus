// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_forge_restricted_area.gsc  (hash_155dc6719f0bbf49.gscc) (size: 20423 Bytes / 0x4fc7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d7098e0 (762353888)
// size ...... 20423 (0x4fc7)
// includes .. 24  (offset: 0x47af)
// strings ... 127 (offset: 0x486f)
// dev strs .. 0   (offset: 0x4fc7)
// exports ... 43  (offset: 0x2f97)
// cseg ...... 0x1016 + 0x1f81 (0x2f97)
// imports ... 144 (offset: 0x364f)
// animtree1 . 0   (offset: 0x4fc7)
// animtree2 . 0   (offset: 0x4fc7)
#using script_16d8789bae43669e;
#using script_35713297c4efa490;
#using script_61b40095fd0502f0;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\vehicle_interact;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\coop;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_audio;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_chase_gdu;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_vo;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\jailbreak_machine;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_item_select;

#namespace mp_sat_ob_capricorn_forge_restricted_area;

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x5
// Checksum 0x4b41aba, Offset: 0x1034
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_ee172b4ca0d120ed", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0xd5369eaf, Offset: 0x105d
// Size: 0x137
function private function_538033a540e63c70()
{
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_RESTRICTED_AREA", "OB_CAPRICORN_FORGE_RESTRICTED_AREA", [ { #result:undefined, #var_de54801bc657ab2c:&sequence_elevator }, { #result:undefined, #var_de54801bc657ab2c:&function_6b1ffc38617c9017 } ] );
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_RESTRICTED_AREA", "OB_CAPRICORN_FORGE_RESTRICTED_AREA_COMPUTER_START", [ { #result:undefined, #var_de54801bc657ab2c:&function_cd0e50e30de5342f }, { #result:undefined, #var_de54801bc657ab2c:&function_4fd3e4f7fd830260 } ] );
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_RESTRICTED_AREA", "OB_CAPRICORN_FORGE_RESTRICTED_AREA_COMPUTER", [ { #result:undefined, #var_de54801bc657ab2c:&function_df99ee379500245b }, { #result:undefined, #var_de54801bc657ab2c:&function_22d704d32b4f13fe } ] );
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_RESTRICTED_AREA", "OB_CAPRICORN_FORGE_RESTRICTED_AREA_GARAGE_COMPLETED", [ { #result:undefined, #var_de54801bc657ab2c:&function_9d59028078fae410 } ] );
    ob_story_mission_activity_setup::function_13cff85d193f6c27( "CAPRICORN_RESTRICTED_AREA", &restricted_area_setup );
    ob_story_mission_activity_setup::function_159af14427677b6c( "CAPRICORN_RESTRICTED_AREA", &restricted_area_destroy );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0x4c2b89df, Offset: 0x119c
// Size: 0x300
function private restricted_area_setup()
{
    thread namespace_14fc50a6bcc28440::function_c89c8c8e27d1c8ec();
    namespace_14fc50a6bcc28440::set_minimap( "restricted_area" );
    thread setup_jailbreak();
    case_struct = utility::getstruct( "security_area_ability_case", "targetname" );
    thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_vision_pulse", "super_drone_launcher", #"default" );
    thread function_6069874c6149b511();
    level.var_f9cd1c1793438654 = &namespace_276282d3095ce278::function_d9d4b79f80d998a2;
    thread ob_story_mission_utils::item_spawn_weapon( "s_restricted_weapon", "restricted_area_staged_gear_clean_up", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_restricted_equipment", "restricted_area_staged_gear_clean_up", 1 );
    thread activity_ai_encounters::function_79c1b913ce172ac5( self, "restricted_encounter_trigger", undefined, &activity_ai_encounters::function_952687d67d74fdef, undefined, 1 );
    thread ob_story_mission_utils::function_e6799e9a19df2365( "capricorn_restricted_caches" );
    thread function_a11fe96307e873a1();
    thread namespace_14fc50a6bcc28440::encounter_create_squad( "ai_encounter_capricorn_restricted_tunnel" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"lock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "restricted_area_quantum_computer_door" );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"lock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "restricted_door_cooling_to_quantum" );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"lock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "restricted_area_quantum_go_to_garage_door" );
    }
    
    switch ( level.current_activity.type )
    {
        case #"hash_4f98713871a79664":
            function_fdad13ac6b321a60();
            break;
        case #"hash_d1556795f64d8f5b":
            function_fdad13ac6b321a60();
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"hash_db1e4159151acded" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                level [[ var_32dbca3143d9c4a5 ]]( "restricted_area_quantum_computer_door" );
            }
            
            break;
        case #"hash_dda68f0ca89dccbc":
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"hash_db1e4159151acded" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                level [[ var_32dbca3143d9c4a5 ]]( "restricted_area_quantum_go_to_garage_door" );
            }
            
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"hash_db1e4159151acded" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                level [[ var_32dbca3143d9c4a5 ]]( "restricted_area_quantum_computer_door" );
            }
            
            break;
        case #"hash_6f01176b6b24737a":
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"hash_db1e4159151acded" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                level [[ var_32dbca3143d9c4a5 ]]( "restricted_area_quantum_go_to_garage_door" );
            }
            
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"hash_db1e4159151acded" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                level [[ var_32dbca3143d9c4a5 ]]( "restricted_area_quantum_computer_door" );
            }
            
            init_trailer_scene();
            thread function_c4c2d7c6d471a80a();
            break;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"unlock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "restricted_door_intro_to_cooling" );
    }
    
    level thread setup_force_fields();
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0xcf3c3778, Offset: 0x14a4
// Size: 0x37
function private function_fdad13ac6b321a60()
{
    level.var_b93d9c6a4bb876fa = [];
    
    if ( level.players.size >= 3 )
    {
        thread function_eb93ba251e300eaa( "computer_defense_bot_large" );
        return;
    }
    
    thread function_eb93ba251e300eaa( "computer_defense_bot" );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0
// Checksum 0xa7c88467, Offset: 0x14e3
// Size: 0x14
function restricted_area_destroy()
{
    level utility::flag_set( "restricted_area_staged_gear_clean_up" );
    removeallcorpses();
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 3, eflags: 0x4
// Checksum 0x27abe39b, Offset: 0x14ff
// Size: 0xe5
function private function_51d6fb0508c7e40( activity_instance, encounter_name, player )
{
    if ( encounter_name == "encounter_metro_03" )
    {
        flashgrenadeweapon = equipment_mp::getweaponfromequipmentref( "equip_flash" );
        owner = level.players[ 0 ];
        position = ( -12069, -59095, -41 );
        position2 = ( -12191, -59079, -40 );
        vectorforward = vectornormalize( position - position2 );
        velocity = vectorforward * 300;
        fuse = 1;
        flash = owner launchgrenade( flashgrenadeweapon.basename ?? "sat_flash_grenade_mp", position, velocity, fuse );
        level utility::flag_set( "flag_vo_restricted_area_subway_flashbang_ambush" );
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 3, eflags: 0x4
// Checksum 0xe48fbdbd, Offset: 0x15ec
// Size: 0x63
function private function_7bcd87f50b74a606( activity_instance, encounter_name, player )
{
    droneoptions = spawnstruct();
    droneoptions.activationdelay = 0.5;
    namespace_14fc50a6bcc28440::spawn_turret_drone( activity_instance, encounter_name, droneoptions );
    level utility::flag_set_delayed( "flag_vo_restricted_area_garage_drones_spawned", 1 );
    thread namespace_14fc50a6bcc28440::function_36a2524eb4edf91a( activity_instance, encounter_name );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0xdc67d524, Offset: 0x1657
// Size: 0x2e
function private function_ef4d9f8b7fd099b3()
{
    encounter_id = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_capricorn_restricted_vista", 1, 0, 1, 1 );
    ai_spawn_director::add_spawned_callback( encounter_id, &function_943a46e2e7d858f4 );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 4, eflags: 0x4
// Checksum 0xd47c9c21, Offset: 0x168d
// Size: 0x43
function private function_943a46e2e7d858f4( requestid, instance, agent, ai_data )
{
    agent.ignoreall = 1;
    agent.kfe_ignore = 1;
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 1, eflags: 0x4
// Checksum 0x997ef632, Offset: 0x16d8
// Size: 0x9f
function private function_daff594b43172b6f( var_d181c60c1b529a2b )
{
    turret_structs = utility::getstructarray( var_d181c60c1b529a2b, "targetname" );
    
    foreach ( var_555a947463e55350 in turret_structs )
    {
        turret = ob_soldier_util::ob_sentry_turret_spawn( var_555a947463e55350 );
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0x557b976e, Offset: 0x177f
// Size: 0x1bb
function private sequence_elevator()
{
    activity_instance = self;
    fade_to_black( 1, 0 );
    function_84db29856a95eac1();
    elevator_doors = getscriptablearray( "restricted_area_elevator_door", #targetname );
    var_a7165335e6116f30 = getent( "restricted_elevator_door_bottom", "targetname" );
    var_f4ad079a3e073cc8 = getent( "restricted_elevator_door_top", "targetname" );
    var_a7165335e6116f30 linkto( elevator_doors[ 0 ], "j_door_02" );
    var_f4ad079a3e073cc8 linkto( elevator_doors[ 0 ], "j_door_01" );
    var_a7165335e6116f30 connectpaths();
    var_f4ad079a3e073cc8 connectpaths();
    utility::players_stream_wait( level.players );
    
    if ( isdefined( elevator_doors ) && elevator_doors.size > 0 )
    {
        capricorn_audio::function_3ed9b3c2d81f1d99( elevator_doors[ 0 ].origin );
        thread capricorn_audio::function_7a41d84cc84c11e2();
    }
    
    wait 2;
    utility::flag_set( "flag_forge_restricted_elevator" );
    
    if ( isdefined( elevator_doors ) && elevator_doors.size > 0 )
    {
        earthquake( 0.3, 3, elevator_doors[ 0 ].origin, 2000 );
        playrumbleonposition( "capricorn_world_medium", elevator_doors[ 0 ].origin );
    }
    
    fade_to_black( 0, 1 );
    thread mp_sat_ob_capricorn_vo::function_181bcaf98baacce2();
    wait 3;
    utility::flag_set( "flag_forge_restricted_elevator_open" );
    
    foreach ( door in elevator_doors )
    {
        door setscriptablepartstate( "main", "open" );
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0x1d91d1be, Offset: 0x1942
// Size: 0x5c
function private function_84db29856a95eac1()
{
    a_s_start = ob_story_mission_utils::get_activity_starts( "OB_CAPRICORN_FORGE_RESTRICTED_AREA" );
    
    if ( !isarray( a_s_start ) )
    {
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        coop::teleport_player( level.players[ i ], a_s_start[ i ] );
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 2, eflags: 0x4
// Checksum 0x60db2c1b, Offset: 0x19a6
// Size: 0x91
function private fade_to_black( fade_to_black, duration )
{
    foreach ( player in level.players )
    {
        level thread game_utility::fadetoblackforplayer( player, fade_to_black, duration );
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0x6dcd68c6, Offset: 0x1a3f
// Size: 0x2d1
function private function_6b1ffc38617c9017()
{
    activity_instance = self;
    thread function_ef4d9f8b7fd099b3();
    activity_ai_encounters::function_79c1b913ce172ac5( self, "encounter_trigger_restricted_area", undefined, &activity_ai_encounters::function_952687d67d74fdef, undefined, 1 );
    thread function_8d270ede5fb92184();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_RESTRICTED_AREA" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_restricted_computer_room", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "computer_room_reached", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread namespace_14fc50a6bcc28440::function_776ea74dd9e92d46( "flag_restricted_enter_cooling_room", "capricorn_restricted_computer_room" );
    level utility::flag_wait( "flag_vo_restricted_area_cooling_room_clear" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_RESTRICTED_AREA" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_restricted_computer_room", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "computer_room_reached", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread namespace_14fc50a6bcc28440::function_776ea74dd9e92d46( "flag_restricted_area_quantum_computer_room_opened", "capricorn_restricted_computer_room" );
    interactstruct = utility::getstruct( "restricted_area_quantum_computer_room_interact" );
    
    if ( !interactstruct )
    {
        interactstruct = { #angles:( 0, 0, 0 ), #origin:( -13539, -63389, -20 ) };
    }
    
    interact = interaction::register_interact( interactstruct.origin, 64, &function_7aa304e386ebcb2a, &"jup_ob_objectives/interact_activate" );
    interact setcursorhint( "HINT_BUTTON" );
    level waittill( #"flag_restricted_area_quantum_computer_room_opened", player );
    var_678759dcf4f532b7 = namespace_1f3f9eb1e9681da5::function_ffc96a24d6f74919( "player_catchup_restricted_area_computer_start", self, "flag_computer_catchup_complete", 5, "flag_computer_catchup_start" );
    var_ba7c3b8fa9d3823 = spawnstruct();
    var_ba7c3b8fa9d3823.origin = ( -13311.5, -63301.1, -55.58 );
    options = spawnstruct();
    options.flag_completed = "player_regroup_restricted_area_computer_completed";
    options.fadestartnone = 1;
    options.var_227ead15d2892709 = 1;
    options.var_ba7c3b8fa9d3823 = var_ba7c3b8fa9d3823;
    options.teleport_structs = var_678759dcf4f532b7.teleport_structs;
    options.var_560eecb53e318cbf = 1;
    options.var_2b79828dcc50cbcc = 1;
    options.ignore_cleanup = 1;
    options.triggerradius = 550;
    thread coop::function_ca1c6723a350447f( options );
    utility::flag_wait( "player_regroup_restricted_area_computer_completed" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"lock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "restricted_door_cooling_to_quantum" );
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0
// Checksum 0x12243e8e, Offset: 0x1d18
// Size: 0x199
function function_cd0e50e30de5342f()
{
    activity_instance = self;
    thread mp_sat_ob_capricorn_vo::function_1d318dd57a696070();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_RESTRICTED_AREA_DECRYPT" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_restricted_computer", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "computer_reached", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread namespace_14fc50a6bcc28440::function_776ea74dd9e92d46( "flag_restricted_quantum_computer_interact_start", "capricorn_restricted_computer" );
    deactivateworldevent( "Light_Computer_Room" );
    interactstruct = utility::getstruct( "obj_struct_restricted_area_get_twin_drive" );
    interact = interaction::register_interact( interactstruct.origin, 64, &function_32c7c95bd3d646bf, &"jup_ob_objectives/interact_activate" );
    interact setcursorhint( "HINT_BUTTON" );
    level waittill( #"flag_restricted_quantum_computer_interact_start", player );
    level utility::flag_set( "flag_vo_quantum_computer_interact" );
    anim_struct = utility::getstruct( "restricted_area_drive_animnode", "targetname" );
    level.var_3d9fc7aa7b25b565.usb_drive = spawn( "script_model", player gettagorigin( "TAG_ACCESSORY_RIGHT" ) );
    level.var_3d9fc7aa7b25b565.usb_drive setmodel( %"electronics_usb_thumb_drive" );
    level.var_3d9fc7aa7b25b565.usb_drive linkto( player, "TAG_ACCESSORY_RIGHT" );
    player thread function_d34c35ce5ffa2475();
    anim_struct scene::play( [ player ] );
    thread capricorn_audio::function_ed847a2000673574( interactstruct );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0
// Checksum 0xb7af8b49, Offset: 0x1eb9
// Size: 0xa1
function function_d34c35ce5ffa2475()
{
    self endon( #"death" );
    self waittill( #"detach" );
    position = utility::getstruct( "quantum_computer_thumb_drive_location", "targetname" );
    level.var_3d9fc7aa7b25b565.usb_drive unlink();
    level.var_3d9fc7aa7b25b565.usb_drive.origin = position.origin;
    level.var_3d9fc7aa7b25b565.usb_drive.angles = position.angles;
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0xae24315e, Offset: 0x1f62
// Size: 0x56
function private function_8d270ede5fb92184()
{
    level utility::flag_wait( "ai_encounter_capricorn_restricted_cooling_room_completed" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"unlock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "restricted_door_cooling_to_quantum" );
    }
    
    level utility::flag_set( "flag_vo_restricted_area_cooling_room_clear" );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 1, eflags: 0x4
// Checksum 0x985a1d56, Offset: 0x1fc0
// Size: 0x6a
function private function_7aa304e386ebcb2a( player )
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"hash_db1e4159151acded" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "restricted_area_quantum_computer_door" );
    }
    
    utility::flag_set( "flag_restricted_area_quantum_computer_room_opened", player );
    thread capricorn_audio::function_e5ef3603af687f1b( self.origin );
    self delete();
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 1, eflags: 0x4
// Checksum 0x1b23d29, Offset: 0x2032
// Size: 0x2e
function private function_32c7c95bd3d646bf( player )
{
    utility::flag_set( "flag_restricted_quantum_computer_interact_start", player );
    utility::flag_set( "flag_restricted_area_twin_drive_acquired_start", player );
    self delete();
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0xe5c2e465, Offset: 0x2068
// Size: 0x207
function private function_4fd3e4f7fd830260()
{
    activity_instance = self;
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_RESTRICTED_AREA_DEFEND" );
    level utility::flag_set( "flag_computer_defense_wave_01_start" );
    level utility::flag_wait( "flag_restricted_computer_wave_01_done" );
    [ encounter_id, agents ] = activity_ai_encounters::function_e9091e3a4b3537eb( self, "computer_defense_wave_03", "flag_restricted_computer_wave_02_done", 4 );
    
    if ( agents )
    {
        agents function_1e2a65ced6295ba0();
    }
    
    wait 1;
    turn_on_force_field( "restricted_corridor_ff", "targetname" );
    wait 2;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"hash_db1e4159151acded" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "restricted_door_cooling_to_quantum" );
    }
    
    level utility::flag_set( "flag_computer_defense_wave_02_start" );
    level utility::flag_wait( "flag_restricted_computer_wave_02_done" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_RESTRICTED_AREA_DECRYPTED" );
    utility::flag_set( "flag_restricted_computer_encounter_done", level );
    interactstruct = utility::getstruct( "obj_struct_restricted_area_get_twin_drive" );
    interact = interaction::register_interact( interactstruct.origin, 64, &function_f665766100acc7a8, &"jup_ob_objectives/interact_activate" );
    interact setcursorhint( "HINT_BUTTON" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_restricted_computer", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "computer_reached", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread namespace_14fc50a6bcc28440::function_776ea74dd9e92d46( "flag_restricted_quantum_computer_interact_completed", "capricorn_restricted_computer" );
    level waittill( #"flag_restricted_quantum_computer_interact_completed", player );
    anim_struct = utility::getstruct( "restricted_area_drive_out_animnode", "targetname" );
    anim_struct scene::play( [ level.var_3d9fc7aa7b25b565.usb_drive, player ] );
    utility::flag_set( "flag_restricted_area_twin_drive_acquired" );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0x3397fa65, Offset: 0x2277
// Size: 0x88
function private function_1e2a65ced6295ba0()
{
    agents = self;
    
    if ( isarray( agents ) )
    {
        foreach ( agent in agents )
        {
            agent thread function_c6a9f55a1fb76e83();
        }
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0x3d3b01c, Offset: 0x2307
// Size: 0x19
function private function_c6a9f55a1fb76e83()
{
    agent = self;
    agent mp_sat_ob_libra_util::function_90c440460dba0ba2( 0 );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 1, eflags: 0x4
// Checksum 0x98d375ce, Offset: 0x2328
// Size: 0x5a
function private function_f665766100acc7a8( player )
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"hash_db1e4159151acded" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "restricted_area_quantum_go_to_garage_door" );
    }
    
    utility::flag_set( "flag_restricted_quantum_computer_interact_completed", player );
    self delete();
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 1, eflags: 0x4
// Checksum 0x9c83aa35, Offset: 0x238a
// Size: 0x98
function private spawn_dawg( struct )
{
    dawg = mp_agent::spawnnewagentaitype( "sat_dawg_sm", struct.origin, struct.angles, "team_hundred_ninety" );
    owner = utility::spawn_tag_origin( struct.origin, struct.angles );
    owner.team = "team_hundred_ninety";
    setupstruct = { #timeout_disabled:1 };
    dawg dawg::dawgpostinit( owner, setupstruct );
    return dawg;
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0xa9b7f995, Offset: 0x242b
// Size: 0x26
function private init_trailer_scene()
{
    level.trailer_scene_struct = utility::getstruct( "sat_cin_cap_395_forge_restricted_area_trailer_drone" );
    level.trailer_scene_struct scene::init();
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0x42d6f2a0, Offset: 0x2459
// Size: 0x18f
function private function_df99ee379500245b()
{
    activity_instance = self;
    init_trailer_scene();
    thread mp_sat_ob_capricorn_vo::function_c0ac404eaba06846();
    activity_ai_encounters::function_79c1b913ce172ac5( self, "encounter_trigger_restricted_area_01", &function_51d6fb0508c7e40, &activity_ai_encounters::function_952687d67d74fdef );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_RESTRICTED_AREA_ESCAPE" );
    forcefield = getent( "restricted_computer_ff", "targetname" );
    
    if ( forcefield )
    {
        thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_restricted_computer_forcefield_01", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "capricorn_forge_security_room_button_done", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
        level thread namespace_14fc50a6bcc28440::function_776ea74dd9e92d46( "flag_computer_ff_destroyed", "capricorn_restricted_computer_forcefield_01" );
        level utility::flag_wait( "flag_computer_ff_destroyed" );
    }
    
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_restricted_computer_forcefield_02", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "capricorn_forge_security_room_button_done", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread namespace_14fc50a6bcc28440::function_776ea74dd9e92d46( "flag_garage_ff_destroyed", "capricorn_restricted_computer_forcefield_02" );
    level utility::flag_wait( "flag_garage_ff_destroyed" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_restricted_garage_button", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "garage_button_reached", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread namespace_14fc50a6bcc28440::function_776ea74dd9e92d46( "restricted_area_garage_opened", "capricorn_restricted_garage_button" );
    level utility::flag_wait( "flag_restricted_enter_garage" );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0xda1fec41, Offset: 0x25f0
// Size: 0xcf
function private function_22d704d32b4f13fe()
{
    level.trailer_scene_struct thread scene::play();
    activity_ai_encounters::function_79c1b913ce172ac5( self, "encounter_trigger_restricted_area", &function_7bcd87f50b74a606, &activity_ai_encounters::function_952687d67d74fdef );
    interactstructs = utility::getstructarray( "interact_forge_restricted_area_tunnel_gate_open" );
    interact = interaction::register_interact( interactstructs[ 0 ].origin, 64, &restricted_area_tunnel_gate_open, &"jup_ob_objectives/interact_activate" );
    interact setcursorhint( "HINT_BUTTON" );
    level waittill( #"restricted_area_tunnel_gate_open" );
    level utility::flag_set( "flag_vo_restricted_area_garage_door" );
    function_c1412872e70aa28b( "capricorn_restricted_area_garage_button", "accepted" );
    thread capricorn_audio::function_fe35739e161d0c5d( interactstructs[ 0 ].origin );
    wait 1;
    thread open_bunker_blast_door();
    level utility::flag_set( "restricted_area_garage_opened" );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 1, eflags: 0x4
// Checksum 0x54a5c081, Offset: 0x26c7
// Size: 0x1e
function private restricted_area_tunnel_gate_open( player )
{
    level notify( #"restricted_area_tunnel_gate_open" );
    self delete();
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0x2bcf902f, Offset: 0x26ed
// Size: 0xd4
function private function_9d59028078fae410()
{
    utility::trigger_off( "encounter_trigger_restricted_area", "targetname" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_restricted_garage_exit", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "garage_exit_reached", undefined, undefined, 0, 1, 0, 1, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread namespace_14fc50a6bcc28440::function_776ea74dd9e92d46( "flag_restricted_activity_completed", "capricorn_restricted_garage_exit" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_RESTRICTED_AREA_SUBWAY" );
    thread function_daff594b43172b6f( "garage_ambush_turret" );
    thread mp_sat_ob_capricorn_vo::function_d8700cb3aac99139();
    activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_capricorn_restricted_tunnel", 1, 1, 1, 1 );
    activity_ai_encounters::function_79c1b913ce172ac5( self, "ai_encounter_capricorn_restricted_metro_station", &function_51d6fb0508c7e40, &activity_ai_encounters::function_952687d67d74fdef, &function_a6f8e50c19b5adaf );
    level utility::flag_wait( "flag_restricted_activity_completed" );
    level notify( #"hash_a90894fda4feb874" );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0x92337ae6, Offset: 0x27c9
// Size: 0x98
function private function_a11fe96307e873a1()
{
    blast_doors = getscriptablearray( "restricted_area_blast_door_2", #targetname );
    
    foreach ( blast_door in blast_doors )
    {
        blast_door setscriptablepartstate( "bunker_door", "closed" );
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0
// Checksum 0xc4e0214e, Offset: 0x2869
// Size: 0x8b
function open_bunker_blast_door()
{
    blast_door = getscriptablearray( "restricted_area_blast_door_2", #targetname )[ 0 ];
    var_75a7b2314b830461 = getent( "blast_door_collision_left", "targetname" );
    var_dc9e15b53fef0de2 = getent( "blast_door_collision_right", "targetname" );
    var_75a7b2314b830461 linkto( blast_door, "j_bunker_door_left" );
    var_dc9e15b53fef0de2 linkto( blast_door, "j_bunker_door_right" );
    var_75a7b2314b830461 connectpaths();
    var_dc9e15b53fef0de2 connectpaths();
    blast_door setscriptablepartstate( "bunker_door", "opening" );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0
// Checksum 0x99695d72, Offset: 0x28fc
// Size: 0x46
function function_c4c2d7c6d471a80a()
{
    triggers = getnoentvolumearray( "capricorn_restricted_area_open_blast_door_from_checkpoint", #targetname );
    
    if ( triggers[ 0 ] )
    {
        triggers[ 0 ] waittill( #"trigger", player );
    }
    
    open_bunker_blast_door();
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0
// Checksum 0x91a21ed9, Offset: 0x294a
// Size: 0x3a
function setup_jailbreak()
{
    scriptables = getentitylessscriptablearray( "capricorn_jailbreak", "script_noteworthy" );
    
    if ( isdefined( scriptables ) && scriptables.size > 0 )
    {
        scriptables[ 0 ] jailbreak_machine::init( 0, 2, 1 );
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0, eflags: 0x4
// Checksum 0x346ccc05, Offset: 0x298c
// Size: 0x79
function private function_6069874c6149b511()
{
    level endon( #"hash_3873487e84716366" );
    trigger = getnoentvolumearray( "OB_CAPRICORN_WALL_JUMP_HINT", "targetname" );
    
    while ( true )
    {
        trigger[ 0 ] waittill( #"trigger", player );
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_wall_jump", &"sat_ob_story_missions_capricorn/ob_capricorn_wall_jump_hint", 10, undefined, undefined, undefined, undefined, 0 );
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 1
// Checksum 0x6bb4826c, Offset: 0x2a0d
// Size: 0x19b
function function_eb93ba251e300eaa( bot_targetname )
{
    computer_bots = utility::getstructarray( bot_targetname, "targetname" );
    
    foreach ( computer_bot in computer_bots )
    {
        computer_bot scene::add_spawn_function( &function_de62ac43fb0a4686, "Types_Actor" );
        computer_bot thread scene::play( undefined, "idle" );
    }
    
    level utility::flag_wait( "flag_computer_defense_wave_01_start" );
    
    foreach ( computer_bot in computer_bots )
    {
        if ( computer_bot.script_noteworthy == "1" )
        {
            delay_time = 0;
        }
        
        if ( computer_bot.script_noteworthy == "2" )
        {
            delay_time = 4;
        }
        
        if ( computer_bot.script_noteworthy == "3" )
        {
            delay_time = 8;
        }
        
        if ( computer_bot.script_noteworthy == "4" )
        {
            delay_time = 14;
        }
        
        computer_bot utility::delaythread( delay_time, &function_1f5c506d73337c32, computer_bot.script_noteworthy );
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0
// Checksum 0xcb33409d, Offset: 0x2bb0
// Size: 0xe9
function function_de62ac43fb0a4686()
{
    level.var_b93d9c6a4bb876fa[ level.var_b93d9c6a4bb876fa.size ] = self;
    self.var_c3c4d711e69d5ab9 = 1;
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.kfe_ignore = 1;
    self.var_24954f14e27b448d = 0;
    self.var_2fc3a5fb762afb6e = 1;
    level notify( #"highvis_reload_outline", undefined, [ self ] );
    level utility::flag_wait( "flag_computer_defense_wave_01_start" );
    utility::ent_flag_waitopen_any( "scene_active" );
    self.var_c3c4d711e69d5ab9 = 0;
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.kfe_ignore = undefined;
    self.var_2fc3a5fb762afb6e = 0;
    level notify( #"highvis_reload_outline", undefined, [ self ] );
    self.var_24954f14e27b448d = 1;
    self waittill( #"death" );
    function_87c9dc12f3244d2d();
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0
// Checksum 0x1c490442, Offset: 0x2ca1
// Size: 0x37
function function_87c9dc12f3244d2d()
{
    level.var_b93d9c6a4bb876fa = utility::array_removedead_or_dying( level.var_b93d9c6a4bb876fa );
    
    if ( level.var_b93d9c6a4bb876fa.size < 1 )
    {
        level utility::flag_set( "flag_restricted_computer_wave_01_done" );
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 1
// Checksum 0x8d758f23, Offset: 0x2ce0
// Size: 0x1c
function function_1f5c506d73337c32( exit_num )
{
    thread scene::play( undefined, "exit_0" + exit_num );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 3, eflags: 0x4
// Checksum 0x620998e4, Offset: 0x2d04
// Size: 0xb2
function private function_a6f8e50c19b5adaf( requestid, userdata, vehicle )
{
    player_team = level.players[ 0 ].team;
    vehicle.godmode = 1;
    vehicle setturretscriptcontrolled( 1, 1 );
    vehicle turret::function_e2d699d813d8eac1( ( 165, 5, 0 ) );
    vehicle turret::function_42ec7ba446a3e025( ( 240, 5, 0 ) );
    vehicle turret::function_9b1f535339c80a4( 1 );
    vehicle turret::function_40a195262f7f99ab( 1, [ player_team ] );
    vehicle vehicle_turnengineon();
    vehicle_interact::allow_use( vehicle, 0 );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 0
// Checksum 0x711b5a78, Offset: 0x2dbe
// Size: 0x7b
function setup_force_fields()
{
    mp_sat_ob_libra_util::function_7e4765db24e0ee73( "on", "restricted_computer_ff", #targetname );
    mp_sat_ob_libra_util::function_7e4765db24e0ee73( "off", "restricted_corridor_ff", #targetname );
    
    if ( level.current_activity.type != "OB_CAPRICORN_FORGE_RESTRICTED_AREA_GARAGE_COMPLETED" )
    {
        mp_sat_ob_libra_util::function_7e4765db24e0ee73( "on", "restricted_garage_ff", #targetname );
        return;
    }
    
    namespace_14fc50a6bcc28440::function_d1e2187515b5099f( "restricted_garage_ff" );
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 2
// Checksum 0x8cf14a34, Offset: 0x2e41
// Size: 0xa8
function turn_on_force_field( force_field_name, key = #targetname )
{
    force_fields = getentarray( force_field_name, key );
    
    foreach ( ff in force_fields )
    {
        ff mp_sat_ob_libra_util::force_field_on();
    }
}

// Namespace mp_sat_ob_capricorn_forge_restricted_area
// Params 2, eflags: 0x4
// Checksum 0x25fbef9a, Offset: 0x2ef1
// Size: 0xa6
function private function_c1412872e70aa28b( targetname, state )
{
    buttons = getentitylessscriptablearray( targetname, #targetname );
    waitframe();
    
    foreach ( button in buttons )
    {
        button setscriptablepartstate( "base", state );
    }
}

