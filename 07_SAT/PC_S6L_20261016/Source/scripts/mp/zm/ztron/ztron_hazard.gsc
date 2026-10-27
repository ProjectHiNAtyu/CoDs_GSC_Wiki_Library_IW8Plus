// scripts\mp\zm\ztron\ztron_hazard.gsc  (hash_489951dd86bc3532.gscc) (size: 9075 Bytes / 0x2373 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x88d0aec5 (2295377605)
// size ...... 9075 (0x2373)
// includes .. 24  (offset: 0x21bb)
// strings ... 5   (offset: 0x227b)
// dev strs .. 13  (offset: 0x22c7)
// exports ... 35  (offset: 0x16cb)
// cseg ...... 0xc4 + 0x1607 (0x16cb)
// imports ... 43  (offset: 0x1c43)
// animtree1 . 0   (offset: 0x2373)
// animtree2 . 0   (offset: 0x2373)
#using script_1a7a046d8c150ec;
#using script_25b108053631cfea;
#using script_3047310ffabb66fc;
#using script_35a342a0af11a9c1;
#using script_3f1481aeb31c4b53;
#using script_4bf17c7c52d3ed18;
#using script_5155c7ada2c7988a;
#using script_549039d84ee7a683;
#using script_5c83e389220d3e8d;
#using script_6386400ab764805e;
#using script_7089e90608d33a92;
#using script_73cee2c0b86c6204;
#using script_7574fdd29cd7dec6;
#using script_765e03d786b4ec4;
#using script_78eb0f055d8c6ae;
#using script_79d6ac13cb9dfe42;
#using script_9d7b1b99a878301;
#using script_cc7edad3d14d7bf;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\weapons;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard;

// Namespace ztron_hazard
// Params 0, eflags: 0x5
// Checksum 0xc1c1d7e6, Offset: 0xe2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ztron_hazards", undefined, undefined, &init );
}

// Namespace ztron_hazard
// Params 0
// Checksum 0x2f9f1d10, Offset: 0x103
// Size: 0x24
function init()
{
    level.var_626cd6778f06ecd8 = spawnstruct();
    level.var_626cd6778f06ecd8.typecallbacks = [];
}

// Namespace ztron_hazard
// Params 3
// Checksum 0xf2182264, Offset: 0x12f
// Size: 0xa0
function function_6f661fac5fd31f1( type, funcname, func )
{
    assert( isdefined( level.var_626cd6778f06ecd8.typecallbacks ) );
    assert( !isdefined( level.var_626cd6778f06ecd8.typecallbacks[ type ][ funcname ] ) );
    typecallbacks = level.var_626cd6778f06ecd8.typecallbacks[ type ] ?? [];
    typecallbacks[ funcname ] = func;
    level.var_626cd6778f06ecd8.typecallbacks[ type ] = typecallbacks;
}

// Namespace ztron_hazard
// Params 4, eflags: 0x40 variadic
// Checksum 0x86e32df6, Offset: 0x1d7
// Size: 0x8f
function function_ed33fea23f0d8109( type, funcname, ... )
{
    if ( isdefined( level.var_626cd6778f06ecd8.typecallbacks[ type ][ funcname ] ) )
    {
        return [[ level.var_626cd6778f06ecd8.typecallbacks[ type ][ funcname ] ]]( flat_args( vararg, varargcount ) );
    }
    
    assertmsg( "<dev string:x24>" + getxhashsourcename( type ) + "<dev string:x32>" + getxhashsourcename( funcname ) + "<dev string:x4f>" );
}

