// script_53b43743b43d43d3  (hash_53b43743b43d43d3.gscc) (size: 14085 Bytes / 0x3705 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x64647eee (1684307694)
// size ...... 14085 (0x3705)
// includes .. 15  (offset: 0x3151)
// strings ... 83  (offset: 0x31c9)
// dev strs .. 0   (offset: 0x3705)
// exports ... 37  (offset: 0x1f31)
// cseg ...... 0x889 + 0x16a8 (0x1f31)
// imports ... 97  (offset: 0x24f9)
// animtree1 . 0   (offset: 0x3705)
// animtree2 . 0   (offset: 0x3705)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_audio;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;
#using scripts\mp\ob\ob_soldier_util;

#namespace namespace_f2b7612d2fda2d2e;

/#

    // Namespace namespace_f2b7612d2fda2d2e
    // Params 0
    // Checksum 0xebe32270, Offset: 0x8a7
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_f2b7612d2fda2d2e
// Params 0, eflags: 0x5
// Checksum 0x8e45eb87, Offset: 0x8b4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_5256c39eb9e3e3ad", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0, eflags: 0x4
// Checksum 0x7cbd4be7, Offset: 0x8dd
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_JAPAN_INTRO";
    activity_common::registeractivitytype( "OB_VIRGO_JAPAN_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_JAPAN_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_JAPAN_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_JAPAN_INTRO", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0xaf879720, Offset: 0x93e
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance japan_intro_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0xc7c2ed4b, Offset: 0x9a3
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance japan_intro_main();
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0x76d4b98f, Offset: 0x9dd
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

/#

    // Namespace namespace_f2b7612d2fda2d2e
    // Params 0
    // Checksum 0xac598660, Offset: 0xa01
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0xe3515344, Offset: 0xa0e
// Size: 0x2
function japan_intro_start()
{
    
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0x334703aa, Offset: 0xa18
// Size: 0x134
function japan_intro_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread japan_intro_scene();
    level thread function_c7ac751750f331f0();
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "struct_cache_warehouse" );
    level thread ob_virgo_util::function_1415e67b35bab88e( "trig_virgo_japan_inside", "flag_japan_inside" );
    level thread ob_virgo_util::function_1415e67b35bab88e( "trig_virgo_japan_inside_puzzle", "flag_japan_puzzle_start" );
    level thread ob_virgo_util::function_1415e67b35bab88e( "trig_virgo_japan_intro_warehouse_door", "flag_warehouse_interact" );
    thread japan_intro_combat();
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_japan_intro", undefined, 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_japan_intro", undefined, 1, undefined, undefined, undefined );
    level thread virgo_vo::function_959cd51445082fb8();
    level thread utility::exploder( "fx_jpn_intro" );
    level thread utility::exploder( "fx_jpn_fight" );
    ob_virgo_util::setup_ui_widget( "OB_VIRGO_JAPAN_INTRO" );
    level.objective_waypoint = "struct_keypad_waypoint";
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, level.objective_waypoint, undefined, "obj_waypoint_japan_intro_done" );
    level utility::flag_wait( "flag_japan_echo_assembled" );
    level thread function_eb093890f173a38b();
    waypoint_objective_handler::waypoint_objective_handler_cancel( level.objective_waypoint );
    level utility::flag_wait( "flag_virgo_japan_intro_done" );
    level thread virgo_vo::function_27ffcc2318635693( undefined, "event_damage_upgrade", undefined, 1 );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0x3f82107c, Offset: 0xb54
