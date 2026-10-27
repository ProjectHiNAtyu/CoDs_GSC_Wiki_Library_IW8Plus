// script_187126f2318df171  (hash_187126f2318df171.gscc) (size: 8927 Bytes / 0x22df / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4ef70397 (1324811159)
// size ...... 8927 (0x22df)
// includes .. 14  (offset: 0x1f13)
// strings ... 56  (offset: 0x1f83)
// dev strs .. 0   (offset: 0x22df)
// exports ... 20  (offset: 0x118f)
// cseg ...... 0x54a + 0xc45 (0x118f)
// imports ... 89  (offset: 0x14af)
// animtree1 . 0   (offset: 0x22df)
// animtree2 . 0   (offset: 0x22df)
#using script_4d6ddd547bcd9399;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_lighting;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;
#using scripts\mp\overlord;

#namespace namespace_23a5805143aa7eed;

/#

    // Namespace namespace_23a5805143aa7eed
    // Params 0
    // Checksum 0x879371b3, Offset: 0x568
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_23a5805143aa7eed
// Params 0, eflags: 0x5
// Checksum 0xc3b88800, Offset: 0x575
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b138a39c197783b0", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_23a5805143aa7eed
// Params 0, eflags: 0x4
// Checksum 0xbb5cd436, Offset: 0x59e
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_PROCESSING_DOORS";
    activity_common::registeractivitytype( "OB_LIBRA_PROCESSING_DOORS", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_PROCESSING_DOORS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_PROCESSING_DOORS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_PROCESSING_DOORS", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0xf32a2ca1, Offset: 0x5ff
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start_func();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0x31cca59, Offset: 0x664
// Size: 0x47
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance main_func();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0x1aa4ea4c, Offset: 0x6b3
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0xa3f40fbf, Offset: 0x6d7
// Size: 0x50
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_PROCESSING_DOORS" );
    ob_story_mission_utils::function_315d79883d962ba7( 0, 2 );
    utility::flag_wait_any( "door_a_open", "door_b_open" );
    ob_story_mission_utils::function_315d79883d962ba7( 1, 2 );
    utility::flag_wait_all( "door_a_open", "door_b_open" );
    ob_story_mission_utils::function_315d79883d962ba7( 2, 2 );
}