// Namespace ztron_hazard
// Params 2
// Checksum 0x48b79b39, Offset: 0x26e
// Size: 0xc7
function function_ff91beb643f81d0b( traps, page )
{
    throttle = 5;
    
    foreach ( trap in traps )
    {
        type = getxhash( trap.script_noteworthy );
        function_ed33fea23f0d8109( type, #"create", trap, page );
        throttle--;
        
        if ( throttle <= 0 )
        {
            throttle = 5;
            waitframe();
        }
    }
}

// Namespace ztron_hazard
// Params 3
// Checksum 0x187ddc9f, Offset: 0x33d
// Size: 0x6f
function function_4512b7715789e4cf( strid, value, forcereset = 0 )
{
    weapons::function_4512b7715789e4cf( strid, value );
    
    if ( value < 1 )
    {
        self notify( #"slowed_by_hazard" );
    }
    
    if ( forcereset )
    {
        self.ztron.speedoverride = undefined;
        self notify( #"force_reset_speed" );
    }
    
    ztron_player_utility::updateplayerspeed();
}

// Namespace ztron_hazard
// Params 2
// Checksum 0x275b8297, Offset: 0x3b4
// Size: 0x39
function function_986fc44dada307f4( strid, forceupdate = 0 )
{
    weapons::function_986fc44dada307f4( strid );
    ztron_player_utility::updateplayerspeed();
    
    if ( forceupdate )
    {
        weapons::updatemovespeedscale();
    }
}

// Namespace ztron_hazard
// Params 1
// Checksum 0x18d338a3, Offset: 0x3f5
// Size: 0x14
function function_8131aea7eb196354( strid )
{
    return weapons::function_8131aea7eb196354( strid );
}

// Namespace ztron_hazard
// Params 1
// Checksum 0xd9cb2df0, Offset: 0x412
// Size: 0xc6
function function_4d643b159a80c647( roundbase = 0 )
{
    self notify( #"hash_e12ad1c619ed8c9c" );
    self endon( #"hash_e12ad1c619ed8c9c" );
    self endon( #"death", #"destroy_hazard" );
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        if ( roundbase )
        {
            level utility::waittill_any( "game_reset", "arena_deactivated", "arena_round_leaving" );
        }
        else
        {
            level utility::waittill_any( "game_reset", "arena_deactivated" );
        }
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 3 )
    {
        level utility::waittill_any( "game_reset", "deactivate_bonus_room" );
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        level utility::waittill_any( "game_reset", "slayer_round_finished" );
    }
    
    self notify( #"destroy_hazard" );
}

/#

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0xe2c03910, Offset: 0x4e0
    // Size: 0x4d, Type: dev
    function debug_spawn_barrel( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, 0 );
        ztron_hazard_barrel::hazard_spawn_barrel( "<dev string:x5c>", undefined, origin );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x252dd43b, Offset: 0x535
    // Size: 0x70, Type: dev
    function debug_spawn_pole( params )
    {
        trap = spawnstruct();
        trap.origin = level.players[ 0 ].origin + ( 100, 100, 0 );
        trap.angles = ( 0, 0, 0 );
        ztron_hazard_electric_pole::function_5af93e037365b05e( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x9dd6e76d, Offset: 0x5ad
    // Size: 0x9f, Type: dev
    function function_675c8a21648c7594( params )
    {
        origin = level.players[ 0 ].origin + ( 200, 200, 0 );
        trap = spawnstruct();
        trap.model = "<dev string:x83>";
        trap.script_parameters = "<dev string:xa6>";
        trap.origin = origin;
        trap.angles = ( 0, 0, 180 );
        namespace_47c07e1713f6efbc::function_efa2782f3fc50aa( trap, undefined );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x5d231ce6, Offset: 0x654
    // Size: 0x57, Type: dev
    function debug_spawn_fireball( params )
    {
        trap = spawnstruct();
        trap.origin = level.players[ 0 ].origin + ( 100, 100, 0 );
        ztron_hazard_fireball::function_f8b3e1f72186d094( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0xf8269514, Offset: 0x6b3
    // Size: 0x68, Type: dev
    function function_980d15ef3eef7806( params )
    {
        trap = spawnstruct();
        trap.origin = level.players[ 0 ].origin + ( 100, 100, 0 );
        trap.script_parameters = "<dev string:xb8>";
        ztron_hazard_fireball::function_f8b3e1f72186d094( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x3c9afbdd, Offset: 0x723
    // Size: 0x8d, Type: dev
    function debug_spawn_dragonhead( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, 0 );
        trap = spawnstruct();
        trap.model = "<dev string:x83>";
        trap.origin = origin;
        trap.angles = ( 0, 0, 0 );
        ztron_hazard_dragonhead::function_8f80fc5b1a48cb85( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x80e10401, Offset: 0x7b8
    // Size: 0x7c, Type: dev
    function debug_spawn_pungi( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, 0 );
        trap = spawnstruct();
        trap.origin = origin;
        trap.angles = ( 0, 0, 0 );
        ztron_hazard_pungi::function_80b1e0915bf7e6c3( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0xc49062bb, Offset: 0x83c
    // Size: 0x1d3, Type: dev
    function debug_spawn_lawn_mower( params )
    {
        origin = level.players[ 0 ].origin + ( 200, 200, 0 );
        trap = spawnstruct();
        trap.script_parameters = "<dev string:xc0>";
        trap.origin = origin;
        trap.angles = ( 0, 0, 0 );
        trap.origin = origin;
        trap.var_88163dd40ed18fac = spawnstruct();
        trap.var_88163dd40ed18fac.origin = origin + ( 300, 0, 0 );
        trap.var_88163dd40ed18fac.var_88163dd40ed18fac = spawnstruct();
        trap.var_88163dd40ed18fac.var_88163dd40ed18fac.origin = origin + ( 0, 300, 0 );
        ztron_hazard_lawn_mower::create_lawn_mower( trap );
        var_3bb6c11a7045d92d = spawnstruct();
        origin = level.players[ 0 ].origin + ( -200, -200, 0 );
        var_3bb6c11a7045d92d.script_parameters = "<dev string:xf3>";
        var_3bb6c11a7045d92d.origin = origin;
        var_3bb6c11a7045d92d.angles = ( 0, 0, 0 );
        var_3bb6c11a7045d92d.origin = origin;
        var_3bb6c11a7045d92d.var_88163dd40ed18fac = spawnstruct();
        var_3bb6c11a7045d92d.var_88163dd40ed18fac.origin = origin + ( 300, 0, 0 );
        ztron_hazard_lawn_mower::create_lawn_mower( var_3bb6c11a7045d92d );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x209f5a98, Offset: 0xa17
    // Size: 0x6f, Type: dev
    function debug_spawn_flogger( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, 100 );
        ztron_hazard_flogger::function_f91630ded89ad41a( { #angles:level.players[ 0 ].angles, #origin:origin } );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x1ea66507, Offset: 0xa8e
    // Size: 0x109, Type: dev
    function function_71e123b58aaef93( params )
    {
        origin1 = level.players[ 0 ].origin + ( 100, 100, 0 );
        var_3bb6be1a7045d294 = spawnstruct();
        var_3bb6be1a7045d294.origin = origin1;
        var_3bb6be1a7045d294.angles = ( 0, 0, 0 );
        var_3bb6be1a7045d294.script_parameters = "<dev string:xf7>";
        namespace_8849960825a32a32::function_c7756360860ab12d( var_3bb6be1a7045d294 );
        origin2 = level.players[ 0 ].origin + ( -100, 100, 0 );
        var_3bb6c11a7045d92d = spawnstruct();
        var_3bb6c11a7045d92d.origin = origin2;
        var_3bb6c11a7045d92d.angles = ( 0, 0, 0 );
        var_3bb6c11a7045d92d.script_parameters = "<dev string:x10f>";
        namespace_8849960825a32a32::function_c7756360860ab12d( var_3bb6c11a7045d92d );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x1c9a4edb, Offset: 0xb9f
    // Size: 0x10d, Type: dev
    function debug_spawn_specter( params )
    {
        origin = level.players[ 0 ].origin + ( 0, 100, 0 );
        trap = spawnstruct();
        trap.script_parameters = "<dev string:xf3>";
        trap.origin = origin;
        trap.angles = ( 0, 0, 0 );
        trap.var_88163dd40ed18fac = spawnstruct();
        trap.var_88163dd40ed18fac.origin = origin + ( 300, 0, 0 );
        trap.var_88163dd40ed18fac.var_88163dd40ed18fac = spawnstruct();
        trap.var_88163dd40ed18fac.var_88163dd40ed18fac.origin = origin + ( 0, 300, 0 );
        ztron_hazard_specter::create_specter( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x2ed5ef18, Offset: 0xcb4
    // Size: 0x7c, Type: dev
    function function_aec715fe33ce0ab5( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, -50 );
        trap = spawnstruct();
        trap.origin = origin;
        trap.angles = ( 0, 0, 0 );
        namespace_356f861e48353864::function_89f0d9a5a07b89db( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x67d7ec0e, Offset: 0xd38
    // Size: 0x7c, Type: dev
    function debug_spawn_lava_pool( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, 50 );
        trap = spawnstruct();
        trap.origin = origin;
        trap.angles = ( 0, 0, 0 );
        namespace_301c1c47ac7cc7e6::function_ce8c749c8a5098a( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0xa1077015, Offset: 0xdbc
    // Size: 0x1b, Type: dev
    function function_bae82969d2609056( params )
    {
        level notify( #"lava_pool_burst" );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x96d9f277, Offset: 0xddf
    // Size: 0x8d, Type: dev
    function debug_spawn_enemy_spawner( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, 0 );
        trap = spawnstruct();
        trap.origin = origin;
        trap.angles = ( 0, 0, 0 );
        trap.script_parameters = "<dev string:x129>";
        ztron_hazard_enemy_spawner::create_enemy_spawner( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x71a6b393, Offset: 0xe74
    // Size: 0x118, Type: dev
    function debug_spawn_moving_platform( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, 20 );
        trap = spawnstruct();
        trap.model = "<dev string:x5c>";
        trap.origin = origin;
        trap.angles = ( 0, 0, 180 );
        trap.var_c6db5c05a5f1e16e = 5;
        trap.var_9b703e3ad83159ff = 10;
        trap.moving_mode = 0;
        new_target = spawnstruct();
        new_target.origin = origin + ( 300, 0, 0 );
        new_target.var_c6db5c05a5f1e16e = 5;
        new_target.var_9b703e3ad83159ff = 10;
        trap.next_node = new_target;
        new_target.pre_node = trap;
        ztron_hazard_moving_platform::function_5aff0f6748b42c3f( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0xba0e6687, Offset: 0xf94
    // Size: 0x120, Type: dev
    function debug_spawn_rats_horde( params )
    {
        origin = level.players[ 0 ].origin + ( 0, 100, 0 );
        trap = spawnstruct();
        trap.script_parameters = "<dev string:xf3>";
        trap.origin = origin;
        trap.angles = ( 0, 0, 0 );
        trap.var_88163dd40ed18fac = spawnstruct();
        trap.var_88163dd40ed18fac.origin = origin + ( 300, 0, 0 );
        trap.var_88163dd40ed18fac.var_88163dd40ed18fac = spawnstruct();
        trap.var_88163dd40ed18fac.var_88163dd40ed18fac.origin = origin + ( 0, 300, 0 );
        function_ed33fea23f0d8109( #"rats_horde", #"create", trap, 0 );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x1236f816, Offset: 0x10bc
    // Size: 0x99, Type: dev
    function debug_spawn_crate( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, 0 );
        origin = ztron_util::function_3fe38741460a4a49( origin );
        trap = spawnstruct();
        trap.origin = origin;
        trap.angles = ( 0, 0, 0 );
        function_ed33fea23f0d8109( #"crate", #"create", trap, 0 );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x934e975b, Offset: 0x115d
    // Size: 0xbc, Type: dev
    function function_ed976f621141163b( params )
    {
        player = level.players[ 0 ];
        angles = player getplayerangles();
        forward = anglestoforward( angles );
        origin = player.origin + forward * 100;
        origin = ztron_util::function_3fe38741460a4a49( origin );
        trap = spawnstruct();
        trap.origin = origin;
        trap.angles = ( 0, 0, 0 );
        function_ed33fea23f0d8109( #"fuel_tank", #"create", trap, 0 );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x34525530, Offset: 0x1221
    // Size: 0xbf, Type: dev
    function debug_spawn_conveyor_belt( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, 0 );
        origin = ztron_util::function_3fe38741460a4a49( origin ) + ( 0, 0, 50 );
        trap = spawnstruct();
        trap.origin = origin;
        trap.angles = ( 1, 0, 0 );
        trap.target_point = origin + ( 800, 0, 0 );
        trap.moving_speed = 100;
        ztron_hazard_conveyor_belt::function_a514f11da84ae618( trap, 0 );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0xe0087466, Offset: 0x12e8
    // Size: 0x138, Type: dev
    function debug_spawn_saw_blade( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, 20 );
        trap = spawnstruct();
        trap.model = "<dev string:x13a>";
        trap.origin = origin;
        trap.angles = ( 0, 180, 0 );
        trap.var_c6db5c05a5f1e16e = 2;
        trap.var_9b703e3ad83159ff = 3;
        trap.moving_mode = 1;
        trap.need_moving = 1;
        new_target = spawnstruct();
        new_target.origin = origin + ( 0, 400, 0 );
        new_target.var_c6db5c05a5f1e16e = 2;
        new_target.var_9b703e3ad83159ff = 3;
        trap.next_node = new_target;
        new_target.pre_node = trap;
        trap.reverse_callback = &ztron_hazard_saw_blade::function_afd2d792191eff6e;
        ztron_hazard_saw_blade::function_4deda08a92c5d1c7( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x7496c044, Offset: 0x1428
    // Size: 0x70, Type: dev
    function debug_spawn_aether_slate( params )
    {
        trap = spawnstruct();
        trap.origin = level.players[ 0 ].origin + ( 50, 50, 0 );
        trap.angles = ( 0, 0, 0 );
        ztron_hazard_aether_slate::function_78680fa5375dd7c0( trap );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x78c3fe25, Offset: 0x14a0
    // Size: 0x99, Type: dev
    function debug_spawn_bump_mushroom( params )
    {
        origin = level.players[ 0 ].origin + ( 100, 100, 0 );
        origin = ztron_util::function_3fe38741460a4a49( origin );
        trap = spawnstruct();
        trap.origin = origin;
        trap.angles = ( 0, 0, 0 );
        function_ed33fea23f0d8109( #"bump_mushroom", #"create", trap, 0 );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0x3d451eaa, Offset: 0x1541
    // Size: 0xe5, Type: dev
    function debug_spawn_tornado( params )
    {
        points = [];
        
        if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
        {
            spots = level.ztron.active_arena.lootspots;
            
            foreach ( spot in spots )
            {
                points[ points.size ] = spot.origin;
            }
        }
        
        ztron_hazard_tornado::create_tornado( level.players[ 0 ].origin, points );
    }

    // Namespace ztron_hazard
    // Params 1
    // Checksum 0xaf68873b, Offset: 0x162e
    // Size: 0x9d, Type: dev
    function debug_spawn_snowman( params )
    {
        player = level.players[ 0 ];
        forward = anglestoforward( player.angles );
        trap = spawnstruct();
        trap.origin = player.origin + forward * 100;
        trap.angles = player.angles;
        function_ed33fea23f0d8109( #"snowman", #"create", trap, 0 );
    }

#/
