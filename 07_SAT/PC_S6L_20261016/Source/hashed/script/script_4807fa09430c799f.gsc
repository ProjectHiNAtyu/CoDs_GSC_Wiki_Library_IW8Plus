// script_4807fa09430c799f  (hash_4807fa09430c799f.gscc) (size: 28284 Bytes / 0x6e7c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x795be416 (2036065302)
// size ...... 28284 (0x6e7c)
// includes .. 26  (offset: 0x64e8)
// strings ... 136 (offset: 0x65b8)
// dev strs .. 7   (offset: 0x6e24)
// exports ... 61  (offset: 0x4418)
// cseg ...... 0xc8b + 0x378d (0x4418)
// imports ... 182 (offset: 0x4da0)
// animtree1 . 0   (offset: 0x6e7c)
// animtree2 . 0   (offset: 0x6e7c)
#using script_636bd827a012af12;
#using scripts\anim\dialogue;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\callbacks;
#using scripts\common\hints;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\common\equipment\mini_sentry;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\hud_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_audio;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;
#using scripts\mp\mp_agent_damage;

#namespace OB_VIRGO_CARRIER_INTRO;

/#

    // Namespace OB_VIRGO_CARRIER_INTRO
    // Params 0
    // Checksum 0x74695be7, Offset: 0xca9
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0, eflags: 0x5
// Checksum 0x716b4625, Offset: 0xcb6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d34509016fd605f5", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0, eflags: 0x4
// Checksum 0xf3fdaa40, Offset: 0xcdf
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_CARRIER_INTRO";
    activity_common::registeractivitytype( "OB_VIRGO_CARRIER_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_CARRIER_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_CARRIER_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_CARRIER_INTRO", 3, &function_d4acef179eb9f9b2 );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0x640d8353, Offset: 0xd40
// Size: 0x89
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance carrier_intro_start();
    }
    
    var_e04c0425c57a325 = utility::getstruct( "scene_harper_boss", "targetname" );
    var_e04c0425c57a325 zombie_boss_healthbar::function_f50a10314e72caa1();
    var_e04c0425c57a325 zombie_boss_healthbar::init_zombie_boss_healthbar();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0x17f7f58c, Offset: 0xdd1
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    /#
        level thread function_4214cab27b5e5573();
    #/
    
    activity_instance carrier_intro_main();
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0x5572a0af, Offset: 0xe16
// Size: 0x2b
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    /#
        level notify( #"hash_44942599bc2c6056" );
    #/
}