/#

    // Namespace namespace_23a5805143aa7eed
    // Params 0
    // Checksum 0xc029d5a3, Offset: 0x72f
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0xce087354, Offset: 0x73c
// Size: 0x83
function start_func()
{
    level thread mp_sat_ob_libra_util::function_2bc2cecd260a5613( [ "hoist_interact_scene_a", "hoist_interact_scene_b" ] );
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "proc_pump_room_door" );
    thread mp_sat_ob_libra_lighting::function_430f1a03769e2382();
    thread mp_sat_ob_libra_lighting::function_2bd21e5bfd850bd0();
    thread mp_sat_ob_libra_util::function_7c6f64dfa8ae940c();
    thread namespace_eee6457f670d8545::function_2fd33a3b1faebfe0();
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "processing_alt_door", 1, 0, 1 );
    level thread mp_sat_ob_libra_util::function_32b80bf22f39a811( "processing_fan", "roll", 2, "flag_boss_intro_regroup_countdown_finished", %"electronics_fan_box_lg_01_blade" );
    level thread mp_sat_ob_libra_util::function_9886d86be8c62744();
}

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0xd39eb78, Offset: 0x7c7
// Size: 0x184
function main_func()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread setup_ui_widget();
    level thread mp_sat_ob_libra_util::cooling_pool_hurt_trigger();
    sight_blocker = getent( "sight_blocker", "targetname" );
    
    if ( isdefined( sight_blocker ) )
    {
        sight_blocker notsolid();
    }
    
    init_sphere_pos();
    mp_sat_ob_libra_util::function_4003e4e7ea24dd2b( "opening" );
    activateworldevent( "LGT_PROC_DESIGN" );
    thread starting_vo();
    function_398bc9ee922d91fd( "BossPressure", 0 );
    level thread libra_audio::function_fb418899097f8fb7();
    level.doors_stopped = 0;
    level.buttons_waiting = 0;
    level.var_487d13e59880a96a = 0;
    thread mp_sat_ob_libra_lighting::function_c13c803d33601b7( "hatch_door_a", "hatch_door_b" );
    thread handle_open_door( "pool_door_interact_a", "door_a_activate", "hatch_door_a", "cancel_door_a", "door_a_open", "pool_door_interact_a_console" );
    thread handle_open_door( "pool_door_interact_b", "door_b_activate", "hatch_door_b", "cancel_door_b", "door_b_open", "pool_door_interact_b_console" );
    utility::flag_wait_any( "door_a_activate", "door_b_activate" );
    level utility::flag_set( "started_doors" );
    thread function_5a665a9674b8ed46();
    thread mp_sat_ob_libra_vo::processing_enemies_enter();
    utility::flag_wait_any( "door_a_open", "door_b_open" );
    wait 2;
    mp_sat_ob_libra_vo::one_side_is_open();
    utility::flag_wait_all( "door_a_open", "door_b_open" );
    level thread libra_audio::function_300975db3e742073();
    wait 2;
    mp_sat_ob_libra_util::function_4003e4e7ea24dd2b( "opening", 0 );
    mp_sat_ob_libra_util::function_4003e4e7ea24dd2b( "opened", 0 );
    mp_sat_ob_libra_vo::processing_doors_done();
}

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0xb2ccd9e2, Offset: 0x953
// Size: 0xe6
function function_5a665a9674b8ed46()
{
    utility::flag_wait_any_timeout( 7, "door_a_activate", "door_b_activate" );
    
    if ( utility::flag( "door_a_activate" ) || utility::flag( "door_b_activate" ) )
    {
        wait randomfloatrange( 2, 4 );
    }
    
    thread function_800542f4a97236a();
    thread libra_audio::function_71b8a97ce2054d2d();
    requestid = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_processing_wave1", 1, 1, 1, 1 );
    function_ef57f478f96b050c( requestid, 1 );
    var_8bda1922db495b = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_processing_wave1b_large_squad", 1, 1, 1, 1 );
    function_ef57f478f96b050c( var_8bda1922db495b, 1 );
    level thread libra_audio::function_e5927efd9f56b920();
    wait 15;
    function_42319057a16481e( requestid );
    requestid = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_processing_wave1b", 1, 1, 1, 1 );
    function_ef57f478f96b050c( requestid, 1 );
    utility::flag_wait_all( "door_a_open", "door_b_open" );
    function_42319057a16481e( requestid );
    function_42319057a16481e( var_8bda1922db495b );
}

