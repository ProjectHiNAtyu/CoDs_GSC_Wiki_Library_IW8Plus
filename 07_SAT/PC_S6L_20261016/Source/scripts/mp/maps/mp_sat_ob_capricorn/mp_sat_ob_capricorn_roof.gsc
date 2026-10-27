// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_roof.gsc  (hash_15ad7fde5ad4e10e.gscc) (size: 19795 Bytes / 0x4d53 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6c284f0 (113411312)
// size ...... 19795 (0x4d53)
// includes .. 28  (offset: 0x473f)
// strings ... 91  (offset: 0x481f)
// dev strs .. 8   (offset: 0x4ce7)
// exports ... 48  (offset: 0x2b2b)
// cseg ...... 0x8a1 + 0x228a (0x2b2b)
// imports ... 176 (offset: 0x32ab)
// animtree1 . 0   (offset: 0x4d53)
// animtree2 . 0   (offset: 0x4d53)
#using script_35713297c4efa490;
#using script_3ec57c71b0b61f00;
#using script_3edd59d0d3fc3262;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\stealth\threat_sight;
#using scripts\common\callbacks;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_audio;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_hijack_throttle;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_vo;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_vtol_utils;
#using scripts\mp\ob\activities\ob_activity_gunship_heli;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\objidpoolmanager;