/#

    // Namespace OB_VIRGO_CARRIER_INTRO
    // Params 0
    // Checksum 0x33d3fff7, Offset: 0xe49
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0x94d034b0, Offset: 0xe56
// Size: 0x2
function carrier_intro_start()
{
    
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0xa5c790a7, Offset: 0xe60
// Size: 0xa2
function carrier_intro_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level.boss_activity = self;
    level thread ob_virgo_util::carrier_exploders();
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_carrier", undefined, 1, undefined, undefined, undefined, undefined, 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_carrier", undefined, 1, undefined, undefined, undefined, undefined, 1 );
    level thread virgo_vo::function_62378c0819bf51db();
    level thread function_f3df2664d7d1b2c2();
    thread function_487a6cc252362b1();
    level thread ob_virgo_util::supply_drop_1( "carrier_airdrop_2", "flag_virgo_harper_boss_1" );
    ob_virgo_util::setup_ui_widget( "OB_VIRGO_CARRIER_INTRO" );
    level utility::flag_wait( "flag_virgo_carrier_intro_done" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 1
// Checksum 0x19f30a80, Offset: 0xf0a
// Size: 0x5d
function function_f249fb23439c6410( pos )
{
    var_55fb688e1d94c6a7 = utility::getstruct( "struct_boss_palm_strike_right", "targetname" );
    struct_2 = utility::getstruct( "carrier_airdrop_2", "targetname" );
    return vectornormalize( var_55fb688e1d94c6a7.origin - struct_2.origin );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0x5c6d0f9d, Offset: 0xf70
// Size: 0x310
function function_f3df2664d7d1b2c2()
{
    level.bubble = getent( "harper_attack_orb", "targetname" );
    
    if ( isdefined( level.bubble ) )
    {
        level.old_spot = level.bubble.origin;
    }
    
    level.bubble_2 = getent( "harper_attack_orb_2", "targetname" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_78a1a9cabfc4d42e = 150000;
    
    /#
        if ( getdvarint( @"scr_harper_health", 0 ) )
        {
            var_78a1a9cabfc4d42e = getdvarint( @"scr_harper_health" );
        }
    #/
    
    switch ( level.players.size )
    {
        case 1:
            boss_health = var_78a1a9cabfc4d42e;
            break;
        case 2:
            boss_health = var_78a1a9cabfc4d42e * 2;
            break;
        case 3:
            boss_health = var_78a1a9cabfc4d42e * 3;
            break;
        case 4:
            boss_health = var_78a1a9cabfc4d42e * 4;
            break;
        default:
            boss_health = var_78a1a9cabfc4d42e;
            break;
    }
    
    level.stun_damage = boss_health / 30;
    level.health_struct = {};
    level.health_struct.health = boss_health;
    level.health_struct.maxhealth = boss_health;
    level thread boss_damage_listener();
    var_f7e3c6f1b4b470ac = [ "palm_slam_left", "attack_yell", "palm_slam_right", "attack_yell", "double_slam", "attack_yell" ];
    scene_struct = utility::getstruct( "scene_harper_boss", "targetname" );
    var_63b52a0bc1c0f3bf = utility::getstruct( "struct_scene_boss_intro", "targetname" );
    var_63b52a0bc1c0f3bf = utility::getstruct( "struct_scene_boss_intro", "targetname" );
    scene_struct thread setup_harper();
    scene_struct scene::play( undefined, "intro_roar" );
    level utility::flag_set( "flag_start_boss_fight" );
    scene_struct scene::set_notify_note( level, "slam_right", "Types_Prop", 1 );
    scene_struct scene::set_notify_note( level, "slam_left", "Types_Prop", 1 );
    scene_struct scene::set_notify_note( level, "deck_shake", "Types_Prop", 1 );
    scene_struct scene::set_notify_note( level, "deck_shake_long", "Types_Prop", 1 );
    level.var_bf2e669910db962c = "flag_virgo_harper_boss_1";
    level.health_threshold = level.health_struct.maxhealth * 0.666667;
    scene_struct thread function_57dded51455ae5ae( "flag_virgo_harper_boss_1", var_f7e3c6f1b4b470ac );
    level thread function_430bfb34f5c4fc82( level.health_threshold, "flag_virgo_harper_boss_1" );
    level utility::flag_wait( "flag_virgo_harper_boss_1" );
    level utility::flag_set( "flag_spawn_encounter_1" );
    scene_struct scene::play( undefined, "exit_agitated" );
    level utility::flag_wait( "flag_stop_encounter_1" );
    level utility::flag_set( "flag_virgo_carrier_intro_done" );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0xe10e6bfa, Offset: 0x1288
// Size: 0xae
function setup_harper()
{
    level notify( #"setup_harper" );
    level endon( #"setup_harper" );
    level utility::registersharedfunc( #"hellstorm_missile", #"directionoverride", &function_f249fb23439c6410, 1 );
    wait 1;
    
    if ( !isdefined( level.harper ) )
    {
        level.harper = scene::get_entity( "harper_boss" );
        level.harper thread harper_damage();
        level thread hand_overlap( "vol_hand_right", "flag_slam_on_right" );
        level thread hand_overlap( "vol_hand_left", "flag_slam_on_left" );
        level thread hand_overlap( "vol_hand_yell", "flag_yell_on_hand" );
    }
    
    level thread notetrack_listener();
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0xf4617cce, Offset: 0x133e
// Size: 0xd6
function notetrack_listener()
{
    level.boss_activity endon( #"activity_ended" );
    level.boss_activity endon( #"instance_destroyed" );
    
    while ( true )
    {
        msg = level utility::waittill_any_return( "deck_shake", "slam_right", "slam_left", "deck_shake_long" );
        
        switch ( msg )
        {
            case #"hash_671d42da5e151609":
            case #"hash_84a9418d3814303c":
                level thread rumble_players( "heavy_3s", 1 );
                break;
            case #"hash_8f3a188329fa9365":
                level thread rumble_players( "heavy_1s", 0 );
                break;
            case #"hash_d53e191467c7b608":
                level thread rumble_players( "heavy_3s", 0 );
                break;
            default:
                break;
        }
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0x98b81f46, Offset: 0x141c
// Size: 0x50
function function_487a6cc252362b1()
{
    level utility::flag_wait( "flag_spawn_encounter_1" );
    level thread virgo_audio::boss_lull_combat_walla();
    wait 6;
    level thread ob_virgo_util::function_fdd5b4c27ba17b79();
    thread function_39bad07f36de7efd( undefined, "zone_1_encounter", "flag_stop_encounter_1" );
    level utility::flag_wait_or_timeout( "flag_carrier_combat_1_done", 90 );
    level utility::flag_set( "flag_stop_encounter_1" );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0x8f08529, Offset: 0x1474
// Size: 0xde
function function_39bad07f36de7efd( flag_encounter, encounter_name, flag_to_end )
{
    if ( isdefined( flag_encounter ) )
    {
        level utility::flag_wait( flag_encounter );
    }
    
    level.carrier_enemies = [];
    encounter_targetname = encounter_name;
    request_id = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( request_id, 1 );
    ai_spawn_director::add_spawned_callback( request_id, &function_98fb3cc9551ec3b5, flag_to_end );
    activity_ai_encounters::function_6bf4ff2fbde584ee( request_id, &function_936abb667490e720, self );
    level utility::flag_wait( "flag_carrier_1_spawned" );
    struct = utility::getstruct( "struct_boss_palm_strike_left", "targetname" );
    level.boss_activity ob_virgo_util::function_3fbaca3bceae7dfb( "OB_VIRGO_CARRIER_ATTACK" );
    activity_progress_tracking::function_82d854bb84c20512( "carrier_combat_1_tracker", level.carrier_enemies, &function_986201c16cc61cac );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0x902479e6, Offset: 0x155a
// Size: 0x2b
function function_936abb667490e720( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_carrier_1_spawned" );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0xa94aab13, Offset: 0x158d
// Size: 0x70
function function_986201c16cc61cac( requestid, activity_instance, agent )
{
    level.carrier_enemies = utility::array_removedead_or_dying( level.carrier_enemies );
    
    if ( level.carrier_enemies.size < 2 )
    {
        level utility::flag_set( "flag_carrier_combat_1_done" );
    }
    
    if ( level.carrier_enemies.size < 4 )
    {
        level utility::flag_set( "flag_carrier_wave_2_retreat" );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 4
// Checksum 0x9526777f, Offset: 0x1605
// Size: 0x101
function function_98fb3cc9551ec3b5( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    agent.battlechatterallowed = 0;
    agent.var_80bfd8beda20e707 = 0;
    level.carrier_enemies[ level.carrier_enemies.size ] = agent;
    agent setmodel( "body_c_sat_usa_pl_black_horde_sp" );
    
    if ( isdefined( agent.headmodel ) )
    {
        agent detach( agent.headmodel );
    }
    
    agent attach( "head_c_sat_usa_pl_black_base_cradle" );
    agent.headmodel = "head_c_sat_usa_pl_black_base_cradle";
    agent thread function_9ee1b9a6e0f6776c();
    agent thread agent_move_up( "flag_carrier_wave_1_retreat" );
    level utility::flag_wait( userdata );
    wait randomfloatrange( 0, 0.25 );
    playfx( level._effect[ "enemy_vanish" ], agent.origin );
    agent kill();
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0xc660d5be, Offset: 0x170e
// Size: 0x139
function function_9ee1b9a6e0f6776c()
{
    agent = self;
    agent endon( #"death" );
    var_9fd703e8e079c458 = 3;
    var_9ffa19e8e0a03c72 = 25;
    lines = [];
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_whichofyouisit";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_youwontbetrayme";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_stayawayfromme";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_whosthetraitor";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_whoturnedonme";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_wontgettrickedagain";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_wontshootmeintheback";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_notgettinkilledtoday";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_illfuckinkillyou";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_dietraitor";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_iwantanswers";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_tellme";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_battlecry";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_battlecry_01";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_battlecry_02";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_ragescream";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_ragescream_01";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_ragescream_02";
    lines[ lines.size ] = "dx_wc_irgo_vcar_harp_aggressivegrowl";
    
    while ( true )
    {
        wait randomfloatrange( var_9fd703e8e079c458, var_9ffa19e8e0a03c72 );
        agent dialogue::say( utility::array_random( lines ) );
        wait randomfloatrange( var_9fd703e8e079c458, var_9ffa19e8e0a03c72 );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 4
// Checksum 0x84a67430, Offset: 0x184f
// Size: 0xe7
function function_98fb39c9551ebd1c( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    level.carrier_enemies[ level.carrier_enemies.size ] = agent;
    agent setmodel( "body_c_sat_usa_pl_black_horde_sp" );
    
    if ( isdefined( agent.headmodel ) )
    {
        agent detach( agent.headmodel );
    }
    
    agent attach( "head_c_sat_usa_pl_black_base_cradle" );
    agent.headmodel = "head_c_sat_usa_pl_black_base_cradle";
    agent thread function_9ee1b9a6e0f6776c();
    agent thread agent_move_up( "flag_carrier_wave_2_retreat" );
    level utility::flag_wait( userdata );
    wait randomfloatrange( 0, 0.25 );
    playfx( level._effect[ "enemy_vanish" ], agent.origin );
    agent kill();
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 1
// Checksum 0xe17e0a40, Offset: 0x193e
// Size: 0x4b
function agent_move_up( flag_name )
{
    self endon( #"death" );
    level utility::flag_wait( flag_name );
    vols = getnoentvolumearray( "vol_harper_wave_last", "targetname" );
    
    if ( isdefined( vols ) )
    {
        self setgoalvolumeauto( vols[ 0 ] );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0xa874e856, Offset: 0x1991
// Size: 0xde
function function_39bacd7f36de7864( flag_encounter, encounter_name, flag_to_end )
{
    if ( isdefined( flag_encounter ) )
    {
        level utility::flag_wait( flag_encounter );
    }
    
    level.carrier_enemies = [];
    encounter_targetname = encounter_name;
    request_id = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( request_id, 1 );
    ai_spawn_director::add_spawned_callback( request_id, &function_98fb39c9551ebd1c, flag_to_end );
    activity_ai_encounters::function_6bf4ff2fbde584ee( request_id, &function_91ea1434eaba86b1, self );
    level utility::flag_wait( "flag_carrier_2_spawned" );
    struct = utility::getstruct( "struct_boss_palm_strike_left", "targetname" );
    level.boss_activity ob_virgo_util::function_3fbaca3bceae7dfb( "OB_VIRGO_CARRIER_ATTACK" );
    activity_progress_tracking::function_82d854bb84c20512( "carrier_combat_2_tracker", level.carrier_enemies, &function_986204c16cc62345 );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0x902479e6, Offset: 0x1a77
// Size: 0x2b
function function_91ea1434eaba86b1( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_carrier_2_spawned" );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0xb6d78807, Offset: 0x1aaa
// Size: 0x70
function function_986204c16cc62345( requestid, activity_instance, agent )
{
    level.carrier_enemies = utility::array_removedead_or_dying( level.carrier_enemies );
    
    if ( level.carrier_enemies.size < 2 )
    {
        level utility::flag_set( "flag_carrier_combat_2_done" );
    }
    
    if ( level.carrier_enemies.size < 4 )
    {
        level utility::flag_set( "flag_carrier_wave_2_retreat" );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0xb1187548, Offset: 0x1b22
// Size: 0x332
function function_57dded51455ae5ae( stop_flag, attack_shots, var_b53142ef2a7a99cd )
{
    scene_struct = self;
    var_a7ae08291a3ce46d = 0;
    count = 0;
    
    while ( !level utility::flag( stop_flag ) )
    {
        if ( level utility::flag( "flag_stun_harper" ) )
        {
            while ( level utility::flag( "flag_stun_harper" ) )
            {
                waitframe();
            }
        }
        
        if ( level utility::flag( stop_flag ) )
        {
            break;
        }
        
        shot = attack_shots[ count % attack_shots.size ];
        count++;
        
        if ( getdvarint( @"scr_force_attack", 0 ) )
        {
            switch ( getdvarint( @"scr_force_attack", 0 ) )
            {
                case 1:
                    shot = "palm_slam_left";
                    break;
                case 2:
                    shot = "palm_slam_right";
                    break;
                case 3:
                    shot = "attack_yell";
                    break;
                case 4:
                    shot = "attack_cradle";
                    break;
                case 5:
                    shot = "double_slam";
                    break;
                case 99:
                    level waittill( #"forever" );
                    break;
                default:
                    break;
            }
        }
        
        switch ( shot )
        {
            case #"hash_3a821fde5aa0e972":
                level thread function_4b4b390738c665e2();
                level.current_attack = "palm_slam_right";
                level.current_react = "palm_slam_right_react_a";
                struct = utility::getstruct( "struct_boss_palm_strike_right", "targetname" );
                level thread slam_logic( stop_flag, struct, "slam_right", "flag_slam_on_right" );
                break;
            case #"hash_fd44069c942a9351":
                level thread function_4b4b390738c665e2();
                level.current_attack = "palm_slam_left";
                level.current_react = "palm_slam_left_react_a";
                struct = utility::getstruct( "struct_boss_palm_strike_left", "targetname" );
                level thread slam_logic( stop_flag, struct, "slam_left", "flag_slam_on_left" );
                break;
            case #"hash_264ecbb95817adf0":
                level.current_attack = "attack_yell";
                level.current_react = "attack_yell_react";
                level thread harper_attack_yell( stop_flag );
                break;
            case #"hash_59cac06d7062d56d":
                level.current_attack = "attack_cradle";
                level.current_react = "attack_cradle_react_a";
                level thread function_afd5b750141246b3( stop_flag );
                break;
            case #"hash_dbe3b110971c0664":
                level thread function_4b4b390738c665e2();
                level.current_attack = "double_slam";
                level.current_react = "palm_slam_left_react_a";
                left_struct = utility::getstruct( "struct_boss_palm_strike_left", "targetname" );
                right_struct = utility::getstruct( "struct_boss_palm_strike_right", "targetname" );
                level thread slam_logic( stop_flag, right_struct, "slam_right", "flag_slam_on_right" );
                level thread slam_logic( stop_flag, left_struct, "slam_left", "flag_slam_on_left" );
                break;
            default:
                break;
        }
        
        scene_struct scene::play( undefined, shot );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0x3db610f6, Offset: 0x1e5c
// Size: 0x99
function function_4b4b390738c665e2()
{
    foreach ( player in level.players )
    {
        player thread utility::player_prestream_assets( "virgo_carrier_intro", "model", [ "vfx_sat_wc_vgo_boss_hand_aoe_ring" ], [ 2000 ], 10 );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 2
// Checksum 0xf8c14c0a, Offset: 0x1efd
// Size: 0xd2
function function_afd5b750141246b3( stop_flag, s_side )
{
    delay_strike = 3;
    var_e48a04791aaa0280 = 1;
    bubble_window = 7;
    level thread bubble_timeout( var_e48a04791aaa0280 + bubble_window );
    level utility::flag_set( "flag_relay_hand_damage" );
    level thread boss_attack_vulnerable( stop_flag, "right_hand", var_e48a04791aaa0280, undefined, 1 );
    delay = var_e48a04791aaa0280 + bubble_window;
    wait delay;
    level notify( #"hash_c4980a0ee83ab554" );
    level utility::flag_clear( "flag_relay_hand_damage" );
    
    if ( level utility::flag( "flag_virgo_harper_boss_3" ) )
    {
        return;
    }
    
    if ( !level utility::flag( stop_flag ) && !level utility::flag( "flag_stun_harper" ) )
    {
        level thread ob_virgo_util::function_e68ea7f6b97ccd83( stop_flag );
        level thread virgo_vo::function_ae0ea9b1fbab45d2();
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 1
// Checksum 0x6e97b7f6, Offset: 0x1fd7
// Size: 0x291
function harper_attack_yell( stop_flag )
{
    var_e48a04791aaa0280 = 2;
    bubble_duration = 3;
    level thread boss_attack_vulnerable( stop_flag, "mouth", var_e48a04791aaa0280 );
    level thread function_1e614ac341444bf9( "flag_yell_on_hand", stop_flag, 5, 3 );
    wait var_e48a04791aaa0280 + bubble_duration;
    level notify( #"hash_c4980a0ee83ab554" );
    
    if ( level utility::flag( "flag_stun_harper" ) )
    {
        return;
    }
    
    if ( !level utility::flag( stop_flag ) && !level utility::flag( "flag_stun_harper" ) )
    {
        level thread virgo_vo::function_41c202a0e44c503();
    }
    
    yell_spots = utility::getstructarray( "struct_harper_yell_end", "targetname" );
    player_spots = [];
    spots_per_player = 10;
    lower_end = -192;
    upper_end = 192;
    struct = utility::getstruct( "struct_fake_agent", "targetname" );
    
    if ( !isdefined( level.wizard ) )
    {
        level.wizard = ob_virgo_util::function_2987bea0e44c9a52( struct );
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        for ( j = 0; j < spots_per_player ; j++ )
        {
            struct = spawnstruct();
            
            if ( isdefined( level.players[ i ] ) && isdefined( level.players[ i ].origin ) )
            {
                struct.origin = level.players[ i ].origin + ( randomfloatrange( lower_end, upper_end ), randomfloatrange( lower_end, upper_end ), 0 );
                player_spots[ player_spots.size ] = struct;
            }
        }
    }
    
    if ( player_spots.size )
    {
        yell_spots = player_spots;
    }
    
    shot_length = 2.1;
    wait_time = shot_length / yell_spots.size;
    num_shots = yell_spots.size;
    yell_spots = arrayrandomize( yell_spots );
    
    for ( i = 0; i < yell_spots.size ; i++ )
    {
        if ( !level utility::flag( stop_flag ) && !level utility::flag( "flag_stun_harper" ) )
        {
            start = level.harper gettagorigin( "tag_fx_mouth" );
            owner = level.wizard;
            
            if ( !isdefined( owner ) )
            {
                owner = level.players[ 0 ];
            }
            
            missile = magicbullet( "sat_la_ztron_fireball_virgo", start, yell_spots[ i ].origin, owner );
            missile thread virgo_audio::function_658f02408d1a0c7c();
            wait wait_time;
        }
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0xad0c3fab, Offset: 0x2270
// Size: 0x35e
function harper_damage()
{
    harper = self;
    level.var_501ade91cd412744 = getdvarint( @"hash_38ecac846c8aebd1", 250 );
    head_multiplier = 1.01;
    chest_multiplier = 0.7;
    arm_multiplier = 0.6;
    hand_multiplier = 0.4;
    clip_chest = getent( "harper_clip_chest", "targetname" );
    clip_chest linkto( harper, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    clip_chest thread harper_damage_piece( chest_multiplier );
    clip_head = getent( "harper_clip_head", "targetname" );
    clip_head linkto( harper, "j_head", ( 300, 0, 0 ), ( 0, 0, 0 ) );
    clip_head thread harper_damage_piece( head_multiplier );
    clip_bicep_l = getent( "harper_clip_bicep_l", "targetname" );
    clip_bicep_l linkto( harper, "j_shoulder_le", ( 500, 0, 0 ), ( 0, 0, 0 ) );
    clip_bicep_l thread harper_damage_piece( arm_multiplier );
    clip_bicep_r = getent( "harper_clip_bicep_r", "targetname" );
    clip_bicep_r linkto( harper, "j_shoulder_ri", ( 500, 0, 0 ), ( 0, 0, 0 ) );
    clip_bicep_r thread harper_damage_piece( arm_multiplier );
    clip_forearm_l = getent( "harper_clip_forearm_l", "targetname" );
    clip_forearm_l linkto( harper, "j_elbow_le", ( 500, 0, 0 ), ( 0, 0, 0 ) );
    clip_forearm_l thread harper_damage_piece( arm_multiplier );
    clip_forearm_r = getent( "harper_clip_forearm_r", "targetname" );
    clip_forearm_r linkto( harper, "j_elbow_ri", ( 500, 0, 0 ), ( 0, 0, 0 ) );
    clip_forearm_r thread harper_damage_piece( arm_multiplier );
    clip_hand_l = getent( "harper_clip_hand_l", "targetname" );
    clip_hand_l linkto( harper, "j_wrist_le", ( 300, 0, 0 ), ( 0, 0, 0 ) );
    clip_hand_l thread harper_damage_piece( hand_multiplier, 1, "left" );
    clip_hand_r = getent( "harper_clip_hand_r", "targetname" );
    clip_hand_r linkto( harper, "j_wrist_ri", ( 300, 0, 0 ), ( 0, 0, 0 ) );
    clip_hand_r thread harper_damage_piece( hand_multiplier, 1, "right" );
    clip_hip = getent( "harper_clip_hips", "targetname" );
    
    if ( isdefined( clip_hip ) )
    {
        clip_hip linkto( harper, "j_mainroot", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        clip_hip thread harper_damage_piece( chest_multiplier );
    }
    
    level.harper_objective = utility::spawn_tag_origin( harper gettagorigin( "j_head" ), ( 0, 0, 0 ) );
    level.harper_objective linkto( harper, "j_head", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0x5631c067, Offset: 0x25d6
// Size: 0x263
function harper_damage_piece( multiplier = 1, is_hand = 0, side = undefined )
{
    self setcandamage( 1 );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction, point, type, model, tag, part, idflags, objweapon );
        critcal = 0;
        
        if ( isplayer( attacker ) )
        {
            if ( level utility::flag( "flag_allow_harper_damage" ) )
            {
                damage *= 7;
                
                if ( isdefined( objweapon ) && function_ad3f7e0f31991cb8( objweapon ) )
                {
                    damage *= function_ad3f7e0f31991cb8( objweapon );
                }
                
                damage = multiplier * damage;
                damage = clamp( damage, 75, 2000 );
                
                if ( is_hand && level utility::flag( "flag_relay_hand_damage" ) )
                {
                    critical = 1;
                    
                    if ( side == "right" )
                    {
                        level.bubble notify( #"damage", damage, attacker, direction, point, type, model, tag, part, idflags, objweapon );
                    }
                    else
                    {
                        level.bubble_2 notify( #"damage", damage, attacker, direction, point, type, model, tag, part, idflags, objweapon );
                    }
                }
                
                level notify( #"harper_damaged", damage );
                level thread play_impact( "harper_impact", point, direction, damage, level.health_struct.health, level.health_threshold );
                attacker damagefeedback::updatehitmarker( 1, 0, critcal, 0, undefined, undefined, undefined, undefined, 1 );
                attacker utility::callsharedfunc( #"hud", #"hash_84d4f784de00c6af", 0, self );
                continue;
            }
            
            attacker damagefeedback::updatedamagefeedback( "hitimmune", 0, 0 );
            now = gettime();
            
            if ( !isdefined( self.var_2df28f22fff95c50 ) || now > self.var_2df28f22fff95c50 )
            {
                self.var_2df28f22fff95c50 = now + level.var_501ade91cd412744;
                mp_agent_damage::function_eb8ba16055d6da7c( attacker, self, "none", undefined, undefined, 0, undefined, 1, undefined, undefined, undefined, undefined );
            }
        }
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 1
// Checksum 0x3e5c0a98, Offset: 0x2841
// Size: 0x4c
function function_ad3f7e0f31991cb8( objweapon )
{
    if ( issubstr( getweaponbasename( objweapon ), "polis" ) )
    {
        return 5;
    }
    
    if ( issubstr( getweaponbasename( objweapon ), "fang" ) )
    {
        return 5;
    }
    
    if ( issubstr( getweaponbasename( objweapon ), "killstreak" ) )
    {
        return 8;
    }
    
    return 0;
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0x3554cc35, Offset: 0x2896
// Size: 0xe6
function cradle_attack( delay_time, duration_time = 5, stop_flag )
{
    var_e48a04791aaa0280 = 1.5;
    level thread boss_attack_vulnerable( stop_flag, "left_hand", var_e48a04791aaa0280, 50 );
    bubble_window = 6;
    level thread bubble_timeout( var_e48a04791aaa0280 + bubble_window );
    points = utility::getstructarray( "struct_harper_yell_end", "targetname" );
    circle_point = utility::array_random( points );
    total_time = delay_time + var_e48a04791aaa0280;
    
    if ( isdefined( delay_time ) )
    {
        wait total_time;
    }
    
    level notify( #"hash_c4980a0ee83ab554" );
    
    if ( level utility::flag( stop_flag ) )
    {
        return;
    }
    
    if ( level utility::flag( "flag_stun_harper" ) )
    {
        return;
    }
    
    level thread cradle_cloud( duration_time, circle_point.origin, stop_flag );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0x71143d68, Offset: 0x2984
// Size: 0x8e
function cradle_cloud( duration_time, location, stop_flag )
{
    level thread virgo_vo::function_e0b9e67ee5cf3eb6();
    gas_circle_struct = spawnstruct();
    gas_circle_struct.origin = location;
    gas_circle_struct.angles = ( 0, 0, 0 );
    circle_time = 10;
    hold_time = 1;
    level.boss_activity thread ob_virgo_util::function_374a43deed4cfbf4( location, circle_time, hold_time, stop_flag, 1024 );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 4
// Checksum 0x15ce36c2, Offset: 0x2a1a
// Size: 0x60
function slam_logic( stop_flag, struct, side, slam_flag )
{
    level waittill( side );
    level thread virgo_vo::function_24bf2574be98a7dc();
    level thread function_1e614ac341444bf9( slam_flag, stop_flag );
    
    if ( !level utility::flag( stop_flag ) )
    {
        level thread function_1f89f29043f859c9( struct.origin );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0xd4025b9f, Offset: 0x2a82
// Size: 0x3f
function slam_pop()
{
    level thread function_4b4b390738c665e2();
    wait 0.4;
    struct = utility::getstruct( "harper_point", "targetname" );
    level thread function_1f89f29043f859c9( struct.origin );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 4
// Checksum 0x4c72134a, Offset: 0x2ac9
// Size: 0x6d
function function_1e614ac341444bf9( flag_name, stop_flag, time = 3, delay = undefined )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( !level utility::flag( stop_flag ) )
    {
        level utility::flag_set( flag_name );
        level utility::flag_wait_or_timeout( stop_flag, time );
        level utility::flag_clear( flag_name );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 2
// Checksum 0xa0259440, Offset: 0x2b3e
// Size: 0xd7
function hand_overlap( var_cc7ce90ddd28aa63, flag_name )
{
    vol = getent( var_cc7ce90ddd28aa63, "targetname" );
    
    if ( !isdefined( vol ) )
    {
        return;
    }
    
    while ( true )
    {
        waitframe();
        
        if ( level utility::flag( flag_name ) )
        {
            foreach ( player in level.players )
            {
                if ( player istouching( vol ) && player::isaliveandnotinlaststand( player ) )
                {
                    level thread smash_player( player );
                }
            }
        }
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 1
// Checksum 0x6c137755, Offset: 0x2c1d
// Size: 0x74
function smash_player( player )
{
    stun_duration = 4;
    playfx( level._effect[ "enemy_vanish" ], player.origin );
    player dodamage( 100000, player.origin, player );
    player thread shellshock_utility_cpmp::_shellshock( %"sat_ob_virgo_harper_crush", #"flash", stun_duration, 1, 1500 );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 1
// Checksum 0x6ac7611d, Offset: 0x2c99
// Size: 0x2ea
function function_1f89f29043f859c9( originpoint )
{
    current_radius = 0;
    thread virgo_audio::function_930721c6d3c319f9();
    earthquake( 0.7, 0.3, originpoint, 6000 );
    playfx( level._effect[ "harper_slam" ], originpoint );
    thread virgo_audio::function_619612726bb47e08( originpoint, 6000, 1800 );
    level thread destroy_turrets( originpoint );
    
    while ( true )
    {
        max_radius = 6000;
        
        /#
            max_radius = getdvarfloat( @"hash_eb0728328b9612a0", 6000 );
        #/
        
        var_ccf9a72ba0ac0132 = 1800;
        
        /#
            var_ccf9a72ba0ac0132 = getdvarfloat( @"hash_9ae12f01fd46d8a0", 1800 );
        #/
        
        prev_radius = current_radius;
        current_radius += var_ccf9a72ba0ac0132 * level.framedurationseconds;
        
        /#
            if ( getdvarint( @"hash_82adc06924887d53", 0 ) )
            {
                cylinder( originpoint, originpoint + ( 0, 0, 10 ), current_radius, ( 1, 1, 0 ), 1, 1 );
            }
        #/
        
        player_radius = 16;
        
        /#
            player_radius = getdvarfloat( @"hash_bb65ec1ec6eb3ceb", 16 );
        #/
        
        radius_max = current_radius;
        radius_min = prev_radius;
        
        foreach ( player in level.players )
        {
            if ( player::isreallyalive( player ) && player.sessionstate == "playing" )
            {
                if ( !player function_dd48b56c28acb2e3( player_radius, originpoint, prev_radius, current_radius ) )
                {
                    continue;
                }
                
                if ( player.isstunned )
                {
                    continue;
                }
                
                if ( player is_above_shockwave( originpoint ) )
                {
                    continue;
                }
                
                if ( player isonground() )
                {
                    /#
                        if ( getdvarint( @"hash_82adc06924887d53", 0 ) )
                        {
                            cylinder( player.origin, player.origin + ( 0, 0, 2 ), player_radius, ( 1, 0, 0 ), 0, 400 );
                            var_ac26e3818b7168a8 = vectornormalize2( player.origin - originpoint );
                            var_d791d1e26b912fad = ( originpoint[ 0 ], originpoint[ 1 ], player.origin[ 2 ] );
                            var_4d5d4e179e2ae0ad = var_d791d1e26b912fad + var_ac26e3818b7168a8 * prev_radius;
                            var_3055b5bbc6767dbe = var_d791d1e26b912fad + var_ac26e3818b7168a8 * current_radius;
                            line( var_4d5d4e179e2ae0ad, var_3055b5bbc6767dbe, ( 1, 0, 0 ), 1, 0, 400 );
                        }
                    #/
                    
                    player thread function_ce258bccf32cf64b( originpoint );
                }
            }
        }
        
        if ( current_radius > max_radius )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 1
// Checksum 0x9cf0ae17, Offset: 0x2f8b
// Size: 0xa7
function destroy_turrets( originpoint )
{
    var_563c84cd7c4fb595 = getentarray( "veh_sat_mini_sentry", "targetname" );
    
    foreach ( turret in var_563c84cd7c4fb595 )
    {
        if ( turret utility::ent_flag( "mini_sentry_deployed" ) )
        {
            turret thread function_93221f8e48fc3c75( originpoint );
        }
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 1
// Checksum 0xa76c12f4, Offset: 0x303a
// Size: 0x51
function function_93221f8e48fc3c75( originpoint )
{
    self endon( #"death" );
    dist = distance( self.origin, originpoint );
    scalar_wait = 3 * dist / 6000;
    wait scalar_wait;
    thread mini_sentry::on_destruction( undefined );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 1, eflags: 0x4
// Checksum 0x6efb5a02, Offset: 0x3093
// Size: 0xd0
function private function_ce258bccf32cf64b( originpoint )
{
    player = self;
    stun_duration = 2;
    player utility::setplayerstunned();
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    if ( !ob::nightmare() )
    {
        player dodamage( 30, originpoint, player );
    }
    else
    {
        player dodamage( 50, originpoint, player );
        var_40b66f58ae925367 = player.maxarmorhealth ?? 200;
        player armor::damagearmor( var_40b66f58ae925367 );
    }
    
    player thread weapon_utility::cleanupconcussionstun( stun_duration );
    player thread shellshock_utility_cpmp::_shellshock( %"sat_ob_virgo_harper_slam", #"stun", stun_duration, 1, 1500 );
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "medium", 1, player );
    player playrumbleonentity( "damage_heavy" );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 1, eflags: 0x4
// Checksum 0xfc6a777a, Offset: 0x316b
// Size: 0x5d, Type: bool
function private is_above_shockwave( originpoint )
{
    player = self;
    
    if ( !isdefined( originpoint ) )
    {
        return false;
    }
    
    if ( !isdefined( player.origin ) )
    {
        return false;
    }
    
    z_dist = player.origin[ 2 ] - originpoint[ 2 ];
    
    if ( z_dist > 32 )
    {
        return true;
    }
    
    return false;
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 4, eflags: 0x4
// Checksum 0xeb1ab6be, Offset: 0x31d1
// Size: 0x78, Type: bool
function private function_dd48b56c28acb2e3( ent_radius, wave_center, var_ea37701f14081978, var_aa226a6b39c78a6a )
{
    ent = self;
    var_b3f50ca949e18afc = distance2d( ent.origin, wave_center );
    ent_dist_min = var_b3f50ca949e18afc - ent_radius;
    ent_dist_max = var_b3f50ca949e18afc + ent_radius;
    return !( var_aa226a6b39c78a6a < ent_dist_min || var_ea37701f14081978 > ent_dist_max );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0, eflags: 0x4
// Checksum 0x83c0502, Offset: 0x3252
// Size: 0x120
function private stun_ai()
{
    guy = self;
    guy endon( #"death" );
    
    if ( guy.maxarmorhealth > 0 )
    {
        /#
            if ( getdvarint( @"hash_82adc06924887d53", 0 ) )
            {
                debug_draw_end = gettime() + 3000;
                
                while ( gettime() < debug_draw_end )
                {
                    sphere( guy getcentroid(), 3, ( 1, 0, 0 ), 0, 1 );
                    waitframe();
                }
            }
        #/
        
        return;
    }
    
    stun_duration = randomfloatrange( 3.5, 5 );
    guy notify( #"flashbang", guy.origin, 1, undefined, undefined, undefined, stun_duration );
    playfx( level._effect[ "enemy_vanish" ], guy.origin );
    
    /#
        if ( getdvarint( @"hash_82adc06924887d53", 0 ) )
        {
            debug_draw_end = gettime() + stun_duration * 1000;
            
            while ( gettime() < debug_draw_end )
            {
                sphere( guy getcentroid(), 3, ( 0, 1, 0 ), 0, 1 );
                waitframe();
            }
        }
    #/
}

/#

    // Namespace OB_VIRGO_CARRIER_INTRO
    // Params 0
    // Checksum 0x4ab37df5, Offset: 0x337a
    // Size: 0x233, Type: dev
    function function_4214cab27b5e5573()
    {
        level endon( #"hash_44942599bc2c6056" );
        utility::flag_wait( "<dev string:x2f>" );
        setdevdvarifuninitialized( @"hash_82adc06924887d53", 0 );
        setdevdvarifuninitialized( @"hash_eb0728328b9612a0", 6000 );
        setdevdvarifuninitialized( @"hash_9ae12f01fd46d8a0", 1800 );
        setdevdvarifuninitialized( @"hash_bb65ec1ec6eb3ceb", 16 );
        var_8e273f14a460a396 = [];
        debug_draw_enabled = -1;
        
        while ( true )
        {
            if ( getdvarint( @"hash_82adc06924887d53", 0 ) != debug_draw_enabled )
            {
                debug_draw_enabled = getdvarint( @"hash_82adc06924887d53", 0 );
                
                if ( debug_draw_enabled )
                {
                    total_hud_elems = 3;
                    elem_x = -200;
                    elem_y_start = -200;
                    elem_y_delta = 15;
                    
                    for ( i = 0; i < total_hud_elems ; i++ )
                    {
                        new_hud_elem = hud_util::createhudelem( undefined, undefined, "<dev string:x4d>", undefined, elem_x, elem_y_start + elem_y_delta * i, ( 0.8, 0.8, 0.2 ), undefined, 1.5, undefined );
                        new_hud_elem.alpha = 1;
                        var_8e273f14a460a396[ var_8e273f14a460a396.size ] = new_hud_elem;
                    }
                }
                else
                {
                    foreach ( hud_elem in var_8e273f14a460a396 )
                    {
                        hud_elem hud_util::destroyelem();
                    }
                    
                    var_8e273f14a460a396 = [];
                }
            }
            
            if ( debug_draw_enabled )
            {
                max_radius_elem = var_8e273f14a460a396[ 0 ];
                max_radius_elem setdevtext( "<dev string:x54>", getdvarfloat( @"hash_eb0728328b9612a0", 6000 ) );
                speed_hud_elem = var_8e273f14a460a396[ 1 ];
                speed_hud_elem setdevtext( "<dev string:x6d>", getdvarfloat( @"hash_9ae12f01fd46d8a0", 1800 ) );
                player_radius_elem = var_8e273f14a460a396[ 2 ];
                player_radius_elem setdevtext( "<dev string:x81>", getdvarfloat( @"hash_bb65ec1ec6eb3ceb", 16 ) );
            }
            
            wait 1;
        }
    }

#/

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0x57af5abc, Offset: 0x35b5
// Size: 0x186
function function_430bfb34f5c4fc82( threshold, var_522717c720226792, delay = undefined )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    level utility::flag_set( "flag_allow_harper_damage" );
    level utility::flag_clear( "flag_remove_harper_objective" );
    level utility::flag_clear( "flag_stun_harper" );
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_harper", level.health_struct );
    }
    
    while ( level.health_struct.health > threshold )
    {
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
    }
    
    level utility::flag_clear( "flag_allow_harper_damage" );
    
    if ( isdefined( var_522717c720226792 ) )
    {
        level utility::flag_set( var_522717c720226792 );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0xa4ba17f7, Offset: 0x3743
// Size: 0xaa
function boss_damage_listener()
{
    level notify( #"hash_11f7ecde5454a29" );
    level endon( #"hash_11f7ecde5454a29" );
    hit_dmg = 100;
    
    while ( true )
    {
        level waittill( #"harper_damaged", amount );
        
        if ( isdefined( amount ) )
        {
            hit_dmg = amount;
        }
        
        /#
            iprintln( hit_dmg );
        #/
        
        if ( level utility::flag( "flag_allow_harper_damage" ) )
        {
            level.health_struct.health -= hit_dmg;
            level callback::callback( "on_boss_progress_updated", level.health_struct );
        }
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0xa9b5f18e, Offset: 0x37f5
// Size: 0xfe
function boss_stunned_phase( threshold, var_522717c720226792, var_772501ce9a0c24da = 9 )
{
    scene_struct = utility::getstruct( "scene_harper_boss", "targetname" );
    shot = level.current_react;
    level thread ob_virgo_util::function_fdd5b4c27ba17b79();
    level thread rumble_players();
    level.health_struct.health -= level.stun_damage;
    level callback::callback( "on_boss_progress_updated", level.health_struct );
    
    if ( !isdefined( shot ) )
    {
        shot = "hurt_hit_01";
    }
    
    scene_struct thread function_9d936b5b0f7e006e( var_522717c720226792, shot );
    var_e9044649c161984d = function_24ce3e590bdaa921( threshold, var_772501ce9a0c24da );
    level.harper setscriptablepartstate( "attack", "default" );
    
    if ( var_e9044649c161984d )
    {
        level utility::flag_set( var_522717c720226792 );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 2
// Checksum 0xc7d7f829, Offset: 0x38fb
// Size: 0xd9
function rumble_players( rumble = "heavy_3s", do_quake = 1 )
{
    foreach ( player in level.players )
    {
        player playrumbleonentity( rumble );
    }
    
    if ( do_quake )
    {
        earthquakeadvanced( 0.3, 0.2, 0.04, 1, level.harper.origin, 2000, 4000, 8000 );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 2
// Checksum 0x8b82db4, Offset: 0x39dc
// Size: 0x34
function function_9d936b5b0f7e006e( var_522717c720226792, stun_shot )
{
    level thread slam_pop();
    scene::play( undefined, stun_shot );
    level utility::flag_clear( "flag_stun_harper" );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 2
// Checksum 0x1b70998d, Offset: 0x3a18
// Size: 0x89, Type: bool
function function_24ce3e590bdaa921( threshold, var_772501ce9a0c24da )
{
    timerms = var_772501ce9a0c24da * 1000;
    start_time = gettime();
    
    while ( level.health_struct.health > threshold )
    {
        curr_time = gettime();
        
        if ( curr_time >= start_time + timerms )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( level.health_struct.health <= threshold )
    {
        return true;
    }
    
    return false;
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 5
// Checksum 0xf9d3603d, Offset: 0x3aaa
// Size: 0x10c
function boss_attack_vulnerable( stop_flag, part, delay, var_78a1a9cabfc4d42e = 1500, second_bubble = 0 )
{
    if ( second_bubble )
    {
        level thread function_382a62f771d9c79a( var_78a1a9cabfc4d42e, part, delay );
    }
    
    bubble_health( var_78a1a9cabfc4d42e, part, delay );
    level.harper setscriptablepartstate( "attack", "default" );
    level.bubble unlink();
    level.bubble.origin = level.old_spot;
    
    if ( second_bubble )
    {
        if ( isdefined( level.bubble_2 ) )
        {
            level.bubble_2 unlink();
            level.bubble_2.origin = level.old_spot;
        }
    }
    
    if ( level utility::flag( "flag_stun_harper" ) )
    {
        boss_stunned_phase( level.health_threshold, stop_flag );
        level utility::flag_clear( "flag_stun_harper" );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0xcc4642d2, Offset: 0x3bbe
// Size: 0x435
function bubble_health( var_78a1a9cabfc4d42e = 500, part, delay )
{
    level endon( #"hash_c4980a0ee83ab554" );
    hint_line = undefined;
    scriptable_part = undefined;
    scriptable_state = undefined;
    
    if ( !isdefined( level.mouth_attack_count ) )
    {
        level.mouth_attack_count = 0;
    }
    
    if ( !isdefined( level.var_2efd05be56ec2a2c ) )
    {
        level.var_2efd05be56ec2a2c = 0;
    }
    
    count = 0;
    
    switch ( part )
    {
        case #"hash_e7c68238652540bc":
            tag = "tag_fx_mouth";
            offset = ( 0, 0, 0 );
            hint_line = &"sat_ob_story_missions/virgo_hint_harper_mouth";
            scriptable_part = "attack";
            scriptable_state = "mouth";
            count = level.mouth_attack_count;
            level.mouth_attack_count++;
            pop_flag_name = "flag_popped_mouth_attack";
            break;
        case #"hash_da2f35145aa58933":
            tag = "j_ring_ri_1";
            offset = ( 0, 0, 0 );
            hint_line = &"sat_ob_story_missions/virgo_hint_harper_hand";
            scriptable_part = "attack";
            scriptable_state = "killstreak";
            count = level.var_2efd05be56ec2a2c;
            level.var_2efd05be56ec2a2c++;
            pop_flag_name = "flag_popped_killstreak_attack";
            break;
        default:
            tag = "tag_fx_mouth";
            offset = ( 0, 0, 0 );
            hint_line = &"sat_ob_story_missions/virgo_hint_harper_mouth";
            scriptable_part = "attack";
            scriptable_state = "mouth";
            break;
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( hint_line ) && function_b3536364361b680e( pop_flag_name, count ) )
    {
        foreach ( player in level.players )
        {
            player thread hints::hint_add_simple( "harper_weak_point", hint_line, 4, &function_8e164960be122813 );
        }
    }
    
    if ( isdefined( scriptable_part ) )
    {
        level.harper setscriptablepartstate( scriptable_part, scriptable_state );
    }
    
    level.bubble setcandamage( 1 );
    level.bubble.origin = level.harper gettagorigin( tag );
    level.bubble linkto( level.harper, tag, offset, ( 0, 0, 0 ) );
    current_hits = 0;
    player_count_adjustment = level.players.size * 500;
    var_3af905cd185d7d6d = var_78a1a9cabfc4d42e;
    bubble_threshold = var_3af905cd185d7d6d + player_count_adjustment;
    
    while ( true )
    {
        level.bubble waittill( #"damage", damage, attacker, direction, point, type, model, tag, part, idflags, objweapon );
        
        if ( isplayer( attacker ) )
        {
            damage *= 7;
            
            if ( isdefined( objweapon ) && function_ad3f7e0f31991cb8( objweapon ) )
            {
                damage *= function_ad3f7e0f31991cb8( objweapon );
            }
            
            damage = clamp( damage, 100, 5000 );
            
            /#
                iprintln( "<dev string:x9d>" + damage );
            #/
            
            attacker damagefeedback::updatehitmarker( 1, 0, 1, 0, undefined, undefined, undefined, undefined, 1 );
            attacker utility::callsharedfunc( #"hud", #"hash_eb86447382b1de03", 0, self );
            level thread play_impact( "harper_bubble_impact", point, direction, damage, bubble_threshold, 0 );
            bubble_threshold -= damage;
            
            if ( bubble_threshold < 0 )
            {
                level utility::flag_set( "flag_stun_harper" );
                level utility::flag_set( pop_flag_name );
                level notify( #"hash_c4980a0ee83ab554" );
                break;
            }
            
            attacker playsoundtoplayer( "evt_giant_harper_weak_spot_bullet_imp", attacker );
        }
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 2
// Checksum 0x2efd0a0, Offset: 0x3ffb
// Size: 0x2f, Type: bool
function function_b3536364361b680e( pop_flag_name, count )
{
    if ( level utility::flag( pop_flag_name ) )
    {
        return false;
    }
    
    if ( count < 2 )
    {
        return false;
    }
    
    return true;
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0x8cc7a3c3, Offset: 0x4033
// Size: 0x8b
function function_bfdd00ad736bde06()
{
    foreach ( player in level.players )
    {
        player thread hints::hint_add_simple( "harper_gas_ring", &"sat_ob_story_missions/virgo_hint_harper_ring", 5 );
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 3
// Checksum 0xc6dc0c6d, Offset: 0x40c6
// Size: 0x252
function function_382a62f771d9c79a( var_78a1a9cabfc4d42e = 500, part, delay )
{
    level endon( #"hash_c4980a0ee83ab554" );
    tag = "j_ring_le_1";
    offset = ( 0, 0, 0 );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( !isdefined( level.bubble_2 ) )
    {
        return;
    }
    
    level.bubble_2 setcandamage( 1 );
    level.bubble_2.origin = level.harper gettagorigin( tag );
    level.bubble_2 linkto( level.harper, tag, offset, ( 0, 0, 0 ) );
    current_hits = 0;
    player_count_adjustment = level.players.size * 500;
    var_3af905cd185d7d6d = var_78a1a9cabfc4d42e;
    bubble_threshold = var_3af905cd185d7d6d + player_count_adjustment;
    
    while ( true )
    {
        level.bubble_2 waittill( #"damage", damage, attacker, direction, point, type, model, tag, part, idflags, objweapon );
        
        if ( isplayer( attacker ) )
        {
            damage *= 7;
            
            if ( isdefined( objweapon ) && function_ad3f7e0f31991cb8( objweapon ) )
            {
                damage *= function_ad3f7e0f31991cb8( objweapon );
            }
            
            damage = clamp( damage, 100, 5000 );
            
            /#
                iprintln( "<dev string:x9d>" + damage );
            #/
            
            attacker damagefeedback::updatehitmarker( 1, 0, 1, 0, undefined, undefined, undefined, undefined, 1 );
            attacker utility::callsharedfunc( #"hud", #"hash_eb86447382b1de03", 0, self );
            level thread play_impact( "harper_bubble_impact", point, direction, damage, bubble_threshold, 0 );
            bubble_threshold -= damage;
            
            if ( bubble_threshold < 0 )
            {
                level utility::flag_set( "flag_stun_harper" );
                level utility::flag_set( "flag_popped_killstreak_attack" );
                level notify( #"hash_c4980a0ee83ab554" );
                break;
            }
            
            attacker playsoundtoplayer( "evt_giant_harper_weak_spot_bullet_imp", attacker );
        }
    }
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 0
// Checksum 0x2e15bfe7, Offset: 0x4320
// Size: 0x2b, Type: bool
function function_8e164960be122813()
{
    if ( level utility::flag( "flag_stun_harper" ) )
    {
        return true;
    }
    
    if ( level utility::flag( level.var_bf2e669910db962c ) )
    {
        return true;
    }
    
    return false;
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 1
// Checksum 0x2a561f80, Offset: 0x4354
// Size: 0x27
function bubble_timeout( delay )
{
    level endon( #"hash_c4980a0ee83ab554" );
    wait delay;
    level notify( #"hash_c4980a0ee83ab554" );
}

// Namespace OB_VIRGO_CARRIER_INTRO
// Params 6
// Checksum 0x154e2393, Offset: 0x4383
// Size: 0x95
function play_impact( impact_type, point, direction = ( 0, 0, 1 ), damage, health, lethal_threshold )
{
    if ( isdefined( damage ) )
    {
        threshold = health - damage;
        
        if ( threshold < lethal_threshold )
        {
            impact_type = "harper_fatal_impact";
        }
    }
    
    if ( isdefined( point ) )
    {
        playfx( level._effect[ impact_type ], point, anglestoforward( direction ), anglestoup( direction ) );
    }
}

