// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_boss_fight.gsc  (hash_4ee31b8addc35fac.gscc) (size: 69848 Bytes / 0x110d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x108882f5 (277381877)
// size ...... 69848 (0x110d8)
// includes .. 70  (offset: 0xfedc)
// strings ... 211 (offset: 0x1010c)
// dev strs .. 42  (offset: 0x10ea0)
// exports ... 126 (offset: 0xb018)
// cseg ...... 0x1324 + 0x9cf4 (0xb018)
// imports ... 454 (offset: 0xc3c8)
// animtree1 . 0   (offset: 0x110d8)
// animtree2 . 0   (offset: 0x110d8)
#using script_16ea1b94f0f381b3;
#using script_21453148428dc2c0;
#using script_26df541bce0105e;
#using script_28f8e299bbcf2c00;
#using script_2de83d6261680959;
#using script_4fb7a9021a570c8a;
#using script_69318f8d1ba7f072;
#using script_6d4c5bf7d72d6d4a;
#using script_726b7f033a90911c;
#using script_75753577a55139f3;
#using script_79edb4ed1f52fb62;
#using script_7f0fdfedd9ca7570;
#using script_aa3bac81ad4fc8e;
#using scripts\anim\dialogue;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\augments\zombie_augments;
#using scripts\mp\common\field_upgrades\field_upgrades_wiley_fox;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\powerups\full_ammo;
#using scripts\mp\common\powerups\powerups;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\overlord;
#using scripts\mp\pack_a_punch;
#using scripts\mp\playerachievements;
#using scripts\mp\playerlogic;
#using scripts\mp\weapons;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_assault_rounds;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_falling_rocks;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_mq_quest;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_necrotic_fan_create_script;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_talisman;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_ash;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\aitypes\zm_zombie_diana;
#using scripts\mp\zm\systems\items\zm_item_ammo;
#using scripts\mp\zm\systems\zm_armor;
#using scripts\mp\zm\systems\zm_exfil;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_boss_fight;

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x5
// Checksum 0x6d93ea81, Offset: 0x1342
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hornet_boss_fight", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xbdbb995, Offset: 0x136f
// Size: 0x167
function private pre_main()
{
    level.s_hornet_boss = { #var_1c20af01180087e0:[], #pause_add_spawning:0, #var_d3cb692a83b72d98:30, #var_d85a011a39aea0f1:902500, #var_7143f13768f05e8e:60, #max_zombie_count:55, #var_3a7c5451c5ba016f:[], #var_be82617e5e8087bd:[] };
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_7d1b4b7b23fd890d", &function_e83b11eb8fabc062 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_6ea9a7e922307b79", &debug_play_outro_igc );
    
    if ( getdvarint( @"hash_29d31b60035f04e8", 0 ) )
    {
        utility::delaythread( 1, &start_boss_fight );
    }
    
    thread init_boss_fight_quest();
    function_5945adbb022532ef();
    powerups::register_powerup( "hornet_firefly_boss", &function_e414f20fd70c259a, &function_6ee60d5cadd9a4e6 );
    powerups::register_powerup( "hornet_ruby_boss", &function_bac94abddc2388ed, &function_6ee60d5cadd9a4e6 );
    powerups::register_powerup( "hornet_locust_boss", &function_baf213ed02ae7e83, &function_6ee60d5cadd9a4e6 );
    scene::add_scene_func( "sat_cin_zm_vig_death_diana", &function_993650b33e5f246e, "callback_play" );
    scene::add_scene_func( "sat_cin_zm_hornet_outro", &function_865300eb5cab0d91, "callback_play" );
    scene::add_scene_func( "sat_cin_zm_vig_plr_dth_diana", &function_7aa72deea6086933, "callback_play" );
    utility::registersharedfunc( #"hornet_boss_fight", #"start_boss_fight", &start_boss_fight );
    
    /#
        level thread boss_devgui();
    #/
}

// Namespace zm_sat_hornet_boss_fight
// Params 0
// Checksum 0xde63b3d6, Offset: 0x14de
// Size: 0x77
function function_993650b33e5f246e()
{
    function_7bd644985a4684e8();
    cleanup_all_zombies( 1, self.origin, 3000 );
    zm_quest::function_2850bf8c7015dc92( [ "zone_boss_arena", "zone_boss_arena_n", "zone_boss_arena_e", "zone_boss_arena_s", "zone_boss_arena_w", "zone_boss_arena_nw", "zone_boss_arena_sw", "zone_boss_arena_ne", "zone_boss_arena_se" ] );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0
// Checksum 0x853c48a7, Offset: 0x155d
// Size: 0x165
function function_865300eb5cab0d91()
{
    function_7bd644985a4684e8();
    
    foreach ( s_ammo_cache in level._ammo_cache_info.var_ea07e36d8fd28578 )
    {
        ammo_cache = s_ammo_cache.ammocache_trigger.var_a3338cc37b82b7b3;
        
        if ( zone_manager::function_427ae6b3bc10b5ac( ammo_cache.origin, "zone_boss_arena_sw" ) || zone_manager::function_427ae6b3bc10b5ac( ammo_cache.origin, "zone_boss_arena_ne" ) )
        {
            ammo_cache setscriptablepartstate( "base", "hidden" );
            ammo_cache setscriptablepartstate( "light", "hidden" );
        }
    }
    
    cleanup_all_zombies( 1, self.origin, 3000 );
    zm_quest::function_2850bf8c7015dc92( [ "zone_boss_arena", "zone_boss_arena_n", "zone_boss_arena_e", "zone_boss_arena_s", "zone_boss_arena_w", "zone_boss_arena_nw", "zone_boss_arena_sw", "zone_boss_arena_ne", "zone_boss_arena_se" ] );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0
// Checksum 0x940a12d1, Offset: 0x16ca
// Size: 0x77
function function_7aa72deea6086933()
{
    function_7bd644985a4684e8();
    cleanup_all_zombies( 1, self.origin, 3000 );
    zm_quest::function_2850bf8c7015dc92( [ "zone_boss_arena", "zone_boss_arena_n", "zone_boss_arena_e", "zone_boss_arena_s", "zone_boss_arena_w", "zone_boss_arena_nw", "zone_boss_arena_sw", "zone_boss_arena_ne", "zone_boss_arena_se" ] );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0
// Checksum 0x1bbe3d88, Offset: 0x1749
// Size: 0x17d
function function_7bd644985a4684e8()
{
    deactivateworldevent( "we_vfx_volcano_boss_erupt", 1 );
    deactivateworldevent( "we_vfx_volcano_boss_erupt_loop", 1 );
    deactivateworldevent( "we_vfx_volcano_boss_start", 1 );
    deactivateworldevent( "we_vfx_volcano_vista", 1 );
    
    if ( level.var_852213e2b06e3f79 )
    {
        level.var_852213e2b06e3f79 freescriptable();
    }
    
    if ( level.s_hornet_boss.entity.var_c435bf1af09a0686 )
    {
        deactivateworldevent( level.s_hornet_boss.entity.var_c435bf1af09a0686, 1 );
        level.s_hornet_boss.entity.var_c435bf1af09a0686 = undefined;
    }
    
    if ( isarray( level.s_hornet_boss.entity.var_7209b234b5b93b6f ) )
    {
        foreach ( world_event in level.s_hornet_boss.entity.var_7209b234b5b93b6f )
        {
            deactivateworldevent( world_event, 1 );
        }
        
        level.s_hornet_boss.entity.var_7209b234b5b93b6f = [];
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 3
// Checksum 0x16a38b75, Offset: 0x18ce
// Size: 0x110
function cleanup_all_zombies( var_23aaedb4d3ed1411, origin, radius )
{
    zombies = getaispeciesarray( "all", "zombie" );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) || zombie.magic_bullet_shield || zombie val::get( "damageshield" ) )
        {
            continue;
        }
        
        zombie.nocorpse = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie kill();
    }
    
    if ( var_23aaedb4d3ed1411 )
    {
        var_847d084dec62c9ef = function_955f614470e71cb2( origin, radius, 1 );
        utility::array_delete( var_847d084dec62c9ef );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xf844042b, Offset: 0x19e6
// Size: 0x12b
function private function_88ace301d085483f()
{
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie.aicategory == "boss" )
        {
            continue;
        }
        
        if ( zombie.aicategory != "elite" && zombie.aicategory != "special" )
        {
            continue;
        }
        
        if ( zombie.magic_bullet_shield || zombie.damageshield )
        {
            zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        }
        
        zombie.nocorpse = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie kill();
        waitframe();
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xad95863b, Offset: 0x1b19
// Size: 0x9
function private post_main()
{
    zm_sat_hornet_necrotic_fan_create_script::main();
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x56af12c2, Offset: 0x1b2a
// Size: 0x296
function private function_5945adbb022532ef()
{
    level.s_hornet_boss.boss_pos_a = utility::getstruct( "tag_align_hornet_boss_arena_north", "targetname" );
    
    if ( !isdefined( level.s_hornet_boss.boss_pos_a ) )
    {
        level.s_hornet_boss.boss_pos_a = { #angles:( 0, 45, 0 ), #origin:( 31165.9, 40160.2, 16570 ), #targetname:"tag_align_hornet_boss_arena_north" };
        utility::addstruct( level.s_hornet_boss.boss_pos_a );
    }
    
    level.s_hornet_boss.boss_pos_b = utility::getstruct( "tag_align_hornet_boss_arena_east", "targetname" );
    
    if ( !isdefined( level.s_hornet_boss.boss_pos_b ) )
    {
        level.s_hornet_boss.boss_pos_b = { #angles:( 0, 315, 0 ), #origin:( 31303.8, 44286.2, 16570 ), #targetname:"tag_align_hornet_boss_arena_east" };
        utility::addstruct( level.s_hornet_boss.boss_pos_b );
    }
    
    level.s_hornet_boss.var_ce151cff43b2b50 = utility::getstruct( "tag_align_hornet_boss_arena_south", "targetname" );
    
    if ( !isdefined( level.s_hornet_boss.var_ce151cff43b2b50 ) )
    {
        level.s_hornet_boss.var_ce151cff43b2b50 = { #angles:( 0, 225, 0 ), #origin:( 35408.5, 44402.8, 16570 ), #targetname:"tag_align_hornet_boss_arena_south" };
        utility::addstruct( level.s_hornet_boss.var_ce151cff43b2b50 );
    }
    
    level.s_hornet_boss.var_ce158cff43b3ab5 = utility::getstruct( "tag_align_hornet_boss_arena_west", "targetname" );
    
    if ( !isdefined( level.s_hornet_boss.var_ce158cff43b3ab5 ) )
    {
        level.s_hornet_boss.var_ce158cff43b3ab5 = { #angles:( 0, 135, 0 ), #origin:( 35546.4, 40043.5, 16570 ), #targetname:"tag_align_hornet_boss_arena_west" };
        utility::addstruct( level.s_hornet_boss.var_ce158cff43b3ab5 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1
// Checksum 0xe5f6f4bb, Offset: 0x1dc8
// Size: 0x5f7
function start_boss_fight( round_override )
{
    self notify( #"hash_b249d315bdb36eb8" );
    self endon( #"hash_b249d315bdb36eb8" );
    level endon( #"game_ended" );
    init_boss_fight_data( level.var_5b30c08562022091 );
    function_7609962a351a5650();
    level.var_e9bce67d0022b869 = 40000;
    level.var_dc81f03d76612023 = 1;
    level utility::flag_clear( "rbz_allow_exfil" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"bossfight_intro_lp" );
    level.var_852213e2b06e3f79 = spawnscriptable( "zm_sat_hornet_boss_fight_volcano_vista_audio", ( 31772, 39275, 17575 ) );
    level musicbank_utility::function_683e33ddcb824d18( #"round_start" );
    level musicbank_utility::function_683e33ddcb824d18( #"round_end" );
    n_round = round_override ?? zm_utility::get_round_number();
    
    foreach ( st_zone in [ "zone_boss_arena", "zone_boss_arena_n", "zone_boss_arena_e", "zone_boss_arena_s", "zone_boss_arena_w", "zone_boss_arena_nw", "zone_boss_arena_sw", "zone_boss_arena_ne", "zone_boss_arena_se" ] )
    {
        zone_manager::set_zone_enabled( st_zone, 1 );
    }
    
    level.var_1599a55445d3259f = level.cratedropdata.heliheight;
    level.cratedropdata.heliheight = ( 33370, 42192, 16626 )[ 2 ] + 1000;
    utility::callsharedfunc( #"zombie", #"hash_d4fd1ac4daa061c6" );
    function_2c3568bb8ce4bf7();
    
    if ( getdvarint( @"hash_29d31b60035f04e8", 0 ) || level.var_8bd966e8e0c1bbaa )
    {
        if ( !level utility::flag( "open_sesame" ) )
        {
            zm_utility::open_sesame();
        }
        
        level notify( #"restart_round" );
        n_round = level.var_5b30c08562022091 ?? function_b80976b7930587b4();
        
        if ( zm_utility::get_round_number() != n_round )
        {
            zm_round_logic::function_68bdb49c82c0f892( n_round );
            zm_round_logic::function_895fdc21ab019efe();
        }
        
        zm_utility::function_1bd2eda42461fad1( level.var_6781718da4f78d1c.roundnumber );
        
        if ( getdvarint( @"hash_29d31b60035f04e8", 0 ) && !level.var_8bd966e8e0c1bbaa )
        {
            level thread function_5f0a50b61f3da74c();
        }
        
        foreach ( player in level.players )
        {
            player thread function_a52a3295de3df985( 0 );
        }
        
        wait 1;
        level thread function_8ef95d5d6219b790();
        level.var_8bd966e8e0c1bbaa = undefined;
    }
    else
    {
        foreach ( player in level.players )
        {
            player thread function_a52a3295de3df985( 1 );
        }
    }
    
    if ( level.active_relic_challenge )
    {
        wait 1;
        level thread function_8ef95d5d6219b790();
        level.var_8bd966e8e0c1bbaa = undefined;
    }
    
    level callback::callback( "zm_mq_final_fight_start", { #timestamp:gettime() } );
    current_round = zm_utility::get_round_number();
    
    if ( level.var_a009ab14ee0d3223.isspecialround )
    {
        zm_round_logic::function_895fdc21ab019efe();
        level thread special_round_end_failsafe();
    }
    else if ( level.hornet_mq.next_assault_round == current_round )
    {
        new_special_round = current_round + 2;
        zm_sat_hornet_assault_rounds::function_52f7e142e34bc386( new_special_round );
        zm_round_spawning::function_9fd9e12523021d1d( level.hornet_mq.next_assault_round, new_special_round );
    }
    
    zm_round_spawning::pause_round_spawning( 1, "honet_boss_fight_pause_spawning" );
    level val::set( "tasks_hornet_boss_fight", "task_logic_activate", 0 );
    function_ebef81106cdde6c7( n_round );
    setup_zombie_add_data();
    level.var_9c0d12c8f8edeb3d = "sat_cin_zm_vig_plr_dth_diana";
    level.s_game_over_scene_override = utility::getstruct( "sat_cin_zm_vig_plr_dth_diana", "targetname" );
    level.var_654073823a58b613 = &function_8ee476f4ad76c216;
    level.var_9075568a1189c7c9 = 1;
    level thread function_2a2dc4458e023072();
    function_187778d499d053eb();
    thread init_pedestals();
    level utility::flag_wait( "hornet_boss_fight_intro_complete" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level utility::flag_set( "directed_damage_boss" );
        function_ecc91637c2a6fbb1();
    }
    
    level thread function_7b3a45c4fdbfc566();
    level thread function_f9d693fe94b1c1c();
    utility::array_thread( level.players, &val::reset_all, "hornet_boss_fight" );
    utility::flag_set( "hornet_boss_fight_start" );
    activateworldevent( "we_vfx_volcano_vista", 1 );
    activateworldevent( "we_vfx_volcano_boss_start", 1 );
    level.s_hornet_boss.entity thread function_8744ea5df5117a61();
    level.s_hornet_boss.entity utility::waittill_any_in_array( [ "diana_fade_in_to_death_igc_complete", "death" ] );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level utility::flag_set( "directed_end_boss" );
        function_ecc91637c2a6fbb1();
    }
    
    level.var_2d7f360a931545ed = !utility::flag_exist( "playing_game_over_scene" );
    level thread on_boss_fight_complete();
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x711bbd57, Offset: 0x23c7
// Size: 0x27
function private special_round_end_failsafe()
{
    level endon( #"hash_269834394b0cb506" );
    wait 10;
    
    if ( level utility::flag( "ar_active" ) )
    {
        zm_round_logic::function_895fdc21ab019efe();
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x1c403b72, Offset: 0x23f6
// Size: 0x2e
function private function_a52a3295de3df985( var_c8d308fc8378e610 )
{
    if ( var_c8d308fc8378e610 )
    {
        utility::waittill_notify_or_timeout( "fasttravel_start", 10 );
        wait 4;
    }
    
    if ( self )
    {
        self function_d88e8eab88c50c13( 1 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x7522c572, Offset: 0x242c
// Size: 0xb2
function private function_8744ea5df5117a61()
{
    msg = level.s_hornet_boss.entity utility::waittill_any_in_array_return( [ "diana_death_igc_transition", "death" ] );
    level notify( #"hash_a35f3533da3f5d81" );
    level zm_sat_hornet_weather_ash::function_91ad74da91af1982( [ "zone_boss_arena", "zone_boss_arena_n", "zone_boss_arena_e", "zone_boss_arena_s", "zone_boss_arena_w", "zone_boss_arena_nw", "zone_boss_arena_sw", "zone_boss_arena_ne", "zone_boss_arena_se" ] );
    
    if ( msg == "diana_death_igc_transition" )
    {
        vo_boss_defeated();
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xb54735e3, Offset: 0x24e6
// Size: 0x534
function private on_boss_fight_complete()
{
    level notify( #"hash_768127cac878630f" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"bossfight_outro" );
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            continue;
        }
        
        if ( player.var_4fd5ac47a9bd8c18 )
        {
            player.var_4fd5ac47a9bd8c18 utility::callsharedfunc( #"w_mod", #"delete_wisp", player );
        }
        
        allequip = player weapons::getallequip();
        
        foreach ( equip in allequip )
        {
            if ( equip && equip.equipmentref == "equip_blackhole_bomb" )
            {
                equip weapons::deleteexplosive();
            }
        }
        
        player.var_7ab4c9acb317c405 = undefined;
        
        if ( level.var_2d7f360a931545ed )
        {
            player setclienttriggeraudiozone( "zm_sat_hornet_death_igc" );
        }
        
        player val::set_array( "hornet_boss_ending_igcs", [ "ignoreme", "damage" ], 1 );
        player val::set( "hornet_boss_ending_igcs", "show_hud", 0 );
    }
    
    function_1a46a56a1b1a3eea( ( 33370, 42192, 16626 ), 1500 );
    level thread function_ced36fcacbb1cc1f();
    function_ff1c14eb2cd91691();
    level.var_9c0d12c8f8edeb3d = undefined;
    level.s_game_over_scene_override = undefined;
    level.var_654073823a58b613 = undefined;
    level.var_9075568a1189c7c9 = undefined;
    level.cratedropdata.heliheight = level.var_1599a55445d3259f;
    level.var_1599a55445d3259f = undefined;
    level thread function_11d1867a975c9a73();
    zm_sat_hornet_talisman::function_34532b42a097d6b5();
    zm_sat_hornet_falling_rocks::stop_falling_rocks( 1 );
    level.s_hornet_boss.entity zombie_diana_necrotic_beam::function_4084db6a60bfeb55();
    level.s_hornet_boss.entity zombie_diana_necrotic_projectile::function_95d3b9d0dd153b31();
    level.s_hornet_boss.entity zombie_diana_winged_tornado_attack::function_c40d8c7dad9b7976();
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) || zombie == level.s_hornet_boss.entity )
        {
            continue;
        }
        
        zombie.nocorpse = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie kill();
    }
    
    zm_quest::function_2850bf8c7015dc92( [ "zone_boss_arena", "zone_boss_arena_n", "zone_boss_arena_e", "zone_boss_arena_s", "zone_boss_arena_w", "zone_boss_arena_nw", "zone_boss_arena_sw", "zone_boss_arena_ne", "zone_boss_arena_se" ] );
    
    if ( level.var_2d7f360a931545ed )
    {
        utility::flag_wait_or_timeout( "diana_death_igc_complete", 15 );
        level musicbank_utility::function_e146ca500a84f52f( #"round_start" );
        level musicbank_utility::function_e146ca500a84f52f( #"round_end" );
        
        foreach ( player in level.players )
        {
            player clearsoundsubmix( "sat_zm_hornet_boss" );
        }
        
        var_181bfe57b6b9d727 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_mq_quest", #"hash_6fa8cda7b6053899" ) ?? 0;
        var_181bfe57b6b9d727 = utility::set_bit_flag( var_181bfe57b6b9d727, 21 );
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_6fa8cda7b6053899", var_181bfe57b6b9d727 );
        function_af128c8a75662591();
        utility::flag_set( "hornet_boss_fight_complete" );
        utility::flag_clear( "hornet_boss_fight_start" );
        var_968e3a0a2071cb3d = !level.active_relic_challenge;
        
        if ( var_968e3a0a2071cb3d )
        {
            level thread function_1b0b03050cb7f8f7();
            level waittill( #"hash_269834394b0cb506" );
        }
        
        utility::array_thread( level.players, &val::reset, "hornet_boss_ending_igcs", "show_hud" );
        function_c32ea4de009cc0d4();
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 2, eflags: 0x4
// Checksum 0x49c76b7e, Offset: 0x2a22
// Size: 0xfc
function private get_powerups_in_radius( origin, radius )
{
    powerups_in_radius = [];
    root = powerups::get_powerups_root();
    active_powerups = root.active_powerups;
    
    if ( !isarray( active_powerups ) || active_powerups.size <= 0 )
    {
        return powerups_in_radius;
    }
    
    radius_sq = radius * radius;
    
    foreach ( powerup in active_powerups )
    {
        if ( !isdefined( powerup ) )
        {
            continue;
        }
        
        if ( distancesquared( powerup.origin, origin ) <= radius_sq )
        {
            powerups_in_radius[ powerups_in_radius.size ] = powerup;
        }
    }
    
    return powerups_in_radius;
}

// Namespace zm_sat_hornet_boss_fight
// Params 2, eflags: 0x4
// Checksum 0xc52bb0ab, Offset: 0x2b27
// Size: 0xa0
function private function_1a46a56a1b1a3eea( origin, radius )
{
    var_ce607c804a2b8215 = get_powerups_in_radius( origin, radius );
    
    foreach ( powerup in var_ce607c804a2b8215 )
    {
        if ( isdefined( powerup ) )
        {
            powerup powerups::powerup_delete();
        }
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xd69e293f, Offset: 0x2bcf
// Size: 0x9b
function private function_ced36fcacbb1cc1f()
{
    level endon( #"game_ended" );
    level utility::waittill_notify_or_timeout( "hornet_boss_reset_gameplay_after_exfil_vote_complete", 120 );
    
    foreach ( player in level.players )
    {
        player val::reset_all( "hornet_boss_ending_igcs" );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xa3238d4d, Offset: 0x2c72
// Size: 0xcb5
function private function_2a2dc4458e023072()
{
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    var_d938ff4d7f6235da = 300;
    var_21b394ead72bc0b = level.s_hornet_boss.var_4b68c903144fea03 ? 3 : 0;
    zm_sat_hornet_talisman::function_f0665edb8caafe15( ( 33370, 42192, 16626 ) );
    zm_sat_hornet_talisman::function_d2691457fcb21c95( ( 33370, 42192, 16626 ), 1200 );
    zm_sat_hornet_talisman::function_96dd573261cf2dc6( 50 );
    zm_sat_hornet_talisman::function_c367c0ea85e3b628( ( level.s_hornet_boss.var_3bc8868c04316fb3 ?? 20 ) + var_21b394ead72bc0b );
    
    /#
        level notify( #"hornet_boss_fight_init_complete" );
    #/
    
    level thread function_a5622c9de63238b1();
    level.var_c50a6791b09e24ba = 0;
    level childthread function_8688509a4ab44508();
    
    if ( level.var_940a4ec67a9e7d5d )
    {
        function_88ace301d085483f();
        zm_sat_hornet_talisman::set_talisman_state( level.talisman_system.starting_talisman, "destroyed", level.s_hornet_boss.entity );
        level.s_hornet_boss.entity notify( #"hash_4ad5af914cce06a3" );
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_1ad4a8059dfebbbc" );
        
        foreach ( player in level.players )
        {
            player setsoundsubmix( "sat_zm_hornet_boss" );
        }
        
        level.s_hornet_boss.entity function_786bb6aa1b76c7ee( "in_intro_sequence", 0 );
        level.s_hornet_boss.entity asm::function_7256f5ba459c840b( "idle_in" );
        level.s_hornet_boss.entity forceteleport( level.s_hornet_boss.boss_pos_a.origin, level.s_hornet_boss.boss_pos_a.angles, 8000 );
        level.var_940a4ec67a9e7d5d = undefined;
        level.s_hornet_boss.entity.var_382b3e1f72536e3c = undefined;
        
        foreach ( player in level.players )
        {
            player thread zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_diana_healthbar", level.s_hornet_boss.entity );
        }
        
        level thread function_e4e3ee7973fee3af();
        wait 0.1;
        level.s_hornet_boss.entity zombie_diana_metabones::function_18dadfe96dbc0e42();
        level notify( #"hash_d69e9ba70f5bf07c" );
    }
    else
    {
        level thread function_43e19a47d8a68e6a();
        level waittill( #"hash_4f8663a9389008fd" );
        level.var_852213e2b06e3f79 setscriptablepartstate( "eruption", "erupt" );
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_1ad4a8059dfebbbc" );
        
        foreach ( player in level.players )
        {
            player setsoundsubmix( "sat_zm_hornet_boss" );
        }
        
        level.s_hornet_boss.entity notify( #"hash_4ad5af914cce06a3" );
        level.s_hornet_boss.entity thread function_bf61c4bbd337fa21();
        level.s_hornet_boss.entity asm::asm_fireevent( level.s_hornet_boss.entity.asmname, "intro_start" );
        level.s_hornet_boss.entity utility::waittill_notify_or_timeout( "intro_start_end", 9.6 );
        wait 1;
        entrystartpoint = anglestoforward( level.s_hornet_boss.boss_pos_a.angles ) * -2000;
        entrystartpoint = level.s_hornet_boss.boss_pos_a.origin + entrystartpoint + ( 0, 0, -2000 );
        level.s_hornet_boss.entity forceteleport( entrystartpoint, level.s_hornet_boss.boss_pos_a.angles, 40000 );
        level.s_hornet_boss.entity function_1e56472b6212eed1();
        level.s_hornet_boss.entity thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "intro_finish", "intro_finish", entrystartpoint, level.s_hornet_boss.boss_pos_a.angles, "entering_arena" );
        level.s_hornet_boss.entity.var_382b3e1f72536e3c = undefined;
        level.s_hornet_boss.entity zombie_diana_metabones::function_18dadfe96dbc0e42();
        
        foreach ( player in level.players )
        {
            player thread zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_diana_healthbar", level.s_hornet_boss.entity );
        }
        
        level thread function_e4e3ee7973fee3af();
        level.s_hornet_boss.entity utility::waittill_notify_or_timeout( "intro_finished", 4.5 );
        var_7db363ec026d6bd = level.s_hornet_boss.entity.vantagepoints[ "south" ].origin;
        var_245bcb148477cfd5 = level.s_hornet_boss.entity.vantagepoints[ "south" ].angles;
        level.s_hornet_boss.entity forceteleport( var_7db363ec026d6bd, var_245bcb148477cfd5, var_d938ff4d7f6235da );
        thread function_c0770da56d534c29();
        
        if ( level.var_e89ede0f3821c2aa == "talisman_charged" )
        {
            level.s_hornet_boss.entity zombie_diana_targeting::set_diana_target( level.talisman_system.starting_talisman.scriptable );
            level.s_hornet_boss.entity notify( #"necrotic_projectile_start", 0, 0, 1 );
            level.s_hornet_boss.entity utility::waittill_notify_or_timeout( "necrotic_projectile_end", 5 );
            wait 0.2;
            zm_sat_hornet_talisman::set_talisman_state( level.talisman_system.starting_talisman, "destroyed", level.s_hornet_boss.entity );
        }
        
        level.s_hornet_boss.entity function_925c4af01cebb500();
        level.s_hornet_boss.entity function_786bb6aa1b76c7ee( "in_intro_sequence", 0 );
        level.var_e89ede0f3821c2aa = undefined;
    }
    
    level utility::flag_set( "hornet_boss_fight_intro_complete" );
    
    if ( level.s_hornet_boss.var_4b68c903144fea03 )
    {
        var_280510f9a6d6a305 = utility::array_random( level.talisman_system.hidden_talismans );
        zm_sat_hornet_talisman::set_talisman_state( var_280510f9a6d6a305, "destroyed", level.s_hornet_boss.entity );
    }
    
    level.s_hornet_boss.var_e8d02e948d71bafe thread add_spawner();
    
    if ( !callback::exists( "on_zombie_ai_damaged", &function_263a6b7ab8df6028 ) )
    {
        level.s_hornet_boss.entity callback::add( "on_zombie_ai_damaged", &function_263a6b7ab8df6028 );
    }
    
    level utility::flag_wait( "boss_second_stage" );
    
    if ( !getdvarint( @"hash_ec4f031582b94425", 0 ) || getdvarint( @"hash_85a66692f812170f", 0 ) )
    {
        function_60902db3e5b28ef3( 2 );
        level.s_hornet_boss.entity thread function_5cd2f27ba9782226();
        level.s_hornet_boss.entity utility::waittill_notify_or_timeout( "hibernation_phase_complete", 57.1 );
        level thread function_a09bf37439e1d3f();
        
        if ( level.s_hornet_boss.var_b637cf356e0e8ff5 && !getdvarint( @"hash_169846c664077bf", 0 ) )
        {
            level thread function_b903b13776f583e1();
        }
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_1ad4ab059dfec0d5" );
    level.s_hornet_boss.entity zombie_diana_necrotic_projectile::set_necrotic_projectile_cooldown( 7 );
    level.s_hornet_boss.entity zombie_diana_necrotic_projectile::function_d43db4f022d36e9c( 70 );
    level.s_hornet_boss.entity zombie_diana_necrotic_beam::set_necrotic_beam_cooldown( 40 );
    
    if ( level.s_hornet_boss.var_a3c1ec18fc553adc != 0 )
    {
        level.s_hornet_boss.entity zombie_diana_necrotic_beam::function_f68f7d07e46fbb70( level.s_hornet_boss.var_a3c1ec18fc553adc );
    }
    
    level.s_hornet_boss.entity zombie_diana_necrotic_fan::set_necrotic_fan_cooldown( 55 );
    level.s_hornet_boss.entity zombie_diana_summon_agni_zombies::set_summon_agni_zombies_cooldown( 40 );
    level.s_hornet_boss.entity zombie_diana_metabones::function_324024ba7d02c81c( 1 );
    
    foreach ( pedestal in level.s_hornet_boss.a_pedestals )
    {
        if ( pedestal.mq_type == "ruby" )
        {
            thread rise_pedestal( pedestal );
        }
    }
    
    level utility::flag_wait( "boss_third_stage" );
    
    if ( !getdvarint( @"hash_ec4f021582b941f2", 0 ) || getdvarint( @"hash_1e077c52817a6ac0", 0 ) )
    {
        function_60902db3e5b28ef3( 3 );
        level.s_hornet_boss.entity thread function_5cd2f27ba9782226();
        level.s_hornet_boss.entity utility::waittill_notify_or_timeout( "hibernation_phase_complete", 57.1 );
        level thread function_a09be37439e1b0c();
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_1ad4aa059dfebf22" );
    level.s_hornet_boss.entity zombie_diana_necrotic_projectile::set_necrotic_projectile_cooldown( 7 );
    level.s_hornet_boss.entity zombie_diana_necrotic_projectile::function_d43db4f022d36e9c( 100 );
    level.s_hornet_boss.entity zombie_diana_necrotic_beam::set_necrotic_beam_cooldown( 40 );
    
    if ( level.s_hornet_boss.var_a3c1ec18fc553adc != 0 )
    {
        level.s_hornet_boss.entity zombie_diana_necrotic_beam::function_f68f7d07e46fbb70( level.s_hornet_boss.var_a3c1ec18fc553adc );
    }
    
    level.s_hornet_boss.entity zombie_diana_necrotic_fan::set_necrotic_fan_cooldown( 50 );
    level.s_hornet_boss.entity zombie_diana_summon_agni_zombies::set_summon_agni_zombies_cooldown( 15 );
    level.s_hornet_boss.entity zombie_diana_winged_tornado_attack::set_winged_tornado_attack_cooldown( 25 );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x8ed86b42, Offset: 0x392f
// Size: 0xbe
function private function_a5622c9de63238b1()
{
    self notify( #"hash_bf441e9047716de3" );
    self endon( #"hash_bf441e9047716de3" );
    level waittill( #"hash_d69e9ba70f5bf07c" );
    
    foreach ( pedestal in level.s_hornet_boss.a_pedestals )
    {
        if ( pedestal.mq_type == "firefly" )
        {
            thread rise_pedestal( pedestal );
        }
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x27cec304, Offset: 0x39f5
// Size: 0xbe
function private function_8688509a4ab44508()
{
    self notify( #"hash_f0142320e6f8899c" );
    self endon( #"hash_f0142320e6f8899c" );
    level waittill( #"hash_c765e7a3c3acfaa9" );
    
    foreach ( pedestal in level.s_hornet_boss.a_pedestals )
    {
        if ( pedestal.mq_type == "locust" )
        {
            thread rise_pedestal( pedestal );
        }
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x95c4056d, Offset: 0x3abb
// Size: 0x123
function private function_bf61c4bbd337fa21()
{
    self notify( #"hash_714eafb827557275" );
    self endon( #"hash_714eafb827557275" );
    self endon( #"death" );
    var_c6b28cb1ed1420f9 = 10000;
    self waittill( #"intro_beam_start" );
    playrumbleonposition( "zombie_diana_impact_rumble", ( 33370, 42192, 16626 ) );
    earthquakeadvanced( 0.4, 0.363636, 0.333333, 5, ( 33370, 42192, 16626 ), 4166.67, 4545.45, 5000 );
    var_c2d140635f85f767 = self gettagorigin( "tag_mouth_fx", 1 );
    upvec = anglestoup( self.angles );
    var_2c4791a7cb56e579 = function_767584b2d3ddf986( utility::getfx( "diana_necrotic_beam_attack_vfx" ), var_c2d140635f85f767, vectortoangles( upvec ), var_c2d140635f85f767 + upvec * var_c6b28cb1ed1420f9 );
    var_2c4791a7cb56e579 namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
    thread utility::function_9a9165839779317f( var_2c4791a7cb56e579, "intro_beam_end" );
    thread utility::delete_on_death( var_2c4791a7cb56e579 );
    
    if ( zm_utility::get_round_number() >= 100 )
    {
        overlord::playevent( "zm_special_round_start_vo", level.players, undefined, 1 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x46f1fc12, Offset: 0x3be6
// Size: 0xea
function private function_b903b13776f583e1()
{
    level endon( #"game_ended" );
    level endon( #"hash_a35f3533da3f5d81" );
    
    while ( true )
    {
        level zm_sat_hornet_weather_ash::function_d8678c685a005f29( [ "zone_boss_arena", "zone_boss_arena_n", "zone_boss_arena_e", "zone_boss_arena_s", "zone_boss_arena_w", "zone_boss_arena_nw", "zone_boss_arena_sw", "zone_boss_arena_ne", "zone_boss_arena_se" ], 1 );
        wait randomfloatrange( 30, 45 );
        level zm_sat_hornet_weather_ash::function_91ad74da91af1982( [ "zone_boss_arena", "zone_boss_arena_n", "zone_boss_arena_e", "zone_boss_arena_s", "zone_boss_arena_w", "zone_boss_arena_nw", "zone_boss_arena_sw", "zone_boss_arena_ne", "zone_boss_arena_se" ] );
        wait randomfloatrange( 25, 40 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x330e7f69, Offset: 0x3cd8
// Size: 0xd4
function private function_1e56472b6212eed1()
{
    traversalattributes = {};
    traversalattributes.startpos = self.origin;
    traversalattributes.endpos = level.s_hornet_boss.boss_pos_a.origin;
    traversalattributes.angles = level.s_hornet_boss.boss_pos_a.angles;
    
    if ( traversalattributes.startpos && traversalattributes.endpos && traversalattributes.angles )
    {
        self settraversalattributes( traversalattributes.startpos, traversalattributes.endpos, traversalattributes.angles, traversalattributes.endpos );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xe6334f0a, Offset: 0x3db4
// Size: 0x10e
function private function_263a6b7ab8df6028( params )
{
    inarmorbreak = asm::asm_getcurrentstate( self.asmname ) == "special_pain";
    
    if ( inarmorbreak || !self.var_f8115155adde44d[ self.bossfightphase ] )
    {
        return;
    }
    
    var_bddcd5de72042f4b = self.var_f8115155adde44d[ self.bossfightphase ] * self.maxhealth;
    
    if ( self.health <= var_bddcd5de72042f4b && !level utility::flag( "boss_second_stage" ) )
    {
        self.bossfightphase = 2;
        callback::callback( "new_diana_phase" );
        level utility::flag_set( "boss_second_stage" );
        return;
    }
    
    if ( self.health <= var_bddcd5de72042f4b && !level utility::flag( "boss_third_stage" ) )
    {
        self.bossfightphase = 3;
        callback::callback( "new_diana_phase" );
        level utility::flag_set( "boss_third_stage" );
        callback::remove( "on_zombie_ai_damaged", &function_263a6b7ab8df6028 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xac48724c, Offset: 0x3eca
// Size: 0x55c
function private function_5cd2f27ba9782226()
{
    self endon( #"death" );
    var_f884160fb1f3fd42 = 50;
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"bossfight_interlude" );
    zombie_diana_hibernation::hibernation_start();
    level.s_hornet_boss.entity utility::waittill_notify_or_timeout( "hibernation_start_complete", 32.5 );
    
    foreach ( var_2e766ac2e3d5391e in level.talisman_system.var_af34bc9458b6a4ce )
    {
        if ( var_2e766ac2e3d5391e.state == "destroyed" )
        {
            zm_sat_hornet_talisman::function_4a11d946b66c1758( var_2e766ac2e3d5391e );
        }
        
        zm_sat_hornet_talisman::set_talisman_state( var_2e766ac2e3d5391e, "destroyed", level.s_hornet_boss.entity );
    }
    
    if ( !isdefined( level.var_92119e3c88eb426c ) )
    {
        level.var_92119e3c88eb426c = randomint( 1 );
    }
    
    if ( level.var_92119e3c88eb426c )
    {
        var_f06472d1768af74f = arrayrandomize( level.talisman_system.upper_talismans );
        
        foreach ( uppertalisman in var_f06472d1768af74f )
        {
            if ( uppertalisman.state == "hidden" )
            {
                zm_sat_hornet_talisman::set_talisman_state( uppertalisman, "destroyed", level.s_hornet_boss.entity );
                break;
            }
        }
        
        level.var_92119e3c88eb426c = 0;
    }
    else
    {
        var_a02f3bf1416a7778 = arrayrandomize( level.talisman_system.lower_talismans );
        
        foreach ( lowertalisman in var_a02f3bf1416a7778 )
        {
            if ( lowertalisman.state == "hidden" )
            {
                zm_sat_hornet_talisman::set_talisman_state( lowertalisman, "destroyed", level.s_hornet_boss.entity );
                break;
            }
        }
        
        level.var_92119e3c88eb426c = 1;
    }
    
    var_21b394ead72bc0b = level.s_hornet_boss.var_4b68c903144fea03 ? 3 : 0;
    
    switch ( level.s_hornet_boss.entity.bossfightphase )
    {
        case 2:
            zm_sat_hornet_talisman::function_96dd573261cf2dc6( 35 );
            zm_sat_hornet_talisman::function_c367c0ea85e3b628( ( level.s_hornet_boss.var_2a0d1547118ddc25 ?? 23 ) + var_21b394ead72bc0b );
            break;
        case 3:
            zm_sat_hornet_talisman::function_96dd573261cf2dc6( 25 );
            zm_sat_hornet_talisman::function_c367c0ea85e3b628( ( level.s_hornet_boss.var_eb822575c28a2007 ?? 26 ) + var_21b394ead72bc0b );
            break;
    }
    
    zm_sat_hornet_falling_rocks::start_falling_rocks( 1 );
    level notify( #"hash_768127cac878630f" );
    level.s_hornet_boss.var_ab62d4ac6c7ef73a thread add_spawner();
    level utility::waittill_any_in_array_or_timeout( [ "all_talismans_charged", "dev_skip_hibernation" ], 45 );
    zombie_diana_hibernation::hibernation_end();
    
    if ( level.s_hornet_boss.entity.bossfightphase >= level.s_hornet_boss.var_8a51c7aa42fd7382 )
    {
        zm_sat_hornet_falling_rocks::function_9a22faf44c3f0c78( [ 0.7, 1 ] );
    }
    else
    {
        zm_sat_hornet_falling_rocks::stop_falling_rocks();
    }
    
    level notify( #"hash_6222cdcd958a1f6b" );
    level.s_hornet_boss.var_e8d02e948d71bafe thread add_spawner();
    wait 4.5;
    zombie_diana_hibernation::function_a158e8b272958836();
    self.var_fbd2b9707b5bd16f = 0;
    var_e4eb48abb2477776 = vectornormalize2( level.s_hornet_boss.boss_pos_a.origin - ( 33370, 42192, 16626 ) );
    var_e4eb48abb2477776 = vectorcross( ( 0, 0, 1 ), var_e4eb48abb2477776 ) * var_f884160fb1f3fd42;
    powerups::powerup_drop( "full_ammo", utility::drop_to_ground( ( 33370, 42192, 16626 ) + var_e4eb48abb2477776 ) + ( 0, 0, 60 ), 60, undefined, "quest" );
    powerups::powerup_drop( "full_armor", utility::drop_to_ground( ( 33370, 42192, 16626 ) - var_e4eb48abb2477776 ) + ( 0, 0, 60 ), 60, undefined, "quest" );
    level.s_hornet_boss.entity notify( #"hibernation_phase_complete" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0
// Checksum 0x8e9dd714, Offset: 0x442e
// Size: 0x89
function function_b80976b7930587b4()
{
    num_players = level.players.size;
    
    if ( num_players <= 1 )
    {
        return level.s_hornet_boss.var_6b7fb2da3cdf5121;
    }
    
    if ( num_players <= 2 )
    {
        return level.s_hornet_boss.var_6b83b8da3ce3542a;
    }
    
    if ( num_players <= 3 )
    {
        return level.s_hornet_boss.var_6b889eda3ce943d3;
    }
    
    return level.s_hornet_boss.var_6b8ca4da3ced46dc;
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x1ef49881, Offset: 0x44bf
// Size: 0x794
function private function_ebef81106cdde6c7( n_round )
{
    if ( isalive( level.s_hornet_boss.entity ) )
    {
        level.s_hornet_boss.entity.origin = ( 25388, 27166, 27680 );
    }
    
    while ( !isalive( level.s_hornet_boss.entity ) || level.s_hornet_boss.entity.aicategory != "boss" )
    {
        level.s_hornet_boss.entity = agent_manager::spawn_agent( "zombie_diana", ( 25388, 27166, 27680 ), ( 0, 62, 0 ), zm_utility::get_zombie_team() );
        
        if ( !isdefined( level.s_hornet_boss.entity ) )
        {
            waitframe();
            continue;
        }
        
        level.s_hornet_boss.entity function_90b65a36a6c1814a();
        level.s_hornet_boss.entity.var_2fc3a5fb762afb6e = 0;
        level.s_hornet_boss.entity.var_521099eccef67894 = 1;
        visibility_mode::function_3afc3bc470c80e61( level.s_hornet_boss.entity, level.s_hornet_boss.entity.team );
        level.s_hornet_boss.entity.var_382b3e1f72536e3c = 1;
        level.s_hornet_boss.entity asm::function_7256f5ba459c840b( "intro_in" );
        level.s_hornet_boss.entity function_786bb6aa1b76c7ee( "in_intro_sequence", 1 );
        level.s_hornet_boss.entity.targetname = "HORNET_BOSS";
        level.s_hornet_boss.entity.var_1f6335e27ced5dca = 1;
        n_round = max( n_round, function_b80976b7930587b4() );
        
        if ( level.s_hornet_boss.entity zombie_utils::get_zombie_round_difficulty() < n_round )
        {
            level.s_hornet_boss.entity zombie_utils::set_zombie_round_difficulty( n_round, 0, 1 );
        }
        
        foreach ( player in level.players )
        {
            player zombie_boss_healthbar::zombie_boss_healthbar_hide();
            player utility::player_prestream_assets( "hornet_boss", "entity", level.s_hornet_boss.entity, 2000 );
        }
        
        level.s_hornet_boss.entity zombie_diana_move::set_vantage_points( { #angles:level.s_hornet_boss.boss_pos_a.angles, #origin:level.s_hornet_boss.boss_pos_a.origin }, { #angles:level.s_hornet_boss.boss_pos_b.angles, #origin:level.s_hornet_boss.boss_pos_b.origin }, { #angles:level.s_hornet_boss.var_ce151cff43b2b50.angles, #origin:level.s_hornet_boss.var_ce151cff43b2b50.origin }, { #angles:level.s_hornet_boss.var_ce158cff43b3ab5.angles, #origin:level.s_hornet_boss.var_ce158cff43b3ab5.origin } );
        
        if ( level.s_hornet_boss.var_754b9305e6d92db9 != level.s_hornet_boss.entity.var_f8115155adde44d[ 1 ] || level.s_hornet_boss.var_2a9625e4994e3b70 != level.s_hornet_boss.entity.var_f8115155adde44d[ 2 ] )
        {
            level.s_hornet_boss.entity zombie_diana::function_2c054e2c3e95b33e( level.s_hornet_boss.var_754b9305e6d92db9, level.s_hornet_boss.var_2a9625e4994e3b70 );
        }
        
        level.s_hornet_boss.entity zombie_diana::set_diana_tether( ( 33370, 42192, 16626 ), 1500 );
        level.s_hornet_boss.entity zombie_diana_necrotic_beam::function_d6a6dc868f2c4e06( level.s_hornet_boss.var_6b1405438bf971d );
        level.s_hornet_boss.entity zombie_diana_necrotic_fan::set_necrotic_fan_anchor_point( ( 33370, 42192, 16626 ) );
        level.s_hornet_boss.entity zombie_diana_winged_tornado_attack::function_5bcf086a3ac09f6c( ( 33370, 42192, 16626 ) );
        level.s_hornet_boss.entity zombie_diana_winged_tornado_attack::function_eb67cab25bd84134( level.s_hornet_boss.var_10cee2dd281613f0 );
        level.s_hornet_boss.entity zombie_diana_winged_tornado_attack::function_487be135af565351( level.s_hornet_boss.var_689aac61e0378208 );
        level.s_hornet_boss.entity zombie_diana_move::function_9bd74d854992fd6c( level.s_hornet_boss.var_811a1d3d27b1c649 );
        
        if ( level.s_hornet_boss.var_11acdfdbbfadf4b9 != 0 )
        {
            level.s_hornet_boss.entity namespace_11bfef4f5e98b9a1::function_2add19745029c412( level.s_hornet_boss.var_11acdfdbbfadf4b9 );
        }
        
        if ( level.s_hornet_boss.var_c4dd99c9fb22b0b4 != 0 )
        {
            level.s_hornet_boss.entity zombie_diana_summon_agni_zombies::function_8b9e1d59323dcf9e( level.s_hornet_boss.var_c4dd99c9fb22b0b4 );
        }
        
        if ( level.s_hornet_boss.var_5622075a17b9e84 != 0 )
        {
            level.s_hornet_boss.entity zombie_diana_summon_agni_zombies::function_b15050bc8a54fed1( level.s_hornet_boss.var_5622075a17b9e84 );
        }
        
        if ( level.s_hornet_boss.var_48401477c1fa0414 != -1 )
        {
            level.s_hornet_boss.entity zm_zombie_diana::function_66524aff88e1f47e( level.s_hornet_boss.var_48401477c1fa0414 );
        }
        
        if ( level.s_hornet_boss.var_1d344e7d3e199ee1 != -1 )
        {
            level.s_hornet_boss.entity zm_zombie_diana::function_5550daad88f85dfb( level.s_hornet_boss.var_1d344e7d3e199ee1 );
        }
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x6f52391b, Offset: 0x4c5b
// Size: 0xb7
function private function_90b65a36a6c1814a()
{
    self.var_f8115155adde44d = [ 1, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_754b9305e6d92db9, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_2a9625e4994e3b70 ];
    ai::set_ai_max_health( int( self.maxhealth * level.s_hornet_boss.maxhealthmultiplier ) );
    self.var_9dd11279d5e371c7 *= level.s_hornet_boss.maxhealthmultiplier;
    self.health = self.maxhealth;
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0xc
// Checksum 0xc812dbe0, Offset: 0x4d1a
// Size: 0x132
function private function_43e19a47d8a68e6a()
{
    self notify( #"hash_3b4ec8651b7bc4ca" );
    self endon( #"hash_3b4ec8651b7bc4ca" );
    level endon( #"game_ended" );
    level.s_hornet_boss.entity function_786bb6aa1b76c7ee( "in_intro_sequence", 1 );
    zm_sat_hornet_talisman::set_talisman_state( level.talisman_system.starting_talisman, "active", level.s_hornet_boss.entity, 1 );
    
    if ( level.var_7a0e1cc5121e500d )
    {
        level utility::waittill_notify_or_timeout( "fast_travel_into_boss_arena_complete", 24 );
        level.var_7a0e1cc5121e500d = undefined;
        level thread zm_quest::update_guidance( undefined, #"hornet_boss_fight_guidance", #"hash_64764973552723ac" );
    }
    
    level notify( #"hash_d69e9ba70f5bf07c" );
    function_88ace301d085483f();
    level.var_e89ede0f3821c2aa = level.talisman_system.starting_talisman.scriptable utility::waittill_any_timeout( 60, "talisman_charged" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread zm_quest::update_guidance( undefined, #"hornet_boss_fight_guidance", #"talisman_active" );
    }
    
    level notify( #"hash_4f8663a9389008fd" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x719744d9, Offset: 0x4e54
// Size: 0x5f
function private function_e4e3ee7973fee3af()
{
    self notify( #"hash_5a5bc176eb708de6" );
    self endon( #"hash_5a5bc176eb708de6" );
    level.s_hornet_boss.entity endon( #"death" );
    utility::flag_wait( "playing_game_over_scene" );
    wait 0.5;
    utility::array_thread( level.players, &zombie_boss_healthbar::zombie_boss_healthbar_hide );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xad4b7883, Offset: 0x4ebb
// Size: 0x73
function private on_player_spawned( params )
{
    if ( !utility::flag( "hornet_boss_fight_complete" ) && !self.var_2d6ce24b1278055a )
    {
        self function_d88e8eab88c50c13( 1 );
        zombie_boss_healthbar::zombie_boss_healthbar_hide();
        s_respawn_group = zone_manager::function_9dd25e9fb0ecd45b( "zone_boss_arena" );
        thread function_cd96995d9a559038( utility::array_random( s_respawn_group[ 0 ].var_f448a26cf56f4a2a ) );
        wait 1;
        function_9cc2b48802345520();
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x7ccb6731, Offset: 0x4f36
// Size: 0x23
function private on_player_connect( params )
{
    if ( !utility::flag( "hornet_boss_fight_complete" ) )
    {
        self function_d88e8eab88c50c13( 1 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x5d4ad2b7, Offset: 0x4f61
// Size: 0x89
function private function_2ed0e66395a9201a( params )
{
    self.no_powerups = 1;
    self.var_825b17c932865df = 1;
    self.b_cleanup_no_respawn = 1;
    self.var_825b17c932865df = 1;
    self.var_15598d8e493afe88 = 1;
    self.ignore_enemy_count = 1;
    val::set( "boss_zombie", "ignore_cleanup", 1 );
    self function_ec04263fa4f47f78( 1 );
    
    if ( self.aicategory == "normal" )
    {
        self.var_50c96a5c56dab386 = &function_acf02770d0dc43ac;
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x49b54055, Offset: 0x4ff2
// Size: 0x129
function private function_acf02770d0dc43ac()
{
    zombie_droplist = "zm_sat_hornet_boss_fight_normal_item_list";
    attacker = isdefined( self.last_dmg_struct ) ? self.last_dmg_struct.eattacker : undefined;
    var_55f94a869dd7e4d5 = isplayer( attacker ) && attacker armor::function_22290101992e4874() <= 1;
    var_476fe576f05a4c8f = isplayer( attacker ) && attacker currency::get_currency_amount( #"salvage" ) < 1000;
    
    if ( isstartstr( self.subclass, "zombie_base_armored" ) && var_55f94a869dd7e4d5 )
    {
        zombie_droplist = level.s_hornet_boss.var_f1e8ce0d92289759 ?? "zm_sat_hornet_boss_fight_normal_armored_item_list";
    }
    else if ( var_476fe576f05a4c8f )
    {
        zombie_droplist = "zm_sat_hornet_boss_fight_normal_low_salvage_item_list";
    }
    
    var_245f1c4b1d5b3e81 = 1;
    zombie_droppos = self.origin;
    zombie_droplist_params = { #droppos:zombie_droppos ?? self.origin, #dropquantity:var_245f1c4b1d5b3e81, #droplist:zombie_droplist };
    return zombie_droplist_params;
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x862d40a, Offset: 0x5124
// Size: 0xb9
function private function_9cc2b48802345520()
{
    foreach ( player in level.players )
    {
        if ( isalive( level.s_hornet_boss.entity ) )
        {
            player zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_diana_healthbar", level.s_hornet_boss.entity );
            continue;
        }
        
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 4, eflags: 0x4
// Checksum 0x75f46fe3, Offset: 0x51e5
// Size: 0x51
function private function_8ee476f4ad76c216( var_be866219ba036c6, var_77fc4ed806f5cac9, var_51c533560222849c, var_9e41dd30435985b7 )
{
    s_respawn_group = zone_manager::function_9dd25e9fb0ecd45b( "zone_boss_arena" );
    return s_respawn_group[ 0 ].var_f448a26cf56f4a2a[ self getentitynumber() ];
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xe25581d5, Offset: 0x523f
// Size: 0xf4
function private function_1b0b03050cb7f8f7()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclienttriggeraudiozone( "zm_sat_hornet_outro_igc" );
    }
    
    s_scene = utility::getstruct( "sat_cin_zm_hornet_outro", "targetname" );
    s_scene thread scene::pre_stream();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"endigc" );
    s_scene scene::play();
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"endigc" );
    level notify( #"hash_269834394b0cb506" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x1abd13d6, Offset: 0x533b
// Size: 0x244
function private function_c32ea4de009cc0d4()
{
    level endon( #"game_ended" );
    level.var_2d7f360a931545ed = undefined;
    level.var_e9bce67d0022b869 = undefined;
    level.var_dc81f03d76612023 = undefined;
    utility::callsharedfunc( #"zombie", #"hash_edafec158d8c1bdc" );
    teleport_pos = utility::getstruct( "boss_exfil_loc", "targetname" );
    
    if ( level.active_relic_challenge )
    {
        level function_86248267cad4d9c4( teleport_pos );
        return;
    }
    
    if ( !level.var_7a0e1cc5121e500d )
    {
        utility::array_thread( level.players, &val::set, "final_vote", "ignoreme", 1 );
        var_f8a710a43590c8b1 = zm_quest::function_3477750f338de598( teleport_pos, &"hash_50c9eb217ce94c69", undefined, 0 );
        utility::array_thread( level.players, &val::reset, "final_vote", "ignoreme" );
    }
    else
    {
        foreach ( player in level.players )
        {
            level thread zm_fasttravel::function_cbb08198e7c84adf( teleport_pos, player, undefined, undefined, 0 );
        }
    }
    
    if ( !var_f8a710a43590c8b1 )
    {
        level thread function_78f9d6116fa25d95( teleport_pos );
    }
    
    level val::reset( "tasks_hornet_boss_fight", "task_logic_activate" );
    
    foreach ( st_zone in [ "zone_boss_arena", "zone_boss_arena_n", "zone_boss_arena_e", "zone_boss_arena_s", "zone_boss_arena_w", "zone_boss_arena_nw", "zone_boss_arena_sw", "zone_boss_arena_ne", "zone_boss_arena_se" ] )
    {
        zone_manager::set_zone_enabled( st_zone, 0 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xb8c29d4b, Offset: 0x5587
// Size: 0x10c
function private function_86248267cad4d9c4( teleport_pos )
{
    level thread function_78f9d6116fa25d95( teleport_pos );
    level val::reset( "tasks_hornet_boss_fight", "task_logic_activate" );
    utility::callsharedfunc( #"relics", #"end_relic_challenge", undefined, 1, teleport_pos );
    wait 5;
    
    foreach ( st_zone in [ "zone_boss_arena", "zone_boss_arena_n", "zone_boss_arena_e", "zone_boss_arena_s", "zone_boss_arena_w", "zone_boss_arena_nw", "zone_boss_arena_sw", "zone_boss_arena_ne", "zone_boss_arena_se" ] )
    {
        zone_manager::set_zone_enabled( st_zone, 0 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x1ff25683, Offset: 0x569b
// Size: 0xc2
function private function_78f9d6116fa25d95( teleport_pos )
{
    foreach ( player in level.players )
    {
        player function_d88e8eab88c50c13( 0 );
    }
    
    wait 3;
    level thread zm_quest::function_2e003fa13e881f92( teleport_pos );
    wait 15;
    zm_exfil::disable_zm_exfil( 0 );
    zm_round_spawning::pause_round_spawning( 0, "honet_boss_fight_pause_spawning" );
    level utility::flag_set( "rbz_allow_exfil" );
    level notify( #"hornet_boss_reset_gameplay_after_exfil_vote_complete" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0
// Checksum 0xb3d4efc6, Offset: 0x5765
// Size: 0x46
function function_ecc91637c2a6fbb1()
{
    if ( level utility::flag( "directed_end_boss" ) )
    {
        level thread zm_quest::clear_all_guidance();
        return;
    }
    
    if ( level utility::flag( "directed_damage_boss" ) )
    {
        level thread zm_quest::update_guidance( undefined, #"hornet_boss_fight_guidance", #"directed_damage_boss" );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x8f13631, Offset: 0x57b3
// Size: 0x2e
function private function_af128c8a75662591()
{
    level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_9d1f38c29e4aa24a", #"zm_sat_hornet_mq", level.players );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xcce5e79e, Offset: 0x57e9
// Size: 0xb8
function private function_7609962a351a5650()
{
    entityless_scriptables = getentitylessscriptablearray( undefined, undefined, ( 33370, 42192, 16626 ), 3000 );
    
    foreach ( scriptable in entityless_scriptables )
    {
        if ( scriptable && scriptable.type == "sat_zm_ammo_cache" )
        {
            scriptable utility::function_32b24db3127bff40( "icon", "active_force_top" );
        }
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x1fcd0d28, Offset: 0x58a9
// Size: 0x9c
function private function_8ef95d5d6219b790()
{
    level notify( #"warp_to_boss" );
    var_64eedefd196f941b = ( 33936, 42559, 16761 );
    var_c577fd45b822d99f = ( 0, 241, 0 );
    var_ee99619d549e58c7 = anglestoright( var_c577fd45b822d99f ) * 80;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        level.players[ i ] setorigin( var_64eedefd196f941b + var_ee99619d549e58c7 * i );
        level.players[ i ] setplayerangles( var_c577fd45b822d99f );
        waitframe();
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xcd2eb59c, Offset: 0x594d
// Size: 0x9c
function private function_1e2e0a55b313622f()
{
    level notify( #"warp_to_boss" );
    var_64eedefd196f941b = ( 323, -16743, 1410 );
    var_c577fd45b822d99f = ( 0, 10, 0 );
    var_ee99619d549e58c7 = anglestoright( var_c577fd45b822d99f ) * 80;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        level.players[ i ] setorigin( var_64eedefd196f941b + var_ee99619d549e58c7 * i );
        level.players[ i ] setplayerangles( var_c577fd45b822d99f );
        waitframe();
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 2, eflags: 0x4
// Checksum 0x28f1f44, Offset: 0x59f1
// Size: 0x1d8
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
    self.var_7ab4c9acb317c405 = utility::drop_to_ground( ( 33370, 42192, 16626 ) );
    level.s_hornet_boss.var_be82617e5e8087bd = arraycombineunique( level.s_hornet_boss.var_be82617e5e8087bd, [ self ] );
    wait 4.55;
    
    if ( var_415fcbcfd1b4ef03 )
    {
        waitframe();
        thread zm_fasttravel::set_player_vars( 0 );
    }
    
    self clearadditionalstreampos();
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x31dce003, Offset: 0x5bd1
// Size: 0x1c4
function private setup_zombie_add_data()
{
    level.s_hornet_boss.var_e8d02e948d71bafe = { #valid_spawn_locs:[], #is_wave:0, #var_cd510aa21ac99288:[], #var_fc3a7cc0ec4c2d1:0, #var_acdf804d5a6fed94:1, #speeds:[ "sprint" ], #var_239b65f9b1709ecc:4, #var_2637d564b270bd8e:0.5, #var_8fc52f361f5ac082:3, #var_cfad8c7db8e390ba:15, #var_f250c4df13fe7fa1:[ 18, 35 ], #zombie_spawner_chances:[ 55, 20, 25 ], #var_d3f5f0cc01094984:[ "zombie_base", "zombie_base_armored_heavy", "zombie_base_armored_light" ] };
    level.s_hornet_boss.var_ab62d4ac6c7ef73a = { #valid_spawn_locs:[], #is_wave:0, #var_cd510aa21ac99288:[], #var_fc3a7cc0ec4c2d1:0, #var_acdf804d5a6fed94:1, #speeds:[ "sprint" ], #var_239b65f9b1709ecc:3, #var_2637d564b270bd8e:0.3, #var_8fc52f361f5ac082:2, #var_cfad8c7db8e390ba:10, #var_f250c4df13fe7fa1:[ 25, 50 ], #zombie_spawner_chances:[ 40, 35, 25 ], #var_d3f5f0cc01094984:[ "zombie_base", "zombie_base_armored_heavy", "zombie_base_armored_light" ] };
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x4a298789, Offset: 0x5d9d
// Size: 0x2ed
function private add_spawner()
{
    self notify( #"hash_4e262cd9d7cefee3" );
    self endon( #"hash_4e262cd9d7cefee3" );
    level endon( #"game_ended", #"hash_768127cac878630f" );
    level endon( #"game_ended", #"hash_6222cdcd958a1f6b" );
    level.s_hornet_boss.entity endon( #"death" );
    spawning_settings = self;
    spawn_start_time_ms = gettime();
    
    if ( isarray( spawning_settings.var_f250c4df13fe7fa1 ) )
    {
        player_count = level.players.size;
        squad_size_frac = math::lerp_fraction( 1, 4, player_count );
        max_zombie_count = int( math::lerp( spawning_settings.var_f250c4df13fe7fa1[ 0 ], spawning_settings.var_f250c4df13fe7fa1[ 1 ], squad_size_frac ) );
    }
    else
    {
        max_zombie_count = level.s_hornet_boss.max_zombie_count;
    }
    
    if ( spawning_settings.var_239b65f9b1709ecc )
    {
        wait spawning_settings.var_239b65f9b1709ecc;
    }
    
    var_ffffa3b031ee47b9 = spawning_settings.var_cfad8c7db8e390ba ? utility::function_4b74c15943231980( spawning_settings.var_cfad8c7db8e390ba ) : 0;
    
    while ( true )
    {
        if ( level.s_hornet_boss.pause_add_spawning )
        {
            waitframe();
            continue;
        }
        
        active_zombie_count = spawning_settings.is_wave ? 0 : zm_utility::get_active_zombies_count();
        
        if ( level.s_hornet_boss.var_3a7c5451c5ba016f.size >= level.s_hornet_boss.max_zombie_count )
        {
            waitframe();
            continue;
        }
        
        var_bd285724ca688389 = max_zombie_count;
        elapsed_time_ms = gettime() - spawn_start_time_ms;
        
        if ( var_ffffa3b031ee47b9 && elapsed_time_ms < var_ffffa3b031ee47b9 )
        {
            var_d56e05ab97ac91c1 = math::lerp_fraction( 0, var_ffffa3b031ee47b9, elapsed_time_ms );
            var_bd285724ca688389 = clampint( int( math::lerp( 0, max_zombie_count, var_d56e05ab97ac91c1 ) ), 0, max_zombie_count );
        }
        else
        {
            var_bd285724ca688389 = max_zombie_count;
        }
        
        var_93aa0d163f5afaea = var_bd285724ca688389 - active_zombie_count;
        
        for ( i = 0; i < var_93aa0d163f5afaea ; i++ )
        {
            if ( level.s_hornet_boss.pause_add_spawning )
            {
                break;
            }
            
            chosen_subclass = utility::random_weighted( spawning_settings.var_d3f5f0cc01094984, spawning_settings.zombie_spawner_chances );
            spawn_zombie_add( spawning_settings, chosen_subclass );
            
            if ( !spawning_settings.var_2637d564b270bd8e || spawning_settings.var_2637d564b270bd8e == 0 )
            {
                waitframe();
                continue;
            }
            
            wait spawning_settings.var_2637d564b270bd8e;
        }
        
        if ( spawning_settings.is_wave && level.s_hornet_boss.var_3a7c5451c5ba016f.size >= max_zombie_count )
        {
            return;
        }
        
        wait spawning_settings.var_8fc52f361f5ac082;
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 2, eflags: 0x4
// Checksum 0x84013ae0, Offset: 0x6092
// Size: 0x21b
function private spawn_zombie_add( spawn_settings, subclass )
{
    var_395649a1ecde9e39 = spawn_settings.valid_spawn_locs[ subclass ] ?? level.s_hornet_boss.var_1c20af01180087e0[ subclass ];
    random_spawn_override = spawn_settings.var_acdf804d5a6fed94 && randomint( 100 ) < level.s_hornet_boss.var_d3cb692a83b72d98 || spawn_settings.var_fc3a7cc0ec4c2d1;
    spawn_loc = undefined;
    
    if ( !random_spawn_override && var_395649a1ecde9e39.size > 0 )
    {
        spawn_loc = utility::array_random( var_395649a1ecde9e39 );
    }
    else
    {
        spawn_loc = zone_spawner::select_spawn_loc( subclass, undefined, 0 );
    }
    
    if ( !spawn_loc )
    {
        return;
    }
    
    zombie_aitype = function_b3988325430ce242( subclass );
    
    if ( !isdefined( spawn_settings.var_cd510aa21ac99288[ subclass ] ) )
    {
        spawn_settings.var_cd510aa21ac99288[ subclass ] = 0;
    }
    
    if ( isvector( spawn_loc.origin ) )
    {
        zombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( zombie_aitype, spawn_loc.origin, spawn_loc.angles, zm_utility::get_zombie_team() );
    }
    
    if ( zombie )
    {
        spawn_settings.var_cd510aa21ac99288[ subclass ]++;
        level.s_hornet_boss.var_3a7c5451c5ba016f[ level.s_hornet_boss.var_3a7c5451c5ba016f.size ] = zombie;
        zombie.spawn_settings = spawn_settings;
        zombie.spawn_time_ms = gettime();
        zombie thread agent_spawner::function_ce10e453e7f7bb8e( spawn_loc );
        round_difficulty = function_b80976b7930587b4();
        
        if ( zm_utility::get_round_number() > round_difficulty )
        {
            round_difficulty = zm_utility::get_round_number();
        }
        
        zombie zombie_utils::set_zombie_round_difficulty( round_difficulty, 1, 1 );
        zombie function_7f8988ce63c1623d( 0 );
        zombie utility::delaycallendon( 3, "death", &function_7f8988ce63c1623d, 1 );
        zombie_base_speed = get_zombie_base_speed( subclass, spawn_settings.speeds );
        zombie zombie_utils::function_a8ce00e0448cb6f0( zombie_base_speed, "hornet_boss", 5 );
    }
    
    return zombie;
}

// Namespace zm_sat_hornet_boss_fight
// Params 2, eflags: 0x4
// Checksum 0x2d3ff272, Offset: 0x62b6
// Size: 0x7c
function private get_zombie_base_speed( subclass, possible_speeds )
{
    var_19c281157ac50f3d = 85;
    
    if ( subclass == "zombie_base" && level.s_hornet_boss.var_eb5d30136560fd73 && randomfloat( 100 ) <= var_19c281157ac50f3d )
    {
        return "super_sprint";
    }
    
    if ( !isarray( possible_speeds ) || possible_speeds.size == 0 )
    {
        return "run";
    }
    
    return utility::array_random( possible_speeds );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0xc
// Checksum 0xeff81cf, Offset: 0x633b
// Size: 0x251
function private function_7b3a45c4fdbfc566()
{
    self notify( #"hash_2732d3303a9f62b1" );
    self endon( #"hash_2732d3303a9f62b1" );
    level endon( #"game_ended" );
    level.s_hornet_boss.entity endon( #"death" );
    var_781d5a2b2ddd795e = 0;
    
    while ( true )
    {
        valid_spawn_locs = [];
        
        foreach ( subclass in [ "zombie_base", "zombie_base_armored_heavy", "zombie_base_armored_light" ] )
        {
            valid_spawn_locs[ subclass ] = [];
            all_spawn_locs = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_boss_arena" ], subclass );
            
            foreach ( spawn_loc in all_spawn_locs )
            {
                foreach ( player in level.players )
                {
                    if ( !zm_player::function_f37cfdf04b932a03( player, 1, 0 ) )
                    {
                        continue;
                    }
                    
                    if ( distancesquared( spawn_loc.origin, player.origin ) <= level.s_hornet_boss.var_d85a011a39aea0f1 )
                    {
                        valid_spawn_locs[ subclass ][ valid_spawn_locs[ subclass ].size ] = spawn_loc;
                    }
                }
                
                var_781d5a2b2ddd795e++;
                
                if ( var_781d5a2b2ddd795e >= 10 )
                {
                    waitframe();
                    var_781d5a2b2ddd795e = 0;
                }
            }
        }
        
        level.s_hornet_boss.var_1c20af01180087e0 = valid_spawn_locs;
        waitframe();
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x1685679f, Offset: 0x6594
// Size: 0x106
function private function_f9d693fe94b1c1c()
{
    level endon( #"game_ended" );
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    var_26a8765c67e4c2c5 = utility::function_4b74c15943231980( level.s_hornet_boss.var_7143f13768f05e8e );
    
    while ( true )
    {
        foreach ( zombie in level.s_hornet_boss.var_3a7c5451c5ba016f )
        {
            if ( isalive( zombie ) )
            {
                if ( gettime() - zombie.spawn_time_ms >= var_26a8765c67e4c2c5 )
                {
                    zombie zombie_utils::try_despawn_zombie( 0 );
                }
            }
        }
        
        wait 5;
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xa28efb9e, Offset: 0x66a2
// Size: 0x28
function private function_187778d499d053eb()
{
    if ( !callback::exists( "on_hornet_boss_talisman_charged", &function_aa51e33623984e71 ) )
    {
        level callback::add( "on_hornet_boss_talisman_charged", &function_aa51e33623984e71 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x1b214c39, Offset: 0x66d2
// Size: 0x31e
function private function_2c3568bb8ce4bf7()
{
    if ( !callback::exists( #"player_spawned", &on_player_spawned ) )
    {
        level callback::add( #"player_spawned", &on_player_spawned );
    }
    
    if ( !callback::exists( #"player_connect", &on_player_connect ) )
    {
        level callback::add( #"player_connect", &on_player_connect );
    }
    
    if ( !callback::exists( "on_zombie_ai_spawned", &function_2ed0e66395a9201a ) )
    {
        level callback::add( "on_zombie_ai_spawned", &function_2ed0e66395a9201a );
    }
    
    if ( !callback::exists( "on_zombie_ai_killed", &function_6d534ed61e82d61e ) )
    {
        level callback::add( "on_zombie_ai_killed", &function_6d534ed61e82d61e );
    }
    
    if ( !level.var_47dd1e352c4e1070 )
    {
        level callback::add( #"player_connect", &function_fd1311d9927fce85 );
        level callback::add( #"player_disconnect", &on_player_disconnected );
        level callback::add( #"player_laststand", &on_player_last_stand_entered );
        level callback::add( #"player_laststand_revived", &on_player_last_stand_revived );
        level.var_47dd1e352c4e1070 = 1;
    }
    
    foreach ( player in level.players )
    {
        player callback::add( #"hash_5b8b82c2527d7aa2", &function_15d45e40acfbebac );
        player callback::add( #"hash_d558db2dac47d5f7", &function_783833e71587ca6d );
        player callback::add( #"hash_21d7e4119185d412", &function_ae5b33fac9103bfb );
        player callback::add( #"on_remote_robot_ended", &on_remote_robot_ended );
    }
    
    if ( !callback::exists( "on_hornet_boss_banner_picked_up", &function_5b30f1c3121ebd3d ) )
    {
        level callback::add( "on_hornet_boss_banner_picked_up", &function_5b30f1c3121ebd3d );
    }
    
    if ( !callback::exists( "on_hornet_boss_talisman_repaired", &function_ca1dd86df715131e ) )
    {
        level callback::add( "on_hornet_boss_talisman_repaired", &function_ca1dd86df715131e );
    }
    
    if ( !callback::exists( "on_hornet_boss_weakpoint_damaged", &function_204df2ffbabdf66c ) )
    {
        level callback::add( "on_hornet_boss_weakpoint_damaged", &function_204df2ffbabdf66c );
    }
    
    if ( !callback::exists( "on_hornet_boss_fan_out_vo", &function_f34180c393ded962 ) )
    {
        level callback::add( "on_hornet_boss_fan_out_vo", &function_f34180c393ded962 );
    }
    
    if ( !callback::exists( "on_hornet_boss_summon_scorched_zombies_vo", &vo_summon_scorched_zombies ) )
    {
        level callback::add( "on_hornet_boss_summon_scorched_zombies_vo", &vo_summon_scorched_zombies );
    }
    
    if ( !callback::exists( #"player_laststand", &vo_on_player_downed ) )
    {
        level callback::add( #"player_laststand", &vo_on_player_downed );
    }
    
    if ( !callback::exists( "on_hornet_boss_falling_rock_damage_vo", &function_1d17d9de32b04fdd ) )
    {
        level callback::add( "on_hornet_boss_falling_rock_damage_vo", &function_1d17d9de32b04fdd );
    }
    
    if ( !callback::exists( "on_hornet_boss_tornado_damage_vo", &function_8213cb4b60c86c7d ) )
    {
        level callback::add( "on_hornet_boss_tornado_damage_vo", &function_8213cb4b60c86c7d );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x47cd90d4, Offset: 0x69f8
// Size: 0x363
function private function_ff1c14eb2cd91691()
{
    if ( callback::exists( #"player_spawned", &on_player_spawned ) )
    {
        level callback::remove( #"player_spawned", &on_player_spawned );
    }
    
    if ( callback::exists( #"player_connect", &on_player_connect ) )
    {
        level callback::remove( #"player_connect", &on_player_connect );
    }
    
    if ( callback::exists( "on_zombie_ai_spawned", &function_2ed0e66395a9201a ) )
    {
        level callback::remove( "on_zombie_ai_spawned", &function_2ed0e66395a9201a );
    }
    
    if ( callback::exists( "on_zombie_ai_killed", &function_6d534ed61e82d61e ) )
    {
        level callback::remove( "on_zombie_ai_killed", &function_6d534ed61e82d61e );
    }
    
    if ( level.var_47dd1e352c4e1070 )
    {
        level callback::remove( #"player_connect", &function_fd1311d9927fce85 );
        level callback::remove( #"player_disconnect", &on_player_disconnected );
        level callback::remove( #"player_laststand", &on_player_last_stand_entered );
        level callback::remove( #"player_laststand_revived", &on_player_last_stand_revived );
        level.var_47dd1e352c4e1070 = undefined;
    }
    
    foreach ( player in level.players )
    {
        if ( callback::exists( #"hash_5b8b82c2527d7aa2", &function_15d45e40acfbebac ) )
        {
            player callback::remove( #"hash_5b8b82c2527d7aa2", &function_15d45e40acfbebac );
            player callback::remove( #"hash_d558db2dac47d5f7", &function_783833e71587ca6d );
        }
        
        if ( callback::exists( #"hash_21d7e4119185d412", &function_ae5b33fac9103bfb ) )
        {
            player callback::remove( #"hash_21d7e4119185d412", &function_ae5b33fac9103bfb );
            player callback::remove( #"on_remote_robot_ended", &on_remote_robot_ended );
        }
    }
    
    if ( callback::exists( "on_hornet_boss_banner_picked_up", &function_5b30f1c3121ebd3d ) )
    {
        level callback::remove( "on_hornet_boss_banner_picked_up", &function_5b30f1c3121ebd3d );
    }
    
    if ( callback::exists( "on_hornet_boss_talisman_repaired", &function_ca1dd86df715131e ) )
    {
        level callback::remove( "on_hornet_boss_talisman_repaired", &function_ca1dd86df715131e );
    }
    
    if ( callback::exists( "on_hornet_boss_talisman_charged", &function_aa51e33623984e71 ) )
    {
        level callback::remove( "on_hornet_boss_talisman_charged", &function_aa51e33623984e71 );
    }
    
    if ( callback::exists( "on_hornet_boss_weakpoint_damaged", &function_204df2ffbabdf66c ) )
    {
        level callback::remove( "on_hornet_boss_weakpoint_damaged", &function_204df2ffbabdf66c );
    }
    
    if ( callback::exists( "on_hornet_boss_fan_out_vo", &function_f34180c393ded962 ) )
    {
        level callback::remove( "on_hornet_boss_fan_out_vo", &function_f34180c393ded962 );
    }
    
    if ( callback::exists( "on_hornet_boss_summon_scorched_zombies_vo", &vo_summon_scorched_zombies ) )
    {
        level callback::remove( "on_hornet_boss_summon_scorched_zombies_vo", &vo_summon_scorched_zombies );
    }
    
    if ( callback::exists( #"player_laststand", &vo_on_player_downed ) )
    {
        level callback::remove( #"player_laststand", &vo_on_player_downed );
    }
    
    if ( callback::exists( "on_hornet_boss_falling_rock_damage_vo", &function_1d17d9de32b04fdd ) )
    {
        level callback::remove( "on_hornet_boss_falling_rock_damage_vo", &function_1d17d9de32b04fdd );
    }
    
    if ( callback::exists( "on_hornet_boss_tornado_damage_vo", &function_8213cb4b60c86c7d ) )
    {
        level callback::remove( "on_hornet_boss_tornado_damage_vo", &function_8213cb4b60c86c7d );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xa6328d9c, Offset: 0x6d63
// Size: 0xdf
function private function_6d534ed61e82d61e( params )
{
    if ( !isdefined( self.spawn_settings ) )
    {
        return;
    }
    
    if ( self.spawn_settings.var_cd510aa21ac99288 )
    {
        if ( !isdefined( self.spawn_settings.var_cd510aa21ac99288[ self.subclass ] ) )
        {
            self.spawn_settings.var_cd510aa21ac99288[ self.subclass ] = 0;
        }
        
        self.spawn_settings.var_cd510aa21ac99288[ self.subclass ] = maxint( self.spawn_settings.var_cd510aa21ac99288[ self.subclass ] - 1, 0 );
    }
    
    level.s_hornet_boss.var_3a7c5451c5ba016f = arrayremove( level.s_hornet_boss.var_3a7c5451c5ba016f, self );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xa0b26e38, Offset: 0x6e4a
// Size: 0xdf
function private function_fd1311d9927fce85( params )
{
    if ( level.s_hornet_boss.entity.var_d07937101f7ccc9f )
    {
        level.s_hornet_boss.entity.var_d07937101f7ccc9f++;
        level.s_hornet_boss.entity.var_d07937101f7ccc9f = minint( level.s_hornet_boss.entity.var_d07937101f7ccc9f, 4 );
    }
    
    callback::add( #"hash_5b8b82c2527d7aa2", &function_15d45e40acfbebac );
    callback::add( #"hash_d558db2dac47d5f7", &function_783833e71587ca6d );
    callback::add( #"hash_21d7e4119185d412", &function_ae5b33fac9103bfb );
    callback::add( #"on_remote_robot_ended", &on_remote_robot_ended );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xf7ae2905, Offset: 0x6f31
// Size: 0xab
function private on_player_disconnected( params )
{
    if ( level.s_hornet_boss.entity.var_d07937101f7ccc9f )
    {
        level.s_hornet_boss.entity.var_d07937101f7ccc9f--;
        level.s_hornet_boss.entity.var_d07937101f7ccc9f = maxint( level.s_hornet_boss.entity.var_d07937101f7ccc9f, level.s_hornet_boss.entity.var_7900bbbb6dec0637 ?? 2 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x4f417fa0, Offset: 0x6fe4
// Size: 0xab
function private on_player_last_stand_entered( params )
{
    if ( level.s_hornet_boss.entity.var_d07937101f7ccc9f )
    {
        level.s_hornet_boss.entity.var_d07937101f7ccc9f--;
        level.s_hornet_boss.entity.var_d07937101f7ccc9f = maxint( level.s_hornet_boss.entity.var_d07937101f7ccc9f, level.s_hornet_boss.entity.var_7900bbbb6dec0637 ?? 2 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xa77c0782, Offset: 0x7097
// Size: 0x8b
function private on_player_last_stand_revived( params )
{
    if ( level.s_hornet_boss.entity.var_d07937101f7ccc9f )
    {
        level.s_hornet_boss.entity.var_d07937101f7ccc9f++;
        level.s_hornet_boss.entity.var_d07937101f7ccc9f = minint( level.s_hornet_boss.entity.var_d07937101f7ccc9f, 4 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xfc54fb24, Offset: 0x712a
// Size: 0x2b
function private function_15d45e40acfbebac( params )
{
    if ( params.streakname == "zm_dinj" )
    {
        self.var_9dabcc4edb9438f = 1;
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x5070a62a, Offset: 0x715d
// Size: 0x37
function private function_783833e71587ca6d( params )
{
    if ( params.streakname == "zm_dinj" && self.var_9dabcc4edb9438f )
    {
        self.var_9dabcc4edb9438f = undefined;
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x8edaff7c, Offset: 0x719c
// Size: 0x17
function private function_ae5b33fac9103bfb( params )
{
    self.var_9dabcc4edb9438f = 1;
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xa4dbdfd0, Offset: 0x71bb
// Size: 0x16
function private on_remote_robot_ended( params )
{
    self.var_9dabcc4edb9438f = undefined;
}

// Namespace zm_sat_hornet_boss_fight
// Params 1
// Checksum 0x3bd90a96, Offset: 0x71d9
// Size: 0x21c
function function_e83b11eb8fabc062( params = [] )
{
    if ( arraycontains( params, "weapons" ) )
    {
        level thread function_5f0a50b61f3da74c();
        params = arrayremove( params, "weapons" );
    }
    
    if ( arraycontains( params, "force_pedestals" ) )
    {
        setdvar( @"hash_25e9bd8e4586dc95", 1 );
        params = arrayremove( params, "force_pedestals" );
    }
    
    foreach ( param in params )
    {
        if ( issubstr( param, "round" ) )
        {
            n_round = int( removesubstr( param, "round" ) );
        }
    }
    
    init_boss_fight_data( n_round );
    
    if ( !n_round )
    {
        n_round = function_b80976b7930587b4();
    }
    
    zm_round_logic::function_68bdb49c82c0f892( n_round );
    level.var_5b30c08562022091 = n_round;
    
    if ( arraycontains( params, "natural" ) )
    {
        zm_utility::open_sesame();
        
        foreach ( step in level.hornet_ww_quest.steps )
        {
            zm_quest::function_e65609834444650c( step );
        }
        
        zm_quest::function_11b75e2232ce3d4( [ "release_pearl", 1 ] );
        level zm_sat_hornet_mq_quest::function_af6027f41da042e3( 1 );
        wait 1;
        level utility::flag_set( "start_boss_fight" );
        level thread function_1e2e0a55b313622f();
        return;
    }
    else if ( arraycontains( params, "skip_intro" ) )
    {
        level.var_940a4ec67a9e7d5d = 1;
    }
    
    level.var_8bd966e8e0c1bbaa = 1;
    level thread start_boss_fight();
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x3a5f5d89, Offset: 0x73fd
// Size: 0x7b
function private function_5f0a50b61f3da74c()
{
    foreach ( player in level.players )
    {
        player thread function_e5292169f3b94171();
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0xc
// Checksum 0xff01a177, Offset: 0x7480
// Size: 0x3a5
function private function_e5292169f3b94171()
{
    self notify( #"hash_14608f8c47acbb38" );
    self endon( #"hash_14608f8c47acbb38" );
    player = self;
    player zombie_augments::function_eae5368ab01aaa9f();
    player zombie_augments::function_6dec499dd490fc54();
    player zombie_augments::function_ae34f860566cce0b( 3, 1 );
    player equipment_mp::giveequipment( "equip_blackhole_bomb", "secondary" );
    
    if ( getdvarint( @"hash_348d280a97829389", 0 ) || getdvarint( @"hash_858fa933221afe65", 0 ) )
    {
        weapon_rarity = 3;
        n_power_level = 2;
    }
    else
    {
        weapon_rarity = 4;
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
    player zombie_perks::give_perk( "specialty_y_mod" );
    player zombie_perks::give_perk( "specialty_z_mod" );
    player zombie_perks::give_perk( "specialty_vulture_aid" );
    player zm_armor::function_fdbe2cad6d8bb7e7( 3 );
    player armor::setarmorhealth( player.maxarmorhealth );
    player armor::function_164c824617d7e8d7( armor::function_db9ebf086f67fe92() );
    player currency::add_currency_amount( #"essence", 50000 );
    player killstreaks::awardkillstreak( utility::array_random( killstreaks ), "other", undefined, undefined, undefined, 1 );
    player thread zm::function_42d384ca3c76eee3();
    weapon = player function_cb38c050042391c5();
    player item_weapon::function_40e1cbd0e1f47d1a( weapon, weapon_rarity );
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
    
    player item_weapon::function_40e1cbd0e1f47d1a( weapon, weapon_rarity );
    weapon = player pack_a_punch::pap_weapon( weapon, int( max( n_power_level - 1, 0 ) ) );
    
    foreach ( player in level.players )
    {
        player bgb::function_c068e36660508e7c( "perkaholic" );
        player bgb::function_c068e36660508e7c( "near_death_experience" );
        player bgb::function_c068e36660508e7c( "idle_eyes" );
    }
    
    player = self;
    player function_692765e1fece04ba( weapon, ammo_mods );
    wait 5;
    player thread zm::function_1693f9e934b707ea( undefined, n_power_level );
    player thread zm::function_1693f9e934b707ea( undefined, n_power_level );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xe1f807c7, Offset: 0x782d
// Size: 0x9d
function private take_all_gobblegums()
{
    iprintlnbold( "Removing all players' gobblegums" );
    
    foreach ( player in level.players )
    {
        player bgb::take( 1 );
        player bgb::take( 2 );
        player bgb::take( 3 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xd90e956d, Offset: 0x78d2
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

// Namespace zm_sat_hornet_boss_fight
// Params 2, eflags: 0x4
// Checksum 0xa4fc81, Offset: 0x7910
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

// Namespace zm_sat_hornet_boss_fight
// Params 0
// Checksum 0x345c2dd, Offset: 0x7982
// Size: 0x39
function init_boss_fight_quest()
{
    level utility::flag_wait( "zm_quest_initialized" );
    callback::add( #"player_connect", &function_dd45775ae0ef0a7b );
    callback::add( #"hash_22fdd0c3eb081084", &function_f2a5f8f940f14e5e );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x9777d64f, Offset: 0x79c3
// Size: 0x79
function private function_dd45775ae0ef0a7b( params )
{
    if ( !level.completed_firefly_mq )
    {
        playerachievements::getstate( self, 54420 );
        playerachievements::getstate( self, 63431 );
    }
    
    if ( !level.completed_ruby_mq )
    {
        playerachievements::getstate( self, 64034 );
        playerachievements::getstate( self, 64041 );
    }
    
    if ( !level.completed_locust_mq )
    {
        playerachievements::getstate( self, 69556 );
        playerachievements::getstate( self, 69558 );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x8abdf0ee, Offset: 0x7a44
// Size: 0x16e
function private function_f2a5f8f940f14e5e( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !level.completed_firefly_mq )
    {
        if ( params.achievementid == 54420 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 54420, "progress", 0 ) )
            {
                level.completed_firefly_mq = 1;
            }
        }
        else if ( params.achievementid == 63431 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 63431, "progress", 0 ) )
            {
                level.completed_firefly_mq = 1;
            }
        }
    }
    
    if ( !level.completed_ruby_mq )
    {
        if ( params.achievementid == 64034 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 64034, "progress", 0 ) )
            {
                level.completed_ruby_mq = 1;
            }
        }
        else if ( params.achievementid == 64041 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 64041, "progress", 0 ) )
            {
                level.completed_ruby_mq = 1;
            }
        }
    }
    
    if ( !level.completed_locust_mq )
    {
        if ( params.achievementid == 69556 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69556, "progress", 0 ) )
            {
                level.completed_locust_mq = 1;
            }
            
            return;
        }
        
        if ( params.achievementid == 69558 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69558, "progress", 0 ) )
            {
                level.completed_locust_mq = 1;
            }
        }
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xd90b0527, Offset: 0x7bba
// Size: 0x3bb
function private init_pedestals()
{
    level endon( #"game_ended" );
    level.s_hornet_boss.a_pedestals = [];
    forcepedestals = getdvarint( @"hash_25e9bd8e4586dc95", 0 );
    
    if ( forcepedestals )
    {
        level.completed_firefly_mq = 1;
        level.completed_ruby_mq = 1;
        level.completed_locust_mq = 1;
    }
    
    if ( level.completed_firefly_mq )
    {
        var_7e2cd8efb19edebe = utility::drop_to_ground( ( 33878, 41706, 16653 ) ) - ( 0, 0, 100 );
        fireflymover = utility::spawn_model( "tag_origin", var_7e2cd8efb19edebe, ( 0, 135, 0 ) );
        var_416257c6ce1047fa = spawnscriptable( "zm_sat_hornet_boss_fight_firefly_pedestal", var_7e2cd8efb19edebe, ( 0, 135, 0 ) );
        var_416257c6ce1047fa scriptablesetparententity( fireflymover );
        fireflypedestal = { #mq_type:"firefly", #is_up:0, #spawnorigin:var_7e2cd8efb19edebe, #targetorigin:( 33878, 41706, 16653 ), #scriptable:var_416257c6ce1047fa, #mover:fireflymover };
        level.s_hornet_boss.a_pedestals[ level.s_hornet_boss.a_pedestals.size ] = fireflypedestal;
    }
    
    if ( level.completed_ruby_mq )
    {
        var_ef80f2c5712d0cd5 = utility::drop_to_ground( ( 32992, 42844, 16657 ) ) - ( 0, 0, 100 );
        rubymover = utility::spawn_model( "tag_origin", var_ef80f2c5712d0cd5, ( 0, 135, 0 ) );
        var_e71d5ebb9dd8b9b = spawnscriptable( "zm_sat_hornet_boss_fight_ruby_pedestal", var_ef80f2c5712d0cd5, ( 0, 135, 0 ) );
        var_e71d5ebb9dd8b9b scriptablesetparententity( rubymover );
        rubypedestal = { #mq_type:"ruby", #is_up:0, #spawnorigin:var_ef80f2c5712d0cd5, #targetorigin:( 32992, 42844, 16657 ), #scriptable:var_e71d5ebb9dd8b9b, #mover:rubymover };
        level.s_hornet_boss.a_pedestals[ level.s_hornet_boss.a_pedestals.size ] = rubypedestal;
    }
    
    if ( level.completed_locust_mq )
    {
        var_2ab96ae8f986c267 = utility::drop_to_ground( ( 32816, 41780, 16637 ) ) - ( 0, 0, 100 );
        locustmover = utility::spawn_model( "tag_origin", var_2ab96ae8f986c267, ( 0, 135, 0 ) );
        var_e0cf2ded89c9bf2d = spawnscriptable( "zm_sat_hornet_boss_fight_locust_pedestal", var_2ab96ae8f986c267, ( 0, 135, 0 ) );
        var_e0cf2ded89c9bf2d scriptablesetparententity( locustmover );
        locustpedestal = { #mq_type:"locust", #is_up:0, #spawnorigin:var_2ab96ae8f986c267, #targetorigin:( 32816, 41780, 16637 ), #scriptable:var_e0cf2ded89c9bf2d, #mover:locustmover };
        level.s_hornet_boss.a_pedestals[ level.s_hornet_boss.a_pedestals.size ] = locustpedestal;
    }
    
    if ( forcepedestals && getdvarint( @"hash_180bf2ccc08fe150", 0 ) )
    {
        level utility::flag_wait( "hornet_boss_fight_intro_complete" );
        level notify( #"hash_c765e7a3c3acfaa9" );
        level thread rise_pedestal( rubypedestal );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x19afe50f, Offset: 0x7f7d
// Size: 0x8f
function private rise_pedestal( pedestal )
{
    level endon( #"game_ended" );
    
    if ( !pedestal.is_up && pedestal.mover )
    {
        pedestal.scriptable utility::function_32b24db3127bff40( "vfx", "spawn" );
        pedestal.mover moveto( pedestal.targetorigin, 1 );
    }
    
    wait 1;
    pedestal.is_up = 1;
    thread function_c331f67f8d47263( pedestal );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x397f41a4, Offset: 0x8014
// Size: 0x95
function private function_4e101f45ae34c0f7()
{
    foreach ( pedestal in level.s_hornet_boss.a_pedestals )
    {
        if ( !istrue( pedestal.is_up ) )
        {
            thread rise_pedestal( pedestal );
        }
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x1c20b22c, Offset: 0x80b1
// Size: 0x140
function private function_c331f67f8d47263( pedestal )
{
    level endon( #"game_ended" );
    
    switch ( pedestal.mq_type )
    {
        case #"hash_4a893e97eed6857e":
            poweruptype = "hornet_firefly_boss";
            break;
        case #"hash_8e7d808fb46da1ad":
            poweruptype = "hornet_ruby_boss";
            break;
        case #"hash_a53322a24b88d15f":
            poweruptype = "hornet_locust_boss";
            break;
        default:
            return;
    }
    
    spawnpos = pedestal.targetorigin + ( 0, 0, 200 );
    restpos = pedestal.targetorigin + ( 0, 0, 60 );
    earthquake( 0.5, 1, pedestal.targetorigin, 2000 );
    wait 2;
    powerup = powerups::powerup_drop( poweruptype, spawnpos, -1 );
    powerup.angles = ( 0, 135, 0 );
    powerup moveto( restpos, 1.8, 0, 1.8 );
    pedestal.powerup = powerup;
    level thread function_8f2f326f9495df17( pedestal );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xf890e1c6, Offset: 0x81f9
// Size: 0x48
function private function_8f2f326f9495df17( pedestal )
{
    level endon( #"game_ended" );
    
    if ( !pedestal.powerup )
    {
        return;
    }
    
    pedestal.powerup waittill( #"death" );
    lower_pedestal( pedestal );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x56d16b02, Offset: 0x8249
// Size: 0x136
function private lower_pedestal( pedestal )
{
    level endon( #"game_ended" );
    pedestal.mover moveto( pedestal.spawnorigin, 1 );
    pedestal.mover waittill( #"movedone" );
    pedestal.scriptable utility::function_32b24db3127bff40( "vfx", "despawn" );
    pedestal.is_up = 0;
    pedestal.powerup = undefined;
    
    switch ( pedestal.mq_type )
    {
        case #"hash_4a893e97eed6857e":
        case #"hash_8e7d808fb46da1ad":
            level.s_hornet_boss.a_pedestals = arrayremove( level.s_hornet_boss.a_pedestals, pedestal );
            
            if ( pedestal.mover && pedestal.scriptable )
            {
                pedestal.mover delete();
                pedestal.scriptable freescriptable();
                pedestal = undefined;
            }
            
            break;
        case #"hash_a53322a24b88d15f":
            thread function_d14b8454c84a421a( pedestal );
            break;
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xaf774a6, Offset: 0x8387
// Size: 0xa4
function private function_d14b8454c84a421a( pedestal )
{
    level endon( #"game_ended" );
    level.s_hornet_boss.entity endon( #"death" );
    wait 450;
    pedestal.mover moveto( pedestal.targetorigin, 1 );
    pedestal.mover waittill( #"movedone" );
    pedestal.is_up = 1;
    pedestal.scriptable utility::function_32b24db3127bff40( "vfx", "spawn" );
    thread function_c331f67f8d47263( pedestal );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x1b66adee, Offset: 0x8433
// Size: 0x218
function private function_11d1867a975c9a73()
{
    if ( !level.s_hornet_boss.a_pedestals || level.s_hornet_boss.a_pedestals.size == 0 )
    {
        return;
    }
    
    foreach ( pedestal in level.s_hornet_boss.a_pedestals )
    {
        if ( pedestal.powerup )
        {
            pedestal.powerup delete();
            pedestal.powerup = undefined;
        }
        
        if ( pedestal.is_up && pedestal.mover )
        {
            pedestal.mover moveto( pedestal.spawnorigin, 1 );
        }
    }
    
    wait 1;
    
    foreach ( pedestal in level.s_hornet_boss.a_pedestals )
    {
        pedestal.scriptable utility::function_32b24db3127bff40( "vfx", "despawn" );
        pedestal.is_up = 0;
        
        if ( pedestal.mover && pedestal.scriptable )
        {
            pedestal.mover delete();
            pedestal.scriptable freescriptable();
            pedestal.scriptable = undefined;
            pedestal = undefined;
        }
    }
    
    level.s_hornet_boss.a_pedestals = undefined;
    zm_item_ammo::function_331d2418b6cdd643();
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xe5676809, Offset: 0x8653
// Size: 0x3, Type: bool
function private function_6ee60d5cadd9a4e6()
{
    return false;
}

// Namespace zm_sat_hornet_boss_fight
// Params 2, eflags: 0x4
// Checksum 0xe1951d76, Offset: 0x865f
// Size: 0x32
function private function_e414f20fd70c259a( str_powerup, ent_powerup )
{
    level endon( #"game_ended" );
    level thread function_edc3e626a957baf7( ent_powerup );
    function_a1bb921a5a7ca552();
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x32f87e03, Offset: 0x8699
// Size: 0x153
function private function_edc3e626a957baf7( ent_powerup )
{
    var_991810aa0c65d38b = 0;
    
    foreach ( player in level.players )
    {
        player thread powerups_cpmp::function_52318afc13635e7c( "hornet_firefly_boss", 0 );
        
        if ( player laststand::function_7072b516e6cffb7c() == 0 )
        {
            var_991810aa0c65d38b = 1;
        }
    }
    
    spawncount = 4;
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( ent_powerup.origin );
    
    if ( var_991810aa0c65d38b )
    {
        spawncount--;
        common_item::function_61c2c0251e742ffd( %"hash_428e5b0816d1da5f", 1, spawnoptions );
    }
    
    spawnlist = "zm_sat_hornet_boss_firefly_blessing_item_list";
    
    if ( level.gametype == "zm_rb_r_mod" )
    {
        switch ( level.zm_relic_tier )
        {
            case 2:
                spawnlist = "zm_sat_hornet_boss_firefly_blessing_cursed_tier2_item_list";
                break;
            case 3:
                spawnlist = "zm_sat_hornet_boss_firefly_blessing_cursed_tier3_item_list";
                break;
        }
    }
    
    common_item::function_38cde6a6acb68ea6( spawnlist, spawncount, spawnoptions );
}

// Namespace zm_sat_hornet_boss_fight
// Params 2, eflags: 0x4
// Checksum 0x15a5f421, Offset: 0x87f4
// Size: 0xd2
function private function_bac94abddc2388ed( str_powerup, ent_powerup )
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        player thread powerups_cpmp::function_52318afc13635e7c( "hornet_ruby_boss", 45 );
        player thread full_ammo::function_cf46f312587658ee();
        powerupendtime = gettime() + utility::function_4b74c15943231980( 45 );
        player thread give_fireballs( powerupendtime );
    }
    
    function_9267566f36e93731();
}

// Namespace zm_sat_hornet_boss_fight
// Params 1
// Checksum 0xb0f83167, Offset: 0x88ce
// Size: 0x27b
function give_fireballs( powerupendtime )
{
    self endon( #"death_or_disconnect" );
    
    if ( utility::ent_flag( "wiley_fox_active" ) )
    {
        duration = utility::function_6f5d2e1f1ff70482( powerupendtime - gettime() );
        
        if ( duration < 0 )
        {
            return;
        }
        
        utility::ent_flag_waitopen_or_timeout( "wiley_fox_active", duration );
    }
    
    duration = utility::function_6f5d2e1f1ff70482( powerupendtime - gettime() );
    
    if ( isalive( self ) && duration > 0 )
    {
        if ( !isdefined( self.wiley_fox_settings ) )
        {
            self.wiley_fox_settings = spawnstruct();
        }
        
        self.wiley_fox_settings.active = 1;
        self.wiley_fox_settings.var_8ba032eda7c0ca98 = level.zombie_augments[ #"wiley_fox_fireball" ].var_64f4cfdade7b61ff ?? 1;
        self.wiley_fox_settings.fireball_damage_percent = level.zombie_augments[ #"wiley_fox_fireball" ].var_2156771241445406 ?? 0.5;
        self.wiley_fox_settings.fireball_fire_rate = level.zombie_augments[ #"wiley_fox_fireball" ].var_de1de3409eb1b39e ?? 0.5;
        self.wiley_fox_settings.fireball_range = level.zombie_augments[ #"wiley_fox_fireball" ].var_ed968622dc45b2ad ?? 2000;
        self.wiley_fox_settings.fireball_radius = level.zombie_augments[ #"wiley_fox_fireball" ].var_87d11b3b87126b4e ?? 5;
        self.wiley_fox_settings.fireball_up_offset = level.zombie_augments[ #"wiley_fox_fireball" ].var_435fe595d1117a3f ?? 0.5;
        self.wiley_fox_settings.fireball_horizontal_offset = level.zombie_augments[ #"wiley_fox_fireball" ].var_61b66704783b8482 ?? 0.5;
        self.wiley_fox_settings.fireball_forward_offset = level.zombie_augments[ #"wiley_fox_fireball" ].var_34753bf4907a539 ?? 0.5;
        thread field_upgrades_wiley_fox::fireball_activate();
        utility::delaycall( duration, &kill_fireballs );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x4d923c03, Offset: 0x8b51
// Size: 0x21
function private kill_fireballs()
{
    if ( self.wiley_fox_settings )
    {
        self.wiley_fox_settings.active = undefined;
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 2, eflags: 0x4
// Checksum 0xbe1a31b8, Offset: 0x8b7a
// Size: 0x1d1
function private function_baf213ed02ae7e83( str_powerup, ent_powerup )
{
    level endon( #"game_ended" );
    
    foreach ( var_d2d81d749e4b1cc9 in level.talisman_system.talismans )
    {
        switch ( var_d2d81d749e4b1cc9.state )
        {
            case #"hash_61f1a95d6bf95699":
                continue;
            case #"hash_bee8aefcdf5a9a8f":
                var_d2d81d749e4b1cc9.scriptable notify( #"talisman_activated_via_locust_powerup" );
                var_d2d81d749e4b1cc9.var_833fa5c081e5e9e5 = 1;
                break;
            case #"hash_174d75faff6dcf22":
            case #"hash_2c6dd295e7428eef":
            case #"hash_f2b431c975ba652c":
            case #"hash_feb6a1f938941775":
                zm_sat_hornet_talisman::function_4a11d946b66c1758( var_d2d81d749e4b1cc9 );
                break;
        }
        
        zm_sat_hornet_talisman::set_talisman_state( var_d2d81d749e4b1cc9, "active", level.s_hornet_boss.entity );
    }
    
    foreach ( player in level.players )
    {
        player thread powerups_cpmp::function_52318afc13635e7c( "hornet_locust_boss", 0 );
    }
    
    function_6cbc2ac04f3ad56b();
}

// Namespace zm_sat_hornet_boss_fight
// Params 0
// Checksum 0xe7600da8, Offset: 0x8d53
// Size: 0x43
function function_925c4af01cebb500()
{
    self.var_51a3642a860acf96 = gettime();
    self.var_6b5d4239a4e96045 = gettime();
    self.var_8ad388b7caa4eff9 = gettime();
    self.var_fc5df94b84690417 = gettime();
    self.var_8fad37f51430ed9d = gettime();
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x6c4074ea, Offset: 0x8d9e
// Size: 0x1e1
function private function_5597c1d89e08301e( var_e78bdb075ae542da )
{
    possible_bundles = [];
    
    if ( isdefined( level.directed_mode ) || getdvarint( @"hash_858fa933221afe65", 0 ) )
    {
        possible_bundles[ possible_bundles.size ] = "zm_guided";
    }
    else if ( level.var_8a98c33a6b47db4a )
    {
        switch ( level.zm_relic_tier )
        {
            case 0:
                if ( ( var_e78bdb075ae542da ?? zm_utility::get_round_number() ) >= 100 )
                {
                    possible_bundles[ possible_bundles.size ] = "zm_rb_r_mod_tier0_round100";
                }
                else
                {
                    possible_bundles[ possible_bundles.size ] = "zm_rb_r_mod_tier0";
                }
                
                break;
            case 1:
            case 2:
            case 3:
                if ( ( var_e78bdb075ae542da ?? zm_utility::get_round_number() ) >= 100 )
                {
                    possible_bundles[ possible_bundles.size ] = "zm_rb_r_mod_tier1_round100";
                }
                else
                {
                    possible_bundles[ possible_bundles.size ] = "zm_rb_r_mod_tier1";
                }
                
                break;
        }
    }
    else if ( ( var_e78bdb075ae542da ?? zm_utility::get_round_number() ) >= 100 )
    {
        possible_bundles[ possible_bundles.size ] = "round100";
    }
    
    possible_bundles[ possible_bundles.size ] = "default";
    var_86976c7090853462 = getscriptbundlenames( "hornetbossfightsetting" );
    
    for ( bundle_i = 0; bundle_i < possible_bundles.size ; bundle_i++ )
    {
        var_1f839ab22d85993e = possible_bundles[ bundle_i ];
        
        if ( isdefined( var_1f839ab22d85993e ) )
        {
            foreach ( bundle_name in var_86976c7090853462 )
            {
                selectorid = getscriptbundlefieldvalue( bundle_name, "selectorID" );
                
                if ( var_1f839ab22d85993e == selectorid )
                {
                    return getscriptbundle( bundle_name );
                }
            }
        }
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x7f50230b, Offset: 0x8f88
// Size: 0x37b
function private init_boss_fight_data( var_e78bdb075ae542da )
{
    var_713e58edbcfc94fd = function_5597c1d89e08301e( var_e78bdb075ae542da );
    
    if ( !isdefined( var_713e58edbcfc94fd ) )
    {
        return;
    }
    
    level.s_hornet_boss.maxhealthmultiplier = var_713e58edbcfc94fd.maxhealthmultiplier;
    level.s_hornet_boss.var_6b7fb2da3cdf5121 = var_713e58edbcfc94fd.var_6b7fb2da3cdf5121;
    level.s_hornet_boss.var_6b83b8da3ce3542a = var_713e58edbcfc94fd.var_6b83b8da3ce3542a;
    level.s_hornet_boss.var_6b889eda3ce943d3 = var_713e58edbcfc94fd.var_6b889eda3ce943d3;
    level.s_hornet_boss.var_6b8ca4da3ced46dc = var_713e58edbcfc94fd.var_6b8ca4da3ced46dc;
    level.s_hornet_boss.var_f1e8ce0d92289759 = var_713e58edbcfc94fd.var_f1e8ce0d92289759;
    
    if ( level.s_hornet_boss.var_f1e8ce0d92289759 == "itemspawnlist:" || level.s_hornet_boss.var_f1e8ce0d92289759 == "" )
    {
        level.s_hornet_boss.var_f1e8ce0d92289759 = undefined;
    }
    
    level.s_hornet_boss.var_754b9305e6d92db9 = var_713e58edbcfc94fd.var_754b9305e6d92db9;
    level.s_hornet_boss.var_2a9625e4994e3b70 = var_713e58edbcfc94fd.var_2a9625e4994e3b70;
    level.s_hornet_boss.var_eb5d30136560fd73 = var_713e58edbcfc94fd.var_eb5d30136560fd73;
    level.s_hornet_boss.var_b637cf356e0e8ff5 = var_713e58edbcfc94fd.var_b637cf356e0e8ff5;
    level.s_hornet_boss.var_48401477c1fa0414 = var_713e58edbcfc94fd.var_48401477c1fa0414;
    level.s_hornet_boss.var_1d344e7d3e199ee1 = var_713e58edbcfc94fd.var_1d344e7d3e199ee1;
    level.s_hornet_boss.var_3bc8868c04316fb3 = var_713e58edbcfc94fd.var_3bc8868c04316fb3;
    level.s_hornet_boss.var_2a0d1547118ddc25 = var_713e58edbcfc94fd.var_2a0d1547118ddc25;
    level.s_hornet_boss.var_eb822575c28a2007 = var_713e58edbcfc94fd.var_eb822575c28a2007;
    level.s_hornet_boss.var_4b68c903144fea03 = var_713e58edbcfc94fd.var_4b68c903144fea03;
    level.s_hornet_boss.var_8a51c7aa42fd7382 = var_713e58edbcfc94fd.var_8a51c7aa42fd7382;
    level.s_hornet_boss.var_11acdfdbbfadf4b9 = var_713e58edbcfc94fd.var_11acdfdbbfadf4b9;
    level.s_hornet_boss.var_c4dd99c9fb22b0b4 = var_713e58edbcfc94fd.var_c4dd99c9fb22b0b4;
    level.s_hornet_boss.var_5622075a17b9e84 = var_713e58edbcfc94fd.var_5622075a17b9e84;
    level.s_hornet_boss.var_10cee2dd281613f0 = var_713e58edbcfc94fd.var_10cee2dd281613f0;
    level.s_hornet_boss.var_689aac61e0378208 = var_713e58edbcfc94fd.var_689aac61e0378208;
    level.s_hornet_boss.var_a3c1ec18fc553adc = var_713e58edbcfc94fd.var_a3c1ec18fc553adc;
    level.s_hornet_boss.var_6b1405438bf971d = var_713e58edbcfc94fd.var_6b1405438bf971d;
    level.s_hornet_boss.var_811a1d3d27b1c649 = var_713e58edbcfc94fd.var_811a1d3d27b1c649;
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x64e223bb, Offset: 0x930b
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

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xb10c9901, Offset: 0x93d8
// Size: 0x6a
function private function_5b30f1c3121ebd3d( params )
{
    level endon( #"game_ended" );
    var_818a3d5fe05d1387 = params.player;
    
    if ( var_818a3d5fe05d1387 namespace_c0b4f2882c9d100f::is_hero_operator() && !var_818a3d5fe05d1387.var_140e32d400278fc8 )
    {
        var_818a3d5fe05d1387.var_140e32d400278fc8 = 1;
        var_818a3d5fe05d1387 thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_7f7cef7e13a01d0b" );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xc510adfb, Offset: 0x944a
// Size: 0x6a
function private function_ca1dd86df715131e( params )
{
    level endon( #"game_ended" );
    player = params.player;
    
    if ( player namespace_c0b4f2882c9d100f::is_hero_operator() && !player.var_2e728534ef6515 )
    {
        player.var_2e728534ef6515 = 1;
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_2b0d169a48917c66" );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x31c5ae98, Offset: 0x94bc
// Size: 0x137
function private function_aa51e33623984e71( params )
{
    level endon( #"game_ended" );
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    talisman_origin = params.var_d2d81d749e4b1cc9.scriptable.origin;
    var_f43eb6e734c44585 = arraycopy( level.players );
    var_f43eb6e734c44585 = function_1465e47b0eb098c0( var_f43eb6e734c44585 );
    
    if ( var_f43eb6e734c44585.size < 1 )
    {
        return;
    }
    
    var_b2d3fdd84b0be01c = sortbydistance( var_f43eb6e734c44585, talisman_origin );
    
    foreach ( var_1e808b59bbcd9f74 in var_b2d3fdd84b0be01c )
    {
        if ( var_1e808b59bbcd9f74.var_93c75f0c78400168 != 1 )
        {
            var_1e808b59bbcd9f74.var_93c75f0c78400168 = 1;
            level thread function_e02c2d4bd07aeec9( var_1e808b59bbcd9f74 );
            return;
        }
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xce7dc07d, Offset: 0x95fb
// Size: 0xb3
function private function_1465e47b0eb098c0( a_potential_players )
{
    var_f43eb6e734c44585 = a_potential_players;
    
    foreach ( player in a_potential_players )
    {
        if ( !zm_utility::is_player_valid_target( player ) || player::isinlaststand( player ) || player.var_93c75f0c78400168 )
        {
            var_f43eb6e734c44585 = arrayremove( var_f43eb6e734c44585, player );
        }
    }
    
    return var_f43eb6e734c44585;
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x4f21a3da, Offset: 0x96b7
// Size: 0x87
function private function_e02c2d4bd07aeec9( player )
{
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    var_ab5b5e70e99e5b55 = 0.5;
    level endon( #"game_ended" );
    wait var_ab5b5e70e99e5b55;
    
    if ( !zm_utility::is_player_valid_target( player ) || player::isinlaststand( player ) )
    {
        return;
    }
    
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_a8c67069e10078a9", #"bc_flavor_player_positive" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xc88d0dd1, Offset: 0x9746
// Size: 0x38
function private function_a1bb921a5a7ca552()
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "vo_pedestal_firefly_played" ) )
    {
        return;
    }
    
    level utility::flag_set( "vo_pedestal_firefly_played" );
    level thread dialogue::say( "dx_zm_hobf_hbf1_ssfh_hbf1usevtnped" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xee1a0d84, Offset: 0x9786
// Size: 0x38
function private function_9267566f36e93731()
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "vo_pedestal_ruby_played" ) )
    {
        return;
    }
    
    level utility::flag_set( "vo_pedestal_ruby_played" );
    level thread dialogue::say( "dx_zm_hobf_hbf1_ssrh_hbf1usecalped" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xaaf64717, Offset: 0x97c6
// Size: 0x38
function private function_6cbc2ac04f3ad56b()
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "vo_pedestal_locust_played" ) )
    {
        return;
    }
    
    level utility::flag_set( "vo_pedestal_locust_played" );
    level thread dialogue::say( "dx_zm_hobf_hbf1_sslh_hbf1usedvkped" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x59b41a10, Offset: 0x9806
// Size: 0xba
function private function_c0770da56d534c29( params )
{
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    var_920959344a3f774b = 0.5;
    level endon( #"game_ended" );
    
    if ( level utility::flag( "vo_boss_arrival_played" ) )
    {
        return;
    }
    
    level utility::flag_set( "vo_boss_arrival_played" );
    wait var_920959344a3f774b;
    level.s_hornet_boss.entity dialogue::say( "dx_zm_hobf_hbf1_ssho_hbf1nyaarr" );
    player = function_1b9aca015902dbdf();
    
    if ( isplayer( player ) )
    {
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_d39001c4b59875f0" );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xa0cefc2c, Offset: 0x98c8
// Size: 0x8b
function private function_204df2ffbabdf66c( params )
{
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    level endon( #"game_ended" );
    player = function_1b9aca015902dbdf();
    
    if ( !isplayer( player ) || player.var_dac2388cfeaff7a3 )
    {
        return;
    }
    
    player.var_dac2388cfeaff7a3 = 1;
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_83cfba74c07f3c2f" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x72ded8d9, Offset: 0x995b
// Size: 0x193
function private function_f34180c393ded962( params )
{
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    var_9991104ac90e37df = 500;
    level endon( #"game_ended" );
    var_52a111264f33ff56 = [];
    
    foreach ( player in level.players )
    {
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() && zm_utility::is_player_valid_target( player ) && !player::isinlaststand( player ) && !player.var_de3952b3f92f4236 )
        {
            var_52a111264f33ff56[ var_52a111264f33ff56.size ] = player;
        }
    }
    
    if ( var_52a111264f33ff56.size > 0 )
    {
        player = utility::array_random( var_52a111264f33ff56 );
    }
    
    if ( !isplayer( player ) || player.var_de3952b3f92f4236 )
    {
        return;
    }
    
    current_time = gettime();
    
    if ( isdefined( level.var_14f159f75be615c2 ) && current_time - level.var_14f159f75be615c2 < var_9991104ac90e37df )
    {
        return;
    }
    
    level.var_14f159f75be615c2 = current_time;
    player.var_de3952b3f92f4236 = 1;
    player.var_de3952b3f92f4236 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_c46164c975bcef6b" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xfd7e14a, Offset: 0x9af6
// Size: 0xaa
function private function_60902db3e5b28ef3( phase )
{
    level endon( #"game_ended" );
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    
    if ( phase == 2 )
    {
        level thread dialogue::say( "dx_zm_hobf_hbf1_ssho_hbf1ssmet1" );
        return;
    }
    
    if ( phase == 3 )
    {
        player = function_1b9aca015902dbdf();
        
        if ( isplayer( player ) && !player.var_4f358159f4fb0139 )
        {
            player.var_4f358159f4fb0139 = 1;
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_eeb77b35a5c746e3" );
        }
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x89b2c370, Offset: 0x9ba8
// Size: 0x8b
function private vo_summon_scorched_zombies( params )
{
    level endon( #"game_ended" );
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    
    if ( level utility::flag( "vo_summon_scorched_zombies_played" ) )
    {
        return;
    }
    
    level utility::flag_set( "vo_summon_scorched_zombies_played" );
    player = function_1b9aca015902dbdf();
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_a4194d29e8e35ae5" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xcee4af5f, Offset: 0x9c3b
// Size: 0x7b
function private vo_on_player_downed( params )
{
    level endon( #"game_ended" );
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    
    if ( level utility::flag( "vo_player_death_played" ) )
    {
        return;
    }
    
    level utility::flag_set( "vo_player_death_played" );
    level.s_hornet_boss.entity thread dialogue::say( "dx_zm_hobf_hbf2_ssho_hbf2plydth" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x48d9f2a6, Offset: 0x9cbe
// Size: 0xa9
function private function_1d17d9de32b04fdd( params )
{
    level endon( #"game_ended" );
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    player = params.player;
    
    if ( !isplayer( player ) || player.var_d2bcde0c4b22efc0 || !player namespace_c0b4f2882c9d100f::is_hero_operator() || player::isinlaststand( player ) )
    {
        return;
    }
    
    player.var_d2bcde0c4b22efc0 = 1;
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_c1dd6301007de7f8" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xf7fe6e3e, Offset: 0x9d6f
// Size: 0x192
function private function_8213cb4b60c86c7d( params )
{
    vo_global_cooldown = 30000;
    level endon( #"game_ended" );
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    var_52a111264f33ff56 = [];
    
    foreach ( player in level.players )
    {
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() && zm_utility::is_player_valid_target( player ) && !player::isinlaststand( player ) && !player.var_5f71f42450b45e7a )
        {
            var_52a111264f33ff56[ var_52a111264f33ff56.size ] = player;
        }
    }
    
    if ( var_52a111264f33ff56.size > 0 )
    {
        player = utility::array_random( var_52a111264f33ff56 );
    }
    
    if ( !isplayer( player ) || player.var_5f71f42450b45e7a )
    {
        return;
    }
    
    current_time = gettime();
    
    if ( level.var_9528db0c714c78ae && current_time - level.var_9528db0c714c78ae < vo_global_cooldown )
    {
        return;
    }
    
    level.var_9528db0c714c78ae = current_time;
    player.var_5f71f42450b45e7a = 1;
    player.var_5f71f42450b45e7a = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_e3fee86450b79f22" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xbeead75b, Offset: 0x9f09
// Size: 0x93
function private function_a09bf37439e1d3f()
{
    var_fe4d3ac477fa435a = 0.5;
    level endon( #"game_ended" );
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    wait var_fe4d3ac477fa435a;
    level.s_hornet_boss.entity dialogue::say( "dx_zm_hobf_hbf2_ssho_hbf2nyrtn1" );
    player = function_1b9aca015902dbdf();
    
    if ( isplayer( player ) )
    {
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_9159d74b6a7e835a" );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x50e4b020, Offset: 0x9fa4
// Size: 0x93
function private function_a09be37439e1b0c()
{
    var_fe4d3ac477fa435a = 0.5;
    level endon( #"game_ended" );
    level.s_hornet_boss.entity endon( #"death", #"diana_death_igc_transition" );
    wait var_fe4d3ac477fa435a;
    level.s_hornet_boss.entity dialogue::say( "dx_zm_hobf_hbf2_ssho_hbf2nyrtn2" );
    player = function_1b9aca015902dbdf();
    
    if ( isplayer( player ) )
    {
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_9159d84b6a7e850d" );
    }
}

// Namespace zm_sat_hornet_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xf77dc427, Offset: 0xa03f
// Size: 0x75
function private vo_boss_defeated()
{
    level endon( #"game_ended" );
    player = function_1b9aca015902dbdf();
    
    if ( !isdefined( player ) && level.players.size > 0 )
    {
        player = utility::array_random( level.players );
    }
    
    if ( isdefined( player ) )
    {
        player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"boss_defeated", #"bc_flavor_player_positive" );
    }
    
    utility::flag_set( "diana_defeated_vo_played" );
}

// Namespace zm_sat_hornet_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x8a0ef869, Offset: 0xa0bc
// Size: 0xde
function private debug_play_outro_igc( params )
{
    if ( isalive( level.s_hornet_boss.entity ) )
    {
        if ( !utility::flag( "hornet_boss_fight_intro_complete" ) )
        {
            level utility::flag_set( "hornet_boss_fight_intro_complete" );
            wait 2;
        }
        
        level.s_hornet_boss.entity.var_382b3e1f72536e3c = undefined;
        level.s_hornet_boss.entity.health = 1;
        function_9cc2b48802345520();
        level.s_hornet_boss.entity utility::delaycall( 1, &dodamage, 999, level.s_hornet_boss.entity.origin, level.players[ 0 ] );
        return;
    }
    
    level thread function_1b0b03050cb7f8f7();
}

/#

    // Namespace zm_sat_hornet_boss_fight
    // Params 0
    // Checksum 0xb8c16cfa, Offset: 0xa1a2
    // Size: 0x150, Type: dev
    function boss_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3c>", "<dev string:x4e>", &function_8ef95d5d6219b790 );
        devgui::add_devgui_func( "<dev string:x64>", "<dev string:x75>", &function_e83b11eb8fabc062 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x86>", "<dev string:xa1>", &function_e83b11eb8fabc062 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xba>", "<dev string:xd8>", &function_e83b11eb8fabc062 );
        devgui::add_devgui_func( "<dev string:xf4>", "<dev string:x119>", &function_55316b255d7c446b, 1 );
        devgui::add_devgui_func( "<dev string:x135>", "<dev string:x155>", &function_ffeed757c6391a5, 1 );
        devgui::add_devgui_func( "<dev string:x172>", "<dev string:x183>", &set_pedestal_up );
        devgui::add_devgui_func( "<dev string:x193>", "<dev string:x1a6>", &set_pedestal_down );
        devgui::add_devgui_func( "<dev string:x1b8>", "<dev string:x1c8>", &function_358d6056fe05320a );
        devgui::add_devgui_func( "<dev string:x1d8>", "<dev string:x1f6>", &function_5f8649add82ddc53 );
        devgui::add_devgui_func( "<dev string:x212>", "<dev string:x222>", &function_358d6156fe05343d );
        devgui::add_devgui_func( "<dev string:x232>", "<dev string:x250>", &function_3b0cbe4dfcb78222 );
        devgui::add_devgui_func( "<dev string:x26c>", "<dev string:x27d>", &dev_skip_hibernation );
        devgui::add_devgui_func( "<dev string:x28e>", "<dev string:x29d>", &debug_play_outro_igc );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_hornet_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x2bd2523e, Offset: 0xa2fa
    // Size: 0x188, Type: dev
    function private set_pedestal_up()
    {
        level endon( #"death" );
        function_ab1080bcd2b3a1c4();
        
        foreach ( pedestal in level.s_hornet_boss.a_pedestals )
        {
            if ( !pedestal.is_up && pedestal.mover )
            {
                pedestal.scriptable utility::function_32b24db3127bff40( "<dev string:x2b2>", "<dev string:x2b6>" );
                pedestal.mover moveto( pedestal.targetorigin, 1 );
                pedestal.is_up = 1;
            }
        }
        
        wait 1;
        
        foreach ( pedestal in level.s_hornet_boss.a_pedestals )
        {
            if ( !pedestal.powerup )
            {
                thread function_c331f67f8d47263( pedestal );
            }
        }
    }

    // Namespace zm_sat_hornet_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xc4013d8b, Offset: 0xa48a
    // Size: 0x2a9, Type: dev
    function private function_ab1080bcd2b3a1c4()
    {
        var_c30a85159c9cfe55 = [];
        
        foreach ( pedestal in level.s_hornet_boss.a_pedestals )
        {
            var_c30a85159c9cfe55[ var_c30a85159c9cfe55.size ] = pedestal.mq_type;
        }
        
        if ( !arraycontains( var_c30a85159c9cfe55, "<dev string:x2bc>" ) )
        {
            fireflyspawnorigin = ( 33878, 41706, 16653 ) - ( 0, 0, 100 );
            fireflymover = utility::spawn_model( "<dev string:x2c4>", fireflyspawnorigin, ( 0, 135, 0 ) );
            fireflyscriptable = spawnscriptable( "<dev string:x2cf>", fireflyspawnorigin, ( 0, 135, 0 ) );
            fireflyscriptable scriptablesetparententity( fireflymover );
            fireflypedestal = { #mq_type:"<dev string:x2bc>", #is_up:0, #spawnorigin:fireflyspawnorigin, #targetorigin:( 33878, 41706, 16653 ), #scriptable:fireflyscriptable, #mover:fireflymover };
            level.s_hornet_boss.a_pedestals[ level.s_hornet_boss.a_pedestals.size ] = fireflypedestal;
        }
        
        if ( !arraycontains( var_c30a85159c9cfe55, "<dev string:x2f9>" ) )
        {
            rubyspawnorigin = ( 32992, 42844, 16657 ) - ( 0, 0, 100 );
            rubymover = utility::spawn_model( "<dev string:x2c4>", rubyspawnorigin, ( 0, 135, 0 ) );
            rubyscriptable = spawnscriptable( "<dev string:x2fe>", rubyspawnorigin, ( 0, 135, 0 ) );
            rubyscriptable scriptablesetparententity( rubymover );
            rubypedestal = { #mq_type:"<dev string:x2f9>", #is_up:0, #spawnorigin:rubyspawnorigin, #targetorigin:( 32992, 42844, 16657 ), #scriptable:rubyscriptable, #mover:rubymover };
            level.s_hornet_boss.a_pedestals[ level.s_hornet_boss.a_pedestals.size ] = rubypedestal;
        }
    }

    // Namespace zm_sat_hornet_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x4a7b1ec7, Offset: 0xa73b
    // Size: 0xf1, Type: dev
    function private set_pedestal_down()
    {
        level endon( #"death" );
        
        foreach ( pedestal in level.s_hornet_boss.a_pedestals )
        {
            if ( pedestal.is_up && pedestal.mover )
            {
                pedestal.scriptable utility::function_32b24db3127bff40( "<dev string:x2b2>", "<dev string:x325>" );
                pedestal.mover moveto( pedestal.spawnorigin, 1 );
                pedestal.is_up = 0;
            }
        }
    }

    // Namespace zm_sat_hornet_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xfbcf9836, Offset: 0xa834
    // Size: 0xc0, Type: dev
    function private function_ffeed757c6391a5()
    {
        level endon( #"death" );
        
        while ( true )
        {
            foreach ( pedestal in level.s_hornet_boss.a_pedestals )
            {
                sphere( pedestal.mover.origin, 50, ( 1, 0, 0 ), 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_hornet_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x1b5d56c5, Offset: 0xa8fc
    // Size: 0x15b, Type: dev
    function private function_358d6056fe05320a()
    {
        if ( !level.var_8bd966e8e0c1bbaa )
        {
            function_e83b11eb8fabc062();
            level waittill( #"hornet_boss_fight_init_complete" );
        }
        
        if ( !isalive( level.s_hornet_boss.entity ) || level utility::flag( "<dev string:x329>" ) )
        {
            return;
        }
        
        level.var_940a4ec67a9e7d5d = 1;
        function_3c456501ed652cc1();
        setdvar( @"hash_ec4f031582b94425", 1 );
        setdvar( @"hash_85a66692f812170f", 0 );
        var_bddcd5de72042f4b = level.s_hornet_boss.entity.var_f8115155adde44d[ level.s_hornet_boss.entity.bossfightphase ] * level.s_hornet_boss.entity.maxhealth;
        level.s_hornet_boss.entity.health = int( var_bddcd5de72042f4b - 1 );
        level.s_hornet_boss.entity.bossfightphase = 2;
        level.s_hornet_boss.entity callback::callback( "<dev string:x33b>" );
        level utility::flag_set( "<dev string:x329>" );
    }

    // Namespace zm_sat_hornet_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xfd1e9a30, Offset: 0xaa5f
    // Size: 0x184, Type: dev
    function private function_358d6156fe05343d()
    {
        if ( !level.var_8bd966e8e0c1bbaa )
        {
            function_e83b11eb8fabc062();
            level waittill( #"hornet_boss_fight_init_complete" );
        }
        
        if ( !isalive( level.s_hornet_boss.entity ) || level utility::flag( "<dev string:x34b>" ) )
        {
            return;
        }
        
        if ( !level utility::flag( "<dev string:x329>" ) )
        {
            function_358d6056fe05320a();
        }
        
        setdvar( @"hash_ec4f021582b941f2", 1 );
        setdvar( @"hash_85a66692f812170f", 0 );
        var_bddcd5de72042f4b = level.s_hornet_boss.entity.var_f8115155adde44d[ level.s_hornet_boss.entity.bossfightphase ] * level.s_hornet_boss.entity.maxhealth;
        level.s_hornet_boss.entity.health = int( var_bddcd5de72042f4b - 1 );
        level.s_hornet_boss.entity.bossfightphase = 3;
        level.s_hornet_boss.entity callback::callback( "<dev string:x33b>" );
        level utility::flag_set( "<dev string:x34b>" );
        level.s_hornet_boss.entity callback::remove( "<dev string:x35c>", &function_263a6b7ab8df6028 );
    }

    // Namespace zm_sat_hornet_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x1d518e48, Offset: 0xabeb
    // Size: 0x2d, Type: dev
    function private dev_skip_hibernation()
    {
        if ( !isalive( level.s_hornet_boss.entity ) )
        {
            return;
        }
        
        level notify( #"dev_skip_hibernation" );
    }

    // Namespace zm_sat_hornet_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x4abcb8a5, Offset: 0xac20
    // Size: 0x151, Type: dev
    function private function_5f8649add82ddc53()
    {
        if ( !level.var_8bd966e8e0c1bbaa )
        {
            function_e83b11eb8fabc062();
            level waittill( #"hornet_boss_fight_init_complete" );
        }
        
        if ( !isalive( level.s_hornet_boss.entity ) || level utility::flag( "<dev string:x329>" ) )
        {
            return;
        }
        
        function_3c456501ed652cc1();
        setdvar( @"hash_ec4f031582b94425", 1 );
        setdvar( @"hash_85a66692f812170f", 1 );
        var_bddcd5de72042f4b = level.s_hornet_boss.entity.var_f8115155adde44d[ level.s_hornet_boss.entity.bossfightphase ] * level.s_hornet_boss.entity.maxhealth;
        level.s_hornet_boss.entity.health = int( var_bddcd5de72042f4b - 1 );
        level.s_hornet_boss.entity.bossfightphase = 2;
        level.s_hornet_boss.entity callback::callback( "<dev string:x33b>" );
        level utility::flag_set( "<dev string:x329>" );
    }

    // Namespace zm_sat_hornet_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x698af232, Offset: 0xad79
    // Size: 0x185, Type: dev
    function private function_3b0cbe4dfcb78222()
    {
        if ( !level.var_8bd966e8e0c1bbaa )
        {
            function_e83b11eb8fabc062();
            level waittill( #"hornet_boss_fight_init_complete" );
        }
        
        if ( !isalive( level.s_hornet_boss.entity ) || level utility::flag( "<dev string:x34b>" ) )
        {
            return;
        }
        
        if ( !level utility::flag( "<dev string:x329>" ) )
        {
            function_358d6056fe05320a();
        }
        
        setdvar( @"hash_ec4f021582b941f2", 1 );
        setdvar( @"hash_1e077c52817a6ac0", 1 );
        var_bddcd5de72042f4b = level.s_hornet_boss.entity.var_f8115155adde44d[ level.s_hornet_boss.entity.bossfightphase ] * level.s_hornet_boss.entity.maxhealth;
        level.s_hornet_boss.entity.health = int( var_bddcd5de72042f4b - 1 );
        level.s_hornet_boss.entity.bossfightphase = 3;
        level.s_hornet_boss.entity callback::callback( "<dev string:x33b>" );
        level utility::flag_set( "<dev string:x34b>" );
        level.s_hornet_boss.entity callback::remove( "<dev string:x35c>", &function_263a6b7ab8df6028 );
    }

    // Namespace zm_sat_hornet_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x5d3597a8, Offset: 0xaf06
    // Size: 0x20, Type: dev
    function private function_3c456501ed652cc1()
    {
        if ( !utility::flag( "<dev string:x371>" ) )
        {
            level notify( #"hash_4f8663a9389008fd" );
        }
    }

    // Namespace zm_sat_hornet_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xfc87d1c7, Offset: 0xaf2e
    // Size: 0xea, Type: dev
    function private function_55316b255d7c446b()
    {
        level endon( #"death" );
        
        while ( true )
        {
            sphere( level.s_hornet_boss.boss_pos_a.origin, 50, ( 1, 0, 0 ), 0, 1 );
            sphere( level.s_hornet_boss.boss_pos_b.origin, 50, ( 0, 1, 0 ), 0, 1 );
            sphere( level.s_hornet_boss.var_ce151cff43b2b50.origin, 50, ( 0, 0, 1 ), 0, 1 );
            sphere( level.s_hornet_boss.var_ce158cff43b3ab5.origin, 50, ( 1, 1, 0 ), 0, 1 );
            waitframe();
        }
    }

#/
