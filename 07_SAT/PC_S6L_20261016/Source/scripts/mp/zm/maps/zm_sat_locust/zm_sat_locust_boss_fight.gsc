// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_boss_fight.gsc  (hash_2829d2db01ee3698.gscc) (size: 96453 Bytes / 0x178c5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbb596193 (3143197075)
// size ...... 96453 (0x178c5)
// includes .. 53  (offset: 0x15705)
// strings ... 243 (offset: 0x158ad)
// dev strs .. 267 (offset: 0x16889)
// exports ... 158 (offset: 0xf175)
// cseg ...... 0x19b4 + 0xd7c1 (0xf175)
// imports ... 571 (offset: 0x10a25)
// animtree1 . 0   (offset: 0x178c5)
// animtree2 . 0   (offset: 0x178c5)
#using script_16ea1b94f0f381b3;
#using script_2d59c90cd0791757;
#using script_3aa124d2660239e3;
#using script_3d250c1a364843aa;
#using script_44c033c00a89e56d;
#using script_4708e9fa04f2c426;
#using script_4714f11e284c32a4;
#using script_53600bb9c82cbdf2;
#using script_7f22b5c78b8ccf70;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\hud_util;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\mp\ammomods\shadowvortex;
#using scripts\mp\armor;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\content_manager;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\overlord;
#using scripts\mp\playerlogic;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_caltheris_blessing;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_glocke_drop;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_rej;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_wunderbarrage;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_exfil;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_locust_boss_fight;

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x1
// Checksum 0x4f09426d, Offset: 0x19d2
// Size: 0x94d
function autoexec boss_fight_init()
{
    /#
        boss_fight_debug();
    #/
    
    level.locust_boss = { #var_a4ea5107f132f0a4:getdvarfloat( @"hash_d1afa3c8dea4fbfc", 3.2 ), #var_f934f9654157c0a5:getdvarfloat( @"hash_324cc656b756b017", 3.8 ), #var_ef7c0929439853be:getdvarfloat( @"hash_6e036d58a01aa78d", 3.2 ), #var_45dc56c4d94a7067:getdvarfloat( @"hash_9fbf928f7b9bf7d4", 3.6 ), #var_53aa6abb2f7a5bcc:getdvarfloat( @"hash_f78d016b8b86a2a", 5 ), #var_69984ca0a6c03459:getdvarfloat( @"hash_f230b2794ce6abb", 8 ), #var_94b88bf373afeaee:getdvarint( @"hash_54b8655c7b85f554", 0 ), #var_b57c83e07016787a:getdvarint( @"hash_66bd6aa497581a4", 1 ), #var_73070b2a3482c5bb:0, #var_97f825d9580915bf:getdvarint( @"hash_2e558f8d5f1ee25e", 0 ), #var_c28d8f43aec7987d:getdvarint( @"hash_25869b30e7984c2a", 2 ), #var_930f2ef877e8c779:getdvarfloat( @"hash_2d178c515b652b20", 1.5 ), #var_972e29ee126bd3a2:getdvarint( @"hash_b2ab1fad5c5f8647", 20 ), #var_4721b8a237c452ba:0, #var_f58d54140851ab7c:[ undefined, "zm_sat_locust_boss_fight_normal_armored_item_list_medium", "zm_sat_locust_boss_fight_normal_armored_item_list" ], #var_d58a745178e211ff:"zm_sat_locust_boss_fight_high_lethals_item_list", #var_eb653dd8d957a667:"zm_sat_locust_boss_fight_normal_item_list", #var_5c55d7663a23fce9:getdvarint( @"hash_19f872c58fdbc2d7", 11 ), #var_fd7b343d1dba2d37:getdvarint( @"hash_6690f61d297a2183", 3 ), #var_28b04aa4e0e753a2:getdvarint( @"hash_a60d47d2046fe938", 36 ), #var_6e0f5ed87f13dac9:getdvarint( @"hash_ed4e98ecd9923a0f", 3 ), #var_4cb2a12b1dcecf65:getdvarint( @"hash_9a51f2ab5ef6d383", 1 ), #var_19c1a99789f57362:getdvarint( @"hash_2d531a9c9235debc", 2 ), #var_ab2d095839396fe:getdvarint( @"hash_14ff408fdc1daec", 200 ), #var_34ef5c3bedb64ec7:getdvarint( @"hash_95ea0b963ff4c219", 70 ), #var_a81d69764c10948d:getdvarfloat( @"hash_1cb6d2633fc35933", 9 ), #var_272ada3d19c33cbd:getdvarint( @"hash_2ad591a9ee97f8df", 900 ), #var_3c83acb7f29c0e2c:getdvarint( @"hash_7cc932c8648453ba", 1500 ), #var_be233d540338b55a:getdvarint( @"hash_f9026dc833b810d0", 1250 ), #var_883f4315da40d1c9:getdvarint( @"hash_8a8f98db32445343", 1800 ), #var_850ff6bfe846e62b:getdvarfloat( @"hash_20eaa6a8207b95f", 5 ), #var_e42dc453b8173b89:getdvarfloat( @"hash_bc00c7281e25937d", 2.5 ), #var_30c9af1f7295fac8:getdvarfloat( @"hash_7341f6031c96c35c", 5 ), #var_93f393438d94fcfb:getdvarfloat( @"hash_f1ba004a6e67ad28", 1.35 ), #var_a5f4c354124e7fec:getdvarfloat( @"hash_7d6584ca34607855", 1 ), #var_158a2887e5e4c94f:getdvarfloat( @"hash_b8d4e1fb068eeeaf", 0.3 ) * 1000, #var_32e8dfeac4d9fdc2:getdvarfloat( @"hash_d53ed8b25fa6b7e5", 0.3 ), #var_6867cc2c91785161:getdvarint( @"hash_309fe1da00175e8c", 60 ), #max_zombie_count:getdvarint( @"hash_90fbf33423fc096d", 55 ), #var_b229ffa0bcfb358c:0, #var_a4ab93ebef0ec473:getdvarfloat( @"hash_e9ce29c6a2727821", 5.5 ), #var_1c20af01180087e0:[], #var_3a375732324696b2:[], #var_e5d57517e7d99072:0, #var_796f5ac8707d9989:0, #var_3723abf7bbf4524:[ 2:[ 2, 3, 3, 3 ], [ 2, 3, 3, 3 ], 0:[ 2, 3, 3, 3 ] ], #var_352c32b3da81b2e7:[ 2:[ 2, 3, 3, 3 ], [ 2, 2, 3, 3 ], 0:[ 1, 2, 2, 2 ] ], #var_d9dd0e342567c6ca:0, #var_41a2f002c2dd7d40:[], #var_9194bcfae1efe20c:0, #var_dd3af4dd260cd224:0, #var_b00308c2518fb5fd:undefined, #var_4546d335d28e1ce0:[], #var_3a7c5451c5ba016f:[], #var_f0fc324e83e30d1f:getdvarint( @"hash_b62ab2bf505f359d", 5 ), #var_4cd56d4f3f6e2c01:getdvarint( @"hash_e0d8fe4e0d2bb676", 20 ), #var_ec288d10013c915e:getdvarint( @"hash_79dfcb12c01bddb0", 25 ), #var_156becd7b01dc488:getdvarint( @"hash_53183d99314d370a", 65 ), #var_7d32689281abf25b:[ 2, 1, 0 ], #var_1a3c5082b1353761:1, #var_abbebdb114e4f57f:0, #var_a43aedfbf56783d5:getdvarfloat( @"hash_5967dca22b6d4977", 15 ), #var_65556bb3ce28bef6:getdvarfloat( @"hash_b952536af064a35d", 3 ), #var_17ecde05d577dee1:getdvarint( @"hash_5e101006c2509345", 1 ), #var_f667db67e736e53d:getdvarfloat( @"hash_69b64f7149590feb", 0.5 ), #var_a3a2f9d475d6bf1f:getdvarfloat( @"hash_4e7c39f96b7099c9", 1 ), #var_8b979abb87499b95:getdvarfloat( @"hash_ffd8b9468b64ac3f", 0.3 ), #var_5bf494624fb165e8:getdvarfloat( @"hash_49d627da8e3396ea", 5 ), #var_f1ca7b2bc4d1abe3:getdvarint( @"hash_690eba6ca818f6c9", 111 ), #var_9a37a2dba34b9c29:getdvarfloat( @"hash_5d7bceb27173a569", 4 ), #var_74e5084f6f0f1dcc:getdvarfloat( @"hash_fd810fd80a3f6b02", 300 ), #var_b29cfab6b5e224b5:getdvarfloat( @"hash_5e0557dd689aa77b", 4 ), #var_d63587a4ddf12169:getdvarfloat( @"hash_6db22d9e1fde51cf", 6 ), #var_2f1438a3cdb80731:getdvarfloat( @"hash_ffdc6cb0c724fdb7", 3.5 ), #var_dffafaab2921d826:getdvarfloat( @"hash_9cb8697bdcea929c", 6 ), #var_e9e379528e296063:getdvarfloat( @"hash_229fc6ba3abcbca9", 10 ), #var_dbfa32b097fce30e:getdvarfloat( @"hash_cbd76fa9c19de4d4", 6 ), #var_77a58a9369ed11da:getdvarfloat( @"hash_52b8ad500dd81310", 10 ), #var_430aab74708e791:getdvarfloat( @"hash_1da830b4932f9a63", 110 ), #var_d3cb692a83b72d98:getdvarint( @"hash_481f7abc24352405", 30 ), #var_d85a011a39aea0f1:getdvarint( @"hash_5c1c268ac008c5fa", 680625 ), #var_84332934dc6cd275:getdvarint( @"hash_44867f7dee6ccce3", 250000 ), #var_dd8068d8c0933cf7:getdvarfloat( @"hash_3a4bd2f5a8f3fb35", 0.65 ), #var_e19d73111b687b47:getdvarint( @"hash_c606a649dbae95b4", 15 ), #var_5ae9842b9e893bea:getdvarint( @"hash_3f885074246dba83", 30 ), #var_40b00bc48b18b2a8:getdvarint( @"hash_972ec3342c44e97b", 25 ), #var_f4e2cc1360f58fce:getdvarfloat( @"hash_28a4ab4be55d4a49", 0.5 ), #var_2b310761450f3fa9:[], #var_5b773f68ed81c923:[], #quest_players:[], #var_4ed552a3c1201536:0, #natural_start:1, #is_active:0 };
    level.locust_boss.var_40455a2a5d5c5ae0 = level.locust_boss.var_6867cc2c91785161 * 1000;
    level thread function_a688cf2aa460b62e();
    level thread function_ad4018c087a3cecb();
    level thread function_b6a6af073d6125be();
    
    if ( getdvar( @"hash_69cbca361cfd76bf", 1 ) )
    {
        level thread hide_fire_traps();
    }
    
    utility::add_fx( "fire_trap_destroy", "vfx_t10_core_impacts_impact_equip_explo_semtex_snow" );
    utility::add_fx( "virgil_crystal_land", "vfx_sat_levels_zm_locust_blizzard_ice_explo_lrg" );
    level.locust_boss.phase_3_collision = getent( "phase_3_collision", #targetname );
    
    if ( isent( level.locust_boss.phase_3_collision ) )
    {
        wait 1;
        level.locust_boss.phase_3_collision connectpaths();
        level.locust_boss.phase_3_collision hide();
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xf497c136, Offset: 0x2327
// Size: 0xec
function private function_b6a6af073d6125be()
{
    level endon( #"game_ended" );
    
    while ( !utility::issharedfuncdefined( #"dev", #"register_dev_console_callback", 0 ) )
    {
        waitframe();
    }
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_ebc885aa28ad5396", &quick_start_boss_fight );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_48224eb23e45a55e", &function_6695afd7224b1e8b );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_b54d7b84007bf0df", &zm_sat_locust_caltheris_blessing::function_6478eae486cfa1e7 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_7d1b4b7b23fd890d", &function_e83b11eb8fabc062 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_83f2d5102bd6871f", &function_7075393f6ff798a );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_83f2d4102bd6856c", &function_7075493f6ff7bbd );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"virgil_deal_damage", &function_145645d45ab07036 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"kill_all_totems", &zombie_boss_virgil_totem_attack::kill_all_totems );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_6d2d05f5de63ab6a", &zm_sat_locust_util::function_a59b225ef3240980 );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x46527138, Offset: 0x241b
// Size: 0x28
function private function_145645d45ab07036( params )
{
    var_8d2325a3c1b80415 = float( params[ 0 ] );
    zombie_boss_virgil::function_be62689fc9735cc8( var_8d2325a3c1b80415 );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x6d6bba54, Offset: 0x244b
// Size: 0x738
function private setup_difficulty_variants()
{
    if ( function_17846b5d2c783c6f() )
    {
        level.locust_boss.var_798c76b6802b4b16.weak_point_damage_multiplier = level.locust_boss.var_a4ea5107f132f0a4;
        level.locust_boss.var_413400bce8a8580d.weak_point_damage_multiplier = level.locust_boss.var_a4ea5107f132f0a4;
        level.locust_boss.var_b255a818a9203db3.weak_point_damage_multiplier = level.locust_boss.var_a4ea5107f132f0a4;
        level.var_c9376b589ea0723.var_3c87de4ec640d314 = level.locust_boss.var_69984ca0a6c03459;
        level.var_c9376b589ea0723.var_d11d424a9369b797 = level.locust_boss.var_53aa6abb2f7a5bcc;
        level.locust_boss.var_5bf494624fb165e8 = level.locust_boss.var_69984ca0a6c03459;
        namespace_fd7b16d2452999a9::function_f49c3fd08787f8d3( 4, "sat_zombie_virgil_runic_volley_attack_fast_no_splash" );
        level.locust_boss.var_2587cda957b2249a.speeds = [ "sprint" ];
        level.locust_boss.var_2587cda957b2249a.speed_weights = [ 100 ];
        level.locust_boss.var_2587cda957b2249a.var_17c3760d1b7569b9 = 0.25;
        level.locust_boss.var_2587cda957b2249a.var_beb995718940175b = 0.9;
        level.locust_boss.var_2587cda957b2249a.var_f250c4df13fe7fa1 = [ 15, 35 ];
        level.locust_boss.var_d8e6192766a7f281.speeds = [ "sprint" ];
        level.locust_boss.var_d8e6192766a7f281.speed_weights = [ 100 ];
        level.locust_boss.var_e0a617f2185b96cf.speeds = [ "sprint" ];
        level.locust_boss.var_e0a617f2185b96cf.speed_weights = [ 100 ];
        level.locust_boss.var_3b88fc59d8c7825f.speeds = [ "run", "sprint" ];
        level.locust_boss.var_3b88fc59d8c7825f.speed_weights = [ 50, 50 ];
        level.locust_boss.var_3b88fc59d8c7825f.var_f250c4df13fe7fa1 = [ 15, 30 ];
        level.locust_boss.var_3b88fc59d8c7825f.var_e7f8b5e9e395eac4 = 1;
        level.locust_boss.var_3b88fc59d8c7825f.var_17c3760d1b7569b9 = 0.25;
        level.locust_boss.var_3b88fc59d8c7825f.var_beb995718940175b = 0.9;
        return;
    }
    
    var_e347d8a50a9a817e = 0;
    
    if ( function_9a175032e129ea49() )
    {
        var_4523fcab5f806cef = 0;
        
        foreach ( player in level.players )
        {
            if ( player.var_a1faa64d8c07872e )
            {
                var_4523fcab5f806cef++;
            }
        }
        
        if ( var_4523fcab5f806cef / level.players.size >= 0.5 )
        {
            var_e347d8a50a9a817e = 1;
        }
    }
    
    if ( function_52bede95605c448d() || function_9a175032e129ea49() )
    {
        level.locust_boss.var_1a3c5082b1353761 = 0;
        level.locust_boss.var_7d32689281abf25b = [ 1, 3, 0 ];
        level.locust_boss.var_34ef5c3bedb64ec7 = level.locust_boss.var_ab2d095839396fe;
        level.locust_boss.var_352c32b3da81b2e7 = level.locust_boss.var_3723abf7bbf4524;
        level.locust_boss.var_796f5ac8707d9989 = level.locust_boss.var_e5d57517e7d99072;
        level.locust_boss.var_b57c83e07016787a = 0;
        level.locust_boss.var_94b88bf373afeaee = 1;
    }
    
    if ( function_52bede95605c448d() )
    {
        level.locust_boss.var_5ed02bdc19feccb7.speeds = [ "sprint" ];
        level.locust_boss.var_2587cda957b2249a.speeds = [ "sprint" ];
        level.locust_boss.var_2587cda957b2249a.speed_weights = [ 100 ];
        level.locust_boss.var_19c1a99789f57362 = level.locust_boss.var_4cb2a12b1dcecf65;
        level.locust_boss.var_f58d54140851ab7c = [ "zm_sat_locust_boss_fight_normal_armored_item_list_low", "zm_sat_locust_boss_fight_normal_armored_item_list_medium", "zm_sat_locust_boss_fight_normal_armored_item_list" ];
    }
    
    if ( function_9a175032e129ea49() )
    {
        level.virgil_boss.weak_point_damage_multiplier = 1.5;
        level.virgil_boss.head_damage_multiplier = 1;
        
        if ( var_e347d8a50a9a817e )
        {
            zombie_boss_virgil_totem_attack::set_death_loot_list( "zm_sat_virgil_totem_drop_list_cursed" );
        }
        
        if ( !function_52bede95605c448d() )
        {
            level.locust_boss.var_2587cda957b2249a.speed_weights = [ 80, 20 ];
            level.locust_boss.var_3b88fc59d8c7825f.speeds = [ "sprint", "super_sprint" ];
            level.locust_boss.var_3b88fc59d8c7825f.speed_weights = [ 75, 25 ];
        }
        
        level.locust_boss.var_19c1a99789f57362 = level.locust_boss.var_6e0f5ed87f13dac9;
        level.locust_boss.var_a5f4c354124e7fec = level.locust_boss.var_93f393438d94fcfb;
        level.locust_boss.var_f58d54140851ab7c = [ undefined, "zm_sat_locust_boss_fight_normal_armored_item_list_low", "zm_sat_locust_boss_fight_normal_armored_item_list" ];
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x3d2519eb, Offset: 0x2b8b
// Size: 0x735
function private setup_zombie_add_data()
{
    level.locust_boss.var_5ed02bdc19feccb7 = { #aggressive_despawn:0, #prevent_cleanup:1, #var_acdf804d5a6fed94:0, #var_e7f8b5e9e395eac4:1, #speeds:[ "super_sprint" ], #var_92205a04ae82189f:90, #timeout_sec:50, #var_cfad8c7db8e390ba:10, #max_zombie_count:{ #max:40, #min:20 }, #zombie_counts:[ { #max:70, #min:30 } ], #var_d3f5f0cc01094984:[ "zombie_base_luna" ], #var_bee4413cf3d9bd65:"virgil_victory" };
    level.locust_boss.var_f787818c2f0cc112 = { #var_acdf804d5a6fed94:0, #speeds:[ "run", "sprint" ], #var_e7f8b5e9e395eac4:1, #zombie_spawner_chances:[ 70, 30 ], #var_d3f5f0cc01094984:[ "zombie_base", "zombie_base_armored_heavy" ], #var_f250c4df13fe7fa1:[ 8, 16 ] };
    level.locust_boss.var_2587cda957b2249a = { #var_92205a04ae82189f:100, #prevent_cleanup:1, #var_acdf804d5a6fed94:0, #var_fc3a7cc0ec4c2d1:0, #speed_weights:[ 90, 10 ], #speeds:[ "sprint", "super_sprint" ], #var_e7f8b5e9e395eac4:1, #zombie_spawner_chances:[ 80, 20 ], #var_f250c4df13fe7fa1:[ 20, 50 ], #var_d3f5f0cc01094984:[ "zombie_base", "zombie_base_armored_heavy" ], #var_bee4413cf3d9bd65:"undecided_wave" };
    level.locust_boss.var_d8e6192766a7f281 = structcopy( level.locust_boss.var_2587cda957b2249a );
    
    if ( getdvarint( @"hash_395cb66d7b1c0a73", 1 ) )
    {
        level.locust_boss.var_d8e6192766a7f281.var_d3f5f0cc01094984 = [ "zombie_base", "zombie_base_armored_heavy" ];
        level.locust_boss.var_d8e6192766a7f281.zombie_spawner_chances = [ 80, 20 ];
    }
    else
    {
        level.locust_boss.var_d8e6192766a7f281.var_d3f5f0cc01094984 = [ "zombie_base", "zombie_base_armored_heavy", "zombie_karkinos" ];
        level.locust_boss.var_d8e6192766a7f281.zombie_spawner_chances = [ 70, 10, 20 ];
        level.locust_boss.var_d8e6192766a7f281.subclass_max[ "zombie_karkinos" ] = 2;
    }
    
    level.locust_boss.var_e0a617f2185b96cf = structcopy( level.locust_boss.var_d8e6192766a7f281 );
    level.locust_boss.var_3b88fc59d8c7825f = { #var_acdf804d5a6fed94:0, #speeds:[ "sprint" ], #var_34f6debcf4497d2a:&function_ba7abe17363289ac, #var_e7f8b5e9e395eac4:1.2, #var_cfad8c7db8e390ba:8, #zombie_spawner_chances:[ 60, 15, 25 ], #var_d3f5f0cc01094984:[ "zombie_base", "zombie_base_luna", "zombie_base_armored_heavy" ], #var_f250c4df13fe7fa1:[ 25, 44 ] };
    
    if ( getdvarint( @"hash_395cb66d7b1c0a73", 1 ) )
    {
        level.locust_boss.var_3b88fc59d8c7825f.zombie_spawner_chances = [ 50, 25, 25 ];
    }
    else
    {
        level.locust_boss.var_676d9b41331ea36f = { #speeds:[ "sprint" ], #var_92205a04ae82189f:120, #var_cfad8c7db8e390ba:25, #var_e7f8b5e9e395eac4:1, #prevent_cleanup:1, #zombie_counts:[ { #max:3, #min:1 } ], #var_d3f5f0cc01094984:[ "zombie_karkinos" ] };
    }
    
    level.locust_boss.var_90d8917d73cdb9ac = { #aggressive_despawn:0, #var_acdf804d5a6fed94:0, #speeds:[ "run" ], #prevent_cleanup:1, #var_e7f8b5e9e395eac4:1, #zombie_spawner_chances:[ 80, 20 ], #var_d3f5f0cc01094984:[ "zombie_base", "zombie_base_armored_heavy" ], #var_f250c4df13fe7fa1:[ 15, 30 ] };
    var_533da86a837cce46 = utility::getstruct( "front_arena_spawners_loc", "targetname" );
    
    foreach ( subclass in level.locust_boss.var_90d8917d73cdb9ac.var_d3f5f0cc01094984 )
    {
        valid_spawn_locs = [];
        var_395649a1ecde9e39 = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_boss_arena" ], subclass );
        
        foreach ( spawn_loc in var_395649a1ecde9e39 )
        {
            if ( distancesquared( spawn_loc.origin, var_533da86a837cce46.origin ) <= level.locust_boss.var_84332934dc6cd275 )
            {
                valid_spawn_locs[ valid_spawn_locs.size ] = spawn_loc;
            }
        }
        
        level.locust_boss.var_90d8917d73cdb9ac.valid_spawn_locs[ subclass ] = valid_spawn_locs;
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x701b99ee, Offset: 0x32c8
// Size: 0x13f
function private function_ad4018c087a3cecb()
{
    level.locust_boss.var_798c76b6802b4b16 = { #var_5275d938754b334c:0, #weak_point_damage_multiplier:1.1, #weak_point_health_frac:0.0275, #var_35e16c5719638f4c:1 };
    level.locust_boss.var_413400bce8a8580d = { #var_5275d938754b334c:0, #weak_point_damage_multiplier:1.1, #weak_point_health_frac:0.075, #var_35e16c5719638f4c:1 };
    level.locust_boss.var_b255a818a9203db3 = { #var_5275d938754b334c:0, #weak_point_damage_multiplier:1.1, #weak_point_health_frac:0.0425, #var_35e16c5719638f4c:1 };
    level.locust_boss.var_7856f3fdd6d929cc = structcopy( level.locust_boss.var_b255a818a9203db3, 1 );
    level.locust_boss.var_7856f3fdd6d929cc.weak_point_health_frac *= 2;
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xaeb96f4f, Offset: 0x340f
// Size: 0x3a9
function private function_a688cf2aa460b62e()
{
    level.locust_boss.var_b00308c2518fb5fd = { #var_f3a4685889898e41:&function_d3ac0ce0e25bc197, #var_7725a85501c8adf:0, #var_763844b3b672e0c:0, #var_31e5c2b466a0410e:0, #var_c6318ece6fa18364:0.2, #var_2a1b17b60632a51d:3, #var_cc48735c9f8faaca:3, #column_offset:200, #row_offset:200, #turret_owners:[] };
    level.locust_boss.var_b00308c2518fb5fd.danger_zone_radius = level.locust_boss.var_b00308c2518fb5fd.row_offset * ( level.locust_boss.var_b00308c2518fb5fd.var_cc48735c9f8faaca - 2 );
    level.locust_boss.var_b00308c2518fb5fd zm_sat_locust_wunderbarrage::function_16feb079ca810058( ( 6354.35, 28360.9, 5500.12 ) );
    level.locust_boss.var_b00308c2518fb5fd zm_sat_locust_wunderbarrage::function_16feb079ca810058( ( 5464.35, 28360.9, 5500.12 ) );
    level.locust_boss.var_ff0560ae1fe34ada = structcopy( level.locust_boss.var_b00308c2518fb5fd );
    level.locust_boss.var_ff0560ae1fe34ada.var_cc48735c9f8faaca = 3;
    level.locust_boss.var_ff0560ae1fe34ada.var_2a1b17b60632a51d = 5;
    level.locust_boss.var_ff0560ae1fe34ada.var_31e5c2b466a0410e = 1;
    level.locust_boss.var_ff0560ae1fe34ada.var_7725a85501c8adf = 0;
    level.locust_boss.var_ff0560ae1fe34ada.var_c6318ece6fa18364 = 0.3;
    level.locust_boss.var_ff0560ae1fe34ada.row_offset = 300;
    level.locust_boss.var_ff0560ae1fe34ada.column_offset = 400;
    level.locust_boss.var_ff0560ae1fe34ada.danger_zone_radius = level.locust_boss.var_ff0560ae1fe34ada.row_offset * ( level.locust_boss.var_ff0560ae1fe34ada.var_cc48735c9f8faaca - 2 );
    level.locust_boss.var_ff0560ae1fe34ada.var_8e0c26679c09073 = 1300;
    level.locust_boss.var_ff0560ae1fe34ada.var_991e405c8748a065 = 3000;
    level.locust_boss.var_ff0560ae1fe34ada.var_59684fc8ebfb0a2d = 3.5;
    level.locust_boss.var_ff0560ae1fe34ada.var_f6dd48944f5ba833 = 5;
    level.locust_boss.var_b00308c2518fb5fd.var_8e0c26679c09073 = 1300;
    level.locust_boss.var_b00308c2518fb5fd.var_991e405c8748a065 = 2500;
    level.locust_boss.var_b00308c2518fb5fd.var_59684fc8ebfb0a2d = 2.25;
    level.locust_boss.var_b00308c2518fb5fd.var_f6dd48944f5ba833 = 3.25;
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xa0afcd34, Offset: 0x37c0
// Size: 0x53
function private function_d3ac0ce0e25bc197()
{
    if ( getdvarint( @"hash_eafb708aa184ea38", 0 ) && !isdefined( level.locust_boss.pops_entity ) )
    {
        return ( 6354.35, 28360.9, 5500.12 );
    }
    
    return level.locust_boss.pops_entity boss_pops::function_e8b7c32e77fa2ba2();
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xf3da6b42, Offset: 0x381c
// Size: 0x848
function private setup_attack_settings()
{
    level endon( #"game_ended" );
    level.virgil_entity endon( #"death" );
    min_struct = utility::getstruct( "phase_3_safe_volume_min", "targetname" );
    max_struct = utility::getstruct( "phase_3_safe_volume_max", "targetname" );
    level.locust_boss.var_ca217143f8bba31f = min_struct.origin;
    level.locust_boss.var_c9fd7f43f8934731 = max_struct.origin;
    level.locust_boss.var_6285b5dc66cc849c = structcopy( namespace_dba99780c141b678::function_f5d5ec8b4b8a5e33() );
    level.locust_boss.var_6285b5dc66cc849c.var_64bf2bd1792ae381 = 875;
    level.locust_boss.var_6285b5dc66cc849c.ice_block_health = 2147483647;
    level.locust_boss.var_6285b5dc66cc849c.var_6fa394937ac3d679 = 0.5;
    level.locust_boss.var_6285b5dc66cc849c.var_6c0ed12be32db1d2 *= 2;
    level.locust_boss.var_6285b5dc66cc849c.var_46fa04ee5128915c = 1;
    level.locust_boss.var_6285b5dc66cc849c.var_2244b0b58f132d60 = level.locust_boss.arena_center_struct.origin;
    level.locust_boss.var_6285b5dc66cc849c.var_c6243ec0d08c3d06 = 0;
    level.locust_boss.var_6285b5dc66cc849c.var_f13930fcf48fafc4 = 300;
    level.locust_boss.var_6285b5dc66cc849c.var_89a6b9f8f7eb226d = 1;
    level.locust_boss.var_6285b5dc66cc849c.ice_block_player_damage *= 0;
    level.locust_boss.var_6285b5dc66cc849c.update_nav_mesh = 0;
    level.locust_boss.var_6285b5dc66cc849c.var_3857c5270d63c9f3 = undefined;
    level.locust_boss.var_6285b5dc66cc849c.var_70bbf852ea79c4ba = 0.25;
    level.locust_boss.var_6285b5dc66cc849c.var_6fa394937ac3d679 = 0.25;
    level.locust_boss.var_6285b5dc66cc849c.var_39760dce39fe4565 = 0.1;
    level.locust_boss.var_6285b5dc66cc849c.var_d44d63a0f39f895b = 0;
    level.locust_boss.var_6285b5dc66cc849c.var_1607b7a6b428ada = 1.25;
    level.locust_boss.var_6285b5dc66cc849c.var_2c636187351a0692 = 0.25;
    level.locust_boss.var_6285b5dc66cc849c.force_block_rise = 1;
    level.locust_boss.var_1494d211b49e450e = structcopy( level.locust_boss.var_6285b5dc66cc849c );
    level.locust_boss.var_1494d211b49e450e.var_fd259abce3ad9187 = 0;
    level.locust_boss.var_1494d211b49e450e.var_f13930fcf48fafc4 = 125;
    level.locust_boss.var_1494d211b49e450e.var_64bf2bd1792ae381 = 550;
    level.locust_boss.var_1494d211b49e450e.var_5af603e95a98d83e = 1;
    level.locust_boss.var_1494d211b49e450e.var_89a6b9f8f7eb226d = 0;
    level.locust_boss.var_1494d211b49e450e.var_786f877946506ca8 = 0.15;
    level.locust_boss.var_1494d211b49e450e.fire_damage_multiplier = 0.75;
    level.locust_boss.var_3fbea7eb0be38692 = structcopy( level.locust_boss.var_6285b5dc66cc849c );
    level.locust_boss.var_3fbea7eb0be38692.var_64bf2bd1792ae381 = 0;
    level.locust_boss.var_3fbea7eb0be38692.var_70bbf852ea79c4ba = 0;
    var_f7be40f8876789b7 = utility::getstructarray( "ice_wall_start", "targetname" );
    level.locust_boss.var_52bbe6cd66b593d9 = [];
    
    foreach ( var_a2a23d56975c4221 in var_f7be40f8876789b7 )
    {
        if ( var_a2a23d56975c4221.name == "Ice Wall Block P3" )
        {
            var_5a80a1ad6341fffd = namespace_dba99780c141b678::function_91fd7afce74113fd( var_a2a23d56975c4221 );
            ice_wall_struct = namespace_dba99780c141b678::function_9e6cbb9351c6ff95( var_5a80a1ad6341fffd );
            ice_wall_struct.row = int( var_a2a23d56975c4221.row );
            ice_wall_struct.should_timeout = var_a2a23d56975c4221.should_timeout != "0";
            level.locust_boss.var_52bbe6cd66b593d9[ level.locust_boss.var_52bbe6cd66b593d9.size ] = ice_wall_struct;
        }
        
        waitframe();
    }
    
    level.locust_boss.var_65d716cde74ff23f = structcopy( namespace_dba99780c141b678::function_f5d5ec8b4b8a5e33() );
    level.locust_boss.var_65d716cde74ff23f.var_70bbf852ea79c4ba = 3;
    level.locust_boss.var_65d716cde74ff23f.var_46fa04ee5128915c = 1;
    level.locust_boss.var_65d716cde74ff23f.var_6fa394937ac3d679 = 35;
    level.locust_boss.var_65d716cde74ff23f.ice_block_player_damage = 200;
    level.locust_boss.var_65d716cde74ff23f.var_39760dce39fe4565 = 0.1;
    level.locust_boss.var_65d716cde74ff23f.var_786f877946506ca8 = 0.3;
    level.locust_boss.var_65d716cde74ff23f.fire_damage_multiplier = 0.75;
    level.locust_boss.var_65d716cde74ff23f.var_3569026c514f16e4 = 0.25;
    level.locust_boss.var_65d716cde74ff23f.var_2c636187351a0692 = 0.25;
    level.locust_boss.var_e84aa86341a44c43 = [];
    level.locust_boss.var_bb8c9f56882bf5cc = namespace_dba99780c141b678::function_7d4b00914399a657( 102 );
    level.locust_boss.var_bb8c9f56882bf5cc = arraycombine( level.locust_boss.var_bb8c9f56882bf5cc, level.locust_boss.var_e84aa86341a44c43 );
    level.locust_boss.var_679f35ffd4968766 = namespace_dba99780c141b678::function_7d4b00914399a657( 103 );
    level.locust_boss.var_679f35ffd4968766 = arraycombine( level.locust_boss.var_679f35ffd4968766, level.locust_boss.var_bb8c9f56882bf5cc );
    utility::flag_set( "flag_locust_boss_ice_wall_data_ready" );
}

// Namespace zm_sat_locust_boss_fight
// Params 1
// Checksum 0xa120bcfb, Offset: 0x406c
// Size: 0xa15
function start_boss_fight( natural_start = 1 )
{
    self notify( #"hash_308663414083a795" );
    self endon( #"hash_308663414083a795" );
    level endon( #"game_ended" );
    
    if ( level.locust_boss.is_active )
    {
        return;
    }
    
    current_round = zm_round_logic::get_rb_round_number();
    
    if ( current_round >= 100 || getdvarint( @"hash_65ca608c812027ea", 0 ) )
    {
        level.locust_boss.var_4ed552a3c1201536 = 1;
    }
    
    if ( game_utility::function_d68874417f3eea5c() || getdvarint( @"hash_b2c4756a219d2f98", 0 ) )
    {
        level.locust_boss.var_9489982d1305112c = 1;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() || getdvarint( @"hash_cbb4278900e83c52", 0 ) )
    {
        level.locust_boss.var_a1f9caee8f9cc7b2 = 1;
    }
    
    if ( function_17846b5d2c783c6f() )
    {
        utility::flag_clear( "mq_bs_show_guidance" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    clamped_round = clampint( current_round, 25, 100 );
    var_bb11ab55020ceec4 = math::lerp_fraction( 25, 100, clamped_round );
    var_6d5f8c1bc34d818b = math::lerp( level.locust_boss.var_c28d8f43aec7987d, level.locust_boss.var_97f825d9580915bf, var_bb11ab55020ceec4 );
    level.locust_boss.var_73070b2a3482c5bb = roundint( var_6d5f8c1bc34d818b );
    level.locust_boss.is_active = 1;
    level.locust_boss.natural_start = natural_start;
    level.locust_boss.arena_center_struct = utility::getstruct( "boss_arena_center_loc", "targetname" );
    level.locust_boss.arena_vista_struct = utility::getstruct( "boss_arena_vista_loc", "targetname" );
    level.locust_boss.pops_dialog_ent_struct = utility::getstruct( "pops_dialog_ent", "targetname" );
    level.locust_boss.var_c67f4438ea8c963e = utility::getstruct( "bossSceneScriptStruct01", "targetname" );
    level.locust_boss.var_c67f4338ea8c940b = utility::getstruct( "bossSceneScriptStruct02", "targetname" );
    level.locust_boss.var_942db576cc571861 = structcopy( level.locust_boss.var_c67f4338ea8c940b, 1 );
    level.locust_boss.var_c67f4238ea8c91d8 = utility::getstruct( "bossSceneScriptStruct03", "targetname" );
    level.locust_boss.var_c67f4938ea8ca13d = utility::getstruct( "bossSceneScriptStruct04", "targetname" );
    level.locust_boss.var_b77c50fc08ede4e4 = utility::getstruct( "bossSceneScriptStructOutro", "targetname" );
    level.locust_boss.var_93f1a41633f6bf5f = utility::getstruct( "bossSceneScriptStructIdleVirgil", "targetname" );
    level.locust_boss.var_8cb04e1b207cb0fc = utility::getstruct( "bossSceneScriptStructIdlePops", "targetname" );
    level.locust_boss.pops_dialog_ent = utility::spawn_model( "tag_origin", level.locust_boss.pops_dialog_ent_struct.origin, level.locust_boss.pops_dialog_ent_struct.angles );
    level.locust_boss.safe_spawn_locs = [];
    var_f08ede20bbf57037 = utility::getstructarray( "boss_safe_teleport_loc", "targetname" );
    
    foreach ( var_e016fe279e1dfd9e in var_f08ede20bbf57037 )
    {
        level.locust_boss.safe_spawn_locs[ level.locust_boss.safe_spawn_locs.size ] = var_e016fe279e1dfd9e;
    }
    
    level.locust_boss.var_8d3b74bf300b6819 = [];
    var_f08ede20bbf57037 = utility::getstructarray( "phase_3_safe_spawn_loc", "script_noteworthy" );
    
    foreach ( var_e016fe279e1dfd9e in var_f08ede20bbf57037 )
    {
        level.locust_boss.var_8d3b74bf300b6819[ level.locust_boss.var_8d3b74bf300b6819.size ] = var_e016fe279e1dfd9e;
    }
    
    utility::array_thread( level.players, &val::reset_all, "task_logic_activate" );
    level val::set( "val_locust_boss_fight", "task_logic_activate", 0 );
    level.var_654073823a58b613 = &function_e5bc572edb237317;
    level.var_9075568a1189c7c9 = 1;
    level.var_9c0d12c8f8edeb3d = "sat_cin_zm_vig_plr_dth_virgil_01";
    level.s_game_over_scene_override = utility::getstruct( "sat_cin_zm_vig_plr_dth_virgil_01" );
    zone_manager::set_zone_enabled( "zone_boss_arena", 1 );
    level.locust_boss.var_500a93937951dac4 = level.cratedropdata.heliheight;
    level.cratedropdata.heliheight = 6600;
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    level.locust_boss.var_8b1d8f6e6a206628 = heightent.origin;
    heightent.origin = ( heightent.origin[ 0 ], heightent.origin[ 1 ], level.cratedropdata.heliheight );
    arena_lb = getnoentvolumearray( "boss_arena_lb", #targetname )[ 0 ];
    namespace_af5a2e4a7277c1d::function_ff714b8751ab0002( arena_lb );
    utility::flag_set( "boss_fight_start" );
    zm_exfil::disable_zm_exfil( 1 );
    zm_round_spawning::pause_round_spawning( 1, "locust_boss_pause_round_spawning" );
    
    if ( level.var_6781718da4f78d1c.state == 2 )
    {
        potential_special_round = zm_round_logic::get_rb_round_number() + 1;
        
        if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ potential_special_round ] ) )
        {
            level.var_a009ab14ee0d3223.specialroundspawns[ potential_special_round ] = undefined;
        }
    }
    
    zm_quest::function_823ee6000b6e1947( zm_round_logic::get_rb_round_number() - 1 );
    zm_quest::function_823ee6000b6e1947( zm_round_logic::get_rb_round_number() );
    
    if ( level.var_a009ab14ee0d3223.isspecialround || utility::flag( "special_round_is_ongoing" ) )
    {
        level thread zm_round_logic::function_895fdc21ab019efe();
    }
    
    utility::callsharedfunc( #"mutant_injection", #"force_exit_mutant_injection", 1 );
    zm_fasttravel::function_8649f9a98d2d9ce3();
    setup_zombie_add_data();
    level thread function_cc1ef5b7f7d2668e();
    level thread function_528dfc7eb7ea8402();
    utility::registersharedfunc( #"zm_robot_controller", #"get_wunderbarrage_settings", &function_bcd0c1d941da37a );
    utility::registersharedfunc( #"zm_robot_controller", #"hash_92958a874adb388f", &function_55f2fcd4ebd3047a );
    level callback::add( #"glocke_drop_loot", &function_ef95129f5503d36c );
    level callback::add( #"hash_2767e511882e6794", &function_c0dd49e279947594 );
    level callback::add( #"glocke_drop_complete", &function_23d57e953c8a20f );
    level callback::add( #"hash_4b6e460a881d6da6", &function_17aec1e5ce578ef6 );
    level callback::add( #"hash_4b57400860de234e", &function_f12de54f3de6bdc0 );
    level callback::add( #"hash_890a266bc5d64b1b", &function_adf8f2ef3d2f23c2 );
    level callback::add( #"player_connect", &function_f9ec749f5254db40 );
    level callback::add( #"player_laststand_revived", &function_72e0775f8af3e2c8 );
    level callback::add( #"player_spawned", &callback_player_spawned );
    level callback::add( "on_zombie_ai_killed", &on_zombie_killed );
    level callback::add( #"killstreak_can_trigger", &function_5532a1bf6661e432 );
    level callback::add( #"hash_89720860d7fd7978", &function_219ddf701bf5ddb3 );
    level callback::add( "locust_launch_wunderbarrage", &zm_sat_locust_wunderbarrage::function_380301741164ece8 );
    level callback::add( #"hash_874a75f9e033ec57", &zm_sat_locust_glocke_drop::function_e77f3a459c886b1c );
    level callback::add( #"hash_aeec77b89ab49d7c", &function_bd3f2e6f362aa4a9 );
    level callback::add( #"glocke_drop_created", &function_fd8c75e1fd3c7254 );
    level callback::add( #"hash_70700a7ae0ffa528", &function_b2ea7e1d5a0ca3dd );
    level callback::add( #"hash_7d450bcc4887da1e", &function_b283c0fc518ae8bf );
    level callback::add( #"hash_3e2eb4cb47f0d7b3", &function_97a6903ec3cd5b02 );
    utility::registersharedfunc( #"zombie", #"hash_ec597a712c9bb135", &function_2923e4e60f984da );
    level thread function_149fcafa5137f98c();
    level.var_e9bce67d0022b869 = 10000;
    
    if ( getdvarint( @"hash_4d481e99ba28801f", 0 ) )
    {
        spawn_virgil();
        level.locust_boss.var_93f1a41633f6bf5f thread scene::play( [ level.virgil_entity ], "battle_idle_virgil" );
        level.virgil_entity zombie_boss_virgil::boss_fight_begin();
        level.virgil_entity thread zombie_boss_virgil::enable_immunity();
    }
    else
    {
        level thread start_boss_fight_phases();
    }
    
    level thread function_46b0a9670a97a0bf();
    level thread zm_sat_locust_caltheris_blessing::init_caltheris_blessing();
    setup_difficulty_variants();
    utility::flag_wait( "boss_fight_end" );
    level thread on_boss_fight_complete();
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x70b05de8, Offset: 0x4a89
// Size: 0x197
function private start_boss_fight_phases()
{
    level thread function_7075293f6ff7757();
    
    /#
        starting_phase = getdvarint( @"hash_65c7d199af184d6", 0 );
        level.virgil_entity zombie_boss_virgil::disable_immunity();
        
        if ( starting_phase == 2 )
        {
            health_frac_to_remove = 0.25;
            health_to_remove = level.virgil_entity.maxhealth * health_frac_to_remove;
            level.virgil_entity.health = int( level.virgil_entity.maxhealth - health_to_remove );
        }
        else if ( starting_phase == 3 )
        {
            health_frac_to_remove = ( 100 - level.locust_boss.var_ec288d10013c915e ) / 100;
            health_to_remove = level.virgil_entity.maxhealth * health_frac_to_remove;
            level.virgil_entity.health = int( level.virgil_entity.maxhealth - health_to_remove );
        }
        
        level.virgil_entity zombie_boss_virgil::enable_immunity();
        utility::flag_wait( "<dev string:x24>" );
        
        if ( starting_phase > 1 )
        {
            wait 1;
            level thread show_fire_traps();
            level.virgil_entity zombie_boss_virgil::function_dab167edcd6162fa();
            level thread function_7075393f6ff798a();
        }
        
        if ( starting_phase > 2 )
        {
            wait 1;
            level.virgil_entity utility::ent_flag_clear( "<dev string:x45>" );
            level.virgil_entity zombie_boss_virgil::virgil_show();
            level thread function_7075493f6ff7bbd();
        }
    #/
    
    level thread function_3dbb66c072b2ed73();
    level thread function_55bd1e39bc8ec36a();
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0xcb9f2ba5, Offset: 0x4c28
// Size: 0x15
function function_52bede95605c448d()
{
    return level.locust_boss.var_4ed552a3c1201536;
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0xab904de3, Offset: 0x4c46
// Size: 0x15
function function_9a175032e129ea49()
{
    return level.locust_boss.var_9489982d1305112c;
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0xab904de3, Offset: 0x4c64
// Size: 0x15
function function_17846b5d2c783c6f()
{
    return level.locust_boss.var_a1f9caee8f9cc7b2;
}

// Namespace zm_sat_locust_boss_fight
// Params 1
// Checksum 0xacbd69c6, Offset: 0x4c82
// Size: 0x169
function function_77bf79da6a2825ec( initial_warp = 1 )
{
    self endon( #"disconnect" );
    revive_player();
    destination = function_ae9b6227df1d3fe3();
    
    if ( !self.var_35541497c394d312 )
    {
        self.var_35541497c394d312 = self.deaths;
    }
    
    if ( initial_warp )
    {
        hud_util::fade_out( level.locust_boss.var_739a41bbd1a52655, "white" );
        var_d3823b80b1397854 = { #destination:destination, #angles:self.angles, #origin:self.origin };
        params = { #skip_narrative_room:1, #player:self, #var_d3823b80b1397854:var_d3823b80b1397854 };
        level thread zm_sat_locust_rej::ejection_sequence( params );
        self waittill( #"touchdown_ejection" );
        level.locust_boss.quest_players = arraycombineunique( level.locust_boss.quest_players, [ self ] );
        utility::flag_set( "flag_locust_boss_players_entered" );
        return;
    }
    
    self setadditionalstreamposuntilcleared( destination.origin );
    thread zm_fasttravel::function_8649f9a98d2d9ce3();
    thread zm_fasttravel::set_player_vars( 1 );
    thread zm_fasttravel::fasttravel_teleport_vortex( destination, 1, undefined, 1, 0 );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xce50a41a, Offset: 0x4df3
// Size: 0x119
function private function_52d52ac5a9df175a()
{
    scene_struct = self;
    
    foreach ( sceneobj in scene_struct.scenedata.sceneobjectdata )
    {
        ent = sceneobj.entity;
        
        if ( ent && ent.classname == "script_model" )
        {
            if ( sceneobj.sceneobject.variant_object.xmodelname == "c_sat_zmb_pops" )
            {
                ent.var_2fc3a5fb762afb6e = 0;
                ent.var_521099eccef67894 = 1;
                visibility_mode::function_3afc3bc470c80e61( ent, level.players[ 0 ].team );
            }
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0x8ee78f56, Offset: 0x4f14
// Size: 0x33d
function function_7075293f6ff7757()
{
    level endon( #"game_ended" );
    level endon( #"hash_c7944c25ad06f095" );
    
    if ( level.locust_boss.var_abbebdb114e4f57f == 1 )
    {
        return;
    }
    
    level.locust_boss.var_abbebdb114e4f57f = 1;
    level notify( #"hash_c7944925ad06eb7c" );
    logstring( "[LOCUST BOSS] Phase transition: Phase 1 started" );
    
    if ( !level.virgil_entity )
    {
        spawn_virgil();
    }
    
    level.virgil_entity endon( #"death" );
    level.virgil_entity thread function_9b507e2b8cbc40a5();
    level.locust_boss.var_c67f4438ea8c963e utility::delaythread( level.locust_boss.var_a4ab93ebef0ec473, &scene::play, [ level.virgil_entity ], [ "virgil_intro" ] );
    level.locust_boss.var_c67f4438ea8c963e scene::set_notify_state( level.virgil_entity, "scene_done" );
    utility::flag_wait( "flag_locust_boss_players_entered" );
    
    foreach ( player in level.players )
    {
        player setsoundsubmix( "sat_zm_locust_boss" );
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_intro" );
    level.virgil_entity zombie_boss_virgil::boss_fight_begin();
    level.virgil_entity thread zombie_boss_virgil::enable_immunity();
    zombie_boss_virgil::boss_play_dialogue( #"virgil_appear" );
    level thread function_7b3a45c4fdbfc566();
    
    if ( !level.locust_boss.pops_entity )
    {
        spawn_pops();
    }
    
    level.virgil_entity waittill( #"scene_done" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_main" );
    level thread deliver_fire_traps();
    level thread namespace_589ae4efe3ba85ad::function_41f5e51182a17fdc( 65 );
    level.locust_boss.pops_entity show();
    level.locust_boss.pops_dialog_ent thread dialogue::say_self( "dx_zm_lobf_bfp1_typa_lbf1bfstr" );
    level thread zombie_boss_virgil_pops::init_dance( level.locust_boss.pops_entity, level.virgil_entity );
    function_ad915db840c90fb3( 1023, 4, 8 );
    level.virgil_entity utility::ent_flag_wait( "flag_virgil_intro_complete" );
    
    if ( function_17846b5d2c783c6f() )
    {
        utility::flag_set( "mq_bs_show_guidance" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    glocke_struct = utility::getstruct( "robot_glocke_launch_loc", "targetname" );
    level.locust_boss.pops_entity boss_pops::function_4c469f7f8939560e( glocke_struct.origin );
    level.virgil_entity thread zombie_boss_virgil::disable_immunity();
}

// Namespace zm_sat_locust_boss_fight
// Params 1
// Checksum 0x69a5cc82, Offset: 0x5259
// Size: 0x49f
function function_7075393f6ff798a( params )
{
    level endon( #"game_ended" );
    level endon( #"hash_c7944b25ad06eee2" );
    level.virgil_entity endon( #"death" );
    
    if ( level.locust_boss.var_abbebdb114e4f57f == 2 )
    {
        return;
    }
    
    level.virgil_entity zombie_boss_virgil::enable_immunity();
    
    if ( function_17846b5d2c783c6f() )
    {
        utility::flag_clear( "mq_bs_show_guidance" );
        utility::flag_set( "mq_bs_step_01" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    if ( level.var_a0cc52751f52c09.dance_begun && !level.var_a0cc52751f52c09.dance_ended )
    {
        zombie_boss_virgil_pops::request_dance_end();
    }
    
    function_ad915db840c90fb3( 1023, 1, 8 );
    level.virgil_entity utility::ent_flag_set( "flag_locust_boss_pause_add_spawning" );
    level thread kill_all_adds();
    level.virgil_entity.weak_points_hidden = 0;
    var_b5c2fe7aa3f65b1b = level.virgil_entity.health / level.virgil_entity.maxhealth * 100;
    var_2e9c65c99b2c6069 = var_b5c2fe7aa3f65b1b - level.locust_boss.var_ec288d10013c915e;
    var_40bb26ebf97c4a58 = ( var_2e9c65c99b2c6069 / 2 + 2 ) / 100;
    level.locust_boss.var_1623eb1928ba7967 = min( var_40bb26ebf97c4a58, level.locust_boss.var_32e8dfeac4d9fdc2 ) * level.virgil_entity.maxhealth;
    level.locust_boss.var_abbebdb114e4f57f = 2;
    level notify( #"hash_c7944c25ad06f095" );
    logstring( "[LOCUST BOSS] Phase transition: Phase 2 started" );
    level.virgil_entity utility::ent_flag_set( "flag_virgil_intro_complete" );
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_runic_volley_enabled" );
    
    if ( level.locust_boss.pops_entity && isalive( level.locust_boss.pops_entity ) )
    {
        level.locust_boss.pops_entity kill();
    }
    
    level.locust_boss.var_942db576cc571861 thread scene::play( undefined, [ "phase1_transition_pops_loop" ] );
    level.locust_boss.var_942db576cc571861 function_52d52ac5a9df175a();
    level.virgil_entity zombie_boss_virgil::function_760120540374bc8d();
    level callback::add( #"hash_d734f5978951ec2a", &on_totem_destroyed );
    level callback::add( #"hash_293bd578dad314b7", &function_c2890d39733d97c0 );
    level.locust_boss.var_883f4315da40d1c9 = level.locust_boss.var_3c83acb7f29c0e2c;
    level.locust_boss.var_be233d540338b55a = level.locust_boss.var_272ada3d19c33cbd;
    level namespace_589ae4efe3ba85ad::function_41f5e51182a17fdc( level.locust_boss.var_34ef5c3bedb64ec7 );
    level.virgil_entity utility::ent_flag_clear( "flag_locust_boss_pause_add_spawning" );
    level.virgil_entity thread function_358d5c2dc3a83ee8();
    level.virgil_entity zombie_boss_virgil::function_7962cd4502850b79();
    level.virgil_entity metabone::set_metabone_active( "weakspot_forearm_right", 0 );
    level.virgil_entity metabone::set_metabone_active( "weakspot_elbow_right", 0 );
    level.virgil_entity metabone::set_metabone_active( "weakspot_chest_right", 0 );
    level.virgil_entity metabone::set_metabone_active( "weakspot_elbow_left", 0 );
    level.virgil_entity metabone::set_metabone_active( "weakspot_forearm_left", 0 );
    
    if ( function_17846b5d2c783c6f() )
    {
        if ( level.locust_boss.var_45dc56c4d94a7067 )
        {
            var_3932f2530419d216 = structcopy( zombie_boss_virgil::function_f8a229a16991533c(), 1 );
            var_3932f2530419d216.weak_point_damage_multiplier = level.locust_boss.var_45dc56c4d94a7067;
            zombie_boss_virgil::function_3d52547cf27e2d36( var_3932f2530419d216 );
        }
        
        if ( level.locust_boss.var_ef7c0929439853be )
        {
            zombie_boss_virgil::function_b7a39a9bf03c92b7( level.locust_boss.var_ef7c0929439853be );
        }
        
        if ( level.locust_boss.var_f934f9654157c0a5 )
        {
            zombie_boss_virgil_totem_attack::function_304a04c4fbfbf30a( level.locust_boss.var_f934f9654157c0a5 );
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1
// Checksum 0x180f91c, Offset: 0x5700
// Size: 0x3df
function function_7075493f6ff7bbd( params )
{
    level endon( #"game_ended" );
    level.virgil_entity endon( #"death" );
    level.virgil_entity utility::ent_flag_wait( "flag_virgil_is_ready" );
    
    if ( level.locust_boss.var_abbebdb114e4f57f == 3 )
    {
        return;
    }
    
    level.locust_boss.var_abbebdb114e4f57f = 3;
    level notify( #"hash_c7944b25ad06eee2" );
    logstring( "[LOCUST BOSS] Phase transition: Phase 3 started" );
    level callback::remove( #"hash_d734f5978951ec2a", &on_totem_destroyed );
    level callback::remove( #"hash_293bd578dad314b7", &function_c2890d39733d97c0 );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_5550f26e36226edf" );
    level.virgil_entity val::set( "virgil", "death", 0 );
    level.virgil_entity zombie_boss_virgil::disable_immunity();
    level.virgil_entity thread function_7889284aec46c15a();
    level.virgil_entity thread function_9cf2722dfb4745fa();
    level.virgil_entity thread zombie_boss_virgil::function_ed45e41507b1667d();
    level.virgil_entity thread zombie_boss_virgil::function_760120540374bc8d();
    level thread namespace_589ae4efe3ba85ad::function_19acc91d6a304892();
    level.virgil_entity utility::ent_flag_set( "flag_locust_boss_pause_add_spawning" );
    level thread kill_all_adds();
    level thread function_c4452a75b0f45366();
    level.virgil_entity utility::ent_flag_wait( "flag_virgil_force_players_to_center" );
    level thread namespace_589ae4efe3ba85ad::function_950d4585ce2b2a46();
    
    if ( level.locust_boss.var_94b88bf373afeaee )
    {
        level.virgil_entity utility::ent_flag_clear( "flag_locust_boss_pause_add_spawning" );
        level.locust_boss.var_90d8917d73cdb9ac thread function_313accf65ecc31c1();
    }
    
    zombie_boss_virgil::boss_play_dialogue( #"hash_e7564cd0438f9e82" );
    force_players_to_center();
    
    if ( function_17846b5d2c783c6f() )
    {
        utility::flag_set( "mq_bs_show_guidance" );
        utility::flag_set( "mq_bs_step_02_a" );
        utility::flag_set( "mq_bs_step_02_b" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_main" );
    level thread function_2d5e343a8e72540e();
    var_14cd6fe555805aaa = namespace_fd7b16d2452999a9::function_5ac5fa188f92dd3b();
    var_6e6491e90f970810 = undefined;
    closest_dist_sq = undefined;
    
    foreach ( orientation_struct in var_14cd6fe555805aaa )
    {
        dist_sq = distancesquared( orientation_struct.end_point, level.locust_boss.arena_center_struct.origin );
        
        if ( !isdefined( var_6e6491e90f970810 ) || dist_sq < closest_dist_sq )
        {
            closest_dist_sq = dist_sq;
            var_6e6491e90f970810 = orientation_struct;
        }
    }
    
    level thread namespace_fd7b16d2452999a9::function_8dc03d228121adda( var_6e6491e90f970810 );
    level.var_c9376b589ea0723.var_3c87de4ec640d314 = level.locust_boss.var_5bf494624fb165e8;
    level thread namespace_fd7b16d2452999a9::function_9b44b0b758f8469a( level.locust_boss.var_9a37a2dba34b9c29, level.locust_boss.var_74e5084f6f0f1dcc, level.locust_boss.var_f1ca7b2bc4d1abe3 );
    level thread namespace_fd7b16d2452999a9::function_11135981b04b76d5();
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_stop_attacking" );
    level.virgil_entity utility::ent_flag_set( "flag_virgil_runic_volley_enabled" );
    level.virgil_entity zombie_boss_virgil::disable_immunity();
    level thread function_54ada0a2b6c1cfce();
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x9fdd0bd0, Offset: 0x5ae7
// Size: 0x16e
function private function_156c4dfcf529f702( var_31854a9e29e8d2d = 0 )
{
    level endon( #"game_ended" );
    level.virgil_entity endon( #"death" );
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_busy_scene" );
    level.virgil_entity notify( #"hash_7ffd9295d37efbf1" );
    level.virgil_entity utility::ent_flag_set( "flag_virgil_in_pain" );
    level thread namespace_589ae4efe3ba85ad::function_950d4585ce2b2a46();
    level.virgil_entity zombie_boss_virgil::function_1c3066df3a64ff1b( "head" );
    level.virgil_entity metabone::set_metabone_active( "head", 1 );
    level.virgil_entity metabone::set_metabone_state( "head", "exposed_enabled" );
    
    if ( var_31854a9e29e8d2d )
    {
        level.locust_boss.var_c67f4238ea8c91d8 scene::play( [ level.virgil_entity ], [ "virgil_pain_heavy_volley" ] );
    }
    else
    {
        level.locust_boss.var_c67f4238ea8c91d8 scene::play( [ level.virgil_entity ], [ "virgil_pain_heavy" ] );
    }
    
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_in_pain" );
    level.locust_boss.var_c67f4438ea8c963e thread scene::play( [ level.virgil_entity ], "virgil_player_facing_idle" );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xf06d6e6e, Offset: 0x5c5d
// Size: 0x5b
function private function_8e960f8ef4ce0871( params )
{
    if ( self == level.virgil_entity )
    {
        if ( params.shitloc == "head" || level.virgil_entity.var_e1e8440f02996bbd )
        {
            level.virgil_entity.var_2b44f8c076fdbd73 = 1;
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xbf32d2aa, Offset: 0x5cc0
// Size: 0xf6
function private function_2d5e343a8e72540e()
{
    var_a3ed71111ddc1c45 = namespace_dba99780c141b678::function_77d21320ab4c5981( level.locust_boss.center_fire_trap.origin, 1, 1 );
    
    if ( var_a3ed71111ddc1c45 )
    {
        ice_wall = namespace_dba99780c141b678::function_9e6cbb9351c6ff95( [ var_a3ed71111ddc1c45 ] );
        level thread namespace_dba99780c141b678::place_ice_wall( ice_wall, level.locust_boss.var_3fbea7eb0be38692 );
        wait 0.25;
        disable_fire_traps();
        waitframe();
        hide_fire_traps( 1 );
        playfx( utility::getfx( "fire_trap_destroy" ), level.locust_boss.center_fire_trap.origin );
    }
    
    if ( level.locust_boss.var_b57c83e07016787a )
    {
        powerups::force_powerup_drop( "full_ammo", level.locust_boss.center_fire_trap.origin, "quest" );
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xa76151e1, Offset: 0x5dbe
// Size: 0x14a
function private function_54ada0a2b6c1cfce()
{
    level endon( #"game_ended" );
    level.virgil_entity endon( #"death" );
    level.virgil_entity val::set( "virgil", "death", 0 );
    level.virgil_entity callback::callback( "agent_fake_defeat_health", { #health_percentage:level.locust_boss.var_f0fc324e83e30d1f } );
    
    for ( health_percentage = level.virgil_entity.health / level.virgil_entity.maxhealth * 100; health_percentage > level.locust_boss.var_f0fc324e83e30d1f ; health_percentage = level.virgil_entity.health / level.virgil_entity.maxhealth * 100 )
    {
        waitframe();
    }
    
    level.virgil_entity utility::ent_flag_set( "flag_virgil_stop_attacking" );
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_runic_volley_enabled" );
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_charge_bomb_enabled" );
    level.virgil_entity utility::ent_flag_wait( "flag_virgil_is_ready" );
    level thread function_7852a89cc455d84f();
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x26015881, Offset: 0x5f10
// Size: 0x339
function private function_7852a89cc455d84f()
{
    level endon( #"game_ended" );
    level.virgil_entity endon( #"death" );
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_in_pain" );
    level.locust_boss.var_942db576cc571861 scene::cleanup( 1 );
    level.locust_boss.var_c67f4338ea8c940b scene::cleanup( 1 );
    spawn_pops();
    waitframe();
    level.locust_boss.pops_entity show();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_end" );
    level.virgil_entity utility::ent_flag_set( "flag_locust_boss_pause_add_spawning" );
    utility::delaythread( level.locust_boss.var_dffafaab2921d826, &function_53f4b886870e06a7 );
    function_ad915db840c90fb3( 1023, 4, 8 );
    
    if ( level.locust_boss.var_17ecde05d577dee1 )
    {
        prestream_igc( -1 );
    }
    
    level.locust_boss.var_c67f4938ea8ca13d scene::play( [ level.locust_boss.pops_entity, level.virgil_entity ], [ "death_intro" ] );
    health_percentage = level.virgil_entity.health / level.virgil_entity.maxhealth * 100;
    
    if ( health_percentage > 4 )
    {
        level.locust_boss.var_c67f4938ea8ca13d scene::play( [ level.locust_boss.pops_entity, level.virgil_entity ], [ "death_loop" ] );
    }
    
    level thread kill_all_adds();
    
    foreach ( player in level.players )
    {
        player utility::delaythread( level.locust_boss.var_2f1438a3cdb80731, &zombie_boss_healthbar::zombie_boss_healthbar_hide );
    }
    
    level.locust_boss.var_1494d211b49e450e.var_5af603e95a98d83e = 0;
    level utility::delaythread( level.locust_boss.var_2f1438a3cdb80731, &function_9ed8b90a7f7b7e7 );
    level.virgil_entity setcandamage( 0 );
    level.virgil_entity val::set( "virgil", "damage", 0 );
    level.locust_boss.var_c67f4938ea8ca13d thread scene::play( [ level.locust_boss.pops_entity, level.virgil_entity ], [ "death_outro" ] );
    utility::flag_wait( "begin_end_scene" );
    utility::flag_set( "boss_fight_end" );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x7a88574e, Offset: 0x6251
// Size: 0x64
function private function_9ed8b90a7f7b7e7()
{
    level thread open_arena_center();
    level thread zombie_boss_virgil::function_9c386609d0280bef( #"virgil_killed" );
    level thread disable_fire_traps();
    level thread hide_fire_traps( 1 );
    level thread free_ammo_cache();
    
    if ( function_17846b5d2c783c6f() )
    {
        utility::flag_set( "mq_bs_step_03" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x27cef104, Offset: 0x62bd
// Size: 0x1b8
function private force_players_to_center()
{
    level endon( #"game_ended" );
    level.virgil_entity endon( #"death" );
    utility::flag_wait( "flag_locust_boss_ice_wall_data_ready" );
    shadowvortex::register_shadowvortex_validation_func( &function_d6839bf51ac5dc76 );
    utility::array_thread( utility::get_alive_players( 1 ), &function_74355e9bb1dd020b );
    level thread zm_sat_locust_caltheris_blessing::function_c3caec2115529287( level.locust_boss.var_ca217143f8bba31f, level.locust_boss.var_c9fd7f43f8934731 );
    var_ac5f632d63fc563d = arraysort( level.locust_boss.var_52bbe6cd66b593d9, undefined, &namespace_dba99780c141b678::function_3d5e42923a9d0965 );
    current_row = 1;
    
    for ( i = 0; i < var_ac5f632d63fc563d.size ; i++ )
    {
        ice_wall_struct = var_ac5f632d63fc563d[ i ];
        
        if ( ice_wall_struct.row != current_row )
        {
            wait level.locust_boss.var_8b979abb87499b95;
            current_row = ice_wall_struct.row;
        }
        
        if ( ice_wall_struct.should_timeout )
        {
            level thread namespace_dba99780c141b678::place_ice_wall( ice_wall_struct, level.locust_boss.var_6285b5dc66cc849c );
            continue;
        }
        
        level thread namespace_dba99780c141b678::place_ice_wall( ice_wall_struct, level.locust_boss.var_1494d211b49e450e );
    }
    
    wait level.locust_boss.var_f667db67e736e53d;
    level.locust_boss.phase_3_collision disconnectpaths();
    level.locust_boss.phase_3_collision show();
    utility::delaythread( level.locust_boss.var_a3a2f9d475d6bf1f, &function_a6becc0fb4417c7f );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xcf363732, Offset: 0x647d
// Size: 0xd2
function private function_a6becc0fb4417c7f()
{
    [ phase_3_safe_volume ] = getnoentvolumearray( "phase_3_safe_volume", #targetname );
    alive_players = utility::get_alive_players( 1 );
    
    foreach ( player in alive_players )
    {
        if ( !ispointinvolume( player.origin, phase_3_safe_volume ) )
        {
            player thread reset_player_position( undefined, 0 );
        }
    }
    
    level notify( #"all_players_in_center" );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x9d08ea3a, Offset: 0x6557
// Size: 0x36
function private function_74355e9bb1dd020b()
{
    self endon( #"disconnect" );
    self.falldamageprotection = 1;
    level waittill( #"all_players_in_center" );
    wait 2.5;
    self.falldamageprotection = undefined;
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xb27c819, Offset: 0x6595
// Size: 0xdd
function private open_arena_center()
{
    foreach ( ice_wall_struct in level.locust_boss.var_52bbe6cd66b593d9 )
    {
        level thread namespace_dba99780c141b678::cleanup_ice_wall( ice_wall_struct, level.locust_boss.var_6285b5dc66cc849c );
    }
    
    level thread namespace_dba99780c141b678::function_c03123422fb8e97d();
    level.locust_boss.phase_3_collision connectpaths();
    level.locust_boss.phase_3_collision hide();
    shadowvortex::function_df703f0d3c44e68e( &function_d6839bf51ac5dc76 );
}

// Namespace zm_sat_locust_boss_fight
// Params 2
// Checksum 0x3a78823b, Offset: 0x667a
// Size: 0xc1
function function_7cdcdb5f43adfef7( target_name, subclass_override = undefined )
{
    subclass_override = subclass_override ?? self.subclass;
    structs = utility::getstructarray( target_name, "targetname" );
    
    foreach ( struct in structs )
    {
        if ( struct.script_noteworthy == subclass_override )
        {
            return struct;
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0x39a824cc, Offset: 0x6744
// Size: 0xd9
function kill_all_adds()
{
    foreach ( zombie in level.locust_boss.var_3a7c5451c5ba016f )
    {
        if ( isalive( zombie ) && !is_boss_ent( zombie ) )
        {
            if ( zombie val::get( "damageshield_allow_quest_kill" ) )
            {
                zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
            }
            
            zombie kill();
        }
    }
    
    level.locust_boss.var_3a7c5451c5ba016f = [];
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0x8469e794, Offset: 0x6825
// Size: 0x15
function function_4266e2c0c79cdd07()
{
    return level.locust_boss.var_3a7c5451c5ba016f;
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0x74ac54ce, Offset: 0x6843
// Size: 0xce
function function_53f4b886870e06a7()
{
    level endon( #"game_ended" );
    level.virgil_entity endon( #"death" );
    wait 1;
    var_ef58452436339895 = function_4266e2c0c79cdd07();
    
    foreach ( zombie in var_ef58452436339895 )
    {
        if ( zombie && !is_boss_ent( zombie ) )
        {
            zombie.var_a13bed1ac47e1b2c = 1;
            zombie zombie_utils::try_despawn_zombie( 0 );
            wait 0.4;
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0x2c78f167, Offset: 0x6919
// Size: 0xe
function function_b9f98165d48b9a1a()
{
    level notify( #"hash_6a34a67110a8a92e" );
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0x9d373cc1, Offset: 0x692f
// Size: 0xe
function function_42ff753e6d5bc179()
{
    level notify( #"hash_5afa166e1c990771" );
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0xef790a84, Offset: 0x6945
// Size: 0xe6
function function_34a8c89ccb015bd7()
{
    level endon( #"game_ended", #"hash_5afa166e1c990771", #"hash_6a34a67110a8a92e" );
    level.virgil_entity endon( #"death" );
    wave_settings = self;
    
    if ( isstring( wave_settings.var_bee4413cf3d9bd65 ) )
    {
        level endon( wave_settings.var_bee4413cf3d9bd65 );
    }
    
    wave_settings.zombies_killed = 0;
    
    if ( isdefined( wave_settings.var_239b65f9b1709ecc ) )
    {
        wait wave_settings.var_239b65f9b1709ecc;
    }
    
    for ( i = 0; i < wave_settings.var_d3f5f0cc01094984.size ; i++ )
    {
        var_c60105d2445aa45f = wave_settings.var_d3f5f0cc01094984[ i ];
        zombie_type_count = wave_settings.zombie_counts[ i ];
        thread function_e2118341caccde40( var_c60105d2445aa45f, zombie_type_count );
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 2
// Checksum 0xa6c1e4cc, Offset: 0x6a33
// Size: 0x270
function function_e2118341caccde40( var_c60105d2445aa45f, zombie_type_count )
{
    level endon( #"game_ended", #"hash_5afa166e1c990771", #"hash_6a34a67110a8a92e" );
    level.virgil_entity endon( #"death" );
    wave_settings = self;
    
    if ( isstring( wave_settings.var_bee4413cf3d9bd65 ) )
    {
        level endon( wave_settings.var_bee4413cf3d9bd65 );
    }
    
    num_to_spawn = zombie_type_count.min;
    
    if ( !wave_settings.var_13168de3d758bfa5 )
    {
        if ( !isdefined( wave_settings.var_cd510aa21ac99288[ var_c60105d2445aa45f ] ) )
        {
            wave_settings.var_cd510aa21ac99288[ var_c60105d2445aa45f ] = 0;
        }
        
        player_count = level.players.size;
        squad_size_frac = math::lerp_fraction( 1, 4, player_count );
        num_to_spawn = roundint( math::lerp( zombie_type_count.min, zombie_type_count.max, squad_size_frac ) );
    }
    
    var_617153ec0ad51a08 = wave_settings.var_2637d564b270bd8e ?? 0;
    
    if ( isdefined( wave_settings.var_cfad8c7db8e390ba ) && num_to_spawn > 0 )
    {
        var_617153ec0ad51a08 = wave_settings.var_cfad8c7db8e390ba / num_to_spawn;
    }
    
    spawned_count = 0;
    timeout_sec = wave_settings.timeout_sec ?? 45;
    timeout_end_time_sec = gettime() + timeout_sec * 1000;
    var_9cfe63fd0fe48257 = level.locust_boss.max_zombie_count;
    
    if ( isdefined( wave_settings.max_zombie_count ) )
    {
        var_9cfe63fd0fe48257 = int( math::lerp( wave_settings.max_zombie_count.min, wave_settings.max_zombie_count.max, squad_size_frac ) );
    }
    
    while ( spawned_count < num_to_spawn && gettime() < timeout_end_time_sec )
    {
        if ( level.virgil_entity utility::ent_flag( "flag_locust_boss_pause_add_spawning" ) || getdvarint( @"scr_locust_boss_pause_add_spawning", 0 ) )
        {
            return;
        }
        
        if ( level.locust_boss.var_3a7c5451c5ba016f.size < var_9cfe63fd0fe48257 )
        {
            zombie = function_fcc576ce75ae207c( wave_settings, var_c60105d2445aa45f );
            
            if ( isdefined( zombie ) )
            {
                spawned_count++;
            }
        }
        
        if ( !isdefined( var_617153ec0ad51a08 ) || var_617153ec0ad51a08 == 0 )
        {
            waitframe();
            continue;
        }
        
        wait var_617153ec0ad51a08;
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0xd72a6c1, Offset: 0x6cab
// Size: 0x3f9
function function_313accf65ecc31c1()
{
    self notify( #"hash_e4f2d958d46478cb" );
    self endon( #"hash_e4f2d958d46478cb" );
    level notify( #"hash_5afa166e1c990771" );
    level endon( #"game_ended", #"hash_5afa166e1c990771" );
    level.virgil_entity endon( #"death" );
    spawn_settings = self;
    level.locust_boss.var_4721b8a237c452ba = 0;
    
    if ( isstring( spawn_settings.var_bee4413cf3d9bd65 ) )
    {
        level endon( spawn_settings.var_bee4413cf3d9bd65 );
    }
    
    var_874a374f6314c47b = 0;
    var_a2fa061209b9e70c = [];
    spawn_settings.zombies_killed = 0;
    
    foreach ( subclass in spawn_settings.var_d3f5f0cc01094984 )
    {
        var_a2fa061209b9e70c[ subclass ] = 0;
    }
    
    var_b51b283e85c6f7b0 = 1;
    
    if ( isarray( spawn_settings.var_f250c4df13fe7fa1 ) )
    {
        player_count = level.players.size;
        squad_size_frac = math::lerp_fraction( 1, 4, player_count );
        max_zombie_count = int( math::lerp( spawn_settings.var_f250c4df13fe7fa1[ 0 ], spawn_settings.var_f250c4df13fe7fa1[ 1 ], squad_size_frac ) );
        scalar_player_count = maxint( player_count - 1, 1 );
        var_43ca57fbf18f6e5e = math::lerp_fraction( 1, 4, scalar_player_count );
        var_24771fed9da001d2 = int( math::lerp( spawn_settings.var_f250c4df13fe7fa1[ 0 ], spawn_settings.var_f250c4df13fe7fa1[ 1 ], var_43ca57fbf18f6e5e ) );
        var_b51b283e85c6f7b0 = var_24771fed9da001d2 / spawn_settings.var_f250c4df13fe7fa1[ 0 ];
    }
    else
    {
        max_zombie_count = spawn_settings.max_zombie_count;
    }
    
    var_5e0c20018999fcc6 = undefined;
    
    if ( spawn_settings.var_cfad8c7db8e390ba )
    {
        var_5e0c20018999fcc6 = spawn_settings.var_cfad8c7db8e390ba / max_zombie_count;
    }
    
    while ( true )
    {
        chosen_subclass = utility::random_weighted( spawn_settings.var_d3f5f0cc01094984, spawn_settings.zombie_spawner_chances );
        
        if ( function_aa50926973c6d069( spawn_settings, var_a2fa061209b9e70c, chosen_subclass ) )
        {
            waitframe();
            continue;
        }
        
        active_zombie_count = zm_utility::get_active_zombies_count();
        var_93aa0d163f5afaea = max_zombie_count - active_zombie_count;
        
        if ( var_93aa0d163f5afaea > 0 )
        {
            zombie = function_fcc576ce75ae207c( spawn_settings, chosen_subclass );
            
            if ( zombie )
            {
                var_874a374f6314c47b++;
                var_a2fa061209b9e70c[ chosen_subclass ]++;
            }
            
            var_17c3760d1b7569b9 = spawn_settings.var_17c3760d1b7569b9 ?? getdvarfloat( @"min_rate", 0.25 );
            var_beb995718940175b = spawn_settings.var_beb995718940175b ?? getdvarfloat( @"max_rate", 1.5 );
            var_a7e9ce1d565fc9f8 = clamp( math::lerp_fraction( 0, max_zombie_count, active_zombie_count ), 0, 1 );
            spawn_rate = math::lerp( var_17c3760d1b7569b9, var_beb995718940175b, var_a7e9ce1d565fc9f8 );
            spawn_rate *= var_b51b283e85c6f7b0;
            var_2637d564b270bd8e = 1 / spawn_rate;
            var_2637d564b270bd8e = min( var_2637d564b270bd8e, level.locust_boss.var_930f2ef877e8c779 );
            
            if ( level.locust_boss.var_4721b8a237c452ba > 0 )
            {
                var_2637d564b270bd8e = 0;
                level.locust_boss.var_4721b8a237c452ba = max( level.locust_boss.var_4721b8a237c452ba - 1, 0 );
            }
            
            if ( var_2637d564b270bd8e <= 0 )
            {
                waitframe();
            }
            else if ( var_874a374f6314c47b < max_zombie_count && isdefined( var_5e0c20018999fcc6 ) && var_5e0c20018999fcc6 > 0 )
            {
                wait var_5e0c20018999fcc6;
            }
            else
            {
                wait var_2637d564b270bd8e;
            }
            
            continue;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1
// Checksum 0xf6d3950d, Offset: 0x70ac
// Size: 0x38, Type: bool
function is_boss_ent( zombie )
{
    return zombie && ( zombie.basearchetype == "zombie_boss_virgil" || zombie.basearchetype == "boss_pops" );
}

// Namespace zm_sat_locust_boss_fight
// Params 3, eflags: 0x4
// Checksum 0x4794a98a, Offset: 0x70ed
// Size: 0xfa
function private function_aa50926973c6d069( spawn_settings, var_a2fa061209b9e70c, chosen_subclass )
{
    var_5730940ed13e182 = 0;
    
    if ( level.virgil_entity utility::ent_flag( "flag_locust_boss_pause_add_spawning" ) || level.virgil_entity utility::ent_flag( "flag_locust_boss_pause_ambient_add_spawning" ) )
    {
        var_5730940ed13e182 = 1;
    }
    else if ( getdvarint( @"scr_locust_boss_pause_add_spawning", 0 ) )
    {
        var_5730940ed13e182 = 1;
    }
    else if ( level.locust_boss.var_3a7c5451c5ba016f.size >= level.locust_boss.max_zombie_count )
    {
        var_5730940ed13e182 = 1;
    }
    else if ( level.virgil_entity utility::ent_flag( "flag_locust_boss_pause_add_spawning" ) || level.virgil_entity utility::ent_flag( "flag_locust_boss_pause_ambient_add_spawning" ) )
    {
        var_5730940ed13e182 = 1;
    }
    
    if ( var_a2fa061209b9e70c[ chosen_subclass ] >= spawn_settings.subclass_max[ chosen_subclass ] )
    {
        var_5730940ed13e182 = 1;
    }
    
    return var_5730940ed13e182;
}

// Namespace zm_sat_locust_boss_fight
// Params 2, eflags: 0x4
// Checksum 0xf6a9e14d, Offset: 0x71f0
// Size: 0x399
function private function_fcc576ce75ae207c( spawn_settings, subclass )
{
    zombie = undefined;
    var_395649a1ecde9e39 = spawn_settings.valid_spawn_locs[ subclass ] ?? level.locust_boss.var_1c20af01180087e0[ subclass ];
    random_spawn_override = spawn_settings.var_acdf804d5a6fed94 && randomint( 100 ) < level.locust_boss.var_d3cb692a83b72d98 || spawn_settings.var_fc3a7cc0ec4c2d1;
    
    if ( random_spawn_override || !isarray( var_395649a1ecde9e39 ) || var_395649a1ecde9e39.size == 0 )
    {
        var_395649a1ecde9e39 = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_boss_arena" ], subclass );
    }
    
    spawn_loc = utility::array_random( var_395649a1ecde9e39 );
    zombie_aitype = function_b3988325430ce242( subclass );
    
    if ( !isdefined( spawn_settings.var_cd510aa21ac99288[ subclass ] ) )
    {
        spawn_settings.var_cd510aa21ac99288[ subclass ] = 0;
    }
    
    if ( isvector( spawn_loc.origin ) )
    {
        zombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( zombie_aitype, spawn_loc.origin, spawn_loc.angles, zm_utility::get_zombie_team() );
    }
    
    if ( isdefined( zombie ) )
    {
        if ( spawn_settings.prevent_cleanup )
        {
            zombie.b_cleanup_no_respawn = 1;
            zombie.var_825b17c932865df = 1;
            zombie val::set( "boss_zombie", "ignore_cleanup", 1 );
            zombie.var_15598d8e493afe88 = 1;
        }
        
        spawn_settings.var_cd510aa21ac99288[ subclass ]++;
        level.locust_boss.var_3a7c5451c5ba016f[ level.locust_boss.var_3a7c5451c5ba016f.size ] = zombie;
        zombie.spawn_settings = spawn_settings;
        zombie.spawn_loc = spawn_loc;
        zombie.aggressive_despawn = spawn_settings.aggressive_despawn;
        zombie.disable_brain_rot = spawn_settings.disable_brain_rot;
        zombie.var_f895c28d17024434 = 1;
        zombie.spawn_time_ms = gettime();
        
        if ( isdefined( spawn_settings.var_92205a04ae82189f ) )
        {
            zombie.var_8c780611bf9fe4ae = spawn_settings.var_92205a04ae82189f * 1000;
        }
        
        zombie thread agent_spawner::function_ce10e453e7f7bb8e( spawn_loc );
        
        if ( isdefined( spawn_settings.var_e7f8b5e9e395eac4 ) )
        {
            var_410521ef65c6c757 = level.virgil_entity zombie_utils::get_zombie_round_difficulty();
            var_1e9b5c4ba7d895f0 = min( var_410521ef65c6c757 + level.locust_boss.var_73070b2a3482c5bb, int( var_410521ef65c6c757 * spawn_settings.var_e7f8b5e9e395eac4 ) );
            zombie zombie_utils::set_zombie_round_difficulty( var_1e9b5c4ba7d895f0, 1, 1 );
        }
        else
        {
            zombie zombie_utils::set_zombie_round_difficulty( level.virgil_entity zombie_utils::get_zombie_round_difficulty(), 1, 1 );
        }
        
        zombie function_7f8988ce63c1623d( 0 );
        zombie utility::delaycallendon( 5, "death", &function_7f8988ce63c1623d, 1 );
        droplist_func = spawn_settings.var_34f6debcf4497d2a ?? &function_acf02770d0dc43ac;
        zombie.var_50c96a5c56dab386 = droplist_func;
        zombie.no_powerups = 1;
        zombie_base_speed = zombie get_zombie_base_speed( spawn_settings.speeds );
        zombie zombie_utils::function_a8ce00e0448cb6f0( zombie_base_speed, "locust_boss", 5 );
        
        if ( isfunction( spawn_settings.on_spawn_func ) )
        {
            zombie thread [[ spawn_settings.on_spawn_func ]]();
        }
    }
    
    return zombie;
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xccc12779, Offset: 0x7592
// Size: 0xf5
function private function_acf02770d0dc43ac()
{
    zombie_droplist = level.locust_boss.var_eb653dd8d957a667;
    attacker = isdefined( self.last_dmg_struct ) ? self.last_dmg_struct.eattacker : undefined;
    
    if ( self.aicategory == "normal" && isstartstr( self.subclass, "zombie_base_armored" ) && isplayer( attacker ) )
    {
        armored_zombie_droplist = get_armored_zombie_droplist_name( attacker );
        
        if ( armored_zombie_droplist )
        {
            zombie_droplist = armored_zombie_droplist;
        }
    }
    
    var_245f1c4b1d5b3e81 = 1;
    zombie_droppos = self.origin;
    zombie_droplist_params = { #droppos:zombie_droppos ?? self.origin, #dropquantity:var_245f1c4b1d5b3e81, #droplist:zombie_droplist };
    return zombie_droplist_params;
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xe71a00e, Offset: 0x7690
// Size: 0xf5
function private function_ba7abe17363289ac()
{
    zombie_droplist = level.locust_boss.var_d58a745178e211ff;
    attacker = isdefined( self.last_dmg_struct ) ? self.last_dmg_struct.eattacker : undefined;
    
    if ( self.aicategory == "normal" && isstartstr( self.subclass, "zombie_base_armored" ) && isplayer( attacker ) )
    {
        armored_zombie_droplist = get_armored_zombie_droplist_name( attacker );
        
        if ( armored_zombie_droplist )
        {
            zombie_droplist = armored_zombie_droplist;
        }
    }
    
    var_245f1c4b1d5b3e81 = 1;
    zombie_droppos = self.origin;
    zombie_droplist_params = { #droppos:zombie_droppos ?? self.origin, #dropquantity:var_245f1c4b1d5b3e81, #droplist:zombie_droplist };
    return zombie_droplist_params;
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x1f30f4c9, Offset: 0x778e
// Size: 0x10b
function private get_armored_zombie_droplist_name( attacker )
{
    if ( attacker.maxarmorhealth == 0 )
    {
        return;
    }
    
    var_7369442765bcdccc = math::lerp( 0, 3, attacker.armorhealth / attacker.maxarmorhealth );
    var_8caf6d1fde4eec61 = attacker armor::function_22290101992e4874();
    armor_frac = clamp( math::lerp_fraction( 0, 6, var_7369442765bcdccc + var_8caf6d1fde4eec61 ), 0, 1 );
    armor_percentage = armor_frac * 100;
    
    if ( attacker.var_a1faa64d8c07872e )
    {
        return;
    }
    
    if ( armor_percentage <= 33 )
    {
        return level.locust_boss.var_f58d54140851ab7c[ 2 ];
    }
    
    if ( armor_percentage > 33 && armor_percentage <= 66 )
    {
        return level.locust_boss.var_f58d54140851ab7c[ 1 ];
    }
    
    if ( armor_percentage > 85 && armor_percentage < 100 )
    {
        return level.locust_boss.var_f58d54140851ab7c[ 0 ];
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x2d92edc9, Offset: 0x78a2
// Size: 0x6b
function private function_ae9b6227df1d3fe3()
{
    var_bfbd5040a053a006 = utility::getstruct( "boss_player_entry_loc", "targetname" );
    var_bfbd5040a053a006.locations = utility::getstructarray( var_bfbd5040a053a006.target, "targetname" );
    assert( var_bfbd5040a053a006.locations.size == 4 );
    return var_bfbd5040a053a006.locations[ self getentitynumber() % 4 ];
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0x7c9f16c, Offset: 0x7916
// Size: 0x24
function get_active_weak_points()
{
    if ( !level.virgil_entity )
    {
        return [];
    }
    
    return level.virgil_entity.active_weak_points;
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x2ead43e1, Offset: 0x7943
// Size: 0x34
function private function_807d65800f628da1()
{
    level.var_654073823a58b613 = undefined;
    level.var_9c0d12c8f8edeb3d = undefined;
    level.s_game_over_scene_override = undefined;
    level.var_328791597304e46b = undefined;
    level.var_9075568a1189c7c9 = undefined;
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xe2caee0c, Offset: 0x797f
// Size: 0xd9
function private function_c1657a2bd936a248()
{
    if ( level.locust_boss.natural_start )
    {
        params = spawnstruct();
        params.timestamp = gettime();
        params.questname = #"zm_sat_locust_mq";
        params.is_main_quest = 1;
        
        if ( isdefined( level.locust_boss.quest_players ) )
        {
            params.quest_players = level.locust_boss.quest_players;
            level callback::callback( #"zm_mq_quest_complete", params );
            params.event = #"zm_mq_quest_complete";
            level callback::callback( #"hash_6c71d319dc089c27", params );
        }
        
        return;
    }
    
    namespace_c0b4f2882c9d100f::function_c0b0828d1107c141( undefined, 1 );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x8b36b098, Offset: 0x7a60
// Size: 0x3af
function private on_boss_fight_complete()
{
    level endon( #"game_ended" );
    level.var_9c0d12c8f8edeb3d = undefined;
    level.s_game_over_scene_override = undefined;
    utility::clearsharedfunc( #"zombie", #"hash_ec597a712c9bb135" );
    
    foreach ( player in level.players )
    {
        player clearsoundsubmix( "sat_zm_locust_boss" );
    }
    
    level.cratedropdata.heliheight = level.locust_boss.var_500a93937951dac4;
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    heightent.origin = level.locust_boss.var_8b1d8f6e6a206628;
    function_807d65800f628da1();
    zm_round_spawning::pause_round_spawning( 0, "locust_boss_pause_round_spawning" );
    zm_round_spawning::pause_round_spawning( 1, "final_scene" );
    zm_utility::util_kill_all_zombies();
    level thread disable_fire_traps();
    utility::clearsharedfunc( #"zm_robot_controller", #"get_wunderbarrage_settings" );
    utility::clearsharedfunc( #"zm_robot_controller", #"hash_92958a874adb388f" );
    level callback::remove( #"glocke_drop_loot", &function_ef95129f5503d36c );
    level callback::remove( #"hash_2767e511882e6794", &function_c0dd49e279947594 );
    level callback::remove( #"glocke_drop_complete", &function_23d57e953c8a20f );
    level callback::remove( #"hash_4b6e460a881d6da6", &function_17aec1e5ce578ef6 );
    level callback::remove( #"hash_4b57400860de234e", &function_f12de54f3de6bdc0 );
    level callback::remove( #"hash_890a266bc5d64b1b", &function_adf8f2ef3d2f23c2 );
    level callback::remove( #"killstreak_can_trigger", &function_5532a1bf6661e432 );
    level callback::remove( #"player_connect", &function_f9ec749f5254db40 );
    level callback::remove( #"player_laststand_revived", &function_72e0775f8af3e2c8 );
    level callback::remove( #"player_spawned", &callback_player_spawned );
    level callback::remove( "locust_launch_wunderbarrage", &zm_sat_locust_wunderbarrage::function_380301741164ece8 );
    level callback::remove( #"hash_874a75f9e033ec57", &zm_sat_locust_glocke_drop::function_e77f3a459c886b1c );
    level callback::remove( #"hash_aeec77b89ab49d7c", &function_bd3f2e6f362aa4a9 );
    level callback::remove( #"glocke_drop_created", &function_fd8c75e1fd3c7254 );
    level callback::remove( #"hash_70700a7ae0ffa528", &function_b2ea7e1d5a0ca3dd );
    level callback::remove( #"hash_7d450bcc4887da1e", &function_b283c0fc518ae8bf );
    level callback::remove( #"hash_3e2eb4cb47f0d7b3", &function_97a6903ec3cd5b02 );
    level thread namespace_dba99780c141b678::cleanup();
    level thread zm_sat_locust_caltheris_blessing::cleanup_caltheris_blessing();
    level thread namespace_fd7b16d2452999a9::function_fb1b5d4ec6ce76bd();
    level thread function_c1657a2bd936a248();
    level utility::flag_set( "mq_step_02" );
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
        player thread revive_player();
    }
    
    utility::flag_clear( "boss_fight_start" );
    level.locust_boss.is_active = 0;
    function_c32ea4de009cc0d4();
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x6eb69546, Offset: 0x7e17
// Size: 0x327
function private function_c32ea4de009cc0d4()
{
    level endon( #"game_ended" );
    
    if ( level.locust_boss.var_17ecde05d577dee1 )
    {
        function_785dee38bd826ae2();
    }
    
    if ( level.locust_boss.pops_dialog_ent )
    {
        level.locust_boss.pops_dialog_ent delete();
    }
    
    level.locust_boss.var_c67f4438ea8c963e scene::cleanup( 1 );
    level.locust_boss.var_c67f4338ea8c940b scene::cleanup( 1 );
    level.locust_boss.var_c67f4238ea8c91d8 scene::cleanup( 1 );
    level.locust_boss.var_c67f4938ea8ca13d scene::cleanup( 1 );
    level.locust_boss.var_942db576cc571861 scene::cleanup( 1 );
    level.locust_boss.var_93f1a41633f6bf5f scene::cleanup( 1 );
    level.locust_boss.var_8cb04e1b207cb0fc scene::cleanup( 1 );
    teleport_pos = utility::getstruct( "boss_exfil_loc", "targetname" );
    var_f8a710a43590c8b1 = 0;
    
    foreach ( player in level.players )
    {
        player val::set( "boss_exfil_transition", "ignore_afk", 1 );
    }
    
    if ( level.locust_boss.natural_start )
    {
        utility::array_thread( level.players, &val::set, "final_vote", "ignoreme", 1 );
        var_f8a710a43590c8b1 = zm_quest::function_3477750f338de598( teleport_pos, &"zm_sat_locust/mission_complete_exfil", undefined, 0 );
        utility::array_thread( level.players, &val::reset, "final_vote", "ignoreme" );
    }
    else
    {
        foreach ( player in level.players )
        {
            level thread zm_fasttravel::function_cbb08198e7c84adf( teleport_pos, player, undefined, undefined, 0 );
        }
    }
    
    level.var_e9bce67d0022b869 = undefined;
    function_ad915db840c90fb3( 1023, 1, 6 );
    
    if ( !var_f8a710a43590c8b1 )
    {
        level thread function_78f9d6116fa25d95( teleport_pos );
    }
    
    level notify( #"hash_1a56ce6d49d1a451" );
    level.locust_boss.quest_players = [];
    level val::reset( "val_locust_boss_fight", "task_logic_activate" );
    utility::delaythread( level.locust_boss.var_e9e379528e296063, &zone_manager::set_zone_enabled, "zone_boss_arena", 0 );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x14ff9cc3, Offset: 0x8146
// Size: 0x3c6
function private spawn_virgil()
{
    spawn_loc = function_7cdcdb5f43adfef7( "titan_spawn_loc", "zombie_boss_virgil" );
    level.virgil_entity = agent_manager::spawn_agent( "zombie_boss_virgil", spawn_loc.origin, spawn_loc.angles, "team_hundred_ninety_nine" );
    level.virgil_entity zombie_boss_virgil::function_c0e77c8f500f805c();
    logstring( "[LOCUST BOSS] Spawned Virgil at location: " + level.virgil_entity.origin );
    level.virgil_entity.var_2fc3a5fb762afb6e = 0;
    level.virgil_entity.var_521099eccef67894 = 1;
    visibility_mode::function_3afc3bc470c80e61( level.virgil_entity, level.virgil_entity.team );
    level thread function_6952717caa7a6608();
    projectile_spawn_locs = utility::getstructarray( "boss_projectile_spawn_loc", "targetname" );
    charge_bomb_spawn_loc = utility::getstruct( "boss_charge_bomb_loc", "targetname" );
    charge_bomb_end_loc = utility::getstruct( "boss_charge_bomb_end_loc", "targetname" );
    charge_bomb_explosion_loc = utility::getstruct( "boss_charge_bomb_explosion_loc", "targetname" );
    var_26827aa210cb773e = utility::getstruct( "boss_charge_debris_loc", "targetname" );
    totem_spawn_loc = utility::getstruct( "boss_totem_spawn_loc", "targetname" );
    ice_walls = utility::getstructarray( "ice_wall_start", "targetname" );
    ice_clumps = utility::getstructarray( "ice_clump_start", "targetname" );
    arena_vista_dir = vectornormalize( level.locust_boss.arena_vista_struct.origin - level.locust_boss.arena_center_struct.origin );
    level.virgil_entity thread namespace_fd7b16d2452999a9::setup_arena_properties( projectile_spawn_locs );
    level.virgil_entity thread namespace_589ae4efe3ba85ad::setup_arena_properties( charge_bomb_spawn_loc, charge_bomb_end_loc, charge_bomb_explosion_loc, var_26827aa210cb773e );
    level.virgil_entity thread namespace_dba99780c141b678::setup_arena_properties( ice_walls, ice_clumps, arena_vista_dir );
    level.virgil_entity thread zombie_boss_virgil_totem_attack::setup_arena_properties( totem_spawn_loc );
    level thread setup_attack_settings();
    var_edf196138adf1c4 = max( zm_utility::get_round_number(), function_b80976b7930587b4() );
    
    if ( level.virgil_entity zombie_utils::get_zombie_round_difficulty() < var_edf196138adf1c4 )
    {
        level.virgil_entity zombie_utils::set_zombie_round_difficulty( var_edf196138adf1c4, 0, 1 );
    }
    
    /#
        if ( getdvarint( @"hash_8b110b65590c8a61", 0 ) )
        {
            level.virgil_entity val::set( "<dev string:x5c>", "<dev string:x63>", 0 );
        }
    #/
    
    level.virgil_entity.var_c7cc8d9838136fcd = { #var_a2b544087983e9ad:&function_49c5fc3fd6543e7c, #allowable_versions:[ "secondary" ] };
    level.virgil_entity zombie_boss_virgil::function_333e5267a078290c( "head" );
    level.virgil_entity thread zombie_boss_virgil::enable_immunity();
    level.virgil_entity val::set( "virgil", "death", 0 );
    
    if ( function_17846b5d2c783c6f() )
    {
        weakpoint_locations = [ "weakspot_forearm_right", "weakspot_elbow_right", "weakspot_chest_right", "weakspot_stomach_left", "weakspot_armpit_left", "weakspot_elbow_left", "weakspot_forearm_left" ];
        
        for ( i = 0; i < weakpoint_locations.size ; i++ )
        {
            location = weakpoint_locations[ i ];
            zm_sat_locust_util::function_295a36ef38f5acae( getxhash( location ), level.virgil_entity.weak_point_objectives[ location ] );
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x27ff0cc2, Offset: 0x8514
// Size: 0x1e8
function private spawn_pops()
{
    level.locust_boss.pops_entity = agent_manager::spawn_agent( "boss_pops", ( 0, 0, 0 ), ( 0, 0, 0 ), level.players[ 0 ].team );
    logstring( "[LOCUST BOSS] Spawned Pops at location: " + level.locust_boss.pops_entity.origin );
    level.locust_boss.pops_entity.var_2fc3a5fb762afb6e = 0;
    level.locust_boss.pops_entity.var_521099eccef67894 = 1;
    visibility_mode::function_3afc3bc470c80e61( level.locust_boss.pops_entity, level.locust_boss.pops_entity.team );
    var_9f19b3714f69a042 = utility::getstruct( "robot_glocke_intro_launch_loc", "targetname" );
    structs = utility::getstructarray( "robot_barrage_launch_loc", "targetname" );
    barrage_locs = [];
    
    foreach ( struct in structs )
    {
        barrage_locs[ barrage_locs.size ] = struct.origin;
    }
    
    level.locust_boss.pops_entity boss_pops::function_1d553e9d7f5f1f2e( barrage_locs );
    level.locust_boss.pops_entity boss_pops::function_4c469f7f8939560e( var_9f19b3714f69a042.origin );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x45c2daca, Offset: 0x8704
// Size: 0x4e
function private function_6952717caa7a6608()
{
    level endon( #"game_ended" );
    level.virgil_entity waittill( #"death" );
    
    if ( !utility::flag( "boss_fight_end" ) && !utility::flag( "flag_locust_boss_players_lost" ) )
    {
        utility::flag_set( "boss_fight_end" );
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x7a1fabf2, Offset: 0x875a
// Size: 0x344
function private function_785dee38bd826ae2()
{
    overlord::function_f2fedd3be0be82ef();
    
    foreach ( player in level.players )
    {
        player thread revive_player();
        player function_75bb03a2ad3b4b09();
        player setclienttriggeraudiozone( "zm_sat_locust_outro_igc" );
        level thread game_utility::fadetoblackforplayer( player, 1, level.locust_boss.var_f4e2cc1360f58fce );
    }
    
    wait level.locust_boss.var_f4e2cc1360f58fce;
    level.locust_boss.var_c67f4938ea8ca13d scene::cleanup( 1 );
    level.locust_boss.var_c67f4338ea8c940b scene::cleanup( 1 );
    
    if ( level.locust_boss.pops_entity )
    {
        level.locust_boss.pops_entity val::reset( "pops", "death" );
        level.locust_boss.pops_entity kill();
    }
    
    if ( level.virgil_entity )
    {
        level.virgil_entity val::reset( "virgil", "death" );
        level.virgil_entity kill();
    }
    
    removeallcorpses();
    startnoninteractivesequence();
    setomnvar( "scriptable_loot_hide", 1 );
    hide_fire_traps();
    free_ammo_cache( 1 );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"endigc" );
    
    foreach ( player in level.players )
    {
        utility::delaythread( 1, &game_utility::fadetoblackforplayer, player, 0, level.locust_boss.var_f4e2cc1360f58fce );
    }
    
    level.locust_boss.var_b77c50fc08ede4e4 scene::play( undefined, undefined, "sat_cin_zm_locust_outro" );
    
    foreach ( player in level.players )
    {
        player val::reset_all( "igc_val_locust_boss_fight" );
        player clearclienttriggeraudiozone();
    }
    
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"endigc" );
    stopcinematicforall( 1, 1 );
    function_4d2cf7ef166227();
    level.locust_boss.var_b77c50fc08ede4e4 utility::delaythread( 1, &scene::cleanup, 1 );
    setomnvar( "scriptable_loot_hide", 0 );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x1dd4156b, Offset: 0x8aa6
// Size: 0x2f
function private prestream_igc( prestream_time )
{
    level.locust_boss.var_b77c50fc08ede4e4 scene::pre_stream( undefined, undefined, prestream_time, "sat_cin_zm_locust_outro" );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x5e8e7aff, Offset: 0x8add
// Size: 0x8b
function private function_75bb03a2ad3b4b09()
{
    val::set( "igc_val_locust_boss_fight", "killstreaks", 0 );
    val::set( "igc_val_locust_boss_fight", "damage", 0 );
    val::set( "igc_val_locust_boss_fight", "freezecontrols", 1 );
    val::set( "igc_val_locust_boss_fight", "allow_movement", 0 );
    val::set( "igc_val_locust_boss_fight", "ignoreme", 1 );
    val::set( "igc_val_locust_boss_fight", "ignore_afk", 1 );
    val::set( "igc_val_locust_boss_fight", "show_hud", 0 );
    battlechatter_mp::disablebattlechatter( self );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x1e0f046a, Offset: 0x8b70
// Size: 0xec
function private function_78f9d6116fa25d95( teleport_pos )
{
    foreach ( player in level.players )
    {
        player val::reset( "boss_exfil_transition", "ignore_afk" );
        player playerlogic::playerhasmoved();
    }
    
    wait level.locust_boss.var_65556bb3ce28bef6;
    level thread zm_quest::function_2e003fa13e881f92( teleport_pos );
    wait level.locust_boss.var_a43aedfbf56783d5;
    zm_exfil::disable_zm_exfil( 0 );
    zm_round_spawning::pause_round_spawning( 0, "final_scene" );
    level utility::flag_set( "rbz_allow_exfil" );
}

// Namespace zm_sat_locust_boss_fight
// Params 4, eflags: 0x4
// Checksum 0xcde62bf9, Offset: 0x8c64
// Size: 0x2d
function private function_e5bc572edb237317( var_be866219ba036c6, var_77fc4ed806f5cac9, var_51c533560222849c, var_9e41dd30435985b7 )
{
    return function_ae9b6227df1d3fe3();
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x30b2832c, Offset: 0x8c9a
// Size: 0x66
function private revive_player()
{
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
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x81ff067b, Offset: 0x8d08
// Size: 0x172
function private function_3dbb66c072b2ed73()
{
    self notify( #"hash_6ef1ed13e5e5b97d" );
    self endon( #"hash_6ef1ed13e5e5b97d" );
    level endon( #"game_ended" );
    level.virgil_entity endon( #"death" );
    
    while ( true )
    {
        health_percentage = level.virgil_entity.health / level.virgil_entity.maxhealth * 100;
        var_db8ec1c042628ac6 = health_percentage <= level.locust_boss.var_156becd7b01dc488 || !level.virgil_entity zombie_boss_virgil::has_body_armor();
        
        if ( var_db8ec1c042628ac6 && level.locust_boss.var_abbebdb114e4f57f == 1 )
        {
            function_7075393f6ff798a();
        }
        else if ( health_percentage <= level.locust_boss.var_ec288d10013c915e && level.locust_boss.var_abbebdb114e4f57f < 3 )
        {
            level.locust_boss.var_b229ffa0bcfb358c = 1;
            level.virgil_entity thread zombie_boss_virgil::function_ed45e41507b1667d();
            level.virgil_entity thread zombie_boss_virgil::function_760120540374bc8d();
            level.virgil_entity utility::ent_flag_clear( "flag_virgil_charge_bomb_enabled" );
            level.virgil_entity utility::ent_flag_set( "flag_virgil_stop_attacking" );
            level thread function_7075493f6ff7bbd();
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0xc
// Checksum 0xf4603f8d, Offset: 0x8e82
// Size: 0x2c2
function private function_7b3a45c4fdbfc566()
{
    self notify( #"hash_8cb0609a96d75613" );
    self endon( #"hash_8cb0609a96d75613" );
    level endon( #"game_ended" );
    level endon( #"hash_c7944b25ad06eee2" );
    level.virgil_entity endon( #"death" );
    var_a61fde1f3261ba1e = 10;
    var_781d5a2b2ddd795e = 0;
    
    while ( true )
    {
        valid_spawn_locs = [];
        
        foreach ( subclass in [ "zombie_base", "zombie_base_armored_heavy", "zombie_base_luna", "zombie_karkinos", "zombie_callisto", "zombie_callisto_hvt" ] )
        {
            valid_spawn_locs[ subclass ] = [];
            all_spawn_locs = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_boss_arena" ], subclass );
            
            foreach ( spawn_loc in all_spawn_locs )
            {
                var_d3f030749f6993cf = level.players;
                var_d3f030749f6993cf = arraycombine( var_d3f030749f6993cf, level.locust_boss.var_2b310761450f3fa9 );
                
                foreach ( ent in var_d3f030749f6993cf )
                {
                    if ( isplayer( ent ) && !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( ent, 0, 0 ) )
                    {
                        continue;
                    }
                    
                    if ( !( isdefined( ent ) && isdefined( ent.origin ) ) )
                    {
                        continue;
                    }
                    
                    if ( distancesquared( spawn_loc.origin, ent.origin ) <= level.locust_boss.var_d85a011a39aea0f1 )
                    {
                        valid_spawn_locs[ subclass ][ valid_spawn_locs[ subclass ].size ] = spawn_loc;
                    }
                }
                
                var_781d5a2b2ddd795e++;
                
                if ( var_781d5a2b2ddd795e >= var_a61fde1f3261ba1e )
                {
                    waitframe();
                    var_781d5a2b2ddd795e = 0;
                }
            }
        }
        
        level.locust_boss.var_1c20af01180087e0 = valid_spawn_locs;
        waitframe();
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x9570826, Offset: 0x914c
// Size: 0x3d4
function private function_55bd1e39bc8ec36a()
{
    self notify( #"hash_581c1edbe3ec4ffd" );
    self endon( #"hash_581c1edbe3ec4ffd" );
    level endon( #"game_ended", #"hash_c7944b25ad06eee2" );
    level.virgil_entity endon( #"death" );
    zombies_per_frame = 15;
    var_e67a76f26c837b44 = 50;
    cos_fov = cos( var_e67a76f26c837b44 );
    
    while ( true )
    {
        var_a2c6bd3b4b9f6d96 = 0;
        
        for ( i = 0; i < level.locust_boss.var_3a7c5451c5ba016f.size ; i++ )
        {
            zombie = level.locust_boss.var_3a7c5451c5ba016f[ i ];
            
            if ( isalive( zombie ) )
            {
                should_despawn = 0;
                var_40a7fb6e7921ba39 = zombie.var_8c780611bf9fe4ae ?? level.locust_boss.var_40455a2a5d5c5ae0;
                time_alive_ms = gettime() - zombie.spawn_time_ms;
                
                if ( zombie status_effects::has_status_effect_type( "charm" ) || zombie status_effects::has_status_effect_type( "stun" ) || zombie status_effects::has_status_effect_type( "slow" ) || zombie status_effects::has_status_effect_type( "frost_blast" ) || isdefined( zombie.target_attractor ) )
                {
                    should_despawn = 0;
                }
                else if ( time_alive_ms >= var_40a7fb6e7921ba39 )
                {
                    should_despawn = 1;
                }
                else if ( zombie.aggressive_despawn != 0 && !level.virgil_entity utility::ent_flag( "flag_locust_boss_pause_add_spawning" ) && isdefined( function_f02c63b99c9614c9( [ "zombie_base", "zombie_base_armored_heavy", "zombie_base_luna" ], zombie.subclass ) ) )
                {
                    distance = getinfluencedistanceatposition( zombie.origin );
                    
                    if ( distance >= level.locust_boss.var_883f4315da40d1c9 )
                    {
                        should_despawn = 1;
                    }
                    else if ( time_alive_ms * 0.001 >= level.locust_boss.var_a81d69764c10948d && distance < level.locust_boss.var_883f4315da40d1c9 && distance >= level.locust_boss.var_be233d540338b55a )
                    {
                        should_despawn = 1;
                        alive_players = utility::get_alive_players( 0 );
                        
                        foreach ( player in alive_players )
                        {
                            forward = anglestoforward( player.angles );
                            var_43d7b7dba2dc18f5 = zombie.origin - player.origin;
                            dot = vectordot( forward, var_43d7b7dba2dc18f5 );
                            check_value = cos_fov * distance;
                            
                            if ( dot < 0 )
                            {
                                continue;
                            }
                            
                            if ( dot >= check_value )
                            {
                                should_despawn = 0;
                                break;
                            }
                        }
                    }
                }
                
                if ( should_despawn && !is_boss_ent( zombie ) )
                {
                    if ( zombie val::get( "damageshield_allow_quest_kill" ) )
                    {
                        zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
                    }
                    
                    zombie.var_a13bed1ac47e1b2c = 1;
                    zombie kill();
                    level.locust_boss.var_4721b8a237c452ba++;
                }
                
                var_a2c6bd3b4b9f6d96++;
                
                if ( var_a2c6bd3b4b9f6d96 >= zombies_per_frame )
                {
                    waitframe();
                    var_a2c6bd3b4b9f6d96 = 0;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x6cb8febe, Offset: 0x9528
// Size: 0x85
function private function_b80976b7930587b4()
{
    if ( isdefined( level.directed_mode ) )
    {
        return level.locust_boss.var_e19d73111b687b47;
    }
    
    player_count = level.players.size;
    squad_size_frac = math::lerp_fraction( 1, 4, player_count );
    return roundint( math::lerp( level.locust_boss.var_40b00bc48b18b2a8, level.locust_boss.var_5ae9842b9e893bea, squad_size_frac ) );
}

// Namespace zm_sat_locust_boss_fight
// Params 2, eflags: 0x4
// Checksum 0xef686379, Offset: 0x95b5
// Size: 0x1f8
function private get_zombie_base_speed( var_3d92eee1fec7dd4b = undefined, speed_weights = undefined )
{
    speeds = var_3d92eee1fec7dd4b ?? [ "walk", "run", "sprint", "super_sprint" ];
    
    if ( isdefined( speed_weights ) && speed_weights.size == speeds.size )
    {
        return ( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( utility::random_weighted( speeds, speed_weights ) == "super_sprint" || utility::random_weighted( speeds, speed_weights ) == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && utility::random_weighted( speeds, speed_weights ) == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && utility::random_weighted( speeds, speed_weights ) == "sprint" ? "run" : utility::random_weighted( speeds, speed_weights ) );
    }
    
    return level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( utility::array_random( speeds ) == "super_sprint" || utility::array_random( speeds ) == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && utility::array_random( speeds ) == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && utility::array_random( speeds ) == "sprint" ? "run" : utility::array_random( speeds );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x8ce953ab, Offset: 0x97b5
// Size: 0x15
function private function_bcd0c1d941da37a()
{
    return level.locust_boss.var_b00308c2518fb5fd;
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xea339d5c, Offset: 0x97d3
// Size: 0x230
function private on_zombie_killed( params )
{
    if ( self.spawn_settings.var_cd510aa21ac99288 )
    {
        if ( !isdefined( self.spawn_settings.var_cd510aa21ac99288[ self.subclass ] ) )
        {
            self.spawn_settings.var_cd510aa21ac99288[ self.subclass ] = 0;
        }
        
        self.spawn_settings.var_cd510aa21ac99288[ self.subclass ] = maxint( self.spawn_settings.var_cd510aa21ac99288[ self.subclass ] - 1, 0 );
    }
    
    if ( self.spawn_settings )
    {
        self.spawn_settings.zombies_killed = self.spawn_settings.zombies_killed ?? 0;
        
        if ( isplayer( params.eattacker ) && params.objweapon.basenamehash != %"none" )
        {
            self.spawn_settings.zombies_killed++;
        }
    }
    
    if ( isarray( self.spawn_settings.special_drops ) && self.spawn_settings.special_drops.size > 0 )
    {
        for ( i = 0; i < self.spawn_settings.special_drop_count ; i++ )
        {
            drop_point = getrandomnavpoint( self.origin, 75 );
            drop_bundle = self.spawn_settings.special_drops[ randomint( self.spawn_settings.special_drops.size ) ];
            itembundle = getscriptbundle( hashcat( %"itemspawnentry:", drop_bundle ) );
            common_item::function_47324f290423b2d1( itembundle, self.origin, drop_point );
        }
    }
    
    level.locust_boss.var_3a7c5451c5ba016f = arrayremove( level.locust_boss.var_3a7c5451c5ba016f, self );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x82eeff8e, Offset: 0x9a0b
// Size: 0xa6
function private function_c0dd49e279947594( params )
{
    if ( params.streakinfo.var_c7cc8d9838136fcd.glocke_drop_settings )
    {
        params.type = params.streakinfo.var_c7cc8d9838136fcd.glocke_drop_settings.type;
    }
    
    params.from_position = level.locust_boss.pops_entity boss_pops::function_5841cefc95b45c06();
    params.height_override = 22000;
    params.control_point_offset = 6000;
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xda41b03e, Offset: 0x9ab9
// Size: 0xe3
function private function_23d57e953c8a20f( params )
{
    assert( params.glocke );
    
    if ( params.type == "delivery_quest_no_float" && isdefined( params.glocke.fire_trap_payload ) )
    {
        show_fire_trap( params.glocke.fire_trap_payload );
        spawn_options = common_item::function_c5093ef57497e721( params.glocke );
        spawn_options.var_8d4f327170228364 = 0;
        spawn_options.dropradiusscale = 2;
        
        for ( i = 0; i < params.glocke.var_5975ea4af4bcfe6c ; i++ )
        {
            common_item::function_325e28c0fb65c36a( "zm_bernard_secondary", 1, spawn_options );
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x74068ae2, Offset: 0x9ba4
// Size: 0x75
function private function_ef95129f5503d36c( params )
{
    params.spawn_list = getxhashasset( "itemspawnlist:zm_sat_locust_glocke_drop_boss_fight_tier_3" );
    player_count = level.players.size;
    squad_size_frac = math::lerp_fraction( 1, 4, player_count );
    var_15190186ad7ea77 = roundint( math::lerp( 7, 12, squad_size_frac ) );
    params.spawn_count = var_15190186ad7ea77;
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x9949d598, Offset: 0x9c21
// Size: 0x83
function private function_5532a1bf6661e432( params )
{
    var_7146e7ac9568191 = getdvarint( @"hash_eafb708aa184ea38", 0 );
    can_use = zombie_boss_virgil_pops::function_1255a83f7bf87761( params.bundle.killstreakref ) || var_7146e7ac9568191;
    
    if ( !can_use )
    {
        params.var_1b38ed24a6c4e157 = undefined;
        params.out_errormessage = get_controller_error_message();
        return;
    }
    
    params.var_1b38ed24a6c4e157 = 1;
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xedcee6dd, Offset: 0x9cac
// Size: 0x5e
function private function_55f2fcd4ebd3047a( streakinfo )
{
    var_7146e7ac9568191 = getdvarint( @"hash_eafb708aa184ea38", 0 );
    can_use = zombie_boss_virgil_pops::function_1255a83f7bf87761( streakinfo.bundle.killstreakref ) || var_7146e7ac9568191;
    
    if ( !can_use )
    {
        return get_controller_error_message();
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xc8b9895c, Offset: 0x9d13
// Size: 0x2e
function private get_controller_error_message()
{
    if ( level.locust_boss.var_abbebdb114e4f57f == 1 )
    {
        return %"zm_sat_locust/killstreak_bernard_unavailable";
    }
    
    return %"zm_sat_locust/killstreak_bernard_offline";
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x20a3cf7, Offset: 0x9d4a
// Size: 0x156, Type: bool
function private function_49c5fc3fd6543e7c( trace )
{
    player = self;
    var_5fdbe30accd88987 = trace[ "position" ];
    direction = vectornormalize( var_5fdbe30accd88987 - player.origin );
    var_d2a5054f32a9bf8f = [ "arm_right", "torso_lower", "torso_upper" ];
    highest_dot = undefined;
    var_7a92c5deb27644fb = undefined;
    
    foreach ( body_location in var_d2a5054f32a9bf8f )
    {
        body_pos = level.virgil_entity.origin;
        body_dir = vectornormalize( body_pos - player.origin );
        dot = vectordot( direction, body_dir );
        
        if ( !isdefined( var_7a92c5deb27644fb ) || dot > highest_dot )
        {
            var_7a92c5deb27644fb = body_pos;
            highest_dot = dot;
        }
    }
    
    return var_7a92c5deb27644fb ?? trace[ "position" ];
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x774f8d28, Offset: 0x9ea9
// Size: 0x1bf
function private on_totem_destroyed( params )
{
    totem_ent = params.totem_ent;
    
    if ( isent( totem_ent ) )
    {
        level.locust_boss.var_2b310761450f3fa9 = arrayremove( level.locust_boss.var_2b310761450f3fa9, totem_ent );
    }
    
    level.locust_boss.var_d9dd0e342567c6ca = maxint( 0, level.locust_boss.var_d9dd0e342567c6ca - 1 );
    logstring( "[LOCUST BOSS] on_totem_destroyed: remaining=" + level.locust_boss.var_d9dd0e342567c6ca + " phase=" + level.locust_boss.var_abbebdb114e4f57f + " FLAG TOTEMS_STATE_ACTIVE : " + level.virgil_entity utility::ent_flag( "flag_virgil_totems_state_active" ) + " FLAG HIDDEN : " + level.virgil_entity utility::ent_flag( "flag_virgil_hidden" ) );
    
    if ( level.locust_boss.var_d9dd0e342567c6ca == 0 && level.locust_boss.var_abbebdb114e4f57f == 2 && level.virgil_entity utility::ent_flag( "flag_virgil_totems_state_active" ) )
    {
        if ( level.locust_boss.var_3a375732324696b2.size > 0 )
        {
            power_up_pos = totem_ent.spawn_info_struct.recovery_origin + ( 0, 0, -80 );
            powerups::force_powerup_drop( utility::array_random( level.locust_boss.var_3a375732324696b2 ), power_up_pos, "quest" );
        }
        
        logstring( "[LOCUST BOSS] on_totem_destroyed: All totems destroyed, starting transition_to_dps_state" );
        level thread transition_to_dps_state();
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xd3eaadcf, Offset: 0xa070
// Size: 0xdf
function private transition_to_dps_state()
{
    level endon( #"hash_c7944b25ad06eee2", #"game_ended" );
    level.virgil_entity endon( #"death" );
    logstring( "[LOCUST BOSS] transition_to_dps_state: Waiting for FLAG_VIRGIL_HIDDEN. FLAG HIDDEN : " + level.virgil_entity utility::ent_flag( "flag_virgil_hidden" ) + " FLAG BUSY_SCENE : " + level.virgil_entity utility::ent_flag( "flag_virgil_busy_scene" ) );
    level.virgil_entity utility::ent_flag_wait( "flag_virgil_hidden" );
    
    if ( function_17846b5d2c783c6f() )
    {
        utility::flag_clear( "mq_bs_show_guidance" );
        utility::flag_set( "mq_bs_step_02_a" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    logstring( "[LOCUST BOSS] transition_to_dps_state: FLAG_VIRGIL_HIDDEN confirmed. Proceeding to disable totem state" );
    level.virgil_entity function_7889284aec46c15a();
    level.virgil_entity thread enter_dps_state();
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xefb08a7b, Offset: 0xa157
// Size: 0x57
function private function_c2890d39733d97c0( params )
{
    totem_ent = params.totem_ent;
    
    if ( isent( totem_ent ) )
    {
        level.locust_boss.var_2b310761450f3fa9[ level.locust_boss.var_2b310761450f3fa9.size ] = totem_ent;
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 3
// Checksum 0x8456e994, Offset: 0xa1b6
// Size: 0x18c
function function_3e87b4905eee6015( position, spawn_radius, add_subclass_list )
{
    valid_spawn_locs = [];
    spawn_radius_sq = spawn_radius * spawn_radius;
    
    if ( !isdefined( add_subclass_list ) )
    {
        add_subclass_list = [ "zombie_base", "zombie_base_armored_heavy", "zombie_base_luna", "zombie_karkinos", "zombie_callisto", "zombie_callisto_hvt" ];
    }
    
    foreach ( subclass in add_subclass_list )
    {
        valid_spawn_locs[ subclass ] = [];
        all_spawn_locs = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_boss_arena" ], subclass );
        
        foreach ( spawn_loc in all_spawn_locs )
        {
            if ( distancesquared( spawn_loc.origin, position ) <= spawn_radius_sq )
            {
                valid_spawn_locs[ subclass ][ valid_spawn_locs[ subclass ].size ] = spawn_loc;
            }
        }
    }
    
    return valid_spawn_locs;
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0x64ad9727, Offset: 0xa34b
// Size: 0x16b
function enter_dps_state()
{
    level endon( #"hash_c7944b25ad06eee2", #"game_ended" );
    level.virgil_entity endon( #"death" );
    logstring( "[LOCUST BOSS] enter_dps_state: Starting. dps_state_count=" + level.locust_boss.var_9194bcfae1efe20c + " FLAG HIDDEN : " + level.virgil_entity utility::ent_flag( "flag_virgil_hidden" ) + " FLAG BUSY_SCENE : " + level.virgil_entity utility::ent_flag( "flag_virgil_busy_scene" ) + " FLAG IS_READY : " + level.virgil_entity utility::ent_flag( "flag_virgil_is_ready" ) + " FLAG ATTACK_RUNIC_VOLLEY : " + level.virgil_entity utility::ent_flag( "flag_virgil_attack_runic_volley" ) + " FLAG ATTACK_CHARGE_BOMB : " + level.virgil_entity utility::ent_flag( "flag_virgil_attack_charge_bomb" ) + " FLAG IN_PAIN : " + level.virgil_entity utility::ent_flag( "flag_virgil_in_pain" ) );
    level.locust_boss.var_9194bcfae1efe20c++;
    level.locust_boss.var_41a2f002c2dd7d40[ level.locust_boss.var_9194bcfae1efe20c ] = 0;
    zombie_boss_virgil::function_760120540374bc8d();
    utility::ent_flag_set( "flag_locust_boss_pause_add_spawning" );
    logstring( "[LOCUST BOSS] enter_dps_state: Calling phase_2_shadowsmith_show (blocking)" );
    function_de7ce8f81316c914();
    thread zombie_boss_virgil::update_state_change();
    level thread function_ede268a1a8fd1042();
    level thread namespace_fd7b16d2452999a9::function_11135981b04b76d5();
    level thread function_8d6b0a38d3edc0a7();
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x92603f9d, Offset: 0xa4be
// Size: 0xae
function private function_ede268a1a8fd1042()
{
    level endon( #"hash_c7944b25ad06eee2", #"game_ended" );
    level.virgil_entity endon( #"death" );
    level.virgil_entity zombie_boss_virgil::function_682e7757f916b296( "taunt_plyr_facing_05", level.locust_boss.var_c67f4338ea8c940b );
    level.virgil_entity thread zombie_boss_virgil::function_3719639b6a7c555c( [ "weakspot_chest_right", "weakspot_stomach_left", "weakspot_armpit_left" ] );
    
    if ( function_17846b5d2c783c6f() )
    {
        utility::flag_set( "mq_bs_show_guidance" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x63f10e5, Offset: 0xa574
// Size: 0x42
function private function_9cf2722dfb4745fa()
{
    utility::ent_flag_clear( "flag_virgil_runic_volley_enabled" );
    utility::ent_flag_clear( "flag_virgil_charge_bomb_enabled" );
    level thread namespace_fd7b16d2452999a9::function_fb1b5d4ec6ce76bd();
    level.virgil_entity thread zombie_boss_virgil::function_ed45e41507b1667d();
    level.virgil_entity thread zombie_boss_virgil::function_760120540374bc8d();
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0xc
// Checksum 0xa8fc625d, Offset: 0xa5be
// Size: 0x65
function private function_7889284aec46c15a()
{
    self notify( #"hash_3965fd2efa4f7fea" );
    self endon( #"hash_3965fd2efa4f7fea" );
    level endon( #"hash_c7944b25ad06eee2", #"game_ended" );
    level.virgil_entity endon( #"death" );
    level thread zombie_boss_virgil_totem_attack::kill_all_totems();
    function_b9f98165d48b9a1a();
    function_42ff753e6d5bc179();
    utility::ent_flag_clear( "flag_virgil_totems_state_active" );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x82a188c, Offset: 0xa62b
// Size: 0x208
function private function_358d5c2dc3a83ee8()
{
    level endon( #"hash_c7944b25ad06eee2", #"game_ended" );
    level.virgil_entity endon( #"death" );
    utility::ent_flag_set( "flag_virgil_totems_state_active" );
    thread function_9cf2722dfb4745fa();
    zombie_boss_virgil::boss_play_dialogue( #"totem_first" );
    thread function_c09e3c93cc1af9a5();
    
    if ( function_17846b5d2c783c6f() )
    {
        utility::flag_set( "mq_bs_show_guidance" );
        utility::flag_clear( "mq_bs_step_02_a" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    level thread namespace_589ae4efe3ba85ad::function_950d4585ce2b2a46();
    level.virgil_entity utility::ent_flag_clear( "flag_locust_boss_pause_add_spawning" );
    level.locust_boss.var_3b88fc59d8c7825f thread function_313accf65ecc31c1();
    
    if ( level.locust_boss.var_dd3af4dd260cd224 >= level.locust_boss.var_796f5ac8707d9989 )
    {
        if ( !getdvarint( @"hash_395cb66d7b1c0a73", 1 ) )
        {
            level.locust_boss.var_676d9b41331ea36f thread function_34a8c89ccb015bd7();
        }
    }
    
    totem_array_index = clampint( level.locust_boss.var_dd3af4dd260cd224, 0, level.locust_boss.var_352c32b3da81b2e7.size - 1 );
    totem_count_array = level.locust_boss.var_352c32b3da81b2e7[ totem_array_index ];
    totem_count = totem_count_array[ level.players.size - 1 ];
    level.locust_boss.var_d9dd0e342567c6ca = totem_count;
    var_acbfdd783fdb6007 = level.locust_boss.var_dd3af4dd260cd224 >= 1;
    
    for ( i = 0; i < totem_count ; i++ )
    {
        wait 9;
        level thread zombie_boss_virgil_totem_attack::initiate_totem_attack( var_acbfdd783fdb6007 );
    }
    
    thread zombie_boss_virgil::update_state_change();
    level.locust_boss.var_dd3af4dd260cd224++;
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x21c086e4, Offset: 0xa83b
// Size: 0x1b2
function private function_c09e3c93cc1af9a5()
{
    level endon( #"game_ended" );
    level endon( #"hash_c7944b25ad06eee2" );
    self endon( #"death", #"hash_4e721058c69d87d0" );
    logstring( "[LOCUST BOSS] phase_2_shadowsmith_hide: Starting. FLAG IS_READY : " + level.virgil_entity utility::ent_flag( "flag_virgil_is_ready" ) + " FLAG HIDDEN : " + level.virgil_entity utility::ent_flag( "flag_virgil_hidden" ) + " FLAG BUSY_SCENE : " + level.virgil_entity utility::ent_flag( "flag_virgil_busy_scene" ) + " FLAG ATTACK_RUNIC_VOLLEY : " + level.virgil_entity utility::ent_flag( "flag_virgil_attack_runic_volley" ) + " FLAG ATTACK_CHARGE_BOMB : " + level.virgil_entity utility::ent_flag( "flag_virgil_attack_charge_bomb" ) + " FLAG IN_PAIN : " + level.virgil_entity utility::ent_flag( "flag_virgil_in_pain" ) );
    self notify( #"hash_9038a238bdb76d59" );
    zombie_boss_virgil::enable_immunity();
    level.virgil_entity utility::ent_flag_wait( "flag_virgil_is_ready" );
    utility::ent_flag_set( "flag_virgil_busy_scene" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_invul" );
    logstring( "[LOCUST BOSS] phase_2_shadowsmith_hide: Playing virgil_hide_out scene" );
    level.locust_boss.var_c67f4238ea8c91d8 scene::play( self, "virgil_hide_out", undefined, 0 );
    level.locust_boss.var_c67f4238ea8c91d8 thread scene::play( self, "virgil_hide_out_idle", undefined, 0 );
    utility::ent_flag_clear( "flag_virgil_busy_scene" );
    self setscriptablepartstate( #"visibility", #"hidden" );
    utility::ent_flag_set( "flag_virgil_hidden" );
    zombie_boss_virgil::virgil_hide();
    logstring( "[LOCUST BOSS] phase_2_shadowsmith_hide: Complete. Virgil is now hidden" );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x792a11a, Offset: 0xa9f5
// Size: 0x1a2
function private function_de7ce8f81316c914()
{
    level endon( #"game_ended" );
    self endon( #"death", #"hash_9038a238bdb76d59" );
    logstring( "[LOCUST BOSS] phase_2_shadowsmith_show: Starting. FLAG HIDDEN : " + level.virgil_entity utility::ent_flag( "flag_virgil_hidden" ) + " FLAG BUSY_SCENE : " + level.virgil_entity utility::ent_flag( "flag_virgil_busy_scene" ) + " FLAG IS_READY : " + level.virgil_entity utility::ent_flag( "flag_virgil_is_ready" ) + " FLAG ATTACK_RUNIC_VOLLEY : " + level.virgil_entity utility::ent_flag( "flag_virgil_attack_runic_volley" ) + " FLAG ATTACK_CHARGE_BOMB : " + level.virgil_entity utility::ent_flag( "flag_virgil_attack_charge_bomb" ) + " FLAG IN_PAIN : " + level.virgil_entity utility::ent_flag( "flag_virgil_in_pain" ) );
    self notify( #"hash_4e721058c69d87d0" );
    utility::ent_flag_clear( "flag_virgil_hidden" );
    level.virgil_entity utility::ent_flag_wait( "flag_virgil_is_ready" );
    zombie_boss_virgil::virgil_show();
    self setscriptablepartstate( #"visibility", #"visible" );
    utility::ent_flag_set( "flag_virgil_busy_scene" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_main" );
    logstring( "[LOCUST BOSS] phase_2_shadowsmith_show: Playing virgil_hide_in scene" );
    level.locust_boss.var_c67f4238ea8c91d8 scene::play( self, "virgil_hide_in" );
    utility::ent_flag_clear( "flag_virgil_busy_scene" );
    zombie_boss_virgil::disable_immunity();
    logstring( "[LOCUST BOSS] phase_2_shadowsmith_show: Complete. Virgil is now visible" );
    level.locust_boss.var_c67f4438ea8c963e thread scene::play( self, "virgil_player_facing_idle" );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xeebedf7d, Offset: 0xab9f
// Size: 0x375
function private function_8d6b0a38d3edc0a7()
{
    level endon( #"hash_c7944b25ad06eee2", #"game_ended" );
    level.virgil_entity endon( #"death" );
    level.virgil_entity utility::ent_flag_wait( "flag_virgil_is_ready" );
    var_91223ed6ed74b713 = level.virgil_entity.health;
    time_out_time_ms = gettime() + level.locust_boss.var_430aab74708e791 * 1000;
    var_bafa5965a960e259 = time_out_time_ms - level.locust_boss.var_77a58a9369ed11da * 1000;
    var_c2f1f4865e8d1bfc = level.locust_boss.var_9194bcfae1efe20c >= level.locust_boss.var_19c1a99789f57362 ? 2 : 1;
    
    if ( level.locust_boss.var_9194bcfae1efe20c >= level.locust_boss.var_19c1a99789f57362 )
    {
        level thread namespace_fd7b16d2452999a9::function_9b44b0b758f8469a( level.locust_boss.var_fd7b343d1dba2d37, level.locust_boss.var_28b04aa4e0e753a2, level.locust_boss.var_5c55d7663a23fce9 );
        level.virgil_entity utility::ent_flag_clear( "flag_virgil_attack_charge_bomb_require_cooldown" );
    }
    
    level.virgil_entity utility::ent_flag_set( "flag_virgil_charge_bomb_enabled" );
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_attack_charge_bomb_require_players" );
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_attack_charge_bomb_interrupt_requested" );
    
    while ( !level.virgil_entity utility::ent_flag( "flag_virgil_totems_state_active" ) && gettime() <= time_out_time_ms )
    {
        if ( var_91223ed6ed74b713 - level.virgil_entity.health >= level.locust_boss.var_1623eb1928ba7967 )
        {
            break;
        }
        
        if ( level.locust_boss.var_41a2f002c2dd7d40[ level.locust_boss.var_9194bcfae1efe20c ] >= var_c2f1f4865e8d1bfc && !level.virgil_entity utility::ent_flag( "flag_virgil_runic_volley_enabled" ) )
        {
            level.virgil_entity utility::ent_flag_set( "flag_virgil_runic_volley_enabled" );
            level.virgil_entity utility::ent_flag_set( "flag_virgil_attack_charge_bomb_require_players" );
            level.virgil_entity utility::ent_flag_set( "flag_virgil_attack_charge_bomb_require_cooldown" );
        }
        
        if ( gettime() >= var_bafa5965a960e259 && level.virgil_entity utility::ent_flag( "flag_virgil_charge_bomb_enabled" ) )
        {
            level.virgil_entity utility::ent_flag_clear( "flag_virgil_charge_bomb_enabled" );
        }
        
        waitframe();
    }
    
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_charge_bomb_enabled" );
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_runic_volley_enabled" );
    level.virgil_entity utility::ent_flag_set( "flag_virgil_attack_charge_bomb_require_players" );
    level.virgil_entity utility::ent_flag_set( "flag_virgil_attack_charge_bomb_require_cooldown" );
    level.virgil_entity thread zombie_boss_virgil::function_760120540374bc8d();
    
    while ( !level.virgil_entity utility::ent_flag( "flag_virgil_is_ready" ) || level.locust_boss.var_b229ffa0bcfb358c )
    {
        waitframe();
    }
    
    if ( !level.virgil_entity utility::ent_flag( "flag_virgil_totems_state_active" ) )
    {
        level.virgil_entity thread function_358d5c2dc3a83ee8();
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xe5627c2d, Offset: 0xaf1c
// Size: 0x26e
function private function_c4452a75b0f45366()
{
    level endon( #"hash_c7944b25ad06eee2", #"game_ended" );
    level.virgil_entity endon( #"death" );
    level callback::add( "on_zombie_ai_damaged", &function_8e960f8ef4ce0871 );
    level.virgil_entity setscriptablepartstate( #"eyes", #"eyes_weak_point" );
    level thread namespace_fd7b16d2452999a9::function_11135981b04b76d5();
    level thread namespace_fd7b16d2452999a9::function_9b44b0b758f8469a( level.locust_boss.var_fd7b343d1dba2d37, level.locust_boss.var_28b04aa4e0e753a2, level.locust_boss.var_5c55d7663a23fce9 );
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_stop_attacking" );
    level.virgil_entity utility::ent_flag_set( "flag_virgil_runic_volley_enabled" );
    var_bdf10f264612a41c = 15;
    var_9c0e820f85ab7785 = gettime();
    var_b5c2fe7aa3f65b1b = level.virgil_entity.health / level.virgil_entity.maxhealth * 100;
    
    while ( !level.virgil_entity.var_2b44f8c076fdbd73 )
    {
        current_time_ms = gettime();
        var_b5c2fe7aa3f65b1b = level.virgil_entity.health / level.virgil_entity.maxhealth * 100;
        
        if ( var_b5c2fe7aa3f65b1b <= level.locust_boss.var_4cd56d4f3f6e2c01 )
        {
            level.virgil_entity.var_e1e8440f02996bbd = 1;
        }
        
        if ( current_time_ms >= var_9c0e820f85ab7785 && namespace_fd7b16d2452999a9::is_on_cooldown() && zombie_boss_virgil::function_8fc422943bc5c65a() && !level.virgil_entity utility::ent_flag( "flag_virgil_attack_runic_volley" ) )
        {
            level.virgil_entity thread zombie_boss_virgil::function_682e7757f916b296( "phase3_transition_fail", level.locust_boss.var_c67f4238ea8c91d8 );
            var_9c0e820f85ab7785 = current_time_ms + var_bdf10f264612a41c * 1000;
        }
        
        waitframe();
    }
    
    level callback::remove( "on_zombie_ai_damaged", &function_8e960f8ef4ce0871 );
    var_31854a9e29e8d2d = level.virgil_entity utility::ent_flag( "flag_virgil_attack_runic_volley" );
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_runic_volley_enabled" );
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_attack_runic_volley" );
    level function_156c4dfcf529f702( var_31854a9e29e8d2d );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xc0b3ef16, Offset: 0xb192
// Size: 0x58
function private function_219ddf701bf5ddb3( params )
{
    if ( params.was_killed && level.locust_boss.var_abbebdb114e4f57f == 1 && function_17846b5d2c783c6f() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0
// Checksum 0x7081bd6f, Offset: 0xb1f2
// Size: 0x16d
function deliver_fire_traps()
{
    if ( getdvar( @"hash_69cbca361cfd76bf", 1 ) )
    {
        wait 1;
        
        foreach ( fire_trap_scriptable in level.locust_boss.var_4546d335d28e1ce0 )
        {
            from_position = level.locust_boss.pops_entity boss_pops::function_5841cefc95b45c06();
            glocke_data = zm_sat_locust_glocke_drop::request_glocke_drop( fire_trap_scriptable.origin, from_position, "delivery_quest_no_float" );
            glocke_data.glocke.fire_trap_payload = fire_trap_scriptable;
            glocke_data.glocke.var_5975ea4af4bcfe6c = 0;
            var_3b27e164067ea890 = 500;
            var_a1a30cf0aec35001 = var_3b27e164067ea890 * var_3b27e164067ea890;
            
            if ( distancesquared( level.locust_boss.arena_center_struct.origin, fire_trap_scriptable.origin ) <= var_a1a30cf0aec35001 )
            {
                glocke_data.glocke.var_5975ea4af4bcfe6c = 0;
            }
            
            waitframe();
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xd018af6f, Offset: 0xb367
// Size: 0x1df
function private hide_fire_traps( only_final = 0 )
{
    level utility::flag_wait( "fire_trap_switch_trap_init_finished" );
    
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( issubstr( trap.name, "boss" ) )
        {
            group_id_tokens = strtok( trap.groupid, "_" );
            
            if ( group_id_tokens.size > 0 )
            {
                group_num_str = group_id_tokens[ group_id_tokens.size - 1 ];
                
                if ( only_final && group_num_str != "2" )
                {
                    continue;
                }
                
                trap.trap_scriptable.var_fa80ffd30d85cba2 = int( group_num_str );
                trap.trap_scriptable setscriptablepartstate( #"model", #"hidden" );
                trap.trap_scriptable setscriptablepartstate( #"interactable", #"disabled" );
                coll_target_name = "boss_grant_col_" + group_num_str;
                trap_collision = getent( coll_target_name, #targetname );
                
                if ( isdefined( trap_collision ) )
                {
                    trap_collision connectpaths();
                    trap_collision hide();
                }
                
                trap.trap_scriptable.collision = trap_collision;
            }
            
            level.locust_boss.var_4546d335d28e1ce0[ level.locust_boss.var_4546d335d28e1ce0.size ] = trap.trap_scriptable;
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x93387e99, Offset: 0xb54e
// Size: 0x13c
function private disable_fire_traps()
{
    level utility::flag_wait( "fire_trap_switch_trap_init_finished" );
    
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( issubstr( trap.name, "boss" ) )
        {
            if ( trap.trap_scriptable.var_32f1e7774266024b.shared_in_use )
            {
                trap.trap_scriptable notify( #"deactivate_trap" );
            }
            
            trap.trap_scriptable.perma_disabled = 1;
            trap.trap_scriptable setscriptablepartstate( #"interactable", #"disabled" );
            level.locust_boss.var_4546d335d28e1ce0[ level.locust_boss.var_4546d335d28e1ce0.size ] = trap.trap_scriptable;
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xf28e851f, Offset: 0xb692
// Size: 0xa8
function private show_fire_traps()
{
    level utility::flag_wait( "fire_trap_switch_trap_init_finished" );
    
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( issubstr( trap.name, "boss" ) )
        {
            show_fire_trap( trap.trap_scriptable );
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xdec3ca22, Offset: 0xb742
// Size: 0x10e
function private show_fire_trap( fire_trap_scriptable )
{
    fire_trap_scriptable setscriptablepartstate( #"model", #"default" );
    fire_trap_scriptable setscriptablepartstate( #"interactable", #"usable" );
    
    if ( fire_trap_scriptable.var_fa80ffd30d85cba2 == 2 )
    {
        level.locust_boss.center_fire_trap = fire_trap_scriptable;
        ammo_cache_instances = level.contentmanager.spawnedinstances[ "ammo_cache" ][ 0 ].var_1d6cddfc47031bff[ "ammo_cache_spawn" ];
        ammo_cache_instance = function_47c86977a18df38b( ammo_cache_instances, level.locust_boss.center_fire_trap.origin );
        level.locust_boss.ammo_cache = ammo_cache_instance;
    }
    
    if ( isdefined( fire_trap_scriptable.collision ) )
    {
        fire_trap_scriptable.collision disconnectpaths();
        fire_trap_scriptable.collision show();
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x5f3d903d, Offset: 0xb858
// Size: 0xd4
function private free_ammo_cache( hide = 0 )
{
    if ( level.locust_boss.ammo_cache.block )
    {
        utility::callsharedfunc( #"zm_blizzard", #"unfreeze_feature", level.locust_boss.ammo_cache, "ammo_cache" );
    }
    
    if ( hide && level.locust_boss.ammo_cache )
    {
        content_manager::disable_feature( level.locust_boss.ammo_cache, "ammo_cache" );
        level.locust_boss.ammo_cache.ammocache_trigger setscriptablepartstate( #"base", #"hidden" );
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x5c555dd9, Offset: 0xb934
// Size: 0x59
function private function_17aec1e5ce578ef6( params )
{
    zombie_boss_virgil::function_a09504af23da06b0( params.player );
    level.locust_boss.var_5b773f68ed81c923 = arraycombineunique( level.locust_boss.var_5b773f68ed81c923, [ params.player ] );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xe0d0f592, Offset: 0xb995
// Size: 0x6b
function private function_f12de54f3de6bdc0( params )
{
    if ( level.virgil_entity utility::ent_flag( "flag_virgil_freeze_effects_active" ) )
    {
        zombie_boss_virgil::function_8c7b9b9da0fc6edf( params.player );
    }
    
    level.locust_boss.var_5b773f68ed81c923 = arrayremove( level.locust_boss.var_5b773f68ed81c923, params.player );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x46db59a2, Offset: 0xba08
// Size: 0x2b
function private function_f9ec749f5254db40( params )
{
    if ( level.virgil_entity utility::ent_flag( "flag_virgil_freeze_effects_active" ) )
    {
        zombie_boss_virgil::function_8c7b9b9da0fc6edf( self );
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x2c606f8c, Offset: 0xba3b
// Size: 0x15
function private function_72e0775f8af3e2c8( params )
{
    thread function_f9ec749f5254db40( params );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x373fc48a, Offset: 0xba58
// Size: 0x50
function private callback_player_spawned( params )
{
    if ( self.var_2d6ce24b1278055a )
    {
        return;
    }
    
    current_zone_struct = zone_manager::get_current_zone();
    
    if ( current_zone_struct.script_zone_name != "zone_boss_arena" )
    {
        function_77bf79da6a2825ec( 0 );
    }
    
    thread function_f9ec749f5254db40( params );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xdb372158, Offset: 0xbab0
// Size: 0x3d
function private function_bd3f2e6f362aa4a9( params )
{
    if ( level.virgil_entity utility::ent_flag( "flag_virgil_totems_state_active" ) )
    {
        level thread namespace_dba99780c141b678::function_a049cf755cfbf450( self.origin, 2000, namespace_dba99780c141b678::function_f5d5ec8b4b8a5e33() );
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x6d3ed5b0, Offset: 0xbaf5
// Size: 0x79
function private function_fd8c75e1fd3c7254( params )
{
    if ( !params.var_f5ff424098b1d5f9 )
    {
        params.from_position = level.locust_boss.pops_entity boss_pops::function_5841cefc95b45c06();
        params.control_point = ( params.request_position[ 0 ], params.request_position[ 1 ], 22000 );
        params.var_f5ff424098b1d5f9 = 1;
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xf1f1c033, Offset: 0xbb76
// Size: 0x54, Type: bool
function private function_adf8f2ef3d2f23c2( params )
{
    player = params.player;
    protected = zombie_boss_virgil::function_23321ff001c537b( player );
    return arraycontains( level.locust_boss.var_5b773f68ed81c923, player ) || protected;
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x79891de8, Offset: 0xbbd3
// Size: 0x164
function private function_b283c0fc518ae8bf( params )
{
    if ( level utility::flag( "flag_locust_boss_players_lost" ) )
    {
        return;
    }
    
    level utility::flag_set( "flag_locust_boss_players_lost" );
    
    if ( level.locust_boss.var_abbebdb114e4f57f == 3 )
    {
        level thread open_arena_center();
    }
    
    if ( level.virgil_entity && isalive( level.virgil_entity ) )
    {
        level.virgil_entity thread function_7889284aec46c15a();
        level.virgil_entity thread function_9cf2722dfb4745fa();
        level thread namespace_589ae4efe3ba85ad::function_19acc91d6a304892();
        level thread namespace_dba99780c141b678::function_c03123422fb8e97d();
        level.virgil_entity utility::ent_flag_set( "flag_virgil_stop_attacking" );
        level.virgil_entity utility::ent_flag_set( "flag_locust_boss_pause_add_spawning" );
        level thread kill_all_adds();
        level.virgil_entity val::set( "virgil", "death", 1 );
        level.virgil_entity zombie_boss_virgil::virgil_hide();
    }
    
    if ( level.locust_boss.pops_entity && isalive( level.locust_boss.pops_entity ) )
    {
        level.locust_boss.pops_entity val::set( "pops", "death", 1 );
        level.locust_boss.pops_entity kill();
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x7607626f, Offset: 0xbd3f
// Size: 0xd, Type: bool
function private function_97a6903ec3cd5b02( params )
{
    return false;
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xf1309d3f, Offset: 0xbd55
// Size: 0x1f7
function private function_b2ea7e1d5a0ca3dd( params )
{
    if ( params.arena_section == "center" )
    {
        if ( level.locust_boss.ammo_cache && !level.locust_boss.ammo_cache.block )
        {
            utility::callsharedfunc( #"zm_blizzard", #"freeze_feature", level.locust_boss.ammo_cache, "ammo_cache" );
        }
    }
    
    var_9c39bfc2688c4ae5 = getaiarrayinradius( params.position, params.radius, "team_two_hundred" );
    
    foreach ( zombie in var_9c39bfc2688c4ae5 )
    {
        if ( isalive( zombie ) && !is_boss_ent( zombie ) )
        {
            if ( zombie val::get( "damageshield_allow_quest_kill" ) )
            {
                zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
            }
            
            zombie kill();
        }
    }
    
    if ( level.locust_boss.var_abbebdb114e4f57f == 2 )
    {
        if ( !isdefined( level.locust_boss.var_41a2f002c2dd7d40[ level.locust_boss.var_9194bcfae1efe20c ] ) )
        {
            level.locust_boss.var_41a2f002c2dd7d40[ level.locust_boss.var_9194bcfae1efe20c ] = 0;
        }
        
        level.locust_boss.var_41a2f002c2dd7d40[ level.locust_boss.var_9194bcfae1efe20c ]++;
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x63fce65e, Offset: 0xbf54
// Size: 0xb4
function private quick_start_boss_fight( params )
{
    zm_utility::open_sesame();
    function_6695afd7224b1e8b();
    wait 2;
    zm_round_spawning::pause_round_spawning( 1, "locust_boss_pause_round_spawning" );
    zm_utility::util_kill_all_zombies();
    
    foreach ( player in level.players )
    {
        player thread function_77bf79da6a2825ec();
    }
    
    level thread start_boss_fight( 0 );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x77740c8b, Offset: 0xc010
// Size: 0x2f5
function private function_e83b11eb8fabc062( params = [] )
{
    zm_utility::open_sesame();
    function_6695afd7224b1e8b();
    natural = 0;
    round = function_b80976b7930587b4();
    
    foreach ( param in params )
    {
        if ( issubstr( param, "round" ) )
        {
            round = int( removesubstr( param, "round" ) );
            continue;
        }
        
        if ( issubstr( param, "natural" ) )
        {
            natural = 1;
        }
    }
    
    wait 5;
    level notify( #"restart_round" );
    round = function_b80976b7930587b4();
    
    foreach ( param in params )
    {
        if ( issubstr( param, "round" ) )
        {
            round = int( removesubstr( param, "round" ) );
        }
    }
    
    current_round_num = zm_utility::get_round_number();
    
    if ( current_round_num < round )
    {
        var_a01e28b7bdaa1f6d = maxint( function_b80976b7930587b4(), round );
        
        if ( zm_utility::get_round_number() < var_a01e28b7bdaa1f6d )
        {
            zm_round_logic::function_68bdb49c82c0f892( var_a01e28b7bdaa1f6d );
            zm_round_logic::function_895fdc21ab019efe();
        }
        
        zm_utility::function_1bd2eda42461fad1( level.var_6781718da4f78d1c.roundnumber );
        
        while ( zm_utility::get_round_number() < var_a01e28b7bdaa1f6d )
        {
            waitframe();
        }
    }
    
    if ( arraycontains( params, "weapons" ) )
    {
        foreach ( player in level.players )
        {
            player thread zm_sat_locust_util::function_a59b225ef3240980();
        }
    }
    
    zm_round_spawning::pause_round_spawning( 1, "locust_boss_pause_round_spawning" );
    zm_utility::util_kill_all_zombies();
    
    foreach ( player in level.players )
    {
        player thread function_77bf79da6a2825ec();
    }
    
    level thread start_boss_fight( natural );
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xa74b68b2, Offset: 0xc30d
// Size: 0x17d
function private function_6695afd7224b1e8b( params )
{
    var_7192378ce0f51e6b = [ #"locust_quest_pap", #"hash_709d77ab2b2005c5", #"hash_d1612ed5d50da819", #"hash_7b26a8bb39d7312", #"hash_9a9f22ecb2a5ad11" ];
    
    foreach ( quest in var_7192378ce0f51e6b )
    {
        if ( !zm_quest::is_quest_complete( quest ) )
        {
            zm_quest = zm_quest::get_quest( quest );
            
            foreach ( step in zm_quest.steps )
            {
                zm_quest::function_e65609834444650c( step );
            }
        }
    }
    
    zm_quest = zm_quest::get_quest( #"locust_mq" );
    zm_quest::function_e65609834444650c( zm_quest.steps[ 0 ] );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0xc
// Checksum 0xd47e23e4, Offset: 0xc492
// Size: 0x10d
function private function_cc1ef5b7f7d2668e()
{
    self notify( #"hash_1ea652449695fab4" );
    self endon( #"hash_1ea652449695fab4" );
    level endon( #"game_ended" );
    level endon( #"hash_1a56ce6d49d1a451" );
    arena_platform = getent( "boss_arena_falling_col", #targetname );
    arena_platform show();
    
    for ( ;; )
    {
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( player.is_resetting )
            {
                continue;
            }
            
            if ( player function_265bf714eef2b2a5( arena_platform, ( 0, 0, 0 ), player getboundshalfsize() ) )
            {
                player thread reset_player_position();
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 2, eflags: 0x4
// Checksum 0xcbd1f712, Offset: 0xc5a7
// Size: 0x17c
function private reset_player_position( position = undefined, deal_damage = 1 )
{
    level endon( #"game_ended" );
    level endon( #"hash_1a56ce6d49d1a451" );
    self endon( #"disconnect" );
    
    /#
        if ( self isnoclip() || self isufo() )
        {
            return;
        }
    #/
    
    if ( self.sessionstate == "spectator" )
    {
        return;
    }
    
    namespace_8a6b6b859e6fcad::function_530dd8c997a5c843();
    
    if ( level.locust_boss.var_abbebdb114e4f57f == 3 )
    {
        var_a1e68c33991c906f = function_b21056d585c710d( level.locust_boss.var_8d3b74bf300b6819, self.origin );
    }
    else
    {
        var_a1e68c33991c906f = function_b21056d585c710d( level.locust_boss.safe_spawn_locs, self.origin );
    }
    
    assert( var_a1e68c33991c906f, "<dev string:x69>" );
    position = var_a1e68c33991c906f.origin;
    angles = var_a1e68c33991c906f.angles;
    self.is_resetting = 1;
    zm_utility::teleport_player( position, angles, "teleport_out_of_map", 0, 0.5 );
    self.is_resetting = 0;
    
    if ( !player::isreallyalive( self ) )
    {
        level thread game_utility::fadetoblackforplayer( self, 0, 0.5 );
        zm_utility::set_player_frozen_vars( 0, "teleport_out_of_map" );
        return;
    }
    
    namespace_8a6b6b859e6fcad::function_c8b5c790334752c6( deal_damage );
    self.var_a3cdd26776d9bf4a = gettime();
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x4e9af972, Offset: 0xc72b
// Size: 0xc4
function private function_528dfc7eb7ea8402()
{
    level endon( #"game_ended" );
    level endon( #"boss_fight_end" );
    trigger = getnoentvolumearray( "boss_ai_fling", #targetname )[ 0 ];
    
    if ( !isdefined( trigger ) )
    {
        assertmsg( "<dev string:xa2>" );
        return;
    }
    
    for ( ;; )
    {
        trigger waittill( #"trigger", entity );
        
        if ( !isscriptedai( entity ) )
        {
            continue;
        }
        
        if ( entity.aicategory == "boss" )
        {
            continue;
        }
        
        entity.do_immediate_ragdoll = 1;
        entity.forceragdollimmediate = 1;
        entity kill( entity.origin, entity, entity, "MOD_UNKNOWN" );
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xf9ff712c, Offset: 0xc7f7
// Size: 0xa
function private disable_bees()
{
    zombie_callisto::function_4b705a0e1a9137e8( 0 );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x7b1e6df2, Offset: 0xc809
// Size: 0x1b
function private function_149fcafa5137f98c()
{
    level endon( #"boss_fight_end" );
    level waittill( #"game_ended" );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x41526e0, Offset: 0xc82c
// Size: 0x3, Type: bool
function private function_d6839bf51ac5dc76()
{
    return false;
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x7fec739f, Offset: 0xc838
// Size: 0x12e
function private function_46b0a9670a97a0bf()
{
    level endon( #"start_game_ended" );
    level endon( #"game_ended" );
    level endon( #"hash_c7944c25ad06f095" );
    level.virgil_entity endon( #"death" );
    
    for ( ;; )
    {
        if ( level.virgil_entity utility::ent_flag( "flag_virgil_freeze_effects_active" ) )
        {
            foreach ( player in utility::get_alive_players( 0 ) )
            {
                frozen = player.var_e5557a1483620915;
                protected = player utility::callsharedfunc( #"locust_ww", #"hash_5f2e6769ea79096e" );
                
                if ( frozen && protected )
                {
                    zombie_boss_virgil::function_a09504af23da06b0( player );
                    continue;
                }
                
                if ( !frozen && !protected )
                {
                    zombie_boss_virgil::function_8c7b9b9da0fc6edf( player );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xd4707893, Offset: 0xc96e
// Size: 0xfd
function private function_2923e4e60f984da( params )
{
    damage = params.idamage;
    damage_weapons = [ "sat_zombie_virgil_runic_volley_attack", "sat_zombie_virgil_runic_volley_attack_fast", "sat_zombie_virgil_runic_volley_attack_fast_no_splash", "sat_zombie_virgil_runic_volley_attack_faster_no_splash", "sat_zombie_virgil_runic_volley_attack_faster", "sat_zombie_virgil_runic_volley_attack_fastest", "sat_zombie_virgil_runic_volley_attack_slow", "sat_zombie_virgil_runic_volley_attack_slowest" ];
    
    if ( !arraycontains( damage_weapons, params.objweapon.basename ) )
    {
        return damage;
    }
    
    current_time_ms = gettime();
    
    if ( self.var_101cbfec68e4b7e9 && current_time_ms < self.var_101cbfec68e4b7e9 )
    {
        return 0;
    }
    
    damage *= level.locust_boss.var_a5f4c354124e7fec;
    self.var_101cbfec68e4b7e9 = current_time_ms + level.locust_boss.var_158a2887e5e4c94f;
    return damage;
}

// Namespace zm_sat_locust_boss_fight
// Params 4
// Checksum 0xb3ad5176, Offset: 0xca74
// Size: 0x8f
function function_898c03a2778d5536( size, duration, source, radius )
{
    intensity = 0.3;
    
    switch ( size )
    {
        case #"hash_5971965ed985a26c":
            intensity = 0.3;
            break;
        case #"hash_c71b112fe04823d6":
            intensity = 0.5;
            break;
        case #"hash_4bf33d595d8f4894":
            intensity = 0.75;
            break;
    }
    
    earthquake( intensity, duration, source, radius );
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x41ecd326, Offset: 0xcb0b
// Size: 0x177
function private function_d17f8f05c7a7d96c()
{
    self notify( #"hash_1ce367a0cacc90e9" );
    self endon( #"hash_1ce367a0cacc90e9" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"locust_virgil_note", type, var_7c801ea48f8ea5d6, var_7c801da48f8ea3a3 );
        
        if ( type == "crystal_land" )
        {
            landing_position = level.locust_boss.center_fire_trap.origin ?? level.locust_boss.arena_center_struct.origin;
            playfx( utility::getfx( "virgil_crystal_land" ), landing_position );
            level thread function_898c03a2778d5536( "small", 0.5, landing_position, 10000 );
            var_4ec03c59fe015016 = getplayersinradius( landing_position, 150 );
            
            foreach ( player in var_4ec03c59fe015016 )
            {
                knockback_dir = vectornormalize2( player.origin - landing_position );
                player knockback( knockback_dir, 250, 1 );
            }
        }
    }
}

// Namespace zm_sat_locust_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x4bb8c1b8, Offset: 0xcc8a
// Size: 0x544
function private function_9b507e2b8cbc40a5()
{
    self notify( #"hash_97cb823078791cc3" );
    self endon( #"hash_97cb823078791cc3" );
    level endon( #"game_ended" );
    self endon( #"death" );
    level thread function_d17f8f05c7a7d96c();
    
    while ( true )
    {
        self waittill( #"locust_virgil_note", type, var_7c801ea48f8ea5d6, var_7c801da48f8ea3a3 );
        
        if ( type == "virgil_armor_break" )
        {
            var_53168c85a94431a = var_7c801ea48f8ea5d6;
            
            if ( var_53168c85a94431a )
            {
                if ( var_53168c85a94431a == "all" )
                {
                    level.virgil_entity zombie_boss_virgil::function_dab167edcd6162fa();
                }
                else
                {
                    level.virgil_entity thread zombie_boss_virgil::function_1c3066df3a64ff1b( var_53168c85a94431a );
                    
                    if ( level.virgil_entity.is_immune && !level.var_a0cc52751f52c09.dance_ended )
                    {
                        level.virgil_entity thread zombie_boss_virgil::disable_immunity();
                        waitframe();
                    }
                }
            }
            
            continue;
        }
        
        if ( type == "donut_punch" )
        {
            level.virgil_entity setscriptablepartstate( #"torso_center", #"exposed" );
            level.virgil_entity setscriptablepartstate( #"eyes", #"eyes_off" );
            continue;
        }
        
        if ( type == "begin_end_scene" )
        {
            utility::flag_set( "begin_end_scene" );
            continue;
        }
        
        if ( type == "earthquake" )
        {
            size = var_7c801ea48f8ea5d6;
            duration = float( var_7c801da48f8ea3a3 ?? 3 );
            
            if ( size == "small" || size == "medium" || size == "large" )
            {
                level thread function_898c03a2778d5536( size, duration, level.virgil_entity.origin, 10000 );
            }
            else
            {
                intensity = float( size );
                
                if ( isnumber( intensity ) )
                {
                    earthquake( intensity, duration, level.virgil_entity.origin, 10000 );
                }
            }
            
            continue;
        }
        
        if ( type == "spawn_weak_point" )
        {
            if ( level.locust_boss.var_abbebdb114e4f57f == 1 )
            {
                weak_point_names = [ var_7c801ea48f8ea5d6, var_7c801da48f8ea3a3 ];
                
                foreach ( weak_point_name in weak_point_names )
                {
                    if ( weak_point_name )
                    {
                        if ( zombie_boss_virgil::is_weak_point_active( weak_point_name ) )
                        {
                            zombie_boss_virgil::show_weak_point( zombie_boss_virgil::get_weak_point_struct( weak_point_name ) );
                        }
                        else
                        {
                            weak_points_spawned = 0;
                            
                            if ( isdefined( level.var_a0cc52751f52c09 ) )
                            {
                                var_392506c7e7c9de99 = zombie_boss_virgil_pops::function_d7a8b518a92e6441();
                                var_966e8ba852fa24f3 = zombie_boss_virgil_pops::function_f5bdb00e35d67dc5( var_392506c7e7c9de99.difficulty );
                                weak_points_spawned = var_392506c7e7c9de99.weak_points_spawned;
                                level.virgil_entity zombie_boss_virgil::function_3d52547cf27e2d36( var_966e8ba852fa24f3.weak_point_settings );
                            }
                            
                            if ( !weak_points_spawned )
                            {
                                level.virgil_entity zombie_boss_virgil::activate_weak_point( weak_point_name );
                            }
                            
                            if ( zombie_boss_virgil::is_weak_point_active( weak_point_name ) )
                            {
                                weak_point_struct = zombie_boss_virgil::get_weak_point_struct( weak_point_name );
                                zombie_boss_virgil::show_weak_point( weak_point_struct );
                            }
                        }
                        
                        if ( function_17846b5d2c783c6f() )
                        {
                            level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
                        }
                    }
                }
            }
            
            continue;
        }
        
        if ( type == "stop_adds" )
        {
            level thread function_b9f98165d48b9a1a();
            level thread function_42ff753e6d5bc179();
            continue;
        }
        
        if ( type == "flag" )
        {
            flag_name = var_7c801ea48f8ea5d6;
            
            if ( isstring( flag_name ) )
            {
                level.virgil_entity utility::ent_flag_set( flag_name );
            }
            
            continue;
        }
        
        if ( type == "play_dialogue" )
        {
            if ( var_7c801ea48f8ea5d6 == "roar" && var_7c801da48f8ea3a3 )
            {
                continue;
            }
            
            if ( var_7c801ea48f8ea5d6 == "virgil_knockdown" )
            {
                zombie_boss_virgil::function_9c386609d0280bef( #"virgil_knockdown_first" );
                continue;
            }
            
            if ( var_7c801ea48f8ea5d6 == "pops_knockdown" )
            {
                zombie_boss_virgil::function_9c386609d0280bef( #"pops_knockdown_first" );
                continue;
            }
            
            if ( var_7c801ea48f8ea5d6 == "virgil_return" )
            {
                zombie_boss_virgil::boss_play_dialogue( #"virgil_return" );
                continue;
            }
            
            if ( var_7c801ea48f8ea5d6 == "pops_return" )
            {
                if ( !isdefined( level.locust_boss.var_c9ad85824026f771 ) )
                {
                    level.locust_boss.pops_dialog_ent thread dialogue::say_self( "dx_zm_lobf_bfp1_typa_lbf1rbtrt1t" );
                    level.locust_boss.var_c9ad85824026f771 = 1;
                }
                
                continue;
            }
            
            if ( var_7c801ea48f8ea5d6 == "pops_saves_the_day" )
            {
                level.locust_boss.pops_dialog_ent thread dialogue::say_self( "dx_zm_lobf_bflo_typa_lbfrbret" );
                continue;
            }
            
            if ( var_7c801ea48f8ea5d6 == "virgil_defeats_pops" )
            {
                level.virgil_entity thread zombie_boss_virgil::function_d6cf55dbb78f41c8( #"virgil_defeats_pops", #"pops_defeated" );
                continue;
            }
            
            if ( var_7c801ea48f8ea5d6 == "pops_recovers" )
            {
                zombie_boss_virgil::function_9c386609d0280bef( #"pops_recovers" );
            }
        }
    }
}

/#

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x5c7b716a, Offset: 0xd1d6
    // Size: 0x93, Type: dev
    function private function_e3b6907971f2e140()
    {
        zm_utility::open_sesame();
        zone_manager::set_zone_enabled( "<dev string:xde>", 1 );
        
        foreach ( player in level.players )
        {
            player thread function_77bf79da6a2825ec();
        }
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x94e0035a, Offset: 0xd271
    // Size: 0xd, Type: dev
    function private function_f562897b468ea151()
    {
        level thread quick_start_boss_fight();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x34a8bbe4, Offset: 0xd286
    // Size: 0x36, Type: dev
    function private start_boss_fight_debug()
    {
        function_6695afd7224b1e8b();
        
        if ( level.locust_boss.is_active )
        {
            level thread start_boss_fight_phases();
            return;
        }
        
        level thread start_boss_fight( 0 );
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x40536ed6, Offset: 0xd2c4
    // Size: 0xc36, Type: dev
    function private scene_anim_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:xee>" );
        devgui::add_devgui_func( "<dev string:x106>", "<dev string:x110>", &function_5982d79d8898313e );
        devgui::add_devgui_func( "<dev string:x11a>", "<dev string:x126>", &function_6c9628d4825578c3 );
        devgui::add_devgui_func( "<dev string:x132>", "<dev string:x13c>", &function_8fee2cacf03c201b );
        devgui::add_devgui_func( "<dev string:x146>", "<dev string:x150>", &function_f00be56781036a8b );
        devgui::add_devgui_func( "<dev string:x15a>", "<dev string:x166>", &zombie_boss_virgil::virgil_hide );
        devgui::add_devgui_func( "<dev string:x172>", "<dev string:x18b>", &function_f239507a4e425c74 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1a4>", "<dev string:x1b2>" + "<dev string:x1ba>", &set_fog );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1c1>", "<dev string:x1b2>" + "<dev string:x1cf>", &set_fog );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1d6>", "<dev string:x1f0>" + "<dev string:x201>" + "<dev string:x20f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x21b>", "<dev string:x1f0>" + "<dev string:x233>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::add_devgui_func( "<dev string:x245>", "<dev string:x25f>", &debug_play_outro_igc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x274>", "<dev string:x1f0>" + "<dev string:x28c>" + "<dev string:x299>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x29d>", "<dev string:x1f0>" + "<dev string:x2b5>" + "<dev string:x299>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2c1>", "<dev string:x1f0>" + "<dev string:x2da>" + "<dev string:x299>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e7>", "<dev string:x1f0>" + "<dev string:x308>" + "<dev string:x20f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x323>", "<dev string:x1f0>" + "<dev string:x342>" + "<dev string:x299>" + "<dev string:x23f>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x359>", "<dev string:x1f0>" + "<dev string:x37a>" + "<dev string:x38e>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x39a>", "<dev string:x1f0>" + "<dev string:x3b9>" + "<dev string:x3cb>" + "<dev string:x23f>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3d5>", "<dev string:x1f0>" + "<dev string:x3f4>" + "<dev string:x299>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x408>", "<dev string:x1f0>" + "<dev string:x425>" + "<dev string:x299>" + "<dev string:x23f>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x437>", "<dev string:x1f0>" + "<dev string:x459>" + "<dev string:x46b>" + "<dev string:x23f>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x46f>", "<dev string:x1f0>" + "<dev string:x49a>" + "<dev string:x46b>" + "<dev string:x23f>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4b8>", "<dev string:x1f0>" + "<dev string:x4e2>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x501>", "<dev string:x1f0>" + "<dev string:x52a>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x544>", "<dev string:x1f0>" + "<dev string:x56e>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x589>", "<dev string:x1f0>" + "<dev string:x5aa>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5bb>", "<dev string:x1f0>" + "<dev string:x5de>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5f3>", "<dev string:x1f0>" + "<dev string:x616>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x62b>", "<dev string:x1f0>" + "<dev string:x656>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x66d>", "<dev string:x1f0>" + "<dev string:x698>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6b2>", "<dev string:x1f0>" + "<dev string:x6e1>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6f9>", "<dev string:x1f0>" + "<dev string:x729>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x741>", "<dev string:x1f0>" + "<dev string:x773>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x78e>", "<dev string:x1f0>" + "<dev string:x7c0>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7db>", "<dev string:x1f0>" + "<dev string:x80d>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x828>", "<dev string:x1f0>" + "<dev string:x85a>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x875>", "<dev string:x1f0>" + "<dev string:x8a1>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8b4>", "<dev string:x1f0>" + "<dev string:x8e0>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x901>", "<dev string:x1f0>" + "<dev string:x931>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x950>", "<dev string:x1f0>" + "<dev string:x981>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9a0>", "<dev string:x1f0>" + "<dev string:x9d3>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9f5>", "<dev string:x1f0>" + "<dev string:xa28>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa4a>", "<dev string:x1f0>" + "<dev string:xa7d>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa9f>", "<dev string:x1f0>" + "<dev string:xad2>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xaf4>", "<dev string:x1f0>" + "<dev string:xb12>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb21>", "<dev string:x1f0>" + "<dev string:xb3f>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb4e>", "<dev string:x1f0>" + "<dev string:xb6c>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb7b>", "<dev string:x1f0>" + "<dev string:xb99>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xba8>", "<dev string:x1f0>" + "<dev string:xbc6>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xbd5>", "<dev string:x1f0>" + "<dev string:xbf4>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc0a>", "<dev string:x1f0>" + "<dev string:xc29>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc3f>", "<dev string:x1f0>" + "<dev string:xc5e>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc74>", "<dev string:x1f0>" + "<dev string:xc93>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xca9>", "<dev string:x1f0>" + "<dev string:xcc8>" + "<dev string:x46b>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xcde>", "<dev string:x1f0>" + "<dev string:xd08>" + "<dev string:x46b>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd1b>", "<dev string:x1f0>" + "<dev string:xd4a>" + "<dev string:x46b>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd67>", "<dev string:x1f0>" + "<dev string:xd8e>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd9f>", "<dev string:x1f0>" + "<dev string:xdc8>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xdd8>", "<dev string:x1f0>" + "<dev string:x8a1>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe06>", "<dev string:x1f0>" + "<dev string:xe39>" + "<dev string:x4fd>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe54>", "<dev string:x1f0>" + "<dev string:xe71>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe88>", "<dev string:x1f0>" + "<dev string:xea5>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xebc>", "<dev string:x1f0>" + "<dev string:xedd>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xeea>", "<dev string:x1f0>" + "<dev string:xf0a>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf1c>", "<dev string:x1f0>" + "<dev string:xf45>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf60>", "<dev string:x1f0>" + "<dev string:xf87>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfa0>", "<dev string:x1f0>" + "<dev string:xfc1>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfce>", "<dev string:x1f0>" + "<dev string:xfee>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1000>", "<dev string:x1f0>" + "<dev string:x1029>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1044>", "<dev string:x1f0>" + "<dev string:x106b>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1084>", "<dev string:x1f0>" + "<dev string:x10a5>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x10b2>", "<dev string:x1f0>" + "<dev string:x10d2>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x10e4>", "<dev string:x1f0>" + "<dev string:x110d>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1128>", "<dev string:x1f0>" + "<dev string:x114f>" + "<dev string:x20f>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1168>", "<dev string:x1f0>" + "<dev string:x1186>" + "<dev string:x46b>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x11a0>", "<dev string:x1f0>" + "<dev string:x11be>" + "<dev string:x46b>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x11da>", "<dev string:x1f0>" + "<dev string:x11f8>" + "<dev string:x46b>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1212>", "<dev string:x1f0>" + "<dev string:x1230>" + "<dev string:x46b>" + "<dev string:x23f>" + "<dev string:x213>", &debug_play_scene );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x96c8ef56, Offset: 0xdf02
    // Size: 0x15, Type: dev
    function private function_f239507a4e425c74()
    {
        level.virgil_entity thread function_9b507e2b8cbc40a5();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 1, eflags: 0x4
    // Checksum 0x6703f883, Offset: 0xdf1f
    // Size: 0x36, Type: dev
    function private set_fog( params )
    {
        if ( params[ 0 ] == "<dev string:x124c>" )
        {
            function_ad915db840c90fb3( 1023, 4, 3 );
            return;
        }
        
        function_ad915db840c90fb3( 1023, 1, 3 );
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x33c42736, Offset: 0xdf5d
    // Size: 0x18, Type: dev
    function private debug_play_outro_igc()
    {
        prestream_igc( 3 );
        wait 3;
        function_785dee38bd826ae2();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x1708da32, Offset: 0xdf7d
    // Size: 0x3c, Type: dev
    function private function_5982d79d8898313e()
    {
        if ( !isdefined( level.locust_boss.pops_entity ) )
        {
            spawn_pops();
        }
        
        level.locust_boss.pops_entity show();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xcdf92a92, Offset: 0xdfc1
    // Size: 0x1d, Type: dev
    function private function_8fee2cacf03c201b()
    {
        level.locust_boss.pops_entity hide();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xc9418c96, Offset: 0xdfe6
    // Size: 0x43, Type: dev
    function private function_f00be56781036a8b()
    {
        level.locust_boss.pops_entity val::set( "<dev string:x1252>", "<dev string:x63>", 1 );
        level.locust_boss.pops_entity kill();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xe966160a, Offset: 0xe031
    // Size: 0x21, Type: dev
    function private function_6c9628d4825578c3()
    {
        if ( !isdefined( level.virgil_entity ) )
        {
            spawn_virgil();
        }
        
        zombie_boss_virgil::virgil_show();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 1, eflags: 0x4
    // Checksum 0x9eadc500, Offset: 0xe05a
    // Size: 0x1c1, Type: dev
    function private debug_play_scene( params )
    {
        scene_name = params[ 0 ];
        scene_bundle_ref = params[ 1 ];
        relevant_ents = [];
        bundle = undefined;
        
        switch ( scene_bundle_ref )
        {
            case #"hash_f98495f6bce2af9a":
                bundle = level.locust_boss.var_c67f4438ea8c963e;
                break;
            case #"hash_f98494f6bce2ae07":
                bundle = level.locust_boss.var_c67f4338ea8c940b;
                break;
            case #"hash_f98493f6bce2ac74":
                bundle = level.locust_boss.var_c67f4238ea8c91d8;
                break;
            case #"hash_f98492f6bce2aae1":
                bundle = level.locust_boss.var_c67f4938ea8ca13d;
                break;
            case #"hash_cea8747d1bf0b5e8":
                bundle = level.locust_boss.var_b77c50fc08ede4e4;
                break;
            case #"hash_8721eba9648f5a08":
                bundle = level.locust_boss.var_93f1a41633f6bf5f;
                break;
            case #"hash_310c0e96f66db3f":
                bundle = level.locust_boss.var_8cb04e1b207cb0fc;
                break;
            default:
                bundle = undefined;
                break;
        }
        
        for ( i = 2; i < params.size ; i++ )
        {
            if ( isdefined( params[ i ] ) )
            {
                ent = params[ i ] == "<dev string:x5c>" ? level.virgil_entity : level.locust_boss.pops_entity;
                relevant_ents[ relevant_ents.size ] = ent;
            }
        }
        
        bundle thread scene::play( relevant_ents, scene_name );
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xd95cfc00, Offset: 0xe223
    // Size: 0x391, Type: dev
    function private boss_fight_debug()
    {
        level thread scene_anim_debug();
        devgui::function_9082edeb5db93280( "<dev string:x127d>" );
        devgui::add_devgui_func( "<dev string:x128e>", "<dev string:x12a9>", &spawn_pops );
        devgui::add_devgui_func( "<dev string:x12b4>", "<dev string:x12d9>", &spawn_virgil );
        devgui::add_devgui_func( "<dev string:x12e6>", "<dev string:x12f7>", &start_boss_fight_debug );
        devgui::add_devgui_func( "<dev string:x130e>", "<dev string:x1321>", &function_e3b6907971f2e140 );
        devgui::add_devgui_func( "<dev string:x133a>", "<dev string:x1357>", &function_f562897b468ea151 );
        devgui::add_devgui_func( "<dev string:x137a>", "<dev string:x1390>", &function_7075393f6ff798a );
        devgui::add_devgui_func( "<dev string:x13a6>", "<dev string:x13bc>", &function_7075493f6ff7bbd );
        devgui::add_devgui_func( "<dev string:x13d2>", "<dev string:x13ff>", &function_89002f351e696678 );
        devgui::add_devgui_func( "<dev string:x1417>", "<dev string:x143d>", &open_arena_center );
        devgui::add_devgui_func( "<dev string:x144f>", "<dev string:x145e>", &end_boss_fight );
        devgui::add_devgui_func( "<dev string:x146d>", "<dev string:x148b>", &function_7e21c5fcd8bbabbf );
        devgui::add_devgui_func( "<dev string:x149d>", "<dev string:x14c0>", &function_5e546dac05e3b4d2 );
        devgui::add_devgui_func( "<dev string:x14d7>", "<dev string:x14fa>", &function_a49daed8287a44af );
        devgui::add_devgui_func( "<dev string:x1511>", "<dev string:x1534>", &function_1e8e6a42de4a442a );
        devgui::add_devgui_func( "<dev string:x154b>", "<dev string:x155e>", &function_5f0a50b61f3da74c );
        devgui::add_devgui_func( "<dev string:x1583>", "<dev string:x159d>", &function_46773b1267aed263 );
        devgui::add_devgui_func( "<dev string:x15af>", "<dev string:x15bf>", &show_fire_traps );
        devgui::add_devgui_func( "<dev string:x15cf>", "<dev string:x15df>", &hide_fire_traps );
        devgui::add_devgui_func( "<dev string:x15ef>", "<dev string:x1610>", &function_6478eae486cfa1e7 );
        devgui::add_devgui_func( "<dev string:x1629>", "<dev string:x164f>", &function_2cadeb30a751b0db );
        devgui::add_devgui_func( "<dev string:x1676>", "<dev string:x169e>", &function_2be022d554d2a1e5 );
        devgui::add_devgui_func( "<dev string:x16ba>", "<dev string:x16ee>", &function_c3ecef7c45e9a96 );
        devgui::add_devgui_func( "<dev string:x1710>", "<dev string:x1747>", &function_54863714555eae99 );
        devgui::add_devgui_func( "<dev string:x176e>", "<dev string:x177d>", &function_15957ac4d94dbb48 );
        devgui::add_devgui_func( "<dev string:x1795>", "<dev string:x17a6>", &debug_enter_dps_state );
        devgui::add_devgui_func( "<dev string:x17bc>", "<dev string:x17df>", &function_a47268fea8233c40 );
        devgui::add_devgui_func( "<dev string:x1808>", "<dev string:x1828>", &function_b5cdd6b9dcc349ff );
        devgui::add_devgui_func( "<dev string:x184e>", "<dev string:x1876>", &function_f4250612876c168b );
        devgui::function_cd4e263c1f3018ae( "<dev string:x189d>", "<dev string:x18ce>" + "<dev string:x18f4>", &function_3ecc9137be4cc1d2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x18fa>", "<dev string:x18ce>" + "<dev string:x192d>", &function_3ecc9137be4cc1d2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1935>", "<dev string:x18ce>" + "<dev string:x1966>", &function_3ecc9137be4cc1d2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x196c>", "<dev string:x1991>" + "<dev string:x18f4>", &function_3187dd773779b40c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x19ac>", "<dev string:x1991>" + "<dev string:x192d>", &function_3187dd773779b40c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x19d3>", "<dev string:x1991>" + "<dev string:x1966>", &function_3187dd773779b40c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x19f8>", "<dev string:x1a2b>" + "<dev string:x1a4c>", &function_94af48ff135c3f36 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1a59>", "<dev string:x1a2b>" + "<dev string:x1a83>", &function_94af48ff135c3f36 );
        devgui::function_77df7fe7dd273e10();
        level thread function_704426edfb2ca8d1();
        
        if ( getdvarint( @"hash_c84beccf3d4a5bac", 0 ) )
        {
            level thread function_8d8babcb9844eb35();
        }
        
        level thread update_dvars_loop();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 1, eflags: 0x4
    // Checksum 0xaec57d63, Offset: 0xe5bc
    // Size: 0xb7, Type: dev
    function private function_94af48ff135c3f36( params )
    {
        override_type = params[ 0 ];
        
        switch ( override_type )
        {
            case #"hash_681e20c508bbff98":
                level thread namespace_fd7b16d2452999a9::function_9b44b0b758f8469a( level.locust_boss.var_fd7b343d1dba2d37, level.locust_boss.var_28b04aa4e0e753a2, level.locust_boss.var_5c55d7663a23fce9 );
                break;
            case #"hash_fa4e13f6bd8146b4":
                level thread namespace_fd7b16d2452999a9::function_9b44b0b758f8469a( level.locust_boss.var_9a37a2dba34b9c29, level.locust_boss.var_74e5084f6f0f1dcc, 1 );
                break;
        }
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x3c584594, Offset: 0xe67b
    // Size: 0x13, Type: dev
    function private function_5e546dac05e3b4d2()
    {
        function_b9f98165d48b9a1a();
        function_42ff753e6d5bc179();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xe0d677f2, Offset: 0xe696
    // Size: 0x23, Type: dev
    function private function_89002f351e696678()
    {
        level.locust_boss.var_abbebdb114e4f57f = 3;
        level thread force_players_to_center();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xd27a5842, Offset: 0xe6c1
    // Size: 0x31, Type: dev
    function private function_a47268fea8233c40()
    {
        level.virgil_entity thread zombie_boss_virgil::function_3719639b6a7c555c( [ "<dev string:x1a96>", "<dev string:x1aab>", "<dev string:x1ac1>" ] );
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x1ec08747, Offset: 0xe6fa
    // Size: 0x15, Type: dev
    function private function_6ebe6245a417d3ae()
    {
        level.virgil_entity thread zombie_boss_virgil::function_ed45e41507b1667d();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x6411f297, Offset: 0xe717
    // Size: 0xd, Type: dev
    function private function_2cadeb30a751b0db()
    {
        level thread function_7b3a45c4fdbfc566();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x6246ec0d, Offset: 0xe72c
    // Size: 0x39, Type: dev
    function private function_c3ecef7c45e9a96()
    {
        level.locust_boss.karkinos_wave thread function_34a8c89ccb015bd7();
        level.locust_boss.var_5548ed08f027ff84 thread function_34a8c89ccb015bd7();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x7fe019a8, Offset: 0xe76d
    // Size: 0x1f, Type: dev
    function private function_54863714555eae99()
    {
        level.locust_boss.var_5ed02bdc19feccb7 thread function_34a8c89ccb015bd7();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 1, eflags: 0x4
    // Checksum 0x99448436, Offset: 0xe794
    // Size: 0xb8, Type: dev
    function private function_3187dd773779b40c( params )
    {
        undecided_difficulty = params[ 0 ];
        var_93874a4bdaff8e91 = undefined;
        
        switch ( undecided_difficulty )
        {
            case #"hash_22ce4003c1e5227b":
                var_93874a4bdaff8e91 = level.locust_boss.var_2587cda957b2249a;
                break;
            case #"hash_c71b112fe04823d6":
                var_93874a4bdaff8e91 = level.locust_boss.var_d8e6192766a7f281;
                break;
            case #"hash_cc9157548a55043c":
                var_93874a4bdaff8e91 = level.locust_boss.var_e0a617f2185b96cf;
                break;
        }
        
        level thread function_7b3a45c4fdbfc566();
        level thread function_55bd1e39bc8ec36a();
        var_93874a4bdaff8e91 thread function_313accf65ecc31c1();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 1, eflags: 0x4
    // Checksum 0xc53765b2, Offset: 0xe854
    // Size: 0xa8, Type: dev
    function private function_3ecc9137be4cc1d2( params )
    {
        undecided_difficulty = params[ 0 ];
        weak_point_settings = undefined;
        
        switch ( undecided_difficulty )
        {
            case #"hash_22ce4003c1e5227b":
                weak_point_settings = level.locust_boss.var_798c76b6802b4b16;
                break;
            case #"hash_c71b112fe04823d6":
                weak_point_settings = level.locust_boss.var_413400bce8a8580d;
                break;
            case #"hash_cc9157548a55043c":
                weak_point_settings = level.locust_boss.var_b255a818a9203db3;
                break;
        }
        
        zombie_boss_virgil::function_3d52547cf27e2d36( weak_point_settings );
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x78e0487a, Offset: 0xe904
    // Size: 0x3c, Type: dev
    function private function_f4250612876c168b()
    {
        var_98b86e04db7c2515 = { #weak_point_damage_multiplier:1, #weak_point_health_frac:1, #var_35e16c5719638f4c:5 };
        zombie_boss_virgil::function_3d52547cf27e2d36( var_98b86e04db7c2515 );
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xb1ef564c, Offset: 0xe948
    // Size: 0xc, Type: dev
    function private function_b5cdd6b9dcc349ff()
    {
        zombie_boss_virgil::function_7962cd4502850b79();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xef291c45, Offset: 0xe95c
    // Size: 0x5c, Type: dev
    function private debug_enter_dps_state()
    {
        level thread zombie_boss_virgil_totem_attack::kill_all_totems();
        level.virgil_entity utility::ent_flag_clear( "<dev string:x1ae7>" );
        level.virgil_entity utility::ent_flag_clear( "<dev string:x45>" );
        level.virgil_entity utility::ent_flag_clear( "<dev string:x1b07>" );
        level.virgil_entity thread enter_dps_state();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xf258aa9e, Offset: 0xe9c0
    // Size: 0x3f, Type: dev
    function private function_15957ac4d94dbb48()
    {
        level.virgil_entity utility::ent_flag_clear( "<dev string:x45>" );
        level.virgil_entity utility::ent_flag_clear( "<dev string:x1b07>" );
        level.virgil_entity thread function_358d5c2dc3a83ee8();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xc6d27fdd, Offset: 0xea07
    // Size: 0x6d, Type: dev
    function private function_2be022d554d2a1e5()
    {
        level callback::add( #"hash_293bd578dad314b7", &function_c2890d39733d97c0 );
        level callback::add( #"hash_d734f5978951ec2a", &on_totem_destroyed );
        level thread function_55bd1e39bc8ec36a();
        level.locust_boss.var_3b88fc59d8c7825f thread function_313accf65ecc31c1();
        level.locust_boss.var_676d9b41331ea36f thread function_34a8c89ccb015bd7();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x5c72923c, Offset: 0xea7c
    // Size: 0x1a, Type: dev
    function private function_6478eae486cfa1e7()
    {
        level thread zm_sat_locust_caltheris_blessing::function_6478eae486cfa1e7( level.players[ 0 ], 1 );
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x2c56599, Offset: 0xea9e
    // Size: 0x51, Type: dev
    function private function_7e21c5fcd8bbabbf()
    {
        if ( level.virgil_entity utility::ent_flag( "<dev string:x1b1a>" ) )
        {
            level.virgil_entity utility::ent_flag_clear( "<dev string:x1b1a>" );
        }
        else
        {
            level.virgil_entity utility::ent_flag_set( "<dev string:x1b1a>" );
        }
        
        level thread kill_all_adds();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0xc
    // Checksum 0xe7e3fb88, Offset: 0xeaf7
    // Size: 0x18b, Type: dev
    function private function_a49daed8287a44af()
    {
        self notify( #"hash_35d0f66252aa1b4e" );
        self endon( #"hash_35d0f66252aa1b4e" );
        level endon( #"hash_5f66e48be749bed5" );
        
        while ( true )
        {
            foreach ( subclass in [ "<dev string:x1b3e>", "<dev string:x1b4a>", "<dev string:x1b64>", "<dev string:x1b75>", "<dev string:x1b85>", "<dev string:x1b95>" ] )
            {
                var_395649a1ecde9e39 = level.locust_boss.var_1c20af01180087e0[ subclass ] ?? zone_spawner::function_20c574a6ba7cc5c6( [ "<dev string:xde>" ], subclass );
                
                foreach ( spawn_loc in var_395649a1ecde9e39 )
                {
                    sphere( spawn_loc.origin, 25, ( 0, 0, 1 ) );
                }
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x872d84fc, Offset: 0xec8a
    // Size: 0x11, Type: dev
    function private function_1e8e6a42de4a442a()
    {
        level notify( #"hash_5f66e48be749bed5" );
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x9e6d6121, Offset: 0xeca3
    // Size: 0x79, Type: dev
    function private end_boss_fight()
    {
        if ( level.virgil_entity && isalive( level.virgil_entity ) )
        {
            level.virgil_entity kill();
        }
        
        if ( level.locust_boss.pops_entity && isalive( level.locust_boss.pops_entity ) )
        {
            level.locust_boss.pops_entity kill();
        }
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x3777b331, Offset: 0xed24
    // Size: 0x271, Type: dev
    function private function_8d8babcb9844eb35()
    {
        while ( level.players.size == 0 || !isalive( level.players[ 0 ] ) )
        {
            waitframe();
        }
        
        utility::flag_wait( "<dev string:x1ba9>" );
        zm_utility::open_sesame();
        var_7192378ce0f51e6b = [ #"locust_quest_pap", #"hash_709d77ab2b2005c5", #"hash_d1612ed5d50da819", #"hash_7b26a8bb39d7312", #"hash_9a9f22ecb2a5ad11" ];
        
        foreach ( quest in var_7192378ce0f51e6b )
        {
            if ( !zm_quest::is_quest_complete( quest ) )
            {
                zm_quest = zm_quest::get_quest( quest );
                
                foreach ( step in zm_quest.steps )
                {
                    zm_quest::function_e65609834444650c( step );
                }
            }
        }
        
        zm_quest = zm_quest::get_quest( #"locust_mq" );
        zm_quest::function_e65609834444650c( zm_quest.steps[ 0 ] );
        wait 15;
        level notify( #"restart_round" );
        var_c0b9c14692cbf343 = getdvarint( @"hash_2b30bbfc17e3f922", 0 );
        
        if ( var_c0b9c14692cbf343 > 0 )
        {
            var_a01e28b7bdaa1f6d = maxint( function_b80976b7930587b4(), var_c0b9c14692cbf343 );
            
            if ( zm_utility::get_round_number() < var_a01e28b7bdaa1f6d )
            {
                zm_round_logic::function_68bdb49c82c0f892( var_a01e28b7bdaa1f6d );
                zm_round_logic::function_895fdc21ab019efe();
            }
            
            zm_utility::function_1bd2eda42461fad1( level.var_6781718da4f78d1c.roundnumber );
            
            while ( zm_utility::get_round_number() != var_a01e28b7bdaa1f6d )
            {
                waitframe();
            }
        }
        
        level thread function_f562897b468ea151();
        level.players[ 0 ] waittill( #"touchdown_ejection" );
        
        if ( getdvarint( @"hash_655bd436d955c823", 0 ) )
        {
            function_5f0a50b61f3da74c();
        }
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x61a2132d, Offset: 0xef9d
    // Size: 0x1a, Type: dev
    function private function_46773b1267aed263()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x1bc7>", @"hash_ec565fb5cfd84b8c" );
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x13f4ddeb, Offset: 0xefbf
    // Size: 0x7e, Type: dev
    function private function_5f0a50b61f3da74c()
    {
        foreach ( player in level.players )
        {
            player thread zm_sat_locust_util::function_a59b225ef3240980();
        }
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0xc
    // Checksum 0xf878010e, Offset: 0xf045
    // Size: 0x37, Type: dev
    function private update_dvars_loop()
    {
        self notify( #"hash_92725b28a6c300b3" );
        self endon( #"hash_92725b28a6c300b3" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            wait 0.5;
        }
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x6af6ac6b, Offset: 0xf084
    // Size: 0xbd, Type: dev
    function private function_704426edfb2ca8d1()
    {
        dialogues = [ "<dev string:x1bec>", "<dev string:x1c0b>", "<dev string:x1c2c>" ];
        devgui::function_9082edeb5db93280( "<dev string:x1c4a>" );
        
        foreach ( dialogue in dialogues )
        {
            devgui::function_cd4e263c1f3018ae( dialogue, "<dev string:x1c6c>" + dialogue, &function_9d237cd2f8b869dc );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_boss_fight
    // Params 1, eflags: 0x4
    // Checksum 0xa8b0e06e, Offset: 0xf149
    // Size: 0x2c, Type: dev
    function private function_9d237cd2f8b869dc( params )
    {
        level.locust_boss.pops_entity thread dialogue::say_self( params[ 0 ] );
    }

#/
