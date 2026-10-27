// script_22b4e9052246a77f  (hash_22b4e9052246a77f.gscc) (size: 10941 Bytes / 0x2abd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf646ffef (4131848175)
// size ...... 10941 (0x2abd)
// includes .. 18  (offset: 0x26a5)
// strings ... 56  (offset: 0x2735)
// dev strs .. 0   (offset: 0x2abd)
// exports ... 25  (offset: 0x15e5)
// cseg ...... 0x4e1 + 0x1104 (0x15e5)
// imports ... 109 (offset: 0x19cd)
// animtree1 . 0   (offset: 0x2abd)
// animtree2 . 0   (offset: 0x2abd)
#using script_187126f2318df171;
#using script_4d6ddd547bcd9399;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_lighting;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;

#namespace namespace_2c47ae483d0feb71;

/#

    // Namespace namespace_2c47ae483d0feb71
    // Params 0
    // Checksum 0xf936e42f, Offset: 0x4ff
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_2c47ae483d0feb71
// Params 0, eflags: 0x5
// Checksum 0x7688e116, Offset: 0x50c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_5b74e9c3145045ee", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_2c47ae483d0feb71
// Params 0, eflags: 0x4
// Checksum 0x222199fe, Offset: 0x535
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_PROCESSING_LIFT";
    activity_common::registeractivitytype( "OB_LIBRA_PROCESSING_LIFT", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_PROCESSING_LIFT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_PROCESSING_LIFT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_PROCESSING_LIFT", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_2c47ae483d0feb71
// Params 0
// Checksum 0x4b3d83e9, Offset: 0x596
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

// Namespace namespace_2c47ae483d0feb71
// Params 0
// Checksum 0xbb0b6511, Offset: 0x5fb
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

// Namespace namespace_2c47ae483d0feb71
// Params 0
// Checksum 0x64017fd0, Offset: 0x64a
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_2c47ae483d0feb71
// Params 0
// Checksum 0xb3812b63, Offset: 0x66e
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_PROCESSING_LIFT" );
}

/#

    // Namespace namespace_2c47ae483d0feb71
    // Params 0
    // Checksum 0xbe8c403f, Offset: 0x684
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_2c47ae483d0feb71
// Params 0
// Checksum 0xc11b87f, Offset: 0x691
// Size: 0xc2
function start_func()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    mp_sat_ob_libra_util::function_8f97ea6ececa5d();
    namespace_23a5805143aa7eed::init_sphere_pos();
    activateworldevent( "LGT_PROC_DESIGN" );
    thread mp_sat_ob_libra_lighting::function_2bd21e5bfd850bd0();
    level.cradle_sphere thread mp_sat_ob_libra_lighting::function_70a171f22b600bac();
    thread namespace_eee6457f670d8545::function_2fd33a3b1faebfe0();
    level thread function_e8b8f14b227b3c43();
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "proc_pump_room_door" );
    level thread mp_sat_ob_libra_util::function_2bc2cecd260a5613( [ "hoist_interact_scene_a", "hoist_interact_scene_b" ] );
    thread mp_sat_ob_libra_util::function_7c6f64dfa8ae940c();
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "processing_alt_door", 1, 0, 1 );
    level thread mp_sat_ob_libra_util::function_32b80bf22f39a811( "processing_fan", "roll", 2, "flag_boss_intro_regroup_countdown_finished", %"electronics_fan_box_lg_01_blade" );
    level thread mp_sat_ob_libra_util::function_9886d86be8c62744();
}

// Namespace namespace_2c47ae483d0feb71
// Params 0, eflags: 0x4
// Checksum 0x8d62a2d3, Offset: 0x75b
// Size: 0x1b
function private function_e8b8f14b227b3c43()
{
    level utility::flag_wait( "scriptables_ready" );
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "processing_main_door" );
}

