// script_4708e9fa04f2c426  (hash_4708e9fa04f2c426.gscc) (size: 17926 Bytes / 0x4606 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9c43ca79 (2621688441)
// size ...... 17926 (0x4606)
// includes .. 15  (offset: 0x4112)
// strings ... 84  (offset: 0x418a)
// dev strs .. 2   (offset: 0x45e6)
// exports ... 32  (offset: 0x308e)
// cseg ...... 0x814 + 0x287a (0x308e)
// imports ... 91  (offset: 0x358e)
// animtree1 . 0   (offset: 0x4606)
// animtree2 . 0   (offset: 0x4606)
#using script_2d59c90cd0791757;
#using script_4714f11e284c32a4;
#using script_53600bb9c82cbdf2;
#using script_53651341190c5aab;
#using script_7f22b5c78b8ccf70;
#using scripts\common\callbacks;
#using scripts\common\logging\playtest_logger;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_boss_fight;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_glocke_drop;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_wunderbarrage;

#namespace zombie_boss_virgil_pops;

// Namespace zombie_boss_virgil_pops
// Params 2
// Checksum 0x6bcdf16e, Offset: 0x832
// Size: 0x575
function init_dance( pops_ent, virgil_ent )
{
    setuppops( pops_ent );
    setupvirgil( virgil_ent );
    
    if ( !isdefined( level.var_a0cc52751f52c09 ) )
    {
        level.var_a0cc52751f52c09 = { #var_f63db919eb5b3d5f:getdvarfloat( @"hash_6e23ec3dd94d8689", 0.035 ), #var_27e56042b97e2045:getdvarfloat( @"hash_67e42d9ef7b0ce6f", 1 ), #var_17f68dedd5f6849:getdvarfloat( @"hash_aa1a6de0bcb73733", 8 ), #var_686c660ab19d3cfc:getdvarfloat( @"hash_89ca81c73e212cb2", 2 ), #var_4980c76ede752579:getdvarfloat( @"hash_d27411a920da493", 24 ), #var_35f54bd7442b479a:getdvarfloat( @"hash_2eee1691204142d8", 18 ), #var_ec59d14a39abdc30:[ "taunt_bttl_01", "taunt_bttl_02", "taunt_bttl_05" ], #logger_config:undefined, #pops_ent:pops_ent, #virgil_ent:virgil_ent, #var_93ef15bc50a0d1f7:-1, #var_c0fd8fb2667da7e6:[], #battle_scene_structs:[], #var_93f1a41633f6bf5f:utility::getstruct( "bossSceneScriptStructIdleVirgil", "targetname" ), #var_8cb04e1b207cb0fc:utility::getstruct( "bossSceneScriptStructIdlePops", "targetname" ), #var_c67f4938ea8ca13d:utility::getstruct( "bossSceneScriptStruct04", "targetname" ), #var_c67f4238ea8c91d8:utility::getstruct( "bossSceneScriptStruct03", "targetname" ), #var_c67f4338ea8c940b:utility::getstruct( "bossSceneScriptStruct02", "targetname" ), #var_c67f4438ea8c963e:utility::getstruct( "bossSceneScriptStruct01", "targetname" ), #var_d36311e820ed0fab:gettime() * 0.001, #dance_ended:0, #dance_begun:1 };
    }
    
    function_25a3444b3ef0c28b( level.var_a0cc52751f52c09.var_c67f4338ea8c940b, 0, "perf_bttl_01_pops_victor", "pops", 0 );
    function_25a3444b3ef0c28b( level.var_a0cc52751f52c09.var_c67f4338ea8c940b, 0, "perf_bttl_03_pops_victor", "pops", 0 );
    function_25a3444b3ef0c28b( level.var_a0cc52751f52c09.var_c67f4338ea8c940b, 0, "perf_bttl_02_virgil_victor", "virgil", 0 );
    function_25a3444b3ef0c28b( level.var_a0cc52751f52c09.var_c67f4338ea8c940b, 0, "perf_bttl_04_virgil_victor", "virgil", 0 );
    var_d34feedd850e9b1c = function_5e6a29f099ed9b26( level.var_a0cc52751f52c09.var_c67f4438ea8c963e, "interact_01", 1, "interact_01_loop", "interact_01_pops_victor", "interact_01_virgil_victor", [ "arm_right" ] );
    var_d34ff0dd850e9f82 = function_5e6a29f099ed9b26( level.var_a0cc52751f52c09.var_c67f4438ea8c963e, "interact_03", 1, "interact_03_loop", "interact_03_pops_victor", "interact_03_virgil_victor", [ "torso_upper", "torso_lower" ] );
    var_d34ff1dd850ea1b5 = function_5e6a29f099ed9b26( level.var_a0cc52751f52c09.var_c67f4438ea8c963e, "interact_02", 1, "interact_02_loop", "interact_02_pops_victor", "interact_02_virgil_victor", [ "arm_left" ] );
    level.var_a0cc52751f52c09.undecided_battles = [ 2:{ #weak_points_spawned:0, #pops_action_func:&function_78f494e5b9c67fef, #armor_break_location:"torso_lower", #weak_point_locations:[ "weakspot_forearm_left" ], #difficulty:level.locust_boss.var_7d32689281abf25b[ 2 ], #battle_scene_struct:var_d34ff1dd850ea1b5 }, { #weak_points_spawned:0, #pops_action_func:&pops_assist_glocke, #armor_break_location:"arm_left", #weak_point_locations:[ "weakspot_chest_right" ], #difficulty:level.locust_boss.var_7d32689281abf25b[ 1 ], #battle_scene_struct:var_d34ff0dd850e9f82 }, 0:{ #weak_points_spawned:0, #pops_action_func:&function_78f494e5b9c67fef, #armor_break_location:"torso_upper", #weak_point_locations:[ "weakspot_forearm_right" ], #difficulty:level.locust_boss.var_7d32689281abf25b[ 0 ], #battle_scene_struct:var_d34feedd850e9b1c } ];
    level.var_a0cc52751f52c09.current_undecided_battle = 0;
    level.var_a0cc52751f52c09.var_96fe9d5b0c01dbf9 = [ { #var_6559194b462cd918:1, #difficulty:2, #winner:"battle_winner_undecided" } ];
    level callback::add( #"hash_70700a7ae0ffa528", &function_b2ea7e1d5a0ca3dd );
    level.var_a0cc52751f52c09.logger_config = playtest_logger::function_81cc4ca859a01d68( @"hash_722cbf5baac39d73", @"hash_287c84da4025f127", @"hash_f78c7cbe92653dd2", @"hash_d5c1185258c76b78", @"hash_c2ced4678d5f8c2", @"hash_1452bef182bc7986", @"hash_6b103db9aed6450c", "LOCUST BOSS " );
    level thread state_intro();
}

// Namespace zombie_boss_virgil_pops
// Params 1, eflags: 0x4
// Checksum 0x79c51956, Offset: 0xdaf
// Size: 0x42
function private setuppops( pops_ent )
{
    pops_ent.var_fe98e9c78a510185 = [];
    pops_ent.var_a82ddf40b72f9a8 = 0;
    pops_ent.var_935b9b4eeda6cb2f = 1;
    pops_ent.var_3a1f1b9e777fd3c7 = 1;
}

// Namespace zombie_boss_virgil_pops
// Params 1, eflags: 0x4
// Checksum 0x9e3712d5, Offset: 0xdf9
// Size: 0x26
function private setupvirgil( virgil_ent )
{
    virgil_ent.var_fe98e9c78a510185 = [];
    virgil_ent.var_a82ddf40b72f9a8 = 0;
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0x1155b7ab, Offset: 0xe27
// Size: 0x4f
function request_dance_end()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    self endon( #"death" );
    level.var_a0cc52751f52c09.dance_ended = 1;
    level waittill( #"hash_4174149dd0216da" );
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0xd592ea80, Offset: 0xe7e
// Size: 0xf0
function state_intro()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.virgil_ent endon( #"death" );
    level.var_a0cc52751f52c09.pops_ent endon( #"death" );
    level thread battle_log( "STATE ENTER: INTRO" );
    
    if ( !getdvarint( @"hash_268e00e0a415c089", 0 ) )
    {
        level.var_a0cc52751f52c09.var_c67f4438ea8c963e scene::play( [ level.var_a0cc52751f52c09.virgil_ent, level.var_a0cc52751f52c09.pops_ent ], "pops_intro" );
    }
    
    level.var_a0cc52751f52c09.virgil_ent utility::ent_flag_set( "flag_virgil_intro_complete" );
    level thread state_prepare();
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0x9692414c, Offset: 0xf76
// Size: 0xa6
function state_prepare()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.virgil_ent endon( #"death" );
    level.var_a0cc52751f52c09.pops_ent endon( #"death" );
    level thread battle_log( "STATE ENTER: PREPARE" );
    
    if ( level.var_a0cc52751f52c09.dance_ended )
    {
        level thread state_phase_transition();
        return;
    }
    
    level.var_a0cc52751f52c09.var_93ef15bc50a0d1f7++;
    level thread state_idle();
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0xdefc833a, Offset: 0x1024
// Size: 0xd4
function state_idle()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.virgil_ent endon( #"death" );
    level.var_a0cc52751f52c09.pops_ent endon( #"death" );
    level thread battle_log( "STATE ENTER: IDLE" );
    battle_script = get_battle_script( level.var_a0cc52751f52c09.var_93ef15bc50a0d1f7 );
    
    if ( !battle_script.var_6559194b462cd918 )
    {
        level thread zm_sat_locust_boss_fight::function_b9f98165d48b9a1a();
        level thread zm_sat_locust_boss_fight::function_42ff753e6d5bc179();
    }
    
    if ( battle_script.winner == "battle_winner_undecided" )
    {
        level thread state_undecided_battle();
        return;
    }
    
    level thread state_battle();
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0xb509a225, Offset: 0x1100
// Size: 0x8bc
function state_undecided_battle()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.virgil_ent endon( #"death" );
    level.var_a0cc52751f52c09.pops_ent endon( #"death" );
    level thread battle_log( "STATE ENTER: SCRIPTED BATTLE" );
    level namespace_589ae4efe3ba85ad::function_950d4585ce2b2a46();
    battle_script = get_battle_script( level.var_a0cc52751f52c09.var_93ef15bc50a0d1f7 );
    var_392506c7e7c9de99 = function_d7a8b518a92e6441();
    var_7ddaace0862cb868 = var_392506c7e7c9de99.battle_scene_struct;
    level thread battle_log( "Undecided Battle Scene Selected: " + var_7ddaace0862cb868.name );
    var_966e8ba852fa24f3 = function_f5bdb00e35d67dc5( var_392506c7e7c9de99.difficulty );
    var_966e8ba852fa24f3.var_93874a4bdaff8e91 thread zm_sat_locust_boss_fight::function_313accf65ecc31c1();
    
    if ( !level.var_a0cc52751f52c09.dance_ended )
    {
        level thread namespace_dba99780c141b678::function_20489ced0b98219b();
        
        foreach ( ice_wall_clump in var_966e8ba852fa24f3.ice_clumps )
        {
            zombie_boss_virgil::function_9c386609d0280bef( #"hash_d86403afb0b514e5" );
            level thread namespace_dba99780c141b678::function_efe887b9ff2ba515( ice_wall_clump, level.locust_boss.var_65d716cde74ff23f );
        }
        
        level.var_a0cc52751f52c09.virgil_ent zombie_boss_virgil::function_3d52547cf27e2d36( var_966e8ba852fa24f3.weak_point_settings );
    }
    
    var_7ddaace0862cb868.bundle scene::play( [ level.var_a0cc52751f52c09.virgil_ent, level.var_a0cc52751f52c09.pops_ent ], var_7ddaace0862cb868.shot );
    
    if ( !level.var_a0cc52751f52c09.dance_ended )
    {
        foreach ( weak_point_struct in level.var_a0cc52751f52c09.virgil_ent.active_weak_points )
        {
            level thread battle_log( "Starting Weak Point Health: " + weak_point_struct.health - weak_point_struct.damage_taken );
        }
        
        level.var_a0cc52751f52c09.virgil_ent zombie_boss_virgil::function_7b87ea5cec2388a6();
        var_7ddaace0862cb868.bundle thread scene::play( [ level.var_a0cc52751f52c09.virgil_ent, level.var_a0cc52751f52c09.pops_ent ], var_7ddaace0862cb868.loop );
        player_count = level.players.size;
        squad_size_frac = math::lerp_fraction( 1, 4, player_count );
        undecided_battle_time_sec = int( math::lerp( level.var_a0cc52751f52c09.var_35f54bd7442b479a, level.var_a0cc52751f52c09.var_4980c76ede752579, squad_size_frac ) );
        end_time_ms = gettime() + undecided_battle_time_sec * 1000;
        min_time_ms = gettime() + 3000;
        
        while ( gettime() < end_time_ms && level.var_a0cc52751f52c09.virgil_ent.active_weak_points.size > 0 )
        {
            if ( gettime() > min_time_ms && level.var_a0cc52751f52c09.dance_ended )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    var_392506c7e7c9de99.weak_points_spawned = 1;
    level.var_a0cc52751f52c09.virgil_ent notify( #"end_ice_wall_attack" );
    
    foreach ( ice_wall_clump in var_966e8ba852fa24f3.ice_clumps )
    {
        foreach ( ice_wall_struct in ice_wall_clump.ice_wall_structs )
        {
            level thread namespace_dba99780c141b678::cleanup_ice_wall( ice_wall_struct, level.locust_boss.var_65d716cde74ff23f );
        }
    }
    
    foreach ( weak_point_struct in zombie_boss_virgil::function_86ea0d4221766f6() )
    {
        level thread battle_log( "Remaining Weak Point Health: " + weak_point_struct.health - weak_point_struct.damage_taken );
        
        if ( level.locust_boss.var_1a3c5082b1353761 )
        {
            var_31ea95b903e7b82b = 0.775;
            var_8c32951d92121853 = var_31ea95b903e7b82b * weak_point_struct.health;
            weak_point_struct.damage_taken = min( weak_point_struct.damage_taken, var_8c32951d92121853 );
            level thread battle_log( "Remaining Weak Point NEW Health: " + weak_point_struct.health - weak_point_struct.damage_taken );
        }
    }
    
    level.var_a0cc52751f52c09.virgil_ent zombie_boss_virgil::function_64ecba8d40b7f9d7();
    
    if ( zm_sat_locust_boss_fight::function_17846b5d2c783c6f() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    players_succeeded = level.var_a0cc52751f52c09.virgil_ent.active_weak_points.size == 0 || level.var_a0cc52751f52c09.dance_ended;
    battle_script.was_undecided = 1;
    
    if ( !players_succeeded )
    {
        level thread battle_log( "Num of Players: " + level.players.size + " failed undecided battle #" + level.var_a0cc52751f52c09.current_undecided_battle );
        battle_script.winner = "virgil";
        battle_script.victory_action = 1;
        battle_script.action_func = battle_script.virgil_action_func ?? &virgil_attack_bomb;
        battle_script.var_cc3c848b2b39048d = function_2985fe09d8f2f262( var_7ddaace0862cb868.bundle, 3, var_7ddaace0862cb868.virgil, "virgil", 1 );
    }
    else
    {
        if ( level.var_a0cc52751f52c09.virgil_ent.active_weak_points.size == 0 )
        {
            spare_time = "0";
            
            if ( end_time_ms > gettime() )
            {
                spare_time = string( ( end_time_ms - gettime() ) * 0.001 );
            }
            
            level thread battle_log( "Num of Players: " + level.players.size + " won undecided battle #" + level.var_a0cc52751f52c09.current_undecided_battle + " with " + spare_time + " seconds to spare." );
            battle_script.armor_break = 1;
            level.var_a0cc52751f52c09.current_undecided_battle++;
        }
        
        battle_script.winner = "pops";
        battle_script.victory_action = 1;
        battle_script.action_func = var_392506c7e7c9de99.pops_action_func ?? &function_78f494e5b9c67fef;
        battle_script.var_cc3c848b2b39048d = function_2985fe09d8f2f262( var_7ddaace0862cb868.bundle, 3, var_7ddaace0862cb868.pops, "pops", 1 );
    }
    
    level thread state_battle();
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0x314b8b45, Offset: 0x19c4
// Size: 0x17f
function state_battle()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.virgil_ent endon( #"death" );
    level.var_a0cc52751f52c09.pops_ent endon( #"death" );
    level thread battle_log( "STATE ENTER: SCRIPTED BATTLE" );
    battle_script = get_battle_script( level.var_a0cc52751f52c09.var_93ef15bc50a0d1f7 );
    var_7ddaace0862cb868 = battle_script.var_cc3c848b2b39048d;
    
    if ( !var_7ddaace0862cb868 )
    {
        var_7ddaace0862cb868 = get_battle_scene( undefined, battle_script.winner, battle_script.victory_action );
    }
    
    level thread battle_log( "Battle Scene Selected: " + var_7ddaace0862cb868.name );
    var_7ddaace0862cb868.bundle scene::play( [ level.var_a0cc52751f52c09.virgil_ent, level.var_a0cc52751f52c09.pops_ent ], var_7ddaace0862cb868.shot );
    function_5451c4ca365615cc( var_7ddaace0862cb868.shot );
    
    if ( battle_script.victory_action )
    {
        if ( battle_script.winner == "virgil" )
        {
            level thread state_virgil_victory();
        }
        else
        {
            level thread function_c8c8ffdf55c0d935();
        }
        
        return;
    }
    
    level thread state_prepare();
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0xe4db3e68, Offset: 0x1b4b
// Size: 0x175
function state_virgil_victory()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.virgil_ent endon( #"death" );
    level.var_a0cc52751f52c09.pops_ent endon( #"death" );
    level thread battle_log( "STATE ENTER: VIRGIL ATTACK PLAYERS" );
    level.var_a0cc52751f52c09.var_c67f4938ea8ca13d thread scene::play( [ level.var_a0cc52751f52c09.pops_ent ], [ "pops_defeat_idle" ] );
    battle_script = get_battle_script( level.var_a0cc52751f52c09.var_93ef15bc50a0d1f7 );
    level thread zm_sat_locust_boss_fight::function_b9f98165d48b9a1a();
    level thread zm_sat_locust_boss_fight::function_42ff753e6d5bc179();
    level.var_a0cc52751f52c09.virgil_ent [[ battle_script.action_func ]]();
    level.var_a0cc52751f52c09.virgil_ent utility::ent_flag_wait( "flag_virgil_is_ready" );
    level.var_a0cc52751f52c09.var_c67f4438ea8c963e scene::play( [ level.var_a0cc52751f52c09.virgil_ent, level.var_a0cc52751f52c09.pops_ent ], [ "transition 01" ] );
    level thread state_prepare();
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0xcce789c, Offset: 0x1cc8
// Size: 0x1a3
function function_c8c8ffdf55c0d935()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.virgil_ent endon( #"death" );
    level.var_a0cc52751f52c09.pops_ent endon( #"death" );
    level thread battle_log( "STATE ENTER: POPS ASSIST PLAYERS" );
    level.var_a0cc52751f52c09.var_c67f4938ea8ca13d thread scene::play( [ level.var_a0cc52751f52c09.virgil_ent ], [ "virgil_defeat_idle" ] );
    level thread zm_sat_locust_boss_fight::function_b9f98165d48b9a1a();
    level thread zm_sat_locust_boss_fight::function_42ff753e6d5bc179();
    level.locust_boss.var_f787818c2f0cc112 thread zm_sat_locust_boss_fight::function_313accf65ecc31c1();
    
    if ( level.var_a0cc52751f52c09.dance_ended )
    {
        level.var_a0cc52751f52c09.pops_ent function_78f494e5b9c67fef();
    }
    else
    {
        battle_script = get_battle_script( level.var_a0cc52751f52c09.var_93ef15bc50a0d1f7 );
        level.var_a0cc52751f52c09.pops_ent [[ battle_script.action_func ]]();
    }
    
    level.var_a0cc52751f52c09.var_c67f4438ea8c963e scene::play( [ level.var_a0cc52751f52c09.virgil_ent, level.var_a0cc52751f52c09.pops_ent ], [ "transition 02" ] );
    level thread state_prepare();
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0x30d6a88d, Offset: 0x1e73
// Size: 0x12a
function state_phase_transition()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.virgil_ent endon( #"death" );
    level.var_a0cc52751f52c09.pops_ent endon( #"death" );
    level thread battle_log( "STATE ENTER: PHASE 2 TRANSITION" );
    level thread zm_sat_locust_boss_fight::function_b9f98165d48b9a1a();
    level thread zm_sat_locust_boss_fight::function_42ff753e6d5bc179();
    level.locust_boss.var_f787818c2f0cc112 thread zm_sat_locust_boss_fight::function_313accf65ecc31c1();
    level thread namespace_589ae4efe3ba85ad::function_950d4585ce2b2a46();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_fb7ee0281852a3e6" );
    level.var_a0cc52751f52c09.var_c67f4338ea8c940b scene::play( [ level.var_a0cc52751f52c09.virgil_ent, level.var_a0cc52751f52c09.pops_ent ], [ "phase1_transition" ] );
    level callback::remove( #"hash_70700a7ae0ffa528", &function_b2ea7e1d5a0ca3dd );
    level notify( #"hash_4174149dd0216da" );
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0x7ccdbaeb, Offset: 0x1fa5
// Size: 0xdd
function pops_assist_glocke()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.pops_ent endon( #"death" );
    level thread battle_log( "Action - Glocke Drop" );
    level.var_a0cc52751f52c09.pops_ent thread function_9c540426c3b897b9();
    level.var_a0cc52751f52c09.var_c67f4338ea8c940b scene::play( level.var_a0cc52751f52c09.pops_ent, "barrage_atk_pops_plyr_facing" );
    level.var_a0cc52751f52c09.var_c67f4938ea8ca13d thread scene::play( level.var_a0cc52751f52c09.pops_ent, "pops_plyr_facing_idle" );
    wait level.var_a0cc52751f52c09.var_17f68dedd5f6849;
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0x16d8a0c3, Offset: 0x208a
// Size: 0xe8
function function_78f494e5b9c67fef()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.pops_ent endon( #"death" );
    level thread battle_log( "Action - Arena Barrage" );
    level.var_a0cc52751f52c09.var_c67f4338ea8c940b thread scene::play( level.var_a0cc52751f52c09.pops_ent, "barrage_atk_pops_plyr_facing" );
    level.var_a0cc52751f52c09.var_c67f4338ea8c940b scene::set_notify_state( level.var_a0cc52751f52c09.pops_ent, "scene_done" );
    level.var_a0cc52751f52c09.pops_ent thread function_22f27c8f9d02beb6();
    level.var_a0cc52751f52c09.pops_ent waittill( #"scene_done" );
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0xa7fb5522, Offset: 0x217a
// Size: 0x8f
function virgil_attack_bomb()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.virgil_ent endon( #"death" );
    level thread zm_sat_locust_boss_fight::function_b9f98165d48b9a1a();
    level thread zm_sat_locust_boss_fight::function_42ff753e6d5bc179();
    arena_section = namespace_589ae4efe3ba85ad::function_76ecceee1d5e4314();
    arena_section = arena_section ?? namespace_589ae4efe3ba85ad::get_available_section();
    
    if ( isdefined( arena_section ) )
    {
        level.var_a0cc52751f52c09.virgil_ent namespace_589ae4efe3ba85ad::function_caa813b1b18fec04( arena_section );
    }
}

// Namespace zombie_boss_virgil_pops
// Params 0, eflags: 0x4
// Checksum 0xba179841, Offset: 0x2211
// Size: 0xfe
function private function_9c540426c3b897b9()
{
    level endon( #"game_ended", #"hash_c7944c25ad06f095", #"hash_c7944b25ad06eee2" );
    level.var_a0cc52751f52c09.pops_ent endon( #"death" );
    var_bce3a8976bb64cb1 = utility::getstruct( "boss_arena_center_loc", "targetname" );
    wait level.var_a0cc52751f52c09.var_686c660ab19d3cfc;
    var_1bd890367e80209c = boss_pops::function_5841cefc95b45c06();
    glocke_drop_loc_structs = utility::getstructarray( "phase_1_glocke_drop_loc", "targetname" );
    closest_drop_loc = glocke_drop_loc_structs[ 0 ].origin;
    
    if ( !closest_drop_loc )
    {
        closest_drop_loc = getrandomnavpoint( var_bce3a8976bb64cb1.origin, 7500, undefined, 1 );
    }
    
    level.var_a0cc52751f52c09.pops_ent zm_sat_locust_glocke_drop::request_glocke_drop( closest_drop_loc, var_1bd890367e80209c, "delivery_loot_no_minigame" );
    zombie_boss_virgil::function_9c386609d0280bef( #"hash_f97707d9b2c60f0" );
}

// Namespace zombie_boss_virgil_pops
// Params 0, eflags: 0x4
// Checksum 0xcb865707, Offset: 0x2317
// Size: 0xd8
function private function_22f27c8f9d02beb6()
{
    wait level.var_a0cc52751f52c09.var_27e56042b97e2045;
    zombies = zm_sat_locust_boss_fight::function_4266e2c0c79cdd07();
    var_46f0c43efc430960 = undefined;
    
    if ( zombies.size > 0 )
    {
        var_46f0c43efc430960 = utility::function_54fdde0a73217354( zombies, 0, 1 );
    }
    
    if ( !var_46f0c43efc430960 )
    {
        var_46f0c43efc430960 = level.locust_boss.arena_center_struct.origin;
    }
    
    level.var_a0cc52751f52c09.pops_ent thread zm_sat_locust_wunderbarrage::launch_wunderbarrage( level.locust_boss.var_ff0560ae1fe34ada, level.var_a0cc52751f52c09.pops_ent, undefined, var_46f0c43efc430960, undefined );
    level utility::delaythread( 6.5, &function_3bd617b4936e008d, var_46f0c43efc430960, 850 );
    zombie_boss_virgil::function_9c386609d0280bef( #"hash_6cb37c3368099316" );
}

// Namespace zombie_boss_virgil_pops
// Params 2, eflags: 0x4
// Checksum 0x34c6df81, Offset: 0x23f7
// Size: 0xdc
function private function_3bd617b4936e008d( position, radius )
{
    var_9c39bfc2688c4ae5 = getaiarrayinradius( position, radius, "team_two_hundred" );
    
    foreach ( zombie in var_9c39bfc2688c4ae5 )
    {
        if ( isalive( zombie ) && !zm_sat_locust_boss_fight::is_boss_ent( zombie ) )
        {
            if ( zombie val::get( "damageshield_allow_quest_kill" ) )
            {
                zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
            }
            
            zombie kill();
        }
    }
}

// Namespace zombie_boss_virgil_pops
// Params 1
// Checksum 0xc4352b89, Offset: 0x24db
// Size: 0x27, Type: bool
function function_1255a83f7bf87761( var_91b1a61dfb132c72 )
{
    if ( var_91b1a61dfb132c72 == "zm_bernard_primary" || var_91b1a61dfb132c72 == "zm_bernard_secondary" )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_boss_virgil_pops
// Params 1, eflags: 0x4
// Checksum 0x48a7f3e8, Offset: 0x250b
// Size: 0x97
function private function_b2ea7e1d5a0ca3dd( params )
{
    zombie_subclasses = level.locust_boss.var_5ed02bdc19feccb7.var_d3f5f0cc01094984;
    zombie_spawn_locs = zm_sat_locust_boss_fight::function_3e87b4905eee6015( params.position, params.radius, zombie_subclasses );
    level.locust_boss.var_5ed02bdc19feccb7.valid_spawn_locs = zombie_spawn_locs;
    level.locust_boss.var_5ed02bdc19feccb7 thread zm_sat_locust_boss_fight::function_34a8c89ccb015bd7();
}

// Namespace zombie_boss_virgil_pops
// Params 0
// Checksum 0x1cea4459, Offset: 0x25aa
// Size: 0x4f
function function_d7a8b518a92e6441()
{
    battle_index = minint( level.var_a0cc52751f52c09.current_undecided_battle, level.var_a0cc52751f52c09.undecided_battles.size );
    return level.var_a0cc52751f52c09.undecided_battles[ battle_index ];
}

// Namespace zombie_boss_virgil_pops
// Params 1, eflags: 0x4
// Checksum 0x63c2ecfb, Offset: 0x2602
// Size: 0x176
function private function_5451c4ca365615cc( battle_scene_name )
{
    if ( isarray( battle_scene_name ) && battle_scene_name.size == 2 )
    {
        battle_scene_name = battle_scene_name[ 1 ];
    }
    
    switch ( battle_scene_name )
    {
        case #"hash_a0e1754099afa39":
            level.var_a0cc52751f52c09.pops_ent setscriptablepartstate( #"head", #"damaged" );
            break;
        case #"hash_7c319367369954dc":
            level.var_a0cc52751f52c09.pops_ent setscriptablepartstate( #"hash_1f103bb2b8170224", #"damaged" );
            break;
        case #"hash_a8b533cf90dd0fda":
            level.var_a0cc52751f52c09.pops_ent setscriptablepartstate( #"hips", #"damaged" );
            break;
        case #"hash_28c8c457ea47febf":
            level.var_a0cc52751f52c09.pops_ent setscriptablepartstate( #"right arm", #"damaged" );
            level.var_a0cc52751f52c09.pops_ent setscriptablepartstate( #"left arm", #"damaged" );
            break;
        case #"hash_7a6772704ebe1d11":
            level.var_a0cc52751f52c09.pops_ent setscriptablepartstate( #"hash_47126042cfda6fbd", #"damaged" );
            break;
    }
}

// Namespace zombie_boss_virgil_pops
// Params 1
// Checksum 0xee1eb97d, Offset: 0x2780
// Size: 0x195
function function_f5bdb00e35d67dc5( battle_difficulty = 1 )
{
    if ( battle_difficulty == 2 )
    {
        return { #ice_clumps:level.locust_boss.var_e84aa86341a44c43, #var_93874a4bdaff8e91:level.locust_boss.var_2587cda957b2249a, #weak_point_settings:level.locust_boss.var_798c76b6802b4b16 };
    }
    
    if ( battle_difficulty == 1 )
    {
        return { #ice_clumps:level.locust_boss.var_bb8c9f56882bf5cc, #var_93874a4bdaff8e91:level.locust_boss.var_d8e6192766a7f281, #weak_point_settings:level.locust_boss.var_413400bce8a8580d };
    }
    
    if ( battle_difficulty == 0 )
    {
        return { #ice_clumps:level.locust_boss.var_679f35ffd4968766, #var_93874a4bdaff8e91:level.locust_boss.var_e0a617f2185b96cf, #weak_point_settings:level.locust_boss.var_b255a818a9203db3 };
    }
    
    if ( battle_difficulty == 3 )
    {
        return { #ice_clumps:level.locust_boss.var_679f35ffd4968766, #var_93874a4bdaff8e91:level.locust_boss.var_e0a617f2185b96cf, #weak_point_settings:level.locust_boss.var_7856f3fdd6d929cc };
    }
}

// Namespace zombie_boss_virgil_pops
// Params 1, eflags: 0x4
// Checksum 0xf371bccf, Offset: 0x291d
// Size: 0x7c
function private battle_log( msg )
{
    elapsed_time_sec = gettime() * 0.001 - level.var_a0cc52751f52c09.var_d36311e820ed0fab;
    msg = "(" + gettime() * 0.001 + ")" + " ELAPSED TIME (" + elapsed_time_sec + ") " + msg;
    playtest_logger::loginfo( msg, level.var_a0cc52751f52c09.logger_config );
}

// Namespace zombie_boss_virgil_pops
// Params 3, eflags: 0x4
// Checksum 0x2615fe15, Offset: 0x29a1
// Size: 0x25c
function private get_battle_scene( type, victor, action )
{
    var_d831012108d80bb9 = 9223372036854775807;
    var_aa6b27ae5bc2543d = [];
    
    foreach ( battle_scene_struct in level.var_a0cc52751f52c09.battle_scene_structs )
    {
        if ( isdefined( type ) )
        {
            if ( type != battle_scene_struct.type )
            {
                continue;
            }
        }
        
        if ( isdefined( victor ) )
        {
            if ( victor != battle_scene_struct.victor )
            {
                continue;
            }
        }
        
        if ( isdefined( action ) )
        {
            if ( action != battle_scene_struct.action )
            {
                continue;
            }
        }
        
        var_aa6b27ae5bc2543d[ var_aa6b27ae5bc2543d.size ] = battle_scene_struct;
        var_b4fb0e40e7b87c11 = level.var_a0cc52751f52c09.var_c0fd8fb2667da7e6[ battle_scene_struct.name ];
        
        if ( var_b4fb0e40e7b87c11 < var_d831012108d80bb9 )
        {
            var_d831012108d80bb9 = var_b4fb0e40e7b87c11;
        }
    }
    
    var_f895635cca4881b1 = [];
    
    foreach ( var_e3de1dbdec57a0dc in var_aa6b27ae5bc2543d )
    {
        var_b4fb0e40e7b87c11 = level.var_a0cc52751f52c09.var_c0fd8fb2667da7e6[ var_e3de1dbdec57a0dc.name ];
        
        if ( var_b4fb0e40e7b87c11 == var_d831012108d80bb9 )
        {
            var_f895635cca4881b1[ var_f895635cca4881b1.size ] = var_e3de1dbdec57a0dc;
        }
    }
    
    if ( var_f895635cca4881b1.size > 0 )
    {
        var_963dc702fe185155 = utility::array_random( var_f895635cca4881b1 );
    }
    else if ( var_aa6b27ae5bc2543d.size > 0 )
    {
        var_963dc702fe185155 = utility::array_random( var_aa6b27ae5bc2543d );
    }
    else
    {
        assertmsg( "<dev string:x24>" );
        var_963dc702fe185155 = utility::array_random( level.var_a0cc52751f52c09.battle_scene_structs );
    }
    
    level.var_a0cc52751f52c09.var_c0fd8fb2667da7e6[ var_963dc702fe185155.name ]++;
    return var_963dc702fe185155;
}

// Namespace zombie_boss_virgil_pops
// Params 5, eflags: 0x4
// Checksum 0x5f1709ab, Offset: 0x2c06
// Size: 0x90
function private function_2985fe09d8f2f262( bundle, type, shot, victor, action )
{
    battle_scene_struct = { #action:action, #victor:victor, #shot:shot, #type:type, #bundle:bundle, #name:isarray( shot ) ? shot[ 0 ] : shot };
    return battle_scene_struct;
}

// Namespace zombie_boss_virgil_pops
// Params 6, eflags: 0x4
// Checksum 0xf342d008, Offset: 0x2c9f
// Size: 0xa7
function private function_25a3444b3ef0c28b( bundle, type, shot, victor, action, var_9d7be03640e0c7fa = 0 )
{
    battle_scene_struct = function_2985fe09d8f2f262( bundle, type, shot, victor, action );
    level.var_a0cc52751f52c09.battle_scene_structs[ level.var_a0cc52751f52c09.battle_scene_structs.size ] = battle_scene_struct;
    level.var_a0cc52751f52c09.var_c0fd8fb2667da7e6[ battle_scene_struct.name ] = var_9d7be03640e0c7fa;
}

// Namespace zombie_boss_virgil_pops
// Params 8, eflags: 0x4
// Checksum 0xf6481e9, Offset: 0x2d4e
// Size: 0xf9
function private function_5e6a29f099ed9b26( bundle, shot, action, loop, pops_shots, virgil_shots, var_6385e747e771bcd7, var_9d7be03640e0c7fa = 0 )
{
    battle_scene_struct = function_2985fe09d8f2f262( bundle, 3, shot, "battle_winner_undecided", action );
    battle_scene_struct.loop = loop;
    battle_scene_struct.pops = pops_shots;
    battle_scene_struct.virgil = virgil_shots;
    battle_scene_struct.var_6385e747e771bcd7 = var_6385e747e771bcd7;
    level.var_a0cc52751f52c09.battle_scene_structs[ level.var_a0cc52751f52c09.battle_scene_structs.size ] = battle_scene_struct;
    level.var_a0cc52751f52c09.var_c0fd8fb2667da7e6[ battle_scene_struct.name ] = var_9d7be03640e0c7fa;
    return battle_scene_struct;
}

// Namespace zombie_boss_virgil_pops
// Params 1, eflags: 0x4
// Checksum 0x85cb1d86, Offset: 0x2e50
// Size: 0x1a0
function private get_battle_script( cycle )
{
    battle_script = level.var_a0cc52751f52c09.var_96fe9d5b0c01dbf9[ cycle ];
    
    if ( cycle > 0 )
    {
        var_81e22405dd712b6d = level.var_a0cc52751f52c09.var_96fe9d5b0c01dbf9[ cycle - 1 ];
    }
    else if ( cycle < 0 )
    {
        return;
    }
    
    if ( isdefined( battle_script ) )
    {
        return battle_script;
    }
    
    var_5c0df6de32dc5351 = {};
    
    if ( var_81e22405dd712b6d.victory_action && var_81e22405dd712b6d.winner == "virgil" )
    {
        var_5c0df6de32dc5351.winner = utility::array_random( [ "virgil", "pops" ] );
        var_5c0df6de32dc5351.victory_action = 0;
        var_5c0df6de32dc5351.var_6559194b462cd918 = 1;
        level thread battle_log( "Battle Script Cycle: " + cycle + ". Had a previous Victory Action. Selecting Performative Option." );
    }
    else
    {
        var_5c0df6de32dc5351.winner = "battle_winner_undecided";
        var_5c0df6de32dc5351.virgil_action_func = &virgil_attack_bomb;
        var_5c0df6de32dc5351.pops_action_func = &function_78f494e5b9c67fef;
        var_5c0df6de32dc5351.var_6559194b462cd918 = 1;
    }
    
    level thread battle_log( "Battle Script Cycle: " + cycle + ". Winner: " + var_5c0df6de32dc5351.winner + ". Victory Action: " + string( var_5c0df6de32dc5351.victory_action ) + ". Skip Idle: " + string( var_5c0df6de32dc5351.var_6559194b462cd918 ) );
    level.var_a0cc52751f52c09.var_96fe9d5b0c01dbf9[ cycle ] = var_5c0df6de32dc5351;
    return var_5c0df6de32dc5351;
}

// Namespace zombie_boss_virgil_pops
// Params 1
// Checksum 0xfea86856, Offset: 0x2ff8
// Size: 0x14
function getfunction( funcid )
{
    return interaction_common::function_d4be89b1cf3d4993( funcid );
}

/#

    // Namespace zombie_boss_virgil_pops
    // Params 1, eflags: 0x4
    // Checksum 0xa891ee1a, Offset: 0x3015
    // Size: 0x79, Type: dev
    function private debug_state_pause( statename )
    {
        /#
            for ( specific_state_change = getdvar( @"hash_abbb98610b936ca2", "<dev string:xa3>" ); getdvarint( @"hash_9d05f1c76164c161", 0 ) || specific_state_change != "<dev string:xa3>" && issubstr( tolower( statename ), tolower( specific_state_change ) ) ; specific_state_change = getdvar( @"hash_abbb98610b936ca2", "<dev string:xa3>" ) )
            {
                waitframe();
            }
        #/
    }

#/
