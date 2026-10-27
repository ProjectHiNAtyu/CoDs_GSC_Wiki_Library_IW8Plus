// scripts\mp\zm\tedd_tasks.gsc  (hash_292c039f763f4b94.gscc) (size: 108054 Bytes / 0x1a616 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xba8a58d6 (3129628886)
// size ...... 108054 (0x1a616)
// includes .. 44  (offset: 0x18f0a)
// strings ... 244 (offset: 0x1906a)
// dev strs .. 62  (offset: 0x1a30e)
// exports ... 227 (offset: 0x124ee)
// cseg ...... 0x1524 + 0x10fca (0x124ee)
// imports ... 468 (offset: 0x14866)
// animtree1 . 0   (offset: 0x1a616)
// animtree2 . 0   (offset: 0x1a616)
#using script_16ea1b94f0f381b3;
#using script_a8268e56860874f;
#using script_aa3bac81ad4fc8e;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\powerups\full_power;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace teddtasks;

// Namespace teddtasks
// Params 0, eflags: 0x5
// Checksum 0x83468d24, Offset: 0x1542
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"teddtasks", undefined, &init_teddtasks, undefined );
}

// Namespace teddtasks
// Params 0
// Checksum 0xd2274f99, Offset: 0x1563
// Size: 0x488
function init_teddtasks()
{
    if ( getdvarint( @"hash_ead72691a7d4475", 0 ) )
    {
        return;
    }
    
    if ( !level.gametypebundle.var_72ac15a3b4f37f80 )
    {
        var_62638af37653ded7 = utility::getstructarray( "teddtask", "script_noteworthy" );
        
        foreach ( destination in var_62638af37653ded7 )
        {
            on_spawn_teddtask( destination );
        }
        
        var_62638af37653ded7 = utility::getstructarray( "teddtask_killzone", "script_noteworthy" );
        
        foreach ( destination in var_62638af37653ded7 )
        {
            on_spawn_teddtask( destination );
        }
        
        var_62638af37653ded7 = utility::getstructarray( "teddtask_holdzone", "script_noteworthy" );
        
        foreach ( destination in var_62638af37653ded7 )
        {
            on_spawn_teddtask( destination );
        }
        
        var_62638af37653ded7 = utility::getstructarray( "teddtask_holdzone_and_killzone", "script_noteworthy" );
        
        foreach ( destination in var_62638af37653ded7 )
        {
            on_spawn_teddtask( destination );
        }
        
        return;
    }
    
    map_info_bundle = getactivemapinfobundle();
    
    if ( !map_info_bundle.var_5051a1153bf7de9f )
    {
        return;
    }
    
    level.tedd_challenges = [];
    level.var_f30ca8dcd3d76b94 = [];
    level.tedd_locations = [];
    level.var_aa683977d9d7ac47 = [];
    level.var_25a70c08764c4ac6 = [];
    level.roundscale = undefined;
    level.var_4584d2a490bee346 = 0;
    level.var_b21212eb5055e9a5 = 0;
    level.var_69fd32cd84096bd4 = 0;
    level._effect[ "zombie_impact" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact" );
    level._effect[ "zombie_impact_blood" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact_blood" );
    level._effect[ "tessie_gate" ] = loadfxasset( "vfx_t10_gameplay_zm_boat_gate_blue" );
    level._effect[ "tessie_next_gate" ] = loadfxasset( "vfx_t10_gameplay_zm_boat_gate_orange" );
    level._effect[ "tessie_final_gate" ] = loadfxasset( "vfx_t10_gameplay_zm_boat_gate_green" );
    level._effect[ "tessie_passing_gate" ] = loadfxasset( "vfx_t10_gameplay_zm_boat_cross_gate" );
    level._effect[ "tessie_arrow" ] = loadfxasset( "vfx_t10_levels_zm_quartz_directional_arrow_orange" );
    level._effect[ "tessie_arrow_final" ] = loadfxasset( "vfx_t10_levels_zm_quartz_directional_arrow_green" );
    level._effect[ "tessie_arrow_clear" ] = loadfxasset( "vfx_t10_levels_zm_quartz_directional_arrow_white_fade" );
    level.var_6cd59946b7475e48 = undefined;
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"tasks_spawn", &function_b6bbb9467dc688bc );
    
    if ( isdefined( map_info_bundle.var_6ce5662bb95e4da0 ) )
    {
        function_338d60aa9c62bd0( map_info_bundle.var_6ce5662bb95e4da0 );
    }
    else
    {
        s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
        
        if ( isdefined( s_bundle ) && isarray( s_bundle.var_5affbc209c3d4203 ) )
        {
            function_338d60aa9c62bd0( s_bundle.var_19dd92d61272c9c2 );
        }
    }
    
    content_manager::function_3209da123476142f( "teddtasks", &on_spawn_teddtask );
    
    if ( !level.gamemodebundle.var_c214fc63695cd685 )
    {
        level thread function_f8de431251c46c4a();
    }
    else
    {
        callback::add( "ob_content_process_create_script", &function_f8de431251c46c4a );
    }
    
    level thread function_38cc78a151dcfbfe();
    level callback::add( #"player_connect", &function_ea7e65df624ea3d5 );
    scene::function_85b13b837056bc8b( &igc_start_func );
    scene::function_53de0775d8452750( &igc_end_func );
}

// Namespace teddtasks
// Params 0
// Checksum 0xdcfa791b, Offset: 0x19f3
// Size: 0x63
function function_38cc78a151dcfbfe()
{
    while ( true )
    {
        waitframe();
        
        if ( !function_599ed71d54c4c3f8() )
        {
            if ( isdefined( level.var_a3eb428773fa9129 ) && !isdefined( level.var_fd94a3cfab1edb0 ) )
            {
                level.var_8cff5e93e7f5e8 = undefined;
                level.var_a3eb428773fa9129 hide_teddtask( 1 );
                level.var_a3eb428773fa9129 = undefined;
                level notify( #"task_interrupt" );
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x610daf1f, Offset: 0x1a5e
// Size: 0x22, Type: bool
function function_599ed71d54c4c3f8()
{
    if ( level val::get( "task_logic_activate" ) || level.is_task_debug )
    {
        return true;
    }
    
    return false;
}

// Namespace teddtasks
// Params 0
// Checksum 0xe41698fc, Offset: 0x1a89
// Size: 0xa4
function function_bc01a392b11e1af6()
{
    var_f43eb6e734c44585 = [];
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player.var_896ba90a1f08dc45 )
        {
            continue;
        }
        
        var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
    }
    
    return var_f43eb6e734c44585;
}

// Namespace teddtasks
// Params 1
// Checksum 0xcd35d0c, Offset: 0x1b36
// Size: 0x2fd
function function_f8de431251c46c4a( params )
{
    level endon( #"game_ended" );
    waittillframeend();
    var_62638af37653ded7 = utility::getstructarray( "teddtask", "script_noteworthy" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        on_spawn_teddtask( destination );
    }
    
    var_62638af37653ded7 = utility::getstructarray( "teddtask_killzone", "script_noteworthy" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        on_spawn_teddtask( destination );
    }
    
    var_62638af37653ded7 = utility::getstructarray( "teddtask_holdzone", "script_noteworthy" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        on_spawn_teddtask( destination );
    }
    
    var_62638af37653ded7 = utility::getstructarray( "teddtask_holdzone_and_killzone", "script_noteworthy" );
    
    foreach ( destination in var_62638af37653ded7 )
    {
        on_spawn_teddtask( destination );
    }
    
    if ( isdefined( level.var_31998b7ccf36d152 ) )
    {
        if ( utility::issharedfuncdefined( #"survival_mode", #"override_tedd_task" ) )
        {
            level utility::callsharedfunc( #"survival_mode", #"override_tedd_task" );
        }
        
        level callback::add( "on_round_start", &on_round_start );
        
        foreach ( a_s_teddtasks in level.var_31998b7ccf36d152 )
        {
            a_s_teddtasks.var_93e4a0a8514ca47e = a_s_teddtasks.targetname;
        }
        
        function_b6290cf8847b5d4a();
        
        /#
            init_tasks_debug();
        #/
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0xfd7c3f4d, Offset: 0x1e3b
// Size: 0x892
function function_338d60aa9c62bd0( taskslist )
{
    if ( isarray( taskslist ) )
    {
        foreach ( typeindex, tasklist in taskslist )
        {
            task_bundle = getscriptbundle( tasklist.samtrialslist );
            
            if ( isdefined( task_bundle ) )
            {
                foreach ( taskindex, task in task_bundle.trialstruct )
                {
                    begin_func = undefined;
                    end_func = undefined;
                    var_4b982a86540b7193 = undefined;
                    hold_zone = 0;
                    var_47ecdfefe42d85a5 = 0;
                    var_733c3a80dec065c3 = undefined;
                    var_141fa4ee9eaf198b = undefined;
                    
                    switch ( task.trialname )
                    {
                        case #"killfest_task":
                            begin_func = &function_8a708daa6ff124dd;
                            end_func = &function_cd47d47d696193f5;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"killzone_task":
                            begin_func = &function_6aae02a40e2e3c02;
                            end_func = &function_5ac3d0ff7a600cd6;
                            var_141fa4ee9eaf198b = #"hash_8cab7394cebc0db1";
                            var_47ecdfefe42d85a5 = 1;
                            break;
                        case #"holding_task":
                            begin_func = &function_89a4b9f9bc4fd568;
                            end_func = &function_35bb83a0bd23481c;
                            var_141fa4ee9eaf198b = #"hash_9d1a39df01856b94";
                            hold_zone = 1;
                            break;
                        case #"deadeye_task":
                            begin_func = &function_684e1dca7da979c9;
                            end_func = &function_eea5bf547c21e761;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"crouch_task":
                            begin_func = &function_66140ef554c6df7c;
                            end_func = &function_e2568511c79bcc10;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hipfire_task":
                            begin_func = &function_6b6abc5a5beb79df;
                            end_func = &function_5354f5b8f8f00e7f;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_6f285bafad03005c":
                            begin_func = &function_3b5902c939afd55f;
                            end_func = &function_4d9eb9121831fdff;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_e5258b343e2c20b8":
                            begin_func = &function_ded6319d67ebcb03;
                            end_func = &function_3a52f6f62c763983;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_ba2317c9aed69030":
                            begin_func = &function_8ce0bffd8e864da7;
                            end_func = &function_9434cfe0cdf72097;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_73a0cda637a9fddb":
                            begin_func = &function_f68bfccf4cada9b2;
                            end_func = &function_1ff7c578c7f8f086;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"equipment_kill_task":
                            begin_func = &function_da4b7f15133fb5da;
                            end_func = &function_ad3a23d225ef295e;
                            var_141fa4ee9eaf198b = #"hash_6dcfc60a47b1635";
                            break;
                        case #"hash_b5cc287ee78dd3b1":
                            begin_func = &function_e6e754f384217673;
                            end_func = &function_403064dcbc4b84f3;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"multikill_task":
                            begin_func = &function_40ef98b743cf494e;
                            end_func = &function_fcbd7ba16c26f3a2;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_ae8f9e6180549b26":
                            begin_func = &function_1347bd4edb73540b;
                            end_func = &function_11f70bbfdb99ff5b;
                            var_141fa4ee9eaf198b = #"hash_d6eb02bd68f0601";
                            break;
                        case #"rcxd_kills":
                            begin_func = &function_a7f6679048d6b8d5;
                            end_func = &function_674f8be6e1ea355d;
                            var_141fa4ee9eaf198b = #"hash_d6eb02bd68f0601";
                            break;
                        case #"mangler_cannon_kills":
                            begin_func = &function_2eb5b7b40f13174e;
                            end_func = &function_5cb20d8c7c5a11a2;
                            var_141fa4ee9eaf198b = #"hash_d6eb02bd68f0601";
                            break;
                        case #"phd_flopper_kills":
                            begin_func = &function_fb620fbe86cd8684;
                            end_func = &function_3727ddd7fbe5ff88;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"combat_axe_kills":
                            begin_func = &function_5737a44a24c52e31;
                            end_func = &function_5559d346454317f9;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hand_cannon_kills":
                            begin_func = &function_a6626864de6bb896;
                            end_func = &function_d5e8aa6cff06ef9a;
                            var_141fa4ee9eaf198b = #"hash_d6eb02bd68f0601";
                            break;
                        case #"hash_ea48a75c45ceb167":
                            begin_func = &function_5a59a62a35a4398c;
                            end_func = &function_d447d7fa331b13a0;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"ravager_kills":
                            begin_func = &function_3a778efff187fedc;
                            end_func = &function_5537a9e3692f0170;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"ol_tessie_race":
                            begin_func = &function_dca39aacef6b3ecf;
                            end_func = &function_416b68942789962f;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_118650abf6b05f4f":
                            begin_func = &function_b1f3f6ce9327e3cc;
                            end_func = &function_2531f42cdab1d3e0;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"jumppad_kill_task":
                            begin_func = &function_8a44875c338da4a6;
                            end_func = &function_b00b07c8a20c18aa;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_ce9fdbcda61d6a64":
                            begin_func = &function_7e1fc4da6da325e3;
                            end_func = &function_4bf0cd04dc694763;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_d05df353e9a4f244":
                            begin_func = &function_46d8f4de173b9410;
                            end_func = &function_f843b745f166a674;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_ee4baa4bd2e99fbc":
                            begin_func = &function_472508eb0f5ad52b;
                            end_func = &function_73408bb7c2b6de7b;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"laser_trap_task":
                            begin_func = &function_3cd260ab16dac6a9;
                            end_func = &function_786d435822a6f641;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_b889bb5a45343ffb":
                            begin_func = &function_c33dc2b33469e642;
                            end_func = &function_f04348c68a436616;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_c8ea9a99174bd498":
                            begin_func = &function_5e88e04229a7e69e;
                            end_func = &function_5a80b7d23793abf2;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_25c962afdfe978cd":
                            begin_func = &function_438872664ac2f0f1;
                            end_func = &function_2445697244cc29b9;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_6b9680cd639231d9":
                            begin_func = &function_d8a37ed333152fb2;
                            end_func = &function_7247a837e3f90686;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_5c31db188171f96":
                            begin_func = &function_f05779fd93f90a8d;
                            end_func = &function_fb5dd3c1a2cea025;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_a48ad861d242497c":
                            begin_func = &function_40f4ec7bd8eaddb8;
                            end_func = &function_f0df1fe25a780fec;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"lava_trial":
                            begin_func = &function_e7f9b51efcae602d;
                            end_func = &function_432050a0daee2745;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_a3cadba4140aefef":
                            begin_func = &function_f05779fd93f90a8d;
                            end_func = &function_fb5dd3c1a2cea025;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"phd_flopper_scarab":
                            begin_func = &function_ba0219c238241fa2;
                            end_func = &function_8f2d298d69fa67f6;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_16ebae0f38e004ac":
                            begin_func = &function_14917ec5c1e0a5d8;
                            end_func = &function_23419b6ecb0be50c;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                        case #"hash_1b9662b3e5586c37":
                            begin_func = &function_ccab5ffc99ff2b8c;
                            end_func = &function_c5bf042a19e8b5a0;
                            var_141fa4ee9eaf198b = #"hash_193b515058eb9850";
                            break;
                    }
                    
                    function_d8e253939842fa25( task.trialname, task.var_40e8271091a7ffcd, typeindex, taskindex, task.level1time, task.level2time, task.level3time, task.var_47c9e80732806591, task.var_81aa943b3c6085, task.var_3cd507e9a4d604bf, task.var_3cb215e9a4afdbd1, task.var_caf31413692b1ff8, task.trialweight, task.level1mastery, task.level2mastery, task.level3mastery, task.var_b5f00f4c6da195d5, task.var_ebfe6af0ee41141d, hold_zone, var_47ecdfefe42d85a5, task.triallocation, task.var_15bcb9af47b058b8, begin_func, end_func, task.var_7b000dbed04b4b2d, task.var_48513829d1f2cb20, task.waypointstate, var_4b982a86540b7193, var_141fa4ee9eaf198b, task.relicrefs );
                }
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xbf61406d, Offset: 0x26d5
// Size: 0x6d6
function function_8c7dd04aa844bd67()
{
    blocked_tasks = [];
    var_996b23f3178096ec = undefined;
    [ valid_locations, var_499f1feeb9d67e34, var_c37ce4e300923f51 ] = level function_8d3fdf6f4d0a2eef();
    
    if ( isdefined( level.var_d1b86166c79a010b ) && valid_locations.size > 1 )
    {
        var_996b23f3178096ec = level.var_d1b86166c79a010b;
        var_c37ce4e300923f51 = arrayremove( var_c37ce4e300923f51, level.var_d1b86166c79a010b );
        var_499f1feeb9d67e34 = arrayremove( var_499f1feeb9d67e34, level.var_d1b86166c79a010b );
        valid_locations = arrayremove( valid_locations, level.var_d1b86166c79a010b );
    }
    
    var_b21e306cc44872ec = function_f2b70b9ae4163ff8();
    
    if ( var_b21e306cc44872ec )
    {
        level.var_fec0dbcf6bc0c4be = [];
    }
    else
    {
        blocked_tasks = level.var_fec0dbcf6bc0c4be;
    }
    
    foreach ( challenge in level.tedd_challenges )
    {
        if ( challenge === level.var_b570c2056b285e27 )
        {
            blocked_tasks = arraycombineunique( blocked_tasks, [ challenge ] );
        }
        else if ( isdefined( challenge.str_unique_name ) && challenge.str_unique_name != "" )
        {
            if ( challenge.str_unique_name === var_996b23f3178096ec.targetname )
            {
                blocked_tasks = arraycombineunique( blocked_tasks, [ challenge ] );
            }
            else if ( challenge.var_c2afe1a671205584 == #"ol_tessie_race" || challenge.var_c2afe1a671205584 == #"hash_118650abf6b05f4f" )
            {
                if ( level utility::flag( "pause_tessie_task_wvq_1" ) || level utility::flag( "pause_tessie_task_wvq_2" ) || level utility::flag( "pause_tessie_task_wwq" ) || level utility::flag( "pause_tessie_task_mq" ) || !level utility::flag( "garage_opened" ) )
                {
                    blocked_tasks = arraycombineunique( blocked_tasks, [ challenge ] );
                }
            }
            else if ( challenge.var_c2afe1a671205584 == #"laser_trap_task" )
            {
                if ( !utility::flag( "ruby_wwq_complete" ) )
                {
                    blocked_tasks = arraycombineunique( blocked_tasks, [ challenge ] );
                }
            }
            else if ( isdefined( challenge.str_unique_name ) && challenge.str_unique_name != "" )
            {
                if ( challenge.str_unique_name === var_996b23f3178096ec.targetname )
                {
                    blocked_tasks = arraycombineunique( blocked_tasks, [ challenge ] );
                }
                else
                {
                    var_cdecdce0a06d8f6f = undefined;
                    
                    foreach ( tedd_location in valid_locations )
                    {
                        if ( tedd_location.targetname == challenge.str_unique_name )
                        {
                            var_cdecdce0a06d8f6f = 1;
                            break;
                        }
                    }
                    
                    if ( !isdefined( var_cdecdce0a06d8f6f ) )
                    {
                        blocked_tasks = arraycombineunique( blocked_tasks, [ challenge ] );
                    }
                }
            }
        }
        
        if ( challenge.var_c2afe1a671205584 == #"mangler_cannon_kills" || challenge.var_c2afe1a671205584 == #"rcxd_kills" )
        {
            foreach ( player in level.players )
            {
                var_6fb860f7c9723d4e = player bgb::is_active( "support_group" );
                
                if ( var_6fb860f7c9723d4e == 1 )
                {
                    blocked_tasks = arraycombineunique( blocked_tasks, [ challenge ] );
                    break;
                }
            }
        }
        
        if ( challenge.var_1bbfedd55ef1a7ae && var_c37ce4e300923f51.size == 0 || challenge.b_kill_challenge && var_499f1feeb9d67e34.size == 0 )
        {
            blocked_tasks = arraycombineunique( blocked_tasks, [ challenge ] );
        }
    }
    
    level.tedd_challenges = arrayremove( level.tedd_challenges, blocked_tasks );
    
    if ( level.tedd_challenges.size <= 0 )
    {
        level.tedd_challenges = level.var_f30ca8dcd3d76b94;
    }
    
    weight_array = [];
    
    foreach ( challenge in level.tedd_challenges )
    {
        weight_array[ weight_array.size ] = challenge.var_a58b9f66285b1c55;
    }
    
    level.var_8cff5e93e7f5e8 = utility::random_weighted( level.tedd_challenges, weight_array );
    
    if ( level.var_8cff5e93e7f5e8.var_1bbfedd55ef1a7ae )
    {
        level.var_a3eb428773fa9129 = utility::array_random( var_c37ce4e300923f51 );
    }
    else if ( level.var_8cff5e93e7f5e8.b_kill_challenge )
    {
        level.var_a3eb428773fa9129 = utility::array_random( var_499f1feeb9d67e34 );
    }
    else if ( level.var_8cff5e93e7f5e8.str_unique_name != "" )
    {
        foreach ( location in valid_locations )
        {
            if ( location.targetname == level.var_8cff5e93e7f5e8.str_unique_name )
            {
                level.var_a3eb428773fa9129 = location;
                break;
            }
        }
    }
    else
    {
        level.var_a3eb428773fa9129 = utility::array_random( valid_locations );
    }
    
    if ( isdefined( level.var_4833eef421ac6267 ) )
    {
        level.var_a3eb428773fa9129 = level.var_4833eef421ac6267;
    }
    
    if ( blocked_tasks.size > 0 )
    {
        level.tedd_challenges = arraycombine( level.tedd_challenges, blocked_tasks );
    }
    
    if ( isdefined( level.var_a3eb428773fa9129 ) )
    {
        level.var_a3eb428773fa9129 show_teddtask( 0 );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x1c1c5fc8, Offset: 0x2db3
// Size: 0x43, Type: bool
function function_f2b70b9ae4163ff8()
{
    var_19090c6d5ceab754 = level.tedd_challenges;
    
    if ( !isdefined( level.var_fec0dbcf6bc0c4be ) )
    {
        level.var_fec0dbcf6bc0c4be = [];
    }
    
    var_19090c6d5ceab754 = arrayremove( var_19090c6d5ceab754, level.var_fec0dbcf6bc0c4be );
    return var_19090c6d5ceab754.size == 0;
}

// Namespace teddtasks
// Params 0
// Checksum 0x1b908bf3, Offset: 0x2dff
// Size: 0x24e
function function_8d3fdf6f4d0a2eef()
{
    var_499f1feeb9d67e34 = [];
    var_c37ce4e300923f51 = [];
    valid_locations = [];
    
    foreach ( tedd_location in level.tedd_locations )
    {
        task_zone = zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( tedd_location.origin ) );
        var_a216e8aa5c6a0670 = 1;
        
        if ( isdefined( task_zone ) && utility::issharedfuncdefined( #"hash_be7eb02741915d95", #"hash_be7eb02741915d95" ) )
        {
            profilestart();
            var_a216e8aa5c6a0670 = self [[ utility::getsharedfunc( #"hash_be7eb02741915d95", #"hash_be7eb02741915d95" ) ]]( task_zone );
            profilestop();
        }
        
        if ( isdefined( task_zone ) && var_a216e8aa5c6a0670 )
        {
            var_c96b1c3cfbbd6aac = task_zone zone_manager::get_adjacent_zones( 1, 1 );
            
            if ( var_c96b1c3cfbbd6aac.size > 0 )
            {
                if ( isdefined( tedd_location ) )
                {
                    if ( tedd_location.script_label == "must_unlock" && !task_zone.is_enabled )
                    {
                        continue;
                    }
                    
                    valid_locations = arraycombineunique( valid_locations, [ tedd_location ] );
                    
                    switch ( tedd_location.script_noteworthy )
                    {
                        case #"hash_445b5dfa2a170606":
                            var_499f1feeb9d67e34 = arraycombineunique( var_499f1feeb9d67e34, [ tedd_location ] );
                            break;
                        case #"hash_822bc1d083b5aa9f":
                            var_c37ce4e300923f51 = arraycombineunique( var_c37ce4e300923f51, [ tedd_location ] );
                            break;
                        case #"hash_927c40326f210c88":
                            var_499f1feeb9d67e34 = arraycombineunique( var_499f1feeb9d67e34, [ tedd_location ] );
                            var_c37ce4e300923f51 = arraycombineunique( var_c37ce4e300923f51, [ tedd_location ] );
                            break;
                    }
                }
            }
        }
    }
    
    if ( utility::issharedfuncdefined( #"hash_f2451a0850e06732", #"hash_f2451a0850e06732" ) )
    {
        profilestart();
        [ valid_locations, var_499f1feeb9d67e34, var_c37ce4e300923f51 ] = self [[ utility::getsharedfunc( #"hash_f2451a0850e06732", #"hash_f2451a0850e06732" ) ]]( valid_locations, var_499f1feeb9d67e34, var_c37ce4e300923f51 );
        profilestop();
    }
    
    return [ valid_locations, var_499f1feeb9d67e34, var_c37ce4e300923f51 ];
}

// Namespace teddtasks
// Params 0
// Checksum 0x4d1fffbb, Offset: 0x3056
// Size: 0x2ed
function function_11956b77accdefca()
{
    s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
    
    if ( getdvar( @"hash_d1f265cf095ba53", "" ) != "" )
    {
        self.var_84a62ee7b6bedad = getdvar( @"hash_d1f265cf095ba53" );
    }
    
    if ( !isdefined( self.mdl_teddtasks ) )
    {
        if ( isdefined( level.gametypebundle.var_491e3a85ef39e784 ) )
        {
            self.mdl_teddtasks = content_manager::spawn_script_model( self, level.gametypebundle.var_491e3a85ef39e784, 1, 1 );
        }
        else if ( isdefined( s_bundle.model ) && !isdefined( self.var_84a62ee7b6bedad ) )
        {
            self.mdl_teddtasks = content_manager::spawn_script_model( self, s_bundle.model, 1, 1 );
        }
        else
        {
            self.mdl_teddtasks = spawnscriptable( self.var_84a62ee7b6bedad, self.origin, self.angles );
        }
    }
    
    self.mdl_teddtasks.unresolved_collision_func = &task_unresolved_collision;
    self.mdl_teddtasks.override_unresolved_collision = &task_override_unresolved_collision;
    
    if ( !isdefined( self.script_currency ) )
    {
        self.script_currency = level.magicbox_currency_type;
    }
    
    if ( !isdefined( self.radius ) )
    {
        self.radius = 96;
    }
    
    if ( !isdefined( self.script_cost ) )
    {
        self.script_cost = 500;
    }
    
    if ( !isdefined( self.mdl_teddtasks.interact ) )
    {
        fwd = anglestoforward( self.mdl_teddtasks.angles );
        interact_org = self.mdl_teddtasks.origin + fwd * 20;
        self.mdl_teddtasks.interact = interaction::register_interact( interact_org + ( 0, 0, 55 ), 60, &on_use_teddtask, undefined, undefined, undefined, undefined, "HINT_BUTTON" );
        self.mdl_teddtasks.interact setusefov( 80 );
        self.mdl_teddtasks.interact sethintonobstruction( "hide" );
        self.mdl_teddtasks.interact interaction::set_interact_hint_callback( &function_5ed3d43991500ce );
        self.mdl_teddtasks.interact interaction::function_3d5329c553924b3();
    }
    
    if ( self.mdl_teddtasks.interact tagexists( "tag_hint" ) )
    {
        self.mdl_teddtasks.interact sethinttag( "tag_hint" );
    }
    
    self.mdl_teddtasks.interact.s_teddtasks = self;
}

// Namespace teddtasks
// Params 1
// Checksum 0xf8e61159, Offset: 0x334b
// Size: 0x64d
function show_teddtask( b_immediate )
{
    level notify( #"task_deleted" );
    hide_teddtask( 1 );
    
    if ( self.deleting_task == 1 )
    {
        level waittill( #"task_deleted" );
    }
    
    function_11956b77accdefca();
    
    if ( utility::issharedfuncdefined( #"hash_1d7f6cc83b109f24", #"hash_1d7f6cc83b109f24" ) )
    {
        level [[ utility::getsharedfunc( #"hash_1d7f6cc83b109f24", #"hash_1d7f6cc83b109f24" ) ]]();
    }
    
    s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
    self.var_86cc9ebeeb479011 = 1;
    self.mdl_teddtasks.task_spawning = 1;
    
    if ( isdefined( self.mdl_teddtasks ) )
    {
        self.task_loading = 1;
        self.var_4a5149b7324cc691 = 1;
        
        if ( b_immediate )
        {
            self.mdl_teddtasks.unresolved_collision_func = &task_unresolved_collision;
            self.mdl_teddtasks.override_unresolved_collision = &task_override_unresolved_collision;
            self.mdl_teddtasks show();
            self.mdl_teddtasks.interact function_de48127d5b3b7e8c();
            self.task_loading = undefined;
        }
        else
        {
            self.mdl_teddtasks show();
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "on", "static" );
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient_audio", "spawn_in" );
            
            if ( self.script_parameters == "0" )
            {
                self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "cloud", "activate" );
                wait 1;
                self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "activate" );
            }
            else if ( self.script_parameters == "1" )
            {
                self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "cloud", "activate_half" );
                wait 1;
                self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "activate_half" );
            }
            else
            {
                self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "cloud", "activate_minimal" );
                wait 1;
                self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "activate_minimal" );
            }
            
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "spawn", "show" );
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "objective", "show" );
            wait 1.5;
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient_audio", "idle" );
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "model_and_collision", "show" );
            function_5c255c52a547a609();
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient", "show" );
            self.mdl_teddtasks.interact function_de48127d5b3b7e8c();
            self.task_loading = undefined;
        }
        
        self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "flipbook", "idle" );
        a_cols = function_3627db2cb6b33dfe( self.script_location );
        
        foreach ( col in a_cols )
        {
            col.unresolved_collision_func = &task_unresolved_collision;
            col.override_unresolved_collision = &task_override_unresolved_collision;
            col solid();
            col disconnectpaths();
        }
        
        self.mdl_teddtasks solid();
        self.mdl_teddtasks disconnectpaths();
        s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
        
        if ( isdefined( self.mdl_teddtasks.interact ) && isdefined( s_bundle ) )
        {
            function_c404e4ff729071ca();
            
            switch ( level.roundscale )
            {
                case 1:
                    self.script_cost = s_bundle.level1cost;
                    break;
                case 2:
                    self.script_cost = s_bundle.level2cost;
                    break;
                case 3:
                    self.script_cost = s_bundle.level3cost;
                    break;
                case 4:
                    self.script_cost = s_bundle.var_b2efa8663d73ce5d;
                    break;
            }
            
            self.mdl_teddtasks.interact interaction::set_interact_hint_callback( &function_5ed3d43991500ce );
            
            if ( isdefined( level.gametypebundle.var_491e3a85ef39e784 ) )
            {
                function_c337088ceb0b5c57( self.mdl_teddtasks );
            }
        }
        
        self.mdl_teddtasks.task_spawning = undefined;
        level notify( #"task_spawned" );
        zone_index = -1;
        zone_loc = getclosestpointonnavmesh( self.mdl_teddtasks.origin );
        
        if ( !isdefined( zone_loc ) )
        {
            zone_loc = self.mdl_teddtasks.origin;
        }
        
        zone = zone_manager::function_90e5c3e2272b0130( zone_loc );
        
        if ( isdefined( zone ) )
        {
            zone_index = level.calloutglobals.areaidmap[ zone.display_name ];
        }
        
        if ( !isdefined( zone_index ) )
        {
            zone_index = -1;
        }
        
        setomnvar( "ui_zm_current_trial_zone_index", zone_index );
        waitframe();
        thread function_8aa00e759afe9612();
        
        if ( level.gametypebundle.var_1f997f75ab03363a )
        {
            level.task_round_limit = randomintrange( 2, 5 );
        }
        else
        {
            level.task_round_limit = randomintrange( 2, 5 );
        }
        
        hud_util::showsplashtoall( "sat_zm_tedd_tasks_spawned" );
        var_7a56e95c47567b86 = utility::callsharedfunc( #"zombie", #"hash_896b88a46f6a4c15", "tedd" );
        self.var_7a56e95c47567b86 = var_7a56e95c47567b86;
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x1db9dca3, Offset: 0x39a0
// Size: 0x270
function function_8aa00e759afe9612()
{
    level endon( #"game_ended" );
    level endon( #"task_deleted" );
    maxdistance = 490000;
    heightstep = 200;
    level.var_dbeefd390ddc15be = 1;
    
    while ( isdefined( level.var_a3eb428773fa9129.mdl_teddtasks ) )
    {
        maxheight = 1000;
        currentheight = 0;
        level.var_dbeefd390ddc15be = 1;
        
        while ( currentheight <= maxheight )
        {
            upvector = anglestoup( level.var_a3eb428773fa9129.mdl_teddtasks.angles ) * currentheight;
            
            /#
            #/
            
            foreach ( player in level.players )
            {
                dist = distance2dsquared( player.origin, level.var_a3eb428773fa9129.mdl_teddtasks.origin + upvector );
                
                if ( dist <= maxdistance || level.var_fe14ab33acc04da3 )
                {
                    self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "off" );
                    level.var_dbeefd390ddc15be = undefined;
                }
            }
            
            if ( level.var_dbeefd390ddc15be && !level.var_fe14ab33acc04da3 )
            {
                if ( level.var_a3eb428773fa9129.script_parameters == "0" )
                {
                    level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "activate" );
                }
                else if ( level.var_a3eb428773fa9129.script_parameters == "1" )
                {
                    level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "activate_half" );
                }
                else
                {
                    level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "activate_minimal" );
                }
            }
            
            currentheight += heightstep;
            waitframe();
        }
        
        wait 0.1;
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x75a26418, Offset: 0x3c18
// Size: 0xa
function function_de48127d5b3b7e8c()
{
    self setusableenabled( 1 );
}

// Namespace teddtasks
// Params 1
// Checksum 0x61e11a48, Offset: 0x3c2a
// Size: 0x5ab
function hide_teddtask( b_immediate )
{
    level endon( #"task_deleted" );
    
    if ( isdefined( self.var_7a56e95c47567b86 ) )
    {
        self.var_7a56e95c47567b86 delete();
    }
    
    if ( isdefined( self.mdl_teddtasks ) )
    {
        if ( self.mdl_teddtasks.task_spawning )
        {
            return;
        }
        
        self.var_86cc9ebeeb479011 = 0;
        self.deleting_task = 1;
        level.var_4584d2a490bee346 = 0;
        level.var_b21212eb5055e9a5 = 0;
        level.var_69fd32cd84096bd4 = 0;
        self.mdl_teddtasks.interact setusableenabled( 0 );
        self.var_4a5149b7324cc691 = undefined;
        
        if ( b_immediate )
        {
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient", "off" );
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "spawn", "off" );
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "objective", "off" );
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "model_and_collision", "hide" );
            function_259156271c99e60a();
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "off" );
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "cloud", "off" );
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient_audio", "spawn_out" );
            
            if ( isdefined( self.mdl_teddtasks.objid ) )
            {
                if ( self.mdl_teddtasks.objid != -1 && !objidpoolmanager::function_fb05d646a96ed99e( self.mdl_teddtasks.objid ) )
                {
                    objidpoolmanager::update_objective_state( self.mdl_teddtasks.objid, "done" );
                    objidpoolmanager::returnobjectiveid( self.mdl_teddtasks.objid );
                }
            }
            
            if ( !isdefined( self.cheststruct ) )
            {
                a_cols = function_3627db2cb6b33dfe( self.script_location );
                
                foreach ( col in a_cols )
                {
                    col notsolid();
                    col connectpaths();
                }
            }
            
            self.mdl_teddtasks notsolid();
            self.mdl_teddtasks connectpaths();
            self.mdl_teddtasks hide();
            self.mdl_teddtasks delete();
        }
        else
        {
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient", "off" );
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "spawn", "off" );
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "objective", "off" );
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient_audio", "spawn_out" );
            wait 2;
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "model_and_collision", "hide" );
            function_259156271c99e60a();
            self.mdl_teddtasks notsolid();
            self.mdl_teddtasks connectpaths();
            
            if ( !isdefined( self.cheststruct ) )
            {
                a_cols = function_3627db2cb6b33dfe( self.script_location );
                
                foreach ( col in a_cols )
                {
                    col notsolid();
                    col connectpaths();
                }
            }
            
            if ( isdefined( self.cheststruct ) )
            {
                interactable_chest = self.cheststruct.chest;
                interactable_chest thread namespace_e9b9b9f95177a5c7::function_9275e2f3d8ac4142( self.cheststruct.chest_item, self.cheststruct.hint_data, self.cheststruct.reward_str, self.cheststruct.cleanup_call );
                self.cheststruct = undefined;
            }
            
            if ( isdefined( self.mdl_teddtasks.objid ) )
            {
                if ( self.mdl_teddtasks.objid != -1 && !objidpoolmanager::function_fb05d646a96ed99e( self.mdl_teddtasks.objid ) )
                {
                    objidpoolmanager::update_objective_state( self.mdl_teddtasks.objid, "done" );
                    objidpoolmanager::returnobjectiveid( self.mdl_teddtasks.objid );
                }
            }
            
            wait 2;
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "off" );
            wait 2;
            self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "cloud", "off" );
            wait 0.1;
            self.mdl_teddtasks notsolid();
            self.mdl_teddtasks connectpaths();
            self.mdl_teddtasks hide();
            self.mdl_teddtasks delete();
        }
        
        self.task_failed = undefined;
        self.deleting_task = undefined;
        level notify( #"task_deleted" );
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0x1bc2a27, Offset: 0x41dd
// Size: 0x84a
function function_ea7e65df624ea3d5( sparams )
{
    self endon( #"disconnect" );
    
    if ( isdefined( level.var_a3eb428773fa9129 ) )
    {
        if ( level.var_a3eb428773fa9129.mdl_teddtasks.task_spawning )
        {
            return;
        }
        
        level.var_a3eb428773fa9129.mdl_teddtasks.interact setusableenabled( 0 );
        level.var_a3eb428773fa9129.mdl_teddtasks delete();
        level.var_a3eb428773fa9129 function_11956b77accdefca();
        s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
        
        if ( isdefined( level.var_a3eb428773fa9129.mdl_teddtasks ) )
        {
            level.var_a3eb428773fa9129.mdl_teddtasks.unresolved_collision_func = &task_unresolved_collision;
            level.var_a3eb428773fa9129.mdl_teddtasks.override_unresolved_collision = &task_override_unresolved_collision;
            level.var_a3eb428773fa9129.mdl_teddtasks show();
            
            if ( level.var_a3eb428773fa9129.script_parameters == "0" )
            {
                level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "cloud", "activate_simple" );
                level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "activate" );
            }
            else if ( level.var_a3eb428773fa9129.script_parameters == "1" )
            {
                level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "cloud", "activate_half_simple" );
                level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "activate_half" );
            }
            else
            {
                level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "cloud", "activate_minimal_simple" );
                level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "activate_minimal" );
            }
            
            if ( level.var_fd94a3cfab1edb0 )
            {
                level.var_a3eb428773fa9129.mdl_teddtasks.interact setusableenabled( 0 );
                level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "active", "activate" );
                level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient_audio", "active_simple" );
            }
            else
            {
                level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient_audio", "idle" );
                level.var_a3eb428773fa9129.mdl_teddtasks.interact function_de48127d5b3b7e8c();
            }
            
            level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "objective", "show" );
            level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "model_and_collision", "show" );
            level.var_a3eb428773fa9129 function_5c255c52a547a609();
            level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient", "show_simple" );
            level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "flipbook", "idle" );
            a_cols = function_3627db2cb6b33dfe( level.var_a3eb428773fa9129.script_location );
            
            foreach ( col in a_cols )
            {
                col.unresolved_collision_func = &task_unresolved_collision;
                col.override_unresolved_collision = &task_override_unresolved_collision;
                col solid();
                col disconnectpaths();
            }
            
            level.var_a3eb428773fa9129.mdl_teddtasks solid();
            level.var_a3eb428773fa9129.mdl_teddtasks disconnectpaths();
            s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
            
            if ( isdefined( level.var_a3eb428773fa9129.mdl_teddtasks.interact ) && isdefined( s_bundle ) )
            {
                level.var_a3eb428773fa9129.mdl_teddtasks.interact interaction::set_interact_hint_callback( &function_5ed3d43991500ce );
            }
            
            zone_index = -1;
            zone_loc = getclosestpointonnavmesh( level.var_a3eb428773fa9129.mdl_teddtasks.origin );
            
            if ( !isdefined( zone_loc ) )
            {
                zone_loc = level.var_a3eb428773fa9129.mdl_teddtasks.origin;
            }
            
            zone = level.var_a3eb428773fa9129 zone_manager::function_90e5c3e2272b0130( zone_loc );
            
            if ( isdefined( zone ) )
            {
                zone_index = level.calloutglobals.areaidmap[ zone.display_name ];
            }
            
            if ( !isdefined( zone_index ) )
            {
                zone_index = -1;
            }
            
            setomnvar( "ui_zm_current_trial_zone_index", zone_index );
            
            if ( level.var_38e41e5bcaec2a1d )
            {
                level.var_a3eb428773fa9129 waittill( #"hash_c9f662e8d01eeb9b" );
                setomnvar( "ui_zm_current_trial_id", level.var_8cff5e93e7f5e8.var_7c00f823b7c297d4 + 1 );
                setomnvar( "ui_zm_current_trial_type", level.var_8cff5e93e7f5e8.var_19cd9b8d08f8a7c9 + 1 );
                
                foreach ( player in level.players )
                {
                    if ( player getclientomnvar( "ui_zm_current_trial_status" ) != 1 )
                    {
                        player setclientomnvar( "ui_zm_current_trial_status", 1 );
                        player setclientomnvar( "ui_zm_current_trial_status_notify", gettime() );
                    }
                }
                
                setomnvar( "ui_zm_current_trial_time", 0 );
                setomnvar( "ui_zm_current_trial_time_notify", gettime() );
                setomnvar( "ui_zm_current_trial_time_frozen", 0 );
                setomnvar( "ui_zm_current_trial_mastery_progress", level.tedd_task_progress );
                setomnvar( "ui_zm_current_trial_mastery_progress_max", int( level.mastery_rank ) );
                level function_e9e1e5f03716ae0f();
            }
            else if ( level.var_fd94a3cfab1edb0 )
            {
                if ( isdefined( level.var_8cff5e93e7f5e8 ) )
                {
                    setomnvar( "ui_zm_current_trial_id", level.var_8cff5e93e7f5e8.var_7c00f823b7c297d4 + 1 );
                    setomnvar( "ui_zm_current_trial_type", level.var_8cff5e93e7f5e8.var_19cd9b8d08f8a7c9 + 1 );
                    
                    foreach ( player in level.players )
                    {
                        if ( player getclientomnvar( "ui_zm_current_trial_status" ) != 1 )
                        {
                            player setclientomnvar( "ui_zm_current_trial_status", 1 );
                            player setclientomnvar( "ui_zm_current_trial_status_notify", gettime() );
                        }
                    }
                    
                    setomnvar( "ui_zm_current_trial_time", level.var_77be3669189a4fe3 );
                    setomnvar( "ui_zm_current_trial_time_notify", gettime() );
                    setomnvar( "ui_zm_current_trial_time_frozen", 0 );
                    setomnvar( "ui_zm_current_trial_mastery_progress", level.tedd_task_progress );
                    setomnvar( "ui_zm_current_trial_mastery_progress_max", int( level.mastery_rank ) );
                    level function_e9e1e5f03716ae0f();
                }
            }
            
            waitframe();
        }
    }
}

// Namespace teddtasks
// Params 1, eflags: 0x4
// Checksum 0xe5ae6972, Offset: 0x4a2f
// Size: 0x100
function private on_spawn_teddtask( instance )
{
    var_60be27428dad0213 = instance;
    var_93e4a0a8514ca47e = instance.targetname;
    
    if ( !isdefined( level.a_s_teddtasks ) )
    {
        level.a_s_teddtasks = [];
    }
    
    level.a_s_teddtasks = arraycombineunique( level.a_s_teddtasks, [ var_60be27428dad0213 ] );
    level.var_31998b7ccf36d152[ var_93e4a0a8514ca47e ] = var_60be27428dad0213;
    a_cols = function_3627db2cb6b33dfe( instance.script_location );
    
    foreach ( col in a_cols )
    {
        col notsolid();
        col connectpaths();
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0x5deb29df, Offset: 0x4b37
// Size: 0xbc
function function_3627db2cb6b33dfe( script_loc )
{
    a_cols = [];
    var_5d90897eaecbeed3 = getentarray( "task_col", #targetname );
    
    if ( isdefined( var_5d90897eaecbeed3 ) )
    {
        foreach ( task_col in var_5d90897eaecbeed3 )
        {
            if ( task_col.script_location == script_loc )
            {
                a_cols[ a_cols.size ] = task_col;
            }
        }
    }
    
    return a_cols;
}

// Namespace teddtasks
// Params 2
// Checksum 0x8c1b4961, Offset: 0x4bfc
// Size: 0xb8
function task_unresolved_collision( hitent, penetration )
{
    hitent endon( #"death_or_disconnect" );
    
    if ( isplayer( hitent ) && isalive( hitent ) )
    {
        if ( isdefined( level.var_a3eb428773fa9129.mdl_teddtasks.angles ) )
        {
            forwardangle = anglestoforward( level.var_a3eb428773fa9129.mdl_teddtasks.angles );
            
            if ( isdefined( forwardangle ) )
            {
                forwardvec = vectornormalize( forwardangle );
                
                if ( isdefined( forwardvec ) )
                {
                    hitent setorigin( hitent.origin + forwardvec * 64, 0 );
                }
            }
        }
    }
}

// Namespace teddtasks
// Params 2
// Checksum 0x37c6c048, Offset: 0x4cbc
// Size: 0x1f
function task_override_unresolved_collision( player, ballowsuicide )
{
    task_unresolved_collision( player, undefined );
}

// Namespace teddtasks
// Params 1
// Checksum 0x1a6da1a5, Offset: 0x4ce3
// Size: 0x125
function on_use_teddtask( player )
{
    if ( player.interactions_disabled )
    {
        return;
    }
    
    if ( player.var_2314a9263fbe04b9 )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_a3eb428773fa9129 ) )
    {
        return;
    }
    
    if ( isdefined( level.var_a3eb428773fa9129.task_loading ) )
    {
        return;
    }
    
    if ( isdefined( player ) && isdefined( self.s_teddtasks.script_currency ) && isdefined( self.s_teddtasks.script_cost ) )
    {
        if ( !player currency::attempt_purchase( self.s_teddtasks.script_currency, self.s_teddtasks.script_cost, undefined, undefined, #"magicbox" ) )
        {
            return;
        }
    }
    
    if ( isdefined( level.var_a3eb428773fa9129 ) && isdefined( player ) )
    {
        level.var_a3eb428773fa9129.var_37f3a4cd8252c9f0 = player;
    }
    
    if ( isdefined( self.s_teddtasks.mdl_teddtasks ) )
    {
        self.s_teddtasks.mdl_teddtasks thread function_f1f31c26130bea5b();
    }
}

// Namespace teddtasks
// Params 2, eflags: 0x4
// Checksum 0x4da79e91, Offset: 0x4e10
// Size: 0x201
function private function_5ed3d43991500ce( usable, player )
{
    s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
    
    if ( isdefined( player ) && isdefined( usable ) )
    {
        if ( player.interactions_disabled || player.var_2314a9263fbe04b9 )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        if ( isdefined( usable.s_teddtasks ) )
        {
            teddtask = usable.s_teddtasks;
            hintstring_obj = { #icon_text_value:teddtask.script_cost, #var_776a268784e089af:s_bundle.var_896c522ebda5d26b, #icon:s_bundle.var_e3bf65edeca285e, #description:s_bundle.var_9b8424046d25022c, #buttoncallout:s_bundle.var_e4e8a2d45e333293, #title:s_bundle.var_e6f7d2cea8dd392d, #params:[ teddtask.script_cost ], #type:"HINT_BUTTON" };
            
            if ( player currency::can_afford( teddtask.script_currency, teddtask.script_cost ) )
            {
                hintstring_obj.string = &"TRIALS/TRIAL_ACTIVATE_GENERIC";
                return hintstring_obj;
            }
            else
            {
                hintstring_obj.aux_text = s_bundle.var_f0c4b156ae620bcc;
                hintstring_obj.var_776a268784e089af = s_bundle.var_a9325a4692c22dca;
                hintstring_obj.interactable = 0;
                hintstring_obj.string = &"TRIALS/TRIAL_NOT_ENOUGH_ESSENCE_GENERIC";
                return hintstring_obj;
            }
        }
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace teddtasks
// Params 30
// Checksum 0x1b386a13, Offset: 0x501a
// Size: 0x293
function function_d8e253939842fa25( hash_title, str_challenge_name, n_challenge_type_id, n_challenge_id, var_eae75eeed3b54a3d, var_eae75beed3b543a4, var_eae75ceed3b545d7, var_eae759eed3b53f3e, var_d250a8a38be13e37, var_94ef8310ba429cba, var_95126d10ba68b410, var_b20b97cf2f99e58e, var_550074b1274cf10f, var_a42c54f869445e0c, var_a42c57f8694464a5, var_a42c56f869446272, var_a42c51f869445773, var_3f77d5fa92c1edbb, var_7a8f8c60006edb29, var_f258025b0635658, var_874c2879dc7ec22b, b_start_task, func_begin, var_1ac8ec3543ec9fa6, var_d0e631fd03498040, var_48513829d1f2cb20, var_83417edbb9168097, var_4b982a86540b7193, var_141fa4ee9eaf198b, var_777eba4f39e3c87d )
{
    if ( !( isdefined( func_begin ) && isdefined( var_1ac8ec3543ec9fa6 ) ) )
    {
        return;
    }
    
    var_5dc3a271f3cb3d31 = { #var_141fa4ee9eaf198b:var_141fa4ee9eaf198b, #var_777eba4f39e3c87d:var_777eba4f39e3c87d, #fn_custom:var_4b982a86540b7193, #e_waypoint_obj:var_83417edbb9168097, #var_d19cfc327f3899a1:var_48513829d1f2cb20, #var_49db79060a915125:var_d0e631fd03498040, #fn_end:var_1ac8ec3543ec9fa6, #fn_begin:func_begin, #var_b0d851194bdb1a0f:b_start_task, #str_unique_name:var_874c2879dc7ec22b, #b_kill_challenge:var_f258025b0635658, #var_1bbfedd55ef1a7ae:var_7a8f8c60006edb29, #var_d4b4bbc33aaa2ac8:var_b20b97cf2f99e58e, #var_3f77d5fa92c1edbb:var_3f77d5fa92c1edbb, #var_ea032a4b836e0865:var_a42c51f869445773, #var_ea03234b836df900:var_a42c56f869446272, #var_ea03244b836dfb33:var_a42c57f8694464a5, #var_ea03254b836dfd66:var_a42c54f869445e0c, #var_a58b9f66285b1c55:var_550074b1274cf10f, #var_2e99a503f8dbc90a:var_95126d10ba68b410, #var_2ebc8f03f901e060:var_94ef8310ba429cba, #n_time_scalar:var_d250a8a38be13e37, #var_51379032d0af2dfc:var_eae759eed3b53f3e, #var_51378f32d0af2bc9:var_eae75ceed3b545d7, #var_51378e32d0af2996:var_eae75beed3b543a4, #var_51378d32d0af2763:var_eae75eeed3b54a3d, #var_7c00f823b7c297d4:n_challenge_id, #var_19cd9b8d08f8a7c9:n_challenge_type_id, #str_name:str_challenge_name, #var_c2afe1a671205584:hash_title };
    level.var_f30ca8dcd3d76b94 = arraycombineunique( level.var_f30ca8dcd3d76b94, [ var_5dc3a271f3cb3d31 ] );
}

// Namespace teddtasks
// Params 0
// Checksum 0x4f629a6f, Offset: 0x52b5
// Size: 0x26b
function function_f1f31c26130bea5b()
{
    self endon( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
    objicon = "ui_icon_zm_tasks_icon_backer_blue_with_TEDD_task_machine";
    
    if ( isdefined( s_bundle.objectiveicon ) )
    {
        objicon = s_bundle.objectiveicon;
    }
    
    if ( level.var_8cff5e93e7f5e8.e_waypoint_obj != "invalid" )
    {
        self.objid = objidpoolmanager::requestobjectiveid();
        
        if ( isdefined( self.objid ) )
        {
            if ( self.objid != -1 )
            {
                objidpoolmanager::objective_set_play_intro( self.objid, 1 );
                objidpoolmanager::objective_set_play_outro( self.objid, 1 );
                objective_setbackground( self.objid, 1 );
                
                if ( level.var_8cff5e93e7f5e8.e_waypoint_obj == "zone" )
                {
                    task_loc = undefined;
                    a_waypoint = utility::getstructarray( "task_waypoint", "script_noteworthy" );
                    
                    foreach ( waypoint in a_waypoint )
                    {
                        if ( waypoint.targetname == level.var_a3eb428773fa9129.targetname )
                        {
                            task_loc = waypoint;
                        }
                    }
                    
                    if ( isdefined( task_loc ) )
                    {
                        objective_setbackground( self.objid, 1 );
                        objidpoolmanager::function_586b631e7bbb592a( self.objid, 0 );
                    }
                }
                else if ( level.var_8cff5e93e7f5e8.e_waypoint_obj == "local" )
                {
                    objidpoolmanager::objective_add_objective( self.objid, "current", self.origin + ( 0, 0, 120 ), objicon, "icon_small" );
                    objidpoolmanager::function_de3fb937d4f45f38( self.objid, 350, 170 );
                    objective_setbackground( self.objid, 1 );
                }
            }
        }
    }
    
    utility::function_7c10ea82c1e305b8( "flipbook", "active" );
    thread begin_task( level.var_8cff5e93e7f5e8 );
}

// Namespace teddtasks
// Params 1
// Checksum 0xd80d989d, Offset: 0x5528
// Size: 0x6a0
function begin_task( var_5dc3a271f3cb3d31 )
{
    if ( !( isdefined( level.var_a3eb428773fa9129 ) && isdefined( level.var_a3eb428773fa9129.mdl_teddtasks ) ) )
    {
        return;
    }
    
    level utility::flag_clear( "rbz_allow_exfil" );
    level.var_fd94a3cfab1edb0 = 1;
    level.var_38e41e5bcaec2a1d = 1;
    
    if ( isdefined( level.var_a3eb428773fa9129.mdl_teddtasks.interact ) )
    {
        level.var_a3eb428773fa9129.mdl_teddtasks.interact setusableenabled( 0 );
    }
    
    level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "active", "activate" );
    level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient_audio", "active" );
    
    if ( !isdefined( var_5dc3a271f3cb3d31 ) )
    {
        zone = level.var_a3eb428773fa9129 zone_manager::function_90e5c3e2272b0130( level.var_a3eb428773fa9129.origin );
        assert( isdefined( var_5dc3a271f3cb3d31 ), "<dev string:x24>" + level.var_6781718da4f78d1c.roundnumber + "<dev string:x69>" + zone.display_name );
        var_5dc3a271f3cb3d31 = level.tedd_challenges[ 0 ];
    }
    
    level.var_885dd881b6fcc525 = [];
    function_57c54c0a6db240f7();
    
    if ( isdefined( level.var_a3eb428773fa9129.var_37f3a4cd8252c9f0 ) )
    {
        foreach ( player in level.players )
        {
            player thread hud_message::showsplash( "sat_zm_tedd_tasks_initiated", 0, level.var_a3eb428773fa9129.var_37f3a4cd8252c9f0 );
        }
        
        if ( isdefined( var_5dc3a271f3cb3d31 ) && isdefined( level.var_a3eb428773fa9129 ) )
        {
            level.var_a3eb428773fa9129.var_37f3a4cd8252c9f0 callback::callback( "teddtask_used", { #round_scaler:level.roundscale, #cost:level.var_a3eb428773fa9129.script_cost, #currency:level.var_a3eb428773fa9129.script_currency, #var_7c00f823b7c297d4:var_5dc3a271f3cb3d31.var_7c00f823b7c297d4, #var_19cd9b8d08f8a7c9:var_5dc3a271f3cb3d31.var_19cd9b8d08f8a7c9, #var_c2afe1a671205584:var_5dc3a271f3cb3d31.var_c2afe1a671205584, #player:level.var_a3eb428773fa9129.var_37f3a4cd8252c9f0 } );
        }
    }
    
    setup_scorestreak_task( var_5dc3a271f3cb3d31 );
    waitframe();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"tasks" );
    level thread overlord::playevent( level.var_8cff5e93e7f5e8.var_141fa4ee9eaf198b, function_bc01a392b11e1af6(), 1 );
    level.var_a3eb428773fa9129.var_41c88f190b4433e = 1;
    zone_index = -1;
    zone = level.var_a3eb428773fa9129 zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( level.var_a3eb428773fa9129.origin ) );
    
    if ( isdefined( zone ) )
    {
        zone_index = level.calloutglobals.areaidmap[ zone.display_name ];
    }
    
    if ( !isdefined( zone_index ) )
    {
        zone_index = -1;
    }
    
    setomnvar( "ui_zm_current_trial_zone_index", zone_index );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_zm_current_trial_status", 1 );
        player setclientomnvar( "ui_zm_current_trial_status_notify", gettime() );
        
        if ( !player callback::exists( #"player_death", &function_1096404509b6527b ) )
        {
            player callback::add( #"player_death", &function_1096404509b6527b );
        }
    }
    
    ui::lui_registercallback( "trials_ui_tracker_showing", &function_947f2b5cff5cbd7c );
    level.var_a3eb428773fa9129 waittill( #"hash_fe551c249c55c786" );
    level.var_38e41e5bcaec2a1d = undefined;
    
    if ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"ol_tessie_race" || level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"hash_118650abf6b05f4f" )
    {
        function_5baaaa47135fa58e();
    }
    
    if ( isdefined( level.var_8cff5e93e7f5e8.fn_begin ) )
    {
        level thread [[ level.var_8cff5e93e7f5e8.fn_begin ]]();
    }
    
    if ( !( isdefined( level.var_a3eb428773fa9129 ) && isdefined( level.var_a3eb428773fa9129.mdl_teddtasks ) ) )
    {
        end_task();
        return;
    }
    
    setomnvar( "ui_zm_current_trial_time", level.challenge_time );
    setomnvar( "ui_zm_current_trial_time_notify", gettime() );
    setomnvar( "ui_zm_current_trial_time_frozen", 0 );
    var_f9073b9a68fe2fe = level.challenge_time + 1;
    level.var_77be3669189a4fe3 = var_f9073b9a68fe2fe;
    thread function_5fff597ce88f56e7();
    level callback::callback( "teddtask_begin", { #s_active_task:level.var_a3eb428773fa9129 } );
    
    while ( level.var_77be3669189a4fe3 > 0 )
    {
        if ( isdefined( level.mastery_achieved ) && level.mastery_achieved )
        {
            break;
        }
        
        if ( !level.var_a3eb428773fa9129.var_d9d7f9ce3106b5a5 )
        {
            level.var_77be3669189a4fe3 -= 1;
        }
        
        wait 1;
    }
    
    params = spawnstruct();
    params.var_c2afe1a671205584 = var_5dc3a271f3cb3d31.var_c2afe1a671205584;
    params.var_19cd9b8d08f8a7c9 = var_5dc3a271f3cb3d31.var_19cd9b8d08f8a7c9;
    params.var_7c00f823b7c297d4 = var_5dc3a271f3cb3d31.var_7c00f823b7c297d4;
    params.mastery_achieved = istrue( level.mastery_achieved );
    params.round_scaler = level.roundscale;
    level callback::callback( "tedd_task_end", params );
    end_task();
}

// Namespace teddtasks
// Params 1
// Checksum 0x8a032074, Offset: 0x5bd0
// Size: 0x27
function function_1096404509b6527b( params )
{
    self setclientomnvar( "ui_zm_current_trial_status", 0 );
    self setclientomnvar( "ui_zm_current_trial_status_notify", gettime() );
}

// Namespace teddtasks
// Params 1
// Checksum 0xd784c4ea, Offset: 0x5bff
// Size: 0x2d
function function_947f2b5cff5cbd7c( index )
{
    if ( isdefined( level.var_a3eb428773fa9129 ) )
    {
        level.var_a3eb428773fa9129 notify( #"hash_fe551c249c55c786" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x832b1e84, Offset: 0x5c34
// Size: 0x2e
function function_5fff597ce88f56e7()
{
    level endon( #"game_ended" );
    level endon( #"task_ended" );
    
    while ( function_599ed71d54c4c3f8() )
    {
        waitframe();
    }
    
    thread interrupt_task();
}

// Namespace teddtasks
// Params 0
// Checksum 0x8b2fd8f0, Offset: 0x5c6a
// Size: 0x1e5
function interrupt_task()
{
    if ( isdefined( level.var_a3eb428773fa9129.mdl_teddtasks.objid ) )
    {
        if ( level.var_a3eb428773fa9129.mdl_teddtasks.objid != -1 && !objidpoolmanager::function_fb05d646a96ed99e( self.mdl_teddtasks.objid ) )
        {
            objidpoolmanager::update_objective_state( level.var_a3eb428773fa9129.mdl_teddtasks.objid, "done" );
            objidpoolmanager::returnobjectiveid( self.mdl_teddtasks.objid );
        }
    }
    
    foreach ( player in level.players )
    {
        if ( level.var_a3eb428773fa9129.var_37f3a4cd8252c9f0 == player && isalive( player ) )
        {
            current_essence = player currency::get_currency_amount( level.var_a3eb428773fa9129.script_currency );
            
            if ( isdefined( current_essence ) )
            {
                player currency::set_currency_amount( level.var_a3eb428773fa9129.script_currency, current_essence + level.var_a3eb428773fa9129.script_cost );
            }
        }
        
        player setclientomnvar( "ui_zm_current_trial_status", 0 );
        player setclientomnvar( "ui_zm_current_trial_status_notify", gettime() );
    }
    
    hud_util::showsplashtoall( "sat_zm_tedd_tasks_interrupted" );
    level thread overlord::playevent( #"hash_d5cc35c5c9000d4d", function_bc01a392b11e1af6(), 1.5 );
    thread end_task( 1 );
}

// Namespace teddtasks
// Params 0
// Checksum 0xed87b063, Offset: 0x5e57
// Size: 0x15
function igc_start_func()
{
    level val::set( "task_default_igc", "task_logic_activate", 0 );
}

// Namespace teddtasks
// Params 0
// Checksum 0xd81d1c52, Offset: 0x5e74
// Size: 0x14
function igc_end_func()
{
    level val::reset( "task_default_igc", "task_logic_activate" );
}

// Namespace teddtasks
// Params 1
// Checksum 0x6412083e, Offset: 0x5e90
// Size: 0x7e6
function end_task( var_2274cdf01688dac3 )
{
    level endon( #"game_ended" );
    level notify( #"task_ended" );
    
    if ( !isdefined( level.var_a3eb428773fa9129 ) )
    {
        return;
    }
    
    level.var_a3eb428773fa9129.var_41c88f190b4433e = undefined;
    level.var_a3eb428773fa9129.cheststruct = undefined;
    
    if ( level.mastery_achieved )
    {
        wait 2;
    }
    
    s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
    
    if ( !( isdefined( level.var_fd94a3cfab1edb0 ) && isdefined( level.var_a3eb428773fa9129 ) ) )
    {
        return;
    }
    
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"tasks" );
    
    if ( isdefined( level.var_8cff5e93e7f5e8.fn_end ) )
    {
        result = level [[ level.var_8cff5e93e7f5e8.fn_end ]]();
    }
    else
    {
        result = 0;
    }
    
    per_grade = result / level.mastery_rank * 100;
    endstatus = 0;
    loot_level = 0;
    
    if ( !isdefined( level.var_a3eb428773fa9129.mdl_teddtasks ) )
    {
        return;
    }
    
    if ( per_grade < s_bundle.var_f3fea6b3e058e8c0 )
    {
        level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "flipbook", "fail" );
        endstatus = 2;
        level.var_a3eb428773fa9129.task_failed = 1;
        
        if ( !var_2274cdf01688dac3 )
        {
            level thread overlord::playevent( #"hash_44db123ad714392", function_bc01a392b11e1af6() );
        }
    }
    else
    {
        chest_item = s_bundle.var_c7002265bee68505;
        
        if ( per_grade < s_bundle.intermediatepercentage )
        {
            level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "flipbook", "rare" );
            loot_level = 1;
            chest_item = s_bundle.var_c7002265bee68505;
            
            if ( !var_2274cdf01688dac3 )
            {
                level thread overlord::playevent( #"hash_6c7d5f7edbe82d7c", function_bc01a392b11e1af6() );
            }
        }
        else if ( per_grade < s_bundle.masterypercentage )
        {
            level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "flipbook", "epic" );
            loot_level = 2;
            chest_item = s_bundle.var_8ffbdb5b82e4551a;
            
            if ( !var_2274cdf01688dac3 )
            {
                level thread overlord::playevent( #"hash_ef362852d34468a0", function_bc01a392b11e1af6() );
            }
        }
        else
        {
            level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "flipbook", "legendary" );
            loot_level = 3;
            chest_item = s_bundle.var_6fdc3121083383a2;
            
            if ( !var_2274cdf01688dac3 )
            {
                level thread overlord::playevent( #"hash_1f7faa9e7ae50bae", function_bc01a392b11e1af6() );
            }
            
            foreach ( player in level.players )
            {
                player namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_taskforce" );
            }
        }
        
        level notify( #"tedd_task_result", loot_level );
        level notify( #"trial_result", loot_level );
        reward_str = get_loot_reward_list( loot_level, level.roundscale );
        chest = function_c5298f8ce7c4a4cb( level.var_a3eb428773fa9129.targetname );
        params = spawnstruct();
        params.loot_level = loot_level;
        params.chest = chest;
        params.struct = level.var_a3eb428773fa9129.targetname;
        level callback::callback( "teddtask_complete", params );
        
        if ( isdefined( chest ) && function_599ed71d54c4c3f8() )
        {
            cheststruct = spawnstruct();
            cheststruct.chest = chest;
            cheststruct.chest_item = chest_item;
            cheststruct.hint_data = { #type:"HINT_BUTTON", #string:&"TRIALS/CHEST_REWARD", #buttoncallout:s_bundle.var_bb6cdbc49010a5e1, #description:s_bundle.var_eafd4bd4d8beed23, #title:s_bundle.var_29309653d0deb647, #icon:s_bundle.var_1a7018c4af0fb1fe };
            cheststruct.reward_str = reward_str;
            cheststruct.cleanup_call = "task_spawned";
            level.var_a3eb428773fa9129.cheststruct = cheststruct;
        }
        
        endstatus = 3;
    }
    
    if ( function_599ed71d54c4c3f8() )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_zm_current_trial_status", endstatus );
            player setclientomnvar( "ui_zm_current_trial_status_notify", gettime() );
        }
    }
    
    thread task_hidden( 15 );
    
    foreach ( player in level.players )
    {
        if ( player callback::exists( #"player_death", &function_1096404509b6527b ) )
        {
            player callback::remove( #"player_death", &function_1096404509b6527b );
        }
    }
    
    if ( isdefined( level.var_885dd881b6fcc525 ) && level.var_885dd881b6fcc525.size > 0 )
    {
        foreach ( item in level.var_885dd881b6fcc525 )
        {
            if ( isdefined( item ) )
            {
                common_item::function_869d7676e359a627( item );
            }
        }
    }
    
    level.var_885dd881b6fcc525 = [];
    level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "active", "off" );
    level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "ambient_audio", "active_complete" );
    level.var_d1b86166c79a010b = level.var_a3eb428773fa9129;
    
    if ( isdefined( level.var_8cff5e93e7f5e8 ) )
    {
        level.var_b570c2056b285e27 = level.var_8cff5e93e7f5e8;
        
        if ( !isdefined( level.var_fec0dbcf6bc0c4be ) )
        {
            level.var_fec0dbcf6bc0c4be = [];
        }
        
        level.var_fec0dbcf6bc0c4be[ level.var_fec0dbcf6bc0c4be.size ] = level.var_8cff5e93e7f5e8;
    }
    
    level notify( #"task_ended" );
    level.var_8cff5e93e7f5e8 = undefined;
    level.var_a3eb428773fa9129 hide_teddtask( 0 );
    level utility::flag_set( "rbz_allow_exfil" );
    self.task_failed = undefined;
    level.var_a3eb428773fa9129 = undefined;
    level.var_fd94a3cfab1edb0 = undefined;
    level.var_55239d3fb3c08d7a = 0;
}

// Namespace teddtasks
// Params 1
// Checksum 0x518f2c6c, Offset: 0x667e
// Size: 0xa3
function function_c5298f8ce7c4a4cb( name )
{
    var_1fffbca07ddaae4e = utility::getstructarray( name, "targetname" );
    
    foreach ( location in var_1fffbca07ddaae4e )
    {
        if ( location.script_noteworthy == "task_chest" )
        {
            return location;
        }
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0xbf5de2a5, Offset: 0x6729
// Size: 0xb1
function remove_chest( chest )
{
    level utility::waittill_any( "task_spawned", chest.name );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_zm_current_trial_status", 0 );
        player setclientomnvar( "ui_zm_current_trial_status_notify", gettime() );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x3679439b, Offset: 0x67e2
// Size: 0xb
function task_completed()
{
    thread task_hidden( 10 );
}

// Namespace teddtasks
// Params 0
// Checksum 0xd689f500, Offset: 0x67f5
// Size: 0xb
function task_failed()
{
    thread task_hidden( 10 );
}

// Namespace teddtasks
// Params 1
// Checksum 0x9a8b93, Offset: 0x6808
// Size: 0xaa
function task_hidden( var_fc8737c768b62605 = undefined )
{
    if ( isdefined( var_fc8737c768b62605 ) )
    {
        wait var_fc8737c768b62605;
    }
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_zm_current_trial_status", 0 );
        player setclientomnvar( "ui_zm_current_trial_status_notify", gettime() );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x2b7c6d93, Offset: 0x68ba
// Size: 0x16d
function function_b6290cf8847b5d4a()
{
    foreach ( a_s_teddtasks in level.var_31998b7ccf36d152 )
    {
        var_93e4a0a8514ca47e = a_s_teddtasks.targetname;
        
        if ( isdefined( var_93e4a0a8514ca47e ) && var_93e4a0a8514ca47e == "teddtask_nyxara_noas" )
        {
            continue;
        }
        
        level.tedd_locations = arraycombineunique( level.tedd_locations, [ a_s_teddtasks ] );
        
        switch ( a_s_teddtasks.script_noteworthy )
        {
            case #"hash_445b5dfa2a170606":
                level.var_aa683977d9d7ac47 = arraycombineunique( level.var_aa683977d9d7ac47, [ a_s_teddtasks ] );
                break;
            case #"hash_822bc1d083b5aa9f":
                level.var_25a70c08764c4ac6 = arraycombineunique( level.var_25a70c08764c4ac6, [ a_s_teddtasks ] );
                break;
            case #"hash_927c40326f210c88":
                level.var_aa683977d9d7ac47 = arraycombineunique( level.var_aa683977d9d7ac47, [ a_s_teddtasks ] );
                level.var_25a70c08764c4ac6 = arraycombineunique( level.var_25a70c08764c4ac6, [ a_s_teddtasks ] );
                break;
        }
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0xb8c47f27, Offset: 0x6a2f
// Size: 0x12f, Type: bool
function function_6390d0ab6c539317( challenge )
{
    foreach ( relic_ref in challenge.var_777eba4f39e3c87d )
    {
        foreach ( relichash in level.active_relics )
        {
            if ( level.zm_relics[ relichash ] )
            {
                var_2153e39e051f5b91 = level.zm_relics[ relichash ];
                
                if ( relic_ref.ref == var_2153e39e051f5b91.ref )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace teddtasks
// Params 1
// Checksum 0x92104882, Offset: 0x6b67
// Size: 0x8a6
function on_round_start( var_8582cc5f29b6732c )
{
    if ( utility::issharedfuncdefined( #"hash_d042b9b95fefa1e", #"hash_d042b9b95fefa1e" ) )
    {
        level [[ utility::getsharedfunc( #"hash_d042b9b95fefa1e", #"hash_d042b9b95fefa1e" ) ]]();
    }
    
    if ( !function_599ed71d54c4c3f8() )
    {
        return;
    }
    
    if ( level.var_dc81f03d76612023 )
    {
        return;
    }
    
    if ( !isdefined( level.task_round_limit ) )
    {
        if ( level.gametypebundle.var_1f997f75ab03363a )
        {
            level.task_round_limit = randomintrange( 2, 5 );
        }
        else
        {
            level.task_round_limit = randomintrange( 2, 5 );
        }
    }
    
    if ( isdefined( level.var_6cd59946b7475e48 ) )
    {
        var_75035f2548f2dd38 = 2;
    }
    else
    {
        var_75035f2548f2dd38 = 4;
    }
    
    if ( isdefined( level.var_a72bccdabdf9d8 ) )
    {
        var_75035f2548f2dd38 = level.var_a72bccdabdf9d8;
    }
    
    if ( level.var_6781718da4f78d1c.roundnumber < var_75035f2548f2dd38 )
    {
        return;
    }
    
    if ( !isdefined( level.var_f30ca8dcd3d76b94 ) || level.var_f30ca8dcd3d76b94.size <= 0 )
    {
        return;
    }
    
    foreach ( var_71e3a46af0b727fa in level.var_f30ca8dcd3d76b94 )
    {
        if ( var_71e3a46af0b727fa.var_2ebc8f03f901e060 <= level.var_6781718da4f78d1c.roundnumber && var_71e3a46af0b727fa.var_2e99a503f8dbc90a >= level.var_6781718da4f78d1c.roundnumber && !arraycontains( level.tedd_challenges, var_71e3a46af0b727fa ) )
        {
            if ( isdefined( var_71e3a46af0b727fa.fn_custom ) )
            {
                if ( [[ var_71e3a46af0b727fa.fn_custom ]]() == 1 )
                {
                    level.tedd_challenges = arraycombineunique( level.tedd_challenges, [ var_71e3a46af0b727fa ] );
                }
                
                continue;
            }
            
            level.tedd_challenges = arraycombineunique( level.tedd_challenges, [ var_71e3a46af0b727fa ] );
        }
    }
    
    foreach ( challenge in level.tedd_challenges )
    {
        if ( !( challenge.var_2e99a503f8dbc90a >= 30 ) && challenge.var_2e99a503f8dbc90a < level.var_6781718da4f78d1c.roundnumber )
        {
            level.tedd_challenges = arrayremove( level.tedd_challenges, challenge );
            continue;
        }
        
        if ( function_6390d0ab6c539317( challenge ) )
        {
            level.tedd_challenges = arrayremove( level.tedd_challenges, challenge );
        }
    }
    
    if ( !isdefined( level.var_a3eb428773fa9129 ) && level.var_6781718da4f78d1c.roundnumber == var_75035f2548f2dd38 )
    {
        var_5fc14fa6494d9886 = [];
        var_a17936ae71c8e34a = [];
        var_5dc962ec09351611 = [];
        
        foreach ( a_s_teddtasks in level.var_31998b7ccf36d152 )
        {
            task_zone = zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( a_s_teddtasks.origin ) );
            var_a216e8aa5c6a0670 = 1;
            
            if ( isdefined( task_zone ) && utility::issharedfuncdefined( #"hash_be7eb02741915d95", #"hash_be7eb02741915d95" ) )
            {
                profilestart();
                var_a216e8aa5c6a0670 = self [[ utility::getsharedfunc( #"hash_be7eb02741915d95", #"hash_be7eb02741915d95" ) ]]( task_zone );
                profilestop();
            }
            
            if ( !var_a216e8aa5c6a0670 )
            {
                continue;
            }
            
            if ( a_s_teddtasks.script_start == 1 )
            {
                var_5fc14fa6494d9886 = arraycombineunique( var_5fc14fa6494d9886, [ a_s_teddtasks ] );
            }
            
            switch ( a_s_teddtasks.script_noteworthy )
            {
                case #"hash_445b5dfa2a170606":
                    if ( a_s_teddtasks.script_start == 1 )
                    {
                        var_5dc962ec09351611 = arraycombineunique( var_5dc962ec09351611, [ a_s_teddtasks ] );
                    }
                    
                    break;
                case #"hash_822bc1d083b5aa9f":
                    if ( a_s_teddtasks.script_start == 1 )
                    {
                        var_a17936ae71c8e34a = arraycombineunique( var_a17936ae71c8e34a, [ a_s_teddtasks ] );
                    }
                    
                    break;
                case #"hash_927c40326f210c88":
                    if ( a_s_teddtasks.script_start == 1 )
                    {
                        var_a17936ae71c8e34a = arraycombineunique( var_a17936ae71c8e34a, [ a_s_teddtasks ] );
                        var_5dc962ec09351611 = arraycombineunique( var_5dc962ec09351611, [ a_s_teddtasks ] );
                    }
                    
                    break;
            }
        }
        
        if ( var_5fc14fa6494d9886.size > 0 )
        {
            weight_array = [];
            start_tasks = [];
            
            foreach ( challenge in level.tedd_challenges )
            {
                if ( challenge.var_b0d851194bdb1a0f == 1 )
                {
                    if ( challenge.var_1bbfedd55ef1a7ae == 1 )
                    {
                        if ( var_a17936ae71c8e34a.size > 0 )
                        {
                            weight_array[ weight_array.size ] = challenge.var_a58b9f66285b1c55;
                            start_tasks[ start_tasks.size ] = challenge;
                        }
                        
                        continue;
                    }
                    
                    if ( challenge.b_kill_challenge == 1 )
                    {
                        if ( var_5dc962ec09351611.size > 0 )
                        {
                            weight_array[ weight_array.size ] = challenge.var_a58b9f66285b1c55;
                            start_tasks[ start_tasks.size ] = challenge;
                        }
                        
                        continue;
                    }
                    
                    weight_array[ weight_array.size ] = challenge.var_a58b9f66285b1c55;
                    start_tasks[ start_tasks.size ] = challenge;
                }
            }
            
            level.var_8cff5e93e7f5e8 = utility::random_weighted( start_tasks, weight_array );
            
            if ( level.var_8cff5e93e7f5e8.var_1bbfedd55ef1a7ae == 1 )
            {
                level.var_a3eb428773fa9129 = utility::array_random( var_a17936ae71c8e34a );
            }
            else if ( level.var_8cff5e93e7f5e8.b_kill_challenge == 1 )
            {
                level.var_a3eb428773fa9129 = utility::array_random( var_5dc962ec09351611 );
            }
            else if ( level.var_8cff5e93e7f5e8.str_unique_name != "" )
            {
                foreach ( location in var_5fc14fa6494d9886 )
                {
                    if ( location.targetname == level.var_8cff5e93e7f5e8.str_unique_name )
                    {
                        level.var_a3eb428773fa9129 = location;
                        break;
                    }
                }
            }
            else
            {
                level.var_a3eb428773fa9129 = utility::array_random( var_5fc14fa6494d9886 );
            }
            
            if ( isdefined( level.var_a3eb428773fa9129 ) )
            {
                level.var_a3eb428773fa9129 show_teddtask( 0 );
            }
            
            return;
        }
        
        function_8c7dd04aa844bd67();
        return;
    }
    
    if ( !isdefined( level.var_55239d3fb3c08d7a ) || isdefined( level.var_fd94a3cfab1edb0 ) )
    {
        level.var_55239d3fb3c08d7a = 0;
    }
    
    if ( !isdefined( level.var_fd94a3cfab1edb0 ) )
    {
        level.var_55239d3fb3c08d7a += 1;
        
        if ( isdefined( level.var_a3eb428773fa9129 ) )
        {
            if ( level.var_55239d3fb3c08d7a >= 3 )
            {
                level.var_d1b86166c79a010b = level.var_a3eb428773fa9129;
                level.var_8cff5e93e7f5e8 = undefined;
                level.var_a3eb428773fa9129 hide_teddtask( 0 );
                level.var_a3eb428773fa9129 = undefined;
                level.var_55239d3fb3c08d7a = 0;
                return;
            }
        }
        else if ( isdefined( level.var_6cd59946b7475e48 ) )
        {
            if ( level.var_55239d3fb3c08d7a >= 1 )
            {
                function_8c7dd04aa844bd67();
                level.var_55239d3fb3c08d7a = 0;
                return;
            }
        }
        else if ( level.var_55239d3fb3c08d7a >= level.task_round_limit )
        {
            function_8c7dd04aa844bd67();
            level.var_55239d3fb3c08d7a = 0;
            return;
        }
    }
    
    if ( isdefined( level.var_fd94a3cfab1edb0 ) )
    {
        level.var_55239d3fb3c08d7a = 0;
    }
}

// Namespace teddtasks
// Params 2
// Checksum 0x932cb333, Offset: 0x7415
// Size: 0x19f
function get_loot_reward_list( mastery, currentround )
{
    map_info_bundle = getactivemapinfobundle();
    
    if ( !isdefined( map_info_bundle ) )
    {
        return "zm_t10_items_lv1_resources";
    }
    
    switch ( currentround )
    {
        case 1:
            if ( mastery == 1 )
            {
                return map_info_bundle.var_b107f2c36ccb6854;
            }
            else if ( mastery == 2 )
            {
                return map_info_bundle.var_1c598ac15f407ed1;
            }
            else if ( mastery == 3 )
            {
                return map_info_bundle.var_35ac14f5598de5f1;
            }
            
            break;
        case 2:
            if ( mastery == 1 )
            {
                return map_info_bundle.var_40f9a96793bffc3d;
            }
            else if ( mastery == 2 )
            {
                return map_info_bundle.var_a79cc04e45505d68;
            }
            else if ( mastery == 3 )
            {
                return map_info_bundle.var_5c9188184fa3e88a;
            }
            
            break;
        case 3:
            if ( mastery == 1 )
            {
                return map_info_bundle.var_9bee7589669e2661;
            }
            else if ( mastery == 2 )
            {
                return map_info_bundle.var_5fe3f52b3948192c;
            }
            else if ( mastery == 3 )
            {
                return map_info_bundle.var_38c8f91cc6d2630e;
            }
            
            break;
        case 4:
            if ( mastery == 1 )
            {
                return map_info_bundle.var_90efd28510e019ba;
            }
            else if ( mastery == 2 )
            {
                return map_info_bundle.var_f2bccaf2c6d5c1b;
            }
            else if ( mastery == 3 )
            {
                return map_info_bundle.var_686a792bb5c37a4f;
            }
            
            break;
    }
    
    assert( currentround <= 4 && currentround > 0, "<dev string:x74>" );
    return "zm_t10_items_lv1_resources";
}

// Namespace teddtasks
// Params 5
// Checksum 0xaebea9d7, Offset: 0x75bd
// Size: 0x115
function function_f9276ae9d8fb81a3( rate, itemfn, itemname, count, origin )
{
    level endon( #"game_ended" );
    level endon( #"task_ended" );
    
    while ( true )
    {
        if ( !isdefined( level.var_885dd881b6fcc525 ) )
        {
            level.var_885dd881b6fcc525 = [];
        }
        
        level.var_885dd881b6fcc525 = function_5713d46873b29625( level.var_885dd881b6fcc525 );
        
        foreach ( player in level.players )
        {
            if ( level.var_885dd881b6fcc525.size < count )
            {
                level [[ itemfn ]]( itemname, count - level.var_885dd881b6fcc525.size, origin );
            }
        }
        
        wait rate;
    }
}

// Namespace teddtasks
// Params 3
// Checksum 0xa3afbbd2, Offset: 0x76da
// Size: 0x175
function function_f84a2dcb5ad013db( listbundlename, count, origin )
{
    if ( isdefined( listbundlename ) )
    {
        var_8b5270de14dff72e = common_item::items_selectfromlist( listbundlename, count );
    }
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        itemspawnentryname = var_8b5270de14dff72e[ i ];
        
        if ( !isdefined( itemspawnentryname ) )
        {
            continue;
        }
        
        itembundle = getscriptbundle( itemspawnentryname );
        assert( isdefined( itembundle ), "<dev string:xae>" + getxhashsourcename( itemspawnentryname ) );
        
        if ( !isdefined( itembundle ) )
        {
            continue;
        }
        
        if ( common_item::function_16e8c106491eeaca( itembundle ) == "weapon" )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( getclosestpointonnavmesh( origin + ( randomfloatrange( -20, 20 ), randomfloatrange( -20, 20 ), -25 ) ), ( 0, randomfloatrange( 0, 360 ), 0 ) );
            item = item_weapon::function_b960bc85ea91de14( itembundle, spawnoptions );
        }
        else
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( getclosestpointonnavmesh( origin + ( randomfloatrange( -20, 20 ), randomfloatrange( -20, 20 ), -25 ) ), ( 0, randomfloatrange( 0, 360 ), 0 ) );
            spawnoptions.dropindex = i;
            item = common_item::items_spawnitemfromscriptable( itembundle.scriptable, undefined, spawnoptions );
        }
        
        if ( !isdefined( level.var_885dd881b6fcc525 ) )
        {
            level.var_885dd881b6fcc525 = [];
        }
        
        level.var_885dd881b6fcc525[ level.var_885dd881b6fcc525.size ] = item;
    }
}

// Namespace teddtasks
// Params 3
// Checksum 0x4e267fae, Offset: 0x7857
// Size: 0x11a
function function_cb857dcf07f529d5( items, count, origin )
{
    itembundle = getscriptbundle( items );
    
    if ( isdefined( itembundle ) )
    {
        if ( !isdefined( level.var_885dd881b6fcc525 ) )
        {
            level.var_885dd881b6fcc525 = [];
        }
        
        for ( i = 0; i < count ; i++ )
        {
            if ( common_item::function_16e8c106491eeaca( itembundle ) == "weapon" )
            {
                spawnoptions = common_item::items_initspawnoptions_spawnfromposition( getclosestpointonnavmesh( origin + ( randomfloatrange( -20, 20 ), randomfloatrange( -20, 20 ), -25 ) ), ( 0, randomfloatrange( 0, 360 ), 0 ) );
                item = item_weapon::function_b960bc85ea91de14( itembundle, spawnoptions );
            }
            else
            {
                spawnoptions = common_item::items_initspawnoptions_spawnfromposition( getclosestpointonnavmesh( origin + ( randomfloatrange( -20, 20 ), randomfloatrange( -20, 20 ), -25 ) ), ( 0, randomfloatrange( 0, 360 ), 0 ) );
                item = common_item::items_spawnitemfromscriptable( itembundle.scriptable, undefined, spawnoptions );
            }
            
            level.var_885dd881b6fcc525[ level.var_885dd881b6fcc525.size ] = item;
        }
    }
}

// Namespace teddtasks
// Params 6
// Checksum 0xa8369a15, Offset: 0x7979
// Size: 0x72
function function_6c675068cc710601( listbundlename, var_e6e771ce10f5a6e1, origin, directitem, directcount, spawnrate )
{
    level endon( #"task_ended" );
    
    while ( true )
    {
        wait spawnrate;
        
        if ( isdefined( listbundlename ) )
        {
            function_f84a2dcb5ad013db( listbundlename, var_e6e771ce10f5a6e1, origin );
        }
        
        if ( isdefined( directitem ) )
        {
            function_cb857dcf07f529d5( directitem, directcount, origin );
        }
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0x76de5ede, Offset: 0x79f3
// Size: 0x40
function function_2944592f987dc720( activate )
{
    if ( activate )
    {
        level val::reset( "task_default_activation", "task_logic_activate" );
        return;
    }
    
    level val::set( "task_default_activation", "task_logic_activate", 0 );
    end_task();
}

// Namespace teddtasks
// Params 0
// Checksum 0x495f14b9, Offset: 0x7a3b
// Size: 0x367
function function_e9e1e5f03716ae0f()
{
    if ( !isdefined( level.var_a3eb428773fa9129.mdl_teddtasks ) || level.var_a3eb428773fa9129.var_d9d7f9ce3106b5a5 )
    {
        return;
    }
    
    s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
    level.tedd_task_progress = int( clamp( level.tedd_task_progress, 0, level.mastery_rank ) );
    setomnvar( "ui_zm_current_trial_mastery_progress", level.tedd_task_progress );
    per_grade = level.tedd_task_progress / level.mastery_rank * 100;
    
    if ( per_grade < s_bundle.var_f3fea6b3e058e8c0 )
    {
        level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "flipbook", "active" );
        return;
    }
    
    if ( per_grade < s_bundle.intermediatepercentage )
    {
        level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "flipbook", "rare" );
        
        if ( level.var_4584d2a490bee346 == 0 )
        {
            level thread overlord::playevent( #"hash_7afcb4b3b6608d07", function_bc01a392b11e1af6() );
            
            foreach ( player in level.players )
            {
                player playlocalsound( "uin_cer_zm_tasks_loot_upgrade_2" );
            }
            
            level.var_4584d2a490bee346 = 1;
        }
        
        return;
    }
    
    if ( per_grade < s_bundle.masterypercentage )
    {
        level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "flipbook", "epic" );
        
        if ( level.var_b21212eb5055e9a5 == 0 )
        {
            level thread overlord::playevent( #"hash_e7380002e0419e9a", function_bc01a392b11e1af6() );
            
            foreach ( player in level.players )
            {
                player playlocalsound( "uin_cer_zm_tasks_loot_upgrade_3" );
            }
            
            level.var_b21212eb5055e9a5 = 1;
        }
        
        return;
    }
    
    level.var_a3eb428773fa9129.mdl_teddtasks utility::function_7c10ea82c1e305b8( "flipbook", "legendary" );
    
    if ( level.var_69fd32cd84096bd4 == 0 )
    {
        level thread overlord::playevent( #"hash_503c36160cc931bd", function_bc01a392b11e1af6() );
        
        foreach ( player in level.players )
        {
            player playlocalsound( "uin_cer_zm_tasks_loot_upgrade_4" );
        }
        
        level.var_69fd32cd84096bd4 = 1;
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0xd98119e1, Offset: 0x7daa
// Size: 0x249
function setup_scorestreak_task( var_5dc3a271f3cb3d31 )
{
    if ( !isdefined( var_5dc3a271f3cb3d31 ) )
    {
        return;
    }
    
    level.var_96db6f3ebb5f208a = undefined;
    
    switch ( var_5dc3a271f3cb3d31.var_c2afe1a671205584 )
    {
        case #"mutant_injection_kills":
            level.var_96db6f3ebb5f208a = "zm_minj";
            break;
        case #"hash_ae8f9e6180549b26":
            level.var_96db6f3ebb5f208a = "toma_strike";
            break;
        case #"rcxd_kills":
            level.var_96db6f3ebb5f208a = "rcxd";
            break;
        case #"mangler_cannon_kills":
            level.var_96db6f3ebb5f208a = "mangler_cannon";
            var_87533acdd3a97df6 = 3;
            break;
        case #"hand_cannon_kills":
            level.var_96db6f3ebb5f208a = "hand_cannon";
            var_87533acdd3a97df6 = 10;
            break;
    }
    
    if ( isdefined( level.var_96db6f3ebb5f208a ) )
    {
        foreach ( player in level.players )
        {
            if ( player callback::exists( "on_crafting_item_success", &function_36854a4b5e3fc5b1 ) )
            {
                player callback::remove( "on_crafting_item_success", &function_36854a4b5e3fc5b1 );
            }
            
            player.var_54e4128b0929fa09 = player save_killstreak_name();
            
            if ( isdefined( player ) && !player.ismutantinjection )
            {
                if ( !isdefined( var_87533acdd3a97df6 ) )
                {
                    player namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( level.var_96db6f3ebb5f208a, "other", undefined, undefined, undefined, 1 );
                }
                else
                {
                    item_bundle_name = common_item_database::function_a4f0a21951180013( level.var_96db6f3ebb5f208a );
                    
                    if ( isdefined( item_bundle_name ) )
                    {
                        scriptable_name = getscriptbundlefieldvalue( item_bundle_name, #"scriptable" );
                        fake_scriptable = { #count:var_87533acdd3a97df6, #type:scriptable_name };
                        success = player common_item::function_2b5e2ff57d5f392( fake_scriptable, 0, 1 );
                    }
                }
            }
            
            player callback::add( "on_crafting_item_success", &function_36854a4b5e3fc5b1 );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x714a4827, Offset: 0x7ffb
// Size: 0x4a
function function_8a708daa6ff124dd()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_ca82f16b01d5c09e ) )
    {
        level callback::add( #"on_ai_killed", &function_ca82f16b01d5c09e );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x6f7f6144, Offset: 0x804d
// Size: 0x39
function function_cd47d47d696193f5()
{
    if ( level callback::exists( #"on_ai_killed", &function_ca82f16b01d5c09e ) )
    {
        level callback::remove( #"on_ai_killed", &function_ca82f16b01d5c09e );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x6eb3e3e8, Offset: 0x808f
// Size: 0x9c
function function_ca82f16b01d5c09e( params )
{
    if ( isplayer( params.eattacker ) || isdefined( params.eattacker.trap_scriptable ) || isdefined( params.eattacker.var_bd22ba6c600a23a3 ) )
    {
        utility::ent_flag_clear( "dark_aether_field_trap_kill" );
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xcbd1a18, Offset: 0x8133
// Size: 0x4a
function function_684e1dca7da979c9()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_3015609e6a140d52 ) )
    {
        level callback::add( #"on_ai_killed", &function_3015609e6a140d52 );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xac62aad4, Offset: 0x8185
// Size: 0x39
function function_eea5bf547c21e761()
{
    if ( level callback::exists( #"on_ai_killed", &function_3015609e6a140d52 ) )
    {
        level callback::remove( #"on_ai_killed", &function_3015609e6a140d52 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xbb8086ca, Offset: 0x81c7
// Size: 0x6d
function function_3015609e6a140d52( params )
{
    if ( isdefined( self.last_dmg_struct ) )
    {
        if ( self.last_dmg_struct.biscritical )
        {
            level.tedd_task_progress++;
            function_e9e1e5f03716ae0f();
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x3966e2eb, Offset: 0x823c
// Size: 0x4a
function function_6b6abc5a5beb79df()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_928fa655dc408c2c ) )
    {
        level callback::add( #"on_ai_killed", &function_928fa655dc408c2c );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x976d6543, Offset: 0x828e
// Size: 0x39
function function_5354f5b8f8f00e7f()
{
    if ( level callback::exists( #"on_ai_killed", &function_928fa655dc408c2c ) )
    {
        level callback::remove( #"on_ai_killed", &function_928fa655dc408c2c );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xddf96cb8, Offset: 0x82d0
// Size: 0x217
function function_928fa655dc408c2c( params )
{
    if ( isplayer( params.eattacker ) && function_1aa18656f47cace3( params.eattacker.currentweapon, params ) )
    {
        if ( params.sweapon.basename != "sat_mini_sentry_turret" && params.eattacker.currentweapon.basename != "sat_ww_locust_zm" )
        {
            if ( params.smeansofdeath != "MOD_MELEE" && !params.eattacker player::isplayerads() && ( params.sweapon.inventorytype == "primary" || params.sweapon.inventorytype == "secondary" || params.sweapon.inventorytype == "altmode" || params.sweapon.basename == "sat_ks_handcannon" ) && isdefined( params.sweapon ) && ( params.sweapon.type == "projectile" || params.sweapon.type == "bullet" ) || params.eattacker.primaryweapons[ 0 ].var_1616e6fbba9a722d == %"hash_612e1e9217f2bef8" || params.eattacker.primaryweapons[ 1 ].var_1616e6fbba9a722d == %"hash_612e1e9217f2bef8" )
            {
                level.tedd_task_progress++;
                function_e9e1e5f03716ae0f();
                
                if ( level.tedd_task_progress >= level.mastery_rank )
                {
                    level.mastery_achieved = 1;
                    level notify( #"task_ended" );
                }
            }
        }
    }
}

// Namespace teddtasks
// Params 2
// Checksum 0x985fe789, Offset: 0x84ef
// Size: 0xa6
function function_1aa18656f47cace3( weapon, params )
{
    if ( weapon.classname != "rocketlauncher" )
    {
        return 1;
    }
    
    if ( issubstr( weapon.basename, "sat_sl_crossbow_mp" ) || issubstr( weapon.basename, "sat_sl_sargas_mp" ) || issubstr( weapon.basename, "sat_ww_firefly" ) && params.smeansofdeath == "MOD_IMPACT" || issubstr( weapon.basename, "sat_pi_alcor_mp" ) )
    {
        return 1;
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x67a7cf5e, Offset: 0x859e
// Size: 0x4a
function function_66140ef554c6df7c()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_90f053fe9a129b3f ) )
    {
        level callback::add( #"on_ai_killed", &function_90f053fe9a129b3f );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x99557390, Offset: 0x85f0
// Size: 0x39
function function_e2568511c79bcc10()
{
    if ( level callback::exists( #"on_ai_killed", &function_90f053fe9a129b3f ) )
    {
        level callback::remove( #"on_ai_killed", &function_90f053fe9a129b3f );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x4a14ad9a, Offset: 0x8632
// Size: 0xe1
function function_90f053fe9a129b3f( params )
{
    if ( isplayer( params.eattacker ) || isdefined( params.eattacker.var_bd22ba6c600a23a3 ) )
    {
        if ( isplayer( params.eattacker ) && params.eattacker getstance() == "crouch" || isplayer( params.eattacker.var_bd22ba6c600a23a3 ) && params.eattacker.var_bd22ba6c600a23a3 getstance() == "crouch" )
        {
            level.tedd_task_progress++;
            function_e9e1e5f03716ae0f();
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x24395cdd, Offset: 0x871b
// Size: 0x55
function function_d577a3d8c0f7d058()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_18e10dd3b23fe803 ) )
    {
        level callback::add( #"on_ai_killed", &function_18e10dd3b23fe803 );
    }
    
    level.var_4326b3e09af8481e = 1;
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x998b6d93, Offset: 0x8778
// Size: 0x43
function function_d369a9bb111e0b8c()
{
    if ( level callback::exists( #"on_ai_killed", &function_18e10dd3b23fe803 ) )
    {
        level callback::remove( #"on_ai_killed", &function_18e10dd3b23fe803 );
    }
    
    level.var_4326b3e09af8481e = undefined;
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x54013bad, Offset: 0x87c4
// Size: 0xe1
function function_18e10dd3b23fe803( params )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( isdefined( params.eattacker.vehicle ) && params.eattacker.vehicle.targetname == "veh_cer_tactical_raft" || isdefined( params.eattacker.var_bd22ba6c600a23a3 ) && params.eattacker.vehicle.targetname == "veh_cer_tactical_raft" )
        {
            level.tedd_task_progress++;
            function_e9e1e5f03716ae0f();
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x98656d59, Offset: 0x88ad
// Size: 0x4a
function function_3b5902c939afd55f()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_d2ca128af33033ac ) )
    {
        level callback::add( #"on_ai_killed", &function_d2ca128af33033ac );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x86243965, Offset: 0x88ff
// Size: 0x39
function function_4d9eb9121831fdff()
{
    if ( level callback::exists( #"on_ai_killed", &function_d2ca128af33033ac ) )
    {
        level callback::remove( #"on_ai_killed", &function_d2ca128af33033ac );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xc7e8cd, Offset: 0x8941
// Size: 0xaf
function function_d2ca128af33033ac( params )
{
    if ( isplayer( params.eattacker ) || isdefined( params.eattacker.var_bd22ba6c600a23a3 ) )
    {
        if ( !params.eattacker vehicle::is_in_vehicle() )
        {
            if ( vectornormalize( params.eattacker getentityvelocity() ) == ( 0, 0, 0 ) )
            {
                level.tedd_task_progress++;
                function_e9e1e5f03716ae0f();
                
                if ( level.tedd_task_progress >= level.mastery_rank )
                {
                    level.mastery_achieved = 1;
                    level notify( #"task_ended" );
                }
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xbcf02661, Offset: 0x89f8
// Size: 0x8e
function function_6aae02a40e2e3c02()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_72f339375a9b139 ) )
    {
        level callback::add( #"on_ai_killed", &function_72f339375a9b139 );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
    
    if ( isdefined( level.var_a3eb428773fa9129.script_location ) )
    {
        enable_trigger_zones( level.var_a3eb428773fa9129.script_location, level.var_a3eb428773fa9129.script_location );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x20bb5237, Offset: 0x8a8e
// Size: 0x112
function function_5ac3d0ff7a600cd6()
{
    triggerzones = getentarray( level.var_a3eb428773fa9129.script_location, #targetname );
    disable_trigger_zones( triggerzones );
    var_fab2d9ee9393e74f = getentitylessscriptablearray( level.var_a3eb428773fa9129.script_location, #targetname );
    
    foreach ( var_bfb9424e344026e0 in var_fab2d9ee9393e74f )
    {
        var_bfb9424e344026e0 utility::function_7c10ea82c1e305b8( "chevron_0", "off" );
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_72f339375a9b139 ) )
    {
        level callback::remove( #"on_ai_killed", &function_72f339375a9b139 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x15509b1b, Offset: 0x8ba9
// Size: 0x230
function function_72f339375a9b139( params )
{
    if ( isplayer( params.eattacker ) || isdefined( params.eattacker.var_bd22ba6c600a23a3 ) || isdefined( params.eattacker.trap_scriptable ) || utility::ent_flag( "saw_blade_trap_kill" ) || utility::ent_flag( "flame_trap_kill" ) )
    {
        s_player_zone = params.eattacker zone_manager::get_current_zone();
        s_destination_zone = zone_manager::function_90e5c3e2272b0130( level.var_a3eb428773fa9129.origin );
        
        if ( function_618b63a16e7e0c81( level.var_a3eb428773fa9129.script_location, params.eattacker ) && function_618b63a16e7e0c81( level.var_a3eb428773fa9129.script_location, self ) || function_618b63a16e7e0c81( level.var_a3eb428773fa9129.script_location, params.eattacker ) && function_618b63a16e7e0c81( level.var_a3eb428773fa9129.script_location, self ) && params.einflictor.streakinfo.streakname == "chopper_gunner" || function_618b63a16e7e0c81( level.var_a3eb428773fa9129.script_location, params.einflictor.my_owner ) && utility::ent_flag( "saw_blade_trap_kill" ) || utility::ent_flag( "flame_trap_kill" ) && function_618b63a16e7e0c81( level.var_a3eb428773fa9129.script_location, params.einflictor.activator ) )
        {
            level.tedd_task_progress++;
            function_e9e1e5f03716ae0f();
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
        }
        
        utility::ent_flag_clear( "saw_blade_trap_kill" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xea351fe2, Offset: 0x8de1
// Size: 0x67
function function_89a4b9f9bc4fd568()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.var_a3eb428773fa9129.script_location ) )
    {
        enable_trigger_zones( level.var_a3eb428773fa9129.script_location, level.var_a3eb428773fa9129.script_location );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
    level thread function_dc023478555a849();
}

// Namespace teddtasks
// Params 0
// Checksum 0x3ca4865b, Offset: 0x8e50
// Size: 0xee
function function_35bb83a0bd23481c()
{
    triggerzones = getentarray( level.var_a3eb428773fa9129.script_location, #targetname );
    disable_trigger_zones( triggerzones );
    var_fab2d9ee9393e74f = getentitylessscriptablearray( level.var_a3eb428773fa9129.script_location, #targetname );
    
    foreach ( var_bfb9424e344026e0 in var_fab2d9ee9393e74f )
    {
        var_bfb9424e344026e0 utility::function_7c10ea82c1e305b8( "chevron_0", "off" );
    }
    
    level.task_zone_name = undefined;
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 0
// Checksum 0x9de7c590, Offset: 0x8f47
// Size: 0x102
function function_dc023478555a849()
{
    level endon( #"task_ended" );
    
    while ( level.tedd_task_progress <= level.mastery_rank )
    {
        foreach ( player in level.players )
        {
            if ( function_618b63a16e7e0c81( level.var_a3eb428773fa9129.script_location, player ) )
            {
                level.tedd_task_progress++;
                function_e9e1e5f03716ae0f();
                
                if ( level.tedd_task_progress >= level.mastery_rank )
                {
                    wait 2;
                    level.mastery_achieved = 1;
                    level notify( #"task_ended" );
                }
            }
        }
        
        wait 1;
        continue;
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x2c87445e, Offset: 0x9051
// Size: 0x8f
function function_fb620fbe86cd8684()
{
    level endon( #"game_ended" );
    function_14803fc9f713dd42( "specialty_phd_flopper" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_a75864dee731b8f7 ) )
    {
        level callback::add( #"on_ai_killed", &function_a75864dee731b8f7 );
    }
    
    if ( !level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" ) )
    {
        level callback::add( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x6effec59, Offset: 0x90e8
// Size: 0x7d
function function_3727ddd7fbe5ff88()
{
    function_1dab26efe8511860( "specialty_phd_flopper" );
    
    if ( level callback::exists( #"on_ai_killed", &function_a75864dee731b8f7 ) )
    {
        level callback::remove( #"on_ai_killed", &function_a75864dee731b8f7 );
    }
    
    if ( level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" ) )
    {
        level callback::remove( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xfd1be22b, Offset: 0x916e
// Size: 0xb9
function function_a75864dee731b8f7( params )
{
    if ( isplayer( params.eattacker ) && params.eattacker utility::ent_flag( "is_phd_flopping" ) )
    {
        if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_slider" ) && params.eattacker issprintsliding() )
        {
            return;
        }
        
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xac4af15e, Offset: 0x922f
// Size: 0x4a
function function_ded6319d67ebcb03()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_bb1d4fdeda416998 ) )
    {
        level callback::add( #"on_ai_killed", &function_bb1d4fdeda416998 );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xc7a530ce, Offset: 0x9281
// Size: 0x39
function function_3a52f6f62c763983()
{
    if ( level callback::exists( #"on_ai_killed", &function_bb1d4fdeda416998 ) )
    {
        level callback::remove( #"on_ai_killed", &function_bb1d4fdeda416998 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x81e3a021, Offset: 0x92c3
// Size: 0xcd
function function_bb1d4fdeda416998( params )
{
    if ( isplayer( params.eattacker ) || isdefined( params.eattacker.var_bd22ba6c600a23a3 ) )
    {
        if ( params.eattacker.origin[ 2 ] > self.origin[ 2 ] + 30 || params.einflictor.streakinfo.streakname == "chopper_gunner" )
        {
            level.tedd_task_progress++;
            function_e9e1e5f03716ae0f();
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x6ec895c2, Offset: 0x9398
// Size: 0x4a
function function_8ce0bffd8e864da7()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_1fb3df18bebc4964 ) )
    {
        level callback::add( #"on_ai_killed", &function_1fb3df18bebc4964 );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x59b8a379, Offset: 0x93ea
// Size: 0x39
function function_9434cfe0cdf72097()
{
    if ( level callback::exists( #"on_ai_killed", &function_1fb3df18bebc4964 ) )
    {
        level callback::remove( #"on_ai_killed", &function_1fb3df18bebc4964 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xd90ab16b, Offset: 0x942c
// Size: 0xa4
function function_1fb3df18bebc4964( params )
{
    if ( isplayer( params.eattacker ) || isdefined( params.eattacker.var_bd22ba6c600a23a3 ) )
    {
        if ( params.eattacker.origin[ 2 ] < self.origin[ 2 ] - 15 )
        {
            level.tedd_task_progress++;
            function_e9e1e5f03716ae0f();
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xc6b8127c, Offset: 0x94d8
// Size: 0xa0
function function_e6e754f384217673()
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        player powerups::powerup_activate( "full_armor" );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
    thread function_14935a551f83dd5a();
}

// Namespace teddtasks
// Params 0
// Checksum 0xc1904e00, Offset: 0x9580
// Size: 0xb
function function_403064dcbc4b84f3()
{
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 0
// Checksum 0x828bcb65, Offset: 0x9594
// Size: 0x107
function function_14935a551f83dd5a()
{
    level endon( #"game_ended" );
    level endon( #"task_ended" );
    
    while ( true )
    {
        wait 1;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.lastdamagedtime ) || gettime() - player.lastdamagedtime > 2000 )
            {
                level.tedd_task_progress++;
            }
        }
        
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            wait 2;
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
            break;
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x66f15aec, Offset: 0x96a3
// Size: 0x8f
function function_f68bfccf4cada9b2()
{
    level endon( #"game_ended" );
    function_14803fc9f713dd42( "specialty_m_mod" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_91803eede1d0a89 ) )
    {
        level callback::add( #"on_ai_killed", &function_91803eede1d0a89 );
    }
    
    if ( !level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_m_mod" ) )
    {
        level callback::add( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_m_mod" );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x3551baf8, Offset: 0x973a
// Size: 0x7d
function function_1ff7c578c7f8f086()
{
    function_1dab26efe8511860( "specialty_m_mod" );
    
    if ( level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_m_mod" ) )
    {
        level callback::remove( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_m_mod" );
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_91803eede1d0a89 ) )
    {
        level callback::remove( #"on_ai_killed", &function_91803eede1d0a89 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x3955d715, Offset: 0x97c0
// Size: 0x71
function function_91803eede1d0a89( params )
{
    if ( params.smeansofdeath == "MOD_MELEE" && isplayer( params.eattacker ) )
    {
        level.tedd_task_progress++;
    }
    
    function_e9e1e5f03716ae0f();
    
    if ( level.tedd_task_progress >= level.mastery_rank )
    {
        level.mastery_achieved = 1;
        level notify( #"task_ended" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xe260f63c, Offset: 0x9839
// Size: 0xb9
function function_da4b7f15133fb5da()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_37515cc6eae04a21 ) )
    {
        level callback::add( #"on_ai_killed", &function_37515cc6eae04a21 );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
    var_cff06ae231824dcb = 50 * anglestoforward( level.var_a3eb428773fa9129.angles );
    var_cff06ae231824dcb = var_cff06ae231824dcb + level.var_a3eb428773fa9129.origin + ( 0, 0, 30 );
    level thread function_f9276ae9d8fb81a3( 15, &function_f84a2dcb5ad013db, "zm_sat_items_equipment_lethal", level.players.size + 2, var_cff06ae231824dcb );
}

// Namespace teddtasks
// Params 0
// Checksum 0x4f9d69ba, Offset: 0x98fa
// Size: 0x39
function function_ad3a23d225ef295e()
{
    if ( level callback::exists( #"on_ai_killed", &function_37515cc6eae04a21 ) )
    {
        level callback::remove( #"on_ai_killed", &function_37515cc6eae04a21 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xc4613ff7, Offset: 0x993c
// Size: 0x174
function function_37515cc6eae04a21( params )
{
    equipmentref = equipment_mp::function_fdc4a655fbde0dec( params.sweapon.basename );
    
    if ( equipment_mp::isequipmentlethal( equipmentref ) || params.sweapon.basename == "sat_monkey_bomb_zm" || params.sweapon.basename == "sat_blackhole_bomb_zm" || params.sweapon.basename == "sat_cluster_grenade_zm" || params.sweapon.basename == "sat_cluster_grenade_submunition" || params.sweapon.basename == "t10_c4_mp" || params.sweapon.basename == "sat_mini_sentry_turret" || params.sweapon.basename == "cer_monkey_bomb_zm" || params.sweapon.basename == "cer_blackhole_bomb_zm" )
    {
        level.tedd_task_progress++;
    }
    
    function_e9e1e5f03716ae0f();
    
    if ( level.tedd_task_progress >= level.mastery_rank )
    {
        level.mastery_achieved = 1;
        level notify( #"task_ended" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x72fdc8d8, Offset: 0x9ab8
// Size: 0x4a
function function_70b5b2091ce8501f()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_7829ed74f704cc6c ) )
    {
        level callback::add( #"on_ai_killed", &function_7829ed74f704cc6c );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x7cd946d1, Offset: 0x9b0a
// Size: 0x135
function function_6c764d5043e3bdbf()
{
    foreach ( player in level.players )
    {
        killstreakstruct = player killstreaks::getkillstreakinslot( 1 );
        
        if ( isdefined( killstreakstruct ) && killstreakstruct.streakname == "zm_minj" && !level.var_c794ead7f61b085f )
        {
            player killstreaks::removekillstreak( 1 );
            player killstreaks::clearkillstreaks();
        }
        
        function_dfd7caa60e9b188d( player );
        
        if ( player callback::exists( "on_crafting_item_success", &function_36854a4b5e3fc5b1 ) )
        {
            player callback::remove( "on_crafting_item_success", &function_36854a4b5e3fc5b1 );
        }
        
        level.var_c794ead7f61b085f = 0;
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_7829ed74f704cc6c ) )
    {
        level callback::remove( #"on_ai_killed", &function_7829ed74f704cc6c );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x57f1ca94, Offset: 0x9c48
// Size: 0xaa
function function_7829ed74f704cc6c( params )
{
    if ( isdefined( params.einflictor.ismutantinjection ) )
    {
        level.tedd_task_progress++;
    }
    
    if ( isstring( params.einflictor.weapon ) )
    {
        if ( issubstr( params.einflictor.weapon, "la_mutant_injection_cannon_mp" ) )
        {
            level.tedd_task_progress++;
        }
    }
    
    function_e9e1e5f03716ae0f();
    
    if ( level.tedd_task_progress >= level.mastery_rank )
    {
        level.mastery_achieved = 1;
        level notify( #"task_ended" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xd5dca7a6, Offset: 0x9cfa
// Size: 0x14b
function save_killstreak_name()
{
    var_261d5c07fcbeedd7 = killstreaks::getkillstreakinslot( 1 );
    
    if ( isdefined( var_261d5c07fcbeedd7 ) )
    {
        streakname = var_261d5c07fcbeedd7.streakname;
        
        if ( isdefined( streakname ) )
        {
            item_bundle_name = common_item_database::function_a4f0a21951180013( streakname );
            
            if ( isdefined( item_bundle_name ) && getscriptbundlefieldvalue( item_bundle_name, #"useCountAsKillstreakAmmo" ) )
            {
                weaponname = var_261d5c07fcbeedd7.streaksetupinfo.weaponname;
                
                if ( isdefined( weaponname ) )
                {
                    if ( isdefined( self.pers[ "held_killstreak_init_count" ] ) )
                    {
                        var_261d5c07fcbeedd7.saved_ammo_count = self.pers[ "held_killstreak_init_count" ];
                    }
                    else if ( isdefined( self.pers[ "held_killstreak_clip_count" ][ weaponname ] ) && isdefined( self.pers[ "held_killstreak_ammo_count" ][ weaponname ] ) )
                    {
                        var_261d5c07fcbeedd7.saved_ammo_count = self.pers[ "held_killstreak_clip_count" ][ weaponname ] + ( self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] ?? 0 ) + ( function_fbb6adbc1a89658a( weaponname ) ? 0 : self.pers[ "held_killstreak_ammo_count" ][ weaponname ] );
                    }
                }
            }
        }
    }
    
    killstreaks::removekillstreak( 1 );
    killstreaks::clearkillstreaks();
    return var_261d5c07fcbeedd7;
}

// Namespace teddtasks
// Params 1
// Checksum 0x2ac99779, Offset: 0x9e4e
// Size: 0x8f
function function_dfd7caa60e9b188d( player )
{
    if ( !isdefined( player.var_54e4128b0929fa09.streakname ) )
    {
        return;
    }
    
    player namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( player.var_54e4128b0929fa09.streakname, "other", undefined, undefined, undefined, 1 );
    
    if ( isdefined( player.var_54e4128b0929fa09.saved_ammo_count ) )
    {
        player.pers[ "held_killstreak_init_count" ] = player.var_54e4128b0929fa09.saved_ammo_count;
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xb64404dd, Offset: 0x9ee5
// Size: 0x4a
function function_1347bd4edb73540b()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_b37cd69c447b38f0 ) )
    {
        level callback::add( #"on_ai_killed", &function_b37cd69c447b38f0 );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xb13d0c24, Offset: 0x9f37
// Size: 0x134
function function_11f70bbfdb99ff5b()
{
    foreach ( player in level.players )
    {
        killstreakstruct = player killstreaks::getkillstreakinslot( 1 );
        
        if ( isdefined( killstreakstruct ) && killstreakstruct.streakname == "toma_strike" && !level.var_c794ead7f61b085f )
        {
            player killstreaks::removekillstreak( 1 );
            player killstreaks::clearkillstreaks();
        }
        
        function_dfd7caa60e9b188d( player );
        level.var_c794ead7f61b085f = 0;
        
        if ( level callback::exists( "on_crafting_item_success", &function_36854a4b5e3fc5b1 ) )
        {
            player callback::remove( "on_crafting_item_success", &function_36854a4b5e3fc5b1 );
        }
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_b37cd69c447b38f0 ) )
    {
        level callback::remove( #"on_ai_killed", &function_b37cd69c447b38f0 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x411581a4, Offset: 0xa074
// Size: 0x72
function function_b37cd69c447b38f0( params )
{
    if ( params.einflictor.streakinfo.streakname == "toma_strike" )
    {
        level.tedd_task_progress++;
    }
    
    function_e9e1e5f03716ae0f();
    
    if ( level.tedd_task_progress >= level.mastery_rank )
    {
        level.mastery_achieved = 1;
        level notify( #"task_ended" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x93d8b435, Offset: 0xa0ee
// Size: 0x4a
function function_a7f6679048d6b8d5()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_cd78d60c6a7148a6 ) )
    {
        level callback::add( #"on_ai_killed", &function_cd78d60c6a7148a6 );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x28a20e3d, Offset: 0xa140
// Size: 0x135
function function_674f8be6e1ea355d()
{
    foreach ( player in level.players )
    {
        killstreakstruct = player killstreaks::getkillstreakinslot( 1 );
        
        if ( isdefined( killstreakstruct ) && killstreakstruct.streakname == "rcxd" && !level.var_c794ead7f61b085f )
        {
            player killstreaks::removekillstreak( 1 );
            player killstreaks::clearkillstreaks();
        }
        
        function_dfd7caa60e9b188d( player );
        level.var_c794ead7f61b085f = 0;
        
        if ( player callback::exists( "on_crafting_item_success", &function_36854a4b5e3fc5b1 ) )
        {
            player callback::remove( "on_crafting_item_success", &function_36854a4b5e3fc5b1 );
        }
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_cd78d60c6a7148a6 ) )
    {
        level callback::remove( #"on_ai_killed", &function_cd78d60c6a7148a6 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x7667d7ba, Offset: 0xa27e
// Size: 0x68
function function_cd78d60c6a7148a6( params )
{
    if ( params.sweapon.basename == "rcxd" )
    {
        level.tedd_task_progress++;
    }
    
    function_e9e1e5f03716ae0f();
    
    if ( level.tedd_task_progress >= level.mastery_rank )
    {
        level.mastery_achieved = 1;
        level notify( #"task_ended" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x400d203a, Offset: 0xa2ee
// Size: 0x4a
function function_2eb5b7b40f13174e()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_448f1083b565278d ) )
    {
        level callback::add( #"on_ai_killed", &function_448f1083b565278d );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x65311933, Offset: 0xa340
// Size: 0x135
function function_5cb20d8c7c5a11a2()
{
    foreach ( player in level.players )
    {
        killstreakstruct = player killstreaks::getkillstreakinslot( 1 );
        
        if ( isdefined( killstreakstruct ) && killstreakstruct.streakname == "mangler_cannon" && !level.var_c794ead7f61b085f )
        {
            player killstreaks::removekillstreak( 1 );
            player killstreaks::clearkillstreaks();
        }
        
        function_dfd7caa60e9b188d( player );
        level.var_c794ead7f61b085f = 0;
        
        if ( player callback::exists( "on_crafting_item_success", &function_36854a4b5e3fc5b1 ) )
        {
            player callback::remove( "on_crafting_item_success", &function_36854a4b5e3fc5b1 );
        }
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_448f1083b565278d ) )
    {
        level callback::remove( #"on_ai_killed", &function_448f1083b565278d );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xc9433490, Offset: 0xa47e
// Size: 0x68
function function_448f1083b565278d( params )
{
    if ( params.sweapon.basename == "t10_la_mangler_cannon_mp" )
    {
        level.tedd_task_progress++;
    }
    
    function_e9e1e5f03716ae0f();
    
    if ( level.tedd_task_progress >= level.mastery_rank )
    {
        level.mastery_achieved = 1;
        level notify( #"task_ended" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xd07abf76, Offset: 0xa4ee
// Size: 0x2d
function function_40ef98b743cf494e()
{
    level endon( #"game_ended" );
    level callback::add( "on_rapid_kill_counted", &function_66e4331d67455370 );
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xd6a09fb9, Offset: 0xa523
// Size: 0x31
function function_fcbd7ba16c26f3a2()
{
    if ( level callback::exists( "on_rapid_kill_counted", &function_66e4331d67455370 ) )
    {
        level callback::remove( "on_rapid_kill_counted", &function_66e4331d67455370 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x752df31, Offset: 0xa55d
// Size: 0x5b
function function_66e4331d67455370( params )
{
    if ( params.rapidkill_count > 1 )
    {
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xfb7babee, Offset: 0xa5c0
// Size: 0xea
function function_b86f99e49921675b()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( "on_field_upgrade_kill_track", &function_61722792ce0fff73 ) )
    {
        level callback::add( "on_field_upgrade_kill_track", &function_61722792ce0fff73 );
    }
    
    foreach ( player in level.players )
    {
        player callback::add( "field_upgrade_edit_notify", &function_2856e938bbe436 );
        player.var_975c27dd607974a2 = 0;
        player.var_11a6fc56d6979943 = "string";
    }
    
    function_2856e938bbe436();
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x32469d5, Offset: 0xa6b2
// Size: 0xd3
function function_417d0409eb80d62b()
{
    if ( level callback::exists( "on_field_upgrade_kill_track", &function_61722792ce0fff73 ) )
    {
        level callback::remove( "on_field_upgrade_kill_track", &function_61722792ce0fff73 );
    }
    
    foreach ( player in level.players )
    {
        if ( player callback::exists( "field_upgrade_edit_notify", &function_2856e938bbe436 ) )
        {
            player callback::remove( "field_upgrade_edit_notify", &function_2856e938bbe436 );
        }
        
        level.var_750a1cea39c9abc8 = undefined;
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xae16352d, Offset: 0xa78e
// Size: 0x5c
function function_61722792ce0fff73( params )
{
    if ( isplayer( params.player ) )
    {
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0xed79ac47, Offset: 0xa7f2
// Size: 0x1b1
function function_2856e938bbe436( params )
{
    foreach ( player in level.players )
    {
        level.var_750a1cea39c9abc8 = undefined;
        superinfo = player.super;
        
        if ( player.var_11a6fc56d6979943 == superinfo.staticdata.ref )
        {
            break;
        }
        
        if ( player.var_975c27dd607974a2 < 2 )
        {
            superinfo = player.super;
            player.var_e38641864ab13131 = 0;
            player.var_438ba36868c10421 = 0;
            player.var_11a6fc56d6979943 = superinfo.staticdata.ref;
            
            if ( isdefined( superinfo ) && superinfo.staticdata.ref != "super_healing_aura" )
            {
                player thread full_power::function_21f8005dcd5af7f9();
            }
            
            if ( isdefined( superinfo ) && superinfo.staticdata.ref != "super_healing_aura" )
            {
                if ( superinfo.staticdata.ref == "super_mary_paris" )
                {
                    level.var_750a1cea39c9abc8 = 20;
                }
                else
                {
                    level.var_750a1cea39c9abc8 = 4;
                }
            }
            
            player.var_975c27dd607974a2++;
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x701b2bd1, Offset: 0xa9ab
// Size: 0xd5
function function_404e8c030bc0402c()
{
    level endon( #"game_ended" );
    level callback::add( "on_field_upgrade_kill_track", &function_4030bb2a9b96c616 );
    
    foreach ( player in level.players )
    {
        player callback::add( "field_upgrade_edit_notify", &function_d96e52986d0d4ceb );
        player.var_975c27dd607974a2 = 0;
        player.var_11a6fc56d6979943 = "string";
    }
    
    function_d96e52986d0d4ceb();
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x677ec573, Offset: 0xaa88
// Size: 0xd3
function function_b1b1dd4001dc2b40()
{
    if ( level callback::exists( "on_field_upgrade_kill_track", &function_4030bb2a9b96c616 ) )
    {
        level callback::remove( "on_field_upgrade_kill_track", &function_4030bb2a9b96c616 );
    }
    
    foreach ( player in level.players )
    {
        if ( player callback::exists( "field_upgrade_edit_notify", &function_d96e52986d0d4ceb ) )
        {
            player callback::remove( "field_upgrade_edit_notify", &function_d96e52986d0d4ceb );
        }
        
        level.var_750a1cea39c9abc8 = undefined;
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x3d172c3d, Offset: 0xab64
// Size: 0x71
function function_4030bb2a9b96c616( params )
{
    if ( isplayer( params.player ) && params.field_upgrade == "energy_mine" )
    {
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0xff2d1639, Offset: 0xabdd
// Size: 0x1bb
function function_d96e52986d0d4ceb( params )
{
    foreach ( player in level.players )
    {
        level.var_750a1cea39c9abc8 = undefined;
        superinfo = player.super;
        
        if ( player.var_11a6fc56d6979943 == superinfo.staticdata.ref )
        {
            break;
        }
        
        if ( player.var_975c27dd607974a2 < 2 )
        {
            player.var_e38641864ab13131 = 0;
            player.var_438ba36868c10421 = 0;
            player.var_11a6fc56d6979943 = superinfo.staticdata.ref;
            
            if ( isdefined( superinfo ) && superinfo.staticdata.ref == "super_energy_mine" )
            {
                player thread full_power::function_21f8005dcd5af7f9();
            }
            
            if ( isdefined( superinfo ) && superinfo.staticdata.ref == "super_energy_mine" )
            {
                level.var_750a1cea39c9abc8 = 4;
            }
            
            if ( isdefined( player.perkpackagedata.overridepointsneeded ) && superinfo.staticdata.ref == "super_energy_mine" )
            {
                level.var_750a1cea39c9abc8 = 4;
            }
            
            player.var_975c27dd607974a2++;
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x24c5d4bf, Offset: 0xada0
// Size: 0xb9
function function_5737a44a24c52e31()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_1feff924f60ec2ca ) )
    {
        level callback::add( #"on_ai_killed", &function_1feff924f60ec2ca );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
    var_cff06ae231824dcb = 50 * anglestoforward( level.var_a3eb428773fa9129.angles );
    var_cff06ae231824dcb = var_cff06ae231824dcb + level.var_a3eb428773fa9129.origin + ( 0, 0, 30 );
    level thread function_f9276ae9d8fb81a3( 15, &function_cb857dcf07f529d5, "itemspawnentry:zm_sat_item_combataxe", level.players.size + 2, var_cff06ae231824dcb );
}

// Namespace teddtasks
// Params 0
// Checksum 0xecd86bda, Offset: 0xae61
// Size: 0x39
function function_5559d346454317f9()
{
    if ( level callback::exists( #"on_ai_killed", &function_1feff924f60ec2ca ) )
    {
        level callback::remove( #"on_ai_killed", &function_1feff924f60ec2ca );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xaa9cd9e3, Offset: 0xaea3
// Size: 0x88
function function_1feff924f60ec2ca( params )
{
    equipmentref = equipment_mp::function_fdc4a655fbde0dec( params.sweapon.basename );
    
    if ( equipment_mp::isequipmentlethal( equipmentref ) && equipmentref == "equip_combataxe" )
    {
        level.tedd_task_progress++;
    }
    
    function_e9e1e5f03716ae0f();
    
    if ( level.tedd_task_progress >= level.mastery_rank )
    {
        level.mastery_achieved = 1;
        level notify( #"task_ended" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x44288a30, Offset: 0xaf33
// Size: 0x4a
function function_a6626864de6bb896()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_dadd639495831ac5 ) )
    {
        level callback::add( #"on_ai_killed", &function_dadd639495831ac5 );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xf0afbb38, Offset: 0xaf85
// Size: 0x133
function function_d5e8aa6cff06ef9a()
{
    foreach ( player in level.players )
    {
        killstreakstruct = player killstreaks::getkillstreakinslot( 1 );
        
        if ( isdefined( killstreakstruct ) && killstreakstruct.streakname == "hand_cannon" && !level.var_c794ead7f61b085f )
        {
            player killstreaks::removekillstreak( 1 );
            player killstreaks::clearkillstreaks();
        }
        
        function_dfd7caa60e9b188d( player );
        level.var_c794ead7f61b085f = 0;
        
        if ( level callback::exists( "on_crafting_item_success", &function_36854a4b5e3fc5b1 ) )
        {
            level callback::remove( "on_crafting_item_success", &function_36854a4b5e3fc5b1 );
        }
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_dadd639495831ac5 ) )
    {
        level callback::remove( #"on_ai_killed", &function_dadd639495831ac5 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xc009afb2, Offset: 0xb0c1
// Size: 0x68
function function_dadd639495831ac5( params )
{
    if ( params.sweapon.basename == "sat_ks_handcannon" )
    {
        level.tedd_task_progress++;
    }
    
    function_e9e1e5f03716ae0f();
    
    if ( level.tedd_task_progress >= level.mastery_rank )
    {
        level.mastery_achieved = 1;
        level notify( #"task_ended" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x4d54aff7, Offset: 0xb131
// Size: 0x55
function function_5a59a62a35a4398c()
{
    level endon( #"game_ended" );
    level.var_f5150377c9cfdfd4 = 1;
    
    if ( !level callback::exists( #"on_ai_killed", &function_22d3eee6800396b ) )
    {
        level callback::add( #"on_ai_killed", &function_22d3eee6800396b );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x9d977a66, Offset: 0xb18e
// Size: 0x43
function function_d447d7fa331b13a0()
{
    level.var_f5150377c9cfdfd4 = undefined;
    
    if ( level callback::exists( #"on_ai_killed", &function_22d3eee6800396b ) )
    {
        level callback::remove( #"on_ai_killed", &function_22d3eee6800396b );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xeaac74cd, Offset: 0xb1da
// Size: 0xdb
function function_22d3eee6800396b( params )
{
    if ( level utility::flag( "l_g_active" ) && isplayer( params.eattacker ) || isdefined( params.eattacker.var_bd22ba6c600a23a3 ) )
    {
        playergravity = params.eattacker getlocalgravity();
        playeronground = params.eattacker isonground();
        
        if ( playergravity < 800 && level utility::flag( "l_g_active" ) && playeronground == 0 )
        {
            level.tedd_task_progress++;
        }
        
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x11d28b1, Offset: 0xb2bd
// Size: 0x4c
function function_3a778efff187fedc()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_e5df1d5879ccec5f ) )
    {
        level callback::add( #"on_ai_killed", &function_e5df1d5879ccec5f );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_shade", 1 );
}

// Namespace teddtasks
// Params 0
// Checksum 0x6e2bf81c, Offset: 0xb311
// Size: 0x39
function function_5537a9e3692f0170()
{
    if ( level callback::exists( #"on_ai_killed", &function_e5df1d5879ccec5f ) )
    {
        level callback::remove( #"on_ai_killed", &function_e5df1d5879ccec5f );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xfb20c325, Offset: 0xb353
// Size: 0x88
function function_e5df1d5879ccec5f( params )
{
    if ( isplayer( params.eattacker ) || isdefined( params.eattacker.var_bd22ba6c600a23a3 ) )
    {
        if ( self.subclass == "zombie_shade" )
        {
            level.tedd_task_progress++;
        }
        
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xb7a51697, Offset: 0xb3e3
// Size: 0x138
function function_dca39aacef6b3ecf()
{
    level endon( #"game_ended" );
    level.var_eea66b98d5965287 = [];
    level.var_ff160ed52904625e = [];
    
    for ( i = 1; i < 20 ; i++ )
    {
        var_ebf272cbfcfe4b98 = utility::getstruct( "fx_tessie_race_" + i, "targetname" );
        mld_tag_origin = utility::spawn_model( "tag_origin", var_ebf272cbfcfe4b98.origin, var_ebf272cbfcfe4b98.angles );
        mld_tag_origin.arrow_ent = utility::spawn_model( "tag_origin", var_ebf272cbfcfe4b98.origin, var_ebf272cbfcfe4b98.angles );
        level.var_ff160ed52904625e[ level.var_ff160ed52904625e.size ] = mld_tag_origin;
    }
    
    for ( i = 1; i < 20 ; i++ )
    {
        var_bb62354c4027f1d8 = getent( "tessie_race_" + i, "targetname" );
        level.var_eea66b98d5965287[ level.var_eea66b98d5965287.size ] = var_bb62354c4027f1d8;
    }
    
    if ( isdefined( level.wonder_veh ) )
    {
        car = level.wonder_veh;
    }
    
    level thread tessie_race_progress( car );
}

// Namespace teddtasks
// Params 0
// Checksum 0xb3ff1b47, Offset: 0xb523
// Size: 0x1cd
function function_416b68942789962f()
{
    foreach ( fx in level.var_ff160ed52904625e )
    {
        killfxontag( utility::getfx( "tessie_gate" ), fx, "tag_origin" );
        killfxontag( utility::getfx( "tessie_next_gate" ), fx, "tag_origin" );
        killfxontag( utility::getfx( "tessie_final_gate" ), fx, "tag_origin" );
        killfxontag( utility::getfx( "tessie_arrow" ), fx.arrow_ent, "tag_origin" );
        killfxontag( utility::getfx( "tessie_arrow_final" ), fx.arrow_ent, "tag_origin" );
        
        if ( isdefined( level.var_d5d7db9bb2b3a218 ) )
        {
            objidpoolmanager::returnobjectiveid( level.var_d5d7db9bb2b3a218.objidnum );
            level.var_d5d7db9bb2b3a218 = undefined;
        }
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.var_ddafffdc9c17da50 ) )
        {
            player.var_ddafffdc9c17da50 = undefined;
        }
    }
    
    level.var_eea66b98d5965287 = undefined;
    level.var_ff160ed52904625e = undefined;
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xecb3ce19, Offset: 0xb6f9
// Size: 0x18f
function tessie_race_progress( car )
{
    level endon( #"task_ended" );
    n_current_gate = 0;
    level set_gate_fx( n_current_gate );
    
    while ( n_current_gate < level.var_eea66b98d5965287.size )
    {
        level.var_eea66b98d5965287[ n_current_gate ] waittill( #"trigger", ent );
        
        if ( ent vehicle::is_vehicle() )
        {
            level.tedd_task_progress++;
            
            if ( n_current_gate <= 4 )
            {
                level.var_77be3669189a4fe3 += 5;
            }
            else
            {
                level.var_77be3669189a4fe3 += 4;
            }
            
            setomnvar( "ui_zm_current_trial_time", level.var_77be3669189a4fe3 );
            setomnvar( "ui_zm_current_trial_time_notify", gettime() );
            setomnvar( "ui_zm_current_trial_time_frozen", 0 );
            playfxontag( utility::getfx( "tessie_passing_gate" ), level.var_ff160ed52904625e[ n_current_gate ], "tag_origin" );
            playfxontag( utility::getfx( "tessie_arrow_clear" ), level.var_ff160ed52904625e[ n_current_gate ].arrow_ent, "tag_origin" );
            passing_sfx();
            level function_f927ed401f7ab247( n_current_gate );
            function_e9e1e5f03716ae0f();
            n_current_gate++;
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
            
            if ( n_current_gate < level.var_eea66b98d5965287.size )
            {
                level set_gate_fx( n_current_gate );
            }
        }
        else
        {
            continue;
        }
        
        waitframe();
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0x8fc13d94, Offset: 0xb890
// Size: 0x295
function set_gate_fx( var_59388bc9279a059 )
{
    n_last_gate = level.var_ff160ed52904625e.size - 1;
    
    if ( var_59388bc9279a059 == n_last_gate )
    {
        playfxontag( utility::getfx( "tessie_final_gate" ), level.var_ff160ed52904625e[ var_59388bc9279a059 ], "tag_origin" );
        playfxontag( utility::getfx( "tessie_arrow_final" ), level.var_ff160ed52904625e[ var_59388bc9279a059 ].arrow_ent, "tag_origin" );
        level.var_d5d7db9bb2b3a218 = gameobjects::createobjidobject( level.var_ff160ed52904625e[ var_59388bc9279a059 ].origin, "any", undefined, undefined, "any", 1, undefined );
        objidpoolmanager::function_c34959a44b376957( level.var_d5d7db9bb2b3a218.objidnum, function_2c53177dca959c16() );
        objidpoolmanager::update_objective_state( level.var_d5d7db9bb2b3a218.objidnum, "active" );
        objidpoolmanager::update_objective_icon( level.var_d5d7db9bb2b3a218.objidnum, "ui_hud_compass_boat_race_gate" );
        objidpoolmanager::function_373aaf492aabde6f( level.var_d5d7db9bb2b3a218.objidnum, 4, 225, 255, 1 );
        objidpoolmanager::function_9d4895ed38151e46( level.var_d5d7db9bb2b3a218.objidnum, 1 );
        return;
    }
    
    waitframe();
    playfxontag( utility::getfx( "tessie_gate" ), level.var_ff160ed52904625e[ var_59388bc9279a059 ], "tag_origin" );
    playfxontag( utility::getfx( "tessie_arrow" ), level.var_ff160ed52904625e[ var_59388bc9279a059 ].arrow_ent, "tag_origin" );
    level.var_d5d7db9bb2b3a218 = gameobjects::createobjidobject( level.var_ff160ed52904625e[ var_59388bc9279a059 ].origin, "any", undefined, undefined, "any", 1, undefined );
    objidpoolmanager::function_c34959a44b376957( level.var_d5d7db9bb2b3a218.objidnum, function_2c53177dca959c16() );
    objidpoolmanager::update_objective_state( level.var_d5d7db9bb2b3a218.objidnum, "active" );
    objidpoolmanager::update_objective_icon( level.var_d5d7db9bb2b3a218.objidnum, "ui_hud_compass_boat_race_gate" );
    objidpoolmanager::function_373aaf492aabde6f( level.var_d5d7db9bb2b3a218.objidnum, 4, 225, 255, 1 );
    objidpoolmanager::function_9d4895ed38151e46( level.var_d5d7db9bb2b3a218.objidnum, 1 );
    var_74dd65f1b0f1dac3 = var_59388bc9279a059 + 1;
    waitframe();
    playfxontag( utility::getfx( "tessie_next_gate" ), level.var_ff160ed52904625e[ var_74dd65f1b0f1dac3 ], "tag_origin" );
}

// Namespace teddtasks
// Params 1
// Checksum 0xe6f9ecfa, Offset: 0xbb2d
// Size: 0x13f
function function_f927ed401f7ab247( var_59388bc9279a059 )
{
    n_last_gate = level.var_ff160ed52904625e.size - 1;
    
    if ( var_59388bc9279a059 == n_last_gate )
    {
        killfxontag( utility::getfx( "tessie_final_gate" ), level.var_ff160ed52904625e[ var_59388bc9279a059 ], "tag_origin" );
        killfxontag( utility::getfx( "tessie_arrow_final" ), level.var_ff160ed52904625e[ var_59388bc9279a059 ].arrow_ent, "tag_origin" );
        objidpoolmanager::returnobjectiveid( level.var_d5d7db9bb2b3a218.objidnum );
        level.var_d5d7db9bb2b3a218 = undefined;
        return;
    }
    
    killfxontag( utility::getfx( "tessie_gate" ), level.var_ff160ed52904625e[ var_59388bc9279a059 ], "tag_origin" );
    killfxontag( utility::getfx( "tessie_arrow" ), level.var_ff160ed52904625e[ var_59388bc9279a059 ].arrow_ent, "tag_origin" );
    objidpoolmanager::returnobjectiveid( level.var_d5d7db9bb2b3a218.objidnum );
    level.var_d5d7db9bb2b3a218 = undefined;
    var_74dd65f1b0f1dac3 = var_59388bc9279a059 + 1;
    killfxontag( utility::getfx( "tessie_next_gate" ), level.var_ff160ed52904625e[ var_74dd65f1b0f1dac3 ], "tag_origin" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xcc1c5528, Offset: 0xbc74
// Size: 0xbb
function passing_sfx()
{
    if ( isdefined( level.wonder_veh ) && isdefined( level.wonder_veh.occupants ) )
    {
        foreach ( occupant in level.wonder_veh.occupants )
        {
            if ( isplayer( occupant ) )
            {
                occupant playsoundtoplayer( #"hash_7d3d5347df7f1dd2", occupant );
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x385b7233, Offset: 0xbd37
// Size: 0x3a8
function function_5baaaa47135fa58e()
{
    if ( isdefined( level.wonder_veh ) )
    {
        veh_zone_name = zone_manager::function_90e5c3e2272b0130( level.wonder_veh.origin );
        
        if ( veh_zone_name.zone_name == "zone_sunken_garage" || veh_zone_name.zone_name == "zone_sunken" || veh_zone_name.zone_name == "zone_sunken_north" || veh_zone_name.zone_name == "zone_sunken_south" )
        {
            return;
        }
    }
    
    var_a1a2ee087783daba = [];
    
    foreach ( player in level.players )
    {
        if ( isdefined( level.wonder_veh ) && isdefined( level.wonder_veh.occupants ) )
        {
            foreach ( occupant in level.wonder_veh.occupants )
            {
                if ( player == occupant && isplayer( occupant ) )
                {
                    player.var_ddafffdc9c17da50 = 1;
                    var_a1a2ee087783daba[ var_a1a2ee087783daba.size ] = player;
                }
            }
        }
    }
    
    var_db0f914564d0001e = getplayersinradius( level.wonder_veh.origin, 400 );
    
    if ( isdefined( var_db0f914564d0001e ) && var_db0f914564d0001e.size > 0 )
    {
        foreach ( player in var_db0f914564d0001e )
        {
            if ( !isdefined( player.var_ddafffdc9c17da50 ) )
            {
                var_a1a2ee087783daba[ var_a1a2ee087783daba.size ] = player;
            }
        }
    }
    
    if ( isdefined( var_a1a2ee087783daba ) )
    {
        foreach ( player in var_a1a2ee087783daba )
        {
            if ( isalive( player ) && isdefined( player.var_ddafffdc9c17da50 ) )
            {
                data = { #exittype:"INVOLUNTARY", #allowairexit:1 };
                seatid = vehicle_occupancy::get_occupant_seat( level.wonder_veh, player );
                level thread vehicle_occupancy::exit( level.wonder_veh, seatid, player, data, 1 );
            }
        }
    }
    
    level callback::callback( "tessie_task_initiated" );
    var_2b43aa5f72b09914 = utility::getstructarray( "garage_task_player_teleport", "targetname" );
    
    for ( i = 0; i < var_a1a2ee087783daba.size ; i++ )
    {
        var_2b43aa5f72b09914[ i ].target = "garage_task_player_teleport";
        level thread zm_fasttravel::function_cbb08198e7c84adf( var_2b43aa5f72b09914[ i ], var_a1a2ee087783daba[ i ] );
    }
    
    wait 6;
}

// Namespace teddtasks
// Params 0
// Checksum 0xad2276b4, Offset: 0xc0e7
// Size: 0x3c
function function_b1f3f6ce9327e3cc()
{
    level endon( #"game_ended" );
    level callback::add( #"on_ai_killed", &function_6dd66fb13818574f );
    level.var_8672fa96c3fb69e0 = 1;
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xc02130ba, Offset: 0xc12b
// Size: 0xcd
function function_2531f42cdab1d3e0()
{
    level.var_8672fa96c3fb69e0 = undefined;
    
    if ( level callback::exists( #"on_ai_killed", &function_6dd66fb13818574f ) )
    {
        level callback::remove( #"on_ai_killed", &function_6dd66fb13818574f );
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.var_ddafffdc9c17da50 ) )
        {
            player.var_ddafffdc9c17da50 = undefined;
        }
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x1b1dbda3, Offset: 0xc201
// Size: 0x87
function function_6dd66fb13818574f( params )
{
    if ( params.eattacker.vehicle.vehiclename == "veh_sat_firefly_pluto" && params.smeansofdeath == "MOD_CRUSH" )
    {
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xacd10ca5, Offset: 0xc290
// Size: 0x153
function function_8a44875c338da4a6()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_13e55ee8fe38d73d ) )
    {
        level callback::add( #"on_ai_killed", &function_13e55ee8fe38d73d );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
    
    foreach ( jumppad in level.a_jumppads )
    {
        level.var_d4c49766c6f14a4f = jumppad.script_cost;
        jumppad.script_cost = 0;
    }
    
    level.override_trap_duration = 2;
    var_cff06ae231824dcb = 50 * anglestoforward( level.var_a3eb428773fa9129.angles );
    var_cff06ae231824dcb = var_cff06ae231824dcb + level.var_a3eb428773fa9129.origin + ( 0, 0, 30 );
    level thread function_f9276ae9d8fb81a3( 15, &function_cb857dcf07f529d5, "itemspawnentry:zm_sat_item_c4", level.players.size + 2, var_cff06ae231824dcb );
}

// Namespace teddtasks
// Params 0
// Checksum 0x8502bc40, Offset: 0xc3eb
// Size: 0xec
function function_b00b07c8a20c18aa()
{
    if ( level callback::exists( #"on_ai_killed", &function_13e55ee8fe38d73d ) )
    {
        level callback::remove( #"on_ai_killed", &function_13e55ee8fe38d73d );
    }
    
    foreach ( jumppad in level.a_jumppads )
    {
        jumppad.script_cost = level.var_d4c49766c6f14a4f;
    }
    
    if ( isdefined( level.var_d4c49766c6f14a4f ) && isdefined( level.saved_trap_duration ) )
    {
        level.var_d4c49766c6f14a4f = undefined;
        level.override_trap_duration = undefined;
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xb4bf8f02, Offset: 0xc4e0
// Size: 0x14d
function function_13e55ee8fe38d73d( params )
{
    equipmentref = equipment_mp::function_fdc4a655fbde0dec( params.sweapon.basename );
    
    if ( isdefined( params.eattacker ) && params.eattacker utility::ent_flag( "player_ft_jp_jumping" ) && equipment_mp::isequipmentlethal( equipmentref ) && ( equipmentref == "equip_c4" || params.sweapon.basename == "sat_monkey_bomb_zm" || params.sweapon.basename == "sat_cluster_grenade_zm" || params.sweapon.basename == "sat_cluster_grenade_submunition" || params.sweapon.basename == "cer_monkey_bomb_zm" || params.sweapon.basename == "t10_c4_mp" ) )
    {
        level.tedd_task_progress++;
    }
    
    function_e9e1e5f03716ae0f();
    
    if ( level.tedd_task_progress >= level.mastery_rank )
    {
        level.mastery_achieved = 1;
        level notify( #"task_ended" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xb1417090, Offset: 0xc635
// Size: 0x35
function function_7e1fc4da6da325e3()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( "fog_zombie_killed_by_player", &function_bdea43f0e4a316bd ) )
    {
        level callback::add( "fog_zombie_killed_by_player", &function_bdea43f0e4a316bd );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xd3f7b72d, Offset: 0xc672
// Size: 0x31
function function_4bf0cd04dc694763()
{
    if ( level callback::exists( "fog_zombie_killed_by_player", &function_bdea43f0e4a316bd ) )
    {
        level callback::remove( "fog_zombie_killed_by_player", &function_bdea43f0e4a316bd );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xef796355, Offset: 0xc6ac
// Size: 0x63
function function_bdea43f0e4a316bd( params )
{
    waitframe();
    
    if ( !self.trial_fog_kill )
    {
        self.trial_fog_kill = 1;
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x562fa935, Offset: 0xc717
// Size: 0x16
function function_46d8f4de173b9410()
{
    level endon( #"game_ended" );
    level thread function_5564f270f81076c2();
}

// Namespace teddtasks
// Params 0
// Checksum 0x7f4852da, Offset: 0xc735
// Size: 0xb
function function_f843b745f166a674()
{
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 0
// Checksum 0x6ee14735, Offset: 0xc749
// Size: 0x116
function function_5564f270f81076c2()
{
    level endon( #"task_ended" );
    
    while ( level.tedd_task_progress <= level.mastery_rank )
    {
        foreach ( player in level.players )
        {
            if ( player.var_cc1677771f64fd22 && isalive( player ) )
            {
                var_c5885de780aa9569 = is_player_inside_vehicle( player );
                
                if ( var_c5885de780aa9569 == 1 )
                {
                    level.tedd_task_progress++;
                    function_e9e1e5f03716ae0f();
                }
                
                if ( level.tedd_task_progress >= level.mastery_rank )
                {
                    wait 2;
                    level.mastery_achieved = 1;
                    level notify( #"task_ended" );
                }
            }
        }
        
        wait 1;
        continue;
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0x62d564b9, Offset: 0xc867
// Size: 0xb4
function is_player_inside_vehicle( player )
{
    if ( isdefined( level.wonder_veh ) )
    {
        vehicle = level.wonder_veh;
        
        foreach ( occupant in vehicle.occupants )
        {
            if ( player == occupant && isplayer( occupant ) )
            {
                return 0;
            }
        }
        
        return 1;
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x85b1bc71, Offset: 0xc923
// Size: 0x1cb
function function_3cd260ab16dac6a9()
{
    level endon( #"game_ended" );
    level callback::add( #"on_ai_killed", &laser_trap_on_ai_killed );
    
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( trap.targetname == "laser_trap_switch" )
        {
            foreach ( switch_pos in trap.a_switch_pos )
            {
                switch_pos.interact.s_trapbuy notify( #"trap_finish_cooldown_early" );
                level.var_d4c49766c6f14a4f = switch_pos.var_32f1e7774266024b.script_cost;
                level.saved_trap_duration = switch_pos.var_32f1e7774266024b.script_timeout;
                switch_pos.var_32f1e7774266024b.script_cost = 0;
                switch_pos.var_32f1e7774266024b.script_timeout = 2;
                level.var_1bc31921d079dc44[ "laser_trap_switch" ].trapcost = 0;
            }
        }
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x4eddeba7, Offset: 0xcaf6
// Size: 0x1bc
function function_786d435822a6f641()
{
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( trap.targetname == "laser_trap_switch" )
        {
            foreach ( switch_pos in trap.a_switch_pos )
            {
                switch_pos.var_32f1e7774266024b.script_cost = level.var_d4c49766c6f14a4f;
                level.var_1bc31921d079dc44[ "laser_trap_switch" ].trapcost = level.var_d4c49766c6f14a4f;
                switch_pos.var_32f1e7774266024b.script_timeout = level.saved_trap_duration;
            }
        }
    }
    
    if ( isdefined( level.var_d4c49766c6f14a4f ) && isdefined( level.saved_trap_duration ) )
    {
        level.var_d4c49766c6f14a4f = undefined;
        level.override_trap_duration = undefined;
    }
    
    if ( level callback::exists( #"on_ai_killed", &laser_trap_on_ai_killed ) )
    {
        level callback::remove( #"on_ai_killed", &laser_trap_on_ai_killed );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xfc0d3e3a, Offset: 0xccbb
// Size: 0x74
function laser_trap_on_ai_killed( params )
{
    if ( params.eattacker.var_fcda7168a743663a == "laser_trap_switch" )
    {
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
        
        utility::ent_flag_clear( "laser_trap_kill" );
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xa1a9269a, Offset: 0xcd37
// Size: 0x1cb
function function_c33dc2b33469e642()
{
    level endon( #"game_ended" );
    level callback::add( #"on_ai_killed", &function_8299552442385e79 );
    
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( trap.targetname == "rocket_trap_switch" )
        {
            foreach ( switch_pos in trap.a_switch_pos )
            {
                switch_pos.interact.s_trapbuy notify( #"trap_finish_cooldown_early" );
                level.var_d4c49766c6f14a4f = switch_pos.var_32f1e7774266024b.script_cost;
                level.saved_trap_duration = switch_pos.var_32f1e7774266024b.script_timeout;
                switch_pos.var_32f1e7774266024b.script_cost = 0;
                switch_pos.var_32f1e7774266024b.script_timeout = 2;
                level.var_1bc31921d079dc44[ "rocket_trap_switch" ].trapcost = 0;
            }
        }
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xeb357bca, Offset: 0xcf0a
// Size: 0x1bc
function function_f04348c68a436616()
{
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( trap.targetname == "rocket_trap_switch" )
        {
            foreach ( switch_pos in trap.a_switch_pos )
            {
                switch_pos.var_32f1e7774266024b.script_cost = level.var_d4c49766c6f14a4f;
                level.var_1bc31921d079dc44[ "rocket_trap_switch" ].trapcost = level.var_d4c49766c6f14a4f;
                switch_pos.var_32f1e7774266024b.script_timeout = level.saved_trap_duration;
            }
        }
    }
    
    if ( isdefined( level.var_d4c49766c6f14a4f ) && isdefined( level.saved_trap_duration ) )
    {
        level.var_d4c49766c6f14a4f = undefined;
        level.override_trap_duration = undefined;
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_8299552442385e79 ) )
    {
        level callback::remove( #"on_ai_killed", &function_8299552442385e79 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x44df5dba, Offset: 0xd0cf
// Size: 0x83
function function_8299552442385e79( params )
{
    if ( utility::ent_flag( "rocket_trap_kill" ) && params.einflictor.var_fcda7168a743663a == "rocket_trap_switch" )
    {
        utility::ent_flag_clear( "rocket_trap_kill" );
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x70231899, Offset: 0xd15a
// Size: 0x8f
function function_472508eb0f5ad52b()
{
    level endon( #"game_ended" );
    function_14803fc9f713dd42( "specialty_phd_flopper" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_33f78087bb64ca50 ) )
    {
        level callback::add( #"on_ai_killed", &function_33f78087bb64ca50 );
    }
    
    if ( !level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" ) )
    {
        level callback::add( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xef8214c7, Offset: 0xd1f1
// Size: 0x7d
function function_73408bb7c2b6de7b()
{
    function_1dab26efe8511860( "specialty_phd_flopper" );
    
    if ( level callback::exists( #"on_ai_killed", &function_33f78087bb64ca50 ) )
    {
        level callback::remove( #"on_ai_killed", &function_33f78087bb64ca50 );
    }
    
    if ( level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" ) )
    {
        level callback::remove( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xfeb99514, Offset: 0xd277
// Size: 0xcd
function function_33f78087bb64ca50( params )
{
    if ( function_6f6349c66c16ba80( params.eattacker ) )
    {
        if ( isplayer( params.eattacker ) && params.eattacker utility::ent_flag( "is_phd_flopping" ) )
        {
            if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_slider" ) && params.eattacker issprintsliding() )
            {
                return;
            }
            
            level.tedd_task_progress++;
            function_e9e1e5f03716ae0f();
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
        }
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0x2778677b, Offset: 0xd34c
// Size: 0x163, Type: bool
function function_6f6349c66c16ba80( eattacker )
{
    var_844bca1d00cc4a25 = [ "zone_temple_left", "zone_temple_right", "zone_temple_center", "zone_temple_tech", "zone_temple_displays", "zone_temple", "zone_temple_displays" ];
    eattacker_in_zone = undefined;
    zombie_in_zone = undefined;
    
    foreach ( zone in var_844bca1d00cc4a25 )
    {
        if ( zone_manager::is_touching_zone( zone, eattacker ) )
        {
            eattacker_in_zone = 1;
        }
    }
    
    foreach ( zone in var_844bca1d00cc4a25 )
    {
        if ( zone_manager::is_touching_zone( zone, self ) )
        {
            zombie_in_zone = 1;
        }
    }
    
    if ( zombie_in_zone && eattacker_in_zone )
    {
        return true;
    }
    
    return false;
}

// Namespace teddtasks
// Params 0
// Checksum 0xdecdb357, Offset: 0xd4b8
// Size: 0x259
function function_5e88e04229a7e69e()
{
    level endon( #"game_ended" );
    level callback::add( #"on_ai_killed", &function_a411d6fa3eea55fd );
    
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( trap.targetname == "electro_shock_trap_switch" || trap.targetname == "electro_shock_trap_garage_switch" )
        {
            foreach ( switch_pos in trap.a_switch_pos )
            {
                switch_pos.interact.s_trapbuy notify( #"trap_finish_cooldown_early" );
                level.var_d4c49766c6f14a4f = switch_pos.var_32f1e7774266024b.script_cost;
                level.saved_trap_duration = switch_pos.var_32f1e7774266024b.script_timeout;
                switch_pos.var_32f1e7774266024b.script_cost = 0;
                switch_pos.var_32f1e7774266024b.script_timeout = 2;
                
                if ( isdefined( level.var_1bc31921d079dc44[ "electro_shock_trap_switch" ] ) )
                {
                    level.var_1bc31921d079dc44[ "electro_shock_trap_switch" ].trapcost = 0;
                    level.var_1bc31921d079dc44[ "electro_shock_trap_switch" ].var_204569adc9c61cb9 = 2;
                }
                
                if ( isdefined( level.var_1bc31921d079dc44[ "electro_shock_trap_garage_switch" ] ) )
                {
                    level.var_1bc31921d079dc44[ "electro_shock_trap_garage_switch" ].trapcost = 0;
                    level.var_1bc31921d079dc44[ "electro_shock_trap_garage_switch" ].var_204569adc9c61cb9 = 2;
                }
            }
        }
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x5de8089c, Offset: 0xd719
// Size: 0x260
function function_5a80b7d23793abf2()
{
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( trap.targetname == "electro_shock_trap_switch" || trap.targetname == "electro_shock_trap_garage_switch" )
        {
            foreach ( switch_pos in trap.a_switch_pos )
            {
                switch_pos.var_32f1e7774266024b.script_cost = level.var_d4c49766c6f14a4f;
                switch_pos.var_32f1e7774266024b.script_timeout = level.saved_trap_duration;
                
                if ( isdefined( level.var_1bc31921d079dc44[ "electro_shock_trap_switch" ] ) )
                {
                    level.var_1bc31921d079dc44[ "electro_shock_trap_switch" ].trapcost = level.var_d4c49766c6f14a4f;
                    level.var_1bc31921d079dc44[ "electro_shock_trap_switch" ].var_204569adc9c61cb9 = level.saved_trap_duration;
                }
                
                if ( isdefined( level.var_1bc31921d079dc44[ "electro_shock_trap_garage_switch" ] ) )
                {
                    level.var_1bc31921d079dc44[ "electro_shock_trap_garage_switch" ].trapcost = level.var_d4c49766c6f14a4f;
                    level.var_1bc31921d079dc44[ "electro_shock_trap_garage_switch" ].var_204569adc9c61cb9 = level.saved_trap_duration;
                }
            }
        }
    }
    
    if ( isdefined( level.var_d4c49766c6f14a4f ) && isdefined( level.saved_trap_duration ) )
    {
        level.var_d4c49766c6f14a4f = undefined;
        level.override_trap_duration = undefined;
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_a411d6fa3eea55fd ) )
    {
        level callback::remove( #"on_ai_killed", &function_a411d6fa3eea55fd );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x8eb144f5, Offset: 0xd982
// Size: 0x64
function function_a411d6fa3eea55fd( params )
{
    if ( utility::ent_flag( "electro_shock_trap_kill" ) )
    {
        utility::ent_flag_clear( "electro_shock_trap_kill" );
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xb8d76967, Offset: 0xd9ee
// Size: 0x21e
function function_438872664ac2f0f1()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_3202c933ef3ff18a ) )
    {
        level callback::add( #"on_ai_killed", &function_3202c933ef3ff18a );
    }
    
    level.var_4d9092a6949e967 = 1;
    
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( trap.targetname == "fire_trap_switch" )
        {
            foreach ( switch_pos in trap.a_switch_pos )
            {
                switch_pos.interact.s_trapbuy notify( #"trap_finish_cooldown_early" );
                level.var_d4c49766c6f14a4f = switch_pos.var_32f1e7774266024b.script_cost;
                level.saved_trap_duration = switch_pos.var_32f1e7774266024b.script_timeout;
                switch_pos.var_32f1e7774266024b.script_cost = 0;
                switch_pos.var_32f1e7774266024b.script_timeout = 2;
                
                if ( isdefined( level.var_1bc31921d079dc44[ "fire_trap_switch" ] ) )
                {
                    level.var_1bc31921d079dc44[ "fire_trap_switch" ].trapcost = 0;
                    level.var_1bc31921d079dc44[ "fire_trap_switch" ].var_204569adc9c61cb9 = 2;
                }
            }
        }
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x3dee73c, Offset: 0xdc14
// Size: 0x1fc
function function_2445697244cc29b9()
{
    level.var_4d9092a6949e967 = undefined;
    
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( trap.targetname == "fire_trap_switch" )
        {
            foreach ( switch_pos in trap.a_switch_pos )
            {
                switch_pos.var_32f1e7774266024b.script_cost = level.var_d4c49766c6f14a4f;
                switch_pos.var_32f1e7774266024b.script_timeout = level.saved_trap_duration;
                
                if ( isdefined( level.var_1bc31921d079dc44[ "fire_trap_switch" ] ) )
                {
                    level.var_1bc31921d079dc44[ "fire_trap_switch" ].trapcost = level.var_d4c49766c6f14a4f;
                    level.var_1bc31921d079dc44[ "fire_trap_switch" ].var_204569adc9c61cb9 = level.saved_trap_duration;
                }
            }
        }
    }
    
    if ( isdefined( level.var_d4c49766c6f14a4f ) && isdefined( level.saved_trap_duration ) )
    {
        level.var_d4c49766c6f14a4f = undefined;
        level.override_trap_duration = undefined;
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_3202c933ef3ff18a ) )
    {
        level callback::remove( #"on_ai_killed", &function_3202c933ef3ff18a );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xae1eb304, Offset: 0xde19
// Size: 0x64
function function_3202c933ef3ff18a( params )
{
    if ( utility::ent_flag( "flame_trap_kill" ) )
    {
        utility::ent_flag_clear( "flame_trap_kill" );
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x8016e096, Offset: 0xde85
// Size: 0x9b
function function_d8a37ed333152fb2()
{
    level endon( #"game_ended" );
    function_14803fc9f713dd42( "specialty_phd_flopper" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_c378cf6c75c9b4c9 ) )
    {
        level callback::add( #"on_ai_killed", &function_c378cf6c75c9b4c9 );
    }
    
    if ( !level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk ) )
    {
        level callback::add( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
    enable_trigger_zones( "zone_fishery_phd", "zone_fishery_phd" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x9d19a685, Offset: 0xdf28
// Size: 0x143
function function_7247a837e3f90686()
{
    function_1dab26efe8511860( "specialty_phd_flopper" );
    triggerzones = getentarray( level.var_a3eb428773fa9129.script_location, #targetname );
    disable_trigger_zones( triggerzones );
    var_a965cfed27d75b2 = getentitylessscriptablearray( "zone_fishery_phd", #targetname );
    
    foreach ( var_bfb9424e344026e0 in var_a965cfed27d75b2 )
    {
        var_bfb9424e344026e0 utility::function_7c10ea82c1e305b8( "chevron_0", "off" );
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_c378cf6c75c9b4c9 ) )
    {
        level callback::remove( #"on_ai_killed", &function_c378cf6c75c9b4c9 );
    }
    
    if ( level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" ) )
    {
        level callback::remove( #"player_laststand_revived", &on_player_revived_give_perk );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x22bf2f46, Offset: 0xe074
// Size: 0xe2
function function_c378cf6c75c9b4c9( params )
{
    if ( function_618b63a16e7e0c81( "zone_fishery_phd", params.eattacker ) && function_618b63a16e7e0c81( "zone_fishery_phd", self ) )
    {
        if ( isplayer( params.eattacker ) && params.eattacker utility::ent_flag( "is_phd_flopping" ) )
        {
            if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_slider" ) && params.eattacker issprintsliding() )
            {
                return;
            }
            
            level.tedd_task_progress++;
            function_e9e1e5f03716ae0f();
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x65549627, Offset: 0xe15e
// Size: 0x21e
function function_f05779fd93f90a8d()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_bcba659018a88d2e ) )
    {
        level callback::add( #"on_ai_killed", &function_bcba659018a88d2e );
    }
    
    level.var_228d4dde2f35bfcb = 1;
    
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( trap.targetname == "murder_holes_trap" )
        {
            foreach ( switch_pos in trap.a_switch_pos )
            {
                switch_pos.interact.s_trapbuy notify( #"trap_finish_cooldown_early" );
                level.var_d4c49766c6f14a4f = switch_pos.var_32f1e7774266024b.script_cost;
                level.saved_trap_duration = switch_pos.var_32f1e7774266024b.script_timeout;
                switch_pos.var_32f1e7774266024b.script_cost = 0;
                switch_pos.var_32f1e7774266024b.script_timeout = 2;
                
                if ( isdefined( level.var_1bc31921d079dc44[ "murder_holes_trap" ] ) )
                {
                    level.var_1bc31921d079dc44[ "murder_holes_trap" ].trapcost = 0;
                    level.var_1bc31921d079dc44[ "murder_holes_trap" ].var_204569adc9c61cb9 = 2;
                }
            }
        }
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xc37b0ee8, Offset: 0xe384
// Size: 0x1fc
function function_fb5dd3c1a2cea025()
{
    level.var_228d4dde2f35bfcb = undefined;
    
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        if ( trap.targetname == "murder_holes_trap" )
        {
            foreach ( switch_pos in trap.a_switch_pos )
            {
                switch_pos.var_32f1e7774266024b.script_cost = level.var_d4c49766c6f14a4f;
                switch_pos.var_32f1e7774266024b.script_timeout = level.saved_trap_duration;
                
                if ( isdefined( level.var_1bc31921d079dc44[ "murder_holes_trap" ] ) )
                {
                    level.var_1bc31921d079dc44[ "murder_holes_trap" ].trapcost = level.var_d4c49766c6f14a4f;
                    level.var_1bc31921d079dc44[ "murder_holes_trap" ].var_204569adc9c61cb9 = level.saved_trap_duration;
                }
            }
        }
    }
    
    if ( isdefined( level.var_d4c49766c6f14a4f ) && isdefined( level.saved_trap_duration ) )
    {
        level.var_d4c49766c6f14a4f = undefined;
        level.override_trap_duration = undefined;
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_bcba659018a88d2e ) )
    {
        level callback::remove( #"on_ai_killed", &function_bcba659018a88d2e );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xc10df60f, Offset: 0xe589
// Size: 0x64
function function_bcba659018a88d2e( params )
{
    if ( utility::ent_flag( "murder_trap_kill" ) )
    {
        utility::ent_flag_clear( "murder_trap_kill" );
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xd960e2a7, Offset: 0xe5f5
// Size: 0x9b
function function_40f4ec7bd8eaddb8()
{
    level endon( #"game_ended" );
    function_14803fc9f713dd42( "specialty_phd_flopper" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_6e4482a3910ad34 ) )
    {
        level callback::add( #"on_ai_killed", &function_6e4482a3910ad34 );
    }
    
    if ( !level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk ) )
    {
        level callback::add( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
    enable_trigger_zones( "zone_keep_phd", "zone_keep_phd" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x5fc65e2e, Offset: 0xe698
// Size: 0x143
function function_f0df1fe25a780fec()
{
    function_1dab26efe8511860( "specialty_phd_flopper" );
    triggerzones = getentarray( level.var_a3eb428773fa9129.script_location, #targetname );
    disable_trigger_zones( triggerzones );
    var_a965cfed27d75b2 = getentitylessscriptablearray( "zone_keep_phd", #targetname );
    
    foreach ( var_bfb9424e344026e0 in var_a965cfed27d75b2 )
    {
        var_bfb9424e344026e0 utility::function_7c10ea82c1e305b8( "chevron_0", "off" );
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_6e4482a3910ad34 ) )
    {
        level callback::remove( #"on_ai_killed", &function_6e4482a3910ad34 );
    }
    
    if ( level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" ) )
    {
        level callback::remove( #"player_laststand_revived", &on_player_revived_give_perk );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xd567584a, Offset: 0xe7e4
// Size: 0xe2
function function_6e4482a3910ad34( params )
{
    if ( function_618b63a16e7e0c81( "zone_keep_phd", params.eattacker ) && function_618b63a16e7e0c81( "zone_keep_phd", self ) )
    {
        if ( isplayer( params.eattacker ) && params.eattacker utility::ent_flag( "is_phd_flopping" ) )
        {
            if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_slider" ) && params.eattacker issprintsliding() )
            {
                return;
            }
            
            level.tedd_task_progress++;
            function_e9e1e5f03716ae0f();
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x8e47650e, Offset: 0xe8ce
// Size: 0x57
function function_e7f9b51efcae602d()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_19a323c18d7093a4 ) )
    {
        level callback::add( #"on_ai_killed", &function_19a323c18d7093a4 );
    }
    
    level callback::callback( "teddtask_hornet_lava_kill" );
    level thread function_1d105e8b51d70eff( "zombie_base" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xd66b909e, Offset: 0xe92d
// Size: 0x43
function function_432050a0daee2745()
{
    level.var_f5150377c9cfdfd4 = undefined;
    
    if ( level callback::exists( #"on_ai_killed", &function_19a323c18d7093a4 ) )
    {
        level callback::remove( #"on_ai_killed", &function_19a323c18d7093a4 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x61e0f6ea, Offset: 0xe979
// Size: 0x59
function function_19a323c18d7093a4( params )
{
    if ( self.var_d682d30b84057103 == 1 )
    {
        level.tedd_task_progress++;
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x53e0dcea, Offset: 0xe9da
// Size: 0x9b
function function_ba0219c238241fa2()
{
    level endon( #"game_ended" );
    function_14803fc9f713dd42( "specialty_phd_flopper" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_7c397cce74de8e2e ) )
    {
        level callback::add( #"on_ai_killed", &function_7c397cce74de8e2e );
    }
    
    if ( !level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk ) )
    {
        level callback::add( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
    enable_trigger_zones( "zone_aranea_insula_phd", "zone_aranea_insula_phd" );
}

// Namespace teddtasks
// Params 0
// Checksum 0x9afb7fa2, Offset: 0xea7d
// Size: 0x143
function function_8f2d298d69fa67f6()
{
    function_1dab26efe8511860( "specialty_phd_flopper" );
    triggerzones = getentarray( level.var_a3eb428773fa9129.script_location, #targetname );
    disable_trigger_zones( triggerzones );
    var_a965cfed27d75b2 = getentitylessscriptablearray( "zone_aranea_insula_phd", #targetname );
    
    foreach ( var_bfb9424e344026e0 in var_a965cfed27d75b2 )
    {
        var_bfb9424e344026e0 utility::function_7c10ea82c1e305b8( "chevron_0", "off" );
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_7c397cce74de8e2e ) )
    {
        level callback::remove( #"on_ai_killed", &function_7c397cce74de8e2e );
    }
    
    if ( level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" ) )
    {
        level callback::remove( #"player_laststand_revived", &on_player_revived_give_perk );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xfdc9cce3, Offset: 0xebc9
// Size: 0xe2
function function_7c397cce74de8e2e( params )
{
    if ( function_618b63a16e7e0c81( "zone_aranea_insula_phd", params.eattacker ) && function_618b63a16e7e0c81( "zone_aranea_insula_phd", self ) )
    {
        if ( isplayer( params.eattacker ) && params.eattacker utility::ent_flag( "is_phd_flopping" ) )
        {
            if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_slider" ) && params.eattacker issprintsliding() )
            {
                return;
            }
            
            level.tedd_task_progress++;
            function_e9e1e5f03716ae0f();
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0xc34c8db7, Offset: 0xecb3
// Size: 0x4a
function function_14917ec5c1e0a5d8()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_57cc402ed0031983 ) )
    {
        level callback::add( #"on_ai_killed", &function_57cc402ed0031983 );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_loom_minion" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xc4f082ce, Offset: 0xed05
// Size: 0x39
function function_23419b6ecb0be50c()
{
    if ( level callback::exists( #"on_ai_killed", &function_57cc402ed0031983 ) )
    {
        level callback::remove( #"on_ai_killed", &function_57cc402ed0031983 );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0xc0065843, Offset: 0xed47
// Size: 0xa2
function function_57cc402ed0031983( params )
{
    if ( isplayer( params.eattacker ) || isdefined( params.eattacker.trap_scriptable ) || isdefined( params.eattacker.var_bd22ba6c600a23a3 ) )
    {
        if ( self.subclass == "zombie_loom_minion" )
        {
            level.tedd_task_progress++;
        }
        
        function_e9e1e5f03716ae0f();
        
        if ( level.tedd_task_progress >= level.mastery_rank )
        {
            level.mastery_achieved = 1;
            level notify( #"task_ended" );
        }
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x416b4261, Offset: 0xedf1
// Size: 0x9b
function function_ccab5ffc99ff2b8c()
{
    level endon( #"game_ended" );
    function_14803fc9f713dd42( "specialty_phd_flopper" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_cc81d76aaaf474d0 ) )
    {
        level callback::add( #"on_ai_killed", &function_cc81d76aaaf474d0 );
    }
    
    if ( !level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk ) )
    {
        level callback::add( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" );
    }
    
    level thread function_1d105e8b51d70eff( "zombie_base" );
    enable_trigger_zones( "zone_nyxara_transitus_phd", "zone_nyxara_transitus_phd" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xe3ce5284, Offset: 0xee94
// Size: 0x143
function function_c5bf042a19e8b5a0()
{
    function_1dab26efe8511860( "specialty_phd_flopper" );
    triggerzones = getentarray( level.var_a3eb428773fa9129.script_location, #targetname );
    disable_trigger_zones( triggerzones );
    var_a965cfed27d75b2 = getentitylessscriptablearray( "zone_nyxara_transitus_phd", #targetname );
    
    foreach ( var_bfb9424e344026e0 in var_a965cfed27d75b2 )
    {
        var_bfb9424e344026e0 utility::function_7c10ea82c1e305b8( "chevron_0", "off" );
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_cc81d76aaaf474d0 ) )
    {
        level callback::remove( #"on_ai_killed", &function_cc81d76aaaf474d0 );
    }
    
    if ( level callback::exists( #"player_laststand_revived", &on_player_revived_give_perk, "specialty_phd_flopper" ) )
    {
        level callback::remove( #"player_laststand_revived", &on_player_revived_give_perk );
    }
    
    return level.tedd_task_progress;
}

// Namespace teddtasks
// Params 1
// Checksum 0x6c921b4f, Offset: 0xefe0
// Size: 0xe2
function function_cc81d76aaaf474d0( params )
{
    if ( function_618b63a16e7e0c81( "zone_nyxara_transitus_phd", params.eattacker ) && function_618b63a16e7e0c81( "zone_nyxara_transitus_phd", self ) )
    {
        if ( isplayer( params.eattacker ) && params.eattacker utility::ent_flag( "is_phd_flopping" ) )
        {
            if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_slider" ) && params.eattacker issprintsliding() )
            {
                return;
            }
            
            level.tedd_task_progress++;
            function_e9e1e5f03716ae0f();
            
            if ( level.tedd_task_progress >= level.mastery_rank )
            {
                level.mastery_achieved = 1;
                level notify( #"task_ended" );
            }
        }
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0x28dfc849, Offset: 0xf0ca
// Size: 0xc4
function function_36854a4b5e3fc5b1( params )
{
    if ( isdefined( params.item.itemref ) && params.item.category == "support" )
    {
        if ( params.item.itemref != "equip_self_revive" && params.item.itemref != ( level.armorref ?? "equip_armorplate" ) )
        {
            self.var_54e4128b0929fa09 = undefined;
        }
        
        if ( level.var_96db6f3ebb5f208a == params.item.itemref )
        {
            level.var_c794ead7f61b085f = 1;
        }
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0x7626af85, Offset: 0xf196
// Size: 0x143
function function_14803fc9f713dd42( perk_name )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player.micontext.var_d2526179d91798d6 ) )
        {
            if ( !arraycontains( player.micontext.var_d2526179d91798d6, perk_name ) )
            {
                player.micontext.var_d2526179d91798d6[ player.micontext.var_d2526179d91798d6.size ] = perk_name;
                player.var_8eaa5a1f702291ca = 1;
            }
            else
            {
                player.var_8eaa5a1f702291ca = undefined;
            }
        }
        else if ( !player zombie_perks::has_perk( perk_name ) )
        {
            player zombie_perks::grab_and_use_perk( perk_name );
            player.var_8eaa5a1f702291ca = 1;
        }
        else
        {
            player.var_8eaa5a1f702291ca = undefined;
        }
        
        player.var_dfa4fa883ff5e93f = 1;
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0x3ecb7ebc, Offset: 0xf2e1
// Size: 0x11f
function function_1dab26efe8511860( perk_name )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player.var_8eaa5a1f702291ca ) )
        {
            if ( player zombie_perks::has_perk( perk_name ) )
            {
                player zombie_perks::take_perk( perk_name );
            }
            
            if ( isdefined( player.micontext.var_d2526179d91798d6 ) )
            {
                if ( arraycontains( player.micontext.var_d2526179d91798d6, perk_name ) )
                {
                    player.micontext.var_d2526179d91798d6 = arrayremove( player.micontext.var_d2526179d91798d6, perk_name );
                }
            }
        }
        
        player.var_dfa4fa883ff5e93f = undefined;
        player.var_8eaa5a1f702291ca = undefined;
    }
}

// Namespace teddtasks
// Params 2
// Checksum 0x54902243, Offset: 0xf408
// Size: 0x38
function on_player_revived_give_perk( params, var_e892a69ba675af62 )
{
    if ( !zombie_perks::has_perk( var_e892a69ba675af62 ) && isdefined( self.var_dfa4fa883ff5e93f ) )
    {
        zombie_perks::give_perk( var_e892a69ba675af62 );
    }
}

// Namespace teddtasks
// Params 2
// Checksum 0x3e12d8ed, Offset: 0xf448
// Size: 0x602
function function_1d105e8b51d70eff( var_800bb2e8d2ae301c, bpause )
{
    level endon( #"game_ended" );
    zm_round_spawning::pause_round_spawning( 1, "task began" );
    var_213f7a641da91283 = level.var_8cff5e93e7f5e8.var_d4b4bbc33aaa2ac8;
    alive_players = utility::get_alive_players();
    max_spawn_count = level.mastery_rank;
    
    if ( var_213f7a641da91283 )
    {
        zombie_spawn_interval = 1 / ( alive_players.size + level.roundscale );
    }
    else
    {
        zombie_spawn_interval = 1.5 / ( alive_players.size + level.roundscale );
    }
    
    if ( level.var_8cff5e93e7f5e8.var_d19cfc327f3899a1 > 0 )
    {
        zombie_spawn_interval = level.var_8cff5e93e7f5e8.var_d19cfc327f3899a1;
    }
    
    round_number = zm_round_logic::get_rb_round_number();
    task_zone = zone_manager::function_90e5c3e2272b0130( getclosestpointonnavmesh( level.var_a3eb428773fa9129.origin ) );
    
    if ( !isdefined( task_zone ) && isdefined( level.var_a3eb428773fa9129.mdl_teddtasks ) )
    {
        task_zone = level.var_a3eb428773fa9129.mdl_teddtasks zone_manager::get_current_zone();
    }
    
    spawner_zombie_type = undefined;
    level.var_cbdb009fd53f720f = [];
    level.a_bubbles = [];
    
    if ( !callback::exists( #"on_ai_killed", &function_a8219108040d8468 ) )
    {
        callback::add( #"on_ai_killed", &function_a8219108040d8468 );
    }
    
    while ( level.var_a3eb428773fa9129.var_41c88f190b4433e )
    {
        zombies = getaiarray( zm_utility::get_zombie_team() );
        round_zombies = zm_round_spawning::get_round_enemies();
        spawn_check = level.mastery_rank > round_zombies.size && round_zombies.size < level.var_a009ab14ee0d3223.var_63a0ca44b877a390;
        
        if ( level.var_8cff5e93e7f5e8.var_49db79060a915125 )
        {
            spawn_check = round_zombies.size < level.var_a009ab14ee0d3223.var_63a0ca44b877a390;
        }
        
        if ( spawn_check )
        {
            if ( isdefined( var_800bb2e8d2ae301c ) )
            {
                spawner_zombie_type = function_b3988325430ce242( var_800bb2e8d2ae301c );
            }
            else
            {
                spawner_zombie_type = utility::percent_chance( 80 ) ? function_b3988325430ce242( "zombie_base" ) : function_b3988325430ce242( "zombie_vermin" );
            }
            
            if ( !isdefined( spawner_zombie_type ) )
            {
                /#
                    iprintlnbold( "<dev string:xe1>" );
                #/
                
                waitframe();
                continue;
            }
            
            if ( !var_213f7a641da91283 )
            {
                spawn_zones = task_zone zone_manager::get_adjacent_zones( 1, 1 );
                spawn_zones[ spawn_zones.size ] = task_zone;
                var_9516872a92fce93a = [];
                
                if ( isdefined( spawn_zones ) )
                {
                    foreach ( zone in spawn_zones )
                    {
                        var_5a8a10ea963112d0 = zone_spawner::function_20c574a6ba7cc5c6( zone.script_zone_name, spawner_zombie_type );
                        var_9516872a92fce93a = arraycombine( var_9516872a92fce93a, var_5a8a10ea963112d0 );
                    }
                }
                
                spawners = var_9516872a92fce93a;
                
                if ( !isdefined( var_9516872a92fce93a ) || var_9516872a92fce93a.size <= 0 )
                {
                    waitframe();
                    continue;
                }
                
                zmb_spawner = utility::array_random( spawners );
                waitframe();
                level thread function_bd8375e0cb9a9437( spawner_zombie_type, zmb_spawner, round_number );
            }
            else
            {
                waitframe();
                level thread function_bd8375e0cb9a9437( spawner_zombie_type, undefined, round_number, 1 );
            }
        }
        
        if ( !level.var_a3eb428773fa9129.var_41c88f190b4433e )
        {
            break;
        }
        
        utility::waittill_notify_or_timeout( "task_ended", zombie_spawn_interval );
    }
    
    zm_round_spawning::pause_round_spawning( 0, "task began" );
    taskTickThrottle = throttle::throttle_initialize( "taskTickThrottle", 1, level.framedurationseconds );
    
    if ( level.b_zm_game_over )
    {
        return;
    }
    
    ai_kill_radius = 650;
    
    if ( isdefined( level.var_a3eb428773fa9129 ) )
    {
        nearby_ai = getaiarrayinradius( level.var_a3eb428773fa9129.origin, ai_kill_radius, zm_utility::get_zombie_team() );
        
        foreach ( var_a8ed9dcd9413dc0a in nearby_ai )
        {
            if ( !var_a8ed9dcd9413dc0a val::get( "allow_secondary_attack_damage" ) || var_a8ed9dcd9413dc0a val::get( "ignoreme" ) || var_a8ed9dcd9413dc0a.aicategory == "special" || var_a8ed9dcd9413dc0a.aicategory == "elite" || var_a8ed9dcd9413dc0a.aicategory == "hvt" || var_a8ed9dcd9413dc0a.type != "zombie" )
            {
                nearby_ai = arrayremove( nearby_ai, var_a8ed9dcd9413dc0a );
                continue;
            }
            
            if ( !arraycontains( level.var_cbdb009fd53f720f, var_a8ed9dcd9413dc0a ) )
            {
                var_a8ed9dcd9413dc0a zm_cleanup_manager::function_dd62e2042418b7e5();
            }
        }
        
        ais = arraycombineunique( nearby_ai, level.var_cbdb009fd53f720f );
        
        foreach ( ai in ais )
        {
            if ( isalive( ai ) )
            {
                ai thread function_5bbd540197e3fd();
            }
        }
    }
    
    if ( callback::exists( #"on_ai_killed", &function_a8219108040d8468 ) )
    {
        callback::remove( #"on_ai_killed", &function_a8219108040d8468 );
    }
}

// Namespace teddtasks
// Params 4
// Checksum 0xabc36527, Offset: 0xfa52
// Size: 0x206
function function_bd8375e0cb9a9437( zombie_type, spawner, round_number, near_player )
{
    level endon( #"task_ended" );
    
    if ( !isdefined( level.var_a3eb428773fa9129.var_41c88f190b4433e ) )
    {
        return;
    }
    
    if ( !isdefined( near_player ) )
    {
        zombie = agent_manager::spawn_agent( zombie_type, spawner.origin, ( 0, 0, 0 ), "team_two_hundred" );
    }
    else
    {
        zombie = agent_spawner::spawn_agent( zombie_type );
    }
    
    if ( isdefined( zombie ) )
    {
        zombie.var_76a3d9c353b6fc50 = zombie.kiastring;
        
        if ( zombie.aicategory == "normal" )
        {
            zombie.kiastring = #"hash_2a7922a73e6eb69";
            zmb_subclass = ai::function_29ab862ec4f51541( zombie_type );
            
            if ( zmb_subclass == "zombie_base" || zmb_subclass == "zombie_vermin" )
            {
                if ( !zombie callback::exists( #"on_ai_killed", &function_cf6b7c5ba1f55a43 ) )
                {
                    zombie callback::add( #"on_ai_killed", &function_cf6b7c5ba1f55a43 );
                }
            }
            
            if ( zombie.subclass == "zombie_base" )
            {
                zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
            }
            
            if ( zombie.subclass == "zombie_vermin" )
            {
                zombie utility::function_7c10ea82c1e305b8( "eyes", "purple_eyes" );
            }
        }
        else if ( zombie.aicategory == "special" )
        {
            zombie.kiastring = #"hash_2a7922a73e6eb69";
        }
        else
        {
            zombie.kiastring = #"hash_2a7922a73e6eb69";
        }
        
        zombie zombie_utils::set_zombie_round_difficulty( round_number );
        function_56a5d231844a7cd2( zombie, 1 );
        level.var_cbdb009fd53f720f = arraycombineunique( level.var_cbdb009fd53f720f, [ zombie ] );
        
        if ( !isdefined( near_player ) )
        {
            zombie zone_spawner::function_ce10e453e7f7bb8e( spawner );
        }
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0x9fdcc980, Offset: 0xfc60
// Size: 0x52
function function_cf6b7c5ba1f55a43( params )
{
    if ( self.subclass == "zombie_base" )
    {
        utility::function_7c10ea82c1e305b8( "base", "base_on" );
    }
    
    if ( self.subclass == "zombie_vermin" )
    {
        utility::function_7c10ea82c1e305b8( "eyes", "off" );
    }
}

// Namespace teddtasks
// Params 2
// Checksum 0x1153ecf7, Offset: 0xfcba
// Size: 0x4d
function function_56a5d231844a7cd2( ent, var_b84028f2a0141008 )
{
    ent.b_cleanup_no_respawn = var_b84028f2a0141008;
    ent.var_a13bed1ac47e1b2c = var_b84028f2a0141008;
    ent.no_powerups = var_b84028f2a0141008;
    ent.var_15598d8e493afe88 = var_b84028f2a0141008;
}

// Namespace teddtasks
// Params 1
// Checksum 0x24bc4a5f, Offset: 0xfd0f
// Size: 0x22
function function_a8219108040d8468( sparams )
{
    level.var_cbdb009fd53f720f = function_46f9072493651dc9( level.var_cbdb009fd53f720f );
}

// Namespace teddtasks
// Params 0
// Checksum 0xa6f73001, Offset: 0xfd39
// Size: 0x175
function function_5bbd540197e3fd()
{
    self endon( #"death" );
    wait randomfloatrange( 1, 1.25 );
    self.nuked = 1;
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.full_gib = 1;
    self.var_65522105f3bdca37 = 1;
    zombie_stun::stun_ai( 100 );
    var_d8c7a0fac844e6b = utility::getfx( "zombie_impact" );
    var_b0a812f37b404b6e = utility::getfx( "zombie_impact_blood" );
    
    if ( self tagexists( "j_spine4" ) )
    {
        self.pap_stun_fx = playfxontag( var_d8c7a0fac844e6b, self, "j_spine4" );
    }
    
    wait randomfloatrange( 0.5, 1 );
    
    if ( isalive( self ) && self tagexists( "j_spine4" ) )
    {
        self.pap_stun_fx = stopfxontag( var_d8c7a0fac844e6b, self, "j_spine4" );
        self.pap_death_fx = playfxontag( var_b0a812f37b404b6e, self, "j_spine4" );
    }
    
    wait 0.25;
    
    if ( val::get( "damageshield" ) && val::get( "damageshield_allow_delete" ) )
    {
        if ( utility::issharedfuncdefined( #"ai", #"hash_c649178f35fe47cf" ) )
        {
            utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        }
    }
    
    if ( isalive( self ) && !self.magic_bullet_shield && !self.damageshield )
    {
        self kill();
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x9fab1b21, Offset: 0xfeb6
// Size: 0x8d
function function_c404e4ff729071ca()
{
    level.roundscale = 1;
    
    if ( level.var_6781718da4f78d1c.roundnumber <= 10 )
    {
        level.roundscale = 1;
        return;
    }
    
    if ( level.var_6781718da4f78d1c.roundnumber <= 20 )
    {
        level.roundscale = 2;
        return;
    }
    
    if ( level.var_6781718da4f78d1c.roundnumber <= 30 )
    {
        level.roundscale = 3;
        return;
    }
    
    level.roundscale = 4;
}

// Namespace teddtasks
// Params 2
// Checksum 0x8cfdbe37, Offset: 0xff4b
// Size: 0xbc
function function_618b63a16e7e0c81( var_d5e505e9e95f2d3b, target )
{
    if ( !isdefined( var_d5e505e9e95f2d3b ) )
    {
        return;
    }
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    triggerzones = getentarray( var_d5e505e9e95f2d3b, #targetname );
    
    foreach ( trigger in triggerzones )
    {
        if ( isdefined( trigger ) && target istouching( trigger ) )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace teddtasks
// Params 0
// Checksum 0xf66d5d59, Offset: 0x10010
// Size: 0x5ea
function function_57c54c0a6db240f7()
{
    level endon( #"task_interrupt" );
    
    if ( !isdefined( level.var_8cff5e93e7f5e8 ) )
    {
        return;
    }
    
    s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
    playerscalar = 1;
    timescalar = 1;
    level.roundscale = 1;
    
    if ( isdefined( s_bundle ) && isdefined( level.var_8cff5e93e7f5e8.n_time_scalar ) && level.players.size > 1 )
    {
        if ( !isdefined( s_bundle.playerscalar ) )
        {
            s_bundle.playerscalar = 0.5;
        }
        
        playerscalar += ( level.players.size - 1 ) * s_bundle.playerscalar;
        timescalar += ( level.players.size - 1 ) * level.var_8cff5e93e7f5e8.n_time_scalar;
    }
    
    function_c404e4ff729071ca();
    level.tedd_task_progress = 0;
    level.mastery_achieved = undefined;
    
    switch ( level.roundscale )
    {
        case 1:
            if ( !isdefined( level.var_8cff5e93e7f5e8.var_51378d32d0af2763 ) )
            {
                level.var_8cff5e93e7f5e8.var_51378d32d0af2763 = 120;
            }
            
            level.challenge_time = int( level.var_8cff5e93e7f5e8.var_51378d32d0af2763 * timescalar );
            var_b6c24f94393aa90f = int( level.var_8cff5e93e7f5e8.var_ea03254b836dfd66 * playerscalar );
            level.mastery_rank = round_to_nearest_five( var_b6c24f94393aa90f );
            
            if ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"ol_tessie_race" )
            {
                level.mastery_rank = 19;
                level.challenge_time = 16;
            }
            
            if ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"hash_118650abf6b05f4f" )
            {
                level.mastery_rank = 35;
            }
            
            break;
        case 2:
            if ( !isdefined( level.var_8cff5e93e7f5e8.var_51378e32d0af2996 ) )
            {
                level.var_8cff5e93e7f5e8.var_51378e32d0af2996 = 120;
            }
            
            level.challenge_time = int( level.var_8cff5e93e7f5e8.var_51378e32d0af2996 * timescalar );
            var_b6c24f94393aa90f = int( level.var_8cff5e93e7f5e8.var_ea03244b836dfb33 * playerscalar );
            level.mastery_rank = round_to_nearest_five( var_b6c24f94393aa90f );
            
            if ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"ol_tessie_race" )
            {
                level.mastery_rank = 19;
                level.challenge_time = 16;
            }
            
            if ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"hash_118650abf6b05f4f" )
            {
                level.mastery_rank = 45;
            }
            
            break;
        case 3:
            if ( !isdefined( level.var_8cff5e93e7f5e8.var_51378f32d0af2bc9 ) )
            {
                level.var_8cff5e93e7f5e8.var_51378f32d0af2bc9 = 120;
            }
            
            level.challenge_time = int( level.var_8cff5e93e7f5e8.var_51378f32d0af2bc9 * timescalar );
            var_b6c24f94393aa90f = int( level.var_8cff5e93e7f5e8.var_ea03234b836df900 * playerscalar );
            level.mastery_rank = round_to_nearest_five( var_b6c24f94393aa90f );
            
            if ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"ol_tessie_race" )
            {
                level.mastery_rank = 19;
                level.challenge_time = 16;
            }
            
            if ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"hash_118650abf6b05f4f" )
            {
                level.mastery_rank = 55;
            }
            
            break;
        case 4:
            if ( !isdefined( level.var_8cff5e93e7f5e8.var_51379032d0af2dfc ) )
            {
                level.var_8cff5e93e7f5e8.var_51379032d0af2dfc = 120;
            }
            
            level.challenge_time = int( level.var_8cff5e93e7f5e8.var_51379032d0af2dfc * timescalar );
            var_b6c24f94393aa90f = int( level.var_8cff5e93e7f5e8.var_ea032a4b836e0865 * playerscalar );
            level.mastery_rank = round_to_nearest_five( var_b6c24f94393aa90f );
            
            if ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"ol_tessie_race" )
            {
                level.mastery_rank = 19;
                level.challenge_time = 16;
            }
            
            if ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"hash_118650abf6b05f4f" )
            {
                level.mastery_rank = 55;
            }
            
            break;
    }
    
    setomnvar( "ui_zm_current_trial_id", level.var_8cff5e93e7f5e8.var_7c00f823b7c297d4 + 1 );
    setomnvar( "ui_zm_current_trial_type", level.var_8cff5e93e7f5e8.var_19cd9b8d08f8a7c9 + 1 );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_zm_current_trial_status", 0 );
        player setclientomnvar( "ui_zm_current_trial_status_notify", gettime() );
    }
    
    setomnvar( "ui_zm_current_trial_time", 0 );
    setomnvar( "ui_zm_current_trial_time_notify", gettime() );
    setomnvar( "ui_zm_current_trial_time_frozen", 1 );
    setomnvar( "ui_zm_current_trial_mastery_progress", 0 );
    setomnvar( "ui_zm_current_trial_mastery_progress_max", int( level.mastery_rank ) );
}

// Namespace teddtasks
// Params 0
// Checksum 0xba65548d, Offset: 0x10602
// Size: 0x32, Type: bool
function function_d7f41834c8b941a4()
{
    quartz_pap_quest = zm_quest::get_quest( #"quartz_pap_quest" );
    
    if ( quartz_pap_quest.can_num > 3 )
    {
        return true;
    }
    
    return false;
}

// Namespace teddtasks
// Params 1
// Checksum 0x41af8eec, Offset: 0x1063d
// Size: 0x55
function round_to_nearest_five( mastery_value )
{
    if ( isdefined( mastery_value ) )
    {
        remainder = mastery_value % 5;
        lowermultiple = mastery_value - remainder;
        uppermultiple = lowermultiple + 5;
        
        if ( mastery_value - lowermultiple < uppermultiple - mastery_value )
        {
            return lowermultiple;
        }
        
        return uppermultiple;
    }
}

// Namespace teddtasks
// Params 2
// Checksum 0x91de55f7, Offset: 0x1069a
// Size: 0x3e3
function enable_trigger_zones( zone_location, border_location )
{
    triggerzones = getentarray( zone_location, #targetname );
    s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
    objicon = "transparent_invisible";
    
    if ( isdefined( s_bundle.objectiveicon ) )
    {
        objicon = s_bundle.objectiveicon;
    }
    
    task_loc = level.var_a3eb428773fa9129.mdl_teddtasks.origin;
    
    if ( level.var_8cff5e93e7f5e8.e_waypoint_obj == "zone" )
    {
        task_loc = undefined;
        a_waypoint = utility::getstructarray( "task_waypoint", "script_noteworthy" );
        
        foreach ( waypoint in a_waypoint )
        {
            if ( waypoint.targetname == level.var_a3eb428773fa9129.targetname )
            {
                task_loc = waypoint.origin;
            }
        }
    }
    
    if ( !isdefined( task_loc ) )
    {
        return;
    }
    
    level.var_9195e4ef4a3e3935 = utility::spawn_model( "tag_origin", task_loc, ( 0, 0, 0 ) );
    level.var_9195e4ef4a3e3935.objid = objidpoolmanager::requestobjectiveid();
    
    if ( isdefined( level.var_9195e4ef4a3e3935.objid ) )
    {
        if ( level.var_9195e4ef4a3e3935.objid != -1 )
        {
            objidpoolmanager::objective_add_objective( level.var_9195e4ef4a3e3935.objid, "current", level.var_9195e4ef4a3e3935.origin, objicon, "icon_small" );
            objidpoolmanager::function_de3fb937d4f45f38( level.var_9195e4ef4a3e3935.objid, 350, 170 );
            objective_setbackground( level.var_9195e4ef4a3e3935.objid, 1 );
            objidpoolmanager::objective_showdistance( level.var_9195e4ef4a3e3935.objid, 0 );
        }
    }
    
    foreach ( trigger in triggerzones )
    {
        objective_setownerteam( level.var_9195e4ef4a3e3935.objid, level.players[ 0 ].team );
        objective_setprogressteam( level.var_9195e4ef4a3e3935.objid, level.players[ 0 ].team );
        function_ca1cc2938b2b4271( level.var_9195e4ef4a3e3935.objid, triggerzones[ 0 ] );
    }
    
    var_fab2d9ee9393e74f = getentitylessscriptablearray( border_location, #targetname );
    
    foreach ( var_bfb9424e344026e0 in var_fab2d9ee9393e74f )
    {
        var_bfb9424e344026e0 utility::function_7c10ea82c1e305b8( "chevron_0", "axis" );
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0x59b42bbb, Offset: 0x10a85
// Size: 0xc6
function disable_trigger_zones( triggerzones )
{
    if ( isdefined( level.var_9195e4ef4a3e3935 ) )
    {
        if ( isdefined( level.var_9195e4ef4a3e3935.objid ) )
        {
            function_ca30be9f04600a82( level.var_9195e4ef4a3e3935.objid );
            
            if ( level.var_9195e4ef4a3e3935.objid != -1 && !objidpoolmanager::function_fb05d646a96ed99e( level.var_9195e4ef4a3e3935.objid ) )
            {
                objidpoolmanager::update_objective_state( level.var_9195e4ef4a3e3935.objid, "done" );
                objidpoolmanager::returnobjectiveid( level.var_9195e4ef4a3e3935.objid );
            }
        }
        
        level.var_9195e4ef4a3e3935 delete();
    }
}

// Namespace teddtasks
// Params 1
// Checksum 0xc308e7cc, Offset: 0x10b53
// Size: 0x159
function function_c337088ceb0b5c57( var_75385495715741fb )
{
    level endon( #"game_ended" );
    a_offsets = [];
    offsetone = var_75385495715741fb.origin + rotatevector( ( 60, 30, 0 ), var_75385495715741fb.angles );
    a_offsets[ a_offsets.size ] = offsetone;
    offsettwo = var_75385495715741fb.origin + rotatevector( ( 60, -30, 0 ), var_75385495715741fb.angles );
    a_offsets[ a_offsets.size ] = offsettwo;
    
    for ( i = 0; i < a_offsets.size ; i++ )
    {
        wait 0.1;
        spawnoptions = common_item::function_f5dfaa3bbdf99a33( a_offsets[ i ], var_75385495715741fb.origin );
        spawnoptions.var_44d5025c8cfbd48e = 3;
        spawnoptions.var_2321e933cbdf46d8 = 30;
        spawnoptions.var_12d76a8b35ac875d = 3;
        spawnoptions.var_aec43e9d95b191f9 = 1;
        spawnoptions.var_9161cf0784b6951d = 0;
        spawnoptions.var_18608bd8660b3a19 = 8;
        present_bundle = utility::array_random( level.var_8d50fe65da45ad00 );
        item = common_item::function_61c2c0251e742ffd( present_bundle, undefined, spawnoptions );
    }
    
    a_offsets = undefined;
}

// Namespace teddtasks
// Params 0
// Checksum 0x464a9b1c, Offset: 0x10cb4
// Size: 0xea
function function_5c255c52a547a609()
{
    switch ( self.targetname )
    {
        case #"hash_a13dcc7545006505":
            activateworldevent( "we_sat_teddtask_ashwood_square" );
            break;
        case #"hash_2a64cb23733b5c97":
            activateworldevent( "we_sat_teddtask_diner_roof" );
            break;
        case #"hash_fd0b07d9410a7ee7":
            activateworldevent( "we_sat_teddtask_farm_house" );
            break;
        case #"hash_62f3ccf495ca4f3b":
            activateworldevent( "we_sat_teddtask_lakecabin_house" );
            break;
        case #"hash_1f05574be080585d":
            activateworldevent( "we_sat_teddtask_tessie_race" );
            break;
        case #"hash_ad48ece1be8233a2":
            activateworldevent( "we_lgt_zm_TEDD_stables" );
            break;
        case #"hash_b929f73afbf89ba":
            activateworldevent( "we_lgt_zm_TEDD_courtyard" );
            break;
        case #"hash_44d5f2d138ab1514":
            activateworldevent( "we_lgt_zm_TEDD_gatehouse" );
            break;
        default:
            break;
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x11cc7c79, Offset: 0x10da6
// Size: 0xea
function function_259156271c99e60a()
{
    switch ( self.targetname )
    {
        case #"hash_a13dcc7545006505":
            deactivateworldevent( "we_sat_teddtask_ashwood_square" );
            break;
        case #"hash_2a64cb23733b5c97":
            deactivateworldevent( "we_sat_teddtask_diner_roof" );
            break;
        case #"hash_fd0b07d9410a7ee7":
            deactivateworldevent( "we_sat_teddtask_farm_house" );
            break;
        case #"hash_62f3ccf495ca4f3b":
            deactivateworldevent( "we_sat_teddtask_lakecabin_house" );
            break;
        case #"hash_1f05574be080585d":
            deactivateworldevent( "we_sat_teddtask_tessie_race" );
            break;
        case #"hash_ad48ece1be8233a2":
            deactivateworldevent( "we_lgt_zm_TEDD_stables" );
            break;
        case #"hash_b929f73afbf89ba":
            deactivateworldevent( "we_lgt_zm_TEDD_courtyard" );
            break;
        case #"hash_44d5f2d138ab1514":
            deactivateworldevent( "we_lgt_zm_TEDD_gatehouse" );
            break;
        default:
            break;
    }
}

// Namespace teddtasks
// Params 0
// Checksum 0x181f78ff, Offset: 0x10e98
// Size: 0x5a
function function_c687838183131248()
{
    level.var_fe14ab33acc04da3 = undefined;
    self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "activate" );
    self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "cloud", "activate" );
    self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "objective", "show" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xf042f20f, Offset: 0x10efa
// Size: 0x5b
function function_ec8395db14b3e26f()
{
    level.var_fe14ab33acc04da3 = 1;
    self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "objective", "off" );
    self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "beam", "off" );
    self.mdl_teddtasks utility::function_7c10ea82c1e305b8( "cloud", "off" );
}

// Namespace teddtasks
// Params 0
// Checksum 0xb5817f77, Offset: 0x10f5d
// Size: 0x4a
function pause_task()
{
    if ( !( isdefined( level.var_a3eb428773fa9129 ) && isdefined( level.var_a3eb428773fa9129.mdl_teddtasks ) ) )
    {
        return;
    }
    
    level.var_a3eb428773fa9129.var_d9d7f9ce3106b5a5 = 1;
    setomnvar( "ui_zm_current_trial_time_frozen", 1 );
}

// Namespace teddtasks
// Params 0
// Checksum 0xef928a17, Offset: 0x10faf
// Size: 0x48
function resume_task()
{
    if ( !( isdefined( level.var_a3eb428773fa9129 ) && isdefined( level.var_a3eb428773fa9129.mdl_teddtasks ) ) )
    {
        return;
    }
    
    level.var_a3eb428773fa9129.var_d9d7f9ce3106b5a5 = 0;
    setomnvar( "ui_zm_current_trial_time_frozen", 0 );
}

/#

    // Namespace teddtasks
    // Params 0
    // Checksum 0x33d0b024, Offset: 0x10fff
    // Size: 0x2b5, Type: dev
    function init_tasks_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x101>" );
        devgui::add_devgui_func( "<dev string:x10b>", "<dev string:x11d>", &function_b9bb1c745c45e024 );
        devgui::add_devgui_func( "<dev string:x12f>", "<dev string:x144>", &function_c1b247239056f4c1 );
        
        foreach ( challenge in level.var_f30ca8dcd3d76b94 )
        {
            if ( isdefined( challenge.var_c2afe1a671205584 ) )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x159>" + getxhashsourcename( challenge.var_c2afe1a671205584 ), "<dev string:x165>" + getxhashsourcename( challenge.var_c2afe1a671205584 ) + "<dev string:x177>", &debug_start_task );
            }
        }
        
        if ( isdefined( level.tedd_locations ) )
        {
            foreach ( location in level.tedd_locations )
            {
                if ( isdefined( location ) )
                {
                    if ( isdefined( location.targetname ) )
                    {
                        devgui::function_cd4e263c1f3018ae( "<dev string:x179>" + location.targetname, "<dev string:x188>" + location.targetname + "<dev string:x177>", &function_4cab8cfb76b74685 );
                    }
                }
            }
        }
        
        devgui::add_devgui_func( "<dev string:x1a2>", "<dev string:x1ab>", &function_dc5d14cb1cb20155 );
        devgui::add_devgui_func( "<dev string:x1b4>", "<dev string:x1c2>", &function_7894e70c01bad1be );
        devgui::add_devgui_func( "<dev string:x1d0>", "<dev string:x1de>", &function_4653b6f0a11ec536 );
        devgui::add_devgui_func( "<dev string:x1ec>", "<dev string:x1fa>", &function_53803b5023bb6ec7 );
        devgui::add_devgui_func( "<dev string:x208>", "<dev string:x218>", &function_7e0a6d001846e214 );
        devgui::add_devgui_func( "<dev string:x228>", "<dev string:x236>", &function_d93ded9d7272f83f );
        devgui::add_devgui_func( "<dev string:x244>", "<dev string:x252>", &function_68e21db6281edddb );
        devgui::add_devgui_func( "<dev string:x260>", "<dev string:x26e>", &function_cf4089b98b8de89a );
        devgui::add_devgui_func( "<dev string:x27c>", "<dev string:x28c>", &function_419867a668c40d61 );
        devgui::add_devgui_func( "<dev string:x29c>", "<dev string:x2bf>", &function_c4f9bbd2052d6376 );
        devgui::add_devgui_func( "<dev string:x2d7>", "<dev string:x2fa>", &function_a0442e941059db85 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0x38f1c06e, Offset: 0x112bc
    // Size: 0x1ae, Type: dev
    function function_b9bb1c745c45e024()
    {
        level.is_task_debug = 1;
        
        if ( isdefined( level.var_fd94a3cfab1edb0 ) )
        {
            end_task();
        }
        
        if ( isdefined( level.var_a3eb428773fa9129 ) )
        {
            level.var_a3eb428773fa9129.mdl_teddtasks thread function_f1f31c26130bea5b();
            return;
        }
        
        foreach ( var_71e3a46af0b727fa in level.var_f30ca8dcd3d76b94 )
        {
            if ( var_71e3a46af0b727fa.var_2ebc8f03f901e060 <= level.var_6781718da4f78d1c.roundnumber && var_71e3a46af0b727fa.var_2e99a503f8dbc90a >= level.var_6781718da4f78d1c.roundnumber && !arraycontains( level.tedd_challenges, var_71e3a46af0b727fa ) )
            {
                if ( isdefined( var_71e3a46af0b727fa.fn_custom ) )
                {
                    if ( [[ var_71e3a46af0b727fa.fn_custom ]]() == 1 )
                    {
                        level.tedd_challenges = arraycombineunique( level.tedd_challenges, [ var_71e3a46af0b727fa ] );
                    }
                    
                    continue;
                }
                
                level.tedd_challenges = arraycombineunique( level.tedd_challenges, [ var_71e3a46af0b727fa ] );
            }
        }
        
        function_8c7dd04aa844bd67();
        
        if ( isdefined( level.var_a3eb428773fa9129.mdl_teddtasks ) )
        {
            level.var_a3eb428773fa9129.mdl_teddtasks thread function_f1f31c26130bea5b();
        }
    }

    // Namespace teddtasks
    // Params 1
    // Checksum 0xde137650, Offset: 0x11472
    // Size: 0xf0, Type: dev
    function debug_start_task( params )
    {
        level.is_task_debug = 1;
        
        if ( !isdefined( level.var_a3eb428773fa9129 ) )
        {
            function_8c7dd04aa844bd67();
        }
        
        foreach ( challenge in level.var_f30ca8dcd3d76b94 )
        {
            if ( challenge.var_c2afe1a671205584 == params[ 0 ] )
            {
                level.var_8cff5e93e7f5e8 = challenge;
                
                if ( isdefined( level.var_a3eb428773fa9129.mdl_teddtasks ) )
                {
                    level.var_a3eb428773fa9129.mdl_teddtasks thread function_f1f31c26130bea5b();
                }
                
                break;
            }
        }
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0x9cc832f6, Offset: 0x1156a
    // Size: 0x171, Type: dev
    function function_c1b247239056f4c1()
    {
        level.is_task_debug = 1;
        level.var_8cff5e93e7f5e8 = undefined;
        
        if ( isdefined( level.var_a3eb428773fa9129 ) )
        {
            level.var_a3eb428773fa9129 hide_teddtask( 0 );
        }
        
        level.var_a3eb428773fa9129 = undefined;
        
        foreach ( var_71e3a46af0b727fa in level.var_f30ca8dcd3d76b94 )
        {
            if ( var_71e3a46af0b727fa.var_2ebc8f03f901e060 <= level.var_6781718da4f78d1c.roundnumber && var_71e3a46af0b727fa.var_2e99a503f8dbc90a >= level.var_6781718da4f78d1c.roundnumber && !arraycontains( level.tedd_challenges, var_71e3a46af0b727fa ) )
            {
                if ( isdefined( var_71e3a46af0b727fa.fn_custom ) )
                {
                    if ( [[ var_71e3a46af0b727fa.fn_custom ]]() == 1 )
                    {
                        level.tedd_challenges = arraycombineunique( level.tedd_challenges, [ var_71e3a46af0b727fa ] );
                    }
                    
                    continue;
                }
                
                level.tedd_challenges = arraycombineunique( level.tedd_challenges, [ var_71e3a46af0b727fa ] );
            }
        }
        
        function_8c7dd04aa844bd67();
    }

    // Namespace teddtasks
    // Params 1
    // Checksum 0xdb4e5dd8, Offset: 0x116e3
    // Size: 0x1d3, Type: dev
    function function_4cab8cfb76b74685( params )
    {
        level.is_task_debug = 1;
        level.var_8cff5e93e7f5e8 = undefined;
        
        if ( isdefined( level.var_a3eb428773fa9129 ) )
        {
            level.var_a3eb428773fa9129 hide_teddtask( 0 );
        }
        
        level.var_a3eb428773fa9129 = undefined;
        
        foreach ( location in level.tedd_locations )
        {
            if ( location.targetname == params[ 0 ] )
            {
                level.var_a3eb428773fa9129 = location;
                level.var_a3eb428773fa9129.var_fc33c079280ed93a = 1;
                break;
            }
        }
        
        foreach ( challenge in level.var_f30ca8dcd3d76b94 )
        {
            if ( ( challenge.str_unique_name == "<dev string:x312>" || level.var_a3eb428773fa9129.targetname === challenge.str_unique_name ) && !challenge.b_kill_challenge && !challenge.var_1bbfedd55ef1a7ae )
            {
                level.var_8cff5e93e7f5e8 = challenge;
            }
        }
        
        level.var_a3eb428773fa9129 show_teddtask( 0 );
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0x884b806a, Offset: 0x118be
    // Size: 0x26, Type: dev
    function function_dc5d14cb1cb20155()
    {
        level.is_task_debug = 1;
        
        if ( !isdefined( level.var_fd94a3cfab1edb0 ) )
        {
            return;
        }
        
        end_task();
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0x9799bf4c, Offset: 0x118ec
    // Size: 0x37, Type: dev
    function function_7894e70c01bad1be()
    {
        level.is_task_debug = 1;
        
        if ( !isdefined( level.var_fd94a3cfab1edb0 ) )
        {
            return;
        }
        
        level.tedd_task_progress = 0;
        function_e9e1e5f03716ae0f();
        end_task();
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0xabfbfc72, Offset: 0x1192b
    // Size: 0x9b, Type: dev
    function function_4653b6f0a11ec536()
    {
        level.is_task_debug = 1;
        
        if ( !isdefined( level.var_fd94a3cfab1edb0 ) )
        {
            return;
        }
        
        s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
        first_score = s_bundle.var_f3fea6b3e058e8c0;
        second_score = s_bundle.intermediatepercentage;
        level.tedd_task_progress = int( ( first_score + second_score ) / 2 * level.mastery_rank / 100 );
        function_e9e1e5f03716ae0f();
        end_task();
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0xe96eb7df, Offset: 0x119ce
    // Size: 0x9b, Type: dev
    function function_53803b5023bb6ec7()
    {
        level.is_task_debug = 1;
        
        if ( !isdefined( level.var_fd94a3cfab1edb0 ) )
        {
            return;
        }
        
        s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
        first_score = s_bundle.intermediatepercentage;
        second_score = s_bundle.masterypercentage;
        level.tedd_task_progress = int( ( first_score + second_score ) / 2 * level.mastery_rank / 100 );
        function_e9e1e5f03716ae0f();
        end_task();
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0xe797256a, Offset: 0x11a71
    // Size: 0x3f, Type: dev
    function function_7e0a6d001846e214()
    {
        level.is_task_debug = 1;
        
        if ( !isdefined( level.var_fd94a3cfab1edb0 ) )
        {
            return;
        }
        
        level.tedd_task_progress = level.mastery_rank;
        function_e9e1e5f03716ae0f();
        end_task();
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0x89086e22, Offset: 0x11ab8
    // Size: 0x30, Type: dev
    function function_d93ded9d7272f83f()
    {
        level.is_task_debug = 1;
        
        if ( !isdefined( level.var_fd94a3cfab1edb0 ) )
        {
            return;
        }
        
        level.tedd_task_progress = 0;
        function_e9e1e5f03716ae0f();
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0xb56a2d1c, Offset: 0x11af0
    // Size: 0x94, Type: dev
    function function_68e21db6281edddb()
    {
        level.is_task_debug = 1;
        
        if ( !isdefined( level.var_fd94a3cfab1edb0 ) )
        {
            return;
        }
        
        s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
        first_score = s_bundle.var_f3fea6b3e058e8c0;
        second_score = s_bundle.intermediatepercentage;
        level.tedd_task_progress = int( ( first_score + second_score ) / 2 * level.mastery_rank / 100 );
        function_e9e1e5f03716ae0f();
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0xf7ff66b1, Offset: 0x11b8c
    // Size: 0x94, Type: dev
    function function_cf4089b98b8de89a()
    {
        level.is_task_debug = 1;
        
        if ( !isdefined( level.var_fd94a3cfab1edb0 ) )
        {
            return;
        }
        
        s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
        first_score = s_bundle.intermediatepercentage;
        second_score = s_bundle.masterypercentage;
        level.tedd_task_progress = int( ( first_score + second_score ) / 2 * level.mastery_rank / 100 );
        function_e9e1e5f03716ae0f();
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0xaf273b4c, Offset: 0x11c28
    // Size: 0x38, Type: dev
    function function_419867a668c40d61()
    {
        level.is_task_debug = 1;
        
        if ( !isdefined( level.var_fd94a3cfab1edb0 ) )
        {
            return;
        }
        
        level.tedd_task_progress = level.mastery_rank;
        function_e9e1e5f03716ae0f();
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0x90baaf9e, Offset: 0x11c68
    // Size: 0x5fe, Type: dev
    function function_c4f9bbd2052d6376()
    {
        level endon( #"game_ended" );
        s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
        level.var_2c54a007c62cf905 = [];
        level.var_aacc1b1f10d158ea = [];
        
        foreach ( s_location in level.tedd_locations )
        {
            model = undefined;
            
            if ( isdefined( level.gametypebundle.var_491e3a85ef39e784 ) )
            {
                model = content_manager::spawn_script_model( s_location, level.gametypebundle.var_491e3a85ef39e784, 1, 1 );
            }
            else if ( isdefined( s_bundle.model ) )
            {
                model = content_manager::spawn_script_model( s_location, s_bundle.model, 1, 1 );
            }
            
            model show();
            model utility::function_7c10ea82c1e305b8( "<dev string:x313>", "<dev string:x316>" );
            model utility::function_7c10ea82c1e305b8( "<dev string:x31d>", "<dev string:x32b>" );
            model utility::function_7c10ea82c1e305b8( "<dev string:x334>", "<dev string:x33a>" );
            model utility::function_7c10ea82c1e305b8( "<dev string:x343>", "<dev string:x33a>" );
            model utility::function_7c10ea82c1e305b8( "<dev string:x348>", "<dev string:x34e>" );
            model utility::function_7c10ea82c1e305b8( "<dev string:x353>", "<dev string:x34e>" );
            model utility::function_7c10ea82c1e305b8( "<dev string:x31d>", "<dev string:x35d>" );
            model utility::function_7c10ea82c1e305b8( "<dev string:x362>", "<dev string:x34e>" );
            model utility::function_7c10ea82c1e305b8( "<dev string:x376>", "<dev string:x34e>" );
            model utility::function_7c10ea82c1e305b8( "<dev string:x37e>", "<dev string:x35d>" );
            model function_5c255c52a547a609();
            level.var_2c54a007c62cf905[ level.var_2c54a007c62cf905.size ] = model;
            var_fab2d9ee9393e74f = getentitylessscriptablearray( s_location.script_location, #targetname );
            
            if ( var_fab2d9ee9393e74f.size > 0 )
            {
                if ( isdefined( s_location.script_location ) )
                {
                    zone_location = s_location.script_location;
                    border_location = s_location.script_location;
                    triggerzones = getentarray( zone_location, #targetname );
                    s_bundle = getscriptbundle( level.gamemodebundle.var_5d18653129c81780 );
                    objicon = "<dev string:x387>";
                    
                    if ( isdefined( s_bundle.objectiveicon ) )
                    {
                        objicon = s_bundle.invisicon;
                    }
                    
                    task_loc = undefined;
                    a_waypoint = utility::getstructarray( "<dev string:x39d>", "<dev string:x3ab>" );
                    
                    foreach ( waypoint in a_waypoint )
                    {
                        if ( waypoint.targetname == s_location.targetname )
                        {
                            task_loc = waypoint;
                        }
                    }
                    
                    if ( !isdefined( task_loc ) )
                    {
                        return;
                    }
                    
                    s_location.icon = utility::spawn_model( "<dev string:x3bd>", task_loc.origin, ( 0, 0, 0 ) );
                    s_location.icon.objid = objidpoolmanager::requestobjectiveid();
                    
                    if ( isdefined( s_location.icon.objid ) )
                    {
                        if ( s_location.icon.objid != -1 )
                        {
                            objidpoolmanager::objective_add_objective( s_location.icon.objid, "<dev string:x3c8>", s_location.icon.origin, objicon, "<dev string:x3d0>" );
                            objidpoolmanager::function_de3fb937d4f45f38( s_location.icon.objid, 350, 170 );
                            objective_setbackground( s_location.icon.objid, 1 );
                            objidpoolmanager::objective_showdistance( s_location.icon.objid, 0 );
                        }
                    }
                    
                    foreach ( trigger in triggerzones )
                    {
                        objective_setownerteam( s_location.icon.objid, level.players[ 0 ].team );
                        objective_setprogressteam( s_location.icon.objid, level.players[ 0 ].team );
                        function_ca1cc2938b2b4271( s_location.icon.objid, triggerzones[ 0 ] );
                    }
                    
                    var_fab2d9ee9393e74f = getentitylessscriptablearray( border_location, #targetname );
                    
                    foreach ( var_bfb9424e344026e0 in var_fab2d9ee9393e74f )
                    {
                        var_bfb9424e344026e0 utility::function_7c10ea82c1e305b8( "<dev string:x3db>", "<dev string:x3e5>" );
                    }
                }
            }
        }
    }

    // Namespace teddtasks
    // Params 0
    // Checksum 0x8dc56d2b, Offset: 0x1226e
    // Size: 0x261, Type: dev
    function function_a0442e941059db85()
    {
        level endon( #"game_ended" );
        
        if ( isdefined( level.var_2c54a007c62cf905 ) )
        {
            foreach ( task_model in level.var_2c54a007c62cf905 )
            {
                task_model delete();
            }
        }
        
        foreach ( s_location in level.tedd_locations )
        {
            var_fab2d9ee9393e74f = getentitylessscriptablearray( s_location.script_location, #targetname );
            
            if ( var_fab2d9ee9393e74f.size > 0 )
            {
                triggerzones = getentarray( s_location.script_location, #targetname );
                disable_trigger_zones( triggerzones );
                
                if ( isdefined( s_location.icon ) )
                {
                    if ( isdefined( s_location.icon.objid ) )
                    {
                        function_ca30be9f04600a82( s_location.icon.objid );
                        objidpoolmanager::update_objective_state( s_location.icon.objid, "<dev string:x3ea>" );
                        objidpoolmanager::returnobjectiveid( s_location.icon.objid );
                    }
                    
                    s_location.icon delete();
                }
                
                foreach ( var_bfb9424e344026e0 in var_fab2d9ee9393e74f )
                {
                    var_bfb9424e344026e0 utility::function_7c10ea82c1e305b8( "<dev string:x3db>", "<dev string:x3ef>" );
                }
            }
        }
    }

#/

// Namespace teddtasks
// Params 1
// Checksum 0xf4cd91fd, Offset: 0x124d7
// Size: 0x17
function function_b6bbb9467dc688bc( params )
{
    level.var_6cd59946b7475e48 = 1;
}