// Namespace namespace_2c47ae483d0feb71
// Params 0
// Checksum 0xbe53f5bb, Offset: 0x77e
// Size: 0x4ce
function main_func()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    setup_ui_widget();
    level thread mp_sat_ob_libra_util::cooling_pool_hurt_trigger();
    mp_sat_ob_libra_util::function_4003e4e7ea24dd2b( "libra_sphere_up" );
    waitframe();
    dripfx = playfxontag( utility::getfx( "cradle_sphere_water_drips" ), level.cradle_sphere, "tag_origin" );
    function_398bc9ee922d91fd( "BossPressure", 0 );
    thread mp_sat_ob_libra_vo::processing_lift_intro();
    sight_blocker = getent( "sight_blocker", "targetname" );
    
    if ( isdefined( sight_blocker ) )
    {
        sight_blocker notsolid();
    }
    
    thread function_66808faba48e8930();
    level.raise_console = getent( "sphere_raise_console", "targetname" );
    level thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "sphere_raise_button", undefined, "sphere_raise_button_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "start_sphere_raise", "sphere_raise_button" );
    mp_sat_ob_libra_util::function_c58a10af89e58f3f( "sphere_raise_button", "start_sphere_raise", &"sat_ob_story_missions/interact_raise" );
    level thread libra_audio::function_7a23717c3f03bc75();
    level thread libra_audio::function_fb418899097f8fb7();
    utility::flag_wait( "start_sphere_raise" );
    mp_sat_ob_libra_util::function_bd1845bf5896dd1b( level.raise_console, "libra_sphere_up", "sat_libra_electronics_server_console_standing_01b" );
    utility::delaythread( 0.2, &mp_sat_ob_libra_util::function_4003e4e7ea24dd2b, "libra_sphere_up", 0 );
    utility::delaythread( 0.4, &mp_sat_ob_libra_util::function_4003e4e7ea24dd2b, "libra_sphere_down" );
    utility::delaythread( 1, &mp_sat_ob_libra_vo::raise_the_bioreactor_initial_press );
    sphere_peek_pos = utility::getstruct( "sphere_peek_pos", "targetname" );
    move_time = 10;
    level.cradle_sphere moveto( sphere_peek_pos.origin, move_time, 3, 5 );
    wait move_time;
    thread mp_sat_ob_libra_vo::raise_the_bioreactor_fakeout();
    wait 1;
    mp_sat_ob_libra_util::function_bd1845bf5896dd1b( level.raise_console, "libra_sphere_down", "sat_libra_electronics_server_console_standing_01b" );
    utility::delaythread( 0.2, &mp_sat_ob_libra_util::function_4003e4e7ea24dd2b, "libra_sphere_down", 0 );
    utility::delaythread( 0.4, &mp_sat_ob_libra_util::function_4003e4e7ea24dd2b, "sphere_locked" );
    down_pos = utility::getstruct( "sphere_down_pos", "targetname" ).origin;
    move_time = 7;
    level.cradle_sphere moveto( down_pos, move_time, 2, 3 );
    wait move_time;
    wait 1;
    mp_sat_ob_libra_util::function_bd1845bf5896dd1b( level.raise_console, "sphere_locked", "sat_libra_electronics_server_console_standing_01b" );
    utility::delaythread( 0.5, &mp_sat_ob_libra_util::function_4003e4e7ea24dd2b, "sphere_locked", 0 );
    function_d77731ed9677040();
    utility::flag_set( "lift_bottom" );
    thread function_73a0b90285cb2a94();
    waitframe();
    buttona = utility::getstruct( "hoist_interact_a", "targetname" );
    thread function_65571dd767982f65( buttona, &"sat_ob_story_missions/interact_raise", "hoist_interact_scene_a", "hoist_cable_a" );
    buttonb = utility::getstruct( "hoist_interact_b", "targetname" );
    thread function_65571dd767982f65( buttonb, &"sat_ob_story_missions/interact_raise", "hoist_interact_scene_b", "hoist_cable_b" );
    requestid = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_processing_wave2", 1, 1, 1, 1 );
    function_ef57f478f96b050c( requestid, 1 );
    activity_ai_encounters::function_d33de057e760c97b( requestid, &function_1b49618750a9d0c7 );
    var_8bda1922db495b = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_processing_wave2_large_squad", 1, 1, 1, 1 );
    function_ef57f478f96b050c( var_8bda1922db495b, 1 );
    activity_ai_encounters::function_d33de057e760c97b( var_8bda1922db495b, &function_1b49618750a9d0c7 );
    thread libra_audio::function_9b68dd8c571716b0();
    level thread libra_audio::function_84d61cc73e4c68c4();
    utility::flag_wait( "lift_complete" );
    
    foreach ( player in level.players )
    {
        str_objective_start = "hoist_interact_a";
        
        if ( isdefined( player waypoint_objective_handler::function_c2eeb9e0ffc2533d( str_objective_start ) ) )
        {
            player.waypoint_objective_state[ str_objective_start ] = 3;
            player.var_52f632411cc75d51[ str_objective_start ] = undefined;
            player notify( "cancel_waypoint_objective_handler" + str_objective_start );
        }
        
        str_objective_start = "hoist_interact_b";
        
        if ( isdefined( player waypoint_objective_handler::function_c2eeb9e0ffc2533d( str_objective_start ) ) )
        {
            player.waypoint_objective_state[ str_objective_start ] = 3;
            player.var_52f632411cc75d51[ str_objective_start ] = undefined;
            player notify( "cancel_waypoint_objective_handler" + str_objective_start );
        }
    }
    
    stopfxontag( utility::getfx( "cradle_sphere_water_drips" ), level.cradle_sphere, "tag_origin" );
    function_42319057a16481e( requestid );
    function_42319057a16481e( var_8bda1922db495b );
    level thread libra_audio::function_5d1b09ee49fe7578();
    mp_sat_ob_libra_vo::bioreactor_raised();
    utility::flag_set( "processing_last_phase" );
}

