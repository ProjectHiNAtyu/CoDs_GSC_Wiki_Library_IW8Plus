// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_boss_fight.gsc  (hash_062b924f07195bb6.gscc) (size: 40670 Bytes / 0x9ede / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7e576a3 (2816833187)
// size ...... 40670 (0x9ede)
// includes .. 53  (offset: 0x9386)
// strings ... 153 (offset: 0x952e)
// dev strs .. 15  (offset: 0x9e26)
// exports ... 69  (offset: 0x5fbe)
// cseg ...... 0xdba + 0x5204 (0x5fbe)
// imports ... 324 (offset: 0x6a86)
// animtree1 . 0   (offset: 0x9ede)
// animtree2 . 0   (offset: 0x9ede)
#using script_16ea1b94f0f381b3;
#using script_54d7585f0a1791e6;
#using script_790c61e9438e5f33;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_aetheric_energy;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_move;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\augments\zombie_augments;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\overlord;
#using scripts\mp\pack_a_punch;
#using scripts\mp\playerlogic;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_boss_fight_urchin_cs;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_mq;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_armor;
#using scripts\mp\zm\systems\zm_barnacle;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_lighting_visionset;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_urchin;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm;
#using scripts\mp\zm\zm_utility;
#using scripts\vehicle\pluto\pluto_shared;

