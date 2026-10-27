// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_rocker.gsc  (hash_0106be1f5705ac33.gscc) (size: 8671 Bytes / 0x21df / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7427bd1 (2806152145)
// size ...... 8671 (0x21df)
// includes .. 14  (offset: 0x1f7f)
// strings ... 28  (offset: 0x1fef)
// dev strs .. 8   (offset: 0x217f)
// exports ... 21  (offset: 0x1383)
// cseg ...... 0x248 + 0x113b (0x1383)
// imports ... 77  (offset: 0x16cb)
// animtree1 . 0   (offset: 0x21df)
// animtree2 . 0   (offset: 0x21df)
#using script_16ea1b94f0f381b3;
#using script_5a0c375c28690264;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_rocker_cs;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_sat_hornet_ee_rocker;

// Namespace zm_sat_hornet_ee_rocker
// Params 0, eflags: 0x5
// Checksum 0x6f4a6005, Offset: 0x266
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_ee_rocker", #"zm_quest", &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_ee_rocker
// Params 0, eflags: 0x4
// Checksum 0xf1d24846, Offset: 0x293
// Size: 0x2
function private function_7cf8dacb278a2665()
{
    
}

// Namespace zm_sat_hornet_ee_rocker
// Params 0, eflags: 0x4
// Checksum 0x1d6935c6, Offset: 0x29d
// Size: 0xc4
function private postmain_init()
{
    if ( !getdvarint( @"enable_hornet_sq", 0 ) || !getdvarint( @"hash_8f2f5ea98074bef4", 1 ) )
    {
        return;
    }
    
    zm_sat_hornet_ee_rocker_cs::main();
    level utility::flag_wait( "zm_quest_initialized" );
    level.ee_rocker = zm_quest::get_quest( #"hornet_ee_rocker" );
    zm_quest::register_quest_step( #"hornet_ee_rocker", #"main_logic", &setup_main_logic, &cleanup_main_logic );
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hornet_ee_rocker" );
    function_d635ab966d301088();
    level scriptable::scriptable_adddamagedcallback( &function_add639fd60a28ea9 );
    
    /#
        register_rocker_devgui();
    #/
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_491f820e8df7395f", &function_22936b6485273800 );
}

// Namespace zm_sat_hornet_ee_rocker
// Params 0, eflags: 0x4
// Checksum 0x25df8a63, Offset: 0x369
// Size: 0x1b1
function private function_d635ab966d301088()
{
    a_starts = utility::getstructarray( "rkr_sta", "targetname" );
    paths = [];
    var_41307f4ffadbf90b = [];
    
    foreach ( s_start in a_starts )
    {
        path = [ s_start.origin ];
        node = s_start;
        
        while ( node.target )
        {
            node = utility::getstruct( node.target, "targetname" );
            path[ path.size ] = node.origin;
        }
        
        paths[ s_start.script_noteworthy ] = path;
        var_41307f4ffadbf90b[ s_start.script_noteworthy ] = s_start;
    }
    
    level.ee_rocker.paths = paths;
    level.ee_rocker.var_41307f4ffadbf90b = var_41307f4ffadbf90b;
    path_durations = [];
    path_durations[ "rkr_bt" ] = 96;
    path_durations[ "rkr_lg_in" ] = 72;
    path_durations[ "rkr_lg_out" ] = 80;
    path_durations[ "rkr_sb" ] = 48;
    path_durations[ "rkr_tb" ] = 48;
    path_durations[ "rkr_tors" ] = 22;
    level.ee_rocker.path_durations = path_durations;
    level utility::flag_set( "rkr_pth_setup_complete" );
}

// Namespace zm_sat_hornet_ee_rocker
// Params 2, eflags: 0x4
// Checksum 0x7544a5a3, Offset: 0x522
// Size: 0x27
function private setup_main_logic( b_skipped, b_save_restored )
{
    level callback::add( "on_round_start", &on_round_start );
}

// Namespace zm_sat_hornet_ee_rocker
// Params 2, eflags: 0x4
// Checksum 0x8aee5101, Offset: 0x551
// Size: 0x15
function private cleanup_main_logic( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_hornet_ee_rocker
// Params 1, eflags: 0x4
// Checksum 0xf1b148b9, Offset: 0x56e
// Size: 0x14
function private on_round_start( sparams )
{
    level thread function_9d3414f071c471e2();
}

// Namespace zm_sat_hornet_ee_rocker
// Params 0, eflags: 0xc
// Checksum 0xa12dce6f, Offset: 0x58a
// Size: 0xa1
function private function_9d3414f071c471e2()
{
    self notify( #"hash_c0f203414d825e8c" );
    self endon( #"hash_c0f203414d825e8c" );
    level endon( #"on_round_end" );
    wait 15;
    var_837486f15a0e0e84 = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        path_name = function_a021b083cd8f0139( var_837486f15a0e0e84 );
        var_837486f15a0e0e84[ var_837486f15a0e0e84.size ] = path_name;
        
        /#
            if ( getdvarint( @"hash_9d8a02655bb54490", 0 ) )
            {
                iprintlnbold( path_name );
            }
        #/
        
        function_49a6f3d88d8f4381( path_name );
        var_20b9ddf5990fdb6d = randomintrange( 30, 60 );
        wait var_20b9ddf5990fdb6d;
    }
}

// Namespace zm_sat_hornet_ee_rocker
// Params 1, eflags: 0x4
// Checksum 0x932b00c7, Offset: 0x633
// Size: 0x158
function private function_a021b083cd8f0139( var_a839ec98f324b067 )
{
    var_6210a36ac06c4520 = arraycopy( [ "rkr_lg_in", "rkr_lg_out", "rkr_sb", "rkr_tb" ] );
    var_6210a36ac06c4520 = arrayremove( var_6210a36ac06c4520, var_a839ec98f324b067 );
    var_d9662461fbddd8e6 = utility::getstructarray( "lf_parent", "targetname" );
    
    foreach ( flow in var_d9662461fbddd8e6 )
    {
        if ( flow.script_noteworthy == "westbailey" && flow.iscooled )
        {
            var_6210a36ac06c4520 = arrayremove( var_6210a36ac06c4520, "rkr_tb" );
            continue;
        }
        
        if ( flow.script_noteworthy == "secondbailey" && flow.iscooled )
        {
            var_6210a36ac06c4520 = arrayremove( var_6210a36ac06c4520, "rkr_sb" );
        }
    }
    
    if ( var_6210a36ac06c4520.size > 0 )
    {
        return utility::array_random( var_6210a36ac06c4520 );
    }
    
    return utility::array_random( [ "rkr_lg_in", "rkr_lg_out" ] );
}

// Namespace zm_sat_hornet_ee_rocker
// Params 1
// Checksum 0xb1beec98, Offset: 0x794
// Size: 0x2a1
function function_49a6f3d88d8f4381( path_name )
{
    var_d00b944707343dc9 = level.ee_rocker.paths[ path_name ];
    duration = level.ee_rocker.path_durations[ path_name ];
    s_start = level.ee_rocker.var_41307f4ffadbf90b[ path_name ];
    rock = spawnscriptable( %"zm_sat_hornet_rock", s_start.origin, s_start.angles );
    function_df014fab06de0500( rock );
    rock.mover = utility::spawn_model( %"tag_origin", s_start.origin, s_start.angles );
    rock utility::scriptable_setparententity( rock.mover );
    
    if ( !isdefined( level.ee_rocker.platform ) )
    {
        level.ee_rocker.platform = getent( "rky_pc_bm", #targetname );
    }
    
    if ( level.ee_rocker.platform && path_name == "rkr_bt" )
    {
        level.ee_rocker.platform.origin = s_start.origin;
        level.ee_rocker.platform.angles = s_start.angles;
        level.ee_rocker.platform unlink();
        level.ee_rocker.platform.current_link = rock.mover;
        level.ee_rocker.platform linkto( rock.mover );
    }
    
    var_2fc917213ef7c7e0 = utility::array_random( [ "type3", "type4" ] );
    rock utility::function_32b24db3127bff40( "model", var_2fc917213ef7c7e0 );
    rock.mover thread utility::play_loop_sound_on_entity( "evt_neigh_race_flame_lp" );
    rock.mover thread utility::function_2159dd4196ff4b81( var_d00b944707343dc9, duration, 1, 1 );
    level thread function_1d8571b50c4cd243( rock );
    
    if ( path_name == "rkr_tb" )
    {
        level thread function_af0fa28d8f31f1c5( rock, "lava_flow_started_cooling_westbailey" );
        return;
    }
    
    if ( path_name == "rkr_sb" )
    {
        level thread function_af0fa28d8f31f1c5( rock, "lava_flow_started_cooling_secondbailey" );
    }
}

// Namespace zm_sat_hornet_ee_rocker
// Params 1, eflags: 0x4
// Checksum 0xb29e6c4e, Offset: 0xa3d
// Size: 0x12a
function private function_1d8571b50c4cd243( rock )
{
    rock.mover endon( #"deleted" );
    rock.mover endon( #"hash_e4dcebe07727829e" );
    rock.mover waittill( #"stop_curve" );
    
    if ( level.ee_rocker.platform && level.ee_rocker.platform.current_link == rock.mover )
    {
        level.ee_rocker.platform unlink();
        level.ee_rocker.platform.origin += ( 0, 0, -100 );
        function_dfc684adac52f9e9( rock );
    }
    
    rock.mover thread utility::stop_loop_sound_on_entity( "evt_neigh_race_flame_lp" );
    rock.mover delete();
    rock freescriptable();
}

// Namespace zm_sat_hornet_ee_rocker
// Params 2, eflags: 0x4
// Checksum 0xdab270a1, Offset: 0xb6f
// Size: 0xf3
function private function_af0fa28d8f31f1c5( rock, var_75c20b9bed3ea249 )
{
    rock.mover endon( #"death" );
    rock.mover endon( #"deleted" );
    level waittill( var_75c20b9bed3ea249 );
    wait 0.75;
    rock.mover notify( #"hash_e4dcebe07727829e" );
    rock.mover notify( #"stop_curve" );
    rock.mover moveto( rock.mover.origin + ( 0, 0, -100 ), 5 );
    rock.mover waittill( #"movedone" );
    rock.mover utility::stop_loop_sound_on_entity( "evt_neigh_race_flame_lp" );
    rock.mover delete();
    rock freescriptable();
}

// Namespace zm_sat_hornet_ee_rocker
// Params 1, eflags: 0x4
// Checksum 0x44ab756d, Offset: 0xc6a
// Size: 0xc0
function private function_dfc684adac52f9e9( rock )
{
    a_players = getplayersinradius( rock.origin, 80 );
    
    foreach ( player in a_players )
    {
        dir = vectornormalize( player.origin - rock.origin );
        player knockback( dir, 300 );
    }
}

// Namespace zm_sat_hornet_ee_rocker
// Params 1, eflags: 0x4
// Checksum 0x1688e549, Offset: 0xd32
// Size: 0x11e
function private function_df014fab06de0500( rock )
{
    rock.tier = utility::random_weighted( [ 0, 1, 2, 3 ], [ 85, 10, 4, 1 ] );
    
    switch ( rock.tier )
    {
        case 3:
            rock.health = 8000;
            rock.num_items = 4;
            break;
        case 2:
            rock.health = 4000;
            rock.num_items = 3;
            break;
        case 1:
            rock.health = 2000;
            rock.num_items = 3;
            break;
        case 0:
        default:
            rock.health = 500;
            rock.num_items = 2;
            break;
    }
}

// Namespace zm_sat_hornet_ee_rocker
// Params 3
// Checksum 0xe3e01d5e, Offset: 0xe58
// Size: 0xb6
function function_e5b4858e27850ba9( path_name, prop, s_start_override )
{
    var_d00b944707343dc9 = level.ee_rocker.paths[ path_name ];
    duration = level.ee_rocker.path_durations[ path_name ];
    s_start = s_start_override ?? level.ee_rocker.var_41307f4ffadbf90b[ path_name ];
    prop = utility::spawn_model( prop, s_start.origin, s_start.angles );
    prop thread utility::function_2159dd4196ff4b81( var_d00b944707343dc9, duration, 1, 1 );
    return prop;
}

// Namespace zm_sat_hornet_ee_rocker
// Params 11, eflags: 0x4
// Checksum 0x6cf57730, Offset: 0xf17
// Size: 0x212
function private function_add639fd60a28ea9( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isdefined( instance.type ) || getxhashasset( instance.type ) != %"zm_sat_hornet_rock" )
    {
        return;
    }
    
    player_attacker = isplayer( eattacker ) ? eattacker : eattacker.owner;
    
    if ( !isplayer( player_attacker ) )
    {
        return;
    }
    
    instance.health -= idamage;
    player_attacker damagefeedback::updatehitmarker( "standard", instance.health <= 0, 0, 0, undefined );
    
    if ( !instance.b_destroyed && instance.health <= 0 )
    {
        instance.b_destroyed = 1;
        instance utility::function_32b24db3127bff40( "fx", "dest" );
        playsoundatpos( instance.origin, "evt_trail_impact" );
        instance.mover notify( #"stop_curve" );
        function_bdbf59a6b31f81f9( instance, player_attacker );
        
        if ( randomfloat( 1 ) <= 0.5 )
        {
            n_time = gettime();
            
            if ( !isdefined( player_attacker.var_748895d06ad9265c ) || n_time - player_attacker.var_748895d06ad9265c >= 120000 )
            {
                player_attacker.var_748895d06ad9265c = n_time;
                player_attacker thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hesd2_loot_geode_collect_loot", #"bc_flavor_player_positive" );
            }
        }
        
        if ( isfunction( level.ee_rocker.var_a01e8692e9c5d076 ) )
        {
            [[ level.ee_rocker.var_a01e8692e9c5d076 ]]( instance, player_attacker );
        }
    }
}

// Namespace zm_sat_hornet_ee_rocker
// Params 2, eflags: 0x4
// Checksum 0x4b124156, Offset: 0x1131
// Size: 0x13c
function private function_bdbf59a6b31f81f9( rock, player )
{
    v_destination = namespace_923cf551235ca152::function_697b336296162337( rock.origin, player.origin );
    
    if ( distancesquared( v_destination, player.origin ) > 2500 )
    {
        v_destination = ( v_destination + player.origin ) / 2;
    }
    
    v_ground_trace = getgroundposition( v_destination + ( 0, 0, 48 ), 5 );
    rock_origin = rock.origin + ( 0, 0, 48 );
    spawn_options = common_item::function_f5dfaa3bbdf99a33( v_ground_trace, rock_origin );
    spawn_options.var_90cdc5dbcd319e5d = 1;
    spawn_options.var_9161cf0784b6951d = 0;
    spawn_options.var_d72f168a0f299753 = 2;
    spawn_options.var_d7522c8a0f500f6d = 4;
    spawn_options.var_789c456dda9c8572 = rock_origin;
    var_e9564cd22ae43276 = zm_round_reward_bundle::function_fbc9326d735aa670( "zm_round_reward_bundle_loot_geode_rewards", "Default" );
    loot = common_item::function_38cde6a6acb68ea6( var_e9564cd22ae43276, rock.num_items, spawn_options );
}

/#

    // Namespace zm_sat_hornet_ee_rocker
    // Params 0, eflags: 0x4
    // Checksum 0x370beaa3, Offset: 0x1275
    // Size: 0x4c, Type: dev
    function private register_rocker_devgui()
    {
        zm_quest::function_bc99f123a684344f( #"hornet_ee_rocker" );
        devgui::add_devgui_func( "<dev string:x24>", "<dev string:x36>", &debug_spawn_rocks, 1 );
        devgui::add_devgui_func( "<dev string:x3f>", "<dev string:x5a>", &function_22936b6485273800, 1 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_hornet_ee_rocker
    // Params 0, eflags: 0x4
    // Checksum 0x1f610c5c, Offset: 0x12c9
    // Size: 0x9a, Type: dev
    function private debug_spawn_rocks()
    {
        foreach ( path_name in [ "<dev string:x66>", "<dev string:x70>", "<dev string:x7b>", "<dev string:x82>" ] )
        {
            function_49a6f3d88d8f4381( path_name );
        }
    }

#/

// Namespace zm_sat_hornet_ee_rocker
// Params 1, eflags: 0x4
// Checksum 0x4f429be1, Offset: 0x136b
// Size: 0x18
function private function_22936b6485273800( params )
{
    function_49a6f3d88d8f4381( "rkr_bt" );
}

