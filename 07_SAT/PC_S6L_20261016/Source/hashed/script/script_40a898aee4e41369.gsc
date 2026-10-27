// script_40a898aee4e41369  (hash_40a898aee4e41369.gscc) (size: 16051 Bytes / 0x3eb3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1272681b (309487643)
// size ...... 16051 (0x3eb3)
// includes .. 15  (offset: 0x399f)
// strings ... 70  (offset: 0x3a17)
// dev strs .. 11  (offset: 0x3e2f)
// exports ... 36  (offset: 0x266b)
// cseg ...... 0x6b2 + 0x1fb9 (0x266b)
// imports ... 106 (offset: 0x2c0b)
// animtree1 . 0   (offset: 0x3eb3)
// animtree2 . 0   (offset: 0x3eb3)
#using script_16ea1b94f0f381b3;
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using scripts\asm\asm;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\snd\snd;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\supers\drone_launcher;
#using scripts\mp\gameobjects;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\systems\ob_flying_drone;

#namespace ob_nm_escort;

// Namespace ob_nm_escort
// Params 4
// Checksum 0x99d90d9c, Offset: 0x6d0
// Size: 0x1b0
function escort_event( var_dc6a4b4b351da087, encounter_name, var_fcb964ac6f23a112, objective_asset )
{
    utility::add_fx( "escort_beam", "vfx_sat_saw_avalon_cradle_warp_portal_sky_beam" );
    utility::add_fx( "escort_zone", "vfx_sat_zm_weapons_fireworks_fire_wheel_yellow" );
    utility::add_fx( "laser_spawn_vfx", "vfx_sat_levels_wc_cradle_site_laser" );
    utility::add_fx( "blast_vfx", "vfx_sat_levels_wc_cradle_site_clean_blast" );
    utility::add_fx( "smoke_portal", "vfx_sat_levels_mp_odysseus_cradle_smoke_portal" );
    nm_escort_beam = utility::getstruct( "nm_escort_beam", "targetname" );
    self.var_9be376218db54aba = "sat_ob_objectivemarker_location";
    obj_id = ob_story_mission_utils::function_804834359f20ef5a( level.escortai, 128 );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    level utility::flag_clear( "flag_nm_escort_event_done" );
    ob_nm_mode::start_of_round_fanfare( undefined, "nm_escort_start" );
    
    if ( isdefined( var_fcb964ac6f23a112 ) )
    {
        var_fcb964ac6f23a112 = utility::getstruct( var_fcb964ac6f23a112, "targetname" );
    }
    
    level utility::flag_clear( "nightmare_encouter_done" );
    obj = objective_asset ?? %"hash_3bf31e4ce3a428b6";
    ob_story_mission_utils::objective_text_show( obj );
    time_modifier = ob_nm_mode::function_3fc7f1f10018b737( 300 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread ob_nm_mode::wave_fail_timer( time_modifier );
    thread function_c598cb04a5da89af();
    function_2c482267b16ce5ad( var_dc6a4b4b351da087 );
    ob_story_mission_utils::mission_objective_marker_clear( obj_id );
    level notify( #"stop_escort" );
    level notify( #"cleanup_minions" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    level notify( #"hash_aefc5c470125baf8" );
    ob_nm_mode::end_of_round_fanfare( undefined, "nm_escort_end" );
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x4ce6b334, Offset: 0x888
// Size: 0x351
function function_c598cb04a5da89af()
{
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    level.enemy_count_array = [ 10, 14, 18, 22 ];
    level.cadence_override = 2.5;
    thread ob_nm_mode::minion_encounter( "la_nm_activity", "flag_escort_enemy_01_done", 0, 3, 1 );
    nm_escort_intro = ai_spawn_director::array_spawn_targetname( "nm_escort_intro" );
    
    foreach ( guy in nm_escort_intro )
    {
        guy thread function_5909d91a1830cee8();
    }
    
    level utility::flag_wait( "flag_escort_enemy_02_start" );
    
    /#
        iprintlnbold( "<dev string:x42>" );
    #/
    
    level thread function_6991acc112533fa5();
    level thread function_4fa2c2679bc03149();
    scene_broken_freeway_jets = utility::getstruct( "scene_broken_freeway_jets", "targetname" );
    scene_broken_freeway_jets thread ob_virgo_util::function_29164af2d4d89658();
    scene_broken_freeway_jets.var_98aee7f719b7f32d = 0;
    scene_broken_freeway_jets scene::add_spawn_function( &function_3385df57cd5c04f4 );
    scene_broken_freeway_jets thread scene::play();
    level.nightmare_minions = utility::array_removedead_or_dying( level.nightmare_minions );
    level thread function_bfc51189e2811e1d( level.nightmare_minions, "minion_vol_02" );
    nm_escort_mid_ambush = ai_spawn_director::array_spawn_targetname( "nm_escort_mid_ambush" );
    
    foreach ( guy in nm_escort_mid_ambush )
    {
        guy thread function_a2d70819db1065e8();
    }
    
    level.enemy_count_array = [ 10, 14, 18, 22 ];
    level.cadence_override = 2.5;
    level.activity_instance thread ob_nm_mode::minion_encounter( "la_nm_activity_02", "flag_escort_enemy_02_done" );
    level utility::flag_wait( "flag_escort_enemy_03_start" );
    
    /#
        iprintlnbold( "<dev string:x57>" );
    #/
    
    nm_escort_end_enemies = ai_spawn_director::array_spawn_targetname( "nm_escort_end_enemies" );
    
    foreach ( guy in nm_escort_end_enemies )
    {
        guy thread function_6b03d005e3cd900e();
    }
    
    level.nightmare_minions = utility::array_removedead_or_dying( level.nightmare_minions );
    level thread function_bfc51189e2811e1d( level.nightmare_minions, "minion_vol_03" );
    level.enemy_count_array = [ 10, 14, 18, 22 ];
    level.cadence_override = 2.5;
    level.activity_instance thread ob_nm_mode::minion_encounter( "la_nm_activity_03", "flag_escort_enemy_03_done" );
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x81b4d62e, Offset: 0xbe1
// Size: 0xec
function function_4fa2c2679bc03149()
{
    level utility::flag_wait( "flag_spawn_escort_titan" );
    scene_nm_jugger = utility::getstruct( "scene_nm_jugger", "targetname" );
    ai_juggernaut = mp_agent::spawnnewagentaitype( "sat_ob_enemy_hvt_jugg_minigun", scene_nm_jugger.origin, scene_nm_jugger.angles, "team_hundred_ninety" );
    ai_juggernaut.animname = "heavy_ai";
    scene_nm_jugger thread scene::play( ai_juggernaut );
    ai_juggernaut thread function_a1f8b5c15b9ea9f5();
    jugger_vol = getnoentvolumearray( "jugger_vol", #targetname )[ 0 ];
    ai_juggernaut setgoalvolumeauto( jugger_vol );
    scene_crashsite_jets = utility::getstruct( "scene_crashsite_jets", "targetname" );
    scene_crashsite_jets thread ob_virgo_util::function_29164af2d4d89658();
    scene_crashsite_jets.var_98aee7f719b7f32d = 0;
    scene_crashsite_jets scene::add_spawn_function( &function_3385df57cd5c04f4 );
    scene_crashsite_jets thread scene::play();
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0xd1f08c90, Offset: 0xcd5
// Size: 0x8f
function function_6991acc112533fa5()
{
    if ( level.players.size > 2 )
    {
        level utility::flag_wait( "flag_escort_enemy_02_done" );
        scene_nm_jugger = utility::getstruct( "scene_nm_jugger_0", "targetname" );
        ai_juggernaut = mp_agent::spawnnewagentaitype( "sat_ob_enemy_hvt_jugg_minigun", scene_nm_jugger.origin, scene_nm_jugger.angles, "team_hundred_ninety" );
        ai_juggernaut.animname = "heavy_ai";
        scene_nm_jugger thread scene::play( ai_juggernaut );
        ai_juggernaut thread function_a1f8b5c15b9ea9f5();
    }
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x9d2a8e64, Offset: 0xd6c
// Size: 0xa1
function function_3385df57cd5c04f4()
{
    if ( !isdefined( self.sceneobjectdata.sceneroot ) )
    {
        return;
    }
    
    scene_root = self.sceneobjectdata.sceneroot;
    alias = undefined;
    scene_root.var_98aee7f719b7f32d = ( scene_root.var_98aee7f719b7f32d ?? 0 ) + 1;
    alias = scene_root.var_98aee7f719b7f32d == 1 ? "evt_parkour_jet_flyby_01" : "evt_parkour_jet_flyby_02";
    
    if ( isdefined( alias ) )
    {
        snd::play( [ 2.3, alias ], self );
    }
}

// Namespace ob_nm_escort
// Params 2
// Checksum 0xd759b8eb, Offset: 0xe15
// Size: 0xb6
function function_bfc51189e2811e1d( guys, vol )
{
    guys = utility::array_removedead_or_dying( guys );
    goalvolume = getnoentvolumearray( vol, #targetname )[ 0 ];
    
    foreach ( guy in guys )
    {
        if ( isalive( guy ) )
        {
            guy thread ob_virgo_util::function_c04c50d8c93df4d3( goalvolume );
        }
    }
}

// Namespace ob_nm_escort
// Params 1
// Checksum 0xc5051c49, Offset: 0xed3
// Size: 0x3e
function function_58d0c2af286e443f( vol )
{
    self endon( #"death" );
    goalvolume = getnoentvolumearray( vol, #targetname )[ 0 ];
    thread ob_virgo_util::function_c04c50d8c93df4d3( goalvolume );
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0xe7e95ef0, Offset: 0xf19
// Size: 0x3f
function function_6b03d005e3cd900e()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_nm_escort_event_done" );
    playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
    agent_utils::despawnagent();
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x3b6c7646, Offset: 0xf60
// Size: 0x67
function function_a1f8b5c15b9ea9f5()
{
    self endon( #"death" );
    minion_vol_03 = getnoentvolumearray( "minion_vol_03", #targetname )[ 0 ];
    self setgoalvolumeauto( minion_vol_03 );
    level utility::flag_wait( "flag_nm_escort_event_done" );
    playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
    agent_utils::despawnagent();
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x1aefb109, Offset: 0xfcf
// Size: 0xc9
function function_5909d91a1830cee8()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_escort_fallback_intro" );
    
    /#
        iprintlnbold( "<dev string:x6c>" );
    #/
    
    minion_vol_02 = getnoentvolumearray( "minion_vol_02", #targetname )[ 0 ];
    thread function_58d0c2af286e443f( "minion_vol_02" );
    level utility::flag_wait( "flag_escort_enemy_02_done" );
    
    /#
        iprintlnbold( "<dev string:x8c>" );
    #/
    
    minion_vol_03 = getnoentvolumearray( "minion_vol_03", #targetname )[ 0 ];
    thread function_58d0c2af286e443f( "minion_vol_03" );
    level utility::flag_wait( "flag_nm_escort_event_done" );
    playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
    agent_utils::despawnagent();
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0xc9b73fbf, Offset: 0x10a0
// Size: 0x81
function function_a2d70819db1065e8()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_escort_enemy_02_start" );
    
    /#
        iprintlnbold( "<dev string:xac>" );
    #/
    
    minion_vol_03 = getnoentvolumearray( "minion_vol_03", #targetname )[ 0 ];
    self setgoalvolumeauto( minion_vol_03 );
    level utility::flag_wait( "flag_nm_escort_event_done" );
    playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
    agent_utils::despawnagent();
}

// Namespace ob_nm_escort
// Params 1
// Checksum 0xe1dfa5b1, Offset: 0x1129
// Size: 0x9d
function escort_zone_beam( struct )
{
    offset = ( 0, 0, -40 );
    angle = ( -90, 0, 0 );
    tag_origin = utility::function_1808878d1c511ce8( struct.origin + offset );
    playfxontag( level._effect[ "escort_beam" ], tag_origin, "tag_origin" );
    level utility::flag_wait( "flag_nm_escort_event_done" );
    stopfxontag( level._effect[ "escort_beam" ], tag_origin, "tag_origin" );
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x783352dc, Offset: 0x11ce
// Size: 0x33
function end_escort()
{
    wait 2;
    level utility::flag_set( "flag_nm_escort_event_done" );
    level.var_bd2748e149a8024b ob_story_mission_utils::function_315d79883d962ba7( 100, 100 );
    level utility::flag_set( "flag_escort_complete" );
}

// Namespace ob_nm_escort
// Params 1
// Checksum 0xbd9d3511, Offset: 0x1209
// Size: 0x312
function spawn_escort_robot( delay = 5 )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    level.var_287047003668e438 = getvehiclenode( "nm_freeway_escort_start", "targetname" );
    escortai = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( "sat_juggerbot_ob_boss_nm", level.var_287047003668e438.origin, level.var_287047003668e438.angles, level.players[ 0 ].team );
    escortai force_settings();
    struct = spawnstruct();
    struct.origin = utility::groundpos( level.var_287047003668e438.origin );
    struct.angles = level.var_287047003668e438.angles;
    struct thread scene::play( escortai, "drop", "scene_sat_nm_rhino_spawn" );
    playsoundatpos( struct.origin, #"hash_7d193990335be69c" );
    escortai.var_4fb7740c7ac5d31d = 0;
    level.escortai = escortai;
    escortai hudoutlineenable( "outline_nodepth_orange" );
    level.var_94d7dd4bbfb0a933 = escortai.health;
    level.escortai.var_b65c21b6930b6109 = 1;
    level.escortai.var_70e5107fa80844df = 2;
    level.escortai.ignoreme = 1;
    level.end_node = getvehiclenode( level.var_287047003668e438.target, "targetname" );
    level.escortai.dontmelee = 1;
    level.escortai.default_animrate = 0.5;
    level.escortai asm::function_d82cb83c9c260d49( 0.5 );
    level.escortai pushplayer( 1 );
    level.escortai setcandamage( 0 );
    level.escortai.var_55bcb1f81e429cb1 = 1;
    segment_degrees = 22.5;
    
    for ( i = 0; i < 16 ; i++ )
    {
        local_offset = anglestoforward( ( 0, segment_degrees * i, 0 ) ) * 200;
        chevron_org = coordtransform( local_offset, level.escortai.origin, level.escortai.angles );
        chevron_ang = vectortoangles( chevron_org - level.escortai.origin );
        level.escortai.zone_chevrons[ i ] = spawnscriptable( "ob_sat_capture_zone_chevron", chevron_org, chevron_ang );
        level.escortai.zone_chevrons[ i ] utility::scriptable_setparententity( level.escortai, local_offset, vectortoangles( local_offset ) );
    }
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x45254399, Offset: 0x1523
// Size: 0x85
function force_settings()
{
    self.var_24954f14e27b448d = 0;
    self.forcerunngun = 1;
    self.aggressivemode = 1;
    self.ignoresuppression = 1;
    self.set_forcedgoal = 1;
    self.turnanimsenabled = 0;
    self.var_63f1ffef1eafa4e4 = 1;
    self.meleechargedistvsplayer = 0;
    self.meleechargedist = 0;
    self.meleebashmaxdistsq = squared( 0 );
    self.dontmelee = 1;
    self.goalradius = 16;
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0xd3810d4b, Offset: 0x15b0
// Size: 0x53
function old_values()
{
    self.var_24954f14e27b448d = 1;
    self.meleechargedistvsplayer = 200;
    self.meleechargedist = 200;
    self.meleebashmaxdistsq = squared( 110 );
    self.dontmelee = 0;
    self.goalradius = 256;
    self.turnanimsenabled = 1;
}

// Namespace ob_nm_escort
// Params 1
// Checksum 0x5201140b, Offset: 0x160b
// Size: 0x7e
function function_2c482267b16ce5ad( var_dc6a4b4b351da087 )
{
    level.escortai thread escort_logic();
    dist = distance2d( level.var_287047003668e438.origin, level.end_node.origin );
    level utility::flag_set( "flag_nm_escort_event_start" );
    level.escortai function_2faf2655894567dd( dist );
    level utility::flag_set( "flag_nm_escort_event_done" );
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x530b018f, Offset: 0x1691
// Size: 0x15a
function function_69961ef34cea929()
{
    rhinoboss = self;
    rhinoboss endon( #"death" );
    var_a98cb6d17a72550d = 5000;
    var_8c33d36d010ba0f4 = rhinoboss.var_e394d1e674023dd1 ?? 0;
    
    if ( gettime() < var_8c33d36d010ba0f4 + var_a98cb6d17a72550d )
    {
        return 0;
    }
    
    var_ee7873751a1ab517 = rhinoboss drone_launcher::begin_use();
    
    if ( !var_ee7873751a1ab517 )
    {
        return 0;
    }
    
    rhinoboss function_7431584be2cab477();
    
    if ( !isdefined( rhinoboss.plantedsuperequip ) )
    {
        rhinoboss.plantedsuperequip = [];
    }
    
    launch_origin = rhinoboss.origin + ( 0, 0, 128 );
    launch_vel = anglestoforward( rhinoboss.angles ) * 64;
    launcher = magicgrenademanual( "sat_drone_launcher_ob", launch_origin, launch_vel, 0, rhinoboss );
    launcher.drone_launcher_overrides = { #callback_deploy_drone:&function_d180c93b8d32fcae };
    launcher.rhinoboss = rhinoboss;
    launcher.hackable = 0;
    launcher.var_92f27893e3e47b21 = 1;
    rhinoboss.var_e394d1e674023dd1 = gettime();
    rhinoboss.last_drone_launcher = launcher;
    rhinoboss thread function_27d2f442a943002e();
    launcher thread notify_launcher_death();
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x28bf6b8, Offset: 0x17f3
// Size: 0x1b
function notify_launcher_death()
{
    self waittill( #"death" );
    level notify( #"stop_scripted_shield" );
}

// Namespace ob_nm_escort
// Params 0, eflags: 0xc
// Checksum 0x4ab6fa37, Offset: 0x1816
// Size: 0x3e
function private function_27d2f442a943002e()
{
    self notify( #"hash_995bddf447ba3663" );
    self endon( #"hash_995bddf447ba3663" );
    rhinoboss = self;
    rhinoboss waittill( #"death" );
    rhinoboss function_7431584be2cab477();
}

// Namespace ob_nm_escort
// Params 0, eflags: 0x4
// Checksum 0xc4ebf949, Offset: 0x185c
// Size: 0x6f
function private function_7431584be2cab477()
{
    rhinoboss = self;
    
    if ( level.var_ba053330d81f6481.helper_drones && level.var_ba053330d81f6481.helper_drones.size > 0 )
    {
        level.var_ba053330d81f6481 ob_flying_drone::function_a08f109bc062fffe();
    }
    
    if ( rhinoboss.last_drone_launcher )
    {
        rhinoboss callback::callback( #"super_cancel" );
    }
}

// Namespace ob_nm_escort
// Params 4
// Checksum 0x98a38684, Offset: 0x18d3
// Size: 0x1a9
function function_d180c93b8d32fcae( spawnorigin, spawnangle, deployid, batchid )
{
    drone_launcher = self;
    launch_angle = drone_launcher.var_c27285d419af12ef ?? spawnangle[ 1 ];
    var_2501b9aef17e35f9 = anglestoforward( ( 0, launch_angle, 0 ) );
    drone_launcher.var_c27285d419af12ef = launch_angle + randomintrange( 110, 130 );
    
    if ( deployid == 2 )
    {
        drone_launcher.var_c27285d419af12ef += 60;
    }
    
    var_c6ee14e15410d5bf = var_2501b9aef17e35f9 * randomintrange( 5, 15 );
    var_6b7e0c6504666cbe = var_2501b9aef17e35f9 * randomintrange( 60, 200 );
    launch_height_offset = ( 0, 0, randomintrange( 80, 150 ) );
    var_9e4db6d9561aacc2 = spawnorigin + launch_height_offset + var_c6ee14e15410d5bf;
    var_9e4db5d9561aaa8f = spawnorigin + launch_height_offset + var_6b7e0c6504666cbe;
    dummy_target_origin = spawnorigin + anglestoforward( spawnangle ) * 100;
    
    if ( !level.var_ba053330d81f6481 )
    {
        level.var_ba053330d81f6481 = {};
    }
    
    drone_options = { #immuneteam:drone_launcher.rhinoboss.team, #activationdelay:0 };
    drone_path = [ spawnorigin, var_9e4db6d9561aacc2, var_9e4db5d9561aaa8f ];
    drone = level.var_ba053330d81f6481 ob_flying_drone::spawn_helper_drone( "shock", { #origin:dummy_target_origin }, drone_path, undefined, drone_options );
}

// Namespace ob_nm_escort
// Params 2
// Checksum 0x6e7c837b, Offset: 0x1a84
// Size: 0x1f1
function function_c62751ce9b00d732( launchorigin, var_139ce90b9e096f2c )
{
    rhinoboss = self;
    rhinoboss endon( #"death" );
    var_a98cb6d17a72550d = 5000;
    var_8c33d36d010ba0f4 = rhinoboss.var_e394d1e674023dd1 ?? 0;
    
    if ( gettime() < var_8c33d36d010ba0f4 + var_a98cb6d17a72550d )
    {
        return 0;
    }
    
    if ( rhinoboss.drone_launcher_drones && rhinoboss.drone_launcher_drones.size > 0 )
    {
        foreach ( drone in rhinoboss.drone_launcher_drones )
        {
            if ( drone )
            {
                drone drone_launcher::detonate_drone();
            }
        }
        
        wait 0.1;
    }
    
    var_ee7873751a1ab517 = rhinoboss drone_launcher::begin_use();
    
    if ( !var_ee7873751a1ab517 )
    {
        return 0;
    }
    
    if ( !isdefined( rhinoboss.plantedsuperequip ) )
    {
        rhinoboss.plantedsuperequip = [];
    }
    
    launch_origin = launchorigin ?? rhinoboss.origin + ( 0, 0, 128 );
    launch_vel = var_139ce90b9e096f2c ?? anglestoforward( rhinoboss.angles ) * 64;
    launcher = magicgrenademanual( "sat_drone_launcher_ob", launch_origin, launch_vel, 0, rhinoboss );
    rhinoboss.var_e394d1e674023dd1 = gettime();
    launcher.drone_launcher_overrides = { #drone_inner_damage:200, #drone_outer_damage:100, #drone_model:"veh_sat_mil_air_drone_launcher_quad_razor" };
    launcher thread notify_launcher_death();
    rhinoboss thread function_220cd08431fbc90d();
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x53bddb2f, Offset: 0x1c7d
// Size: 0xbb
function function_220cd08431fbc90d()
{
    rhinoboss = self;
    rhinoboss waittill( #"death" );
    
    if ( rhinoboss.drone_launcher_drones && rhinoboss.drone_launcher_drones.size > 0 )
    {
        foreach ( drone in rhinoboss.drone_launcher_drones )
        {
            if ( drone )
            {
                drone drone_launcher::detonate_drone();
            }
        }
    }
}

// Namespace ob_nm_escort
// Params 1
// Checksum 0x16f18261, Offset: 0x1d40
// Size: 0x66
function test_stop_robot( robot )
{
    wait 10;
    
    /#
        iprintln( "<dev string:xca>" );
    #/
    
    robot setgoalpos( robot.origin, 16 );
    robot hudoutlineenable( "outline_nodepth_orange" );
    level utility::flag_set( "flag_stop_robot" );
    wait 30;
    
    /#
        iprintln( "<dev string:xd9>" );
    #/
    
    level utility::flag_clear( "flag_stop_robot" );
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0xf7cd3139, Offset: 0x1dae
// Size: 0x16c
function escort_logic()
{
    switch ( level.players.size )
    {
        case 1:
            var_9dd7ca52abe7ccf6 = 200;
            break;
        case 2:
            var_9dd7ca52abe7ccf6 = 200;
            break;
        case 3:
            var_9dd7ca52abe7ccf6 = 200;
            break;
        case 4:
            var_9dd7ca52abe7ccf6 = 200;
            break;
        default:
            var_9dd7ca52abe7ccf6 = 200;
            break;
    }
    
    trigger = spawn( "trigger_radius", self.origin, 0, var_9dd7ca52abe7ccf6, 250 );
    useobjectowner = "neutral";
    zone = gameobjects::createuseobject( useobjectowner, trigger, [], ( 0, 0, 70 ), 0, 0, 1 );
    zone gameobjects::setvisibleteam( "any" );
    zone gameobjects::pinobjiconontriggertouch();
    zone gameobjects::setusetime( 0 );
    zone.onplayerenter = &function_af81e135ffb1b37e;
    zone.onplayerexit = &function_ae39f76007065ca8;
    zone.trigger enablelinkto();
    zone.trigger linkto( self );
    zone.escortent = self;
    self.zone = zone;
    level.zone = zone;
    level.escortent = self;
    zone thread function_d7301d7c57ca016c();
}

// Namespace ob_nm_escort
// Params 1
// Checksum 0xc81b781e, Offset: 0x1f22
// Size: 0x1a
function function_af81e135ffb1b37e( player )
{
    player.in_escort_zone = 1;
}

// Namespace ob_nm_escort
// Params 1
// Checksum 0x1b4e3e1c, Offset: 0x1f44
// Size: 0x19
function function_ae39f76007065ca8( player )
{
    player.in_escort_zone = 0;
}

// Namespace ob_nm_escort
// Params 1
// Checksum 0x2d6ab81d, Offset: 0x1f65
// Size: 0x163
function function_2faf2655894567dd( dist )
{
    self endon( #"death" );
    percent = 0;
    
    while ( percent < 99 )
    {
        if ( percent > 10 )
        {
            level utility::flag_set( "flag_escort_fallback_intro" );
        }
        
        if ( percent > 30 )
        {
            level utility::flag_set( "flag_escort_enemy_01_done" );
            level utility::flag_set( "flag_escort_enemy_02_start" );
        }
        
        if ( percent > 50 )
        {
            level utility::flag_set( "flag_escort_enemy_02_done" );
        }
        
        if ( percent > 60 )
        {
            level utility::flag_set( "flag_spawn_escort_titan" );
        }
        
        if ( percent > 75 )
        {
            level utility::flag_set( "flag_escort_enemy_03_start" );
        }
        
        if ( percent > 85 )
        {
        }
        
        dist_check = distance2d( self.origin, level.end_node.origin );
        frac = dist_check / dist;
        remaining_frac = 1 - frac;
        percent = int( remaining_frac * 100 );
        percent = clamp( percent, 0, 100 );
        level.var_bd2748e149a8024b ob_story_mission_utils::function_315d79883d962ba7( percent, 100 );
        wait 1;
    }
    
    level utility::flag_set( "flag_escort_enemy_03_done" );
    level.var_bd2748e149a8024b ob_story_mission_utils::function_315d79883d962ba7( 100, 100 );
    level utility::flag_set( "flag_escort_complete" );
    self hudoutlinedisable();
    level thread toggle_chevrons( "off" );
}

// Namespace ob_nm_escort
// Params 1
// Checksum 0xe2c0849f, Offset: 0x20d0
// Size: 0xed
function function_b113243688ac85ac( var_772501ce9a0c24da = 15 )
{
    while ( isalive( self ) )
    {
        while ( self.health > level.var_94d7dd4bbfb0a933 * 0.9 )
        {
            waitframe();
        }
        
        /#
            iprintln( "<dev string:xe8>" );
        #/
        
        self hudoutlineenable( "outline_nodepth_red" );
        level utility::flag_set( "flag_stop_robot" );
        struct = spawnstruct();
        struct.origin = self.origin;
        struct.angles = self.angles;
        struct thread scene::play( self, "enter", "scene_sat_nm_rhino_stunned" );
        wait var_772501ce9a0c24da;
        struct scene::play( self, "exit", "scene_sat_nm_rhino_stunned" );
        level utility::flag_clear( "flag_stop_robot" );
        mp_agent::set_agent_health( level.var_94d7dd4bbfb0a933 );
        self hudoutlinedisable();
    }
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x1bb1f5b9, Offset: 0x21c5
// Size: 0x12d
function function_d7301d7c57ca016c()
{
    zone = self;
    zone.escortent endon( #"death" );
    level endon( #"stop_escort" );
    wait_time = 0.1;
    level.var_c3d51128c31b5490 = getent( "escort_chain_start", "targetname" );
    
    while ( true )
    {
        if ( player_escorting() )
        {
            level thread toggle_chevrons( "active" );
            
            /#
                iprintln( "<dev string:xf8>" );
            #/
            
            zone.escortent thread function_e3ae6f11e0353401();
            zone.escortent hudoutlineenable( "outline_nodepth_cyan" );
            
            while ( player_escorting() )
            {
                wait wait_time;
            }
        }
        else
        {
            level thread toggle_chevrons( "inactive" );
            
            /#
                iprintln( "<dev string:x10f>" );
            #/
            
            level notify( #"hash_fdb018a03ec479fc" );
            waitframe();
            zone.escortent setgoalpos( zone.escortent.origin, 16 );
            zone.escortent hudoutlineenable( "outline_nodepth_orange" );
            
            while ( !player_escorting() )
            {
                waitframe();
            }
        }
        
        waitframe();
    }
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x3e6811db, Offset: 0x22fa
// Size: 0x160
function function_e3ae6f11e0353401()
{
    level endon( #"hash_fdb018a03ec479fc" );
    self endon( #"death" );
    valid_escort = 1;
    
    if ( distancesquared( self.origin, level.var_c3d51128c31b5490.origin ) < squared( 128 ) )
    {
        if ( isdefined( level.var_c3d51128c31b5490.target ) )
        {
            level.var_c3d51128c31b5490 = getent( level.var_c3d51128c31b5490.target, "targetname" );
        }
    }
    
    self.goalradius = 16;
    self.default_animrate = 0.5;
    asm::function_d82cb83c9c260d49( 0.5 );
    self setgoalpos( level.var_c3d51128c31b5490.origin, 16 );
    
    while ( valid_escort )
    {
        function_d18adc4038a0be81();
        
        if ( isdefined( level.var_c3d51128c31b5490.target ) )
        {
            level.var_c3d51128c31b5490 = getent( level.var_c3d51128c31b5490.target, "targetname" );
            self setgoalpos( level.var_c3d51128c31b5490.origin, 16 );
            self.goalradius = 16;
            self.default_animrate = 0.5;
            asm::function_d82cb83c9c260d49( 0.5 );
            continue;
        }
        
        valid_escort = 0;
        waitframe();
    }
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0x2d0f8129, Offset: 0x2462
// Size: 0xa2
function function_d18adc4038a0be81()
{
    level endon( #"hash_60dec42035171c13" );
    self endon( #"goal" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( distancesquared( self.origin, level.var_c3d51128c31b5490.origin ) < squared( 64 ) )
        {
            level notify( #"hash_60dec42035171c13" );
        }
        else
        {
            self setgoalpos( level.var_c3d51128c31b5490.origin, 16 );
            self.default_animrate = 0.5;
            asm::function_d82cb83c9c260d49( 0.5 );
        }
        
        wait 0.2;
    }
}

// Namespace ob_nm_escort
// Params 0
// Checksum 0xd6051e47, Offset: 0x250c
// Size: 0x9e, Type: bool
function player_escorting()
{
    foreach ( player in level.players )
    {
        if ( isalive( player ) && isdefined( player.in_escort_zone ) && player.in_escort_zone )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_nm_escort
// Params 1
// Checksum 0x537452c8, Offset: 0x25b3
// Size: 0xb8
function toggle_chevrons( state = "inactive" )
{
    rhino = self;
    rhino endon( #"death" );
    
    foreach ( chevron in level.escortai.zone_chevrons )
    {
        chevron setscriptablepartstate( "chevron", state );
    }
}

