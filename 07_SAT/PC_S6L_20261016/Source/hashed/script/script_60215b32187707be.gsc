// script_60215b32187707be  (hash_60215b32187707be.gscc) (size: 17418 Bytes / 0x440a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe5742290 (3849593488)
// size ...... 17418 (0x440a)
// includes .. 19  (offset: 0x3bde)
// strings ... 127 (offset: 0x3c76)
// dev strs .. 2   (offset: 0x43f2)
// exports ... 39  (offset: 0x28c2)
// cseg ...... 0xbac + 0x1d16 (0x28c2)
// imports ... 99  (offset: 0x2eda)
// animtree1 . 0   (offset: 0x440a)
// animtree2 . 0   (offset: 0x440a)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\snd\snd;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_audio;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;
#using scripts\mp\overlord;

#namespace namespace_71c43420242b7913;

/#

    // Namespace namespace_71c43420242b7913
    // Params 0
    // Checksum 0xe012764d, Offset: 0xbca
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_71c43420242b7913
// Params 0, eflags: 0x5
// Checksum 0x5f61296a, Offset: 0xbd7
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_cb2a85764d5f3a38", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_71c43420242b7913
// Params 0, eflags: 0x4
// Checksum 0x115bcd5, Offset: 0xc00
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_FREEWAY_PARKOUR";
    activity_common::registeractivitytype( "OB_VIRGO_FREEWAY_PARKOUR", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_PARKOUR", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_PARKOUR", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_PARKOUR", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x2d559530, Offset: 0xc61
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance freeway_parkour_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0xcf65ffd7, Offset: 0xcc6
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance freeway_parkour_main();
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x7d25edb2, Offset: 0xd00
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

/#

    // Namespace namespace_71c43420242b7913
    // Params 0
    // Checksum 0xa7a8d25d, Offset: 0xd24
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0xcb4446fc, Offset: 0xd31
// Size: 0x47
function freeway_parkour_start()
{
    level thread utility::exploder( "fx_freeway_inverted" );
    level thread utility::exploder( "fx_freeway_broken" );
    level thread virgo_vo::function_93593d5e3c494229();
    level thread ob_virgo_util::function_4ec71c3da6905745();
    activity_instance = self;
    level.objective_waypoint = "struct_obj_waypoint_freeway_parkour";
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x15f35eac, Offset: 0xd80
// Size: 0x3a
function function_7801d8ea4e071560()
{
    level endon( #"flag_frogger_top" );
    level utility::flag_wait( "flag_conv_la_freeway_parkour_done" );
    wait 15;
    
    if ( !utility::flag( "flag_frogger_top" ) )
    {
        level utility::flag_set( "flag_parkour_vo_climb" );
    }
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x62b02919, Offset: 0xdc2
// Size: 0x474
function freeway_parkour_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    thread function_863fd685fef731c5();
    level thread function_bb0cc032561f44f7();
    activity_instance ob_virgo_util::setup_ui_widget( "OB_VIRGO_FREEWAY_PARKOUR" );
    level.objective_waypoint = "obj_parkour_end";
    thread ob_story_mission_utils::function_56960723e6738b6c( "OB_VIRGO_FREEWAY_PARKOUR", level.objective_waypoint, undefined, "obj_waypoint_freeway_canyon_done", undefined, undefined, 0 );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_parkour_start", "flag_parkour_start" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_parkour_vo", "flag_parkour_vo" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_frogger_vo_1", "flag_frogger_la_traffic" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_frogger_vo_2", "flag_frogger_move_quick" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_parkour_cradle_effects", "flag_parkour_cradle_effects" );
    level thread function_d5a43c8309204ad0();
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_parkour_top", "flag_parkour_top" );
    level utility::flag_wait( "flag_parkour_top" );
    scene_samuels_overlook = utility::getstruct( "scene_samuels_overlook", "targetname" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_frogger_top", "flag_frogger_top" );
    level utility::flag_wait( "flag_frogger_top" );
    assets = [];
    distances = [];
    assets[ assets.size ] = "sat_wc_cradle_warp_01_alt_vfx";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "sat_wc_cradle_warp_02_alt_vfx";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "sat_wc_cradle_warp_02a_alt_vfx";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "sat_wc_cradle_warp_02b_alt_vfx";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "sat_wc_cradle_warp_02c_alt_vfx";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "sat_wc_cradle_warp_03_alt_vfx";
    distances[ distances.size ] = 128;
    
    foreach ( player in level.players )
    {
        player thread utility::player_prestream_assets( "virgo_freeway_parkour", "model", assets, distances, -1 );
    }
    
    scene_broken_freeway_drone = utility::getstruct( "scene_broken_freeway_drone", "targetname" );
    scene_broken_freeway_drone thread ob_virgo_util::function_29164af2d4d89658();
    scene_broken_freeway_drone thread scene::play();
    level utility::flag_wait( "frogger_move_quick_vo_done" );
    scene_samuels_overlook thread scene::play( undefined, "Echo" );
    level thread function_47c303dcb5d8568f();
    level thread function_68a648e2bdd820b3();
    waitframe();
    samuels_ent = scene_samuels_overlook scene::get_entity( "Samuels" );
    samuels_ent.team = level.players[ 0 ].team;
    level notify( #"highvis_reload_outline", samuels_ent.team, [ samuels_ent ] );
    level ob_virgo_util::echo_fragment_transition( activity_instance, "OB_VIRGO_FREEWAY_CRASHSITE", "int_memory_jump_02", "flag_virgo_memory_jump_02_done", "flag_frogger_to_crashsite_bink_done", 0, 256 );
    level utility::flag_set( "flag_frogger_to_crashsite_bink_done" );
    level utility::exploder( "fx_freeway_crashsite_bc" );
    level utility::flag_wait( "flag_frogger_to_crashsite_bink_done" );
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light" );
    all_ai = getaiarray();
    
    foreach ( ai in all_ai )
    {
        if ( isalive( ai ) )
        {
            playfx( level._effect[ "enemy_death_cleanup" ], ai.origin );
            ai agent_utils::despawnagent();
        }
    }
    
    foreach ( player in level.players )
    {
        player utility::player_prestream_clear( "virgo_freeway_parkour" );
    }
    
    waypoint_objective_handler::waypoint_objective_handler_cancel( level.objective_waypoint );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0xefa2e0ba, Offset: 0x123e
// Size: 0x8b
function function_68a648e2bdd820b3()
{
    level utility::flag_wait( "int_memory_jump_02" );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "heavy_3s" );
    }
}

// Namespace namespace_71c43420242b7913
// Params 0, eflags: 0x4
// Checksum 0x39dfb199, Offset: 0x12d1
// Size: 0xab
function private function_863fd685fef731c5()
{
    level endon( #"game_ended" );
    completion_trigger = getentarray( "trig_frogger_top", #targetname )[ 0 ];
    
    if ( !completion_trigger )
    {
        completion_trigger = getnoentvolumearray( "trig_frogger_top", #targetname )[ 0 ];
        
        if ( !completion_trigger )
        {
            /#
                iprintlnbold( "<dev string:x24>" + "<dev string:x47>" );
            #/
            
            return;
        }
    }
    
    while ( true )
    {
        completion_trigger waittill( #"trigger", data );
        
        if ( isplayer( data ) )
        {
            level callback::callback( #"frogger_complete", { #player:data } );
        }
        
        waitframe();
    }
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x765a4221, Offset: 0x1384
// Size: 0x10a
function function_d5a43c8309204ad0()
{
    level utility::flag_wait( "flag_parkour_cradle_effects" );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
    
    level utility::flag_wait( "flag_frogger_la_traffic" );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x2d354bf7, Offset: 0x1496
// Size: 0xd1
function function_47c303dcb5d8568f()
{
    wait 2;
    activateworldevent( "lgt_portal_2" );
    bm_cradle_portal_clip_02 = getent( "bm_cradle_portal_clip_02", "targetname" );
    level utility::exploder( "fx_warp_02" );
    bm_cradle_portal_clip_02 virgo_audio::inverted_portal_open( "flag_frogger_to_crashsite_bink_done" );
    wait 1.8;
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
    
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light" );
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x7c72796f, Offset: 0x156f
// Size: 0xa
function function_bb0cc032561f44f7()
{
    level thread function_aff93b796c7e3125();
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x48589695, Offset: 0x1581
// Size: 0x90
function function_5de2d4f73281d8bd()
{
    parkour_lightpost_01 = getent( "parkour_lightpost_01", "targetname" );
    parkour_lightpost_02 = getent( "parkour_lightpost_02", "targetname" );
    var_aa51443487c71c68 = getent( parkour_lightpost_01.target, "targetname" );
    var_aa51443487c71c68 linkto( parkour_lightpost_01 );
    parkour_lightpost_01 thread rotate_lightpost();
    wait 2.5;
    var_aa51443487c71c68 = getent( parkour_lightpost_02.target, "targetname" );
    var_aa51443487c71c68 linkto( parkour_lightpost_02 );
    parkour_lightpost_02 thread rotate_lightpost();
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x7b56de08, Offset: 0x1619
// Size: 0x2c
function rotate_lightpost()
{
    while ( true )
    {
        self rotateroll( 360, 3 );
        thread virgo_audio::function_7aa4f6f25beab23b();
        self waittill( #"rotatedone" );
        wait 3;
    }
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0xcfc7bb03, Offset: 0x164d
// Size: 0xcd
function function_9e85ed294cde3b82()
{
    parkour_floating_signs = getentarray( "parkour_floating_signs", "targetname" );
    
    foreach ( sign in parkour_floating_signs )
    {
        sign_clip = getent( sign.target, "targetname" );
        sign_clip linkto( sign );
        var_def68e8d6c25ac6f = randomfloatrange( 0.3, 2 );
        wait var_def68e8d6c25ac6f;
        sign thread ob_virgo_util::function_8099635f87b4d57c();
    }
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0xde3005bd, Offset: 0x1722
// Size: 0x25
function function_a62a760853d1bd9e()
{
    sm_up_and_down_car = getent( "sm_up_and_down_car", "targetname" );
    sm_up_and_down_car thread function_a8ce740371d77e27();
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x76d45332, Offset: 0x174f
// Size: 0x84
function function_a8ce740371d77e27()
{
    var_aa51443487c71c68 = getent( self.target, "targetname" );
    var_aa51443487c71c68 linkto( self );
    
    while ( true )
    {
        self movez( -192, 3 );
        playfx( level._effect[ "enemy_vanish" ], self.origin );
        wait 3;
        self movez( 192, 3 );
        playfx( level._effect[ "enemy_vanish" ], self.origin );
        wait 3;
    }
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x34c99694, Offset: 0x17db
// Size: 0x25
function function_fe7871f4841dcce0()
{
    sm_right_left_veh = getent( "sm_right_left_veh", "targetname" );
    sm_right_left_veh thread function_bbeeffa3ed9842af();
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0xf3251c77, Offset: 0x1808
// Size: 0xdc
function function_bbeeffa3ed9842af()
{
    var_aa51443487c71c68 = getent( self.target, "targetname" );
    var_aa51443487c71c68 linkto( self );
    s_right_left_veh_start = utility::getstruct( "s_right_left_veh_start", "targetname" );
    s_right_left_veh_end = utility::getstruct( s_right_left_veh_start.target, "targetname" );
    n_move_time = 2;
    
    while ( true )
    {
        self moveto( s_right_left_veh_end.origin, n_move_time );
        playfx( level._effect[ "enemy_vanish" ], self.origin );
        wait 3;
        self moveto( s_right_left_veh_start.origin, n_move_time );
        playfx( level._effect[ "enemy_vanish" ], self.origin );
        wait 3;
    }
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x23c1868f, Offset: 0x18ec
// Size: 0x9a
function function_807bd46def2bc358()
{
    e_cradle_poof_platform_01 = getent( "e_cradle_poof_platform_01", "targetname" );
    e_cradle_poof_platform_02 = getent( "e_cradle_poof_platform_02", "targetname" );
    e_cradle_poof_platform_03 = getent( "e_cradle_poof_platform_03", "targetname" );
    e_cradle_poof_platform_04 = getent( "e_cradle_poof_platform_04", "targetname" );
    e_cradle_poof_platform_01 thread function_3019c753c5f1b2b0();
    wait 0.5;
    e_cradle_poof_platform_02 thread function_3019c753c5f1b2b0();
    wait 0.5;
    e_cradle_poof_platform_03 thread function_3019c753c5f1b2b0();
    wait 0.5;
    e_cradle_poof_platform_04 thread function_3019c753c5f1b2b0();
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x47953f18, Offset: 0x198e
// Size: 0x46
function function_3019c753c5f1b2b0()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.var_aa51443487c71c68 = getent( self.target, "targetname" );
    self.var_aa51443487c71c68 linkto( self );
    self show();
    self solid();
    thread function_99ec5f084bacbc3b();
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0xa711e9a1, Offset: 0x19dc
// Size: 0x26
function function_99ec5f084bacbc3b()
{
    var_def68e8d6c25ac6f = randomfloatrange( 0.3, 2 );
    wait var_def68e8d6c25ac6f;
    thread ob_virgo_util::function_8099635f87b4d57c();
}

// Namespace namespace_71c43420242b7913
// Params 5
// Checksum 0x901ec61c, Offset: 0x1a0a
// Size: 0x143
function function_e1d3a064c63da75a( var_6fcf470d42d51f8e, scene_name, delay, start_struct, var_fe41cd39c047e1b9 )
{
    level endon( #"stop_frogger" );
    scene_struct = self;
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    trig = getent( var_6fcf470d42d51f8e, "targetname" );
    
    if ( !isdefined( trig ) )
    {
        return;
    }
    
    trig endon( #"death" );
    trig thread function_9fda42f53fa80ebe();
    
    while ( !utility::flag( "flag_frogger_to_crashsite_bink_done" ) )
    {
        random_shot = utility::array_random( level.frogger_shots );
        
        if ( isdefined( start_struct ) )
        {
            playfx( level._effect[ "frogger_veh_spawn" ], start_struct.origin, anglestoforward( start_struct.angles ) );
        }
        
        level thread function_7142d8a8ca809e3b( trig );
        scene_struct scene::play( undefined, random_shot, scene_name );
        trig.veh_active = 0;
        
        if ( isdefined( var_fe41cd39c047e1b9 ) )
        {
            playfx( level._effect[ "frogger_veh_spawn" ], var_fe41cd39c047e1b9.origin, anglestoforward( var_fe41cd39c047e1b9.angles ) );
        }
        
        function_2a8d380fd763c6a9();
    }
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x91b78da1, Offset: 0x1b55
// Size: 0x3b
function function_2a8d380fd763c6a9()
{
    if ( level.var_d54ad69d2c51a5b0 >= 3 )
    {
        wait_time = level.var_d54ad69d2c51a5b0 * 0.25;
        wait_time = clamp( wait_time, 0, 2 );
        wait wait_time;
    }
    
    waitframe();
}

// Namespace namespace_71c43420242b7913
// Params 5
// Checksum 0x4dc8a989, Offset: 0x1b98
// Size: 0x12e
function function_c672d0e5324b13b3( var_6fcf470d42d51f8e, scene_name, delay, start_struct, var_fe41cd39c047e1b9 )
{
    level endon( #"stop_frogger" );
    scene_struct = self;
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    trig = getent( var_6fcf470d42d51f8e, "targetname" );
    
    if ( !isdefined( trig ) )
    {
        return;
    }
    
    trig thread function_9fda42f53fa80ebe();
    trig endon( #"death" );
    
    while ( !utility::flag( "flag_frogger_to_crashsite_bink_done" ) )
    {
        if ( isdefined( start_struct ) )
        {
            playfx( level._effect[ "frogger_bike_spawn" ], start_struct.origin, anglestoforward( start_struct.angles ) );
        }
        
        level thread function_7142d8a8ca809e3b( trig );
        scene_struct scene::play( undefined, "motorcycle", scene_name );
        trig.veh_active = 0;
        
        if ( isdefined( var_fe41cd39c047e1b9 ) )
        {
            playfx( level._effect[ "frogger_bike_spawn" ], var_fe41cd39c047e1b9.origin, anglestoforward( var_fe41cd39c047e1b9.angles ) );
        }
        
        function_2a8d380fd763c6a9();
    }
}

// Namespace namespace_71c43420242b7913
// Params 1
// Checksum 0x2f507acc, Offset: 0x1cce
// Size: 0x2d
function function_7142d8a8ca809e3b( trig )
{
    trig endon( #"death" );
    wait 0.1;
    trig.veh_active = 1;
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x4f997cae, Offset: 0x1d03
// Size: 0x7c
function function_61614eada8760cdc()
{
    trig_frogger_lane_01_car_01 = getent( "trig_frogger_lane_01_car_01", "targetname" );
    veh_tag = "tag_origin";
    trig_frogger_lane_01_car_01.origin = self gettagorigin( veh_tag );
    trig_frogger_lane_01_car_01.angles = self gettagangles( veh_tag );
    trig_frogger_lane_01_car_01 enablelinkto();
    trig_frogger_lane_01_car_01 linkto( self, veh_tag, ( 0, 0, 32 ), ( 0, 90, 0 ) );
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x839067e, Offset: 0x1d87
// Size: 0x7c
function function_d014ad921c6700c9()
{
    trig_frogger_lane_02_car_01 = getent( "trig_frogger_lane_02_car_01", "targetname" );
    veh_tag = "tag_origin";
    trig_frogger_lane_02_car_01.origin = self gettagorigin( veh_tag );
    trig_frogger_lane_02_car_01.angles = self gettagangles( veh_tag );
    trig_frogger_lane_02_car_01 enablelinkto();
    trig_frogger_lane_02_car_01 linkto( self, veh_tag, ( 0, 0, 32 ), ( 0, 90, 0 ) );
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x35592fce, Offset: 0x1e0b
// Size: 0x7c
function function_40efba7a37e2a8ca()
{
    trig_frogger_lane_03_car_01 = getent( "trig_frogger_lane_03_car_01", "targetname" );
    veh_tag = "tag_origin";
    trig_frogger_lane_03_car_01.origin = self gettagorigin( veh_tag );
    trig_frogger_lane_03_car_01.angles = self gettagangles( veh_tag );
    trig_frogger_lane_03_car_01 enablelinkto();
    trig_frogger_lane_03_car_01 linkto( self, veh_tag, ( 0, 0, 32 ), ( 0, 90, 0 ) );
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x8779f3de, Offset: 0x1e8f
// Size: 0x7c
function function_aca64510e9421707()
{
    trig_frogger_lane_04_car_01 = getent( "trig_frogger_lane_04_car_01", "targetname" );
    veh_tag = "tag_origin";
    trig_frogger_lane_04_car_01.origin = self gettagorigin( veh_tag );
    trig_frogger_lane_04_car_01.angles = self gettagangles( veh_tag );
    trig_frogger_lane_04_car_01 enablelinkto();
    trig_frogger_lane_04_car_01 linkto( self, veh_tag, ( 0, 0, 32 ), ( 0, 90, 0 ) );
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0xc3a611d, Offset: 0x1f13
// Size: 0x7c
function function_7f0425a8b846569e()
{
    trig_frogger_lane_01_moto_01 = getent( "trig_frogger_lane_01_moto_01", "targetname" );
    veh_tag = "tag_origin";
    trig_frogger_lane_01_moto_01.origin = self gettagorigin( veh_tag );
    trig_frogger_lane_01_moto_01.angles = self gettagangles( veh_tag );
    trig_frogger_lane_01_moto_01 enablelinkto();
    trig_frogger_lane_01_moto_01 linkto( self, veh_tag, ( 0, 0, 32 ), ( 0, 90, 0 ) );
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x953330a7, Offset: 0x1f97
// Size: 0x7c
function function_7f0424a8b846546b()
{
    trig_frogger_lane_04_moto_01 = getent( "trig_frogger_lane_04_moto_01", "targetname" );
    veh_tag = "tag_origin";
    trig_frogger_lane_04_moto_01.origin = self gettagorigin( veh_tag );
    trig_frogger_lane_04_moto_01.angles = self gettagangles( veh_tag );
    trig_frogger_lane_04_moto_01 enablelinkto();
    trig_frogger_lane_04_moto_01 linkto( self, veh_tag, ( 0, 0, 32 ), ( 0, 90, 0 ) );
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x2332bca5, Offset: 0x201b
// Size: 0x5d6
function function_aff93b796c7e3125()
{
    level.frogger_shots = [];
    level.frogger_shots[ level.frogger_shots.size ] = "microbus_black";
    level.frogger_shots[ level.frogger_shots.size ] = "microbus_blue";
    level.frogger_shots[ level.frogger_shots.size ] = "microbus_green";
    level.frogger_shots[ level.frogger_shots.size ] = "microbus_grey";
    level.frogger_shots[ level.frogger_shots.size ] = "microbus_red";
    level.frogger_shots[ level.frogger_shots.size ] = "microbus_white";
    level.frogger_shots[ level.frogger_shots.size ] = "microbus_yellow";
    level.frogger_shots[ level.frogger_shots.size ] = "sedan_black";
    level.frogger_shots[ level.frogger_shots.size ] = "sedan_blue";
    level.frogger_shots[ level.frogger_shots.size ] = "sedan_brown";
    level.frogger_shots[ level.frogger_shots.size ] = "sedan_gray";
    level.frogger_shots[ level.frogger_shots.size ] = "sedan_green";
    level.frogger_shots[ level.frogger_shots.size ] = "sedan_red";
    level.frogger_shots[ level.frogger_shots.size ] = "sedan_white";
    level.frogger_shots[ level.frogger_shots.size ] = "hatch_black";
    level.frogger_shots[ level.frogger_shots.size ] = "hatch_blue";
    level.frogger_shots[ level.frogger_shots.size ] = "hatch_brown";
    level.frogger_shots[ level.frogger_shots.size ] = "hatch_red";
    level.frogger_shots[ level.frogger_shots.size ] = "hatch_silver";
    level.frogger_shots[ level.frogger_shots.size ] = "hatch_white";
    level.frogger_shots[ level.frogger_shots.size ] = "hatch_yellow";
    level.frogger_shots[ level.frogger_shots.size ] = "police_lights";
    level.frogger_shots[ level.frogger_shots.size ] = "police_lights";
    level.frogger_shots[ level.frogger_shots.size ] = "police_lights";
    level.frogger_shots[ level.frogger_shots.size ] = "police_lights";
    level.frogger_shots[ level.frogger_shots.size ] = "police_lights";
    level.frogger_shots[ level.frogger_shots.size ] = "police_lights";
    level.frogger_shots[ level.frogger_shots.size ] = "police_lights";
    level.frogger_shots[ level.frogger_shots.size ] = "suv_black";
    level.frogger_shots[ level.frogger_shots.size ] = "suv_blue";
    level.frogger_shots[ level.frogger_shots.size ] = "suv_gray";
    level.frogger_shots[ level.frogger_shots.size ] = "suv_green";
    level.frogger_shots[ level.frogger_shots.size ] = "suv_red";
    level.frogger_shots[ level.frogger_shots.size ] = "suv_white";
    level.frogger_shots[ level.frogger_shots.size ] = "suv_yellow";
    level.var_d54ad69d2c51a5b0 = 0;
    var_a66e0b78ae85bac0 = utility::getstruct( "struct_lane_01_car_01", "targetname" );
    var_a66e0b78ae85bac0 scene::add_spawn_function( &function_61614eada8760cdc );
    var_a66e0e78ae85c159 = utility::getstruct( "struct_lane_02_car_01", "targetname" );
    var_a66e0e78ae85c159 scene::add_spawn_function( &function_d014ad921c6700c9 );
    var_a66e0d78ae85bf26 = utility::getstruct( "struct_lane_03_car_01", "targetname" );
    var_a66e0d78ae85bf26 scene::add_spawn_function( &function_40efba7a37e2a8ca );
    var_a66e1078ae85c5bf = utility::getstruct( "struct_lane_04_car_01", "targetname" );
    var_a66e1078ae85c5bf scene::add_spawn_function( &function_aca64510e9421707 );
    var_c374b049b88f5f89 = utility::getstruct( "struct_lane_01_moto_01", "targetname" );
    var_c374b049b88f5f89 scene::add_spawn_function( &function_7f0425a8b846569e );
    var_c374ad49b88f58f0 = utility::getstruct( "struct_lane_04_moto_01", "targetname" );
    var_c374ad49b88f58f0 scene::add_spawn_function( &function_7f0424a8b846546b );
    start_struct = utility::getstruct( "struct_lane_01_fx_start", "targetname" );
    var_fe41cd39c047e1b9 = utility::getstruct( "struct_lane_01_fx_end", "targetname" );
    var_a66e0b78ae85bac0 thread function_e1d3a064c63da75a( "trig_frogger_lane_01_car_01", "sat_scene_frogger_lane_01", undefined, start_struct, var_fe41cd39c047e1b9 );
    start_struct = utility::getstruct( "struct_lane_02_fx_start", "targetname" );
    var_fe41cd39c047e1b9 = utility::getstruct( "struct_lane_02_fx_end", "targetname" );
    var_a66e0e78ae85c159 thread function_e1d3a064c63da75a( "trig_frogger_lane_02_car_01", "sat_scene_frogger_lane_02", undefined, start_struct, var_fe41cd39c047e1b9 );
    start_struct = utility::getstruct( "struct_moto_fx_start", "targetname" );
    var_fe41cd39c047e1b9 = utility::getstruct( "struct_moto_fx_end", "targetname" );
    var_c374b049b88f5f89 thread function_c672d0e5324b13b3( "trig_frogger_lane_01_moto_01", "sat_scene_frogger_lane_01", 3, start_struct, var_fe41cd39c047e1b9 );
    start_struct = utility::getstruct( "struct_lane_03_fx_start", "targetname" );
    var_fe41cd39c047e1b9 = utility::getstruct( "struct_lane_03_fx_end", "targetname" );
    var_a66e0d78ae85bf26 thread function_e1d3a064c63da75a( "trig_frogger_lane_03_car_01", "sat_scene_frogger_lane_03", 1.5, start_struct, var_fe41cd39c047e1b9 );
    start_struct = utility::getstruct( "struct_lane_04_fx_start", "targetname" );
    var_fe41cd39c047e1b9 = utility::getstruct( "struct_lane_04_fx_end", "targetname" );
    var_a66e1078ae85c5bf thread function_e1d3a064c63da75a( "trig_frogger_lane_04_car_01", "sat_scene_frogger_lane_04", 0.5, start_struct, var_fe41cd39c047e1b9 );
}

// Namespace namespace_71c43420242b7913
// Params 0
// Checksum 0x239fc5f5, Offset: 0x25f9
// Size: 0x236
function function_9fda42f53fa80ebe()
{
    level endon( #"stop_frogger" );
    self endon( #"death" );
    parkour_frogger_start = utility::getstruct( "parkour_frogger_start", "targetname" );
    parkour_frogger_start_01 = utility::getstruct( "parkour_frogger_start_01", "targetname" );
    parkour_frogger_start_02 = utility::getstruct( "parkour_frogger_start_02", "targetname" );
    parkour_frogger_start_03 = utility::getstruct( "parkour_frogger_start_03", "targetname" );
    parkour_frogger_start_04 = utility::getstruct( "parkour_frogger_start_04", "targetname" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && self.veh_active )
        {
            level.var_d54ad69d2c51a5b0 += 1;
            stun_duration = 1.5;
            playfx( level._effect[ "enemy_death_cleanup" ], ent.origin );
            ent thread shellshock_utility_cpmp::_shellshock( %"sat_ob_virgo_frogger_hit", #"flash", stun_duration, 1, 1500 );
            ent playrumbleonentity( "damage_heavy" );
            ent playsoundtoplayer( "evt_spawn_frogger_car_hit_2d", ent );
            snd::play( "evt_spawn_frogger_car_hit_3d", ent.origin );
            
            if ( !isdefined( ent.var_600507ec1d8676a8 ) )
            {
                if ( ob::nightmare() )
                {
                    waitframe();
                }
                else
                {
                    ent.var_600507ec1d8676a8 = 1;
                    level thread overlord::playevent( "event_la_freeway_rushhour", [ ent ], 2 );
                }
            }
            
            if ( ent == level.players[ 0 ] )
            {
                ent thread function_3b1d7b25990d8f3e( parkour_frogger_start_01, 0.05 );
                continue;
            }
            
            if ( ent == level.players[ 1 ] )
            {
                ent thread function_3b1d7b25990d8f3e( parkour_frogger_start_02, 0.05 );
                continue;
            }
            
            if ( ent == level.players[ 2 ] )
            {
                ent thread function_3b1d7b25990d8f3e( parkour_frogger_start_03, 0.05 );
                continue;
            }
            
            if ( ent == level.players[ 3 ] )
            {
                ent thread function_3b1d7b25990d8f3e( parkour_frogger_start_04, 0.05 );
            }
        }
    }
}

// Namespace namespace_71c43420242b7913
// Params 2
// Checksum 0x22ddac82, Offset: 0x2837
// Size: 0x8b
function function_3b1d7b25990d8f3e( s_teleport_ref, wait_time )
{
    player = self;
    player endon( #"death" );
    player hud_util::fade_out( wait_time, "white" );
    player freezecontrols( 1 );
    coop::teleport_player( player, s_teleport_ref );
    wait wait_time;
    player hud_util::fade_in( wait_time, "white" );
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light", 1, player );
    wait 1;
    player freezecontrols( 0 );
    player playrumbleonentity( "damage_heavy" );
}