// Namespace namespace_2c47ae483d0feb71
// Params 2
// Checksum 0xad8e1590, Offset: 0xc54
// Size: 0x20
function function_1b49618750a9d0c7( requestid, userdata )
{
    return utility::flag( "lift_complete" );
}

// Namespace namespace_2c47ae483d0feb71
// Params 4
// Checksum 0x9732aa25, Offset: 0xc7d
// Size: 0x136
function function_65571dd767982f65( button, var_81916649a7b1af22, var_4e849c3ae91eb8aa, cable_name )
{
    radius = 64;
    interact = interaction::register_interact( button.origin, radius, &used_crank, var_81916649a7b1af22, undefined, undefined, undefined, "HINT_BUTTON" );
    interact.obj_root = self;
    interact.use_origin = button.origin;
    interact.use_radius = radius;
    interact.var_4e849c3ae91eb8aa = var_4e849c3ae91eb8aa;
    interact.cable_name = cable_name;
    interact.button_struct = button;
    interact sethintdisplayrange( 128 );
    interact sethintdisplayfov( 360 );
    interact setusefov( 45 );
    level thread ob_story_mission_utils::function_56960723e6738b6c( undefined, button.targetname, undefined, button.targetname + "_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    interact endon( #"crank_used" );
    utility::flag_wait( "lift_complete" );
    interact makeunusable();
}

// Namespace namespace_2c47ae483d0feb71
// Params 1
// Checksum 0x530aec34, Offset: 0xdbb
// Size: 0x315
function used_crank( player )
{
    self makeunusable();
    self notify( #"crank_used" );
    level notify( #"crank_used" );
    level thread waypoint_objective_handler::waypoint_objective_handler_cancel( self.button_struct.targetname );
    player val::set( "crank", "allow_movement", 0 );
    player val::set( "crank", "crouch", 0 );
    player val::set( "crank", "prone", 0 );
    player val::set( "crank", "melee", 0 );
    player val::set( "crank", "offhand_primary_weapons", 0 );
    player val::set( "crank", "offhand_secondary_weapons", 0 );
    player val::set( "crank", "weapon", 0 );
    player val::set( "crank", "killstreaks", 0 );
    player val::set( "crank", "ads", 0 );
    player val::set( "crank", "weapon_switch", 0 );
    player val::set( "crank", "action_slot_weapon", 0 );
    player val::set( "crank", "armor", 0 );
    player val::set( "crank", "supers", 0 );
    var_e507e20aac42b1e0 = getentarray( self.cable_name, "targetname" );
    player mp_sat_ob_libra_util::start_interact_scene( self.var_4e849c3ae91eb8aa );
    level.cranks_active++;
    var_aef62691d2e532f1 = self.obj_root interaction::register_interact( self.use_origin, self.use_radius, &stop_crank, &"sat_ob_story_missions/interact_stop" );
    var_aef62691d2e532f1.button_struct = self.button_struct;
    var_aef62691d2e532f1 thread cancel_crank( player );
    var_aef62691d2e532f1.use_origin = self.use_origin;
    var_aef62691d2e532f1.use_radius = self.use_radius;
    var_aef62691d2e532f1.obj_root = self.obj_root;
    var_aef62691d2e532f1.var_4e849c3ae91eb8aa = self.var_4e849c3ae91eb8aa;
    var_aef62691d2e532f1.cable_name = self.cable_name;
    var_aef62691d2e532f1.var_fa144882e203b671 = player;
    
    foreach ( cable in var_e507e20aac42b1e0 )
    {
        player thread function_fe9953c728ba50da( cable );
    }
    
    dead_or_dying = player::isinlaststand( player ) || !isalive( player );
    
    if ( dead_or_dying || utility::flag( "lift_complete" ) )
    {
        var_aef62691d2e532f1 thread stop_crank( player );
        return;
    }
    
    player thread function_7c8447b69a9fb37f( self.var_4e849c3ae91eb8aa, var_aef62691d2e532f1 );
}

// Namespace namespace_2c47ae483d0feb71
// Params 1
// Checksum 0x372a19b4, Offset: 0x10d8
// Size: 0x7d
function function_fe9953c728ba50da( cable )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"stop_crank" );
    dir = int( cable.script_parameters ) ?? 1;
    
    while ( true )
    {
        cable rotateyaw( dir * 90, 0.5, 0, 0 );
        wait 0.5;
    }
}

// Namespace namespace_2c47ae483d0feb71
// Params 2
// Checksum 0x650b5f5a, Offset: 0x115d
// Size: 0x60
function function_7c8447b69a9fb37f( scene_targetname, var_aef62691d2e532f1 )
{
    self endon( #"stop_crank" );
    scene_struct = utility::getstruct( scene_targetname );
    utility::waittill_any_return( "disconnect", "last_stand_enter", "death" );
    scene_struct scene::stop();
    var_aef62691d2e532f1 thread stop_crank( self, 1 );
}

// Namespace namespace_2c47ae483d0feb71
// Params 1
// Checksum 0x8b583af1, Offset: 0x11c5
// Size: 0x2d
function cancel_crank( player )
{
    self endon( #"stop_crank" );
    utility::flag_wait( "lift_complete" );
    thread stop_crank( player );
}

// Namespace namespace_2c47ae483d0feb71
// Params 2
// Checksum 0xf0da2027, Offset: 0x11fa
// Size: 0xc7
function stop_crank( player, skip_exit_anim )
{
    if ( self.var_fa144882e203b671 != player )
    {
        return;
    }
    
    self notify( #"stop_crank" );
    self makeunusable();
    level.cranks_active--;
    thread function_9b19a04248e4b106();
    
    if ( self.var_fa144882e203b671 == player )
    {
        player notify( #"stop_crank" );
        player val::reset_all( "crank" );
        player mp_sat_ob_libra_util::function_d68eec31414afe2e( self.var_4e849c3ae91eb8aa );
    }
    
    if ( !utility::flag( "lift_complete" ) )
    {
        self.obj_root function_65571dd767982f65( self.button_struct, &"sat_ob_story_missions/interact_raise", self.var_4e849c3ae91eb8aa, self.cable_name );
    }
}

// Namespace namespace_2c47ae483d0feb71
// Params 0
// Checksum 0x811caf66, Offset: 0x12c9
// Size: 0x1df
function function_73a0b90285cb2a94()
{
    var_fe3e75749881f59a = 40;
    drop_time = 120;
    thread mp_sat_ob_libra_vo::function_5f84a16cb0dd4025();
    
    if ( level.players.size == 1 )
    {
        var_fe3e75749881f59a = 20;
    }
    
    level.cranks_active = 0;
    var_2135a25a0a337ee6 = 0;
    up_pos = utility::getstruct( "sphere_raise_pos", "targetname" ).origin;
    down_pos = utility::getstruct( "sphere_down_pos", "targetname" ).origin;
    
    while ( !utility::flag( "lift_complete" ) )
    {
        if ( level.cranks_active != var_2135a25a0a337ee6 )
        {
            level notify( #"crank_change" );
            pct_done = ( level.cradle_sphere.origin[ 2 ] - down_pos[ 2 ] ) / ( up_pos[ 2 ] - down_pos[ 2 ] );
            pct_done = clamp( pct_done, 0, 1 );
            
            if ( level.cranks_active == 0 )
            {
                level notify( #"sphere_dropping" );
                move_time = drop_time * pct_done;
                var_1d016b4edfbc212a = down_pos;
                accel_time = clamp( move_time / 3, 0, 10 );
                decel_time = clamp( move_time / 3, 0, 10 );
                thread function_27ff0d2aa92a3d5( move_time );
                level thread libra_audio::function_64906a1170a7a844( move_time );
            }
            else
            {
                move_time = var_fe3e75749881f59a / level.cranks_active * ( 1 - pct_done );
                var_1d016b4edfbc212a = up_pos;
                accel_time = 0;
                decel_time = 0;
                utility::flag_clear( "lift_bottom" );
                thread finish_lift( move_time );
                level thread libra_audio::function_aa9fb818aed27570( move_time );
            }
            
            if ( move_time <= 0 )
            {
                move_time = 0.1;
            }
            
            level.cradle_sphere moveto( var_1d016b4edfbc212a, move_time, accel_time, decel_time );
            var_2135a25a0a337ee6 = level.cranks_active;
        }
        
        waitframe();
    }
}

// Namespace namespace_2c47ae483d0feb71
// Params 1
// Checksum 0x544bed77, Offset: 0x14b0
// Size: 0x33
function function_27ff0d2aa92a3d5( move_time )
{
    level notify( #"crank_change" );
    level endon( #"crank_change" );
    wait move_time;
    utility::flag_set( "lift_bottom" );
}

// Namespace namespace_2c47ae483d0feb71
// Params 1
// Checksum 0x8408eef4, Offset: 0x14eb
// Size: 0x33
function finish_lift( move_time )
{
    level notify( #"crank_change" );
    level endon( #"crank_change" );
    wait move_time;
    utility::flag_set( "lift_complete" );
}

// Namespace namespace_2c47ae483d0feb71
// Params 0
// Checksum 0xaa85a91d, Offset: 0x1526
// Size: 0x21
function function_66808faba48e8930()
{
    wait 8;
    
    while ( !utility::flag( "start_sphere_raise" ) )
    {
        mp_sat_ob_libra_vo::raise_the_bioreactor_initial_nag();
        wait 16;
    }
}

// Namespace namespace_2c47ae483d0feb71
// Params 0
// Checksum 0x4b59cb1b, Offset: 0x154f
// Size: 0x10
function function_d77731ed9677040()
{
    mp_sat_ob_libra_vo::function_53de642f3018a207();
    thread function_9b19a04248e4b106();
}

// Namespace namespace_2c47ae483d0feb71
// Params 0
// Checksum 0x5632d2ad, Offset: 0x1567
// Size: 0x7e
function function_9b19a04248e4b106()
{
    level notify( #"wheel_nags" );
    level endon( #"wheel_nags" );
    level endon( #"crank_used" );
    
    if ( level.cranks_active > 0 )
    {
        return;
    }
    
    for ( nag_wait = 6; !utility::flag( "lift_complete" ) ; nag_wait = 18 )
    {
        wait nag_wait;
        mp_sat_ob_libra_vo::bioreactor_wheel_nag( !utility::flag( "lift_bottom" ) );
        nag_wait *= 2;
        
        if ( nag_wait > 18 )
        {
        }
    }
}

