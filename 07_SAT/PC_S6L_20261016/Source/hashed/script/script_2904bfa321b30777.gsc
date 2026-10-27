// script_2904bfa321b30777  (hash_2904bfa321b30777.gscc) (size: 21914 Bytes / 0x559a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8623fe37 (2250505783)
// size ...... 21914 (0x559a)
// includes .. 24  (offset: 0x4f06)
// strings ... 110 (offset: 0x4fc6)
// dev strs .. 0   (offset: 0x559a)
// exports ... 48  (offset: 0x3226)
// cseg ...... 0xc2b + 0x25fb (0x3226)
// imports ... 177 (offset: 0x39a6)
// animtree1 . 0   (offset: 0x559a)
// animtree2 . 0   (offset: 0x559a)
#using script_3edd59d0d3fc3262;
#using script_55b30772fa27258;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\hud_util;
#using scripts\common\save;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_42924d1fcc6ad94f;

/#

    // Namespace namespace_42924d1fcc6ad94f
    // Params 0
    // Checksum 0x853d611, Offset: 0xc49
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_42924d1fcc6ad94f
// Params 0, eflags: 0x5
// Checksum 0xc1cb84d5, Offset: 0xc56
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_955a9eae445038a6", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0, eflags: 0x4
// Checksum 0x6bc7bbba, Offset: 0xc7f
// Size: 0x67
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_ESCAPE_1";
    activity_common::registeractivitytype( "OB_LIBRA_ESCAPE_1", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_ESCAPE_1", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_ESCAPE_1", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_ESCAPE_1", 3, &function_d4acef179eb9f9b2 );
    level.var_7229e74abf36c408 = &function_116ed14568087311;
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x4e48089c, Offset: 0xcee
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x199c527a, Offset: 0xd53
// Size: 0x460
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance setup_ui_widget();
    activity_instance thread function_ed344c08f4a3e7a7();
    level utility::flag_wait( "flag_escape_done" );
    
    if ( ob::nightmare() )
    {
        struct = utility::getstruct( "mech_center", "targetname" );
        level thread mp_sat_ob_libra_util::nightmare_transition_stream( struct.origin );
        ffs = utility::getstructarray( "boss_ff_base", "targetname" );
        level thread namespace_4759598db99787a0::init_boss_ffs();
    }
    
    namespace_b451b5202140ccde::completed( level.players );
    wait 0.5;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", undefined, undefined, undefined, undefined, undefined, 1 );
    level utility::flag_set( "flag_escape_done_fade_out" );
    
    foreach ( player in level.players )
    {
        player hud_util::function_be7e0db0a4ea532( 1 );
        player thread coop::player_fade_with_shader( 1, 2, "white" );
    }
    
    wait 2;
    level utility::flag_set( "flag_escape_really_done" );
    level notify( #"hash_866273063a45342c" );
    
    if ( ob::nightmare() )
    {
        waypoint_objective_handler::waypoint_objective_handler_cancel( "escape_swim" );
        ob_story_mission_utils::function_f20a9fe6c594f5b3( 0 );
        
        foreach ( player in level.players )
        {
            player thread hud_util::fade_in( 1.5, "white" );
            player utility::callsharedfunc( #"hash_561b73e89e879cb7", #"hash_3fa3c8cca94e4308", "libra" );
        }
        
        struct = utility::getstruct( "mech_center", "targetname" );
        ob_story_mission_utils::function_e1f7ae6f70c4b0c1( struct.origin, struct.angles, undefined, "OB_LIBRA_BOSS_1" );
    }
    
    options = spawnstruct();
    options.timeout = 99;
    options.countdown = 0;
    options.fadestartshader = "white";
    options.fadestartnone = 1;
    options.fadestarthold = 2;
    options.fadeendshader = "black";
    coop::play_cinematic( "sat_libra_outro", options );
    options = spawnstruct();
    options.timeout = 17;
    options.countdown = 0;
    options.fadestartshader = "black";
    options.fadestartnone = 1;
    options.fadeendshader = "black";
    options.fadeenddelay = 10;
    coop::play_cinematic( "sat_end_rotate", options );
    
    foreach ( player in level.players )
    {
        player val::reset( "libra_escape", "deathShieldThreshold" );
    }
    
    setdvar( @"hash_2a4f08bc79265550", 0 );
    story_contract_util::mark_complete( level.players, #"libra_complete" );
    story_contract_util::mark_complete( level.players, #"avalon_freeroam" );
    story_contract_util::achievement_activities( level.players, "sat_wc_mission10and11", [ #"taurus_cradle_vents", #"libra_complete" ] );
    coop::achievement_simple( "sat_wc_completecampaign" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x95644dee, Offset: 0x11bb
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x9274a87c, Offset: 0x11df
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_ESCAPE_1" );
}

/#

    // Namespace namespace_42924d1fcc6ad94f
    // Params 0
    // Checksum 0x4fe97201, Offset: 0x11f5
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xf3e8265, Offset: 0x1202
// Size: 0x18
function start()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x4ce5d53e, Offset: 0x1222
// Size: 0x323
function function_ed344c08f4a3e7a7()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_escape" );
    case_struct = utility::getstruct( "ability_struct_escape", "targetname" );
    
    if ( isdefined( case_struct ) )
    {
        thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_mega_jump", "super_grappling_hook_sm", #"tactical" );
    }
    
    activateworldevent( "VFX_Libra_Escape_Ambient" );
    level thread mp_sat_ob_libra_util::handle_alarms( "escape_alarms", "flag_escape_done" );
    level utility::flag_wait( "story_mission_party_check_complete" );
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", undefined, undefined, undefined, undefined, undefined, 1 );
    level.ob_laststand_revive = 1;
    level.var_49dba571eb2cc910 = 1;
    level thread escape_respawn_point_trigger_setup();
    level thread escape_kill_trigger();
    thread escape_encounters();
    level thread function_486393efd31d11ac();
    level thread mp_sat_ob_libra_util::setup_robotic_modules( "escape_robotic_module", "flag_escape_done" );
    activity_name = "OB_LIBRA_ESCAPE_1";
    level thread mp_sat_ob_libra_vo::escape_intro();
    level thread mp_sat_ob_libra_vo::function_1055913c2de99997();
    level thread mp_sat_ob_libra_util::function_d2bb8bdd5246e2ca( "flag_escape_done" );
    level thread mp_sat_ob_libra_vo::escape_taking_on_water();
    level thread mp_sat_ob_libra_vo::escape_under_water();
    level thread catwalk_gauntlet_groundref_monitor();
    thread escape_swim();
    level thread mp_sat_ob_libra_util::function_666afe336bbc23e3( "escape_ambient_moment_trigger" );
    level thread mp_sat_ob_libra_util::function_7beb2eae4a2ffc52( "escape_looping_ambient_structs" );
    a_spawn_points = getspawnarray( "mp_ob_spawn_start" );
    level.a_s_start = [];
    
    foreach ( spawn_point in a_spawn_points )
    {
        if ( spawn_point.script_noteworthy == activity_name )
        {
            level.a_s_start[ level.a_s_start.size ] = spawn_point;
        }
    }
    
    level.a_s_start = arrayrandomize( level.a_s_start );
    
    foreach ( player in level.players )
    {
        player val::set( "libra_escape", "deathShieldThreshold", 3 );
        player skydive_setdeploymentstatus( 0 );
        player skydive_autodeployoff();
        player thread player_health_monitor();
    }
    
    utility::exploder( "escape_looping_cradle_gas_01" );
    utility::exploder( "escape_cargo_sub_lights" );
    utility::exploder( "escape_grappling_hook_crate" );
    utility::exploder( "door_water_pressure" );
    level thread function_9eae82faa8bb8391();
    level thread escape_cradle_lift_movers();
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "escape_objective_org", undefined, "escape_objective_org_done", undefined, undefined, 1 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_escape_gauntlet_solo_door_burst", "escape_objective_org" );
    escape_gauntlet_catwalk_setup();
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x702d51d1, Offset: 0x154d
// Size: 0x58
function function_9eae82faa8bb8391()
{
    while ( true )
    {
        utility::trigger_off( "intermittent_cradle_gas_triggers", #targetname );
        utility::stop_exploder( "intermittent_cradle_gas" );
        wait 3;
        utility::trigger_on( "intermittent_cradle_gas_triggers", #targetname );
        utility::exploder( "intermittent_cradle_gas" );
        wait 3;
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0, eflags: 0x4
// Checksum 0x7de7aad1, Offset: 0x15ad
// Size: 0x21
function private facility_intro_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    setup_ui_widget();
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x9a274811, Offset: 0x15d6
// Size: 0x34
function escape_cradle_lift_movers()
{
    escape_cradle_lift_movers = getentarray( "escape_cradle_lift_mover", #targetname );
    
    if ( isdefined( escape_cradle_lift_movers ) )
    {
        utility::array_thread( escape_cradle_lift_movers, &function_ea535d648c90de5d );
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x2e3524a4, Offset: 0x1612
// Size: 0x20d
function function_ea535d648c90de5d()
{
    if ( isdefined( self.target ) )
    {
        if ( isdefined( self.script_linkto ) )
        {
            self.linked_ents = utility::get_linked_ents();
            
            if ( isdefined( self.linked_ents ) )
            {
                if ( isarray( self.linked_ents ) )
                {
                    foreach ( ent in self.linked_ents )
                    {
                        if ( isdefined( ent ) )
                        {
                            ent linkto( self );
                            ent.var_c8692c885ac9b10d = self;
                        }
                    }
                }
                else if ( isdefined( ent ) )
                {
                    ent linkto( self );
                    ent.var_c8692c885ac9b10d = self;
                }
            }
        }
        
        start_struct = utility::getstruct( self.target );
        
        if ( isdefined( start_struct.target ) )
        {
            var_fe41cd39c047e1b9 = utility::getstruct( start_struct.target );
        }
        
        if ( isdefined( start_struct.script_delay ) )
        {
            wait start_struct.script_delay;
        }
        
        while ( true )
        {
            self moveto( var_fe41cd39c047e1b9.origin, var_fe41cd39c047e1b9.script_duration, 0, 0 );
            playsoundatpos( var_fe41cd39c047e1b9.origin, "tmp_libra_boss_escape_platforms_move" );
            self waittill( #"movedone" );
            
            if ( isdefined( var_fe41cd39c047e1b9.script_wait ) )
            {
                wait var_fe41cd39c047e1b9.script_wait;
            }
            
            self moveto( start_struct.origin, start_struct.script_duration, 0, 0 );
            playsoundatpos( start_struct.origin, "tmp_libra_boss_escape_platforms_move" );
            self waittill( #"movedone" );
            
            if ( isdefined( start_struct.script_wait ) )
            {
                wait start_struct.script_wait;
            }
        }
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x4568e3c0, Offset: 0x1827
// Size: 0xcf
function escape_gauntlet_catwalk_setup()
{
    level.escape_gauntlet_catwalks = getentarray( "escape_gauntlet_catwalk", #targetname );
    
    if ( isdefined( level.escape_gauntlet_catwalks ) )
    {
        foreach ( var_aff571583f20e7db in level.escape_gauntlet_catwalks )
        {
            var_aff571583f20e7db escape_gauntlet_catwalk();
        }
        
        utility::flag_set( "flag_escape_gauntlet_catwalks_ready" );
        level thread escape_gauntlet_catwalk_01();
        level thread escape_gauntlet_catwalk_03();
        level thread escape_gauntlet_door_burst_01();
        level thread escape_gauntlet_catwalk_06();
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xbbd609ef, Offset: 0x18fe
// Size: 0xd1
function escape_gauntlet_catwalk()
{
    if ( isdefined( self.script_linkto ) )
    {
        var_c8692c885ac9b10d = utility::get_linked_ent();
        
        if ( isdefined( var_c8692c885ac9b10d ) )
        {
            self linkto( var_c8692c885ac9b10d );
            var_c8692c885ac9b10d.var_c8692c885ac9b10d = self;
        }
    }
    
    var_2625efdafde82b32 = getentarray( self.target, #targetname );
    
    if ( isdefined( var_2625efdafde82b32 ) )
    {
        foreach ( ent in var_2625efdafde82b32 )
        {
            ent linkto( self );
        }
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x11ebf39d, Offset: 0x19d7
// Size: 0x140
function escape_gauntlet_catwalk_01()
{
    var_aff571583f20e7db = getent( "escape_gauntlet_catwalk_01", #script_noteworthy );
    
    if ( isdefined( var_aff571583f20e7db ) )
    {
        utility::flag_wait( "flag_escape_gauntlet_catwalk_01" );
        shakeduration = 0.75;
        var_39bbe706cd34d2ec = 0.25;
        var_39deeb06cd5b2370 = 0.15;
        var_39def506cd5b396e = 0.08;
        radiusscalemax = 200;
        radiusscalemid = 400;
        radiusscalemin = 600;
        mp_sat_ob_libra_util::libra_shake( var_aff571583f20e7db.origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin );
        utility::exploder( "escape_gauntlet_catwalk_01" );
        var_aff571583f20e7db thread libra_audio::function_9efda6347b7516e6( ( -1952, 14093, 3414 ) );
        wait 0.3;
        var_aff571583f20e7db rotateby( ( 2, 0, 8 ), 0.1 );
        var_aff571583f20e7db waittill( #"rotatedone" );
        
        if ( isdefined( var_aff571583f20e7db.var_c8692c885ac9b10d ) )
        {
            var_aff571583f20e7db.var_c8692c885ac9b10d unlink();
            var_aff571583f20e7db.var_c8692c885ac9b10d rotateby( ( 2, 0, 6 ), 0.1 );
        }
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x62947256, Offset: 0x1b1f
// Size: 0x189
function escape_gauntlet_catwalk_03()
{
    catwalk_03 = getent( "escape_gauntlet_catwalk_03", #script_noteworthy );
    catwalk_04 = getent( "escape_gauntlet_catwalk_04", #script_noteworthy );
    catwalk_05 = getent( "escape_gauntlet_catwalk_05", #script_noteworthy );
    
    if ( isdefined( catwalk_03 ) )
    {
        utility::flag_wait( "flag_escape_gauntlet_catwalk_03" );
        shakeduration = 0.75;
        var_39bbe706cd34d2ec = 0.25;
        var_39deeb06cd5b2370 = 0.15;
        var_39def506cd5b396e = 0.08;
        radiusscalemax = 200;
        radiusscalemid = 400;
        radiusscalemin = 600;
        mp_sat_ob_libra_util::libra_shake( catwalk_03.origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin );
        utility::exploder( "escape_gauntlet_catwalk_03" );
        catwalk_03 thread libra_audio::function_9efda6347b7516e6( ( -1986, 13726, 3415 ) );
        wait 0.3;
        catwalk_03 rotateby( ( 4, 0, 18 ), 0.1 );
        catwalk_04 movez( -3000, 2, 0.5 );
        catwalk_04 rotateto( ( 10, 2, 4 ), 2, 0.5 );
        catwalk_05 rotateby( ( 2, 0, -15 ), 0.1 );
        catwalk_04 waittill( #"movedone" );
        catwalk_04 delete();
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x5f432ee0, Offset: 0x1cb0
// Size: 0x128
function escape_gauntlet_door_burst_01()
{
    var_13237222c7fee14c = getent( "escape_gauntlet_door_burst_01", #targetname );
    
    if ( isdefined( var_13237222c7fee14c ) )
    {
        utility::flag_wait( "flag_escape_gauntlet_door_burst_01" );
        
        if ( ob::nightmare() )
        {
            level thread ob_story_mission_utils::function_ecbb860d6714e9f3( 0, 1, 0.25 );
        }
        
        shakeduration = 0.75;
        var_39bbe706cd34d2ec = 0.25;
        var_39deeb06cd5b2370 = 0.15;
        var_39def506cd5b396e = 0.08;
        radiusscalemax = 200;
        radiusscalemid = 400;
        radiusscalemin = 600;
        mp_sat_ob_libra_util::libra_shake( var_13237222c7fee14c.origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin );
        utility::exploder( "escape_gauntlet_door_burst_01" );
        playsoundatpos( var_13237222c7fee14c.origin, "tmp_libra_boss_escape_door_burst_water" );
        var_13237222c7fee14c rotateyaw( -100, 0.2, 0.2 );
        trigger = getent( "escape_gauntlet_door_burst_trigger_01", #targetname );
        
        if ( isdefined( trigger ) )
        {
            trigger thread function_3b74ef7f9985a472();
        }
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x5d32208e, Offset: 0x1de0
// Size: 0x1f2
function escape_gauntlet_catwalk_06()
{
    catwalk_06 = getent( "escape_gauntlet_catwalk_06", #script_noteworthy );
    catwalk_07 = getent( "escape_gauntlet_catwalk_07", #script_noteworthy );
    catwalk_08 = getent( "escape_gauntlet_catwalk_08", #script_noteworthy );
    
    if ( isdefined( catwalk_06 ) )
    {
        utility::flag_wait( "flag_escape_gauntlet_catwalk_06" );
        shakeduration = 0.75;
        var_39bbe706cd34d2ec = 0.25;
        var_39deeb06cd5b2370 = 0.15;
        var_39def506cd5b396e = 0.08;
        radiusscalemax = 200;
        radiusscalemid = 400;
        radiusscalemin = 600;
        mp_sat_ob_libra_util::libra_shake( catwalk_06.origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin );
        mp_sat_ob_libra_util::libra_shake( catwalk_08.origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin );
        utility::exploder( "escape_gauntlet_catwalk_06" );
        utility::exploder( "escape_gauntlet_catwalk_07" );
        catwalk_06 thread libra_audio::function_9efda6347b7516e6( ( -1978, 13213, 3447 ) );
        wait 0.1;
        catwalk_08 rotateby( ( 6, 0, 20 ), 0.1 );
        catwalk_06 rotateby( ( 2, 0, -26 ), 0.1 );
        catwalk_06 waittill( #"rotatedone" );
        utility::flag_wait( "flag_escape_gauntlet_catwalk_07" );
        catwalk_07.var_6942397b429845b8 = catwalk_07 getlinkedparent();
        catwalk_07 unlink();
        mp_sat_ob_libra_util::libra_shake( catwalk_07.origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin );
        utility::exploder( "escape_gauntlet_catwalk_07" );
        wait 0.1;
        catwalk_07 rotateby( ( 4, 0, -10 ), 0.1 );
        catwalk_07 waittill( #"rotatedone" );
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xf35305c8, Offset: 0x1fda
// Size: 0x9a
function function_3b74ef7f9985a472()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self.push_origin = utility::getstruct( self.target );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && isalive( ent ) && !isdefined( ent.being_pushed ) && !ent isskydiving() )
        {
            thread function_b1be32512384c2cf( ent );
            ent playsoundtoplayer( "tmp_libra_boss_escape_water_hit_plr", ent );
        }
        
        waitframe();
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 1
// Checksum 0xe090fe77, Offset: 0x207c
// Size: 0xbe
function function_b1be32512384c2cf( ent )
{
    self endon( #"death" );
    ent endon( #"death" );
    
    while ( isdefined( ent ) && ent istouching( self ) )
    {
        ent.being_pushed = 1;
        v_forward = vectornormalize( ent.origin - self.push_origin.origin ) * 20;
        ent pushplayervector( v_forward, 1 );
        ent setwatersheeting( 1, 1 );
        wait 0.5;
    }
    
    ent pushplayervector( ( 0, 0, 0 ) );
    ent setwatersheeting( 0 );
    ent.being_pushed = undefined;
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x61ac53f, Offset: 0x2142
// Size: 0x64
function escape_kill_trigger()
{
    level endon( #"stop_escape_kill_trigger" );
    escape_kill_trigger = getent( "escape_kill_trigger", #targetname );
    
    if ( isdefined( escape_kill_trigger ) )
    {
        while ( true )
        {
            escape_kill_trigger waittill( #"trigger", player );
            
            if ( isalive( player ) )
            {
                player thread player_teleport();
            }
        }
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xcec929d9, Offset: 0x21ae
// Size: 0x170
function player_teleport()
{
    self notify( #"hash_f0af94965f81a893" );
    self endon( #"hash_f0af94965f81a893" );
    self endon( #"death_or_disconnect" );
    player = self;
    
    if ( isdefined( player.ground_ref_ent ) )
    {
        player playersetgroundreferenceent( undefined );
        player.ground_ref_ent delete();
    }
    
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", undefined, undefined, player, undefined, undefined, 1 );
    player.health = player.maxhealth;
    player notify( #"healed" );
    weapons = player getweaponslistprimaries();
    
    foreach ( weapon in weapons )
    {
        player givemaxammo( weapon );
        player setweaponammoclip( weapon, weaponclipsize( weapon ) );
    }
    
    if ( isdefined( player.escape_respawn_point ) )
    {
        coop::teleport_player( player, player.escape_respawn_point, 1 );
    }
    else
    {
        coop::teleport_player( player, utility::array_random( level.a_s_start ), 1 );
    }
    
    player playsoundtoplayer( "evt_libra_boss_escape_plr_reset", player );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xb5d606f4, Offset: 0x2326
// Size: 0x38
function player_health_monitor()
{
    level endon( #"stop_escape_kill_trigger" );
    self.disabletakecoverwarning = 1;
    
    while ( true )
    {
        if ( self.health < 5 )
        {
            thread player_teleport();
        }
        
        waitframe();
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x36decf73, Offset: 0x2366
// Size: 0x2d
function function_486393efd31d11ac()
{
    escape_hull_tube_link_positions = utility::getstructarray( "escape_hull_tube_link_pos" );
    
    if ( isdefined( escape_hull_tube_link_positions ) )
    {
        utility::array_thread( escape_hull_tube_link_positions, &function_dd7a69b000e863e5 );
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x7289bf4e, Offset: 0x239b
// Size: 0x1c0
function function_dd7a69b000e863e5()
{
    level endon( #"flag_escape_really_done" );
    level endon( #"hash_5e03b2ab1dff65c5" );
    linker = utility::spawn_tag_origin();
    linker dontinterpolate();
    linker.linked_ents = getentarray( self.target, #targetname );
    
    if ( isdefined( linker.linked_ents ) )
    {
        foreach ( ent in linker.linked_ents )
        {
            ent linkto( linker );
            ent thread libra_audio::function_ab96b19a993a95db( ent );
            
            if ( ent.model == "sat_libra_capsule_hull_shipwrecked_01" )
            {
                ent thread function_65906908ffa106f5( "tag_ring_1_light_fx_", 6 );
                continue;
            }
            
            if ( ent.model == "sat_libra_capsule_hull_shipwrecked_02" )
            {
                ent thread function_65906908ffa106f5( "tag_ring_2_light_fx_", 7 );
            }
        }
        
        if ( isdefined( self.script_parameters ) )
        {
            switch ( self.script_parameters )
            {
                case #"hash_c9b3133a17a3b2d0":
                    rotation = -360;
                    break;
                case #"hash_96815ce4f2a3dbc5":
                    rotation = 360;
                    break;
                default:
                    rotation = 360;
                    break;
            }
        }
        
        while ( true )
        {
            linker rotateroll( rotation, self.script_speed * 4 );
            linker waittill( #"rotatedone" );
        }
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 2
// Checksum 0x763fbc7, Offset: 0x2563
// Size: 0x75
function function_65906908ffa106f5( tag_prefix, num_tags )
{
    fx_played = 0;
    
    for ( i = 1; i <= num_tags ; i++ )
    {
        tag = tag_prefix + i;
        
        if ( self tagexists( tag ) )
        {
            playfxontag( utility::getfx( "escape_ring_window_light" ), self, tag );
            fx_played++;
            
            if ( fx_played == 4 )
            {
                waitframe();
                fx_played = 0;
            }
        }
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x23e9f54c, Offset: 0x25e0
// Size: 0x2c
function escape_encounters()
{
    thread function_83e610ced020d47d();
    thread encounter_libra_escape_01();
    thread encounter_libra_escape_02();
    thread encounter_libra_escape_03();
    thread encounter_libra_escape_04();
    thread encounter_libra_escape_05();
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x30fd9dbc, Offset: 0x2614
// Size: 0x30
function function_83e610ced020d47d()
{
    ai_spawn_director::array_spawn_function_noteworthy( "escape_enemies", &function_1d434f2135fa5895 );
    wait 3;
    escape_enemies_01 = ai_spawn_director::array_spawn_targetname( "escape_enemies_00" );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xa9c2c45d, Offset: 0x264c
// Size: 0x26
function encounter_libra_escape_01()
{
    level utility::flag_wait( "flag_spawn_encounter_libra_escape_01" );
    escape_enemies_01 = ai_spawn_director::array_spawn_targetname( "escape_enemies_01" );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xa9c2c45d, Offset: 0x267a
// Size: 0x26
function encounter_libra_escape_02()
{
    level utility::flag_wait( "flag_spawn_encounter_libra_escape_02" );
    escape_enemies_02 = ai_spawn_director::array_spawn_targetname( "escape_enemies_02" );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xa9c2c45d, Offset: 0x26a8
// Size: 0x26
function encounter_libra_escape_03()
{
    level utility::flag_wait( "flag_spawn_encounter_libra_escape_03" );
    escape_enemies_03 = ai_spawn_director::array_spawn_targetname( "escape_enemies_03" );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xa9c2c45d, Offset: 0x26d6
// Size: 0x26
function encounter_libra_escape_04()
{
    level utility::flag_wait( "flag_spawn_encounter_libra_escape_04" );
    escape_enemies_04 = ai_spawn_director::array_spawn_targetname( "escape_enemies_04" );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xa9c2c45d, Offset: 0x2704
// Size: 0x26
function encounter_libra_escape_05()
{
    level utility::flag_wait( "flag_spawn_encounter_libra_escape_05" );
    escape_enemies_05 = ai_spawn_director::array_spawn_targetname( "escape_enemies_05" );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xfa59396d, Offset: 0x2732
// Size: 0x30
function function_1d434f2135fa5895()
{
    self.health = int( self.health * 0.25 );
    self.maxhealth = self.health;
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x18503c59, Offset: 0x276a
// Size: 0xd1
function catwalk_gauntlet_groundref_monitor()
{
    level endon( #"stop_catwalk_gauntlet_groundref_monitor" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player.sessionstate != "playing" )
            {
                continue;
            }
            
            if ( isdefined( player.var_a5f59fcd482d9c3c ) )
            {
                continue;
            }
            
            player thread function_a5f59fcd482d9c3c( "stop_catwalk_gauntlet_groundref_monitor", "flag_player_in_escape_catwalk_gauntlet" );
            player.var_a5f59fcd482d9c3c = 1;
        }
        
        waitframe();
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 2
// Checksum 0x8e6128f6, Offset: 0x2843
// Size: 0x10d
function function_a5f59fcd482d9c3c( ender, entflag )
{
    self endon( #"death_or_disconnect" );
    level endon( ender );
    ground_ref_ent_start_time = 2;
    ground_ref_ent_reset_time = 1;
    new_angles = ( -20, 0, 0 );
    
    while ( true )
    {
        utility::ent_flag_wait( entflag );
        
        if ( !isdefined( self.ground_ref_ent ) )
        {
            self.ground_ref_ent = utility::function_1808878d1c511ce8( self.origin, ( 0, 0, 0 ) );
            self.ground_ref_ent dontinterpolate();
            self playersetgroundreferenceent( self.ground_ref_ent );
        }
        
        if ( self.ground_ref_ent )
        {
            self.ground_ref_ent rotateto( new_angles, ground_ref_ent_start_time );
        }
        
        utility::ent_flag_waitopen_any( entflag );
        
        if ( self.ground_ref_ent )
        {
            self.ground_ref_ent rotateto( ( 0, 0, 0 ), ground_ref_ent_reset_time );
        }
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x47c1ffb6, Offset: 0x2958
// Size: 0x3e2
function escape_swim()
{
    function_f3a6772c8b060a41( 0 );
    level utility::flag_wait( "flag_escape_gauntlet_solo_door_burst" );
    water_entrance_door_sfx = utility::getstruct( "water_entrance_door_sfx" );
    
    if ( isdefined( water_entrance_door_sfx ) )
    {
        playsoundatpos( water_entrance_door_sfx.origin, "tmp_libra_boss_escape_door_burst_water" );
    }
    
    utility::exploder( "escape_gauntlet_exit_door_burst_01" );
    utility::exploder( "water_door_bubbles_vfx" );
    utility::stop_exploder( "door_water_pressure" );
    level thread mp_sat_ob_libra_util::function_4f33c858a708f9d4( "escape_swim_sphere", 1, 4, 5, 10 );
    level thread mp_sat_ob_libra_util::function_3404036aa1432445( "water_entrance_door" );
    level thread setup_floating_bodies();
    level thread function_2ba34e628213b8e5();
    
    foreach ( player in level.players )
    {
        if ( ( player.model ?? "" ) != "" && modelhastag( player.model, "tag_origin" ) )
        {
            playfxontagforclients( utility::getfx( "vfx_sat_levels_mp_ob_libra_vistaroom_bubbles_surfacebursts_ch_3" ), player, "tag_origin", player );
        }
        
        player earthquakeforplayer( 0.4, 0.75, player.origin, 200 );
        player playrumbleonpositionforclient( "damage_heavy", player.origin );
    }
    
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", undefined, undefined, undefined, undefined, undefined, 1 );
    wait 0.4;
    fadetime = 0.3;
    
    foreach ( player in level.players )
    {
        player hud_util::function_be7e0db0a4ea532( 1 );
        player thread hud_util::fade_out( fadetime, "black" );
    }
    
    wait fadetime + 0.05;
    deactivateworldevent( "VFX_Libra_Escape_Ambient" );
    activateworldevent( "VFX_Libra_Escape_Swimming_Ambient" );
    setdvar( @"hash_2a4f08bc79265550", 1 );
    level notify( #"hash_866273063a45342c" );
    level notify( #"stop_escape_kill_trigger" );
    level notify( #"stop_catwalk_gauntlet_groundref_monitor" );
    level thread mp_sat_ob_libra_util::function_7beb2eae4a2ffc52( "escape_looping_ambient_structs_underwater" );
    escape_swim_player_starts = utility::getstructarray( "escape_swim_player_starts" );
    
    foreach ( player in level.players )
    {
        player thread player_teleport_underwater( escape_swim_player_starts );
    }
    
    wait 0.1;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", undefined, undefined, undefined, undefined, undefined, 1 );
    fadetime = 0.5;
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_in( fadetime, "black" );
    }
    
    wait fadetime;
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "escape_swim", undefined, "escape_swim_breadcrumb_done", undefined, undefined, 0, 0 );
    level utility::flag_set( "flag_escape_under_water" );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 1
// Checksum 0x7ce080cf, Offset: 0x2d42
// Size: 0x7b
function player_teleport_underwater( starts )
{
    val::set( "player_swim_values", "death", 0 );
    self.health = self.maxhealth;
    self notify( #"healed" );
    thread function_d84af59b53611dcd();
    
    if ( isdefined( self.ground_ref_ent ) )
    {
        self playersetgroundreferenceent( undefined );
        self.ground_ref_ent delete();
    }
    
    level thread coop::teleport_player( self, starts[ self.sessionuimemberindex ], 1 );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xf6ada5a6, Offset: 0x2dc5
// Size: 0x45
function setup_floating_bodies()
{
    scene_root = utility::getstruct( "tag_align_escape_tornado" );
    
    if ( isdefined( scene_root ) )
    {
        scene_root thread scene::play( undefined, undefined, "scene_sat_cin_libra_escape_hal" );
        level utility::flag_wait( "flag_escape_really_done" );
        scene_root thread scene::stop();
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x277e089f, Offset: 0x2e12
// Size: 0xb4
function function_d84af59b53611dcd()
{
    self endon( #"death_or_disconnect" );
    var_a61491b0a32e905f = 1;
    endvalue = 2;
    duration = 20000;
    wait 2;
    starttime = gettime();
    endtime = starttime + duration;
    
    while ( gettime() < endtime )
    {
        currenttime = gettime();
        t = ( currenttime - starttime ) / duration;
        currentvalue = var_a61491b0a32e905f + t * ( endvalue - var_a61491b0a32e905f );
        self setswimspeedscale( currentvalue );
        wait 0.1;
    }
    
    self setswimspeedscale( endvalue );
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x2941c2ee, Offset: 0x2ece
// Size: 0x64
function function_2ba34e628213b8e5()
{
    analysis_water_entrance_door = getent( "analysis_water_entrance_door", #script_noteworthy );
    
    if ( isdefined( analysis_water_entrance_door ) )
    {
        analysis_water_entrance_door thread function_b12b8c2fbdfa6c5b( "analysis_water_entrance_door_bubbles" );
    }
    
    analysis_water_exit_door = getent( "analysis_water_exit_door", #script_noteworthy );
    
    if ( isdefined( analysis_water_exit_door ) )
    {
        analysis_water_exit_door thread function_b12b8c2fbdfa6c5b( "analysis_water_exit_door_bubbles" );
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 1
// Checksum 0x647467, Offset: 0x2f3a
// Size: 0x77
function function_b12b8c2fbdfa6c5b( explodername )
{
    trigger = self;
    
    if ( isdefined( trigger ) )
    {
        trigger endon( #"death" );
        
        while ( true )
        {
            wait randomfloatrange( 0.1, 1 );
            trigger scriptable_door_utility::function_ebbc2714ba8e6bd9( "opening" );
            utility::exploder( explodername );
            wait randomfloatrange( 0.1, 1 );
            trigger scriptable_door_utility::function_ebbc2714ba8e6bd9( "closing" );
        }
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x3bee9af4, Offset: 0x2fb9
// Size: 0x3b
function escape_respawn_point_trigger_setup()
{
    level.escape_respawn_point_triggers = getentarray( "escape_respawn_point_trigger", "targetname" );
    
    if ( isdefined( level.escape_respawn_point_triggers ) )
    {
        utility::array_thread( level.escape_respawn_point_triggers, &escape_respawn_point_trigger_monitor );
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0xb9f72217, Offset: 0x2ffc
// Size: 0x56
function escape_respawn_point_trigger_monitor()
{
    level endon( #"hash_866273063a45342c" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", triggerer );
        triggerer.escape_respawn_point = utility::getstruct( self.target );
    }
}

// Namespace namespace_42924d1fcc6ad94f
// Params 0
// Checksum 0x326ff858, Offset: 0x305a
// Size: 0x1cc
function function_116ed14568087311()
{
    dmzslots = [ 103, 101, 102, 100 ];
    
    foreach ( player in level.players )
    {
        hasStartedAvalonFreeroam = player getplayerdata( level.var_6f9b00680ed002d8, "hasStartedAvalonFreeroam" );
        
        if ( !hasStartedAvalonFreeroam )
        {
            squad = teams::function_72b89edf6b47c40a( player );
            
            if ( !isdefined( squad ) )
            {
                continue;
            }
            
            missiondata = save::mission_get_data();
            worldsquad = missiondata.squads[ squad.index ];
            var_b19d8caf59cb31b6 = worldsquad.var_cb57883a946fccc8[ player.guid ];
            
            if ( var_b19d8caf59cb31b6 >= 0 && var_b19d8caf59cb31b6 < dmzslots.size )
            {
                dmzActiveOperatorSlot = dmzslots[ var_b19d8caf59cb31b6 ];
                player setplayerdata( level.var_6f9b00680ed002d8, "dmzActiveOperatorSlot", dmzActiveOperatorSlot );
            }
        }
    }
    
    waitframe();
    
    foreach ( player in level.players )
    {
        player function_432458e83a394206( 3 );
    }
}