// Namespace namespace_23a5805143aa7eed
// Params 6
// Checksum 0xd00e1f95, Offset: 0xa41
// Size: 0x2d3
function handle_open_door( var_dc6a4b4b351da087, start_flag, doorname, var_d67f4e21ff0a661b, finished_flag, console_model_name )
{
    if ( !isdefined( level.var_1f6deb184845f55b ) )
    {
        level.var_1f6deb184845f55b = 0;
    }
    
    level.buttons_waiting++;
    var_190f59357d8260f7 = getent( console_model_name, "targetname" );
    level thread ob_story_mission_utils::function_56960723e6738b6c( undefined, var_dc6a4b4b351da087, undefined, var_dc6a4b4b351da087 + "_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( start_flag, var_dc6a4b4b351da087 );
    mp_sat_ob_libra_util::function_c58a10af89e58f3f( var_dc6a4b4b351da087, start_flag, &"sat_ob_story_missions/interact_open" );
    var_45186bee171d12fa = 30;
    time_left = var_45186bee171d12fa;
    door = getent( doorname, "targetname" );
    moveto_target = utility::getstruct( door.target, "targetname" );
    door.moveto_pos = moveto_target.origin;
    utility::flag_wait( start_flag );
    level.buttons_waiting--;
    level.var_487d13e59880a96a++;
    var_190f59357d8260f7 mp_sat_ob_libra_util::function_bd1845bf5896dd1b( var_190f59357d8260f7, "opening", "sat_libra_electronics_server_console_standing_01b" );
    utility::delaythread( 0.5, &mp_sat_ob_libra_util::function_4003e4e7ea24dd2b, "opening", 0 );
    utility::delaythread( 1, &mp_sat_ob_libra_util::function_4003e4e7ea24dd2b, "opened" );
    
    if ( level.var_487d13e59880a96a >= 4 )
    {
        level notify( #"end_door_nags" );
    }
    
    start_time = gettime();
    
    if ( level.players.size > 1 )
    {
        if ( isdefined( door.time_left ) )
        {
            time_left = door.time_left;
        }
        else
        {
            thread interrupt_door( var_dc6a4b4b351da087, start_flag, doorname, var_d67f4e21ff0a661b, finished_flag, var_190f59357d8260f7 );
        }
    }
    
    level thread libra_audio::function_17b69484dae782e8( var_dc6a4b4b351da087, var_d67f4e21ff0a661b, finished_flag, time_left, door );
    level.var_1f6deb184845f55b++;
    door moveto( door.moveto_pos, time_left, 5, 5 );
    utility::flag_wait_or_timeout( var_d67f4e21ff0a661b, time_left );
    level.var_1f6deb184845f55b--;
    
    if ( !utility::flag( var_d67f4e21ff0a661b ) )
    {
        utility::flag_set( finished_flag );
        var_190f59357d8260f7 mp_sat_ob_libra_util::function_bd1845bf5896dd1b( var_190f59357d8260f7, "opened", "sat_libra_electronics_server_console_standing_01b" );
        wait 0.1;
        
        if ( !( utility::flag( "door_a_open" ) && utility::flag( "door_b_open" ) ) )
        {
            mp_sat_ob_libra_util::function_4003e4e7ea24dd2b( "opened", 0 );
            wait 0.1;
            mp_sat_ob_libra_util::function_4003e4e7ea24dd2b( "opening" );
        }
        
        return;
    }
    
    door moveto( door.origin, 0.1, 0, 0 );
    cur_time = gettime();
    door.time_left = time_left - utility::function_6f5d2e1f1ff70482( cur_time - start_time );
}

// Namespace namespace_23a5805143aa7eed
// Params 6
// Checksum 0xb6bc82ba, Offset: 0xd1c
// Size: 0xba
function interrupt_door( var_dc6a4b4b351da087, start_flag, doorname, var_d67f4e21ff0a661b, finished_flag, var_190f59357d8260f7 )
{
    wait 15;
    level.doors_stopped++;
    mp_sat_ob_libra_util::function_bd1845bf5896dd1b( var_190f59357d8260f7, "closed", "sat_libra_electronics_server_console_standing_01b" );
    thread function_157680e34901a68f();
    console_pos = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    level thread libra_audio::function_88dfdf8869b920e9( var_dc6a4b4b351da087 );
    utility::flag_set( var_d67f4e21ff0a661b );
    utility::flag_clear( start_flag );
    wait 1;
    utility::flag_clear( var_d67f4e21ff0a661b );
    thread handle_open_door( var_dc6a4b4b351da087, start_flag, doorname, var_d67f4e21ff0a661b, finished_flag, var_190f59357d8260f7.targetname );
}

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0x2c856b5a, Offset: 0xdde
// Size: 0x34
function init_door_pos()
{
    level.var_eb1cb96d31019392 = mp_sat_ob_libra_util::init_model_pos( "hatch_door_a", "hatch_door_a_closed_pos" );
    level.var_eb1cb96d31019392 = mp_sat_ob_libra_util::init_model_pos( "hatch_door_b", "hatch_door_b_closed_pos" );
}

// Namespace namespace_23a5805143aa7eed
// Params 1
// Checksum 0xee134123, Offset: 0xe1a
// Size: 0xd8
function init_sphere_pos( var_22f0e5ca4db3f3a9 = "sphere_down_pos" )
{
    pipe = getent( "cradle_sphere_pipe", "targetname" );
    ball = getent( "cradle_sphere", "targetname" );
    clip = getent( "biosphere_clip", "targetname" );
    
    if ( isdefined( pipe ) && isdefined( ball ) )
    {
        pipe linkto( ball );
    }
    
    if ( isdefined( clip ) && isdefined( ball ) )
    {
        clip linkto( ball );
    }
    
    level.cradle_sphere = mp_sat_ob_libra_util::init_model_pos( "cradle_sphere", var_22f0e5ca4db3f3a9 );
    ball thread scene::play( [ ball ], "init", "scene_sat_cin_libra_cradle_meltdown" );
    level notify( #"hash_50d3f1c15e4e5198", "no_problem" );
    ball thread libra_audio::function_c0661bf35792b445( ball, 860 );
}

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0x5496c9, Offset: 0xefa
// Size: 0x4a
function starting_vo()
{
    mp_sat_ob_libra_vo::karma_door_hatch_intro();
    wait 1;
    thread door_open_nags();
    mp_sat_ob_libra_vo::set_up_a_perimeter();
    wait 3;
    mp_sat_ob_libra_vo::last_chance_walk_away();
    wait 3;
    level notify( #"hash_dec17fd9229a137a" );
    wait 15;
    mp_sat_ob_libra_vo::just_walk_away();
    wait 15;
    mp_sat_ob_libra_vo::doesnt_have_to_end_like_this();
}

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0x85aaedc3, Offset: 0xf4c
// Size: 0x1a5
function door_open_nags()
{
    level endon( #"end_door_nags" );
    level waittill( #"hash_dec17fd9229a137a" );
    general_nags = [ "get_the_hatch_open", "someone_get_the_hatch_open", "open_the_hatch", "open_the_hatch_nag_1", "open_the_hatch_nag_2" ];
    var_38c4380195f53dca = [ "one_side_needs_attention", "one_side_stopped" ];
    var_d37c4ddc139685a8 = [ "both_sides_stopped", "get_both_opening" ];
    nag_num = 0;
    var_53913eb7191f7436 = 0;
    var_53913db7191f7203 = 0;
    nag_wait = 6;
    var_9ac2a9920107bedc = 18;
    
    while ( !( utility::flag( "door_a_open" ) || utility::flag( "door_b_open" ) ) )
    {
        if ( level.buttons_waiting > 0 )
        {
            wait nag_wait;
            
            if ( level.buttons_waiting > 0 )
            {
                if ( level.doors_stopped == 2 && level.buttons_waiting == 2 )
                {
                    nag = var_d37c4ddc139685a8[ var_53913db7191f7203 ];
                    var_53913db7191f7203++;
                    
                    if ( var_53913db7191f7203 >= var_d37c4ddc139685a8.size )
                    {
                        var_53913db7191f7203 = 0;
                    }
                }
                else if ( level.doors_stopped >= 1 )
                {
                    nag = var_38c4380195f53dca[ var_53913eb7191f7436 ];
                    var_53913eb7191f7436++;
                    
                    if ( var_53913eb7191f7436 >= var_38c4380195f53dca.size )
                    {
                        var_53913eb7191f7436 = 0;
                    }
                }
                else
                {
                    nag = general_nags[ nag_num ];
                    nag_num++;
                    
                    if ( nag_num >= general_nags.size )
                    {
                        nag_num = 0;
                    }
                }
                
                overlord::function_be2d6dc71f97faa6( nag );
                nag_wait *= 2;
                
                if ( nag_wait > var_9ac2a9920107bedc )
                {
                    nag_wait = var_9ac2a9920107bedc;
                }
            }
            
            continue;
        }
        
        nag_wait = 6;
        wait 1;
    }
}

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0xb7d30551, Offset: 0x10f9
// Size: 0x33
function function_157680e34901a68f()
{
    doors_stopped = level.doors_stopped;
    wait 1;
    
    if ( doors_stopped == 1 )
    {
        mp_sat_ob_libra_vo::function_d01c999544f8769b();
        return;
    }
    
    mp_sat_ob_libra_vo::function_d01c9a9544f878ce();
}

// Namespace namespace_23a5805143aa7eed
// Params 0
// Checksum 0x1a3c951d, Offset: 0x1134
// Size: 0x5b
function function_800542f4a97236a()
{
    var_4e150d63f7211cdc = utility::getstruct( "door_explosion_org", "targetname" );
    utility::exploder( "processing_door_explo" );
    var_4e150d63f7211cdc thread libra_audio::function_3e6395b6451a1a8d();
    mp_sat_ob_libra_util::function_bf06941991e5f14( var_4e150d63f7211cdc.origin, "artillery_rumble_heavy", "large" );
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "processing_main_door" );
}