#namespace zm_sat_firefly_boss_fight;

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x5
// Checksum 0xde5e6d7, Offset: 0xdd8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"firefly_boss_fight", #"zm_quest", &pre_main, undefined );
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xbffaa0ea, Offset: 0xe01
// Size: 0x189
function private pre_main()
{
    level.s_firefly_boss = spawnstruct();
    level.s_firefly_boss.var_be82617e5e8087bd = [];
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_7d1b4b7b23fd890d", &function_e83b11eb8fabc062 );
    
    if ( getdvarint( @"hash_bf9422c47629ad53", 0 ) )
    {
        utility::delaythread( 1, &start_boss_fight );
    }
    
    boss_spawn_pos_struct = utility::getstruct( "firefly_boss_spawn_pos", "targetname" );
    
    if ( !isdefined( boss_spawn_pos_struct ) )
    {
        boss_spawn_pos_struct = { #angles:( 0, 0, 0 ), #origin:( 7682, -6057, 397 ), #targetname:"firefly_boss_spawn_pos" };
        utility::addstruct( boss_spawn_pos_struct );
    }
    
    var_e4d291ff6e8515af = utility::getstructarray( "boss_arena_start_pos", "targetname" );
    
    if ( var_e4d291ff6e8515af.size <= 0 )
    {
        player_spawn_pos_struct = { #angles:( 0, 283, 0 ), #origin:( 7506, -4728, 319 ), #targetname:"boss_arena_start_pos" };
        utility::addstruct( player_spawn_pos_struct );
        utility::addstruct( player_spawn_pos_struct );
        utility::addstruct( player_spawn_pos_struct );
        utility::addstruct( player_spawn_pos_struct );
    }
    
    level callback::add( "hermes_vehicle_modified", &on_hermes_vehicle_modified );
    
    if ( !isdefined( level.var_a417b33646ddb4b3 ) )
    {
        level mutant_injection_zombies::function_fe184eca11e17f3( 150, 5000, "boss" );
    }
    
    /#
        level thread boss_devgui();
    #/
}

// Namespace zm_sat_firefly_boss_fight
// Params 1
// Checksum 0xb20cc341, Offset: 0xf92
// Size: 0xdc2
function start_boss_fight( var_61718866e365d0f9 )
{
    self notify( #"hash_20283439f2072f08" );
    self endon( #"hash_20283439f2072f08" );
    FIREFLY_BOSS = undefined;
    deactivateworldevent( "we_sat_firefly_boss_light" );
    level.var_81dc9de2fda86a3f = level.var_8a98c33a6b47db4a && getdvarint( @"hash_29d6c9bed7b8174e", 1 ) > 0;
    level utility::flag_clear( "rbz_allow_exfil" );
    level musicbank_utility::function_683e33ddcb824d18( #"round_start" );
    level musicbank_utility::function_683e33ddcb824d18( #"round_end" );
    n_round = zm_utility::get_round_number();
    
    if ( getdvarint( @"hash_bf9422c47629ad53", 0 ) || level.var_8bd966e8e0c1bbaa )
    {
        if ( !level utility::flag( "open_sesame" ) )
        {
            zm_utility::open_sesame();
            wait 2;
        }
        
        level notify( #"restart_round" );
        n_round = level.var_5b30c08562022091 ?? function_b80976b7930587b4();
        
        if ( zm_utility::get_round_number() != n_round )
        {
            zm_round_logic::function_68bdb49c82c0f892( n_round );
            zm_round_logic::function_895fdc21ab019efe();
        }
        
        zm_utility::function_1bd2eda42461fad1( level.var_6781718da4f78d1c.roundnumber );
        var_f342a872dffd84b0 = utility::getstructarray( "boss_arena_start_pos", "targetname" );
        var_f342a872dffd84b0 = arrayrandomize( var_f342a872dffd84b0 );
        zone_manager::set_zone_enabled( "zone_boss_arena", 1 );
        
        if ( getdvarint( @"hash_bf9422c47629ad53", 0 ) && !level.var_8bd966e8e0c1bbaa )
        {
            level thread function_5f0a50b61f3da74c();
        }
        
        wait 1;
        zm_sat_firefly_boss_fight_urchin_cs::main();
        utility::flag_set( "firefly_boss_fight_start" );
        level.var_8bd966e8e0c1bbaa = undefined;
    }
    
    level callback::callback( "zm_mq_final_fight_start", { #timestamp:gettime() } );
    zm_round_spawning::pause_round_spawning( 1, "firefly_boss_fight_pause_spawning" );
    level val::set( "tasks_firefly_boss_fight", "task_logic_activate", 0 );
    
    foreach ( s_magic_box in level.var_1bbb5557537e2c0c )
    {
        if ( s_magic_box.var_f14b2b4820b635e7 )
        {
            s_magic_box thread magicbox::hide_magicbox();
            break;
        }
    }
    
    zone_manager::set_zone_enabled( "zone_boss_arena", 1 );
    
    foreach ( player in level.players )
    {
        player val::set( "firefly_boss_fight", "ignoreme", 1 );
        player val::set( "firefly_boss_fight", "damage", 0 );
        player.var_14db25ae7cde1c15 = 1;
        player function_d88e8eab88c50c13( 1 );
    }
    
    spawn_boss_model( n_round );
    function_82d79b414f7830b0( var_61718866e365d0f9 );
    
    if ( isdefined( level.wonder_veh ) )
    {
        level utility::flag_set( "firefly_boss_fight_start_teleport_veh" );
        var_6209aa2f9c5149e4 = utility::getstructarray( "vehicle_respawn_point", "targetname" );
        chosen_point = undefined;
        chosen_angles = undefined;
        
        foreach ( point in var_6209aa2f9c5149e4 )
        {
            if ( point.target == "starting_vehicle_point" )
            {
                chosen_point = point.origin;
                chosen_angles = point.angles;
                break;
            }
        }
        
        if ( !( isdefined( chosen_point ) && isdefined( chosen_angles ) ) )
        {
            iprintlnbold( "No valid vehicle respawn points found for wonder vehicle in Boss Arena." );
            chosen_point = ( 45051.5, -1690, -192 );
            chosen_angles = ( 0, 14.9871, 0 );
        }
        
        level utility::flag_clear( "firefly_boss_fight_start_teleport_veh" );
    }
    
    wait 1;
    
    foreach ( player in level.players )
    {
        player setsoundsubmix( "sat_zm_firefly_boss", -1, 1 );
    }
    
    if ( !utility::flag( "firefly_boss_callbacks_added" ) )
    {
        level callback::add( "vo_shadow_energy_attack_launched", &function_50d136e458aa9204 );
        level callback::add( "vo_shadow_soul_beam_attack", &vo_shadow_soul_beam_attack );
        level callback::add( "vo_boss_aetheric_energy_pickup", &vo_boss_aetheric_energy_pickup );
        level callback::add( "vo_boss_aetheric_energy_attack", &vo_boss_aetheric_energy_attack );
        level callback::add( "vo_ufo_attack", &vo_ufo_attack );
        level callback::add( "vo_launch_zombie_attack", &vo_launch_zombie_attack );
        level callback::add( "vo_hermes_invulnerable", &function_87a73669d70840cb );
        level callback::add( "vo_hermes_invulnerable", &invulnerable_music );
        level.s_firefly_boss.entity callback::add( "on_hermes_gamera_spin_immune", &function_bd284f5a9c74806f );
        level.s_firefly_boss.entity callback::add( "on_hermes_stunned", &function_bd284f5a9c74806f );
        level callback::add( "hermes_aetheric_energy_spawned", &function_a70f201acfecb1f1 );
        level callback::add( "phase_heal_tessie", &function_1aa6798c6e512797 );
        level callback::add( #"player_laststand", &vo_player_downed );
    }
    
    utility::flag_set( "firefly_boss_callbacks_added" );
    level thread vo_boss_fight_start();
    level.var_9c0d12c8f8edeb3d = "sat_cin_zm_vig_plr_dth_hermes_01";
    level.s_game_over_scene_override = utility::getstruct( "zombie_game_over_scene_hermes", "targetname" );
    level.s_firefly_boss.entity setbtgoalstationary( 0 );
    skipped_intro = 0;
    
    if ( getdvarint( @"hash_d7808a252138594e", 1 ) > 0 )
    {
        level thread play_intro_sequence( chosen_point, chosen_angles );
    }
    else
    {
        activateworldevent( "we_sat_firefly_boss_light" );
        
        foreach ( player in level.players )
        {
            player thread zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_hermes_healthbar", level.s_firefly_boss.entity );
        }
        
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_start" );
        level.wonder_veh vehicle_teleport( chosen_point, chosen_angles );
        function_6b01801b08f66717();
        skipped_intro = 1;
    }
    
    level thread function_e4e3ee7973fee3af();
    utility::array_thread( level.players, &val::reset_all, "firefly_boss_fight" );
    level.var_654073823a58b613 = &function_54e8f68865420985;
    
    if ( !callback::exists( #"player_spawned", &on_player_spawned ) )
    {
        level callback::add( #"player_spawned", &on_player_spawned );
    }
    
    if ( !callback::exists( "on_zombie_ai_spawned", &function_2ed0e66395a9201a ) )
    {
        level callback::add( "on_zombie_ai_spawned", &function_2ed0e66395a9201a );
    }
    
    if ( !callback::exists( "new_hermes_phase", &spawn_boss_powerup ) )
    {
        level callback::add( "new_hermes_phase", &spawn_boss_powerup );
    }
    
    if ( !callback::exists( "vehicle_aetheric_energy_imbued", &on_vehicle_imbued ) )
    {
        level callback::add( "vehicle_aetheric_energy_imbued", &on_vehicle_imbued );
    }
    
    if ( !callback::exists( "new_hermes_phase", &phase_change_music ) )
    {
        level callback::add( "new_hermes_phase", &phase_change_music );
    }
    
    level thread function_3333966761f3426();
    zm_barnacle::init_boss_fight_barnacles();
    
    if ( n_round >= 100 )
    {
        if ( !level callback::exists( "spawn_boss_death_urchins", &spawn_boss_death_urchins ) )
        {
            level callback::add( "spawn_boss_death_urchins", &spawn_boss_death_urchins );
        }
        
        level thread spawn_boss_death_urchins( { #var_f7585bfe318bec1:1 } );
    }
    
    if ( !level callback::exists( "spawn_boss_barnacles", &spawn_boss_barnacles ) )
    {
        level callback::add( "spawn_boss_barnacles", &spawn_boss_barnacles );
    }
    
    level thread spawn_boss_barnacles( { #var_f7585bfe318bec1:1 } );
    level thread spawn_adds();
    
    if ( skipped_intro )
    {
        level notify( #"firefly_boss_intro_done" );
    }
    else
    {
        level waittill( #"firefly_boss_intro_done" );
    }
    
    level.wonder_veh.stagerequested = 5;
    level thread function_17fc4da24b13ff20( level.wonder_veh );
    scene::function_85b13b837056bc8b( &function_211a1f0a0f5ca4fd );
    level utility::flag_set( "disable_pluto_repair_delay" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level utility::flag_set( "directed_damage_boss" );
        function_ecc91637c2a6fbb1();
    }
    
    result = level.s_firefly_boss.entity utility::waittill_any_return_no_endon_death( "death", "fake_death" );
    
    foreach ( player in level.players )
    {
        player clearsoundsubmix( "sat_zm_firefly_boss" );
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_complete" );
    function_af128c8a75662591();
    function_768d3a0b57154613();
    function_9504b8fbe743abec();
    level utility::flag_clear( "disable_pluto_repair_delay" );
    zm_round_spawning::pause_round_spawning( 0, "firefly_boss_fight_pause_spawning" );
    level.wonder_veh.stagerequested = 4;
    
    if ( callback::exists( "on_zombie_ai_spawned", &function_2ed0e66395a9201a ) )
    {
        level callback::remove( "on_zombie_ai_spawned", &function_2ed0e66395a9201a );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level utility::flag_set( "directed_end_boss" );
        function_ecc91637c2a6fbb1();
    }
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
        
        if ( player::isinlaststand( player ) )
        {
            player laststand::exit( "last_stand_revived", player );
        }
        
        player.var_14db25ae7cde1c15 = 0;
    }
    
    if ( callback::exists( "phase_heal_tessie", &function_1aa6798c6e512797 ) )
    {
        level callback::remove( "phase_heal_tessie", &function_1aa6798c6e512797 );
    }
    
    utility::flag_clear( "firefly_boss_callbacks_added" );
    level callback::remove( "vo_shadow_energy_attack_launched", &function_50d136e458aa9204 );
    level callback::remove( "vo_shadow_soul_beam_attack", &vo_shadow_soul_beam_attack );
    level callback::remove( "vo_ufo_attack", &vo_ufo_attack );
    level callback::remove( "vo_boss_aetheric_energy_pickup", &vo_boss_aetheric_energy_pickup );
    level callback::remove( "vo_boss_aetheric_energy_attack", &vo_boss_aetheric_energy_attack );
    level callback::remove( "vo_launch_zombie_attack", &vo_launch_zombie_attack );
    level callback::remove( "vo_hermes_invulnerable", &function_87a73669d70840cb );
    level callback::remove( "vo_hermes_invulnerable", &invulnerable_music );
    level callback::remove( "hermes_aetheric_energy_spawned", &function_a70f201acfecb1f1 );
    level callback::remove( #"player_laststand", &vo_player_downed );
    level musicbank_utility::function_e146ca500a84f52f( #"round_start" );
    level musicbank_utility::function_e146ca500a84f52f( #"round_end" );
    zm_quest::function_2850bf8c7015dc92( [ "zone_boss_arena" ] );
    level.var_328791597304e46b = undefined;
    level.var_9c0d12c8f8edeb3d = undefined;
    level.s_game_over_scene_override = undefined;
    zm_round_spawning::pause_round_spawning( 0, "firefly_boss_fight_pause_spawning" );
    zm_round_spawning::pause_round_spawning( 1, "final_scene" );
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) || zombie utility::ent_flag( "scene_active" ) || !zombie val::get( "death" ) )
        {
            continue;
        }
        
        if ( zombie.aicategory === "boss" )
        {
            continue;
        }
        
        zombie.death_source = "firefly_boss_all_kill";
        zombie kill();
        waitframe();
    }
    
    if ( level callback::exists( "spawn_boss_death_urchins", &spawn_boss_death_urchins ) )
    {
        level callback::remove( "spawn_boss_death_urchins", &spawn_boss_death_urchins );
        zm_urchin::function_f5d3679bd21a64b();
    }
    
    level callback::remove( "spawn_boss_barnacles", &spawn_boss_barnacles );
    zm_barnacle::despawn_boss_barnacles();
    removeallcorpses();
    utility::flag_set( "firefly_boss_fight_complete" );
    utility::flag_clear( "firefly_boss_fight_start" );
    function_aa17fa7583dcf3bd( var_61718866e365d0f9, result != "death" );
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xbd3d5458, Offset: 0x1d5c
// Size: 0x188
function private function_211a1f0a0f5ca4fd()
{
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
    
    if ( self.script_scenescriptbundle != "sat_cin_zm_vig_plr_dth_hermes_01" && self.script_scenescriptbundle != "sat_cin_zm_fly_outro" )
    {
        return;
    }
    
    if ( isdefined( level.wonder_veh ) )
    {
        level.wonder_veh thread utility::callsharedfunc( #"veh_pluto", #"hash_c662103c9de1c046" );
    }
    
    if ( isalive( level.s_firefly_boss.entity ) )
    {
        level thread zombie_hermes_move::function_5308069777f513f1( level.s_firefly_boss.entity );
    }
    
    foreach ( player in level.players )
    {
        player thread utility::callsharedfunc( #"fireflyww", #"hash_dd255803bfe21f65", 1 );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 2, eflags: 0x4
// Checksum 0xfcd4bfbb, Offset: 0x1eec
// Size: 0x327
function private play_intro_sequence( start_pos, start_angles )
{
    level.s_firefly_boss.entity endon( #"death" );
    wait 1;
    var_de36bb737872a2f7 = 0;
    end_time = gettime() + utility::function_4b74c15943231980( 30 );
    
    while ( gettime() < end_time )
    {
        var_54f6bc129bf800ff = 0;
        var_71ad1fcaa45ff309 = undefined;
        
        foreach ( player in level.players )
        {
            if ( can_see_boss( player, 10 ) )
            {
                var_54f6bc129bf800ff = 1;
                var_71ad1fcaa45ff309 = player;
                break;
            }
            
            if ( can_see_boss( player ) )
            {
                var_de36bb737872a2f7 += level.framedurationseconds;
                
                if ( var_de36bb737872a2f7 > 1 )
                {
                    var_71ad1fcaa45ff309 = player;
                    break;
                }
            }
            
            if ( start_pos && distance2d( player.origin, start_pos ) > 750 )
            {
                var_71ad1fcaa45ff309 = player;
                break;
            }
        }
        
        if ( utility::flag( "firefly_boss_found_boss" ) )
        {
            break;
        }
        
        if ( var_71ad1fcaa45ff309 )
        {
            break;
        }
        
        waitframe();
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_start" );
    level.s_firefly_boss.entity thread utility::thread_on_notify( "start_screenshake", &function_2065a9feccf730e, level.s_firefly_boss.entity, "firefly_boss_intro_done" );
    level thread function_7ac58316c5eb3fe5( var_71ad1fcaa45ff309 );
    wait 2;
    level thread function_f7334642ca9d7262();
    level thread utility::delaythread( 4, &function_9cc2b48802345520 );
    level.wonder_veh thread utility::delaythread( 1, &pluto_veh::function_934c783b411fa6cc, start_pos, start_angles ?? ( 0, 0, 0 ) );
    level.s_firefly_boss.entity utility::function_7c10ea82c1e305b8( "idle_intro", "off" );
    level.s_firefly_boss scene::play( level.s_firefly_boss.entity, "intro", "sat_cin_zm_fly_boss_intro" );
    level notify( #"firefly_boss_intro_done" );
    level.s_firefly_boss.entity notify( #"firefly_boss_intro_done" );
    
    foreach ( player in level.players )
    {
        if ( player.var_383ec89462929311 )
        {
            player inventory_utility::takegunlessweapon( player.var_383ec89462929311 );
        }
        
        player val::reset_all( "firefly_boss_intro_cinematic" );
    }
    
    function_6b01801b08f66717();
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x5fe9bd18, Offset: 0x221b
// Size: 0x157
function private function_9cc2b48802345520()
{
    foreach ( player in level.players )
    {
        if ( isalive( level.s_firefly_boss.entity ) )
        {
            var_339d6cc1cd302213 = !zombie_hermes_aetheric_energy::is_stunned( level.s_firefly_boss.entity ) || zombie_hermes_aetheric_energy::is_recently_stunned( level.s_firefly_boss.entity );
            is_immune = zombie_hermes_aetheric_energy::function_798e83d6bf762949( level.s_firefly_boss.entity ) && var_339d6cc1cd302213 || level.s_firefly_boss.entity utility::ent_flag( "hermes_gamera_spin_immune" );
            
            if ( !is_immune )
            {
                player zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_hermes_healthbar", level.s_firefly_boss.entity );
            }
            else
            {
                player zombie_boss_healthbar::zombie_boss_healthbar_immune();
            }
            
            continue;
        }
        
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x5d2c3009, Offset: 0x237a
// Size: 0x1f
function private function_bd284f5a9c74806f( params )
{
    utility::ent_flag_waitopen_any( "hermes_stunned_recently" );
    function_9cc2b48802345520();
}

// Namespace zm_sat_firefly_boss_fight
// Params 2, eflags: 0x4
// Checksum 0x1d9cc8a2, Offset: 0x23a1
// Size: 0x56
function private can_see_boss( player, fov = 30 )
{
    return withinfov( player.origin, player getplayerangles(), level.s_firefly_boss.entity.origin, cos( fov ) );
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x3103d2e3, Offset: 0x2400
// Size: 0x9a
function private function_2065a9feccf730e()
{
    foreach ( player in level.players )
    {
        player earthquakeforplayer( 0.2, 2, player.origin, 500 );
        player playrumbleonentity( "heavy_2s" );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x6a1d1dba, Offset: 0x24a2
// Size: 0x86e
function private function_7ac58316c5eb3fe5( var_71ad1fcaa45ff309 )
{
    if ( getdvarint( @"hash_567219ee7397ea4b", 1 ) <= 0 )
    {
        return;
    }
    
    var_2f07db258f716d8f = isdefined( var_71ad1fcaa45ff309.vehicle );
    
    foreach ( player in level.players )
    {
        player.var_ecdded035c957180 = 0;
        player playsoundtoplayer( "evt_ai_hermes_intro_whoosh", player );
        player val::set( "firefly_boss_intro_cinematic", "allow_movement", 0 );
        
        if ( player.vehicle )
        {
            player.var_6fc6affda1468970 = player.vehicle;
            player.var_67b809caa1dbc218 = vehicle_occupancy::get_occupant_seat( player.vehicle, player );
            thread vehicle_occupancy::exit( player.vehicle, undefined, player, undefined, 1 );
        }
    }
    
    foreach ( player in level.players )
    {
        if ( !player.var_6fc6affda1468970 )
        {
            player.var_383ec89462929311 = player getcurrentweapon();
            player inventory_utility::givegunlessweapon();
        }
    }
    
    foreach ( player in level.players )
    {
        while ( player && player inventory_utility::isanymonitoredweaponswitchinprogress() )
        {
            waitframe();
        }
    }
    
    foreach ( player in level.players )
    {
        if ( player.var_ecdded035c957180 )
        {
            player.var_20c3081a04201e3b = var_71ad1fcaa45ff309;
            player startcameratween( 1, 1 );
        }
        else
        {
            player.var_20c3081a04201e3b = level.s_firefly_boss.entity;
            player startcameratween( 2, 1 );
        }
        
        var_7e5c210112685ff0 = player geteye();
        var_ba474bc1a76e1caa = vectortoangles( player.var_20c3081a04201e3b.origin - var_7e5c210112685ff0 );
        var_7e5c210112685ff0 += ( 0, 0, 60 );
        player.camera_link = utility::spawn_model( "tag_origin", var_7e5c210112685ff0, var_ba474bc1a76e1caa );
        player.camera_link thread function_4c9b4aed64deaa7f( player, player.camera_link );
        player thread utility::delete_on_death( player.camera_link );
        player cameralinkto( player.camera_link, "tag_origin", 1, 1 );
        camfstop = 20;
        var_808746315c162c95 = 300;
        var_84e9de3fe674dc3c = 2;
        var_f660c6a7f16bbd5f = 4;
        player enablephysicaldepthoffieldscripting();
        player setphysicaldepthoffield( camfstop, var_808746315c162c95, var_84e9de3fe674dc3c, var_f660c6a7f16bbd5f );
    }
    
    foreach ( player in level.players )
    {
        if ( getdvarint( @"hash_c48a78165b89d882", 1 ) > 0 )
        {
            if ( player.var_20c3081a04201e3b != level.s_firefly_boss.entity )
            {
                player modifybasefov( 30, 1 );
                player lerpfovscalefactor( 0, 0.5 );
            }
            else
            {
                player modifybasefov( 20, 0.5 );
                player lerpfovscalefactor( 0, 0.5 );
            }
            
            player function_f3f05a362d4b7712( 1 );
        }
        
        player playerhide();
    }
    
    waitframe();
    
    foreach ( player in level.players )
    {
        player playershow();
    }
    
    wait 1.5;
    
    foreach ( player in level.players )
    {
        if ( player.var_20c3081a04201e3b != level.s_firefly_boss.entity )
        {
            player startcameratween( 2, 1 );
            player.var_20c3081a04201e3b = level.s_firefly_boss.entity;
        }
    }
    
    wait 2;
    wait 1;
    
    foreach ( player in level.players )
    {
        player modifybasefov( 65, 0.5 );
        player lerpfovscalefactor( 1, 0.5 );
        player function_f3f05a362d4b7712( 0 );
    }
    
    wait 2.5;
    
    foreach ( player in level.players )
    {
        player startcameratween( 0.5, 1 );
        player cameraunlink();
        
        if ( player.camera_link )
        {
            player.camera_link delete();
        }
        
        player disablephysicaldepthoffieldscripting();
    }
    
    foreach ( player in level.players )
    {
        if ( !player.var_6fc6affda1468970 )
        {
            continue;
        }
        
        player thread vehicle_occupancy::enter( player.var_6fc6affda1468970, player.var_67b809caa1dbc218, player, undefined, 1 );
        player.var_6fc6affda1468970 = undefined;
    }
    
    foreach ( player in level.players )
    {
        if ( player.var_383ec89462929311 )
        {
            player inventory_utility::takegunlessweapon( player.var_383ec89462929311 );
        }
        
        player val::reset_all( "firefly_boss_intro_cinematic" );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x85d24a22, Offset: 0x2d18
// Size: 0x19
function private function_f7334642ca9d7262()
{
    deactivateworldevent( "we_sat_firefly_boss_light" );
    wait 2;
    activateworldevent( "we_sat_firefly_boss_light" );
}

// Namespace zm_sat_firefly_boss_fight
// Params 2, eflags: 0x4
// Checksum 0xa0950a68, Offset: 0x2d39
// Size: 0xbf
function private function_4c9b4aed64deaa7f( player, camera )
{
    player endon( #"death" );
    camera endon( #"death" );
    
    while ( isalive( player.var_20c3081a04201e3b ) )
    {
        target_pos = player.var_20c3081a04201e3b.origin;
        
        if ( isplayer( player.var_20c3081a04201e3b ) )
        {
            target_pos = player.var_20c3081a04201e3b.origin;
        }
        
        camera.angles = vectortoangles( target_pos - camera.origin );
        player setplayerangles( camera.angles );
        waitframe();
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 4, eflags: 0x4
// Checksum 0x9951c1d8, Offset: 0x2e00
// Size: 0x51
function private function_54e8f68865420985( var_be866219ba036c6, var_77fc4ed806f5cac9, var_51c533560222849c, var_9e41dd30435985b7 )
{
    s_respawn_group = zone_manager::function_9dd25e9fb0ecd45b( "zone_boss_arena" );
    return s_respawn_group[ 0 ].var_f448a26cf56f4a2a[ self getentitynumber() ];
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x2c0dc5b2, Offset: 0x2e5a
// Size: 0x107
function private get_zombie_base_speed()
{
    if ( self.aicategory != "normal" )
    {
        return;
    }
    
    speeds = [ "walk", "run", "sprint", "super_sprint" ];
    speed_offset = 2;
    
    if ( level.s_firefly_boss.entity zombie_utils::get_zombie_round_difficulty() >= 50 )
    {
        speed_offset += 0;
    }
    
    if ( level.s_firefly_boss.entity zombie_utils::get_zombie_round_difficulty() >= 100 )
    {
        speed_offset += 1;
    }
    
    max_speed_index = 3;
    
    if ( self.subclass == "zombie_base_armored_light" || self.subclass == "zombie_base_armored_heavy" )
    {
        max_speed_index = 2;
    }
    
    speed = utility::cointoss() ? speeds[ int( min( speed_offset, max_speed_index ) ) ] : speeds[ int( min( speed_offset + 1, max_speed_index ) ) ];
    return speed;
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x8382337d, Offset: 0x2f6a
// Size: 0x77
function private on_player_spawned( params )
{
    if ( !utility::flag( "firefly_boss_fight_complete" ) )
    {
        zombie_boss_healthbar::zombie_boss_healthbar_hide();
        var_f342a872dffd84b0 = utility::getstructarray( "boss_arena_start_pos", "targetname" );
        s_respawn_group = zone_manager::function_9dd25e9fb0ecd45b( "zone_boss_arena" );
        thread function_cd96995d9a559038( s_respawn_group[ 0 ].var_f448a26cf56f4a2a[ self getentitynumber() ] );
        wait 1;
        function_9cc2b48802345520();
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x33133639, Offset: 0x2fe9
// Size: 0x30
function private spawn_boss_death_urchins( params )
{
    if ( params.var_f7585bfe318bec1 )
    {
        level waittill( #"firefly_boss_intro_done" );
    }
    
    zm_urchin::function_9dcc3820f6db0b( 10 );
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x93c57df7, Offset: 0x3021
// Size: 0x30
function private spawn_boss_barnacles( params )
{
    if ( params.var_f7585bfe318bec1 )
    {
        level waittill( #"firefly_boss_intro_done" );
    }
    
    zm_barnacle::function_b2c54b98dc238f9( 7 );
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x4877db67, Offset: 0x3059
// Size: 0x194
function private function_17fc4da24b13ff20( vehicle )
{
    vehicle endon( #"death" );
    level utility::flag_waitopen( "warping_pluto" );
    waitframe();
    end_time = gettime() + 500;
    
    while ( gettime() < end_time )
    {
        nearby_players = function_d63fe6a4c08ba6f5( vehicle.origin, 1000, 400, 1 );
        remaining_players = arraycopy( nearby_players );
        
        foreach ( player in nearby_players )
        {
            if ( player.var_941ebfa7d3fd44b6 )
            {
                function_c8f569b219566cbb( player, player.var_941ebfa7d3fd44b6 );
                arrayremove( remaining_players, player );
            }
        }
        
        foreach ( player in remaining_players )
        {
            seat_id = vehicle_occupancy::function_79f80964bb18e6c6( level.wonder_veh, player, "back_right" );
            function_c8f569b219566cbb( player, seat_id );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 2, eflags: 0x4
// Checksum 0xc32dfc0c, Offset: 0x31f5
// Size: 0x92
function private function_c8f569b219566cbb( player, seat_id )
{
    player endon( #"death" );
    player endon( #"disconnect" );
    
    if ( player.ismutantinjection || player.vehicle )
    {
        return;
    }
    
    if ( !isdefined( seat_id ) )
    {
        seat_id = "driver";
    }
    
    player function_b14dead5d492aa48( 1 );
    thread vehicle_occupancy::enter( level.wonder_veh, seat_id, player );
    
    while ( !player vehicle::is_in_vehicle() )
    {
        wait 0.1;
    }
    
    player function_b14dead5d492aa48( 0 );
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x3acce506, Offset: 0x328f
// Size: 0xec
function private function_3333966761f3426()
{
    level waittill( #"firefly_boss_intro_done" );
    
    if ( !isdefined( level.var_b8321e0cfe7eb9ca ) )
    {
        level.var_b8321e0cfe7eb9ca = [];
    }
    
    level.var_b8321e0cfe7eb9ca = function_5713d46873b29625( level.var_b8321e0cfe7eb9ca );
    structs = utility::getstructarray( "boss_powerup_loc_OutPlayspace", "script_noteworthy" );
    
    if ( structs.size <= 0 )
    {
        return;
    }
    
    var_38b7db984cd651c1 = powerups::powerup_drop( "full_ammo", structs[ 0 ].origin, -1, undefined, "quest" );
    var_38b7d8984cd64b28 = powerups::powerup_drop( "full_armor", structs[ 1 ].origin, -1, undefined, "quest" );
    level.s_firefly_boss.entity waittill( #"death" );
    
    if ( var_38b7db984cd651c1 )
    {
        var_38b7db984cd651c1 delete();
    }
    
    if ( var_38b7d8984cd64b28 )
    {
        var_38b7d8984cd64b28 delete();
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x69d493c5, Offset: 0x3383
// Size: 0x52
function private phase_change_music( params )
{
    if ( isdefined( params.phase ) )
    {
        musicevent = hashcat( #"hash_9d1a261b27d25139", params.phase );
        level musicbank_utility::function_5aca66c390aa347d( level.players, musicevent );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xad987f9f, Offset: 0x33dd
// Size: 0x63
function private invulnerable_music( params )
{
    currentphase = zombie_hermes_aetheric_energy::get_hermes_phase( level.s_firefly_boss.entity );
    
    if ( isdefined( currentphase ) )
    {
        musicevent = hashcat( #"hash_6e64e53dcf12940d", currentphase );
        level musicbank_utility::function_5aca66c390aa347d( level.players, musicevent );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xd1111881, Offset: 0x3448
// Size: 0xf9
function private spawn_boss_powerup( params )
{
    structs = utility::getstructarray( "boss_powerup_loc_InPlayspace", "script_noteworthy" );
    
    if ( structs.size <= 0 )
    {
        return;
    }
    
    if ( !isdefined( level.firefly_boss_powerups ) )
    {
        level.firefly_boss_powerups = [];
    }
    
    level.firefly_boss_powerups = function_5713d46873b29625( level.firefly_boss_powerups );
    
    if ( level.firefly_boss_powerups.size <= 0 )
    {
        var_38b7db984cd651c1 = powerups::powerup_drop( "full_ammo", structs[ 0 ].origin, 45, undefined, "quest" );
        var_38b7d8984cd64b28 = powerups::powerup_drop( "full_armor", structs[ 1 ].origin, 45, undefined, "quest" );
        
        if ( var_38b7db984cd651c1 )
        {
            level.firefly_boss_powerups[ level.firefly_boss_powerups.size ] = var_38b7db984cd651c1;
        }
        
        if ( var_38b7d8984cd64b28 )
        {
            level.firefly_boss_powerups[ level.firefly_boss_powerups.size ] = var_38b7d8984cd64b28;
        }
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x8bfda4b6, Offset: 0x3549
// Size: 0x212
function private on_vehicle_imbued( params )
{
    vehicle = params.vehicle;
    pluto_veh::set_vehicle_usable_state( vehicle, 1 );
    
    if ( isdefined( vehicle.var_b59ff7c648465b45 ) )
    {
        [[ vehicle.var_b59ff7c648465b45 ]]( vehicle, 1 );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level utility::flag_set( "directed_use_ae" );
        function_ecc91637c2a6fbb1();
    }
    
    while ( vehicle utility::ent_flag( "aetheric_energy_imbued" ) )
    {
        playfxontag( level._effect[ "wonder_energy_pulse" ], level.wonder_veh, "tag_origin" );
        params.vehicle playsound( #"hash_b8c4ec4aa73e90d4" );
        vehicle = params.vehicle;
        nearby_ai = getaiarrayinradius( vehicle.origin, 350, zm_utility::get_zombie_team() );
        damage = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", zm_utility::get_round_number() );
        
        foreach ( zombie in nearby_ai )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            damage_mult = 1;
            
            if ( zombie.aicategory != "normal" )
            {
                damage_mult = 0.25;
            }
            
            zombie dodamage( int( damage * damage_mult ), zombie.origin, self.mdl, self.mdl, "MOD_UNKNOWN", level.weaponnone, "none", undefined, 65536 );
            waitframe();
        }
        
        wait 5;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level utility::flag_clear( "directed_pickup_ae" );
        level utility::flag_clear( "directed_use_ae" );
        function_ecc91637c2a6fbb1();
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x7deb01fd, Offset: 0x3763
// Size: 0x40
function private function_b80976b7930587b4()
{
    if ( isdefined( level.directed_mode ) || getdvarint( @"hash_6dc3ee14c4a05c36", 0 ) )
    {
        return 15;
    }
    
    if ( level.players.size == 1 )
    {
        return 25;
    }
    
    return 30;
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xf00fada5, Offset: 0x37ab
// Size: 0xc9
function private function_82d79b414f7830b0( var_415fcbcfd1b4ef03 = 1 )
{
    level notify( #"warp_to_boss" );
    s_respawn_group = zone_manager::function_9dd25e9fb0ecd45b( "zone_boss_arena" );
    
    foreach ( i, player in level.players )
    {
        player thread function_cd96995d9a559038( s_respawn_group[ 0 ].var_f448a26cf56f4a2a[ i ], var_415fcbcfd1b4ef03 );
    }
    
    waitframe();
    
    if ( var_415fcbcfd1b4ef03 )
    {
        wait 5;
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 2, eflags: 0x4
// Checksum 0x4bfccc4f, Offset: 0x387c
// Size: 0x211
function private function_cd96995d9a559038( var_e94b45e0030d64e4, var_415fcbcfd1b4ef03 )
{
    self endon( #"disconnect" );
    
    if ( !isalive( self ) || self.sessionstate == "spectator" )
    {
        thread playerlogic::spawnclient();
        
        if ( !isalive( self ) || self.sessionstate == "spectator" )
        {
            utility::waittill_any_timeout( 5, "spawned_player" );
        }
    }
    
    if ( player::isinlaststand( self ) )
    {
        laststand::exit( "last_stand_revived", self );
    }
    
    if ( !isalive( self ) || self.sessionstate == "spectator" )
    {
        thread playerlogic::spawnclient();
        
        if ( !isalive( self ) || self.sessionstate == "spectator" )
        {
            utility::waittill_any_timeout( 5, "spawned_player" );
        }
    }
    
    self setadditionalstreamposuntilcleared( var_e94b45e0030d64e4.origin );
    
    if ( var_415fcbcfd1b4ef03 )
    {
        thread zm_fasttravel::function_8649f9a98d2d9ce3();
        thread zm_fasttravel::set_player_vars( 1 );
        thread zm_fasttravel::fasttravel_teleport_vortex( var_e94b45e0030d64e4, 1, undefined, 1, 0 );
    }
    else if ( isalive( self ) && self.sessionstate != "spectator" )
    {
        self dontinterpolate();
        self setorigin( var_e94b45e0030d64e4.origin );
        angles = var_e94b45e0030d64e4.angles ?? ( 0, 0, 0 );
        self setplayerangles( angles );
    }
    
    wait 0.5;
    
    if ( self.vehicle )
    {
        thread vehicle_occupancy::exit( self.vehicle, undefined, self, undefined, 1 );
    }
    
    self.var_7ab4c9acb317c405 = var_e94b45e0030d64e4.origin;
    level.s_firefly_boss.var_be82617e5e8087bd = arraycombineunique( level.s_firefly_boss.var_be82617e5e8087bd, [ self ] );
    wait 4.55;
    
    if ( var_415fcbcfd1b4ef03 )
    {
        thread zm_utility::white_screen_flash( level.framedurationseconds, level.framedurationseconds, 1, 0.5 );
        waitframe();
        thread zm_fasttravel::set_player_vars( 0 );
    }
    
    self clearadditionalstreampos();
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x18a64a10, Offset: 0x3a95
// Size: 0x346
function private spawn_boss_model( n_round )
{
    if ( !isdefined( level.s_firefly_boss.s_boss_pos ) )
    {
        level.s_firefly_boss.s_boss_pos = utility::getstruct( "firefly_boss_spawn_pos", "targetname" );
    }
    
    if ( isalive( level.s_firefly_boss.entity ) )
    {
        level.s_firefly_boss.entity.origin = level.s_firefly_boss.s_boss_pos.origin;
    }
    
    while ( !isalive( level.s_firefly_boss.entity ) || level.s_firefly_boss.entity.aicategory != "boss" )
    {
        level.s_firefly_boss.entity = agent_manager::spawn_agent( "zombie_hermes", level.s_firefly_boss.s_boss_pos.origin, level.s_firefly_boss.s_boss_pos.angles, zm_utility::get_zombie_team() );
        
        if ( !isdefined( level.s_firefly_boss.entity ) )
        {
            waitframe();
            continue;
        }
        
        level.s_firefly_boss.entity.targetname = "FIREFLY_BOSS";
        level.s_firefly_boss.entity.var_1f6335e27ced5dca = 1;
        n_round = max( n_round, function_b80976b7930587b4() );
        
        if ( level.s_firefly_boss.entity zombie_utils::get_zombie_round_difficulty() < n_round )
        {
            level.s_firefly_boss.entity zombie_utils::set_zombie_round_difficulty( n_round, 0, 1 );
        }
        
        level.s_firefly_boss.entity.var_7b6457a80abc9e9c = &function_acf02770d0dc43ac;
        level.s_firefly_boss.entity.adds_get_speed = &get_zombie_base_speed;
        level thread function_e9df79d010cc022f( level.s_firefly_boss.entity );
        
        if ( getdvarint( @"hash_d7808a252138594e", 1 ) > 0 )
        {
            level thread scene::play( level.s_firefly_boss.entity, undefined, "sat_cin_zm_fly_boss_intro" );
            level.s_firefly_boss.entity utility::function_7c10ea82c1e305b8( "idle_intro", "on" );
        }
        
        foreach ( player in level.players )
        {
            player zombie_boss_healthbar::zombie_boss_healthbar_hide();
            player utility::player_prestream_assets( "firefly_boss", "entity", level.s_firefly_boss.entity, 2000 );
        }
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x5816f1d6, Offset: 0x3de3
// Size: 0xe1
function private function_af128c8a75662591()
{
    params = spawnstruct();
    params.timestamp = gettime();
    params.questname = #"zm_sat_firefly_mq";
    params.is_main_quest = 1;
    
    if ( isdefined( level.s_firefly_boss.var_be82617e5e8087bd ) )
    {
        level.s_firefly_boss.var_be82617e5e8087bd = function_5713d46873b29625( level.s_firefly_boss.var_be82617e5e8087bd );
        params.var_be82617e5e8087bd = level.s_firefly_boss.var_be82617e5e8087bd;
        level callback::callback( #"zm_mq_quest_complete", params );
        params.event = #"zm_mq_quest_complete";
        level callback::callback( #"hash_6c71d319dc089c27", params );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 2
// Checksum 0x9c65ef80, Offset: 0x3ecc
// Size: 0x37e
function function_aa17fa7583dcf3bd( var_61718866e365d0f9 = 0, var_de762017d6a9cac6 = 1 )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player::isinlaststand( player ) )
        {
            player laststand::exit( "last_stand_revived", player );
        }
    }
    
    if ( var_61718866e365d0f9 )
    {
        level zm_sat_firefly_script_mq::function_e4ec6c7611abdf7d();
        prestream_time = 15;
        level zm_sat_firefly_script_mq::prestream_igc( prestream_time );
    }
    
    if ( var_de762017d6a9cac6 )
    {
        var_200db2f4cdd3316 = 3;
        var_9951f0ae0474327d = 2;
        wait var_200db2f4cdd3316;
        
        foreach ( player in level.players )
        {
            level thread utility::fadetoblackforplayer( player, 1, var_9951f0ae0474327d );
        }
        
        wait var_9951f0ae0474327d;
        wait 1;
        
        foreach ( player in level.players )
        {
            level thread utility::fadetoblackforplayer( player, 0, 1 );
            
            if ( var_61718866e365d0f9 )
            {
                player utility::hidehudenable();
            }
        }
    }
    
    level val::reset( "task_firefly_final_boss", "task_logic_activate" );
    level.var_654073823a58b613 = undefined;
    utility::flag_set( "firefly_final_cutscene_done" );
    utility::flag_clear( "firefly_boss_fight_start" );
    level.var_9075568a1189c7c9 = undefined;
    
    foreach ( player in level.players )
    {
        player function_d88e8eab88c50c13( 0 );
        
        if ( player.vehicle )
        {
            thread vehicle_occupancy::exit( player.vehicle, undefined, player, undefined, 1 );
        }
    }
    
    if ( isalive( level.s_firefly_boss.entity ) )
    {
        level.s_firefly_boss.entity notify( #"end_fake_death" );
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.var_7ab4c9acb317c405 = undefined;
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1
// Checksum 0x12617b7c, Offset: 0x4252
// Size: 0xc5
function function_ecc91637c2a6fbb1( aetheric_energy_loc )
{
    if ( level utility::flag( "directed_end_boss" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"firefly_boss_fight_guidance", #"directed_end_boss" );
    }
    
    if ( level utility::flag( "directed_use_ae" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"firefly_boss_fight_guidance", #"directed_use_ae" );
        return;
    }
    
    if ( level utility::flag( "directed_pickup_ae" ) )
    {
        level thread zm_quest::update_guidance( [ [ aetheric_energy_loc ] ], #"firefly_boss_fight_guidance", #"directed_pickup_ae" );
        return;
    }
    
    if ( level utility::flag( "directed_damage_boss" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"firefly_boss_fight_guidance", #"directed_damage_boss" );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x29e44e68, Offset: 0x431f
// Size: 0x67
function private function_a70f201acfecb1f1( sparams )
{
    if ( !zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    if ( sparams.var_e3b7316c4c6ad3f9 )
    {
        level utility::flag_clear( "directed_use_ae" );
        function_ecc91637c2a6fbb1();
        return;
    }
    
    aetheric_energy_loc = sparams.energy_ref;
    level utility::flag_set( "directed_pickup_ae" );
    function_ecc91637c2a6fbb1( aetheric_energy_loc );
}

// Namespace zm_sat_firefly_boss_fight
// Params 1
// Checksum 0xa76c98fb, Offset: 0x438e
// Size: 0x139
function function_e83b11eb8fabc062( params = [] )
{
    if ( arraycontains( params, "weapons" ) )
    {
        level thread function_5f0a50b61f3da74c();
        params = arrayremove( params, "weapons" );
    }
    
    n_round = function_b80976b7930587b4();
    
    foreach ( param in params )
    {
        if ( issubstr( param, "round" ) )
        {
            n_round = int( removesubstr( param, "round" ) );
        }
    }
    
    zm_round_logic::function_68bdb49c82c0f892( n_round );
    level.var_5b30c08562022091 = n_round;
    level.var_8bd966e8e0c1bbaa = 1;
    
    if ( arraycontains( params, "natural" ) )
    {
        zm_utility::open_sesame();
        level.wonder_veh.stagerequested = 4;
        zm_quest::function_11b75e2232ce3d4( [ "TME_collection", 1 ] );
        return;
    }
    
    level thread start_boss_fight();
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x232e4db8, Offset: 0x44cf
// Size: 0x7b
function private function_5f0a50b61f3da74c()
{
    foreach ( player in level.players )
    {
        player thread function_e5292169f3b94171();
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x4e9ac480, Offset: 0x4552
// Size: 0x2f6
function private function_e5292169f3b94171()
{
    self notify( #"hash_6849729ac4fbddec" );
    self endon( #"hash_6849729ac4fbddec" );
    player = self;
    player zombie_augments::function_eae5368ab01aaa9f();
    player zombie_augments::function_6dec499dd490fc54();
    player zombie_augments::function_ae34f860566cce0b( 1, 1 );
    player equipment_mp::giveequipment( "equip_blackhole_bomb", "secondary" );
    
    if ( getdvarint( @"hash_348d280a97829389", 0 ) || getdvarint( @"hash_6dc3ee14c4a05c36", 0 ) )
    {
        var_1ae6ccd39356a608 = 3;
        n_power_level = 2;
    }
    else
    {
        var_1ae6ccd39356a608 = 4;
        n_power_level = 3;
    }
    
    ammo_mods = [ "brainrot", "deadwire", "napalmburst", "cryofreeze", "shadowvortex", "lightray" ];
    killstreaks = [ "dawg" ];
    super_power = utility::array_random( [ "super_aether_shroud" ] );
    thread perkpackage::perkpackage_givedebug( super_power );
    
    if ( laststand::function_7072b516e6cffb7c() == 0 )
    {
        player laststand::function_a2e03a85015b1897();
    }
    
    player zombie_perks::take_all_perks();
    player zombie_perks::give_perk( "specialty_juggernog" );
    player zombie_perks::give_perk( "specialty_quickrevive" );
    player zombie_perks::give_perk( "specialty_speedcola" );
    player zombie_perks::give_perk( "specialty_staminup" );
    player zombie_perks::give_perk( "specialty_elemental_pop" );
    player zombie_perks::give_perk( "specialty_phd_flopper" );
    player zombie_perks::give_perk( "specialty_death_perception" );
    player zombie_perks::give_perk( "specialty_deadshot" );
    player zombie_perks::give_perk( "specialty_m_mod" );
    player zombie_perks::give_perk( "specialty_d_mod" );
    player zombie_perks::give_perk( "specialty_w_mod" );
    player zombie_perks::give_perk( "specialty_vulture_aid" );
    player namespace_74c85f0ddf2d285f::function_fdbe2cad6d8bb7e7( 3 );
    player armor::setarmorhealth( player.maxarmorhealth );
    player armor::function_164c824617d7e8d7( armor::function_db9ebf086f67fe92() );
    player currency::add_currency_amount( #"essence", 50000 );
    player killstreaks::awardkillstreak( utility::array_random( killstreaks ), "other", undefined, undefined, undefined, 1 );
    player thread zm::function_53cd25a30a3920a();
    weapon = player function_cb38c050042391c5();
    player item_weapon::function_40e1cbd0e1f47d1a( weapon, var_1ae6ccd39356a608 );
    weapon = player pack_a_punch::pap_weapon( weapon, int( max( n_power_level - 1, 0 ) ) );
    player function_692765e1fece04ba( weapon, ammo_mods );
    
    if ( isarray( weapon ) && isweapon( weapon[ 1 ] ) )
    {
        weapon = weapon[ 1 ];
    }
    else
    {
        weapon = player function_cb38c050042391c5();
    }
    
    weapon = player pack_a_punch::pap_weapon( weapon, int( max( n_power_level - 1, 0 ) ) );
    player item_weapon::function_40e1cbd0e1f47d1a( weapon, var_1ae6ccd39356a608 );
    player function_692765e1fece04ba( weapon, ammo_mods );
    wait 10;
    player thread zm::function_1693f9e934b707ea( undefined, n_power_level );
    player thread zm::function_1693f9e934b707ea( undefined, n_power_level );
}

// Namespace zm_sat_firefly_boss_fight
// Params 2, eflags: 0x4
// Checksum 0x88f2d6a4, Offset: 0x4850
// Size: 0x6a
function private function_692765e1fece04ba( weapon, ammo_mods )
{
    ammomodname = utility::array_random( ammo_mods );
    var_ace202d0c6b9306a = 0;
    
    while ( !isdefined( level.ammo_mods[ ammomodname ] ) )
    {
        ammomodname = utility::array_random( ammo_mods );
        var_ace202d0c6b9306a++;
        
        if ( var_ace202d0c6b9306a > 10 )
        {
            ammomodname = undefined;
        }
    }
    
    ammo_mod::add_ammo_mod_to_weapon( weapon, ammomodname );
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xc7124145, Offset: 0x48c2
// Size: 0x35
function private function_cb38c050042391c5()
{
    self endon( #"disconnect" );
    currentweapon = self getcurrentweapon();
    
    while ( isnullweapon( currentweapon ) )
    {
        currentweapon = self getcurrentweapon();
        waitframe();
    }
    
    return currentweapon;
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xaadc7936, Offset: 0x4900
// Size: 0x712
function private spawn_adds()
{
    level.s_firefly_boss.entity endon( #"death" );
    level.s_firefly_boss.entity endon( #"fake_death" );
    level waittill( #"firefly_boss_intro_done" );
    wait 10;
    
    while ( true )
    {
        if ( level.s_firefly_boss.entity utility::ent_flag( "pause_add_spawning" ) )
        {
            waitframe();
            continue;
        }
        
        if ( getdvarint( @"hash_b1f22d7a8d4eb2df", 0 ) > 0 )
        {
            waitframe();
            continue;
        }
        
        player_count = 0;
        
        foreach ( player in level.players )
        {
            if ( zm_utility::is_player_valid_target( player ) )
            {
                player_count += 1;
            }
        }
        
        subclass_spawns = [ "zombie_base", "zombie_base_armored_heavy", "zombie_shade" ];
        var_ec74c3bcdf361692 = [ 35, 30, 30 ];
        elite_index = subclass_spawns.size;
        var_d4e9f9731be0a456 = 3;
        var_7389b8cab3df9017 = 1;
        elite_num = 0;
        nearby_ai = getaiarrayinradius( level.s_firefly_boss.entity.origin, 3000 );
        
        foreach ( ai in nearby_ai )
        {
            if ( ai.aicategory === "elite" )
            {
                elite_num += 1;
            }
        }
        
        elite_subclass = "zombie_callisto";
        
        if ( zm_utility::get_round_number() < 50 && level.players.size == 1 && !level.var_81dc9de2fda86a3f )
        {
            var_7389b8cab3df9017 = 0;
        }
        
        if ( zm_utility::get_round_number() >= 50 && zm_utility::get_round_number() < 100 )
        {
            var_7389b8cab3df9017 = 1;
            var_d4e9f9731be0a456 = 2;
            
            if ( level.players.size == 1 && !level.var_81dc9de2fda86a3f )
            {
                var_7389b8cab3df9017 = 0;
            }
        }
        else if ( zm_utility::get_round_number() >= 100 && zm_utility::get_round_number() < 115 )
        {
            if ( level.players.size <= 1 )
            {
                var_7389b8cab3df9017 = 1;
            }
            else
            {
                var_7389b8cab3df9017 = 2;
            }
            
            var_d4e9f9731be0a456 = 2;
        }
        else if ( zm_utility::get_round_number() >= 115 )
        {
            if ( level.players.size <= 1 )
            {
                var_7389b8cab3df9017 = 1;
            }
            else
            {
                var_7389b8cab3df9017 = 2;
            }
            
            var_d4e9f9731be0a456 = 2;
            elite_subclass = "zombie_callisto_hvt";
        }
        
        if ( elite_num < var_7389b8cab3df9017 && zombie_hermes_aetheric_energy::get_hermes_phase( level.s_firefly_boss.entity ) >= var_d4e9f9731be0a456 )
        {
            subclass_spawns[ subclass_spawns.size ] = elite_subclass;
            var_ec74c3bcdf361692[ var_ec74c3bcdf361692.size ] = 5;
        }
        
        var_f9ba21168ef176ec = [ getdvarint( @"hash_4a09dfe82ba48e6a", 8 ), getdvarint( @"hash_4a09dee82ba48c37", 8 ), getdvarint( @"hash_4a09dde82ba48a04", 10 ), getdvarint( @"hash_4a09dce82ba487d1", 10 ) ];
        adds_number = var_f9ba21168ef176ec[ int( clamp( level.players.size - 1, 0, 3 ) ) ];
        var_ac9ed585e934e589 = [ 30, 15, 15, 15 ];
        adds_pause = var_ac9ed585e934e589[ int( clamp( level.players.size - 1, 0, 3 ) ) ];
        max_zombie_count = 35;
        add_i = 0;
        
        while ( add_i < adds_number )
        {
            chosen_subclass = utility::random_weighted( subclass_spawns, var_ec74c3bcdf361692 );
            spawn_loc_spawner = chosen_subclass;
            
            if ( spawn_loc_spawner == "zombie_callisto_hvt" )
            {
                spawn_loc_spawner = "zombie_callisto";
            }
            
            var_395649a1ecde9e39 = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_boss_arena" ], spawn_loc_spawner );
            assert( var_395649a1ecde9e39 );
            spawn_loc = utility::array_random( var_395649a1ecde9e39 );
            
            for ( active_zombie_count = zm_utility::get_active_zombies_count(); active_zombie_count >= max_zombie_count ; active_zombie_count = zm_utility::get_active_zombies_count() )
            {
                waitframe();
            }
            
            zombie_aitype = function_b3988325430ce242( chosen_subclass );
            zombie = undefined;
            
            if ( isvector( spawn_loc.origin ) )
            {
                zombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( zombie_aitype, spawn_loc.origin, spawn_loc.angles, level.s_firefly_boss.entity.team );
            }
            
            if ( isdefined( zombie ) )
            {
                zombie thread agent_spawner::function_ce10e453e7f7bb8e( spawn_loc );
                zombie zombie_utils::set_zombie_round_difficulty( level.s_firefly_boss.entity zombie_utils::get_zombie_round_difficulty(), 1, 1 );
                zombie function_7f8988ce63c1623d( 0 );
                zombie utility::delaycallendon( 5, "death", &function_7f8988ce63c1623d, 1 );
                zombie.no_powerups = 1;
                
                if ( isdefined( level.s_firefly_boss.entity.var_7b6457a80abc9e9c ) )
                {
                    zombie.var_50c96a5c56dab386 = level.s_firefly_boss.entity.var_7b6457a80abc9e9c;
                }
                
                speed = zombie get_zombie_base_speed();
                zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( speed == "super_sprint" || speed == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && speed == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && speed == "sprint" ? "run" : speed, "topaz_boss", 6 );
                
                if ( chosen_subclass == elite_subclass )
                {
                    subclass_spawns[ elite_index ] = undefined;
                    
                    if ( isint( elite_index ) )
                    {
                        function_cdc669dbc8ea2101( subclass_spawns );
                    }
                    
                    var_ec74c3bcdf361692[ elite_index ] = undefined;
                    
                    if ( isint( elite_index ) )
                    {
                        function_cdc669dbc8ea2101( var_ec74c3bcdf361692 );
                    }
                }
                
                /#
                    sphere( spawn_loc.origin, 10, ( 1, 0, 0 ), 2, 10 );
                #/
            }
            
            waitframe();
            add_i += 1;
        }
        
        wait adds_pause;
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x75c231a7, Offset: 0x501a
// Size: 0x2d
function private function_6b01801b08f66717()
{
    if ( zm_utility::get_round_number() >= 100 )
    {
        zm_lighting_visionset::set_special_round_visionset();
        overlord::playevent( "zm_special_round_start_vo", level.players, undefined, 1 );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x5354c70c, Offset: 0x504f
// Size: 0x15
function private function_9504b8fbe743abec()
{
    if ( zm_utility::get_round_number() >= 100 )
    {
        zm_lighting_visionset::function_48532c8b58f4b0b3();
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x9296a4f5, Offset: 0x506c
// Size: 0x159
function private function_acf02770d0dc43ac()
{
    zombie_droplist = "zm_sat_firefly_boss_fight_normal_item_list";
    
    if ( self.aicategory == "normal" )
    {
        attacker = isdefined( self.last_dmg_struct ) ? self.last_dmg_struct.eattacker : undefined;
        var_55f94a869dd7e4d5 = isplayer( attacker ) && attacker armor::function_22290101992e4874() <= 1;
        var_476fe576f05a4c8f = isplayer( attacker ) && attacker currency::get_currency_amount( #"salvage" ) < 1000;
        
        if ( isstartstr( self.subclass, "zombie_base_armored" ) && var_55f94a869dd7e4d5 )
        {
            zombie_droplist = "zm_sat_firefly_boss_fight_normal_armored_item_list";
        }
        else if ( var_476fe576f05a4c8f && function_1674ad84bafdd078() )
        {
            zombie_droplist = "zm_sat_firefly_boss_fight_normal_low_salvage_item_list";
        }
    }
    else if ( self.aicategory == "special" )
    {
    }
    else if ( self.aicategory == "elite" )
    {
    }
    
    var_245f1c4b1d5b3e81 = 1;
    zombie_droppos = self.origin;
    zombie_droplist_params = { #droppos:zombie_droppos ?? self.origin, #dropquantity:var_245f1c4b1d5b3e81, #droplist:zombie_droplist };
    return zombie_droplist_params;
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x664f6634, Offset: 0x51ce
// Size: 0xb4
function private function_1674ad84bafdd078()
{
    var_d244414fcb33ce3 = 0;
    nearby_vehicles = vehicle_getarrayinradius( self.origin, 3000 );
    
    foreach ( vehicle in nearby_vehicles )
    {
        if ( vehicle utility::function_9f2c41c1dcc8c94( "single", "vehicle_unusable" ) )
        {
            var_d244414fcb33ce3 = 1;
            continue;
        }
        
        var_d244414fcb33ce3 = 0;
        break;
    }
    
    return var_d244414fcb33ce3;
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x9dc1d326, Offset: 0x528b
// Size: 0xa6
function private function_1aa6798c6e512797( params )
{
    if ( isdefined( level.wonder_veh ) )
    {
        level.wonder_veh vehicle_damage::set_health( clamp( level.wonder_veh.health + 0.4 * level.wonder_veh.maxhealth, 0, level.wonder_veh.maxhealth ) );
        
        if ( isdefined( level.wonder_veh.var_b59ff7c648465b45 ) )
        {
            [[ level.wonder_veh.var_b59ff7c648465b45 ]]( level.wonder_veh, 1 );
        }
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x209fb438, Offset: 0x5339
// Size: 0x25
function private function_2ed0e66395a9201a( params )
{
    self.no_powerups = 1;
    self.var_50c96a5c56dab386 = &function_acf02770d0dc43ac;
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xaf0ac308, Offset: 0x5366
// Size: 0x82
function private function_e9df79d010cc022f( boss )
{
    boss endon( #"death" );
    var_f342a872dffd84b0 = utility::getstructarray( "boss_arena_start_pos", "targetname" );
    start_pos = var_f342a872dffd84b0[ 0 ].origin;
    
    while ( true )
    {
        if ( boss.origin[ 2 ] < start_pos[ 2 ] - 500 )
        {
            boss forceteleport( start_pos, self.angles );
        }
        
        wait 2;
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x9cd6daa5, Offset: 0x53f0
// Size: 0xe0
function private function_e4e3ee7973fee3af()
{
    self notify( #"hash_ae98b084ca511aca" );
    self endon( #"hash_ae98b084ca511aca" );
    level.s_firefly_boss.entity endon( #"death" );
    utility::flag_wait( "playing_game_over_scene" );
    level.s_firefly_boss.entity utility::function_32b24db3127bff40( "head_back_ri", "attached" );
    wait 0.5;
    utility::array_thread( level.players, &zombie_boss_healthbar::zombie_boss_healthbar_hide );
    wait 0.5;
    utility::array_thread( level.players, &zombie_boss_healthbar::zombie_boss_healthbar_hide );
    wait 0.5;
    utility::array_thread( level.players, &zombie_boss_healthbar::zombie_boss_healthbar_hide );
    wait 0.5;
    utility::array_thread( level.players, &zombie_boss_healthbar::zombie_boss_healthbar_hide );
    utility::flag_waitopen( "playing_game_over_scene" );
}

// Namespace zm_sat_firefly_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x2a6ec164, Offset: 0x54d8
// Size: 0x74
function private on_hermes_vehicle_modified( params )
{
    if ( getdvarint( @"hash_20117777223356d5", 1 ) > 0 )
    {
        return;
    }
    
    driver = vehicle_occupancy::get_driver( params.vehicle, 1 );
    
    if ( driver )
    {
        pbgpostfxbundlestart( driver, "sat_zm_firefly_boss_pluto_speed_effect" );
        params.vehicle waittill( #"hash_7e2220d729fcacbd" );
        pbgpostfxbundleend( driver, "sat_zm_firefly_boss_pluto_speed_effect" );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 0
// Checksum 0x2539a832, Offset: 0x5554
// Size: 0xcb
function vo_boss_fight_start()
{
    level waittill( #"firefly_boss_intro_done" );
    level.s_firefly_boss.entity dialogue::say( "dx_zm_ffmn_8fbf_ssff_ffm8s" );
    wait 1.2;
    var_379f0fd057ff9fde = function_1b9aca015902dbdf();
    var_23678b38e8a299c4 = namespace_c0b4f2882c9d100f::get_tedd_players( 1 );
    player_tedd = utility::array_random( var_23678b38e8a299c4 );
    
    if ( isdefined( var_379f0fd057ff9fde ) )
    {
        var_379f0fd057ff9fde namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"boss_fight_start_operator" );
        return;
    }
    
    if ( isdefined( player_tedd ) )
    {
        player_tedd namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"boss_fight_start_silver" );
        return;
    }
    
    level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_fb14862dddae3c59" );
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x274cb343, Offset: 0x5627
// Size: 0xc5
function private function_1b9aca015902dbdf()
{
    var_52a111264f33ff56 = [];
    
    foreach ( player in level.players )
    {
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() && zm_utility::is_player_valid_target( player ) && !player::isinlaststand( player ) )
        {
            var_52a111264f33ff56[ var_52a111264f33ff56.size ] = player;
        }
    }
    
    if ( var_52a111264f33ff56.size > 0 )
    {
        var_4efaf33c51758bd7 = utility::array_random( var_52a111264f33ff56 );
        return var_4efaf33c51758bd7;
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1
// Checksum 0xd73af31a, Offset: 0x56f4
// Size: 0x36
function vo_player_downed( params )
{
    if ( utility::percent_chance( 100 ) )
    {
        level.s_firefly_boss.entity dialogue::say( "dx_zm_ffmn_8fbf_ssff_ffm8pd" );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1
// Checksum 0xe0c42007, Offset: 0x5732
// Size: 0x165
function function_87a73669d70840cb( sparams )
{
    self notify( #"hash_90a58eaa1935bc48" );
    self endon( #"hash_90a58eaa1935bc48" );
    self endon( #"death" );
    var_abbebdb114e4f57f = sparams.phase;
    level utility::flag_set( "vo_invulnerable_state_playing" );
    wait 3;
    var_379f0fd057ff9fde = function_1b9aca015902dbdf();
    var_23678b38e8a299c4 = namespace_c0b4f2882c9d100f::get_tedd_players( 1 );
    player_tedd = utility::array_random( var_23678b38e8a299c4 );
    
    if ( var_abbebdb114e4f57f == 1 )
    {
        if ( isdefined( var_379f0fd057ff9fde ) )
        {
            var_379f0fd057ff9fde namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_3f45acb1585401ba" );
        }
        else if ( isdefined( player_tedd ) )
        {
            player_tedd namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_28a386ad87a8fb13" );
        }
        else
        {
            level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_84bdcdefcb5c9433" );
        }
    }
    else if ( isdefined( var_379f0fd057ff9fde ) )
    {
        var_379f0fd057ff9fde namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_3f45abb158540007" );
    }
    else if ( isdefined( player_tedd ) )
    {
        player_tedd namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_28a387ad87a8fcc6" );
    }
    else
    {
        level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_84bdceefcb5c95e6" );
    }
    
    level utility::flag_clear( "vo_invulnerable_state_playing" );
}

// Namespace zm_sat_firefly_boss_fight
// Params 1
// Checksum 0x407b6f9, Offset: 0x589f
// Size: 0x63
function function_50d136e458aa9204( params )
{
    if ( isdefined( level.s_firefly_boss.entity ) )
    {
        if ( utility::percent_chance( 100 ) && !level.var_e6cea7326a2579cc )
        {
            level thread function_6eaabbafc0677a7a();
            level.s_firefly_boss.entity dialogue::say( "dx_zm_ffmn_8fbf_ssff_ffm8sel" );
        }
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1
// Checksum 0xd8bc8d20, Offset: 0x590a
// Size: 0x66
function vo_launch_zombie_attack( params )
{
    wait 1;
    
    if ( isdefined( level.s_firefly_boss.entity ) )
    {
        if ( utility::percent_chance( 100 ) && !level.var_14e2a0b03915aee7 )
        {
            level thread function_8c4400db94b9a7ef();
            level.s_firefly_boss.entity dialogue::say( "dx_zm_ffmn_8fbf_ssff_ffm8sz" );
        }
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1
// Checksum 0x484fe30a, Offset: 0x5978
// Size: 0x42
function vo_ufo_attack( params )
{
    if ( isdefined( level.s_firefly_boss.entity ) )
    {
        level.s_firefly_boss.entity dialogue::say( "dx_zm_ffmn_8fbf_ssff_ffm8vt" );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1
// Checksum 0xc4ad8fc8, Offset: 0x59c2
// Size: 0x63
function vo_shadow_soul_beam_attack( params )
{
    if ( isdefined( level.s_firefly_boss.entity ) )
    {
        if ( utility::percent_chance( 100 ) && !level.var_69d51e629d79676b )
        {
            level thread function_df06479aecfab669();
            level.s_firefly_boss.entity dialogue::say( "dx_zm_ffmn_8fbf_ssff_ffm8ssb" );
        }
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xc8137c7d, Offset: 0x5a2d
// Size: 0x50
function private function_8c4400db94b9a7ef()
{
    level.s_firefly_boss.entity endon( #"death" );
    level endon( #"playing_game_over_scene" );
    level endon( #"firefly_boss_fight_complete" );
    level.var_14e2a0b03915aee7 = 1;
    wait 10;
    level.var_14e2a0b03915aee7 = 0;
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xcfd998a8, Offset: 0x5a85
// Size: 0x50
function private function_df06479aecfab669()
{
    level.s_firefly_boss.entity endon( #"death" );
    level endon( #"playing_game_over_scene" );
    level endon( #"firefly_boss_fight_complete" );
    level.var_69d51e629d79676b = 1;
    wait 10;
    level.var_69d51e629d79676b = 0;
}

// Namespace zm_sat_firefly_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x4a56fee, Offset: 0x5add
// Size: 0x50
function private function_6eaabbafc0677a7a()
{
    level.s_firefly_boss.entity endon( #"death" );
    level endon( #"playing_game_over_scene" );
    level endon( #"firefly_boss_fight_complete" );
    level.var_e6cea7326a2579cc = 1;
    wait 10;
    level.var_e6cea7326a2579cc = 0;
}

// Namespace zm_sat_firefly_boss_fight
// Params 0
// Checksum 0xd0f78e4f, Offset: 0x5b35
// Size: 0xa5
function function_768d3a0b57154613()
{
    if ( !isalive( level.s_firefly_boss.entity ) )
    {
        e_boss_vo = utility::spawn_model( "tag_origin", level.s_firefly_boss.entity.origin, level.s_firefly_boss.entity.angles );
        e_boss_vo dialogue::say( "dx_zm_ffmn_8fbf_ssff_ffm8sd" );
        e_boss_vo delete();
        return;
    }
    
    level.s_firefly_boss.entity dialogue::say( "dx_zm_ffmn_8fbf_ssff_ffm8sd" );
}

// Namespace zm_sat_firefly_boss_fight
// Params 1
// Checksum 0x26438ef1, Offset: 0x5be2
// Size: 0x62
function vo_boss_aetheric_energy_pickup( params )
{
    if ( !utility::flag( "vo_invulnerable_state_playing" ) && !utility::flag( "aetheric_energy_vo_played" ) )
    {
        level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_c9e768eff27f3b7e" );
        utility::flag_set( "aetheric_energy_vo_played" );
    }
}

// Namespace zm_sat_firefly_boss_fight
// Params 1
// Checksum 0x1637aa5b, Offset: 0x5c4c
// Size: 0x42
function vo_boss_aetheric_energy_attack( params )
{
    if ( utility::percent_chance( 20 ) )
    {
        level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_c9e776eff27f5348" );
    }
}

/#

    // Namespace zm_sat_firefly_boss_fight
    // Params 0
    // Checksum 0x1cc1b8ff, Offset: 0x5c96
    // Size: 0x5, Type: dev
    function function_b967f2f55dce6301()
    {
        
    }

    // Namespace zm_sat_firefly_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x993ca1b6, Offset: 0x5ca3
    // Size: 0x9c, Type: dev
    function private boss_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x43>", "<dev string:x60>", &function_822c0448839cca3c );
        devgui::add_devgui_func( "<dev string:x7a>", "<dev string:x8b>", &function_2545ca0f8453be1b );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa4>", "<dev string:xb8>", &function_c72cb6137e866d01 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd0>", "<dev string:xe6>", &function_c72cb6137e866d01 );
        devgui::add_devgui_func( "<dev string:x100>", "<dev string:x11b>", &function_f2374597596880c1 );
        devgui::add_devgui_func( "<dev string:x13e>", "<dev string:x157>", &function_930f7366d8f5306d );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_firefly_boss_fight
    // Params 1, eflags: 0x4
    // Checksum 0xb17ff0f5, Offset: 0x5d47
    // Size: 0x47, Type: dev
    function private function_822c0448839cca3c( params )
    {
        level thread function_5f0a50b61f3da74c();
        n_round = zm_utility::get_round_number();
        level.var_5b30c08562022091 = n_round;
        level.var_8bd966e8e0c1bbaa = 1;
        level thread start_boss_fight();
    }

    // Namespace zm_sat_firefly_boss_fight
    // Params 0
    // Checksum 0x18599345, Offset: 0x5d96
    // Size: 0x98, Type: dev
    function function_2545ca0f8453be1b()
    {
        self notify( #"hash_c4171042fec2dc72" );
        self endon( #"hash_c4171042fec2dc72" );
        
        if ( !isdefined( level.s_firefly_boss.entity ) )
        {
            return;
        }
        
        level.s_firefly_boss.entity.health = 2;
        level.s_firefly_boss.entity dodamage( 1, level.s_firefly_boss.entity.origin, level.players[ 0 ] );
    }

    // Namespace zm_sat_firefly_boss_fight
    // Params 1, eflags: 0x4
    // Checksum 0x9b0acd45, Offset: 0x5e36
    // Size: 0x7d, Type: dev
    function private function_c72cb6137e866d01( params )
    {
        if ( !isdefined( level.s_firefly_boss.entity ) )
        {
            return;
        }
        
        n_damage = int( params[ 0 ] );
        level.s_firefly_boss.entity dodamage( n_damage, level.s_firefly_boss.entity.origin, level.players[ 0 ] );
    }

    // Namespace zm_sat_firefly_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x2ff78f5c, Offset: 0x5ebb
    // Size: 0xdb, Type: dev
    function private function_f2374597596880c1()
    {
        bot = undefined;
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                bot = player;
                break;
            }
        }
        
        if ( !bot )
        {
            iprintlnbold( "<dev string:x178>" );
            return;
        }
        
        to_boss_angles = vectortoangles( level.s_firefly_boss.entity.origin - bot geteye() );
        bot setplayerangles( to_boss_angles );
    }

    // Namespace zm_sat_firefly_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xe564a9cb, Offset: 0x5f9e
    // Size: 0x20, Type: dev
    function private function_930f7366d8f5306d()
    {
        utility::flag_set( "<dev string:x185>" );
        wait 1;
        utility::flag_clear( "<dev string:x185>" );
    }

#/