#namespace mp_sat_ob_capricorn_roof;

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x5
// Checksum 0xefec8d42, Offset: 0x8bf
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_ob_capricorn_roof", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x6da26d7a, Offset: 0x8e8
// Size: 0x102
function private function_538033a540e63c70()
{
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_ROOF", "OB_CAPRICORN_ROOF", [ { #result:undefined, #var_de54801bc657ab2c:&function_1bba2bcdd50fb8fd }, { #result:undefined, #var_de54801bc657ab2c:&function_4ab8d3544d4ed1c8 } ] );
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_ROOF", "OB_CAPRICORN_ROOF_EMP", [ { #result:undefined, #var_de54801bc657ab2c:&function_17efcbd91e7275ce }, { #result:undefined, #var_de54801bc657ab2c:&function_9b1a0ceea9a1bf6b }, { #result:undefined, #var_de54801bc657ab2c:&phase_activate_emp }, { #result:undefined, #var_de54801bc657ab2c:&function_c66a7a5331eb8eee }, { #result:undefined, #var_de54801bc657ab2c:&phase_exfil } ] );
    ob_story_mission_activity_setup::function_13cff85d193f6c27( "CAPRICORN_ROOF", &function_d77111aad62e5956 );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0
// Checksum 0xee9f7b16, Offset: 0x9f2
// Size: 0x64
function function_d77111aad62e5956()
{
    level.request_ids = undefined;
    namespace_14fc50a6bcc28440::set_minimap( "roji" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_roof_weapon", undefined, 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_roof_equipment", undefined, 1 );
    thread ob_story_mission_utils::function_fa27c4afc0f886da( "s_roof_item", undefined, 1 );
    level thread ob_story_mission_utils::function_b0bc4cf3be6ad752( "roof_trigger_fails" );
    level callback::add( "on_agent_spawned", &guild_bot_on_spawned );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0
// Checksum 0xabb0c335, Offset: 0xa5e
// Size: 0x4c
function function_1bba2bcdd50fb8fd()
{
    thread mp_sat_ob_capricorn_vo::function_53347a20ac46aab3();
    thread namespace_14fc50a6bcc28440::function_c89c8c8e27d1c8ec();
    mp_sat_ob_capricorn_hijack_throttle::throttle_area_swap();
    threat_sight::threat_sight_set_enabled( 0 );
    function_b0621c752bba4833();
    
    /#
        init_debug();
    #/
    
    level.var_3d9fc7aa7b25b565.rocket_launcher_used = 0;
    elevator_introduction();
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0
// Checksum 0x3e20cef6, Offset: 0xab2
// Size: 0xc8
function elevator_introduction()
{
    activity_instance = self;
    fade_to_black( 1, 0 );
    ob_story_mission_utils::function_2686bb512b355040( "OB_CAPRICORN_ROOF", 1 );
    wait 0.1;
    elevator_origin = level.var_d94fd043f14f11c9[ "roof_small_elevator_top" ][ 0 ].origin;
    earthquake( 0.3, 3, elevator_origin, 2000 );
    wait 2;
    fade_to_black( 0, 1 );
    capricorn_audio::function_b6af3d091facf18d( elevator_origin );
    thread capricorn_audio::function_8ba0df2dc7d45480();
    wait 3;
    level utility::flag_set( "elevator_reached_roof" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"unlock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "roof_small_elevator_top" );
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 2, eflags: 0x4
// Checksum 0xf92462f1, Offset: 0xb82
// Size: 0x91
function private fade_to_black( fade_to_black, duration )
{
    foreach ( player in level.players )
    {
        level thread game_utility::fadetoblackforplayer( player, fade_to_black, duration );
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0
// Checksum 0x583f9d4d, Offset: 0xc1b
// Size: 0xe8
function spawn_turret_drone()
{
    if ( getdvarint( @"hash_8d15b5b3f90ff719", 0 ) == 1 )
    {
        return;
    }
    
    var_b3daf67a5a5ba863 = utility::getstructarray( "ai_encounter_capricorn_roji_roof_drone_defend", "targetname" );
    droneoptions = spawnstruct();
    droneoptions.activationdelay = 0.3;
    droneoptions.scannerlogic = 1;
    
    foreach ( node in var_b3daf67a5a5ba863 )
    {
        ob_flying_drone::spawn_helper_drone( node.script_noteworthy, level.players[ 0 ], undefined, node, droneoptions );
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x584a2ca8, Offset: 0xd0b
// Size: 0x16e
function private function_4ab8d3544d4ed1c8()
{
    activity_instance = self;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    thread capricorn_audio::function_1759d7be335cfc85();
    chopper = namespace_d735b26ffb28d82a::function_aec87cf75ef5fbc4();
    chopper namespace_d735b26ffb28d82a::function_f6098d122e2499e3( 1 );
    chopper namespace_7161222aac9ca916::function_bfaacd2d206fbda3( 1 );
    level.var_3d9fc7aa7b25b565.roof_boss = chopper;
    level.var_3d9fc7aa7b25b565.roof_boss playrumblelooponentity( "capricorn_world_vtol" );
    level.var_3d9fc7aa7b25b565.roof_boss thread function_2836f33f1b1e99ab();
    level.var_3d9fc7aa7b25b565.roof_boss.var_521099eccef67894 = 1;
    visibility_mode::function_3afc3bc470c80e61( level.var_3d9fc7aa7b25b565.roof_boss, level.var_3d9fc7aa7b25b565.roof_boss.team );
    level notify( #"highvis_reload_outline", level.var_3d9fc7aa7b25b565.roof_boss.team, [ level.var_3d9fc7aa7b25b565.roof_boss ] );
    level.var_3d9fc7aa7b25b565.roof_boss thread function_f88c475e054d079d();
    chopper thread function_57b4d99ab3b1afe4( 0.65, 0.3, 0.8 );
    chopper waittill( #"boss_target_health_reached" );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x3280a6ab, Offset: 0xe81
// Size: 0x1d5
function private function_f88c475e054d079d()
{
    self.currentstate = "animation";
    self notify( #"state_change" );
    self.var_c3c4d711e69d5ab9 = 1;
    self vehicle_teleport( ( -13397.5, -45985.6, 2445.1 ), ( 0, 0, 0 ) );
    initial_speed = self vehicle_getspeed();
    self vehicle_setspeedimmediate( 0 );
    level utility::flag_wait( "OB_CAPRICORN_REACHED_ROOF" );
    level utility::flag_set( "flag_roof_gunship_first_appearance" );
    self.objidnum = self.bossinstance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_boss", 0, 0 );
    objidpoolmanager::update_objective_state( self.objidnum, "active" );
    objidpoolmanager::update_objective_onentity( self.objidnum, self );
    self vehicle_cleardrivingstate();
    self function_d2b8ee2e1275daaf( 1 );
    self vehphys_forcekeyframedmotion();
    anim_completed = function_ca1a531c33e0785f();
    self vehicleclearanims();
    self stopanimscripted();
    self vehphys_setdefaultmotion();
    self function_d2b8ee2e1275daaf( 0 );
    namespace_7161222aac9ca916::chopper_movetolocation( self.origin, 1, ( 0, 0, 0 ) );
    self vehicle_setvelocity( ( 0, 0, 0 ) );
    var_95b86e61b2c6a7 = utility::array_random( level.players );
    namespace_7161222aac9ca916::function_c585f17cc1fba955( var_95b86e61b2c6a7, 420 );
    self.currenttarget = var_95b86e61b2c6a7.guid;
    self vehicle_setspeed( self.originalspeed, self.originalaccel );
    self.var_49696bc140d789dc = 0;
    namespace_d735b26ffb28d82a::function_f6098d122e2499e3( 0 );
    self.var_c3c4d711e69d5ab9 = 0;
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_ROOF" );
    
    if ( anim_completed )
    {
        self.currentstate = "attack";
        self.canreposition = !namespace_d735b26ffb28d82a::function_3397c6ad45473a58();
        self notify( #"state_change" );
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0
// Checksum 0x2f230df5, Offset: 0x105e
// Size: 0x58, Type: bool
function function_ca1a531c33e0785f()
{
    self endon( #"state_change" );
    level.var_9fe4187b1b7cd52e = 0;
    namespace_d735b26ffb28d82a::function_dd1f33638eed1c98( 1 );
    scene_struct = utility::getstruct( "sat_scene_cin_roof_intro_vtol", "targetname" );
    scene_struct scene::init( self, "init" );
    scene_struct scene::play( self );
    return true;
}

// Namespace mp_sat_ob_capricorn_roof
// Params 3
// Checksum 0x3a9f0019, Offset: 0x10bf
// Size: 0x230
function function_57b4d99ab3b1afe4( var_22ef1bb6bef5ba13, var_22ef1cb6bef5bc46, rocket_hint_health )
{
    level endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, point, type, modelname, attachtagname, partname, dflags, objweapon );
        
        if ( objweapon.classname == "rocketlauncher" && !level.var_3d9fc7aa7b25b565.rocket_launcher_used )
        {
            level.var_3d9fc7aa7b25b565.rocket_launcher_used = 1;
        }
        
        namespace_d735b26ffb28d82a::healthbar_update( amount, self.max_health );
        health_percentage = self.health / self.maxhealth;
        
        if ( health_percentage <= rocket_hint_health && !level.var_3d9fc7aa7b25b565.rocket_launcher_used )
        {
            level utility::flag_set( "flag_vo_roof_boss_reinforced_hull" );
            level notify( #"hash_7f6c54ce3c54c745" );
        }
        
        if ( health_percentage <= var_22ef1bb6bef5ba13 && !level utility::flag_exist( "flag_roof_ground_enemies_1" ) )
        {
            level utility::flag_set( "flag_roof_ground_enemies_1" );
            self.currentstate = "reinforcement";
            self.var_9f517cd4839d8ab2 = "encounter_roof_defend_assault";
            self notify( #"state_change" );
        }
        else if ( health_percentage <= var_22ef1cb6bef5bc46 && !level utility::flag_exist( "flag_roof_ground_enemies_2" ) )
        {
            level utility::flag_set( "flag_roof_ground_enemies_2" );
            self.currentstate = "reinforcement";
            self.var_9f517cd4839d8ab2 = "encounter_roof_defend_assault_02";
            self notify( #"state_change" );
        }
        
        if ( !isdefined( self ) || !isdefined( self.thresholdhealth ) || self.currenthealth <= self.thresholdhealth )
        {
            self notify( #"boss_target_health_reached" );
            return;
        }
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0xfa9c67c4, Offset: 0x12f7
// Size: 0x54
function private function_2836f33f1b1e99ab()
{
    self.fpatrol = 1;
    self notify( #"state_change" );
    self.thresholdhealth = level.var_adaaa86b7b5a18b6 * getdvarfloat( @"hash_1617f96f120d0717", 0.05 );
    ob_activity_gunship_heli::function_9cde1a77d22afe7f( self, 1 );
    self notify( #"state_change" );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x21c6e800, Offset: 0x1353
// Size: 0x305
function private function_17efcbd91e7275ce()
{
    /#
        iprintlnbold( "<dev string:x35>" );
    #/
    
    thread capricorn_audio::function_a788173f443fabc2();
    
    if ( !isdefined( level.var_3d9fc7aa7b25b565.roof_boss ) )
    {
        chopper = namespace_d735b26ffb28d82a::function_aec87cf75ef5fbc4();
        level.var_3d9fc7aa7b25b565.roof_boss = chopper;
        chopper thread function_2836f33f1b1e99ab();
        chopper.health = int( chopper.thresholdhealth );
        chopper.currenthealth = chopper.health;
        chopper namespace_d735b26ffb28d82a::healthbar_update_health();
        ob_activity_gunship_heli::function_d5f8d6a043f4d38c( chopper, 1 );
        chopper vehicle_teleport( ( -11940, -46735, 3835 ), ( 0, 268, 0 ) );
    }
    
    if ( !isdefined( level.var_3d9fc7aa7b25b565.var_2eb4c8aa45b5d24f ) )
    {
        function_b0621c752bba4833();
    }
    
    level.var_3d9fc7aa7b25b565.roof_boss notify( #"stop_shooting" );
    level.var_3d9fc7aa7b25b565.roof_boss notify( #"hash_329b7df83eae9ecf" );
    level.var_3d9fc7aa7b25b565.var_c034cb540665e574 = 1;
    level.var_3d9fc7aa7b25b565.var_fd872544d06b9bb6 = 1;
    level.var_3d9fc7aa7b25b565.roof_boss.attackcounter = 0;
    level.var_3d9fc7aa7b25b565.roof_boss.black_hat_hacked = 0;
    level.var_3d9fc7aa7b25b565.roof_boss namespace_d735b26ffb28d82a::function_dd1f33638eed1c98( 1 );
    thread mp_sat_ob_capricorn_vo::function_67d5bc2ad61d01da();
    utility::flag_set( "flag_step_plant_emp_started" );
    level.var_3d9fc7aa7b25b565.roof_boss.currentstate = "patrol";
    level.var_3d9fc7aa7b25b565.roof_boss notify( #"state_change" );
    utility::flag_wait( "flag_plant_emp_vo_finished" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_ROOF_PLANT" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_roji_emp", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "emp_plant_reached", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread namespace_14fc50a6bcc28440::function_776ea74dd9e92d46( "flag_step_plant_emp_completed", "capricorn_roji_emp" );
    var_cc9dbb3fbaaec44e = utility::getstruct( "CAPRICORN_ROOF_EMP_INTERACT" );
    interactorigin = var_cc9dbb3fbaaec44e.origin + ( 0, 0, 20 );
    interact = interaction::register_interact( interactorigin, 64, &function_3d464d6530620652, &"sat_ob_story_missions_capricorn/ob_capricorn_roof_emp_interact_title" );
    interact setcursorhint( "HINT_BUTTON" );
    interact waittill( #"hash_5b6262ff4bef27da", player );
    function_d44ee0df813009eb();
    interact delete();
    level utility::flag_set( "flag_step_plant_emp_completed" );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 2, eflags: 0x4
// Checksum 0x4137d79d, Offset: 0x1660
// Size: 0x17, Type: bool
function private function_bf6a74fc1af60ff5( requestid, data )
{
    return true;
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0xdb707f0b, Offset: 0x1680
// Size: 0x105
function private function_9b1a0ceea9a1bf6b()
{
    /#
        iprintlnbold( "<dev string:x45>" );
    #/
    
    thread capricorn_audio::function_25940a9db64c5ef9();
    
    if ( 1 && level.var_3d9fc7aa7b25b565.roof_boss )
    {
        level.var_3d9fc7aa7b25b565.roof_boss.var_4fe9c7e216477665 = 1;
    }
    
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_ROOF_DEFEND", undefined, 60 );
    level thread utility::flag_set_delayed( "flag_vo_halfway_charged", 30 );
    level thread utility::flag_set_delayed( "flag_vo_position_for_exfil", 45 );
    level thread utility::flag_set_delayed( "flag_vo_emp_charged", 60 );
    wait 5;
    level.enc_roof = activity_ai_encounters::function_92b671064b0b1ce2( "encounter_roof_defend_emp", 1, 1, 1, 1 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.enc_roof, &function_b4ca9b1a0d3cedc6 );
    ai_spawn_director::function_53289c032f506bb1( level.enc_roof, &function_bf6a74fc1af60ff5 );
    spawn_turret_drone();
    level.var_3d9fc7aa7b25b565.roof_boss thread function_9c3afd2fab582fb3();
    thread function_75eb7fb32532dc1a();
    wait 60;
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x16da74a, Offset: 0x178d
// Size: 0x73
function private function_9c3afd2fab582fb3()
{
    wait 55;
    self.stayidle = 1;
    self.currentstate = "idle";
    self notify( #"state_change" );
    self vehicle_setspeed( self.originalspeed, self.originalaccel );
    var_9787b103e667dfdb = ( -11995.6, -46476.5, 3800.72 );
    namespace_7161222aac9ca916::chopper_movetolocation( var_9787b103e667dfdb, 1, ( 0, 0, 0 ) );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0xedf8bebe, Offset: 0x1808
// Size: 0x14
function private function_75eb7fb32532dc1a()
{
    wait 50.6;
    utility::exploder( "roji_emp_anticipation" );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x3904fd46, Offset: 0x1824
// Size: 0x15b
function private function_50c98cd67e874b44()
{
    self.currentstate = "animation";
    self notify( #"state_change" );
    self vehicle_cleardrivingstate();
    self function_d2b8ee2e1275daaf( 1 );
    self vehphys_forcekeyframedmotion();
    anim_origin = ( -11995.6, -46476.5, 3800.72 );
    anim_angles = self.angles;
    self function_df84c23b1e53ff82( anim_origin, anim_angles );
    self.animname = "Vehicle 1";
    scene_struct = utility::getstruct( "sat_scene_cin_roof_emp_aftermath_vtol_react", "targetname" );
    scene_struct scene::init( self, [ "react_in", "react_loop", "crash", "destroyed" ] );
    scene_struct thread scene::play( self, [ "react_in", "react_loop" ] );
    level utility::flag_wait( "flag_start_crash_anim" );
    thread capricorn_audio::function_4189698a498d8703();
    scene_struct scene::play( self, "crash" );
    level utility::flag_set( "flag_vtol_crash_done" );
    level.var_3d9fc7aa7b25b565.roof_boss kill();
    level.var_3d9fc7aa7b25b565.roof_boss delete();
    level.var_3d9fc7aa7b25b565.roof_boss = undefined;
    scene_struct scene::play( undefined, "destroyed" );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 1, eflags: 0x4
// Checksum 0x1dadffda, Offset: 0x1987
// Size: 0x78
function private function_3d464d6530620652( player )
{
    level utility::flag_set( "flag_vo_emp_planting" );
    self makeunusable();
    player ob_story_mission_utils::function_ecffad6077c8f9dc();
    scene_struct = utility::getstruct( "sat_scene_cin_roof_emp_plant" );
    scene_struct scene::init( player, "init" );
    scene_struct scene::play( player );
    emp_plant_anim_end( player );
    level utility::flag_set( "flag_vo_emp_planted" );
    player ob_story_mission_utils::function_ecffad6077c8f9dc( 0 );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x22158a18, Offset: 0x1a07
// Size: 0x24d
function private phase_activate_emp()
{
    wait 0.6;
    level.var_3d9fc7aa7b25b565.roof_boss thread function_c0b8cdb7a82567d0();
    level utility::flag_set( "flag_audio_emp_explode" );
    
    foreach ( player in level.players )
    {
        thread capricorn_audio::function_9abff8fa716db965( player );
    }
    
    shockstick_enemies( 1 );
    thread function_efdd2abf510c9c42();
    
    foreach ( remaining_drone in self.helper_drones )
    {
        remaining_drone dodamage( 9999, ( 0, 0, 0 ), remaining_drone );
    }
    
    foreach ( player in level.players )
    {
        foreach ( turret in player.placedsentries[ "remote_turret" ] )
        {
            turret notify( #"kill_turret", 0, 0 );
        }
    }
    
    function_d44ee0df813009eb();
    function_71b9317cae9caab6();
    emp_aftermath_anim_start();
    emp_aftermath_anim_end();
    thread function_a5e0c592d279cd93();
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x205cc930, Offset: 0x1c5c
// Size: 0x2b
function private function_c0b8cdb7a82567d0()
{
    namespace_d735b26ffb28d82a::function_dd1f33638eed1c98( 0 );
    ob_activity_gunship_heli::function_9cde1a77d22afe7f( self, 0 );
    self setscriptablepartstate( "engine", "on_all_damage", 0 );
    thread function_50c98cd67e874b44();
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x6876c99, Offset: 0x1c8f
// Size: 0xad
function private function_c66a7a5331eb8eee()
{
    level.var_3d9fc7aa7b25b565.roof_boss.thresholdhealth = 1;
    level.var_3d9fc7aa7b25b565.roof_boss thread function_57b4d99ab3b1afe4();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_ROOF_DESTROY" );
    level.var_3d9fc7aa7b25b565.roof_boss utility::waittill_any_timeout( 10, "boss_target_health_reached" );
    thread function_bba2b5b47b7bb8f0();
    namespace_d735b26ffb28d82a::function_f6098d122e2499e3( 1 );
    level utility::flag_set( "flag_start_crash_anim" );
    level utility::flag_set( "flag_vo_vtol_defeated" );
    level utility::flag_wait( "flag_vtol_crash_done" );
    level utility::flag_wait( "flag_vtol_defeated_vo_complete" );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x312faffc, Offset: 0x1d44
// Size: 0x7e
function private function_bba2b5b47b7bb8f0()
{
    wait 3.5;
    scene_struct = utility::getstruct( "sat_scene_cin_roof_exfil", "targetname" );
    scene_struct scene::init( undefined, "init" );
    scene_struct thread scene::play( undefined, [ "In", "Loop" ] );
    scene_struct scene::set_notify_note( level, "fs_our_ride", "Types_Prop" );
    level waittill( #"fs_our_ride" );
    level utility::flag_set( "flag_vo_roof_exfil" );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0xcb537a48, Offset: 0x1dca
// Size: 0x169
function private phase_exfil()
{
    level utility::flag_wait( "flag_exfil_vo_complete" );
    story_contract_util::mark_complete( level.players, #"capricorn_complete" );
    story_contract_util::achievement_activities( level.players, "sat_wc_mission4and5", [ #"capricorn_launch", #"capricorn_complete" ] );
    
    foreach ( player in level.players )
    {
        player emp_debuff::stop_emp_scramble( 5 );
        player thread hud_util::fade_out( 1 );
        player val::set( "cinematic", "show_hud", 0 );
    }
    
    wait 1;
    
    foreach ( player in level.players )
    {
        player val::reset_all( "cinematic" );
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 1, eflags: 0x4
// Checksum 0xea524e09, Offset: 0x1f3b
// Size: 0x1a
function private exfil_interact_setup_func( player )
{
    self notify( #"exfil_interact_triggered", player );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0xc8a01217, Offset: 0x1f5d
// Size: 0x127
function private function_b0621c752bba4833()
{
    level.var_3d9fc7aa7b25b565.var_2eb4c8aa45b5d24f = [];
    structs = utility::getstructarray( "CAPRICORN_ROOF_EMP_AFTERMATH_ANIMNODE" );
    
    foreach ( struct in structs )
    {
        animstruct = spawnstruct();
        animstruct.origin = struct.origin;
        animstruct.angles = struct.angles;
        
        if ( !isdefined( level.var_3d9fc7aa7b25b565.var_2eb4c8aa45b5d24f ) )
        {
            level.var_3d9fc7aa7b25b565.var_2eb4c8aa45b5d24f = [];
        }
        
        level.var_3d9fc7aa7b25b565.var_2eb4c8aa45b5d24f[ level.var_3d9fc7aa7b25b565.var_2eb4c8aa45b5d24f.size ] = animstruct;
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 1, eflags: 0x4
// Checksum 0x70f3698, Offset: 0x208c
// Size: 0x1a
function private emp_plant_anim_end( player )
{
    self notify( #"hash_5b6262ff4bef27da", player );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x2cabc6f0, Offset: 0x20ae
// Size: 0xe0
function private emp_aftermath_anim_start()
{
    foreach ( i, player in level.players )
    {
        if ( player.sessionstate == "playing" )
        {
            node = player function_b85573967c71e096();
            node thread emp_aftermath_player_anim( player, i + 1 );
        }
    }
    
    scene_struct = utility::getstruct( "sat_scene_cin_roof_emp_aftermath", "targetname" );
    scene_struct scene::init( undefined, "init" );
    thread turn_off_emissives();
    scene_struct scene::play();
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x203e7403, Offset: 0x2196
// Size: 0x11a
function private turn_off_emissives()
{
    emissive_blockers = getentitylessscriptablearray( "emp_emissivestodark_blocker_1", "targetname" );
    
    foreach ( blocker in emissive_blockers )
    {
        blocker setscriptablepartstate( "base", "show" );
    }
    
    wait 0.7;
    emissive_blockers = getentitylessscriptablearray( "emp_emissivestodark_blocker_2", "targetname" );
    
    foreach ( blocker in emissive_blockers )
    {
        blocker setscriptablepartstate( "base", "show" );
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 2, eflags: 0x4
// Checksum 0x421b9c48, Offset: 0x22b8
// Size: 0x93
function private emp_aftermath_player_anim( player, index )
{
    player emp_debuff::play_emp_scramble( 5 );
    player ob_story_mission_utils::function_ecffad6077c8f9dc();
    player thread function_b42677d88ed540a7();
    var_feef854589716f7c = { #angles:self.angles, #origin:self.origin };
    var_feef854589716f7c scene::play( [ player ], undefined, "sat_cin_cap_590_roji_emp_aftermath_plr0" + index );
    player ob_story_mission_utils::function_ecffad6077c8f9dc( 0 );
    level utility::flag_set( "flag_emp_animation_completed" );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x36435c2c, Offset: 0x2353
// Size: 0x24
function private function_b42677d88ed540a7()
{
    hud_util::fade_out( 0.6, "white" );
    hud_util::fade_in( 0.3, "white" );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x4ced04d6, Offset: 0x237f
// Size: 0xe
function private emp_aftermath_anim_end()
{
    self notify( #"emp_aftermath_done" );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0xbf2e817b, Offset: 0x2395
// Size: 0x36
function private heli_death_anim()
{
    scene_struct = utility::getstruct( "sat_scene_cin_roof_emp_aftermath_crash", "targetname" );
    scene_struct scene::init( undefined, "init" );
    scene_struct scene::play();
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x321204c9, Offset: 0x23d3
// Size: 0xce
function private function_b85573967c71e096()
{
    var_bb1782bd98627ce4 = [];
    
    foreach ( struct in level.var_3d9fc7aa7b25b565.var_2eb4c8aa45b5d24f )
    {
        if ( !struct.taken )
        {
            if ( !isdefined( var_bb1782bd98627ce4 ) )
            {
                var_bb1782bd98627ce4 = [];
            }
            
            var_bb1782bd98627ce4[ var_bb1782bd98627ce4.size ] = struct;
        }
    }
    
    node = function_47c86977a18df38b( var_bb1782bd98627ce4, self.origin );
    node.taken = 1;
    return node;
}

// Namespace mp_sat_ob_capricorn_roof
// Params 1, eflags: 0x4
// Checksum 0x68b6f6da, Offset: 0x24aa
// Size: 0x34
function private player_setup( player )
{
    activity_instance = self;
    utility::callsharedfunc( #"gametype", #"hash_b64530c1428fda8", player );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 3, eflags: 0x4
// Checksum 0xb04e1d5f, Offset: 0x24e6
// Size: 0x2b
function private function_b4ca9b1a0d3cedc6( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_roof_enemies_spawned" );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 1, eflags: 0x4
// Checksum 0x49f1f750, Offset: 0x2519
// Size: 0x50
function private guild_bot_on_spawned( params )
{
    agent = params.agent;
    
    if ( params.agent.agent_type != "actor_sat_ob_enemy_guild_bot" )
    {
        return;
    }
    
    agent.goalheight = 160;
}

/#

    // Namespace mp_sat_ob_capricorn_roof
    // Params 0
    // Checksum 0x4038491b, Offset: 0x2571
    // Size: 0x79, Type: dev
    function init_debug()
    {
        setdevdvarifuninitialized( @"hash_e037142d1530de43", "<dev string:x56>" );
        
        if ( getdvarint( @"hash_e037142d1530de43" ) == 1 )
        {
            thread function_d862238511f1842f();
            level utility::flag_wait( "<dev string:x58>" );
        }
        
        setdevdvarifuninitialized( @"hash_cb0ba8768e329fe6", "<dev string:x56>" );
        
        if ( getdvarint( @"hash_cb0ba8768e329fe6" ) == 1 )
        {
            thread function_86ddd704b5e64ad2();
            level utility::flag_wait( "<dev string:x7b>" );
        }
    }

    // Namespace mp_sat_ob_capricorn_roof
    // Params 0, eflags: 0x4
    // Checksum 0xc4b74bd1, Offset: 0x25f2
    // Size: 0x9c, Type: dev
    function private function_d862238511f1842f()
    {
        var_cc9dbb3fbaaec44e = utility::getstruct( "<dev string:xa2>" );
        vip_obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( var_cc9dbb3fbaaec44e.origin + ( 0, -1.2, 16 ) );
        interact = interaction::register_interact( var_cc9dbb3fbaaec44e.origin, 64, &function_3d464d6530620652, &"sat_ob_story_missions_capricorn/ob_capricorn_roof_emp_interact_title" );
        interact setcursorhint( "<dev string:xbe>" );
        
        while ( true )
        {
            interact waittill( #"hash_5b6262ff4bef27da", player );
        }
    }

    // Namespace mp_sat_ob_capricorn_roof
    // Params 0, eflags: 0x4
    // Checksum 0x6fdf00b4, Offset: 0x2696
    // Size: 0x9c, Type: dev
    function private function_86ddd704b5e64ad2()
    {
        var_cc9dbb3fbaaec44e = utility::getstruct( "<dev string:xa2>" );
        vip_obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( var_cc9dbb3fbaaec44e.origin + ( 0, -1.2, 16 ) );
        interact = interaction::register_interact( var_cc9dbb3fbaaec44e.origin, 64, &function_34375cda041dd88f, &"sat_ob_story_missions_capricorn/ob_capricorn_roof_emp_interact_title" );
        interact setcursorhint( "<dev string:xbe>" );
        
        while ( true )
        {
            interact waittill( #"hash_5b6262ff4bef27da", player );
        }
    }

    // Namespace mp_sat_ob_capricorn_roof
    // Params 1, eflags: 0x4
    // Checksum 0x3c547bfd, Offset: 0x273a
    // Size: 0x32, Type: dev
    function private function_34375cda041dd88f( player )
    {
        function_71b9317cae9caab6();
        emp_aftermath_anim_start();
        emp_aftermath_anim_end();
        self notify( #"hash_5b6262ff4bef27da", player );
    }

#/

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0xa65892f8, Offset: 0x2774
// Size: 0x89
function private function_71b9317cae9caab6()
{
    foreach ( struct in level.var_3d9fc7aa7b25b565.var_2eb4c8aa45b5d24f )
    {
        struct.taken = 0;
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x9f620074, Offset: 0x2805
// Size: 0xbd
function private function_a5e0c592d279cd93()
{
    wait 5;
    
    if ( isdefined( self.var_9c4a0b2cae577c1b[ level.enc_roof ] ) )
    {
        activity_ai_encounters::function_46dadc3aca2ffac0( level.enc_roof, 0 );
    }
    
    foreach ( agent in level.agentarray )
    {
        if ( isalive( agent ) && !agent.invulnerable )
        {
            agent kill();
        }
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 1, eflags: 0x4
// Checksum 0x7176158d, Offset: 0x28ca
// Size: 0xac
function private shockstick_enemies( forcedshock = 0 )
{
    foreach ( agent in level.agentarray )
    {
        if ( isalive( agent ) && ( !agent.ishaywire || forcedshock ) )
        {
            agent apply_shocks();
        }
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x4ea71cf4, Offset: 0x297e
// Size: 0x27
function private function_efdd2abf510c9c42()
{
    wait 0.5;
    
    while ( level.agentarray.size > 0 )
    {
        shockstick_enemies();
        wait 0.25;
    }
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x6244a5c4, Offset: 0x29ad
// Size: 0xef
function private apply_shocks()
{
    agent = self;
    var_ed2c165091bf4dd5 = spawnstruct();
    agent emp_debuff::clear_emp();
    
    if ( agent.agent_type != "actor_sat_ob_enemy_guild_bot" )
    {
        var_ed2c165091bf4dd5.var_f3b6e148094e7137 = 1;
    }
    
    agent.stunduration = 99999;
    agent dodamage( 1, agent.origin );
    var_ed2c165091bf4dd5.victim = agent;
    var_ed2c165091bf4dd5.inflictor = level.players[ 0 ];
    var_ed2c165091bf4dd5.objweapon = makeweapon( "shock_stick_mp" );
    var_ed2c165091bf4dd5.var_b688bbdf5036e88e = 1000000;
    var_ed2c165091bf4dd5.attacker = var_ed2c165091bf4dd5.inflictor;
    var_ed2c165091bf4dd5.var_d7e160d46b65574f = agent.health;
    shock_stick::shockstick_applyhaywirestruct( var_ed2c165091bf4dd5 );
}

// Namespace mp_sat_ob_capricorn_roof
// Params 0, eflags: 0x4
// Checksum 0x9e59bb80, Offset: 0x2aa4
// Size: 0x87
function private function_d44ee0df813009eb()
{
    foreach ( player in level.players )
    {
        player ob_gametype_story_mission::function_53bd6710a606e0a();
        player setstance( "stand" );
    }
}

