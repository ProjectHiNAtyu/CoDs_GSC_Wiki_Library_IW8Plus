// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_rh.gsc  (hash_374203d4d751df0e.gscc) (size: 14861 Bytes / 0x3a0d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x92bed4f5 (2461979893)
// size ...... 14861 (0x3a0d)
// includes .. 8   (offset: 0x3479)
// strings ... 71  (offset: 0x34b9)
// dev strs .. 0   (offset: 0x3a0d)
// exports ... 29  (offset: 0x244d)
// cseg ...... 0x565 + 0x1ee8 (0x244d)
// imports ... 80  (offset: 0x28d5)
// animtree1 . 0   (offset: 0x3a0d)
// animtree2 . 0   (offset: 0x3a0d)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\interaction;
#using scripts\mp\overlord;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_rabbithole;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_sat_hornet_rh;

// Namespace zm_sat_hornet_rh
// Params 0, eflags: 0x5
// Checksum 0x96afa871, Offset: 0x583
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hornet_rh", undefined, undefined, &init );
}

// Namespace zm_sat_hornet_rh
// Params 0, eflags: 0x4
// Checksum 0x1a8e1728, Offset: 0x5a4
// Size: 0x11f
function private init()
{
    if ( !getdvarint( @"enable_rh", 0 ) )
    {
        return;
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level callback::add( #"player_connect", &on_player_connect );
    
    if ( !getdvarint( @"hash_7ae1c9d5cf785e78", 0 ) )
    {
        level utility::flag_wait_or_timeout( "rh_validation_set", 120 );
    }
    
    if ( !level.rh_enabled && !getdvarint( @"hash_7ae1c9d5cf785e78", 0 ) )
    {
        return;
    }
    
    level thread zm_rabbithole::function_5b9514e060bb4725();
    level._effect[ #"toy_trail" ] = loadfxasset( "vfx_sat_zm_hornet_pink_soul_charge_trail" );
    level._effect[ #"toy_impact" ] = loadfxasset( "vfx_sat_zm_hornet_pink_soul_charge_trail_impact" );
    level._effect[ #"box_aura" ] = loadfxasset( "vfx_sat_levels_zm_hornet_super_ee_toy_chest_amb" );
    level._effect[ #"hash_654d9343ea94c59d" ] = loadfxasset( "vfx_sat_levels_zm_hornet_super_ee_toy_chest_smk" );
    level thread callback::add( "cb_storm_spawned", &function_acf150e1f656da4 );
    level callback::add( "tree_storm_started", &check_tree_storm_started );
    set_up_quest();
}

// Namespace zm_sat_hornet_rh
// Params 1, eflags: 0x4
// Checksum 0x82bf9065, Offset: 0x6cb
// Size: 0x39
function private on_player_connect( params )
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        if ( self.var_e8b776e9698cb857 )
        {
            level.var_e8b776e9698cb857 = 1;
        }
    }
    
    level utility::flag_set( "super_ee_save_check" );
}

// Namespace zm_sat_hornet_rh
// Params 0
// Checksum 0x178af3c5, Offset: 0x70c
// Size: 0x141
function set_up_quest()
{
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "super_ee_save_check" );
    
    if ( level.var_e8b776e9698cb857 )
    {
        level utility::flag_set( "rh_to_pic" );
        return;
    }
    
    level.toy_box = zm_rabbithole::spawn_toybox( "tb_start" );
    level.toy_box utility::function_7c10ea82c1e305b8( "snd_idle_rattle", "on" );
    level.toy_box utility::function_7c10ea82c1e305b8( "anim", "close" );
    playfxontag( level._effect[ #"box_aura" ], level.toy_box, "tag_origin" );
    level.toy_box thread bird_bounce( 0.75, 4 );
    level.var_c0179b8b2dbf283d = utility::getstruct( "cb_radius", "targetname" );
    s_nest = utility::getstruct( "f_nest", "targetname" );
    nest = spawn( "script_model", s_nest.origin );
    nest.angles = s_nest.angles;
    nest setscale( 10 );
    nest setmodel( "periph_bird_nest_02" );
    get_flight_paths();
}

// Namespace zm_sat_hornet_rh
// Params 0
// Checksum 0x2d9863f4, Offset: 0x855
// Size: 0x368
function get_flight_paths()
{
    s_box_start = utility::getstruct( "ch_roll", "script_noteworthy" );
    result = function_9de4d6e42a18df6( s_box_start );
    level.box_path = result.path;
    level.var_54fc63f60b44b0a0 = result.last_angles;
    level.s_pigeon_box = utility::getstruct( "pg_first_flight_start", "script_noteworthy" );
    result = function_9de4d6e42a18df6( level.s_pigeon_box );
    level.first_flight = result.path;
    level.var_851a84b69d24bf24 = result.last_angles;
    level.s_first_tree = utility::getstruct( "ft_path", "script_noteworthy" );
    result = function_9de4d6e42a18df6( level.s_first_tree );
    level.first_tree_path = result.path;
    level.var_6e30cde13eee35f2 = result.last_angles;
    level.var_fc1686cefcb855f9 = utility::getstruct( "st_path", "script_noteworthy" );
    result = function_9de4d6e42a18df6( level.var_fc1686cefcb855f9 );
    level.second_tree_path = result.path;
    level.second_tree_path_angles = result.last_angles;
    level.var_3f35ecd976359a46 = utility::getstruct( "tht_path", "script_noteworthy" );
    result = function_9de4d6e42a18df6( level.var_3f35ecd976359a46 );
    level.third_tree_path = result.path;
    level.var_2d03ae610de605e3 = result.last_angles;
    var_2b415576483a8ba4 = utility::getstruct( "fnt_path", "script_noteworthy" );
    result = function_9de4d6e42a18df6( var_2b415576483a8ba4 );
    level.final_tree_path = result.path;
    level.var_2357bf2e7991da58 = result.last_angles;
    s_first_tree_return = utility::getstruct( "ft_return_path", "script_noteworthy" );
    result = function_9de4d6e42a18df6( s_first_tree_return );
    level.first_tree_return_path = result.path;
    level.var_ea9dd628fb6998bb = result.last_angles;
    s_second_tree_return = utility::getstruct( "st_return_path", "script_noteworthy" );
    result = function_9de4d6e42a18df6( s_second_tree_return );
    level.second_tree_return_path = result.path;
    level.var_3d5b287af647fc21 = result.last_angles;
    s_third_tree_return = utility::getstruct( "tt_return_path", "script_noteworthy" );
    result = function_9de4d6e42a18df6( s_third_tree_return );
    level.third_tree_return_path = result.path;
    level.var_f8bb73ec1c1c1350 = result.last_angles;
    var_d0e4758e72aede36 = utility::getstruct( "pg_ft_failure", "script_noteworthy" );
    result = function_9de4d6e42a18df6( var_d0e4758e72aede36 );
    level.var_ae522ec45ca9f25a = result.path;
    level.var_2b8ed3563e698d3f = result.last_angles;
    var_8d0dfb65c1abb2c = utility::getstruct( "pg_perch_start_failed", "script_noteworthy" );
    result = function_9de4d6e42a18df6( var_8d0dfb65c1abb2c );
    level.var_be2f681a578c8fd4 = result.path;
    level.var_e7e19f4a08d5a09d = result.last_angles;
}

// Namespace zm_sat_hornet_rh
// Params 2
// Checksum 0x80711505, Offset: 0xbc5
// Size: 0xc1
function bird_bounce( bobspeed, height )
{
    self endon( #"death" );
    self endon( #"tb_triggered" );
    level endon( #"game_ended" );
    acceleration_const = bobspeed * 0.25;
    down_speed = bobspeed * 0.5;
    
    while ( isdefined( self ) )
    {
        self movez( height * 0.5, bobspeed, acceleration_const, acceleration_const );
        self waittill( #"movedone" );
        self movez( height, bobspeed, acceleration_const, acceleration_const );
        self waittill( #"movedone" );
        self movez( height * 1.5 * -1, down_speed, acceleration_const, acceleration_const );
        self waittill( #"movedone" );
    }
}

// Namespace zm_sat_hornet_rh
// Params 1
// Checksum 0x3fbee975, Offset: 0xc8e
// Size: 0x99
function function_acf150e1f656da4( params )
{
    is_position_in_trigger = utility::function_148a680721859842( params.position, level.var_c0179b8b2dbf283d.origin, 100, 200 );
    
    if ( is_position_in_trigger )
    {
        level.toy_box notify( #"tb_triggered" );
        stopfxontag( level._effect[ #"box_aura" ], level.toy_box, "tag_origin" );
        level thread roll_box();
        level thread callback::remove( "cb_storm_spawned", &function_acf150e1f656da4 );
    }
}

// Namespace zm_sat_hornet_rh
// Params 0
// Checksum 0xe8d99a8, Offset: 0xd2f
// Size: 0x18c
function roll_box()
{
    level endon( #"game_ended" );
    level.tb_final = utility::getstruct( "final_tb", "script_noteworthy" );
    wait 1;
    playworldsound( level.toy_box.origin, #"hash_e4901f268a047ef5" );
    acceleration_const = 1.5;
    level.toy_box rotateby( ( 0, 1440, 0 ), 3, acceleration_const );
    wait 2.5;
    level thread rotate_box( level.tb_final );
    level thread overlord::playconversation( hashcat( #"hash_4480b2d59e32cd95", randomintrange( 1, 9 ) ) );
    level.toy_box utility::function_2159dd4196ff4b81( level.box_path, 3.5, 0, 0, 0, 1, 1, 1 );
    playfxontag( level._effect[ #"hash_654d9343ea94c59d" ], level.toy_box, "tag_origin" );
    level.toy_box utility::function_7c10ea82c1e305b8( "snd_idle_rattle", "off" );
    level.toy_box utility::function_7c10ea82c1e305b8( "anim", "open_fast" );
    level.toy_box utility::function_7c10ea82c1e305b8( "fx", "on" );
    zm_rabbithole::function_b422525417f4cda2();
    
    if ( !level callback::exists( "tree_storm_ended", &check_tree_storm_ended ) )
    {
        level callback::add( "tree_storm_ended", &check_tree_storm_ended );
    }
    
    level utility::flag_set( "box_rolled" );
    function_7fff219219f4476d();
}

// Namespace zm_sat_hornet_rh
// Params 1, eflags: 0x4
// Checksum 0xc889b72f, Offset: 0xec3
// Size: 0x82
function private function_9de4d6e42a18df6( start_struct )
{
    var_d00b944707343dc9 = [ start_struct.origin ];
    
    while ( start_struct.target )
    {
        start_struct = utility::getstruct( start_struct.target, "targetname" );
        var_d00b944707343dc9[ var_d00b944707343dc9.size ] = start_struct.origin;
    }
    
    return { #last_angles:start_struct.angles, #path:var_d00b944707343dc9 };
}

// Namespace zm_sat_hornet_rh
// Params 1
// Checksum 0x95897775, Offset: 0xf4e
// Size: 0x57
function rotate_box( struct )
{
    acceleration_const = 0.875;
    final_angle = struct.angles + ( 0, 1440, 0 );
    level.toy_box rotateto( final_angle, 3.5, acceleration_const );
}

// Namespace zm_sat_hornet_rh
// Params 0
// Checksum 0xdcb9ae45, Offset: 0xfad
// Size: 0x248
function function_7fff219219f4476d()
{
    level.tb_pigeon = utility::spawn_model( "sat_zm_raven_base_fxanim", utility::getstruct( "pg_box_start" ).origin, utility::getstruct( "pg_box_start" ).angles );
    level.tb_pigeon utility::function_7c10ea82c1e305b8( "anim", "fly" );
    level.tb_pigeon utility::function_7c10ea82c1e305b8( "vfx", "on" );
    playworldsound( level.tb_pigeon.origin, #"hash_8893bd14cda17934" );
    var_d471e1d0eadcec25 = utility::getstruct( "pg_inactive_point", "targetname" );
    level.tb_pigeon moveto( var_d471e1d0eadcec25.origin, 1.5 );
    wait 1.5;
    
    if ( !level utility::flag( "starting_tree_triggered" ) )
    {
        level utility::flag_set( "flight_failed" );
        level thread failure_loop();
    }
    else if ( level utility::flag( "starting_tree_triggered" ) )
    {
        var_2507853f87e521e3 = utility::getstruct( "pg_perch_start", "script_noteworthy" );
        level.tb_pigeon function_7e2d377b7d86c222( level.first_flight, 4, 1, level.var_851a84b69d24bf24 );
        level.tb_pigeon rotateto( var_2507853f87e521e3.angles, 0.1 );
        level utility::flag_set( "pf_first_stop" );
        level.tb_pigeon.id = "fp_path";
        wait 5;
        level thread function_27e6fa3e278f7595();
    }
    
    level thread overlord::playconversation( hashcat( #"hash_63572e8b279c1b4f", randomintrange( 1, 4 ) ) );
    wait 1;
    
    if ( level.var_ce1470413371c515 && level.var_ce1470413371c515.targetname == "zone_second_bailey_tree" && level utility::flag( "starting_tree_triggered" ) )
    {
        level.tb_pigeon thread function_7e2d377b7d86c222( level.first_tree_path, 10, 1, level.var_6e30cde13eee35f2 );
        level.tb_pigeon.id = "ft_path";
        level thread function_c9db42ef48369314();
        level utility::flag_set( "pf_second_stop" );
    }
}

// Namespace zm_sat_hornet_rh
// Params 4
// Checksum 0x20291c35, Offset: 0x11fd
// Size: 0xee
function function_7e2d377b7d86c222( var_d00b944707343dc9, speed, perch = 1, angles )
{
    level utility::flag_set( "pg_inflight" );
    level.tb_pigeon thread rotate_bird( angles, speed );
    level.tb_pigeon utility::function_7c10ea82c1e305b8( "anim", "fly" );
    level.tb_pigeon utility::function_7c10ea82c1e305b8( "vfx", "on" );
    utility::function_2159dd4196ff4b81( var_d00b944707343dc9, speed, 1, 1, 0, 1, 1, 1 );
    level utility::flag_clear( "pg_inflight" );
    level notify( #"flight_complete" );
    
    if ( perch == 1 )
    {
        level.tb_pigeon utility::function_7c10ea82c1e305b8( "anim", "perch" );
        level.tb_pigeon utility::function_7c10ea82c1e305b8( "vfx", "off" );
    }
}

// Namespace zm_sat_hornet_rh
// Params 2
// Checksum 0x71aff814, Offset: 0x12f3
// Size: 0x1e
function rotate_bird( angles, speed )
{
    self rotateto( angles, speed );
}

// Namespace zm_sat_hornet_rh
// Params 0
// Checksum 0xa9c462f9, Offset: 0x1319
// Size: 0x65
function failure_loop()
{
    level endon( #"game_ended" );
    level endon( #"stop_spline" );
    level.tb_pigeon.id = undefined;
    
    while ( !level utility::flag( "starting_tree_triggered" ) )
    {
        level.tb_pigeon function_7e2d377b7d86c222( level.var_ae522ec45ca9f25a, 4, 0, level.var_2b8ed3563e698d3f );
    }
}

// Namespace zm_sat_hornet_rh
// Params 0
// Checksum 0xf2e0de23, Offset: 0x1386
// Size: 0x5c
function function_c9db42ef48369314()
{
    if ( !level utility::flag( "first_flight_vo" ) )
    {
        level utility::flag_set( "first_flight_vo" );
        level thread overlord::playconversation( hashcat( #"hash_10b2bfacf500c70c", randomintrange( 1, 3 ) ) );
        return;
    }
    
    level thread overlord::playconversation( hashcat( #"hash_9e1256a3eb9e8b3d", randomintrange( 1, 9 ) ) );
}

// Namespace zm_sat_hornet_rh
// Params 1
// Checksum 0x3e2e087d, Offset: 0x13ea
// Size: 0x330
function check_tree_storm_started( params )
{
    tree = params.tree;
    
    if ( !level callback::exists( "tree_storm_ended", &check_tree_storm_ended ) )
    {
        level callback::add( "tree_storm_ended", &check_tree_storm_ended );
    }
    
    if ( level utility::flag( "pg_wait_flight" ) )
    {
        return;
    }
    
    if ( tree.targetname != "zone_main_keep_tree" && !level utility::flag( "box_rolled" ) )
    {
        level utility::flag_set( "pg_wait_flight" );
        level utility::flag_set( "flight_failed" );
        return;
    }
    
    foreach ( var_f6f96163bcc5370 in level.sakura_root.all_trees )
    {
        if ( var_f6f96163bcc5370.var_c50f749e8cfd5137 && !var_f6f96163bcc5370.var_93d1cc32428929a7 )
        {
            return;
        }
    }
    
    if ( tree.targetname == "zone_main_keep_tree" && !level utility::flag( "starting_tree_triggered" ) )
    {
        level utility::flag_set( "starting_tree_triggered" );
    }
    
    if ( tree.targetname == "zone_main_keep_tree" && level utility::flag( "starting_tree_triggered" ) && level utility::flag( "flight_failed" ) )
    {
        level utility::flag_clear( "flight_failed" );
        level utility::flag_set( "starting_tree_triggered" );
        level utility::flag_set( "pf_first_stop" );
        level notify( #"stop_spline" );
        wait 1;
        var_2507853f87e521e3 = utility::getstruct( "pg_perch_start", "script_noteworthy" );
        
        if ( level.tb_pigeon )
        {
            level.tb_pigeon moveto( var_2507853f87e521e3.origin, 2 );
            level utility::flag_clear( "pg_inflight" );
            wait 2;
            level.tb_pigeon utility::function_7c10ea82c1e305b8( "anim", "perch" );
            level.tb_pigeon utility::function_7c10ea82c1e305b8( "vfx", "off" );
            level.tb_pigeon.id = "fp_path";
        }
        
        if ( level.var_ce1470413371c515 && level.var_ce1470413371c515.targetname == "zone_second_bailey_tree" && level utility::flag( "pf_first_stop" ) )
        {
            level.tb_pigeon thread function_7e2d377b7d86c222( level.first_tree_path, 10, 1, level.var_6e30cde13eee35f2 );
            level.tb_pigeon.id = "ft_path";
            level thread function_c9db42ef48369314();
            level utility::flag_set( "pf_second_stop" );
        }
    }
    
    if ( level utility::flag( "pf_first_stop" ) )
    {
        wait 2;
        
        while ( level utility::flag( "pg_inflight" ) )
        {
            wait 1;
        }
        
        level thread function_27e6fa3e278f7595();
        check_flight_path( tree );
    }
}

// Namespace zm_sat_hornet_rh
// Params 1
// Checksum 0x2aa1cdaa, Offset: 0x1722
// Size: 0x94
function check_tree_storm_ended( params )
{
    if ( level utility::flag( "pg_inflight" ) )
    {
        level waittill( #"flight_complete" );
    }
    
    level notify( #"flight_end" );
    level callback::remove( "tree_storm_ended", &check_tree_storm_ended );
    level utility::flag_clear( "pf_second_stop" );
    level utility::flag_clear( "pf_third_stop" );
    level utility::flag_clear( "pf_fourth_stop" );
    level utility::flag_clear( "pf_first_stop" );
    level utility::flag_clear( "starting_tree_triggered" );
    level utility::flag_clear( "pg_wait_flight" );
}

// Namespace zm_sat_hornet_rh
// Params 0
// Checksum 0x74a052f2, Offset: 0x17be
// Size: 0x31c
function function_27e6fa3e278f7595()
{
    level endon( #"game_ended" );
    level endon( #"flight_path_complete" );
    level waittill( #"flight_end" );
    
    if ( !level utility::flag( "tree_failure_vo" ) )
    {
        level utility::flag_set( "tree_failure_vo" );
        level thread overlord::playconversation( hashcat( #"hash_597a41ee2fa8108d", randomintrange( 1, 3 ) ) );
    }
    
    if ( level.tb_pigeon.origin == level.var_f5945aa4561dd7b5.origin )
    {
        return;
    }
    else if ( level.tb_pigeon.id == "fp_path" )
    {
        level.tb_pigeon function_7e2d377b7d86c222( level.var_be2f681a578c8fd4, 4, 0, level.var_e7e19f4a08d5a09d );
    }
    else if ( level.tb_pigeon.id == "ft_path" )
    {
        level.tb_pigeon function_7e2d377b7d86c222( level.first_tree_return_path, 10, 0, level.var_ea9dd628fb6998bb );
    }
    else if ( level.tb_pigeon.id == "st_path" )
    {
        level.tb_pigeon function_7e2d377b7d86c222( level.second_tree_return_path, 10, 0, level.var_3d5b287af647fc21 );
    }
    else if ( level.tb_pigeon.id == "tht_path" )
    {
        level.tb_pigeon function_7e2d377b7d86c222( level.third_tree_return_path, 10, 0, level.var_f8bb73ec1c1c1350 );
    }
    else
    {
        if ( !level.tb_pigeon )
        {
            return;
        }
        
        level.tb_pigeon waittill( #"stop_curve" );
        
        if ( level.tb_pigeon.origin == level.var_f5945aa4561dd7b5.origin )
        {
            return;
        }
        else if ( level.tb_pigeon.id == "ft_path" )
        {
            level.tb_pigeon function_7e2d377b7d86c222( level.first_tree_return_path, 10, 0, level.var_ea9dd628fb6998bb );
        }
        else if ( level.tb_pigeon.id == "st_path" )
        {
            level.tb_pigeon function_7e2d377b7d86c222( level.second_tree_return_path, 10, 0, level.var_3d5b287af647fc21 );
        }
        else if ( level.tb_pigeon.id == "tht_path" )
        {
            level.tb_pigeon function_7e2d377b7d86c222( level.third_tree_return_path, 10, 0, level.var_f8bb73ec1c1c1350 );
        }
    }
    
    level thread failure_loop();
    level utility::flag_set( "flight_failed" );
    level utility::flag_clear( "pf_second_stop" );
    level utility::flag_clear( "pf_third_stop" );
    level utility::flag_clear( "pf_fourth_stop" );
    level utility::flag_clear( "pf_first_stop" );
    level utility::flag_clear( "starting_tree_triggered" );
    level utility::flag_clear( "pg_wait_flight" );
}

// Namespace zm_sat_hornet_rh
// Params 1
// Checksum 0xa35886ab, Offset: 0x1ae2
// Size: 0x30d
function check_flight_path( tree )
{
    if ( tree.targetname == "zone_second_bailey_tree" )
    {
        if ( level utility::flag( "pf_first_stop" ) && !level utility::flag( "pf_second_stop" ) )
        {
            level.tb_pigeon thread function_7e2d377b7d86c222( level.first_tree_path, 10, 1, level.var_6e30cde13eee35f2 );
            level.tb_pigeon.id = "ft_path";
            level thread function_c9db42ef48369314();
            level utility::flag_set( "pf_second_stop" );
            level.tb_pigeon waittill( #"stop_curve" );
            
            if ( level.var_ce1470413371c515.targetname == "zone_third_bailey_tree" )
            {
                level.tb_pigeon function_7e2d377b7d86c222( level.second_tree_path, 10, 1, level.second_tree_path_angles );
                level.tb_pigeon.id = "st_path";
                level utility::flag_set( "pf_third_stop" );
            }
        }
        else
        {
            level notify( #"flight_end" );
        }
        
        return;
    }
    
    if ( tree.targetname == "zone_third_bailey_tree" )
    {
        if ( level utility::flag( "pf_second_stop" ) && !level utility::flag( "pf_third_stop" ) )
        {
            level.tb_pigeon thread function_7e2d377b7d86c222( level.second_tree_path, 10, 1, level.second_tree_path_angles );
            level.tb_pigeon.id = "st_path";
            level utility::flag_set( "pf_third_stop" );
            level.tb_pigeon waittill( #"stop_curve" );
            
            if ( level.var_ce1470413371c515.targetname == "zone_broken_turrets_tree" )
            {
                level.tb_pigeon function_7e2d377b7d86c222( level.third_tree_path, 10, 1, level.var_2d03ae610de605e3 );
                level.tb_pigeon.id = "tht_path";
                level utility::flag_set( "pf_fourth_stop" );
                
                if ( level thread callback::remove( "cb_storm_spawned", &function_228125d2faba4004 ) )
                {
                    level thread callback::add( "cb_storm_spawned", &function_228125d2faba4004 );
                }
            }
        }
        else
        {
            level notify( #"flight_end" );
        }
        
        return;
    }
    
    if ( tree.targetname == "zone_broken_turrets_tree" )
    {
        if ( level utility::flag( "pf_third_stop" ) && !level utility::flag( "pf_fourth_stop" ) )
        {
            level.tb_pigeon thread function_7e2d377b7d86c222( level.third_tree_path, 10, 1, level.var_2d03ae610de605e3 );
            level.tb_pigeon.id = "tht_path";
            level utility::flag_set( "pf_fourth_stop" );
            
            if ( level thread callback::remove( "cb_storm_spawned", &function_228125d2faba4004 ) )
            {
                level thread callback::add( "cb_storm_spawned", &function_228125d2faba4004 );
            }
            
            return;
        }
        
        level notify( #"flight_end" );
    }
}

// Namespace zm_sat_hornet_rh
// Params 1
// Checksum 0x6a57adfe, Offset: 0x1df7
// Size: 0x13a
function function_228125d2faba4004( params )
{
    var_41ceaa74258f977f = utility::getstruct( "cb_t_t", "targetname" );
    level.var_f5945aa4561dd7b5 = utility::getstruct( "fn_br_pt", "script_noteworthy" );
    level notify( #"flight_path_complete" );
    level callback::remove( "tree_storm_ended", &check_tree_storm_ended );
    level callback::remove( "tree_storm_started", &check_tree_storm_started );
    is_position_in_trigger = utility::function_148a680721859842( params.position, var_41ceaa74258f977f.origin, 700, 500 );
    
    if ( is_position_in_trigger && level utility::flag( "pf_fourth_stop" ) )
    {
        level thread callback::remove( "cb_storm_spawned", &function_228125d2faba4004 );
        level.tb_pigeon function_7e2d377b7d86c222( level.final_tree_path, 10, 1, level.var_2357bf2e7991da58 );
        level.tb_pigeon rotateto( level.var_f5945aa4561dd7b5.angles, 0.1 );
        level.tb_pigeon utility::function_7c10ea82c1e305b8( "vfx", "off" );
        spawn_toy( level.var_f5945aa4561dd7b5 );
    }
}

// Namespace zm_sat_hornet_rh
// Params 1
// Checksum 0x547ec62b, Offset: 0x1f39
// Size: 0x1b8
function spawn_toy( struct )
{
    s_final_pos = utility::getstruct( "tpc_f_p", "targetname" );
    var_754d0edb4bfe156c = utility::getstruct( "tpc_m_p", "targetname" );
    level.crane_toy = spawn( "script_model", struct.origin );
    level.crane_toy.angles = struct.angles;
    level.crane_toy setmodel( "sat_zm_origami_crane" );
    level.crane_toy hudoutlineenable( "outline_depth_orange" );
    wait 2;
    level.crane_toy playsoundonmovingent( #"hash_e63147ca67132f64" );
    playfxontag( level._effect[ #"toy_trail" ], level.crane_toy, "tag_origin" );
    waitframe();
    level.crane_toy utility::function_8001268940441423( struct.origin, s_final_pos.origin, var_754d0edb4bfe156c.origin, 5, 1, 1 );
    stopfxontag( level._effect[ #"toy_trail" ], level.crane_toy, "tag_origin" );
    playfxontag( level._effect[ #"toy_impact" ], level.crane_toy, "tag_origin" );
    playworldsound( level.crane_toy.origin + ( 0, 0, 25 ), #"hash_87dfa661a671fb08" );
    zm_quest::function_91f9590e98d57ff6( s_final_pos.origin, &toy_pickedup, &hidden_hint, "small" );
}

// Namespace zm_sat_hornet_rh
// Params 2
// Checksum 0x1488724c, Offset: 0x20f9
// Size: 0x36
function hidden_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_rh
// Params 1
// Checksum 0xb11853c8, Offset: 0x2138
// Size: 0x63
function toy_pickedup( player )
{
    playworldsound( level.crane_toy.origin + ( 0, 0, 25 ), #"hash_5f13eee5e0b0dcaf" );
    self freescriptable();
    level.crane_toy delete();
    level utility::flag_set( "toy_picked_up" );
    spawn_box_interact();
}

// Namespace zm_sat_hornet_rh
// Params 0
// Checksum 0x6821da90, Offset: 0x21a3
// Size: 0x56
function spawn_box_interact()
{
    box_interact = interaction::register_interact( level.tb_final.origin + ( 0, 0, 25 ), 60, &box_interact_func, &box_interact_hint );
    box_interact.pos = level.tb_wat_final;
}

// Namespace zm_sat_hornet_rh
// Params 1
// Checksum 0x3a7cbdc2, Offset: 0x2201
// Size: 0x6d
function box_interact_func( player )
{
    self delete();
    level thread overlord::playconversation( hashcat( #"hash_206be448fe49442b", randomintrange( 1, 3 ) ) );
    level.toy_box thread zm_rabbithole::toybox_give_reward( "sat_zm_origami_crane", ( 0, 90, 0 ) );
    level callback::add( "zm_exfil_success", &function_cf25da101db108b3 );
    level thread function_af7c0169a8e958dd( player );
}

// Namespace zm_sat_hornet_rh
// Params 1
// Checksum 0x87455354, Offset: 0x2276
// Size: 0x4f
function function_af7c0169a8e958dd( player )
{
    level endon( #"game_ended" );
    level waittill( #"rh_to_pic" );
    wait 2;
    level thread overlord::playconversation( hashcat( #"hash_bf912a38c873c12a", randomintrange( 1, 4 ) ) );
    wait 20;
    zm_rabbithole::function_1c6c02f0af873754();
}

// Namespace zm_sat_hornet_rh
// Params 2
// Checksum 0xbeaa8e53, Offset: 0x22cd
// Size: 0x36
function box_interact_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_rh
// Params 1
// Checksum 0x735a3a9a, Offset: 0x230c
// Size: 0x141
function function_cf25da101db108b3( params )
{
    if ( utility::flag( "rh_to_pic" ) )
    {
        event_str = zm_rabbithole::function_85eaee7552aadd2e();
        
        foreach ( player in params.a_exfil_players )
        {
            if ( player.var_e8b776e9698cb857 )
            {
                level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", event_str, [ player ] );
                
                if ( player.var_11f0a190160021dd && player.var_1bf107e8638f5574 && player.var_5388587ed7a9f314 && player.var_7fe31db612cd941a && player.var_27501a6cf23a6c06 )
                {
                    level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", #"hash_8f4de46115e0d713", [ player ] );
                }
            }
        }
    }
}