// Size: 0xb3
function japan_intro_scene()
{
    struct = utility::getstruct( "script_scene_warehouse", "targetname" );
    struct thread ob_virgo_util::function_29164af2d4d89658();
    struct thread scene::play( undefined, "enter" );
    var_6dcd6d1e9b245b9d = struct scene::function_b3c7b792a7a154fa( 0 );
    level thread ob_virgo_util::function_f8c90a6db244c560( struct, "fiftyfifty" );
    wait var_6dcd6d1e9b245b9d;
    struct thread scene::play( undefined, "loop" );
    level utility::flag_wait( "flag_warehouse_interact" );
    struct thread ob_virgo_util::function_29164af2d4d89658();
    level thread function_a36a306e3e306cf6( 7 );
    struct scene::play( undefined, "exit" );
    level utility::flag_set( "flag_japan_intro_sniper" );
    level utility::flag_set( "flag_warehouse_scene_done" );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 1
// Checksum 0x43cd1b0f, Offset: 0xc0f
// Size: 0x36
function function_a36a306e3e306cf6( time )
{
    wait time;
    door = getent( "script_warehouse_door", "targetname" );
    
    if ( isdefined( door ) )
    {
        door delete();
    }
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0xf058b3c4, Offset: 0xc4d
// Size: 0x171
function japan_intro_combat()
{
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_virgo_japan_alley_1", "flag_japan_alley_1" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_virgo_japan_intro_sniper", "flag_japan_intro_sniper" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_virgo_japan_intro_wave_1", "flag_japan_intro_1" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_virgo_japan_intro_wave_2", "flag_japan_intro_2" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_virgo_japan_intro_wave_3", "flag_japan_intro_3" );
    level thread virgo_audio::japan_intro_combat_walla();
    
    if ( level.players.size > 2 )
    {
        level thread function_854f578fa6af2906();
    }
    
    level utility::flag_wait( "flag_japan_intro_sniper" );
    thread function_7383a5274a00e93e();
    level utility::flag_wait( "flag_japan_intro_1" );
    thread function_7383a6274a00eb71();
    
    if ( level.players.size > 2 )
    {
        level thread function_ca55ce3794ab1caa();
    }
    
    level utility::flag_wait( "flag_japan_inside" );
    thread function_9b79276f55422ba0();
    numbers = getentarray( "japan_numbers", "targetname" );
    
    foreach ( num in numbers )
    {
        num hide();
    }
    
    level utility::flag_wait_all( "flag_japan_intro_combat_clear", "flag_japan_interior_clear" );
    thread function_9e18b68737520587();
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0xd2e28fce, Offset: 0xdc6
// Size: 0x106
function function_854f578fa6af2906()
{
    var_555a947463e55350 = utility::getstruct( "struct_turret_japan_alley", "targetname" );
    turret = ob_soldier_util::ob_sentry_turret_spawn( var_555a947463e55350 );
    waitframe();
    level.sentrysettings[ "ai_sentry_turret" ].targetrange = 10000;
    level.sentrysettings[ "ai_sentry_turret" ].burstmin = 55;
    level.sentrysettings[ "ai_sentry_turret" ].burstmax = 60;
    level.sentrysettings[ "ai_sentry_turret" ].pausemin = 2;
    level.sentrysettings[ "ai_sentry_turret" ].pausemax = 4;
    level.sentrysettings[ "ai_sentry_turret" ].spinuptime = 2;
    level utility::flag_wait( "flag_japan_intro_sniper" );
    turret.isactive = 1;
    turret.team = "team_hundred_ninety";
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0xfe741a98, Offset: 0xed4
// Size: 0x160
function function_ca55ce3794ab1caa()
{
    a_turret_structs = utility::getstructarray( "struct_turret_japan_intro", "targetname" );
    
    foreach ( var_555a947463e55350 in a_turret_structs )
    {
        turret = ob_soldier_util::ob_sentry_turret_spawn( var_555a947463e55350 );
        waitframe();
        level.sentrysettings[ "ai_sentry_turret" ].targetrange = 10000;
        level.sentrysettings[ "ai_sentry_turret" ].burstmin = 55;
        level.sentrysettings[ "ai_sentry_turret" ].burstmax = 60;
        level.sentrysettings[ "ai_sentry_turret" ].pausemin = 2;
        level.sentrysettings[ "ai_sentry_turret" ].pausemax = 4;
        level.sentrysettings[ "ai_sentry_turret" ].spinuptime = 2;
        turret.isactive = 1;
        turret.team = "team_hundred_ninety";
    }
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0x29064c56, Offset: 0x103c
// Size: 0x6c
function japan_vtol_path()
{
    vspeed = 200;
    struct = utility::getstruct( "struct_japan_heli_end", "targetname" );
    vtol = ob_virgo_util::function_d7b66ae5a4715213( "struct_japan_heli_start" );
    wait 2;
    vtol vehicle_setspeed( vspeed / 2, vspeed / 4, vspeed / 4 );
    vtol setvehgoalpos( struct.origin, 1 );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0xd312b10c, Offset: 0x10b0
// Size: 0x141
function function_9e18b68737520587()
{
    options = [];
    options[ options.size ] = 5900;
    options[ options.size ] = 3600;
    options[ options.size ] = 7400;
    options[ options.size ] = 4200;
    options[ options.size ] = 8300;
    level thread function_f0db7a9ae97fcdc9();
    level.puzzle_prefix = utility::array_random( options );
    number = randomint( 99 );
    code = level.puzzle_prefix + number;
    level thread function_34e7a1aa24e4e1b5( number, level.puzzle_prefix );
    level ob_virgo_util::function_7ee93ae119e3f312( "virgo_hack_1" );
    connection_puzzle_struct = utility::getstruct( "struct_japan_echo_2", "targetname" );
    connection_puzzle_struct thread ob_story_mission_utils::function_e89ed2a08ce38bbf( "struct_japan_echo_2", level.connection_puzzle_asset );
    ob_virgo_util::virgo_keypad( "struct_japan_echo_1", "flag_japan_echo_1", &"sat_ob_story_missions/interact_unlock", "japan_keypad", "flag_japan_echo_assembled", code );
    level utility::flag_wait( "flag_japan_echo_1" );
    ob_virgo_util::function_3fbaca3bceae7dfb( "OB_VIRGO_JAPAN_ECHO" );
    ob_virgo_util::function_70674852bcdd6cd3( "struct_japan_echo_2", "flag_japan_echo_2", &"sat_ob_story_missions/interact_hack", "virgo_hack_1", 0 );
    level utility::flag_wait( "flag_japan_echo_2" );
    connection_puzzle_struct thread ob_story_mission_utils::remove_connection_puzzle_streaming_volume();
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0xa0e56919, Offset: 0x11f9
// Size: 0x14a
function puzzle_helper()
{
    wait 30;
    
    if ( level utility::flag( "flag_japan_echo_assembled" ) )
    {
        return;
    }
    
    foreach ( num in level.fake_numbers )
    {
        if ( utility::cointoss() )
        {
            num delete();
        }
    }
    
    level.fake_numbers = function_5713d46873b29625( level.fake_numbers );
    wait 30;
    
    if ( level utility::flag( "flag_japan_echo_assembled" ) )
    {
        return;
    }
    
    foreach ( num in level.fake_numbers )
    {
        if ( utility::cointoss() )
        {
            num delete();
        }
    }
    
    level.fake_numbers = function_5713d46873b29625( level.fake_numbers );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0x3e4076ed, Offset: 0x134b
// Size: 0x51
function function_f0db7a9ae97fcdc9()
{
    level utility::flag_wait( "flag_japan_puzzle_start" );
    struct = utility::getstruct( "struct_scene_japan_echo", "targetname" );
    struct thread ob_virgo_util::function_29164af2d4d89658();
    struct thread scene::play( undefined, "echo_01" );
    ob_virgo_util::function_f8c90a6db244c560( struct, "fitfyfifty" );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0x1124ed83, Offset: 0x13a4
// Size: 0x36
function function_e87adf24796e8c7b()
{
    struct = utility::getstruct( "struct_scene_japan_echo", "targetname" );
    struct thread ob_virgo_util::function_29164af2d4d89658();
    struct scene::play( undefined, "echo_02" );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 2
// Checksum 0x839702a0, Offset: 0x13e2
// Size: 0x3ee
function function_34e7a1aa24e4e1b5( number, option )
{
    numbers = getentarray( "japan_numbers", "targetname" );
    
    foreach ( num in numbers )
    {
        num hide();
    }
    
    level.fake_numbers = [];
    level utility::flag_wait( "flag_japan_echo_2" );
    side = 0;
    row = randomintrange( 0, 9 );
    col = randomintrange( 0, 6 );
    spot = "search_" + side + row + col;
    
    /#
        iprintlnbold( spot );
    #/
    
    tens = floor( number / 10 );
    ones = number % 10;
    var_760bd5d0bea9daf5 = "search_" + side + row + col + 0;
    var_760bd4d0bea9d8c2 = "search_" + side + row + col + 1;
    var_760bd3d0bea9d68f = "search_" + side + row + col + 2;
    var_760bd2d0bea9d45c = "search_" + side + row + col + 3;
    piece_0 = getent( var_760bd5d0bea9daf5, "script_noteworthy" );
    piece_1 = getent( var_760bd4d0bea9d8c2, "script_noteworthy" );
    piece_2 = getent( var_760bd3d0bea9d68f, "script_noteworthy" );
    piece_3 = getent( var_760bd2d0bea9d45c, "script_noteworthy" );
    
    /#
        iprintlnbold( option );
    #/
    
    switch ( option )
    {
        case 5900:
            piece_0 setmodel( "electronics_digits_numbers_5_red" );
            piece_1 setmodel( "electronics_digits_numbers_9_red" );
            break;
        case 3600:
            piece_0 setmodel( "electronics_digits_numbers_3_red" );
            piece_1 setmodel( "electronics_digits_numbers_6_red" );
            break;
        case 7400:
            piece_0 setmodel( "electronics_digits_numbers_7_red" );
            piece_1 setmodel( "electronics_digits_numbers_4_red" );
            break;
        case 4200:
            piece_0 setmodel( "electronics_digits_numbers_4_red" );
            piece_1 setmodel( "electronics_digits_numbers_2_red" );
            break;
        case 8300:
            piece_0 setmodel( "electronics_digits_numbers_8_red" );
            piece_1 setmodel( "electronics_digits_numbers_3_red" );
            break;
        default:
            piece_0 setmodel( "electronics_digits_numbers_5_red" );
            piece_1 setmodel( "electronics_digits_numbers_9_red" );
            break;
    }
    
    piece_2 setmodel( "electronics_digits_numbers_" + tens + "_red" );
    piece_3 setmodel( "electronics_digits_numbers_" + ones + "_red" );
    numbers = getentarray( "japan_numbers", "targetname" );
    
    foreach ( num in numbers )
    {
        if ( num.script_noteworthy == var_760bd5d0bea9daf5 || num.script_noteworthy == var_760bd4d0bea9d8c2 || num.script_noteworthy == var_760bd3d0bea9d68f || num.script_noteworthy == var_760bd2d0bea9d45c )
        {
            num thread num_flicker_together();
            continue;
        }
        
        level.fake_numbers[ level.fake_numbers.size ] = num;
        num thread num_flicker();
    }
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0xeca5c4b0, Offset: 0x17d8
// Size: 0xbe
function num_flicker()
{
    min_time = 1;
    max_time = 4;
    first_start_time = 5;
    min_hide_time = 0.05;
    max_hide_time = 1;
    var_c91f26ce3738add1 = 1;
    self endon( #"delete" );
    self show();
    wait first_start_time;
    
    while ( !level utility::flag( "flag_japan_echo_assembled" ) && isdefined( self ) )
    {
        wait randomfloatrange( min_time, max_time );
        
        if ( !var_c91f26ce3738add1 )
        {
            if ( isdefined( self ) )
            {
                self show();
                var_c91f26ce3738add1 = 1;
            }
            
            continue;
        }
        
        if ( isdefined( self ) )
        {
            self hide();
            var_c91f26ce3738add1 = 0;
            wait randomfloatrange( min_hide_time, max_hide_time );
        }
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0x6495f14e, Offset: 0x189e
// Size: 0x1b
function num_flicker_together()
{
    self show();
    level utility::flag_wait( "flag_japan_echo_assembled" );
    self delete();
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0x60f2bafd, Offset: 0x18c1
// Size: 0x8d
function function_eb093890f173a38b()
{
    clip = getent( "clip_garden_door", "targetname" );
    sound_org = ( 42880, -45814, 251 );
    playsoundatpos( sound_org, "uin_keypad_puzzle_unlock" );
    level utility::flag_set( "flag_virgo_japan_intro_done" );
    scene_struct = utility::getstruct( "script_struct_puzzle_door", "targetname" );
    
    if ( isdefined( scene_struct ) )
    {
        scene_struct thread scene::play( undefined, "exit", "scene_sat_virgo_puzzle_doors" );
    }
    
    if ( isdefined( clip ) )
    {
        clip delete();
    }
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0xe5aa59c8, Offset: 0x1956
// Size: 0x29
function japan_intro_drones()
{
    level utility::flag_wait( "flag_japan_alley_1" );
    thread ob_virgo_util::virgo_drones( "struct_japan_alley_drone", ( 0, 0, 64 ), undefined );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0x5343061f, Offset: 0x1987
// Size: 0x51
function function_7383a5274a00e93e()
{
    encounter_targetname = "encounter_japan_sniper";
    level.var_891f023ebb471226 = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.var_891f023ebb471226, 1 );
    ai_spawn_director::add_spawned_callback( level.var_891f023ebb471226, &function_91c06726388c02d6 );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0x6692394d, Offset: 0x19e0
// Size: 0x98
function function_7383a6274a00eb71()
{
    level.japan_intro_enemies = [];
    encounter_targetname = "encounter_japan_intro";
    level.japan_intro_encounter = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.japan_intro_encounter, 1 );
    ai_spawn_director::add_spawned_callback( level.japan_intro_encounter, &function_5b602ecb9c2e7f69 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.japan_intro_encounter, &function_cad1856423c11b02, self );
    level utility::flag_wait( "flag_japan_intro_enemies_spawned" );
    activity_progress_tracking::function_82d854bb84c20512( "intro_tracker", level.japan_intro_enemies, &function_14433da175f2582e );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0x3261da27, Offset: 0x1a80
// Size: 0x98
function function_9b79276f55422ba0()
{
    level.var_863e82b56b372e38 = [];
    encounter_targetname = "encounter_japan_intro_3";
    level.var_697a5a99746a9085 = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.var_697a5a99746a9085, 1 );
    ai_spawn_director::add_spawned_callback( level.var_697a5a99746a9085, &function_3c3a7a75d9543975 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.var_697a5a99746a9085, &function_32f09b6369370d6c, self );
    level utility::flag_wait( "flag_japan_interior_enemies_spawned" );
    activity_progress_tracking::function_82d854bb84c20512( "interior_tracker", level.var_863e82b56b372e38, &function_1e9cb8fffb3935dc );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 4
// Checksum 0x56dc4353, Offset: 0x1b20
// Size: 0xaf
function function_5b602ecb9c2e7f69( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    level.japan_intro_enemies[ level.japan_intro_enemies.size ] = agent;
    level utility::flag_wait( "flag_japan_intro_2" );
    wait randomfloatrange( 0.5, 2 );
    vols = getnoentvolumearray( "vol_japan_intro_back_balcony", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_japan_inside" );
    vols = getnoentvolumearray( "vol_japan_intro_back_inside", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 4
// Checksum 0x9130d9bf, Offset: 0x1bd7
// Size: 0xc1
function function_91c06726388c02d6( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    agent.ignoresuppression = 1;
    level utility::flag_wait( "flag_japan_alley_1" );
    vols = getnoentvolumearray( "vol_japan_intro_back", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_japan_intro_2" );
    vols = getnoentvolumearray( "vol_japan_intro_back_balcony", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_japan_intro_3" );
    vols = getnoentvolumearray( "vol_japan_intro_back_inside", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 3
// Checksum 0x5d44c7ea, Offset: 0x1ca0
// Size: 0x2b
function function_cad1856423c11b02( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_japan_intro_enemies_spawned" );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 3
// Checksum 0x49b0bec7, Offset: 0x1cd3
// Size: 0x70
function function_14433da175f2582e( requestid, activity_instance, agent )
{
    level.japan_intro_enemies = utility::array_removedead_or_dying( level.japan_intro_enemies );
    
    if ( level.japan_intro_enemies.size < 4 )
    {
        level utility::flag_set( "flag_japan_intro_2" );
    }
    
    if ( level.japan_intro_enemies.size < 2 )
    {
        level utility::flag_set( "flag_japan_intro_combat_clear" );
    }
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 3
// Checksum 0xd5029087, Offset: 0x1d4b
// Size: 0x2b
function function_32f09b6369370d6c( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_japan_interior_enemies_spawned" );
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 3
// Checksum 0xd2f0f44c, Offset: 0x1d7e
// Size: 0x53
function function_1e9cb8fffb3935dc( requestid, activity_instance, agent )
{
    level.var_863e82b56b372e38 = utility::array_removedead_or_dying( level.var_863e82b56b372e38 );
    
    if ( level.var_863e82b56b372e38.size < 1 )
    {
        level utility::flag_set( "flag_japan_interior_clear" );
    }
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 4
// Checksum 0xe37c75b6, Offset: 0x1dd9
// Size: 0x4b
function function_3c3a7a75d9543975( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    level.var_863e82b56b372e38[ level.var_863e82b56b372e38.size ] = agent;
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 0
// Checksum 0xd68e004a, Offset: 0x1e2c
// Size: 0xc6
function function_c7ac751750f331f0()
{
    rocks = getentarray( "script_japan_floaty_rocks", "targetname" );
    
    foreach ( part in rocks )
    {
        if ( isdefined( part.target ) )
        {
            clip = getent( part.target, "targetname" );
            clip linkto( part );
        }
        
        part thread function_99ec5f084bacbc3b( "flag_virgo_japan_intro_done" );
    }
}

// Namespace namespace_f2b7612d2fda2d2e
// Params 1
// Checksum 0xc0906b3d, Offset: 0x1efa
// Size: 0x37
function function_99ec5f084bacbc3b( flag_name )
{
    var_def68e8d6c25ac6f = randomfloatrange( 0.1, 0.5 );
    wait var_def68e8d6c25ac6f;
    thread ob_virgo_util::function_8099635f87b4d57c( flag_name, 0.2 );
}

